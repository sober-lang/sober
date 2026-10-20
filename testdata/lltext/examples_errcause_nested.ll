; 生成物（sober build --emit=ll）
target triple = "x86_64-unknown-linux-none"

module asm ".globl _start"
module asm "_start:"
module asm "  movq %rsp, %rdi"
module asm "  andq $-16, %rsp"
module asm "  call sober_entry"
module asm "  ud2"

attributes #0 = { nounwind "no-builtins" "frame-pointer"="all" }

@"rt.meta" = internal global [2574 x i64] zeroinitializer
@"rt.btip" = internal global [1025 x i64] zeroinitializer
@"rt.gcache" = internal global [320 x i64] zeroinitializer
@"rt.rgen" = internal global [1025 x i64] zeroinitializer
@"rt.iobuf" = internal global [512 x i64] zeroinitializer
@"str.0" = internal constant [2 x i64] [i64 7959390400869068654, i64 8292]
@"str.1" = internal constant [1 x i64] [i64 9117585978058084]
@"str.2" = internal constant [1 x i64] [i64 27503]
@"str.3" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.4" = internal constant [1 x i64] [i64 45]
@"str.5" = internal constant [1 x i64] [i64 2334102040480936567]
@"str.6" = internal constant [2 x i64] [i64 8027139070292271162, i64 543452789]
@"str.7" = internal constant [2 x i64] [i64 7234304299308949562, i64 32]
@"str.8" = internal constant [2 x i64] [i64 2322280035508515872, i64 9117585978058084]
@"str.9" = internal constant [1 x i64] [i64 111477645603872]
@"str.10" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.11" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.12" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.13" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.14" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.15" = internal constant [1 x i64] [i64 2685]
@"str.16" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.17" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.18" = internal constant [1 x i64] [i64 35899498962976]
@"str.19" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.20" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [6 x i64] [i64 2533275880914951, i64 7599827508527363, i64 8725727465701635, i64 8444252589654273, i64 2533276132573191, i64 2533275511816199]
@"str.21" = internal constant [1 x i64] [i64 9071397899755888]
@"str.22" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.23" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.24" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.25" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.26" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.27" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.28" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.29" = internal constant [1 x i64] [i64 544497952]
@"str.30" = internal constant [3 x i64] [i64 7310315681293169253, i64 3342908374242389599, i64 491327221619]
@"str.31" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]

define internal void @"rt.flush"() #0 {
b0:
  %v0 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v0, i64 1028
  %v1 = load i64, ptr %v1.p
  %v2 = add i64 0, 0
  %v3.c = icmp eq i64 %v1, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v5 = add i64 0, 0
  br label %b3
b2:
  ret void
b3:
  %v4 = phi i64 [ %v5, %b1 ], [ %v4, %b6 ], [ %v21, %b8 ]
  %v6.p = getelementptr i64, ptr %v0, i64 1028
  %v6 = load i64, ptr %v6.p
  %v7 = sub i64 %v6, %v4
  %v8 = add i64 0, 0
  %v9.c = icmp sgt i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b3 = icmp ne i64 %v9, 0
  br i1 %c.b3, label %b3.t3, label %b3.e4
b3.t3:
  br label %b4
b3.e4:
  br label %b5
b4:
  %v10 = add i64 0, 8248
  %v11 = add i64 %v10, %v4
  %v12 = getelementptr i8, ptr %v0, i64 %v11
  %v13 = ptrtoint ptr %v12 to i64
  %v14.p = getelementptr i64, ptr %v0, i64 1026
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 0, 1
  %v16 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v15, i64 %v14, i64 %v13, i64 %v7)
  %v17 = add i64 0, -4
  %v18.c = icmp eq i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b4 = icmp ne i64 %v18, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b6
b4.e6:
  br label %b7
b5:
  %v22 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v0, i64 1028
  store i64 %v22, ptr %st6
  ret void
b6:
  br label %b3
b7:
  %v19 = add i64 0, 0
  %v20.c = icmp sle i64 %v16, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b7 = icmp ne i64 %v20, 0
  br i1 %c.b7, label %b7.t8, label %b7.e9
b7.t8:
  br label %b5
b7.e9:
  br label %b8
b8:
  %v21 = add i64 %v4, %v16
  br label %b3
}

define internal void @"rt.print_char"(i64 %v0) #0 {
b0:
  %v1 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v1, i64 1028
  %v2 = load i64, ptr %v2.p
  %v3 = add i64 0, 8248
  %v4 = add i64 %v3, %v2
  %v5 = getelementptr i8, ptr %v1, i64 %v4
  %st0 = getelementptr i8, ptr %v5, i64 0
  %st0.b = trunc i64 %v0 to i8
  store i8 %st0.b, ptr %st0
  %v6 = add i64 0, 1
  %v7 = add i64 %v2, %v6
  %st1 = getelementptr i64, ptr %v1, i64 1028
  store i64 %v7, ptr %st1
  %v8 = add i64 0, 10
  %v9.c = icmp eq i64 %v0, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b0 = icmp ne i64 %v9, 0
  br i1 %c.b0, label %b0.t3, label %b0.e4
b0.t3:
  br label %b1
b0.e4:
  br label %b2
b1:
  call void @"rt.flush"()
  br label %b3
b2:
  %v10 = add i64 0, 4096
  %v11.c = icmp sge i64 %v7, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b2 = icmp ne i64 %v11, 0
  br i1 %c.b2, label %b2.t5, label %b2.e6
b2.t5:
  br label %b1
b2.e6:
  br label %b3
b3:
  ret void
}

define internal void @"rt.print_int"(i64 %v0) #0 {
b0:
  %s0 = alloca [4 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %v1 = getelementptr i64, ptr %s0, i64 0
  %v2 = add i64 0, 0
  %v3.c = icmp slt i64 %v0, %v2
  %v3 = zext i1 %v3.c to i64
  %v4 = add i64 0, 1
  %v5 = add i64 0, 2
  %v6 = mul i64 %v5, %v3
  %v7 = sub i64 %v4, %v6
  %v8 = add i64 0, 10
  %v11 = add i64 0, 32
  br label %b1
b1:
  %v9 = phi i64 [ %v0, %b0 ], [ %v19, %b1.t2 ]
  %v10 = phi i64 [ %v11, %b0 ], [ %v17, %b1.t2 ]
  %v12 = add i64 0, 48
  %v13 = srem i64 %v9, %v8
  %v14 = mul i64 %v13, %v7
  %v15 = add i64 %v12, %v14
  %v16 = add i64 0, 1
  %v17 = sub i64 %v10, %v16
  %v18 = getelementptr i8, ptr %v1, i64 %v17
  %st0 = getelementptr i8, ptr %v18, i64 0
  %st0.b = trunc i64 %v15 to i8
  store i8 %st0.b, ptr %st0
  %v19 = sdiv i64 %v9, %v8
  %v21 = add i64 0, 0
  %v22.c = icmp ne i64 %v19, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b1 = icmp ne i64 %v22, 0
  br i1 %c.b1, label %b1.t2, label %b1.e3
b1.t2:
  br label %b1
b1.e3:
  br label %b2
b2:
  %v20 = phi i64 [ %v17, %b1.e3 ]
  %c.b2 = icmp ne i64 %v3, 0
  br i1 %c.b2, label %b2.t4, label %b2.e5
b2.t4:
  br label %b3
b2.e5:
  br label %b4
b3:
  %v24 = add i64 0, 1
  %v25 = sub i64 %v20, %v24
  %v26 = getelementptr i8, ptr %v1, i64 %v25
  %v27 = add i64 0, 45
  %st5 = getelementptr i8, ptr %v26, i64 0
  %st5.b = trunc i64 %v27 to i8
  store i8 %st5.b, ptr %st5
  br label %b4
b4:
  %v23 = phi i64 [ %v20, %b2.e5 ], [ %v25, %b3 ], [ %v33, %b5 ]
  %v28 = add i64 0, 32
  %v29.c = icmp slt i64 %v23, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b4 = icmp ne i64 %v29, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b5
b4.e8:
  br label %b6
b5:
  %v30 = getelementptr i8, ptr %v1, i64 %v23
  %v31.p = getelementptr i8, ptr %v30, i64 0
  %v31.b = load i8, ptr %v31.p
  %v31 = zext i8 %v31.b to i64
  call void @"rt.print_char"(i64 %v31)
  %v32 = add i64 0, 1
  %v33 = add i64 %v23, %v32
  br label %b4
b6:
  ret void
}

define internal void @"rt.region_enter"() #0 {
b0:
  %v0 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v0, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = add i64 0, 1
  %v3 = add i64 %v1, %v2
  %v4 = add i64 0, 1024
  %v5.c = icmp sge i64 %v3, %v4
  %v5 = zext i1 %v5.c to i64
  %c.b0 = icmp ne i64 %v5, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v6 = add i64 0, 1
  call void @"rt.panic_mem"(i64 %v6)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b2:
  %st2 = getelementptr i64, ptr %v0, i64 0
  store i64 %v3, ptr %st2
  %v7.p = getelementptr i64, ptr %v0, i64 1029
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v0, i64 1030
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v0, i64 2569
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v0, i64 2570
  %v10 = load i64, ptr %v10.p
  br label %b3
b3:
  %v11 = phi i64 [ %v3, %b2 ], [ %v25, %b6 ]
  %v12.c = icmp sle i64 %v11, %v10
  %v12 = zext i1 %v12.c to i64
  %c.b3 = icmp ne i64 %v12, 0
  br i1 %c.b3, label %b3.t4, label %b3.e5
b3.t4:
  br label %b4
b3.e5:
  br label %b7
b4:
  %v13 = mul i64 %v11, %v8
  %v14 = add i64 %v7, %v13
  %v15 = getelementptr i64, ptr %v0, i64 %v11
  %v16.p = getelementptr i64, ptr %v15, i64 1
  %v16 = load i64, ptr %v16.p
  %v17 = sub i64 %v16, %v14
  %v18.c = icmp sgt i64 %v17, %v9
  %v18 = zext i1 %v18.c to i64
  %c.b4 = icmp ne i64 %v18, 0
  br i1 %c.b4, label %b4.t6, label %b4.e7
b4.t6:
  br label %b5
b4.e7:
  br label %b6
b5:
  %v19 = add i64 0, 28
  %v20 = add i64 %v14, %v9
  %v21 = sub i64 %v17, %v9
  %v22 = add i64 0, 4
  %v23 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v19, i64 %v20, i64 %v21, i64 %v22)
  br label %b6
b6:
  %v24 = add i64 0, 1
  %v25 = add i64 %v11, %v24
  br label %b3
b7:
  %st7 = getelementptr i64, ptr %v0, i64 2570
  store i64 %v3, ptr %st7
  %v26 = mul i64 %v3, %v8
  %v27 = add i64 %v7, %v26
  %v28 = getelementptr i64, ptr %v0, i64 %v3
  %st8 = getelementptr i64, ptr %v28, i64 1
  store i64 %v27, ptr %st8
  %v29 = getelementptr i64, ptr @"rt.rgen", i64 0
  %v30 = getelementptr i64, ptr %v29, i64 %v3
  %v31.p = getelementptr i64, ptr %v30, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 0, 1
  %v33 = add i64 %v31, %v32
  %st9 = getelementptr i64, ptr %v30, i64 0
  store i64 %v33, ptr %st9
  ret void
}

define internal ptr @"rt.region_alloc"(i64 %v0, i64 %v1) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3 = getelementptr i64, ptr %v2, i64 %v0
  %v4.p = getelementptr i64, ptr %v3, i64 1
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 8
  %v6 = mul i64 %v1, %v5
  %v7 = add i64 %v4, %v6
  %v8.p = getelementptr i64, ptr %v2, i64 1029
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 1
  %v10 = add i64 %v0, %v9
  %v11.p = getelementptr i64, ptr %v2, i64 1030
  %v11 = load i64, ptr %v11.p
  %v12 = mul i64 %v10, %v11
  %v13 = add i64 %v8, %v12
  %v14.c = icmp sgt i64 %v7, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v15 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v15)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b2:
  %st2 = getelementptr i64, ptr %v3, i64 1
  store i64 %v7, ptr %st2
  %v16 = inttoptr i64 %v4 to ptr
  ret ptr %v16
}

define internal void @"rt.region_relocate"(ptr %v0, i64 %v1, i64 %v2) #0 {
b0:
  %v3.p = getelementptr i64, ptr %v0, i64 2
  %v3 = load i64, ptr %v3.p
  %v4.c = icmp sgt i64 %v3, %v2
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5.p = getelementptr i64, ptr %v0, i64 1
  %v5 = load i64, ptr %v5.p
  %v6 = mul i64 %v5, %v1
  %v7 = call ptr @"rt.region_alloc"(i64 %v2, i64 %v6)
  %v8.p = getelementptr i64, ptr %v0, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = inttoptr i64 %v8 to ptr
  call void @"rt.copy"(ptr %v7, ptr %v9, i64 %v6)
  %v10 = ptrtoint ptr %v7 to i64
  %st2 = getelementptr i64, ptr %v0, i64 0
  store i64 %v10, ptr %st2
  %st3 = getelementptr i64, ptr %v0, i64 2
  store i64 %v2, ptr %st3
  br label %b2
b2:
  ret void
}

define internal void @"rt.copy"(ptr %v0, ptr %v1, i64 %v2) #0 {
b0:
  %v4 = add i64 0, 0
  br label %b1
b1:
  %v3 = phi i64 [ %v4, %b0 ], [ %v10, %b2 ]
  %v5.c = icmp slt i64 %v3, %v2
  %v5 = zext i1 %v5.c to i64
  %c.b1 = icmp ne i64 %v5, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b3
b2:
  %v6 = getelementptr i64, ptr %v0, i64 %v3
  %v7 = getelementptr i64, ptr %v1, i64 %v3
  %v8.p = getelementptr i64, ptr %v7, i64 0
  %v8 = load i64, ptr %v8.p
  %st2 = getelementptr i64, ptr %v6, i64 0
  store i64 %v8, ptr %st2
  %v9 = add i64 0, 1
  %v10 = add i64 %v3, %v9
  br label %b1
b3:
  ret void
}

define internal i64 @"rt.str_eq"(ptr %v0, ptr %v1) #0 {
b0:
  %v2.p = getelementptr i64, ptr %v0, i64 1
  %v2 = load i64, ptr %v2.p
  %v3.p = getelementptr i64, ptr %v0, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = inttoptr i64 %v3 to ptr
  %v5.p = getelementptr i64, ptr %v1, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = inttoptr i64 %v5 to ptr
  %v8.p = getelementptr i64, ptr %v1, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.c = icmp ne i64 %v2, %v8
  %v9 = zext i1 %v9.c to i64
  %v10 = add i64 0, 0
  %c.b0 = icmp ne i64 %v9, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v11 = add i64 0, 0
  ret i64 %v11
b2:
  %v7 = phi i64 [ %v10, %b0.e2 ], [ %v21, %b4 ]
  %v12 = add i64 0, 8
  %v13 = add i64 %v7, %v12
  %v14.c = icmp sle i64 %v13, %v2
  %v14 = zext i1 %v14.c to i64
  %c.b2 = icmp ne i64 %v14, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b5
b3:
  %v15 = getelementptr i8, ptr %v4, i64 %v7
  %v16.p = getelementptr i64, ptr %v15, i64 0
  %v16 = load i64, ptr %v16.p, align 1
  %v17 = getelementptr i8, ptr %v6, i64 %v7
  %v18.p = getelementptr i64, ptr %v17, i64 0
  %v18 = load i64, ptr %v18.p, align 1
  %v19.c = icmp ne i64 %v16, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b3 = icmp ne i64 %v19, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b1
b3.e6:
  br label %b4
b4:
  %v20 = add i64 0, 8
  %v21 = add i64 %v7, %v20
  br label %b2
b5:
  %v22.c = icmp eq i64 %v7, %v2
  %v22 = zext i1 %v22.c to i64
  %c.b5 = icmp ne i64 %v22, 0
  br i1 %c.b5, label %b5.t7, label %b5.e8
b5.t7:
  br label %b6
b5.e8:
  br label %b8
b6:
  %v64 = add i64 0, 1
  ret i64 %v64
b7:
  %v49 = add i64 0, 8
  %v50 = sub i64 %v2, %v49
  %v51 = getelementptr i8, ptr %v4, i64 %v50
  %v52.p = getelementptr i64, ptr %v51, i64 0
  %v52 = load i64, ptr %v52.p, align 1
  %v53 = getelementptr i8, ptr %v6, i64 %v50
  %v54.p = getelementptr i64, ptr %v53, i64 0
  %v54 = load i64, ptr %v54.p, align 1
  %v55.c = icmp ne i64 %v52, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b7 = icmp ne i64 %v55, 0
  br i1 %c.b7, label %b7.t9, label %b7.e10
b7.t9:
  br label %b1
b7.e10:
  br label %b6
b8:
  %v24 = add i64 0, 8
  %v25.c = icmp sge i64 %v2, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b8 = icmp ne i64 %v25, 0
  br i1 %c.b8, label %b8.t11, label %b8.e12
b8.t11:
  br label %b7
b8.e12:
  br label %b10
b9:
  %v23 = phi i64 [ %v7, %b10.e16 ], [ %v63, %b13 ]
  %v56.c = icmp slt i64 %v23, %v2
  %v56 = zext i1 %v56.c to i64
  %c.b9 = icmp ne i64 %v56, 0
  br i1 %c.b9, label %b9.t13, label %b9.e14
b9.t13:
  br label %b12
b9.e14:
  br label %b6
b10:
  %v26 = ptrtoint ptr %v4 to i64
  %v27 = add i64 0, 4095
  %v28 = and i64 %v26, %v27
  %v29 = add i64 0, 4089
  %v30 = sub i64 %v28, %v29
  %v31 = ptrtoint ptr %v6 to i64
  %v32 = add i64 0, 4095
  %v33 = and i64 %v31, %v32
  %v34 = add i64 0, 4089
  %v35 = sub i64 %v33, %v34
  %v36 = and i64 %v30, %v35
  %v37 = add i64 0, 0
  %v38.c = icmp slt i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b10 = icmp ne i64 %v38, 0
  br i1 %c.b10, label %b10.t15, label %b10.e16
b10.t15:
  br label %b11
b10.e16:
  br label %b9
b11:
  %v39.p = getelementptr i64, ptr %v4, i64 0
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v6, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = xor i64 %v39, %v40
  %v42 = add i64 0, 8
  %v43 = sub i64 %v42, %v2
  %v44 = add i64 0, 3
  %v45.n = and i64 %v44, 63
  %v45 = shl i64 %v43, %v45.n
  %v46.n = and i64 %v45, 63
  %v46 = shl i64 %v41, %v46.n
  %v47 = add i64 0, 0
  %v48.c = icmp eq i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b11 = icmp ne i64 %v48, 0
  br i1 %c.b11, label %b11.t17, label %b11.e18
b11.t17:
  br label %b6
b11.e18:
  br label %b1
b12:
  %v57 = getelementptr i8, ptr %v4, i64 %v23
  %v58.p = getelementptr i8, ptr %v57, i64 0
  %v58.b = load i8, ptr %v58.p
  %v58 = zext i8 %v58.b to i64
  %v59 = getelementptr i8, ptr %v6, i64 %v23
  %v60.p = getelementptr i8, ptr %v59, i64 0
  %v60.b = load i8, ptr %v60.p
  %v60 = zext i8 %v60.b to i64
  %v61.c = icmp ne i64 %v58, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b12 = icmp ne i64 %v61, 0
  br i1 %c.b12, label %b12.t19, label %b12.e20
b12.t19:
  br label %b1
b12.e20:
  br label %b13
b13:
  %v62 = add i64 0, 1
  %v63 = add i64 %v23, %v62
  br label %b9
}

define internal i64 @"rt.map_hash"(ptr %v0, i64 %v1) #0 {
b0:
  %v2 = add i64 0, 0
  %v3.c = icmp eq i64 %v1, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v4.p = getelementptr i64, ptr %v0, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, -7046029254386353131
  %v6 = mul i64 %v4, %v5
  %v7 = add i64 0, 29
  %v8.n = and i64 %v7, 63
  %v8 = ashr i64 %v6, %v8.n
  %v9 = xor i64 %v6, %v8
  ret i64 %v9
b2:
  %v10.p = getelementptr i64, ptr %v0, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = inttoptr i64 %v10 to ptr
  %v12.p = getelementptr i64, ptr %v0, i64 1
  %v12 = load i64, ptr %v12.p
  %v17 = add i64 0, 0
  %v18 = add i64 0, -3750763034065230579
  br label %b3
b3:
  %v13 = phi i64 [ %v17, %b2 ], [ %v26, %b4 ]
  %v14 = phi i64 [ %v18, %b2 ], [ %v28, %b4 ]
  %v19 = add i64 0, 8
  %v20 = add i64 %v13, %v19
  %v21.c = icmp sle i64 %v20, %v12
  %v21 = zext i1 %v21.c to i64
  %c.b3 = icmp ne i64 %v21, 0
  br i1 %c.b3, label %b3.t3, label %b3.e4
b3.t3:
  br label %b4
b3.e4:
  br label %b5
b4:
  %v22 = getelementptr i8, ptr %v11, i64 %v13
  %v23.p = getelementptr i64, ptr %v22, i64 0
  %v23 = load i64, ptr %v23.p, align 1
  %v24 = xor i64 %v14, %v23
  %v25 = add i64 0, 8
  %v26 = add i64 %v13, %v25
  %v27 = add i64 0, -7046029254386353131
  %v28 = mul i64 %v24, %v27
  br label %b3
b5:
  %v15 = phi i64 [ %v13, %b3.e4 ], [ %v34, %b6 ]
  %v16 = phi i64 [ %v14, %b3.e4 ], [ %v36, %b6 ]
  %v29.c = icmp slt i64 %v15, %v12
  %v29 = zext i1 %v29.c to i64
  %c.b5 = icmp ne i64 %v29, 0
  br i1 %c.b5, label %b5.t5, label %b5.e6
b5.t5:
  br label %b6
b5.e6:
  br label %b7
b6:
  %v30 = getelementptr i8, ptr %v11, i64 %v15
  %v31.p = getelementptr i8, ptr %v30, i64 0
  %v31.b = load i8, ptr %v31.p
  %v31 = zext i8 %v31.b to i64
  %v32 = xor i64 %v16, %v31
  %v33 = add i64 0, 1
  %v34 = add i64 %v15, %v33
  %v35 = add i64 0, 1099511628211
  %v36 = mul i64 %v32, %v35
  br label %b5
b7:
  %v37 = add i64 0, 29
  %v38.n = and i64 %v37, 63
  %v38 = ashr i64 %v16, %v38.n
  %v39 = xor i64 %v16, %v38
  ret i64 %v39
}

define internal void @"rt.print_str"(ptr %v0) #0 {
b0:
  %v1.p = getelementptr i64, ptr %v0, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = inttoptr i64 %v1 to ptr
  %v3.p = getelementptr i64, ptr %v0, i64 1
  %v3 = load i64, ptr %v3.p
  %v5 = add i64 0, 0
  br label %b1
b1:
  %v4 = phi i64 [ %v5, %b0 ], [ %v10, %b2 ]
  %v6.c = icmp slt i64 %v4, %v3
  %v6 = zext i1 %v6.c to i64
  %c.b1 = icmp ne i64 %v6, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b3
b2:
  %v7 = getelementptr i8, ptr %v2, i64 %v4
  %v8.p = getelementptr i8, ptr %v7, i64 0
  %v8.b = load i8, ptr %v8.p
  %v8 = zext i8 %v8.b to i64
  call void @"rt.print_char"(i64 %v8)
  %v9 = add i64 0, 1
  %v10 = add i64 %v4, %v9
  br label %b1
b3:
  ret void
}

define internal void @"rt.panic_mem"(i64 %v0) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [3 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s2 = alloca [3 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [3 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %v1 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v2 = add i64 0, 2
  %st0 = getelementptr i64, ptr %v1, i64 1026
  store i64 %v2, ptr %st0
  %v3 = getelementptr i64, ptr @"str.10", i64 0
  %v4 = add i64 0, 29
  %v5 = add i64 0, 0
  %v6 = getelementptr i64, ptr %s0, i64 0
  %v7 = ptrtoint ptr %v3 to i64
  %st1 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 1
  store i64 %v4, ptr %st2
  %st3 = getelementptr i64, ptr %v6, i64 2
  store i64 %v5, ptr %st3
  call void @"rt.print_str"(ptr %v6)
  %v8 = add i64 0, 1
  %v9.c = icmp eq i64 %v0, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b0 = icmp ne i64 %v9, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b2
b0.e6:
  br label %b3
b1:
  %v29 = getelementptr i64, ptr @"str.14", i64 0
  %v30 = add i64 0, 9
  %v31 = add i64 0, 0
  %v32 = getelementptr i64, ptr %s4, i64 0
  %v33 = ptrtoint ptr %v29 to i64
  %st6 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st6
  %st7 = getelementptr i64, ptr %v32, i64 1
  store i64 %v30, ptr %st7
  %st8 = getelementptr i64, ptr %v32, i64 2
  store i64 %v31, ptr %st8
  call void @"rt.print_str"(ptr %v32)
  %v34.p = getelementptr i64, ptr %v1, i64 0
  %v34 = load i64, ptr %v34.p
  call void @"rt.print_int"(i64 %v34)
  %v35 = getelementptr i64, ptr @"str.15", i64 0
  %v36 = add i64 0, 2
  %v37 = add i64 0, 0
  %v38 = getelementptr i64, ptr %s5, i64 0
  %v39 = ptrtoint ptr %v35 to i64
  %st9 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st9
  %st10 = getelementptr i64, ptr %v38, i64 1
  store i64 %v36, ptr %st10
  %st11 = getelementptr i64, ptr %v38, i64 2
  store i64 %v37, ptr %st11
  call void @"rt.print_str"(ptr %v38)
  %v40.p = getelementptr i64, ptr %v1, i64 1029
  %v40 = load i64, ptr %v40.p
  %v41.p = getelementptr i64, ptr %v1, i64 1030
  %v41 = load i64, ptr %v41.p
  %v46 = add i64 0, 1
  %v47 = add i64 0, 0
  br label %b8
b2:
  %v10 = getelementptr i64, ptr @"str.11", i64 0
  %v11 = add i64 0, 11
  %v12 = add i64 0, 0
  %v13 = getelementptr i64, ptr %s1, i64 0
  %v14 = ptrtoint ptr %v10 to i64
  %st12 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st12
  %st13 = getelementptr i64, ptr %v13, i64 1
  store i64 %v11, ptr %st13
  %st14 = getelementptr i64, ptr %v13, i64 2
  store i64 %v12, ptr %st14
  call void @"rt.print_str"(ptr %v13)
  br label %b1
b3:
  %v15 = add i64 0, 2
  %v16.c = icmp eq i64 %v0, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b3 = icmp ne i64 %v16, 0
  br i1 %c.b3, label %b3.t16, label %b3.e17
b3.t16:
  br label %b4
b3.e17:
  br label %b5
b4:
  %v17 = getelementptr i64, ptr @"str.12", i64 0
  %v18 = add i64 0, 13
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr %s2, i64 0
  %v21 = ptrtoint ptr %v17 to i64
  %st17 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st17
  %st18 = getelementptr i64, ptr %v20, i64 1
  store i64 %v18, ptr %st18
  %st19 = getelementptr i64, ptr %v20, i64 2
  store i64 %v19, ptr %st19
  call void @"rt.print_str"(ptr %v20)
  br label %b1
b5:
  %v22 = add i64 0, 3
  %v23.c = icmp eq i64 %v0, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b5 = icmp ne i64 %v23, 0
  br i1 %c.b5, label %b5.t21, label %b5.e22
b5.t21:
  br label %b6
b5.e22:
  br label %b7
b6:
  %v24 = getelementptr i64, ptr @"str.13", i64 0
  %v25 = add i64 0, 12
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v28 = ptrtoint ptr %v24 to i64
  %st22 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st22
  %st23 = getelementptr i64, ptr %v27, i64 1
  store i64 %v25, ptr %st23
  %st24 = getelementptr i64, ptr %v27, i64 2
  store i64 %v26, ptr %st24
  call void @"rt.print_str"(ptr %v27)
  br label %b1
b7:
  br label %b1
b8:
  %v42 = phi i64 [ %v46, %b1 ], [ %v78, %b12 ]
  %v43 = phi i64 [ %v47, %b1 ], [ %v44, %b12 ]
  %v48.c = icmp sle i64 %v42, %v34
  %v48 = zext i1 %v48.c to i64
  %c.b8 = icmp ne i64 %v48, 0
  br i1 %c.b8, label %b8.t26, label %b8.e27
b8.t26:
  br label %b9
b8.e27:
  br label %b13
b9:
  %v49 = getelementptr i64, ptr %v1, i64 %v42
  %v50.p = getelementptr i64, ptr %v49, i64 1
  %v50 = load i64, ptr %v50.p
  %v51 = mul i64 %v42, %v41
  %v52 = add i64 %v40, %v51
  %v53 = sub i64 %v50, %v52
  %v54 = add i64 0, 0
  %v55.c = icmp sgt i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b9 = icmp ne i64 %v55, 0
  br i1 %c.b9, label %b9.t28, label %b9.e29
b9.t28:
  br label %b10
b9.e29:
  br label %b12
b10:
  %v56 = add i64 0, 16
  %v57.c = icmp slt i64 %v43, %v56
  %v57 = zext i1 %v57.c to i64
  %v58 = add i64 0, 1
  %v59 = add i64 %v43, %v58
  %c.b10 = icmp ne i64 %v57, 0
  br i1 %c.b10, label %b10.t30, label %b10.e31
b10.t30:
  br label %b11
b10.e31:
  br label %b12
b11:
  %v60 = getelementptr i64, ptr @"str.16", i64 0
  %v61 = add i64 0, 16
  %v62 = add i64 0, 0
  %v63 = getelementptr i64, ptr %s6, i64 0
  %v64 = ptrtoint ptr %v60 to i64
  %st31 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st31
  %st32 = getelementptr i64, ptr %v63, i64 1
  store i64 %v61, ptr %st32
  %st33 = getelementptr i64, ptr %v63, i64 2
  store i64 %v62, ptr %st33
  call void @"rt.print_str"(ptr %v63)
  call void @"rt.print_int"(i64 %v42)
  %v65 = getelementptr i64, ptr @"str.17", i64 0
  %v66 = add i64 0, 14
  %v67 = add i64 0, 0
  %v68 = getelementptr i64, ptr %s7, i64 0
  %v69 = ptrtoint ptr %v65 to i64
  %st34 = getelementptr i64, ptr %v68, i64 0
  store i64 %v69, ptr %st34
  %st35 = getelementptr i64, ptr %v68, i64 1
  store i64 %v66, ptr %st35
  %st36 = getelementptr i64, ptr %v68, i64 2
  store i64 %v67, ptr %st36
  call void @"rt.print_str"(ptr %v68)
  call void @"rt.print_int"(i64 %v53)
  %v70 = getelementptr i64, ptr @"str.15", i64 0
  %v71 = add i64 0, 2
  %v72 = add i64 0, 0
  %v73 = getelementptr i64, ptr %s8, i64 0
  %v74 = ptrtoint ptr %v70 to i64
  %st37 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st37
  %st38 = getelementptr i64, ptr %v73, i64 1
  store i64 %v71, ptr %st38
  %st39 = getelementptr i64, ptr %v73, i64 2
  store i64 %v72, ptr %st39
  call void @"rt.print_str"(ptr %v73)
  %v75 = add i64 0, 1
  %v76 = add i64 %v43, %v75
  br label %b12
b12:
  %v44 = phi i64 [ %v43, %b9.e29 ], [ %v59, %b10.e31 ], [ %v76, %b11 ]
  %v77 = add i64 0, 1
  %v78 = add i64 %v42, %v77
  br label %b8
b13:
  %v45 = phi i64 [ %v43, %b8.e27 ]
  %v79 = add i64 0, 16
  %v80.c = icmp sgt i64 %v45, %v79
  %v80 = zext i1 %v80.c to i64
  %c.b13 = icmp ne i64 %v80, 0
  br i1 %c.b13, label %b13.t41, label %b13.e42
b13.t41:
  br label %b14
b13.e42:
  br label %b15
b14:
  %v81 = getelementptr i64, ptr @"str.18", i64 0
  %v82 = add i64 0, 6
  %v83 = add i64 0, 0
  %v84 = getelementptr i64, ptr %s9, i64 0
  %v85 = ptrtoint ptr %v81 to i64
  %st42 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st42
  %st43 = getelementptr i64, ptr %v84, i64 1
  store i64 %v82, ptr %st43
  %st44 = getelementptr i64, ptr %v84, i64 2
  store i64 %v83, ptr %st44
  call void @"rt.print_str"(ptr %v84)
  %v86 = add i64 0, 16
  %v87 = sub i64 %v45, %v86
  call void @"rt.print_int"(i64 %v87)
  %v88 = getelementptr i64, ptr @"str.19", i64 0
  %v89 = add i64 0, 34
  %v90 = add i64 0, 0
  %v91 = getelementptr i64, ptr %s10, i64 0
  %v92 = ptrtoint ptr %v88 to i64
  %st45 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st45
  %st46 = getelementptr i64, ptr %v91, i64 1
  store i64 %v89, ptr %st46
  %st47 = getelementptr i64, ptr %v91, i64 2
  store i64 %v90, ptr %st47
  call void @"rt.print_str"(ptr %v91)
  br label %b15
b15:
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
}

define internal void @"rt.depth_report"() #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [3 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %v0 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v0, i64 2573
  %v1 = load i64, ptr %v1.p
  %v2 = add i64 0, 0
  %v3.c = icmp eq i64 %v1, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v6 = add i64 0, 1023
  br label %b3
b2:
  ret void
b3:
  %v4 = phi i64 [ %v6, %b1 ], [ %v15, %b4.e6 ]
  %v7 = add i64 0, 0
  %v8.c = icmp sgt i64 %v4, %v7
  %v8 = zext i1 %v8.c to i64
  %v9 = add i64 0, 0
  %c.b3 = icmp ne i64 %v8, 0
  br i1 %c.b3, label %b3.t3, label %b3.e4
b3.t3:
  br label %b4
b3.e4:
  br label %b5
b4:
  %v10 = getelementptr i64, ptr %v0, i64 %v4
  %v11.p = getelementptr i64, ptr %v10, i64 1
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.c = icmp ne i64 %v11, %v12
  %v13 = zext i1 %v13.c to i64
  %v14 = add i64 0, 1
  %v15 = sub i64 %v4, %v14
  %c.b4 = icmp ne i64 %v13, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b3
b5:
  %v5 = phi i64 [ %v9, %b3.e4 ], [ %v4, %b4.t5 ]
  call void @"rt.flush"()
  %v16 = add i64 0, 2
  %st6 = getelementptr i64, ptr %v0, i64 1026
  store i64 %v16, ptr %st6
  %v17 = getelementptr i64, ptr @"str.20", i64 0
  %v18 = add i64 0, 18
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr %s0, i64 0
  %v21 = ptrtoint ptr %v17 to i64
  %st7 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st7
  %st8 = getelementptr i64, ptr %v20, i64 1
  store i64 %v18, ptr %st8
  %st9 = getelementptr i64, ptr %v20, i64 2
  store i64 %v19, ptr %st9
  call void @"rt.print_str"(ptr %v20)
  call void @"rt.print_int"(i64 %v5)
  %v22 = getelementptr i64, ptr @"str.15", i64 0
  %v23 = add i64 0, 2
  %v24 = add i64 0, 0
  %v25 = getelementptr i64, ptr %s1, i64 0
  %v26 = ptrtoint ptr %v22 to i64
  %st10 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st10
  %st11 = getelementptr i64, ptr %v25, i64 1
  store i64 %v23, ptr %st11
  %st12 = getelementptr i64, ptr %v25, i64 2
  store i64 %v24, ptr %st12
  call void @"rt.print_str"(ptr %v25)
  call void @"rt.flush"()
  %v27 = add i64 0, 1
  %st13 = getelementptr i64, ptr %v0, i64 1026
  store i64 %v27, ptr %st13
  ret void
}

define internal ptr @"rt.region_alloc8"(i64 %v0, i64 %v1) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3 = getelementptr i64, ptr %v2, i64 %v0
  %v4.p = getelementptr i64, ptr %v3, i64 1
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 7
  %v6 = add i64 %v1, %v5
  %v7 = add i64 0, -8
  %v8 = and i64 %v6, %v7
  %v9 = add i64 %v4, %v8
  %v10.p = getelementptr i64, ptr %v2, i64 1029
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 1
  %v12 = add i64 %v0, %v11
  %v13.p = getelementptr i64, ptr %v2, i64 1030
  %v13 = load i64, ptr %v13.p
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v10, %v14
  %v16.c = icmp sgt i64 %v9, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v17 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b2:
  %st2 = getelementptr i64, ptr %v3, i64 1
  store i64 %v9, ptr %st2
  %v18 = getelementptr i64, ptr @"rt.btip", i64 0
  %v19 = getelementptr i64, ptr %v18, i64 %v0
  %v20 = add i64 %v4, %v1
  %st3 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st3
  %v21 = inttoptr i64 %v4 to ptr
  ret ptr %v21
}

define internal i64 @"rt.tip8"(i64 %v0, i64 %v1) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.btip", i64 0
  %v3 = getelementptr i64, ptr %v2, i64 %v0
  %v4.p = getelementptr i64, ptr %v3, i64 0
  %v4 = load i64, ptr %v4.p
  %v5.c = icmp ne i64 %v4, %v1
  %v5 = zext i1 %v5.c to i64
  %c.b0 = icmp ne i64 %v5, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v6 = add i64 0, 0
  ret i64 %v6
b2:
  %v7 = add i64 0, 7
  %v8 = and i64 %v1, %v7
  %v9 = add i64 0, 0
  %v10.c = icmp ne i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b2 = icmp ne i64 %v10, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v11 = add i64 0, 1
  %v12 = add i64 %v1, %v11
  %st4 = getelementptr i64, ptr %v3, i64 0
  store i64 %v12, ptr %st4
  %v13 = add i64 0, 1
  ret i64 %v13
