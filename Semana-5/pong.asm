
pong_Serial_Init:

;serial.h,14 :: 		static void Serial_Init()
;serial.h,24 :: 		UART1_Init(9600); // initialize hardware UART @baudrate=115200, the same setting for the sensor
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;serial.h,25 :: 		Delay_ms(100);    // let them stablize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_pong_Serial_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_pong_Serial_Init0
	DECFSZ      R12, 1, 1
	BRA         L_pong_Serial_Init0
	DECFSZ      R11, 1, 1
	BRA         L_pong_Serial_Init0
	NOP
;serial.h,27 :: 		PIE1.RCIE = 1; // enable interrupt source
	BSF         PIE1+0, 5 
;serial.h,28 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;serial.h,29 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;serial.h,30 :: 		}
L_end_Serial_Init:
	RETURN      0
; end of pong_Serial_Init

pong_readKeys:

;keys.h,16 :: 		static inline Keys readKeys()
	MOVF        R0, 0 
	MOVWF       pong_pong_readKeys_su_addr+0 
	MOVF        R1, 0 
	MOVWF       pong_pong_readKeys_su_addr+1 
;keys.h,20 :: 		uint32_t s = 0;
	CLRF        pong_readKeys_s_L0+0 
	CLRF        pong_readKeys_s_L0+1 
	CLRF        pong_readKeys_s_L0+2 
	CLRF        pong_readKeys_s_L0+3 
;keys.h,22 :: 		tmp.up = 0;
	CLRF        pong_readKeys_tmp_L0+0 
;keys.h,23 :: 		tmp.down = 0;
	CLRF        pong_readKeys_tmp_L0+1 
;keys.h,24 :: 		tmp.enter = 0;
	CLRF        pong_readKeys_tmp_L0+2 
;keys.h,27 :: 		tmp.enter = PORTA.B4 == 1;
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
	MOVWF       pong_readKeys_tmp_L0+2 
;keys.h,28 :: 		s = ADC_Read(3);
	MOVLW       3
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       pong_readKeys_s_L0+0 
	MOVF        R1, 0 
	MOVWF       pong_readKeys_s_L0+1 
	MOVLW       0
	MOVWF       pong_readKeys_s_L0+2 
	MOVWF       pong_readKeys_s_L0+3 
;keys.h,30 :: 		if (s >= 800)
	MOVLW       0
	SUBWF       pong_readKeys_s_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys193
	MOVLW       0
	SUBWF       pong_readKeys_s_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys193
	MOVLW       3
	SUBWF       pong_readKeys_s_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys193
	MOVLW       32
	SUBWF       pong_readKeys_s_L0+0, 0 
L_pong_readKeys193:
	BTFSS       STATUS+0, 0 
	GOTO        L_pong_readKeys1
;keys.h,32 :: 		tmp.up = 1;
	MOVLW       1
	MOVWF       pong_readKeys_tmp_L0+0 
;keys.h,33 :: 		}
	GOTO        L_pong_readKeys2
L_pong_readKeys1:
;keys.h,35 :: 		else if (s <= 200)
	MOVF        pong_readKeys_s_L0+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys194
	MOVF        pong_readKeys_s_L0+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys194
	MOVF        pong_readKeys_s_L0+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys194
	MOVF        pong_readKeys_s_L0+0, 0 
	SUBLW       200
L_pong_readKeys194:
	BTFSS       STATUS+0, 0 
	GOTO        L_pong_readKeys3
;keys.h,37 :: 		tmp.down = 1;
	MOVLW       1
	MOVWF       pong_readKeys_tmp_L0+1 
;keys.h,38 :: 		}
	GOTO        L_pong_readKeys4
L_pong_readKeys3:
;keys.h,42 :: 		return tmp;
	MOVLW       3
	MOVWF       R0 
	MOVF        pong_pong_readKeys_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        pong_pong_readKeys_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       pong_readKeys_tmp_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(pong_readKeys_tmp_L0+0)
	MOVWF       FSR0L+1 
L_pong_readKeys5:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys5
	GOTO        L_end_readKeys
;keys.h,43 :: 		}
L_pong_readKeys4:
L_pong_readKeys2:
;keys.h,45 :: 		return tmp;
	MOVLW       3
	MOVWF       R0 
	MOVF        pong_pong_readKeys_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        pong_pong_readKeys_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       pong_readKeys_tmp_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(pong_readKeys_tmp_L0+0)
	MOVWF       FSR0L+1 
L_pong_readKeys6:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_readKeys6
;keys.h,64 :: 		}
L_end_readKeys:
	RETURN      0
; end of pong_readKeys

pong_Draw_Init:

;drawglcd.h,48 :: 		static void Draw_Init()
;drawglcd.h,50 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;drawglcd.h,51 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,53 :: 		}
L_end_Draw_Init:
	RETURN      0
; end of pong_Draw_Init

_draw_loseFrame:

;drawglcd.h,68 :: 		void draw_loseFrame(){
;drawglcd.h,69 :: 		Glcd_Image(loseScreen);
	MOVLW       _loseScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,70 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_loseFrame7:
	DECFSZ      R13, 1, 1
	BRA         L_draw_loseFrame7
	DECFSZ      R12, 1, 1
	BRA         L_draw_loseFrame7
	DECFSZ      R11, 1, 1
	BRA         L_draw_loseFrame7
;drawglcd.h,71 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,73 :: 		}
L_end_draw_loseFrame:
	RETURN      0
; end of _draw_loseFrame

_draw_winFrame:

;drawglcd.h,76 :: 		void draw_winFrame(){
;drawglcd.h,77 :: 		Glcd_Image(winScreen);
	MOVLW       _winScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,78 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_winFrame8:
	DECFSZ      R13, 1, 1
	BRA         L_draw_winFrame8
	DECFSZ      R12, 1, 1
	BRA         L_draw_winFrame8
	DECFSZ      R11, 1, 1
	BRA         L_draw_winFrame8
;drawglcd.h,79 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,81 :: 		}
L_end_draw_winFrame:
	RETURN      0
; end of _draw_winFrame

_draw_InitFrame:

;drawglcd.h,85 :: 		void draw_InitFrame(){
;drawglcd.h,86 :: 		Glcd_Image(pantallaDeInicio);
	MOVLW       _pantallaDeInicio+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,87 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_InitFrame9:
	DECFSZ      R13, 1, 1
	BRA         L_draw_InitFrame9
	DECFSZ      R12, 1, 1
	BRA         L_draw_InitFrame9
	DECFSZ      R11, 1, 1
	BRA         L_draw_InitFrame9
;drawglcd.h,88 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,90 :: 		}
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_menuFrame:

;drawglcd.h,92 :: 		void menuFrame(){
;drawglcd.h,93 :: 		Glcd_Image(seleccionDeJuego);
	MOVLW       _seleccionDeJuego+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_seleccionDeJuego+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,94 :: 		}
L_end_menuFrame:
	RETURN      0
; end of _menuFrame

_draw_rect_pc:

;drawglcd.h,96 :: 		void draw_rect_pc(Splite s, uint8_t color)
;drawglcd.h,98 :: 		Glcd_Rectangle_Round_Edges_Fill(s.rect.x, s.rect.y, s.rect.x - s.rect.w, s.rect.y + s.rect.h, 0, color);
	MOVF        FARG_draw_rect_pc_s+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_x_upper_left+0 
	MOVF        FARG_draw_rect_pc_s+1, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_y_upper_left+0 
	MOVF        FARG_draw_rect_pc_s+2, 0 
	SUBWF       FARG_draw_rect_pc_s+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_x_bottom_right+0 
	MOVF        FARG_draw_rect_pc_s+3, 0 
	ADDWF       FARG_draw_rect_pc_s+1, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_y_bottom_right+0 
	CLRF        FARG_Glcd_Rectangle_Round_Edges_Fill_round_radius+0 
	MOVF        FARG_draw_rect_pc_color+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_color+0 
	CALL        _Glcd_Rectangle_Round_Edges_Fill+0, 0
