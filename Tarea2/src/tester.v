module tester (
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

input balance_stb, entregar_dinero, pin_incorrecto, advertencia, bloqueo, fondos_insuficientes;
input [63:0] balance_actualizado;

output reg clk, reset, tarjeta_recibida, tipo_trans, digito_stb, monto_stb;
output reg [3:0] digito;
output reg [15:0] pin_correcto;
output reg [31:0] monto;
output reg [63:0] balance_inicial;

initial begin
    clk = 1;
    reset = 0;
    tarjeta_recibida = 0;
    tipo_trans = 0;
    digito_stb = 0;
    monto_stb = 0;
    digito = 4'd0;
    pin_correcto = 16'd0;
    monto = 32'd0;
    balance_inicial = 64'd0;

    #100 reset = 1;
    
    //Bloque de pruebas para el depósito básico ---------------------------------------------------------------------------------------------------------------------------------------------
    #0 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};

    //Introducir el pin
    // Primer dígito 
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 balance_inicial = 64'd100;
    #100 monto = 32'd250;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 pin_correcto = 16'd0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    
    //Fin bloque de pruebas para el depósito básico --------------------------------------------------------------------------------------------------------------------------------------
   

    //Bloque de pruebas para el retiro válido-----------------------------------------------------------------------------------------------------------------------------------
    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};

    //Introducir el pin
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 1;
    #0 balance_inicial = 64'd100;
    #100 monto = 32'd25;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 pin_correcto = 16'd0;
    #0 balance_inicial = 64'd0;
    
    //Fin bloque de prueba de retiro válido------------------------------------------------------------------------------------------------------------------------------------------------

    //Inicio de bloque de prueba para fondos insuficientes ----------------------------------------------------------------------------------------------------------------------------------
    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};

    //Introducir el pin
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 1;
    #0 balance_inicial = 64'd100;
    #100 monto = 32'd125;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #0 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    
    //Fin prueba de fondos insuficientes 

    //---------------------------------------------------------------------------------------------------------------------------------------------
    /*
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Bloque de prueba de pines incorrectos
    */
    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};

    //Primer intento
    //Introducir el pin
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd0;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd0;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //Segundo intento 

    //Primer dígito
    #400 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd0;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    //Tercer intento

    //Primer dígito
    #400 digito = 4'd3;
    #100 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd2;
    #100 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //Reinicio
    #400 reset = 0;
    #100 reset = 1;
    #0 tarjeta_recibida = 0;
    
    
    /* 
    Fin bloque de prueba de pines incorrectos
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    */

    /* Bloque de prueba para usuario obtiene fondos insuficientes y el siguiente realiza un retiro*/
    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    
    // Primer dígito 
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 1;
    #0 balance_inicial = 64'd1000;
    #100 monto = 32'd1250;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;

    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd1, 4'd2, 4'd3, 4'd4};

     // Primer dígito 
    #100 digito = 4'd1;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd4;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 1;
    #0 balance_inicial = 64'd500;
    #0 digito = 4'd0;
    #100 monto = 32'd250;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;
    
    /*
    Fin bloque de prueba de fondos insuficientes y retiro
    */
    /* Inicio bloque de pruebas para bloqueo y luego un deposito */

    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    
    // Primer dígito 
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd8;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //SEGUNDO INTENTO
    // Primer dígito 
    #400 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd8;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //TERCER INTENTO

    // Primer dígito 
    #400 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd8;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //Reinicio
    #300 reset = 0;
    #0 tarjeta_recibida = 0;
    #200 reset = 1;
    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd1, 4'd2, 4'd3, 4'd4};

    // Primer dígito 
    #200 digito = 4'd1;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd4;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 0;
    #0 balance_inicial = 64'd100000;
    #0 digito = 4'd0;
    #100 monto = 32'd25000;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;
    
    /*Fin bloque de pruebas de un usuario bloquea el cajero y el siguiente usuario realiza un deposito */

    /*Inicio bloque de pruebas de usuario falla 2 veces y el otro solo 1 */

    
    #100 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    // Primer dígito 
    #200 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd8;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //SEGUNDO INTENTO
    // Primer dígito 
    #400 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd8;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //TERCER INTENTO

    // Primer dígito 
    #400 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd9;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd7;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 1;
    #0 balance_inicial = 64'd100;
    #100 monto = 32'd50;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;

    #200 tarjeta_recibida = 1;
    #0 pin_correcto = {4'd1, 4'd2, 4'd3, 4'd4};

    // Primer dígito 
    #200 digito = 4'd1;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd1;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd4;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    //SEGUNDO INTENTO
    // Primer dígito 
    #400 digito = 4'd1;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Segundo dígito 
    #100 digito = 4'd2;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Tercer dígito 
    #100 digito = 4'd3;
    #0 digito_stb = 1;
    #100 digito_stb = 0;
    
    // Cuarto dígito 
    #100 digito = 4'd4;
    #0 digito_stb = 1;
    #100 digito_stb = 0;

    #200 tipo_trans = 1;
    #0 balance_inicial = 64'd2500;
    #0 digito = 4'd0;
    #100 monto = 32'd500;
    #0 monto_stb = 1;
    #100 monto_stb = 0;
    #100 tarjeta_recibida = 0;
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;
    
    /*
    Fin bloque de pruebas de usuario falla 2 veces y el otro solo 1 
    */

    #400 $finish;
end

always begin
    #50 clk = !clk;
end

endmodule