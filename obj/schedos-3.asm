
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
// #endif


void
start(void)
{
  400000:	31 c0                	xor    %eax,%eax
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  400002:	8b 15 00 80 19 00    	mov    0x198000,%edx
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400008:	40                   	inc    %eax
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  400009:	66 c7 02 33 09       	movw   $0x933,(%edx)
  40000e:	83 c2 02             	add    $0x2,%edx
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400011:	3d 40 01 00 00       	cmp    $0x140,%eax
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  400016:	89 15 00 80 19 00    	mov    %edx,0x198000
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  40001c:	75 e4                	jne    400002 <start+0x2>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  40001e:	66 31 c0             	xor    %ax,%ax
  400021:	cd 31                	int    $0x31
  400023:	eb fe                	jmp    400023 <start+0x23>
