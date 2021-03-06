//////////////////////////////////////////////////////////////////
//                                                              //
//  Clock and Resets                                            //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Takes in the 200MHx board clock and generates the main      //
//  system clock. For the FPGA this is done with a PLL.         //
//                                                              //
//  Author(s):                                                  //
//      - Conor Santifort, csantifort.amber@gmail.com           //
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
`include "../system/system_config_defines.vh"
`include "../tb/global_timescale.vh"


//
// Clocks and Resets Module
//

module clocks_resets  (
input                       i_brd_rst,
input                       i_brd_clk,  
//input                       i_brd_clk_p,  
//input                       i_brd_clk_n,  
input                       i_ddr_calib_done,
output reg                  o_sys_rst,
output                      o_sys_clk,
output                      o_ram_clk

);


wire                        calib_done_33mhz;
wire                        rst0;
wire                        sys_rst;

assign sys_rst = rst0 || !calib_done_33mhz;

always @( posedge o_sys_clk )
    o_sys_rst   <= sys_rst;


`ifdef XILINX_FPGA

    localparam                  RST_SYNC_NUM = 25;
    wire                        pll_locked;
    wire                        clkfbout_clkfbin;
    reg [RST_SYNC_NUM-1:0]      rst0_sync_r    /* synthesis syn_maxfan = 10 */;
    reg [RST_SYNC_NUM-1:0]      ddr_calib_done_sync_r    /* synthesis syn_maxfan = 10 */;
    wire                        rst_tmp;
    wire                        pll_clk;

    (* KEEP = "TRUE" *)  wire brd_clk_ibufg;


    IBUFGDS # (  
         .DIFF_TERM  ( "TRUE"     ), 
         .IOSTANDARD ( "LVDS_25"  ))  // SP605 on chip termination of LVDS clock
         u_ibufgds_brd
        (
         .I  ( i_brd_clk_p    ),
         .IB ( i_brd_clk_n    ),
         .O  ( brd_clk_ibufg  )
         );
         
         
    assign rst0             = rst0_sync_r[RST_SYNC_NUM-1];
    assign calib_done_33mhz = ddr_calib_done_sync_r[RST_SYNC_NUM-1];
    assign o_ram_clk        = brd_clk_ibufg;


    `ifdef XILINX_SPARTAN6_FPGA
    // ======================================
    // Xilinx Spartan-6 PLL
    // ======================================
        PLL_ADV #
            (
             .BANDWIDTH          ( "OPTIMIZED"        ),
             .CLKIN1_PERIOD      ( 5                  ),
             .CLKIN2_PERIOD      ( 1                  ),
             .CLKOUT0_DIVIDE     ( 1                  ), 
             .CLKOUT1_DIVIDE     (                    ),
             .CLKOUT2_DIVIDE     ( `AMBER_CLK_DIVIDER ),   // = 800 MHz / LP_CLK_DIVIDER
             .CLKOUT3_DIVIDE     ( 1                  ),
             .CLKOUT4_DIVIDE     ( 1                  ),
             .CLKOUT5_DIVIDE     ( 1                  ),
             .CLKOUT0_PHASE      ( 0.000              ),
             .CLKOUT1_PHASE      ( 0.000              ),
             .CLKOUT2_PHASE      ( 0.000              ),
             .CLKOUT3_PHASE      ( 0.000              ),
             .CLKOUT4_PHASE      ( 0.000              ),
             .CLKOUT5_PHASE      ( 0.000              ),
             .CLKOUT0_DUTY_CYCLE ( 0.500              ),
             .CLKOUT1_DUTY_CYCLE ( 0.500              ),
             .CLKOUT2_DUTY_CYCLE ( 0.500              ),
             .CLKOUT3_DUTY_CYCLE ( 0.500              ),
             .CLKOUT4_DUTY_CYCLE ( 0.500              ),
             .CLKOUT5_DUTY_CYCLE ( 0.500              ),
             .COMPENSATION       ( "INTERNAL"         ),
             .DIVCLK_DIVIDE      ( 1                  ),
             .CLKFBOUT_MULT      ( 4                  ),   // 200 MHz clock input, x4 to get 800 MHz MCB
             .CLKFBOUT_PHASE     ( 0.0                ),
             .REF_JITTER         ( 0.005000           )
             )
            u_pll_adv
              (
               .CLKFBIN     ( clkfbout_clkfbin  ),
               .CLKINSEL    ( 1'b1              ),
               .CLKIN1      ( brd_clk_ibufg     ),
               .CLKIN2      ( 1'b0              ),
               .DADDR       ( 5'b0              ),
               .DCLK        ( 1'b0              ),
               .DEN         ( 1'b0              ),
               .DI          ( 16'b0             ),           
               .DWE         ( 1'b0              ),
               .REL         ( 1'b0              ),
               .RST         ( i_brd_rst          ),
               .CLKFBDCM    (                   ),
               .CLKFBOUT    ( clkfbout_clkfbin  ),
               .CLKOUTDCM0  (                   ),
               .CLKOUTDCM1  (                   ),
               .CLKOUTDCM2  (                   ),
               .CLKOUTDCM3  (                   ),
               .CLKOUTDCM4  (                   ),
               .CLKOUTDCM5  (                   ),
               .CLKOUT0     (                   ),
               .CLKOUT1     (                   ),
               .CLKOUT2     ( pll_clk           ),
               .CLKOUT3     (                   ),
               .CLKOUT4     (                   ),
               .CLKOUT5     (                   ),
               .DO          (                   ),
               .DRDY        (                   ),
               .LOCKED      ( pll_locked        )
               );

    `elsif XILINX_VIRTEX6_FPGA
    // ======================================
    // Xilinx Virtex-6 PLL
    // ======================================
        MMCM_ADV #
        (
         .CLKIN1_PERIOD      ( 5                    ),   // 200 MHz
         .CLKOUT2_DIVIDE     ( `AMBER_CLK_DIVIDER   ),
         .CLKFBOUT_MULT_F    ( 6                    )    // 200 MHz x 6 = 1200 MHz
         )
        u_pll_adv
          (
           .CLKFBOUT     ( clkfbout_clkfbin ),
           .CLKFBOUTB    (                  ),
           .CLKFBSTOPPED (                  ),
           .CLKINSTOPPED (                  ),
           .CLKOUT0      (                  ),
           .CLKOUT0B     (                  ),
           .CLKOUT1      (                  ),
           .CLKOUT1B     (                  ),
           .CLKOUT2      ( pll_clk          ),
           .CLKOUT2B     (                  ),
           .CLKOUT3      (                  ),
           .CLKOUT3B     (                  ),
           .CLKOUT4      (                  ),
           .CLKOUT5      (                  ),
           .CLKOUT6      (                  ),
           .DRDY         (                  ),
           .LOCKED       ( pll_locked       ),
           .PSDONE       (                  ),
           .DO           (                  ),
           .CLKFBIN      ( clkfbout_clkfbin ),
           .CLKIN1       ( brd_clk_ibufg    ),
           .CLKIN2       ( 1'b0             ),
           .CLKINSEL     ( 1'b1             ),
           .DCLK         ( 1'b0             ),
           .DEN          ( 1'b0             ),
           .DWE          ( 1'b0             ),
           .PSCLK        ( 1'd0             ),
           .PSEN         ( 1'd0             ),
           .PSINCDEC     ( 1'd0             ),
           .PWRDWN       ( 1'd0             ),
           .RST          ( i_brd_rst        ),
           .DI           ( 16'b0            ),
           .DADDR        ( 7'b0             ) 
           );
    `endif


    BUFG u_bufg_sys_clk (
         .O ( o_sys_clk  ),
         .I ( pll_clk    )
         );


    // ======================================
    // Synchronous reset generation
    // ======================================
    assign rst_tmp = i_brd_rst | ~pll_locked;

      // synthesis attribute max_fanout of rst0_sync_r is 10
    always @(posedge pll_clk or posedge rst_tmp)
        if (rst_tmp)
          rst0_sync_r <= {RST_SYNC_NUM{1'b1}};
        else
          // logical left shift by one (pads with 0)
          rst0_sync_r <= rst0_sync_r << 1;

    always @(posedge pll_clk or posedge rst_tmp)
        if (rst_tmp)
            ddr_calib_done_sync_r <= {RST_SYNC_NUM{1'b0}};
        else
            ddr_calib_done_sync_r <= {ddr_calib_done_sync_r[RST_SYNC_NUM-2:0], i_ddr_calib_done};


`elsif ALTERA_FPGA
    // ======================================
    // Altera Cyclone-III and MAX-10 PLL
    // ======================================

    localparam                  RST_SYNC_NUM = 25;
    wire                        pll_locked;
    reg [RST_SYNC_NUM-1:0]      rst0_sync_r              /* synthesis syn_maxfan = 10 */;
    reg [RST_SYNC_NUM-1:0]      ddr_calib_done_sync_r    /* synthesis syn_maxfan = 10 */;
    wire                        rst_tmp;
    wire                        pll_clk;
    (* KEEP = "TRUE" *)         wire brd_clk_ibufg;
    wire [0:0]                  sub_wire2 = 1'h0;
    wire [4:0]                  sub_wire3;
    wire                        sub_wire6;
    wire                        sub_wire0 = brd_clk_ibufg;
    wire [1:0]                  sub_wire1 = {sub_wire2, sub_wire0};
    //wire [1:1]                  sub_wire5 = sub_wire3[1:1];
    //wire [0:0]                  sub_wire4 = sub_wire3[0:0];
    //wire                        c0 = sub_wire4;
    //wire                        c1 = sub_wire5;

    assign o_ram_clk            = sub_wire3[0:0];
    assign pll_clk              = sub_wire3[1:1];
    assign rst0                 = rst0_sync_r[RST_SYNC_NUM-1];
    assign calib_done_33mhz     = ddr_calib_done_sync_r[RST_SYNC_NUM-1];
    assign pll_locked           = sub_wire6;

//    cycloneiii_io_ibuf #(
//         .bus_hold                    ( "false"                  ),
//         .differential_mode           ( "true"                   ),
//         .lpm_type                    ( "cycloneiii_io_ibuf"     ))  // SP605 on chip termination of LVDS clock
//         u_ibufgds_brd
//        ( 
//         .i                           ( i_brd_clk_p              ),
//         .ibar                        ( i_brd_clk_n              ),
//         .o                           ( brd_clk_ibufg            )
//         );
    assign brd_clk_ibufg        = i_brd_clk;                            // avoid using LVDS clock pair

    altpll #(
             .bandwidth_type          ( "AUTO"                   ),
             .clk0_divide_by          ( 8                        ),     // CLK0: 90 MHz memory clock: VCO/8
             .clk0_duty_cycle         ( 50                       ),
             .clk0_multiply_by        ( 36                       ),     // VCO1: 720 MHz = 20 MHz clock input x36
             .clk0_phase_shift        ( "0"                      ),
             .clk1_divide_by          ( 18                       ),     // CLK1: 40 MHz system clock: VCO/18      `AMBER_CLK_DIVIDER
             .clk1_duty_cycle         ( 50                       ),
             .clk1_multiply_by        ( 36                       ),     // VCO2: 720 MHz = 20 MHz clock input x 36
             .clk1_phase_shift        ( "0"                      ),
             .inclk0_input_frequency  ( 50000                    ),
	`ifdef ALTERA_MAX10_FPGA
             .intended_device_family  ( "MAX 10"                 ),
	`elsif ALTERA_CYCLONE3_FPGA
             .intended_device_family  ( "Cyclone III"            ),
	`endif
             .lpm_hint                ( "CBX_MODULE_PREFIX=amber"),
             .lpm_type                ( "altpll"                 ),
             .operation_mode          ( "NO_COMPENSATION"        ),
             .pll_type                ( "AUTO"                   ),
             .port_activeclock        ( "PORT_UNUSED"            ),
             .port_areset             ( "PORT_UNUSED"            ),
             .port_clkbad0            ( "PORT_UNUSED"            ),
             .port_clkbad1            ( "PORT_UNUSED"            ),
             .port_clkloss            ( "PORT_UNUSED"            ),
             .port_clkswitch          ( "PORT_UNUSED"            ),
             .port_configupdate       ( "PORT_UNUSED"            ),
             .port_fbin               ( "PORT_UNUSED"            ),
             .port_inclk0             ( "PORT_USED"              ),
             .port_inclk1             ( "PORT_UNUSED"            ),
             .port_locked             ( "PORT_USED"              ),
             .port_pfdena             ( "PORT_UNUSED"            ),
             .port_phasecounterselect ( "PORT_UNUSED"            ),
             .port_phasedone          ( "PORT_UNUSED"            ),
             .port_phasestep          ( "PORT_UNUSED"            ),
             .port_phaseupdown        ( "PORT_UNUSED"            ),
             .port_pllena             ( "PORT_UNUSED"            ),
             .port_scanaclr           ( "PORT_UNUSED"            ),
             .port_scanclk            ( "PORT_UNUSED"            ),
             .port_scanclkena         ( "PORT_UNUSED"            ),
             .port_scandata           ( "PORT_UNUSED"            ),
             .port_scandataout        ( "PORT_UNUSED"            ),
             .port_scandone           ( "PORT_UNUSED"            ),
             .port_scanread           ( "PORT_UNUSED"            ),
             .port_scanwrite          ( "PORT_UNUSED"            ),
             .port_clk0               ( "PORT_USED"              ),
             .port_clk1               ( "PORT_USED"              ),
             .port_clk2               ( "PORT_UNUSED"            ),
             .port_clk3               ( "PORT_UNUSED"            ),
             .port_clk4               ( "PORT_UNUSED"            ),
             .port_clk5               ( "PORT_UNUSED"            ),
             .port_clkena0            ( "PORT_UNUSED"            ),
             .port_clkena1            ( "PORT_UNUSED"            ),
             .port_clkena2            ( "PORT_UNUSED"            ),
             .port_clkena3            ( "PORT_UNUSED"            ),
             .port_clkena4            ( "PORT_UNUSED"            ),
             .port_clkena5            ( "PORT_UNUSED"            ),
             .port_extclk0            ( "PORT_UNUSED"            ),
             .port_extclk1            ( "PORT_UNUSED"            ),
             .port_extclk2            ( "PORT_UNUSED"            ),
             .port_extclk3            ( "PORT_UNUSED"            ),
             .self_reset_on_loss_lock ( "OFF"                    ),
             .width_clock             ( 5                        ))
        u_altpll
            (
             .inclk                   ( sub_wire1                ),
             .clk                     ( sub_wire3                ),
             .locked                  ( sub_wire6                ),
             .activeclock             (                          ),
             .areset                  ( 1'b0                     ),
             .clkbad                  (                          ),
             .clkena                  ( {6{1'b1}}                ),
             .clkloss                 (                          ),
             .clkswitch               ( 1'b0                     ),
             .configupdate            ( 1'b0                     ),
             .enable0                 (                          ),
             .enable1                 (                          ),
             .extclk                  (                          ),
             .extclkena               ( {4{1'b1}}                ),
             .fbin                    ( 1'b1                     ),
             .fbmimicbidir            (                          ),
             .fbout                   (                          ),
             .fref                    (                          ),
             .icdrclk                 (                          ),
             .pfdena                  ( 1'b1                     ),
             .phasecounterselect      ( {4{1'b1}}                ),
             .phasedone               (                          ),
             .phasestep               ( 1'b1                     ),
             .phaseupdown             ( 1'b1                     ),
             .pllena                  ( 1'b1                     ),
             .scanaclr                ( 1'b0                     ),
             .scanclk                 ( 1'b0                     ),
             .scanclkena              ( 1'b1                     ),
             .scandata                ( 1'b0                     ),
             .scandataout             (                          ),
             .scandone                (                          ),
             .scanread                ( 1'b0                     ),
             .scanwrite               ( 1'b0                     ),
             .sclkout0                (                          ),
             .sclkout1                (                          ),
             .vcooverrange            (                          ),
             .vcounderrange           (                          )
				 );

    cycloneiii_io_obuf #(
         .bus_hold                    ( "false"                  ),
         .open_drain_output           ( "false"                  ),
         .lpm_type                    ( "cycloneiii_io_obuf"     ))
	      u_bufg_sys_clk
        ( 
         .i                           ( pll_clk                  ),
         .o                           ( o_sys_clk                ),
         .obar                        (                          ),
         .oe                          ( 1'b1                     )
          `ifndef FORMAL_VERIFICATION
          //synthesis translate_off
          //synopsys translate_off
          `endif
          ,
         .seriesterminationcontrol    ( {16{1'b0}}               )
          `ifndef FORMAL_VERIFICATION
          //synopsys translate_on
          //synthesis translate_on
          `endif
          //synthesis translate_off
          //synopsys translate_off
          ,
         .devoe                       ( 1'b1                     )
          //synopsys translate_on
          //synthesis translate_on
         );


    // ======================================
    // Synchronous reset generation
    // ======================================
    assign rst_tmp = i_brd_rst | ~pll_locked
`ifdef ALTERA_FPGA
    /* synthesis maxfan = 10 */;
`else
    /* synthesis syn_maxfan = 10 */;
`endif
    always @(posedge pll_clk /* or posedge rst_tmp */)
        if (rst_tmp)
          rst0_sync_r <= {RST_SYNC_NUM{1'b1}};
        else
          // logical left shift by one (pads with 0)
          rst0_sync_r <= rst0_sync_r << 1;

    always @(posedge pll_clk /* or posedge rst_tmp */)
        if (rst_tmp)
            ddr_calib_done_sync_r <= {RST_SYNC_NUM{1'b0}};
        else
            ddr_calib_done_sync_r <= {ddr_calib_done_sync_r[RST_SYNC_NUM-2:0], i_ddr_calib_done};


`else

real      brd_clk_period = 6000;  // use starting value of 6000pS
real      pll_clk_period = 1000;  // use starting value of 1000pS
real      brd_temp;
reg       pll_clk_beh;
reg       sys_clk_beh;
integer   pll_div_count = 0;

// measure input clock period
initial
    begin
    @ (posedge i_brd_clk_p)
    brd_temp = $time;
    @ (posedge i_brd_clk_p)
    brd_clk_period = $time - brd_temp;
    pll_clk_period = brd_clk_period / 4;
    end
    
// Generate an 800MHz pll clock based off the input clock
always @( posedge i_brd_clk_p )
    begin
    pll_clk_beh = 1'd1;
    # ( pll_clk_period / 2 )
    pll_clk_beh = 1'd0;
    # ( pll_clk_period / 2 )

    pll_clk_beh = 1'd1;
    # ( pll_clk_period / 2 )
    pll_clk_beh = 1'd0;
    # ( pll_clk_period / 2 )

    pll_clk_beh = 1'd1;
    # ( pll_clk_period / 2 )
    pll_clk_beh = 1'd0;
    # ( pll_clk_period / 2 )

    pll_clk_beh = 1'd1;
    # ( pll_clk_period / 2 )
    pll_clk_beh = 1'd0;

    end

// Divide the pll clock down to get the system clock
always @( pll_clk_beh )
    begin
    if ( pll_div_count == (
        `AMBER_CLK_DIVIDER 
        * 2 ) - 1 )
        pll_div_count <= 'd0;
    else    
        pll_div_count <= pll_div_count + 1'd1;
        
    if ( pll_div_count == 0 )
        sys_clk_beh = 1'd1;
    else if ( pll_div_count == 
        `AMBER_CLK_DIVIDER 
        )
        sys_clk_beh = 1'd0;
    end

assign o_sys_clk        = sys_clk_beh;
assign rst0             = i_brd_rst;
assign calib_done_33mhz = 1'd1;
assign o_ram_clk        = i_brd_clk_p;

`endif


endmodule
