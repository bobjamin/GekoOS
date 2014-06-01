[ORG 0X9000]
[BITS 16]
jmp Start
%include "Print16.i"
%include "Screen16.i"
%include "GDT.i"

Start:
		MOV CH, 0X0F		;Set Color to White on Black
		MOV BH, 0X0 		;Page 0
		CALL ClearScreen	;Clear Screen
		
		CLI
		XOR AX, AX
		MOV DS, AX
		MOV ES, AX
		MOV AX, 0X9000
		MOV SS, AX
		MOV SP, 0XFFFF
		STI
		CALL InstallGDT

		CLI
		MOV EAX, CR0
		OR EAX, 1
		MOV CR0, EAX
		
		JMP 0X8:Stage3


		CLI
		HLT


[BITS 32]
Stage3:
		MOV AX, 0X10
		MOV DS, AX
		MOV SS, AX
		MOV ES, AX
		MOV ESP, 0X9000

		MOV BYTE [0xb8000], 'C'

STOP:	
		CLI
		HLT