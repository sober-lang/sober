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
@"str.0" = internal constant [1 x i64] [i64 5136718]
@"str.1" = internal constant [1 x i64] [i64 1718503723]
@"str.2" = internal constant [1 x i64] [i64 1718503725]
@"str.3" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.4" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.5" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.6" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.7" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.8" = internal constant [1 x i64] [i64 2685]
@"str.9" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.10" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.11" = internal constant [1 x i64] [i64 35899498962976]
@"str.12" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.13" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [42 x i64] [i64 3659174932119553, i64 4503599946137601, i64 9007199590285313, i64 4785074922848516, i64 11258999806624001, i64 8725725016228099, i64 13510799687418113, i64 10977524897022211, i64 9851625191506179, i64 9851625208283395, i64 9851625241837827, i64 8725725368549635, i64 16044074863689985, i64 9851625376055555, i64 18858824798568705, i64 9851625543827715, i64 4222127502786820, i64 4222127687336196, i64 8162777797492993, i64 7881302904668417, i64 12947853307543812, i64 24206852375970052, i64 4222133710356740, i64 6755408836296961, i64 4222134180118785, i64 2814759313342721, i64 4222134465331457, i64 10977533906387201, i64 2814759598555393, i64 5629509617320193, i64 6755409524162820, i64 3940659773833473, i64 7881309682663681, i64 6192460527042817, i64 3659186105745665, i64 5910985919430913, i64 6755410866340097, i64 8725735703314689, i64 4222136260493569, i64 10977535701549313, i64 3940661317337345, i64 3940661367668993]
@"str.14" = internal constant [1 x i64] [i64 9071397899755888]
@"str.15" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.16" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.17" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.18" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.19" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.20" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.21" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.22" = internal constant [1 x i64] [i64 544497952]
@"str.23" = internal constant [3 x i64] [i64 8027208339290025062, i64 7023475079533129074, i64 8243102923784877155]
@"str.24" = internal constant [5 x i64] [i64 7310589493174891635, i64 8028904589562572402, i64 7810982780818846817, i64 8299699176509563247, i64 1919246959]

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
  %v3 = getelementptr i64, ptr @"str.3", i64 0
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
  %v29 = getelementptr i64, ptr @"str.7", i64 0
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
  %v35 = getelementptr i64, ptr @"str.8", i64 0
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
  %v10 = getelementptr i64, ptr @"str.4", i64 0
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
  %v17 = getelementptr i64, ptr @"str.5", i64 0
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
  %v24 = getelementptr i64, ptr @"str.6", i64 0
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
  %v60 = getelementptr i64, ptr @"str.9", i64 0
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
  %v65 = getelementptr i64, ptr @"str.10", i64 0
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
  %v70 = getelementptr i64, ptr @"str.8", i64 0
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
  %v81 = getelementptr i64, ptr @"str.11", i64 0
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
  %v88 = getelementptr i64, ptr @"str.12", i64 0
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
  %v17 = getelementptr i64, ptr @"str.13", i64 0
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
  %v22 = getelementptr i64, ptr @"str.8", i64 0
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

define internal i64 @"main.main"() #0 {
b0:
  %s0 = alloca [9 x i64], align 8
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
  %s0.z6 = getelementptr i64, ptr %s0, i64 6
  store i64 0, ptr %s0.z6
  %s0.z7 = getelementptr i64, ptr %s0, i64 7
  store i64 0, ptr %s0.z7
  %s0.z8 = getelementptr i64, ptr %s0, i64 8
  store i64 0, ptr %s0.z8
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
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
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
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v99, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  call void @"std/io.ReadStdin"(ptr %v1)
  %v2 = add i64 0, 3
  %v3 = getelementptr i64, ptr %v1, i64 %v2
  %v4 = getelementptr i64, ptr %s1, i64 0
  %v5.p = getelementptr i64, ptr %v1, i64 0
  %v5 = load i64, ptr %v5.p
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v5, ptr %st0
  %v6.p = getelementptr i64, ptr %v1, i64 1
  %v6 = load i64, ptr %v6.p
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v6, ptr %st1
  %v7.p = getelementptr i64, ptr %v1, i64 2
  %v7 = load i64, ptr %v7.p
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v7, ptr %st2
  %v8 = getelementptr i64, ptr %s2, i64 0
  %v9.p = getelementptr i64, ptr %v3, i64 0
  %v9 = load i64, ptr %v9.p
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st3
  %v10.p = getelementptr i64, ptr %v3, i64 1
  %v10 = load i64, ptr %v10.p
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v10, ptr %st4
  %v11.p = getelementptr i64, ptr %v3, i64 2
  %v11 = load i64, ptr %v11.p
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v11, ptr %st5
  %v12.p = getelementptr i64, ptr %v3, i64 3
  %v12 = load i64, ptr %v12.p
  %st6 = getelementptr i64, ptr %v8, i64 3
  store i64 %v12, ptr %st6
  %v13.p = getelementptr i64, ptr %v3, i64 4
  %v13 = load i64, ptr %v13.p
  %st7 = getelementptr i64, ptr %v8, i64 4
  store i64 %v13, ptr %st7
  %v14.p = getelementptr i64, ptr %v3, i64 5
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v8, i64 5
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v8, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 0
  %v17.c = icmp ne i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b0 = icmp ne i64 %v17, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v18 = add i64 0, 1
  %v19 = getelementptr i64, ptr %v8, i64 %v18
  %v20 = getelementptr i64, ptr %s3, i64 0
  %v21.p = getelementptr i64, ptr %v19, i64 0
  %v21 = load i64, ptr %v21.p
  %st11 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st11
  %v22.p = getelementptr i64, ptr %v19, i64 1
  %v22 = load i64, ptr %v22.p
  %st12 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st12
  %v23.p = getelementptr i64, ptr %v19, i64 2
  %v23 = load i64, ptr %v23.p
  %st13 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st13
  %v24.p = getelementptr i64, ptr %v19, i64 3
  %v24 = load i64, ptr %v24.p
  %st14 = getelementptr i64, ptr %v20, i64 3
  store i64 %v24, ptr %st14
  %v25.p = getelementptr i64, ptr %v19, i64 4
  %v25 = load i64, ptr %v25.p
  %st15 = getelementptr i64, ptr %v20, i64 4
  store i64 %v25, ptr %st15
  %v26 = add i64 0, 1
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v100, i64 0
  store i64 %v0, ptr %st16
  ret i64 %v26
b2:
  br label %b3
b3:
  %v27 = phi ptr [ %v4, %b2 ]
  %v28 = getelementptr i64, ptr %s4, i64 0
  %v29.p = getelementptr i64, ptr %v27, i64 0
  %v29 = load i64, ptr %v29.p
  %st17 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st17
  %v30.p = getelementptr i64, ptr %v27, i64 1
  %v30 = load i64, ptr %v30.p
  %st18 = getelementptr i64, ptr %v28, i64 1
  store i64 %v30, ptr %st18
  %v31.p = getelementptr i64, ptr %v27, i64 2
  %v31 = load i64, ptr %v31.p
  %st19 = getelementptr i64, ptr %v28, i64 2
  store i64 %v31, ptr %st19
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s5, i64 0
  %st20 = getelementptr i64, ptr %v33, i64 0
  store i64 %v32, ptr %st20
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v101, i64 0
  %v34 = load i64, ptr %v34.p
  br label %b4
b4:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v102, i64 0
  store i64 %v34, ptr %st21
  %v35.p = getelementptr i64, ptr %v33, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v28, i64 1
  %v36 = load i64, ptr %v36.p
  %v37.c = icmp slt i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b4 = icmp ne i64 %v37, 0
  br i1 %c.b4, label %b4.t23, label %b4.e24
b4.t23:
  br label %b5
b4.e24:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v103, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40 = getelementptr i64, ptr %s6, i64 0
  %st24 = getelementptr i64, ptr %v40, i64 0
  store i64 %v39, ptr %st24
  %v41.p = getelementptr i64, ptr %v33, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v28, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.c = icmp uge i64 %v41, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b5 = icmp ne i64 %v43, 0
  br i1 %c.b5, label %b5.t26, label %b5.e27
b5.t26:
  br label %b7
b5.e27:
  br label %b8
b6:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v104, i64 0
  store i64 %v34, ptr %st27
  %v98 = add i64 0, 0
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v105, i64 0
  store i64 %v0, ptr %st28
  ret i64 %v98
b7:
  %v44 = add i64 0, 0
  call void @"rt.panic"(i64 %v44)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v45.p = getelementptr i64, ptr %v28, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = inttoptr i64 %v45 to ptr
  %v47 = getelementptr i8, ptr %v46, i64 %v41
  %v48.p = getelementptr i8, ptr %v47, i64 0
  %v48.b = load i8, ptr %v48.p
  %v48 = zext i8 %v48.b to i64
  %v49 = add i64 0, 45
  %v50.c = icmp eq i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b8 = icmp ne i64 %v50, 0
  br i1 %c.b8, label %b8.t30, label %b8.e31
b8.t30:
  br label %b9
b8.e31:
  br label %b10
b9:
  %v51 = add i64 0, 1
  %st31 = getelementptr i64, ptr %v40, i64 0
  store i64 %v51, ptr %st31
  %v52 = add i64 0, 1
  %v53.p = getelementptr i64, ptr %v33, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 %v53, %v52
  %st32 = getelementptr i64, ptr %v33, i64 0
  store i64 %v54, ptr %st32
  br label %b11
b10:
  br label %b11
b11:
  %v55 = add i64 0, 0
  %v56 = getelementptr i64, ptr %s7, i64 0
  %st33 = getelementptr i64, ptr %v56, i64 0
  store i64 %v55, ptr %st33
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v106, i64 0
  %v57 = load i64, ptr %v57.p
  br label %b12
b12:
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v107, i64 0
  store i64 %v57, ptr %st34
  %v58.p = getelementptr i64, ptr %v33, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v28, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.c = icmp uge i64 %v58, %v59
  %v60 = zext i1 %v60.c to i64
  %c.b12 = icmp ne i64 %v60, 0
  br i1 %c.b12, label %b12.t36, label %b12.e37
b12.t36:
  br label %b15
b12.e37:
  br label %b16
b13:
  call void @"rt.region_enter"()
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %v68.p = getelementptr i64, ptr %v108, i64 0
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v56, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 10
  %v71 = mul i64 %v69, %v70
  %v72.p = getelementptr i64, ptr %v33, i64 0
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v28, i64 1
  %v73 = load i64, ptr %v73.p
  %v74.c = icmp uge i64 %v72, %v73
  %v74 = zext i1 %v74.c to i64
  %c.b13 = icmp ne i64 %v74, 0
  br i1 %c.b13, label %b13.t38, label %b13.e39
b13.t38:
  br label %b17
b13.e39:
  br label %b18
b14:
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v109, i64 0
  store i64 %v57, ptr %st39
  %v86 = getelementptr i64, ptr %s8, i64 0
  %v87.p = getelementptr i64, ptr %v40, i64 0
  %v87 = load i64, ptr %v87.p
  %c.b14 = icmp ne i64 %v87, 0
  br i1 %c.b14, label %b14.t41, label %b14.e42
b14.t41:
  br label %b19
b14.e42:
  br label %b20
b15:
  %v61 = add i64 0, 1
  call void @"rt.panic"(i64 %v61)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v62.p = getelementptr i64, ptr %v28, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = inttoptr i64 %v62 to ptr
  %v64 = getelementptr i8, ptr %v63, i64 %v58
  %v65.p = getelementptr i8, ptr %v64, i64 0
  %v65.b = load i8, ptr %v65.p
  %v65 = zext i8 %v65.b to i64
  %v66 = add i64 0, 10
  %v67.c = icmp ne i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b16 = icmp ne i64 %v67, 0
  br i1 %c.b16, label %b16.t43, label %b16.e44
b16.t43:
  br label %b13
b16.e44:
  br label %b14
b17:
  %v75 = add i64 0, 2
  call void @"rt.panic"(i64 %v75)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v76.p = getelementptr i64, ptr %v28, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = inttoptr i64 %v76 to ptr
  %v78 = getelementptr i8, ptr %v77, i64 %v72
  %v79.p = getelementptr i8, ptr %v78, i64 0
  %v79.b = load i8, ptr %v79.p
  %v79 = zext i8 %v79.b to i64
  %v80 = add i64 0, 48
  %v81 = sub i64 %v79, %v80
  %v82 = add i64 %v71, %v81
  %st44 = getelementptr i64, ptr %v56, i64 0
  store i64 %v82, ptr %st44
  %v83 = add i64 0, 1
  %v84.p = getelementptr i64, ptr %v33, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 %v84, %v83
  %st45 = getelementptr i64, ptr %v33, i64 0
  store i64 %v85, ptr %st45
  br label %b12
b19:
  %v88 = add i64 0, 0
  %v89.p = getelementptr i64, ptr %v56, i64 0
  %v89 = load i64, ptr %v89.p
  %v90 = sub i64 %v88, %v89
  br label %b21
b20:
  %v91.p = getelementptr i64, ptr %v56, i64 0
  %v91 = load i64, ptr %v91.p
  br label %b21
b21:
  %v92 = phi i64 [ %v90, %b19 ], [ %v91, %b20 ]
  %v93 = call i64 @"std/math.FromBits"(i64 %v92)
  call void @"std/convert.FormatFloat"(ptr %v86, i64 %v93)
  call void @"rt.print_str"(ptr %v86)
  %v94 = add i64 0, 10
  call void @"rt.print_char"(i64 %v94)
  %v95 = add i64 0, 1
  %v96.p = getelementptr i64, ptr %v33, i64 0
  %v96 = load i64, ptr %v96.p
  %v97 = add i64 %v96, %v95
  %st46 = getelementptr i64, ptr %v33, i64 0
  store i64 %v97, ptr %st46
  br label %b4
}

define internal void @"std/convert.FormatFloat"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v18, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2571
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v3, i64 2571
  store i64 %v5, ptr %st0
  %v6 = add i64 0, 1
  %v7.c = icmp sge i64 %v4, %v6
  %v7 = zext i1 %v7.c to i64
  %v8.c = icmp sle i64 %v4, %v2
  %v8 = zext i1 %v8.c to i64
  %v9 = and i64 %v7, %v8
  %v10 = sub i64 %v4, %v2
  %v11 = mul i64 %v9, %v10
  %v12 = add i64 %v2, %v11
  call void @"rt.region_enter"()
  %v13 = getelementptr i64, ptr %s0, i64 0
  %v14 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v14, i64 2571
  store i64 %v12, ptr %st1
  call void @"std/internal/floatfmt.Format"(ptr %v13, i64 %v1)
  %v15.p = getelementptr i64, ptr %v13, i64 0
  %v15 = load i64, ptr %v15.p
  %st2 = getelementptr i64, ptr %v0, i64 0
  store i64 %v15, ptr %st2
  %v16.p = getelementptr i64, ptr %v13, i64 1
  %v16 = load i64, ptr %v16.p
  %st3 = getelementptr i64, ptr %v0, i64 1
  store i64 %v16, ptr %st3
  %v17.p = getelementptr i64, ptr %v13, i64 2
  %v17 = load i64, ptr %v17.p
  %st4 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st4
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v19 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v19, i64 0
  store i64 %v2, ptr %st5
  ret void
}

define internal void @"std/io.errOf"(ptr %v0, i64 %v1) #0 {
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
  %v66 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v66, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 2
  %v4.c = icmp eq i64 %v1, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v6 = add i64 0, 20
  %v7.c = icmp eq i64 %v1, %v6
  %v7 = zext i1 %v7.c to i64
  br label %b2
b2:
  %v5 = phi i64 [ %v4, %b0.t1 ], [ %v7, %b1 ]
  %c.b2 = icmp ne i64 %v5, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v8 = getelementptr i64, ptr %s0, i64 0
  %v9 = add i64 0, 0
  %st4 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 1
  store i64 %v9, ptr %st5
  %v10 = add i64 0, 5
  %st6 = getelementptr i64, ptr %v8, i64 0
  store i64 %v10, ptr %st6
  %v11 = getelementptr i64, ptr %s1, i64 0
  %v12.p = getelementptr i64, ptr %v8, i64 0
  %v12 = load i64, ptr %v12.p
  %st7 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st7
  %v13.p = getelementptr i64, ptr %v8, i64 1
  %v13 = load i64, ptr %v13.p
  %st8 = getelementptr i64, ptr %v11, i64 1
  store i64 %v13, ptr %st8
  %v14 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v11, i64 2
  store i64 %v14, ptr %st9
  %st10 = getelementptr i64, ptr %v11, i64 3
  store i64 %v14, ptr %st10
  %st11 = getelementptr i64, ptr %v11, i64 4
  store i64 %v14, ptr %st11
  %v15.p = getelementptr i64, ptr %v11, i64 0
  %v15 = load i64, ptr %v15.p
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v15, ptr %st12
  %v16.p = getelementptr i64, ptr %v11, i64 1
  %v16 = load i64, ptr %v16.p
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v16, ptr %st13
  %v17.p = getelementptr i64, ptr %v11, i64 2
  %v17 = load i64, ptr %v17.p
  %st14 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st14
  %v18.p = getelementptr i64, ptr %v11, i64 3
  %v18 = load i64, ptr %v18.p
  %st15 = getelementptr i64, ptr %v0, i64 3
  store i64 %v18, ptr %st15
  %v19.p = getelementptr i64, ptr %v11, i64 4
  %v19 = load i64, ptr %v19.p
  %st16 = getelementptr i64, ptr %v0, i64 4
  store i64 %v19, ptr %st16
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v67, i64 0
  store i64 %v2, ptr %st17
  ret void
b4:
  br label %b5
b5:
  %v20 = add i64 0, 13
  %v21.c = icmp eq i64 %v1, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b5 = icmp ne i64 %v21, 0
  br i1 %c.b5, label %b5.t19, label %b5.e20
b5.t19:
  br label %b7
b5.e20:
  br label %b6
b6:
  %v23 = add i64 0, 1
  %v24.c = icmp eq i64 %v1, %v23
  %v24 = zext i1 %v24.c to i64
  br label %b7
b7:
  %v22 = phi i64 [ %v21, %b5.t19 ], [ %v24, %b6 ]
  %c.b7 = icmp ne i64 %v22, 0
  br i1 %c.b7, label %b7.t21, label %b7.e22
b7.t21:
  br label %b9
b7.e22:
  br label %b8
b8:
  %v26 = add i64 0, 30
  %v27.c = icmp eq i64 %v1, %v26
  %v27 = zext i1 %v27.c to i64
  br label %b9
b9:
  %v25 = phi i64 [ %v22, %b7.t21 ], [ %v27, %b8 ]
  %c.b9 = icmp ne i64 %v25, 0
  br i1 %c.b9, label %b9.t23, label %b9.e24
b9.t23:
  br label %b10
b9.e24:
  br label %b11
b10:
  %v28 = getelementptr i64, ptr %s0, i64 0
  %v29 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st24
  %st25 = getelementptr i64, ptr %v28, i64 1
  store i64 %v29, ptr %st25
  %v30 = add i64 0, 6
  %st26 = getelementptr i64, ptr %v28, i64 0
  store i64 %v30, ptr %st26
  %v31 = getelementptr i64, ptr %s1, i64 0
  %v32.p = getelementptr i64, ptr %v28, i64 0
  %v32 = load i64, ptr %v32.p
  %st27 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st27
  %v33.p = getelementptr i64, ptr %v28, i64 1
  %v33 = load i64, ptr %v33.p
  %st28 = getelementptr i64, ptr %v31, i64 1
  store i64 %v33, ptr %st28
  %v34 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v31, i64 2
  store i64 %v34, ptr %st29
  %st30 = getelementptr i64, ptr %v31, i64 3
  store i64 %v34, ptr %st30
  %st31 = getelementptr i64, ptr %v31, i64 4
  store i64 %v34, ptr %st31
  %v35.p = getelementptr i64, ptr %v31, i64 0
  %v35 = load i64, ptr %v35.p
  %st32 = getelementptr i64, ptr %v0, i64 0
  store i64 %v35, ptr %st32
  %v36.p = getelementptr i64, ptr %v31, i64 1
  %v36 = load i64, ptr %v36.p
  %st33 = getelementptr i64, ptr %v0, i64 1
  store i64 %v36, ptr %st33
  %v37.p = getelementptr i64, ptr %v31, i64 2
  %v37 = load i64, ptr %v37.p
  %st34 = getelementptr i64, ptr %v0, i64 2
  store i64 %v37, ptr %st34
  %v38.p = getelementptr i64, ptr %v31, i64 3
  %v38 = load i64, ptr %v38.p
  %st35 = getelementptr i64, ptr %v0, i64 3
  store i64 %v38, ptr %st35
  %v39.p = getelementptr i64, ptr %v31, i64 4
  %v39 = load i64, ptr %v39.p
  %st36 = getelementptr i64, ptr %v0, i64 4
  store i64 %v39, ptr %st36
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v68 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v68, i64 0
  store i64 %v2, ptr %st37
  ret void
b11:
  br label %b12
b12:
  %v40 = add i64 0, 110
  %v41.c = icmp eq i64 %v1, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b12 = icmp ne i64 %v41, 0
  br i1 %c.b12, label %b12.t39, label %b12.e40
b12.t39:
  br label %b13
b12.e40:
  br label %b14
b13:
  %v42 = getelementptr i64, ptr %s0, i64 0
  %v43 = add i64 0, 0
  %st40 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st40
  %st41 = getelementptr i64, ptr %v42, i64 1
  store i64 %v43, ptr %st41
  %v44 = add i64 0, 7
  %st42 = getelementptr i64, ptr %v42, i64 0
  store i64 %v44, ptr %st42
  %v45 = getelementptr i64, ptr %s1, i64 0
  %v46.p = getelementptr i64, ptr %v42, i64 0
  %v46 = load i64, ptr %v46.p
  %st43 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st43
  %v47.p = getelementptr i64, ptr %v42, i64 1
  %v47 = load i64, ptr %v47.p
  %st44 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st44
  %v48 = add i64 0, 0
  %st45 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st45
  %st46 = getelementptr i64, ptr %v45, i64 3
  store i64 %v48, ptr %st46
  %st47 = getelementptr i64, ptr %v45, i64 4
  store i64 %v48, ptr %st47
  %v49.p = getelementptr i64, ptr %v45, i64 0
  %v49 = load i64, ptr %v49.p
  %st48 = getelementptr i64, ptr %v0, i64 0
  store i64 %v49, ptr %st48
  %v50.p = getelementptr i64, ptr %v45, i64 1
  %v50 = load i64, ptr %v50.p
  %st49 = getelementptr i64, ptr %v0, i64 1
  store i64 %v50, ptr %st49
  %v51.p = getelementptr i64, ptr %v45, i64 2
  %v51 = load i64, ptr %v51.p
  %st50 = getelementptr i64, ptr %v0, i64 2
  store i64 %v51, ptr %st50
  %v52.p = getelementptr i64, ptr %v45, i64 3
  %v52 = load i64, ptr %v52.p
  %st51 = getelementptr i64, ptr %v0, i64 3
  store i64 %v52, ptr %st51
  %v53.p = getelementptr i64, ptr %v45, i64 4
  %v53 = load i64, ptr %v53.p
  %st52 = getelementptr i64, ptr %v0, i64 4
  store i64 %v53, ptr %st52
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v69 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v69, i64 0
  store i64 %v2, ptr %st53
  ret void
b14:
  br label %b15
b15:
  %v54 = getelementptr i64, ptr %s0, i64 0
  %v55 = add i64 0, 0
  %st54 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st54
  %st55 = getelementptr i64, ptr %v54, i64 1
  store i64 %v55, ptr %st55
  %v56 = add i64 0, 10
  %st56 = getelementptr i64, ptr %v54, i64 0
  store i64 %v56, ptr %st56
  %st57 = getelementptr i64, ptr %v54, i64 1
  store i64 %v1, ptr %st57
  %v57 = getelementptr i64, ptr %s1, i64 0
  %v58.p = getelementptr i64, ptr %v54, i64 0
  %v58 = load i64, ptr %v58.p
  %st58 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st58
  %v59.p = getelementptr i64, ptr %v54, i64 1
  %v59 = load i64, ptr %v59.p
  %st59 = getelementptr i64, ptr %v57, i64 1
  store i64 %v59, ptr %st59
  %v60 = add i64 0, 0
  %st60 = getelementptr i64, ptr %v57, i64 2
  store i64 %v60, ptr %st60
  %st61 = getelementptr i64, ptr %v57, i64 3
  store i64 %v60, ptr %st61
  %st62 = getelementptr i64, ptr %v57, i64 4
  store i64 %v60, ptr %st62
  %v61.p = getelementptr i64, ptr %v57, i64 0
  %v61 = load i64, ptr %v61.p
  %st63 = getelementptr i64, ptr %v0, i64 0
  store i64 %v61, ptr %st63
  %v62.p = getelementptr i64, ptr %v57, i64 1
  %v62 = load i64, ptr %v62.p
  %st64 = getelementptr i64, ptr %v0, i64 1
  store i64 %v62, ptr %st64
  %v63.p = getelementptr i64, ptr %v57, i64 2
  %v63 = load i64, ptr %v63.p
  %st65 = getelementptr i64, ptr %v0, i64 2
  store i64 %v63, ptr %st65
  %v64.p = getelementptr i64, ptr %v57, i64 3
  %v64 = load i64, ptr %v64.p
  %st66 = getelementptr i64, ptr %v0, i64 3
  store i64 %v64, ptr %st66
  %v65.p = getelementptr i64, ptr %v57, i64 4
  %v65 = load i64, ptr %v65.p
  %st67 = getelementptr i64, ptr %v0, i64 4
  store i64 %v65, ptr %st67
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v70, i64 0
  store i64 %v2, ptr %st68
  ret void
}

define internal void @"std/io.ReadStdin"(ptr %v0) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
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
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s5 = alloca [5 x i64], align 8
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
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v104, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v2, i64 2571
  %v3 = load i64, ptr %v3.p
  %v4 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v2, i64 2571
  store i64 %v4, ptr %st0
  %v5 = add i64 0, 1
  %v6.c = icmp sge i64 %v3, %v5
  %v6 = zext i1 %v6.c to i64
  %v7.c = icmp sle i64 %v3, %v1
  %v7 = zext i1 %v7.c to i64
  %v8 = and i64 %v6, %v7
  %v9 = sub i64 %v3, %v1
  %v10 = mul i64 %v8, %v9
  %v11 = add i64 %v1, %v10
  call void @"rt.region_enter"()
  %v12 = add i64 0, 0
  %v13 = add i64 0, 0
  %v14.c = icmp ne i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v15 = add i64 0, 0
  %v16 = call ptr @"rt.region_alloc8"(i64 %v11, i64 %v15)
  %v17 = add i64 0, 0
  %v18 = getelementptr i64, ptr %s0, i64 0
  %v19 = ptrtoint ptr %v16 to i64
  %st3 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st3
  %st4 = getelementptr i64, ptr %v18, i64 1
  store i64 %v17, ptr %st4
  %st5 = getelementptr i64, ptr %v18, i64 2
  store i64 %v11, ptr %st5
  %v20 = getelementptr i64, ptr %s1, i64 0
  %v21 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st6
  %st7 = getelementptr i64, ptr %v20, i64 1
  store i64 %v21, ptr %st7
  %v22 = add i64 0, 8
  %st8 = getelementptr i64, ptr %v20, i64 0
  store i64 %v22, ptr %st8
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24.p = getelementptr i64, ptr %v20, i64 0
  %v24 = load i64, ptr %v24.p
  %st9 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st9
  %v25.p = getelementptr i64, ptr %v20, i64 1
  %v25 = load i64, ptr %v25.p
  %st10 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st10
  %v26 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st11
  %st12 = getelementptr i64, ptr %v23, i64 3
  store i64 %v26, ptr %st12
  %st13 = getelementptr i64, ptr %v23, i64 4
  store i64 %v26, ptr %st13
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v28 = add i64 0, 1
  %st14 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st14
  %v29.p = getelementptr i64, ptr %v23, i64 0
  %v29 = load i64, ptr %v29.p
  %st15 = getelementptr i64, ptr %v27, i64 1
  store i64 %v29, ptr %st15
  %v30.p = getelementptr i64, ptr %v23, i64 1
  %v30 = load i64, ptr %v30.p
  %st16 = getelementptr i64, ptr %v27, i64 2
  store i64 %v30, ptr %st16
  %v31.p = getelementptr i64, ptr %v23, i64 2
  %v31 = load i64, ptr %v31.p
  %st17 = getelementptr i64, ptr %v27, i64 3
  store i64 %v31, ptr %st17
  %v32.p = getelementptr i64, ptr %v23, i64 3
  %v32 = load i64, ptr %v32.p
  %st18 = getelementptr i64, ptr %v27, i64 4
  store i64 %v32, ptr %st18
  %v33.p = getelementptr i64, ptr %v23, i64 4
  %v33 = load i64, ptr %v33.p
  %st19 = getelementptr i64, ptr %v27, i64 5
  store i64 %v33, ptr %st19
  %v34.p = getelementptr i64, ptr %v18, i64 0
  %v34 = load i64, ptr %v34.p
  %st20 = getelementptr i64, ptr %v0, i64 0
  store i64 %v34, ptr %st20
  %v35.p = getelementptr i64, ptr %v18, i64 1
  %v35 = load i64, ptr %v35.p
  %st21 = getelementptr i64, ptr %v0, i64 1
  store i64 %v35, ptr %st21
  %v36.p = getelementptr i64, ptr %v18, i64 2
  %v36 = load i64, ptr %v36.p
  %st22 = getelementptr i64, ptr %v0, i64 2
  store i64 %v36, ptr %st22
  %v37.p = getelementptr i64, ptr %v27, i64 0
  %v37 = load i64, ptr %v37.p
  %st23 = getelementptr i64, ptr %v0, i64 3
  store i64 %v37, ptr %st23
  %v38.p = getelementptr i64, ptr %v27, i64 1
  %v38 = load i64, ptr %v38.p
  %st24 = getelementptr i64, ptr %v0, i64 4
  store i64 %v38, ptr %st24
  %v39.p = getelementptr i64, ptr %v27, i64 2
  %v39 = load i64, ptr %v39.p
  %st25 = getelementptr i64, ptr %v0, i64 5
  store i64 %v39, ptr %st25
  %v40.p = getelementptr i64, ptr %v27, i64 3
  %v40 = load i64, ptr %v40.p
  %st26 = getelementptr i64, ptr %v0, i64 6
  store i64 %v40, ptr %st26
  %v41.p = getelementptr i64, ptr %v27, i64 4
  %v41 = load i64, ptr %v41.p
  %st27 = getelementptr i64, ptr %v0, i64 7
  store i64 %v41, ptr %st27
  %v42.p = getelementptr i64, ptr %v27, i64 5
  %v42 = load i64, ptr %v42.p
  %st28 = getelementptr i64, ptr %v0, i64 8
  store i64 %v42, ptr %st28
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v43.p = getelementptr i64, ptr %v0, i64 3
  %v43 = load i64, ptr %v43.p
  %v44 = add i64 0, 0
  %v45.c = icmp ne i64 %v43, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b1 = icmp ne i64 %v45, 0
  br i1 %c.b1, label %b1.t30, label %b1.e31
b1.t30:
  br label %b3
b1.e31:
  br label %b4
b2:
  br label %b5
b3:
  %v46 = add i64 0, 4
  %v47 = getelementptr i64, ptr %v0, i64 %v46
  call void @"rt.err_relocate"(ptr %v47, i64 %v1)
  br label %b4
b4:
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v105, i64 0
  store i64 %v1, ptr %st31
  ret void
b5:
  %v48 = add i64 0, 0
  %v49 = add i64 0, 1
  %v50 = add i64 0, 0
  %v51 = sub i64 %v50, %v49
  %v52 = getelementptr i64, ptr %s0, i64 0
  call void @"rt.read_fd"(i64 %v48, i64 %v51, ptr %v52)
  %v53 = getelementptr i64, ptr %s4, i64 0
  %v54.p = getelementptr i64, ptr %v52, i64 0
  %v54 = load i64, ptr %v54.p
  %st32 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st32
  %v55.p = getelementptr i64, ptr %v52, i64 1
  %v55 = load i64, ptr %v55.p
  %st33 = getelementptr i64, ptr %v53, i64 1
  store i64 %v55, ptr %st33
  %v56.p = getelementptr i64, ptr %v52, i64 2
  %v56 = load i64, ptr %v56.p
  %st34 = getelementptr i64, ptr %v53, i64 2
  store i64 %v56, ptr %st34
  %v57 = getelementptr i64, ptr @"rt.meta", i64 0
  %v58.p = getelementptr i64, ptr %v57, i64 1027
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 0
  %v60.c = icmp ne i64 %v58, %v59
  %v60 = zext i1 %v60.c to i64
  %c.b5 = icmp ne i64 %v60, 0
  br i1 %c.b5, label %b5.t36, label %b5.e37
b5.t36:
  br label %b6
b5.e37:
  br label %b7
b6:
  %v61 = add i64 0, 0
  %v62 = call ptr @"rt.region_alloc8"(i64 %v11, i64 %v61)
  %v63 = add i64 0, 0
  %v64 = getelementptr i64, ptr %s0, i64 0
  %v65 = ptrtoint ptr %v62 to i64
  %st37 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st37
  %st38 = getelementptr i64, ptr %v64, i64 1
  store i64 %v63, ptr %st38
  %st39 = getelementptr i64, ptr %v64, i64 2
  store i64 %v11, ptr %st39
  %v66 = getelementptr i64, ptr %s5, i64 0
  call void @"std/io.errOf"(ptr %v66, i64 %v58)
  %v67 = getelementptr i64, ptr %s3, i64 0
  %v68 = add i64 0, 1
  %st40 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st40
  %v69.p = getelementptr i64, ptr %v66, i64 0
  %v69 = load i64, ptr %v69.p
  %st41 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st41
  %v70.p = getelementptr i64, ptr %v66, i64 1
  %v70 = load i64, ptr %v70.p
  %st42 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st42
  %v71.p = getelementptr i64, ptr %v66, i64 2
  %v71 = load i64, ptr %v71.p
  %st43 = getelementptr i64, ptr %v67, i64 3
  store i64 %v71, ptr %st43
  %v72.p = getelementptr i64, ptr %v66, i64 3
  %v72 = load i64, ptr %v72.p
  %st44 = getelementptr i64, ptr %v67, i64 4
  store i64 %v72, ptr %st44
  %v73.p = getelementptr i64, ptr %v66, i64 4
  %v73 = load i64, ptr %v73.p
  %st45 = getelementptr i64, ptr %v67, i64 5
  store i64 %v73, ptr %st45
  %v74.p = getelementptr i64, ptr %v64, i64 0
  %v74 = load i64, ptr %v74.p
  %st46 = getelementptr i64, ptr %v0, i64 0
  store i64 %v74, ptr %st46
  %v75.p = getelementptr i64, ptr %v64, i64 1
  %v75 = load i64, ptr %v75.p
  %st47 = getelementptr i64, ptr %v0, i64 1
  store i64 %v75, ptr %st47
  %v76.p = getelementptr i64, ptr %v64, i64 2
  %v76 = load i64, ptr %v76.p
  %st48 = getelementptr i64, ptr %v0, i64 2
  store i64 %v76, ptr %st48
  %v77.p = getelementptr i64, ptr %v67, i64 0
  %v77 = load i64, ptr %v77.p
  %st49 = getelementptr i64, ptr %v0, i64 3
  store i64 %v77, ptr %st49
  %v78.p = getelementptr i64, ptr %v67, i64 1
  %v78 = load i64, ptr %v78.p
  %st50 = getelementptr i64, ptr %v0, i64 4
  store i64 %v78, ptr %st50
  %v79.p = getelementptr i64, ptr %v67, i64 2
  %v79 = load i64, ptr %v79.p
  %st51 = getelementptr i64, ptr %v0, i64 5
  store i64 %v79, ptr %st51
  %v80.p = getelementptr i64, ptr %v67, i64 3
  %v80 = load i64, ptr %v80.p
  %st52 = getelementptr i64, ptr %v0, i64 6
  store i64 %v80, ptr %st52
  %v81.p = getelementptr i64, ptr %v67, i64 4
  %v81 = load i64, ptr %v81.p
  %st53 = getelementptr i64, ptr %v0, i64 7
  store i64 %v81, ptr %st53
  %v82.p = getelementptr i64, ptr %v67, i64 5
  %v82 = load i64, ptr %v82.p
  %st54 = getelementptr i64, ptr %v0, i64 8
  store i64 %v82, ptr %st54
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v83.p = getelementptr i64, ptr %v0, i64 3
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 0
  %v85.c = icmp ne i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b6 = icmp ne i64 %v85, 0
  br i1 %c.b6, label %b6.t56, label %b6.e57
b6.t56:
  br label %b8
b6.e57:
  br label %b9
b7:
  br label %b10
b8:
  %v86 = add i64 0, 4
  %v87 = getelementptr i64, ptr %v0, i64 %v86
  call void @"rt.err_relocate"(ptr %v87, i64 %v1)
  br label %b9
b9:
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v106, i64 0
  store i64 %v1, ptr %st57
  ret void
b10:
  %v88 = getelementptr i64, ptr %s3, i64 0
  %v89 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st58
  %v90.p = getelementptr i64, ptr %v53, i64 0
  %v90 = load i64, ptr %v90.p
  %st59 = getelementptr i64, ptr %v0, i64 0
  store i64 %v90, ptr %st59
  %v91.p = getelementptr i64, ptr %v53, i64 1
  %v91 = load i64, ptr %v91.p
  %st60 = getelementptr i64, ptr %v0, i64 1
  store i64 %v91, ptr %st60
  %v92.p = getelementptr i64, ptr %v53, i64 2
  %v92 = load i64, ptr %v92.p
  %st61 = getelementptr i64, ptr %v0, i64 2
  store i64 %v92, ptr %st61
  %v93.p = getelementptr i64, ptr %v88, i64 0
  %v93 = load i64, ptr %v93.p
  %st62 = getelementptr i64, ptr %v0, i64 3
  store i64 %v93, ptr %st62
  %v94.p = getelementptr i64, ptr %v88, i64 1
  %v94 = load i64, ptr %v94.p
  %st63 = getelementptr i64, ptr %v0, i64 4
  store i64 %v94, ptr %st63
  %v95.p = getelementptr i64, ptr %v88, i64 2
  %v95 = load i64, ptr %v95.p
  %st64 = getelementptr i64, ptr %v0, i64 5
  store i64 %v95, ptr %st64
  %v96.p = getelementptr i64, ptr %v88, i64 3
  %v96 = load i64, ptr %v96.p
  %st65 = getelementptr i64, ptr %v0, i64 6
  store i64 %v96, ptr %st65
  %v97.p = getelementptr i64, ptr %v88, i64 4
  %v97 = load i64, ptr %v97.p
  %st66 = getelementptr i64, ptr %v0, i64 7
  store i64 %v97, ptr %st66
  %v98.p = getelementptr i64, ptr %v88, i64 5
  %v98 = load i64, ptr %v98.p
  %st67 = getelementptr i64, ptr %v0, i64 8
  store i64 %v98, ptr %st67
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v99.p = getelementptr i64, ptr %v0, i64 3
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 0, 0
  %v101.c = icmp ne i64 %v99, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b10 = icmp ne i64 %v101, 0
  br i1 %c.b10, label %b10.t69, label %b10.e70
