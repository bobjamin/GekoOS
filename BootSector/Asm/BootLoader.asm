[ORG 0X9000]
[BITS 16]
jmp Start

%include "Floppy.i"
%include "Screen16.i"
%include "GDT.i"

Start:
		MOV CH, 0X0F		;Set Color to White on Black
		MOV BH, 0X0 		;Page 0
		CALL ClearScreen	;Clear Screen
		

		MOV BX, 0X1000 		;Set ES:BX to 0x10000 (1Mb)
		MOV ES, BX
		XOR BX, BX
		MOV AX, 0X5 		;Read from sector 5 (512 BootSector 2Kb BootLoader)
		MOV CX, 0X05		;Read 5 Sectors for now
		CALL ReadSectors	

		CALL InstallGDT

		CLI
		MOV EAX, CR0
		OR EAX, 1
		MOV CR0, EAX
		
		;Make a jump using label to Stage3
		;So we can move into 32 bits and 
		;Call to a higher location in memory (1Mb)
		JMP 0X8:Stage3


		CLI
		HLT

[BITS 32]
Stage3:
		CALL 0X8: 0x10000 	;Call our Kernel

TIMES 0X800-($-$$) DB 0