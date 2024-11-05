#set FILLER_CELL_METAL [get_lib_cells FILLCAP*]
#create_stdcell_fillers -lib_cells $FILLER_CELL_METAL -rules {post_route_auto_delete}
#connect_pg_net
#remove_stdcell_fillers_with_violation

#set FILLER_CELL_NO_METAL [get_lib_cells */FILL* -filter {full_name !~ *TIE*}]
#create_stdcell_fillers -lib_cells $FILLER_CELL_NO_METAL -rules {post_route_auto_delete}
#connect_pg_net

create_stdcell_fillers -lib_cells {FILLCELL_X32 FILLCELL_X16 FILLCELL_X8 FILLCELL_X4 FILLCELL_X2 FILLCELL_X1} -rules {post_route_auto_delete}
connect_pg_net

