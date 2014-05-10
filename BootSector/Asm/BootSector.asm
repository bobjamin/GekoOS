[ORG 0X7C00]                        ;Code will be placed at 0x7C00
[BITS 16]                           ;We must tell NASM to assemble 16-bit code
Start:               
					MOV AH, 0XA    ;Print Character Function
					MOV AL, 'X'    ;Print the X Character
					MOV BH, 0      ;The page number
					MOV CX, 5      ;Print X 5 times
					INT 0X10       ;Make the magic happen
					CLI            ;Disables interrupt we don't want them
                    HLT            ;Halts the processor
TIMES 510-($-$$) DB 0              ;Store 0s up to byte 510
DW 0XAA55                          ;The special duo