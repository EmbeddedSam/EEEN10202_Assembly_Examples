; Program to demonstrate longer delays using sounder
; Date: 16/03/24

processor 18F8722
radix   dec ; use decimal numbers
    
CONFIG  OSC = HS  ; use the high speed external crystal on the PCB
CONFIG  WDT = OFF ; turn off the watchdog timer
CONFIG  LVP = OFF ; turn off low voltage mode

;Include useful processor-specific definitions
#include <xc.inc>  

; Delay memory locations

m500cnt equ 0x0E ; loop counter for delay500ms
u100cnt equ 0x0D;  loop counter for delay100us
m10cnt  equ 0x0C;  loop counter for delay100ms
u10cnt  equ 0x0B;  loop counter for delay10us
u6cnt   equ 0x11;  loop counter for delay5us
Scnt    equ 0x0F;  inner loop counter for sounds
OScnt   equ 0x10;  outer loop counter for sounds
x       equ 0x12;  current address

PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start ; On reset, jump to our program start location

; Our program start point
PSECT start, class=CODE, reloc=2
start: 
    MOVLW   0x0F
    MOVWF   0xFC1; ADCON1

    MOVLW   11111100B
    MOVWF   TRISH ;set RH0,RH1 out put, others in put

    SETF    LATH; turn off transistor Q1,Q2

    CLRF    TRISA;set pin A out put
    CLRF    LATA; turn off transistor Q3

    CLRF    TRISF;set pin F0-F7 out put

    SETF    TRISC;set pin C (toggle switches) in put

    CLRF    LATF; clean LATF

    CLRF    TRISJ;set pin J out put
;*******************************Settings****************************************

;********************************Main*******************************************
test_switch:     ;switch bit 1 as a switch of playing music. 1 is on. 0 is off.
    MOVLW   00000100B;set 00000100 in WR
    ANDWF   PORTC,W  ;anding WR and PORTC, save in WR
    BZ     test_switch ; if it's 0, jump back to test_switch

music:
    SETF    LATA; turn on transistor Q3

    ;*******************music starts**********************
    ;--------------------ode to joy-----------------------
    ;----------------------1=C4/4-------------------------
    CALL    C3          ; each Cx play about 250ms
    CALL    C3          ; 2 Cx are a Quarter note
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C5
    CALL    C5
    CALL    delay10ms
    ;1 note
    CALL    C5
    CALL    C5
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms
    ;2 notes
    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms
    ;3 notes
    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C3
    CALL    C2
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    delay500ms
    CALL    delay10ms
    ;4 notes
    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C5
    CALL    C5
    CALL    delay10ms
    ;5 notes
    CALL    C5
    CALL    C5
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms
    ;6 notes
    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms
    ;7  notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C2
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    delay500ms
    CALL    delay10ms
    ;8  notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms
    ;9 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms
    ;10 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms
    ;11 notes
    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    Cl5
    CALL    Cl5
    CALL    delay10ms

    CALL    C3
    CALL    C3
    ;12 notes
    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C5
    CALL    C5
    CALL    delay10ms
    ;13 notes
    CALL    C5
    CALL    C5
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C4
    CALL    C2
    CALL    delay10ms
    ;14 notes
    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms
    ;15 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C2
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    delay500ms
    CALL    delay10ms
    ;16 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms
    ;17 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms
    ;18 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms
    ;19 notes
    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    Cl5
    CALL    Cl5
    CALL    delay10ms

    CALL    C3
    CALL    C3
    ;20 notes
    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C5
    CALL    C5
    CALL    delay10ms
    ;21 notes
    CALL    C5
    CALL    C5
    CALL    delay10ms

    CALL    C4
    CALL    C4
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms

    CALL    C4
    CALL    C2
    CALL    delay10ms
    ;22 notes
    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C3
    CALL    C3
    CALL    delay10ms
    ;23 notes
    CALL    C2
    CALL    C2
    CALL    delay10ms

    CALL    C2
    CALL    C1
    CALL    delay10ms

    CALL    C1
    CALL    C1
    CALL    delay10ms

    CALL    delay500ms
    CALL    delay10ms
    ;24 notes

    ;*******************music ends******************

    CLRF    LATA; turn off transistor Q3

    MOVLW   00000100B;set 00000100 in WR
    ANDWF   PORTC,W  ;anding WR and PORTC, save in WR
    BZ      test_switch_transfer_label ; if it's 0, jump back to test_switch

    BRA     music ; music loop

