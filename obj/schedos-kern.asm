
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
  100014:	e8 68 02 00 00       	call   100281 <start>
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
  10006d:	e8 8b 01 00 00       	call   1001fd <interrupt>

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
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  10009c:	a1 88 7a 10 00       	mov    0x107a88,%eax
 *
 *****************************************************************************/

void
schedule(void)
{
  1000a1:	57                   	push   %edi
  1000a2:	56                   	push   %esi
  1000a3:	53                   	push   %ebx
	pid_t pid = current->p_pid;
  1000a4:	8b 10                	mov    (%eax),%edx
	int j = 0;
	int lowest_priority = 65535; //INT_MAX of 16 bit ints 
	int largest_share = 0;
	if (scheduling_algorithm == 0)
  1000a6:	a1 8c 7a 10 00       	mov    0x107a8c,%eax
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
  1000ba:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000bd:	83 b8 9c 70 10 00 01 	cmpl   $0x1,0x10709c(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
				run(&proc_array[pid]);//run(&proc_array[pid]);
  1000c6:	83 ec 0c             	sub    $0xc,%esp
  1000c9:	eb 1c                	jmp    1000e7 <schedule+0x4b>
		}
	else if (scheduling_algorithm == 1)
  1000cb:	83 f8 01             	cmp    $0x1,%eax
  1000ce:	75 33                	jne    100103 <schedule+0x67>
  1000d0:	ba 01 00 00 00       	mov    $0x1,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE)
  1000d5:	6b ca 5c             	imul   $0x5c,%edx,%ecx
  1000d8:	83 b9 9c 70 10 00 01 	cmpl   $0x1,0x10709c(%ecx)
  1000df:	75 11                	jne    1000f2 <schedule+0x56>
					run(&proc_array[j]);
  1000e1:	6b c0 5c             	imul   $0x5c,%eax,%eax
  1000e4:	83 ec 0c             	sub    $0xc,%esp
  1000e7:	05 54 70 10 00       	add    $0x107054,%eax
  1000ec:	50                   	push   %eax
  1000ed:	e8 1b 05 00 00       	call   10060d <run>
		}
	else if (scheduling_algorithm == 1)
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  1000f2:	8d 42 01             	lea    0x1(%edx),%eax
  1000f5:	83 f8 04             	cmp    $0x4,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);//run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 1)
  1000f8:	89 c2                	mov    %eax,%edx
	{	
		while (1)
		{
			for (j = 1; j<NPROCS; j++)
  1000fa:	7e d9                	jle    1000d5 <schedule+0x39>
  1000fc:	b8 01 00 00 00       	mov    $0x1,%eax
  100101:	eb cd                	jmp    1000d0 <schedule+0x34>
					run(&proc_array[j]);
			}
		}

	}
	else if (scheduling_algorithm == 2)
  100103:	83 f8 02             	cmp    $0x2,%eax
  100106:	0f 85 86 00 00 00    	jne    100192 <schedule+0xf6>
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority < lowest_priority)
					lowest_priority = proc_array[j].p_priority;
			}

			pid = (pid + 1) % NPROCS;
  10010c:	bb 05 00 00 00       	mov    $0x5,%ebx
	{
		while (1)
		{
			for (j = 1; j < NPROCS; j++)
			{
				if (proc_array[j].p_state == P_RUNNABLE && proc_array[j].p_priority < lowest_priority)
  100111:	83 3d f8 70 10 00 01 	cmpl   $0x1,0x1070f8
  100118:	b9 ff ff 00 00       	mov    $0xffff,%ecx
  10011d:	75 13                	jne    100132 <schedule+0x96>
  10011f:	8b 0d 00 71 10 00    	mov    0x107100,%ecx
  100125:	81 f9 ff ff 00 00    	cmp    $0xffff,%ecx
  10012b:	7e 05                	jle    100132 <schedule+0x96>
  10012d:	b9 ff ff 00 00       	mov    $0xffff,%ecx
  100132:	83 3d 54 71 10 00 01 	cmpl   $0x1,0x107154
  100139:	75 0b                	jne    100146 <schedule+0xaa>
  10013b:	a1 5c 71 10 00       	mov    0x10715c,%eax
  100140:	39 c1                	cmp    %eax,%ecx
  100142:	7e 02                	jle    100146 <schedule+0xaa>
  100144:	89 c1                	mov    %eax,%ecx
  100146:	83 3d b0 71 10 00 01 	cmpl   $0x1,0x1071b0
  10014d:	75 0b                	jne    10015a <schedule+0xbe>
  10014f:	a1 b8 71 10 00       	mov    0x1071b8,%eax
  100154:	39 c1                	cmp    %eax,%ecx
  100156:	7e 02                	jle    10015a <schedule+0xbe>
  100158:	89 c1                	mov    %eax,%ecx
  10015a:	83 3d 0c 72 10 00 01 	cmpl   $0x1,0x10720c
  100161:	75 0b                	jne    10016e <schedule+0xd2>
  100163:	a1 14 72 10 00       	mov    0x107214,%eax
  100168:	39 c1                	cmp    %eax,%ecx
  10016a:	7e 02                	jle    10016e <schedule+0xd2>
  10016c:	89 c1                	mov    %eax,%ecx
					lowest_priority = proc_array[j].p_priority;
			}

			pid = (pid + 1) % NPROCS;
  10016e:	8d 42 01             	lea    0x1(%edx),%eax
  100171:	99                   	cltd   
  100172:	f7 fb                	idiv   %ebx
			if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= lowest_priority)
  100174:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100177:	83 b8 9c 70 10 00 01 	cmpl   $0x1,0x10709c(%eax)
  10017e:	75 91                	jne    100111 <schedule+0x75>
  100180:	05 54 70 10 00       	add    $0x107054,%eax
  100185:	39 48 50             	cmp    %ecx,0x50(%eax)
  100188:	7f 87                	jg     100111 <schedule+0x75>
				run(&proc_array[pid]);
  10018a:	83 ec 0c             	sub    $0xc,%esp
  10018d:	e9 5a ff ff ff       	jmp    1000ec <schedule+0x50>
			lowest_priority = 65535;
			
		}
	}
	else if (scheduling_algorithm == 3)
  100192:	83 f8 03             	cmp    $0x3,%eax
  100195:	75 45                	jne    1001dc <schedule+0x140>
				{
					proc_array[pid].p_times_run++;
					run(&proc_array[pid]);
				}
			}
			pid = (pid + 1)%NPROCS;
  100197:	b9 05 00 00 00       	mov    $0x5,%ecx
	}
	else if (scheduling_algorithm == 3)
	{
		while (1)
		{
			if (proc_array[pid].p_state == P_RUNNABLE)
  10019c:	6b da 5c             	imul   $0x5c,%edx,%ebx
  10019f:	8d 83 5c 70 10 00    	lea    0x10705c(%ebx),%eax
  1001a5:	83 78 40 01          	cmpl   $0x1,0x40(%eax)
  1001a9:	75 29                	jne    1001d4 <schedule+0x138>
			{
				if (proc_array[pid].p_times_run >= proc_array[pid].p_share)
  1001ab:	8b 70 50             	mov    0x50(%eax),%esi
  1001ae:	8d 78 50             	lea    0x50(%eax),%edi
  1001b1:	3b b3 a8 70 10 00    	cmp    0x1070a8(%ebx),%esi
  1001b7:	7c 09                	jl     1001c2 <schedule+0x126>
					proc_array[pid].p_times_run = 0;
  1001b9:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
  1001c0:	eb 12                	jmp    1001d4 <schedule+0x138>
				else
				{
					proc_array[pid].p_times_run++;
  1001c2:	46                   	inc    %esi
					run(&proc_array[pid]);
  1001c3:	83 ec 0c             	sub    $0xc,%esp
  1001c6:	81 c3 54 70 10 00    	add    $0x107054,%ebx
			{
				if (proc_array[pid].p_times_run >= proc_array[pid].p_share)
					proc_array[pid].p_times_run = 0;
				else
				{
					proc_array[pid].p_times_run++;
  1001cc:	89 37                	mov    %esi,(%edi)
					run(&proc_array[pid]);
  1001ce:	53                   	push   %ebx
  1001cf:	e9 19 ff ff ff       	jmp    1000ed <schedule+0x51>
				}
			}
			pid = (pid + 1)%NPROCS;
  1001d4:	8d 42 01             	lea    0x1(%edx),%eax
  1001d7:	99                   	cltd   
  1001d8:	f7 f9                	idiv   %ecx
		}
  1001da:	eb c0                	jmp    10019c <schedule+0x100>
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001dc:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001e2:	50                   	push   %eax
  1001e3:	68 cc 0b 10 00       	push   $0x100bcc
  1001e8:	68 00 01 00 00       	push   $0x100
  1001ed:	52                   	push   %edx
  1001ee:	e8 bf 09 00 00       	call   100bb2 <console_printf>
  1001f3:	83 c4 10             	add    $0x10,%esp
  1001f6:	a3 00 80 19 00       	mov    %eax,0x198000
  1001fb:	eb fe                	jmp    1001fb <schedule+0x15f>

001001fd <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001fd:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001fe:	a1 88 7a 10 00       	mov    0x107a88,%eax
  100203:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100208:	56                   	push   %esi
  100209:	53                   	push   %ebx
  10020a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10020e:	8d 78 04             	lea    0x4(%eax),%edi
  100211:	89 de                	mov    %ebx,%esi
  100213:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100215:	8b 53 28             	mov    0x28(%ebx),%edx
  100218:	83 ea 20             	sub    $0x20,%edx
  10021b:	83 fa 15             	cmp    $0x15,%edx
  10021e:	77 5f                	ja     10027f <interrupt+0x82>
  100220:	ff 24 95 f0 0b 10 00 	jmp    *0x100bf0(,%edx,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100227:	e8 70 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10022c:	a1 88 7a 10 00       	mov    0x107a88,%eax
		current->p_exit_status = reg->reg_eax;
  100231:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100234:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10023b:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10023e:	e8 59 fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  100243:	a1 00 80 19 00       	mov    0x198000,%eax
		run(current);
  100248:	83 ec 0c             	sub    $0xc,%esp

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		*cursorpos++ = reg->reg_eax;
  10024b:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10024e:	66 89 10             	mov    %dx,(%eax)
  100251:	83 c0 02             	add    $0x2,%eax
  100254:	a3 00 80 19 00       	mov    %eax,0x198000
		run(current);
  100259:	ff 35 88 7a 10 00    	pushl  0x107a88
  10025f:	eb 04                	jmp    100265 <interrupt+0x68>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100261:	83 ec 0c             	sub    $0xc,%esp
  100264:	50                   	push   %eax
  100265:	e8 a3 03 00 00       	call   10060d <run>
	
	case INT_PRIORITY_SET:
		current->p_priority = reg->reg_eax;
  10026a:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10026d:	89 50 50             	mov    %edx,0x50(%eax)
  100270:	eb ef                	jmp    100261 <interrupt+0x64>
		run(current);
	
	case INT_PRIORITY_SHARE:
		current->p_share = reg->reg_eax;
  100272:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100275:	89 50 54             	mov    %edx,0x54(%eax)
  100278:	eb e7                	jmp    100261 <interrupt+0x64>
		
	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10027a:	e8 1d fe ff ff       	call   10009c <schedule>
  10027f:	eb fe                	jmp    10027f <interrupt+0x82>

00100281 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100281:	57                   	push   %edi
	proc_array[3].p_share = 2;
	proc_array[4].p_share = 5;
	proc_array[1].p_times_run = 1;//first process run initially in this function
	proc_array[2].p_times_run = 0;
	proc_array[3].p_times_run = 0;
	proc_array[4].p_times_run = 0;
  100282:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100287:	56                   	push   %esi
	proc_array[3].p_share = 2;
	proc_array[4].p_share = 5;
	proc_array[1].p_times_run = 1;//first process run initially in this function
	proc_array[2].p_times_run = 0;
	proc_array[3].p_times_run = 0;
	proc_array[4].p_times_run = 0;
  100288:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10028a:	53                   	push   %ebx
	proc_array[3].p_share = 2;
	proc_array[4].p_share = 5;
	proc_array[1].p_times_run = 1;//first process run initially in this function
	proc_array[2].p_times_run = 0;
	proc_array[3].p_times_run = 0;
	proc_array[4].p_times_run = 0;
  10028b:	bb b0 70 10 00       	mov    $0x1070b0,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100290:	e8 57 01 00 00       	call   1003ec <segments_init>
	interrupt_controller_init(0);
  100295:	83 ec 0c             	sub    $0xc,%esp
  100298:	6a 00                	push   $0x0
  10029a:	e8 48 02 00 00       	call   1004e7 <interrupt_controller_init>
	console_clear();
  10029f:	e8 cc 02 00 00       	call   100570 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002a4:	83 c4 0c             	add    $0xc,%esp
  1002a7:	68 cc 01 00 00       	push   $0x1cc
  1002ac:	6a 00                	push   $0x0
  1002ae:	68 54 70 10 00       	push   $0x107054
  1002b3:	e8 98 04 00 00       	call   100750 <memset>
	proc_array[3].p_share = 2;
	proc_array[4].p_share = 5;
	proc_array[1].p_times_run = 1;//first process run initially in this function
	proc_array[2].p_times_run = 0;
	proc_array[3].p_times_run = 0;
	proc_array[4].p_times_run = 0;
  1002b8:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002bb:	c7 05 54 70 10 00 00 	movl   $0x0,0x107054
  1002c2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c5:	c7 05 9c 70 10 00 00 	movl   $0x0,0x10709c
  1002cc:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002cf:	c7 05 b0 70 10 00 01 	movl   $0x1,0x1070b0
  1002d6:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d9:	c7 05 f8 70 10 00 00 	movl   $0x0,0x1070f8
  1002e0:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002e3:	c7 05 0c 71 10 00 02 	movl   $0x2,0x10710c
  1002ea:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ed:	c7 05 54 71 10 00 00 	movl   $0x0,0x107154
  1002f4:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002f7:	c7 05 68 71 10 00 03 	movl   $0x3,0x107168
  1002fe:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100301:	c7 05 b0 71 10 00 00 	movl   $0x0,0x1071b0
  100308:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10030b:	c7 05 c4 71 10 00 04 	movl   $0x4,0x1071c4
  100312:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100315:	c7 05 0c 72 10 00 00 	movl   $0x0,0x10720c
  10031c:	00 00 00 
		//proc_array[i].p_times_run = 0;
	}
	proc_array[1].p_share = 4;
  10031f:	c7 05 04 71 10 00 04 	movl   $0x4,0x107104
  100326:	00 00 00 
	proc_array[2].p_share = 3;
  100329:	c7 05 60 71 10 00 03 	movl   $0x3,0x107160
  100330:	00 00 00 
	proc_array[3].p_share = 2;
  100333:	c7 05 bc 71 10 00 02 	movl   $0x2,0x1071bc
  10033a:	00 00 00 
	proc_array[4].p_share = 5;
  10033d:	c7 05 18 72 10 00 05 	movl   $0x5,0x107218
  100344:	00 00 00 
	proc_array[1].p_times_run = 1;//first process run initially in this function
  100347:	c7 05 08 71 10 00 01 	movl   $0x1,0x107108
  10034e:	00 00 00 
	proc_array[2].p_times_run = 0;
  100351:	c7 05 64 71 10 00 00 	movl   $0x0,0x107164
  100358:	00 00 00 
	proc_array[3].p_times_run = 0;
  10035b:	c7 05 c0 71 10 00 00 	movl   $0x0,0x1071c0
  100362:	00 00 00 
	proc_array[4].p_times_run = 0;
  100365:	c7 05 1c 72 10 00 00 	movl   $0x0,0x10721c
  10036c:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10036f:	83 ec 0c             	sub    $0xc,%esp
  100372:	53                   	push   %ebx
  100373:	e8 ac 02 00 00       	call   100624 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100378:	58                   	pop    %eax
  100379:	5a                   	pop    %edx
  10037a:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10037d:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100380:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100386:	50                   	push   %eax
  100387:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100388:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100389:	e8 d2 02 00 00       	call   100660 <program_loader>
	proc_array[4].p_times_run = 0;
	

	
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10038e:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100391:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100398:	83 c3 5c             	add    $0x5c,%ebx
	proc_array[4].p_times_run = 0;
	

	
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10039b:	83 fe 04             	cmp    $0x4,%esi
  10039e:	75 cf                	jne    10036f <start+0xee>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);
  1003a0:	83 ec 0c             	sub    $0xc,%esp
  1003a3:	68 b0 70 10 00       	push   $0x1070b0
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
	}
	proc_array[1].p_priority = 16;
  1003a8:	c7 05 00 71 10 00 10 	movl   $0x10,0x107100
  1003af:	00 00 00 
	proc_array[2].p_priority = 12;
  1003b2:	c7 05 5c 71 10 00 0c 	movl   $0xc,0x10715c
  1003b9:	00 00 00 
	proc_array[3].p_priority = 60;	
  1003bc:	c7 05 b8 71 10 00 3c 	movl   $0x3c,0x1071b8
  1003c3:	00 00 00 
	proc_array[4].p_priority = 10;
  1003c6:	c7 05 14 72 10 00 0a 	movl   $0xa,0x107214
  1003cd:	00 00 00 

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1003d0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1003d7:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 3;
  1003da:	c7 05 8c 7a 10 00 03 	movl   $0x3,0x107a8c
  1003e1:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1003e4:	e8 24 02 00 00       	call   10060d <run>
  1003e9:	90                   	nop
  1003ea:	90                   	nop
  1003eb:	90                   	nop

001003ec <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003ec:	b8 20 72 10 00       	mov    $0x107220,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003f6:	89 c2                	mov    %eax,%edx
  1003f8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003fb:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003fc:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100401:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100404:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10040a:	c1 e8 18             	shr    $0x18,%eax
  10040d:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100413:	ba 88 72 10 00       	mov    $0x107288,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100418:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10041d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10041f:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100426:	68 00 
  100428:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10042f:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100436:	c7 05 24 72 10 00 00 	movl   $0x180000,0x107224
  10043d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100440:	66 c7 05 28 72 10 00 	movw   $0x10,0x107228
  100447:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100449:	66 89 0c c5 88 72 10 	mov    %cx,0x107288(,%eax,8)
  100450:	00 
  100451:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100458:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10045d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100462:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100467:	40                   	inc    %eax
  100468:	3d 00 01 00 00       	cmp    $0x100,%eax
  10046d:	75 da                	jne    100449 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10046f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100474:	ba 88 72 10 00       	mov    $0x107288,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100479:	66 a3 88 73 10 00    	mov    %ax,0x107388
  10047f:	c1 e8 10             	shr    $0x10,%eax
  100482:	66 a3 8e 73 10 00    	mov    %ax,0x10738e
  100488:	b8 30 00 00 00       	mov    $0x30,%eax
  10048d:	66 c7 05 8a 73 10 00 	movw   $0x8,0x10738a
  100494:	08 00 
  100496:	c6 05 8c 73 10 00 00 	movb   $0x0,0x10738c
  10049d:	c6 05 8d 73 10 00 8e 	movb   $0x8e,0x10738d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004a4:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1004ab:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004b2:	66 89 0c c5 88 72 10 	mov    %cx,0x107288(,%eax,8)
  1004b9:	00 
  1004ba:	c1 e9 10             	shr    $0x10,%ecx
  1004bd:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004c2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1004c7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1004cc:	40                   	inc    %eax
  1004cd:	83 f8 3a             	cmp    $0x3a,%eax
  1004d0:	75 d2                	jne    1004a4 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1004d2:	b0 28                	mov    $0x28,%al
  1004d4:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1004db:	0f 00 d8             	ltr    %ax
  1004de:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1004e5:	5b                   	pop    %ebx
  1004e6:	c3                   	ret    

001004e7 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1004e7:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1004e8:	b0 ff                	mov    $0xff,%al
  1004ea:	57                   	push   %edi
  1004eb:	56                   	push   %esi
  1004ec:	53                   	push   %ebx
  1004ed:	bb 21 00 00 00       	mov    $0x21,%ebx
  1004f2:	89 da                	mov    %ebx,%edx
  1004f4:	ee                   	out    %al,(%dx)
  1004f5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004fa:	89 ca                	mov    %ecx,%edx
  1004fc:	ee                   	out    %al,(%dx)
  1004fd:	be 11 00 00 00       	mov    $0x11,%esi
  100502:	bf 20 00 00 00       	mov    $0x20,%edi
  100507:	89 f0                	mov    %esi,%eax
  100509:	89 fa                	mov    %edi,%edx
  10050b:	ee                   	out    %al,(%dx)
  10050c:	b0 20                	mov    $0x20,%al
  10050e:	89 da                	mov    %ebx,%edx
  100510:	ee                   	out    %al,(%dx)
  100511:	b0 04                	mov    $0x4,%al
  100513:	ee                   	out    %al,(%dx)
  100514:	b0 03                	mov    $0x3,%al
  100516:	ee                   	out    %al,(%dx)
  100517:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10051c:	89 f0                	mov    %esi,%eax
  10051e:	89 ea                	mov    %ebp,%edx
  100520:	ee                   	out    %al,(%dx)
  100521:	b0 28                	mov    $0x28,%al
  100523:	89 ca                	mov    %ecx,%edx
  100525:	ee                   	out    %al,(%dx)
  100526:	b0 02                	mov    $0x2,%al
  100528:	ee                   	out    %al,(%dx)
  100529:	b0 01                	mov    $0x1,%al
  10052b:	ee                   	out    %al,(%dx)
  10052c:	b0 68                	mov    $0x68,%al
  10052e:	89 fa                	mov    %edi,%edx
  100530:	ee                   	out    %al,(%dx)
  100531:	be 0a 00 00 00       	mov    $0xa,%esi
  100536:	89 f0                	mov    %esi,%eax
  100538:	ee                   	out    %al,(%dx)
  100539:	b0 68                	mov    $0x68,%al
  10053b:	89 ea                	mov    %ebp,%edx
  10053d:	ee                   	out    %al,(%dx)
  10053e:	89 f0                	mov    %esi,%eax
  100540:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100541:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100546:	89 da                	mov    %ebx,%edx
  100548:	19 c0                	sbb    %eax,%eax
  10054a:	f7 d0                	not    %eax
  10054c:	05 ff 00 00 00       	add    $0xff,%eax
  100551:	ee                   	out    %al,(%dx)
  100552:	b0 ff                	mov    $0xff,%al
  100554:	89 ca                	mov    %ecx,%edx
  100556:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100557:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10055c:	74 0d                	je     10056b <interrupt_controller_init+0x84>
  10055e:	b2 43                	mov    $0x43,%dl
  100560:	b0 34                	mov    $0x34,%al
  100562:	ee                   	out    %al,(%dx)
  100563:	b0 9c                	mov    $0x9c,%al
  100565:	b2 40                	mov    $0x40,%dl
  100567:	ee                   	out    %al,(%dx)
  100568:	b0 2e                	mov    $0x2e,%al
  10056a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10056b:	5b                   	pop    %ebx
  10056c:	5e                   	pop    %esi
  10056d:	5f                   	pop    %edi
  10056e:	5d                   	pop    %ebp
  10056f:	c3                   	ret    

00100570 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100570:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100571:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100573:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100574:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10057b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10057e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100584:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10058a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10058d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100592:	75 ea                	jne    10057e <console_clear+0xe>
  100594:	be d4 03 00 00       	mov    $0x3d4,%esi
  100599:	b0 0e                	mov    $0xe,%al
  10059b:	89 f2                	mov    %esi,%edx
  10059d:	ee                   	out    %al,(%dx)
  10059e:	31 c9                	xor    %ecx,%ecx
  1005a0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1005a5:	88 c8                	mov    %cl,%al
  1005a7:	89 da                	mov    %ebx,%edx
  1005a9:	ee                   	out    %al,(%dx)
  1005aa:	b0 0f                	mov    $0xf,%al
  1005ac:	89 f2                	mov    %esi,%edx
  1005ae:	ee                   	out    %al,(%dx)
  1005af:	88 c8                	mov    %cl,%al
  1005b1:	89 da                	mov    %ebx,%edx
  1005b3:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1005b4:	5b                   	pop    %ebx
  1005b5:	5e                   	pop    %esi
  1005b6:	c3                   	ret    

001005b7 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1005b7:	ba 64 00 00 00       	mov    $0x64,%edx
  1005bc:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1005bd:	a8 01                	test   $0x1,%al
  1005bf:	74 45                	je     100606 <console_read_digit+0x4f>
  1005c1:	b2 60                	mov    $0x60,%dl
  1005c3:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1005c4:	8d 50 fe             	lea    -0x2(%eax),%edx
  1005c7:	80 fa 08             	cmp    $0x8,%dl
  1005ca:	77 05                	ja     1005d1 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1005cc:	0f b6 c0             	movzbl %al,%eax
  1005cf:	48                   	dec    %eax
  1005d0:	c3                   	ret    
	else if (data == 0x0B)
  1005d1:	3c 0b                	cmp    $0xb,%al
  1005d3:	74 35                	je     10060a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1005d5:	8d 50 b9             	lea    -0x47(%eax),%edx
  1005d8:	80 fa 02             	cmp    $0x2,%dl
  1005db:	77 07                	ja     1005e4 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1005dd:	0f b6 c0             	movzbl %al,%eax
  1005e0:	83 e8 40             	sub    $0x40,%eax
  1005e3:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1005e4:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1005e7:	80 fa 02             	cmp    $0x2,%dl
  1005ea:	77 07                	ja     1005f3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1005ec:	0f b6 c0             	movzbl %al,%eax
  1005ef:	83 e8 47             	sub    $0x47,%eax
  1005f2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1005f3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005f6:	80 fa 02             	cmp    $0x2,%dl
  1005f9:	77 07                	ja     100602 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005fb:	0f b6 c0             	movzbl %al,%eax
  1005fe:	83 e8 4e             	sub    $0x4e,%eax
  100601:	c3                   	ret    
	else if (data == 0x53)
  100602:	3c 53                	cmp    $0x53,%al
  100604:	74 04                	je     10060a <console_read_digit+0x53>
  100606:	83 c8 ff             	or     $0xffffffff,%eax
  100609:	c3                   	ret    
  10060a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10060c:	c3                   	ret    

0010060d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10060d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100611:	a3 88 7a 10 00       	mov    %eax,0x107a88

	asm volatile("movl %0,%%esp\n\t"
  100616:	83 c0 04             	add    $0x4,%eax
  100619:	89 c4                	mov    %eax,%esp
  10061b:	61                   	popa   
  10061c:	07                   	pop    %es
  10061d:	1f                   	pop    %ds
  10061e:	83 c4 08             	add    $0x8,%esp
  100621:	cf                   	iret   
  100622:	eb fe                	jmp    100622 <run+0x15>

00100624 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100624:	53                   	push   %ebx
  100625:	83 ec 0c             	sub    $0xc,%esp
  100628:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10062c:	6a 44                	push   $0x44
  10062e:	6a 00                	push   $0x0
  100630:	8d 43 04             	lea    0x4(%ebx),%eax
  100633:	50                   	push   %eax
  100634:	e8 17 01 00 00       	call   100750 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100639:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10063f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100645:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10064b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100651:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100658:	83 c4 18             	add    $0x18,%esp
  10065b:	5b                   	pop    %ebx
  10065c:	c3                   	ret    
  10065d:	90                   	nop
  10065e:	90                   	nop
  10065f:	90                   	nop

00100660 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100660:	55                   	push   %ebp
  100661:	57                   	push   %edi
  100662:	56                   	push   %esi
  100663:	53                   	push   %ebx
  100664:	83 ec 1c             	sub    $0x1c,%esp
  100667:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10066b:	83 f8 03             	cmp    $0x3,%eax
  10066e:	7f 04                	jg     100674 <program_loader+0x14>
  100670:	85 c0                	test   %eax,%eax
  100672:	79 02                	jns    100676 <program_loader+0x16>
  100674:	eb fe                	jmp    100674 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100676:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10067d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100683:	74 02                	je     100687 <program_loader+0x27>
  100685:	eb fe                	jmp    100685 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100687:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10068a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10068e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100690:	c1 e5 05             	shl    $0x5,%ebp
  100693:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100696:	eb 3f                	jmp    1006d7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100698:	83 3b 01             	cmpl   $0x1,(%ebx)
  10069b:	75 37                	jne    1006d4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10069d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006a0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1006a3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006a6:	01 c7                	add    %eax,%edi
	memsz += va;
  1006a8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1006aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1006af:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1006b3:	52                   	push   %edx
  1006b4:	89 fa                	mov    %edi,%edx
  1006b6:	29 c2                	sub    %eax,%edx
  1006b8:	52                   	push   %edx
  1006b9:	8b 53 04             	mov    0x4(%ebx),%edx
  1006bc:	01 f2                	add    %esi,%edx
  1006be:	52                   	push   %edx
  1006bf:	50                   	push   %eax
  1006c0:	e8 27 00 00 00       	call   1006ec <memcpy>
  1006c5:	83 c4 10             	add    $0x10,%esp
  1006c8:	eb 04                	jmp    1006ce <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1006ca:	c6 07 00             	movb   $0x0,(%edi)
  1006cd:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1006ce:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1006d2:	72 f6                	jb     1006ca <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1006d4:	83 c3 20             	add    $0x20,%ebx
  1006d7:	39 eb                	cmp    %ebp,%ebx
  1006d9:	72 bd                	jb     100698 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1006db:	8b 56 18             	mov    0x18(%esi),%edx
  1006de:	8b 44 24 34          	mov    0x34(%esp),%eax
  1006e2:	89 10                	mov    %edx,(%eax)
}
  1006e4:	83 c4 1c             	add    $0x1c,%esp
  1006e7:	5b                   	pop    %ebx
  1006e8:	5e                   	pop    %esi
  1006e9:	5f                   	pop    %edi
  1006ea:	5d                   	pop    %ebp
  1006eb:	c3                   	ret    

001006ec <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1006ec:	56                   	push   %esi
  1006ed:	31 d2                	xor    %edx,%edx
  1006ef:	53                   	push   %ebx
  1006f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006f4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006f8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006fc:	eb 08                	jmp    100706 <memcpy+0x1a>
		*d++ = *s++;
  1006fe:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100701:	4e                   	dec    %esi
  100702:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100705:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100706:	85 f6                	test   %esi,%esi
  100708:	75 f4                	jne    1006fe <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10070a:	5b                   	pop    %ebx
  10070b:	5e                   	pop    %esi
  10070c:	c3                   	ret    

0010070d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10070d:	57                   	push   %edi
  10070e:	56                   	push   %esi
  10070f:	53                   	push   %ebx
  100710:	8b 44 24 10          	mov    0x10(%esp),%eax
  100714:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100718:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10071c:	39 c7                	cmp    %eax,%edi
  10071e:	73 26                	jae    100746 <memmove+0x39>
  100720:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100723:	39 c6                	cmp    %eax,%esi
  100725:	76 1f                	jbe    100746 <memmove+0x39>
		s += n, d += n;
  100727:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10072a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10072c:	eb 07                	jmp    100735 <memmove+0x28>
			*--d = *--s;
  10072e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100731:	4a                   	dec    %edx
  100732:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100735:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100736:	85 d2                	test   %edx,%edx
  100738:	75 f4                	jne    10072e <memmove+0x21>
  10073a:	eb 10                	jmp    10074c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10073c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10073f:	4a                   	dec    %edx
  100740:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100743:	41                   	inc    %ecx
  100744:	eb 02                	jmp    100748 <memmove+0x3b>
  100746:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100748:	85 d2                	test   %edx,%edx
  10074a:	75 f0                	jne    10073c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10074c:	5b                   	pop    %ebx
  10074d:	5e                   	pop    %esi
  10074e:	5f                   	pop    %edi
  10074f:	c3                   	ret    

00100750 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100750:	53                   	push   %ebx
  100751:	8b 44 24 08          	mov    0x8(%esp),%eax
  100755:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100759:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10075d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10075f:	eb 04                	jmp    100765 <memset+0x15>
		*p++ = c;
  100761:	88 1a                	mov    %bl,(%edx)
  100763:	49                   	dec    %ecx
  100764:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100765:	85 c9                	test   %ecx,%ecx
  100767:	75 f8                	jne    100761 <memset+0x11>
		*p++ = c;
	return v;
}
  100769:	5b                   	pop    %ebx
  10076a:	c3                   	ret    

