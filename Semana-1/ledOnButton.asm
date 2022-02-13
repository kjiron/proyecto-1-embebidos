
_main:

;ledOnButton.c,1 :: 		void main(){
;ledOnButton.c,9 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;ledOnButton.c,10 :: 		LATD = 0x00;
	CLRF        LATD+0 
;ledOnButton.c,11 :: 		LATB = 0x00;
	CLRF        LATB+0 
;ledOnButton.c,12 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;ledOnButton.c,13 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;ledOnButton.c,16 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;ledOnButton.c,18 :: 		while(1)
L_main0:
;ledOnButton.c,20 :: 		if(PORTB.B0 != 0)
	BTFSS       PORTB+0, 0 
	GOTO        L_main2
;ledOnButton.c,22 :: 		LATD.B0 = 1;
	BSF         LATD+0, 0 
;ledOnButton.c,23 :: 		}
L_main2:
;ledOnButton.c,25 :: 		if(PORTB.B1 != 0)
	BTFSS       PORTB+0, 1 
	GOTO        L_main3
;ledOnButton.c,27 :: 		LATD.B0 = 0;
	BCF         LATD+0, 0 
;ledOnButton.c,28 :: 		}
L_main3:
;ledOnButton.c,29 :: 		}
	GOTO        L_main0
;ledOnButton.c,30 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
