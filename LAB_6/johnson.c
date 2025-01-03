#include<stdio.h>
#include<lpc17XX.h>

unsigned int i,j;
unsigned long LED = 0x00000010;

int main(void){
	LPC_PINCON->PINSEL0 = 0;
	LPC_GPIO0->FIODIR = 0xFF<<15;

	while(1){
		LED = 1<<15;
		for(i=1;i<9;i++){
			LPC_GPIO0->FIOSET = LED;
			for(j=0;j<5;j++);
			LED <<= 1;
		}

		LED = 1<<15;
		for(i=1;i<9;i++){
			LPC_GPIO0->FIOCLR = LED;
			for(j=0;j<5;j++);
			LED <<= 1;
		}

	}
} 
