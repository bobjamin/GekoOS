[BITS 16]
;Waits for keypress and stores the scan code in AH
;AL contains ASCII character (0 for special)
WaitForKeyPress:				
	XOR AX, AX
	INT 0X16
RET

;Get String Input
;Read characters into PARSEDINPUT until enter pressed
GetInput:
		XOR CX, CX
		MOV BX, PARSEDINPUT
.Loop:
		CALL WaitForKeyPress
		CMP AX, 0X1C0D			;'Enter' Scancode
		JE .EnterPressed
		MOV BYTE [BX], AL		;Append input to PARSEDINPUT
		CALL PrintChar16		;Print character
		INC BX					;Move to next output byte
		ADD CX, 2				;Move to next input word
		CMP CX, 0X20
		JE .EnterPressed
		JMP .Loop			
.EnterPressed:
		MOV BYTE [BX], 0 		;Add a zero to terminate the string
		MOV SI, PARSEDINPUT		;Set SI to string
RET

PARSEDINPUT: TIMES 32 DB 0