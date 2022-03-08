#include <stdint.h>

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


void main()
{
    int x, y, last_y;
    char text[5];
    char *fix_text;
    uint32_t  s;
    //ADCON1 = 0x0F;
    TRISC = 0xFF;
    TRISA = 0xFF;
    TRISA3_bit = 1;

    x = 60;
    y = 30;
    Glcd_Init();                                   // Initialize GLCD
    Glcd_Fill(0x00);                               // Clear GLCD
    ADC_Init();

    Glcd_Dot(x, y, 1);
    Delay_ms(4000);
    Glcd_Fill(0x00);
    while (1)
    {
        last_y = y;
        Glcd_Dot(x, y, 1);

        //x = (ADC_Read(0)); // Lee el eje Y del joystick
        s = (ADC_Read(1)); // Lee el eje Y del joystick
        Delay_ms(30);
        Glcd_Fill(0x00);
        
        if (s >= 800)
        {
            y = y - 1;
        }

        else if (s <= 200)
        {
            y = y + 1;
        }

        else{
            y = last_y;
        }
        


        //Glcd_Fill(0x00);
        
    }
}