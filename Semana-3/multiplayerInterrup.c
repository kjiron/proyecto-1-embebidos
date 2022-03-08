#include "serial.h"
#include "keys.h"
#include "hit.h"
#include "drawglcd.h"
#include "frames.h"

char score_text[5];
char textA[5];
char textB[5];



Objeto movePlayer(Objeto player)
{
  Keys key;
  key = readKeys();

  if (key.right){
    player.positionX = player.positionX + 1;
  }

  if (key.left){
    player.positionX = player.positionX - 1;
  }

  if (key.down){
    player.positionY = player.positionY + 1;
    if (player.positionY >= 49){
       player.positionY = 49;
    }
  }

  if (key.up){
    player.positionY = player.positionY - 1;
    if (player.positionY <= 7){
       player.positionY = 7;
    }
  }

  return player;
}

void drawScore(uint8 a, uint8 b){

  char *fix_text;
  //draw the escore
  ShortToStr(a, score_text);
  fix_text = Ltrim(score_text);
  Glcd_Write_Text("P1", 118, 0, 1);
  Glcd_Write_Text(fix_text, 95, 0, 1);
  ShortToStr(b, score_text);
  fix_text = Ltrim(score_text);
  Glcd_Write_Text("P2", 0, 0, 1);
  Glcd_Write_Text(fix_text, 31, 0, 1);
}

Generic moveBall(Generic ball)
{
  ball.posX = ball.posX + ball.dx;
  ball.posY = ball.posY + ball.dy;
  return ball;
}

// randint(10) -> 0 .. 10
uint8_t randint(uint8_t n)
{
    return (uint8_t)(rand() % (n+1));
}

static void move_paddle_ai(Objeto *pc, Generic *rtBall) {
  uint8 center = pc->positionY + 7;
  if (rtBall->posY < center)
  {
    pc->positionY -= 1;
    if (pc->positionY <= 7)
    {
      pc->positionY = 7;
    }
    
  }
  if (rtBall->posY > center)
  {
    pc->positionY += 1;
    if (pc->positionY >= 49)
    {
      pc->positionY = 49;
    }
  }
  
} 


