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
	LDR R0,=SRC	
	LDR R1,=DST
	LDR R2,[R0]
	MOV R4,#0xF;to extract last digit
	MOV R5,#8;counter
UP AND R3, R2, R4
	ROR R2, R2, #4
	STR R3, [R1],#4;store to memory
	SUBS R5,#1
	BNE UP
STOP B STOP
SRC DCD 0x12345678
	AREA mydata, DATA, READWRITE
DST DCD 0,0,0,0,0,0,0,0
	END