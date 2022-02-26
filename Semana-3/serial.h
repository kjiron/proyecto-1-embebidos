#ifndef __SERIAL__
#define __SERIAL__

#include <stdint.h>
#include <string.h>
#include <stddef.h>
typedef uint32_t uint32;
typedef uint16_t uint16;
typedef uint8_t uint8;
//typedef uint8 size_t;

/*
static int min(int a, int b)
{
    if (a < b)
    {
        return a;
    }
    return b;
}
*/

static void Serial_Init()
{
    ADCON1 = 0x0F; // turn analog off

    UART1_Init(9600); // initialize hardware UART @baudrate=115200, the same setting for the sensor
    Delay_ms(100);    // let them stablize

    PIE1.RCIE = 1; // enable interrupt source
    INTCON.PEIE = 1;
    INTCON.GIE = 1;
}

void Serial_clear();
size_t Serial_available();
size_t Serial_Write(void *buf, size_t n);
size_t Serial_Read(void *buf, size_t n);
void Serial_writeByte(uint8 b);
uint8 getMark();
#endif