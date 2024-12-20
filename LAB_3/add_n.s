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
	MOV R1,#8
	LDR R2,=DST
	MLA R3,R1,R1,R1
	LSR R3,R3,#1
	STR R3,[R2]
STOP B STOP
	AREA mydata, DATA, READWRITE
DST DCD 0
	END