
_UARTx_Write2:

;movePixelUART.c,103 :: 		void UARTx_Write2(void *arg_data, size_t n)
;movePixelUART.c,106 :: 		uint8_t *p = (uint8_t *)arg_data;
	MOVF        FARG_UARTx_Write2_arg_data+0, 0 
	MOVWF       UARTx_Write2_p_L0+0 
	MOVF        FARG_UARTx_Write2_arg_data+1, 0 
	MOVWF       UARTx_Write2_p_L0+1 
;movePixelUART.c,108 :: 		for (i = 0; i < n; i++) {
	CLRF        UARTx_Write2_i_L0+0 
	CLRF        UARTx_Write2_i_L0+1 
L_UARTx_Write20:
	MOVF        FARG_UARTx_Write2_n+1, 0 
	SUBWF       UARTx_Write2_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__UARTx_Write276
	MOVF        FARG_UARTx_Write2_n+0, 0 
	SUBWF       UARTx_Write2_i_L0+0, 0 
L__UARTx_Write276:
	BTFSC       STATUS+0, 0 
	GOTO        L_UARTx_Write21
;movePixelUART.c,110 :: 		c = p[i];
	MOVF        UARTx_Write2_i_L0+0, 0 
	ADDWF       UARTx_Write2_p_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVF        UARTx_Write2_i_L0+1, 0 
	ADDWFC      UARTx_Write2_p_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
;movePixelUART.c,111 :: 		UART1_Write(c);
	CALL        _UART1_Write+0, 0
;movePixelUART.c,108 :: 		for (i = 0; i < n; i++) {
	INFSNZ      UARTx_Write2_i_L0+0, 1 
	INCF        UARTx_Write2_i_L0+1, 1 
;movePixelUART.c,112 :: 		}
	GOTO        L_UARTx_Write20
L_UARTx_Write21:
;movePixelUART.c,113 :: 		}
L_end_UARTx_Write2:
	RETURN      0
; end of _UARTx_Write2

_UARTx_Read2:

;movePixelUART.c,115 :: 		void UARTx_Read2(void *arg_data, size_t n)
;movePixelUART.c,117 :: 		char *p = (char *)arg_data;
	MOVF        FARG_UARTx_Read2_arg_data+0, 0 
	MOVWF       UARTx_Read2_p_L0+0 
	MOVF        FARG_UARTx_Read2_arg_data+1, 0 
	MOVWF       UARTx_Read2_p_L0+1 
;movePixelUART.c,119 :: 		for (i = 0; i < n; )
	CLRF        UARTx_Read2_i_L0+0 
	CLRF        UARTx_Read2_i_L0+1 
L_UARTx_Read23:
	MOVF        FARG_UARTx_Read2_n+1, 0 
	SUBWF       UARTx_Read2_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__UARTx_Read278
	MOVF        FARG_UARTx_Read2_n+0, 0 
	SUBWF       UARTx_Read2_i_L0+0, 0 
L__UARTx_Read278:
	BTFSC       STATUS+0, 0 
	GOTO        L_UARTx_Read24
;movePixelUART.c,121 :: 		if (UART_Data_Ready() == 1) {
	CALL        _UART_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_UARTx_Read26
;movePixelUART.c,122 :: 		p[i] = UART1_Read();
	MOVF        UARTx_Read2_i_L0+0, 0 
	ADDWF       UARTx_Read2_p_L0+0, 0 
	MOVWF       FLOC__UARTx_Read2+0 
	MOVF        UARTx_Read2_i_L0+1, 0 
	ADDWFC      UARTx_Read2_p_L0+1, 0 
	MOVWF       FLOC__UARTx_Read2+1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__UARTx_Read2+0, FSR1L+0
	MOVFF       FLOC__UARTx_Read2+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;movePixelUART.c,123 :: 		i++;
	INFSNZ      UARTx_Read2_i_L0+0, 1 
	INCF        UARTx_Read2_i_L0+1, 1 
;movePixelUART.c,124 :: 		}
L_UARTx_Read26:
;movePixelUART.c,127 :: 		}
	GOTO        L_UARTx_Read23
