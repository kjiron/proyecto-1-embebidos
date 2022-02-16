
_main:

;drawImagePixel.c,84 :: 		void main() {
;drawImagePixel.c,87 :: 		Objeto player = {62, 32};
	MOVLW       62
	MOVWF       main_player_L0+0 
	MOVLW       32
	MOVWF       main_player_L0+1 
;drawImagePixel.c,93 :: 		state = 0;
	CLRF        main_state_L0+0 
	CLRF        main_state_L0+1 
;drawImagePixel.c,94 :: 		modeGame = 0;
	CLRF        main_modeGame_L0+0 
	CLRF        main_modeGame_L0+1 
;drawImagePixel.c,97 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;drawImagePixel.c,104 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;drawImagePixel.c,105 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,109 :: 		while (1)
L_main0:
;drawImagePixel.c,111 :: 		switch (state)
	GOTO        L_main2
;drawImagePixel.c,113 :: 		case 0:
L_main4:
;drawImagePixel.c,114 :: 		primerFrame();
	CALL        _primerFrame+0, 0
;drawImagePixel.c,115 :: 		state = 1;
	MOVLW       1
	MOVWF       main_state_L0+0 
	MOVLW       0
	MOVWF       main_state_L0+1 
;drawImagePixel.c,116 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,118 :: 		case 1:
L_main5:
;drawImagePixel.c,119 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,120 :: 		Glcd_Circle(25, 34, 4, 1);
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
;drawImagePixel.c,121 :: 		while (1)
L_main6:
;drawImagePixel.c,123 :: 		if ((PORTA.B4 == 1) && (modeGame == 0))
	BTFSS       PORTA+0, 4 
	GOTO        L_main10
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main51
	MOVLW       0
	XORWF       main_modeGame_L0+0, 0 
L__main51:
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
L__main49:
;drawImagePixel.c,125 :: 		Delay_ms(20);
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
;drawImagePixel.c,126 :: 		state = 2;
	MOVLW       2
	MOVWF       main_state_L0+0 
	MOVLW       0
	MOVWF       main_state_L0+1 
;drawImagePixel.c,127 :: 		break;
	GOTO        L_main7
;drawImagePixel.c,128 :: 		}
L_main10:
;drawImagePixel.c,130 :: 		if ((modeGame == 0) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main52
	MOVLW       0
	XORWF       main_modeGame_L0+0, 0 
L__main52:
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
	BTFSC       PORTA+0, 3 
	GOTO        L__main48
	BTFSC       PORTA+0, 2 
	GOTO        L__main48
	GOTO        L_main16
L__main48:
L__main47:
;drawImagePixel.c,132 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,133 :: 		Delay_ms(20);
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
;drawImagePixel.c,134 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,135 :: 		Glcd_Circle(25, 48, 4, 1);
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
;drawImagePixel.c,136 :: 		Delay_ms(1000);
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
;drawImagePixel.c,137 :: 		modeGame = 1;
	MOVLW       1
	MOVWF       main_modeGame_L0+0 
	MOVLW       0
	MOVWF       main_modeGame_L0+1 
;drawImagePixel.c,138 :: 		}
L_main16:
;drawImagePixel.c,141 :: 		if ((PORTA.B4 == 1) && (modeGame == 1))
	BTFSS       PORTA+0, 4 
	GOTO        L_main21
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVLW       1
	XORWF       main_modeGame_L0+0, 0 
L__main53:
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
L__main46:
;drawImagePixel.c,143 :: 		Delay_ms(20);
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
;drawImagePixel.c,144 :: 		state = 3;
	MOVLW       3
	MOVWF       main_state_L0+0 
	MOVLW       0
	MOVWF       main_state_L0+1 
;drawImagePixel.c,145 :: 		break;
	GOTO        L_main7
;drawImagePixel.c,146 :: 		}
L_main21:
;drawImagePixel.c,148 :: 		if ((modeGame == 1) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
	MOVLW       0
	XORWF       main_modeGame_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       1
	XORWF       main_modeGame_L0+0, 0 
L__main54:
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
	BTFSC       PORTA+0, 3 
	GOTO        L__main45
	BTFSC       PORTA+0, 2 
	GOTO        L__main45
	GOTO        L_main27
L__main45:
L__main44:
;drawImagePixel.c,150 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,151 :: 		Delay_ms(20);
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
;drawImagePixel.c,152 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,153 :: 		Glcd_Circle(25, 35, 4, 1);
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
;drawImagePixel.c,154 :: 		Delay_ms(1000);
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
;drawImagePixel.c,155 :: 		modeGame = 0;
	CLRF        main_modeGame_L0+0 
	CLRF        main_modeGame_L0+1 
;drawImagePixel.c,156 :: 		}
L_main27:
;drawImagePixel.c,159 :: 		}
	GOTO        L_main6
