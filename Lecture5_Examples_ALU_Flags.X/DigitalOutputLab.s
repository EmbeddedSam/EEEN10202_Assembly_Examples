; Name: Irfan Imran Bin Hazlan
; Student ID number: 11345787
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
    movlw 11010110B ; binary -42
    movwf 0x00 ; Copy the binary number to 0x00
    
    movlw 11101111B ; Set RA4 as output
    movwf 0xF92 ; Copy the value to TRISA and configure RA4
    
    movlw 00000000B ; Set all LEDs as output
    movwf 0xF97 ; Copy the value to TRISF and configure RF0-RF7
    
    movlw 11111101B ; Set transistor Q2 as output
    movwf 0xF99 ; TRISH
L_Main:    
    movlw 11010110B ; Binary number -42
    movwf 0xF8E ; Copy the literal value to LATF
    
    movlw 00010000B ; Set RA4 high
    movwf 0xF89 ; Turn on transistor Q3 on LATA
    
    movlw 00000000B ; Set RA4 low
    movwf 0xF89 ; turn off transistor Q3 on LATA
    
    movlw 10011111B ; Display number 1 on the left hand 7 segemnt display
    movwf 0xF8E ; LATF
    
    movlw 11111101B ; Set RH1 low
    movwf 0xF90 ; turn on transistor Q2 on LATH
    
    movlw 11111111B ; Set RH1 high
    movwf 0xF90 ; turn off transistor Q2 LATH
    
    bra L_Main

  end ; To tell that it is the end of the code


