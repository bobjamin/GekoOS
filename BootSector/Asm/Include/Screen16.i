[BITS 16]
;Get current video mode in AL
GetVideoMode:
		MOV AH, 0X0F
		INT 0X10
RET

;Get Rows and Columns in BX and AX
GetRowsAndColumns:
	CALL GetVideoMode
	CMP AL, 0X03		;Default is 0x03
	JE	.Default
RET
.Default:
	MOV DL, 80			;Rows
	MOV DH, 25			;Columns
RET

;16-bit Set Cursor method
;X = DH, Y = DL; PAGE = BH
SetCursorPos:
	MOV AH, 0X02
	INT 0X10
RET

;16-bit Clear screen method
;Clears the screen to the color in CH
;and sets cursor to 0 on page in BH
ClearScreen:
	PUSH BX
	CALL GetRowsAndColumns	;Sets DL and DH
	MOV AL, 0X00			;Clear method
	MOV AH, 0X06			;Clear function
	MOV BH, CH				;Set fore and back color
	XOR CX, CX				;Start at 0, 0 
	INT 0X10				;Clear
	POP BX					;Get page
	XOR DX, DX				;Set cursor to 0, 0
	CALL SetCursorPos
RET