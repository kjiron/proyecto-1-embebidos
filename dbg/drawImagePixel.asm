
_main:

;drawImagePixel.c,64 :: 		void main() {
;drawImagePixel.c,70 :: 		posX = 62;
	MOVLW       62
	MOVWF       main_posX_L0+0 
	MOVLW       0
	MOVWF       main_posX_L0+1 
;drawImagePixel.c,71 :: 		posY = 32;
	MOVLW       32
	MOVWF       main_posY_L0+0 
	MOVLW       0
	MOVWF       main_posY_L0+1 
;drawImagePixel.c,72 :: 		state = 0;
	CLRF        main_state_L0+0 
	CLRF        main_state_L0+1 
;drawImagePixel.c,73 :: 		modeGame = 0;
	CLRF        main_modeGame_L0+0 
	CLRF        main_modeGame_L0+1 
;drawImagePixel.c,75 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;drawImagePixel.c,77 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;drawImagePixel.c,78 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,82 :: 		while (1)
L_main0:
;drawImagePixel.c,84 :: 		switch (state)
	GOTO        L_main2
;drawImagePixel.c,86 :: 		case 0:
L_main4:
;drawImagePixel.c,87 :: 		primerFrame();
	CALL        _primerFrame+0, 0
;drawImagePixel.c,88 :: 		state = 1;
	MOVLW       1
	MOVWF       main_state_L0+0 
	MOVLW       0
	MOVWF       main_state_L0+1 
;drawImagePixel.c,89 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,91 :: 		case 1:
L_main5:
;drawImagePixel.c,92 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,93 :: 		Glcd_Circle(25, 34, 4, 1);
	MOVLW       25
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVLW       34
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;drawImagePixel.c,94 :: 		while (1)
L_main6:
;drawImagePixel.c,96 :: 		if ((PORTA.B4 == 1) && (modeGame == 0))
	BTFSS       PORTA+0, 4 
	GOTO        L_main10
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVLW       0
	XORWF       main_modeGame_L0+0, 0 
L__main50:
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
L__main48:
;drawImagePixel.c,98 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	NOP
	NOP
;drawImagePixel.c,99 :: 		state = 2;
	MOVLW       2
	MOVWF       main_state_L0+0 
	MOVLW       0
	MOVWF       main_state_L0+1 
;drawImagePixel.c,100 :: 		break;
	GOTO        L_main7
;drawImagePixel.c,101 :: 		}
L_main10:
;drawImagePixel.c,114 :: 		if ((modeGame == 0) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main51
	MOVLW       0
	XORWF       main_modeGame_L0+0, 0 
L__main51:
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
	BTFSC       PORTA+0, 3 
	GOTO        L__main47
	BTFSC       PORTA+0, 2 
	GOTO        L__main47
	GOTO        L_main16
L__main47:
L__main46:
;drawImagePixel.c,116 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,117 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
	NOP
;drawImagePixel.c,118 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,119 :: 		Glcd_Circle(25, 48, 4, 1);
	MOVLW       25
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVLW       48
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;drawImagePixel.c,120 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main18:
	DECFSZ      R13, 1, 1
	BRA         L_main18
	DECFSZ      R12, 1, 1
	BRA         L_main18
	DECFSZ      R11, 1, 1
	BRA         L_main18
	NOP
	NOP
;drawImagePixel.c,121 :: 		modeGame = 1;
	MOVLW       1
	MOVWF       main_modeGame_L0+0 
	MOVLW       0
	MOVWF       main_modeGame_L0+1 
;drawImagePixel.c,122 :: 		}
L_main16:
;drawImagePixel.c,125 :: 		if ((PORTA.B4 == 1) && (modeGame == 1))
	BTFSS       PORTA+0, 4 
	GOTO        L_main21
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main52
	MOVLW       1
	XORWF       main_modeGame_L0+0, 0 
L__main52:
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
L__main45:
;drawImagePixel.c,127 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	NOP
	NOP
;drawImagePixel.c,128 :: 		state = 3;
	MOVLW       3
	MOVWF       main_state_L0+0 
	MOVLW       0
	MOVWF       main_state_L0+1 
;drawImagePixel.c,129 :: 		break;
	GOTO        L_main7
;drawImagePixel.c,130 :: 		}
L_main21:
;drawImagePixel.c,142 :: 		if ((modeGame == 1) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVLW       1
	XORWF       main_modeGame_L0+0, 0 
L__main53:
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
	BTFSC       PORTA+0, 3 
	GOTO        L__main44
	BTFSC       PORTA+0, 2 
	GOTO        L__main44
	GOTO        L_main27
L__main44:
L__main43:
;drawImagePixel.c,144 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,145 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main28:
	DECFSZ      R13, 1, 1
	BRA         L_main28
	DECFSZ      R12, 1, 1
	BRA         L_main28
	NOP
	NOP
;drawImagePixel.c,146 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,147 :: 		Glcd_Circle(25, 35, 4, 1);
	MOVLW       25
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVLW       35
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;drawImagePixel.c,148 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main29:
	DECFSZ      R13, 1, 1
	BRA         L_main29
	DECFSZ      R12, 1, 1
	BRA         L_main29
	DECFSZ      R11, 1, 1
	BRA         L_main29
	NOP
	NOP
;drawImagePixel.c,149 :: 		modeGame = 0;
	CLRF        main_modeGame_L0+0 
	CLRF        main_modeGame_L0+1 
;drawImagePixel.c,150 :: 		}
L_main27:
;drawImagePixel.c,153 :: 		}
	GOTO        L_main6