;drawglcd.h,99 :: 		}
L_end_draw_rect_pc:
	RETURN      0
; end of _draw_rect_pc

_draw_rect_player:

;drawglcd.h,102 :: 		void draw_rect_player(Splite s, uint8_t color)
;drawglcd.h,104 :: 		Glcd_Rectangle_Round_Edges_Fill(s.rect.x, s.rect.y, s.rect.x + s.rect.w, s.rect.y + s.rect.h, 0, color);
	MOVF        FARG_draw_rect_player_s+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_x_upper_left+0 
	MOVF        FARG_draw_rect_player_s+1, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_y_upper_left+0 
	MOVF        FARG_draw_rect_player_s+2, 0 
	ADDWF       FARG_draw_rect_player_s+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_x_bottom_right+0 
	MOVF        FARG_draw_rect_player_s+3, 0 
	ADDWF       FARG_draw_rect_player_s+1, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_y_bottom_right+0 
	CLRF        FARG_Glcd_Rectangle_Round_Edges_Fill_round_radius+0 
	MOVF        FARG_draw_rect_player_color+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_color+0 
	CALL        _Glcd_Rectangle_Round_Edges_Fill+0, 0
;drawglcd.h,105 :: 		}
L_end_draw_rect_player:
	RETURN      0
; end of _draw_rect_player

_draw_box:

;drawglcd.h,108 :: 		void draw_box(Splite s, uint8_t color)
;drawglcd.h,110 :: 		Glcd_Box(s.rect.x, s.rect.y, s.rect.x + s.rect.w, s.rect.y + s.rect.h, color);
	MOVF        FARG_draw_box_s+0, 0 
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVF        FARG_draw_box_s+1, 0 
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVF        FARG_draw_box_s+2, 0 
	ADDWF       FARG_draw_box_s+0, 0 
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVF        FARG_draw_box_s+3, 0 
	ADDWF       FARG_draw_box_s+1, 0 
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVF        FARG_draw_box_color+0, 0 
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;drawglcd.h,111 :: 		}
L_end_draw_box:
	RETURN      0
; end of _draw_box

_draw_net:

;drawglcd.h,113 :: 		void draw_net()
;drawglcd.h,117 :: 		for ( i = 0; i < 14; i++)
	CLRF        draw_net_i_L0+0 
L_draw_net10:
	MOVLW       14
	SUBWF       draw_net_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_draw_net11
;drawglcd.h,119 :: 		GLcd_V_Line(8 + i*4, 8 + i*4 + 1, 0 + 126/2, 1);
	MOVF        draw_net_i_L0+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       8
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       63
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,117 :: 		for ( i = 0; i < 14; i++)
	INCF        draw_net_i_L0+0, 1 
;drawglcd.h,120 :: 		}
	GOTO        L_draw_net10
L_draw_net11:
;drawglcd.h,122 :: 		}
L_end_draw_net:
	RETURN      0
; end of _draw_net

_draw_text:

;drawglcd.h,124 :: 		void draw_text(char *text, uint8 x)
;drawglcd.h,126 :: 		Glcd_Write_Text(text, x, 0, 1);
	MOVF        FARG_draw_text_text+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        FARG_draw_text_text+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVF        FARG_draw_text_x+0, 0 
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;drawglcd.h,127 :: 		}
L_end_draw_text:
	RETURN      0
; end of _draw_text

_draw_score:

;drawglcd.h,133 :: 		void draw_score(uint8_t a, uint8_t b){ //function to draw the score
;drawglcd.h,136 :: 		ShortToStr(a, score_text);
	MOVF        FARG_draw_score_a+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;drawglcd.h,137 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;drawglcd.h,138 :: 		Glcd_Write_Text(fix_text, 95, 0, 1);
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;drawglcd.h,139 :: 		ShortToStr(b, score_text);
	MOVF        FARG_draw_score_b+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;drawglcd.h,140 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;drawglcd.h,141 :: 		Glcd_Write_Text(fix_text, 31, 0, 1);
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       31
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;drawglcd.h,142 :: 		}
L_end_draw_score:
	RETURN      0
; end of _draw_score

_draw_walls:

;drawglcd.h,145 :: 		void draw_walls()
;drawglcd.h,147 :: 		GLcd_V_Line(7, 63, 0, 1);
	MOVLW       7
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       63
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	CLRF        FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,148 :: 		GLcd_V_Line(7, 63, 127, 1);
	MOVLW       7
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       63
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       127
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,149 :: 		GLcd_H_Line(0, 127, 8, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       8
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;drawglcd.h,150 :: 		GLcd_H_Line(0, 127, 63, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       63
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;drawglcd.h,151 :: 		}
L_end_draw_walls:
	RETURN      0
; end of _draw_walls

_draw_circle:

;drawglcd.h,154 :: 		void draw_circle(Rect circle, uint8_t color)
;drawglcd.h,157 :: 		Glcd_Circle(circle.x, circle.y, circle.w, color);
	MOVF        FARG_draw_circle_circle+0, 0 
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	BTFSC       FARG_draw_circle_circle+0, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVF        FARG_draw_circle_circle+1, 0 
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	BTFSC       FARG_draw_circle_circle+1, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVF        FARG_draw_circle_circle+2, 0 
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	BTFSC       FARG_draw_circle_circle+2, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVF        FARG_draw_circle_color+0, 0 
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;drawglcd.h,158 :: 		}
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_clear:

;drawglcd.h,160 :: 		void draw_clear()
;drawglcd.h,162 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,163 :: 		}
L_end_draw_clear:
	RETURN      0
; end of _draw_clear

_draw_MenuGame:

;drawglcd.h,165 :: 		int draw_MenuGame(uint8_t modeGame)
;drawglcd.h,168 :: 		Rect select = {25, 34, 3, 0};
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;drawglcd.h,169 :: 		menuFrame();
	CALL        _menuFrame+0, 0
;drawglcd.h,170 :: 		draw_circle(select, 1);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame13:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame13
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,172 :: 		while (1)
L_draw_MenuGame14:
;drawglcd.h,176 :: 		key = readKeys();
	MOVLW       FLOC__draw_MenuGame+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__draw_MenuGame+0)
	MOVWF       R1 
	CALL        pong_readKeys+0, 0
	MOVLW       3
	MOVWF       R0 
	MOVLW       draw_MenuGame_key_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(draw_MenuGame_key_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__draw_MenuGame+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__draw_MenuGame+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame16:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame16
;drawglcd.h,178 :: 		if ((key.enter) && (modeGame == 0))
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
L__draw_MenuGame189:
;drawglcd.h,180 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,181 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;drawglcd.h,182 :: 		}
L_draw_MenuGame19:
;drawglcd.h,183 :: 		if ((key.up || key.down)  && (modeGame == 0))
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame188
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame188
	GOTO        L_draw_MenuGame24
L__draw_MenuGame188:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame24
L__draw_MenuGame187:
;drawglcd.h,185 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,186 :: 		menuFrame();
	CALL        _menuFrame+0, 0
;drawglcd.h,187 :: 		select.y = select.y + 14;  //offset
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;drawglcd.h,188 :: 		draw_circle(select, 1);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame25:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame25
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,189 :: 		modeGame = 1;
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;drawglcd.h,190 :: 		Delay_ms(666);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame26:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame26
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame26
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame26
	NOP
;drawglcd.h,191 :: 		continue;
	GOTO        L_draw_MenuGame14
;drawglcd.h,192 :: 		}
L_draw_MenuGame24:
;drawglcd.h,193 :: 		if ((key.enter) && (modeGame == 1))
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame29
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame29
L__draw_MenuGame186:
;drawglcd.h,195 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,196 :: 		return 3;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;drawglcd.h,197 :: 		}
L_draw_MenuGame29:
;drawglcd.h,198 :: 		if ((key.up || key.down ) && (modeGame == 1))
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame185
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame185
	GOTO        L_draw_MenuGame34
