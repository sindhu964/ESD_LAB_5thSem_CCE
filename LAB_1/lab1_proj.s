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
	MOV R0,#2_1010; base2
	MOV R1,#3_1010; base3
	LDR R2,=SRC; base adress of array SRC
	LDR R3,[R2]; access the value pointed by R2
	LDR R4,[R2,#4]; add 4 to location R2 and access the value
STOP
	B STOP
NUM EQU 10
SRC DCD 8,0x12345678,0xABCDEF1A
	END