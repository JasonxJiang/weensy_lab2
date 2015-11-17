
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
  100014:	e8 fb 01 00 00       	call   100214 <start>
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
  10006d:	e8 14 01 00 00       	call   100186 <interrupt>

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

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	56                   	push   %esi
  10009d:	53                   	push   %ebx
  10009e:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  1000a1:	a1 98 76 10 00       	mov    0x107698,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	int j = 0;
	int lowest_priority = 65535; //INT_MAX of 16 bit ints 
	if (scheduling_algorithm == 0)
  1000a8:	a1 9c 76 10 00       	mov    0x10769c,%eax
  1000ad:	85 c0                	test   %eax,%eax
  1000af:	75 24                	jne    1000d5 <schedule+0x39>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b1:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b6:	8d 42 01             	lea    0x1(%edx),%eax
  1000b9:	99                   	cltd   
  1000ba:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bc:	6b c2 54             	imul   $0x54,%edx,%eax
  1000bf:	83 b8 d4 6c 10 00 01 	cmpl   $0x1,0x106cd4(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
				run(&proc_array[pid]);//run(&proc_array[pid]);
  1000c8:	83 ec 0c             	sub    $0xc,%esp
  1000cb:	05 8c 6c 10 00       	add    $0x106c8c,%eax
  1000d0:	e9 8d 00 00 00       	jmp    100162 <schedule+0xc6>
		}
	else if (scheduling_algorithm == 2)
  1000d5:	83 f8 02             	cmp    $0x2,%eax
  1000d8:	75 39                	jne    100113 <schedule+0x77>
  1000da:	ba 01 00 00 00       	mov    $0x1,%edx
  1000df:	b0 01                	mov    $0x1,%al
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE)
  1000e1:	6b c8 54             	imul   $0x54,%eax,%ecx
  1000e4:	83 b9 d4 6c 10 00 01 	cmpl   $0x1,0x106cd4(%ecx)
  1000eb:	75 12                	jne    1000ff <schedule+0x63>
					run(&proc_array[j]);
  1000ed:	6b d2 54             	imul   $0x54,%edx,%edx
  1000f0:	83 ec 0c             	sub    $0xc,%esp
  1000f3:	81 c2 8c 6c 10 00    	add    $0x106c8c,%edx
  1000f9:	52                   	push   %edx
  1000fa:	e8 26 04 00 00       	call   100525 <run>
		}
	else if (scheduling_algorithm == 2)
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  1000ff:	40                   	inc    %eax
  100100:	83 f8 04             	cmp    $0x4,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);//run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 2)
  100103:	89 c2                	mov    %eax,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  100105:	7e da                	jle    1000e1 <schedule+0x45>
  100107:	ba 01 00 00 00       	mov    $0x1,%edx
  10010c:	b8 01 00 00 00       	mov    $0x1,%eax
  100111:	eb ce                	jmp    1000e1 <schedule+0x45>
					run(&proc_array[j]);
			}
		}

	}
	else if (scheduling_algorithm == 41)
  100113:	83 f8 29             	cmp    $0x29,%eax
  100116:	75 4d                	jne    100165 <schedule+0xc9>
  100118:	b9 ff ff 00 00       	mov    $0xffff,%ecx
			for (j = 0; j < NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority 	< lowest_priority)
				lowest_priority = proc_array[j].p_priority;
			}
						pid = (pid + 1) % NPROCS;
  10011d:	bb 05 00 00 00       	mov    $0x5,%ebx
					run(&proc_array[j]);
			}
		}

	}
	else if (scheduling_algorithm == 41)
  100122:	31 c0                	xor    %eax,%eax
	{
		while (1)
		{
			for (j = 0; j < NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority 	< lowest_priority)
  100124:	83 b8 d4 6c 10 00 01 	cmpl   $0x1,0x106cd4(%eax)
  10012b:	75 0c                	jne    100139 <schedule+0x9d>
  10012d:	8b b0 dc 6c 10 00    	mov    0x106cdc(%eax),%esi
  100133:	39 f1                	cmp    %esi,%ecx
  100135:	7e 02                	jle    100139 <schedule+0x9d>
  100137:	89 f1                	mov    %esi,%ecx
  100139:	83 c0 54             	add    $0x54,%eax
	}
	else if (scheduling_algorithm == 41)
	{
		while (1)
		{
			for (j = 0; j < NPROCS; j++)
  10013c:	3d a4 01 00 00       	cmp    $0x1a4,%eax
  100141:	75 e1                	jne    100124 <schedule+0x88>
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority 	< lowest_priority)
				lowest_priority = proc_array[j].p_priority;
			}
						pid = (pid + 1) % NPROCS;
  100143:	8d 42 01             	lea    0x1(%edx),%eax
  100146:	99                   	cltd   
  100147:	f7 fb                	idiv   %ebx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= lowest_priority)
  100149:	6b c2 54             	imul   $0x54,%edx,%eax
  10014c:	83 b8 d4 6c 10 00 01 	cmpl   $0x1,0x106cd4(%eax)
  100153:	75 cd                	jne    100122 <schedule+0x86>
  100155:	05 8c 6c 10 00       	add    $0x106c8c,%eax
  10015a:	39 48 50             	cmp    %ecx,0x50(%eax)
  10015d:	7f c3                	jg     100122 <schedule+0x86>
				run(&proc_array[pid]);//run(&proc_array[pid]);
  10015f:	83 ec 0c             	sub    $0xc,%esp
  100162:	50                   	push   %eax
  100163:	eb 95                	jmp    1000fa <schedule+0x5e>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100165:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10016b:	50                   	push   %eax
  10016c:	68 e4 0a 10 00       	push   $0x100ae4
  100171:	68 00 01 00 00       	push   $0x100
  100176:	52                   	push   %edx
  100177:	e8 4e 09 00 00       	call   100aca <console_printf>
  10017c:	83 c4 10             	add    $0x10,%esp
  10017f:	a3 00 80 19 00       	mov    %eax,0x198000
  100184:	eb fe                	jmp    100184 <schedule+0xe8>

