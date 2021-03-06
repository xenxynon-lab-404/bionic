/*
 * Copyright (C) 2008 The Android Open Source Project
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

	.text
	.globl	memcpy_sse2                  # -- Begin function memcpy
	.p2align	4, 0x90
	.type	memcpy_sse2,@function



memcpy_sse2:                                 # @memcpy
	.cfi_startproc
# %bb.0:
	movq	%rdi, %rax
	cmpq	$128, %rdx
	ja	.LBB0_129
# %bb.1:
	leaq	-1(%rdx), %rdi
	cmpq	$127, %rdi
	ja	.LBB0_145
# %bb.2:
	leaq	.LJTI0_1(%rip), %r8
	leaq	(%rax,%rdx), %rcx
	addq	%rdx, %rsi
	movslq	(%r8,%rdi,4), %rdi
	addq	%r8, %rdi
	jmpq	*%rdi
.LBB0_129:
	movl	%eax, %edi
	negl	%edi
	andq	$15, %rdi
	je	.LBB0_130
# %bb.131:
	movups	(%rsi), %xmm0
	leaq	(%rax,%rdi), %rcx
	addq	%rdi, %rsi
	subq	%rdi, %rdx
	movups	%xmm0, (%rax)
	cmpq	$2097152, %rdx          # imm = 0x200000
	ja	.LBB0_137
.LBB0_133:
	cmpq	$128, %rdx
	jb	.LBB0_141
# %bb.134:
	movq	%rdx, %rdi
	.p2align	4, 0x90
.LBB0_135:                              # =>This Inner Loop Header: Depth=1
	movups	(%rsi), %xmm0
	movups	16(%rsi), %xmm1
	movups	32(%rsi), %xmm2
	movups	48(%rsi), %xmm3
	movups	64(%rsi), %xmm4
	movups	80(%rsi), %xmm5
	movups	96(%rsi), %xmm6
	movups	112(%rsi), %xmm7
	prefetchnta	256(%rsi)
	addq	$-128, %rdi
	subq	$-128, %rsi
	movaps	%xmm0, (%rcx)
	movaps	%xmm1, 16(%rcx)
	movaps	%xmm2, 32(%rcx)
	movaps	%xmm3, 48(%rcx)
	movaps	%xmm4, 64(%rcx)
	movaps	%xmm5, 80(%rcx)
	movaps	%xmm6, 96(%rcx)
	movaps	%xmm7, 112(%rcx)
	subq	$-128, %rcx
	cmpq	$127, %rdi
	ja	.LBB0_135
# %bb.136:
	andl	$127, %edx
	leaq	-1(%rdx), %rdi
	cmpq	$127, %rdi
	jbe	.LBB0_142
	jmp	.LBB0_145
.LBB0_130:
	movq	%rax, %rcx
	cmpq	$2097152, %rdx          # imm = 0x200000
	jbe	.LBB0_133
.LBB0_137:
	prefetchnta	(%rsi)
	movq	%rdx, %rdi
	testb	$15, %sil
	je	.LBB0_139
	.p2align	4, 0x90
.LBB0_138:                              # =>This Inner Loop Header: Depth=1
	movups	(%rsi), %xmm0
	movups	16(%rsi), %xmm1
	movups	32(%rsi), %xmm2
	movups	48(%rsi), %xmm3
	movups	64(%rsi), %xmm4
	movups	80(%rsi), %xmm5
	movups	96(%rsi), %xmm6
	movups	112(%rsi), %xmm7
	prefetchnta	256(%rsi)
	addq	$-128, %rdi
	subq	$-128, %rsi
	movntps	%xmm0, (%rcx)
	movntps	%xmm1, 16(%rcx)
	movntps	%xmm2, 32(%rcx)
	movntps	%xmm3, 48(%rcx)
	movntps	%xmm4, 64(%rcx)
	movntps	%xmm5, 80(%rcx)
	movntps	%xmm6, 96(%rcx)
	movntps	%xmm7, 112(%rcx)
	subq	$-128, %rcx
	cmpq	$127, %rdi
	ja	.LBB0_138
	jmp	.LBB0_140
	.p2align	4, 0x90
.LBB0_139:                              # =>This Inner Loop Header: Depth=1
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	64(%rsi), %xmm4
	movaps	80(%rsi), %xmm5
	movaps	96(%rsi), %xmm6
	movaps	112(%rsi), %xmm7
	prefetchnta	256(%rsi)
	addq	$-128, %rdi
	subq	$-128, %rsi
	movntps	%xmm0, (%rcx)
	movntps	%xmm1, 16(%rcx)
	movntps	%xmm2, 32(%rcx)
	movntps	%xmm3, 48(%rcx)
	movntps	%xmm4, 64(%rcx)
	movntps	%xmm5, 80(%rcx)
	movntps	%xmm6, 96(%rcx)
	movntps	%xmm7, 112(%rcx)
	subq	$-128, %rcx
	cmpq	$127, %rdi
	ja	.LBB0_139
.LBB0_140:
	andl	$127, %edx
	sfence
.LBB0_141:
	leaq	-1(%rdx), %rdi
	cmpq	$127, %rdi
	ja	.LBB0_145
.LBB0_142:
	leaq	.LJTI0_0(%rip), %r8
	addq	%rdx, %rcx
	addq	%rdx, %rsi
	movslq	(%r8,%rdi,4), %rdi
	addq	%r8, %rdi
	jmpq	*%rdi
.LBB0_143:
	movups	-64(%rsi), %xmm0
	movups	-48(%rsi), %xmm1
	movups	-32(%rsi), %xmm2
	movups	-16(%rsi), %xmm3
	movups	%xmm0, -64(%rcx)
	movups	%xmm1, -48(%rcx)
	movups	%xmm2, -32(%rcx)
	movups	%xmm3, -16(%rcx)
	retq
.LBB0_3:
	movups	-65(%rsi), %xmm0
	movups	-49(%rsi), %xmm1
	movups	-33(%rsi), %xmm2
	movups	-17(%rsi), %xmm3
	movups	%xmm0, -65(%rcx)
	movups	%xmm1, -49(%rcx)
	movups	%xmm2, -33(%rcx)
	movups	%xmm3, -17(%rcx)
	movb	-1(%rsi), %dl
	movb	%dl, -1(%rcx)
	retq
.LBB0_5:
	movups	-66(%rsi), %xmm0
	movups	-50(%rsi), %xmm1
	movups	-34(%rsi), %xmm2
	movups	-18(%rsi), %xmm3
	movups	%xmm0, -66(%rcx)
	movups	%xmm1, -50(%rcx)
	movups	%xmm2, -34(%rcx)
	movups	%xmm3, -18(%rcx)
	movzwl	-2(%rsi), %edx
	movw	%dx, -2(%rcx)
	retq
.LBB0_7:
	movups	-67(%rsi), %xmm0
	movups	-51(%rsi), %xmm1
	movups	-35(%rsi), %xmm2
	movups	-19(%rsi), %xmm3
	movups	%xmm0, -67(%rcx)
	movups	%xmm1, -51(%rcx)
	movups	%xmm2, -35(%rcx)
	movups	%xmm3, -19(%rcx)
	jmp	.LBB0_8
.LBB0_9:
	movups	-68(%rsi), %xmm0
	movups	-52(%rsi), %xmm1
	movups	-36(%rsi), %xmm2
	movups	-20(%rsi), %xmm3
	movups	%xmm0, -68(%rcx)
	movups	%xmm1, -52(%rcx)
	movups	%xmm2, -36(%rcx)
	movups	%xmm3, -20(%rcx)
	movl	-4(%rsi), %edx
	movl	%edx, -4(%rcx)
	retq
.LBB0_11:
	movups	-69(%rsi), %xmm0
	movups	-53(%rsi), %xmm1
	movups	-37(%rsi), %xmm2
	movups	-21(%rsi), %xmm3
	movups	%xmm0, -69(%rcx)
	movups	%xmm1, -53(%rcx)
	movups	%xmm2, -37(%rcx)
	movups	%xmm3, -21(%rcx)
	jmp	.LBB0_12
.LBB0_13:
	movups	-70(%rsi), %xmm0
	movups	-54(%rsi), %xmm1
	movups	-38(%rsi), %xmm2
	movups	-22(%rsi), %xmm3
	movups	%xmm0, -70(%rcx)
	movups	%xmm1, -54(%rcx)
	movups	%xmm2, -38(%rcx)
	movups	%xmm3, -22(%rcx)
	jmp	.LBB0_14
.LBB0_15:
	movups	-71(%rsi), %xmm0
	movups	-55(%rsi), %xmm1
	movups	-39(%rsi), %xmm2
	movups	-23(%rsi), %xmm3
	movups	%xmm0, -71(%rcx)
	movups	%xmm1, -55(%rcx)
	movups	%xmm2, -39(%rcx)
	movups	%xmm3, -23(%rcx)
	jmp	.LBB0_16
.LBB0_17:
	movups	-72(%rsi), %xmm0
	movups	-56(%rsi), %xmm1
	movups	-40(%rsi), %xmm2
	movups	-24(%rsi), %xmm3
	movups	%xmm0, -72(%rcx)
	movups	%xmm1, -56(%rcx)
	movups	%xmm2, -40(%rcx)
	movups	%xmm3, -24(%rcx)
	movq	-8(%rsi), %rdx
	movq	%rdx, -8(%rcx)
	retq
.LBB0_19:
	movups	-73(%rsi), %xmm0
	movups	-57(%rsi), %xmm1
	movups	-41(%rsi), %xmm2
	movups	-25(%rsi), %xmm3
	movups	%xmm0, -73(%rcx)
	movups	%xmm1, -57(%rcx)
	movups	%xmm2, -41(%rcx)
	movups	%xmm3, -25(%rcx)
	jmp	.LBB0_20
.LBB0_21:
	movups	-74(%rsi), %xmm0
	movups	-58(%rsi), %xmm1
	movups	-42(%rsi), %xmm2
	movups	-26(%rsi), %xmm3
	movups	%xmm0, -74(%rcx)
	movups	%xmm1, -58(%rcx)
	movups	%xmm2, -42(%rcx)
	movups	%xmm3, -26(%rcx)
	jmp	.LBB0_22
.LBB0_23:
	movups	-75(%rsi), %xmm0
	movups	-59(%rsi), %xmm1
	movups	-43(%rsi), %xmm2
	movups	-27(%rsi), %xmm3
	movups	%xmm0, -75(%rcx)
	movups	%xmm1, -59(%rcx)
	movups	%xmm2, -43(%rcx)
	movups	%xmm3, -27(%rcx)
	jmp	.LBB0_24
.LBB0_25:
	movups	-76(%rsi), %xmm0
	movups	-60(%rsi), %xmm1
	movups	-44(%rsi), %xmm2
	movups	-28(%rsi), %xmm3
	movups	%xmm0, -76(%rcx)
	movups	%xmm1, -60(%rcx)
	movups	%xmm2, -44(%rcx)
	movups	%xmm3, -28(%rcx)
	jmp	.LBB0_26
.LBB0_27:
	movups	-77(%rsi), %xmm0
	movups	-61(%rsi), %xmm1
	movups	-45(%rsi), %xmm2
	movups	-29(%rsi), %xmm3
	movups	%xmm0, -77(%rcx)
	movups	%xmm1, -61(%rcx)
	movups	%xmm2, -45(%rcx)
	movups	%xmm3, -29(%rcx)
	jmp	.LBB0_28
.LBB0_29:
	movups	-78(%rsi), %xmm0
	movups	-62(%rsi), %xmm1
	movups	-46(%rsi), %xmm2
	movups	-30(%rsi), %xmm3
	movups	%xmm0, -78(%rcx)
	movups	%xmm1, -62(%rcx)
	movups	%xmm2, -46(%rcx)
	movups	%xmm3, -30(%rcx)
	jmp	.LBB0_30
.LBB0_31:
	movups	-79(%rsi), %xmm0
	movups	-63(%rsi), %xmm1
	movups	-47(%rsi), %xmm2
	movups	-31(%rsi), %xmm3
	movups	%xmm0, -79(%rcx)
	movups	%xmm1, -63(%rcx)
	movups	%xmm2, -47(%rcx)
	movups	%xmm3, -31(%rcx)
	jmp	.LBB0_32
.LBB0_33:
	movups	-80(%rsi), %xmm0
	movups	-64(%rsi), %xmm1
	movups	-48(%rsi), %xmm2
	movups	-32(%rsi), %xmm3
	movups	%xmm0, -80(%rcx)
	movups	%xmm1, -64(%rcx)
	movups	%xmm2, -48(%rcx)
	movups	%xmm3, -32(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_35:
	movups	-81(%rsi), %xmm0
	movups	-65(%rsi), %xmm1
	movups	-49(%rsi), %xmm2
	movups	-33(%rsi), %xmm3
	movups	%xmm0, -81(%rcx)
	movups	%xmm1, -65(%rcx)
	movups	%xmm2, -49(%rcx)
	movups	%xmm3, -33(%rcx)
	jmp	.LBB0_36
.LBB0_37:
	movups	-82(%rsi), %xmm0
	movups	-66(%rsi), %xmm1
	movups	-50(%rsi), %xmm2
	movups	-34(%rsi), %xmm3
	movups	%xmm0, -82(%rcx)
	movups	%xmm1, -66(%rcx)
	movups	%xmm2, -50(%rcx)
	movups	%xmm3, -34(%rcx)
	jmp	.LBB0_38
.LBB0_39:
	movups	-83(%rsi), %xmm0
	movups	-67(%rsi), %xmm1
	movups	-51(%rsi), %xmm2
	movups	-35(%rsi), %xmm3
	movups	%xmm0, -83(%rcx)
	movups	%xmm1, -67(%rcx)
	movups	%xmm2, -51(%rcx)
	movups	%xmm3, -35(%rcx)
	jmp	.LBB0_40
.LBB0_41:
	movups	-84(%rsi), %xmm0
	movups	-68(%rsi), %xmm1
	movups	-52(%rsi), %xmm2
	movups	-36(%rsi), %xmm3
	movups	%xmm0, -84(%rcx)
	movups	%xmm1, -68(%rcx)
	movups	%xmm2, -52(%rcx)
	movups	%xmm3, -36(%rcx)
	jmp	.LBB0_42
.LBB0_43:
	movups	-85(%rsi), %xmm0
	movups	-69(%rsi), %xmm1
	movups	-53(%rsi), %xmm2
	movups	-37(%rsi), %xmm3
	movups	%xmm0, -85(%rcx)
	movups	%xmm1, -69(%rcx)
	movups	%xmm2, -53(%rcx)
	movups	%xmm3, -37(%rcx)
	jmp	.LBB0_44
.LBB0_45:
	movups	-86(%rsi), %xmm0
	movups	-70(%rsi), %xmm1
	movups	-54(%rsi), %xmm2
	movups	-38(%rsi), %xmm3
	movups	%xmm0, -86(%rcx)
	movups	%xmm1, -70(%rcx)
	movups	%xmm2, -54(%rcx)
	movups	%xmm3, -38(%rcx)
	jmp	.LBB0_46
.LBB0_47:
	movups	-87(%rsi), %xmm0
	movups	-71(%rsi), %xmm1
	movups	-55(%rsi), %xmm2
	movups	-39(%rsi), %xmm3
	movups	%xmm0, -87(%rcx)
	movups	%xmm1, -71(%rcx)
	movups	%xmm2, -55(%rcx)
	movups	%xmm3, -39(%rcx)
	jmp	.LBB0_48
.LBB0_49:
	movups	-88(%rsi), %xmm0
	movups	-72(%rsi), %xmm1
	movups	-56(%rsi), %xmm2
	movups	-40(%rsi), %xmm3
	movups	%xmm0, -88(%rcx)
	movups	%xmm1, -72(%rcx)
	movups	%xmm2, -56(%rcx)
	movups	%xmm3, -40(%rcx)
	jmp	.LBB0_50
.LBB0_51:
	movups	-89(%rsi), %xmm0
	movups	-73(%rsi), %xmm1
	movups	-57(%rsi), %xmm2
	movups	-41(%rsi), %xmm3
	movups	%xmm0, -89(%rcx)
	movups	%xmm1, -73(%rcx)
	movups	%xmm2, -57(%rcx)
	movups	%xmm3, -41(%rcx)
	jmp	.LBB0_52
.LBB0_53:
	movups	-90(%rsi), %xmm0
	movups	-74(%rsi), %xmm1
	movups	-58(%rsi), %xmm2
	movups	-42(%rsi), %xmm3
	movups	%xmm0, -90(%rcx)
	movups	%xmm1, -74(%rcx)
	movups	%xmm2, -58(%rcx)
	movups	%xmm3, -42(%rcx)
	jmp	.LBB0_54
.LBB0_55:
	movups	-91(%rsi), %xmm0
	movups	-75(%rsi), %xmm1
	movups	-59(%rsi), %xmm2
	movups	-43(%rsi), %xmm3
	movups	%xmm0, -91(%rcx)
	movups	%xmm1, -75(%rcx)
	movups	%xmm2, -59(%rcx)
	movups	%xmm3, -43(%rcx)
	jmp	.LBB0_56
.LBB0_57:
	movups	-92(%rsi), %xmm0
	movups	-76(%rsi), %xmm1
	movups	-60(%rsi), %xmm2
	movups	-44(%rsi), %xmm3
	movups	%xmm0, -92(%rcx)
	movups	%xmm1, -76(%rcx)
	movups	%xmm2, -60(%rcx)
	movups	%xmm3, -44(%rcx)
	jmp	.LBB0_58
.LBB0_59:
	movups	-93(%rsi), %xmm0
	movups	-77(%rsi), %xmm1
	movups	-61(%rsi), %xmm2
	movups	-45(%rsi), %xmm3
	movups	%xmm0, -93(%rcx)
	movups	%xmm1, -77(%rcx)
	movups	%xmm2, -61(%rcx)
	movups	%xmm3, -45(%rcx)
	jmp	.LBB0_60
.LBB0_61:
	movups	-94(%rsi), %xmm0
	movups	-78(%rsi), %xmm1
	movups	-62(%rsi), %xmm2
	movups	-46(%rsi), %xmm3
	movups	%xmm0, -94(%rcx)
	movups	%xmm1, -78(%rcx)
	movups	%xmm2, -62(%rcx)
	movups	%xmm3, -46(%rcx)
	jmp	.LBB0_62
.LBB0_63:
	movups	-95(%rsi), %xmm0
	movups	-79(%rsi), %xmm1
	movups	-63(%rsi), %xmm2
	movups	-47(%rsi), %xmm3
	movups	%xmm0, -95(%rcx)
	movups	%xmm1, -79(%rcx)
	movups	%xmm2, -63(%rcx)
	movups	%xmm3, -47(%rcx)
	jmp	.LBB0_64
.LBB0_65:
	movups	-96(%rsi), %xmm0
	movups	-80(%rsi), %xmm1
	movups	-64(%rsi), %xmm2
	movups	-48(%rsi), %xmm3
	movups	%xmm0, -96(%rcx)
	movups	%xmm1, -80(%rcx)
	movups	%xmm2, -64(%rcx)
	movups	%xmm3, -48(%rcx)
.LBB0_66:
	movups	-32(%rsi), %xmm0
	movups	-16(%rsi), %xmm1
	movups	%xmm0, -32(%rcx)
	movups	%xmm1, -16(%rcx)
	retq
.LBB0_67:
	movups	-97(%rsi), %xmm0
	movups	-81(%rsi), %xmm1
	movups	-65(%rsi), %xmm2
	movups	-49(%rsi), %xmm3
	movups	%xmm0, -97(%rcx)
	movups	%xmm1, -81(%rcx)
	movups	%xmm2, -65(%rcx)
	movups	%xmm3, -49(%rcx)
.LBB0_68:
	movups	-33(%rsi), %xmm0
	movups	-17(%rsi), %xmm1
	movups	%xmm0, -33(%rcx)
	movups	%xmm1, -17(%rcx)
	movb	-1(%rsi), %dl
	movb	%dl, -1(%rcx)
	retq
.LBB0_69:
	movups	-98(%rsi), %xmm0
	movups	-82(%rsi), %xmm1
	movups	-66(%rsi), %xmm2
	movups	-50(%rsi), %xmm3
	movups	%xmm0, -98(%rcx)
	movups	%xmm1, -82(%rcx)
	movups	%xmm2, -66(%rcx)
	movups	%xmm3, -50(%rcx)
.LBB0_70:
	movups	-34(%rsi), %xmm0
	movups	-18(%rsi), %xmm1
	movups	%xmm0, -34(%rcx)
	movups	%xmm1, -18(%rcx)
	movzwl	-2(%rsi), %edx
	movw	%dx, -2(%rcx)
	retq
.LBB0_71:
	movups	-99(%rsi), %xmm0
	movups	-83(%rsi), %xmm1
	movups	-67(%rsi), %xmm2
	movups	-51(%rsi), %xmm3
	movups	%xmm0, -99(%rcx)
	movups	%xmm1, -83(%rcx)
	movups	%xmm2, -67(%rcx)
	movups	%xmm3, -51(%rcx)
.LBB0_72:
	movups	-35(%rsi), %xmm0
	movups	-19(%rsi), %xmm1
	movups	%xmm0, -35(%rcx)
	movups	%xmm1, -19(%rcx)
	jmp	.LBB0_8
.LBB0_73:
	movups	-100(%rsi), %xmm0
	movups	-84(%rsi), %xmm1
	movups	-68(%rsi), %xmm2
	movups	-52(%rsi), %xmm3
	movups	%xmm0, -100(%rcx)
	movups	%xmm1, -84(%rcx)
	movups	%xmm2, -68(%rcx)
	movups	%xmm3, -52(%rcx)
.LBB0_74:
	movups	-36(%rsi), %xmm0
	movups	-20(%rsi), %xmm1
	movups	%xmm0, -36(%rcx)
	movups	%xmm1, -20(%rcx)
	movl	-4(%rsi), %edx
	movl	%edx, -4(%rcx)
	retq
.LBB0_75:
	movups	-101(%rsi), %xmm0
	movups	-85(%rsi), %xmm1
	movups	-69(%rsi), %xmm2
	movups	-53(%rsi), %xmm3
	movups	%xmm0, -101(%rcx)
	movups	%xmm1, -85(%rcx)
	movups	%xmm2, -69(%rcx)
	movups	%xmm3, -53(%rcx)
.LBB0_76:
	movups	-37(%rsi), %xmm0
	movups	-21(%rsi), %xmm1
	movups	%xmm0, -37(%rcx)
	movups	%xmm1, -21(%rcx)
	jmp	.LBB0_12
.LBB0_77:
	movups	-102(%rsi), %xmm0
	movups	-86(%rsi), %xmm1
	movups	-70(%rsi), %xmm2
	movups	-54(%rsi), %xmm3
	movups	%xmm0, -102(%rcx)
	movups	%xmm1, -86(%rcx)
	movups	%xmm2, -70(%rcx)
	movups	%xmm3, -54(%rcx)
.LBB0_78:
	movups	-38(%rsi), %xmm0
	movups	-22(%rsi), %xmm1
	movups	%xmm0, -38(%rcx)
	movups	%xmm1, -22(%rcx)
	jmp	.LBB0_14
.LBB0_79:
	movups	-103(%rsi), %xmm0
	movups	-87(%rsi), %xmm1
	movups	-71(%rsi), %xmm2
	movups	-55(%rsi), %xmm3
	movups	%xmm0, -103(%rcx)
	movups	%xmm1, -87(%rcx)
	movups	%xmm2, -71(%rcx)
	movups	%xmm3, -55(%rcx)
.LBB0_80:
	movups	-39(%rsi), %xmm0
	movups	-23(%rsi), %xmm1
	movups	%xmm0, -39(%rcx)
	movups	%xmm1, -23(%rcx)
	jmp	.LBB0_16
.LBB0_81:
	movups	-104(%rsi), %xmm0
	movups	-88(%rsi), %xmm1
	movups	-72(%rsi), %xmm2
	movups	-56(%rsi), %xmm3
	movups	%xmm0, -104(%rcx)
	movups	%xmm1, -88(%rcx)
	movups	%xmm2, -72(%rcx)
	movups	%xmm3, -56(%rcx)
.LBB0_82:
	movups	-40(%rsi), %xmm0
	movups	-24(%rsi), %xmm1
	movups	%xmm0, -40(%rcx)
	movups	%xmm1, -24(%rcx)
	movq	-8(%rsi), %rdx
	movq	%rdx, -8(%rcx)
	retq
.LBB0_83:
	movups	-105(%rsi), %xmm0
	movups	-89(%rsi), %xmm1
	movups	-73(%rsi), %xmm2
	movups	-57(%rsi), %xmm3
	movups	%xmm0, -105(%rcx)
	movups	%xmm1, -89(%rcx)
	movups	%xmm2, -73(%rcx)
	movups	%xmm3, -57(%rcx)
.LBB0_84:
	movups	-41(%rsi), %xmm0
	movups	-25(%rsi), %xmm1
	movups	%xmm0, -41(%rcx)
	movups	%xmm1, -25(%rcx)
.LBB0_20:
	movq	-9(%rsi), %rdx
	movq	%rdx, -9(%rcx)
.LBB0_4:
	movb	-1(%rsi), %dl
	movb	%dl, -1(%rcx)
	retq
.LBB0_85:
	movups	-106(%rsi), %xmm0
	movups	-90(%rsi), %xmm1
	movups	-74(%rsi), %xmm2
	movups	-58(%rsi), %xmm3
	movups	%xmm0, -106(%rcx)
	movups	%xmm1, -90(%rcx)
	movups	%xmm2, -74(%rcx)
	movups	%xmm3, -58(%rcx)
.LBB0_86:
	movups	-42(%rsi), %xmm0
	movups	-26(%rsi), %xmm1
	movups	%xmm0, -42(%rcx)
	movups	%xmm1, -26(%rcx)
.LBB0_22:
	movq	-10(%rsi), %rdx
	movq	%rdx, -10(%rcx)
.LBB0_6:
	movzwl	-2(%rsi), %edx
	movw	%dx, -2(%rcx)
	retq
.LBB0_87:
	movups	-107(%rsi), %xmm0
	movups	-91(%rsi), %xmm1
	movups	-75(%rsi), %xmm2
	movups	-59(%rsi), %xmm3
	movups	%xmm0, -107(%rcx)
	movups	%xmm1, -91(%rcx)
	movups	%xmm2, -75(%rcx)
	movups	%xmm3, -59(%rcx)
.LBB0_88:
	movups	-43(%rsi), %xmm0
	movups	-27(%rsi), %xmm1
	movups	%xmm0, -43(%rcx)
	movups	%xmm1, -27(%rcx)
.LBB0_24:
	movq	-11(%rsi), %rdx
	movq	%rdx, -11(%rcx)
.LBB0_10:
	movl	-4(%rsi), %edx
	movl	%edx, -4(%rcx)
	retq
.LBB0_89:
	movups	-108(%rsi), %xmm0
	movups	-92(%rsi), %xmm1
	movups	-76(%rsi), %xmm2
	movups	-60(%rsi), %xmm3
	movups	%xmm0, -108(%rcx)
	movups	%xmm1, -92(%rcx)
	movups	%xmm2, -76(%rcx)
	movups	%xmm3, -60(%rcx)
.LBB0_90:
	movups	-44(%rsi), %xmm0
	movups	-28(%rsi), %xmm1
	movups	%xmm0, -44(%rcx)
	movups	%xmm1, -28(%rcx)
.LBB0_26:
	movq	-12(%rsi), %rdx
	movq	%rdx, -12(%rcx)
	movl	-4(%rsi), %edx
	movl	%edx, -4(%rcx)
	retq
.LBB0_91:
	movups	-109(%rsi), %xmm0
	movups	-93(%rsi), %xmm1
	movups	-77(%rsi), %xmm2
	movups	-61(%rsi), %xmm3
	movups	%xmm0, -109(%rcx)
	movups	%xmm1, -93(%rcx)
	movups	%xmm2, -77(%rcx)
	movups	%xmm3, -61(%rcx)
.LBB0_92:
	movups	-45(%rsi), %xmm0
	movups	-29(%rsi), %xmm1
	movups	%xmm0, -45(%rcx)
	movups	%xmm1, -29(%rcx)
.LBB0_28:
	movq	-13(%rsi), %rdx
	movq	%rdx, -13(%rcx)
	jmp	.LBB0_12
.LBB0_93:
	movups	-110(%rsi), %xmm0
	movups	-94(%rsi), %xmm1
	movups	-78(%rsi), %xmm2
	movups	-62(%rsi), %xmm3
	movups	%xmm0, -110(%rcx)
	movups	%xmm1, -94(%rcx)
	movups	%xmm2, -78(%rcx)
	movups	%xmm3, -62(%rcx)
.LBB0_94:
	movups	-46(%rsi), %xmm0
	movups	-30(%rsi), %xmm1
	movups	%xmm0, -46(%rcx)
	movups	%xmm1, -30(%rcx)
.LBB0_30:
	movq	-14(%rsi), %rdx
	movq	%rdx, -14(%rcx)
.LBB0_18:
	movq	-8(%rsi), %rdx
	movq	%rdx, -8(%rcx)
	retq
.LBB0_95:
	movups	-111(%rsi), %xmm0
	movups	-95(%rsi), %xmm1
	movups	-79(%rsi), %xmm2
	movups	-63(%rsi), %xmm3
	movups	%xmm0, -111(%rcx)
	movups	%xmm1, -95(%rcx)
	movups	%xmm2, -79(%rcx)
	movups	%xmm3, -63(%rcx)
.LBB0_96:
	movups	-47(%rsi), %xmm0
	movups	-31(%rsi), %xmm1
	movups	%xmm0, -47(%rcx)
	movups	%xmm1, -31(%rcx)
.LBB0_32:
	movq	-15(%rsi), %rdx
	movq	%rdx, -15(%rcx)
	movq	-8(%rsi), %rdx
	movq	%rdx, -8(%rcx)
	retq
.LBB0_97:
	movups	-112(%rsi), %xmm0
	movups	-96(%rsi), %xmm1
	movups	-80(%rsi), %xmm2
	movups	-64(%rsi), %xmm3
	movups	%xmm0, -112(%rcx)
	movups	%xmm1, -96(%rcx)
	movups	%xmm2, -80(%rcx)
	movups	%xmm3, -64(%rcx)
.LBB0_98:
	movups	-48(%rsi), %xmm0
	movups	-32(%rsi), %xmm1
	movups	%xmm0, -48(%rcx)
	movups	%xmm1, -32(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_99:
	movups	-113(%rsi), %xmm0
	movups	-97(%rsi), %xmm1
	movups	-81(%rsi), %xmm2
	movups	-65(%rsi), %xmm3
	movups	%xmm0, -113(%rcx)
	movups	%xmm1, -97(%rcx)
	movups	%xmm2, -81(%rcx)
	movups	%xmm3, -65(%rcx)
.LBB0_100:
	movups	-49(%rsi), %xmm0
	movups	-33(%rsi), %xmm1
	movups	%xmm0, -49(%rcx)
	movups	%xmm1, -33(%rcx)
.LBB0_36:
	movups	-17(%rsi), %xmm0
	movups	%xmm0, -17(%rcx)
	movb	-1(%rsi), %dl
	movb	%dl, -1(%rcx)
	retq
.LBB0_101:
	movups	-114(%rsi), %xmm0
	movups	-98(%rsi), %xmm1
	movups	-82(%rsi), %xmm2
	movups	-66(%rsi), %xmm3
	movups	%xmm0, -114(%rcx)
	movups	%xmm1, -98(%rcx)
	movups	%xmm2, -82(%rcx)
	movups	%xmm3, -66(%rcx)
.LBB0_102:
	movups	-50(%rsi), %xmm0
	movups	-34(%rsi), %xmm1
	movups	%xmm0, -50(%rcx)
	movups	%xmm1, -34(%rcx)
.LBB0_38:
	movups	-18(%rsi), %xmm0
	movups	%xmm0, -18(%rcx)
	movzwl	-2(%rsi), %edx
	movw	%dx, -2(%rcx)
	retq
.LBB0_103:
	movups	-115(%rsi), %xmm0
	movups	-99(%rsi), %xmm1
	movups	-83(%rsi), %xmm2
	movups	-67(%rsi), %xmm3
	movups	%xmm0, -115(%rcx)
	movups	%xmm1, -99(%rcx)
	movups	%xmm2, -83(%rcx)
	movups	%xmm3, -67(%rcx)
.LBB0_104:
	movups	-51(%rsi), %xmm0
	movups	-35(%rsi), %xmm1
	movups	%xmm0, -51(%rcx)
	movups	%xmm1, -35(%rcx)
.LBB0_40:
	movups	-19(%rsi), %xmm0
	movups	%xmm0, -19(%rcx)
.LBB0_8:
	movzwl	-3(%rsi), %edx
	movw	%dx, -3(%rcx)
	movb	-1(%rsi), %dl
	movb	%dl, -1(%rcx)
	retq
.LBB0_105:
	movups	-116(%rsi), %xmm0
	movups	-100(%rsi), %xmm1
	movups	-84(%rsi), %xmm2
	movups	-68(%rsi), %xmm3
	movups	%xmm0, -116(%rcx)
	movups	%xmm1, -100(%rcx)
	movups	%xmm2, -84(%rcx)
	movups	%xmm3, -68(%rcx)
.LBB0_106:
	movups	-52(%rsi), %xmm0
	movups	-36(%rsi), %xmm1
	movups	%xmm0, -52(%rcx)
	movups	%xmm1, -36(%rcx)
.LBB0_42:
	movups	-20(%rsi), %xmm0
	movups	%xmm0, -20(%rcx)
	movl	-4(%rsi), %edx
	movl	%edx, -4(%rcx)
	retq
.LBB0_107:
	movups	-117(%rsi), %xmm0
	movups	-101(%rsi), %xmm1
	movups	-85(%rsi), %xmm2
	movups	-69(%rsi), %xmm3
	movups	%xmm0, -117(%rcx)
	movups	%xmm1, -101(%rcx)
	movups	%xmm2, -85(%rcx)
	movups	%xmm3, -69(%rcx)
.LBB0_108:
	movups	-53(%rsi), %xmm0
	movups	-37(%rsi), %xmm1
	movups	%xmm0, -53(%rcx)
	movups	%xmm1, -37(%rcx)
.LBB0_44:
	movups	-21(%rsi), %xmm0
	movups	%xmm0, -21(%rcx)
.LBB0_12:
	movl	-5(%rsi), %edx
	movl	%edx, -5(%rcx)
	movb	-1(%rsi), %dl
	movb	%dl, -1(%rcx)
	retq
.LBB0_109:
	movups	-118(%rsi), %xmm0
	movups	-102(%rsi), %xmm1
	movups	-86(%rsi), %xmm2
	movups	-70(%rsi), %xmm3
	movups	%xmm0, -118(%rcx)
	movups	%xmm1, -102(%rcx)
	movups	%xmm2, -86(%rcx)
	movups	%xmm3, -70(%rcx)
.LBB0_110:
	movups	-54(%rsi), %xmm0
	movups	-38(%rsi), %xmm1
	movups	%xmm0, -54(%rcx)
	movups	%xmm1, -38(%rcx)
.LBB0_46:
	movups	-22(%rsi), %xmm0
	movups	%xmm0, -22(%rcx)
.LBB0_14:
	movl	-6(%rsi), %edx
	movl	%edx, -6(%rcx)
	movzwl	-2(%rsi), %edx
	movw	%dx, -2(%rcx)
	retq
.LBB0_111:
	movups	-119(%rsi), %xmm0
	movups	-103(%rsi), %xmm1
	movups	-87(%rsi), %xmm2
	movups	-71(%rsi), %xmm3
	movups	%xmm0, -119(%rcx)
	movups	%xmm1, -103(%rcx)
	movups	%xmm2, -87(%rcx)
	movups	%xmm3, -71(%rcx)
.LBB0_112:
	movups	-55(%rsi), %xmm0
	movups	-39(%rsi), %xmm1
	movups	%xmm0, -55(%rcx)
	movups	%xmm1, -39(%rcx)
.LBB0_48:
	movups	-23(%rsi), %xmm0
	movups	%xmm0, -23(%rcx)
.LBB0_16:
	movl	-7(%rsi), %edx
	movl	%edx, -7(%rcx)
	movl	-4(%rsi), %edx
	movl	%edx, -4(%rcx)
	retq
.LBB0_113:
	movups	-120(%rsi), %xmm0
	movups	-104(%rsi), %xmm1
	movups	-88(%rsi), %xmm2
	movups	-72(%rsi), %xmm3
	movups	%xmm0, -120(%rcx)
	movups	%xmm1, -104(%rcx)
	movups	%xmm2, -88(%rcx)
	movups	%xmm3, -72(%rcx)
.LBB0_114:
	movups	-56(%rsi), %xmm0
	movups	-40(%rsi), %xmm1
	movups	%xmm0, -56(%rcx)
	movups	%xmm1, -40(%rcx)
.LBB0_50:
	movups	-24(%rsi), %xmm0
	movups	%xmm0, -24(%rcx)
.LBB0_34:
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_115:
	movups	-121(%rsi), %xmm0
	movups	-105(%rsi), %xmm1
	movups	-89(%rsi), %xmm2
	movups	-73(%rsi), %xmm3
	movups	%xmm0, -121(%rcx)
	movups	%xmm1, -105(%rcx)
	movups	%xmm2, -89(%rcx)
	movups	%xmm3, -73(%rcx)
.LBB0_116:
	movups	-57(%rsi), %xmm0
	movups	-41(%rsi), %xmm1
	movups	%xmm0, -57(%rcx)
	movups	%xmm1, -41(%rcx)
.LBB0_52:
	movups	-25(%rsi), %xmm0
	movups	%xmm0, -25(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_117:
	movups	-122(%rsi), %xmm0
	movups	-106(%rsi), %xmm1
	movups	-90(%rsi), %xmm2
	movups	-74(%rsi), %xmm3
	movups	%xmm0, -122(%rcx)
	movups	%xmm1, -106(%rcx)
	movups	%xmm2, -90(%rcx)
	movups	%xmm3, -74(%rcx)
.LBB0_118:
	movups	-58(%rsi), %xmm0
	movups	-42(%rsi), %xmm1
	movups	%xmm0, -58(%rcx)
	movups	%xmm1, -42(%rcx)
.LBB0_54:
	movups	-26(%rsi), %xmm0
	movups	%xmm0, -26(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_119:
	movups	-123(%rsi), %xmm0
	movups	-107(%rsi), %xmm1
	movups	-91(%rsi), %xmm2
	movups	-75(%rsi), %xmm3
	movups	%xmm0, -123(%rcx)
	movups	%xmm1, -107(%rcx)
	movups	%xmm2, -91(%rcx)
	movups	%xmm3, -75(%rcx)
.LBB0_120:
	movups	-59(%rsi), %xmm0
	movups	-43(%rsi), %xmm1
	movups	%xmm0, -59(%rcx)
	movups	%xmm1, -43(%rcx)
.LBB0_56:
	movups	-27(%rsi), %xmm0
	movups	%xmm0, -27(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_121:
	movups	-124(%rsi), %xmm0
	movups	-108(%rsi), %xmm1
	movups	-92(%rsi), %xmm2
	movups	-76(%rsi), %xmm3
	movups	%xmm0, -124(%rcx)
	movups	%xmm1, -108(%rcx)
	movups	%xmm2, -92(%rcx)
	movups	%xmm3, -76(%rcx)
.LBB0_122:
	movups	-60(%rsi), %xmm0
	movups	-44(%rsi), %xmm1
	movups	%xmm0, -60(%rcx)
	movups	%xmm1, -44(%rcx)
.LBB0_58:
	movups	-28(%rsi), %xmm0
	movups	%xmm0, -28(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_123:
	movups	-125(%rsi), %xmm0
	movups	-109(%rsi), %xmm1
	movups	-93(%rsi), %xmm2
	movups	-77(%rsi), %xmm3
	movups	%xmm0, -125(%rcx)
	movups	%xmm1, -109(%rcx)
	movups	%xmm2, -93(%rcx)
	movups	%xmm3, -77(%rcx)
.LBB0_124:
	movups	-61(%rsi), %xmm0
	movups	-45(%rsi), %xmm1
	movups	%xmm0, -61(%rcx)
	movups	%xmm1, -45(%rcx)
.LBB0_60:
	movups	-29(%rsi), %xmm0
	movups	%xmm0, -29(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_125:
	movups	-126(%rsi), %xmm0
	movups	-110(%rsi), %xmm1
	movups	-94(%rsi), %xmm2
	movups	-78(%rsi), %xmm3
	movups	%xmm0, -126(%rcx)
	movups	%xmm1, -110(%rcx)
	movups	%xmm2, -94(%rcx)
	movups	%xmm3, -78(%rcx)
.LBB0_126:
	movups	-62(%rsi), %xmm0
	movups	-46(%rsi), %xmm1
	movups	%xmm0, -62(%rcx)
	movups	%xmm1, -46(%rcx)
.LBB0_62:
	movups	-30(%rsi), %xmm0
	movups	%xmm0, -30(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_127:
	movups	-127(%rsi), %xmm0
	movups	-111(%rsi), %xmm1
	movups	-95(%rsi), %xmm2
	movups	-79(%rsi), %xmm3
	movups	%xmm0, -127(%rcx)
	movups	%xmm1, -111(%rcx)
	movups	%xmm2, -95(%rcx)
	movups	%xmm3, -79(%rcx)
.LBB0_128:
	movups	-63(%rsi), %xmm0
	movups	-47(%rsi), %xmm1
	movups	%xmm0, -63(%rcx)
	movups	%xmm1, -47(%rcx)
.LBB0_64:
	movups	-31(%rsi), %xmm0
	movups	%xmm0, -31(%rcx)
	movups	-16(%rsi), %xmm0
	movups	%xmm0, -16(%rcx)
	retq
.LBB0_144:
	movups	-128(%rsi), %xmm0
	movups	-112(%rsi), %xmm1
	movups	-96(%rsi), %xmm2
	movups	-80(%rsi), %xmm3
	movups	-64(%rsi), %xmm4
	movups	-48(%rsi), %xmm5
	movups	-32(%rsi), %xmm6
	movups	-16(%rsi), %xmm7
	movups	%xmm0, -128(%rcx)
	movups	%xmm1, -112(%rcx)
	movups	%xmm2, -96(%rcx)
	movups	%xmm3, -80(%rcx)
	movups	%xmm4, -64(%rcx)
	movups	%xmm5, -48(%rcx)
	movups	%xmm6, -32(%rcx)
	movups	%xmm7, -16(%rcx)
.LBB0_145:
	retq
.Lfunc_end0:
	.size	memcpy, .Lfunc_end0-memcpy
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2
.LJTI0_0:
	.long	.LBB0_4-.LJTI0_0
	.long	.LBB0_6-.LJTI0_0
	.long	.LBB0_8-.LJTI0_0
	.long	.LBB0_10-.LJTI0_0
	.long	.LBB0_12-.LJTI0_0
	.long	.LBB0_14-.LJTI0_0
	.long	.LBB0_16-.LJTI0_0
	.long	.LBB0_18-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_22-.LJTI0_0
	.long	.LBB0_24-.LJTI0_0
	.long	.LBB0_26-.LJTI0_0
	.long	.LBB0_28-.LJTI0_0
	.long	.LBB0_30-.LJTI0_0
	.long	.LBB0_32-.LJTI0_0
	.long	.LBB0_34-.LJTI0_0
	.long	.LBB0_36-.LJTI0_0
	.long	.LBB0_38-.LJTI0_0
	.long	.LBB0_40-.LJTI0_0
	.long	.LBB0_42-.LJTI0_0
	.long	.LBB0_44-.LJTI0_0
	.long	.LBB0_46-.LJTI0_0
	.long	.LBB0_48-.LJTI0_0
	.long	.LBB0_50-.LJTI0_0
	.long	.LBB0_52-.LJTI0_0
	.long	.LBB0_54-.LJTI0_0
	.long	.LBB0_56-.LJTI0_0
	.long	.LBB0_58-.LJTI0_0
	.long	.LBB0_60-.LJTI0_0
	.long	.LBB0_62-.LJTI0_0
	.long	.LBB0_64-.LJTI0_0
	.long	.LBB0_66-.LJTI0_0
	.long	.LBB0_68-.LJTI0_0
	.long	.LBB0_70-.LJTI0_0
	.long	.LBB0_72-.LJTI0_0
	.long	.LBB0_74-.LJTI0_0
	.long	.LBB0_76-.LJTI0_0
	.long	.LBB0_78-.LJTI0_0
	.long	.LBB0_80-.LJTI0_0
	.long	.LBB0_82-.LJTI0_0
	.long	.LBB0_84-.LJTI0_0
	.long	.LBB0_86-.LJTI0_0
	.long	.LBB0_88-.LJTI0_0
	.long	.LBB0_90-.LJTI0_0
	.long	.LBB0_92-.LJTI0_0
	.long	.LBB0_94-.LJTI0_0
	.long	.LBB0_96-.LJTI0_0
	.long	.LBB0_98-.LJTI0_0
	.long	.LBB0_100-.LJTI0_0
	.long	.LBB0_102-.LJTI0_0
	.long	.LBB0_104-.LJTI0_0
	.long	.LBB0_106-.LJTI0_0
	.long	.LBB0_108-.LJTI0_0
	.long	.LBB0_110-.LJTI0_0
	.long	.LBB0_112-.LJTI0_0
	.long	.LBB0_114-.LJTI0_0
	.long	.LBB0_116-.LJTI0_0
	.long	.LBB0_118-.LJTI0_0
	.long	.LBB0_120-.LJTI0_0
	.long	.LBB0_122-.LJTI0_0
	.long	.LBB0_124-.LJTI0_0
	.long	.LBB0_126-.LJTI0_0
	.long	.LBB0_128-.LJTI0_0
	.long	.LBB0_143-.LJTI0_0
	.long	.LBB0_3-.LJTI0_0
	.long	.LBB0_5-.LJTI0_0
	.long	.LBB0_7-.LJTI0_0
	.long	.LBB0_9-.LJTI0_0
	.long	.LBB0_11-.LJTI0_0
	.long	.LBB0_13-.LJTI0_0
	.long	.LBB0_15-.LJTI0_0
	.long	.LBB0_17-.LJTI0_0
	.long	.LBB0_19-.LJTI0_0
	.long	.LBB0_21-.LJTI0_0
	.long	.LBB0_23-.LJTI0_0
	.long	.LBB0_25-.LJTI0_0
	.long	.LBB0_27-.LJTI0_0
	.long	.LBB0_29-.LJTI0_0
	.long	.LBB0_31-.LJTI0_0
	.long	.LBB0_33-.LJTI0_0
	.long	.LBB0_35-.LJTI0_0
	.long	.LBB0_37-.LJTI0_0
	.long	.LBB0_39-.LJTI0_0
	.long	.LBB0_41-.LJTI0_0
	.long	.LBB0_43-.LJTI0_0
	.long	.LBB0_45-.LJTI0_0
	.long	.LBB0_47-.LJTI0_0
	.long	.LBB0_49-.LJTI0_0
	.long	.LBB0_51-.LJTI0_0
	.long	.LBB0_53-.LJTI0_0
	.long	.LBB0_55-.LJTI0_0
	.long	.LBB0_57-.LJTI0_0
	.long	.LBB0_59-.LJTI0_0
	.long	.LBB0_61-.LJTI0_0
	.long	.LBB0_63-.LJTI0_0
	.long	.LBB0_65-.LJTI0_0
	.long	.LBB0_67-.LJTI0_0
	.long	.LBB0_69-.LJTI0_0
	.long	.LBB0_71-.LJTI0_0
	.long	.LBB0_73-.LJTI0_0
	.long	.LBB0_75-.LJTI0_0
	.long	.LBB0_77-.LJTI0_0
	.long	.LBB0_79-.LJTI0_0
	.long	.LBB0_81-.LJTI0_0
	.long	.LBB0_83-.LJTI0_0
	.long	.LBB0_85-.LJTI0_0
	.long	.LBB0_87-.LJTI0_0
	.long	.LBB0_89-.LJTI0_0
	.long	.LBB0_91-.LJTI0_0
	.long	.LBB0_93-.LJTI0_0
	.long	.LBB0_95-.LJTI0_0
	.long	.LBB0_97-.LJTI0_0
	.long	.LBB0_99-.LJTI0_0
	.long	.LBB0_101-.LJTI0_0
	.long	.LBB0_103-.LJTI0_0
	.long	.LBB0_105-.LJTI0_0
	.long	.LBB0_107-.LJTI0_0
	.long	.LBB0_109-.LJTI0_0
	.long	.LBB0_111-.LJTI0_0
	.long	.LBB0_113-.LJTI0_0
	.long	.LBB0_115-.LJTI0_0
	.long	.LBB0_117-.LJTI0_0
	.long	.LBB0_119-.LJTI0_0
	.long	.LBB0_121-.LJTI0_0
	.long	.LBB0_123-.LJTI0_0
	.long	.LBB0_125-.LJTI0_0
	.long	.LBB0_127-.LJTI0_0
	.long	.LBB0_144-.LJTI0_0
.LJTI0_1:
	.long	.LBB0_4-.LJTI0_1
	.long	.LBB0_6-.LJTI0_1
	.long	.LBB0_8-.LJTI0_1
	.long	.LBB0_10-.LJTI0_1
	.long	.LBB0_12-.LJTI0_1
	.long	.LBB0_14-.LJTI0_1
	.long	.LBB0_16-.LJTI0_1
	.long	.LBB0_18-.LJTI0_1
	.long	.LBB0_20-.LJTI0_1
	.long	.LBB0_22-.LJTI0_1
	.long	.LBB0_24-.LJTI0_1
	.long	.LBB0_26-.LJTI0_1
	.long	.LBB0_28-.LJTI0_1
	.long	.LBB0_30-.LJTI0_1
	.long	.LBB0_32-.LJTI0_1
	.long	.LBB0_34-.LJTI0_1
	.long	.LBB0_36-.LJTI0_1
	.long	.LBB0_38-.LJTI0_1
	.long	.LBB0_40-.LJTI0_1
	.long	.LBB0_42-.LJTI0_1
	.long	.LBB0_44-.LJTI0_1
	.long	.LBB0_46-.LJTI0_1
	.long	.LBB0_48-.LJTI0_1
	.long	.LBB0_50-.LJTI0_1
	.long	.LBB0_52-.LJTI0_1
	.long	.LBB0_54-.LJTI0_1
	.long	.LBB0_56-.LJTI0_1
	.long	.LBB0_58-.LJTI0_1
	.long	.LBB0_60-.LJTI0_1
	.long	.LBB0_62-.LJTI0_1
	.long	.LBB0_64-.LJTI0_1
	.long	.LBB0_66-.LJTI0_1
	.long	.LBB0_68-.LJTI0_1
	.long	.LBB0_70-.LJTI0_1
	.long	.LBB0_72-.LJTI0_1
	.long	.LBB0_74-.LJTI0_1
	.long	.LBB0_76-.LJTI0_1
	.long	.LBB0_78-.LJTI0_1
	.long	.LBB0_80-.LJTI0_1
	.long	.LBB0_82-.LJTI0_1
	.long	.LBB0_84-.LJTI0_1
	.long	.LBB0_86-.LJTI0_1
	.long	.LBB0_88-.LJTI0_1
	.long	.LBB0_90-.LJTI0_1
	.long	.LBB0_92-.LJTI0_1
	.long	.LBB0_94-.LJTI0_1
	.long	.LBB0_96-.LJTI0_1
	.long	.LBB0_98-.LJTI0_1
	.long	.LBB0_100-.LJTI0_1
	.long	.LBB0_102-.LJTI0_1
	.long	.LBB0_104-.LJTI0_1
	.long	.LBB0_106-.LJTI0_1
	.long	.LBB0_108-.LJTI0_1
	.long	.LBB0_110-.LJTI0_1
	.long	.LBB0_112-.LJTI0_1
	.long	.LBB0_114-.LJTI0_1
	.long	.LBB0_116-.LJTI0_1
	.long	.LBB0_118-.LJTI0_1
	.long	.LBB0_120-.LJTI0_1
	.long	.LBB0_122-.LJTI0_1
	.long	.LBB0_124-.LJTI0_1
	.long	.LBB0_126-.LJTI0_1
	.long	.LBB0_128-.LJTI0_1
	.long	.LBB0_143-.LJTI0_1
	.long	.LBB0_3-.LJTI0_1
	.long	.LBB0_5-.LJTI0_1
	.long	.LBB0_7-.LJTI0_1
	.long	.LBB0_9-.LJTI0_1
	.long	.LBB0_11-.LJTI0_1
	.long	.LBB0_13-.LJTI0_1
	.long	.LBB0_15-.LJTI0_1
	.long	.LBB0_17-.LJTI0_1
	.long	.LBB0_19-.LJTI0_1
	.long	.LBB0_21-.LJTI0_1
	.long	.LBB0_23-.LJTI0_1
	.long	.LBB0_25-.LJTI0_1
	.long	.LBB0_27-.LJTI0_1
	.long	.LBB0_29-.LJTI0_1
	.long	.LBB0_31-.LJTI0_1
	.long	.LBB0_33-.LJTI0_1
	.long	.LBB0_35-.LJTI0_1
	.long	.LBB0_37-.LJTI0_1
	.long	.LBB0_39-.LJTI0_1
	.long	.LBB0_41-.LJTI0_1
	.long	.LBB0_43-.LJTI0_1
	.long	.LBB0_45-.LJTI0_1
	.long	.LBB0_47-.LJTI0_1
	.long	.LBB0_49-.LJTI0_1
	.long	.LBB0_51-.LJTI0_1
	.long	.LBB0_53-.LJTI0_1
	.long	.LBB0_55-.LJTI0_1
	.long	.LBB0_57-.LJTI0_1
	.long	.LBB0_59-.LJTI0_1
	.long	.LBB0_61-.LJTI0_1
	.long	.LBB0_63-.LJTI0_1
	.long	.LBB0_65-.LJTI0_1
	.long	.LBB0_67-.LJTI0_1
	.long	.LBB0_69-.LJTI0_1
	.long	.LBB0_71-.LJTI0_1
	.long	.LBB0_73-.LJTI0_1
	.long	.LBB0_75-.LJTI0_1
	.long	.LBB0_77-.LJTI0_1
	.long	.LBB0_79-.LJTI0_1
	.long	.LBB0_81-.LJTI0_1
	.long	.LBB0_83-.LJTI0_1
	.long	.LBB0_85-.LJTI0_1
	.long	.LBB0_87-.LJTI0_1
	.long	.LBB0_89-.LJTI0_1
	.long	.LBB0_91-.LJTI0_1
	.long	.LBB0_93-.LJTI0_1
	.long	.LBB0_95-.LJTI0_1
	.long	.LBB0_97-.LJTI0_1
	.long	.LBB0_99-.LJTI0_1
	.long	.LBB0_101-.LJTI0_1
	.long	.LBB0_103-.LJTI0_1
	.long	.LBB0_105-.LJTI0_1
	.long	.LBB0_107-.LJTI0_1
	.long	.LBB0_109-.LJTI0_1
	.long	.LBB0_111-.LJTI0_1
	.long	.LBB0_113-.LJTI0_1
	.long	.LBB0_115-.LJTI0_1
	.long	.LBB0_117-.LJTI0_1
	.long	.LBB0_119-.LJTI0_1
	.long	.LBB0_121-.LJTI0_1
	.long	.LBB0_123-.LJTI0_1
	.long	.LBB0_125-.LJTI0_1
	.long	.LBB0_127-.LJTI0_1
	.long	.LBB0_144-.LJTI0_1
                                        # -- End function
