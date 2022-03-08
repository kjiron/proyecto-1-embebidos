
_main:

;readJoystick.c,21 :: 		void main()
;readJoystick.c,28 :: 		TRISC = 0xFF;
	MOVLW       255
	MOVWF       TRISC+0 
;readJoystick.c,29 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;readJoystick.c,30 :: 		TRISA3_bit = 1;
	BSF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;readJoystick.c,32 :: 		x = 60;
	MOVLW       60
	MOVWF       main_x_L0+0 
	MOVLW       0
	MOVWF       main_x_L0+1 
;readJoystick.c,33 :: 		y = 30;
	MOVLW       30
	MOVWF       main_y_L0+0 
	MOVLW       0
	MOVWF       main_y_L0+1 
;readJoystick.c,34 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;readJoystick.c,35 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;readJoystick.c,36 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;readJoystick.c,38 :: 		Glcd_Dot(x, y, 1);
	MOVF        main_x_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_y_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;readJoystick.c,39 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
;readJoystick.c,40 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;readJoystick.c,41 :: 		while (1)
L_main1:
;readJoystick.c,43 :: 		last_y = y;
	MOVF        main_y_L0+0, 0 
	MOVWF       main_last_y_L0+0 
	MOVF        main_y_L0+1, 0 
	MOVWF       main_last_y_L0+1 
;readJoystick.c,44 :: 		Glcd_Dot(x, y, 1);
	MOVF        main_x_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        main_y_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;readJoystick.c,47 :: 		s = (ADC_Read(1)); // Lee el eje Y del joystick
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_s_L0+0 
	MOVF        R1, 0 
	MOVWF       main_s_L0+1 
	MOVLW       0
	MOVWF       main_s_L0+2 
	MOVWF       main_s_L0+3 
;readJoystick.c,48 :: 		Delay_ms(30);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
;readJoystick.c,49 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;readJoystick.c,51 :: 		if (s >= 800)
	MOVLW       0
	SUBWF       main_s_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVLW       0
	SUBWF       main_s_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVLW       3
	SUBWF       main_s_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVLW       32
	SUBWF       main_s_L0+0, 0 
L__main9:
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;readJoystick.c,53 :: 		y = y - 1;
	MOVLW       1
	SUBWF       main_y_L0+0, 1 
	MOVLW       0
	SUBWFB      main_y_L0+1, 1 
;readJoystick.c,54 :: 		}
	GOTO        L_main5
L_main4:
;readJoystick.c,56 :: 		else if (s <= 200)
	MOVF        main_s_L0+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVF        main_s_L0+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVF        main_s_L0+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVF        main_s_L0+0, 0 
	SUBLW       200
L__main10:
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;readJoystick.c,58 :: 		y = y + 1;
	INFSNZ      main_y_L0+0, 1 
	INCF        main_y_L0+1, 1 
;readJoystick.c,59 :: 		}
	GOTO        L_main7
L_main6:
;readJoystick.c,62 :: 		y = last_y;
	MOVF        main_last_y_L0+0, 0 
	MOVWF       main_y_L0+0 
	MOVF        main_last_y_L0+1, 0 
	MOVWF       main_y_L0+1 
;readJoystick.c,63 :: 		}
L_main7:
L_main5:
;readJoystick.c,69 :: 		}
	GOTO        L_main1
;readJoystick.c,70 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
