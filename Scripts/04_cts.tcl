report_clocks
report_clocks -skew
report_clocks -groups
report_clock_qor

report_ports [get_ports CLK]
check_design -checks pre_clock_stage

source -echo ../scripts/cts_setup.tcl

get_scenario  -filter active&&hold
report_scenarios

source ../scripts/cts_app_options.tcl
clock_opt -to route_clock

report_timing
report_clock_timing -type skew

connect_pg_net

save_block
save_block -as CHIP:cts.design
save_lib

