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


char score_text[5];
typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;


typedef struct
{
  int8_t dx, dy;
} Vec2;

typedef struct
{
  Rect rect;
  Vec2 vel;
} Splite;





static void Draw_Init()
{
    Glcd_Init();                                   // Initialize GLCD
    Glcd_Fill(0x00);                               // Clear GLCD

}
/*
void drawPaddleTwo(Objeto *rect, uint8 color){
  Glcd_Rectangle_Round_Edges_Fill(rect->positionX, rect->positionY, rect->positionX - 2, rect->positionY + 14, 0, color);
}

void drawPaddleOne(Objeto *rect, uint8 color){
  Glcd_Rectangle_Round_Edges_Fill(rect->positionX, rect->positionY, rect->positionX + 2, rect->positionY + 14, 0, color);
}

void drawBall(Generic *rect){
  Glcd_Box(rect->posX, rect->posY, rect->posX + 2, rect->posY + 2, 1);
}
*/

void draw_loseFrame(){
  Glcd_Image(loseScreen);
  Delay_ms(4000);
  Glcd_Fill(0x00);

}


void draw_winFrame(){
  Glcd_Image(winScreen);
  Delay_ms(4000);
  Glcd_Fill(0x00);

}



void draw_InitFrame(){
  Glcd_Image(pantallaDeInicio);
  Delay_ms(4000);
  Glcd_Fill(0x00);

}

void menuFrame(){
  Glcd_Image(seleccionDeJuego);
}

void draw_rect_pc(Splite s, uint8_t color)
{
  Glcd_Rectangle_Round_Edges_Fill(s.rect.x, s.rect.y, s.rect.x - s.rect.w, s.rect.y + s.rect.h, 0, color);
}


void draw_rect_player(Splite s, uint8_t color)
{
  Glcd_Rectangle_Round_Edges_Fill(s.rect.x, s.rect.y, s.rect.x + s.rect.w, s.rect.y + s.rect.h, 0, color);
}


void draw_box(Splite s, uint8_t color)
{
  Glcd_Box(s.rect.x, s.rect.y, s.rect.x + s.rect.w, s.rect.y + s.rect.h, color);
}

void draw_net()
{
  uint8_t i;

  for ( i = 0; i < 14; i++)
  {
    GLcd_V_Line(8 + i*4, 8 + i*4 + 1, 0 + 126/2, 1);
  }
 
}

void draw_text(char *text, uint8 x)
{
  Glcd_Write_Text(text, x, 0, 1);
}
/*
Glcd_Write_Text("P1", 115-wall.x, 0, 1);        
Glcd_Write_Text("PC", wall.x, 0, 1);
*/

void draw_score(uint8_t a, uint8_t b){ //function to draw the score
  char *fix_text;
  //draw the score
  ShortToStr(a, score_text);
  fix_text = Ltrim(score_text);
  Glcd_Write_Text(fix_text, 95, 0, 1);
  ShortToStr(b, score_text);
  fix_text = Ltrim(score_text);
  Glcd_Write_Text(fix_text, 31, 0, 1);
}


void draw_walls()
{
  GLcd_V_Line(7, 63, 0, 1);
  GLcd_V_Line(7, 63, 127, 1);
  GLcd_H_Line(0, 127, 8, 1);
  GLcd_H_Line(0, 127, 63, 1);  
}


void draw_circle(Rect circle, uint8_t color)
{ 
  //if (circle.x < 0 || circle.x > 128 || )
  Glcd_Circle(circle.x, circle.y, circle.w, color);
}

void draw_clear()
{
  Glcd_Fill(0x00);
}

int draw_MenuGame(uint8_t modeGame)
{
  Keys key;
  Rect select = {25, 34, 3, 0};
  menuFrame();
  draw_circle(select, 1);

  while (1)
  {
  

    key = readKeys();

    if ((key.enter) && (modeGame == 0))
    {
      draw_clear();
      return 2;
    }
    if ((key.up || key.down)  && (modeGame == 0))
    {
      draw_clear();
      menuFrame();
      select.y = select.y + 14;  //offset
      draw_circle(select, 1);
      modeGame = 1;
      Delay_ms(666);
      continue;
    }
    if ((key.enter) && (modeGame == 1))
    {
      draw_clear();
      return 3;
    }
    if ((key.up || key.down ) && (modeGame == 1)) 
    {
      draw_clear();
      menuFrame();
      select.y = select.y - 14;  //offset
      draw_circle(select, 1);     
      modeGame = 0;
      Delay_ms(666);
    }
  }
}



#endif