00100186 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100186:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100187:	a1 98 76 10 00       	mov    0x107698,%eax
  10018c:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100191:	56                   	push   %esi
  100192:	53                   	push   %ebx
  100193:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100197:	8d 78 04             	lea    0x4(%eax),%edi
  10019a:	89 de                	mov    %ebx,%esi
  10019c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10019e:	8b 53 28             	mov    0x28(%ebx),%edx
  1001a1:	83 fa 32             	cmp    $0x32,%edx
  1001a4:	74 38                	je     1001de <interrupt+0x58>
  1001a6:	77 0e                	ja     1001b6 <interrupt+0x30>
  1001a8:	83 fa 30             	cmp    $0x30,%edx
  1001ab:	74 15                	je     1001c2 <interrupt+0x3c>
  1001ad:	77 18                	ja     1001c7 <interrupt+0x41>
  1001af:	83 fa 20             	cmp    $0x20,%edx
  1001b2:	74 59                	je     10020d <interrupt+0x87>
  1001b4:	eb 5c                	jmp    100212 <interrupt+0x8c>
  1001b6:	83 fa 33             	cmp    $0x33,%edx
  1001b9:	74 41                	je     1001fc <interrupt+0x76>
  1001bb:	83 fa 34             	cmp    $0x34,%edx
  1001be:	74 45                	je     100205 <interrupt+0x7f>
  1001c0:	eb 50                	jmp    100212 <interrupt+0x8c>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001c2:	e8 d5 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001c7:	a1 98 76 10 00       	mov    0x107698,%eax
		current->p_exit_status = reg->reg_eax;
  1001cc:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001cf:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001d6:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001d9:	e8 be fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  1001de:	a1 00 80 19 00       	mov    0x198000,%eax
		run(current);
  1001e3:	83 ec 0c             	sub    $0xc,%esp

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  1001e6:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001e9:	66 89 10             	mov    %dx,(%eax)
  1001ec:	83 c0 02             	add    $0x2,%eax
  1001ef:	a3 00 80 19 00       	mov    %eax,0x198000
		run(current);
  1001f4:	ff 35 98 76 10 00    	pushl  0x107698
  1001fa:	eb 04                	jmp    100200 <interrupt+0x7a>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001fc:	83 ec 0c             	sub    $0xc,%esp
  1001ff:	50                   	push   %eax
  100200:	e8 20 03 00 00       	call   100525 <run>
	
	case INT_PRIORITY_SET:
		current->p_priority = reg->reg_eax;
  100205:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100208:	89 50 50             	mov    %edx,0x50(%eax)
  10020b:	eb ef                	jmp    1001fc <interrupt+0x76>
		run(current);
	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10020d:	e8 8a fe ff ff       	call   10009c <schedule>
  100212:	eb fe                	jmp    100212 <interrupt+0x8c>

00100214 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100214:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100215:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10021a:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10021b:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10021d:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10021e:	bb e0 6c 10 00       	mov    $0x106ce0,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100223:	e8 dc 00 00 00       	call   100304 <segments_init>
	interrupt_controller_init(1);
  100228:	83 ec 0c             	sub    $0xc,%esp
  10022b:	6a 01                	push   $0x1
  10022d:	e8 cd 01 00 00       	call   1003ff <interrupt_controller_init>
	console_clear();
  100232:	e8 51 02 00 00       	call   100488 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100237:	83 c4 0c             	add    $0xc,%esp
  10023a:	68 a4 01 00 00       	push   $0x1a4
  10023f:	6a 00                	push   $0x0
  100241:	68 8c 6c 10 00       	push   $0x106c8c
  100246:	e8 1d 04 00 00       	call   100668 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10024b:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10024e:	c7 05 8c 6c 10 00 00 	movl   $0x0,0x106c8c
  100255:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100258:	c7 05 d4 6c 10 00 00 	movl   $0x0,0x106cd4
  10025f:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100262:	c7 05 e0 6c 10 00 01 	movl   $0x1,0x106ce0
  100269:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10026c:	c7 05 28 6d 10 00 00 	movl   $0x0,0x106d28
  100273:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100276:	c7 05 34 6d 10 00 02 	movl   $0x2,0x106d34
  10027d:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100280:	c7 05 7c 6d 10 00 00 	movl   $0x0,0x106d7c
  100287:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10028a:	c7 05 88 6d 10 00 03 	movl   $0x3,0x106d88
  100291:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100294:	c7 05 d0 6d 10 00 00 	movl   $0x0,0x106dd0
  10029b:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10029e:	c7 05 dc 6d 10 00 04 	movl   $0x4,0x106ddc
  1002a5:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002a8:	c7 05 24 6e 10 00 00 	movl   $0x0,0x106e24
  1002af:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002b2:	83 ec 0c             	sub    $0xc,%esp
  1002b5:	53                   	push   %ebx
  1002b6:	e8 81 02 00 00       	call   10053c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002bb:	58                   	pop    %eax
  1002bc:	5a                   	pop    %edx
  1002bd:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002c0:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002c3:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002c9:	50                   	push   %eax
  1002ca:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002cb:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002cc:	e8 a7 02 00 00       	call   100578 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002d1:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002d4:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  1002db:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002de:	83 fe 04             	cmp    $0x4,%esi
  1002e1:	75 cf                	jne    1002b2 <start+0x9e>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 41;

	// Switch to the first process.
	run(&proc_array[1]);
  1002e3:	83 ec 0c             	sub    $0xc,%esp
  1002e6:	68 e0 6c 10 00       	push   $0x106ce0
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002eb:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002f2:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 41;
  1002f5:	c7 05 9c 76 10 00 29 	movl   $0x29,0x10769c
  1002fc:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1002ff:	e8 21 02 00 00       	call   100525 <run>

