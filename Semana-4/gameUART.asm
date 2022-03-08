
gameUART_Serial_Init:

;serial.h,23 :: 		static void Serial_Init()
;serial.h,25 :: 		ADCON1 = 0x0F; // turn analog off
	MOVLW       15
	MOVWF       ADCON1+0 
;serial.h,27 :: 		UART1_Init(9600); // initialize hardware UART @baudrate=115200, the same setting for the sensor
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;serial.h,28 :: 		Delay_ms(100);    // let them stablize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_gameUART_Serial_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_gameUART_Serial_Init0
	DECFSZ      R12, 1, 1
	BRA         L_gameUART_Serial_Init0
	DECFSZ      R11, 1, 1
	BRA         L_gameUART_Serial_Init0
	NOP
;serial.h,30 :: 		PIE1.RCIE = 1; // enable interrupt source
	BSF         PIE1+0, 5 
;serial.h,31 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;serial.h,32 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;serial.h,33 :: 		}
L_end_Serial_Init:
	RETURN      0
; end of gameUART_Serial_Init

gameUART_readKeys:

;keys.h,12 :: 		static inline Keys readKeys()
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;keys.h,16 :: 		tmp.right = PORTA.B0 == 1;
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
;keys.h,17 :: 		tmp.left  = PORTA.B1 == 1;
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
;keys.h,18 :: 		tmp.up    = PORTA.B2 == 1;
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
;keys.h,19 :: 		tmp.down  = PORTA.B3 == 1;
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
;keys.h,20 :: 		tmp.enter = PORTA.B4 == 1;
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
;keys.h,21 :: 		return tmp;
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
L_gameUART_readKeys1:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_gameUART_readKeys1
;keys.h,22 :: 		}
L_end_readKeys:
	RETURN      0
; end of gameUART_readKeys

_checkWallCollision:

;hit.h,17 :: 		void checkWallCollision(Generic *ball_tmp, uint8 velocity)
;hit.h,19 :: 		if (ball_tmp->posY >= 61){
	MOVLW       1
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       61
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkWallCollision2
;hit.h,20 :: 		ball_tmp->dy = -velocity;
	MOVLW       3
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_checkWallCollision_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,21 :: 		}
L_checkWallCollision2:
;hit.h,22 :: 		if (ball_tmp->posY <= 7){
	MOVLW       1
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkWallCollision3
;hit.h,23 :: 		ball_tmp->dy = velocity;
	MOVLW       3
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_checkWallCollision_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,24 :: 		}
L_checkWallCollision3:
;hit.h,25 :: 		if (ball_tmp->posX >= 125){
	MOVFF       FARG_checkWallCollision_ball_tmp+0, FSR0L+0
	MOVFF       FARG_checkWallCollision_ball_tmp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       125
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkWallCollision4
;hit.h,26 :: 		ball_tmp->dx = -velocity;
	MOVLW       2
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_checkWallCollision_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,27 :: 		}
L_checkWallCollision4:
;hit.h,28 :: 		if (ball_tmp->posX <= 0){
	MOVFF       FARG_checkWallCollision_ball_tmp+0, FSR0L+0
	MOVFF       FARG_checkWallCollision_ball_tmp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkWallCollision5
;hit.h,29 :: 		ball_tmp->dx = velocity;
	MOVLW       2
	ADDWF       FARG_checkWallCollision_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkWallCollision_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_checkWallCollision_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,30 :: 		}
L_checkWallCollision5:
;hit.h,31 :: 		}
L_end_checkWallCollision:
	RETURN      0
; end of _checkWallCollision

_changeDirectionMode1:

