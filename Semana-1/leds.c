void main() {
    //DATA DIRECTION -> output/input -> TRIS -> 0/1
    //READ LEVELS OF THE PIN -> PORT
    //OUTPUT LATCH -> LAT

    LATA = 0;
    LATB = 0;

    TRISA = 0x00;
    TRISB = 0x00;
    while(1)
    {
        PORTA.B1 = 1;
        Delay_ms(1000);
        PORTA.B1 = 0;
        Delay_ms(1000);
        PORTB.B1 = 1;
        Delay_ms(1000);
        PORTB.B1 = 0;
        Delay_ms(1000);
    }
}