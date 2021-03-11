#************************************************************************
#   PROGRAM NAME: In Out                                                
#   DESCRIPTION:  Demonstrates user input / output in x86-64 assembly . 
#   AUTHORS:      Felix Luebken & Taco Timmers                          
#************************************************************************


.text
titlestr:       .asciz "Felix Luebken, Taco Timmers\n2687994, 2809762\nAssignment 4: factorial\n"
prompt:         .asciz "Please input a number: "
inputfmt:        .asciz "%ld"
outputfmt:       .asciz "Your factorial: %ld\n"

.global main
#************************************************************************
#   SUBROUTINE:   main                                                  
#   DESCRIPTION:  main routine                                          
#************************************************************************
main:
	#initialize stack
        pushq   %rbp                    #store the caller's base pointer
        movq    %rsp, %rbp              #initialize the base pointer
	subq	$16, %rsp		#resize the stack


        movq    $0, %rax                #no vector registers for printf
        movq    $titlestr, %rdi         #load string titlestr
        call    printf                  #call printf subroutine

        call    inout                   #call inout subroutine

	#kill stack
	movq	%rbp, %rsp		#empties rbp
	popq	%rbp			#kills the stack

        jmp     end

#************************************************************************
#   SUBROUTINE:  inout
#   DESCRIPTION: requests a number
#************************************************************************
inout:
        #initialize stack
        pushq   %rbp                    #store the caller's base pointer
        movq    %rsp, %rbp              #initialize the base pointer
        subq    $16, %rsp               #resize the stack

        movq    $0, %rax                #no vector registers for printf
        movq    $prompt, %rdi           #load string promt
        call    printf                  #call printf

        leaq    -8(%rbp), %rsi          #load address of stack var in rsi
        movq    $inputfmt, %rdi         #loads inputfmt
        call    scanf                   #call scanf

        movq    -8(%rbp), %rax		#loads value in rax

	call	factorial		#call factorial

	movq	%rax, %rsi		#move rax into rsi
	movq	$0, %rax		#no vector registers for printf
	movq	$outputfmt, %rdi	#loads string outputfmt
	call	printf			#call printf

        #kill stack
        movq    %rbp, %rsp		#empties rbp
        popq    %rbp			#kills the stack

	jmp	end

#************************************************************************
#   SUBROUTINE:  factorial
#   DESCRIPTION: recursively calculates factorial in rax
#************************************************************************
factorial:
	cmpq	$1, -8(%rbp)		#if value is 1
	je	break			#then jump to break

	cmpq	$0, -8(%rbp)		#if vvalue is 0
	je	break			#then jump to break

	decq	-8(%rbp)		#decrease value by 1
	mulq	-8(%rbp)		#multiply rax by value

	call 	factorial		#iterate again via recursion


	break:				#break function
		ret			#return
	


end:

        mov     $0, %rdi                #loads exit code
        call    exit                    #exits the program

