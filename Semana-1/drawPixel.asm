
_main:

;drawPixel.c,38 :: 		void main() {
;drawPixel.c,43 :: 		posX = 62;
	MOVLW       62
	MOVWF       main_posX_L0+0 
	MOVLW       0
	MOVWF       main_posX_L0+1 
;drawPixel.c,44 :: 		posY = 32;
	MOVLW       32
	MOVWF       main_posY_L0+0 
	MOVLW       0
	MOVWF       main_posY_L0+1 
;drawPixel.c,46 :: 		Ball.posX = 50;
	MOVLW       50
	MOVWF       _Ball+0 
	MOVLW       0
	MOVWF       _Ball+1 
;drawPixel.c,47 :: 		Ball.posY = 40;
	MOVLW       40
	MOVWF       _Ball+2 
	MOVLW       0
	MOVWF       _Ball+3 
;drawPixel.c,48 :: 		Ball.velocX = 1;
	MOVLW       1
	MOVWF       _Ball+4 
	MOVLW       0
	MOVWF       _Ball+5 
;drawPixel.c,49 :: 		Ball.velocY = 1;
	MOVLW       1
	MOVWF       _Ball+6 
	MOVLW       0
	MOVWF       _Ball+7 
;drawPixel.c,51 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;drawPixel.c,53 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;drawPixel.c,54 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,58 :: 		while (1)
L_main0:
;drawPixel.c,61 :: 		Glcd_Circle(Ball.posX, Ball.posY, 5, 1);
	MOVF        _Ball+0, 0 
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVF        _Ball+1, 0 
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVF        _Ball+2, 0 
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVF        _Ball+3, 0 
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;drawPixel.c,62 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;drawPixel.c,63 :: 		Glcd_Dot(posX, posY, 2);
	MOVF        main_posX_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_posY_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;drawPixel.c,64 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	NOP
;drawPixel.c,66 :: 		if (PORTA.B0 == 1)
	BTFSS       PORTA+0, 0 
	GOTO        L_main4
;drawPixel.c,68 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,69 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	NOP
	NOP
;drawPixel.c,70 :: 		posX = posX + 1;
	INFSNZ      main_posX_L0+0, 1 
	INCF        main_posX_L0+1, 1 
;drawPixel.c,71 :: 		}
L_main4:
;drawPixel.c,73 :: 		if (PORTA.B1 == 1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main6
;drawPixel.c,75 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,76 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	NOP
	NOP
;drawPixel.c,77 :: 		posX = posX - 1;
	MOVLW       1
	SUBWF       main_posX_L0+0, 1 
	MOVLW       0
	SUBWFB      main_posX_L0+1, 1 
;drawPixel.c,78 :: 		}
L_main6:
;drawPixel.c,81 :: 		if (PORTA.B2 == 1)
	BTFSS       PORTA+0, 2 
	GOTO        L_main8
;drawPixel.c,83 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,84 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
	NOP
;drawPixel.c,85 :: 		posY = posY + 1;
	INFSNZ      main_posY_L0+0, 1 
	INCF        main_posY_L0+1, 1 
;drawPixel.c,86 :: 		}
L_main8:
;drawPixel.c,88 :: 		if (PORTA.B3 == 1)
	BTFSS       PORTA+0, 3 
	GOTO        L_main10
;drawPixel.c,90 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawPixel.c,91 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	NOP
	NOP
;drawPixel.c,92 :: 		posY = posY - 1;
	MOVLW       1
	SUBWF       main_posY_L0+0, 1 
	MOVLW       0
	SUBWFB      main_posY_L0+1, 1 
;drawPixel.c,93 :: 		}
L_main10:
;drawPixel.c,96 :: 		}
	GOTO        L_main0
;drawPixel.c,99 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
