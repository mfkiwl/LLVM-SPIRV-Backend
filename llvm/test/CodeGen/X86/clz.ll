; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=CHECK --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=CHECK --check-prefix=X64
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+bmi,+lzcnt | FileCheck %s --check-prefix=CHECK --check-prefix=X32-CLZ
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi,+lzcnt | FileCheck %s --check-prefix=CHECK --check-prefix=X64-CLZ

declare i8 @llvm.cttz.i8(i8, i1)
declare i16 @llvm.cttz.i16(i16, i1)
declare i32 @llvm.cttz.i32(i32, i1)
declare i64 @llvm.cttz.i64(i64, i1)

declare i8 @llvm.ctlz.i8(i8, i1)
declare i16 @llvm.ctlz.i16(i16, i1)
declare i32 @llvm.ctlz.i32(i32, i1)
declare i64 @llvm.ctlz.i64(i64, i1)

define i8 @cttz_i8(i8 %x)  {
; X32-LABEL: cttz_i8:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i8:
; X64:       # %bb.0:
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    bsfl %eax, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i8:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i8:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    movzbl %dil, %eax
; X64-CLZ-NEXT:    tzcntl %eax, %eax
; X64-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X64-CLZ-NEXT:    retq
  %tmp = call i8 @llvm.cttz.i8( i8 %x, i1 true )
  ret i8 %tmp
}

define i16 @cttz_i16(i16 %x)  {
; X32-LABEL: cttz_i16:
; X32:       # %bb.0:
; X32-NEXT:    bsfw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i16:
; X64:       # %bb.0:
; X64-NEXT:    bsfw %di, %ax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i16:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    tzcntw {{[0-9]+}}(%esp), %ax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i16:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    tzcntw %di, %ax
; X64-CLZ-NEXT:    retq
  %tmp = call i16 @llvm.cttz.i16( i16 %x, i1 true )
  ret i16 %tmp
}

define i32 @cttz_i32(i32 %x)  {
; X32-LABEL: cttz_i32:
; X32:       # %bb.0:
; X32-NEXT:    bsfl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i32:
; X64:       # %bb.0:
; X64-NEXT:    bsfl %edi, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i32:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    tzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i32:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    tzcntl %edi, %eax
; X64-CLZ-NEXT:    retq
  %tmp = call i32 @llvm.cttz.i32( i32 %x, i1 true )
  ret i32 %tmp
}

define i64 @cttz_i64(i64 %x)  {
; X32-LABEL: cttz_i64:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    jne .LBB3_1
; X32-NEXT:  # %bb.2:
; X32-NEXT:    bsfl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    addl $32, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
; X32-NEXT:  .LBB3_1:
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i64:
; X64:       # %bb.0:
; X64-NEXT:    bsfq %rdi, %rax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i64:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    testl %eax, %eax
; X32-CLZ-NEXT:    jne .LBB3_1
; X32-CLZ-NEXT:  # %bb.2:
; X32-CLZ-NEXT:    tzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    addl $32, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
; X32-CLZ-NEXT:  .LBB3_1:
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i64:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    tzcntq %rdi, %rax
; X64-CLZ-NEXT:    retq
  %tmp = call i64 @llvm.cttz.i64( i64 %x, i1 true )
  ret i64 %tmp
}

define i8 @ctlz_i8(i8 %x) {
; X32-LABEL: ctlz_i8:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $7, %eax
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i8:
; X64:       # %bb.0:
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    bsrl %eax, %eax
; X64-NEXT:    xorl $7, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i8:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    addl $-24, %eax
; X32-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i8:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    movzbl %dil, %eax
; X64-CLZ-NEXT:    lzcntl %eax, %eax
; X64-CLZ-NEXT:    addl $-24, %eax
; X64-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X64-CLZ-NEXT:    retq
  %tmp2 = call i8 @llvm.ctlz.i8( i8 %x, i1 true )
  ret i8 %tmp2
}

define i16 @ctlz_i16(i16 %x) {
; X32-LABEL: ctlz_i16:
; X32:       # %bb.0:
; X32-NEXT:    bsrw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    xorl $15, %eax
; X32-NEXT:    # kill: def $ax killed $ax killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i16:
; X64:       # %bb.0:
; X64-NEXT:    bsrw %di, %ax
; X64-NEXT:    xorl $15, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i16:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    lzcntw {{[0-9]+}}(%esp), %ax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i16:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntw %di, %ax
; X64-CLZ-NEXT:    retq
  %tmp2 = call i16 @llvm.ctlz.i16( i16 %x, i1 true )
  ret i16 %tmp2
}