b10.t69:
  br label %b11
b10.e70:
  br label %b12
b11:
  %v102 = add i64 0, 4
  %v103 = getelementptr i64, ptr %v0, i64 %v102
  call void @"rt.err_relocate"(ptr %v103, i64 %v1)
  br label %b12
b12:
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v107, i64 0
  store i64 %v1, ptr %st70
  ret void
}

define internal i64 @"std/math.FromBits"(i64 %v0) #0 {
b0:
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v2, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v1, ptr %st0
  ret i64 %v0
}

define internal void @"std/internal/floatfmt.Format"(ptr %v0, i64 %v1) #0 {
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
  %v703 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v703, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2571
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v3, i64 2571
  store i64 %v5, ptr %st0
  %v6 = add i64 0, 1
  %v7.c = icmp sge i64 %v4, %v6
  %v7 = zext i1 %v7.c to i64
  %v8.c = icmp sle i64 %v4, %v2
  %v8 = zext i1 %v8.c to i64
  %v9 = and i64 %v7, %v8
  %v10 = sub i64 %v4, %v2
  %v11 = mul i64 %v9, %v10
  %v12 = add i64 %v2, %v11
  call void @"rt.region_enter"()
  %v13 = add i64 0, 0
  %v14.c = icmp slt i64 %v1, %v13
  %v14 = zext i1 %v14.c to i64
  %v15 = add i64 0, 52
  %v17 = add i64 0, 0
  %v18.c = icmp slt i64 %v15, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v19 = add i64 0, 3
  call void @"rt.panic"(i64 %v19)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v20 = add i64 0, 63
  %v21.c = icmp sgt i64 %v15, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b2 = icmp ne i64 %v21, 0
  br i1 %c.b2, label %b2.t4, label %b2.e5
b2.t4:
  br label %b4
b2.e5:
  br label %b5
b3:
  %v16 = phi i64 [ %v23, %b4 ], [ %v24, %b5 ]
  %v25 = add i64 0, 2047
  %v26 = and i64 %v16, %v25
  %v27 = add i64 0, 4503599627370495
  %v28 = and i64 %v1, %v27
  %v29 = add i64 0, 2047
  %v30.c = icmp eq i64 %v26, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b3 = icmp ne i64 %v30, 0
  br i1 %c.b3, label %b3.t6, label %b3.e7
b3.t6:
  br label %b6
b3.e7:
  br label %b7
b4:
  %v22 = add i64 0, 63
  %v23.n = and i64 %v22, 63
  %v23 = ashr i64 %v1, %v23.n
  br label %b3
b5:
  %v24.n = and i64 %v15, 63
  %v24 = ashr i64 %v1, %v24.n
  br label %b3
b6:
  %v31 = add i64 0, 0
  %v32.c = icmp ne i64 %v28, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b6 = icmp ne i64 %v32, 0
  br i1 %c.b6, label %b6.t8, label %b6.e9
b6.t8:
  br label %b8
b6.e9:
  br label %b9
b7:
  br label %b14
b8:
  %v33 = getelementptr i64, ptr @"str.0", i64 0
  %v34 = add i64 0, 3
  %v35 = add i64 0, 0
  %v36 = getelementptr i64, ptr %s0, i64 0
  %v37 = ptrtoint ptr %v33 to i64
  %st9 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st9
  %st10 = getelementptr i64, ptr %v36, i64 1
  store i64 %v34, ptr %st10
  %st11 = getelementptr i64, ptr %v36, i64 2
  store i64 %v35, ptr %st11
  %v38.p = getelementptr i64, ptr %v36, i64 0
  %v38 = load i64, ptr %v38.p
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v38, ptr %st12
  %v39.p = getelementptr i64, ptr %v36, i64 1
  %v39 = load i64, ptr %v39.p
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v39, ptr %st13
  %v40.p = getelementptr i64, ptr %v36, i64 2
  %v40 = load i64, ptr %v40.p
  %st14 = getelementptr i64, ptr %v0, i64 2
  store i64 %v40, ptr %st14
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v704 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v704, i64 0
  store i64 %v2, ptr %st15
  ret void
b9:
  br label %b10
b10:
  %c.b10 = icmp ne i64 %v14, 0
  br i1 %c.b10, label %b10.t17, label %b10.e18
b10.t17:
  br label %b11
b10.e18:
  br label %b12
b11:
  %v41 = getelementptr i64, ptr @"str.2", i64 0
  %v42 = add i64 0, 4
  %v43 = add i64 0, 0
  %v44 = getelementptr i64, ptr %s0, i64 0
  %v45 = ptrtoint ptr %v41 to i64
  %st18 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st18
  %st19 = getelementptr i64, ptr %v44, i64 1
  store i64 %v42, ptr %st19
  %st20 = getelementptr i64, ptr %v44, i64 2
  store i64 %v43, ptr %st20
  br label %b13
b12:
  %v46 = getelementptr i64, ptr @"str.1", i64 0
  %v47 = add i64 0, 4
  %v48 = add i64 0, 0
  %v49 = getelementptr i64, ptr %s1, i64 0
  %v50 = ptrtoint ptr %v46 to i64
  %st21 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st21
  %st22 = getelementptr i64, ptr %v49, i64 1
  store i64 %v47, ptr %st22
  %st23 = getelementptr i64, ptr %v49, i64 2
  store i64 %v48, ptr %st23
  br label %b13
b13:
  %v51 = phi ptr [ %v44, %b11 ], [ %v49, %b12 ]
  %v52.p = getelementptr i64, ptr %v51, i64 0
  %v52 = load i64, ptr %v52.p
  %st24 = getelementptr i64, ptr %v0, i64 0
  store i64 %v52, ptr %st24
  %v53.p = getelementptr i64, ptr %v51, i64 1
  %v53 = load i64, ptr %v53.p
  %st25 = getelementptr i64, ptr %v0, i64 1
  store i64 %v53, ptr %st25
  %v54.p = getelementptr i64, ptr %v51, i64 2
  %v54 = load i64, ptr %v54.p
  %st26 = getelementptr i64, ptr %v0, i64 2
  store i64 %v54, ptr %st26
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v705 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v705, i64 0
  store i64 %v2, ptr %st27
  ret void
b14:
  %v55 = add i64 0, 0
  %v56 = call ptr @"rt.region_alloc8"(i64 %v12, i64 %v55)
  %v57 = add i64 0, 0
  %v58 = getelementptr i64, ptr %s1, i64 0
  %v59 = ptrtoint ptr %v56 to i64
  %st28 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st28
  %st29 = getelementptr i64, ptr %v58, i64 1
  store i64 %v57, ptr %st29
  %st30 = getelementptr i64, ptr %v58, i64 2
  store i64 %v12, ptr %st30
  %v60 = getelementptr i64, ptr %s0, i64 0
  %v61.p = getelementptr i64, ptr %v58, i64 0
  %v61 = load i64, ptr %v61.p
  %st31 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st31
  %v62.p = getelementptr i64, ptr %v58, i64 1
  %v62 = load i64, ptr %v62.p
  %st32 = getelementptr i64, ptr %v60, i64 1
  store i64 %v62, ptr %st32
  %v63.p = getelementptr i64, ptr %v58, i64 2
  %v63 = load i64, ptr %v63.p
  %st33 = getelementptr i64, ptr %v60, i64 2
  store i64 %v63, ptr %st33
  %c.b14 = icmp ne i64 %v14, 0
  br i1 %c.b14, label %b14.t35, label %b14.e36
b14.t35:
  br label %b15
b14.e36:
  br label %b16
b15:
  %v64 = getelementptr i64, ptr %s1, i64 0
  %v65.p = getelementptr i64, ptr %v60, i64 0
  %v65 = load i64, ptr %v65.p
  %st36 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st36
  %v66.p = getelementptr i64, ptr %v60, i64 1
  %v66 = load i64, ptr %v66.p
  %st37 = getelementptr i64, ptr %v64, i64 1
  store i64 %v66, ptr %st37
  %v67.p = getelementptr i64, ptr %v60, i64 2
  %v67 = load i64, ptr %v67.p
  %st38 = getelementptr i64, ptr %v64, i64 2
  store i64 %v67, ptr %st38
  %v68 = add i64 0, 45
  %v69.p = getelementptr i64, ptr %v64, i64 2
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v64, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v64, i64 1
  %v71 = load i64, ptr %v71.p
  %v74 = add i64 %v70, %v71
  %v75 = call i64 @"rt.tip8"(i64 %v69, i64 %v74)
  %v76 = add i64 0, 0
  %v77.c = icmp ne i64 %v75, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b15 = icmp ne i64 %v77, 0
  br i1 %c.b15, label %b15.t40, label %b15.e41
b15.t40:
  br label %b19
b15.e41:
  br label %b18
b16:
  br label %b20
b17:
  %v72 = phi ptr [ %v81, %b18 ], [ %v78, %b19 ]
  %v73 = phi ptr [ %v82, %b18 ], [ %v79, %b19 ]
  %st41 = getelementptr i8, ptr %v73, i64 0
  %st41.b = trunc i64 %v68 to i8
  store i8 %st41.b, ptr %st41
  %v83.p = getelementptr i64, ptr %v64, i64 1
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 1
  %v85 = add i64 %v83, %v84
  %v86 = getelementptr i64, ptr %s2, i64 0
  %v87 = ptrtoint ptr %v72 to i64
  %st42 = getelementptr i64, ptr %v86, i64 0
  store i64 %v87, ptr %st42
  %st43 = getelementptr i64, ptr %v86, i64 1
  store i64 %v85, ptr %st43
  %st44 = getelementptr i64, ptr %v86, i64 2
  store i64 %v69, ptr %st44
  %v88.p = getelementptr i64, ptr %v86, i64 0
  %v88 = load i64, ptr %v88.p
  %st45 = getelementptr i64, ptr %v60, i64 0
  store i64 %v88, ptr %st45
  %v89.p = getelementptr i64, ptr %v86, i64 1
  %v89 = load i64, ptr %v89.p
  %st46 = getelementptr i64, ptr %v60, i64 1
  store i64 %v89, ptr %st46
  %v90.p = getelementptr i64, ptr %v86, i64 2
  %v90 = load i64, ptr %v90.p
  %st47 = getelementptr i64, ptr %v60, i64 2
  store i64 %v90, ptr %st47
  br label %b20
b18:
  %v80 = add i64 0, 1
  %v81 = call ptr @"rt.slice_grow8"(i64 %v70, i64 %v71, i64 %v69, i64 %v80)
  %v82 = getelementptr i8, ptr %v81, i64 %v71
  br label %b17
b19:
  %v78 = inttoptr i64 %v70 to ptr
  %v79 = getelementptr i8, ptr %v78, i64 %v71
  br label %b17
b20:
  %v91 = add i64 0, 0
  %v92.c = icmp eq i64 %v26, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b20 = icmp ne i64 %v92, 0
  br i1 %c.b20, label %b20.t49, label %b20.e50
b20.t49:
  br label %b21
b20.e50:
  br label %b22
b21:
  %v94 = add i64 0, 0
  %v95.c = icmp eq i64 %v28, %v94
  %v95 = zext i1 %v95.c to i64
  br label %b22
b22:
  %v93 = phi i64 [ %v92, %b20.e50 ], [ %v95, %b21 ]
  %c.b22 = icmp ne i64 %v93, 0
  br i1 %c.b22, label %b22.t51, label %b22.e52
b22.t51:
  br label %b23
b22.e52:
  br label %b24
b23:
  %v96 = getelementptr i64, ptr %s2, i64 0
  %v97.p = getelementptr i64, ptr %v60, i64 0
  %v97 = load i64, ptr %v97.p
  %st52 = getelementptr i64, ptr %v96, i64 0
  store i64 %v97, ptr %st52
  %v98.p = getelementptr i64, ptr %v60, i64 1
  %v98 = load i64, ptr %v98.p
  %st53 = getelementptr i64, ptr %v96, i64 1
  store i64 %v98, ptr %st53
  %v99.p = getelementptr i64, ptr %v60, i64 2
  %v99 = load i64, ptr %v99.p
  %st54 = getelementptr i64, ptr %v96, i64 2
  store i64 %v99, ptr %st54
  %v100 = add i64 0, 48
  %v101.p = getelementptr i64, ptr %v96, i64 2
  %v101 = load i64, ptr %v101.p
  %v102.p = getelementptr i64, ptr %v96, i64 0
  %v102 = load i64, ptr %v102.p
  %v103.p = getelementptr i64, ptr %v96, i64 1
  %v103 = load i64, ptr %v103.p
  %v106 = add i64 %v102, %v103
  %v107 = call i64 @"rt.tip8"(i64 %v101, i64 %v106)
  %v108 = add i64 0, 0
  %v109.c = icmp ne i64 %v107, %v108
  %v109 = zext i1 %v109.c to i64
  %c.b23 = icmp ne i64 %v109, 0
  br i1 %c.b23, label %b23.t56, label %b23.e57
b23.t56:
  br label %b27
b23.e57:
  br label %b26
b24:
  br label %b28
b25:
  %v104 = phi ptr [ %v113, %b26 ], [ %v110, %b27 ]
  %v105 = phi ptr [ %v114, %b26 ], [ %v111, %b27 ]
  %st57 = getelementptr i8, ptr %v105, i64 0
  %st57.b = trunc i64 %v100 to i8
  store i8 %st57.b, ptr %st57
  %v115.p = getelementptr i64, ptr %v96, i64 1
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 1
  %v117 = add i64 %v115, %v116
  %v118 = getelementptr i64, ptr %s1, i64 0
  %v119 = ptrtoint ptr %v104 to i64
  %st58 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st58
  %st59 = getelementptr i64, ptr %v118, i64 1
  store i64 %v117, ptr %st59
  %st60 = getelementptr i64, ptr %v118, i64 2
  store i64 %v101, ptr %st60
  %v120.p = getelementptr i64, ptr %v118, i64 0
  %v120 = load i64, ptr %v120.p
  %st61 = getelementptr i64, ptr %v60, i64 0
  store i64 %v120, ptr %st61
  %v121.p = getelementptr i64, ptr %v118, i64 1
  %v121 = load i64, ptr %v121.p
  %st62 = getelementptr i64, ptr %v60, i64 1
  store i64 %v121, ptr %st62
  %v122.p = getelementptr i64, ptr %v118, i64 2
  %v122 = load i64, ptr %v122.p
  %st63 = getelementptr i64, ptr %v60, i64 2
  store i64 %v122, ptr %st63
  %v123.p = getelementptr i64, ptr %v60, i64 0
  %v123 = load i64, ptr %v123.p
  %st64 = getelementptr i64, ptr %v0, i64 0
  store i64 %v123, ptr %st64
  %v124.p = getelementptr i64, ptr %v60, i64 1
  %v124 = load i64, ptr %v124.p
  %st65 = getelementptr i64, ptr %v0, i64 1
  store i64 %v124, ptr %st65
  %v125.p = getelementptr i64, ptr %v60, i64 2
  %v125 = load i64, ptr %v125.p
  %st66 = getelementptr i64, ptr %v0, i64 2
  store i64 %v125, ptr %st66
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v706 = getelementptr i64, ptr @"rt.meta", i64 0
  %st67 = getelementptr i64, ptr %v706, i64 0
  store i64 %v2, ptr %st67
  ret void
b26:
  %v112 = add i64 0, 1
  %v113 = call ptr @"rt.slice_grow8"(i64 %v102, i64 %v103, i64 %v101, i64 %v112)
  %v114 = getelementptr i8, ptr %v113, i64 %v103
  br label %b25
b27:
  %v110 = inttoptr i64 %v102 to ptr
  %v111 = getelementptr i8, ptr %v110, i64 %v103
  br label %b25
b28:
  %v126 = add i64 0, 0
  %v127 = call ptr @"rt.region_alloc"(i64 %v12, i64 %v126)
  %v128 = add i64 0, 0
  %v129 = getelementptr i64, ptr %s1, i64 0
  %v130 = ptrtoint ptr %v127 to i64
  %st68 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st68
  %st69 = getelementptr i64, ptr %v129, i64 1
  store i64 %v128, ptr %st69
  %st70 = getelementptr i64, ptr %v129, i64 2
  store i64 %v12, ptr %st70
  %v131 = getelementptr i64, ptr %s2, i64 0
  %v132.p = getelementptr i64, ptr %v129, i64 0
  %v132 = load i64, ptr %v132.p
  %st71 = getelementptr i64, ptr %v131, i64 0
  store i64 %v132, ptr %st71
  %v133.p = getelementptr i64, ptr %v129, i64 1
  %v133 = load i64, ptr %v133.p
  %st72 = getelementptr i64, ptr %v131, i64 1
  store i64 %v133, ptr %st72
  %v134.p = getelementptr i64, ptr %v129, i64 2
  %v134 = load i64, ptr %v134.p
  %st73 = getelementptr i64, ptr %v131, i64 2
  store i64 %v134, ptr %st73
  %v135 = add i64 0, 1
  %v136 = add i64 %v2, %v135
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %st74 = getelementptr i64, ptr %v137, i64 2572
  store i64 %v136, ptr %st74
  %v138 = call i64 @"std/internal/floatfmt.exactShort"(ptr %v131, i64 %v26, i64 %v28)
  %v139 = add i64 0, -100000
  %v140.c = icmp ne i64 %v138, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b28 = icmp ne i64 %v140, 0
  br i1 %c.b28, label %b28.t76, label %b28.e77
b28.t76:
  br label %b29
b28.e77:
  br label %b30
b29:
  br label %b31
b30:
  %v141 = add i64 0, 1
  %v142 = add i64 %v2, %v141
  %v143 = getelementptr i64, ptr @"rt.meta", i64 0
  %st77 = getelementptr i64, ptr %v143, i64 2572
  store i64 %v142, ptr %st77
  %v144 = call i64 @"std/internal/floatfmt.shortest"(ptr %v131, i64 %v26, i64 %v28)
  br label %b31
b31:
  %v145 = phi i64 [ %v138, %b29 ], [ %v144, %b30 ]
  %v146.p = getelementptr i64, ptr %v131, i64 1
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 0, 1
  %v148 = sub i64 %v145, %v147
  %v149 = add i64 0, 4
  %v150 = add i64 0, 0
  %v151 = sub i64 %v150, %v149
  %v152.c = icmp slt i64 %v148, %v151
  %v152 = zext i1 %v152.c to i64
  %c.b31 = icmp ne i64 %v152, 0
  br i1 %c.b31, label %b31.t79, label %b31.e80
b31.t79:
  br label %b33
b31.e80:
  br label %b32
b32:
  %v154 = add i64 0, 6
  %v155.c = icmp sge i64 %v148, %v154
  %v155 = zext i1 %v155.c to i64
  br label %b33
b33:
  %v153 = phi i64 [ %v152, %b31.t79 ], [ %v155, %b32 ]
  %c.b33 = icmp ne i64 %v153, 0
  br i1 %c.b33, label %b33.t81, label %b33.e82
b33.t81:
  br label %b34
b33.e82:
  br label %b35
b34:
  %v156 = getelementptr i64, ptr %s1, i64 0
  %v157.p = getelementptr i64, ptr %v60, i64 0
  %v157 = load i64, ptr %v157.p
  %st82 = getelementptr i64, ptr %v156, i64 0
  store i64 %v157, ptr %st82
  %v158.p = getelementptr i64, ptr %v60, i64 1
  %v158 = load i64, ptr %v158.p
  %st83 = getelementptr i64, ptr %v156, i64 1
  store i64 %v158, ptr %st83
  %v159.p = getelementptr i64, ptr %v60, i64 2
  %v159 = load i64, ptr %v159.p
  %st84 = getelementptr i64, ptr %v156, i64 2
  store i64 %v159, ptr %st84
  %v160 = add i64 0, 48
  %v161 = add i64 0, 0
  %v162.p = getelementptr i64, ptr %v131, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.c = icmp uge i64 %v161, %v162
  %v163 = zext i1 %v163.c to i64
  %c.b34 = icmp ne i64 %v163, 0
  br i1 %c.b34, label %b34.t86, label %b34.e87
b34.t86:
  br label %b36
b34.e87:
  br label %b37
b35:
  br label %b97
b36:
  %v164 = add i64 0, 4
  call void @"rt.panic"(i64 %v164)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b37:
  %v165.p = getelementptr i64, ptr %v131, i64 0
  %v165 = load i64, ptr %v165.p
  %v166 = inttoptr i64 %v165 to ptr
  %v167 = add i64 0, 1
  %v168 = mul i64 %v161, %v167
  %v169 = getelementptr i64, ptr %v166, i64 %v168
  %v170.p = getelementptr i64, ptr %v169, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 %v160, %v170
  %v172 = add i64 0, 256
  %v173.c = icmp uge i64 %v171, %v172
  %v173 = zext i1 %v173.c to i64
  %c.b37 = icmp ne i64 %v173, 0
  br i1 %c.b37, label %b37.t88, label %b37.e89
b37.t88:
  br label %b38
b37.e89:
  br label %b39
b38:
  %v174 = add i64 0, 5
  call void @"rt.panic"(i64 %v174)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b39:
  %v175.p = getelementptr i64, ptr %v156, i64 2
  %v175 = load i64, ptr %v175.p
  %v176.p = getelementptr i64, ptr %v156, i64 0
  %v176 = load i64, ptr %v176.p
  %v177.p = getelementptr i64, ptr %v156, i64 1
  %v177 = load i64, ptr %v177.p
  %v180 = add i64 %v176, %v177
  %v181 = call i64 @"rt.tip8"(i64 %v175, i64 %v180)
  %v182 = add i64 0, 0
  %v183.c = icmp ne i64 %v181, %v182
  %v183 = zext i1 %v183.c to i64
  %c.b39 = icmp ne i64 %v183, 0
  br i1 %c.b39, label %b39.t90, label %b39.e91
b39.t90:
  br label %b42
b39.e91:
  br label %b41
b40:
  %v178 = phi ptr [ %v187, %b41 ], [ %v184, %b42 ]
  %v179 = phi ptr [ %v188, %b41 ], [ %v185, %b42 ]
  %st91 = getelementptr i8, ptr %v179, i64 0
  %st91.b = trunc i64 %v171 to i8
  store i8 %st91.b, ptr %st91
  %v189.p = getelementptr i64, ptr %v156, i64 1
  %v189 = load i64, ptr %v189.p
  %v190 = add i64 0, 1
  %v191 = add i64 %v189, %v190
  %v192 = getelementptr i64, ptr %s3, i64 0
  %v193 = ptrtoint ptr %v178 to i64
  %st92 = getelementptr i64, ptr %v192, i64 0
  store i64 %v193, ptr %st92
  %st93 = getelementptr i64, ptr %v192, i64 1
  store i64 %v191, ptr %st93
  %st94 = getelementptr i64, ptr %v192, i64 2
  store i64 %v175, ptr %st94
  %v194.p = getelementptr i64, ptr %v192, i64 0
  %v194 = load i64, ptr %v194.p
  %st95 = getelementptr i64, ptr %v60, i64 0
  store i64 %v194, ptr %st95
  %v195.p = getelementptr i64, ptr %v192, i64 1
  %v195 = load i64, ptr %v195.p
  %st96 = getelementptr i64, ptr %v60, i64 1
  store i64 %v195, ptr %st96
  %v196.p = getelementptr i64, ptr %v192, i64 2
  %v196 = load i64, ptr %v196.p
  %st97 = getelementptr i64, ptr %v60, i64 2
  store i64 %v196, ptr %st97
  %v197 = add i64 0, 1
  %v198.c = icmp sgt i64 %v146, %v197
  %v198 = zext i1 %v198.c to i64
  %c.b40 = icmp ne i64 %v198, 0
  br i1 %c.b40, label %b40.t99, label %b40.e100
b40.t99:
  br label %b43
b40.e100:
  br label %b44
b41:
  %v186 = add i64 0, 1
  %v187 = call ptr @"rt.slice_grow8"(i64 %v176, i64 %v177, i64 %v175, i64 %v186)
  %v188 = getelementptr i8, ptr %v187, i64 %v177
  br label %b40
b42:
  %v184 = inttoptr i64 %v176 to ptr
  %v185 = getelementptr i8, ptr %v184, i64 %v177
  br label %b40
b43:
  %v199 = getelementptr i64, ptr %s3, i64 0
  %v200.p = getelementptr i64, ptr %v60, i64 0
  %v200 = load i64, ptr %v200.p
  %st100 = getelementptr i64, ptr %v199, i64 0
  store i64 %v200, ptr %st100
  %v201.p = getelementptr i64, ptr %v60, i64 1
  %v201 = load i64, ptr %v201.p
  %st101 = getelementptr i64, ptr %v199, i64 1
  store i64 %v201, ptr %st101
  %v202.p = getelementptr i64, ptr %v60, i64 2
  %v202 = load i64, ptr %v202.p
  %st102 = getelementptr i64, ptr %v199, i64 2
  store i64 %v202, ptr %st102
  %v203 = add i64 0, 46
  %v204.p = getelementptr i64, ptr %v199, i64 2
  %v204 = load i64, ptr %v204.p
  %v205.p = getelementptr i64, ptr %v199, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v199, i64 1
  %v206 = load i64, ptr %v206.p
  %v209 = add i64 %v205, %v206
  %v210 = call i64 @"rt.tip8"(i64 %v204, i64 %v209)
  %v211 = add i64 0, 0
  %v212.c = icmp ne i64 %v210, %v211
  %v212 = zext i1 %v212.c to i64
  %c.b43 = icmp ne i64 %v212, 0
  br i1 %c.b43, label %b43.t104, label %b43.e105
b43.t104:
  br label %b47
b43.e105:
  br label %b46
b44:
  br label %b61
b45:
  %v207 = phi ptr [ %v216, %b46 ], [ %v213, %b47 ]
  %v208 = phi ptr [ %v217, %b46 ], [ %v214, %b47 ]
  %st105 = getelementptr i8, ptr %v208, i64 0
  %st105.b = trunc i64 %v203 to i8
  store i8 %st105.b, ptr %st105
  %v218.p = getelementptr i64, ptr %v199, i64 1
  %v218 = load i64, ptr %v218.p
  %v219 = add i64 0, 1
  %v220 = add i64 %v218, %v219
  %v221 = getelementptr i64, ptr %s1, i64 0
  %v222 = ptrtoint ptr %v207 to i64
  %st106 = getelementptr i64, ptr %v221, i64 0
  store i64 %v222, ptr %st106
  %st107 = getelementptr i64, ptr %v221, i64 1
  store i64 %v220, ptr %st107
  %st108 = getelementptr i64, ptr %v221, i64 2
  store i64 %v204, ptr %st108
  %v223.p = getelementptr i64, ptr %v221, i64 0
  %v223 = load i64, ptr %v223.p
  %st109 = getelementptr i64, ptr %v60, i64 0
  store i64 %v223, ptr %st109
  %v224.p = getelementptr i64, ptr %v221, i64 1
  %v224 = load i64, ptr %v224.p
  %st110 = getelementptr i64, ptr %v60, i64 1
  store i64 %v224, ptr %st110
  %v225.p = getelementptr i64, ptr %v221, i64 2
  %v225 = load i64, ptr %v225.p
  %st111 = getelementptr i64, ptr %v60, i64 2
  store i64 %v225, ptr %st111
  %v707 = getelementptr i64, ptr @"rt.meta", i64 0
  %v226.p = getelementptr i64, ptr %v707, i64 0
  %v226 = load i64, ptr %v226.p
  %v227 = add i64 0, 1
  %v228 = getelementptr i64, ptr %s4, i64 0
  %v708 = getelementptr i64, ptr @"rt.meta", i64 0
  %v229.p = getelementptr i64, ptr %v708, i64 0
  %v229 = load i64, ptr %v229.p
  %v230 = getelementptr i64, ptr %s5, i64 0
  %st112 = getelementptr i64, ptr %v230, i64 0
  store i64 %v227, ptr %st112
  %v709 = getelementptr i64, ptr @"rt.meta", i64 0
  %v231.p = getelementptr i64, ptr %v709, i64 0
  %v231 = load i64, ptr %v231.p
  br label %b50
b46:
  %v215 = add i64 0, 1
  %v216 = call ptr @"rt.slice_grow8"(i64 %v205, i64 %v206, i64 %v204, i64 %v215)
  %v217 = getelementptr i8, ptr %v216, i64 %v206
  br label %b45
b47:
  %v213 = inttoptr i64 %v205 to ptr
  %v214 = getelementptr i8, ptr %v213, i64 %v206
  br label %b45
b48:
  %v710 = getelementptr i64, ptr @"rt.meta", i64 0
  %st113 = getelementptr i64, ptr %v710, i64 0
  store i64 %v226, ptr %st113
  br label %b61
b49:
  br label %b48
b50:
  %v711 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v711, i64 0
  store i64 %v231, ptr %st114
  %v232.p = getelementptr i64, ptr %v230, i64 0
  %v232 = load i64, ptr %v232.p
  %v233.c = icmp slt i64 %v232, %v146
  %v233 = zext i1 %v233.c to i64
  %c.b50 = icmp ne i64 %v233, 0
  br i1 %c.b50, label %b50.t116, label %b50.e117
b50.t116:
  br label %b51
b50.e117:
  br label %b52
b51:
  call void @"rt.region_enter"()
  %v712 = getelementptr i64, ptr @"rt.meta", i64 0
  %v234.p = getelementptr i64, ptr %v712, i64 0
  %v234 = load i64, ptr %v234.p
  %v235.p = getelementptr i64, ptr %v230, i64 0
  %v235 = load i64, ptr %v235.p
  %v713 = getelementptr i64, ptr @"rt.meta", i64 0
  %v236.p = getelementptr i64, ptr %v713, i64 0
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 0, 1
  %v238 = add i64 %v2, %v237
  %v239 = getelementptr i64, ptr %s1, i64 0
  %v240.p = getelementptr i64, ptr %v60, i64 0
  %v240 = load i64, ptr %v240.p
  %st117 = getelementptr i64, ptr %v239, i64 0
  store i64 %v240, ptr %st117
  %v241.p = getelementptr i64, ptr %v60, i64 1
  %v241 = load i64, ptr %v241.p
  %st118 = getelementptr i64, ptr %v239, i64 1
  store i64 %v241, ptr %st118
  %v242.p = getelementptr i64, ptr %v60, i64 2
  %v242 = load i64, ptr %v242.p
  %st119 = getelementptr i64, ptr %v239, i64 2
  store i64 %v242, ptr %st119
  %v243 = add i64 0, 48
  %v244.p = getelementptr i64, ptr %v131, i64 1
  %v244 = load i64, ptr %v244.p
  %v245.c = icmp uge i64 %v235, %v244
  %v245 = zext i1 %v245.c to i64
  %c.b51 = icmp ne i64 %v245, 0
  br i1 %c.b51, label %b51.t121, label %b51.e122
b51.t121:
  br label %b54
b51.e122:
  br label %b55
b52:
  %v714 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v714, i64 0
  store i64 %v231, ptr %st122
  br label %b49
b53:
  %v715 = getelementptr i64, ptr @"rt.meta", i64 0
  %st123 = getelementptr i64, ptr %v715, i64 0
  store i64 %v236, ptr %st123
  %v279 = add i64 0, 1
  %v280.p = getelementptr i64, ptr %v230, i64 0
  %v280 = load i64, ptr %v280.p
  %v281 = add i64 %v280, %v279
  %st124 = getelementptr i64, ptr %v230, i64 0
  store i64 %v281, ptr %st124
  br label %b50
b54:
  %v246 = add i64 0, 6
  call void @"rt.panic"(i64 %v246)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b55:
  %v247.p = getelementptr i64, ptr %v131, i64 0
  %v247 = load i64, ptr %v247.p
  %v248 = inttoptr i64 %v247 to ptr
  %v249 = add i64 0, 1
  %v250 = mul i64 %v235, %v249
  %v251 = getelementptr i64, ptr %v248, i64 %v250
  %v252.p = getelementptr i64, ptr %v251, i64 0
  %v252 = load i64, ptr %v252.p
  %v253 = add i64 %v243, %v252
  %v254 = add i64 0, 256
  %v255.c = icmp uge i64 %v253, %v254
  %v255 = zext i1 %v255.c to i64
  %c.b55 = icmp ne i64 %v255, 0
  br i1 %c.b55, label %b55.t126, label %b55.e127
b55.t126:
  br label %b56
b55.e127:
  br label %b57
b56:
  %v256 = add i64 0, 7
  call void @"rt.panic"(i64 %v256)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b57:
  %v257.p = getelementptr i64, ptr %v239, i64 2
  %v257 = load i64, ptr %v257.p
  %v258.p = getelementptr i64, ptr %v239, i64 0
  %v258 = load i64, ptr %v258.p
  %v259.p = getelementptr i64, ptr %v239, i64 1
  %v259 = load i64, ptr %v259.p
  %v262 = add i64 %v258, %v259
  %v263 = call i64 @"rt.tip8"(i64 %v257, i64 %v262)
  %v264 = add i64 0, 0
  %v265.c = icmp ne i64 %v263, %v264
  %v265 = zext i1 %v265.c to i64
  %c.b57 = icmp ne i64 %v265, 0
  br i1 %c.b57, label %b57.t128, label %b57.e129
b57.t128:
  br label %b60
b57.e129:
  br label %b59
b58:
  %v260 = phi ptr [ %v269, %b59 ], [ %v266, %b60 ]
  %v261 = phi ptr [ %v270, %b59 ], [ %v267, %b60 ]
  %st129 = getelementptr i8, ptr %v261, i64 0
  %st129.b = trunc i64 %v253 to i8
  store i8 %st129.b, ptr %st129
  %v271.p = getelementptr i64, ptr %v239, i64 1
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 0, 1
  %v273 = add i64 %v271, %v272
  %v274 = getelementptr i64, ptr %s3, i64 0
  %v275 = ptrtoint ptr %v260 to i64
  %st130 = getelementptr i64, ptr %v274, i64 0
  store i64 %v275, ptr %st130
  %st131 = getelementptr i64, ptr %v274, i64 1
  store i64 %v273, ptr %st131
  %st132 = getelementptr i64, ptr %v274, i64 2
  store i64 %v257, ptr %st132
  %v276.p = getelementptr i64, ptr %v274, i64 0
  %v276 = load i64, ptr %v276.p
  %st133 = getelementptr i64, ptr %v60, i64 0
  store i64 %v276, ptr %st133
  %v277.p = getelementptr i64, ptr %v274, i64 1
  %v277 = load i64, ptr %v277.p
  %st134 = getelementptr i64, ptr %v60, i64 1
  store i64 %v277, ptr %st134
  %v278.p = getelementptr i64, ptr %v274, i64 2
  %v278 = load i64, ptr %v278.p
  %st135 = getelementptr i64, ptr %v60, i64 2
  store i64 %v278, ptr %st135
  br label %b53
b59:
  %v268 = add i64 0, 1
  %v269 = call ptr @"rt.slice_grow8"(i64 %v258, i64 %v259, i64 %v257, i64 %v268)
  %v270 = getelementptr i8, ptr %v269, i64 %v259
  br label %b58
b60:
  %v266 = inttoptr i64 %v258 to ptr
  %v267 = getelementptr i8, ptr %v266, i64 %v259
  br label %b58
b61:
  %v282 = getelementptr i64, ptr %s3, i64 0
  %v283.p = getelementptr i64, ptr %v60, i64 0
  %v283 = load i64, ptr %v283.p
  %st136 = getelementptr i64, ptr %v282, i64 0
  store i64 %v283, ptr %st136
  %v284.p = getelementptr i64, ptr %v60, i64 1
  %v284 = load i64, ptr %v284.p
  %st137 = getelementptr i64, ptr %v282, i64 1
  store i64 %v284, ptr %st137
  %v285.p = getelementptr i64, ptr %v60, i64 2
  %v285 = load i64, ptr %v285.p
  %st138 = getelementptr i64, ptr %v282, i64 2
  store i64 %v285, ptr %st138
  %v286 = add i64 0, 101
  %v287.p = getelementptr i64, ptr %v282, i64 2
  %v287 = load i64, ptr %v287.p
  %v288.p = getelementptr i64, ptr %v282, i64 0
  %v288 = load i64, ptr %v288.p
  %v289.p = getelementptr i64, ptr %v282, i64 1
  %v289 = load i64, ptr %v289.p
  %v292 = add i64 %v288, %v289
  %v293 = call i64 @"rt.tip8"(i64 %v287, i64 %v292)
  %v294 = add i64 0, 0
  %v295.c = icmp ne i64 %v293, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b61 = icmp ne i64 %v295, 0
  br i1 %c.b61, label %b61.t140, label %b61.e141
b61.t140:
  br label %b64
b61.e141:
  br label %b63
b62:
  %v290 = phi ptr [ %v299, %b63 ], [ %v296, %b64 ]
  %v291 = phi ptr [ %v300, %b63 ], [ %v297, %b64 ]
  %st141 = getelementptr i8, ptr %v291, i64 0
  %st141.b = trunc i64 %v286 to i8
  store i8 %st141.b, ptr %st141
  %v301.p = getelementptr i64, ptr %v282, i64 1
  %v301 = load i64, ptr %v301.p
  %v302 = add i64 0, 1
  %v303 = add i64 %v301, %v302
  %v304 = getelementptr i64, ptr %s1, i64 0
  %v305 = ptrtoint ptr %v290 to i64
  %st142 = getelementptr i64, ptr %v304, i64 0
  store i64 %v305, ptr %st142
  %st143 = getelementptr i64, ptr %v304, i64 1
  store i64 %v303, ptr %st143
  %st144 = getelementptr i64, ptr %v304, i64 2
  store i64 %v287, ptr %st144
  %v306.p = getelementptr i64, ptr %v304, i64 0
  %v306 = load i64, ptr %v306.p
  %st145 = getelementptr i64, ptr %v60, i64 0
  store i64 %v306, ptr %st145
  %v307.p = getelementptr i64, ptr %v304, i64 1
  %v307 = load i64, ptr %v307.p
  %st146 = getelementptr i64, ptr %v60, i64 1
  store i64 %v307, ptr %st146
  %v308.p = getelementptr i64, ptr %v304, i64 2
  %v308 = load i64, ptr %v308.p
  %st147 = getelementptr i64, ptr %v60, i64 2
  store i64 %v308, ptr %st147
  %v309 = getelementptr i64, ptr %s5, i64 0
  %st148 = getelementptr i64, ptr %v309, i64 0
  store i64 %v148, ptr %st148
  %v310.p = getelementptr i64, ptr %v309, i64 0
  %v310 = load i64, ptr %v310.p
  %v311 = add i64 0, 0
  %v312.c = icmp slt i64 %v310, %v311
  %v312 = zext i1 %v312.c to i64
  %c.b62 = icmp ne i64 %v312, 0
  br i1 %c.b62, label %b62.t150, label %b62.e151
b62.t150:
  br label %b65
b62.e151:
  br label %b66
b63:
  %v298 = add i64 0, 1
  %v299 = call ptr @"rt.slice_grow8"(i64 %v288, i64 %v289, i64 %v287, i64 %v298)
  %v300 = getelementptr i8, ptr %v299, i64 %v289
  br label %b62
