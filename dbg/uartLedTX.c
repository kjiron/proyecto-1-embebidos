
void main(){
     char buffer;
     TRISA = 0;
     UART1_Init(9600);
     Delay_ms(200);
     while (1)
     {
          UART1_Write(0x33);
          Delay_ms(5000);
          UART1_Write(0x99);
          Delay_ms(5000);
          UART1_Write(0x84);
          Delay_ms(1000);
          break;
          
          /*
          if(UART_Data_Ready() == 1){
               break;
          }
          */
     }

     while (1)
     {
          if(UART_Data_Ready() == 1){
               PORTA = UART_Read();
               Delay_ms(500); 
          }
                  
     }
     
     
}