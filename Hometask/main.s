# -4[rbp] -> r12d
# -8[rbp] -> r13d
# -12[rbp] -> r14d
	.intel_syntax noprefix
	.text					# начинает секцию
	.local	A				# массив A
	.comm	A,4000000,32
	.local	B				# массив B
	.comm	B,4000000,32
	.section	.rodata		# .rodata
.LC0:
	.string	"%d"			# .LC0: "%d"
.LC1:	
	.string	"%d "			# .LC1: "%d "
	
	.text					# Секция с кодом
	.globl	main
main:
	push	rbp				# / Сохраняем rbp на стек
	mov	rbp, rsp			# | rbp := rsp
	sub	rsp, 32			# \ rsp -= 32
	mov	DWORD PTR -20[rbp], edi	# edi - 1-й - argc
	mov	QWORD PTR -32[rbp], rsi	# rsi - 2-й - argv
	mov	r13d, 0			# rbp[-8] := 0, то есть count := 0	
	lea rsi, -12[rbp]			# rsi := &(-12 на стеке) - 2й аргумент
	lea	rdi, .LC0[rip]			# rdi := &(строчка "%d") - 1й аргумент	
	mov	eax, 0				# eax := 0
	call	__isoc99_scanf@PLT		# scanf("%d", &rbp[-12])
	mov     r14d, -12[rbp]
	mov	r12d, 0			# rbp[-4] := 0, то есть i := 0
	jmp	.L2				# Переходим в .L2
.L3:
	mov	eax, r12d			# eax := rbp[-4] (i)
	lea	rdx, 0[0+rax*4]		# rdx := rax * 4
	lea	rax, A[rip]			# rax := &A
	add	rax, rdx			# rax := rax + rdx
	mov	rsi, rax			# rsi := rax (&A[i]) - 2й аргумент
	lea	rdi, .LC0[rip]			# rdi := &(строчка "%d") - 1й аргумент
	mov	eax, 0				# eax := 0
	call	__isoc99_scanf@PLT		# scanf("%d", &A[i])
	add	r12d, 1			# rbp[-4] := rbp[-4] + 1 (i := i + 1)
.L2:
	mov	eax, r14d			# eax := rbp[-12] (n)
	cmp	r12d, eax			# Сравниваем rbp[-4] и eax (i и n)
	jl	.L3				# Если rbp[-4] < eax (i < n), то переходим в .L3
	mov	r12d, 0			# rbp[-4] := 0 (i := 0)
	jmp	.L4				# Переходим в .L4
.L6:
	mov	eax, r12d			# eax := rbp[-4] (i)
	lea	rdx, 0[0+rax*4]		# rdx := rax * 4	
	lea	rax, A[rip]			# rax := &A
	mov	eax, DWORD PTR [rdx+rax]	# eax := A[i]
	test	eax, eax			# Сравниваем eax с нулём (A[i] с нулём)
	jle	.L5				# Если eax <= 0 (A[i] <= 0), то переходим в .L5
	mov	eax, r12d			# eax := rbp[-4] (i)
	lea	rdx, 0[0+rax*4]		# rdx := rax * 4
	lea	rax, A[rip]			# rax := &A
	mov	eax, DWORD PTR [rdx+rax]	# eax := A[i]
	mov	edx, r13d			# edx := rbp[-8] (count)
	movsx	rdx, edx			# rdx := edx
	lea	rcx, 0[0+rdx*4]		# rcx := rdx * 4
	lea	rdx, B[rip]			# rdx := &B
	mov	DWORD PTR [rcx+rdx], eax	# B[i] := eax (A[i])
	add	r13d, 1			# rbp[-8] := rbp[-8] + 1 (count := count + 1)
.L5:
	add	r12d, 1			# rbp[-4] := rbp[-4] + 1 (i := i + 1)
.L4:
	mov	eax, r14d			# eax := rbp[-12] (n)
	cmp	r12d, eax			# Сравниваем rbp[-4] и eax (i и n)
	jl	.L6				# Если rbp[-4] < eax (i < n), то переходим в .L6
	mov	r12d, 0			# rbp[-4] := 0 (i := 0)	
	jmp	.L7				# Переходим в .L7
.L8:
	mov	eax, r12d			# eax := rbp[-4] (i)
	lea	rdx, 0[0+rax*4]		# rdx := rax * 4
	lea	rax, B[rip]			# rax := &B
	mov	eax, DWORD PTR [rdx+rax]	# eax := B[i]
	mov	esi, eax			# esi := eax (B[i])
	lea	rdi, .LC1[rip]			# rdi := &(строчка "%d ") - 1й аргумент
	mov	eax, 0				# eax := 0
	call	printf@PLT			# printf("%d ", B[i])
	add	r12d, 1			# rbp[-4] := rbp[-4] + 1 (i := i + 1)
.L7:
	mov	eax, r12d			# eax := rbp[-4] (i)
	cmp	eax, r13d			# Сравниваем eax и rbp[-8] (i и count)
	jl	.L8				# Если eax < rbp[-8] (i < count), то переходим в .L8
	mov	eax, 0				# eax := 0
	leave					# / Выход из функции
	ret					# \
