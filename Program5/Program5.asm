TITLE Sorting Random Integers      (CS271_400_ealasagae_Program_5.asm)

; Author:	Elaine Alasagas
; Last Modified: 3/5/3019
; OSU email address: alasagae@oregonstate.edu
; Course number/section:	CS271/400
; Project Number:  Program #4               Due Date:	3/3/2019
; Description: This program asks the user for their name and then how many random integers
	; between 10 and 200 that they would like (random integers between 100 and 999).  Then 
	; the program prints the unsorted list of numbers, then the median and then the sorted 
	; numbers.

INCLUDE Irvine32.inc

	maxNum = 200		;constant
	minNum	= 10
	highNum	= 999
	lowNum	= 100

.data

prgm_title		BYTE		"Welcome to Sorting Random Integers " , 0
prgm_author		BYTE		"			Programmed by Elaine Alasagas ", 0
instru_1		BYTE		"This program generates random numbers in the range [100 ... 999],",0
instru_2		BYTE		"displays the original list, sorts the list, and calculates the ",0
instru_3		BYTE		"median value. Finally, it displays the list sorted in descending order.",0

user_name		BYTE		"What is your name? ", 0
hello			BYTE		"Hello, ",0
userName		SDWORD		33 DUP(0)		;String to be entered for user
hello2			BYTE		", it is nice to meet you! ",0

enterNum		BYTE		"How many numbers should be generated? [10 ... 200]: ",0	;numbers to be generated
randNums		SDWORD		?		;# integers to be generated 
error			BYTE		"Out of range.  Enter a number between 10 and 200.",0		;input validation

goodbye_msg		BYTE		"Thanks for playing! ",0
array			SDWORD		maxNUM DUP(?)
sortedList		BYTE		"The sorted list: ", 0
unsortedList	BYTE		"The unsorted random numbers: ",0
the_median		BYTE		"Median: ",0
space			SDWORD		"   ",0

.code
main PROC
	call	Randomize
	call	introduction	;title and isntructions
	call	getName		;this is just to get user name
	push	OFFSET randNums		;ebp + 4 register
	call	getData			;esp register
	push	OFFSET array	;esp + 8 
	push	randNums		
	call	fillArray		;fill array
	push	OFFSET array
	push	randNums
	push	OFFSET unsortedList		;display array
	call	display
	push	OFFSET	array
	push	randNums
	call	sort			;display sorted integers
	push	OFFSET array
	push	randNums
	call	displayMed
	push	OFFSET array
	push	randNums
	push	OFFSET sortedList
	call	display
	call	CrLF
	call	farewell
	exit	; exit to operating system
main ENDP

;***************************************************
;INTRODUCTION:  
;prints out title and user instruction
;***************************************************
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
	mov		edx, OFFSET instru_3
	call	WriteString
	call	CrLF
	call	CrLF
	ret
introduction ENDP

;***************************************************
;GET NAME:  
;Asks users name and greeting
;***************************************************
getName PROC			
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
	call	CrLF
	ret
getName ENDP

;***************************************************
;GET DATA:  
;asks users for integer input to display how many random 
;integers to generate and passes info through registers
;***************************************************
getData PROC
	push	ebp
	mov		ebp, esp
	mov		ebx, [ebp + 8]
	jmp		getNum

ErrorMsg:						;Prints an error message if out of bounds validation occurs the user input to be in [1, 400]
	mov		edx, OFFSET error
	call	WriteString
	call	CrLF
	jmp		getNum

getNum:
	mov		edx, OFFSET enterNum
	call	WriteString
	call	ReadInt
	cmp		eax, maxNum			;chk if greater than 
	jg		ErrorMsg
	cmp		eax, minNum			;chk if less than 
	jl		ErrorMsg

	mov		[ebx], eax
	pop		ebp
	call	CrLF
	ret		4					;clears the stack
getData ENDP

;***************************************************
;FILL ARRAY:  
;puts random integer value into array by reference 
;***************************************************
fillArray PROC
	push	ebp				;ebp onto stack
	mov		ebp, esp		;point ebp -> esp + 4
	mov		edi, [ebp + 12]	
	mov		ecx, [ebp + 8]

nextNum:					;generating random integer
	mov		eax, highNum
	sub		eax, lowNum
	inc		eax
	call	RandomRange
	add		eax, lowNum
	mov		[edi], eax
	add		edi, 4
	loop	nextNum
	pop		ebp
	ret		8
fillArray ENDP

;***************************************************
;DISPLAY LIST:  
;displays the unsorted value of integers through 
;address
;***************************************************
display PROC
	push	ebp
	mov		ebp, esp
	mov		ecx, [ebp + 12]		;counter 
	mov		esi, [ebp + 16]		;location of array
	mov		ebx, 0
	call	CrLF
	mov		edx, [ebp + 8]		;print display
	call	WriteString
	call	CrLF

current:						;gets current value
	cmp		ebx, 10				;counter to check if 10 per line
	je		nextLine
	mov		eax, [esi]			
	call	WriteDec
	add		esi, 4
	mov		edx, OFFSET space	
	call	WriteString
	inc		ebx
	loop	current
	jmp		last
		
nextLine:
	call	CrLF
	mov		ebx, 0
	jmp		current

last:
	pop		ebp
	ret		12
display ENDP

;***************************************************
;SORT LIST: 
;sorts the list of random integers (largest to smallest)
;by array address
;***************************************************
sort PROC
	push	ebp
	mov		ebp, esp
	mov		ecx, [ebp + 8]
	dec		ecx

out_loop_count:				;loop counter outer
	push	ecx
	mov		esi, [ebp + 12]

in_loop_count:				;array value
	mov		eax, [esi]
	cmp		[esi + 4], eax
	jl		move_next
	xchg	eax, [esi + 4]
	mov		[esi], eax

move_next:					;if count = 0, move array or end
	add		esi, 4
	loop	in_loop_count

	pop		ecx
	loop	out_loop_count

end_loop:
	pop		ebp
	ret		8
	ret
sort ENDP

;***************************************************
;DISPLAY MEDIAN: 
;Splits the number of intgers in half to find the middle
;and then finds and displays the median value
;***************************************************
displayMed PROC
	push	ebp
	mov		ebp, esp
	mov		eax, [ebp+8]
	mov		esi, [ebp+12]
	mov		edx, 0
				
	mov		ebx, 2		;find middle	
	div		ebx
	cmp		edx, 0
	je		middle

	mov		ebx, 4		;find middle array
	mul		ebx
	add		esi, eax
	mov		eax, [esi]
	jmp		display_median

display_median:			;display middle value
	call	CrLF
	call	CrLF
	mov		edx, OFFSET the_median
	call	WriteString
	call	WriteDec
	call	CrLF
	call	CrLF
	jmp		endCall

middle:	
	mov		ebx, 4		;find position of high val via address
	mul		ebx
	add		esi, eax
	mov		edx, [esi]

	mov		eax, esi
	sub		eax, 4		;find position of low val via address
	mov		esi, eax
	mov		eax, [esi]

	add		eax, edx
	mov		edx, 0
	mov		ebx, 2
	div		ebx
	jmp		display_median

endCall:
	pop		ebp
	ret		8
displayMed ENDP

;***************************************************
;FAREWELL: 
;end program goodbye message
;***************************************************
farewell PROC
	call	Crlf
	mov		edx, OFFSET goodbye_msg	
	call	WriteString
	ret
farewell ENDP

END main
