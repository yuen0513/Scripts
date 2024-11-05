set_app_options -name route.global.timing_driven    -value true
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.timing_driven     -value true
set_app_options -name route.track.crosstalk_driven  -value true
set_app_options -name route.detail.timing_driven    -value true
set_app_options -name route.detail.force_max_number_iterations -value false
set_app_options -name time.si_enable_analysis -value true

## Secondary PG Routin
set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 2
set_app_options -name route.common.separate_tie_off_from_secondary_pg     -value true
if {[get_routing_rules -quiet VDDwide] != ""} {remove_routing_rules VDDwide }
create_routing_rule VDDwide -widths {metal1 0.28 metal2 0.28 metal3 0.28} -taper_distance 0.4
set_routing_rule -rule VDDwide -min_routing_layer metal2 -min_layer_mode allow_pin_connection -max_routing_layer metal3 [get_nets VDD]
route_group -nets {VDD}

set_app_options -name ccd.post_route_buffer_removal -value true
set_app_options -name route.detail.eco_route_use_soft_spacing_for_timing_optimization -value false
set_app_options -name route_opt.flow.enable_ccd -value false
