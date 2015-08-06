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
inout       [SRAM_DATA_L-1:0]   io_sram_data,                   // Databus
output      [36: 0]             o_monitor
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
reg                     wb_read_final_r             = 'd0;
reg  [1:0]              wb_state                    = WB_FSM_READY_STATE;
reg  [SRAM_ADR_L-1:0]   wb_adr_r                    = 'd0;
reg  [WB_DWIDTH-1:0]    wb_dat_r                    = 'd0;
reg  [WB_SWIDTH-1:0]    wb_sel_r                    = 'd0;
reg  [WB_DWIDTH-1:0]    wbsync1_ram_dat_out_r       = 'd0;
reg  [WB_DWIDTH-1:0]    wbsync2_ram_dat_out_r       = 'd0;
reg  [3:0]              wbsync1_ram_state           = 'd0;
reg  [3:0]              wbsync2_ram_state           = 'd0;


// RAM FSM signals
localparam [2:0] RAM_CYC_CTR_VALUE_RD_SU            = 3'd1;
localparam [2:0] RAM_CYC_CTR_VALUE_RD_HD            = 3'd2;
localparam [2:0] RAM_CYC_CTR_VALUE_WR_SU            = 3'd0;
localparam [2:0] RAM_CYC_CTR_VALUE_WR_HD            = 3'd3;
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
reg  [SRAM_ADR_L-1:0]   ram_sr_adr_r                = 'd0;
reg  [WB_DWIDTH-1:0]    ram_dat_r                   = 'd0;
reg  [WB_DWIDTH-1:0]    ram_dat_out_r               = 'd0;
reg  [WB_SWIDTH-1:0]    ram_sel_r                   = 'd0;
reg  [1:0]              ram_pos_r                   = 'd0;
reg  [2:0]              ram_cyc_ctr                 = 'd0;
reg                     ramsync1_sys_rst            = 'd0;
//reg                     ramsync2_sys_rst            = 'd0;
reg  [1:0]              ramsync1_wb_state           = 'd0;
//reg  [1:0]              ramsync2_wb_state           = 'd0;
reg  [SRAM_ADR_L-1:0]   ramsync1_wb_adr_r           = 'd0;
//reg  [SRAM_ADR_L-1:0]   ramsync2_wb_adr_r           = 'd0;
reg  [WB_DWIDTH-1:0]    ramsync1_wb_dat_r           = 'd0;
//reg  [WB_DWIDTH-1:0]    ramsync2_wb_dat_r           = 'd0;
reg  [WB_SWIDTH-1:0]    ramsync1_wb_sel_r           = 'd0;
//reg  [WB_SWIDTH-1:0]    ramsync2_wb_sel_r           = 'd0;
reg  [31:0]             dummy                       = 'd0;


assign o_sram_addr                                  = ram_sr_adr_r;


// Wishbone async signals
assign write_request                                = i_wb_stb &&  i_wb_we && ready_r;
assign read_request                                 = i_wb_stb && !i_wb_we && ready_r;


// ------------------------------------------------------
// Syncing
// ------------------------------------------------------
always @( posedge i_wb_clk )
    if ( i_sys_rst )  // reset has to be synced
        begin
        write_request_r             <= 'd0;
        read_request_r              <= 'd0;
 
        o_wb_dat                    <= 'd0;
        wbsync1_ram_dat_out_r       <= 'd0;
        wbsync2_ram_dat_out_r       <= 'd0;

        wbsync1_ram_state           <= 'd0;
        wbsync2_ram_state           <= 'd0;
        end
    else
        begin
        write_request_r             <= write_request;
        read_request_r              <= read_request;

        o_wb_dat                    <= wbsync2_ram_dat_out_r;
        wbsync2_ram_dat_out_r       <= wbsync1_ram_dat_out_r;
        wbsync1_ram_dat_out_r       <= ram_dat_out_r;

        wbsync2_ram_state           <= wbsync1_ram_state;
        wbsync1_ram_state           <= ram_state;
        end


