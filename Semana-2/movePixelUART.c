//DATA DIRECTION -> output/input -> TRIS -> 0/1
//READ LEVELS OF THE PIN -> PORT
//OUTPUT LATCH -> LAT
//Important to configure the clock in the right way: https://forum.mikroe.com/viewtopic.php?t=10646

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>


//typedef unsigned char uint8_t;


//arte maded in: https://www.piskelapp.com/
// ------------------------------------------------------
// GLCD Picture name: pantallaDeInicio.bmp
// GLCD Model: KS0108 128x64
// ------------------------------------------------------

const code char pantallaDeInicio[1024] = {
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255, 143, 143, 143, 143, 143, 143, 143, 143, 143, 255, 255, 255, 255,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255,  15,  15,  15,  15,  15,  15,  15, 255, 255, 255, 255,   0,   0,   0,   0,   0, 255, 255, 255, 255,  31, 255, 255, 240, 240, 128,   0,   0,   0,   0, 255, 255, 255, 255,   0,   0, 224, 224, 254, 254,  30,  31,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255, 128, 128, 128, 128, 128, 128, 128, 255, 255, 255, 255,   0,   0,   0,   0,   0, 255, 255, 255, 255,   0,   0,   7,   7, 127, 127, 120, 120, 248, 128, 255, 255, 255, 255,   0,   0,  31,  31, 255, 255, 240, 240, 128, 128, 158, 158, 158, 158, 158, 254, 254, 254, 252,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 224, 224,   0, 128, 128, 192, 224,  96,   0,   0,   0,  96,  96,  96, 227, 227,  99,  99,  96,   0,   0, 224, 224,   0,   0, 192, 192, 192, 192, 192, 192,   0,   0, 192, 192, 192, 192, 199, 199, 199,   7,   7, 231, 231, 199,   7,   7, 231, 231,   7,   7,   7,   0,   0,   0,   0,   0, 199, 199, 199, 199, 192, 192,   0,   0, 192, 192, 192, 192, 199, 199, 199,   7, 199, 199, 192, 192, 192, 192,   0, 192, 192, 199, 199, 199, 199,   7, 231, 231, 199,   7,   7, 231, 231,   0, 192, 192, 192, 192, 192, 192, 192,   0,   0, 192, 192, 192, 192, 192,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 127, 127,   7,  15,  15,  29,  56, 120, 112,   0,   0,  96,  96,  96, 127, 127,   0,   0,   0,   0,   0, 127, 127,   0,   0, 127, 127,  12,  30, 127, 119,   0,   0, 127, 127,  96,  96,  96, 127, 127,   0,   0, 127, 127,   3,  15,  60, 127, 127,   0,   0,   0,  96,  96,   0,   0,   0, 127, 127,  12,  30, 127, 119,   0,   0, 127, 127, 102, 102, 102, 127,  63,   0, 127, 127,  12,  30, 127, 119,   0, 127, 127, 102,  96,  96,  96,   0, 127, 127,   3,  15,  60, 127, 127,   0, 127, 127, 102,  96,  96,  96,  96,   0,   0, 111, 111, 108, 125, 125,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  96,  96,  96, 224, 224,  96,  96,  96,  96,   0, 224, 224,  96,  96, 224, 224,   0, 224, 224,   0,   0,   0, 224, 224,   0,   0,   0,   0, 224, 224,  96,  96,  96,  96,   0, 224, 224,  96,  96,  96, 224, 224,   0,   0,   0,   0, 224, 224,  96,  96,  96,  96,   0,   0, 224, 224, 192,   0, 128, 192, 224, 224,   0,   0, 224, 224,  96,  96, 224, 224, 224,   0, 224, 224,  96,  96,  96,  96,   0, 224, 224,  96,  96, 224, 224,   0,   0, 224, 224,   0,   0, 224, 224, 224, 224, 192,   0,   0, 224, 224,  96,  96,  96, 224, 224,   0, 224, 224,  96, 224, 224,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  63,  63,   0,   0,   0,   0,   0,  63,  63,   6,   6,  63,  63,   0,  63,  63,  48,  48,   0,  63,  63,  48,  48,   0,   0,  63,  63,  51,  48,  48,  48,   0,  63,  63,   6,   6,  15,  63,  59,   0,   0,   0,   0,  63,  63,  51,  48,  48,  48,   0,   0,  63,  63,   3,   7,   7,   1,  63,  63,   0,   0,  63,  63,  51,  51,  63,  31,  31,   0,  63,  63,  51,  48,  48,  48,   0,  63,  63,  51,  51,  63,  31,   0,   0,  63,  63,   0,   0,  63,  63,  48,  57,  31,  15,   0,  63,  63,  48,  48,  48,  63,  63,   0,  55,  55,  54,  62,  62,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 248, 248, 216,  24,  24,  24,   0,   0,   0, 248, 248, 152, 216, 248, 248,   0,   0, 252, 252,   0,   0, 124, 124, 192, 192,   0, 192, 224, 124, 124,   0,   0, 248, 248, 216,  24,  24,  24,   0,   0, 248, 248, 152, 216, 248, 248,   0, 248, 248, 152, 152, 248, 248,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  15,  15,  12,  12,  12,  12,   0,   0,   0,  15,  15,   1,   3,  15,  14,   0,   0,  15,  15,   0,   0,   0,   0,   3,  15,  12,  15,   3,   0,   0,   0,   0,  15,  15,  12,  12,  12,  12,   0,   0,  15,  15,   1,   3,  15,  14,   0,  15,  15,   1,   1,  15,  15,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
};


