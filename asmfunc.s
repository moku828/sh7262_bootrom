.global boot_mode1
/*-------------------------------------*/
/* Bootstrap code                      */
/*-------------------------------------*/

.section .text, "ax"

boot_mode1:
	MOV.L	stack_boot, R15
/*	MOV.L	fpscr_init, R0*/
/*	LDS	R0, FPSCR*/
	MOV.L	fp_main, R0
	JMP	@R0
	NOP

	.align
fp_main:
	.long	_main
stack_boot:
	.long	0xFFF83000
/*fpscr_init:*/
/*	.long	0x00040001*/