b64:
  %v296 = inttoptr i64 %v288 to ptr
  %v297 = getelementptr i8, ptr %v296, i64 %v289
  br label %b62
b65:
  %v313 = getelementptr i64, ptr %s1, i64 0
  %v314.p = getelementptr i64, ptr %v60, i64 0
  %v314 = load i64, ptr %v314.p
  %st151 = getelementptr i64, ptr %v313, i64 0
  store i64 %v314, ptr %st151
  %v315.p = getelementptr i64, ptr %v60, i64 1
  %v315 = load i64, ptr %v315.p
  %st152 = getelementptr i64, ptr %v313, i64 1
  store i64 %v315, ptr %st152
  %v316.p = getelementptr i64, ptr %v60, i64 2
  %v316 = load i64, ptr %v316.p
  %st153 = getelementptr i64, ptr %v313, i64 2
  store i64 %v316, ptr %st153
  %v317 = add i64 0, 45
  %v318.p = getelementptr i64, ptr %v313, i64 2
  %v318 = load i64, ptr %v318.p
  %v319.p = getelementptr i64, ptr %v313, i64 0
  %v319 = load i64, ptr %v319.p
  %v320.p = getelementptr i64, ptr %v313, i64 1
  %v320 = load i64, ptr %v320.p
  %v323 = add i64 %v319, %v320
  %v324 = call i64 @"rt.tip8"(i64 %v318, i64 %v323)
  %v325 = add i64 0, 0
  %v326.c = icmp ne i64 %v324, %v325
  %v326 = zext i1 %v326.c to i64
  %c.b65 = icmp ne i64 %v326, 0
  br i1 %c.b65, label %b65.t155, label %b65.e156
b65.t155:
  br label %b69
b65.e156:
  br label %b68
b66:
  %v343 = getelementptr i64, ptr %s3, i64 0
  %v344.p = getelementptr i64, ptr %v60, i64 0
  %v344 = load i64, ptr %v344.p
  %st156 = getelementptr i64, ptr %v343, i64 0
  store i64 %v344, ptr %st156
  %v345.p = getelementptr i64, ptr %v60, i64 1
  %v345 = load i64, ptr %v345.p
  %st157 = getelementptr i64, ptr %v343, i64 1
  store i64 %v345, ptr %st157
  %v346.p = getelementptr i64, ptr %v60, i64 2
  %v346 = load i64, ptr %v346.p
  %st158 = getelementptr i64, ptr %v343, i64 2
  store i64 %v346, ptr %st158
  %v347 = add i64 0, 43
  %v348.p = getelementptr i64, ptr %v343, i64 2
  %v348 = load i64, ptr %v348.p
  %v349.p = getelementptr i64, ptr %v343, i64 0
  %v349 = load i64, ptr %v349.p
  %v350.p = getelementptr i64, ptr %v343, i64 1
  %v350 = load i64, ptr %v350.p
  %v353 = add i64 %v349, %v350
  %v354 = call i64 @"rt.tip8"(i64 %v348, i64 %v353)
  %v355 = add i64 0, 0
  %v356.c = icmp ne i64 %v354, %v355
  %v356 = zext i1 %v356.c to i64
  %c.b66 = icmp ne i64 %v356, 0
  br i1 %c.b66, label %b66.t160, label %b66.e161
b66.t160:
  br label %b72
b66.e161:
  br label %b71
b67:
  %v321 = phi ptr [ %v330, %b68 ], [ %v327, %b69 ]
  %v322 = phi ptr [ %v331, %b68 ], [ %v328, %b69 ]
  %st161 = getelementptr i8, ptr %v322, i64 0
  %st161.b = trunc i64 %v317 to i8
  store i8 %st161.b, ptr %st161
  %v332.p = getelementptr i64, ptr %v313, i64 1
  %v332 = load i64, ptr %v332.p
  %v333 = add i64 0, 1
  %v334 = add i64 %v332, %v333
  %v335 = getelementptr i64, ptr %s3, i64 0
  %v336 = ptrtoint ptr %v321 to i64
  %st162 = getelementptr i64, ptr %v335, i64 0
  store i64 %v336, ptr %st162
  %st163 = getelementptr i64, ptr %v335, i64 1
  store i64 %v334, ptr %st163
  %st164 = getelementptr i64, ptr %v335, i64 2
  store i64 %v318, ptr %st164
  %v337.p = getelementptr i64, ptr %v335, i64 0
  %v337 = load i64, ptr %v337.p
  %st165 = getelementptr i64, ptr %v60, i64 0
  store i64 %v337, ptr %st165
  %v338.p = getelementptr i64, ptr %v335, i64 1
  %v338 = load i64, ptr %v338.p
  %st166 = getelementptr i64, ptr %v60, i64 1
  store i64 %v338, ptr %st166
  %v339.p = getelementptr i64, ptr %v335, i64 2
  %v339 = load i64, ptr %v339.p
  %st167 = getelementptr i64, ptr %v60, i64 2
  store i64 %v339, ptr %st167
  %v340 = add i64 0, 0
  %v341.p = getelementptr i64, ptr %v309, i64 0
  %v341 = load i64, ptr %v341.p
  %v342 = sub i64 %v340, %v341
  %st168 = getelementptr i64, ptr %v309, i64 0
  store i64 %v342, ptr %st168
  br label %b73
b68:
  %v329 = add i64 0, 1
  %v330 = call ptr @"rt.slice_grow8"(i64 %v319, i64 %v320, i64 %v318, i64 %v329)
  %v331 = getelementptr i8, ptr %v330, i64 %v320
  br label %b67
b69:
  %v327 = inttoptr i64 %v319 to ptr
  %v328 = getelementptr i8, ptr %v327, i64 %v320
  br label %b67
b70:
  %v351 = phi ptr [ %v360, %b71 ], [ %v357, %b72 ]
  %v352 = phi ptr [ %v361, %b71 ], [ %v358, %b72 ]
  %st169 = getelementptr i8, ptr %v352, i64 0
  %st169.b = trunc i64 %v347 to i8
  store i8 %st169.b, ptr %st169
  %v362.p = getelementptr i64, ptr %v343, i64 1
  %v362 = load i64, ptr %v362.p
  %v363 = add i64 0, 1
  %v364 = add i64 %v362, %v363
  %v365 = getelementptr i64, ptr %s1, i64 0
  %v366 = ptrtoint ptr %v351 to i64
  %st170 = getelementptr i64, ptr %v365, i64 0
  store i64 %v366, ptr %st170
  %st171 = getelementptr i64, ptr %v365, i64 1
  store i64 %v364, ptr %st171
  %st172 = getelementptr i64, ptr %v365, i64 2
  store i64 %v348, ptr %st172
  %v367.p = getelementptr i64, ptr %v365, i64 0
  %v367 = load i64, ptr %v367.p
  %st173 = getelementptr i64, ptr %v60, i64 0
  store i64 %v367, ptr %st173
  %v368.p = getelementptr i64, ptr %v365, i64 1
  %v368 = load i64, ptr %v368.p
  %st174 = getelementptr i64, ptr %v60, i64 1
  store i64 %v368, ptr %st174
  %v369.p = getelementptr i64, ptr %v365, i64 2
  %v369 = load i64, ptr %v369.p
  %st175 = getelementptr i64, ptr %v60, i64 2
  store i64 %v369, ptr %st175
  br label %b73
b71:
  %v359 = add i64 0, 1
  %v360 = call ptr @"rt.slice_grow8"(i64 %v349, i64 %v350, i64 %v348, i64 %v359)
  %v361 = getelementptr i8, ptr %v360, i64 %v350
  br label %b70
b72:
  %v357 = inttoptr i64 %v349 to ptr
  %v358 = getelementptr i8, ptr %v357, i64 %v350
  br label %b70
b73:
  %v370.p = getelementptr i64, ptr %v309, i64 0
  %v370 = load i64, ptr %v370.p
  %v371 = add i64 0, 100
  %v372.c = icmp sge i64 %v370, %v371
  %v372 = zext i1 %v372.c to i64
  %c.b73 = icmp ne i64 %v372, 0
  br i1 %c.b73, label %b73.t177, label %b73.e178
b73.t177:
  br label %b74
b73.e178:
  br label %b75
b74:
  %v373 = getelementptr i64, ptr %s1, i64 0
  %v374.p = getelementptr i64, ptr %v60, i64 0
  %v374 = load i64, ptr %v374.p
  %st178 = getelementptr i64, ptr %v373, i64 0
  store i64 %v374, ptr %st178
  %v375.p = getelementptr i64, ptr %v60, i64 1
  %v375 = load i64, ptr %v375.p
  %st179 = getelementptr i64, ptr %v373, i64 1
  store i64 %v375, ptr %st179
  %v376.p = getelementptr i64, ptr %v60, i64 2
  %v376 = load i64, ptr %v376.p
  %st180 = getelementptr i64, ptr %v373, i64 2
  store i64 %v376, ptr %st180
  %v377 = add i64 0, 48
  %v378.p = getelementptr i64, ptr %v309, i64 0
  %v378 = load i64, ptr %v378.p
  %v379 = add i64 0, 100
  %v380 = sdiv i64 %v378, %v379
  %v381 = add i64 %v377, %v380
  %v382 = add i64 0, 256
  %v383.c = icmp uge i64 %v381, %v382
  %v383 = zext i1 %v383.c to i64
  %c.b74 = icmp ne i64 %v383, 0
  br i1 %c.b74, label %b74.t182, label %b74.e183
b74.t182:
  br label %b76
b74.e183:
  br label %b77
b75:
  %v443 = getelementptr i64, ptr %s1, i64 0
  %v444.p = getelementptr i64, ptr %v60, i64 0
  %v444 = load i64, ptr %v444.p
  %st183 = getelementptr i64, ptr %v443, i64 0
  store i64 %v444, ptr %st183
  %v445.p = getelementptr i64, ptr %v60, i64 1
  %v445 = load i64, ptr %v445.p
  %st184 = getelementptr i64, ptr %v443, i64 1
  store i64 %v445, ptr %st184
  %v446.p = getelementptr i64, ptr %v60, i64 2
  %v446 = load i64, ptr %v446.p
  %st185 = getelementptr i64, ptr %v443, i64 2
  store i64 %v446, ptr %st185
  %v447 = add i64 0, 48
  %v448.p = getelementptr i64, ptr %v309, i64 0
  %v448 = load i64, ptr %v448.p
  %v449 = add i64 0, 10
  %v450 = sdiv i64 %v448, %v449
  %v451 = add i64 %v447, %v450
  %v452 = add i64 0, 256
  %v453.c = icmp uge i64 %v451, %v452
  %v453 = zext i1 %v453.c to i64
  %c.b75 = icmp ne i64 %v453, 0
  br i1 %c.b75, label %b75.t187, label %b75.e188
b75.t187:
  br label %b86
b75.e188:
  br label %b87
b76:
  %v384 = add i64 0, 8
  call void @"rt.panic"(i64 %v384)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b77:
  %v385.p = getelementptr i64, ptr %v373, i64 2
  %v385 = load i64, ptr %v385.p
  %v386.p = getelementptr i64, ptr %v373, i64 0
  %v386 = load i64, ptr %v386.p
  %v387.p = getelementptr i64, ptr %v373, i64 1
  %v387 = load i64, ptr %v387.p
  %v390 = add i64 %v386, %v387
  %v391 = call i64 @"rt.tip8"(i64 %v385, i64 %v390)
  %v392 = add i64 0, 0
  %v393.c = icmp ne i64 %v391, %v392
  %v393 = zext i1 %v393.c to i64
  %c.b77 = icmp ne i64 %v393, 0
  br i1 %c.b77, label %b77.t189, label %b77.e190
b77.t189:
  br label %b80
b77.e190:
  br label %b79
b78:
  %v388 = phi ptr [ %v397, %b79 ], [ %v394, %b80 ]
  %v389 = phi ptr [ %v398, %b79 ], [ %v395, %b80 ]
  %st190 = getelementptr i8, ptr %v389, i64 0
  %st190.b = trunc i64 %v381 to i8
  store i8 %st190.b, ptr %st190
  %v399.p = getelementptr i64, ptr %v373, i64 1
  %v399 = load i64, ptr %v399.p
  %v400 = add i64 0, 1
  %v401 = add i64 %v399, %v400
  %v402 = getelementptr i64, ptr %s3, i64 0
  %v403 = ptrtoint ptr %v388 to i64
  %st191 = getelementptr i64, ptr %v402, i64 0
  store i64 %v403, ptr %st191
  %st192 = getelementptr i64, ptr %v402, i64 1
  store i64 %v401, ptr %st192
  %st193 = getelementptr i64, ptr %v402, i64 2
  store i64 %v385, ptr %st193
  %v404.p = getelementptr i64, ptr %v402, i64 0
  %v404 = load i64, ptr %v404.p
  %st194 = getelementptr i64, ptr %v60, i64 0
  store i64 %v404, ptr %st194
  %v405.p = getelementptr i64, ptr %v402, i64 1
  %v405 = load i64, ptr %v405.p
  %st195 = getelementptr i64, ptr %v60, i64 1
  store i64 %v405, ptr %st195
  %v406.p = getelementptr i64, ptr %v402, i64 2
  %v406 = load i64, ptr %v406.p
  %st196 = getelementptr i64, ptr %v60, i64 2
  store i64 %v406, ptr %st196
  %v407 = getelementptr i64, ptr %s3, i64 0
  %v408.p = getelementptr i64, ptr %v60, i64 0
  %v408 = load i64, ptr %v408.p
  %st197 = getelementptr i64, ptr %v407, i64 0
  store i64 %v408, ptr %st197
  %v409.p = getelementptr i64, ptr %v60, i64 1
  %v409 = load i64, ptr %v409.p
  %st198 = getelementptr i64, ptr %v407, i64 1
  store i64 %v409, ptr %st198
  %v410.p = getelementptr i64, ptr %v60, i64 2
  %v410 = load i64, ptr %v410.p
  %st199 = getelementptr i64, ptr %v407, i64 2
  store i64 %v410, ptr %st199
  %v411 = add i64 0, 48
  %v412.p = getelementptr i64, ptr %v309, i64 0
  %v412 = load i64, ptr %v412.p
  %v413 = add i64 0, 10
  %v414 = sdiv i64 %v412, %v413
  %v415 = add i64 0, 10
  %v416 = srem i64 %v414, %v415
  %v417 = add i64 %v411, %v416
  %v418 = add i64 0, 256
  %v419.c = icmp uge i64 %v417, %v418
  %v419 = zext i1 %v419.c to i64
  %c.b78 = icmp ne i64 %v419, 0
  br i1 %c.b78, label %b78.t201, label %b78.e202
b78.t201:
  br label %b81
b78.e202:
  br label %b82
b79:
  %v396 = add i64 0, 1
  %v397 = call ptr @"rt.slice_grow8"(i64 %v386, i64 %v387, i64 %v385, i64 %v396)
  %v398 = getelementptr i8, ptr %v397, i64 %v387
  br label %b78
b80:
  %v394 = inttoptr i64 %v386 to ptr
  %v395 = getelementptr i8, ptr %v394, i64 %v387
  br label %b78
b81:
  %v420 = add i64 0, 9
  call void @"rt.panic"(i64 %v420)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b82:
  %v421.p = getelementptr i64, ptr %v407, i64 2
  %v421 = load i64, ptr %v421.p
  %v422.p = getelementptr i64, ptr %v407, i64 0
  %v422 = load i64, ptr %v422.p
  %v423.p = getelementptr i64, ptr %v407, i64 1
  %v423 = load i64, ptr %v423.p
  %v426 = add i64 %v422, %v423
  %v427 = call i64 @"rt.tip8"(i64 %v421, i64 %v426)
  %v428 = add i64 0, 0
  %v429.c = icmp ne i64 %v427, %v428
  %v429 = zext i1 %v429.c to i64
  %c.b82 = icmp ne i64 %v429, 0
  br i1 %c.b82, label %b82.t203, label %b82.e204
b82.t203:
  br label %b85
b82.e204:
  br label %b84
b83:
  %v424 = phi ptr [ %v433, %b84 ], [ %v430, %b85 ]
  %v425 = phi ptr [ %v434, %b84 ], [ %v431, %b85 ]
  %st204 = getelementptr i8, ptr %v425, i64 0
  %st204.b = trunc i64 %v417 to i8
  store i8 %st204.b, ptr %st204
  %v435.p = getelementptr i64, ptr %v407, i64 1
  %v435 = load i64, ptr %v435.p
  %v436 = add i64 0, 1
  %v437 = add i64 %v435, %v436
  %v438 = getelementptr i64, ptr %s1, i64 0
  %v439 = ptrtoint ptr %v424 to i64
  %st205 = getelementptr i64, ptr %v438, i64 0
  store i64 %v439, ptr %st205
  %st206 = getelementptr i64, ptr %v438, i64 1
  store i64 %v437, ptr %st206
  %st207 = getelementptr i64, ptr %v438, i64 2
  store i64 %v421, ptr %st207
  %v440.p = getelementptr i64, ptr %v438, i64 0
  %v440 = load i64, ptr %v440.p
  %st208 = getelementptr i64, ptr %v60, i64 0
  store i64 %v440, ptr %st208
  %v441.p = getelementptr i64, ptr %v438, i64 1
  %v441 = load i64, ptr %v441.p
  %st209 = getelementptr i64, ptr %v60, i64 1
  store i64 %v441, ptr %st209
  %v442.p = getelementptr i64, ptr %v438, i64 2
  %v442 = load i64, ptr %v442.p
  %st210 = getelementptr i64, ptr %v60, i64 2
  store i64 %v442, ptr %st210
  br label %b91
b84:
  %v432 = add i64 0, 1
  %v433 = call ptr @"rt.slice_grow8"(i64 %v422, i64 %v423, i64 %v421, i64 %v432)
  %v434 = getelementptr i8, ptr %v433, i64 %v423
  br label %b83
b85:
  %v430 = inttoptr i64 %v422 to ptr
  %v431 = getelementptr i8, ptr %v430, i64 %v423
  br label %b83
b86:
  %v454 = add i64 0, 10
  call void @"rt.panic"(i64 %v454)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b87:
  %v455.p = getelementptr i64, ptr %v443, i64 2
  %v455 = load i64, ptr %v455.p
  %v456.p = getelementptr i64, ptr %v443, i64 0
  %v456 = load i64, ptr %v456.p
  %v457.p = getelementptr i64, ptr %v443, i64 1
  %v457 = load i64, ptr %v457.p
  %v460 = add i64 %v456, %v457
  %v461 = call i64 @"rt.tip8"(i64 %v455, i64 %v460)
  %v462 = add i64 0, 0
  %v463.c = icmp ne i64 %v461, %v462
  %v463 = zext i1 %v463.c to i64
  %c.b87 = icmp ne i64 %v463, 0
  br i1 %c.b87, label %b87.t212, label %b87.e213
b87.t212:
  br label %b90
b87.e213:
  br label %b89
b88:
  %v458 = phi ptr [ %v467, %b89 ], [ %v464, %b90 ]
  %v459 = phi ptr [ %v468, %b89 ], [ %v465, %b90 ]
  %st213 = getelementptr i8, ptr %v459, i64 0
  %st213.b = trunc i64 %v451 to i8
  store i8 %st213.b, ptr %st213
  %v469.p = getelementptr i64, ptr %v443, i64 1
  %v469 = load i64, ptr %v469.p
  %v470 = add i64 0, 1
  %v471 = add i64 %v469, %v470
  %v472 = getelementptr i64, ptr %s3, i64 0
  %v473 = ptrtoint ptr %v458 to i64
  %st214 = getelementptr i64, ptr %v472, i64 0
  store i64 %v473, ptr %st214
  %st215 = getelementptr i64, ptr %v472, i64 1
  store i64 %v471, ptr %st215
  %st216 = getelementptr i64, ptr %v472, i64 2
  store i64 %v455, ptr %st216
  %v474.p = getelementptr i64, ptr %v472, i64 0
  %v474 = load i64, ptr %v474.p
  %st217 = getelementptr i64, ptr %v60, i64 0
  store i64 %v474, ptr %st217
  %v475.p = getelementptr i64, ptr %v472, i64 1
  %v475 = load i64, ptr %v475.p
  %st218 = getelementptr i64, ptr %v60, i64 1
  store i64 %v475, ptr %st218
  %v476.p = getelementptr i64, ptr %v472, i64 2
  %v476 = load i64, ptr %v476.p
  %st219 = getelementptr i64, ptr %v60, i64 2
  store i64 %v476, ptr %st219
  br label %b91
b89:
  %v466 = add i64 0, 1
  %v467 = call ptr @"rt.slice_grow8"(i64 %v456, i64 %v457, i64 %v455, i64 %v466)
  %v468 = getelementptr i8, ptr %v467, i64 %v457
  br label %b88
b90:
  %v464 = inttoptr i64 %v456 to ptr
  %v465 = getelementptr i8, ptr %v464, i64 %v457
  br label %b88
b91:
  %v477 = getelementptr i64, ptr %s3, i64 0
  %v478.p = getelementptr i64, ptr %v60, i64 0
  %v478 = load i64, ptr %v478.p
  %st220 = getelementptr i64, ptr %v477, i64 0
  store i64 %v478, ptr %st220
  %v479.p = getelementptr i64, ptr %v60, i64 1
  %v479 = load i64, ptr %v479.p
  %st221 = getelementptr i64, ptr %v477, i64 1
  store i64 %v479, ptr %st221
  %v480.p = getelementptr i64, ptr %v60, i64 2
  %v480 = load i64, ptr %v480.p
  %st222 = getelementptr i64, ptr %v477, i64 2
  store i64 %v480, ptr %st222
  %v481 = add i64 0, 48
  %v482.p = getelementptr i64, ptr %v309, i64 0
  %v482 = load i64, ptr %v482.p
  %v483 = add i64 0, 10
  %v484 = srem i64 %v482, %v483
  %v485 = add i64 %v481, %v484
  %v486 = add i64 0, 256
  %v487.c = icmp uge i64 %v485, %v486
  %v487 = zext i1 %v487.c to i64
  %c.b91 = icmp ne i64 %v487, 0
  br i1 %c.b91, label %b91.t224, label %b91.e225
b91.t224:
  br label %b92
b91.e225:
  br label %b93
b92:
  %v488 = add i64 0, 11
  call void @"rt.panic"(i64 %v488)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b93:
  %v489.p = getelementptr i64, ptr %v477, i64 2
  %v489 = load i64, ptr %v489.p
  %v490.p = getelementptr i64, ptr %v477, i64 0
  %v490 = load i64, ptr %v490.p
  %v491.p = getelementptr i64, ptr %v477, i64 1
  %v491 = load i64, ptr %v491.p
  %v494 = add i64 %v490, %v491
  %v495 = call i64 @"rt.tip8"(i64 %v489, i64 %v494)
  %v496 = add i64 0, 0
  %v497.c = icmp ne i64 %v495, %v496
  %v497 = zext i1 %v497.c to i64
  %c.b93 = icmp ne i64 %v497, 0
  br i1 %c.b93, label %b93.t226, label %b93.e227
b93.t226:
  br label %b96
b93.e227:
  br label %b95
b94:
  %v492 = phi ptr [ %v501, %b95 ], [ %v498, %b96 ]
  %v493 = phi ptr [ %v502, %b95 ], [ %v499, %b96 ]
  %st227 = getelementptr i8, ptr %v493, i64 0
  %st227.b = trunc i64 %v485 to i8
  store i8 %st227.b, ptr %st227
  %v503.p = getelementptr i64, ptr %v477, i64 1
  %v503 = load i64, ptr %v503.p
  %v504 = add i64 0, 1
  %v505 = add i64 %v503, %v504
  %v506 = getelementptr i64, ptr %s1, i64 0
  %v507 = ptrtoint ptr %v492 to i64
  %st228 = getelementptr i64, ptr %v506, i64 0
  store i64 %v507, ptr %st228
  %st229 = getelementptr i64, ptr %v506, i64 1
  store i64 %v505, ptr %st229
  %st230 = getelementptr i64, ptr %v506, i64 2
  store i64 %v489, ptr %st230
  %v508.p = getelementptr i64, ptr %v506, i64 0
  %v508 = load i64, ptr %v508.p
  %st231 = getelementptr i64, ptr %v60, i64 0
  store i64 %v508, ptr %st231
  %v509.p = getelementptr i64, ptr %v506, i64 1
  %v509 = load i64, ptr %v509.p
  %st232 = getelementptr i64, ptr %v60, i64 1
  store i64 %v509, ptr %st232
  %v510.p = getelementptr i64, ptr %v506, i64 2
  %v510 = load i64, ptr %v510.p
  %st233 = getelementptr i64, ptr %v60, i64 2
  store i64 %v510, ptr %st233
  %v511.p = getelementptr i64, ptr %v60, i64 0
  %v511 = load i64, ptr %v511.p
  %st234 = getelementptr i64, ptr %v0, i64 0
  store i64 %v511, ptr %st234
  %v512.p = getelementptr i64, ptr %v60, i64 1
  %v512 = load i64, ptr %v512.p
  %st235 = getelementptr i64, ptr %v0, i64 1
  store i64 %v512, ptr %st235
  %v513.p = getelementptr i64, ptr %v60, i64 2
  %v513 = load i64, ptr %v513.p
  %st236 = getelementptr i64, ptr %v0, i64 2
  store i64 %v513, ptr %st236
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v716 = getelementptr i64, ptr @"rt.meta", i64 0
  %st237 = getelementptr i64, ptr %v716, i64 0
  store i64 %v2, ptr %st237
  ret void
b95:
  %v500 = add i64 0, 1
  %v501 = call ptr @"rt.slice_grow8"(i64 %v490, i64 %v491, i64 %v489, i64 %v500)
  %v502 = getelementptr i8, ptr %v501, i64 %v491
  br label %b94
b96:
  %v498 = inttoptr i64 %v490 to ptr
  %v499 = getelementptr i8, ptr %v498, i64 %v491
  br label %b94
b97:
  %v514 = add i64 0, 0
  %v515.c = icmp sgt i64 %v145, %v514
  %v515 = zext i1 %v515.c to i64
  %c.b97 = icmp ne i64 %v515, 0
  br i1 %c.b97, label %b97.t239, label %b97.e240
b97.t239:
  br label %b98
b97.e240:
  br label %b99
b98:
  %v717 = getelementptr i64, ptr @"rt.meta", i64 0
  %v516.p = getelementptr i64, ptr %v717, i64 0
  %v516 = load i64, ptr %v516.p
  %v517 = add i64 0, 0
  %v518 = getelementptr i64, ptr %s5, i64 0
  %v718 = getelementptr i64, ptr @"rt.meta", i64 0
  %v519.p = getelementptr i64, ptr %v718, i64 0
  %v519 = load i64, ptr %v519.p
  %v520 = getelementptr i64, ptr %s4, i64 0
  %st240 = getelementptr i64, ptr %v520, i64 0
  store i64 %v517, ptr %st240
  %v719 = getelementptr i64, ptr @"rt.meta", i64 0
  %v521.p = getelementptr i64, ptr %v719, i64 0
  %v521 = load i64, ptr %v521.p
  br label %b102
b99:
  %v575 = getelementptr i64, ptr %s3, i64 0
  %v576.p = getelementptr i64, ptr %v60, i64 0
  %v576 = load i64, ptr %v576.p
  %st241 = getelementptr i64, ptr %v575, i64 0
  store i64 %v576, ptr %st241
  %v577.p = getelementptr i64, ptr %v60, i64 1
  %v577 = load i64, ptr %v577.p
  %st242 = getelementptr i64, ptr %v575, i64 1
  store i64 %v577, ptr %st242
  %v578.p = getelementptr i64, ptr %v60, i64 2
  %v578 = load i64, ptr %v578.p
  %st243 = getelementptr i64, ptr %v575, i64 2
  store i64 %v578, ptr %st243
  %v579 = add i64 0, 48
  %v580.p = getelementptr i64, ptr %v575, i64 2
  %v580 = load i64, ptr %v580.p
  %v581.p = getelementptr i64, ptr %v575, i64 0
  %v581 = load i64, ptr %v581.p
  %v582.p = getelementptr i64, ptr %v575, i64 1
  %v582 = load i64, ptr %v582.p
  %v585 = add i64 %v581, %v582
  %v586 = call i64 @"rt.tip8"(i64 %v580, i64 %v585)
  %v587 = add i64 0, 0
  %v588.c = icmp ne i64 %v586, %v587
  %v588 = zext i1 %v588.c to i64
  %c.b99 = icmp ne i64 %v588, 0
  br i1 %c.b99, label %b99.t245, label %b99.e246
b99.t245:
  br label %b118
b99.e246:
  br label %b117
b100:
  %v720 = getelementptr i64, ptr @"rt.meta", i64 0
  %st246 = getelementptr i64, ptr %v720, i64 0
  store i64 %v516, ptr %st246
  br label %b119
b101:
  br label %b100
b102:
  %v721 = getelementptr i64, ptr @"rt.meta", i64 0
  %st247 = getelementptr i64, ptr %v721, i64 0
  store i64 %v521, ptr %st247
  %v522.p = getelementptr i64, ptr %v520, i64 0
  %v522 = load i64, ptr %v522.p
  %v523.c = icmp slt i64 %v522, %v145
  %v523 = zext i1 %v523.c to i64
  %c.b102 = icmp ne i64 %v523, 0
  br i1 %c.b102, label %b102.t249, label %b102.e250
b102.t249:
  br label %b103
b102.e250:
  br label %b104
b103:
  call void @"rt.region_enter"()
  %v722 = getelementptr i64, ptr @"rt.meta", i64 0
  %v524.p = getelementptr i64, ptr %v722, i64 0
  %v524 = load i64, ptr %v524.p
  %v525.p = getelementptr i64, ptr %v520, i64 0
  %v525 = load i64, ptr %v525.p
  %v723 = getelementptr i64, ptr @"rt.meta", i64 0
  %v526.p = getelementptr i64, ptr %v723, i64 0
  %v526 = load i64, ptr %v526.p
  %v527 = add i64 0, 1
  %v528 = add i64 %v2, %v527
  %v529 = getelementptr i64, ptr %s1, i64 0
  %v530.p = getelementptr i64, ptr %v60, i64 0
  %v530 = load i64, ptr %v530.p
  %st250 = getelementptr i64, ptr %v529, i64 0
  store i64 %v530, ptr %st250
  %v531.p = getelementptr i64, ptr %v60, i64 1
  %v531 = load i64, ptr %v531.p
  %st251 = getelementptr i64, ptr %v529, i64 1
  store i64 %v531, ptr %st251
  %v532.p = getelementptr i64, ptr %v60, i64 2
  %v532 = load i64, ptr %v532.p
  %st252 = getelementptr i64, ptr %v529, i64 2
  store i64 %v532, ptr %st252
  %v533 = add i64 0, 48
  %v534.c = icmp slt i64 %v525, %v146
  %v534 = zext i1 %v534.c to i64
  %c.b103 = icmp ne i64 %v534, 0
  br i1 %c.b103, label %b103.t254, label %b103.e255
b103.t254:
  br label %b106
b103.e255:
  br label %b107
b104:
  %v724 = getelementptr i64, ptr @"rt.meta", i64 0
  %st255 = getelementptr i64, ptr %v724, i64 0
  store i64 %v521, ptr %st255
  br label %b101
b105:
  %v725 = getelementptr i64, ptr @"rt.meta", i64 0
  %st256 = getelementptr i64, ptr %v725, i64 0
  store i64 %v526, ptr %st256
  %v572 = add i64 0, 1
  %v573.p = getelementptr i64, ptr %v520, i64 0
  %v573 = load i64, ptr %v573.p
  %v574 = add i64 %v573, %v572
  %st257 = getelementptr i64, ptr %v520, i64 0
  store i64 %v574, ptr %st257
  br label %b102
b106:
  %v535.p = getelementptr i64, ptr %v131, i64 1
  %v535 = load i64, ptr %v535.p
  %v536.c = icmp uge i64 %v525, %v535
  %v536 = zext i1 %v536.c to i64
  %c.b106 = icmp ne i64 %v536, 0
  br i1 %c.b106, label %b106.t259, label %b106.e260
b106.t259:
  br label %b108
b106.e260:
  br label %b109
b107:
  %v544 = add i64 0, 0
  br label %b110
b108:
  %v537 = add i64 0, 12
  call void @"rt.panic"(i64 %v537)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b109:
  %v538.p = getelementptr i64, ptr %v131, i64 0
  %v538 = load i64, ptr %v538.p
  %v539 = inttoptr i64 %v538 to ptr
  %v540 = add i64 0, 1
  %v541 = mul i64 %v525, %v540
  %v542 = getelementptr i64, ptr %v539, i64 %v541
  %v543.p = getelementptr i64, ptr %v542, i64 0
  %v543 = load i64, ptr %v543.p
  br label %b110
b110:
  %v545 = phi i64 [ %v544, %b107 ], [ %v543, %b109 ]
  %v546 = add i64 %v533, %v545
  %v547 = add i64 0, 256
  %v548.c = icmp uge i64 %v546, %v547
  %v548 = zext i1 %v548.c to i64
  %c.b110 = icmp ne i64 %v548, 0
  br i1 %c.b110, label %b110.t261, label %b110.e262
b110.t261:
  br label %b111
b110.e262:
  br label %b112
b111:
  %v549 = add i64 0, 13
  call void @"rt.panic"(i64 %v549)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b112:
  %v550.p = getelementptr i64, ptr %v529, i64 2
  %v550 = load i64, ptr %v550.p
  %v551.p = getelementptr i64, ptr %v529, i64 0
  %v551 = load i64, ptr %v551.p
  %v552.p = getelementptr i64, ptr %v529, i64 1
  %v552 = load i64, ptr %v552.p
  %v555 = add i64 %v551, %v552
  %v556 = call i64 @"rt.tip8"(i64 %v550, i64 %v555)
  %v557 = add i64 0, 0
  %v558.c = icmp ne i64 %v556, %v557
  %v558 = zext i1 %v558.c to i64
  %c.b112 = icmp ne i64 %v558, 0
  br i1 %c.b112, label %b112.t263, label %b112.e264
b112.t263:
  br label %b115
b112.e264:
  br label %b114
b113:
  %v553 = phi ptr [ %v562, %b114 ], [ %v559, %b115 ]
  %v554 = phi ptr [ %v563, %b114 ], [ %v560, %b115 ]
  %st264 = getelementptr i8, ptr %v554, i64 0
  %st264.b = trunc i64 %v546 to i8
  store i8 %st264.b, ptr %st264
  %v564.p = getelementptr i64, ptr %v529, i64 1
  %v564 = load i64, ptr %v564.p
  %v565 = add i64 0, 1
  %v566 = add i64 %v564, %v565
  %v567 = getelementptr i64, ptr %s3, i64 0
  %v568 = ptrtoint ptr %v553 to i64
  %st265 = getelementptr i64, ptr %v567, i64 0
  store i64 %v568, ptr %st265
  %st266 = getelementptr i64, ptr %v567, i64 1
  store i64 %v566, ptr %st266
  %st267 = getelementptr i64, ptr %v567, i64 2
  store i64 %v550, ptr %st267
  %v569.p = getelementptr i64, ptr %v567, i64 0
  %v569 = load i64, ptr %v569.p
  %st268 = getelementptr i64, ptr %v60, i64 0
  store i64 %v569, ptr %st268
  %v570.p = getelementptr i64, ptr %v567, i64 1
  %v570 = load i64, ptr %v570.p
  %st269 = getelementptr i64, ptr %v60, i64 1
  store i64 %v570, ptr %st269
  %v571.p = getelementptr i64, ptr %v567, i64 2
  %v571 = load i64, ptr %v571.p
  %st270 = getelementptr i64, ptr %v60, i64 2
  store i64 %v571, ptr %st270
  br label %b105
b114:
  %v561 = add i64 0, 1
  %v562 = call ptr @"rt.slice_grow8"(i64 %v551, i64 %v552, i64 %v550, i64 %v561)
  %v563 = getelementptr i8, ptr %v562, i64 %v552
  br label %b113
b115:
  %v559 = inttoptr i64 %v551 to ptr
  %v560 = getelementptr i8, ptr %v559, i64 %v552
  br label %b113
b116:
  %v583 = phi ptr [ %v592, %b117 ], [ %v589, %b118 ]
  %v584 = phi ptr [ %v593, %b117 ], [ %v590, %b118 ]
  %st271 = getelementptr i8, ptr %v584, i64 0
  %st271.b = trunc i64 %v579 to i8
  store i8 %st271.b, ptr %st271
  %v594.p = getelementptr i64, ptr %v575, i64 1
  %v594 = load i64, ptr %v594.p
  %v595 = add i64 0, 1
  %v596 = add i64 %v594, %v595
  %v597 = getelementptr i64, ptr %s1, i64 0
  %v598 = ptrtoint ptr %v583 to i64
  %st272 = getelementptr i64, ptr %v597, i64 0
  store i64 %v598, ptr %st272
  %st273 = getelementptr i64, ptr %v597, i64 1
  store i64 %v596, ptr %st273
  %st274 = getelementptr i64, ptr %v597, i64 2
  store i64 %v580, ptr %st274
  %v599.p = getelementptr i64, ptr %v597, i64 0
  %v599 = load i64, ptr %v599.p
  %st275 = getelementptr i64, ptr %v60, i64 0
  store i64 %v599, ptr %st275
  %v600.p = getelementptr i64, ptr %v597, i64 1
  %v600 = load i64, ptr %v600.p
  %st276 = getelementptr i64, ptr %v60, i64 1
  store i64 %v600, ptr %st276
  %v601.p = getelementptr i64, ptr %v597, i64 2
  %v601 = load i64, ptr %v601.p
  %st277 = getelementptr i64, ptr %v60, i64 2
  store i64 %v601, ptr %st277
  br label %b119
b117:
  %v591 = add i64 0, 1
  %v592 = call ptr @"rt.slice_grow8"(i64 %v581, i64 %v582, i64 %v580, i64 %v591)
  %v593 = getelementptr i8, ptr %v592, i64 %v582
  br label %b116
b118:
  %v589 = inttoptr i64 %v581 to ptr
  %v590 = getelementptr i8, ptr %v589, i64 %v582
  br label %b116
b119:
  %v602 = sub i64 %v146, %v145
  %v603 = add i64 0, 0
  %v604.c = icmp sgt i64 %v602, %v603
  %v604 = zext i1 %v604.c to i64
  %c.b119 = icmp ne i64 %v604, 0
  br i1 %c.b119, label %b119.t279, label %b119.e280
b119.t279:
  br label %b120
b119.e280:
  br label %b121
b120:
  %v605 = sub i64 %v146, %v145
  br label %b122
b121:
  %v606 = add i64 0, 0
  br label %b122
b122:
  %v607 = phi i64 [ %v605, %b120 ], [ %v606, %b121 ]
  %v608 = add i64 0, 0
  %v609.c = icmp sgt i64 %v607, %v608
  %v609 = zext i1 %v609.c to i64
  %c.b122 = icmp ne i64 %v609, 0
  br i1 %c.b122, label %b122.t281, label %b122.e282
b122.t281:
  br label %b123
b122.e282:
  br label %b124