;hit.h,33 :: 		void changeDirectionMode1(uint8 randNum, Generic *ball, uint8 velocity){
;hit.h,34 :: 		if (randNum == 0){
	MOVF        FARG_changeDirectionMode1_randNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_changeDirectionMode16
;hit.h,35 :: 		ball->dx = -velocity;
	MOVLW       2
	ADDWF       FARG_changeDirectionMode1_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode1_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode1_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,36 :: 		ball->dy = velocity;
	MOVLW       3
	ADDWF       FARG_changeDirectionMode1_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode1_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode1_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,37 :: 		}
L_changeDirectionMode16:
;hit.h,38 :: 		if (randNum == 1){
	MOVF        FARG_changeDirectionMode1_randNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_changeDirectionMode17
;hit.h,39 :: 		ball->dx = -velocity;
	MOVLW       2
	ADDWF       FARG_changeDirectionMode1_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode1_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode1_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,40 :: 		ball->dy = -velocity;
	MOVLW       3
	ADDWF       FARG_changeDirectionMode1_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode1_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode1_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,41 :: 		}
L_changeDirectionMode17:
;hit.h,42 :: 		if (randNum == 2)
	MOVF        FARG_changeDirectionMode1_randNum+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_changeDirectionMode18
;hit.h,44 :: 		ball->dx = -velocity;
	MOVLW       2
	ADDWF       FARG_changeDirectionMode1_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode1_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode1_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,45 :: 		ball->dy = 0;
	MOVLW       3
	ADDWF       FARG_changeDirectionMode1_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode1_ball+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;hit.h,46 :: 		}
L_changeDirectionMode18:
;hit.h,48 :: 		}
L_end_changeDirectionMode1:
	RETURN      0
; end of _changeDirectionMode1

_changeDirectionMode2:

;hit.h,50 :: 		void changeDirectionMode2(uint8 randNum, Generic *ball, uint8 velocity){
;hit.h,51 :: 		if (randNum == 0){
	MOVF        FARG_changeDirectionMode2_randNum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_changeDirectionMode29
;hit.h,52 :: 		ball->dx = velocity;
	MOVLW       2
	ADDWF       FARG_changeDirectionMode2_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode2_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode2_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,53 :: 		ball->dy = velocity;
	MOVLW       3
	ADDWF       FARG_changeDirectionMode2_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode2_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode2_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,54 :: 		}
L_changeDirectionMode29:
;hit.h,55 :: 		if (randNum == 1){
	MOVF        FARG_changeDirectionMode2_randNum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_changeDirectionMode210
;hit.h,56 :: 		ball->dx = velocity;
	MOVLW       2
	ADDWF       FARG_changeDirectionMode2_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode2_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode2_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,57 :: 		ball->dy = -velocity;
	MOVLW       3
	ADDWF       FARG_changeDirectionMode2_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode2_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode2_velocity+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,58 :: 		}
L_changeDirectionMode210:
;hit.h,59 :: 		if (randNum == 2){
	MOVF        FARG_changeDirectionMode2_randNum+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_changeDirectionMode211
;hit.h,60 :: 		ball->dx = velocity;
	MOVLW       2
	ADDWF       FARG_changeDirectionMode2_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode2_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode2_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,61 :: 		ball->dy = velocity;
	MOVLW       3
	ADDWF       FARG_changeDirectionMode2_ball+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_changeDirectionMode2_ball+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_changeDirectionMode2_velocity+0, 0 
	MOVWF       POSTINC1+0 
;hit.h,62 :: 		}
L_changeDirectionMode211:
;hit.h,64 :: 		}
L_end_changeDirectionMode2:
	RETURN      0
; end of _changeDirectionMode2

_checkVerticalWall:

