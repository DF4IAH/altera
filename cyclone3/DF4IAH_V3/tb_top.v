//////////////////////////////////////////////////////////////////
// This is the VHDL test bench for the DF4IAH_V3 FPGA project   //
//                                                              //
// Verilog variant                                              //
//                                                              //
//  Author(s):                                                  //
//      - Ulrich Habel, espero7757 at gmx.net                   //
//                                                              //
//////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps


module tb_top #(
parameter NONE  = 0
)(
// Outputs and Inouts
output      [ 3:0]              o_led,

output                          o_uart0_rx,
output                          o_uart0_cts,

output                          o_i2c0_scl,
inout                           io_i2c0_sda,

output                          o_spi0_sclk,
output                          o_spi0_mosi,
output                          o_spi0_ss_n,

output      [ 3:0]              o_sram_cs_n,
output                          o_sram_read_n,
output                          o_sram_write_n,
output      [20:0]              o_sram_addr,
inout       [ 7:0]              io_sram_data,

output      [ 3:0]              o_mtxd,
output                          o_mtxen,
output                          o_mtxerr,
inout                           io_md,
output                          o_mdc,
output                          o_phy_reset_n,

output                          altera_reserved_tdo,

output      [ 2:0]              o_monitor
);


wire                            i_uart0_tx;
wire                            i_uart0_rts;
wire                            i_spi0_miso;
wire        [ 3:0]              i_mrxd;
wire                            i_mrxdv;
wire                            i_mcoll;
wire                            i_mcrs;
wire                            altera_reserved_tck;
wire                            altera_reserved_tdi;
wire                            altera_reserved_tms;

reg                             i_reset_n;
reg                             i_brd_clk;
reg                             i_mtx_clk;
reg                             i_mrx_clk;



// ======================================
// Device Under Test
// ======================================
top u_dut (
    .i_reset_n          ( i_reset_n         ),
    .i_brd_clk          ( i_brd_clk         ),
//  .i_brd_clk_p        ( i_brd_clk_p       ),
//  .i_brd_clk_n        ( i_brd_clk_n       ),

// Status LEDs
    .o_led              ( o_led             ),

// UART 0 Interface
    .i_uart0_tx         ( i_uart0_tx        ),
    .o_uart0_rx         ( o_uart0_rx        ),
    .i_uart0_rts        ( i_uart0_rts       ),
    .o_uart0_cts        ( o_uart0_cts       ),

// UART 1 Interface
//  .i_uart1_tx         ( i_uart1_tx        ),
//  .o_uart1_rx         ( o_uart1_rx        ),
//  .i_uart1_rts        ( i_uart1_rts       ),
//  .o_uart1_cts        ( o_uart1_cts       ),

// I2C Master 0 Master Interface
    .o_i2c0_scl         ( o_i2c0_scl        ),
    .io_i2c0_sda        ( io_i2c0_sda       ),

// SPI Master 0 Interface
    .o_spi0_sclk        ( o_spi0_sclk       ),
    .o_spi0_mosi        ( o_spi0_mosi       ),
    .i_spi0_miso        ( i_spi0_miso       ),
    .o_spi0_ss_n        ( o_spi0_ss_n       ),

// Xilinx Spartan 6 MCB DDR3 Interface
//  .io_ddr3_dq         ( io_ddr3_dq        ),
//  .o_ddr3_addr        ( o_ddr3_addr       ),
//  .o_ddr3_ba          ( o_ddr3_ba         ),
//  .o_ddr3_ras_n       ( o_ddr3_ras_n      ),
//  .o_ddr3_cas_n       ( o_ddr3_cas_n      ),
//  .o_ddr3_we_n        ( o_ddr3_we_n       ),
//  .o_ddr3_odt         ( o_ddr3_odt        ),
//  .o_ddr3_reset_n     ( o_ddr3_reset_n    ),
//  .o_ddr3_cke         ( o_ddr3_cke        ),
//  .o_ddr3_dm          ( o_ddr3_dm         ),
//  .io_ddr3_dqs_p      ( io_ddr3_dqs_p     ),
//  .io_ddr3_dqs_n      ( io_ddr3_dqs_n     ),
//  .o_ddr3_ck_p        ( o_ddr3_ck_p       ),
//  .o_ddr3_ck_n        ( o_ddr3_ck_n       ),
// ifdef XILINX_SPARTAN6_FPGA
//  .io_mcb3_rzq        ( io_mcb3_rzq       ),
// endif

// Altera SRAM 2Mx8 Interface
    .o_sram_cs_n        ( o_sram_cs_n       ),
    .o_sram_read_n      ( o_sram_read_n     ),
    .o_sram_write_n     ( o_sram_write_n    ),
    .o_sram_addr        ( o_sram_addr       ),
    .io_sram_data       ( io_sram_data      ),

// Ethmac B100 MAC to PHY Interface
    .i_mtx_clk          ( i_mtx_clk         ),
    .o_mtxd             ( o_mtxd            ),
    .o_mtxen            ( o_mtxen           ),
    .o_mtxerr           ( o_mtxerr          ),
    .i_mrx_clk          ( i_mrx_clk         ),
    .i_mrxd             ( i_mrxd            ),
    .i_mrxdv            ( i_mrxdv           ),
    .i_mrxerr           ( i_mrxdv           ),
    .i_mcoll            ( i_mcoll           ),
    .i_mcrs             ( i_mcrs            ),
    .io_md              ( io_md             ),
    .o_mdc              ( o_mdc             ),
    .o_phy_reset_n      ( o_phy_reset_n     ),

// JTAG Interface
    .altera_reserved_tck ( altera_reserved_tck ),
    .altera_reserved_tdi ( altera_reserved_tdi ),
    .altera_reserved_tms ( altera_reserved_tms ),
    .altera_reserved_tdo ( altera_reserved_tdo ),

    .o_monitor          ( o_monitor          )
);


initial 
    begin 
    i_reset_n = 0;

    i_brd_clk = 0;
    i_mtx_clk = 0;
    i_mrx_clk = 0;

    #1000000     i_reset_n = 1;                 // 1 us
    end


always
    begin
    #25000      i_brd_clk = !i_brd_clk;         // 20 MHz
    end

always
    begin
    #20000      i_mtx_clk = !i_mtx_clk;         // 25 MHz MMI @ 100 MBit
    end

always
    begin
      #200      ;
    #19800      i_mrx_clk = !i_mrx_clk;         // 25 MHz MMI @ 100 MBit
    end

integer             sram_data_ctr = 'd0;
reg         [7:0]   sram_data_reg = 'd0;
reg         [7:0]   sram_read_r   = 'd0;
always @ (posedge i_brd_clk)
    begin
    if ( !sram_read_r && o_sram_read_n )        // rising edge of o_sram_read_n
        begin
        sram_data_reg <= sram_data_ctr[7:0];
        sram_data_ctr <= sram_data_ctr + 1;
        end
    sram_read_r <= o_sram_read_n;
    end

assign io_sram_data = !o_sram_read_n ? sram_data_reg : 8'bz;


//always @ (posedge i_brd_clk)
//    if (reset == 1'b1) 
//        begin
//        count <= 0;
//        end 
//    else if ( enable == 1'b1 ) 
//        begin
//        count <= count + 1;
//    end

endmodule
