
_main:

;leds.c,1 :: 		void main() {
;leds.c,6 :: 		LATA = 0;
	CLRF        LATA+0 
;leds.c,7 :: 		LATB = 0;
	CLRF        LATB+0 
;leds.c,9 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;leds.c,10 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;leds.c,11 :: 		while(1)
L_main0:
;leds.c,13 :: 		PORTA.B1 = 1;
	BSF         PORTA+0, 1 
;leds.c,14 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;leds.c,15 :: 		PORTA.B1 = 0;
	BCF         PORTA+0, 1 
;leds.c,16 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
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
;leds.c,17 :: 		PORTB.B1 = 1;
	BSF         PORTB+0, 1 
;leds.c,18 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
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
;leds.c,19 :: 		PORTB.B1 = 0;
	BCF         PORTB+0, 1 
;leds.c,20 :: 		Delay_ms(1000);
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
;leds.c,21 :: 		}
	GOTO        L_main0
;leds.c,22 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
