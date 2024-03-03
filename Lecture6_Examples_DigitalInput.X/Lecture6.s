; Program: To light LEDs based on push button switches
; Author: Samuel Walsh
; Date: 02/03/2024
; Pushbutton 1 is attached to RJ5
; Pushbutton 2 is attached to PB0
; LED1 is RF0, LED2 is RF1
processor 18F8722
radix dec 
CONFIG OSC = HS 
CONFIG WDT = OFF ;
CONFIG LVP = OFF 
#include <xc.inc> 


PSECT resetVector, class=CODE, reloc=2
resetVector:
 goto start 
PSECT start, class=CODE, reloc=2
start: 
  // Setup TRIS I/O before main loop
  bsf TRISJ, 5, a  ; Set TRISJ5 as input
  bsf TRISB, 0, a  ; Set TRISB0 as input
  bcf TRISF, 0, a  ; LED1 as output
  bcf TRISF, 1, a  ; LED2 as output
  
  end
    

    



  