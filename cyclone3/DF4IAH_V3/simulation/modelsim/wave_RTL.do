onerror {resume}
quietly virtual signal -install /tb_top { /tb_top/o_monitor[5:2]} ram_state
quietly virtual signal -install /tb_top { /tb_top/o_monitor[1:0]} MONITOR_wb_state
quietly virtual signal -install /tb_top { /tb_top/o_monitor[5:2]} MONITOR_ram_state
quietly virtual signal -install /tb_top { /tb_top/o_monitor[17:14]} MONITOR_i_wb_sel
quietly virtual signal -install /tb_top { /tb_top/o_monitor[21:18]} MONITOR_i_wb_adr
quietly virtual signal -install /tb_top { /tb_top/o_monitor[25:22]} MONITOR_i_wb_dat
quietly virtual signal -install /tb_top { /tb_top/o_monitor[29:26]} MONITOR_o_wb_dat
quietly virtual signal -install /tb_top {/tb_top/o_monitor[6]  } MONITOR_i_sys_rst
quietly virtual signal -install /tb_top {/tb_top/o_monitor[7]  } MONITOR_i_wb_clk
quietly virtual signal -install /tb_top {/tb_top/o_monitor[8]  } MONITOR_i_ram_clk
quietly virtual signal -install /tb_top {/tb_top/o_monitor[9]  } MONITOR_i_wb_cyc
quietly virtual signal -install /tb_top {/tb_top/o_monitor[10]  } MONITOR_i_wb_stb
quietly virtual signal -install /tb_top {/tb_top/o_monitor[11]  } MONITOR_o_wb_ack
quietly virtual signal -install /tb_top {/tb_top/o_monitor[12]  } MONITOR_o_wb_err
quietly virtual signal -install /tb_top {/tb_top/o_monitor[13]  } MONITOR_i_wb_we
quietly virtual signal -install /tb_top {/tb_top/o_monitor[30]  } MONITOR_write_request
quietly virtual signal -install /tb_top {/tb_top/o_monitor[31]  } MONITOR_write_request_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[32]  } MONITOR_read_request
quietly virtual signal -install /tb_top {/tb_top/o_monitor[33]  } MONITOR_read_request_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[34]  } MONITOR_ram_write_final_r
quietly virtual signal -install /tb_top {/tb_top/o_monitor[35]  } MONITOR_ram_read_final_r
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/o_led
add wave -noupdate /tb_top/o_uart0_rx
add wave -noupdate /tb_top/o_uart0_cts
add wave -noupdate /tb_top/o_i2c0_scl
add wave -noupdate /tb_top/io_i2c0_sda
add wave -noupdate /tb_top/o_spi0_sclk
add wave -noupdate /tb_top/o_spi0_mosi
add wave -noupdate /tb_top/o_spi0_ss_n
add wave -noupdate /tb_top/o_sram_cs_n
add wave -noupdate /tb_top/o_sram_read_n
add wave -noupdate /tb_top/o_sram_write_n
add wave -noupdate -radix hexadecimal /tb_top/o_sram_addr
add wave -noupdate -radix hexadecimal /tb_top/io_sram_data
add wave -noupdate /tb_top/o_mtxd
add wave -noupdate /tb_top/o_mtxen
add wave -noupdate /tb_top/o_mtxerr
add wave -noupdate /tb_top/io_md
add wave -noupdate /tb_top/o_mdc
add wave -noupdate /tb_top/o_phy_reset_n
add wave -noupdate /tb_top/altera_reserved_tdo
add wave -noupdate /tb_top/o_monitor
add wave -noupdate /tb_top/i_uart0_tx
add wave -noupdate /tb_top/i_uart0_rts
add wave -noupdate /tb_top/i_spi0_miso
add wave -noupdate /tb_top/i_mrxd
add wave -noupdate /tb_top/i_mrxdv
add wave -noupdate /tb_top/i_mcoll
add wave -noupdate /tb_top/i_mcrs
add wave -noupdate /tb_top/altera_reserved_tck
add wave -noupdate /tb_top/altera_reserved_tdi
add wave -noupdate /tb_top/altera_reserved_tms
add wave -noupdate /tb_top/i_reset_n
add wave -noupdate /tb_top/i_brd_clk
add wave -noupdate /tb_top/i_mtx_clk
add wave -noupdate /tb_top/i_mrx_clk
add wave -noupdate /tb_top/tb_sram_clk
add wave -noupdate /tb_top/sram_data_ctr
add wave -noupdate -radix hexadecimal /tb_top/sram_read_r
add wave -noupdate /tb_top/o_led
add wave -noupdate /tb_top/o_uart0_rx
add wave -noupdate /tb_top/o_uart0_cts
add wave -noupdate /tb_top/o_i2c0_scl
add wave -noupdate /tb_top/io_i2c0_sda
add wave -noupdate /tb_top/o_spi0_sclk
add wave -noupdate /tb_top/o_spi0_mosi
add wave -noupdate /tb_top/o_spi0_ss_n
add wave -noupdate /tb_top/o_sram_cs_n
add wave -noupdate /tb_top/o_sram_read_n
add wave -noupdate /tb_top/o_sram_write_n
add wave -noupdate -radix hexadecimal /tb_top/o_sram_addr
add wave -noupdate -radix hexadecimal /tb_top/io_sram_data
add wave -noupdate /tb_top/o_mtxd
add wave -noupdate /tb_top/o_mtxen
add wave -noupdate /tb_top/o_mtxerr
add wave -noupdate /tb_top/io_md
add wave -noupdate /tb_top/o_mdc
add wave -noupdate /tb_top/o_phy_reset_n
add wave -noupdate /tb_top/altera_reserved_tdo
add wave -noupdate /tb_top/o_monitor
add wave -noupdate /tb_top/i_uart0_tx
add wave -noupdate /tb_top/i_uart0_rts
add wave -noupdate /tb_top/i_spi0_miso
add wave -noupdate /tb_top/i_mrxd
add wave -noupdate /tb_top/i_mrxdv
add wave -noupdate /tb_top/i_mcoll
add wave -noupdate /tb_top/i_mcrs
add wave -noupdate /tb_top/altera_reserved_tck
add wave -noupdate /tb_top/altera_reserved_tdi
add wave -noupdate /tb_top/altera_reserved_tms
add wave -noupdate /tb_top/i_reset_n
add wave -noupdate /tb_top/i_brd_clk
add wave -noupdate /tb_top/i_mtx_clk
add wave -noupdate /tb_top/i_mrx_clk
add wave -noupdate /tb_top/tb_sram_clk
add wave -noupdate /tb_top/sram_data_ctr
add wave -noupdate -radix hexadecimal /tb_top/sram_read_r
add wave -noupdate -expand -group Top -expand -group DEBUG_Top -color Cyan /tb_top/u_dut/testfail
add wave -noupdate -expand -group Top -expand -group DEBUG_Top -color Cyan /tb_top/u_dut/clk_count
add wave -noupdate -expand -group Top -expand -group Input_Control -color Orchid /tb_top/i_reset_n
add wave -noupdate -expand -group Top -expand -group Input_Control -color Orchid /tb_top/i_brd_clk
add wave -noupdate -expand -group Top -group JTAG /tb_top/altera_reserved_tck
add wave -noupdate -expand -group Top -group JTAG /tb_top/altera_reserved_tms
add wave -noupdate -expand -group Top -group JTAG /tb_top/altera_reserved_tdi
add wave -noupdate -expand -group Top -group JTAG /tb_top/altera_reserved_tdo
add wave -noupdate -expand -group Top -group LEDs -color Gold /tb_top/o_led
add wave -noupdate -expand -group Top -group I2C /tb_top/o_i2c0_scl
add wave -noupdate -expand -group Top -group I2C /tb_top/io_i2c0_sda
add wave -noupdate -expand -group Top -group SPI /tb_top/o_spi0_sclk
add wave -noupdate -expand -group Top -group SPI /tb_top/o_spi0_ss_n
add wave -noupdate -expand -group Top -group SPI /tb_top/o_spi0_mosi
add wave -noupdate -expand -group Top -group SPI /tb_top/i_spi0_miso
add wave -noupdate -expand -group Top -expand -group SRAM -color {Sky Blue} /tb_top/o_sram_cs_n
add wave -noupdate -expand -group Top -expand -group SRAM -color {Green Yellow} /tb_top/o_sram_read_n
add wave -noupdate -expand -group Top -expand -group SRAM -color Maroon /tb_top/o_sram_write_n
add wave -noupdate -expand -group Top -expand -group SRAM -radix hexadecimal /tb_top/o_sram_addr
add wave -noupdate -expand -group Top -expand -group SRAM -radix hexadecimal /tb_top/io_sram_data
add wave -noupdate -expand -group Top -group Ethernet -group Ethernet_Config /tb_top/o_mdc
add wave -noupdate -expand -group Top -group Ethernet -group Ethernet_Config /tb_top/io_md
add wave -noupdate -expand -group Top -group Ethernet /tb_top/o_phy_reset_n
add wave -noupdate -expand -group Top -group Ethernet -group Ethernet_MTX -color Yellow /tb_top/i_mtx_clk
add wave -noupdate -expand -group Top -group Ethernet -group Ethernet_MTX /tb_top/o_mtxd
add wave -noupdate -expand -group Top -group Ethernet -group Ethernet_MTX /tb_top/o_mtxen
add wave -noupdate -expand -group Top -group Ethernet -group Ethernet_MTX /tb_top/o_mtxerr
add wave -noupdate -expand -group Top -group Ethernet -group Ehternet_MRX -color Yellow /tb_top/i_mrx_clk
add wave -noupdate -expand -group Top -group Ethernet -group Ehternet_MRX /tb_top/i_mrxd
add wave -noupdate -expand -group Top -group Ethernet -group Ehternet_MRX /tb_top/i_mrxdv
add wave -noupdate -expand -group Top -group Ethernet -group Ehternet_MRX /tb_top/i_mcrs
add wave -noupdate -expand -group Top -group Ethernet -group Ehternet_MRX /tb_top/i_mcoll
add wave -noupdate -expand -group Top -group UART -group UART0 /tb_top/o_uart0_rx
add wave -noupdate -expand -group Top -group UART -group UART0 /tb_top/o_uart0_cts
add wave -noupdate -expand -group Top -group UART -group UART0 /tb_top/i_uart0_tx
add wave -noupdate -expand -group Top -group UART -group UART0 /tb_top/i_uart0_rts
add wave -noupdate -expand -group Top -color Yellow /tb_top/MONITOR_i_wb_clk
add wave -noupdate -expand -group Top -color Yellow /tb_top/MONITOR_i_ram_clk
add wave -noupdate -expand -group Top -color Tan /tb_top/MONITOR_i_sys_rst
add wave -noupdate -expand -group Top -color Cyan -radix unsigned /tb_top/MONITOR_wb_state
add wave -noupdate -expand -group Top -color Cyan -radix unsigned -childformat {{{/tb_top/MONITOR_ram_state[5]} -radix unsigned} {{/tb_top/MONITOR_ram_state[4]} -radix unsigned} {{/tb_top/MONITOR_ram_state[3]} -radix unsigned} {{/tb_top/MONITOR_ram_state[2]} -radix unsigned}} -subitemconfig {{/tb_top/o_monitor[5]} {-color Cyan -radix unsigned} {/tb_top/o_monitor[4]} {-color Cyan -radix unsigned} {/tb_top/o_monitor[3]} {-color Cyan -radix unsigned} {/tb_top/o_monitor[2]} {-color Cyan -radix unsigned}} /tb_top/MONITOR_ram_state
add wave -noupdate -expand -group Top -color Wheat /tb_top/MONITOR_i_wb_cyc
add wave -noupdate -expand -group Top -color Wheat /tb_top/MONITOR_i_wb_stb
add wave -noupdate -expand -group Top -color Wheat /tb_top/MONITOR_o_wb_ack
add wave -noupdate -expand -group Top -color Wheat /tb_top/MONITOR_o_wb_err
add wave -noupdate -expand -group Top -radix hexadecimal -childformat {{{/tb_top/MONITOR_i_wb_adr[21]} -radix hexadecimal} {{/tb_top/MONITOR_i_wb_adr[20]} -radix hexadecimal} {{/tb_top/MONITOR_i_wb_adr[19]} -radix hexadecimal} {{/tb_top/MONITOR_i_wb_adr[18]} -radix hexadecimal}} -subitemconfig {{/tb_top/o_monitor[21]} {-radix hexadecimal} {/tb_top/o_monitor[20]} {-radix hexadecimal} {/tb_top/o_monitor[19]} {-radix hexadecimal} {/tb_top/o_monitor[18]} {-radix hexadecimal}} /tb_top/MONITOR_i_wb_adr
add wave -noupdate -expand -group Top -radix binary -childformat {{{/tb_top/MONITOR_i_wb_sel[17]} -radix binary} {{/tb_top/MONITOR_i_wb_sel[16]} -radix binary} {{/tb_top/MONITOR_i_wb_sel[15]} -radix binary} {{/tb_top/MONITOR_i_wb_sel[14]} -radix binary}} -subitemconfig {{/tb_top/o_monitor[17]} {-radix binary} {/tb_top/o_monitor[16]} {-radix binary} {/tb_top/o_monitor[15]} {-radix binary} {/tb_top/o_monitor[14]} {-radix binary}} /tb_top/MONITOR_i_wb_sel
add wave -noupdate -expand -group Top -radix hexadecimal -childformat {{{/tb_top/MONITOR_i_wb_dat[25]} -radix hexadecimal} {{/tb_top/MONITOR_i_wb_dat[24]} -radix hexadecimal} {{/tb_top/MONITOR_i_wb_dat[23]} -radix hexadecimal} {{/tb_top/MONITOR_i_wb_dat[22]} -radix hexadecimal}} -subitemconfig {{/tb_top/o_monitor[25]} {-radix hexadecimal} {/tb_top/o_monitor[24]} {-radix hexadecimal} {/tb_top/o_monitor[23]} {-radix hexadecimal} {/tb_top/o_monitor[22]} {-radix hexadecimal}} /tb_top/MONITOR_i_wb_dat
add wave -noupdate -expand -group Top -radix hexadecimal /tb_top/MONITOR_o_wb_dat
add wave -noupdate -expand -group Top /tb_top/MONITOR_i_wb_we
add wave -noupdate -expand -group Top -color {Sky Blue} /tb_top/MONITOR_write_request
add wave -noupdate -expand -group Top -color {Sky Blue} /tb_top/MONITOR_write_request_r
add wave -noupdate -expand -group Top -color {Sky Blue} /tb_top/MONITOR_read_request
add wave -noupdate -expand -group Top -color {Sky Blue} /tb_top/MONITOR_read_request_r
add wave -noupdate -expand -group Top -color {Sky Blue} /tb_top/MONITOR_ram_write_final_r
add wave -noupdate -expand -group Top -color {Sky Blue} /tb_top/MONITOR_ram_read_final_r
add wave -noupdate -expand -group Top -radix binary /tb_top/o_monitor
add wave -noupdate -expand -group {Clocks & Resets} -color Orchid -radix hexadecimal /tb_top/u_dut/u_system/u_clocks_resets/i_brd_clk
add wave -noupdate -expand -group {Clocks & Resets} -color Yellow -radix hexadecimal /tb_top/u_dut/u_system/u_clocks_resets/o_sys_clk
add wave -noupdate -expand -group {Clocks & Resets} -color Yellow -radix hexadecimal /tb_top/u_dut/u_system/u_clocks_resets/o_ram_clk
add wave -noupdate -expand -group {Clocks & Resets} -color Orchid -radix hexadecimal /tb_top/u_dut/u_system/u_clocks_resets/i_brd_rst
add wave -noupdate -expand -group {Clocks & Resets} -radix hexadecimal /tb_top/u_dut/u_system/u_clocks_resets/i_ddr_calib_done
add wave -noupdate -expand -group {Clocks & Resets} -color Tan -radix hexadecimal /tb_top/u_dut/u_system/u_clocks_resets/o_sys_rst
add wave -noupdate -divider {Wishbone Masters}
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group Control -color Yellow -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_clk
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group Control -color Tan -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_system_rdy
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group Control -color Tan -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_system_rdy
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -color {Sky Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_address_valid
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_address
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_write_enable
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_byte_enable
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_write_data
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_read_data
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_address_nxt
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_priviledged
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_exclusive
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_data_access
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -color Coral -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_fetch_stall
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group Cache -color {Sky Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_cache_enable
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group Cache -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_cacheable_area
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group Cache -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_cache_flush
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_wb_cyc
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_wb_stb
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_wb_ack
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_wb_err
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_wb_adr
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -color {Sky Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_wb_we
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_wb_sel
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/i_wb_dat
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -group WishBone -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/o_wb_dat
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O /tb_top/o_sram_cs_n
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/o_sram_addr
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O -radix hexadecimal /tb_top/io_sram_data
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O /tb_top/o_sram_read_n
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -expand -group I/O /tb_top/o_sram_write_n
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -color {Sky Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/address_cachable
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -color Coral -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/sel_wb
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -color Coral -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/sel_cache
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/cache_stall
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/wb_stall
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/cache_wb_req
add wave -noupdate -group Amber_Fetch__M1 -expand -group Fetch -group Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/cache_read_data
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -color Coral /tb_top/u_dut/u_system/u_amber/u_fetch/sel_wb
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -color Coral /tb_top/u_dut/u_system/u_amber/u_fetch/sel_cache
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal /tb_top/u_dut/u_system/u_amber/u_fetch/cache_wb_req
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal /tb_top/u_dut/u_system/u_amber/u_fetch/address_cachable
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -color Cyan -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/c_state
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/i_cache_enable
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/i_cache_flush
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/read_stall
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/write_stall
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/cache_busy_stall
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -group Fetch_Cache_Internal -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/ex_read_cache_busy
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -expand -group DEBUG_Fetch -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/xC_STATE
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -expand -group DEBUG_Fetch -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_fetch/u_cache/xSOURCE_SEL
add wave -noupdate -group Amber_Fetch__M1 -expand -group Amber_Fetch_Cache -expand -group DEBUG_Fetch -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_fetch/u_wishbone/xAS_STATE
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Control -color Tan /tb_top/u_dut/u_system/u_amber/u_decode/i_system_rdy
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Control -color Yellow /tb_top/u_dut/u_system/u_amber/u_decode/i_clk
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -color {Dark Orchid} -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_fetch_stall
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -color Coral -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_execute_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_execute_status_bits
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -color {Green Yellow} -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_read_data
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_abt_status
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_irq
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_firq
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_adex
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_read_data
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_read_data_alignment
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_condition
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_exclusive_exec
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_data_access_exec
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_rm_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_rds_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_rn_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_rm_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_rds_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_rn_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_interrupt_vector_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_address_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_pc_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_byte_enable_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Register -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_reg_write_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Register -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Register -radix hexadecimal -childformat {{{/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[3]} -radix hexadecimal} {{/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[2]} -radix hexadecimal} {{/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[1]} -radix hexadecimal} {{/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[0]} -radix hexadecimal}} -subitemconfig {{/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[3]} {-height 15 -radix hexadecimal} {/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[2]} {-height 15 -radix hexadecimal} {/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[1]} {-height 15 -radix hexadecimal} {/tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel[0]} {-height 15 -radix hexadecimal}} /tb_top/u_dut/u_system/u_amber/u_decode/o_reg_bank_wsel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group UserMode -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_user_mode_regs_load
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group UserMode -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_user_mode_regs_store_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group UserMode -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_firq_not_user_mode
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_write_data_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_base_address_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_pc_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_irq_mask
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_irq_mask_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_firq_mask
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_firq_mask_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_mode
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_mode_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_status_bits_flags_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_imm32
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_imm_shift_amount
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_shift_imm_zero
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_alu_function
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_use_carry_in
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_multiply_function
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_multiply_done
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_barrel_shift_amount_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_barrel_shift_data_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_barrel_shift_function
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_opcode1
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_opcode2
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_crn
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_crm
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_num
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_operation
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group CoPro -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_copro_write_data_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group IABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_iabt_trigger
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group IABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_iabt_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group IABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_iabt_status
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group IABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_iabt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_dabt_trigger
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_dabt_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/o_dabt_status
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -expand -group I/O -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/i_dabt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/restore_base_address_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/restore_base_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/base_address_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/address_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/address_sel_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pc_sel_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pc_wen_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_iabt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_adex
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_iabt_status
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_sel
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/itype
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/opcode
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/opcode_compare
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_valid
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/instruction_execute
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mem_op
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/load_op
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/store_op
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/write_pc
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/immediate_shifter_operand
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/rds_use_rs
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/branch
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mem_op_pre_indexed
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mem_op_post_indexed
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/imm32_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/multiply_function_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pc_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/byte_enable_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/reg_write_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/user_mode_regs_load_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/firq_not_user_mode_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/write_data_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/copro_write_data_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pc_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/reg_bank_wsel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/saved_current_instruction_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pre_fetch_instruction_wen
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/control_state
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/control_state_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/use_saved_current_instruction
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/use_pre_fetch_instruction
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/copro_operation_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/condition_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Instruction -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/adex_reg
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/alu_swap_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/alu_not_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/alu_cin_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/alu_cout_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/alu_out_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/condition_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/exclusive_exec_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/data_access_exec_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/alu_function_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/use_carry_in_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/imm8
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/offset12
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/offset24
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/barrel_shift_function_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/barrel_shift_amount_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/barrel_shift_data_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/imm_shift_amount_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/shift_imm_zero_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/shift_extend
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/shift_imm
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/regop_set_flags
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group IABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/iabt_reg
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/dabt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/dabt_reg
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group DABT -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/dabt_reg_d1
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Abt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/abt_address_reg
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Abt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/abt_status_reg
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Saved -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/saved_current_instruction
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Saved -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/saved_current_instruction_iabt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Saved -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/saved_current_instruction_adex
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Saved -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/saved_current_instruction_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Saved -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/saved_current_instruction_iabt_status
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group PreFetch -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pre_fetch_instruction
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group PreFetch -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pre_fetch_instruction_iabt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group PreFetch -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pre_fetch_instruction_adex
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group PreFetch -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pre_fetch_instruction_address
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group PreFetch -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/pre_fetch_instruction_iabt_status
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_reg
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_reg_d1
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_reg_d2
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_instruction_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_base_reg_change
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_num_registers
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_r15
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group MTRANS -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/mtrans_r15_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/interrupt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/interrupt_mode
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/next_interrupt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/irq
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/firq
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/firq_request
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/irq_request
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/swi_request
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/und_request
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Interrupt -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/dabt_request
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_mode_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_mode_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_mode_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_irq_mask_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_irq_mask_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_irq_mask_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_firq_mask_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_firq_mask_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_firq_mask_r
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_sel_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group Decode -group Internal -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_decode/status_bits_flags_wen_nxt
add wave -noupdate -expand -group Amber_Decode -expand -group DEBUG_Decode -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_decode/xCONTROL_STATE
add wave -noupdate -expand -group Amber_Decode -expand -group DEBUG_Decode -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_decode/xMODE
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -group Control -color Tan -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_system_rdy
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -group Control -color Yellow -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_clk
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -color Coral -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_write_data
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_address
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_adex
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_address_valid
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_address_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_priviledged
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_exclusive
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_write_enable
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_byte_enable
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_data_access
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_status_bits
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_multiply_done
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_fetch_stall
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_mode
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_irq_mask
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_firq_mask
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_imm32
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_imm_shift_amount
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_shift_imm_zero
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_condition
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_exclusive_exec
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_use_carry_in
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_rm_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_rds_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_rn_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_rm_sel_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_rds_sel_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_rn_sel_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_barrel_shift_amount_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_barrel_shift_data_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_barrel_shift_function
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_alu_function
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_multiply_function
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_interrupt_vector_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_address_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_pc_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_byte_enable_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_reg_write_sel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_user_mode_regs_load
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_user_mode_regs_store_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_firq_not_user_mode
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_write_data_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_base_address_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_pc_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_reg_bank_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_reg_bank_wsel
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_flags_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_mode_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_irq_mask_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_status_bits_firq_mask_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_copro_write_data_wen
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_read_data
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_read_data_alignment
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_copro_read_data
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/i_data_access_exec
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group I/O_Execute -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/o_copro_write_data
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/pc_plus4
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/pc_minus4
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/address_plus4
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/alu_plus4
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/rn_plus4
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/alu_out
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/alu_flags
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/rm
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/rs
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/rd
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/rn
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/pc
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/pc_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/interrupt_vector
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/base_address
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/address_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/base_address_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/address_r
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/save_int_pc
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/save_int_pc_m4
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/reg_write_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/pc_wen
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/priviledged_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/write_data_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/write_enable_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/byte_enable_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Address -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/adex_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/reg_bank_wen
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/reg_bank_wsel
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/multiply_out
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/multiply_flags
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/shift_amount
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/barrel_shift_in
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/barrel_shift_out
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/barrel_shift_carry
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -group Barrel -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/barrel_shift_carry_alu
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/alu_out_pc_filtered
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/carry_in
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group ALU -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/execute
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/priviledged_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/write_data_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/copro_write_data_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/byte_enable_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/data_access_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/write_enable_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Update_REGs -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/exclusive_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_flags_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_flags
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_nr
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_rds_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_rds_nr
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_rds
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_rds_oh_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_rds_oh
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_rds_oh_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_irq_mask_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_irq_mask
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_firq_mask_nxt
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_firq_mask
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_flags_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_mode_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_irq_mask_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_firq_mask_update
add wave -noupdate -expand -group Amber_Execute__M1 -group Internal_Execute -group Status -radix hexadecimal /tb_top/u_dut/u_system/u_amber/u_execute/status_bits_out
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group DEBUG_Execute -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_execute/xCONDITION
add wave -noupdate -expand -group Amber_Execute__M1 -expand -group DEBUG_Execute -color Cyan -radix ascii /tb_top/u_dut/u_system/u_amber/u_execute/xMODE
add wave -noupdate -divider {Wishbone Slaves}
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -expand -group Control_S1 -color Yellow /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_clk
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -color Wheat /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_cyc
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -color Wheat /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_stb
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -color Wheat /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/o_wb_ack
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -color Wheat /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/o_wb_err
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -radix hexadecimal /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_adr
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_sel
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_we
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -radix hexadecimal /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/o_wb_dat
add wave -noupdate -group BootRam__S1 -expand -group I/O_S1 -radix hexadecimal /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/i_wb_dat
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/start_write
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/start_read
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/start_read_r
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 -radix hexadecimal /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/read_data
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 -radix hexadecimal /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/write_data
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/byte_enable
add wave -noupdate -group BootRam__S1 -expand -group Internal_S1 -radix hexadecimal /tb_top/u_dut/u_system/u_boot_mem32/u_boot_mem/address
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Control_S2 -color Tan /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_sys_rst
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Control_S2 -color Yellow /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_clk
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Control_S2 -color Yellow /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_ram_clk
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -color Wheat /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_cyc
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -color Wheat /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_stb
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -color Wheat /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_wb_ack
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -color Wheat /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_wb_err
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_adr
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_sel
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_we
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_wb_dat
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group Wishbone_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/i_wb_dat
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_sram_cs
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 -color {Medium Sea Green} /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_sram_read
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 -color Salmon /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_sram_write
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/o_sram_addr
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/io_sram_data
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/io_sram_data_l
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group I/O_S2 -expand -group SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/io_sram_data_e
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group Sync_IN_S2 -color {Sky Blue} /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/read_request
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group Sync_IN_S2 -color {Sky Blue} /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/read_request_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group Sync_IN_S2 -color {Sky Blue} /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/write_request
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group Sync_IN_S2 -color {Sky Blue} /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/write_request_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -color Cyan -radix unsigned /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wb_state
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -color {Medium Blue} -radix unsigned /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wbsync1_ram_state
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -color Aquamarine -radix unsigned /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wbsync2_ram_state
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -color {Medium Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wbsync1_ram_dat_out_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -color Aquamarine -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wbsync2_ram_dat_out_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wb_sel_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wb_adr_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wb_dat_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ready_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_WB_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/wb_read_final_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -color Cyan -radix unsigned /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_state
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -color {Medium Blue} -radix unsigned /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ramsync1_wb_state
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -color {Medium Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ramsync1_wb_adr_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -color {Medium Blue} -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ramsync1_wb_dat_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -color {Medium Blue} -radix binary /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ramsync1_wb_sel_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -color Pink -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_cyc_ctr
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_sr_adr_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_dat_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_dat_out_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_pos_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group State_S2 -expand -group FSM_SRAM_S2 -radix binary /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/ram_sel_r
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group DEBUG_SRAM -color Cyan -radix ascii /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/xWB_STATE
add wave -noupdate -expand -group SRAM_Bridge__S2 -expand -group Internal_S2 -expand -group DEBUG_SRAM -color Cyan -radix ascii /tb_top/u_dut/u_system/u_wb_sram_2m08b_bridge/xRAM_STATE
add wave -noupdate -group DMA__M2-S8 -color Yellow /tb_top/u_dut/u_system/u_dma/i_clk
add wave -noupdate -group DMA__M2-S8 -color Tan /tb_top/u_dut/u_system/u_dma/i_sys_rst
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/o_m_wb_stb
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/o_m_wb_cyc
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/i_m_wb_ack
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/i_m_wb_err
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/o_m_wb_adr
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -radix binary /tb_top/u_dut/u_system/u_dma/o_m_wb_sel
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/o_m_wb_we
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/o_m_wb_dat
add wave -noupdate -group DMA__M2-S8 -group Master_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/i_m_wb_dat
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/i_s_wb_stb
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/i_s_wb_cyc
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/o_s_wb_ack
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -color Wheat /tb_top/u_dut/u_system/u_dma/o_s_wb_err
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/i_s_wb_adr
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -radix binary /tb_top/u_dut/u_system/u_dma/i_s_wb_sel
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/i_s_wb_we
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/i_s_wb_dat
add wave -noupdate -group DMA__M2-S8 -group Slave_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/o_s_wb_dat
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/wb_s_read_ack
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/wb_s_rdata32
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/wb_s_start_write
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/wb_s_start_read
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/wb_s_start_read_d1
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/wb_s_wdata32
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Aquamarine -radix hexadecimal /tb_top/u_dut/u_system/u_dma/src_start_reg
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Aquamarine -radix hexadecimal /tb_top/u_dut/u_system/u_dma/dst_start_reg
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Pink -radix hexadecimal /tb_top/u_dut/u_system/u_dma/block_len_reg
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA /tb_top/u_dut/u_system/u_dma/pp_dma_block
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Cyan -radix hexadecimal /tb_top/u_dut/u_system/u_dma/pp_src_ptr
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Cyan -radix hexadecimal /tb_top/u_dut/u_system/u_dma/pp_dst_ptr
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/pp_remain
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix binary /tb_top/u_dut/u_system/u_dma/pp_sel_r
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix hexadecimal /tb_top/u_dut/u_system/u_dma/pp_data
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -radix binary /tb_top/u_dut/u_system/u_dma/sel_nxt
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Cyan -radix hexadecimal /tb_top/u_dut/u_system/u_dma/fsm_master
add wave -noupdate -group DMA__M2-S8 -expand -group Internal_DMA -color Cyan -radix hexadecimal /tb_top/u_dut/u_system/u_dma/fsm_pp
add wave -noupdate -group DMA__M2-S8 -expand -group DEBUG_DMA -color Cyan -radix ascii /tb_top/u_dut/u_system/u_dma/xFSM_MASTER
add wave -noupdate -group DMA__M2-S8 -expand -group DEBUG_DMA -color Cyan -radix ascii /tb_top/u_dut/u_system/u_dma/xFSM_PP
add wave -noupdate -group DMA__M2-S8 -expand -group DEBUG_DMA -divider WishboneArbiter
add wave -noupdate -expand -group WishboneArbiter -group I/O -group Control -color Yellow -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_wb_clk
add wave -noupdate -expand -group WishboneArbiter -group I/O -group Control -color Tan /tb_top/u_dut/u_system/u_wishbone_arbiter/i_sys_rst
add wave -noupdate -expand -group WishboneArbiter -group I/O -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_cyc
add wave -noupdate -expand -group WishboneArbiter -group I/O -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_stb
add wave -noupdate -expand -group WishboneArbiter -group I/O -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_ack
add wave -noupdate -expand -group WishboneArbiter -group I/O -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_err
add wave -noupdate -expand -group WishboneArbiter -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_adr
add wave -noupdate -expand -group WishboneArbiter -group I/O -radix binary /tb_top/u_dut/u_system/u_wishbone_arbiter/master_sel
add wave -noupdate -expand -group WishboneArbiter -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_we
add wave -noupdate -expand -group WishboneArbiter -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_wdat
add wave -noupdate -expand -group WishboneArbiter -group I/O -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/master_rdat
add wave -noupdate -expand -group WishboneArbiter -divider {WishboneArbiter Masters}
add wave -noupdate -expand -group WishboneArbiter -color Violet -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/current_master
add wave -noupdate -expand -group WishboneArbiter -color Violet -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/current_master_r
add wave -noupdate -expand -group WishboneArbiter -color Violet -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/next_master
add wave -noupdate -expand -group WishboneArbiter -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/select_master
add wave -noupdate -expand -group WishboneArbiter -group M0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/m0_wb_hold_r
add wave -noupdate -expand -group WishboneArbiter -group M0 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m0_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group M0 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m0_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group M0 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m0_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group M0 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m0_wb_err
add wave -noupdate -expand -group WishboneArbiter -group M0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m0_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group M0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m0_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group M0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m0_wb_we
add wave -noupdate -expand -group WishboneArbiter -group M0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m0_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group M0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m0_wb_dat
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/m1_wb_hold_r
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m1_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m1_wb_stb
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m1_wb_ack
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m1_wb_err
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m1_wb_adr
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -radix binary /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m1_wb_sel
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m1_wb_we
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m1_wb_dat
add wave -noupdate -expand -group WishboneArbiter -expand -group M1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m1_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group M2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/m2_wb_hold_r
add wave -noupdate -expand -group WishboneArbiter -group M2 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m2_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group M2 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m2_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group M2 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m2_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group M2 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m2_wb_err
add wave -noupdate -expand -group WishboneArbiter -group M2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m2_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group M2 -radix binary /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m2_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group M2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m2_wb_we
add wave -noupdate -expand -group WishboneArbiter -group M2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_m2_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group M2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_m2_wb_dat
add wave -noupdate -expand -group WishboneArbiter -divider {WishboneArbiter Slaves}
add wave -noupdate -expand -group WishboneArbiter -color Cyan -radix unsigned /tb_top/u_dut/u_system/u_wishbone_arbiter/current_slave
add wave -noupdate -expand -group WishboneArbiter -group S0 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s0_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S0 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s0_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S0 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s0_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S0 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s0_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s0_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S0 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s0_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S0 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s0_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s0_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S0 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s0_wb_dat
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s1_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s1_wb_stb
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s1_wb_ack
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s1_wb_err
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s1_wb_adr
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -radix binary /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s1_wb_sel
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s1_wb_we
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s1_wb_dat
add wave -noupdate -expand -group WishboneArbiter -expand -group S1 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s1_wb_dat
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s2_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s2_wb_stb
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s2_wb_ack
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s2_wb_err
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s2_wb_adr
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s2_wb_sel
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s2_wb_we
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s2_wb_dat
add wave -noupdate -expand -group WishboneArbiter -expand -group S2 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s2_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S3 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s3_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S3 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s3_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S3 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s3_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S3 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s3_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S3 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s3_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S3 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s3_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S3 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s3_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S3 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s3_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S3 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s3_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S4 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s4_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S4 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s4_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S4 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s4_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S4 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s4_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S4 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s4_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S4 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s4_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S4 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s4_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S4 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s4_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S4 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s4_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S5 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s5_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S5 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s5_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S5 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s5_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S5 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s5_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S5 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s5_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S5 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s5_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S5 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s5_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S5 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s5_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S5 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s5_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S6 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s6_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S6 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s6_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S6 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s6_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S6 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s6_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S6 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s6_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S6 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s6_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S6 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s6_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S6 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s6_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S6 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s6_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S7 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s7_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S7 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s7_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S7 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s7_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S7 -color Wheat /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s7_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S7 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s7_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S7 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s7_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S7 /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s7_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S7 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s7_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S7 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s7_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S8 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s8_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S8 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s8_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S8 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s8_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S8 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s8_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S8 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s8_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S8 -radix binary /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s8_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S8 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s8_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S8 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s8_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S8 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s8_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S9 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s9_wb_cyc
add wave -noupdate -expand -group WishboneArbiter -group S9 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s9_wb_stb
add wave -noupdate -expand -group WishboneArbiter -group S9 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s9_wb_ack
add wave -noupdate -expand -group WishboneArbiter -group S9 -color Wheat -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s9_wb_err
add wave -noupdate -expand -group WishboneArbiter -group S9 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s9_wb_adr
add wave -noupdate -expand -group WishboneArbiter -group S9 -radix binary /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s9_wb_sel
add wave -noupdate -expand -group WishboneArbiter -group S9 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s9_wb_we
add wave -noupdate -expand -group WishboneArbiter -group S9 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/i_s9_wb_dat
add wave -noupdate -expand -group WishboneArbiter -group S9 -radix hexadecimal /tb_top/u_dut/u_system/u_wishbone_arbiter/o_s9_wb_dat
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {i_brd_reset_n {999025 ps} 1} {{i_brd_reset (synced)} {1073785 ps} 1} {o_sys_rst {1698073 ps} 1} {{1st SRAM Read Cycle} {24521531 ps} 1} {{1st SRAM Datum at WB} {24896877 ps} 1} {{2nd SRAM Datum at WB} {25296705 ps} 1} {{4th SRAM Datum at WB - Cache line full} {26097694 ps} 1} {{SRAM write access} {26296596 ps} 1} {{Cursor 10} {26347222 ps} 0} {{Cursor 10} {26402342 ps} 0} {{Cursor 11} {26413643 ps} 0}
quietly wave cursor active 11
configure wave -namecolwidth 561
configure wave -valuecolwidth 100
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
WaveRestoreZoom {24920824 ps} {25639582 ps}
