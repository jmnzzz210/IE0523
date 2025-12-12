`include "contr_synth.v"
`include "tester.v"
`include "cmos_cells.v"

module cajero_tb;
    wire clk, reset, tarjeta_recibida, tipo_trans, digito_stb, monto_stb, balance_stb, entregar_dinero, pin_incorrecto, advertencia, bloqueo, fondos_insuficientes;
    wire [3:0] digito;
    wire [15:0] pin_correcto;
    wire [31:0] monto;
    wire [63:0] balance_inicial;
    wire [63:0] balance_actualizado;

    initial begin
        $dumpfile("resultados.vcd");
        $dumpvars(0, cajero_tb);
    end

    
    tester tester_inst (
        .clk(clk),
        .reset(reset),
        .tarjeta_recibida(tarjeta_recibida),
        .tipo_trans(tipo_trans),
        .digito_stb(digito_stb),
        .digito(digito),
        .pin_correcto(pin_correcto),
        .monto_stb(monto_stb),
        .monto(monto),
        .balance_inicial(balance_inicial),
        .balance_stb(balance_stb),
        .balance_actualizado(balance_actualizado),
        .entregar_dinero(entregar_dinero),
        .pin_incorrecto(pin_incorrecto),
        .advertencia(advertencia),
        .bloqueo(bloqueo),
        .fondos_insuficientes(fondos_insuficientes)
    );


    controlador controlador_inst (
        .clk(clk),
        .reset(reset),
        .tarjeta_recibida(tarjeta_recibida),
        .tipo_trans(tipo_trans),
        .digito_stb(digito_stb),
        .digito(digito),
        .pin_correcto(pin_correcto),
        .monto_stb(monto_stb),
        .monto(monto),
        .balance_inicial(balance_inicial),
        .balance_stb(balance_stb),
        .balance_actualizado(balance_actualizado),
        .entregar_dinero(entregar_dinero),
        .pin_incorrecto(pin_incorrecto),
        .advertencia(advertencia),
        .bloqueo(bloqueo),
        .fondos_insuficientes(fondos_insuficientes)
    );

endmodule