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
	LDR R0,=ARR
	MOV R8,#3 ; Number of passes through the array
UP1 
	MOV R7,R8 ; Number of comparisons per pass
	MOV R1,R0 ; address of arr 
UP2 
	LDR R2,[R0]; pick element
	LDR R3,[R1,#4]!; take next number
	CMP R2, R3 ; compare selected and next
	BLS SKIP ; Branch if R2<R3
	STR R2,[R1] ;swap
	STR R3,[R0]
SKIP 
	SUB R7,#1 ; decrement no. of comparisons
	TEQ R7,#0 ; check if no. of passes completed
	BNE UP2

	ADD R0,#4 ; next element
	SUB R8, #1 ; decrement no.of passes
	TEQ R8,#0
	BNE UP1
	
STOP B STOP
	AREA mydata, DATA, READWRITE
ARR DCD 0,0,0,0 
	END