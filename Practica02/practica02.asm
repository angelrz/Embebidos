; PIC16F876A Configuration Bit Settings
CONFIG  FOSC = HS
CONFIG  WDTE = OFF
CONFIG  PWRTE = OFF
CONFIG  BOREN = ON
CONFIG  LVP = OFF
CONFIG  CPD = OFF
CONFIG  WRT = OFF
CONFIG  CP = OFF
#include <xc.inc>

; ============================
; Area de arranque deja 0x0000 para el bootlaoder
; ============================
PSECT AFTER_RST, class=CODE, delta=2
ORG 0x0005      

start:
    movlw high(vars)
    movwf PCLATH
    goto    vars
    
; ============================
; Definicion de constantes en Flash
; ============================
PSECT CONST, class=CODE, delta = 2
ORG 0x0100        
 
max: 
    retlw 100  
numeros: 
    addwf PCL, f
    retlw 0b11111100
    retlw 0b01100000
    retlw 0b11011010
    retlw 0b11110010
    retlw 0b01100110
    retlw 0b10110110
    retlw 0b10111110
    retlw 0b11100000
    retlw 0b11111110
    retlw 0b11110110
    
    
; ============================
; Codigo principal
; ============================
PSECT MAIN, class=CODE, delta=2
ORG 0x0500; Ubica el codigo fuera del area del bootloader
    
vars:  ; Variables en RAM    
    bcf STATUS, 5
    bcf STATUS, 6
    ; Direcciones
    cont1 EQU 0x20
    cont2 EQU 0X21
    cont3 EQU 0X22   
    actual EQU 0x23
    ; Inicializando variables
    call max
    movwf cont1
    movwf cont2
    movwf cont3
    movlw 0
    movwf actual
    
conf:    
    BANKSEL TRISB ; Banco 0
    CLRF TRISB
    BSF TRISC,2
    BSF TRISC,3
   
main:
    BANKSEL PORTB  
    
    movlw high(numeros)
    movwf PCLATH
    movlw 2
    call numeros
    movwf PORTB
    CALL retardo
    
    movlw high(numeros)
    movwf PCLATH
    movlw 9
    CALL numeros
    movwf PORTB
    call retardo
    
    movlw high(numeros)
    movwf PCLATH
    movlw 8
    CALL numeros
    movwf PORTB
    call retardo
    
    goto main
    


retardo:
    call max; devuelve 100 en W
    movwf cont3; cont3 = 100
cont2max:
    movwf cont2; cont2 = 100
cont1max:
    movwf cont1; cont1 = 100
    decfsz cont1
    goto $-1
    decfsz cont2
    goto cont1max
    decfsz cont3
    goto cont2max
RETURN

END