L_UARTx_Read24:
;movePixelUART.c,128 :: 		}
L_end_UARTx_Read2:
	RETURN      0
; end of _UARTx_Read2

_strlen:

;movePixelUART.c,131 :: 		size_t strlen(char *str) {
;movePixelUART.c,133 :: 		for (i = 0; str[i] != 0; i++)
	CLRF        R2 
	CLRF        R3 
L_strlen7:
	MOVF        R2, 0 
	ADDWF       FARG_strlen_str+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R3, 0 
	ADDWFC      FARG_strlen_str+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_strlen8
	INFSNZ      R2, 1 
	INCF        R3, 1 
;movePixelUART.c,136 :: 		}
	GOTO        L_strlen7
L_strlen8:
;movePixelUART.c,137 :: 		return i;
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	MOVWF       R1 
;movePixelUART.c,138 :: 		}
L_end_strlen:
	RETURN      0
; end of _strlen

_moveBall:

;movePixelUART.c,141 :: 		Generic moveBall(Generic ball)
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;movePixelUART.c,143 :: 		ball.posX = ball.posX + ball.dx;
	MOVF        FARG_moveBall_ball+2, 0 
	ADDWF       FARG_moveBall_ball+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_moveBall_ball+0 
;movePixelUART.c,144 :: 		ball.posY = ball.posY + ball.dy;
	MOVF        FARG_moveBall_ball+3, 0 
	ADDWF       FARG_moveBall_ball+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_moveBall_ball+1 
;movePixelUART.c,145 :: 		return ball;
	MOVLW       4
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_moveBall_ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_moveBall_ball+0)
	MOVWF       FSR0L+1 
L_moveBall10:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveBall10
;movePixelUART.c,146 :: 		}
L_end_moveBall:
	RETURN      0
; end of _moveBall

_check_collision:

;movePixelUART.c,149 :: 		bool check_collision(Generic _ball, Objeto player)
;movePixelUART.c,151 :: 		return (_ball.posX) < (player.positionX) + (player.positionX + 2) &&
	MOVLW       2
	ADDWF       FARG_check_collision_player+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        FARG_check_collision_player+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
;movePixelUART.c,152 :: 		(_ball.posX) + (_ball.posX + 3) > (player.positionX) &&
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision82
	MOVF        R2, 0 
	SUBWF       FARG_check_collision__ball+0, 0 
L__check_collision82:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision12
	MOVLW       3
	ADDWF       FARG_check_collision__ball+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        FARG_check_collision__ball+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision83
	MOVF        R2, 0 
	SUBWF       FARG_check_collision_player+0, 0 
L__check_collision83:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision12
;movePixelUART.c,153 :: 		(_ball.posY) < (player.positionY + player.positionY + 14) &&
	MOVF        FARG_check_collision_player+1, 0 
	ADDWF       FARG_check_collision_player+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       14
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision84
	MOVF        R2, 0 
	SUBWF       FARG_check_collision__ball+1, 0 
L__check_collision84:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision12
;movePixelUART.c,154 :: 		(_ball.posY + 14 + _ball.posY) > (player.positionY);
	MOVLW       14
	ADDWF       FARG_check_collision__ball+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        FARG_check_collision__ball+1, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision85
	MOVF        R2, 0 
	SUBWF       FARG_check_collision_player+1, 0 
L__check_collision85:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision12
	MOVLW       1
	MOVWF       R0 
	GOTO        L_check_collision11
L_check_collision12:
	CLRF        R0 
L_check_collision11:
;movePixelUART.c,155 :: 		}
L_end_check_collision:
	RETURN      0
; end of _check_collision

_randint:

