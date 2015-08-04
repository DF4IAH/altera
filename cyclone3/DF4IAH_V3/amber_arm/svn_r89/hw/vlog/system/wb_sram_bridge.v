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
output      [SRAM_ADR_L-1:0]    o_sram_addr,                    // Addressbus
inout       [SRAM_DATA_L-1:0]   io_sram_data                    // Databus

);


// SRAM signals
reg  [7:0]              io_sram_data_l              = 'd0;
reg                     io_sram_data_e              = 'd0;


// Wishbone FSM signals
localparam WB_FSM_INIT_STATE                        = 2'd0;
localparam WB_FSM_READY_STATE                       = 2'd1;
localparam WB_FSM_WRITE_STATE                       = 2'd2;
localparam WB_FSM_READ_STATE                        = 2'd3;

reg                     ready_r                     = 'd0;
wire                    write_request;
reg                     write_request_r             = 'd0;
wire                    read_request;
reg                     read_request_r              = 'd0;
reg                     wb_write_final_r            = 'd0;
reg                     wb_read_final_r             = 'd0;
reg  [1:0]              wb_state                    = WB_FSM_READY_STATE;
reg  [SRAM_ADR_L-1:0]   wb_adr_r                    = 'd0;
reg  [WB_DWIDTH-1:0]    wb_dat_r                    = 'd0;
reg  [WB_SWIDTH-1:0]    wb_sel_r                    = 'd0;


// RAM FSM signals
localparam [2:0] RAM_CYC_CTR_VALUE                  = 3'd5;
localparam RAM_FSM_INIT_STATE                       = 4'd0;
localparam RAM_FSM_READY_STATE                      = 4'd1;
localparam RAM_FSM_WRITE_BYTE_SU_STATE              = 4'd2;
localparam RAM_FSM_WRITE_BYTE_HD_STATE              = 4'd3;
localparam RAM_FSM_WRITE_LOOP_STATE                 = 4'd4;
localparam RAM_FSM_WRITE_END_STATE                  = 4'd5;
localparam RAM_FSM_READ_BYTE_SU_STATE               = 4'd6;
localparam RAM_FSM_READ_BYTE_HD_STATE               = 4'd7;
localparam RAM_FSM_READ_LOOP_STATE                  = 4'd8;
localparam RAM_FSM_READ_END_STATE                   = 4'd9;

reg  [3:0]              ram_state                   = RAM_FSM_INIT_STATE;
reg                     ram_write_final_r           = 'd0;
reg                     ram_read_final_r            = 'd0;
integer                 ram_addr_int                =   0;
integer                 ram_adr_r_int               =   0;
wire [SRAM_ADR_L-1:0]   ram_adr_r;
reg  [WB_DWIDTH-1:0]    ram_dat_r                   = 'd0;
reg  [WB_DWIDTH-1:0]    ram_dat_out_r               = 'd0;
reg  [WB_SWIDTH-1:0]    ram_sel_r                   = 'd0;
integer                 ram_pos_int                 =   0;
wire [1:0]              ram_pos;
integer                 ram_cyc_ctr_int             =   0;
wire [2:0]              ram_cyc_ctr;

assign o_sram_addr                                  = ram_addr_int[SRAM_ADR_L-1:0];
assign ram_adr_r                                    = ram_adr_r_int[SRAM_ADR_L-1:0];
assign ram_pos                                      = ram_pos_int[1:0];
assign ram_cyc_ctr                                  = ram_cyc_ctr_int[2:0];


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
        o_wb_dat        <= ram_dat_out_r;
        end


