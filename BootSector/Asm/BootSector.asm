[ORG 0X7C00]
[BITS 16]
Start:
    MOV AL, 'X'
    CALL PrintChar16
    CLI               ;Clear interrupts
    HLT               ;Halt Processor
%include "Print16.i"  ;Include our print file
TIMES 510-($-$$) DB 0 
DW 0XAA55