00100304 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100304:	b8 30 6e 10 00       	mov    $0x106e30,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100309:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10030e:	89 c2                	mov    %eax,%edx
  100310:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100313:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100314:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100319:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10031c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100322:	c1 e8 18             	shr    $0x18,%eax
  100325:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10032b:	ba 98 6e 10 00       	mov    $0x106e98,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100330:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100335:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100337:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10033e:	68 00 
  100340:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100347:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10034e:	c7 05 34 6e 10 00 00 	movl   $0x180000,0x106e34
  100355:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100358:	66 c7 05 38 6e 10 00 	movw   $0x10,0x106e38
  10035f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100361:	66 89 0c c5 98 6e 10 	mov    %cx,0x106e98(,%eax,8)
  100368:	00 
  100369:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100370:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100375:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10037a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10037f:	40                   	inc    %eax
  100380:	3d 00 01 00 00       	cmp    $0x100,%eax
  100385:	75 da                	jne    100361 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100387:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10038c:	ba 98 6e 10 00       	mov    $0x106e98,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100391:	66 a3 98 6f 10 00    	mov    %ax,0x106f98
  100397:	c1 e8 10             	shr    $0x10,%eax
  10039a:	66 a3 9e 6f 10 00    	mov    %ax,0x106f9e
  1003a0:	b8 30 00 00 00       	mov    $0x30,%eax
  1003a5:	66 c7 05 9a 6f 10 00 	movw   $0x8,0x106f9a
  1003ac:	08 00 
  1003ae:	c6 05 9c 6f 10 00 00 	movb   $0x0,0x106f9c
  1003b5:	c6 05 9d 6f 10 00 8e 	movb   $0x8e,0x106f9d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003bc:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003c3:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003ca:	66 89 0c c5 98 6e 10 	mov    %cx,0x106e98(,%eax,8)
  1003d1:	00 
  1003d2:	c1 e9 10             	shr    $0x10,%ecx
  1003d5:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003da:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003df:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1003e4:	40                   	inc    %eax
  1003e5:	83 f8 3a             	cmp    $0x3a,%eax
  1003e8:	75 d2                	jne    1003bc <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003ea:	b0 28                	mov    $0x28,%al
  1003ec:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1003f3:	0f 00 d8             	ltr    %ax
  1003f6:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003fd:	5b                   	pop    %ebx
  1003fe:	c3                   	ret    

001003ff <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003ff:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100400:	b0 ff                	mov    $0xff,%al
  100402:	57                   	push   %edi
  100403:	56                   	push   %esi
  100404:	53                   	push   %ebx
  100405:	bb 21 00 00 00       	mov    $0x21,%ebx
  10040a:	89 da                	mov    %ebx,%edx
  10040c:	ee                   	out    %al,(%dx)
  10040d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100412:	89 ca                	mov    %ecx,%edx
  100414:	ee                   	out    %al,(%dx)
  100415:	be 11 00 00 00       	mov    $0x11,%esi
  10041a:	bf 20 00 00 00       	mov    $0x20,%edi
  10041f:	89 f0                	mov    %esi,%eax
  100421:	89 fa                	mov    %edi,%edx
  100423:	ee                   	out    %al,(%dx)
  100424:	b0 20                	mov    $0x20,%al
  100426:	89 da                	mov    %ebx,%edx
  100428:	ee                   	out    %al,(%dx)
  100429:	b0 04                	mov    $0x4,%al
  10042b:	ee                   	out    %al,(%dx)
  10042c:	b0 03                	mov    $0x3,%al
  10042e:	ee                   	out    %al,(%dx)
  10042f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100434:	89 f0                	mov    %esi,%eax
  100436:	89 ea                	mov    %ebp,%edx
  100438:	ee                   	out    %al,(%dx)
  100439:	b0 28                	mov    $0x28,%al
  10043b:	89 ca                	mov    %ecx,%edx
  10043d:	ee                   	out    %al,(%dx)
  10043e:	b0 02                	mov    $0x2,%al
  100440:	ee                   	out    %al,(%dx)
  100441:	b0 01                	mov    $0x1,%al
  100443:	ee                   	out    %al,(%dx)
  100444:	b0 68                	mov    $0x68,%al
  100446:	89 fa                	mov    %edi,%edx
  100448:	ee                   	out    %al,(%dx)
  100449:	be 0a 00 00 00       	mov    $0xa,%esi
  10044e:	89 f0                	mov    %esi,%eax
  100450:	ee                   	out    %al,(%dx)
  100451:	b0 68                	mov    $0x68,%al
  100453:	89 ea                	mov    %ebp,%edx
  100455:	ee                   	out    %al,(%dx)
  100456:	89 f0                	mov    %esi,%eax
  100458:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100459:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10045e:	89 da                	mov    %ebx,%edx
  100460:	19 c0                	sbb    %eax,%eax
  100462:	f7 d0                	not    %eax
  100464:	05 ff 00 00 00       	add    $0xff,%eax
  100469:	ee                   	out    %al,(%dx)
  10046a:	b0 ff                	mov    $0xff,%al
  10046c:	89 ca                	mov    %ecx,%edx
  10046e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10046f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100474:	74 0d                	je     100483 <interrupt_controller_init+0x84>
  100476:	b2 43                	mov    $0x43,%dl
  100478:	b0 34                	mov    $0x34,%al
  10047a:	ee                   	out    %al,(%dx)
  10047b:	b0 a9                	mov    $0xa9,%al
  10047d:	b2 40                	mov    $0x40,%dl
  10047f:	ee                   	out    %al,(%dx)
  100480:	b0 04                	mov    $0x4,%al
  100482:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100483:	5b                   	pop    %ebx
  100484:	5e                   	pop    %esi
  100485:	5f                   	pop    %edi
  100486:	5d                   	pop    %ebp
  100487:	c3                   	ret    

