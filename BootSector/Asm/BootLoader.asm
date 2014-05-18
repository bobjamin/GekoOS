[ORG 0X9000]
[BITS 16]

Start:
		MOV CH, 0X0F		;Set Color to White on Black
		MOV BH, 0X0 		;Page 0
		CALL ClearScreen	;Clear Screen
		MOV SI, MSG			;Print HELLO
		CALL PrintString16
		
		CLI
		HLT

%include "Print16.i"
%include "Screen16.i"

MSG		DB	"HELLO",0