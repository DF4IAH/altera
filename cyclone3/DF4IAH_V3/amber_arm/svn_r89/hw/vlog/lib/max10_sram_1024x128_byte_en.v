//////////////////////////////////////////////////////////////////
//                                                              //
//  RAM-based data cache for Amber Core                         //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Contains 1024 lines of 128 bit wide DATA cache              //
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


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module max10_sram_1024x128_byte_en
#(
parameter DATA_WIDTH    = 128,
parameter ADDRESS_WIDTH = 10,
parameter BLOCK_WIDTH   = 128,
parameter INIT_FILE     = "bootram.hex"
)

(
	i_clk,
	i_write_data,
	i_write_enable,
	i_address,
	i_byte_enable,
	o_read_data
);

	input                           i_clk;
	input      [DATA_WIDTH-1:0]     i_write_data;
	input                           i_write_enable;
	input      [ADDRESS_WIDTH-1:0]  i_address;
	input      [(DATA_WIDTH/8)-1:0] i_byte_enable;
	output     [DATA_WIDTH-1:0]     o_read_data;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	     i_clk;
	tri0	     i_write_enable;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

   genvar   i;

	wire [DATA_WIDTH-1:0] sub_wire;
	wire [DATA_WIDTH-1:0] o_read_data = sub_wire[DATA_WIDTH-1:0];

generate
    for (i=0;i<(DATA_WIDTH/BLOCK_WIDTH);i=i+1) begin : u_gen
        fiftyfivenm_ram_block #(
               .clk0_core_clock_enable        ( "none"                  ),
               .clk0_input_clock_enable       ( "none"                  ),
               .clk0_output_clock_enable      ( "none"                  ),
               .connectivity_checking         ( "OFF"                   ),
               .init_file                     ( INIT_FILE               ),
               .logical_ram_name              ( "ALTSYNCRAM"            ),
               .mixed_port_feed_through_mode  ( "old"                   ),
               .operation_mode                ( "dual_port"             ),
               .port_a_address_width          ( 8                       ),
               .port_a_data_width             ( BLOCK_WIDTH             ),
               .port_a_first_address          ( 0                       ),
               .port_a_first_bit_number       ( BLOCK_WIDTH*i           ),
               .port_a_last_address           ( 2**ADDRESS_WIDTH-1      ),
               .port_a_logical_ram_depth      ( 2**ADDRESS_WIDTH        ),
               .port_a_logical_ram_width      ( DATA_WIDTH              ),
               .port_b_address_clear          ( "none"                  ),
               .port_b_address_clock          ( "clock0"                ),
               .port_b_address_width          ( 8                       ),
               .port_b_data_out_clear         ( "none"                  ),
               .port_b_data_out_clock         ( "clock0"                ),
               .port_b_data_width             ( BLOCK_WIDTH             ),
               .port_b_first_address          ( 0                       ),
               .port_b_first_bit_number       ( BLOCK_WIDTH*i           ),
               .port_b_last_address           ( 2**ADDRESS_WIDTH-1      ),
               .port_b_logical_ram_depth      ( 2**ADDRESS_WIDTH        ),
               .port_b_logical_ram_width      ( DATA_WIDTH              ),
               .port_b_read_enable_clock      ( "clock0"                ),
               .power_up_uninitialized        ( "false"                 ),
               .ram_block_type                ( "M9K"                   ),
               .lpm_type                      ( "fiftyfivenm_ram_block" )
        ) 
        u_ram_byte (
            .clk0(i_clk),
            .portaaddr(i_address),
            .portadatain({i_write_data[(BLOCK_WIDTH*(i+1)-1):(BLOCK_WIDTH*i)]}),
            .portadataout(),
            .portawe(i_write_enable),
            .portbaddr(i_address),
            .portbdataout(sub_wire[(BLOCK_WIDTH*(i+1)-1):(BLOCK_WIDTH*i)]),
            .portbre(1'b1)
            `ifndef FORMAL_VERIFICATION
            // synopsys translate_off
            `endif
            ,
            .clk1(1'b0),
            .clr0(1'b0),
            .clr1(1'b0),
            .ena0(1'b1),
            .ena1(1'b1),
            .ena2(1'b1),
            .ena3(1'b1),
            .portaaddrstall(1'b0),
            .portabyteenamasks(i_byte_enable[(BLOCK_WIDTH*(i+1)-1):(BLOCK_WIDTH*i)]),
            .portare(1'b1),
            .portbaddrstall(1'b0),
            .portbbyteenamasks({BLOCK_WIDTH/8{1'b1}}),
            .portbdatain({BLOCK_WIDTH{1'b0}}),
            .portbwe(1'b0)
            `ifndef FORMAL_VERIFICATION
            // synopsys translate_on
            `endif
            // synopsys translate_off
            ,
            .devclrn(1'b1),
            .devpor(1'b1)
            // synopsys translate_on
        );

    end
endgenerate

//synopsys translate_off
initial
    begin
    if ( DATA_WIDTH    != 128 ) $display("%M Warning: Incorrect parameter DATA_WIDTH");
    if ( ADDRESS_WIDTH != 10  ) $display("%M Warning: Incorrect parameter ADDRESS_WIDTH");
    end
//synopsys translate_on

endmodule
