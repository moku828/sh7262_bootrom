all:
	sh-elf-gcc -c -Wa,-gstabs -o asmfunc.o asmfunc.s
	sh-elf-gcc -c -Wa,-gstabs -o test_bitop.o test_bitop.s
	sh-elf-gcc -c -Wa,-gstabs -o test_datatrans.o test_datatrans.s
	sh-elf-ld -Tsh7262_boot.ld -nostartfiles -o bootrom.elf asmfunc.o test_bitop.o test_datatrans.o
	sh-elf-objcopy -j .text -j .data -O binary bootrom.elf bootrom.bin
clean:
	rm bootrom.elf bootrom.bin asmfunc.o test_bitop.o test_datatrans.o
