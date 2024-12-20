#include<LPC17xx.h>

unsigned int j;

int main(void){
	LPC_PINCON->PINSEL0 = 0x00000000;
	LPC_GPIO0->FIODIR = 0xFF<<4;
	while(1){
		LPC_GPIO0->FIOSET = 0xFF<<4;
		for(j=0;j<2;j++);
		LPC_GPIO0->FIOCLR=0xFF<<4;
		for(j=0;j<2;j++);
	}
}
