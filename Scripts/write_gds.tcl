set_host_options -max_cores 8
open_block CHIP:CHIP.design
write_gds  -merge_files  { \
../library/gds/NangateOpenCellLibrary.macro.gds \
../library/gds/tpz.gds \
../library/memory/rf_2p_hse.gds \
} \
-layer_map  ../library/tech/macro.map \
-units 1000 CHIP.gds
exit
