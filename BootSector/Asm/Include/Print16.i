;16-Bit print character method
;Prints character in AL at the current cursor position
PrintChar16:
    PUSH BX           ;Save the current state
    PUSH CX
    MOV AH, 0XA       ;Print function
    XOR BX, BX        ;Make BX 0
    MOV CX, 1         ;Repeat once
    INT 0X10          ;Go!
    POP CX            ;Restore state
    POP BX
RET