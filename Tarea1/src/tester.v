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
    clk = 0;
    reset = 0;
    tarjeta_recibida = 0;
    tipo_trans = 0;
    digito_stb = 0;
    monto_stb = 0;
    digito = 4'd0;
    pin_correcto = 16'd0;
    monto = 32'd0;
    balance_inicial = 64'd0;

    
    #4 reset = 1;           
    #2 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};

    //Bloque de pruebas para el depósito básico ---------------------------------------------------------------------------------------------------------------------------------------------
    
    //Introducir el pin
    // Primer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #2 digito_stb = 1;
    #2 digito_stb = 0;

    #1 balance_inicial = 64'd10000;
    #2 monto = 32'd2500;      
    #3 monto_stb = 1;           
    #2 monto_stb = 0;
    #2 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    
    
    //Fin bloque de pruebas para el depósito básico --------------------------------------------------------------------------------------------------------------------------------------
   

    //Bloque de pruebas para el retiro válido-----------------------------------------------------------------------------------------------------------------------------------
    #2 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    //Introducir el pin
    
    #2 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #2 digito_stb = 1;
    #2 digito_stb = 0;

    #0 tipo_trans = 1;
    #1 balance_inicial = 64'd10000;
    #2 monto = 32'd2500;      
    #4 monto_stb = 1;           
    #2 monto_stb = 0;
    #0 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    
    //Fin bloque de prueba de retiro válido------------------------------------------------------------------------------------------------------------------------------------------------

    //Inicio de bloque de prueba para fondos insuficientes ----------------------------------------------------------------------------------------------------------------------------------
    #2 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    //Introducir el pin
    //Primer dígito
    #2 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #2 digito_stb = 1;
    #2 digito_stb = 0;

    #0 tipo_trans = 1;
    #1 balance_inicial = 64'd10000;
    #2 monto = 32'd25000;      
    #3 monto_stb = 1;           
    #2 monto_stb = 0;
    #0 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;

    //Fin prueba de fondos insuficientes 

    //---------------------------------------------------------------------------------------------------------------------------------------------
    /*
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Bloque de prueba de pines incorrectos
    */
    #2 tarjeta_recibida=1;
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    
    //Primer Intento

    //Primer dígito
    #2 digito = 4'd3;
    #2 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #2 digito_stb = 1;
    #2 digito_stb = 0;

    //Segundo intento 

    //Primer dígito
    #7 digito = 4'd3;
    #2 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd0;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    //Tercer intento

    //Primer dígito
    #5 digito = 4'd3;
    #2 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd2;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #2 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #2 digito_stb = 1;
    #2 digito_stb = 0;

    //Reinicio
    #10 reset = 0;
    #2 reset = 1;
    #0 tarjeta_recibida = 0;
    
    
    /* 
    Fin bloque de prueba de pines incorrectos
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    */

    /* Bloque de prueba para usuario obtiene fondos insuficientes y el siguiente realiza un retiro*/
    #2 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    
    // Primer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    


    #0 tipo_trans = 1;
    #1 balance_inicial = 64'd1000;
    #2 monto = 32'd1250;      
    #2 monto_stb = 1;           
    #4 monto_stb = 0;
    #2 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;

    #8 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd1, 4'd2, 4'd3, 4'd4};

     // Primer dígito 
    #1 digito = 4'd1;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd4;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    #0 tipo_trans = 1;
    #1 balance_inicial = 64'd500;
    #0 digito = 4'd0;
    #2 monto = 32'd250;      
    #2 monto_stb = 1;           
    #4 monto_stb = 0;
    #2 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0; 
    
    
    /*
    Fin bloque de prueba de fondos insuficientes y retiro
    */
    /* Inicio bloque de pruebas para bloqueo y luego un deposito */
    
    #2 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    
    // Primer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd8;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    

    //SEGUNDO INTENTO
    // Primer dígito 
    #8 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd8;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    //TERCER INTENTO

    // Primer dígito 
    #8 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd8;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    //Reinicio
    #10 reset = 0;
    #0 tarjeta_recibida = 0;
    #2 reset = 1;
    
    #8 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd1, 4'd2, 4'd3, 4'd4};

    // Primer dígito 
    #2 digito = 4'd1;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd4;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    #0 tipo_trans = 0;
    #1 balance_inicial = 64'd100000;
    #0 digito = 4'd0;
    #2 monto = 32'd25000;      
    #2 monto_stb = 1;           
    #4 monto_stb = 0;
    #2 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;
    
    
    /*Fin bloque de pruebas de un usuario bloquea el cajero y el siguiente usuario realiza un deposito */

    /*Inicio bloque de pruebas de usuario falla 2 veces y el otro solo 1 */

    #2 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd3, 4'd9, 4'd7, 4'd2};
    // Primer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd8;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    

    //SEGUNDO INTENTO
    // Primer dígito 
    #8 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd8;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    //TERCER INTENTO

    // Primer dígito 
    #8 digito = 4'd3;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd9;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd7;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    #0 tipo_trans = 1;
    #1 balance_inicial = 64'd100;
    #2 monto = 32'd50;      
    #2 monto_stb = 1;           
    #4 monto_stb = 0;
    #2 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0;

    #8 tarjeta_recibida = 1; 
    #0 pin_correcto = {4'd1, 4'd2, 4'd3, 4'd4};

    // Primer dígito 
    #1 digito = 4'd1;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd1;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd4;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    //SEGUNDO INTENTO
    // Primer dígito 
    #6 digito = 4'd1;
    #1 digito_stb = 1;      
    #2 digito_stb = 0;
    
    // Segundo dígito 
    #2 digito = 4'd2;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Tercer dígito 
    #2 digito = 4'd3;
    #1 digito_stb = 1;
    #2 digito_stb = 0;
    
    // Cuarto dígito 
    #2 digito = 4'd4;
    #1 digito_stb = 1;
    #2 digito_stb = 0;

    #0 tipo_trans = 1;
    #1 balance_inicial = 64'd2500;
    #0 digito = 4'd0;
    #2 monto = 32'd2500;      
    #2 monto_stb = 1;           
    #4 monto_stb = 0;
    #2 tarjeta_recibida = 0;  
    #0 monto = 32'd0;
    #0 balance_inicial = 64'd0;
    #0 pin_correcto = 16'd0; 
    
    /*
    Fin bloque de pruebas de usuario falla 2 veces y el otro solo 1 
    */


    #10 $finish;  // Fin de simulación
end

always begin
    #1 clk = !clk;  //Reloj periodo 2
end

endmodule