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
input      [DATA_WIDTH-1:0]     i_write_data,
input                           i_write_enable,
input      [ADDRESS_WIDTH-1:0]  i_address,
input      [DATA_WIDTH/8-1:0]   i_byte_enable,
output reg [DATA_WIDTH-1:0]     o_read_data
    );
    
    
reg         [DATA_WIDTH-1:0]    rom [0:2**ADDRESS_WIDTH-1];

initial 
    begin
    rom['h 000] = 32'h 0C94_6F00;
    rom['h 001] = 32'h 0C94_5603;
    rom['h 002] = 32'h 0C94_8C00;
    rom['h 003] = 32'h 0C94_8C00;
    rom['h 004] = 32'h 0C94_8C00;
    rom['h 005] = 32'h 0C94_8C00;
    rom['h 006] = 32'h 0C94_8C00;
    rom['h 007] = 32'h 0C94_8C00;
    rom['h 008] = 32'h 0C94_8C00;
    rom['h 009] = 32'h 0C94_8C00;
    rom['h 00a] = 32'h 0C94_8C00;
    rom['h 00b] = 32'h 0C94_8C00;
    rom['h 00c] = 32'h 0C94_8C00;
    rom['h 00d] = 32'h 0C94_2501;
    rom['h 00e] = 32'h 0C94_8C00;
    rom['h 00f] = 32'h 0C94_8C00;
    rom['h 010] = 32'h 0C94_6F00;
    rom['h 011] = 32'h 0C94_5603;
    rom['h 012] = 32'h 0C94_8C00;
    rom['h 013] = 32'h 0C94_8C00;
    rom['h 014] = 32'h 0C94_8C00;
    rom['h 015] = 32'h 0C94_8C00;
    rom['h 016] = 32'h 0C94_8C00;
    rom['h 017] = 32'h 0C94_8C00;
    rom['h 018] = 32'h 0C94_8C00;
    rom['h 019] = 32'h 0C94_8C00;
    rom['h 01a] = 32'h 0403_0904;
    rom['h 01b] = 32'h 2203_7700;
    rom['h 01c] = 32'h 7700_7700;
    rom['h 01d] = 32'h 2E00_7300;
    rom['h 01e] = 32'h 6400_7200;
    rom['h 01f] = 32'h 2D00_6B00;
    rom['h 020] = 32'h 6900_7400;
    rom['h 021] = 32'h 7300_2E00;
    rom['h 022] = 32'h 6E00_6500;
    rom['h 023] = 32'h 7400_2203;
    end


//assign o_read_data = i_write_enable ? {DATA_WIDTH{1'bx}} : rom[i_address];

always @ (posedge i_clk) begin
    o_read_data <= i_write_enable ? {DATA_WIDTH{1'bx}} : rom[i_address];
    end


endmodule