b4:
  %v14 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15 = getelementptr i64, ptr %v14, i64 %v0
  %v16.p = getelementptr i64, ptr %v15, i64 1
  %v16 = load i64, ptr %v16.p
  %v17.c = icmp eq i64 %v16, %v1
  %v17 = zext i1 %v17.c to i64
  %c.b4 = icmp ne i64 %v17, 0
  br i1 %c.b4, label %b4.t6, label %b4.e7
b4.t6:
  br label %b5
b4.e7:
  br label %b6
b5:
  %v19 = add i64 0, 8
  %v20 = add i64 %v1, %v19
  %v21.p = getelementptr i64, ptr %v14, i64 1029
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 0, 1
  %v23 = add i64 %v0, %v22
  %v24.p = getelementptr i64, ptr %v14, i64 1030
  %v24 = load i64, ptr %v24.p
  %v25 = mul i64 %v23, %v24
  %v26 = add i64 %v21, %v25
  %v27.c = icmp sgt i64 %v20, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b5 = icmp ne i64 %v27, 0
  br i1 %c.b5, label %b5.t8, label %b5.e9
b5.t8:
  br label %b7
b5.e9:
  br label %b8
b6:
  %v18 = add i64 0, 0
  ret i64 %v18
b7:
  %v28 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v28)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b8:
  %st9 = getelementptr i64, ptr %v15, i64 1
  store i64 %v20, ptr %st9
  %v29 = add i64 0, 1
  %v30 = add i64 %v1, %v29
  %st10 = getelementptr i64, ptr %v3, i64 0
  store i64 %v30, ptr %st10
  %v31 = add i64 0, 1
  ret i64 %v31
}

define internal i64 @"rt.tipn8"(i64 %v0, i64 %v1, i64 %v2) #0 {
b0:
  %v3 = getelementptr i64, ptr @"rt.btip", i64 0
  %v4 = getelementptr i64, ptr %v3, i64 %v0
  %v5.p = getelementptr i64, ptr %v4, i64 0
  %v5 = load i64, ptr %v5.p
  %v6.c = icmp ne i64 %v5, %v1
  %v6 = zext i1 %v6.c to i64
  %c.b0 = icmp ne i64 %v6, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v7 = add i64 0, 0
  ret i64 %v7
b2:
  %v8 = add i64 %v1, %v2
  %v9 = add i64 0, 7
  %v10 = add i64 %v1, %v9
  %v11 = add i64 0, -8
  %v12 = and i64 %v10, %v11
  %v13.c = icmp sgt i64 %v8, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b2 = icmp ne i64 %v13, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b4
b2.e4:
  br label %b3
b3:
  %st4 = getelementptr i64, ptr %v4, i64 0
  store i64 %v8, ptr %st4
  %v14 = add i64 0, 1
  ret i64 %v14
b4:
  %v15 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16 = getelementptr i64, ptr %v15, i64 %v0
  %v17.p = getelementptr i64, ptr %v16, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.c = icmp eq i64 %v17, %v12
  %v18 = zext i1 %v18.c to i64
  %c.b4 = icmp ne i64 %v18, 0
  br i1 %c.b4, label %b4.t6, label %b4.e7
b4.t6:
  br label %b5
b4.e7:
  br label %b6
b5:
  %v20 = add i64 0, 7
  %v21 = add i64 %v8, %v20
  %v22 = add i64 0, -8
  %v23 = and i64 %v21, %v22
  %v24.p = getelementptr i64, ptr %v15, i64 1029
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 0, 1
  %v26 = add i64 %v0, %v25
  %v27.p = getelementptr i64, ptr %v15, i64 1030
  %v27 = load i64, ptr %v27.p
  %v28 = mul i64 %v26, %v27
  %v29 = add i64 %v24, %v28
  %v30.c = icmp sgt i64 %v23, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b5 = icmp ne i64 %v30, 0
  br i1 %c.b5, label %b5.t8, label %b5.e9
b5.t8:
  br label %b7
b5.e9:
  br label %b8
b6:
  %v19 = add i64 0, 0
  ret i64 %v19
b7:
  %v31 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v31)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b8:
  %st9 = getelementptr i64, ptr %v16, i64 1
  store i64 %v23, ptr %st9
  %st10 = getelementptr i64, ptr %v4, i64 0
  store i64 %v8, ptr %st10
  %v32 = add i64 0, 1
  ret i64 %v32
}

define internal ptr @"rt.cat8"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
b0:
  %v5.c = icmp eq i64 %v2, %v3
  %v5 = zext i1 %v5.c to i64
  %c.b0 = icmp ne i64 %v5, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b3
b1:
  %v6 = add i64 %v0, %v1
  %v7 = call i64 @"rt.tipn8"(i64 %v3, i64 %v6, i64 %v4)
  %v8 = add i64 0, 0
  %v9.c = icmp ne i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b1 = icmp ne i64 %v9, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b2
b1.e4:
  br label %b3
b2:
  %v10 = inttoptr i64 %v0 to ptr
  ret ptr %v10
b3:
  %v11 = add i64 %v1, %v4
  %v12 = call ptr @"rt.region_alloc8"(i64 %v3, i64 %v11)
  %v13 = inttoptr i64 %v0 to ptr
  call void @"rt.copy8"(ptr %v12, ptr %v13, i64 %v1)
  ret ptr %v12
}

define internal void @"rt.copy8"(ptr %v0, ptr %v1, i64 %v2) #0 {
b0:
  %v4 = add i64 0, 0
  br label %b1
b1:
  %v3 = phi i64 [ %v4, %b0 ], [ %v10, %b2 ]
  %v5.c = icmp slt i64 %v3, %v2
  %v5 = zext i1 %v5.c to i64
  %c.b1 = icmp ne i64 %v5, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b3
b2:
  %v6 = getelementptr i8, ptr %v0, i64 %v3
  %v7 = getelementptr i8, ptr %v1, i64 %v3
  %v8.p = getelementptr i8, ptr %v7, i64 0
  %v8.b = load i8, ptr %v8.p
  %v8 = zext i8 %v8.b to i64
  %st2 = getelementptr i8, ptr %v6, i64 0
  %st2.b = trunc i64 %v8 to i8
  store i8 %st2.b, ptr %st2
  %v9 = add i64 0, 1
  %v10 = add i64 %v3, %v9
  br label %b1
b3:
  ret void
}

define internal void @"rt.region_relocate8"(ptr %v0, i64 %v1) #0 {
b0:
  %v2.p = getelementptr i64, ptr %v0, i64 2
  %v2 = load i64, ptr %v2.p
  %v3.c = icmp sgt i64 %v2, %v1
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v4.p = getelementptr i64, ptr %v0, i64 1
  %v4 = load i64, ptr %v4.p
  %v5 = call ptr @"rt.region_alloc8"(i64 %v1, i64 %v4)
  %v6.p = getelementptr i64, ptr %v0, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = inttoptr i64 %v6 to ptr
  call void @"rt.copy8"(ptr %v5, ptr %v7, i64 %v4)
  %v8 = ptrtoint ptr %v5 to i64
  %st2 = getelementptr i64, ptr %v0, i64 0
  store i64 %v8, ptr %st2
  %st3 = getelementptr i64, ptr %v0, i64 2
  store i64 %v1, ptr %st3
  br label %b2
b2:
  ret void
}

define internal void @"rt.extend8"(i64 %v0, i64 %v1, i64 %v2) #0 {
b0:
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4 = getelementptr i64, ptr %v3, i64 %v0
  %v5 = add i64 %v1, %v2
  %v6 = add i64 0, 7
  %v7 = add i64 %v5, %v6
  %v8 = add i64 0, -8
  %v9 = and i64 %v7, %v8
  %v10.p = getelementptr i64, ptr %v3, i64 1029
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 1
  %v12 = add i64 %v0, %v11
  %v13.p = getelementptr i64, ptr %v3, i64 1030
  %v13 = load i64, ptr %v13.p
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v10, %v14
  %v16.c = icmp sgt i64 %v9, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v17 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b2:
  %st2 = getelementptr i64, ptr %v4, i64 1
  store i64 %v9, ptr %st2
  %v18 = getelementptr i64, ptr @"rt.btip", i64 0
  %v19 = getelementptr i64, ptr %v18, i64 %v0
  %st3 = getelementptr i64, ptr %v19, i64 0
  store i64 %v5, ptr %st3
  ret void
}

define internal ptr @"rt.slice_grow"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
b0:
  %v5 = add i64 0, 8
  %v6 = mul i64 %v2, %v5
  %v7 = mul i64 %v1, %v6
  %v8 = add i64 %v0, %v7
  %v9 = getelementptr i64, ptr @"rt.rgen", i64 0
  %v10 = getelementptr i64, ptr %v9, i64 %v3
  %v11.p = getelementptr i64, ptr %v10, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 4
  %v13.n = and i64 %v12, 63
  %v13 = ashr i64 %v0, %v13.n
  %v14 = add i64 0, 11
  %v15.n = and i64 %v14, 63
  %v15 = ashr i64 %v0, %v15.n
  %v16 = xor i64 %v13, %v15
  %v17 = add i64 0, 63
  %v18 = and i64 %v16, %v17
  %v19 = getelementptr i64, ptr @"rt.gcache", i64 0
  %v20 = add i64 0, 5
  %v21 = mul i64 %v18, %v20
  %v22 = getelementptr i64, ptr %v19, i64 %v21
  %v23.p = getelementptr i64, ptr %v22, i64 0
  %v23 = load i64, ptr %v23.p
  %v24.c = icmp ne i64 %v23, %v0
  %v24 = zext i1 %v24.c to i64
  %c.b0 = icmp ne i64 %v24, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v35 = add i64 0, 1
  %v36 = add i64 %v1, %v35
  %v38.p = getelementptr i64, ptr %v22, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.c = icmp ne i64 %v38, %v0
  %v39 = zext i1 %v39.c to i64
  %c.b1 = icmp ne i64 %v39, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b11
b1.e4:
  br label %b8
b2:
  %v25.p = getelementptr i64, ptr %v22, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp ne i64 %v25, %v3
  %v26 = zext i1 %v26.c to i64
  %c.b2 = icmp ne i64 %v26, 0
  br i1 %c.b2, label %b2.t5, label %b2.e6
b2.t5:
  br label %b1
b2.e6:
  br label %b3
b3:
  %v27.p = getelementptr i64, ptr %v22, i64 2
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp ne i64 %v27, %v11
  %v28 = zext i1 %v28.c to i64
  %c.b3 = icmp ne i64 %v28, 0
  br i1 %c.b3, label %b3.t7, label %b3.e8
b3.t7:
  br label %b1
b3.e8:
  br label %b4
b4:
  %v29.p = getelementptr i64, ptr %v22, i64 3
  %v29 = load i64, ptr %v29.p
  %v30.c = icmp ne i64 %v29, %v8
  %v30 = zext i1 %v30.c to i64
  %c.b4 = icmp ne i64 %v30, 0
  br i1 %c.b4, label %b4.t9, label %b4.e10
b4.t9:
  br label %b1
b4.e10:
  br label %b5
b5:
  %v31 = add i64 %v8, %v6
  %v32.p = getelementptr i64, ptr %v22, i64 4
  %v32 = load i64, ptr %v32.p
  %v33.c = icmp sgt i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b5 = icmp ne i64 %v33, 0
  br i1 %c.b5, label %b5.t11, label %b5.e12
b5.t11:
  br label %b1
b5.e12:
  br label %b6
b6:
  %st12 = getelementptr i64, ptr %v22, i64 3
  store i64 %v31, ptr %st12
  %v34 = inttoptr i64 %v0 to ptr
  ret ptr %v34
b7:
  %v37 = phi i64 [ %v36, %b11 ], [ %v51, %b12 ], [ %v48, %b13 ]
  %v52 = mul i64 %v37, %v2
  %v53 = call ptr @"rt.region_alloc"(i64 %v3, i64 %v52)
  %v54 = inttoptr i64 %v0 to ptr
  %v55 = mul i64 %v1, %v2
  call void @"rt.copy"(ptr %v53, ptr %v54, i64 %v55)
  %v56 = ptrtoint ptr %v53 to i64
  %v57 = add i64 0, 4
  %v58.n = and i64 %v57, 63
  %v58 = ashr i64 %v56, %v58.n
  %v59 = add i64 0, 11
  %v60.n = and i64 %v59, 63
  %v60 = ashr i64 %v56, %v60.n
  %v61 = xor i64 %v58, %v60
  %v62 = add i64 0, 63
  %v63 = and i64 %v61, %v62
  %v64 = getelementptr i64, ptr @"rt.gcache", i64 0
  %v65 = add i64 0, 5
  %v66 = mul i64 %v63, %v65
  %v67 = getelementptr i64, ptr %v64, i64 %v66
  %st13 = getelementptr i64, ptr %v67, i64 0
  store i64 %v56, ptr %st13
  %st14 = getelementptr i64, ptr %v67, i64 1
  store i64 %v3, ptr %st14
  %st15 = getelementptr i64, ptr %v67, i64 2
  store i64 %v11, ptr %st15
  %v68 = add i64 0, 1
  %v69 = add i64 %v1, %v68
  %v70 = mul i64 %v69, %v6
  %v71 = add i64 %v56, %v70
  %st16 = getelementptr i64, ptr %v67, i64 3
  store i64 %v71, ptr %st16
  %v72 = mul i64 %v37, %v6
  %v73 = add i64 %v56, %v72
  %st17 = getelementptr i64, ptr %v67, i64 4
  store i64 %v73, ptr %st17
  ret ptr %v53
b8:
  %v40.p = getelementptr i64, ptr %v22, i64 1
  %v40 = load i64, ptr %v40.p
  %v41.c = icmp ne i64 %v40, %v3
  %v41 = zext i1 %v41.c to i64
  %c.b8 = icmp ne i64 %v41, 0
  br i1 %c.b8, label %b8.t19, label %b8.e20
b8.t19:
  br label %b11
b8.e20:
  br label %b9
b9:
  %v42.p = getelementptr i64, ptr %v22, i64 2
  %v42 = load i64, ptr %v42.p
  %v43.c = icmp ne i64 %v42, %v11
  %v43 = zext i1 %v43.c to i64
  %v44 = add i64 0, 0
  %v45.c = icmp eq i64 %v4, %v44
  %v45 = zext i1 %v45.c to i64
  %v46 = or i64 %v43, %v45
  %c.b9 = icmp ne i64 %v46, 0
  br i1 %c.b9, label %b9.t21, label %b9.e22
b9.t21:
  br label %b11
b9.e22:
  br label %b10
b10:
  %v47 = add i64 0, 2
  %v48 = mul i64 %v36, %v47
  %v49 = add i64 0, 4
  %v50.c = icmp slt i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b10 = icmp ne i64 %v50, 0
  br i1 %c.b10, label %b10.t23, label %b10.e24
b10.t23:
  br label %b12
b10.e24:
  br label %b13
b11:
  br label %b7
b12:
  %v51 = add i64 0, 4
  br label %b7
b13:
  br label %b7
}

define internal ptr @"rt.slice_grow8"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v4 = add i64 0, 1
  %v5 = add i64 0, 1
  %v6 = mul i64 %v1, %v5
  %v7 = add i64 %v0, %v6
  %v8 = getelementptr i64, ptr @"rt.rgen", i64 0
  %v9 = getelementptr i64, ptr %v8, i64 %v2
  %v10.p = getelementptr i64, ptr %v9, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 4
  %v12.n = and i64 %v11, 63
  %v12 = ashr i64 %v0, %v12.n
  %v13 = add i64 0, 11
  %v14.n = and i64 %v13, 63
  %v14 = ashr i64 %v0, %v14.n
  %v15 = xor i64 %v12, %v14
  %v16 = add i64 0, 63
  %v17 = and i64 %v15, %v16
  %v18 = getelementptr i64, ptr @"rt.gcache", i64 0
  %v19 = add i64 0, 5
  %v20 = mul i64 %v17, %v19
  %v21 = getelementptr i64, ptr %v18, i64 %v20
  %v22.p = getelementptr i64, ptr %v21, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp ne i64 %v22, %v0
  %v23 = zext i1 %v23.c to i64
  %c.b0 = icmp ne i64 %v23, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v34 = add i64 0, 1
  %v35 = add i64 %v1, %v34
  %v37.p = getelementptr i64, ptr %v21, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp ne i64 %v37, %v0
  %v38 = zext i1 %v38.c to i64
  %c.b1 = icmp ne i64 %v38, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b11
b1.e4:
  br label %b8
b2:
  %v24.p = getelementptr i64, ptr %v21, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp ne i64 %v24, %v2
  %v25 = zext i1 %v25.c to i64
  %c.b2 = icmp ne i64 %v25, 0
  br i1 %c.b2, label %b2.t5, label %b2.e6
b2.t5:
  br label %b1
b2.e6:
  br label %b3
b3:
  %v26.p = getelementptr i64, ptr %v21, i64 2
  %v26 = load i64, ptr %v26.p
  %v27.c = icmp ne i64 %v26, %v10
  %v27 = zext i1 %v27.c to i64
  %c.b3 = icmp ne i64 %v27, 0
  br i1 %c.b3, label %b3.t7, label %b3.e8
b3.t7:
  br label %b1
b3.e8:
  br label %b4
b4:
  %v28.p = getelementptr i64, ptr %v21, i64 3
  %v28 = load i64, ptr %v28.p
  %v29.c = icmp ne i64 %v28, %v7
  %v29 = zext i1 %v29.c to i64
  %c.b4 = icmp ne i64 %v29, 0
  br i1 %c.b4, label %b4.t9, label %b4.e10
b4.t9:
  br label %b1
b4.e10:
  br label %b5
b5:
  %v30 = add i64 %v7, %v5
  %v31.p = getelementptr i64, ptr %v21, i64 4
  %v31 = load i64, ptr %v31.p
  %v32.c = icmp sgt i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b5 = icmp ne i64 %v32, 0
  br i1 %c.b5, label %b5.t11, label %b5.e12
b5.t11:
  br label %b1
b5.e12:
  br label %b6
b6:
  %st12 = getelementptr i64, ptr %v21, i64 3
  store i64 %v30, ptr %st12
  %v33 = inttoptr i64 %v0 to ptr
  ret ptr %v33
b7:
  %v36 = phi i64 [ %v35, %b11 ], [ %v50, %b12 ], [ %v47, %b13 ]
  %v51 = call ptr @"rt.region_alloc8"(i64 %v2, i64 %v36)
  %v52 = inttoptr i64 %v0 to ptr
  call void @"rt.copy8"(ptr %v51, ptr %v52, i64 %v1)
  %v53 = ptrtoint ptr %v51 to i64
  %v54 = add i64 0, 4
  %v55.n = and i64 %v54, 63
  %v55 = ashr i64 %v53, %v55.n
  %v56 = add i64 0, 11
  %v57.n = and i64 %v56, 63
  %v57 = ashr i64 %v53, %v57.n
  %v58 = xor i64 %v55, %v57
  %v59 = add i64 0, 63
  %v60 = and i64 %v58, %v59
  %v61 = getelementptr i64, ptr @"rt.gcache", i64 0
  %v62 = add i64 0, 5
  %v63 = mul i64 %v60, %v62
  %v64 = getelementptr i64, ptr %v61, i64 %v63
  %st13 = getelementptr i64, ptr %v64, i64 0
  store i64 %v53, ptr %st13
  %st14 = getelementptr i64, ptr %v64, i64 1
  store i64 %v2, ptr %st14
  %st15 = getelementptr i64, ptr %v64, i64 2
  store i64 %v10, ptr %st15
  %v65 = add i64 0, 1
  %v66 = add i64 %v1, %v65
  %v67 = mul i64 %v66, %v5
  %v68 = add i64 %v53, %v67
  %st16 = getelementptr i64, ptr %v64, i64 3
  store i64 %v68, ptr %st16
  %v69 = mul i64 %v36, %v5
  %v70 = add i64 %v53, %v69
  %st17 = getelementptr i64, ptr %v64, i64 4
  store i64 %v70, ptr %st17
  ret ptr %v51
b8:
  %v39.p = getelementptr i64, ptr %v21, i64 1
  %v39 = load i64, ptr %v39.p
  %v40.c = icmp ne i64 %v39, %v2
  %v40 = zext i1 %v40.c to i64
  %c.b8 = icmp ne i64 %v40, 0
  br i1 %c.b8, label %b8.t19, label %b8.e20
b8.t19:
  br label %b11
b8.e20:
  br label %b9
b9:
  %v41.p = getelementptr i64, ptr %v21, i64 2
  %v41 = load i64, ptr %v41.p
  %v42.c = icmp ne i64 %v41, %v10
  %v42 = zext i1 %v42.c to i64
  %v43 = add i64 0, 0
  %v44.c = icmp eq i64 %v3, %v43
  %v44 = zext i1 %v44.c to i64
  %v45 = or i64 %v42, %v44
  %c.b9 = icmp ne i64 %v45, 0
  br i1 %c.b9, label %b9.t21, label %b9.e22
b9.t21:
  br label %b11
b9.e22:
  br label %b10
b10:
  %v46 = add i64 0, 2
  %v47 = mul i64 %v35, %v46
  %v48 = add i64 0, 4
  %v49.c = icmp slt i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b10 = icmp ne i64 %v49, 0
  br i1 %c.b10, label %b10.t23, label %b10.e24
b10.t23:
  br label %b12
b10.e24:
  br label %b13
b11:
  br label %b7
b12:
  %v50 = add i64 0, 4
  br label %b7
b13:
  br label %b7
}

define internal ptr @"rt.map_grow"(ptr %v0, i64 %v1) #0 {
b0:
  %v2.p = getelementptr i64, ptr %v0, i64 0
  %v2 = load i64, ptr %v2.p
  %v3.p = getelementptr i64, ptr %v0, i64 1
  %v3 = load i64, ptr %v3.p
  %v4.p = getelementptr i64, ptr %v0, i64 2
  %v4 = load i64, ptr %v4.p
  %v7 = add i64 0, 1
  %v8 = add i64 %v3, %v7
  %v9 = add i64 0, 8
  %v10.c = icmp slt i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b4
b0.e2:
  br label %b5
b1:
  %v5 = phi ptr [ %v12, %b4 ], [ %v18, %b6 ], [ %v70, %b21 ]
  %v6 = phi ptr [ %v14, %b4 ], [ %v21, %b6 ], [ %v76, %b21 ]
  ret ptr %v5
b2:
  %v69 = mul i64 %v3, %v1
  %v70 = call ptr @"rt.slice_grow"(i64 %v2, i64 %v3, i64 %v1, i64 %v4, i64 %v38)
  %c.b2 = icmp ne i64 %v38, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b21
b2.e4:
  br label %b22
b3:
  %v42 = add i64 0, 16
  br label %b11
b4:
  %v11 = add i64 0, 1
  %v12 = call ptr @"rt.slice_grow"(i64 %v2, i64 %v3, i64 %v1, i64 %v4, i64 %v11)
  %v13 = mul i64 %v3, %v1
  %v14 = getelementptr i64, ptr %v12, i64 %v13
  br label %b1
b5:
  %v15 = call i64 @"rt.grow_try"(i64 %v2, i64 %v3, i64 %v1, i64 %v4)
  %v16 = add i64 0, 0
  %v17.c = icmp ne i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b5 = icmp ne i64 %v17, 0
  br i1 %c.b5, label %b5.t5, label %b5.e6
b5.t5:
  br label %b6
b5.e6:
  br label %b7
b6:
  %v18 = inttoptr i64 %v2 to ptr
  %v19 = inttoptr i64 %v2 to ptr
  %v20 = mul i64 %v3, %v1
  %v21 = getelementptr i64, ptr %v19, i64 %v20
  br label %b1
b7:
  %v22.p = getelementptr i64, ptr %v0, i64 3
  %v22 = load i64, ptr %v22.p
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v22, %v24
  %v25 = zext i1 %v25.c to i64
  %v26 = add i64 0, 0
  %c.b7 = icmp ne i64 %v25, 0
  br i1 %c.b7, label %b7.t7, label %b7.e8
b7.t7:
  br label %b9
b7.e8:
  br label %b8
b8:
  %v23 = phi i64 [ %v26, %b7.e8 ], [ %v36, %b9 ]
  %v37 = add i64 0, 1
  %v38 = xor i64 %v23, %v37
  %c.b8 = icmp ne i64 %v38, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b2
b8.e10:
  br label %b10
b9:
  %v27 = inttoptr i64 %v22 to ptr
  %v28.p = getelementptr i64, ptr %v27, i64 2
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 3
  %v30 = add i64 %v28, %v29
  %v31 = add i64 0, 8
  %v32 = mul i64 %v30, %v31
  %v33 = add i64 %v22, %v32
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v78 = getelementptr i64, ptr %v77, i64 %v4
  %v34.p = getelementptr i64, ptr %v78, i64 1
  %v34 = load ptr, ptr %v34.p
  %v35 = ptrtoint ptr %v34 to i64
  %v36.c = icmp eq i64 %v35, %v33
  %v36 = zext i1 %v36.c to i64
  br label %b8
b10:
  %v39 = add i64 0, 8
  %v40.c = icmp slt i64 %v8, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b10 = icmp ne i64 %v40, 0
  br i1 %c.b10, label %b10.t11, label %b10.e12
b10.t11:
  br label %b2
b10.e12:
  br label %b3
b11:
  %v41 = phi i64 [ %v42, %b3 ], [ %v47, %b12 ]
  %v43 = add i64 0, 4
  %v44 = mul i64 %v8, %v43
  %v45.c = icmp slt i64 %v41, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b11 = icmp ne i64 %v45, 0
  br i1 %c.b11, label %b11.t13, label %b11.e14
b11.t13:
  br label %b12
b11.e14:
  br label %b13
b12:
  %v46 = add i64 0, 2
  %v47 = mul i64 %v41, %v46
  br label %b11
b13:
  %v48 = add i64 0, 3
  %v49 = add i64 %v41, %v48
  %v50 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51 = getelementptr i64, ptr %v50, i64 %v4
  %st14 = getelementptr i64, ptr %v51, i64 1
  store i64 %v22, ptr %st14
  %v52 = add i64 0, 16
  %v53 = mul i64 %v41, %v52
  %v54 = add i64 0, 2097152
  %v55 = add i64 %v41, %v54
  %v57.c = icmp slt i64 %v53, %v55
  %v57 = zext i1 %v57.c to i64
  %c.b13 = icmp ne i64 %v57, 0
  br i1 %c.b13, label %b13.t16, label %b13.e17
b13.t16:
  br label %b15
b13.e17:
  br label %b16
b14:
  %v56 = phi i64 [ %v53, %b15 ], [ %v55, %b16 ]
  %v58 = add i64 0, 3
  %v59 = add i64 %v56, %v58
  %v60 = call ptr @"rt.region_alloc"(i64 %v4, i64 %v59)
  %v62 = add i64 0, 0
  br label %b17
b15:
  br label %b14
b16:
  br label %b14
b17:
  %v61 = phi i64 [ %v62, %b14 ], [ %v67, %b18 ]
  %v63.c = icmp slt i64 %v61, %v49
  %v63 = zext i1 %v63.c to i64
  %c.b17 = icmp ne i64 %v63, 0
  br i1 %c.b17, label %b17.t18, label %b17.e19
b17.t18:
  br label %b18
b17.e19:
  br label %b19
b18:
  %v64 = getelementptr i64, ptr %v60, i64 %v61
  %v65 = add i64 0, 0
  %st19 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st19
  %v66 = add i64 0, 1
  %v67 = add i64 %v61, %v66
  br label %b17
b19:
  %st20 = getelementptr i64, ptr %v60, i64 2
  store i64 %v41, ptr %st20
  %v68 = ptrtoint ptr %v60 to i64
  %st21 = getelementptr i64, ptr %v0, i64 3
  store i64 %v68, ptr %st21
  br label %b2
b20:
  %v73.p = getelementptr i64, ptr %v0, i64 3
  %v73 = load i64, ptr %v73.p
  %v74 = inttoptr i64 %v73 to ptr
  %v75 = ptrtoint ptr %v70 to i64
  %st22 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st22
  br label %b21
b21:
  %v76 = getelementptr i64, ptr %v70, i64 %v69
  br label %b1
b22:
  %v71 = add i64 0, 8
  %v72.c = icmp slt i64 %v8, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b22 = icmp ne i64 %v72, 0
  br i1 %c.b22, label %b22.t24, label %b22.e25
b22.t24:
  br label %b21
b22.e25:
  br label %b20
}

define internal i64 @"rt.grow_try"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v4 = add i64 0, 8
  %v5 = mul i64 %v2, %v4
  %v6 = mul i64 %v1, %v5
  %v7 = add i64 %v0, %v6
  %v8 = getelementptr i64, ptr @"rt.rgen", i64 0
  %v9 = getelementptr i64, ptr %v8, i64 %v3
  %v10.p = getelementptr i64, ptr %v9, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 4
  %v12.n = and i64 %v11, 63
  %v12 = ashr i64 %v0, %v12.n
  %v13 = add i64 0, 11
  %v14.n = and i64 %v13, 63
  %v14 = ashr i64 %v0, %v14.n
  %v15 = xor i64 %v12, %v14
  %v16 = add i64 0, 63
  %v17 = and i64 %v15, %v16
  %v18 = getelementptr i64, ptr @"rt.gcache", i64 0
  %v19 = add i64 0, 5
  %v20 = mul i64 %v17, %v19
  %v21 = getelementptr i64, ptr %v18, i64 %v20
  %v22.p = getelementptr i64, ptr %v21, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp ne i64 %v22, %v0
  %v23 = zext i1 %v23.c to i64
  %c.b0 = icmp ne i64 %v23, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b3
b1:
  %v34 = add i64 0, 0
  ret i64 %v34
b2:
  %v33 = add i64 %v7, %v5
  %st2 = getelementptr i64, ptr %v21, i64 3
  store i64 %v33, ptr %st2
  ret i64 %v0
b3:
  %v24.p = getelementptr i64, ptr %v21, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp ne i64 %v24, %v3
  %v25 = zext i1 %v25.c to i64
  %c.b3 = icmp ne i64 %v25, 0
  br i1 %c.b3, label %b3.t4, label %b3.e5
b3.t4:
  br label %b1
b3.e5:
  br label %b4
b4:
  %v26.p = getelementptr i64, ptr %v21, i64 2
  %v26 = load i64, ptr %v26.p
  %v27.c = icmp ne i64 %v26, %v10
  %v27 = zext i1 %v27.c to i64
  %c.b4 = icmp ne i64 %v27, 0
  br i1 %c.b4, label %b4.t6, label %b4.e7
b4.t6:
  br label %b1
b4.e7:
  br label %b5
b5:
  %v28.p = getelementptr i64, ptr %v21, i64 3
  %v28 = load i64, ptr %v28.p
  %v29.c = icmp ne i64 %v28, %v7
  %v29 = zext i1 %v29.c to i64
  %c.b5 = icmp ne i64 %v29, 0
  br i1 %c.b5, label %b5.t8, label %b5.e9
b5.t8:
  br label %b1
b5.e9:
  br label %b6
b6:
  %v30 = add i64 %v7, %v5
  %v31.p = getelementptr i64, ptr %v21, i64 4
  %v31 = load i64, ptr %v31.p
  %v32.c = icmp sgt i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b6 = icmp ne i64 %v32, 0
  br i1 %c.b6, label %b6.t10, label %b6.e11
b6.t10:
  br label %b1
b6.e11:
  br label %b2
}

define internal i64 @"rt.cstr"(ptr %v0, ptr %v1) #0 {
b0:
  %v2.p = getelementptr i64, ptr %v0, i64 1
  %v2 = load i64, ptr %v2.p
  %v3 = add i64 0, 4096
  %v4.c = icmp uge i64 %v2, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = add i64 0, 36
  ret i64 %v5
b2:
  %v6.p = getelementptr i64, ptr %v0, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = inttoptr i64 %v6 to ptr
  %v9 = add i64 0, 0
  br label %b3
b3:
  %v8 = phi i64 [ %v9, %b2 ], [ %v21, %b7 ]
  %v10.c = icmp sge i64 %v8, %v2
  %v10 = zext i1 %v10.c to i64
  %c.b3 = icmp ne i64 %v10, 0
  br i1 %c.b3, label %b3.t3, label %b3.e4
b3.t3:
  br label %b4
b3.e4:
  br label %b5
b4:
  %v11 = getelementptr i8, ptr %v1, i64 %v8
  %v12 = add i64 0, 0
  %st4 = getelementptr i8, ptr %v11, i64 0
  %st4.b = trunc i64 %v12 to i8
  store i8 %st4.b, ptr %st4
  %v13 = add i64 0, 0
  ret i64 %v13
b5:
  %v14 = getelementptr i8, ptr %v7, i64 %v8
  %v15.p = getelementptr i8, ptr %v14, i64 0
  %v15.b = load i8, ptr %v15.p
  %v15 = zext i8 %v15.b to i64
  %v16 = add i64 0, 0
  %v17.c = icmp eq i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b5 = icmp ne i64 %v17, 0
  br i1 %c.b5, label %b5.t6, label %b5.e7
b5.t6:
  br label %b6
b5.e7:
  br label %b7
b6:
  %v18 = add i64 0, 22
  ret i64 %v18
b7:
  %v19 = getelementptr i8, ptr %v1, i64 %v8
  %st7 = getelementptr i8, ptr %v19, i64 0
  %st7.b = trunc i64 %v15 to i8
  store i8 %st7.b, ptr %st7
  %v20 = add i64 0, 1
  %v21 = add i64 %v8, %v20
  br label %b3
}

define internal i64 @"rt.write_all"(i64 %v0, ptr %v1) #0 {
b0:
  %v2.p = getelementptr i64, ptr %v1, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = inttoptr i64 %v2 to ptr
  %v4.p = getelementptr i64, ptr %v1, i64 1
  %v4 = load i64, ptr %v4.p
  %v6 = add i64 0, 0
  br label %b1
b1:
  %v5 = phi i64 [ %v6, %b0 ], [ %v5, %b4 ], [ %v21, %b7 ]
  %v7 = sub i64 %v4, %v5
  %v8 = add i64 0, 0
  %v9.c = icmp eq i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b1 = icmp ne i64 %v9, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b3
b2:
  %v10 = add i64 0, 0
  ret i64 %v10
b3:
  %v11 = add i64 0, 1
  %v12 = getelementptr i8, ptr %v3, i64 %v5
  %v13 = ptrtoint ptr %v12 to i64
  %v14 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v11, i64 %v0, i64 %v13, i64 %v7)
  %v15 = add i64 0, -4
  %v16.c = icmp eq i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b3 = icmp ne i64 %v16, 0
  br i1 %c.b3, label %b3.t3, label %b3.e4
b3.t3:
  br label %b4
b3.e4:
  br label %b5
b4:
  br label %b1
b5:
  %v17 = add i64 0, 0
  %v18.c = icmp slt i64 %v14, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b5 = icmp ne i64 %v18, 0
  br i1 %c.b5, label %b5.t5, label %b5.e6
b5.t5:
  br label %b6
b5.e6:
  br label %b7
b6:
  %v19 = add i64 0, 0
  %v20 = sub i64 %v19, %v14
  ret i64 %v20
b7:
  %v21 = add i64 %v5, %v14
  br label %b1
}

define internal void @"rt.read_file"(ptr %v0, ptr %v1) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v4.p = getelementptr i64, ptr %v2, i64 0
  %v4 = load i64, ptr %v4.p
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %v62 = getelementptr i64, ptr %v61, i64 %v4
  %v5.p = getelementptr i64, ptr %v62, i64 1
  %v5 = load ptr, ptr %v5.p
  %v6 = ptrtoint ptr %v5 to i64
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v6, ptr %st0
  %v7 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v1, i64 1
  store i64 %v7, ptr %st1
  %st2 = getelementptr i64, ptr %v1, i64 2
  store i64 %v4, ptr %st2
  %v8 = call i64 @"rt.cstr"(ptr %v0, ptr %v3)
  %v9 = add i64 0, 0
  %v10.c = icmp ne i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v11, i64 1027
  store i64 %v8, ptr %st5
  ret void
b2:
  %v12 = add i64 0, 257
  %v13 = add i64 0, -100
  %v14 = ptrtoint ptr %v3 to i64
  %v15 = add i64 0, 524288
  %v16 = add i64 0, 0
  %v17 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v12, i64 %v13, i64 %v14, i64 %v15, i64 %v16)
  %v18 = add i64 0, 0
  %v19.c = icmp slt i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b2 = icmp ne i64 %v19, 0
  br i1 %c.b2, label %b2.t7, label %b2.e8
b2.t7:
  br label %b3
b2.e8:
  br label %b4
b3:
  %v20 = add i64 0, 0
  %v21 = sub i64 %v20, %v17
  %v22 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v22, i64 1027
  store i64 %v21, ptr %st8
  ret void
b4:
  br label %b5
b5:
  %v24.p = getelementptr i64, ptr %v1, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v1, i64 1
  %v25 = load i64, ptr %v25.p
  %v26 = add i64 %v24, %v25
  %v27.p = getelementptr i64, ptr %v2, i64 1029
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 0, 1
  %v29 = add i64 %v4, %v28
  %v30.p = getelementptr i64, ptr %v2, i64 1030
  %v30 = load i64, ptr %v30.p
  %v31 = mul i64 %v29, %v30
  %v32 = add i64 %v27, %v31
  %v33 = sub i64 %v32, %v26
  %v35 = add i64 0, 1048576
  %v36.c = icmp slt i64 %v33, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b5 = icmp ne i64 %v36, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b9
b5.e11:
  br label %b8
b6:
  %v23 = phi i64 [ %v51, %b15 ], [ %v55, %b17 ]
  %v58 = add i64 0, 3
  %v59 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v58, i64 %v17)
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v60, i64 1027
  store i64 %v23, ptr %st11
  ret void
b7:
  %v34 = phi i64 [ %v40, %b8 ], [ %v39, %b9 ]
  call void @"rt.extend8"(i64 %v4, i64 %v26, i64 %v34)
  %v41 = add i64 0, 0
  %v42 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v41, i64 %v17, i64 %v26, i64 %v34)
  %v44 = add i64 0, 0
  %v45.c = icmp sgt i64 %v42, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b7 = icmp ne i64 %v45, 0
  br i1 %c.b7, label %b7.t13, label %b7.e14