always @( posedge i_ram_clk )
        begin
//        ramsync2_sys_rst            <= ramsync1_sys_rst;
        ramsync1_sys_rst            <= i_sys_rst;
        end

always @( posedge i_ram_clk )
    if ( ramsync1_sys_rst )
        begin
        ramsync1_wb_state           <= 'd0;
//        ramsync2_wb_state           <= 'd0;

        ramsync1_wb_adr_r           <= 'd0;
//        ramsync2_wb_adr_r           <= 'd0;

        ramsync1_wb_dat_r           <= 'd0;
//        ramsync2_wb_dat_r           <= 'd0;

        ramsync1_wb_sel_r           <= 'd0;
//        ramsync2_wb_sel_r           <= 'd0;
        end
    else
        begin
//        ramsync2_wb_state           <= ramsync1_wb_state;
        ramsync1_wb_state           <= wb_state;

//        ramsync2_wb_adr_r           <= ramsync1_wb_adr_r;
        ramsync1_wb_adr_r           <= wb_adr_r;

//        ramsync2_wb_dat_r           <= ramsync1_wb_dat_r;
        ramsync1_wb_dat_r           <= wb_dat_r;

//        ramsync2_wb_sel_r           <= ramsync1_wb_sel_r;
        ramsync1_wb_sel_r           <= wb_sel_r;
        end


