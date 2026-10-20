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
@"str.0" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.1" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.2" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.3" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.4" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.5" = internal constant [1 x i64] [i64 2685]
@"str.6" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.7" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.8" = internal constant [1 x i64] [i64 35899498962976]
@"str.9" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.10" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [47 x i64] [i64 5629499869757441, i64 7599824706732033, i64 5629499886534657, i64 8725724630351873, i64 5629499903311873, i64 8725724647129089, i64 7036874837196801, i64 11540474464567297, i64 3940650093379585, i64 7036874853974017, i64 11540474481344513, i64 3940650110156801, i64 7036874870751233, i64 11540474498121729, i64 3940650126934017, i64 7036874887528449, i64 11540474514898945, i64 3940650143711233, i64 7036874904305665, i64 11540474531676161, i64 3940650160488449, i64 7036874921082881, i64 11540474548453377, i64 3940650177265665, i64 4785075191283713, i64 8162774911811585, i64 2814750354309121, i64 5910975114903553, i64 10414574742274049, i64 2814750371086337, i64 5910975131680769, i64 10414574759051265, i64 2814750387863553, i64 7881300371308545, i64 2814750471749633, i64 3659175418658817, i64 1688850581684225, i64 3659175435436033, i64 5629500272410625, i64 1688850598461441, i64 3659175452213249, i64 5629500289187841, i64 1688850615238657, i64 3659175468990465, i64 5629500305965057, i64 1688850632015873, i64 7881300455194625]
@"str.11" = internal constant [1 x i64] [i64 9071397899755888]
@"str.12" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.13" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.14" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.15" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.16" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.17" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.18" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.19" = internal constant [1 x i64] [i64 544497952]
@"str.20" = internal constant [2 x i64] [i64 3346293765914783855, i64 491327221619]

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
  %v3 = getelementptr i64, ptr @"str.0", i64 0
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
  %v29 = getelementptr i64, ptr @"str.4", i64 0
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
  %v35 = getelementptr i64, ptr @"str.5", i64 0
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
  %v10 = getelementptr i64, ptr @"str.1", i64 0
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
  %v17 = getelementptr i64, ptr @"str.2", i64 0
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
  %v24 = getelementptr i64, ptr @"str.3", i64 0
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
  %v60 = getelementptr i64, ptr @"str.6", i64 0
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
  %v65 = getelementptr i64, ptr @"str.7", i64 0
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
  %v70 = getelementptr i64, ptr @"str.5", i64 0
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
  %v81 = getelementptr i64, ptr @"str.8", i64 0
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
  %v88 = getelementptr i64, ptr @"str.9", i64 0
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
  %v17 = getelementptr i64, ptr @"str.10", i64 0
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
  %v22 = getelementptr i64, ptr @"str.5", i64 0
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
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [1 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %v719 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v719, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = add i64 0, 4591870180066957722
  %v2 = add i64 0, 4596373779694328218
  %v3 = add i64 0, 4599075939470750515
  %v4 = add i64 0, 4604480259023595110
  %v5 = add i64 0, 4599075939470750515
  %v6 = add i64 0, -9223372036854775808
  %v7 = xor i64 %v5, %v6
  %v8 = add i64 0, 4592590756007337001
  %v9 = add i64 0, 4630752910647379418
  %v10 = add i64 0, 4617135373976506204
  %v11 = add i64 0, 4607902994740396687
  %v12 = add i64 0, -9223372036854775808
  %v13 = xor i64 %v11, %v12
  %v14 = add i64 0, 4592086352849071505
  %v15 = add i64 0, -9223372036854775808
  %v16 = xor i64 %v14, %v15
  %v17 = add i64 0, 4603633582293649457
  %v18 = add i64 0, 4613509976276472955
  %v19 = add i64 0, 4582862980812216730
  %v20 = add i64 0, -9223372036854775808
  %v21 = xor i64 %v19, %v20
  %v22 = add i64 0, 4585593052079010763
  %v23 = add i64 0, 4620884620666292142
  %v24 = add i64 0, 4616324726043579515
  %v25 = add i64 0, 4600931422517227160
  %v26 = add i64 0, -9223372036854775808
  %v27 = xor i64 %v25, %v26
  %v28 = add i64 0, 4607227454796291113
  %v29 = add i64 0, -9223372036854775808
  %v30 = xor i64 %v28, %v29
  %v31 = add i64 0, 4610875370494461215
  %v32 = add i64 0, 4575995892100402197
  %v33 = add i64 0, 4577659745833829962
  %v34 = add i64 0, 4623446042954359112
  %v35 = add i64 0, 4624695791850954424
  %v36 = add i64 0, -9223372036854775808
  %v37 = xor i64 %v35, %v36
  %v38 = add i64 0, 4597202442025764389
  %v39 = add i64 0, -9223372036854775808
  %v40 = xor i64 %v38, %v39
  %v41 = add i64 0, 4607542706770207048
  %v42 = add i64 0, 4605993468498391597
  %v43 = add i64 0, 4577379397905930414
  %v44 = add i64 0, -9223372036854775808
  %v45 = xor i64 %v43, %v44
  %v46 = add i64 0, 4565592097032511150
  %v47 = add i64 0, 4624842158838843965
  %v48 = add i64 0, 4627986234328701993
  %v49 = add i64 0, -9223372036854775808
  %v50 = xor i64 %v48, %v49
  %v51 = add i64 0, 4595617174956929974
  %v52 = add i64 0, 4606993267615667847
  %v53 = add i64 0, 4603525495902592565
  %v54 = add i64 0, 4585161618062026631
  %v55 = add i64 0, -9223372036854775808
  %v56 = xor i64 %v54, %v55
  %v57 = add i64 0, 4566835785178257835
  %v720 = getelementptr i64, ptr @"rt.meta", i64 0
  %v58.p = getelementptr i64, ptr %v720, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 35
  %v60 = call ptr @"rt.region_alloc"(i64 %v58, i64 %v59)
  %st0 = getelementptr i64, ptr %v60, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v60, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v60, i64 2
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v60, i64 3
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v60, i64 4
  store i64 %v7, ptr %st4
  %st5 = getelementptr i64, ptr %v60, i64 5
  store i64 %v8, ptr %st5
  %st6 = getelementptr i64, ptr %v60, i64 6
  store i64 %v9, ptr %st6
  %st7 = getelementptr i64, ptr %v60, i64 7
  store i64 %v10, ptr %st7
  %st8 = getelementptr i64, ptr %v60, i64 8
  store i64 %v13, ptr %st8
  %st9 = getelementptr i64, ptr %v60, i64 9
  store i64 %v16, ptr %st9
  %st10 = getelementptr i64, ptr %v60, i64 10
  store i64 %v17, ptr %st10
  %st11 = getelementptr i64, ptr %v60, i64 11
  store i64 %v18, ptr %st11
  %st12 = getelementptr i64, ptr %v60, i64 12
  store i64 %v21, ptr %st12
  %st13 = getelementptr i64, ptr %v60, i64 13
  store i64 %v22, ptr %st13
  %st14 = getelementptr i64, ptr %v60, i64 14
  store i64 %v23, ptr %st14
  %st15 = getelementptr i64, ptr %v60, i64 15
  store i64 %v24, ptr %st15
  %st16 = getelementptr i64, ptr %v60, i64 16
  store i64 %v27, ptr %st16
  %st17 = getelementptr i64, ptr %v60, i64 17
  store i64 %v30, ptr %st17
  %st18 = getelementptr i64, ptr %v60, i64 18
  store i64 %v31, ptr %st18
  %st19 = getelementptr i64, ptr %v60, i64 19
  store i64 %v32, ptr %st19
  %st20 = getelementptr i64, ptr %v60, i64 20
  store i64 %v33, ptr %st20
  %st21 = getelementptr i64, ptr %v60, i64 21
  store i64 %v34, ptr %st21
  %st22 = getelementptr i64, ptr %v60, i64 22
  store i64 %v37, ptr %st22
  %st23 = getelementptr i64, ptr %v60, i64 23
  store i64 %v40, ptr %st23
  %st24 = getelementptr i64, ptr %v60, i64 24
  store i64 %v41, ptr %st24
  %st25 = getelementptr i64, ptr %v60, i64 25
  store i64 %v42, ptr %st25
  %st26 = getelementptr i64, ptr %v60, i64 26
  store i64 %v45, ptr %st26
  %st27 = getelementptr i64, ptr %v60, i64 27
  store i64 %v46, ptr %st27
  %st28 = getelementptr i64, ptr %v60, i64 28
  store i64 %v47, ptr %st28
  %st29 = getelementptr i64, ptr %v60, i64 29
  store i64 %v50, ptr %st29
  %st30 = getelementptr i64, ptr %v60, i64 30
  store i64 %v51, ptr %st30
  %st31 = getelementptr i64, ptr %v60, i64 31
  store i64 %v52, ptr %st31
  %st32 = getelementptr i64, ptr %v60, i64 32
  store i64 %v53, ptr %st32
  %st33 = getelementptr i64, ptr %v60, i64 33
  store i64 %v56, ptr %st33
  %st34 = getelementptr i64, ptr %v60, i64 34
  store i64 %v57, ptr %st34
  %v61 = add i64 0, 35
  %v62 = getelementptr i64, ptr %s0, i64 0
  %v63 = ptrtoint ptr %v60 to i64
  %st35 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st35
  %st36 = getelementptr i64, ptr %v62, i64 1
  store i64 %v61, ptr %st36
  %st37 = getelementptr i64, ptr %v62, i64 2
  store i64 %v58, ptr %st37
  %v64 = getelementptr i64, ptr %s1, i64 0
  %v65.p = getelementptr i64, ptr %v62, i64 0
  %v65 = load i64, ptr %v65.p
  %st38 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st38
  %v66.p = getelementptr i64, ptr %v62, i64 1
  %v66 = load i64, ptr %v66.p
  %st39 = getelementptr i64, ptr %v64, i64 1
  store i64 %v66, ptr %st39
  %v67.p = getelementptr i64, ptr %v62, i64 2
  %v67 = load i64, ptr %v67.p
  %st40 = getelementptr i64, ptr %v64, i64 2
  store i64 %v67, ptr %st40
  %v721 = getelementptr i64, ptr @"rt.meta", i64 0
  %v68.p = getelementptr i64, ptr %v721, i64 0
  %v68 = load i64, ptr %v68.p
  %v69 = add i64 0, 0
  %v70 = add i64 0, 20
  %v71 = getelementptr i64, ptr %s2, i64 0
  %v722 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v722, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = getelementptr i64, ptr %s3, i64 0
  %st41 = getelementptr i64, ptr %v73, i64 0
  store i64 %v69, ptr %st41
  %v723 = getelementptr i64, ptr @"rt.meta", i64 0
  %v74.p = getelementptr i64, ptr %v723, i64 0
  %v74 = load i64, ptr %v74.p
  br label %b3
b1:
  %v724 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v724, i64 0
  store i64 %v68, ptr %st42
  %v725 = getelementptr i64, ptr @"rt.meta", i64 0
  %v519.p = getelementptr i64, ptr %v725, i64 0
  %v519 = load i64, ptr %v519.p
  %v520 = add i64 0, 0
  %v521.p = getelementptr i64, ptr %v64, i64 1
  %v521 = load i64, ptr %v521.p
  %v522 = getelementptr i64, ptr %s3, i64 0
  %v726 = getelementptr i64, ptr @"rt.meta", i64 0
  %v523.p = getelementptr i64, ptr %v726, i64 0
  %v523 = load i64, ptr %v523.p
  %v524 = getelementptr i64, ptr %s2, i64 0
  %st43 = getelementptr i64, ptr %v524, i64 0
  store i64 %v520, ptr %st43
  %v727 = getelementptr i64, ptr @"rt.meta", i64 0
  %v525.p = getelementptr i64, ptr %v727, i64 0
  %v525 = load i64, ptr %v525.p
  br label %b94
b2:
  br label %b1
b3:
  %v728 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v728, i64 0
  store i64 %v74, ptr %st44
  %v75.p = getelementptr i64, ptr %v73, i64 0
  %v75 = load i64, ptr %v75.p
  %v76.c = icmp slt i64 %v75, %v70
  %v76 = zext i1 %v76.c to i64
  %c.b3 = icmp ne i64 %v76, 0
  br i1 %c.b3, label %b3.t46, label %b3.e47
b3.t46:
  br label %b4
b3.e47:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v729 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v729, i64 0
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v73, i64 0
  %v78 = load i64, ptr %v78.p
  %v730 = getelementptr i64, ptr @"rt.meta", i64 0
  %v79.p = getelementptr i64, ptr %v730, i64 0
  %v79 = load i64, ptr %v79.p
  %v80 = add i64 0, 4608533498688228557
  %v81 = getelementptr i64, ptr %s4, i64 0
  %v731 = getelementptr i64, ptr @"rt.meta", i64 0
  %v82.p = getelementptr i64, ptr %v731, i64 0
  %v82 = load i64, ptr %v82.p
  %v732 = getelementptr i64, ptr @"rt.meta", i64 0
  %v83.p = getelementptr i64, ptr %v732, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 0
  %v85 = add i64 0, 5
  %v86 = getelementptr i64, ptr %s5, i64 0
  %v733 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v733, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = getelementptr i64, ptr %s6, i64 0
  %st47 = getelementptr i64, ptr %v88, i64 0
  store i64 %v84, ptr %st47
  %v734 = getelementptr i64, ptr @"rt.meta", i64 0
  %v89.p = getelementptr i64, ptr %v734, i64 0
  %v89 = load i64, ptr %v89.p
  br label %b10
b5:
  %v735 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v735, i64 0
  store i64 %v74, ptr %st48
  br label %b2
b6:
  %v736 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v736, i64 0
  store i64 %v79, ptr %st49
  %v516 = add i64 0, 1
  %v517.p = getelementptr i64, ptr %v73, i64 0
  %v517 = load i64, ptr %v517.p
  %v518 = add i64 %v517, %v516
  %st50 = getelementptr i64, ptr %v73, i64 0
  store i64 %v518, ptr %st50
  br label %b3
b7:
  br label %b6
b8:
  %v737 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v737, i64 0
  store i64 %v83, ptr %st51
  %v738 = getelementptr i64, ptr @"rt.meta", i64 0
  %v401.p = getelementptr i64, ptr %v738, i64 0
  %v401 = load i64, ptr %v401.p
  %v402 = add i64 0, 0
  %v403 = add i64 0, 5
  %v404 = getelementptr i64, ptr %s6, i64 0
  %v739 = getelementptr i64, ptr @"rt.meta", i64 0
  %v405.p = getelementptr i64, ptr %v739, i64 0
  %v405 = load i64, ptr %v405.p
  %v406 = getelementptr i64, ptr %s5, i64 0
  %st52 = getelementptr i64, ptr %v406, i64 0
  store i64 %v402, ptr %st52
  %v740 = getelementptr i64, ptr @"rt.meta", i64 0
  %v407.p = getelementptr i64, ptr %v740, i64 0
  %v407 = load i64, ptr %v407.p
  br label %b70
b9:
  br label %b8
b10:
  %v741 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v741, i64 0
  store i64 %v89, ptr %st53
  %v90.p = getelementptr i64, ptr %v88, i64 0
  %v90 = load i64, ptr %v90.p
  %v91.c = icmp slt i64 %v90, %v85
  %v91 = zext i1 %v91.c to i64
  %c.b10 = icmp ne i64 %v91, 0
  br i1 %c.b10, label %b10.t55, label %b10.e56
b10.t55:
  br label %b11
b10.e56:
  br label %b12
b11:
  call void @"rt.region_enter"()
  %v742 = getelementptr i64, ptr @"rt.meta", i64 0
  %v92.p = getelementptr i64, ptr %v742, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v88, i64 0
  %v93 = load i64, ptr %v93.p
  %v743 = getelementptr i64, ptr @"rt.meta", i64 0
  %v94.p = getelementptr i64, ptr %v743, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 0, 7
  %v96 = mul i64 %v93, %v95
  %v744 = getelementptr i64, ptr @"rt.meta", i64 0
  %v97.p = getelementptr i64, ptr %v744, i64 0
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 0, 1
  %v99 = add i64 %v93, %v98
  %v100 = add i64 0, 5
  %v101 = getelementptr i64, ptr %s7, i64 0
  %v745 = getelementptr i64, ptr @"rt.meta", i64 0
  %v102.p = getelementptr i64, ptr %v745, i64 0
  %v102 = load i64, ptr %v102.p
  %v103 = getelementptr i64, ptr %s8, i64 0
  %st56 = getelementptr i64, ptr %v103, i64 0
  store i64 %v99, ptr %st56
  %v746 = getelementptr i64, ptr @"rt.meta", i64 0
  %v104.p = getelementptr i64, ptr %v746, i64 0
  %v104 = load i64, ptr %v104.p
  br label %b16
b12:
  %v747 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v747, i64 0
  store i64 %v89, ptr %st57
  br label %b9
b13:
  %v748 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v748, i64 0
  store i64 %v94, ptr %st58
  %v398 = add i64 0, 1
  %v399.p = getelementptr i64, ptr %v88, i64 0
  %v399 = load i64, ptr %v399.p
  %v400 = add i64 %v399, %v398
  %st59 = getelementptr i64, ptr %v88, i64 0
  store i64 %v400, ptr %st59
  br label %b10
b14:
  %v749 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v749, i64 0
  store i64 %v97, ptr %st60
  br label %b13
b15:
  br label %b14
b16:
  %v750 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v750, i64 0
  store i64 %v104, ptr %st61
  %v105.p = getelementptr i64, ptr %v103, i64 0
  %v105 = load i64, ptr %v105.p
  %v106.c = icmp slt i64 %v105, %v100
  %v106 = zext i1 %v106.c to i64
  %c.b16 = icmp ne i64 %v106, 0
  br i1 %c.b16, label %b16.t63, label %b16.e64
b16.t63:
  br label %b17
b16.e64:
  br label %b18
b17:
  call void @"rt.region_enter"()
  %v751 = getelementptr i64, ptr @"rt.meta", i64 0
  %v107.p = getelementptr i64, ptr %v751, i64 0
  %v107 = load i64, ptr %v107.p
  %v108.p = getelementptr i64, ptr %v103, i64 0
  %v108 = load i64, ptr %v108.p
  %v752 = getelementptr i64, ptr @"rt.meta", i64 0
  %v109.p = getelementptr i64, ptr %v752, i64 0
  %v109 = load i64, ptr %v109.p
  %v110 = add i64 0, 7
  %v111 = mul i64 %v108, %v110
  %v112.p = getelementptr i64, ptr %v64, i64 1
  %v112 = load i64, ptr %v112.p
  %v113.c = icmp uge i64 %v96, %v112
  %v113 = zext i1 %v113.c to i64
  %c.b17 = icmp ne i64 %v113, 0
  br i1 %c.b17, label %b17.t65, label %b17.e66
b17.t65:
  br label %b20
b17.e66:
  br label %b21
b18:
  %v753 = getelementptr i64, ptr @"rt.meta", i64 0
  %st66 = getelementptr i64, ptr %v753, i64 0
  store i64 %v104, ptr %st66
  br label %b15
b19:
  %v754 = getelementptr i64, ptr @"rt.meta", i64 0
  %st67 = getelementptr i64, ptr %v754, i64 0
  store i64 %v109, ptr %st67
  %v395 = add i64 0, 1
  %v396.p = getelementptr i64, ptr %v103, i64 0
  %v396 = load i64, ptr %v396.p
  %v397 = add i64 %v396, %v395
  %st68 = getelementptr i64, ptr %v103, i64 0
  store i64 %v397, ptr %st68
  br label %b16
b20:
  %v114 = add i64 0, 0
  call void @"rt.panic"(i64 %v114)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v115.p = getelementptr i64, ptr %v64, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = inttoptr i64 %v115 to ptr
  %v117 = add i64 0, 1
  %v118 = mul i64 %v96, %v117
  %v119 = getelementptr i64, ptr %v116, i64 %v118
  %v120.p = getelementptr i64, ptr %v119, i64 0
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v64, i64 1
  %v121 = load i64, ptr %v121.p
  %v122.c = icmp uge i64 %v111, %v121
  %v122 = zext i1 %v122.c to i64
  %c.b21 = icmp ne i64 %v122, 0
  br i1 %c.b21, label %b21.t70, label %b21.e71
b21.t70:
  br label %b22
b21.e71:
  br label %b23
b22:
  %v123 = add i64 0, 1
  call void @"rt.panic"(i64 %v123)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v124.p = getelementptr i64, ptr %v64, i64 0
  %v124 = load i64, ptr %v124.p
  %v125 = inttoptr i64 %v124 to ptr
  %v126 = add i64 0, 1
  %v127 = mul i64 %v111, %v126
  %v128 = getelementptr i64, ptr %v125, i64 %v127
  %v129.p = getelementptr i64, ptr %v128, i64 0
  %v129 = load i64, ptr %v129.p
  %v130.a = bitcast i64 %v120 to double
  %v130.b = bitcast i64 %v129 to double
  %v130.f = fsub double %v130.a, %v130.b
  %v130 = bitcast double %v130.f to i64
  %v131 = add i64 0, 1
  %v132 = add i64 %v96, %v131
  %v133.p = getelementptr i64, ptr %v64, i64 1
  %v133 = load i64, ptr %v133.p
  %v134.c = icmp uge i64 %v132, %v133
  %v134 = zext i1 %v134.c to i64
  %c.b23 = icmp ne i64 %v134, 0
  br i1 %c.b23, label %b23.t72, label %b23.e73
b23.t72:
  br label %b24
b23.e73:
  br label %b25
b24:
  %v135 = add i64 0, 2
  call void @"rt.panic"(i64 %v135)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  %v136.p = getelementptr i64, ptr %v64, i64 0
  %v136 = load i64, ptr %v136.p
  %v137 = inttoptr i64 %v136 to ptr
  %v138 = add i64 0, 1
  %v139 = mul i64 %v132, %v138
  %v140 = getelementptr i64, ptr %v137, i64 %v139
  %v141.p = getelementptr i64, ptr %v140, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 0, 1
  %v143 = add i64 %v111, %v142
  %v144.p = getelementptr i64, ptr %v64, i64 1
  %v144 = load i64, ptr %v144.p
  %v145.c = icmp uge i64 %v143, %v144
  %v145 = zext i1 %v145.c to i64
  %c.b25 = icmp ne i64 %v145, 0
  br i1 %c.b25, label %b25.t74, label %b25.e75
b25.t74:
  br label %b26
b25.e75:
  br label %b27
b26:
  %v146 = add i64 0, 3
  call void @"rt.panic"(i64 %v146)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v147.p = getelementptr i64, ptr %v64, i64 0
  %v147 = load i64, ptr %v147.p
  %v148 = inttoptr i64 %v147 to ptr
  %v149 = add i64 0, 1
  %v150 = mul i64 %v143, %v149
  %v151 = getelementptr i64, ptr %v148, i64 %v150
  %v152.p = getelementptr i64, ptr %v151, i64 0
  %v152 = load i64, ptr %v152.p
  %v153.a = bitcast i64 %v141 to double
  %v153.b = bitcast i64 %v152 to double
  %v153.f = fsub double %v153.a, %v153.b
  %v153 = bitcast double %v153.f to i64
  %v154 = add i64 0, 2
  %v155 = add i64 %v96, %v154
  %v156.p = getelementptr i64, ptr %v64, i64 1
  %v156 = load i64, ptr %v156.p
  %v157.c = icmp uge i64 %v155, %v156
  %v157 = zext i1 %v157.c to i64
  %c.b27 = icmp ne i64 %v157, 0
  br i1 %c.b27, label %b27.t76, label %b27.e77
b27.t76:
  br label %b28
b27.e77:
  br label %b29
b28:
  %v158 = add i64 0, 4
  call void @"rt.panic"(i64 %v158)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b29:
  %v159.p = getelementptr i64, ptr %v64, i64 0
  %v159 = load i64, ptr %v159.p
  %v160 = inttoptr i64 %v159 to ptr
  %v161 = add i64 0, 1
  %v162 = mul i64 %v155, %v161
  %v163 = getelementptr i64, ptr %v160, i64 %v162
  %v164.p = getelementptr i64, ptr %v163, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 0, 2
  %v166 = add i64 %v111, %v165
  %v167.p = getelementptr i64, ptr %v64, i64 1
  %v167 = load i64, ptr %v167.p
  %v168.c = icmp uge i64 %v166, %v167
  %v168 = zext i1 %v168.c to i64
  %c.b29 = icmp ne i64 %v168, 0
  br i1 %c.b29, label %b29.t78, label %b29.e79
b29.t78:
  br label %b30
b29.e79:
  br label %b31
b30:
  %v169 = add i64 0, 5
  call void @"rt.panic"(i64 %v169)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b31:
  %v170.p = getelementptr i64, ptr %v64, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = inttoptr i64 %v170 to ptr
  %v172 = add i64 0, 1
  %v173 = mul i64 %v166, %v172
  %v174 = getelementptr i64, ptr %v171, i64 %v173
  %v175.p = getelementptr i64, ptr %v174, i64 0
  %v175 = load i64, ptr %v175.p
  %v176.a = bitcast i64 %v164 to double
  %v176.b = bitcast i64 %v175 to double
  %v176.f = fsub double %v176.a, %v176.b
  %v176 = bitcast double %v176.f to i64
  %v177.a = bitcast i64 %v130 to double
  %v177.b = bitcast i64 %v130 to double
  %v177.f = fmul double %v177.a, %v177.b
  %v177 = bitcast double %v177.f to i64
  %v178.a = bitcast i64 %v153 to double
  %v178.b = bitcast i64 %v153 to double
  %v178.f = fmul double %v178.a, %v178.b
  %v178 = bitcast double %v178.f to i64
  %v179.a = bitcast i64 %v177 to double
  %v179.b = bitcast i64 %v178 to double
  %v179.f = fadd double %v179.a, %v179.b
  %v179 = bitcast double %v179.f to i64
  %v180.a = bitcast i64 %v176 to double
  %v180.b = bitcast i64 %v176 to double
  %v180.f = fmul double %v180.a, %v180.b
  %v180 = bitcast double %v180.f to i64
  %v181.a = bitcast i64 %v179 to double
  %v181.b = bitcast i64 %v180 to double
  %v181.f = fadd double %v181.a, %v181.b
  %v181 = bitcast double %v181.f to i64
  %v182 = call i64 @"std/math.Sqrt"(i64 %v181)
  %v183.a = bitcast i64 %v181 to double
  %v183.b = bitcast i64 %v182 to double
  %v183.f = fmul double %v183.a, %v183.b
  %v183 = bitcast double %v183.f to i64
  %v184.a = bitcast i64 %v80 to double
  %v184.b = bitcast i64 %v183 to double
  %v184.f = fdiv double %v184.a, %v184.b
  %v184 = bitcast double %v184.f to i64
  %v185 = add i64 0, 3
  %v186 = add i64 %v96, %v185
  %v187 = add i64 0, 3
  %v188 = add i64 %v96, %v187
  %v189.p = getelementptr i64, ptr %v64, i64 1
  %v189 = load i64, ptr %v189.p
  %v190.c = icmp uge i64 %v188, %v189
  %v190 = zext i1 %v190.c to i64
  %c.b31 = icmp ne i64 %v190, 0
  br i1 %c.b31, label %b31.t80, label %b31.e81
b31.t80:
  br label %b32
b31.e81:
  br label %b33
b32:
  %v191 = add i64 0, 6
  call void @"rt.panic"(i64 %v191)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b33:
  %v192.p = getelementptr i64, ptr %v64, i64 0
  %v192 = load i64, ptr %v192.p
  %v193 = inttoptr i64 %v192 to ptr
  %v194 = add i64 0, 1
  %v195 = mul i64 %v188, %v194
  %v196 = getelementptr i64, ptr %v193, i64 %v195
  %v197.p = getelementptr i64, ptr %v196, i64 0
  %v197 = load i64, ptr %v197.p
  %v198 = add i64 0, 6
  %v199 = add i64 %v111, %v198
  %v200.p = getelementptr i64, ptr %v64, i64 1
  %v200 = load i64, ptr %v200.p
  %v201.c = icmp uge i64 %v199, %v200
  %v201 = zext i1 %v201.c to i64
  %c.b33 = icmp ne i64 %v201, 0
  br i1 %c.b33, label %b33.t82, label %b33.e83
b33.t82:
  br label %b34
b33.e83:
  br label %b35
b34:
  %v202 = add i64 0, 7
  call void @"rt.panic"(i64 %v202)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b35:
  %v203.p = getelementptr i64, ptr %v64, i64 0
  %v203 = load i64, ptr %v203.p
  %v204 = inttoptr i64 %v203 to ptr
  %v205 = add i64 0, 1
  %v206 = mul i64 %v199, %v205
  %v207 = getelementptr i64, ptr %v204, i64 %v206
  %v208.p = getelementptr i64, ptr %v207, i64 0
  %v208 = load i64, ptr %v208.p
  %v209.a = bitcast i64 %v130 to double
  %v209.b = bitcast i64 %v208 to double
  %v209.f = fmul double %v209.a, %v209.b
  %v209 = bitcast double %v209.f to i64
  %v210.a = bitcast i64 %v209 to double
  %v210.b = bitcast i64 %v184 to double
  %v210.f = fmul double %v210.a, %v210.b
  %v210 = bitcast double %v210.f to i64
  %v211.a = bitcast i64 %v197 to double
  %v211.b = bitcast i64 %v210 to double
  %v211.f = fsub double %v211.a, %v211.b
  %v211 = bitcast double %v211.f to i64
  %v212.p = getelementptr i64, ptr %v64, i64 1
  %v212 = load i64, ptr %v212.p
  %v213.c = icmp uge i64 %v186, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b35 = icmp ne i64 %v213, 0
  br i1 %c.b35, label %b35.t84, label %b35.e85
b35.t84:
  br label %b36
b35.e85:
  br label %b37
b36:
  %v214 = add i64 0, 8
  call void @"rt.panic"(i64 %v214)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b37:
  %v215.p = getelementptr i64, ptr %v64, i64 0
  %v215 = load i64, ptr %v215.p
  %v216 = inttoptr i64 %v215 to ptr
  %v217 = add i64 0, 1
  %v218 = mul i64 %v186, %v217
  %v219 = getelementptr i64, ptr %v216, i64 %v218
  %st85 = getelementptr i64, ptr %v219, i64 0
  store i64 %v211, ptr %st85
  %v220 = add i64 0, 4
  %v221 = add i64 %v96, %v220
  %v222 = add i64 0, 4
  %v223 = add i64 %v96, %v222
  %v224.p = getelementptr i64, ptr %v64, i64 1
  %v224 = load i64, ptr %v224.p
  %v225.c = icmp uge i64 %v223, %v224
  %v225 = zext i1 %v225.c to i64
  %c.b37 = icmp ne i64 %v225, 0
  br i1 %c.b37, label %b37.t87, label %b37.e88
b37.t87:
  br label %b38
b37.e88:
  br label %b39
b38:
  %v226 = add i64 0, 9
  call void @"rt.panic"(i64 %v226)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b39:
  %v227.p = getelementptr i64, ptr %v64, i64 0
  %v227 = load i64, ptr %v227.p
  %v228 = inttoptr i64 %v227 to ptr
  %v229 = add i64 0, 1
  %v230 = mul i64 %v223, %v229
  %v231 = getelementptr i64, ptr %v228, i64 %v230
  %v232.p = getelementptr i64, ptr %v231, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = add i64 0, 6
  %v234 = add i64 %v111, %v233
  %v235.p = getelementptr i64, ptr %v64, i64 1
  %v235 = load i64, ptr %v235.p
  %v236.c = icmp uge i64 %v234, %v235
  %v236 = zext i1 %v236.c to i64
  %c.b39 = icmp ne i64 %v236, 0
  br i1 %c.b39, label %b39.t89, label %b39.e90
b39.t89:
  br label %b40
b39.e90:
  br label %b41
b40:
  %v237 = add i64 0, 10
  call void @"rt.panic"(i64 %v237)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b41:
  %v238.p = getelementptr i64, ptr %v64, i64 0
  %v238 = load i64, ptr %v238.p
  %v239 = inttoptr i64 %v238 to ptr
  %v240 = add i64 0, 1
  %v241 = mul i64 %v234, %v240
  %v242 = getelementptr i64, ptr %v239, i64 %v241
  %v243.p = getelementptr i64, ptr %v242, i64 0
  %v243 = load i64, ptr %v243.p
  %v244.a = bitcast i64 %v153 to double
  %v244.b = bitcast i64 %v243 to double
  %v244.f = fmul double %v244.a, %v244.b
  %v244 = bitcast double %v244.f to i64
  %v245.a = bitcast i64 %v244 to double
  %v245.b = bitcast i64 %v184 to double
  %v245.f = fmul double %v245.a, %v245.b
  %v245 = bitcast double %v245.f to i64
  %v246.a = bitcast i64 %v232 to double
  %v246.b = bitcast i64 %v245 to double
  %v246.f = fsub double %v246.a, %v246.b
  %v246 = bitcast double %v246.f to i64
  %v247.p = getelementptr i64, ptr %v64, i64 1
  %v247 = load i64, ptr %v247.p
  %v248.c = icmp uge i64 %v221, %v247
  %v248 = zext i1 %v248.c to i64
  %c.b41 = icmp ne i64 %v248, 0
  br i1 %c.b41, label %b41.t91, label %b41.e92
b41.t91:
  br label %b42
b41.e92:
  br label %b43
b42:
  %v249 = add i64 0, 11
  call void @"rt.panic"(i64 %v249)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b43:
  %v250.p = getelementptr i64, ptr %v64, i64 0
  %v250 = load i64, ptr %v250.p
  %v251 = inttoptr i64 %v250 to ptr
  %v252 = add i64 0, 1
  %v253 = mul i64 %v221, %v252
  %v254 = getelementptr i64, ptr %v251, i64 %v253
  %st92 = getelementptr i64, ptr %v254, i64 0
  store i64 %v246, ptr %st92
  %v255 = add i64 0, 5
  %v256 = add i64 %v96, %v255
  %v257 = add i64 0, 5
  %v258 = add i64 %v96, %v257
  %v259.p = getelementptr i64, ptr %v64, i64 1
  %v259 = load i64, ptr %v259.p
  %v260.c = icmp uge i64 %v258, %v259
  %v260 = zext i1 %v260.c to i64
  %c.b43 = icmp ne i64 %v260, 0
  br i1 %c.b43, label %b43.t94, label %b43.e95
b43.t94:
  br label %b44
b43.e95:
  br label %b45
b44:
  %v261 = add i64 0, 12
  call void @"rt.panic"(i64 %v261)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b45:
  %v262.p = getelementptr i64, ptr %v64, i64 0
  %v262 = load i64, ptr %v262.p
  %v263 = inttoptr i64 %v262 to ptr
  %v264 = add i64 0, 1
  %v265 = mul i64 %v258, %v264
  %v266 = getelementptr i64, ptr %v263, i64 %v265
  %v267.p = getelementptr i64, ptr %v266, i64 0
  %v267 = load i64, ptr %v267.p
  %v268 = add i64 0, 6
  %v269 = add i64 %v111, %v268
  %v270.p = getelementptr i64, ptr %v64, i64 1
  %v270 = load i64, ptr %v270.p
  %v271.c = icmp uge i64 %v269, %v270
  %v271 = zext i1 %v271.c to i64
  %c.b45 = icmp ne i64 %v271, 0
  br i1 %c.b45, label %b45.t96, label %b45.e97
b45.t96:
  br label %b46
b45.e97:
  br label %b47
b46:
  %v272 = add i64 0, 13
  call void @"rt.panic"(i64 %v272)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v273.p = getelementptr i64, ptr %v64, i64 0
  %v273 = load i64, ptr %v273.p
  %v274 = inttoptr i64 %v273 to ptr
  %v275 = add i64 0, 1
  %v276 = mul i64 %v269, %v275
  %v277 = getelementptr i64, ptr %v274, i64 %v276
  %v278.p = getelementptr i64, ptr %v277, i64 0
  %v278 = load i64, ptr %v278.p
  %v279.a = bitcast i64 %v176 to double
  %v279.b = bitcast i64 %v278 to double
  %v279.f = fmul double %v279.a, %v279.b
  %v279 = bitcast double %v279.f to i64
  %v280.a = bitcast i64 %v279 to double
  %v280.b = bitcast i64 %v184 to double
  %v280.f = fmul double %v280.a, %v280.b
  %v280 = bitcast double %v280.f to i64
  %v281.a = bitcast i64 %v267 to double
  %v281.b = bitcast i64 %v280 to double
  %v281.f = fsub double %v281.a, %v281.b
  %v281 = bitcast double %v281.f to i64
  %v282.p = getelementptr i64, ptr %v64, i64 1
  %v282 = load i64, ptr %v282.p
  %v283.c = icmp uge i64 %v256, %v282
  %v283 = zext i1 %v283.c to i64
  %c.b47 = icmp ne i64 %v283, 0
  br i1 %c.b47, label %b47.t98, label %b47.e99
b47.t98:
  br label %b48
b47.e99:
  br label %b49
b48:
  %v284 = add i64 0, 14
  call void @"rt.panic"(i64 %v284)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b49:
  %v285.p = getelementptr i64, ptr %v64, i64 0
  %v285 = load i64, ptr %v285.p
  %v286 = inttoptr i64 %v285 to ptr
  %v287 = add i64 0, 1
  %v288 = mul i64 %v256, %v287
  %v289 = getelementptr i64, ptr %v286, i64 %v288
  %st99 = getelementptr i64, ptr %v289, i64 0
  store i64 %v281, ptr %st99
  %v290 = add i64 0, 3
  %v291 = add i64 %v111, %v290
  %v292 = add i64 0, 3
  %v293 = add i64 %v111, %v292
  %v294.p = getelementptr i64, ptr %v64, i64 1
  %v294 = load i64, ptr %v294.p
  %v295.c = icmp uge i64 %v293, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b49 = icmp ne i64 %v295, 0
  br i1 %c.b49, label %b49.t101, label %b49.e102
b49.t101:
  br label %b50
b49.e102:
  br label %b51
b50:
  %v296 = add i64 0, 15
  call void @"rt.panic"(i64 %v296)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v297.p = getelementptr i64, ptr %v64, i64 0
  %v297 = load i64, ptr %v297.p
  %v298 = inttoptr i64 %v297 to ptr
  %v299 = add i64 0, 1
  %v300 = mul i64 %v293, %v299
  %v301 = getelementptr i64, ptr %v298, i64 %v300
  %v302.p = getelementptr i64, ptr %v301, i64 0
  %v302 = load i64, ptr %v302.p
  %v303 = add i64 0, 6
  %v304 = add i64 %v96, %v303
  %v305.p = getelementptr i64, ptr %v64, i64 1
  %v305 = load i64, ptr %v305.p
  %v306.c = icmp uge i64 %v304, %v305
  %v306 = zext i1 %v306.c to i64
  %c.b51 = icmp ne i64 %v306, 0
  br i1 %c.b51, label %b51.t103, label %b51.e104
b51.t103:
  br label %b52
b51.e104:
  br label %b53
b52:
  %v307 = add i64 0, 16
  call void @"rt.panic"(i64 %v307)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b53:
  %v308.p = getelementptr i64, ptr %v64, i64 0
  %v308 = load i64, ptr %v308.p
  %v309 = inttoptr i64 %v308 to ptr
  %v310 = add i64 0, 1
  %v311 = mul i64 %v304, %v310
  %v312 = getelementptr i64, ptr %v309, i64 %v311
  %v313.p = getelementptr i64, ptr %v312, i64 0
  %v313 = load i64, ptr %v313.p
  %v314.a = bitcast i64 %v130 to double
  %v314.b = bitcast i64 %v313 to double
  %v314.f = fmul double %v314.a, %v314.b
  %v314 = bitcast double %v314.f to i64
  %v315.a = bitcast i64 %v314 to double
  %v315.b = bitcast i64 %v184 to double
  %v315.f = fmul double %v315.a, %v315.b
  %v315 = bitcast double %v315.f to i64
  %v316.a = bitcast i64 %v302 to double
  %v316.b = bitcast i64 %v315 to double
  %v316.f = fadd double %v316.a, %v316.b
  %v316 = bitcast double %v316.f to i64
  %v317.p = getelementptr i64, ptr %v64, i64 1
  %v317 = load i64, ptr %v317.p
  %v318.c = icmp uge i64 %v291, %v317
  %v318 = zext i1 %v318.c to i64
  %c.b53 = icmp ne i64 %v318, 0
  br i1 %c.b53, label %b53.t105, label %b53.e106
b53.t105:
  br label %b54
b53.e106:
  br label %b55
b54:
  %v319 = add i64 0, 17
  call void @"rt.panic"(i64 %v319)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b55:
  %v320.p = getelementptr i64, ptr %v64, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = inttoptr i64 %v320 to ptr
  %v322 = add i64 0, 1
  %v323 = mul i64 %v291, %v322
  %v324 = getelementptr i64, ptr %v321, i64 %v323
  %st106 = getelementptr i64, ptr %v324, i64 0
  store i64 %v316, ptr %st106
  %v325 = add i64 0, 4
  %v326 = add i64 %v111, %v325
  %v327 = add i64 0, 4
  %v328 = add i64 %v111, %v327
  %v329.p = getelementptr i64, ptr %v64, i64 1
  %v329 = load i64, ptr %v329.p
  %v330.c = icmp uge i64 %v328, %v329
  %v330 = zext i1 %v330.c to i64
  %c.b55 = icmp ne i64 %v330, 0
  br i1 %c.b55, label %b55.t108, label %b55.e109
b55.t108:
  br label %b56
b55.e109:
  br label %b57
b56:
  %v331 = add i64 0, 18
  call void @"rt.panic"(i64 %v331)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b57:
  %v332.p = getelementptr i64, ptr %v64, i64 0
  %v332 = load i64, ptr %v332.p
  %v333 = inttoptr i64 %v332 to ptr
  %v334 = add i64 0, 1
  %v335 = mul i64 %v328, %v334
  %v336 = getelementptr i64, ptr %v333, i64 %v335
  %v337.p = getelementptr i64, ptr %v336, i64 0
  %v337 = load i64, ptr %v337.p
  %v338 = add i64 0, 6
  %v339 = add i64 %v96, %v338
  %v340.p = getelementptr i64, ptr %v64, i64 1
  %v340 = load i64, ptr %v340.p
  %v341.c = icmp uge i64 %v339, %v340
  %v341 = zext i1 %v341.c to i64
  %c.b57 = icmp ne i64 %v341, 0
  br i1 %c.b57, label %b57.t110, label %b57.e111
b57.t110:
  br label %b58
b57.e111:
  br label %b59
b58:
  %v342 = add i64 0, 19
  call void @"rt.panic"(i64 %v342)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b59:
  %v343.p = getelementptr i64, ptr %v64, i64 0
  %v343 = load i64, ptr %v343.p
  %v344 = inttoptr i64 %v343 to ptr
  %v345 = add i64 0, 1
  %v346 = mul i64 %v339, %v345
  %v347 = getelementptr i64, ptr %v344, i64 %v346
  %v348.p = getelementptr i64, ptr %v347, i64 0
  %v348 = load i64, ptr %v348.p
  %v349.a = bitcast i64 %v153 to double
  %v349.b = bitcast i64 %v348 to double
  %v349.f = fmul double %v349.a, %v349.b
  %v349 = bitcast double %v349.f to i64
  %v350.a = bitcast i64 %v349 to double
  %v350.b = bitcast i64 %v184 to double
  %v350.f = fmul double %v350.a, %v350.b
  %v350 = bitcast double %v350.f to i64
  %v351.a = bitcast i64 %v337 to double
  %v351.b = bitcast i64 %v350 to double
  %v351.f = fadd double %v351.a, %v351.b
  %v351 = bitcast double %v351.f to i64
  %v352.p = getelementptr i64, ptr %v64, i64 1
  %v352 = load i64, ptr %v352.p
  %v353.c = icmp uge i64 %v326, %v352
  %v353 = zext i1 %v353.c to i64
  %c.b59 = icmp ne i64 %v353, 0
  br i1 %c.b59, label %b59.t112, label %b59.e113
b59.t112:
  br label %b60
b59.e113:
  br label %b61
b60:
  %v354 = add i64 0, 20
  call void @"rt.panic"(i64 %v354)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b61:
  %v355.p = getelementptr i64, ptr %v64, i64 0
  %v355 = load i64, ptr %v355.p
  %v356 = inttoptr i64 %v355 to ptr
  %v357 = add i64 0, 1
  %v358 = mul i64 %v326, %v357
  %v359 = getelementptr i64, ptr %v356, i64 %v358
  %st113 = getelementptr i64, ptr %v359, i64 0
  store i64 %v351, ptr %st113
  %v360 = add i64 0, 5
  %v361 = add i64 %v111, %v360
  %v362 = add i64 0, 5
  %v363 = add i64 %v111, %v362
  %v364.p = getelementptr i64, ptr %v64, i64 1
  %v364 = load i64, ptr %v364.p
  %v365.c = icmp uge i64 %v363, %v364
  %v365 = zext i1 %v365.c to i64
  %c.b61 = icmp ne i64 %v365, 0
  br i1 %c.b61, label %b61.t115, label %b61.e116
b61.t115:
  br label %b62
b61.e116:
  br label %b63
b62:
  %v366 = add i64 0, 21
  call void @"rt.panic"(i64 %v366)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b63:
  %v367.p = getelementptr i64, ptr %v64, i64 0
  %v367 = load i64, ptr %v367.p
  %v368 = inttoptr i64 %v367 to ptr
  %v369 = add i64 0, 1
  %v370 = mul i64 %v363, %v369
  %v371 = getelementptr i64, ptr %v368, i64 %v370
  %v372.p = getelementptr i64, ptr %v371, i64 0
  %v372 = load i64, ptr %v372.p
  %v373 = add i64 0, 6
  %v374 = add i64 %v96, %v373
  %v375.p = getelementptr i64, ptr %v64, i64 1
  %v375 = load i64, ptr %v375.p
  %v376.c = icmp uge i64 %v374, %v375
  %v376 = zext i1 %v376.c to i64
  %c.b63 = icmp ne i64 %v376, 0
  br i1 %c.b63, label %b63.t117, label %b63.e118
b63.t117:
  br label %b64
b63.e118:
  br label %b65
b64:
  %v377 = add i64 0, 22
  call void @"rt.panic"(i64 %v377)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b65:
  %v378.p = getelementptr i64, ptr %v64, i64 0
  %v378 = load i64, ptr %v378.p
  %v379 = inttoptr i64 %v378 to ptr
  %v380 = add i64 0, 1
  %v381 = mul i64 %v374, %v380
  %v382 = getelementptr i64, ptr %v379, i64 %v381
  %v383.p = getelementptr i64, ptr %v382, i64 0
  %v383 = load i64, ptr %v383.p
  %v384.a = bitcast i64 %v176 to double
  %v384.b = bitcast i64 %v383 to double
  %v384.f = fmul double %v384.a, %v384.b
  %v384 = bitcast double %v384.f to i64
  %v385.a = bitcast i64 %v384 to double
  %v385.b = bitcast i64 %v184 to double
  %v385.f = fmul double %v385.a, %v385.b
  %v385 = bitcast double %v385.f to i64
  %v386.a = bitcast i64 %v372 to double
  %v386.b = bitcast i64 %v385 to double
  %v386.f = fadd double %v386.a, %v386.b
  %v386 = bitcast double %v386.f to i64
  %v387.p = getelementptr i64, ptr %v64, i64 1
  %v387 = load i64, ptr %v387.p
  %v388.c = icmp uge i64 %v361, %v387
  %v388 = zext i1 %v388.c to i64
  %c.b65 = icmp ne i64 %v388, 0
  br i1 %c.b65, label %b65.t119, label %b65.e120
b65.t119:
  br label %b66
b65.e120:
  br label %b67
b66:
  %v389 = add i64 0, 23
  call void @"rt.panic"(i64 %v389)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b67:
  %v390.p = getelementptr i64, ptr %v64, i64 0
  %v390 = load i64, ptr %v390.p
  %v391 = inttoptr i64 %v390 to ptr
  %v392 = add i64 0, 1
  %v393 = mul i64 %v361, %v392
  %v394 = getelementptr i64, ptr %v391, i64 %v393
  %st120 = getelementptr i64, ptr %v394, i64 0
  store i64 %v386, ptr %st120
  br label %b19
b68:
  %v755 = getelementptr i64, ptr @"rt.meta", i64 0
  %st121 = getelementptr i64, ptr %v755, i64 0
  store i64 %v401, ptr %st121
  br label %b7
b69:
  br label %b68
b70:
  %v756 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v756, i64 0
  store i64 %v407, ptr %st122
  %v408.p = getelementptr i64, ptr %v406, i64 0
  %v408 = load i64, ptr %v408.p
  %v409.c = icmp slt i64 %v408, %v403
  %v409 = zext i1 %v409.c to i64
  %c.b70 = icmp ne i64 %v409, 0
  br i1 %c.b70, label %b70.t124, label %b70.e125
b70.t124:
  br label %b71
b70.e125:
  br label %b72
b71:
  call void @"rt.region_enter"()
  %v757 = getelementptr i64, ptr @"rt.meta", i64 0
  %v410.p = getelementptr i64, ptr %v757, i64 0
  %v410 = load i64, ptr %v410.p
  %v411.p = getelementptr i64, ptr %v406, i64 0
  %v411 = load i64, ptr %v411.p
  %v758 = getelementptr i64, ptr @"rt.meta", i64 0
  %v412.p = getelementptr i64, ptr %v758, i64 0
  %v412 = load i64, ptr %v412.p
  %v413 = add i64 0, 7
  %v414 = mul i64 %v411, %v413
  %v415.p = getelementptr i64, ptr %v64, i64 1
  %v415 = load i64, ptr %v415.p
  %v416.c = icmp uge i64 %v414, %v415
  %v416 = zext i1 %v416.c to i64
  %c.b71 = icmp ne i64 %v416, 0
  br i1 %c.b71, label %b71.t126, label %b71.e127
b71.t126:
  br label %b74
b71.e127:
  br label %b75
b72:
  %v759 = getelementptr i64, ptr @"rt.meta", i64 0
  %st127 = getelementptr i64, ptr %v759, i64 0
  store i64 %v407, ptr %st127
  br label %b69
b73:
  %v760 = getelementptr i64, ptr @"rt.meta", i64 0
  %st128 = getelementptr i64, ptr %v760, i64 0
  store i64 %v412, ptr %st128
  %v513 = add i64 0, 1
  %v514.p = getelementptr i64, ptr %v406, i64 0
  %v514 = load i64, ptr %v514.p
  %v515 = add i64 %v514, %v513
  %st129 = getelementptr i64, ptr %v406, i64 0
  store i64 %v515, ptr %st129
  br label %b70
b74:
  %v417 = add i64 0, 24
  call void @"rt.panic"(i64 %v417)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b75:
  %v418.p = getelementptr i64, ptr %v64, i64 0
  %v418 = load i64, ptr %v418.p
  %v419 = inttoptr i64 %v418 to ptr
  %v420 = add i64 0, 1
  %v421 = mul i64 %v414, %v420
  %v422 = getelementptr i64, ptr %v419, i64 %v421
  %v423.p = getelementptr i64, ptr %v422, i64 0
  %v423 = load i64, ptr %v423.p
  %v424 = add i64 0, 3
  %v425 = add i64 %v414, %v424
  %v426.p = getelementptr i64, ptr %v64, i64 1
  %v426 = load i64, ptr %v426.p
  %v427.c = icmp uge i64 %v425, %v426
  %v427 = zext i1 %v427.c to i64
  %c.b75 = icmp ne i64 %v427, 0
  br i1 %c.b75, label %b75.t131, label %b75.e132
b75.t131:
  br label %b76
b75.e132:
  br label %b77
b76:
  %v428 = add i64 0, 25
  call void @"rt.panic"(i64 %v428)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b77:
  %v429.p = getelementptr i64, ptr %v64, i64 0
  %v429 = load i64, ptr %v429.p
  %v430 = inttoptr i64 %v429 to ptr
  %v431 = add i64 0, 1
  %v432 = mul i64 %v425, %v431
  %v433 = getelementptr i64, ptr %v430, i64 %v432
  %v434.p = getelementptr i64, ptr %v433, i64 0
  %v434 = load i64, ptr %v434.p
  %v435.a = bitcast i64 %v80 to double
  %v435.b = bitcast i64 %v434 to double
  %v435.f = fmul double %v435.a, %v435.b
  %v435 = bitcast double %v435.f to i64
  %v436.a = bitcast i64 %v423 to double
  %v436.b = bitcast i64 %v435 to double
  %v436.f = fadd double %v436.a, %v436.b
  %v436 = bitcast double %v436.f to i64
  %v437.p = getelementptr i64, ptr %v64, i64 1
  %v437 = load i64, ptr %v437.p
  %v438.c = icmp uge i64 %v414, %v437
  %v438 = zext i1 %v438.c to i64
  %c.b77 = icmp ne i64 %v438, 0
  br i1 %c.b77, label %b77.t133, label %b77.e134
b77.t133:
  br label %b78
b77.e134:
  br label %b79
b78:
  %v439 = add i64 0, 26
  call void @"rt.panic"(i64 %v439)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b79:
  %v440.p = getelementptr i64, ptr %v64, i64 0
  %v440 = load i64, ptr %v440.p
  %v441 = inttoptr i64 %v440 to ptr
  %v442 = add i64 0, 1
  %v443 = mul i64 %v414, %v442
  %v444 = getelementptr i64, ptr %v441, i64 %v443
  %st134 = getelementptr i64, ptr %v444, i64 0
  store i64 %v436, ptr %st134
  %v445 = add i64 0, 1
  %v446 = add i64 %v414, %v445
  %v447 = add i64 0, 1
  %v448 = add i64 %v414, %v447
  %v449.p = getelementptr i64, ptr %v64, i64 1
  %v449 = load i64, ptr %v449.p
  %v450.c = icmp uge i64 %v448, %v449
  %v450 = zext i1 %v450.c to i64
  %c.b79 = icmp ne i64 %v450, 0
  br i1 %c.b79, label %b79.t136, label %b79.e137
b79.t136:
  br label %b80
b79.e137:
  br label %b81
b80:
  %v451 = add i64 0, 27
  call void @"rt.panic"(i64 %v451)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b81:
  %v452.p = getelementptr i64, ptr %v64, i64 0
  %v452 = load i64, ptr %v452.p
  %v453 = inttoptr i64 %v452 to ptr
  %v454 = add i64 0, 1
  %v455 = mul i64 %v448, %v454
  %v456 = getelementptr i64, ptr %v453, i64 %v455
  %v457.p = getelementptr i64, ptr %v456, i64 0
  %v457 = load i64, ptr %v457.p
  %v458 = add i64 0, 4
  %v459 = add i64 %v414, %v458
  %v460.p = getelementptr i64, ptr %v64, i64 1
  %v460 = load i64, ptr %v460.p
  %v461.c = icmp uge i64 %v459, %v460
  %v461 = zext i1 %v461.c to i64
  %c.b81 = icmp ne i64 %v461, 0
  br i1 %c.b81, label %b81.t138, label %b81.e139
b81.t138:
  br label %b82
b81.e139:
  br label %b83
b82:
  %v462 = add i64 0, 28
  call void @"rt.panic"(i64 %v462)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b83:
  %v463.p = getelementptr i64, ptr %v64, i64 0
  %v463 = load i64, ptr %v463.p
  %v464 = inttoptr i64 %v463 to ptr
  %v465 = add i64 0, 1
  %v466 = mul i64 %v459, %v465
  %v467 = getelementptr i64, ptr %v464, i64 %v466
  %v468.p = getelementptr i64, ptr %v467, i64 0
  %v468 = load i64, ptr %v468.p
  %v469.a = bitcast i64 %v80 to double
  %v469.b = bitcast i64 %v468 to double
  %v469.f = fmul double %v469.a, %v469.b
  %v469 = bitcast double %v469.f to i64
  %v470.a = bitcast i64 %v457 to double
  %v470.b = bitcast i64 %v469 to double
  %v470.f = fadd double %v470.a, %v470.b
  %v470 = bitcast double %v470.f to i64
  %v471.p = getelementptr i64, ptr %v64, i64 1
  %v471 = load i64, ptr %v471.p
  %v472.c = icmp uge i64 %v446, %v471
  %v472 = zext i1 %v472.c to i64
  %c.b83 = icmp ne i64 %v472, 0
  br i1 %c.b83, label %b83.t140, label %b83.e141
b83.t140:
  br label %b84
b83.e141:
  br label %b85
b84:
  %v473 = add i64 0, 29
  call void @"rt.panic"(i64 %v473)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b85:
  %v474.p = getelementptr i64, ptr %v64, i64 0
  %v474 = load i64, ptr %v474.p
  %v475 = inttoptr i64 %v474 to ptr
  %v476 = add i64 0, 1
  %v477 = mul i64 %v446, %v476
  %v478 = getelementptr i64, ptr %v475, i64 %v477
  %st141 = getelementptr i64, ptr %v478, i64 0
  store i64 %v470, ptr %st141
  %v479 = add i64 0, 2
  %v480 = add i64 %v414, %v479
  %v481 = add i64 0, 2
  %v482 = add i64 %v414, %v481
  %v483.p = getelementptr i64, ptr %v64, i64 1
  %v483 = load i64, ptr %v483.p
  %v484.c = icmp uge i64 %v482, %v483
  %v484 = zext i1 %v484.c to i64
  %c.b85 = icmp ne i64 %v484, 0
  br i1 %c.b85, label %b85.t143, label %b85.e144
b85.t143:
  br label %b86
b85.e144:
  br label %b87
b86:
  %v485 = add i64 0, 30
  call void @"rt.panic"(i64 %v485)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b87:
  %v486.p = getelementptr i64, ptr %v64, i64 0
  %v486 = load i64, ptr %v486.p
  %v487 = inttoptr i64 %v486 to ptr
  %v488 = add i64 0, 1
  %v489 = mul i64 %v482, %v488
  %v490 = getelementptr i64, ptr %v487, i64 %v489
  %v491.p = getelementptr i64, ptr %v490, i64 0
  %v491 = load i64, ptr %v491.p
  %v492 = add i64 0, 5
  %v493 = add i64 %v414, %v492
  %v494.p = getelementptr i64, ptr %v64, i64 1
  %v494 = load i64, ptr %v494.p
  %v495.c = icmp uge i64 %v493, %v494
  %v495 = zext i1 %v495.c to i64
  %c.b87 = icmp ne i64 %v495, 0
  br i1 %c.b87, label %b87.t145, label %b87.e146
b87.t145:
  br label %b88
b87.e146:
  br label %b89
b88:
  %v496 = add i64 0, 31
  call void @"rt.panic"(i64 %v496)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b89:
  %v497.p = getelementptr i64, ptr %v64, i64 0
  %v497 = load i64, ptr %v497.p
  %v498 = inttoptr i64 %v497 to ptr
  %v499 = add i64 0, 1
  %v500 = mul i64 %v493, %v499
  %v501 = getelementptr i64, ptr %v498, i64 %v500
  %v502.p = getelementptr i64, ptr %v501, i64 0
  %v502 = load i64, ptr %v502.p
  %v503.a = bitcast i64 %v80 to double
  %v503.b = bitcast i64 %v502 to double
  %v503.f = fmul double %v503.a, %v503.b
  %v503 = bitcast double %v503.f to i64
  %v504.a = bitcast i64 %v491 to double
  %v504.b = bitcast i64 %v503 to double
  %v504.f = fadd double %v504.a, %v504.b
  %v504 = bitcast double %v504.f to i64
  %v505.p = getelementptr i64, ptr %v64, i64 1
  %v505 = load i64, ptr %v505.p
  %v506.c = icmp uge i64 %v480, %v505
  %v506 = zext i1 %v506.c to i64
  %c.b89 = icmp ne i64 %v506, 0
  br i1 %c.b89, label %b89.t147, label %b89.e148
b89.t147:
  br label %b90
b89.e148:
  br label %b91
b90:
  %v507 = add i64 0, 32
  call void @"rt.panic"(i64 %v507)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b91:
  %v508.p = getelementptr i64, ptr %v64, i64 0
  %v508 = load i64, ptr %v508.p
  %v509 = inttoptr i64 %v508 to ptr
  %v510 = add i64 0, 1
  %v511 = mul i64 %v480, %v510
  %v512 = getelementptr i64, ptr %v509, i64 %v511
  %st148 = getelementptr i64, ptr %v512, i64 0
  store i64 %v504, ptr %st148
  br label %b73
b92:
  %v761 = getelementptr i64, ptr @"rt.meta", i64 0
  %st149 = getelementptr i64, ptr %v761, i64 0
  store i64 %v519, ptr %st149
  %v545 = add i64 0, 4609434218613702656
  %v546 = add i64 0, 4612248968380809216
  %v547 = add i64 0, 4614219293217783808
  %v548 = add i64 0, 4616259986798936064
  %v549 = add i64 0, 0
  %v550 = add i64 0, 0
  %v551 = add i64 0, 0
  %v552 = add i64 0, 0
  %v553 = add i64 0, 0
  %v554 = add i64 0, 0
  %v762 = getelementptr i64, ptr @"rt.meta", i64 0
  %v555.p = getelementptr i64, ptr %v762, i64 0
  %v555 = load i64, ptr %v555.p
  %v556 = add i64 0, 10
  %v557 = call ptr @"rt.region_alloc"(i64 %v555, i64 %v556)
  %st150 = getelementptr i64, ptr %v557, i64 0
  store i64 %v545, ptr %st150
  %st151 = getelementptr i64, ptr %v557, i64 1
  store i64 %v546, ptr %st151
  %st152 = getelementptr i64, ptr %v557, i64 2
  store i64 %v547, ptr %st152
  %st153 = getelementptr i64, ptr %v557, i64 3
  store i64 %v548, ptr %st153
  %st154 = getelementptr i64, ptr %v557, i64 4
  store i64 %v549, ptr %st154
  %st155 = getelementptr i64, ptr %v557, i64 5
  store i64 %v550, ptr %st155
  %st156 = getelementptr i64, ptr %v557, i64 6
  store i64 %v551, ptr %st156
  %st157 = getelementptr i64, ptr %v557, i64 7
  store i64 %v552, ptr %st157
  %st158 = getelementptr i64, ptr %v557, i64 8
  store i64 %v553, ptr %st158
  %st159 = getelementptr i64, ptr %v557, i64 9
  store i64 %v554, ptr %st159
  %v558 = add i64 0, 10
  %v559 = getelementptr i64, ptr %s0, i64 0
  %v560 = ptrtoint ptr %v557 to i64
  %st160 = getelementptr i64, ptr %v559, i64 0
  store i64 %v560, ptr %st160
  %st161 = getelementptr i64, ptr %v559, i64 1
  store i64 %v558, ptr %st161
  %st162 = getelementptr i64, ptr %v559, i64 2
  store i64 %v555, ptr %st162
  %v561 = getelementptr i64, ptr %s9, i64 0
  %v562.p = getelementptr i64, ptr %v559, i64 0
  %v562 = load i64, ptr %v562.p
  %st163 = getelementptr i64, ptr %v561, i64 0
  store i64 %v562, ptr %st163
  %v563.p = getelementptr i64, ptr %v559, i64 1
  %v563 = load i64, ptr %v563.p
  %st164 = getelementptr i64, ptr %v561, i64 1
  store i64 %v563, ptr %st164
  %v564.p = getelementptr i64, ptr %v559, i64 2
  %v564 = load i64, ptr %v564.p
  %st165 = getelementptr i64, ptr %v561, i64 2
  store i64 %v564, ptr %st165
  %v565 = add i64 0, 4599075939470750515
  %v566 = add i64 0, 4604480259023595110
  %v567 = getelementptr i64, ptr %s2, i64 0
  %v763 = getelementptr i64, ptr @"rt.meta", i64 0
  %v568.p = getelementptr i64, ptr %v763, i64 0
  %v568 = load i64, ptr %v568.p
  %v569 = add i64 0, 9
  %v570.p = getelementptr i64, ptr %v561, i64 1
  %v570 = load i64, ptr %v570.p
  %v571.c = icmp uge i64 %v569, %v570
  %v571 = zext i1 %v571.c to i64
  %c.b92 = icmp ne i64 %v571, 0
  br i1 %c.b92, label %b92.t167, label %b92.e168
b92.t167:
  br label %b101
b92.e168:
  br label %b102
b93:
  br label %b92
b94:
  %v764 = getelementptr i64, ptr @"rt.meta", i64 0
  %st168 = getelementptr i64, ptr %v764, i64 0
  store i64 %v525, ptr %st168
  %v526.p = getelementptr i64, ptr %v524, i64 0
  %v526 = load i64, ptr %v526.p
  %v527.c = icmp slt i64 %v526, %v521
  %v527 = zext i1 %v527.c to i64
  %c.b94 = icmp ne i64 %v527, 0
  br i1 %c.b94, label %b94.t170, label %b94.e171
b94.t170:
  br label %b95
b94.e171:
  br label %b96
b95:
  call void @"rt.region_enter"()
  %v765 = getelementptr i64, ptr @"rt.meta", i64 0
  %v528.p = getelementptr i64, ptr %v765, i64 0
  %v528 = load i64, ptr %v528.p
  %v529.p = getelementptr i64, ptr %v524, i64 0
  %v529 = load i64, ptr %v529.p
  %v766 = getelementptr i64, ptr @"rt.meta", i64 0
  %v530.p = getelementptr i64, ptr %v766, i64 0
  %v530 = load i64, ptr %v530.p
  %v531.p = getelementptr i64, ptr %v64, i64 1
  %v531 = load i64, ptr %v531.p
  %v532.c = icmp uge i64 %v529, %v531
  %v532 = zext i1 %v532.c to i64
  %c.b95 = icmp ne i64 %v532, 0
  br i1 %c.b95, label %b95.t172, label %b95.e173
b95.t172:
  br label %b98
b95.e173:
  br label %b99
b96:
  %v767 = getelementptr i64, ptr @"rt.meta", i64 0
  %st173 = getelementptr i64, ptr %v767, i64 0
  store i64 %v525, ptr %st173
  br label %b93
b97:
  %v768 = getelementptr i64, ptr @"rt.meta", i64 0
  %st174 = getelementptr i64, ptr %v768, i64 0
  store i64 %v530, ptr %st174
  %v542 = add i64 0, 1
  %v543.p = getelementptr i64, ptr %v524, i64 0
  %v543 = load i64, ptr %v543.p
  %v544 = add i64 %v543, %v542
  %st175 = getelementptr i64, ptr %v524, i64 0
  store i64 %v544, ptr %st175
  br label %b94
b98:
  %v533 = add i64 0, 33
  call void @"rt.panic"(i64 %v533)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b99:
  %v534.p = getelementptr i64, ptr %v64, i64 0
  %v534 = load i64, ptr %v534.p
  %v535 = inttoptr i64 %v534 to ptr
  %v536 = add i64 0, 1
  %v537 = mul i64 %v529, %v536
  %v538 = getelementptr i64, ptr %v535, i64 %v537
  %v539.p = getelementptr i64, ptr %v538, i64 0
  %v539 = load i64, ptr %v539.p
  %v540 = call i64 @"std/math.Bits"(i64 %v539)
  call void @"rt.print_int"(i64 %v540)
  %v541 = add i64 0, 10
  call void @"rt.print_char"(i64 %v541)
  br label %b97
b100:
  %v769 = getelementptr i64, ptr @"rt.meta", i64 0
  %v693.p = getelementptr i64, ptr %v769, i64 0
  %v693 = load i64, ptr %v693.p
  %v694 = add i64 0, 0
  %v695 = add i64 0, 4
  %v696 = getelementptr i64, ptr %s2, i64 0
  %v770 = getelementptr i64, ptr @"rt.meta", i64 0
  %v697.p = getelementptr i64, ptr %v770, i64 0
  %v697 = load i64, ptr %v697.p
  %v698 = getelementptr i64, ptr %s3, i64 0
  %st176 = getelementptr i64, ptr %v698, i64 0
  store i64 %v694, ptr %st176
  %v771 = getelementptr i64, ptr @"rt.meta", i64 0
  %v699.p = getelementptr i64, ptr %v771, i64 0
  %v699 = load i64, ptr %v699.p
  br label %b127
b101:
  %v572 = add i64 0, 34
  call void @"rt.panic"(i64 %v572)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b102:
  %v573.p = getelementptr i64, ptr %v561, i64 0
  %v573 = load i64, ptr %v573.p
  %v574 = inttoptr i64 %v573 to ptr
  %v575 = add i64 0, 1
  %v576 = mul i64 %v569, %v575
  %v577 = getelementptr i64, ptr %v574, i64 %v576
  %v578.p = getelementptr i64, ptr %v577, i64 0
  %v578 = load i64, ptr %v578.p
  %v579 = add i64 0, 0
  %v580 = add i64 0, 0
  %v581.p = getelementptr i64, ptr %v561, i64 1
  %v581 = load i64, ptr %v581.p
  %v582.c = icmp uge i64 %v580, %v581
  %v582 = zext i1 %v582.c to i64
  %c.b102 = icmp ne i64 %v582, 0
  br i1 %c.b102, label %b102.t178, label %b102.e179
b102.t178:
  br label %b103
b102.e179:
  br label %b104
b103:
  %v583 = add i64 0, 35
  call void @"rt.panic"(i64 %v583)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b104:
  %v584.p = getelementptr i64, ptr %v561, i64 0
  %v584 = load i64, ptr %v584.p
  %v585 = inttoptr i64 %v584 to ptr
  %v586 = add i64 0, 1
  %v587 = mul i64 %v580, %v586
  %v588 = getelementptr i64, ptr %v585, i64 %v587
  %v589.p = getelementptr i64, ptr %v588, i64 0
  %v589 = load i64, ptr %v589.p
  %v590.a = bitcast i64 %v565 to double
  %v590.b = bitcast i64 %v566 to double
  %v590.f = fmul double %v590.a, %v590.b
  %v590 = bitcast double %v590.f to i64
  %v591.a = bitcast i64 %v589 to double
  %v591.b = bitcast i64 %v590 to double
  %v591.f = fsub double %v591.a, %v591.b
  %v591 = bitcast double %v591.f to i64
  %v592.p = getelementptr i64, ptr %v561, i64 1
  %v592 = load i64, ptr %v592.p
  %v593.c = icmp uge i64 %v579, %v592
  %v593 = zext i1 %v593.c to i64
  %c.b104 = icmp ne i64 %v593, 0
  br i1 %c.b104, label %b104.t180, label %b104.e181
b104.t180:
  br label %b105
b104.e181:
  br label %b106
b105:
  %v594 = add i64 0, 36
  call void @"rt.panic"(i64 %v594)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b106:
  %v595.p = getelementptr i64, ptr %v561, i64 0
  %v595 = load i64, ptr %v595.p
  %v596 = inttoptr i64 %v595 to ptr
  %v597 = add i64 0, 1
  %v598 = mul i64 %v579, %v597
  %v599 = getelementptr i64, ptr %v596, i64 %v598
  %st181 = getelementptr i64, ptr %v599, i64 0
  store i64 %v591, ptr %st181
  %v600 = add i64 0, 1
  %v601 = add i64 0, 1
  %v602.p = getelementptr i64, ptr %v561, i64 1
  %v602 = load i64, ptr %v602.p
  %v603.c = icmp uge i64 %v601, %v602
  %v603 = zext i1 %v603.c to i64
  %c.b106 = icmp ne i64 %v603, 0
  br i1 %c.b106, label %b106.t183, label %b106.e184
b106.t183:
  br label %b107
b106.e184:
  br label %b108
b107:
  %v604 = add i64 0, 37
  call void @"rt.panic"(i64 %v604)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b108:
  %v605.p = getelementptr i64, ptr %v561, i64 0
  %v605 = load i64, ptr %v605.p
  %v606 = inttoptr i64 %v605 to ptr
  %v607 = add i64 0, 1
  %v608 = mul i64 %v601, %v607
  %v609 = getelementptr i64, ptr %v606, i64 %v608
  %v610.p = getelementptr i64, ptr %v609, i64 0
  %v610 = load i64, ptr %v610.p
  %v611 = add i64 0, 0
  %v612.p = getelementptr i64, ptr %v561, i64 1
  %v612 = load i64, ptr %v612.p
  %v613.c = icmp uge i64 %v611, %v612
  %v613 = zext i1 %v613.c to i64
  %c.b108 = icmp ne i64 %v613, 0
  br i1 %c.b108, label %b108.t185, label %b108.e186
b108.t185:
  br label %b109
b108.e186:
  br label %b110
b109:
  %v614 = add i64 0, 38
  call void @"rt.panic"(i64 %v614)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b110:
  %v615.p = getelementptr i64, ptr %v561, i64 0
  %v615 = load i64, ptr %v615.p
  %v616 = inttoptr i64 %v615 to ptr
  %v617 = add i64 0, 1
  %v618 = mul i64 %v611, %v617
  %v619 = getelementptr i64, ptr %v616, i64 %v618
  %v620.p = getelementptr i64, ptr %v619, i64 0
  %v620 = load i64, ptr %v620.p
  %v621.a = bitcast i64 %v620 to double
  %v621.b = bitcast i64 %v566 to double
  %v621.f = fmul double %v621.a, %v621.b
  %v621 = bitcast double %v621.f to i64
  %v622.a = bitcast i64 %v610 to double
  %v622.b = bitcast i64 %v621 to double
  %v622.f = fsub double %v622.a, %v622.b
  %v622 = bitcast double %v622.f to i64
  %v623.p = getelementptr i64, ptr %v561, i64 1
  %v623 = load i64, ptr %v623.p
  %v624.c = icmp uge i64 %v600, %v623
  %v624 = zext i1 %v624.c to i64
  %c.b110 = icmp ne i64 %v624, 0
  br i1 %c.b110, label %b110.t187, label %b110.e188
b110.t187:
  br label %b111
b110.e188:
  br label %b112
b111:
  %v625 = add i64 0, 39
  call void @"rt.panic"(i64 %v625)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b112:
  %v626.p = getelementptr i64, ptr %v561, i64 0
  %v626 = load i64, ptr %v626.p
  %v627 = inttoptr i64 %v626 to ptr
  %v628 = add i64 0, 1
  %v629 = mul i64 %v600, %v628
  %v630 = getelementptr i64, ptr %v627, i64 %v629
  %st188 = getelementptr i64, ptr %v630, i64 0
  store i64 %v622, ptr %st188
  %v631 = add i64 0, 2
  %v632 = add i64 0, 2
  %v633.p = getelementptr i64, ptr %v561, i64 1
  %v633 = load i64, ptr %v633.p
  %v634.c = icmp uge i64 %v632, %v633
  %v634 = zext i1 %v634.c to i64
  %c.b112 = icmp ne i64 %v634, 0
  br i1 %c.b112, label %b112.t190, label %b112.e191
b112.t190:
  br label %b113
b112.e191:
  br label %b114
b113:
  %v635 = add i64 0, 40
  call void @"rt.panic"(i64 %v635)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b114:
  %v636.p = getelementptr i64, ptr %v561, i64 0
  %v636 = load i64, ptr %v636.p
  %v637 = inttoptr i64 %v636 to ptr
  %v638 = add i64 0, 1
  %v639 = mul i64 %v632, %v638
  %v640 = getelementptr i64, ptr %v637, i64 %v639
  %v641.p = getelementptr i64, ptr %v640, i64 0
  %v641 = load i64, ptr %v641.p
  %v642 = add i64 0, 1
  %v643.p = getelementptr i64, ptr %v561, i64 1
  %v643 = load i64, ptr %v643.p
  %v644.c = icmp uge i64 %v642, %v643
  %v644 = zext i1 %v644.c to i64
  %c.b114 = icmp ne i64 %v644, 0
  br i1 %c.b114, label %b114.t192, label %b114.e193
b114.t192:
  br label %b115
b114.e193:
  br label %b116
b115:
  %v645 = add i64 0, 41
  call void @"rt.panic"(i64 %v645)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b116:
  %v646.p = getelementptr i64, ptr %v561, i64 0
  %v646 = load i64, ptr %v646.p
  %v647 = inttoptr i64 %v646 to ptr
  %v648 = add i64 0, 1
  %v649 = mul i64 %v642, %v648
  %v650 = getelementptr i64, ptr %v647, i64 %v649
  %v651.p = getelementptr i64, ptr %v650, i64 0
  %v651 = load i64, ptr %v651.p
  %v652.a = bitcast i64 %v651 to double
  %v652.b = bitcast i64 %v565 to double
  %v652.f = fmul double %v652.a, %v652.b
  %v652 = bitcast double %v652.f to i64
  %v653.a = bitcast i64 %v641 to double
  %v653.b = bitcast i64 %v652 to double
  %v653.f = fadd double %v653.a, %v653.b
  %v653 = bitcast double %v653.f to i64
  %v654.p = getelementptr i64, ptr %v561, i64 1
  %v654 = load i64, ptr %v654.p
  %v655.c = icmp uge i64 %v631, %v654
  %v655 = zext i1 %v655.c to i64
  %c.b116 = icmp ne i64 %v655, 0
  br i1 %c.b116, label %b116.t194, label %b116.e195
b116.t194:
  br label %b117
b116.e195:
  br label %b118
b117:
  %v656 = add i64 0, 42
  call void @"rt.panic"(i64 %v656)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b118:
  %v657.p = getelementptr i64, ptr %v561, i64 0
  %v657 = load i64, ptr %v657.p
  %v658 = inttoptr i64 %v657 to ptr
  %v659 = add i64 0, 1
  %v660 = mul i64 %v631, %v659
  %v661 = getelementptr i64, ptr %v658, i64 %v660
  %st195 = getelementptr i64, ptr %v661, i64 0
  store i64 %v653, ptr %st195
  %v662 = add i64 0, 3
  %v663 = add i64 0, 3
  %v664.p = getelementptr i64, ptr %v561, i64 1
  %v664 = load i64, ptr %v664.p
  %v665.c = icmp uge i64 %v663, %v664
  %v665 = zext i1 %v665.c to i64
  %c.b118 = icmp ne i64 %v665, 0
  br i1 %c.b118, label %b118.t197, label %b118.e198
b118.t197:
  br label %b119
b118.e198:
  br label %b120
b119:
  %v666 = add i64 0, 43
  call void @"rt.panic"(i64 %v666)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b120:
  %v667.p = getelementptr i64, ptr %v561, i64 0
  %v667 = load i64, ptr %v667.p
  %v668 = inttoptr i64 %v667 to ptr
  %v669 = add i64 0, 1
  %v670 = mul i64 %v663, %v669
  %v671 = getelementptr i64, ptr %v668, i64 %v670
  %v672.p = getelementptr i64, ptr %v671, i64 0
  %v672 = load i64, ptr %v672.p
  %v673 = add i64 0, 2
  %v674.p = getelementptr i64, ptr %v561, i64 1
  %v674 = load i64, ptr %v674.p
  %v675.c = icmp uge i64 %v673, %v674
  %v675 = zext i1 %v675.c to i64
  %c.b120 = icmp ne i64 %v675, 0
  br i1 %c.b120, label %b120.t199, label %b120.e200
b120.t199:
  br label %b121
b120.e200:
  br label %b122
b121:
  %v676 = add i64 0, 44
  call void @"rt.panic"(i64 %v676)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b122:
  %v677.p = getelementptr i64, ptr %v561, i64 0
  %v677 = load i64, ptr %v677.p
  %v678 = inttoptr i64 %v677 to ptr
  %v679 = add i64 0, 1
  %v680 = mul i64 %v673, %v679
  %v681 = getelementptr i64, ptr %v678, i64 %v680
  %v682.p = getelementptr i64, ptr %v681, i64 0
  %v682 = load i64, ptr %v682.p
  %v683.a = bitcast i64 %v682 to double
  %v683.b = bitcast i64 %v565 to double
  %v683.f = fmul double %v683.a, %v683.b
  %v683 = bitcast double %v683.f to i64
  %v684.a = bitcast i64 %v672 to double
  %v684.b = bitcast i64 %v683 to double
  %v684.f = fadd double %v684.a, %v684.b
  %v684 = bitcast double %v684.f to i64
  %v685.p = getelementptr i64, ptr %v561, i64 1
  %v685 = load i64, ptr %v685.p
  %v686.c = icmp uge i64 %v662, %v685
  %v686 = zext i1 %v686.c to i64
  %c.b122 = icmp ne i64 %v686, 0
  br i1 %c.b122, label %b122.t201, label %b122.e202
b122.t201:
  br label %b123
b122.e202:
  br label %b124
b123:
  %v687 = add i64 0, 45
  call void @"rt.panic"(i64 %v687)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b124:
  %v688.p = getelementptr i64, ptr %v561, i64 0
  %v688 = load i64, ptr %v688.p
  %v689 = inttoptr i64 %v688 to ptr
  %v690 = add i64 0, 1
  %v691 = mul i64 %v662, %v690
  %v692 = getelementptr i64, ptr %v689, i64 %v691
  %st202 = getelementptr i64, ptr %v692, i64 0
  store i64 %v684, ptr %st202
  br label %b100
b125:
  %v772 = getelementptr i64, ptr @"rt.meta", i64 0
  %st203 = getelementptr i64, ptr %v772, i64 0
  store i64 %v693, ptr %st203
  %v773 = getelementptr i64, ptr @"rt.meta", i64 0
  %st204 = getelementptr i64, ptr %v773, i64 0
  store i64 %v0, ptr %st204
  ret void
b126:
  br label %b125
b127:
  %v774 = getelementptr i64, ptr @"rt.meta", i64 0
  %st205 = getelementptr i64, ptr %v774, i64 0
  store i64 %v699, ptr %st205
  %v700.p = getelementptr i64, ptr %v698, i64 0
  %v700 = load i64, ptr %v700.p
  %v701.c = icmp slt i64 %v700, %v695
  %v701 = zext i1 %v701.c to i64
  %c.b127 = icmp ne i64 %v701, 0
  br i1 %c.b127, label %b127.t207, label %b127.e208
b127.t207:
  br label %b128
b127.e208:
  br label %b129
b128:
  call void @"rt.region_enter"()
  %v775 = getelementptr i64, ptr @"rt.meta", i64 0
  %v702.p = getelementptr i64, ptr %v775, i64 0
  %v702 = load i64, ptr %v702.p
  %v703.p = getelementptr i64, ptr %v698, i64 0
  %v703 = load i64, ptr %v703.p
  %v776 = getelementptr i64, ptr @"rt.meta", i64 0
  %v704.p = getelementptr i64, ptr %v776, i64 0
  %v704 = load i64, ptr %v704.p
  %v705.p = getelementptr i64, ptr %v561, i64 1
  %v705 = load i64, ptr %v705.p
  %v706.c = icmp uge i64 %v703, %v705
  %v706 = zext i1 %v706.c to i64
  %c.b128 = icmp ne i64 %v706, 0
  br i1 %c.b128, label %b128.t209, label %b128.e210
b128.t209:
  br label %b131
b128.e210:
  br label %b132
b129:
  %v777 = getelementptr i64, ptr @"rt.meta", i64 0
  %st210 = getelementptr i64, ptr %v777, i64 0
  store i64 %v699, ptr %st210
  br label %b126
b130:
  %v778 = getelementptr i64, ptr @"rt.meta", i64 0
  %st211 = getelementptr i64, ptr %v778, i64 0
  store i64 %v704, ptr %st211
  %v716 = add i64 0, 1
  %v717.p = getelementptr i64, ptr %v698, i64 0
  %v717 = load i64, ptr %v717.p
  %v718 = add i64 %v717, %v716
  %st212 = getelementptr i64, ptr %v698, i64 0
  store i64 %v718, ptr %st212
  br label %b127
b131:
  %v707 = add i64 0, 46
  call void @"rt.panic"(i64 %v707)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b132:
  %v708.p = getelementptr i64, ptr %v561, i64 0
  %v708 = load i64, ptr %v708.p
  %v709 = inttoptr i64 %v708 to ptr
  %v710 = add i64 0, 1
  %v711 = mul i64 %v703, %v710
  %v712 = getelementptr i64, ptr %v709, i64 %v711
  %v713.p = getelementptr i64, ptr %v712, i64 0
  %v713 = load i64, ptr %v713.p
  %v714 = call i64 @"std/math.Bits"(i64 %v713)
  call void @"rt.print_int"(i64 %v714)
  %v715 = add i64 0, 10
  call void @"rt.print_char"(i64 %v715)
  br label %b130
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
  %v20 = getelementptr i64, ptr @"str.11", i64 0
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
  %v74 = getelementptr i64, ptr @"str.19", i64 0
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
  %v27 = getelementptr i64, ptr @"str.12", i64 0
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
  %v34 = getelementptr i64, ptr @"str.13", i64 0
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
  %v41 = getelementptr i64, ptr @"str.14", i64 0
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
  %v48 = getelementptr i64, ptr @"str.15", i64 0
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
  %v55 = getelementptr i64, ptr @"str.16", i64 0
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
  %v62 = getelementptr i64, ptr @"str.17", i64 0
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
  %v69 = getelementptr i64, ptr @"str.18", i64 0
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
  %v86 = add i64 0, 58
  call void @"rt.print_char"(i64 %v86)
  call void @"rt.print_int"(i64 %v14)
  %v87 = add i64 0, 58
  call void @"rt.print_char"(i64 %v87)
  call void @"rt.print_int"(i64 %v18)
  %v88 = add i64 0, 10
  call void @"rt.print_char"(i64 %v88)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v81 = getelementptr i64, ptr @"str.20", i64 0
  %v82 = add i64 0, 13
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
  br label %b16
}

define internal i64 @"std/math.Sqrt"(i64 %v0) #0 {
b0:
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v3, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2.a = bitcast i64 %v0 to double
  %v2.f = call double @llvm.sqrt.f64(double %v2.a)
  %v2 = bitcast double %v2.f to i64
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  ret i64 %v2
}

define internal i64 @"std/math.Bits"(i64 %v0) #0 {
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
declare double @llvm.sqrt.f64(double)
