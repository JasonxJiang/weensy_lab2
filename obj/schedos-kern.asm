
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 f2 02 00 00       	call   10030b <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 0d 02 00 00       	call   10027f <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <myrand>:
 *
 *****************************************************************************/
static unsigned long next = 1;
/* RAND_MAX assumed to be 32767 */
int myrand(void) {
    next = next * 1103515245 + 12345;
  10009c:	69 05 00 10 10 00 6d 	imul   $0x41c64e6d,0x101000,%eax
  1000a3:	4e c6 41 
  1000a6:	05 39 30 00 00       	add    $0x3039,%eax
  1000ab:	a3 00 10 10 00       	mov    %eax,0x101000
  1000b0:	c1 e8 10             	shr    $0x10,%eax
  1000b3:	25 ff 7f 00 00       	and    $0x7fff,%eax
    return((unsigned)(next/65536) % 32768);
}
  1000b8:	c3                   	ret    

001000b9 <mysrand>:
void mysrand(unsigned seed) {
    next = seed;
  1000b9:	8b 44 24 04          	mov    0x4(%esp),%eax
  1000bd:	a3 00 10 10 00       	mov    %eax,0x101000
}
  1000c2:	c3                   	ret    

001000c3 <schedule>:


void
schedule(void)
{
	pid_t pid = current->p_pid;
  1000c3:	a1 a0 7a 10 00       	mov    0x107aa0,%eax
}


