	AREA RESET, DATA, READONLY
    EXPORT __Vectors

__Vectors
    DCD 0x10001000      ; Stack Pointer value when Stack is empty
    DCD Reset_Handler   ; Reset vector
    ALIGN

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

Reset_Handler
    ; Initialize pointers to source and destination
    LDR R0, =SRC       ; Load the address of SRC into R0 (number to check)
    LDR R1, =DST       ; Load the address of DST into R1 (result destination)
    
    LDR R2, [R0]       ; Load the value from SRC into R2
    ANDS R2, R2, #1    ; Perform bitwise AND between R2 and 1
                       ; (If the result is 0, the number is even)
    BEQ IS_EVEN        ; If zero flag is set, number is even, branch to IS_EVEN
    
    MOV R3, #0         ; If the number is odd, set R3 to 0
    STR R3, [R1]       ; Store 0 in DST (indicating odd)
    B STOP             ; Branch to STOP
    
IS_EVEN
    MOV R3, #1         ; If the number is even, set R3 to 1
    STR R3, [R1]       ; Store 1 in DST (indicating even)
    
STOP
    B STOP             ; Infinite loop to stop execution

SRC DCD 0x00000004     ; The number to check (change this value to test)
	AREA mydata, DATA, READWRITE
DST DCD 0              ; Destination for the result (1 for even, 0 for odd)

    END