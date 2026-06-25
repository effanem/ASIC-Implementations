###################################################################

# Created by write_sdc on Sun Jan 18 23:37:21 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_wire_load_mode top
set_wire_load_model -name 8000 -library saed14rvt_base_ff0p715v125c
set_max_fanout 200 [current_design]
set_max_capacitance 100 [current_design]
set_max_transition 0.5 [current_design]
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
set_clock_latency 1.5  [get_clocks clk]
set_clock_uncertainty 0.3  [get_clocks clk]
set_clock_transition -max -rise 0.4 [get_clocks clk]
set_clock_transition -max -fall 0.4 [get_clocks clk]
set_clock_transition -min -rise 0.4 [get_clocks clk]
set_clock_transition -min -fall 0.4 [get_clocks clk]
group_path -name CLOCK  -to [get_clocks clk]
group_path -name INPUTS  -through [list [get_ports clk] [get_ports rst] [get_ports {req[7]}]           \
[get_ports {req[6]}] [get_ports {req[5]}] [get_ports {req[4]}] [get_ports      \
{req[3]}] [get_ports {req[2]}] [get_ports {req[1]}] [get_ports {req[0]}]]
group_path -name OUTPUTS  -to [list [get_ports {code[2]}] [get_ports {code[1]}] [get_ports {code[0]}]   \
[get_ports valid]]
set_input_delay -clock clk  -max 1  [get_ports rst]
set_input_delay -clock clk  -max 1  [get_ports {req[7]}]
set_input_delay -clock clk  -max 1  [get_ports {req[6]}]
set_input_delay -clock clk  -max 1  [get_ports {req[5]}]
set_input_delay -clock clk  -max 1  [get_ports {req[4]}]
set_input_delay -clock clk  -max 1  [get_ports {req[3]}]
set_input_delay -clock clk  -max 1  [get_ports {req[2]}]
set_input_delay -clock clk  -max 1  [get_ports {req[1]}]
set_input_delay -clock clk  -max 1  [get_ports {req[0]}]
