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
@"rt.sigact" = internal global [4 x i64] zeroinitializer
@"str.0" = internal constant [2 x i64] [i64 3328210909095473713, i64 3160625]
@"str.1" = internal constant [2 x i64] [i64 3328210909095473713, i64 14897]
@"str.2" = internal constant [1 x i64] [i64 1667391791]
@"str.3" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.4" = internal constant [1 x i64] [i64 45]
@"str.5" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.6" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.7" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.8" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.9" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.10" = internal constant [1 x i64] [i64 2685]
@"str.11" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.12" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.13" = internal constant [1 x i64] [i64 35899498962976]
@"str.14" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.15" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [13 x i64] [i64 12666378213392385, i64 16044077933920257, i64 7599827491750147, i64 8725727448924419, i64 8444252572877057, i64 5066552986566657, i64 10414577544069121, i64 4222126663925761, i64 9288676429266947, i64 4785077003223043, i64 1970327236116481, i64 4785077020000259, i64 1970327252893697]
@"str.16" = internal constant [1 x i64] [i64 9071397899755888]
@"str.17" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.18" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.19" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.20" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.21" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.22" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.23" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.24" = internal constant [1 x i64] [i64 544497952]
@"str.25" = internal constant [3 x i64] [i64 3419469540996969587, i64 7305524086039668078, i64 114]
@"str.26" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]

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
  %v3 = getelementptr i64, ptr @"str.5", i64 0
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
  %v29 = getelementptr i64, ptr @"str.9", i64 0
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
  %v35 = getelementptr i64, ptr @"str.10", i64 0
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
  %v10 = getelementptr i64, ptr @"str.6", i64 0
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
  %v17 = getelementptr i64, ptr @"str.7", i64 0
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
  %v24 = getelementptr i64, ptr @"str.8", i64 0
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
  %v60 = getelementptr i64, ptr @"str.11", i64 0
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
  %v65 = getelementptr i64, ptr @"str.12", i64 0
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
  %v70 = getelementptr i64, ptr @"str.10", i64 0
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
  %v81 = getelementptr i64, ptr @"str.13", i64 0
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
  %v88 = getelementptr i64, ptr @"str.14", i64 0
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
  %v17 = getelementptr i64, ptr @"str.15", i64 0
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
  %v22 = getelementptr i64, ptr @"str.10", i64 0
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

define internal void @"rt.read_file"(ptr %v0, ptr %v1, i64 %v2) #0 {
b0:
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %v62 = getelementptr i64, ptr %v61, i64 %v2
  %v5.p = getelementptr i64, ptr %v62, i64 1
  %v5 = load ptr, ptr %v5.p
  %v6 = ptrtoint ptr %v5 to i64
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v6, ptr %st0
  %v7 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v1, i64 1
  store i64 %v7, ptr %st1
  %st2 = getelementptr i64, ptr %v1, i64 2
  store i64 %v2, ptr %st2
  %v8 = call i64 @"rt.cstr"(ptr %v0, ptr %v4)
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
  %v14 = ptrtoint ptr %v4 to i64
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
  %v27.p = getelementptr i64, ptr %v3, i64 1029
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 0, 1
  %v29 = add i64 %v2, %v28
  %v30.p = getelementptr i64, ptr %v3, i64 1030
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
  call void @"rt.extend8"(i64 %v2, i64 %v26, i64 %v34)
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
  call void @"rt.extend8"(i64 %v2, i64 %v26, i64 %v43)
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

define internal void @"rt.read_dir"(ptr %v0, ptr %v1, i64 %v2) #0 {
b0:
  %v3 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v78 = getelementptr i64, ptr %v77, i64 %v2
  %v4.p = getelementptr i64, ptr %v78, i64 1
  %v4 = load ptr, ptr %v4.p
  %v5 = ptrtoint ptr %v4 to i64
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v5, ptr %st0
  %v6 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v1, i64 1
  store i64 %v6, ptr %st1
  %st2 = getelementptr i64, ptr %v1, i64 2
  store i64 %v2, ptr %st2
  %v7 = call i64 @"rt.cstr"(ptr %v0, ptr %v3)
  %v8 = add i64 0, 0
  %v9.c = icmp ne i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b0 = icmp ne i64 %v9, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v10, i64 1027
  store i64 %v7, ptr %st5
  ret void
b2:
  %v11 = add i64 0, 257
  %v12 = add i64 0, -100
  %v13 = ptrtoint ptr %v3 to i64
  %v14 = add i64 0, 589824
  %v15 = add i64 0, 0
  %v16 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v11, i64 %v12, i64 %v13, i64 %v14, i64 %v15)
  %v17 = add i64 0, 0
  %v18.c = icmp slt i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b2 = icmp ne i64 %v18, 0
  br i1 %c.b2, label %b2.t7, label %b2.e8
b2.t7:
  br label %b3
b2.e8:
  br label %b4
b3:
  %v19 = add i64 0, 0
  %v20 = sub i64 %v19, %v16
  %v21 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v21, i64 1027
  store i64 %v20, ptr %st8
  ret void
b4:
  br label %b5
b5:
  %v23 = add i64 0, 217
  %v24 = ptrtoint ptr %v3 to i64
  %v25 = add i64 0, 4096
  %v26 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v23, i64 %v16, i64 %v24, i64 %v25)
  %v27 = add i64 0, -4
  %v28.c = icmp eq i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b5 = icmp ne i64 %v28, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  %v22 = phi i64 [ %v31, %b9 ], [ %v35, %b11 ]
  %v74 = add i64 0, 3
  %v75 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v74, i64 %v16)
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v76, i64 1027
  store i64 %v22, ptr %st11
  ret void
b7:
  br label %b5
b8:
  %v29 = add i64 0, 0
  %v30.c = icmp eq i64 %v26, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b8 = icmp ne i64 %v30, 0
  br i1 %c.b8, label %b8.t13, label %b8.e14
b8.t13:
  br label %b9
b8.e14:
  br label %b10
b9:
  %v31 = add i64 0, 0
  br label %b6
b10:
  %v32 = add i64 0, 0
  %v33.c = icmp slt i64 %v26, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b10 = icmp ne i64 %v33, 0
  br i1 %c.b10, label %b10.t15, label %b10.e16
b10.t15:
  br label %b11
b10.e16:
  br label %b12
b11:
  %v34 = add i64 0, 0
  %v35 = sub i64 %v34, %v26
  br label %b6
b12:
  %v37 = add i64 0, 0
  br label %b13
b13:
  %v36 = phi i64 [ %v37, %b12 ], [ %v73, %b17 ]
  %v38.c = icmp slt i64 %v36, %v26
  %v38 = zext i1 %v38.c to i64
  %c.b13 = icmp ne i64 %v38, 0
  br i1 %c.b13, label %b13.t17, label %b13.e18
b13.t17:
  br label %b14
b13.e18:
  br label %b5
b14:
  %v39 = getelementptr i8, ptr %v3, i64 %v36
  %v40.p = getelementptr i8, ptr %v39, i64 16
  %v40.b = load i8, ptr %v40.p
  %v40 = zext i8 %v40.b to i64
  %v41.p = getelementptr i8, ptr %v39, i64 17
  %v41.b = load i8, ptr %v41.p
  %v41 = zext i8 %v41.b to i64
  %v42 = add i64 0, 8
  %v43.n = and i64 %v42, 63
  %v43 = shl i64 %v41, %v43.n
  %v44 = or i64 %v40, %v43
  %v45 = add i64 0, 19
  %v46 = getelementptr i8, ptr %v39, i64 %v45
  %v49 = add i64 0, 0
  br label %b15
b15:
  %v47 = phi i64 [ %v49, %b14 ], [ %v55, %b16 ]
  %v50 = getelementptr i8, ptr %v46, i64 %v47
  %v51.p = getelementptr i8, ptr %v50, i64 0
  %v51.b = load i8, ptr %v51.p
  %v51 = zext i8 %v51.b to i64
  %v52 = add i64 0, 0
  %v53.c = icmp eq i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b15 = icmp ne i64 %v53, 0
  br i1 %c.b15, label %b15.t19, label %b15.e20
b15.t19:
  br label %b17
b15.e20:
  br label %b16
b16:
  %v54 = add i64 0, 1
  %v55 = add i64 %v47, %v54
  br label %b15
b17:
  %v48 = phi i64 [ %v47, %b15.t19 ]
  %v56.p = getelementptr i64, ptr %v1, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v1, i64 1
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 %v56, %v57
  %v59 = add i64 0, 2
  %v60 = add i64 %v48, %v59
  call void @"rt.extend8"(i64 %v2, i64 %v58, i64 %v60)
  %v61 = inttoptr i64 %v58 to ptr
  %v62.p = getelementptr i8, ptr %v39, i64 18
  %v62.b = load i8, ptr %v62.p
  %v62 = zext i8 %v62.b to i64
  %st20 = getelementptr i8, ptr %v61, i64 0
  %st20.b = trunc i64 %v62 to i8
  store i8 %st20.b, ptr %st20
  %v63 = add i64 0, 1
  %v64 = getelementptr i8, ptr %v61, i64 %v63
  call void @"rt.copy8"(ptr %v64, ptr %v46, i64 %v48)
  %v65 = add i64 0, 1
  %v66 = add i64 %v48, %v65
  %v67 = getelementptr i8, ptr %v61, i64 %v66
  %v68 = add i64 0, 0
  %st21 = getelementptr i8, ptr %v67, i64 0
  %st21.b = trunc i64 %v68 to i8
  store i8 %st21.b, ptr %st21
  %v69.p = getelementptr i64, ptr %v1, i64 1
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 2
  %v71 = add i64 %v48, %v70
  %v72 = add i64 %v69, %v71
  %st22 = getelementptr i64, ptr %v1, i64 1
  store i64 %v72, ptr %st22
  %v73 = add i64 %v36, %v44
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
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v2, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  call void @"main.run"(ptr %v1)
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v0, ptr %st0
  ret void
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
  %v140 = add i64 0, 39
  %v141 = call i64 asm sideeffect "syscall", "={rax},{rax},~{rcx},~{r11},~{memory}"(i64 %v140)
  %v142 = add i64 0, 1
  %v143.c = icmp eq i64 %v141, %v142
  %v143 = zext i1 %v143.c to i64
  %c.b32 = icmp ne i64 %v143, 0
  br i1 %c.b32, label %b32.t49, label %b32.e50
b32.t49:
  br label %b33
b32.e50:
  br label %b34
b33:
  %v144 = getelementptr i64, ptr @"rt.sigact", i64 0
  %v145 = ptrtoint ptr @"rt.sigterm" to i64
  %st50 = getelementptr i64, ptr %v144, i64 0
  store i64 %v145, ptr %st50
  %v146 = add i64 0, 67108864
  %st51 = getelementptr i64, ptr %v144, i64 1
  store i64 %v146, ptr %st51
  %st52 = getelementptr i64, ptr %v144, i64 2
  store i64 %v145, ptr %st52
  %v147 = add i64 0, 0
  %st53 = getelementptr i64, ptr %v144, i64 3
  store i64 %v147, ptr %st53
  %v148 = add i64 0, 13
  %v149 = add i64 0, 15
  %v150 = ptrtoint ptr %v144 to i64
  %v151 = add i64 0, 0
  %v152 = add i64 0, 8
  %v153 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v148, i64 %v149, i64 %v150, i64 %v151, i64 %v152)
  %v154 = ptrtoint ptr @"rt.sigint" to i64
  %st54 = getelementptr i64, ptr %v144, i64 0
  store i64 %v154, ptr %st54
  %st55 = getelementptr i64, ptr %v144, i64 2
  store i64 %v154, ptr %st55
  %v155 = add i64 0, 13
  %v156 = add i64 0, 2
  %v157 = ptrtoint ptr %v144 to i64
  %v158 = add i64 0, 0
  %v159 = add i64 0, 8
  %v160 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v155, i64 %v156, i64 %v157, i64 %v158, i64 %v159)
  br label %b34
b34:
  %st56 = getelementptr i64, ptr %v1, i64 1029
  store i64 %v130, ptr %st56
  %st57 = getelementptr i64, ptr %v1, i64 1030
  store i64 %v121, ptr %st57
  %v161 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v1, i64 0
  store i64 %v161, ptr %st58
  %v162 = add i64 0, 1
  %st59 = getelementptr i64, ptr %v1, i64 1026
  store i64 %v162, ptr %st59
  %v163 = ptrtoint ptr %v0 to i64
  %st60 = getelementptr i64, ptr %v1, i64 2568
  store i64 %v163, ptr %st60
  %v164.p = getelementptr i64, ptr %v0, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 0, 2
  %v166 = add i64 %v164, %v165
  %v167 = getelementptr i64, ptr %v0, i64 %v166
  br label %b35
b35:
  %v168 = phi ptr [ %v167, %b34 ], [ %v246, %b38 ]
  %v170.p = getelementptr i64, ptr %v168, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 0, 0
  %v172.c = icmp eq i64 %v170, %v171
  %v172 = zext i1 %v172.c to i64
  %v173 = add i64 0, 1
  %c.b35 = icmp ne i64 %v172, 0
  br i1 %c.b35, label %b35.t62, label %b35.e63
b35.t62:
  br label %b36
b35.e63:
  br label %b39
b36:
  %v169 = phi i64 [ %v173, %b35.t62 ], [ %v253, %b55.e97 ], [ %v253, %b56.e99 ], [ %v253, %b57.e101 ], [ %v253, %b58.t102 ], [ %v247, %b59 ]
  %v271 = add i64 0, 20
  %v272.n = and i64 %v271, 63
  %v272 = shl i64 %v169, %v272.n
  %st63 = getelementptr i64, ptr %v1, i64 2569
  store i64 %v272, ptr %st63
  %v273 = add i64 0, 0
  %st64 = getelementptr i64, ptr %v1, i64 2570
  store i64 %v273, ptr %st64
  %v274.p = getelementptr i64, ptr %v0, i64 0
  %v274 = load i64, ptr %v274.p
  %v275 = add i64 0, 2
  %v276 = add i64 %v274, %v275
  %v277 = getelementptr i64, ptr %v0, i64 %v276
  br label %b61
b37:
  %v249 = add i64 0, 0
  %v250 = add i64 0, 14
  br label %b54
b38:
  %v245 = add i64 0, 1
  %v246 = getelementptr i64, ptr %v168, i64 %v245
  br label %b35
b39:
  %v174 = inttoptr i64 %v170 to ptr
  %v175 = add i64 0, 0
  %v176 = getelementptr i8, ptr %v174, i64 %v175
  %v177.p = getelementptr i8, ptr %v176, i64 0
  %v177.b = load i8, ptr %v177.p
  %v177 = zext i8 %v177.b to i64
  %v178 = add i64 0, 83
  %v179.c = icmp eq i64 %v177, %v178
  %v179 = zext i1 %v179.c to i64
  %c.b39 = icmp ne i64 %v179, 0
  br i1 %c.b39, label %b39.t66, label %b39.e67
b39.t66:
  br label %b40
b39.e67:
  br label %b38
b40:
  %v180 = add i64 0, 1
  %v181 = getelementptr i8, ptr %v174, i64 %v180
  %v182.p = getelementptr i8, ptr %v181, i64 0
  %v182.b = load i8, ptr %v182.p
  %v182 = zext i8 %v182.b to i64
  %v183 = add i64 0, 79
  %v184.c = icmp eq i64 %v182, %v183
  %v184 = zext i1 %v184.c to i64
  %c.b40 = icmp ne i64 %v184, 0
  br i1 %c.b40, label %b40.t68, label %b40.e69
b40.t68:
  br label %b41
b40.e69:
  br label %b38
b41:
  %v185 = add i64 0, 2
  %v186 = getelementptr i8, ptr %v174, i64 %v185
  %v187.p = getelementptr i8, ptr %v186, i64 0
  %v187.b = load i8, ptr %v187.p
  %v187 = zext i8 %v187.b to i64
  %v188 = add i64 0, 66
  %v189.c = icmp eq i64 %v187, %v188
  %v189 = zext i1 %v189.c to i64
  %c.b41 = icmp ne i64 %v189, 0
  br i1 %c.b41, label %b41.t70, label %b41.e71
b41.t70:
  br label %b42
b41.e71:
  br label %b38
b42:
  %v190 = add i64 0, 3
  %v191 = getelementptr i8, ptr %v174, i64 %v190
  %v192.p = getelementptr i8, ptr %v191, i64 0
  %v192.b = load i8, ptr %v192.p
  %v192 = zext i8 %v192.b to i64
  %v193 = add i64 0, 69
  %v194.c = icmp eq i64 %v192, %v193
  %v194 = zext i1 %v194.c to i64
  %c.b42 = icmp ne i64 %v194, 0
  br i1 %c.b42, label %b42.t72, label %b42.e73
b42.t72:
  br label %b43
b42.e73:
  br label %b38
b43:
  %v195 = add i64 0, 4
  %v196 = getelementptr i8, ptr %v174, i64 %v195
  %v197.p = getelementptr i8, ptr %v196, i64 0
  %v197.b = load i8, ptr %v197.p
  %v197 = zext i8 %v197.b to i64
  %v198 = add i64 0, 82
  %v199.c = icmp eq i64 %v197, %v198
  %v199 = zext i1 %v199.c to i64
  %c.b43 = icmp ne i64 %v199, 0
  br i1 %c.b43, label %b43.t74, label %b43.e75
b43.t74:
  br label %b44
b43.e75:
  br label %b38
b44:
  %v200 = add i64 0, 5
  %v201 = getelementptr i8, ptr %v174, i64 %v200
  %v202.p = getelementptr i8, ptr %v201, i64 0
  %v202.b = load i8, ptr %v202.p
  %v202 = zext i8 %v202.b to i64
  %v203 = add i64 0, 95
  %v204.c = icmp eq i64 %v202, %v203
  %v204 = zext i1 %v204.c to i64
  %c.b44 = icmp ne i64 %v204, 0
  br i1 %c.b44, label %b44.t76, label %b44.e77
b44.t76:
  br label %b45
b44.e77:
  br label %b38
b45:
  %v205 = add i64 0, 6
  %v206 = getelementptr i8, ptr %v174, i64 %v205
  %v207.p = getelementptr i8, ptr %v206, i64 0
  %v207.b = load i8, ptr %v207.p
  %v207 = zext i8 %v207.b to i64
  %v208 = add i64 0, 77
  %v209.c = icmp eq i64 %v207, %v208
  %v209 = zext i1 %v209.c to i64
  %c.b45 = icmp ne i64 %v209, 0
  br i1 %c.b45, label %b45.t78, label %b45.e79
b45.t78:
  br label %b46
b45.e79:
  br label %b38
b46:
  %v210 = add i64 0, 7
  %v211 = getelementptr i8, ptr %v174, i64 %v210
  %v212.p = getelementptr i8, ptr %v211, i64 0
  %v212.b = load i8, ptr %v212.p
  %v212 = zext i8 %v212.b to i64
  %v213 = add i64 0, 65
  %v214.c = icmp eq i64 %v212, %v213
  %v214 = zext i1 %v214.c to i64
  %c.b46 = icmp ne i64 %v214, 0
  br i1 %c.b46, label %b46.t80, label %b46.e81
b46.t80:
  br label %b47
b46.e81:
  br label %b38
b47:
  %v215 = add i64 0, 8
  %v216 = getelementptr i8, ptr %v174, i64 %v215
  %v217.p = getelementptr i8, ptr %v216, i64 0
  %v217.b = load i8, ptr %v217.p
  %v217 = zext i8 %v217.b to i64
  %v218 = add i64 0, 68
  %v219.c = icmp eq i64 %v217, %v218
  %v219 = zext i1 %v219.c to i64
  %c.b47 = icmp ne i64 %v219, 0
  br i1 %c.b47, label %b47.t82, label %b47.e83
b47.t82:
  br label %b48
b47.e83:
  br label %b38
b48:
  %v220 = add i64 0, 9
  %v221 = getelementptr i8, ptr %v174, i64 %v220
  %v222.p = getelementptr i8, ptr %v221, i64 0
  %v222.b = load i8, ptr %v222.p
  %v222 = zext i8 %v222.b to i64
  %v223 = add i64 0, 86
  %v224.c = icmp eq i64 %v222, %v223
  %v224 = zext i1 %v224.c to i64
  %c.b48 = icmp ne i64 %v224, 0
  br i1 %c.b48, label %b48.t84, label %b48.e85
b48.t84:
  br label %b49
b48.e85:
  br label %b38
b49:
  %v225 = add i64 0, 10
  %v226 = getelementptr i8, ptr %v174, i64 %v225
  %v227.p = getelementptr i8, ptr %v226, i64 0
  %v227.b = load i8, ptr %v227.p
  %v227 = zext i8 %v227.b to i64
  %v228 = add i64 0, 95
  %v229.c = icmp eq i64 %v227, %v228
  %v229 = zext i1 %v229.c to i64
  %c.b49 = icmp ne i64 %v229, 0
  br i1 %c.b49, label %b49.t86, label %b49.e87
b49.t86:
  br label %b50
b49.e87:
  br label %b38
b50:
  %v230 = add i64 0, 11
  %v231 = getelementptr i8, ptr %v174, i64 %v230
  %v232.p = getelementptr i8, ptr %v231, i64 0
  %v232.b = load i8, ptr %v232.p
  %v232 = zext i8 %v232.b to i64
  %v233 = add i64 0, 77
  %v234.c = icmp eq i64 %v232, %v233
  %v234 = zext i1 %v234.c to i64
  %c.b50 = icmp ne i64 %v234, 0
  br i1 %c.b50, label %b50.t88, label %b50.e89
b50.t88:
  br label %b51
b50.e89:
  br label %b38
b51:
  %v235 = add i64 0, 12
  %v236 = getelementptr i8, ptr %v174, i64 %v235
  %v237.p = getelementptr i8, ptr %v236, i64 0
  %v237.b = load i8, ptr %v237.p
  %v237 = zext i8 %v237.b to i64
  %v238 = add i64 0, 66
  %v239.c = icmp eq i64 %v237, %v238
  %v239 = zext i1 %v239.c to i64
  %c.b51 = icmp ne i64 %v239, 0
  br i1 %c.b51, label %b51.t90, label %b51.e91
b51.t90:
  br label %b52
b51.e91:
  br label %b38
b52:
  %v240 = add i64 0, 13
  %v241 = getelementptr i8, ptr %v174, i64 %v240
  %v242.p = getelementptr i8, ptr %v241, i64 0
  %v242.b = load i8, ptr %v242.p
  %v242 = zext i8 %v242.b to i64
  %v243 = add i64 0, 61
  %v244.c = icmp eq i64 %v242, %v243
  %v244 = zext i1 %v244.c to i64
  %c.b52 = icmp ne i64 %v244, 0
  br i1 %c.b52, label %b52.t92, label %b52.e93
b52.t92:
  br label %b53
b52.e93:
  br label %b38
b53:
  br label %b37
b54:
  %v247 = phi i64 [ %v249, %b37 ], [ %v266, %b60 ]
  %v248 = phi i64 [ %v250, %b37 ], [ %v270, %b60 ]
  %v251 = getelementptr i8, ptr %v174, i64 %v248
  %v252.p = getelementptr i8, ptr %v251, i64 0
  %v252.b = load i8, ptr %v252.p
  %v252 = zext i8 %v252.b to i64
  %v253 = add i64 0, 1
  %v254 = add i64 0, 0
  %v255.c = icmp eq i64 %v252, %v254
  %v255 = zext i1 %v255.c to i64
  %c.b54 = icmp ne i64 %v255, 0
  br i1 %c.b54, label %b54.t94, label %b54.e95
b54.t94:
  br label %b55
b54.e95:
  br label %b56
b55:
  %v256 = add i64 0, 14
  %v257.c = icmp sgt i64 %v248, %v256
  %v257 = zext i1 %v257.c to i64
  %c.b55 = icmp ne i64 %v257, 0
  br i1 %c.b55, label %b55.t96, label %b55.e97
b55.t96:
  br label %b59
b55.e97:
  br label %b36
b56:
  %v258 = add i64 0, 48
  %v259.c = icmp sge i64 %v252, %v258
  %v259 = zext i1 %v259.c to i64
  %c.b56 = icmp ne i64 %v259, 0
  br i1 %c.b56, label %b56.t98, label %b56.e99
b56.t98:
  br label %b57
b56.e99:
  br label %b36
b57:
  %v260 = add i64 0, 57
  %v261.c = icmp sle i64 %v252, %v260
  %v261 = zext i1 %v261.c to i64
  %c.b57 = icmp ne i64 %v261, 0
  br i1 %c.b57, label %b57.t100, label %b57.e101
b57.t100:
  br label %b58
b57.e101:
  br label %b36
b58:
  %v262 = add i64 0, 10
  %v263 = mul i64 %v247, %v262
  %v264 = add i64 0, 48
  %v265 = sub i64 %v252, %v264
  %v266 = add i64 %v263, %v265
  %v267 = add i64 0, 65536
  %v268.c = icmp sgt i64 %v266, %v267
  %v268 = zext i1 %v268.c to i64
  %c.b58 = icmp ne i64 %v268, 0
  br i1 %c.b58, label %b58.t102, label %b58.e103
b58.t102:
  br label %b36
b58.e103:
  br label %b60
b59:
  br label %b36
b60:
  %v269 = add i64 0, 1
  %v270 = add i64 %v248, %v269
  br label %b54
b61:
  %v278 = phi ptr [ %v277, %b36 ], [ %v381, %b64 ]
  %v280.p = getelementptr i64, ptr %v278, i64 0
  %v280 = load i64, ptr %v280.p
  %v281 = add i64 0, 0
  %v282.c = icmp eq i64 %v280, %v281
  %v282 = zext i1 %v282.c to i64
  %v283 = add i64 0, 0
  %c.b61 = icmp ne i64 %v282, 0
  br i1 %c.b61, label %b61.t104, label %b61.e105
b61.t104:
  br label %b62
b61.e105:
  br label %b65
b62:
  %v279 = phi i64 [ %v283, %b61.t104 ], [ %v388, %b86.e148 ], [ %v388, %b87.e150 ], [ %v388, %b88.e152 ], [ %v388, %b89.t153 ], [ %v382, %b90 ]
  %st105 = getelementptr i64, ptr %v1, i64 2573
  store i64 %v279, ptr %st105
  call void @"main.main"()
  call void @"rt.depth_report"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 0)
  unreachable
b63:
  %v384 = add i64 0, 0
  %v385 = add i64 0, 19
  br label %b85
b64:
  %v380 = add i64 0, 1
  %v381 = getelementptr i64, ptr %v278, i64 %v380
  br label %b61
b65:
  %v284 = inttoptr i64 %v280 to ptr
  %v285 = add i64 0, 0
  %v286 = getelementptr i8, ptr %v284, i64 %v285
  %v287.p = getelementptr i8, ptr %v286, i64 0
  %v287.b = load i8, ptr %v287.p
  %v287 = zext i8 %v287.b to i64
  %v288 = add i64 0, 83
  %v289.c = icmp eq i64 %v287, %v288
  %v289 = zext i1 %v289.c to i64
  %c.b65 = icmp ne i64 %v289, 0
  br i1 %c.b65, label %b65.t107, label %b65.e108
b65.t107:
  br label %b66
b65.e108:
  br label %b64
b66:
  %v290 = add i64 0, 1
  %v291 = getelementptr i8, ptr %v284, i64 %v290
  %v292.p = getelementptr i8, ptr %v291, i64 0
  %v292.b = load i8, ptr %v292.p
  %v292 = zext i8 %v292.b to i64
  %v293 = add i64 0, 79
  %v294.c = icmp eq i64 %v292, %v293
  %v294 = zext i1 %v294.c to i64
  %c.b66 = icmp ne i64 %v294, 0
  br i1 %c.b66, label %b66.t109, label %b66.e110
b66.t109:
  br label %b67
b66.e110:
  br label %b64
b67:
  %v295 = add i64 0, 2
  %v296 = getelementptr i8, ptr %v284, i64 %v295
  %v297.p = getelementptr i8, ptr %v296, i64 0
  %v297.b = load i8, ptr %v297.p
  %v297 = zext i8 %v297.b to i64
  %v298 = add i64 0, 66
  %v299.c = icmp eq i64 %v297, %v298
  %v299 = zext i1 %v299.c to i64
  %c.b67 = icmp ne i64 %v299, 0
  br i1 %c.b67, label %b67.t111, label %b67.e112
b67.t111:
  br label %b68
b67.e112:
  br label %b64
b68:
  %v300 = add i64 0, 3
  %v301 = getelementptr i8, ptr %v284, i64 %v300
  %v302.p = getelementptr i8, ptr %v301, i64 0
  %v302.b = load i8, ptr %v302.p
  %v302 = zext i8 %v302.b to i64
  %v303 = add i64 0, 69
  %v304.c = icmp eq i64 %v302, %v303
  %v304 = zext i1 %v304.c to i64
  %c.b68 = icmp ne i64 %v304, 0
  br i1 %c.b68, label %b68.t113, label %b68.e114
b68.t113:
  br label %b69
b68.e114:
  br label %b64
