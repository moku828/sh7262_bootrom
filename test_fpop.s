.global test_fpop

.section .text, "ax"

test_fpop:
        BRA     test_41
        NOP

test_41:
        /* fmov.s @(disp12,Rm),FRn */
        /* (disp x 4+Rm) -> FRn */
        MOV     #41, R13

        MOV     #1, R14
        MOV.L   fp_valuew, R1
        MOV.L   fp_value_2_5, R0
        MOV.L   R0, @(4,R1)
        STS     FPSCR, R0
        MOV.L   fpscr_szpr_mask, R3
        AND     R3, R0
        LDS     R0, FPSCR
        FMOV.S  @(4,R1), FR0
        FMOV.S  FR0, @R1
        MOV.L   @R1, R0
        MOV.L   fp_value_2_5, R3
        CMP/EQ  R3, R0
        BF      test_41_failed
	NOP

        BRA     test_42
	NOP

test_41_failed:
        BRA     test_42_failed
	NOP

test_42:
        /* fmov.d @(disp12,Rm),DRn */
        /* (disp x 8+Rm) -> DRn */
        MOV     #42, R13

        MOV     #1, R14
        MOV.L   fp_valuew, R1
        MOV.L   fp_value_double_max, R0
        MOV.L   @(0,R0), R3
        MOV.L   R3, @(8,R1)
        MOV.L   @(4,R0), R3
        MOV.L   R3, @(12,R1)
        STS     FPSCR, R0
        MOV.L   fpscr_szpr_mask, R3
        AND     R3, R0
        MOV.L   fpscr_sz, R3
        OR      R3, R0
        LDS     R0, FPSCR
        FMOV.D  @(8,R1), DR0
        FMOV.D  DR0, @R1
        MOV.L   fp_value_double_max, R0
        MOV.L   @(0,R0), R7
        MOV.L   @(0,R1), R3
        CMP/EQ  R3, R7
        BF      test_42_failed
	NOP
        MOV.L   @(4,R0), R7
        MOV.L   @(4,R1), R3
        CMP/EQ  R3, R7
        BF      test_42_failed
	NOP

        BRA     test_43
	NOP

test_42_failed:
        BRA     test_43_failed
	NOP

test_43:
        /* fmov.s FRm,@(disp12,Rn) */
        /* FRm -> (disp x 4+Rn) */
        MOV     #43, R13

        MOV     #1, R14
        MOV.L   fp_valuew, R1
        MOV.L   fp_value_2_5, R0
        MOV.L   R0, @(4,R1)
        STS     FPSCR, R0
        MOV.L   fpscr_szpr_mask, R3
        AND     R3, R0
        LDS     R0, FPSCR
        FMOV.S  @(4,R1), FR0
        FMOV.S  FR0, @(0,R1)
        MOV.L   @R1, R0
        MOV.L   fp_value_2_5, R3
        CMP/EQ  R3, R0
        BF      test_43_failed
	NOP

        BRA     test_44
	NOP

test_43_failed:
        BRA     test_44_failed
	NOP

test_44:
        /* fmov.d DRm,@(disp12,Rn) */
        /* DRm -> (disp x 8+Rn) */
        MOV     #44, R13

        MOV     #1, R14
        MOV.L   fp_valuew, R1
        MOV.L   fp_value_double_max, R0
        MOV.L   @(0,R0), R3
        MOV.L   R3, @(8,R1)
        MOV.L   @(4,R0), R3
        MOV.L   R3, @(12,R1)
        STS     FPSCR, R0
        MOV.L   fpscr_szpr_mask, R3
        AND     R3, R0
        MOV.L   fpscr_sz, R3
        OR      R3, R0
        LDS     R0, FPSCR
        FMOV.D  @(8,R1), DR0
        FMOV.D  DR0, @(0,R1)
        MOV.L   fp_value_double_max, R0
        MOV.L   @(0,R0), R7
        MOV.L   @(0,R1), R3
        CMP/EQ  R3, R7
        BF      test_44_failed
	NOP
        MOV.L   @(4,R0), R7
        MOV.L   @(4,R1), R3
        CMP/EQ  R3, R7
        BF      test_44_failed
	NOP

        BRA     test_fpop_succeed
	NOP

test_44_failed:
        BRA     test_fpop_failed
	NOP

test_fpop_failed:
        ADD     #6, R12
        RTS
        NOP

test_fpop_succeed:
        RTS
        NOP

        .align 4
fpscr_sz:
        .long 0x00100000
fpscr_pr:
        .long 0x00080000
fpscr_szpr_mask:
        .long 0xFFE7FFFF
fp_value_2_5:
        .long 0x40200000
fp_value_double_max:
        .long _fp_value_double_max
_fp_value_double_max:
        .long 0x7FEFFFFF
        .long 0xFFFFFFFF

fp_valuew:
        .long _fp_valuew

.section .bss, "aw"
_fp_valuew:
        .long 0x00000000
        .long 0x00000000
        .long 0x00000000
        .long 0x00000000
        .long 0x00000000
        .long 0x00000000
        .long 0x00000000
        .long 0x00000000

.section .text, "ax"