;hit.h,67 :: 		uint8 checkVerticalWall(Generic *ball_tmp){
;hit.h,68 :: 		if (ball_tmp->posX <= 0){
	MOVFF       FARG_checkVerticalWall_ball_tmp+0, FSR0L+0
	MOVFF       FARG_checkVerticalWall_ball_tmp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkVerticalWall12
;hit.h,69 :: 		ball_tmp->posX = 64;
	MOVFF       FARG_checkVerticalWall_ball_tmp+0, FSR1L+0
	MOVFF       FARG_checkVerticalWall_ball_tmp+1, FSR1H+0
	MOVLW       64
	MOVWF       POSTINC1+0 
;hit.h,70 :: 		ball_tmp->posY = 32;
	MOVLW       1
	ADDWF       FARG_checkVerticalWall_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkVerticalWall_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;hit.h,71 :: 		ball_tmp->dx = 1;
	MOVLW       2
	ADDWF       FARG_checkVerticalWall_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkVerticalWall_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;hit.h,72 :: 		ball_tmp->dy = -1;
	MOVLW       3
	ADDWF       FARG_checkVerticalWall_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkVerticalWall_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;hit.h,73 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_checkVerticalWall
;hit.h,74 :: 		}
L_checkVerticalWall12:
;hit.h,75 :: 		if (ball_tmp->posX >= 125){
	MOVFF       FARG_checkVerticalWall_ball_tmp+0, FSR0L+0
	MOVFF       FARG_checkVerticalWall_ball_tmp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       125
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_checkVerticalWall13
;hit.h,76 :: 		ball_tmp->posX = 64;
	MOVFF       FARG_checkVerticalWall_ball_tmp+0, FSR1L+0
	MOVFF       FARG_checkVerticalWall_ball_tmp+1, FSR1H+0
	MOVLW       64
	MOVWF       POSTINC1+0 
;hit.h,77 :: 		ball_tmp->posY = 32;
	MOVLW       1
	ADDWF       FARG_checkVerticalWall_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkVerticalWall_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;hit.h,78 :: 		ball_tmp->dx = -1;
	MOVLW       2
	ADDWF       FARG_checkVerticalWall_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkVerticalWall_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;hit.h,79 :: 		ball_tmp->dy = 1;
	MOVLW       3
	ADDWF       FARG_checkVerticalWall_ball_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_checkVerticalWall_ball_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;hit.h,80 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_checkVerticalWall
;hit.h,81 :: 		}
L_checkVerticalWall13:
;hit.h,83 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
;hit.h,84 :: 		}
L_end_checkVerticalWall:
	RETURN      0
; end of _checkVerticalWall

_movePlayer:

;hit.h,98 :: 		Objeto movePlayer(Objeto player)
	MOVF        R0, 0 
	MOVWF       _movePlayer_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _movePlayer_su_addr+1 
;hit.h,101 :: 		key = readKeys();
	MOVLW       FLOC__movePlayer+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__movePlayer+0)
	MOVWF       R1 
	CALL        gameUART_readKeys+0, 0
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
L_movePlayer14:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_movePlayer14
;hit.h,103 :: 		if (key.down){
	MOVF        movePlayer_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_movePlayer15
;hit.h,104 :: 		player.y = player.y + player.dy;
	MOVF        FARG_movePlayer_player+5, 0 
	ADDWF       FARG_movePlayer_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_movePlayer_player+1 
;hit.h,105 :: 		if (player.y >= 49){
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       49
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_movePlayer16
;hit.h,106 :: 		player.y = 49;
	MOVLW       49
	MOVWF       FARG_movePlayer_player+1 
;hit.h,107 :: 		}
L_movePlayer16:
;hit.h,108 :: 		}
L_movePlayer15:
;hit.h,110 :: 		if (key.up){
	MOVF        movePlayer_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_movePlayer17
;hit.h,111 :: 		player.y = player.y - player.dy;
	MOVF        FARG_movePlayer_player+5, 0 
	SUBWF       FARG_movePlayer_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_movePlayer_player+1 
;hit.h,112 :: 		if (player.y <= 7){
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_movePlayer18
;hit.h,113 :: 		player.y = 7;
	MOVLW       7
	MOVWF       FARG_movePlayer_player+1 
;hit.h,114 :: 		}
L_movePlayer18:
;hit.h,115 :: 		}
L_movePlayer17:
;hit.h,117 :: 		return player;
	MOVLW       7
	MOVWF       R0 
	MOVF        _movePlayer_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _movePlayer_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_movePlayer_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_movePlayer_player+0)
	MOVWF       FSR0L+1 
L_movePlayer19:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_movePlayer19
;hit.h,118 :: 		}
L_end_movePlayer:
	RETURN      0
; end of _movePlayer

_drawPaddle:

