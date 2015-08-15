// start.d

// These are marked extern(C) to avoid name mangling, so we can refer to them in our linker script
alias void function() ISR;              // Alias Interrupt Service Routine function pointers
extern(C) immutable ISR ResetHandler = &OnReset;  // Pointer to entry point, OnReset

void SemihostingInvoke(int command, void* message)
{
  // LDC and GDC use slightly different inline assembly syntax, so we have to 
  // differentiate them with D's conditional compilation feature, version.
  version(LDC)
  {
    import ldc.llvmasm;
    
    __asm
    (
      "mov r0, $0;
      mov r1, $1;
      bkpt #0xAB",
      "r,r,~{r0},~{r1}",
      command, message
    );
  }
  else version(GNU)
  {
    asm
    {
      "mov r0, %[cmd]; 
       mov r1, %[msg]; 
       bkpt #0xAB"
	:                              
	: [cmd] "r" command, [msg] "r" message
	: "r0", "r1", "memory";
    };
  }
}

// The program's entry point
void OnReset()
{
    // text to display
    string text = "Hello, World!\r\n";
    
    // Create semihosting message
    uint[3] message =
      [
	2, 			  // stderr
	cast(uint)text.ptr,       // ptr to string
	text.length               // number of bytes in string
      ];

    // run repeatedly
    while(true)
    {
	// Send semihosting command
	SemihostingInvoke(0x05, &message);
    }
}
