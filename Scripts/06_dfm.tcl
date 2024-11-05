source ../scripts/create_stdcell_fillers.tcl

check_routes
route_detail

connect_pg_net 

source ../scripts/icc2_add_io_text.tcl
add_io_text metal7 5 portName

create_shape -layer metal5 -height 5 -origin {490 630} -shape_type text -text VDD 
create_shape -layer metal5 -height 5 -origin {490 618} -shape_type text -text VSS 
create_shape -layer metal7 -height 5 -origin {755 600} -shape_type text -text IOVDD 
create_shape -layer metal7 -height 5 -origin {755 530} -shape_type text -text IOVSS

source ../scripts/icc2_createNplace_bondpads.tcl
createNplace_bondpads 	-inline_pad_ref_name BONDINNER -stagger true -stagger_pad_ref_name BONDOUTER

save_block
save_block -as CHIP:dfm.design
save_lib