b69:
  %v305 = add i64 0, 4
  %v306 = getelementptr i8, ptr %v284, i64 %v305
  %v307.p = getelementptr i8, ptr %v306, i64 0
  %v307.b = load i8, ptr %v307.p
  %v307 = zext i8 %v307.b to i64
  %v308 = add i64 0, 82
  %v309.c = icmp eq i64 %v307, %v308
  %v309 = zext i1 %v309.c to i64
  %c.b69 = icmp ne i64 %v309, 0
  br i1 %c.b69, label %b69.t115, label %b69.e116
b69.t115:
  br label %b70
b69.e116:
  br label %b64
b70:
  %v310 = add i64 0, 5
  %v311 = getelementptr i8, ptr %v284, i64 %v310
  %v312.p = getelementptr i8, ptr %v311, i64 0
  %v312.b = load i8, ptr %v312.p
  %v312 = zext i8 %v312.b to i64
  %v313 = add i64 0, 95
  %v314.c = icmp eq i64 %v312, %v313
  %v314 = zext i1 %v314.c to i64
  %c.b70 = icmp ne i64 %v314, 0
  br i1 %c.b70, label %b70.t117, label %b70.e118
b70.t117:
  br label %b71
b70.e118:
  br label %b64
b71:
  %v315 = add i64 0, 6
  %v316 = getelementptr i8, ptr %v284, i64 %v315
  %v317.p = getelementptr i8, ptr %v316, i64 0
  %v317.b = load i8, ptr %v317.p
  %v317 = zext i8 %v317.b to i64
  %v318 = add i64 0, 68
  %v319.c = icmp eq i64 %v317, %v318
  %v319 = zext i1 %v319.c to i64
  %c.b71 = icmp ne i64 %v319, 0
  br i1 %c.b71, label %b71.t119, label %b71.e120
b71.t119:
  br label %b72
b71.e120:
  br label %b64
b72:
  %v320 = add i64 0, 7
  %v321 = getelementptr i8, ptr %v284, i64 %v320
  %v322.p = getelementptr i8, ptr %v321, i64 0
  %v322.b = load i8, ptr %v322.p
  %v322 = zext i8 %v322.b to i64
  %v323 = add i64 0, 69
  %v324.c = icmp eq i64 %v322, %v323
  %v324 = zext i1 %v324.c to i64
  %c.b72 = icmp ne i64 %v324, 0
  br i1 %c.b72, label %b72.t121, label %b72.e122
b72.t121:
  br label %b73
b72.e122:
  br label %b64
b73:
  %v325 = add i64 0, 8
  %v326 = getelementptr i8, ptr %v284, i64 %v325
  %v327.p = getelementptr i8, ptr %v326, i64 0
  %v327.b = load i8, ptr %v327.p
  %v327 = zext i8 %v327.b to i64
  %v328 = add i64 0, 80
  %v329.c = icmp eq i64 %v327, %v328
  %v329 = zext i1 %v329.c to i64
  %c.b73 = icmp ne i64 %v329, 0
  br i1 %c.b73, label %b73.t123, label %b73.e124
b73.t123:
  br label %b74
b73.e124:
  br label %b64
b74:
  %v330 = add i64 0, 9
  %v331 = getelementptr i8, ptr %v284, i64 %v330
  %v332.p = getelementptr i8, ptr %v331, i64 0
  %v332.b = load i8, ptr %v332.p
  %v332 = zext i8 %v332.b to i64
  %v333 = add i64 0, 84
  %v334.c = icmp eq i64 %v332, %v333
  %v334 = zext i1 %v334.c to i64
  %c.b74 = icmp ne i64 %v334, 0
  br i1 %c.b74, label %b74.t125, label %b74.e126
b74.t125:
  br label %b75
b74.e126:
  br label %b64
b75:
  %v335 = add i64 0, 10
  %v336 = getelementptr i8, ptr %v284, i64 %v335
  %v337.p = getelementptr i8, ptr %v336, i64 0
  %v337.b = load i8, ptr %v337.p
  %v337 = zext i8 %v337.b to i64
  %v338 = add i64 0, 72
  %v339.c = icmp eq i64 %v337, %v338
  %v339 = zext i1 %v339.c to i64
  %c.b75 = icmp ne i64 %v339, 0
  br i1 %c.b75, label %b75.t127, label %b75.e128
b75.t127:
  br label %b76
b75.e128:
  br label %b64
b76:
  %v340 = add i64 0, 11
  %v341 = getelementptr i8, ptr %v284, i64 %v340
  %v342.p = getelementptr i8, ptr %v341, i64 0
  %v342.b = load i8, ptr %v342.p
  %v342 = zext i8 %v342.b to i64
  %v343 = add i64 0, 95
  %v344.c = icmp eq i64 %v342, %v343
  %v344 = zext i1 %v344.c to i64
  %c.b76 = icmp ne i64 %v344, 0
  br i1 %c.b76, label %b76.t129, label %b76.e130
b76.t129:
  br label %b77
b76.e130:
  br label %b64
b77:
  %v345 = add i64 0, 12
  %v346 = getelementptr i8, ptr %v284, i64 %v345
  %v347.p = getelementptr i8, ptr %v346, i64 0
  %v347.b = load i8, ptr %v347.p
  %v347 = zext i8 %v347.b to i64
  %v348 = add i64 0, 82
  %v349.c = icmp eq i64 %v347, %v348
  %v349 = zext i1 %v349.c to i64
  %c.b77 = icmp ne i64 %v349, 0
  br i1 %c.b77, label %b77.t131, label %b77.e132
b77.t131:
  br label %b78
b77.e132:
  br label %b64
b78:
  %v350 = add i64 0, 13
  %v351 = getelementptr i8, ptr %v284, i64 %v350
  %v352.p = getelementptr i8, ptr %v351, i64 0
  %v352.b = load i8, ptr %v352.p
  %v352 = zext i8 %v352.b to i64
  %v353 = add i64 0, 69
  %v354.c = icmp eq i64 %v352, %v353
  %v354 = zext i1 %v354.c to i64
  %c.b78 = icmp ne i64 %v354, 0
  br i1 %c.b78, label %b78.t133, label %b78.e134
b78.t133:
  br label %b79
b78.e134:
  br label %b64
b79:
  %v355 = add i64 0, 14
  %v356 = getelementptr i8, ptr %v284, i64 %v355
  %v357.p = getelementptr i8, ptr %v356, i64 0
  %v357.b = load i8, ptr %v357.p
  %v357 = zext i8 %v357.b to i64
  %v358 = add i64 0, 80
  %v359.c = icmp eq i64 %v357, %v358
  %v359 = zext i1 %v359.c to i64
  %c.b79 = icmp ne i64 %v359, 0
  br i1 %c.b79, label %b79.t135, label %b79.e136
b79.t135:
  br label %b80
b79.e136:
  br label %b64
b80:
  %v360 = add i64 0, 15
  %v361 = getelementptr i8, ptr %v284, i64 %v360
  %v362.p = getelementptr i8, ptr %v361, i64 0
  %v362.b = load i8, ptr %v362.p
  %v362 = zext i8 %v362.b to i64
  %v363 = add i64 0, 79
  %v364.c = icmp eq i64 %v362, %v363
  %v364 = zext i1 %v364.c to i64
  %c.b80 = icmp ne i64 %v364, 0
  br i1 %c.b80, label %b80.t137, label %b80.e138
b80.t137:
  br label %b81
b80.e138:
  br label %b64
b81:
  %v365 = add i64 0, 16
  %v366 = getelementptr i8, ptr %v284, i64 %v365
  %v367.p = getelementptr i8, ptr %v366, i64 0
  %v367.b = load i8, ptr %v367.p
  %v367 = zext i8 %v367.b to i64
  %v368 = add i64 0, 82
  %v369.c = icmp eq i64 %v367, %v368
  %v369 = zext i1 %v369.c to i64
  %c.b81 = icmp ne i64 %v369, 0
  br i1 %c.b81, label %b81.t139, label %b81.e140
b81.t139:
  br label %b82
b81.e140:
  br label %b64
b82:
  %v370 = add i64 0, 17
  %v371 = getelementptr i8, ptr %v284, i64 %v370
  %v372.p = getelementptr i8, ptr %v371, i64 0
  %v372.b = load i8, ptr %v372.p
  %v372 = zext i8 %v372.b to i64
  %v373 = add i64 0, 84
  %v374.c = icmp eq i64 %v372, %v373
  %v374 = zext i1 %v374.c to i64
  %c.b82 = icmp ne i64 %v374, 0
  br i1 %c.b82, label %b82.t141, label %b82.e142
b82.t141:
  br label %b83
b82.e142:
  br label %b64
b83:
  %v375 = add i64 0, 18
  %v376 = getelementptr i8, ptr %v284, i64 %v375
  %v377.p = getelementptr i8, ptr %v376, i64 0
  %v377.b = load i8, ptr %v377.p
  %v377 = zext i8 %v377.b to i64
  %v378 = add i64 0, 61
  %v379.c = icmp eq i64 %v377, %v378
  %v379 = zext i1 %v379.c to i64
  %c.b83 = icmp ne i64 %v379, 0
  br i1 %c.b83, label %b83.t143, label %b83.e144
b83.t143:
  br label %b84
b83.e144:
  br label %b64
b84:
  br label %b63
b85:
  %v382 = phi i64 [ %v384, %b63 ], [ %v401, %b91 ]
  %v383 = phi i64 [ %v385, %b63 ], [ %v405, %b91 ]
  %v386 = getelementptr i8, ptr %v284, i64 %v383
  %v387.p = getelementptr i8, ptr %v386, i64 0
  %v387.b = load i8, ptr %v387.p
  %v387 = zext i8 %v387.b to i64
  %v388 = add i64 0, 0
  %v389 = add i64 0, 0
  %v390.c = icmp eq i64 %v387, %v389
  %v390 = zext i1 %v390.c to i64
  %c.b85 = icmp ne i64 %v390, 0
  br i1 %c.b85, label %b85.t145, label %b85.e146
b85.t145:
  br label %b86
b85.e146:
  br label %b87
b86:
  %v391 = add i64 0, 19
  %v392.c = icmp sgt i64 %v383, %v391
  %v392 = zext i1 %v392.c to i64
  %c.b86 = icmp ne i64 %v392, 0
  br i1 %c.b86, label %b86.t147, label %b86.e148
b86.t147:
  br label %b90
b86.e148:
  br label %b62
b87:
  %v393 = add i64 0, 48
  %v394.c = icmp sge i64 %v387, %v393
  %v394 = zext i1 %v394.c to i64
  %c.b87 = icmp ne i64 %v394, 0
  br i1 %c.b87, label %b87.t149, label %b87.e150
b87.t149:
  br label %b88
b87.e150:
  br label %b62
b88:
  %v395 = add i64 0, 57
  %v396.c = icmp sle i64 %v387, %v395
  %v396 = zext i1 %v396.c to i64
  %c.b88 = icmp ne i64 %v396, 0
  br i1 %c.b88, label %b88.t151, label %b88.e152
b88.t151:
  br label %b89
b88.e152:
  br label %b62
b89:
  %v397 = add i64 0, 10
  %v398 = mul i64 %v382, %v397
  %v399 = add i64 0, 48
  %v400 = sub i64 %v387, %v399
  %v401 = add i64 %v398, %v400
  %v402 = add i64 0, 65536
  %v403.c = icmp sgt i64 %v401, %v402
  %v403 = zext i1 %v403.c to i64
  %c.b89 = icmp ne i64 %v403, 0
  br i1 %c.b89, label %b89.t153, label %b89.e154
b89.t153:
  br label %b62
b89.e154:
  br label %b91
b90:
  br label %b62
b91:
  %v404 = add i64 0, 1
  %v405 = add i64 %v383, %v404
  br label %b85
}

define internal void @"rt.sigterm"() #0 {
b0:
  %v0 = add i64 0, 231
  %v1 = add i64 0, 143
  %v2 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v0, i64 %v1)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 143)
  unreachable
}

define internal void @"rt.sigint"() #0 {
b0:
  %v0 = add i64 0, 231
  %v1 = add i64 0, 130
  %v2 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v0, i64 %v1)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 130)
  unreachable
}