L__draw_MenuGame185:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame34
L__draw_MenuGame184:
;drawglcd.h,200 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,201 :: 		menuFrame();
	CALL        _menuFrame+0, 0
;drawglcd.h,202 :: 		select.y = select.y - 14;  //offset
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;drawglcd.h,203 :: 		draw_circle(select, 1);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame35:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame35
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,204 :: 		modeGame = 0;
	CLRF        FARG_draw_MenuGame_modeGame+0 
;drawglcd.h,205 :: 		Delay_ms(666);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame36:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame36
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame36
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame36
	NOP
;drawglcd.h,206 :: 		}
L_draw_MenuGame34:
;drawglcd.h,207 :: 		}
	GOTO        L_draw_MenuGame14
;drawglcd.h,208 :: 		}
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_move_player:

;hit.h,7 :: 		Splite move_player(Splite player)
	MOVF        R0, 0 
	MOVWF       _move_player_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_player_su_addr+1 
;hit.h,10 :: 		key = readKeys();
	MOVLW       FLOC__move_player+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__move_player+0)
	MOVWF       R1 
	CALL        pong_readKeys+0, 0
	MOVLW       3
	MOVWF       R0 
	MOVLW       move_player_key_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(move_player_key_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__move_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__move_player+0)
	MOVWF       FSR0L+1 
L_move_player37:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player37
;hit.h,12 :: 		if (key.down){
	MOVF        move_player_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player38
;hit.h,13 :: 		player.rect.y = player.rect.y + 1;
	MOVF        FARG_move_player_player+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_player_player+1 
;hit.h,14 :: 		if (player.rect.y >= 50){
	MOVLW       128
	XORWF       FARG_move_player_player+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       50
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player39
;hit.h,15 :: 		player.rect.y = 50;
	MOVLW       50
	MOVWF       FARG_move_player_player+1 
;hit.h,16 :: 		}
L_move_player39:
;hit.h,17 :: 		}
	GOTO        L_move_player40
L_move_player38:
;hit.h,19 :: 		else if (key.up){
	MOVF        move_player_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player41
;hit.h,20 :: 		player.rect.y = player.rect.y - 1;
	DECF        FARG_move_player_player+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_player_player+1 
;hit.h,21 :: 		if (player.rect.y <= 9){
	MOVLW       128
	XORLW       9
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_move_player_player+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player42
;hit.h,22 :: 		player.rect.y = 9;
	MOVLW       9
	MOVWF       FARG_move_player_player+1 
;hit.h,23 :: 		}
L_move_player42:
;hit.h,24 :: 		}
	GOTO        L_move_player43
L_move_player41:
;hit.h,27 :: 		return player;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_player_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_player_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player44:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player44
	GOTO        L_end_move_player
;hit.h,28 :: 		}
L_move_player43:
L_move_player40:
;hit.h,30 :: 		return player;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_player_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_player_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player45:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player45
;hit.h,32 :: 		}
L_end_move_player:
	RETURN      0
; end of _move_player

pong_check_collision00:

;hit.h,35 :: 		static inline bool check_collision00(Rect rect1, Rect rect2)
;hit.h,37 :: 		return rect1.x < rect2.x + rect2.w &&
	MOVF        FARG_pong_check_collision00_rect2+2, 0 
	ADDWF       FARG_pong_check_collision00_rect2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect2+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect2+2, 7 
	MOVLW       255
	ADDWFC      R2, 1 
;hit.h,38 :: 		rect1.x + rect1.w > rect2.x &&
	MOVLW       128
	BTFSC       FARG_pong_check_collision00_rect1+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_check_collision00212
	MOVF        R1, 0 
	SUBWF       FARG_pong_check_collision00_rect1+0, 0 
L_pong_check_collision00212:
	BTFSC       STATUS+0, 0 
	GOTO        L_pong_check_collision0047
	MOVF        FARG_pong_check_collision00_rect1+2, 0 
	ADDWF       FARG_pong_check_collision00_rect1+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect1+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect1+2, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_pong_check_collision00_rect2+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_check_collision00213
	MOVF        R1, 0 
	SUBWF       FARG_pong_check_collision00_rect2+0, 0 
L_pong_check_collision00213:
	BTFSC       STATUS+0, 0 
	GOTO        L_pong_check_collision0047
;hit.h,39 :: 		rect1.y < rect2.y + rect2.h &&
	MOVF        FARG_pong_check_collision00_rect2+3, 0 
	ADDWF       FARG_pong_check_collision00_rect2+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect2+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect2+3, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_pong_check_collision00_rect1+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_check_collision00214
	MOVF        R1, 0 
	SUBWF       FARG_pong_check_collision00_rect1+1, 0 
L_pong_check_collision00214:
	BTFSC       STATUS+0, 0 
	GOTO        L_pong_check_collision0047
;hit.h,40 :: 		rect1.h + rect1.y > rect2.y;
	MOVF        FARG_pong_check_collision00_rect1+1, 0 
	ADDWF       FARG_pong_check_collision00_rect1+3, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect1+3, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_pong_check_collision00_rect1+1, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_pong_check_collision00_rect2+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_pong_check_collision00215
	MOVF        R1, 0 
	SUBWF       FARG_pong_check_collision00_rect2+1, 0 
L_pong_check_collision00215:
	BTFSC       STATUS+0, 0 
	GOTO        L_pong_check_collision0047
	MOVLW       1
	MOVWF       R0 
	GOTO        L_pong_check_collision0046
L_pong_check_collision0047:
	CLRF        R0 
L_pong_check_collision0046:
;hit.h,41 :: 		}
L_end_check_collision00:
	RETURN      0
; end of pong_check_collision00

_check_collision:

;hit.h,44 :: 		bool check_collision(Splite ball, Splite player)
;hit.h,46 :: 		return check_collision00(ball.rect, player.rect);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_pong_check_collision00_rect1+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_pong_check_collision00_rect1+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_check_collision_ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_check_collision_ball+0)
	MOVWF       FSR0L+1 
L_check_collision48:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision48
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_pong_check_collision00_rect2+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_pong_check_collision00_rect2+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR0L+1 
L_check_collision49:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision49
	CALL        pong_check_collision00+0, 0
;hit.h,47 :: 		}
L_end_check_collision:
	RETURN      0
; end of _check_collision

_checkWallCollision:

;hit.h,51 :: 		void checkWallCollision(Splite *ball)
;hit.h,53 :: 		if (ball->rect.y >= 60)
	MOVLW       1
	ADDWF       FARG_checkWallCollision_ball+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       60
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkWallCollision50
;hit.h,55 :: 		ball->vel.dy = -ball->vel.dy;
	MOVLW       4
	ADDWF       FARG_checkWallCollision_ball+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR2L+0
	MOVFF       R3, FSR2H+0
	MOVF        POSTINC2+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,56 :: 		}
L_checkWallCollision50:
;hit.h,58 :: 		if (ball->rect.y <= 9)
	MOVLW       1
	ADDWF       FARG_checkWallCollision_ball+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       128
	XORLW       9
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkWallCollision51
;hit.h,60 :: 		ball->vel.dy = -ball->vel.dy;
	MOVLW       4
	ADDWF       FARG_checkWallCollision_ball+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR2L+0
	MOVFF       R3, FSR2H+0
	MOVF        POSTINC2+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,61 :: 		}
L_checkWallCollision51:
;hit.h,62 :: 		}
L_end_checkWallCollision:
	RETURN      0
; end of _checkWallCollision

_move_ball:

;hit.h,64 :: 		Splite move_ball(Splite ball)
	MOVF        R0, 0 
	MOVWF       _move_ball_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_ball_su_addr+1 