b123:
  %v610 = getelementptr i64, ptr %s1, i64 0
  %v611.p = getelementptr i64, ptr %v60, i64 0
  %v611 = load i64, ptr %v611.p
  %st282 = getelementptr i64, ptr %v610, i64 0
  store i64 %v611, ptr %st282
  %v612.p = getelementptr i64, ptr %v60, i64 1
  %v612 = load i64, ptr %v612.p
  %st283 = getelementptr i64, ptr %v610, i64 1
  store i64 %v612, ptr %st283
  %v613.p = getelementptr i64, ptr %v60, i64 2
  %v613 = load i64, ptr %v613.p
  %st284 = getelementptr i64, ptr %v610, i64 2
  store i64 %v613, ptr %st284
  %v614 = add i64 0, 46
  %v615.p = getelementptr i64, ptr %v610, i64 2
  %v615 = load i64, ptr %v615.p
  %v616.p = getelementptr i64, ptr %v610, i64 0
  %v616 = load i64, ptr %v616.p
  %v617.p = getelementptr i64, ptr %v610, i64 1
  %v617 = load i64, ptr %v617.p
  %v620 = add i64 %v616, %v617
  %v621 = call i64 @"rt.tip8"(i64 %v615, i64 %v620)
  %v622 = add i64 0, 0
  %v623.c = icmp ne i64 %v621, %v622
  %v623 = zext i1 %v623.c to i64
  %c.b123 = icmp ne i64 %v623, 0
  br i1 %c.b123, label %b123.t286, label %b123.e287
b123.t286:
  br label %b127
b123.e287:
  br label %b126
b124:
  br label %b146
b125:
  %v618 = phi ptr [ %v627, %b126 ], [ %v624, %b127 ]
  %v619 = phi ptr [ %v628, %b126 ], [ %v625, %b127 ]
  %st287 = getelementptr i8, ptr %v619, i64 0
  %st287.b = trunc i64 %v614 to i8
  store i8 %st287.b, ptr %st287
  %v629.p = getelementptr i64, ptr %v610, i64 1
  %v629 = load i64, ptr %v629.p
  %v630 = add i64 0, 1
  %v631 = add i64 %v629, %v630
  %v632 = getelementptr i64, ptr %s3, i64 0
  %v633 = ptrtoint ptr %v618 to i64
  %st288 = getelementptr i64, ptr %v632, i64 0
  store i64 %v633, ptr %st288
  %st289 = getelementptr i64, ptr %v632, i64 1
  store i64 %v631, ptr %st289
  %st290 = getelementptr i64, ptr %v632, i64 2
  store i64 %v615, ptr %st290
  %v634.p = getelementptr i64, ptr %v632, i64 0
  %v634 = load i64, ptr %v634.p
  %st291 = getelementptr i64, ptr %v60, i64 0
  store i64 %v634, ptr %st291
  %v635.p = getelementptr i64, ptr %v632, i64 1
  %v635 = load i64, ptr %v635.p
  %st292 = getelementptr i64, ptr %v60, i64 1
  store i64 %v635, ptr %st292
  %v636.p = getelementptr i64, ptr %v632, i64 2
  %v636 = load i64, ptr %v636.p
  %st293 = getelementptr i64, ptr %v60, i64 2
  store i64 %v636, ptr %st293
  %v726 = getelementptr i64, ptr @"rt.meta", i64 0
  %v637.p = getelementptr i64, ptr %v726, i64 0
  %v637 = load i64, ptr %v637.p
  %v638 = add i64 0, 0
  %v639 = getelementptr i64, ptr %s4, i64 0
  %v727 = getelementptr i64, ptr @"rt.meta", i64 0
  %v640.p = getelementptr i64, ptr %v727, i64 0
  %v640 = load i64, ptr %v640.p
  %v641 = getelementptr i64, ptr %s5, i64 0
  %st294 = getelementptr i64, ptr %v641, i64 0
  store i64 %v638, ptr %st294
  %v728 = getelementptr i64, ptr @"rt.meta", i64 0
  %v642.p = getelementptr i64, ptr %v728, i64 0
  %v642 = load i64, ptr %v642.p
  br label %b130
b126:
  %v626 = add i64 0, 1
  %v627 = call ptr @"rt.slice_grow8"(i64 %v616, i64 %v617, i64 %v615, i64 %v626)
  %v628 = getelementptr i8, ptr %v627, i64 %v617
  br label %b125
b127:
  %v624 = inttoptr i64 %v616 to ptr
  %v625 = getelementptr i8, ptr %v624, i64 %v617
  br label %b125
b128:
  %v729 = getelementptr i64, ptr @"rt.meta", i64 0
  %st295 = getelementptr i64, ptr %v729, i64 0
  store i64 %v637, ptr %st295
  br label %b146
b129:
  br label %b128
b130:
  %v730 = getelementptr i64, ptr @"rt.meta", i64 0
  %st296 = getelementptr i64, ptr %v730, i64 0
  store i64 %v642, ptr %st296
  %v643.p = getelementptr i64, ptr %v641, i64 0
  %v643 = load i64, ptr %v643.p
  %v644.c = icmp slt i64 %v643, %v607
  %v644 = zext i1 %v644.c to i64
  %c.b130 = icmp ne i64 %v644, 0
  br i1 %c.b130, label %b130.t298, label %b130.e299
b130.t298:
  br label %b131
b130.e299:
  br label %b132
b131:
  call void @"rt.region_enter"()
  %v731 = getelementptr i64, ptr @"rt.meta", i64 0
  %v645.p = getelementptr i64, ptr %v731, i64 0
  %v645 = load i64, ptr %v645.p
  %v646.p = getelementptr i64, ptr %v641, i64 0
  %v646 = load i64, ptr %v646.p
  %v732 = getelementptr i64, ptr @"rt.meta", i64 0
  %v647.p = getelementptr i64, ptr %v732, i64 0
  %v647 = load i64, ptr %v647.p
  %v648 = add i64 %v145, %v646
  %v649 = add i64 0, 1
  %v650 = add i64 %v2, %v649
  %v651 = getelementptr i64, ptr %s3, i64 0
  %v652.p = getelementptr i64, ptr %v60, i64 0
  %v652 = load i64, ptr %v652.p
  %st299 = getelementptr i64, ptr %v651, i64 0
  store i64 %v652, ptr %st299
  %v653.p = getelementptr i64, ptr %v60, i64 1
  %v653 = load i64, ptr %v653.p
  %st300 = getelementptr i64, ptr %v651, i64 1
  store i64 %v653, ptr %st300
  %v654.p = getelementptr i64, ptr %v60, i64 2
  %v654 = load i64, ptr %v654.p
  %st301 = getelementptr i64, ptr %v651, i64 2
  store i64 %v654, ptr %st301
  %v655 = add i64 0, 48
  %v656 = add i64 0, 0
  %v657.c = icmp sge i64 %v648, %v656
  %v657 = zext i1 %v657.c to i64
  %c.b131 = icmp ne i64 %v657, 0
  br i1 %c.b131, label %b131.t303, label %b131.e304
b131.t303:
  br label %b134
b131.e304:
  br label %b135
b132:
  %v733 = getelementptr i64, ptr @"rt.meta", i64 0
  %st304 = getelementptr i64, ptr %v733, i64 0
  store i64 %v642, ptr %st304
  br label %b129
b133:
  %v734 = getelementptr i64, ptr @"rt.meta", i64 0
  %st305 = getelementptr i64, ptr %v734, i64 0
  store i64 %v647, ptr %st305
  %v697 = add i64 0, 1
  %v698.p = getelementptr i64, ptr %v641, i64 0
  %v698 = load i64, ptr %v698.p
  %v699 = add i64 %v698, %v697
  %st306 = getelementptr i64, ptr %v641, i64 0
  store i64 %v699, ptr %st306
  br label %b130
b134:
  %v659.c = icmp slt i64 %v648, %v146
  %v659 = zext i1 %v659.c to i64
  br label %b135
b135:
  %v658 = phi i64 [ %v657, %b131.e304 ], [ %v659, %b134 ]
  %c.b135 = icmp ne i64 %v658, 0
  br i1 %c.b135, label %b135.t308, label %b135.e309
b135.t308:
  br label %b136
b135.e309:
  br label %b137
b136:
  %v660.p = getelementptr i64, ptr %v131, i64 1
  %v660 = load i64, ptr %v660.p
  %v661.c = icmp uge i64 %v648, %v660
  %v661 = zext i1 %v661.c to i64
  %c.b136 = icmp ne i64 %v661, 0
  br i1 %c.b136, label %b136.t310, label %b136.e311
b136.t310:
  br label %b138
b136.e311:
  br label %b139
b137:
  %v669 = add i64 0, 0
  br label %b140
b138:
  %v662 = add i64 0, 14
  call void @"rt.panic"(i64 %v662)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b139:
  %v663.p = getelementptr i64, ptr %v131, i64 0
  %v663 = load i64, ptr %v663.p
  %v664 = inttoptr i64 %v663 to ptr
  %v665 = add i64 0, 1
  %v666 = mul i64 %v648, %v665
  %v667 = getelementptr i64, ptr %v664, i64 %v666
  %v668.p = getelementptr i64, ptr %v667, i64 0
  %v668 = load i64, ptr %v668.p
  br label %b140
b140:
  %v670 = phi i64 [ %v669, %b137 ], [ %v668, %b139 ]
  %v671 = add i64 %v655, %v670
  %v672 = add i64 0, 256
  %v673.c = icmp uge i64 %v671, %v672
  %v673 = zext i1 %v673.c to i64
  %c.b140 = icmp ne i64 %v673, 0
  br i1 %c.b140, label %b140.t312, label %b140.e313
b140.t312:
  br label %b141
b140.e313:
  br label %b142
b141:
  %v674 = add i64 0, 15
  call void @"rt.panic"(i64 %v674)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b142:
  %v675.p = getelementptr i64, ptr %v651, i64 2
  %v675 = load i64, ptr %v675.p
  %v676.p = getelementptr i64, ptr %v651, i64 0
  %v676 = load i64, ptr %v676.p
  %v677.p = getelementptr i64, ptr %v651, i64 1
  %v677 = load i64, ptr %v677.p
  %v680 = add i64 %v676, %v677
  %v681 = call i64 @"rt.tip8"(i64 %v675, i64 %v680)
  %v682 = add i64 0, 0
  %v683.c = icmp ne i64 %v681, %v682
  %v683 = zext i1 %v683.c to i64
  %c.b142 = icmp ne i64 %v683, 0
  br i1 %c.b142, label %b142.t314, label %b142.e315
b142.t314:
  br label %b145
b142.e315:
  br label %b144
b143:
  %v678 = phi ptr [ %v687, %b144 ], [ %v684, %b145 ]
  %v679 = phi ptr [ %v688, %b144 ], [ %v685, %b145 ]
  %st315 = getelementptr i8, ptr %v679, i64 0
  %st315.b = trunc i64 %v671 to i8
  store i8 %st315.b, ptr %st315
  %v689.p = getelementptr i64, ptr %v651, i64 1
  %v689 = load i64, ptr %v689.p
  %v690 = add i64 0, 1
  %v691 = add i64 %v689, %v690
  %v692 = getelementptr i64, ptr %s1, i64 0
  %v693 = ptrtoint ptr %v678 to i64
  %st316 = getelementptr i64, ptr %v692, i64 0
  store i64 %v693, ptr %st316
  %st317 = getelementptr i64, ptr %v692, i64 1
  store i64 %v691, ptr %st317
  %st318 = getelementptr i64, ptr %v692, i64 2
  store i64 %v675, ptr %st318
  %v694.p = getelementptr i64, ptr %v692, i64 0
  %v694 = load i64, ptr %v694.p
  %st319 = getelementptr i64, ptr %v60, i64 0
  store i64 %v694, ptr %st319
  %v695.p = getelementptr i64, ptr %v692, i64 1
  %v695 = load i64, ptr %v695.p
  %st320 = getelementptr i64, ptr %v60, i64 1
  store i64 %v695, ptr %st320
  %v696.p = getelementptr i64, ptr %v692, i64 2
  %v696 = load i64, ptr %v696.p
  %st321 = getelementptr i64, ptr %v60, i64 2
  store i64 %v696, ptr %st321
  br label %b133
b144:
  %v686 = add i64 0, 1
  %v687 = call ptr @"rt.slice_grow8"(i64 %v676, i64 %v677, i64 %v675, i64 %v686)
  %v688 = getelementptr i8, ptr %v687, i64 %v677
  br label %b143
b145:
  %v684 = inttoptr i64 %v676 to ptr
  %v685 = getelementptr i8, ptr %v684, i64 %v677
  br label %b143
b146:
  %v700.p = getelementptr i64, ptr %v60, i64 0
  %v700 = load i64, ptr %v700.p
  %st322 = getelementptr i64, ptr %v0, i64 0
  store i64 %v700, ptr %st322
  %v701.p = getelementptr i64, ptr %v60, i64 1
  %v701 = load i64, ptr %v701.p
  %st323 = getelementptr i64, ptr %v0, i64 1
  store i64 %v701, ptr %st323
  %v702.p = getelementptr i64, ptr %v60, i64 2
  %v702 = load i64, ptr %v702.p
  %st324 = getelementptr i64, ptr %v0, i64 2
  store i64 %v702, ptr %st324
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v735 = getelementptr i64, ptr @"rt.meta", i64 0
  %st325 = getelementptr i64, ptr %v735, i64 0
  store i64 %v2, ptr %st325
  ret void
}

define internal i64 @"std/internal/floatfmt.exactShort"(ptr %v0, i64 %v1, i64 %v2) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
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
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %v225 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v225, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2572
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %v7.c = icmp eq i64 %v5, %v6
  %v7 = zext i1 %v7.c to i64
  %v8 = mul i64 %v7, %v3
  %v9 = add i64 %v5, %v8
  %v10 = add i64 0, 0
  %v11.c = icmp eq i64 %v1, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b0 = icmp ne i64 %v11, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v12 = add i64 0, -100000
  %v226 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v226, i64 0
  store i64 %v3, ptr %st2
  ret i64 %v12
b2:
  br label %b3
b3:
  %v13 = add i64 0, 4503599627370496
  %v14 = or i64 %v2, %v13
  %v15 = getelementptr i64, ptr %s0, i64 0
  %st3 = getelementptr i64, ptr %v15, i64 0
  store i64 %v14, ptr %st3
  %v16 = add i64 0, 1075
  %v17 = sub i64 %v1, %v16
  %v18 = getelementptr i64, ptr %s1, i64 0
  %st4 = getelementptr i64, ptr %v18, i64 0
  store i64 %v17, ptr %st4
  %v227 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v227, i64 0
  %v19 = load i64, ptr %v19.p
  br label %b4
b4:
  %v228 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v228, i64 0
  store i64 %v19, ptr %st5
  %v20.p = getelementptr i64, ptr %v15, i64 0
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 1
  %v22 = and i64 %v20, %v21
  %v23 = add i64 0, 0
  %v24.c = icmp eq i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b4 = icmp ne i64 %v24, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b7
b4.e8:
  br label %b8
b5:
  call void @"rt.region_enter"()
  %v229 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v229, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v15, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 1
  %v33 = add i64 0, 0
  %v34.c = icmp slt i64 %v31, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b5 = icmp ne i64 %v34, 0
  br i1 %c.b5, label %b5.t9, label %b5.e10
b5.t9:
  br label %b9
b5.e10:
  br label %b10
b6:
  %v230 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v230, i64 0
  store i64 %v19, ptr %st10
  %v44 = add i64 0, 1000000000000000
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s2, i64 0
  %st11 = getelementptr i64, ptr %v46, i64 0
  store i64 %v45, ptr %st11
  %v47 = add i64 0, 0
  %v48 = getelementptr i64, ptr %s3, i64 0
  %st12 = getelementptr i64, ptr %v48, i64 0
  store i64 %v47, ptr %st12
  %v49.p = getelementptr i64, ptr %v18, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.c = icmp sge i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b6 = icmp ne i64 %v51, 0
  br i1 %c.b6, label %b6.t14, label %b6.e15
b6.t14:
  br label %b14
b6.e15:
  br label %b15
b7:
  %v26.p = getelementptr i64, ptr %v18, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp slt i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  br label %b8
b8:
  %v25 = phi i64 [ %v24, %b4.e8 ], [ %v28, %b7 ]
  %c.b8 = icmp ne i64 %v25, 0
  br i1 %c.b8, label %b8.t16, label %b8.e17
b8.t16:
  br label %b5
b8.e17:
  br label %b6
b9:
  %v35 = add i64 0, 16
  call void @"rt.panic"(i64 %v35)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v36 = add i64 0, 63
  %v37.c = icmp sgt i64 %v31, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b10 = icmp ne i64 %v37, 0
  br i1 %c.b10, label %b10.t18, label %b10.e19
b10.t18:
  br label %b12
b10.e19:
  br label %b13
b11:
  %v32 = phi i64 [ %v39, %b12 ], [ %v40, %b13 ]
  %st19 = getelementptr i64, ptr %v15, i64 0
  store i64 %v32, ptr %st19
  %v41 = add i64 0, 1
  %v42.p = getelementptr i64, ptr %v18, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 %v42, %v41
  %st20 = getelementptr i64, ptr %v18, i64 0
  store i64 %v43, ptr %st20
  br label %b4
b12:
  %v38 = add i64 0, 63
  %v39.n = and i64 %v38, 63
  %v39 = ashr i64 %v30, %v39.n
  br label %b11
b13:
  %v40.n = and i64 %v31, 63
  %v40 = ashr i64 %v30, %v40.n
  br label %b11
b14:
  %v52.p = getelementptr i64, ptr %v18, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 10
  %v54.c = icmp sgt i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b14 = icmp ne i64 %v54, 0
  br i1 %c.b14, label %b14.t22, label %b14.e23
b14.t22:
  br label %b16
b14.e23:
  br label %b17
b15:
  %v69 = add i64 0, 0
  %v70.p = getelementptr i64, ptr %v18, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = sub i64 %v69, %v70
  %st23 = getelementptr i64, ptr %v48, i64 0
  store i64 %v71, ptr %st23
  %v72.p = getelementptr i64, ptr %v15, i64 0
  %v72 = load i64, ptr %v72.p
  %st24 = getelementptr i64, ptr %v46, i64 0
  store i64 %v72, ptr %st24
  %v73 = add i64 0, 0
  %v74 = getelementptr i64, ptr %s4, i64 0
  %st25 = getelementptr i64, ptr %v74, i64 0
  store i64 %v73, ptr %st25
  %v231 = getelementptr i64, ptr @"rt.meta", i64 0
  %v75.p = getelementptr i64, ptr %v231, i64 0
  %v75 = load i64, ptr %v75.p
  br label %b27
b16:
  %v55 = add i64 0, -100000
  %v232 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v232, i64 0
  store i64 %v3, ptr %st26
  ret i64 %v55
b17:
  br label %b18
b18:
  %v56.p = getelementptr i64, ptr %v15, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v18, i64 0
  %v57 = load i64, ptr %v57.p
  %v59 = add i64 0, 0
  %v60.c = icmp slt i64 %v57, %v59
  %v60 = zext i1 %v60.c to i64
  %c.b18 = icmp ne i64 %v60, 0
  br i1 %c.b18, label %b18.t28, label %b18.e29
b18.t28:
  br label %b19
b18.e29:
  br label %b20
b19:
  %v61 = add i64 0, 17
  call void @"rt.panic"(i64 %v61)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v62 = add i64 0, 63
  %v63.c = icmp sgt i64 %v57, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b20 = icmp ne i64 %v63, 0
  br i1 %c.b20, label %b20.t30, label %b20.e31
b20.t30:
  br label %b22
b20.e31:
  br label %b23
b21:
  %v58 = phi i64 [ %v64, %b22 ], [ %v65, %b23 ]
  %st31 = getelementptr i64, ptr %v46, i64 0
  store i64 %v58, ptr %st31
  %v66.p = getelementptr i64, ptr %v46, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp sgt i64 %v66, %v44
  %v67 = zext i1 %v67.c to i64
  %c.b21 = icmp ne i64 %v67, 0
  br i1 %c.b21, label %b21.t33, label %b21.e34
b21.t33:
  br label %b24
b21.e34:
  br label %b25
b22:
  %v64 = add i64 0, 0
  br label %b21
b23:
  %v65.n = and i64 %v57, 63
  %v65 = shl i64 %v56, %v65.n
  br label %b21
b24:
  %v68 = add i64 0, -100000
  %v233 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v233, i64 0
  store i64 %v3, ptr %st34
  ret i64 %v68
b25:
  br label %b26
b26:
  br label %b33
b27:
  %v234 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v234, i64 0
  store i64 %v75, ptr %st35
  %v76.p = getelementptr i64, ptr %v74, i64 0
  %v76 = load i64, ptr %v76.p
  %v77.p = getelementptr i64, ptr %v48, i64 0
  %v77 = load i64, ptr %v77.p
  %v78.c = icmp slt i64 %v76, %v77
  %v78 = zext i1 %v78.c to i64
  %c.b27 = icmp ne i64 %v78, 0
  br i1 %c.b27, label %b27.t37, label %b27.e38
b27.t37:
  br label %b28
b27.e38:
  br label %b29
b28:
  call void @"rt.region_enter"()
  %v235 = getelementptr i64, ptr @"rt.meta", i64 0
  %v79.p = getelementptr i64, ptr %v235, i64 0
  %v79 = load i64, ptr %v79.p
  %v80.p = getelementptr i64, ptr %v46, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = add i64 0, 5
  %v82 = sdiv i64 %v44, %v81
  %v83.c = icmp sgt i64 %v80, %v82
  %v83 = zext i1 %v83.c to i64
  %c.b28 = icmp ne i64 %v83, 0
  br i1 %c.b28, label %b28.t39, label %b28.e40
b28.t39:
  br label %b30
b28.e40:
  br label %b31
b29:
  %v236 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v236, i64 0
  store i64 %v75, ptr %st40
  br label %b33
b30:
  %v84 = add i64 0, -100000
  %v237 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v237, i64 0
  store i64 %v3, ptr %st41
  ret i64 %v84
b31:
  br label %b32
b32:
  %v85.p = getelementptr i64, ptr %v46, i64 0
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 0, 5
  %v87 = mul i64 %v85, %v86
  %st42 = getelementptr i64, ptr %v46, i64 0
  store i64 %v87, ptr %st42
  %v88 = add i64 0, 1
  %v89.p = getelementptr i64, ptr %v74, i64 0
  %v89 = load i64, ptr %v89.p
  %v90 = add i64 %v89, %v88
  %st43 = getelementptr i64, ptr %v74, i64 0
  store i64 %v90, ptr %st43
  br label %b27
b33:
  %v91 = add i64 0, 0
  %v92 = call ptr @"rt.region_alloc"(i64 %v3, i64 %v91)
  %v93 = add i64 0, 0
  %v94 = getelementptr i64, ptr %s5, i64 0
  %v95 = ptrtoint ptr %v92 to i64
  %st44 = getelementptr i64, ptr %v94, i64 0
  store i64 %v95, ptr %st44
  %st45 = getelementptr i64, ptr %v94, i64 1
  store i64 %v93, ptr %st45
  %st46 = getelementptr i64, ptr %v94, i64 2
  store i64 %v3, ptr %st46
  %v96 = getelementptr i64, ptr %s6, i64 0
  %v97.p = getelementptr i64, ptr %v94, i64 0
  %v97 = load i64, ptr %v97.p
  %st47 = getelementptr i64, ptr %v96, i64 0
  store i64 %v97, ptr %st47
  %v98.p = getelementptr i64, ptr %v94, i64 1
  %v98 = load i64, ptr %v98.p
  %st48 = getelementptr i64, ptr %v96, i64 1
  store i64 %v98, ptr %st48
  %v99.p = getelementptr i64, ptr %v94, i64 2
  %v99 = load i64, ptr %v99.p
  %st49 = getelementptr i64, ptr %v96, i64 2
  store i64 %v99, ptr %st49
  %v100.p = getelementptr i64, ptr %v46, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = getelementptr i64, ptr %s4, i64 0
  %st50 = getelementptr i64, ptr %v101, i64 0
  store i64 %v100, ptr %st50
  %v238 = getelementptr i64, ptr @"rt.meta", i64 0
  %v102.p = getelementptr i64, ptr %v238, i64 0
  %v102 = load i64, ptr %v102.p
  br label %b34
b34:
  %v239 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v239, i64 0
  store i64 %v102, ptr %st51
  %v103.p = getelementptr i64, ptr %v101, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105.c = icmp sgt i64 %v103, %v104
  %v105 = zext i1 %v105.c to i64
  %c.b34 = icmp ne i64 %v105, 0
  br i1 %c.b34, label %b34.t53, label %b34.e54
b34.t53:
  br label %b35
b34.e54:
  br label %b36
b35:
  call void @"rt.region_enter"()
  %v240 = getelementptr i64, ptr @"rt.meta", i64 0
  %v106.p = getelementptr i64, ptr %v240, i64 0
  %v106 = load i64, ptr %v106.p
  %v107 = getelementptr i64, ptr %s5, i64 0
  %v108.p = getelementptr i64, ptr %v96, i64 0
  %v108 = load i64, ptr %v108.p
  %st54 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st54
  %v109.p = getelementptr i64, ptr %v96, i64 1
  %v109 = load i64, ptr %v109.p
  %st55 = getelementptr i64, ptr %v107, i64 1
  store i64 %v109, ptr %st55
  %v110.p = getelementptr i64, ptr %v96, i64 2
  %v110 = load i64, ptr %v110.p
  %st56 = getelementptr i64, ptr %v107, i64 2
  store i64 %v110, ptr %st56
  %v111.p = getelementptr i64, ptr %v101, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 0, 10
  %v113 = srem i64 %v111, %v112
  %v114.p = getelementptr i64, ptr %v107, i64 2
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v107, i64 0
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v107, i64 1
  %v116 = load i64, ptr %v116.p
  %v119 = add i64 0, 8
  %v120 = mul i64 %v116, %v119
  %v121 = add i64 %v115, %v120
  %v241 = getelementptr i64, ptr @"rt.meta", i64 0
  %v242 = getelementptr i64, ptr %v241, i64 %v114
  %v122.p = getelementptr i64, ptr %v242, i64 1
  %v122 = load ptr, ptr %v122.p
  %v123 = ptrtoint ptr %v122 to i64
  %v124.c = icmp eq i64 %v123, %v121
  %v124 = zext i1 %v124.c to i64
  %c.b35 = icmp ne i64 %v124, 0
  br i1 %c.b35, label %b35.t58, label %b35.e59
b35.t58:
  br label %b39
b35.e59:
  br label %b38
b36:
  %v243 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v243, i64 0
  store i64 %v102, ptr %st59
  %v145.p = getelementptr i64, ptr %v96, i64 1
  %v145 = load i64, ptr %v145.p
  %v146 = add i64 0, 0
  %v147 = getelementptr i64, ptr %s8, i64 0
  %st60 = getelementptr i64, ptr %v147, i64 0
  store i64 %v146, ptr %st60
  %v244 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v244, i64 0
  %v148 = load i64, ptr %v148.p
  br label %b40
b37:
  %v117 = phi ptr [ %v132, %b38 ], [ %v127, %b39 ]
  %v118 = phi ptr [ %v133, %b38 ], [ %v126, %b39 ]
  %st61 = getelementptr i64, ptr %v118, i64 0
  store i64 %v113, ptr %st61
  %v134.p = getelementptr i64, ptr %v107, i64 1
  %v134 = load i64, ptr %v134.p
  %v135 = add i64 0, 1
  %v136 = add i64 %v134, %v135
  %v137 = getelementptr i64, ptr %s7, i64 0
  %v138 = ptrtoint ptr %v117 to i64
  %st62 = getelementptr i64, ptr %v137, i64 0
  store i64 %v138, ptr %st62
  %st63 = getelementptr i64, ptr %v137, i64 1
  store i64 %v136, ptr %st63
  %st64 = getelementptr i64, ptr %v137, i64 2
  store i64 %v114, ptr %st64
  %v139.p = getelementptr i64, ptr %v137, i64 0
  %v139 = load i64, ptr %v139.p
  %st65 = getelementptr i64, ptr %v96, i64 0
  store i64 %v139, ptr %st65
  %v140.p = getelementptr i64, ptr %v137, i64 1
  %v140 = load i64, ptr %v140.p
  %st66 = getelementptr i64, ptr %v96, i64 1
  store i64 %v140, ptr %st66
  %v141.p = getelementptr i64, ptr %v137, i64 2
  %v141 = load i64, ptr %v141.p
  %st67 = getelementptr i64, ptr %v96, i64 2
  store i64 %v141, ptr %st67
  %v142.p = getelementptr i64, ptr %v101, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = add i64 0, 10
  %v144 = sdiv i64 %v142, %v143
  %st68 = getelementptr i64, ptr %v101, i64 0
  store i64 %v144, ptr %st68
  br label %b34
b38:
  %v128 = add i64 0, 1
  %v129 = mul i64 %v116, %v128
  %v130 = add i64 0, 1
  %v131 = add i64 0, 1
  %v132 = call ptr @"rt.slice_grow"(i64 %v115, i64 %v116, i64 %v130, i64 %v114, i64 %v131)
  %v133 = getelementptr i64, ptr %v132, i64 %v129
  br label %b37
b39:
  %v125 = add i64 0, 1
  %v126 = call ptr @"rt.region_alloc"(i64 %v114, i64 %v125)
  %v127 = inttoptr i64 %v115 to ptr
  br label %b37
b40:
  %v245 = getelementptr i64, ptr @"rt.meta", i64 0
  %st69 = getelementptr i64, ptr %v245, i64 0
  store i64 %v148, ptr %st69
  %v149.p = getelementptr i64, ptr %v147, i64 0
  %v149 = load i64, ptr %v149.p
  %v150 = add i64 0, 1
  %v151 = sub i64 %v145, %v150
  %v152.c = icmp slt i64 %v149, %v151
  %v152 = zext i1 %v152.c to i64
  %c.b40 = icmp ne i64 %v152, 0
  br i1 %c.b40, label %b40.t71, label %b40.e72
b40.t71:
  br label %b43
b40.e72:
  br label %b44
b41:
  call void @"rt.region_enter"()
  %v246 = getelementptr i64, ptr @"rt.meta", i64 0
  %v166.p = getelementptr i64, ptr %v246, i64 0
  %v166 = load i64, ptr %v166.p
  %v167 = add i64 0, 1
  %v168.p = getelementptr i64, ptr %v147, i64 0
  %v168 = load i64, ptr %v168.p
  %v169 = add i64 %v168, %v167
  %st72 = getelementptr i64, ptr %v147, i64 0
  store i64 %v169, ptr %st72
  br label %b40
b42:
  %v247 = getelementptr i64, ptr @"rt.meta", i64 0
  %st73 = getelementptr i64, ptr %v247, i64 0
  store i64 %v148, ptr %st73
  %v170 = add i64 0, 1
  %v171 = sub i64 %v145, %v170
  %v172 = getelementptr i64, ptr %s9, i64 0
  %st74 = getelementptr i64, ptr %v172, i64 0
  store i64 %v171, ptr %st74
  %v248 = getelementptr i64, ptr @"rt.meta", i64 0
  %v173.p = getelementptr i64, ptr %v248, i64 0
  %v173 = load i64, ptr %v173.p
  br label %b47
b43:
  %v154.p = getelementptr i64, ptr %v147, i64 0
  %v154 = load i64, ptr %v154.p
  %v155.p = getelementptr i64, ptr %v96, i64 1
  %v155 = load i64, ptr %v155.p
  %v156.c = icmp uge i64 %v154, %v155
  %v156 = zext i1 %v156.c to i64
  %c.b43 = icmp ne i64 %v156, 0
  br i1 %c.b43, label %b43.t76, label %b43.e77
b43.t76:
  br label %b45
b43.e77:
  br label %b46
b44:
  %v153 = phi i64 [ %v152, %b40.e72 ], [ %v165, %b46 ]
  %c.b44 = icmp ne i64 %v153, 0
  br i1 %c.b44, label %b44.t78, label %b44.e79
b44.t78:
  br label %b41
b44.e79:
  br label %b42
b45:
  %v157 = add i64 0, 18
  call void @"rt.panic"(i64 %v157)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b46:
  %v158.p = getelementptr i64, ptr %v96, i64 0
  %v158 = load i64, ptr %v158.p
  %v159 = inttoptr i64 %v158 to ptr
  %v160 = add i64 0, 1
  %v161 = mul i64 %v154, %v160
  %v162 = getelementptr i64, ptr %v159, i64 %v161
  %v163.p = getelementptr i64, ptr %v162, i64 0
  %v163 = load i64, ptr %v163.p
  %v164 = add i64 0, 0
  %v165.c = icmp eq i64 %v163, %v164
  %v165 = zext i1 %v165.c to i64
  br label %b44
b47:
  %v249 = getelementptr i64, ptr @"rt.meta", i64 0
  %st79 = getelementptr i64, ptr %v249, i64 0
  store i64 %v173, ptr %st79
  %v174.p = getelementptr i64, ptr %v172, i64 0
  %v174 = load i64, ptr %v174.p
  %v175.p = getelementptr i64, ptr %v147, i64 0
  %v175 = load i64, ptr %v175.p
  %v176.c = icmp sge i64 %v174, %v175
  %v176 = zext i1 %v176.c to i64
  %c.b47 = icmp ne i64 %v176, 0
  br i1 %c.b47, label %b47.t81, label %b47.e82
b47.t81:
  br label %b48
b47.e82:
  br label %b49
b48:
  call void @"rt.region_enter"()
  %v250 = getelementptr i64, ptr @"rt.meta", i64 0
  %v177.p = getelementptr i64, ptr %v250, i64 0
  %v177 = load i64, ptr %v177.p
  %v178 = getelementptr i64, ptr %s7, i64 0
  %v179.p = getelementptr i64, ptr %v0, i64 0
  %v179 = load i64, ptr %v179.p
  %st82 = getelementptr i64, ptr %v178, i64 0
  store i64 %v179, ptr %st82
  %v180.p = getelementptr i64, ptr %v0, i64 1
  %v180 = load i64, ptr %v180.p
  %st83 = getelementptr i64, ptr %v178, i64 1
  store i64 %v180, ptr %st83
  %v181.p = getelementptr i64, ptr %v0, i64 2
  %v181 = load i64, ptr %v181.p
  %st84 = getelementptr i64, ptr %v178, i64 2
  store i64 %v181, ptr %st84
  %v182.p = getelementptr i64, ptr %v172, i64 0
  %v182 = load i64, ptr %v182.p
  %v183.p = getelementptr i64, ptr %v96, i64 1
  %v183 = load i64, ptr %v183.p
  %v184.c = icmp uge i64 %v182, %v183
  %v184 = zext i1 %v184.c to i64
  %c.b48 = icmp ne i64 %v184, 0
  br i1 %c.b48, label %b48.t86, label %b48.e87
b48.t86:
  br label %b50
b48.e87:
  br label %b51
b49:
  %v251 = getelementptr i64, ptr @"rt.meta", i64 0
  %st87 = getelementptr i64, ptr %v251, i64 0
  store i64 %v173, ptr %st87
  %v223.p = getelementptr i64, ptr %v48, i64 0
  %v223 = load i64, ptr %v223.p
  %v224 = sub i64 %v145, %v223
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %st88 = getelementptr i64, ptr %v252, i64 0
  store i64 %v3, ptr %st88
  ret i64 %v224
b50:
  %v185 = add i64 0, 19
  call void @"rt.panic"(i64 %v185)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v186.p = getelementptr i64, ptr %v96, i64 0
  %v186 = load i64, ptr %v186.p
  %v187 = inttoptr i64 %v186 to ptr
  %v188 = add i64 0, 1
  %v189 = mul i64 %v182, %v188
  %v190 = getelementptr i64, ptr %v187, i64 %v189
  %v191.p = getelementptr i64, ptr %v190, i64 0
  %v191 = load i64, ptr %v191.p
  %v192.p = getelementptr i64, ptr %v178, i64 2
  %v192 = load i64, ptr %v192.p
  %v193.p = getelementptr i64, ptr %v178, i64 0
  %v193 = load i64, ptr %v193.p
  %v194.p = getelementptr i64, ptr %v178, i64 1
  %v194 = load i64, ptr %v194.p
  %v197 = add i64 0, 8
  %v198 = mul i64 %v194, %v197
  %v199 = add i64 %v193, %v198
  %v253 = getelementptr i64, ptr @"rt.meta", i64 0
  %v254 = getelementptr i64, ptr %v253, i64 %v192
  %v200.p = getelementptr i64, ptr %v254, i64 1
  %v200 = load ptr, ptr %v200.p
  %v201 = ptrtoint ptr %v200 to i64
  %v202.c = icmp eq i64 %v201, %v199
  %v202 = zext i1 %v202.c to i64
  %c.b51 = icmp ne i64 %v202, 0
  br i1 %c.b51, label %b51.t90, label %b51.e91
b51.t90:
  br label %b54
b51.e91:
  br label %b53
b52:
  %v195 = phi ptr [ %v210, %b53 ], [ %v205, %b54 ]
  %v196 = phi ptr [ %v211, %b53 ], [ %v204, %b54 ]
  %st91 = getelementptr i64, ptr %v196, i64 0
  store i64 %v191, ptr %st91
  %v212.p = getelementptr i64, ptr %v178, i64 1
  %v212 = load i64, ptr %v212.p
  %v213 = add i64 0, 1
  %v214 = add i64 %v212, %v213
  %v215 = getelementptr i64, ptr %s5, i64 0
  %v216 = ptrtoint ptr %v195 to i64
  %st92 = getelementptr i64, ptr %v215, i64 0
  store i64 %v216, ptr %st92
  %st93 = getelementptr i64, ptr %v215, i64 1
  store i64 %v214, ptr %st93
  %st94 = getelementptr i64, ptr %v215, i64 2
  store i64 %v192, ptr %st94
  %v217.p = getelementptr i64, ptr %v215, i64 0
  %v217 = load i64, ptr %v217.p
  %st95 = getelementptr i64, ptr %v0, i64 0
  store i64 %v217, ptr %st95
  %v218.p = getelementptr i64, ptr %v215, i64 1
  %v218 = load i64, ptr %v218.p
  %st96 = getelementptr i64, ptr %v0, i64 1
  store i64 %v218, ptr %st96
  %v219.p = getelementptr i64, ptr %v215, i64 2
  %v219 = load i64, ptr %v219.p
  %st97 = getelementptr i64, ptr %v0, i64 2
  store i64 %v219, ptr %st97
  %v220 = add i64 0, 1
  %v221.p = getelementptr i64, ptr %v172, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = sub i64 %v221, %v220
  %st98 = getelementptr i64, ptr %v172, i64 0
  store i64 %v222, ptr %st98
  br label %b47
b53:
  %v206 = add i64 0, 1
  %v207 = mul i64 %v194, %v206
  %v208 = add i64 0, 1
  %v209 = add i64 0, 1
  %v210 = call ptr @"rt.slice_grow"(i64 %v193, i64 %v194, i64 %v208, i64 %v192, i64 %v209)
  %v211 = getelementptr i64, ptr %v210, i64 %v207
  br label %b52
b54:
  %v203 = add i64 0, 1
  %v204 = call ptr @"rt.region_alloc"(i64 %v192, i64 %v203)
  %v205 = inttoptr i64 %v193 to ptr
  br label %b52
}

