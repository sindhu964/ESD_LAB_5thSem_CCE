#include<LPC17xx.h>

unsigned int dig_count;
signed int dig_val[] = {0,0,0,0,0};
unsigned int select_seg[] = {0,0<<15,1<<15,2<<15,3<<15};
unsigned char seven_seg[16]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
unsigned long int temp1,temp2,i=0;
unsigned int N=2;
unsigned int count=0;
unsigned int flag=0x00;

void display(void);
void delay(void);
void upcount(void);
void downcount(void);

int main(void){
		SystemInit();
		SystemCoreClockUpdate();
	
		LPC_PINCON->PINSEL0=0; //GPIO data lines
		LPC_PINCON->PINSEL1=0; //GPIO enable lines
	
		LPC_PINCON->PINSEL4=0;//input from P2.12
	
		LPC_GPIO0->FIODIR = 0xFF<<4;
		LPC_GPIO0->FIODIR |= 0xF<<15;
	
		//LPC_GPIO2->FIODIR=1<<12;
	
	while(1){
		delay();
		
		dig_count+=1;
		
		//pressed button
		if (!(LPC_GPIO2->FIOPIN & 1<<12)){
			if(dig_count==0x05){
				dig_count=0x01;
				upcount();
			}
		}
		//not pressed button
		else{
			if(dig_count==0x05){
				dig_count=0x01;
					downcount();
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

void upcount(void){
		if(flag==0xFF){
					flag=0;
					dig_val[1]+=1;
					if(dig_val[1]==0x0A){
						dig_val[1]=0;
						dig_val[2]+=1;
							if(dig_val[2]==0x0A){
								dig_val[2]=0;
								dig_val[3]+=1;
								if(dig_val[3]==0x0A){
									dig_val[3]=0;
									dig_val[4]+=1;
									if(dig_val[4]==0x0A){
										dig_val[4]=0;
								}
							}
						}
					}
				}
}

void downcount(void){
	if(flag==0xFF){
					flag=0;
					dig_val[1]-=1;
					if(dig_val[1] < 0){
						dig_val[1]=9;
						dig_val[2]-=1;
							if(dig_val[2] < 0){
								dig_val[2]=9;
								dig_val[3]-=1;
								if(dig_val[3] < 0){
									dig_val[3]=9;
									dig_val[4]-=1;
									if(dig_val[4]<0){
										 dig_val[1]=9;
										 dig_val[2]=9;
										 dig_val[3]=9;
										 dig_val[4]=9;
								}
							}
						}
					}
				}
}