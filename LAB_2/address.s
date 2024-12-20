 	AREA RESET, DATA, READONLY
	EXPORT __Vectors

__Vectors
	DCD 0x10001000;Stack Pointervalue WBAC
	DCD Reset_Handler;reset vectors
	ALIGN 
	AREA mycode, CODE, READONLY 
	ENTRY
	EXPORT Reset_Handler
Reset_Handler                         ; Entry point for the program

        ; Immediate Addressing Mode
        MOV      R0, #0x10                ; Load immediate value 0x10 into R0

        ; Register Addressing Mode
        MOV      R1, R0                   ; Copy the value of R0 into R1

        ; Memory Addressing Mode - Direct Addressing (LDR/STR)
        LDR      R2, =SRC         ; Load a memory address into R2
        STR      R1, [R2]                 ; Store the value of R1 at the address in R2
        LDR      R3, [R2]                 ; Load the value from the memory address in R2 into R3

        ; Memory Addressing Mode - Pre-indexed Addressing
        LDR      R4, [R2, #4]             ; Load value from memory address (R2 + 4) into R4
        STR      R3, [R2, #8]             ; Store R3 at memory address (R2 + 8)

        ; Memory Addressing Mode - Post-indexed Addressing
        LDR      R5, [R2], #4            ; Load value from R2 into R5, then add 12 to R2
        STR      R4, [R2], #8            ; Store R4 at address R2, then add 16 to R2

        ; Register Indirect Addressing
        LDR      R7,  [R2, #4]!            ; Load from memory address (R6 + R7) into R8
        STR      R5,  [R2, #8]!         ; Store R8 at memory address (R6 + R7)

        B        END_LOOP                 ; Infinite loop to stop execution

END_LOOP
        B        END_LOOP
SRC DCD 0x12345678, 0xABCDEF12, 0x12345678, 0xABCDEF12
        END
