module cpu (
    /*AUTOOUTPUT*/
    /*AUTOARG*/
   // Outputs
   prog_addr, mem_control, equal, mem_addr, mem_data_in, request_rom,
   request_ram,
   // Inputs
   clk, rst, opcode, ab_select, op_addr, mem_data_out
   );

//Entradas
input clk, rst;
input [3:0] opcode;
input ab_select;
input [7:0] op_addr;
input [7:0] mem_data_out;

//Salidas
output reg [11:0] prog_addr;
output reg mem_control;
output reg equal;
output reg [11:0] mem_addr;
output reg [7:0] mem_data_in;
output reg request_rom, request_ram;

// Estados
localparam Env_pos_ROM    = 3'b000;
localparam Espera_ROM     = 3'b001;
localparam Leer_datos     = 3'b010;
localparam Load_o_Store   = 3'b011;
localparam Espera_RAM     = 3'b100;
localparam Registro       = 3'b101;  
localparam Operaciones    = 3'b110;  
localparam fin            = 3'b111;

// Operaciones
localparam store = 4'b0100;
localparam load  = 4'b0011;
localparam add   = 4'b1001;
localparam sub   = 4'b1010;
localparam and_  = 4'b0010;
localparam or_   = 4'b0001;
localparam equal_op = 4'b0101;

reg [7:0] a, b, next_a, next_b;
reg [3:0] state, next_state;

// Regs para capturar datos
reg [3:0] opcode_reg, next_opcode_reg;
reg ab_select_reg, next_ab_select_reg;
reg [7:0] op_addr_reg, next_op_addr_reg;

reg next_mem_control, next_request_rom, next_request_ram;
reg [11:0] next_mem_addr;
reg [7:0] next_mem_data_in;
reg next_equal;

// Lógica secuencial
always @(posedge clk) begin
    if (!rst) begin // si reset se pone en cero el controlador vuelve a su estado inicial y todas las salidas toman el valor de cero.
        state <= Env_pos_ROM;
        prog_addr <= 12'b0;
        mem_control <= 0;
        mem_addr <= 12'b0;
        mem_data_in <= 8'b0;
        equal <= 0;
        a <= 8'b0;
        b <= 8'b0;
        request_rom <= 0;
        request_ram <= 0;
        opcode_reg <= 4'b0;
        ab_select_reg <= 0;
        op_addr_reg <= 8'b0;
    end else begin //ir actualizando los valores en cada ciclo de reloj
        state <= next_state;
        a <= next_a;
        b <= next_b;
        mem_control <= next_mem_control;
        mem_addr <= next_mem_addr;
        mem_data_in <= next_mem_data_in;
        request_rom <= next_request_rom;
        request_ram <= next_request_ram;
        opcode_reg <= next_opcode_reg;
        ab_select_reg <= next_ab_select_reg;
        op_addr_reg <= next_op_addr_reg;
        equal <= next_equal;
        
        if (next_state == Env_pos_ROM) begin
            prog_addr <= prog_addr + 1;
        end
    end
end

