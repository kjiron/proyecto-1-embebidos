#include "serial.h"
#include "frames.h"
#include "keys.h"
#include "drawglcd.h"
#include "hit.h"

#define SCREEN_WIDTH    128
#define SCREEN_HEIGHT   64
#define ERASE           0
#define DRAW            1


uint8_t whoAmI;
uint8_t state = 0;
uint8_t modeGame = 0;
uint8_t paddleWidth = 2;
uint8_t paddleHeight = 12;
uint8_t velocity = 1;
uint8_t master, slave, data_available, markUART;
uint8_t scoreA, scoreB;


Splite playerOne, playerTwo, playerPC, ball;
Splite lastPosPlayer, lastBall;

Splite newPlayer;
Splite newBall;
Splite score;



bool isPlayerNeedSend(Splite player) {
    if (player.rect.y != lastPosPlayer.rect.y) {
        lastPosPlayer = player;
        return true;
    }
    return false;
}


bool isBallNeedSend(Splite player) {
    if (player.vel.dx != lastBall.vel.dx) {
        lastBall = player;
        return true;
    }
    if (player.vel.dy != lastBall.vel.dy) {
        lastBall = player;
        return true;
    }
    return false;
}








void init_game(){
    playerOne.rect.x = SCREEN_WIDTH - 10;
    playerOne.rect.y = (SCREEN_HEIGHT/2) - 5;
    playerOne.rect.w = paddleWidth;
    playerOne.rect.h = paddleHeight;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 0;

    playerPC.rect.x = 7;
    playerPC.rect.y = (SCREEN_HEIGHT/2) - 5;
    playerPC.rect.w = paddleWidth;
    playerPC.rect.h = paddleHeight;
    playerPC.vel.dx = 0;
    playerPC.vel.dy = 0;

    playerTwo = playerPC;

    ball.rect.x = SCREEN_WIDTH/2;
    ball.rect.y = (SCREEN_HEIGHT/2) - paddleHeight;
    ball.rect.w = 2;
    ball.rect.h = 2;

    /*
    ball.vel.dx = 1;
    ball.vel.dy = 1;
    */

    velocity = 1;


    newBall = ball;

    /*
    if (whoAmI == 2) {
        newPlayer = playerOne;
    } else {
        newPlayer = playerTwo;

    } */

}

// nuestras mark

uint16 SendScore = 0x9999;
uint16 SendBall = 0x9668;
uint16 SendPlayer = 0x9669;

uint16 IamPlayer1 = 0x9666;
uint16 IamPlayer2 = 0x9667;


/* 
intenta obtener player durante 1s

return 
    0, 1, 2

*/
int recvPlayer() {
    int i = 0, n;
    uint16 mark;
    while (1)
    {
        n = Serial_available();
        if (n >= 2) {
            Serial_Read(&mark, 2);
            if (mark == IamPlayer1) {
                return 1;
            }
            if (mark == IamPlayer2) {
                return 2;
            }

            // esto nunca deberia de pasar
        }

        if (i == 5) {
            return 0;
        }
        i++;
        Delay_ms(200);
    }
    
}


/*
sincroniza toda la ostia

return 
    1, 2
*/

int syncPlayer() {
    int player;
    Serial_clear();

    while (1)
    {
        player = recvPlayer();
        if (player == 1) {
            Serial_Write(&IamPlayer2, 2);
            return 2;
        }
        if (player == 2) {
            return 1;
        }
        Serial_Write(&IamPlayer1, 2);
    }
}






Splite moveAnother(Splite s) {
    return newPlayer;
}


Splite moveBall398(Splite s) {
 if (s.vel.dx != newBall.vel.dx || s.vel.dy != newBall.vel.dy) {
        return newBall;
    }
    return s;
}




void forceSendPlayer() {

    if (whoAmI == 1) {

        if (isPlayerNeedSend(playerOne) || 1) {
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerOne, sizeof(Splite));                
        }

    }
    if (whoAmI == 2) {
        if (isPlayerNeedSend(playerTwo) || 1) {
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerTwo, sizeof(Splite));                
        }
    }

}




void updateData() {
    int n;
    uint16 mark;

    while (1)
    {
    
        n = Serial_available();
        if (n >= (2 + sizeof(Splite))) {
            Serial_Read(&mark, 2);

            if (mark == SendBall) {
                Serial_Read(&newBall, sizeof(Splite));
                ball = moveBall398(ball);                   
                continue;
            }
            
            if (mark == SendPlayer) {
                Serial_Read(&newPlayer, sizeof(Splite));
                continue;
            }

            if (mark == SendScore) {
                Serial_Read(&score, sizeof(Splite));
                scoreA = score.rect.x;
                scoreB = score.rect.y;
                draw_score(scoreA, scoreB);
                init_game();
                Delay_ms(900);
                forceSendPlayer();
                continue;
            }


            Serial_clear();
        }

        return;
    }

}






