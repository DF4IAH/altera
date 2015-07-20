//////////////////////////////////////////////////////////////////
//                                                              //
//  Generic Library ROM with local code conten                  //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Data is returned per case switches.                         //
//                                                              //
//  Author(s):                                                  //
//      - Ulrich Habel, espero7757@gmx.net                      //
//                                                              //
//////////////////////////////////////////////////////////////////
//                                                              //
// Copyright (C) 2010 Authors and OPENCORES.ORG                 //
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


module generic_rom_byte_en
#(
parameter DATA_WIDTH    = 32,
parameter ADDRESS_WIDTH = 12
)

(
input                           i_clk,
input       [DATA_WIDTH-1:0]    i_write_data,
input                           i_write_enable,
input       [ADDRESS_WIDTH-1:0] i_address,
input       [DATA_WIDTH/8-1:0]  i_byte_enable,
output reg  [DATA_WIDTH-1:0]    o_read_data
    );
    
    
reg         [DATA_WIDTH-1:0]    rom [0:2**ADDRESS_WIDTH-1];

initial 
    begin
    // BIG ENDIAN
    rom['h 000] = 32'h EA00_0006;   // addr: 0x0000
    rom['h 001] = 32'h EAFF_FFFE;   // addr: 0x0004
    rom['h 002] = 32'h EAFF_FFFE;   // addr: 0x0008
    rom['h 003] = 32'h EAFF_FFFE;   // addr: 0x000c
    rom['h 004] = 32'h EAFF_FFFE;   // addr: 0x0010
    rom['h 005] = 32'h EAFF_FFFE;   // addr: 0x0014
    rom['h 006] = 32'h EAFF_FFFE;   // addr: 0x0018
    rom['h 007] = 32'h EAFF_FFFE;   // addr: 0x001c
    rom['h 008] = 32'h E59F_D004;   // addr: 0x0020
    rom['h 009] = 32'h EB00_0008;   // addr: 0x0024
    rom['h 00a] = 32'h EAFF_FFFE;   // addr: 0x0028
    rom['h 00b] = 32'h 0000_3FFC;   // addr: 0x002c
    rom['h 00c] = 32'h E59F_2010;   // addr: 0x0030
    rom['h 00d] = 32'h E592_3000;   // addr: 0x0034
    rom['h 00e] = 32'h E283_1004;   // addr: 0x0038
    rom['h 00f] = 32'h E582_1000;   // addr: 0x003c
    rom['h 010] = 32'h E583_0000;   // addr: 0x0040
    rom['h 011] = 32'h E1A0_F00E;   // addr: 0x0044
    rom['h 012] = 32'h 0000_0098;   // addr: 0x0048
    rom['h 013] = 32'h E92D_47F0;   // addr: 0x004c
    rom['h 014] = 32'h E3E0_6002;   // addr: 0x0050
    rom['h 015] = 32'h E3A0_5009;   // addr: 0x0054
    rom['h 016] = 32'h E3A0_4000;   // addr: 0x0058
    rom['h 017] = 32'h E1A0_9005;   // addr: 0x005c
    rom['h 018] = 32'h E1A0_8004;   // addr: 0x0060
    rom['h 019] = 32'h E3A0_7003;   // addr: 0x0064
    rom['h 01a] = 32'h E088_8009;   // addr: 0x0068
    rom['h 01b] = 32'h E1A0_0008;   // addr: 0x006c
    rom['h 01c] = 32'h EBFF_FFEE;   // addr: 0x0070
    rom['h 01d] = 32'h E089_9006;   // addr: 0x0074
    rom['h 01e] = 32'h E257_7001;   // addr: 0x0078
    rom['h 01f] = 32'h 1AFF_FFF9;   // addr: 0x007c
    rom['h 020] = 32'h E084_4085;   // addr: 0x0080
    rom['h 021] = 32'h E245_5003;   // addr: 0x0084
    rom['h 022] = 32'h E296_6001;   // addr: 0x0088
    rom['h 023] = 32'h 1AFF_FFF2;   // addr: 0x008c
    rom['h 024] = 32'h E1A0_0004;   // addr: 0x0090
    rom['h 025] = 32'h E8BD_87F0;   // addr: 0x0094
    rom['h 026] = 32'h 1000_0000;   // addr: 0x0098
    end


//assign o_read_data = i_write_enable ? {DATA_WIDTH{1'bx}} : rom[i_address];

always @ (posedge i_clk) begin
    o_read_data <= i_write_enable ? {DATA_WIDTH{1'bx}} : rom[i_address];
    end


endmodule
