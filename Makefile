all:
	sh-elf-gcc -c -g -o main.o main.c
	sh-elf-gcc -c -Wa,-gstabs -o asmfunc.o asmfunc.s
	sh-elf-ld -Tsh7262_boot.ld -nostartfiles -o bootrom.elf asmfunc.o main.o
	sh-elf-objcopy -j .text -j .data -O binary bootrom.elf bootrom.bin
clean:
	rm bootrom.elf bootrom.bin main.o asmfunc.o
