#
# Constraints for 'DF4IAH_V3'.
#
#



# Specify the clock period
# 20 MHz
set period  50.000

# Specify the maximum external clock delay from the external device
#set CLKs_max __CLKsMaxValue
set CLKs_max 0.300

# Specify the minimum external clock delay from the external device
#set CLKs_min __CLKsMinValue
set CLKs_min 0.000

# Specify the maximum external clock delay to the FPGA
#set CLKd_max __CLKdMaxValue
set CLKd_max 0.300

# Specify the minimum external clock delay to the FPGA
#set CLKd_min __CLKdMinValue
set CLKd_min 0.000

# Specify the required tCO
#set tCO __tCO
#set tCO 0.000

# Specify the maximum clock-to-out of the external device
#set tCO_max __tCOMax
set tCO_max 1.000

# Specify the minimum clock-to-out of the external device
#set tCO_min __tCOMin
set tCO_min 0.000


# Specify the maximum setup time of the external device
#set tSU __tSU
set tSU 5.000

# Specify the minimum hold time of the external device
#set tH __tH
set tH 0.000

# Specify the maximum board delay
#set BD_max __BDMax
set BD_max 0.300

# Specify the minimum board delay
#set BD_min __BDMin
set BD_min 0.000



#**************************************************************
# Time Information
#**************************************************************
set_time_format -unit ns -decimal_places 3


#**************************************************************
# Create Clock
#**************************************************************
#create_clock -name {clk0}         -period $period -waveform { 0.000 12.500 } [get_ports {C_20MHZ}]
#create_clock -name {clk0_virtual} -period $period -waveform { 0.000 12.500 }
create_clock -name {clk0}                -period 50.000 -waveform { 0.000 25.000 } [get_ports i_brd_clk*]
create_clock -name {clk0_virtual}        -period 50.000 -waveform { 0.000 25.000 }
# MII clock rate for 100BASE-TX is 25 MHz
create_clock -name {clk_eth_tx}          -period 40.000 -waveform { 0.000 20.000 } [get_ports i_mtx_clk*]
create_clock -name {clk_eth_tx_virtual}  -period 40.000 -waveform { 0.000 20.000 }
create_clock -name {clk_eth_rx}          -period 40.000 -waveform { 0.000 20.000 } [get_ports i_mrx_clk*]
create_clock -name {clk_eth_rx_virtual}  -period 40.000 -waveform { 0.000 20.000 }
create_clock -name {clk_eth_mgt}         -period 40.000 -waveform { 0.000 20.000 } [get_ports o_mdc*]
create_clock -name {clk_eth_mgt_virtual} -period 40.000 -waveform { 0.000 20.000 }
#create_clock -name {clk_sram}            -period 11.111 -waveform { 0.000  5.555 } [get_nodes ]
create_clock -name {clk_sram_virtual}    -period 11.111 -waveform { 0.000  5.555 }


#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks -create_base_clocks


#**************************************************************
# Set Clock Latency
#**************************************************************


#**************************************************************
# Set Clock Uncertainty
#**************************************************************
#if { $::TimeQuestInfo(family) == "HardCopy II"} {
derive_clock_uncertainty
#}
#set_clock_uncertainty -setup -from [get_clocks __listOfWildcards] -to [get_clocks __listOfWildcards]
#set_clock_uncertainty -hold  -from [get_clocks __listOfWildcards] -to [get_clocks __listOfWildcards]


#**************************************************************
# Set Input Delay
#**************************************************************
# Create the input maximum delay for the data input to the FPGA that accounts for all delays specified
set_input_delay -clock clk0_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports { i_uart* io_i2c* i_spi* }]
set_input_delay -clock clk_eth_rx_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports { i_mrx* i_mcoll* i_mcrs* }]
set_input_delay -clock clk_eth_mgt_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports io_md*]
set_input_delay -clock clk_sram_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports { io_sram_* }]

# Create the input minimum delay for the data input to the FPGA that accounts for all delays specified
set_input_delay -clock clk0_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports { i_uart* io_i2c* i_spi* }]
set_input_delay -clock clk_eth_rx_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports { i_mrx* i_mcoll* i_mcrs* }]
set_input_delay -clock clk_eth_mgt_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports io_md*]
set_input_delay -clock clk_sram_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports { io_sram_* }]


#**************************************************************
# Set Output Delay
#**************************************************************
# Create the output maximum delay for the data output from the FPGA that accounts for all delays specified
set_output_delay -clock clk0_virtual -max [expr $CLKs_max + $BD_max + $tSU - $CLKd_min] [get_ports { o_uart* o_led* o_i2c* io_i2c* o_spi* o_monitor* }]
set_output_delay -clock clk_eth_tx_virtual -max [expr $CLKs_max + $BD_max + $tSU - $CLKd_min] [get_ports o_mtx*]
set_output_delay -clock clk_sram_virtual -max [expr $CLKs_max + $BD_max + $tSU - $CLKd_min] [get_ports { o_sram_* io_sram_* }]

# Create the output minimum delay for the data output from the FPGA that accounts for all delays specified
set_output_delay -clock clk0_virtual -min [expr $CLKs_min + $BD_min - $tH - $CLKd_max] [get_ports { o_uart* o_led* o_i2c* io_i2c* o_spi* o_monitor* }]
set_output_delay -clock clk_eth_tx_virtual -min [expr $CLKs_min + $BD_min - $tH - $CLKd_max] [get_ports o_mtx*]
set_output_delay -clock clk_sram_virtual -min [expr $CLKs_min + $BD_min - $tH - $CLKd_max] [get_ports { o_sram_* io_sram_* }]


#**************************************************************
# Set Clock Groups
#**************************************************************
set_clock_groups -asynchronous -group [get_clocks clk_sram_virtual]


#**************************************************************
# Set False Path
#**************************************************************
set_false_path -from [get_ports { i_reset_n io_md }] -to [all_registers]
set_false_path -from [all_registers] -to [get_ports { o_mdc io_md o_phy_reset_n }]

#set_false_path -from [get_clocks { clk0 }] -to [get_clocks { clk_sram_virtual }]
#set_false_path -from [get_clocks { clk_sram_virtual }] -to [get_clocks { clk0 }]
set_false_path -from [get_ports { io_sram_* }] -to [all_registers]
set_false_path -from [all_registers] -to [get_ports { o_sram_* io_sram_* }]


#**************************************************************
# Set Multicycle Path
#**************************************************************


#**************************************************************
# Set Maximum Delay
#**************************************************************


#**************************************************************
# Set Minimum Delay
#**************************************************************


#**************************************************************
# Set Input Transition
#**************************************************************



#
# JTAG Signal Constraints constrain the TCK port (50 MHz)
create_clock -name tck -period 20.000 [get_ports altera_reserved_tck]

# Cut all paths to and from tck
set_clock_groups -asynchronous -group [get_clocks tck]

# Constrain the TDI port
##set_input_delay -clock tck -clock_fall __tdiBoardDelayValue [get_ports altera_reserved_tdi]
set_input_delay -clock tck -clock_fall 2.000 [get_ports altera_reserved_tdi]

# Constrain the TMS port
##set_input_delay -clock tck -clock_fall __tmsBoardDelayValue [get_ports altera_reserved_tms]
set_input_delay -clock tck -clock_fall 2.000 [get_ports altera_reserved_tms]

# Constrain the TDO port
##set_output_delay -clock tck -clock_fall __tdoBoardDelayValue [get_ports altera_reserved_tdo]
set_output_delay -clock tck -clock_fall 2.000 [get_ports altera_reserved_tdo]