00100488 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100488:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100489:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10048b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10048c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100493:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100496:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10049c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004a2:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004a5:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004aa:	75 ea                	jne    100496 <console_clear+0xe>
  1004ac:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004b1:	b0 0e                	mov    $0xe,%al
  1004b3:	89 f2                	mov    %esi,%edx
  1004b5:	ee                   	out    %al,(%dx)
  1004b6:	31 c9                	xor    %ecx,%ecx
  1004b8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004bd:	88 c8                	mov    %cl,%al
  1004bf:	89 da                	mov    %ebx,%edx
  1004c1:	ee                   	out    %al,(%dx)
  1004c2:	b0 0f                	mov    $0xf,%al
  1004c4:	89 f2                	mov    %esi,%edx
  1004c6:	ee                   	out    %al,(%dx)
  1004c7:	88 c8                	mov    %cl,%al
  1004c9:	89 da                	mov    %ebx,%edx
  1004cb:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004cc:	5b                   	pop    %ebx
  1004cd:	5e                   	pop    %esi
  1004ce:	c3                   	ret    

001004cf <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004cf:	ba 64 00 00 00       	mov    $0x64,%edx
  1004d4:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004d5:	a8 01                	test   $0x1,%al
  1004d7:	74 45                	je     10051e <console_read_digit+0x4f>
  1004d9:	b2 60                	mov    $0x60,%dl
  1004db:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004dc:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004df:	80 fa 08             	cmp    $0x8,%dl
  1004e2:	77 05                	ja     1004e9 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004e4:	0f b6 c0             	movzbl %al,%eax
  1004e7:	48                   	dec    %eax
  1004e8:	c3                   	ret    
	else if (data == 0x0B)
  1004e9:	3c 0b                	cmp    $0xb,%al
  1004eb:	74 35                	je     100522 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004ed:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004f0:	80 fa 02             	cmp    $0x2,%dl
  1004f3:	77 07                	ja     1004fc <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004f5:	0f b6 c0             	movzbl %al,%eax
  1004f8:	83 e8 40             	sub    $0x40,%eax
  1004fb:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004fc:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004ff:	80 fa 02             	cmp    $0x2,%dl
  100502:	77 07                	ja     10050b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100504:	0f b6 c0             	movzbl %al,%eax
  100507:	83 e8 47             	sub    $0x47,%eax
  10050a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10050b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10050e:	80 fa 02             	cmp    $0x2,%dl
  100511:	77 07                	ja     10051a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100513:	0f b6 c0             	movzbl %al,%eax
  100516:	83 e8 4e             	sub    $0x4e,%eax
  100519:	c3                   	ret    
	else if (data == 0x53)
  10051a:	3c 53                	cmp    $0x53,%al
  10051c:	74 04                	je     100522 <console_read_digit+0x53>
  10051e:	83 c8 ff             	or     $0xffffffff,%eax
  100521:	c3                   	ret    
  100522:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100524:	c3                   	ret    

00100525 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100525:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100529:	a3 98 76 10 00       	mov    %eax,0x107698

	asm volatile("movl %0,%%esp\n\t"
  10052e:	83 c0 04             	add    $0x4,%eax
  100531:	89 c4                	mov    %eax,%esp
  100533:	61                   	popa   
  100534:	07                   	pop    %es
  100535:	1f                   	pop    %ds
  100536:	83 c4 08             	add    $0x8,%esp
  100539:	cf                   	iret   
  10053a:	eb fe                	jmp    10053a <run+0x15>

0010053c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10053c:	53                   	push   %ebx
  10053d:	83 ec 0c             	sub    $0xc,%esp
  100540:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100544:	6a 44                	push   $0x44
  100546:	6a 00                	push   $0x0
  100548:	8d 43 04             	lea    0x4(%ebx),%eax
  10054b:	50                   	push   %eax
  10054c:	e8 17 01 00 00       	call   100668 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100551:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100557:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10055d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100563:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100569:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100570:	83 c4 18             	add    $0x18,%esp
  100573:	5b                   	pop    %ebx
  100574:	c3                   	ret    
  100575:	90                   	nop
  100576:	90                   	nop
  100577:	90                   	nop

00100578 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100578:	55                   	push   %ebp
  100579:	57                   	push   %edi
  10057a:	56                   	push   %esi
  10057b:	53                   	push   %ebx
  10057c:	83 ec 1c             	sub    $0x1c,%esp
  10057f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100583:	83 f8 03             	cmp    $0x3,%eax
  100586:	7f 04                	jg     10058c <program_loader+0x14>
  100588:	85 c0                	test   %eax,%eax
  10058a:	79 02                	jns    10058e <program_loader+0x16>
  10058c:	eb fe                	jmp    10058c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10058e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100595:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10059b:	74 02                	je     10059f <program_loader+0x27>
  10059d:	eb fe                	jmp    10059d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10059f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005a2:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005a6:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005a8:	c1 e5 05             	shl    $0x5,%ebp
  1005ab:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005ae:	eb 3f                	jmp    1005ef <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005b0:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005b3:	75 37                	jne    1005ec <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005b5:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005b8:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005bb:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005be:	01 c7                	add    %eax,%edi
	memsz += va;
  1005c0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005c7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005cb:	52                   	push   %edx
  1005cc:	89 fa                	mov    %edi,%edx
  1005ce:	29 c2                	sub    %eax,%edx
  1005d0:	52                   	push   %edx
  1005d1:	8b 53 04             	mov    0x4(%ebx),%edx
  1005d4:	01 f2                	add    %esi,%edx
  1005d6:	52                   	push   %edx
  1005d7:	50                   	push   %eax
  1005d8:	e8 27 00 00 00       	call   100604 <memcpy>
  1005dd:	83 c4 10             	add    $0x10,%esp
  1005e0:	eb 04                	jmp    1005e6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005e2:	c6 07 00             	movb   $0x0,(%edi)
  1005e5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005e6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005ea:	72 f6                	jb     1005e2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005ec:	83 c3 20             	add    $0x20,%ebx
  1005ef:	39 eb                	cmp    %ebp,%ebx
  1005f1:	72 bd                	jb     1005b0 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005f3:	8b 56 18             	mov    0x18(%esi),%edx
  1005f6:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005fa:	89 10                	mov    %edx,(%eax)
}
  1005fc:	83 c4 1c             	add    $0x1c,%esp
  1005ff:	5b                   	pop    %ebx
  100600:	5e                   	pop    %esi
  100601:	5f                   	pop    %edi
  100602:	5d                   	pop    %ebp
  100603:	c3                   	ret    

