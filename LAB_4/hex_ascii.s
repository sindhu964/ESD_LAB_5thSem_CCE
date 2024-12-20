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
	LDRB R2,[R0]; extract first byte
	AND R3, R2,#0x0F; extract first hex digit
	CMP R3,#9; compare with 9
	BLS DOWN
	ADD R3,#7; add 7 if less than 9
DOWN ADD R3,#0x30
	STRB R3,[R1]; store first ASCII digit at destination
	AND R3, R2,#0xF0; extract next hex digit
	MOV R3, R3, LSR#04
	CMP R3,#9; compare with 9
	BLS DOWN1
	ADD R3,#7; add 7 if less than 9
DOWN1 ADD R3,#0x30 
	STRB R3,[R1,#01];
	
STOP B STOP
NUM DCD 0x0000003A
	AREA mydata, DATA, READWRITE
DST DCD 0
	END