;hit.h,67 :: 		ball.rect.x += ball.vel.dx;
	MOVF        FARG_move_ball_ball+4, 0 
	ADDWF       FARG_move_ball_ball+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ball_ball+0 
;hit.h,68 :: 		ball.rect.y += ball.vel.dy;
	MOVF        FARG_move_ball_ball+5, 0 
	ADDWF       FARG_move_ball_ball+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ball_ball+1 
;hit.h,70 :: 		checkWallCollision(&ball);
	MOVLW       FARG_move_ball_ball+0
	MOVWF       FARG_checkWallCollision_ball+0 
	MOVLW       hi_addr(FARG_move_ball_ball+0)
	MOVWF       FARG_checkWallCollision_ball+1 
	CALL        _checkWallCollision+0, 0
;hit.h,72 :: 		return ball;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ball_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ball_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ball_ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ball_ball+0)
	MOVWF       FSR0L+1 
L_move_ball52:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ball52
;hit.h,73 :: 		}
L_end_move_ball:
	RETURN      0
; end of _move_ball

_move_ai:

;hit.h,75 :: 		Splite move_ai(Splite pc, Splite ball)
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;hit.h,77 :: 		uint8_t center = pc.rect.y + pc.rect.w/2;
	MOVF        FARG_move_ai_pc+2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 6 
	BSF         R0, 7 
	BTFSS       R0, 7 
	GOTO        L__move_ai220
	BTFSS       STATUS+0, 0 
	GOTO        L__move_ai220
	INCF        R0, 1 
L__move_ai220:
	MOVF        FARG_move_ai_pc+1, 0 
	ADDWF       R0, 1 
	MOVLW       0
	BTFSC       FARG_move_ai_pc+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       R4 
;hit.h,78 :: 		if (ball.rect.x < 62)
	MOVLW       128
	XORWF       FARG_move_ai_ball+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       62
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai53
;hit.h,80 :: 		if (ball.rect.y > center)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	BTFSC       FARG_move_ai_ball+1, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ai221
	MOVF        FARG_move_ai_ball+1, 0 
	SUBWF       R4, 0 
L__move_ai221:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai54
;hit.h,82 :: 		pc.rect.y++;
	MOVF        FARG_move_ai_pc+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ai_pc+1 
;hit.h,83 :: 		if (pc.rect.y >= 50)
	MOVLW       128
	XORWF       FARG_move_ai_pc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       50
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai55
;hit.h,85 :: 		pc.rect.y = 50;
	MOVLW       50
	MOVWF       FARG_move_ai_pc+1 
;hit.h,86 :: 		}
L_move_ai55:
;hit.h,87 :: 		}
	GOTO        L_move_ai56
L_move_ai54:
;hit.h,90 :: 		pc.rect.y--;
	DECF        FARG_move_ai_pc+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ai_pc+1 
;hit.h,91 :: 		if (pc.rect.y <= 9)
	MOVLW       128
	XORLW       9
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_move_ai_pc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai57
;hit.h,93 :: 		pc.rect.y = 9;
	MOVLW       9
	MOVWF       FARG_move_ai_pc+1 
;hit.h,94 :: 		}
L_move_ai57:
;hit.h,96 :: 		}
L_move_ai56:
;hit.h,97 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai58:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai58
	GOTO        L_end_move_ai
;hit.h,98 :: 		}
L_move_ai53:
;hit.h,99 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai59:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai59
;hit.h,100 :: 		}
L_end_move_ai:
	RETURN      0
; end of _move_ai

_goal:

;hit.h,102 :: 		bool goal(Splite *ball, uint8 *a, uint8 *b)
;hit.h,104 :: 		if (ball->rect.x >= 123)
	MOVFF       FARG_goal_ball+0, FSR0L+0
	MOVFF       FARG_goal_ball+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       123
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_goal60
;hit.h,106 :: 		ball->vel.dx = -1;
	MOVLW       4
	ADDWF       FARG_goal_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_goal_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;hit.h,107 :: 		ball->vel.dy = 1;
	MOVLW       4
	ADDWF       FARG_goal_ball+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_goal_ball+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;hit.h,108 :: 		(*b) = (*b) + 2;
	MOVFF       FARG_goal_b+0, FSR0L+0
	MOVFF       FARG_goal_b+1, FSR0H+0
	MOVFF       FARG_goal_b+0, FSR1L+0
	MOVFF       FARG_goal_b+1, FSR1H+0
	MOVLW       2
	ADDWF       POSTINC0+0, 1 
;hit.h,110 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_goal
;hit.h,111 :: 		}
L_goal60:
;hit.h,113 :: 		if (ball->rect.x <= 5)
	MOVFF       FARG_goal_ball+0, FSR0L+0
	MOVFF       FARG_goal_ball+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORLW       5
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_goal61
;hit.h,115 :: 		ball->vel.dx = 1;
	MOVLW       4
	ADDWF       FARG_goal_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_goal_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;hit.h,116 :: 		ball->vel.dy = -1;
	MOVLW       4
	ADDWF       FARG_goal_ball+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_goal_ball+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;hit.h,117 :: 		(*a) = (*a) + 2;
	MOVFF       FARG_goal_a+0, FSR0L+0
	MOVFF       FARG_goal_a+1, FSR0H+0
	MOVFF       FARG_goal_a+0, FSR1L+0
	MOVFF       FARG_goal_a+1, FSR1H+0
	MOVLW       2
	ADDWF       POSTINC0+0, 1 
;hit.h,119 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_goal
;hit.h,120 :: 		}
L_goal61:
;hit.h,122 :: 		return 0;
	CLRF        R0 
;hit.h,123 :: 		}
L_end_goal:
	RETURN      0
; end of _goal

_isPlayerNeedSend:

;pong.c,32 :: 		bool isPlayerNeedSend(Splite player) {
;pong.c,33 :: 		if (player.rect.y != lastPosPlayer.rect.y) {
	MOVF        FARG_isPlayerNeedSend_player+1, 0 
	XORWF       _lastPosPlayer+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_isPlayerNeedSend62
;pong.c,34 :: 		lastPosPlayer = player;
	MOVLW       6
	MOVWF       R0 
	MOVLW       _lastPosPlayer+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_lastPosPlayer+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_isPlayerNeedSend_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_isPlayerNeedSend_player+0)
	MOVWF       FSR0L+1 
L_isPlayerNeedSend63:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_isPlayerNeedSend63
;pong.c,35 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_isPlayerNeedSend
;pong.c,36 :: 		}
L_isPlayerNeedSend62:
;pong.c,37 :: 		return false;
	CLRF        R0 
;pong.c,38 :: 		}
L_end_isPlayerNeedSend:
	RETURN      0
; end of _isPlayerNeedSend

_isBallNeedSend:

;pong.c,41 :: 		bool isBallNeedSend(Splite player) {
;pong.c,42 :: 		if (player.vel.dx != lastBall.vel.dx) {
	MOVF        FARG_isBallNeedSend_player+4, 0 
	XORWF       _lastBall+4, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_isBallNeedSend64
;pong.c,43 :: 		lastBall = player;
	MOVLW       6
	MOVWF       R0 
	MOVLW       _lastBall+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_lastBall+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_isBallNeedSend_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_isBallNeedSend_player+0)
	MOVWF       FSR0L+1 
L_isBallNeedSend65:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_isBallNeedSend65
;pong.c,44 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_isBallNeedSend
;pong.c,45 :: 		}
L_isBallNeedSend64:
;pong.c,46 :: 		if (player.vel.dy != lastBall.vel.dy) {
	MOVF        FARG_isBallNeedSend_player+5, 0 
	XORWF       _lastBall+5, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_isBallNeedSend66
;pong.c,47 :: 		lastBall = player;
	MOVLW       6
	MOVWF       R0 
	MOVLW       _lastBall+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_lastBall+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_isBallNeedSend_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_isBallNeedSend_player+0)
	MOVWF       FSR0L+1 
