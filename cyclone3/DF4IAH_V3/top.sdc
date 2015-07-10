#
# Constraints for 'DF4IAH_V3'.
#
#



# Specify the clock period
#set period __period
#set period  25.000
# 20 MHz
set period  50.000
# 200 MHz
#set period  5.000

# Specify the maximum external clock delay from the external device
#set CLKs_max __CLKsMaxValue
set CLKs_max 0.300

# Specify the minimum external clock delay from the external device
#set CLKs_min __CLKsMinValue
set CLKs_min 0.033

# Specify the maximum external clock delay to the FPGA
#set CLKd_max __CLKdMaxValue
set CLKd_max 0.300

# Specify the minimum external clock delay to the FPGA
#set CLKd_min __CLKdMinValue
set CLKd_min 0.033

# Specify the required tCO
#set tCO __tCO
set tCO 0.000

# Specify the maximum clock-to-out of the external device
#set tCO_max __tCOMax
set tCO_max 0.000

# Specify the minimum clock-to-out of the external device
#set tCO_min __tCOMin
set tCO_min 0.000


# Specify the maximum setup time of the external device
#set tSU __tSU
set tSU 0.000

# Specify the minimum hold time of the external device
#set tH __tH
set tH 0.000

# Specify the maximum board delay
#set BD_max __BDMax
set BD_max 0.000

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
#create_clock -name {clk0}         -period $period -waveform { 0.000 12.500 } [get_ports {C_40MHZ}]
#create_clock -name {clk0_virtual} -period $period -waveform { 0.000 12.500 }
create_clock -name {clk0}         -period $period [get_ports {i_brd_clk_p,i_brd_clk_n}]
create_clock -name {clk0_virtual} -period $period


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
derive_clock_uncertainty
#set_clock_uncertainty -setup -from [get_clocks __listOfWildcards] -to [get_clocks __listOfWildcards]
#set_clock_uncertainty -hold  -from [get_clocks __listOfWildcards] -to [get_clocks __listOfWildcards]


#**************************************************************
# Set Input Delay
#**************************************************************
# Create the input maximum delay for the data input to the FPGA that accounts for all delays specified
set_input_delay -clock clk0_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports i_*]
set_input_delay -clock clk0_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports io_*]
#set_input_delay -clock clk0_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports amber_i_*]
#set_input_delay -clock clk0_virtual -max [expr $CLKs_max + $tCO_max + $BD_max - $CLKd_min] [get_ports wb_i_*]

# Create the input minimum delay for the data input to the FPGA that accounts for all delays specified
set_input_delay -clock clk0_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports i_*]
set_input_delay -clock clk0_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports io_*]
#set_input_delay -clock clk0_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports amber_i_*]
#set_input_delay -clock clk0_virtual -min [expr $CLKs_min + $tCO_min + $BD_min - $CLKd_max] [get_ports wb_i_*]


#**************************************************************
# Set Output Delay
#**************************************************************
# Create the output maximum delay for the data output from the FPGA that accounts for all delays specified
set_output_delay -clock clk0_virtual -max [expr $CLKs_max + $BD_max + $tSU - $CLKd_min] [get_ports o_*]
set_output_delay -clock clk0_virtual -max [expr $CLKs_max + $BD_max + $tSU - $CLKd_min] [get_ports io_*]
#set_output_delay -clock clk0_virtual -max [expr $CLKs_max + $BD_max + $tSU - $CLKd_min] [get_ports wb_o_*]

# Create the output minimum delay for the data output from the FPGA that accounts for all delays specified
set_output_delay -clock clk0_virtual -min [expr $CLKs_min + $BD_min - $tH - $CLKd_max] [get_ports o_*]
set_output_delay -clock clk0_virtual -min [expr $CLKs_min + $BD_min - $tH - $CLKd_max] [get_ports io_*]
#set_output_delay -clock clk0_virtual -min [expr $CLKs_min + $BD_min - $tH - $CLKd_max] [get_ports wb_o_*]


#**************************************************************
# Set Clock Groups
#**************************************************************


#**************************************************************
# Set False Path
#**************************************************************


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
# JTAG Signal Constraints constrain the TCK port
#create_clock -name tck -period $period [get_ports altera_reserved_tck]

# Cut all paths to and from tck
#set_clock_groups -asynchronous -group [get_clocks tck]

# Constrain the TDI port
##set_input_delay -clock tck -clock_fall __tdiBoardDelayValue [get_ports altera_reserved_tdi]
#set_input_delay -clock tck -clock_fall 0.000 [get_ports altera_reserved_tdi]

# Constrain the TMS port
##set_input_delay -clock tck -clock_fall __tmsBoardDelayValue [get_ports altera_reserved_tms]
#set_input_delay -clock tck -clock_fall 0.000 [get_ports altera_reserved_tms]

# Constrain the TDO port
##set_output_delay -clock tck -clock_fall __tdoBoardDelayValue [get_ports altera_reserved_tdo]
#set_output_delay -clock tck -clock_fall 0.000 [get_ports altera_reserved_tdo]


#
# False path exception

# Sets a false path exception from a source register clocked by _sourceClock 
# to a destination register __destinationRegisterInputPin
#set_false_path -from [get_clocks __sourceClock] -to [get_pins __destinationRegisterInputPin]