void
schedule(void)
{
  1000c8:	57                   	push   %edi
  1000c9:	56                   	push   %esi
  1000ca:	53                   	push   %ebx
	pid_t pid = current->p_pid;
  1000cb:	8b 18                	mov    (%eax),%ebx
	int j = 0;
	int lowest_priority = 65535; //INT_MAX of 16 bit ints 
	int largest_share = 0;
	if (scheduling_algorithm == 0)
  1000cd:	a1 a4 7a 10 00       	mov    0x107aa4,%eax
  1000d2:	85 c0                	test   %eax,%eax
  1000d4:	75 26                	jne    1000fc <schedule+0x39>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000d6:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000db:	8d 43 01             	lea    0x1(%ebx),%eax
  1000de:	99                   	cltd   
  1000df:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000e1:	6b c2 60             	imul   $0x60,%edx,%eax
	int j = 0;
	int lowest_priority = 65535; //INT_MAX of 16 bit ints 
	int largest_share = 0;
	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000e4:	89 d3                	mov    %edx,%ebx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000e6:	83 b8 a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%eax)
  1000ed:	75 ec                	jne    1000db <schedule+0x18>
				run(&proc_array[pid]);//run(&proc_array[pid]);
  1000ef:	83 ec 0c             	sub    $0xc,%esp
  1000f2:	05 58 70 10 00       	add    $0x107058,%eax
  1000f7:	e9 c8 00 00 00       	jmp    1001c4 <schedule+0x101>
		}
	else if (scheduling_algorithm == 1)
  1000fc:	83 f8 01             	cmp    $0x1,%eax
  1000ff:	75 37                	jne    100138 <schedule+0x75>
  100101:	ba 01 00 00 00       	mov    $0x1,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE)
  100106:	6b c8 60             	imul   $0x60,%eax,%ecx
  100109:	83 b9 a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%ecx)
  100110:	75 12                	jne    100124 <schedule+0x61>
					run(&proc_array[j]);
  100112:	6b d2 60             	imul   $0x60,%edx,%edx
  100115:	83 ec 0c             	sub    $0xc,%esp
  100118:	81 c2 58 70 10 00    	add    $0x107058,%edx
  10011e:	52                   	push   %edx
  10011f:	e8 29 05 00 00       	call   10064d <run>
		}
	else if (scheduling_algorithm == 1)
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  100124:	40                   	inc    %eax
  100125:	83 f8 04             	cmp    $0x4,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);//run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 1)
  100128:	89 c2                	mov    %eax,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  10012a:	7e da                	jle    100106 <schedule+0x43>
  10012c:	ba 01 00 00 00       	mov    $0x1,%edx
  100131:	b8 01 00 00 00       	mov    $0x1,%eax
  100136:	eb ce                	jmp    100106 <schedule+0x43>
					run(&proc_array[j]);
			}
		}

	}
	else if (scheduling_algorithm == 2)
  100138:	83 f8 02             	cmp    $0x2,%eax
  10013b:	0f 85 89 00 00 00    	jne    1001ca <schedule+0x107>
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority < lowest_priority)
					lowest_priority = proc_array[j].p_priority;
			}

			pid = (pid + 1) % NPROCS;
  100141:	be 05 00 00 00       	mov    $0x5,%esi
	{
		while (1)
		{
			for (j = 1; j < NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority < lowest_priority)
  100146:	83 3d 00 71 10 00 01 	cmpl   $0x1,0x107100
  10014d:	b9 ff ff 00 00       	mov    $0xffff,%ecx
  100152:	75 13                	jne    100167 <schedule+0xa4>
  100154:	8b 0d 08 71 10 00    	mov    0x107108,%ecx
  10015a:	81 f9 ff ff 00 00    	cmp    $0xffff,%ecx
  100160:	7e 05                	jle    100167 <schedule+0xa4>
  100162:	b9 ff ff 00 00       	mov    $0xffff,%ecx
  100167:	83 3d 60 71 10 00 01 	cmpl   $0x1,0x107160
  10016e:	75 0b                	jne    10017b <schedule+0xb8>
  100170:	a1 68 71 10 00       	mov    0x107168,%eax
  100175:	39 c1                	cmp    %eax,%ecx
  100177:	7e 02                	jle    10017b <schedule+0xb8>
  100179:	89 c1                	mov    %eax,%ecx
  10017b:	83 3d c0 71 10 00 01 	cmpl   $0x1,0x1071c0
  100182:	75 0b                	jne    10018f <schedule+0xcc>
  100184:	a1 c8 71 10 00       	mov    0x1071c8,%eax
  100189:	39 c1                	cmp    %eax,%ecx
  10018b:	7e 02                	jle    10018f <schedule+0xcc>
  10018d:	89 c1                	mov    %eax,%ecx
  10018f:	83 3d 20 72 10 00 01 	cmpl   $0x1,0x107220
  100196:	75 0b                	jne    1001a3 <schedule+0xe0>
  100198:	a1 28 72 10 00       	mov    0x107228,%eax
  10019d:	39 c1                	cmp    %eax,%ecx
  10019f:	7e 02                	jle    1001a3 <schedule+0xe0>
  1001a1:	89 c1                	mov    %eax,%ecx
					lowest_priority = proc_array[j].p_priority;
			}

			pid = (pid + 1) % NPROCS;
  1001a3:	8d 43 01             	lea    0x1(%ebx),%eax
  1001a6:	99                   	cltd   
  1001a7:	f7 fe                	idiv   %esi
			if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= lowest_priority)
  1001a9:	6b c2 60             	imul   $0x60,%edx,%eax
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority < lowest_priority)
					lowest_priority = proc_array[j].p_priority;
			}

			pid = (pid + 1) % NPROCS;
  1001ac:	89 d3                	mov    %edx,%ebx
			if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= lowest_priority)
  1001ae:	83 b8 a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%eax)
  1001b5:	75 8f                	jne    100146 <schedule+0x83>
  1001b7:	05 58 70 10 00       	add    $0x107058,%eax
  1001bc:	39 48 50             	cmp    %ecx,0x50(%eax)
  1001bf:	7f 85                	jg     100146 <schedule+0x83>
				run(&proc_array[pid]);
  1001c1:	83 ec 0c             	sub    $0xc,%esp
  1001c4:	50                   	push   %eax
  1001c5:	e9 55 ff ff ff       	jmp    10011f <schedule+0x5c>
			lowest_priority = 65535;
			
		}
	}
	else if (scheduling_algorithm == 3)
  1001ca:	83 f8 03             	cmp    $0x3,%eax
  1001cd:	75 40                	jne    10020f <schedule+0x14c>
				{
					proc_array[pid].p_times_run++;
					run(&proc_array[pid]);
				}
			}
			pid = (pid + 1)%NPROCS;
  1001cf:	b9 05 00 00 00       	mov    $0x5,%ecx
	}
	else if (scheduling_algorithm == 3)
	{
		while (1)
		{
			if (proc_array[pid].p_state == P_RUNNABLE)
  1001d4:	6b d3 60             	imul   $0x60,%ebx,%edx
  1001d7:	8d 82 60 70 10 00    	lea    0x107060(%edx),%eax
  1001dd:	83 78 40 01          	cmpl   $0x1,0x40(%eax)
  1001e1:	75 22                	jne    100205 <schedule+0x142>
			{
				if (proc_array[pid].p_times_run >= proc_array[pid].p_share)
  1001e3:	8b 70 50             	mov    0x50(%eax),%esi
  1001e6:	8d 78 50             	lea    0x50(%eax),%edi
  1001e9:	3b b2 ac 70 10 00    	cmp    0x1070ac(%edx),%esi
  1001ef:	7c 09                	jl     1001fa <schedule+0x137>
					proc_array[pid].p_times_run = 0;
  1001f1:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
  1001f8:	eb 0b                	jmp    100205 <schedule+0x142>
				else
				{
					proc_array[pid].p_times_run++;
  1001fa:	46                   	inc    %esi
					run(&proc_array[pid]);
  1001fb:	83 ec 0c             	sub    $0xc,%esp
			{
				if (proc_array[pid].p_times_run >= proc_array[pid].p_share)
					proc_array[pid].p_times_run = 0;
				else
				{
					proc_array[pid].p_times_run++;
  1001fe:	89 37                	mov    %esi,(%edi)
  100200:	e9 13 ff ff ff       	jmp    100118 <schedule+0x55>
					run(&proc_array[pid]);
				}
			}
			pid = (pid + 1)%NPROCS;
  100205:	8d 43 01             	lea    0x1(%ebx),%eax
  100208:	99                   	cltd   
  100209:	f7 f9                	idiv   %ecx
  10020b:	89 d3                	mov    %edx,%ebx
		}
  10020d:	eb c5                	jmp    1001d4 <schedule+0x111>
	}
	else if (scheduling_algorithm == 4) //used for lottery scheduling 
  10020f:	83 f8 04             	cmp    $0x4,%eax
  100212:	75 4a                	jne    10025e <schedule+0x19b>
int myrand(void) {
    next = next * 1103515245 + 12345;
    return((unsigned)(next/65536) % 32768);
}
void mysrand(unsigned seed) {
    next = seed;
  100214:	c7 05 00 10 10 00 52 	movl   $0x52,0x101000
  10021b:	00 00 00 
		
		while (1)
		{
			//int random_num = myrand();
			int curr_ticket = (myrand() %4) + 1;
			if (proc_array[pid].p_ticket == curr_ticket && 						proc_array[pid].p_state == P_RUNNABLE)
  10021e:	be 04 00 00 00       	mov    $0x4,%esi
				run(&proc_array[pid]);
			pid = (pid + 1) % NPROCS;
  100223:	bf 05 00 00 00       	mov    $0x5,%edi
		mysrand(82);
		
		while (1)
		{
			//int random_num = myrand();
			int curr_ticket = (myrand() %4) + 1;
  100228:	e8 6f fe ff ff       	call   10009c <myrand>
			if (proc_array[pid].p_ticket == curr_ticket && 						proc_array[pid].p_state == P_RUNNABLE)
  10022d:	6b cb 60             	imul   $0x60,%ebx,%ecx
  100230:	99                   	cltd   
  100231:	f7 fe                	idiv   %esi
  100233:	42                   	inc    %edx
  100234:	39 91 b4 70 10 00    	cmp    %edx,0x1070b4(%ecx)
  10023a:	75 18                	jne    100254 <schedule+0x191>
  10023c:	83 b9 a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%ecx)
  100243:	75 0f                	jne    100254 <schedule+0x191>
				run(&proc_array[pid]);
  100245:	83 ec 0c             	sub    $0xc,%esp
  100248:	81 c1 58 70 10 00    	add    $0x107058,%ecx
  10024e:	51                   	push   %ecx
  10024f:	e9 cb fe ff ff       	jmp    10011f <schedule+0x5c>
			pid = (pid + 1) % NPROCS;
  100254:	8d 43 01             	lea    0x1(%ebx),%eax
  100257:	99                   	cltd   
  100258:	f7 ff                	idiv   %edi
  10025a:	89 d3                	mov    %edx,%ebx
		}
  10025c:	eb ca                	jmp    100228 <schedule+0x165>
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10025e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100264:	50                   	push   %eax
  100265:	68 0c 0c 10 00       	push   $0x100c0c
  10026a:	68 00 01 00 00       	push   $0x100
  10026f:	52                   	push   %edx
  100270:	e8 7d 09 00 00       	call   100bf2 <console_printf>
  100275:	83 c4 10             	add    $0x10,%esp
  100278:	a3 00 80 19 00       	mov    %eax,0x198000
  10027d:	eb fe                	jmp    10027d <schedule+0x1ba>

0010027f <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10027f:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100280:	a1 a0 7a 10 00       	mov    0x107aa0,%eax
  100285:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10028a:	56                   	push   %esi
  10028b:	53                   	push   %ebx
  10028c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100290:	8d 78 04             	lea    0x4(%eax),%edi
  100293:	89 de                	mov    %ebx,%esi
  100295:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100297:	8b 53 28             	mov    0x28(%ebx),%edx
  10029a:	83 ea 20             	sub    $0x20,%edx
  10029d:	83 fa 16             	cmp    $0x16,%edx
  1002a0:	77 67                	ja     100309 <interrupt+0x8a>
  1002a2:	ff 24 95 30 0c 10 00 	jmp    *0x100c30(,%edx,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1002a9:	e8 15 fe ff ff       	call   1000c3 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002ae:	a1 a0 7a 10 00       	mov    0x107aa0,%eax
		current->p_exit_status = reg->reg_eax;
  1002b3:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002b6:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1002bd:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1002c0:	e8 fe fd ff ff       	call   1000c3 <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  1002c5:	a1 00 80 19 00       	mov    0x198000,%eax
		run(current);
  1002ca:	83 ec 0c             	sub    $0xc,%esp

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  1002cd:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002d0:	66 89 10             	mov    %dx,(%eax)
  1002d3:	83 c0 02             	add    $0x2,%eax
  1002d6:	a3 00 80 19 00       	mov    %eax,0x198000
		run(current);
  1002db:	ff 35 a0 7a 10 00    	pushl  0x107aa0
  1002e1:	eb 04                	jmp    1002e7 <interrupt+0x68>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1002e3:	83 ec 0c             	sub    $0xc,%esp
  1002e6:	50                   	push   %eax
  1002e7:	e8 61 03 00 00       	call   10064d <run>
	
	case INT_PRIORITY_SET:
		current->p_priority = reg->reg_eax;
  1002ec:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002ef:	89 50 50             	mov    %edx,0x50(%eax)
  1002f2:	eb ef                	jmp    1002e3 <interrupt+0x64>
		run(current);
	
	case INT_PRIORITY_SHARE:
		current->p_share = reg->reg_eax;
  1002f4:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002f7:	89 50 54             	mov    %edx,0x54(%eax)
  1002fa:	eb e7                	jmp    1002e3 <interrupt+0x64>
		run(current);
	
	case INT_LOTTERY_TICKET_SET:
		current->p_ticket = reg->reg_eax;
  1002fc:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002ff:	89 50 5c             	mov    %edx,0x5c(%eax)
  100302:	eb df                	jmp    1002e3 <interrupt+0x64>
		
	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100304:	e8 ba fd ff ff       	call   1000c3 <schedule>
  100309:	eb fe                	jmp    100309 <interrupt+0x8a>

0010030b <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10030b:	57                   	push   %edi
  10030c:	56                   	push   %esi
  10030d:	53                   	push   %ebx
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10030e:	e8 19 01 00 00       	call   10042c <segments_init>
	interrupt_controller_init(0);
  100313:	83 ec 0c             	sub    $0xc,%esp
  100316:	6a 00                	push   $0x0
  100318:	e8 0a 02 00 00       	call   100527 <interrupt_controller_init>
	console_clear();
  10031d:	e8 8e 02 00 00       	call   1005b0 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100322:	83 c4 0c             	add    $0xc,%esp
  100325:	68 e0 01 00 00       	push   $0x1e0
  10032a:	6a 00                	push   $0x0
  10032c:	68 58 70 10 00       	push   $0x107058
  100331:	e8 5a 04 00 00       	call   100790 <memset>
  100336:	ba 58 70 10 00       	mov    $0x107058,%edx
  10033b:	31 c0                	xor    %eax,%eax
  10033d:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100340:	89 02                	mov    %eax,(%edx)
		proc_array[i].p_ticket = i;
  100342:	89 42 5c             	mov    %eax,0x5c(%edx)
	interrupt_controller_init(0);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100345:	40                   	inc    %eax
		proc_array[i].p_pid = i;
		proc_array[i].p_ticket = i;
		proc_array[i].p_state = P_EMPTY;
  100346:	c7 42 48 00 00 00 00 	movl   $0x0,0x48(%edx)
	interrupt_controller_init(0);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10034d:	83 c2 60             	add    $0x60,%edx
  100350:	83 f8 05             	cmp    $0x5,%eax
  100353:	75 eb                	jne    100340 <start+0x35>
		proc_array[i].p_pid = i;
		proc_array[i].p_ticket = i;
		proc_array[i].p_state = P_EMPTY;
		//proc_array[i].p_times_run = 0;
	}
	proc_array[1].p_share = 4;
  100355:	c7 05 0c 71 10 00 04 	movl   $0x4,0x10710c
  10035c:	00 00 00 
	proc_array[3].p_share = 2;
	proc_array[4].p_share = 5;
	proc_array[1].p_times_run = 1;//first process run initially in this function
	proc_array[2].p_times_run = 0;
	proc_array[3].p_times_run = 0;
	proc_array[4].p_times_run = 0;
  10035f:	bb b8 70 10 00       	mov    $0x1070b8,%ebx
  100364:	bf 00 00 30 00       	mov    $0x300000,%edi
		proc_array[i].p_ticket = i;
		proc_array[i].p_state = P_EMPTY;
		//proc_array[i].p_times_run = 0;
	}
	proc_array[1].p_share = 4;
	proc_array[2].p_share = 3;
  100369:	c7 05 6c 71 10 00 03 	movl   $0x3,0x10716c
  100370:	00 00 00 
	proc_array[3].p_share = 2;
	proc_array[4].p_share = 5;
	proc_array[1].p_times_run = 1;//first process run initially in this function
	proc_array[2].p_times_run = 0;
	proc_array[3].p_times_run = 0;
	proc_array[4].p_times_run = 0;
  100373:	31 f6                	xor    %esi,%esi
		proc_array[i].p_state = P_EMPTY;
		//proc_array[i].p_times_run = 0;
	}
	proc_array[1].p_share = 4;
	proc_array[2].p_share = 3;
	proc_array[3].p_share = 2;
  100375:	c7 05 cc 71 10 00 02 	movl   $0x2,0x1071cc
  10037c:	00 00 00 
	proc_array[4].p_share = 5;
  10037f:	c7 05 2c 72 10 00 05 	movl   $0x5,0x10722c
  100386:	00 00 00 
	proc_array[1].p_times_run = 1;//first process run initially in this function
  100389:	c7 05 10 71 10 00 01 	movl   $0x1,0x107110
  100390:	00 00 00 
	proc_array[2].p_times_run = 0;
  100393:	c7 05 70 71 10 00 00 	movl   $0x0,0x107170
  10039a:	00 00 00 
	proc_array[3].p_times_run = 0;
  10039d:	c7 05 d0 71 10 00 00 	movl   $0x0,0x1071d0
  1003a4:	00 00 00 
	proc_array[4].p_times_run = 0;
  1003a7:	c7 05 30 72 10 00 00 	movl   $0x0,0x107230
  1003ae:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1003b1:	83 ec 0c             	sub    $0xc,%esp
  1003b4:	53                   	push   %ebx
  1003b5:	e8 aa 02 00 00       	call   100664 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003ba:	58                   	pop    %eax
  1003bb:	5a                   	pop    %edx
  1003bc:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1003bf:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003c2:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003c8:	50                   	push   %eax
  1003c9:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003ca:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003cb:	e8 d0 02 00 00       	call   1006a0 <program_loader>
	proc_array[4].p_times_run = 0;
	

	
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003d0:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003d3:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  1003da:	83 c3 60             	add    $0x60,%ebx
	proc_array[4].p_times_run = 0;
	

	
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003dd:	83 fe 04             	cmp    $0x4,%esi
  1003e0:	75 cf                	jne    1003b1 <start+0xa6>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 4;

	// Switch to the first process.
	run(&proc_array[1]);
  1003e2:	83 ec 0c             	sub    $0xc,%esp
  1003e5:	68 b8 70 10 00       	push   $0x1070b8
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
	}
	proc_array[1].p_priority = 16;
  1003ea:	c7 05 08 71 10 00 10 	movl   $0x10,0x107108
  1003f1:	00 00 00 
	proc_array[2].p_priority = 12;
  1003f4:	c7 05 68 71 10 00 0c 	movl   $0xc,0x107168
  1003fb:	00 00 00 
	proc_array[3].p_priority = 60;	
  1003fe:	c7 05 c8 71 10 00 3c 	movl   $0x3c,0x1071c8
  100405:	00 00 00 
	proc_array[4].p_priority = 10;
  100408:	c7 05 28 72 10 00 0a 	movl   $0xa,0x107228
  10040f:	00 00 00 

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100412:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100419:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 4;
  10041c:	c7 05 a4 7a 10 00 04 	movl   $0x4,0x107aa4
  100423:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100426:	e8 22 02 00 00       	call   10064d <run>
  10042b:	90                   	nop