void main() {
  //Objeto playerOne = {122, 25};
  Objeto playerOne = {5, 25};
  
  Objeto lastPlayerOne = {5, 25};
  Objeto playerTwo = {122, 25};
  Objeto playerPC = {5, 25};
  Generic ball = {64, 32, -1, 1}; //iba a asignar el radio pero el siempre es constante e incluso el color r = 3 y c = 1
  Generic lastBall = {64, 32, -1, 1}; 
  uint8 velocity = 1;
  Keys key;
  //este estado es necesario para ejemplificar el modo UART
  uint8_t state = 0;
  uint8 mode = 0;
  uint8_t randNum = 0;
  uint8 point = 0;
  uint8 scoreB = 0;
  uint8 scoreA = 0;
  uint8 markUART;
  uint8 markTwo;
  uint8 master;

  Serial_Init();
  //aqui una funcion para configurar puertos
  
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
      //menu de juego
      
      while (1)
      {
        markUART = getMark();
        if (markUART == 0xF5)
        {
          master = 0;
          state = 3;
          break;
        }
        
        key = readKeys();
        if (mode == 0)
        {
          Glcd_Fill(0x00);
          Glcd_Image(seleccionDeJuego);
          Glcd_Circle(25, 35, 4, 1);

          if (key.enter)
          {
            state = 2;
            Glcd_Fill(0x00);
            //staticUI();
            break;
          }
          

          if ((key.up) || (key.down))
          {
            Glcd_Fill(0x00);
            Glcd_Image(seleccionDeJuego);
            Glcd_Circle(25, 48, 4, 1);
            mode = 1;
            key.down = 0;
            key.up = 0;
          }
          
        }

        if (mode == 1)
        {
          Glcd_Fill(0x00);
          Glcd_Image(seleccionDeJuego);
          Glcd_Circle(25, 48, 4, 1);

          if (key.enter)
          {
            state = 3;
            Glcd_Fill(0x00);
            Serial_writeByte(0xF5);
            master = 1;
            break;
          }
          

          if ((key.up) || (key.down))
          {
            Glcd_Fill(0x00);
            Glcd_Image(seleccionDeJuego);
            Glcd_Circle(25, 35, 4, 1);
            mode = 0;
            key.down = 0;
            key.up = 0;
          }

        }
        Delay_ms(60);
      }
      break;

    case 2:
      //single player   

       
      //staticUI();
      //drawNet();
      while (1)
      {
        drawPaddleOne(&playerOne, 0);
        drawPaddleTwo(&playerPC, 0);
        if (velocity > 3)
        {
          velocity = 3;
        }
        
        
        ball = moveBall(ball);
        checkWallCollision(&ball, velocity);

        playerOne = movePlayer(playerOne);
        move_paddle_ai(&playerPC, &ball);

        if(check_collision(ball, playerOne)){
          velocity++;
          randNum = randint(2);
          changeDirectionMode1(randNum, &ball, velocity);
        }

        if(check_collision(ball, playerPC)){
          velocity++;
          randNum = randint(2);
          changeDirectionMode2(randNum, &ball, velocity);
        }

        point = checkVerticalWall(&Ball);

        switch (point)
        {
        case 0:
            //para jugador 1
            scoreA = scoreA + 5;
            drawScore(scoreA, scoreB);
            velocity = 1;
            if (scoreA >= 10)
            {
              winFrame();
              state = 1;
              Delay_ms(50);
              
            }
            break;
        
        case 1:
            //para jugador 2
            scoreB = scoreB + 5;
            //scoreB = scoreB + 5;
            velocity = 1;
            drawScore(scoreA, scoreB);
            if (scoreB >= 10)
            {
              loseFrame();
              state = 1;
              Delay_ms(50);
              break;
            }
            
            break;

        case 2:
            //Glcd_Fill(0x00);
            drawScore(scoreA, scoreB);
            Delay_ms(32);
            break;

        default:
          break;
        }

        //Glcd_Fill(0x00);
        drawPaddleOne(&playerOne, 1);
        drawPaddleTwo(&playerPC, 1);
        drawBall(&ball);
        drawNet();
        Delay_ms(16);

        if (state == 1)
        {
          scoreA = 0;
          scoreB = 0;
          Glcd_Fill(0x00);
          break;
        }
      }
      
      
      break;

    case 3:
      //multiplayer
      Glcd_Fill(0x00);
      while (1)
      {
        //logica de la bola
        //Glcd_Fill(0x00);
        
        lastBall = ball;
        ball = moveBall(ball);
        checkWallCollision(&ball, velocity);
        
        drawPaddleOne(&playerOne, 0);

        //logica para jugador 1
        lastPlayerOne = playerOne;
        playerOne = movePlayer(playerOne);

        
        //si el jugador 1 cambia de direccion en Y, envielo por UART
        if (lastPlayerOne.positionY != playerOne.positionY)
        {
          Serial_writeByte(0xCC);
          Serial_Write(&playerOne, sizeof(playerOne));
          Delay_ms(25);
        }
        

        /*
        //MASTER
        if (master == 1)
        {
          //si la bola cambia direccion enviela por UART es informacion nueva
          if ((ball.dx != lastBall.dx) || (ball.dy != lastBall.dy))
          {
            Serial_writeByte(0xDD);
            Serial_Write(&ball, sizeof(Generic));
          }
          
          
          
        }
        //SLAVE
        if (master == 0)
        {
          markUART = getMark();
          if (markUART != 0)
          {
            //obtengo la marca de la bola 0xdd
            if (markUART == 0xdd)
            {
              Serial_Read(&ball, sizeof(Generic)); //parece la opcion mas rapida
            }
          }
        }
        */
        
        
        /*
        markTwo = getMark();
        Delay_ms(30);
        //obtengo la marca del jugador 2 en este caso 0xcc
        if (markTwo == 0xcc)
        {
          Serial_Read(&playerOne, sizeof(Generic)); //parece la opcion mas rapida
          Delay_ms(30);
        }
        */
        
        
        
        drawPaddleOne(&playerOne, 1);
        //drawPaddleTwo(&playerTwo, 1);
        //drawBall(&ball);
        /*
        //logica de la bola
        lastBall = ball;
        ball = moveBall(ball);
        checkWallCollision(&ball, velocity);
        //choque con las paletas 1 y 2
        if(check_collision(ball, playerOne)){
          randNum = randint(1);
          changeDirectionMode1(randNum, &ball, velocity);
        }
        if(check_collision(ball, playerTwo)){
          randNum = randint(1);
          changeDirectionMode2(randNum, &ball, velocity);
        }
        //si la bola cambia direccion enviela por UART es informacion nueva
        if ((ball.dx != lastBall.dx) || (ball.dy != lastBall.dy))
        {
          Serial_writeByte(0xDD);
          Serial_Write(&ball, sizeof(Generic));
        }
        //logica para jugador 1
        lastPlayerOne = playerOne;
        playerOne = movePlayer(playerOne);
        //si el jugador 1 cambia de direccion en Y, envielo por UART
        if (lastPlayerOne.positionY != playerOne.positionY)
        {
          Serial_writeByte(0xCC);
          Serial_Write(&playerOne, sizeof(playerOne));
          Delay_ms(25);
        }        
        //logica para jugador 2
        //en este caso estoy recibiendo un bombardeo de jugador 2 desde python, luego se cambia
        markUART = getMark();
        if (markUART != 0)
        {
          //obtengo la marca del jugador 2 en este caso 0xee
          if (markUART == 0xee)
          {
            Serial_Read(&playerTwo, sizeof(Objeto)); //parece la opcion mas rapida
          }

          if (markUART == 0xdd)
          {
            Serial_Read(&ball, sizeof(Generic)); //parece la opcion mas rapida
          }
          

        }
        //dibujo de score
        point = checkVerticalWall(&ball);
        
        switch (point)
        {
        case 0:
           scoreA = scoreA + 5;
           drawScore(scoreA, scoreB);

           if (scoreA >= 10)
           {
             winFrame();
             state = 1;
             //aqui mandarle una marca al jugador 2 de que perdio será 0xFA
             Serial_writeByte(0xFA);
             Delay_ms(50);
             break;
           }
           
           //si scoreA == 10, win player P1
           break;
        
        case 1:
           scoreB++;
           drawScore(scoreA, scoreB);
           //si scoreB == 10, win player P2
           //ToDo []hacer la imagen de ganar, reiniciar juego, transmitir y recibir por UART
           break;

        case 2:
           Glcd_Fill(0x00);
           drawScore(scoreA, scoreB);
           Delay_ms(30);
           break;

        default:
          break;
        }
    
        drawPaddleOne(&playerOne);
        drawPaddleTwo(&playerTwo);
        drawBall(&ball);

        if (state == 1)
        {
          scoreA = 0;
          scoreB = 0;
          Glcd_Fill(0x00);
          break;
        }
        */
        
      }
      break;

    default:
      break;
    }

  }
}