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

        BRA     test_46
	NOP

test_32_failed:
        BRA     test_46_failed
	NOP

test_46:
        /* resbank */
        /* restore from register bank */
        MOV     #46, R13

        MOV     #1, R14
        MOV.L   vbr_IRQ, R0
        MOV.L   back_1_test_46, R1
        MOV.L   R1, @(256,R0)
        LDC     R0, VBR
        MOV.L   imask_f, R3
        STC     SR, R0
        NOT     R3, R3
        AND     R3, R0
        LDC     R0, SR
        MOV     #0, R0
        MOV     #0, R3

wait_for_IRQ:
        CMP/EQ  #0, R0
        BT      wait_for_IRQ
        NOP
        MOV     #0, R0
        CMP/EQ  R0, R3
        BF      test_46_failed:
        NOP
        MOV.L   imask_f, R3
        STC     SR, R0
        OR      R3, R0
        LDC     R0, SR
        BRA     exit_test46:
        NOP

back_1_test_46_:
        MOV     #1, R3
        RESBANK
        MOV     #1, R0
        RTE
	NOP

exit_test46:

        BRA     test_47
	NOP

test_46_failed:
        BRA     test_47_failed
	NOP

test_47:
        /* ldbank */
        /* (selected register bank entry) -> R0 */
        MOV     #47, R13

        MOV     #1, R14
        MOV.L   bn0_en3, R3
        LDBANK  @R3, R0
        MOV     #0, R3
        CMP/EQ  R3, R0
        BF      test_47_failed
        NOP
        MOV.L   bn0_en16, R3
        LDBANK  @R3, R0
        MOV     #64, R3
        CMP/EQ  R3, R0
        BF      test_47_failed
        NOP

        BRA     test_sysctrl_succeed
	NOP

test_47_failed:
        BRA     test_sysctrl_failed
	NOP

test_sysctrl_failed:
        ADD     #3, R12
        RTS
        NOP

test_sysctrl_succeed:
        RTS
        NOP

        .align 4
imask_f:
        .long 0x000000F0
bn0_en3:
        .long _bn0_en3
_bn0_en3:
        .long 0x0000000C
bn0_en16:
        .long _bn0_en16
_bn0_en16:
        .long 0x00000040
back_1_test_46:
        .long   back_1_test_46_
vbr_IRQ:
        .long _vbr_IRQ

.section .bss, "aw"
_vbr_IRQ:
        .long 0x00000000 /* 0 */
        .long 0x00000000 /* 1 */
        .long 0x00000000 /* 2 */
        .long 0x00000000 /* 3 */
        .long 0x00000000 /* 4 */
        .long 0x00000000 /* 5 */
        .long 0x00000000 /* 6 */
        .long 0x00000000 /* 7 */
        .long 0x00000000 /* 8 */
        .long 0x00000000 /* 9 */
        .long 0x00000000 /* 10 */
        .long 0x00000000 /* 11 */
        .long 0x00000000 /* 12 */
        .long 0x00000000 /* 13 */
        .long 0x00000000 /* 14 */
        .long 0x00000000 /* 15 */
        .long 0x00000000 /* 16 */
        .long 0x00000000 /* 17 */
        .long 0x00000000 /* 18 */
        .long 0x00000000 /* 19 */
        .long 0x00000000 /* 20 */
        .long 0x00000000 /* 21 */
        .long 0x00000000 /* 22 */
        .long 0x00000000 /* 23 */
        .long 0x00000000 /* 24 */
        .long 0x00000000 /* 25 */
        .long 0x00000000 /* 26 */
        .long 0x00000000 /* 27 */
        .long 0x00000000 /* 28 */
        .long 0x00000000 /* 29 */
        .long 0x00000000 /* 30 */
        .long 0x00000000 /* 31 */
        .long 0x00000000 /* 32 */
        .long 0x00000000 /* 33 */
        .long 0x00000000 /* 34 */
        .long 0x00000000 /* 35 */
        .long 0x00000000 /* 36 */
        .long 0x00000000 /* 37 */
        .long 0x00000000 /* 38 */
        .long 0x00000000 /* 39 */
        .long 0x00000000 /* 40 */
        .long 0x00000000 /* 41 */
        .long 0x00000000 /* 42 */
        .long 0x00000000 /* 43 */
        .long 0x00000000 /* 44 */
        .long 0x00000000 /* 45 */
        .long 0x00000000 /* 46 */
        .long 0x00000000 /* 47 */
        .long 0x00000000 /* 48 */
        .long 0x00000000 /* 49 */
        .long 0x00000000 /* 50 */
        .long 0x00000000 /* 51 */
        .long 0x00000000 /* 52 */
        .long 0x00000000 /* 53 */
        .long 0x00000000 /* 54 */
        .long 0x00000000 /* 55 */
        .long 0x00000000 /* 56 */
        .long 0x00000000 /* 57 */
        .long 0x00000000 /* 58 */
        .long 0x00000000 /* 59 */
        .long 0x00000000 /* 60 */
        .long 0x00000000 /* 61 */
        .long 0x00000000 /* 62 */
        .long 0x00000000 /* 63 */
        .long 0x00000000 /* 64 */
        .long 0x00000000 /* 65 */
        .long 0x00000000 /* 66 */
        .long 0x00000000 /* 67 */
        .long 0x00000000 /* 68 */
        .long 0x00000000 /* 69 */
        .long 0x00000000 /* 70 */
        .long 0x00000000 /* 71 */
        .long 0x00000000 /* 72 */
        .long 0x00000000 /* 73 */
        .long 0x00000000 /* 74 */
        .long 0x00000000 /* 75 */
        .long 0x00000000 /* 76 */
        .long 0x00000000 /* 77 */
        .long 0x00000000 /* 78 */
        .long 0x00000000 /* 79 */

.section .text, "ax"