define internal void @"main.run"(ptr %v0) #0 {
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
  %s3 = alloca [2 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s4 = alloca [5 x i64], align 8
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
  %s8 = alloca [5 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s8.z3 = getelementptr i64, ptr %s8, i64 3
  store i64 0, ptr %s8.z3
  %s8.z4 = getelementptr i64, ptr %s8, i64 4
  store i64 0, ptr %s8.z4
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
  %s11 = alloca [5 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %s11.z2 = getelementptr i64, ptr %s11, i64 2
  store i64 0, ptr %s11.z2
  %s11.z3 = getelementptr i64, ptr %s11, i64 3
  store i64 0, ptr %s11.z3
  %s11.z4 = getelementptr i64, ptr %s11, i64 4
  store i64 0, ptr %s11.z4
  %s12 = alloca [1 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s13 = alloca [1 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s14 = alloca [1 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s15 = alloca [1 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
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
  %s18 = alloca [3 x i64], align 8
  %s18.z0 = getelementptr i64, ptr %s18, i64 0
  store i64 0, ptr %s18.z0
  %s18.z1 = getelementptr i64, ptr %s18, i64 1
  store i64 0, ptr %s18.z1
  %s18.z2 = getelementptr i64, ptr %s18, i64 2
  store i64 0, ptr %s18.z2
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
  %s22 = alloca [5 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %s22.z1 = getelementptr i64, ptr %s22, i64 1
  store i64 0, ptr %s22.z1
  %s22.z2 = getelementptr i64, ptr %s22, i64 2
  store i64 0, ptr %s22.z2
  %s22.z3 = getelementptr i64, ptr %s22, i64 3
  store i64 0, ptr %s22.z3
  %s22.z4 = getelementptr i64, ptr %s22, i64 4
  store i64 0, ptr %s22.z4
  %s23 = alloca [1 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %s24 = alloca [5 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s24.z1 = getelementptr i64, ptr %s24, i64 1
  store i64 0, ptr %s24.z1
  %s24.z2 = getelementptr i64, ptr %s24, i64 2
  store i64 0, ptr %s24.z2
  %s24.z3 = getelementptr i64, ptr %s24, i64 3
  store i64 0, ptr %s24.z3
  %s24.z4 = getelementptr i64, ptr %s24, i64 4
  store i64 0, ptr %s24.z4
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
  %s27 = alloca [3 x i64], align 8
  %s27.z0 = getelementptr i64, ptr %s27, i64 0
  store i64 0, ptr %s27.z0
  %s27.z1 = getelementptr i64, ptr %s27, i64 1
  store i64 0, ptr %s27.z1
  %s27.z2 = getelementptr i64, ptr %s27, i64 2
  store i64 0, ptr %s27.z2
  %s28 = alloca [5 x i64], align 8
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
  %s29 = alloca [1 x i64], align 8
  %s29.z0 = getelementptr i64, ptr %s29, i64 0
  store i64 0, ptr %s29.z0
  %s30 = alloca [1 x i64], align 8
  %s30.z0 = getelementptr i64, ptr %s30, i64 0
  store i64 0, ptr %s30.z0
  %s31 = alloca [1 x i64], align 8
  %s31.z0 = getelementptr i64, ptr %s31, i64 0
  store i64 0, ptr %s31.z0
  %s32 = alloca [1 x i64], align 8
  %s32.z0 = getelementptr i64, ptr %s32, i64 0
  store i64 0, ptr %s32.z0
  %s33 = alloca [1 x i64], align 8
  %s33.z0 = getelementptr i64, ptr %s33, i64 0
  store i64 0, ptr %s33.z0
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
  %s35 = alloca [6 x i64], align 8
  %s35.z0 = getelementptr i64, ptr %s35, i64 0
  store i64 0, ptr %s35.z0
  %s35.z1 = getelementptr i64, ptr %s35, i64 1
  store i64 0, ptr %s35.z1
  %s35.z2 = getelementptr i64, ptr %s35, i64 2
  store i64 0, ptr %s35.z2
  %s35.z3 = getelementptr i64, ptr %s35, i64 3
  store i64 0, ptr %s35.z3
  %s35.z4 = getelementptr i64, ptr %s35, i64 4
  store i64 0, ptr %s35.z4
  %s35.z5 = getelementptr i64, ptr %s35, i64 5
  store i64 0, ptr %s35.z5
  %v578 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v578, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v579 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v579, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"str.0", i64 0
  %v4 = add i64 0, 11
  %v5 = add i64 0, 0
  %v6 = getelementptr i64, ptr %s0, i64 0
  %v7 = ptrtoint ptr %v3 to i64
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v4, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v5, ptr %st2
  %v8 = getelementptr i64, ptr %s1, i64 0
  %v9.p = getelementptr i64, ptr %v6, i64 0
  %v9 = load i64, ptr %v9.p
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st3
  %v10.p = getelementptr i64, ptr %v6, i64 1
  %v10 = load i64, ptr %v10.p
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v10, ptr %st4
  %v11.p = getelementptr i64, ptr %v6, i64 2
  %v11 = load i64, ptr %v11.p
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v11, ptr %st5
  %v12 = getelementptr i64, ptr %s2, i64 0
  %v580 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v580, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15 = add i64 0, 0
  %v16.c = icmp ne i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b3
b0.e8:
  br label %b4
b1:
  %v581 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v581, i64 0
  store i64 %v2, ptr %st8
  %v565 = getelementptr i64, ptr %s19, i64 0
  %v566 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v565, i64 0
  store i64 %v566, ptr %st9
  %v567.p = getelementptr i64, ptr %v565, i64 0
  %v567 = load i64, ptr %v567.p
  %st10 = getelementptr i64, ptr %v0, i64 0
  store i64 %v567, ptr %st10
  %v568.p = getelementptr i64, ptr %v565, i64 1
  %v568 = load i64, ptr %v568.p
  %st11 = getelementptr i64, ptr %v0, i64 1
  store i64 %v568, ptr %st11
  %v569.p = getelementptr i64, ptr %v565, i64 2
  %v569 = load i64, ptr %v569.p
  %st12 = getelementptr i64, ptr %v0, i64 2
  store i64 %v569, ptr %st12
  %v570.p = getelementptr i64, ptr %v565, i64 3
  %v570 = load i64, ptr %v570.p
  %st13 = getelementptr i64, ptr %v0, i64 3
  store i64 %v570, ptr %st13
  %v571.p = getelementptr i64, ptr %v565, i64 4
  %v571 = load i64, ptr %v571.p
  %st14 = getelementptr i64, ptr %v0, i64 4
  store i64 %v571, ptr %st14
  %v572.p = getelementptr i64, ptr %v565, i64 5
  %v572 = load i64, ptr %v572.p
  %st15 = getelementptr i64, ptr %v0, i64 5
  store i64 %v572, ptr %st15
  %v573.p = getelementptr i64, ptr %v0, i64 0
  %v573 = load i64, ptr %v573.p
  %v574 = add i64 0, 0
  %v575.c = icmp ne i64 %v573, %v574
  %v575 = zext i1 %v575.c to i64
  %c.b1 = icmp ne i64 %v575, 0
  br i1 %c.b1, label %b1.t17, label %b1.e18
b1.t17:
  br label %b85
b1.e18:
  br label %b86
b2:
  %v550.p = getelementptr i64, ptr %v12, i64 0
  %v550 = load i64, ptr %v550.p
  %v551 = add i64 0, 0
  %v552.c = icmp ne i64 %v550, %v551
  %v552 = zext i1 %v552.c to i64
  %c.b2 = icmp ne i64 %v552, 0
  br i1 %c.b2, label %b2.t19, label %b2.e20
b2.t19:
  br label %b81
b2.e20:
  br label %b82
b3:
  %v17 = getelementptr i64, ptr %s3, i64 0
  %v18 = add i64 0, 0
  %st20 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st20
  %st21 = getelementptr i64, ptr %v17, i64 1
  store i64 %v18, ptr %st21
  %v19 = add i64 0, 9
  %st22 = getelementptr i64, ptr %v17, i64 0
  store i64 %v19, ptr %st22
  %v20 = getelementptr i64, ptr %s4, i64 0
  %v21.p = getelementptr i64, ptr %v17, i64 0
  %v21 = load i64, ptr %v21.p
  %st23 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st23
  %v22.p = getelementptr i64, ptr %v17, i64 1
  %v22 = load i64, ptr %v22.p
  %st24 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st24
  %v23 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st25
  %st26 = getelementptr i64, ptr %v20, i64 3
  store i64 %v23, ptr %st26
  %st27 = getelementptr i64, ptr %v20, i64 4
  store i64 %v23, ptr %st27
  %v24 = getelementptr i64, ptr %s5, i64 0
  %v25 = add i64 0, 1
  %st28 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st28
  %v26.p = getelementptr i64, ptr %v20, i64 0
  %v26 = load i64, ptr %v26.p
  %st29 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st29
  %v27.p = getelementptr i64, ptr %v20, i64 1
  %v27 = load i64, ptr %v27.p
  %st30 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st30
  %v28.p = getelementptr i64, ptr %v20, i64 2
  %v28 = load i64, ptr %v28.p
  %st31 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st31
  %v29.p = getelementptr i64, ptr %v20, i64 3
  %v29 = load i64, ptr %v29.p
  %st32 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st32
  %v30.p = getelementptr i64, ptr %v20, i64 4
  %v30 = load i64, ptr %v30.p
  %st33 = getelementptr i64, ptr %v24, i64 5
  store i64 %v30, ptr %st33
  %v31.p = getelementptr i64, ptr %v24, i64 0
  %v31 = load i64, ptr %v31.p
  %st34 = getelementptr i64, ptr %v12, i64 0
  store i64 %v31, ptr %st34
  %v32.p = getelementptr i64, ptr %v24, i64 1
  %v32 = load i64, ptr %v32.p
  %st35 = getelementptr i64, ptr %v12, i64 1
  store i64 %v32, ptr %st35
  %v33.p = getelementptr i64, ptr %v24, i64 2
  %v33 = load i64, ptr %v33.p
  %st36 = getelementptr i64, ptr %v12, i64 2
  store i64 %v33, ptr %st36
  %v34.p = getelementptr i64, ptr %v24, i64 3
  %v34 = load i64, ptr %v34.p
  %st37 = getelementptr i64, ptr %v12, i64 3
  store i64 %v34, ptr %st37
  %v35.p = getelementptr i64, ptr %v24, i64 4
  %v35 = load i64, ptr %v35.p
  %st38 = getelementptr i64, ptr %v12, i64 4
  store i64 %v35, ptr %st38
  %v36.p = getelementptr i64, ptr %v24, i64 5
  %v36 = load i64, ptr %v36.p
  %st39 = getelementptr i64, ptr %v12, i64 5
  store i64 %v36, ptr %st39
  %v37.p = getelementptr i64, ptr %v12, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 0
  %v39.c = icmp ne i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b3 = icmp ne i64 %v39, 0
  br i1 %c.b3, label %b3.t41, label %b3.e42
b3.t41:
  br label %b5
b3.e42:
  br label %b6
b4:
  br label %b7
b5:
  %v40 = add i64 0, 3
  %v41 = getelementptr i64, ptr %v12, i64 %v40
  %v582 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v41, i64 %v582, i64 %v13)
  br label %b6
b6:
  %v583 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v583, i64 0
  store i64 %v13, ptr %st42
  br label %b2
b7:
  %v42 = getelementptr i64, ptr %s6, i64 0
  %v43.p = getelementptr i64, ptr %v8, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v8, i64 1
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v8, i64 2
  %v45 = load i64, ptr %v45.p
  call void @"std/net.sockaddr"(ptr %v42, i64 %v43, i64 %v44, i64 %v45)
  %v46 = getelementptr i64, ptr %s7, i64 0
  %v47.p = getelementptr i64, ptr %v42, i64 0
  %v47 = load i64, ptr %v47.p
  %st43 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st43
  %v48.p = getelementptr i64, ptr %v42, i64 1
  %v48 = load i64, ptr %v48.p
  %st44 = getelementptr i64, ptr %v46, i64 1
  store i64 %v48, ptr %st44
  %v49.p = getelementptr i64, ptr %v42, i64 2
  %v49 = load i64, ptr %v49.p
  %st45 = getelementptr i64, ptr %v46, i64 2
  store i64 %v49, ptr %st45
  %v50.p = getelementptr i64, ptr %v46, i64 1
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 16
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b7 = icmp ne i64 %v52, 0
  br i1 %c.b7, label %b7.t47, label %b7.e48
b7.t47:
  br label %b8
b7.e48:
  br label %b9
b8:
  %v53 = getelementptr i64, ptr %s3, i64 0
  %v54 = add i64 0, 0
  %st48 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st48
  %st49 = getelementptr i64, ptr %v53, i64 1
  store i64 %v54, ptr %st49
  %v55 = add i64 0, 0
  %st50 = getelementptr i64, ptr %v53, i64 0
  store i64 %v55, ptr %st50
  %v56 = getelementptr i64, ptr %s4, i64 0
  %v57.p = getelementptr i64, ptr %v53, i64 0
  %v57 = load i64, ptr %v57.p
  %st51 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st51
  %v58.p = getelementptr i64, ptr %v53, i64 1
  %v58 = load i64, ptr %v58.p
  %st52 = getelementptr i64, ptr %v56, i64 1
  store i64 %v58, ptr %st52
  %v59 = add i64 0, 0
  %st53 = getelementptr i64, ptr %v56, i64 2
  store i64 %v59, ptr %st53
  %st54 = getelementptr i64, ptr %v56, i64 3
  store i64 %v59, ptr %st54
  %st55 = getelementptr i64, ptr %v56, i64 4
  store i64 %v59, ptr %st55
  %v60 = getelementptr i64, ptr %s5, i64 0
  %v61 = add i64 0, 1
  %st56 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st56
  %v62.p = getelementptr i64, ptr %v56, i64 0
  %v62 = load i64, ptr %v62.p
  %st57 = getelementptr i64, ptr %v60, i64 1
  store i64 %v62, ptr %st57
  %v63.p = getelementptr i64, ptr %v56, i64 1
  %v63 = load i64, ptr %v63.p
  %st58 = getelementptr i64, ptr %v60, i64 2
  store i64 %v63, ptr %st58
  %v64.p = getelementptr i64, ptr %v56, i64 2
  %v64 = load i64, ptr %v64.p
  %st59 = getelementptr i64, ptr %v60, i64 3
  store i64 %v64, ptr %st59
  %v65.p = getelementptr i64, ptr %v56, i64 3
  %v65 = load i64, ptr %v65.p
  %st60 = getelementptr i64, ptr %v60, i64 4
  store i64 %v65, ptr %st60
  %v66.p = getelementptr i64, ptr %v56, i64 4
  %v66 = load i64, ptr %v66.p
  %st61 = getelementptr i64, ptr %v60, i64 5
  store i64 %v66, ptr %st61
  %v67.p = getelementptr i64, ptr %v60, i64 0
  %v67 = load i64, ptr %v67.p
  %st62 = getelementptr i64, ptr %v12, i64 0
  store i64 %v67, ptr %st62
  %v68.p = getelementptr i64, ptr %v60, i64 1
  %v68 = load i64, ptr %v68.p
  %st63 = getelementptr i64, ptr %v12, i64 1
  store i64 %v68, ptr %st63
  %v69.p = getelementptr i64, ptr %v60, i64 2
  %v69 = load i64, ptr %v69.p
  %st64 = getelementptr i64, ptr %v12, i64 2
  store i64 %v69, ptr %st64
  %v70.p = getelementptr i64, ptr %v60, i64 3
  %v70 = load i64, ptr %v70.p
  %st65 = getelementptr i64, ptr %v12, i64 3
  store i64 %v70, ptr %st65
  %v71.p = getelementptr i64, ptr %v60, i64 4
  %v71 = load i64, ptr %v71.p
  %st66 = getelementptr i64, ptr %v12, i64 4
  store i64 %v71, ptr %st66
  %v72.p = getelementptr i64, ptr %v60, i64 5
  %v72 = load i64, ptr %v72.p
  %st67 = getelementptr i64, ptr %v12, i64 5
  store i64 %v72, ptr %st67
  %v73.p = getelementptr i64, ptr %v12, i64 0
  %v73 = load i64, ptr %v73.p
  %v74 = add i64 0, 0
  %v75.c = icmp ne i64 %v73, %v74
  %v75 = zext i1 %v75.c to i64
  %c.b8 = icmp ne i64 %v75, 0
  br i1 %c.b8, label %b8.t69, label %b8.e70
b8.t69:
  br label %b10
b8.e70:
  br label %b11
b9:
  br label %b12
b10:
  %v76 = add i64 0, 3
  %v77 = getelementptr i64, ptr %v12, i64 %v76
  %v584 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v77, i64 %v584, i64 %v13)
  br label %b11
b11:
  %v585 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v585, i64 0
  store i64 %v13, ptr %st70
  br label %b2
b12:
  %v78 = add i64 0, 41
  %v79 = add i64 0, 2
  %v80 = add i64 0, 526337
  %v81 = add i64 0, 0
  %v82 = add i64 0, 0
  %v83 = add i64 0, 0
  %v84 = add i64 0, 0
  %v85 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v78, i64 %v79, i64 %v80, i64 %v81, i64 %v82, i64 %v83, i64 %v84)
  %v86 = add i64 0, 0
  %v87.c = icmp slt i64 %v85, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b12 = icmp ne i64 %v87, 0
  br i1 %c.b12, label %b12.t72, label %b12.e73
b12.t72:
  br label %b13
b12.e73:
  br label %b14
b13:
  %v88 = getelementptr i64, ptr %s8, i64 0
  %v89 = add i64 0, 0
  %v90 = sub i64 %v89, %v85
  call void @"std/net.errOf"(ptr %v88, i64 %v90)
  %v91 = getelementptr i64, ptr %s5, i64 0
  %v92 = add i64 0, 1
  %st73 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st73
  %v93.p = getelementptr i64, ptr %v88, i64 0
  %v93 = load i64, ptr %v93.p
  %st74 = getelementptr i64, ptr %v91, i64 1
  store i64 %v93, ptr %st74
  %v94.p = getelementptr i64, ptr %v88, i64 1
  %v94 = load i64, ptr %v94.p
  %st75 = getelementptr i64, ptr %v91, i64 2
  store i64 %v94, ptr %st75
  %v95.p = getelementptr i64, ptr %v88, i64 2
  %v95 = load i64, ptr %v95.p
  %st76 = getelementptr i64, ptr %v91, i64 3
  store i64 %v95, ptr %st76
  %v96.p = getelementptr i64, ptr %v88, i64 3
  %v96 = load i64, ptr %v96.p
  %st77 = getelementptr i64, ptr %v91, i64 4
  store i64 %v96, ptr %st77
  %v97.p = getelementptr i64, ptr %v88, i64 4
  %v97 = load i64, ptr %v97.p
  %st78 = getelementptr i64, ptr %v91, i64 5
  store i64 %v97, ptr %st78
  %v98.p = getelementptr i64, ptr %v91, i64 0
  %v98 = load i64, ptr %v98.p
  %st79 = getelementptr i64, ptr %v12, i64 0
  store i64 %v98, ptr %st79
  %v99.p = getelementptr i64, ptr %v91, i64 1
  %v99 = load i64, ptr %v99.p
  %st80 = getelementptr i64, ptr %v12, i64 1
  store i64 %v99, ptr %st80
  %v100.p = getelementptr i64, ptr %v91, i64 2
  %v100 = load i64, ptr %v100.p
  %st81 = getelementptr i64, ptr %v12, i64 2
  store i64 %v100, ptr %st81
  %v101.p = getelementptr i64, ptr %v91, i64 3
  %v101 = load i64, ptr %v101.p
  %st82 = getelementptr i64, ptr %v12, i64 3
  store i64 %v101, ptr %st82
  %v102.p = getelementptr i64, ptr %v91, i64 4
  %v102 = load i64, ptr %v102.p
  %st83 = getelementptr i64, ptr %v12, i64 4
  store i64 %v102, ptr %st83
  %v103.p = getelementptr i64, ptr %v91, i64 5
  %v103 = load i64, ptr %v103.p
  %st84 = getelementptr i64, ptr %v12, i64 5
  store i64 %v103, ptr %st84
  %v104.p = getelementptr i64, ptr %v12, i64 0
  %v104 = load i64, ptr %v104.p
  %v105 = add i64 0, 0
  %v106.c = icmp ne i64 %v104, %v105
  %v106 = zext i1 %v106.c to i64
  %c.b13 = icmp ne i64 %v106, 0
  br i1 %c.b13, label %b13.t86, label %b13.e87
b13.t86:
  br label %b15
b13.e87:
  br label %b16
b14:
  br label %b17
b15:
  %v107 = add i64 0, 3
  %v108 = getelementptr i64, ptr %v12, i64 %v107
  %v586 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v108, i64 %v586, i64 %v13)
  br label %b16
b16:
  %v587 = getelementptr i64, ptr @"rt.meta", i64 0
  %st87 = getelementptr i64, ptr %v587, i64 0
  store i64 %v13, ptr %st87
  br label %b2
b17:
  %v109 = add i64 0, 1
  %v110 = add i64 0, 0
  %v111 = add i64 0, 0
  %v112 = add i64 0, 0
  %v588 = getelementptr i64, ptr @"rt.meta", i64 0
  %v113.p = getelementptr i64, ptr %v588, i64 0
  %v113 = load i64, ptr %v113.p
  %v114 = add i64 0, 4
  %v115 = call ptr @"rt.region_alloc8"(i64 %v113, i64 %v114)
  %v116 = add i64 0, 0
  %v117 = getelementptr i8, ptr %v115, i64 %v116
  %st88 = getelementptr i8, ptr %v117, i64 0
  %st88.b = trunc i64 %v109 to i8
  store i8 %st88.b, ptr %st88
  %v118 = add i64 0, 1
  %v119 = getelementptr i8, ptr %v115, i64 %v118
  %st89 = getelementptr i8, ptr %v119, i64 0
  %st89.b = trunc i64 %v110 to i8
  store i8 %st89.b, ptr %st89
  %v120 = add i64 0, 2
  %v121 = getelementptr i8, ptr %v115, i64 %v120
  %st90 = getelementptr i8, ptr %v121, i64 0
  %st90.b = trunc i64 %v111 to i8
  store i8 %st90.b, ptr %st90
  %v122 = add i64 0, 3
  %v123 = getelementptr i8, ptr %v115, i64 %v122
  %st91 = getelementptr i8, ptr %v123, i64 0
  %st91.b = trunc i64 %v112 to i8
  store i8 %st91.b, ptr %st91
  %v124 = add i64 0, 4
  %v125 = getelementptr i64, ptr %s9, i64 0
  %v126 = ptrtoint ptr %v115 to i64
  %st92 = getelementptr i64, ptr %v125, i64 0
  store i64 %v126, ptr %st92
  %st93 = getelementptr i64, ptr %v125, i64 1
  store i64 %v124, ptr %st93
  %st94 = getelementptr i64, ptr %v125, i64 2
  store i64 %v113, ptr %st94
  %v127 = getelementptr i64, ptr %s10, i64 0
  %v128.p = getelementptr i64, ptr %v125, i64 0
  %v128 = load i64, ptr %v128.p
  %st95 = getelementptr i64, ptr %v127, i64 0
  store i64 %v128, ptr %st95
  %v129.p = getelementptr i64, ptr %v125, i64 1
  %v129 = load i64, ptr %v129.p
  %st96 = getelementptr i64, ptr %v127, i64 1
  store i64 %v129, ptr %st96
  %v130.p = getelementptr i64, ptr %v125, i64 2
  %v130 = load i64, ptr %v130.p
  %st97 = getelementptr i64, ptr %v127, i64 2
  store i64 %v130, ptr %st97
  %v131 = add i64 0, 54
  %v132 = add i64 0, 1
  %v133 = add i64 0, 2
  %v134.p = getelementptr i64, ptr %v127, i64 0
  %v134 = load i64, ptr %v134.p
  %v135 = add i64 0, 4
  %v136 = add i64 0, 0
  %v137 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v131, i64 %v85, i64 %v132, i64 %v133, i64 %v134, i64 %v135, i64 %v136)
  %v138 = add i64 0, 0
  %v139.c = icmp slt i64 %v137, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b17 = icmp ne i64 %v139, 0
  br i1 %c.b17, label %b17.t99, label %b17.e100
b17.t99:
  br label %b18
b17.e100:
  br label %b19
b18:
  br label %b20
b19:
  %v140 = add i64 0, 49
  %v141.p = getelementptr i64, ptr %v46, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 0, 16
  %v143 = add i64 0, 0
  %v144 = add i64 0, 0
  %v145 = add i64 0, 0
  %v146 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v140, i64 %v85, i64 %v141, i64 %v142, i64 %v143, i64 %v144, i64 %v145)
  br label %b20
b20:
  %v147 = phi i64 [ %v137, %b18 ], [ %v146, %b19 ]
  %v148 = add i64 0, 0
  %v149.c = icmp slt i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b20 = icmp ne i64 %v149, 0
  br i1 %c.b20, label %b20.t101, label %b20.e102
b20.t101:
  br label %b21
b20.e102:
  br label %b22
b21:
  br label %b23
b22:
  %v150 = add i64 0, 50
  %v151 = add i64 0, 65535
  %v152 = add i64 0, 0
  %v153 = add i64 0, 0
  %v154 = add i64 0, 0
  %v155 = add i64 0, 0
  %v156 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v150, i64 %v85, i64 %v151, i64 %v152, i64 %v153, i64 %v154, i64 %v155)
  br label %b23
b23:
  %v157 = phi i64 [ %v147, %b21 ], [ %v156, %b22 ]
  %v158 = add i64 0, 0
  %v159.c = icmp slt i64 %v157, %v158
  %v159 = zext i1 %v159.c to i64
  %c.b23 = icmp ne i64 %v159, 0
  br i1 %c.b23, label %b23.t103, label %b23.e104
b23.t103:
  br label %b24
b23.e104:
  br label %b25
b24:
  %v160 = add i64 0, 3
  %v161 = add i64 0, 0
  %v162 = add i64 0, 0
  %v163 = add i64 0, 0
  %v164 = add i64 0, 0
  %v165 = add i64 0, 0
  %v166 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v160, i64 %v85, i64 %v161, i64 %v162, i64 %v163, i64 %v164, i64 %v165)
  %v167 = getelementptr i64, ptr %s11, i64 0
  %v168 = add i64 0, 0
  %v169 = sub i64 %v168, %v157
  call void @"std/net.errOf"(ptr %v167, i64 %v169)
  %v170 = getelementptr i64, ptr %s5, i64 0
  %v171 = add i64 0, 1
  %st104 = getelementptr i64, ptr %v170, i64 0
  store i64 %v171, ptr %st104
  %v172.p = getelementptr i64, ptr %v167, i64 0
  %v172 = load i64, ptr %v172.p
  %st105 = getelementptr i64, ptr %v170, i64 1
  store i64 %v172, ptr %st105
  %v173.p = getelementptr i64, ptr %v167, i64 1
  %v173 = load i64, ptr %v173.p
  %st106 = getelementptr i64, ptr %v170, i64 2
  store i64 %v173, ptr %st106
  %v174.p = getelementptr i64, ptr %v167, i64 2
  %v174 = load i64, ptr %v174.p
  %st107 = getelementptr i64, ptr %v170, i64 3
  store i64 %v174, ptr %st107
  %v175.p = getelementptr i64, ptr %v167, i64 3
  %v175 = load i64, ptr %v175.p
  %st108 = getelementptr i64, ptr %v170, i64 4
  store i64 %v175, ptr %st108
  %v176.p = getelementptr i64, ptr %v167, i64 4
  %v176 = load i64, ptr %v176.p
  %st109 = getelementptr i64, ptr %v170, i64 5
  store i64 %v176, ptr %st109
  %v177.p = getelementptr i64, ptr %v170, i64 0
  %v177 = load i64, ptr %v177.p
  %st110 = getelementptr i64, ptr %v12, i64 0
  store i64 %v177, ptr %st110
  %v178.p = getelementptr i64, ptr %v170, i64 1
  %v178 = load i64, ptr %v178.p
  %st111 = getelementptr i64, ptr %v12, i64 1
  store i64 %v178, ptr %st111
  %v179.p = getelementptr i64, ptr %v170, i64 2
  %v179 = load i64, ptr %v179.p
  %st112 = getelementptr i64, ptr %v12, i64 2
  store i64 %v179, ptr %st112
  %v180.p = getelementptr i64, ptr %v170, i64 3
  %v180 = load i64, ptr %v180.p
  %st113 = getelementptr i64, ptr %v12, i64 3
  store i64 %v180, ptr %st113
  %v181.p = getelementptr i64, ptr %v170, i64 4
  %v181 = load i64, ptr %v181.p
  %st114 = getelementptr i64, ptr %v12, i64 4
  store i64 %v181, ptr %st114
  %v182.p = getelementptr i64, ptr %v170, i64 5
  %v182 = load i64, ptr %v182.p
  %st115 = getelementptr i64, ptr %v12, i64 5
  store i64 %v182, ptr %st115
  %v183.p = getelementptr i64, ptr %v12, i64 0
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 0
  %v185.c = icmp ne i64 %v183, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b24 = icmp ne i64 %v185, 0
  br i1 %c.b24, label %b24.t117, label %b24.e118
b24.t117:
  br label %b26
b24.e118:
  br label %b27
b25:
  br label %b28
b26:
  %v186 = add i64 0, 3
  %v187 = getelementptr i64, ptr %v12, i64 %v186
  %v589 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v187, i64 %v589, i64 %v13)
  br label %b27
b27:
  %v590 = getelementptr i64, ptr @"rt.meta", i64 0
  %st118 = getelementptr i64, ptr %v590, i64 0
  store i64 %v13, ptr %st118
  br label %b2
b28:
  %v188 = getelementptr i64, ptr %s12, i64 0
  %v189 = add i64 0, 0
  %v190 = getelementptr i64, ptr %s13, i64 0
  %v191 = getelementptr i64, ptr %s14, i64 0
  %v192 = add i64 0, 0
  %st119 = getelementptr i64, ptr %v191, i64 0
  store i64 %v192, ptr %st119
  %st120 = getelementptr i64, ptr %v191, i64 0
  store i64 %v85, ptr %st120
  %v193 = getelementptr i64, ptr %s15, i64 0
  %v194.p = getelementptr i64, ptr %v191, i64 0
  %v194 = load i64, ptr %v194.p
  %st121 = getelementptr i64, ptr %v193, i64 0
  store i64 %v194, ptr %st121
  %v591 = getelementptr i64, ptr @"rt.meta", i64 0
  %v195.p = getelementptr i64, ptr %v591, i64 0
  %v195 = load i64, ptr %v195.p
  %v592 = getelementptr i64, ptr @"rt.meta", i64 0
  %v196.p = getelementptr i64, ptr %v592, i64 0
  %v196 = load i64, ptr %v196.p
  %v197.p = getelementptr i64, ptr %v193, i64 0
  %v197 = load i64, ptr %v197.p
  %v198 = call i64 @"std/net.Port"(i64 %v197)
  %v199 = getelementptr i64, ptr @"str.1", i64 0
  %v200 = add i64 0, 10
  %v201 = add i64 0, 0
  %v202 = getelementptr i64, ptr %s9, i64 0
  %v203 = ptrtoint ptr %v199 to i64
  %st122 = getelementptr i64, ptr %v202, i64 0
  store i64 %v203, ptr %st122
  %st123 = getelementptr i64, ptr %v202, i64 1
  store i64 %v200, ptr %st123
  %st124 = getelementptr i64, ptr %v202, i64 2
  store i64 %v201, ptr %st124
  %v204 = getelementptr i64, ptr %s16, i64 0
  call void @"std/convert.FormatInt"(ptr %v204, i64 %v198)
  %v205.p = getelementptr i64, ptr %v202, i64 1
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v204, i64 1
  %v206 = load i64, ptr %v206.p
  %v207 = add i64 %v205, %v206
  %v593 = getelementptr i64, ptr @"rt.meta", i64 0
  %v208.p = getelementptr i64, ptr %v593, i64 0
  %v208 = load i64, ptr %v208.p
  %v209.p = getelementptr i64, ptr %v202, i64 0
  %v209 = load i64, ptr %v209.p
  %v210.p = getelementptr i64, ptr %v202, i64 1
  %v210 = load i64, ptr %v210.p
  %v211.p = getelementptr i64, ptr %v202, i64 2
  %v211 = load i64, ptr %v211.p
  %v212 = call ptr @"rt.cat8"(i64 %v209, i64 %v210, i64 %v211, i64 %v208, i64 %v206)
  %v213 = getelementptr i8, ptr %v212, i64 %v205
  %v214.p = getelementptr i64, ptr %v204, i64 0
  %v214 = load i64, ptr %v214.p
  %v215 = inttoptr i64 %v214 to ptr
  call void @"rt.copy8"(ptr %v213, ptr %v215, i64 %v206)
  %v216 = getelementptr i64, ptr %s17, i64 0
  %v217 = ptrtoint ptr %v212 to i64
  %st125 = getelementptr i64, ptr %v216, i64 0
  store i64 %v217, ptr %st125
  %st126 = getelementptr i64, ptr %v216, i64 1
  store i64 %v207, ptr %st126
  %st127 = getelementptr i64, ptr %v216, i64 2
  store i64 %v208, ptr %st127
  %v218 = getelementptr i64, ptr %s18, i64 0
  %v219.p = getelementptr i64, ptr %v216, i64 0
  %v219 = load i64, ptr %v219.p
  %st128 = getelementptr i64, ptr %v218, i64 0
  store i64 %v219, ptr %st128
  %v220.p = getelementptr i64, ptr %v216, i64 1
  %v220 = load i64, ptr %v220.p
  %st129 = getelementptr i64, ptr %v218, i64 1
  store i64 %v220, ptr %st129
  %v221.p = getelementptr i64, ptr %v216, i64 2
  %v221 = load i64, ptr %v221.p
  %st130 = getelementptr i64, ptr %v218, i64 2
  store i64 %v221, ptr %st130
  %v222 = getelementptr i64, ptr %s5, i64 0
  %v594 = getelementptr i64, ptr @"rt.meta", i64 0
  %v223.p = getelementptr i64, ptr %v594, i64 0
  %v223 = load i64, ptr %v223.p
  %v224 = add i64 0, 0
  %v225 = add i64 0, 0
  %v226.c = icmp ne i64 %v224, %v225
  %v226 = zext i1 %v226.c to i64
  %c.b28 = icmp ne i64 %v226, 0
  br i1 %c.b28, label %b28.t132, label %b28.e133
b28.t132:
  br label %b32
b28.e133:
  br label %b33
b29:
  %v595 = getelementptr i64, ptr @"rt.meta", i64 0
  %st133 = getelementptr i64, ptr %v595, i64 0
  store i64 %v195, ptr %st133
  %v537 = getelementptr i64, ptr %s19, i64 0
  %v538 = add i64 0, 0
  %st134 = getelementptr i64, ptr %v537, i64 0
  store i64 %v538, ptr %st134
  %v539.p = getelementptr i64, ptr %v537, i64 0
  %v539 = load i64, ptr %v539.p
  %st135 = getelementptr i64, ptr %v12, i64 0
  store i64 %v539, ptr %st135
  %v540.p = getelementptr i64, ptr %v537, i64 1
  %v540 = load i64, ptr %v540.p
  %st136 = getelementptr i64, ptr %v12, i64 1
  store i64 %v540, ptr %st136
  %v541.p = getelementptr i64, ptr %v537, i64 2
  %v541 = load i64, ptr %v541.p
  %st137 = getelementptr i64, ptr %v12, i64 2
  store i64 %v541, ptr %st137
  %v542.p = getelementptr i64, ptr %v537, i64 3
  %v542 = load i64, ptr %v542.p
  %st138 = getelementptr i64, ptr %v12, i64 3
  store i64 %v542, ptr %st138
  %v543.p = getelementptr i64, ptr %v537, i64 4
  %v543 = load i64, ptr %v543.p
  %st139 = getelementptr i64, ptr %v12, i64 4
  store i64 %v543, ptr %st139
  %v544.p = getelementptr i64, ptr %v537, i64 5
  %v544 = load i64, ptr %v544.p
  %st140 = getelementptr i64, ptr %v12, i64 5
  store i64 %v544, ptr %st140
  call void @"std/net.closeFd"(i64 %v85)
  %v545.p = getelementptr i64, ptr %v12, i64 0
  %v545 = load i64, ptr %v545.p
  %v546 = add i64 0, 0
  %v547.c = icmp ne i64 %v545, %v546
  %v547 = zext i1 %v547.c to i64
  %c.b29 = icmp ne i64 %v547, 0
  br i1 %c.b29, label %b29.t142, label %b29.e143
b29.t142:
  br label %b79
b29.e143:
  br label %b80
b30:
  %v596 = getelementptr i64, ptr @"rt.meta", i64 0
  %st143 = getelementptr i64, ptr %v596, i64 0
  store i64 %v196, ptr %st143
  br label %b29
b31:
  %v522.p = getelementptr i64, ptr %v222, i64 0
  %v522 = load i64, ptr %v522.p
  %v523 = add i64 0, 0
  %v524.c = icmp ne i64 %v522, %v523
  %v524 = zext i1 %v524.c to i64
  %c.b31 = icmp ne i64 %v524, 0
  br i1 %c.b31, label %b31.t145, label %b31.e146
b31.t145:
  br label %b75
b31.e146:
  br label %b76
b32:
  %v227 = getelementptr i64, ptr %s3, i64 0
  %v228 = add i64 0, 0
  %st146 = getelementptr i64, ptr %v227, i64 0
  store i64 %v228, ptr %st146
  %st147 = getelementptr i64, ptr %v227, i64 1
  store i64 %v228, ptr %st147
  %v229 = add i64 0, 9
  %st148 = getelementptr i64, ptr %v227, i64 0
  store i64 %v229, ptr %st148
  %v230 = getelementptr i64, ptr %s4, i64 0
  %v231.p = getelementptr i64, ptr %v227, i64 0
  %v231 = load i64, ptr %v231.p
  %st149 = getelementptr i64, ptr %v230, i64 0
  store i64 %v231, ptr %st149
  %v232.p = getelementptr i64, ptr %v227, i64 1
  %v232 = load i64, ptr %v232.p
  %st150 = getelementptr i64, ptr %v230, i64 1
  store i64 %v232, ptr %st150
  %v233 = add i64 0, 0
  %st151 = getelementptr i64, ptr %v230, i64 2
  store i64 %v233, ptr %st151
  %st152 = getelementptr i64, ptr %v230, i64 3
  store i64 %v233, ptr %st152
  %st153 = getelementptr i64, ptr %v230, i64 4
  store i64 %v233, ptr %st153
  %v234 = getelementptr i64, ptr %s19, i64 0
  %v235 = add i64 0, 1
  %st154 = getelementptr i64, ptr %v234, i64 0
  store i64 %v235, ptr %st154
  %v236.p = getelementptr i64, ptr %v230, i64 0
  %v236 = load i64, ptr %v236.p
  %st155 = getelementptr i64, ptr %v234, i64 1
  store i64 %v236, ptr %st155
  %v237.p = getelementptr i64, ptr %v230, i64 1
  %v237 = load i64, ptr %v237.p
  %st156 = getelementptr i64, ptr %v234, i64 2
  store i64 %v237, ptr %st156
  %v238.p = getelementptr i64, ptr %v230, i64 2
  %v238 = load i64, ptr %v238.p
  %st157 = getelementptr i64, ptr %v234, i64 3
  store i64 %v238, ptr %st157
  %v239.p = getelementptr i64, ptr %v230, i64 3
  %v239 = load i64, ptr %v239.p
  %st158 = getelementptr i64, ptr %v234, i64 4
  store i64 %v239, ptr %st158
  %v240.p = getelementptr i64, ptr %v230, i64 4
  %v240 = load i64, ptr %v240.p
  %st159 = getelementptr i64, ptr %v234, i64 5
  store i64 %v240, ptr %st159
  %v241.p = getelementptr i64, ptr %v234, i64 0
  %v241 = load i64, ptr %v241.p
  %st160 = getelementptr i64, ptr %v222, i64 0
  store i64 %v241, ptr %st160
  %v242.p = getelementptr i64, ptr %v234, i64 1
  %v242 = load i64, ptr %v242.p
  %st161 = getelementptr i64, ptr %v222, i64 1
  store i64 %v242, ptr %st161
  %v243.p = getelementptr i64, ptr %v234, i64 2
  %v243 = load i64, ptr %v243.p
  %st162 = getelementptr i64, ptr %v222, i64 2
  store i64 %v243, ptr %st162
  %v244.p = getelementptr i64, ptr %v234, i64 3
  %v244 = load i64, ptr %v244.p
  %st163 = getelementptr i64, ptr %v222, i64 3
  store i64 %v244, ptr %st163
  %v245.p = getelementptr i64, ptr %v234, i64 4
  %v245 = load i64, ptr %v245.p
  %st164 = getelementptr i64, ptr %v222, i64 4
  store i64 %v245, ptr %st164
  %v246.p = getelementptr i64, ptr %v234, i64 5
  %v246 = load i64, ptr %v246.p
  %st165 = getelementptr i64, ptr %v222, i64 5
  store i64 %v246, ptr %st165
  %v247.p = getelementptr i64, ptr %v222, i64 0
  %v247 = load i64, ptr %v247.p
  %v248 = add i64 0, 0
  %v249.c = icmp ne i64 %v247, %v248
  %v249 = zext i1 %v249.c to i64
  %c.b32 = icmp ne i64 %v249, 0
  br i1 %c.b32, label %b32.t167, label %b32.e168
b32.t167:
  br label %b34
b32.e168:
  br label %b35
b33:
  br label %b36
b34:
  %v250 = add i64 0, 3
  %v251 = getelementptr i64, ptr %v222, i64 %v250
  %v597 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v251, i64 %v597, i64 %v223)
  br label %b35
b35:
  %v598 = getelementptr i64, ptr @"rt.meta", i64 0
  %st168 = getelementptr i64, ptr %v598, i64 0
  store i64 %v223, ptr %st168
  br label %b31
b36:
  %v252 = getelementptr i64, ptr %s20, i64 0
  %v253.p = getelementptr i64, ptr %v218, i64 0
  %v253 = load i64, ptr %v253.p
  %v254.p = getelementptr i64, ptr %v218, i64 1
  %v254 = load i64, ptr %v254.p
  %v255.p = getelementptr i64, ptr %v218, i64 2
  %v255 = load i64, ptr %v255.p
  call void @"std/net.sockaddr"(ptr %v252, i64 %v253, i64 %v254, i64 %v255)
  %v256 = getelementptr i64, ptr %s21, i64 0
  %v257.p = getelementptr i64, ptr %v252, i64 0
  %v257 = load i64, ptr %v257.p
  %st169 = getelementptr i64, ptr %v256, i64 0
  store i64 %v257, ptr %st169
  %v258.p = getelementptr i64, ptr %v252, i64 1
  %v258 = load i64, ptr %v258.p
  %st170 = getelementptr i64, ptr %v256, i64 1
  store i64 %v258, ptr %st170
  %v259.p = getelementptr i64, ptr %v252, i64 2
  %v259 = load i64, ptr %v259.p
  %st171 = getelementptr i64, ptr %v256, i64 2
  store i64 %v259, ptr %st171
  %v260.p = getelementptr i64, ptr %v256, i64 1
  %v260 = load i64, ptr %v260.p
  %v261 = add i64 0, 16
  %v262.c = icmp ne i64 %v260, %v261
  %v262 = zext i1 %v262.c to i64
  %c.b36 = icmp ne i64 %v262, 0
  br i1 %c.b36, label %b36.t173, label %b36.e174
b36.t173:
  br label %b37
b36.e174:
  br label %b38
b37:
  %v263 = getelementptr i64, ptr %s3, i64 0
  %v264 = add i64 0, 0
  %st174 = getelementptr i64, ptr %v263, i64 0
  store i64 %v264, ptr %st174
  %st175 = getelementptr i64, ptr %v263, i64 1
  store i64 %v264, ptr %st175
  %v265 = add i64 0, 0
  %st176 = getelementptr i64, ptr %v263, i64 0
  store i64 %v265, ptr %st176
  %v266 = getelementptr i64, ptr %s4, i64 0
  %v267.p = getelementptr i64, ptr %v263, i64 0
  %v267 = load i64, ptr %v267.p
  %st177 = getelementptr i64, ptr %v266, i64 0
  store i64 %v267, ptr %st177
  %v268.p = getelementptr i64, ptr %v263, i64 1
  %v268 = load i64, ptr %v268.p
  %st178 = getelementptr i64, ptr %v266, i64 1
  store i64 %v268, ptr %st178
  %v269 = add i64 0, 0
  %st179 = getelementptr i64, ptr %v266, i64 2
  store i64 %v269, ptr %st179
  %st180 = getelementptr i64, ptr %v266, i64 3
  store i64 %v269, ptr %st180
  %st181 = getelementptr i64, ptr %v266, i64 4
  store i64 %v269, ptr %st181
  %v270 = getelementptr i64, ptr %s19, i64 0
  %v271 = add i64 0, 1
  %st182 = getelementptr i64, ptr %v270, i64 0
  store i64 %v271, ptr %st182
  %v272.p = getelementptr i64, ptr %v266, i64 0
  %v272 = load i64, ptr %v272.p
  %st183 = getelementptr i64, ptr %v270, i64 1
  store i64 %v272, ptr %st183
  %v273.p = getelementptr i64, ptr %v266, i64 1
  %v273 = load i64, ptr %v273.p
  %st184 = getelementptr i64, ptr %v270, i64 2
  store i64 %v273, ptr %st184
  %v274.p = getelementptr i64, ptr %v266, i64 2
  %v274 = load i64, ptr %v274.p
  %st185 = getelementptr i64, ptr %v270, i64 3
  store i64 %v274, ptr %st185
  %v275.p = getelementptr i64, ptr %v266, i64 3
  %v275 = load i64, ptr %v275.p
  %st186 = getelementptr i64, ptr %v270, i64 4
  store i64 %v275, ptr %st186
  %v276.p = getelementptr i64, ptr %v266, i64 4
  %v276 = load i64, ptr %v276.p
  %st187 = getelementptr i64, ptr %v270, i64 5
  store i64 %v276, ptr %st187
  %v277.p = getelementptr i64, ptr %v270, i64 0
  %v277 = load i64, ptr %v277.p
  %st188 = getelementptr i64, ptr %v222, i64 0
  store i64 %v277, ptr %st188
  %v278.p = getelementptr i64, ptr %v270, i64 1
  %v278 = load i64, ptr %v278.p
  %st189 = getelementptr i64, ptr %v222, i64 1
  store i64 %v278, ptr %st189
  %v279.p = getelementptr i64, ptr %v270, i64 2
  %v279 = load i64, ptr %v279.p
  %st190 = getelementptr i64, ptr %v222, i64 2
  store i64 %v279, ptr %st190
  %v280.p = getelementptr i64, ptr %v270, i64 3
  %v280 = load i64, ptr %v280.p
  %st191 = getelementptr i64, ptr %v222, i64 3
  store i64 %v280, ptr %st191
  %v281.p = getelementptr i64, ptr %v270, i64 4
  %v281 = load i64, ptr %v281.p
  %st192 = getelementptr i64, ptr %v222, i64 4
  store i64 %v281, ptr %st192
  %v282.p = getelementptr i64, ptr %v270, i64 5
  %v282 = load i64, ptr %v282.p
  %st193 = getelementptr i64, ptr %v222, i64 5
  store i64 %v282, ptr %st193
  %v283.p = getelementptr i64, ptr %v222, i64 0
  %v283 = load i64, ptr %v283.p
  %v284 = add i64 0, 0
  %v285.c = icmp ne i64 %v283, %v284
  %v285 = zext i1 %v285.c to i64
  %c.b37 = icmp ne i64 %v285, 0
  br i1 %c.b37, label %b37.t195, label %b37.e196
