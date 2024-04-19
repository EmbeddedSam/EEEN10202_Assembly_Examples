; Program to demonstrate delays using subroutines
; Author: Samuel Walsh
; Date: 16/03/24

; Write an assembly language program to create a delay with a subroutine. 
; Implement the delay as a subroutine with the label dly200us using the CALL and RETURN 
; instructions and demonstrate the operation of this subroutine 
; using the stopwatch function of the MPLAB X simulator.

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
    call sub_delay
    nop

loop: bra loop ; endless loop


; ------- Subroutines  ----------
    
; 1 cycle delay  at 2.5 MHz instruction frequency is 400 ns
; Remember to set up the instruction frequency in the simulator
sub_delay:
    nop		; 1 cycle delay  1/2.5M = 400 ns
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay 
    nop		; 1 cycle delay
    return 0    ; 2 cycles
    end



