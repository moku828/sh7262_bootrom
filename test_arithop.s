.global test_arithop

.section .text, "ax"

test_arithop:
        BRA     test_34
        NOP

test_34:
        /* clips.b Rn */
        /* when Rn > (saturation upper limit value) */
        /* (saturation upper limit value) -> Rn */
        /* 1 -> CS */
        /* when Rn < (saturation lower limit value) */
        /* (saturation lower limit value) -> Rn */
        /* 1 -> CS */
        MOV     #34, R13

        MOV     #1, R14
        MOVI20  #128, R0
        MOVI20  #127, R1
        CLIPS.B R0
        CMP/EQ  R0, R1
        BF      test_34_failed
        NOP

        MOV     #2, R14
        MOVI20  #-129, R0
        MOVI20  #-128, R1
        CLIPS.B R0
        CMP/EQ  R0, R1
        BF      test_34_failed
        NOP

        MOV     #3, R14
        MOVI20  #126, R0
        MOVI20  #126, R1
        CLIPS.B R0
        CMP/EQ  R0, R1
        BF      test_34_failed
        NOP

        MOV     #4, R14
        MOVI20  #-127, R0
        MOVI20  #-127, R1
        CLIPS.B R0
        CMP/EQ  R0, R1
        BF      test_34_failed
        NOP

        BRA     test_35
        NOP

test_34_failed:
        BRA     test_35_failed
	NOP

test_35:
        /* clips.w Rn */
        /* when Rn > (saturation upper limit value) */
        /* (saturation upper limit value) -> Rn */
        /* 1 -> CS */
        /* when Rn < (saturation lower limit value) */
        /* (saturation lower limit value) -> Rn */
        /* 1 -> CS */
        MOV     #35, R13

        MOV     #1, R14
        MOVI20  #32768, R0
        MOVI20  #32767, R1
        CLIPS.W R0
        CMP/EQ  R0, R1
        BF      test_35_failed
        NOP

        MOV     #2, R14
        MOVI20  #-32769, R0
        MOVI20  #-32768, R1
        CLIPS.W R0
        CMP/EQ  R0, R1
        BF      test_35_failed
        NOP

        MOV     #3, R14
        MOVI20  #32766, R0
        MOVI20  #32766, R1
        CLIPS.W R0
        CMP/EQ  R0, R1
        BF      test_35_failed
        NOP

        MOV     #4, R14
        MOVI20  #-32767, R0
        MOVI20  #-32767, R1
        CLIPS.W R0
        CMP/EQ  R0, R1
        BF      test_35_failed
        NOP

        BRA     test_36
        NOP

test_35_failed:
        BRA     test_36_failed
	NOP

test_36:
        /* clipu.b Rn */
        /* when Rn > (saturation value) */
        /* (saturation value) -> Rn */
        /* 1 -> CS */
        MOV     #36, R13

        MOV     #1, R14
        MOVI20  #256, R0
        MOVI20  #255, R1
        CLIPU.B R0
        CMP/EQ  R0, R1
        BF      test_36_failed
        NOP

        MOV     #2, R14
        MOVI20  #254, R0
        MOVI20  #254, R1
        CLIPU.B R0
        CMP/EQ  R0, R1
        BF      test_36_failed
        NOP

        BRA     test_37
        NOP

test_36_failed:
        BRA     test_37_failed
	NOP

test_37:
        /* clipu.w Rn */
        /* when Rn > (saturation value) */
        /* (saturation value) -> Rn */
        /* 1 -> CS */
        MOV     #37, R13

        MOV     #1, R14
        MOVI20  #65536, R0
        MOVI20  #65535, R1
        CLIPU.W R0
        CMP/EQ  R0, R1
        BF      test_37_failed
        NOP

        MOV     #2, R14
        MOVI20  #65534, R0
        MOVI20  #65534, R1
        CLIPU.W R0
        CMP/EQ  R0, R1
        BF      test_37_failed
        NOP

        BRA     test_38
        NOP

test_37_failed:
        BRA     test_38_failed
	NOP

