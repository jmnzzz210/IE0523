module rom (/*AUTOARG*/
   // Outputs
   data, opcode, ab_select, op_addr,
   // Inputs
   rst, clk, request_rom, prog_addr
   );

    input         rst, clk, request_rom;
    input [11:0]   prog_addr;
    output reg [12:0] data;
    output [3:0]  opcode;
    output        ab_select;
    output [7:0] op_addr;

    // Memoria para almacenar las instrucciones
    reg [12:0] rom_memory [0:9];

    assign opcode = data[12:9];
    assign ab_select = data[8]; // Si quiero el valor de A es cero y si quiero B es 1
    assign op_addr  = data[7:0];

  // Initial block para inicializar y cambiar después de cierto tiempo
  initial begin
    // Inicializar con la primera prueba
    rom_memory[0] <= 13'b0011_0_00000101; // Load a from 005
    rom_memory[1] <= 13'b0011_1_00001010; // Load b from 010
    rom_memory[2] <= 13'b1001_1_00000000; // ADD a + b y guardar en b
    rom_memory[3] <= 13'b0100_0_00001111; // Store a at 015 
    rom_memory[4] <= 13'b0100_1_00010100; // Store b at 020
    rom_memory[5] <= 13'b0011_0_00010100; // LOAD a from 020
    rom_memory[6] <= 13'b0011_1_00011001; // LOAD b from 025
    rom_memory[7] <= 13'b0101_0_00000000; // EQUAL a to b
    #500; // Cambiar instrucciones después de 500 segundos

    //Segunda prueba
    rom_memory[0] <= 13'b0011_0_00000001;  // Load a from 001
    rom_memory[1] <= 13'b0011_1_00000010;  // Load b from 002
    rom_memory[2] <= 13'b1010_1_00000000;  // SUB a - b y guardar en b
    rom_memory[3] <= 13'b0100_1_00000110;  // Store b at 006
    rom_memory[4] <= 13'b0011_1_00000010;  // Load b from 002
    rom_memory[5] <= 13'b0010_1_00000000;  // AND a && b y guardar en b
    rom_memory[6] <= 13'b0001_0_00000000;  // OR a || b y guardar en a
    rom_memory[7] <= 13'b0100_0_00000111;  // Store a at 007
    rom_memory[8] <= 13'b0100_1_00001010;  // STORE B at 010
    rom_memory[9] <= 13'b0101_0_00000000;  // EQUAL a to b
  end

  always @(posedge clk) begin
    if (request_rom && rst) begin
        data <= rom_memory[prog_addr];
    end else begin
      data <= '0;
    end
  end
endmodule