// ------------------------------------------------------
// Wishbone FSM
// ------------------------------------------------------
always @( posedge i_wb_clk )
    if ( i_sys_rst )
        begin
        wb_state            <= WB_FSM_INIT_STATE;
        ready_r             <= 'd0;
        wb_write_final_r    <= 'd0;
        wb_read_final_r     <= 'd0;
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
                wb_write_final_r    <= 'd0;
                wb_read_final_r     <= 'd0;
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
                    wb_adr_r        <= i_wb_adr[SRAM_ADR_L-1:0];
                    wb_sel_r        <= i_wb_sel;
                    end

            WB_FSM_WRITE_STATE:
                if ( ram_write_final_r )
                    begin
                    wb_state        <= WB_FSM_INIT_STATE;
                    wb_write_final_r<= 'd1;
                    wb_adr_r        <= 'd0;
                    wb_dat_r        <= 'd0;
                    wb_sel_r        <= 'd0;
                    end

            WB_FSM_READ_STATE:
                if ( ram_read_final_r )
                    begin
                    wb_state        <= WB_FSM_INIT_STATE;
                    wb_read_final_r <= 'd1;
                    wb_adr_r        <= 'd0;
                    wb_sel_r        <= 'd0;
                    end
        endcase


// ------------------------------------------------------
// External SRAM FSM
// ------------------------------------------------------
always @( posedge i_ram_clk )
    if ( i_sys_rst )
        begin
        ram_state               <= RAM_FSM_INIT_STATE;
        ram_write_final_r       <= 'd0;
        ram_read_final_r        <= 'd0;
        ram_dat_out_r           <= 'd0;
        o_sram_cs               <= 4'b0000;
        o_sram_read             <= 'd0;
		o_sram_write            <= 'd0;
		ram_addr_int            <=   0;
        io_sram_data_l          <= 'd0;
        io_sram_data_e          <= 'd0;
		ram_adr_r_int           <=   0;
		ram_sel_r               <= 'd0;
		ram_dat_r               <= 'd0;
        ram_pos_int             <=   0;
        ram_cyc_ctr_int         <=   0;
		end
    else
        case ( ram_state )
            RAM_FSM_INIT_STATE:
                begin
                ram_state               <= RAM_FSM_READY_STATE;
                ram_write_final_r       <= 'd0;
                ram_read_final_r        <= 'd0;
                ram_dat_out_r           <= 'd0;
                o_sram_cs               <= 4'b0000;
                o_sram_read             <= 'd0;
                o_sram_write            <= 'd0;
                ram_addr_int            <=   0;
                io_sram_data_l          <= 'd0;
                io_sram_data_e          <= 'd0;
                ram_adr_r_int           <=   0;
                ram_sel_r               <= 'd0;
                ram_dat_r               <= 'd0;
                ram_pos_int             <=   0;
                ram_cyc_ctr_int         <=   0;
                end
				
            RAM_FSM_READY_STATE:
                if ( wb_state == WB_FSM_WRITE_STATE )
                    begin
                    if ( wb_sel_r[0] )
                        begin
                        // data w/o shift available
                        ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs           <=  4'b0001;
                        ram_addr_int        <= wb_adr_r;
                        io_sram_data_l      <= wb_dat_r[ 7: 0];
                        io_sram_data_e      <= 'd1;
                        ram_adr_r_int       <= wb_adr_r + 1;                            // Litte Endian
                        ram_pos_int         <=   0;
                        ram_sel_r           <= wb_sel_r >> 1;                           // shift one bit right
                        ram_dat_r           <= wb_dat_r >> 8;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[1] )
                        begin
                        ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs           <= 4'b0001;
                        ram_addr_int        <= wb_adr_r + 1;
                        io_sram_data_l      <= wb_dat_r[15: 8];
                        io_sram_data_e      <= 'd1;
                        ram_adr_r_int       <= wb_adr_r + 2;
                        ram_pos_int         <=   1;
                        ram_sel_r           <= wb_sel_r >> 2;                           // shift two bits right
                        ram_dat_r           <= wb_dat_r >> 16;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[2] )
                        begin
                        ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs           <= 4'b0001;
                        ram_addr_int        <= wb_adr_r + 2;
                        io_sram_data_l      <= wb_dat_r[23:16];
                        io_sram_data_e      <= 'd1;
                        ram_adr_r_int       <= wb_adr_r + 3;
                        ram_pos_int         <=   2;
                        ram_sel_r           <= wb_sel_r >> 3;                           // shift three bits right
                        ram_dat_r           <= wb_dat_r >> 24;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[3] )
                        begin
                        ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs           <= 4'b0001;
                        ram_addr_int        <= wb_adr_r + 3;
                        io_sram_data_l      <= wb_dat_r[31:24];
                        io_sram_data_e      <= 'd1;
                        ram_adr_r_int       <=   0;
                        ram_pos_int         <=   3;
                        ram_sel_r           <= 'd0;
                        ram_dat_r           <= 'd0;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
