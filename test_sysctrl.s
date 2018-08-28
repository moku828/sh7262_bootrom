.global test_sysctrl

.section .text, "ax"

test_sysctrl:
        BRA     test_31
        NOP

test_31:
        /* ldc Rm,TBR */
        /* Rm -> TBR */
        MOV     #31, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        LDC     R0, TBR

        /* Nothing can be checked */

        BRA     test_32
	NOP

test_31_failed:
        BRA     test_32_failed
	NOP

test_32:
        /* stc TBR,Rn */
        /* TBR -> Rn */
        MOV     #32, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        LDC     R0, TBR
        STC     TBR, R3
        CMP/EQ  R3, R0
        BF      test_32_failed
	NOP

        BRA     test_sysctrl_succeed
	NOP

test_32_failed:
        BRA     test_sysctrl_failed
	NOP

test_sysctrl_failed:
        ADD     #3, R12
        RTS
        NOP

test_sysctrl_succeed:
        RTS
        NOP

