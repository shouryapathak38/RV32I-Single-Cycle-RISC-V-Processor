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

vlog -work work \
../rtl/pc.v \
../rtl/pc_plus4.v \
../rtl/pc_mux.v \
../rtl/instruction_memory.v \
../rtl/fetch_unit_top.v \
../rtl/register_file.v \
../rtl/imm_gen.v \
../rtl/main_decoder.v \
../rtl/alu_decoder.v \
../rtl/branch_decision.v \
../rtl/control_unit_top.v \
../rtl/decode_top.v \
../rtl/comparator.v \
../rtl/srcA_mux.v \
../rtl/srcB_mux.v \
../rtl/alu.v \
../rtl/execute_top.v \
../rtl/data_memory.v \
../rtl/result_mux.v \
../rtl/RISCV_SC_TOP.v

#=========================================================
# Compile Testbench
#=========================================================

vlog -work work ../tb/RISCV_SC_all37_tb.v

#=========================================================
# Start Simulation
#=========================================================

vsim work.RISCV_SC_all37_tb -voptargs=+acc

#=========================================================
# Waveforms
#=========================================================

delete wave *

add wave sim:/RISCV_SC_all37_tb/*
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[1]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[2]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[3]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[4]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[5]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[6]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[7]
add wave -radix hex sim:/RISCV_SC_all37_tb/dut/u_decode_top/u_register_file/reg_file[8]

#=========================================================
# Run
#=========================================================

run -all
wave zoom full