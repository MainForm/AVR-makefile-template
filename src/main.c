#define F_CPU 16000000UL // Define CPU frequency for delay functions

#ifndef __AVR_ATmega128A__
#define __AVR_ATmega128A__
#endif

#include <avr/io.h>
#include <util/delay.h>

#include "usart.h"

int main(void) {
    // Set PORTB0 as output
    DDRA = 0xFF;

    USART0_Init(MYUBRR);

    while (1) {
        PORTA ^= 0x01; // Toggle PORTA0

        USART0_Transmit('T');
        USART0_Transmit('\n');

        _delay_ms(1000); // Delay for 1 second
    }

    return 0;
}