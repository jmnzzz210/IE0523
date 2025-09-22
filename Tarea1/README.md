
# Diseño conductual del cajero automático

En esta tarea se realiza el diseño de un controlador para un cajero automático, el cual va a poder realizar retiros y depósitos, además de tener las funcionalidades de un cajero, como lo son recibir un pin ingresado por el usuario y verificar que este sea el correcto, si se falla el pin 3 veces el cajero entrará en un estado de bloqueo y además también en un retiro verificará si el balance inicial de la cuenta es mayor que el monto, ya que si el monto es mayor que el balance inicial se debe de activar una salida llamada fondos insuficientes. 

## Diseño arquitectónico

A la hora de realizar el diseño se utilizó el siguiente diagrama de bloques:

<p align="center">
  <img src="./images/diagrama_bloques.png" alt="Diagrama de bloques">
</p>

Además, el diagrama ASM del controlador:

<p align="center">
  <img src="./images/diagrama_asm.png" alt="Diagrama ASM">
</p>

En la colocación del código, se colocaron los siguientes estados:

| Nombre del estado | Número asignado al estado |
| :---------------- | :-----------------------: |
| Esperando Tarjeta | 0 |
| Digitar número | 1 |
| Se digitaron 4 números | 2 |
| Elegir trámite | 3 |
| Digitar monto retiro | 4 |
| Digitar monto depósito | 5 |
| Actualización balance | 6 |
| Actualización balance retiro | 7 |
| Pin incorrecto 1 vez | 8 |
| Pin incorrecto 2 veces | 9 |
| Pin incorrecto 3 veces | 10 |

*Tabla 1: Estados y su número asignado en el código de Verilog.*

## Plan de pruebas
El controlador fue puesto bajo las siguientes pruebas con el fin de poder verificar su correcto funcionamiento ante situaciones para las cuales está diseñado, como lo es un retiro o un depósito, tanto como situaciones que podría sufrir en el día a día, como podría ser el que una persona olvide su clave y falle el pin 3 veces o también que recuerde el pin en el segundo intento. A continuación se presentan las pruebas a las cuales fue sometido el diseño, además se planteó una situación muy común, la cual es que el usuario no disponga de los fondos suficientes, entonces también se realizó la prueba para observar cómo reaccionar el controlador en un caso como este.

### Prueba I: Realización de un depósito básico
Esta prueba consiste en una situación a la cual se va a enfrentar el controlador, ya que esta es una de sus funciones básicas, la cual es que el cajero recibe la tarjeta, el usuario coloca su pin correctamente, se selecciona el monto deseado para el depósito y se debe de actualizar el balance de la cuenta, esta prueba su finalidad es demostrar que el diseño cumple con lo solicitado correctamente.

Estado de la prueba: Aprobado.

### Prueba II: Realización de un retiro básico
Esta prueba consiste en una situación a la que se va a enfrentar el controlador de manera muy común, la cual es la de realizar un retiro, esta prueba consiste en que el cajero recibe una tarjeta, se ingresa el pin correcto y se selecciona el monto que se desea retirar y en este caso el monto va a ser menor que el balance inicial, logrando así que se actualice el balance y se active la salida de entregar dinero, esta prueba su finalidad es verificar que el diseño funciona correctamente y activa la señal de entregar el dinero.

Estado de la prueba: Aprobado.

### Prueba III: Caso en donde la persona no tenga los fondos suficientes
Esta prueba consiste en una situación a la que muy probablemente vaya a enfrentar el controlador y esta es una prueba para verificar la correcta implementación de seguridad para que el cajero no otorgue más dinero del que contiene el usuario en su cuenta bancaria, ya que si el cajero otorga más dinero del que contiene el usuario sería un problema que perjudicaría al banco directamente.

Estado de la prueba:  Aprobado.

### Prueba IV: Se ingresa 3 veces un pin incorrecto
En esta prueba se verifica que el controlador sea capaz de poder actuar cuando un usuario falla el pin 3 veces, en este caso debería de bloquearse.

Estado de la prueba:  Aprobado.

### Prueba V: Un usuario realiza un trámite y luego llega otro usuario a realizar otro trámite
En esta prueba se verifica el funcionamiento del controlador cuando se tiene 2 trámites seguidos, esto ya que el controlador no solamente va a ser de un uso, este va a estar en un uso constante, por ende debe de funcionar correctamente ante dos trámites seguidos.

Estado de la prueba: Aprobado.

### Prueba VI: Un usuario obtiene fondos insuficientes y luego otro usuario realiza un retiro
En esta prueba se verifica que el funcionamiento del controlador después de que a un usuario se le otorgó la señal de fondos insuficientes sea el correcto, este funcionamiento se verifica a través de cómo se comporta en la transacción posterior a que se activó la señal de fondos insuficientes.

Estado de la prueba: Aprobado.

### Prueba VII: Un usuario bloquea el cajero y el siguiente usuario realiza un depósito
A través de esta prueba se busca verificar el correcto funcionamiento del controlador en la transacción posterior a que se tuvo un bloqueo debido al introducir tres veces el pin incorrecto, luego de que se bloquee el controlador y se active la señal de reset para poder sacarlo de este estado de bloqueo y poder utilizarlo nuevamente se introducirá otra tarjeta en la cual se realizará un depósito.

Estado de la prueba: Aprobado.

### Prueba VIII: Un usuario falla el pin 2 veces y en la tercera coloca correctamente el pin y el usuario que sigue también falla el pin 1 vez
Esta prueba consiste en que el primer usuario falla el pin 2 veces y en el tercer intento logra ingresar el pin correcto y realiza la transferencia que desea, seguido a esto el usuario que sigue también falla el pin 1 vez y en el segundo intento ya ingresa el pin correctamente y realizar el trámite deseado, esto es con el fin de poder observar que el controlador no acumule la cantidad de errores y se demuestre que cada vez que se ingresa una tarjeta el contador de fallos no arrastra números de usuarios anteriores.

Estado de la prueba: Aprobado.

### Prueba IX: Usuario solicita todo el dinero que tiene en su cuenta
Esta prueba lo que realiza es verificar si el controlador otorga el dinero cuando el usuario coloca en monto su balance inicial, o sea monto = balance_inicial, y verificar si realiza la actualización del balance y activa el balance_STB.

Estado de la prueba: Aprobado.

## Instrucciones para poder utilizar la simulación en donde se reflejan las pruebas realizadas

Para poder ejecutar la simulación se presentará a continuación la manera de poder ejecutarlo desde la terminal en linux. Para esto primero se debe de descargar los archivos nombrados como controlador.v, tester.v, testbench.v y Makefile, esto debido a que se necesitan los 4 archivos para poder ejecutar la simulación, porque en el controlador.v esta el código del controlador, en tester.v está toda la información de valores que toman las señales que entran al controlador y el tiempo en donde se activan las señales, el testbench.v que es donde se conecta al controlador con el tester y por último el archivo Makefile que será el encargado de realizar la simulación.

```bash
git clone https://github.com/jmnzzz210/IE0523
cd IE0523
cd Tarea1
make
```
