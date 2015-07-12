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
`include "global_defines.vh"

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
output reg  [3:0]               o_sram_cs_n,             // ChipSelect#
output reg                      o_sram_read_n,           // Read#
output reg                      o_sram_write_n,          // Write#
output reg  [SRAM_ADR_L-1:0]    o_sram_addr,             // Addressbus
inout       [SRAM_DATA_L-1:0]   io_sram_data             // Databus

);


// Wishbone signals
wire                    write_request;
wire                    read_request;
reg                     write_ready_r               = 'd0;
reg                     read_ready_r                = 'd0;
reg                     write_final_r               = 'd0;
reg                     read_final_r                = 'd0;
//reg                     write_request_r;
//reg                     read_request_r;

reg  [SRAM_ADR_L-1:0]   wb_adr_r;
reg  [WB_DWIDTH-1:0]    wb_dat_write_r;
reg  [WB_SWIDTH-1:0]    wb_sel_write_r;
reg  [SRAM_ADR_L-1:0]   ram_adr_r;
reg  [WB_DWIDTH-1:0]    ram_dat_write_r;
reg  [WB_SWIDTH-1:0]    ram_sel_write_r;


// SRAM signals
reg  [7:0]              io_sram_data_l              = 'd0;
reg                     io_sram_data_e              = 'd0;
assign io_sram_data     = (io_sram_data_e) ?  io_sram_data_l : { SRAM_DATA_L{1'bz }};


// Wishbone async signals
assign write_request    = i_wb_stb &&  i_wb_we && write_ready_r;
assign read_request     = i_wb_stb && !i_wb_we && read_ready_r;
assign o_wb_ack         = i_wb_stb && (write_request || read_final_r);
assign o_wb_err         = 'd0;


// ------------------------------------------------------
// Syncing
// ------------------------------------------------------
//always @( posedge i_wb_clk )
//    if ( i_sys_rst )  // reset has to be synced
//        begin
//        write_request_r <= 'd0;
//        read_request_r  <= 'd0;
//        end
//    else
//        begin
//        write_request_r <= write_request;
//        read_request_r  <= read_request;
//        end

// ------------------------------------------------------
// Wishbone FSM
// ------------------------------------------------------
localparam WB_FSM_INIT_STATE    = 2'd0;
localparam WB_FSM_READY_STATE   = 2'd1;
localparam WB_FSM_WRITE_STATE   = 2'd2;
localparam WB_FSM_READ_STATE    = 2'd3;
reg [1:0] wb_state              = WB_FSM_READY_STATE;

always @( posedge i_wb_clk )
    if ( i_sys_rst )
        begin
        wb_state        <= WB_FSM_INIT_STATE;
        write_ready_r   <= 'd0;
        read_ready_r    <= 'd0;
        wb_adr_r        <= 'd0;
        wb_dat_write_r  <= 'd0;
        wb_sel_write_r  <= 'd0;
        end
    else
        case ( wb_state )
            WB_FSM_INIT_STATE:
                begin
                wb_state            <= WB_FSM_READY_STATE;
                write_ready_r       <= 'd1;
                read_ready_r        <= 'd1;
                end

            WB_FSM_READY_STATE:
                if ( write_request )
                    begin
                    wb_state        <= WB_FSM_WRITE_STATE;
                    wb_adr_r        <= i_wb_adr[SRAM_ADR_L-1:0];      // latch data to avoid wait state "wss"
                    wb_dat_write_r  <= i_wb_dat;
                    wb_sel_write_r  <= i_wb_sel;
                    write_ready_r   <= 'd0;				
                    read_ready_r    <= 'd0;
                    end
                else if ( read_request )
                    begin
                    wb_state        <= WB_FSM_READ_STATE;
                    write_ready_r   <= 'd1;				
                    read_ready_r    <= 'd0;
                    end

            WB_FSM_WRITE_STATE:
                if ( write_final_r )
                    begin
                    wb_state        <= WB_FSM_READY_STATE;
                    write_ready_r   <= 'd1;
                    read_ready_r    <= 'd1;
                    end

            WB_FSM_READ_STATE:
                if ( read_final_r )
                    begin
                    wb_state        <= WB_FSM_READY_STATE;
                    write_ready_r   <= 'd1;
                    read_ready_r    <= 'd1;
                    end
	     endcase


// ------------------------------------------------------
// External SRAM FSM
// ------------------------------------------------------
localparam SRAM_FSM_INIT_STATE          = 3'd0;
localparam SRAM_FSM_READY_STATE         = 3'd1;
localparam SRAM_FSM_WRITE_BYTE_STATE    = 3'd2;
localparam SRAM_FSM_WRITE_LOOP_STATE    = 3'd3;
localparam SRAM_FSM_WRITE_END_STATE     = 3'd4;
//localparam SRAM_FSM_READ_XXX_STATE    = 3'd5;
//localparam SRAM_FSM_READ_XXX_STATE    = 3'd6;
//localparam SRAM_FSM_READ_XXX_STATE    = 3'd7;
reg [2:0] sram_state                    = SRAM_FSM_INIT_STATE;

always @( posedge i_ram_clk )
    if ( i_sys_rst )
        begin
        sram_state              <= SRAM_FSM_INIT_STATE;
        o_sram_cs_n             <= 4'b1111;
        o_sram_read_n           <= 'd1;
		o_sram_write_n          <= 'd1;
		o_sram_addr             <= 'd0;
        io_sram_data_l          <= 'd0;
        io_sram_data_e          <= 'd0;
        write_final_r           <= 'd0;
        read_final_r            <= 'd0;
		ram_adr_r               <= 'd0;
		ram_sel_write_r         <= 'd0;
		ram_dat_write_r         <= 'd0;
		end
    else
        case ( sram_state )
            SRAM_FSM_INIT_STATE:
                begin
                sram_state              <= SRAM_FSM_READY_STATE;
                o_sram_cs_n		        <= 4'b1111;
                o_sram_read_n           <= 'd1;
                o_sram_write_n	        <= 'd1;
                o_sram_addr             <= 'd0;
                io_sram_data_l          <= 'd0;
                io_sram_data_e          <= 'd0;
                write_final_r           <= 'd0;
                read_final_r            <= 'd0;
                ram_adr_r               <= 'd0;
                ram_sel_write_r         <= 'd0;
                ram_dat_write_r         <= 'd0;
                end
				
            SRAM_FSM_READY_STATE:
                if ( wb_state == WB_FSM_WRITE_STATE )
                    begin
                    if ( wb_sel_write_r[0] == 1 )
                        begin
                        // data w/o shift available
                        sram_state 	    <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_cs_n     <=  4'b1110;
                        o_sram_addr     <= wb_adr_r[SRAM_ADR_L-1:0];
                        io_sram_data_l  <= wb_dat_write_r[ 7: 0];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= wb_adr_r + 1;
                        ram_sel_write_r <= { 1'd0,wb_sel_write_r[WB_SWIDTH-1: 1] };		// Litte Endian
                        ram_dat_write_r <= { 8'd0,wb_dat_write_r[WB_DWIDTH-1: 8] };
                        end
                    else if ( wb_sel_write_r[1] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_cs_n     <= 4'b1110;
                        o_sram_addr     <= wb_adr_r + 1;
                        io_sram_data_l  <= wb_dat_write_r[15: 8];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= wb_adr_r + 2;
                        ram_sel_write_r <= {  2'd0,wb_sel_write_r[WB_SWIDTH-1: 2] };
                        ram_dat_write_r <= { 16'd0,wb_dat_write_r[WB_DWIDTH-1:16] };
                        end
                    else if ( wb_sel_write_r[2] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_cs_n     <= 4'b1110;
                        o_sram_addr     <= wb_adr_r + 2;
                        io_sram_data_l  <= wb_dat_write_r[23:16];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= wb_adr_r + 3;
                        ram_sel_write_r <= {  3'd0,wb_sel_write_r[WB_SWIDTH-1: 3] };
                        ram_dat_write_r <= { 24'd0,wb_dat_write_r[WB_DWIDTH-1:24] };
                        end
                    else if ( wb_sel_write_r[3] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_cs_n     <= 4'b1110;
                        o_sram_addr     <= wb_adr_r + 3;
                        io_sram_data_l  <= wb_dat_write_r[31:24];
                        io_sram_data_e  <= 'd1;
                        ram_adr_r       <= 'd0;
                        ram_sel_write_r <= 'd0;
                        ram_dat_write_r <= 'd0;
                        end
`ifdef AMBER_A25_CORE
                    else if ( wb_sel_write_r[WB_SWIDTH-1] == 1 )
