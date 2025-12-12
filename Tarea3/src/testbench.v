`include "rom.v"
`include "ram.v"
//`include "cpu.v"
`include "cpu_synth.v"
`include "tester.v"
`include "cmos_cells.v"

module cpu_tb;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		ab_select;		// From ROM of rom.v
    wire		clk;			// From probador of tester.v
    wire [12:0]		data;			// From ROM of rom.v
    wire		equal;			// From CPU of cpu.v
    wire [11:0]		mem_addr;		// From CPU of cpu.v
    wire		mem_control;		// From CPU of cpu.v
    wire [7:0]		mem_data_in;		// From CPU of cpu.v
    wire [7:0]		mem_data_out;		// From RAM of ram.v
    wire [7:0]		op_addr;		// From ROM of rom.v
    wire [3:0]		opcode;			// From ROM of rom.v
    wire [11:0]		prog_addr;		// From CPU of cpu.v
    wire		request_ram;		// From CPU of cpu.v
    wire		request_rom;		// From CPU of cpu.v
    wire		rst;			// From probador of tester.v
    // End of automatics

    initial begin
        $dumpfile("resultados.vcd");
        $dumpvars(0, cpu_tb);
    end

    rom ROM(/*AUTOINST*/
	    // Outputs
	    .data			(data[12:0]),
	    .opcode			(opcode[3:0]),
	    .ab_select			(ab_select),
	    .op_addr			(op_addr[7:0]),
	    // Inputs
	    .rst			(rst),
	    .clk			(clk),
	    .request_rom		(request_rom),
	    .prog_addr			(prog_addr[11:0]));

    ram RAM(/*AUTOINST*/
	    // Outputs
	    .mem_data_out		(mem_data_out[7:0]),
	    // Inputs
	    .rst			(rst),
	    .clk			(clk),
	    .request_ram		(request_ram),
	    .mem_control		(mem_control),
	    .mem_addr			(mem_addr[11:0]),
	    .mem_data_in		(mem_data_in[7:0]));

    cpu CPU(/*AUTOINST*/
	    // Outputs
	    .prog_addr			(prog_addr[11:0]),
	    .mem_control		(mem_control),
	    .equal			(equal),
	    .mem_addr			(mem_addr[11:0]),
	    .mem_data_in		(mem_data_in[7:0]),
	    .request_rom		(request_rom),
	    .request_ram		(request_ram),
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .opcode			(opcode[3:0]),
	    .ab_select			(ab_select),
	    .op_addr			(op_addr[7:0]),
	    .mem_data_out		(mem_data_out[7:0]));
    
    tester probador (/*AUTOINST*/
		     // Outputs
		     .clk		(clk),
		     .rst		(rst));

endmodule
