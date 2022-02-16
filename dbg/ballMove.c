//DATA DIRECTION -> output/input -> TRIS -> 0/1
//READ LEVELS OF THE PIN -> PORT
//OUTPUT LATCH -> LAT
//Important to configure the clock in the right way: https://forum.mikroe.com/viewtopic.php?t=10646


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


struct Objeto
{
  int posX, posY;
  int velocX, velocY;

} Ball;




void main() {
  //position of the pixel
  int posX;
  int posY;
  int state;
  posX = 62;
  posY = 32;
  state = 0;
  Ball.posX = 50;
  Ball.posY = 40;
  Ball.velocX = 1;
  Ball.velocY = 1;
  //ADCON1 -> allow us to set the pin as digital I/O in the ports A and B
  ADCON1=0x0F;

  Glcd_Init();                                   // Initialize GLCD
  Glcd_Fill(0x00);                               // Clear GLCD



  while (1)
  {

    Glcd_Circle(Ball.posX, Ball.posY, 3, 1);
    
  


  }


}