define i32 @ctlz_i32(i32 %x) {
; X32-LABEL: ctlz_i32:
; X32:       # %bb.0:
; X32-NEXT:    bsrl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i32:
; X64:       # %bb.0:
; X64-NEXT:    bsrl %edi, %eax
; X64-NEXT:    xorl $31, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i32:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    lzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i32:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntl %edi, %eax
; X64-CLZ-NEXT:    retq
  %tmp = call i32 @llvm.ctlz.i32( i32 %x, i1 true )
  ret i32 %tmp
}

define i64 @ctlz_i64(i64 %x) {
; X32-LABEL: ctlz_i64:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    jne .LBB7_1
; X32-NEXT:  # %bb.2:
; X32-NEXT:    bsrl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    addl $32, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
; X32-NEXT:  .LBB7_1:
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i64:
; X64:       # %bb.0:
; X64-NEXT:    bsrq %rdi, %rax
; X64-NEXT:    xorq $63, %rax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i64:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    testl %eax, %eax
; X32-CLZ-NEXT:    jne .LBB7_1
; X32-CLZ-NEXT:  # %bb.2:
; X32-CLZ-NEXT:    lzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    addl $32, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
; X32-CLZ-NEXT:  .LBB7_1:
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i64:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntq %rdi, %rax
; X64-CLZ-NEXT:    retq
  %tmp = call i64 @llvm.ctlz.i64( i64 %x, i1 true )
  ret i64 %tmp
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i8 @ctlz_i8_zero_test(i8 %n) {
; X32-LABEL: ctlz_i8_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    testb %al, %al
; X32-NEXT:    je .LBB8_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $7, %eax
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB8_1:
; X32-NEXT:    movb $8, %al
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i8_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testb %dil, %dil
; X64-NEXT:    je .LBB8_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    bsrl %eax, %eax
; X64-NEXT:    xorl $7, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB8_1:
; X64-NEXT:    movb $8, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i8_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    addl $-24, %eax
; X32-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i8_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    movzbl %dil, %eax
; X64-CLZ-NEXT:    lzcntl %eax, %eax
; X64-CLZ-NEXT:    addl $-24, %eax
; X64-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i8 @llvm.ctlz.i8(i8 %n, i1 false)
  ret i8 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i16 @ctlz_i16_zero_test(i16 %n) {
; X32-LABEL: ctlz_i16_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testw %ax, %ax
; X32-NEXT:    je .LBB9_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    bsrw %ax, %ax
; X32-NEXT:    xorl $15, %eax
; X32-NEXT:    # kill: def $ax killed $ax killed $eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB9_1:
; X32-NEXT:    movw $16, %ax
; X32-NEXT:    # kill: def $ax killed $ax killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i16_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testw %di, %di
; X64-NEXT:    je .LBB9_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsrw %di, %ax
; X64-NEXT:    xorl $15, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB9_1:
; X64-NEXT:    movw $16, %ax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i16_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    lzcntw {{[0-9]+}}(%esp), %ax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i16_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntw %di, %ax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i16 @llvm.ctlz.i16(i16 %n, i1 false)
  ret i16 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i32 @ctlz_i32_zero_test(i32 %n) {
; X32-LABEL: ctlz_i32_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    je .LBB10_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB10_1:
; X32-NEXT:    movl $32, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i32_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testl %edi, %edi
; X64-NEXT:    je .LBB10_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsrl %edi, %eax
; X64-NEXT:    xorl $31, %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB10_1:
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i32_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    lzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i32_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntl %edi, %eax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i32 @llvm.ctlz.i32(i32 %n, i1 false)
  ret i32 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i64 @ctlz_i64_zero_test(i64 %n) {
; X32-LABEL: ctlz_i64_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    bsrl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl $63, %eax
; X32-NEXT:    je .LBB11_2
; X32-NEXT:  # %bb.1:
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:  .LBB11_2:
; X32-NEXT:    testl %ecx, %ecx
; X32-NEXT:    jne .LBB11_3
; X32-NEXT:  # %bb.4:
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    addl $32, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
; X32-NEXT:  .LBB11_3:
; X32-NEXT:    bsrl %ecx, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i64_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testq %rdi, %rdi
; X64-NEXT:    je .LBB11_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsrq %rdi, %rax
; X64-NEXT:    xorq $63, %rax
; X64-NEXT:    retq
; X64-NEXT:  .LBB11_1:
; X64-NEXT:    movl $64, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i64_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    testl %eax, %eax
; X32-CLZ-NEXT:    jne .LBB11_1
; X32-CLZ-NEXT:  # %bb.2:
; X32-CLZ-NEXT:    lzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    addl $32, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
; X32-CLZ-NEXT:  .LBB11_1:
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i64_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntq %rdi, %rax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i64 @llvm.ctlz.i64(i64 %n, i1 false)
  ret i64 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i8 @cttz_i8_zero_test(i8 %n) {
; X32-LABEL: cttz_i8_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    testb %al, %al
; X32-NEXT:    je .LBB12_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB12_1:
; X32-NEXT:    movb $8, %al
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i8_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testb %dil, %dil
; X64-NEXT:    je .LBB12_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    bsfl %eax, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB12_1:
; X64-NEXT:    movb $8, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i8_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    orl $256, %eax # imm = 0x100
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i8_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    movzbl %dil, %eax
; X64-CLZ-NEXT:    orl $256, %eax # imm = 0x100
; X64-CLZ-NEXT:    tzcntl %eax, %eax
; X64-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i8 @llvm.cttz.i8(i8 %n, i1 false)
  ret i8 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i16 @cttz_i16_zero_test(i16 %n) {
; X32-LABEL: cttz_i16_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testw %ax, %ax
; X32-NEXT:    je .LBB13_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    bsfw %ax, %ax
; X32-NEXT:    retl
; X32-NEXT:  .LBB13_1:
; X32-NEXT:    movw $16, %ax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i16_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testw %di, %di
; X64-NEXT:    je .LBB13_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsfw %di, %ax
; X64-NEXT:    retq
; X64-NEXT:  .LBB13_1:
; X64-NEXT:    movw $16, %ax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i16_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    tzcntw {{[0-9]+}}(%esp), %ax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i16_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    tzcntw %di, %ax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i16 @llvm.cttz.i16(i16 %n, i1 false)
  ret i16 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i32 @cttz_i32_zero_test(i32 %n) {
; X32-LABEL: cttz_i32_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    je .LBB14_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB14_1:
; X32-NEXT:    movl $32, %eax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i32_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testl %edi, %edi
; X64-NEXT:    je .LBB14_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsfl %edi, %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB14_1:
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i32_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    tzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i32_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    tzcntl %edi, %eax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i32 @llvm.cttz.i32(i32 %n, i1 false)
  ret i32 %tmp1
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
define i64 @cttz_i64_zero_test(i64 %n) {
; X32-LABEL: cttz_i64_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    bsfl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl $32, %eax
; X32-NEXT:    je .LBB15_2
; X32-NEXT:  # %bb.1:
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:  .LBB15_2:
; X32-NEXT:    testl %ecx, %ecx
; X32-NEXT:    jne .LBB15_3
; X32-NEXT:  # %bb.4:
; X32-NEXT:    addl $32, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
; X32-NEXT:  .LBB15_3:
; X32-NEXT:    bsfl %ecx, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i64_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testq %rdi, %rdi
; X64-NEXT:    je .LBB15_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsfq %rdi, %rax
; X64-NEXT:    retq
; X64-NEXT:  .LBB15_1:
; X64-NEXT:    movl $64, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i64_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    testl %eax, %eax
; X32-CLZ-NEXT:    jne .LBB15_1
; X32-CLZ-NEXT:  # %bb.2:
; X32-CLZ-NEXT:    tzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    addl $32, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
; X32-CLZ-NEXT:  .LBB15_1:
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i64_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    tzcntq %rdi, %rax
; X64-CLZ-NEXT:    retq
  %tmp1 = call i64 @llvm.cttz.i64(i64 %n, i1 false)
  ret i64 %tmp1
}

; Don't generate the cmovne when the source is known non-zero (and bsr would
; not set ZF).
; rdar://9490949
; FIXME: The compare and branch are produced late in IR (by CodeGenPrepare), and
;        codegen doesn't know how to delete the movl and je.
define i32 @ctlz_i32_fold_cmov(i32 %n) {
; X32-LABEL: ctlz_i32_fold_cmov:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl $1, %eax
; X32-NEXT:    je .LBB16_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB16_1:
; X32-NEXT:    movl $32, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i32_fold_cmov:
; X64:       # %bb.0:
; X64-NEXT:    orl $1, %edi
; X64-NEXT:    je .LBB16_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsrl %edi, %eax
; X64-NEXT:    xorl $31, %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB16_1:
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i32_fold_cmov:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    orl $1, %eax
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i32_fold_cmov:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    orl $1, %edi
; X64-CLZ-NEXT:    lzcntl %edi, %eax
; X64-CLZ-NEXT:    retq
  %or = or i32 %n, 1
  %tmp1 = call i32 @llvm.ctlz.i32(i32 %or, i1 false)
  ret i32 %tmp1
}

; Don't generate any xors when a 'ctlz' intrinsic is actually used to compute
; the most significant bit, which is what 'bsr' does natively.
; FIXME: We should probably select BSR instead of LZCNT in these circumstances.
define i32 @ctlz_bsr(i32 %n) {
; X32-LABEL: ctlz_bsr:
; X32:       # %bb.0:
; X32-NEXT:    bsrl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_bsr:
; X64:       # %bb.0:
; X64-NEXT:    bsrl %edi, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_bsr:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    lzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    xorl $31, %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_bsr:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntl %edi, %eax
; X64-CLZ-NEXT:    xorl $31, %eax
; X64-CLZ-NEXT:    retq
  %ctlz = call i32 @llvm.ctlz.i32(i32 %n, i1 true)
  %bsr = xor i32 %ctlz, 31
  ret i32 %bsr
}

; Generate a test and branch to handle zero inputs because bsr/bsf are very slow.
; FIXME: The compare and branch are produced late in IR (by CodeGenPrepare), and
;        codegen doesn't know how to combine the $32 and $31 into $63.
define i32 @ctlz_bsr_zero_test(i32 %n) {
; X32-LABEL: ctlz_bsr_zero_test:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    je .LBB18_1
; X32-NEXT:  # %bb.2: # %cond.false
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB18_1:
; X32-NEXT:    movl $32, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_bsr_zero_test:
; X64:       # %bb.0:
; X64-NEXT:    testl %edi, %edi
; X64-NEXT:    je .LBB18_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsrl %edi, %eax
; X64-NEXT:    xorl $31, %eax
; X64-NEXT:    xorl $31, %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB18_1:
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    xorl $31, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_bsr_zero_test:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    lzcntl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    xorl $31, %eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_bsr_zero_test:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    lzcntl %edi, %eax
; X64-CLZ-NEXT:    xorl $31, %eax
; X64-CLZ-NEXT:    retq
  %ctlz = call i32 @llvm.ctlz.i32(i32 %n, i1 false)
  %bsr = xor i32 %ctlz, 31
  ret i32 %bsr
}

define i8 @cttz_i8_knownbits(i8 %x)  {
; X32-LABEL: cttz_i8_knownbits:
; X32:       # %bb.0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    orb $2, %al
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i8_knownbits:
; X64:       # %bb.0:
; X64-NEXT:    orb $2, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    bsfl %eax, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i8_knownbits:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-CLZ-NEXT:    orb $2, %al
; X32-CLZ-NEXT:    movzbl %al, %eax
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i8_knownbits:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    orb $2, %dil
; X64-CLZ-NEXT:    movzbl %dil, %eax
; X64-CLZ-NEXT:    tzcntl %eax, %eax
; X64-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X64-CLZ-NEXT:    retq
  %x2 = or i8 %x, 2
  %tmp = call i8 @llvm.cttz.i8(i8 %x2, i1 true )
  %tmp2 = and i8 %tmp, 1
  ret i8 %tmp2
}

define i8 @ctlz_i8_knownbits(i8 %x)  {
; X32-LABEL: ctlz_i8_knownbits:
; X32:       # %bb.0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    orb $64, %al
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $7, %eax
; X32-NEXT:    # kill: def $al killed $al killed $eax
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i8_knownbits:
; X64:       # %bb.0:
; X64-NEXT:    orb $64, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    bsrl %eax, %eax
; X64-NEXT:    xorl $7, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i8_knownbits:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-CLZ-NEXT:    orb $64, %al
; X32-CLZ-NEXT:    movzbl %al, %eax
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    addl $-24, %eax
; X32-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i8_knownbits:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    orb $64, %dil
; X64-CLZ-NEXT:    movzbl %dil, %eax
; X64-CLZ-NEXT:    lzcntl %eax, %eax
; X64-CLZ-NEXT:    addl $-24, %eax
; X64-CLZ-NEXT:    # kill: def $al killed $al killed $eax
; X64-CLZ-NEXT:    retq

  %x2 = or i8 %x, 64
  %tmp = call i8 @llvm.ctlz.i8(i8 %x2, i1 true )
  %tmp2 = and i8 %tmp, 1
  ret i8 %tmp2
}

; Make sure we can detect that the input is non-zero and avoid cmov after BSR
; This is relevant for 32-bit mode without lzcnt
define i64 @ctlz_i64_zero_test_knownneverzero(i64 %n) {
; X32-LABEL: ctlz_i64_zero_test_knownneverzero:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    jne .LBB21_1
; X32-NEXT:  # %bb.2:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    orl $1, %eax
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    orl $32, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
; X32-NEXT:  .LBB21_1:
; X32-NEXT:    bsrl %eax, %eax
; X32-NEXT:    xorl $31, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: ctlz_i64_zero_test_knownneverzero:
; X64:       # %bb.0:
; X64-NEXT:    orq $1, %rdi
; X64-NEXT:    je .LBB21_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsrq %rdi, %rax
; X64-NEXT:    xorq $63, %rax
; X64-NEXT:    retq
; X64-NEXT:  .LBB21_1:
; X64-NEXT:    movl $64, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: ctlz_i64_zero_test_knownneverzero:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    testl %eax, %eax
; X32-CLZ-NEXT:    jne .LBB21_1
; X32-CLZ-NEXT:  # %bb.2:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    orl $1, %eax
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    orl $32, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
; X32-CLZ-NEXT:  .LBB21_1:
; X32-CLZ-NEXT:    lzcntl %eax, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: ctlz_i64_zero_test_knownneverzero:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    orq $1, %rdi
; X64-CLZ-NEXT:    lzcntq %rdi, %rax
; X64-CLZ-NEXT:    retq
  %o = or i64 %n, 1
  %tmp1 = call i64 @llvm.ctlz.i64(i64 %o, i1 false)
  ret i64 %tmp1
}

; Make sure we can detect that the input is non-zero and avoid cmov after BSF
; This is relevant for 32-bit mode without tzcnt
define i64 @cttz_i64_zero_test_knownneverzero(i64 %n) {
; X32-LABEL: cttz_i64_zero_test_knownneverzero:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testl %eax, %eax
; X32-NEXT:    jne .LBB22_1
; X32-NEXT:  # %bb.2:
; X32-NEXT:    movl $-2147483648, %eax # imm = 0x80000000
; X32-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    orl $32, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
; X32-NEXT:  .LBB22_1:
; X32-NEXT:    bsfl %eax, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: cttz_i64_zero_test_knownneverzero:
; X64:       # %bb.0:
; X64-NEXT:    movabsq $-9223372036854775808, %rax # imm = 0x8000000000000000
; X64-NEXT:    orq %rdi, %rax
; X64-NEXT:    je .LBB22_1
; X64-NEXT:  # %bb.2: # %cond.false
; X64-NEXT:    bsfq %rax, %rax
; X64-NEXT:    retq
; X64-NEXT:  .LBB22_1:
; X64-NEXT:    movl $64, %eax
; X64-NEXT:    retq
;
; X32-CLZ-LABEL: cttz_i64_zero_test_knownneverzero:
; X32-CLZ:       # %bb.0:
; X32-CLZ-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    testl %eax, %eax
; X32-CLZ-NEXT:    jne .LBB22_1
; X32-CLZ-NEXT:  # %bb.2:
; X32-CLZ-NEXT:    movl $-2147483648, %eax # imm = 0x80000000
; X32-CLZ-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    orl $32, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
; X32-CLZ-NEXT:  .LBB22_1:
; X32-CLZ-NEXT:    tzcntl %eax, %eax
; X32-CLZ-NEXT:    xorl %edx, %edx
; X32-CLZ-NEXT:    retl
;
; X64-CLZ-LABEL: cttz_i64_zero_test_knownneverzero:
; X64-CLZ:       # %bb.0:
; X64-CLZ-NEXT:    movabsq $-9223372036854775808, %rax # imm = 0x8000000000000000
; X64-CLZ-NEXT:    orq %rdi, %rax
; X64-CLZ-NEXT:    tzcntq %rax, %rax
; X64-CLZ-NEXT:    retq
  %o = or i64 %n, -9223372036854775808 ; 0x8000000000000000
  %tmp1 = call i64 @llvm.cttz.i64(i64 %o, i1 false)
  ret i64 %tmp1
}
