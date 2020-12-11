set uut_dir .
set uut_lib work
set verif_top tb_memory_cell
set vcom_args -93

vlib $uut_lib
vmap $uut_lib $uut_lib

vcom $vcom_args -work $uut_lib $uut_dir/memory_cell_pkg.vhd
vcom $vcom_args -work $uut_lib $uut_dir/memory_cell.vhd
vcom $vcom_args -work $uut_lib $uut_dir/tb_memory_cell.vhd

vsim $uut_lib.$verif_top

run
