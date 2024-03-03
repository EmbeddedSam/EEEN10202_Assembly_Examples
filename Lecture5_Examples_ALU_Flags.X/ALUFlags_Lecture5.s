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

  ; Examples showing how all of the different flags are set
  ; and how they can be used to determine the result of an
  ; operation


  ; Example 1 - Carry flag (255 + 1 = 0) (unsigned overflow)
  ; 11111111 + 00000001 = [1]00000000
  movlw 255
  addlw 1
  bnc start ; Branch back to start if carry flag is not set. 
  ; This could also have been bc if I wanted to branch if the carry flag was set.
  
  ; Single step through the code to see the carry flag change
  ; Notice that the carry flag is set after the addition, but also
  ; notice that the zero flag is also set. This is because the result
  ; of the addition is 0, and the carry flag is set to indicate that
  ; the result is greater than 255 (unsigned). The carry flag is trying
  ; to tell us that there is an error with our ALU output (unsigned values). 
  ; Results of the ALU flags are below:
  ; C = 1
  ; Z = 1
  ; OV = 0
  ; N = 0


  ; Example 2 - Overflow flag (127 + 1 = -128) (signed overflow)
  ; 01111111 + 00000001 = [0]10000000
  ; Here we are adding two signed numbers together, and the result
  ; is greater than 127. 
  ; This is a signed overflow, and the overflow
  ; flag is set to indicate this. Wheneer the overflow flag is set, the
  ; sign of the result is incorrect (the two inputs have the same sign, but the result has a different sign).
  movlw 127
  addlw 1
  bnov start ; Branch back to start if overflow flag is not set
  ; Single step through the code to see the overflow flag change
  ; Results of the ALU flags are below:
  ; C = 0
  ; Z = 0
  ; OV = 1
  ; N = 1

  ; Why can't we use the carry flag to detect signed overflow?
  ; Because the most significant bit of a signed number will be 1 (to indicate it is negative). So if we add two signed numbers together, there will always be carry into the 9th bit. The carry flag will always be set, and so we can't use it to detect signed overflow. It is useless to us in this case.


  ; Example 3 - Carry flag again (200 + 200 = 144) (unsigned overflow)
  ; 11001000 + 11001000 = [1]10010000
  ; This time we are adding two unsigned numbers together, and the result
  ; is greater than 255. This is an unsigned overflow, and the carry flag
  ; is set to indicate this. Note how this time the overflow flag is not set, as 
  ; the two inputs have the same sign, and the result also has the same sign (MSB = 0 for both inputs and result - positive).
  movlw 200
  addlw 200
  bnc start ; Branch back to start if carry flag is not set
  ; Single step through the code to see the carry flag change
  ; Results of the ALU flags are below:
  ; C = 1
  ; Z = 0
  ; OV = 0
  ; N = 1

  ; Example 4 - Negative flag (1 - 2 = -1) 
  ; 00000001 + 11111110 = 11111111 
  ; This time we are adding two signed numbers together, and the result
  ; is negative. The negative flag is set to indicate this. Note how this time
  ; the overflow flag is not set, as the two inputs have the same sign, and the result
  ; also has the same sign (MSB = 1 for both inputs and result - negative).
  movlw 1
  addlw -2
  bnn start ; Branch back to start if negative flag is not set
  ; Single step through the code to see the negative flag change
  ; Results of the ALU flags are below:
  ; C = 0
  ; Z = 0
  ; OV = 0
  ; N = 1

  ; Example 5 - Zero flag (1 - 1 = 0) (a == b)
  ; 00000001 + 11111111 = 00000000 
  ; This time we are adding two signed numbers together, and the result
  ; is zero. The zero flag is set to indicate this. Note how this time
  ; the overflow flag is not set, as the two inputs have the same sign, and the result
  ; also has the same sign (MSB = 0 for both inputs and result - positive).
  movlw 1
  addlw -1
  bnz start ; Branch back to start if zero flag is not set
  ; Single step through the code to see the zero flag change
  ; Results of the ALU flags are below
  ; C = 0
  ; Z = 1
  ; OV = 0
  ; N = 0

  ; Example 6 - The carry flag is also a "not borrowed" flag (1 - 2 = -1) (unsigned subtraction)
  ; 00000001 + 11111110 = [0]11111111 (with this subtraction the carry has been borrowed). . 
  ; This time we are subtracting two unsigned numbers and the carry flag has been
  ; borrowed. It can be confusing, but the carry flag has a dual function, it is also a "not borrowed" flag with subtraction operations. If we need to borrow from the 9th bit, the carry flag is cleared, if we don't it remains set. 
  movlw 2
  sublw 1
  bc start ; Branch back to start if carry flag is set (not borrowed)
  ; Single step through the code to see the carry flag change
  ; Results of the ALU flags are below
  ; C = 0 (borrowed)
  ; Z = 0
  ; OV = 0
  ; N = 1

  ; Example 7 - Where carry flag is not borrowed (2 - 1 = 1) (unsigned subtraction)
  ; 00000010 + 11111111 = [1]00000001 (with this subtraction the carry has not been borrowed).
  movlw 1
  sublw 2
  bnc start ; Branch back to start if carry flag is not set (borrowed)
  ; Single step through the code to see the carry flag change
  ; Results of the ALU flags are below
  ; C = 1 (not borrowed)
  ; Z = 0
  ; OV = 0
  ; N = 0

  



 ; The key to ALU flags is to understand that they are trying to tell us that there is an error with our ALU output. They are useful for performing comparisons on numbers, and for determining the result of an operation.

 ; You need to know what the sign of the result should be, and then you can use the ALU flags to determine if the result is correct or not. 

; A table of the different types of comparisons you can do is below:

; a == b (a - b = 0)  ()
; a != b (a - b != 0) 
; a > b (a - b > 0)
; a < b (a - b < 0)

; For each of these comparisons, you can use the ALU flags to determine the result of the operation. The flags are different for each comparison, and you need to know what the sign of the result should be to determine if the result is correct or not.

; The carry flag is trying to tell us that there is an error with our ALU output (unsigned values)
; The overflow flag is trying to tell us that there is an error with our ALU output (signed values)

; The negative flag is trying to tell us that the result is negative, but can't be used to determine if the result is correct or not.

  bra start
    
  end
    

    



  


