; Program to demonstrate call return using delays
; Author: Samuel Walsh, Frank Podd
; Date: 16/03/24
; Description: This program will countdown from 100 to 0, every 200 ms, then stop.
; This code is correct for a 10 MHz clock ? giving an instruction frequency of 2.5 MHz, which is 0.4 us per instruction

; NOTE 1 - Make sure you have set the instruction frequency up in the simulator.

; NOTE 2 - Add the standard header above this code with CONFIG etc

; NOTE 3 - You must also create 4 variables named:
;   var_count_100us 
;   var_count_10ms  
;   var_count_200ms
;   var_counter_value
; Whether to use absolute or relocatable variables for these 4 is programmers choice. 

processor 18F8722
radix   dec ; use decimal numbers
    
CONFIG  OSC = HS  ; use the high speed external crystal on the PCB
CONFIG  WDT = OFF ; turn off the watchdog timer
CONFIG  LVP = OFF ; turn off low voltage mode

;Include useful processor-specific definitions
#include <xc.inc>   

PSECT udata_acs
global  var_count_100us, var_count_10ms, var_count_200ms, var_counter_value
var_count_100us: ds 1
var_count_10ms:  ds 1
var_count_200ms: ds 1   
var_counter_value:   ds 1

PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
  ; Setup SFR for using LEDs
  clrf TRISF, a    ; Set LEDs to be outputs
  bcf TRISA, 4, a  ; Set RA4 as output for Q3
  
  ; Setup initial counter value
  movlw 100
  movwf var_counter_value, a 

l_decrement:
  movf var_counter_value, W, a 
  movwf LATF, a                 ; Put counter value on LEDs
  bsf LATA, 4, a                ; Enable Q3
  call sub_200ms		; Using the stopwatch, step over this line to make sure it takes 200ms (you could confirm using MyDAQ oscilloscope also). 
  bcf LATA, 4, a                ; Disable Q3

  ; Decrement counter value, I use addlw -1 but you could try decf instruction
  movf var_counter_value, W, a
  addlw -1
  movwf var_counter_value, a
  bnz l_decrement               ; Loop again if counter > 0
  
l_end: bra l_end ; endless loop

; ------------- Subroutines defined below ------------------

sub_100us: ; creates a delay of 100 microseconds
  movlw 35 ; Set the initial value for the var_count_100us variable.
  movwf var_count_100us, a
  l_delay:
    nop ; Waste some time. Each instruction takes 0.4 us
    nop ; Waste another 0.4 us
    nop ; boring
    nop ; yawn. The choice of the number of NOPs is up to you
    decf var_count_100us, a ; Reduce the value of the var_count_100us variable
    bnz l_delay ; If var_count_100us is not yet zero then loop around
    ; The loop contains 7 instructions cycles of delay (4xNOP+DECF+2forBNZ)
    ; It will be called 35 times, so 35 * 7 * 0.4 = 98 us. Plus the Call/Return + the MOVLW and MOVWF, gives 100 us
    return ; This is not included in the calculation of the loops.
    ; In addition to the loop there is also the delay from 2xMOV+RETURN (1.6 us)
    ; To increase the delay further, we?ll call the SUB_100us subroutine many times

sub_10ms: ; This subroutine has a delay of approximately 10 ms
  movlw 99 ; We will call the sub_100us approximately 100 times to get a 10 ms delay
  movwf var_count_10ms, a

l_innerloop_10ms:
  call sub_100us ; Call that subroutine that wasted 100 us
  decf var_count_10ms, a
  bnz l_innerloop_10ms

  return

; To increase the delay still further, we?ll call the sub_10ms subroutine in another loop

sub_200ms: ; This subroutine has a delay of approximately 200 ms
  movlw 20 ; The sub_10ms takes 10 ms plus we have a few extra instructions
  movwf var_count_200ms, a ; We?ll call the SUB_10ms nearly 20 times to get an approximately 200 ms delay

l_innerloop_200ms:
  call sub_10ms
  decf var_count_200ms, a
  bnz l_innerloop_200ms
  return

  end




