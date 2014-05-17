[ORG 0X7C00]
[BITS 16]
Start:
	
    CLI                 ;Clear interrupts
    HLT                 ;Halt Processor

;Read DH sectors to ES:BX from Drive DL
ReadSectors:
	PUSH DX
	MOV AH, 0X2			;Read Disk Function
	MOV CH, 0 			;Cylinder 0
	MOV CL, 0X2			;2nd Sector (512 bytes)
	MOV AL, DH			;No. Sectors
	MOV DH, 0 			;Head 0
	INT 0X13			;Read
	JC .DiskError		;Error if Carry Flag set
	POP DX
	CMP AL, DH			;Compare No. actually copied
	JNE .DiskError
RET
.DiskError:
	MOV SI, DISKERRMSG
	CALL  PrintString16
	CLI
	HLT

%include "Print16.i"  ;Include our print file

WELCOMEMSG	DB	"--- Welcome to Geko (16-bit real mode) ---", 0
DISKERRMSG	DB	"Disk Read Error!",0
DISKSCCMSG 	DB	"Disk Read Success!", 0
BOOTDRIVE	DB	0

TIMES 510-($-$$) DB 0 
DW 0XAA55

;Code not loaded by BIOS after the 512 byte mark
MSG 		DB "BLAH BLAH BLAH", 0