`ifdef AMBER_A25_CORE
                    else if ( wb_sel_r[WB_SWIDTH-1] )
                        begin
                        end
`endif
                    else
                        begin
                        ram_state           <= RAM_FSM_WRITE_END_STATE;
                        o_sram_cs           <= 4'b0000;
                        ram_addr_int        <=   0;
                        io_sram_data_l      <= 'd0;
                        io_sram_data_e      <= 'd0;
                        ram_write_final_r   <= 'd1;
                        end
                    end
                else if ( wb_state == WB_FSM_READ_STATE )
                    begin
                    if ( wb_sel_r[0] )
                        begin
                        // first least significant byte available
                        ram_state 	        <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs           <=  4'b0001;
                        ram_addr_int        <= wb_adr_r;
                        io_sram_data_e      <= 'd0;
                        ram_adr_r_int       <= wb_adr_r + 1;                    // Litte Endian
                        ram_sel_r           <= wb_sel_r >> 1;                   // shift one bit right
                        ram_pos_int         <=   0;
                        ram_dat_r           <= 'd0;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[1] )
                        begin
                        ram_state 	        <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs           <=  4'b0001;
                        ram_addr_int        <= wb_adr_r + 1;
                        io_sram_data_e      <= 'd0;
                        ram_adr_r_int       <= wb_adr_r + 2;
                        ram_sel_r           <= wb_sel_r >> 2;                   // shift two bits right
                        ram_pos_int         <=   1;
                        ram_dat_r           <= 'd0;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[2] )
                        begin
                        ram_state 	        <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs           <=  4'b0001;
                        ram_addr_int        <= wb_adr_r + 2;
                        io_sram_data_e      <= 'd0;
                        ram_adr_r_int       <= wb_adr_r + 3;
                        ram_sel_r           <= wb_sel_r >> 3;                   // shift three bits right
                        ram_pos_int         <=   2;
                        ram_dat_r           <= 'd0;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else if ( wb_sel_r[3] )
                        begin
                        ram_state 	        <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs           <=  4'b0001;
                        ram_addr_int        <= wb_adr_r + 3;
                        io_sram_data_e      <= 'd0;
                        ram_adr_r_int       <=   0;
                        ram_sel_r           <= 'd0;
                        ram_pos_int         <=   3;
                        ram_dat_r           <= 'd0;
                        ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                        end
                    else
                        begin
                        ram_state           <= RAM_FSM_READ_END_STATE;
                        o_sram_cs           <= 4'b0000;
                        ram_addr_int        <=   0;
                        io_sram_data_l      <= 'd0;
                        io_sram_data_e      <= 'd0;
                        ram_dat_out_r       <= 'd0;                             // reading w/o any selected bytes
                        ram_read_final_r    <= 'd1;
                        end
                    end

            RAM_FSM_WRITE_BYTE_SU_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    ram_state           <= RAM_FSM_WRITE_BYTE_HD_STATE;
                    o_sram_write        <= 'd1;
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
                else
                    begin
                    ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    ram_cyc_ctr_int     <= ram_cyc_ctr - 1;
                    end
                end
					
            RAM_FSM_WRITE_BYTE_HD_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    o_sram_write    <= 'd0;
                    if ( ram_sel_r == 4'd0 )
                        begin
                        ram_state           <= RAM_FSM_WRITE_END_STATE;
                        ram_write_final_r   <= 'd1;
                        end
                    else
                        ram_state           <= RAM_FSM_WRITE_LOOP_STATE;
                    end
                else
                    begin
                    ram_state           <= RAM_FSM_WRITE_BYTE_HD_STATE;
                    ram_cyc_ctr_int     <= ram_cyc_ctr - 1;
                    end
                end

            RAM_FSM_WRITE_LOOP_STATE:
                begin
                if ( ram_sel_r[0] )
                    begin
                    ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    ram_addr_int        <= ram_adr_r;
                    io_sram_data_l      <= 8'h_ff & (ram_dat_r >> ({4'd0,ram_pos} << 3));
                    io_sram_data_e      <= 'd1;
                    o_sram_write        <= 'd0;
                    ram_adr_r_int       <= ram_adr_r + 1;
                    ram_pos_int         <= ram_pos + 1;
                    ram_sel_r           <= ram_sel_r >> 1;                      // shift one bit right
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[1] )
                    begin
                    ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    ram_addr_int        <= ram_adr_r + 1;
                    io_sram_data_l      <= 8'h_ff & (ram_dat_r >> ({4'd0,ram_pos} << 3));
                    io_sram_data_e      <= 'd1;
                    o_sram_write        <= 'd0;
                    ram_adr_r_int       <= ram_adr_r + 2;
                    ram_pos_int         <= ram_pos + 2;
                    ram_sel_r           <= ram_sel_r >> 2;                      // shift two bits right
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[2] )
                    begin
                    ram_state           <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    ram_addr_int        <= ram_adr_r + 2;
                    io_sram_data_l      <= 8'h_ff & (ram_dat_r >> ({4'd0,ram_pos} << 3));
                    io_sram_data_e      <= 'd1;
                    o_sram_write        <= 'd0;
                    ram_adr_r_int       <= ram_adr_r + 3;
                    ram_pos_int         <= ram_pos + 3;
                    ram_sel_r           <= ram_sel_r >> 3;                      // shift three bits right
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
`ifdef AMBER_A25_CORE
                else if ( ram_sel_r[WB_SWIDTH-2] )
                    begin
                    end
`endif
//              else                                                            // dead code
//                  begin
//                  ram_state           <= RAM_FSM_WRITE_END_STATE;
//                  write_final_r       <= 'd1;
//                  end
                end
					
            RAM_FSM_WRITE_END_STATE:
                begin
                if ( wb_state <= WB_FSM_READY_STATE )
                    begin
                    ram_state           <= RAM_FSM_READY_STATE;
                    ram_write_final_r   <= 'd0;
                    o_sram_cs           <= 4'b0000;
                    o_sram_read         <= 'd0;
                    o_sram_write  	    <= 'd0;
                    ram_addr_int        <=   0;
                    io_sram_data_l      <= 'd0;
                    io_sram_data_e      <= 'd0;
                    end
                end 

            RAM_FSM_READ_BYTE_SU_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    ram_state           <= RAM_FSM_READ_BYTE_HD_STATE;
                    o_sram_read         <= 'd1;
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
                else
                    begin
                    ram_state           <= RAM_FSM_READ_BYTE_SU_STATE;
                    ram_cyc_ctr_int     <= ram_cyc_ctr - 1;
                    end
                end

            RAM_FSM_READ_BYTE_HD_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    o_sram_read         <= 'd0;
                    ram_dat_r           <= ram_dat_r | ({24'd0,io_sram_data} << ({8'd0,ram_pos} << 3));
                    if ( ram_sel_r == 4'd0 )
                        begin
                        ram_state           <= RAM_FSM_READ_END_STATE;
                        ram_read_final_r    <= 'd1;
                        ram_dat_out_r       <= ram_dat_r | ({24'd0,io_sram_data} << ({8'd0,ram_pos} << 3));
                        end
                    else
                        ram_state           <= RAM_FSM_READ_LOOP_STATE;
                    end
                else
                    begin
                    ram_state           <= RAM_FSM_READ_BYTE_HD_STATE;
                    ram_cyc_ctr_int     <= ram_cyc_ctr - 1;
                    end
                end

            RAM_FSM_READ_LOOP_STATE:
                begin
                if ( ram_sel_r[0] )
                    begin
                    ram_state           <= RAM_FSM_READ_BYTE_SU_STATE;
                    ram_addr_int        <= ram_adr_r;
                    o_sram_read         <= 'd0;
                    ram_adr_r_int       <= ram_adr_r + 1;
                    ram_pos_int         <= ram_pos + 1;
                    ram_sel_r           <= ram_sel_r >> 1;
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[1] )
                    begin
                    ram_state           <= RAM_FSM_READ_BYTE_SU_STATE;
                    ram_addr_int        <= ram_adr_r + 1;
                    o_sram_read         <= 'd0;
                    ram_adr_r_int       <= ram_adr_r + 2;
                    ram_pos_int         <= ram_pos + 2;
                    ram_sel_r           <= ram_sel_r >> 2;
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
                else if ( ram_sel_r[2] )
                    begin
                    ram_state           <= RAM_FSM_READ_BYTE_SU_STATE;
                    ram_addr_int        <= ram_adr_r + 2;
                    o_sram_read         <= 'd0;
                    ram_adr_r_int       <= ram_adr_r + 3;
                    ram_pos_int         <= ram_pos + 3;
                    ram_sel_r           <= ram_sel_r >> 3;
                    ram_cyc_ctr_int     <= RAM_CYC_CTR_VALUE;
                    end
