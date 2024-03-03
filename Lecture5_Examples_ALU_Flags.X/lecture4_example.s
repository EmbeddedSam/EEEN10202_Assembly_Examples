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
  BCF TRISA, 4
  BSF LATA, 4
  CLRF TRISF
  CLRF LATF
  
  BSF LATF, 0
  
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
  
  ; Combining nibbles with IOR

  

loop: bra loop ; endless loop
  end






