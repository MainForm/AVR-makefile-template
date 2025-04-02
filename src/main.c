#define F_CPU 16000000UL // Define CPU frequency for delay functions

#ifndef __AVR_ATmega128A__
#define __AVR_ATmega128A__
#endif

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <util/delay.h>

#include "usart.h"

int add_main(int a, int b) {
    PORTA = 0x00;

    return a + b;
}

int main(void) {
    int num1 = 0;
    
    // Set PORTB0 as output
    DDRA = 0xFF;
    PORTA = 0x01;

    add_main(1,2);
    USART0_Init(MYUBRR);

    while (1) {
        PORTA ^= 0x01; // Toggle PORTA0
        USART0_Transmit('T');
        _delay_ms(1000); // Delay for 1 second
    }

    return 0;
}