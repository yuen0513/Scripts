check_routability

source ../scripts/route_app_options.tcl

set_app_options -name route.common.post_detail_route_redundant_via_insertion -value medium
set_app_options -name route.common.concurrent_redundant_via_effort_level -value medium

source ../scripts/icc2_antenna.clf
route_auto

check_routes
route_detail -incremental true -initial_drc_from_input true

#check_routes
#route_detail

#route_opt
#check_routes
#route_detail -incremental true -initial_drc_from_input true

save_block
save_block -as CHIP:route.design
save_lib
