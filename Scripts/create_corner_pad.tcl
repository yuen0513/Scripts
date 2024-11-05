create_cell {cornerLL cornerLR cornerUL cornerUR} PADCORNER
create_io_corner_cell -cell cornerLL  {ioring.bottom ioring.left}
create_io_corner_cell -cell cornerUL  {ioring.left ioring.top}
create_io_corner_cell -cell cornerUR  {ioring.top ioring.right}
create_io_corner_cell -cell cornerLR  {ioring.right ioring.bottom}

