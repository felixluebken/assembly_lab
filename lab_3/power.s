#************************************************************************
#   PROGRAM NAME: In Out                                                
#   DESCRIPTION:  Demonstrates user input / output in x86-64 assembly . 
#   AUTHORS:      Felix Luebken & Taco Timmers                          
#************************************************************************


.text
titlestr:       .asciz "Felix Luebken, Taco Timmers\n2687994, 2809762\nAssignment 3: power\n"
promptbase:	.asciz "Please input the base: "
promptexp:	.asciz "Please input the exponent: "
inputfmt:	.asciz "%ld"
outputfmt:	.asciz "Your result: %ld\n"




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
	
	#prints assignment title
        movq    $0, %rax                #no vector registers for printf
        movq    $titlestr, %rdi         #load string titlestr
        call    printf                  #call printf subroutine

	#prints base prompt
	movq    $0, %rax                #no vector registers for printf
        movq    $promptbase, %rdi       #load string titlestr
        call    printf                  #call printf subroutine

	#input for base
	leaq	-16(%rbp), %rsi		#loads address 16 into rsi
	movq	$inputfmt, %rdi		#loads input format
	call	scanf			#call scanf

        #prints exponent prompt
        movq    $0, %rax                #no vector registers for printf
        movq    $promptexp, %rdi        #load string titlestr
        call    printf                  #call printf subroutine

	#input for exponent
	leaq	-8(%rbp), %rsi		#loads address 8 into rsi
	movq	$inputfmt, %rdi		#loads input format
	call	scanf			#call scanf
	

	call 	pow

	#prints result
	movq	%rax, %rsi		#moves result to rsi
        movq    $0, %rax                #no vector registers for printf
        movq    $outputfmt, %rdi        #load string titlestr
        call    printf                  #call printf subroutine


	#kill stack
	movq	%rbp, %rsp		#empties rbp
	popq	%rbp			#kills the stack

	jmp	end



#************************************************************************
#   SUBROUTINE:  pow
#   DESCRIPTION: calculates result from base and exponent
#   ARGS:	 base & exponent
#************************************************************************
pow:
	startloop:
		cmpq	$0, -8(%rbp)	#if power is 0
		je	endloop		#then break
			
		mulq	-16(%rbp)	#multiply base by itself
		decq	-8(%rbp)	#decrease exponent

		jmp	startloop	#reiterate the loop
	
	endloop:
		ret			#return

end:

        mov     $0, %rdi                #loads exit code
        call    exit                    #exits the program

