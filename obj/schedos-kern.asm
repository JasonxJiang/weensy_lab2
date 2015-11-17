
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
  100014:	e8 86 01 00 00       	call   10019f <start>
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
  10006d:	e8 bc 00 00 00       	call   10012e <interrupt>

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
  10009c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
	int j = 0;
	if (scheduling_algorithm == 0)
  10009f:	8b 0d 70 76 10 00    	mov    0x107670,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  1000a5:	a1 6c 76 10 00       	mov    0x10766c,%eax
	int j = 0;
	if (scheduling_algorithm == 0)
  1000aa:	85 c9                	test   %ecx,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  1000ac:	8b 10                	mov    (%eax),%edx
	int j = 0;
	if (scheduling_algorithm == 0)
  1000ae:	75 19                	jne    1000c9 <schedule+0x2d>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b0:	b1 05                	mov    $0x5,%cl
  1000b2:	8d 42 01             	lea    0x1(%edx),%eax
  1000b5:	99                   	cltd   
  1000b6:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000b8:	6b c2 50             	imul   $0x50,%edx,%eax
  1000bb:	83 b8 bc 6c 10 00 01 	cmpl   $0x1,0x106cbc(%eax)
  1000c2:	75 ee                	jne    1000b2 <schedule+0x16>
				run(&proc_array[pid]);
  1000c4:	83 ec 0c             	sub    $0xc,%esp
  1000c7:	eb 3a                	jmp    100103 <schedule+0x67>
		}
	else if (scheduling_algorithm == 2)
  1000c9:	83 f9 02             	cmp    $0x2,%ecx
  1000cc:	75 40                	jne    10010e <schedule+0x72>
	{
		for (j = 1; j<NPROCS; j++)
		{
			if (proc_array[j].p_state == P_RUNNABLE)
  1000ce:	83 3d 0c 6d 10 00 01 	cmpl   $0x1,0x106d0c
  1000d5:	b8 01 00 00 00       	mov    $0x1,%eax
  1000da:	74 21                	je     1000fd <schedule+0x61>
  1000dc:	83 3d 5c 6d 10 00 01 	cmpl   $0x1,0x106d5c
  1000e3:	b0 02                	mov    $0x2,%al
  1000e5:	74 16                	je     1000fd <schedule+0x61>
  1000e7:	83 3d ac 6d 10 00 01 	cmpl   $0x1,0x106dac
  1000ee:	b0 03                	mov    $0x3,%al
  1000f0:	74 0b                	je     1000fd <schedule+0x61>
  1000f2:	83 3d fc 6d 10 00 01 	cmpl   $0x1,0x106dfc
  1000f9:	75 13                	jne    10010e <schedule+0x72>
  1000fb:	b0 04                	mov    $0x4,%al
				run(&proc_array[j]);
  1000fd:	6b c0 50             	imul   $0x50,%eax,%eax
  100100:	83 ec 0c             	sub    $0xc,%esp
  100103:	05 74 6c 10 00       	add    $0x106c74,%eax
  100108:	50                   	push   %eax
  100109:	e8 a3 03 00 00       	call   1004b1 <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10010e:	a1 00 80 19 00       	mov    0x198000,%eax
  100113:	51                   	push   %ecx
  100114:	68 70 0a 10 00       	push   $0x100a70
  100119:	68 00 01 00 00       	push   $0x100
  10011e:	50                   	push   %eax
  10011f:	e8 32 09 00 00       	call   100a56 <console_printf>
  100124:	83 c4 10             	add    $0x10,%esp
  100127:	a3 00 80 19 00       	mov    %eax,0x198000
  10012c:	eb fe                	jmp    10012c <schedule+0x90>

0010012e <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10012e:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10012f:	a1 6c 76 10 00       	mov    0x10766c,%eax
  100134:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100139:	56                   	push   %esi
  10013a:	53                   	push   %ebx
  10013b:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10013f:	8d 78 04             	lea    0x4(%eax),%edi
  100142:	89 de                	mov    %ebx,%esi
  100144:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100146:	8b 53 28             	mov    0x28(%ebx),%edx
  100149:	83 fa 31             	cmp    $0x31,%edx
  10014c:	74 1f                	je     10016d <interrupt+0x3f>
  10014e:	77 0c                	ja     10015c <interrupt+0x2e>
  100150:	83 fa 20             	cmp    $0x20,%edx
  100153:	74 43                	je     100198 <interrupt+0x6a>
  100155:	83 fa 30             	cmp    $0x30,%edx
  100158:	74 0e                	je     100168 <interrupt+0x3a>
  10015a:	eb 41                	jmp    10019d <interrupt+0x6f>
  10015c:	83 fa 32             	cmp    $0x32,%edx
  10015f:	74 23                	je     100184 <interrupt+0x56>
  100161:	83 fa 33             	cmp    $0x33,%edx
  100164:	74 29                	je     10018f <interrupt+0x61>
  100166:	eb 35                	jmp    10019d <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100168:	e8 2f ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10016d:	a1 6c 76 10 00       	mov    0x10766c,%eax
		current->p_exit_status = reg->reg_eax;
  100172:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100175:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10017c:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10017f:	e8 18 ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  100184:	83 ec 0c             	sub    $0xc,%esp
  100187:	ff 35 6c 76 10 00    	pushl  0x10766c
  10018d:	eb 04                	jmp    100193 <interrupt+0x65>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  10018f:	83 ec 0c             	sub    $0xc,%esp
  100192:	50                   	push   %eax
  100193:	e8 19 03 00 00       	call   1004b1 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100198:	e8 ff fe ff ff       	call   10009c <schedule>
  10019d:	eb fe                	jmp    10019d <interrupt+0x6f>

0010019f <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10019f:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001a0:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001a5:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001a6:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001a8:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001a9:	bb c4 6c 10 00       	mov    $0x106cc4,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001ae:	e8 dd 00 00 00       	call   100290 <segments_init>
	interrupt_controller_init(0);
  1001b3:	83 ec 0c             	sub    $0xc,%esp
  1001b6:	6a 00                	push   $0x0
  1001b8:	e8 ce 01 00 00       	call   10038b <interrupt_controller_init>
	console_clear();
  1001bd:	e8 52 02 00 00       	call   100414 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001c2:	83 c4 0c             	add    $0xc,%esp
  1001c5:	68 90 01 00 00       	push   $0x190
  1001ca:	6a 00                	push   $0x0
  1001cc:	68 74 6c 10 00       	push   $0x106c74
  1001d1:	e8 1e 04 00 00       	call   1005f4 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001d6:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001d9:	c7 05 74 6c 10 00 00 	movl   $0x0,0x106c74
  1001e0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001e3:	c7 05 bc 6c 10 00 00 	movl   $0x0,0x106cbc
  1001ea:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001ed:	c7 05 c4 6c 10 00 01 	movl   $0x1,0x106cc4
  1001f4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001f7:	c7 05 0c 6d 10 00 00 	movl   $0x0,0x106d0c
  1001fe:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100201:	c7 05 14 6d 10 00 02 	movl   $0x2,0x106d14
  100208:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10020b:	c7 05 5c 6d 10 00 00 	movl   $0x0,0x106d5c
  100212:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100215:	c7 05 64 6d 10 00 03 	movl   $0x3,0x106d64
  10021c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10021f:	c7 05 ac 6d 10 00 00 	movl   $0x0,0x106dac
  100226:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100229:	c7 05 b4 6d 10 00 04 	movl   $0x4,0x106db4
  100230:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100233:	c7 05 fc 6d 10 00 00 	movl   $0x0,0x106dfc
  10023a:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10023d:	83 ec 0c             	sub    $0xc,%esp
  100240:	53                   	push   %ebx
  100241:	e8 82 02 00 00       	call   1004c8 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100246:	58                   	pop    %eax
  100247:	5a                   	pop    %edx
  100248:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10024b:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10024e:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100254:	50                   	push   %eax
  100255:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100256:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100257:	e8 a8 02 00 00       	call   100504 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10025c:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10025f:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100266:	83 c3 50             	add    $0x50,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100269:	83 fe 04             	cmp    $0x4,%esi
  10026c:	75 cf                	jne    10023d <start+0x9e>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  10026e:	83 ec 0c             	sub    $0xc,%esp
  100271:	68 c4 6c 10 00       	push   $0x106cc4
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100276:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10027d:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;
  100280:	c7 05 70 76 10 00 00 	movl   $0x0,0x107670
  100287:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10028a:	e8 22 02 00 00       	call   1004b1 <run>
  10028f:	90                   	nop

00100290 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100290:	b8 04 6e 10 00       	mov    $0x106e04,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100295:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10029a:	89 c2                	mov    %eax,%edx
  10029c:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10029f:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002a0:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002a5:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002a8:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002ae:	c1 e8 18             	shr    $0x18,%eax
  1002b1:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002b7:	ba 6c 6e 10 00       	mov    $0x106e6c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002bc:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c1:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002c3:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002ca:	68 00 
  1002cc:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002d3:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002da:	c7 05 08 6e 10 00 00 	movl   $0x180000,0x106e08
  1002e1:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002e4:	66 c7 05 0c 6e 10 00 	movw   $0x10,0x106e0c
  1002eb:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002ed:	66 89 0c c5 6c 6e 10 	mov    %cx,0x106e6c(,%eax,8)
  1002f4:	00 
  1002f5:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1002fc:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100301:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100306:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10030b:	40                   	inc    %eax
  10030c:	3d 00 01 00 00       	cmp    $0x100,%eax
  100311:	75 da                	jne    1002ed <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100313:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100318:	ba 6c 6e 10 00       	mov    $0x106e6c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10031d:	66 a3 6c 6f 10 00    	mov    %ax,0x106f6c
  100323:	c1 e8 10             	shr    $0x10,%eax
  100326:	66 a3 72 6f 10 00    	mov    %ax,0x106f72
  10032c:	b8 30 00 00 00       	mov    $0x30,%eax
  100331:	66 c7 05 6e 6f 10 00 	movw   $0x8,0x106f6e
  100338:	08 00 
  10033a:	c6 05 70 6f 10 00 00 	movb   $0x0,0x106f70
  100341:	c6 05 71 6f 10 00 8e 	movb   $0x8e,0x106f71

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100348:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10034f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100356:	66 89 0c c5 6c 6e 10 	mov    %cx,0x106e6c(,%eax,8)
  10035d:	00 
  10035e:	c1 e9 10             	shr    $0x10,%ecx
  100361:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100366:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10036b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100370:	40                   	inc    %eax
  100371:	83 f8 3a             	cmp    $0x3a,%eax
  100374:	75 d2                	jne    100348 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100376:	b0 28                	mov    $0x28,%al
  100378:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10037f:	0f 00 d8             	ltr    %ax
  100382:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100389:	5b                   	pop    %ebx
  10038a:	c3                   	ret    

0010038b <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10038b:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10038c:	b0 ff                	mov    $0xff,%al
  10038e:	57                   	push   %edi
  10038f:	56                   	push   %esi
  100390:	53                   	push   %ebx
  100391:	bb 21 00 00 00       	mov    $0x21,%ebx
  100396:	89 da                	mov    %ebx,%edx
  100398:	ee                   	out    %al,(%dx)
  100399:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10039e:	89 ca                	mov    %ecx,%edx
  1003a0:	ee                   	out    %al,(%dx)
  1003a1:	be 11 00 00 00       	mov    $0x11,%esi
  1003a6:	bf 20 00 00 00       	mov    $0x20,%edi
  1003ab:	89 f0                	mov    %esi,%eax
  1003ad:	89 fa                	mov    %edi,%edx
  1003af:	ee                   	out    %al,(%dx)
  1003b0:	b0 20                	mov    $0x20,%al
  1003b2:	89 da                	mov    %ebx,%edx
  1003b4:	ee                   	out    %al,(%dx)
  1003b5:	b0 04                	mov    $0x4,%al
  1003b7:	ee                   	out    %al,(%dx)
  1003b8:	b0 03                	mov    $0x3,%al
  1003ba:	ee                   	out    %al,(%dx)
  1003bb:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003c0:	89 f0                	mov    %esi,%eax
  1003c2:	89 ea                	mov    %ebp,%edx
  1003c4:	ee                   	out    %al,(%dx)
  1003c5:	b0 28                	mov    $0x28,%al
  1003c7:	89 ca                	mov    %ecx,%edx
  1003c9:	ee                   	out    %al,(%dx)
  1003ca:	b0 02                	mov    $0x2,%al
  1003cc:	ee                   	out    %al,(%dx)
  1003cd:	b0 01                	mov    $0x1,%al
  1003cf:	ee                   	out    %al,(%dx)
  1003d0:	b0 68                	mov    $0x68,%al
  1003d2:	89 fa                	mov    %edi,%edx
  1003d4:	ee                   	out    %al,(%dx)
  1003d5:	be 0a 00 00 00       	mov    $0xa,%esi
  1003da:	89 f0                	mov    %esi,%eax
  1003dc:	ee                   	out    %al,(%dx)
  1003dd:	b0 68                	mov    $0x68,%al
  1003df:	89 ea                	mov    %ebp,%edx
  1003e1:	ee                   	out    %al,(%dx)
  1003e2:	89 f0                	mov    %esi,%eax
  1003e4:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003e5:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003ea:	89 da                	mov    %ebx,%edx
  1003ec:	19 c0                	sbb    %eax,%eax
  1003ee:	f7 d0                	not    %eax
  1003f0:	05 ff 00 00 00       	add    $0xff,%eax
  1003f5:	ee                   	out    %al,(%dx)
  1003f6:	b0 ff                	mov    $0xff,%al
  1003f8:	89 ca                	mov    %ecx,%edx
  1003fa:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1003fb:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100400:	74 0d                	je     10040f <interrupt_controller_init+0x84>
  100402:	b2 43                	mov    $0x43,%dl
  100404:	b0 34                	mov    $0x34,%al
  100406:	ee                   	out    %al,(%dx)
  100407:	b0 9c                	mov    $0x9c,%al
  100409:	b2 40                	mov    $0x40,%dl
  10040b:	ee                   	out    %al,(%dx)
  10040c:	b0 2e                	mov    $0x2e,%al
  10040e:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10040f:	5b                   	pop    %ebx
  100410:	5e                   	pop    %esi
  100411:	5f                   	pop    %edi
  100412:	5d                   	pop    %ebp
  100413:	c3                   	ret    

00100414 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100414:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100415:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100417:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100418:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10041f:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100422:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100428:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10042e:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100431:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100436:	75 ea                	jne    100422 <console_clear+0xe>
  100438:	be d4 03 00 00       	mov    $0x3d4,%esi
  10043d:	b0 0e                	mov    $0xe,%al
  10043f:	89 f2                	mov    %esi,%edx
  100441:	ee                   	out    %al,(%dx)
  100442:	31 c9                	xor    %ecx,%ecx
  100444:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100449:	88 c8                	mov    %cl,%al
  10044b:	89 da                	mov    %ebx,%edx
  10044d:	ee                   	out    %al,(%dx)
  10044e:	b0 0f                	mov    $0xf,%al
  100450:	89 f2                	mov    %esi,%edx
  100452:	ee                   	out    %al,(%dx)
  100453:	88 c8                	mov    %cl,%al
  100455:	89 da                	mov    %ebx,%edx
  100457:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100458:	5b                   	pop    %ebx
  100459:	5e                   	pop    %esi
  10045a:	c3                   	ret    

0010045b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10045b:	ba 64 00 00 00       	mov    $0x64,%edx
  100460:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100461:	a8 01                	test   $0x1,%al
  100463:	74 45                	je     1004aa <console_read_digit+0x4f>
  100465:	b2 60                	mov    $0x60,%dl
  100467:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100468:	8d 50 fe             	lea    -0x2(%eax),%edx
  10046b:	80 fa 08             	cmp    $0x8,%dl
  10046e:	77 05                	ja     100475 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100470:	0f b6 c0             	movzbl %al,%eax
  100473:	48                   	dec    %eax
  100474:	c3                   	ret    
	else if (data == 0x0B)
  100475:	3c 0b                	cmp    $0xb,%al
  100477:	74 35                	je     1004ae <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100479:	8d 50 b9             	lea    -0x47(%eax),%edx
  10047c:	80 fa 02             	cmp    $0x2,%dl
  10047f:	77 07                	ja     100488 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100481:	0f b6 c0             	movzbl %al,%eax
  100484:	83 e8 40             	sub    $0x40,%eax
  100487:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100488:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10048b:	80 fa 02             	cmp    $0x2,%dl
  10048e:	77 07                	ja     100497 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100490:	0f b6 c0             	movzbl %al,%eax
  100493:	83 e8 47             	sub    $0x47,%eax
  100496:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100497:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10049a:	80 fa 02             	cmp    $0x2,%dl
  10049d:	77 07                	ja     1004a6 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10049f:	0f b6 c0             	movzbl %al,%eax
  1004a2:	83 e8 4e             	sub    $0x4e,%eax
  1004a5:	c3                   	ret    
	else if (data == 0x53)
  1004a6:	3c 53                	cmp    $0x53,%al
  1004a8:	74 04                	je     1004ae <console_read_digit+0x53>
  1004aa:	83 c8 ff             	or     $0xffffffff,%eax
  1004ad:	c3                   	ret    
  1004ae:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004b0:	c3                   	ret    

001004b1 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004b1:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004b5:	a3 6c 76 10 00       	mov    %eax,0x10766c

	asm volatile("movl %0,%%esp\n\t"
  1004ba:	83 c0 04             	add    $0x4,%eax
  1004bd:	89 c4                	mov    %eax,%esp
  1004bf:	61                   	popa   
  1004c0:	07                   	pop    %es
  1004c1:	1f                   	pop    %ds
  1004c2:	83 c4 08             	add    $0x8,%esp
  1004c5:	cf                   	iret   
  1004c6:	eb fe                	jmp    1004c6 <run+0x15>

001004c8 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004c8:	53                   	push   %ebx
  1004c9:	83 ec 0c             	sub    $0xc,%esp
  1004cc:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004d0:	6a 44                	push   $0x44
  1004d2:	6a 00                	push   $0x0
  1004d4:	8d 43 04             	lea    0x4(%ebx),%eax
  1004d7:	50                   	push   %eax
  1004d8:	e8 17 01 00 00       	call   1005f4 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004dd:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004e3:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004e9:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004ef:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1004f5:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1004fc:	83 c4 18             	add    $0x18,%esp
  1004ff:	5b                   	pop    %ebx
  100500:	c3                   	ret    
  100501:	90                   	nop
  100502:	90                   	nop
  100503:	90                   	nop

00100504 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100504:	55                   	push   %ebp
  100505:	57                   	push   %edi
  100506:	56                   	push   %esi
  100507:	53                   	push   %ebx
  100508:	83 ec 1c             	sub    $0x1c,%esp
  10050b:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10050f:	83 f8 03             	cmp    $0x3,%eax
  100512:	7f 04                	jg     100518 <program_loader+0x14>
  100514:	85 c0                	test   %eax,%eax
  100516:	79 02                	jns    10051a <program_loader+0x16>
  100518:	eb fe                	jmp    100518 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10051a:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100521:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100527:	74 02                	je     10052b <program_loader+0x27>
  100529:	eb fe                	jmp    100529 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10052b:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10052e:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100532:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100534:	c1 e5 05             	shl    $0x5,%ebp
  100537:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10053a:	eb 3f                	jmp    10057b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  10053c:	83 3b 01             	cmpl   $0x1,(%ebx)
  10053f:	75 37                	jne    100578 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100541:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100544:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100547:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10054a:	01 c7                	add    %eax,%edi
	memsz += va;
  10054c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10054e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100553:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100557:	52                   	push   %edx
  100558:	89 fa                	mov    %edi,%edx
  10055a:	29 c2                	sub    %eax,%edx
  10055c:	52                   	push   %edx
  10055d:	8b 53 04             	mov    0x4(%ebx),%edx
  100560:	01 f2                	add    %esi,%edx
  100562:	52                   	push   %edx
  100563:	50                   	push   %eax
  100564:	e8 27 00 00 00       	call   100590 <memcpy>
  100569:	83 c4 10             	add    $0x10,%esp
  10056c:	eb 04                	jmp    100572 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10056e:	c6 07 00             	movb   $0x0,(%edi)
  100571:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100572:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100576:	72 f6                	jb     10056e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100578:	83 c3 20             	add    $0x20,%ebx
  10057b:	39 eb                	cmp    %ebp,%ebx
  10057d:	72 bd                	jb     10053c <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10057f:	8b 56 18             	mov    0x18(%esi),%edx
  100582:	8b 44 24 34          	mov    0x34(%esp),%eax
  100586:	89 10                	mov    %edx,(%eax)
}
  100588:	83 c4 1c             	add    $0x1c,%esp
  10058b:	5b                   	pop    %ebx
  10058c:	5e                   	pop    %esi
  10058d:	5f                   	pop    %edi
  10058e:	5d                   	pop    %ebp
  10058f:	c3                   	ret    

00100590 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100590:	56                   	push   %esi
  100591:	31 d2                	xor    %edx,%edx
  100593:	53                   	push   %ebx
  100594:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100598:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10059c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005a0:	eb 08                	jmp    1005aa <memcpy+0x1a>
		*d++ = *s++;
  1005a2:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005a5:	4e                   	dec    %esi
  1005a6:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005a9:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005aa:	85 f6                	test   %esi,%esi
  1005ac:	75 f4                	jne    1005a2 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005ae:	5b                   	pop    %ebx
  1005af:	5e                   	pop    %esi
  1005b0:	c3                   	ret    

001005b1 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005b1:	57                   	push   %edi
  1005b2:	56                   	push   %esi
  1005b3:	53                   	push   %ebx
  1005b4:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005b8:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005bc:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005c0:	39 c7                	cmp    %eax,%edi
  1005c2:	73 26                	jae    1005ea <memmove+0x39>
  1005c4:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005c7:	39 c6                	cmp    %eax,%esi
  1005c9:	76 1f                	jbe    1005ea <memmove+0x39>
		s += n, d += n;
  1005cb:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005ce:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005d0:	eb 07                	jmp    1005d9 <memmove+0x28>
			*--d = *--s;
  1005d2:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005d5:	4a                   	dec    %edx
  1005d6:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005d9:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005da:	85 d2                	test   %edx,%edx
  1005dc:	75 f4                	jne    1005d2 <memmove+0x21>
  1005de:	eb 10                	jmp    1005f0 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005e0:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005e3:	4a                   	dec    %edx
  1005e4:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005e7:	41                   	inc    %ecx
  1005e8:	eb 02                	jmp    1005ec <memmove+0x3b>
  1005ea:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005ec:	85 d2                	test   %edx,%edx
  1005ee:	75 f0                	jne    1005e0 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005f0:	5b                   	pop    %ebx
  1005f1:	5e                   	pop    %esi
  1005f2:	5f                   	pop    %edi
  1005f3:	c3                   	ret    

001005f4 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005f4:	53                   	push   %ebx
  1005f5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005f9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005fd:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100601:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100603:	eb 04                	jmp    100609 <memset+0x15>
		*p++ = c;
  100605:	88 1a                	mov    %bl,(%edx)
  100607:	49                   	dec    %ecx
  100608:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100609:	85 c9                	test   %ecx,%ecx
  10060b:	75 f8                	jne    100605 <memset+0x11>
		*p++ = c;
	return v;
}
  10060d:	5b                   	pop    %ebx
  10060e:	c3                   	ret    

0010060f <strlen>:

size_t
strlen(const char *s)
{
  10060f:	8b 54 24 04          	mov    0x4(%esp),%edx
  100613:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100615:	eb 01                	jmp    100618 <strlen+0x9>
		++n;
  100617:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100618:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  10061c:	75 f9                	jne    100617 <strlen+0x8>
		++n;
	return n;
}
  10061e:	c3                   	ret    

0010061f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10061f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100623:	31 c0                	xor    %eax,%eax
  100625:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100629:	eb 01                	jmp    10062c <strnlen+0xd>
		++n;
  10062b:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10062c:	39 d0                	cmp    %edx,%eax
  10062e:	74 06                	je     100636 <strnlen+0x17>
  100630:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100634:	75 f5                	jne    10062b <strnlen+0xc>
		++n;
	return n;
}
  100636:	c3                   	ret    

