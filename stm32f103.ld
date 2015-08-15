MEMORY
{
  SRAM     (rxw) : ORIGIN = 0x20000000, LENGTH =   20k
  FLASH    (rx)  : ORIGIN = 0x08000000, LENGTH = 1024k
}
 
_stackStart = ORIGIN(SRAM) + LENGTH(SRAM);
 
SECTIONS
{  
  /* We don't need exceptions, and discarding these sections
     prevents linker errors with LDC */
  /DISCARD/ :
  {
    *(.ARM.extab*)
    *(.ARM.exidx*)
  }
 
  .text :       
  {
    LONG(_stackStart);              /* Initial stack pointer */
    KEEP(start.o(*.ResetHandler))   /* Interrupt vector table (Entry point) */
 
    /* the code */
    *(.text)      
    *(.text*)  
 
    /* for "hello\r\n" string constant */
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
 
  }>FLASH
 
 
  /* Need .data, .bss, .ctors and probably more as program becomes
     More complex */
}