define internal i64 @"std/internal/floatfmt.shortest"(ptr %v0, i64 %v1, i64 %v2) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
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
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s10 = alloca [3 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s12 = alloca [3 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %v532 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v532, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2572
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %v7.c = icmp eq i64 %v5, %v6
  %v7 = zext i1 %v7.c to i64
  %v8 = mul i64 %v7, %v3
  %v9 = add i64 %v5, %v8
  %v10 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v10, i64 0
  store i64 %v2, ptr %st0
  %v11 = add i64 0, 1074
  %v12 = add i64 0, 0
  %v13 = sub i64 %v12, %v11
  %v14 = getelementptr i64, ptr %s1, i64 0
  %st1 = getelementptr i64, ptr %v14, i64 0
  store i64 %v13, ptr %st1
  %v15 = add i64 0, 0
  %v16.c = icmp sgt i64 %v1, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t3, label %b0.e4
b0.t3:
  br label %b1
b0.e4:
  br label %b2
b1:
  %v17 = add i64 0, 4503599627370496
  %v18 = add i64 %v2, %v17
  %st4 = getelementptr i64, ptr %v10, i64 0
  store i64 %v18, ptr %st4
  %v19 = add i64 0, 1075
  %v20 = sub i64 %v1, %v19
  %st5 = getelementptr i64, ptr %v14, i64 0
  store i64 %v20, ptr %st5
  br label %b3
b2:
  br label %b3
b3:
  %v21.p = getelementptr i64, ptr %v10, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 0, 2
  %v23 = srem i64 %v21, %v22
  %v24 = add i64 0, 0
  %v25.c = icmp eq i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %v533 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v533, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28 = call ptr @"rt.region_alloc"(i64 %v26, i64 %v27)
  %v29 = add i64 0, 0
  %v30 = getelementptr i64, ptr %s2, i64 0
  %v31 = ptrtoint ptr %v28 to i64
  %st6 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st6
  %st7 = getelementptr i64, ptr %v30, i64 1
  store i64 %v29, ptr %st7
  %st8 = getelementptr i64, ptr %v30, i64 2
  store i64 %v26, ptr %st8
  %v32 = getelementptr i64, ptr %s3, i64 0
  %v33.p = getelementptr i64, ptr %v30, i64 0
  %v33 = load i64, ptr %v33.p
  %st9 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st9
  %v34.p = getelementptr i64, ptr %v30, i64 1
  %v34 = load i64, ptr %v34.p
  %st10 = getelementptr i64, ptr %v32, i64 1
  store i64 %v34, ptr %st10
  %v35.p = getelementptr i64, ptr %v30, i64 2
  %v35 = load i64, ptr %v35.p
  %st11 = getelementptr i64, ptr %v32, i64 2
  store i64 %v35, ptr %st11
  %v534 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v534, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 0, 0
  %v38 = call ptr @"rt.region_alloc"(i64 %v36, i64 %v37)
  %v39 = add i64 0, 0
  %v40 = getelementptr i64, ptr %s2, i64 0
  %v41 = ptrtoint ptr %v38 to i64
  %st12 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st12
  %st13 = getelementptr i64, ptr %v40, i64 1
  store i64 %v39, ptr %st13
  %st14 = getelementptr i64, ptr %v40, i64 2
  store i64 %v36, ptr %st14
  %v42 = getelementptr i64, ptr %s4, i64 0
  %v43.p = getelementptr i64, ptr %v40, i64 0
  %v43 = load i64, ptr %v43.p
  %st15 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st15
  %v44.p = getelementptr i64, ptr %v40, i64 1
  %v44 = load i64, ptr %v44.p
  %st16 = getelementptr i64, ptr %v42, i64 1
  store i64 %v44, ptr %st16
  %v45.p = getelementptr i64, ptr %v40, i64 2
  %v45 = load i64, ptr %v45.p
  %st17 = getelementptr i64, ptr %v42, i64 2
  store i64 %v45, ptr %st17
  %v535 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v535, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 0, 0
  %v48 = call ptr @"rt.region_alloc"(i64 %v46, i64 %v47)
  %v49 = add i64 0, 0
  %v50 = getelementptr i64, ptr %s2, i64 0
  %v51 = ptrtoint ptr %v48 to i64
  %st18 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st18
  %st19 = getelementptr i64, ptr %v50, i64 1
  store i64 %v49, ptr %st19
  %st20 = getelementptr i64, ptr %v50, i64 2
  store i64 %v46, ptr %st20
  %v52 = getelementptr i64, ptr %s5, i64 0
  %v53.p = getelementptr i64, ptr %v50, i64 0
  %v53 = load i64, ptr %v53.p
  %st21 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st21
  %v54.p = getelementptr i64, ptr %v50, i64 1
  %v54 = load i64, ptr %v54.p
  %st22 = getelementptr i64, ptr %v52, i64 1
  store i64 %v54, ptr %st22
  %v55.p = getelementptr i64, ptr %v50, i64 2
  %v55 = load i64, ptr %v55.p
  %st23 = getelementptr i64, ptr %v52, i64 2
  store i64 %v55, ptr %st23
  %v536 = getelementptr i64, ptr @"rt.meta", i64 0
  %v56.p = getelementptr i64, ptr %v536, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 0
  %v58 = call ptr @"rt.region_alloc"(i64 %v56, i64 %v57)
  %v59 = add i64 0, 0
  %v60 = getelementptr i64, ptr %s2, i64 0
  %v61 = ptrtoint ptr %v58 to i64
  %st24 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st24
  %st25 = getelementptr i64, ptr %v60, i64 1
  store i64 %v59, ptr %st25
  %st26 = getelementptr i64, ptr %v60, i64 2
  store i64 %v56, ptr %st26
  %v62 = getelementptr i64, ptr %s6, i64 0
  %v63.p = getelementptr i64, ptr %v60, i64 0
  %v63 = load i64, ptr %v63.p
  %st27 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st27
  %v64.p = getelementptr i64, ptr %v60, i64 1
  %v64 = load i64, ptr %v64.p
  %st28 = getelementptr i64, ptr %v62, i64 1
  store i64 %v64, ptr %st28
  %v65.p = getelementptr i64, ptr %v60, i64 2
  %v65 = load i64, ptr %v65.p
  %st29 = getelementptr i64, ptr %v62, i64 2
  store i64 %v65, ptr %st29
  %v66.p = getelementptr i64, ptr %v14, i64 0
  %v66 = load i64, ptr %v66.p
  %v67 = add i64 0, 0
  %v68.c = icmp sge i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b3 = icmp ne i64 %v68, 0
  br i1 %c.b3, label %b3.t31, label %b3.e32
b3.t31:
  br label %b4
b3.e32:
  br label %b5
b4:
  %v69.p = getelementptr i64, ptr %v10, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v70, i64 2572
  store i64 %v3, ptr %st32
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v32, i64 %v69)
  %v71 = add i64 0, 1
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v72, i64 2572
  store i64 %v3, ptr %st33
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v52, i64 %v71)
  %v73.p = getelementptr i64, ptr %v14, i64 0
  %v73 = load i64, ptr %v73.p
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v74, i64 2572
  store i64 %v3, ptr %st34
  call void @"std/internal/floatfmt.bnShl"(ptr %v52, i64 %v73)
  %v75 = add i64 0, 1
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v76, i64 2572
  store i64 %v3, ptr %st35
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v62, i64 %v75)
  %v77.p = getelementptr i64, ptr %v14, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st36 = getelementptr i64, ptr %v78, i64 2572
  store i64 %v3, ptr %st36
  call void @"std/internal/floatfmt.bnShl"(ptr %v62, i64 %v77)
  %v79.p = getelementptr i64, ptr %v10, i64 0
  %v79 = load i64, ptr %v79.p
  %v80 = add i64 0, 4503599627370496
  %v81.c = icmp ne i64 %v79, %v80
  %v81 = zext i1 %v81.c to i64
  %c.b4 = icmp ne i64 %v81, 0
  br i1 %c.b4, label %b4.t38, label %b4.e39
b4.t38:
  br label %b6
b4.e39:
  br label %b7
b5:
  %v96.p = getelementptr i64, ptr %v10, i64 0
  %v96 = load i64, ptr %v96.p
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v97, i64 2572
  store i64 %v3, ptr %st39
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v32, i64 %v96)
  %v98 = add i64 0, 1
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v99, i64 2572
  store i64 %v3, ptr %st40
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v42, i64 %v98)
  %v100 = add i64 0, 1
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v101, i64 2572
  store i64 %v3, ptr %st41
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v62, i64 %v100)
  %v102 = add i64 0, 1
  %v103.c = icmp sle i64 %v1, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b5 = icmp ne i64 %v103, 0
  br i1 %c.b5, label %b5.t43, label %b5.e44
b5.t43:
  br label %b10
b5.e44:
  br label %b9
b6:
  %v82.p = getelementptr i64, ptr %v14, i64 0
  %v82 = load i64, ptr %v82.p
  %v83 = add i64 0, 1
  %v84 = add i64 %v82, %v83
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v85, i64 2572
  store i64 %v3, ptr %st44
  call void @"std/internal/floatfmt.bnShl"(ptr %v32, i64 %v84)
  %v86 = add i64 0, 2
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v87, i64 2572
  store i64 %v3, ptr %st45
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v42, i64 %v86)
  br label %b8
b7:
  %v88.p = getelementptr i64, ptr %v14, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = add i64 0, 2
  %v90 = add i64 %v88, %v89
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %st46 = getelementptr i64, ptr %v91, i64 2572
  store i64 %v3, ptr %st46
  call void @"std/internal/floatfmt.bnShl"(ptr %v32, i64 %v90)
  %v92 = add i64 0, 4
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v93, i64 2572
  store i64 %v3, ptr %st47
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v42, i64 %v92)
  %v94 = add i64 0, 1
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v95, i64 2572
  store i64 %v3, ptr %st48
  call void @"std/internal/floatfmt.bnShl"(ptr %v52, i64 %v94)
  br label %b8
b8:
  br label %b14
b9:
  %v105.p = getelementptr i64, ptr %v10, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = add i64 0, 4503599627370496
  %v107.c = icmp ne i64 %v105, %v106
  %v107 = zext i1 %v107.c to i64
  br label %b10
b10:
  %v104 = phi i64 [ %v103, %b5.t43 ], [ %v107, %b9 ]
  %c.b10 = icmp ne i64 %v104, 0
  br i1 %c.b10, label %b10.t50, label %b10.e51
b10.t50:
  br label %b11
b10.e51:
  br label %b12
b11:
  %v108 = add i64 0, 1
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v109, i64 2572
  store i64 %v3, ptr %st51
  call void @"std/internal/floatfmt.bnShl"(ptr %v32, i64 %v108)
  %v110 = add i64 0, 1
  %v111.p = getelementptr i64, ptr %v14, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = sub i64 %v110, %v111
  %v113 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v113, i64 2572
  store i64 %v3, ptr %st52
  call void @"std/internal/floatfmt.bnShl"(ptr %v42, i64 %v112)
  %v114 = add i64 0, 1
  %v115 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v115, i64 2572
  store i64 %v3, ptr %st53
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v52, i64 %v114)
  br label %b13
b12:
  %v116 = add i64 0, 2
  %v117 = getelementptr i64, ptr @"rt.meta", i64 0
  %st54 = getelementptr i64, ptr %v117, i64 2572
  store i64 %v3, ptr %st54
  call void @"std/internal/floatfmt.bnShl"(ptr %v32, i64 %v116)
  %v118 = add i64 0, 2
  %v119.p = getelementptr i64, ptr %v14, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = sub i64 %v118, %v119
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v121, i64 2572
  store i64 %v3, ptr %st55
  call void @"std/internal/floatfmt.bnShl"(ptr %v42, i64 %v120)
  %v122 = add i64 0, 2
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v123, i64 2572
  store i64 %v3, ptr %st56
  call void @"std/internal/floatfmt.bnSetInt"(ptr %v52, i64 %v122)
  br label %b13
b13:
  br label %b14
b14:
  %v124.p = getelementptr i64, ptr %v10, i64 0
  %v124 = load i64, ptr %v124.p
  %v125 = call i64 @"std/internal/floatfmt.bitLen"(i64 %v124)
  %v126.p = getelementptr i64, ptr %v14, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 %v125, %v126
  %v128 = add i64 0, 1
  %v129.c = icmp sge i64 %v127, %v128
  %v129 = zext i1 %v129.c to i64
  %c.b14 = icmp ne i64 %v129, 0
  br i1 %c.b14, label %b14.t58, label %b14.e59
b14.t58:
  br label %b15
b14.e59:
  br label %b16
b15:
  %v130 = add i64 0, 1
  %v131 = sub i64 %v127, %v130
  %v132 = add i64 0, 78913
  %v133 = mul i64 %v131, %v132
  %v134 = add i64 0, 18
  %v136 = add i64 0, 0
  %v137.c = icmp slt i64 %v134, %v136
  %v137 = zext i1 %v137.c to i64
  %c.b15 = icmp ne i64 %v137, 0
  br i1 %c.b15, label %b15.t60, label %b15.e61
b15.t60:
  br label %b17
b15.e61:
  br label %b18
b16:
  %v144 = add i64 0, 0
  %v145 = add i64 0, 1
  %v146 = sub i64 %v145, %v127
  %v147 = add i64 0, 78913
  %v148 = mul i64 %v146, %v147
  %v149 = add i64 0, 18
  %v151 = add i64 0, 0
  %v152.c = icmp slt i64 %v149, %v151
  %v152 = zext i1 %v152.c to i64
  %c.b16 = icmp ne i64 %v152, 0
  br i1 %c.b16, label %b16.t62, label %b16.e63
b16.t62:
  br label %b22
b16.e63:
  br label %b23
b17:
  %v138 = add i64 0, 20
  call void @"rt.panic"(i64 %v138)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v139 = add i64 0, 63
  %v140.c = icmp sgt i64 %v134, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b18 = icmp ne i64 %v140, 0
  br i1 %c.b18, label %b18.t64, label %b18.e65
b18.t64:
  br label %b20
b18.e65:
  br label %b21
b19:
  %v135 = phi i64 [ %v142, %b20 ], [ %v143, %b21 ]
  br label %b27
b20:
  %v141 = add i64 0, 63
  %v142.n = and i64 %v141, 63
  %v142 = ashr i64 %v133, %v142.n
  br label %b19
b21:
  %v143.n = and i64 %v134, 63
  %v143 = ashr i64 %v133, %v143.n
  br label %b19
b22:
  %v153 = add i64 0, 21
  call void @"rt.panic"(i64 %v153)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v154 = add i64 0, 63
  %v155.c = icmp sgt i64 %v149, %v154
  %v155 = zext i1 %v155.c to i64
  %c.b23 = icmp ne i64 %v155, 0
  br i1 %c.b23, label %b23.t66, label %b23.e67
b23.t66:
  br label %b25
b23.e67:
  br label %b26
b24:
  %v150 = phi i64 [ %v157, %b25 ], [ %v158, %b26 ]
  %v159 = add i64 0, 1
  %v160 = add i64 %v150, %v159
  %v161 = sub i64 %v144, %v160
  br label %b27
b25:
  %v156 = add i64 0, 63
  %v157.n = and i64 %v156, 63
  %v157 = ashr i64 %v148, %v157.n
  br label %b24
b26:
  %v158.n = and i64 %v149, 63
  %v158 = ashr i64 %v148, %v158.n
  br label %b24
b27:
  %v162 = phi i64 [ %v135, %b19 ], [ %v161, %b24 ]
  %v163 = getelementptr i64, ptr %s7, i64 0
  %st67 = getelementptr i64, ptr %v163, i64 0
  store i64 %v162, ptr %st67
  %v164.p = getelementptr i64, ptr %v163, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 0, 0
  %v166.c = icmp sge i64 %v164, %v165
  %v166 = zext i1 %v166.c to i64
  %c.b27 = icmp ne i64 %v166, 0
  br i1 %c.b27, label %b27.t69, label %b27.e70
b27.t69:
  br label %b28
b27.e70:
  br label %b29
b28:
  %v537 = getelementptr i64, ptr @"rt.meta", i64 0
  %v167.p = getelementptr i64, ptr %v537, i64 0
  %v167 = load i64, ptr %v167.p
  %v168 = add i64 0, 0
  %v169.p = getelementptr i64, ptr %v163, i64 0
  %v169 = load i64, ptr %v169.p
  %v170 = getelementptr i64, ptr %s8, i64 0
  %v538 = getelementptr i64, ptr @"rt.meta", i64 0
  %v171.p = getelementptr i64, ptr %v538, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = getelementptr i64, ptr %s9, i64 0
  %st70 = getelementptr i64, ptr %v172, i64 0
  store i64 %v168, ptr %st70
  %v539 = getelementptr i64, ptr @"rt.meta", i64 0
  %v173.p = getelementptr i64, ptr %v539, i64 0
  %v173 = load i64, ptr %v173.p
  br label %b32
b29:
  %v540 = getelementptr i64, ptr @"rt.meta", i64 0
  %v185.p = getelementptr i64, ptr %v540, i64 0
  %v185 = load i64, ptr %v185.p
  %v186 = add i64 0, 0
  %v187 = add i64 0, 0
  %v188.p = getelementptr i64, ptr %v163, i64 0
  %v188 = load i64, ptr %v188.p
  %v189 = sub i64 %v187, %v188
  %v190 = getelementptr i64, ptr %s9, i64 0
  %v541 = getelementptr i64, ptr @"rt.meta", i64 0
  %v191.p = getelementptr i64, ptr %v541, i64 0
  %v191 = load i64, ptr %v191.p
  %v192 = getelementptr i64, ptr %s8, i64 0
  %st71 = getelementptr i64, ptr %v192, i64 0
  store i64 %v186, ptr %st71
  %v542 = getelementptr i64, ptr @"rt.meta", i64 0
  %v193.p = getelementptr i64, ptr %v542, i64 0
  %v193 = load i64, ptr %v193.p
  br label %b38
b30:
  %v543 = getelementptr i64, ptr @"rt.meta", i64 0
  %st72 = getelementptr i64, ptr %v543, i64 0
  store i64 %v167, ptr %st72
  br label %b42
b31:
  br label %b30
b32:
  %v544 = getelementptr i64, ptr @"rt.meta", i64 0
  %st73 = getelementptr i64, ptr %v544, i64 0
  store i64 %v173, ptr %st73
  %v174.p = getelementptr i64, ptr %v172, i64 0
  %v174 = load i64, ptr %v174.p
  %v175.c = icmp slt i64 %v174, %v169
  %v175 = zext i1 %v175.c to i64
  %c.b32 = icmp ne i64 %v175, 0
  br i1 %c.b32, label %b32.t75, label %b32.e76
b32.t75:
  br label %b33
b32.e76:
  br label %b34
b33:
  call void @"rt.region_enter"()
  %v545 = getelementptr i64, ptr @"rt.meta", i64 0
  %v176.p = getelementptr i64, ptr %v545, i64 0
  %v176 = load i64, ptr %v176.p
  %v177.p = getelementptr i64, ptr %v172, i64 0
  %v177 = load i64, ptr %v177.p
  %v546 = getelementptr i64, ptr @"rt.meta", i64 0
  %v178.p = getelementptr i64, ptr %v546, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 10
  %v180 = add i64 0, 0
  %v181 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v181, i64 2572
  store i64 %v3, ptr %st76
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v42, i64 %v179, i64 %v180)
  br label %b35
b34:
  %v547 = getelementptr i64, ptr @"rt.meta", i64 0
  %st77 = getelementptr i64, ptr %v547, i64 0
  store i64 %v173, ptr %st77
  br label %b31
b35:
  %v548 = getelementptr i64, ptr @"rt.meta", i64 0
  %st78 = getelementptr i64, ptr %v548, i64 0
  store i64 %v178, ptr %st78
  %v182 = add i64 0, 1
  %v183.p = getelementptr i64, ptr %v172, i64 0
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 %v183, %v182
  %st79 = getelementptr i64, ptr %v172, i64 0
  store i64 %v184, ptr %st79
  br label %b32
b36:
  %v549 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v549, i64 0
  store i64 %v185, ptr %st80
  br label %b42
b37:
  br label %b36
b38:
  %v550 = getelementptr i64, ptr @"rt.meta", i64 0
  %st81 = getelementptr i64, ptr %v550, i64 0
  store i64 %v193, ptr %st81
  %v194.p = getelementptr i64, ptr %v192, i64 0
  %v194 = load i64, ptr %v194.p
  %v195.c = icmp slt i64 %v194, %v189
  %v195 = zext i1 %v195.c to i64
  %c.b38 = icmp ne i64 %v195, 0
  br i1 %c.b38, label %b38.t83, label %b38.e84
b38.t83:
  br label %b39
b38.e84:
  br label %b40
b39:
  call void @"rt.region_enter"()
  %v551 = getelementptr i64, ptr @"rt.meta", i64 0
  %v196.p = getelementptr i64, ptr %v551, i64 0
  %v196 = load i64, ptr %v196.p
  %v197.p = getelementptr i64, ptr %v192, i64 0
  %v197 = load i64, ptr %v197.p
  %v552 = getelementptr i64, ptr @"rt.meta", i64 0
  %v198.p = getelementptr i64, ptr %v552, i64 0
  %v198 = load i64, ptr %v198.p
  %v199 = add i64 0, 10
  %v200 = add i64 0, 0
  %v201 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v201, i64 2572
  store i64 %v3, ptr %st84
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v32, i64 %v199, i64 %v200)
  %v202 = add i64 0, 10
  %v203 = add i64 0, 0
  %v204 = getelementptr i64, ptr @"rt.meta", i64 0
  %st85 = getelementptr i64, ptr %v204, i64 2572
  store i64 %v3, ptr %st85
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v52, i64 %v202, i64 %v203)
  %v205 = add i64 0, 10
  %v206 = add i64 0, 0
  %v207 = getelementptr i64, ptr @"rt.meta", i64 0
  %st86 = getelementptr i64, ptr %v207, i64 2572
  store i64 %v3, ptr %st86
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v62, i64 %v205, i64 %v206)
  br label %b41
b40:
  %v553 = getelementptr i64, ptr @"rt.meta", i64 0
  %st87 = getelementptr i64, ptr %v553, i64 0
  store i64 %v193, ptr %st87
  br label %b37
b41:
  %v554 = getelementptr i64, ptr @"rt.meta", i64 0
  %st88 = getelementptr i64, ptr %v554, i64 0
  store i64 %v198, ptr %st88
  %v208 = add i64 0, 1
  %v209.p = getelementptr i64, ptr %v192, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = add i64 %v209, %v208
  %st89 = getelementptr i64, ptr %v192, i64 0
  store i64 %v210, ptr %st89
  br label %b38
b42:
  %v555 = getelementptr i64, ptr @"rt.meta", i64 0
  %v211.p = getelementptr i64, ptr %v555, i64 0
  %v211 = load i64, ptr %v211.p
  %v212 = add i64 0, 0
  %v213 = call ptr @"rt.region_alloc"(i64 %v211, i64 %v212)
  %v214 = add i64 0, 0
  %v215 = getelementptr i64, ptr %s2, i64 0
  %v216 = ptrtoint ptr %v213 to i64
  %st90 = getelementptr i64, ptr %v215, i64 0
  store i64 %v216, ptr %st90
  %st91 = getelementptr i64, ptr %v215, i64 1
  store i64 %v214, ptr %st91
  %st92 = getelementptr i64, ptr %v215, i64 2
  store i64 %v211, ptr %st92
  %v217 = getelementptr i64, ptr %s10, i64 0
  %v218.p = getelementptr i64, ptr %v215, i64 0
  %v218 = load i64, ptr %v218.p
  %st93 = getelementptr i64, ptr %v217, i64 0
  store i64 %v218, ptr %st93
  %v219.p = getelementptr i64, ptr %v215, i64 1
  %v219 = load i64, ptr %v219.p
  %st94 = getelementptr i64, ptr %v217, i64 1
  store i64 %v219, ptr %st94
  %v220.p = getelementptr i64, ptr %v215, i64 2
  %v220 = load i64, ptr %v220.p
  %st95 = getelementptr i64, ptr %v217, i64 2
  store i64 %v220, ptr %st95
  %v221 = add i64 0, 0
  %v222 = getelementptr i64, ptr %s8, i64 0
  %st96 = getelementptr i64, ptr %v222, i64 0
  store i64 %v221, ptr %st96
  %v556 = getelementptr i64, ptr @"rt.meta", i64 0
  %v223.p = getelementptr i64, ptr %v556, i64 0
  %v223 = load i64, ptr %v223.p
  br label %b43
b43:
  %v557 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v557, i64 0
  store i64 %v223, ptr %st97
  %v224.p = getelementptr i64, ptr %v222, i64 0
  %v224 = load i64, ptr %v224.p
  %v225 = add i64 0, 1
  %v226 = xor i64 %v224, %v225
  %c.b43 = icmp ne i64 %v226, 0
  br i1 %c.b43, label %b43.t99, label %b43.e100
b43.t99:
  br label %b44
b43.e100:
  br label %b45
b44:
  call void @"rt.region_enter"()
  %v558 = getelementptr i64, ptr @"rt.meta", i64 0
  %v227.p = getelementptr i64, ptr %v558, i64 0
  %v227 = load i64, ptr %v227.p
  %v228.c = icmp slt i64 %v3, %v3
  %v228 = zext i1 %v228.c to i64
  %v229 = sub i64 %v3, %v3
  %v230 = mul i64 %v228, %v229
  %v231 = add i64 %v3, %v230
  %v232 = getelementptr i64, ptr @"rt.meta", i64 0
  %st100 = getelementptr i64, ptr %v232, i64 2572
  store i64 %v231, ptr %st100
  call void @"std/internal/floatfmt.bnSet"(ptr %v217, ptr %v32)
  %v233.c = icmp slt i64 %v3, %v3
  %v233 = zext i1 %v233.c to i64
  %v234 = sub i64 %v3, %v3
  %v235 = mul i64 %v233, %v234
  %v236 = add i64 %v3, %v235
  %v237 = getelementptr i64, ptr @"rt.meta", i64 0
  %st101 = getelementptr i64, ptr %v237, i64 2572
  store i64 %v236, ptr %st101
  call void @"std/internal/floatfmt.bnAdd"(ptr %v217, ptr %v52)
  %v238.c = icmp slt i64 %v3, %v3
  %v238 = zext i1 %v238.c to i64
  %v239 = sub i64 %v3, %v3
  %v240 = mul i64 %v238, %v239
  %v241 = add i64 %v3, %v240
  %v242 = getelementptr i64, ptr @"rt.meta", i64 0
  %st102 = getelementptr i64, ptr %v242, i64 2572
  store i64 %v241, ptr %st102
  %v243 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v217, ptr %v42)
  %v244 = add i64 0, 0
  %v245.c = icmp sgt i64 %v243, %v244
  %v245 = zext i1 %v245.c to i64
  %c.b44 = icmp ne i64 %v245, 0
  br i1 %c.b44, label %b44.t104, label %b44.e105
b44.t104:
  br label %b47
b44.e105:
  br label %b46
b45:
  %v559 = getelementptr i64, ptr @"rt.meta", i64 0
  %st105 = getelementptr i64, ptr %v559, i64 0
  store i64 %v223, ptr %st105
  %v286 = add i64 0, 0
  %v287 = getelementptr i64, ptr %s9, i64 0
  %st106 = getelementptr i64, ptr %v287, i64 0
  store i64 %v286, ptr %st106
  %v560 = getelementptr i64, ptr @"rt.meta", i64 0
  %v288.p = getelementptr i64, ptr %v560, i64 0
  %v288 = load i64, ptr %v288.p
  br label %b60
b46:
  %v247 = add i64 0, 0
  %v248.c = icmp eq i64 %v243, %v247
  %v248 = zext i1 %v248.c to i64
  %c.b46 = icmp ne i64 %v248, 0
  br i1 %c.b46, label %b46.t108, label %b46.e109
b46.t108:
  br label %b48
b46.e109:
  br label %b49
b47:
  %v246 = phi i64 [ %v245, %b44.t104 ], [ %v249, %b49 ]
  %c.b47 = icmp ne i64 %v246, 0
  br i1 %c.b47, label %b47.t110, label %b47.e111
b47.t110:
  br label %b50
b47.e111:
  br label %b51
b48:
  br label %b49
b49:
  %v249 = phi i64 [ %v248, %b46.e109 ], [ %v25, %b48 ]
  br label %b47
b50:
  %v250 = add i64 0, 10
  %v251 = add i64 0, 0
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %st111 = getelementptr i64, ptr %v252, i64 2572
  store i64 %v3, ptr %st111
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v42, i64 %v250, i64 %v251)
  %v253 = add i64 0, 1
  %v254.p = getelementptr i64, ptr %v163, i64 0
  %v254 = load i64, ptr %v254.p
  %v255 = add i64 %v254, %v253
  %st112 = getelementptr i64, ptr %v163, i64 0
  store i64 %v255, ptr %st112
  br label %b59
b51:
  %v256 = add i64 0, 10
  %v257 = add i64 0, 0
  %v258 = getelementptr i64, ptr @"rt.meta", i64 0
  %st113 = getelementptr i64, ptr %v258, i64 2572
  store i64 %v3, ptr %st113
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v217, i64 %v256, i64 %v257)
  %v259.c = icmp slt i64 %v3, %v3
  %v259 = zext i1 %v259.c to i64
  %v260 = sub i64 %v3, %v3
  %v261 = mul i64 %v259, %v260
  %v262 = add i64 %v3, %v261
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v263, i64 2572
  store i64 %v262, ptr %st114
  %v264 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v217, ptr %v42)
  %v265 = add i64 0, 0
  %v266.c = icmp slt i64 %v264, %v265
  %v266 = zext i1 %v266.c to i64
  %c.b51 = icmp ne i64 %v266, 0
  br i1 %c.b51, label %b51.t116, label %b51.e117
b51.t116:
  br label %b53
b51.e117:
  br label %b52
b52:
  %v268 = add i64 0, 0
  %v269.c = icmp eq i64 %v264, %v268
  %v269 = zext i1 %v269.c to i64
  %c.b52 = icmp ne i64 %v269, 0
  br i1 %c.b52, label %b52.t118, label %b52.e119
b52.t118:
  br label %b54
b52.e119:
  br label %b55
b53:
  %v267 = phi i64 [ %v266, %b51.t116 ], [ %v270, %b55 ]
  %c.b53 = icmp ne i64 %v267, 0
  br i1 %c.b53, label %b53.t120, label %b53.e121
b53.t120:
  br label %b56
b53.e121:
  br label %b57
b54:
  %v271 = add i64 0, 1
  %v272 = xor i64 %v25, %v271
  br label %b55
b55:
  %v270 = phi i64 [ %v269, %b52.e119 ], [ %v272, %b54 ]
  br label %b53
b56:
  %v273 = add i64 0, 10
  %v274 = add i64 0, 0
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st121 = getelementptr i64, ptr %v275, i64 2572
  store i64 %v3, ptr %st121
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v32, i64 %v273, i64 %v274)
  %v276 = add i64 0, 10
  %v277 = add i64 0, 0
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v278, i64 2572
  store i64 %v3, ptr %st122
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v52, i64 %v276, i64 %v277)
  %v279 = add i64 0, 10
  %v280 = add i64 0, 0
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %st123 = getelementptr i64, ptr %v281, i64 2572
  store i64 %v3, ptr %st123
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v62, i64 %v279, i64 %v280)
  %v282 = add i64 0, 1
  %v283.p = getelementptr i64, ptr %v163, i64 0
  %v283 = load i64, ptr %v283.p
  %v284 = sub i64 %v283, %v282
  %st124 = getelementptr i64, ptr %v163, i64 0
  store i64 %v284, ptr %st124
  br label %b58
b57:
  %v285 = add i64 0, 1
  %st125 = getelementptr i64, ptr %v222, i64 0
  store i64 %v285, ptr %st125
  br label %b58
b58:
  br label %b59
b59:
  br label %b43
b60:
  %v561 = getelementptr i64, ptr @"rt.meta", i64 0
  %st126 = getelementptr i64, ptr %v561, i64 0
  store i64 %v288, ptr %st126
  %v289.p = getelementptr i64, ptr %v287, i64 0
  %v289 = load i64, ptr %v289.p
  %v290 = add i64 0, 1
  %v291 = xor i64 %v289, %v290
  %c.b60 = icmp ne i64 %v291, 0
  br i1 %c.b60, label %b60.t128, label %b60.e129
b60.t128:
  br label %b61
b60.e129:
  br label %b62
b61:
  call void @"rt.region_enter"()
  %v562 = getelementptr i64, ptr @"rt.meta", i64 0
  %v292.p = getelementptr i64, ptr %v562, i64 0
  %v292 = load i64, ptr %v292.p
  %v293 = add i64 0, 10
  %v294 = add i64 0, 0
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %st129 = getelementptr i64, ptr %v295, i64 2572
  store i64 %v3, ptr %st129
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v32, i64 %v293, i64 %v294)
  %v296 = add i64 0, 10
  %v297 = add i64 0, 0
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %st130 = getelementptr i64, ptr %v298, i64 2572
  store i64 %v3, ptr %st130
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v52, i64 %v296, i64 %v297)
  %v299 = add i64 0, 10
  %v300 = add i64 0, 0
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %st131 = getelementptr i64, ptr %v301, i64 2572
  store i64 %v3, ptr %st131
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v62, i64 %v299, i64 %v300)
  %v302 = add i64 0, 0
  %v303 = getelementptr i64, ptr %s11, i64 0
  %st132 = getelementptr i64, ptr %v303, i64 0
  store i64 %v302, ptr %st132
  %v563 = getelementptr i64, ptr @"rt.meta", i64 0
  %v304.p = getelementptr i64, ptr %v563, i64 0
  %v304 = load i64, ptr %v304.p
  br label %b63
b62:
  %v564 = getelementptr i64, ptr @"rt.meta", i64 0
  %st133 = getelementptr i64, ptr %v564, i64 0
  store i64 %v288, ptr %st133
  %v531.p = getelementptr i64, ptr %v163, i64 0
  %v531 = load i64, ptr %v531.p
  %v565 = getelementptr i64, ptr @"rt.meta", i64 0
  %st134 = getelementptr i64, ptr %v565, i64 0
  store i64 %v3, ptr %st134
  ret i64 %v531
b63:
  %v566 = getelementptr i64, ptr @"rt.meta", i64 0
  %st135 = getelementptr i64, ptr %v566, i64 0
  store i64 %v304, ptr %st135
  %v305.c = icmp slt i64 %v3, %v3
  %v305 = zext i1 %v305.c to i64
  %v306 = sub i64 %v3, %v3
  %v307 = mul i64 %v305, %v306
  %v308 = add i64 %v3, %v307
  %v309 = getelementptr i64, ptr @"rt.meta", i64 0
  %st136 = getelementptr i64, ptr %v309, i64 2572
  store i64 %v308, ptr %st136
  %v310 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v32, ptr %v42)
  %v311 = add i64 0, 0
  %v312.c = icmp sge i64 %v310, %v311
  %v312 = zext i1 %v312.c to i64
  %c.b63 = icmp ne i64 %v312, 0
  br i1 %c.b63, label %b63.t138, label %b63.e139
b63.t138:
  br label %b64
b63.e139:
  br label %b65
b64:
  call void @"rt.region_enter"()
  %v567 = getelementptr i64, ptr @"rt.meta", i64 0
  %v313.p = getelementptr i64, ptr %v567, i64 0
  %v313 = load i64, ptr %v313.p
  %v314.c = icmp slt i64 %v3, %v3
  %v314 = zext i1 %v314.c to i64
  %v315 = sub i64 %v3, %v3
  %v316 = mul i64 %v314, %v315
  %v317 = add i64 %v3, %v316
  %v318 = getelementptr i64, ptr @"rt.meta", i64 0
  %st139 = getelementptr i64, ptr %v318, i64 2572
  store i64 %v317, ptr %st139
  call void @"std/internal/floatfmt.bnSub"(ptr %v32, ptr %v42)
  %v319 = add i64 0, 1
  %v320.p = getelementptr i64, ptr %v303, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = add i64 %v320, %v319
  %st140 = getelementptr i64, ptr %v303, i64 0
  store i64 %v321, ptr %st140
  br label %b63
b65:
  %v568 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v568, i64 0
  store i64 %v304, ptr %st141
  %v322.c = icmp slt i64 %v3, %v3
  %v322 = zext i1 %v322.c to i64
  %v323 = sub i64 %v3, %v3
  %v324 = mul i64 %v322, %v323
  %v325 = add i64 %v3, %v324
  %v326 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v326, i64 2572
  store i64 %v325, ptr %st142
  %v327 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v32, ptr %v62)
  %v328 = add i64 0, 0
  %v329.c = icmp slt i64 %v327, %v328
  %v329 = zext i1 %v329.c to i64
  %c.b65 = icmp ne i64 %v329, 0
  br i1 %c.b65, label %b65.t144, label %b65.e145
b65.t144:
  br label %b67
b65.e145:
  br label %b66
b66:
  %v331 = add i64 0, 0
  %v332.c = icmp eq i64 %v327, %v331
  %v332 = zext i1 %v332.c to i64
  %c.b66 = icmp ne i64 %v332, 0
  br i1 %c.b66, label %b66.t146, label %b66.e147
b66.t146:
  br label %b68
b66.e147:
  br label %b69
b67:
  %v330 = phi i64 [ %v329, %b65.t144 ], [ %v333, %b69 ]
  %v334.c = icmp slt i64 %v3, %v3
  %v334 = zext i1 %v334.c to i64
  %v335 = sub i64 %v3, %v3
  %v336 = mul i64 %v334, %v335
  %v337 = add i64 %v3, %v336
  %v338 = getelementptr i64, ptr @"rt.meta", i64 0
  %st147 = getelementptr i64, ptr %v338, i64 2572
  store i64 %v337, ptr %st147
  call void @"std/internal/floatfmt.bnSet"(ptr %v217, ptr %v32)
  %v339.c = icmp slt i64 %v3, %v3
  %v339 = zext i1 %v339.c to i64
  %v340 = sub i64 %v3, %v3
  %v341 = mul i64 %v339, %v340
  %v342 = add i64 %v3, %v341
  %v343 = getelementptr i64, ptr @"rt.meta", i64 0
  %st148 = getelementptr i64, ptr %v343, i64 2572
  store i64 %v342, ptr %st148
  call void @"std/internal/floatfmt.bnAdd"(ptr %v217, ptr %v52)
  %v344.c = icmp slt i64 %v3, %v3
  %v344 = zext i1 %v344.c to i64
  %v345 = sub i64 %v3, %v3
  %v346 = mul i64 %v344, %v345
  %v347 = add i64 %v3, %v346
  %v348 = getelementptr i64, ptr @"rt.meta", i64 0
  %st149 = getelementptr i64, ptr %v348, i64 2572
  store i64 %v347, ptr %st149
  %v349 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v217, ptr %v42)
  %v350 = add i64 0, 0
  %v351.c = icmp sgt i64 %v349, %v350
  %v351 = zext i1 %v351.c to i64
  %c.b67 = icmp ne i64 %v351, 0
  br i1 %c.b67, label %b67.t151, label %b67.e152
b67.t151:
  br label %b71
b67.e152:
  br label %b70
b68:
  br label %b69
b69:
  %v333 = phi i64 [ %v332, %b66.e147 ], [ %v25, %b68 ]
  br label %b67
