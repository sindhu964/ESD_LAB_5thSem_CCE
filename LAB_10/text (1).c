#include <LPC17xx.h>
#include <stdio.h>

int temp1, temp2, flag1, flag2;

void port_write() {
    int i;
    LPC_GPIO0->FIOPIN = temp2 << 23;

    if (flag1 == 0)
        LPC_GPIO0->FIOCLR = 1 << 27;
    else
        LPC_GPIO0->FIOSET = 1 << 27;

    LPC_GPIO0->FIOSET = 1 << 28;
    for (i = 0; i < 50; i++);
    LPC_GPIO0->FIOCLR = 1 << 28;

    for (i = 0; i < 30000; i++);
}

void LCD_write() {
    if ((flag1 == 0) & ((temp1 == 0x30) || (temp1 == 0x20)))
        flag2 = 1;
    else
        flag2 = 0;

    temp2 = temp1 >> 4;
    port_write();

    if (flag2 == 0) {
        temp2 = temp1 & 0xF;
        port_write();
    }
}

int main() {
    unsigned int adc_temp_4, adc_temp_5;
    int i;
    float in_vtg_4, in_vtg_5, voltage_diff;
    char vtg_4[7], vtg_5[7], diff_str[7];
    char msg1[] = {"ANALOG IP:"};
    char msg2[] = {"ADC OUTPUT:"};
    char msg3[] = {"DIFF:"};
    int lcd_init[] = {0x30, 0x30, 0x30, 0x20, 0x28, 0x0C, 0x01, 0x80, 0x06};

    SystemInit();
    SystemCoreClockUpdate();

    LPC_PINCON->PINSEL1 = 0;
    LPC_GPIO0->FIODIR = 0xF << 23 | 1 << 27 | 1 << 28;
    flag1 = 0;
    for (i = 0; i <= 8; i++) {
        temp1 = lcd_init[i];
        LCD_write();
    }
    flag1 = 1;

    LPC_PINCON->PINSEL3 = (3 << 28) | (3 << 30); // P1.30 as AD0.4 and P1.31 as AD0.5
    LPC_SC->PCONP = (1 << 12); // Enable peripheral ADC
    LPC_SC->PCONP |= (1 << 15); // Power for GPIO block

    // Display initial messages on LCD
    flag1 = 0;
    temp1 = 0x80; // First line
    LCD_write();
    flag1 = 1;
    i = 0;
    while (msg1[i] != '\0') {
        temp1 = msg1[i];
        LCD_write();
        i++;
    }

    flag1 = 0;
    temp1 = 0xC0; // Move to second line
    LCD_write();
    flag1 = 1;
    i = 0;
    while (msg2[i] != '\0') {
        temp1 = msg2[i];
        LCD_write();
        i++;
    }

    // Loop to read ADC values
    while (1) {
        // Read from channel 4 (AD0.4)
        LPC_ADC->ADCR = (1 << 4) | (1 << 21) | (1 << 24); // Start conversion on AD0.4
        while (!(LPC_ADC->ADGDR >> 31)); // Wait until conversion is complete
        adc_temp_4 = LPC_ADC->ADGDR >> 4 & 0x0FFF; // Read ADC value for channel 4
        in_vtg_4 = ((float)adc_temp_4 * 3.3 / 0xFFF); // Calculate voltage

        // Read from channel 5 (AD0.5)
        LPC_ADC->ADCR = (1 << 5) | (1 << 21) | (1 << 24); // Start conversion on AD0.5
        while (!(LPC_ADC->ADGDR >> 31)); // Wait until conversion is complete
        adc_temp_5 = LPC_ADC->ADGDR >> 4 & 0x0FFF; // Read ADC value for channel 5
        in_vtg_5 = ((float)adc_temp_5 * 3.3 / 0xFFF); // Calculate voltage

        // Calculate the difference
        voltage_diff = in_vtg_4 - in_vtg_5;

        // Display voltages on the LCD
        sprintf(vtg_4, "%3.2fV", in_vtg_4);
        sprintf(vtg_5, "%3.2fV", in_vtg_5);
        sprintf(diff_str, "%3.2fV", voltage_diff); // Format difference as voltage string

        // Display channel 4 voltage
        flag1 = 0;
        temp1 = 0x8A; // Move cursor to first data line
        LCD_write();
        flag1 = 1;
        i = 0;
        while (vtg_4[i] != '\0') {
            temp1 = vtg_4[i];
            LCD_write();
            i++;
        }

        // Display channel 5 voltage
        flag1 = 0;
        temp1 = 0xCB; // Move to second data line
        LCD_write();
        flag1 = 1;
        i = 0;
        while (vtg_5[i] != '\0') {
            temp1 = vtg_5[i];
            LCD_write();
            i++;
        }

        // Display the difference
        flag1 = 0;
        temp1 = 0xCE; // Move to a new position for the difference
        LCD_write();
        flag1 = 1;
        i = 0;
        while (diff_str[i] != '\0') {
            temp1 = diff_str[i];
            LCD_write();
            i++;
        }

        // Delay for stability (adjust as needed)
        for (i = 0; i < 100000; i++);
    }
}
