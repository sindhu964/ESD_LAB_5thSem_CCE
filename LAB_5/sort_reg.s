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
	 MOV R1,#30
	 MOV R2,#9
	 MOV R3,#45
	 MOV R4,#4
	 LDM R13!,{R1-R4}
	 
	AREA mydata, DATA, READWRITE
DST DCD 0
	END