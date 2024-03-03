; Program to light LED1 on the IO board
; Author:   Samuel Walsh
; Date:	    09/02/24
; Add the global options "-Wl,-presetVector=0h, -Wl,-pstart=200h" in MPLAB before building this
; 
; Helpful information
; TRISA = 0xF92, LATA = 0xF89  (NPN Tansistor Q3 attached to RA4)
; TRISF = 0xF97, LATF = 0xF8E  (LEDs attached to RF0-RF7)
    
processor 18F8722
radix   dec ; use decimal numbers
    
CONFIG  OSC = HS  ; use the high speed external crystal on the PCB
CONFIG  WDT = OFF ; turn off the watchdog timer
CONFIG  LVP = OFF ; turn off low voltage mode

;Include useful processor-specific definitions
#include <xc.inc>      

; Our program start point
PSECT start, class=CODE, reloc=2

PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
    ; Configure GPIO Port A and F (RAx and RFx). Note bit 0 is the RIGHT-most bit.
    ; Step 1: CONFIGURE the pins to be digital INPUT or OUTPUT using TRIS
    movlw 11101111B ; Prepare a byte that will set GPIO4 pin as OUTPUT (0).
    movwf 0xF92	    ; Copy the value to the TRISA register to configure RA4
    
    movlw 00000000B ; Prepare a byte that will set all GPIO's 0-7 as output
    movwf 0xF97	    ; Copy the value to TRISF to make all LED pins outputs

    ; Step 2: Set the Output pins high (5 V) or low (0 V) using LAT
    movlw 00010000B ; Set RA4 high as it is an NPN transistor
    movwf 0xF89     ; Copy the value to the LATA register
    
    movlw 00000001B ; Set LED1 as ON (5 V)
    movwf 0xF8E     ; Send value to LATF to turn LED1 on

loop:
    bra loop ; endless loop
    end



