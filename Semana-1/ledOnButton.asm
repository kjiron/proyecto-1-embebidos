
_leerPuertos:

;ledOnButton.c,1 :: 		void leerPuertos(){
;ledOnButton.c,2 :: 		if(PORTB.B0 != 0)
	BTFSS       PORTB+0, 0 
	GOTO        L_leerPuertos0
;ledOnButton.c,4 :: 		LATD.B0 = 1;
	BSF         LATD+0, 0 
;ledOnButton.c,5 :: 		}
L_leerPuertos0:
;ledOnButton.c,7 :: 		if(PORTB.B1 != 0)
	BTFSS       PORTB+0, 1 
	GOTO        L_leerPuertos1
;ledOnButton.c,9 :: 		LATD.B0 = 0;
	BCF         LATD+0, 0 
;ledOnButton.c,10 :: 		}
L_leerPuertos1:
;ledOnButton.c,12 :: 		}
L_end_leerPuertos:
	RETURN      0
; end of _leerPuertos

_main:

;ledOnButton.c,15 :: 		void main(){
;ledOnButton.c,23 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;ledOnButton.c,24 :: 		LATD = 0x00;
	CLRF        LATD+0 
;ledOnButton.c,25 :: 		LATB = 0x00;
	CLRF        LATB+0 
;ledOnButton.c,26 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;ledOnButton.c,27 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;ledOnButton.c,30 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;ledOnButton.c,32 :: 		while(1)
L_main2:
;ledOnButton.c,34 :: 		leerPuertos();
	CALL        _leerPuertos+0, 0
;ledOnButton.c,35 :: 		}
	GOTO        L_main2
;ledOnButton.c,36 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
