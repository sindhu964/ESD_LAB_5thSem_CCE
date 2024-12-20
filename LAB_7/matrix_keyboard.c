#include <LPC17xx.h>
#define FIRST_SEG 0xFFF87FFF
void scan(void);

unsigned char col, row,flag;
unsigned long int i,var1,temp,temp3,temp2;
unsigned char SEVEN_CODE[4][4]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x77,0x7c,0x58,0x5e,0x79,0x71};

int main(void){
	SystemInit();
	SystemCoreClockUpdate();
	LPC_PINCON->PINSEL0 = 0; //P0.4 to P0.11 GPIO data lines
	LPC_GPIO0->FIODIR = 0xFFFFFFFF;//Port 0 output
	LPC_PINCON->PINSEL3 = 0; //P1.23 to P1.26 MADE GPIO
	LPC_PINCON->PINSEL4 = 0; //P2.10 t P2.13 made GPIO
	LPC_GPIO2->FIODIR = 0x00003C00; //made output P2.10 to P2.13 (rows)
	LPC_GPIO1->FIODIR =0; //made input P1.23 to P1.26 (cols)
	 
		while(1){

		for(row=0;row<4;row++){

					if(row == 0)
					temp = 1 << 10;
					else if(row == 1)
					temp = 1 << 11;
					else if(row == 2)
					temp=1 << 12;
					else if(row == 3)
					temp = 1 << 13;

					LPC_GPIO2->FIOPIN = temp;
					flag = 0;
					scan();
					if(flag == 1){

					temp2 = SEVEN_CODE[row][col];
					LPC_GPIO0->FIOMASK=0xFFF87FFF;
					LPC_GPIO0->FIOPIN = FIRST_SEG;
					temp2 = temp2 << 4;
					LPC_GPIO0->FIOMASK=0xFFFFF00F;
					LPC_GPIO0->FIOPIN = temp2;
					break;
					}
		} 
	}
	}

	void scan(void){
		unsigned long temp3;

			temp3 = LPC_GPIO1->FIOPIN;
			temp3 &= 0x07800000;
			if(temp3 != 0x00000000){
				flag = 1;
				if (temp3 == 1 << 23)
				col=0;
				else if (temp3 == 1 << 24)
				col=1;
				else if (temp3 == 1 << 25)
				col=2;
				else if (temp3 == 1 << 26)
				col=3;
			}
	}