00100604 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100604:	56                   	push   %esi
  100605:	31 d2                	xor    %edx,%edx
  100607:	53                   	push   %ebx
  100608:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10060c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100610:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100614:	eb 08                	jmp    10061e <memcpy+0x1a>
		*d++ = *s++;
  100616:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100619:	4e                   	dec    %esi
  10061a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10061d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10061e:	85 f6                	test   %esi,%esi
  100620:	75 f4                	jne    100616 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100622:	5b                   	pop    %ebx
  100623:	5e                   	pop    %esi
  100624:	c3                   	ret    

00100625 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100625:	57                   	push   %edi
  100626:	56                   	push   %esi
  100627:	53                   	push   %ebx
  100628:	8b 44 24 10          	mov    0x10(%esp),%eax
  10062c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100630:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100634:	39 c7                	cmp    %eax,%edi
  100636:	73 26                	jae    10065e <memmove+0x39>
  100638:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10063b:	39 c6                	cmp    %eax,%esi
  10063d:	76 1f                	jbe    10065e <memmove+0x39>
		s += n, d += n;
  10063f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100642:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100644:	eb 07                	jmp    10064d <memmove+0x28>
			*--d = *--s;
  100646:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100649:	4a                   	dec    %edx
  10064a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10064d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10064e:	85 d2                	test   %edx,%edx
  100650:	75 f4                	jne    100646 <memmove+0x21>
  100652:	eb 10                	jmp    100664 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100654:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100657:	4a                   	dec    %edx
  100658:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10065b:	41                   	inc    %ecx
  10065c:	eb 02                	jmp    100660 <memmove+0x3b>
  10065e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100660:	85 d2                	test   %edx,%edx
  100662:	75 f0                	jne    100654 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100664:	5b                   	pop    %ebx
  100665:	5e                   	pop    %esi
  100666:	5f                   	pop    %edi
  100667:	c3                   	ret    

00100668 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100668:	53                   	push   %ebx
  100669:	8b 44 24 08          	mov    0x8(%esp),%eax
  10066d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100671:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100675:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100677:	eb 04                	jmp    10067d <memset+0x15>
		*p++ = c;
  100679:	88 1a                	mov    %bl,(%edx)
  10067b:	49                   	dec    %ecx
  10067c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10067d:	85 c9                	test   %ecx,%ecx
  10067f:	75 f8                	jne    100679 <memset+0x11>
		*p++ = c;
	return v;
}
  100681:	5b                   	pop    %ebx
  100682:	c3                   	ret    

00100683 <strlen>:

size_t
strlen(const char *s)
{
  100683:	8b 54 24 04          	mov    0x4(%esp),%edx
  100687:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100689:	eb 01                	jmp    10068c <strlen+0x9>
		++n;
  10068b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10068c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100690:	75 f9                	jne    10068b <strlen+0x8>
		++n;
	return n;
}
  100692:	c3                   	ret    

00100693 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100693:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100697:	31 c0                	xor    %eax,%eax
  100699:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10069d:	eb 01                	jmp    1006a0 <strnlen+0xd>
		++n;
  10069f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006a0:	39 d0                	cmp    %edx,%eax
  1006a2:	74 06                	je     1006aa <strnlen+0x17>
  1006a4:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006a8:	75 f5                	jne    10069f <strnlen+0xc>
		++n;
	return n;
}
  1006aa:	c3                   	ret    

