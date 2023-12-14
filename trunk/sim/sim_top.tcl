alias clc ".main clear"

clc
exec vlib work
vmap work work

set TB					"tb"
set hdl_path			"../src/hdl"
set inc_path			"../src/inc"

set run_time			"-all"

#============================ Add verilog files  ===============================

vlog 	+acc -incr -source  +define+SIM 	$hdl_path/activationFunction.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/checkOnes.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/comparator.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/fp_multiplier.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/fpadder.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/group_4_registers.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Maxnet.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_2_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_4to1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/pu.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg_32bit.v

vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM ./tb/maxnet_tb.v
onerror {break}

#================================ simulation ====================================

vsim	-voptargs=+acc -debugDB $TB

#======================= adding signals to wave window ==========================

add wave -hex -group 	 	{TB}				sim:/$TB/*
add wave -hex -group 	 	{top}				sim:/$TB/perm/*
add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================

configure wave -signalnamewidth 2

#====================================== run =====================================

run $run_time