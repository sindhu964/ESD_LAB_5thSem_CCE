#include <LPC17xx.h>

unsigned int i,j;
unsigned long LED = 0x1<<15;

int main(void){
	LPC_PINCON -> PINSEL0 = 0;
	LPC_GPIO0 -> FIODIR = 0xFF<<15;
	
	while(1){
		LED = 0;
		for(i=0;i<=255;i++){
			LPC_GPIO0 -> FIOPIN = LED;
			for(j=0;j<9;j++);
			LED+=(1<<15);
		}
	}
}
