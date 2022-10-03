/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */
#define TMR2PERIOD ((80000000 / 32 ) / 77) /* definerar  tidkonstant för vår period samt error hantering*/
#if TMR2PERIOD > 0xffff
#error "Timer period is too big."
#endif


int mytime = 0x5957;
int switch_value = 0x0;
int button = 0x0;
int timer = 0x0;

char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void )
{
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{
    volatile int * trise = (volatile int *) 0xbf886100;
    // ===A===
    //set PORTE, j =1-3 to outputs
    *trise &= ~0xff;
    TRISD = TRISD & 0x0fe0;
    //===B===
    // same as above but with definitions in pic32mx.h
    //TRISECLR = 0xe;

    T2CON = 0x70; //använder skala 1:256
    PR2 = TMR2PERIOD;
    TMR2 = 0;
    T2CONSET = 0x8000;
    
    // ===D===
    // write 0b101 to PORTE, j = 1-3
    // we use PORTESET and PORTECLR directly
    //PORTESET = (1 | 2 | 4 | 8 | 16 | 32 | 64); //| (1<<1)
    //*trise = 0xa;
    //PORTECLR = (1<<1);


  return;
}

/* This function is called repetitively from the main program */
void labwork( void )
{
    volatile int * porte = (volatile int *) 0xbf886110;
    //del h
    button = getbtns();
    switch_value = getsw();
    
  //delay( 1000 );
  // del 2, skapa egen delay


    if(IFS(0) & 0x100){ /* Test time-out event flag */
        IFS(0) = 0; /* Reset all event flags (crude!) */
        timer++;
        
    }
    
    

    
    if (button & 1){
        mytime = (switch_value << 4) | (mytime & 0xff0f);
        
    }
    
    if (button & 2){
        
        mytime = (switch_value << 8) | (mytime & 0xf0ff);
        
    }
    
    if (button & 4){
        
        mytime = (switch_value << 12) | (mytime & 0x0fff);
        
    }
        
        if (timer == 10){  // En sekund har gått
            time2string( textstring, mytime);  //Gör symbolerna
            display_string( 3, textstring );
            tick( &mytime );
            display_update();
            timer = 0;
            
            *porte = *porte + 1; //Lamport tickar
            
        }
    display_image(96, icon);
    
}
