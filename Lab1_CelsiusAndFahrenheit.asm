%include "..\My_Macros.inc"
; Description: Convert Fahrenheit to Celsius
;              and Celsius to Fahrenheit
; Source File: Lab1_CelsuisToFahrenheit.asm
;  Data Files: NA
;      Author: Taylor Converse
;Date Created: February 5, 2019

    segment .data
        Celsius     dq  0      ; Celsius Operand
        Fahrenheit  dq  100    ; Fahrenheit Operand
        Conversion  dq  0      ; 
        Thirtytwo   dq  32 
        Five        dq  5
        Nine        dq  9


        Yolo        db  "Your current number is %i",0x0a,0

        ; Just creating some output here :)
        lineOne     db  "Fahrenheit TO Celsius Conversion",\
                        0x0a,"%i degrees F = %i degrees C",\
                        0x0a,"By:    Taylor Converse",0x0a,0x0a,0x0a,0
        lineTwo     db  0x0a,"Celsius TO Fahrenheit Conversion",\
                        0x0a,"%i degrees C = %i degrees F",\
                        0x0a,"By:    Taylor Converse",0x0a,0

    segment .text
        global   main        ;Tell the Linker about the main() entry point
        extern  printf       ;Reference "C" printf() function

main:
        push  rbp            ;Save CURRENT RBP on the STACK
        mov   rbp, rsp       ;Store the current RSP (stack pointer) register
                             ;value in the RBP register
        sub   rsp, 40        ;MUST create room for at least the 4 possible
                             ;parameters in a function call that are stored
                             ;in dedicated registers (rcx,rdx,r8,r9).
                            ;These stack locations are referred to as the
                            ;'shadow stack space' occupying (32 bytes MINIMUM)
                            ;on the program's stack at runtime.
         
        ; Save incoming registers on the stack 
        pushregs  rbx,rsi,rdi,r10,r11,r12,r13,r14,r15
        
        xor   rax,rax           ;Clear the RAX register
        xor   rdx,rdx           ;Clear the RDX register
;+------------------------------------------------------------------+
;|                      Fahrenheit to Celsius                       |
;+------------------------------------------------------------------+
        ;subtract Thirtytwo from Fahrenheit
        mov   rax,[Fahrenheit]  ; Place the Fahrneheit unit in rax
        sub   rax,[Thirtytwo]   ; Wtf

        ;multiply by 5
        mov   r12,[Five]
        mul   r12

        ;divide by 9
        mov   r12,[Nine]
        div   r12

;Just testing where I am at in the code

;        lea   rcx,[Yolo]
;        mov   rdx,rax
;        call  printf

        ; Print conversion from 100 degrees Fahrenheit to Celsius
        lea   rcx,[lineOne]
        mov   rdx,[Fahrenheit]
        mov   r8,rax
        call  printf

        xor   rax,rax
        xor   rcx,rcx
        xor   rdx,rdx
        xor   r8,r8

;+------------------------------------------------------------------+
;|                      Celsius to Fahrenheit                       |
;+------------------------------------------------------------------+

        ;Initializing values for new set of calculations
        mov ax, 100
        mov [Celsius],ax
        mov ax, 30
        mov [Fahrenheit],ax

        ;multiply celsius * 9
        mov rax,[Celsius]
        mov r12,[Nine]
        mul r12

        ;divide celsius / 9
        mov r12,[Five]
        div r12

        ;add 32 to celsius calculation
        add rax,[Thirtytwo]

        ;printing Celsius to Fahrenheit
        lea   rcx,[lineTwo]
        mov   rdx,[Celsius]
        mov   r8,rax
        call  printf

        ;Restore values of incoming registers that were saved on
        ;the stack by the pushregs macro 
        popregs  rbx,rsi,rdi,r10,r11,r12,r13,r14,r15

        add   rsp,40         ;Revise stack to undo Line #39
        xor   rcx,rcx        ;0 return = success
        leave
        ret