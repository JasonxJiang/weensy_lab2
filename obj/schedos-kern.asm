
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
  100014:	e8 91 01 00 00       	call   1001aa <start>
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
  10006d:	e8 b4 00 00 00       	call   100126 <interrupt>

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
  10009f:	a1 74 76 10 00       	mov    0x107674,%eax
  1000a4:	8b 10                	mov    (%eax),%edx
	int j = 0;
	if (scheduling_algorithm == 0)
  1000a6:	a1 78 76 10 00       	mov    0x107678,%eax
  1000ab:	85 c0                	test   %eax,%eax
  1000ad:	75 1c                	jne    1000cb <schedule+0x2f>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000af:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b4:	8d 42 01             	lea    0x1(%edx),%eax
  1000b7:	99                   	cltd   
  1000b8:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ba:	6b c2 50             	imul   $0x50,%edx,%eax
  1000bd:	83 b8 c4 6c 10 00 01 	cmpl   $0x1,0x106cc4(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
				run(&proc_array[pid]);//run(&proc_array[pid]);
  1000c6:	83 ec 0c             	sub    $0xc,%esp
  1000c9:	eb 1e                	jmp    1000e9 <schedule+0x4d>
		}
	else if (scheduling_algorithm == 2)
  1000cb:	83 f8 02             	cmp    $0x2,%eax
  1000ce:	75 35                	jne    100105 <schedule+0x69>
  1000d0:	b0 01                	mov    $0x1,%al
  1000d2:	ba 01 00 00 00       	mov    $0x1,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE)
  1000d7:	6b ca 50             	imul   $0x50,%edx,%ecx
  1000da:	83 b9 c4 6c 10 00 01 	cmpl   $0x1,0x106cc4(%ecx)
  1000e1:	75 11                	jne    1000f4 <schedule+0x58>
					run(&proc_array[j]);
  1000e3:	6b c0 50             	imul   $0x50,%eax,%eax
  1000e6:	83 ec 0c             	sub    $0xc,%esp
  1000e9:	05 7c 6c 10 00       	add    $0x106c7c,%eax
  1000ee:	50                   	push   %eax
  1000ef:	e8 c9 03 00 00       	call   1004bd <run>
		}
	else if (scheduling_algorithm == 2)
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  1000f4:	8d 42 01             	lea    0x1(%edx),%eax
  1000f7:	83 f8 04             	cmp    $0x4,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);//run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 2)
  1000fa:	89 c2                	mov    %eax,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  1000fc:	7e d9                	jle    1000d7 <schedule+0x3b>
  1000fe:	b8 01 00 00 00       	mov    $0x1,%eax
  100103:	eb cd                	jmp    1000d2 <schedule+0x36>
			}
		}

	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100105:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10010b:	50                   	push   %eax
  10010c:	68 7c 0a 10 00       	push   $0x100a7c
  100111:	68 00 01 00 00       	push   $0x100
  100116:	52                   	push   %edx
  100117:	e8 46 09 00 00       	call   100a62 <console_printf>
  10011c:	83 c4 10             	add    $0x10,%esp
  10011f:	a3 00 80 19 00       	mov    %eax,0x198000
  100124:	eb fe                	jmp    100124 <schedule+0x88>

00100126 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100126:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100127:	a1 74 76 10 00       	mov    0x107674,%eax
  10012c:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100131:	56                   	push   %esi
  100132:	53                   	push   %ebx
  100133:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100137:	8d 78 04             	lea    0x4(%eax),%edi
  10013a:	89 de                	mov    %ebx,%esi
  10013c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10013e:	8b 53 28             	mov    0x28(%ebx),%edx
  100141:	83 fa 31             	cmp    $0x31,%edx
  100144:	74 1f                	je     100165 <interrupt+0x3f>
  100146:	77 0c                	ja     100154 <interrupt+0x2e>
  100148:	83 fa 20             	cmp    $0x20,%edx
  10014b:	74 56                	je     1001a3 <interrupt+0x7d>
  10014d:	83 fa 30             	cmp    $0x30,%edx
  100150:	74 0e                	je     100160 <interrupt+0x3a>
  100152:	eb 54                	jmp    1001a8 <interrupt+0x82>
  100154:	83 fa 32             	cmp    $0x32,%edx
  100157:	74 23                	je     10017c <interrupt+0x56>
  100159:	83 fa 33             	cmp    $0x33,%edx
  10015c:	74 3c                	je     10019a <interrupt+0x74>
  10015e:	eb 48                	jmp    1001a8 <interrupt+0x82>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100160:	e8 37 ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100165:	a1 74 76 10 00       	mov    0x107674,%eax
		current->p_exit_status = reg->reg_eax;
  10016a:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10016d:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100174:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100177:	e8 20 ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  10017c:	a1 00 80 19 00       	mov    0x198000,%eax
		run(current);
  100181:	83 ec 0c             	sub    $0xc,%esp

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  100184:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100187:	66 89 10             	mov    %dx,(%eax)
  10018a:	83 c0 02             	add    $0x2,%eax
  10018d:	a3 00 80 19 00       	mov    %eax,0x198000
		run(current);
  100192:	ff 35 74 76 10 00    	pushl  0x107674
  100198:	eb 04                	jmp    10019e <interrupt+0x78>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  10019a:	83 ec 0c             	sub    $0xc,%esp
  10019d:	50                   	push   %eax
  10019e:	e8 1a 03 00 00       	call   1004bd <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001a3:	e8 f4 fe ff ff       	call   10009c <schedule>
  1001a8:	eb fe                	jmp    1001a8 <interrupt+0x82>

