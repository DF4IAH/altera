//////////////////////////////////////////////////////////////////
//                                                              //
//  Wishbone Slave to external SRAM Bridge                      //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Converts wishbone read and write accesses to the externally //
//  connected SRAM.                                             //
//                                                              //
//  Author(s):                                                  //
//      - Ulrich Habel, espero7757 at gmx.net                   //
//                                                              //
//////////////////////////////////////////////////////////////////
//                                                              //
// Copyright (C) 2015 Authors and OPENCORES.ORG                 //
//                                                              //
// This source file may be used and distributed without         //
// restriction provided that this copyright statement is not    //
// removed from the file and that any derivative work contains  //
// the original copyright notice and the associated disclaimer. //
//                                                              //
// This source file is free software; you can redistribute it   //
// and/or modify it under the terms of the GNU Lesser General   //
// Public License as published by the Free Software Foundation; //
// either version 2.1 of the License, or (at your option) any   //
// later version.                                               //
//                                                              //
// This source is distributed in the hope that it will be       //
// useful, but WITHOUT ANY WARRANTY; without even the implied   //
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //
// PURPOSE.  See the GNU Lesser General Public License for more //
// details.                                                     //
//                                                              //
// You should have received a copy of the GNU Lesser General    //
// Public License along with this source; if not, download it   //
// from http://www.opencores.org/lgpl.shtml                     //
//                                                              //
//////////////////////////////////////////////////////////////////
`include "../tb/global_defines.vh"

module wb_sram_bridge #(
parameter WB_DWIDTH   = 32,
parameter WB_SWIDTH   = 4,
parameter SRAM_ADR_L  = 21,
parameter SRAM_DATA_L = 8
)(
input                           i_sys_rst,
input                           i_wb_clk,
input                           i_ram_clk,

//input                         i_mem_ctrl,  // 0=128MB, 1=32MB

// Wishbone Bus
input       [31:0]              i_wb_adr,
input       [WB_SWIDTH-1:0]     i_wb_sel,
input                           i_wb_we,
output reg  [WB_DWIDTH-1:0]     o_wb_dat            = 'd0,
input       [WB_DWIDTH-1:0]     i_wb_dat,
input                           i_wb_cyc,
input                           i_wb_stb,
output                          o_wb_ack,
output                          o_wb_err,

// SRAM Interface
output reg  [3:0]               o_sram_cs           = 'd0,      // ChipSelect
output reg                      o_sram_read         = 'd0,      // Read
output reg                      o_sram_write        = 'd0,      // Write
output reg  [SRAM_ADR_L-1:0]    o_sram_addr         = 'd0,      // Addressbus
inout       [SRAM_DATA_L-1:0]   io_sram_data                    // Databus

);


// SRAM signals
reg  [7:0]              io_sram_data_l              = 'd0;
reg                     io_sram_data_e              = 'd0;

// Wishbone signals
reg                     ready_r                     = 'd0;
reg                     write_final_r               = 'd0;
reg                     read_final_r                = 'd0;
reg                     write_request_r             = 'd0;
reg                     read_request_r              = 'd0;
reg                     wb_dat_out_r                = 'd0;
wire                    write_request;
wire                    read_request;


// Wishbone async signals
assign write_request                                = i_wb_stb &&  i_wb_we && ready_r;
assign read_request                                 = i_wb_stb && !i_wb_we && ready_r;


// ------------------------------------------------------
// Syncing
// ------------------------------------------------------
always @( posedge i_wb_clk )
    if ( i_sys_rst )  // reset has to be synced
        begin
        write_request_r <= 'd0;
        read_request_r  <= 'd0;
        o_wb_dat        <= 'd0;
        end
    else
        begin
        write_request_r <= write_request;
        read_request_r  <= read_request;
        o_wb_dat        <= wb_dat_out_r;
        end


// ------------------------------------------------------
// Wishbone FSM
// ------------------------------------------------------
localparam WB_FSM_INIT_STATE    = 2'd0;
localparam WB_FSM_READY_STATE   = 2'd1;
localparam WB_FSM_WRITE_STATE   = 2'd2;
localparam WB_FSM_READ_STATE    = 2'd3;
reg  [1:0]              wb_state                    = WB_FSM_READY_STATE;
reg  [SRAM_ADR_L-1:0]   wb_adr_r                    = 'd0;
reg  [WB_DWIDTH-1:0]    wb_dat_r                    = 'd0;
reg  [WB_SWIDTH-1:0]    wb_sel_r                    = 'd0;

always @( posedge i_wb_clk )
    if ( i_sys_rst )
        begin
        wb_state            <= WB_FSM_INIT_STATE;
        ready_r             <= 'd0;
        wb_adr_r            <= 'd0;
        wb_dat_r            <= 'd0;
        wb_sel_r            <= 'd0;
        end
    else
        case ( wb_state )
            WB_FSM_INIT_STATE:
                begin
                wb_state            <= WB_FSM_READY_STATE;
                ready_r             <= 'd1;
                wb_adr_r            <= 'd0;
                wb_dat_r            <= 'd0;
                wb_sel_r            <= 'd0;
                end

            WB_FSM_READY_STATE:
                if ( write_request_r )
                    begin
                    wb_state        <= WB_FSM_WRITE_STATE;
                    ready_r         <= 'd0;				
                    wb_adr_r        <= i_wb_adr[SRAM_ADR_L-1:0];      // latch data to avoid wait state "WSS"
                    wb_dat_r        <= i_wb_dat;
                    wb_sel_r        <= i_wb_sel;
                    end
                else if ( read_request_r )
                    begin
                    wb_state        <= WB_FSM_READ_STATE;
                    ready_r         <= 'd0;
                    end

            WB_FSM_WRITE_STATE:
                if ( write_final_r && !i_wb_stb )
                    begin
                    wb_state        <= WB_FSM_READY_STATE;
                    ready_r         <= 'd1;
                    end

            WB_FSM_READ_STATE:
                if ( read_final_r && !i_wb_stb )
                    begin
                    wb_state        <= WB_FSM_READY_STATE;
                    ready_r         <= 'd1;
                    end
        endcase


// ------------------------------------------------------
// External SRAM FSM
// ------------------------------------------------------
localparam SRAM_CYC_CTR_VALUE           = 'd4;
localparam SRAM_FSM_INIT_STATE          = 4'd0;
localparam SRAM_FSM_READY_STATE         = 4'd1;
localparam SRAM_FSM_WRITE_BYTE_SU_STATE = 4'd2;
localparam SRAM_FSM_WRITE_BYTE_HD_STATE = 4'd3;
localparam SRAM_FSM_WRITE_LOOP_STATE    = 4'd4;
localparam SRAM_FSM_WRITE_END_STATE     = 4'd5;
localparam SRAM_FSM_READ_BYTE_SU_STATE  = 4'd6;
localparam SRAM_FSM_READ_BYTE_HD_STATE  = 4'd7;
localparam SRAM_FSM_READ_LOOP_STATE     = 4'd8;
localparam SRAM_FSM_READ_END_STATE      = 4'd9;
reg  [3:0]              sram_state      = SRAM_FSM_INIT_STATE;
reg  [SRAM_ADR_L-1:0]   ram_adr_r       = 'd0;
reg  [WB_DWIDTH-1:0]    ram_dat_r       = 'd0;
reg  [WB_SWIDTH-1:0]    ram_sel_r       = 'd0;
reg  [1:0]              ram_read_pos    = 'd0;
reg  [2:0]              ram_cyc_ctr     = 'd0;

always @( posedge i_ram_clk )
    if ( i_sys_rst )
        begin
        sram_state              <= SRAM_FSM_INIT_STATE;
        wb_dat_out_r            <= 'd0;
        o_sram_cs               <= 4'b0000;
        o_sram_read             <= 'd0;
		o_sram_write            <= 'd0;
		o_sram_addr             <= 'd0;
        io_sram_data_l          <= 'd0;
        io_sram_data_e          <= 'd0;
        write_final_r           <= 'd0;
        read_final_r            <= 'd0;
		ram_adr_r               <= 'd0;
		ram_sel_r               <= 'd0;
		ram_dat_r               <= 'd0;
        ram_cyc_ctr             <= 'd0;
		end
    else
        case ( sram_state )
            SRAM_FSM_INIT_STATE:
                begin
                sram_state              <= SRAM_FSM_READY_STATE;
                wb_dat_out_r            <= 'd0;
                o_sram_cs		        <= 4'b0000;
                o_sram_read             <= 'd0;
                o_sram_write	        <= 'd0;
                o_sram_addr             <= 'd0;
                io_sram_data_l          <= 'd0;
                io_sram_data_e          <= 'd0;
                write_final_r           <= 'd0;
                read_final_r            <= 'd0;
                ram_adr_r               <= 'd0;
                ram_sel_r               <= 'd0;
                ram_read_pos            <= 'd0;
                ram_dat_r               <= 'd0;
                ram_cyc_ctr             <= 'd0;
                end
				
            SRAM_FSM_READY_STATE:
                if ( wb_state == WB_FSM_WRITE_STATE )
                    begin
                    if ( wb_sel_r[0] )
                        begin
                        // data w/o shift available
                        sram_state 	    <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs       <=  4'b0001;
                        o_sram_addr     <= wb_adr_r;
                        io_sram_data_l  <= wb_dat_r[ 7: 0];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= wb_adr_r + 1;
                        ram_sel_r       <= {  1'd0,wb_sel_r[WB_SWIDTH-1: 1] };		// Litte Endian
                        ram_dat_r       <= {  8'd0,wb_dat_r[WB_DWIDTH-1: 8] };
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[1] )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs       <= 4'b0001;
                        o_sram_addr     <= wb_adr_r + 1;
                        io_sram_data_l  <= wb_dat_r[15: 8];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= wb_adr_r + 2;
                        ram_sel_r       <= {  2'd0,wb_sel_r[WB_SWIDTH-1: 2] };
                        ram_dat_r       <= { 16'd0,wb_dat_r[WB_DWIDTH-1:16] };
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[2] )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs       <= 4'b0001;
                        o_sram_addr     <= wb_adr_r + 2;
                        io_sram_data_l  <= wb_dat_r[23:16];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= wb_adr_r + 3;
                        ram_sel_r       <= {  3'd0,wb_sel_r[WB_SWIDTH-1: 3] };
                        ram_dat_r       <= { 24'd0,wb_dat_r[WB_DWIDTH-1:24] };
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[3] )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs       <= 4'b0001;
                        o_sram_addr     <= wb_adr_r + 3;
                        io_sram_data_l  <= wb_dat_r[31:24];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= 'd0;
                        ram_sel_r       <= 'd0;
                        ram_dat_r       <= 'd0;
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
`ifdef AMBER_A25_CORE
                    else if ( wb_sel_r[WB_SWIDTH-1] )