b70:
  %v353 = add i64 0, 0
  %v354.c = icmp eq i64 %v349, %v353
  %v354 = zext i1 %v354.c to i64
  %c.b70 = icmp ne i64 %v354, 0
  br i1 %c.b70, label %b70.t153, label %b70.e154
b70.t153:
  br label %b72
b70.e154:
  br label %b73
b71:
  %v352 = phi i64 [ %v351, %b67.t151 ], [ %v355, %b73 ]
  %v356 = add i64 0, 1
  %v357 = xor i64 %v330, %v356
  %c.b71 = icmp ne i64 %v357, 0
  br i1 %c.b71, label %b71.t155, label %b71.e156
b71.t155:
  br label %b74
b71.e156:
  br label %b75
b72:
  br label %b73
b73:
  %v355 = phi i64 [ %v354, %b70.e154 ], [ %v25, %b72 ]
  br label %b71
b74:
  %v359 = add i64 0, 1
  %v360 = xor i64 %v352, %v359
  br label %b75
b75:
  %v358 = phi i64 [ %v357, %b71.e156 ], [ %v360, %b74 ]
  %c.b75 = icmp ne i64 %v358, 0
  br i1 %c.b75, label %b75.t157, label %b75.e158
b75.t157:
  br label %b76
b75.e158:
  br label %b77
b76:
  %v361 = getelementptr i64, ptr %s2, i64 0
  %v362.p = getelementptr i64, ptr %v0, i64 0
  %v362 = load i64, ptr %v362.p
  %st158 = getelementptr i64, ptr %v361, i64 0
  store i64 %v362, ptr %st158
  %v363.p = getelementptr i64, ptr %v0, i64 1
  %v363 = load i64, ptr %v363.p
  %st159 = getelementptr i64, ptr %v361, i64 1
  store i64 %v363, ptr %st159
  %v364.p = getelementptr i64, ptr %v0, i64 2
  %v364 = load i64, ptr %v364.p
  %st160 = getelementptr i64, ptr %v361, i64 2
  store i64 %v364, ptr %st160
  %v365.p = getelementptr i64, ptr %v303, i64 0
  %v365 = load i64, ptr %v365.p
  %v366.p = getelementptr i64, ptr %v361, i64 2
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v361, i64 0
  %v367 = load i64, ptr %v367.p
  %v368.p = getelementptr i64, ptr %v361, i64 1
  %v368 = load i64, ptr %v368.p
  %v371 = add i64 0, 8
  %v372 = mul i64 %v368, %v371
  %v373 = add i64 %v367, %v372
  %v569 = getelementptr i64, ptr @"rt.meta", i64 0
  %v570 = getelementptr i64, ptr %v569, i64 %v366
  %v374.p = getelementptr i64, ptr %v570, i64 1
  %v374 = load ptr, ptr %v374.p
  %v375 = ptrtoint ptr %v374 to i64
  %v376.c = icmp eq i64 %v375, %v373
  %v376 = zext i1 %v376.c to i64
  %c.b76 = icmp ne i64 %v376, 0
  br i1 %c.b76, label %b76.t162, label %b76.e163
b76.t162:
  br label %b80
b76.e163:
  br label %b79
b77:
  %v394 = add i64 0, 1
  %st163 = getelementptr i64, ptr %v287, i64 0
  store i64 %v394, ptr %st163
  %c.b77 = icmp ne i64 %v330, 0
  br i1 %c.b77, label %b77.t165, label %b77.e166
b77.t165:
  br label %b81
b77.e166:
  br label %b82
b78:
  %v369 = phi ptr [ %v384, %b79 ], [ %v379, %b80 ]
  %v370 = phi ptr [ %v385, %b79 ], [ %v378, %b80 ]
  %st166 = getelementptr i64, ptr %v370, i64 0
  store i64 %v365, ptr %st166
  %v386.p = getelementptr i64, ptr %v361, i64 1
  %v386 = load i64, ptr %v386.p
  %v387 = add i64 0, 1
  %v388 = add i64 %v386, %v387
  %v389 = getelementptr i64, ptr %s12, i64 0
  %v390 = ptrtoint ptr %v369 to i64
  %st167 = getelementptr i64, ptr %v389, i64 0
  store i64 %v390, ptr %st167
  %st168 = getelementptr i64, ptr %v389, i64 1
  store i64 %v388, ptr %st168
  %st169 = getelementptr i64, ptr %v389, i64 2
  store i64 %v366, ptr %st169
  %v391.p = getelementptr i64, ptr %v389, i64 0
  %v391 = load i64, ptr %v391.p
  %st170 = getelementptr i64, ptr %v0, i64 0
  store i64 %v391, ptr %st170
  %v392.p = getelementptr i64, ptr %v389, i64 1
  %v392 = load i64, ptr %v392.p
  %st171 = getelementptr i64, ptr %v0, i64 1
  store i64 %v392, ptr %st171
  %v393.p = getelementptr i64, ptr %v389, i64 2
  %v393 = load i64, ptr %v393.p
  %st172 = getelementptr i64, ptr %v0, i64 2
  store i64 %v393, ptr %st172
  br label %b107
b79:
  %v380 = add i64 0, 1
  %v381 = mul i64 %v368, %v380
  %v382 = add i64 0, 1
  %v383 = add i64 0, 1
  %v384 = call ptr @"rt.slice_grow"(i64 %v367, i64 %v368, i64 %v382, i64 %v366, i64 %v383)
  %v385 = getelementptr i64, ptr %v384, i64 %v381
  br label %b78
b80:
  %v377 = add i64 0, 1
  %v378 = call ptr @"rt.region_alloc"(i64 %v366, i64 %v377)
  %v379 = inttoptr i64 %v367 to ptr
  br label %b78
b81:
  %v396 = add i64 0, 1
  %v397 = xor i64 %v352, %v396
  br label %b82
b82:
  %v395 = phi i64 [ %v330, %b77.e166 ], [ %v397, %b81 ]
  %c.b82 = icmp ne i64 %v395, 0
  br i1 %c.b82, label %b82.t174, label %b82.e175
b82.t174:
  br label %b83
b82.e175:
  br label %b84
b83:
  %v398 = getelementptr i64, ptr %s12, i64 0
  %v399.p = getelementptr i64, ptr %v0, i64 0
  %v399 = load i64, ptr %v399.p
  %st175 = getelementptr i64, ptr %v398, i64 0
  store i64 %v399, ptr %st175
  %v400.p = getelementptr i64, ptr %v0, i64 1
  %v400 = load i64, ptr %v400.p
  %st176 = getelementptr i64, ptr %v398, i64 1
  store i64 %v400, ptr %st176
  %v401.p = getelementptr i64, ptr %v0, i64 2
  %v401 = load i64, ptr %v401.p
  %st177 = getelementptr i64, ptr %v398, i64 2
  store i64 %v401, ptr %st177
  %v402.p = getelementptr i64, ptr %v303, i64 0
  %v402 = load i64, ptr %v402.p
  %v403.p = getelementptr i64, ptr %v398, i64 2
  %v403 = load i64, ptr %v403.p
  %v404.p = getelementptr i64, ptr %v398, i64 0
  %v404 = load i64, ptr %v404.p
  %v405.p = getelementptr i64, ptr %v398, i64 1
  %v405 = load i64, ptr %v405.p
  %v408 = add i64 0, 8
  %v409 = mul i64 %v405, %v408
  %v410 = add i64 %v404, %v409
  %v571 = getelementptr i64, ptr @"rt.meta", i64 0
  %v572 = getelementptr i64, ptr %v571, i64 %v403
  %v411.p = getelementptr i64, ptr %v572, i64 1
  %v411 = load ptr, ptr %v411.p
  %v412 = ptrtoint ptr %v411 to i64
  %v413.c = icmp eq i64 %v412, %v410
  %v413 = zext i1 %v413.c to i64
  %c.b83 = icmp ne i64 %v413, 0
  br i1 %c.b83, label %b83.t179, label %b83.e180
b83.t179:
  br label %b87
b83.e180:
  br label %b86
b84:
  %v431 = add i64 0, 1
  %v432 = xor i64 %v330, %v431
  %c.b84 = icmp ne i64 %v432, 0
  br i1 %c.b84, label %b84.t181, label %b84.e182
b84.t181:
  br label %b88
b84.e182:
  br label %b89
b85:
  %v406 = phi ptr [ %v421, %b86 ], [ %v416, %b87 ]
  %v407 = phi ptr [ %v422, %b86 ], [ %v415, %b87 ]
  %st182 = getelementptr i64, ptr %v407, i64 0
  store i64 %v402, ptr %st182
  %v423.p = getelementptr i64, ptr %v398, i64 1
  %v423 = load i64, ptr %v423.p
  %v424 = add i64 0, 1
  %v425 = add i64 %v423, %v424
  %v426 = getelementptr i64, ptr %s2, i64 0
  %v427 = ptrtoint ptr %v406 to i64
  %st183 = getelementptr i64, ptr %v426, i64 0
  store i64 %v427, ptr %st183
  %st184 = getelementptr i64, ptr %v426, i64 1
  store i64 %v425, ptr %st184
  %st185 = getelementptr i64, ptr %v426, i64 2
  store i64 %v403, ptr %st185
  %v428.p = getelementptr i64, ptr %v426, i64 0
  %v428 = load i64, ptr %v428.p
  %st186 = getelementptr i64, ptr %v0, i64 0
  store i64 %v428, ptr %st186
  %v429.p = getelementptr i64, ptr %v426, i64 1
  %v429 = load i64, ptr %v429.p
  %st187 = getelementptr i64, ptr %v0, i64 1
  store i64 %v429, ptr %st187
  %v430.p = getelementptr i64, ptr %v426, i64 2
  %v430 = load i64, ptr %v430.p
  %st188 = getelementptr i64, ptr %v0, i64 2
  store i64 %v430, ptr %st188
  br label %b106
b86:
  %v417 = add i64 0, 1
  %v418 = mul i64 %v405, %v417
  %v419 = add i64 0, 1
  %v420 = add i64 0, 1
  %v421 = call ptr @"rt.slice_grow"(i64 %v404, i64 %v405, i64 %v419, i64 %v403, i64 %v420)
  %v422 = getelementptr i64, ptr %v421, i64 %v418
  br label %b85
b87:
  %v414 = add i64 0, 1
  %v415 = call ptr @"rt.region_alloc"(i64 %v403, i64 %v414)
  %v416 = inttoptr i64 %v404 to ptr
  br label %b85
b88:
  br label %b89
b89:
  %v433 = phi i64 [ %v432, %b84.e182 ], [ %v352, %b88 ]
  %c.b89 = icmp ne i64 %v433, 0
  br i1 %c.b89, label %b89.t190, label %b89.e191
b89.t190:
  br label %b90
b89.e191:
  br label %b91
b90:
  %v434 = getelementptr i64, ptr %s2, i64 0
  %v435.p = getelementptr i64, ptr %v0, i64 0
  %v435 = load i64, ptr %v435.p
  %st191 = getelementptr i64, ptr %v434, i64 0
  store i64 %v435, ptr %st191
  %v436.p = getelementptr i64, ptr %v0, i64 1
  %v436 = load i64, ptr %v436.p
  %st192 = getelementptr i64, ptr %v434, i64 1
  store i64 %v436, ptr %st192
  %v437.p = getelementptr i64, ptr %v0, i64 2
  %v437 = load i64, ptr %v437.p
  %st193 = getelementptr i64, ptr %v434, i64 2
  store i64 %v437, ptr %st193
  %v438.p = getelementptr i64, ptr %v303, i64 0
  %v438 = load i64, ptr %v438.p
  %v439 = add i64 0, 1
  %v440 = add i64 %v438, %v439
  %v441.p = getelementptr i64, ptr %v434, i64 2
  %v441 = load i64, ptr %v441.p
  %v442.p = getelementptr i64, ptr %v434, i64 0
  %v442 = load i64, ptr %v442.p
  %v443.p = getelementptr i64, ptr %v434, i64 1
  %v443 = load i64, ptr %v443.p
  %v446 = add i64 0, 8
  %v447 = mul i64 %v443, %v446
  %v448 = add i64 %v442, %v447
  %v573 = getelementptr i64, ptr @"rt.meta", i64 0
  %v574 = getelementptr i64, ptr %v573, i64 %v441
  %v449.p = getelementptr i64, ptr %v574, i64 1
  %v449 = load ptr, ptr %v449.p
  %v450 = ptrtoint ptr %v449 to i64
  %v451.c = icmp eq i64 %v450, %v448
  %v451 = zext i1 %v451.c to i64
  %c.b90 = icmp ne i64 %v451, 0
  br i1 %c.b90, label %b90.t195, label %b90.e196
b90.t195:
  br label %b94
b90.e196:
  br label %b93
b91:
  %v469.c = icmp slt i64 %v3, %v3
  %v469 = zext i1 %v469.c to i64
  %v470 = sub i64 %v3, %v3
  %v471 = mul i64 %v469, %v470
  %v472 = add i64 %v3, %v471
  %v473 = getelementptr i64, ptr @"rt.meta", i64 0
  %st196 = getelementptr i64, ptr %v473, i64 2572
  store i64 %v472, ptr %st196
  call void @"std/internal/floatfmt.bnSet"(ptr %v217, ptr %v32)
  %v474 = add i64 0, 2
  %v475 = add i64 0, 0
  %v476 = getelementptr i64, ptr @"rt.meta", i64 0
  %st197 = getelementptr i64, ptr %v476, i64 2572
  store i64 %v3, ptr %st197
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v217, i64 %v474, i64 %v475)
  %v477.c = icmp slt i64 %v3, %v3
  %v477 = zext i1 %v477.c to i64
  %v478 = sub i64 %v3, %v3
  %v479 = mul i64 %v477, %v478
  %v480 = add i64 %v3, %v479
  %v481 = getelementptr i64, ptr @"rt.meta", i64 0
  %st198 = getelementptr i64, ptr %v481, i64 2572
  store i64 %v480, ptr %st198
  %v482 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v217, ptr %v42)
  %v483 = getelementptr i64, ptr %s12, i64 0
  %v484.p = getelementptr i64, ptr %v0, i64 0
  %v484 = load i64, ptr %v484.p
  %st199 = getelementptr i64, ptr %v483, i64 0
  store i64 %v484, ptr %st199
  %v485.p = getelementptr i64, ptr %v0, i64 1
  %v485 = load i64, ptr %v485.p
  %st200 = getelementptr i64, ptr %v483, i64 1
  store i64 %v485, ptr %st200
  %v486.p = getelementptr i64, ptr %v0, i64 2
  %v486 = load i64, ptr %v486.p
  %st201 = getelementptr i64, ptr %v483, i64 2
  store i64 %v486, ptr %st201
  %v487 = add i64 0, 0
  %v488.c = icmp slt i64 %v482, %v487
  %v488 = zext i1 %v488.c to i64
  %c.b91 = icmp ne i64 %v488, 0
  br i1 %c.b91, label %b91.t203, label %b91.e204
b91.t203:
  br label %b96
b91.e204:
  br label %b95
b92:
  %v444 = phi ptr [ %v459, %b93 ], [ %v454, %b94 ]
  %v445 = phi ptr [ %v460, %b93 ], [ %v453, %b94 ]
  %st204 = getelementptr i64, ptr %v445, i64 0
  store i64 %v440, ptr %st204
  %v461.p = getelementptr i64, ptr %v434, i64 1
  %v461 = load i64, ptr %v461.p
  %v462 = add i64 0, 1
  %v463 = add i64 %v461, %v462
  %v464 = getelementptr i64, ptr %s12, i64 0
  %v465 = ptrtoint ptr %v444 to i64
  %st205 = getelementptr i64, ptr %v464, i64 0
  store i64 %v465, ptr %st205
  %st206 = getelementptr i64, ptr %v464, i64 1
  store i64 %v463, ptr %st206
  %st207 = getelementptr i64, ptr %v464, i64 2
  store i64 %v441, ptr %st207
  %v466.p = getelementptr i64, ptr %v464, i64 0
  %v466 = load i64, ptr %v466.p
  %st208 = getelementptr i64, ptr %v0, i64 0
  store i64 %v466, ptr %st208
  %v467.p = getelementptr i64, ptr %v464, i64 1
  %v467 = load i64, ptr %v467.p
  %st209 = getelementptr i64, ptr %v0, i64 1
  store i64 %v467, ptr %st209
  %v468.p = getelementptr i64, ptr %v464, i64 2
  %v468 = load i64, ptr %v468.p
  %st210 = getelementptr i64, ptr %v0, i64 2
  store i64 %v468, ptr %st210
  br label %b105
b93:
  %v455 = add i64 0, 1
  %v456 = mul i64 %v443, %v455
  %v457 = add i64 0, 1
  %v458 = add i64 0, 1
  %v459 = call ptr @"rt.slice_grow"(i64 %v442, i64 %v443, i64 %v457, i64 %v441, i64 %v458)
  %v460 = getelementptr i64, ptr %v459, i64 %v456
  br label %b92
b94:
  %v452 = add i64 0, 1
  %v453 = call ptr @"rt.region_alloc"(i64 %v441, i64 %v452)
  %v454 = inttoptr i64 %v442 to ptr
  br label %b92
b95:
  %v490 = add i64 0, 0
  %v491.c = icmp eq i64 %v482, %v490
  %v491 = zext i1 %v491.c to i64
  %c.b95 = icmp ne i64 %v491, 0
  br i1 %c.b95, label %b95.t212, label %b95.e213
b95.t212:
  br label %b97
b95.e213:
  br label %b98
b96:
  %v489 = phi i64 [ %v488, %b91.t203 ], [ %v492, %b98 ]
  %c.b96 = icmp ne i64 %v489, 0
  br i1 %c.b96, label %b96.t214, label %b96.e215
b96.t214:
  br label %b99
b96.e215:
  br label %b100
b97:
  %v493.p = getelementptr i64, ptr %v303, i64 0
  %v493 = load i64, ptr %v493.p
  %v494 = add i64 0, 2
  %v495 = srem i64 %v493, %v494
  %v496 = add i64 0, 0
  %v497.c = icmp eq i64 %v495, %v496
  %v497 = zext i1 %v497.c to i64
  br label %b98
b98:
  %v492 = phi i64 [ %v491, %b95.e213 ], [ %v497, %b97 ]
  br label %b96
b99:
  %v498.p = getelementptr i64, ptr %v303, i64 0
  %v498 = load i64, ptr %v498.p
  br label %b101
b100:
  %v499.p = getelementptr i64, ptr %v303, i64 0
  %v499 = load i64, ptr %v499.p
  %v500 = add i64 0, 1
  %v501 = add i64 %v499, %v500
  br label %b101
b101:
  %v502 = phi i64 [ %v498, %b99 ], [ %v501, %b100 ]
  %v503.p = getelementptr i64, ptr %v483, i64 2
  %v503 = load i64, ptr %v503.p
  %v504.p = getelementptr i64, ptr %v483, i64 0
  %v504 = load i64, ptr %v504.p
  %v505.p = getelementptr i64, ptr %v483, i64 1
  %v505 = load i64, ptr %v505.p
  %v508 = add i64 0, 8
  %v509 = mul i64 %v505, %v508
  %v510 = add i64 %v504, %v509
  %v575 = getelementptr i64, ptr @"rt.meta", i64 0
  %v576 = getelementptr i64, ptr %v575, i64 %v503
  %v511.p = getelementptr i64, ptr %v576, i64 1
  %v511 = load ptr, ptr %v511.p
  %v512 = ptrtoint ptr %v511 to i64
  %v513.c = icmp eq i64 %v512, %v510
  %v513 = zext i1 %v513.c to i64
  %c.b101 = icmp ne i64 %v513, 0
  br i1 %c.b101, label %b101.t216, label %b101.e217
b101.t216:
  br label %b104
b101.e217:
  br label %b103
b102:
  %v506 = phi ptr [ %v521, %b103 ], [ %v516, %b104 ]
  %v507 = phi ptr [ %v522, %b103 ], [ %v515, %b104 ]
  %st217 = getelementptr i64, ptr %v507, i64 0
  store i64 %v502, ptr %st217
  %v523.p = getelementptr i64, ptr %v483, i64 1
  %v523 = load i64, ptr %v523.p
  %v524 = add i64 0, 1
  %v525 = add i64 %v523, %v524
  %v526 = getelementptr i64, ptr %s2, i64 0
  %v527 = ptrtoint ptr %v506 to i64
  %st218 = getelementptr i64, ptr %v526, i64 0
  store i64 %v527, ptr %st218
  %st219 = getelementptr i64, ptr %v526, i64 1
  store i64 %v525, ptr %st219
  %st220 = getelementptr i64, ptr %v526, i64 2
  store i64 %v503, ptr %st220
  %v528.p = getelementptr i64, ptr %v526, i64 0
  %v528 = load i64, ptr %v528.p
  %st221 = getelementptr i64, ptr %v0, i64 0
  store i64 %v528, ptr %st221
  %v529.p = getelementptr i64, ptr %v526, i64 1
  %v529 = load i64, ptr %v529.p
  %st222 = getelementptr i64, ptr %v0, i64 1
  store i64 %v529, ptr %st222
  %v530.p = getelementptr i64, ptr %v526, i64 2
  %v530 = load i64, ptr %v530.p
  %st223 = getelementptr i64, ptr %v0, i64 2
  store i64 %v530, ptr %st223
  br label %b105
b103:
  %v517 = add i64 0, 1
  %v518 = mul i64 %v505, %v517
  %v519 = add i64 0, 1
  %v520 = add i64 0, 1
  %v521 = call ptr @"rt.slice_grow"(i64 %v504, i64 %v505, i64 %v519, i64 %v503, i64 %v520)
  %v522 = getelementptr i64, ptr %v521, i64 %v518
  br label %b102
b104:
  %v514 = add i64 0, 1
  %v515 = call ptr @"rt.region_alloc"(i64 %v503, i64 %v514)
  %v516 = inttoptr i64 %v504 to ptr
  br label %b102
b105:
  br label %b106
b106:
  br label %b107
b107:
  br label %b60
}

define internal i64 @"std/internal/floatfmt.bitLen"(i64 %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v27, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v0, ptr %st0
  %v3 = add i64 0, 0
  %v4 = getelementptr i64, ptr %s1, i64 0
  %st1 = getelementptr i64, ptr %v4, i64 0
  store i64 %v3, ptr %st1
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v28, i64 0
  %v5 = load i64, ptr %v5.p
  br label %b1
b1:
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v29, i64 0
  store i64 %v5, ptr %st2
  %v6.p = getelementptr i64, ptr %v2, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp sgt i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b1 = icmp ne i64 %v8, 0
  br i1 %c.b1, label %b1.t4, label %b1.e5
b1.t4:
  br label %b2
b1.e5:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v30 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v30, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 1
  %v11 = add i64 %v1, %v10
  %v12.p = getelementptr i64, ptr %v2, i64 0
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 1
  %v15 = add i64 0, 0
  %v16.c = icmp slt i64 %v13, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b2 = icmp ne i64 %v16, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b4
b2.e7:
  br label %b5
b3:
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v31, i64 0
  store i64 %v5, ptr %st7
  %v26.p = getelementptr i64, ptr %v4, i64 0
  %v26 = load i64, ptr %v26.p
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v32, i64 0
  store i64 %v1, ptr %st8
  ret i64 %v26
b4:
  %v17 = add i64 0, 22
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v18 = add i64 0, 63
  %v19.c = icmp sgt i64 %v13, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b5 = icmp ne i64 %v19, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  %v14 = phi i64 [ %v21, %b7 ], [ %v22, %b8 ]
  %st11 = getelementptr i64, ptr %v2, i64 0
  store i64 %v14, ptr %st11
  %v23 = add i64 0, 1
  %v24.p = getelementptr i64, ptr %v4, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 %v24, %v23
  %st12 = getelementptr i64, ptr %v4, i64 0
  store i64 %v25, ptr %st12
  br label %b1
b7:
  %v20 = add i64 0, 63
  %v21.n = and i64 %v20, 63
  %v21 = ashr i64 %v12, %v21.n
  br label %b6
b8:
  %v22.n = and i64 %v13, 63
  %v22 = ashr i64 %v12, %v22.n
  br label %b6
}

define internal void @"std/internal/floatfmt.bnSetInt"(ptr %v0, i64 %v1) #0 {
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
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v103, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 0
  %v10 = call ptr @"rt.region_alloc"(i64 %v8, i64 %v9)
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s0, i64 0
  %v13 = ptrtoint ptr %v10 to i64
  %st0 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st0
  %st1 = getelementptr i64, ptr %v12, i64 1
  store i64 %v11, ptr %st1
  %st2 = getelementptr i64, ptr %v12, i64 2
  store i64 %v8, ptr %st2
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15.p = getelementptr i64, ptr %v12, i64 0
  %v15 = load i64, ptr %v15.p
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st3
  %v16.p = getelementptr i64, ptr %v12, i64 1
  %v16 = load i64, ptr %v16.p
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st4
  %v17.p = getelementptr i64, ptr %v12, i64 2
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st5
  %v104 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v14, i64 %v104, i64 %v8)
  %v18.p = getelementptr i64, ptr %v14, i64 0
  %v18 = load i64, ptr %v18.p
  %st6 = getelementptr i64, ptr %v0, i64 0
  store i64 %v18, ptr %st6
  %v19.p = getelementptr i64, ptr %v14, i64 1
  %v19 = load i64, ptr %v19.p
  %st7 = getelementptr i64, ptr %v0, i64 1
  store i64 %v19, ptr %st7
  %v20.p = getelementptr i64, ptr %v14, i64 2
  %v20 = load i64, ptr %v20.p
  %st8 = getelementptr i64, ptr %v0, i64 2
  store i64 %v20, ptr %st8
  %v21 = getelementptr i64, ptr %s2, i64 0
  %st9 = getelementptr i64, ptr %v21, i64 0
  store i64 %v1, ptr %st9
  %v22 = getelementptr i64, ptr %s0, i64 0
  %v23.p = getelementptr i64, ptr %v0, i64 0
  %v23 = load i64, ptr %v23.p
  %st10 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st10
  %v24.p = getelementptr i64, ptr %v0, i64 1
  %v24 = load i64, ptr %v24.p
  %st11 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st11
  %v25.p = getelementptr i64, ptr %v0, i64 2
  %v25 = load i64, ptr %v25.p
  %st12 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st12
  %v26.p = getelementptr i64, ptr %v21, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 1073741824
  %v28 = srem i64 %v26, %v27
  %v29.p = getelementptr i64, ptr %v22, i64 2
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v22, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v22, i64 1
  %v31 = load i64, ptr %v31.p
  %v34 = add i64 0, 8
  %v35 = mul i64 %v31, %v34
  %v36 = add i64 %v30, %v35
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %v106 = getelementptr i64, ptr %v105, i64 %v29
  %v37.p = getelementptr i64, ptr %v106, i64 1
  %v37 = load ptr, ptr %v37.p
  %v38 = ptrtoint ptr %v37 to i64
  %v39.c = icmp eq i64 %v38, %v36
  %v39 = zext i1 %v39.c to i64
  %c.b0 = icmp ne i64 %v39, 0
  br i1 %c.b0, label %b0.t14, label %b0.e15
b0.t14:
  br label %b3
b0.e15:
  br label %b2
b1:
  %v32 = phi ptr [ %v47, %b2 ], [ %v42, %b3 ]
  %v33 = phi ptr [ %v48, %b2 ], [ %v41, %b3 ]
  %st15 = getelementptr i64, ptr %v33, i64 0
  store i64 %v28, ptr %st15
  %v49.p = getelementptr i64, ptr %v22, i64 1
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 1
  %v51 = add i64 %v49, %v50
  %v52 = getelementptr i64, ptr %s3, i64 0
  %v53 = ptrtoint ptr %v32 to i64
  %st16 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st16
  %st17 = getelementptr i64, ptr %v52, i64 1
  store i64 %v51, ptr %st17
  %st18 = getelementptr i64, ptr %v52, i64 2
  store i64 %v29, ptr %st18
  %v54.p = getelementptr i64, ptr %v52, i64 0
  %v54 = load i64, ptr %v54.p
  %st19 = getelementptr i64, ptr %v0, i64 0
  store i64 %v54, ptr %st19
  %v55.p = getelementptr i64, ptr %v52, i64 1
  %v55 = load i64, ptr %v55.p
  %st20 = getelementptr i64, ptr %v0, i64 1
  store i64 %v55, ptr %st20
  %v56.p = getelementptr i64, ptr %v52, i64 2
  %v56 = load i64, ptr %v56.p
  %st21 = getelementptr i64, ptr %v0, i64 2
  store i64 %v56, ptr %st21
  %v57.p = getelementptr i64, ptr %v21, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 0, 1073741824
  %v59 = sdiv i64 %v57, %v58
  %st22 = getelementptr i64, ptr %v21, i64 0
  store i64 %v59, ptr %st22
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v107, i64 0
  %v60 = load i64, ptr %v60.p
  br label %b4
b2:
  %v43 = add i64 0, 1
  %v44 = mul i64 %v31, %v43
  %v45 = add i64 0, 1
  %v46 = add i64 0, 1
  %v47 = call ptr @"rt.slice_grow"(i64 %v30, i64 %v31, i64 %v45, i64 %v29, i64 %v46)
  %v48 = getelementptr i64, ptr %v47, i64 %v44
  br label %b1
b3:
  %v40 = add i64 0, 1
  %v41 = call ptr @"rt.region_alloc"(i64 %v29, i64 %v40)
  %v42 = inttoptr i64 %v30 to ptr
  br label %b1
b4:
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v108, i64 0
  store i64 %v60, ptr %st23
  %v61.p = getelementptr i64, ptr %v21, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 0
  %v63.c = icmp sgt i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b4 = icmp ne i64 %v63, 0
  br i1 %c.b4, label %b4.t25, label %b4.e26
b4.t25:
  br label %b5
b4.e26:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %v64.p = getelementptr i64, ptr %v109, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = getelementptr i64, ptr %s3, i64 0
  %v66.p = getelementptr i64, ptr %v0, i64 0
  %v66 = load i64, ptr %v66.p
  %st26 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st26
  %v67.p = getelementptr i64, ptr %v0, i64 1
  %v67 = load i64, ptr %v67.p
  %st27 = getelementptr i64, ptr %v65, i64 1
  store i64 %v67, ptr %st27
  %v68.p = getelementptr i64, ptr %v0, i64 2
  %v68 = load i64, ptr %v68.p
  %st28 = getelementptr i64, ptr %v65, i64 2
  store i64 %v68, ptr %st28
  %v69.p = getelementptr i64, ptr %v21, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 1073741824
  %v71 = srem i64 %v69, %v70
  %v72.p = getelementptr i64, ptr %v65, i64 2
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v65, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v65, i64 1
  %v74 = load i64, ptr %v74.p
  %v77 = add i64 0, 8
  %v78 = mul i64 %v74, %v77
  %v79 = add i64 %v73, %v78
  %v110 = getelementptr i64, ptr @"rt.meta", i64 0
  %v111 = getelementptr i64, ptr %v110, i64 %v72
  %v80.p = getelementptr i64, ptr %v111, i64 1
  %v80 = load ptr, ptr %v80.p
  %v81 = ptrtoint ptr %v80 to i64
  %v82.c = icmp eq i64 %v81, %v79
  %v82 = zext i1 %v82.c to i64
  %c.b5 = icmp ne i64 %v82, 0
  br i1 %c.b5, label %b5.t30, label %b5.e31
b5.t30:
  br label %b9
b5.e31:
  br label %b8
b6:
  %v112 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v112, i64 0
  store i64 %v60, ptr %st31
  %v113 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v113, i64 0
  store i64 %v2, ptr %st32
  ret void
b7:
  %v75 = phi ptr [ %v90, %b8 ], [ %v85, %b9 ]
  %v76 = phi ptr [ %v91, %b8 ], [ %v84, %b9 ]
  %st33 = getelementptr i64, ptr %v76, i64 0
  store i64 %v71, ptr %st33
  %v92.p = getelementptr i64, ptr %v65, i64 1
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 1
  %v94 = add i64 %v92, %v93
  %v95 = getelementptr i64, ptr %s0, i64 0
  %v96 = ptrtoint ptr %v75 to i64
  %st34 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st34
  %st35 = getelementptr i64, ptr %v95, i64 1
  store i64 %v94, ptr %st35
  %st36 = getelementptr i64, ptr %v95, i64 2
  store i64 %v72, ptr %st36
  %v97.p = getelementptr i64, ptr %v95, i64 0
  %v97 = load i64, ptr %v97.p
  %st37 = getelementptr i64, ptr %v0, i64 0
  store i64 %v97, ptr %st37
  %v98.p = getelementptr i64, ptr %v95, i64 1
  %v98 = load i64, ptr %v98.p
  %st38 = getelementptr i64, ptr %v0, i64 1
  store i64 %v98, ptr %st38
  %v99.p = getelementptr i64, ptr %v95, i64 2
  %v99 = load i64, ptr %v99.p
  %st39 = getelementptr i64, ptr %v0, i64 2
  store i64 %v99, ptr %st39
  %v100.p = getelementptr i64, ptr %v21, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 1073741824
  %v102 = sdiv i64 %v100, %v101
  %st40 = getelementptr i64, ptr %v21, i64 0
  store i64 %v102, ptr %st40
  br label %b4
b8:
  %v86 = add i64 0, 1
  %v87 = mul i64 %v74, %v86
  %v88 = add i64 0, 1
  %v89 = add i64 0, 1
  %v90 = call ptr @"rt.slice_grow"(i64 %v73, i64 %v74, i64 %v88, i64 %v72, i64 %v89)
  %v91 = getelementptr i64, ptr %v90, i64 %v87
  br label %b7
b9:
  %v83 = add i64 0, 1
  %v84 = call ptr @"rt.region_alloc"(i64 %v72, i64 %v83)
  %v85 = inttoptr i64 %v73 to ptr
  br label %b7
}

define internal void @"std/internal/floatfmt.bnSet"(ptr %v0, ptr %v1) #0 {
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
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
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
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %v128 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v128, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 0
  %v10 = call ptr @"rt.region_alloc"(i64 %v8, i64 %v9)
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s0, i64 0
  %v13 = ptrtoint ptr %v10 to i64
  %st0 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st0
  %st1 = getelementptr i64, ptr %v12, i64 1
  store i64 %v11, ptr %st1
  %st2 = getelementptr i64, ptr %v12, i64 2
  store i64 %v8, ptr %st2
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15.p = getelementptr i64, ptr %v12, i64 0
  %v15 = load i64, ptr %v15.p
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st3
  %v16.p = getelementptr i64, ptr %v12, i64 1
  %v16 = load i64, ptr %v16.p
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st4
  %v17.p = getelementptr i64, ptr %v12, i64 2
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st5
  %v129 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v14, i64 %v129, i64 %v8)
  %v18.p = getelementptr i64, ptr %v14, i64 0
  %v18 = load i64, ptr %v18.p
  %st6 = getelementptr i64, ptr %v0, i64 0
  store i64 %v18, ptr %st6
  %v19.p = getelementptr i64, ptr %v14, i64 1
  %v19 = load i64, ptr %v19.p
  %st7 = getelementptr i64, ptr %v0, i64 1
  store i64 %v19, ptr %st7
  %v20.p = getelementptr i64, ptr %v14, i64 2
  %v20 = load i64, ptr %v20.p
  %st8 = getelementptr i64, ptr %v0, i64 2
  store i64 %v20, ptr %st8
  %v21 = add i64 0, 0
  %v22 = add i64 0, 0
  %v23.p = getelementptr i64, ptr %v1, i64 1
  %v23 = load i64, ptr %v23.p
  %v24 = sub i64 %v23, %v22
  %v25.c = icmp sle i64 %v24, %v21
  %v25 = zext i1 %v25.c to i64
  %c.b0 = icmp ne i64 %v25, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v130 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v130, i64 0
  store i64 %v2, ptr %st11
  ret void
b2:
  %v26.c = icmp sge i64 %v22, %v21
  %v26 = zext i1 %v26.c to i64
  %v27.p = getelementptr i64, ptr %v1, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp sle i64 %v23, %v27
  %v28 = zext i1 %v28.c to i64
  %v29 = and i64 %v26, %v28
  %v30.c = icmp ne i64 %v29, %v21
  %v30 = zext i1 %v30.c to i64
  %c.b2 = icmp ne i64 %v30, 0
  br i1 %c.b2, label %b2.t13, label %b2.e14
b2.t13:
  br label %b4
b2.e14:
  br label %b3
b3:
  %v131 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v131, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 0
  %v74.p = getelementptr i64, ptr %v1, i64 1
  %v74 = load i64, ptr %v74.p
  %v75 = getelementptr i64, ptr %s3, i64 0
  %v132 = getelementptr i64, ptr @"rt.meta", i64 0
  %v76.p = getelementptr i64, ptr %v132, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = getelementptr i64, ptr %s4, i64 0
  %st14 = getelementptr i64, ptr %v77, i64 0
  store i64 %v73, ptr %st14
  %v133 = getelementptr i64, ptr @"rt.meta", i64 0
  %v78.p = getelementptr i64, ptr %v133, i64 0
  %v78 = load i64, ptr %v78.p
  br label %b10
b4:
  %v31 = getelementptr i64, ptr %s0, i64 0
  %v32.p = getelementptr i64, ptr %v0, i64 0
  %v32 = load i64, ptr %v32.p
  %st15 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st15
  %v33.p = getelementptr i64, ptr %v0, i64 1
  %v33 = load i64, ptr %v33.p
  %st16 = getelementptr i64, ptr %v31, i64 1
  store i64 %v33, ptr %st16
  %v34.p = getelementptr i64, ptr %v0, i64 2
  %v34 = load i64, ptr %v34.p
  %st17 = getelementptr i64, ptr %v31, i64 2
  store i64 %v34, ptr %st17
  %v35.p = getelementptr i64, ptr %v31, i64 2
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v31, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v31, i64 1
  %v37 = load i64, ptr %v37.p
  %v40 = add i64 0, 8
  %v41 = mul i64 %v37, %v40
  %v42 = add i64 %v36, %v41
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v135 = getelementptr i64, ptr %v134, i64 %v35
  %v43.p = getelementptr i64, ptr %v135, i64 1
  %v43 = load ptr, ptr %v43.p
  %v44 = ptrtoint ptr %v43 to i64
  %v45.c = icmp eq i64 %v44, %v42
  %v45 = zext i1 %v45.c to i64
  %c.b4 = icmp ne i64 %v45, 0
  br i1 %c.b4, label %b4.t19, label %b4.e20
b4.t19:
  br label %b7
b4.e20:
  br label %b6
