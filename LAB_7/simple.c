#include<lpc17xx.h>
unsigned char seven_seg[10] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
unsigned int i,j;
void delay(void);

int main(void){
	SystemInit();
	SystemCoreClockUpdate();
	
	LPC_PINCON->PINSEL0 = 0;
	LPC_GPIO0->FIODIR |= 0x00000FF0;
	
	while(1){
		for(i=0;i<10;i++){
			LPC_GPIO0->FIOPIN = seven_seg[i]<<4;
			delay();
		}
	}
	
}

void delay(){
	for(j=0;j<100000;j++);
}