void main()
{
    //ADCON1 = 0x0F;
    //TRISC = 0xFF;
    TRISA = 0xFF;

    
    
    ball.vel.dx = 1;
    ball.vel.dy = 1;

    scoreA = 0;
    scoreB = 0;
    
    

    Serial_Init();
    

    //ADC_Init();
    Draw_Init();

    init_game();
    while (1)
    {
        switch (state)
        {
        case 0:
            // Portada
            draw_InitFrame();
            state = 1;
            break;

        case 1:
            // Menu de Juego
            
            state = draw_MenuGame(modeGame);
            
            break;

        case 2:
            // One Player
            draw_walls();
            draw_net();
            draw_text("P1", SCREEN_WIDTH - 10);
            draw_text("PC", 0);
            draw_score(scoreA, scoreB);
            while (1)
            {
         
                playerOne = move_player(playerOne);
                ball = move_ball(ball);   
                playerPC = move_ai(playerPC, ball);

                if (check_collision(ball, playerOne)) {
                    velocity++;
                    if (velocity >= 3)
                    {
                        velocity = 3;
                    }
                    ball.vel.dx = -velocity;
                }

                if (check_collision(ball, playerPC)) {
                    velocity++;
                    if (velocity >= 3)
                    {
                        velocity = 3;
                    }
                    ball.vel.dx = velocity;
                }


                if (goal(&ball, &scoreA, &scoreB))
                {
                    draw_score(scoreA, scoreB);
                   
                    ball.rect.x = SCREEN_WIDTH/2;
                    ball.rect.y = (SCREEN_HEIGHT/2) - paddleHeight;
                    ball.rect.w = 2;
                    ball.rect.h = 2;
                    
                    init_game();
                }

                if (scoreA == 10)
                {
                    state = 1;
                    scoreA = 0;
                    scoreB = 0;
                    draw_winFrame();
                    break;
                }

                if (scoreB == 10)
                {
                    state = 1;
                    scoreA = 0;
                    scoreB = 0;
                    draw_loseFrame();
                    break;
                }


                draw_box(ball, DRAW);
                draw_box(playerOne, DRAW);
                draw_box(playerPC, DRAW);
                draw_net();
                //draw_walls();
                Delay_ms(30);
                draw_box(playerOne, ERASE);
                draw_box(playerPC, ERASE);
                draw_box(ball, ERASE);


            }  
            break;

        case 3:
            init_game();

            draw_walls();
            draw_net();
            draw_text("P1", SCREEN_WIDTH - 10);
            draw_text("P2", 0);
            draw_score(scoreA, scoreB);
            
            whoAmI = syncPlayer();
            Serial_clear();
            Delay_ms(2000);
            
            forceSendPlayer();
            
            while (1)
            {

                updateData();

                // enviarVectorBall,newpaleta
                ball = move_ball(ball);                   
                



                    if (check_collision(ball, playerOne)) {
                        velocity++;
                        if (velocity >= 3)
                        {
                            velocity = 3;
                        }
                        ball.vel.dx = -velocity;
                    }

                    if (check_collision(ball, playerTwo)) {
                        velocity++;
                        if (velocity >= 3)
                        {

                            velocity = 3;
                        }
                        ball.vel.dx = velocity;
                    }



                // mueve mi jugador
                if (whoAmI == 1) {
                    playerTwo = moveAnother(playerTwo);
                    playerOne = move_player(playerOne);

                    if (isPlayerNeedSend(playerOne)) {
                        Serial_Write(&SendPlayer, 2);
                        Serial_Write(&playerOne, sizeof(Splite));                
                    }

                    if (goal(&ball, &scoreA, &scoreB))
                    {
                        draw_score(scoreA, scoreB);
                        ball.rect.x = SCREEN_WIDTH/2;
                        ball.rect.y = (SCREEN_HEIGHT/2) - paddleHeight;
                        ball.rect.w = 2;
                        ball.rect.h = 2;

                        init_game();
                        
                        score.rect.x = scoreA;
                        score.rect.y = scoreB;
                        Serial_Write(&SendScore, 2);
                        Serial_Write(&score, sizeof(Splite));
                        Delay_ms(1000);
                        forceSendPlayer();
            
                        continue;
                    }


                    if (isBallNeedSend(ball)) {
                        Serial_Write(&SendBall, 2);
                        Serial_Write(&ball, sizeof(ball));
                    }

                }
                if (whoAmI == 2) {
                    playerOne = moveAnother(playerOne);
                    playerTwo = move_player(playerTwo);

                    if (isPlayerNeedSend(playerTwo)) {
                        Serial_Write(&SendPlayer, 2);
                        Serial_Write(&playerTwo, sizeof(Splite));                
                    }


                    
                    if (goal(&ball, &scoreA, &scoreB))
                    {
                        Delay_ms(100);
                        continue;
                    }
                    
                }


                if (scoreA == 10)
                {
                    state = 1;
                    scoreA = 0;
                    scoreB = 0;

                    if (whoAmI == 1) {
                        draw_winFrame();
                    }
                    else {    
                        draw_loseFrame();
                    }

                    break;
                }


                if (scoreB == 10)
                {
                    state = 1;
                    scoreA = 0;
                    scoreB = 0;

                    if (whoAmI == 2) {
                        draw_winFrame();
                    }else {    
                        draw_loseFrame();
                    }

                    break;
                }


 
                draw_box(ball, DRAW);
                draw_box(playerOne, DRAW);
                draw_box(playerTwo, DRAW);
                draw_net();
                Delay_ms(30);
                draw_box(playerOne, ERASE);
                draw_box(playerTwo, ERASE);
                draw_box(ball, ERASE);

            }
            

            break;

        default:
            break;
        }
    }
}