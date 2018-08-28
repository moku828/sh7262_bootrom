.global test_bra

.section .text, "ax"

test_bra:
        BRA     test_33
        NOP

test_33:
        /* jsr/n @@(disp8, TBR) */
        /* PC-2 -> PR */
        /* (disp x 4+TBR) -> PC */
        MOV     #33, R13

        MOV     #1, R14
        MOV     R2, R15
        ADD     #4, R15
        MOVMU.L R15, @-R15
        MOV.L   jump_table, R0
        LDC     R0, TBR
        SETT
        JSR/N   @@(4, TBR)
        MOVMU.L @R15+, R15

        BT      test_33_failed
        NOP

        BRA     test_bra_succeed
        NOP

_back_test_33:

        CLRT
        RTS/N

test_33_failed:
        BRA     test_bra_failed
	NOP

test_bra_failed:
        ADD     #3, R12
        RTS
        NOP

test_bra_succeed:
        RTS
        NOP

        .align  4
jump_table:
        .long   _jump_table
_jump_table:
        .long   0
        .long   _back_test_33
        .long   0
        .long   0