test_switch_transfer_label:;conditional branch can only jump 8 bits places,but unconditioned branch can jump 13 bits. So, using this additional label to use BRA
    BRA     test_switch
;********************************Main*******************************************


;****Functions:***

;********************************C major_do*************************************
C1:
    CALL    light_LED1; turn on LED1
    MOVLW   65;65 loops
    MOVWF   OScnt; save in OScnt

C1_period:;do{
    ;total 3.8488ms for a full period
    SETF    LATJ; set LATJ 5V
    MOVLW   19;19 loops
    MOVWF   Scnt; save in Scnt
C1_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C1_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   19;19 loops
    MOVWF   Scnt; save in Scnt
C1_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C1_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C1_period ;}while(OScnt!=0)
    RETURN
;********************************C major_do*************************************

;********************************C major_re*************************************
C2:
    CALL    light_LED2; turn on LED1
    MOVLW   72;72 loops
    MOVWF   OScnt; save in OScnt

C2_period:;do{
    ;total  3.4448ms
    SETF    LATJ; set LATJ 5V
    MOVLW   17;17 loops
    MOVWF   Scnt; save in Scnt
C2_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C2_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   17;17 loops
    MOVWF   Scnt; save in Scnt
C2_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C2_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C2_period ;}while(OScnt!=0)

    ;ADDING 0.5period
    SETF    LATJ; set LATJ 5V
    MOVLW   17;17 loops
    MOVWF   Scnt; save in Scnt
C2_using_100us_1_2:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C2_using_100us_1_2; }while(Scnt!=0)

    RETURN
;********************************C major_re*************************************

;********************************C major_mi*************************************
C3:
    CALL    light_LED3; turn on LED3
    MOVLW   82;82 loops
    MOVWF   OScnt; save in OScnt

C3_period:;do{
    ;total  3.0392ms
    SETF    LATJ; set LATJ 5V
    MOVLW   15;15 loops
    MOVWF   Scnt; save in Scnt
C3_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C3_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   15;15 loops
    MOVWF   Scnt; save in Scnt
C3_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C3_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C3_period ;}while(OScnt!=0)

    ;adding 0.5 period

    SETF    LATJ; set LATJ 5V
    MOVLW   15;15 loops
    MOVWF   Scnt; save in Scnt
C3_using_100us_1_2:;do{
    CALL    delay100us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C3_using_100us_1_2; }while(Scnt!=0)

    RETURN
;********************************C major_mi*************************************

;********************************C major_fa*************************************
C4:
    CALL    light_LED4; turn on LED4
    MOVLW   86;86 loops
    MOVWF   OScnt; save in OScnt

C4_period:;do{
    ;total   2.8944ms
    SETF    LATJ; set LATJ 5V
    MOVLW   13;13 loops
    MOVWF   Scnt; save in Scnt
C4_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    CALL    delay10us;delay 10 us
    DECF    Scnt; --Scnt
    BNZ     C4_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   13;13 loops
    MOVWF   Scnt; save in Scnt
C4_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    CALL    delay10us;delay 10 us
    DECF    Scnt; --Scnt
    BNZ     C4_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C4_period ;}while(OScnt!=0)

    ;adding 0.5 period

    SETF    LATJ; set LATJ 5V
    MOVLW   13;13 loops
    MOVWF   Scnt; save in Scnt
C4_using_100us_1_2:;do{
    CALL    delay100us;delay 100 us
    CALL    delay10us;delay 100 us
    DECF    Scnt; --Scnt
    BNZ     C4_using_100us_1_2; }while(Scnt!=0)

    RETURN
