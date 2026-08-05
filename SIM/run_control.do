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

vlog -work work ../rtl/main_decoder.v ../rtl/alu_decoder.v ../rtl/branch_decision.v ../rtl/control_unit_top.v

#=========================================================
# Compile Testbench
#=========================================================

vlog -work work ../tb/control_unit_top_tb.v

#=========================================================
# Start Simulation
#=========================================================
# vopt +acc work.control_unit_top_tb -o control_unit_top_tb_opt
# vsim fetch_unit_top_tb_opt
vsim work.control_unit_top_tb -voptargs=+acc

#=========================================================
# Waveforms
#=========================================================

delete wave *

# Inputs
# add wave sim:/control_unit_top_tb/opcode
# add wave sim:/control_unit_top_tb/funct3
# add wave sim:/control_unit_top_tb/funct7_5
# add wave sim:/control_unit_top_tb/Flags

# Outputs
# add wave sim:/control_unit_top_tb/RegWrite
# add wave sim:/control_unit_top_tb/ResultSrc
# add wave sim:/control_unit_top_tb/MemRW
# add wave sim:/control_unit_top_tb/Jump
# add wave sim:/control_unit_top_tb/Branch
# add wave sim:/control_unit_top_tb/ALUSrc
# add wave sim:/control_unit_top_tb/ImmSrc
# add wave sim:/control_unit_top_tb/ALUControl
# add wave sim:/control_unit_top_tb/PCSrc
add wave sim:/control_unit_top_tb/*
#=========================================================
# Run
#=========================================================

run -all
wave zoom full