0010076b <strlen>:

size_t
strlen(const char *s)
{
  10076b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10076f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100771:	eb 01                	jmp    100774 <strlen+0x9>
		++n;
  100773:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100774:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100778:	75 f9                	jne    100773 <strlen+0x8>
		++n;
	return n;
}
  10077a:	c3                   	ret    

0010077b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10077b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10077f:	31 c0                	xor    %eax,%eax
  100781:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100785:	eb 01                	jmp    100788 <strnlen+0xd>
		++n;
  100787:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100788:	39 d0                	cmp    %edx,%eax
  10078a:	74 06                	je     100792 <strnlen+0x17>
  10078c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100790:	75 f5                	jne    100787 <strnlen+0xc>
		++n;
	return n;
}
  100792:	c3                   	ret    

00100793 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100793:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100794:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100799:	53                   	push   %ebx
  10079a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10079c:	76 05                	jbe    1007a3 <console_putc+0x10>
  10079e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007a3:	80 fa 0a             	cmp    $0xa,%dl
  1007a6:	75 2c                	jne    1007d4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007a8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007ae:	be 50 00 00 00       	mov    $0x50,%esi
  1007b3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1007b5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007b8:	99                   	cltd   
  1007b9:	f7 fe                	idiv   %esi
  1007bb:	89 de                	mov    %ebx,%esi
  1007bd:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1007bf:	eb 07                	jmp    1007c8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1007c1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007c4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1007c5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007c8:	83 f8 50             	cmp    $0x50,%eax
  1007cb:	75 f4                	jne    1007c1 <console_putc+0x2e>
  1007cd:	29 d0                	sub    %edx,%eax
  1007cf:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1007d2:	eb 0b                	jmp    1007df <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1007d4:	0f b6 d2             	movzbl %dl,%edx
  1007d7:	09 ca                	or     %ecx,%edx
  1007d9:	66 89 13             	mov    %dx,(%ebx)
  1007dc:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1007df:	5b                   	pop    %ebx
  1007e0:	5e                   	pop    %esi
  1007e1:	c3                   	ret    