001001aa <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001aa:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001ab:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001b0:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001b1:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001b3:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001b4:	bb cc 6c 10 00       	mov    $0x106ccc,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001b9:	e8 de 00 00 00       	call   10029c <segments_init>
	interrupt_controller_init(1);
  1001be:	83 ec 0c             	sub    $0xc,%esp
  1001c1:	6a 01                	push   $0x1
  1001c3:	e8 cf 01 00 00       	call   100397 <interrupt_controller_init>
	console_clear();
  1001c8:	e8 53 02 00 00       	call   100420 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001cd:	83 c4 0c             	add    $0xc,%esp
  1001d0:	68 90 01 00 00       	push   $0x190
  1001d5:	6a 00                	push   $0x0
  1001d7:	68 7c 6c 10 00       	push   $0x106c7c
  1001dc:	e8 1f 04 00 00       	call   100600 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001e1:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001e4:	c7 05 7c 6c 10 00 00 	movl   $0x0,0x106c7c
  1001eb:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001ee:	c7 05 c4 6c 10 00 00 	movl   $0x0,0x106cc4
  1001f5:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001f8:	c7 05 cc 6c 10 00 01 	movl   $0x1,0x106ccc
  1001ff:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100202:	c7 05 14 6d 10 00 00 	movl   $0x0,0x106d14
  100209:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10020c:	c7 05 1c 6d 10 00 02 	movl   $0x2,0x106d1c
  100213:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100216:	c7 05 64 6d 10 00 00 	movl   $0x0,0x106d64
  10021d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100220:	c7 05 6c 6d 10 00 03 	movl   $0x3,0x106d6c
  100227:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10022a:	c7 05 b4 6d 10 00 00 	movl   $0x0,0x106db4
  100231:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100234:	c7 05 bc 6d 10 00 04 	movl   $0x4,0x106dbc
  10023b:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10023e:	c7 05 04 6e 10 00 00 	movl   $0x0,0x106e04
  100245:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100248:	83 ec 0c             	sub    $0xc,%esp
  10024b:	53                   	push   %ebx
  10024c:	e8 83 02 00 00       	call   1004d4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100251:	58                   	pop    %eax
  100252:	5a                   	pop    %edx
  100253:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100256:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100259:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10025f:	50                   	push   %eax
  100260:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100261:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100262:	e8 a9 02 00 00       	call   100510 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100267:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10026a:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100271:	83 c3 50             	add    $0x50,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100274:	83 fe 04             	cmp    $0x4,%esi
  100277:	75 cf                	jne    100248 <start+0x9e>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  100279:	83 ec 0c             	sub    $0xc,%esp
  10027c:	68 cc 6c 10 00       	push   $0x106ccc
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100281:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100288:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;
  10028b:	c7 05 78 76 10 00 00 	movl   $0x0,0x107678
  100292:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100295:	e8 23 02 00 00       	call   1004bd <run>
  10029a:	90                   	nop
  10029b:	90                   	nop

0010029c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10029c:	b8 0c 6e 10 00       	mov    $0x106e0c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002a1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002a6:	89 c2                	mov    %eax,%edx
  1002a8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002ab:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002ac:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002b1:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b4:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002ba:	c1 e8 18             	shr    $0x18,%eax
  1002bd:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c3:	ba 74 6e 10 00       	mov    $0x106e74,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002c8:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002cd:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002cf:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002d6:	68 00 
  1002d8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002df:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002e6:	c7 05 10 6e 10 00 00 	movl   $0x180000,0x106e10
  1002ed:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002f0:	66 c7 05 14 6e 10 00 	movw   $0x10,0x106e14
  1002f7:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f9:	66 89 0c c5 74 6e 10 	mov    %cx,0x106e74(,%eax,8)
  100300:	00 
  100301:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100308:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10030d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100312:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100317:	40                   	inc    %eax
  100318:	3d 00 01 00 00       	cmp    $0x100,%eax
  10031d:	75 da                	jne    1002f9 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10031f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100324:	ba 74 6e 10 00       	mov    $0x106e74,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100329:	66 a3 74 6f 10 00    	mov    %ax,0x106f74
  10032f:	c1 e8 10             	shr    $0x10,%eax
  100332:	66 a3 7a 6f 10 00    	mov    %ax,0x106f7a
  100338:	b8 30 00 00 00       	mov    $0x30,%eax
  10033d:	66 c7 05 76 6f 10 00 	movw   $0x8,0x106f76
  100344:	08 00 
  100346:	c6 05 78 6f 10 00 00 	movb   $0x0,0x106f78
  10034d:	c6 05 79 6f 10 00 8e 	movb   $0x8e,0x106f79

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100354:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10035b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100362:	66 89 0c c5 74 6e 10 	mov    %cx,0x106e74(,%eax,8)
  100369:	00 
  10036a:	c1 e9 10             	shr    $0x10,%ecx
  10036d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100372:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100377:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10037c:	40                   	inc    %eax
  10037d:	83 f8 3a             	cmp    $0x3a,%eax
  100380:	75 d2                	jne    100354 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100382:	b0 28                	mov    $0x28,%al
  100384:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10038b:	0f 00 d8             	ltr    %ax
  10038e:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100395:	5b                   	pop    %ebx
  100396:	c3                   	ret    

