transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/ula_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/ula.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/stage_wb.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/stage_mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/stage_if.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/stage_id.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/stage_ex.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/pipeline_memwb.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/pipeline_ifid.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/pipeline_idex.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/pipeline_exmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/instruction_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/imm_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/hazard_detection.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/fowarding_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/bancoreg.v}
vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/processador.v}

vlog -vlog01compat -work work +incdir+C:/Users/gabri/Documents/processador {C:/Users/gabri/Documents/processador/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