`endif
                    else
                        begin
                        sram_state      <= SRAM_FSM_WRITE_END_STATE;
                        o_sram_cs       <= 4'b0000;
                        o_sram_addr     <= 'd0;
                        io_sram_data_l  <= 'd0;
                        io_sram_data_e  <= 'd0;
                        write_final_r   <= 'd1;
                        end
                    end
                else if ( wb_state == WB_FSM_READ_STATE )
                    begin
                    if ( wb_sel_r[0] )
                        begin
                        // first LB-Byte available
                        sram_state 	    <= SRAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs       <=  4'b0001;
                        o_sram_addr     <= wb_adr_r;
                        io_sram_data_e  <= 'd0;
                        ram_adr_r       <= wb_adr_r + 1;
                        ram_sel_r       <= { 1'd0,wb_sel_r[WB_SWIDTH-1: 1] };		// Litte Endian
                        ram_read_pos    <= 'd0;
                        ram_dat_r       <= 'd0;
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[1] )
                        begin
                        sram_state 	    <= SRAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs       <=  4'b0001;
                        o_sram_addr     <= wb_adr_r + 1;
                        io_sram_data_e  <= 'd0;
                        ram_adr_r       <= wb_adr_r + 2;
                        ram_sel_r       <= { 2'd0,wb_sel_r[WB_SWIDTH-1: 2] };
                        ram_read_pos    <= 'd1;
                        ram_dat_r       <= 'd0;
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[2] )
                        begin
                        sram_state 	    <= SRAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs       <=  4'b0001;
                        o_sram_addr     <= wb_adr_r + 2;
                        io_sram_data_e  <= 'd0;
                        ram_adr_r       <= wb_adr_r + 3;
                        ram_sel_r       <= { 3'd0,wb_sel_r[WB_SWIDTH-1: 3] };
                        ram_read_pos    <= 'd2;
                        ram_dat_r       <= 'd0;
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[3] )
                        begin
                        sram_state 	    <= SRAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs       <=  4'b0001;
                        o_sram_addr     <= wb_adr_r + 3;
                        io_sram_data_e  <= 'd0;
                        ram_adr_r       <= 'd0;
                        ram_sel_r       <= 'd0;
                        ram_read_pos    <= 'd3;
                        ram_dat_r       <= 'd0;
                        ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                        end
                    else
                        begin
                        sram_state      <= SRAM_FSM_READ_END_STATE;
                        o_sram_cs       <= 4'b0000;
                        o_sram_addr     <= 'd0;
                        io_sram_data_l  <= 'd0;
                        io_sram_data_e  <= 'd0;
                        wb_dat_out_r    <= 'd0;     // reading w/o any selected bytes
                        read_final_r    <= 'd1;
                        end
                    end

            SRAM_FSM_WRITE_BYTE_SU_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    sram_state      <= SRAM_FSM_WRITE_BYTE_HD_STATE;
                    o_sram_write    <= 'd1;
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
                else
                    begin
                    sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                    ram_cyc_ctr     <= ram_cyc_ctr - 1;
                    end
                end
					
            SRAM_FSM_WRITE_BYTE_HD_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    sram_state      <= SRAM_FSM_WRITE_LOOP_STATE;
                    o_sram_write    <= 'd0;
                    end
                else
                    begin
                    sram_state      <= SRAM_FSM_WRITE_BYTE_HD_STATE;
                    ram_cyc_ctr     <= ram_cyc_ctr - 1;
                    end
                end

            SRAM_FSM_WRITE_LOOP_STATE:
                begin
                if ( ram_sel_r[0] )
                    begin
                    sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                    o_sram_addr     <= ram_adr_r;
                    io_sram_data_l  <= ram_dat_r[ 7: 0];
                    io_sram_data_e  <= 'd1;
                    o_sram_write    <= 'd0;
                    ram_adr_r       <= ram_adr_r + 1;
                    ram_sel_r       <= {  1'd0,ram_sel_r[WB_SWIDTH-1: 1] };
                    ram_dat_r       <= {  8'd0,ram_dat_r[WB_DWIDTH-1: 8] };
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[1] )
                    begin
                    sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                    o_sram_addr     <= ram_adr_r + 1;
                    io_sram_data_l  <= ram_dat_r[15: 8];
                    io_sram_data_e  <= 'd1;
                    o_sram_write    <= 'd0;
                    ram_adr_r       <= ram_adr_r + 2;
                    ram_sel_r       <= {  2'd0,ram_sel_r[WB_SWIDTH-1: 2] };
                    ram_dat_r       <= { 16'd0,ram_dat_r[WB_DWIDTH-1:16] };
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[2] )
                    begin
                    sram_state      <= SRAM_FSM_WRITE_BYTE_SU_STATE;
                    o_sram_addr     <= ram_adr_r + 2;
                    io_sram_data_l  <= ram_dat_r[23:16];
                    io_sram_data_e  <= 'd1;
                    o_sram_write    <= 'd0;
                    ram_adr_r       <= ram_adr_r + 3;
                    ram_sel_r       <= {  3'd0,ram_sel_r[WB_SWIDTH-1: 3] };
                    ram_dat_r       <= { 24'd0,ram_dat_r[WB_DWIDTH-1:24] };
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
`ifdef AMBER_A25_CORE
                else if ( ram_sel_r[WB_SWIDTH-2] )
