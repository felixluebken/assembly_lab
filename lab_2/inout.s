#************************************************************************
#   PROGRAM NAME: In Out                                   	        
#   DESCRIPTION:  Demonstrates user input / output in x86-64 assembly . 
#   AUTHORS:      Felix Luebken & Taco Timmers                          
#************************************************************************


.text
titlestr:    	.asciz "Felix Luebken, Taco Timmers\n2687994, 2809762\nAssignment 2: inout\n"
prompt:	        .asciz "Please input a number: "
inputfmt:   	 .asciz "%ld"
outputfmt:  	 .asciz "Your incremented number: %ld\n"




.global main
#************************************************************************
#   SUBROUTINE:   main                                                  
#   DESCRIPTION:  main routine 	                                        
#************************************************************************
main:
        pushq   %rbp                    #store the caller's base pointer
        movq    %rsp, %rbp              #initialize the base pointer

        movq    $0, %rax                #no vector registers for printf
        movq    $titlestr, %rdi         #load string titlestr
        call    printf                  #call printf subroutine

	call 	inout			#call inout subroutine

#	jmp 	end

#************************************************************************
#   SUBROUTINE:	 inout
#   DESCRIPTION: prints a incremented prompted number
#************************************************************************
inout:
	pushq	%rbp			#store the caller's base pointer
	movq	%rsp, %rbp		#initialize the base pointer
	subq	$16, %rsp		#resize the stack
	
	movq	$0, %rax		#no vector registers for printf
	movq	$prompt, %rdi		#load string promt
	call	printf			#call printf

	leaq	-16(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputfmt, %rdi		#loads inputfmt
	call	scanf			#call scanf

	movq 	-16(%rbp), %rbx		#moves variable into rbx
	incq	%rbx			#increments variable
	movq	%rbx, %rsi		#moves variable into rsi

	movq    $0, %rax                #no vector registers for print
	movq 	$outputfmt, %rdi	#load string outputfmt
	call	printf			#call printf

#	ret

	jmp	end

end:
        
	mov     $0, %rdi                #loads exit code
        call    exit                    #exits the program



