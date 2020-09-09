TITLE Fibonacci numbers    (alasagae_prgm2.asm)

; Author:	Elaine Alasagas
; Last Modified:	01/24/2019
; OSU email address:	alasagae@oregonstate.edu
; Course number/section:	CS271/400
; Project Number: Program #2			Due Date: 01/27/2019
; Description: This program will introduce executes the Fibonacci sequence by getting
;				n number of terms from the user between values 1-46.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
; (insert variable definitions here)
prgm_title		BYTE	"Fibonacci Numbers                 ",0
intro			BYTE	"                    Programmed by Elaine Alasagas",0
intro_1			BYTE	"What's your name?  ", 0
hello			BYTE	"Hello, ",0
userName		BYTE	33 DUP(0)		;String to be entered for user
intro_2			BYTE	"Enter the number of Fibonacci terms to be displayed.",0
intro_3			BYTE	"Give the numer as an integer within range 1-46.",0
question1		BYTE	"How many Fibonacci terms do you want?  ",0
n 	DWORD	?
count			DWORD	0
maxNum			DWORD	46
space			BYTE	"  ",0
error			BYTE	"Out of range.  Enter a number between 1-46.",0
end1			BYTE	"Results certified by Elaine Alasagas.",0
farewell			BYTE	"Goodbye, ",0

.code
main PROC
;Introductions: display program title and name 
	mov		edx, OFFSET prgm_title
	call	WriteString
	mov		edx, OFFSET intro
	call	WriteString
	call	CrLF
	call	CrLF
	mov		edx, OFFSET intro_1
	call	WriteString

;Get user's name
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString
	call	CrLF
	mov		edx, OFFSET hello
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLF

;User instruction
	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLF
	mov		edx, OFFSET intro_3
	call	WriteString
	call	CrLF
	call	CrLF

;Display Fibs: jump back to question if number entered out of range
displayFibs:	
	mov		edx, OFFSET question1
	call	WriteString
	call	ReadInt

;Get user data
	mov		n, eax
	cmp		eax, maxNum		;if greater than 46, jump to error message
	jg		message
	cmp		eax, 0			;if less than 0, jump to error message
	jl		message
	cmp		eax, 0			;if equal to 0, jump to error message
	je		message
	jmp		continue	
message:		
	mov		edx, OFFSET error
	call	WriteString
	call	CrLF
	jmp		displayFibs

;Calculate fibonacci sequence
continue:
	mov		ecx, n 				;Number of times to execute loop
	mov		eax, 0				;a = 0
	mov		ebx, 1				;b = 1
	mov		eax, count			;counter for every 5 terms

addLine:
	call	CrLF
	mov		count, 0

fibonacci:
	mov		edx, eax			;use edx as 'temp' 
	add		edx, ebx			;a + b = temp
	mov		eax, ebx			;a = b
	mov		ebx, edx			;b = temp
	call	WriteDec
	mov		edx, OFFSET space
	call	WriteString
	inc		count					;Write 5 terms per line
	cmp		count, 5
	je		addLine
	loop	fibonacci
	call	CrLF

;Farewell: Goodbye message
	call	CrLF
	mov		edx, OFFSET end1
	call	WriteString
	call	CrLF
	mov		edx, OFFSET farewell
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLF

	exit	; exit to operating system
main ENDP


; (insert additional procedures here)

END main