b7.t13:
  br label %b11
b7.e14:
  br label %b12
b8:
  %v40 = add i64 0, 1048576
  br label %b7
b9:
  %v37 = add i64 0, 0
  %v38.c = icmp eq i64 %v33, %v37
  %v38 = zext i1 %v38.c to i64
  %v39 = add i64 %v33, %v38
  br label %b7
b10:
  %v43 = phi i64 [ %v42, %b11 ], [ %v46, %b12 ]
  call void @"rt.extend8"(i64 %v4, i64 %v26, i64 %v43)
  %v47 = add i64 0, -4
  %v48.c = icmp eq i64 %v42, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b10 = icmp ne i64 %v48, 0
  br i1 %c.b10, label %b10.t15, label %b10.e16
b10.t15:
  br label %b13
b10.e16:
  br label %b14
b11:
  br label %b10
b12:
  %v46 = add i64 0, 0
  br label %b10
b13:
  br label %b5
b14:
  %v49 = add i64 0, 0
  %v50.c = icmp eq i64 %v42, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b14 = icmp ne i64 %v50, 0
  br i1 %c.b14, label %b14.t17, label %b14.e18
b14.t17:
  br label %b15
b14.e18:
  br label %b16
b15:
  %v51 = add i64 0, 0
  br label %b6
b16:
  %v52 = add i64 0, 0
  %v53.c = icmp slt i64 %v42, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b16 = icmp ne i64 %v53, 0
  br i1 %c.b16, label %b16.t19, label %b16.e20
b16.t19:
  br label %b17
b16.e20:
  br label %b18
b17:
  %v54 = add i64 0, 0
  %v55 = sub i64 %v54, %v42
  br label %b6
b18:
  %v56.p = getelementptr i64, ptr %v1, i64 1
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 %v56, %v42
  %st20 = getelementptr i64, ptr %v1, i64 1
  store i64 %v57, ptr %st20
  br label %b5
}

define internal i64 @"rt.write_file"(ptr %v0, ptr %v1) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v3 = call i64 @"rt.cstr"(ptr %v0, ptr %v2)
  %v4 = add i64 0, 0
  %v5.c = icmp ne i64 %v3, %v4
  %v5 = zext i1 %v5.c to i64
  %c.b0 = icmp ne i64 %v5, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v6, i64 1027
  store i64 %v3, ptr %st2
  ret i64 %v3
b2:
  %v7 = add i64 0, 257
  %v8 = add i64 0, -100
  %v9 = ptrtoint ptr %v2 to i64
  %v10 = add i64 0, 524865
  %v11 = add i64 0, 420
  %v12 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11)
  %v13 = add i64 0, 0
  %v14.c = icmp slt i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b2 = icmp ne i64 %v14, 0
  br i1 %c.b2, label %b2.t4, label %b2.e5
b2.t4:
  br label %b3
b2.e5:
  br label %b4
b3:
  %v15 = add i64 0, 0
  %v16 = sub i64 %v15, %v12
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v17, i64 1027
  store i64 %v16, ptr %st5
  ret i64 %v16
b4:
  %v18 = call i64 @"rt.write_all"(i64 %v12, ptr %v1)
  %v19 = add i64 0, 3
  %v20 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v19, i64 %v12)
  %v22 = add i64 0, 0
  %v23.c = icmp slt i64 %v20, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b4 = icmp ne i64 %v23, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b6
b4.e8:
  br label %b5
b5:
  %v21 = phi i64 [ %v18, %b4.e8 ], [ %v18, %b6.t10 ], [ %v27, %b7 ]
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v28, i64 1027
  store i64 %v21, ptr %st8
  ret i64 %v21
b6:
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v18, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b6 = icmp ne i64 %v25, 0
  br i1 %c.b6, label %b6.t10, label %b6.e11
b6.t10:
  br label %b5
b6.e11:
  br label %b7
b7:
  %v26 = add i64 0, 0
  %v27 = sub i64 %v26, %v20
  br label %b5
}

define internal void @"rt.read_args"(ptr %v0) #0 {
b0:
  %v1 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v1, i64 0
  %v2 = load i64, ptr %v2.p
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42 = getelementptr i64, ptr %v41, i64 %v2
  %v3.p = getelementptr i64, ptr %v42, i64 1
  %v3 = load ptr, ptr %v3.p
  %v4 = ptrtoint ptr %v3 to i64
  %st0 = getelementptr i64, ptr %v0, i64 0
  store i64 %v4, ptr %st0
  %v5 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v0, i64 1
  store i64 %v5, ptr %st1
  %st2 = getelementptr i64, ptr %v0, i64 2
  store i64 %v2, ptr %st2
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2568
  %v7 = load i64, ptr %v7.p
  %v8 = inttoptr i64 %v7 to ptr
  %v9.p = getelementptr i64, ptr %v8, i64 0
  %v9 = load i64, ptr %v9.p
  %v11 = add i64 0, 0
  br label %b1
b1:
  %v10 = phi i64 [ %v11, %b0 ], [ %v40, %b6 ]
  %v12.c = icmp slt i64 %v10, %v9
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t4, label %b1.e5
b1.t4:
  br label %b2
b1.e5:
  br label %b3
b2:
  %v13 = add i64 0, 1
  %v14 = add i64 %v10, %v13
  %v15 = getelementptr i64, ptr %v8, i64 %v14
  %v16.p = getelementptr i64, ptr %v15, i64 0
  %v16 = load i64, ptr %v16.p
  %v17 = inttoptr i64 %v16 to ptr
  %v20 = add i64 0, 0
  br label %b4
b3:
  ret void
b4:
  %v18 = phi i64 [ %v20, %b2 ], [ %v26, %b5 ]
  %v21 = getelementptr i8, ptr %v17, i64 %v18
  %v22.p = getelementptr i8, ptr %v21, i64 0
  %v22.b = load i8, ptr %v22.p
  %v22 = zext i8 %v22.b to i64
  %v23 = add i64 0, 0
  %v24.c = icmp eq i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b4 = icmp ne i64 %v24, 0
  br i1 %c.b4, label %b4.t6, label %b4.e7
b4.t6:
  br label %b6
b4.e7:
  br label %b5
b5:
  %v25 = add i64 0, 1
  %v26 = add i64 %v18, %v25
  br label %b4
b6:
  %v19 = phi i64 [ %v18, %b4.t6 ]
  %v27.p = getelementptr i64, ptr %v0, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v0, i64 1
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 %v27, %v28
  %v30 = add i64 0, 1
  %v31 = add i64 %v19, %v30
  call void @"rt.extend8"(i64 %v2, i64 %v29, i64 %v31)
  %v32 = inttoptr i64 %v29 to ptr
  call void @"rt.copy8"(ptr %v32, ptr %v17, i64 %v19)
  %v33 = getelementptr i8, ptr %v32, i64 %v19
  %v34 = add i64 0, 0
  %st7 = getelementptr i8, ptr %v33, i64 0
  %st7.b = trunc i64 %v34 to i8
  store i8 %st7.b, ptr %st7
  %v35.p = getelementptr i64, ptr %v0, i64 1
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 1
  %v37 = add i64 %v19, %v36
  %v38 = add i64 %v35, %v37
  %st8 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st8
  %v39 = add i64 0, 1
  %v40 = add i64 %v10, %v39
  br label %b1
}

define internal void @"rt.read_dir"(ptr %v0, ptr %v1) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 0
  %v4 = load i64, ptr %v4.p
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %v79 = getelementptr i64, ptr %v78, i64 %v4
  %v5.p = getelementptr i64, ptr %v79, i64 1
  %v5 = load ptr, ptr %v5.p
  %v6 = ptrtoint ptr %v5 to i64
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v6, ptr %st0
  %v7 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v1, i64 1
  store i64 %v7, ptr %st1
  %st2 = getelementptr i64, ptr %v1, i64 2
  store i64 %v4, ptr %st2
  %v8 = call i64 @"rt.cstr"(ptr %v0, ptr %v2)
  %v9 = add i64 0, 0
  %v10.c = icmp ne i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v11, i64 1027
  store i64 %v8, ptr %st5
  ret void
b2:
  %v12 = add i64 0, 257
  %v13 = add i64 0, -100
  %v14 = ptrtoint ptr %v2 to i64
  %v15 = add i64 0, 589824
  %v16 = add i64 0, 0
  %v17 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v12, i64 %v13, i64 %v14, i64 %v15, i64 %v16)
  %v18 = add i64 0, 0
  %v19.c = icmp slt i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b2 = icmp ne i64 %v19, 0
  br i1 %c.b2, label %b2.t7, label %b2.e8
b2.t7:
  br label %b3
b2.e8:
  br label %b4
b3:
  %v20 = add i64 0, 0
  %v21 = sub i64 %v20, %v17
  %v22 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v22, i64 1027
  store i64 %v21, ptr %st8
  ret void
b4:
  br label %b5
b5:
  %v24 = add i64 0, 217
  %v25 = ptrtoint ptr %v2 to i64
  %v26 = add i64 0, 4096
  %v27 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v24, i64 %v17, i64 %v25, i64 %v26)
  %v28 = add i64 0, -4
  %v29.c = icmp eq i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b5 = icmp ne i64 %v29, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  %v23 = phi i64 [ %v32, %b9 ], [ %v36, %b11 ]
  %v75 = add i64 0, 3
  %v76 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v75, i64 %v17)
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v77, i64 1027
  store i64 %v23, ptr %st11
  ret void
b7:
  br label %b5
b8:
  %v30 = add i64 0, 0
  %v31.c = icmp eq i64 %v27, %v30
  %v31 = zext i1 %v31.c to i64
  %c.b8 = icmp ne i64 %v31, 0
  br i1 %c.b8, label %b8.t13, label %b8.e14
b8.t13:
  br label %b9
b8.e14:
  br label %b10
b9:
  %v32 = add i64 0, 0
  br label %b6
b10:
  %v33 = add i64 0, 0
  %v34.c = icmp slt i64 %v27, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b10 = icmp ne i64 %v34, 0
  br i1 %c.b10, label %b10.t15, label %b10.e16
b10.t15:
  br label %b11
b10.e16:
  br label %b12
b11:
  %v35 = add i64 0, 0
  %v36 = sub i64 %v35, %v27
  br label %b6
b12:
  %v38 = add i64 0, 0
  br label %b13
b13:
  %v37 = phi i64 [ %v38, %b12 ], [ %v74, %b17 ]
  %v39.c = icmp slt i64 %v37, %v27
  %v39 = zext i1 %v39.c to i64
  %c.b13 = icmp ne i64 %v39, 0
  br i1 %c.b13, label %b13.t17, label %b13.e18
b13.t17:
  br label %b14
b13.e18:
  br label %b5
b14:
  %v40 = getelementptr i8, ptr %v2, i64 %v37
  %v41.p = getelementptr i8, ptr %v40, i64 16
  %v41.b = load i8, ptr %v41.p
  %v41 = zext i8 %v41.b to i64
  %v42.p = getelementptr i8, ptr %v40, i64 17
  %v42.b = load i8, ptr %v42.p
  %v42 = zext i8 %v42.b to i64
  %v43 = add i64 0, 8
  %v44.n = and i64 %v43, 63
  %v44 = shl i64 %v42, %v44.n
  %v45 = or i64 %v41, %v44
  %v46 = add i64 0, 19
  %v47 = getelementptr i8, ptr %v40, i64 %v46
  %v50 = add i64 0, 0
  br label %b15
b15:
  %v48 = phi i64 [ %v50, %b14 ], [ %v56, %b16 ]
  %v51 = getelementptr i8, ptr %v47, i64 %v48
  %v52.p = getelementptr i8, ptr %v51, i64 0
  %v52.b = load i8, ptr %v52.p
  %v52 = zext i8 %v52.b to i64
  %v53 = add i64 0, 0
  %v54.c = icmp eq i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b15 = icmp ne i64 %v54, 0
  br i1 %c.b15, label %b15.t19, label %b15.e20
b15.t19:
  br label %b17
b15.e20:
  br label %b16
b16:
  %v55 = add i64 0, 1
  %v56 = add i64 %v48, %v55
  br label %b15
b17:
  %v49 = phi i64 [ %v48, %b15.t19 ]
  %v57.p = getelementptr i64, ptr %v1, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v1, i64 1
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 %v57, %v58
  %v60 = add i64 0, 2
  %v61 = add i64 %v49, %v60
  call void @"rt.extend8"(i64 %v4, i64 %v59, i64 %v61)
  %v62 = inttoptr i64 %v59 to ptr
  %v63.p = getelementptr i8, ptr %v40, i64 18
  %v63.b = load i8, ptr %v63.p
  %v63 = zext i8 %v63.b to i64
  %st20 = getelementptr i8, ptr %v62, i64 0
  %st20.b = trunc i64 %v63 to i8
  store i8 %st20.b, ptr %st20
  %v64 = add i64 0, 1
  %v65 = getelementptr i8, ptr %v62, i64 %v64
  call void @"rt.copy8"(ptr %v65, ptr %v47, i64 %v49)
  %v66 = add i64 0, 1
  %v67 = add i64 %v49, %v66
  %v68 = getelementptr i8, ptr %v62, i64 %v67
  %v69 = add i64 0, 0
  %st21 = getelementptr i8, ptr %v68, i64 0
  %st21.b = trunc i64 %v69 to i8
  store i8 %st21.b, ptr %st21
  %v70.p = getelementptr i64, ptr %v1, i64 1
  %v70 = load i64, ptr %v70.p
  %v71 = add i64 0, 2
  %v72 = add i64 %v49, %v71
  %v73 = add i64 %v70, %v72
  %st22 = getelementptr i64, ptr %v1, i64 1
  store i64 %v73, ptr %st22
  %v74 = add i64 %v37, %v45
  br label %b13
}

define internal i64 @"rt.write_fd"(i64 %v0, ptr %v1) #0 {
b0:
  call void @"rt.flush"()
  %v2 = call i64 @"rt.write_all"(i64 %v0, ptr %v1)
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v3, i64 1027
  store i64 %v2, ptr %st0
  ret i64 %v2
}

define internal void @"main.main"() #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s2 = alloca [6 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s2.z5 = getelementptr i64, ptr %s2, i64 5
  store i64 0, ptr %s2.z5
  %s3 = alloca [6 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s3.z3 = getelementptr i64, ptr %s3, i64 3
  store i64 0, ptr %s3.z3
  %s3.z4 = getelementptr i64, ptr %s3, i64 4
  store i64 0, ptr %s3.z4
  %s3.z5 = getelementptr i64, ptr %s3, i64 5
  store i64 0, ptr %s3.z5
  %s4 = alloca [6 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s4.z3 = getelementptr i64, ptr %s4, i64 3
  store i64 0, ptr %s4.z3
  %s4.z4 = getelementptr i64, ptr %s4, i64 4
  store i64 0, ptr %s4.z4
  %s4.z5 = getelementptr i64, ptr %s4, i64 5
  store i64 0, ptr %s4.z5
  %s5 = alloca [6 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s5.z3 = getelementptr i64, ptr %s5, i64 3
  store i64 0, ptr %s5.z3
  %s5.z4 = getelementptr i64, ptr %s5, i64 4
  store i64 0, ptr %s5.z4
  %s5.z5 = getelementptr i64, ptr %s5, i64 5
  store i64 0, ptr %s5.z5
  %s6 = alloca [6 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s6.z3 = getelementptr i64, ptr %s6, i64 3
  store i64 0, ptr %s6.z3
  %s6.z4 = getelementptr i64, ptr %s6, i64 4
  store i64 0, ptr %s6.z4
  %s6.z5 = getelementptr i64, ptr %s6, i64 5
  store i64 0, ptr %s6.z5
  %s7 = alloca [6 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s7.z3 = getelementptr i64, ptr %s7, i64 3
  store i64 0, ptr %s7.z3
  %s7.z4 = getelementptr i64, ptr %s7, i64 4
  store i64 0, ptr %s7.z4
  %s7.z5 = getelementptr i64, ptr %s7, i64 5
  store i64 0, ptr %s7.z5
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v58, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v59, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = add i64 0, 0
  %v3 = add i64 0, 3
  %v4 = getelementptr i64, ptr %s0, i64 0
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v60, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr %s1, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v2, ptr %st0
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v61, i64 0
  %v7 = load i64, ptr %v7.p
  br label %b3
b1:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v62, i64 0
  store i64 %v1, ptr %st1
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v63, i64 0
  store i64 %v0, ptr %st2
  ret void
b2:
  br label %b1
b3:
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v64, i64 0
  store i64 %v7, ptr %st3
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %v9.c = icmp slt i64 %v8, %v3
  %v9 = zext i1 %v9.c to i64
  %c.b3 = icmp ne i64 %v9, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b4
b3.e6:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v65 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v65, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v6, i64 0
  %v11 = load i64, ptr %v11.p
  %v66 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v66, i64 0
  %v12 = load i64, ptr %v12.p
  %v13 = getelementptr i64, ptr %s2, i64 0
  call void @"main.open"(ptr %v13, i64 %v11)
  %v14.p = getelementptr i64, ptr %v13, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v13, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.p = getelementptr i64, ptr %v13, i64 2
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v13, i64 3
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v13, i64 4
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v13, i64 5
  %v19 = load i64, ptr %v19.p
  call void @"main.show"(i64 %v14, i64 %v15, i64 %v16, i64 %v17, i64 %v18, i64 %v19)
  %v20 = getelementptr i64, ptr %s3, i64 0
  call void @"main.open"(ptr %v20, i64 %v11)
  %v21.p = getelementptr i64, ptr %v20, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v20, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v20, i64 2
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v20, i64 3
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v20, i64 4
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v20, i64 5
  %v26 = load i64, ptr %v26.p
  call void @"main.show2"(i64 %v21, i64 %v22, i64 %v23, i64 %v24, i64 %v25, i64 %v26)
  %v27 = getelementptr i64, ptr %s4, i64 0
  call void @"main.load"(ptr %v27, i64 %v11)
  %v28.p = getelementptr i64, ptr %v27, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v27, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v27, i64 2
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v27, i64 3
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v27, i64 4
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v27, i64 5
  %v33 = load i64, ptr %v33.p
  call void @"main.show"(i64 %v28, i64 %v29, i64 %v30, i64 %v31, i64 %v32, i64 %v33)
  %v34 = getelementptr i64, ptr %s5, i64 0
  call void @"main.load"(ptr %v34, i64 %v11)
  %v35.p = getelementptr i64, ptr %v34, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v34, i64 1
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v34, i64 2
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v34, i64 3
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v34, i64 4
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v34, i64 5
  %v40 = load i64, ptr %v40.p
  call void @"main.show2"(i64 %v35, i64 %v36, i64 %v37, i64 %v38, i64 %v39, i64 %v40)
  %v41 = getelementptr i64, ptr %s6, i64 0
  call void @"main.twice"(ptr %v41, i64 %v11)
  %v42.p = getelementptr i64, ptr %v41, i64 0
  %v42 = load i64, ptr %v42.p
  %v43.p = getelementptr i64, ptr %v41, i64 1
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v41, i64 2
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v41, i64 3
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v41, i64 4
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v41, i64 5
  %v47 = load i64, ptr %v47.p
  call void @"main.show"(i64 %v42, i64 %v43, i64 %v44, i64 %v45, i64 %v46, i64 %v47)
  %v48 = getelementptr i64, ptr %s7, i64 0
  call void @"main.twice"(ptr %v48, i64 %v11)
  %v49.p = getelementptr i64, ptr %v48, i64 0
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v48, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.p = getelementptr i64, ptr %v48, i64 2
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v48, i64 3
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v48, i64 4
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v48, i64 5
  %v54 = load i64, ptr %v54.p
  call void @"main.show2"(i64 %v49, i64 %v50, i64 %v51, i64 %v52, i64 %v53, i64 %v54)
  br label %b6
b5:
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v67, i64 0
  store i64 %v7, ptr %st6
  br label %b2
b6:
  %v68 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v68, i64 0
  store i64 %v12, ptr %st7
  %v55 = add i64 0, 1
  %v56.p = getelementptr i64, ptr %v6, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 %v56, %v55
  %st8 = getelementptr i64, ptr %v6, i64 0
  store i64 %v57, ptr %st8
  br label %b3
}

define void @"sober_entry"(ptr %v0) #0 {
b0:
  %v1 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v0, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = add i64 0, 2
  %v4 = add i64 %v2, %v3
  %v5 = getelementptr i64, ptr %v0, i64 %v4
  br label %b1
b1:
  %v6 = phi ptr [ %v5, %b0 ], [ %v94, %b4 ]
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp eq i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %v11 = add i64 0, 4096
  %c.b1 = icmp ne i64 %v10, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b5
b2:
  %v7 = phi i64 [ %v11, %b1.t1 ], [ %v101, %b23.e38 ], [ %v101, %b24.e40 ], [ %v101, %b25.e42 ], [ %v101, %b26.t43 ], [ %v95, %b27 ]
  br label %b29
b3:
  %v97 = add i64 0, 0
  %v98 = add i64 0, 16
  br label %b22
b4:
  %v93 = add i64 0, 1
  %v94 = getelementptr i64, ptr %v6, i64 %v93
  br label %b1
b5:
  %v12 = inttoptr i64 %v8 to ptr
  %v13 = add i64 0, 0
  %v14 = getelementptr i8, ptr %v12, i64 %v13
  %v15.p = getelementptr i8, ptr %v14, i64 0
  %v15.b = load i8, ptr %v15.p
  %v15 = zext i8 %v15.b to i64
  %v16 = add i64 0, 83
  %v17.c = icmp eq i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b5 = icmp ne i64 %v17, 0
  br i1 %c.b5, label %b5.t3, label %b5.e4
b5.t3:
  br label %b6
b5.e4:
  br label %b4
b6:
  %v18 = add i64 0, 1
  %v19 = getelementptr i8, ptr %v12, i64 %v18
  %v20.p = getelementptr i8, ptr %v19, i64 0
  %v20.b = load i8, ptr %v20.p
  %v20 = zext i8 %v20.b to i64
  %v21 = add i64 0, 79
  %v22.c = icmp eq i64 %v20, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b6 = icmp ne i64 %v22, 0
  br i1 %c.b6, label %b6.t5, label %b6.e6
b6.t5:
  br label %b7
b6.e6:
  br label %b4
b7:
  %v23 = add i64 0, 2
  %v24 = getelementptr i8, ptr %v12, i64 %v23
  %v25.p = getelementptr i8, ptr %v24, i64 0
  %v25.b = load i8, ptr %v25.p
  %v25 = zext i8 %v25.b to i64
  %v26 = add i64 0, 66
  %v27.c = icmp eq i64 %v25, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b7 = icmp ne i64 %v27, 0
  br i1 %c.b7, label %b7.t7, label %b7.e8
b7.t7:
  br label %b8
b7.e8:
  br label %b4
b8:
  %v28 = add i64 0, 3
  %v29 = getelementptr i8, ptr %v12, i64 %v28
  %v30.p = getelementptr i8, ptr %v29, i64 0
  %v30.b = load i8, ptr %v30.p
  %v30 = zext i8 %v30.b to i64
  %v31 = add i64 0, 69
  %v32.c = icmp eq i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b8 = icmp ne i64 %v32, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b9
b8.e10:
  br label %b4
b9:
  %v33 = add i64 0, 4
  %v34 = getelementptr i8, ptr %v12, i64 %v33
  %v35.p = getelementptr i8, ptr %v34, i64 0
  %v35.b = load i8, ptr %v35.p
  %v35 = zext i8 %v35.b to i64
  %v36 = add i64 0, 82
  %v37.c = icmp eq i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b9 = icmp ne i64 %v37, 0
  br i1 %c.b9, label %b9.t11, label %b9.e12
b9.t11:
  br label %b10
b9.e12:
  br label %b4
b10:
  %v38 = add i64 0, 5
  %v39 = getelementptr i8, ptr %v12, i64 %v38
  %v40.p = getelementptr i8, ptr %v39, i64 0
  %v40.b = load i8, ptr %v40.p
  %v40 = zext i8 %v40.b to i64
  %v41 = add i64 0, 95
  %v42.c = icmp eq i64 %v40, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b10 = icmp ne i64 %v42, 0
  br i1 %c.b10, label %b10.t13, label %b10.e14
b10.t13:
  br label %b11
b10.e14:
  br label %b4
b11:
  %v43 = add i64 0, 6
  %v44 = getelementptr i8, ptr %v12, i64 %v43
  %v45.p = getelementptr i8, ptr %v44, i64 0
  %v45.b = load i8, ptr %v45.p
  %v45 = zext i8 %v45.b to i64
  %v46 = add i64 0, 82
  %v47.c = icmp eq i64 %v45, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b11 = icmp ne i64 %v47, 0
  br i1 %c.b11, label %b11.t15, label %b11.e16
b11.t15:
  br label %b12
b11.e16:
  br label %b4
b12:
  %v48 = add i64 0, 7
  %v49 = getelementptr i8, ptr %v12, i64 %v48
  %v50.p = getelementptr i8, ptr %v49, i64 0
  %v50.b = load i8, ptr %v50.p
  %v50 = zext i8 %v50.b to i64
  %v51 = add i64 0, 69
  %v52.c = icmp eq i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b12 = icmp ne i64 %v52, 0
  br i1 %c.b12, label %b12.t17, label %b12.e18
b12.t17:
  br label %b13
b12.e18:
  br label %b4
b13:
  %v53 = add i64 0, 8
  %v54 = getelementptr i8, ptr %v12, i64 %v53
  %v55.p = getelementptr i8, ptr %v54, i64 0
  %v55.b = load i8, ptr %v55.p
  %v55 = zext i8 %v55.b to i64
  %v56 = add i64 0, 71
  %v57.c = icmp eq i64 %v55, %v56
  %v57 = zext i1 %v57.c to i64
  %c.b13 = icmp ne i64 %v57, 0
  br i1 %c.b13, label %b13.t19, label %b13.e20
b13.t19:
  br label %b14
b13.e20:
  br label %b4
b14:
  %v58 = add i64 0, 9
  %v59 = getelementptr i8, ptr %v12, i64 %v58
  %v60.p = getelementptr i8, ptr %v59, i64 0
  %v60.b = load i8, ptr %v60.p
  %v60 = zext i8 %v60.b to i64
  %v61 = add i64 0, 73
  %v62.c = icmp eq i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b14 = icmp ne i64 %v62, 0
  br i1 %c.b14, label %b14.t21, label %b14.e22
b14.t21:
  br label %b15
b14.e22:
  br label %b4
b15:
  %v63 = add i64 0, 10
  %v64 = getelementptr i8, ptr %v12, i64 %v63
  %v65.p = getelementptr i8, ptr %v64, i64 0
  %v65.b = load i8, ptr %v65.p
  %v65 = zext i8 %v65.b to i64
  %v66 = add i64 0, 79
  %v67.c = icmp eq i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b15 = icmp ne i64 %v67, 0
  br i1 %c.b15, label %b15.t23, label %b15.e24
b15.t23:
  br label %b16
b15.e24:
  br label %b4
b16:
  %v68 = add i64 0, 11
  %v69 = getelementptr i8, ptr %v12, i64 %v68
  %v70.p = getelementptr i8, ptr %v69, i64 0
  %v70.b = load i8, ptr %v70.p
  %v70 = zext i8 %v70.b to i64
  %v71 = add i64 0, 78
  %v72.c = icmp eq i64 %v70, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b16 = icmp ne i64 %v72, 0
  br i1 %c.b16, label %b16.t25, label %b16.e26
b16.t25:
  br label %b17
b16.e26:
  br label %b4
b17:
  %v73 = add i64 0, 12
  %v74 = getelementptr i8, ptr %v12, i64 %v73
  %v75.p = getelementptr i8, ptr %v74, i64 0
  %v75.b = load i8, ptr %v75.p
  %v75 = zext i8 %v75.b to i64
  %v76 = add i64 0, 95
  %v77.c = icmp eq i64 %v75, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b17 = icmp ne i64 %v77, 0
  br i1 %c.b17, label %b17.t27, label %b17.e28
b17.t27:
  br label %b18
b17.e28:
  br label %b4
b18:
  %v78 = add i64 0, 13
  %v79 = getelementptr i8, ptr %v12, i64 %v78
  %v80.p = getelementptr i8, ptr %v79, i64 0
  %v80.b = load i8, ptr %v80.p
  %v80 = zext i8 %v80.b to i64
  %v81 = add i64 0, 77
  %v82.c = icmp eq i64 %v80, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b18 = icmp ne i64 %v82, 0
  br i1 %c.b18, label %b18.t29, label %b18.e30
b18.t29:
  br label %b19
b18.e30:
  br label %b4
b19:
  %v83 = add i64 0, 14
  %v84 = getelementptr i8, ptr %v12, i64 %v83
  %v85.p = getelementptr i8, ptr %v84, i64 0
  %v85.b = load i8, ptr %v85.p
  %v85 = zext i8 %v85.b to i64
  %v86 = add i64 0, 66
  %v87.c = icmp eq i64 %v85, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b19 = icmp ne i64 %v87, 0
  br i1 %c.b19, label %b19.t31, label %b19.e32
b19.t31:
  br label %b20
b19.e32:
  br label %b4
b20:
  %v88 = add i64 0, 15
  %v89 = getelementptr i8, ptr %v12, i64 %v88
  %v90.p = getelementptr i8, ptr %v89, i64 0
  %v90.b = load i8, ptr %v90.p
  %v90 = zext i8 %v90.b to i64
  %v91 = add i64 0, 61
  %v92.c = icmp eq i64 %v90, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b20 = icmp ne i64 %v92, 0
  br i1 %c.b20, label %b20.t33, label %b20.e34
b20.t33:
  br label %b21
b20.e34:
  br label %b4
b21:
  br label %b3
b22:
  %v95 = phi i64 [ %v97, %b3 ], [ %v114, %b28 ]
  %v96 = phi i64 [ %v98, %b3 ], [ %v118, %b28 ]
  %v99 = getelementptr i8, ptr %v12, i64 %v96
  %v100.p = getelementptr i8, ptr %v99, i64 0
  %v100.b = load i8, ptr %v100.p
  %v100 = zext i8 %v100.b to i64
  %v101 = add i64 0, 4096
  %v102 = add i64 0, 0
  %v103.c = icmp eq i64 %v100, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b22 = icmp ne i64 %v103, 0
  br i1 %c.b22, label %b22.t35, label %b22.e36
b22.t35:
  br label %b23
b22.e36:
  br label %b24
b23:
  %v104 = add i64 0, 0
  %v105.c = icmp sgt i64 %v95, %v104
  %v105 = zext i1 %v105.c to i64
  %c.b23 = icmp ne i64 %v105, 0
  br i1 %c.b23, label %b23.t37, label %b23.e38
b23.t37:
  br label %b27
b23.e38:
  br label %b2
b24:
  %v106 = add i64 0, 48
  %v107.c = icmp sge i64 %v100, %v106
  %v107 = zext i1 %v107.c to i64
  %c.b24 = icmp ne i64 %v107, 0
  br i1 %c.b24, label %b24.t39, label %b24.e40
b24.t39:
  br label %b25
b24.e40:
  br label %b2
b25:
  %v108 = add i64 0, 57
  %v109.c = icmp sle i64 %v100, %v108
  %v109 = zext i1 %v109.c to i64
  %c.b25 = icmp ne i64 %v109, 0
  br i1 %c.b25, label %b25.t41, label %b25.e42
b25.t41:
  br label %b26
b25.e42:
  br label %b2
b26:
  %v110 = add i64 0, 10
  %v111 = mul i64 %v95, %v110
  %v112 = add i64 0, 48
  %v113 = sub i64 %v100, %v112
  %v114 = add i64 %v111, %v113
  %v115 = add i64 0, 65536
  %v116.c = icmp sgt i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b26 = icmp ne i64 %v116, 0
  br i1 %c.b26, label %b26.t43, label %b26.e44
b26.t43:
  br label %b2
b26.e44:
  br label %b28
b27:
  br label %b2
b28:
  %v117 = add i64 0, 1
  %v118 = add i64 %v96, %v117
  br label %b22
b29:
  %v119 = phi i64 [ %v7, %b2 ], [ %v136, %b30.t47 ]
  %v120 = add i64 0, 20
  %v121.n = and i64 %v120, 63
  %v121 = shl i64 %v119, %v121.n
  %v122 = add i64 0, 9
  %v123 = add i64 0, 0
  %v124 = add i64 0, 1024
  %v125 = mul i64 %v121, %v124
  %v126 = add i64 0, 3
  %v127 = add i64 0, 16418
  %v128 = add i64 0, -1
  %v129 = add i64 0, 0
  %v130 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v122, i64 %v123, i64 %v125, i64 %v126, i64 %v127, i64 %v128, i64 %v129)
  %v131 = add i64 0, -4095
  %v132.c = icmp uge i64 %v130, %v131
  %v132 = zext i1 %v132.c to i64
  %c.b29 = icmp ne i64 %v132, 0
  br i1 %c.b29, label %b29.t45, label %b29.e46
b29.t45:
  br label %b30
b29.e46:
  br label %b32
b30:
  %v133 = add i64 0, 1
  %v134.c = icmp sgt i64 %v119, %v133
  %v134 = zext i1 %v134.c to i64
  %v135 = add i64 0, 1
  %v136.n = and i64 %v135, 63
  %v136 = ashr i64 %v119, %v136.n
  %c.b30 = icmp ne i64 %v134, 0
  br i1 %c.b30, label %b30.t47, label %b30.e48
b30.t47:
  br label %b29
b30.e48:
  br label %b31
b31:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b32:
  %v137 = add i64 0, 28
  %v138 = add i64 0, 15
  %v139 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v137, i64 %v130, i64 %v125, i64 %v138)
  %st48 = getelementptr i64, ptr %v1, i64 1029
  store i64 %v130, ptr %st48
  %st49 = getelementptr i64, ptr %v1, i64 1030
  store i64 %v121, ptr %st49
  %v140 = add i64 0, 0
  %st50 = getelementptr i64, ptr %v1, i64 0
  store i64 %v140, ptr %st50
  %v141 = add i64 0, 1
  %st51 = getelementptr i64, ptr %v1, i64 1026
  store i64 %v141, ptr %st51
  %v142 = ptrtoint ptr %v0 to i64
  %st52 = getelementptr i64, ptr %v1, i64 2568
  store i64 %v142, ptr %st52
  %v143.p = getelementptr i64, ptr %v0, i64 0
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 2
  %v145 = add i64 %v143, %v144
  %v146 = getelementptr i64, ptr %v0, i64 %v145
  br label %b33
b33:
  %v147 = phi ptr [ %v146, %b32 ], [ %v225, %b36 ]
  %v149.p = getelementptr i64, ptr %v147, i64 0
  %v149 = load i64, ptr %v149.p
  %v150 = add i64 0, 0
  %v151.c = icmp eq i64 %v149, %v150
  %v151 = zext i1 %v151.c to i64
  %v152 = add i64 0, 1
  %c.b33 = icmp ne i64 %v151, 0
  br i1 %c.b33, label %b33.t54, label %b33.e55
b33.t54:
  br label %b34
b33.e55:
  br label %b37
b34:
  %v148 = phi i64 [ %v152, %b33.t54 ], [ %v232, %b53.e89 ], [ %v232, %b54.e91 ], [ %v232, %b55.e93 ], [ %v232, %b56.t94 ], [ %v226, %b57 ]
  %v250 = add i64 0, 20
  %v251.n = and i64 %v250, 63
  %v251 = shl i64 %v148, %v251.n
  %st55 = getelementptr i64, ptr %v1, i64 2569
  store i64 %v251, ptr %st55
  %v252 = add i64 0, 0
  %st56 = getelementptr i64, ptr %v1, i64 2570
  store i64 %v252, ptr %st56
  %v253.p = getelementptr i64, ptr %v0, i64 0
  %v253 = load i64, ptr %v253.p
  %v254 = add i64 0, 2
  %v255 = add i64 %v253, %v254
  %v256 = getelementptr i64, ptr %v0, i64 %v255
  br label %b59
b35:
  %v228 = add i64 0, 0
  %v229 = add i64 0, 14
  br label %b52
b36:
  %v224 = add i64 0, 1
  %v225 = getelementptr i64, ptr %v147, i64 %v224
  br label %b33
b37:
  %v153 = inttoptr i64 %v149 to ptr
  %v154 = add i64 0, 0
  %v155 = getelementptr i8, ptr %v153, i64 %v154
  %v156.p = getelementptr i8, ptr %v155, i64 0
  %v156.b = load i8, ptr %v156.p
  %v156 = zext i8 %v156.b to i64
  %v157 = add i64 0, 83
  %v158.c = icmp eq i64 %v156, %v157
  %v158 = zext i1 %v158.c to i64
  %c.b37 = icmp ne i64 %v158, 0
  br i1 %c.b37, label %b37.t58, label %b37.e59
b37.t58:
  br label %b38
b37.e59:
  br label %b36
b38:
  %v159 = add i64 0, 1
  %v160 = getelementptr i8, ptr %v153, i64 %v159
  %v161.p = getelementptr i8, ptr %v160, i64 0
  %v161.b = load i8, ptr %v161.p
  %v161 = zext i8 %v161.b to i64
  %v162 = add i64 0, 79
  %v163.c = icmp eq i64 %v161, %v162
  %v163 = zext i1 %v163.c to i64
  %c.b38 = icmp ne i64 %v163, 0
  br i1 %c.b38, label %b38.t60, label %b38.e61
b38.t60:
  br label %b39
b38.e61:
  br label %b36
b39:
  %v164 = add i64 0, 2
  %v165 = getelementptr i8, ptr %v153, i64 %v164
  %v166.p = getelementptr i8, ptr %v165, i64 0
  %v166.b = load i8, ptr %v166.p
  %v166 = zext i8 %v166.b to i64
  %v167 = add i64 0, 66
  %v168.c = icmp eq i64 %v166, %v167
  %v168 = zext i1 %v168.c to i64
  %c.b39 = icmp ne i64 %v168, 0
  br i1 %c.b39, label %b39.t62, label %b39.e63
b39.t62:
  br label %b40
b39.e63:
  br label %b36
b40:
  %v169 = add i64 0, 3
  %v170 = getelementptr i8, ptr %v153, i64 %v169
  %v171.p = getelementptr i8, ptr %v170, i64 0
  %v171.b = load i8, ptr %v171.p
  %v171 = zext i8 %v171.b to i64
  %v172 = add i64 0, 69
  %v173.c = icmp eq i64 %v171, %v172
  %v173 = zext i1 %v173.c to i64
  %c.b40 = icmp ne i64 %v173, 0
  br i1 %c.b40, label %b40.t64, label %b40.e65
b40.t64:
  br label %b41
b40.e65:
  br label %b36
b41:
  %v174 = add i64 0, 4
  %v175 = getelementptr i8, ptr %v153, i64 %v174
  %v176.p = getelementptr i8, ptr %v175, i64 0
  %v176.b = load i8, ptr %v176.p
  %v176 = zext i8 %v176.b to i64
  %v177 = add i64 0, 82
  %v178.c = icmp eq i64 %v176, %v177
  %v178 = zext i1 %v178.c to i64
  %c.b41 = icmp ne i64 %v178, 0
  br i1 %c.b41, label %b41.t66, label %b41.e67
b41.t66:
  br label %b42
b41.e67:
  br label %b36
b42:
  %v179 = add i64 0, 5
  %v180 = getelementptr i8, ptr %v153, i64 %v179
  %v181.p = getelementptr i8, ptr %v180, i64 0
  %v181.b = load i8, ptr %v181.p
  %v181 = zext i8 %v181.b to i64
  %v182 = add i64 0, 95
  %v183.c = icmp eq i64 %v181, %v182
  %v183 = zext i1 %v183.c to i64
  %c.b42 = icmp ne i64 %v183, 0
  br i1 %c.b42, label %b42.t68, label %b42.e69
b42.t68:
  br label %b43
b42.e69:
  br label %b36
b43:
  %v184 = add i64 0, 6
  %v185 = getelementptr i8, ptr %v153, i64 %v184
  %v186.p = getelementptr i8, ptr %v185, i64 0
  %v186.b = load i8, ptr %v186.p
  %v186 = zext i8 %v186.b to i64
  %v187 = add i64 0, 77
  %v188.c = icmp eq i64 %v186, %v187
  %v188 = zext i1 %v188.c to i64
  %c.b43 = icmp ne i64 %v188, 0
  br i1 %c.b43, label %b43.t70, label %b43.e71
b43.t70:
  br label %b44
b43.e71:
  br label %b36
b44:
  %v189 = add i64 0, 7
  %v190 = getelementptr i8, ptr %v153, i64 %v189
  %v191.p = getelementptr i8, ptr %v190, i64 0
  %v191.b = load i8, ptr %v191.p
  %v191 = zext i8 %v191.b to i64
  %v192 = add i64 0, 65
  %v193.c = icmp eq i64 %v191, %v192
  %v193 = zext i1 %v193.c to i64
  %c.b44 = icmp ne i64 %v193, 0
  br i1 %c.b44, label %b44.t72, label %b44.e73
b44.t72:
  br label %b45
b44.e73:
  br label %b36
b45:
  %v194 = add i64 0, 8
  %v195 = getelementptr i8, ptr %v153, i64 %v194
  %v196.p = getelementptr i8, ptr %v195, i64 0
  %v196.b = load i8, ptr %v196.p
  %v196 = zext i8 %v196.b to i64
  %v197 = add i64 0, 68
  %v198.c = icmp eq i64 %v196, %v197
  %v198 = zext i1 %v198.c to i64
  %c.b45 = icmp ne i64 %v198, 0
  br i1 %c.b45, label %b45.t74, label %b45.e75
b45.t74:
  br label %b46
b45.e75:
  br label %b36
b46:
  %v199 = add i64 0, 9
  %v200 = getelementptr i8, ptr %v153, i64 %v199
  %v201.p = getelementptr i8, ptr %v200, i64 0
  %v201.b = load i8, ptr %v201.p
  %v201 = zext i8 %v201.b to i64
  %v202 = add i64 0, 86
  %v203.c = icmp eq i64 %v201, %v202
  %v203 = zext i1 %v203.c to i64
  %c.b46 = icmp ne i64 %v203, 0
  br i1 %c.b46, label %b46.t76, label %b46.e77
b46.t76:
  br label %b47
b46.e77:
  br label %b36
b47:
  %v204 = add i64 0, 10
  %v205 = getelementptr i8, ptr %v153, i64 %v204
  %v206.p = getelementptr i8, ptr %v205, i64 0
  %v206.b = load i8, ptr %v206.p
  %v206 = zext i8 %v206.b to i64
  %v207 = add i64 0, 95
  %v208.c = icmp eq i64 %v206, %v207
  %v208 = zext i1 %v208.c to i64
  %c.b47 = icmp ne i64 %v208, 0
  br i1 %c.b47, label %b47.t78, label %b47.e79
b47.t78:
  br label %b48
b47.e79:
  br label %b36
b48:
  %v209 = add i64 0, 11
  %v210 = getelementptr i8, ptr %v153, i64 %v209
  %v211.p = getelementptr i8, ptr %v210, i64 0
  %v211.b = load i8, ptr %v211.p
  %v211 = zext i8 %v211.b to i64
  %v212 = add i64 0, 77
  %v213.c = icmp eq i64 %v211, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b48 = icmp ne i64 %v213, 0
  br i1 %c.b48, label %b48.t80, label %b48.e81
b48.t80:
  br label %b49
b48.e81:
  br label %b36
b49:
  %v214 = add i64 0, 12
  %v215 = getelementptr i8, ptr %v153, i64 %v214
  %v216.p = getelementptr i8, ptr %v215, i64 0
  %v216.b = load i8, ptr %v216.p
  %v216 = zext i8 %v216.b to i64
  %v217 = add i64 0, 66
  %v218.c = icmp eq i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b49 = icmp ne i64 %v218, 0
  br i1 %c.b49, label %b49.t82, label %b49.e83
b49.t82:
  br label %b50
b49.e83:
  br label %b36
b50:
  %v219 = add i64 0, 13
  %v220 = getelementptr i8, ptr %v153, i64 %v219
  %v221.p = getelementptr i8, ptr %v220, i64 0
  %v221.b = load i8, ptr %v221.p
  %v221 = zext i8 %v221.b to i64
  %v222 = add i64 0, 61
  %v223.c = icmp eq i64 %v221, %v222
  %v223 = zext i1 %v223.c to i64
  %c.b50 = icmp ne i64 %v223, 0
  br i1 %c.b50, label %b50.t84, label %b50.e85
b50.t84:
  br label %b51
b50.e85:
  br label %b36
b51:
  br label %b35
b52:
  %v226 = phi i64 [ %v228, %b35 ], [ %v245, %b58 ]
  %v227 = phi i64 [ %v229, %b35 ], [ %v249, %b58 ]
  %v230 = getelementptr i8, ptr %v153, i64 %v227
  %v231.p = getelementptr i8, ptr %v230, i64 0
  %v231.b = load i8, ptr %v231.p
  %v231 = zext i8 %v231.b to i64
  %v232 = add i64 0, 1
  %v233 = add i64 0, 0
  %v234.c = icmp eq i64 %v231, %v233
  %v234 = zext i1 %v234.c to i64
  %c.b52 = icmp ne i64 %v234, 0
  br i1 %c.b52, label %b52.t86, label %b52.e87
b52.t86:
  br label %b53
b52.e87:
  br label %b54
b53:
  %v235 = add i64 0, 14
  %v236.c = icmp sgt i64 %v227, %v235
  %v236 = zext i1 %v236.c to i64
  %c.b53 = icmp ne i64 %v236, 0
  br i1 %c.b53, label %b53.t88, label %b53.e89
b53.t88:
  br label %b57
b53.e89:
  br label %b34
b54:
  %v237 = add i64 0, 48
  %v238.c = icmp sge i64 %v231, %v237
  %v238 = zext i1 %v238.c to i64
  %c.b54 = icmp ne i64 %v238, 0
  br i1 %c.b54, label %b54.t90, label %b54.e91
b54.t90:
  br label %b55
b54.e91:
  br label %b34
b55:
  %v239 = add i64 0, 57
  %v240.c = icmp sle i64 %v231, %v239
  %v240 = zext i1 %v240.c to i64
  %c.b55 = icmp ne i64 %v240, 0
  br i1 %c.b55, label %b55.t92, label %b55.e93
b55.t92:
  br label %b56
b55.e93:
  br label %b34
b56:
  %v241 = add i64 0, 10
  %v242 = mul i64 %v226, %v241
  %v243 = add i64 0, 48
  %v244 = sub i64 %v231, %v243
  %v245 = add i64 %v242, %v244
  %v246 = add i64 0, 65536
  %v247.c = icmp sgt i64 %v245, %v246
  %v247 = zext i1 %v247.c to i64
  %c.b56 = icmp ne i64 %v247, 0
  br i1 %c.b56, label %b56.t94, label %b56.e95
b56.t94:
  br label %b34
b56.e95:
  br label %b58
b57:
  br label %b34
b58:
  %v248 = add i64 0, 1
  %v249 = add i64 %v227, %v248
  br label %b52
b59:
  %v257 = phi ptr [ %v256, %b34 ], [ %v360, %b62 ]
  %v259.p = getelementptr i64, ptr %v257, i64 0
  %v259 = load i64, ptr %v259.p
  %v260 = add i64 0, 0
  %v261.c = icmp eq i64 %v259, %v260
  %v261 = zext i1 %v261.c to i64
  %v262 = add i64 0, 0
  %c.b59 = icmp ne i64 %v261, 0
  br i1 %c.b59, label %b59.t96, label %b59.e97
b59.t96:
  br label %b60
b59.e97:
  br label %b63
b60:
  %v258 = phi i64 [ %v262, %b59.t96 ], [ %v367, %b84.e140 ], [ %v367, %b85.e142 ], [ %v367, %b86.e144 ], [ %v367, %b87.t145 ], [ %v361, %b88 ]
  %st97 = getelementptr i64, ptr %v1, i64 2573
  store i64 %v258, ptr %st97
  call void @"main.main"()
  call void @"rt.depth_report"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 0)
  unreachable
b61:
  %v363 = add i64 0, 0
  %v364 = add i64 0, 19
  br label %b83
b62:
  %v359 = add i64 0, 1
  %v360 = getelementptr i64, ptr %v257, i64 %v359
  br label %b59
b63:
  %v263 = inttoptr i64 %v259 to ptr
  %v264 = add i64 0, 0
  %v265 = getelementptr i8, ptr %v263, i64 %v264
  %v266.p = getelementptr i8, ptr %v265, i64 0
  %v266.b = load i8, ptr %v266.p
  %v266 = zext i8 %v266.b to i64
  %v267 = add i64 0, 83
  %v268.c = icmp eq i64 %v266, %v267
  %v268 = zext i1 %v268.c to i64
  %c.b63 = icmp ne i64 %v268, 0
  br i1 %c.b63, label %b63.t99, label %b63.e100
b63.t99:
  br label %b64
b63.e100:
  br label %b62
b64:
  %v269 = add i64 0, 1
  %v270 = getelementptr i8, ptr %v263, i64 %v269
  %v271.p = getelementptr i8, ptr %v270, i64 0
  %v271.b = load i8, ptr %v271.p
  %v271 = zext i8 %v271.b to i64
  %v272 = add i64 0, 79
  %v273.c = icmp eq i64 %v271, %v272
  %v273 = zext i1 %v273.c to i64
  %c.b64 = icmp ne i64 %v273, 0
  br i1 %c.b64, label %b64.t101, label %b64.e102
b64.t101:
  br label %b65
b64.e102:
  br label %b62
b65:
  %v274 = add i64 0, 2
  %v275 = getelementptr i8, ptr %v263, i64 %v274
  %v276.p = getelementptr i8, ptr %v275, i64 0
  %v276.b = load i8, ptr %v276.p
  %v276 = zext i8 %v276.b to i64
  %v277 = add i64 0, 66
  %v278.c = icmp eq i64 %v276, %v277
  %v278 = zext i1 %v278.c to i64
  %c.b65 = icmp ne i64 %v278, 0
  br i1 %c.b65, label %b65.t103, label %b65.e104
b65.t103:
  br label %b66
b65.e104:
  br label %b62
b66:
  %v279 = add i64 0, 3
  %v280 = getelementptr i8, ptr %v263, i64 %v279
  %v281.p = getelementptr i8, ptr %v280, i64 0
  %v281.b = load i8, ptr %v281.p
  %v281 = zext i8 %v281.b to i64
  %v282 = add i64 0, 69
  %v283.c = icmp eq i64 %v281, %v282
  %v283 = zext i1 %v283.c to i64
  %c.b66 = icmp ne i64 %v283, 0
  br i1 %c.b66, label %b66.t105, label %b66.e106
b66.t105:
  br label %b67
b66.e106:
  br label %b62
b67:
  %v284 = add i64 0, 4
  %v285 = getelementptr i8, ptr %v263, i64 %v284
  %v286.p = getelementptr i8, ptr %v285, i64 0
  %v286.b = load i8, ptr %v286.p
  %v286 = zext i8 %v286.b to i64
  %v287 = add i64 0, 82
  %v288.c = icmp eq i64 %v286, %v287
  %v288 = zext i1 %v288.c to i64
  %c.b67 = icmp ne i64 %v288, 0
  br i1 %c.b67, label %b67.t107, label %b67.e108
b67.t107:
  br label %b68
b67.e108:
  br label %b62
b68:
  %v289 = add i64 0, 5
  %v290 = getelementptr i8, ptr %v263, i64 %v289
  %v291.p = getelementptr i8, ptr %v290, i64 0
  %v291.b = load i8, ptr %v291.p
  %v291 = zext i8 %v291.b to i64
  %v292 = add i64 0, 95
  %v293.c = icmp eq i64 %v291, %v292
  %v293 = zext i1 %v293.c to i64
  %c.b68 = icmp ne i64 %v293, 0
  br i1 %c.b68, label %b68.t109, label %b68.e110
b68.t109:
  br label %b69
b68.e110:
  br label %b62
b69:
  %v294 = add i64 0, 6
  %v295 = getelementptr i8, ptr %v263, i64 %v294
  %v296.p = getelementptr i8, ptr %v295, i64 0
  %v296.b = load i8, ptr %v296.p
  %v296 = zext i8 %v296.b to i64
  %v297 = add i64 0, 68
  %v298.c = icmp eq i64 %v296, %v297
  %v298 = zext i1 %v298.c to i64
  %c.b69 = icmp ne i64 %v298, 0
  br i1 %c.b69, label %b69.t111, label %b69.e112
b69.t111:
  br label %b70
b69.e112:
  br label %b62
b70:
  %v299 = add i64 0, 7
  %v300 = getelementptr i8, ptr %v263, i64 %v299
  %v301.p = getelementptr i8, ptr %v300, i64 0
  %v301.b = load i8, ptr %v301.p
  %v301 = zext i8 %v301.b to i64
  %v302 = add i64 0, 69
  %v303.c = icmp eq i64 %v301, %v302
  %v303 = zext i1 %v303.c to i64
  %c.b70 = icmp ne i64 %v303, 0
  br i1 %c.b70, label %b70.t113, label %b70.e114
b70.t113:
  br label %b71
b70.e114:
  br label %b62
b71:
  %v304 = add i64 0, 8
  %v305 = getelementptr i8, ptr %v263, i64 %v304
  %v306.p = getelementptr i8, ptr %v305, i64 0
  %v306.b = load i8, ptr %v306.p
  %v306 = zext i8 %v306.b to i64
  %v307 = add i64 0, 80
  %v308.c = icmp eq i64 %v306, %v307
  %v308 = zext i1 %v308.c to i64
  %c.b71 = icmp ne i64 %v308, 0
  br i1 %c.b71, label %b71.t115, label %b71.e116
b71.t115:
  br label %b72
b71.e116:
  br label %b62
b72:
  %v309 = add i64 0, 9
  %v310 = getelementptr i8, ptr %v263, i64 %v309
  %v311.p = getelementptr i8, ptr %v310, i64 0
  %v311.b = load i8, ptr %v311.p
  %v311 = zext i8 %v311.b to i64
  %v312 = add i64 0, 84
  %v313.c = icmp eq i64 %v311, %v312
  %v313 = zext i1 %v313.c to i64
  %c.b72 = icmp ne i64 %v313, 0
  br i1 %c.b72, label %b72.t117, label %b72.e118
b72.t117:
  br label %b73
b72.e118:
  br label %b62
b73:
  %v314 = add i64 0, 10
  %v315 = getelementptr i8, ptr %v263, i64 %v314
  %v316.p = getelementptr i8, ptr %v315, i64 0
  %v316.b = load i8, ptr %v316.p
  %v316 = zext i8 %v316.b to i64
  %v317 = add i64 0, 72
  %v318.c = icmp eq i64 %v316, %v317
  %v318 = zext i1 %v318.c to i64
  %c.b73 = icmp ne i64 %v318, 0
  br i1 %c.b73, label %b73.t119, label %b73.e120
b73.t119:
  br label %b74
b73.e120:
  br label %b62
b74:
  %v319 = add i64 0, 11
  %v320 = getelementptr i8, ptr %v263, i64 %v319
  %v321.p = getelementptr i8, ptr %v320, i64 0
  %v321.b = load i8, ptr %v321.p
  %v321 = zext i8 %v321.b to i64
  %v322 = add i64 0, 95
  %v323.c = icmp eq i64 %v321, %v322
  %v323 = zext i1 %v323.c to i64
  %c.b74 = icmp ne i64 %v323, 0
  br i1 %c.b74, label %b74.t121, label %b74.e122
b74.t121:
  br label %b75
b74.e122:
  br label %b62
b75:
  %v324 = add i64 0, 12
  %v325 = getelementptr i8, ptr %v263, i64 %v324
  %v326.p = getelementptr i8, ptr %v325, i64 0
  %v326.b = load i8, ptr %v326.p
  %v326 = zext i8 %v326.b to i64
  %v327 = add i64 0, 82
  %v328.c = icmp eq i64 %v326, %v327
  %v328 = zext i1 %v328.c to i64
  %c.b75 = icmp ne i64 %v328, 0
  br i1 %c.b75, label %b75.t123, label %b75.e124
b75.t123:
  br label %b76
b75.e124:
  br label %b62
b76:
  %v329 = add i64 0, 13
  %v330 = getelementptr i8, ptr %v263, i64 %v329
  %v331.p = getelementptr i8, ptr %v330, i64 0
  %v331.b = load i8, ptr %v331.p
  %v331 = zext i8 %v331.b to i64
  %v332 = add i64 0, 69
  %v333.c = icmp eq i64 %v331, %v332
  %v333 = zext i1 %v333.c to i64
  %c.b76 = icmp ne i64 %v333, 0
  br i1 %c.b76, label %b76.t125, label %b76.e126
b76.t125:
  br label %b77
b76.e126:
  br label %b62
b77:
  %v334 = add i64 0, 14
  %v335 = getelementptr i8, ptr %v263, i64 %v334
  %v336.p = getelementptr i8, ptr %v335, i64 0
  %v336.b = load i8, ptr %v336.p
  %v336 = zext i8 %v336.b to i64
  %v337 = add i64 0, 80
  %v338.c = icmp eq i64 %v336, %v337
  %v338 = zext i1 %v338.c to i64
  %c.b77 = icmp ne i64 %v338, 0
  br i1 %c.b77, label %b77.t127, label %b77.e128
b77.t127:
  br label %b78
b77.e128:
  br label %b62
b78:
  %v339 = add i64 0, 15
  %v340 = getelementptr i8, ptr %v263, i64 %v339
  %v341.p = getelementptr i8, ptr %v340, i64 0
  %v341.b = load i8, ptr %v341.p
  %v341 = zext i8 %v341.b to i64
  %v342 = add i64 0, 79
  %v343.c = icmp eq i64 %v341, %v342
  %v343 = zext i1 %v343.c to i64
  %c.b78 = icmp ne i64 %v343, 0
  br i1 %c.b78, label %b78.t129, label %b78.e130
b78.t129:
  br label %b79
b78.e130:
  br label %b62
b79:
  %v344 = add i64 0, 16
  %v345 = getelementptr i8, ptr %v263, i64 %v344
  %v346.p = getelementptr i8, ptr %v345, i64 0
  %v346.b = load i8, ptr %v346.p
  %v346 = zext i8 %v346.b to i64
  %v347 = add i64 0, 82
  %v348.c = icmp eq i64 %v346, %v347
  %v348 = zext i1 %v348.c to i64
  %c.b79 = icmp ne i64 %v348, 0
  br i1 %c.b79, label %b79.t131, label %b79.e132
b79.t131:
  br label %b80
b79.e132:
  br label %b62
b80:
  %v349 = add i64 0, 17
  %v350 = getelementptr i8, ptr %v263, i64 %v349
  %v351.p = getelementptr i8, ptr %v350, i64 0
  %v351.b = load i8, ptr %v351.p
  %v351 = zext i8 %v351.b to i64
  %v352 = add i64 0, 84
  %v353.c = icmp eq i64 %v351, %v352
  %v353 = zext i1 %v353.c to i64
  %c.b80 = icmp ne i64 %v353, 0
  br i1 %c.b80, label %b80.t133, label %b80.e134
b80.t133:
  br label %b81
b80.e134:
  br label %b62
b81:
  %v354 = add i64 0, 18
  %v355 = getelementptr i8, ptr %v263, i64 %v354
  %v356.p = getelementptr i8, ptr %v355, i64 0
  %v356.b = load i8, ptr %v356.p
  %v356 = zext i8 %v356.b to i64
  %v357 = add i64 0, 61
  %v358.c = icmp eq i64 %v356, %v357
  %v358 = zext i1 %v358.c to i64
  %c.b81 = icmp ne i64 %v358, 0
  br i1 %c.b81, label %b81.t135, label %b81.e136
b81.t135:
  br label %b82
b81.e136:
  br label %b62
b82:
  br label %b61
b83:
  %v361 = phi i64 [ %v363, %b61 ], [ %v380, %b89 ]
  %v362 = phi i64 [ %v364, %b61 ], [ %v384, %b89 ]
  %v365 = getelementptr i8, ptr %v263, i64 %v362
  %v366.p = getelementptr i8, ptr %v365, i64 0
  %v366.b = load i8, ptr %v366.p
  %v366 = zext i8 %v366.b to i64
  %v367 = add i64 0, 0
  %v368 = add i64 0, 0
  %v369.c = icmp eq i64 %v366, %v368
  %v369 = zext i1 %v369.c to i64
  %c.b83 = icmp ne i64 %v369, 0
  br i1 %c.b83, label %b83.t137, label %b83.e138
b83.t137:
  br label %b84
b83.e138:
  br label %b85
b84:
  %v370 = add i64 0, 19
  %v371.c = icmp sgt i64 %v362, %v370
  %v371 = zext i1 %v371.c to i64
  %c.b84 = icmp ne i64 %v371, 0
  br i1 %c.b84, label %b84.t139, label %b84.e140
b84.t139:
  br label %b88
b84.e140:
  br label %b60
b85:
  %v372 = add i64 0, 48
  %v373.c = icmp sge i64 %v366, %v372
  %v373 = zext i1 %v373.c to i64
  %c.b85 = icmp ne i64 %v373, 0
  br i1 %c.b85, label %b85.t141, label %b85.e142
b85.t141:
  br label %b86
b85.e142:
  br label %b60
b86:
  %v374 = add i64 0, 57
  %v375.c = icmp sle i64 %v366, %v374
  %v375 = zext i1 %v375.c to i64
  %c.b86 = icmp ne i64 %v375, 0
  br i1 %c.b86, label %b86.t143, label %b86.e144
b86.t143:
  br label %b87
b86.e144:
  br label %b60
b87:
  %v376 = add i64 0, 10
  %v377 = mul i64 %v361, %v376
  %v378 = add i64 0, 48
  %v379 = sub i64 %v366, %v378
  %v380 = add i64 %v377, %v379
  %v381 = add i64 0, 65536
  %v382.c = icmp sgt i64 %v380, %v381
  %v382 = zext i1 %v382.c to i64
  %c.b87 = icmp ne i64 %v382, 0
  br i1 %c.b87, label %b87.t145, label %b87.e146
b87.t145:
  br label %b60
b87.e146:
  br label %b89
b88:
  br label %b60
b89:
  %v383 = add i64 0, 1
  %v384 = add i64 %v362, %v383
  br label %b83
}

