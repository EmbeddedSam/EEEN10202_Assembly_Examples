; Program to demonstrate delays using subroutines
; Author: Samuel Walsh
; Date: 16/03/24

; Write an assembly language program to create a delay of exactly 200uS. 
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

PSECT udata_acs
global loop_count
loop_count: ds 1    

PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
    call delay_200us  ; 2 cycles
    nop

inf: bra inf ; endless loop


; ------- Subroutines  ----------
    
; 1 cycle delay  at 2.5 MHz instruction frequency is 4 ns
; Remember to set up the instruction frequency in the simulator
delay_200us:
    movlw 82      ; 1 cycle
    movwf loop_count, a   ;1 cycle
loop:
; do {
	nop		        ; 1 cycle delay 400 ns
	nop		        ; 1 cycle  400 ns
	nop		        ; 1 cycle delay
	decf	loop_count, a	; loop count-- 1 cycle delay 400 ns
	bnz	loop	        ; } while (lcnt1 != 0) 2 cycles 800 ns
; end of main loop delay
	nop		; 1 cycle delay
	nop
	return		; 2 cycles

    end