`endif
                else
                    begin
                    sram_state      <= SRAM_FSM_WRITE_END_STATE;
                    write_final_r   <= 'd1;
                    end
                end
					
            SRAM_FSM_WRITE_END_STATE:
                if ( wb_state == WB_FSM_READY_STATE )
                    begin
                    sram_state      <= SRAM_FSM_READY_STATE;
                    write_final_r   <= 'd0;
                    o_sram_cs       <= 4'b0000;
                    o_sram_read     <= 'd0;
                    o_sram_write  	<= 'd0;
                    o_sram_addr     <= 'd0;
                    io_sram_data_l  <= 'd0;
                    io_sram_data_e  <= 'd0;
                    end

            SRAM_FSM_READ_BYTE_SU_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    sram_state      <= SRAM_FSM_READ_BYTE_HD_STATE;
                    o_sram_read     <= 'd1;
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
                else
                    begin
                    sram_state      <= SRAM_FSM_READ_BYTE_SU_STATE;
                    ram_cyc_ctr     <= ram_cyc_ctr - 1;
                    end
                end

            SRAM_FSM_READ_BYTE_HD_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    sram_state      <= SRAM_FSM_READ_LOOP_STATE;
                    o_sram_read     <= 'd0;
                    ram_dat_r       <= ram_dat_r | (io_sram_data << (ram_read_pos << 3));
                    end
                else
                    begin
                    sram_state      <= SRAM_FSM_READ_BYTE_HD_STATE;
                    ram_cyc_ctr     <= ram_cyc_ctr - 1;
                    end
                end

            SRAM_FSM_READ_LOOP_STATE:
                begin
                if ( ram_sel_r[0] )
                    begin
                    sram_state      <= SRAM_FSM_READ_BYTE_SU_STATE;
                    o_sram_addr     <= ram_adr_r;
                    o_sram_read     <= 'd0;
                    ram_adr_r       <= ram_adr_r + 1;
                    ram_sel_r       <= {  1'd0,ram_sel_r[WB_SWIDTH-1: 1] };
                    ram_read_pos    <= ram_read_pos + 1;
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[1] )
                    begin
                    sram_state      <= SRAM_FSM_READ_BYTE_SU_STATE;
                    o_sram_addr     <= ram_adr_r + 1;
                    o_sram_read     <= 'd0;
                    ram_adr_r       <= ram_adr_r + 2;
                    ram_sel_r       <= {  2'd0,ram_sel_r[WB_SWIDTH-1: 2] };
                    ram_read_pos    <= ram_read_pos + 2;
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[2] )
                    begin
                    sram_state      <= SRAM_FSM_READ_BYTE_SU_STATE;
                    o_sram_addr     <= ram_adr_r + 2;
                    o_sram_read     <= 'd0;
                    ram_adr_r       <= ram_adr_r + 3;
                    ram_sel_r       <= {  3'd0,ram_sel_r[WB_SWIDTH-1: 3] };
                    ram_read_pos    <= ram_read_pos + 3;
                    ram_cyc_ctr     <= SRAM_CYC_CTR_VALUE;
                    end
`ifdef AMBER_A25_CORE
                else if ( ram_sel_r[WB_SWIDTH-2] )
`endif
                else
                    begin
                    sram_state      <= SRAM_FSM_READ_END_STATE;
                    wb_dat_out_r    <= ram_dat_r;
                    read_final_r    <= 'd1;
                    end
                end

            SRAM_FSM_READ_END_STATE:
                if ( wb_state == WB_FSM_READY_STATE )
                    begin
                    sram_state      <= SRAM_FSM_READY_STATE;
                    read_final_r    <= 'd0;
                    o_sram_cs       <= 4'b0000;
                    o_sram_read     <= 'd0;
                    o_sram_write  	<= 'd0;
                    o_sram_addr     <= 'd0;
                    io_sram_data_l  <= 'd0;
                    io_sram_data_e  <= 'd0;
                    end

        endcase

        
// SRAM signals
assign io_sram_data                                 = (io_sram_data_e) ?  io_sram_data_l : { SRAM_DATA_L{1'bz }};

// Wishbone async signals
assign o_wb_ack                                     = i_wb_stb && (write_request_r || read_final_r);
assign o_wb_err                                     = 'd0;
	  
endmodule
