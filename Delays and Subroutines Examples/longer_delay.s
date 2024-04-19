; Program to demonstrate longer delays
; Author: Samuel Walsh, Frank Podd
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
global lcnt1, lcnt12
lcnt1: ds 1   
lcnt12: ds 1 

PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
; Step 0: Turn LED's transistor on

; "We are only interested in the RA4 pin, therefore the configurations of the rest do not matter in this case, 
; we will set the other port A pins as inputs
  MOVLW 11101111B ; Set RA4 as an Output (O)
  MOVWF TRISA, a    ; TRISA

; Set RA4 High
  MOVLW 00010000B
  MOVWF LATA, a ; LATA

; We have now turned the transistor on

; Step 1: Set the LED's pins as outputs. 
; We can set all 8 pins of port F as output but writing the value 0 to the port F TRIS address
  MOVLW 00000000B  ;	OR	MOVLW 0
  MOVWF TRISF, a  ; TRISF

; Step 2: Set pins RF5 and RF3 high. We write these two bits as 1 to the LAT address for port F.
  MOVLW 00101000B  ; this are bits 5 and 3, the rightmost bit is bit 0
  MOVWF LATF, a 	    ; write the value (in WREG) to the LATF address

_loop: 
  ; Toggle ALL bits COMF
    COMF  LATF, F, a ; Toggle all bits in LATF and put the result back into LATF
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms
    CALL SUB_dly20ms

    BRA _loop
  

; ------- Subroutines  ----------
    
; 1 cycle delay  at 2.5 MHz instruction frequency is 4 ns
; Remember to set up the cindluction frequency in the simulator
    
SUB_dly200us:
    ; Initialise the counter for this delay
    MOVLW	83	        ; loop count value
    MOVWF	lcnt1, a	; save loop count value
L_dly200us:			
; do {
	NOP		; 1 cycle delay 
	NOP		; 1 cycle delay
	NOP		; 1 cycle delay
	DECF	lcnt1, a	; loop count-- 1 cycle delay
	BNZ	L_dly200us	; } while (lcnt1 != 0) 2 cycles
; end of inner loop delay
	NOP		; 1 cycle delay - outside the loop to give a small adjustment
	RETURN		; 2 cycles


SUB_dly20ms:  ; This subroutine calls the inner subroutine 100 times to produce a 100x longer delay
    ; Initialise the counter for this delay
    MOVLW	100	        ; loop count value
    MOVWF	lcnt12, a	; save loop count value
L_dly20ms:			
; do {
	CALL SUB_dly200us
	DECF	lcnt12, a	; loop count-- 1 cycle delay
	BNZ	L_dly20ms	; } while (lcnt12 != 0) 2 cycles
; end of outer loop delay
	NOP		; 1 cycle delay
	RETURN		; 2 cycles
	
;    end

  end   ; Tell the mpasm compiler that there is no more assembler
  