b37.t195:
  br label %b39
b37.e196:
  br label %b40
b38:
  br label %b41
b39:
  %v286 = add i64 0, 3
  %v287 = getelementptr i64, ptr %v222, i64 %v286
  %v599 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v287, i64 %v599, i64 %v223)
  br label %b40
b40:
  %v600 = getelementptr i64, ptr @"rt.meta", i64 0
  %st196 = getelementptr i64, ptr %v600, i64 0
  store i64 %v223, ptr %st196
  br label %b31
b41:
  %v288 = add i64 0, 41
  %v289 = add i64 0, 2
  %v290 = add i64 0, 526337
  %v291 = add i64 0, 0
  %v292 = add i64 0, 0
  %v293 = add i64 0, 0
  %v294 = add i64 0, 0
  %v295 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v288, i64 %v289, i64 %v290, i64 %v291, i64 %v292, i64 %v293, i64 %v294)
  %v296 = add i64 0, 0
  %v297.c = icmp slt i64 %v295, %v296
  %v297 = zext i1 %v297.c to i64
  %c.b41 = icmp ne i64 %v297, 0
  br i1 %c.b41, label %b41.t198, label %b41.e199
b41.t198:
  br label %b42
b41.e199:
  br label %b43
b42:
  %v298 = getelementptr i64, ptr %s22, i64 0
  %v299 = add i64 0, 0
  %v300 = sub i64 %v299, %v295
  call void @"std/net.errOf"(ptr %v298, i64 %v300)
  %v301 = getelementptr i64, ptr %s19, i64 0
  %v302 = add i64 0, 1
  %st199 = getelementptr i64, ptr %v301, i64 0
  store i64 %v302, ptr %st199
  %v303.p = getelementptr i64, ptr %v298, i64 0
  %v303 = load i64, ptr %v303.p
  %st200 = getelementptr i64, ptr %v301, i64 1
  store i64 %v303, ptr %st200
  %v304.p = getelementptr i64, ptr %v298, i64 1
  %v304 = load i64, ptr %v304.p
  %st201 = getelementptr i64, ptr %v301, i64 2
  store i64 %v304, ptr %st201
  %v305.p = getelementptr i64, ptr %v298, i64 2
  %v305 = load i64, ptr %v305.p
  %st202 = getelementptr i64, ptr %v301, i64 3
  store i64 %v305, ptr %st202
  %v306.p = getelementptr i64, ptr %v298, i64 3
  %v306 = load i64, ptr %v306.p
  %st203 = getelementptr i64, ptr %v301, i64 4
  store i64 %v306, ptr %st203
  %v307.p = getelementptr i64, ptr %v298, i64 4
  %v307 = load i64, ptr %v307.p
  %st204 = getelementptr i64, ptr %v301, i64 5
  store i64 %v307, ptr %st204
  %v308.p = getelementptr i64, ptr %v301, i64 0
  %v308 = load i64, ptr %v308.p
  %st205 = getelementptr i64, ptr %v222, i64 0
  store i64 %v308, ptr %st205
  %v309.p = getelementptr i64, ptr %v301, i64 1
  %v309 = load i64, ptr %v309.p
  %st206 = getelementptr i64, ptr %v222, i64 1
  store i64 %v309, ptr %st206
  %v310.p = getelementptr i64, ptr %v301, i64 2
  %v310 = load i64, ptr %v310.p
  %st207 = getelementptr i64, ptr %v222, i64 2
  store i64 %v310, ptr %st207
  %v311.p = getelementptr i64, ptr %v301, i64 3
  %v311 = load i64, ptr %v311.p
  %st208 = getelementptr i64, ptr %v222, i64 3
  store i64 %v311, ptr %st208
  %v312.p = getelementptr i64, ptr %v301, i64 4
  %v312 = load i64, ptr %v312.p
  %st209 = getelementptr i64, ptr %v222, i64 4
  store i64 %v312, ptr %st209
  %v313.p = getelementptr i64, ptr %v301, i64 5
  %v313 = load i64, ptr %v313.p
  %st210 = getelementptr i64, ptr %v222, i64 5
  store i64 %v313, ptr %st210
  %v314.p = getelementptr i64, ptr %v222, i64 0
  %v314 = load i64, ptr %v314.p
  %v315 = add i64 0, 0
  %v316.c = icmp ne i64 %v314, %v315
  %v316 = zext i1 %v316.c to i64
  %c.b42 = icmp ne i64 %v316, 0
  br i1 %c.b42, label %b42.t212, label %b42.e213
b42.t212:
  br label %b44
b42.e213:
  br label %b45
b43:
  br label %b46
b44:
  %v317 = add i64 0, 3
  %v318 = getelementptr i64, ptr %v222, i64 %v317
  %v601 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v318, i64 %v601, i64 %v223)
  br label %b45
b45:
  %v602 = getelementptr i64, ptr @"rt.meta", i64 0
  %st213 = getelementptr i64, ptr %v602, i64 0
  store i64 %v223, ptr %st213
  br label %b31
b46:
  %v319 = add i64 0, 42
  %v320.p = getelementptr i64, ptr %v256, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = add i64 0, 16
  %v322 = add i64 0, 0
  %v323 = add i64 0, 0
  %v324 = add i64 0, 0
  %v325 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v319, i64 %v295, i64 %v320, i64 %v321, i64 %v322, i64 %v323, i64 %v324)
  %v326 = getelementptr i64, ptr %s23, i64 0
  %st214 = getelementptr i64, ptr %v326, i64 0
  store i64 %v325, ptr %st214
  %v327.p = getelementptr i64, ptr %v326, i64 0
  %v327 = load i64, ptr %v327.p
  %v328 = add i64 0, 4
  %v329 = call i64 @"std/net.again"(i64 %v327, i64 %v295, i64 %v328)
  %v330 = add i64 0, 0
  %v331.c = icmp slt i64 %v329, %v330
  %v331 = zext i1 %v331.c to i64
  %c.b46 = icmp ne i64 %v331, 0
  br i1 %c.b46, label %b46.t216, label %b46.e217
b46.t216:
  br label %b47
b46.e217:
  br label %b48
b47:
  %v332 = add i64 0, 3
  %v333 = add i64 0, 0
  %v334 = add i64 0, 0
  %v335 = add i64 0, 0
  %v336 = add i64 0, 0
  %v337 = add i64 0, 0
  %v338 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v332, i64 %v295, i64 %v333, i64 %v334, i64 %v335, i64 %v336, i64 %v337)
  %v339 = getelementptr i64, ptr %s24, i64 0
  call void @"std/net.waitErr"(ptr %v339, i64 %v329)
  %v340 = getelementptr i64, ptr %s19, i64 0
  %v341 = add i64 0, 1
  %st217 = getelementptr i64, ptr %v340, i64 0
  store i64 %v341, ptr %st217
  %v342.p = getelementptr i64, ptr %v339, i64 0
  %v342 = load i64, ptr %v342.p
  %st218 = getelementptr i64, ptr %v340, i64 1
  store i64 %v342, ptr %st218
  %v343.p = getelementptr i64, ptr %v339, i64 1
  %v343 = load i64, ptr %v343.p
  %st219 = getelementptr i64, ptr %v340, i64 2
  store i64 %v343, ptr %st219
  %v344.p = getelementptr i64, ptr %v339, i64 2
  %v344 = load i64, ptr %v344.p
  %st220 = getelementptr i64, ptr %v340, i64 3
  store i64 %v344, ptr %st220
  %v345.p = getelementptr i64, ptr %v339, i64 3
  %v345 = load i64, ptr %v345.p
  %st221 = getelementptr i64, ptr %v340, i64 4
  store i64 %v345, ptr %st221
  %v346.p = getelementptr i64, ptr %v339, i64 4
  %v346 = load i64, ptr %v346.p
  %st222 = getelementptr i64, ptr %v340, i64 5
  store i64 %v346, ptr %st222
  %v347.p = getelementptr i64, ptr %v340, i64 0
  %v347 = load i64, ptr %v347.p
  %st223 = getelementptr i64, ptr %v222, i64 0
  store i64 %v347, ptr %st223
  %v348.p = getelementptr i64, ptr %v340, i64 1
  %v348 = load i64, ptr %v348.p
  %st224 = getelementptr i64, ptr %v222, i64 1
  store i64 %v348, ptr %st224
  %v349.p = getelementptr i64, ptr %v340, i64 2
  %v349 = load i64, ptr %v349.p
  %st225 = getelementptr i64, ptr %v222, i64 2
  store i64 %v349, ptr %st225
  %v350.p = getelementptr i64, ptr %v340, i64 3
  %v350 = load i64, ptr %v350.p
  %st226 = getelementptr i64, ptr %v222, i64 3
  store i64 %v350, ptr %st226
  %v351.p = getelementptr i64, ptr %v340, i64 4
  %v351 = load i64, ptr %v351.p
  %st227 = getelementptr i64, ptr %v222, i64 4
  store i64 %v351, ptr %st227
  %v352.p = getelementptr i64, ptr %v340, i64 5
  %v352 = load i64, ptr %v352.p
  %st228 = getelementptr i64, ptr %v222, i64 5
  store i64 %v352, ptr %st228
  %v353.p = getelementptr i64, ptr %v222, i64 0
  %v353 = load i64, ptr %v353.p
  %v354 = add i64 0, 0
  %v355.c = icmp ne i64 %v353, %v354
  %v355 = zext i1 %v355.c to i64
  %c.b47 = icmp ne i64 %v355, 0
  br i1 %c.b47, label %b47.t230, label %b47.e231
b47.t230:
  br label %b49
b47.e231:
  br label %b50
b48:
  %v358 = add i64 0, 0
  %v359.c = icmp eq i64 %v329, %v358
  %v359 = zext i1 %v359.c to i64
  %c.b48 = icmp ne i64 %v359, 0
  br i1 %c.b48, label %b48.t232, label %b48.e233
b48.t232:
  br label %b51
b48.e233:
  br label %b52
b49:
  %v356 = add i64 0, 3
  %v357 = getelementptr i64, ptr %v222, i64 %v356
  %v603 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v357, i64 %v603, i64 %v223)
  br label %b50
b50:
  %v604 = getelementptr i64, ptr @"rt.meta", i64 0
  %st233 = getelementptr i64, ptr %v604, i64 0
  store i64 %v223, ptr %st233
  br label %b31
b51:
  %v360 = add i64 0, 0
  %v361 = add i64 0, 0
  %v362 = add i64 0, 0
  %v363 = add i64 0, 0
  %v605 = getelementptr i64, ptr @"rt.meta", i64 0
  %v364.p = getelementptr i64, ptr %v605, i64 0
  %v364 = load i64, ptr %v364.p
  %v365 = add i64 0, 4
  %v366 = call ptr @"rt.region_alloc8"(i64 %v364, i64 %v365)
  %v367 = add i64 0, 0
  %v368 = getelementptr i8, ptr %v366, i64 %v367
  %st234 = getelementptr i8, ptr %v368, i64 0
  %st234.b = trunc i64 %v360 to i8
  store i8 %st234.b, ptr %st234
  %v369 = add i64 0, 1
  %v370 = getelementptr i8, ptr %v366, i64 %v369
  %st235 = getelementptr i8, ptr %v370, i64 0
  %st235.b = trunc i64 %v361 to i8
  store i8 %st235.b, ptr %st235
  %v371 = add i64 0, 2
  %v372 = getelementptr i8, ptr %v366, i64 %v371
  %st236 = getelementptr i8, ptr %v372, i64 0
  %st236.b = trunc i64 %v362 to i8
  store i8 %st236.b, ptr %st236
  %v373 = add i64 0, 3
  %v374 = getelementptr i8, ptr %v366, i64 %v373
  %st237 = getelementptr i8, ptr %v374, i64 0
  %st237.b = trunc i64 %v363 to i8
  store i8 %st237.b, ptr %st237
  %v375 = add i64 0, 4
  %v376 = getelementptr i64, ptr %s25, i64 0
  %v377 = ptrtoint ptr %v366 to i64
  %st238 = getelementptr i64, ptr %v376, i64 0
  store i64 %v377, ptr %st238
  %st239 = getelementptr i64, ptr %v376, i64 1
  store i64 %v375, ptr %st239
  %st240 = getelementptr i64, ptr %v376, i64 2
  store i64 %v364, ptr %st240
  %v378 = getelementptr i64, ptr %s26, i64 0
  %v379.p = getelementptr i64, ptr %v376, i64 0
  %v379 = load i64, ptr %v379.p
  %st241 = getelementptr i64, ptr %v378, i64 0
  store i64 %v379, ptr %st241
  %v380.p = getelementptr i64, ptr %v376, i64 1
  %v380 = load i64, ptr %v380.p
  %st242 = getelementptr i64, ptr %v378, i64 1
  store i64 %v380, ptr %st242
  %v381.p = getelementptr i64, ptr %v376, i64 2
  %v381 = load i64, ptr %v381.p
  %st243 = getelementptr i64, ptr %v378, i64 2
  store i64 %v381, ptr %st243
  %v382 = add i64 0, 4
  %v383 = add i64 0, 0
  %v384 = add i64 0, 0
  %v385 = add i64 0, 0
  %v606 = getelementptr i64, ptr @"rt.meta", i64 0
  %v386.p = getelementptr i64, ptr %v606, i64 0
  %v386 = load i64, ptr %v386.p
  %v387 = add i64 0, 4
  %v388 = call ptr @"rt.region_alloc8"(i64 %v386, i64 %v387)
  %v389 = add i64 0, 0
  %v390 = getelementptr i8, ptr %v388, i64 %v389
  %st244 = getelementptr i8, ptr %v390, i64 0
  %st244.b = trunc i64 %v382 to i8
  store i8 %st244.b, ptr %st244
  %v391 = add i64 0, 1
  %v392 = getelementptr i8, ptr %v388, i64 %v391
  %st245 = getelementptr i8, ptr %v392, i64 0
  %st245.b = trunc i64 %v383 to i8
  store i8 %st245.b, ptr %st245
  %v393 = add i64 0, 2
  %v394 = getelementptr i8, ptr %v388, i64 %v393
  %st246 = getelementptr i8, ptr %v394, i64 0
  %st246.b = trunc i64 %v384 to i8
  store i8 %st246.b, ptr %st246
  %v395 = add i64 0, 3
  %v396 = getelementptr i8, ptr %v388, i64 %v395
  %st247 = getelementptr i8, ptr %v396, i64 0
  %st247.b = trunc i64 %v385 to i8
  store i8 %st247.b, ptr %st247
  %v397 = add i64 0, 4
  %v398 = getelementptr i64, ptr %s25, i64 0
  %v399 = ptrtoint ptr %v388 to i64
  %st248 = getelementptr i64, ptr %v398, i64 0
  store i64 %v399, ptr %st248
  %st249 = getelementptr i64, ptr %v398, i64 1
  store i64 %v397, ptr %st249
  %st250 = getelementptr i64, ptr %v398, i64 2
  store i64 %v386, ptr %st250
  %v400 = getelementptr i64, ptr %s27, i64 0
  %v401.p = getelementptr i64, ptr %v398, i64 0
  %v401 = load i64, ptr %v401.p
  %st251 = getelementptr i64, ptr %v400, i64 0
  store i64 %v401, ptr %st251
  %v402.p = getelementptr i64, ptr %v398, i64 1
  %v402 = load i64, ptr %v402.p
  %st252 = getelementptr i64, ptr %v400, i64 1
  store i64 %v402, ptr %st252
  %v403.p = getelementptr i64, ptr %v398, i64 2
  %v403 = load i64, ptr %v403.p
  %st253 = getelementptr i64, ptr %v400, i64 2
  store i64 %v403, ptr %st253
  %v404 = add i64 0, 55
  %v405 = add i64 0, 1
  %v406 = add i64 0, 4
  %v407.p = getelementptr i64, ptr %v378, i64 0
  %v407 = load i64, ptr %v407.p
  %v408.p = getelementptr i64, ptr %v400, i64 0
  %v408 = load i64, ptr %v408.p
  %v409 = add i64 0, 0
  %v410 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v404, i64 %v295, i64 %v405, i64 %v406, i64 %v407, i64 %v408, i64 %v409)
  %v411 = add i64 0, 0
  %v412.c = icmp slt i64 %v410, %v411
  %v412 = zext i1 %v412.c to i64
  %c.b51 = icmp ne i64 %v412, 0
  br i1 %c.b51, label %b51.t255, label %b51.e256
b51.t255:
  br label %b53
b51.e256:
  br label %b54
b52:
  br label %b60
b53:
  br label %b59
b54:
  %v413 = add i64 0, 0
  %v414 = add i64 0, 0
  %v415.p = getelementptr i64, ptr %v378, i64 1
  %v415 = load i64, ptr %v415.p
  %v416.c = icmp uge i64 %v414, %v415
  %v416 = zext i1 %v416.c to i64
  %c.b54 = icmp ne i64 %v416, 0
  br i1 %c.b54, label %b54.t257, label %b54.e258
b54.t257:
  br label %b55
b54.e258:
  br label %b56
b55:
  %v417 = add i64 0, 0
  call void @"rt.panic"(i64 %v417)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b56:
  %v418.p = getelementptr i64, ptr %v378, i64 0
  %v418 = load i64, ptr %v418.p
  %v419 = inttoptr i64 %v418 to ptr
  %v420 = getelementptr i8, ptr %v419, i64 %v414
  %v421.p = getelementptr i8, ptr %v420, i64 0
  %v421.b = load i8, ptr %v421.p
  %v421 = zext i8 %v421.b to i64
  %v422 = add i64 0, 1
  %v423.p = getelementptr i64, ptr %v378, i64 1
  %v423 = load i64, ptr %v423.p
  %v424.c = icmp uge i64 %v422, %v423
  %v424 = zext i1 %v424.c to i64
  %c.b56 = icmp ne i64 %v424, 0
  br i1 %c.b56, label %b56.t259, label %b56.e260
b56.t259:
  br label %b57
b56.e260:
  br label %b58
b57:
  %v425 = add i64 0, 1
  call void @"rt.panic"(i64 %v425)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b58:
  %v426.p = getelementptr i64, ptr %v378, i64 0
  %v426 = load i64, ptr %v426.p
  %v427 = inttoptr i64 %v426 to ptr
  %v428 = getelementptr i8, ptr %v427, i64 %v422
  %v429.p = getelementptr i8, ptr %v428, i64 0
  %v429.b = load i8, ptr %v429.p
  %v429 = zext i8 %v429.b to i64
  %v430 = add i64 0, 256
  %v431 = mul i64 %v429, %v430
  %v432 = add i64 %v421, %v431
  %v433 = sub i64 %v413, %v432
  br label %b59
b59:
  %v434 = phi i64 [ %v410, %b53 ], [ %v433, %b58 ]
  %st260 = getelementptr i64, ptr %v326, i64 0
  store i64 %v434, ptr %st260
  br label %b60
b60:
  br label %b61
b61:
  %v435.p = getelementptr i64, ptr %v326, i64 0
  %v435 = load i64, ptr %v435.p
  %v436 = add i64 0, 0
  %v437.c = icmp slt i64 %v435, %v436
  %v437 = zext i1 %v437.c to i64
  %c.b61 = icmp ne i64 %v437, 0
  br i1 %c.b61, label %b61.t262, label %b61.e263
b61.t262:
  br label %b62
b61.e263:
  br label %b63
b62:
  %v438 = add i64 0, 3
  %v439 = add i64 0, 0
  %v440 = add i64 0, 0
  %v441 = add i64 0, 0
  %v442 = add i64 0, 0
  %v443 = add i64 0, 0
  %v444 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v438, i64 %v295, i64 %v439, i64 %v440, i64 %v441, i64 %v442, i64 %v443)
  %v445 = getelementptr i64, ptr %s28, i64 0
  %v446 = add i64 0, 0
  %v447.p = getelementptr i64, ptr %v326, i64 0
  %v447 = load i64, ptr %v447.p
  %v448 = sub i64 %v446, %v447
  call void @"std/net.errOf"(ptr %v445, i64 %v448)
  %v449 = getelementptr i64, ptr %s19, i64 0
  %v450 = add i64 0, 1
  %st263 = getelementptr i64, ptr %v449, i64 0
  store i64 %v450, ptr %st263
  %v451.p = getelementptr i64, ptr %v445, i64 0
  %v451 = load i64, ptr %v451.p
  %st264 = getelementptr i64, ptr %v449, i64 1
  store i64 %v451, ptr %st264
  %v452.p = getelementptr i64, ptr %v445, i64 1
  %v452 = load i64, ptr %v452.p
  %st265 = getelementptr i64, ptr %v449, i64 2
  store i64 %v452, ptr %st265
  %v453.p = getelementptr i64, ptr %v445, i64 2
  %v453 = load i64, ptr %v453.p
  %st266 = getelementptr i64, ptr %v449, i64 3
  store i64 %v453, ptr %st266
  %v454.p = getelementptr i64, ptr %v445, i64 3
  %v454 = load i64, ptr %v454.p
  %st267 = getelementptr i64, ptr %v449, i64 4
  store i64 %v454, ptr %st267
  %v455.p = getelementptr i64, ptr %v445, i64 4
  %v455 = load i64, ptr %v455.p
  %st268 = getelementptr i64, ptr %v449, i64 5
  store i64 %v455, ptr %st268
  %v456.p = getelementptr i64, ptr %v449, i64 0
  %v456 = load i64, ptr %v456.p
  %st269 = getelementptr i64, ptr %v222, i64 0
  store i64 %v456, ptr %st269
  %v457.p = getelementptr i64, ptr %v449, i64 1
  %v457 = load i64, ptr %v457.p
  %st270 = getelementptr i64, ptr %v222, i64 1
  store i64 %v457, ptr %st270
  %v458.p = getelementptr i64, ptr %v449, i64 2
  %v458 = load i64, ptr %v458.p
  %st271 = getelementptr i64, ptr %v222, i64 2
  store i64 %v458, ptr %st271
  %v459.p = getelementptr i64, ptr %v449, i64 3
  %v459 = load i64, ptr %v459.p
  %st272 = getelementptr i64, ptr %v222, i64 3
  store i64 %v459, ptr %st272
  %v460.p = getelementptr i64, ptr %v449, i64 4
  %v460 = load i64, ptr %v460.p
  %st273 = getelementptr i64, ptr %v222, i64 4
  store i64 %v460, ptr %st273
  %v461.p = getelementptr i64, ptr %v449, i64 5
  %v461 = load i64, ptr %v461.p
  %st274 = getelementptr i64, ptr %v222, i64 5
  store i64 %v461, ptr %st274
  %v462.p = getelementptr i64, ptr %v222, i64 0
  %v462 = load i64, ptr %v462.p
  %v463 = add i64 0, 0
  %v464.c = icmp ne i64 %v462, %v463
  %v464 = zext i1 %v464.c to i64
  %c.b62 = icmp ne i64 %v464, 0
  br i1 %c.b62, label %b62.t276, label %b62.e277
b62.t276:
  br label %b64
b62.e277:
  br label %b65
b63:
  br label %b66
b64:
  %v465 = add i64 0, 3
  %v466 = getelementptr i64, ptr %v222, i64 %v465
  %v607 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v466, i64 %v607, i64 %v223)
  br label %b65
b65:
  %v608 = getelementptr i64, ptr @"rt.meta", i64 0
  %st277 = getelementptr i64, ptr %v608, i64 0
  store i64 %v223, ptr %st277
  br label %b31
b66:
  %v467 = getelementptr i64, ptr %s29, i64 0
  %v609 = getelementptr i64, ptr @"rt.meta", i64 0
  %v468.p = getelementptr i64, ptr %v609, i64 0
  %v468 = load i64, ptr %v468.p
  %v469 = getelementptr i64, ptr %s30, i64 0
  %v470 = add i64 0, 0
  %v471 = getelementptr i64, ptr %s31, i64 0
  %v472 = getelementptr i64, ptr %s32, i64 0
  %v473 = add i64 0, 0
  %st278 = getelementptr i64, ptr %v472, i64 0
  store i64 %v473, ptr %st278
  %st279 = getelementptr i64, ptr %v472, i64 0
  store i64 %v295, ptr %st279
  %v474 = getelementptr i64, ptr %s33, i64 0
  %v475.p = getelementptr i64, ptr %v472, i64 0
  %v475 = load i64, ptr %v475.p
  %st280 = getelementptr i64, ptr %v474, i64 0
  store i64 %v475, ptr %st280
  %v610 = getelementptr i64, ptr @"rt.meta", i64 0
  %v476.p = getelementptr i64, ptr %v610, i64 0
  %v476 = load i64, ptr %v476.p
  %v477 = getelementptr i64, ptr %s34, i64 0
  %v478.p = getelementptr i64, ptr %v474, i64 0
  %v478 = load i64, ptr %v478.p
  %v479 = getelementptr i64, ptr %s35, i64 0
  %v480 = getelementptr i64, ptr @"str.2", i64 0
  %v481 = add i64 0, 4
  %v482 = add i64 0, 0
  %v483 = getelementptr i64, ptr %s27, i64 0
  %v484 = ptrtoint ptr %v480 to i64
  %st281 = getelementptr i64, ptr %v483, i64 0
  store i64 %v484, ptr %st281
  %st282 = getelementptr i64, ptr %v483, i64 1
  store i64 %v481, ptr %st282
  %st283 = getelementptr i64, ptr %v483, i64 2
  store i64 %v482, ptr %st283
  %v485.p = getelementptr i64, ptr %v483, i64 0
  %v485 = load i64, ptr %v485.p
  %v486.p = getelementptr i64, ptr %v483, i64 1
  %v486 = load i64, ptr %v486.p
  %v487.p = getelementptr i64, ptr %v483, i64 2
  %v487 = load i64, ptr %v487.p
  call void @"main.handle"(ptr %v479, i64 %v485, i64 %v486, i64 %v487)
  %v488.p = getelementptr i64, ptr %v479, i64 0
  %v488 = load i64, ptr %v488.p
  %v489.p = getelementptr i64, ptr %v479, i64 1
  %v489 = load i64, ptr %v489.p
  %v490.p = getelementptr i64, ptr %v479, i64 2
  %v490 = load i64, ptr %v490.p
  %v491.p = getelementptr i64, ptr %v479, i64 3
  %v491 = load i64, ptr %v491.p
  %v492.p = getelementptr i64, ptr %v479, i64 4
  %v492 = load i64, ptr %v492.p
  %v493.p = getelementptr i64, ptr %v479, i64 5
  %v493 = load i64, ptr %v493.p
  call void @"main.serve"(ptr %v477, i64 %v478, i64 %v488, i64 %v489, i64 %v490, i64 %v491, i64 %v492, i64 %v493)
  %v494.p = getelementptr i64, ptr %v477, i64 0
  %v494 = load i64, ptr %v494.p
  %v495 = add i64 0, 0
  %v496.c = icmp ne i64 %v494, %v495
  %v496 = zext i1 %v496.c to i64
  %c.b66 = icmp ne i64 %v496, 0
  br i1 %c.b66, label %b66.t285, label %b66.e286
b66.t285:
  br label %b69
b66.e286:
  br label %b70
