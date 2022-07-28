## Sistemas empotrados de firmware y protocolos de comunicación (PONG MULTIPLAYER)

By : ![KJiron](https://github.com/kjiron) & ![RBrenes](https://github.com/Andrub21)


### Avances :

#### Semana 1

- [x] Prender LEDs.
- [x] Presionar un botón y el LED se prende.
- [x] Presionar un botón y el LED se apaga.
- [x] Pruebas iniciales con pantalla GLCD.
- [x] Pintar un pixel y moverlo según entradas.

#### Semana 2

- [x] Primeros uso del puerto UART
- [x] Test de la comunicación entre placas
- [x] Mover un pixel en cada pantalla por medio del UART

#### Semana 3

- [x] Crear entorno del juego
- [x] Definición de estructuras genéricas para el teclado

#### Semana 4

- [x] Finalizando el juego
- [x] Correción de bugs 

#### Semana 5

El proyecto logró obtener un juego basado en ![pong](https://www.youtube.com/watch?v=fiShX2pTz9A) 
en la placa de desarrollo de ![MikroE easypic](https://www.mikroe.com/easypic-dspic30), el resultado
final se encuentra en semana 5 que es donde los archivos necesarios se encuentran ubicados. El proyecto
utiliza el protocolo UART para lograr el modo de 2 jugadores permitiendo la comunicación entre ambos
MCU:


![placa_front](https://github.com/kjiron/proyecto-1-embebidos/blob/main/Images/placa_front)

![placa_back](https://github.com/kjiron/proyecto-1-embebidos/blob/main/Images/placa_back)


### Configuración del cristal

Esto es importante para tener la velocidad adecuada en la GLCD y ver reflejados los delays.

![cristal](https://github.com/kjiron/proyecto-1-embebidos/blob/main/configPIC/cristal.PNG)
