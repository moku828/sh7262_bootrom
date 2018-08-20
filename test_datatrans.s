.global test_datatrans

.section .text, "ax"

test_datatrans:
        BRA     test_13

test_13:
        /* mov.b R0,@Rn+ */
        /* R0 -> (Rn), Rn+1 -> Rn */
        MOV     #13, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV     R7, R6
        MOV     R0, R5
        MOV.B   R0, @R7+
        MOV     #0x00, R0
        ADD     #1, R6
        CMP/EQ  R7, R6
        BF      test_13_failed
	NOP
        ADD     #-1, R6
        MOV.B   @R6, R0
        CMP/EQ  R5, R0
        BF      test_13_failed
	NOP

        BRA     test_14
	NOP

test_13_failed:
        BRA     test_14_failed
	NOP

test_14:
        /* mov.w R0,@Rn+ */
        /* R0 -> (Rn), Rn+2 -> Rn */
        MOV     #14, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV     R7, R6
        MOV     R0, R5
        MOV.W   R0, @R7+
        MOV     #0x00, R0
        ADD     #2, R6
        CMP/EQ  R7, R6
        BF      test_14_failed
	NOP
        ADD     #-2, R6
        MOV.W   @R6, R0
        CMP/EQ  R5, R0
        BF      test_14_failed
	NOP

        BRA     test_15
	NOP

test_14_failed:
        BRA     test_15_failed
	NOP

test_15:
        /* mov.l R0,@Rn+ */
        /* R0 -> (Rn), Rn+4 -> Rn */
        MOV     #15, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV     R7, R6
        MOV     R0, R5
        MOV.L   R0, @R7+
        MOV     #0x00, R0
        ADD     #4, R6
        CMP/EQ  R7, R6
        BF      test_15_failed
	NOP
        ADD     #-4, R6
        MOV.L   @R6, R0
        CMP/EQ  R5, R0
        BF      test_15_failed
	NOP

        BRA     test_16
	NOP

test_15_failed:
        BRA     test_16_failed
	NOP

test_16:
        /* mov.b @-Rm,R0 */
        /* Rm-1 -> Rm, (Rm) -> extend sign -> R0 */
        MOV     #16, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV.B   R0, @R7
        MOV     R7, R6
        ADD     #1, R7
        MOV     R0, R5
        MOV.B   @-R7, R0
        CMP/EQ  R7, R6
        BF      test_16_failed
	NOP
        CMP/EQ  R5, R0
        BF      test_16_failed
	NOP

        BRA     test_17
	NOP

test_16_failed:
        BRA     test_17_failed
	NOP

test_17:
        /* mov.w @-Rm,R0 */
        /* Rm-2 -> Rm, (Rm) -> extend sign -> R0 */
        MOV     #17, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV.W   R0, @R7
        MOV     R7, R6
        ADD     #2, R7
        MOV     R0, R5
        MOV.W   @-R7, R0
        CMP/EQ  R7, R6
        BF      test_17_failed
	NOP
        CMP/EQ  R5, R0
        BF      test_17_failed
	NOP

        BRA     test_18
	NOP

test_17_failed:
        BRA     test_18_failed
	NOP

test_18:
        /* mov.l @-Rm,R0 */
        /* Rm-1 -> Rm, (Rm) -> R0 */
        MOV     #18, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV.L   R0, @R7
        MOV     R7, R6
        ADD     #4, R7
        MOV     R0, R5
        MOV.L   @-R7, R0
        CMP/EQ  R7, R6
        BF      test_18_failed
	NOP
        CMP/EQ  R5, R0
        BF      test_18_failed
	NOP

        BRA     test_19
	NOP

test_18_failed:
        BRA     test_19_failed
	NOP

test_19:
        /* mov.b Rm,@(disp12,Rn) */
        /* Rm -> (disp+Rn) */
        MOV     #19, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV     R7, R6
        MOV.B   R0, @(0x0100,R7)
        ADD     #0x7F, R6
        ADD     #0x7F, R6
        ADD     #2, R6
        MOV.B   @R6, R5
        CMP/EQ  R5, R0
        BF      test_19_failed
        NOP

        BRA     test_20
	NOP