00100637 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100637:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100638:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10063d:	53                   	push   %ebx
  10063e:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100640:	76 05                	jbe    100647 <console_putc+0x10>
  100642:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100647:	80 fa 0a             	cmp    $0xa,%dl
  10064a:	75 2c                	jne    100678 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10064c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100652:	be 50 00 00 00       	mov    $0x50,%esi
  100657:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100659:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10065c:	99                   	cltd   
  10065d:	f7 fe                	idiv   %esi
  10065f:	89 de                	mov    %ebx,%esi
  100661:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100663:	eb 07                	jmp    10066c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100665:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100668:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100669:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10066c:	83 f8 50             	cmp    $0x50,%eax
  10066f:	75 f4                	jne    100665 <console_putc+0x2e>
  100671:	29 d0                	sub    %edx,%eax
  100673:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100676:	eb 0b                	jmp    100683 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100678:	0f b6 d2             	movzbl %dl,%edx
  10067b:	09 ca                	or     %ecx,%edx
  10067d:	66 89 13             	mov    %dx,(%ebx)
  100680:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100683:	5b                   	pop    %ebx
  100684:	5e                   	pop    %esi
  100685:	c3                   	ret    

00100686 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100686:	56                   	push   %esi
  100687:	53                   	push   %ebx
  100688:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  10068c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10068f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100693:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100698:	75 04                	jne    10069e <fill_numbuf+0x18>
  10069a:	85 d2                	test   %edx,%edx
  10069c:	74 10                	je     1006ae <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10069e:	89 d0                	mov    %edx,%eax
  1006a0:	31 d2                	xor    %edx,%edx
  1006a2:	f7 f1                	div    %ecx
  1006a4:	4b                   	dec    %ebx
  1006a5:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006a8:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006aa:	89 c2                	mov    %eax,%edx
  1006ac:	eb ec                	jmp    10069a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006ae:	89 d8                	mov    %ebx,%eax
  1006b0:	5b                   	pop    %ebx
  1006b1:	5e                   	pop    %esi
  1006b2:	c3                   	ret    

