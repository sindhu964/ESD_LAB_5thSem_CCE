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
	LDR R2,=DST
	MOV R7,#2

UP LDR R3,[R0],#4
	LDR R4,[R1],#4
	ADDS R5,R3,R4
	ADD R5,R6
	ADC R6,#0
	SUBS R7,#01
	STR R5,[R2],#4
	BNE UP
	
STOP B STOP
SRC1 DCD 0x12345678,0x12345678
SRC2 DCD 0xFFFFFFFF,0xFFFFFFFF
	AREA mydata, DATA, READWRITE
DST DCD 0,0,0
	END