L_isBallNeedSend67:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_isBallNeedSend67
;pong.c,48 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_isBallNeedSend
;pong.c,49 :: 		}
L_isBallNeedSend66:
;pong.c,50 :: 		return false;
	CLRF        R0 
;pong.c,51 :: 		}
L_end_isBallNeedSend:
	RETURN      0
; end of _isBallNeedSend

_init_game:

;pong.c,60 :: 		void init_game(){
;pong.c,61 :: 		playerOne.rect.x = SCREEN_WIDTH - 10;
	MOVLW       118
	MOVWF       _playerOne+0 
;pong.c,62 :: 		playerOne.rect.y = (SCREEN_HEIGHT/2) - 5;
	MOVLW       27
	MOVWF       _playerOne+1 
;pong.c,63 :: 		playerOne.rect.w = paddleWidth;
	MOVF        _paddleWidth+0, 0 
	MOVWF       _playerOne+2 
;pong.c,64 :: 		playerOne.rect.h = paddleHeight;
	MOVF        _paddleHeight+0, 0 
	MOVWF       _playerOne+3 
;pong.c,65 :: 		playerOne.vel.dx = 0;
	CLRF        _playerOne+4 
;pong.c,66 :: 		playerOne.vel.dy = 0;
	CLRF        _playerOne+5 
;pong.c,68 :: 		playerPC.rect.x = 7;
	MOVLW       7
	MOVWF       _playerPC+0 
;pong.c,69 :: 		playerPC.rect.y = (SCREEN_HEIGHT/2) - 5;
	MOVLW       27
	MOVWF       _playerPC+1 
;pong.c,70 :: 		playerPC.rect.w = paddleWidth;
	MOVF        _paddleWidth+0, 0 
	MOVWF       _playerPC+2 
;pong.c,71 :: 		playerPC.rect.h = paddleHeight;
	MOVF        _paddleHeight+0, 0 
	MOVWF       _playerPC+3 
;pong.c,72 :: 		playerPC.vel.dx = 0;
	CLRF        _playerPC+4 
;pong.c,73 :: 		playerPC.vel.dy = 0;
	CLRF        _playerPC+5 
;pong.c,75 :: 		playerTwo = playerPC;
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerTwo+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_init_game68:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_init_game68
;pong.c,77 :: 		ball.rect.x = SCREEN_WIDTH/2;
	MOVLW       64
	MOVWF       _ball+0 
;pong.c,78 :: 		ball.rect.y = (SCREEN_HEIGHT/2) - paddleHeight;
	MOVF        _paddleHeight+0, 0 
	SUBLW       32
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+1 
;pong.c,79 :: 		ball.rect.w = 2;
	MOVLW       2
	MOVWF       _ball+2 
;pong.c,80 :: 		ball.rect.h = 2;
	MOVLW       2
	MOVWF       _ball+3 
;pong.c,87 :: 		velocity = 1;
	MOVLW       1
	MOVWF       _velocity+0 
;pong.c,90 :: 		newBall = ball;
	MOVLW       6
	MOVWF       R0 
	MOVLW       _newBall+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_newBall+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_init_game69:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_init_game69
;pong.c,100 :: 		}
L_end_init_game:
	RETURN      0
; end of _init_game

_recvPlayer:

;pong.c,119 :: 		int recvPlayer() {
;pong.c,120 :: 		int i = 0, n;
	CLRF        recvPlayer_i_L0+0 
	CLRF        recvPlayer_i_L0+1 
;pong.c,122 :: 		while (1)
L_recvPlayer70:
;pong.c,124 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;pong.c,125 :: 		if (n >= 2) {
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__recvPlayer227
	MOVLW       2
	SUBWF       R0, 0 
L__recvPlayer227:
	BTFSS       STATUS+0, 0 
	GOTO        L_recvPlayer72
;pong.c,126 :: 		Serial_Read(&mark, 2);
	MOVLW       recvPlayer_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(recvPlayer_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;pong.c,127 :: 		if (mark == IamPlayer1) {
	MOVF        recvPlayer_mark_L0+1, 0 
	XORWF       _IamPlayer1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__recvPlayer228
	MOVF        _IamPlayer1+0, 0 
	XORWF       recvPlayer_mark_L0+0, 0 
L__recvPlayer228:
	BTFSS       STATUS+0, 2 
	GOTO        L_recvPlayer73
;pong.c,128 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_recvPlayer
;pong.c,129 :: 		}
L_recvPlayer73:
;pong.c,130 :: 		if (mark == IamPlayer2) {
	MOVF        recvPlayer_mark_L0+1, 0 
	XORWF       _IamPlayer2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__recvPlayer229
	MOVF        _IamPlayer2+0, 0 
	XORWF       recvPlayer_mark_L0+0, 0 
L__recvPlayer229:
	BTFSS       STATUS+0, 2 
	GOTO        L_recvPlayer74
;pong.c,131 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_recvPlayer
;pong.c,132 :: 		}
L_recvPlayer74:
;pong.c,135 :: 		}
L_recvPlayer72:
;pong.c,137 :: 		if (i == 5) {
	MOVLW       0
	XORWF       recvPlayer_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__recvPlayer230
	MOVLW       5
	XORWF       recvPlayer_i_L0+0, 0 
L__recvPlayer230:
	BTFSS       STATUS+0, 2 
	GOTO        L_recvPlayer75
;pong.c,138 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_recvPlayer
;pong.c,139 :: 		}
L_recvPlayer75:
;pong.c,140 :: 		i++;
	INFSNZ      recvPlayer_i_L0+0, 1 
	INCF        recvPlayer_i_L0+1, 1 
;pong.c,141 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_recvPlayer76:
	DECFSZ      R13, 1, 1
	BRA         L_recvPlayer76
	DECFSZ      R12, 1, 1
	BRA         L_recvPlayer76
	DECFSZ      R11, 1, 1
	BRA         L_recvPlayer76
;pong.c,142 :: 		}
	GOTO        L_recvPlayer70
;pong.c,144 :: 		}
L_end_recvPlayer:
	RETURN      0
; end of _recvPlayer

_syncPlayer:

;pong.c,154 :: 		int syncPlayer() {
;pong.c,156 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;pong.c,158 :: 		while (1)
L_syncPlayer77:
;pong.c,160 :: 		player = recvPlayer();
	CALL        _recvPlayer+0, 0
	MOVF        R0, 0 
	MOVWF       syncPlayer_player_L0+0 
	MOVF        R1, 0 
	MOVWF       syncPlayer_player_L0+1 
;pong.c,161 :: 		if (player == 1) {
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__syncPlayer232
	MOVLW       1
	XORWF       R0, 0 
L__syncPlayer232:
	BTFSS       STATUS+0, 2 
	GOTO        L_syncPlayer79
;pong.c,162 :: 		Serial_Write(&IamPlayer2, 2);
	MOVLW       _IamPlayer2+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_IamPlayer2+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,163 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_syncPlayer
;pong.c,164 :: 		}
L_syncPlayer79:
;pong.c,165 :: 		if (player == 2) {
	MOVLW       0
	XORWF       syncPlayer_player_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__syncPlayer233
	MOVLW       2
	XORWF       syncPlayer_player_L0+0, 0 
L__syncPlayer233:
	BTFSS       STATUS+0, 2 
	GOTO        L_syncPlayer80
;pong.c,166 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_syncPlayer
;pong.c,167 :: 		}
L_syncPlayer80:
;pong.c,168 :: 		Serial_Write(&IamPlayer1, 2);
	MOVLW       _IamPlayer1+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_IamPlayer1+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,169 :: 		}
	GOTO        L_syncPlayer77
;pong.c,170 :: 		}
L_end_syncPlayer:
	RETURN      0
; end of _syncPlayer

_moveAnother:

;pong.c,177 :: 		Splite moveAnother(Splite s) {
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;pong.c,178 :: 		return newPlayer;
	MOVLW       6
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       _newPlayer+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_newPlayer+0)
	MOVWF       FSR0L+1 