0010042c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10042c:	b8 38 72 10 00       	mov    $0x107238,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100431:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100436:	89 c2                	mov    %eax,%edx
  100438:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10043b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10043c:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100441:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100444:	66 a3 3e 10 10 00    	mov    %ax,0x10103e
  10044a:	c1 e8 18             	shr    $0x18,%eax
  10044d:	88 15 40 10 10 00    	mov    %dl,0x101040
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100453:	ba a0 72 10 00       	mov    $0x1072a0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100458:	a2 43 10 10 00       	mov    %al,0x101043
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10045d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10045f:	66 c7 05 3c 10 10 00 	movw   $0x68,0x10103c
  100466:	68 00 
  100468:	c6 05 42 10 10 00 40 	movb   $0x40,0x101042
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10046f:	c6 05 41 10 10 00 89 	movb   $0x89,0x101041

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100476:	c7 05 3c 72 10 00 00 	movl   $0x180000,0x10723c
  10047d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100480:	66 c7 05 40 72 10 00 	movw   $0x10,0x107240
  100487:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100489:	66 89 0c c5 a0 72 10 	mov    %cx,0x1072a0(,%eax,8)
  100490:	00 
  100491:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100498:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10049d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1004a2:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1004a7:	40                   	inc    %eax
  1004a8:	3d 00 01 00 00       	cmp    $0x100,%eax
  1004ad:	75 da                	jne    100489 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004af:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004b4:	ba a0 72 10 00       	mov    $0x1072a0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004b9:	66 a3 a0 73 10 00    	mov    %ax,0x1073a0
  1004bf:	c1 e8 10             	shr    $0x10,%eax
  1004c2:	66 a3 a6 73 10 00    	mov    %ax,0x1073a6
  1004c8:	b8 30 00 00 00       	mov    $0x30,%eax
  1004cd:	66 c7 05 a2 73 10 00 	movw   $0x8,0x1073a2
  1004d4:	08 00 
  1004d6:	c6 05 a4 73 10 00 00 	movb   $0x0,0x1073a4
  1004dd:	c6 05 a5 73 10 00 8e 	movb   $0x8e,0x1073a5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004e4:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1004eb:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004f2:	66 89 0c c5 a0 72 10 	mov    %cx,0x1072a0(,%eax,8)
  1004f9:	00 
  1004fa:	c1 e9 10             	shr    $0x10,%ecx
  1004fd:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100502:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100507:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10050c:	40                   	inc    %eax
  10050d:	83 f8 3a             	cmp    $0x3a,%eax
  100510:	75 d2                	jne    1004e4 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100512:	b0 28                	mov    $0x28,%al
  100514:	0f 01 15 04 10 10 00 	lgdtl  0x101004
  10051b:	0f 00 d8             	ltr    %ax
  10051e:	0f 01 1d 0c 10 10 00 	lidtl  0x10100c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100525:	5b                   	pop    %ebx
  100526:	c3                   	ret    

