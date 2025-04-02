#ifndef __COUNTING_H__
#define __COUNTING_H__

#define FOSC    F_CPU // Clock Speed
#define BAUD    9600
#define MYUBRR  FOSC/16/BAUD-1


void USART0_Init( unsigned int ubrr);
void USART0_Transmit( unsigned char data);

#endif // __COUNTING_H__