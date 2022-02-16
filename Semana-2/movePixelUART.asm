
_main:

;movePixelUART.c,84 :: 		void main() {
;movePixelUART.c,87 :: 		Objeto playerOne = {62,32};
	MOVLW       62
	MOVWF       main_playerOne_L0+0 
	MOVLW       32
	MOVWF       main_playerOne_L0+1 
	MOVLW       30
	MOVWF       main_playerTwo_L0+0 
	MOVLW       15
	MOVWF       main_playerTwo_L0+1 
	MOVLW       3
	MOVWF       main_state_L0+0 
	CLRF        main_modeGame_L0+0 
;movePixelUART.c,95 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;movePixelUART.c,96 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;movePixelUART.c,97 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;movePixelUART.c,101 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;movePixelUART.c,102 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,106 :: 		while (1)
L_main1:
;movePixelUART.c,108 :: 		switch (state)
	GOTO        L_main3
;movePixelUART.c,110 :: 		case 0:
L_main5:
;movePixelUART.c,111 :: 		primerFrame();
	CALL        _primerFrame+0, 0
;movePixelUART.c,112 :: 		state = 3;
	MOVLW       3
	MOVWF       main_state_L0+0 
;movePixelUART.c,113 :: 		break;
	GOTO        L_main4
;movePixelUART.c,115 :: 		case 1:
L_main6:
;movePixelUART.c,116 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,117 :: 		Glcd_Circle(25, 34, 4, 1);
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
;movePixelUART.c,118 :: 		while (1)
L_main7:
;movePixelUART.c,120 :: 		if ((PORTA.B4 == 1) && (modeGame == 0))
	BTFSS       PORTA+0, 4 
	GOTO        L_main11
	MOVF        main_modeGame_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
L__main75:
;movePixelUART.c,122 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	NOP
	NOP
;movePixelUART.c,123 :: 		state = 2;
	MOVLW       2
	MOVWF       main_state_L0+0 
;movePixelUART.c,124 :: 		break;
	GOTO        L_main8
;movePixelUART.c,125 :: 		}
L_main11:
;movePixelUART.c,127 :: 		if ((modeGame == 0) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
	MOVF        main_modeGame_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
	BTFSC       PORTA+0, 3 
	GOTO        L__main74
	BTFSC       PORTA+0, 2 
	GOTO        L__main74
	GOTO        L_main17
L__main74:
L__main73:
;movePixelUART.c,129 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,130 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main18:
	DECFSZ      R13, 1, 1
	BRA         L_main18
	DECFSZ      R12, 1, 1
	BRA         L_main18
	NOP
	NOP
;movePixelUART.c,131 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,132 :: 		Glcd_Circle(25, 48, 4, 1);
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
;movePixelUART.c,133 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main19:
	DECFSZ      R13, 1, 1
	BRA         L_main19
	DECFSZ      R12, 1, 1
	BRA         L_main19
	DECFSZ      R11, 1, 1
	BRA         L_main19
	NOP
	NOP
;movePixelUART.c,134 :: 		modeGame = 1;
	MOVLW       1
	MOVWF       main_modeGame_L0+0 
;movePixelUART.c,135 :: 		}
L_main17:
;movePixelUART.c,138 :: 		if ((PORTA.B4 == 1) && (modeGame == 1))
	BTFSS       PORTA+0, 4 
	GOTO        L_main22
	MOVF        main_modeGame_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
L__main72:
;movePixelUART.c,140 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main23:
	DECFSZ      R13, 1, 1
	BRA         L_main23
	DECFSZ      R12, 1, 1
	BRA         L_main23
	NOP
	NOP
;movePixelUART.c,141 :: 		state = 3;
	MOVLW       3
	MOVWF       main_state_L0+0 
;movePixelUART.c,142 :: 		break;
	GOTO        L_main8
