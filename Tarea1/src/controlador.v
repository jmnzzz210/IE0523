module controlador(
    clk, 
    reset,
    tarjeta_recibida, 
    tipo_trans, 
    digito_stb, 
    digito, 
    pin_correcto, 
    monto_stb,
    monto, 
    balance_inicial, 
    balance_stb, 
    balance_actualizado, 
    entregar_dinero, 
    pin_incorrecto, 
    advertencia,
    bloqueo, 
    fondos_insuficientes);

input clk;
input reset;
input tarjeta_recibida;
input tipo_trans;
input digito_stb;
input monto_stb;
input [3:0] digito;
input [15:0] pin_correcto;
input [31:0] monto;
input [63:0] balance_inicial;

output reg balance_stb, entregar_dinero, pin_incorrecto, advertencia, bloqueo, fondos_insuficientes;
output reg [63:0] balance_actualizado;

localparam Esperando_Tarjeta  = 4'b0000;
localparam Digitar_numero  = 4'b0001;
localparam Digitaron_cuatro  = 4'b0010;
localparam Elegir_tramite  = 4'b0011;
localparam Digitar_monto_retiro  = 4'b0100;
localparam Digitar_monto_depo  = 4'b0101;
localparam Act_balance  = 4'b0110;
localparam Act_balance_retiro  = 4'b0111;
localparam P_incorrecto_una  = 4'b1000;
localparam P_incorrecto_dos = 4'b1001;
localparam P_incorrecto_tres = 4'b1010;

reg [15:0] pin_ingresado;
reg [3:0] contador_digitos;
reg [3:0] state, next_state;
reg [1:0] contador_fallos;


//Lógica combinacional
always @(*) begin
    next_state = state;
    case (state)
    Esperando_Tarjeta: begin
        if (tarjeta_recibida == 1) begin
            next_state = Digitar_numero;
        end
    end

    Digitar_numero: begin //Estado en donde se están digitando los números del pin
        if (contador_digitos == 4'd4) begin //Cuando se digitan 4 números seguir al siguiente estado
            next_state = Digitaron_cuatro;
        end
    end

    Digitaron_cuatro: begin //Estado en donde se compara el pin ingresado con el pin correcto
        if (pin_ingresado == pin_correcto) begin
            next_state = Elegir_tramite;
        end else begin
            if (contador_fallos == 0)
                next_state = P_incorrecto_una;  // Primer fallo
            else if (contador_fallos == 1) 
                next_state = P_incorrecto_dos;  // Segundo fallo
            else 
                next_state = P_incorrecto_tres; // Tercer fallo
        end
    end

    Elegir_tramite: begin
         if (tipo_trans == 0) begin
                next_state = Digitar_monto_depo;
            end else begin
                next_state = Digitar_monto_retiro;
                end 
    end

    Digitar_monto_retiro: begin
        if (monto > balance_inicial)begin
                next_state = Esperando_Tarjeta;
                end else begin
                    next_state = Act_balance_retiro;
                    end
    end

    Digitar_monto_depo: begin
        if (monto_stb == 1) begin
        next_state = Act_balance;
        end
    end

    Act_balance: begin
        next_state = Esperando_Tarjeta;
    end

    Act_balance_retiro: begin
        next_state = Esperando_Tarjeta;
    end

    P_incorrecto_una: begin
        next_state = Digitar_numero; //Lo manda a digitar otra vez el pin
    end

    P_incorrecto_dos: begin
        next_state = Digitar_numero; //Lo manda a digitar otra vez el pin
    end

    P_incorrecto_tres: begin
        if (reset == 0) begin
            next_state = Esperando_Tarjeta;
        end

    end
    endcase

end

//Lógica secuencial
always @(posedge clk) begin
    if (reset == 0) begin
        balance_actualizado <= 0;
        entregar_dinero <= 0;
        pin_incorrecto <= 0;
        advertencia <= 0;
        bloqueo <= 0;
        fondos_insuficientes <= 0;
        pin_ingresado <= 0;
        contador_digitos <= 0;
        state <= Esperando_Tarjeta;
        contador_fallos <= 0; 
        
    end else begin
        

        case (state)
        Esperando_Tarjeta: begin //Estado donde se está esperando la tarjeta
            balance_actualizado <= 64'd0;
            balance_stb <= 0;
            fondos_insuficientes <= 0;
            pin_ingresado <= 16'd0;
            entregar_dinero <= 0;
            bloqueo <=0;
        end
        Digitar_numero: begin //Estado donde se digitan los 4 números del pin
            if (digito_stb == 1) begin
                pin_ingresado <= {pin_ingresado[11:0], digito};
                contador_digitos <= contador_digitos + 1;
            end
        end
        Digitaron_cuatro: begin //Estado donde ya está ingresado el pin de 4 dígitos
           if (pin_ingresado != pin_correcto) begin
           contador_fallos <= contador_fallos + 1;
           end
        end
        Elegir_tramite: begin //Estado donde se elige el trámite
            contador_fallos <= 0; //Se reinician los contadores
            contador_digitos <= 0;
            pin_incorrecto <= 0;
            advertencia <= 0;
        end

        Digitar_monto_retiro: begin //Estado donde se digita el monto de retiro y se verifica si es mayor o menor al balance inicial
            if (monto_stb == 1) begin
                if (monto > balance_inicial)begin
                fondos_insuficientes <= 1;
                end
            end
        end

        Digitar_monto_depo: begin //Estado en donde se digita el monto de depósito
            //En este estado, como se coloca el monto de una vez, no necesita ninguna lógica secuencial.
        end

        Act_balance: begin //Código para actualizar el balance
            balance_actualizado <= balance_inicial + monto;
            balance_stb <= 1;
            
        end

        Act_balance_retiro: begin //Estado en donde se actualiza el balance de la cuenta y se entrega el dinero
            balance_actualizado <= balance_inicial - monto;
            balance_stb <= 1;
            entregar_dinero <= 1;
            
        end

        P_incorrecto_una: begin //Estado en donde se falló el pin una vez
             contador_digitos <= 0; //Se reinicia la cuenta de dígitos para poder introducir un nuevo pin
             pin_incorrecto <= 1; //Se activa la salida de pin incorrecto
             pin_ingresado <= 0;
             
        end
        P_incorrecto_dos: begin //Estado en donde se falló el pin 2 veces
            contador_digitos <= 0; //Se reinicia la cuenta de dígitos para poder introducir un nuevo pin
            advertencia <= 1; //Se activa la advertencia
            pin_ingresado <= 0;
            
        end
        P_incorrecto_tres: begin //Estado en donde se falló el pin 3 veces
            bloqueo <= 1;
            
        end

        endcase
        state <= next_state;
    end
    
end
endmodule
