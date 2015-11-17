
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
// #endif


void
start(void)
{
  500000:	31 c0                	xor    %eax,%eax
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  500002:	8b 15 00 80 19 00    	mov    0x198000,%edx
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  500008:	40                   	inc    %eax
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  500009:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  50000e:	83 c2 02             	add    $0x2,%edx
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  500011:	3d 40 01 00 00       	cmp    $0x140,%eax
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  500016:	89 15 00 80 19 00    	mov    %edx,0x198000
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  50001c:	75 e4                	jne    500002 <start+0x2>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  50001e:	66 31 c0             	xor    %ax,%ax
  500021:	cd 31                	int    $0x31
  500023:	eb fe                	jmp    500023 <start+0x23>
