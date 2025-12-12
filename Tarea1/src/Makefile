all:
	iverilog testbench.v
	vvp a.out
	gtkwave resultados.vcd

clear:
	rm *.vcd
	rm a.out