// Lógica combinacional
always @(*) begin
    // Valores por defecto
    next_state = state;
    next_a = a;
    next_b = b;
    next_mem_control = 0;
    next_mem_addr = 12'b0;
    next_mem_data_in = 8'b0;
    next_request_rom = 0;  
    next_request_ram = 0; 
    next_opcode_reg = opcode_reg;
    next_ab_select_reg = ab_select_reg;
    next_op_addr_reg = op_addr_reg;
    next_equal = equal;

    case (state)
        Env_pos_ROM: begin
            next_request_rom = 1;  // Activar la señal de la solicitud a la ROM
            next_state = Espera_ROM;
            next_equal = 0;
        end

        Espera_ROM: begin
            // al no colocar next_request_rom en 1 al tomar el valor por defecto se va a poner en cero
            next_state = Leer_datos;
        end

        Leer_datos: begin
            next_opcode_reg = opcode; // se registra el valor de opcode para no perderlo durante la ejecución del código restante
            next_ab_select_reg = ab_select; // se registra el valor de ab_select para no perderlo durante la ejecución del código restante
            next_op_addr_reg = op_addr; // se registra el valor de aop_addr para no perderlo durante la ejecución del código restante
            
            case (opcode)
                store: begin
                    next_state = Load_o_Store; // si opcode es store irse al estado de Load_o_Store
                end
                load: begin
                    next_state = Load_o_Store; // si opcode es load irse al estado de Load_o_Store
                end
                default: begin
                    next_state = Operaciones; // sino, irse al estado de operaciones
                end
            endcase
        end

        Load_o_Store: begin
            next_request_ram = 1;  // activar la señal de que en el siguiente flanco de reloj encender el request_ram
            next_mem_addr = op_addr_reg; //la dirección a la cual se quiere acceder en la ram se guarda en el registro de op_addr_reg
            
            case (opcode_reg)
                load: begin 
                    next_mem_control = 1; // como es una lectura el siguiente valor de mem_control debe ser mem_control = 1
                    next_state = Espera_RAM;
                end
                store: begin
                    next_mem_control = 0;  //como es una escritura el siguiente valor de mem_control debe ser mem_control = 0
                    if (ab_select_reg) begin
                        next_mem_data_in = b; //si ab_select = 1 se quiere realizar la escritura con el valor de b
                    end else begin
                        next_mem_data_in = a; //si ab_select = 1 se quiere realizar la escritura con el valor de a
                    end
                    next_state = Espera_RAM;
                end
            endcase
        end

        Espera_RAM: begin
            // request_ram se apaga automáticamente debido a los valores por defecto
            next_mem_control = mem_control;  // Mantener mem_control
            next_mem_addr = mem_addr;        // Mantener dirección de memoria 
            next_mem_data_in = mem_data_in;  // Mantener dato que va a entrar en la RAM
            
            case (opcode_reg)
                load: begin // si el opcode (solamente que ahora guardado en opcode_reg) es load irse a registro, sino irse al estado de inicio para continuar con la siguiente instruccion
                    next_state = Registro;
                end
                store: begin
                    next_state = Env_pos_ROM;
                end
            endcase
        end

        Registro: begin
            if (ab_select_reg) begin // se verifica a cual variable se le realiza el registro
                next_b = mem_data_out; //el valor de b después del flanco de reloj será el que entrega la RAM
            end else begin
                next_a = mem_data_out; //el valor de a después del flanco de reloj será el que entrega la RAM
            end
            next_state = Env_pos_ROM;
        end

        Operaciones: begin
            case (opcode_reg)
                add: begin // si se tiene una operación de suma, verificar en que variable se debe de guardar
                    if (ab_select_reg) begin
                        next_b = a + b; // el proximo valor de b será la suma de a y b
                    end else begin
                        next_a = a + b; // el proximo valor de a será la suma de a y b
                    end
                    next_state = Env_pos_ROM;
                end
                sub: begin // como no se especifica, por el momento el controlador solamente resta a con b (a - b) y no b con a (b - a)
                    if (ab_select_reg) begin
                        next_b = a - b; // el proximo valor de b será la resta de a y b
                    end else begin
                        next_a = a - b; // el proximo valor de a será la resta de a y b
                    end
                    next_state = Env_pos_ROM;
                end
                and_: begin // se realiza la and bit por bit de a y b y se guarda en su respectiva variable según ab_select.
                    if (ab_select_reg) begin
                        next_b = a & b;
                    end else begin
                        next_a = a & b;
                    end
                    next_state = Env_pos_ROM;
                end
                or_: begin // se realiza la or bit por bit de a y b y se guarda en su respectiva variable según ab_select.
                    if (ab_select_reg) begin
                        next_b = a | b;
                    end else begin
                        next_a = a | b;
                    end
                    next_state = Env_pos_ROM;
                end
                equal_op: begin //si se tiene que op code es equal hacer a= b, encender el flag e irse al estado de fin
                    next_a = b;
                    next_equal = 1;
                    next_state = fin;
                end
                default: begin
                    next_state = Env_pos_ROM;
                end
            endcase
        end
        
        fin: begin 
            next_equal = 1; //encender la bandera de equal en el estado de fin y no se va a otro, porque en este termina.
        end
        
        default: begin
            next_state = Env_pos_ROM;
        end
    endcase
end

endmodule