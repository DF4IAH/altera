//////////////////////////////////////////////////////////////////
// This is the VHDL top entity for the DF4IAH_V3 FPGA project   //
//                                                              //
// Verilog variant                                              //
//                                                              //
//  Author(s):                                                  //
//      - Ulrich Habel, espero7757 at gmx.net                   //
//                                                              //
//////////////////////////////////////////////////////////////////

`include "amber_arm/svn_r89/hw/vlog/tb/global_timescale.vh"
`include "amber_arm/svn_r89/hw/vlog/system/system_config_defines.vh"


module top #(
parameter NONE  = 0
)(
// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!

// Reset Pin
input		                    i_reset_n,

// Clock from oscillator
input		                    i_brd_clk,
//input		                    i_brd_clk_p,
//input		                    i_brd_clk_n,

// Status LEDs
output	    [ 3:0]	            o_led,
		
// UART 0 Interface
input		                    i_uart0_tx,
output		                    o_uart0_rx,
input		                    i_uart0_rts,
output		                    o_uart0_cts,

// UART 1 Interface
//input		                    i_uart1_tx,
//output		                o_uart1_rx,
//input		                    i_uart1_rts,
//output		                o_uart1_cts,

// I2C Master 0 Master Interface
output                          o_i2c0_scl,
inout                           io_i2c0_sda,

// SPI Master 0 Interface
output                          o_spi0_sclk,
output                          o_spi0_mosi,
input                           i_spi0_miso,
output                          o_spi0_ss_n,

// Xilinx Spartan 6 MCB DDR3 Interface
//inout       [15:0]            io_ddr3_dq,
//output      [12:0]            o_ddr3_addr,
//output      [ 2:0]            o_ddr3_ba,
//output		                o_ddr3_ras_n,
//output		                o_ddr3_cas_n,
//output		                o_ddr3_we_n,
//output		                o_ddr3_odt,
//output		                o_ddr3_reset_n,
//output		                o_ddr3_cke,
//output      [ 1:0]            o_ddr3_dm,
//inout       [ 1:0]            io_ddr3_dqs_p,
//inout       [ 1:0]            io_ddr3_dqs_n,
//output		                o_ddr3_ck_p,
//output		                o_ddr3_ck_n,
// ifdef XILINX_SPARTAN6_FPGA
//inout	                        io_mcb3_rzq,
// endif

// Altera SRAM 2Mx8 Interface
output      [ 3:0]              o_sram_cs_n,
output                          o_sram_read_n,
output                          o_sram_write_n,
output      [20:0]              o_sram_addr,
inout       [ 7:0]              io_sram_data,

// Ethmac B100 MAC to PHY Interface
input                           i_mtx_clk,
output      [ 3:0]              o_mtxd,
output                          o_mtxen,
output                          o_mtxerr,
input                           i_mrx_clk,
input       [ 3:0]              i_mrxd,
input                           i_mrxdv,
input                           i_mrxerr,
input                           i_mcoll,
input                           i_mcrs,
inout                           io_md,
output                          o_mdc,
output                          o_phy_reset_n,

// JTAG Interface
input                           altera_reserved_tck,
input                           altera_reserved_tdi,
input                           altera_reserved_tms,
output                          altera_reserved_tdo,

//output    [ 2:0]              o_monitor
output      [36: 0]             o_monitor
// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
);


integer                         clk_count;
integer                         testfail;


wire                            i_uart1_rts;
wire                            o_uart1_rx;
wire                            o_uart1_cts;
wire                            i_uart1_tx;
wire        [15:0]              ddr3_dq;
wire        [12:0]              ddr3_addr;
wire        [ 2:0]              ddr3_ba;
wire                            ddr3_ras_n;
wire                            ddr3_cas_n;
wire                            ddr3_we_n;
wire                            ddr3_odt;
wire                            ddr3_reset_n;
wire                            ddr3_cke;
wire        [ 1:0]              ddr3_dm;
wire        [ 1:0]              ddr3_dqs_p;
wire        [ 1:0]              ddr3_dqs_n;
wire                            ddr3_ck_p;
wire                            ddr3_ck_n;
`ifdef XILINX_SPARTAN6_FPGA
wire                            mcb3_rzq;
`endif

reg                             i_reset_n_r     = 'd0;
reg                             brd_rst         = 'd0;

wire        [3:0]               o_sram_cs;
assign o_sram_cs_n = o_sram_cs ^ 4'b1111;

wire                            o_sram_read;
assign o_sram_read_n = !o_sram_read;

wire                            o_sram_write;
assign o_sram_write_n = !o_sram_write;


