[ORG 0X9000]
[BITS 16]

Start:
		MOV SI, MSG
		CALL PrintString16
		CLI
		HLT

%include "Print16.i"

MSG		DB	"HELLO",0