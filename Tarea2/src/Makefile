all:
	yosys -s controlador.ys
	iverilog testbench.v
	vvp a.out
	gtkwave resultados.vcd plantilla.gtkw

clear:
	rm *.vcd
	rm a.out
	rm contr_synth.v