L_main7:
;drawImagePixel.c,160 :: 		Delay_ms(1000);
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
;drawImagePixel.c,161 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,162 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,166 :: 		case 2:
L_main31:
;drawImagePixel.c,168 :: 		Glcd_Dot(player.positionX, player.positionY, 2);
	MOVF        main_player_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_player_L0+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;drawImagePixel.c,169 :: 		Delay_ms(10);
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
;drawImagePixel.c,173 :: 		Glcd_Dot(player.positionX, player.positionY, 2);
	MOVF        main_player_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_player_L0+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;drawImagePixel.c,174 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main33:
	DECFSZ      R13, 1, 1
	BRA         L_main33
	DECFSZ      R12, 1, 1
	BRA         L_main33
	NOP
;drawImagePixel.c,176 :: 		if (PORTA.B0 == 1)
	BTFSS       PORTA+0, 0 
	GOTO        L_main34
;drawImagePixel.c,178 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,179 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main35:
	DECFSZ      R13, 1, 1
	BRA         L_main35
	DECFSZ      R12, 1, 1
	BRA         L_main35
	NOP
	NOP
;drawImagePixel.c,180 :: 		player.positionX = player.positionX + 1;
	MOVF        main_player_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_player_L0+0 
;drawImagePixel.c,181 :: 		}
L_main34:
;drawImagePixel.c,183 :: 		if (PORTA.B1 == 1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main36
;drawImagePixel.c,185 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,186 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main37:
	DECFSZ      R13, 1, 1
	BRA         L_main37
	DECFSZ      R12, 1, 1
	BRA         L_main37
	NOP
	NOP
;drawImagePixel.c,187 :: 		player.positionX = player.positionX - 1;
	DECF        main_player_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_player_L0+0 
;drawImagePixel.c,188 :: 		}
L_main36:
;drawImagePixel.c,191 :: 		if (PORTA.B2 == 1)
	BTFSS       PORTA+0, 2 
	GOTO        L_main38
;drawImagePixel.c,193 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,194 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main39:
	DECFSZ      R13, 1, 1
	BRA         L_main39
	DECFSZ      R12, 1, 1
	BRA         L_main39
	NOP
	NOP
;drawImagePixel.c,195 :: 		player.positionY = player.positionY + 1;
	MOVF        main_player_L0+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_player_L0+1 
;drawImagePixel.c,196 :: 		}
L_main38:
;drawImagePixel.c,198 :: 		if (PORTA.B3 == 1)
	BTFSS       PORTA+0, 3 
	GOTO        L_main40
;drawImagePixel.c,200 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,201 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main41:
	DECFSZ      R13, 1, 1
	BRA         L_main41
	DECFSZ      R12, 1, 1
	BRA         L_main41
	NOP
	NOP
;drawImagePixel.c,202 :: 		player.positionY = player.positionY - 1;
	DECF        main_player_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_player_L0+1 
;drawImagePixel.c,203 :: 		}
L_main40:
;drawImagePixel.c,205 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,207 :: 		default:
L_main42:
;drawImagePixel.c,208 :: 		break;
	GOTO        L_main3
;drawImagePixel.c,209 :: 		}
L_main2:
	MOVLW       0
	XORWF       main_state_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       0
	XORWF       main_state_L0+0, 0 
L__main55:
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       0
	XORWF       main_state_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVLW       1
	XORWF       main_state_L0+0, 0 
L__main56:
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVLW       0
	XORWF       main_state_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       2
	XORWF       main_state_L0+0, 0 
L__main57:
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
	GOTO        L_main42
L_main3:
;drawImagePixel.c,211 :: 		}
	GOTO        L_main0
;drawImagePixel.c,214 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_primerFrame:

;drawImagePixel.c,216 :: 		void primerFrame(void){
;drawImagePixel.c,217 :: 		Glcd_Image(pantallaDeInicio);
	MOVLW       _pantallaDeInicio+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawImagePixel.c,218 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_primerFrame43:
	DECFSZ      R13, 1, 1
	BRA         L_primerFrame43
	DECFSZ      R12, 1, 1
	BRA         L_primerFrame43
	DECFSZ      R11, 1, 1
	BRA         L_primerFrame43
;drawImagePixel.c,219 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawImagePixel.c,221 :: 		}
L_end_primerFrame:
	RETURN      0
; end of _primerFrame
