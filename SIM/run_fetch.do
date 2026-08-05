transcript on

if {![file exists work]} {
    vlib work
}
vmap work work

# Compile all RTL
vlog -work work ../rtl/*.v

# Compile current testbench
vlog -work work ../tb/fetch_unit_top_tb.v

# Optimize
vopt +acc work.fetch_unit_top_tb -o fetch_unit_top_tb_opt
vsim fetch_unit_top_tb_opt

# Add all signals
add wave sim:/fetch_unit_top_tb/*

# Run
run -all