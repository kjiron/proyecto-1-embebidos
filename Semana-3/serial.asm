
serial_Serial_Init:

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
L_serial_Serial_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_serial_Serial_Init0
	DECFSZ      R12, 1, 1
	BRA         L_serial_Serial_Init0
	DECFSZ      R11, 1, 1
	BRA         L_serial_Serial_Init0
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
; end of serial_Serial_Init

_Serial_clear:

;serial.c,9 :: 		void Serial_clear()
;serial.c,11 :: 		uartPos_w = 0;
	CLRF        serial_uartPos_w+0 
;serial.c,12 :: 		uartPos_r = 0;
	CLRF        serial_uartPos_r+0 
;serial.c,13 :: 		}
L_end_Serial_clear:
	RETURN      0
; end of _Serial_clear

_Serial_available:

;serial.c,15 :: 		size_t Serial_available()
;serial.c,17 :: 		uint8 n = uartPos_w - uartPos_r;
	MOVF        serial_uartPos_r+0, 0 
	SUBWF       serial_uartPos_w+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
;serial.c,18 :: 		return n;
	MOVLW       0
	MOVWF       R1 
;serial.c,19 :: 		}
L_end_Serial_available:
	RETURN      0
; end of _Serial_available

_Serial_Write:

;serial.c,21 :: 		size_t Serial_Write(void *buf, size_t n)
;serial.c,24 :: 		uint8 *p = (uint8 *)buf;
	MOVF        FARG_Serial_Write_buf+0, 0 
	MOVWF       Serial_Write_p_L0+0 
	MOVF        FARG_Serial_Write_buf+1, 0 
	MOVWF       Serial_Write_p_L0+1 
;serial.c,26 :: 		for (i = 0; i < n;)
	CLRF        Serial_Write_i_L0+0 
	CLRF        Serial_Write_i_L0+1 
L_Serial_Write1:
	MOVF        FARG_Serial_Write_n+1, 0 
	SUBWF       Serial_Write_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Serial_Write15
	MOVF        FARG_Serial_Write_n+0, 0 
	SUBWF       Serial_Write_i_L0+0, 0 
L__Serial_Write15:
	BTFSC       STATUS+0, 0 
	GOTO        L_Serial_Write2
;serial.c,28 :: 		if (UART1_Tx_Idle() == 1)
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Serial_Write4
;serial.c,30 :: 		c = p[i];
	MOVF        Serial_Write_i_L0+0, 0 
	ADDWF       Serial_Write_p_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVF        Serial_Write_i_L0+1, 0 
	ADDWFC      Serial_Write_p_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
;serial.c,31 :: 		UART1_Write(c);
	CALL        _UART1_Write+0, 0
;serial.c,32 :: 		i++;
	INFSNZ      Serial_Write_i_L0+0, 1 
	INCF        Serial_Write_i_L0+1, 1 
;serial.c,33 :: 		}
L_Serial_Write4:
;serial.c,34 :: 		}
	GOTO        L_Serial_Write1
L_Serial_Write2:
;serial.c,35 :: 		return n;
	MOVF        FARG_Serial_Write_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_Serial_Write_n+1, 0 
	MOVWF       R1 
;serial.c,36 :: 		}
L_end_Serial_Write:
	RETURN      0
; end of _Serial_Write

_Serial_Read:

;serial.c,38 :: 		size_t Serial_Read(void *buf, size_t n)
;serial.c,41 :: 		memcpy(buf, uartRx + uartPos_r, n);
	MOVF        FARG_Serial_Read_buf+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVF        FARG_Serial_Read_buf+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       serial_uartRx+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(serial_uartRx+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVF        serial_uartPos_r+0, 0 
	ADDWF       FARG_memcpy_s1+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_memcpy_s1+1, 1 
	MOVF        FARG_Serial_Read_n+0, 0 
	MOVWF       FARG_memcpy_n+0 
	MOVF        FARG_Serial_Read_n+1, 0 
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;serial.c,42 :: 		uartPos_r += n;
	MOVF        FARG_Serial_Read_n+0, 0 
	ADDWF       serial_uartPos_r+0, 1 
;serial.c,43 :: 		return n;
	MOVF        FARG_Serial_Read_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_Serial_Read_n+1, 0 
	MOVWF       R1 
;serial.c,44 :: 		}
L_end_Serial_Read:
	RETURN      0
; end of _Serial_Read

_interrupt:

;serial.c,46 :: 		void interrupt(void)
;serial.c,49 :: 		uint8 n = uartPos_w - uartPos_r;
	MOVF        serial_uartPos_r+0, 0 
	SUBWF       serial_uartPos_w+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       interrupt_n_L0+0 
;serial.c,50 :: 		if (uartPos_w > 0 && n == 0)
	MOVF        serial_uartPos_w+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt7
	MOVF        interrupt_n_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
L__interrupt10:
;serial.c,52 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;serial.c,53 :: 		}
L_interrupt7:
;serial.c,56 :: 		uartRx[uartPos_w] = UART1_Read(); // put a byte to a buffer
	MOVLW       serial_uartRx+0
	MOVWF       FLOC__interrupt+0 
	MOVLW       hi_addr(serial_uartRx+0)
	MOVWF       FLOC__interrupt+1 
	MOVF        serial_uartPos_w+0, 0 
	ADDWF       FLOC__interrupt+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__interrupt+1, 1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__interrupt+0, FSR1L+0
	MOVFF       FLOC__interrupt+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;serial.c,57 :: 		uartPos_w++;
	INCF        serial_uartPos_w+0, 1 
;serial.c,58 :: 		if (uartPos_w == 64)
	MOVF        serial_uartPos_w+0, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;serial.c,60 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;serial.c,61 :: 		} // reset pointer.
L_interrupt8:
;serial.c,62 :: 		}
L_end_interrupt:
L__interrupt18:
	RETFIE      1
; end of _interrupt

_Serial_writeByte:

;serial.c,64 :: 		void Serial_writeByte(uint8 b) {
;serial.c,65 :: 		Serial_write(&b, 1);
	MOVLW       FARG_Serial_writeByte_b+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(FARG_Serial_writeByte_b+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;serial.c,66 :: 		}
L_end_Serial_writeByte:
	RETURN      0
; end of _Serial_writeByte

_getMark:

;serial.c,69 :: 		uint8 getMark(){
;serial.c,70 :: 		uint8 mark = 0;
	CLRF        getMark_mark_L0+0 
;serial.c,71 :: 		if (Serial_available() >= 3)
	CALL        _Serial_available+0, 0
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getMark21
	MOVLW       3
	SUBWF       R0, 0 
L__getMark21:
	BTFSS       STATUS+0, 0 
	GOTO        L_getMark9
;serial.c,73 :: 		Serial_Read(&mark, 1);
	MOVLW       getMark_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(getMark_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;serial.c,74 :: 		}
L_getMark9:
;serial.c,75 :: 		return mark;
	MOVF        getMark_mark_L0+0, 0 
	MOVWF       R0 
;serial.c,77 :: 		}
L_end_getMark:
	RETURN      0
; end of _getMark
