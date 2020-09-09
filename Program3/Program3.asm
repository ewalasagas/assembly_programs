TITLE Negative Number Accumulator      (template.asm)

; Author:	Elaine Alasagas
; Last Modified:	02/10/2019
; OSU email address:	alasagae@oregonstate.edu
; Course number/section:	CS271/400
; Project Number: Program #2			Due Date: 02/10/2019
; Description: This program asks the user to enter a number between [-100, -1].  It counts
;	and checks whether valid number is entered.  It adds the sum of the numbers entered and
;	then returns the rounded-integer value of the average.

INCLUDE Irvine32.inc

; (insert constant definitions here)
 
.data

prgm_title		BYTE		"Welcome to the Negative Number Accumulator" , 0
prgm_author		BYTE		"			Author: Elaine Alasagas ", 0
user_name		BYTE		"What is your name? ", 0
hello			BYTE		"Hello, ",0
instru_1		BYTE		"Please enter numbers in [-100, -1]. ",0
instru_2		BYTE		"Enter a non-negative number when you are finished to see results. ",0
enterNum		BYTE		"Enter number: ",0
end_num1		BYTE		"You entered ",0
end_num2		BYTE		" valid numbers." ,0
sum_txt			BYTE		"The sum of your valid numbers is ",0
avg_txt			BYTE		"The rounded average is ",0
end_prgm		BYTE		"Thank you for playing! It's been a pleasure to meet you, ",0
userName		DWORD		33 DUP(0)		;String to be entered for user
maxNum			SDWORD		1
minNum			SDWORD		100
error			BYTE		"Out of range.  Enter a number between [-100, -1].",0
n				SDWORD		?		;integer input number 
count			SDWORD		0		;count how many numbers entered
sum				SDWORD		0
avg				SDWORD		0
remainder		SDWORD		0

.code
main PROC

;Introductions: display program title and name 
	mov		edx, OFFSET prgm_title
	call	WriteString
	mov		edx, OFFSET prgm_author
	call	WriteString
	call	CrLF
	call	CrLF
	mov		edx, OFFSET user_name
	call	WriteString

;Get user's name
	mov		edx, OFFSET user_name
	mov		ecx, 32
	call	ReadString
	call	CrLF
	mov		edx, OFFSET hello
	call	WriteString
	mov		edx, OFFSET user_name
	call	WriteString
	call	CrLF

;Display instructions for user
	mov		edx, OFFSET instru_1
	call	WriteString
	call	CrLF
	mov		edx, OFFSET instru_2
	call	WriteString
	call	CrLF

;set negative numbers of max and min range
	neg		maxNum
	neg		minNum
	mov		eax, count	

;Repeatedly prompt the user to enter a number.  
EnterNumber:
	mov		edx, OFFSET enterNum
	call	WriteString
	call	ReadInt
	mov		n, eax				;Integer entered
	jmp		Validate

;Count and accumulate the valid user numbers until a non-negative number is entered 
Validate:
	cmp		eax, maxNum			;Break out of loop if n is positive number
	jg		PrintSum
	cmp		eax, minNum			;chk if less than -100
	jl		ErrorMsg
	inc		count
	mov		eax, sum
	add		eax, n
	mov		sum, eax
	mov		eax, sum
	jmp		EnterNumber

;Validate the user input to be in [-100, -1]
ErrorMsg:
	mov		edx, OFFSET error
	call	WriteString
	call	CrLF
	jmp		EnterNumber		

;Round avergae 
RoundAverage:
	dec		avg
	jmp		PrintAverage

;End of the program
PrintSum:
	mov		edx, OFFSET end_num1
	call	WriteString
	mov		eax, count
	call	WriteDec
	mov		edx, OFFSET end_num2
	call	WriteString
	call	Crlf
	mov		edx, OFFSET sum_txt	
	call	WriteString
	mov		eax, sum
	call	WriteInt
	call	CrLF

;Calculate the average 
	mov		edx, 0
	mov		eax, sum
	cdq
	mov		ebx, count
	idiv	ebx
	mov		avg, eax
	mov		remainder, edx

;Check if remainder is even (if even round up, else no increment)
	mov		edx, 0
	mov		eax, remainder
	neg		remainder
	cdq
	mov		ebx, 2
	idiv	ebx
	mov		remainder, eax
	cmp		remainder, 0
	jne		RoundAverage

;Prints the average after checking if rounded up or not 
PrintAverage:
	mov		edx, OFFSET avg_txt		
	call	WriteString
	mov		eax, avg
	call	WriteInt
	call	CrLF

	mov		edx, OFFSET end_prgm		
	call	WriteString
	mov		edx, OFFSET user_name
	call	WriteString
	call	CrLF

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