001006ab <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006ab:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006ac:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006b1:	53                   	push   %ebx
  1006b2:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006b4:	76 05                	jbe    1006bb <console_putc+0x10>
  1006b6:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006bb:	80 fa 0a             	cmp    $0xa,%dl
  1006be:	75 2c                	jne    1006ec <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006c0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006c6:	be 50 00 00 00       	mov    $0x50,%esi
  1006cb:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006cd:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006d0:	99                   	cltd   
  1006d1:	f7 fe                	idiv   %esi
  1006d3:	89 de                	mov    %ebx,%esi
  1006d5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006d7:	eb 07                	jmp    1006e0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006d9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006dc:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006dd:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006e0:	83 f8 50             	cmp    $0x50,%eax
  1006e3:	75 f4                	jne    1006d9 <console_putc+0x2e>
  1006e5:	29 d0                	sub    %edx,%eax
  1006e7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006ea:	eb 0b                	jmp    1006f7 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006ec:	0f b6 d2             	movzbl %dl,%edx
  1006ef:	09 ca                	or     %ecx,%edx
  1006f1:	66 89 13             	mov    %dx,(%ebx)
  1006f4:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006f7:	5b                   	pop    %ebx
  1006f8:	5e                   	pop    %esi
  1006f9:	c3                   	ret    

001006fa <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006fa:	56                   	push   %esi
  1006fb:	53                   	push   %ebx
  1006fc:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100700:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100703:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100707:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10070c:	75 04                	jne    100712 <fill_numbuf+0x18>
  10070e:	85 d2                	test   %edx,%edx
  100710:	74 10                	je     100722 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100712:	89 d0                	mov    %edx,%eax
  100714:	31 d2                	xor    %edx,%edx
  100716:	f7 f1                	div    %ecx
  100718:	4b                   	dec    %ebx
  100719:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10071c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10071e:	89 c2                	mov    %eax,%edx
  100720:	eb ec                	jmp    10070e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100722:	89 d8                	mov    %ebx,%eax
  100724:	5b                   	pop    %ebx
  100725:	5e                   	pop    %esi
  100726:	c3                   	ret    

