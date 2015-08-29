//////////////////////////////////////////////////////////////////
//                                                              //
//  Boot-RAM for Amber Core                                     //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Contains 1 address of 8 bit wide DATA                       //
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
module cyc3_sram_1x8_byte_en
#(
parameter DATA_WIDTH         = 8,
parameter INIT_FILE          = "none.hex"
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

genvar   i;
generate
    for (i=0;i<1;i=i+1) begin : u_gen
        altsyncram #(
               .address_reg_b                      ( "CLOCK0"           ),
               .byte_size                          ( 8                  ),
               .byteena_reg_b                      ( "CLOCK0"           ),
               .indata_reg_b                       ( "CLOCK0"           ),
               .init_file                          ( INIT_FILE          ),
               .lpm_type                           ( "altsyncram"       ),
               .maximum_depth                      ( 1                  ),
               .numwords_a                         ( 1                  ),
               .numwords_b                         ( 1                  ),
               .operation_mode                     ( "BIDIR_DUAL_PORT"  ),
               .outdata_reg_a                      ( "UNREGISTERED"     ),
               .outdata_reg_b                      ( "UNREGISTERED"     ),
               .ram_block_type                     ( "M9K"              ),
               .read_during_write_mode_mixed_ports ( "OLD_DATA"         ),
               .read_during_write_mode_port_a      ( "OLD_DATA"         ),
               .read_during_write_mode_port_b      ( "OLD_DATA"         ),
               .width_a                            ( DATA_WIDTH         ),
               .width_b                            ( DATA_WIDTH         ),
//             .width_byteena_a                    ( DATA_WIDTH/8       ),
//             .width_byteena_b                    ( DATA_WIDTH/8       ),
               .widthad_a                          ( 1                  ),
               .widthad_b                          ( 1                  ),
               .wrcontrol_wraddress_reg_b          ( "CLOCK0"           )
        ) 
        u_ram_byte (
            .address_a (1'b0),
            .address_b (1'b0),
            .addressstall_a (1'b0),
            .addressstall_b (1'b0),
//          .byteena_a (i_byte_enable),
//          .byteena_b (i_byte_enable),
            .clock0 (i_clk),
//          .clock1 (1'b0),
            .clocken0 (1'b1),
//          .clocken1 (1'b0),
//          .clocken2 (1'b0),
//          .clocken3 (1'b0),
            .data_a (i_write_data),
            .data_b ({DATA_WIDTH{1'b0}}),
            .q_a (),
            .q_b (o_read_data),
            .rden_a (1'b0),
            .rden_b (1'b1),
            .wren_a (i_write_enable),
            .wren_b (1'b0)
//          .aclr0 (1'b0),
//          .aclr1 (1'b0),
//          .eccstatus ()
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
