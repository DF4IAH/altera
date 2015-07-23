//////////////////////////////////////////////////////////////////
//                                                              //
//  ConfigData Module                                           //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Data access from/to ext. EEPROM and FPGA configuration      //
//  blocks.                                                     //
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

module cfg_dta  #(
parameter WB_DWIDTH   = 32,
parameter WB_SWIDTH   = 4,
parameter MADDR_WIDTH = 12
)(
input                       i_clk,
input                       i_sys_rst,

// WISHBONE SLAVE
input       [31:0]          i_wb_adr,
input       [WB_SWIDTH-1:0] i_wb_sel,
input                       i_wb_we,
output      [WB_DWIDTH-1:0] o_wb_dat,
input       [WB_DWIDTH-1:0] i_wb_dat,
input                       i_wb_cyc,
input                       i_wb_stb,
output                      o_wb_ack,
output                      o_wb_err

);


`include "register_addresses.vh"

// Wishbone interface
reg  [31:0]     wb_rdata32 = 'd0;
wire            wb_start_write;
wire            wb_start_read;
reg             wb_start_read_d1 = 'd0;
//wire [31:0]     wb_wdata32;


// ======================================================
// Wishbone Interface
// ======================================================

// Can't start a write while a read is completing. The ack for the read cycle
// needs to be sent first
assign wb_start_write = i_wb_stb && i_wb_we && !wb_start_read_d1;
assign wb_start_read  = i_wb_stb && !i_wb_we && !o_wb_ack;

always @( posedge i_clk )
    if ( i_sys_rst )
        wb_start_read_d1 <= 'd0;
    else
        wb_start_read_d1 <= wb_start_read;


assign o_wb_err = 1'd0;
assign o_wb_ack = i_wb_stb && ( wb_start_write || wb_start_read_d1 );

generate
if (WB_DWIDTH == 128) 
    begin : wb128
//    assign wb_wdata32   = i_wb_adr[3:2] == 2'd3 ? i_wb_dat[127:96] :
//                          i_wb_adr[3:2] == 2'd2 ? i_wb_dat[ 95:64] :
//                          i_wb_adr[3:2] == 2'd1 ? i_wb_dat[ 63:32] :
//                                                  i_wb_dat[ 31: 0] ;
                                                                                                                                            
    assign o_wb_dat    = {4{wb_rdata32}};
    end
else
    begin : wb32
//    assign wb_wdata32  = i_wb_dat;
    assign o_wb_dat    = wb_rdata32;
    end
endgenerate


// -------------------------------  
// external EEPROM / FLASH access engine
// -------------------------------  

    

// this sub-module is a quick replacement to read from a local "ROM" module w/ initialized program code

    generic_rom_byte_en #(
        .MADDR_WIDTH    ( 12                        ),
        .DATA_WIDTH     ( WB_DWIDTH                 )
    )
    u_mem (
        .i_clk          ( i_clk                     ),
        .i_address      ( i_wb_adr[MADDR_WIDTH+1:2] ),  // 4096 words, 32 bits
        .o_read_data    ( o_wb_dat                  )
    );

endmodule
