; PIC16F876A Configuration Bit Settings
CONFIG FOSC = HS    ; Usar oscilador externo HS (High-Speed Crystal)
CONFIG WDTE = OFF   ; Desactivar Watchdog Timer
CONFIG PWRTE = OFF  ; Desactivar Power-Up Timer
CONFIG BOREN = ON   ; Activar Brown-Out Reset
CONFIG LVP = OFF    ; Desactivar Low-Voltage Programming
CONFIG CPD = OFF    ; Desactivar Data Memory Code Protection
CONFIG WRT = OFF    ; Desactivar Flash Memory Write Protection
CONFIG CP = OFF	    ; Desactivar Flash Memory Code Protection

#include <xc.inc>
; ============================
; �rea de arranque (bootloader salta aqu�)
; ============================
PSECT AFTER_RST, class=CODE, delta=2
ORG 0x0008 ; Direcci�n despu�s del espacio de reset (0x0000)
start:
    goto conf; Saltar a configuraci�n inicial

PSECT CONST, class=CODE, delta=2
ORG 0x0010 
; ============================
; C�digo principal
; ============================
PSECT MAIN, class=CODE, delta=2
ORG 0x0500               ; Inicio del programa principal

; COMPLETA: Asigna todo el puerto B como salida
conf:
    banksel TRISB
    clrf TRISB

; COMPLETA: Asigna un d�gito (0-9) al display de 7 segmentos
main:
    banksel PORTB
    ;movlw 0b11111100; 0 
    movlw 0b01100000; 1 
    ;movlw 0b11011010; 2 
    ;movlw 0b11110010; 3 
    ;movlw 0b01100110; 4 
    ;movlw 0b10110110; 5 
    ;movlw 0b10111110; 6 
    ;movlw 0b11100000; 7 
    ;movlw 0b11111110; 8 
    ;movlw 0b11110110; 9 
    movwf PORTB
END
    