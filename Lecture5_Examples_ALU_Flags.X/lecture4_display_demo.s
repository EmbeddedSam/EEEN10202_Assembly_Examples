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
  clrf TRISF, a	     ; All LED's as outputs
  bcf  TRISA, 4, a   ; TRISA4 for Q4
  bcf  TRISH, 0, a   ; Q1 for U1 display
  bcf  TRISH, 1, a   ; Q2 for U2 display
  bsf  LATH, 0, a    ; Turn off U1
  bsf  LATH, 1, a    ; Turn off U2
loop:
  movlw 00010101B   ; The ?H? bit pattern for the 7-segment
  movwf LATF, a     ; Set that bit pattern as the high/low output levels of port F
  
  bcf LATH, 1, a    ; Turn on U1
  bsf LATH, 1, a    ; Turn off U1
  
  movlw 11110101B   ; The ?I? bit pattern for the 7-segment
  movwf LATF, a     ; Set that bit pattern as the high/low output levels of port F
  
  bcf LATH, 0, a    ; Turn on U1
  bsf LATH, 0, a    ; Turn off U1

  ; Toggling LEDs
  movlw 0x09   ; The required bit pattern for the LEDs
  movwf 0x01
  movf 0x01, W
  movwf LATF, a
  bsf LATA, 4, a    ; Turn RA4 on for Q3 (turn on LED's)
  bcf LATA, 4, a    ; Turn RA4 off (flash LEDs)
  
  btg 0x01, 0
  bcf 0x01, 7
  movf 0x01, W
  movwf LATF, a
  bsf LATA, 4, a    ; Turn RA4 on for Q3 (turn on LED's)
  bcf LATA, 4, a    ; Turn RA4 off (flash LEDs)
  
  bra loop ; endless loop
  end



