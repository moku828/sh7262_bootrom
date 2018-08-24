.global test_start

.section .text, "ax"

test_start:
        /* setup */
	MOV.L	value, R1
	MOV.L	valuew, R2
        MOV.L   _test_bitop, R0
        JSR     @R0
        NOP
        MOV     R12, R0
        CMP/EQ  #0, R0
        BF      test_failed
        NOP
        MOV.L   _test_datatrans, R0
        JSR     @R0
        NOP
        MOV     R12, R0
        CMP/EQ  #0, R0
        BF      test_failed
        NOP
        MOV.L   _test_sysctrl, R0
        JSR     @R0
        NOP
        MOV     R12, R0
        CMP/EQ  #0, R0
        BF      test_failed
        NOP
        MOV.L   _test_bra, R0
        JSR     @R0
        NOP
        MOV     R12, R0
        CMP/EQ  #0, R0
        BF      test_failed
        NOP
        BRA     test_succeed
        NOP

	.align  4
_test_bitop:
        .long   test_bitop
_test_datatrans:
        .long   test_datatrans
_test_sysctrl:
        .long   test_sysctrl
_test_bra:
        .long   test_bra

test_succeed:
        BRA     test_succeed
        NOP

test_failed:
        BRA     test_failed
        NOP

	.align  4
value:
        .long   _value
valuew:
        .long   _valuew
_value:
	.byte	0x00
	.byte	0x20
	.byte	0x00
	.byte	0x00

.section .bss, "aw"
_valuew:
	.byte	0x00
	.byte	0x00
	.byte	0x00
	.byte	0x00

.section .text, "ax"

