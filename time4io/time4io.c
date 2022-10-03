#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int getsw(void){  //Ingen in-parameter
    
    return (PORTD >> 8) & 0x000f; //skiftar värdet i PORTD 8 bits höger och and:ar                 och returnerar de 4 lsb för att se ifall de är high eller low
        
}

int getbtns(void){
    
    return (PORTD >> 5) & 0x0007;  //Samma som ovan fast H/L värdet är i bits 7-5
    
}
