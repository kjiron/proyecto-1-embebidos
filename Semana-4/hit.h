#ifndef __HIT__
#define __HIT__

typedef struct
{
  int8_t posX, posY;
  int8_t dx, dy;
} Generic;

typedef struct
{
  //uint8_t positionX, positionY;
   int8_t x, y, w, h, dx, dy, score; 
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

/*

bool check_collision(Generic _ball, Objeto player)
{
   return _ball.posX < (player.x + player.w) &&
      (_ball.posX + 3) > player.x &&
      _ball.posY < (player.y + player.h) &&
      (3 + _ball.posY) > player.y;
}

*/

Objeto movePlayer(Objeto player)
{
  Keys key;
  key = readKeys();

  if (key.down){
    player.y = player.y + player.dy;
    if (player.y >= 49){
       player.y = 49;
    }
  }

  if (key.up){
    player.y = player.y - player.dy;
    if (player.y <= 7){
       player.y = 7;
    }
  }

  return player;
}

#endif