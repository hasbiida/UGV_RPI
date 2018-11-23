/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 4/22/2013
Author  : estheim
Company : 
Comments: 


Chip type               : ATmega8
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/
#include <mega8.h>
#include <delay.h>
unsigned int counterkanan,counterkiri;
// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
counterkanan++;
}

// External Interrupt 1 service routine
interrupt [EXT_INT1] void ext_int1_isr(void)
{
counterkiri++;
}

#include <stdio.h>
#define kanan PORTC.0;
#define kiri PORTC.1;
int i,j;
bit status;
unsigned char datas[20];
long pwml,pwmr;

void maju(void);
void mundur(void);
void kanan90(void);
void kiri90(void);
void stop(void);
void kirim(void);
void baca(void);
void proses(void); 
long rubahdata(unsigned char arah);
void cekarah(void);

void main(void)
{
PORTB=0x00;                                        
DDRB=0x0E;
PORTC=0xFF;
DDRC=0xFF;
PORTD=0x00;
DDRD=0x00;
TCCR0=0x00;
TCNT0=0x00;
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 16000.000 kHz
// Mode: Ph. correct PWM top=0x00FF
// OC1A output: Non-Inv.
// OC1B output: Non-Inv.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0xA1;
TCCR1B=0x09;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Set on compare match
ASSR=0x00;
TCCR2=0x30;
TCNT2=0x00;
OCR2=0x00;
// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Rising Edge
// INT1: On
// INT1 Mode: Rising Edge
GICR|=0xC0;
MCUCR=0x0F;
GIFR=0xC0;
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;
// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x18;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;
ACSR=0x80;
SFIOR=0x00;
ADCSRA=0x00;
SPCR=0x00;
TWCR=0x00;
// Global enable interrupts
#asm("sei")
pwml=240;
pwmr=240;
printf("begin program\r\n");
while (1){ 
      status=0;
      kirim(); 
      baca();
      printf("%s,%i\r\n",datas,status);
      proses();
      }
}
void maju(void) {
    OCR1AL=pwmr;  //  kanan
    OCR1BL=pwml; //    kiri
    PORTC.0=1;// kanan
    PORTC.1=1;// kiri
};
void stop(void){
    OCR1AL=0;
    OCR1BL=0;
    PORTC.0=0;
    PORTC.1=0;   
};
void mundur(void){
    OCR1AL=pwmr;
    OCR1BL=pwml;
    PORTC.0=0;
    PORTC.1=0;   
};
void kanan90(void){
    OCR1AL=pwmr;
    OCR1BL=pwml;
    PORTC.0=0;
    PORTC.1=1;   
};
void kiri90(void){
    OCR1AL=pwmr;
    OCR1BL=pwml;
    PORTC.0=1;
    PORTC.1=0;    
};
void kirim(void){  
    scanf("%s",datas);
}
void baca(void)
{
j=0;
 if(datas[j]==36)//$
 {             
 j=j+1;
   if(datas[j]==109) {//ascii m
   i=0;
   j=0; 
   status=1;
   }
   else {
   status=0;           
   }
 }
 else{
 status=0; 
 }
}
void proses(void)
{
    if(status==1){
     //   printf("rubah data");
        pwml=rubahdata(0);       //0 for left, 1 for right
        pwmr=rubahdata(1);
        cekarah(); //untuk arah   
        status=0;        
    }
    else
    {
    stop();
    } 
    printf("$slave,%3d,%3d\r\n",pwml,pwmr);
    delay_ms(1); //delay untuk mencegah error
    printf("$counter,%i,%i\r\n",counterkanan,counterkiri);
    counterkanan=0;
    counterkiri=0;      
}
long rubahdata(unsigned char arah)
{
    unsigned char temp; 
    unsigned char a,b,c;
    unsigned char pwm;
    if (arah==0){  
        a=(datas[8]-48)*100;     
        b=(datas[9]-48)*10;                                   
        c=datas[10]-48;
        temp=a+b+c;                            
    }
    else if (arah==1) {        
        a=(datas[12]-48)*100;     
        b=(datas[13]-48)*10;                                   
        c=datas[14]-48;
        temp=a+b+c;
    }
    else{
    pwm=0;
    }    
    pwm=temp;
return pwm;
}
void cekarah(void){
    if (datas[16]=='1' && datas[18]=='1'){                                                
      maju();
    }   
    else if (datas[16]=='0' && datas[18]=='0'){                                                
      mundur();
    }
    else if (datas[16]=='1' && datas[18]=='0'){                                                
      kanan90();
    }
    else if (datas[16]=='0' && datas[18]=='1'){                                                
      kiri90();
    }
}