//a23_core u_a23_core_0 ( 
//    .i_clk              ( C_40MHZ           ),
//    .i_irq              ( amber_i_irq       ),      // Interrupt request, active high
//    .i_firq             ( amber_i_firq      ),      // Fast Interrupt request, active high
//    .i_system_rdy       ( amber_i_system_rdy),      // Amber is stalled when this is low
//
//    // Wishbone Master I/F
//    .o_wb_adr           ( o_wb_adr          ),
//    .o_wb_adr           ( o_wb_adr          ),
//    .o_wb_sel           ( o_wb_sel          ),
//    .o_wb_we            ( o_wb_we           ),
//    .i_wb_dat           ( i_wb_dat          ),
//    .o_wb_dat           ( o_wb_dat          ),
//    .o_wb_cyc           ( o_wb_cyc          ),
//    .o_wb_stb           ( o_wb_stb          ),
//    .i_wb_ack           ( i_wb_ack          ),
//    .i_wb_err           ( i_wb_err          ),
//);



// ======================================
// System Module
// ======================================
system u_system (
    .brd_rst            ( brd_rst           ),
    .brd_clk            ( i_brd_clk         ),
//  .brd_clk_p          ( i_brd_clk_p       ),
//  .brd_clk_n          ( i_brd_clk_n       ),


// UART 0 Interface
    .i_uart0_rts        ( i_uart0_rts       ),
    .o_uart0_rx         ( o_uart0_rx        ),
    .o_uart0_cts        ( o_uart0_cts       ),
    .i_uart0_tx         ( i_uart0_tx        ),

// UART 1 Interface
    .i_uart1_rts        ( i_uart1_rts       ),
    .o_uart1_rx         ( o_uart1_rx        ),
    .o_uart1_cts        ( o_uart1_cts       ),
    .i_uart1_tx         ( i_uart1_tx        ),

// I2C Master 0 Master Interface
    .o_i2c0_scl         ( o_i2c0_scl        ),
    .io_i2c0_sda        ( io_i2c0_sda       ),

// SPI Master 0 Interface
    .o_spi0_sclk        ( o_spi0_sclk       ),
    .o_spi0_mosi        ( o_spi0_mosi       ),
    .i_spi0_miso        ( i_spi0_miso       ),
    .o_spi0_ss_n        ( o_spi0_ss_n       ),

// Xilinx Spartan 6 MCB DDR3 Interface
    .ddr3_dq            ( ddr3_dq           ),
    .ddr3_addr          ( ddr3_addr         ),
    .ddr3_ba            ( ddr3_ba           ),
    .ddr3_ras_n         ( ddr3_ras_n        ),
    .ddr3_cas_n         ( ddr3_cas_n        ),
    .ddr3_we_n          ( ddr3_we_n         ),
    .ddr3_odt           ( ddr3_odt          ),
    .ddr3_reset_n       ( ddr3_reset_n      ),
    .ddr3_cke           ( ddr3_cke          ),
    .ddr3_dm            ( ddr3_dm           ),
    .ddr3_dqs_p         ( ddr3_dqs_p        ),
    .ddr3_dqs_n         ( ddr3_dqs_n        ),
    .ddr3_ck_p          ( ddr3_ck_p         ),
    .ddr3_ck_n          ( ddr3_ck_n         ),

`ifdef XILINX_SPARTAN6_FPGA
//  .mcb3_rzq           ( mcb3_rzq          ),
`endif


// Ethmac B100 MAC to PHY Interface
    .mtx_clk_pad_i      ( i_mtx_clk         ),
    .mtxd_pad_o         ( o_mtxd            ),
    .mtxen_pad_o        ( o_mtxen           ),
    .mtxerr_pad_o       ( o_mtxerr          ),
    .mrx_clk_pad_i      ( i_mrx_clk         ),
    .mrxd_pad_i         ( i_mrxd            ),
    .mrxdv_pad_i        ( i_mrxdv           ),
    .mrxerr_pad_i       ( i_mrxerr          ),
    .mcoll_pad_i        ( i_mcoll           ),
    .mcrs_pad_i         ( i_mcrs            ),
    .md_pad_io          ( io_md             ),
    .mdc_pad_o          ( o_mdc             ),
    .phy_reset_n        ( o_phy_reset_n     ),

`ifdef ALTERA_FPGA
// Altera SRAM 2Mx8 Interface
    .o_sram_cs          ( o_sram_cs         ),
    .o_sram_read        ( o_sram_read       ),
    .o_sram_write       ( o_sram_write      ),
    .o_sram_addr        ( o_sram_addr       ),
    .io_sram_data       ( io_sram_data      ),
`endif

    .led                ( o_led             ),
    .o_monitor          ( o_monitor         )
);



// Synchronizing reset
//
always @ ( posedge i_brd_clk )
    begin
    brd_rst     <= !i_reset_n_r;
    i_reset_n_r <=  i_reset_n;

    clk_count = clk_count + 1;
    end

// Monitoring
//
//assign o_monitor[0] = !i_reset_n;
//assign o_monitor[1] = !i_reset_n_r;
//assign o_monitor[2] =  brd_rst;


initial 
    begin 
    testfail = 1'd0;
    clk_count = 0;
    end


endmodule
