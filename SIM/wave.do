onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fetch_unit_top_tb/clk
add wave -noupdate /fetch_unit_top_tb/rst
add wave -noupdate /fetch_unit_top_tb/pc_src
add wave -noupdate /fetch_unit_top_tb/pc_target
add wave -noupdate /fetch_unit_top_tb/pc
add wave -noupdate /fetch_unit_top_tb/instruction
add wave -noupdate /fetch_unit_top_tb/dut/clk
add wave -noupdate /fetch_unit_top_tb/dut/rst
add wave -noupdate /fetch_unit_top_tb/dut/pc_src
add wave -noupdate /fetch_unit_top_tb/dut/pc_target
add wave -noupdate /fetch_unit_top_tb/dut/pc
add wave -noupdate /fetch_unit_top_tb/dut/instruction
add wave -noupdate /fetch_unit_top_tb/dut/next_pc
add wave -noupdate /fetch_unit_top_tb/dut/pc_plus4
add wave -noupdate /fetch_unit_top_tb/dut/u_pc/clk
add wave -noupdate /fetch_unit_top_tb/dut/u_pc/rst
add wave -noupdate /fetch_unit_top_tb/dut/u_pc/next_pc
add wave -noupdate /fetch_unit_top_tb/dut/u_pc/pc
add wave -noupdate /fetch_unit_top_tb/dut/u_pc_plus4/pc
add wave -noupdate /fetch_unit_top_tb/dut/u_pc_plus4/pc_plus4
add wave -noupdate /fetch_unit_top_tb/dut/u_pc_mux/pc_src
add wave -noupdate /fetch_unit_top_tb/dut/u_pc_mux/pc_plus4
add wave -noupdate /fetch_unit_top_tb/dut/u_pc_mux/pc_target
add wave -noupdate /fetch_unit_top_tb/dut/u_pc_mux/next_pc
add wave -noupdate /fetch_unit_top_tb/dut/u_instruction_memory/addr
add wave -noupdate /fetch_unit_top_tb/dut/u_instruction_memory/instr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3410 ns}
