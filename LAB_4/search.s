	AREA RESET, DATA, READONLY
	EXPORT __Vectors

__Vectors
	DCD 0x10001000;Stack Pointervalue WBAC
	DCD Reset_Handler;reset vectors
	ALIGN 
	AREA mycode, CODE, READONLY 
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =array            ; Load the base address of the original array into R0
        LDR R1, =element          ; Load the address of the element to search into R1
        LDR R2, [R1]              ; Load the search element into R2
        MOV R3, #0                ; Clear the flag (0 = not found)
        MOV R4, #0                ; Initialize loop counter for the source array
        MOV R5, #0                ; Initialize loop counter for the destination array

search_loop
        LDR R6, [R0, R4, LSL #2]  ; Load the current element in the array (R4 used as index)
        CMP R6, #0x00             ; Check if the current element is the sentinel (end of array)
        BEQ end_search            ; If sentinel found, break the loop
        STR R6, [R7, R5, LSL #2]  ; Store the current element to DST array
        ADD R5, R5, #1            ; Increment destination loop counter
        EORS R6, R6, R2           ; Compare the current element with the search element
        BEQ set_flag              ; If elements are equal, set the flag
        ADD R4, R4, #1            ; Increment source loop counter (next array element)
        B search_loop             ; Repeat the search loop

set_flag
        MOV R3, #1                ; Set the flag to indicate the element was found
        B search_loop             ; Continue checking the rest of the array

end_search
        LDR R8, =0xFFFFFFFF       ; Load the value 0xFFFFFFFF into R8
        CMP R3, #1                ; Check if the element was found (flag = 1)
        BEQ found                 ; If element was found, go to found

not_found
        STR R2, [R7, R5, LSL #2]  ; Store the search element at the end of the DST array
        ADD R5, R5, #1            ; Move to the next DST array position
        STR R0, [R7, R5, LSL #2]  ; Store sentinel (0x00) at the next DST array position
        B end_program             ; End program

found
        STR R8, [R7, R5, LSL #2]  ; Store 0xFFFFFFFF at the end of the DST array
        ADD R5, R5, #1            ; Move to the next DST array position
        STR R0, [R7, R5, LSL #2]  ; Store sentinel (0x00) at the next DST array position

end_program
        B end_program  
LIST DCD 0x10, 0x05, 0x33, 0x24, 0x56, 0x77, 0x21, 0x04, 0x87, 0x01
ELEMENT DCD 0x05
	AREA mydata, DATA, READWRITE
DST DCD 0,0,0,0,0,0,0,0,0,0
	END