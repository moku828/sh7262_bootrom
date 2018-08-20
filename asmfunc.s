.global test_start
/*-------------------------------------*/
/* Bootstrap code                      */
/*-------------------------------------*/

.section .text, "ax"

test_start:
        /* setup */
	MOV.L	value, R1
	MOV.L	valuew, R2

test_1:
        /* bld #imm3,Rn */
        /* <imm> of Rn -> T */
        MOV     #1, R13

        MOV     #1, R14
        MOV.B   @(1,R1), R0
        CLRT
        BLD     #5, R0 /* T: 0 => 1 */
        BF      test_1_failed
	NOP

        MOV     #2, R14
        MOV.B   @(0,R1), R0
        SETT
        BLD     #5, R0 /* T: 1 => 0 */
        BT      test_1_failed
	NOP

        BRA     test_2
	NOP

test_1_failed:
        BRA     test_2_failed
	NOP

test_2:
        /* bclr #imm3,Rn */
        /* 0 -> <imm> of Rn */
        MOV     #2, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        BCLR    #5, R0
        SETT
        BLD     #5, R0 /* T: 1 => 0 */
        BT      test_2_failed
	NOP

        BRA     test_3
	NOP

test_2_failed:
        BRA     test_3_failed
	NOP

test_3:
        /* bset #imm3,Rn */
        /* 1 -> <imm> of Rn */
        MOV     #3, R13

        MOV     #1, R14
        MOV     #0x00, R0
        BSET    #5, R0
        CLRT
        BLD     #5, R0 /* T: 0 => 1 */
        BF      test_3_failed
	NOP

        BRA     test_4
	NOP

test_3_failed:
        BRA     test_4_failed
	NOP

test_4:
        /* bst #imm3,Rn */
        /* T -> <imm> of Rn */
        MOV     #4, R13

        MOV     #1, R14
        MOV     #0xFF, R0
        CLRT
        BST     #5, R0
        SETT
        BLD     #5, R0 /* T: 1 => 0 */
        BT      test_4_failed
	NOP

        MOV     #2, R14
        MOV     #0x00, R0
        SETT
        BST     #5, R0
        CLRT
        BLD     #5, R0 /* T: 0 => 1 */
        BF      test_4_failed
	NOP

        BRA     test_5
	NOP

test_4_failed:
        BRA     test_5_failed
	NOP

test_5:
        /* bld.b #imm3,@(disp12,Rn) */
        /* (<imm> of (disp+Rn)) -> T */
        MOV     #5, R13

        MOV     #1, R14
        CLRT
        BLD.B   #5, @(1,R1) /* T: 0 => 1 */
        BF      test_5_failed
	NOP

        MOV     #2, R14
        SETT
        BLD.B   #5, @(0,R1) /* T: 1 => 0 */
        BT      test_5_failed
	NOP

        BRA     test_6
	NOP

test_5_failed:
        BRA     test_6_failed
	NOP

test_6:
        /* bldnot.b #imm3,@(disp12,Rn) */
        /* ~(<imm> of (disp+Rn)) -> T */
        MOV     #6, R13

        MOV     #1, R14
        SETT
        BLDNOT.B #5, @(1,R1) /* T: 1 => 0 */
        BT      test_6_failed
	NOP

        MOV     #2, R14
        CLRT
        BLDNOT.B #5, @(0,R1) /* T: 0 => 1 */
        BF      test_6_failed
	NOP

        BRA     test_7
	NOP

test_6_failed:
        BRA     test_7_failed
	NOP

test_7:
        /* bst.b #imm3,@(disp12,Rn) */
        /* T -> (<imm> of (disp+Rn)) */
        MOV     #7, R13

        MOV     #1, R14
        SETT
        BST.B   #5, @(2,R2)
        CLRT
        BLD.B   #5, @(2,R2) /* T: 0 => 1 */
        BF      test_7_failed
	NOP

        MOV     #2, R14
        CLRT
        BST.B   #5, @(2,R2)
        SETT
        BLD.B   #5, @(2,R2) /* T: 1 => 0 */
        BT      test_7_failed
	NOP

        BRA     test_8
	NOP

test_7_failed:
        BRA     test_8_failed
	NOP