const code char seleccionDeJuego[1024] = {
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255, 143, 143, 143, 143, 143, 143, 143, 143, 143, 255, 255, 255, 255,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255,  15,  15,  15,  15,  15,  15,  15, 255, 255, 255, 255,   0,   0,   0,   0,   0, 255, 255, 255, 255,  31, 255, 255, 240, 240, 128,   0,   0,   0,   0, 255, 255, 255, 255,   0,   0, 224, 224, 254, 254,  30,  31,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   0,   0,   0,   0,   0,   0, 255, 255, 255, 255, 128, 128, 128, 128, 128, 128, 128, 255, 255, 255, 255,   0,   0,   0,   0,   0, 255, 255, 255, 255,   0,   0,   7,   7, 127, 127, 120, 120, 248, 128, 255, 255, 255, 255,   0,   0,  31,  31, 255, 255, 240, 240, 128, 128, 158, 158, 158, 158, 158, 254, 254, 254, 252,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   3,   3,   3,   3,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   0,   0,   0,   0,   0,   7,   7,   7,   7,   0,   0,   0,   0,   0,   0,   0,   0,   7,   7,   7,   7,   7,   7,   0,   0,   0,   0,   0,   0,   0,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 192, 192, 192, 192,   0,   0,   0,   0,   0,   0,   0, 224, 224,  96,  96,  96, 224, 224,   0,   0, 224, 224,   0,   0,   0,   0, 224, 224,  96,  96,  96, 224, 224,   0,   0, 224, 224,   0,   0, 224, 224,   0,   0, 224, 224,  96,  96,  96,  96,   0,   0, 224, 224,  96,  96, 224, 224,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  96,  96, 127, 127,  96,  96,   0,   0,   0,   0,   0, 127, 127,   6,   6,   6,   7,   7,   0,   0, 127, 127,  96,  96,  96,   0, 127, 127,   6,   6,   6, 127, 127,   0,   0,   1,   3, 127, 127,   3,   1,   0,   0, 127, 127, 102,  96,  96,  96,   0,   0, 127, 127,  12,  30, 127, 115,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 176, 176, 176, 176, 240, 240,   0,   0,   0,   0,   0, 248, 248, 152, 152, 152, 248, 248,   0,   0, 248, 248,   0,   0,   0,   0, 248, 248, 152, 152, 152, 248, 248,   0,   0, 120, 248, 192, 192, 248, 120,   0,   0, 248, 248, 152,  24,  24,  24,   0,   0, 248, 248,  24, 152, 248, 248,   0, 248, 248, 152, 152, 152, 152,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  15,  15,  13,  13,  13,  13,   0,   0,   0,   0,   0,  31,  31,   1,   1,   1,   1,   1,   0,   0,  31,  31,  24,  24,  24,   0,  31,  31,   1,   1,   1,  31,  31,   0,   0,   0,   0,  31,  31,   0,   0,   0,   0,  31,  31,  25,  24,  24,  24,   0,   0,  31,  31,   3,   7,  31,  28,   0,  13,  13,  13,  13,  15,  15,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
};




