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
	    mov r4,#0
        mov r1,#10
        ldr r0, =ilist
        ldr r2, =result
up      ldr r3, [r0,r4]
        str r3, [r2,r4]
        add r4, r4, #04
        sub r1, r1, #01
        cmp r1, #00
        bhi up
        ldr r0, =result

        mov r3, #10             ; inner loop counter
        sub r3, r3, #1
        mov r9, r3              ; R9 contain no of passes
        ; outer loop counter
outer_loop
        mov r5, r0
loop
		        mov r4, r3              ; R4 contains no of compare in a pass
inner_loop
        ldr r6, [r5], #4
        ldr r7, [r5]
        cmp r7, r6

        strls r6, [r5]
        strls r7, [r5, #-4]     ; swap without swp instruction

        subs r4, r4, #1
        bne inner_loop
        sub r3, #1
        subs r9, r9, #1
        bne outer_loop

list dcd 0x10, 0x05, 0x33, 0x24, 0x56, 0x77, 0x21, 0x04, 0x87, 0x01
        AREA data1, data, readwrite
result DCW 0,0,0,0,0,0,0,0
        end

STOP B STOP
NUM DCD 0x39414543,0x45343331
	AREA mydata, DATA, READWRITE
DST DCD 0
	END