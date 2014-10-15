/*
 * GccApplication2.c
 *
 * Created: 2014-10-15 17:49:19
 *  Author: student
 */ 

#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRA = 255;
	double	time = 1;
	double x = 0,delta=0.01;
	
	
    while(1)
    {
		
		for(int i=0;i<10;i++){
        PORTA=255;
		_delay_ms(x);
		PORTA=0;
		_delay_ms(time-x);
		}
		x+=delta;
		if(x>=1 || x<=0) {delta*=-1;}	
		
		
		
		
		
	}		
}