;movePixelUART.c,158 :: 		uint8_t randint(uint8_t n)
;movePixelUART.c,160 :: 		return (uint8_t)(rand() % (n+1));
	CALL        _rand+0, 0
	MOVF        FARG_randint_n+0, 0 
	ADDLW       1
	MOVWF       R4 
	CLRF        R5 
	MOVLW       0
	ADDWFC      R5, 1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
;movePixelUART.c,161 :: 		}
L_end_randint:
	RETURN      0
; end of _randint

_main:

;movePixelUART.c,165 :: 		void main() {
;movePixelUART.c,168 :: 		Objeto playerOne = {122,18};
	MOVLW       122
	MOVWF       main_playerOne_L0+0 
	MOVLW       18
	MOVWF       main_playerOne_L0+1 
	MOVLW       5
	MOVWF       main_playerTwo_L0+0 
	MOVLW       18
	MOVWF       main_playerTwo_L0+1 
	MOVLW       64
	MOVWF       main_ball_L0+0 
	MOVLW       32
	MOVWF       main_ball_L0+1 
	MOVLW       255
	MOVWF       main_ball_L0+2 
	MOVLW       1
	MOVWF       main_ball_L0+3 
	MOVLW       3
	MOVWF       main_state_L0+0 
	CLRF        main_modeGame_L0+0 
;movePixelUART.c,179 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;movePixelUART.c,180 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
	NOP
;movePixelUART.c,181 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;movePixelUART.c,183 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;movePixelUART.c,184 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,186 :: 		while (1)
L_main14:
;movePixelUART.c,188 :: 		switch (state)
	GOTO        L_main16
;movePixelUART.c,190 :: 		case 0:
L_main18:
;movePixelUART.c,192 :: 		primerFrame();
	CALL        _primerFrame+0, 0
;movePixelUART.c,193 :: 		state = 1;
	MOVLW       1
	MOVWF       main_state_L0+0 
;movePixelUART.c,194 :: 		break;
	GOTO        L_main17
;movePixelUART.c,196 :: 		case 1:
L_main19:
;movePixelUART.c,197 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,198 :: 		Glcd_Circle(25, 34, 4, 1);
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
;movePixelUART.c,200 :: 		while (1)
L_main20:
;movePixelUART.c,202 :: 		key = readKeys();
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _readKeys+0, 0
	MOVLW       5
	MOVWF       R0 
	MOVLW       main_key_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_key_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main22:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
;movePixelUART.c,204 :: 		if ((key.enter) && (modeGame == 0))
	MOVF        main_key_L0+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	MOVF        main_modeGame_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main25
L__main74:
;movePixelUART.c,206 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main26:
	DECFSZ      R13, 1, 1
	BRA         L_main26
	DECFSZ      R12, 1, 1
	BRA         L_main26
	NOP
	NOP
;movePixelUART.c,207 :: 		state = 2;
	MOVLW       2
	MOVWF       main_state_L0+0 
;movePixelUART.c,208 :: 		break;
	GOTO        L_main21
;movePixelUART.c,209 :: 		}
L_main25:
;movePixelUART.c,211 :: 		if ((modeGame == 0) && ((key.down) || (key.up)))
	MOVF        main_modeGame_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main31
	MOVF        main_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main73
	MOVF        main_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main73
	GOTO        L_main31
L__main73:
L__main72:
;movePixelUART.c,213 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,214 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,215 :: 		Glcd_Circle(25, 48, 4, 1);
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
;movePixelUART.c,216 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main32:
	DECFSZ      R13, 1, 1
	BRA         L_main32
	DECFSZ      R12, 1, 1
	BRA         L_main32
	DECFSZ      R11, 1, 1
	BRA         L_main32
	NOP
	NOP
;movePixelUART.c,217 :: 		modeGame = 1;
	MOVLW       1
	MOVWF       main_modeGame_L0+0 
;movePixelUART.c,218 :: 		}
L_main31:
;movePixelUART.c,221 :: 		if ((key.enter == 1) && (modeGame == 1))
	MOVF        main_key_L0+4, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
	MOVF        main_modeGame_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