00100727 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100727:	55                   	push   %ebp
  100728:	57                   	push   %edi
  100729:	56                   	push   %esi
  10072a:	53                   	push   %ebx
  10072b:	83 ec 38             	sub    $0x38,%esp
  10072e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100732:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100736:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10073a:	e9 60 03 00 00       	jmp    100a9f <console_vprintf+0x378>
		if (*format != '%') {
  10073f:	80 fa 25             	cmp    $0x25,%dl
  100742:	74 13                	je     100757 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100744:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100748:	0f b6 d2             	movzbl %dl,%edx
  10074b:	89 f0                	mov    %esi,%eax
  10074d:	e8 59 ff ff ff       	call   1006ab <console_putc>
  100752:	e9 45 03 00 00       	jmp    100a9c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100757:	47                   	inc    %edi
  100758:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10075f:	00 
  100760:	eb 12                	jmp    100774 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100762:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100763:	8a 11                	mov    (%ecx),%dl
  100765:	84 d2                	test   %dl,%dl
  100767:	74 1a                	je     100783 <console_vprintf+0x5c>
  100769:	89 e8                	mov    %ebp,%eax
  10076b:	38 c2                	cmp    %al,%dl
  10076d:	75 f3                	jne    100762 <console_vprintf+0x3b>
  10076f:	e9 3f 03 00 00       	jmp    100ab3 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100774:	8a 17                	mov    (%edi),%dl
  100776:	84 d2                	test   %dl,%dl
  100778:	74 0b                	je     100785 <console_vprintf+0x5e>
  10077a:	b9 08 0b 10 00       	mov    $0x100b08,%ecx
  10077f:	89 d5                	mov    %edx,%ebp
  100781:	eb e0                	jmp    100763 <console_vprintf+0x3c>
  100783:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100785:	8d 42 cf             	lea    -0x31(%edx),%eax
  100788:	3c 08                	cmp    $0x8,%al
  10078a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100791:	00 
  100792:	76 13                	jbe    1007a7 <console_vprintf+0x80>
  100794:	eb 1d                	jmp    1007b3 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100796:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10079b:	0f be c0             	movsbl %al,%eax
  10079e:	47                   	inc    %edi
  10079f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007a7:	8a 07                	mov    (%edi),%al
  1007a9:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007ac:	80 fa 09             	cmp    $0x9,%dl
  1007af:	76 e5                	jbe    100796 <console_vprintf+0x6f>
  1007b1:	eb 18                	jmp    1007cb <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007b3:	80 fa 2a             	cmp    $0x2a,%dl
  1007b6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007bd:	ff 
  1007be:	75 0b                	jne    1007cb <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007c0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007c3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007c4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007c7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007cb:	83 cd ff             	or     $0xffffffff,%ebp
  1007ce:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007d1:	75 37                	jne    10080a <console_vprintf+0xe3>
			++format;
  1007d3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007d4:	31 ed                	xor    %ebp,%ebp
  1007d6:	8a 07                	mov    (%edi),%al
  1007d8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007db:	80 fa 09             	cmp    $0x9,%dl
  1007de:	76 0d                	jbe    1007ed <console_vprintf+0xc6>
  1007e0:	eb 17                	jmp    1007f9 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007e2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007e5:	0f be c0             	movsbl %al,%eax
  1007e8:	47                   	inc    %edi
  1007e9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007ed:	8a 07                	mov    (%edi),%al
  1007ef:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007f2:	80 fa 09             	cmp    $0x9,%dl
  1007f5:	76 eb                	jbe    1007e2 <console_vprintf+0xbb>
  1007f7:	eb 11                	jmp    10080a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007f9:	3c 2a                	cmp    $0x2a,%al
  1007fb:	75 0b                	jne    100808 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007fd:	83 c3 04             	add    $0x4,%ebx
				++format;
  100800:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100801:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100804:	85 ed                	test   %ebp,%ebp
  100806:	79 02                	jns    10080a <console_vprintf+0xe3>
  100808:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10080a:	8a 07                	mov    (%edi),%al
  10080c:	3c 64                	cmp    $0x64,%al
  10080e:	74 34                	je     100844 <console_vprintf+0x11d>
  100810:	7f 1d                	jg     10082f <console_vprintf+0x108>
  100812:	3c 58                	cmp    $0x58,%al
  100814:	0f 84 a2 00 00 00    	je     1008bc <console_vprintf+0x195>
  10081a:	3c 63                	cmp    $0x63,%al
  10081c:	0f 84 bf 00 00 00    	je     1008e1 <console_vprintf+0x1ba>
  100822:	3c 43                	cmp    $0x43,%al
  100824:	0f 85 d0 00 00 00    	jne    1008fa <console_vprintf+0x1d3>
  10082a:	e9 a3 00 00 00       	jmp    1008d2 <console_vprintf+0x1ab>
  10082f:	3c 75                	cmp    $0x75,%al
  100831:	74 4d                	je     100880 <console_vprintf+0x159>
  100833:	3c 78                	cmp    $0x78,%al
  100835:	74 5c                	je     100893 <console_vprintf+0x16c>
  100837:	3c 73                	cmp    $0x73,%al
  100839:	0f 85 bb 00 00 00    	jne    1008fa <console_vprintf+0x1d3>
  10083f:	e9 86 00 00 00       	jmp    1008ca <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100844:	83 c3 04             	add    $0x4,%ebx
  100847:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10084a:	89 d1                	mov    %edx,%ecx
  10084c:	c1 f9 1f             	sar    $0x1f,%ecx
  10084f:	89 0c 24             	mov    %ecx,(%esp)
  100852:	31 ca                	xor    %ecx,%edx
  100854:	55                   	push   %ebp
  100855:	29 ca                	sub    %ecx,%edx
  100857:	68 10 0b 10 00       	push   $0x100b10
  10085c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100861:	8d 44 24 40          	lea    0x40(%esp),%eax
  100865:	e8 90 fe ff ff       	call   1006fa <fill_numbuf>
  10086a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10086e:	58                   	pop    %eax
  10086f:	5a                   	pop    %edx
  100870:	ba 01 00 00 00       	mov    $0x1,%edx
  100875:	8b 04 24             	mov    (%esp),%eax
  100878:	83 e0 01             	and    $0x1,%eax
  10087b:	e9 a5 00 00 00       	jmp    100925 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100880:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100883:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100888:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10088b:	55                   	push   %ebp
  10088c:	68 10 0b 10 00       	push   $0x100b10
  100891:	eb 11                	jmp    1008a4 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100893:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100896:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100899:	55                   	push   %ebp
  10089a:	68 24 0b 10 00       	push   $0x100b24
  10089f:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008a4:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008a8:	e8 4d fe ff ff       	call   1006fa <fill_numbuf>
  1008ad:	ba 01 00 00 00       	mov    $0x1,%edx
  1008b2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008b6:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008b8:	59                   	pop    %ecx
  1008b9:	59                   	pop    %ecx
  1008ba:	eb 69                	jmp    100925 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008bc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008bf:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008c2:	55                   	push   %ebp
  1008c3:	68 10 0b 10 00       	push   $0x100b10
  1008c8:	eb d5                	jmp    10089f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008ca:	83 c3 04             	add    $0x4,%ebx
  1008cd:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008d0:	eb 40                	jmp    100912 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008d2:	83 c3 04             	add    $0x4,%ebx
  1008d5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008d8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008dc:	e9 bd 01 00 00       	jmp    100a9e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008e1:	83 c3 04             	add    $0x4,%ebx
  1008e4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008e7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008eb:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008f0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008f4:	88 44 24 24          	mov    %al,0x24(%esp)
  1008f8:	eb 27                	jmp    100921 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008fa:	84 c0                	test   %al,%al
  1008fc:	75 02                	jne    100900 <console_vprintf+0x1d9>
  1008fe:	b0 25                	mov    $0x25,%al
  100900:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100904:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100909:	80 3f 00             	cmpb   $0x0,(%edi)
  10090c:	74 0a                	je     100918 <console_vprintf+0x1f1>
  10090e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100912:	89 44 24 04          	mov    %eax,0x4(%esp)
  100916:	eb 09                	jmp    100921 <console_vprintf+0x1fa>
				format--;
  100918:	8d 54 24 24          	lea    0x24(%esp),%edx
  10091c:	4f                   	dec    %edi
  10091d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100921:	31 d2                	xor    %edx,%edx
  100923:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100925:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100927:	83 fd ff             	cmp    $0xffffffff,%ebp
  10092a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100931:	74 1f                	je     100952 <console_vprintf+0x22b>
  100933:	89 04 24             	mov    %eax,(%esp)
  100936:	eb 01                	jmp    100939 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100938:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100939:	39 e9                	cmp    %ebp,%ecx
  10093b:	74 0a                	je     100947 <console_vprintf+0x220>
  10093d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100941:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100945:	75 f1                	jne    100938 <console_vprintf+0x211>
  100947:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10094a:	89 0c 24             	mov    %ecx,(%esp)
  10094d:	eb 1f                	jmp    10096e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10094f:	42                   	inc    %edx
  100950:	eb 09                	jmp    10095b <console_vprintf+0x234>
  100952:	89 d1                	mov    %edx,%ecx
  100954:	8b 14 24             	mov    (%esp),%edx
  100957:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10095b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10095f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100963:	75 ea                	jne    10094f <console_vprintf+0x228>
  100965:	8b 44 24 08          	mov    0x8(%esp),%eax
  100969:	89 14 24             	mov    %edx,(%esp)
  10096c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10096e:	85 c0                	test   %eax,%eax
  100970:	74 0c                	je     10097e <console_vprintf+0x257>
  100972:	84 d2                	test   %dl,%dl
  100974:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10097b:	00 
  10097c:	75 24                	jne    1009a2 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10097e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100983:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10098a:	00 
  10098b:	75 15                	jne    1009a2 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10098d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100991:	83 e0 08             	and    $0x8,%eax
  100994:	83 f8 01             	cmp    $0x1,%eax
  100997:	19 c9                	sbb    %ecx,%ecx
  100999:	f7 d1                	not    %ecx
  10099b:	83 e1 20             	and    $0x20,%ecx
  10099e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009a2:	3b 2c 24             	cmp    (%esp),%ebp
  1009a5:	7e 0d                	jle    1009b4 <console_vprintf+0x28d>
  1009a7:	84 d2                	test   %dl,%dl
  1009a9:	74 40                	je     1009eb <console_vprintf+0x2c4>
			zeros = precision - len;
  1009ab:	2b 2c 24             	sub    (%esp),%ebp
  1009ae:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009b2:	eb 3f                	jmp    1009f3 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009b4:	84 d2                	test   %dl,%dl
  1009b6:	74 33                	je     1009eb <console_vprintf+0x2c4>
  1009b8:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009bc:	83 e0 06             	and    $0x6,%eax
  1009bf:	83 f8 02             	cmp    $0x2,%eax
  1009c2:	75 27                	jne    1009eb <console_vprintf+0x2c4>
  1009c4:	45                   	inc    %ebp
  1009c5:	75 24                	jne    1009eb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009c7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009c9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009cc:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009d1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009d7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009db:	7d 0e                	jge    1009eb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009dd:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009e1:	29 ca                	sub    %ecx,%edx
  1009e3:	29 c2                	sub    %eax,%edx
  1009e5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009e9:	eb 08                	jmp    1009f3 <console_vprintf+0x2cc>
  1009eb:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009f2:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009f3:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009f7:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009f9:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009fd:	2b 2c 24             	sub    (%esp),%ebp
  100a00:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a05:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a08:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a0b:	29 c5                	sub    %eax,%ebp
  100a0d:	89 f0                	mov    %esi,%eax
  100a0f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a13:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a17:	eb 0f                	jmp    100a28 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a19:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a1d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a22:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a23:	e8 83 fc ff ff       	call   1006ab <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a28:	85 ed                	test   %ebp,%ebp
  100a2a:	7e 07                	jle    100a33 <console_vprintf+0x30c>
  100a2c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a31:	74 e6                	je     100a19 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a33:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a38:	89 c6                	mov    %eax,%esi
  100a3a:	74 23                	je     100a5f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a3c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a41:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a45:	e8 61 fc ff ff       	call   1006ab <console_putc>
  100a4a:	89 c6                	mov    %eax,%esi
  100a4c:	eb 11                	jmp    100a5f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a4e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a52:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a57:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a58:	e8 4e fc ff ff       	call   1006ab <console_putc>
  100a5d:	eb 06                	jmp    100a65 <console_vprintf+0x33e>
  100a5f:	89 f0                	mov    %esi,%eax
  100a61:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a65:	85 f6                	test   %esi,%esi
  100a67:	7f e5                	jg     100a4e <console_vprintf+0x327>
  100a69:	8b 34 24             	mov    (%esp),%esi
  100a6c:	eb 15                	jmp    100a83 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a6e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a72:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a73:	0f b6 11             	movzbl (%ecx),%edx
  100a76:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a7a:	e8 2c fc ff ff       	call   1006ab <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a7f:	ff 44 24 04          	incl   0x4(%esp)
  100a83:	85 f6                	test   %esi,%esi
  100a85:	7f e7                	jg     100a6e <console_vprintf+0x347>
  100a87:	eb 0f                	jmp    100a98 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a89:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a8d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a92:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a93:	e8 13 fc ff ff       	call   1006ab <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a98:	85 ed                	test   %ebp,%ebp
  100a9a:	7f ed                	jg     100a89 <console_vprintf+0x362>
  100a9c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a9e:	47                   	inc    %edi
  100a9f:	8a 17                	mov    (%edi),%dl
  100aa1:	84 d2                	test   %dl,%dl
  100aa3:	0f 85 96 fc ff ff    	jne    10073f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100aa9:	83 c4 38             	add    $0x38,%esp
  100aac:	89 f0                	mov    %esi,%eax
  100aae:	5b                   	pop    %ebx
  100aaf:	5e                   	pop    %esi
  100ab0:	5f                   	pop    %edi
  100ab1:	5d                   	pop    %ebp
  100ab2:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ab3:	81 e9 08 0b 10 00    	sub    $0x100b08,%ecx
  100ab9:	b8 01 00 00 00       	mov    $0x1,%eax
  100abe:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ac0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ac1:	09 44 24 14          	or     %eax,0x14(%esp)
  100ac5:	e9 aa fc ff ff       	jmp    100774 <console_vprintf+0x4d>

00100aca <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100aca:	8d 44 24 10          	lea    0x10(%esp),%eax
  100ace:	50                   	push   %eax
  100acf:	ff 74 24 10          	pushl  0x10(%esp)
  100ad3:	ff 74 24 10          	pushl  0x10(%esp)
  100ad7:	ff 74 24 10          	pushl  0x10(%esp)
  100adb:	e8 47 fc ff ff       	call   100727 <console_vprintf>
  100ae0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100ae3:	c3                   	ret    
