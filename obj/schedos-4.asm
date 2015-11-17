
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
// #endif


void
start(void)
{
  500000:	31 d2                	xor    %edx,%edx
 *
 *****************************************************************************/
static inline void 
sys_print(int print)
{
	asm volatile("int %0\n"
  500002:	b8 34 0e 00 00       	mov    $0xe34,%eax
  500007:	cd 32                	int    $0x32
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  500009:	42                   	inc    %edx
  50000a:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  500010:	75 f5                	jne    500007 <start+0x7>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500012:	31 c0                	xor    %eax,%eax
  500014:	cd 31                	int    $0x31
  500016:	eb fe                	jmp    500016 <start+0x16>