00100527 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100527:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100528:	b0 ff                	mov    $0xff,%al
  10052a:	57                   	push   %edi
  10052b:	56                   	push   %esi
  10052c:	53                   	push   %ebx
  10052d:	bb 21 00 00 00       	mov    $0x21,%ebx
  100532:	89 da                	mov    %ebx,%edx
  100534:	ee                   	out    %al,(%dx)
  100535:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10053a:	89 ca                	mov    %ecx,%edx
  10053c:	ee                   	out    %al,(%dx)
  10053d:	be 11 00 00 00       	mov    $0x11,%esi
  100542:	bf 20 00 00 00       	mov    $0x20,%edi
  100547:	89 f0                	mov    %esi,%eax
  100549:	89 fa                	mov    %edi,%edx
  10054b:	ee                   	out    %al,(%dx)
  10054c:	b0 20                	mov    $0x20,%al
  10054e:	89 da                	mov    %ebx,%edx
  100550:	ee                   	out    %al,(%dx)
  100551:	b0 04                	mov    $0x4,%al
  100553:	ee                   	out    %al,(%dx)
  100554:	b0 03                	mov    $0x3,%al
  100556:	ee                   	out    %al,(%dx)
  100557:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10055c:	89 f0                	mov    %esi,%eax
  10055e:	89 ea                	mov    %ebp,%edx
  100560:	ee                   	out    %al,(%dx)
  100561:	b0 28                	mov    $0x28,%al
  100563:	89 ca                	mov    %ecx,%edx
  100565:	ee                   	out    %al,(%dx)
  100566:	b0 02                	mov    $0x2,%al
  100568:	ee                   	out    %al,(%dx)
  100569:	b0 01                	mov    $0x1,%al
  10056b:	ee                   	out    %al,(%dx)
  10056c:	b0 68                	mov    $0x68,%al
  10056e:	89 fa                	mov    %edi,%edx
  100570:	ee                   	out    %al,(%dx)
  100571:	be 0a 00 00 00       	mov    $0xa,%esi
  100576:	89 f0                	mov    %esi,%eax
  100578:	ee                   	out    %al,(%dx)
  100579:	b0 68                	mov    $0x68,%al
  10057b:	89 ea                	mov    %ebp,%edx
  10057d:	ee                   	out    %al,(%dx)
  10057e:	89 f0                	mov    %esi,%eax
  100580:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100581:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100586:	89 da                	mov    %ebx,%edx
  100588:	19 c0                	sbb    %eax,%eax
  10058a:	f7 d0                	not    %eax
  10058c:	05 ff 00 00 00       	add    $0xff,%eax
  100591:	ee                   	out    %al,(%dx)
  100592:	b0 ff                	mov    $0xff,%al
  100594:	89 ca                	mov    %ecx,%edx
  100596:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100597:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10059c:	74 0d                	je     1005ab <interrupt_controller_init+0x84>
  10059e:	b2 43                	mov    $0x43,%dl
  1005a0:	b0 34                	mov    $0x34,%al
  1005a2:	ee                   	out    %al,(%dx)
  1005a3:	b0 9c                	mov    $0x9c,%al
  1005a5:	b2 40                	mov    $0x40,%dl
  1005a7:	ee                   	out    %al,(%dx)
  1005a8:	b0 2e                	mov    $0x2e,%al
  1005aa:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1005ab:	5b                   	pop    %ebx
  1005ac:	5e                   	pop    %esi
  1005ad:	5f                   	pop    %edi
  1005ae:	5d                   	pop    %ebp
  1005af:	c3                   	ret    