00100397 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100397:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100398:	b0 ff                	mov    $0xff,%al
  10039a:	57                   	push   %edi
  10039b:	56                   	push   %esi
  10039c:	53                   	push   %ebx
  10039d:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003a2:	89 da                	mov    %ebx,%edx
  1003a4:	ee                   	out    %al,(%dx)
  1003a5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003aa:	89 ca                	mov    %ecx,%edx
  1003ac:	ee                   	out    %al,(%dx)
  1003ad:	be 11 00 00 00       	mov    $0x11,%esi
  1003b2:	bf 20 00 00 00       	mov    $0x20,%edi
  1003b7:	89 f0                	mov    %esi,%eax
  1003b9:	89 fa                	mov    %edi,%edx
  1003bb:	ee                   	out    %al,(%dx)
  1003bc:	b0 20                	mov    $0x20,%al
  1003be:	89 da                	mov    %ebx,%edx
  1003c0:	ee                   	out    %al,(%dx)
  1003c1:	b0 04                	mov    $0x4,%al
  1003c3:	ee                   	out    %al,(%dx)
  1003c4:	b0 03                	mov    $0x3,%al
  1003c6:	ee                   	out    %al,(%dx)
  1003c7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003cc:	89 f0                	mov    %esi,%eax
  1003ce:	89 ea                	mov    %ebp,%edx
  1003d0:	ee                   	out    %al,(%dx)
  1003d1:	b0 28                	mov    $0x28,%al
  1003d3:	89 ca                	mov    %ecx,%edx
  1003d5:	ee                   	out    %al,(%dx)
  1003d6:	b0 02                	mov    $0x2,%al
  1003d8:	ee                   	out    %al,(%dx)
  1003d9:	b0 01                	mov    $0x1,%al
  1003db:	ee                   	out    %al,(%dx)
  1003dc:	b0 68                	mov    $0x68,%al
  1003de:	89 fa                	mov    %edi,%edx
  1003e0:	ee                   	out    %al,(%dx)
  1003e1:	be 0a 00 00 00       	mov    $0xa,%esi
  1003e6:	89 f0                	mov    %esi,%eax
  1003e8:	ee                   	out    %al,(%dx)
  1003e9:	b0 68                	mov    $0x68,%al
  1003eb:	89 ea                	mov    %ebp,%edx
  1003ed:	ee                   	out    %al,(%dx)
  1003ee:	89 f0                	mov    %esi,%eax
  1003f0:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003f1:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003f6:	89 da                	mov    %ebx,%edx
  1003f8:	19 c0                	sbb    %eax,%eax
  1003fa:	f7 d0                	not    %eax
  1003fc:	05 ff 00 00 00       	add    $0xff,%eax
  100401:	ee                   	out    %al,(%dx)
  100402:	b0 ff                	mov    $0xff,%al
  100404:	89 ca                	mov    %ecx,%edx
  100406:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100407:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10040c:	74 0d                	je     10041b <interrupt_controller_init+0x84>
  10040e:	b2 43                	mov    $0x43,%dl
  100410:	b0 34                	mov    $0x34,%al
  100412:	ee                   	out    %al,(%dx)
  100413:	b0 a9                	mov    $0xa9,%al
  100415:	b2 40                	mov    $0x40,%dl
  100417:	ee                   	out    %al,(%dx)
  100418:	b0 04                	mov    $0x4,%al
  10041a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10041b:	5b                   	pop    %ebx
  10041c:	5e                   	pop    %esi
  10041d:	5f                   	pop    %edi
  10041e:	5d                   	pop    %ebp
  10041f:	c3                   	ret    

00100420 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100420:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100421:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100423:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100424:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10042b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10042e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100434:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10043a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10043d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100442:	75 ea                	jne    10042e <console_clear+0xe>
  100444:	be d4 03 00 00       	mov    $0x3d4,%esi
  100449:	b0 0e                	mov    $0xe,%al
  10044b:	89 f2                	mov    %esi,%edx
  10044d:	ee                   	out    %al,(%dx)
  10044e:	31 c9                	xor    %ecx,%ecx
  100450:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100455:	88 c8                	mov    %cl,%al
  100457:	89 da                	mov    %ebx,%edx
  100459:	ee                   	out    %al,(%dx)
  10045a:	b0 0f                	mov    $0xf,%al
  10045c:	89 f2                	mov    %esi,%edx
  10045e:	ee                   	out    %al,(%dx)
  10045f:	88 c8                	mov    %cl,%al
  100461:	89 da                	mov    %ebx,%edx
  100463:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100464:	5b                   	pop    %ebx
  100465:	5e                   	pop    %esi
  100466:	c3                   	ret    