b67:
  %v509 = getelementptr i64, ptr %s19, i64 0
  %v510 = add i64 0, 0
  %st286 = getelementptr i64, ptr %v509, i64 0
  store i64 %v510, ptr %st286
  %v511.p = getelementptr i64, ptr %v509, i64 0
  %v511 = load i64, ptr %v511.p
  %st287 = getelementptr i64, ptr %v222, i64 0
  store i64 %v511, ptr %st287
  %v512.p = getelementptr i64, ptr %v509, i64 1
  %v512 = load i64, ptr %v512.p
  %st288 = getelementptr i64, ptr %v222, i64 1
  store i64 %v512, ptr %st288
  %v513.p = getelementptr i64, ptr %v509, i64 2
  %v513 = load i64, ptr %v513.p
  %st289 = getelementptr i64, ptr %v222, i64 2
  store i64 %v513, ptr %st289
  %v514.p = getelementptr i64, ptr %v509, i64 3
  %v514 = load i64, ptr %v514.p
  %st290 = getelementptr i64, ptr %v222, i64 3
  store i64 %v514, ptr %st290
  %v515.p = getelementptr i64, ptr %v509, i64 4
  %v515 = load i64, ptr %v515.p
  %st291 = getelementptr i64, ptr %v222, i64 4
  store i64 %v515, ptr %st291
  %v516.p = getelementptr i64, ptr %v509, i64 5
  %v516 = load i64, ptr %v516.p
  %st292 = getelementptr i64, ptr %v222, i64 5
  store i64 %v516, ptr %st292
  %v517.p = getelementptr i64, ptr %v222, i64 0
  %v517 = load i64, ptr %v517.p
  %v518 = add i64 0, 0
  %v519.c = icmp ne i64 %v517, %v518
  %v519 = zext i1 %v519.c to i64
  %c.b67 = icmp ne i64 %v519, 0
  br i1 %c.b67, label %b67.t294, label %b67.e295
b67.t294:
  br label %b73
b67.e295:
  br label %b74
b68:
  %v611 = getelementptr i64, ptr @"rt.meta", i64 0
  %st295 = getelementptr i64, ptr %v611, i64 0
  store i64 %v476, ptr %st295
  call void @"std/net.closeFd"(i64 %v295)
  br label %b67
b69:
  %v497 = add i64 0, 0
  %v498.p = getelementptr i64, ptr %v477, i64 0
  %v498 = load i64, ptr %v498.p
  %st296 = getelementptr i64, ptr %v0, i64 0
  store i64 %v498, ptr %st296
  %v499.p = getelementptr i64, ptr %v477, i64 1
  %v499 = load i64, ptr %v499.p
  %st297 = getelementptr i64, ptr %v0, i64 1
  store i64 %v499, ptr %st297
  %v500.p = getelementptr i64, ptr %v477, i64 2
  %v500 = load i64, ptr %v500.p
  %st298 = getelementptr i64, ptr %v0, i64 2
  store i64 %v500, ptr %st298
  %v501.p = getelementptr i64, ptr %v477, i64 3
  %v501 = load i64, ptr %v501.p
  %st299 = getelementptr i64, ptr %v0, i64 3
  store i64 %v501, ptr %st299
  %v502.p = getelementptr i64, ptr %v477, i64 4
  %v502 = load i64, ptr %v502.p
  %st300 = getelementptr i64, ptr %v0, i64 4
  store i64 %v502, ptr %st300
  %v503.p = getelementptr i64, ptr %v477, i64 5
  %v503 = load i64, ptr %v503.p
  %st301 = getelementptr i64, ptr %v0, i64 5
  store i64 %v503, ptr %st301
  call void @"std/net.closeFd"(i64 %v295)
  call void @"std/net.closeFd"(i64 %v85)
  %v504.p = getelementptr i64, ptr %v0, i64 0
  %v504 = load i64, ptr %v504.p
  %v505 = add i64 0, 0
  %v506.c = icmp ne i64 %v504, %v505
  %v506 = zext i1 %v506.c to i64
  %c.b69 = icmp ne i64 %v506, 0
  br i1 %c.b69, label %b69.t303, label %b69.e304
b69.t303:
  br label %b71
b69.e304:
  br label %b72
b70:
  br label %b68
b71:
  %v507 = add i64 0, 3
  %v508 = getelementptr i64, ptr %v0, i64 %v507
  %v612 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v508, i64 %v612, i64 %v1)
  br label %b72
b72:
  %v613 = getelementptr i64, ptr @"rt.meta", i64 0
  %st304 = getelementptr i64, ptr %v613, i64 0
  store i64 %v1, ptr %st304
  ret void
b73:
  %v520 = add i64 0, 3
  %v521 = getelementptr i64, ptr %v222, i64 %v520
  %v614 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v521, i64 %v614, i64 %v223)
  br label %b74
b74:
  %v615 = getelementptr i64, ptr @"rt.meta", i64 0
  %st305 = getelementptr i64, ptr %v615, i64 0
  store i64 %v223, ptr %st305
  br label %b31
b75:
  %v525 = add i64 0, 0
  %v526.p = getelementptr i64, ptr %v222, i64 0
  %v526 = load i64, ptr %v526.p
  %st306 = getelementptr i64, ptr %v0, i64 0
  store i64 %v526, ptr %st306
  %v527.p = getelementptr i64, ptr %v222, i64 1
  %v527 = load i64, ptr %v527.p
  %st307 = getelementptr i64, ptr %v0, i64 1
  store i64 %v527, ptr %st307
  %v528.p = getelementptr i64, ptr %v222, i64 2
  %v528 = load i64, ptr %v528.p
  %st308 = getelementptr i64, ptr %v0, i64 2
  store i64 %v528, ptr %st308
  %v529.p = getelementptr i64, ptr %v222, i64 3
  %v529 = load i64, ptr %v529.p
  %st309 = getelementptr i64, ptr %v0, i64 3
  store i64 %v529, ptr %st309
  %v530.p = getelementptr i64, ptr %v222, i64 4
  %v530 = load i64, ptr %v530.p
  %st310 = getelementptr i64, ptr %v0, i64 4
  store i64 %v530, ptr %st310
  %v531.p = getelementptr i64, ptr %v222, i64 5
  %v531 = load i64, ptr %v531.p
  %st311 = getelementptr i64, ptr %v0, i64 5
  store i64 %v531, ptr %st311
  call void @"std/net.closeFd"(i64 %v85)
  %v532.p = getelementptr i64, ptr %v0, i64 0
  %v532 = load i64, ptr %v532.p
  %v533 = add i64 0, 0
  %v534.c = icmp ne i64 %v532, %v533
  %v534 = zext i1 %v534.c to i64
  %c.b75 = icmp ne i64 %v534, 0
  br i1 %c.b75, label %b75.t313, label %b75.e314
b75.t313:
  br label %b77
b75.e314:
  br label %b78
b76:
  br label %b30
b77:
  %v535 = add i64 0, 3
  %v536 = getelementptr i64, ptr %v0, i64 %v535
  %v616 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v536, i64 %v616, i64 %v1)
  br label %b78
b78:
  %v617 = getelementptr i64, ptr @"rt.meta", i64 0
  %st314 = getelementptr i64, ptr %v617, i64 0
  store i64 %v1, ptr %st314
  ret void
b79:
  %v548 = add i64 0, 3
  %v549 = getelementptr i64, ptr %v12, i64 %v548
  %v618 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v549, i64 %v618, i64 %v13)
  br label %b80
b80:
  %v619 = getelementptr i64, ptr @"rt.meta", i64 0
  %st315 = getelementptr i64, ptr %v619, i64 0
  store i64 %v13, ptr %st315
  br label %b2
b81:
  %v553 = add i64 0, 0
  %v554.p = getelementptr i64, ptr %v12, i64 0
  %v554 = load i64, ptr %v554.p
  %st316 = getelementptr i64, ptr %v0, i64 0
  store i64 %v554, ptr %st316
  %v555.p = getelementptr i64, ptr %v12, i64 1
  %v555 = load i64, ptr %v555.p
  %st317 = getelementptr i64, ptr %v0, i64 1
  store i64 %v555, ptr %st317
  %v556.p = getelementptr i64, ptr %v12, i64 2
  %v556 = load i64, ptr %v556.p
  %st318 = getelementptr i64, ptr %v0, i64 2
  store i64 %v556, ptr %st318
  %v557.p = getelementptr i64, ptr %v12, i64 3
  %v557 = load i64, ptr %v557.p
  %st319 = getelementptr i64, ptr %v0, i64 3
  store i64 %v557, ptr %st319
  %v558.p = getelementptr i64, ptr %v12, i64 4
  %v558 = load i64, ptr %v558.p
  %st320 = getelementptr i64, ptr %v0, i64 4
  store i64 %v558, ptr %st320
  %v559.p = getelementptr i64, ptr %v12, i64 5
  %v559 = load i64, ptr %v559.p
  %st321 = getelementptr i64, ptr %v0, i64 5
  store i64 %v559, ptr %st321
  %v560.p = getelementptr i64, ptr %v0, i64 0
  %v560 = load i64, ptr %v560.p
  %v561 = add i64 0, 0
  %v562.c = icmp ne i64 %v560, %v561
  %v562 = zext i1 %v562.c to i64
  %c.b81 = icmp ne i64 %v562, 0
  br i1 %c.b81, label %b81.t323, label %b81.e324
b81.t323:
  br label %b83
b81.e324:
  br label %b84
b82:
  br label %b1
b83:
  %v563 = add i64 0, 3
  %v564 = getelementptr i64, ptr %v0, i64 %v563
  %v620 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v564, i64 %v620, i64 %v1)
  br label %b84
b84:
  %v621 = getelementptr i64, ptr @"rt.meta", i64 0
  %st324 = getelementptr i64, ptr %v621, i64 0
  store i64 %v1, ptr %st324
  ret void
b85:
  %v576 = add i64 0, 3
  %v577 = getelementptr i64, ptr %v0, i64 %v576
  %v622 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v577, i64 %v622, i64 %v1)
  br label %b86
b86:
  %v623 = getelementptr i64, ptr @"rt.meta", i64 0
  %st325 = getelementptr i64, ptr %v623, i64 0
  store i64 %v1, ptr %st325
  ret void
}

define internal void @"std/net.sockaddr"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [1 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v247 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v247, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v4, i64 0
  %v7 = load i64, ptr %v7.p
  %st3 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st3
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %st4 = getelementptr i64, ptr %v6, i64 1
  store i64 %v8, ptr %st4
  %v9.p = getelementptr i64, ptr %v4, i64 2
  %v9 = load i64, ptr %v9.p
  %st5 = getelementptr i64, ptr %v6, i64 2
  store i64 %v9, ptr %st5
  %v10 = add i64 0, 2
  %v11 = add i64 0, 0
  %v12 = add i64 0, 0
  %v13 = add i64 0, 0
  %v248 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v248, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 0, 4
  %v16 = call ptr @"rt.region_alloc8"(i64 %v14, i64 %v15)
  %v17 = add i64 0, 0
  %v18 = getelementptr i8, ptr %v16, i64 %v17
  %st6 = getelementptr i8, ptr %v18, i64 0
  %st6.b = trunc i64 %v10 to i8
  store i8 %st6.b, ptr %st6
  %v19 = add i64 0, 1
  %v20 = getelementptr i8, ptr %v16, i64 %v19
  %st7 = getelementptr i8, ptr %v20, i64 0
  %st7.b = trunc i64 %v11 to i8
  store i8 %st7.b, ptr %st7
  %v21 = add i64 0, 2
  %v22 = getelementptr i8, ptr %v16, i64 %v21
  %st8 = getelementptr i8, ptr %v22, i64 0
  %st8.b = trunc i64 %v12 to i8
  store i8 %st8.b, ptr %st8
  %v23 = add i64 0, 3
  %v24 = getelementptr i8, ptr %v16, i64 %v23
  %st9 = getelementptr i8, ptr %v24, i64 0
  %st9.b = trunc i64 %v13 to i8
  store i8 %st9.b, ptr %st9
  %v25 = add i64 0, 4
  %v26 = getelementptr i64, ptr %s2, i64 0
  %v27 = ptrtoint ptr %v16 to i64
  %st10 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st10
  %st11 = getelementptr i64, ptr %v26, i64 1
  store i64 %v25, ptr %st11
  %st12 = getelementptr i64, ptr %v26, i64 2
  store i64 %v14, ptr %st12
  %v28 = getelementptr i64, ptr %s3, i64 0
  %v29.p = getelementptr i64, ptr %v26, i64 0
  %v29 = load i64, ptr %v29.p
  %st13 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st13
  %v30.p = getelementptr i64, ptr %v26, i64 1
  %v30 = load i64, ptr %v30.p
  %st14 = getelementptr i64, ptr %v28, i64 1
  store i64 %v30, ptr %st14
  %v31.p = getelementptr i64, ptr %v26, i64 2
  %v31 = load i64, ptr %v31.p
  %st15 = getelementptr i64, ptr %v28, i64 2
  store i64 %v31, ptr %st15
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s4, i64 0
  %st16 = getelementptr i64, ptr %v33, i64 0
  store i64 %v32, ptr %st16
  %v34 = add i64 0, 0
  %v35 = getelementptr i64, ptr %s5, i64 0
  %st17 = getelementptr i64, ptr %v35, i64 0
  store i64 %v34, ptr %st17
  %v36 = add i64 0, 0
  %v37 = getelementptr i64, ptr %s6, i64 0
  %st18 = getelementptr i64, ptr %v37, i64 0
  store i64 %v36, ptr %st18
  %v38 = add i64 0, 0
  %v39 = getelementptr i64, ptr %s7, i64 0
  %st19 = getelementptr i64, ptr %v39, i64 0
  store i64 %v38, ptr %st19
  %v249 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v249, i64 0
  %v40 = load i64, ptr %v40.p
  br label %b1
b1:
  %v250 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v250, i64 0
  store i64 %v40, ptr %st20
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v6, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.c = icmp slt i64 %v41, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b1 = icmp ne i64 %v43, 0
  br i1 %c.b1, label %b1.t22, label %b1.e23
b1.t22:
  br label %b2
b1.e23:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v251 = getelementptr i64, ptr @"rt.meta", i64 0
  %v44.p = getelementptr i64, ptr %v251, i64 0
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v39, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v6, i64 1
  %v46 = load i64, ptr %v46.p
  %v47.c = icmp uge i64 %v45, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b2 = icmp ne i64 %v47, 0
  br i1 %c.b2, label %b2.t24, label %b2.e25
b2.t24:
  br label %b4
b2.e25:
  br label %b5
b3:
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v252, i64 0
  store i64 %v40, ptr %st25
  %v163.p = getelementptr i64, ptr %v37, i64 0
  %v163 = load i64, ptr %v163.p
  %v164 = add i64 0, 4
  %v165.c = icmp ne i64 %v163, %v164
  %v165 = zext i1 %v165.c to i64
  %c.b3 = icmp ne i64 %v165, 0
  br i1 %c.b3, label %b3.t27, label %b3.e28
b3.t27:
  br label %b34
b3.e28:
  br label %b33
b4:
  %v48 = add i64 0, 7
  call void @"rt.panic"(i64 %v48)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v49.p = getelementptr i64, ptr %v6, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = inttoptr i64 %v49 to ptr
  %v51 = getelementptr i8, ptr %v50, i64 %v45
  %v52.p = getelementptr i8, ptr %v51, i64 0
  %v52.b = load i8, ptr %v52.p
  %v52 = zext i8 %v52.b to i64
  %v53 = add i64 0, 48
  %v54.c = icmp sge i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b5 = icmp ne i64 %v54, 0
  br i1 %c.b5, label %b5.t29, label %b5.e30
b5.t29:
  br label %b6
b5.e30:
  br label %b7
b6:
  %v56 = add i64 0, 57
  %v57.c = icmp sle i64 %v52, %v56
  %v57 = zext i1 %v57.c to i64
  br label %b7
b7:
  %v55 = phi i64 [ %v54, %b5.e30 ], [ %v57, %b6 ]
  %c.b7 = icmp ne i64 %v55, 0
  br i1 %c.b7, label %b7.t31, label %b7.e32
b7.t31:
  br label %b8
b7.e32:
  br label %b9
b8:
  %v58 = add i64 0, 1
  %v59 = add i64 %v5, %v58
  %v60.p = getelementptr i64, ptr %v33, i64 0
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 10
  %v62 = mul i64 %v60, %v61
  %v63 = add i64 %v62, %v52
  %v64 = add i64 0, 48
  %v65 = sub i64 %v63, %v64
  %st32 = getelementptr i64, ptr %v33, i64 0
  store i64 %v65, ptr %st32
  %v66 = add i64 0, 1
  %v67.p = getelementptr i64, ptr %v35, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 %v67, %v66
  %st33 = getelementptr i64, ptr %v35, i64 0
  store i64 %v68, ptr %st33
  %v69.p = getelementptr i64, ptr %v33, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 65535
  %v71.c = icmp sgt i64 %v69, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b8 = icmp ne i64 %v71, 0
  br i1 %c.b8, label %b8.t35, label %b8.e36
b8.t35:
  br label %b10
b8.e36:
  br label %b11
b9:
  %v81 = add i64 0, 46
  %v82.c = icmp eq i64 %v52, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b9 = icmp ne i64 %v82, 0
  br i1 %c.b9, label %b9.t37, label %b9.e38
b9.t37:
  br label %b13
b9.e38:
  br label %b14
b10:
  %v253 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v253, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 0
  %v74 = call ptr @"rt.region_alloc8"(i64 %v72, i64 %v73)
  %v75 = add i64 0, 0
  %v76 = getelementptr i64, ptr %s2, i64 0
  %v77 = ptrtoint ptr %v74 to i64
  %st38 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st38
  %st39 = getelementptr i64, ptr %v76, i64 1
  store i64 %v75, ptr %st39
  %st40 = getelementptr i64, ptr %v76, i64 2
  store i64 %v72, ptr %st40
  %v78.p = getelementptr i64, ptr %v76, i64 0
  %v78 = load i64, ptr %v78.p
  %st41 = getelementptr i64, ptr %v0, i64 0
  store i64 %v78, ptr %st41
  %v79.p = getelementptr i64, ptr %v76, i64 1
  %v79 = load i64, ptr %v79.p
  %st42 = getelementptr i64, ptr %v0, i64 1
  store i64 %v79, ptr %st42
  %v80.p = getelementptr i64, ptr %v76, i64 2
  %v80 = load i64, ptr %v80.p
  %st43 = getelementptr i64, ptr %v0, i64 2
  store i64 %v80, ptr %st43
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v254 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v254, i64 0
  store i64 %v5, ptr %st44
  ret void
b11:
  br label %b12
b12:
  br label %b32
b13:
  %v84.p = getelementptr i64, ptr %v37, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 3
  %v86.c = icmp slt i64 %v84, %v85
  %v86 = zext i1 %v86.c to i64
  br label %b14
b14:
  %v83 = phi i64 [ %v82, %b9.e38 ], [ %v86, %b13 ]
  %c.b14 = icmp ne i64 %v83, 0
  br i1 %c.b14, label %b14.t46, label %b14.e47
b14.t46:
  br label %b16
b14.e47:
  br label %b15
b15:
  %v88 = add i64 0, 58
  %v89.c = icmp eq i64 %v52, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b15 = icmp ne i64 %v89, 0
  br i1 %c.b15, label %b15.t48, label %b15.e49
b15.t48:
  br label %b17
b15.e49:
  br label %b18
b16:
  %v87 = phi i64 [ %v83, %b14.t46 ], [ %v90, %b18 ]
  %c.b16 = icmp ne i64 %v87, 0
  br i1 %c.b16, label %b16.t50, label %b16.e51
b16.t50:
  br label %b19
b16.e51:
  br label %b20
b17:
  %v91.p = getelementptr i64, ptr %v37, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = add i64 0, 3
  %v93.c = icmp eq i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  br label %b18
b18:
  %v90 = phi i64 [ %v89, %b15.e49 ], [ %v93, %b17 ]
  br label %b16
b19:
  %v94.p = getelementptr i64, ptr %v35, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 0, 0
  %v96.c = icmp eq i64 %v94, %v95
  %v96 = zext i1 %v96.c to i64
  %c.b19 = icmp ne i64 %v96, 0
  br i1 %c.b19, label %b19.t52, label %b19.e53
b19.t52:
  br label %b22
b19.e53:
  br label %b21
b20:
  %v255 = getelementptr i64, ptr @"rt.meta", i64 0
  %v151.p = getelementptr i64, ptr %v255, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = add i64 0, 0
  %v153 = call ptr @"rt.region_alloc8"(i64 %v151, i64 %v152)
  %v154 = add i64 0, 0
  %v155 = getelementptr i64, ptr %s8, i64 0
  %v156 = ptrtoint ptr %v153 to i64
  %st53 = getelementptr i64, ptr %v155, i64 0
  store i64 %v156, ptr %st53
  %st54 = getelementptr i64, ptr %v155, i64 1
  store i64 %v154, ptr %st54
  %st55 = getelementptr i64, ptr %v155, i64 2
  store i64 %v151, ptr %st55
  %v157.p = getelementptr i64, ptr %v155, i64 0
  %v157 = load i64, ptr %v157.p
  %st56 = getelementptr i64, ptr %v0, i64 0
  store i64 %v157, ptr %st56
  %v158.p = getelementptr i64, ptr %v155, i64 1
  %v158 = load i64, ptr %v158.p
  %st57 = getelementptr i64, ptr %v0, i64 1
  store i64 %v158, ptr %st57
  %v159.p = getelementptr i64, ptr %v155, i64 2
  %v159 = load i64, ptr %v159.p
  %st58 = getelementptr i64, ptr %v0, i64 2
  store i64 %v159, ptr %st58
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v256 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v256, i64 0
  store i64 %v5, ptr %st59
  ret void
b21:
  %v98.p = getelementptr i64, ptr %v33, i64 0
  %v98 = load i64, ptr %v98.p
  %v99 = add i64 0, 255
  %v100.c = icmp sgt i64 %v98, %v99
  %v100 = zext i1 %v100.c to i64
  br label %b22
b22:
  %v97 = phi i64 [ %v96, %b19.t52 ], [ %v100, %b21 ]
  %c.b22 = icmp ne i64 %v97, 0
  br i1 %c.b22, label %b22.t61, label %b22.e62
b22.t61:
  br label %b23
b22.e62:
  br label %b24
b23:
  %v257 = getelementptr i64, ptr @"rt.meta", i64 0
  %v101.p = getelementptr i64, ptr %v257, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 0
  %v103 = call ptr @"rt.region_alloc8"(i64 %v101, i64 %v102)
  %v104 = add i64 0, 0
  %v105 = getelementptr i64, ptr %s2, i64 0
  %v106 = ptrtoint ptr %v103 to i64
  %st62 = getelementptr i64, ptr %v105, i64 0
  store i64 %v106, ptr %st62
  %st63 = getelementptr i64, ptr %v105, i64 1
  store i64 %v104, ptr %st63
  %st64 = getelementptr i64, ptr %v105, i64 2
  store i64 %v101, ptr %st64
  %v107.p = getelementptr i64, ptr %v105, i64 0
  %v107 = load i64, ptr %v107.p
  %st65 = getelementptr i64, ptr %v0, i64 0
  store i64 %v107, ptr %st65
  %v108.p = getelementptr i64, ptr %v105, i64 1
  %v108 = load i64, ptr %v108.p
  %st66 = getelementptr i64, ptr %v0, i64 1
  store i64 %v108, ptr %st66
  %v109.p = getelementptr i64, ptr %v105, i64 2
  %v109 = load i64, ptr %v109.p
  %st67 = getelementptr i64, ptr %v0, i64 2
  store i64 %v109, ptr %st67
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v258 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v258, i64 0
  store i64 %v5, ptr %st68
  ret void
b24:
  br label %b25
b25:
  %v110 = add i64 0, 1
  %v111 = add i64 %v5, %v110
  %v112 = getelementptr i64, ptr %s2, i64 0
  %v113.p = getelementptr i64, ptr %v28, i64 0
  %v113 = load i64, ptr %v113.p
  %st69 = getelementptr i64, ptr %v112, i64 0
  store i64 %v113, ptr %st69
  %v114.p = getelementptr i64, ptr %v28, i64 1
  %v114 = load i64, ptr %v114.p
  %st70 = getelementptr i64, ptr %v112, i64 1
  store i64 %v114, ptr %st70
  %v115.p = getelementptr i64, ptr %v28, i64 2
  %v115 = load i64, ptr %v115.p
  %st71 = getelementptr i64, ptr %v112, i64 2
  store i64 %v115, ptr %st71
  %v116.p = getelementptr i64, ptr %v33, i64 0
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 256
  %v118.c = icmp uge i64 %v116, %v117
  %v118 = zext i1 %v118.c to i64
  %c.b25 = icmp ne i64 %v118, 0
  br i1 %c.b25, label %b25.t73, label %b25.e74
b25.t73:
  br label %b26
b25.e74:
  br label %b27
b26:
  %v119 = add i64 0, 8
  call void @"rt.panic"(i64 %v119)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v120.p = getelementptr i64, ptr %v112, i64 2
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v112, i64 0
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v112, i64 1
  %v122 = load i64, ptr %v122.p
  %v125 = add i64 %v121, %v122
  %v126 = call i64 @"rt.tip8"(i64 %v120, i64 %v125)
  %v127 = add i64 0, 0
  %v128.c = icmp ne i64 %v126, %v127
  %v128 = zext i1 %v128.c to i64
  %c.b27 = icmp ne i64 %v128, 0
  br i1 %c.b27, label %b27.t75, label %b27.e76
b27.t75:
  br label %b30
b27.e76:
  br label %b29
b28:
  %v123 = phi ptr [ %v132, %b29 ], [ %v129, %b30 ]
  %v124 = phi ptr [ %v133, %b29 ], [ %v130, %b30 ]
  %st76 = getelementptr i8, ptr %v124, i64 0
  %st76.b = trunc i64 %v116 to i8
  store i8 %st76.b, ptr %st76
  %v134.p = getelementptr i64, ptr %v112, i64 1
  %v134 = load i64, ptr %v134.p
  %v135 = add i64 0, 1
  %v136 = add i64 %v134, %v135
  %v137 = getelementptr i64, ptr %s8, i64 0
  %v138 = ptrtoint ptr %v123 to i64
  %st77 = getelementptr i64, ptr %v137, i64 0
  store i64 %v138, ptr %st77
  %st78 = getelementptr i64, ptr %v137, i64 1
  store i64 %v136, ptr %st78
  %st79 = getelementptr i64, ptr %v137, i64 2
  store i64 %v120, ptr %st79
  %v139.p = getelementptr i64, ptr %v137, i64 0
  %v139 = load i64, ptr %v139.p
  %st80 = getelementptr i64, ptr %v28, i64 0
  store i64 %v139, ptr %st80
  %v140.p = getelementptr i64, ptr %v137, i64 1
  %v140 = load i64, ptr %v140.p
  %st81 = getelementptr i64, ptr %v28, i64 1
  store i64 %v140, ptr %st81
  %v141.p = getelementptr i64, ptr %v137, i64 2
  %v141 = load i64, ptr %v141.p
  %st82 = getelementptr i64, ptr %v28, i64 2
  store i64 %v141, ptr %st82
  %v142 = add i64 0, 1
  %v143.p = getelementptr i64, ptr %v37, i64 0
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 %v143, %v142
  %st83 = getelementptr i64, ptr %v37, i64 0
  store i64 %v144, ptr %st83
  %v145 = add i64 0, 1
  %v146 = add i64 %v5, %v145
  %v147 = add i64 0, 0
  %st84 = getelementptr i64, ptr %v33, i64 0
  store i64 %v147, ptr %st84
  %v148 = add i64 0, 1
  %v149 = add i64 %v5, %v148
  %v150 = add i64 0, 0
  %st85 = getelementptr i64, ptr %v35, i64 0
  store i64 %v150, ptr %st85
  br label %b31
b29:
  %v131 = add i64 0, 1
  %v132 = call ptr @"rt.slice_grow8"(i64 %v121, i64 %v122, i64 %v120, i64 %v131)
  %v133 = getelementptr i8, ptr %v132, i64 %v122
  br label %b28
b30:
  %v129 = inttoptr i64 %v121 to ptr
  %v130 = getelementptr i8, ptr %v129, i64 %v122
  br label %b28
b31:
  br label %b32
b32:
  %v160 = add i64 0, 1
  %v161.p = getelementptr i64, ptr %v39, i64 0
  %v161 = load i64, ptr %v161.p
  %v162 = add i64 %v161, %v160
  %st86 = getelementptr i64, ptr %v39, i64 0
  store i64 %v162, ptr %st86
  br label %b1
b33:
  %v167.p = getelementptr i64, ptr %v35, i64 0
  %v167 = load i64, ptr %v167.p
  %v168 = add i64 0, 0
  %v169.c = icmp eq i64 %v167, %v168
  %v169 = zext i1 %v169.c to i64
  br label %b34
b34:
  %v166 = phi i64 [ %v165, %b3.t27 ], [ %v169, %b33 ]
  %c.b34 = icmp ne i64 %v166, 0
  br i1 %c.b34, label %b34.t88, label %b34.e89
b34.t88:
  br label %b35
b34.e89:
  br label %b36
b35:
  %v259 = getelementptr i64, ptr @"rt.meta", i64 0
  %v170.p = getelementptr i64, ptr %v259, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 0, 0
  %v172 = call ptr @"rt.region_alloc8"(i64 %v170, i64 %v171)
  %v173 = add i64 0, 0
  %v174 = getelementptr i64, ptr %s8, i64 0
  %v175 = ptrtoint ptr %v172 to i64
  %st89 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st89
  %st90 = getelementptr i64, ptr %v174, i64 1
  store i64 %v173, ptr %st90
  %st91 = getelementptr i64, ptr %v174, i64 2
  store i64 %v170, ptr %st91
  %v176.p = getelementptr i64, ptr %v174, i64 0
  %v176 = load i64, ptr %v176.p
  %st92 = getelementptr i64, ptr %v0, i64 0
  store i64 %v176, ptr %st92
  %v177.p = getelementptr i64, ptr %v174, i64 1
  %v177 = load i64, ptr %v177.p
  %st93 = getelementptr i64, ptr %v0, i64 1
  store i64 %v177, ptr %st93
  %v178.p = getelementptr i64, ptr %v174, i64 2
  %v178 = load i64, ptr %v178.p
  %st94 = getelementptr i64, ptr %v0, i64 2
  store i64 %v178, ptr %st94
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v260 = getelementptr i64, ptr @"rt.meta", i64 0
  %st95 = getelementptr i64, ptr %v260, i64 0
  store i64 %v5, ptr %st95
  ret void
b36:
  br label %b37
b37:
  %v179 = add i64 0, 2
  %v180.p = getelementptr i64, ptr %v33, i64 0
  %v180 = load i64, ptr %v180.p
  %v181 = add i64 0, 256
  %v182 = sdiv i64 %v180, %v181
  %v183 = add i64 0, 256
  %v184.c = icmp uge i64 %v182, %v183
  %v184 = zext i1 %v184.c to i64
  %c.b37 = icmp ne i64 %v184, 0
  br i1 %c.b37, label %b37.t97, label %b37.e98
b37.t97:
  br label %b38
b37.e98:
  br label %b39
b38:
  %v185 = add i64 0, 9
  call void @"rt.panic"(i64 %v185)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b39:
  %v186.p = getelementptr i64, ptr %v28, i64 1
  %v186 = load i64, ptr %v186.p
  %v187.c = icmp uge i64 %v179, %v186
  %v187 = zext i1 %v187.c to i64
  %c.b39 = icmp ne i64 %v187, 0
  br i1 %c.b39, label %b39.t99, label %b39.e100
b39.t99:
  br label %b40
b39.e100:
  br label %b41
b40:
  %v188 = add i64 0, 10
  call void @"rt.panic"(i64 %v188)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b41:
  %v189.p = getelementptr i64, ptr %v28, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = inttoptr i64 %v189 to ptr
  %v191 = getelementptr i8, ptr %v190, i64 %v179
  %st100 = getelementptr i8, ptr %v191, i64 0
  %st100.b = trunc i64 %v182 to i8
  store i8 %st100.b, ptr %st100
  %v192 = add i64 0, 3
  %v193.p = getelementptr i64, ptr %v33, i64 0
  %v193 = load i64, ptr %v193.p
  %v194 = add i64 0, 256
  %v195 = srem i64 %v193, %v194
  %v196 = add i64 0, 256
  %v197.c = icmp uge i64 %v195, %v196
  %v197 = zext i1 %v197.c to i64
  %c.b41 = icmp ne i64 %v197, 0
  br i1 %c.b41, label %b41.t102, label %b41.e103
b41.t102:
  br label %b42
b41.e103:
  br label %b43
b42:
  %v198 = add i64 0, 11
  call void @"rt.panic"(i64 %v198)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b43:
  %v199.p = getelementptr i64, ptr %v28, i64 1
  %v199 = load i64, ptr %v199.p
  %v200.c = icmp uge i64 %v192, %v199
  %v200 = zext i1 %v200.c to i64
  %c.b43 = icmp ne i64 %v200, 0
  br i1 %c.b43, label %b43.t104, label %b43.e105
b43.t104:
  br label %b44
b43.e105:
  br label %b45
b44:
  %v201 = add i64 0, 12
  call void @"rt.panic"(i64 %v201)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b45:
  %v202.p = getelementptr i64, ptr %v28, i64 0
  %v202 = load i64, ptr %v202.p
  %v203 = inttoptr i64 %v202 to ptr
  %v204 = getelementptr i8, ptr %v203, i64 %v192
  %st105 = getelementptr i8, ptr %v204, i64 0
  %st105.b = trunc i64 %v195 to i8
  store i8 %st105.b, ptr %st105
  %v205 = add i64 0, 0
  %v206 = getelementptr i64, ptr %s9, i64 0
  %st106 = getelementptr i64, ptr %v206, i64 0
  store i64 %v205, ptr %st106
  %v261 = getelementptr i64, ptr @"rt.meta", i64 0
  %v207.p = getelementptr i64, ptr %v261, i64 0
  %v207 = load i64, ptr %v207.p
  br label %b46
b46:
  %v262 = getelementptr i64, ptr @"rt.meta", i64 0
  %st107 = getelementptr i64, ptr %v262, i64 0
  store i64 %v207, ptr %st107
  %v208.p = getelementptr i64, ptr %v206, i64 0
  %v208 = load i64, ptr %v208.p
  %v209 = add i64 0, 8
  %v210.c = icmp slt i64 %v208, %v209
  %v210 = zext i1 %v210.c to i64
  %c.b46 = icmp ne i64 %v210, 0
  br i1 %c.b46, label %b46.t109, label %b46.e110
b46.t109:
  br label %b47
b46.e110:
  br label %b48
b47:
  call void @"rt.region_enter"()
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %v211.p = getelementptr i64, ptr %v263, i64 0
  %v211 = load i64, ptr %v211.p
  %v212 = add i64 0, 1
  %v213 = add i64 %v5, %v212
  %v214 = getelementptr i64, ptr %s8, i64 0
  %v215.p = getelementptr i64, ptr %v28, i64 0
  %v215 = load i64, ptr %v215.p
  %st110 = getelementptr i64, ptr %v214, i64 0
  store i64 %v215, ptr %st110
  %v216.p = getelementptr i64, ptr %v28, i64 1
  %v216 = load i64, ptr %v216.p
  %st111 = getelementptr i64, ptr %v214, i64 1
  store i64 %v216, ptr %st111
  %v217.p = getelementptr i64, ptr %v28, i64 2
  %v217 = load i64, ptr %v217.p
  %st112 = getelementptr i64, ptr %v214, i64 2
  store i64 %v217, ptr %st112
  %v218 = add i64 0, 0
  %v219.p = getelementptr i64, ptr %v214, i64 2
  %v219 = load i64, ptr %v219.p
  %v220.p = getelementptr i64, ptr %v214, i64 0
  %v220 = load i64, ptr %v220.p
  %v221.p = getelementptr i64, ptr %v214, i64 1
  %v221 = load i64, ptr %v221.p
  %v224 = add i64 %v220, %v221
  %v225 = call i64 @"rt.tip8"(i64 %v219, i64 %v224)
  %v226 = add i64 0, 0
  %v227.c = icmp ne i64 %v225, %v226
  %v227 = zext i1 %v227.c to i64
  %c.b47 = icmp ne i64 %v227, 0
  br i1 %c.b47, label %b47.t114, label %b47.e115
b47.t114:
  br label %b51
b47.e115:
  br label %b50
b48:
  %v264 = getelementptr i64, ptr @"rt.meta", i64 0
  %st115 = getelementptr i64, ptr %v264, i64 0
  store i64 %v207, ptr %st115
  %v244.p = getelementptr i64, ptr %v28, i64 0
  %v244 = load i64, ptr %v244.p
  %st116 = getelementptr i64, ptr %v0, i64 0
  store i64 %v244, ptr %st116
  %v245.p = getelementptr i64, ptr %v28, i64 1
  %v245 = load i64, ptr %v245.p
  %st117 = getelementptr i64, ptr %v0, i64 1
  store i64 %v245, ptr %st117
  %v246.p = getelementptr i64, ptr %v28, i64 2
  %v246 = load i64, ptr %v246.p
  %st118 = getelementptr i64, ptr %v0, i64 2
  store i64 %v246, ptr %st118
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %st119 = getelementptr i64, ptr %v265, i64 0
  store i64 %v5, ptr %st119
  ret void
b49:
  %v222 = phi ptr [ %v231, %b50 ], [ %v228, %b51 ]
  %v223 = phi ptr [ %v232, %b50 ], [ %v229, %b51 ]
  %st120 = getelementptr i8, ptr %v223, i64 0
  %st120.b = trunc i64 %v218 to i8
  store i8 %st120.b, ptr %st120
  %v233.p = getelementptr i64, ptr %v214, i64 1
  %v233 = load i64, ptr %v233.p
  %v234 = add i64 0, 1
  %v235 = add i64 %v233, %v234
  %v236 = getelementptr i64, ptr %s2, i64 0
  %v237 = ptrtoint ptr %v222 to i64
  %st121 = getelementptr i64, ptr %v236, i64 0
  store i64 %v237, ptr %st121
  %st122 = getelementptr i64, ptr %v236, i64 1
  store i64 %v235, ptr %st122
  %st123 = getelementptr i64, ptr %v236, i64 2
  store i64 %v219, ptr %st123
  %v238.p = getelementptr i64, ptr %v236, i64 0
  %v238 = load i64, ptr %v238.p
  %st124 = getelementptr i64, ptr %v28, i64 0
  store i64 %v238, ptr %st124
  %v239.p = getelementptr i64, ptr %v236, i64 1
  %v239 = load i64, ptr %v239.p
  %st125 = getelementptr i64, ptr %v28, i64 1
  store i64 %v239, ptr %st125
  %v240.p = getelementptr i64, ptr %v236, i64 2
  %v240 = load i64, ptr %v240.p
  %st126 = getelementptr i64, ptr %v28, i64 2
  store i64 %v240, ptr %st126
  %v241 = add i64 0, 1
  %v242.p = getelementptr i64, ptr %v206, i64 0
  %v242 = load i64, ptr %v242.p
  %v243 = add i64 %v242, %v241
  %st127 = getelementptr i64, ptr %v206, i64 0
  store i64 %v243, ptr %st127
  br label %b46
b50:
  %v230 = add i64 0, 1
  %v231 = call ptr @"rt.slice_grow8"(i64 %v220, i64 %v221, i64 %v219, i64 %v230)
  %v232 = getelementptr i8, ptr %v231, i64 %v221
  br label %b49
b51:
  %v228 = inttoptr i64 %v220 to ptr
  %v229 = getelementptr i8, ptr %v228, i64 %v221
  br label %b49
}