;movePixelUART.c,143 :: 		}
L_main22:
;movePixelUART.c,145 :: 		if ((modeGame == 1) && ((PORTA.B3 == 1) || (PORTA.B2 == 1)))
	MOVF        main_modeGame_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main28
	BTFSC       PORTA+0, 3 
	GOTO        L__main71
	BTFSC       PORTA+0, 2 
	GOTO        L__main71
	GOTO        L_main28
L__main71:
L__main70:
;movePixelUART.c,147 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,148 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main29:
	DECFSZ      R13, 1, 1
	BRA         L_main29
	DECFSZ      R12, 1, 1
	BRA         L_main29
	NOP
	NOP
;movePixelUART.c,149 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,150 :: 		Glcd_Circle(25, 35, 4, 1);
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
;movePixelUART.c,151 :: 		Delay_ms(1000);
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
;movePixelUART.c,152 :: 		modeGame = 0;
	CLRF        main_modeGame_L0+0 
;movePixelUART.c,153 :: 		}
L_main28:
;movePixelUART.c,156 :: 		}
	GOTO        L_main7
L_main8:
;movePixelUART.c,157 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main31:
	DECFSZ      R13, 1, 1
	BRA         L_main31
	DECFSZ      R12, 1, 1
	BRA         L_main31
	DECFSZ      R11, 1, 1
	BRA         L_main31
	NOP
	NOP
;movePixelUART.c,158 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,159 :: 		break;
	GOTO        L_main4
;movePixelUART.c,163 :: 		case 2:
L_main32:
;movePixelUART.c,165 :: 		Glcd_Dot(playerOne.positionX, playerOne.positionY, 2);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;movePixelUART.c,166 :: 		Delay_ms(10);
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
;movePixelUART.c,170 :: 		Glcd_Dot(playerOne.positionX, playerOne.positionY, 2);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;movePixelUART.c,171 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main34:
	DECFSZ      R13, 1, 1
	BRA         L_main34
	DECFSZ      R12, 1, 1
	BRA         L_main34
	NOP
;movePixelUART.c,173 :: 		if (PORTA.B0 == 1)
	BTFSS       PORTA+0, 0 
	GOTO        L_main35
;movePixelUART.c,175 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,176 :: 		Delay_ms(5);
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
;movePixelUART.c,177 :: 		playerOne.positionX = playerOne.positionX + 1;
	MOVF        main_playerOne_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+0 
;movePixelUART.c,178 :: 		}
L_main35:
;movePixelUART.c,180 :: 		if (PORTA.B1 == 1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main37
;movePixelUART.c,182 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,183 :: 		Delay_ms(5);
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
;movePixelUART.c,184 :: 		playerOne.positionX = playerOne.positionX - 1;
	DECF        main_playerOne_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+0 
;movePixelUART.c,185 :: 		}
L_main37:
;movePixelUART.c,188 :: 		if (PORTA.B2 == 1)
	BTFSS       PORTA+0, 2 
	GOTO        L_main39
;movePixelUART.c,190 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,191 :: 		Delay_ms(5);
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
;movePixelUART.c,192 :: 		playerOne.positionY = playerOne.positionY + 1;
	MOVF        main_playerOne_L0+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+1 
;movePixelUART.c,193 :: 		}
L_main39:
;movePixelUART.c,195 :: 		if (PORTA.B3 == 1)
	BTFSS       PORTA+0, 3 
	GOTO        L_main41
;movePixelUART.c,197 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,198 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main42:
	DECFSZ      R13, 1, 1
	BRA         L_main42
	DECFSZ      R12, 1, 1
	BRA         L_main42
	NOP
	NOP
;movePixelUART.c,199 :: 		playerOne.positionY = playerOne.positionY - 1;
	DECF        main_playerOne_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+1 
;movePixelUART.c,200 :: 		}
L_main41:
;movePixelUART.c,202 :: 		break;
	GOTO        L_main4