00100467 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100467:	ba 64 00 00 00       	mov    $0x64,%edx
  10046c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10046d:	a8 01                	test   $0x1,%al
  10046f:	74 45                	je     1004b6 <console_read_digit+0x4f>
  100471:	b2 60                	mov    $0x60,%dl
  100473:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100474:	8d 50 fe             	lea    -0x2(%eax),%edx
  100477:	80 fa 08             	cmp    $0x8,%dl
  10047a:	77 05                	ja     100481 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10047c:	0f b6 c0             	movzbl %al,%eax
  10047f:	48                   	dec    %eax
  100480:	c3                   	ret    
	else if (data == 0x0B)
  100481:	3c 0b                	cmp    $0xb,%al
  100483:	74 35                	je     1004ba <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100485:	8d 50 b9             	lea    -0x47(%eax),%edx
  100488:	80 fa 02             	cmp    $0x2,%dl
  10048b:	77 07                	ja     100494 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10048d:	0f b6 c0             	movzbl %al,%eax
  100490:	83 e8 40             	sub    $0x40,%eax
  100493:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100494:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100497:	80 fa 02             	cmp    $0x2,%dl
  10049a:	77 07                	ja     1004a3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10049c:	0f b6 c0             	movzbl %al,%eax
  10049f:	83 e8 47             	sub    $0x47,%eax
  1004a2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004a3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004a6:	80 fa 02             	cmp    $0x2,%dl
  1004a9:	77 07                	ja     1004b2 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004ab:	0f b6 c0             	movzbl %al,%eax
  1004ae:	83 e8 4e             	sub    $0x4e,%eax
  1004b1:	c3                   	ret    
	else if (data == 0x53)
  1004b2:	3c 53                	cmp    $0x53,%al
  1004b4:	74 04                	je     1004ba <console_read_digit+0x53>
  1004b6:	83 c8 ff             	or     $0xffffffff,%eax
  1004b9:	c3                   	ret    
  1004ba:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004bc:	c3                   	ret    

001004bd <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004bd:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004c1:	a3 74 76 10 00       	mov    %eax,0x107674

	asm volatile("movl %0,%%esp\n\t"
  1004c6:	83 c0 04             	add    $0x4,%eax
  1004c9:	89 c4                	mov    %eax,%esp
  1004cb:	61                   	popa   
  1004cc:	07                   	pop    %es
  1004cd:	1f                   	pop    %ds
  1004ce:	83 c4 08             	add    $0x8,%esp
  1004d1:	cf                   	iret   
  1004d2:	eb fe                	jmp    1004d2 <run+0x15>

001004d4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004d4:	53                   	push   %ebx
  1004d5:	83 ec 0c             	sub    $0xc,%esp
  1004d8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004dc:	6a 44                	push   $0x44
  1004de:	6a 00                	push   $0x0
  1004e0:	8d 43 04             	lea    0x4(%ebx),%eax
  1004e3:	50                   	push   %eax
  1004e4:	e8 17 01 00 00       	call   100600 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004e9:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004ef:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004f5:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004fb:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100501:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100508:	83 c4 18             	add    $0x18,%esp
  10050b:	5b                   	pop    %ebx
  10050c:	c3                   	ret    
  10050d:	90                   	nop
  10050e:	90                   	nop
  10050f:	90                   	nop

00100510 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100510:	55                   	push   %ebp
  100511:	57                   	push   %edi
  100512:	56                   	push   %esi
  100513:	53                   	push   %ebx
  100514:	83 ec 1c             	sub    $0x1c,%esp
  100517:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10051b:	83 f8 03             	cmp    $0x3,%eax
  10051e:	7f 04                	jg     100524 <program_loader+0x14>
  100520:	85 c0                	test   %eax,%eax
  100522:	79 02                	jns    100526 <program_loader+0x16>
  100524:	eb fe                	jmp    100524 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100526:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10052d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100533:	74 02                	je     100537 <program_loader+0x27>
  100535:	eb fe                	jmp    100535 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100537:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10053a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10053e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100540:	c1 e5 05             	shl    $0x5,%ebp
  100543:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100546:	eb 3f                	jmp    100587 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100548:	83 3b 01             	cmpl   $0x1,(%ebx)
  10054b:	75 37                	jne    100584 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10054d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100550:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100553:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100556:	01 c7                	add    %eax,%edi
	memsz += va;
  100558:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10055a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10055f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100563:	52                   	push   %edx
  100564:	89 fa                	mov    %edi,%edx
  100566:	29 c2                	sub    %eax,%edx
  100568:	52                   	push   %edx
  100569:	8b 53 04             	mov    0x4(%ebx),%edx
  10056c:	01 f2                	add    %esi,%edx
  10056e:	52                   	push   %edx
  10056f:	50                   	push   %eax
  100570:	e8 27 00 00 00       	call   10059c <memcpy>
  100575:	83 c4 10             	add    $0x10,%esp
  100578:	eb 04                	jmp    10057e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10057a:	c6 07 00             	movb   $0x0,(%edi)
  10057d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10057e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100582:	72 f6                	jb     10057a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100584:	83 c3 20             	add    $0x20,%ebx
  100587:	39 eb                	cmp    %ebp,%ebx
  100589:	72 bd                	jb     100548 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10058b:	8b 56 18             	mov    0x18(%esi),%edx
  10058e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100592:	89 10                	mov    %edx,(%eax)
}
  100594:	83 c4 1c             	add    $0x1c,%esp
  100597:	5b                   	pop    %ebx
  100598:	5e                   	pop    %esi
  100599:	5f                   	pop    %edi
  10059a:	5d                   	pop    %ebp
  10059b:	c3                   	ret    

