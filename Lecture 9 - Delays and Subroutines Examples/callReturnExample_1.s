; Program to demonstrate call return functionality
; Author: Samuel Walsh, Frank Podd
; Date: 16/03/24

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
  movlw 10
  call increment_working
loop:
  bra loop ; endless loop

increment_working:
  addlw 1
  return
  
  end



