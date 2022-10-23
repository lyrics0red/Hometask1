# Hometask1

## 1) Краснослободцев Кирилл Дмитриевич
## 2) БПИ218
## 3) Вариант №1
Условие: Сформировать массив B из положительных элементов массива А.
## 4) Тесты
![image](https://user-images.githubusercontent.com/90769620/197410514-89532142-c06b-40bc-87e1-0bcd2443900a.png)
![image](https://user-images.githubusercontent.com/90769620/197410583-6027c31f-2e6b-4cf4-be37-5c68deeeb23c.png)
![image](https://user-images.githubusercontent.com/90769620/197410605-8a3cc37b-50ff-4efc-b678-65bb512ec1c0.png)
![image](https://user-images.githubusercontent.com/90769620/197410720-33b114e3-7781-49e4-ab91-98c54c7127b5.png)
![image](https://user-images.githubusercontent.com/90769620/197410613-8cf1a47b-0d73-435b-942b-9e446d1c0e47.png)
![image](https://user-images.githubusercontent.com/90769620/197410688-5dc12766-7026-4d49-a979-8d0c032ce014.png)
## 5) Результаты тестов
![image](https://user-images.githubusercontent.com/90769620/197411606-14199e4f-ee0c-4515-9fda-8a5afdf11b48.png)
## 6) main.c
	#include <stdio.h>

	static int A[1000000], B[1000000];

	int main(int argc, char** argv) {
    	int n, i, count = 0;

    	scanf("%d", &n);
    	for (i = 0; i < n; ++i) {
                scanf("%d", &A[i]);
    	}

    	for (i = 0; i < n; ++i) {
        	    if (A[i] > 0) {
            	B[count] = A[i];
            	++count;
        	    }
    	}

    	for (i = 0; i < count; ++i) {
        	    printf("%d ", B[i]);
    	}
    
    	return 0;
	}
## 7) main.s
	# -4[rbp] -> r12d
	# -8[rbp] -> r13d
	# -12[rbp] -> r14d
		.intel_syntax noprefix
		.text						# начинает секцию
		.local	A					# массив A
		.comm	A,4000000,32
		.local	B					# массив B
		.comm	B,4000000,32
		.section	.rodata			# .rodata
	.LC0:
		.string	"%d"				# .LC0: "%d"
	.LC1:	
		.string	"%d "				# .LC1: "%d "
	
		.text						# Секция с кодом
		.globl	main
	main:
		push	rbp					# / Сохраняем rbp на стек
		mov	rbp, rsp				# | rbp := rsp
		sub	rsp, 32					# \ rsp -= 32
		mov	DWORD PTR -20[rbp], edi	# edi - 1-й - argc
		mov	QWORD PTR -32[rbp], rsi	# rsi - 2-й - argv
		mov	r13d, 0					# r13d := 0, то есть count := 0	
		lea rsi, -12[rbp]			# rsi := &(-12 на стеке) - 2й аргумент
		lea	rdi, .LC0[rip]			# rdi := &(строчка "%d") - 1й аргумент	
		mov	eax, 0					# eax := 0
		call	__isoc99_scanf@PLT	# scanf("%d", &rbp[-12])
		mov     r14d, -12[rbp]		# r14d := rbp[-12]
		mov	r12d, 0					# r12d := 0, то есть i := 0
		jmp	.L2						# Переходим в .L2
	.L3:
		mov	eax, r12d				# eax := r12d (i)
		lea	rdx, 0[0+rax*4]			# rdx := rax * 4
		lea	rax, A[rip]				# rax := &A
		add	rax, rdx				# rax := rax + rdx
		mov	rsi, rax				# rsi := rax (&A[i]) - 2й аргумент
		lea	rdi, .LC0[rip]			# rdi := &(строчка "%d") - 1й аргумент
		mov	eax, 0					# eax := 0
		call	__isoc99_scanf@PLT	# scanf("%d", &A[i])
		add	r12d, 1					# r12d := r12d + 1 (i := i + 1)
	.L2:
		mov	eax, r14d				# eax := r14d (n)
		cmp	r12d, eax				# Сравниваем r12d и eax (i и n)
		jl	.L3						# Если r12d < eax (i < n), то переходим в .L3
		mov	r12d, 0					# r12d := 0 (i := 0)
		jmp	.L4						# Переходим в .L4
	.L6:
		mov	eax, r12d				# eax := r12d (i)
		lea	rdx, 0[0+rax*4]			# rdx := rax * 4	
		lea	rax, A[rip]				# rax := &A
		mov	eax, DWORD PTR [rdx+rax]# eax := A[i]
		test	eax, eax			# Сравниваем eax с нулём (A[i] с нулём)
		jle	.L5						# Если eax <= 0 (A[i] <= 0), то переходим в .L5
		mov	eax, r12d				# eax := r12d (i)
		lea	rdx, 0[0+rax*4]			# rdx := rax * 4
		lea	rax, A[rip]				# rax := &A
		mov	eax, DWORD PTR [rdx+rax]# eax := A[i]
		mov	edx, r13d				# edx := r13d (count)
		movsx	rdx, edx			# rdx := edx
		lea	rcx, 0[0+rdx*4]			# rcx := rdx * 4
		lea	rdx, B[rip]				# rdx := &B
		mov	DWORD PTR [rcx+rdx], eax# B[i] := eax (A[i])
		add	r13d, 1					# r13d := r13d + 1 (count := count + 1)
	.L5:
		add	r12d, 1					# r12d := r12d + 1 (i := i + 1)
	.L4:
		mov	eax, r14d				# eax := r14d (n)
		cmp	r12d, eax				# Сравниваем r12d и eax (i и n)
		jl	.L6						# Если r12d < eax (i < n), то переходим в .L6
		mov	r12d, 0					# r12d := 0 (i := 0)	
		jmp	.L7						# Переходим в .L7
	.L8:
		mov	eax, r12d				# eax := r12d (i)
		lea	rdx, 0[0+rax*4]			# rdx := rax * 4
		lea	rax, B[rip]				# rax := &B
		mov	eax, DWORD PTR [rdx+rax]# eax := B[i]
		mov	esi, eax				# esi := eax (B[i])
		lea	rdi, .LC1[rip]			# rdi := &(строчка "%d ") - 1й аргумент
		mov	eax, 0					# eax := 0
		call	printf@PLT			# printf("%d ", B[i])
		add	r12d, 1					# r12d := r12d + 1 (i := i + 1)
	.L7:
		mov	eax, r12d				# eax := r12d (i)
		cmp	eax, r13d				# Сравниваем eax и r13d (i и count)
		jl	.L8						# Если eax < r13d (i < count), то переходим в .L8
		mov	eax, 0					# eax := 0
		leave						# / Выход из функции
		ret							# \
## 8) clear.s
		.file "main.c"
		.intel_syntax noprefix
		.text
		.local A
		.comm A,4000000,32
		.local B
		.comm B,4000000,32
		.section .rodata
	.LC0:
		.string "%d"
	.LC1:
		.string "%d "
		.text
		.globl main
		.type main, @function
	main:
		endbr64
		push rbp
		mov rbp, rsp
		sub rsp, 32
		mov DWORD PTR -20[rbp], edi
		mov QWORD PTR -32[rbp], rsi
		mov DWORD PTR -8[rbp], 0
		lea rax, -12[rbp]
		mov rsi, rax
		lea rdi, .LC0[rip]
		mov eax, 0
		call __isoc99_scanf@PLT
		mov DWORD PTR -4[rbp], 0
		jmp .L2
	.L3:
		mov eax, DWORD PTR -4[rbp]
		cdqe
		lea rdx, 0[0+rax*4]
		lea rax, A[rip]
		add rax, rdx
		mov rsi, rax
		lea rdi, .LC0[rip]
		mov eax, 0
		call __isoc99_scanf@PLT
		add DWORD PTR -4[rbp], 1
	.L2:
		mov eax, DWORD PTR -12[rbp]
		cmp DWORD PTR -4[rbp], eax
		jl .L3
		mov DWORD PTR -4[rbp], 0
		jmp .L4
	.L6:
		mov eax, DWORD PTR -4[rbp]
		cdqe
		lea rdx, 0[0+rax*4]
		lea rax, A[rip]
		mov eax, DWORD PTR [rdx+rax]
		test eax, eax
		jle .L5
		mov eax, DWORD PTR -4[rbp]
		cdqe
		lea rdx, 0[0+rax*4]
		lea rax, A[rip]
		mov eax, DWORD PTR [rdx+rax]
		mov edx, DWORD PTR -8[rbp]
		movsx rdx, edx
		lea rcx, 0[0+rdx*4]
		lea rdx, B[rip]
		mov DWORD PTR [rcx+rdx], eax
		add DWORD PTR -8[rbp], 1
	.L5:
		add DWORD PTR -4[rbp], 1
	.L4:
		mov eax, DWORD PTR -12[rbp]
		cmp DWORD PTR -4[rbp], eax
		jl .L6
		mov DWORD PTR -4[rbp], 0
		jmp .L7
	.L8:
		mov eax, DWORD PTR -4[rbp]
		cdqe
		lea rdx, 0[0+rax*4]
		lea rax, B[rip]
		mov eax, DWORD PTR [rdx+rax]
		mov esi, eax
		lea rdi, .LC1[rip]
		mov eax, 0
		call printf@PLT
		add DWORD PTR -4[rbp], 1
	.L7:
		mov eax, DWORD PTR -4[rbp]
		cmp eax, DWORD PTR -8[rbp]
		jl .L8
		mov eax, 0
		leave
		ret
		.size main, .-main
		.ident "GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
		.section .note.GNU-stack,"",@progbits
		.section .note.gnu.property,"a"
		.align 8
		.long 1f - 0f
		.long 4f - 1f
		.long 5
	0:
		.string "GNU"
	1:
		.align 8
		.long 0xc0000002
		.long 3f - 2f
	2:
		.long 0x3
	3:
		.align 8
	4:
## 9) Дополнительная информация
Был проведен рефакторинг кода с помощью компиляции программы на C с флагами и ручным редактированием кода(удалением макросов), также путем тестирования было обнаружено, что использование регистров r12d, r13d, r14d увеличивает эффективность программы по сравнению с использованием позиций на стеке. Помимо этого был исправлен недочет. В неисправленной версии кода на ассемблере в .main можно найти следующие строчки:
		lea rax, -12[rbp]
		mov rsi, rax
В конечной версии программы это было заменено на:
		lea rsi, -12[rbp]