0010059c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10059c:	56                   	push   %esi
  10059d:	31 d2                	xor    %edx,%edx
  10059f:	53                   	push   %ebx
  1005a0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005a4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005a8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005ac:	eb 08                	jmp    1005b6 <memcpy+0x1a>
		*d++ = *s++;
  1005ae:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005b1:	4e                   	dec    %esi
  1005b2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005b5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005b6:	85 f6                	test   %esi,%esi
  1005b8:	75 f4                	jne    1005ae <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005ba:	5b                   	pop    %ebx
  1005bb:	5e                   	pop    %esi
  1005bc:	c3                   	ret    

001005bd <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005bd:	57                   	push   %edi
  1005be:	56                   	push   %esi
  1005bf:	53                   	push   %ebx
  1005c0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005c4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005c8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005cc:	39 c7                	cmp    %eax,%edi
  1005ce:	73 26                	jae    1005f6 <memmove+0x39>
  1005d0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005d3:	39 c6                	cmp    %eax,%esi
  1005d5:	76 1f                	jbe    1005f6 <memmove+0x39>
		s += n, d += n;
  1005d7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005da:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005dc:	eb 07                	jmp    1005e5 <memmove+0x28>
			*--d = *--s;
  1005de:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005e1:	4a                   	dec    %edx
  1005e2:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005e5:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005e6:	85 d2                	test   %edx,%edx
  1005e8:	75 f4                	jne    1005de <memmove+0x21>
  1005ea:	eb 10                	jmp    1005fc <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005ec:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005ef:	4a                   	dec    %edx
  1005f0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005f3:	41                   	inc    %ecx
  1005f4:	eb 02                	jmp    1005f8 <memmove+0x3b>
  1005f6:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005f8:	85 d2                	test   %edx,%edx
  1005fa:	75 f0                	jne    1005ec <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005fc:	5b                   	pop    %ebx
  1005fd:	5e                   	pop    %esi
  1005fe:	5f                   	pop    %edi
  1005ff:	c3                   	ret    

00100600 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100600:	53                   	push   %ebx
  100601:	8b 44 24 08          	mov    0x8(%esp),%eax
  100605:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100609:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10060d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10060f:	eb 04                	jmp    100615 <memset+0x15>
		*p++ = c;
  100611:	88 1a                	mov    %bl,(%edx)
  100613:	49                   	dec    %ecx
  100614:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100615:	85 c9                	test   %ecx,%ecx
  100617:	75 f8                	jne    100611 <memset+0x11>
		*p++ = c;
	return v;
}
  100619:	5b                   	pop    %ebx
  10061a:	c3                   	ret    

0010061b <strlen>:

size_t
strlen(const char *s)
{
  10061b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10061f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100621:	eb 01                	jmp    100624 <strlen+0x9>
		++n;
  100623:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100624:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100628:	75 f9                	jne    100623 <strlen+0x8>
		++n;
	return n;
}
  10062a:	c3                   	ret    

0010062b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10062b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10062f:	31 c0                	xor    %eax,%eax
  100631:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100635:	eb 01                	jmp    100638 <strnlen+0xd>
		++n;
  100637:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100638:	39 d0                	cmp    %edx,%eax
  10063a:	74 06                	je     100642 <strnlen+0x17>
  10063c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100640:	75 f5                	jne    100637 <strnlen+0xc>
		++n;
	return n;
}
  100642:	c3                   	ret    

00100643 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100643:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100644:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100649:	53                   	push   %ebx
  10064a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10064c:	76 05                	jbe    100653 <console_putc+0x10>
  10064e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100653:	80 fa 0a             	cmp    $0xa,%dl
  100656:	75 2c                	jne    100684 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100658:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10065e:	be 50 00 00 00       	mov    $0x50,%esi
  100663:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100665:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100668:	99                   	cltd   
  100669:	f7 fe                	idiv   %esi
  10066b:	89 de                	mov    %ebx,%esi
  10066d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10066f:	eb 07                	jmp    100678 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100671:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100674:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100675:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100678:	83 f8 50             	cmp    $0x50,%eax
  10067b:	75 f4                	jne    100671 <console_putc+0x2e>
  10067d:	29 d0                	sub    %edx,%eax
  10067f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100682:	eb 0b                	jmp    10068f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100684:	0f b6 d2             	movzbl %dl,%edx
  100687:	09 ca                	or     %ecx,%edx
  100689:	66 89 13             	mov    %dx,(%ebx)
  10068c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10068f:	5b                   	pop    %ebx
  100690:	5e                   	pop    %esi
  100691:	c3                   	ret    