L__main71:
;movePixelUART.c,223 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main36:
	DECFSZ      R13, 1, 1
	BRA         L_main36
	DECFSZ      R12, 1, 1
	BRA         L_main36
	NOP
	NOP
;movePixelUART.c,224 :: 		state = 3;
	MOVLW       3
	MOVWF       main_state_L0+0 
;movePixelUART.c,225 :: 		break;
	GOTO        L_main21
;movePixelUART.c,226 :: 		}
L_main35:
;movePixelUART.c,228 :: 		if ((modeGame == 1) && ((key.down) || (key.up)))
	MOVF        main_modeGame_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main41
	MOVF        main_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	MOVF        main_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	GOTO        L_main41
L__main70:
L__main69:
;movePixelUART.c,230 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,231 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,232 :: 		Glcd_Circle(25, 35, 4, 1);
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
;movePixelUART.c,233 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main42:
	DECFSZ      R13, 1, 1
	BRA         L_main42
	DECFSZ      R12, 1, 1
	BRA         L_main42
	DECFSZ      R11, 1, 1
	BRA         L_main42
	NOP
	NOP
;movePixelUART.c,234 :: 		modeGame = 0;
	CLRF        main_modeGame_L0+0 
;movePixelUART.c,235 :: 		}
L_main41:
;movePixelUART.c,236 :: 		}
	GOTO        L_main20
L_main21:
;movePixelUART.c,237 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main43:
	DECFSZ      R13, 1, 1
	BRA         L_main43
	DECFSZ      R12, 1, 1
	BRA         L_main43
	DECFSZ      R11, 1, 1
	BRA         L_main43
	NOP
	NOP
;movePixelUART.c,238 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,239 :: 		break;
	GOTO        L_main17
;movePixelUART.c,241 :: 		case 2:
L_main44:
;movePixelUART.c,243 :: 		Glcd_Dot(playerOne.positionX, playerOne.positionY, 2);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;movePixelUART.c,244 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main45:
	DECFSZ      R13, 1, 1
	BRA         L_main45
	DECFSZ      R12, 1, 1
	BRA         L_main45
	NOP
;movePixelUART.c,245 :: 		playerOne = movePlayer(playerOne);
	MOVLW       2
	MOVWF       R0 
	MOVLW       FARG_movePlayer+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_movePlayer+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main46:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _movePlayer+0, 0
	MOVLW       2
	MOVWF       R0 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main47:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
;movePixelUART.c,246 :: 		break;
	GOTO        L_main17
;movePixelUART.c,248 :: 		case 3:
L_main48:
;movePixelUART.c,284 :: 		if(UART_Data_Ready() == 1){
	CALL        _UART_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;movePixelUART.c,285 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,289 :: 		UARTx_Read2(&buffer, 1);
	MOVLW       main_buffer_L0+0
	MOVWF       FARG_UARTx_Read2_arg_data+0 
	MOVLW       hi_addr(main_buffer_L0+0)
	MOVWF       FARG_UARTx_Read2_arg_data+1 
	MOVLW       1
	MOVWF       FARG_UARTx_Read2_n+0 
	MOVLW       0
	MOVWF       FARG_UARTx_Read2_n+1 
	CALL        _UARTx_Read2+0, 0
;movePixelUART.c,291 :: 		if (buffer == 0xEE || 0) {
	MOVF        main_buffer_L0+0, 0 
	XORLW       238
	BTFSC       STATUS+0, 2 
	GOTO        L__main68
	GOTO        L_main52
L__main68:
;movePixelUART.c,293 :: 		UARTx_Read2(&playerTwo, sizeof(Objeto));
	MOVLW       main_playerTwo_L0+0
	MOVWF       FARG_UARTx_Read2_arg_data+0 
	MOVLW       hi_addr(main_playerTwo_L0+0)
	MOVWF       FARG_UARTx_Read2_arg_data+1 
	MOVLW       2
	MOVWF       FARG_UARTx_Read2_n+0 
	MOVLW       0
	MOVWF       FARG_UARTx_Read2_n+1 
	CALL        _UARTx_Read2+0, 0
;movePixelUART.c,297 :: 		}
L_main52:
;movePixelUART.c,298 :: 		}
L_main49:
;movePixelUART.c,301 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,302 :: 		Delay_ms(50);
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
;movePixelUART.c,303 :: 		Glcd_Rectangle(playerOne.positionX, playerOne.positionY, playerOne.positionX + 2, playerOne.positionY + 14, 1);
	MOVF        main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVF        main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       2
	ADDWF       main_playerOne_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       14
	ADDWF       main_playerOne_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;movePixelUART.c,304 :: 		Glcd_Rectangle(playerTwo.positionX, playerTwo.positionY, playerTwo.positionX - 2, playerTwo.positionY + 14, 1);
	MOVF        main_playerTwo_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVF        main_playerTwo_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       2
	SUBWF       main_playerTwo_L0+0, 0 
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       14
	ADDWF       main_playerTwo_L0+1, 0 
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;movePixelUART.c,305 :: 		Glcd_Circle(ball.posX, ball.posY, 3, 1);
	MOVF        main_ball_L0+0, 0 
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVF        main_ball_L0+1, 0 
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;movePixelUART.c,309 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main54:
	DECFSZ      R13, 1, 1
	BRA         L_main54
	DECFSZ      R12, 1, 1
	BRA         L_main54
	NOP
