initialize_floorplan -honor_pad_limit -core_offset {300}
create_io_ring -name ioring -corner_height 199.5

source -echo ../scripts/create_corner_pad.tcl
source -echo ../scripts/create_power_pad.tcl

set_signal_io_constraints -file ../design_data/CHIP.io
place_io

create_io_filler_cells -reference_cells {PADFILLER20 PADFILLER10 PADFILLER5 PADFILLER1 PADFILLER05 PADFILLER0005} -overlap_cells PADFILLER0005
set io_insts [get_cells -hier -filter "is_io==true"]
set_fixed_objects $io_insts

save_block
save_block -as CHIP:die_init.design
save_lib

set all_macros [get_cells -hierarchical -filter "is_hard_macro && !is_physical_only"]
create_keepout_margin -type hard -outer {10 10 10 10} $all_macros
set_app_options -name place.coarse.fix_hard_macros -value false
set_app_options -name plan.place.auto_create_blockages -value auto

create_placement -floorplan
set_fixed_objects $all_macros

save_block
save_block -as CHIP::before_pns.design
save_lib

source -echo ../scripts/pns.tcl
create_placement -incremental

save_block
save_block -as CHIP:design_planning.design
save_lib

write_floorplan -net_types {power ground} \
   -include_physical_status {fixed locked} \
   -force -output CHIP_icc2.fp