define internal void @"std/net.errOf"(ptr %v0, i64 %v1) #0 {
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
  %s2 = alloca [2 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v97, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 32
  %v4.c = icmp eq i64 %v1, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v6 = add i64 0, 104
  %v7.c = icmp eq i64 %v1, %v6
  %v7 = zext i1 %v7.c to i64
  br label %b2
b2:
  %v5 = phi i64 [ %v4, %b0.t1 ], [ %v7, %b1 ]
  %c.b2 = icmp ne i64 %v5, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b4
b2.e4:
  br label %b3
b3:
  %v9 = add i64 0, 111
  %v10.c = icmp eq i64 %v1, %v9
  %v10 = zext i1 %v10.c to i64
  br label %b4
b4:
  %v8 = phi i64 [ %v5, %b2.t3 ], [ %v10, %b3 ]
  %c.b4 = icmp ne i64 %v8, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v11 = getelementptr i64, ptr %s0, i64 0
  %v12 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st6
  %st7 = getelementptr i64, ptr %v11, i64 1
  store i64 %v12, ptr %st7
  %v13 = add i64 0, 10
  %st8 = getelementptr i64, ptr %v11, i64 0
  store i64 %v13, ptr %st8
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15.p = getelementptr i64, ptr %v11, i64 0
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v11, i64 1
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st10
  %v17 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st11
  %st12 = getelementptr i64, ptr %v14, i64 3
  store i64 %v17, ptr %st12
  %st13 = getelementptr i64, ptr %v14, i64 4
  store i64 %v17, ptr %st13
  %v18.p = getelementptr i64, ptr %v14, i64 0
  %v18 = load i64, ptr %v18.p
  %st14 = getelementptr i64, ptr %v0, i64 0
  store i64 %v18, ptr %st14
  %v19.p = getelementptr i64, ptr %v14, i64 1
  %v19 = load i64, ptr %v19.p
  %st15 = getelementptr i64, ptr %v0, i64 1
  store i64 %v19, ptr %st15
  %v20.p = getelementptr i64, ptr %v14, i64 2
  %v20 = load i64, ptr %v20.p
  %st16 = getelementptr i64, ptr %v0, i64 2
  store i64 %v20, ptr %st16
  %v21.p = getelementptr i64, ptr %v14, i64 3
  %v21 = load i64, ptr %v21.p
  %st17 = getelementptr i64, ptr %v0, i64 3
  store i64 %v21, ptr %st17
  %v22.p = getelementptr i64, ptr %v14, i64 4
  %v22 = load i64, ptr %v22.p
  %st18 = getelementptr i64, ptr %v0, i64 4
  store i64 %v22, ptr %st18
  %v23 = add i64 0, 2
  %v24 = getelementptr i64, ptr %v0, i64 %v23
  %v98 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v24, i64 %v98, i64 %v2)
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v99, i64 0
  store i64 %v2, ptr %st19
  ret void
b6:
  br label %b7
b7:
  %v25 = add i64 0, 110
  %v26.c = icmp eq i64 %v1, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b7 = icmp ne i64 %v26, 0
  br i1 %c.b7, label %b7.t21, label %b7.e22
b7.t21:
  br label %b8
b7.e22:
  br label %b9
b8:
  %v27 = add i64 0, 0
  %v28 = add i64 0, 0
  %v29.c = icmp ne i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b8 = icmp ne i64 %v29, 0
  br i1 %c.b8, label %b8.t23, label %b8.e24
b8.t23:
  br label %b10
b8.e24:
  br label %b11
b9:
  br label %b13
b10:
  %v30 = getelementptr i64, ptr %s0, i64 0
  %v31 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st24
  %st25 = getelementptr i64, ptr %v30, i64 1
  store i64 %v31, ptr %st25
  %v32 = add i64 0, 9
  %st26 = getelementptr i64, ptr %v30, i64 0
  store i64 %v32, ptr %st26
  br label %b12
b11:
  %v33 = getelementptr i64, ptr %s2, i64 0
  %v34 = add i64 0, 0
  %st27 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st27
  %st28 = getelementptr i64, ptr %v33, i64 1
  store i64 %v34, ptr %st28
  %v35 = add i64 0, 8
  %st29 = getelementptr i64, ptr %v33, i64 0
  store i64 %v35, ptr %st29
  br label %b12
b12:
  %v36 = phi ptr [ %v30, %b10 ], [ %v33, %b11 ]
  %v37 = getelementptr i64, ptr %s1, i64 0
  %v38.p = getelementptr i64, ptr %v36, i64 0
  %v38 = load i64, ptr %v38.p
  %st30 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st30
  %v39.p = getelementptr i64, ptr %v36, i64 1
  %v39 = load i64, ptr %v39.p
  %st31 = getelementptr i64, ptr %v37, i64 1
  store i64 %v39, ptr %st31
  %v40 = add i64 0, 0
  %st32 = getelementptr i64, ptr %v37, i64 2
  store i64 %v40, ptr %st32
  %st33 = getelementptr i64, ptr %v37, i64 3
  store i64 %v40, ptr %st33
  %st34 = getelementptr i64, ptr %v37, i64 4
  store i64 %v40, ptr %st34
  %v41.p = getelementptr i64, ptr %v37, i64 0
  %v41 = load i64, ptr %v41.p
  %st35 = getelementptr i64, ptr %v0, i64 0
  store i64 %v41, ptr %st35
  %v42.p = getelementptr i64, ptr %v37, i64 1
  %v42 = load i64, ptr %v42.p
  %st36 = getelementptr i64, ptr %v0, i64 1
  store i64 %v42, ptr %st36
  %v43.p = getelementptr i64, ptr %v37, i64 2
  %v43 = load i64, ptr %v43.p
  %st37 = getelementptr i64, ptr %v0, i64 2
  store i64 %v43, ptr %st37
  %v44.p = getelementptr i64, ptr %v37, i64 3
  %v44 = load i64, ptr %v44.p
  %st38 = getelementptr i64, ptr %v0, i64 3
  store i64 %v44, ptr %st38
  %v45.p = getelementptr i64, ptr %v37, i64 4
  %v45 = load i64, ptr %v45.p
  %st39 = getelementptr i64, ptr %v0, i64 4
  store i64 %v45, ptr %st39
  %v46 = add i64 0, 2
  %v47 = getelementptr i64, ptr %v0, i64 %v46
  %v100 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v47, i64 %v100, i64 %v2)
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v101, i64 0
  store i64 %v2, ptr %st40
  ret void
b13:
  %v48 = add i64 0, 125
  %v49.c = icmp eq i64 %v1, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b13 = icmp ne i64 %v49, 0
  br i1 %c.b13, label %b13.t42, label %b13.e43
b13.t42:
  br label %b14
b13.e43:
  br label %b15
b14:
  %v50 = getelementptr i64, ptr %s2, i64 0
  %v51 = add i64 0, 0
  %st43 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st43
  %st44 = getelementptr i64, ptr %v50, i64 1
  store i64 %v51, ptr %st44
  %v52 = add i64 0, 9
  %st45 = getelementptr i64, ptr %v50, i64 0
  store i64 %v52, ptr %st45
  %v53 = getelementptr i64, ptr %s1, i64 0
  %v54.p = getelementptr i64, ptr %v50, i64 0
  %v54 = load i64, ptr %v54.p
  %st46 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st46
  %v55.p = getelementptr i64, ptr %v50, i64 1
  %v55 = load i64, ptr %v55.p
  %st47 = getelementptr i64, ptr %v53, i64 1
  store i64 %v55, ptr %st47
  %v56 = add i64 0, 0
  %st48 = getelementptr i64, ptr %v53, i64 2
  store i64 %v56, ptr %st48
  %st49 = getelementptr i64, ptr %v53, i64 3
  store i64 %v56, ptr %st49
  %st50 = getelementptr i64, ptr %v53, i64 4
  store i64 %v56, ptr %st50
  %v57.p = getelementptr i64, ptr %v53, i64 0
  %v57 = load i64, ptr %v57.p
  %st51 = getelementptr i64, ptr %v0, i64 0
  store i64 %v57, ptr %st51
  %v58.p = getelementptr i64, ptr %v53, i64 1
  %v58 = load i64, ptr %v58.p
  %st52 = getelementptr i64, ptr %v0, i64 1
  store i64 %v58, ptr %st52
  %v59.p = getelementptr i64, ptr %v53, i64 2
  %v59 = load i64, ptr %v59.p
  %st53 = getelementptr i64, ptr %v0, i64 2
  store i64 %v59, ptr %st53
  %v60.p = getelementptr i64, ptr %v53, i64 3
  %v60 = load i64, ptr %v60.p
  %st54 = getelementptr i64, ptr %v0, i64 3
  store i64 %v60, ptr %st54
  %v61.p = getelementptr i64, ptr %v53, i64 4
  %v61 = load i64, ptr %v61.p
  %st55 = getelementptr i64, ptr %v0, i64 4
  store i64 %v61, ptr %st55
  %v62 = add i64 0, 2
  %v63 = getelementptr i64, ptr %v0, i64 %v62
  %v102 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v63, i64 %v102, i64 %v2)
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v103, i64 0
  store i64 %v2, ptr %st56
  ret void
b15:
  br label %b16
b16:
  %v64 = add i64 0, 13
  %v65.c = icmp eq i64 %v1, %v64
  %v65 = zext i1 %v65.c to i64
  %c.b16 = icmp ne i64 %v65, 0
  br i1 %c.b16, label %b16.t58, label %b16.e59
b16.t58:
  br label %b18
b16.e59:
  br label %b17
b17:
  %v67 = add i64 0, 1
  %v68.c = icmp eq i64 %v1, %v67
  %v68 = zext i1 %v68.c to i64
  br label %b18
b18:
  %v66 = phi i64 [ %v65, %b16.t58 ], [ %v68, %b17 ]
  %c.b18 = icmp ne i64 %v66, 0
  br i1 %c.b18, label %b18.t60, label %b18.e61
b18.t60:
  br label %b19
b18.e61:
  br label %b20
b19:
  %v69 = getelementptr i64, ptr %s2, i64 0
  %v70 = add i64 0, 0
  %st61 = getelementptr i64, ptr %v69, i64 0
  store i64 %v70, ptr %st61
  %st62 = getelementptr i64, ptr %v69, i64 1
  store i64 %v70, ptr %st62
  %v71 = add i64 0, 7
  %st63 = getelementptr i64, ptr %v69, i64 0
  store i64 %v71, ptr %st63
  %v72 = getelementptr i64, ptr %s1, i64 0
  %v73.p = getelementptr i64, ptr %v69, i64 0
  %v73 = load i64, ptr %v73.p
  %st64 = getelementptr i64, ptr %v72, i64 0
  store i64 %v73, ptr %st64
  %v74.p = getelementptr i64, ptr %v69, i64 1
  %v74 = load i64, ptr %v74.p
  %st65 = getelementptr i64, ptr %v72, i64 1
  store i64 %v74, ptr %st65
  %v75 = add i64 0, 0
  %st66 = getelementptr i64, ptr %v72, i64 2
  store i64 %v75, ptr %st66
  %st67 = getelementptr i64, ptr %v72, i64 3
  store i64 %v75, ptr %st67
  %st68 = getelementptr i64, ptr %v72, i64 4
  store i64 %v75, ptr %st68
  %v76.p = getelementptr i64, ptr %v72, i64 0
  %v76 = load i64, ptr %v76.p
  %st69 = getelementptr i64, ptr %v0, i64 0
  store i64 %v76, ptr %st69
  %v77.p = getelementptr i64, ptr %v72, i64 1
  %v77 = load i64, ptr %v77.p
  %st70 = getelementptr i64, ptr %v0, i64 1
  store i64 %v77, ptr %st70
  %v78.p = getelementptr i64, ptr %v72, i64 2
  %v78 = load i64, ptr %v78.p
  %st71 = getelementptr i64, ptr %v0, i64 2
  store i64 %v78, ptr %st71
  %v79.p = getelementptr i64, ptr %v72, i64 3
  %v79 = load i64, ptr %v79.p
  %st72 = getelementptr i64, ptr %v0, i64 3
  store i64 %v79, ptr %st72
  %v80.p = getelementptr i64, ptr %v72, i64 4
  %v80 = load i64, ptr %v80.p
  %st73 = getelementptr i64, ptr %v0, i64 4
  store i64 %v80, ptr %st73
  %v81 = add i64 0, 2
  %v82 = getelementptr i64, ptr %v0, i64 %v81
  %v104 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v82, i64 %v104, i64 %v2)
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %st74 = getelementptr i64, ptr %v105, i64 0
  store i64 %v2, ptr %st74
  ret void
b20:
  br label %b21
b21:
  %v83 = getelementptr i64, ptr %s2, i64 0
  %v84 = add i64 0, 0
  %st75 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st75
  %st76 = getelementptr i64, ptr %v83, i64 1
  store i64 %v84, ptr %st76
  %v85 = add i64 0, 11
  %st77 = getelementptr i64, ptr %v83, i64 0
  store i64 %v85, ptr %st77
  %st78 = getelementptr i64, ptr %v83, i64 1
  store i64 %v1, ptr %st78
  %v86 = getelementptr i64, ptr %s1, i64 0
  %v87.p = getelementptr i64, ptr %v83, i64 0
  %v87 = load i64, ptr %v87.p
  %st79 = getelementptr i64, ptr %v86, i64 0
  store i64 %v87, ptr %st79
  %v88.p = getelementptr i64, ptr %v83, i64 1
  %v88 = load i64, ptr %v88.p
  %st80 = getelementptr i64, ptr %v86, i64 1
  store i64 %v88, ptr %st80
  %v89 = add i64 0, 0
  %st81 = getelementptr i64, ptr %v86, i64 2
  store i64 %v89, ptr %st81
  %st82 = getelementptr i64, ptr %v86, i64 3
  store i64 %v89, ptr %st82
  %st83 = getelementptr i64, ptr %v86, i64 4
  store i64 %v89, ptr %st83
  %v90.p = getelementptr i64, ptr %v86, i64 0
  %v90 = load i64, ptr %v90.p
  %st84 = getelementptr i64, ptr %v0, i64 0
  store i64 %v90, ptr %st84
  %v91.p = getelementptr i64, ptr %v86, i64 1
  %v91 = load i64, ptr %v91.p
  %st85 = getelementptr i64, ptr %v0, i64 1
  store i64 %v91, ptr %st85
  %v92.p = getelementptr i64, ptr %v86, i64 2
  %v92 = load i64, ptr %v92.p
  %st86 = getelementptr i64, ptr %v0, i64 2
  store i64 %v92, ptr %st86
  %v93.p = getelementptr i64, ptr %v86, i64 3
  %v93 = load i64, ptr %v93.p
  %st87 = getelementptr i64, ptr %v0, i64 3
  store i64 %v93, ptr %st87
  %v94.p = getelementptr i64, ptr %v86, i64 4
  %v94 = load i64, ptr %v94.p
  %st88 = getelementptr i64, ptr %v0, i64 4
  store i64 %v94, ptr %st88
  %v95 = add i64 0, 2
  %v96 = getelementptr i64, ptr %v0, i64 %v95
  %v106 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v96, i64 %v106, i64 %v2)
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st89 = getelementptr i64, ptr %v107, i64 0
  store i64 %v2, ptr %st89
  ret void
}

