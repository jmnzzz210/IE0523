all:
	yosys -s cpu.ys
	iverilog -g2005-sv testbench.v 
	vvp a.out
	gtkwave resultados.vcd plantilla.gtkw

clear:
	rm *.vcd
	rm a.out 
	rm cpu_synth.v
	