;movePixelUART.c,204 :: 		case 3:
L_main43:
;movePixelUART.c,206 :: 		if(UART_Tx_Idle() == 1){
	CALL        _UART_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main44
;movePixelUART.c,207 :: 		if (PORTA.B0 == 1){
	BTFSS       PORTA+0, 0 
	GOTO        L_main45
;movePixelUART.c,208 :: 		UART1_Write(0xAA);
	MOVLW       170
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,209 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,210 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main46:
	DECFSZ      R13, 1, 1
	BRA         L_main46
	DECFSZ      R12, 1, 1
	BRA         L_main46
	NOP
	NOP
;movePixelUART.c,211 :: 		playerOne.positionX = playerOne.positionX + 1;
	MOVF        main_playerOne_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+0 
;movePixelUART.c,212 :: 		UART1_Write(playerOne.positionX);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,213 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main47:
	DECFSZ      R13, 1, 1
	BRA         L_main47
	DECFSZ      R12, 1, 1
	BRA         L_main47
	NOP
	NOP
;movePixelUART.c,214 :: 		}
L_main45:
;movePixelUART.c,216 :: 		if (PORTA.B1 == 1){
	BTFSS       PORTA+0, 1 
	GOTO        L_main48
;movePixelUART.c,217 :: 		UART1_Write(0xAA);
	MOVLW       170
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,218 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,219 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main49:
	DECFSZ      R13, 1, 1
	BRA         L_main49
	DECFSZ      R12, 1, 1
	BRA         L_main49
	NOP
	NOP
;movePixelUART.c,220 :: 		playerOne.positionX = playerOne.positionX - 1;
	DECF        main_playerOne_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+0 
;movePixelUART.c,221 :: 		UART1_Write(playerOne.positionX);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,222 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main50:
	DECFSZ      R13, 1, 1
	BRA         L_main50
	DECFSZ      R12, 1, 1
	BRA         L_main50
	NOP
	NOP
;movePixelUART.c,223 :: 		}
L_main48:
;movePixelUART.c,227 :: 		if (PORTA.B2 == 1){
	BTFSS       PORTA+0, 2 
	GOTO        L_main51
;movePixelUART.c,228 :: 		UART1_Write(0xBB);
	MOVLW       187
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,229 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,230 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main52:
	DECFSZ      R13, 1, 1
	BRA         L_main52
	DECFSZ      R12, 1, 1
	BRA         L_main52
	NOP
	NOP
;movePixelUART.c,231 :: 		playerOne.positionY = playerOne.positionY + 1;
	MOVF        main_playerOne_L0+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+1 
;movePixelUART.c,232 :: 		UART1_Write(playerOne.positionY);
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,233 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main53:
	DECFSZ      R13, 1, 1
	BRA         L_main53
	DECFSZ      R12, 1, 1
	BRA         L_main53
	NOP
	NOP
;movePixelUART.c,234 :: 		}
L_main51:
;movePixelUART.c,236 :: 		if (PORTA.B3 == 1){
	BTFSS       PORTA+0, 3 
	GOTO        L_main54
;movePixelUART.c,237 :: 		UART1_Write(0xBB);
	MOVLW       187
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,238 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,239 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main55:
	DECFSZ      R13, 1, 1
	BRA         L_main55
	DECFSZ      R12, 1, 1
	BRA         L_main55
	NOP
	NOP
;movePixelUART.c,240 :: 		playerOne.positionY = playerOne.positionY - 1;
	DECF        main_playerOne_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_playerOne_L0+1 
;movePixelUART.c,241 :: 		UART1_Write(playerOne.positionY);
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;movePixelUART.c,242 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main56:
	DECFSZ      R13, 1, 1
	BRA         L_main56
	DECFSZ      R12, 1, 1
	BRA         L_main56
	NOP
	NOP
;movePixelUART.c,243 :: 		}
L_main54:
;movePixelUART.c,245 :: 		}
L_main44:
;movePixelUART.c,248 :: 		if(UART_Data_Ready()){
	CALL        _UART_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
;movePixelUART.c,250 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,251 :: 		buffer = UART_Read();
	CALL        _UART_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_buffer_L0+0 
;movePixelUART.c,252 :: 		if(buffer == 0xAA){
	MOVF        R0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main58
;movePixelUART.c,254 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main59:
	DECFSZ      R13, 1, 1
	BRA         L_main59
	DECFSZ      R12, 1, 1
	BRA         L_main59
	NOP
	NOP
;movePixelUART.c,255 :: 		if(UART_Data_Ready()){
	CALL        _UART_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
;movePixelUART.c,257 :: 		buffer = UART_Read();
	CALL        _UART_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_buffer_L0+0 
;movePixelUART.c,258 :: 		playerTwo.positionX = (int)buffer;
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       main_playerTwo_L0+0 
;movePixelUART.c,259 :: 		}
L_main60:
;movePixelUART.c,260 :: 		}
	GOTO        L_main61
L_main58:
;movePixelUART.c,262 :: 		else if(buffer == 0xBB){
	MOVF        main_buffer_L0+0, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
;movePixelUART.c,263 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main63:
	DECFSZ      R13, 1, 1
	BRA         L_main63
	DECFSZ      R12, 1, 1
	BRA         L_main63
	NOP
	NOP
;movePixelUART.c,264 :: 		if(UART_Data_Ready()){
	CALL        _UART_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
;movePixelUART.c,267 :: 		buffer = UART_Read();
	CALL        _UART_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_buffer_L0+0 
;movePixelUART.c,268 :: 		playerTwo.positionY = (int)buffer;
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       main_playerTwo_L0+1 
;movePixelUART.c,269 :: 		}
L_main64:
;movePixelUART.c,270 :: 		}
	GOTO        L_main65
L_main62:
;movePixelUART.c,275 :: 		buffer = 0;
	CLRF        main_buffer_L0+0 
;movePixelUART.c,276 :: 		}
L_main65:
L_main61:
;movePixelUART.c,277 :: 		}
	GOTO        L_main66