00100692 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100692:	56                   	push   %esi
  100693:	53                   	push   %ebx
  100694:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100698:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10069b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10069f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006a4:	75 04                	jne    1006aa <fill_numbuf+0x18>
  1006a6:	85 d2                	test   %edx,%edx
  1006a8:	74 10                	je     1006ba <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006aa:	89 d0                	mov    %edx,%eax
  1006ac:	31 d2                	xor    %edx,%edx
  1006ae:	f7 f1                	div    %ecx
  1006b0:	4b                   	dec    %ebx
  1006b1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006b4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006b6:	89 c2                	mov    %eax,%edx
  1006b8:	eb ec                	jmp    1006a6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006ba:	89 d8                	mov    %ebx,%eax
  1006bc:	5b                   	pop    %ebx
  1006bd:	5e                   	pop    %esi
  1006be:	c3                   	ret    

001006bf <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006bf:	55                   	push   %ebp
  1006c0:	57                   	push   %edi
  1006c1:	56                   	push   %esi
  1006c2:	53                   	push   %ebx
  1006c3:	83 ec 38             	sub    $0x38,%esp
  1006c6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006ca:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006ce:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006d2:	e9 60 03 00 00       	jmp    100a37 <console_vprintf+0x378>
		if (*format != '%') {
  1006d7:	80 fa 25             	cmp    $0x25,%dl
  1006da:	74 13                	je     1006ef <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006dc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006e0:	0f b6 d2             	movzbl %dl,%edx
  1006e3:	89 f0                	mov    %esi,%eax
  1006e5:	e8 59 ff ff ff       	call   100643 <console_putc>
  1006ea:	e9 45 03 00 00       	jmp    100a34 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006ef:	47                   	inc    %edi
  1006f0:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006f7:	00 
  1006f8:	eb 12                	jmp    10070c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006fa:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006fb:	8a 11                	mov    (%ecx),%dl
  1006fd:	84 d2                	test   %dl,%dl
  1006ff:	74 1a                	je     10071b <console_vprintf+0x5c>
  100701:	89 e8                	mov    %ebp,%eax
  100703:	38 c2                	cmp    %al,%dl
  100705:	75 f3                	jne    1006fa <console_vprintf+0x3b>
  100707:	e9 3f 03 00 00       	jmp    100a4b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10070c:	8a 17                	mov    (%edi),%dl
  10070e:	84 d2                	test   %dl,%dl
  100710:	74 0b                	je     10071d <console_vprintf+0x5e>
  100712:	b9 a0 0a 10 00       	mov    $0x100aa0,%ecx
  100717:	89 d5                	mov    %edx,%ebp
  100719:	eb e0                	jmp    1006fb <console_vprintf+0x3c>
  10071b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10071d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100720:	3c 08                	cmp    $0x8,%al
  100722:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100729:	00 
  10072a:	76 13                	jbe    10073f <console_vprintf+0x80>
  10072c:	eb 1d                	jmp    10074b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10072e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100733:	0f be c0             	movsbl %al,%eax
  100736:	47                   	inc    %edi
  100737:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10073b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10073f:	8a 07                	mov    (%edi),%al
  100741:	8d 50 d0             	lea    -0x30(%eax),%edx
  100744:	80 fa 09             	cmp    $0x9,%dl
  100747:	76 e5                	jbe    10072e <console_vprintf+0x6f>
  100749:	eb 18                	jmp    100763 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10074b:	80 fa 2a             	cmp    $0x2a,%dl
  10074e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100755:	ff 
  100756:	75 0b                	jne    100763 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100758:	83 c3 04             	add    $0x4,%ebx
			++format;
  10075b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10075c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10075f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100763:	83 cd ff             	or     $0xffffffff,%ebp
  100766:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100769:	75 37                	jne    1007a2 <console_vprintf+0xe3>
			++format;
  10076b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10076c:	31 ed                	xor    %ebp,%ebp
  10076e:	8a 07                	mov    (%edi),%al
  100770:	8d 50 d0             	lea    -0x30(%eax),%edx
  100773:	80 fa 09             	cmp    $0x9,%dl
  100776:	76 0d                	jbe    100785 <console_vprintf+0xc6>
  100778:	eb 17                	jmp    100791 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10077a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10077d:	0f be c0             	movsbl %al,%eax
  100780:	47                   	inc    %edi
  100781:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100785:	8a 07                	mov    (%edi),%al
  100787:	8d 50 d0             	lea    -0x30(%eax),%edx
  10078a:	80 fa 09             	cmp    $0x9,%dl
  10078d:	76 eb                	jbe    10077a <console_vprintf+0xbb>
  10078f:	eb 11                	jmp    1007a2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100791:	3c 2a                	cmp    $0x2a,%al
  100793:	75 0b                	jne    1007a0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100795:	83 c3 04             	add    $0x4,%ebx
				++format;
  100798:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100799:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10079c:	85 ed                	test   %ebp,%ebp
  10079e:	79 02                	jns    1007a2 <console_vprintf+0xe3>
  1007a0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007a2:	8a 07                	mov    (%edi),%al
  1007a4:	3c 64                	cmp    $0x64,%al
  1007a6:	74 34                	je     1007dc <console_vprintf+0x11d>
  1007a8:	7f 1d                	jg     1007c7 <console_vprintf+0x108>
  1007aa:	3c 58                	cmp    $0x58,%al
  1007ac:	0f 84 a2 00 00 00    	je     100854 <console_vprintf+0x195>
  1007b2:	3c 63                	cmp    $0x63,%al
  1007b4:	0f 84 bf 00 00 00    	je     100879 <console_vprintf+0x1ba>
  1007ba:	3c 43                	cmp    $0x43,%al
  1007bc:	0f 85 d0 00 00 00    	jne    100892 <console_vprintf+0x1d3>
  1007c2:	e9 a3 00 00 00       	jmp    10086a <console_vprintf+0x1ab>
  1007c7:	3c 75                	cmp    $0x75,%al
  1007c9:	74 4d                	je     100818 <console_vprintf+0x159>
  1007cb:	3c 78                	cmp    $0x78,%al
  1007cd:	74 5c                	je     10082b <console_vprintf+0x16c>
  1007cf:	3c 73                	cmp    $0x73,%al
  1007d1:	0f 85 bb 00 00 00    	jne    100892 <console_vprintf+0x1d3>
  1007d7:	e9 86 00 00 00       	jmp    100862 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007dc:	83 c3 04             	add    $0x4,%ebx
  1007df:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007e2:	89 d1                	mov    %edx,%ecx
  1007e4:	c1 f9 1f             	sar    $0x1f,%ecx
  1007e7:	89 0c 24             	mov    %ecx,(%esp)
  1007ea:	31 ca                	xor    %ecx,%edx
  1007ec:	55                   	push   %ebp
  1007ed:	29 ca                	sub    %ecx,%edx
  1007ef:	68 a8 0a 10 00       	push   $0x100aa8
  1007f4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007f9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007fd:	e8 90 fe ff ff       	call   100692 <fill_numbuf>
  100802:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100806:	58                   	pop    %eax
  100807:	5a                   	pop    %edx
  100808:	ba 01 00 00 00       	mov    $0x1,%edx
  10080d:	8b 04 24             	mov    (%esp),%eax
  100810:	83 e0 01             	and    $0x1,%eax
  100813:	e9 a5 00 00 00       	jmp    1008bd <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100818:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10081b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100820:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100823:	55                   	push   %ebp
  100824:	68 a8 0a 10 00       	push   $0x100aa8
  100829:	eb 11                	jmp    10083c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10082b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10082e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100831:	55                   	push   %ebp
  100832:	68 bc 0a 10 00       	push   $0x100abc
  100837:	b9 10 00 00 00       	mov    $0x10,%ecx
  10083c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100840:	e8 4d fe ff ff       	call   100692 <fill_numbuf>
  100845:	ba 01 00 00 00       	mov    $0x1,%edx
  10084a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10084e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100850:	59                   	pop    %ecx
  100851:	59                   	pop    %ecx
  100852:	eb 69                	jmp    1008bd <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100854:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100857:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10085a:	55                   	push   %ebp
  10085b:	68 a8 0a 10 00       	push   $0x100aa8
  100860:	eb d5                	jmp    100837 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100862:	83 c3 04             	add    $0x4,%ebx
  100865:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100868:	eb 40                	jmp    1008aa <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10086a:	83 c3 04             	add    $0x4,%ebx
  10086d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100870:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100874:	e9 bd 01 00 00       	jmp    100a36 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100879:	83 c3 04             	add    $0x4,%ebx
  10087c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10087f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100883:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100888:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10088c:	88 44 24 24          	mov    %al,0x24(%esp)
  100890:	eb 27                	jmp    1008b9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100892:	84 c0                	test   %al,%al
  100894:	75 02                	jne    100898 <console_vprintf+0x1d9>
  100896:	b0 25                	mov    $0x25,%al
  100898:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10089c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008a1:	80 3f 00             	cmpb   $0x0,(%edi)
  1008a4:	74 0a                	je     1008b0 <console_vprintf+0x1f1>
  1008a6:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008aa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ae:	eb 09                	jmp    1008b9 <console_vprintf+0x1fa>
				format--;
  1008b0:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008b4:	4f                   	dec    %edi
  1008b5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008b9:	31 d2                	xor    %edx,%edx
  1008bb:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008bd:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008bf:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008c9:	74 1f                	je     1008ea <console_vprintf+0x22b>
  1008cb:	89 04 24             	mov    %eax,(%esp)
  1008ce:	eb 01                	jmp    1008d1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008d0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008d1:	39 e9                	cmp    %ebp,%ecx
  1008d3:	74 0a                	je     1008df <console_vprintf+0x220>
  1008d5:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008d9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008dd:	75 f1                	jne    1008d0 <console_vprintf+0x211>
  1008df:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008e2:	89 0c 24             	mov    %ecx,(%esp)
  1008e5:	eb 1f                	jmp    100906 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008e7:	42                   	inc    %edx
  1008e8:	eb 09                	jmp    1008f3 <console_vprintf+0x234>
  1008ea:	89 d1                	mov    %edx,%ecx
  1008ec:	8b 14 24             	mov    (%esp),%edx
  1008ef:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008f3:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008f7:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008fb:	75 ea                	jne    1008e7 <console_vprintf+0x228>
  1008fd:	8b 44 24 08          	mov    0x8(%esp),%eax
  100901:	89 14 24             	mov    %edx,(%esp)
  100904:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100906:	85 c0                	test   %eax,%eax
  100908:	74 0c                	je     100916 <console_vprintf+0x257>
  10090a:	84 d2                	test   %dl,%dl
  10090c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100913:	00 
  100914:	75 24                	jne    10093a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100916:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  10091b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100922:	00 
  100923:	75 15                	jne    10093a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100925:	8b 44 24 14          	mov    0x14(%esp),%eax
  100929:	83 e0 08             	and    $0x8,%eax
  10092c:	83 f8 01             	cmp    $0x1,%eax
  10092f:	19 c9                	sbb    %ecx,%ecx
  100931:	f7 d1                	not    %ecx
  100933:	83 e1 20             	and    $0x20,%ecx
  100936:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10093a:	3b 2c 24             	cmp    (%esp),%ebp
  10093d:	7e 0d                	jle    10094c <console_vprintf+0x28d>
  10093f:	84 d2                	test   %dl,%dl
  100941:	74 40                	je     100983 <console_vprintf+0x2c4>
			zeros = precision - len;
  100943:	2b 2c 24             	sub    (%esp),%ebp
  100946:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10094a:	eb 3f                	jmp    10098b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10094c:	84 d2                	test   %dl,%dl
  10094e:	74 33                	je     100983 <console_vprintf+0x2c4>
  100950:	8b 44 24 14          	mov    0x14(%esp),%eax
  100954:	83 e0 06             	and    $0x6,%eax
  100957:	83 f8 02             	cmp    $0x2,%eax
  10095a:	75 27                	jne    100983 <console_vprintf+0x2c4>
  10095c:	45                   	inc    %ebp
  10095d:	75 24                	jne    100983 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10095f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100961:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100964:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100969:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10096c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10096f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100973:	7d 0e                	jge    100983 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100975:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100979:	29 ca                	sub    %ecx,%edx
  10097b:	29 c2                	sub    %eax,%edx
  10097d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100981:	eb 08                	jmp    10098b <console_vprintf+0x2cc>
  100983:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  10098a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10098b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10098f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100991:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100995:	2b 2c 24             	sub    (%esp),%ebp
  100998:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10099d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009a3:	29 c5                	sub    %eax,%ebp
  1009a5:	89 f0                	mov    %esi,%eax
  1009a7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009ab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009af:	eb 0f                	jmp    1009c0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009b1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009b5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009ba:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009bb:	e8 83 fc ff ff       	call   100643 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009c0:	85 ed                	test   %ebp,%ebp
  1009c2:	7e 07                	jle    1009cb <console_vprintf+0x30c>
  1009c4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009c9:	74 e6                	je     1009b1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009cb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009d0:	89 c6                	mov    %eax,%esi
  1009d2:	74 23                	je     1009f7 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009d4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009d9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009dd:	e8 61 fc ff ff       	call   100643 <console_putc>
  1009e2:	89 c6                	mov    %eax,%esi
  1009e4:	eb 11                	jmp    1009f7 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009e6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009ea:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009ef:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009f0:	e8 4e fc ff ff       	call   100643 <console_putc>
  1009f5:	eb 06                	jmp    1009fd <console_vprintf+0x33e>
  1009f7:	89 f0                	mov    %esi,%eax
  1009f9:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009fd:	85 f6                	test   %esi,%esi
  1009ff:	7f e5                	jg     1009e6 <console_vprintf+0x327>
  100a01:	8b 34 24             	mov    (%esp),%esi
  100a04:	eb 15                	jmp    100a1b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a06:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a0a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a0b:	0f b6 11             	movzbl (%ecx),%edx
  100a0e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a12:	e8 2c fc ff ff       	call   100643 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a17:	ff 44 24 04          	incl   0x4(%esp)
  100a1b:	85 f6                	test   %esi,%esi
  100a1d:	7f e7                	jg     100a06 <console_vprintf+0x347>
  100a1f:	eb 0f                	jmp    100a30 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a21:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a25:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a2a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a2b:	e8 13 fc ff ff       	call   100643 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a30:	85 ed                	test   %ebp,%ebp
  100a32:	7f ed                	jg     100a21 <console_vprintf+0x362>
  100a34:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a36:	47                   	inc    %edi
  100a37:	8a 17                	mov    (%edi),%dl
  100a39:	84 d2                	test   %dl,%dl
  100a3b:	0f 85 96 fc ff ff    	jne    1006d7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a41:	83 c4 38             	add    $0x38,%esp
  100a44:	89 f0                	mov    %esi,%eax
  100a46:	5b                   	pop    %ebx
  100a47:	5e                   	pop    %esi
  100a48:	5f                   	pop    %edi
  100a49:	5d                   	pop    %ebp
  100a4a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a4b:	81 e9 a0 0a 10 00    	sub    $0x100aa0,%ecx
  100a51:	b8 01 00 00 00       	mov    $0x1,%eax
  100a56:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a58:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a59:	09 44 24 14          	or     %eax,0x14(%esp)
  100a5d:	e9 aa fc ff ff       	jmp    10070c <console_vprintf+0x4d>

00100a62 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a62:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a66:	50                   	push   %eax
  100a67:	ff 74 24 10          	pushl  0x10(%esp)
  100a6b:	ff 74 24 10          	pushl  0x10(%esp)
  100a6f:	ff 74 24 10          	pushl  0x10(%esp)
  100a73:	e8 47 fc ff ff       	call   1006bf <console_vprintf>
  100a78:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a7b:	c3                   	ret    
