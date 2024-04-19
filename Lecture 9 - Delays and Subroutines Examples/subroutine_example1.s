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

; 1. Show call and return
; 2. Show shadow registers
; 3. Show passing and returning values

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
  movlw 10
  call increment, 1
  nop


loop: bra loop ; endless loop


; Subroutine below here
increment:
  addlw 1
  return 1 


  end