test_38:
        /* divs R0,Rn */
        /* signed, Rn / R0 -> Rn */
        MOV     #38, R13

        MOV     #1, R14
        MOVI20  #3, R0
        MOVI20  #6, R1
        DIVS    R0, R1
        MOVI20  #2, R0
        CMP/EQ  R0, R1
        BF      test_38_failed
        NOP

        MOV     #2, R14
        MOVI20  #-3, R0
        MOVI20  #6, R1
        DIVS    R0, R1
        MOVI20  #-2, R0
        CMP/EQ  R0, R1
        BF      test_38_failed
        NOP

        MOV     #3, R14
        MOVI20  #3, R0
        MOVI20  #-6, R1
        DIVS    R0, R1
        MOVI20  #-2, R0
        CMP/EQ  R0, R1
        BF      test_38_failed
        NOP

        MOV     #4, R14
        MOVI20  #-3, R0
        MOVI20  #-6, R1
        DIVS    R0, R1
        MOVI20  #2, R0
        CMP/EQ  R0, R1
        BF      test_38_failed
        NOP

        MOV     #5, R14
        MOVI20  #2, R0
        MOV.L   signed_long_max, R1
        DIVS    R0, R1
        MOV.L   exp_signed_long_max_divided_by_2, R0
        CMP/EQ  R0, R1
        BF      test_39_failed
        NOP

        MOV     #6, R14
        MOVI20  #2, R0
        MOV.L   signed_long_min, R1
        DIVS    R0, R1
        MOV.L   exp_signed_long_min_divided_by_2, R0
        CMP/EQ  R0, R1
        BF      test_39_failed
        NOP

        MOV     #7, R14
        MOV.L   vbr_divide_exception, R0
        MOV.L   back_1_test_38, R1
        MOV.L   R1, @(68,R0)
        LDC     R0, VBR
        MOVI20  #0, R0
        MOVI20  #6, R1
        DIVS    R0, R1
_back_2_test_38:
        MOVI20  #6, R0
        CMP/EQ  R0, R1
        BF      test_38_failed
        NOP

        MOV     #8, R14
        MOV.L   vbr_divide_exception, R0
        MOV.L   back_3_test_38, R1
        MOV.L   R1, @(72,R0)
        LDC     R0, VBR
        MOVI20  #-1, R0
        MOV.L   signed_long_min, R1
        DIVS    R0, R1
_back_4_test_38:
        MOV.L   signed_long_min, R0
        CMP/EQ  R0, R1
        BF      test_38_failed
        NOP

        BRA     test_39
        NOP

        .align 4
back_1_test_38:
        .long   _back_1_test_38
_back_1_test_38:
        BRA     _back_2_test_38
        NOP

        .align 4
back_3_test_38:
        .long   _back_3_test_38
_back_3_test_38:
        BRA     _back_4_test_38
        NOP

test_38_failed:
        BRA     test_39_failed
	NOP

test_39:
        /* divu R0,Rn */
        /* unsigned, Rn / R0 -> Rn */
        MOV     #39, R13

        MOV     #1, R14
        MOVI20  #3, R0
        MOVI20  #6, R1
        DIVU    R0, R1
        MOVI20  #2, R0
        CMP/EQ  R0, R1
        BF      test_39_failed
        NOP

        MOV     #2, R14
        MOVI20  #2, R0
        MOV.L   unsigned_long_max, R1
        DIVU    R0, R1
        MOV.L   exp_unsigned_long_max_divided_by_2, R0
        CMP/EQ  R0, R1
        BF      test_39_failed
        NOP

        MOV     #3, R14
        MOV.L   vbr_divide_exception, R0
        MOV.L   back_1_test_39, R1
        MOV.L   R1, @(68,R0)
        LDC     R0, VBR
        MOVI20  #0, R0
        MOVI20  #6, R1
        DIVU    R0, R1
_back_2_test_39:
        MOVI20  #6, R0
        CMP/EQ  R0, R1
        BF      test_39_failed
        NOP

        BRA     test_40
        NOP

        .align 4
back_1_test_39:
        .long   _back_1_test_39
_back_1_test_39:
        BRA     _back_2_test_39
        NOP

test_39_failed:
        BRA     test_40_failed
	NOP

test_40:
        /* mulr R0,Rn */
        /* R0 x Rn -> Rn */
        MOV     #40, R13

        MOV     #1, R14
        MOVI20  #3, R0
        MOVI20  #2, R1
        MULR    R0, R1
        MOVI20  #6, R0
        CMP/EQ  R0, R1
        BF      test_40_failed
        NOP

        BRA     test_arithop_succeed
        NOP

test_40_failed:
        BRA     test_arithop_failed
	NOP

test_arithop_failed:
        ADD     #5, R12
        RTS
        NOP

test_arithop_succeed:
        RTS
        NOP

        .align 4
unsigned_long_max:
        .long 0xFFFFFFFF
unsigned_long_min:
        .long 0x00000000
signed_long_max:
        .long 0x7FFFFFFF
signed_long_min:
        .long 0x80000000
exp_unsigned_long_max_divided_by_2:
        .long 0x7FFFFFFF
exp_signed_long_max_divided_by_2:
        .long 0x3FFFFFFF
exp_signed_long_min_divided_by_2:
        .long 0xC0000000
vbr_divide_exception:
        .long _vbr_divide_exception

.section .bss, "aw"
_vbr_divide_exception:
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

.section .text, "ax"
