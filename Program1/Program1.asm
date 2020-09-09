TITLE Elementary Arithmetic    (alasagae.asm)

; Author: Elaine Alasagas
; Last Modified: 1/15/2019
; OSU email address: alasagae@oregonstate.edu
; Course number/section: CS271/400
; Project Number: Program #1			Due Date: 01/20/2019
; Description: This program will introduce the programmer and title and will get two numbers from the 
;				user and will calculate and display the sum, difference, product, (integer) quotient
;				and remainder of the two numbers.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
userName		BYTE	33 DUP(0)		;string to be entered by user
prgm_title		BYTE	"Elementary Arithmetic				by Elaine Alasagas", 0	
intro_1			BYTE	"Hello! What is your name? ", 0
intro_2			BYTE	"Hello ", 0
intro_3			BYTE	"! I am Elaine and I'd like for you to enter 2 numbers.", 0
intro_4			BYTE	"I will show you the sum, difference, product, quotient and remainder.", 0
prompt_1		BYTE	"First number: ", 0
firstNum		DWORD	?
prompt_2		BYTE	"Second number: ", 0
secondNum		DWORD	?
goodBye_1		BYTE	"Thanks for particpating!", 0
goodBye_2		BYTE	"Good-bye! ", 0
sum				DWORD	0
difference		DWORD	0
product			DWORD	0
quotient		DWORD	0
remainder		DWORD	0
equal			BYTE	" = ",0
multiply		BYTE	"x",0
divide			BYTE	"/",0
remain_prompt	BYTE	"Remainder: ",0
goodBye_3		BYTE	"Try again! First number MUST be larger than the second number. ", 0

.code
main PROC
;INTRODUCTION
;Introduce your name and the program title 
	mov		edx, OFFSET prgm_title
	call	WriteString
	call	CrLF
	call	CrLF

;Get user name
	mov		edx, OFFSET intro_1
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString
	call	CrLF
	mov		edx, OFFSET intro_2		
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString

;Read instructions
	mov		edx, OFFSET intro_3
	call	WriteString
	call	CrLF
	mov		edx, OFFSET	intro_4
	call	WriteString
	call	CrLF

;Prompt user to enter two numbers
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt				;User enters first number
	mov		firstNum, eax		;Moving first number to EAX

	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt				;User enters second number
	mov		secondNum, eax		;Moving second number to EAX

;Compare firstnum and secondnum
	mov		eax, firstNum
	mov		ebx, secondNum
	cmp		ebx, eax			;Compare if secondNum is larger than firstNum
	ja		Larger				;End program if true
	
;Calculate the sum and print
   mov		eax,firstNum
   add		eax,secondNum
   mov		sum, eax

;Display sum calculation
   mov		eax,firstNum
   call		WriteDec
   mov		eax,secondNum
   call		WriteInt
   mov		edx, OFFSET equal
   call		WriteString
   mov		eax,sum
   call		WriteDec
   call		CrLF

;Calculate the difference - second number subtracts first number
	mov		eax,firstNum
	sub		eax,secondNum
	mov		difference,eax

;Display subtraction calculation
	mov		eax,firstNum 
	call	WriteDec
	mov		eax,secondNum
	neg		eax
	call	WriteInt
	mov		edx, OFFSET equal
	call	WriteString
	mov		eax,difference
	call	WriteDec
	call	CrLF


;Calculate product 
	mov		eax,firstNum
	mov		ebx,secondNum
	mul		ebx
	mov		product,eax
	mov		eax,product

;Display product 
	mov		eax,firstNum
	call	WriteDec
	mov		edx, OFFSET multiply
	call	WriteString
	mov		eax,secondNum
	call	WriteDec
	mov		edx, OFFSET equal
	call	WriteString
	mov		eax,product
	call	WriteDec
	call	CrLF

;Display division
	mov		eax,firstNum 
	call	WriteDec
	mov		edx, OFFSET divide
	call	WriteString
	mov		eax,secondNum
	call	WriteDec
	mov		edx, OFFSET equal
	call	WriteString

;Calculate/display 
	mov		edx,0
	mov		eax,secondNum		 
	mov		eax,firstNum
	mov		ebx,secondNum
	div		ebx
	mov		quotient, eax
	mov		remainder,edx
	call	WriteDec	
	call	CrLF

;Print the remainder
	mov		edx, OFFSET remain_prompt
	call	WriteString
	mov		eax,remainder
	call	WriteDec
	call	CrLF
	call	CrLF


;Goodbye
	mov		edx, OFFSET goodBye_1
	call	WriteString
	call	CrLF
	mov		edx, OFFSET goodBye_2
	call	WriteString
	call	CrLF

	exit	; exit to operating system
main ENDP

;Executes if second number larger than first number
Larger:
	call	CrLF
	mov		edx, OFFSET goodBye_3
	call	WriteString
	call	CrLF
	mov		edx, OFFSET goodBye_1
	call	WriteString
	call	CrLF
	
; (insert additional procedures here)

END main
