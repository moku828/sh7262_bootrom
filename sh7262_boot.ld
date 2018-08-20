OUTPUT_FORMAT("elf32-sh");
OUTPUT_ARCH(sh2a-nofpu);
ENTRY("test_start");
/* SH72620 Available Memory */
MEMORY
{
  BOOTROM (x) : ORIGIN = 0x40000000, LENGTH = 64k	/* Boot ROM: 64k */
  FRAM (wx) : ORIGIN = 0xFFF80000, LENGTH = 64k         /* Fast SRAM: 64k */
}


/* Section Definitions */
SECTIONS
{
  .text :
  {
	*(.text .text.*)	/* Program code */
	*(.rodata)		/* Read-only data (constants) */
	*(.rodata*)
	. = ALIGN(4);
	__text_end__ = . ;
  } > BOOTROM


  /* .data section which has initialized data */
  .data :
  {
	__data_start__ = . ;
	*(.data)
	*(.data.*)
	*(.zdata)
	. = ALIGN(4);
	__data_end__ = . ;
  } > FRAM


  /* .bss section which is to be initialized by 0 */
  .bss (NOLOAD) :
  {
	__bss_start__ = . ;
	*(.bss)
	*(.bss.*)
	*(COMMON)
	*(.got.*)
	. = ALIGN(4);
	__bss_end__ = . ;
  } > FRAM


  .stack (NOLOAD) :
  {
	__stack_start__ = . ;
	*(.STACK)
	*(.stack)
	. = ALIGN(4);
	__stack_end__ = . ;
  } > FRAM



  /* Stabs debugging sections.  */
  .stab          0 : { *(.stab) }
  .stabstr       0 : { *(.stabstr) }
  .stab.excl     0 : { *(.stab.excl) }
  .stab.exclstr  0 : { *(.stab.exclstr) }
  .stab.index    0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment       0 : { *(.comment) }
  .debug          0 : { *(.debug*) }

}
