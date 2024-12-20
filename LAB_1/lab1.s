	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x10001000; Stack Pointervalue when stack is empty
	DCD Reset_Handler; reset vectors
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	MOVW R0,#0x1234
	MOVT R1,#0x1234
	MVN R2,#-2
	LDR R3,=0x12345678
STOP
	B STOP
NUM EQU 10
SRC DCD 8,0x12345678,0xABCDEF1A
	END