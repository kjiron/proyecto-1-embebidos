#include "serial.h"

// initialize pointers and buffer.

static uint8 uartRx[64];
static uint8 uartPos_w = 0;
static uint8 uartPos_r = 0;

void Serial_clear()
{
    uartPos_w = 0;
    uartPos_r = 0;
}

size_t Serial_available()
{
    uint8 n = uartPos_w - uartPos_r;
    return n;
}

size_t Serial_Write(void *buf, size_t n)
{
    uint8 c;
    uint8 *p = (uint8 *)buf;
    size_t i;
    for (i = 0; i < n;)
    {
        if (UART1_Tx_Idle() == 1)
        {
            c = p[i];
            UART1_Write(c);
            i++;
        }
    }
    return n;
}

size_t Serial_Read(void *buf, size_t n)
{

    memcpy(buf, uartRx + uartPos_r, n);
    uartPos_r += n;
    return n;
}

void interrupt(void)
{
    // Serial_available();
    uint8 n = uartPos_w - uartPos_r;
    if (uartPos_w > 0 && n == 0)
    {
        Serial_clear();
    }
    // -----
    // interrupt routine when a byte arrives
    uartRx[uartPos_w] = UART1_Read(); // put a byte to a buffer
    uartPos_w++;
    if (uartPos_w == 64)
    {
        Serial_clear();
    } // reset pointer.
}

void Serial_writeByte(uint8 b) {
  Serial_write(&b, 1);
}


uint8 getMark(){
  uint8 mark = 0;
  if (Serial_available() >= 3) 
  { 
    Serial_Read(&mark, 1);
  }
  return mark;
  
}