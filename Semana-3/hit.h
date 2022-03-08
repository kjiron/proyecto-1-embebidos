#ifndef __HIT__
#define __HIT__

typedef struct
{
  int8_t posX, posY;
  int8_t dx, dy;
} Generic;

typedef struct
{
  uint8_t positionX, positionY;
} Objeto;


void checkWallCollision(Generic *ball_tmp, uint8 velocity)
{
  if (ball_tmp->posY >= 61){
      ball_tmp->dy = -velocity;
  }
  if (ball_tmp->posY <= 7){
      ball_tmp->dy = velocity;
  }
  if (ball_tmp->posX >= 125){
      ball_tmp->dx = -velocity;
  }
  if (ball_tmp->posX <= 0){
      ball_tmp->dx = velocity;
  }
}

void changeDirectionMode1(uint8 randNum, Generic *ball, uint8 velocity){
   if (randNum == 0){
      ball->dx = -velocity;
      ball->dy = velocity;
   }
   if (randNum == 1){
      ball->dx = -velocity;
      ball->dy = -velocity;
   }
   if (randNum == 2)
   {
      ball->dx = -velocity;
      ball->dy = 0;
   }
   
}

void changeDirectionMode2(uint8 randNum, Generic *ball, uint8 velocity){
   if (randNum == 0){
      ball->dx = velocity;
      ball->dy = velocity;
   }
   if (randNum == 1){
      ball->dx = velocity;
      ball->dy = -velocity;
   }
   if (randNum == 2){
      ball->dx = velocity;
      ball->dy = velocity;
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


#endif