;drawglcd.h,36 :: 		void drawPaddle(Objeto *rect, uint8 color){
;drawglcd.h,37 :: 		Glcd_Rectangle_Round_Edges_Fill(rect->x, rect->y, rect->x - rect->w, rect->y + rect->h, 0, color);
	MOVFF       FARG_drawPaddle_rect+0, FSR0L+0
	MOVFF       FARG_drawPaddle_rect+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_x_upper_left+0 
	MOVLW       1
	ADDWF       FARG_drawPaddle_rect+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_drawPaddle_rect+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_y_upper_left+0 
	MOVLW       2
	ADDWF       FARG_drawPaddle_rect+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_drawPaddle_rect+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	SUBWF       R1, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_x_bottom_right+0 
	MOVLW       3
	ADDWF       FARG_drawPaddle_rect+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_drawPaddle_rect+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	ADDWF       R0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_y_bottom_right+0 
	CLRF        FARG_Glcd_Rectangle_Round_Edges_Fill_round_radius+0 
	MOVF        FARG_drawPaddle_color+0, 0 
	MOVWF       FARG_Glcd_Rectangle_Round_Edges_Fill_color+0 
	CALL        _Glcd_Rectangle_Round_Edges_Fill+0, 0
;drawglcd.h,38 :: 		}
L_end_drawPaddle:
	RETURN      0
; end of _drawPaddle

_drawBall:

;drawglcd.h,41 :: 		void drawBall(Generic *rect){
;drawglcd.h,43 :: 		Glcd_Box(rect->posX, rect->posY, rect->posX + 2, rect->posY + 2, 1);
	MOVFF       FARG_drawBall_rect+0, FSR0L+0
	MOVFF       FARG_drawBall_rect+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       1
	ADDWF       FARG_drawBall_rect+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_drawBall_rect+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       2
	ADDWF       R1, 0 
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;drawglcd.h,44 :: 		}
L_end_drawBall:
	RETURN      0
; end of _drawBall

_drawNet:

;drawglcd.h,46 :: 		void drawNet()
;drawglcd.h,50 :: 		for ( i = 0; i < 14; i++)
	CLRF        drawNet_i_L0+0 
L_drawNet20:
	MOVLW       14
	SUBWF       drawNet_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_drawNet21
;drawglcd.h,52 :: 		GLcd_V_Line(8 + i*4, 8 + i*4 + 1, 0 + 126/2, 1);
	MOVF        drawNet_i_L0+0, 0 
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
;drawglcd.h,50 :: 		for ( i = 0; i < 14; i++)
	INCF        drawNet_i_L0+0, 1 
;drawglcd.h,53 :: 		}
	GOTO        L_drawNet20
L_drawNet21:
;drawglcd.h,55 :: 		}
L_end_drawNet:
	RETURN      0
; end of _drawNet

_drawNetAndWall:

;drawglcd.h,58 :: 		void drawNetAndWall(){
;drawglcd.h,59 :: 		Glcd_V_Line(10, 17, 62, 1);
	MOVLW       10
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       17
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       62
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,60 :: 		Glcd_V_Line(24, 31, 62, 1);
	MOVLW       24
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       31
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       62
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,61 :: 		Glcd_V_Line(38, 45, 62, 1);
	MOVLW       38
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       45
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       62
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,62 :: 		Glcd_V_Line(51, 59, 62, 1);
	MOVLW       51
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       59
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       62
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,63 :: 		Delay_ms(30);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_drawNetAndWall23:
	DECFSZ      R13, 1, 1
	BRA         L_drawNetAndWall23
	DECFSZ      R12, 1, 1
	BRA         L_drawNetAndWall23
;drawglcd.h,65 :: 		}
L_end_drawNetAndWall:
	RETURN      0
; end of _drawNetAndWall

_staticUI:

