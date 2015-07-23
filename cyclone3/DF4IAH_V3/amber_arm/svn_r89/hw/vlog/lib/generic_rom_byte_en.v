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
parameter MADDR_WIDTH   = 12,
parameter DATA_WIDTH    = 32
)

(
input                           i_clk,
input       [MADDR_WIDTH-1:0]   i_address,
output reg  [DATA_WIDTH-1:0]    o_read_data
    );
    
reg         [DATA_WIDTH-1:0]    rom [0:2**MADDR_WIDTH-1];


// BIG ENDIAN
initial 
    begin
    `include "bootmem.vh"
    end


//assign o_read_data = i_write_enable ? {DATA_WIDTH{1'bx}} : rom[i_address];

always @ (posedge i_clk) begin
    o_read_data <= rom[i_address];
    end


endmodule
