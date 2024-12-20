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
	LDR R0,=NUM
	LDR R1,=DST
	MOV R2,#8
LOOP 
	LDRB R4,[R0],#1
	SUB R5,R4,#0x30
	CMP R5, #0x0A
	BLO DOWN
	SUB R5,#7
DOWN
	
	STRB R5,[R1],#1
	SUBS R2,#1
	BNE LOOP
STOP B STOP
NUM DCD 0x39414543,0x45343331
	AREA mydata, DATA, READWRITE
DST DCD 0
	END
	;fix the storing part it need to be getting stored contiguously