;********************************C major_fa*************************************

;********************************C major_sol************************************
C5:
    CALL    light_LED5; turn on LED5
    MOVLW   97;97 loops
    MOVWF   OScnt; save in OScnt

C5_period:;do{
    ;total  2576ms
    SETF    LATJ; set LATJ 5V
    MOVLW   12;12 loops
    MOVWF   Scnt; save in Scnt
C5_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    CALL    delay6us;delay 6 us
    DECF    Scnt; --Scnt
    BNZ     C5_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   12;12 loops
    MOVWF   Scnt; save in Scnt
C5_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    CALL    delay6us;delay 6 us
    DECF    Scnt; --Scnt
    BNZ     C5_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C5_period ;}while(OScnt!=0)
    RETURN
;********************************C major_sol************************************

;********************************C major_la************************************
C6:
    CALL    light_LED6; turn on LED6
    MOVLW   110;110 loops
    MOVWF   OScnt; save in OScnt

C6_period:;do{
    ;total  2.2736ms
    SETF    LATJ; set LATJ 5V
    MOVLW   11;11 loops
    MOVWF   Scnt; save in Scnt
C6_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    NOP     ;5 nop= 2us
    NOP
    NOP
    NOP
    NOP
    DECF    Scnt; --Scnt
    BNZ     C6_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   11;11 loops
    MOVWF   Scnt; save in Scnt
C6_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    NOP     ;5 nop= 2us
    NOP
    NOP
    NOP
    NOP
    DECF    Scnt; --Scnt
    BNZ     C6_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C6_period ;}while(OScnt!=0)
    RETURN
;********************************C major_la*************************************

;********************************C major_si*************************************
C7:
    CALL    light_LED7; turn on LED7
    MOVLW   122;122 loops
    MOVWF   OScnt; save in OScnt

C7_period:;do{
    ;total  2.0512ms
    SETF    LATJ; set LATJ 5V
    MOVLW   10;10 loops
    MOVWF   Scnt; save in Scnt
C7_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    NOP     ;3 NOP = 1.2 us
    NOP
    NOP
    DECF    Scnt; --Scnt
    BNZ     C7_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   10;10 loops
    MOVWF   Scnt; save in Scnt
C7_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    NOP     ;3 NOP = 1.2 us
    NOP
    NOP     
    DECF    Scnt; --Scnt
    BNZ     C7_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     C7_period ;}while(OScnt!=0)
    RETURN
;********************************C major_si*************************************

;********************************C major_low sol********************************
Cl5:
    CALL    light_LED5; turn on LED5
    MOVLW   49;49 loops
    MOVWF   OScnt; save in OScnt

Cl5_period:;do{
	;total 5.1184 ms
    SETF    LATJ; set LATJ 5V
    MOVLW   23;23 loops
    MOVWF   Scnt; save in Scnt
Cl5_using_100us_1:;do{
    CALL    delay100us;delay 100 us
    CALL    delay10us;delay 10 us
    DECF    Scnt; --Scnt
    BNZ     Cl5_using_100us_1; }while(Scnt!=0)

    CLRF    LATJ; set LATJ 0V
    MOVLW   23;23 loops
    MOVWF   Scnt; save in Scnt
Cl5_using_100us_0:;do{
    CALL    delay100us;delay 100 us
    CALL    delay10us;delay 10 us
    DECF    Scnt; --Scnt
    BNZ     Cl5_using_100us_0; }while(Scnt!=0)

    DECF    OScnt; --OScnt
    BNZ     Cl5_period ;}while(OScnt!=0)
    RETURN
;********************************C major_low sol********************************


;********************************light_LED1*************************************
light_LED1:
    MOVLW   00000001B;put 00000001
    MOVWF   LATF; to LATF light LED1
    RETURN
;********************************light_LED1*************************************

;********************************light_LED2*************************************
light_LED2:
    MOVLW   00000010B;put 00000010
    MOVWF   LATF; to LATF light LED2
    RETURN
;********************************light_LED2*************************************

