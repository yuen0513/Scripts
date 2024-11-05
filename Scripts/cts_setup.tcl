set CTS_LIB_CELL_PATTERN_LIST "*/CLK* */*DFF*"
set CTS_CELLS [get_lib_cells $CTS_LIB_CELL_PATTERN_LIST]
set_dont_touch $CTS_CELLS false
#suppress_message ATTR-12
set_lib_cell_purpose -exclude cts [get_lib_cells]
set_lib_cell_purpose -include cts $CTS_CELLS
#unsuppress_message ATTR-12

## Clock NDRs
####################################

mark_clock_trees
source ../scripts/clock_ndr.tcl
report_clock_routing_rules

#      Change the uncertainty for all clocks in all scenarios
foreach_in_collection scen [all_scenarios] {
  current_scenario $scen
  set_clock_uncertainty 0.2 -setup [all_clocks]
  set_clock_uncertainty 0.01 -hold [all_clocks]
}
current_scenario Mfunc:max

set_max_transition 0.1 -clock_path [get_clocks] -corners [all_corners]

#set_max_capacitance 0.5 -clock_path [all_clocks]
#set_clock_tree_options -target_skew 0.05 -corners [get_corners *max]
#set_clock_tree_options -target_skew 0.02 -corners [get_corners *min]

get_scenario  -filter active&&hold
report_scenarios
report_clock_tree_options

