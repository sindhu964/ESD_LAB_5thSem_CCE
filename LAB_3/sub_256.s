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
	LDR R0,=SRC1
	LDR R1,=SRC2
	LDR R3,=DST
	MOV R2,#8
	LDR R7,=0x20000000
	MSR xPSR,R7
UP LDR R4,[R0],#4
	LDR R5,[R1],#4
	SBCS R6,R4,R5
	STR R6,[R3],#4
	SUB R2,#1
	TEQ R2, #0; Test equality
	BNE UP
STOP B STOP
SRC1 DCD 0x12345677, 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0x12345678
SRC2 DCD 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0x12345678, 0xABCDEF12
	AREA mydata, DATA, READWRITE 
DST DCD 0,0,0,0,0,0,0,0
	END