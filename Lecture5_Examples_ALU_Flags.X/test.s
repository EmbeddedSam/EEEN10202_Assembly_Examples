; Name:Botao Su [Write your name here]
; Student ID number:11071241 [Write your student number here e.g. 12341010]
processor 18F8722
radix dec 
CONFIG OSC = HS 
CONFIG WDT = OFF ;
CONFIG LVP = OFF 
#include <xc.inc> 
PSECT resetVector, class=CODE, reloc=2
resetVector:
 goto start ; 
PSECT start, class=CODE, reloc=2
 movlw 00000000B
 movwf 0xF97
 MOVLW 11101111B
 movwf 0xF92
start: 
 global f
 f: ds 1
 movlw 10011000B
 movwf f
 btg t,1
 bcf t,7
 loop:
 movf f,w
 movwf 0xF8E
 movlw 11111111B
 movwf 0xF89
 bra loop
 ; Your code should be here
end ;