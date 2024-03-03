; Program: To light LED based on push button switch input using bitmasks
; Author: Samuel Walsh
; Date: 02/03/2024
; Pushbutton 2 is attached to PB0
; LED1 is RF0

processor 18F8722
radix dec 

CONFIG OSC = HS 
CONFIG WDT = OFF 
CONFIG LVP = OFF 

#include <xc.inc> 


PSECT resetVector, class=CODE, reloc=2
resetVector:
 goto start 
PSECT start, class=CODE, reloc=2
start: 
  // Setup TRIS I/O before main loop
  movlw 0x0F
  movwf ADCON1, a  ; Set all inputs as digital (see p272 of datasheet)
  bsf TRISB, 0, a  ; Set TRISB0 as input
  bcf TRISF, 0, a  ; LED1 as output
  bcf TRISA, 4, a  ; Set Q3 as output

main:
  clrf LATF, a      ; Clear all LEDs
  movf PORTB, W, a  ; Read all of PORTB
  andlw 00000001    ; Mask off unused bits
  ; Now we have the value you could do a few things. 
  ; For example, you could check the ALU flags to see whether the value was 0.
  ; As PB2 = 0 V when pressed down, 1 AND 0 = 0 = Zero flag will be set. 
  ; Check the Z flag and then branch to wherever you want:
  bz pb2_pressed    ; If pressed go to this label
  bra main	    ; Else loop back to main

pb2_pressed:
  bsf LATA, 4, a  ; Enable Q3
  bsf LATF, 0, a  ; Turn on LED1
  bra main
  end
    

    



  