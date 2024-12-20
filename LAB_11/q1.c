#include <LPC17xx.h>
unsigned int flag = 0;
int main() {
	SystemInit();
	SystemCoreClockUpdate();
	LPC_PINCON -> PINSEL3 = 2 << 14;
	LPC_PWM1 -> TCR = 0x02;
	LPC_PWM1 -> PR = 0;
	LPC_PWM1 -> MCR = 0x03;
	LPC_PWM1 -> PCR = 1 << 12;
	LPC_PWM1 -> MR4 = 50;
	LPC_PWM1 -> MR0 = 30000;
	LPC_PWM1 -> LER = 0xFF;
	LPC_PWM1 -> TCR = 0x09;
	NVIC_EnableIRQ(PWM1_IRQn);
	while(1);
}

void PWM1_IRQHandler() {
	LPC_PWM1 -> IR = 0x01;
	if(flag == 0x00) {
		LPC_PWM1 -> MR4 += 50;
		LPC_PWM1 -> LER = 0xFF;
		if(LPC_PWM1 -> MR4 > 29900) {
			flag = 0xFF;
			LPC_PWM1 -> LER = 0xFF;
			
}
}
	else if(flag == 0xFF) {
		LPC_PWM1 -> MR4 -= 50;
		LPC_PWM1 -> LER = 0xFF;
		if(LPC_PWM1 -> MR4 < 100) {
			flag = 0x00;
			LPC_PWM1 -> LER = 0xFF;
}
}
}