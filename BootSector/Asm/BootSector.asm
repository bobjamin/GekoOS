[ORG 0X7C00]
[BITS 16]
Start:
	XOR AX, AX			;Set segments to 0 offset
	MOV DS, AX
	MOV ES, AX
    MOV SI, WELCOMEMSG  ;Print welcome message
    CALL PrintString16
    CLI                 ;Clear interrupts
    HLT                 ;Halt Processor

%include "Print16.i"  ;Include our print file

WELCOMEMSG	DB	"--- Welcome to Geko (16-bit real mode) ---", 0

TIMES 510-($-$$) DB 0 
DW 0XAA55