#ifndef __HIT__
#define __HIT__

typedef struct
{
  uint8_t posX, posY;
  int8_t dx, dy;
} Generic;

typedef struct
{
  uint8_t positionX, positionY;
} Objeto;


void checkWallCollision(Generic *ball_tmp)
{
  if (ball_tmp->posY >= 61){
      ball_tmp->dy = -1;
  }
  if (ball_tmp->posY <= 7){
      ball_tmp->dy = 1;
  }
}

void changeDirectionMode1(uint8 randNum, Generic *ball){
   if (randNum == 0){
      ball->dx = -1;
      ball->dy = 1;
   }
   if (randNum == 1){
      ball->dx = -1;
      ball->dy = -1;
   }
}

void changeDirectionMode2(uint8 randNum, Generic *ball){
   if (randNum == 0){
      ball->dx = 1;
      ball->dy = 1;
   }
   if (randNum == 1){
      ball->dx = 1;
      ball->dy = -1;
   }
}


uint8 checkVerticalWall(Generic *ball_tmp){
  if (ball_tmp->posX <= 0){
      ball_tmp->posX = 64;
      ball_tmp->posY = 32;
      ball_tmp->dx = 1;
      ball_tmp->dy = -1;
      return 0;
  }
  if (ball_tmp->posX >= 125){
      ball_tmp->posX = 64;
      ball_tmp->posY = 32;
      ball_tmp->dx = -1;
      ball_tmp->dy = 1;
      return 1;
  }

  return 2;
}


bool check_collision(Generic _ball, Objeto player)
{
    return _ball.posX < (player.positionX + 2) &&
        (_ball.posX + 3) > player.positionX &&
        _ball.posY < (player.positionY + 14) &&
        (3 + _ball.posY) > player.positionY;
}


#endif



