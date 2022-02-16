void leerPuertos(){
    if(PORTB.B0 != 0)
    {
        LATD.B0 = 1;
    }
        
    if(PORTB.B1 != 0)
    {
        LATD.B0 = 0;
    }

}


void main(){
    /*
    enciende un led con un boton y lo apaga con otro
    la resistencia de pull up/down del puerto B debe de estar en down la de RB0
    esto se puede hacer sin el DIP switch pero se necesita configurar el puerto
    INTCON2.RBPU -> 0 habilita resistencia de pull up y en 1 las deshabilita
    */
    //config de puertos
    ADCON1 = 0x0F;
    LATD = 0x00;
    LATB = 0x00;
    TRISB.B0 = 1;
    TRISB.B1 = 1;


    TRISD = 0x00;

    while(1)
    {
        leerPuertos();
    }
}