test_8:
        /* band.b #imm3,@(disp12,Rn) */
        /* (<imm> of (disp+Rn))&T -> T */
        MOV     #8, R13

        MOV     #1, R14
        SETT
        BAND.B  #5, @(1,R1) /* T: 1 => 1 */
        BF      test_8_failed
	NOP

        MOV     #2, R14
        SETT
        BAND.B  #5, @(0,R1) /* T: 1 => 0 */
        BT      test_8_failed
	NOP

        MOV     #3, R14
        CLRT
        BAND.B  #5, @(1,R1) /* T: 0 => 0 */
        BT      test_8_failed
	NOP

        MOV     #4, R14
        CLRT
        BAND.B  #5, @(0,R1) /* T: 0 => 0 */
        BT      test_8_failed
	NOP

        BRA     test_9
	NOP

test_8_failed:
        BRA     test_9_failed
	NOP

test_9:
        /* bandnot.b #imm3,@(disp12,Rn) */
        /* ~(<imm> of (disp+Rn))&T -> T */
        MOV     #9, R13

        MOV     #1, R14
        SETT
        BANDNOT.B  #5, @(1,R1) /* T: 1 => 0 */
        BT      test_9_failed
	NOP

        MOV     #2, R14
        SETT
        BANDNOT.B  #5, @(0,R1) /* T: 1 => 1 */
        BF      test_9_failed
	NOP

        MOV     #3, R14
        CLRT
        BANDNOT.B  #5, @(1,R1) /* T: 0 => 0 */
        BT      test_9_failed
	NOP

        MOV     #4, R14
        CLRT
        BANDNOT.B  #5, @(0,R1) /* T: 0 => 0 */
        BT      test_9_failed
	NOP

        BRA     test_10
	NOP

test_9_failed:
        BRA     test_10_failed
	NOP

test_10:
        /* bor.b #imm3,@(disp12,Rn) */
        /* (<imm> of (disp+Rn))|T -> T */
        MOV     #10, R13

        MOV     #1, R14
        CLRT
        BOR.B  #5, @(1,R1) /* T: 0 => 1 */
        BF      test_10_failed
	NOP

        MOV     #2, R14
        CLRT
        BOR.B  #5, @(0,R1) /* T: 0 => 0 */
        BT      test_10_failed
	NOP

        MOV     #3, R14
        SETT
        BOR.B  #5, @(1,R1) /* T: 1 => 1 */
        BF      test_10_failed
	NOP

        MOV     #4, R14
        SETT
        BOR.B  #5, @(0,R1) /* T: 1 => 1 */
        BF      test_10_failed
	NOP

        BRA     test_11
	NOP

test_10_failed:
        BRA     test_11_failed
	NOP

test_11:
        /* bornot.b #imm3,@(disp12,Rn) */
        /* ~(<imm> of (disp+Rn))|T -> T */
        MOV     #11, R13

        MOV     #1, R14
        CLRT
        BORNOT.B  #5, @(1,R1) /* T: 0 => 0 */
        BT      test_11_failed
	NOP

        MOV     #2, R14
        CLRT
        BORNOT.B  #5, @(0,R1) /* T: 0 => 1 */
        BF      test_11_failed
	NOP

        MOV     #3, R14
        SETT
        BORNOT.B  #5, @(1,R1) /* T: 1 => 1 */
        BF      test_11_failed
	NOP

        MOV     #4, R14
        SETT
        BORNOT.B  #5, @(0,R1) /* T: 1 => 1 */
        BF      test_11_failed
	NOP

        BRA     test_12
	NOP

test_11_failed:
        BRA     test_12_failed
	NOP

test_12:
        /* bxor.b #imm3,@(disp12,Rn) */
        /* (<imm> of (disp+Rn))^T -> T */
        MOV     #12, R13

        MOV     #1, R14
        CLRT
        BXOR.B  #5, @(1,R1) /* T: 0 => 1 */
        BF      test_12_failed
	NOP

        MOV     #2, R14
        CLRT
        BXOR.B  #5, @(0,R1) /* T: 0 => 0 */
        BT      test_12_failed
	NOP

        MOV     #3, R14
        SETT
        BXOR.B  #5, @(1,R1) /* T: 1 => 0 */
        BT      test_12_failed
	NOP

        MOV     #4, R14
        SETT
        BXOR.B  #5, @(0,R1) /* T: 1 => 1 */
        BF      test_12_failed
	NOP

        BRA     test_succeed
	NOP

test_12_failed:
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

test_succeed:
        BRA     test_succeed
        NOP
test_failed:
        BRA     test_failed
        NOP

.section .bss, "aw"
_valuew:
	.byte	0x00
	.byte	0x00
	.byte	0x00
	.byte	0x00