001005b0 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005b0:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005b1:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005b3:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005b4:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1005bb:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1005be:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1005c4:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1005ca:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1005cd:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1005d2:	75 ea                	jne    1005be <console_clear+0xe>
  1005d4:	be d4 03 00 00       	mov    $0x3d4,%esi
  1005d9:	b0 0e                	mov    $0xe,%al
  1005db:	89 f2                	mov    %esi,%edx
  1005dd:	ee                   	out    %al,(%dx)
  1005de:	31 c9                	xor    %ecx,%ecx
  1005e0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1005e5:	88 c8                	mov    %cl,%al
  1005e7:	89 da                	mov    %ebx,%edx
  1005e9:	ee                   	out    %al,(%dx)
  1005ea:	b0 0f                	mov    $0xf,%al
  1005ec:	89 f2                	mov    %esi,%edx
  1005ee:	ee                   	out    %al,(%dx)
  1005ef:	88 c8                	mov    %cl,%al
  1005f1:	89 da                	mov    %ebx,%edx
  1005f3:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1005f4:	5b                   	pop    %ebx
  1005f5:	5e                   	pop    %esi
  1005f6:	c3                   	ret    

001005f7 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1005f7:	ba 64 00 00 00       	mov    $0x64,%edx
  1005fc:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1005fd:	a8 01                	test   $0x1,%al
  1005ff:	74 45                	je     100646 <console_read_digit+0x4f>
  100601:	b2 60                	mov    $0x60,%dl
  100603:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100604:	8d 50 fe             	lea    -0x2(%eax),%edx
  100607:	80 fa 08             	cmp    $0x8,%dl
  10060a:	77 05                	ja     100611 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10060c:	0f b6 c0             	movzbl %al,%eax
  10060f:	48                   	dec    %eax
  100610:	c3                   	ret    
	else if (data == 0x0B)
  100611:	3c 0b                	cmp    $0xb,%al
  100613:	74 35                	je     10064a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100615:	8d 50 b9             	lea    -0x47(%eax),%edx
  100618:	80 fa 02             	cmp    $0x2,%dl
  10061b:	77 07                	ja     100624 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10061d:	0f b6 c0             	movzbl %al,%eax
  100620:	83 e8 40             	sub    $0x40,%eax
  100623:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100624:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100627:	80 fa 02             	cmp    $0x2,%dl
  10062a:	77 07                	ja     100633 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10062c:	0f b6 c0             	movzbl %al,%eax
  10062f:	83 e8 47             	sub    $0x47,%eax
  100632:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100633:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100636:	80 fa 02             	cmp    $0x2,%dl
  100639:	77 07                	ja     100642 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10063b:	0f b6 c0             	movzbl %al,%eax
  10063e:	83 e8 4e             	sub    $0x4e,%eax
  100641:	c3                   	ret    
	else if (data == 0x53)
  100642:	3c 53                	cmp    $0x53,%al
  100644:	74 04                	je     10064a <console_read_digit+0x53>
  100646:	83 c8 ff             	or     $0xffffffff,%eax
  100649:	c3                   	ret    
  10064a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10064c:	c3                   	ret    

0010064d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10064d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100651:	a3 a0 7a 10 00       	mov    %eax,0x107aa0

	asm volatile("movl %0,%%esp\n\t"
  100656:	83 c0 04             	add    $0x4,%eax
  100659:	89 c4                	mov    %eax,%esp
  10065b:	61                   	popa   
  10065c:	07                   	pop    %es
  10065d:	1f                   	pop    %ds
  10065e:	83 c4 08             	add    $0x8,%esp
  100661:	cf                   	iret   
  100662:	eb fe                	jmp    100662 <run+0x15>

00100664 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100664:	53                   	push   %ebx
  100665:	83 ec 0c             	sub    $0xc,%esp
  100668:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10066c:	6a 44                	push   $0x44
  10066e:	6a 00                	push   $0x0
  100670:	8d 43 04             	lea    0x4(%ebx),%eax
  100673:	50                   	push   %eax
  100674:	e8 17 01 00 00       	call   100790 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100679:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10067f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100685:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10068b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100691:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100698:	83 c4 18             	add    $0x18,%esp
  10069b:	5b                   	pop    %ebx
  10069c:	c3                   	ret    
  10069d:	90                   	nop
  10069e:	90                   	nop
  10069f:	90                   	nop

001006a0 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1006a0:	55                   	push   %ebp
  1006a1:	57                   	push   %edi
  1006a2:	56                   	push   %esi
  1006a3:	53                   	push   %ebx
  1006a4:	83 ec 1c             	sub    $0x1c,%esp
  1006a7:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1006ab:	83 f8 03             	cmp    $0x3,%eax
  1006ae:	7f 04                	jg     1006b4 <program_loader+0x14>
  1006b0:	85 c0                	test   %eax,%eax
  1006b2:	79 02                	jns    1006b6 <program_loader+0x16>
  1006b4:	eb fe                	jmp    1006b4 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1006b6:	8b 34 c5 44 10 10 00 	mov    0x101044(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1006bd:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1006c3:	74 02                	je     1006c7 <program_loader+0x27>
  1006c5:	eb fe                	jmp    1006c5 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006c7:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1006ca:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006ce:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1006d0:	c1 e5 05             	shl    $0x5,%ebp
  1006d3:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1006d6:	eb 3f                	jmp    100717 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1006d8:	83 3b 01             	cmpl   $0x1,(%ebx)
  1006db:	75 37                	jne    100714 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1006dd:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006e0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1006e3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006e6:	01 c7                	add    %eax,%edi
	memsz += va;
  1006e8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1006ea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1006ef:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1006f3:	52                   	push   %edx
  1006f4:	89 fa                	mov    %edi,%edx
  1006f6:	29 c2                	sub    %eax,%edx
  1006f8:	52                   	push   %edx
  1006f9:	8b 53 04             	mov    0x4(%ebx),%edx
  1006fc:	01 f2                	add    %esi,%edx
  1006fe:	52                   	push   %edx
  1006ff:	50                   	push   %eax
  100700:	e8 27 00 00 00       	call   10072c <memcpy>
  100705:	83 c4 10             	add    $0x10,%esp
  100708:	eb 04                	jmp    10070e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10070a:	c6 07 00             	movb   $0x0,(%edi)
  10070d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10070e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100712:	72 f6                	jb     10070a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100714:	83 c3 20             	add    $0x20,%ebx
  100717:	39 eb                	cmp    %ebp,%ebx
  100719:	72 bd                	jb     1006d8 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10071b:	8b 56 18             	mov    0x18(%esi),%edx
  10071e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100722:	89 10                	mov    %edx,(%eax)
}
  100724:	83 c4 1c             	add    $0x1c,%esp
  100727:	5b                   	pop    %ebx
  100728:	5e                   	pop    %esi
  100729:	5f                   	pop    %edi
  10072a:	5d                   	pop    %ebp
  10072b:	c3                   	ret    

0010072c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10072c:	56                   	push   %esi
  10072d:	31 d2                	xor    %edx,%edx
  10072f:	53                   	push   %ebx
  100730:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100734:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100738:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10073c:	eb 08                	jmp    100746 <memcpy+0x1a>
		*d++ = *s++;
  10073e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100741:	4e                   	dec    %esi
  100742:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100745:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100746:	85 f6                	test   %esi,%esi
  100748:	75 f4                	jne    10073e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10074a:	5b                   	pop    %ebx
  10074b:	5e                   	pop    %esi
  10074c:	c3                   	ret    

0010074d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10074d:	57                   	push   %edi
  10074e:	56                   	push   %esi
  10074f:	53                   	push   %ebx
  100750:	8b 44 24 10          	mov    0x10(%esp),%eax
  100754:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100758:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10075c:	39 c7                	cmp    %eax,%edi
  10075e:	73 26                	jae    100786 <memmove+0x39>
  100760:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100763:	39 c6                	cmp    %eax,%esi
  100765:	76 1f                	jbe    100786 <memmove+0x39>
		s += n, d += n;
  100767:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10076a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10076c:	eb 07                	jmp    100775 <memmove+0x28>
			*--d = *--s;
  10076e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100771:	4a                   	dec    %edx
  100772:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100775:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100776:	85 d2                	test   %edx,%edx
  100778:	75 f4                	jne    10076e <memmove+0x21>
  10077a:	eb 10                	jmp    10078c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10077c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10077f:	4a                   	dec    %edx
  100780:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100783:	41                   	inc    %ecx
  100784:	eb 02                	jmp    100788 <memmove+0x3b>
  100786:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100788:	85 d2                	test   %edx,%edx
  10078a:	75 f0                	jne    10077c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10078c:	5b                   	pop    %ebx
  10078d:	5e                   	pop    %esi
  10078e:	5f                   	pop    %edi
  10078f:	c3                   	ret    

00100790 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100790:	53                   	push   %ebx
  100791:	8b 44 24 08          	mov    0x8(%esp),%eax
  100795:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100799:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10079d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10079f:	eb 04                	jmp    1007a5 <memset+0x15>
		*p++ = c;
  1007a1:	88 1a                	mov    %bl,(%edx)
  1007a3:	49                   	dec    %ecx
  1007a4:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1007a5:	85 c9                	test   %ecx,%ecx
  1007a7:	75 f8                	jne    1007a1 <memset+0x11>
		*p++ = c;
	return v;
}
  1007a9:	5b                   	pop    %ebx
  1007aa:	c3                   	ret    

