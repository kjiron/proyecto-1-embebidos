#ifndef __HIT__
#define __HIT__

#include "drawglcd.h"
#include "keys.h"

Splite move_player(Splite player)
{
   Keys key;
   key = readKeys();

   if (key.down){
      player.rect.y = player.rect.y + 1;
      if (player.rect.y >= 50){
         player.rect.y = 50;
      }
   }

   else if (key.up){
      player.rect.y = player.rect.y - 1;
      if (player.rect.y <= 9){
         player.rect.y = 9;
      }
   }

   else{
      return player;
   }

  return player;

}


static inline bool check_collision00(Rect rect1, Rect rect2)
{
    return rect1.x < rect2.x + rect2.w &&
       rect1.x + rect1.w > rect2.x &&
       rect1.y < rect2.y + rect2.h &&
       rect1.h + rect1.y > rect2.y;
}


bool check_collision(Splite ball, Splite player)
{
   return check_collision00(ball.rect, player.rect);
}



void checkWallCollision(Splite *ball)
{
   if (ball->rect.y >= 60)
   {
      ball->vel.dy = -ball->vel.dy; 
   }

   if (ball->rect.y <= 9)
   {
      ball->vel.dy = -ball->vel.dy; 
   }
}

Splite move_ball(Splite ball)
{
   
   ball.rect.x += ball.vel.dx;
   ball.rect.y += ball.vel.dy; 
   
   checkWallCollision(&ball);

   return ball;
}

Splite move_ai(Splite pc, Splite ball)
{
   uint8_t center = pc.rect.y + pc.rect.w/2;
   if (ball.rect.x < 62)
   {
      if (ball.rect.y > center) 
      { 
         pc.rect.y++;
         if (pc.rect.y >= 50)
         {
            pc.rect.y = 50;
         }
      } 
      else 
      { 
         pc.rect.y--;
         if (pc.rect.y <= 9)
         {
            pc.rect.y = 9;
         }
         
      }
      return pc;      
   }
   return pc;
}

bool goal(Splite *ball, uint8 *a, uint8 *b)
{
   if (ball->rect.x >= 123)
   {
      ball->vel.dx = -1;
      ball->vel.dy = 1;
      (*b) = (*b) + 2; 
      //(*b)++;
      return 1;
   }
   
   if (ball->rect.x <= 5)
   {
      ball->vel.dx = 1;
      ball->vel.dy = -1;
      (*a) = (*a) + 2;  
      //(*a)++;
      return 1;
   }      
   
   return 0;
}


/*

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

*/
#endif



