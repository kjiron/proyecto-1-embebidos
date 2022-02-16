
_main:

;uartLedTX.c,2 :: 		void main(){
;uartLedTX.c,4 :: 		TRISA = 0;
	CLRF        TRISA+0 
;uartLedTX.c,5 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;uartLedTX.c,6 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
;uartLedTX.c,9 :: 		UART1_Write(0x33);
	MOVLW       51
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;uartLedTX.c,10 :: 		Delay_ms(5000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;uartLedTX.c,11 :: 		UART1_Write(0x99);
	MOVLW       153
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;uartLedTX.c,12 :: 		Delay_ms(5000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;uartLedTX.c,13 :: 		UART1_Write(0x84);
	MOVLW       132
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;uartLedTX.c,14 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;uartLedTX.c,22 :: 		}
L_main2:
;uartLedTX.c,24 :: 		while (1)
L_main6:
;uartLedTX.c,26 :: 		if(UART_Data_Ready() == 1){
	CALL        _UART_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;uartLedTX.c,27 :: 		PORTA = UART_Read();
	CALL        _UART_Read+0, 0
	MOVF        R0, 0 
	MOVWF       PORTA+0 
;uartLedTX.c,28 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	DECFSZ      R11, 1, 1
	BRA         L_main9
	NOP
	NOP
;uartLedTX.c,29 :: 		}
L_main8:
;uartLedTX.c,31 :: 		}
	GOTO        L_main6
;uartLedTX.c,34 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
