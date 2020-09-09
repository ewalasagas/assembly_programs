TITLE Composite Numbers     (CS271_400_ealasagae_Program_4.asm)

; Author:	Elaine Alasagas
; Last Modified: 2/17/2019
; OSU email address: alasagae@oregonstate.edu
; Course number/section:	CS271/400
; Project Number:  Program #4               Due Date:	2/17/2019
; Description: This program asks the user for their name and for them to enter a number
	; between 1 and 400.  The program will then print out that many numbers that are composite.
	; I checked against numbers 2/3/5/7 to see if a composite exists.

INCLUDE Irvine32.inc

maxNum			EQU		1
minNum			EQU		400

.data

prgm_title		BYTE		"Welcome to calculating Composite Numbers" , 0
prgm_author		BYTE		"			Programmed by Elaine Alasagas ", 0
instru_1		BYTE		"Enter the number of composite nmbers you would like to see.",0
instru_2		BYTE		"I'll accept order for up to 400 composites.",0
user_name		BYTE		"What is your name? ", 0
hello			BYTE		"Hello, ",0
userName		SDWORD		33 DUP(0)		;String to be entered for user
hello2			BYTE		", it is nice to meet you! ",0
enterNum		BYTE		"Enter the number of composites to display [1 .. 400]: ",0
n				SDWORD		?		;integer input number to print the number of composites
error			BYTE		"Out of range.  Enter a number between [1, 400].",0
startNum		SDWORD		8		;increment and divide by , if remainder == 0, show composite
numTwo			SDWORD		2
numThree		SDWORD		3
numFive			SDWORD		5
numSev			SDWORD		7
remainder		SDWORD		?
count			SDWORD		1
not_comp		BYTE		"Number is not a composite.",0
goodbye_msg		BYTE		"Thanks for playing! ",0
quotient		SDWORD		0
space			SDWORD		"   ",0
countSpace		SDWORD		2		;counts numbers per line
initial			SDWORD		?

.code
main PROC
	call	introduction
	call	getUserData
	call	validate
	call	showComposites
	call	farewell

	exit	; exit to operating system

main ENDP

;Program title and instructions
introduction PROC
	mov		edx, OFFSET prgm_title
	call	WriteString
	mov		edx, OFFSET prgm_author
	call	WriteString
	call	CrLF
	call	CrLF
	mov		edx, OFFSET instru_1
	call	WriteString
	call	CrLF
	mov		edx, OFFSET instru_2
	call	WriteString
	call	CrLF
	ret
introduction ENDP

;Asking user for name and greeting
getUserData PROC			
	mov		edx, OFFSET user_name
	call	WriteString
	mov		edx, OFFSET user_name
	mov		ecx, 32
	call	ReadString
	call	CrLF
	mov		edx, OFFSET hello
	call	WriteString
	mov		edx, OFFSET user_name
	call	WriteString
	mov		edx, OFFSET hello2
	call	WriteString
	call	CrLF
	ret
getUserData ENDP

ErrorMsg:						;Prints an error message if out of bounds validation occurs the user input to be in [1, 400]
	mov		edx, OFFSET error
	call	WriteString
	call	CrLF

validate PROC					;CHceks whether number below 1 or above 400
	mov		edx, OFFSET enterNum
	call	WriteString
	call	ReadInt
	mov		n, eax				;Integer entered
	cmp		eax, maxNum			;chk if greater than 400
	jl		ErrorMsg
	cmp		eax, minNum			;chk if less than 1
	jg		ErrorMsg
	ret
validate ENDP
	
showComposites PROC				;showComposites - increment and divide and then show output if remainder is equal to 0
	mov		eax,numTwo			;Need initial number 4
	mov		ebx,numTwo			;Multipying 2 x 2 to get initial number 4 (and then increase count comparison)
	mul		ebx
	mov		initial,eax
	call	WriteDec
	mov		edx, OFFSET space
	call	WriteString
	mov		eax, count
	inc		count
	cmp		eax, n
	je		exitLoop			;Compare whether ready to exit program (catch if user enters 1)
	mov		eax,numTwo			;Need initial number 6 
	mov		ebx,numThree		;Multipying 2 x 3 to get initial number 6 (and then increase count comparison)
	mul		ebx
	mov		initial,eax
	call	WriteDec
	mov		edx, OFFSET space
	call	WriteString
	mov		eax, count
	inc		count
	cmp		eax, n
	je		exitLoop			;Compare whether ready to exit program  (catch if user enters 2)
isComposite:					;Print out loop if number is a composite number (checks against 2/3/5/7 if remainder is 0)
	mov		eax, startNum
	call	WriteDec
	mov		edx, OFFSET space
	call	WriteString
	inc		countSpace
	mov		eax, countSpace
	cmp		countSpace, 10
	jne		noNewLine
	call	Crlf
	mov		countSpace, 0
noNewLine:						;Need loop to skip "new-line" if numbers per line do not equal 10
	inc		startNum		
	mov		eax, count
	inc		count
	cmp		eax, n
	je		exitLoop			;Compare whether ready to exit program
Loop1:							;Main loop if no number has a remainder equal to 0
	mov		edx, 0
	mov		eax, numTwo			
	mov		eax, startNum		;check divisible by 2
	mov		ebx, numTwo
	div		ebx
	mov		quotient, eax
	mov		remainder, edx
	cmp		remainder, 0	
	je		isComposite
	mov		edx, 0
	mov		eax, numThree 
	mov		eax, startNum		;check divisible by 3
	mov		ebx, numThree
	div		ebx
	mov		quotient, eax
	mov		remainder, edx
	cmp		remainder, 0		
	je		isComposite			;Loop back to print composite number
	mov		edx, 0
	mov		eax, numFive		;check divisible by 5
	mov		eax, startNum		
	mov		ebx, numFive
	div		ebx
	mov		quotient, eax
	mov		remainder, edx
	cmp		remainder, 0	
	je		isComposite			;Loop back to print composite number
	mov		edx, 0
	mov		eax, numSev			;check divisible by 7
	mov		eax, startNum		
	mov		ebx, numSev
	div		ebx
	mov		quotient, eax
	mov		remainder, edx
	cmp		remainder, 0	
	je		isComposite			;Loop back to print composite number
	mov		eax, startNum
	inc		startNum
	cmp		eax, n
	je		exitLoop			;to break out of loop
	jmp		Loop1
exitLoop:
	ret
showComposites ENDP


;end program
farewell PROC
	call	Crlf
	mov		edx, OFFSET goodbye_msg	
	call	WriteString
	ret
farewell ENDP

END main
