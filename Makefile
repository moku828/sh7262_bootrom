all:
	sh-elf-gcc -c -Wa,-gstabs -o asmfunc.o asmfunc.s
	sh-elf-gcc -c -Wa,-gstabs -o test_bitop.o test_bitop.s
	sh-elf-gcc -c -Wa,-gstabs -o test_datatrans.o test_datatrans.s
	sh-elf-gcc -c -Wa,-gstabs -o test_sysctrl.o test_sysctrl.s
	sh-elf-gcc -c -Wa,-gstabs -o test_bra.o test_bra.s
	sh-elf-gcc -c -Wa,-gstabs -o test_arithop.o test_arithop.s
	sh-elf-gcc -c -Wa,-gstabs -o test_fpop.o test_fpop.s
	sh-elf-ld -Tsh7262_boot.ld -nostartfiles -o bootrom.elf asmfunc.o test_bitop.o test_datatrans.o test_sysctrl.o test_bra.o test_arithop.o test_fpop.o
	sh-elf-objcopy -j .text -j .data -O binary bootrom.elf bootrom.bin
clean:
	rm bootrom.elf bootrom.bin asmfunc.o test_bitop.o test_datatrans.o test_sysctrl.o test_bra.o test_arithop.o test_fpop.o