001007e2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1007e2:	56                   	push   %esi
  1007e3:	53                   	push   %ebx
  1007e4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1007e8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1007eb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1007ef:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1007f4:	75 04                	jne    1007fa <fill_numbuf+0x18>
  1007f6:	85 d2                	test   %edx,%edx
  1007f8:	74 10                	je     10080a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1007fa:	89 d0                	mov    %edx,%eax
  1007fc:	31 d2                	xor    %edx,%edx
  1007fe:	f7 f1                	div    %ecx
  100800:	4b                   	dec    %ebx
  100801:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100804:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100806:	89 c2                	mov    %eax,%edx
  100808:	eb ec                	jmp    1007f6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10080a:	89 d8                	mov    %ebx,%eax
  10080c:	5b                   	pop    %ebx
  10080d:	5e                   	pop    %esi
  10080e:	c3                   	ret    

0010080f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10080f:	55                   	push   %ebp
  100810:	57                   	push   %edi
  100811:	56                   	push   %esi
  100812:	53                   	push   %ebx
  100813:	83 ec 38             	sub    $0x38,%esp
  100816:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10081a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10081e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100822:	e9 60 03 00 00       	jmp    100b87 <console_vprintf+0x378>
		if (*format != '%') {
  100827:	80 fa 25             	cmp    $0x25,%dl
  10082a:	74 13                	je     10083f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10082c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100830:	0f b6 d2             	movzbl %dl,%edx
  100833:	89 f0                	mov    %esi,%eax
  100835:	e8 59 ff ff ff       	call   100793 <console_putc>
  10083a:	e9 45 03 00 00       	jmp    100b84 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10083f:	47                   	inc    %edi
  100840:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100847:	00 
  100848:	eb 12                	jmp    10085c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10084a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10084b:	8a 11                	mov    (%ecx),%dl
  10084d:	84 d2                	test   %dl,%dl
  10084f:	74 1a                	je     10086b <console_vprintf+0x5c>
  100851:	89 e8                	mov    %ebp,%eax
  100853:	38 c2                	cmp    %al,%dl
  100855:	75 f3                	jne    10084a <console_vprintf+0x3b>
  100857:	e9 3f 03 00 00       	jmp    100b9b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10085c:	8a 17                	mov    (%edi),%dl
  10085e:	84 d2                	test   %dl,%dl
  100860:	74 0b                	je     10086d <console_vprintf+0x5e>
  100862:	b9 48 0c 10 00       	mov    $0x100c48,%ecx
  100867:	89 d5                	mov    %edx,%ebp
  100869:	eb e0                	jmp    10084b <console_vprintf+0x3c>
  10086b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10086d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100870:	3c 08                	cmp    $0x8,%al
  100872:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100879:	00 
  10087a:	76 13                	jbe    10088f <console_vprintf+0x80>
  10087c:	eb 1d                	jmp    10089b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10087e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100883:	0f be c0             	movsbl %al,%eax
  100886:	47                   	inc    %edi
  100887:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10088b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10088f:	8a 07                	mov    (%edi),%al
  100891:	8d 50 d0             	lea    -0x30(%eax),%edx
  100894:	80 fa 09             	cmp    $0x9,%dl
  100897:	76 e5                	jbe    10087e <console_vprintf+0x6f>
  100899:	eb 18                	jmp    1008b3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10089b:	80 fa 2a             	cmp    $0x2a,%dl
  10089e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008a5:	ff 
  1008a6:	75 0b                	jne    1008b3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008a8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008ab:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008ac:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008af:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1008b3:	83 cd ff             	or     $0xffffffff,%ebp
  1008b6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1008b9:	75 37                	jne    1008f2 <console_vprintf+0xe3>
			++format;
  1008bb:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1008bc:	31 ed                	xor    %ebp,%ebp
  1008be:	8a 07                	mov    (%edi),%al
  1008c0:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008c3:	80 fa 09             	cmp    $0x9,%dl
  1008c6:	76 0d                	jbe    1008d5 <console_vprintf+0xc6>
  1008c8:	eb 17                	jmp    1008e1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1008ca:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1008cd:	0f be c0             	movsbl %al,%eax
  1008d0:	47                   	inc    %edi
  1008d1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1008d5:	8a 07                	mov    (%edi),%al
  1008d7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008da:	80 fa 09             	cmp    $0x9,%dl
  1008dd:	76 eb                	jbe    1008ca <console_vprintf+0xbb>
  1008df:	eb 11                	jmp    1008f2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1008e1:	3c 2a                	cmp    $0x2a,%al
  1008e3:	75 0b                	jne    1008f0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1008e5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1008e8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1008e9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1008ec:	85 ed                	test   %ebp,%ebp
  1008ee:	79 02                	jns    1008f2 <console_vprintf+0xe3>
  1008f0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1008f2:	8a 07                	mov    (%edi),%al
  1008f4:	3c 64                	cmp    $0x64,%al
  1008f6:	74 34                	je     10092c <console_vprintf+0x11d>
  1008f8:	7f 1d                	jg     100917 <console_vprintf+0x108>
  1008fa:	3c 58                	cmp    $0x58,%al
  1008fc:	0f 84 a2 00 00 00    	je     1009a4 <console_vprintf+0x195>
  100902:	3c 63                	cmp    $0x63,%al
  100904:	0f 84 bf 00 00 00    	je     1009c9 <console_vprintf+0x1ba>
  10090a:	3c 43                	cmp    $0x43,%al
  10090c:	0f 85 d0 00 00 00    	jne    1009e2 <console_vprintf+0x1d3>
  100912:	e9 a3 00 00 00       	jmp    1009ba <console_vprintf+0x1ab>
  100917:	3c 75                	cmp    $0x75,%al
  100919:	74 4d                	je     100968 <console_vprintf+0x159>
  10091b:	3c 78                	cmp    $0x78,%al
  10091d:	74 5c                	je     10097b <console_vprintf+0x16c>
  10091f:	3c 73                	cmp    $0x73,%al
  100921:	0f 85 bb 00 00 00    	jne    1009e2 <console_vprintf+0x1d3>
  100927:	e9 86 00 00 00       	jmp    1009b2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10092c:	83 c3 04             	add    $0x4,%ebx
  10092f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100932:	89 d1                	mov    %edx,%ecx
  100934:	c1 f9 1f             	sar    $0x1f,%ecx
  100937:	89 0c 24             	mov    %ecx,(%esp)
  10093a:	31 ca                	xor    %ecx,%edx
  10093c:	55                   	push   %ebp
  10093d:	29 ca                	sub    %ecx,%edx
  10093f:	68 50 0c 10 00       	push   $0x100c50
  100944:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100949:	8d 44 24 40          	lea    0x40(%esp),%eax
  10094d:	e8 90 fe ff ff       	call   1007e2 <fill_numbuf>
  100952:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100956:	58                   	pop    %eax
  100957:	5a                   	pop    %edx
  100958:	ba 01 00 00 00       	mov    $0x1,%edx
  10095d:	8b 04 24             	mov    (%esp),%eax
  100960:	83 e0 01             	and    $0x1,%eax
  100963:	e9 a5 00 00 00       	jmp    100a0d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100968:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10096b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100970:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100973:	55                   	push   %ebp
  100974:	68 50 0c 10 00       	push   $0x100c50
  100979:	eb 11                	jmp    10098c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10097b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10097e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100981:	55                   	push   %ebp
  100982:	68 64 0c 10 00       	push   $0x100c64
  100987:	b9 10 00 00 00       	mov    $0x10,%ecx
  10098c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100990:	e8 4d fe ff ff       	call   1007e2 <fill_numbuf>
  100995:	ba 01 00 00 00       	mov    $0x1,%edx
  10099a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10099e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009a0:	59                   	pop    %ecx
  1009a1:	59                   	pop    %ecx
  1009a2:	eb 69                	jmp    100a0d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009a4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009a7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009aa:	55                   	push   %ebp
  1009ab:	68 50 0c 10 00       	push   $0x100c50
  1009b0:	eb d5                	jmp    100987 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1009b2:	83 c3 04             	add    $0x4,%ebx
  1009b5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1009b8:	eb 40                	jmp    1009fa <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1009ba:	83 c3 04             	add    $0x4,%ebx
  1009bd:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009c0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1009c4:	e9 bd 01 00 00       	jmp    100b86 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009c9:	83 c3 04             	add    $0x4,%ebx
  1009cc:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1009cf:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1009d3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1009d8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009dc:	88 44 24 24          	mov    %al,0x24(%esp)
  1009e0:	eb 27                	jmp    100a09 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1009e2:	84 c0                	test   %al,%al
  1009e4:	75 02                	jne    1009e8 <console_vprintf+0x1d9>
  1009e6:	b0 25                	mov    $0x25,%al
  1009e8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1009ec:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1009f1:	80 3f 00             	cmpb   $0x0,(%edi)
  1009f4:	74 0a                	je     100a00 <console_vprintf+0x1f1>
  1009f6:	8d 44 24 24          	lea    0x24(%esp),%eax
  1009fa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009fe:	eb 09                	jmp    100a09 <console_vprintf+0x1fa>
				format--;
  100a00:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a04:	4f                   	dec    %edi
  100a05:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a09:	31 d2                	xor    %edx,%edx
  100a0b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a0d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a0f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a12:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a19:	74 1f                	je     100a3a <console_vprintf+0x22b>
  100a1b:	89 04 24             	mov    %eax,(%esp)
  100a1e:	eb 01                	jmp    100a21 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a20:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a21:	39 e9                	cmp    %ebp,%ecx
  100a23:	74 0a                	je     100a2f <console_vprintf+0x220>
  100a25:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a29:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a2d:	75 f1                	jne    100a20 <console_vprintf+0x211>
  100a2f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a32:	89 0c 24             	mov    %ecx,(%esp)
  100a35:	eb 1f                	jmp    100a56 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a37:	42                   	inc    %edx
  100a38:	eb 09                	jmp    100a43 <console_vprintf+0x234>
  100a3a:	89 d1                	mov    %edx,%ecx
  100a3c:	8b 14 24             	mov    (%esp),%edx
  100a3f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a43:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a47:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a4b:	75 ea                	jne    100a37 <console_vprintf+0x228>
  100a4d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a51:	89 14 24             	mov    %edx,(%esp)
  100a54:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a56:	85 c0                	test   %eax,%eax
  100a58:	74 0c                	je     100a66 <console_vprintf+0x257>
  100a5a:	84 d2                	test   %dl,%dl
  100a5c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a63:	00 
  100a64:	75 24                	jne    100a8a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a66:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a6b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a72:	00 
  100a73:	75 15                	jne    100a8a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a75:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a79:	83 e0 08             	and    $0x8,%eax
  100a7c:	83 f8 01             	cmp    $0x1,%eax
  100a7f:	19 c9                	sbb    %ecx,%ecx
  100a81:	f7 d1                	not    %ecx
  100a83:	83 e1 20             	and    $0x20,%ecx
  100a86:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a8a:	3b 2c 24             	cmp    (%esp),%ebp
  100a8d:	7e 0d                	jle    100a9c <console_vprintf+0x28d>
  100a8f:	84 d2                	test   %dl,%dl
  100a91:	74 40                	je     100ad3 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a93:	2b 2c 24             	sub    (%esp),%ebp
  100a96:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a9a:	eb 3f                	jmp    100adb <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a9c:	84 d2                	test   %dl,%dl
  100a9e:	74 33                	je     100ad3 <console_vprintf+0x2c4>
  100aa0:	8b 44 24 14          	mov    0x14(%esp),%eax
  100aa4:	83 e0 06             	and    $0x6,%eax
  100aa7:	83 f8 02             	cmp    $0x2,%eax
  100aaa:	75 27                	jne    100ad3 <console_vprintf+0x2c4>
  100aac:	45                   	inc    %ebp
  100aad:	75 24                	jne    100ad3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100aaf:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ab1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ab4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ab9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100abc:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100abf:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100ac3:	7d 0e                	jge    100ad3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100ac5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100ac9:	29 ca                	sub    %ecx,%edx
  100acb:	29 c2                	sub    %eax,%edx
  100acd:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ad1:	eb 08                	jmp    100adb <console_vprintf+0x2cc>
  100ad3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100ada:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100adb:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100adf:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ae1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100ae5:	2b 2c 24             	sub    (%esp),%ebp
  100ae8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100aed:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100af0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100af3:	29 c5                	sub    %eax,%ebp
  100af5:	89 f0                	mov    %esi,%eax
  100af7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100afb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100aff:	eb 0f                	jmp    100b10 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b01:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b05:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b0a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b0b:	e8 83 fc ff ff       	call   100793 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b10:	85 ed                	test   %ebp,%ebp
  100b12:	7e 07                	jle    100b1b <console_vprintf+0x30c>
  100b14:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b19:	74 e6                	je     100b01 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b1b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b20:	89 c6                	mov    %eax,%esi
  100b22:	74 23                	je     100b47 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b24:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b29:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b2d:	e8 61 fc ff ff       	call   100793 <console_putc>
  100b32:	89 c6                	mov    %eax,%esi
  100b34:	eb 11                	jmp    100b47 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b36:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b3a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b3f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b40:	e8 4e fc ff ff       	call   100793 <console_putc>
  100b45:	eb 06                	jmp    100b4d <console_vprintf+0x33e>
  100b47:	89 f0                	mov    %esi,%eax
  100b49:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b4d:	85 f6                	test   %esi,%esi
  100b4f:	7f e5                	jg     100b36 <console_vprintf+0x327>
  100b51:	8b 34 24             	mov    (%esp),%esi
  100b54:	eb 15                	jmp    100b6b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b56:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b5a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b5b:	0f b6 11             	movzbl (%ecx),%edx
  100b5e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b62:	e8 2c fc ff ff       	call   100793 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b67:	ff 44 24 04          	incl   0x4(%esp)
  100b6b:	85 f6                	test   %esi,%esi
  100b6d:	7f e7                	jg     100b56 <console_vprintf+0x347>
  100b6f:	eb 0f                	jmp    100b80 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b71:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b75:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b7a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b7b:	e8 13 fc ff ff       	call   100793 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b80:	85 ed                	test   %ebp,%ebp
  100b82:	7f ed                	jg     100b71 <console_vprintf+0x362>
  100b84:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b86:	47                   	inc    %edi
  100b87:	8a 17                	mov    (%edi),%dl
  100b89:	84 d2                	test   %dl,%dl
  100b8b:	0f 85 96 fc ff ff    	jne    100827 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b91:	83 c4 38             	add    $0x38,%esp
  100b94:	89 f0                	mov    %esi,%eax
  100b96:	5b                   	pop    %ebx
  100b97:	5e                   	pop    %esi
  100b98:	5f                   	pop    %edi
  100b99:	5d                   	pop    %ebp
  100b9a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b9b:	81 e9 48 0c 10 00    	sub    $0x100c48,%ecx
  100ba1:	b8 01 00 00 00       	mov    $0x1,%eax
  100ba6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ba8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ba9:	09 44 24 14          	or     %eax,0x14(%esp)
  100bad:	e9 aa fc ff ff       	jmp    10085c <console_vprintf+0x4d>

00100bb2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100bb2:	8d 44 24 10          	lea    0x10(%esp),%eax
  100bb6:	50                   	push   %eax
  100bb7:	ff 74 24 10          	pushl  0x10(%esp)
  100bbb:	ff 74 24 10          	pushl  0x10(%esp)
  100bbf:	ff 74 24 10          	pushl  0x10(%esp)
  100bc3:	e8 47 fc ff ff       	call   10080f <console_vprintf>
  100bc8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100bcb:	c3                   	ret    