define internal void @"main.show"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
b0:
  %s0 = alloca [6 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %s0.z4 = getelementptr i64, ptr %s0, i64 4
  store i64 0, ptr %s0.z4
  %s0.z5 = getelementptr i64, ptr %s0, i64 5
  store i64 0, ptr %s0.z5
  %s1 = alloca [5 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
  %s1.z4 = getelementptr i64, ptr %s1, i64 4
  store i64 0, ptr %s1.z4
  %s2 = alloca [6 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s2.z5 = getelementptr i64, ptr %s2, i64 5
  store i64 0, ptr %s2.z5
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [6 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %s10.z3 = getelementptr i64, ptr %s10, i64 3
  store i64 0, ptr %s10.z3
  %s10.z4 = getelementptr i64, ptr %s10, i64 4
  store i64 0, ptr %s10.z4
  %s10.z5 = getelementptr i64, ptr %s10, i64 5
  store i64 0, ptr %s10.z5
  %s11 = alloca [3 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %s11.z2 = getelementptr i64, ptr %s11, i64 2
  store i64 0, ptr %s11.z2
  %s12 = alloca [3 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s13 = alloca [3 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s13.z1 = getelementptr i64, ptr %s13, i64 1
  store i64 0, ptr %s13.z1
  %s13.z2 = getelementptr i64, ptr %s13, i64 2
  store i64 0, ptr %s13.z2
  %s14 = alloca [3 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s14.z1 = getelementptr i64, ptr %s14, i64 1
  store i64 0, ptr %s14.z1
  %s14.z2 = getelementptr i64, ptr %s14, i64 2
  store i64 0, ptr %s14.z2
  %s15 = alloca [3 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s15.z1 = getelementptr i64, ptr %s15, i64 1
  store i64 0, ptr %s15.z1
  %s15.z2 = getelementptr i64, ptr %s15, i64 2
  store i64 0, ptr %s15.z2
  %s16 = alloca [3 x i64], align 8
  %s16.z0 = getelementptr i64, ptr %s16, i64 0
  store i64 0, ptr %s16.z0
  %s16.z1 = getelementptr i64, ptr %s16, i64 1
  store i64 0, ptr %s16.z1
  %s16.z2 = getelementptr i64, ptr %s16, i64 2
  store i64 0, ptr %s16.z2
  %s17 = alloca [3 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s17.z1 = getelementptr i64, ptr %s17, i64 1
  store i64 0, ptr %s17.z1
  %s17.z2 = getelementptr i64, ptr %s17, i64 2
  store i64 0, ptr %s17.z2
  %s18 = alloca [6 x i64], align 8
  %s18.z0 = getelementptr i64, ptr %s18, i64 0
  store i64 0, ptr %s18.z0
  %s18.z1 = getelementptr i64, ptr %s18, i64 1
  store i64 0, ptr %s18.z1
  %s18.z2 = getelementptr i64, ptr %s18, i64 2
  store i64 0, ptr %s18.z2
  %s18.z3 = getelementptr i64, ptr %s18, i64 3
  store i64 0, ptr %s18.z3
  %s18.z4 = getelementptr i64, ptr %s18, i64 4
  store i64 0, ptr %s18.z4
  %s18.z5 = getelementptr i64, ptr %s18, i64 5
  store i64 0, ptr %s18.z5
  %s19 = alloca [6 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s19.z1 = getelementptr i64, ptr %s19, i64 1
  store i64 0, ptr %s19.z1
  %s19.z2 = getelementptr i64, ptr %s19, i64 2
  store i64 0, ptr %s19.z2
  %s19.z3 = getelementptr i64, ptr %s19, i64 3
  store i64 0, ptr %s19.z3
  %s19.z4 = getelementptr i64, ptr %s19, i64 4
  store i64 0, ptr %s19.z4
  %s19.z5 = getelementptr i64, ptr %s19, i64 5
  store i64 0, ptr %s19.z5
  %s20 = alloca [3 x i64], align 8
  %s20.z0 = getelementptr i64, ptr %s20, i64 0
  store i64 0, ptr %s20.z0
  %s20.z1 = getelementptr i64, ptr %s20, i64 1
  store i64 0, ptr %s20.z1
  %s20.z2 = getelementptr i64, ptr %s20, i64 2
  store i64 0, ptr %s20.z2
  %s21 = alloca [3 x i64], align 8
  %s21.z0 = getelementptr i64, ptr %s21, i64 0
  store i64 0, ptr %s21.z0
  %s21.z1 = getelementptr i64, ptr %s21, i64 1
  store i64 0, ptr %s21.z1
  %s21.z2 = getelementptr i64, ptr %s21, i64 2
  store i64 0, ptr %s21.z2
  %s22 = alloca [3 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %s22.z1 = getelementptr i64, ptr %s22, i64 1
  store i64 0, ptr %s22.z1
  %s22.z2 = getelementptr i64, ptr %s22, i64 2
  store i64 0, ptr %s22.z2
  %s23 = alloca [3 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %s23.z1 = getelementptr i64, ptr %s23, i64 1
  store i64 0, ptr %s23.z1
  %s23.z2 = getelementptr i64, ptr %s23, i64 2
  store i64 0, ptr %s23.z2
  %s24 = alloca [3 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s24.z1 = getelementptr i64, ptr %s24, i64 1
  store i64 0, ptr %s24.z1
  %s24.z2 = getelementptr i64, ptr %s24, i64 2
  store i64 0, ptr %s24.z2
  %s25 = alloca [3 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
  %s25.z1 = getelementptr i64, ptr %s25, i64 1
  store i64 0, ptr %s25.z1
  %s25.z2 = getelementptr i64, ptr %s25, i64 2
  store i64 0, ptr %s25.z2
  %s26 = alloca [3 x i64], align 8
  %s26.z0 = getelementptr i64, ptr %s26, i64 0
  store i64 0, ptr %s26.z0
  %s26.z1 = getelementptr i64, ptr %s26, i64 1
  store i64 0, ptr %s26.z1
  %s26.z2 = getelementptr i64, ptr %s26, i64 2
  store i64 0, ptr %s26.z2
  %s27 = alloca [6 x i64], align 8
  %s27.z0 = getelementptr i64, ptr %s27, i64 0
  store i64 0, ptr %s27.z0
  %s27.z1 = getelementptr i64, ptr %s27, i64 1
  store i64 0, ptr %s27.z1
  %s27.z2 = getelementptr i64, ptr %s27, i64 2
  store i64 0, ptr %s27.z2
  %s27.z3 = getelementptr i64, ptr %s27, i64 3
  store i64 0, ptr %s27.z3
  %s27.z4 = getelementptr i64, ptr %s27, i64 4
  store i64 0, ptr %s27.z4
  %s27.z5 = getelementptr i64, ptr %s27, i64 5
  store i64 0, ptr %s27.z5
  %s28 = alloca [6 x i64], align 8
  %s28.z0 = getelementptr i64, ptr %s28, i64 0
  store i64 0, ptr %s28.z0
  %s28.z1 = getelementptr i64, ptr %s28, i64 1
  store i64 0, ptr %s28.z1
  %s28.z2 = getelementptr i64, ptr %s28, i64 2
  store i64 0, ptr %s28.z2
  %s28.z3 = getelementptr i64, ptr %s28, i64 3
  store i64 0, ptr %s28.z3
  %s28.z4 = getelementptr i64, ptr %s28, i64 4
  store i64 0, ptr %s28.z4
  %s28.z5 = getelementptr i64, ptr %s28, i64 5
  store i64 0, ptr %s28.z5
  %s29 = alloca [3 x i64], align 8
  %s29.z0 = getelementptr i64, ptr %s29, i64 0
  store i64 0, ptr %s29.z0
  %s29.z1 = getelementptr i64, ptr %s29, i64 1
  store i64 0, ptr %s29.z1
  %s29.z2 = getelementptr i64, ptr %s29, i64 2
  store i64 0, ptr %s29.z2
  %s30 = alloca [3 x i64], align 8
  %s30.z0 = getelementptr i64, ptr %s30, i64 0
  store i64 0, ptr %s30.z0
  %s30.z1 = getelementptr i64, ptr %s30, i64 1
  store i64 0, ptr %s30.z1
  %s30.z2 = getelementptr i64, ptr %s30, i64 2
  store i64 0, ptr %s30.z2
  %s31 = alloca [3 x i64], align 8
  %s31.z0 = getelementptr i64, ptr %s31, i64 0
  store i64 0, ptr %s31.z0
  %s31.z1 = getelementptr i64, ptr %s31, i64 1
  store i64 0, ptr %s31.z1
  %s31.z2 = getelementptr i64, ptr %s31, i64 2
  store i64 0, ptr %s31.z2
  %s32 = alloca [3 x i64], align 8
  %s32.z0 = getelementptr i64, ptr %s32, i64 0
  store i64 0, ptr %s32.z0
  %s32.z1 = getelementptr i64, ptr %s32, i64 1
  store i64 0, ptr %s32.z1
  %s32.z2 = getelementptr i64, ptr %s32, i64 2
  store i64 0, ptr %s32.z2
  %s33 = alloca [3 x i64], align 8
  %s33.z0 = getelementptr i64, ptr %s33, i64 0
  store i64 0, ptr %s33.z0
  %s33.z1 = getelementptr i64, ptr %s33, i64 1
  store i64 0, ptr %s33.z1
  %s33.z2 = getelementptr i64, ptr %s33, i64 2
  store i64 0, ptr %s33.z2
  %s34 = alloca [6 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
  %s34.z1 = getelementptr i64, ptr %s34, i64 1
  store i64 0, ptr %s34.z1
  %s34.z2 = getelementptr i64, ptr %s34, i64 2
  store i64 0, ptr %s34.z2
  %s34.z3 = getelementptr i64, ptr %s34, i64 3
  store i64 0, ptr %s34.z3
  %s34.z4 = getelementptr i64, ptr %s34, i64 4
  store i64 0, ptr %s34.z4
  %s34.z5 = getelementptr i64, ptr %s34, i64 5
  store i64 0, ptr %s34.z5
  %s35 = alloca [3 x i64], align 8
  %s35.z0 = getelementptr i64, ptr %s35, i64 0
  store i64 0, ptr %s35.z0
  %s35.z1 = getelementptr i64, ptr %s35, i64 1
  store i64 0, ptr %s35.z1
  %s35.z2 = getelementptr i64, ptr %s35, i64 2
  store i64 0, ptr %s35.z2
  %s36 = alloca [3 x i64], align 8
  %s36.z0 = getelementptr i64, ptr %s36, i64 0
  store i64 0, ptr %s36.z0
  %s36.z1 = getelementptr i64, ptr %s36, i64 1
  store i64 0, ptr %s36.z1
  %s36.z2 = getelementptr i64, ptr %s36, i64 2
  store i64 0, ptr %s36.z2
  %s37 = alloca [3 x i64], align 8
  %s37.z0 = getelementptr i64, ptr %s37, i64 0
  store i64 0, ptr %s37.z0
  %s37.z1 = getelementptr i64, ptr %s37, i64 1
  store i64 0, ptr %s37.z1
  %s37.z2 = getelementptr i64, ptr %s37, i64 2
  store i64 0, ptr %s37.z2
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %st3 = getelementptr i64, ptr %v6, i64 3
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v6, i64 4
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v6, i64 5
  store i64 %v5, ptr %st5
  %v466 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v466, i64 0
  %v7 = load i64, ptr %v7.p
  call void @"rt.region_enter"()
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp ne i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v11 = add i64 0, 1
  %v12 = getelementptr i64, ptr %v6, i64 %v11
  %v13 = getelementptr i64, ptr %s1, i64 0
  %v14.p = getelementptr i64, ptr %v12, i64 0
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v12, i64 1
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v12, i64 2
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st10
  %v17.p = getelementptr i64, ptr %v12, i64 3
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v13, i64 3
  store i64 %v17, ptr %st11
  %v18.p = getelementptr i64, ptr %v12, i64 4
  %v18 = load i64, ptr %v18.p
  %st12 = getelementptr i64, ptr %v13, i64 4
  store i64 %v18, ptr %st12
  %v19.p = getelementptr i64, ptr %v13, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 2
  %v21.c = icmp eq i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b1 = icmp ne i64 %v21, 0
  br i1 %c.b1, label %b1.t14, label %b1.e15
b1.t14:
  br label %b4
b1.e15:
  br label %b3
b2:
  %v460 = getelementptr i64, ptr @"str.2", i64 0
  %v461 = add i64 0, 2
  %v462 = add i64 0, 0
  %v463 = getelementptr i64, ptr %s37, i64 0
  %v464 = ptrtoint ptr %v460 to i64
  %st15 = getelementptr i64, ptr %v463, i64 0
  store i64 %v464, ptr %st15
  %st16 = getelementptr i64, ptr %v463, i64 1
  store i64 %v461, ptr %st16
  %st17 = getelementptr i64, ptr %v463, i64 2
  store i64 %v462, ptr %st17
  call void @"rt.print_str"(ptr %v463)
  %v465 = add i64 0, 10
  call void @"rt.print_char"(i64 %v465)
  br label %b44
b3:
  %v105.p = getelementptr i64, ptr %v13, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = add i64 0, 2
  %v107.c = icmp eq i64 %v105, %v106
  %v107 = zext i1 %v107.c to i64
  %c.b3 = icmp ne i64 %v107, 0
  br i1 %c.b3, label %b3.t19, label %b3.e20
b3.t19:
  br label %b11
b3.e20:
  br label %b10
b4:
  %v22.p = getelementptr i64, ptr %v13, i64 1
  %v22 = load i64, ptr %v22.p
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24 = add i64 0, 2
  %v25 = getelementptr i64, ptr %v13, i64 %v24
  %v26.p = getelementptr i64, ptr %v25, i64 1
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp ne i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b4 = icmp ne i64 %v28, 0
  br i1 %c.b4, label %b4.t21, label %b4.e22
b4.t21:
  br label %b5
b4.e22:
  br label %b6
b5:
  %v30 = add i64 0, 1
  %st22 = getelementptr i64, ptr %v23, i64 0
  store i64 %v30, ptr %st22
  %v31 = add i64 0, 1
  %v32 = sub i64 %v26, %v31
  %v33.p = getelementptr i64, ptr %v25, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = inttoptr i64 %v33 to ptr
  %v35 = add i64 0, 2
  %v36 = mul i64 %v32, %v35
  %v37 = getelementptr i64, ptr %v34, i64 %v36
  %v38.p = getelementptr i64, ptr %v37, i64 0
  %v38 = load i64, ptr %v38.p
  %st23 = getelementptr i64, ptr %v23, i64 1
  store i64 %v38, ptr %st23
  %v39.p = getelementptr i64, ptr %v37, i64 1
  %v39 = load i64, ptr %v39.p
  %st24 = getelementptr i64, ptr %v23, i64 2
  store i64 %v39, ptr %st24
  %v40 = add i64 0, 3
  %v41 = getelementptr i64, ptr %v23, i64 %v40
  %v42.p = getelementptr i64, ptr %v25, i64 0
  %v42 = load i64, ptr %v42.p
  %st25 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st25
  %st26 = getelementptr i64, ptr %v41, i64 1
  store i64 %v32, ptr %st26
  %v43.p = getelementptr i64, ptr %v25, i64 2
  %v43 = load i64, ptr %v43.p
  %st27 = getelementptr i64, ptr %v41, i64 2
  store i64 %v43, ptr %st27
  br label %b7
b6:
  %v29 = add i64 0, 0
  %st28 = getelementptr i64, ptr %v23, i64 0
  store i64 %v29, ptr %st28
  br label %b7
b7:
  %v44.p = getelementptr i64, ptr %v23, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = add i64 0, 0
  %v46.c = icmp ne i64 %v44, %v45
  %v46 = zext i1 %v46.c to i64
  %c.b7 = icmp ne i64 %v46, 0
  br i1 %c.b7, label %b7.t30, label %b7.e31
b7.t30:
  br label %b8
b7.e31:
  br label %b3
b8:
  %v47 = add i64 0, 1
  %v48 = getelementptr i64, ptr %v23, i64 %v47
  %v49.p = getelementptr i64, ptr %v48, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.c = icmp eq i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b8 = icmp ne i64 %v51, 0
  br i1 %c.b8, label %b8.t32, label %b8.e33
b8.t32:
  br label %b9
b8.e33:
  br label %b3
b9:
  %v52.p = getelementptr i64, ptr %v48, i64 1
  %v52 = load i64, ptr %v52.p
  %v53 = getelementptr i64, ptr @"str.5", i64 0
  %v54 = add i64 0, 8
  %v55 = add i64 0, 0
  %v56 = getelementptr i64, ptr %s3, i64 0
  %v57 = ptrtoint ptr %v53 to i64
  %st33 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st33
  %st34 = getelementptr i64, ptr %v56, i64 1
  store i64 %v54, ptr %st34
  %st35 = getelementptr i64, ptr %v56, i64 2
  store i64 %v55, ptr %st35
  %v58 = getelementptr i64, ptr %s4, i64 0
  call void @"std/convert.FormatInt"(ptr %v58, i64 %v22)
  %v59.p = getelementptr i64, ptr %v56, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v58, i64 1
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 %v59, %v60
  %v467 = getelementptr i64, ptr @"rt.meta", i64 0
  %v62.p = getelementptr i64, ptr %v467, i64 0
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v56, i64 0
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v56, i64 1
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v56, i64 2
  %v65 = load i64, ptr %v65.p
  %v66 = call ptr @"rt.cat8"(i64 %v63, i64 %v64, i64 %v65, i64 %v62, i64 %v60)
  %v67 = getelementptr i8, ptr %v66, i64 %v59
  %v68.p = getelementptr i64, ptr %v58, i64 0
  %v68 = load i64, ptr %v68.p
  %v69 = inttoptr i64 %v68 to ptr
  call void @"rt.copy8"(ptr %v67, ptr %v69, i64 %v60)
  %v70 = getelementptr i64, ptr %s5, i64 0
  %v71 = ptrtoint ptr %v66 to i64
  %st36 = getelementptr i64, ptr %v70, i64 0
  store i64 %v71, ptr %st36
  %st37 = getelementptr i64, ptr %v70, i64 1
  store i64 %v61, ptr %st37
  %st38 = getelementptr i64, ptr %v70, i64 2
  store i64 %v62, ptr %st38
  %v72 = getelementptr i64, ptr @"str.6", i64 0
  %v73 = add i64 0, 12
  %v74 = add i64 0, 0
  %v75 = getelementptr i64, ptr %s6, i64 0
  %v76 = ptrtoint ptr %v72 to i64
  %st39 = getelementptr i64, ptr %v75, i64 0
  store i64 %v76, ptr %st39
  %st40 = getelementptr i64, ptr %v75, i64 1
  store i64 %v73, ptr %st40
  %st41 = getelementptr i64, ptr %v75, i64 2
  store i64 %v74, ptr %st41
  %v77.p = getelementptr i64, ptr %v70, i64 1
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v75, i64 1
  %v78 = load i64, ptr %v78.p
  %v79 = add i64 %v77, %v78
  %v468 = getelementptr i64, ptr @"rt.meta", i64 0
  %v80.p = getelementptr i64, ptr %v468, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v70, i64 0
  %v81 = load i64, ptr %v81.p
  %v82.p = getelementptr i64, ptr %v70, i64 1
  %v82 = load i64, ptr %v82.p
  %v83.p = getelementptr i64, ptr %v70, i64 2
  %v83 = load i64, ptr %v83.p
  %v84 = call ptr @"rt.cat8"(i64 %v81, i64 %v82, i64 %v83, i64 %v80, i64 %v78)
  %v85 = getelementptr i8, ptr %v84, i64 %v77
  %v86.p = getelementptr i64, ptr %v75, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = inttoptr i64 %v86 to ptr
  call void @"rt.copy8"(ptr %v85, ptr %v87, i64 %v78)
  %v88 = getelementptr i64, ptr %s7, i64 0
  %v89 = ptrtoint ptr %v84 to i64
  %st42 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st42
  %st43 = getelementptr i64, ptr %v88, i64 1
  store i64 %v79, ptr %st43
  %st44 = getelementptr i64, ptr %v88, i64 2
  store i64 %v80, ptr %st44
  %v90 = getelementptr i64, ptr %s8, i64 0
  call void @"std/convert.FormatInt"(ptr %v90, i64 %v52)
  %v91.p = getelementptr i64, ptr %v88, i64 1
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v90, i64 1
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 %v91, %v92
  %v469 = getelementptr i64, ptr @"rt.meta", i64 0
  %v94.p = getelementptr i64, ptr %v469, i64 0
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v88, i64 0
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v88, i64 1
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v88, i64 2
  %v97 = load i64, ptr %v97.p
  %v98 = call ptr @"rt.cat8"(i64 %v95, i64 %v96, i64 %v97, i64 %v94, i64 %v92)
  %v99 = getelementptr i8, ptr %v98, i64 %v91
  %v100.p = getelementptr i64, ptr %v90, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = inttoptr i64 %v100 to ptr
  call void @"rt.copy8"(ptr %v99, ptr %v101, i64 %v92)
  %v102 = getelementptr i64, ptr %s9, i64 0
  %v103 = ptrtoint ptr %v98 to i64
  %st45 = getelementptr i64, ptr %v102, i64 0
  store i64 %v103, ptr %st45
  %st46 = getelementptr i64, ptr %v102, i64 1
  store i64 %v93, ptr %st46
  %st47 = getelementptr i64, ptr %v102, i64 2
  store i64 %v94, ptr %st47
  call void @"rt.print_str"(ptr %v102)
  %v104 = add i64 0, 10
  call void @"rt.print_char"(i64 %v104)
  br label %b43
b10:
  %v191.p = getelementptr i64, ptr %v13, i64 0
  %v191 = load i64, ptr %v191.p
  %v192 = add i64 0, 2
  %v193.c = icmp eq i64 %v191, %v192
  %v193 = zext i1 %v193.c to i64
  %c.b10 = icmp ne i64 %v193, 0
  br i1 %c.b10, label %b10.t49, label %b10.e50
b10.t49:
  br label %b18
b10.e50:
  br label %b17
b11:
  %v108.p = getelementptr i64, ptr %v13, i64 1
  %v108 = load i64, ptr %v108.p
  %v109 = getelementptr i64, ptr %s10, i64 0
  %v110 = add i64 0, 2
  %v111 = getelementptr i64, ptr %v13, i64 %v110
  %v112.p = getelementptr i64, ptr %v111, i64 1
  %v112 = load i64, ptr %v112.p
  %v113 = add i64 0, 0
  %v114.c = icmp ne i64 %v112, %v113
  %v114 = zext i1 %v114.c to i64
  %c.b11 = icmp ne i64 %v114, 0
  br i1 %c.b11, label %b11.t51, label %b11.e52
b11.t51:
  br label %b12
b11.e52:
  br label %b13
b12:
  %v116 = add i64 0, 1
  %st52 = getelementptr i64, ptr %v109, i64 0
  store i64 %v116, ptr %st52
  %v117 = add i64 0, 1
  %v118 = sub i64 %v112, %v117
  %v119.p = getelementptr i64, ptr %v111, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = inttoptr i64 %v119 to ptr
  %v121 = add i64 0, 2
  %v122 = mul i64 %v118, %v121
  %v123 = getelementptr i64, ptr %v120, i64 %v122
  %v124.p = getelementptr i64, ptr %v123, i64 0
  %v124 = load i64, ptr %v124.p
  %st53 = getelementptr i64, ptr %v109, i64 1
  store i64 %v124, ptr %st53
  %v125.p = getelementptr i64, ptr %v123, i64 1
  %v125 = load i64, ptr %v125.p
  %st54 = getelementptr i64, ptr %v109, i64 2
  store i64 %v125, ptr %st54
  %v126 = add i64 0, 3
  %v127 = getelementptr i64, ptr %v109, i64 %v126
  %v128.p = getelementptr i64, ptr %v111, i64 0
  %v128 = load i64, ptr %v128.p
  %st55 = getelementptr i64, ptr %v127, i64 0
  store i64 %v128, ptr %st55
  %st56 = getelementptr i64, ptr %v127, i64 1
  store i64 %v118, ptr %st56
  %v129.p = getelementptr i64, ptr %v111, i64 2
  %v129 = load i64, ptr %v129.p
  %st57 = getelementptr i64, ptr %v127, i64 2
  store i64 %v129, ptr %st57
  br label %b14
b13:
  %v115 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v109, i64 0
  store i64 %v115, ptr %st58
  br label %b14
b14:
  %v130.p = getelementptr i64, ptr %v109, i64 0
  %v130 = load i64, ptr %v130.p
  %v131 = add i64 0, 0
  %v132.c = icmp ne i64 %v130, %v131
  %v132 = zext i1 %v132.c to i64
  %c.b14 = icmp ne i64 %v132, 0
  br i1 %c.b14, label %b14.t60, label %b14.e61
b14.t60:
  br label %b15
b14.e61:
  br label %b10
b15:
  %v133 = add i64 0, 1
  %v134 = getelementptr i64, ptr %v109, i64 %v133
  %v135.p = getelementptr i64, ptr %v134, i64 0
  %v135 = load i64, ptr %v135.p
  %v136 = add i64 0, 1
  %v137.c = icmp eq i64 %v135, %v136
  %v137 = zext i1 %v137.c to i64
  %c.b15 = icmp ne i64 %v137, 0
  br i1 %c.b15, label %b15.t62, label %b15.e63
b15.t62:
  br label %b16
b15.e63:
  br label %b10
b16:
  %v138.p = getelementptr i64, ptr %v134, i64 1
  %v138 = load i64, ptr %v138.p
  %v139 = getelementptr i64, ptr @"str.5", i64 0
  %v140 = add i64 0, 8
  %v141 = add i64 0, 0
  %v142 = getelementptr i64, ptr %s11, i64 0
  %v143 = ptrtoint ptr %v139 to i64
  %st63 = getelementptr i64, ptr %v142, i64 0
  store i64 %v143, ptr %st63
  %st64 = getelementptr i64, ptr %v142, i64 1
  store i64 %v140, ptr %st64
  %st65 = getelementptr i64, ptr %v142, i64 2
  store i64 %v141, ptr %st65
  %v144 = getelementptr i64, ptr %s12, i64 0
  call void @"std/convert.FormatInt"(ptr %v144, i64 %v108)
  %v145.p = getelementptr i64, ptr %v142, i64 1
  %v145 = load i64, ptr %v145.p
  %v146.p = getelementptr i64, ptr %v144, i64 1
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 %v145, %v146
  %v470 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v470, i64 0
  %v148 = load i64, ptr %v148.p
  %v149.p = getelementptr i64, ptr %v142, i64 0
  %v149 = load i64, ptr %v149.p
  %v150.p = getelementptr i64, ptr %v142, i64 1
  %v150 = load i64, ptr %v150.p
  %v151.p = getelementptr i64, ptr %v142, i64 2
  %v151 = load i64, ptr %v151.p
  %v152 = call ptr @"rt.cat8"(i64 %v149, i64 %v150, i64 %v151, i64 %v148, i64 %v146)
  %v153 = getelementptr i8, ptr %v152, i64 %v145
  %v154.p = getelementptr i64, ptr %v144, i64 0
  %v154 = load i64, ptr %v154.p
  %v155 = inttoptr i64 %v154 to ptr
  call void @"rt.copy8"(ptr %v153, ptr %v155, i64 %v146)
  %v156 = getelementptr i64, ptr %s13, i64 0
  %v157 = ptrtoint ptr %v152 to i64
  %st66 = getelementptr i64, ptr %v156, i64 0
  store i64 %v157, ptr %st66
  %st67 = getelementptr i64, ptr %v156, i64 1
  store i64 %v147, ptr %st67
  %st68 = getelementptr i64, ptr %v156, i64 2
  store i64 %v148, ptr %st68
  %v158 = getelementptr i64, ptr @"str.7", i64 0
  %v159 = add i64 0, 9
  %v160 = add i64 0, 0
  %v161 = getelementptr i64, ptr %s14, i64 0
  %v162 = ptrtoint ptr %v158 to i64
  %st69 = getelementptr i64, ptr %v161, i64 0
  store i64 %v162, ptr %st69
  %st70 = getelementptr i64, ptr %v161, i64 1
  store i64 %v159, ptr %st70
  %st71 = getelementptr i64, ptr %v161, i64 2
  store i64 %v160, ptr %st71
  %v163.p = getelementptr i64, ptr %v156, i64 1
  %v163 = load i64, ptr %v163.p
  %v164.p = getelementptr i64, ptr %v161, i64 1
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 %v163, %v164
  %v471 = getelementptr i64, ptr @"rt.meta", i64 0
  %v166.p = getelementptr i64, ptr %v471, i64 0
  %v166 = load i64, ptr %v166.p
  %v167.p = getelementptr i64, ptr %v156, i64 0
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v156, i64 1
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v156, i64 2
  %v169 = load i64, ptr %v169.p
  %v170 = call ptr @"rt.cat8"(i64 %v167, i64 %v168, i64 %v169, i64 %v166, i64 %v164)
  %v171 = getelementptr i8, ptr %v170, i64 %v163
  %v172.p = getelementptr i64, ptr %v161, i64 0
  %v172 = load i64, ptr %v172.p
  %v173 = inttoptr i64 %v172 to ptr
  call void @"rt.copy8"(ptr %v171, ptr %v173, i64 %v164)
  %v174 = getelementptr i64, ptr %s15, i64 0
  %v175 = ptrtoint ptr %v170 to i64
  %st72 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st72
  %st73 = getelementptr i64, ptr %v174, i64 1
  store i64 %v165, ptr %st73
  %st74 = getelementptr i64, ptr %v174, i64 2
  store i64 %v166, ptr %st74
  %v176 = getelementptr i64, ptr %s16, i64 0
  call void @"std/convert.FormatInt"(ptr %v176, i64 %v138)
  %v177.p = getelementptr i64, ptr %v174, i64 1
  %v177 = load i64, ptr %v177.p
  %v178.p = getelementptr i64, ptr %v176, i64 1
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 %v177, %v178
  %v472 = getelementptr i64, ptr @"rt.meta", i64 0
  %v180.p = getelementptr i64, ptr %v472, i64 0
  %v180 = load i64, ptr %v180.p
  %v181.p = getelementptr i64, ptr %v174, i64 0
  %v181 = load i64, ptr %v181.p
  %v182.p = getelementptr i64, ptr %v174, i64 1
  %v182 = load i64, ptr %v182.p
  %v183.p = getelementptr i64, ptr %v174, i64 2
  %v183 = load i64, ptr %v183.p
  %v184 = call ptr @"rt.cat8"(i64 %v181, i64 %v182, i64 %v183, i64 %v180, i64 %v178)
  %v185 = getelementptr i8, ptr %v184, i64 %v177
  %v186.p = getelementptr i64, ptr %v176, i64 0
  %v186 = load i64, ptr %v186.p
  %v187 = inttoptr i64 %v186 to ptr
  call void @"rt.copy8"(ptr %v185, ptr %v187, i64 %v178)
  %v188 = getelementptr i64, ptr %s17, i64 0
  %v189 = ptrtoint ptr %v184 to i64
  %st75 = getelementptr i64, ptr %v188, i64 0
  store i64 %v189, ptr %st75
  %st76 = getelementptr i64, ptr %v188, i64 1
  store i64 %v179, ptr %st76
  %st77 = getelementptr i64, ptr %v188, i64 2
  store i64 %v180, ptr %st77
  call void @"rt.print_str"(ptr %v188)
  %v190 = add i64 0, 10
  call void @"rt.print_char"(i64 %v190)
  br label %b43
b17:
  %v306.p = getelementptr i64, ptr %v13, i64 0
  %v306 = load i64, ptr %v306.p
  %v307 = add i64 0, 2
  %v308.c = icmp eq i64 %v306, %v307
  %v308 = zext i1 %v308.c to i64
  %c.b17 = icmp ne i64 %v308, 0
  br i1 %c.b17, label %b17.t79, label %b17.e80
b17.t79:
  br label %b30
b17.e80:
  br label %b29
b18:
  %v194.p = getelementptr i64, ptr %v13, i64 1
  %v194 = load i64, ptr %v194.p
  %v195 = getelementptr i64, ptr %s18, i64 0
  %v196 = add i64 0, 2
  %v197 = getelementptr i64, ptr %v13, i64 %v196
  %v198.p = getelementptr i64, ptr %v197, i64 1
  %v198 = load i64, ptr %v198.p
  %v199 = add i64 0, 0
  %v200.c = icmp ne i64 %v198, %v199
  %v200 = zext i1 %v200.c to i64
  %c.b18 = icmp ne i64 %v200, 0
  br i1 %c.b18, label %b18.t81, label %b18.e82
b18.t81:
  br label %b19
b18.e82:
  br label %b20
b19:
  %v202 = add i64 0, 1
  %st82 = getelementptr i64, ptr %v195, i64 0
  store i64 %v202, ptr %st82
  %v203 = add i64 0, 1
  %v204 = sub i64 %v198, %v203
  %v205.p = getelementptr i64, ptr %v197, i64 0
  %v205 = load i64, ptr %v205.p
  %v206 = inttoptr i64 %v205 to ptr
  %v207 = add i64 0, 2
  %v208 = mul i64 %v204, %v207
  %v209 = getelementptr i64, ptr %v206, i64 %v208
  %v210.p = getelementptr i64, ptr %v209, i64 0
  %v210 = load i64, ptr %v210.p
  %st83 = getelementptr i64, ptr %v195, i64 1
  store i64 %v210, ptr %st83
  %v211.p = getelementptr i64, ptr %v209, i64 1
  %v211 = load i64, ptr %v211.p
  %st84 = getelementptr i64, ptr %v195, i64 2
  store i64 %v211, ptr %st84
  %v212 = add i64 0, 3
  %v213 = getelementptr i64, ptr %v195, i64 %v212
  %v214.p = getelementptr i64, ptr %v197, i64 0
  %v214 = load i64, ptr %v214.p
  %st85 = getelementptr i64, ptr %v213, i64 0
  store i64 %v214, ptr %st85
  %st86 = getelementptr i64, ptr %v213, i64 1
  store i64 %v204, ptr %st86
  %v215.p = getelementptr i64, ptr %v197, i64 2
  %v215 = load i64, ptr %v215.p
  %st87 = getelementptr i64, ptr %v213, i64 2
  store i64 %v215, ptr %st87
  br label %b21
b20:
  %v201 = add i64 0, 0
  %st88 = getelementptr i64, ptr %v195, i64 0
  store i64 %v201, ptr %st88
  br label %b21
b21:
  %v216.p = getelementptr i64, ptr %v195, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 0
  %v218.c = icmp ne i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b21 = icmp ne i64 %v218, 0
  br i1 %c.b21, label %b21.t90, label %b21.e91
b21.t90:
  br label %b22
b21.e91:
  br label %b17
b22:
  %v219 = add i64 0, 1
  %v220 = getelementptr i64, ptr %v195, i64 %v219
  %v221.p = getelementptr i64, ptr %v220, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = add i64 0, 2
  %v223.c = icmp eq i64 %v221, %v222
  %v223 = zext i1 %v223.c to i64
  %c.b22 = icmp ne i64 %v223, 0
  br i1 %c.b22, label %b22.t92, label %b22.e93
b22.t92:
  br label %b23
b22.e93:
  br label %b17
b23:
  %v224 = getelementptr i64, ptr %s19, i64 0
  %v225 = add i64 0, 2
  %v226 = getelementptr i64, ptr %v220, i64 %v225
  %v227.p = getelementptr i64, ptr %v226, i64 1
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 0, 0
  %v229.c = icmp ne i64 %v227, %v228
  %v229 = zext i1 %v229.c to i64
  %c.b23 = icmp ne i64 %v229, 0
  br i1 %c.b23, label %b23.t94, label %b23.e95
b23.t94:
  br label %b24
b23.e95:
  br label %b25
b24:
  %v231 = add i64 0, 1
  %st95 = getelementptr i64, ptr %v224, i64 0
  store i64 %v231, ptr %st95
  %v232 = add i64 0, 1
  %v233 = sub i64 %v227, %v232
  %v234.p = getelementptr i64, ptr %v226, i64 0
  %v234 = load i64, ptr %v234.p
  %v235 = inttoptr i64 %v234 to ptr
  %v236 = add i64 0, 2
  %v237 = mul i64 %v233, %v236
  %v238 = getelementptr i64, ptr %v235, i64 %v237
  %v239.p = getelementptr i64, ptr %v238, i64 0
  %v239 = load i64, ptr %v239.p
  %st96 = getelementptr i64, ptr %v224, i64 1
  store i64 %v239, ptr %st96
  %v240.p = getelementptr i64, ptr %v238, i64 1
  %v240 = load i64, ptr %v240.p
  %st97 = getelementptr i64, ptr %v224, i64 2
  store i64 %v240, ptr %st97
  %v241 = add i64 0, 3
  %v242 = getelementptr i64, ptr %v224, i64 %v241
  %v243.p = getelementptr i64, ptr %v226, i64 0
  %v243 = load i64, ptr %v243.p
  %st98 = getelementptr i64, ptr %v242, i64 0
  store i64 %v243, ptr %st98
  %st99 = getelementptr i64, ptr %v242, i64 1
  store i64 %v233, ptr %st99
  %v244.p = getelementptr i64, ptr %v226, i64 2
  %v244 = load i64, ptr %v244.p
  %st100 = getelementptr i64, ptr %v242, i64 2
  store i64 %v244, ptr %st100
  br label %b26
b25:
  %v230 = add i64 0, 0
  %st101 = getelementptr i64, ptr %v224, i64 0
  store i64 %v230, ptr %st101
  br label %b26
b26:
  %v245.p = getelementptr i64, ptr %v224, i64 0
  %v245 = load i64, ptr %v245.p
  %v246 = add i64 0, 0
  %v247.c = icmp ne i64 %v245, %v246
  %v247 = zext i1 %v247.c to i64
  %c.b26 = icmp ne i64 %v247, 0
  br i1 %c.b26, label %b26.t103, label %b26.e104
b26.t103:
  br label %b27
b26.e104:
  br label %b17
b27:
  %v248 = add i64 0, 1
  %v249 = getelementptr i64, ptr %v224, i64 %v248
  %v250.p = getelementptr i64, ptr %v249, i64 0
  %v250 = load i64, ptr %v250.p
  %v251 = add i64 0, 1
  %v252.c = icmp eq i64 %v250, %v251
  %v252 = zext i1 %v252.c to i64
  %c.b27 = icmp ne i64 %v252, 0
  br i1 %c.b27, label %b27.t105, label %b27.e106
b27.t105:
  br label %b28
b27.e106:
  br label %b17
b28:
  %v253.p = getelementptr i64, ptr %v249, i64 1
  %v253 = load i64, ptr %v253.p
  %v254 = getelementptr i64, ptr @"str.5", i64 0
  %v255 = add i64 0, 8
  %v256 = add i64 0, 0
  %v257 = getelementptr i64, ptr %s20, i64 0
  %v258 = ptrtoint ptr %v254 to i64
  %st106 = getelementptr i64, ptr %v257, i64 0
  store i64 %v258, ptr %st106
  %st107 = getelementptr i64, ptr %v257, i64 1
  store i64 %v255, ptr %st107
  %st108 = getelementptr i64, ptr %v257, i64 2
  store i64 %v256, ptr %st108
  %v259 = getelementptr i64, ptr %s21, i64 0
  call void @"std/convert.FormatInt"(ptr %v259, i64 %v194)
  %v260.p = getelementptr i64, ptr %v257, i64 1
  %v260 = load i64, ptr %v260.p
  %v261.p = getelementptr i64, ptr %v259, i64 1
  %v261 = load i64, ptr %v261.p
  %v262 = add i64 %v260, %v261
  %v473 = getelementptr i64, ptr @"rt.meta", i64 0
  %v263.p = getelementptr i64, ptr %v473, i64 0
  %v263 = load i64, ptr %v263.p
  %v264.p = getelementptr i64, ptr %v257, i64 0
  %v264 = load i64, ptr %v264.p
  %v265.p = getelementptr i64, ptr %v257, i64 1
  %v265 = load i64, ptr %v265.p
  %v266.p = getelementptr i64, ptr %v257, i64 2
  %v266 = load i64, ptr %v266.p
  %v267 = call ptr @"rt.cat8"(i64 %v264, i64 %v265, i64 %v266, i64 %v263, i64 %v261)
  %v268 = getelementptr i8, ptr %v267, i64 %v260
  %v269.p = getelementptr i64, ptr %v259, i64 0
  %v269 = load i64, ptr %v269.p
  %v270 = inttoptr i64 %v269 to ptr
  call void @"rt.copy8"(ptr %v268, ptr %v270, i64 %v261)
  %v271 = getelementptr i64, ptr %s22, i64 0
  %v272 = ptrtoint ptr %v267 to i64
  %st109 = getelementptr i64, ptr %v271, i64 0
  store i64 %v272, ptr %st109
  %st110 = getelementptr i64, ptr %v271, i64 1
  store i64 %v262, ptr %st110
  %st111 = getelementptr i64, ptr %v271, i64 2
  store i64 %v263, ptr %st111
  %v273 = getelementptr i64, ptr @"str.8", i64 0
  %v274 = add i64 0, 15
  %v275 = add i64 0, 0
  %v276 = getelementptr i64, ptr %s23, i64 0
  %v277 = ptrtoint ptr %v273 to i64
  %st112 = getelementptr i64, ptr %v276, i64 0
  store i64 %v277, ptr %st112
  %st113 = getelementptr i64, ptr %v276, i64 1
  store i64 %v274, ptr %st113
  %st114 = getelementptr i64, ptr %v276, i64 2
  store i64 %v275, ptr %st114
  %v278.p = getelementptr i64, ptr %v271, i64 1
  %v278 = load i64, ptr %v278.p
  %v279.p = getelementptr i64, ptr %v276, i64 1
  %v279 = load i64, ptr %v279.p
  %v280 = add i64 %v278, %v279
  %v474 = getelementptr i64, ptr @"rt.meta", i64 0
  %v281.p = getelementptr i64, ptr %v474, i64 0
  %v281 = load i64, ptr %v281.p
  %v282.p = getelementptr i64, ptr %v271, i64 0
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v271, i64 1
  %v283 = load i64, ptr %v283.p
  %v284.p = getelementptr i64, ptr %v271, i64 2
  %v284 = load i64, ptr %v284.p
  %v285 = call ptr @"rt.cat8"(i64 %v282, i64 %v283, i64 %v284, i64 %v281, i64 %v279)
  %v286 = getelementptr i8, ptr %v285, i64 %v278
  %v287.p = getelementptr i64, ptr %v276, i64 0
  %v287 = load i64, ptr %v287.p
  %v288 = inttoptr i64 %v287 to ptr
  call void @"rt.copy8"(ptr %v286, ptr %v288, i64 %v279)
  %v289 = getelementptr i64, ptr %s24, i64 0
  %v290 = ptrtoint ptr %v285 to i64
  %st115 = getelementptr i64, ptr %v289, i64 0
  store i64 %v290, ptr %st115
  %st116 = getelementptr i64, ptr %v289, i64 1
  store i64 %v280, ptr %st116
  %st117 = getelementptr i64, ptr %v289, i64 2
  store i64 %v281, ptr %st117
  %v291 = getelementptr i64, ptr %s25, i64 0
  call void @"std/convert.FormatInt"(ptr %v291, i64 %v253)
  %v292.p = getelementptr i64, ptr %v289, i64 1
  %v292 = load i64, ptr %v292.p
  %v293.p = getelementptr i64, ptr %v291, i64 1
  %v293 = load i64, ptr %v293.p
  %v294 = add i64 %v292, %v293
  %v475 = getelementptr i64, ptr @"rt.meta", i64 0
  %v295.p = getelementptr i64, ptr %v475, i64 0
  %v295 = load i64, ptr %v295.p
  %v296.p = getelementptr i64, ptr %v289, i64 0
  %v296 = load i64, ptr %v296.p
  %v297.p = getelementptr i64, ptr %v289, i64 1
  %v297 = load i64, ptr %v297.p
  %v298.p = getelementptr i64, ptr %v289, i64 2
  %v298 = load i64, ptr %v298.p
  %v299 = call ptr @"rt.cat8"(i64 %v296, i64 %v297, i64 %v298, i64 %v295, i64 %v293)
  %v300 = getelementptr i8, ptr %v299, i64 %v292
  %v301.p = getelementptr i64, ptr %v291, i64 0
  %v301 = load i64, ptr %v301.p
  %v302 = inttoptr i64 %v301 to ptr
  call void @"rt.copy8"(ptr %v300, ptr %v302, i64 %v293)
  %v303 = getelementptr i64, ptr %s26, i64 0
  %v304 = ptrtoint ptr %v299 to i64
  %st118 = getelementptr i64, ptr %v303, i64 0
  store i64 %v304, ptr %st118
  %st119 = getelementptr i64, ptr %v303, i64 1
  store i64 %v294, ptr %st119
  %st120 = getelementptr i64, ptr %v303, i64 2
  store i64 %v295, ptr %st120
  call void @"rt.print_str"(ptr %v303)
  %v305 = add i64 0, 10
  call void @"rt.print_char"(i64 %v305)
  br label %b43
b29:
  %v411.p = getelementptr i64, ptr %v13, i64 0
  %v411 = load i64, ptr %v411.p
  %v412 = add i64 0, 0
  %v413.c = icmp eq i64 %v411, %v412
  %v413 = zext i1 %v413.c to i64
  %c.b29 = icmp ne i64 %v413, 0
  br i1 %c.b29, label %b29.t122, label %b29.e123
b29.t122:
  br label %b40
b29.e123:
  br label %b39
b30:
  %v309.p = getelementptr i64, ptr %v13, i64 1
  %v309 = load i64, ptr %v309.p
  %v310 = getelementptr i64, ptr %s27, i64 0
  %v311 = add i64 0, 2
  %v312 = getelementptr i64, ptr %v13, i64 %v311
  %v313.p = getelementptr i64, ptr %v312, i64 1
  %v313 = load i64, ptr %v313.p
  %v314 = add i64 0, 0
  %v315.c = icmp ne i64 %v313, %v314
  %v315 = zext i1 %v315.c to i64
  %c.b30 = icmp ne i64 %v315, 0
  br i1 %c.b30, label %b30.t124, label %b30.e125
b30.t124:
  br label %b31
b30.e125:
  br label %b32
b31:
  %v317 = add i64 0, 1
  %st125 = getelementptr i64, ptr %v310, i64 0
  store i64 %v317, ptr %st125
  %v318 = add i64 0, 1
  %v319 = sub i64 %v313, %v318
  %v320.p = getelementptr i64, ptr %v312, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = inttoptr i64 %v320 to ptr
  %v322 = add i64 0, 2
  %v323 = mul i64 %v319, %v322
  %v324 = getelementptr i64, ptr %v321, i64 %v323
  %v325.p = getelementptr i64, ptr %v324, i64 0
  %v325 = load i64, ptr %v325.p
  %st126 = getelementptr i64, ptr %v310, i64 1
  store i64 %v325, ptr %st126
  %v326.p = getelementptr i64, ptr %v324, i64 1
  %v326 = load i64, ptr %v326.p
  %st127 = getelementptr i64, ptr %v310, i64 2
  store i64 %v326, ptr %st127
  %v327 = add i64 0, 3
  %v328 = getelementptr i64, ptr %v310, i64 %v327
  %v329.p = getelementptr i64, ptr %v312, i64 0
  %v329 = load i64, ptr %v329.p
  %st128 = getelementptr i64, ptr %v328, i64 0
  store i64 %v329, ptr %st128
  %st129 = getelementptr i64, ptr %v328, i64 1
  store i64 %v319, ptr %st129
  %v330.p = getelementptr i64, ptr %v312, i64 2
  %v330 = load i64, ptr %v330.p
  %st130 = getelementptr i64, ptr %v328, i64 2
  store i64 %v330, ptr %st130
  br label %b33
b32:
  %v316 = add i64 0, 0
  %st131 = getelementptr i64, ptr %v310, i64 0
  store i64 %v316, ptr %st131
  br label %b33
b33:
  %v331.p = getelementptr i64, ptr %v310, i64 0
  %v331 = load i64, ptr %v331.p
  %v332 = add i64 0, 0
  %v333.c = icmp ne i64 %v331, %v332
  %v333 = zext i1 %v333.c to i64
  %c.b33 = icmp ne i64 %v333, 0
  br i1 %c.b33, label %b33.t133, label %b33.e134
b33.t133:
  br label %b34
b33.e134:
  br label %b29
b34:
  %v334 = add i64 0, 1
  %v335 = getelementptr i64, ptr %v310, i64 %v334
  %v336.p = getelementptr i64, ptr %v335, i64 0
  %v336 = load i64, ptr %v336.p
  %v337 = add i64 0, 2
  %v338.c = icmp eq i64 %v336, %v337
  %v338 = zext i1 %v338.c to i64
  %c.b34 = icmp ne i64 %v338, 0
  br i1 %c.b34, label %b34.t135, label %b34.e136
b34.t135:
  br label %b35
b34.e136:
  br label %b29
b35:
  %v339 = getelementptr i64, ptr %s28, i64 0
  %v340 = add i64 0, 2
  %v341 = getelementptr i64, ptr %v335, i64 %v340
  %v342.p = getelementptr i64, ptr %v341, i64 1
  %v342 = load i64, ptr %v342.p
  %v343 = add i64 0, 0
  %v344.c = icmp ne i64 %v342, %v343
  %v344 = zext i1 %v344.c to i64
  %c.b35 = icmp ne i64 %v344, 0
  br i1 %c.b35, label %b35.t137, label %b35.e138
b35.t137:
  br label %b36
b35.e138:
  br label %b37
b36:
  %v346 = add i64 0, 1
  %st138 = getelementptr i64, ptr %v339, i64 0
  store i64 %v346, ptr %st138
  %v347 = add i64 0, 1
  %v348 = sub i64 %v342, %v347
  %v349.p = getelementptr i64, ptr %v341, i64 0
  %v349 = load i64, ptr %v349.p
  %v350 = inttoptr i64 %v349 to ptr
  %v351 = add i64 0, 2
  %v352 = mul i64 %v348, %v351
  %v353 = getelementptr i64, ptr %v350, i64 %v352
  %v354.p = getelementptr i64, ptr %v353, i64 0
  %v354 = load i64, ptr %v354.p
  %st139 = getelementptr i64, ptr %v339, i64 1
  store i64 %v354, ptr %st139
  %v355.p = getelementptr i64, ptr %v353, i64 1
  %v355 = load i64, ptr %v355.p
  %st140 = getelementptr i64, ptr %v339, i64 2
  store i64 %v355, ptr %st140
  %v356 = add i64 0, 3
  %v357 = getelementptr i64, ptr %v339, i64 %v356
  %v358.p = getelementptr i64, ptr %v341, i64 0
  %v358 = load i64, ptr %v358.p
  %st141 = getelementptr i64, ptr %v357, i64 0
  store i64 %v358, ptr %st141
  %st142 = getelementptr i64, ptr %v357, i64 1
  store i64 %v348, ptr %st142
  %v359.p = getelementptr i64, ptr %v341, i64 2
  %v359 = load i64, ptr %v359.p
  %st143 = getelementptr i64, ptr %v357, i64 2
  store i64 %v359, ptr %st143
  br label %b38
b37:
  %v345 = add i64 0, 0
  %st144 = getelementptr i64, ptr %v339, i64 0
  store i64 %v345, ptr %st144
  br label %b38
b38:
  %v360 = getelementptr i64, ptr @"str.5", i64 0
  %v361 = add i64 0, 8
  %v362 = add i64 0, 0
  %v363 = getelementptr i64, ptr %s29, i64 0
  %v364 = ptrtoint ptr %v360 to i64
  %st145 = getelementptr i64, ptr %v363, i64 0
  store i64 %v364, ptr %st145
  %st146 = getelementptr i64, ptr %v363, i64 1
  store i64 %v361, ptr %st146
  %st147 = getelementptr i64, ptr %v363, i64 2
  store i64 %v362, ptr %st147
  %v365 = getelementptr i64, ptr %s30, i64 0
  call void @"std/convert.FormatInt"(ptr %v365, i64 %v309)
  %v366.p = getelementptr i64, ptr %v363, i64 1
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v365, i64 1
  %v367 = load i64, ptr %v367.p
  %v368 = add i64 %v366, %v367
  %v476 = getelementptr i64, ptr @"rt.meta", i64 0
  %v369.p = getelementptr i64, ptr %v476, i64 0
  %v369 = load i64, ptr %v369.p
  %v370.p = getelementptr i64, ptr %v363, i64 0
  %v370 = load i64, ptr %v370.p
  %v371.p = getelementptr i64, ptr %v363, i64 1
  %v371 = load i64, ptr %v371.p
  %v372.p = getelementptr i64, ptr %v363, i64 2
  %v372 = load i64, ptr %v372.p
  %v373 = call ptr @"rt.cat8"(i64 %v370, i64 %v371, i64 %v372, i64 %v369, i64 %v367)
  %v374 = getelementptr i8, ptr %v373, i64 %v366
  %v375.p = getelementptr i64, ptr %v365, i64 0
  %v375 = load i64, ptr %v375.p
  %v376 = inttoptr i64 %v375 to ptr
  call void @"rt.copy8"(ptr %v374, ptr %v376, i64 %v367)
  %v377 = getelementptr i64, ptr %s31, i64 0
  %v378 = ptrtoint ptr %v373 to i64
  %st148 = getelementptr i64, ptr %v377, i64 0
  store i64 %v378, ptr %st148
  %st149 = getelementptr i64, ptr %v377, i64 1
  store i64 %v368, ptr %st149
  %st150 = getelementptr i64, ptr %v377, i64 2
  store i64 %v369, ptr %st150
  %v379 = getelementptr i64, ptr @"str.9", i64 0
  %v380 = add i64 0, 6
  %v381 = add i64 0, 0
  %v382 = getelementptr i64, ptr %s32, i64 0
  %v383 = ptrtoint ptr %v379 to i64
  %st151 = getelementptr i64, ptr %v382, i64 0
  store i64 %v383, ptr %st151
  %st152 = getelementptr i64, ptr %v382, i64 1
  store i64 %v380, ptr %st152
  %st153 = getelementptr i64, ptr %v382, i64 2
  store i64 %v381, ptr %st153
  %v384.p = getelementptr i64, ptr %v377, i64 1
  %v384 = load i64, ptr %v384.p
  %v385.p = getelementptr i64, ptr %v382, i64 1
  %v385 = load i64, ptr %v385.p
  %v386 = add i64 %v384, %v385
  %v477 = getelementptr i64, ptr @"rt.meta", i64 0
  %v387.p = getelementptr i64, ptr %v477, i64 0
  %v387 = load i64, ptr %v387.p
  %v388.p = getelementptr i64, ptr %v377, i64 0
  %v388 = load i64, ptr %v388.p
  %v389.p = getelementptr i64, ptr %v377, i64 1
  %v389 = load i64, ptr %v389.p
  %v390.p = getelementptr i64, ptr %v377, i64 2
  %v390 = load i64, ptr %v390.p
  %v391 = call ptr @"rt.cat8"(i64 %v388, i64 %v389, i64 %v390, i64 %v387, i64 %v385)
  %v392 = getelementptr i8, ptr %v391, i64 %v384
  %v393.p = getelementptr i64, ptr %v382, i64 0
  %v393 = load i64, ptr %v393.p
  %v394 = inttoptr i64 %v393 to ptr
  call void @"rt.copy8"(ptr %v392, ptr %v394, i64 %v385)
  %v395 = getelementptr i64, ptr %s33, i64 0
  %v396 = ptrtoint ptr %v391 to i64
  %st154 = getelementptr i64, ptr %v395, i64 0
  store i64 %v396, ptr %st154
  %st155 = getelementptr i64, ptr %v395, i64 1
  store i64 %v386, ptr %st155
  %st156 = getelementptr i64, ptr %v395, i64 2
  store i64 %v387, ptr %st156
  call void @"rt.print_str"(ptr %v395)
  %v397 = add i64 0, 10
  call void @"rt.print_char"(i64 %v397)
  %v398 = getelementptr i64, ptr %s34, i64 0
  %v399 = add i64 0, 1
  %st157 = getelementptr i64, ptr %v398, i64 0
  store i64 %v399, ptr %st157
  %v400.p = getelementptr i64, ptr %v335, i64 0
  %v400 = load i64, ptr %v400.p
  %st158 = getelementptr i64, ptr %v398, i64 1
  store i64 %v400, ptr %st158
  %v401.p = getelementptr i64, ptr %v335, i64 1
  %v401 = load i64, ptr %v401.p
  %st159 = getelementptr i64, ptr %v398, i64 2
  store i64 %v401, ptr %st159
  %v402.p = getelementptr i64, ptr %v335, i64 2
  %v402 = load i64, ptr %v402.p
  %st160 = getelementptr i64, ptr %v398, i64 3
  store i64 %v402, ptr %st160
  %v403.p = getelementptr i64, ptr %v335, i64 3
  %v403 = load i64, ptr %v403.p
  %st161 = getelementptr i64, ptr %v398, i64 4
  store i64 %v403, ptr %st161
  %v404.p = getelementptr i64, ptr %v335, i64 4
  %v404 = load i64, ptr %v404.p
  %st162 = getelementptr i64, ptr %v398, i64 5
  store i64 %v404, ptr %st162
  %v405.p = getelementptr i64, ptr %v398, i64 0
  %v405 = load i64, ptr %v405.p
  %v406.p = getelementptr i64, ptr %v398, i64 1
  %v406 = load i64, ptr %v406.p
  %v407.p = getelementptr i64, ptr %v398, i64 2
  %v407 = load i64, ptr %v407.p
  %v408.p = getelementptr i64, ptr %v398, i64 3
  %v408 = load i64, ptr %v408.p
  %v409.p = getelementptr i64, ptr %v398, i64 4
  %v409 = load i64, ptr %v409.p
  %v410.p = getelementptr i64, ptr %v398, i64 5
  %v410 = load i64, ptr %v410.p
  call void @"main.show"(i64 %v405, i64 %v406, i64 %v407, i64 %v408, i64 %v409, i64 %v410)
  br label %b43
b39:
  %v435.p = getelementptr i64, ptr %v13, i64 0
  %v435 = load i64, ptr %v435.p
  %v436 = add i64 0, 1
  %v437.c = icmp eq i64 %v435, %v436
  %v437 = zext i1 %v437.c to i64
  %c.b39 = icmp ne i64 %v437, 0
  br i1 %c.b39, label %b39.t164, label %b39.e165
b39.t164:
  br label %b42
b39.e165:
  br label %b41
b40:
  %v414.p = getelementptr i64, ptr %v13, i64 1
  %v414 = load i64, ptr %v414.p
  %v415 = getelementptr i64, ptr @"str.0", i64 0
  %v416 = add i64 0, 10
  %v417 = add i64 0, 0
  %v418 = getelementptr i64, ptr %s33, i64 0
  %v419 = ptrtoint ptr %v415 to i64
  %st165 = getelementptr i64, ptr %v418, i64 0
  store i64 %v419, ptr %st165
  %st166 = getelementptr i64, ptr %v418, i64 1
  store i64 %v416, ptr %st166
  %st167 = getelementptr i64, ptr %v418, i64 2
  store i64 %v417, ptr %st167
  %v420 = getelementptr i64, ptr %s35, i64 0
  call void @"std/convert.FormatInt"(ptr %v420, i64 %v414)
  %v421.p = getelementptr i64, ptr %v418, i64 1
  %v421 = load i64, ptr %v421.p
  %v422.p = getelementptr i64, ptr %v420, i64 1
  %v422 = load i64, ptr %v422.p
  %v423 = add i64 %v421, %v422
  %v478 = getelementptr i64, ptr @"rt.meta", i64 0
  %v424.p = getelementptr i64, ptr %v478, i64 0
  %v424 = load i64, ptr %v424.p
  %v425.p = getelementptr i64, ptr %v418, i64 0
  %v425 = load i64, ptr %v425.p
  %v426.p = getelementptr i64, ptr %v418, i64 1
  %v426 = load i64, ptr %v426.p
  %v427.p = getelementptr i64, ptr %v418, i64 2
  %v427 = load i64, ptr %v427.p
  %v428 = call ptr @"rt.cat8"(i64 %v425, i64 %v426, i64 %v427, i64 %v424, i64 %v422)
  %v429 = getelementptr i8, ptr %v428, i64 %v421
  %v430.p = getelementptr i64, ptr %v420, i64 0
  %v430 = load i64, ptr %v430.p
  %v431 = inttoptr i64 %v430 to ptr
  call void @"rt.copy8"(ptr %v429, ptr %v431, i64 %v422)
  %v432 = getelementptr i64, ptr %s32, i64 0
  %v433 = ptrtoint ptr %v428 to i64
  %st168 = getelementptr i64, ptr %v432, i64 0
  store i64 %v433, ptr %st168
  %st169 = getelementptr i64, ptr %v432, i64 1
  store i64 %v423, ptr %st169
  %st170 = getelementptr i64, ptr %v432, i64 2
  store i64 %v424, ptr %st170
  call void @"rt.print_str"(ptr %v432)
  %v434 = add i64 0, 10
  call void @"rt.print_char"(i64 %v434)
  br label %b43
b41:
  %v459 = add i64 0, 5
  call void @"rt.panic"(i64 %v459)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b42:
  %v438.p = getelementptr i64, ptr %v13, i64 1
  %v438 = load i64, ptr %v438.p
  %v439 = getelementptr i64, ptr @"str.1", i64 0
  %v440 = add i64 0, 7
  %v441 = add i64 0, 0
  %v442 = getelementptr i64, ptr %s31, i64 0
  %v443 = ptrtoint ptr %v439 to i64
  %st171 = getelementptr i64, ptr %v442, i64 0
  store i64 %v443, ptr %st171
  %st172 = getelementptr i64, ptr %v442, i64 1
  store i64 %v440, ptr %st172
  %st173 = getelementptr i64, ptr %v442, i64 2
  store i64 %v441, ptr %st173
  %v444 = getelementptr i64, ptr %s36, i64 0
  call void @"std/convert.FormatInt"(ptr %v444, i64 %v438)
  %v445.p = getelementptr i64, ptr %v442, i64 1
  %v445 = load i64, ptr %v445.p
  %v446.p = getelementptr i64, ptr %v444, i64 1
  %v446 = load i64, ptr %v446.p
  %v447 = add i64 %v445, %v446
  %v479 = getelementptr i64, ptr @"rt.meta", i64 0
  %v448.p = getelementptr i64, ptr %v479, i64 0
  %v448 = load i64, ptr %v448.p
  %v449.p = getelementptr i64, ptr %v442, i64 0
  %v449 = load i64, ptr %v449.p
  %v450.p = getelementptr i64, ptr %v442, i64 1
  %v450 = load i64, ptr %v450.p
  %v451.p = getelementptr i64, ptr %v442, i64 2
  %v451 = load i64, ptr %v451.p
  %v452 = call ptr @"rt.cat8"(i64 %v449, i64 %v450, i64 %v451, i64 %v448, i64 %v446)
  %v453 = getelementptr i8, ptr %v452, i64 %v445
  %v454.p = getelementptr i64, ptr %v444, i64 0
  %v454 = load i64, ptr %v454.p
  %v455 = inttoptr i64 %v454 to ptr
  call void @"rt.copy8"(ptr %v453, ptr %v455, i64 %v446)
  %v456 = getelementptr i64, ptr %s29, i64 0
  %v457 = ptrtoint ptr %v452 to i64
  %st174 = getelementptr i64, ptr %v456, i64 0
  store i64 %v457, ptr %st174
  %st175 = getelementptr i64, ptr %v456, i64 1
  store i64 %v447, ptr %st175
  %st176 = getelementptr i64, ptr %v456, i64 2
  store i64 %v448, ptr %st176
  call void @"rt.print_str"(ptr %v456)
  %v458 = add i64 0, 10
  call void @"rt.print_char"(i64 %v458)
  br label %b43
b43:
  br label %b44
b44:
  %v480 = getelementptr i64, ptr @"rt.meta", i64 0
  %st177 = getelementptr i64, ptr %v480, i64 0
  store i64 %v7, ptr %st177
  ret void
}

define internal void @"main.open"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [2 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s1 = alloca [5 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
  %s1.z4 = getelementptr i64, ptr %s1, i64 4
  store i64 0, ptr %s1.z4
  %s2 = alloca [6 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s2.z5 = getelementptr i64, ptr %s2, i64 5
  store i64 0, ptr %s2.z5
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v72, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 0
  %v4.c = icmp eq i64 %v1, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = add i64 0, 5
  %v6 = getelementptr i64, ptr %s0, i64 0
  %v7 = add i64 0, 0
  %st2 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st2
  %st3 = getelementptr i64, ptr %v6, i64 1
  store i64 %v7, ptr %st3
  %v8 = add i64 0, 0
  %st4 = getelementptr i64, ptr %v6, i64 0
  store i64 %v8, ptr %st4
  %st5 = getelementptr i64, ptr %v6, i64 1
  store i64 %v5, ptr %st5
  %v9 = getelementptr i64, ptr %s1, i64 0
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %st6 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st6
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %st7 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st7
  %v12 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st8
  %st9 = getelementptr i64, ptr %v9, i64 3
  store i64 %v12, ptr %st9
  %st10 = getelementptr i64, ptr %v9, i64 4
  store i64 %v12, ptr %st10
  %v13 = getelementptr i64, ptr %s2, i64 0
  %v14 = add i64 0, 1
  %st11 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st11
  %v15.p = getelementptr i64, ptr %v9, i64 0
  %v15 = load i64, ptr %v15.p
  %st12 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st12
  %v16.p = getelementptr i64, ptr %v9, i64 1
  %v16 = load i64, ptr %v16.p
  %st13 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st13
  %v17.p = getelementptr i64, ptr %v9, i64 2
  %v17 = load i64, ptr %v17.p
  %st14 = getelementptr i64, ptr %v13, i64 3
  store i64 %v17, ptr %st14
  %v18.p = getelementptr i64, ptr %v9, i64 3
  %v18 = load i64, ptr %v18.p
  %st15 = getelementptr i64, ptr %v13, i64 4
  store i64 %v18, ptr %st15
  %v19.p = getelementptr i64, ptr %v9, i64 4
  %v19 = load i64, ptr %v19.p
  %st16 = getelementptr i64, ptr %v13, i64 5
  store i64 %v19, ptr %st16
  %v20.p = getelementptr i64, ptr %v13, i64 0
  %v20 = load i64, ptr %v20.p
  %st17 = getelementptr i64, ptr %v0, i64 0
  store i64 %v20, ptr %st17
  %v21.p = getelementptr i64, ptr %v13, i64 1
  %v21 = load i64, ptr %v21.p
  %st18 = getelementptr i64, ptr %v0, i64 1
  store i64 %v21, ptr %st18
  %v22.p = getelementptr i64, ptr %v13, i64 2
  %v22 = load i64, ptr %v22.p
  %st19 = getelementptr i64, ptr %v0, i64 2
  store i64 %v22, ptr %st19
  %v23.p = getelementptr i64, ptr %v13, i64 3
  %v23 = load i64, ptr %v23.p
  %st20 = getelementptr i64, ptr %v0, i64 3
  store i64 %v23, ptr %st20
  %v24.p = getelementptr i64, ptr %v13, i64 4
  %v24 = load i64, ptr %v24.p
  %st21 = getelementptr i64, ptr %v0, i64 4
  store i64 %v24, ptr %st21
  %v25.p = getelementptr i64, ptr %v13, i64 5
  %v25 = load i64, ptr %v25.p
  %st22 = getelementptr i64, ptr %v0, i64 5
  store i64 %v25, ptr %st22
  %v26.p = getelementptr i64, ptr %v0, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp ne i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b1 = icmp ne i64 %v28, 0
  br i1 %c.b1, label %b1.t24, label %b1.e25
b1.t24:
  br label %b3
b1.e25:
  br label %b4
b2:
  br label %b5
b3:
  %v29 = add i64 0, 3
  %v30 = getelementptr i64, ptr %v0, i64 %v29
  %v73 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v30, i64 %v73, i64 %v2)
  br label %b4
b4:
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v74, i64 0
  store i64 %v2, ptr %st25
  ret void
b5:
  %v31 = add i64 0, 1
  %v32.c = icmp eq i64 %v1, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b5 = icmp ne i64 %v32, 0
  br i1 %c.b5, label %b5.t27, label %b5.e28
b5.t27:
  br label %b6
b5.e28:
  br label %b7
b6:
  %v33 = add i64 0, 7
  %v34 = getelementptr i64, ptr %s0, i64 0
  %v35 = add i64 0, 0
  %st28 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st28
  %st29 = getelementptr i64, ptr %v34, i64 1
  store i64 %v35, ptr %st29
  %v36 = add i64 0, 1
  %st30 = getelementptr i64, ptr %v34, i64 0
  store i64 %v36, ptr %st30
  %st31 = getelementptr i64, ptr %v34, i64 1
  store i64 %v33, ptr %st31
  %v37 = getelementptr i64, ptr %s1, i64 0
  %v38.p = getelementptr i64, ptr %v34, i64 0
  %v38 = load i64, ptr %v38.p
  %st32 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st32
  %v39.p = getelementptr i64, ptr %v34, i64 1
  %v39 = load i64, ptr %v39.p
  %st33 = getelementptr i64, ptr %v37, i64 1
  store i64 %v39, ptr %st33
  %v40 = add i64 0, 0
  %st34 = getelementptr i64, ptr %v37, i64 2
  store i64 %v40, ptr %st34
  %st35 = getelementptr i64, ptr %v37, i64 3
  store i64 %v40, ptr %st35
  %st36 = getelementptr i64, ptr %v37, i64 4
  store i64 %v40, ptr %st36
  %v41 = getelementptr i64, ptr %s2, i64 0
  %v42 = add i64 0, 1
  %st37 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st37
  %v43.p = getelementptr i64, ptr %v37, i64 0
  %v43 = load i64, ptr %v43.p
  %st38 = getelementptr i64, ptr %v41, i64 1
  store i64 %v43, ptr %st38
  %v44.p = getelementptr i64, ptr %v37, i64 1
  %v44 = load i64, ptr %v44.p
  %st39 = getelementptr i64, ptr %v41, i64 2
  store i64 %v44, ptr %st39
  %v45.p = getelementptr i64, ptr %v37, i64 2
  %v45 = load i64, ptr %v45.p
  %st40 = getelementptr i64, ptr %v41, i64 3
  store i64 %v45, ptr %st40
  %v46.p = getelementptr i64, ptr %v37, i64 3
  %v46 = load i64, ptr %v46.p
  %st41 = getelementptr i64, ptr %v41, i64 4
  store i64 %v46, ptr %st41
  %v47.p = getelementptr i64, ptr %v37, i64 4
  %v47 = load i64, ptr %v47.p
  %st42 = getelementptr i64, ptr %v41, i64 5
  store i64 %v47, ptr %st42
  %v48.p = getelementptr i64, ptr %v41, i64 0
  %v48 = load i64, ptr %v48.p
  %st43 = getelementptr i64, ptr %v0, i64 0
  store i64 %v48, ptr %st43
  %v49.p = getelementptr i64, ptr %v41, i64 1
  %v49 = load i64, ptr %v49.p
  %st44 = getelementptr i64, ptr %v0, i64 1
  store i64 %v49, ptr %st44
  %v50.p = getelementptr i64, ptr %v41, i64 2
  %v50 = load i64, ptr %v50.p
  %st45 = getelementptr i64, ptr %v0, i64 2
  store i64 %v50, ptr %st45
  %v51.p = getelementptr i64, ptr %v41, i64 3
  %v51 = load i64, ptr %v51.p
  %st46 = getelementptr i64, ptr %v0, i64 3
  store i64 %v51, ptr %st46
  %v52.p = getelementptr i64, ptr %v41, i64 4
  %v52 = load i64, ptr %v52.p
  %st47 = getelementptr i64, ptr %v0, i64 4
  store i64 %v52, ptr %st47
  %v53.p = getelementptr i64, ptr %v41, i64 5
  %v53 = load i64, ptr %v53.p
  %st48 = getelementptr i64, ptr %v0, i64 5
  store i64 %v53, ptr %st48
  %v54.p = getelementptr i64, ptr %v0, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = add i64 0, 0
  %v56.c = icmp ne i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b6 = icmp ne i64 %v56, 0
  br i1 %c.b6, label %b6.t50, label %b6.e51
b6.t50:
  br label %b8
b6.e51:
  br label %b9
b7:
  br label %b10
b8:
  %v57 = add i64 0, 3
  %v58 = getelementptr i64, ptr %v0, i64 %v57
  %v75 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v58, i64 %v75, i64 %v2)
  br label %b9
b9:
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v76, i64 0
  store i64 %v2, ptr %st51
  ret void
b10:
  %v59 = getelementptr i64, ptr %s2, i64 0
  %v60 = add i64 0, 0
  %st52 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st52
  %v61.p = getelementptr i64, ptr %v59, i64 0
  %v61 = load i64, ptr %v61.p
  %st53 = getelementptr i64, ptr %v0, i64 0
  store i64 %v61, ptr %st53
  %v62.p = getelementptr i64, ptr %v59, i64 1
  %v62 = load i64, ptr %v62.p
  %st54 = getelementptr i64, ptr %v0, i64 1
  store i64 %v62, ptr %st54
  %v63.p = getelementptr i64, ptr %v59, i64 2
  %v63 = load i64, ptr %v63.p
  %st55 = getelementptr i64, ptr %v0, i64 2
  store i64 %v63, ptr %st55
  %v64.p = getelementptr i64, ptr %v59, i64 3
  %v64 = load i64, ptr %v64.p
  %st56 = getelementptr i64, ptr %v0, i64 3
  store i64 %v64, ptr %st56
  %v65.p = getelementptr i64, ptr %v59, i64 4
  %v65 = load i64, ptr %v65.p
  %st57 = getelementptr i64, ptr %v0, i64 4
  store i64 %v65, ptr %st57
  %v66.p = getelementptr i64, ptr %v59, i64 5
  %v66 = load i64, ptr %v66.p
  %st58 = getelementptr i64, ptr %v0, i64 5
  store i64 %v66, ptr %st58
  %v67.p = getelementptr i64, ptr %v0, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 0
  %v69.c = icmp ne i64 %v67, %v68
  %v69 = zext i1 %v69.c to i64
  %c.b10 = icmp ne i64 %v69, 0
  br i1 %c.b10, label %b10.t60, label %b10.e61
b10.t60:
  br label %b11
b10.e61:
  br label %b12
b11:
  %v70 = add i64 0, 3
  %v71 = getelementptr i64, ptr %v0, i64 %v70
  %v77 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v71, i64 %v77, i64 %v2)
  br label %b12
b12:
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v78, i64 0
  store i64 %v2, ptr %st61
  ret void
}

define internal void @"main.show2"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
b0:
  %s0 = alloca [6 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %s0.z4 = getelementptr i64, ptr %s0, i64 4
  store i64 0, ptr %s0.z4
  %s0.z5 = getelementptr i64, ptr %s0, i64 5
  store i64 0, ptr %s0.z5
  %s1 = alloca [5 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
  %s1.z4 = getelementptr i64, ptr %s1, i64 4
  store i64 0, ptr %s1.z4
  %s2 = alloca [6 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s2.z5 = getelementptr i64, ptr %s2, i64 5
  store i64 0, ptr %s2.z5
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %st3 = getelementptr i64, ptr %v6, i64 3
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v6, i64 4
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v6, i64 5
  store i64 %v5, ptr %st5
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v105, i64 0
  %v7 = load i64, ptr %v7.p
  call void @"rt.region_enter"()
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp ne i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v11 = add i64 0, 1
  %v12 = getelementptr i64, ptr %v6, i64 %v11
  %v13 = getelementptr i64, ptr %s1, i64 0
  %v14.p = getelementptr i64, ptr %v12, i64 0
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v12, i64 1
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v12, i64 2
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st10
  %v17.p = getelementptr i64, ptr %v12, i64 3
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v13, i64 3
  store i64 %v17, ptr %st11
  %v18.p = getelementptr i64, ptr %v12, i64 4
  %v18 = load i64, ptr %v18.p
  %st12 = getelementptr i64, ptr %v13, i64 4
  store i64 %v18, ptr %st12
  %v19.p = getelementptr i64, ptr %v13, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 2
  %v21.c = icmp eq i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b1 = icmp ne i64 %v21, 0
  br i1 %c.b1, label %b1.t14, label %b1.e15
b1.t14:
  br label %b4
b1.e15:
  br label %b3
b2:
  %v99 = getelementptr i64, ptr @"str.2", i64 0
  %v100 = add i64 0, 2
  %v101 = add i64 0, 0
  %v102 = getelementptr i64, ptr %s9, i64 0
  %v103 = ptrtoint ptr %v99 to i64
  %st15 = getelementptr i64, ptr %v102, i64 0
  store i64 %v103, ptr %st15
  %st16 = getelementptr i64, ptr %v102, i64 1
  store i64 %v100, ptr %st16
  %st17 = getelementptr i64, ptr %v102, i64 2
  store i64 %v101, ptr %st17
  call void @"rt.print_str"(ptr %v102)
  %v104 = add i64 0, 10
  call void @"rt.print_char"(i64 %v104)
  br label %b13
b3:
  %v50.p = getelementptr i64, ptr %v13, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 0
  %v52.c = icmp eq i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b3 = icmp ne i64 %v52, 0
  br i1 %c.b3, label %b3.t19, label %b3.e20
b3.t19:
  br label %b9
b3.e20:
  br label %b8
b4:
  %v22.p = getelementptr i64, ptr %v13, i64 1
  %v22 = load i64, ptr %v22.p
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24 = add i64 0, 2
  %v25 = getelementptr i64, ptr %v13, i64 %v24
  %v26.p = getelementptr i64, ptr %v25, i64 1
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp ne i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b4 = icmp ne i64 %v28, 0
  br i1 %c.b4, label %b4.t21, label %b4.e22
b4.t21:
  br label %b5
b4.e22:
  br label %b6
b5:
  %v30 = add i64 0, 1
  %st22 = getelementptr i64, ptr %v23, i64 0
  store i64 %v30, ptr %st22
  %v31 = add i64 0, 1
  %v32 = sub i64 %v26, %v31
  %v33.p = getelementptr i64, ptr %v25, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = inttoptr i64 %v33 to ptr
  %v35 = add i64 0, 2
  %v36 = mul i64 %v32, %v35
  %v37 = getelementptr i64, ptr %v34, i64 %v36
  %v38.p = getelementptr i64, ptr %v37, i64 0
  %v38 = load i64, ptr %v38.p
  %st23 = getelementptr i64, ptr %v23, i64 1
  store i64 %v38, ptr %st23
  %v39.p = getelementptr i64, ptr %v37, i64 1
  %v39 = load i64, ptr %v39.p
  %st24 = getelementptr i64, ptr %v23, i64 2
  store i64 %v39, ptr %st24
  %v40 = add i64 0, 3
  %v41 = getelementptr i64, ptr %v23, i64 %v40
  %v42.p = getelementptr i64, ptr %v25, i64 0
  %v42 = load i64, ptr %v42.p
  %st25 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st25
  %st26 = getelementptr i64, ptr %v41, i64 1
  store i64 %v32, ptr %st26
  %v43.p = getelementptr i64, ptr %v25, i64 2
  %v43 = load i64, ptr %v43.p
  %st27 = getelementptr i64, ptr %v41, i64 2
  store i64 %v43, ptr %st27
  br label %b7
b6:
  %v29 = add i64 0, 0
  %st28 = getelementptr i64, ptr %v23, i64 0
  store i64 %v29, ptr %st28
  br label %b7
b7:
  %v44.p = getelementptr i64, ptr %v23, i64 0
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v23, i64 1
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v23, i64 2
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v23, i64 3
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v23, i64 4
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v23, i64 5
  %v49 = load i64, ptr %v49.p
  call void @"main.inner"(i64 %v22, i64 %v44, i64 %v45, i64 %v46, i64 %v47, i64 %v48, i64 %v49)
  br label %b12
b8:
  %v74.p = getelementptr i64, ptr %v13, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 1
  %v76.c = icmp eq i64 %v74, %v75
  %v76 = zext i1 %v76.c to i64
  %c.b8 = icmp ne i64 %v76, 0
  br i1 %c.b8, label %b8.t30, label %b8.e31
b8.t30:
  br label %b11
b8.e31:
  br label %b10
b9:
  %v53.p = getelementptr i64, ptr %v13, i64 1
  %v53 = load i64, ptr %v53.p
  %v54 = getelementptr i64, ptr @"str.0", i64 0
  %v55 = add i64 0, 10
  %v56 = add i64 0, 0
  %v57 = getelementptr i64, ptr %s3, i64 0
  %v58 = ptrtoint ptr %v54 to i64
  %st31 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st31
  %st32 = getelementptr i64, ptr %v57, i64 1
  store i64 %v55, ptr %st32
  %st33 = getelementptr i64, ptr %v57, i64 2
  store i64 %v56, ptr %st33
  %v59 = getelementptr i64, ptr %s4, i64 0
  call void @"std/convert.FormatInt"(ptr %v59, i64 %v53)
  %v60.p = getelementptr i64, ptr %v57, i64 1
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v59, i64 1
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 %v60, %v61
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %v63.p = getelementptr i64, ptr %v106, i64 0
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v57, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v57, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v57, i64 2
  %v66 = load i64, ptr %v66.p
  %v67 = call ptr @"rt.cat8"(i64 %v64, i64 %v65, i64 %v66, i64 %v63, i64 %v61)
  %v68 = getelementptr i8, ptr %v67, i64 %v60
  %v69.p = getelementptr i64, ptr %v59, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = inttoptr i64 %v69 to ptr
  call void @"rt.copy8"(ptr %v68, ptr %v70, i64 %v61)
  %v71 = getelementptr i64, ptr %s5, i64 0
  %v72 = ptrtoint ptr %v67 to i64
  %st34 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st34
  %st35 = getelementptr i64, ptr %v71, i64 1
  store i64 %v62, ptr %st35
  %st36 = getelementptr i64, ptr %v71, i64 2
  store i64 %v63, ptr %st36
  call void @"rt.print_str"(ptr %v71)
  %v73 = add i64 0, 10
  call void @"rt.print_char"(i64 %v73)
  br label %b12
b10:
  %v98 = add i64 0, 0
  call void @"rt.panic"(i64 %v98)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v77.p = getelementptr i64, ptr %v13, i64 1
  %v77 = load i64, ptr %v77.p
  %v78 = getelementptr i64, ptr @"str.1", i64 0
  %v79 = add i64 0, 7
  %v80 = add i64 0, 0
  %v81 = getelementptr i64, ptr %s6, i64 0
  %v82 = ptrtoint ptr %v78 to i64
  %st37 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st37
  %st38 = getelementptr i64, ptr %v81, i64 1
  store i64 %v79, ptr %st38
  %st39 = getelementptr i64, ptr %v81, i64 2
  store i64 %v80, ptr %st39
  %v83 = getelementptr i64, ptr %s7, i64 0
  call void @"std/convert.FormatInt"(ptr %v83, i64 %v77)
  %v84.p = getelementptr i64, ptr %v81, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v83, i64 1
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 %v84, %v85
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v107, i64 0
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v81, i64 0
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v81, i64 1
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v81, i64 2
  %v90 = load i64, ptr %v90.p
  %v91 = call ptr @"rt.cat8"(i64 %v88, i64 %v89, i64 %v90, i64 %v87, i64 %v85)
  %v92 = getelementptr i8, ptr %v91, i64 %v84
  %v93.p = getelementptr i64, ptr %v83, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = inttoptr i64 %v93 to ptr
  call void @"rt.copy8"(ptr %v92, ptr %v94, i64 %v85)
  %v95 = getelementptr i64, ptr %s8, i64 0
  %v96 = ptrtoint ptr %v91 to i64
  %st40 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st40
  %st41 = getelementptr i64, ptr %v95, i64 1
  store i64 %v86, ptr %st41
  %st42 = getelementptr i64, ptr %v95, i64 2
  store i64 %v87, ptr %st42
  call void @"rt.print_str"(ptr %v95)
  %v97 = add i64 0, 10
  call void @"rt.print_char"(i64 %v97)
  br label %b12
b12:
  br label %b13
b13:
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v108, i64 0
  store i64 %v7, ptr %st43
  ret void
}

define internal void @"main.load"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [6 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %s0.z4 = getelementptr i64, ptr %s0, i64 4
  store i64 0, ptr %s0.z4
  %s0.z5 = getelementptr i64, ptr %s0, i64 5
  store i64 0, ptr %s0.z5
  %s1 = alloca [2 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s2 = alloca [5 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s3 = alloca [6 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s3.z3 = getelementptr i64, ptr %s3, i64 3
  store i64 0, ptr %s3.z3
  %s3.z4 = getelementptr i64, ptr %s3, i64 4
  store i64 0, ptr %s3.z4
  %s3.z5 = getelementptr i64, ptr %s3, i64 5
  store i64 0, ptr %s3.z5
  %v69 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v69, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = getelementptr i64, ptr %s0, i64 0
  call void @"main.open"(ptr %v3, i64 %v1)
  %v4.p = getelementptr i64, ptr %v3, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp ne i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b0 = icmp ne i64 %v6, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v7 = add i64 0, 0
  %v8 = getelementptr i64, ptr %s1, i64 0
  %v9 = add i64 0, 0
  %st2 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st2
  %st3 = getelementptr i64, ptr %v8, i64 1
  store i64 %v9, ptr %st3
  %v10 = add i64 0, 2
  %st4 = getelementptr i64, ptr %v8, i64 0
  store i64 %v10, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 1
  store i64 %v1, ptr %st5
  %v11 = getelementptr i64, ptr %s2, i64 0
  %v12.p = getelementptr i64, ptr %v8, i64 0
  %v12 = load i64, ptr %v12.p
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st6
  %v13.p = getelementptr i64, ptr %v8, i64 1
  %v13 = load i64, ptr %v13.p
  %st7 = getelementptr i64, ptr %v11, i64 1
  store i64 %v13, ptr %st7
  %v14 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v11, i64 2
  store i64 %v14, ptr %st8
  %st9 = getelementptr i64, ptr %v11, i64 3
  store i64 %v14, ptr %st9
  %st10 = getelementptr i64, ptr %v11, i64 4
  store i64 %v14, ptr %st10
  %v15 = add i64 0, 2
  %v16 = getelementptr i64, ptr %v11, i64 %v15
  %v17 = add i64 0, 1
  %v18 = getelementptr i64, ptr %v3, i64 %v17
  %v19 = add i64 0, 2
  %v20 = getelementptr i64, ptr %v18, i64 %v19
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v70, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v20, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v20, i64 1
  %v23 = load i64, ptr %v23.p
  br label %b4
b2:
  %v56 = getelementptr i64, ptr %s3, i64 0
  %v57 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st11
  %v58.p = getelementptr i64, ptr %v56, i64 0
  %v58 = load i64, ptr %v58.p
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v58, ptr %st12
  %v59.p = getelementptr i64, ptr %v56, i64 1
  %v59 = load i64, ptr %v59.p
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v59, ptr %st13
  %v60.p = getelementptr i64, ptr %v56, i64 2
  %v60 = load i64, ptr %v60.p
  %st14 = getelementptr i64, ptr %v0, i64 2
  store i64 %v60, ptr %st14
  %v61.p = getelementptr i64, ptr %v56, i64 3
  %v61 = load i64, ptr %v61.p
  %st15 = getelementptr i64, ptr %v0, i64 3
  store i64 %v61, ptr %st15
  %v62.p = getelementptr i64, ptr %v56, i64 4
  %v62 = load i64, ptr %v62.p
  %st16 = getelementptr i64, ptr %v0, i64 4
  store i64 %v62, ptr %st16
  %v63.p = getelementptr i64, ptr %v56, i64 5
  %v63 = load i64, ptr %v63.p
  %st17 = getelementptr i64, ptr %v0, i64 5
  store i64 %v63, ptr %st17
  %v64.p = getelementptr i64, ptr %v0, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 0
  %v66.c = icmp ne i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b2 = icmp ne i64 %v66, 0
  br i1 %c.b2, label %b2.t19, label %b2.e20
b2.t19:
  br label %b7
b2.e20:
  br label %b8
b3:
  %v24 = phi ptr [ %v30, %b4 ]
  %v25 = phi ptr [ %v31, %b4 ]
  %v32.p = getelementptr i64, ptr %v18, i64 0
  %v32 = load i64, ptr %v32.p
  %st20 = getelementptr i64, ptr %v25, i64 0
  store i64 %v32, ptr %st20
  %v33.p = getelementptr i64, ptr %v18, i64 1
  %v33 = load i64, ptr %v33.p
  %st21 = getelementptr i64, ptr %v25, i64 1
  store i64 %v33, ptr %st21
  %v34 = ptrtoint ptr %v24 to i64
  %st22 = getelementptr i64, ptr %v16, i64 0
  store i64 %v34, ptr %st22
  %v35.p = getelementptr i64, ptr %v20, i64 1
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 1
  %v37 = add i64 %v35, %v36
  %st23 = getelementptr i64, ptr %v16, i64 1
  store i64 %v37, ptr %st23
  %st24 = getelementptr i64, ptr %v16, i64 2
  store i64 %v21, ptr %st24
  %v38 = getelementptr i64, ptr %s3, i64 0
  %v39 = add i64 0, 1
  %st25 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st25
  %v40.p = getelementptr i64, ptr %v11, i64 0
  %v40 = load i64, ptr %v40.p
  %st26 = getelementptr i64, ptr %v38, i64 1
  store i64 %v40, ptr %st26
  %v41.p = getelementptr i64, ptr %v11, i64 1
  %v41 = load i64, ptr %v41.p
  %st27 = getelementptr i64, ptr %v38, i64 2
  store i64 %v41, ptr %st27
  %v42.p = getelementptr i64, ptr %v11, i64 2
  %v42 = load i64, ptr %v42.p
  %st28 = getelementptr i64, ptr %v38, i64 3
  store i64 %v42, ptr %st28
  %v43.p = getelementptr i64, ptr %v11, i64 3
  %v43 = load i64, ptr %v43.p
  %st29 = getelementptr i64, ptr %v38, i64 4
  store i64 %v43, ptr %st29
  %v44.p = getelementptr i64, ptr %v11, i64 4
  %v44 = load i64, ptr %v44.p
  %st30 = getelementptr i64, ptr %v38, i64 5
  store i64 %v44, ptr %st30
  %v45.p = getelementptr i64, ptr %v38, i64 0
  %v45 = load i64, ptr %v45.p
  %st31 = getelementptr i64, ptr %v0, i64 0
  store i64 %v45, ptr %st31
  %v46.p = getelementptr i64, ptr %v38, i64 1
  %v46 = load i64, ptr %v46.p
  %st32 = getelementptr i64, ptr %v0, i64 1
  store i64 %v46, ptr %st32
  %v47.p = getelementptr i64, ptr %v38, i64 2
  %v47 = load i64, ptr %v47.p
  %st33 = getelementptr i64, ptr %v0, i64 2
  store i64 %v47, ptr %st33
  %v48.p = getelementptr i64, ptr %v38, i64 3
  %v48 = load i64, ptr %v48.p
  %st34 = getelementptr i64, ptr %v0, i64 3
  store i64 %v48, ptr %st34
  %v49.p = getelementptr i64, ptr %v38, i64 4
  %v49 = load i64, ptr %v49.p
  %st35 = getelementptr i64, ptr %v0, i64 4
  store i64 %v49, ptr %st35
  %v50.p = getelementptr i64, ptr %v38, i64 5
  %v50 = load i64, ptr %v50.p
  %st36 = getelementptr i64, ptr %v0, i64 5
  store i64 %v50, ptr %st36
  %v51.p = getelementptr i64, ptr %v0, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp ne i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b3 = icmp ne i64 %v53, 0
  br i1 %c.b3, label %b3.t38, label %b3.e39
b3.t38:
  br label %b5
b3.e39:
  br label %b6
b4:
  %v26 = add i64 0, 2
  %v27 = mul i64 %v23, %v26
  %v28 = add i64 0, 2
  %v29 = add i64 0, 1
  %v30 = call ptr @"rt.slice_grow"(i64 %v22, i64 %v23, i64 %v28, i64 %v21, i64 %v29)
  %v31 = getelementptr i64, ptr %v30, i64 %v27
  br label %b3
b5:
  %v54 = add i64 0, 3
  %v55 = getelementptr i64, ptr %v0, i64 %v54
  %v71 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v55, i64 %v71, i64 %v2)
  br label %b6
b6:
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v72, i64 0
  store i64 %v2, ptr %st39
  ret void
b7:
  %v67 = add i64 0, 3
  %v68 = getelementptr i64, ptr %v0, i64 %v67
  %v73 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v68, i64 %v73, i64 %v2)
  br label %b8
b8:
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v74, i64 0
  store i64 %v2, ptr %st40
  ret void
}

define internal void @"main.twice"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [6 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %s0.z4 = getelementptr i64, ptr %s0, i64 4
  store i64 0, ptr %s0.z4
  %s0.z5 = getelementptr i64, ptr %s0, i64 5
  store i64 0, ptr %s0.z5
  %s1 = alloca [2 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s2 = alloca [5 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s3 = alloca [6 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s3.z3 = getelementptr i64, ptr %s3, i64 3
  store i64 0, ptr %s3.z3
  %s3.z4 = getelementptr i64, ptr %s3, i64 4
  store i64 0, ptr %s3.z4
  %s3.z5 = getelementptr i64, ptr %s3, i64 5
  store i64 0, ptr %s3.z5
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v70, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = getelementptr i64, ptr %s0, i64 0
  call void @"main.load"(ptr %v3, i64 %v1)
  %v4.p = getelementptr i64, ptr %v3, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp ne i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b0 = icmp ne i64 %v6, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v7 = add i64 0, 0
  %v8 = add i64 0, 10
  %v9 = getelementptr i64, ptr %s1, i64 0
  %v10 = add i64 0, 0
  %st2 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st2
  %st3 = getelementptr i64, ptr %v9, i64 1
  store i64 %v10, ptr %st3
  %v11 = add i64 0, 2
  %st4 = getelementptr i64, ptr %v9, i64 0
  store i64 %v11, ptr %st4
  %st5 = getelementptr i64, ptr %v9, i64 1
  store i64 %v8, ptr %st5
  %v12 = getelementptr i64, ptr %s2, i64 0
  %v13.p = getelementptr i64, ptr %v9, i64 0
  %v13 = load i64, ptr %v13.p
  %st6 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st6
  %v14.p = getelementptr i64, ptr %v9, i64 1
  %v14 = load i64, ptr %v14.p
  %st7 = getelementptr i64, ptr %v12, i64 1
  store i64 %v14, ptr %st7
  %v15 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v12, i64 2
  store i64 %v15, ptr %st8
  %st9 = getelementptr i64, ptr %v12, i64 3
  store i64 %v15, ptr %st9
  %st10 = getelementptr i64, ptr %v12, i64 4
  store i64 %v15, ptr %st10
  %v16 = add i64 0, 2
  %v17 = getelementptr i64, ptr %v12, i64 %v16
  %v18 = add i64 0, 1
  %v19 = getelementptr i64, ptr %v3, i64 %v18
  %v20 = add i64 0, 2
  %v21 = getelementptr i64, ptr %v19, i64 %v20
  %v71 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v71, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v21, i64 0
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v21, i64 1
  %v24 = load i64, ptr %v24.p
  br label %b4
b2:
  %v57 = getelementptr i64, ptr %s3, i64 0
  %v58 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st11
  %v59.p = getelementptr i64, ptr %v57, i64 0
  %v59 = load i64, ptr %v59.p
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v59, ptr %st12
  %v60.p = getelementptr i64, ptr %v57, i64 1
  %v60 = load i64, ptr %v60.p
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v60, ptr %st13
  %v61.p = getelementptr i64, ptr %v57, i64 2
  %v61 = load i64, ptr %v61.p
  %st14 = getelementptr i64, ptr %v0, i64 2
  store i64 %v61, ptr %st14
  %v62.p = getelementptr i64, ptr %v57, i64 3
  %v62 = load i64, ptr %v62.p
  %st15 = getelementptr i64, ptr %v0, i64 3
  store i64 %v62, ptr %st15
  %v63.p = getelementptr i64, ptr %v57, i64 4
  %v63 = load i64, ptr %v63.p
  %st16 = getelementptr i64, ptr %v0, i64 4
  store i64 %v63, ptr %st16
  %v64.p = getelementptr i64, ptr %v57, i64 5
  %v64 = load i64, ptr %v64.p
  %st17 = getelementptr i64, ptr %v0, i64 5
  store i64 %v64, ptr %st17
  %v65.p = getelementptr i64, ptr %v0, i64 0
  %v65 = load i64, ptr %v65.p
  %v66 = add i64 0, 0
  %v67.c = icmp ne i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b2 = icmp ne i64 %v67, 0
  br i1 %c.b2, label %b2.t19, label %b2.e20
b2.t19:
  br label %b7
b2.e20:
  br label %b8
b3:
  %v25 = phi ptr [ %v31, %b4 ]
  %v26 = phi ptr [ %v32, %b4 ]
  %v33.p = getelementptr i64, ptr %v19, i64 0
  %v33 = load i64, ptr %v33.p
  %st20 = getelementptr i64, ptr %v26, i64 0
  store i64 %v33, ptr %st20
  %v34.p = getelementptr i64, ptr %v19, i64 1
  %v34 = load i64, ptr %v34.p
  %st21 = getelementptr i64, ptr %v26, i64 1
  store i64 %v34, ptr %st21
  %v35 = ptrtoint ptr %v25 to i64
  %st22 = getelementptr i64, ptr %v17, i64 0
  store i64 %v35, ptr %st22
  %v36.p = getelementptr i64, ptr %v21, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 0, 1
  %v38 = add i64 %v36, %v37
  %st23 = getelementptr i64, ptr %v17, i64 1
  store i64 %v38, ptr %st23
  %st24 = getelementptr i64, ptr %v17, i64 2
  store i64 %v22, ptr %st24
  %v39 = getelementptr i64, ptr %s3, i64 0
  %v40 = add i64 0, 1
  %st25 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st25
  %v41.p = getelementptr i64, ptr %v12, i64 0
  %v41 = load i64, ptr %v41.p
  %st26 = getelementptr i64, ptr %v39, i64 1
  store i64 %v41, ptr %st26
  %v42.p = getelementptr i64, ptr %v12, i64 1
  %v42 = load i64, ptr %v42.p
  %st27 = getelementptr i64, ptr %v39, i64 2
  store i64 %v42, ptr %st27
  %v43.p = getelementptr i64, ptr %v12, i64 2
  %v43 = load i64, ptr %v43.p
  %st28 = getelementptr i64, ptr %v39, i64 3
  store i64 %v43, ptr %st28
  %v44.p = getelementptr i64, ptr %v12, i64 3
  %v44 = load i64, ptr %v44.p
  %st29 = getelementptr i64, ptr %v39, i64 4
  store i64 %v44, ptr %st29
  %v45.p = getelementptr i64, ptr %v12, i64 4
  %v45 = load i64, ptr %v45.p
  %st30 = getelementptr i64, ptr %v39, i64 5
  store i64 %v45, ptr %st30
  %v46.p = getelementptr i64, ptr %v39, i64 0
  %v46 = load i64, ptr %v46.p
  %st31 = getelementptr i64, ptr %v0, i64 0
  store i64 %v46, ptr %st31
  %v47.p = getelementptr i64, ptr %v39, i64 1
  %v47 = load i64, ptr %v47.p
  %st32 = getelementptr i64, ptr %v0, i64 1
  store i64 %v47, ptr %st32
  %v48.p = getelementptr i64, ptr %v39, i64 2
  %v48 = load i64, ptr %v48.p
  %st33 = getelementptr i64, ptr %v0, i64 2
  store i64 %v48, ptr %st33
  %v49.p = getelementptr i64, ptr %v39, i64 3
  %v49 = load i64, ptr %v49.p
  %st34 = getelementptr i64, ptr %v0, i64 3
  store i64 %v49, ptr %st34
  %v50.p = getelementptr i64, ptr %v39, i64 4
  %v50 = load i64, ptr %v50.p
  %st35 = getelementptr i64, ptr %v0, i64 4
  store i64 %v50, ptr %st35
  %v51.p = getelementptr i64, ptr %v39, i64 5
  %v51 = load i64, ptr %v51.p
  %st36 = getelementptr i64, ptr %v0, i64 5
  store i64 %v51, ptr %st36
  %v52.p = getelementptr i64, ptr %v0, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 0
  %v54.c = icmp ne i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b3 = icmp ne i64 %v54, 0
  br i1 %c.b3, label %b3.t38, label %b3.e39
b3.t38:
  br label %b5
b3.e39:
  br label %b6
b4:
  %v27 = add i64 0, 2
  %v28 = mul i64 %v24, %v27
  %v29 = add i64 0, 2
  %v30 = add i64 0, 1
  %v31 = call ptr @"rt.slice_grow"(i64 %v23, i64 %v24, i64 %v29, i64 %v22, i64 %v30)
  %v32 = getelementptr i64, ptr %v31, i64 %v28
  br label %b3
b5:
  %v55 = add i64 0, 3
  %v56 = getelementptr i64, ptr %v0, i64 %v55
  %v72 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v56, i64 %v72, i64 %v2)
  br label %b6
b6:
  %v73 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v73, i64 0
  store i64 %v2, ptr %st39
  ret void
b7:
  %v68 = add i64 0, 3
  %v69 = getelementptr i64, ptr %v0, i64 %v68
  %v74 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v69, i64 %v74, i64 %v2)
  br label %b8
b8:
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v75, i64 0
  store i64 %v2, ptr %st40
  ret void
}

define internal void @"main.inner"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
b0:
  %s0 = alloca [6 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %s0.z4 = getelementptr i64, ptr %s0, i64 4
  store i64 0, ptr %s0.z4
  %s0.z5 = getelementptr i64, ptr %s0, i64 5
  store i64 0, ptr %s0.z5
  %s1 = alloca [5 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
  %s1.z4 = getelementptr i64, ptr %s1, i64 4
  store i64 0, ptr %s1.z4
  %s2 = alloca [3 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [3 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %s11 = alloca [3 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %s11.z2 = getelementptr i64, ptr %s11, i64 2
  store i64 0, ptr %s11.z2
  %s12 = alloca [3 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s13 = alloca [3 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s13.z1 = getelementptr i64, ptr %s13, i64 1
  store i64 0, ptr %s13.z1
  %s13.z2 = getelementptr i64, ptr %s13, i64 2
  store i64 0, ptr %s13.z2
  %s14 = alloca [3 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s14.z1 = getelementptr i64, ptr %s14, i64 1
  store i64 0, ptr %s14.z1
  %s14.z2 = getelementptr i64, ptr %s14, i64 2
  store i64 0, ptr %s14.z2
  %s15 = alloca [3 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s15.z1 = getelementptr i64, ptr %s15, i64 1
  store i64 0, ptr %s15.z1
  %s15.z2 = getelementptr i64, ptr %s15, i64 2
  store i64 0, ptr %s15.z2
  %s16 = alloca [6 x i64], align 8
  %s16.z0 = getelementptr i64, ptr %s16, i64 0
  store i64 0, ptr %s16.z0
  %s16.z1 = getelementptr i64, ptr %s16, i64 1
  store i64 0, ptr %s16.z1
  %s16.z2 = getelementptr i64, ptr %s16, i64 2
  store i64 0, ptr %s16.z2
  %s16.z3 = getelementptr i64, ptr %s16, i64 3
  store i64 0, ptr %s16.z3
  %s16.z4 = getelementptr i64, ptr %s16, i64 4
  store i64 0, ptr %s16.z4
  %s16.z5 = getelementptr i64, ptr %s16, i64 5
  store i64 0, ptr %s16.z5
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v7, i64 3
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 4
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 5
  store i64 %v6, ptr %st5
  %v168 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v168, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9.p = getelementptr i64, ptr %v7, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 0
  %v11.c = icmp ne i64 %v9, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b0 = icmp ne i64 %v11, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v12 = add i64 0, 1
  %v13 = getelementptr i64, ptr %v7, i64 %v12
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15.p = getelementptr i64, ptr %v13, i64 0
  %v15 = load i64, ptr %v15.p
  %st8 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st8
  %v16.p = getelementptr i64, ptr %v13, i64 1
  %v16 = load i64, ptr %v16.p
  %st9 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st9
  %v17.p = getelementptr i64, ptr %v13, i64 2
  %v17 = load i64, ptr %v17.p
  %st10 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st10
  %v18.p = getelementptr i64, ptr %v13, i64 3
  %v18 = load i64, ptr %v18.p
  %st11 = getelementptr i64, ptr %v14, i64 3
  store i64 %v18, ptr %st11
  %v19.p = getelementptr i64, ptr %v13, i64 4
  %v19 = load i64, ptr %v19.p
  %st12 = getelementptr i64, ptr %v14, i64 4
  store i64 %v19, ptr %st12
  %v20.p = getelementptr i64, ptr %v14, i64 0
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 0
  %v22.c = icmp eq i64 %v20, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b1 = icmp ne i64 %v22, 0
  br i1 %c.b1, label %b1.t14, label %b1.e15
b1.t14:
  br label %b4
b1.e15:
  br label %b3
b2:
  br label %b13
b3:
  %v76.p = getelementptr i64, ptr %v14, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = add i64 0, 1
  %v78.c = icmp eq i64 %v76, %v77
  %v78 = zext i1 %v78.c to i64
  %c.b3 = icmp ne i64 %v78, 0
  br i1 %c.b3, label %b3.t16, label %b3.e17
b3.t16:
  br label %b6
b3.e17:
  br label %b5
b4:
  %v23.p = getelementptr i64, ptr %v14, i64 1
  %v23 = load i64, ptr %v23.p
  %v24 = getelementptr i64, ptr @"str.5", i64 0
  %v25 = add i64 0, 8
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s2, i64 0
  %v28 = ptrtoint ptr %v24 to i64
  %st17 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st17
  %st18 = getelementptr i64, ptr %v27, i64 1
  store i64 %v25, ptr %st18
  %st19 = getelementptr i64, ptr %v27, i64 2
  store i64 %v26, ptr %st19
  %v29 = getelementptr i64, ptr %s3, i64 0
  call void @"std/convert.FormatInt"(ptr %v29, i64 %v0)
  %v30.p = getelementptr i64, ptr %v27, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v29, i64 1
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 %v30, %v31
  %v169 = getelementptr i64, ptr @"rt.meta", i64 0
  %v33.p = getelementptr i64, ptr %v169, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v27, i64 0
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v27, i64 1
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v27, i64 2
  %v36 = load i64, ptr %v36.p
  %v37 = call ptr @"rt.cat8"(i64 %v34, i64 %v35, i64 %v36, i64 %v33, i64 %v31)
  %v38 = getelementptr i8, ptr %v37, i64 %v30
  %v39.p = getelementptr i64, ptr %v29, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = inttoptr i64 %v39 to ptr
  call void @"rt.copy8"(ptr %v38, ptr %v40, i64 %v31)
  %v41 = getelementptr i64, ptr %s4, i64 0
  %v42 = ptrtoint ptr %v37 to i64
  %st20 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st20
  %st21 = getelementptr i64, ptr %v41, i64 1
  store i64 %v32, ptr %st21
  %st22 = getelementptr i64, ptr %v41, i64 2
  store i64 %v33, ptr %st22
  %v43 = getelementptr i64, ptr @"str.6", i64 0
  %v44 = add i64 0, 12
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s5, i64 0
  %v47 = ptrtoint ptr %v43 to i64
  %st23 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st23
  %st24 = getelementptr i64, ptr %v46, i64 1
  store i64 %v44, ptr %st24
  %st25 = getelementptr i64, ptr %v46, i64 2
  store i64 %v45, ptr %st25
  %v48.p = getelementptr i64, ptr %v41, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v46, i64 1
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 %v48, %v49
  %v170 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v170, i64 0
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v41, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v41, i64 1
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v41, i64 2
  %v54 = load i64, ptr %v54.p
  %v55 = call ptr @"rt.cat8"(i64 %v52, i64 %v53, i64 %v54, i64 %v51, i64 %v49)
  %v56 = getelementptr i8, ptr %v55, i64 %v48
  %v57.p = getelementptr i64, ptr %v46, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = inttoptr i64 %v57 to ptr
  call void @"rt.copy8"(ptr %v56, ptr %v58, i64 %v49)
  %v59 = getelementptr i64, ptr %s6, i64 0
  %v60 = ptrtoint ptr %v55 to i64
  %st26 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st26
  %st27 = getelementptr i64, ptr %v59, i64 1
  store i64 %v50, ptr %st27
  %st28 = getelementptr i64, ptr %v59, i64 2
  store i64 %v51, ptr %st28
  %v61 = getelementptr i64, ptr %s7, i64 0
  call void @"std/convert.FormatInt"(ptr %v61, i64 %v23)
  %v62.p = getelementptr i64, ptr %v59, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v61, i64 1
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 %v62, %v63
  %v171 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v171, i64 0
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v59, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v59, i64 1
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v59, i64 2
  %v68 = load i64, ptr %v68.p
  %v69 = call ptr @"rt.cat8"(i64 %v66, i64 %v67, i64 %v68, i64 %v65, i64 %v63)
  %v70 = getelementptr i8, ptr %v69, i64 %v62
  %v71.p = getelementptr i64, ptr %v61, i64 0
  %v71 = load i64, ptr %v71.p
  %v72 = inttoptr i64 %v71 to ptr
  call void @"rt.copy8"(ptr %v70, ptr %v72, i64 %v63)
  %v73 = getelementptr i64, ptr %s8, i64 0
  %v74 = ptrtoint ptr %v69 to i64
  %st29 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st29
  %st30 = getelementptr i64, ptr %v73, i64 1
  store i64 %v64, ptr %st30
  %st31 = getelementptr i64, ptr %v73, i64 2
  store i64 %v65, ptr %st31
  call void @"rt.print_str"(ptr %v73)
  %v75 = add i64 0, 10
  call void @"rt.print_char"(i64 %v75)
  br label %b12
b5:
  %v132.p = getelementptr i64, ptr %v14, i64 0
  %v132 = load i64, ptr %v132.p
  %v133 = add i64 0, 2
  %v134.c = icmp eq i64 %v132, %v133
  %v134 = zext i1 %v134.c to i64
  %c.b5 = icmp ne i64 %v134, 0
  br i1 %c.b5, label %b5.t33, label %b5.e34
b5.t33:
  br label %b8
b5.e34:
  br label %b7
b6:
  %v79.p = getelementptr i64, ptr %v14, i64 1
  %v79 = load i64, ptr %v79.p
  %v80 = getelementptr i64, ptr @"str.5", i64 0
  %v81 = add i64 0, 8
  %v82 = add i64 0, 0
  %v83 = getelementptr i64, ptr %s9, i64 0
  %v84 = ptrtoint ptr %v80 to i64
  %st34 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st34
  %st35 = getelementptr i64, ptr %v83, i64 1
  store i64 %v81, ptr %st35
  %st36 = getelementptr i64, ptr %v83, i64 2
  store i64 %v82, ptr %st36
  %v85 = getelementptr i64, ptr %s10, i64 0
  call void @"std/convert.FormatInt"(ptr %v85, i64 %v0)
  %v86.p = getelementptr i64, ptr %v83, i64 1
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v85, i64 1
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 %v86, %v87
  %v172 = getelementptr i64, ptr @"rt.meta", i64 0
  %v89.p = getelementptr i64, ptr %v172, i64 0
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v83, i64 0
  %v90 = load i64, ptr %v90.p
  %v91.p = getelementptr i64, ptr %v83, i64 1
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v83, i64 2
  %v92 = load i64, ptr %v92.p
  %v93 = call ptr @"rt.cat8"(i64 %v90, i64 %v91, i64 %v92, i64 %v89, i64 %v87)
  %v94 = getelementptr i8, ptr %v93, i64 %v86
  %v95.p = getelementptr i64, ptr %v85, i64 0
  %v95 = load i64, ptr %v95.p
  %v96 = inttoptr i64 %v95 to ptr
  call void @"rt.copy8"(ptr %v94, ptr %v96, i64 %v87)
  %v97 = getelementptr i64, ptr %s11, i64 0
  %v98 = ptrtoint ptr %v93 to i64
  %st37 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st37
  %st38 = getelementptr i64, ptr %v97, i64 1
  store i64 %v88, ptr %st38
  %st39 = getelementptr i64, ptr %v97, i64 2
  store i64 %v89, ptr %st39
  %v99 = getelementptr i64, ptr @"str.7", i64 0
  %v100 = add i64 0, 9
  %v101 = add i64 0, 0
  %v102 = getelementptr i64, ptr %s12, i64 0
  %v103 = ptrtoint ptr %v99 to i64
  %st40 = getelementptr i64, ptr %v102, i64 0
  store i64 %v103, ptr %st40
  %st41 = getelementptr i64, ptr %v102, i64 1
  store i64 %v100, ptr %st41
  %st42 = getelementptr i64, ptr %v102, i64 2
  store i64 %v101, ptr %st42
  %v104.p = getelementptr i64, ptr %v97, i64 1
  %v104 = load i64, ptr %v104.p
  %v105.p = getelementptr i64, ptr %v102, i64 1
  %v105 = load i64, ptr %v105.p
  %v106 = add i64 %v104, %v105
  %v173 = getelementptr i64, ptr @"rt.meta", i64 0
  %v107.p = getelementptr i64, ptr %v173, i64 0
  %v107 = load i64, ptr %v107.p
  %v108.p = getelementptr i64, ptr %v97, i64 0
  %v108 = load i64, ptr %v108.p
  %v109.p = getelementptr i64, ptr %v97, i64 1
  %v109 = load i64, ptr %v109.p
  %v110.p = getelementptr i64, ptr %v97, i64 2
  %v110 = load i64, ptr %v110.p
  %v111 = call ptr @"rt.cat8"(i64 %v108, i64 %v109, i64 %v110, i64 %v107, i64 %v105)
  %v112 = getelementptr i8, ptr %v111, i64 %v104
  %v113.p = getelementptr i64, ptr %v102, i64 0
  %v113 = load i64, ptr %v113.p
  %v114 = inttoptr i64 %v113 to ptr
  call void @"rt.copy8"(ptr %v112, ptr %v114, i64 %v105)
  %v115 = getelementptr i64, ptr %s13, i64 0
  %v116 = ptrtoint ptr %v111 to i64
  %st43 = getelementptr i64, ptr %v115, i64 0
  store i64 %v116, ptr %st43
  %st44 = getelementptr i64, ptr %v115, i64 1
  store i64 %v106, ptr %st44
  %st45 = getelementptr i64, ptr %v115, i64 2
  store i64 %v107, ptr %st45
  %v117 = getelementptr i64, ptr %s14, i64 0
  call void @"std/convert.FormatInt"(ptr %v117, i64 %v79)
  %v118.p = getelementptr i64, ptr %v115, i64 1
  %v118 = load i64, ptr %v118.p
  %v119.p = getelementptr i64, ptr %v117, i64 1
  %v119 = load i64, ptr %v119.p
  %v120 = add i64 %v118, %v119
  %v174 = getelementptr i64, ptr @"rt.meta", i64 0
  %v121.p = getelementptr i64, ptr %v174, i64 0
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v115, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v115, i64 1
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v115, i64 2
  %v124 = load i64, ptr %v124.p
  %v125 = call ptr @"rt.cat8"(i64 %v122, i64 %v123, i64 %v124, i64 %v121, i64 %v119)
  %v126 = getelementptr i8, ptr %v125, i64 %v118
  %v127.p = getelementptr i64, ptr %v117, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = inttoptr i64 %v127 to ptr
  call void @"rt.copy8"(ptr %v126, ptr %v128, i64 %v119)
  %v129 = getelementptr i64, ptr %s15, i64 0
  %v130 = ptrtoint ptr %v125 to i64
  %st46 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st46
  %st47 = getelementptr i64, ptr %v129, i64 1
  store i64 %v120, ptr %st47
  %st48 = getelementptr i64, ptr %v129, i64 2
  store i64 %v121, ptr %st48
  call void @"rt.print_str"(ptr %v129)
  %v131 = add i64 0, 10
  call void @"rt.print_char"(i64 %v131)
  br label %b12
b7:
  %v167 = add i64 0, 4
  call void @"rt.panic"(i64 %v167)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v135 = getelementptr i64, ptr %s16, i64 0
  %v136 = add i64 0, 2
  %v137 = getelementptr i64, ptr %v14, i64 %v136
  %v138.p = getelementptr i64, ptr %v137, i64 1
  %v138 = load i64, ptr %v138.p
  %v139 = add i64 0, 0
  %v140.c = icmp ne i64 %v138, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b8 = icmp ne i64 %v140, 0
  br i1 %c.b8, label %b8.t50, label %b8.e51
b8.t50:
  br label %b9
b8.e51:
  br label %b10
b9:
  %v142 = add i64 0, 1
  %st51 = getelementptr i64, ptr %v135, i64 0
  store i64 %v142, ptr %st51
  %v143 = add i64 0, 1
  %v144 = sub i64 %v138, %v143
  %v145.p = getelementptr i64, ptr %v137, i64 0
  %v145 = load i64, ptr %v145.p
  %v146 = inttoptr i64 %v145 to ptr
  %v147 = add i64 0, 2
  %v148 = mul i64 %v144, %v147
  %v149 = getelementptr i64, ptr %v146, i64 %v148
  %v150.p = getelementptr i64, ptr %v149, i64 0
  %v150 = load i64, ptr %v150.p
  %st52 = getelementptr i64, ptr %v135, i64 1
  store i64 %v150, ptr %st52
  %v151.p = getelementptr i64, ptr %v149, i64 1
  %v151 = load i64, ptr %v151.p
  %st53 = getelementptr i64, ptr %v135, i64 2
  store i64 %v151, ptr %st53
  %v152 = add i64 0, 3
  %v153 = getelementptr i64, ptr %v135, i64 %v152
  %v154.p = getelementptr i64, ptr %v137, i64 0
  %v154 = load i64, ptr %v154.p
  %st54 = getelementptr i64, ptr %v153, i64 0
  store i64 %v154, ptr %st54
  %st55 = getelementptr i64, ptr %v153, i64 1
  store i64 %v144, ptr %st55
  %v155.p = getelementptr i64, ptr %v137, i64 2
  %v155 = load i64, ptr %v155.p
  %st56 = getelementptr i64, ptr %v153, i64 2
  store i64 %v155, ptr %st56
  br label %b11
b10:
  %v141 = add i64 0, 0
  %st57 = getelementptr i64, ptr %v135, i64 0
  store i64 %v141, ptr %st57
  br label %b11
b11:
  %v156.p = getelementptr i64, ptr %v14, i64 0
  %v156 = load i64, ptr %v156.p
  %v157.p = getelementptr i64, ptr %v14, i64 1
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v14, i64 2
  %v158 = load i64, ptr %v158.p
  %v159.p = getelementptr i64, ptr %v14, i64 3
  %v159 = load i64, ptr %v159.p
  %v160.p = getelementptr i64, ptr %v14, i64 4
  %v160 = load i64, ptr %v160.p
  %v161.p = getelementptr i64, ptr %v135, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v135, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v135, i64 2
  %v163 = load i64, ptr %v163.p
  %v164.p = getelementptr i64, ptr %v135, i64 3
  %v164 = load i64, ptr %v164.p
  %v165.p = getelementptr i64, ptr %v135, i64 4
  %v165 = load i64, ptr %v165.p
  %v166.p = getelementptr i64, ptr %v135, i64 5
  %v166 = load i64, ptr %v166.p
  call void @"main.inner2"(i64 %v0, i64 %v156, i64 %v157, i64 %v158, i64 %v159, i64 %v160, i64 %v161, i64 %v162, i64 %v163, i64 %v164, i64 %v165, i64 %v166)
  br label %b12
b12:
  br label %b13
b13:
  %v175 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v175, i64 0
  store i64 %v8, ptr %st58
  ret void
}

define internal void @"std/convert.FormatInt"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [3 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s2 = alloca [3 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v43, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 9223372036854775807
  %v4 = add i64 0, 0
  %v5 = sub i64 %v4, %v3
  %v6 = add i64 0, 1
  %v7 = sub i64 %v5, %v6
  %v8.c = icmp eq i64 %v1, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b0 = icmp ne i64 %v8, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v9 = getelementptr i64, ptr @"str.3", i64 0
  %v10 = add i64 0, 20
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s0, i64 0
  %v13 = ptrtoint ptr %v9 to i64
  %st2 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st2
  %st3 = getelementptr i64, ptr %v12, i64 1
  store i64 %v10, ptr %st3
  %st4 = getelementptr i64, ptr %v12, i64 2
  store i64 %v11, ptr %st4
  br label %b6
b2:
  %v14 = add i64 0, 0
  %v15.c = icmp slt i64 %v1, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b2 = icmp ne i64 %v15, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b3
b2.e7:
  br label %b4
b3:
  %v16 = getelementptr i64, ptr @"str.4", i64 0
  %v17 = add i64 0, 1
  %v18 = add i64 0, 0
  %v19 = getelementptr i64, ptr %s1, i64 0
  %v20 = ptrtoint ptr %v16 to i64
  %st7 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st7
  %st8 = getelementptr i64, ptr %v19, i64 1
  store i64 %v17, ptr %st8
  %st9 = getelementptr i64, ptr %v19, i64 2
  store i64 %v18, ptr %st9
  %v21 = getelementptr i64, ptr %s2, i64 0
  %v22 = add i64 0, 0
  %v23 = sub i64 %v22, %v1
  call void @"std/convert.formatUint"(ptr %v21, i64 %v23)
  %v24.p = getelementptr i64, ptr %v19, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v21, i64 1
  %v25 = load i64, ptr %v25.p
  %v26 = add i64 %v24, %v25
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v44, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v19, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v19, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v19, i64 2
  %v30 = load i64, ptr %v30.p
  %v31 = call ptr @"rt.cat8"(i64 %v28, i64 %v29, i64 %v30, i64 %v27, i64 %v25)
  %v32 = getelementptr i8, ptr %v31, i64 %v24
  %v33.p = getelementptr i64, ptr %v21, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = inttoptr i64 %v33 to ptr
  call void @"rt.copy8"(ptr %v32, ptr %v34, i64 %v25)
  %v35 = getelementptr i64, ptr %s3, i64 0
  %v36 = ptrtoint ptr %v31 to i64
  %st10 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st10
  %st11 = getelementptr i64, ptr %v35, i64 1
  store i64 %v26, ptr %st11
  %st12 = getelementptr i64, ptr %v35, i64 2
  store i64 %v27, ptr %st12
  br label %b5
b4:
  %v37 = getelementptr i64, ptr %s4, i64 0
  call void @"std/convert.formatUint"(ptr %v37, i64 %v1)
  br label %b5
b5:
  %v38 = phi ptr [ %v35, %b3 ], [ %v37, %b4 ]
  br label %b6
b6:
  %v39 = phi ptr [ %v12, %b1 ], [ %v38, %b5 ]
  %v40.p = getelementptr i64, ptr %v39, i64 0
  %v40 = load i64, ptr %v40.p
  %st13 = getelementptr i64, ptr %v0, i64 0
  store i64 %v40, ptr %st13
  %v41.p = getelementptr i64, ptr %v39, i64 1
  %v41 = load i64, ptr %v41.p
  %st14 = getelementptr i64, ptr %v0, i64 1
  store i64 %v41, ptr %st14
  %v42.p = getelementptr i64, ptr %v39, i64 2
  %v42 = load i64, ptr %v42.p
  %st15 = getelementptr i64, ptr %v0, i64 2
  store i64 %v42, ptr %st15
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v45, i64 0
  store i64 %v2, ptr %st16
  ret void
}

define internal void @"rt.panic"(i64 %v0) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [3 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s2 = alloca [3 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [3 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %v1 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2 = getelementptr i64, ptr @"rt.psites", i64 0
  %v3 = getelementptr i64, ptr %v2, i64 %v0
  %v4.p = getelementptr i64, ptr %v3, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 255
  %v6 = and i64 %v4, %v5
  %v7 = add i64 0, 8
  %v8.n = and i64 %v7, 63
  %v8 = ashr i64 %v4, %v8.n
  %v9 = add i64 0, 65535
  %v10 = and i64 %v8, %v9
  %v11 = add i64 0, 24
  %v12.n = and i64 %v11, 63
  %v12 = ashr i64 %v4, %v12.n
  %v13 = add i64 0, 16777215
  %v14 = and i64 %v12, %v13
  %v15 = add i64 0, 48
  %v16.n = and i64 %v15, 63
  %v16 = ashr i64 %v4, %v16.n
  %v17 = add i64 0, 32767
  %v18 = and i64 %v16, %v17
  call void @"rt.flush"()
  %v19 = add i64 0, 2
  %st0 = getelementptr i64, ptr %v1, i64 1026
  store i64 %v19, ptr %st0
  %v20 = getelementptr i64, ptr @"str.21", i64 0
  %v21 = add i64 0, 7
  %v22 = add i64 0, 0
  %v23 = getelementptr i64, ptr %s0, i64 0
  %v24 = ptrtoint ptr %v20 to i64
  %st1 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st1
  %st2 = getelementptr i64, ptr %v23, i64 1
  store i64 %v21, ptr %st2
  %st3 = getelementptr i64, ptr %v23, i64 2
  store i64 %v22, ptr %st3
  call void @"rt.print_str"(ptr %v23)
  %v25 = add i64 0, 1
  %v26.c = icmp eq i64 %v6, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b0 = icmp ne i64 %v26, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b2
b0.e6:
  br label %b3
b1:
  %v74 = getelementptr i64, ptr @"str.29", i64 0
  %v75 = add i64 0, 4
  %v76 = add i64 0, 0
  %v77 = getelementptr i64, ptr %s8, i64 0
  %v78 = ptrtoint ptr %v74 to i64
  %st6 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st6
  %st7 = getelementptr i64, ptr %v77, i64 1
  store i64 %v75, ptr %st7
  %st8 = getelementptr i64, ptr %v77, i64 2
  store i64 %v76, ptr %st8
  call void @"rt.print_str"(ptr %v77)
  %v79 = add i64 0, 0
  %v80.c = icmp eq i64 %v10, %v79
  %v80 = zext i1 %v80.c to i64
  %c.b1 = icmp ne i64 %v80, 0
  br i1 %c.b1, label %b1.t10, label %b1.e11
b1.t10:
  br label %b17
b1.e11:
  br label %b18
b2:
  %v27 = getelementptr i64, ptr @"str.22", i64 0
  %v28 = add i64 0, 18
  %v29 = add i64 0, 0
  %v30 = getelementptr i64, ptr %s1, i64 0
  %v31 = ptrtoint ptr %v27 to i64
  %st11 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st11
  %st12 = getelementptr i64, ptr %v30, i64 1
  store i64 %v28, ptr %st12
  %st13 = getelementptr i64, ptr %v30, i64 2
  store i64 %v29, ptr %st13
  call void @"rt.print_str"(ptr %v30)
  br label %b1
b3:
  %v32 = add i64 0, 2
  %v33.c = icmp eq i64 %v6, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b3 = icmp ne i64 %v33, 0
  br i1 %c.b3, label %b3.t15, label %b3.e16
b3.t15:
  br label %b4
b3.e16:
  br label %b5
b4:
  %v34 = getelementptr i64, ptr @"str.23", i64 0
  %v35 = add i64 0, 25
  %v36 = add i64 0, 0
  %v37 = getelementptr i64, ptr %s2, i64 0
  %v38 = ptrtoint ptr %v34 to i64
  %st16 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st16
  %st17 = getelementptr i64, ptr %v37, i64 1
  store i64 %v35, ptr %st17
  %st18 = getelementptr i64, ptr %v37, i64 2
  store i64 %v36, ptr %st18
  call void @"rt.print_str"(ptr %v37)
  br label %b1
b5:
  %v39 = add i64 0, 3
  %v40.c = icmp eq i64 %v6, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b5 = icmp ne i64 %v40, 0
  br i1 %c.b5, label %b5.t20, label %b5.e21
b5.t20:
  br label %b6
b5.e21:
  br label %b7
b6:
  %v41 = getelementptr i64, ptr @"str.24", i64 0
  %v42 = add i64 0, 27
  %v43 = add i64 0, 0
  %v44 = getelementptr i64, ptr %s3, i64 0
  %v45 = ptrtoint ptr %v41 to i64
  %st21 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st21
  %st22 = getelementptr i64, ptr %v44, i64 1
  store i64 %v42, ptr %st22
  %st23 = getelementptr i64, ptr %v44, i64 2
  store i64 %v43, ptr %st23
  call void @"rt.print_str"(ptr %v44)
  br label %b1
b7:
  %v46 = add i64 0, 4
  %v47.c = icmp eq i64 %v6, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b7 = icmp ne i64 %v47, 0
  br i1 %c.b7, label %b7.t25, label %b7.e26
b7.t25:
  br label %b8
b7.e26:
  br label %b9
b8:
  %v48 = getelementptr i64, ptr @"str.25", i64 0
  %v49 = add i64 0, 21
  %v50 = add i64 0, 0
  %v51 = getelementptr i64, ptr %s4, i64 0
  %v52 = ptrtoint ptr %v48 to i64
  %st26 = getelementptr i64, ptr %v51, i64 0
  store i64 %v52, ptr %st26
  %st27 = getelementptr i64, ptr %v51, i64 1
  store i64 %v49, ptr %st27
  %st28 = getelementptr i64, ptr %v51, i64 2
  store i64 %v50, ptr %st28
  call void @"rt.print_str"(ptr %v51)
  br label %b1
b9:
  %v53 = add i64 0, 5
  %v54.c = icmp eq i64 %v6, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b9 = icmp ne i64 %v54, 0
  br i1 %c.b9, label %b9.t30, label %b9.e31
b9.t30:
  br label %b10
b9.e31:
  br label %b11
b10:
  %v55 = getelementptr i64, ptr @"str.26", i64 0
  %v56 = add i64 0, 22
  %v57 = add i64 0, 0
  %v58 = getelementptr i64, ptr %s5, i64 0
  %v59 = ptrtoint ptr %v55 to i64
  %st31 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st31
  %st32 = getelementptr i64, ptr %v58, i64 1
  store i64 %v56, ptr %st32
  %st33 = getelementptr i64, ptr %v58, i64 2
  store i64 %v57, ptr %st33
  call void @"rt.print_str"(ptr %v58)
  br label %b1
b11:
  %v60 = add i64 0, 6
  %v61.c = icmp eq i64 %v6, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b11 = icmp ne i64 %v61, 0
  br i1 %c.b11, label %b11.t35, label %b11.e36
b11.t35:
  br label %b12
b11.e36:
  br label %b13
b12:
  %v62 = getelementptr i64, ptr @"str.27", i64 0
  %v63 = add i64 0, 16
  %v64 = add i64 0, 0
  %v65 = getelementptr i64, ptr %s6, i64 0
  %v66 = ptrtoint ptr %v62 to i64
  %st36 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st36
  %st37 = getelementptr i64, ptr %v65, i64 1
  store i64 %v63, ptr %st37
  %st38 = getelementptr i64, ptr %v65, i64 2
  store i64 %v64, ptr %st38
  call void @"rt.print_str"(ptr %v65)
  br label %b1
b13:
  %v67 = add i64 0, 7
  %v68.c = icmp eq i64 %v6, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b13 = icmp ne i64 %v68, 0
  br i1 %c.b13, label %b13.t40, label %b13.e41
b13.t40:
  br label %b14
b13.e41:
  br label %b15
b14:
  %v69 = getelementptr i64, ptr @"str.28", i64 0
  %v70 = add i64 0, 24
  %v71 = add i64 0, 0
  %v72 = getelementptr i64, ptr %s7, i64 0
  %v73 = ptrtoint ptr %v69 to i64
  %st41 = getelementptr i64, ptr %v72, i64 0
  store i64 %v73, ptr %st41
  %st42 = getelementptr i64, ptr %v72, i64 1
  store i64 %v70, ptr %st42
  %st43 = getelementptr i64, ptr %v72, i64 2
  store i64 %v71, ptr %st43
  call void @"rt.print_str"(ptr %v72)
  br label %b1
b15:
  br label %b1
b16:
  %v93 = add i64 0, 58
  call void @"rt.print_char"(i64 %v93)
  call void @"rt.print_int"(i64 %v14)
  %v94 = add i64 0, 58
  call void @"rt.print_char"(i64 %v94)
  call void @"rt.print_int"(i64 %v18)
  %v95 = add i64 0, 10
  call void @"rt.print_char"(i64 %v95)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v81 = getelementptr i64, ptr @"str.30", i64 0
  %v82 = add i64 0, 21
  %v83 = add i64 0, 0
  %v84 = getelementptr i64, ptr %s9, i64 0
  %v85 = ptrtoint ptr %v81 to i64
  %st44 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st44
  %st45 = getelementptr i64, ptr %v84, i64 1
  store i64 %v82, ptr %st45
  %st46 = getelementptr i64, ptr %v84, i64 2
  store i64 %v83, ptr %st46
  call void @"rt.print_str"(ptr %v84)
  br label %b16
b18:
  %v86 = add i64 0, 1
  %v87.c = icmp eq i64 %v10, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b18 = icmp ne i64 %v87, 0
  br i1 %c.b18, label %b18.t48, label %b18.e49
b18.t48:
  br label %b19
b18.e49:
  br label %b20
b19:
  %v88 = getelementptr i64, ptr @"str.31", i64 0
  %v89 = add i64 0, 22
  %v90 = add i64 0, 0
  %v91 = getelementptr i64, ptr %s10, i64 0
  %v92 = ptrtoint ptr %v88 to i64
  %st49 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st49
  %st50 = getelementptr i64, ptr %v91, i64 1
  store i64 %v89, ptr %st50
  %st51 = getelementptr i64, ptr %v91, i64 2
  store i64 %v90, ptr %st51
  call void @"rt.print_str"(ptr %v91)
  br label %b16
b20:
  br label %b16
}

define internal void @"std/convert.formatUint"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [3 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %v158 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v158, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v159, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = add i64 0, 0
  %v5 = call ptr @"rt.region_alloc8"(i64 %v3, i64 %v4)
  %v6 = add i64 0, 0
  %v7 = getelementptr i64, ptr %s0, i64 0
  %v8 = ptrtoint ptr %v5 to i64
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v6, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %v9 = getelementptr i64, ptr %s1, i64 0
  %v10.p = getelementptr i64, ptr %v7, i64 0
  %v10 = load i64, ptr %v10.p
  %st3 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st3
  %v11.p = getelementptr i64, ptr %v7, i64 1
  %v11 = load i64, ptr %v11.p
  %st4 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st4
  %v12.p = getelementptr i64, ptr %v7, i64 2
  %v12 = load i64, ptr %v12.p
  %st5 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st5
  %v13 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v13, i64 0
  store i64 %v1, ptr %st6
  %v14 = getelementptr i64, ptr %s0, i64 0
  %v15.p = getelementptr i64, ptr %v9, i64 0
  %v15 = load i64, ptr %v15.p
  %st7 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st7
  %v16.p = getelementptr i64, ptr %v9, i64 1
  %v16 = load i64, ptr %v16.p
  %st8 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st8
  %v17.p = getelementptr i64, ptr %v9, i64 2
  %v17 = load i64, ptr %v17.p
  %st9 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st9
  %v18 = add i64 0, 48
  %v19.p = getelementptr i64, ptr %v13, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 10
  %v21 = srem i64 %v19, %v20
  %v22 = add i64 %v18, %v21
  %v23 = add i64 0, 256
  %v24.c = icmp uge i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b0 = icmp ne i64 %v24, 0
  br i1 %c.b0, label %b0.t11, label %b0.e12
b0.t11:
  br label %b1
b0.e12:
  br label %b2
b1:
  %v25 = add i64 0, 1
  call void @"rt.panic"(i64 %v25)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v26.p = getelementptr i64, ptr %v14, i64 2
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v14, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v14, i64 1
  %v28 = load i64, ptr %v28.p
  %v31 = add i64 %v27, %v28
  %v32 = call i64 @"rt.tip8"(i64 %v26, i64 %v31)
  %v33 = add i64 0, 0
  %v34.c = icmp ne i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b2 = icmp ne i64 %v34, 0
  br i1 %c.b2, label %b2.t13, label %b2.e14
b2.t13:
  br label %b5
b2.e14:
  br label %b4
b3:
  %v29 = phi ptr [ %v38, %b4 ], [ %v35, %b5 ]
  %v30 = phi ptr [ %v39, %b4 ], [ %v36, %b5 ]
  %st14 = getelementptr i8, ptr %v30, i64 0
  %st14.b = trunc i64 %v22 to i8
  store i8 %st14.b, ptr %st14
  %v40.p = getelementptr i64, ptr %v14, i64 1
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 1
  %v42 = add i64 %v40, %v41
  %v43 = getelementptr i64, ptr %s3, i64 0
  %v44 = ptrtoint ptr %v29 to i64
  %st15 = getelementptr i64, ptr %v43, i64 0
  store i64 %v44, ptr %st15
  %st16 = getelementptr i64, ptr %v43, i64 1
  store i64 %v42, ptr %st16
  %st17 = getelementptr i64, ptr %v43, i64 2
  store i64 %v26, ptr %st17
  %v45.p = getelementptr i64, ptr %v43, i64 0
  %v45 = load i64, ptr %v45.p
  %st18 = getelementptr i64, ptr %v9, i64 0
  store i64 %v45, ptr %st18
  %v46.p = getelementptr i64, ptr %v43, i64 1
  %v46 = load i64, ptr %v46.p
  %st19 = getelementptr i64, ptr %v9, i64 1
  store i64 %v46, ptr %st19
  %v47.p = getelementptr i64, ptr %v43, i64 2
  %v47 = load i64, ptr %v47.p
  %st20 = getelementptr i64, ptr %v9, i64 2
  store i64 %v47, ptr %st20
  %v48.p = getelementptr i64, ptr %v13, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 10
  %v50 = sdiv i64 %v48, %v49
  %st21 = getelementptr i64, ptr %v13, i64 0
  store i64 %v50, ptr %st21
  %v160 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v160, i64 0
  %v51 = load i64, ptr %v51.p
  br label %b6
b4:
  %v37 = add i64 0, 1
  %v38 = call ptr @"rt.slice_grow8"(i64 %v27, i64 %v28, i64 %v26, i64 %v37)
  %v39 = getelementptr i8, ptr %v38, i64 %v28
  br label %b3
b5:
  %v35 = inttoptr i64 %v27 to ptr
  %v36 = getelementptr i8, ptr %v35, i64 %v28
  br label %b3
b6:
  %v161 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v161, i64 0
  store i64 %v51, ptr %st22
  %v52.p = getelementptr i64, ptr %v13, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 0
  %v54.c = icmp sgt i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b6 = icmp ne i64 %v54, 0
  br i1 %c.b6, label %b6.t24, label %b6.e25
b6.t24:
  br label %b7
b6.e25:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v162 = getelementptr i64, ptr @"rt.meta", i64 0
  %v55.p = getelementptr i64, ptr %v162, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = add i64 0, 1
  %v57 = add i64 %v2, %v56
  %v58 = getelementptr i64, ptr %s3, i64 0
  %v59.p = getelementptr i64, ptr %v9, i64 0
  %v59 = load i64, ptr %v59.p
  %st25 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st25
  %v60.p = getelementptr i64, ptr %v9, i64 1
  %v60 = load i64, ptr %v60.p
  %st26 = getelementptr i64, ptr %v58, i64 1
  store i64 %v60, ptr %st26
  %v61.p = getelementptr i64, ptr %v9, i64 2
  %v61 = load i64, ptr %v61.p
  %st27 = getelementptr i64, ptr %v58, i64 2
  store i64 %v61, ptr %st27
  %v62 = add i64 0, 48
  %v63.p = getelementptr i64, ptr %v13, i64 0
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 0, 10
  %v65 = srem i64 %v63, %v64
  %v66 = add i64 %v62, %v65
  %v67 = add i64 0, 256
  %v68.c = icmp uge i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b7 = icmp ne i64 %v68, 0
  br i1 %c.b7, label %b7.t29, label %b7.e30
b7.t29:
  br label %b9
b7.e30:
  br label %b10
b8:
  %v163 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v163, i64 0
  store i64 %v51, ptr %st30
  %v164 = getelementptr i64, ptr @"rt.meta", i64 0
  %v97.p = getelementptr i64, ptr %v164, i64 0
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 0, 0
  %v99 = call ptr @"rt.region_alloc8"(i64 %v97, i64 %v98)
  %v100 = add i64 0, 0
  %v101 = getelementptr i64, ptr %s0, i64 0
  %v102 = ptrtoint ptr %v99 to i64
  %st31 = getelementptr i64, ptr %v101, i64 0
  store i64 %v102, ptr %st31
  %st32 = getelementptr i64, ptr %v101, i64 1
  store i64 %v100, ptr %st32
  %st33 = getelementptr i64, ptr %v101, i64 2
  store i64 %v97, ptr %st33
  %v103 = getelementptr i64, ptr %s3, i64 0
  %v104.p = getelementptr i64, ptr %v101, i64 0
  %v104 = load i64, ptr %v104.p
  %st34 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st34
  %v105.p = getelementptr i64, ptr %v101, i64 1
  %v105 = load i64, ptr %v105.p
  %st35 = getelementptr i64, ptr %v103, i64 1
  store i64 %v105, ptr %st35
  %v106.p = getelementptr i64, ptr %v101, i64 2
  %v106 = load i64, ptr %v106.p
  %st36 = getelementptr i64, ptr %v103, i64 2
  store i64 %v106, ptr %st36
  %v107.p = getelementptr i64, ptr %v9, i64 1
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 0, 1
  %v109 = sub i64 %v107, %v108
  %v110 = getelementptr i64, ptr %s4, i64 0
  %st37 = getelementptr i64, ptr %v110, i64 0
  store i64 %v109, ptr %st37
  %v165 = getelementptr i64, ptr @"rt.meta", i64 0
  %v111.p = getelementptr i64, ptr %v165, i64 0
  %v111 = load i64, ptr %v111.p
  br label %b14
b9:
  %v69 = add i64 0, 2
  call void @"rt.panic"(i64 %v69)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v70.p = getelementptr i64, ptr %v58, i64 2
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v58, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v58, i64 1
  %v72 = load i64, ptr %v72.p
  %v75 = add i64 %v71, %v72
  %v76 = call i64 @"rt.tip8"(i64 %v70, i64 %v75)
  %v77 = add i64 0, 0
  %v78.c = icmp ne i64 %v76, %v77
  %v78 = zext i1 %v78.c to i64
  %c.b10 = icmp ne i64 %v78, 0
  br i1 %c.b10, label %b10.t39, label %b10.e40
b10.t39:
  br label %b13
b10.e40:
  br label %b12
b11:
  %v73 = phi ptr [ %v82, %b12 ], [ %v79, %b13 ]
  %v74 = phi ptr [ %v83, %b12 ], [ %v80, %b13 ]
  %st40 = getelementptr i8, ptr %v74, i64 0
  %st40.b = trunc i64 %v66 to i8
  store i8 %st40.b, ptr %st40
  %v84.p = getelementptr i64, ptr %v58, i64 1
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 1
  %v86 = add i64 %v84, %v85
  %v87 = getelementptr i64, ptr %s0, i64 0
  %v88 = ptrtoint ptr %v73 to i64
  %st41 = getelementptr i64, ptr %v87, i64 0
  store i64 %v88, ptr %st41
  %st42 = getelementptr i64, ptr %v87, i64 1
  store i64 %v86, ptr %st42
  %st43 = getelementptr i64, ptr %v87, i64 2
  store i64 %v70, ptr %st43
  %v89.p = getelementptr i64, ptr %v87, i64 0
  %v89 = load i64, ptr %v89.p
  %st44 = getelementptr i64, ptr %v9, i64 0
  store i64 %v89, ptr %st44
  %v90.p = getelementptr i64, ptr %v87, i64 1
  %v90 = load i64, ptr %v90.p
  %st45 = getelementptr i64, ptr %v9, i64 1
  store i64 %v90, ptr %st45
  %v91.p = getelementptr i64, ptr %v87, i64 2
  %v91 = load i64, ptr %v91.p
  %st46 = getelementptr i64, ptr %v9, i64 2
  store i64 %v91, ptr %st46
  %v92 = add i64 0, 1
  %v93 = add i64 %v2, %v92
  %v94.p = getelementptr i64, ptr %v13, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 0, 10
  %v96 = sdiv i64 %v94, %v95
  %st47 = getelementptr i64, ptr %v13, i64 0
  store i64 %v96, ptr %st47
  br label %b6
b12:
  %v81 = add i64 0, 1
  %v82 = call ptr @"rt.slice_grow8"(i64 %v71, i64 %v72, i64 %v70, i64 %v81)
  %v83 = getelementptr i8, ptr %v82, i64 %v72
  br label %b11
b13:
  %v79 = inttoptr i64 %v71 to ptr
  %v80 = getelementptr i8, ptr %v79, i64 %v72
  br label %b11
b14:
  %v166 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v166, i64 0
  store i64 %v111, ptr %st48
  %v112.p = getelementptr i64, ptr %v110, i64 0
  %v112 = load i64, ptr %v112.p
  %v113 = add i64 0, 0
  %v114.c = icmp sge i64 %v112, %v113
  %v114 = zext i1 %v114.c to i64
  %c.b14 = icmp ne i64 %v114, 0
  br i1 %c.b14, label %b14.t50, label %b14.e51
b14.t50:
  br label %b15
b14.e51:
  br label %b16
b15:
  call void @"rt.region_enter"()
  %v167 = getelementptr i64, ptr @"rt.meta", i64 0
  %v115.p = getelementptr i64, ptr %v167, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 1
  %v117 = add i64 %v2, %v116
  %v118 = getelementptr i64, ptr %s0, i64 0
  %v119.p = getelementptr i64, ptr %v103, i64 0
  %v119 = load i64, ptr %v119.p
  %st51 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st51
  %v120.p = getelementptr i64, ptr %v103, i64 1
  %v120 = load i64, ptr %v120.p
  %st52 = getelementptr i64, ptr %v118, i64 1
  store i64 %v120, ptr %st52
  %v121.p = getelementptr i64, ptr %v103, i64 2
  %v121 = load i64, ptr %v121.p
  %st53 = getelementptr i64, ptr %v118, i64 2
  store i64 %v121, ptr %st53
  %v122.p = getelementptr i64, ptr %v110, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v9, i64 1
  %v123 = load i64, ptr %v123.p
  %v124.c = icmp uge i64 %v122, %v123
  %v124 = zext i1 %v124.c to i64
  %c.b15 = icmp ne i64 %v124, 0
  br i1 %c.b15, label %b15.t55, label %b15.e56
b15.t55:
  br label %b17
b15.e56:
  br label %b18
b16:
  %v168 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v168, i64 0
  store i64 %v111, ptr %st56
  %v155.p = getelementptr i64, ptr %v103, i64 0
  %v155 = load i64, ptr %v155.p
  %st57 = getelementptr i64, ptr %v0, i64 0
  store i64 %v155, ptr %st57
  %v156.p = getelementptr i64, ptr %v103, i64 1
  %v156 = load i64, ptr %v156.p
  %st58 = getelementptr i64, ptr %v0, i64 1
  store i64 %v156, ptr %st58
  %v157.p = getelementptr i64, ptr %v103, i64 2
  %v157 = load i64, ptr %v157.p
  %st59 = getelementptr i64, ptr %v0, i64 2
  store i64 %v157, ptr %st59
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v169 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v169, i64 0
  store i64 %v2, ptr %st60
  ret void
b17:
  %v125 = add i64 0, 3
  call void @"rt.panic"(i64 %v125)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v126.p = getelementptr i64, ptr %v9, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = inttoptr i64 %v126 to ptr
  %v128 = getelementptr i8, ptr %v127, i64 %v122
  %v129.p = getelementptr i8, ptr %v128, i64 0
  %v129.b = load i8, ptr %v129.p
  %v129 = zext i8 %v129.b to i64
  %v130.p = getelementptr i64, ptr %v118, i64 2
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v118, i64 0
  %v131 = load i64, ptr %v131.p
  %v132.p = getelementptr i64, ptr %v118, i64 1
  %v132 = load i64, ptr %v132.p
  %v135 = add i64 %v131, %v132
  %v136 = call i64 @"rt.tip8"(i64 %v130, i64 %v135)
  %v137 = add i64 0, 0
  %v138.c = icmp ne i64 %v136, %v137
  %v138 = zext i1 %v138.c to i64
  %c.b18 = icmp ne i64 %v138, 0
  br i1 %c.b18, label %b18.t62, label %b18.e63
b18.t62:
  br label %b21
b18.e63:
  br label %b20
b19:
  %v133 = phi ptr [ %v142, %b20 ], [ %v139, %b21 ]
  %v134 = phi ptr [ %v143, %b20 ], [ %v140, %b21 ]
  %st63 = getelementptr i8, ptr %v134, i64 0
  %st63.b = trunc i64 %v129 to i8
  store i8 %st63.b, ptr %st63
  %v144.p = getelementptr i64, ptr %v118, i64 1
  %v144 = load i64, ptr %v144.p
  %v145 = add i64 0, 1
  %v146 = add i64 %v144, %v145
  %v147 = getelementptr i64, ptr %s5, i64 0
  %v148 = ptrtoint ptr %v133 to i64
  %st64 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st64
  %st65 = getelementptr i64, ptr %v147, i64 1
  store i64 %v146, ptr %st65
  %st66 = getelementptr i64, ptr %v147, i64 2
  store i64 %v130, ptr %st66
  %v149.p = getelementptr i64, ptr %v147, i64 0
  %v149 = load i64, ptr %v149.p
  %st67 = getelementptr i64, ptr %v103, i64 0
  store i64 %v149, ptr %st67
  %v150.p = getelementptr i64, ptr %v147, i64 1
  %v150 = load i64, ptr %v150.p
  %st68 = getelementptr i64, ptr %v103, i64 1
  store i64 %v150, ptr %st68
  %v151.p = getelementptr i64, ptr %v147, i64 2
  %v151 = load i64, ptr %v151.p
  %st69 = getelementptr i64, ptr %v103, i64 2
  store i64 %v151, ptr %st69
  %v152 = add i64 0, 1
  %v153.p = getelementptr i64, ptr %v110, i64 0
  %v153 = load i64, ptr %v153.p
  %v154 = sub i64 %v153, %v152
  %st70 = getelementptr i64, ptr %v110, i64 0
  store i64 %v154, ptr %st70
  br label %b14
b20:
  %v141 = add i64 0, 1
  %v142 = call ptr @"rt.slice_grow8"(i64 %v131, i64 %v132, i64 %v130, i64 %v141)
  %v143 = getelementptr i8, ptr %v142, i64 %v132
  br label %b19
b21:
  %v139 = inttoptr i64 %v131 to ptr
  %v140 = getelementptr i8, ptr %v139, i64 %v132
  br label %b19
}

define internal void @"main.inner2"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11) #0 {
b0:
  %s0 = alloca [5 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s0.z3 = getelementptr i64, ptr %s0, i64 3
  store i64 0, ptr %s0.z3
  %s0.z4 = getelementptr i64, ptr %s0, i64 4
  store i64 0, ptr %s0.z4
  %s1 = alloca [6 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
  %s1.z4 = getelementptr i64, ptr %s1, i64 4
  store i64 0, ptr %s1.z4
  %s1.z5 = getelementptr i64, ptr %s1, i64 5
  store i64 0, ptr %s1.z5
  %s2 = alloca [5 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s2.z3 = getelementptr i64, ptr %s2, i64 3
  store i64 0, ptr %s2.z3
  %s2.z4 = getelementptr i64, ptr %s2, i64 4
  store i64 0, ptr %s2.z4
  %s3 = alloca [3 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [3 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %s11 = alloca [3 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %s11.z2 = getelementptr i64, ptr %s11, i64 2
  store i64 0, ptr %s11.z2
  %s12 = alloca [3 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s13 = alloca [3 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s13.z1 = getelementptr i64, ptr %s13, i64 1
  store i64 0, ptr %s13.z1
  %s13.z2 = getelementptr i64, ptr %s13, i64 2
  store i64 0, ptr %s13.z2
  %s14 = alloca [3 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s14.z1 = getelementptr i64, ptr %s14, i64 1
  store i64 0, ptr %s14.z1
  %s14.z2 = getelementptr i64, ptr %s14, i64 2
  store i64 0, ptr %s14.z2
  %s15 = alloca [6 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s15.z1 = getelementptr i64, ptr %s15, i64 1
  store i64 0, ptr %s15.z1
  %s15.z2 = getelementptr i64, ptr %s15, i64 2
  store i64 0, ptr %s15.z2
  %s15.z3 = getelementptr i64, ptr %s15, i64 3
  store i64 0, ptr %s15.z3
  %s15.z4 = getelementptr i64, ptr %s15, i64 4
  store i64 0, ptr %s15.z4
  %s15.z5 = getelementptr i64, ptr %s15, i64 5
  store i64 0, ptr %s15.z5
  %v12 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v12, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v12, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v12, i64 2
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v12, i64 3
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v12, i64 4
  store i64 %v5, ptr %st4
  %v13 = getelementptr i64, ptr %s1, i64 0
  %st5 = getelementptr i64, ptr %v13, i64 0
  store i64 %v6, ptr %st5
  %st6 = getelementptr i64, ptr %v13, i64 1
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 2
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v13, i64 3
  store i64 %v9, ptr %st8
  %st9 = getelementptr i64, ptr %v13, i64 4
  store i64 %v10, ptr %st9
  %st10 = getelementptr i64, ptr %v13, i64 5
  store i64 %v11, ptr %st10
  %v133 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v133, i64 0
  %v14 = load i64, ptr %v14.p
  call void @"rt.region_enter"()
  %v15.p = getelementptr i64, ptr %v13, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 0
  %v17.c = icmp ne i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b0 = icmp ne i64 %v17, 0
  br i1 %c.b0, label %b0.t12, label %b0.e13
b0.t12:
  br label %b1
b0.e13:
  br label %b2
b1:
  %v18 = add i64 0, 1
  %v19 = getelementptr i64, ptr %v13, i64 %v18
  %v20 = getelementptr i64, ptr %s2, i64 0
  %v21.p = getelementptr i64, ptr %v19, i64 0
  %v21 = load i64, ptr %v21.p
  %st13 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st13
  %v22.p = getelementptr i64, ptr %v19, i64 1
  %v22 = load i64, ptr %v22.p
  %st14 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st14
  %v23.p = getelementptr i64, ptr %v19, i64 2
  %v23 = load i64, ptr %v23.p
  %st15 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st15
  %v24.p = getelementptr i64, ptr %v19, i64 3
  %v24 = load i64, ptr %v24.p
  %st16 = getelementptr i64, ptr %v20, i64 3
  store i64 %v24, ptr %st16
  %v25.p = getelementptr i64, ptr %v19, i64 4
  %v25 = load i64, ptr %v25.p
  %st17 = getelementptr i64, ptr %v20, i64 4
  store i64 %v25, ptr %st17
  %v26.p = getelementptr i64, ptr %v20, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 1
  %v28.c = icmp eq i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b1 = icmp ne i64 %v28, 0
  br i1 %c.b1, label %b1.t19, label %b1.e20
b1.t19:
  br label %b4
b1.e20:
  br label %b3
b2:
  br label %b6
b3:
  %v82 = getelementptr i64, ptr @"str.5", i64 0
  %v83 = add i64 0, 8
  %v84 = add i64 0, 0
  %v85 = getelementptr i64, ptr %s10, i64 0
  %v86 = ptrtoint ptr %v82 to i64
  %st20 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st20
  %st21 = getelementptr i64, ptr %v85, i64 1
  store i64 %v83, ptr %st21
  %st22 = getelementptr i64, ptr %v85, i64 2
  store i64 %v84, ptr %st22
  %v87 = getelementptr i64, ptr %s11, i64 0
  call void @"std/convert.FormatInt"(ptr %v87, i64 %v0)
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v87, i64 1
  %v89 = load i64, ptr %v89.p
  %v90 = add i64 %v88, %v89
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v91.p = getelementptr i64, ptr %v134, i64 0
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v85, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v85, i64 1
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v85, i64 2
  %v94 = load i64, ptr %v94.p
  %v95 = call ptr @"rt.cat8"(i64 %v92, i64 %v93, i64 %v94, i64 %v91, i64 %v89)
  %v96 = getelementptr i8, ptr %v95, i64 %v88
  %v97.p = getelementptr i64, ptr %v87, i64 0
  %v97 = load i64, ptr %v97.p
  %v98 = inttoptr i64 %v97 to ptr
  call void @"rt.copy8"(ptr %v96, ptr %v98, i64 %v89)
  %v99 = getelementptr i64, ptr %s12, i64 0
  %v100 = ptrtoint ptr %v95 to i64
  %st23 = getelementptr i64, ptr %v99, i64 0
  store i64 %v100, ptr %st23
  %st24 = getelementptr i64, ptr %v99, i64 1
  store i64 %v90, ptr %st24
  %st25 = getelementptr i64, ptr %v99, i64 2
  store i64 %v91, ptr %st25
  %v101 = getelementptr i64, ptr @"str.9", i64 0
  %v102 = add i64 0, 6
  %v103 = add i64 0, 0
  %v104 = getelementptr i64, ptr %s13, i64 0
  %v105 = ptrtoint ptr %v101 to i64
  %st26 = getelementptr i64, ptr %v104, i64 0
  store i64 %v105, ptr %st26
  %st27 = getelementptr i64, ptr %v104, i64 1
  store i64 %v102, ptr %st27
  %st28 = getelementptr i64, ptr %v104, i64 2
  store i64 %v103, ptr %st28
  %v106.p = getelementptr i64, ptr %v99, i64 1
  %v106 = load i64, ptr %v106.p
  %v107.p = getelementptr i64, ptr %v104, i64 1
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 %v106, %v107
  %v135 = getelementptr i64, ptr @"rt.meta", i64 0
  %v109.p = getelementptr i64, ptr %v135, i64 0
  %v109 = load i64, ptr %v109.p
  %v110.p = getelementptr i64, ptr %v99, i64 0
  %v110 = load i64, ptr %v110.p
  %v111.p = getelementptr i64, ptr %v99, i64 1
  %v111 = load i64, ptr %v111.p
  %v112.p = getelementptr i64, ptr %v99, i64 2
  %v112 = load i64, ptr %v112.p
  %v113 = call ptr @"rt.cat8"(i64 %v110, i64 %v111, i64 %v112, i64 %v109, i64 %v107)
  %v114 = getelementptr i8, ptr %v113, i64 %v106
  %v115.p = getelementptr i64, ptr %v104, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = inttoptr i64 %v115 to ptr
  call void @"rt.copy8"(ptr %v114, ptr %v116, i64 %v107)
  %v117 = getelementptr i64, ptr %s14, i64 0
  %v118 = ptrtoint ptr %v113 to i64
  %st29 = getelementptr i64, ptr %v117, i64 0
  store i64 %v118, ptr %st29
  %st30 = getelementptr i64, ptr %v117, i64 1
  store i64 %v108, ptr %st30
  %st31 = getelementptr i64, ptr %v117, i64 2
  store i64 %v109, ptr %st31
  call void @"rt.print_str"(ptr %v117)
  %v119 = add i64 0, 10
  call void @"rt.print_char"(i64 %v119)
  %v120 = getelementptr i64, ptr %s15, i64 0
  %v121 = add i64 0, 1
  %st32 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st32
  %v122.p = getelementptr i64, ptr %v12, i64 0
  %v122 = load i64, ptr %v122.p
  %st33 = getelementptr i64, ptr %v120, i64 1
  store i64 %v122, ptr %st33
  %v123.p = getelementptr i64, ptr %v12, i64 1
  %v123 = load i64, ptr %v123.p
  %st34 = getelementptr i64, ptr %v120, i64 2
  store i64 %v123, ptr %st34
  %v124.p = getelementptr i64, ptr %v12, i64 2
  %v124 = load i64, ptr %v124.p
  %st35 = getelementptr i64, ptr %v120, i64 3
  store i64 %v124, ptr %st35
  %v125.p = getelementptr i64, ptr %v12, i64 3
  %v125 = load i64, ptr %v125.p
  %st36 = getelementptr i64, ptr %v120, i64 4
  store i64 %v125, ptr %st36
  %v126.p = getelementptr i64, ptr %v12, i64 4
  %v126 = load i64, ptr %v126.p
  %st37 = getelementptr i64, ptr %v120, i64 5
  store i64 %v126, ptr %st37
  %v127.p = getelementptr i64, ptr %v120, i64 0
  %v127 = load i64, ptr %v127.p
  %v128.p = getelementptr i64, ptr %v120, i64 1
  %v128 = load i64, ptr %v128.p
  %v129.p = getelementptr i64, ptr %v120, i64 2
  %v129 = load i64, ptr %v129.p
  %v130.p = getelementptr i64, ptr %v120, i64 3
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v120, i64 4
  %v131 = load i64, ptr %v131.p
  %v132.p = getelementptr i64, ptr %v120, i64 5
  %v132 = load i64, ptr %v132.p
  call void @"main.show2"(i64 %v127, i64 %v128, i64 %v129, i64 %v130, i64 %v131, i64 %v132)
  br label %b5
b4:
  %v29.p = getelementptr i64, ptr %v20, i64 1
  %v29 = load i64, ptr %v29.p
  %v30 = getelementptr i64, ptr @"str.5", i64 0
  %v31 = add i64 0, 8
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s3, i64 0
  %v34 = ptrtoint ptr %v30 to i64
  %st38 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st38
  %st39 = getelementptr i64, ptr %v33, i64 1
  store i64 %v31, ptr %st39
  %st40 = getelementptr i64, ptr %v33, i64 2
  store i64 %v32, ptr %st40
  %v35 = getelementptr i64, ptr %s4, i64 0
  call void @"std/convert.FormatInt"(ptr %v35, i64 %v0)
  %v36.p = getelementptr i64, ptr %v33, i64 1
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v35, i64 1
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 %v36, %v37
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v136, i64 0
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v33, i64 0
  %v40 = load i64, ptr %v40.p
  %v41.p = getelementptr i64, ptr %v33, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v33, i64 2
  %v42 = load i64, ptr %v42.p
  %v43 = call ptr @"rt.cat8"(i64 %v40, i64 %v41, i64 %v42, i64 %v39, i64 %v37)
  %v44 = getelementptr i8, ptr %v43, i64 %v36
  %v45.p = getelementptr i64, ptr %v35, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = inttoptr i64 %v45 to ptr
  call void @"rt.copy8"(ptr %v44, ptr %v46, i64 %v37)
  %v47 = getelementptr i64, ptr %s5, i64 0
  %v48 = ptrtoint ptr %v43 to i64
  %st41 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st41
  %st42 = getelementptr i64, ptr %v47, i64 1
  store i64 %v38, ptr %st42
  %st43 = getelementptr i64, ptr %v47, i64 2
  store i64 %v39, ptr %st43
  %v49 = getelementptr i64, ptr @"str.8", i64 0
  %v50 = add i64 0, 15
  %v51 = add i64 0, 0
  %v52 = getelementptr i64, ptr %s6, i64 0
  %v53 = ptrtoint ptr %v49 to i64
  %st44 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st44
  %st45 = getelementptr i64, ptr %v52, i64 1
  store i64 %v50, ptr %st45
  %st46 = getelementptr i64, ptr %v52, i64 2
  store i64 %v51, ptr %st46
  %v54.p = getelementptr i64, ptr %v47, i64 1
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v52, i64 1
  %v55 = load i64, ptr %v55.p
  %v56 = add i64 %v54, %v55
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v137, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v47, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v47, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v47, i64 2
  %v60 = load i64, ptr %v60.p
  %v61 = call ptr @"rt.cat8"(i64 %v58, i64 %v59, i64 %v60, i64 %v57, i64 %v55)
  %v62 = getelementptr i8, ptr %v61, i64 %v54
  %v63.p = getelementptr i64, ptr %v52, i64 0
  %v63 = load i64, ptr %v63.p
  %v64 = inttoptr i64 %v63 to ptr
  call void @"rt.copy8"(ptr %v62, ptr %v64, i64 %v55)
  %v65 = getelementptr i64, ptr %s7, i64 0
  %v66 = ptrtoint ptr %v61 to i64
  %st47 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st47
  %st48 = getelementptr i64, ptr %v65, i64 1
  store i64 %v56, ptr %st48
  %st49 = getelementptr i64, ptr %v65, i64 2
  store i64 %v57, ptr %st49
  %v67 = getelementptr i64, ptr %s8, i64 0
  call void @"std/convert.FormatInt"(ptr %v67, i64 %v29)
  %v68.p = getelementptr i64, ptr %v65, i64 1
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v67, i64 1
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 %v68, %v69
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %v71.p = getelementptr i64, ptr %v138, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v65, i64 0
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v65, i64 1
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v65, i64 2
  %v74 = load i64, ptr %v74.p
  %v75 = call ptr @"rt.cat8"(i64 %v72, i64 %v73, i64 %v74, i64 %v71, i64 %v69)
  %v76 = getelementptr i8, ptr %v75, i64 %v68
  %v77.p = getelementptr i64, ptr %v67, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = inttoptr i64 %v77 to ptr
  call void @"rt.copy8"(ptr %v76, ptr %v78, i64 %v69)
  %v79 = getelementptr i64, ptr %s9, i64 0
  %v80 = ptrtoint ptr %v75 to i64
  %st50 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st50
  %st51 = getelementptr i64, ptr %v79, i64 1
  store i64 %v70, ptr %st51
  %st52 = getelementptr i64, ptr %v79, i64 2
  store i64 %v71, ptr %st52
  call void @"rt.print_str"(ptr %v79)
  %v81 = add i64 0, 10
  call void @"rt.print_char"(i64 %v81)
  br label %b5
b5:
  br label %b6
b6:
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v139, i64 0
  store i64 %v14, ptr %st53
  ret void
}