;drawglcd.h,67 :: 		void staticUI()
;drawglcd.h,71 :: 		GLcd_V_Line(7, 63, 0, 1);
	MOVLW       7
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       63
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	CLRF        FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,72 :: 		GLcd_V_Line(7, 63, 127, 1);
	MOVLW       7
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       63
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVLW       127
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;drawglcd.h,73 :: 		GLcd_H_Line(0, 127, 7, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       7
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;drawglcd.h,74 :: 		GLcd_H_Line(0, 127, 63, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       63
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;drawglcd.h,77 :: 		}
L_end_staticUI:
	RETURN      0
; end of _staticUI

_main:

;gameUART.c,10 :: 		void main()
;gameUART.c,16 :: 		Objeto paddle[2] = {0, 0};
	CLRF        main_paddle_L0+0 
	CLRF        main_paddle_L0+1 
	CLRF        main_paddle_L0+2 
	CLRF        main_paddle_L0+3 
	CLRF        main_paddle_L0+4 
	CLRF        main_paddle_L0+5 
	CLRF        main_paddle_L0+6 
	CLRF        main_paddle_L0+7 
	CLRF        main_paddle_L0+8 
	CLRF        main_paddle_L0+9 
	CLRF        main_paddle_L0+10 
	CLRF        main_paddle_L0+11 
	CLRF        main_paddle_L0+12 
	CLRF        main_paddle_L0+13 
;gameUART.c,18 :: 		drawNet();
	CALL        _drawNet+0, 0
;gameUART.c,19 :: 		staticUI();
	CALL        _staticUI+0, 0
;gameUART.c,20 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;gameUART.c,22 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;gameUART.c,23 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;gameUART.c,26 :: 		paddle[0].x = 5;
	MOVLW       5
	MOVWF       main_paddle_L0+0 
;gameUART.c,27 :: 		paddle[0].y = 25;
	MOVLW       25
	MOVWF       main_paddle_L0+1 
;gameUART.c,28 :: 		paddle[0].dx = 1;
	MOVLW       1
	MOVWF       main_paddle_L0+4 
;gameUART.c,29 :: 		paddle[0].dy = 1;
	MOVLW       1
	MOVWF       main_paddle_L0+5 
;gameUART.c,30 :: 		paddle[0].w = 2;
	MOVLW       2
	MOVWF       main_paddle_L0+2 
;gameUART.c,31 :: 		paddle[0].h = 14;
	MOVLW       14
	MOVWF       main_paddle_L0+3 
;gameUART.c,32 :: 		paddle[0].score = 0;
	CLRF        main_paddle_L0+6 
;gameUART.c,34 :: 		paddle[1].x = 122;
	MOVLW       122
	MOVWF       main_paddle_L0+7 
;gameUART.c,35 :: 		paddle[1].y = 25;
	MOVLW       25
	MOVWF       main_paddle_L0+8 
;gameUART.c,36 :: 		paddle[1].dx = 1;
	MOVLW       1
	MOVWF       main_paddle_L0+11 
;gameUART.c,37 :: 		paddle[1].dy = 1;
	MOVLW       1
	MOVWF       main_paddle_L0+12 
;gameUART.c,38 :: 		paddle[1].w = 2;
	MOVLW       2
	MOVWF       main_paddle_L0+9 
;gameUART.c,39 :: 		paddle[1].h = 14;
	MOVLW       14
	MOVWF       main_paddle_L0+10 
;gameUART.c,40 :: 		paddle[1].score = 0;
	CLRF        main_paddle_L0+13 
;gameUART.c,43 :: 		while (1)
L_main24:
;gameUART.c,45 :: 		drawPaddle(&paddle[0], 0);
	MOVLW       main_paddle_L0+0
	MOVWF       FARG_drawPaddle_rect+0 
	MOVLW       hi_addr(main_paddle_L0+0)
	MOVWF       FARG_drawPaddle_rect+1 
	CLRF        FARG_drawPaddle_color+0 
	CALL        _drawPaddle+0, 0
;gameUART.c,63 :: 		info = Serial_available();
	CALL        _Serial_available+0, 0
;gameUART.c,65 :: 		if (info > 0)
	MOVF        R0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main26
;gameUART.c,67 :: 		mark = getMark();
	CALL        _getMark+0, 0
;gameUART.c,68 :: 		if (mark == 0xFF)
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
;gameUART.c,70 :: 		Serial_Read(&paddle[0], sizeof(Objeto));
	MOVLW       main_paddle_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(main_paddle_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       7
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;gameUART.c,71 :: 		}
L_main27:
;gameUART.c,73 :: 		}
L_main26:
;gameUART.c,80 :: 		drawPaddle(&paddle[0], 1);
	MOVLW       main_paddle_L0+0
	MOVWF       FARG_drawPaddle_rect+0 
	MOVLW       hi_addr(main_paddle_L0+0)
	MOVWF       FARG_drawPaddle_rect+1 
	MOVLW       1
	MOVWF       FARG_drawPaddle_color+0 
	CALL        _drawPaddle+0, 0
;gameUART.c,83 :: 		Delay_ms(30);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_main28:
	DECFSZ      R13, 1, 1
	BRA         L_main28
	DECFSZ      R12, 1, 1
	BRA         L_main28
;gameUART.c,84 :: 		}
	GOTO        L_main24
;gameUART.c,86 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
