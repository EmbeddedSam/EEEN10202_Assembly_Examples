; Program: To light LEDs based on toggle switches value
; Author: Samuel Walsh
; Date: 02/03/2024
; SW1 = RC2
; SW2 = RC3
; SW3 = RC4
; SW4 = RC5
; SW5 = RH4
; SW6 = RH5
; SW7 = RH6
; SW8 = RH7
; LEDs are RF0-RF7
; Q3 = RA4
processor 18F8722
radix dec 

CONFIG OSC = HS 
CONFIG WDT = OFF 
CONFIG LVP = OFF 

#include <xc.inc> 

PSECT udata_acs
global switch_value
switch_value: ds 1

PSECT resetVector, class=CODE, reloc=2
resetVector:
 goto start 

PSECT start, class=CODE, reloc=2
start: 
  ; Setup TRIS I/O before main loop
  movlw 0x0F
  movwf ADCON1, a  ; Set all inputs as digital (see p272 of datasheet)
  setf TRISC, a    ; Set all of TRISC as inputs (although only using RC2:RC5)
  clrf TRISF, a    ; Set all LEDs as outputs
  bcf  TRISA, 4, a ; Set Q3 as output

  ; Setup initial outputs
 clrf LATF, a      ; Turn off all LEDs
 bsf LATA, 4, a    ; Enable Q3

main:
  movf PORTC, W, a
  movwf switch_value, a
  rrncf switch_value, F, a  ; Rotate switches right
  rrncf switch_value, F, a  ; Rotate switches right
  movf  switch_value, W, a  
  andlw 0x0F                ; Mask off unused bits
  movwf LATF, a
  bra main

  end
    

    



  