[BITS 16]
LBACHS:
		XOR DX, DX
		DIV WORD [bpbSectorsPerTrack]
;Ax contains sector / sectors per track
		INC DL
		MOV BYTE [absoluteSector], DL
		XOR DX, DX
		DIV WORD [bpbHeadsPerCylinder]
		MOV BYTE [absoluteHead], DL
		MOV BYTE [absoluteTrack], AL
RET
;AX = Starting sector
;CX = No. sectors
;ES:BX = Memory location
ReadSectors:
		MOV DI, 0X5
.Loop:
		PUSH AX
		PUSH BX
		PUSH CX
		CALL LBACHS
		MOV AH, 0X2
		MOV AL, 0x1
		MOV CH, BYTE [absoluteTrack]
		MOV CL, BYTE [absoluteSector]
		MOV DH, BYTE [absoluteHead]
		MOV DL, BYTE [bsDriveNumber]
		INT 0X13
		JNC .End
		XOR AX, AX
		INT 0X13
		DEC DI
		POP CX
		POP BX
		POP AX
		JNZ .Loop
		INT 0X18
.End:
		POP CX
		POP BX
		POP AX
		ADD BX, WORD [bpbBytesPerSector]
		INC AX
		LOOP ReadSectors
RET

absoluteSector:			DB 0
absoluteHead:			DB 0
absoluteTrack:			DB 0
bpbBytesPerSector:  	DW 512
bpbSectorsPerCluster: 	DB 1
bpbReservedSectors: 	DW 1
bpbNumberOfFATs: 		DB 2
bpbRootEntries: 		DW 224
bpbTotalSectors: 		DW 2880
bpbMedia: 				DB 0xf0  ;; 0xF1
bpbSectorsPerFAT: 		DW 9
bpbSectorsPerTrack: 	DW 18
bpbHeadsPerCylinder: 	DW 2
bpbHiddenSectors: 		DD 0
bpbTotalSectorsBig:     DD 0
bsDriveNumber: 	        DB 0