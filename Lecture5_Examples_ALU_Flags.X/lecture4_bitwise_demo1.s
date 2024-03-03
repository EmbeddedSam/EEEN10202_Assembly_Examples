; Program to use both 7-segment displays simultaneously with the LEDs
; Author:   Samuel Walsh
; Date:	    18/02/24
; Add the global options "-Wl,-presetVector=0h, -Wl,-pstart=200h" in MPLAB before building this
    
processor 18F8722
radix   dec ; use decimal numbers
    
CONFIG  OSC = HS  ; use the high speed external crystal on the PCB
CONFIG  WDT = OFF ; turn off the watchdog timer
CONFIG  LVP = OFF ; turn off low voltage mode

;Include useful processor-specific definitions
#include <xc.inc>      

PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
  ; Bit operations 
  clrf TRISF
  clrf LATF
  bcf TRISA, 4   ; Configure RA4 as output
  bsf LATA, 4    ; Turn RA4 on for Q3 (turn on LED's)
  
  btg LATF, 0
  btg LATF, 0
  btg LATF, 0
  
  ; Bitwise operations on words
  clrf LATF
  comf LATF  ; NOT
  comf LATF 
  
  ; Masking unused bits using AND
  movlw 10101010B 
  movwf LATF
  andlw 00001111B
  movwf LATF
  
  ; Not touching existing 1's using IOR
  movlw 10101010B
  movwf LATF
  iorlw 01010101B  ; Changed but left the originals in place
  movwf LATF
  
  
  
  movlw 10101010B  
  movwf LATF
  iorlw 00000100B  ; Setting individual bit with ior
  movwf LATF
  
  movlw 10010000B   ; 1001 0000
  iorlw 00001010B   ; 0000 1010      result = 1001 1010
  movwf LATF
  

loop: bra loop ; endless loop
  end