001006b3 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006b3:	55                   	push   %ebp
  1006b4:	57                   	push   %edi
  1006b5:	56                   	push   %esi
  1006b6:	53                   	push   %ebx
  1006b7:	83 ec 38             	sub    $0x38,%esp
  1006ba:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006be:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006c2:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006c6:	e9 60 03 00 00       	jmp    100a2b <console_vprintf+0x378>
		if (*format != '%') {
  1006cb:	80 fa 25             	cmp    $0x25,%dl
  1006ce:	74 13                	je     1006e3 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006d0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006d4:	0f b6 d2             	movzbl %dl,%edx
  1006d7:	89 f0                	mov    %esi,%eax
  1006d9:	e8 59 ff ff ff       	call   100637 <console_putc>
  1006de:	e9 45 03 00 00       	jmp    100a28 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006e3:	47                   	inc    %edi
  1006e4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006eb:	00 
  1006ec:	eb 12                	jmp    100700 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006ee:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006ef:	8a 11                	mov    (%ecx),%dl
  1006f1:	84 d2                	test   %dl,%dl
  1006f3:	74 1a                	je     10070f <console_vprintf+0x5c>
  1006f5:	89 e8                	mov    %ebp,%eax
  1006f7:	38 c2                	cmp    %al,%dl
  1006f9:	75 f3                	jne    1006ee <console_vprintf+0x3b>
  1006fb:	e9 3f 03 00 00       	jmp    100a3f <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100700:	8a 17                	mov    (%edi),%dl
  100702:	84 d2                	test   %dl,%dl
  100704:	74 0b                	je     100711 <console_vprintf+0x5e>
  100706:	b9 94 0a 10 00       	mov    $0x100a94,%ecx
  10070b:	89 d5                	mov    %edx,%ebp
  10070d:	eb e0                	jmp    1006ef <console_vprintf+0x3c>
  10070f:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100711:	8d 42 cf             	lea    -0x31(%edx),%eax
  100714:	3c 08                	cmp    $0x8,%al
  100716:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10071d:	00 
  10071e:	76 13                	jbe    100733 <console_vprintf+0x80>
  100720:	eb 1d                	jmp    10073f <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100722:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100727:	0f be c0             	movsbl %al,%eax
  10072a:	47                   	inc    %edi
  10072b:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10072f:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100733:	8a 07                	mov    (%edi),%al
  100735:	8d 50 d0             	lea    -0x30(%eax),%edx
  100738:	80 fa 09             	cmp    $0x9,%dl
  10073b:	76 e5                	jbe    100722 <console_vprintf+0x6f>
  10073d:	eb 18                	jmp    100757 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10073f:	80 fa 2a             	cmp    $0x2a,%dl
  100742:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100749:	ff 
  10074a:	75 0b                	jne    100757 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10074c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10074f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100750:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100753:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100757:	83 cd ff             	or     $0xffffffff,%ebp
  10075a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10075d:	75 37                	jne    100796 <console_vprintf+0xe3>
			++format;
  10075f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100760:	31 ed                	xor    %ebp,%ebp
  100762:	8a 07                	mov    (%edi),%al
  100764:	8d 50 d0             	lea    -0x30(%eax),%edx
  100767:	80 fa 09             	cmp    $0x9,%dl
  10076a:	76 0d                	jbe    100779 <console_vprintf+0xc6>
  10076c:	eb 17                	jmp    100785 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10076e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100771:	0f be c0             	movsbl %al,%eax
  100774:	47                   	inc    %edi
  100775:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100779:	8a 07                	mov    (%edi),%al
  10077b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10077e:	80 fa 09             	cmp    $0x9,%dl
  100781:	76 eb                	jbe    10076e <console_vprintf+0xbb>
  100783:	eb 11                	jmp    100796 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100785:	3c 2a                	cmp    $0x2a,%al
  100787:	75 0b                	jne    100794 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100789:	83 c3 04             	add    $0x4,%ebx
				++format;
  10078c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  10078d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100790:	85 ed                	test   %ebp,%ebp
  100792:	79 02                	jns    100796 <console_vprintf+0xe3>
  100794:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100796:	8a 07                	mov    (%edi),%al
  100798:	3c 64                	cmp    $0x64,%al
  10079a:	74 34                	je     1007d0 <console_vprintf+0x11d>
  10079c:	7f 1d                	jg     1007bb <console_vprintf+0x108>
  10079e:	3c 58                	cmp    $0x58,%al
  1007a0:	0f 84 a2 00 00 00    	je     100848 <console_vprintf+0x195>
  1007a6:	3c 63                	cmp    $0x63,%al
  1007a8:	0f 84 bf 00 00 00    	je     10086d <console_vprintf+0x1ba>
  1007ae:	3c 43                	cmp    $0x43,%al
  1007b0:	0f 85 d0 00 00 00    	jne    100886 <console_vprintf+0x1d3>
  1007b6:	e9 a3 00 00 00       	jmp    10085e <console_vprintf+0x1ab>
  1007bb:	3c 75                	cmp    $0x75,%al
  1007bd:	74 4d                	je     10080c <console_vprintf+0x159>
  1007bf:	3c 78                	cmp    $0x78,%al
  1007c1:	74 5c                	je     10081f <console_vprintf+0x16c>
  1007c3:	3c 73                	cmp    $0x73,%al
  1007c5:	0f 85 bb 00 00 00    	jne    100886 <console_vprintf+0x1d3>
  1007cb:	e9 86 00 00 00       	jmp    100856 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007d0:	83 c3 04             	add    $0x4,%ebx
  1007d3:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007d6:	89 d1                	mov    %edx,%ecx
  1007d8:	c1 f9 1f             	sar    $0x1f,%ecx
  1007db:	89 0c 24             	mov    %ecx,(%esp)
  1007de:	31 ca                	xor    %ecx,%edx
  1007e0:	55                   	push   %ebp
  1007e1:	29 ca                	sub    %ecx,%edx
  1007e3:	68 9c 0a 10 00       	push   $0x100a9c
  1007e8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007ed:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007f1:	e8 90 fe ff ff       	call   100686 <fill_numbuf>
  1007f6:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007fa:	58                   	pop    %eax
  1007fb:	5a                   	pop    %edx
  1007fc:	ba 01 00 00 00       	mov    $0x1,%edx
  100801:	8b 04 24             	mov    (%esp),%eax
  100804:	83 e0 01             	and    $0x1,%eax
  100807:	e9 a5 00 00 00       	jmp    1008b1 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  10080c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10080f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100814:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100817:	55                   	push   %ebp
  100818:	68 9c 0a 10 00       	push   $0x100a9c
  10081d:	eb 11                	jmp    100830 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10081f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100822:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100825:	55                   	push   %ebp
  100826:	68 b0 0a 10 00       	push   $0x100ab0
  10082b:	b9 10 00 00 00       	mov    $0x10,%ecx
  100830:	8d 44 24 40          	lea    0x40(%esp),%eax
  100834:	e8 4d fe ff ff       	call   100686 <fill_numbuf>
  100839:	ba 01 00 00 00       	mov    $0x1,%edx
  10083e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100842:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100844:	59                   	pop    %ecx
  100845:	59                   	pop    %ecx
  100846:	eb 69                	jmp    1008b1 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100848:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10084b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10084e:	55                   	push   %ebp
  10084f:	68 9c 0a 10 00       	push   $0x100a9c
  100854:	eb d5                	jmp    10082b <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100856:	83 c3 04             	add    $0x4,%ebx
  100859:	8b 43 fc             	mov    -0x4(%ebx),%eax
  10085c:	eb 40                	jmp    10089e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10085e:	83 c3 04             	add    $0x4,%ebx
  100861:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100864:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100868:	e9 bd 01 00 00       	jmp    100a2a <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10086d:	83 c3 04             	add    $0x4,%ebx
  100870:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100873:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100877:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  10087c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100880:	88 44 24 24          	mov    %al,0x24(%esp)
  100884:	eb 27                	jmp    1008ad <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100886:	84 c0                	test   %al,%al
  100888:	75 02                	jne    10088c <console_vprintf+0x1d9>
  10088a:	b0 25                	mov    $0x25,%al
  10088c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100890:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100895:	80 3f 00             	cmpb   $0x0,(%edi)
  100898:	74 0a                	je     1008a4 <console_vprintf+0x1f1>
  10089a:	8d 44 24 24          	lea    0x24(%esp),%eax
  10089e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008a2:	eb 09                	jmp    1008ad <console_vprintf+0x1fa>
				format--;
  1008a4:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008a8:	4f                   	dec    %edi
  1008a9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008ad:	31 d2                	xor    %edx,%edx
  1008af:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008b1:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008b3:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008bd:	74 1f                	je     1008de <console_vprintf+0x22b>
  1008bf:	89 04 24             	mov    %eax,(%esp)
  1008c2:	eb 01                	jmp    1008c5 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008c4:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008c5:	39 e9                	cmp    %ebp,%ecx
  1008c7:	74 0a                	je     1008d3 <console_vprintf+0x220>
  1008c9:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008cd:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008d1:	75 f1                	jne    1008c4 <console_vprintf+0x211>
  1008d3:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008d6:	89 0c 24             	mov    %ecx,(%esp)
  1008d9:	eb 1f                	jmp    1008fa <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008db:	42                   	inc    %edx
  1008dc:	eb 09                	jmp    1008e7 <console_vprintf+0x234>
  1008de:	89 d1                	mov    %edx,%ecx
  1008e0:	8b 14 24             	mov    (%esp),%edx
  1008e3:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008e7:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008eb:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008ef:	75 ea                	jne    1008db <console_vprintf+0x228>
  1008f1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008f5:	89 14 24             	mov    %edx,(%esp)
  1008f8:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008fa:	85 c0                	test   %eax,%eax
  1008fc:	74 0c                	je     10090a <console_vprintf+0x257>
  1008fe:	84 d2                	test   %dl,%dl
  100900:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100907:	00 
  100908:	75 24                	jne    10092e <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10090a:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  10090f:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100916:	00 
  100917:	75 15                	jne    10092e <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100919:	8b 44 24 14          	mov    0x14(%esp),%eax
  10091d:	83 e0 08             	and    $0x8,%eax
  100920:	83 f8 01             	cmp    $0x1,%eax
  100923:	19 c9                	sbb    %ecx,%ecx
  100925:	f7 d1                	not    %ecx
  100927:	83 e1 20             	and    $0x20,%ecx
  10092a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10092e:	3b 2c 24             	cmp    (%esp),%ebp
  100931:	7e 0d                	jle    100940 <console_vprintf+0x28d>
  100933:	84 d2                	test   %dl,%dl
  100935:	74 40                	je     100977 <console_vprintf+0x2c4>
			zeros = precision - len;
  100937:	2b 2c 24             	sub    (%esp),%ebp
  10093a:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10093e:	eb 3f                	jmp    10097f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100940:	84 d2                	test   %dl,%dl
  100942:	74 33                	je     100977 <console_vprintf+0x2c4>
  100944:	8b 44 24 14          	mov    0x14(%esp),%eax
  100948:	83 e0 06             	and    $0x6,%eax
  10094b:	83 f8 02             	cmp    $0x2,%eax
  10094e:	75 27                	jne    100977 <console_vprintf+0x2c4>
  100950:	45                   	inc    %ebp
  100951:	75 24                	jne    100977 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100953:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100955:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100958:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10095d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100960:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100963:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100967:	7d 0e                	jge    100977 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100969:	8b 54 24 0c          	mov    0xc(%esp),%edx
  10096d:	29 ca                	sub    %ecx,%edx
  10096f:	29 c2                	sub    %eax,%edx
  100971:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100975:	eb 08                	jmp    10097f <console_vprintf+0x2cc>
  100977:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  10097e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10097f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100983:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100985:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100989:	2b 2c 24             	sub    (%esp),%ebp
  10098c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100991:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100994:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100997:	29 c5                	sub    %eax,%ebp
  100999:	89 f0                	mov    %esi,%eax
  10099b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10099f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009a3:	eb 0f                	jmp    1009b4 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009a5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009a9:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009ae:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009af:	e8 83 fc ff ff       	call   100637 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b4:	85 ed                	test   %ebp,%ebp
  1009b6:	7e 07                	jle    1009bf <console_vprintf+0x30c>
  1009b8:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009bd:	74 e6                	je     1009a5 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009bf:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009c4:	89 c6                	mov    %eax,%esi
  1009c6:	74 23                	je     1009eb <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009c8:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009cd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009d1:	e8 61 fc ff ff       	call   100637 <console_putc>
  1009d6:	89 c6                	mov    %eax,%esi
  1009d8:	eb 11                	jmp    1009eb <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009da:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009de:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009e3:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009e4:	e8 4e fc ff ff       	call   100637 <console_putc>
  1009e9:	eb 06                	jmp    1009f1 <console_vprintf+0x33e>
  1009eb:	89 f0                	mov    %esi,%eax
  1009ed:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009f1:	85 f6                	test   %esi,%esi
  1009f3:	7f e5                	jg     1009da <console_vprintf+0x327>
  1009f5:	8b 34 24             	mov    (%esp),%esi
  1009f8:	eb 15                	jmp    100a0f <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009fa:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009fe:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009ff:	0f b6 11             	movzbl (%ecx),%edx
  100a02:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a06:	e8 2c fc ff ff       	call   100637 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a0b:	ff 44 24 04          	incl   0x4(%esp)
  100a0f:	85 f6                	test   %esi,%esi
  100a11:	7f e7                	jg     1009fa <console_vprintf+0x347>
  100a13:	eb 0f                	jmp    100a24 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a15:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a19:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a1e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a1f:	e8 13 fc ff ff       	call   100637 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a24:	85 ed                	test   %ebp,%ebp
  100a26:	7f ed                	jg     100a15 <console_vprintf+0x362>
  100a28:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a2a:	47                   	inc    %edi
  100a2b:	8a 17                	mov    (%edi),%dl
  100a2d:	84 d2                	test   %dl,%dl
  100a2f:	0f 85 96 fc ff ff    	jne    1006cb <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a35:	83 c4 38             	add    $0x38,%esp
  100a38:	89 f0                	mov    %esi,%eax
  100a3a:	5b                   	pop    %ebx
  100a3b:	5e                   	pop    %esi
  100a3c:	5f                   	pop    %edi
  100a3d:	5d                   	pop    %ebp
  100a3e:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a3f:	81 e9 94 0a 10 00    	sub    $0x100a94,%ecx
  100a45:	b8 01 00 00 00       	mov    $0x1,%eax
  100a4a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a4c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a4d:	09 44 24 14          	or     %eax,0x14(%esp)
  100a51:	e9 aa fc ff ff       	jmp    100700 <console_vprintf+0x4d>

00100a56 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a56:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a5a:	50                   	push   %eax
  100a5b:	ff 74 24 10          	pushl  0x10(%esp)
  100a5f:	ff 74 24 10          	pushl  0x10(%esp)
  100a63:	ff 74 24 10          	pushl  0x10(%esp)
  100a67:	e8 47 fc ff ff       	call   1006b3 <console_vprintf>
  100a6c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a6f:	c3                   	ret    
