//////////////////////////////////////////////////////////////////
//                                                              //
//  Boot-RAM for Amber Core                                     //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Contains 4096 addresses of 32 bit wide DATA                 //
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


//synthesis translate_off
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
//synthesis translate_on
module max10_sram_1x8_byte_en
#(
parameter DATA_WIDTH    = 8,
parameter INIT_FILE     = "none.hex"
)

(
	i_clk,
	i_write_data,
	i_write_enable,
	o_read_data
);

	input                           i_clk;
	input      [DATA_WIDTH-1:0]     i_write_data;
	input                           i_write_enable;
	output     [DATA_WIDTH-1:0]     o_read_data;
`ifndef ALTERA_RESERVED_QIS
//synthesis translate_off
//synopsys translate_off
`endif
	tri1	     i_clk;
	tri0	     i_write_enable;
`ifndef ALTERA_RESERVED_QIS
//synopsys translate_on
//synthesis translate_on
`endif


	wire [DATA_WIDTH-1:0] sub_wire;
	wire [DATA_WIDTH-1:0] o_read_data = sub_wire[DATA_WIDTH-1:0];

genvar   i;
generate
    for (i=0;i<1;i=i+1) begin : u_gen
        fiftyfivenm_ram_block #(
               .clk0_core_clock_enable        ( "none"                  ),
               .clk0_input_clock_enable       ( "none"                  ),
               .clk0_output_clock_enable      ( "none"                  ),
               .connectivity_checking         ( "OFF"                   ),
               .init_file                     ( INIT_FILE               ),
               .logical_ram_name              ( "ALTSYNCRAM"            ),
               .mixed_port_feed_through_mode  ( "old"                   ),
               .operation_mode                ( "dual_port"             ),
               .port_a_address_width          ( 0                       ),
               .port_a_data_width             ( DATA_WIDTH              ),
               .port_a_first_address          ( 0                       ),
               .port_a_first_bit_number       ( DATA_WIDTH*i            ),
               .port_a_last_address           ( 0                       ),
               .port_a_logical_ram_depth      ( 1                       ),
               .port_a_logical_ram_width      ( DATA_WIDTH              ),
               .port_b_address_clear          ( "none"                  ),
               .port_b_address_clock          ( "clock0"                ),
               .port_b_address_width          ( 8                       ),
               .port_b_data_out_clear         ( "none"                  ),
               .port_b_data_out_clock         ( "clock0"                ),
               .port_b_data_width             ( DATA_WIDTH              ),
               .port_b_first_address          ( 0                       ),
               .port_b_first_bit_number       ( DATA_WIDTH*i            ),
               .port_b_last_address           ( 0                       ),
               .port_b_logical_ram_depth      ( 1                       ),
               .port_b_logical_ram_width      ( DATA_WIDTH              ),
               .port_b_read_enable_clock      ( "clock0"                ),
               .power_up_uninitialized        ( "false"                 ),
               .ram_block_type                ( "M9K"                   ),
               .lpm_type                      ( "fiftyfivenm_ram_block" )
        ) 
        u_ram_byte (
            .clk0(i_clk),
            .portaaddr(1'b0),
            .portadatain({i_write_data[(DATA_WIDTH*(i+1)-1):(DATA_WIDTH*i)]}),
            .portadataout(),
            .portawe(i_write_enable),
            .portbaddr(1'b0),
            .portbdataout(sub_wire[(DATA_WIDTH*(i+1)-1):(DATA_WIDTH*i)]),
            .portbre(1'b1)
            `ifndef FORMAL_VERIFICATION
            //synthesis translate_off
            //synopsys translate_off
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
            //.portabyteenamasks(i_byte_enable[(DATA_WIDTH*(i+1)-1):(DATA_WIDTH*i)]),
            .portare(1'b1),
            .portbaddrstall(1'b0),
            //.portbbyteenamasks({DATA_WIDTH/8{1'b1}}),
            .portbdatain({DATA_WIDTH{1'b0}}),
            .portbwe(1'b0)
            `ifndef FORMAL_VERIFICATION
            //synopsys translate_on
            //synthesis translate_on
            `endif
            //synthesis translate_off
            //synopsys translate_off
            ,
            .devclrn(1'b1),
            .devpor(1'b1)
            //synopsys translate_on
            //synthesis translate_on
        );

    end
endgenerate

//synthesis translate_off
//synopsys translate_off
initial
    begin
    if ( DATA_WIDTH    != 8  ) $display("%M Warning: Incorrect parameter DATA_WIDTH");
    end
//synopsys translate_on
//synthesis translate_on

endmodule