// ------------------------------------------------------
// Wishbone FSM
// ------------------------------------------------------
always @( posedge i_wb_clk )
    if ( i_sys_rst )
        begin
        wb_state            <= WB_FSM_INIT_STATE;
        ready_r             <= 'd0;
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
                wb_read_final_r     <= 'd0;
                wb_adr_r            <= 'd0;
                wb_dat_r            <= 'd0;
                wb_sel_r            <= 'd0;
                end

            WB_FSM_READY_STATE:
                if ( write_request && (wbsync2_ram_state == RAM_FSM_READY_STATE) )
                    begin
                    wb_state        <= WB_FSM_WRITE_STATE;
                    ready_r         <= 'd0;				
                    wb_adr_r        <= i_wb_adr[SRAM_ADR_L-1:0];                // latch data to avoid wait state "WSS"
                    wb_dat_r        <= i_wb_dat;
                    wb_sel_r        <= i_wb_sel;
                    end
                else if ( read_request && (wbsync2_ram_state == RAM_FSM_READY_STATE) )
                    begin
                    wb_state        <= WB_FSM_READ_STATE;
                    ready_r         <= 'd0;
                    wb_adr_r        <= i_wb_adr[SRAM_ADR_L-1:0];
                    wb_sel_r        <= i_wb_sel;
                    end

            WB_FSM_WRITE_STATE:
                if ( wbsync2_ram_state == RAM_FSM_WRITE_END_STATE )
                    begin
                    wb_state        <= WB_FSM_INIT_STATE;
                    wb_adr_r        <= 'd0;
                    wb_dat_r        <= 'd0;
                    wb_sel_r        <= 'd0;
                    end

            WB_FSM_READ_STATE:
                if ( wbsync2_ram_state == RAM_FSM_READ_END_STATE )
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
    if ( ramsync1_sys_rst )
        begin
        ram_state               <= RAM_FSM_INIT_STATE;
        ram_dat_out_r           <= 'd0;
        o_sram_cs               <= 4'b0000;
        o_sram_read             <= 'd0;
		o_sram_write            <= 'd0;
		ram_sr_adr_r            <= 'd0;
        io_sram_data_l          <= 'd0;
        io_sram_data_e          <= 'd0;
		ram_sel_r               <= 'd0;
		ram_dat_r               <= 'd0;
        ram_pos_r               <= 'd0;
        ram_cyc_ctr             <= 'd0;
		end
    else
        case ( ram_state )
            RAM_FSM_INIT_STATE:
                begin
                ram_state               <= RAM_FSM_READY_STATE;
                ram_dat_out_r           <= 'd0;
                o_sram_cs               <= 4'b0000;
                o_sram_read             <= 'd0;
                o_sram_write            <= 'd0;
                ram_sr_adr_r            <= 'd0;
                io_sram_data_l          <= 'd0;
                io_sram_data_e          <= 'd0;
                ram_sel_r               <= 'd0;
                ram_dat_r               <= 'd0;
                ram_pos_r               <= 'd0;
                ram_cyc_ctr             <= 'd0;
                end
				
            RAM_FSM_READY_STATE:
                if ( ramsync1_wb_state == WB_FSM_WRITE_STATE )
                    begin
                    if ( ramsync1_wb_sel_r[0] )
                        begin
                        // data w/o shift available
                        ram_state                   <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs                   <=  4'b0001;
                        ram_sr_adr_r                <= ramsync1_wb_adr_r;
                        io_sram_data_l              <= ramsync1_wb_dat_r[ 7: 0];
                        io_sram_data_e              <= 'd1;
                        ram_pos_r                   <= 2'd0;                            // Litte Endian
                        ram_sel_r                   <= ramsync1_wb_sel_r >> 1;           // shift one bit right
                        ram_dat_r                   <= ramsync1_wb_dat_r >> 8;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_WR_SU;
                        end
                    else if ( ramsync1_wb_sel_r[1] )
                        begin
                        ram_state                   <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs                   <= 4'b0001;
                        {dummy[31:21],ram_sr_adr_r} <= ramsync1_wb_adr_r + 1;
                        io_sram_data_l              <= ramsync1_wb_dat_r[15: 8];
                        io_sram_data_e              <= 'd1;
                        ram_pos_r                   <= 2'd1;
                        ram_sel_r                   <= ramsync1_wb_sel_r >> 2;           // shift two bits right
                        ram_dat_r                   <= ramsync1_wb_dat_r >> 16;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_WR_SU;
                        end
                    else if ( ramsync1_wb_sel_r[2] )
                        begin
                        ram_state                   <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs                   <= 4'b0001;
                        {dummy[31:21],ram_sr_adr_r} <= ramsync1_wb_adr_r + 2;
                        io_sram_data_l              <= ramsync1_wb_dat_r[23:16];
                        io_sram_data_e              <= 'd1;
                        ram_pos_r                   <= 2'd2;
                        ram_sel_r                   <= ramsync1_wb_sel_r >> 3;           // shift three bits right
                        ram_dat_r                   <= ramsync1_wb_dat_r >> 24;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_WR_SU;
                        end
                    else if ( ramsync1_wb_sel_r[3] )
                        begin
                        ram_state                   <= RAM_FSM_WRITE_BYTE_SU_STATE;
                        o_sram_cs                   <= 4'b0001;
                        {dummy[31:21],ram_sr_adr_r} <= ramsync1_wb_adr_r + 3;
                        io_sram_data_l              <= ramsync1_wb_dat_r[31:24];
                        io_sram_data_e              <= 'd1;
                        ram_pos_r                   <= 2'd3;
                        ram_sel_r                   <= 'd0;
                        ram_dat_r                   <= 'd0;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_WR_SU;
                        end
