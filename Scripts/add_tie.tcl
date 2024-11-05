set TIE_LIB_CELL_PATTERN_LIST "*/LOGIC0_X1* */LOGIC1_X1*"
set_lib_cell_purpose -include optimization [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST]
set_dont_touch [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST] false
#      Limit the fanout of each tie cell to 8
set_app_options -name opt.tie_cell.max_fanout -value 8
