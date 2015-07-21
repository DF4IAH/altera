onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Control -color Orchid /tb_top/i_reset_n
add wave -noupdate -expand -group Control -color Yellow /tb_top/i_brd_clk
add wave -noupdate -group LEDs -color Gold /tb_top/o_led
add wave -noupdate -group UART0 /tb_top/o_uart0_rx
add wave -noupdate -group UART0 -color Tan /tb_top/o_uart0_cts
add wave -noupdate -group UART0 /tb_top/i_uart0_tx
add wave -noupdate -group UART0 -color Tan /tb_top/i_uart0_rts
add wave -noupdate -group I2C -color Yellow /tb_top/o_i2c0_scl
add wave -noupdate -group I2C /tb_top/io_i2c0_sda
add wave -noupdate -group SPI0 -color Yellow /tb_top/o_spi0_sclk
add wave -noupdate -group SPI0 -color {Sky Blue} /tb_top/o_spi0_ss_n
add wave -noupdate -group SPI0 /tb_top/o_spi0_mosi
add wave -noupdate -group SPI0 /tb_top/i_spi0_miso
add wave -noupdate -expand -group SRAM /tb_top/o_sram_cs_n
add wave -noupdate -expand -group SRAM -color {Sky Blue} /tb_top/o_sram_read_n
add wave -noupdate -expand -group SRAM -color {Sky Blue} /tb_top/o_sram_write_n
add wave -noupdate -expand -group SRAM -radix hexadecimal /tb_top/o_sram_addr
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
add wave -noupdate /tb_top/o_monitor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13589417 ps} 0} {{Cursor 2} {13600455 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 257
configure wave -valuecolwidth 163
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
WaveRestoreZoom {17395930 ps} {19279450 ps}
