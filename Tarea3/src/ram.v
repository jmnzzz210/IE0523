module ram (/*AUTOARG*/
   // Outputs
   mem_data_out,
   // Inputs
   rst, clk, request_ram, mem_control, mem_addr, mem_data_in
   );


    initial begin
        memory[0] <= 8'b00000011; // primera posición 3
        memory[1] <= 8'b00001001; // segunda posición 9 
        memory[2] <= 8'b00000111; // tercera posición 7
        memory[3] <= 8'b00000010; // cuarta posición 2, formando así las 4 primeras posiciones los últimos 4 dígitos de mi carné C33972
        memory[5] <= 8'b00000010; //2
        memory[10] <= 8'b00000010; //2
        memory[20] <= 8'b00000001;
        memory[25] <= 8'b00000101; //5
    end

  localparam ESCRITURA = 0;
  localparam LECTURA   = 1;

  input         rst, clk, request_ram, mem_control;
  input      [11:0] mem_addr;
  output reg [7:0] mem_data_out;
  input      [7:0] mem_data_in;

  reg [7:0] memory[31:0];

  always @(posedge clk) begin
    if (request_ram && rst) begin
      case (mem_control)
        ESCRITURA: memory[mem_addr] <= mem_data_in;
        LECTURA:   mem_data_out        <= memory[mem_addr];
      endcase
    end else begin
        mem_data_out <= '0;


      end

  end
endmodule