L_main57:
;movePixelUART.c,283 :: 		}
L_main66:
;movePixelUART.c,287 :: 		Glcd_Rectangle(playerOne.positionX, playerOne.positionY, playerOne.positionX + 2, playerOne.positionY + 3, 1);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       2
	ADDWF       main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       3
	ADDWF       main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;movePixelUART.c,288 :: 		Glcd_Rectangle(playerTwo.positionX, playerTwo.positionY, playerTwo.positionX - 2, playerTwo.positionY + 3, 1);
	MOVF        main_playerTwo_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVF        main_playerTwo_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       2
	SUBWF       main_playerTwo_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       3
	ADDWF       main_playerTwo_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;movePixelUART.c,291 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main67:
	DECFSZ      R13, 1, 1
	BRA         L_main67
	DECFSZ      R12, 1, 1
	BRA         L_main67
	NOP
;movePixelUART.c,296 :: 		break;
	GOTO        L_main4
;movePixelUART.c,299 :: 		default:
L_main68:
;movePixelUART.c,300 :: 		break;
	GOTO        L_main4
;movePixelUART.c,301 :: 		}
L_main3:
	MOVF        main_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVF        main_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        main_state_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
	MOVF        main_state_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
	GOTO        L_main68
L_main4:
;movePixelUART.c,303 :: 		}
	GOTO        L_main1
;movePixelUART.c,306 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_primerFrame:

;movePixelUART.c,308 :: 		void primerFrame(void){
;movePixelUART.c,309 :: 		Glcd_Image(pantallaDeInicio);
	MOVLW       _pantallaDeInicio+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,310 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_primerFrame69:
	DECFSZ      R13, 1, 1
	BRA         L_primerFrame69
	DECFSZ      R12, 1, 1
	BRA         L_primerFrame69
	DECFSZ      R11, 1, 1
	BRA         L_primerFrame69
;movePixelUART.c,311 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,313 :: 		}
L_end_primerFrame:
	RETURN      0
; end of _primerFrame
