onerror {resume}
quietly virtual signal -install /tb_top { /tb_top/o_monitor[1:0]} MONITOR_wb_state
quietly virtual signal -install /tb_top { /tb_top/o_monitor[5:2]} MONITOR_ram_state
quietly virtual signal -install /tb_top {/tb_top/o_monitor[6]  } MONITOR_i_sys_rst
quietly virtual signal -install /tb_top {/tb_top/o_monitor[7]  } MONITOR_i_wb_clk
quietly virtual signal -install /tb_top {/tb_top/o_monitor[8]  } MONITOR_i_ram_clk
quietly virtual signal -install /tb_top {/tb_top/o_monitor[9]  } MONITOR_i_wb_cyc
quietly virtual signal -install /tb_top {/tb_top/o_monitor[10]  } MONITOR_i_wb_stb
quietly virtual signal -install /tb_top {/tb_top/o_monitor[11]  } MONITOR_o_wb_ack
quietly virtual signal -install /tb_top {/tb_top/o_monitor[12]  } MONITOR_o_wb_err
quietly virtual signal -install /tb_top {/tb_top/o_monitor[13]  } MONITOR_i_wb_we
quietly virtual signal -install /tb_top { /tb_top/o_monitor[17:14]} MONITOR_i_wb_sel
quietly virtual signal -install /tb_top { /tb_top/o_monitor[21:18]} MONITOR_i_wb_adr
quietly virtual signal -install /tb_top { /tb_top/o_monitor[25:22]} MONITOR_i_wb_dat
quietly virtual signal -install /tb_top { /tb_top/o_monitor[29:26]} MONITOR_i_wb_dat001
quietly virtual signal -install /tb_top { /tb_top/o_monitor[29:26]} MONITOR_o_wb_dat
quietly virtual signal -install /tb_top {/tb_top/o_monitor[30]  } MONITOR_write_request
quietly virtual signal -install /tb_top {/tb_top/o_monitor[31]  } MONITOR_write_request_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[32]  } MONITOR_read_request
quietly virtual signal -install /tb_top {/tb_top/o_monitor[33]  } MONITOR_read_request_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[30]  } MONITOR_read_request001
quietly virtual signal -install /tb_top {/tb_top/o_monitor[31]  } MONITOR_read_request_r001
quietly virtual signal -install /tb_top {/tb_top/o_monitor[34]  } MONITOR_ram_write_final_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[35]  } MONITOR_ram_read_final_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[34]  } MONITOR_wb_read_final_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[35]  } MONITOR_ready_r
quietly virtual signal -install /tb_top/u_dut {/tb_top/u_dut/o_monitor[36]  } MONITOR_ramsync2_sys_rst
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Control -color Orchid /tb_top/i_reset_n
add wave -noupdate -expand -group Control -color Yellow /tb_top/i_brd_clk
add wave -noupdate -expand -group LEDs -color Gold /tb_top/o_led
add wave -noupdate -expand -group UART0 /tb_top/o_uart0_rx
add wave -noupdate -expand -group UART0 -color Tan /tb_top/o_uart0_cts
add wave -noupdate -expand -group UART0 /tb_top/i_uart0_tx
add wave -noupdate -expand -group UART0 -color Tan /tb_top/i_uart0_rts
add wave -noupdate -group I2C -color Yellow /tb_top/o_i2c0_scl
add wave -noupdate -group I2C /tb_top/io_i2c0_sda
add wave -noupdate -group SPI0 -color Yellow /tb_top/o_spi0_sclk
add wave -noupdate -group SPI0 -color {Sky Blue} /tb_top/o_spi0_ss_n
add wave -noupdate -group SPI0 /tb_top/o_spi0_mosi
add wave -noupdate -group SPI0 /tb_top/i_spi0_miso
add wave -noupdate -expand -group SRAM /tb_top/o_sram_cs_n
add wave -noupdate -expand -group SRAM -color {Sky Blue} /tb_top/o_sram_read_n
add wave -noupdate -expand -group SRAM -color {Sky Blue} /tb_top/o_sram_write_n
add wave -noupdate -expand -group SRAM -radix hexadecimal -childformat {{{/tb_top/o_sram_addr[20]} -radix hexadecimal} {{/tb_top/o_sram_addr[19]} -radix hexadecimal} {{/tb_top/o_sram_addr[18]} -radix hexadecimal} {{/tb_top/o_sram_addr[17]} -radix hexadecimal} {{/tb_top/o_sram_addr[16]} -radix hexadecimal} {{/tb_top/o_sram_addr[15]} -radix hexadecimal} {{/tb_top/o_sram_addr[14]} -radix hexadecimal} {{/tb_top/o_sram_addr[13]} -radix hexadecimal} {{/tb_top/o_sram_addr[12]} -radix hexadecimal} {{/tb_top/o_sram_addr[11]} -radix hexadecimal} {{/tb_top/o_sram_addr[10]} -radix hexadecimal} {{/tb_top/o_sram_addr[9]} -radix hexadecimal} {{/tb_top/o_sram_addr[8]} -radix hexadecimal} {{/tb_top/o_sram_addr[7]} -radix hexadecimal} {{/tb_top/o_sram_addr[6]} -radix hexadecimal} {{/tb_top/o_sram_addr[5]} -radix hexadecimal} {{/tb_top/o_sram_addr[4]} -radix hexadecimal} {{/tb_top/o_sram_addr[3]} -radix hexadecimal} {{/tb_top/o_sram_addr[2]} -radix hexadecimal} {{/tb_top/o_sram_addr[1]} -radix hexadecimal} {{/tb_top/o_sram_addr[0]} -radix hexadecimal}} -subitemconfig {{/tb_top/o_sram_addr[20]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[19]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[18]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[17]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[16]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[15]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[14]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[13]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[12]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[11]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[10]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[9]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[8]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[7]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[6]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[5]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[4]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[3]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[2]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[1]} {-height 15 -radix hexadecimal} {/tb_top/o_sram_addr[0]} {-height 15 -radix hexadecimal}} /tb_top/o_sram_addr
add wave -noupdate -expand -group SRAM -radix hexadecimal /tb_top/io_sram_data
add wave -noupdate -expand -group SRAM -color Cyan -radix hexadecimal /tb_top/sram_data_reg
add wave -noupdate -group Ethernet -expand -group Config_Ethernet -color Yellow /tb_top/o_mdc
add wave -noupdate -group Ethernet -expand -group Config_Ethernet /tb_top/io_md
add wave -noupdate -group Ethernet /tb_top/o_phy_reset_n
add wave -noupdate -group Ethernet -expand -group MTX_Ethernet -color Yellow /tb_top/i_mtx_clk
add wave -noupdate -group Ethernet -expand -group MTX_Ethernet -radix hexadecimal /tb_top/o_mtxd
add wave -noupdate -group Ethernet -expand -group MTX_Ethernet /tb_top/o_mtxen
add wave -noupdate -group Ethernet -expand -group MTX_Ethernet /tb_top/o_mtxerr
add wave -noupdate -group Ethernet -expand -group MRX_Ethernet -color Yellow /tb_top/i_mrx_clk
add wave -noupdate -group Ethernet -expand -group MRX_Ethernet -radix hexadecimal /tb_top/i_mrxd
add wave -noupdate -group Ethernet -expand -group MRX_Ethernet /tb_top/i_mrxdv
add wave -noupdate -group Ethernet -expand -group MRX_Ethernet /tb_top/i_mcrs
add wave -noupdate -group Ethernet -expand -group MRX_Ethernet /tb_top/i_mcoll
add wave -noupdate -group JTAG -color Gray20 /tb_top/altera_reserved_tck
add wave -noupdate -group JTAG -color Gray20 /tb_top/altera_reserved_tms
add wave -noupdate -group JTAG -color Gray20 /tb_top/altera_reserved_tdi
add wave -noupdate -group JTAG /tb_top/altera_reserved_tdo
add wave -noupdate -color Cyan /tb_top/sram_data_ctr
add wave -noupdate -divider {MONITOR Section}
add wave -noupdate -color Yellow /tb_top/MONITOR_i_wb_clk
add wave -noupdate -color Yellow /tb_top/MONITOR_i_ram_clk
add wave -noupdate -color Tan /tb_top/MONITOR_i_sys_rst
add wave -noupdate -color Tan /tb_top/u_dut/MONITOR_ramsync2_sys_rst
add wave -noupdate -color Cyan -radix unsigned /tb_top/MONITOR_wb_state
add wave -noupdate -color Cyan -radix unsigned /tb_top/MONITOR_ram_state
add wave -noupdate -color Wheat /tb_top/MONITOR_i_wb_cyc
add wave -noupdate -color Wheat /tb_top/MONITOR_i_wb_stb
add wave -noupdate -color Wheat /tb_top/MONITOR_o_wb_ack
add wave -noupdate -color Wheat /tb_top/MONITOR_o_wb_err
add wave -noupdate -radix hexadecimal /tb_top/MONITOR_i_wb_adr
add wave -noupdate -radix binary /tb_top/MONITOR_i_wb_sel
add wave -noupdate -radix hexadecimal /tb_top/MONITOR_i_wb_dat
add wave -noupdate -radix hexadecimal /tb_top/MONITOR_o_wb_dat
add wave -noupdate /tb_top/MONITOR_i_wb_we
add wave -noupdate -color Thistle /tb_top/MONITOR_ready_r
add wave -noupdate -color {Sky Blue} /tb_top/MONITOR_write_request
add wave -noupdate -color {Sky Blue} /tb_top/MONITOR_write_request_r
add wave -noupdate -color {Sky Blue} /tb_top/MONITOR_read_request
add wave -noupdate -color {Sky Blue} /tb_top/MONITOR_read_request_r
add wave -noupdate -color {Sky Blue} /tb_top/MONITOR_wb_read_final_r
add wave -noupdate {/tb_top/u_dut/o_monitor[36]}
add wave -noupdate /tb_top/o_monitor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1758164 ps} 0} {{Cursor 2} {1762607 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 552
configure wave -valuecolwidth 199
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1728458 ps} {1813250 ps}
