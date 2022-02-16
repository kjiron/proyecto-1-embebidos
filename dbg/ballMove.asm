
_main:

;ballMove.c,38 :: 		void main() {
;ballMove.c,46 :: 		Ball.posX = 50;
	MOVLW       50
	MOVWF       _Ball+0 
	MOVLW       0
	MOVWF       _Ball+1 
;ballMove.c,47 :: 		Ball.posY = 40;
	MOVLW       40
	MOVWF       _Ball+2 
	MOVLW       0
	MOVWF       _Ball+3 
;ballMove.c,48 :: 		Ball.velocX = 1;
	MOVLW       1
	MOVWF       _Ball+4 
	MOVLW       0
	MOVWF       _Ball+5 
;ballMove.c,49 :: 		Ball.velocY = 1;
	MOVLW       1
	MOVWF       _Ball+6 
	MOVLW       0
	MOVWF       _Ball+7 
;ballMove.c,51 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;ballMove.c,53 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;ballMove.c,54 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;ballMove.c,58 :: 		while (1)
L_main0:
;ballMove.c,61 :: 		Glcd_Circle(Ball.posX, Ball.posY, 3, 1);
	MOVF        _Ball+0, 0 
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVF        _Ball+1, 0 
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVF        _Ball+2, 0 
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVF        _Ball+3, 0 
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;ballMove.c,66 :: 		}
	GOTO        L_main0
;ballMove.c,69 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