`ifdef AMBER_A25_CORE
                    else if ( ramsync1_wb_sel_r[WB_SWIDTH-1] )
                        begin
                        end
`endif
                    else
                        begin
                        ram_state                   <= RAM_FSM_WRITE_END_STATE;
                        o_sram_cs                   <= 4'b0000;
                        ram_sr_adr_r                <= 'd0;
                        io_sram_data_l              <= 'd0;
                        io_sram_data_e              <= 'd0;
                        end
                    end
                else if ( ramsync1_wb_state == WB_FSM_READ_STATE )
                    begin
                    if ( ramsync1_wb_sel_r[0] )
                        begin
                        // first least significant byte available
                        ram_state 	                <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs                   <=  4'b0001;
                        ram_sr_adr_r                <= ramsync1_wb_adr_r;
                        io_sram_data_e              <= 'd0;                             // Litte Endian
                        ram_sel_r                   <= ramsync1_wb_sel_r >> 1;
                        ram_pos_r                   <= 2'd0;
                        ram_dat_r                   <= 'd0;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_RD_SU;
                        end
                    else if ( ramsync1_wb_sel_r[1] )
                        begin
                        ram_state 	                <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs                   <=  4'b0001;
                        {dummy[31:21],ram_sr_adr_r} <= ramsync1_wb_adr_r + 1;
                        io_sram_data_e              <= 'd0;
                        ram_sel_r                   <= ramsync1_wb_sel_r >> 2;
                        ram_pos_r                   <= 2'd1;
                        ram_dat_r                   <= 'd0;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_RD_SU;
                        end
                    else if ( ramsync1_wb_sel_r[2] )
                        begin
                        ram_state 	                <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs                   <=  4'b0001;
                        {dummy[31:21],ram_sr_adr_r} <= ramsync1_wb_adr_r + 2;
                        io_sram_data_e              <= 'd0;
                        ram_sel_r                   <= ramsync1_wb_sel_r >> 3;
                        ram_pos_r                   <= 2'd2;
                        ram_dat_r                   <= 'd0;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_RD_SU;
                        end
                    else if ( ramsync1_wb_sel_r[3] )
                        begin
                        ram_state 	                <= RAM_FSM_READ_BYTE_SU_STATE;
                        o_sram_cs                   <=  4'b0001;
                        {dummy[31:21],ram_sr_adr_r} <= ramsync1_wb_adr_r + 3;
                        io_sram_data_e              <= 'd0;
                        ram_sel_r                   <= 'd0;
                        ram_pos_r                   <= 2'd3;
                        ram_dat_r                   <= 'd0;
                        ram_cyc_ctr                 <= RAM_CYC_CTR_VALUE_RD_SU;
                        end
                    else
                        begin
                        ram_state                   <= RAM_FSM_READ_END_STATE;
                        o_sram_cs                   <= 4'b0000;
                        ram_sr_adr_r                <= 'd0;
                        io_sram_data_l              <= 'd0;
                        io_sram_data_e              <= 'd0;
                        ram_dat_out_r               <= 'd0;                     // reading w/o any selected bytes
                        end
                    end

            RAM_FSM_WRITE_BYTE_SU_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    ram_state                       <= RAM_FSM_WRITE_BYTE_HD_STATE;
                    o_sram_write                    <= 'd1;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_WR_HD;
                    end
                else
                    begin
                    ram_state                       <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    {dummy[31:3],ram_cyc_ctr}       <= ram_cyc_ctr - 1;
                    end
                end
					
            RAM_FSM_WRITE_BYTE_HD_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    o_sram_write    <= 'd0;
                    if ( ram_sel_r == 4'd0 )
                        begin
                        ram_state                   <= RAM_FSM_WRITE_END_STATE;
                        end
                    else
                        ram_state                   <= RAM_FSM_WRITE_LOOP_STATE;
                    end
                else
                    begin
                    ram_state                       <= RAM_FSM_WRITE_BYTE_HD_STATE;
                    {dummy[31:3],ram_cyc_ctr}       <= ram_cyc_ctr - 1;
                    end
                end

            RAM_FSM_WRITE_LOOP_STATE:
                begin
                if ( ram_sel_r[0] )
                    begin
                    ram_state                       <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    {dummy[31:21],ram_sr_adr_r}     <= ram_sr_adr_r + 1;
                    {dummy[31:8],io_sram_data_l}    <= ram_dat_r >> ({3'd0,ram_pos_r} << 3);
                    io_sram_data_e                  <= 'd1;
                    o_sram_write                    <= 'd0;
                    {dummy[31:2],ram_pos_r}         <= ram_pos_r + 1;
                    ram_sel_r                       <= ram_sel_r >> 1;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_WR_SU;
                    end
                else if ( ram_sel_r[1] )
                    begin
                    ram_state                       <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    {dummy[31:21],ram_sr_adr_r}     <= ram_sr_adr_r + 2;
                    {dummy[31:8],io_sram_data_l}    <= ram_dat_r >> ({3'd0,ram_pos_r} << 3);
                    io_sram_data_e                  <= 'd1;
                    o_sram_write                    <= 'd0;
                    {dummy[31:2],ram_pos_r}         <= ram_pos_r + 2;
                    ram_sel_r                       <= ram_sel_r >> 2;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_WR_SU;
                    end
                else if ( ram_sel_r[2] )
                    begin
                    ram_state                       <= RAM_FSM_WRITE_BYTE_SU_STATE;
                    {dummy[31:21],ram_sr_adr_r}     <= ram_sr_adr_r + 3;
                    {dummy[31:8],io_sram_data_l}    <= ram_dat_r >> ({3'd0,ram_pos_r} << 3);
                    io_sram_data_e                  <= 'd1;
                    o_sram_write                    <= 'd0;
                    {dummy[31:2],ram_pos_r}         <= ram_pos_r + 3;
                    ram_sel_r                       <= ram_sel_r >> 3;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_WR_SU;
                    end
`ifdef AMBER_A25_CORE
                else if ( ram_sel_r[WB_SWIDTH-2] )
                    begin
                    end
`endif
//              else                                                            // dead code
//                  begin
//                  ram_state           <= RAM_FSM_WRITE_END_STATE;
//                  end
                end
					
            RAM_FSM_WRITE_END_STATE:
                begin
                if ( ramsync1_wb_state <= WB_FSM_READY_STATE )
                    begin
                    ram_state                       <= RAM_FSM_READY_STATE;
                    o_sram_cs                       <= 4'b0000;
                    o_sram_read                     <= 'd0;
                    o_sram_write  	                <= 'd0;
                    ram_sr_adr_r                    <= 'd0;
                    io_sram_data_l                  <= 'd0;
                    io_sram_data_e                  <= 'd0;
                    end
                end 

            RAM_FSM_READ_BYTE_SU_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    ram_state                       <= RAM_FSM_READ_BYTE_HD_STATE;
                    o_sram_read                     <= 'd1;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_RD_HD;
                    end
                else
                    begin
                    ram_state                       <= RAM_FSM_READ_BYTE_SU_STATE;
                    {dummy[31:3],ram_cyc_ctr}       <= ram_cyc_ctr - 1;
                    end
                end

            RAM_FSM_READ_BYTE_HD_STATE:
                begin
                if ( ram_cyc_ctr == 0 )
                    begin
                    o_sram_read                     <= 'd0;
                    ram_dat_r                       <= ram_dat_r | ({24'd0,io_sram_data} << ({3'd0,ram_pos_r} << 3));
                    if ( ram_sel_r == 4'd0 )
                        begin
                        ram_state                   <= RAM_FSM_READ_END_STATE;
                        ram_dat_out_r               <= ram_dat_r | ({24'd0,io_sram_data} << ({3'd0,ram_pos_r} << 3));
                        end
                    else
                        ram_state                   <= RAM_FSM_READ_LOOP_STATE;
                    end
                else
                    begin
                    ram_state                       <= RAM_FSM_READ_BYTE_HD_STATE;
                    {dummy[31:3],ram_cyc_ctr}       <= ram_cyc_ctr - 1;
                    end
                end

            RAM_FSM_READ_LOOP_STATE:
                begin
                if ( ram_sel_r[0] )
                    begin
                    ram_state                       <= RAM_FSM_READ_BYTE_SU_STATE;
                    {dummy[31:21],ram_sr_adr_r}     <= ram_sr_adr_r + 1;
                    o_sram_read                     <= 'd0;
                    {dummy[31:2],ram_pos_r}         <= ram_pos_r + 1;
                    ram_sel_r                       <= ram_sel_r >> 1;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_RD_SU;
                    end
                else if ( ram_sel_r[1] )
                    begin
                    ram_state                       <= RAM_FSM_READ_BYTE_SU_STATE;
                    {dummy[31:21],ram_sr_adr_r}     <= ram_sr_adr_r + 2;
                    o_sram_read                     <= 'd0;
                    {dummy[31:2],ram_pos_r}         <= ram_pos_r + 2;
                    ram_sel_r                       <= ram_sel_r >> 2;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_RD_SU;
                    end
                else if ( ram_sel_r[2] )
                    begin
                    ram_state                       <= RAM_FSM_READ_BYTE_SU_STATE;
                    {dummy[31:21],ram_sr_adr_r}     <= ram_sr_adr_r + 3;
                    o_sram_read                     <= 'd0;
                    {dummy[31:2],ram_pos_r}         <= ram_pos_r + 3;
                    ram_sel_r                       <= ram_sel_r >> 3;
                    ram_cyc_ctr                     <= RAM_CYC_CTR_VALUE_RD_SU;
                    end
`ifdef AMBER_A25_CORE
                else if ( ram_sel_r[WB_SWIDTH-2] )
`endif
//              else                                                            // dead code
//                  begin
//                  ram_state                       <= RAM_FSM_READ_END_STATE;
//                  ram_dat_out_r                   <= ram_dat_r;
//                  end
                end

            RAM_FSM_READ_END_STATE:
                begin
                if ( ramsync1_wb_state <= WB_FSM_READY_STATE )
                    begin
                    ram_state                       <= RAM_FSM_READY_STATE;
                    o_sram_cs                       <= 4'b0000;
                    o_sram_read                     <= 'd0;
                    o_sram_write  	                <= 'd0;
                    ram_sr_adr_r                    <= 'd0;
                    io_sram_data_l                  <= 'd0;
                    io_sram_data_e                  <= 'd0;
                    end
                end

        endcase


// SRAM signals
assign io_sram_data                                 = (io_sram_data_e) ?  io_sram_data_l : { SRAM_DATA_L{1'bz} };

// Wishbone async signals
assign o_wb_ack                                     = i_wb_stb && (write_request || wb_read_final_r);
assign o_wb_err                                     = 'd0;

assign o_monitor[ 1: 0] = wb_state;
assign o_monitor[ 5: 2] = ram_state;
assign o_monitor[ 6: 6] = i_sys_rst;
assign o_monitor[ 7: 7] = i_wb_clk;
assign o_monitor[ 8: 8] = i_ram_clk;
assign o_monitor[ 9: 9] = i_wb_cyc;
assign o_monitor[10:10] = i_wb_stb;
assign o_monitor[11:11] = o_wb_ack;
assign o_monitor[12:12] = o_wb_err;
assign o_monitor[13:13] = i_wb_we;
assign o_monitor[17:14] = i_wb_sel[3:0];
assign o_monitor[21:18] = i_wb_adr[3:0];
assign o_monitor[25:22] = i_wb_dat[3:0];
assign o_monitor[29:26] = o_wb_dat[3:0];
assign o_monitor[30:30] = write_request;
assign o_monitor[31:31] = write_request_r;
assign o_monitor[32:32] = read_request;
assign o_monitor[33:33] = read_request_r;
assign o_monitor[34:34] = wb_read_final_r;
assign o_monitor[35:35] = ready_r;
//assign o_monitor[36:36] = ramsync2_sys_rst;
assign o_monitor[36:36] = 1'b0;


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
