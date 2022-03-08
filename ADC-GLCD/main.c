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

ANSEL  = 0x02;              // Configure AN2 pin as analog
ANSELH = 0;                 // Configure other AN pins as digital I/O
C1ON_bit = 0;               // Disable comparators
C2ON_bit = 0;

TRISA  = 0xFF;              // PORTA is input


void main()
{
    int x, y;
    x = 60;
    y = 30;
    Glcd_Init();                                   // Initialize GLCD
    Glcd_Fill(0x00);                               // Clear GLCD
    ADC_Init();
    
    while (1)
    {
        Glcd_Dot(x, y, 1);

        if (ADC_Read(0) != 0)
        {
            x = x + 1;
        }

        if (ADC_Read(1) != 0)
        {
            y = y + 1;
        }
        Glcd_Fill(0x00);
    }
}