;********************************light_LED3*************************************
light_LED3:
    MOVLW   00000100B;put 00000100
    MOVWF   LATF; to LATF light LED3
    RETURN
;********************************light_LED3*************************************

;********************************light_LED4*************************************
light_LED4:
    MOVLW   00001000B;put 00001000
    MOVWF   LATF; to LATF light LED4
    RETURN
;********************************light_LED4*************************************

;********************************light_LED5*************************************
light_LED5:
    MOVLW   00010000B;put 00010000
    MOVWF   LATF; to LATF light LED5
    RETURN
;********************************light_LED5*************************************

;********************************light_LED6*************************************
light_LED6:
    MOVLW   00100000B;put 00100000
    MOVWF   LATF; to LATF light LED6
    RETURN
;********************************light_LED6*************************************

;********************************light_LED7*************************************
light_LED7:
    MOVLW   01000000B;put 01000000
    MOVWF   LATF; to LATF light LED7
    RETURN
;********************************light_LED7*************************************

;********************************light_LED8*************************************
light_LED8:
    MOVLW   10000000B;put 10000000
    MOVWF   LATF; to LATF light LED8
    RETURN
;********************************light_LED8*************************************

;*****************************Delay 500ms***************************************
delay500ms:;
    MOVLW  49;loop count m500cnt=49
    MOVWF  m500cnt
l500ms:;do{
    CALL    delay10ms;delay10ms
    DECF    m500cnt;--m100cnt
    BNZ     l500ms      ;}while(i!=0);
    MOVLW   98  ;loop count m10cnt=98
    MOVWF   m500cnt
m_using_100us:;
    CALL    delay100us
    DECF    m500cnt;--m100cnt
    BNZ     m_using_100us      ;}while(i!=0);

    CALL    delay10us; delay10us
    CALL    delay10us; delay10us
    NOP     ; 1 cycle delay
    NOP     ; 1 cycle delay
    NOP     ; 1 cycle delay

    RETURN  ; reurn
;}
;*****************************Delay 500ms***************************************

;*****************************Delay 10ms****************************************
;{
delay10ms:;{
    MOVLW   98;loop count m10cnt=98
    MOVWF   m10cnt

l10ms:;do{
    CALL    delay100us
    DECF    m10cnt;--m100cnt
    BNZ     l10ms      ;}while(i!=0);

    MOVLW   7;
    MOVWF   m10cnt;loop count m10cnt=7
using_10us:;do{
    CALL    delay10us
    DECF    m10cnt;--m100cnt
    BNZ     using_10us      ;}while(i!=0);
    NOP     ; 1 cycle delay
    NOP     ; 1 cycle delay
    NOP     ; 1 cycle delay
    NOP     ; 1 cycle delay
    RETURN; return
;}
;*****************************Delay 10ms****************************************

;*****************************Delay 100us***************************************
;{
delay100us:;
    MOVLW   49; load loop count value,set 49 loops
    MOVWF   u100cnt
l100us: ;do{
    NOP     ; 1 cycle delay
    NOP     ; 1 cycle delay
    DECF    u100cnt;--m100cnt
    BNZ     l100us;}while(i!=0);
    RETURN; return
;}
;*****************************Delay 100us***************************************


;*****************************Delay 10us****************************************
;{
delay10us:;
    MOVLW   4; load loop count value,set 4 loops
    MOVWF   u10cnt
l10us:
    ;do{
    NOP ; 1 cycle delay
    NOP ; 1 cycle delay
    DECF    u10cnt;--m100cnt
    BNZ     l10us;}while(i!=0);
    RETURN; return
;}
;*****************************Delay 10us****************************************

;*****************************Delay 16us****************************************
;{
delay6us:;
    MOVLW   2; load loop count value,set 2 loops
    MOVWF   u6cnt
l6us:
    ;do{
    NOP ; 1 cycle delay
    NOP ; 1 cycle delay
    DECF    u6cnt;--m100cnt
    BNZ     l6us;}while(i!=0);
    RETURN; return
;}
;*****************************Delay 16us****************************************

    end


