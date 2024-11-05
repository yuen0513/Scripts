connect_pg_net

###################################
# create power ring
###################################
create_pg_ring_pattern ring_pattern_4_5 \
                       -nets {VDD VSS} \
                       -horizontal_layer metal5 -vertical_layer metal4 \
                       -horizontal_width {8} -vertical_width {8} \
                       -horizontal_spacing {2} -vertical_spacing {2} \
                       -corner_bridge true

set_pg_strategy Strategy_ring_4_5 -core -pattern {{name : ring_pattern_4_5}{nets : {VSS VDD VSS VDD VSS VDD}}{offset : {20 20}}}

compile_pg -strategies {Strategy_ring_4_5}

###################################
# connect power pad to power ring
###################################

connect_supply_net VDD -port [get_pins -hierarchical */VDD]
connect_supply_net VSS -port [get_pins -hierarchical */VSS]
connect_pg_net 

create_pg_macro_conn_pattern iopg_pattern_v -pin_conn_type scattered_pin -nets {VSS VDD} -layers {metal1 metal2} -pin_layers {metal2}

create_pg_macro_conn_pattern iopg_pattern_h -pin_conn_type scattered_pin -nets {VSS VDD} -layers {metal2 metal2} -pin_layers {metal2}
set_app_options -name plan.pgroute.treat_pad_as_macro -value true

set iopgs [get_cells core*]

set_pg_strategy Strategy_iopg_v -macros {core_vdd1 core_vdd2 core_vdd3 core_vdd4 core_vss1 core_vss2 core_vss3 core_vss4} -pattern {{name : iopg_pattern_v}{nets : {VDD VSS}}} -extension  {{{stop : outermost_ring}}}

set_pg_strategy Strategy_iopg_h -macros {core_vdd1 core_vdd2 core_vdd3 core_vdd4 core_vss1 core_vss2 core_vss3 core_vss4} -pattern {{name : iopg_pattern_h}{nets : {VDD VSS}}} -extension  {{{stop : outermost_ring}}}

compile_pg -strategies {Strategy_iopg_v Strategy_iopg_h} 


###################################
# Create Macro Block ring
###################################
set_pg_strategy Strategy_right_macro_ring_4_5 -macros u_IDCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0 -pattern {{name : ring_pattern_4_5}{nets :  {VSS VDD}}{offset : {2 2}}{skip_sides : 3 4}} -extension {{{direction : R B}{stop : outermost_ring}}}

set_pg_strategy Strategy_left_macro_ring_4_5 -macros u_DCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0 -pattern {{name : ring_pattern_4_5}{nets :  {VSS VDD}}{offset : {2 2}}{skip_sides : 1 4}} -extension {{{direction : L B}{stop : outermost_ring}}}

compile_pg -strategies {Strategy_right_macro_ring_4_5 Strategy_left_macro_ring_4_5}


#########################################
# create power straps 4_5 , exclude macro
#########################################
create_pg_mesh_pattern mesh_pattern_4_5 -layers {{{horizontal_layer : metal5} {width : 1} {spacing : minimum} {pitch : 20} {trim : true}} {{vertical_layer : metal4} {width   : 1} {spacing : minimum} {pitch : 20} {trim : true}}} -via_rule {{intersection : all}}

set_pg_strategy Strategy_4_5 -core -pattern {{name : mesh_pattern_4_5}{nets : {VSS VDD}}} -blockage {{{macros :   {u_DCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0 u_IDCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0}}}} -extension {{{nets : {VSS   VDD}}{stop : outermost_ring}}}

set_pg_strategy_via_rule via_rule_3_6 -via_rule {{{{existing : ring}{layers : {metal3 metal4 metal5 metal6}}}{via_master : default}}}

compile_pg -strategies Strategy_4_5 -via_rule via_rule_3_6


###################################
# M5 straps over macro
###################################
create_pg_macro_conn_pattern long_pin_pattern -pin_conn_type long_pin -nets {VDD VSS} -direction horizontal -layers metal5 -width 2 -spacing minimum -pitch 8

set_pg_strategy Strategy_RAM -macros {u_DCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0 u_IDCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0} -pattern {{name : long_pin_pattern}{nets : {VDD VSS}}} -extension {{{nets : {VDD VSS}}{layers   : {metal4 metal5}}{direction : R L}{stop : first_target}}}

compile_pg -strategies Strategy_RAM -via_rule via_rule_3_6


###################################
# create power rails
###################################
#create_routing_blockage -layers metal1 -net_types {power ground} -boundary {{194.915 457.065} {279.875 434.660}}
#create_routing_blockage -layers metal1 -net_types {power ground} -boundary {{575.515 417.020} {660.785 438.750}}

create_pg_std_cell_conn_pattern rail_pattern -layers {metal1}

set_pg_strategy power_rails -core \
   -pattern {{name: rail_pattern}{nets: VSS VDD}} \
   -extension {{{stop : outermost_ring}}} \
   -blockage {{{macros_with_keepout :   {u_DCT/tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0 u_IDCT/        tposemem_Bisted_RF_2P_ADV64x16_RF_2P_ADV64x16_u0_SRAM_i0}}}}

compile_pg -strategies power_rails
                        

analyze_power_plan -nets {VDD VSS} -analyze_power -voltage 1.1
