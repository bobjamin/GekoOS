[ORG 0X7C00]
[BITS 16]
Start:
	
    CLI                 ;Clear interrupts
    HLT                 ;Halt Processor

%include "Print16.i"  ;Include our print file

WELCOMEMSG	DB	"--- Welcome to Geko (16-bit real mode) ---", 0

TIMES 510-($-$$) DB 0 
DW 0XAA55