define internal i64 @"std/net.Port"(i64 %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
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
  %v1 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v0, ptr %st0
  %v115 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v115, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 0
  %v4 = add i64 0, 0
  %v5 = add i64 0, 0
  %v6 = add i64 0, 0
  %v7 = add i64 0, 0
  %v8 = add i64 0, 0
  %v9 = add i64 0, 0
  %v10 = add i64 0, 0
  %v11 = add i64 0, 0
  %v12 = add i64 0, 0
  %v13 = add i64 0, 0
  %v14 = add i64 0, 0
  %v15 = add i64 0, 0
  %v16 = add i64 0, 0
  %v17 = add i64 0, 0
  %v18 = add i64 0, 0
  %v116 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v116, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 16
  %v21 = call ptr @"rt.region_alloc8"(i64 %v19, i64 %v20)
  %v22 = add i64 0, 0
  %v23 = getelementptr i8, ptr %v21, i64 %v22
  %st1 = getelementptr i8, ptr %v23, i64 0
  %st1.b = trunc i64 %v3 to i8
  store i8 %st1.b, ptr %st1
  %v24 = add i64 0, 1
  %v25 = getelementptr i8, ptr %v21, i64 %v24
  %st2 = getelementptr i8, ptr %v25, i64 0
  %st2.b = trunc i64 %v4 to i8
  store i8 %st2.b, ptr %st2
  %v26 = add i64 0, 2
  %v27 = getelementptr i8, ptr %v21, i64 %v26
  %st3 = getelementptr i8, ptr %v27, i64 0
  %st3.b = trunc i64 %v5 to i8
  store i8 %st3.b, ptr %st3
  %v28 = add i64 0, 3
  %v29 = getelementptr i8, ptr %v21, i64 %v28
  %st4 = getelementptr i8, ptr %v29, i64 0
  %st4.b = trunc i64 %v6 to i8
  store i8 %st4.b, ptr %st4
  %v30 = add i64 0, 4
  %v31 = getelementptr i8, ptr %v21, i64 %v30
  %st5 = getelementptr i8, ptr %v31, i64 0
  %st5.b = trunc i64 %v7 to i8
  store i8 %st5.b, ptr %st5
  %v32 = add i64 0, 5
  %v33 = getelementptr i8, ptr %v21, i64 %v32
  %st6 = getelementptr i8, ptr %v33, i64 0
  %st6.b = trunc i64 %v8 to i8
  store i8 %st6.b, ptr %st6
  %v34 = add i64 0, 6
  %v35 = getelementptr i8, ptr %v21, i64 %v34
  %st7 = getelementptr i8, ptr %v35, i64 0
  %st7.b = trunc i64 %v9 to i8
  store i8 %st7.b, ptr %st7
  %v36 = add i64 0, 7
  %v37 = getelementptr i8, ptr %v21, i64 %v36
  %st8 = getelementptr i8, ptr %v37, i64 0
  %st8.b = trunc i64 %v10 to i8
  store i8 %st8.b, ptr %st8
  %v38 = add i64 0, 8
  %v39 = getelementptr i8, ptr %v21, i64 %v38
  %st9 = getelementptr i8, ptr %v39, i64 0
  %st9.b = trunc i64 %v11 to i8
  store i8 %st9.b, ptr %st9
  %v40 = add i64 0, 9
  %v41 = getelementptr i8, ptr %v21, i64 %v40
  %st10 = getelementptr i8, ptr %v41, i64 0
  %st10.b = trunc i64 %v12 to i8
  store i8 %st10.b, ptr %st10
  %v42 = add i64 0, 10
  %v43 = getelementptr i8, ptr %v21, i64 %v42
  %st11 = getelementptr i8, ptr %v43, i64 0
  %st11.b = trunc i64 %v13 to i8
  store i8 %st11.b, ptr %st11
  %v44 = add i64 0, 11
  %v45 = getelementptr i8, ptr %v21, i64 %v44
  %st12 = getelementptr i8, ptr %v45, i64 0
  %st12.b = trunc i64 %v14 to i8
  store i8 %st12.b, ptr %st12
  %v46 = add i64 0, 12
  %v47 = getelementptr i8, ptr %v21, i64 %v46
  %st13 = getelementptr i8, ptr %v47, i64 0
  %st13.b = trunc i64 %v15 to i8
  store i8 %st13.b, ptr %st13
  %v48 = add i64 0, 13
  %v49 = getelementptr i8, ptr %v21, i64 %v48
  %st14 = getelementptr i8, ptr %v49, i64 0
  %st14.b = trunc i64 %v16 to i8
  store i8 %st14.b, ptr %st14
  %v50 = add i64 0, 14
  %v51 = getelementptr i8, ptr %v21, i64 %v50
  %st15 = getelementptr i8, ptr %v51, i64 0
  %st15.b = trunc i64 %v17 to i8
  store i8 %st15.b, ptr %st15
  %v52 = add i64 0, 15
  %v53 = getelementptr i8, ptr %v21, i64 %v52
  %st16 = getelementptr i8, ptr %v53, i64 0
  %st16.b = trunc i64 %v18 to i8
  store i8 %st16.b, ptr %st16
  %v54 = add i64 0, 16
  %v55 = getelementptr i64, ptr %s1, i64 0
  %v56 = ptrtoint ptr %v21 to i64
  %st17 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st17
  %st18 = getelementptr i64, ptr %v55, i64 1
  store i64 %v54, ptr %st18
  %st19 = getelementptr i64, ptr %v55, i64 2
  store i64 %v19, ptr %st19
  %v57 = getelementptr i64, ptr %s2, i64 0
  %v58.p = getelementptr i64, ptr %v55, i64 0
  %v58 = load i64, ptr %v58.p
  %st20 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st20
  %v59.p = getelementptr i64, ptr %v55, i64 1
  %v59 = load i64, ptr %v59.p
  %st21 = getelementptr i64, ptr %v57, i64 1
  store i64 %v59, ptr %st21
  %v60.p = getelementptr i64, ptr %v55, i64 2
  %v60 = load i64, ptr %v60.p
  %st22 = getelementptr i64, ptr %v57, i64 2
  store i64 %v60, ptr %st22
  %v61 = add i64 0, 16
  %v62 = add i64 0, 0
  %v63 = add i64 0, 0
  %v64 = add i64 0, 0
  %v117 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v117, i64 0
  %v65 = load i64, ptr %v65.p
  %v66 = add i64 0, 4
  %v67 = call ptr @"rt.region_alloc8"(i64 %v65, i64 %v66)
  %v68 = add i64 0, 0
  %v69 = getelementptr i8, ptr %v67, i64 %v68
  %st23 = getelementptr i8, ptr %v69, i64 0
  %st23.b = trunc i64 %v61 to i8
  store i8 %st23.b, ptr %st23
  %v70 = add i64 0, 1
  %v71 = getelementptr i8, ptr %v67, i64 %v70
  %st24 = getelementptr i8, ptr %v71, i64 0
  %st24.b = trunc i64 %v62 to i8
  store i8 %st24.b, ptr %st24
  %v72 = add i64 0, 2
  %v73 = getelementptr i8, ptr %v67, i64 %v72
  %st25 = getelementptr i8, ptr %v73, i64 0
  %st25.b = trunc i64 %v63 to i8
  store i8 %st25.b, ptr %st25
  %v74 = add i64 0, 3
  %v75 = getelementptr i8, ptr %v67, i64 %v74
  %st26 = getelementptr i8, ptr %v75, i64 0
  %st26.b = trunc i64 %v64 to i8
  store i8 %st26.b, ptr %st26
  %v76 = add i64 0, 4
  %v77 = getelementptr i64, ptr %s1, i64 0
  %v78 = ptrtoint ptr %v67 to i64
  %st27 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st27
  %st28 = getelementptr i64, ptr %v77, i64 1
  store i64 %v76, ptr %st28
  %st29 = getelementptr i64, ptr %v77, i64 2
  store i64 %v65, ptr %st29
  %v79 = getelementptr i64, ptr %s3, i64 0
  %v80.p = getelementptr i64, ptr %v77, i64 0
  %v80 = load i64, ptr %v80.p
  %st30 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st30
  %v81.p = getelementptr i64, ptr %v77, i64 1
  %v81 = load i64, ptr %v81.p
  %st31 = getelementptr i64, ptr %v79, i64 1
  store i64 %v81, ptr %st31
  %v82.p = getelementptr i64, ptr %v77, i64 2
  %v82 = load i64, ptr %v82.p
  %st32 = getelementptr i64, ptr %v79, i64 2
  store i64 %v82, ptr %st32
  %v83 = add i64 0, 51
  %v84.p = getelementptr i64, ptr %v1, i64 0
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v57, i64 0
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v79, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 0, 0
  %v88 = add i64 0, 0
  %v89 = add i64 0, 0
  %v90 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v83, i64 %v84, i64 %v85, i64 %v86, i64 %v87, i64 %v88, i64 %v89)
  %v91 = add i64 0, 0
  %v92.c = icmp slt i64 %v90, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b0 = icmp ne i64 %v92, 0
  br i1 %c.b0, label %b0.t34, label %b0.e35
b0.t34:
  br label %b1
b0.e35:
  br label %b2
b1:
  %v93 = add i64 0, 1
  %v94 = add i64 0, 0
  %v95 = sub i64 %v94, %v93
  %v118 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v118, i64 0
  store i64 %v2, ptr %st35
  ret i64 %v95
b2:
  br label %b3
b3:
  %v96 = add i64 0, 2
  %v97.p = getelementptr i64, ptr %v57, i64 1
  %v97 = load i64, ptr %v97.p
  %v98.c = icmp uge i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b3 = icmp ne i64 %v98, 0
  br i1 %c.b3, label %b3.t37, label %b3.e38
b3.t37:
  br label %b4
b3.e38:
  br label %b5
b4:
  %v99 = add i64 0, 5
  call void @"rt.panic"(i64 %v99)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v100.p = getelementptr i64, ptr %v57, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = inttoptr i64 %v100 to ptr
  %v102 = getelementptr i8, ptr %v101, i64 %v96
  %v103.p = getelementptr i8, ptr %v102, i64 0
  %v103.b = load i8, ptr %v103.p
  %v103 = zext i8 %v103.b to i64
  %v104 = add i64 0, 256
  %v105 = mul i64 %v103, %v104
  %v106 = add i64 0, 3
  %v107.p = getelementptr i64, ptr %v57, i64 1
  %v107 = load i64, ptr %v107.p
  %v108.c = icmp uge i64 %v106, %v107
  %v108 = zext i1 %v108.c to i64
  %c.b5 = icmp ne i64 %v108, 0
  br i1 %c.b5, label %b5.t39, label %b5.e40
b5.t39:
  br label %b6
b5.e40:
  br label %b7
b6:
  %v109 = add i64 0, 6
  call void @"rt.panic"(i64 %v109)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v110.p = getelementptr i64, ptr %v57, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = inttoptr i64 %v110 to ptr
  %v112 = getelementptr i8, ptr %v111, i64 %v106
  %v113.p = getelementptr i8, ptr %v112, i64 0
  %v113.b = load i8, ptr %v113.p
  %v113 = zext i8 %v113.b to i64
  %v114 = add i64 %v105, %v113
  %v119 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v119, i64 0
  store i64 %v2, ptr %st40
  ret i64 %v114
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

define internal i64 @"std/net.again"(i64 %v0, i64 %v1, i64 %v2) #0 {
b0:
  %v24 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v24, i64 0
  %v3 = load i64, ptr %v3.p
  call void @"rt.region_enter"()
  %v4 = add i64 0, 11
  %v5 = add i64 0, 0
  %v6 = sub i64 %v5, %v4
  %v7.c = icmp ne i64 %v0, %v6
  %v7 = zext i1 %v7.c to i64
  %c.b0 = icmp ne i64 %v7, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v9 = add i64 0, 4
  %v10 = add i64 0, 0
  %v11 = sub i64 %v10, %v9
  %v12.c = icmp ne i64 %v0, %v11
  %v12 = zext i1 %v12.c to i64
  br label %b2
b2:
  %v8 = phi i64 [ %v7, %b0.e2 ], [ %v12, %b1 ]
  %c.b2 = icmp ne i64 %v8, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v14 = add i64 0, 115
  %v15 = add i64 0, 0
  %v16 = sub i64 %v15, %v14
  %v17.c = icmp ne i64 %v0, %v16
  %v17 = zext i1 %v17.c to i64
  br label %b4
b4:
  %v13 = phi i64 [ %v8, %b2.e4 ], [ %v17, %b3 ]
  %c.b4 = icmp ne i64 %v13, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v18 = add i64 0, 1
  %v25 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v25, i64 0
  store i64 %v3, ptr %st6
  ret i64 %v18
b6:
  br label %b7
b7:
  %v19 = call i64 @"rt.fdwait"(i64 %v1, i64 %v2)
  %v20 = add i64 0, 0
  %v21.c = icmp slt i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b7 = icmp ne i64 %v21, 0
  br i1 %c.b7, label %b7.t8, label %b7.e9
b7.t8:
  br label %b8
b7.e9:
  br label %b9
b8:
  br label %b10
b9:
  %v22 = add i64 0, 0
  br label %b10
b10:
  %v23 = phi i64 [ %v19, %b8 ], [ %v22, %b9 ]
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v26, i64 0
  store i64 %v3, ptr %st9
  ret i64 %v23
}

define internal void @"std/net.waitErr"(ptr %v0, i64 %v1) #0 {
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
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v31, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 0
  %v4 = add i64 0, 110
  %v5 = sub i64 %v3, %v4
  %v6.c = icmp eq i64 %v1, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b0 = icmp ne i64 %v6, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v7 = getelementptr i64, ptr %s0, i64 0
  %v8 = add i64 0, 0
  %st2 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st2
  %st3 = getelementptr i64, ptr %v7, i64 1
  store i64 %v8, ptr %st3
  %v9 = add i64 0, 9
  %st4 = getelementptr i64, ptr %v7, i64 0
  store i64 %v9, ptr %st4
  %v10 = getelementptr i64, ptr %s1, i64 0
  %v11.p = getelementptr i64, ptr %v7, i64 0
  %v11 = load i64, ptr %v11.p
  %st5 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st5
  %v12.p = getelementptr i64, ptr %v7, i64 1
  %v12 = load i64, ptr %v12.p
  %st6 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st6
  %v13 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st7
  %st8 = getelementptr i64, ptr %v10, i64 3
  store i64 %v13, ptr %st8
  %st9 = getelementptr i64, ptr %v10, i64 4
  store i64 %v13, ptr %st9
  %v14.p = getelementptr i64, ptr %v10, i64 0
  %v14 = load i64, ptr %v14.p
  %st10 = getelementptr i64, ptr %v0, i64 0
  store i64 %v14, ptr %st10
  %v15.p = getelementptr i64, ptr %v10, i64 1
  %v15 = load i64, ptr %v15.p
  %st11 = getelementptr i64, ptr %v0, i64 1
  store i64 %v15, ptr %st11
  %v16.p = getelementptr i64, ptr %v10, i64 2
  %v16 = load i64, ptr %v16.p
  %st12 = getelementptr i64, ptr %v0, i64 2
  store i64 %v16, ptr %st12
  %v17.p = getelementptr i64, ptr %v10, i64 3
  %v17 = load i64, ptr %v17.p
  %st13 = getelementptr i64, ptr %v0, i64 3
  store i64 %v17, ptr %st13
  %v18.p = getelementptr i64, ptr %v10, i64 4
  %v18 = load i64, ptr %v18.p
  %st14 = getelementptr i64, ptr %v0, i64 4
  store i64 %v18, ptr %st14
  %v19 = add i64 0, 2
  %v20 = getelementptr i64, ptr %v0, i64 %v19
  %v32 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v20, i64 %v32, i64 %v2)
  %v33 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v33, i64 0
  store i64 %v2, ptr %st15
  ret void
b2:
  br label %b3
b3:
  %v21 = getelementptr i64, ptr %s2, i64 0
  %v22 = add i64 0, 0
  %v23 = sub i64 %v22, %v1
  call void @"std/net.errOf"(ptr %v21, i64 %v23)
  %v24.p = getelementptr i64, ptr %v21, i64 0
  %v24 = load i64, ptr %v24.p
  %st16 = getelementptr i64, ptr %v0, i64 0
  store i64 %v24, ptr %st16
  %v25.p = getelementptr i64, ptr %v21, i64 1
  %v25 = load i64, ptr %v25.p
  %st17 = getelementptr i64, ptr %v0, i64 1
  store i64 %v25, ptr %st17
  %v26.p = getelementptr i64, ptr %v21, i64 2
  %v26 = load i64, ptr %v26.p
  %st18 = getelementptr i64, ptr %v0, i64 2
  store i64 %v26, ptr %st18
  %v27.p = getelementptr i64, ptr %v21, i64 3
  %v27 = load i64, ptr %v27.p
  %st19 = getelementptr i64, ptr %v0, i64 3
  store i64 %v27, ptr %st19
  %v28.p = getelementptr i64, ptr %v21, i64 4
  %v28 = load i64, ptr %v28.p
  %st20 = getelementptr i64, ptr %v0, i64 4
  store i64 %v28, ptr %st20
  %v29 = add i64 0, 2
  %v30 = getelementptr i64, ptr %v0, i64 %v29
  %v34 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v30, i64 %v34, i64 %v2)
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v35, i64 0
  store i64 %v2, ptr %st21
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
  %v20 = getelementptr i64, ptr @"str.16", i64 0
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
  %v74 = getelementptr i64, ptr @"str.24", i64 0
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
  %v27 = getelementptr i64, ptr @"str.17", i64 0
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
  %v34 = getelementptr i64, ptr @"str.18", i64 0
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
  %v41 = getelementptr i64, ptr @"str.19", i64 0
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
  %v48 = getelementptr i64, ptr @"str.20", i64 0
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
  %v55 = getelementptr i64, ptr @"str.21", i64 0
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
  %v62 = getelementptr i64, ptr @"str.22", i64 0
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
  %v69 = getelementptr i64, ptr @"str.23", i64 0
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
  %v81 = getelementptr i64, ptr @"str.25", i64 0
  %v82 = add i64 0, 17
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
  %v88 = getelementptr i64, ptr @"str.26", i64 0
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

define internal void @"main.serve"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
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
  %s3 = alloca [4 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s3.z3 = getelementptr i64, ptr %s3, i64 3
  store i64 0, ptr %s3.z3
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
  %s5 = alloca [2 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
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
  %v8 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v8, i64 0
  store i64 %v1, ptr %st0
  %v9 = getelementptr i64, ptr %s1, i64 0
  %st1 = getelementptr i64, ptr %v9, i64 0
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v9, i64 1
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v9, i64 2
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v9, i64 3
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v9, i64 4
  store i64 %v6, ptr %st5
  %st6 = getelementptr i64, ptr %v9, i64 5
  store i64 %v7, ptr %st6
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v63, i64 0
  %v10 = load i64, ptr %v10.p
  call void @"rt.region_enter"()
  %v11 = add i64 0, 1
  %v12 = getelementptr i64, ptr %v9, i64 %v11
  %v13 = getelementptr i64, ptr %s2, i64 0
  %v14.p = getelementptr i64, ptr %v12, i64 0
  %v14 = load i64, ptr %v14.p
  %st7 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st7
  %v15.p = getelementptr i64, ptr %v12, i64 1
  %v15 = load i64, ptr %v15.p
  %st8 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st8
  %v16.p = getelementptr i64, ptr %v12, i64 2
  %v16 = load i64, ptr %v16.p
  %st9 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st9
  %v17.p = getelementptr i64, ptr %v12, i64 3
  %v17 = load i64, ptr %v17.p
  %st10 = getelementptr i64, ptr %v13, i64 3
  store i64 %v17, ptr %st10
  %v18.p = getelementptr i64, ptr %v12, i64 4
  %v18 = load i64, ptr %v18.p
  %st11 = getelementptr i64, ptr %v13, i64 4
  store i64 %v18, ptr %st11
  %v19.p = getelementptr i64, ptr %v13, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %v21.c = icmp ne i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b0 = icmp ne i64 %v21, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v22 = add i64 0, 1
  %v23 = getelementptr i64, ptr %v13, i64 %v22
  %v24 = getelementptr i64, ptr %s3, i64 0
  %v25.p = getelementptr i64, ptr %v23, i64 0
  %v25 = load i64, ptr %v25.p
  %st14 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st14
  %v26.p = getelementptr i64, ptr %v23, i64 1
  %v26 = load i64, ptr %v26.p
  %st15 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st15
  %v27.p = getelementptr i64, ptr %v23, i64 2
  %v27 = load i64, ptr %v27.p
  %st16 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st16
  %v28.p = getelementptr i64, ptr %v23, i64 3
  %v28 = load i64, ptr %v28.p
  %st17 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st17
  %v29.p = getelementptr i64, ptr %v24, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 0, 1
  %v31 = getelementptr i64, ptr %v24, i64 %v30
  %v32 = ptrtoint ptr %v31 to i64
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34 = getelementptr i64, ptr %s5, i64 0
  %v35 = ptrtoint ptr @"lambda#1" to i64
  %st18 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st18
  %v36.p = getelementptr i64, ptr %v8, i64 0
  %v36 = load i64, ptr %v36.p
  %st19 = getelementptr i64, ptr %v34, i64 1
  store i64 %v36, ptr %st19
  %v37.p = getelementptr i64, ptr %v34, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v34, i64 1
  %v38 = load i64, ptr %v38.p
  %fp20 = inttoptr i64 %v29 to ptr
  call void %fp20(ptr %v33, i64 %v32, i64 %v37, i64 %v38)
  %v39.p = getelementptr i64, ptr %v33, i64 0
  %v39 = load i64, ptr %v39.p
  %st21 = getelementptr i64, ptr %v0, i64 0
  store i64 %v39, ptr %st21
  %v40.p = getelementptr i64, ptr %v33, i64 1
  %v40 = load i64, ptr %v40.p
  %st22 = getelementptr i64, ptr %v0, i64 1
  store i64 %v40, ptr %st22
  %v41.p = getelementptr i64, ptr %v33, i64 2
  %v41 = load i64, ptr %v41.p
  %st23 = getelementptr i64, ptr %v0, i64 2
  store i64 %v41, ptr %st23
  %v42.p = getelementptr i64, ptr %v33, i64 3
  %v42 = load i64, ptr %v42.p
  %st24 = getelementptr i64, ptr %v0, i64 3
  store i64 %v42, ptr %st24
  %v43.p = getelementptr i64, ptr %v33, i64 4
  %v43 = load i64, ptr %v43.p
  %st25 = getelementptr i64, ptr %v0, i64 4
  store i64 %v43, ptr %st25
  %v44.p = getelementptr i64, ptr %v33, i64 5
  %v44 = load i64, ptr %v44.p
  %st26 = getelementptr i64, ptr %v0, i64 5
  store i64 %v44, ptr %st26
  %v45.p = getelementptr i64, ptr %v0, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = add i64 0, 0
  %v47.c = icmp ne i64 %v45, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b1 = icmp ne i64 %v47, 0
  br i1 %c.b1, label %b1.t28, label %b1.e29
b1.t28:
  br label %b3
b1.e29:
  br label %b4
b2:
  br label %b5
b3:
  %v48 = add i64 0, 3
  %v49 = getelementptr i64, ptr %v0, i64 %v48
  %v64 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v49, i64 %v64, i64 %v10)
  br label %b4
b4:
  %v65 = getelementptr i64, ptr @"rt.meta", i64 0
  %st29 = getelementptr i64, ptr %v65, i64 0
  store i64 %v10, ptr %st29
  ret void
b5:
  %v50 = getelementptr i64, ptr %s6, i64 0
  %v51 = add i64 0, 0
  %st30 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st30
  %v52.p = getelementptr i64, ptr %v50, i64 0
  %v52 = load i64, ptr %v52.p
  %st31 = getelementptr i64, ptr %v0, i64 0
  store i64 %v52, ptr %st31
  %v53.p = getelementptr i64, ptr %v50, i64 1
  %v53 = load i64, ptr %v53.p
  %st32 = getelementptr i64, ptr %v0, i64 1
  store i64 %v53, ptr %st32
  %v54.p = getelementptr i64, ptr %v50, i64 2
  %v54 = load i64, ptr %v54.p
  %st33 = getelementptr i64, ptr %v0, i64 2
  store i64 %v54, ptr %st33
  %v55.p = getelementptr i64, ptr %v50, i64 3
  %v55 = load i64, ptr %v55.p
  %st34 = getelementptr i64, ptr %v0, i64 3
  store i64 %v55, ptr %st34
  %v56.p = getelementptr i64, ptr %v50, i64 4
  %v56 = load i64, ptr %v56.p
  %st35 = getelementptr i64, ptr %v0, i64 4
  store i64 %v56, ptr %st35
  %v57.p = getelementptr i64, ptr %v50, i64 5
  %v57 = load i64, ptr %v57.p
  %st36 = getelementptr i64, ptr %v0, i64 5
  store i64 %v57, ptr %st36
  %v58.p = getelementptr i64, ptr %v0, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 0
  %v60.c = icmp ne i64 %v58, %v59
  %v60 = zext i1 %v60.c to i64
  %c.b5 = icmp ne i64 %v60, 0
  br i1 %c.b5, label %b5.t38, label %b5.e39
b5.t38:
  br label %b6
b5.e39:
  br label %b7
b6:
  %v61 = add i64 0, 3
  %v62 = getelementptr i64, ptr %v0, i64 %v61
  %v66 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v62, i64 %v66, i64 %v10)
  br label %b7
b7:
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v67, i64 0
  store i64 %v10, ptr %st39
  ret void
}

define internal void @"main.handle"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [4 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
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
  %s3 = alloca [5 x i64], align 8
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v42, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 200
  %v7 = getelementptr i64, ptr %s1, i64 0
  %v8 = ptrtoint ptr @"lambda#0" to i64
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st3
  %v9.p = getelementptr i64, ptr %v4, i64 0
  %v9 = load i64, ptr %v9.p
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v9, ptr %st4
  %v10.p = getelementptr i64, ptr %v4, i64 1
  %v10 = load i64, ptr %v10.p
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v10, ptr %st5
  %v11.p = getelementptr i64, ptr %v4, i64 2
  %v11 = load i64, ptr %v11.p
  %st6 = getelementptr i64, ptr %v7, i64 3
  store i64 %v11, ptr %st6
  %v12 = getelementptr i64, ptr %s2, i64 0
  %v13 = add i64 0, 1
  %st7 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st7
  %v14.p = getelementptr i64, ptr %v7, i64 0
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v12, i64 1
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v7, i64 1
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v12, i64 2
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v7, i64 2
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v12, i64 3
  store i64 %v16, ptr %st10
  %v17.p = getelementptr i64, ptr %v7, i64 3
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v12, i64 4
  store i64 %v17, ptr %st11
  %v18 = getelementptr i64, ptr %s3, i64 0
  %v19.p = getelementptr i64, ptr %v12, i64 0
  %v19 = load i64, ptr %v19.p
  %st12 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st12
  %v20.p = getelementptr i64, ptr %v12, i64 1
  %v20 = load i64, ptr %v20.p
  %st13 = getelementptr i64, ptr %v18, i64 1
  store i64 %v20, ptr %st13
  %v21.p = getelementptr i64, ptr %v12, i64 2
  %v21 = load i64, ptr %v21.p
  %st14 = getelementptr i64, ptr %v18, i64 2
  store i64 %v21, ptr %st14
  %v22.p = getelementptr i64, ptr %v12, i64 3
  %v22 = load i64, ptr %v22.p
  %st15 = getelementptr i64, ptr %v18, i64 3
  store i64 %v22, ptr %st15
  %v23.p = getelementptr i64, ptr %v12, i64 4
  %v23 = load i64, ptr %v23.p
  %st16 = getelementptr i64, ptr %v18, i64 4
  store i64 %v23, ptr %st16
  %v24 = getelementptr i64, ptr %s4, i64 0
  %v25 = add i64 0, 0
  %st17 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st17
  %st18 = getelementptr i64, ptr %v24, i64 1
  store i64 %v25, ptr %st18
  %st19 = getelementptr i64, ptr %v24, i64 2
  store i64 %v25, ptr %st19
  %st20 = getelementptr i64, ptr %v24, i64 3
  store i64 %v25, ptr %st20
  %st21 = getelementptr i64, ptr %v24, i64 4
  store i64 %v25, ptr %st21
  %st22 = getelementptr i64, ptr %v24, i64 5
  store i64 %v25, ptr %st22
  %st23 = getelementptr i64, ptr %v24, i64 0
  store i64 %v6, ptr %st23
  %v26.p = getelementptr i64, ptr %v18, i64 0
  %v26 = load i64, ptr %v26.p
  %st24 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st24
  %v27.p = getelementptr i64, ptr %v18, i64 1
  %v27 = load i64, ptr %v27.p
  %st25 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st25
  %v28.p = getelementptr i64, ptr %v18, i64 2
  %v28 = load i64, ptr %v28.p
  %st26 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st26
  %v29.p = getelementptr i64, ptr %v18, i64 3
  %v29 = load i64, ptr %v29.p
  %st27 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st27
  %v30.p = getelementptr i64, ptr %v18, i64 4
  %v30 = load i64, ptr %v30.p
  %st28 = getelementptr i64, ptr %v24, i64 5
  store i64 %v30, ptr %st28
  %v31.p = getelementptr i64, ptr %v24, i64 0
  %v31 = load i64, ptr %v31.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v31, ptr %st29
  %v32.p = getelementptr i64, ptr %v24, i64 1
  %v32 = load i64, ptr %v32.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v32, ptr %st30
  %v33.p = getelementptr i64, ptr %v24, i64 2
  %v33 = load i64, ptr %v33.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v33, ptr %st31
  %v34.p = getelementptr i64, ptr %v24, i64 3
  %v34 = load i64, ptr %v34.p
  %st32 = getelementptr i64, ptr %v0, i64 3
  store i64 %v34, ptr %st32
  %v35.p = getelementptr i64, ptr %v24, i64 4
  %v35 = load i64, ptr %v35.p
  %st33 = getelementptr i64, ptr %v0, i64 4
  store i64 %v35, ptr %st33
  %v36.p = getelementptr i64, ptr %v24, i64 5
  %v36 = load i64, ptr %v36.p
  %st34 = getelementptr i64, ptr %v0, i64 5
  store i64 %v36, ptr %st34
  %v37.p = getelementptr i64, ptr %v0, i64 1
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 0
  %v39.c = icmp ne i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b0 = icmp ne i64 %v39, 0
  br i1 %c.b0, label %b0.t36, label %b0.e37
b0.t36:
  br label %b1
b0.e37:
  br label %b2
b1:
  %v40 = add i64 0, 3
  %v41 = getelementptr i64, ptr %v0, i64 %v40
  call void @"rt.region_relocate8"(ptr %v41, i64 %v5)
  br label %b2
b2:
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v43, i64 0
  store i64 %v5, ptr %st37
  ret void
}

define internal void @"std/net.closeFd"(i64 %v0) #0 {
b0:
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v6, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = add i64 0, 2
  %v3 = add i64 0, 0
  %v4 = add i64 0, 0
  %v5 = call i64 @"rt.netop"(i64 %v2, i64 %v0, i64 %v3, i64 %v4)
  %v7 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  ret void
}

define internal i64 @"rt.netop"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v4 = add i64 0, 0
  %v5 = add i64 0, 1
  %v6.c = icmp eq i64 %v0, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b0 = icmp ne i64 %v6, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v16 = add i64 0, 16384
  %v17 = add i64 0, 44
  %v18 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v17, i64 %v1, i64 %v2, i64 %v3, i64 %v16, i64 %v4, i64 %v4)
  ret i64 %v18
b2:
  %v7 = add i64 0, 3
  %v8.c = icmp eq i64 %v0, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b2 = icmp ne i64 %v8, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b4
b2.e4:
  br label %b5
b3:
  %v19 = add i64 0, 3
  %v20 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v19, i64 %v1)
  %v21.c = icmp sgt i64 %v20, %v4
  %v21 = zext i1 %v21.c to i64
  %v22 = sub i64 %v20, %v4
  %v23 = mul i64 %v21, %v22
  %v24 = sub i64 %v20, %v23
  ret i64 %v24
b4:
  %v13 = add i64 0, 526336
  %v14 = add i64 0, 288
  %v15 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v14, i64 %v1, i64 %v4, i64 %v4, i64 %v13)
  ret i64 %v15
b5:
  %v9 = add i64 0, 6
  %v10.c = icmp eq i64 %v0, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b5 = icmp ne i64 %v10, 0
  br i1 %c.b5, label %b5.t5, label %b5.e6
b5.t5:
  br label %b8
b5.e6:
  br label %b7
b6:
  ret i64 %v4
b7:
  %v11 = add i64 0, 5
  %v12.c = icmp eq i64 %v0, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b7 = icmp ne i64 %v12, 0
  br i1 %c.b7, label %b7.t7, label %b7.e8
b7.t7:
  br label %b6
b7.e8:
  br label %b3
b8:
  ret i64 %v4
}

