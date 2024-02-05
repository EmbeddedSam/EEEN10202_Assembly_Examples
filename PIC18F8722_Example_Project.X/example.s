; Program to move 3 values to 3 memory 
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
    movlw 22
    movwf 10
    movlw 00101001B
    movwf 11
    movlw 0x15
    movwf 12
loop:
    bra loop ; endless loop
    end



