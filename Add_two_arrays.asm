/*
 * Add_two_arrays.asm
 *
 *  Created: 2014-10-22 17:42:21
 *   Authors: Adrian Mrowiec && Grzegorz Wojda
 */ 


#include "m32def.inc"

; Rozmiar stały 
.EQU LEN = 0x00  

; Segment danych
.DSEG 

; Dwie tablice o rozmiarze stałym
tab1: .BYTE LEN
tab2: .BYTE LEN

; Segment kodu
.CSEG 
; Wyczyszczenuie wszystkich flag 
CLC 

; Wypełniamy rejestr 18 jedynkami 
LDI R18,0xff

; Rejestr X wykorzystujemy jako wskaznik pierwszej tablicy
LDI XL, LOW(tab1) 
LDI XH, HIGH(tab1)

; Rejestr Y wykorzystujemy jako wskaznik do drugiej tablicy
LDI YL, LOW(tab2)
LDI YH, HIGH(tab2)

; Wpisujemy wielkosc tablic do rejestru Z
LDI ZL, LOW(LEN)
LDI ZH, HIGH(LEN)

; Poczatek petli
LOOP:

; Sprawdzamy czy pierwsa połówka Z jest różna od 0
CPI ZL,0
; Jeśli jest różna to napewno musimy jeszcze kontynuować 
BRNE AFTER_IF
; Jeśli jest równa 0 to sprawdzamy drugą połówkę
CPI ZH,0
BREQ END_LOOP


AFTER_IF:
; Do rejestru 16 wpisujemy wartosc wskazywana przez X i przesuwamy i na kolejny bajt
LD R16,X+
; Do rejestru 17 wpisujemy wartos wskazywana przez Y
LD R17,Y
; Dodanie wartości rejestrow:
; czyszczenie flagi carry
CLC
; odzyskanie poprzedniej wartosci flagi carry
ADD R14, R18
; Dodajemy rejestry
ADC R17, R16

; zapisanie wartosci carry
CLR R14
ADC R14, R0

; Wpisanie wartosci dodanej do komorki wskazywanej przez Y i przesuniecie wskaznika Y na kolejny bajt
ST Y+,R17

; Z--
CLC
SBCI ZL, 1
SBCI ZH, 0

CLZ
; Koniec petli
RJMP LOOP

; koniec
END_LOOP:
RJMP END_LOOP
