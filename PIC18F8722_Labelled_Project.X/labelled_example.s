processor 18F8722 ; the processor we are using
radix     dec     ; set the default radix to decimal

; These configuration bit commands mean: 
; 1. We are going to be using the external crystal oscillator as our main system clock
; 2. We are not using the watchdog timer feature of the PIC
; 3. We are not using low voltage programming mode of the PIC 
CONFIG  OSC = HS  
CONFIG  WDT = OFF 
CONFIG  LVP = OFF 

;This file include useful processor-specific definitions such as locations of registers and bits within registers. It is not essential, but highly recommended. Note, you can create your own include files too.
#include <xc.inc>     

; PSECTS hold program code and data in pic-as. They allow you to split code up across multiple files. This one holds the code (due to having class=CODE) for the reset vector (the first command executed on boot). We tell the linker to place this PSECT at program memory address 0x00 by adding the option "-Wl, -PresetVector=0x00" to pic-as global options in MPLAB X. '-Wl' = add linker option, '-P' = place, then followed by the name of the PSECT (without spaces).
PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point. We could have called this whatever we wanted, but we chose 'start' for clarity. We could allow the linker to place this PSECT anywhere in program memory by not specifying a location, but we chose to place it at 0x200 by adding the option "-Wl, -Pstart=0x200" to pic-as global options in MPLAB X. 

; The final linker options were: "-Wl, -PresetVector=0x00, -Wl, -Pstart=0x200"
PSECT start, class=CODE, reloc=2
start:                    ; This is the start of our program 
    MOVLW  22             ; Move value (Literal) 22 into the WReg
    MOVWF  0x01           ; Move the value stored in WReg in File address 1

    MOVLW  00101001B      ; Move binary value 00101001 to the WReg
    MOVWF  0x02           ; Move the value stored in WReg in File address 2

    MOVLW  0x15           ; Move hexadecimal value 0x15 into WREG
    MOVWF  0x03           ; Move the value stored in WReg in File address 3

    MOVF   0x01, W        ; Move the contents of File memory 1 into WReg
    ADDLW  0x1F           ; Add the value (Literal) 31 to WReg.

    ADDWF  0x02, W        ; Add the value in the WReg to the value in File Memory address 2, and put the result into the working register
    
    ADDWF  0x03, F        ; Add the value in the WReg to the value in File Memory address 3, and put the result into File memory address 3
L_FOREVER:
    BRA   L_FOREVER       ; Creates an infinite loop
    end                   ; tells the compiler it is the end of the program