L_moveAnother81:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveAnother81
;pong.c,179 :: 		}
L_end_moveAnother:
	RETURN      0
; end of _moveAnother

_moveBall398:

;pong.c,182 :: 		Splite moveBall398(Splite s) {
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;pong.c,183 :: 		if (s.vel.dx != newBall.vel.dx || s.vel.dy != newBall.vel.dy) {
	MOVF        FARG_moveBall398_s+4, 0 
	XORWF       _newBall+4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveBall398190
	MOVF        FARG_moveBall398_s+5, 0 
	XORWF       _newBall+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveBall398190
	GOTO        L_moveBall39884
L__moveBall398190:
;pong.c,184 :: 		return newBall;
	MOVLW       6
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       _newBall+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_newBall+0)
	MOVWF       FSR0L+1 
L_moveBall39885:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveBall39885
	GOTO        L_end_moveBall398
;pong.c,185 :: 		}
L_moveBall39884:
;pong.c,186 :: 		return s;
	MOVLW       6
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_moveBall398_s+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_moveBall398_s+0)
	MOVWF       FSR0L+1 
L_moveBall39886:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveBall39886
;pong.c,187 :: 		}
L_end_moveBall398:
	RETURN      0
; end of _moveBall398

_forceSendPlayer:

;pong.c,192 :: 		void forceSendPlayer() {
;pong.c,194 :: 		if (whoAmI == 1) {
	MOVF        _whoAmI+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_forceSendPlayer87
;pong.c,196 :: 		if (isPlayerNeedSend(playerOne) || 1) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_isPlayerNeedSend_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_isPlayerNeedSend_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_forceSendPlayer88:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_forceSendPlayer88
	CALL        _isPlayerNeedSend+0, 0
;pong.c,197 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,198 :: 		Serial_Write(&playerOne, sizeof(Splite));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,201 :: 		}
L_forceSendPlayer87:
;pong.c,202 :: 		if (whoAmI == 2) {
	MOVF        _whoAmI+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_forceSendPlayer90
;pong.c,203 :: 		if (isPlayerNeedSend(playerTwo) || 1) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_isPlayerNeedSend_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_isPlayerNeedSend_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_forceSendPlayer91:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_forceSendPlayer91
	CALL        _isPlayerNeedSend+0, 0
;pong.c,204 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,205 :: 		Serial_Write(&playerTwo, sizeof(Splite));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,207 :: 		}
L_forceSendPlayer90:
;pong.c,209 :: 		}
L_end_forceSendPlayer:
	RETURN      0
; end of _forceSendPlayer

_updateData:

;pong.c,214 :: 		void updateData() {
;pong.c,218 :: 		while (1)
L_updateData93:
;pong.c,221 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;pong.c,222 :: 		if (n >= (2 + sizeof(Splite))) {
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	XORLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData238
	MOVLW       8
	SUBWF       R0, 0 
L__updateData238:
	BTFSS       STATUS+0, 0 
	GOTO        L_updateData95
;pong.c,223 :: 		Serial_Read(&mark, 2);
	MOVLW       updateData_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(updateData_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;pong.c,225 :: 		if (mark == SendBall) {
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendBall+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData239
	MOVF        _SendBall+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData239:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData96
;pong.c,226 :: 		Serial_Read(&newBall, sizeof(Splite));
	MOVLW       _newBall+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_newBall+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;pong.c,227 :: 		ball = moveBall398(ball);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_moveBall398_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_moveBall398_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_updateData97:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData97
	MOVLW       FLOC__updateData+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__updateData+0)
	MOVWF       R1 
	CALL        _moveBall398+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__updateData+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__updateData+0)
	MOVWF       FSR0L+1 
L_updateData98:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData98
;pong.c,228 :: 		continue;
	GOTO        L_updateData93
;pong.c,229 :: 		}
L_updateData96:
;pong.c,231 :: 		if (mark == SendPlayer) {
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendPlayer+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData240
	MOVF        _SendPlayer+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData240:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData99
;pong.c,232 :: 		Serial_Read(&newPlayer, sizeof(Splite));
	MOVLW       _newPlayer+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_newPlayer+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;pong.c,233 :: 		continue;
	GOTO        L_updateData93
;pong.c,234 :: 		}
L_updateData99:
;pong.c,236 :: 		if (mark == SendScore) {
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendScore+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData241
	MOVF        _SendScore+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData241:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData100
;pong.c,237 :: 		Serial_Read(&score, sizeof(Splite));
	MOVLW       _score+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;pong.c,238 :: 		scoreA = score.rect.x;
	MOVF        _score+0, 0 
	MOVWF       _scoreA+0 
;pong.c,239 :: 		scoreB = score.rect.y;
	MOVF        _score+1, 0 
	MOVWF       _scoreB+0 
;pong.c,240 :: 		draw_score(scoreA, scoreB);
	MOVF        _score+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _score+1, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;pong.c,241 :: 		init_game();
	CALL        _init_game+0, 0
;pong.c,242 :: 		Delay_ms(900);
	MOVLW       10
	MOVWF       R11, 0
	MOVLW       34
	MOVWF       R12, 0
	MOVLW       161
	MOVWF       R13, 0
L_updateData101:
	DECFSZ      R13, 1, 1
	BRA         L_updateData101
	DECFSZ      R12, 1, 1
	BRA         L_updateData101
	DECFSZ      R11, 1, 1
	BRA         L_updateData101
;pong.c,243 :: 		forceSendPlayer();
	CALL        _forceSendPlayer+0, 0
;pong.c,244 :: 		continue;
	GOTO        L_updateData93
;pong.c,245 :: 		}
L_updateData100:
;pong.c,248 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;pong.c,249 :: 		}
L_updateData95:
;pong.c,251 :: 		return;
;pong.c,254 :: 		}
L_end_updateData:
	RETURN      0
; end of _updateData

_main:

;pong.c,261 :: 		void main()
;pong.c,265 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;pong.c,269 :: 		ball.vel.dx = 1;
	MOVLW       1
	MOVWF       _ball+4 
;pong.c,270 :: 		ball.vel.dy = 1;
	MOVLW       1
	MOVWF       _ball+5 
;pong.c,272 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;pong.c,273 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;pong.c,277 :: 		Serial_Init();
	CALL        pong_Serial_Init+0, 0
;pong.c,281 :: 		Draw_Init();
	CALL        pong_Draw_Init+0, 0
;pong.c,283 :: 		init_game();
	CALL        _init_game+0, 0
;pong.c,284 :: 		while (1)
L_main102:
;pong.c,286 :: 		switch (state)
	GOTO        L_main104
;pong.c,288 :: 		case 0:
L_main106:
;pong.c,290 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;pong.c,291 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;pong.c,292 :: 		break;
	GOTO        L_main105
;pong.c,294 :: 		case 1:
L_main107:
;pong.c,297 :: 		state = draw_MenuGame(modeGame);
	MOVF        _modeGame+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       _state+0 
;pong.c,299 :: 		break;
	GOTO        L_main105
;pong.c,301 :: 		case 2:
L_main108:
;pong.c,303 :: 		draw_walls();
	CALL        _draw_walls+0, 0
;pong.c,304 :: 		draw_net();
	CALL        _draw_net+0, 0
;pong.c,305 :: 		draw_text("P1", SCREEN_WIDTH - 10);
	MOVLW       ?lstr1_pong+0
	MOVWF       FARG_draw_text_text+0 
	MOVLW       hi_addr(?lstr1_pong+0)
	MOVWF       FARG_draw_text_text+1 
	MOVLW       118
	MOVWF       FARG_draw_text_x+0 
	CALL        _draw_text+0, 0
;pong.c,306 :: 		draw_text("PC", 0);
	MOVLW       ?lstr2_pong+0
	MOVWF       FARG_draw_text_text+0 
	MOVLW       hi_addr(?lstr2_pong+0)
	MOVWF       FARG_draw_text_text+1 
	CLRF        FARG_draw_text_x+0 
	CALL        _draw_text+0, 0
