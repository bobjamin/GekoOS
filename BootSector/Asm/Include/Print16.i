;16-Bit print character method
;Prints character in AL at the current cursor position
PrintChar16:
    PUSH BX           ;Save the current state
    PUSH CX
    MOV AH, 0XE       ;Print function
    XOR BX, BX        ;Make BX 0
    MOV CX, 1         ;Repeat once
    INT 0X10          ;Go!
    POP CX            ;Restore state
    POP BX
RET

;16-Bit print string method
;Prints a null terminated string of characters
; from the memory location pointed at by BX
PrintString16:
	PUSHA			;Save State
	MOV AH, 0XE		;Print function
	XOR BX, BX		;Make BX 0
	MOV CX, 0  		;Repeat characters once
	CLD				;Load String Left to Right		
.Loop:
	LODSB			;Load byte from DS:SI to AL
	OR AL, AL  		;If 0 jump to end
	JZ .End
	INT 0X10		;Print Character
	JMP .Loop
.End:
POPA
RET