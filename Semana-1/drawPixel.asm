
_main:

;drawPixel.c,30 :: 		void main() {
;drawPixel.c,35 :: 		posX = 62;
	MOVLW       62
	MOVWF       main_posX_L0+0 
	MOVLW       0
	MOVWF       main_posX_L0+1 
;drawPixel.c,36 :: 		posY = 32;
	MOVLW       32
	MOVWF       main_posY_L0+0 
	MOVLW       0
	MOVWF       main_posY_L0+1 
;drawPixel.c,40 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;drawPixel.c,42 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;drawPixel.c,43 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,47 :: 		while (1)
L_main0:
;drawPixel.c,49 :: 		Glcd_Dot(posX, posY, 2);
	MOVF        main_posX_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_posY_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;drawPixel.c,50 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
;drawPixel.c,52 :: 		if (PORTA.B0 == 1)
	BTFSS       PORTA+0, 0 
	GOTO        L_main3
;drawPixel.c,54 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,55 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
	NOP
;drawPixel.c,56 :: 		posX = posX + 1;
	INFSNZ      main_posX_L0+0, 1 
	INCF        main_posX_L0+1, 1 
;drawPixel.c,57 :: 		}
L_main3:
;drawPixel.c,59 :: 		if (PORTA.B1 == 1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main5
;drawPixel.c,61 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,62 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
	NOP
;drawPixel.c,63 :: 		posX = posX - 1;
	MOVLW       1
	SUBWF       main_posX_L0+0, 1 
	MOVLW       0
	SUBWFB      main_posX_L0+1, 1 
;drawPixel.c,64 :: 		}
L_main5:
;drawPixel.c,67 :: 		if (PORTA.B2 == 1)
	BTFSS       PORTA+0, 2 
	GOTO        L_main7
;drawPixel.c,69 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,70 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	NOP
	NOP
;drawPixel.c,71 :: 		posY = posY + 1;
	INFSNZ      main_posY_L0+0, 1 
	INCF        main_posY_L0+1, 1 
;drawPixel.c,72 :: 		}
L_main7:
;drawPixel.c,74 :: 		if (PORTA.B3 == 1)
	BTFSS       PORTA+0, 3 
	GOTO        L_main9
;drawPixel.c,76 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,77 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	NOP
	NOP
;drawPixel.c,78 :: 		posY = posY - 1;
	MOVLW       1
	SUBWF       main_posY_L0+0, 1 
	MOVLW       0
	SUBWFB      main_posY_L0+1, 1 
;drawPixel.c,79 :: 		}
L_main9:
;drawPixel.c,82 :: 		}
	GOTO        L_main0
;drawPixel.c,85 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
