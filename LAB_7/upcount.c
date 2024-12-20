#include<LPC17xx.h>

unsigned int dig_count;
unsigned int dig_val[] = {0,0,0,0,0};
unsigned int select_seg[] = {0,0<<15,1<<15,2<<15,3<<15};
unsigned char seven_seg[16]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x67,0x77,0x7C,0x5E,0x79,0x71};
unsigned long int temp1,temp2,i=0;
unsigned int N=1000;
unsigned int count=0;
unsigned int flag=0x00;

void display(void);
void delay(void);

int main(void){
		SystemInit();
		SystemCoreClockUpdate();
	
		LPC_PINCON->PINSEL0=0; //GPIO data lines
		LPC_PINCON->PINSEL1=0; //GPIO enable lines
	
		LPC_GPIO0->FIODIR = 0xFF<<4;
		LPC_GPIO0->FIODIR |= 0xF<<15;
		
	while(1){
		delay();
		
		dig_count+=1;
		if(dig_count==0x05)
			dig_count=0x01;
		if(flag==0xFF){
			flag=0;
			dig_val[1]+=1;
			if(dig_val[1]==0x10){
				dig_val[1]=0;
				dig_val[2]+=1;
					if(dig_val[2]==0x10){
						dig_val[2]=0;
						dig_val[3]+=1;
						if(dig_val[3]==0x10){
							dig_val[3]=0;
							dig_val[4]+=1;
							if(dig_val[4]==0x10){
								dig_val[4]=0;
						}
					}
				}
			}
		}
	display();
	}
}

void display(void){
	LPC_GPIO0->FIOMASK=0xFF<<4;
	LPC_GPIO0->FIOPIN=select_seg[dig_count];
	LPC_GPIO0->FIOMASK=0xFF<<15;
	LPC_GPIO0->FIOPIN=seven_seg[dig_val[dig_count]]<<4;
	for(i=0;i<500;i++);
	LPC_GPIO0->FIOCLR = 0xFF<<4;
}

void delay(void){
	for(i=0;i<500;i++);
	if(count==N){
		flag =0xFF;
		count=0;
	}else{
		count+=1;
	}
}
