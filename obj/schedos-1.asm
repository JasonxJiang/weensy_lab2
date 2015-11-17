
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
// #endif


void
start(void)
{
  200000:	31 c0                	xor    %eax,%eax
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  200002:	8b 15 00 80 19 00    	mov    0x198000,%edx
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200008:	40                   	inc    %eax
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  200009:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  20000e:	83 c2 02             	add    $0x2,%edx
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200011:	3d 40 01 00 00       	cmp    $0x140,%eax
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  200016:	89 15 00 80 19 00    	mov    %edx,0x198000
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  20001c:	75 e4                	jne    200002 <start+0x2>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  20001e:	66 31 c0             	xor    %ax,%ax
  200021:	cd 31                	int    $0x31
  200023:	eb fe                	jmp    200023 <start+0x23>
