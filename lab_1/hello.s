#************************************************************************
#   PROGRAM NAME: Hello World						
#   DESCRIPTION:  Your standard hello world program in x86-64 assembly.	
#   AUTHORS: 	  Felix Luebken & Taco Timmers				
#************************************************************************

.text
str:	.asciz	"Felix Luebken, Taco Timmers\n2687994, 2709762\nAssignment 1: hello\n"

.global main
#************************************************************************
#   SUBROUTINE:   main							
#   DESCRIPTION:  prints str and exits 				
#************************************************************************
main:
	pushq	%rbp			#store the caller's base pointer
	movq	%rsp, %rbp		#initialize the base pointer
	
	movq	$0, %rax		#no vector registers for printf
	movq	$str, %rdi		#load string str
	call	printf			#call printf subroutine
	jmp	end			#call end subroutine

end:
	mov	$0, %rdi		#loads exit code
	call	exit			#exits the program
