all:
	sh-elf-gcc -c -gdwarf-2 -O0 -o main.o main.c
	sh-elf-gcc -c -Wa,-gstabs -o asmfunc.o asmfunc.s
	sh-elf-ld -Tsh7262_boot.ld -o bootrom.elf asmfunc.o main.o -L/usr/local/lib/gcc/sh-elf/10.2.0/m2a -lgcc
	sh-elf-objcopy -j .text -j .data -O binary bootrom.elf bootrom.bin
	cp bootrom.bin shix_bios.bin
	touch shix_linux_nand.bin
clean:
	rm shix_bios.bin shix_linux_nand.bin bootrom.elf bootrom.bin main.o asmfunc.o