b5:
  %v38 = phi ptr [ %v55, %b6 ], [ %v49, %b7 ]
  %v39 = phi ptr [ %v57, %b6 ], [ %v48, %b7 ]
  %v58.p = getelementptr i64, ptr %v1, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = inttoptr i64 %v58 to ptr
  %v60 = add i64 0, 1
  %v61 = mul i64 %v22, %v60
  %v62 = getelementptr i64, ptr %v59, i64 %v61
  %v63 = add i64 0, 1
  %v64 = mul i64 %v24, %v63
  call void @"rt.copy"(ptr %v39, ptr %v62, i64 %v64)
  %v65.p = getelementptr i64, ptr %v31, i64 1
  %v65 = load i64, ptr %v65.p
  %v66 = add i64 %v65, %v24
  %v67 = getelementptr i64, ptr %s2, i64 0
  %v68 = ptrtoint ptr %v38 to i64
  %st20 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st20
  %st21 = getelementptr i64, ptr %v67, i64 1
  store i64 %v66, ptr %st21
  %st22 = getelementptr i64, ptr %v67, i64 2
  store i64 %v35, ptr %st22
  %v69.p = getelementptr i64, ptr %v67, i64 0
  %v69 = load i64, ptr %v69.p
  %st23 = getelementptr i64, ptr %v0, i64 0
  store i64 %v69, ptr %st23
  %v70.p = getelementptr i64, ptr %v67, i64 1
  %v70 = load i64, ptr %v70.p
  %st24 = getelementptr i64, ptr %v0, i64 1
  store i64 %v70, ptr %st24
  %v71.p = getelementptr i64, ptr %v67, i64 2
  %v71 = load i64, ptr %v71.p
  %st25 = getelementptr i64, ptr %v0, i64 2
  store i64 %v71, ptr %st25
  br label %b1
b6:
  %v50 = add i64 0, 1
  %v51 = mul i64 %v37, %v50
  %v52 = add i64 0, 1
  %v53 = mul i64 %v24, %v52
  %v54 = add i64 %v51, %v53
  %v55 = call ptr @"rt.region_alloc"(i64 %v35, i64 %v54)
  %v56 = inttoptr i64 %v36 to ptr
  call void @"rt.copy"(ptr %v55, ptr %v56, i64 %v51)
  %v57 = getelementptr i64, ptr %v55, i64 %v51
  br label %b5
b7:
  %v46 = add i64 0, 1
  %v47 = mul i64 %v24, %v46
  %v48 = call ptr @"rt.region_alloc"(i64 %v35, i64 %v47)
  %v49 = inttoptr i64 %v36 to ptr
  br label %b5
b8:
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v136, i64 0
  store i64 %v72, ptr %st26
  br label %b1
b9:
  br label %b8
b10:
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v137, i64 0
  store i64 %v78, ptr %st27
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %v80.c = icmp slt i64 %v79, %v74
  %v80 = zext i1 %v80.c to i64
  %c.b10 = icmp ne i64 %v80, 0
  br i1 %c.b10, label %b10.t29, label %b10.e30
b10.t29:
  br label %b11
b10.e30:
  br label %b12
b11:
  call void @"rt.region_enter"()
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %v81.p = getelementptr i64, ptr %v138, i64 0
  %v81 = load i64, ptr %v81.p
  %v82.p = getelementptr i64, ptr %v77, i64 0
  %v82 = load i64, ptr %v82.p
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %v83.p = getelementptr i64, ptr %v139, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = getelementptr i64, ptr %s5, i64 0
  %v85.p = getelementptr i64, ptr %v0, i64 0
  %v85 = load i64, ptr %v85.p
  %st30 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st30
  %v86.p = getelementptr i64, ptr %v0, i64 1
  %v86 = load i64, ptr %v86.p
  %st31 = getelementptr i64, ptr %v84, i64 1
  store i64 %v86, ptr %st31
  %v87.p = getelementptr i64, ptr %v0, i64 2
  %v87 = load i64, ptr %v87.p
  %st32 = getelementptr i64, ptr %v84, i64 2
  store i64 %v87, ptr %st32
  %v88.p = getelementptr i64, ptr %v1, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.c = icmp uge i64 %v82, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b11 = icmp ne i64 %v89, 0
  br i1 %c.b11, label %b11.t34, label %b11.e35
b11.t34:
  br label %b14
b11.e35:
  br label %b15
b12:
  %v140 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v140, i64 0
  store i64 %v78, ptr %st35
  br label %b9
b13:
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %st36 = getelementptr i64, ptr %v141, i64 0
  store i64 %v83, ptr %st36
  %v125 = add i64 0, 1
  %v126.p = getelementptr i64, ptr %v77, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 %v126, %v125
  %st37 = getelementptr i64, ptr %v77, i64 0
  store i64 %v127, ptr %st37
  br label %b10
b14:
  %v90 = add i64 0, 23
  call void @"rt.panic"(i64 %v90)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v91.p = getelementptr i64, ptr %v1, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = inttoptr i64 %v91 to ptr
  %v93 = add i64 0, 1
  %v94 = mul i64 %v82, %v93
  %v95 = getelementptr i64, ptr %v92, i64 %v94
  %v96.p = getelementptr i64, ptr %v95, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v84, i64 2
  %v97 = load i64, ptr %v97.p
  %v98.p = getelementptr i64, ptr %v84, i64 0
  %v98 = load i64, ptr %v98.p
  %v99.p = getelementptr i64, ptr %v84, i64 1
  %v99 = load i64, ptr %v99.p
  %v102 = add i64 0, 8
  %v103 = mul i64 %v99, %v102
  %v104 = add i64 %v98, %v103
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %v143 = getelementptr i64, ptr %v142, i64 %v97
  %v105.p = getelementptr i64, ptr %v143, i64 1
  %v105 = load ptr, ptr %v105.p
  %v106 = ptrtoint ptr %v105 to i64
  %v107.c = icmp eq i64 %v106, %v104
  %v107 = zext i1 %v107.c to i64
  %c.b15 = icmp ne i64 %v107, 0
  br i1 %c.b15, label %b15.t39, label %b15.e40
b15.t39:
  br label %b18
b15.e40:
  br label %b17
b16:
  %v100 = phi ptr [ %v115, %b17 ], [ %v110, %b18 ]
  %v101 = phi ptr [ %v116, %b17 ], [ %v109, %b18 ]
  %st40 = getelementptr i64, ptr %v101, i64 0
  store i64 %v96, ptr %st40
  %v117.p = getelementptr i64, ptr %v84, i64 1
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 0, 1
  %v119 = add i64 %v117, %v118
  %v120 = getelementptr i64, ptr %s6, i64 0
  %v121 = ptrtoint ptr %v100 to i64
  %st41 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st41
  %st42 = getelementptr i64, ptr %v120, i64 1
  store i64 %v119, ptr %st42
  %st43 = getelementptr i64, ptr %v120, i64 2
  store i64 %v97, ptr %st43
  %v122.p = getelementptr i64, ptr %v120, i64 0
  %v122 = load i64, ptr %v122.p
  %st44 = getelementptr i64, ptr %v0, i64 0
  store i64 %v122, ptr %st44
  %v123.p = getelementptr i64, ptr %v120, i64 1
  %v123 = load i64, ptr %v123.p
  %st45 = getelementptr i64, ptr %v0, i64 1
  store i64 %v123, ptr %st45
  %v124.p = getelementptr i64, ptr %v120, i64 2
  %v124 = load i64, ptr %v124.p
  %st46 = getelementptr i64, ptr %v0, i64 2
  store i64 %v124, ptr %st46
  br label %b13
b17:
  %v111 = add i64 0, 1
  %v112 = mul i64 %v99, %v111
  %v113 = add i64 0, 1
  %v114 = add i64 0, 1
  %v115 = call ptr @"rt.slice_grow"(i64 %v98, i64 %v99, i64 %v113, i64 %v97, i64 %v114)
  %v116 = getelementptr i64, ptr %v115, i64 %v112
  br label %b16
b18:
  %v108 = add i64 0, 1
  %v109 = call ptr @"rt.region_alloc"(i64 %v97, i64 %v108)
  %v110 = inttoptr i64 %v98 to ptr
  br label %b16
}

define internal void @"std/internal/floatfmt.bnMulAdd"(ptr %v0, i64 %v1, i64 %v2) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
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
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v93, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2572
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %v7.c = icmp eq i64 %v5, %v6
  %v7 = zext i1 %v7.c to i64
  %v8 = mul i64 %v7, %v3
  %v9 = add i64 %v5, %v8
  %v10 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v10, i64 0
  store i64 %v2, ptr %st0
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v94, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.p = getelementptr i64, ptr %v0, i64 1
  %v13 = load i64, ptr %v13.p
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v95, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s2, i64 0
  %st1 = getelementptr i64, ptr %v16, i64 0
  store i64 %v12, ptr %st1
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v96, i64 0
  %v17 = load i64, ptr %v17.p
  br label %b3
b1:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v97, i64 0
  store i64 %v11, ptr %st2
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %v50.p = getelementptr i64, ptr %v98, i64 0
  %v50 = load i64, ptr %v50.p
  br label %b11
b2:
  br label %b1
b3:
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v99, i64 0
  store i64 %v17, ptr %st3
  %v18.p = getelementptr i64, ptr %v16, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp slt i64 %v18, %v13
  %v19 = zext i1 %v19.c to i64
  %c.b3 = icmp ne i64 %v19, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b4
b3.e6:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v100, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 0
  %v21 = load i64, ptr %v21.p
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v101, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v0, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.c = icmp uge i64 %v21, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b4 = icmp ne i64 %v24, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b7
b4.e8:
  br label %b8
b5:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v102, i64 0
  store i64 %v17, ptr %st8
  br label %b2
b6:
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v103, i64 0
  store i64 %v22, ptr %st9
  %v47 = add i64 0, 1
  %v48.p = getelementptr i64, ptr %v16, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 %v48, %v47
  %st10 = getelementptr i64, ptr %v16, i64 0
  store i64 %v49, ptr %st10
  br label %b3
b7:
  %v25 = add i64 0, 24
  call void @"rt.panic"(i64 %v25)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v26.p = getelementptr i64, ptr %v0, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = inttoptr i64 %v26 to ptr
  %v28 = add i64 0, 1
  %v29 = mul i64 %v21, %v28
  %v30 = getelementptr i64, ptr %v27, i64 %v29
  %v31.p = getelementptr i64, ptr %v30, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = mul i64 %v31, %v1
  %v33.p = getelementptr i64, ptr %v10, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 %v32, %v33
  %v35 = add i64 0, 1073741824
  %v36 = srem i64 %v34, %v35
  %v37.p = getelementptr i64, ptr %v0, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v21, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b8 = icmp ne i64 %v38, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b9
b8.e13:
  br label %b10
b9:
  %v39 = add i64 0, 25
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v40.p = getelementptr i64, ptr %v0, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v21, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %st13 = getelementptr i64, ptr %v44, i64 0
  store i64 %v36, ptr %st13
  %v45 = add i64 0, 1073741824
  %v46 = sdiv i64 %v34, %v45
  %st14 = getelementptr i64, ptr %v10, i64 0
  store i64 %v46, ptr %st14
  br label %b6
b11:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v104, i64 0
  store i64 %v50, ptr %st15
  %v51.p = getelementptr i64, ptr %v10, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp sgt i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b11 = icmp ne i64 %v53, 0
  br i1 %c.b11, label %b11.t17, label %b11.e18
b11.t17:
  br label %b12
b11.e18:
  br label %b13
b12:
  call void @"rt.region_enter"()
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %v54.p = getelementptr i64, ptr %v105, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = getelementptr i64, ptr %s3, i64 0
  %v56.p = getelementptr i64, ptr %v0, i64 0
  %v56 = load i64, ptr %v56.p
  %st18 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st18
  %v57.p = getelementptr i64, ptr %v0, i64 1
  %v57 = load i64, ptr %v57.p
  %st19 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st19
  %v58.p = getelementptr i64, ptr %v0, i64 2
  %v58 = load i64, ptr %v58.p
  %st20 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st20
  %v59.p = getelementptr i64, ptr %v10, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 1073741824
  %v61 = srem i64 %v59, %v60
  %v62.p = getelementptr i64, ptr %v55, i64 2
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v55, i64 0
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v55, i64 1
  %v64 = load i64, ptr %v64.p
  %v67 = add i64 0, 8
  %v68 = mul i64 %v64, %v67
  %v69 = add i64 %v63, %v68
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %v107 = getelementptr i64, ptr %v106, i64 %v62
  %v70.p = getelementptr i64, ptr %v107, i64 1
  %v70 = load ptr, ptr %v70.p
  %v71 = ptrtoint ptr %v70 to i64
  %v72.c = icmp eq i64 %v71, %v69
  %v72 = zext i1 %v72.c to i64
  %c.b12 = icmp ne i64 %v72, 0
  br i1 %c.b12, label %b12.t22, label %b12.e23
b12.t22:
  br label %b16
b12.e23:
  br label %b15
b13:
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v108, i64 0
  store i64 %v50, ptr %st23
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v109, i64 0
  store i64 %v3, ptr %st24
  ret void
b14:
  %v65 = phi ptr [ %v80, %b15 ], [ %v75, %b16 ]
  %v66 = phi ptr [ %v81, %b15 ], [ %v74, %b16 ]
  %st25 = getelementptr i64, ptr %v66, i64 0
  store i64 %v61, ptr %st25
  %v82.p = getelementptr i64, ptr %v55, i64 1
  %v82 = load i64, ptr %v82.p
  %v83 = add i64 0, 1
  %v84 = add i64 %v82, %v83
  %v85 = getelementptr i64, ptr %s4, i64 0
  %v86 = ptrtoint ptr %v65 to i64
  %st26 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st26
  %st27 = getelementptr i64, ptr %v85, i64 1
  store i64 %v84, ptr %st27
  %st28 = getelementptr i64, ptr %v85, i64 2
  store i64 %v62, ptr %st28
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v87, ptr %st29
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v88, ptr %st30
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v89, ptr %st31
  %v90.p = getelementptr i64, ptr %v10, i64 0
  %v90 = load i64, ptr %v90.p
  %v91 = add i64 0, 1073741824
  %v92 = sdiv i64 %v90, %v91
  %st32 = getelementptr i64, ptr %v10, i64 0
  store i64 %v92, ptr %st32
  br label %b11
b15:
  %v76 = add i64 0, 1
  %v77 = mul i64 %v64, %v76
  %v78 = add i64 0, 1
  %v79 = add i64 0, 1
  %v80 = call ptr @"rt.slice_grow"(i64 %v63, i64 %v64, i64 %v78, i64 %v62, i64 %v79)
  %v81 = getelementptr i64, ptr %v80, i64 %v77
  br label %b14
b16:
  %v73 = add i64 0, 1
  %v74 = call ptr @"rt.region_alloc"(i64 %v62, i64 %v73)
  %v75 = inttoptr i64 %v63 to ptr
  br label %b14
}

define internal void @"std/internal/floatfmt.bnAdd"(ptr %v0, ptr %v1) #0 {
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
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v137, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v138, i64 0
  %v9 = load i64, ptr %v9.p
  br label %b1
b1:
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v139, i64 0
  store i64 %v9, ptr %st0
  %v10.p = getelementptr i64, ptr %v0, i64 1
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v1, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp slt i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t2, label %b1.e3
b1.t2:
  br label %b2
b1.e3:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v140 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v140, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = getelementptr i64, ptr %s0, i64 0
  %v15.p = getelementptr i64, ptr %v0, i64 0
  %v15 = load i64, ptr %v15.p
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st3
  %v16.p = getelementptr i64, ptr %v0, i64 1
  %v16 = load i64, ptr %v16.p
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st4
  %v17.p = getelementptr i64, ptr %v0, i64 2
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st5
  %v18 = add i64 0, 0
  %v19.p = getelementptr i64, ptr %v14, i64 2
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v14, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v14, i64 1
  %v21 = load i64, ptr %v21.p
  %v24 = add i64 0, 8
  %v25 = mul i64 %v21, %v24
  %v26 = add i64 %v20, %v25
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v142 = getelementptr i64, ptr %v141, i64 %v19
  %v27.p = getelementptr i64, ptr %v142, i64 1
  %v27 = load ptr, ptr %v27.p
  %v28 = ptrtoint ptr %v27 to i64
  %v29.c = icmp eq i64 %v28, %v26
  %v29 = zext i1 %v29.c to i64
  %c.b2 = icmp ne i64 %v29, 0
  br i1 %c.b2, label %b2.t7, label %b2.e8
b2.t7:
  br label %b6
b2.e8:
  br label %b5
b3:
  %v143 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v143, i64 0
  store i64 %v9, ptr %st8
  %v47 = add i64 0, 0
  %v48 = getelementptr i64, ptr %s2, i64 0
  %st9 = getelementptr i64, ptr %v48, i64 0
  store i64 %v47, ptr %st9
  %v144 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v144, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.p = getelementptr i64, ptr %v0, i64 1
  %v51 = load i64, ptr %v51.p
  %v52 = getelementptr i64, ptr %s3, i64 0
  %v145 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v145, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = getelementptr i64, ptr %s4, i64 0
  %st10 = getelementptr i64, ptr %v54, i64 0
  store i64 %v50, ptr %st10
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %v55.p = getelementptr i64, ptr %v146, i64 0
  %v55 = load i64, ptr %v55.p
  br label %b9
b4:
  %v22 = phi ptr [ %v37, %b5 ], [ %v32, %b6 ]
  %v23 = phi ptr [ %v38, %b5 ], [ %v31, %b6 ]
  %st11 = getelementptr i64, ptr %v23, i64 0
  store i64 %v18, ptr %st11
  %v39.p = getelementptr i64, ptr %v14, i64 1
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 1
  %v41 = add i64 %v39, %v40
  %v42 = getelementptr i64, ptr %s1, i64 0
  %v43 = ptrtoint ptr %v22 to i64
  %st12 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st12
  %st13 = getelementptr i64, ptr %v42, i64 1
  store i64 %v41, ptr %st13
  %st14 = getelementptr i64, ptr %v42, i64 2
  store i64 %v19, ptr %st14
  %v44.p = getelementptr i64, ptr %v42, i64 0
  %v44 = load i64, ptr %v44.p
  %st15 = getelementptr i64, ptr %v0, i64 0
  store i64 %v44, ptr %st15
  %v45.p = getelementptr i64, ptr %v42, i64 1
  %v45 = load i64, ptr %v45.p
  %st16 = getelementptr i64, ptr %v0, i64 1
  store i64 %v45, ptr %st16
  %v46.p = getelementptr i64, ptr %v42, i64 2
  %v46 = load i64, ptr %v46.p
  %st17 = getelementptr i64, ptr %v0, i64 2
  store i64 %v46, ptr %st17
  br label %b1
b5:
  %v33 = add i64 0, 1
  %v34 = mul i64 %v21, %v33
  %v35 = add i64 0, 1
  %v36 = add i64 0, 1
  %v37 = call ptr @"rt.slice_grow"(i64 %v20, i64 %v21, i64 %v35, i64 %v19, i64 %v36)
  %v38 = getelementptr i64, ptr %v37, i64 %v34
  br label %b4
b6:
  %v30 = add i64 0, 1
  %v31 = call ptr @"rt.region_alloc"(i64 %v19, i64 %v30)
  %v32 = inttoptr i64 %v20 to ptr
  br label %b4
b7:
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v147, i64 0
  store i64 %v49, ptr %st18
  %v101.p = getelementptr i64, ptr %v48, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 0
  %v103.c = icmp sgt i64 %v101, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b7 = icmp ne i64 %v103, 0
  br i1 %c.b7, label %b7.t20, label %b7.e21
b7.t20:
  br label %b22
b7.e21:
  br label %b23
b8:
  br label %b7
b9:
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v148, i64 0
  store i64 %v55, ptr %st21
  %v56.p = getelementptr i64, ptr %v54, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.c = icmp slt i64 %v56, %v51
  %v57 = zext i1 %v57.c to i64
  %c.b9 = icmp ne i64 %v57, 0
  br i1 %c.b9, label %b9.t23, label %b9.e24
b9.t23:
  br label %b10
b9.e24:
  br label %b11
b10:
  call void @"rt.region_enter"()
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v58.p = getelementptr i64, ptr %v149, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v54, i64 0
  %v59 = load i64, ptr %v59.p
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v150, i64 0
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v0, i64 1
  %v61 = load i64, ptr %v61.p
  %v62.c = icmp uge i64 %v59, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b10 = icmp ne i64 %v62, 0
  br i1 %c.b10, label %b10.t25, label %b10.e26
b10.t25:
  br label %b13
b10.e26:
  br label %b14
b11:
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v151, i64 0
  store i64 %v55, ptr %st26
  br label %b8
b12:
  %v152 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v152, i64 0
  store i64 %v60, ptr %st27
  %v98 = add i64 0, 1
  %v99.p = getelementptr i64, ptr %v54, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 %v99, %v98
  %st28 = getelementptr i64, ptr %v54, i64 0
  store i64 %v100, ptr %st28
  br label %b9
b13:
  %v63 = add i64 0, 26
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v64.p = getelementptr i64, ptr %v0, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = inttoptr i64 %v64 to ptr
  %v66 = add i64 0, 1
  %v67 = mul i64 %v59, %v66
  %v68 = getelementptr i64, ptr %v65, i64 %v67
  %v69.p = getelementptr i64, ptr %v68, i64 0
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v1, i64 1
  %v70 = load i64, ptr %v70.p
  %v71.c = icmp slt i64 %v59, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b14 = icmp ne i64 %v71, 0
  br i1 %c.b14, label %b14.t30, label %b14.e31
b14.t30:
  br label %b15
b14.e31:
  br label %b16
b15:
  %v72.p = getelementptr i64, ptr %v1, i64 1
  %v72 = load i64, ptr %v72.p
  %v73.c = icmp uge i64 %v59, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b15 = icmp ne i64 %v73, 0
  br i1 %c.b15, label %b15.t32, label %b15.e33
b15.t32:
  br label %b17
b15.e33:
  br label %b18
b16:
  %v81 = add i64 0, 0
  br label %b19
b17:
  %v74 = add i64 0, 27
  call void @"rt.panic"(i64 %v74)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v75.p = getelementptr i64, ptr %v1, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = inttoptr i64 %v75 to ptr
  %v77 = add i64 0, 1
  %v78 = mul i64 %v59, %v77
  %v79 = getelementptr i64, ptr %v76, i64 %v78
  %v80.p = getelementptr i64, ptr %v79, i64 0
  %v80 = load i64, ptr %v80.p
  br label %b19
b19:
  %v82 = phi i64 [ %v81, %b16 ], [ %v80, %b18 ]
  %v83 = add i64 %v69, %v82
  %v84.p = getelementptr i64, ptr %v48, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 %v83, %v84
  %v86 = add i64 0, 1073741824
  %v87 = srem i64 %v85, %v86
  %v88.p = getelementptr i64, ptr %v0, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.c = icmp uge i64 %v59, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b19 = icmp ne i64 %v89, 0
  br i1 %c.b19, label %b19.t34, label %b19.e35
b19.t34:
  br label %b20
b19.e35:
  br label %b21
b20:
  %v90 = add i64 0, 28
  call void @"rt.panic"(i64 %v90)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v91.p = getelementptr i64, ptr %v0, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = inttoptr i64 %v91 to ptr
  %v93 = add i64 0, 1
  %v94 = mul i64 %v59, %v93
  %v95 = getelementptr i64, ptr %v92, i64 %v94
  %st35 = getelementptr i64, ptr %v95, i64 0
  store i64 %v87, ptr %st35
  %v96 = add i64 0, 1073741824
  %v97 = sdiv i64 %v85, %v96
  %st36 = getelementptr i64, ptr %v48, i64 0
  store i64 %v97, ptr %st36
  br label %b12
b22:
  %v104 = getelementptr i64, ptr %s1, i64 0
  %v105.p = getelementptr i64, ptr %v0, i64 0
  %v105 = load i64, ptr %v105.p
  %st37 = getelementptr i64, ptr %v104, i64 0
  store i64 %v105, ptr %st37
  %v106.p = getelementptr i64, ptr %v0, i64 1
  %v106 = load i64, ptr %v106.p
  %st38 = getelementptr i64, ptr %v104, i64 1
  store i64 %v106, ptr %st38
  %v107.p = getelementptr i64, ptr %v0, i64 2
  %v107 = load i64, ptr %v107.p
  %st39 = getelementptr i64, ptr %v104, i64 2
  store i64 %v107, ptr %st39
  %v108.p = getelementptr i64, ptr %v48, i64 0
  %v108 = load i64, ptr %v108.p
  %v109.p = getelementptr i64, ptr %v104, i64 2
  %v109 = load i64, ptr %v109.p
  %v110.p = getelementptr i64, ptr %v104, i64 0
  %v110 = load i64, ptr %v110.p
  %v111.p = getelementptr i64, ptr %v104, i64 1
  %v111 = load i64, ptr %v111.p
  %v114 = add i64 0, 8
  %v115 = mul i64 %v111, %v114
  %v116 = add i64 %v110, %v115
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %v154 = getelementptr i64, ptr %v153, i64 %v109
  %v117.p = getelementptr i64, ptr %v154, i64 1
  %v117 = load ptr, ptr %v117.p
  %v118 = ptrtoint ptr %v117 to i64
  %v119.c = icmp eq i64 %v118, %v116
  %v119 = zext i1 %v119.c to i64
  %c.b22 = icmp ne i64 %v119, 0
  br i1 %c.b22, label %b22.t41, label %b22.e42
b22.t41:
  br label %b26
b22.e42:
  br label %b25
b23:
  br label %b27
b24:
  %v112 = phi ptr [ %v127, %b25 ], [ %v122, %b26 ]
  %v113 = phi ptr [ %v128, %b25 ], [ %v121, %b26 ]
  %st42 = getelementptr i64, ptr %v113, i64 0
  store i64 %v108, ptr %st42
  %v129.p = getelementptr i64, ptr %v104, i64 1
  %v129 = load i64, ptr %v129.p
  %v130 = add i64 0, 1
  %v131 = add i64 %v129, %v130
  %v132 = getelementptr i64, ptr %s0, i64 0
  %v133 = ptrtoint ptr %v112 to i64
  %st43 = getelementptr i64, ptr %v132, i64 0
  store i64 %v133, ptr %st43
  %st44 = getelementptr i64, ptr %v132, i64 1
  store i64 %v131, ptr %st44
  %st45 = getelementptr i64, ptr %v132, i64 2
  store i64 %v109, ptr %st45
  %v134.p = getelementptr i64, ptr %v132, i64 0
  %v134 = load i64, ptr %v134.p
  %st46 = getelementptr i64, ptr %v0, i64 0
  store i64 %v134, ptr %st46
  %v135.p = getelementptr i64, ptr %v132, i64 1
  %v135 = load i64, ptr %v135.p
  %st47 = getelementptr i64, ptr %v0, i64 1
  store i64 %v135, ptr %st47
  %v136.p = getelementptr i64, ptr %v132, i64 2
  %v136 = load i64, ptr %v136.p
  %st48 = getelementptr i64, ptr %v0, i64 2
  store i64 %v136, ptr %st48
  br label %b27
b25:
  %v123 = add i64 0, 1
  %v124 = mul i64 %v111, %v123
  %v125 = add i64 0, 1
  %v126 = add i64 0, 1
  %v127 = call ptr @"rt.slice_grow"(i64 %v110, i64 %v111, i64 %v125, i64 %v109, i64 %v126)
  %v128 = getelementptr i64, ptr %v127, i64 %v124
  br label %b24
b26:
  %v120 = add i64 0, 1
  %v121 = call ptr @"rt.region_alloc"(i64 %v109, i64 %v120)
  %v122 = inttoptr i64 %v110 to ptr
  br label %b24
b27:
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v155, i64 0
  store i64 %v2, ptr %st49
  ret void
}

define internal void @"std/internal/floatfmt.bnShl"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
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
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v268, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 30
  %v10 = sdiv i64 %v1, %v9
  %v11 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st0
  %v12 = add i64 0, 30
  %v13 = srem i64 %v1, %v12
  %v14 = add i64 0, 0
  %v15.c = icmp sgt i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b0 = icmp ne i64 %v15, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v16 = add i64 0, 0
  %v17 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v17, i64 0
  store i64 %v16, ptr %st3
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v18.p = getelementptr i64, ptr %v269, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %v20.p = getelementptr i64, ptr %v0, i64 1
  %v20 = load i64, ptr %v20.p
  %v21 = getelementptr i64, ptr %s2, i64 0
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v270, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = getelementptr i64, ptr %s3, i64 0
  %st4 = getelementptr i64, ptr %v23, i64 0
  store i64 %v19, ptr %st4
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v271, i64 0
  %v24 = load i64, ptr %v24.p
  br label %b5
b2:
  br label %b24
b3:
  %v272 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v272, i64 0
  store i64 %v18, ptr %st5
  %v64.p = getelementptr i64, ptr %v17, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 0
  %v66.c = icmp sgt i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b3 = icmp ne i64 %v66, 0
  br i1 %c.b3, label %b3.t7, label %b3.e8
b3.t7:
  br label %b18
b3.e8:
  br label %b19
b4:
  br label %b3
b5:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v273, i64 0
  store i64 %v24, ptr %st8
  %v25.p = getelementptr i64, ptr %v23, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp slt i64 %v25, %v20
  %v26 = zext i1 %v26.c to i64
  %c.b5 = icmp ne i64 %v26, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b6
b5.e11:
  br label %b7
b6:
  call void @"rt.region_enter"()
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v274, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v23, i64 0
  %v28 = load i64, ptr %v28.p
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v275, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v0, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.c = icmp uge i64 %v28, %v30
  %v31 = zext i1 %v31.c to i64
  %c.b6 = icmp ne i64 %v31, 0
  br i1 %c.b6, label %b6.t12, label %b6.e13
b6.t12:
  br label %b9
b6.e13:
  br label %b10
b7:
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v276, i64 0
  store i64 %v24, ptr %st13
  br label %b4
b8:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v277, i64 0
  store i64 %v29, ptr %st14
  %v61 = add i64 0, 1
  %v62.p = getelementptr i64, ptr %v23, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 %v62, %v61
  %st15 = getelementptr i64, ptr %v23, i64 0
  store i64 %v63, ptr %st15
  br label %b5
b9:
  %v32 = add i64 0, 29
  call void @"rt.panic"(i64 %v32)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v33.p = getelementptr i64, ptr %v0, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = inttoptr i64 %v33 to ptr
  %v35 = add i64 0, 1
  %v36 = mul i64 %v28, %v35
  %v37 = getelementptr i64, ptr %v34, i64 %v36
  %v38.p = getelementptr i64, ptr %v37, i64 0
  %v38 = load i64, ptr %v38.p
  %v40 = add i64 0, 0
  %v41.c = icmp slt i64 %v13, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b10 = icmp ne i64 %v41, 0
  br i1 %c.b10, label %b10.t17, label %b10.e18
b10.t17:
  br label %b11
b10.e18:
  br label %b12
b11:
  %v42 = add i64 0, 30
  call void @"rt.panic"(i64 %v42)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v43 = add i64 0, 63
  %v44.c = icmp sgt i64 %v13, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b12 = icmp ne i64 %v44, 0
  br i1 %c.b12, label %b12.t19, label %b12.e20
b12.t19:
  br label %b14
b12.e20:
  br label %b15
b13:
  %v39 = phi i64 [ %v45, %b14 ], [ %v46, %b15 ]
  %v47.p = getelementptr i64, ptr %v17, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 %v39, %v47
  %v49 = add i64 0, 1073741824
  %v50 = srem i64 %v48, %v49
  %v51.p = getelementptr i64, ptr %v0, i64 1
  %v51 = load i64, ptr %v51.p
  %v52.c = icmp uge i64 %v28, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b13 = icmp ne i64 %v52, 0
  br i1 %c.b13, label %b13.t21, label %b13.e22
b13.t21:
  br label %b16
b13.e22:
  br label %b17
b14:
  %v45 = add i64 0, 0
  br label %b13
b15:
  %v46.n = and i64 %v13, 63
  %v46 = shl i64 %v38, %v46.n
  br label %b13
b16:
  %v53 = add i64 0, 31
  call void @"rt.panic"(i64 %v53)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v54.p = getelementptr i64, ptr %v0, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = inttoptr i64 %v54 to ptr
  %v56 = add i64 0, 1
  %v57 = mul i64 %v28, %v56
  %v58 = getelementptr i64, ptr %v55, i64 %v57
  %st22 = getelementptr i64, ptr %v58, i64 0
  store i64 %v50, ptr %st22
  %v59 = add i64 0, 1073741824
  %v60 = sdiv i64 %v48, %v59
  %st23 = getelementptr i64, ptr %v17, i64 0
  store i64 %v60, ptr %st23
  br label %b8
b18:
  %v67 = getelementptr i64, ptr %s4, i64 0
  %v68.p = getelementptr i64, ptr %v0, i64 0
  %v68 = load i64, ptr %v68.p
  %st24 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st24
  %v69.p = getelementptr i64, ptr %v0, i64 1
  %v69 = load i64, ptr %v69.p
  %st25 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st25
  %v70.p = getelementptr i64, ptr %v0, i64 2
  %v70 = load i64, ptr %v70.p
  %st26 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st26
  %v71.p = getelementptr i64, ptr %v17, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v67, i64 2
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v67, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v67, i64 1
  %v74 = load i64, ptr %v74.p
  %v77 = add i64 0, 8
  %v78 = mul i64 %v74, %v77
  %v79 = add i64 %v73, %v78
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279 = getelementptr i64, ptr %v278, i64 %v72
  %v80.p = getelementptr i64, ptr %v279, i64 1
  %v80 = load ptr, ptr %v80.p
  %v81 = ptrtoint ptr %v80 to i64
  %v82.c = icmp eq i64 %v81, %v79
  %v82 = zext i1 %v82.c to i64
  %c.b18 = icmp ne i64 %v82, 0
  br i1 %c.b18, label %b18.t28, label %b18.e29
b18.t28:
  br label %b22
b18.e29:
  br label %b21
b19:
  br label %b23
b20:
  %v75 = phi ptr [ %v90, %b21 ], [ %v85, %b22 ]
  %v76 = phi ptr [ %v91, %b21 ], [ %v84, %b22 ]
  %st29 = getelementptr i64, ptr %v76, i64 0
  store i64 %v71, ptr %st29
  %v92.p = getelementptr i64, ptr %v67, i64 1
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 1
  %v94 = add i64 %v92, %v93
  %v95 = getelementptr i64, ptr %s5, i64 0
  %v96 = ptrtoint ptr %v75 to i64
  %st30 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st30
  %st31 = getelementptr i64, ptr %v95, i64 1
  store i64 %v94, ptr %st31
  %st32 = getelementptr i64, ptr %v95, i64 2
  store i64 %v72, ptr %st32
  %v97.p = getelementptr i64, ptr %v95, i64 0
  %v97 = load i64, ptr %v97.p
  %st33 = getelementptr i64, ptr %v0, i64 0
  store i64 %v97, ptr %st33
  %v98.p = getelementptr i64, ptr %v95, i64 1
  %v98 = load i64, ptr %v98.p
  %st34 = getelementptr i64, ptr %v0, i64 1
  store i64 %v98, ptr %st34
  %v99.p = getelementptr i64, ptr %v95, i64 2
  %v99 = load i64, ptr %v99.p
  %st35 = getelementptr i64, ptr %v0, i64 2
  store i64 %v99, ptr %st35
  br label %b23
b21:
  %v86 = add i64 0, 1
  %v87 = mul i64 %v74, %v86
  %v88 = add i64 0, 1
  %v89 = add i64 0, 1
  %v90 = call ptr @"rt.slice_grow"(i64 %v73, i64 %v74, i64 %v88, i64 %v72, i64 %v89)
  %v91 = getelementptr i64, ptr %v90, i64 %v87
  br label %b20
b22:
  %v83 = add i64 0, 1
  %v84 = call ptr @"rt.region_alloc"(i64 %v72, i64 %v83)
  %v85 = inttoptr i64 %v73 to ptr
  br label %b20
b23:
  br label %b24
b24:
  %v100.p = getelementptr i64, ptr %v11, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 0
  %v102.c = icmp sgt i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b24 = icmp ne i64 %v102, 0
  br i1 %c.b24, label %b24.t37, label %b24.e38
b24.t37:
  br label %b25
b24.e38:
  br label %b26
b25:
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %v103.p = getelementptr i64, ptr %v280, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105 = call ptr @"rt.region_alloc"(i64 %v103, i64 %v104)
  %v106 = add i64 0, 0
  %v107 = getelementptr i64, ptr %s5, i64 0
  %v108 = ptrtoint ptr %v105 to i64
  %st38 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st38
  %st39 = getelementptr i64, ptr %v107, i64 1
  store i64 %v106, ptr %st39
  %st40 = getelementptr i64, ptr %v107, i64 2
  store i64 %v103, ptr %st40
  %v109 = getelementptr i64, ptr %s4, i64 0
  %v110.p = getelementptr i64, ptr %v107, i64 0
  %v110 = load i64, ptr %v110.p
  %st41 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st41
  %v111.p = getelementptr i64, ptr %v107, i64 1
  %v111 = load i64, ptr %v111.p
  %st42 = getelementptr i64, ptr %v109, i64 1
  store i64 %v111, ptr %st42
  %v112.p = getelementptr i64, ptr %v107, i64 2
  %v112 = load i64, ptr %v112.p
  %st43 = getelementptr i64, ptr %v109, i64 2
  store i64 %v112, ptr %st43
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %v113.p = getelementptr i64, ptr %v281, i64 0
  %v113 = load i64, ptr %v113.p
  br label %b27
b26:
  br label %b51
b27:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v282, i64 0
  store i64 %v113, ptr %st44
  %v114.p = getelementptr i64, ptr %v11, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp sgt i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b27 = icmp ne i64 %v116, 0
  br i1 %c.b27, label %b27.t46, label %b27.e47
b27.t46:
  br label %b28
b27.e47:
  br label %b29
b28:
  call void @"rt.region_enter"()
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %v117.p = getelementptr i64, ptr %v283, i64 0
  %v117 = load i64, ptr %v117.p
  %v118 = getelementptr i64, ptr %s5, i64 0
  %v119.p = getelementptr i64, ptr %v109, i64 0
  %v119 = load i64, ptr %v119.p
  %st47 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st47
  %v120.p = getelementptr i64, ptr %v109, i64 1
  %v120 = load i64, ptr %v120.p
  %st48 = getelementptr i64, ptr %v118, i64 1
  store i64 %v120, ptr %st48
  %v121.p = getelementptr i64, ptr %v109, i64 2
  %v121 = load i64, ptr %v121.p
  %st49 = getelementptr i64, ptr %v118, i64 2
  store i64 %v121, ptr %st49
  %v122 = add i64 0, 0
  %v123.p = getelementptr i64, ptr %v118, i64 2
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v118, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v118, i64 1
  %v125 = load i64, ptr %v125.p
  %v128 = add i64 0, 8
  %v129 = mul i64 %v125, %v128
  %v130 = add i64 %v124, %v129
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %v285 = getelementptr i64, ptr %v284, i64 %v123
  %v131.p = getelementptr i64, ptr %v285, i64 1
  %v131 = load ptr, ptr %v131.p
  %v132 = ptrtoint ptr %v131 to i64
  %v133.c = icmp eq i64 %v132, %v130
  %v133 = zext i1 %v133.c to i64
  %c.b28 = icmp ne i64 %v133, 0
  br i1 %c.b28, label %b28.t51, label %b28.e52
b28.t51:
  br label %b32
b28.e52:
  br label %b31
b29:
  %v286 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v286, i64 0
  store i64 %v113, ptr %st52
  %v154 = add i64 0, 0
  %v155 = add i64 0, 0
  %v156.p = getelementptr i64, ptr %v0, i64 1
  %v156 = load i64, ptr %v156.p
  %v157 = sub i64 %v156, %v155
  %v158.c = icmp sle i64 %v157, %v154
  %v158 = zext i1 %v158.c to i64
  %c.b29 = icmp ne i64 %v158, 0
  br i1 %c.b29, label %b29.t54, label %b29.e55