;movePixelUART.c,310 :: 		break;
	GOTO        L_main17
;movePixelUART.c,313 :: 		default:
L_main55:
;movePixelUART.c,314 :: 		break;
	GOTO        L_main17
;movePixelUART.c,317 :: 		}
L_main16:
	MOVF        main_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
	MOVF        main_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
	MOVF        main_state_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main44
	MOVF        main_state_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
	GOTO        L_main55
L_main17:
;movePixelUART.c,319 :: 		}
	GOTO        L_main14
;movePixelUART.c,320 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_primerFrame:

;movePixelUART.c,322 :: 		void primerFrame(void){
;movePixelUART.c,323 :: 		Glcd_Image(pantallaDeInicio);
	MOVLW       _pantallaDeInicio+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;movePixelUART.c,324 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_primerFrame56:
	DECFSZ      R13, 1, 1
	BRA         L_primerFrame56
	DECFSZ      R12, 1, 1
	BRA         L_primerFrame56
	DECFSZ      R11, 1, 1
	BRA         L_primerFrame56
;movePixelUART.c,325 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;movePixelUART.c,327 :: 		}
L_end_primerFrame:
	RETURN      0
; end of _primerFrame

_movePlayer:

;movePixelUART.c,329 :: 		Objeto movePlayer(Objeto player)
	MOVF        R0, 0 
	MOVWF       _movePlayer_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _movePlayer_su_addr+1 
;movePixelUART.c,332 :: 		key = readKeys();
	MOVLW       FLOC__movePlayer+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__movePlayer+0)
	MOVWF       R1 
	CALL        _readKeys+0, 0
	MOVLW       5
	MOVWF       R0 
	MOVLW       movePlayer_key_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(movePlayer_key_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__movePlayer+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__movePlayer+0)
	MOVWF       FSR0L+1 