;pong.c,307 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;pong.c,308 :: 		while (1)
L_main109:
;pong.c,311 :: 		playerOne = move_player(playerOne);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main111:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main111
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_player+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerOne+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main112:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main112
;pong.c,312 :: 		ball = move_ball(ball);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_ball_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_ball_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main113:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main113
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_ball+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main114:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main114
;pong.c,313 :: 		playerPC = move_ai(playerPC, ball);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main115:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main115
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_ai_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_ai_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main116:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main116
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_ai+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerPC+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main117:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main117
;pong.c,315 :: 		if (check_collision(ball, playerOne)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main118:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main118
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main119:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main119
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main120
;pong.c,316 :: 		velocity++;
	INCF        _velocity+0, 1 
;pong.c,317 :: 		if (velocity >= 3)
	MOVLW       3
	SUBWF       _velocity+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main121
;pong.c,319 :: 		velocity = 3;
	MOVLW       3
	MOVWF       _velocity+0 
;pong.c,320 :: 		}
L_main121:
;pong.c,321 :: 		ball.vel.dx = -velocity;
	MOVF        _velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+4 
;pong.c,322 :: 		}
L_main120:
;pong.c,324 :: 		if (check_collision(ball, playerPC)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main122:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main122
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main123:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main123
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main124
;pong.c,325 :: 		velocity++;
	INCF        _velocity+0, 1 
;pong.c,326 :: 		if (velocity >= 3)
	MOVLW       3
	SUBWF       _velocity+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main125
;pong.c,328 :: 		velocity = 3;
	MOVLW       3
	MOVWF       _velocity+0 
;pong.c,329 :: 		}
L_main125:
;pong.c,330 :: 		ball.vel.dx = velocity;
	MOVF        _velocity+0, 0 
	MOVWF       _ball+4 
;pong.c,331 :: 		}
L_main124:
;pong.c,334 :: 		if (goal(&ball, &scoreA, &scoreB))
	MOVLW       _ball+0
	MOVWF       FARG_goal_ball+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FARG_goal_ball+1 
	MOVLW       _scoreA+0
	MOVWF       FARG_goal_a+0 
	MOVLW       hi_addr(_scoreA+0)
	MOVWF       FARG_goal_a+1 
	MOVLW       _scoreB+0
	MOVWF       FARG_goal_b+0 
	MOVLW       hi_addr(_scoreB+0)
	MOVWF       FARG_goal_b+1 
	CALL        _goal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main126
;pong.c,336 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;pong.c,338 :: 		ball.rect.x = SCREEN_WIDTH/2;
	MOVLW       64
	MOVWF       _ball+0 
;pong.c,339 :: 		ball.rect.y = (SCREEN_HEIGHT/2) - paddleHeight;
	MOVF        _paddleHeight+0, 0 
	SUBLW       32
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+1 
;pong.c,340 :: 		ball.rect.w = 2;
	MOVLW       2
	MOVWF       _ball+2 
;pong.c,341 :: 		ball.rect.h = 2;
	MOVLW       2
	MOVWF       _ball+3 
;pong.c,343 :: 		init_game();
	CALL        _init_game+0, 0
;pong.c,344 :: 		}
L_main126:
;pong.c,346 :: 		if (scoreA == 10)
	MOVF        _scoreA+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main127
;pong.c,348 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;pong.c,349 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;pong.c,350 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;pong.c,351 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;pong.c,352 :: 		break;
	GOTO        L_main110
;pong.c,353 :: 		}
L_main127:
;pong.c,355 :: 		if (scoreB == 10)
	MOVF        _scoreB+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main128
;pong.c,357 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;pong.c,358 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;pong.c,359 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;pong.c,360 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;pong.c,361 :: 		break;
	GOTO        L_main110
;pong.c,362 :: 		}
L_main128:
;pong.c,365 :: 		draw_box(ball, DRAW);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main129:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main129
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,366 :: 		draw_box(playerOne, DRAW);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main130:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main130
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,367 :: 		draw_box(playerPC, DRAW);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main131:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main131
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,368 :: 		draw_net();
	CALL        _draw_net+0, 0
;pong.c,370 :: 		Delay_ms(30);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_main132:
	DECFSZ      R13, 1, 1
	BRA         L_main132
	DECFSZ      R12, 1, 1
	BRA         L_main132
;pong.c,371 :: 		draw_box(playerOne, ERASE);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main133:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main133
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,372 :: 		draw_box(playerPC, ERASE);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main134:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main134
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,373 :: 		draw_box(ball, ERASE);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main135:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main135
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,376 :: 		}
	GOTO        L_main109
L_main110:
;pong.c,377 :: 		break;
	GOTO        L_main105
;pong.c,379 :: 		case 3:
L_main136:
;pong.c,380 :: 		init_game();
	CALL        _init_game+0, 0
;pong.c,382 :: 		draw_walls();
	CALL        _draw_walls+0, 0
;pong.c,383 :: 		draw_net();
	CALL        _draw_net+0, 0
;pong.c,384 :: 		draw_text("P1", SCREEN_WIDTH - 10);
	MOVLW       ?lstr3_pong+0
	MOVWF       FARG_draw_text_text+0 
	MOVLW       hi_addr(?lstr3_pong+0)
	MOVWF       FARG_draw_text_text+1 
	MOVLW       118
	MOVWF       FARG_draw_text_x+0 
	CALL        _draw_text+0, 0
;pong.c,385 :: 		draw_text("P2", 0);
	MOVLW       ?lstr4_pong+0
	MOVWF       FARG_draw_text_text+0 
	MOVLW       hi_addr(?lstr4_pong+0)
	MOVWF       FARG_draw_text_text+1 
	CLRF        FARG_draw_text_x+0 
	CALL        _draw_text+0, 0
;pong.c,386 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;pong.c,388 :: 		whoAmI = syncPlayer();
	CALL        _syncPlayer+0, 0
	MOVF        R0, 0 
	MOVWF       _whoAmI+0 
;pong.c,389 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;pong.c,390 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main137:
	DECFSZ      R13, 1, 1
	BRA         L_main137
	DECFSZ      R12, 1, 1
	BRA         L_main137
	DECFSZ      R11, 1, 1
	BRA         L_main137
	NOP
;pong.c,392 :: 		forceSendPlayer();
	CALL        _forceSendPlayer+0, 0
;pong.c,394 :: 		while (1)
L_main138:
;pong.c,397 :: 		updateData();
	CALL        _updateData+0, 0
;pong.c,400 :: 		ball = move_ball(ball);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_ball_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_ball_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main140:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main140
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_ball+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main141:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main141
;pong.c,405 :: 		if (check_collision(ball, playerOne)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main142:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main142
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main143:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main143
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main144
;pong.c,406 :: 		velocity++;
	INCF        _velocity+0, 1 
;pong.c,407 :: 		if (velocity >= 3)
	MOVLW       3
	SUBWF       _velocity+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main145
;pong.c,409 :: 		velocity = 3;
	MOVLW       3
	MOVWF       _velocity+0 
;pong.c,410 :: 		}
L_main145:
;pong.c,411 :: 		ball.vel.dx = -velocity;
	MOVF        _velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+4 
;pong.c,412 :: 		}
L_main144:
;pong.c,414 :: 		if (check_collision(ball, playerTwo)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_ball+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_ball+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main146:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main146
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main147:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main147
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main148
;pong.c,415 :: 		velocity++;
	INCF        _velocity+0, 1 
;pong.c,416 :: 		if (velocity >= 3)
	MOVLW       3
	SUBWF       _velocity+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main149
;pong.c,419 :: 		velocity = 3;
	MOVLW       3
	MOVWF       _velocity+0 
;pong.c,420 :: 		}
L_main149:
;pong.c,421 :: 		ball.vel.dx = velocity;
	MOVF        _velocity+0, 0 
	MOVWF       _ball+4 
