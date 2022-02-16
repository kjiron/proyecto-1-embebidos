//DATA DIRECTION -> output/input -> TRIS -> 0/1
//READ LEVELS OF THE PIN -> PORT
//OUTPUT LATCH -> LAT
//Important to configure the clock in the right way: https://forum.mikroe.com/viewtopic.php?t=10646

#include <stdint.h>


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



void main() {
  //position of the pixel

  Objeto playerOne = {62,32};
  Objeto playerTwo = {30,15};
  //este estado es necesario para ejemplificar el modo UART
  uint8_t state = 3;
  uint8_t modeGame = 0;
  char buffer;
  
  
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
      primerFrame();
      state = 3;
      break;
    
    case 1:
      Glcd_Image(seleccionDeJuego);
      Glcd_Circle(25, 34, 4, 1);
      while (1)
      {
        if ((PORTA.B4 == 1) && (modeGame == 0))
        {
          Delay_ms(20);
          state = 2;
          break;
        }

        if ((modeGame == 0) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
        {
          Glcd_Fill(0x00);
          Delay_ms(20);
          Glcd_Image(seleccionDeJuego);
          Glcd_Circle(25, 48, 4, 1);
          Delay_ms(1000);
          modeGame = 1;
        }


        if ((PORTA.B4 == 1) && (modeGame == 1))
        {
          Delay_ms(20);
          state = 3;
          break;
        }

        if ((modeGame == 1) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
        {
          Glcd_Fill(0x00);
          Delay_ms(20);
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

      Glcd_Dot(playerOne.positionX, playerOne.positionY, 2);
      Delay_ms(10);

  
      
      Glcd_Dot(playerOne.positionX, playerOne.positionY, 2);
      Delay_ms(10);

      if (PORTA.B0 == 1)
      {
        Glcd_Fill(0x00);
        Delay_ms(5);
        playerOne.positionX = playerOne.positionX + 1;
      }

      if (PORTA.B1 == 1)
      {
        Glcd_Fill(0x00);
        Delay_ms(5);
        playerOne.positionX = playerOne.positionX - 1;
      }

  
      if (PORTA.B2 == 1)
      {
        Glcd_Fill(0x00);
        Delay_ms(5);
        playerOne.positionY = playerOne.positionY + 1;
      }

      if (PORTA.B3 == 1)
      {
        Glcd_Fill(0x00);
        Delay_ms(5);
        playerOne.positionY = playerOne.positionY - 1;
      }
      
      break;
    
    case 3:

        //esta seccion hace referencia al transmisor osea TX
        if(UART_Tx_Idle() == 1){
            if (PORTA.B0 == 1){
                //HEX 0xAA es para cualquier posicion en X
                UART1_Write(0xAA);
                Glcd_Fill(0x00);
                Delay_ms(50);
                playerOne.positionX = playerOne.positionX + 1;
                UART1_Write(playerOne.positionX);
                Delay_ms(50);
            }

            if (PORTA.B1 == 1){
                UART1_Write(0xAA);
                Glcd_Fill(0x00);
                Delay_ms(50);
                playerOne.positionX = playerOne.positionX - 1;
                UART1_Write(playerOne.positionX);
                Delay_ms(50);
            }



            if (PORTA.B2 == 1){
                //HEX 0xAA es para cualquier posicion en Y
                UART1_Write(0xBB);
                Glcd_Fill(0x00);
                Delay_ms(50);
                playerOne.positionY = playerOne.positionY + 1;
                UART1_Write(playerOne.positionY);
                Delay_ms(50);
            }

            if (PORTA.B3 == 1){
                UART1_Write(0xBB);
                Glcd_Fill(0x00);
                Delay_ms(50);
                playerOne.positionY = playerOne.positionY - 1;
                UART1_Write(playerOne.positionY);
                Delay_ms(50);
            }

        }
        

        if(UART_Data_Ready()){
            //PORTA.B0 = 0;         //esto es una buena idea para depurar y entender el flujo
            Glcd_Fill(0x00);
            buffer = UART_Read();
            if(buffer == 0xAA){
                //buffer = 0;
                Delay_ms(50);
                if(UART_Data_Ready()){
                    //PORTA.B1 = 1;
                    buffer = UART_Read();
                    // se transforma el char en int para poder graficar
                    playerTwo.positionX = (int)buffer;
                }
            }

            else if(buffer == 0xBB){
                Delay_ms(50);
                if(UART_Data_Ready()){
                    //buffer = 0;
                    //PORTA.B2 = 1;
                    buffer = UART_Read();
                    playerTwo.positionY = (int)buffer;
                }
            }

            else{
                //PORTA.B1 = 0;
                //PORTA.B2 = 0;
                buffer = 0;
            }
        }

        
        else
        {
            //PORTA.B0 = 1;
        }
        
        

        Glcd_Rectangle(playerOne.positionX, playerOne.positionY, playerOne.positionX + 2, playerOne.positionY + 3, 1);
        Glcd_Rectangle(playerTwo.positionX, playerTwo.positionY, playerTwo.positionX - 2, playerTwo.positionY + 3, 1);
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