define internal void @"lambda#0"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [2 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
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
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
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
  %s8 = alloca [6 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s8.z3 = getelementptr i64, ptr %s8, i64 3
  store i64 0, ptr %s8.z3
  %s8.z4 = getelementptr i64, ptr %s8, i64 4
  store i64 0, ptr %s8.z4
  %s8.z5 = getelementptr i64, ptr %s8, i64 5
  store i64 0, ptr %s8.z5
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v2, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v3, ptr %st1
  %v5 = inttoptr i64 %v1 to ptr
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v5, i64 0
  %v7 = load i64, ptr %v7.p
  %st2 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st2
  %v8.p = getelementptr i64, ptr %v5, i64 1
  %v8 = load i64, ptr %v8.p
  %st3 = getelementptr i64, ptr %v6, i64 1
  store i64 %v8, ptr %st3
  %v9.p = getelementptr i64, ptr %v5, i64 2
  %v9 = load i64, ptr %v9.p
  %st4 = getelementptr i64, ptr %v6, i64 2
  store i64 %v9, ptr %st4
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v83, i64 0
  %v10 = load i64, ptr %v10.p
  call void @"rt.region_enter"()
  %v11 = getelementptr i64, ptr %s2, i64 0
  %v12.p = getelementptr i64, ptr %v6, i64 0
  %v12 = load i64, ptr %v12.p
  %st5 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st5
  %v13.p = getelementptr i64, ptr %v6, i64 1
  %v13 = load i64, ptr %v13.p
  %st6 = getelementptr i64, ptr %v11, i64 1
  store i64 %v13, ptr %st6
  %v14.p = getelementptr i64, ptr %v6, i64 2
  %v14 = load i64, ptr %v14.p
  %st7 = getelementptr i64, ptr %v11, i64 2
  store i64 %v14, ptr %st7
  %v15 = add i64 0, 3
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v84, i64 0
  %v17 = load i64, ptr %v17.p
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %v18.p = getelementptr i64, ptr %v85, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr %s4, i64 0
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v86, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = getelementptr i64, ptr %s5, i64 0
  %st8 = getelementptr i64, ptr %v22, i64 0
  store i64 %v19, ptr %st8
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %v23.p = getelementptr i64, ptr %v87, i64 0
  %v23 = load i64, ptr %v23.p
  br label %b4
b1:
  %v72.p = getelementptr i64, ptr %v16, i64 0
  %v72 = load i64, ptr %v72.p
  %st9 = getelementptr i64, ptr %v0, i64 0
  store i64 %v72, ptr %st9
  %v73.p = getelementptr i64, ptr %v16, i64 1
  %v73 = load i64, ptr %v73.p
  %st10 = getelementptr i64, ptr %v0, i64 1
  store i64 %v73, ptr %st10
  %v74.p = getelementptr i64, ptr %v16, i64 2
  %v74 = load i64, ptr %v74.p
  %st11 = getelementptr i64, ptr %v0, i64 2
  store i64 %v74, ptr %st11
  %v75.p = getelementptr i64, ptr %v16, i64 3
  %v75 = load i64, ptr %v75.p
  %st12 = getelementptr i64, ptr %v0, i64 3
  store i64 %v75, ptr %st12
  %v76.p = getelementptr i64, ptr %v16, i64 4
  %v76 = load i64, ptr %v76.p
  %st13 = getelementptr i64, ptr %v0, i64 4
  store i64 %v76, ptr %st13
  %v77.p = getelementptr i64, ptr %v16, i64 5
  %v77 = load i64, ptr %v77.p
  %st14 = getelementptr i64, ptr %v0, i64 5
  store i64 %v77, ptr %st14
  %v78.p = getelementptr i64, ptr %v0, i64 0
  %v78 = load i64, ptr %v78.p
  %v79 = add i64 0, 0
  %v80.c = icmp ne i64 %v78, %v79
  %v80 = zext i1 %v80.c to i64
  %c.b1 = icmp ne i64 %v80, 0
  br i1 %c.b1, label %b1.t16, label %b1.e17
b1.t16:
  br label %b14
b1.e17:
  br label %b15
b2:
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v88, i64 0
  store i64 %v18, ptr %st17
  %v59 = getelementptr i64, ptr %s8, i64 0
  %v60 = add i64 0, 0
  %st18 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st18
  %v61.p = getelementptr i64, ptr %v59, i64 0
  %v61 = load i64, ptr %v61.p
  %st19 = getelementptr i64, ptr %v16, i64 0
  store i64 %v61, ptr %st19
  %v62.p = getelementptr i64, ptr %v59, i64 1
  %v62 = load i64, ptr %v62.p
  %st20 = getelementptr i64, ptr %v16, i64 1
  store i64 %v62, ptr %st20
  %v63.p = getelementptr i64, ptr %v59, i64 2
  %v63 = load i64, ptr %v63.p
  %st21 = getelementptr i64, ptr %v16, i64 2
  store i64 %v63, ptr %st21
  %v64.p = getelementptr i64, ptr %v59, i64 3
  %v64 = load i64, ptr %v64.p
  %st22 = getelementptr i64, ptr %v16, i64 3
  store i64 %v64, ptr %st22
  %v65.p = getelementptr i64, ptr %v59, i64 4
  %v65 = load i64, ptr %v65.p
  %st23 = getelementptr i64, ptr %v16, i64 4
  store i64 %v65, ptr %st23
  %v66.p = getelementptr i64, ptr %v59, i64 5
  %v66 = load i64, ptr %v66.p
  %st24 = getelementptr i64, ptr %v16, i64 5
  store i64 %v66, ptr %st24
  %v67.p = getelementptr i64, ptr %v16, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 0
  %v69.c = icmp ne i64 %v67, %v68
  %v69 = zext i1 %v69.c to i64
  %c.b2 = icmp ne i64 %v69, 0
  br i1 %c.b2, label %b2.t26, label %b2.e27
b2.t26:
  br label %b12
b2.e27:
  br label %b13
b3:
  br label %b2
b4:
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v89, i64 0
  store i64 %v23, ptr %st27
  %v24.p = getelementptr i64, ptr %v22, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp slt i64 %v24, %v15
  %v25 = zext i1 %v25.c to i64
  %c.b4 = icmp ne i64 %v25, 0
  br i1 %c.b4, label %b4.t29, label %b4.e30
b4.t29:
  br label %b5
b4.e30:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v90, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v22, i64 0
  %v27 = load i64, ptr %v27.p
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v91, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = getelementptr i64, ptr %s6, i64 0
  %v30.p = getelementptr i64, ptr %v11, i64 0
  %v30 = load i64, ptr %v30.p
  %st30 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st30
  %v31.p = getelementptr i64, ptr %v11, i64 1
  %v31 = load i64, ptr %v31.p
  %st31 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st31
  %v32.p = getelementptr i64, ptr %v11, i64 2
  %v32 = load i64, ptr %v32.p
  %st32 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st32
  %v33.p = getelementptr i64, ptr %v4, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 0, 1
  %v35 = getelementptr i64, ptr %v4, i64 %v34
  %v36 = ptrtoint ptr %v35 to i64
  %v37 = getelementptr i64, ptr %s7, i64 0
  %v38.p = getelementptr i64, ptr %v29, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v29, i64 1
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v29, i64 2
  %v40 = load i64, ptr %v40.p
  %fp33 = inttoptr i64 %v33 to ptr
  call void %fp33(ptr %v37, i64 %v36, i64 %v38, i64 %v39, i64 %v40)
  %v41.p = getelementptr i64, ptr %v37, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 0
  %v43.c = icmp ne i64 %v41, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b5 = icmp ne i64 %v43, 0
  br i1 %c.b5, label %b5.t35, label %b5.e36
b5.t35:
  br label %b8
b5.e36:
  br label %b9
b6:
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %st36 = getelementptr i64, ptr %v92, i64 0
  store i64 %v23, ptr %st36
  br label %b3
b7:
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v93, i64 0
  store i64 %v28, ptr %st37
  %v56 = add i64 0, 1
  %v57.p = getelementptr i64, ptr %v22, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 %v57, %v56
  %st38 = getelementptr i64, ptr %v22, i64 0
  store i64 %v58, ptr %st38
  br label %b4
b8:
  %v44 = add i64 0, 0
  %v45.p = getelementptr i64, ptr %v37, i64 0
  %v45 = load i64, ptr %v45.p
  %st39 = getelementptr i64, ptr %v16, i64 0
  store i64 %v45, ptr %st39
  %v46.p = getelementptr i64, ptr %v37, i64 1
  %v46 = load i64, ptr %v46.p
  %st40 = getelementptr i64, ptr %v16, i64 1
  store i64 %v46, ptr %st40
  %v47.p = getelementptr i64, ptr %v37, i64 2
  %v47 = load i64, ptr %v47.p
  %st41 = getelementptr i64, ptr %v16, i64 2
  store i64 %v47, ptr %st41
  %v48.p = getelementptr i64, ptr %v37, i64 3
  %v48 = load i64, ptr %v48.p
  %st42 = getelementptr i64, ptr %v16, i64 3
  store i64 %v48, ptr %st42
  %v49.p = getelementptr i64, ptr %v37, i64 4
  %v49 = load i64, ptr %v49.p
  %st43 = getelementptr i64, ptr %v16, i64 4
  store i64 %v49, ptr %st43
  %v50.p = getelementptr i64, ptr %v37, i64 5
  %v50 = load i64, ptr %v50.p
  %st44 = getelementptr i64, ptr %v16, i64 5
  store i64 %v50, ptr %st44
  %v51.p = getelementptr i64, ptr %v16, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp ne i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b8 = icmp ne i64 %v53, 0
  br i1 %c.b8, label %b8.t46, label %b8.e47
b8.t46:
  br label %b10
b8.e47:
  br label %b11
b9:
  br label %b7
b10:
  %v54 = add i64 0, 3
  %v55 = getelementptr i64, ptr %v16, i64 %v54
  %v94 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v55, i64 %v94, i64 %v17)
  br label %b11
b11:
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v95, i64 0
  store i64 %v17, ptr %st47
  br label %b1
b12:
  %v70 = add i64 0, 3
  %v71 = getelementptr i64, ptr %v16, i64 %v70
  %v96 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v71, i64 %v96, i64 %v17)
  br label %b13
b13:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v97, i64 0
  store i64 %v17, ptr %st48
  br label %b1
b14:
  %v81 = add i64 0, 3
  %v82 = getelementptr i64, ptr %v0, i64 %v81
  %v98 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v82, i64 %v98, i64 %v10)
  br label %b15
b15:
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v99, i64 0
  store i64 %v10, ptr %st49
  ret void
}

define internal void @"lambda#1"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
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
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v2, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v3, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v4, ptr %st2
  %v6 = inttoptr i64 %v1 to ptr
  %v7 = getelementptr i64, ptr %s1, i64 0
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st3
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v26, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v7, i64 0
  %v11 = load i64, ptr %v11.p
  %v12.p = getelementptr i64, ptr %v5, i64 0
  %v12 = load i64, ptr %v12.p
  %v13.p = getelementptr i64, ptr %v5, i64 1
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v5, i64 2
  %v14 = load i64, ptr %v14.p
  call void @"std/net.Send"(ptr %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14)
  %v15.p = getelementptr i64, ptr %v10, i64 0
  %v15 = load i64, ptr %v15.p
  %st4 = getelementptr i64, ptr %v0, i64 0
  store i64 %v15, ptr %st4
  %v16.p = getelementptr i64, ptr %v10, i64 1
  %v16 = load i64, ptr %v16.p
  %st5 = getelementptr i64, ptr %v0, i64 1
  store i64 %v16, ptr %st5
  %v17.p = getelementptr i64, ptr %v10, i64 2
  %v17 = load i64, ptr %v17.p
  %st6 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st6
  %v18.p = getelementptr i64, ptr %v10, i64 3
  %v18 = load i64, ptr %v18.p
  %st7 = getelementptr i64, ptr %v0, i64 3
  store i64 %v18, ptr %st7
  %v19.p = getelementptr i64, ptr %v10, i64 4
  %v19 = load i64, ptr %v19.p
  %st8 = getelementptr i64, ptr %v0, i64 4
  store i64 %v19, ptr %st8
  %v20.p = getelementptr i64, ptr %v10, i64 5
  %v20 = load i64, ptr %v20.p
  %st9 = getelementptr i64, ptr %v0, i64 5
  store i64 %v20, ptr %st9
  %v21.p = getelementptr i64, ptr %v0, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 0, 0
  %v23.c = icmp ne i64 %v21, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b0 = icmp ne i64 %v23, 0
  br i1 %c.b0, label %b0.t11, label %b0.e12
b0.t11:
  br label %b1
b0.e12:
  br label %b2
b1:
  %v24 = add i64 0, 3
  %v25 = getelementptr i64, ptr %v0, i64 %v24
  %v27 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v25, i64 %v27, i64 %v9)
  br label %b2
b2:
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v28, i64 0
  store i64 %v9, ptr %st12
  ret void
}

define internal void @"std/net.Send"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [3 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s2 = alloca [2 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s3 = alloca [5 x i64], align 8
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
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [5 x i64], align 8
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
  %s7 = alloca [5 x i64], align 8
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
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %v6 = getelementptr i64, ptr %s1, i64 0
  %st1 = getelementptr i64, ptr %v6, i64 0
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 1
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v6, i64 2
  store i64 %v4, ptr %st3
  %v119 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v119, i64 0
  %v7 = load i64, ptr %v7.p
  call void @"rt.region_enter"()
  %v8 = add i64 0, 0
  %v9 = add i64 0, 0
  %v10.c = icmp ne i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v11 = getelementptr i64, ptr %s2, i64 0
  %v12 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st6
  %st7 = getelementptr i64, ptr %v11, i64 1
  store i64 %v12, ptr %st7
  %v13 = add i64 0, 9
  %st8 = getelementptr i64, ptr %v11, i64 0
  store i64 %v13, ptr %st8
  %v14 = getelementptr i64, ptr %s3, i64 0
  %v15.p = getelementptr i64, ptr %v11, i64 0
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v11, i64 1
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st10
  %v17 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st11
  %st12 = getelementptr i64, ptr %v14, i64 3
  store i64 %v17, ptr %st12
  %st13 = getelementptr i64, ptr %v14, i64 4
  store i64 %v17, ptr %st13
  %v18 = getelementptr i64, ptr %s4, i64 0
  %v19 = add i64 0, 1
  %st14 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st14
  %v20.p = getelementptr i64, ptr %v14, i64 0
  %v20 = load i64, ptr %v20.p
  %st15 = getelementptr i64, ptr %v18, i64 1
  store i64 %v20, ptr %st15
  %v21.p = getelementptr i64, ptr %v14, i64 1
  %v21 = load i64, ptr %v21.p
  %st16 = getelementptr i64, ptr %v18, i64 2
  store i64 %v21, ptr %st16
  %v22.p = getelementptr i64, ptr %v14, i64 2
  %v22 = load i64, ptr %v22.p
  %st17 = getelementptr i64, ptr %v18, i64 3
  store i64 %v22, ptr %st17
  %v23.p = getelementptr i64, ptr %v14, i64 3
  %v23 = load i64, ptr %v23.p
  %st18 = getelementptr i64, ptr %v18, i64 4
  store i64 %v23, ptr %st18
  %v24.p = getelementptr i64, ptr %v14, i64 4
  %v24 = load i64, ptr %v24.p
  %st19 = getelementptr i64, ptr %v18, i64 5
  store i64 %v24, ptr %st19
  %v25.p = getelementptr i64, ptr %v18, i64 0
  %v25 = load i64, ptr %v25.p
  %st20 = getelementptr i64, ptr %v0, i64 0
  store i64 %v25, ptr %st20
  %v26.p = getelementptr i64, ptr %v18, i64 1
  %v26 = load i64, ptr %v26.p
  %st21 = getelementptr i64, ptr %v0, i64 1
  store i64 %v26, ptr %st21
  %v27.p = getelementptr i64, ptr %v18, i64 2
  %v27 = load i64, ptr %v27.p
  %st22 = getelementptr i64, ptr %v0, i64 2
  store i64 %v27, ptr %st22
  %v28.p = getelementptr i64, ptr %v18, i64 3
  %v28 = load i64, ptr %v28.p
  %st23 = getelementptr i64, ptr %v0, i64 3
  store i64 %v28, ptr %st23
  %v29.p = getelementptr i64, ptr %v18, i64 4
  %v29 = load i64, ptr %v29.p
  %st24 = getelementptr i64, ptr %v0, i64 4
  store i64 %v29, ptr %st24
  %v30.p = getelementptr i64, ptr %v18, i64 5
  %v30 = load i64, ptr %v30.p
  %st25 = getelementptr i64, ptr %v0, i64 5
  store i64 %v30, ptr %st25
  %v31.p = getelementptr i64, ptr %v0, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 0, 0
  %v33.c = icmp ne i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b1 = icmp ne i64 %v33, 0
  br i1 %c.b1, label %b1.t27, label %b1.e28
b1.t27:
  br label %b3
b1.e28:
  br label %b4
b2:
  br label %b5
b3:
  %v34 = add i64 0, 3
  %v35 = getelementptr i64, ptr %v0, i64 %v34
  %v120 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v35, i64 %v120, i64 %v7)
  br label %b4
b4:
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v121, i64 0
  store i64 %v7, ptr %st28
  ret void
b5:
  %v36 = add i64 0, 0
  %v37 = getelementptr i64, ptr %s5, i64 0
  %st29 = getelementptr i64, ptr %v37, i64 0
  store i64 %v36, ptr %st29
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v122, i64 0
  %v38 = load i64, ptr %v38.p
  br label %b6
b6:
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v123, i64 0
  store i64 %v38, ptr %st30
  %v39.p = getelementptr i64, ptr %v37, i64 0
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v6, i64 1
  %v40 = load i64, ptr %v40.p
  %v41.c = icmp slt i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b6 = icmp ne i64 %v41, 0
  br i1 %c.b6, label %b6.t32, label %b6.e33
b6.t32:
  br label %b7
b6.e33:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v124, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 0, 1
  %v44.p = getelementptr i64, ptr %v5, i64 0
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v6, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v37, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 %v45, %v46
  %v48.p = getelementptr i64, ptr %v6, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v37, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = sub i64 %v48, %v49
  %v51 = call i64 @"rt.netop"(i64 %v43, i64 %v44, i64 %v47, i64 %v50)
  %v52.p = getelementptr i64, ptr %v5, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 4
  %v54 = call i64 @"std/net.again"(i64 %v51, i64 %v52, i64 %v53)
  %v55 = add i64 0, 0
  %v56.c = icmp slt i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b7 = icmp ne i64 %v56, 0
  br i1 %c.b7, label %b7.t34, label %b7.e35
b7.t34:
  br label %b9
b7.e35:
  br label %b10
b8:
  %v125 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v125, i64 0
  store i64 %v38, ptr %st35
  %v106 = getelementptr i64, ptr %s4, i64 0
  %v107 = add i64 0, 0
  %st36 = getelementptr i64, ptr %v106, i64 0
  store i64 %v107, ptr %st36
  %v108.p = getelementptr i64, ptr %v106, i64 0
  %v108 = load i64, ptr %v108.p
  %st37 = getelementptr i64, ptr %v0, i64 0
  store i64 %v108, ptr %st37
  %v109.p = getelementptr i64, ptr %v106, i64 1
  %v109 = load i64, ptr %v109.p
  %st38 = getelementptr i64, ptr %v0, i64 1
  store i64 %v109, ptr %st38
  %v110.p = getelementptr i64, ptr %v106, i64 2
  %v110 = load i64, ptr %v110.p
  %st39 = getelementptr i64, ptr %v0, i64 2
  store i64 %v110, ptr %st39
  %v111.p = getelementptr i64, ptr %v106, i64 3
  %v111 = load i64, ptr %v111.p
  %st40 = getelementptr i64, ptr %v0, i64 3
  store i64 %v111, ptr %st40
  %v112.p = getelementptr i64, ptr %v106, i64 4
  %v112 = load i64, ptr %v112.p
  %st41 = getelementptr i64, ptr %v0, i64 4
  store i64 %v112, ptr %st41
  %v113.p = getelementptr i64, ptr %v106, i64 5
  %v113 = load i64, ptr %v113.p
  %st42 = getelementptr i64, ptr %v0, i64 5
  store i64 %v113, ptr %st42
  %v114.p = getelementptr i64, ptr %v0, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp ne i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b8 = icmp ne i64 %v116, 0
  br i1 %c.b8, label %b8.t44, label %b8.e45
b8.t44:
  br label %b24
b8.e45:
  br label %b25
b9:
  %v57 = getelementptr i64, ptr %s6, i64 0
  call void @"std/net.waitErr"(ptr %v57, i64 %v54)
  %v58 = getelementptr i64, ptr %s4, i64 0
  %v59 = add i64 0, 1
  %st45 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st45
  %v60.p = getelementptr i64, ptr %v57, i64 0
  %v60 = load i64, ptr %v60.p
  %st46 = getelementptr i64, ptr %v58, i64 1
  store i64 %v60, ptr %st46
  %v61.p = getelementptr i64, ptr %v57, i64 1
  %v61 = load i64, ptr %v61.p
  %st47 = getelementptr i64, ptr %v58, i64 2
  store i64 %v61, ptr %st47
  %v62.p = getelementptr i64, ptr %v57, i64 2
  %v62 = load i64, ptr %v62.p
  %st48 = getelementptr i64, ptr %v58, i64 3
  store i64 %v62, ptr %st48
  %v63.p = getelementptr i64, ptr %v57, i64 3
  %v63 = load i64, ptr %v63.p
  %st49 = getelementptr i64, ptr %v58, i64 4
  store i64 %v63, ptr %st49
  %v64.p = getelementptr i64, ptr %v57, i64 4
  %v64 = load i64, ptr %v64.p
  %st50 = getelementptr i64, ptr %v58, i64 5
  store i64 %v64, ptr %st50
  %v65.p = getelementptr i64, ptr %v58, i64 0
  %v65 = load i64, ptr %v65.p
  %st51 = getelementptr i64, ptr %v0, i64 0
  store i64 %v65, ptr %st51
  %v66.p = getelementptr i64, ptr %v58, i64 1
  %v66 = load i64, ptr %v66.p
  %st52 = getelementptr i64, ptr %v0, i64 1
  store i64 %v66, ptr %st52
  %v67.p = getelementptr i64, ptr %v58, i64 2
  %v67 = load i64, ptr %v67.p
  %st53 = getelementptr i64, ptr %v0, i64 2
  store i64 %v67, ptr %st53
  %v68.p = getelementptr i64, ptr %v58, i64 3
  %v68 = load i64, ptr %v68.p
  %st54 = getelementptr i64, ptr %v0, i64 3
  store i64 %v68, ptr %st54
  %v69.p = getelementptr i64, ptr %v58, i64 4
  %v69 = load i64, ptr %v69.p
  %st55 = getelementptr i64, ptr %v0, i64 4
  store i64 %v69, ptr %st55
  %v70.p = getelementptr i64, ptr %v58, i64 5
  %v70 = load i64, ptr %v70.p
  %st56 = getelementptr i64, ptr %v0, i64 5
  store i64 %v70, ptr %st56
  %v71.p = getelementptr i64, ptr %v0, i64 0
  %v71 = load i64, ptr %v71.p
  %v72 = add i64 0, 0
  %v73.c = icmp ne i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b9 = icmp ne i64 %v73, 0
  br i1 %c.b9, label %b9.t58, label %b9.e59
b9.t58:
  br label %b11
b9.e59:
  br label %b12
b10:
  br label %b13
b11:
  %v74 = add i64 0, 3
  %v75 = getelementptr i64, ptr %v0, i64 %v74
  %v126 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v75, i64 %v126, i64 %v7)
  br label %b12
b12:
  %v127 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v127, i64 0
  store i64 %v7, ptr %st59
  ret void
b13:
  %v76 = add i64 0, 1
  %v77.c = icmp eq i64 %v54, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b13 = icmp ne i64 %v77, 0
  br i1 %c.b13, label %b13.t61, label %b13.e62
b13.t61:
  br label %b14
b13.e62:
  br label %b15
b14:
  %v79 = add i64 0, 0
  %v80.c = icmp slt i64 %v51, %v79
  %v80 = zext i1 %v80.c to i64
  br label %b15
b15:
  %v78 = phi i64 [ %v77, %b13.e62 ], [ %v80, %b14 ]
  %c.b15 = icmp ne i64 %v78, 0
  br i1 %c.b15, label %b15.t63, label %b15.e64
b15.t63:
  br label %b16
b15.e64:
  br label %b17
b16:
  %v81 = getelementptr i64, ptr %s7, i64 0
  %v82 = add i64 0, 0
  %v83 = sub i64 %v82, %v51
  call void @"std/net.errOf"(ptr %v81, i64 %v83)
  %v84 = getelementptr i64, ptr %s4, i64 0
  %v85 = add i64 0, 1
  %st64 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st64
  %v86.p = getelementptr i64, ptr %v81, i64 0
  %v86 = load i64, ptr %v86.p
  %st65 = getelementptr i64, ptr %v84, i64 1
  store i64 %v86, ptr %st65
  %v87.p = getelementptr i64, ptr %v81, i64 1
  %v87 = load i64, ptr %v87.p
  %st66 = getelementptr i64, ptr %v84, i64 2
  store i64 %v87, ptr %st66
  %v88.p = getelementptr i64, ptr %v81, i64 2
  %v88 = load i64, ptr %v88.p
  %st67 = getelementptr i64, ptr %v84, i64 3
  store i64 %v88, ptr %st67
  %v89.p = getelementptr i64, ptr %v81, i64 3
  %v89 = load i64, ptr %v89.p
  %st68 = getelementptr i64, ptr %v84, i64 4
  store i64 %v89, ptr %st68
  %v90.p = getelementptr i64, ptr %v81, i64 4
  %v90 = load i64, ptr %v90.p
  %st69 = getelementptr i64, ptr %v84, i64 5
  store i64 %v90, ptr %st69
  %v91.p = getelementptr i64, ptr %v84, i64 0
  %v91 = load i64, ptr %v91.p
  %st70 = getelementptr i64, ptr %v0, i64 0
  store i64 %v91, ptr %st70
  %v92.p = getelementptr i64, ptr %v84, i64 1
  %v92 = load i64, ptr %v92.p
  %st71 = getelementptr i64, ptr %v0, i64 1
  store i64 %v92, ptr %st71
  %v93.p = getelementptr i64, ptr %v84, i64 2
  %v93 = load i64, ptr %v93.p
  %st72 = getelementptr i64, ptr %v0, i64 2
  store i64 %v93, ptr %st72
  %v94.p = getelementptr i64, ptr %v84, i64 3
  %v94 = load i64, ptr %v94.p
  %st73 = getelementptr i64, ptr %v0, i64 3
  store i64 %v94, ptr %st73
  %v95.p = getelementptr i64, ptr %v84, i64 4
  %v95 = load i64, ptr %v95.p
  %st74 = getelementptr i64, ptr %v0, i64 4
  store i64 %v95, ptr %st74
  %v96.p = getelementptr i64, ptr %v84, i64 5
  %v96 = load i64, ptr %v96.p
  %st75 = getelementptr i64, ptr %v0, i64 5
  store i64 %v96, ptr %st75
  %v97.p = getelementptr i64, ptr %v0, i64 0
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 0, 0
  %v99.c = icmp ne i64 %v97, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b16 = icmp ne i64 %v99, 0
  br i1 %c.b16, label %b16.t77, label %b16.e78
b16.t77:
  br label %b18
b16.e78:
  br label %b19
b17:
  br label %b20
b18:
  %v100 = add i64 0, 3
  %v101 = getelementptr i64, ptr %v0, i64 %v100
  %v128 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v101, i64 %v128, i64 %v7)
  br label %b19
b19:
  %v129 = getelementptr i64, ptr @"rt.meta", i64 0
  %st78 = getelementptr i64, ptr %v129, i64 0
  store i64 %v7, ptr %st78
  ret void
b20:
  %v102 = add i64 0, 0
  %v103.c = icmp sgt i64 %v51, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b20 = icmp ne i64 %v103, 0
  br i1 %c.b20, label %b20.t80, label %b20.e81
b20.t80:
  br label %b21
b20.e81:
  br label %b22
b21:
  %v104.p = getelementptr i64, ptr %v37, i64 0
  %v104 = load i64, ptr %v104.p
  %v105 = add i64 %v104, %v51
  %st81 = getelementptr i64, ptr %v37, i64 0
  store i64 %v105, ptr %st81
  br label %b23
b22:
  br label %b23
b23:
  br label %b6
b24:
  %v117 = add i64 0, 3
  %v118 = getelementptr i64, ptr %v0, i64 %v117
  %v130 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v118, i64 %v130, i64 %v7)
  br label %b25
b25:
  %v131 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v131, i64 0
  store i64 %v7, ptr %st82
  ret void
}

define internal i64 @"rt.fdwait"(i64 %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v2 = add i64 0, 0
  %v3 = getelementptr i64, ptr %s0, i64 0
  %v4 = add i64 0, 32
  %v5.n = and i64 %v4, 63
  %v5 = shl i64 %v1, %v5.n
  %v6 = or i64 %v0, %v5
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v6, ptr %st0
  %v7 = ptrtoint ptr %v3 to i64
  %v8 = add i64 0, 1
  %v9 = add i64 0, -1
  %v10 = add i64 0, 7
  %v11 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v10, i64 %v7, i64 %v8, i64 %v9)
  %v12.c = icmp sgt i64 %v11, %v2
  %v12 = zext i1 %v12.c to i64
  %v13 = sub i64 %v11, %v2
  %v14 = mul i64 %v12, %v13
  %v15 = sub i64 %v11, %v14
  ret i64 %v15
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
  %v25 = add i64 0, 2
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
  %v69 = add i64 0, 3
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
  %v125 = add i64 0, 4
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