test_19_failed:
        BRA     test_20_failed
	NOP

test_20:
        /* mov.w Rm,@(disp12,Rn) */
        /* Rm -> (disp x 2+Rn) */
        MOV     #20, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV     R7, R6
        MOV.W   R0, @(0x0100,R7)
        ADD     #0x7F, R6
        ADD     #0x7F, R6
        ADD     #2, R6
        MOV.W   @R6, R5
        CMP/EQ  R5, R0
        BF      test_20_failed
        NOP

        BRA     test_21
	NOP

test_20_failed:
        BRA     test_21_failed
	NOP

test_21:
        /* mov.l Rm,@(disp12,Rn) */
        /* Rm -> (disp x 4+Rn) */
        MOV     #21, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        MOV     R2, R7
        MOV     R7, R6
        MOV.L   R0, @(0x0100,R7)
        ADD     #0x7F, R6
        ADD     #0x7F, R6
        ADD     #2, R6
        MOV.L   @R6, R5
        CMP/EQ  R5, R0
        BF      test_21_failed
        NOP

        BRA     test_22
	NOP

test_21_failed:
        BRA     test_22_failed
	NOP

test_22:
        /* mov.b @(disp12,Rm),Rn */
        /* (disp+Rm) -> extend sign -> Rn */
        MOV     #22, R13

        MOV     #1, R14
        MOV     #0xFF, R5
        MOV     R2, R7
        MOV     R7, R6
        ADD     #0x7F, R6
        ADD     #0x7F, R6
        ADD     #2, R6
        MOV.B   R5, @R6
        MOV.B   @(0x0100,R7), R0
        CMP/EQ  R5, R0
        BF      test_22_failed

        BRA     test_23
	NOP

test_22_failed:
        BRA     test_23_failed
	NOP

test_23:
        /* mov.w @(disp12,Rm),Rn */
        /* (disp x 2+Rm) -> extend sign -> Rn */
        MOV     #23, R13

        MOV     #1, R14
        MOV     #0xFF, R5
        MOV     R2, R7
        MOV     R7, R6
        ADD     #0x7F, R6
        ADD     #0x7F, R6
        ADD     #2, R6
        MOV.W   R5, @R6
        MOV.W   @(0x0100,R7), R0
        CMP/EQ  R5, R0
        BF      test_23_failed

        BRA     test_24
	NOP

test_23_failed:
        BRA     test_24_failed
	NOP

test_24:
        /* mov.l @(disp12,Rm),Rn */
        /* (disp x 4+Rm) -> Rn */
        MOV     #24, R13

        MOV     #1, R14
        MOV     #0xFF, R5
        MOV     R2, R7
        MOV     R7, R6
        ADD     #0x7F, R6
        ADD     #0x7F, R6
        ADD     #2, R6
        MOV.L   R5, @R6
        MOV.L   @(0x0100,R7), R0
        CMP/EQ  R5, R0
        BF      test_24_failed

        BRA     test_25
	NOP

test_24_failed:
        BRA     test_25_failed
	NOP

test_25:
        /* movu.b @(disp12,Rm),Rn */
        /* (disp+Rm) -> extend zero -> Rn */
        MOV     #25, R13

        MOV     #1, R14

        BRA     test_26
	NOP

test_25_failed:
        BRA     test_26_failed
	NOP

test_26:
        /* movu.w @(disp12,Rm),Rn */
        /* (disp x 2+Rm) -> extend zero -> Rn */
        MOV     #26, R13

        MOV     #1, R14

        BRA     test_27
	NOP

test_26_failed:
        BRA     test_27_failed
	NOP

test_27:
        /* mov.l @-Rm,R0 */
        /* Rm-1 -> Rm, (Rm) -> R0 */
        MOV     #27, R13

        MOV     #1, R14

        BRA     test_datatrans_succeed
	NOP

test_27_failed:
        BRA     test_datatrans_failed
	NOP

test_datatrans_failed:
        ADD     #2, R12
        RTS
        NOP

test_datatrans_succeed:
        RTS
        NOP

