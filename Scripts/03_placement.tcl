set_app_options -name time.delay_calculation_style -value zero_interconnect
report_timing
set_app_options -name time.delay_calculation_style -value auto

get_scan_chain_count
check_scan_chain

report_power

source ../scripts/add_tie.tcl
place_opt
optimize_dft

report_timing
report_power
connect_pg_net

save_block
save_block -as CHIP:placement.design
save_lib