L_main7:
;drawImagePixel.c,154 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main30:
	DECFSZ      R13, 1, 1
	BRA         L_main30
	DECFSZ      R12, 1, 1
	BRA         L_main30
	DECFSZ      R11, 1, 1
	BRA         L_main30
	NOP
	NOP
;drawImagePixel.c,155 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,156 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,160 :: 		case 2:
L_main31:
;drawImagePixel.c,163 :: 		Glcd_Dot(posX, posY, 2);
	MOVF        main_posX_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_posY_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;drawImagePixel.c,164 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main32:
	DECFSZ      R13, 1, 1
	BRA         L_main32
	DECFSZ      R12, 1, 1
	BRA         L_main32
	NOP
;drawImagePixel.c,167 :: 		if (PORTA.B0 == 1)
	BTFSS       PORTA+0, 0 
	GOTO        L_main33
;drawImagePixel.c,169 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,170 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main34:
	DECFSZ      R13, 1, 1
	BRA         L_main34
	DECFSZ      R12, 1, 1
	BRA         L_main34
	NOP
	NOP
;drawImagePixel.c,171 :: 		posX = posX + 1;
	INFSNZ      main_posX_L0+0, 1 
	INCF        main_posX_L0+1, 1 
;drawImagePixel.c,172 :: 		}
L_main33:
;drawImagePixel.c,174 :: 		if (PORTA.B1 == 1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main35
;drawImagePixel.c,176 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,177 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main36:
	DECFSZ      R13, 1, 1
	BRA         L_main36
	DECFSZ      R12, 1, 1
	BRA         L_main36
	NOP
	NOP
;drawImagePixel.c,178 :: 		posX = posX - 1;
	MOVLW       1
	SUBWF       main_posX_L0+0, 1 
	MOVLW       0
	SUBWFB      main_posX_L0+1, 1 
;drawImagePixel.c,179 :: 		}
L_main35:
;drawImagePixel.c,182 :: 		if (PORTA.B2 == 1)
	BTFSS       PORTA+0, 2 
	GOTO        L_main37
;drawImagePixel.c,184 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,185 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main38:
	DECFSZ      R13, 1, 1
	BRA         L_main38
	DECFSZ      R12, 1, 1
	BRA         L_main38
	NOP
	NOP
;drawImagePixel.c,186 :: 		posY = posY + 1;
	INFSNZ      main_posY_L0+0, 1 
	INCF        main_posY_L0+1, 1 
;drawImagePixel.c,187 :: 		}
L_main37:
;drawImagePixel.c,189 :: 		if (PORTA.B3 == 1)
	BTFSS       PORTA+0, 3 
	GOTO        L_main39
;drawImagePixel.c,191 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,192 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main40:
	DECFSZ      R13, 1, 1
	BRA         L_main40
	DECFSZ      R12, 1, 1
	BRA         L_main40
	NOP
	NOP
;drawImagePixel.c,193 :: 		posY = posY - 1;
	MOVLW       1
	SUBWF       main_posY_L0+0, 1 
	MOVLW       0
	SUBWFB      main_posY_L0+1, 1 
;drawImagePixel.c,194 :: 		}
L_main39:
;drawImagePixel.c,195 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,197 :: 		default:
L_main41:
;drawImagePixel.c,198 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,199 :: 		}
L_main2:
	MOVLW       0
	XORWF       main_state_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       0
	XORWF       main_state_L0+0, 0 
L__main54:
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       0
	XORWF       main_state_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       1
	XORWF       main_state_L0+0, 0 
L__main55:
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVLW       0
	XORWF       main_state_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVLW       2
	XORWF       main_state_L0+0, 0 
L__main56:
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
	GOTO        L_main41
L_main3:
;drawImagePixel.c,201 :: 		}
	GOTO        L_main0
;drawImagePixel.c,204 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_primerFrame:

;drawImagePixel.c,206 :: 		void primerFrame(void){
;drawImagePixel.c,207 :: 		Glcd_Image(pantallaDeInicio);
	MOVLW       _pantallaDeInicio+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,208 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_primerFrame42:
	DECFSZ      R13, 1, 1
	BRA         L_primerFrame42
	DECFSZ      R12, 1, 1
	BRA         L_primerFrame42
	DECFSZ      R11, 1, 1
	BRA         L_primerFrame42
	NOP
;drawImagePixel.c,209 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,211 :: 		}
L_end_primerFrame:
	RETURN      0
; end of _primerFrame