001007ab <strlen>:

size_t
strlen(const char *s)
{
  1007ab:	8b 54 24 04          	mov    0x4(%esp),%edx
  1007af:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007b1:	eb 01                	jmp    1007b4 <strlen+0x9>
		++n;
  1007b3:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007b4:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1007b8:	75 f9                	jne    1007b3 <strlen+0x8>
		++n;
	return n;
}
  1007ba:	c3                   	ret    

001007bb <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1007bb:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1007bf:	31 c0                	xor    %eax,%eax
  1007c1:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007c5:	eb 01                	jmp    1007c8 <strnlen+0xd>
		++n;
  1007c7:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007c8:	39 d0                	cmp    %edx,%eax
  1007ca:	74 06                	je     1007d2 <strnlen+0x17>
  1007cc:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1007d0:	75 f5                	jne    1007c7 <strnlen+0xc>
		++n;
	return n;
}
  1007d2:	c3                   	ret    

001007d3 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007d3:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1007d4:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007d9:	53                   	push   %ebx
  1007da:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1007dc:	76 05                	jbe    1007e3 <console_putc+0x10>
  1007de:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007e3:	80 fa 0a             	cmp    $0xa,%dl
  1007e6:	75 2c                	jne    100814 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007e8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007ee:	be 50 00 00 00       	mov    $0x50,%esi
  1007f3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1007f5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007f8:	99                   	cltd   
  1007f9:	f7 fe                	idiv   %esi
  1007fb:	89 de                	mov    %ebx,%esi
  1007fd:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1007ff:	eb 07                	jmp    100808 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100801:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100804:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100805:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100808:	83 f8 50             	cmp    $0x50,%eax
  10080b:	75 f4                	jne    100801 <console_putc+0x2e>
  10080d:	29 d0                	sub    %edx,%eax
  10080f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100812:	eb 0b                	jmp    10081f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100814:	0f b6 d2             	movzbl %dl,%edx
  100817:	09 ca                	or     %ecx,%edx
  100819:	66 89 13             	mov    %dx,(%ebx)
  10081c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10081f:	5b                   	pop    %ebx
  100820:	5e                   	pop    %esi
  100821:	c3                   	ret    

00100822 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100822:	56                   	push   %esi
  100823:	53                   	push   %ebx
  100824:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100828:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10082b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10082f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100834:	75 04                	jne    10083a <fill_numbuf+0x18>
  100836:	85 d2                	test   %edx,%edx
  100838:	74 10                	je     10084a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10083a:	89 d0                	mov    %edx,%eax
  10083c:	31 d2                	xor    %edx,%edx
  10083e:	f7 f1                	div    %ecx
  100840:	4b                   	dec    %ebx
  100841:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100844:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100846:	89 c2                	mov    %eax,%edx
  100848:	eb ec                	jmp    100836 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10084a:	89 d8                	mov    %ebx,%eax
  10084c:	5b                   	pop    %ebx
  10084d:	5e                   	pop    %esi
  10084e:	c3                   	ret    