L_movePlayer57:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_movePlayer57
;movePixelUART.c,334 :: 		if (key.right){
	MOVF        movePlayer_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_movePlayer58
;movePixelUART.c,337 :: 		player.positionX = player.positionX + 1;
	MOVF        FARG_movePlayer_player+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_movePlayer_player+0 
;movePixelUART.c,338 :: 		}
L_movePlayer58:
;movePixelUART.c,340 :: 		if (key.left){
	MOVF        movePlayer_key_L0+3, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_movePlayer59
;movePixelUART.c,343 :: 		player.positionX = player.positionX - 1;
	DECF        FARG_movePlayer_player+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_movePlayer_player+0 
;movePixelUART.c,344 :: 		}
L_movePlayer59:
;movePixelUART.c,347 :: 		if (key.down){
	MOVF        movePlayer_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_movePlayer60
;movePixelUART.c,350 :: 		player.positionY = player.positionY + 1;
	MOVF        FARG_movePlayer_player+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_movePlayer_player+1 
;movePixelUART.c,351 :: 		}
L_movePlayer60:
;movePixelUART.c,353 :: 		if (key.up){
	MOVF        movePlayer_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_movePlayer61
;movePixelUART.c,356 :: 		player.positionY = player.positionY - 1;
	DECF        FARG_movePlayer_player+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_movePlayer_player+1 
;movePixelUART.c,357 :: 		}
L_movePlayer61:
;movePixelUART.c,359 :: 		return player;
	MOVLW       2
	MOVWF       R0 
	MOVF        _movePlayer_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _movePlayer_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_movePlayer_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_movePlayer_player+0)
	MOVWF       FSR0L+1 
L_movePlayer62:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_movePlayer62
;movePixelUART.c,360 :: 		}
L_end_movePlayer:
	RETURN      0
; end of _movePlayer

_readKeys:

;movePixelUART.c,365 :: 		Keys readKeys(void)
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;movePixelUART.c,369 :: 		tmp.right = PORTA.B0 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 0 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R6 
;movePixelUART.c,370 :: 		tmp.left  = PORTA.B1 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 1 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R7 
;movePixelUART.c,371 :: 		tmp.up    = PORTA.B2 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 2 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R4 
;movePixelUART.c,372 :: 		tmp.down  = PORTA.B3 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 3 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R5 
;movePixelUART.c,373 :: 		tmp.enter = PORTA.B4 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 4 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R8 
;movePixelUART.c,374 :: 		return tmp;
	MOVLW       5
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       4
	MOVWF       FSR0L+0 
	MOVLW       0
	MOVWF       FSR0L+1 
L_readKeys63:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_readKeys63
;movePixelUART.c,375 :: 		}
L_end_readKeys:
	RETURN      0
; end of _readKeys

_checkWallCollision:

;movePixelUART.c,378 :: 		void checkWallCollision(Generic *ball_tmp)
;movePixelUART.c,381 :: 		if (ball_tmp->posY > 60){
	MOVLW       1
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	SUBLW       60
	BTFSC       STATUS+0, 0 
	GOTO        L_checkWallCollision64
;movePixelUART.c,382 :: 		ball_tmp->dy = -1;
	MOVLW       3
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;movePixelUART.c,383 :: 		}
L_checkWallCollision64:
;movePixelUART.c,385 :: 		if (ball_tmp->posX < 5){
	MOVFF       FARG_checkWallCollision_ball_tmp+0, FSR0L+0
	MOVFF       FARG_checkWallCollision_ball_tmp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       5
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_checkWallCollision65
;movePixelUART.c,386 :: 		ball_tmp->dx = 1;
	MOVLW       2
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;movePixelUART.c,387 :: 		}
L_checkWallCollision65:
;movePixelUART.c,389 :: 		if (ball_tmp->posY < 5){
	MOVLW       1
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       5
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_checkWallCollision66
;movePixelUART.c,390 :: 		ball_tmp->dy = 1;
	MOVLW       3
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;movePixelUART.c,391 :: 		}
L_checkWallCollision66:
;movePixelUART.c,393 :: 		if (ball_tmp->posX > 124){
	MOVFF       FARG_checkWallCollision_ball_tmp+0, FSR0L+0
	MOVFF       FARG_checkWallCollision_ball_tmp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       124
	BTFSC       STATUS+0, 0 
	GOTO        L_checkWallCollision67
;movePixelUART.c,394 :: 		ball_tmp->dx = -1;
	MOVLW       2
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;movePixelUART.c,395 :: 		}
L_checkWallCollision67:
;movePixelUART.c,397 :: 		}
L_end_checkWallCollision:
	RETURN      0
; end of _checkWallCollision
