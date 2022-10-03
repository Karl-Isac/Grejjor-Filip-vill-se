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

volatile int * porte = (volatile int *) 0xbf886110;  //global pekare för adressen                                                       PORTE

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
    volatile int * trise = (volatile int *) 0xbf886100; //Pointer trise pekar på
    // ===A===                                          adressen för TRISE
    //set PORTE, j =1-3 to outputs
    
    *trise &= ~0xff;    //Avrefererar pekaren trise och sätter värderna för de 8                        lsb (mha and) till ett för att indekera en input
    
    TRISD = TRISD & 0x0fe0; //And:ar hex 000111111100000 för att inisilera port                                         11-5 till outputs
    //===B===
    // same as above but with definitions in pic32mx.h
    //TRISECLR = 0xe;

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
  delay( 1000 );
  time2string( textstring, mytime);
  display_string( 3, textstring );
  display_update();
  tick( &mytime );
  display_image(96, icon);
    
    *porte = *porte +1; //Lamport tickar. Avrefererar pointern och ökar det binära                                      värdet
    
    //del h
    button = getbtns(); //Kallar getbtns från time4io.c
    switch_value = getsw();
    
    if (button & 1){   //BTN2
        mytime = (switch_value << 4) | (mytime & 0xff0f);
        //en siffera i mytime är 4 bits, så den andra sifferan är bits 7-4
        
    }
    
    if (button & 2){    //BTN3
        
        mytime = (switch_value << 8) | (mytime & 0xf0ff);
                    //tredje sifferan 11-8
    }
    
    if (button & 4){    //BTN4. 4 binärt är 100 vilket kollar msb från buttons
        
        mytime = (switch_value << 12) | (mytime & 0x0fff);
                            //osv
    }
    
}