b29.t54:
  br label %b33
b29.e55:
  br label %b34
b30:
  %v126 = phi ptr [ %v141, %b31 ], [ %v136, %b32 ]
  %v127 = phi ptr [ %v142, %b31 ], [ %v135, %b32 ]
  %st55 = getelementptr i64, ptr %v127, i64 0
  store i64 %v122, ptr %st55
  %v143.p = getelementptr i64, ptr %v118, i64 1
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 1
  %v145 = add i64 %v143, %v144
  %v146 = getelementptr i64, ptr %s6, i64 0
  %v147 = ptrtoint ptr %v126 to i64
  %st56 = getelementptr i64, ptr %v146, i64 0
  store i64 %v147, ptr %st56
  %st57 = getelementptr i64, ptr %v146, i64 1
  store i64 %v145, ptr %st57
  %st58 = getelementptr i64, ptr %v146, i64 2
  store i64 %v123, ptr %st58
  %v148.p = getelementptr i64, ptr %v146, i64 0
  %v148 = load i64, ptr %v148.p
  %st59 = getelementptr i64, ptr %v109, i64 0
  store i64 %v148, ptr %st59
  %v149.p = getelementptr i64, ptr %v146, i64 1
  %v149 = load i64, ptr %v149.p
  %st60 = getelementptr i64, ptr %v109, i64 1
  store i64 %v149, ptr %st60
  %v150.p = getelementptr i64, ptr %v146, i64 2
  %v150 = load i64, ptr %v150.p
  %st61 = getelementptr i64, ptr %v109, i64 2
  store i64 %v150, ptr %st61
  %v151 = add i64 0, 1
  %v152.p = getelementptr i64, ptr %v11, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = sub i64 %v152, %v151
  %st62 = getelementptr i64, ptr %v11, i64 0
  store i64 %v153, ptr %st62
  br label %b27
b31:
  %v137 = add i64 0, 1
  %v138 = mul i64 %v125, %v137
  %v139 = add i64 0, 1
  %v140 = add i64 0, 1
  %v141 = call ptr @"rt.slice_grow"(i64 %v124, i64 %v125, i64 %v139, i64 %v123, i64 %v140)
  %v142 = getelementptr i64, ptr %v141, i64 %v138
  br label %b30
b32:
  %v134 = add i64 0, 1
  %v135 = call ptr @"rt.region_alloc"(i64 %v123, i64 %v134)
  %v136 = inttoptr i64 %v124 to ptr
  br label %b30
b33:
  %v261 = getelementptr i64, ptr %s5, i64 0
  %v262.p = getelementptr i64, ptr %v109, i64 0
  %v262 = load i64, ptr %v262.p
  %st63 = getelementptr i64, ptr %v261, i64 0
  store i64 %v262, ptr %st63
  %v263.p = getelementptr i64, ptr %v109, i64 1
  %v263 = load i64, ptr %v263.p
  %st64 = getelementptr i64, ptr %v261, i64 1
  store i64 %v263, ptr %st64
  %v264.p = getelementptr i64, ptr %v109, i64 2
  %v264 = load i64, ptr %v264.p
  %st65 = getelementptr i64, ptr %v261, i64 2
  store i64 %v264, ptr %st65
  %v287 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v261, i64 %v287, i64 %v8)
  %v265.p = getelementptr i64, ptr %v261, i64 0
  %v265 = load i64, ptr %v265.p
  %st66 = getelementptr i64, ptr %v0, i64 0
  store i64 %v265, ptr %st66
  %v266.p = getelementptr i64, ptr %v261, i64 1
  %v266 = load i64, ptr %v266.p
  %st67 = getelementptr i64, ptr %v0, i64 1
  store i64 %v266, ptr %st67
  %v267.p = getelementptr i64, ptr %v261, i64 2
  %v267 = load i64, ptr %v267.p
  %st68 = getelementptr i64, ptr %v0, i64 2
  store i64 %v267, ptr %st68
  br label %b51
b34:
  %v159.c = icmp sge i64 %v155, %v154
  %v159 = zext i1 %v159.c to i64
  %v160.p = getelementptr i64, ptr %v0, i64 1
  %v160 = load i64, ptr %v160.p
  %v161.c = icmp sle i64 %v156, %v160
  %v161 = zext i1 %v161.c to i64
  %v162 = and i64 %v159, %v161
  %v163.c = icmp ne i64 %v162, %v154
  %v163 = zext i1 %v163.c to i64
  %c.b34 = icmp ne i64 %v163, 0
  br i1 %c.b34, label %b34.t70, label %b34.e71
b34.t70:
  br label %b36
b34.e71:
  br label %b35
b35:
  %v288 = getelementptr i64, ptr @"rt.meta", i64 0
  %v205.p = getelementptr i64, ptr %v288, i64 0
  %v205 = load i64, ptr %v205.p
  %v206 = add i64 0, 0
  %v207.p = getelementptr i64, ptr %v0, i64 1
  %v207 = load i64, ptr %v207.p
  %v208 = getelementptr i64, ptr %s1, i64 0
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %v209.p = getelementptr i64, ptr %v289, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = getelementptr i64, ptr %s3, i64 0
  %st71 = getelementptr i64, ptr %v210, i64 0
  store i64 %v206, ptr %st71
  %v290 = getelementptr i64, ptr @"rt.meta", i64 0
  %v211.p = getelementptr i64, ptr %v290, i64 0
  %v211 = load i64, ptr %v211.p
  br label %b42
b36:
  %v164 = getelementptr i64, ptr %s6, i64 0
  %v165.p = getelementptr i64, ptr %v109, i64 0
  %v165 = load i64, ptr %v165.p
  %st72 = getelementptr i64, ptr %v164, i64 0
  store i64 %v165, ptr %st72
  %v166.p = getelementptr i64, ptr %v109, i64 1
  %v166 = load i64, ptr %v166.p
  %st73 = getelementptr i64, ptr %v164, i64 1
  store i64 %v166, ptr %st73
  %v167.p = getelementptr i64, ptr %v109, i64 2
  %v167 = load i64, ptr %v167.p
  %st74 = getelementptr i64, ptr %v164, i64 2
  store i64 %v167, ptr %st74
  %v168.p = getelementptr i64, ptr %v164, i64 2
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v164, i64 0
  %v169 = load i64, ptr %v169.p
  %v170.p = getelementptr i64, ptr %v164, i64 1
  %v170 = load i64, ptr %v170.p
  %v173 = add i64 0, 8
  %v174 = mul i64 %v170, %v173
  %v175 = add i64 %v169, %v174
  %v291 = getelementptr i64, ptr @"rt.meta", i64 0
  %v292 = getelementptr i64, ptr %v291, i64 %v168
  %v176.p = getelementptr i64, ptr %v292, i64 1
  %v176 = load ptr, ptr %v176.p
  %v177 = ptrtoint ptr %v176 to i64
  %v178.c = icmp eq i64 %v177, %v175
  %v178 = zext i1 %v178.c to i64
  %c.b36 = icmp ne i64 %v178, 0
  br i1 %c.b36, label %b36.t76, label %b36.e77
b36.t76:
  br label %b39
b36.e77:
  br label %b38
b37:
  %v171 = phi ptr [ %v188, %b38 ], [ %v182, %b39 ]
  %v172 = phi ptr [ %v190, %b38 ], [ %v181, %b39 ]
  %v191.p = getelementptr i64, ptr %v0, i64 0
  %v191 = load i64, ptr %v191.p
  %v192 = inttoptr i64 %v191 to ptr
  %v193 = add i64 0, 1
  %v194 = mul i64 %v155, %v193
  %v195 = getelementptr i64, ptr %v192, i64 %v194
  %v196 = add i64 0, 1
  %v197 = mul i64 %v157, %v196
  call void @"rt.copy"(ptr %v172, ptr %v195, i64 %v197)
  %v198.p = getelementptr i64, ptr %v164, i64 1
  %v198 = load i64, ptr %v198.p
  %v199 = add i64 %v198, %v157
  %v200 = getelementptr i64, ptr %s5, i64 0
  %v201 = ptrtoint ptr %v171 to i64
  %st77 = getelementptr i64, ptr %v200, i64 0
  store i64 %v201, ptr %st77
  %st78 = getelementptr i64, ptr %v200, i64 1
  store i64 %v199, ptr %st78
  %st79 = getelementptr i64, ptr %v200, i64 2
  store i64 %v168, ptr %st79
  %v202.p = getelementptr i64, ptr %v200, i64 0
  %v202 = load i64, ptr %v202.p
  %st80 = getelementptr i64, ptr %v109, i64 0
  store i64 %v202, ptr %st80
  %v203.p = getelementptr i64, ptr %v200, i64 1
  %v203 = load i64, ptr %v203.p
  %st81 = getelementptr i64, ptr %v109, i64 1
  store i64 %v203, ptr %st81
  %v204.p = getelementptr i64, ptr %v200, i64 2
  %v204 = load i64, ptr %v204.p
  %st82 = getelementptr i64, ptr %v109, i64 2
  store i64 %v204, ptr %st82
  br label %b33
b38:
  %v183 = add i64 0, 1
  %v184 = mul i64 %v170, %v183
  %v185 = add i64 0, 1
  %v186 = mul i64 %v157, %v185
  %v187 = add i64 %v184, %v186
  %v188 = call ptr @"rt.region_alloc"(i64 %v168, i64 %v187)
  %v189 = inttoptr i64 %v169 to ptr
  call void @"rt.copy"(ptr %v188, ptr %v189, i64 %v184)
  %v190 = getelementptr i64, ptr %v188, i64 %v184
  br label %b37
b39:
  %v179 = add i64 0, 1
  %v180 = mul i64 %v157, %v179
  %v181 = call ptr @"rt.region_alloc"(i64 %v168, i64 %v180)
  %v182 = inttoptr i64 %v169 to ptr
  br label %b37
b40:
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v293, i64 0
  store i64 %v205, ptr %st83
  br label %b33
b41:
  br label %b40
b42:
  %v294 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v294, i64 0
  store i64 %v211, ptr %st84
  %v212.p = getelementptr i64, ptr %v210, i64 0
  %v212 = load i64, ptr %v212.p
  %v213.c = icmp slt i64 %v212, %v207
  %v213 = zext i1 %v213.c to i64
  %c.b42 = icmp ne i64 %v213, 0
  br i1 %c.b42, label %b42.t86, label %b42.e87
b42.t86:
  br label %b43
b42.e87:
  br label %b44
b43:
  call void @"rt.region_enter"()
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %v214.p = getelementptr i64, ptr %v295, i64 0
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v210, i64 0
  %v215 = load i64, ptr %v215.p
  %v296 = getelementptr i64, ptr @"rt.meta", i64 0
  %v216.p = getelementptr i64, ptr %v296, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = getelementptr i64, ptr %s7, i64 0
  %v218.p = getelementptr i64, ptr %v109, i64 0
  %v218 = load i64, ptr %v218.p
  %st87 = getelementptr i64, ptr %v217, i64 0
  store i64 %v218, ptr %st87
  %v219.p = getelementptr i64, ptr %v109, i64 1
  %v219 = load i64, ptr %v219.p
  %st88 = getelementptr i64, ptr %v217, i64 1
  store i64 %v219, ptr %st88
  %v220.p = getelementptr i64, ptr %v109, i64 2
  %v220 = load i64, ptr %v220.p
  %st89 = getelementptr i64, ptr %v217, i64 2
  store i64 %v220, ptr %st89
  %v221.p = getelementptr i64, ptr %v0, i64 1
  %v221 = load i64, ptr %v221.p
  %v222.c = icmp uge i64 %v215, %v221
  %v222 = zext i1 %v222.c to i64
  %c.b43 = icmp ne i64 %v222, 0
  br i1 %c.b43, label %b43.t91, label %b43.e92
b43.t91:
  br label %b46
b43.e92:
  br label %b47
b44:
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v297, i64 0
  store i64 %v211, ptr %st92
  br label %b41
b45:
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %st93 = getelementptr i64, ptr %v298, i64 0
  store i64 %v216, ptr %st93
  %v258 = add i64 0, 1
  %v259.p = getelementptr i64, ptr %v210, i64 0
  %v259 = load i64, ptr %v259.p
  %v260 = add i64 %v259, %v258
  %st94 = getelementptr i64, ptr %v210, i64 0
  store i64 %v260, ptr %st94
  br label %b42
b46:
  %v223 = add i64 0, 32
  call void @"rt.panic"(i64 %v223)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v224.p = getelementptr i64, ptr %v0, i64 0
  %v224 = load i64, ptr %v224.p
  %v225 = inttoptr i64 %v224 to ptr
  %v226 = add i64 0, 1
  %v227 = mul i64 %v215, %v226
  %v228 = getelementptr i64, ptr %v225, i64 %v227
  %v229.p = getelementptr i64, ptr %v228, i64 0
  %v229 = load i64, ptr %v229.p
  %v230.p = getelementptr i64, ptr %v217, i64 2
  %v230 = load i64, ptr %v230.p
  %v231.p = getelementptr i64, ptr %v217, i64 0
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v217, i64 1
  %v232 = load i64, ptr %v232.p
  %v235 = add i64 0, 8
  %v236 = mul i64 %v232, %v235
  %v237 = add i64 %v231, %v236
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %v300 = getelementptr i64, ptr %v299, i64 %v230
  %v238.p = getelementptr i64, ptr %v300, i64 1
  %v238 = load ptr, ptr %v238.p
  %v239 = ptrtoint ptr %v238 to i64
  %v240.c = icmp eq i64 %v239, %v237
  %v240 = zext i1 %v240.c to i64
  %c.b47 = icmp ne i64 %v240, 0
  br i1 %c.b47, label %b47.t96, label %b47.e97
b47.t96:
  br label %b50
b47.e97:
  br label %b49
b48:
  %v233 = phi ptr [ %v248, %b49 ], [ %v243, %b50 ]
  %v234 = phi ptr [ %v249, %b49 ], [ %v242, %b50 ]
  %st97 = getelementptr i64, ptr %v234, i64 0
  store i64 %v229, ptr %st97
  %v250.p = getelementptr i64, ptr %v217, i64 1
  %v250 = load i64, ptr %v250.p
  %v251 = add i64 0, 1
  %v252 = add i64 %v250, %v251
  %v253 = getelementptr i64, ptr %s8, i64 0
  %v254 = ptrtoint ptr %v233 to i64
  %st98 = getelementptr i64, ptr %v253, i64 0
  store i64 %v254, ptr %st98
  %st99 = getelementptr i64, ptr %v253, i64 1
  store i64 %v252, ptr %st99
  %st100 = getelementptr i64, ptr %v253, i64 2
  store i64 %v230, ptr %st100
  %v255.p = getelementptr i64, ptr %v253, i64 0
  %v255 = load i64, ptr %v255.p
  %st101 = getelementptr i64, ptr %v109, i64 0
  store i64 %v255, ptr %st101
  %v256.p = getelementptr i64, ptr %v253, i64 1
  %v256 = load i64, ptr %v256.p
  %st102 = getelementptr i64, ptr %v109, i64 1
  store i64 %v256, ptr %st102
  %v257.p = getelementptr i64, ptr %v253, i64 2
  %v257 = load i64, ptr %v257.p
  %st103 = getelementptr i64, ptr %v109, i64 2
  store i64 %v257, ptr %st103
  br label %b45
b49:
  %v244 = add i64 0, 1
  %v245 = mul i64 %v232, %v244
  %v246 = add i64 0, 1
  %v247 = add i64 0, 1
  %v248 = call ptr @"rt.slice_grow"(i64 %v231, i64 %v232, i64 %v246, i64 %v230, i64 %v247)
  %v249 = getelementptr i64, ptr %v248, i64 %v245
  br label %b48
b50:
  %v241 = add i64 0, 1
  %v242 = call ptr @"rt.region_alloc"(i64 %v230, i64 %v241)
  %v243 = inttoptr i64 %v231 to ptr
  br label %b48
b51:
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %st104 = getelementptr i64, ptr %v301, i64 0
  store i64 %v2, ptr %st104
  ret void
}

define internal i64 @"std/internal/floatfmt.bnTop"(ptr %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v34, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v2, i64 2572
  %v3 = load i64, ptr %v3.p
  %v4 = add i64 0, 0
  %v5.c = icmp eq i64 %v3, %v4
  %v5 = zext i1 %v5.c to i64
  %v6 = mul i64 %v5, %v1
  %v7 = add i64 %v3, %v6
  %v8.p = getelementptr i64, ptr %v0, i64 1
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 1
  %v10 = sub i64 %v8, %v9
  %v11 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st0
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v35, i64 0
  %v12 = load i64, ptr %v12.p
  br label %b1
b1:
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v36, i64 0
  store i64 %v12, ptr %st1
  %v13.p = getelementptr i64, ptr %v11, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15.c = icmp sge i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b1 = icmp ne i64 %v15, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b4
b1.e4:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v37, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 0, 1
  %v31.p = getelementptr i64, ptr %v11, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = sub i64 %v31, %v30
  %st4 = getelementptr i64, ptr %v11, i64 0
  store i64 %v32, ptr %st4
  br label %b1
b3:
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v38, i64 0
  store i64 %v12, ptr %st5
  %v33.p = getelementptr i64, ptr %v11, i64 0
  %v33 = load i64, ptr %v33.p
  %v39 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v39, i64 0
  store i64 %v1, ptr %st6
  ret i64 %v33
b4:
  %v17.p = getelementptr i64, ptr %v11, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v0, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp uge i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b4 = icmp ne i64 %v19, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b6
b4.e9:
  br label %b7
b5:
  %v16 = phi i64 [ %v15, %b1.e4 ], [ %v28, %b7 ]
  %c.b5 = icmp ne i64 %v16, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b2
b5.e11:
  br label %b3
b6:
  %v20 = add i64 0, 33
  call void @"rt.panic"(i64 %v20)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v21.p = getelementptr i64, ptr %v0, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = inttoptr i64 %v21 to ptr
  %v23 = add i64 0, 1
  %v24 = mul i64 %v17, %v23
  %v25 = getelementptr i64, ptr %v22, i64 %v24
  %v26.p = getelementptr i64, ptr %v25, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp eq i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  br label %b5
}

define internal i64 @"std/internal/floatfmt.bnCmp"(ptr %v0, ptr %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v77, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v9, i64 2572
  store i64 %v8, ptr %st0
  %v10 = call i64 @"std/internal/floatfmt.bnTop"(ptr %v0)
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v11, i64 2572
  store i64 %v8, ptr %st1
  %v12 = call i64 @"std/internal/floatfmt.bnTop"(ptr %v1)
  %v13.c = icmp ne i64 %v10, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b0 = icmp ne i64 %v13, 0
  br i1 %c.b0, label %b0.t3, label %b0.e4
b0.t3:
  br label %b1
b0.e4:
  br label %b2
b1:
  %v14.c = icmp sgt i64 %v10, %v12
  %v14 = zext i1 %v14.c to i64
  %c.b1 = icmp ne i64 %v14, 0
  br i1 %c.b1, label %b1.t5, label %b1.e6
b1.t5:
  br label %b3
b1.e6:
  br label %b4
b2:
  br label %b6
b3:
  %v15 = add i64 0, 1
  br label %b5
b4:
  %v16 = add i64 0, 1
  %v17 = add i64 0, 0
  %v18 = sub i64 %v17, %v16
  br label %b5
b5:
  %v19 = phi i64 [ %v15, %b3 ], [ %v18, %b4 ]
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v78, i64 0
  store i64 %v2, ptr %st6
  ret i64 %v19
b6:
  %v20 = getelementptr i64, ptr %s0, i64 0
  %st7 = getelementptr i64, ptr %v20, i64 0
  store i64 %v10, ptr %st7
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v79, i64 0
  %v21 = load i64, ptr %v21.p
  br label %b7
b7:
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v80, i64 0
  store i64 %v21, ptr %st8
  %v22.p = getelementptr i64, ptr %v20, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 0, 0
  %v24.c = icmp sge i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b7 = icmp ne i64 %v24, 0
  br i1 %c.b7, label %b7.t10, label %b7.e11
b7.t10:
  br label %b8
b7.e11:
  br label %b9
b8:
  call void @"rt.region_enter"()
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %v25.p = getelementptr i64, ptr %v81, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v20, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v0, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b8 = icmp ne i64 %v28, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b10
b8.e13:
  br label %b11
b9:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v82, i64 0
  store i64 %v21, ptr %st13
  %v76 = add i64 0, 0
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v83, i64 0
  store i64 %v2, ptr %st14
  ret i64 %v76
b10:
  %v29 = add i64 0, 34
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v30.p = getelementptr i64, ptr %v0, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = add i64 0, 1
  %v33 = mul i64 %v26, %v32
  %v34 = getelementptr i64, ptr %v31, i64 %v33
  %v35.p = getelementptr i64, ptr %v34, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v20, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v1, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b11 = icmp ne i64 %v38, 0
  br i1 %c.b11, label %b11.t16, label %b11.e17
b11.t16:
  br label %b12
b11.e17:
  br label %b13
b12:
  %v39 = add i64 0, 35
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v40.p = getelementptr i64, ptr %v1, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v36, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %v45.p = getelementptr i64, ptr %v44, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.c = icmp ne i64 %v35, %v45
  %v46 = zext i1 %v46.c to i64
  %c.b13 = icmp ne i64 %v46, 0
  br i1 %c.b13, label %b13.t18, label %b13.e19
b13.t18:
  br label %b14
b13.e19:
  br label %b15
b14:
  %v47.p = getelementptr i64, ptr %v20, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v0, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp uge i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b14 = icmp ne i64 %v49, 0
  br i1 %c.b14, label %b14.t20, label %b14.e21
b14.t20:
  br label %b16
b14.e21:
  br label %b17
b15:
  br label %b23
b16:
  %v50 = add i64 0, 36
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v51.p = getelementptr i64, ptr %v0, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = add i64 0, 1
  %v54 = mul i64 %v47, %v53
  %v55 = getelementptr i64, ptr %v52, i64 %v54
  %v56.p = getelementptr i64, ptr %v55, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v20, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v1, i64 1
  %v58 = load i64, ptr %v58.p
  %v59.c = icmp uge i64 %v57, %v58
  %v59 = zext i1 %v59.c to i64
  %c.b17 = icmp ne i64 %v59, 0
  br i1 %c.b17, label %b17.t22, label %b17.e23
b17.t22:
  br label %b18
b17.e23:
  br label %b19
b18:
  %v60 = add i64 0, 37
  call void @"rt.panic"(i64 %v60)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v61.p = getelementptr i64, ptr %v1, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = inttoptr i64 %v61 to ptr
  %v63 = add i64 0, 1
  %v64 = mul i64 %v57, %v63
  %v65 = getelementptr i64, ptr %v62, i64 %v64
  %v66.p = getelementptr i64, ptr %v65, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp sgt i64 %v56, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b19 = icmp ne i64 %v67, 0
  br i1 %c.b19, label %b19.t24, label %b19.e25
b19.t24:
  br label %b20
b19.e25:
  br label %b21
b20:
  %v68 = add i64 0, 1
  br label %b22
b21:
  %v69 = add i64 0, 1
  %v70 = add i64 0, 0
  %v71 = sub i64 %v70, %v69
  br label %b22
b22:
  %v72 = phi i64 [ %v68, %b20 ], [ %v71, %b21 ]
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v84, i64 0
  store i64 %v2, ptr %st25
  ret i64 %v72
b23:
  %v73 = add i64 0, 1
  %v74.p = getelementptr i64, ptr %v20, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = sub i64 %v74, %v73
  %st26 = getelementptr i64, ptr %v20, i64 0
  store i64 %v75, ptr %st26
  br label %b7
}

define internal void @"std/internal/floatfmt.bnSub"(ptr %v0, ptr %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %v73 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v73, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 0
  %v10 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v10, i64 0
  store i64 %v9, ptr %st0
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v74, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.p = getelementptr i64, ptr %v0, i64 1
  %v13 = load i64, ptr %v13.p
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v75, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s2, i64 0
  %st1 = getelementptr i64, ptr %v16, i64 0
  store i64 %v12, ptr %st1
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v76, i64 0
  %v17 = load i64, ptr %v17.p
  br label %b3
b1:
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v77, i64 0
  store i64 %v11, ptr %st2
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v78, i64 0
  store i64 %v2, ptr %st3
  ret void
b2:
  br label %b1
b3:
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v79, i64 0
  store i64 %v17, ptr %st4
  %v18.p = getelementptr i64, ptr %v16, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp slt i64 %v18, %v13
  %v19 = zext i1 %v19.c to i64
  %c.b3 = icmp ne i64 %v19, 0
  br i1 %c.b3, label %b3.t6, label %b3.e7
b3.t6:
  br label %b4
b3.e7:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v80, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 0
  %v21 = load i64, ptr %v21.p
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v81, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v0, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.c = icmp uge i64 %v21, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b4 = icmp ne i64 %v24, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b7
b4.e9:
  br label %b8
b5:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v82, i64 0
  store i64 %v17, ptr %st9
  br label %b2
b6:
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v83, i64 0
  store i64 %v22, ptr %st10
  %v70 = add i64 0, 1
  %v71.p = getelementptr i64, ptr %v16, i64 0
  %v71 = load i64, ptr %v71.p
  %v72 = add i64 %v71, %v70
  %st11 = getelementptr i64, ptr %v16, i64 0
  store i64 %v72, ptr %st11
  br label %b3
b7:
  %v25 = add i64 0, 38
  call void @"rt.panic"(i64 %v25)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v26.p = getelementptr i64, ptr %v0, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = inttoptr i64 %v26 to ptr
  %v28 = add i64 0, 1
  %v29 = mul i64 %v21, %v28
  %v30 = getelementptr i64, ptr %v27, i64 %v29
  %v31.p = getelementptr i64, ptr %v30, i64 0
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v1, i64 1
  %v32 = load i64, ptr %v32.p
  %v33.c = icmp slt i64 %v21, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b8 = icmp ne i64 %v33, 0
  br i1 %c.b8, label %b8.t13, label %b8.e14
b8.t13:
  br label %b9
b8.e14:
  br label %b10
b9:
  %v34.p = getelementptr i64, ptr %v1, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp uge i64 %v21, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b9 = icmp ne i64 %v35, 0
  br i1 %c.b9, label %b9.t15, label %b9.e16
b9.t15:
  br label %b11
b9.e16:
  br label %b12
b10:
  %v43 = add i64 0, 0
  br label %b13
b11:
  %v36 = add i64 0, 39
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v37.p = getelementptr i64, ptr %v1, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = inttoptr i64 %v37 to ptr
  %v39 = add i64 0, 1
  %v40 = mul i64 %v21, %v39
  %v41 = getelementptr i64, ptr %v38, i64 %v40
  %v42.p = getelementptr i64, ptr %v41, i64 0
  %v42 = load i64, ptr %v42.p
  br label %b13
b13:
  %v44 = phi i64 [ %v43, %b10 ], [ %v42, %b12 ]
  %v45 = sub i64 %v31, %v44
  %v46.p = getelementptr i64, ptr %v10, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = sub i64 %v45, %v46
  %v48 = add i64 0, 0
  %v49.c = icmp slt i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b13 = icmp ne i64 %v49, 0
  br i1 %c.b13, label %b13.t17, label %b13.e18
b13.t17:
  br label %b14
b13.e18:
  br label %b15
b14:
  %v50 = add i64 0, 1073741824
  %v51 = add i64 %v47, %v50
  %v52.p = getelementptr i64, ptr %v0, i64 1
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp uge i64 %v21, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b14 = icmp ne i64 %v53, 0
  br i1 %c.b14, label %b14.t19, label %b14.e20
b14.t19:
  br label %b16
b14.e20:
  br label %b17
b15:
  %v61.p = getelementptr i64, ptr %v0, i64 1
  %v61 = load i64, ptr %v61.p
  %v62.c = icmp uge i64 %v21, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b15 = icmp ne i64 %v62, 0
  br i1 %c.b15, label %b15.t21, label %b15.e22
b15.t21:
  br label %b18
b15.e22:
  br label %b19
b16:
  %v54 = add i64 0, 40
  call void @"rt.panic"(i64 %v54)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v55.p = getelementptr i64, ptr %v0, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = inttoptr i64 %v55 to ptr
  %v57 = add i64 0, 1
  %v58 = mul i64 %v21, %v57
  %v59 = getelementptr i64, ptr %v56, i64 %v58
  %st22 = getelementptr i64, ptr %v59, i64 0
  store i64 %v51, ptr %st22
  %v60 = add i64 0, 1
  %st23 = getelementptr i64, ptr %v10, i64 0
  store i64 %v60, ptr %st23
  br label %b20
b18:
  %v63 = add i64 0, 41
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v64.p = getelementptr i64, ptr %v0, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = inttoptr i64 %v64 to ptr
  %v66 = add i64 0, 1
  %v67 = mul i64 %v21, %v66
  %v68 = getelementptr i64, ptr %v65, i64 %v67
  %st24 = getelementptr i64, ptr %v68, i64 0
  store i64 %v47, ptr %st24
  %v69 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v10, i64 0
  store i64 %v69, ptr %st25
  br label %b20
b20:
  br label %b6
}

define internal void @"rt.err_relocate"(ptr %v0, i64 %v1) #0 {
b0:
  %v2 = add i64 0, 2
  %v3 = getelementptr i64, ptr %v0, i64 %v2
  %v4 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v3, i64 %v4, i64 %v1)
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
  %v20 = getelementptr i64, ptr @"str.14", i64 0
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
  %v74 = getelementptr i64, ptr @"str.22", i64 0
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
  %v27 = getelementptr i64, ptr @"str.15", i64 0
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
  %v34 = getelementptr i64, ptr @"str.16", i64 0
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
  %v41 = getelementptr i64, ptr @"str.17", i64 0
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
  %v48 = getelementptr i64, ptr @"str.18", i64 0
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
  %v55 = getelementptr i64, ptr @"str.19", i64 0
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
  %v62 = getelementptr i64, ptr @"str.20", i64 0
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
  %v69 = getelementptr i64, ptr @"str.21", i64 0
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
  %v81 = getelementptr i64, ptr @"str.23", i64 0
  %v82 = add i64 0, 24
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
  %v88 = getelementptr i64, ptr @"str.24", i64 0
  %v89 = add i64 0, 36
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

define internal void @"rt.read_fd"(i64 %v0, i64 %v1, ptr %v2) #0 {
b0:
  call void @"rt.flush"()
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 0
  %v4 = load i64, ptr %v4.p
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41 = getelementptr i64, ptr %v40, i64 %v4
  %v5.p = getelementptr i64, ptr %v41, i64 1
  %v5 = load ptr, ptr %v5.p
  %v6 = ptrtoint ptr %v5 to i64
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v6, ptr %st0
  %v7 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v2, i64 1
  store i64 %v7, ptr %st1
  %st2 = getelementptr i64, ptr %v2, i64 2
  store i64 %v4, ptr %st2
  %v8 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v9 = add i64 0, 0
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v10, i64 1027
  store i64 %v9, ptr %st3
  br label %b1
b1:
  %v11 = add i64 0, 4096
  %v12.c = icmp slt i64 %v1, %v11
  %v12 = zext i1 %v12.c to i64
  %v13 = add i64 0, 0
  %v14.c = icmp sge i64 %v1, %v13
  %v14 = zext i1 %v14.c to i64
  %v15 = and i64 %v12, %v14
  %c.b1 = icmp ne i64 %v15, 0
  br i1 %c.b1, label %b1.t5, label %b1.e6
b1.t5:
  br label %b4
b1.e6:
  br label %b5
b2:
  ret void
b3:
  %v16 = phi i64 [ %v1, %b4 ], [ %v17, %b5 ]
  %v18 = add i64 0, 0
  %v19.c = icmp eq i64 %v16, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b3 = icmp ne i64 %v19, 0
  br i1 %c.b3, label %b3.t7, label %b3.e8
b3.t7:
  br label %b6
b3.e8:
  br label %b7
b4:
  br label %b3
b5:
  %v17 = add i64 0, 4096
  br label %b3
b6:
  br label %b2
b7:
  %v20 = add i64 0, 0
  %v21 = ptrtoint ptr %v8 to i64
  %v22 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v20, i64 %v0, i64 %v21, i64 %v16)
  %v23 = add i64 0, -4
  %v24.c = icmp eq i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b7 = icmp ne i64 %v24, 0
  br i1 %c.b7, label %b7.t9, label %b7.e10
b7.t9:
  br label %b8
b7.e10:
  br label %b9
b8:
  br label %b1
b9:
  %v25 = add i64 0, 0
  %v26.c = icmp eq i64 %v22, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b9 = icmp ne i64 %v26, 0
  br i1 %c.b9, label %b9.t11, label %b9.e12
b9.t11:
  br label %b10
b9.e12:
  br label %b11
b10:
  br label %b2
b11:
  %v27 = add i64 0, 0
  %v28.c = icmp slt i64 %v22, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b11 = icmp ne i64 %v28, 0
  br i1 %c.b11, label %b11.t13, label %b11.e14
b11.t13:
  br label %b12
b11.e14:
  br label %b13
b12:
  %v29 = add i64 0, 0
  %v30 = sub i64 %v29, %v22
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v31, i64 1027
  store i64 %v30, ptr %st14
  br label %b2
b13:
  %v32.p = getelementptr i64, ptr %v2, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v2, i64 1
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 %v32, %v33
  call void @"rt.extend8"(i64 %v4, i64 %v34, i64 %v22)
  %v35 = inttoptr i64 %v34 to ptr
  call void @"rt.copy8"(ptr %v35, ptr %v8, i64 %v22)
  %v36.p = getelementptr i64, ptr %v2, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 %v36, %v22
  %st15 = getelementptr i64, ptr %v2, i64 1
  store i64 %v37, ptr %st15
  %v38 = add i64 0, 0
  %v39.c = icmp slt i64 %v1, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b13 = icmp ne i64 %v39, 0
  br i1 %c.b13, label %b13.t17, label %b13.e18
b13.t17:
  br label %b14
b13.e18:
  br label %b15
b14:
  br label %b1
b15:
  br label %b2
}

define internal void @"rt.sigint"() #0 {
b0:
  %v0 = add i64 0, 231
  %v1 = add i64 0, 130
  %v2 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v0, i64 %v1)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 130)
  unreachable
}

define internal void @"rt.sigterm"() #0 {
b0:
  %v0 = add i64 0, 231
  %v1 = add i64 0, 143
  %v2 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v0, i64 %v1)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 143)
  unreachable
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
  %v279 = phi i64 [ %v283, %b61.t104 ], [ %v388, %b86.e150 ], [ %v388, %b87.e152 ], [ %v388, %b88.e154 ], [ %v388, %b89.t155 ], [ %v382, %b90 ]
  %st105 = getelementptr i64, ptr %v1, i64 2573
  store i64 %v279, ptr %st105
  %v406 = call i64 @"main.main"()
  call void @"rt.depth_report"()
  %v407 = add i64 0, 256
  %v408.c = icmp uge i64 %v406, %v407
  %v408 = zext i1 %v408.c to i64
  %c.b62 = icmp ne i64 %v408, 0
  br i1 %c.b62, label %b62.t107, label %b62.e108
b62.t107:
  br label %b92
b62.e108:
  br label %b93
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
  br i1 %c.b65, label %b65.t109, label %b65.e110
b65.t109:
  br label %b66
b65.e110:
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
  br i1 %c.b66, label %b66.t111, label %b66.e112
b66.t111:
  br label %b67
b66.e112:
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
  br i1 %c.b67, label %b67.t113, label %b67.e114
b67.t113:
  br label %b68
b67.e114:
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
  br i1 %c.b68, label %b68.t115, label %b68.e116
b68.t115:
  br label %b69
b68.e116:
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
  br i1 %c.b69, label %b69.t117, label %b69.e118
b69.t117:
  br label %b70
b69.e118:
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
  br i1 %c.b70, label %b70.t119, label %b70.e120
b70.t119:
  br label %b71
b70.e120:
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
  br i1 %c.b71, label %b71.t121, label %b71.e122
b71.t121:
  br label %b72
b71.e122:
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
  br i1 %c.b72, label %b72.t123, label %b72.e124
b72.t123:
  br label %b73
b72.e124:
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
  br i1 %c.b73, label %b73.t125, label %b73.e126
b73.t125:
  br label %b74
b73.e126:
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
  br i1 %c.b74, label %b74.t127, label %b74.e128
b74.t127:
  br label %b75
b74.e128:
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
  br i1 %c.b75, label %b75.t129, label %b75.e130
b75.t129:
  br label %b76
b75.e130:
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
  br i1 %c.b76, label %b76.t131, label %b76.e132
b76.t131:
  br label %b77
b76.e132:
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
  br i1 %c.b77, label %b77.t133, label %b77.e134
b77.t133:
  br label %b78
b77.e134:
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
  br i1 %c.b78, label %b78.t135, label %b78.e136
b78.t135:
  br label %b79
b78.e136:
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
  br i1 %c.b79, label %b79.t137, label %b79.e138
b79.t137:
  br label %b80
b79.e138:
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
  br i1 %c.b80, label %b80.t139, label %b80.e140
b80.t139:
  br label %b81
b80.e140:
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
  br i1 %c.b81, label %b81.t141, label %b81.e142
b81.t141:
  br label %b82
b81.e142:
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
  br i1 %c.b82, label %b82.t143, label %b82.e144
b82.t143:
  br label %b83
b82.e144:
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
  br i1 %c.b83, label %b83.t145, label %b83.e146
b83.t145:
  br label %b84
b83.e146:
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
  br i1 %c.b85, label %b85.t147, label %b85.e148
b85.t147:
  br label %b86
b85.e148:
  br label %b87
b86:
  %v391 = add i64 0, 19
  %v392.c = icmp sgt i64 %v383, %v391
  %v392 = zext i1 %v392.c to i64
  %c.b86 = icmp ne i64 %v392, 0
  br i1 %c.b86, label %b86.t149, label %b86.e150
b86.t149:
  br label %b90
b86.e150:
  br label %b62
b87:
  %v393 = add i64 0, 48
  %v394.c = icmp sge i64 %v387, %v393
  %v394 = zext i1 %v394.c to i64
  %c.b87 = icmp ne i64 %v394, 0
  br i1 %c.b87, label %b87.t151, label %b87.e152
b87.t151:
  br label %b88
b87.e152:
  br label %b62
b88:
  %v395 = add i64 0, 57
  %v396.c = icmp sle i64 %v387, %v395
  %v396 = zext i1 %v396.c to i64
  %c.b88 = icmp ne i64 %v396, 0
  br i1 %c.b88, label %b88.t153, label %b88.e154
b88.t153:
  br label %b89
b88.e154:
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
  br i1 %c.b89, label %b89.t155, label %b89.e156
b89.t155:
  br label %b62
b89.e156:
  br label %b91
b90:
  br label %b62
b91:
  %v404 = add i64 0, 1
  %v405 = add i64 %v383, %v404
  br label %b85
b92:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b93:
  %v409 = add i64 0, 231
  %v410 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v409, i64 %v406)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 0)
  unreachable
}