`endif
                    else
                        begin
                        sram_state      <= SRAM_FSM_WRITE_END_STATE;
                        o_sram_cs_n     <= 4'b1111;
                        o_sram_addr     <= 'd0;
                        io_sram_data_l  <= 'd0;
                        io_sram_data_e  <= 'd0;
                        write_final_r   <= 'd1;
                        end
                    end
						
                SRAM_FSM_WRITE_BYTE_STATE:
                    begin
                    sram_state          <= SRAM_FSM_WRITE_LOOP_STATE;
                    o_sram_write_n      <= 'd0;
                    end
					
                SRAM_FSM_WRITE_LOOP_STATE:
                    begin
                    if ( ram_sel_write_r[0] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_addr     <= ram_adr_r[SRAM_ADR_L-1:0];
                        io_sram_data_l  <= ram_dat_write_r[ 7: 0];
                        io_sram_data_e  <= 'd1;
                        o_sram_write_n  <= 'd1;
                        ram_adr_r       <= ram_adr_r + 1;
                        ram_sel_write_r <= { 1'd0,ram_sel_write_r[WB_SWIDTH-1: 1] };
                        ram_dat_write_r <= { 8'd0,ram_dat_write_r[WB_DWIDTH-1: 8] };
                        end
                    else if ( wb_sel_write_r[1] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_addr     <= ram_adr_r + 1;
                        io_sram_data_l  <= ram_dat_write_r[15: 8];
                        io_sram_data_e  <= 'd1;
                        o_sram_write_n  <= 'd1;
                        ram_adr_r       <= ram_adr_r + 2;
                        ram_sel_write_r <= { 2'd0,ram_sel_write_r[WB_SWIDTH-1: 2] };
                        ram_dat_write_r <= {16'd0,ram_dat_write_r[WB_DWIDTH-1:16] };
                        end
                    else if ( wb_sel_write_r[2] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_addr     <= ram_adr_r + 2;
                        io_sram_data_l  <= ram_dat_write_r[23:16];
                        io_sram_data_e  <= 'd1;
                        o_sram_write_n  <= 'd1;
                        ram_adr_r       <= ram_adr_r + 3;
                        ram_sel_write_r <= { 3'd0,ram_sel_write_r[WB_SWIDTH-1: 3] };
                        ram_dat_write_r <= {24'd0,ram_dat_write_r[WB_DWIDTH-1:24] };
                        end
                    else if ( wb_sel_write_r[3] == 1 )
                        begin
                        sram_state      <= SRAM_FSM_WRITE_BYTE_STATE;
                        o_sram_addr     <= ram_adr_r + 3;
                        io_sram_data_l  <= ram_dat_write_r[31:24];
                        io_sram_data_e  <= 'd1;
                        o_sram_write_n  <= 'd1;
                        end
`ifdef AMBER_A25_CORE
                    else if ( wb_sel_write_r[WB_SWIDTH-1] == 1 )
`endif
                    else
                        begin
                        sram_state      <= SRAM_FSM_WRITE_END_STATE;
                        write_final_r   <= 'd1;
                        end
                    end
					
                SRAM_FSM_WRITE_END_STATE:
                    if ( !i_wb_stb )
                        begin
                        sram_state      <= SRAM_FSM_READY_STATE;
                        write_final_r   <= 'd0;
                        o_sram_cs_n     <= 4'b1111;
                        o_sram_read_n   <= 'd1;
                        o_sram_write_n	<= 'd1;
                        o_sram_addr     <= 'd0;
                        io_sram_data_e  <= 'd0;
                        end
						
				// TODO: READ	
        endcase
	  
endmodule
