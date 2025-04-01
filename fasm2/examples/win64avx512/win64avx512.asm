
use AMD64, XSAVE, AVX512F

format PE64 NX GUI 5.0
entry start

section '.data' data readable writeable

  _title db 'AVX-512 playground',0
  _error db 'AVX-512 instructions are not supported.',0

  x dq 3.14159265389

  vector_output:
    repeat 32, i:0
	db 'ZMM',`i,':',9,'%f, %f, %f, %f, %f, %f, %f, %f',10
    end repeat
    db 0

  buffer db 1000h dup ?

section '.text' code readable executable

    start:

	mov	eax,1
	cpuid
	and	ecx,18000000h
	cmp	ecx,18000000h
	jne	no_AVX512
	xor	ecx,ecx
	xgetbv
	and	eax,11100110b
	cmp	eax,11100110b
	jne	no_AVX512
	mov	eax,7
	cpuid
	test	ebx,1 shl 16
	jz	no_AVX512

		vbroadcastsd	zmm0, [x]
		vmovapd 	zmm1, zmm0

		mov		al, 10011111b
		kmovw		k1, eax
;   {AVX512DQ}	kmovb		k1, eax
		vsqrtpd 	zmm1{k1}, zmm1

		vsubpd		ymm2, ymm0, ymm1
		vsubpd		xmm3, xmm1, xmm2
		vaddpd		ymm4, ymm2, ymm3
		vaddpd		zmm5, zmm1, zmm4
		vcmpeqpd	k6, zmm5, zmm0

	test	ebx,1 shl 30
	jz	no_AVX512BW

    {AVX512BW}	kshiftlq	k6, k6, 1

    no_AVX512BW:

		vmulpd		zmm6{k6}, zmm0, zmm1
		vgetexppd	zmm7{k6}, zmm6

	sub	rsp,818h

    repeat 32, i:0
	vmovups [rsp+10h+i*64],zmm#i
    end repeat

	mov	r8,[rsp+10h]
	mov	r9,[rsp+18h]
	lea	rdx,[vector_output]
	lea	rcx,[buffer]
	call	[sprintf]

	xor	ecx,ecx
	lea	rdx,[buffer]
	lea	r8,[_title]
	xor	r9d,r9d
	call	[MessageBoxA]

	xor	ecx,ecx
	call	[ExitProcess]

    no_AVX512:

	sub	rsp,28h

	xor	ecx,ecx
	lea	rdx,[_error]
	lea	r8,[_title]
	mov	r9d,10h
	call	[MessageBoxA]

	mov	ecx,1
	call	[ExitProcess]

section '.idata' import data readable writeable

    include 'imports.inc'

    imports KERNEL32.DLL, ExitProcess, USER32.DLL, MessageBoxA, MSVCRT.DLL, sprintf
