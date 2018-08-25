.global test_arithop

.section .text, "ax"

test_arithop:
        BRA     test_34

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

        BRA     test_arithop_succeed
        NOP

test_37_failed:
        BRA     test_arithop_failed
	NOP

test_arithop_failed:
        ADD     #3, R12
        RTS
        NOP

test_arithop_succeed:
        RTS
        NOP

