
#include "serial.h"
#include "keys.h"
#include "hit.h"
#include "drawglcd.h"




void main()
{
    Keys key;
    uint8 info;
    uint8 mark;

    Objeto paddle[2] = {0, 0};
    Objeto lastPaddle;
    drawNet();
    staticUI();
    ADCON1=0x0F;

    Glcd_Init();                                   // Initialize GLCD
    Glcd_Fill(0x00);                               // Clear GLCD

    //paddle 1
    paddle[0].x = 5;
    paddle[0].y = 25;
    paddle[0].dx = 1;
    paddle[0].dy = 1;
    paddle[0].w = 2;
    paddle[0].h = 14;
    paddle[0].score = 0;
    //paddle 2
    paddle[1].x = 122;
    paddle[1].y = 25;
    paddle[1].dx = 1;
    paddle[1].dy = 1;
    paddle[1].w = 2;
    paddle[1].h = 14;
    paddle[1].score = 0;


    while (1)
    {
        drawPaddle(&paddle[0], 0);
        //drawPaddle(&paddle[1], 0);

        
        
        
        lastPaddle = paddle[0];
        paddle[0] = movePlayer(paddle[0]);

        if (lastPaddle.y != paddle[0].y)
        {
            Serial_writeByte(0xFF);
            Serial_Write(&paddle[0], sizeof(Objeto));
        }
        
        

        /*
        info = Serial_available();

        if (info > 0)
        {
            mark = getMark();
            if (mark == 0xFF)
            {
                Serial_Read(&paddle[0], sizeof(Objeto));
            }
            
        }
        */

        drawPaddle(&paddle[0], 1);
        //drawPaddle(&paddle[1], 1);

        Delay_ms(30);
    }

}