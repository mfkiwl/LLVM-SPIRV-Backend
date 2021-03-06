; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-unknown -mattr=+sse2 | FileCheck -check-prefix=CHECK -check-prefix=CHECK64 %s
; RUN: llc < %s -mtriple=i686-pc-unknown -mattr=+sse2 | FileCheck -check-prefix=CHECK -check-prefix=CHECK32 %s

; PR19059

define i32 @isint_return(double %d) nounwind {
; CHECK64-LABEL: isint_return:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    cvttpd2dq %xmm0, %xmm1
; CHECK64-NEXT:    cvtdq2pd %xmm1, %xmm1
; CHECK64-NEXT:    cmpeqsd %xmm0, %xmm1
; CHECK64-NEXT:    movq %xmm1, %rax
; CHECK64-NEXT:    andl $1, %eax
; CHECK64-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK64-NEXT:    retq
;
; CHECK32-LABEL: isint_return:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK32-NEXT:    cvttpd2dq %xmm0, %xmm1
; CHECK32-NEXT:    cvtdq2pd %xmm1, %xmm1
; CHECK32-NEXT:    cmpeqsd %xmm0, %xmm1
; CHECK32-NEXT:    movd %xmm1, %eax
; CHECK32-NEXT:    andl $1, %eax
; CHECK32-NEXT:    retl
  %i = fptosi double %d to i32
  %e = sitofp i32 %i to double
  %c = fcmp oeq double %d, %e
  %z = zext i1 %c to i32
  ret i32 %z
}

define i32 @isint_float_return(float %f) nounwind {
; CHECK64-LABEL: isint_float_return:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    cvttps2dq %xmm0, %xmm1
; CHECK64-NEXT:    cvtdq2ps %xmm1, %xmm1
; CHECK64-NEXT:    cmpeqss %xmm0, %xmm1
; CHECK64-NEXT:    movd %xmm1, %eax
; CHECK64-NEXT:    andl $1, %eax
; CHECK64-NEXT:    retq
;
; CHECK32-LABEL: isint_float_return:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK32-NEXT:    cvttps2dq %xmm0, %xmm1
; CHECK32-NEXT:    cvtdq2ps %xmm1, %xmm1
; CHECK32-NEXT:    cmpeqss %xmm0, %xmm1
; CHECK32-NEXT:    movd %xmm1, %eax
; CHECK32-NEXT:    andl $1, %eax
; CHECK32-NEXT:    retl
  %i = fptosi float %f to i32
  %g = sitofp i32 %i to float
  %c = fcmp oeq float %f, %g
  %z = zext i1 %c to i32
  ret i32 %z
}

declare void @foo()

define void @isint_branch(double %d) nounwind {
; CHECK64-LABEL: isint_branch:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    cvttpd2dq %xmm0, %xmm1
; CHECK64-NEXT:    cvtdq2pd %xmm1, %xmm1
; CHECK64-NEXT:    ucomisd %xmm1, %xmm0
; CHECK64-NEXT:    jne .LBB2_2
; CHECK64-NEXT:    jp .LBB2_2
; CHECK64-NEXT:  # %bb.1: # %true
; CHECK64-NEXT:    pushq %rax
; CHECK64-NEXT:    callq foo
; CHECK64-NEXT:    popq %rax
; CHECK64-NEXT:  .LBB2_2: # %false
; CHECK64-NEXT:    retq
;
; CHECK32-LABEL: isint_branch:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK32-NEXT:    cvttpd2dq %xmm0, %xmm1
; CHECK32-NEXT:    cvtdq2pd %xmm1, %xmm1
; CHECK32-NEXT:    ucomisd %xmm1, %xmm0
; CHECK32-NEXT:    jne .LBB2_2
; CHECK32-NEXT:    jp .LBB2_2
; CHECK32-NEXT:  # %bb.1: # %true
; CHECK32-NEXT:    calll foo
; CHECK32-NEXT:  .LBB2_2: # %false
; CHECK32-NEXT:    retl
  %i = fptosi double %d to i32
  %e = sitofp i32 %i to double
  %c = fcmp oeq double %d, %e
  br i1 %c, label %true, label %false
true:
  call void @foo()
  ret void
false:
  ret void
}
