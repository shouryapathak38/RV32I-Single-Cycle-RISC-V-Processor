#=========================================================
# Create WORK Library
#=========================================================

if {![file exists work]} {
    vlib work
}

vmap work work

#=========================================================
# Compile RTL
#=========================================================

vlog -work work ../rtl/register_file.v ../rtl/imm_gen.v ../rtl/main_decoder.v ../rtl/alu_decoder.v ../rtl/branch_decision.v ../rtl/control_unit_top.v ../rtl/decode_top.v

#=========================================================
# Compile Testbench
#=========================================================

vlog -work work ../tb/decode_top_tb.v

#=========================================================
# Start Simulation
#=========================================================

# vopt +acc work.decode_top_tb -o decode_top_tb_opt
# vsim decode_top_tb_opt

vsim work.decode_top_tb -voptargs=+acc

#=========================================================
# Waveforms
#=========================================================

delete wave *

add wave sim:/decode_top_tb/*

#=========================================================
# Run
#=========================================================

run -all
