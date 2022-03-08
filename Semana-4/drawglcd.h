#ifndef __DRAWGLCD__
#define __DRAWGLCD__


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

/*
void drawPaddleTwo(Objeto *rect, uint8 color){
  Glcd_Rectangle_Round_Edges_Fill(rect->x, rect->y, rect->x - rect->w, rect->y + rect->h, 0, color);
}

void drawPaddleOne(Objeto *rect, uint8 color){
  //Glcd_Fill(0x00);
  Glcd_Rectangle_Round_Edges_Fill(rect->x, rect->y, rect->x + rect->w, rect->y + rect->h, 0, color);
//Glcd_Rectangle_Round_Edges_Fill(rect->positionX, rect->positionY, rect->positionX + 2, rect->positionY + 14, 0, color);
}
*/

void drawPaddle(Objeto *rect, uint8 color){
  Glcd_Rectangle_Round_Edges_Fill(rect->x, rect->y, rect->x - rect->w, rect->y + rect->h, 0, color);
}


void drawBall(Generic *rect){
  //Glcd_Fill(0x00);
  Glcd_Box(rect->posX, rect->posY, rect->posX + 2, rect->posY + 2, 1);
}

void drawNet()
{
  uint8_t i;

  for ( i = 0; i < 14; i++)
  {
    GLcd_V_Line(8 + i*4, 8 + i*4 + 1, 0 + 126/2, 1);
  }
 
}


void drawNetAndWall(){
  Glcd_V_Line(10, 17, 62, 1);
  Glcd_V_Line(24, 31, 62, 1);
  Glcd_V_Line(38, 45, 62, 1);
  Glcd_V_Line(51, 59, 62, 1);
  Delay_ms(30);
  //Glcd_H_Line(0, 127, 7, 1);
}

void staticUI()
{//draw the static ui from each level


  GLcd_V_Line(7, 63, 0, 1);
  GLcd_V_Line(7, 63, 127, 1);
  GLcd_H_Line(0, 127, 7, 1);
  GLcd_H_Line(0, 127, 63, 1);

  
}

#endif