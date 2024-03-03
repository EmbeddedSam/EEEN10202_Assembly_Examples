
processor 18F8722
radix dec 
CONFIG OSC = HS 
CONFIG WDT = OFF ;
CONFIG LVP = OFF 
#include <xc.inc> 

psect udata_acs
 x:ds 1 ;store in data memory address 0x00

PSECT resetVector, class=CODE, reloc=2
resetVector:
 goto start 
PSECT start, class=CODE, reloc=2
start: 

  ; Carry flag is trying to tell us, that there is an 
  ; error with our ALU output (unsigned values)

  ; 127 + 129 = 256
  ; [1] 0000 0000
  ; C = 1, Z = 1
  ; 0111 1111 = 127
  ; 1000 0001 = 129

  movlw 127
  addlw 129

  ; 200 + 200 = 400 [1] 1001 0000
  movlw 200
  addlw 200

  ; -1 + -2 = -3
  ; 1111 1111
  ; 1111 1110 
  ; ---------
  ; 1111 1101 
  
  movlw -1
  addlw -2
    
  ; 1111 11111 = 255 (unsigned)

  ; 0111 11111 = 127
  ; 1000 00000 = -128

  ; -128 + -2 = -130 
  ; 1000 0000
  ; 1111 1110
  ; [1] 01111110

  movlw -128
  addlw -2

  bra start
    
  end
    

    



  