;pong.c,422 :: 		}
L_main148:
;pong.c,427 :: 		if (whoAmI == 1) {
	MOVF        _whoAmI+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main150
;pong.c,428 :: 		playerTwo = moveAnother(playerTwo);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_moveAnother_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_moveAnother_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main151:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main151
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _moveAnother+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerTwo+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main152:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main152
;pong.c,429 :: 		playerOne = move_player(playerOne);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main153:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main153
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_player+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerOne+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main154:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main154
;pong.c,431 :: 		if (isPlayerNeedSend(playerOne)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_isPlayerNeedSend_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_isPlayerNeedSend_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main155:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main155
	CALL        _isPlayerNeedSend+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main156
;pong.c,432 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,433 :: 		Serial_Write(&playerOne, sizeof(Splite));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,434 :: 		}
L_main156:
;pong.c,436 :: 		if (goal(&ball, &scoreA, &scoreB))
	MOVLW       _ball+0
	MOVWF       FARG_goal_ball+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FARG_goal_ball+1 
	MOVLW       _scoreA+0
	MOVWF       FARG_goal_a+0 
	MOVLW       hi_addr(_scoreA+0)
	MOVWF       FARG_goal_a+1 
	MOVLW       _scoreB+0
	MOVWF       FARG_goal_b+0 
	MOVLW       hi_addr(_scoreB+0)
	MOVWF       FARG_goal_b+1 
	CALL        _goal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main157
;pong.c,438 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;pong.c,439 :: 		ball.rect.x = SCREEN_WIDTH/2;
	MOVLW       64
	MOVWF       _ball+0 
;pong.c,440 :: 		ball.rect.y = (SCREEN_HEIGHT/2) - paddleHeight;
	MOVF        _paddleHeight+0, 0 
	SUBLW       32
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+1 
;pong.c,441 :: 		ball.rect.w = 2;
	MOVLW       2
	MOVWF       _ball+2 
;pong.c,442 :: 		ball.rect.h = 2;
	MOVLW       2
	MOVWF       _ball+3 
;pong.c,444 :: 		init_game();
	CALL        _init_game+0, 0
;pong.c,446 :: 		score.rect.x = scoreA;
	MOVF        _scoreA+0, 0 
	MOVWF       _score+0 
;pong.c,447 :: 		score.rect.y = scoreB;
	MOVF        _scoreB+0, 0 
	MOVWF       _score+1 
;pong.c,448 :: 		Serial_Write(&SendScore, 2);
	MOVLW       _SendScore+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendScore+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,449 :: 		Serial_Write(&score, sizeof(Splite));
	MOVLW       _score+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,450 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main158:
	DECFSZ      R13, 1, 1
	BRA         L_main158
	DECFSZ      R12, 1, 1
	BRA         L_main158
	DECFSZ      R11, 1, 1
	BRA         L_main158
	NOP
	NOP
;pong.c,451 :: 		forceSendPlayer();
	CALL        _forceSendPlayer+0, 0
;pong.c,453 :: 		continue;
	GOTO        L_main138
;pong.c,454 :: 		}
L_main157:
;pong.c,457 :: 		if (isBallNeedSend(ball)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_isBallNeedSend_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_isBallNeedSend_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main159:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main159
	CALL        _isBallNeedSend+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main160
;pong.c,458 :: 		Serial_Write(&SendBall, 2);
	MOVLW       _SendBall+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendBall+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,459 :: 		Serial_Write(&ball, sizeof(ball));
	MOVLW       _ball+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,460 :: 		}
L_main160:
;pong.c,462 :: 		}
L_main150:
;pong.c,463 :: 		if (whoAmI == 2) {
	MOVF        _whoAmI+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main161
;pong.c,464 :: 		playerOne = moveAnother(playerOne);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_moveAnother_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_moveAnother_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main162:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main162
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _moveAnother+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerOne+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main163:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main163
;pong.c,465 :: 		playerTwo = move_player(playerTwo);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main164:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main164
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_player+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerTwo+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main165:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main165
;pong.c,467 :: 		if (isPlayerNeedSend(playerTwo)) {
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_isPlayerNeedSend_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_isPlayerNeedSend_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main166:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main166
	CALL        _isPlayerNeedSend+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main167
;pong.c,468 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,469 :: 		Serial_Write(&playerTwo, sizeof(Splite));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;pong.c,470 :: 		}
L_main167:
;pong.c,474 :: 		if (goal(&ball, &scoreA, &scoreB))
	MOVLW       _ball+0
	MOVWF       FARG_goal_ball+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FARG_goal_ball+1 
	MOVLW       _scoreA+0
	MOVWF       FARG_goal_a+0 
	MOVLW       hi_addr(_scoreA+0)
	MOVWF       FARG_goal_a+1 
	MOVLW       _scoreB+0
	MOVWF       FARG_goal_b+0 
	MOVLW       hi_addr(_scoreB+0)
	MOVWF       FARG_goal_b+1 
	CALL        _goal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main168
;pong.c,476 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main169:
	DECFSZ      R13, 1, 1
	BRA         L_main169
	DECFSZ      R12, 1, 1
	BRA         L_main169
	DECFSZ      R11, 1, 1
	BRA         L_main169
	NOP
;pong.c,477 :: 		continue;
	GOTO        L_main138
;pong.c,478 :: 		}
L_main168:
;pong.c,480 :: 		}
L_main161:
;pong.c,483 :: 		if (scoreA == 10)
	MOVF        _scoreA+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main170
;pong.c,485 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;pong.c,486 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;pong.c,487 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;pong.c,489 :: 		if (whoAmI == 1) {
	MOVF        _whoAmI+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main171
;pong.c,490 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;pong.c,491 :: 		}
	GOTO        L_main172
L_main171:
;pong.c,493 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;pong.c,494 :: 		}
L_main172:
;pong.c,496 :: 		break;
	GOTO        L_main139
;pong.c,497 :: 		}
L_main170:
;pong.c,500 :: 		if (scoreB == 10)
	MOVF        _scoreB+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main173
;pong.c,502 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;pong.c,503 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;pong.c,504 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;pong.c,506 :: 		if (whoAmI == 2) {
	MOVF        _whoAmI+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main174
;pong.c,507 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;pong.c,508 :: 		}else {
	GOTO        L_main175
L_main174:
;pong.c,509 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;pong.c,510 :: 		}
L_main175:
;pong.c,512 :: 		break;
	GOTO        L_main139
;pong.c,513 :: 		}
L_main173:
;pong.c,517 :: 		draw_box(ball, DRAW);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main176:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main176
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,518 :: 		draw_box(playerOne, DRAW);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main177:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main177
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,519 :: 		draw_box(playerTwo, DRAW);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main178:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main178
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,520 :: 		draw_net();
	CALL        _draw_net+0, 0
;pong.c,521 :: 		Delay_ms(30);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_main179:
	DECFSZ      R13, 1, 1
	BRA         L_main179
	DECFSZ      R12, 1, 1
	BRA         L_main179
;pong.c,522 :: 		draw_box(playerOne, ERASE);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main180:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main180
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,523 :: 		draw_box(playerTwo, ERASE);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main181:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main181
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,524 :: 		draw_box(ball, ERASE);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_box_s+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_s+0)
	MOVWF       FSR1L+1 
	MOVLW       _ball+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0L+1 
L_main182:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main182
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;pong.c,526 :: 		}
	GOTO        L_main138
L_main139:
;pong.c,529 :: 		break;
	GOTO        L_main105
;pong.c,531 :: 		default:
L_main183:
;pong.c,532 :: 		break;
	GOTO        L_main105
;pong.c,533 :: 		}
L_main104:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main106
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main107
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main108
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main136
	GOTO        L_main183
L_main105:
;pong.c,534 :: 		}
	GOTO        L_main102
;pong.c,535 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