// Glcd module connections
//https://download.mikroe.com/documents/compilers/mikroc/pic/help/graphic_lcd_library.htm
char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at LATB0_bit;
sbit GLCD_CS2 at LATB1_bit;
sbit GLCD_RS  at LATB2_bit;
sbit GLCD_RW  at LATB3_bit;
sbit GLCD_EN  at LATB4_bit;
sbit GLCD_RST at LATB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;
// End Glcd module connections


void primerFrame(void);
//void segundoFrame(void);





typedef struct
{
  uint8_t positionX, positionY;
} Objeto;


typedef struct
{
  uint8_t posX, posY;
  int8_t dx, dy;
} Generic;



typedef struct 
{
  bool up, down, right, left, enter;
} Keys;

uint8_t kkk = 0;

Objeto movePlayer(Objeto);
uint8_t menuDeJuego(uint8_t);
Keys readKeys(void);
void checkWallCollision(Generic *);




void UARTx_Write2(void *arg_data, size_t n)
{
    uint8_t c;
    uint8_t *p = (uint8_t *)arg_data;
    size_t i;
    for (i = 0; i < n; i++) {
        //while (UART1_Tx_Idle() != 1) {}
        c = p[i];
        UART1_Write(c);
    }
}

void UARTx_Read2(void *arg_data, size_t n)
{
    char *p = (char *)arg_data;
    size_t i;
    for (i = 0; i < n; )
    {
     if (UART_Data_Ready() == 1) {
         p[i] = UART1_Read(); 
         i++;
      }
      
          
    }
}


size_t strlen(char *str) {
  size_t i;
  for (i = 0; str[i] != 0; i++)
  {
    
  }
  return i;
}


Generic moveBall(Generic ball)
{ 
  ball.posX = ball.posX + ball.dx;
  ball.posY = ball.posY + ball.dy;
  return ball;
}


bool check_collision(Generic _ball, Objeto player)
{
    return (_ball.posX) < (player.positionX) + (player.positionX + 2) &&
       (_ball.posX) + (_ball.posX + 3) > (player.positionX) &&
       (_ball.posY) < (player.positionY + player.positionY + 14) &&
       (_ball.posY + 14 + _ball.posY) > (player.positionY);
}

// randint(10) -> 0 .. 10
uint8_t randint(uint8_t n)
{
    return (uint8_t)(rand() % (n+1));
}

char culo[128];

