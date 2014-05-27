
[BITS 16]
;Print Hex Character
PrintHexChar16:	
				PUSH AX
				SHR AL, 4
				CALL PrintHex4Bit16
				POP AX
				SHL AL, 4
				SHR AL, 4
				CALL PrintHex4Bit16
RET

;Print 4 bit Hex value stored in AL
PrintHex4Bit16:	CMP AL, 0XA
				JL .Print
				ADD AL, 0X07
	.Print:		ADD AL, 0X30
				CALL PrintChar16
RET