0010084f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10084f:	55                   	push   %ebp
  100850:	57                   	push   %edi
  100851:	56                   	push   %esi
  100852:	53                   	push   %ebx
  100853:	83 ec 38             	sub    $0x38,%esp
  100856:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10085a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10085e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100862:	e9 60 03 00 00       	jmp    100bc7 <console_vprintf+0x378>
		if (*format != '%') {
  100867:	80 fa 25             	cmp    $0x25,%dl
  10086a:	74 13                	je     10087f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10086c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100870:	0f b6 d2             	movzbl %dl,%edx
  100873:	89 f0                	mov    %esi,%eax
  100875:	e8 59 ff ff ff       	call   1007d3 <console_putc>
  10087a:	e9 45 03 00 00       	jmp    100bc4 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10087f:	47                   	inc    %edi
  100880:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100887:	00 
  100888:	eb 12                	jmp    10089c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10088a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10088b:	8a 11                	mov    (%ecx),%dl
  10088d:	84 d2                	test   %dl,%dl
  10088f:	74 1a                	je     1008ab <console_vprintf+0x5c>
  100891:	89 e8                	mov    %ebp,%eax
  100893:	38 c2                	cmp    %al,%dl
  100895:	75 f3                	jne    10088a <console_vprintf+0x3b>
  100897:	e9 3f 03 00 00       	jmp    100bdb <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10089c:	8a 17                	mov    (%edi),%dl
  10089e:	84 d2                	test   %dl,%dl
  1008a0:	74 0b                	je     1008ad <console_vprintf+0x5e>
  1008a2:	b9 8c 0c 10 00       	mov    $0x100c8c,%ecx
  1008a7:	89 d5                	mov    %edx,%ebp
  1008a9:	eb e0                	jmp    10088b <console_vprintf+0x3c>
  1008ab:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1008ad:	8d 42 cf             	lea    -0x31(%edx),%eax
  1008b0:	3c 08                	cmp    $0x8,%al
  1008b2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008b9:	00 
  1008ba:	76 13                	jbe    1008cf <console_vprintf+0x80>
  1008bc:	eb 1d                	jmp    1008db <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1008be:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1008c3:	0f be c0             	movsbl %al,%eax
  1008c6:	47                   	inc    %edi
  1008c7:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1008cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1008cf:	8a 07                	mov    (%edi),%al
  1008d1:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008d4:	80 fa 09             	cmp    $0x9,%dl
  1008d7:	76 e5                	jbe    1008be <console_vprintf+0x6f>
  1008d9:	eb 18                	jmp    1008f3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1008db:	80 fa 2a             	cmp    $0x2a,%dl
  1008de:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008e5:	ff 
  1008e6:	75 0b                	jne    1008f3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008e8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008eb:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008ec:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008ef:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1008f3:	83 cd ff             	or     $0xffffffff,%ebp
  1008f6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1008f9:	75 37                	jne    100932 <console_vprintf+0xe3>
			++format;
  1008fb:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1008fc:	31 ed                	xor    %ebp,%ebp
  1008fe:	8a 07                	mov    (%edi),%al
  100900:	8d 50 d0             	lea    -0x30(%eax),%edx
  100903:	80 fa 09             	cmp    $0x9,%dl
  100906:	76 0d                	jbe    100915 <console_vprintf+0xc6>
  100908:	eb 17                	jmp    100921 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10090a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10090d:	0f be c0             	movsbl %al,%eax
  100910:	47                   	inc    %edi
  100911:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100915:	8a 07                	mov    (%edi),%al
  100917:	8d 50 d0             	lea    -0x30(%eax),%edx
  10091a:	80 fa 09             	cmp    $0x9,%dl
  10091d:	76 eb                	jbe    10090a <console_vprintf+0xbb>
  10091f:	eb 11                	jmp    100932 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100921:	3c 2a                	cmp    $0x2a,%al
  100923:	75 0b                	jne    100930 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100925:	83 c3 04             	add    $0x4,%ebx
				++format;
  100928:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100929:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10092c:	85 ed                	test   %ebp,%ebp
  10092e:	79 02                	jns    100932 <console_vprintf+0xe3>
  100930:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100932:	8a 07                	mov    (%edi),%al
  100934:	3c 64                	cmp    $0x64,%al
  100936:	74 34                	je     10096c <console_vprintf+0x11d>
  100938:	7f 1d                	jg     100957 <console_vprintf+0x108>
  10093a:	3c 58                	cmp    $0x58,%al
  10093c:	0f 84 a2 00 00 00    	je     1009e4 <console_vprintf+0x195>
  100942:	3c 63                	cmp    $0x63,%al
  100944:	0f 84 bf 00 00 00    	je     100a09 <console_vprintf+0x1ba>
  10094a:	3c 43                	cmp    $0x43,%al
  10094c:	0f 85 d0 00 00 00    	jne    100a22 <console_vprintf+0x1d3>
  100952:	e9 a3 00 00 00       	jmp    1009fa <console_vprintf+0x1ab>
  100957:	3c 75                	cmp    $0x75,%al
  100959:	74 4d                	je     1009a8 <console_vprintf+0x159>
  10095b:	3c 78                	cmp    $0x78,%al
  10095d:	74 5c                	je     1009bb <console_vprintf+0x16c>
  10095f:	3c 73                	cmp    $0x73,%al
  100961:	0f 85 bb 00 00 00    	jne    100a22 <console_vprintf+0x1d3>
  100967:	e9 86 00 00 00       	jmp    1009f2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10096c:	83 c3 04             	add    $0x4,%ebx
  10096f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100972:	89 d1                	mov    %edx,%ecx
  100974:	c1 f9 1f             	sar    $0x1f,%ecx
  100977:	89 0c 24             	mov    %ecx,(%esp)
  10097a:	31 ca                	xor    %ecx,%edx
  10097c:	55                   	push   %ebp
  10097d:	29 ca                	sub    %ecx,%edx
  10097f:	68 94 0c 10 00       	push   $0x100c94
  100984:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100989:	8d 44 24 40          	lea    0x40(%esp),%eax
  10098d:	e8 90 fe ff ff       	call   100822 <fill_numbuf>
  100992:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100996:	58                   	pop    %eax
  100997:	5a                   	pop    %edx
  100998:	ba 01 00 00 00       	mov    $0x1,%edx
  10099d:	8b 04 24             	mov    (%esp),%eax
  1009a0:	83 e0 01             	and    $0x1,%eax
  1009a3:	e9 a5 00 00 00       	jmp    100a4d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1009a8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1009ab:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009b0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009b3:	55                   	push   %ebp
  1009b4:	68 94 0c 10 00       	push   $0x100c94
  1009b9:	eb 11                	jmp    1009cc <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1009bb:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1009be:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009c1:	55                   	push   %ebp
  1009c2:	68 a8 0c 10 00       	push   $0x100ca8
  1009c7:	b9 10 00 00 00       	mov    $0x10,%ecx
  1009cc:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009d0:	e8 4d fe ff ff       	call   100822 <fill_numbuf>
  1009d5:	ba 01 00 00 00       	mov    $0x1,%edx
  1009da:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1009de:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009e0:	59                   	pop    %ecx
  1009e1:	59                   	pop    %ecx
  1009e2:	eb 69                	jmp    100a4d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009e4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009e7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009ea:	55                   	push   %ebp
  1009eb:	68 94 0c 10 00       	push   $0x100c94
  1009f0:	eb d5                	jmp    1009c7 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1009f2:	83 c3 04             	add    $0x4,%ebx
  1009f5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1009f8:	eb 40                	jmp    100a3a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1009fa:	83 c3 04             	add    $0x4,%ebx
  1009fd:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a00:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a04:	e9 bd 01 00 00       	jmp    100bc6 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a09:	83 c3 04             	add    $0x4,%ebx
  100a0c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a0f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a13:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a18:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a1c:	88 44 24 24          	mov    %al,0x24(%esp)
  100a20:	eb 27                	jmp    100a49 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a22:	84 c0                	test   %al,%al
  100a24:	75 02                	jne    100a28 <console_vprintf+0x1d9>
  100a26:	b0 25                	mov    $0x25,%al
  100a28:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a2c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a31:	80 3f 00             	cmpb   $0x0,(%edi)
  100a34:	74 0a                	je     100a40 <console_vprintf+0x1f1>
  100a36:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a3e:	eb 09                	jmp    100a49 <console_vprintf+0x1fa>
				format--;
  100a40:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a44:	4f                   	dec    %edi
  100a45:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a49:	31 d2                	xor    %edx,%edx
  100a4b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a4d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a4f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a52:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a59:	74 1f                	je     100a7a <console_vprintf+0x22b>
  100a5b:	89 04 24             	mov    %eax,(%esp)
  100a5e:	eb 01                	jmp    100a61 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a60:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a61:	39 e9                	cmp    %ebp,%ecx
  100a63:	74 0a                	je     100a6f <console_vprintf+0x220>
  100a65:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a69:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a6d:	75 f1                	jne    100a60 <console_vprintf+0x211>
  100a6f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a72:	89 0c 24             	mov    %ecx,(%esp)
  100a75:	eb 1f                	jmp    100a96 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a77:	42                   	inc    %edx
  100a78:	eb 09                	jmp    100a83 <console_vprintf+0x234>
  100a7a:	89 d1                	mov    %edx,%ecx
  100a7c:	8b 14 24             	mov    (%esp),%edx
  100a7f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a83:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a87:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a8b:	75 ea                	jne    100a77 <console_vprintf+0x228>
  100a8d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a91:	89 14 24             	mov    %edx,(%esp)
  100a94:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a96:	85 c0                	test   %eax,%eax
  100a98:	74 0c                	je     100aa6 <console_vprintf+0x257>
  100a9a:	84 d2                	test   %dl,%dl
  100a9c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100aa3:	00 
  100aa4:	75 24                	jne    100aca <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100aa6:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100aab:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100ab2:	00 
  100ab3:	75 15                	jne    100aca <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100ab5:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ab9:	83 e0 08             	and    $0x8,%eax
  100abc:	83 f8 01             	cmp    $0x1,%eax
  100abf:	19 c9                	sbb    %ecx,%ecx
  100ac1:	f7 d1                	not    %ecx
  100ac3:	83 e1 20             	and    $0x20,%ecx
  100ac6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100aca:	3b 2c 24             	cmp    (%esp),%ebp
  100acd:	7e 0d                	jle    100adc <console_vprintf+0x28d>
  100acf:	84 d2                	test   %dl,%dl
  100ad1:	74 40                	je     100b13 <console_vprintf+0x2c4>
			zeros = precision - len;
  100ad3:	2b 2c 24             	sub    (%esp),%ebp
  100ad6:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100ada:	eb 3f                	jmp    100b1b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100adc:	84 d2                	test   %dl,%dl
  100ade:	74 33                	je     100b13 <console_vprintf+0x2c4>
  100ae0:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ae4:	83 e0 06             	and    $0x6,%eax
  100ae7:	83 f8 02             	cmp    $0x2,%eax
  100aea:	75 27                	jne    100b13 <console_vprintf+0x2c4>
  100aec:	45                   	inc    %ebp
  100aed:	75 24                	jne    100b13 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100aef:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100af1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100af4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100af9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100afc:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100aff:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b03:	7d 0e                	jge    100b13 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b05:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b09:	29 ca                	sub    %ecx,%edx
  100b0b:	29 c2                	sub    %eax,%edx
  100b0d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b11:	eb 08                	jmp    100b1b <console_vprintf+0x2cc>
  100b13:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b1a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b1b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b1f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b21:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b25:	2b 2c 24             	sub    (%esp),%ebp
  100b28:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b2d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b30:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b33:	29 c5                	sub    %eax,%ebp
  100b35:	89 f0                	mov    %esi,%eax
  100b37:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b3b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b3f:	eb 0f                	jmp    100b50 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b41:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b45:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b4a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b4b:	e8 83 fc ff ff       	call   1007d3 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b50:	85 ed                	test   %ebp,%ebp
  100b52:	7e 07                	jle    100b5b <console_vprintf+0x30c>
  100b54:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b59:	74 e6                	je     100b41 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b5b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b60:	89 c6                	mov    %eax,%esi
  100b62:	74 23                	je     100b87 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b64:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b69:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b6d:	e8 61 fc ff ff       	call   1007d3 <console_putc>
  100b72:	89 c6                	mov    %eax,%esi
  100b74:	eb 11                	jmp    100b87 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b76:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b7a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b7f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b80:	e8 4e fc ff ff       	call   1007d3 <console_putc>
  100b85:	eb 06                	jmp    100b8d <console_vprintf+0x33e>
  100b87:	89 f0                	mov    %esi,%eax
  100b89:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b8d:	85 f6                	test   %esi,%esi
  100b8f:	7f e5                	jg     100b76 <console_vprintf+0x327>
  100b91:	8b 34 24             	mov    (%esp),%esi
  100b94:	eb 15                	jmp    100bab <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b96:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b9a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b9b:	0f b6 11             	movzbl (%ecx),%edx
  100b9e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ba2:	e8 2c fc ff ff       	call   1007d3 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ba7:	ff 44 24 04          	incl   0x4(%esp)
  100bab:	85 f6                	test   %esi,%esi
  100bad:	7f e7                	jg     100b96 <console_vprintf+0x347>
  100baf:	eb 0f                	jmp    100bc0 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100bb1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bb5:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bba:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bbb:	e8 13 fc ff ff       	call   1007d3 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bc0:	85 ed                	test   %ebp,%ebp
  100bc2:	7f ed                	jg     100bb1 <console_vprintf+0x362>
  100bc4:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100bc6:	47                   	inc    %edi
  100bc7:	8a 17                	mov    (%edi),%dl
  100bc9:	84 d2                	test   %dl,%dl
  100bcb:	0f 85 96 fc ff ff    	jne    100867 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100bd1:	83 c4 38             	add    $0x38,%esp
  100bd4:	89 f0                	mov    %esi,%eax
  100bd6:	5b                   	pop    %ebx
  100bd7:	5e                   	pop    %esi
  100bd8:	5f                   	pop    %edi
  100bd9:	5d                   	pop    %ebp
  100bda:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bdb:	81 e9 8c 0c 10 00    	sub    $0x100c8c,%ecx
  100be1:	b8 01 00 00 00       	mov    $0x1,%eax
  100be6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100be8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100be9:	09 44 24 14          	or     %eax,0x14(%esp)
  100bed:	e9 aa fc ff ff       	jmp    10089c <console_vprintf+0x4d>

00100bf2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100bf2:	8d 44 24 10          	lea    0x10(%esp),%eax
  100bf6:	50                   	push   %eax
  100bf7:	ff 74 24 10          	pushl  0x10(%esp)
  100bfb:	ff 74 24 10          	pushl  0x10(%esp)
  100bff:	ff 74 24 10          	pushl  0x10(%esp)
  100c03:	e8 47 fc ff ff       	call   10084f <console_vprintf>
  100c08:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c0b:	c3                   	ret    