void main() {
  //position of the pixel

  Objeto playerOne = {122,18};
  Objeto playerTwo = {5,18};
  Generic ball = {64, 32, -1, 1}; //iba a asignar el radio pero el siempre es constante e incluso el color r = 3 y c = 1
  Keys key;
  //este estado es necesario para ejemplificar el modo UART
  uint8_t state = 3;
  uint8_t modeGame = 0;
  uint8_t randNum = 0;
  char buffer;
  
  //aqui una funcion para configurar puertos
  UART1_Init(9600);
  Delay_ms(100);
  ADCON1=0x0F;
  
  Glcd_Init();                                   // Initialize GLCD
  Glcd_Fill(0x00);                               // Clear GLCD

  while (1)
  {
    switch (state)
    {
    case 0:
      //portada
      primerFrame();
      state = 1;
      break;
    
    case 1:
      Glcd_Image(seleccionDeJuego);
      Glcd_Circle(25, 34, 4, 1);
      
      while (1)
      {
        key = readKeys();

        if ((key.enter) && (modeGame == 0))
        {
          Delay_ms(20);
          state = 2;
          break;
        }

        if ((modeGame == 0) && ((key.down) || (key.up)))
        {
          Glcd_Fill(0x00);
          Glcd_Image(seleccionDeJuego);
          Glcd_Circle(25, 48, 4, 1);
          Delay_ms(1000);
          modeGame = 1;
        }


        if ((key.enter == 1) && (modeGame == 1))
        {
          Delay_ms(20);
          state = 3;
          break;
        }

        if ((modeGame == 1) && ((key.down) || (key.up)))
        {
          Glcd_Fill(0x00);
          Glcd_Image(seleccionDeJuego);
          Glcd_Circle(25, 35, 4, 1);
          Delay_ms(1000);
          modeGame = 0;
        }       
      }
      Delay_ms(1000);
      Glcd_Fill(0x00); 
      break;
        
    case 2:
      //single player
      Glcd_Dot(playerOne.positionX, playerOne.positionY, 2);
      Delay_ms(10);      
      playerOne = movePlayer(playerOne);
      break;
    
    case 3:
      //multiplayer
      //esta seccion hace referencia al transmisor osea TX
      //setear el valor de la paleta cuando se sale de la pantalla


      /*
      if(UART_Tx_Idle() == 1){
        ball = moveBall(ball);
        checkWallCollision(&ball);
        playerOne = movePlayer(playerOne);

        //para player1
        if (((ball.posX + 3 ) > (playerOne.positionX)) & (ball.posY > playerOne.positionY) & (ball.posY < (playerOne.positionY + 14)))
        {
          ball.dx = -1;
          //0 a 1
          randNum = randint(1);
          if (randNum == 0)
          {
            ball.dy = -1;
          }
          if (randNum == 1)
          {
            ball.dy = 1;
          }    
        }

        UART1_Write(0xFF);    
        UARTx_Write2(&playerOne, sizeof(Objeto)); //esta funcion llama a UARTx_Write() según el tamaño de la data
        UART1_Write(0xDD);    
        UARTx_Write2(&ball, sizeof(Generic)); 

      }
      */

      if(UART_Data_Ready() == 1){
        Glcd_Fill(0x00);

        //buffer = UART_Read();

       UARTx_Read2(&buffer, 1);

        if (buffer == 0xEE || 0) {
          //Delay_ms(30);
          UARTx_Read2(&playerTwo, sizeof(Objeto));
          //UARTx_Read2(culo, 10);
          //Delay_ms(1000);
         
        }
      }
  
       //UARTx_Write2(culo, 15); 
      Glcd_Fill(0x00);
      Delay_ms(50);
      Glcd_Rectangle(playerOne.positionX, playerOne.positionY, playerOne.positionX + 2, playerOne.positionY + 14, 1);
      Glcd_Rectangle(playerTwo.positionX, playerTwo.positionY, playerTwo.positionX - 2, playerTwo.positionY + 14, 1);
      Glcd_Circle(ball.posX, ball.posY, 3, 1);

      //Glcd_Circle_Fill(playerOne.positionX, playerOne.positionY, 4, 1);
      //Glcd_Circle_Fill(playerTwo.positionX, playerTwo.positionY, 4, 1);
      Delay_ms(10);
      break;


    default:
      break;

  
    }

  }
}

void primerFrame(void){
  Glcd_Image(pantallaDeInicio);
  Delay_ms(4000);
  Glcd_Fill(0x00);
  
}

Objeto movePlayer(Objeto player)
{
  Keys key;
  key = readKeys();

  if (key.right){
    //Glcd_Fill(0x00);
    //Delay_ms(5);
    player.positionX = player.positionX + 1;
  }

  if (key.left){
    //Glcd_Fill(0x00);
    //Delay_ms(5);
    player.positionX = player.positionX - 1;
  }


  if (key.down){
    //Glcd_Fill(0x00);
    //Delay_ms(5);
    player.positionY = player.positionY + 1;
  }

  if (key.up){
    //Glcd_Fill(0x00);
    //Delay_ms(5);
    player.positionY = player.positionY - 1;
  }

  return player;
}




Keys readKeys(void)
{

  Keys tmp;
  tmp.right = PORTA.B0 == 1;
  tmp.left  = PORTA.B1 == 1;
  tmp.up    = PORTA.B2 == 1;
  tmp.down  = PORTA.B3 == 1;
  tmp.enter = PORTA.B4 == 1;
  return tmp;
}


void checkWallCollision(Generic *ball_tmp)
{
  
  if (ball_tmp->posY > 60){
      ball_tmp->dy = -1;
  }

  if (ball_tmp->posX < 5){
      ball_tmp->dx = 1;
  }

  if (ball_tmp->posY < 5){
      ball_tmp->dy = 1;
  }

  if (ball_tmp->posX > 124){
      ball_tmp->dx = -1;
  }

}