`ifdef AMBER_A25_CORE
                else if ( ram_sel_r[WB_SWIDTH-2] )
`endif
//              else                                                            // dead code
//                  begin
//                  ram_state           <= RAM_FSM_READ_END_STATE;
//                  ram_dat_out_r       <= ram_dat_r;
//                  read_final_r        <= 'd1;
//                  end
                end

            RAM_FSM_READ_END_STATE:
                begin
                if ( wb_state <= WB_FSM_READY_STATE )
                    begin
                    ram_state           <= RAM_FSM_READY_STATE;
                    ram_read_final_r    <= 'd0;
                    o_sram_cs           <= 4'b0000;
                    o_sram_read         <= 'd0;
                    o_sram_write  	    <= 'd0;
                    ram_addr_int        <=   0;
                    io_sram_data_l      <= 'd0;
                    io_sram_data_e      <= 'd0;
                    end
                end

        endcase


// SRAM signals
assign io_sram_data                                 = (io_sram_data_e) ?  io_sram_data_l : { SRAM_DATA_L{1'bz} };

// Wishbone async signals
assign o_wb_ack                                     = i_wb_stb && (write_request || wb_read_final_r);
assign o_wb_err                                     = 'd0;


// ========================================================
// Debug - non-synthesizable code
// ========================================================
//synthesis translate_off
//synopsys translate_off
wire    [(5*8)-1:0]    xWB_STATE;
wire    [(6*8)-1:0]    xRAM_STATE;

assign  xWB_STATE   = wb_state  == WB_FSM_INIT_STATE                ? "INIT " :
                      wb_state  == WB_FSM_READY_STATE               ? "READY" :
                      wb_state  == WB_FSM_WRITE_STATE               ? "WRITE" :
                      wb_state  == WB_FSM_READ_STATE                ? "READ " :
                                                                      "?????" ;

assign  xRAM_STATE  = ram_state == RAM_FSM_INIT_STATE               ? "INIT  " :
                      ram_state == RAM_FSM_READY_STATE              ? "READY " :
                      ram_state == RAM_FSM_WRITE_BYTE_SU_STATE      ? "WrBySu" :
                      ram_state == RAM_FSM_WRITE_BYTE_HD_STATE      ? "WrByHd" :
                      ram_state == RAM_FSM_WRITE_LOOP_STATE         ? "WrLoop" :
                      ram_state == RAM_FSM_WRITE_END_STATE          ? "WrEnd " :
                      ram_state == RAM_FSM_READ_BYTE_SU_STATE       ? "RdBySu" :
                      ram_state == RAM_FSM_READ_BYTE_HD_STATE       ? "RdByHd" :
                      ram_state == RAM_FSM_READ_LOOP_STATE          ? "RdLoop" :
                      ram_state == RAM_FSM_READ_END_STATE           ? "RdEnd " :
                                                                      "??????" ;
//synopsys translate_on
//synthesis translate_on

endmodule
