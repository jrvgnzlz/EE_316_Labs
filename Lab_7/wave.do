onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /product_sum/Clk
add wave -noupdate /product_sum/Rst
add wave -noupdate /product_sum/Start
add wave -noupdate /product_sum/Result
add wave -noupdate /product_sum/Done
add wave -noupdate /product_sum/ACC
add wave -noupdate /product_sum/add_4
add wave -noupdate /product_sum/add_9
add wave -noupdate /product_sum/State
add wave -noupdate /product_sum/Nextstate
add wave -noupdate /product_sum/shift
add wave -noupdate /product_sum/adder_select
add wave -noupdate /product_sum/load_register
add wave -noupdate /product_sum/add_4_out
add wave -noupdate /product_sum/add_9_out
add wave -noupdate /product_sum/M
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9947 ns} 0}
configure wave -namecolwidth 179
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
WaveRestoreZoom {8874 ns} {10059 ns}
