set_host_options -max_cores 16

create_lib -ref_libs {../library/ndm/icc2_cell_lib/io.ndm ../library/ndm/icc2_cell_lib/NangateOpenCellLibrary.ndm ../library/ndm/icc2_cell_lib/USERLIB_nldm.ndm ../library/ndm/icc2_cell_lib/Nangate_physical_only.ndm} -technology ../library/tech/NangateOpenCellLibrary.tf CHIP

read_verilog -top CHIP ../design_data/CHIP_syn.v
link_block
report_ref_libs

load_upf ../design_data/CHIP.upf
commit_upf

read_def ../design_data/CHIP-scan.def

read_parasitic_tech -tlup ../library/tluplus/worst.tluplus -layermap ../library/tluplus/tluplus.map -name rcworst
read_parasitic_tech -tlup ../library/tluplus/best.tluplus -layermap ../library/tluplus/tluplus.map -name rcbest
report_lib -parasitic_tech [current_lib]

set_attribute [get_site_defs unit] is_default true
set_attribute [get_site_defs unit] symmetry Y

set_attribute [get_layers {metal1}] track_offset  0.07
set_attribute [get_layers {metal2}] track_offset  0.095
set_attribute [get_layers {metal1 metal3 metal5 metal7 metal9}] routing_direction horizontal
set_attribute [get_layers {metal2 metal4 metal6 metal8 metal10}] routing_direction vertical

report_ignored_layers

source -echo ../design_data/mcmm/CHIP.mcmm.tcl
report_mode

save_block 
save_block -as CHIP:design_setup.design
save_lib
