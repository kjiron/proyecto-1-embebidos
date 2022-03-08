#ifndef __KEYS__
#define __KEYS__

#include <stdbool.h>

typedef struct
{
  bool up, down, right, left, enter;
} Keys;


static inline Keys readKeys()
{

  Keys tmp;
  tmp.right = PORTA.B0 == 1;
  tmp.left  = PORTA.B1 == 1;
  tmp.up    = PORTA.B2 == 1;
  tmp.down  = PORTA.B3 == 1;
  tmp.enter = PORTA.B4 == 1;
  return tmp;
}


#endif



