	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x10001000; Stack Pointervalue when stack is empty
	DCD Reset_Handler; reset vectors
	ALIGN
	AREA mycode, CODE, READONLY; point to ROM
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=SRC; points to SRC array
	LDR R1,=DST; points to DST array
	LDR R2,[R0]; take first value of SRC and put in temporary variable
	STR R2,[R1]; !IMP: source and dest is reversed in this instruction so we copy value into location pointed by R1,i.e. DST
	LDR R2,[R0,#4]
	STR R2,[R1,#4]
	LDR R2,[R0,#8]
	STR R2,[R1,#8]
STOP
	B STOP
NUM EQU 10
SRC DCD 8,0x12345678,0xABCDEF1A
	AREA mydata, DATA ,READWRITE; point to RAM so that DST is now a writable array
DST DCD 0
	END