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
@"str.0" = internal constant [2 x i64] [i64 8313485934707635567, i64 7627124]
@"str.1" = internal constant [1 x i64] [i64 138419271026]
@"str.2" = internal constant [2 x i64] [i64 7959390400869068654, i64 100]
@"str.3" = internal constant [1 x i64] [i64 110386723317092]
@"str.4" = internal constant [1 x i64] [i64 35662966452837]
@"str.5" = internal constant [1 x i64] [i64 491327616111]
@"str.6" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.7" = internal constant [1 x i64] [i64 45]
@"str.8" = internal constant [1 x i64] [i64 30806320502891055]
@"str.9" = internal constant [1 x i64] [i64 6713901]
@"str.10" = internal constant [2 x i64] [i64 7235997276784124463, i64 29289]
@"str.11" = internal constant [1 x i64] [i64 28717]
@"str.12" = internal constant [1 x i64] [i64 1651864367]
@"str.13" = internal constant [1 x i64] [i64 128060694094127]
@"str.14" = internal constant [2 x i64] [i64 8295679370688488808, i64 7627124]
@"str.15" = internal constant [1 x i64] [i64 133541009384751]
@"str.16" = internal constant [2 x i64] [i64 7955998172649846063, i64 31356325290798383]
@"str.17" = internal constant [1 x i64] [i64 435677655087]
@"str.18" = internal constant [2 x i64] [i64 7955998172649846063, i64 114776381289519]
@"str.19" = internal constant [1 x i64] [i64 25645]
@"str.20" = internal constant [3 x i64] [i64 3472328296228139328, i64 3761405300594192432, i64 245756278325]
@"str.21" = internal constant [1 x i64] [i64 500237086305]
@"str.22" = internal constant [1 x i64] [i64 521644567909]
@"str.23" = internal constant [1 x i64] [i64 6452595]
@"str.24" = internal constant [1 x i64] [i64 1701865840]
@"str.25" = internal constant [1 x i64] [i64 47]
@"str.26" = internal constant [1 x i64] [i64 32195265799087474]
@"str.27" = internal constant [1 x i64] [i64 67506054722336]
@"str.28" = internal constant [0 x i64] zeroinitializer
@"str.29" = internal constant [1 x i64] [i64 8250]
@"str.30" = internal constant [2 x i64] [i64 7308613581475376416, i64 61]
@"str.31" = internal constant [2 x i64] [i64 8313976300752696096, i64 1030975277]
@"str.32" = internal constant [1 x i64] [i64 1702195828]
@"str.33" = internal constant [1 x i64] [i64 435728179558]
@"str.34" = internal constant [1 x i64] [i64 1701736302]
@"str.35" = internal constant [1 x i64] [i64 7498084]
@"str.36" = internal constant [1 x i64] [i64 30239221577775475]
@"str.37" = internal constant [2 x i64] [i64 7020115006107841129, i64 114]
@"rt.statbuf" = internal global [18 x i64] zeroinitializer
@"str.38" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.39" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.40" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.41" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.42" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.43" = internal constant [1 x i64] [i64 2685]
@"str.44" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.45" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.46" = internal constant [1 x i64] [i64 35899498962976]
@"str.47" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.48" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [13 x i64] [i64 7599827575635971, i64 8725727532810243, i64 8444252656762881, i64 5629503527190785, i64 11259003061403905, i64 7881303508648193, i64 3940654036025601, i64 7036878830174465, i64 3940652693848577, i64 7036877487997441, i64 8162775482237441, i64 3940652693848577, i64 7036877487997441]
@"str.49" = internal constant [1 x i64] [i64 9071397899755888]
@"str.50" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.51" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.52" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.53" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.54" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.55" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.56" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.57" = internal constant [1 x i64] [i64 544497952]
@"str.58" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]
@"str.59" = internal constant [2 x i64] [i64 7579399195445195891, i64 32199620796034671]
@"str.60" = internal constant [2 x i64] [i64 8011749183489078387, i64 32199620796034675]

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
  %v3 = getelementptr i64, ptr @"str.38", i64 0
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
  %v29 = getelementptr i64, ptr @"str.42", i64 0
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
  %v35 = getelementptr i64, ptr @"str.43", i64 0
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
  %v10 = getelementptr i64, ptr @"str.39", i64 0
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
  %v17 = getelementptr i64, ptr @"str.40", i64 0
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
  %v24 = getelementptr i64, ptr @"str.41", i64 0
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
  %v60 = getelementptr i64, ptr @"str.44", i64 0
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
  %v65 = getelementptr i64, ptr @"str.45", i64 0
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
  %v70 = getelementptr i64, ptr @"str.43", i64 0
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
  %v81 = getelementptr i64, ptr @"str.46", i64 0
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
  %v88 = getelementptr i64, ptr @"str.47", i64 0
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
  %v17 = getelementptr i64, ptr @"str.48", i64 0
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
  %v22 = getelementptr i64, ptr @"str.43", i64 0
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
  %v57 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v57, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  %v2 = getelementptr i64, ptr @"str.0", i64 0
  %v3 = add i64 0, 11
  %v4 = add i64 0, 0
  %v5 = getelementptr i64, ptr %s1, i64 0
  %v6 = ptrtoint ptr %v2 to i64
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v6, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v3, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v4, ptr %st2
  %v7.p = getelementptr i64, ptr %v5, i64 0
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v5, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v5, i64 2
  %v9 = load i64, ptr %v9.p
  call void @"main.run"(ptr %v1, i64 %v7, i64 %v8, i64 %v9)
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v1, i64 0
  %v11 = load i64, ptr %v11.p
  %st3 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st3
  %v12.p = getelementptr i64, ptr %v1, i64 1
  %v12 = load i64, ptr %v12.p
  %st4 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st4
  %v13.p = getelementptr i64, ptr %v1, i64 2
  %v13 = load i64, ptr %v13.p
  %st5 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st5
  %v14.p = getelementptr i64, ptr %v1, i64 3
  %v14 = load i64, ptr %v14.p
  %st6 = getelementptr i64, ptr %v10, i64 3
  store i64 %v14, ptr %st6
  %v15.p = getelementptr i64, ptr %v1, i64 4
  %v15 = load i64, ptr %v15.p
  %st7 = getelementptr i64, ptr %v10, i64 4
  store i64 %v15, ptr %st7
  %v16.p = getelementptr i64, ptr %v1, i64 5
  %v16 = load i64, ptr %v16.p
  %st8 = getelementptr i64, ptr %v10, i64 5
  store i64 %v16, ptr %st8
  %v17.p = getelementptr i64, ptr %v10, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 0
  %v19.c = icmp ne i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b0 = icmp ne i64 %v19, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v20 = add i64 0, 1
  %v21 = getelementptr i64, ptr %v10, i64 %v20
  %v22 = getelementptr i64, ptr %s3, i64 0
  %v23.p = getelementptr i64, ptr %v21, i64 0
  %v23 = load i64, ptr %v23.p
  %st11 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st11
  %v24.p = getelementptr i64, ptr %v21, i64 1
  %v24 = load i64, ptr %v24.p
  %st12 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st12
  %v25.p = getelementptr i64, ptr %v21, i64 2
  %v25 = load i64, ptr %v25.p
  %st13 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st13
  %v26.p = getelementptr i64, ptr %v21, i64 3
  %v26 = load i64, ptr %v26.p
  %st14 = getelementptr i64, ptr %v22, i64 3
  store i64 %v26, ptr %st14
  %v27.p = getelementptr i64, ptr %v21, i64 4
  %v27 = load i64, ptr %v27.p
  %st15 = getelementptr i64, ptr %v22, i64 4
  store i64 %v27, ptr %st15
  %v28 = getelementptr i64, ptr %s4, i64 0
  %v29.p = getelementptr i64, ptr %v22, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v22, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v22, i64 2
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v22, i64 3
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v22, i64 4
  %v33 = load i64, ptr %v33.p
  call void @"main.why"(ptr %v28, i64 %v29, i64 %v30, i64 %v31, i64 %v32, i64 %v33)
  %v34 = getelementptr i64, ptr %s1, i64 0
  %v35.p = getelementptr i64, ptr %v28, i64 0
  %v35 = load i64, ptr %v35.p
  %st16 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st16
  %v36.p = getelementptr i64, ptr %v28, i64 1
  %v36 = load i64, ptr %v36.p
  %st17 = getelementptr i64, ptr %v34, i64 1
  store i64 %v36, ptr %st17
  %v37.p = getelementptr i64, ptr %v28, i64 2
  %v37 = load i64, ptr %v37.p
  %st18 = getelementptr i64, ptr %v34, i64 2
  store i64 %v37, ptr %st18
  %v38 = getelementptr i64, ptr @"str.1", i64 0
  %v39 = add i64 0, 5
  %v40 = add i64 0, 0
  %v41 = getelementptr i64, ptr %s5, i64 0
  %v42 = ptrtoint ptr %v38 to i64
  %st19 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st19
  %st20 = getelementptr i64, ptr %v41, i64 1
  store i64 %v39, ptr %st20
  %st21 = getelementptr i64, ptr %v41, i64 2
  store i64 %v40, ptr %st21
  %v43.p = getelementptr i64, ptr %v41, i64 1
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v34, i64 1
  %v44 = load i64, ptr %v44.p
  %v45 = add i64 %v43, %v44
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v58, i64 0
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v41, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v41, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v41, i64 2
  %v49 = load i64, ptr %v49.p
  %v50 = call ptr @"rt.cat8"(i64 %v47, i64 %v48, i64 %v49, i64 %v46, i64 %v44)
  %v51 = getelementptr i8, ptr %v50, i64 %v43
  %v52.p = getelementptr i64, ptr %v34, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = inttoptr i64 %v52 to ptr
  call void @"rt.copy8"(ptr %v51, ptr %v53, i64 %v44)
  %v54 = getelementptr i64, ptr %s6, i64 0
  %v55 = ptrtoint ptr %v50 to i64
  %st22 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st22
  %st23 = getelementptr i64, ptr %v54, i64 1
  store i64 %v45, ptr %st23
  %st24 = getelementptr i64, ptr %v54, i64 2
  store i64 %v46, ptr %st24
  call void @"rt.print_str"(ptr %v54)
  %v56 = add i64 0, 10
  call void @"rt.print_char"(i64 %v56)
  br label %b3
b2:
  br label %b3
b3:
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v59, i64 0
  store i64 %v0, ptr %st25
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

define internal void @"main.run"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [7 x i64], align 8
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
  %s1.z6 = getelementptr i64, ptr %s1, i64 6
  store i64 0, ptr %s1.z6
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
  %s7 = alloca [7 x i64], align 8
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
  %s7.z6 = getelementptr i64, ptr %s7, i64 6
  store i64 0, ptr %s7.z6
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
  %s11 = alloca [6 x i64], align 8
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
  %s11.z5 = getelementptr i64, ptr %s11, i64 5
  store i64 0, ptr %s11.z5
  %s12 = alloca [7 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s12.z3 = getelementptr i64, ptr %s12, i64 3
  store i64 0, ptr %s12.z3
  %s12.z4 = getelementptr i64, ptr %s12, i64 4
  store i64 0, ptr %s12.z4
  %s12.z5 = getelementptr i64, ptr %s12, i64 5
  store i64 0, ptr %s12.z5
  %s12.z6 = getelementptr i64, ptr %s12, i64 6
  store i64 0, ptr %s12.z6
  %s13 = alloca [7 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s13.z1 = getelementptr i64, ptr %s13, i64 1
  store i64 0, ptr %s13.z1
  %s13.z2 = getelementptr i64, ptr %s13, i64 2
  store i64 0, ptr %s13.z2
  %s13.z3 = getelementptr i64, ptr %s13, i64 3
  store i64 0, ptr %s13.z3
  %s13.z4 = getelementptr i64, ptr %s13, i64 4
  store i64 0, ptr %s13.z4
  %s13.z5 = getelementptr i64, ptr %s13, i64 5
  store i64 0, ptr %s13.z5
  %s13.z6 = getelementptr i64, ptr %s13, i64 6
  store i64 0, ptr %s13.z6
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
  %s18 = alloca [3 x i64], align 8
  %s18.z0 = getelementptr i64, ptr %s18, i64 0
  store i64 0, ptr %s18.z0
  %s18.z1 = getelementptr i64, ptr %s18, i64 1
  store i64 0, ptr %s18.z1
  %s18.z2 = getelementptr i64, ptr %s18, i64 2
  store i64 0, ptr %s18.z2
  %s19 = alloca [3 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s19.z1 = getelementptr i64, ptr %s19, i64 1
  store i64 0, ptr %s19.z1
  %s19.z2 = getelementptr i64, ptr %s19, i64 2
  store i64 0, ptr %s19.z2
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
  %s25 = alloca [7 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
  %s25.z1 = getelementptr i64, ptr %s25, i64 1
  store i64 0, ptr %s25.z1
  %s25.z2 = getelementptr i64, ptr %s25, i64 2
  store i64 0, ptr %s25.z2
  %s25.z3 = getelementptr i64, ptr %s25, i64 3
  store i64 0, ptr %s25.z3
  %s25.z4 = getelementptr i64, ptr %s25, i64 4
  store i64 0, ptr %s25.z4
  %s25.z5 = getelementptr i64, ptr %s25, i64 5
  store i64 0, ptr %s25.z5
  %s25.z6 = getelementptr i64, ptr %s25, i64 6
  store i64 0, ptr %s25.z6
  %s26 = alloca [1 x i64], align 8
  %s26.z0 = getelementptr i64, ptr %s26, i64 0
  store i64 0, ptr %s26.z0
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
  %s29 = alloca [6 x i64], align 8
  %s29.z0 = getelementptr i64, ptr %s29, i64 0
  store i64 0, ptr %s29.z0
  %s29.z1 = getelementptr i64, ptr %s29, i64 1
  store i64 0, ptr %s29.z1
  %s29.z2 = getelementptr i64, ptr %s29, i64 2
  store i64 0, ptr %s29.z2
  %s29.z3 = getelementptr i64, ptr %s29, i64 3
  store i64 0, ptr %s29.z3
  %s29.z4 = getelementptr i64, ptr %s29, i64 4
  store i64 0, ptr %s29.z4
  %s29.z5 = getelementptr i64, ptr %s29, i64 5
  store i64 0, ptr %s29.z5
  %s30 = alloca [6 x i64], align 8
  %s30.z0 = getelementptr i64, ptr %s30, i64 0
  store i64 0, ptr %s30.z0
  %s30.z1 = getelementptr i64, ptr %s30, i64 1
  store i64 0, ptr %s30.z1
  %s30.z2 = getelementptr i64, ptr %s30, i64 2
  store i64 0, ptr %s30.z2
  %s30.z3 = getelementptr i64, ptr %s30, i64 3
  store i64 0, ptr %s30.z3
  %s30.z4 = getelementptr i64, ptr %s30, i64 4
  store i64 0, ptr %s30.z4
  %s30.z5 = getelementptr i64, ptr %s30, i64 5
  store i64 0, ptr %s30.z5
  %s31 = alloca [6 x i64], align 8
  %s31.z0 = getelementptr i64, ptr %s31, i64 0
  store i64 0, ptr %s31.z0
  %s31.z1 = getelementptr i64, ptr %s31, i64 1
  store i64 0, ptr %s31.z1
  %s31.z2 = getelementptr i64, ptr %s31, i64 2
  store i64 0, ptr %s31.z2
  %s31.z3 = getelementptr i64, ptr %s31, i64 3
  store i64 0, ptr %s31.z3
  %s31.z4 = getelementptr i64, ptr %s31, i64 4
  store i64 0, ptr %s31.z4
  %s31.z5 = getelementptr i64, ptr %s31, i64 5
  store i64 0, ptr %s31.z5
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v599 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v599, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7 = getelementptr i64, ptr @"str.8", i64 0
  %v8 = add i64 0, 7
  %v9 = add i64 0, 0
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11 = ptrtoint ptr %v7 to i64
  %st3 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st3
  %st4 = getelementptr i64, ptr %v10, i64 1
  store i64 %v8, ptr %st4
  %st5 = getelementptr i64, ptr %v10, i64 2
  store i64 %v9, ptr %st5
  %v12.p = getelementptr i64, ptr %v10, i64 0
  %v12 = load i64, ptr %v12.p
  %v13.p = getelementptr i64, ptr %v10, i64 1
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v10, i64 2
  %v14 = load i64, ptr %v14.p
  %v15 = getelementptr i64, ptr @"str.9", i64 0
  %v16 = add i64 0, 3
  %v17 = add i64 0, 0
  %v18 = getelementptr i64, ptr %s3, i64 0
  %v19 = ptrtoint ptr %v15 to i64
  %st6 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st6
  %st7 = getelementptr i64, ptr %v18, i64 1
  store i64 %v16, ptr %st7
  %st8 = getelementptr i64, ptr %v18, i64 2
  store i64 %v17, ptr %st8
  %v20 = getelementptr i64, ptr %s4, i64 0
  %v21.p = getelementptr i64, ptr %v18, i64 0
  %v21 = load i64, ptr %v21.p
  %st9 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st9
  %v22.p = getelementptr i64, ptr %v18, i64 1
  %v22 = load i64, ptr %v22.p
  %st10 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st10
  %v23.p = getelementptr i64, ptr %v18, i64 2
  %v23 = load i64, ptr %v23.p
  %st11 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st11
  %v24 = getelementptr i64, ptr %s5, i64 0
  %v25.p = getelementptr i64, ptr %v4, i64 0
  %v25 = load i64, ptr %v25.p
  %st12 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st12
  %v26.p = getelementptr i64, ptr %v4, i64 1
  %v26 = load i64, ptr %v26.p
  %st13 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st13
  %v27.p = getelementptr i64, ptr %v4, i64 2
  %v27 = load i64, ptr %v27.p
  %st14 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st14
  %v600 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v600, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 6
  %v30 = call ptr @"rt.region_alloc"(i64 %v28, i64 %v29)
  %v31.p = getelementptr i64, ptr %v20, i64 0
  %v31 = load i64, ptr %v31.p
  %st15 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st15
  %v32.p = getelementptr i64, ptr %v20, i64 1
  %v32 = load i64, ptr %v32.p
  %st16 = getelementptr i64, ptr %v30, i64 1
  store i64 %v32, ptr %st16
  %v33.p = getelementptr i64, ptr %v20, i64 2
  %v33 = load i64, ptr %v33.p
  %st17 = getelementptr i64, ptr %v30, i64 2
  store i64 %v33, ptr %st17
  %v34.p = getelementptr i64, ptr %v24, i64 0
  %v34 = load i64, ptr %v34.p
  %st18 = getelementptr i64, ptr %v30, i64 3
  store i64 %v34, ptr %st18
  %v35.p = getelementptr i64, ptr %v24, i64 1
  %v35 = load i64, ptr %v35.p
  %st19 = getelementptr i64, ptr %v30, i64 4
  store i64 %v35, ptr %st19
  %v36.p = getelementptr i64, ptr %v24, i64 2
  %v36 = load i64, ptr %v36.p
  %st20 = getelementptr i64, ptr %v30, i64 5
  store i64 %v36, ptr %st20
  %v37 = add i64 0, 2
  %v38 = getelementptr i64, ptr %s6, i64 0
  %v39 = ptrtoint ptr %v30 to i64
  %st21 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st21
  %st22 = getelementptr i64, ptr %v38, i64 1
  store i64 %v37, ptr %st22
  %st23 = getelementptr i64, ptr %v38, i64 2
  store i64 %v28, ptr %st23
  %v40.p = getelementptr i64, ptr %v38, i64 0
  %v40 = load i64, ptr %v40.p
  %v41.p = getelementptr i64, ptr %v38, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v38, i64 2
  %v42 = load i64, ptr %v42.p
  call void @"std/os.Run"(ptr %v6, i64 %v12, i64 %v13, i64 %v14, i64 %v40, i64 %v41, i64 %v42)
  %v43.p = getelementptr i64, ptr %v6, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = add i64 0, 1
  %v45 = getelementptr i64, ptr %v6, i64 %v44
  %v46.p = getelementptr i64, ptr %v45, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 0, 0
  %v48.c = icmp ne i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b0 = icmp ne i64 %v48, 0
  br i1 %c.b0, label %b0.t25, label %b0.e26
b0.t25:
  br label %b1
b0.e26:
  br label %b2
b1:
  %v49 = add i64 0, 0
  %v50.p = getelementptr i64, ptr %v45, i64 0
  %v50 = load i64, ptr %v50.p
  %st26 = getelementptr i64, ptr %v0, i64 0
  store i64 %v50, ptr %st26
  %v51.p = getelementptr i64, ptr %v45, i64 1
  %v51 = load i64, ptr %v51.p
  %st27 = getelementptr i64, ptr %v0, i64 1
  store i64 %v51, ptr %st27
  %v52.p = getelementptr i64, ptr %v45, i64 2
  %v52 = load i64, ptr %v52.p
  %st28 = getelementptr i64, ptr %v0, i64 2
  store i64 %v52, ptr %st28
  %v53.p = getelementptr i64, ptr %v45, i64 3
  %v53 = load i64, ptr %v53.p
  %st29 = getelementptr i64, ptr %v0, i64 3
  store i64 %v53, ptr %st29
  %v54.p = getelementptr i64, ptr %v45, i64 4
  %v54 = load i64, ptr %v54.p
  %st30 = getelementptr i64, ptr %v0, i64 4
  store i64 %v54, ptr %st30
  %v55.p = getelementptr i64, ptr %v45, i64 5
  %v55 = load i64, ptr %v55.p
  %st31 = getelementptr i64, ptr %v0, i64 5
  store i64 %v55, ptr %st31
  %v56.p = getelementptr i64, ptr %v0, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 0
  %v58.c = icmp ne i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b1 = icmp ne i64 %v58, 0
  br i1 %c.b1, label %b1.t33, label %b1.e34
b1.t33:
  br label %b3
b1.e34:
  br label %b4
b2:
  %v61 = getelementptr i64, ptr %s7, i64 0
  %v62 = getelementptr i64, ptr @"str.10", i64 0
  %v63 = add i64 0, 10
  %v64 = add i64 0, 0
  %v65 = getelementptr i64, ptr %s6, i64 0
  %v66 = ptrtoint ptr %v62 to i64
  %st34 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st34
  %st35 = getelementptr i64, ptr %v65, i64 1
  store i64 %v63, ptr %st35
  %st36 = getelementptr i64, ptr %v65, i64 2
  store i64 %v64, ptr %st36
  %v67.p = getelementptr i64, ptr %v65, i64 0
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v65, i64 1
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v65, i64 2
  %v69 = load i64, ptr %v69.p
  %v70 = getelementptr i64, ptr @"str.11", i64 0
  %v71 = add i64 0, 2
  %v72 = add i64 0, 0
  %v73 = getelementptr i64, ptr %s5, i64 0
  %v74 = ptrtoint ptr %v70 to i64
  %st37 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st37
  %st38 = getelementptr i64, ptr %v73, i64 1
  store i64 %v71, ptr %st38
  %st39 = getelementptr i64, ptr %v73, i64 2
  store i64 %v72, ptr %st39
  %v75 = getelementptr i64, ptr %s4, i64 0
  %v76.p = getelementptr i64, ptr %v73, i64 0
  %v76 = load i64, ptr %v76.p
  %st40 = getelementptr i64, ptr %v75, i64 0
  store i64 %v76, ptr %st40
  %v77.p = getelementptr i64, ptr %v73, i64 1
  %v77 = load i64, ptr %v77.p
  %st41 = getelementptr i64, ptr %v75, i64 1
  store i64 %v77, ptr %st41
  %v78.p = getelementptr i64, ptr %v73, i64 2
  %v78 = load i64, ptr %v78.p
  %st42 = getelementptr i64, ptr %v75, i64 2
  store i64 %v78, ptr %st42
  %v79 = getelementptr i64, ptr @"str.12", i64 0
  %v80 = add i64 0, 4
  %v81 = add i64 0, 0
  %v82 = getelementptr i64, ptr %s3, i64 0
  %v83 = ptrtoint ptr %v79 to i64
  %st43 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st43
  %st44 = getelementptr i64, ptr %v82, i64 1
  store i64 %v80, ptr %st44
  %st45 = getelementptr i64, ptr %v82, i64 2
  store i64 %v81, ptr %st45
  %v84.p = getelementptr i64, ptr %v4, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v82, i64 1
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 %v84, %v85
  %v601 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v601, i64 0
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v4, i64 0
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v4, i64 1
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v4, i64 2
  %v90 = load i64, ptr %v90.p
  %v91 = call ptr @"rt.cat8"(i64 %v88, i64 %v89, i64 %v90, i64 %v87, i64 %v85)
  %v92 = getelementptr i8, ptr %v91, i64 %v84
  %v93.p = getelementptr i64, ptr %v82, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = inttoptr i64 %v93 to ptr
  call void @"rt.copy8"(ptr %v92, ptr %v94, i64 %v85)
  %v95 = getelementptr i64, ptr %s2, i64 0
  %v96 = ptrtoint ptr %v91 to i64
  %st46 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st46
  %st47 = getelementptr i64, ptr %v95, i64 1
  store i64 %v86, ptr %st47
  %st48 = getelementptr i64, ptr %v95, i64 2
  store i64 %v87, ptr %st48
  %v97 = getelementptr i64, ptr %s8, i64 0
  %v98.p = getelementptr i64, ptr %v95, i64 0
  %v98 = load i64, ptr %v98.p
  %st49 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st49
  %v99.p = getelementptr i64, ptr %v95, i64 1
  %v99 = load i64, ptr %v99.p
  %st50 = getelementptr i64, ptr %v97, i64 1
  store i64 %v99, ptr %st50
  %v100.p = getelementptr i64, ptr %v95, i64 2
  %v100 = load i64, ptr %v100.p
  %st51 = getelementptr i64, ptr %v97, i64 2
  store i64 %v100, ptr %st51
  %v602 = getelementptr i64, ptr @"rt.meta", i64 0
  %v101.p = getelementptr i64, ptr %v602, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 6
  %v103 = call ptr @"rt.region_alloc"(i64 %v101, i64 %v102)
  %v104.p = getelementptr i64, ptr %v75, i64 0
  %v104 = load i64, ptr %v104.p
  %st52 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st52
  %v105.p = getelementptr i64, ptr %v75, i64 1
  %v105 = load i64, ptr %v105.p
  %st53 = getelementptr i64, ptr %v103, i64 1
  store i64 %v105, ptr %st53
  %v106.p = getelementptr i64, ptr %v75, i64 2
  %v106 = load i64, ptr %v106.p
  %st54 = getelementptr i64, ptr %v103, i64 2
  store i64 %v106, ptr %st54
  %v107.p = getelementptr i64, ptr %v97, i64 0
  %v107 = load i64, ptr %v107.p
  %st55 = getelementptr i64, ptr %v103, i64 3
  store i64 %v107, ptr %st55
  %v108.p = getelementptr i64, ptr %v97, i64 1
  %v108 = load i64, ptr %v108.p
  %st56 = getelementptr i64, ptr %v103, i64 4
  store i64 %v108, ptr %st56
  %v109.p = getelementptr i64, ptr %v97, i64 2
  %v109 = load i64, ptr %v109.p
  %st57 = getelementptr i64, ptr %v103, i64 5
  store i64 %v109, ptr %st57
  %v110 = add i64 0, 2
  %v111 = getelementptr i64, ptr %s9, i64 0
  %v112 = ptrtoint ptr %v103 to i64
  %st58 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st58
  %st59 = getelementptr i64, ptr %v111, i64 1
  store i64 %v110, ptr %st59
  %st60 = getelementptr i64, ptr %v111, i64 2
  store i64 %v101, ptr %st60
  %v113.p = getelementptr i64, ptr %v111, i64 0
  %v113 = load i64, ptr %v113.p
  %v114.p = getelementptr i64, ptr %v111, i64 1
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v111, i64 2
  %v115 = load i64, ptr %v115.p
  call void @"std/os.Run"(ptr %v61, i64 %v67, i64 %v68, i64 %v69, i64 %v113, i64 %v114, i64 %v115)
  %v116.p = getelementptr i64, ptr %v61, i64 0
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 1
  %v118 = getelementptr i64, ptr %v61, i64 %v117
  %v119.p = getelementptr i64, ptr %v118, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = add i64 0, 0
  %v121.c = icmp ne i64 %v119, %v120
  %v121 = zext i1 %v121.c to i64
  %c.b2 = icmp ne i64 %v121, 0
  br i1 %c.b2, label %b2.t62, label %b2.e63
b2.t62:
  br label %b5
b2.e63:
  br label %b6
b3:
  %v59 = add i64 0, 3
  %v60 = getelementptr i64, ptr %v0, i64 %v59
  %v603 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v60, i64 %v603, i64 %v5)
  br label %b4
b4:
  %v604 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v604, i64 0
  store i64 %v5, ptr %st63
  ret void
b5:
  %v122 = add i64 0, 0
  %v123.p = getelementptr i64, ptr %v118, i64 0
  %v123 = load i64, ptr %v123.p
  %st64 = getelementptr i64, ptr %v0, i64 0
  store i64 %v123, ptr %st64
  %v124.p = getelementptr i64, ptr %v118, i64 1
  %v124 = load i64, ptr %v124.p
  %st65 = getelementptr i64, ptr %v0, i64 1
  store i64 %v124, ptr %st65
  %v125.p = getelementptr i64, ptr %v118, i64 2
  %v125 = load i64, ptr %v125.p
  %st66 = getelementptr i64, ptr %v0, i64 2
  store i64 %v125, ptr %st66
  %v126.p = getelementptr i64, ptr %v118, i64 3
  %v126 = load i64, ptr %v126.p
  %st67 = getelementptr i64, ptr %v0, i64 3
  store i64 %v126, ptr %st67
  %v127.p = getelementptr i64, ptr %v118, i64 4
  %v127 = load i64, ptr %v127.p
  %st68 = getelementptr i64, ptr %v0, i64 4
  store i64 %v127, ptr %st68
  %v128.p = getelementptr i64, ptr %v118, i64 5
  %v128 = load i64, ptr %v128.p
  %st69 = getelementptr i64, ptr %v0, i64 5
  store i64 %v128, ptr %st69
  %v129.p = getelementptr i64, ptr %v0, i64 0
  %v129 = load i64, ptr %v129.p
  %v130 = add i64 0, 0
  %v131.c = icmp ne i64 %v129, %v130
  %v131 = zext i1 %v131.c to i64
  %c.b5 = icmp ne i64 %v131, 0
  br i1 %c.b5, label %b5.t71, label %b5.e72
b5.t71:
  br label %b7
b5.e72:
  br label %b8
b6:
  %v134 = getelementptr i64, ptr %s10, i64 0
  %v135 = getelementptr i64, ptr @"str.13", i64 0
  %v136 = add i64 0, 6
  %v137 = add i64 0, 0
  %v138 = getelementptr i64, ptr %s9, i64 0
  %v139 = ptrtoint ptr %v135 to i64
  %st72 = getelementptr i64, ptr %v138, i64 0
  store i64 %v139, ptr %st72
  %st73 = getelementptr i64, ptr %v138, i64 1
  store i64 %v136, ptr %st73
  %st74 = getelementptr i64, ptr %v138, i64 2
  store i64 %v137, ptr %st74
  %v140.p = getelementptr i64, ptr %v4, i64 1
  %v140 = load i64, ptr %v140.p
  %v141.p = getelementptr i64, ptr %v138, i64 1
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 %v140, %v141
  %v605 = getelementptr i64, ptr @"rt.meta", i64 0
  %v143.p = getelementptr i64, ptr %v605, i64 0
  %v143 = load i64, ptr %v143.p
  %v144.p = getelementptr i64, ptr %v4, i64 0
  %v144 = load i64, ptr %v144.p
  %v145.p = getelementptr i64, ptr %v4, i64 1
  %v145 = load i64, ptr %v145.p
  %v146.p = getelementptr i64, ptr %v4, i64 2
  %v146 = load i64, ptr %v146.p
  %v147 = call ptr @"rt.cat8"(i64 %v144, i64 %v145, i64 %v146, i64 %v143, i64 %v141)
  %v148 = getelementptr i8, ptr %v147, i64 %v140
  %v149.p = getelementptr i64, ptr %v138, i64 0
  %v149 = load i64, ptr %v149.p
  %v150 = inttoptr i64 %v149 to ptr
  call void @"rt.copy8"(ptr %v148, ptr %v150, i64 %v141)
  %v151 = getelementptr i64, ptr %s8, i64 0
  %v152 = ptrtoint ptr %v147 to i64
  %st75 = getelementptr i64, ptr %v151, i64 0
  store i64 %v152, ptr %st75
  %st76 = getelementptr i64, ptr %v151, i64 1
  store i64 %v142, ptr %st76
  %st77 = getelementptr i64, ptr %v151, i64 2
  store i64 %v143, ptr %st77
  %v153.p = getelementptr i64, ptr %v151, i64 0
  %v153 = load i64, ptr %v153.p
  %v154.p = getelementptr i64, ptr %v151, i64 1
  %v154 = load i64, ptr %v154.p
  %v155.p = getelementptr i64, ptr %v151, i64 2
  %v155 = load i64, ptr %v155.p
  %v156 = getelementptr i64, ptr @"str.14", i64 0
  %v157 = add i64 0, 11
  %v158 = add i64 0, 0
  %v159 = getelementptr i64, ptr %s2, i64 0
  %v160 = ptrtoint ptr %v156 to i64
  %st78 = getelementptr i64, ptr %v159, i64 0
  store i64 %v160, ptr %st78
  %st79 = getelementptr i64, ptr %v159, i64 1
  store i64 %v157, ptr %st79
  %st80 = getelementptr i64, ptr %v159, i64 2
  store i64 %v158, ptr %st80
  %v161.p = getelementptr i64, ptr %v159, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v159, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v159, i64 2
  %v163 = load i64, ptr %v163.p
  call void @"std/io.WriteFile"(ptr %v134, i64 %v153, i64 %v154, i64 %v155, i64 %v161, i64 %v162, i64 %v163)
  %v164.p = getelementptr i64, ptr %v134, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 0, 0
  %v166.c = icmp ne i64 %v164, %v165
  %v166 = zext i1 %v166.c to i64
  %c.b6 = icmp ne i64 %v166, 0
  br i1 %c.b6, label %b6.t82, label %b6.e83
b6.t82:
  br label %b9
b6.e83:
  br label %b10
b7:
  %v132 = add i64 0, 3
  %v133 = getelementptr i64, ptr %v0, i64 %v132
  %v606 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v133, i64 %v606, i64 %v5)
  br label %b8
b8:
  %v607 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v607, i64 0
  store i64 %v5, ptr %st83
  ret void
b9:
  %v167 = add i64 0, 0
  %v168.p = getelementptr i64, ptr %v134, i64 0
  %v168 = load i64, ptr %v168.p
  %st84 = getelementptr i64, ptr %v0, i64 0
  store i64 %v168, ptr %st84
  %v169.p = getelementptr i64, ptr %v134, i64 1
  %v169 = load i64, ptr %v169.p
  %st85 = getelementptr i64, ptr %v0, i64 1
  store i64 %v169, ptr %st85
  %v170.p = getelementptr i64, ptr %v134, i64 2
  %v170 = load i64, ptr %v170.p
  %st86 = getelementptr i64, ptr %v0, i64 2
  store i64 %v170, ptr %st86
  %v171.p = getelementptr i64, ptr %v134, i64 3
  %v171 = load i64, ptr %v171.p
  %st87 = getelementptr i64, ptr %v0, i64 3
  store i64 %v171, ptr %st87
  %v172.p = getelementptr i64, ptr %v134, i64 4
  %v172 = load i64, ptr %v172.p
  %st88 = getelementptr i64, ptr %v0, i64 4
  store i64 %v172, ptr %st88
  %v173.p = getelementptr i64, ptr %v134, i64 5
  %v173 = load i64, ptr %v173.p
  %st89 = getelementptr i64, ptr %v0, i64 5
  store i64 %v173, ptr %st89
  %v174.p = getelementptr i64, ptr %v0, i64 0
  %v174 = load i64, ptr %v174.p
  %v175 = add i64 0, 0
  %v176.c = icmp ne i64 %v174, %v175
  %v176 = zext i1 %v176.c to i64
  %c.b9 = icmp ne i64 %v176, 0
  br i1 %c.b9, label %b9.t91, label %b9.e92
b9.t91:
  br label %b11
b9.e92:
  br label %b12
b10:
  %v179 = getelementptr i64, ptr %s11, i64 0
  %v180 = getelementptr i64, ptr @"str.15", i64 0
  %v181 = add i64 0, 6
  %v182 = add i64 0, 0
  %v183 = getelementptr i64, ptr %s2, i64 0
  %v184 = ptrtoint ptr %v180 to i64
  %st92 = getelementptr i64, ptr %v183, i64 0
  store i64 %v184, ptr %st92
  %st93 = getelementptr i64, ptr %v183, i64 1
  store i64 %v181, ptr %st93
  %st94 = getelementptr i64, ptr %v183, i64 2
  store i64 %v182, ptr %st94
  %v185.p = getelementptr i64, ptr %v4, i64 1
  %v185 = load i64, ptr %v185.p
  %v186.p = getelementptr i64, ptr %v183, i64 1
  %v186 = load i64, ptr %v186.p
  %v187 = add i64 %v185, %v186
  %v608 = getelementptr i64, ptr @"rt.meta", i64 0
  %v188.p = getelementptr i64, ptr %v608, i64 0
  %v188 = load i64, ptr %v188.p
  %v189.p = getelementptr i64, ptr %v4, i64 0
  %v189 = load i64, ptr %v189.p
  %v190.p = getelementptr i64, ptr %v4, i64 1
  %v190 = load i64, ptr %v190.p
  %v191.p = getelementptr i64, ptr %v4, i64 2
  %v191 = load i64, ptr %v191.p
  %v192 = call ptr @"rt.cat8"(i64 %v189, i64 %v190, i64 %v191, i64 %v188, i64 %v186)
  %v193 = getelementptr i8, ptr %v192, i64 %v185
  %v194.p = getelementptr i64, ptr %v183, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = inttoptr i64 %v194 to ptr
  call void @"rt.copy8"(ptr %v193, ptr %v195, i64 %v186)
  %v196 = getelementptr i64, ptr %s8, i64 0
  %v197 = ptrtoint ptr %v192 to i64
  %st95 = getelementptr i64, ptr %v196, i64 0
  store i64 %v197, ptr %st95
  %st96 = getelementptr i64, ptr %v196, i64 1
  store i64 %v187, ptr %st96
  %st97 = getelementptr i64, ptr %v196, i64 2
  store i64 %v188, ptr %st97
  %v198.p = getelementptr i64, ptr %v196, i64 0
  %v198 = load i64, ptr %v198.p
  %v199.p = getelementptr i64, ptr %v196, i64 1
  %v199 = load i64, ptr %v199.p
  %v200.p = getelementptr i64, ptr %v196, i64 2
  %v200 = load i64, ptr %v200.p
  %v609 = getelementptr i64, ptr @"rt.meta", i64 0
  %v201.p = getelementptr i64, ptr %v609, i64 0
  %v201 = load i64, ptr %v201.p
  %v202 = add i64 0, 0
  %v203 = call ptr @"rt.region_alloc8"(i64 %v201, i64 %v202)
  %v204 = add i64 0, 0
  %v205 = getelementptr i64, ptr %s9, i64 0
  %v206 = ptrtoint ptr %v203 to i64
  %st98 = getelementptr i64, ptr %v205, i64 0
  store i64 %v206, ptr %st98
  %st99 = getelementptr i64, ptr %v205, i64 1
  store i64 %v204, ptr %st99
  %st100 = getelementptr i64, ptr %v205, i64 2
  store i64 %v201, ptr %st100
  %v207.p = getelementptr i64, ptr %v205, i64 0
  %v207 = load i64, ptr %v207.p
  %v208.p = getelementptr i64, ptr %v205, i64 1
  %v208 = load i64, ptr %v208.p
  %v209.p = getelementptr i64, ptr %v205, i64 2
  %v209 = load i64, ptr %v209.p
  call void @"std/io.WriteFile"(ptr %v179, i64 %v198, i64 %v199, i64 %v200, i64 %v207, i64 %v208, i64 %v209)
  %v210.p = getelementptr i64, ptr %v179, i64 0
  %v210 = load i64, ptr %v210.p
  %v211 = add i64 0, 0
  %v212.c = icmp ne i64 %v210, %v211
  %v212 = zext i1 %v212.c to i64
  %c.b10 = icmp ne i64 %v212, 0
  br i1 %c.b10, label %b10.t102, label %b10.e103
b10.t102:
  br label %b13
b10.e103:
  br label %b14
b11:
  %v177 = add i64 0, 3
  %v178 = getelementptr i64, ptr %v0, i64 %v177
  %v610 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v178, i64 %v610, i64 %v5)
  br label %b12
b12:
  %v611 = getelementptr i64, ptr @"rt.meta", i64 0
  %st103 = getelementptr i64, ptr %v611, i64 0
  store i64 %v5, ptr %st103
  ret void
b13:
  %v213 = add i64 0, 0
  %v214.p = getelementptr i64, ptr %v179, i64 0
  %v214 = load i64, ptr %v214.p
  %st104 = getelementptr i64, ptr %v0, i64 0
  store i64 %v214, ptr %st104
  %v215.p = getelementptr i64, ptr %v179, i64 1
  %v215 = load i64, ptr %v215.p
  %st105 = getelementptr i64, ptr %v0, i64 1
  store i64 %v215, ptr %st105
  %v216.p = getelementptr i64, ptr %v179, i64 2
  %v216 = load i64, ptr %v216.p
  %st106 = getelementptr i64, ptr %v0, i64 2
  store i64 %v216, ptr %st106
  %v217.p = getelementptr i64, ptr %v179, i64 3
  %v217 = load i64, ptr %v217.p
  %st107 = getelementptr i64, ptr %v0, i64 3
  store i64 %v217, ptr %st107
  %v218.p = getelementptr i64, ptr %v179, i64 4
  %v218 = load i64, ptr %v218.p
  %st108 = getelementptr i64, ptr %v0, i64 4
  store i64 %v218, ptr %st108
  %v219.p = getelementptr i64, ptr %v179, i64 5
  %v219 = load i64, ptr %v219.p
  %st109 = getelementptr i64, ptr %v0, i64 5
  store i64 %v219, ptr %st109
  %v220.p = getelementptr i64, ptr %v0, i64 0
  %v220 = load i64, ptr %v220.p
  %v221 = add i64 0, 0
  %v222.c = icmp ne i64 %v220, %v221
  %v222 = zext i1 %v222.c to i64
  %c.b13 = icmp ne i64 %v222, 0
  br i1 %c.b13, label %b13.t111, label %b13.e112
b13.t111:
  br label %b15
b13.e112:
  br label %b16
b14:
  %v225 = getelementptr i64, ptr %s12, i64 0
  %v226 = getelementptr i64, ptr @"str.16", i64 0
  %v227 = add i64 0, 15
  %v228 = add i64 0, 0
  %v229 = getelementptr i64, ptr %s9, i64 0
  %v230 = ptrtoint ptr %v226 to i64
  %st112 = getelementptr i64, ptr %v229, i64 0
  store i64 %v230, ptr %st112
  %st113 = getelementptr i64, ptr %v229, i64 1
  store i64 %v227, ptr %st113
  %st114 = getelementptr i64, ptr %v229, i64 2
  store i64 %v228, ptr %st114
  %v231.p = getelementptr i64, ptr %v229, i64 0
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v229, i64 1
  %v232 = load i64, ptr %v232.p
  %v233.p = getelementptr i64, ptr %v229, i64 2
  %v233 = load i64, ptr %v233.p
  %v234 = getelementptr i64, ptr @"str.17", i64 0
  %v235 = add i64 0, 5
  %v236 = add i64 0, 0
  %v237 = getelementptr i64, ptr %s8, i64 0
  %v238 = ptrtoint ptr %v234 to i64
  %st115 = getelementptr i64, ptr %v237, i64 0
  store i64 %v238, ptr %st115
  %st116 = getelementptr i64, ptr %v237, i64 1
  store i64 %v235, ptr %st116
  %st117 = getelementptr i64, ptr %v237, i64 2
  store i64 %v236, ptr %st117
  %v239.p = getelementptr i64, ptr %v4, i64 1
  %v239 = load i64, ptr %v239.p
  %v240.p = getelementptr i64, ptr %v237, i64 1
  %v240 = load i64, ptr %v240.p
  %v241 = add i64 %v239, %v240
  %v612 = getelementptr i64, ptr @"rt.meta", i64 0
  %v242.p = getelementptr i64, ptr %v612, i64 0
  %v242 = load i64, ptr %v242.p
  %v243.p = getelementptr i64, ptr %v4, i64 0
  %v243 = load i64, ptr %v243.p
  %v244.p = getelementptr i64, ptr %v4, i64 1
  %v244 = load i64, ptr %v244.p
  %v245.p = getelementptr i64, ptr %v4, i64 2
  %v245 = load i64, ptr %v245.p
  %v246 = call ptr @"rt.cat8"(i64 %v243, i64 %v244, i64 %v245, i64 %v242, i64 %v240)
  %v247 = getelementptr i8, ptr %v246, i64 %v239
  %v248.p = getelementptr i64, ptr %v237, i64 0
  %v248 = load i64, ptr %v248.p
  %v249 = inttoptr i64 %v248 to ptr
  call void @"rt.copy8"(ptr %v247, ptr %v249, i64 %v240)
  %v250 = getelementptr i64, ptr %s2, i64 0
  %v251 = ptrtoint ptr %v246 to i64
  %st118 = getelementptr i64, ptr %v250, i64 0
  store i64 %v251, ptr %st118
  %st119 = getelementptr i64, ptr %v250, i64 1
  store i64 %v241, ptr %st119
  %st120 = getelementptr i64, ptr %v250, i64 2
  store i64 %v242, ptr %st120
  %v252 = getelementptr i64, ptr %s3, i64 0
  %v253.p = getelementptr i64, ptr %v250, i64 0
  %v253 = load i64, ptr %v253.p
  %st121 = getelementptr i64, ptr %v252, i64 0
  store i64 %v253, ptr %st121
  %v254.p = getelementptr i64, ptr %v250, i64 1
  %v254 = load i64, ptr %v254.p
  %st122 = getelementptr i64, ptr %v252, i64 1
  store i64 %v254, ptr %st122
  %v255.p = getelementptr i64, ptr %v250, i64 2
  %v255 = load i64, ptr %v255.p
  %st123 = getelementptr i64, ptr %v252, i64 2
  store i64 %v255, ptr %st123
  %v613 = getelementptr i64, ptr @"rt.meta", i64 0
  %v256.p = getelementptr i64, ptr %v613, i64 0
  %v256 = load i64, ptr %v256.p
  %v257 = add i64 0, 3
  %v258 = call ptr @"rt.region_alloc"(i64 %v256, i64 %v257)
  %v259.p = getelementptr i64, ptr %v252, i64 0
  %v259 = load i64, ptr %v259.p
  %st124 = getelementptr i64, ptr %v258, i64 0
  store i64 %v259, ptr %st124
  %v260.p = getelementptr i64, ptr %v252, i64 1
  %v260 = load i64, ptr %v260.p
  %st125 = getelementptr i64, ptr %v258, i64 1
  store i64 %v260, ptr %st125
  %v261.p = getelementptr i64, ptr %v252, i64 2
  %v261 = load i64, ptr %v261.p
  %st126 = getelementptr i64, ptr %v258, i64 2
  store i64 %v261, ptr %st126
  %v262 = add i64 0, 1
  %v263 = getelementptr i64, ptr %s4, i64 0
  %v264 = ptrtoint ptr %v258 to i64
  %st127 = getelementptr i64, ptr %v263, i64 0
  store i64 %v264, ptr %st127
  %st128 = getelementptr i64, ptr %v263, i64 1
  store i64 %v262, ptr %st128
  %st129 = getelementptr i64, ptr %v263, i64 2
  store i64 %v256, ptr %st129
  %v265.p = getelementptr i64, ptr %v263, i64 0
  %v265 = load i64, ptr %v265.p
  %v266.p = getelementptr i64, ptr %v263, i64 1
  %v266 = load i64, ptr %v266.p
  %v267.p = getelementptr i64, ptr %v263, i64 2
  %v267 = load i64, ptr %v267.p
  call void @"std/os.Run"(ptr %v225, i64 %v231, i64 %v232, i64 %v233, i64 %v265, i64 %v266, i64 %v267)
  %v268.p = getelementptr i64, ptr %v225, i64 0
  %v268 = load i64, ptr %v268.p
  %v269 = add i64 0, 1
  %v270 = getelementptr i64, ptr %v225, i64 %v269
  %v271.p = getelementptr i64, ptr %v270, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 0, 0
  %v273.c = icmp ne i64 %v271, %v272
  %v273 = zext i1 %v273.c to i64
  %c.b14 = icmp ne i64 %v273, 0
  br i1 %c.b14, label %b14.t131, label %b14.e132
b14.t131:
  br label %b17
b14.e132:
  br label %b18
b15:
  %v223 = add i64 0, 3
  %v224 = getelementptr i64, ptr %v0, i64 %v223
  %v614 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v224, i64 %v614, i64 %v5)
  br label %b16
b16:
  %v615 = getelementptr i64, ptr @"rt.meta", i64 0
  %st132 = getelementptr i64, ptr %v615, i64 0
  store i64 %v5, ptr %st132
  ret void
b17:
  %v274 = add i64 0, 0
  %v275.p = getelementptr i64, ptr %v270, i64 0
  %v275 = load i64, ptr %v275.p
  %st133 = getelementptr i64, ptr %v0, i64 0
  store i64 %v275, ptr %st133
  %v276.p = getelementptr i64, ptr %v270, i64 1
  %v276 = load i64, ptr %v276.p
  %st134 = getelementptr i64, ptr %v0, i64 1
  store i64 %v276, ptr %st134
  %v277.p = getelementptr i64, ptr %v270, i64 2
  %v277 = load i64, ptr %v277.p
  %st135 = getelementptr i64, ptr %v0, i64 2
  store i64 %v277, ptr %st135
  %v278.p = getelementptr i64, ptr %v270, i64 3
  %v278 = load i64, ptr %v278.p
  %st136 = getelementptr i64, ptr %v0, i64 3
  store i64 %v278, ptr %st136
  %v279.p = getelementptr i64, ptr %v270, i64 4
  %v279 = load i64, ptr %v279.p
  %st137 = getelementptr i64, ptr %v0, i64 4
  store i64 %v279, ptr %st137
  %v280.p = getelementptr i64, ptr %v270, i64 5
  %v280 = load i64, ptr %v280.p
  %st138 = getelementptr i64, ptr %v0, i64 5
  store i64 %v280, ptr %st138
  %v281.p = getelementptr i64, ptr %v0, i64 0
  %v281 = load i64, ptr %v281.p
  %v282 = add i64 0, 0
  %v283.c = icmp ne i64 %v281, %v282
  %v283 = zext i1 %v283.c to i64
  %c.b17 = icmp ne i64 %v283, 0
  br i1 %c.b17, label %b17.t140, label %b17.e141
b17.t140:
  br label %b19
b17.e141:
  br label %b20
b18:
  %v286 = getelementptr i64, ptr %s13, i64 0
  %v287 = getelementptr i64, ptr @"str.18", i64 0
  %v288 = add i64 0, 14
  %v289 = add i64 0, 0
  %v290 = getelementptr i64, ptr %s4, i64 0
  %v291 = ptrtoint ptr %v287 to i64
  %st141 = getelementptr i64, ptr %v290, i64 0
  store i64 %v291, ptr %st141
  %st142 = getelementptr i64, ptr %v290, i64 1
  store i64 %v288, ptr %st142
  %st143 = getelementptr i64, ptr %v290, i64 2
  store i64 %v289, ptr %st143
  %v292.p = getelementptr i64, ptr %v290, i64 0
  %v292 = load i64, ptr %v292.p
  %v293.p = getelementptr i64, ptr %v290, i64 1
  %v293 = load i64, ptr %v293.p
  %v294.p = getelementptr i64, ptr %v290, i64 2
  %v294 = load i64, ptr %v294.p
  %v295 = getelementptr i64, ptr @"str.19", i64 0
  %v296 = add i64 0, 2
  %v297 = add i64 0, 0
  %v298 = getelementptr i64, ptr %s3, i64 0
  %v299 = ptrtoint ptr %v295 to i64
  %st144 = getelementptr i64, ptr %v298, i64 0
  store i64 %v299, ptr %st144
  %st145 = getelementptr i64, ptr %v298, i64 1
  store i64 %v296, ptr %st145
  %st146 = getelementptr i64, ptr %v298, i64 2
  store i64 %v297, ptr %st146
  %v300 = getelementptr i64, ptr %s2, i64 0
  %v301.p = getelementptr i64, ptr %v298, i64 0
  %v301 = load i64, ptr %v301.p
  %st147 = getelementptr i64, ptr %v300, i64 0
  store i64 %v301, ptr %st147
  %v302.p = getelementptr i64, ptr %v298, i64 1
  %v302 = load i64, ptr %v302.p
  %st148 = getelementptr i64, ptr %v300, i64 1
  store i64 %v302, ptr %st148
  %v303.p = getelementptr i64, ptr %v298, i64 2
  %v303 = load i64, ptr %v303.p
  %st149 = getelementptr i64, ptr %v300, i64 2
  store i64 %v303, ptr %st149
  %v304 = getelementptr i64, ptr @"str.20", i64 0
  %v305 = add i64 0, 21
  %v306 = add i64 0, 0
  %v307 = getelementptr i64, ptr %s8, i64 0
  %v308 = ptrtoint ptr %v304 to i64
  %st150 = getelementptr i64, ptr %v307, i64 0
  store i64 %v308, ptr %st150
  %st151 = getelementptr i64, ptr %v307, i64 1
  store i64 %v305, ptr %st151
  %st152 = getelementptr i64, ptr %v307, i64 2
  store i64 %v306, ptr %st152
  %v309 = getelementptr i64, ptr %s9, i64 0
  %v310.p = getelementptr i64, ptr %v307, i64 0
  %v310 = load i64, ptr %v310.p
  %st153 = getelementptr i64, ptr %v309, i64 0
  store i64 %v310, ptr %st153
  %v311.p = getelementptr i64, ptr %v307, i64 1
  %v311 = load i64, ptr %v311.p
  %st154 = getelementptr i64, ptr %v309, i64 1
  store i64 %v311, ptr %st154
  %v312.p = getelementptr i64, ptr %v307, i64 2
  %v312 = load i64, ptr %v312.p
  %st155 = getelementptr i64, ptr %v309, i64 2
  store i64 %v312, ptr %st155
  %v313 = getelementptr i64, ptr @"str.13", i64 0
  %v314 = add i64 0, 6
  %v315 = add i64 0, 0
  %v316 = getelementptr i64, ptr %s5, i64 0
  %v317 = ptrtoint ptr %v313 to i64
  %st156 = getelementptr i64, ptr %v316, i64 0
  store i64 %v317, ptr %st156
  %st157 = getelementptr i64, ptr %v316, i64 1
  store i64 %v314, ptr %st157
  %st158 = getelementptr i64, ptr %v316, i64 2
  store i64 %v315, ptr %st158
  %v318.p = getelementptr i64, ptr %v4, i64 1
  %v318 = load i64, ptr %v318.p
  %v319.p = getelementptr i64, ptr %v316, i64 1
  %v319 = load i64, ptr %v319.p
  %v320 = add i64 %v318, %v319
  %v616 = getelementptr i64, ptr @"rt.meta", i64 0
  %v321.p = getelementptr i64, ptr %v616, i64 0
  %v321 = load i64, ptr %v321.p
  %v322.p = getelementptr i64, ptr %v4, i64 0
  %v322 = load i64, ptr %v322.p
  %v323.p = getelementptr i64, ptr %v4, i64 1
  %v323 = load i64, ptr %v323.p
  %v324.p = getelementptr i64, ptr %v4, i64 2
  %v324 = load i64, ptr %v324.p
  %v325 = call ptr @"rt.cat8"(i64 %v322, i64 %v323, i64 %v324, i64 %v321, i64 %v319)
  %v326 = getelementptr i8, ptr %v325, i64 %v318
  %v327.p = getelementptr i64, ptr %v316, i64 0
  %v327 = load i64, ptr %v327.p
  %v328 = inttoptr i64 %v327 to ptr
  call void @"rt.copy8"(ptr %v326, ptr %v328, i64 %v319)
  %v329 = getelementptr i64, ptr %s6, i64 0
  %v330 = ptrtoint ptr %v325 to i64
  %st159 = getelementptr i64, ptr %v329, i64 0
  store i64 %v330, ptr %st159
  %st160 = getelementptr i64, ptr %v329, i64 1
  store i64 %v320, ptr %st160
  %st161 = getelementptr i64, ptr %v329, i64 2
  store i64 %v321, ptr %st161
  %v331 = getelementptr i64, ptr %s14, i64 0
  %v332.p = getelementptr i64, ptr %v329, i64 0
  %v332 = load i64, ptr %v332.p
  %st162 = getelementptr i64, ptr %v331, i64 0
  store i64 %v332, ptr %st162
  %v333.p = getelementptr i64, ptr %v329, i64 1
  %v333 = load i64, ptr %v333.p
  %st163 = getelementptr i64, ptr %v331, i64 1
  store i64 %v333, ptr %st163
  %v334.p = getelementptr i64, ptr %v329, i64 2
  %v334 = load i64, ptr %v334.p
  %st164 = getelementptr i64, ptr %v331, i64 2
  store i64 %v334, ptr %st164
  %v335 = getelementptr i64, ptr @"str.15", i64 0
  %v336 = add i64 0, 6
  %v337 = add i64 0, 0
  %v338 = getelementptr i64, ptr %s15, i64 0
  %v339 = ptrtoint ptr %v335 to i64
  %st165 = getelementptr i64, ptr %v338, i64 0
  store i64 %v339, ptr %st165
  %st166 = getelementptr i64, ptr %v338, i64 1
  store i64 %v336, ptr %st166
  %st167 = getelementptr i64, ptr %v338, i64 2
  store i64 %v337, ptr %st167
  %v340.p = getelementptr i64, ptr %v4, i64 1
  %v340 = load i64, ptr %v340.p
  %v341.p = getelementptr i64, ptr %v338, i64 1
  %v341 = load i64, ptr %v341.p
  %v342 = add i64 %v340, %v341
  %v617 = getelementptr i64, ptr @"rt.meta", i64 0
  %v343.p = getelementptr i64, ptr %v617, i64 0
  %v343 = load i64, ptr %v343.p
  %v344.p = getelementptr i64, ptr %v4, i64 0
  %v344 = load i64, ptr %v344.p
  %v345.p = getelementptr i64, ptr %v4, i64 1
  %v345 = load i64, ptr %v345.p
  %v346.p = getelementptr i64, ptr %v4, i64 2
  %v346 = load i64, ptr %v346.p
  %v347 = call ptr @"rt.cat8"(i64 %v344, i64 %v345, i64 %v346, i64 %v343, i64 %v341)
  %v348 = getelementptr i8, ptr %v347, i64 %v340
  %v349.p = getelementptr i64, ptr %v338, i64 0
  %v349 = load i64, ptr %v349.p
  %v350 = inttoptr i64 %v349 to ptr
  call void @"rt.copy8"(ptr %v348, ptr %v350, i64 %v341)
  %v351 = getelementptr i64, ptr %s16, i64 0
  %v352 = ptrtoint ptr %v347 to i64
  %st168 = getelementptr i64, ptr %v351, i64 0
  store i64 %v352, ptr %st168
  %st169 = getelementptr i64, ptr %v351, i64 1
  store i64 %v342, ptr %st169
  %st170 = getelementptr i64, ptr %v351, i64 2
  store i64 %v343, ptr %st170
  %v353 = getelementptr i64, ptr %s17, i64 0
  %v354.p = getelementptr i64, ptr %v351, i64 0
  %v354 = load i64, ptr %v354.p
  %st171 = getelementptr i64, ptr %v353, i64 0
  store i64 %v354, ptr %st171
  %v355.p = getelementptr i64, ptr %v351, i64 1
  %v355 = load i64, ptr %v355.p
  %st172 = getelementptr i64, ptr %v353, i64 1
  store i64 %v355, ptr %st172
  %v356.p = getelementptr i64, ptr %v351, i64 2
  %v356 = load i64, ptr %v356.p
  %st173 = getelementptr i64, ptr %v353, i64 2
  store i64 %v356, ptr %st173
  %v357 = getelementptr i64, ptr @"str.12", i64 0
  %v358 = add i64 0, 4
  %v359 = add i64 0, 0
  %v360 = getelementptr i64, ptr %s18, i64 0
  %v361 = ptrtoint ptr %v357 to i64
  %st174 = getelementptr i64, ptr %v360, i64 0
  store i64 %v361, ptr %st174
  %st175 = getelementptr i64, ptr %v360, i64 1
  store i64 %v358, ptr %st175
  %st176 = getelementptr i64, ptr %v360, i64 2
  store i64 %v359, ptr %st176
  %v362.p = getelementptr i64, ptr %v4, i64 1
  %v362 = load i64, ptr %v362.p
  %v363.p = getelementptr i64, ptr %v360, i64 1
  %v363 = load i64, ptr %v363.p
  %v364 = add i64 %v362, %v363
  %v618 = getelementptr i64, ptr @"rt.meta", i64 0
  %v365.p = getelementptr i64, ptr %v618, i64 0
  %v365 = load i64, ptr %v365.p
  %v366.p = getelementptr i64, ptr %v4, i64 0
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v4, i64 1
  %v367 = load i64, ptr %v367.p
  %v368.p = getelementptr i64, ptr %v4, i64 2
  %v368 = load i64, ptr %v368.p
  %v369 = call ptr @"rt.cat8"(i64 %v366, i64 %v367, i64 %v368, i64 %v365, i64 %v363)
  %v370 = getelementptr i8, ptr %v369, i64 %v362
  %v371.p = getelementptr i64, ptr %v360, i64 0
  %v371 = load i64, ptr %v371.p
  %v372 = inttoptr i64 %v371 to ptr
  call void @"rt.copy8"(ptr %v370, ptr %v372, i64 %v363)
  %v373 = getelementptr i64, ptr %s19, i64 0
  %v374 = ptrtoint ptr %v369 to i64
  %st177 = getelementptr i64, ptr %v373, i64 0
  store i64 %v374, ptr %st177
  %st178 = getelementptr i64, ptr %v373, i64 1
  store i64 %v364, ptr %st178
  %st179 = getelementptr i64, ptr %v373, i64 2
  store i64 %v365, ptr %st179
  %v375 = getelementptr i64, ptr %s20, i64 0
  %v376.p = getelementptr i64, ptr %v373, i64 0
  %v376 = load i64, ptr %v376.p
  %st180 = getelementptr i64, ptr %v375, i64 0
  store i64 %v376, ptr %st180
  %v377.p = getelementptr i64, ptr %v373, i64 1
  %v377 = load i64, ptr %v377.p
  %st181 = getelementptr i64, ptr %v375, i64 1
  store i64 %v377, ptr %st181
  %v378.p = getelementptr i64, ptr %v373, i64 2
  %v378 = load i64, ptr %v378.p
  %st182 = getelementptr i64, ptr %v375, i64 2
  store i64 %v378, ptr %st182
  %v379 = getelementptr i64, ptr @"str.17", i64 0
  %v380 = add i64 0, 5
  %v381 = add i64 0, 0
  %v382 = getelementptr i64, ptr %s21, i64 0
  %v383 = ptrtoint ptr %v379 to i64
  %st183 = getelementptr i64, ptr %v382, i64 0
  store i64 %v383, ptr %st183
  %st184 = getelementptr i64, ptr %v382, i64 1
  store i64 %v380, ptr %st184
  %st185 = getelementptr i64, ptr %v382, i64 2
  store i64 %v381, ptr %st185
  %v384.p = getelementptr i64, ptr %v4, i64 1
  %v384 = load i64, ptr %v384.p
  %v385.p = getelementptr i64, ptr %v382, i64 1
  %v385 = load i64, ptr %v385.p
  %v386 = add i64 %v384, %v385
  %v619 = getelementptr i64, ptr @"rt.meta", i64 0
  %v387.p = getelementptr i64, ptr %v619, i64 0
  %v387 = load i64, ptr %v387.p
  %v388.p = getelementptr i64, ptr %v4, i64 0
  %v388 = load i64, ptr %v388.p
  %v389.p = getelementptr i64, ptr %v4, i64 1
  %v389 = load i64, ptr %v389.p
  %v390.p = getelementptr i64, ptr %v4, i64 2
  %v390 = load i64, ptr %v390.p
  %v391 = call ptr @"rt.cat8"(i64 %v388, i64 %v389, i64 %v390, i64 %v387, i64 %v385)
  %v392 = getelementptr i8, ptr %v391, i64 %v384
  %v393.p = getelementptr i64, ptr %v382, i64 0
  %v393 = load i64, ptr %v393.p
  %v394 = inttoptr i64 %v393 to ptr
  call void @"rt.copy8"(ptr %v392, ptr %v394, i64 %v385)
  %v395 = getelementptr i64, ptr %s22, i64 0
  %v396 = ptrtoint ptr %v391 to i64
  %st186 = getelementptr i64, ptr %v395, i64 0
  store i64 %v396, ptr %st186
  %st187 = getelementptr i64, ptr %v395, i64 1
  store i64 %v386, ptr %st187
  %st188 = getelementptr i64, ptr %v395, i64 2
  store i64 %v387, ptr %st188
  %v397 = getelementptr i64, ptr %s23, i64 0
  %v398.p = getelementptr i64, ptr %v395, i64 0
  %v398 = load i64, ptr %v398.p
  %st189 = getelementptr i64, ptr %v397, i64 0
  store i64 %v398, ptr %st189
  %v399.p = getelementptr i64, ptr %v395, i64 1
  %v399 = load i64, ptr %v399.p
  %st190 = getelementptr i64, ptr %v397, i64 1
  store i64 %v399, ptr %st190
  %v400.p = getelementptr i64, ptr %v395, i64 2
  %v400 = load i64, ptr %v400.p
  %st191 = getelementptr i64, ptr %v397, i64 2
  store i64 %v400, ptr %st191
  %v620 = getelementptr i64, ptr @"rt.meta", i64 0
  %v401.p = getelementptr i64, ptr %v620, i64 0
  %v401 = load i64, ptr %v401.p
  %v402 = add i64 0, 18
  %v403 = call ptr @"rt.region_alloc"(i64 %v401, i64 %v402)
  %v404.p = getelementptr i64, ptr %v300, i64 0
  %v404 = load i64, ptr %v404.p
  %st192 = getelementptr i64, ptr %v403, i64 0
  store i64 %v404, ptr %st192
  %v405.p = getelementptr i64, ptr %v300, i64 1
  %v405 = load i64, ptr %v405.p
  %st193 = getelementptr i64, ptr %v403, i64 1
  store i64 %v405, ptr %st193
  %v406.p = getelementptr i64, ptr %v300, i64 2
  %v406 = load i64, ptr %v406.p
  %st194 = getelementptr i64, ptr %v403, i64 2
  store i64 %v406, ptr %st194
  %v407.p = getelementptr i64, ptr %v309, i64 0
  %v407 = load i64, ptr %v407.p
  %st195 = getelementptr i64, ptr %v403, i64 3
  store i64 %v407, ptr %st195
  %v408.p = getelementptr i64, ptr %v309, i64 1
  %v408 = load i64, ptr %v408.p
  %st196 = getelementptr i64, ptr %v403, i64 4
  store i64 %v408, ptr %st196
  %v409.p = getelementptr i64, ptr %v309, i64 2
  %v409 = load i64, ptr %v409.p
  %st197 = getelementptr i64, ptr %v403, i64 5
  store i64 %v409, ptr %st197
  %v410.p = getelementptr i64, ptr %v331, i64 0
  %v410 = load i64, ptr %v410.p
  %st198 = getelementptr i64, ptr %v403, i64 6
  store i64 %v410, ptr %st198
  %v411.p = getelementptr i64, ptr %v331, i64 1
  %v411 = load i64, ptr %v411.p
  %st199 = getelementptr i64, ptr %v403, i64 7
  store i64 %v411, ptr %st199
  %v412.p = getelementptr i64, ptr %v331, i64 2
  %v412 = load i64, ptr %v412.p
  %st200 = getelementptr i64, ptr %v403, i64 8
  store i64 %v412, ptr %st200
  %v413.p = getelementptr i64, ptr %v353, i64 0
  %v413 = load i64, ptr %v413.p
  %st201 = getelementptr i64, ptr %v403, i64 9
  store i64 %v413, ptr %st201
  %v414.p = getelementptr i64, ptr %v353, i64 1
  %v414 = load i64, ptr %v414.p
  %st202 = getelementptr i64, ptr %v403, i64 10
  store i64 %v414, ptr %st202
  %v415.p = getelementptr i64, ptr %v353, i64 2
  %v415 = load i64, ptr %v415.p
  %st203 = getelementptr i64, ptr %v403, i64 11
  store i64 %v415, ptr %st203
  %v416.p = getelementptr i64, ptr %v375, i64 0
  %v416 = load i64, ptr %v416.p
  %st204 = getelementptr i64, ptr %v403, i64 12
  store i64 %v416, ptr %st204
  %v417.p = getelementptr i64, ptr %v375, i64 1
  %v417 = load i64, ptr %v417.p
  %st205 = getelementptr i64, ptr %v403, i64 13
  store i64 %v417, ptr %st205
  %v418.p = getelementptr i64, ptr %v375, i64 2
  %v418 = load i64, ptr %v418.p
  %st206 = getelementptr i64, ptr %v403, i64 14
  store i64 %v418, ptr %st206
  %v419.p = getelementptr i64, ptr %v397, i64 0
  %v419 = load i64, ptr %v419.p
  %st207 = getelementptr i64, ptr %v403, i64 15
  store i64 %v419, ptr %st207
  %v420.p = getelementptr i64, ptr %v397, i64 1
  %v420 = load i64, ptr %v420.p
  %st208 = getelementptr i64, ptr %v403, i64 16
  store i64 %v420, ptr %st208
  %v421.p = getelementptr i64, ptr %v397, i64 2
  %v421 = load i64, ptr %v421.p
  %st209 = getelementptr i64, ptr %v403, i64 17
  store i64 %v421, ptr %st209
  %v422 = add i64 0, 6
  %v423 = getelementptr i64, ptr %s24, i64 0
  %v424 = ptrtoint ptr %v403 to i64
  %st210 = getelementptr i64, ptr %v423, i64 0
  store i64 %v424, ptr %st210
  %st211 = getelementptr i64, ptr %v423, i64 1
  store i64 %v422, ptr %st211
  %st212 = getelementptr i64, ptr %v423, i64 2
  store i64 %v401, ptr %st212
  %v425.p = getelementptr i64, ptr %v423, i64 0
  %v425 = load i64, ptr %v425.p
  %v426.p = getelementptr i64, ptr %v423, i64 1
  %v426 = load i64, ptr %v426.p
  %v427.p = getelementptr i64, ptr %v423, i64 2
  %v427 = load i64, ptr %v427.p
  call void @"std/os.Run"(ptr %v286, i64 %v292, i64 %v293, i64 %v294, i64 %v425, i64 %v426, i64 %v427)
  %v428.p = getelementptr i64, ptr %v286, i64 0
  %v428 = load i64, ptr %v428.p
  %v429 = add i64 0, 1
  %v430 = getelementptr i64, ptr %v286, i64 %v429
  %v431.p = getelementptr i64, ptr %v430, i64 0
  %v431 = load i64, ptr %v431.p
  %v432 = add i64 0, 0
  %v433.c = icmp ne i64 %v431, %v432
  %v433 = zext i1 %v433.c to i64
  %c.b18 = icmp ne i64 %v433, 0
  br i1 %c.b18, label %b18.t214, label %b18.e215
b18.t214:
  br label %b21
b18.e215:
  br label %b22
b19:
  %v284 = add i64 0, 3
  %v285 = getelementptr i64, ptr %v0, i64 %v284
  %v621 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v285, i64 %v621, i64 %v5)
  br label %b20
b20:
  %v622 = getelementptr i64, ptr @"rt.meta", i64 0
  %st215 = getelementptr i64, ptr %v622, i64 0
  store i64 %v5, ptr %st215
  ret void
b21:
  %v434 = add i64 0, 0
  %v435.p = getelementptr i64, ptr %v430, i64 0
  %v435 = load i64, ptr %v435.p
  %st216 = getelementptr i64, ptr %v0, i64 0
  store i64 %v435, ptr %st216
  %v436.p = getelementptr i64, ptr %v430, i64 1
  %v436 = load i64, ptr %v436.p
  %st217 = getelementptr i64, ptr %v0, i64 1
  store i64 %v436, ptr %st217
  %v437.p = getelementptr i64, ptr %v430, i64 2
  %v437 = load i64, ptr %v437.p
  %st218 = getelementptr i64, ptr %v0, i64 2
  store i64 %v437, ptr %st218
  %v438.p = getelementptr i64, ptr %v430, i64 3
  %v438 = load i64, ptr %v438.p
  %st219 = getelementptr i64, ptr %v0, i64 3
  store i64 %v438, ptr %st219
  %v439.p = getelementptr i64, ptr %v430, i64 4
  %v439 = load i64, ptr %v439.p
  %st220 = getelementptr i64, ptr %v0, i64 4
  store i64 %v439, ptr %st220
  %v440.p = getelementptr i64, ptr %v430, i64 5
  %v440 = load i64, ptr %v440.p
  %st221 = getelementptr i64, ptr %v0, i64 5
  store i64 %v440, ptr %st221
  %v441.p = getelementptr i64, ptr %v0, i64 0
  %v441 = load i64, ptr %v441.p
  %v442 = add i64 0, 0
  %v443.c = icmp ne i64 %v441, %v442
  %v443 = zext i1 %v443.c to i64
  %c.b21 = icmp ne i64 %v443, 0
  br i1 %c.b21, label %b21.t223, label %b21.e224
b21.t223:
  br label %b23
b21.e224:
  br label %b24
b22:
  %v446 = getelementptr i64, ptr %s25, i64 0
  %v447.p = getelementptr i64, ptr %v4, i64 0
  %v447 = load i64, ptr %v447.p
  %v448.p = getelementptr i64, ptr %v4, i64 1
  %v448 = load i64, ptr %v448.p
  %v449.p = getelementptr i64, ptr %v4, i64 2
  %v449 = load i64, ptr %v449.p
  call void @"std/io.OpenRoot"(ptr %v446, i64 %v447, i64 %v448, i64 %v449)
  %v450 = add i64 0, 1
  %v451 = getelementptr i64, ptr %v446, i64 %v450
  %v452.p = getelementptr i64, ptr %v451, i64 0
  %v452 = load i64, ptr %v452.p
  %v453 = add i64 0, 0
  %v454.c = icmp ne i64 %v452, %v453
  %v454 = zext i1 %v454.c to i64
  %c.b22 = icmp ne i64 %v454, 0
  br i1 %c.b22, label %b22.t225, label %b22.e226
b22.t225:
  br label %b25
b22.e226:
  br label %b26
b23:
  %v444 = add i64 0, 3
  %v445 = getelementptr i64, ptr %v0, i64 %v444
  %v623 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v445, i64 %v623, i64 %v5)
  br label %b24
b24:
  %v624 = getelementptr i64, ptr @"rt.meta", i64 0
  %st226 = getelementptr i64, ptr %v624, i64 0
  store i64 %v5, ptr %st226
  ret void
b25:
  %v455 = add i64 0, 0
  %v456.p = getelementptr i64, ptr %v451, i64 0
  %v456 = load i64, ptr %v456.p
  %st227 = getelementptr i64, ptr %v0, i64 0
  store i64 %v456, ptr %st227
  %v457.p = getelementptr i64, ptr %v451, i64 1
  %v457 = load i64, ptr %v457.p
  %st228 = getelementptr i64, ptr %v0, i64 1
  store i64 %v457, ptr %st228
  %v458.p = getelementptr i64, ptr %v451, i64 2
  %v458 = load i64, ptr %v458.p
  %st229 = getelementptr i64, ptr %v0, i64 2
  store i64 %v458, ptr %st229
  %v459.p = getelementptr i64, ptr %v451, i64 3
  %v459 = load i64, ptr %v459.p
  %st230 = getelementptr i64, ptr %v0, i64 3
  store i64 %v459, ptr %st230
  %v460.p = getelementptr i64, ptr %v451, i64 4
  %v460 = load i64, ptr %v460.p
  %st231 = getelementptr i64, ptr %v0, i64 4
  store i64 %v460, ptr %st231
  %v461.p = getelementptr i64, ptr %v451, i64 5
  %v461 = load i64, ptr %v461.p
  %st232 = getelementptr i64, ptr %v0, i64 5
  store i64 %v461, ptr %st232
  %v462.p = getelementptr i64, ptr %v0, i64 0
  %v462 = load i64, ptr %v462.p
  %v463 = add i64 0, 0
  %v464.c = icmp ne i64 %v462, %v463
  %v464 = zext i1 %v464.c to i64
  %c.b25 = icmp ne i64 %v464, 0
  br i1 %c.b25, label %b25.t234, label %b25.e235
b25.t234:
  br label %b27
b25.e235:
  br label %b28
b26:
  %v467 = getelementptr i64, ptr %s26, i64 0
  %v468.p = getelementptr i64, ptr %v446, i64 0
  %v468 = load i64, ptr %v468.p
  %st235 = getelementptr i64, ptr %v467, i64 0
  store i64 %v468, ptr %st235
  %v469 = getelementptr i64, ptr %s27, i64 0
  %v470.p = getelementptr i64, ptr %v4, i64 0
  %v470 = load i64, ptr %v470.p
  %v471.p = getelementptr i64, ptr %v4, i64 1
  %v471 = load i64, ptr %v471.p
  %v472.p = getelementptr i64, ptr %v4, i64 2
  %v472 = load i64, ptr %v472.p
  %v473.p = getelementptr i64, ptr %v467, i64 0
  %v473 = load i64, ptr %v473.p
  %v474 = getelementptr i64, ptr @"str.21", i64 0
  %v475 = add i64 0, 5
  %v476 = add i64 0, 0
  %v477 = getelementptr i64, ptr %s24, i64 0
  %v478 = ptrtoint ptr %v474 to i64
  %st236 = getelementptr i64, ptr %v477, i64 0
  store i64 %v478, ptr %st236
  %st237 = getelementptr i64, ptr %v477, i64 1
  store i64 %v475, ptr %st237
  %st238 = getelementptr i64, ptr %v477, i64 2
  store i64 %v476, ptr %st238
  %v479.p = getelementptr i64, ptr %v477, i64 0
  %v479 = load i64, ptr %v479.p
  %v480.p = getelementptr i64, ptr %v477, i64 1
  %v480 = load i64, ptr %v480.p
  %v481.p = getelementptr i64, ptr %v477, i64 2
  %v481 = load i64, ptr %v481.p
  call void @"main.show"(ptr %v469, i64 %v470, i64 %v471, i64 %v472, i64 %v473, i64 %v479, i64 %v480, i64 %v481)
  %v482.p = getelementptr i64, ptr %v469, i64 0
  %v482 = load i64, ptr %v482.p
  %v483 = add i64 0, 0
  %v484.c = icmp ne i64 %v482, %v483
  %v484 = zext i1 %v484.c to i64
  %c.b26 = icmp ne i64 %v484, 0
  br i1 %c.b26, label %b26.t240, label %b26.e241
b26.t240:
  br label %b29
b26.e241:
  br label %b30
b27:
  %v465 = add i64 0, 3
  %v466 = getelementptr i64, ptr %v0, i64 %v465
  %v625 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v466, i64 %v625, i64 %v5)
  br label %b28
b28:
  %v626 = getelementptr i64, ptr @"rt.meta", i64 0
  %st241 = getelementptr i64, ptr %v626, i64 0
  store i64 %v5, ptr %st241
  ret void
b29:
  %v485 = add i64 0, 0
  %v486.p = getelementptr i64, ptr %v469, i64 0
  %v486 = load i64, ptr %v486.p
  %st242 = getelementptr i64, ptr %v0, i64 0
  store i64 %v486, ptr %st242
  %v487.p = getelementptr i64, ptr %v469, i64 1
  %v487 = load i64, ptr %v487.p
  %st243 = getelementptr i64, ptr %v0, i64 1
  store i64 %v487, ptr %st243
  %v488.p = getelementptr i64, ptr %v469, i64 2
  %v488 = load i64, ptr %v488.p
  %st244 = getelementptr i64, ptr %v0, i64 2
  store i64 %v488, ptr %st244
  %v489.p = getelementptr i64, ptr %v469, i64 3
  %v489 = load i64, ptr %v489.p
  %st245 = getelementptr i64, ptr %v0, i64 3
  store i64 %v489, ptr %st245
  %v490.p = getelementptr i64, ptr %v469, i64 4
  %v490 = load i64, ptr %v490.p
  %st246 = getelementptr i64, ptr %v0, i64 4
  store i64 %v490, ptr %st246
  %v491.p = getelementptr i64, ptr %v469, i64 5
  %v491 = load i64, ptr %v491.p
  %st247 = getelementptr i64, ptr %v0, i64 5
  store i64 %v491, ptr %st247
  %v492.p = getelementptr i64, ptr %v467, i64 0
  %v492 = load i64, ptr %v492.p
  call void @"std/io.CloseRoot"(i64 %v492)
  %v493.p = getelementptr i64, ptr %v0, i64 0
  %v493 = load i64, ptr %v493.p
  %v494 = add i64 0, 0
  %v495.c = icmp ne i64 %v493, %v494
  %v495 = zext i1 %v495.c to i64
  %c.b29 = icmp ne i64 %v495, 0
  br i1 %c.b29, label %b29.t249, label %b29.e250
b29.t249:
  br label %b31
b29.e250:
  br label %b32
b30:
  %v498 = getelementptr i64, ptr %s28, i64 0
  %v499.p = getelementptr i64, ptr %v4, i64 0
  %v499 = load i64, ptr %v499.p
  %v500.p = getelementptr i64, ptr %v4, i64 1
  %v500 = load i64, ptr %v500.p
  %v501.p = getelementptr i64, ptr %v4, i64 2
  %v501 = load i64, ptr %v501.p
  %v502.p = getelementptr i64, ptr %v467, i64 0
  %v502 = load i64, ptr %v502.p
  %v503 = getelementptr i64, ptr @"str.22", i64 0
  %v504 = add i64 0, 5
  %v505 = add i64 0, 0
  %v506 = getelementptr i64, ptr %s24, i64 0
  %v507 = ptrtoint ptr %v503 to i64
  %st250 = getelementptr i64, ptr %v506, i64 0
  store i64 %v507, ptr %st250
  %st251 = getelementptr i64, ptr %v506, i64 1
  store i64 %v504, ptr %st251
  %st252 = getelementptr i64, ptr %v506, i64 2
  store i64 %v505, ptr %st252
  %v508.p = getelementptr i64, ptr %v506, i64 0
  %v508 = load i64, ptr %v508.p
  %v509.p = getelementptr i64, ptr %v506, i64 1
  %v509 = load i64, ptr %v509.p
  %v510.p = getelementptr i64, ptr %v506, i64 2
  %v510 = load i64, ptr %v510.p
  call void @"main.show"(ptr %v498, i64 %v499, i64 %v500, i64 %v501, i64 %v502, i64 %v508, i64 %v509, i64 %v510)
  %v511.p = getelementptr i64, ptr %v498, i64 0
  %v511 = load i64, ptr %v511.p
  %v512 = add i64 0, 0
  %v513.c = icmp ne i64 %v511, %v512
  %v513 = zext i1 %v513.c to i64
  %c.b30 = icmp ne i64 %v513, 0
  br i1 %c.b30, label %b30.t254, label %b30.e255
b30.t254:
  br label %b33
b30.e255:
  br label %b34
b31:
  %v496 = add i64 0, 3
  %v497 = getelementptr i64, ptr %v0, i64 %v496
  %v627 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v497, i64 %v627, i64 %v5)
  br label %b32
b32:
  %v628 = getelementptr i64, ptr @"rt.meta", i64 0
  %st255 = getelementptr i64, ptr %v628, i64 0
  store i64 %v5, ptr %st255
  ret void
b33:
  %v514 = add i64 0, 0
  %v515.p = getelementptr i64, ptr %v498, i64 0
  %v515 = load i64, ptr %v515.p
  %st256 = getelementptr i64, ptr %v0, i64 0
  store i64 %v515, ptr %st256
  %v516.p = getelementptr i64, ptr %v498, i64 1
  %v516 = load i64, ptr %v516.p
  %st257 = getelementptr i64, ptr %v0, i64 1
  store i64 %v516, ptr %st257
  %v517.p = getelementptr i64, ptr %v498, i64 2
  %v517 = load i64, ptr %v517.p
  %st258 = getelementptr i64, ptr %v0, i64 2
  store i64 %v517, ptr %st258
  %v518.p = getelementptr i64, ptr %v498, i64 3
  %v518 = load i64, ptr %v518.p
  %st259 = getelementptr i64, ptr %v0, i64 3
  store i64 %v518, ptr %st259
  %v519.p = getelementptr i64, ptr %v498, i64 4
  %v519 = load i64, ptr %v519.p
  %st260 = getelementptr i64, ptr %v0, i64 4
  store i64 %v519, ptr %st260
  %v520.p = getelementptr i64, ptr %v498, i64 5
  %v520 = load i64, ptr %v520.p
  %st261 = getelementptr i64, ptr %v0, i64 5
  store i64 %v520, ptr %st261
  %v521.p = getelementptr i64, ptr %v467, i64 0
  %v521 = load i64, ptr %v521.p
  call void @"std/io.CloseRoot"(i64 %v521)
  %v522.p = getelementptr i64, ptr %v0, i64 0
  %v522 = load i64, ptr %v522.p
  %v523 = add i64 0, 0
  %v524.c = icmp ne i64 %v522, %v523
  %v524 = zext i1 %v524.c to i64
  %c.b33 = icmp ne i64 %v524, 0
  br i1 %c.b33, label %b33.t263, label %b33.e264
b33.t263:
  br label %b35
b33.e264:
  br label %b36
b34:
  %v527 = getelementptr i64, ptr %s29, i64 0
  %v528.p = getelementptr i64, ptr %v4, i64 0
  %v528 = load i64, ptr %v528.p
  %v529.p = getelementptr i64, ptr %v4, i64 1
  %v529 = load i64, ptr %v529.p
  %v530.p = getelementptr i64, ptr %v4, i64 2
  %v530 = load i64, ptr %v530.p
  %v531.p = getelementptr i64, ptr %v467, i64 0
  %v531 = load i64, ptr %v531.p
  %v532 = getelementptr i64, ptr @"str.23", i64 0
  %v533 = add i64 0, 3
  %v534 = add i64 0, 0
  %v535 = getelementptr i64, ptr %s24, i64 0
  %v536 = ptrtoint ptr %v532 to i64
  %st264 = getelementptr i64, ptr %v535, i64 0
  store i64 %v536, ptr %st264
  %st265 = getelementptr i64, ptr %v535, i64 1
  store i64 %v533, ptr %st265
  %st266 = getelementptr i64, ptr %v535, i64 2
  store i64 %v534, ptr %st266
  %v537.p = getelementptr i64, ptr %v535, i64 0
  %v537 = load i64, ptr %v537.p
  %v538.p = getelementptr i64, ptr %v535, i64 1
  %v538 = load i64, ptr %v538.p
  %v539.p = getelementptr i64, ptr %v535, i64 2
  %v539 = load i64, ptr %v539.p
  call void @"main.show"(ptr %v527, i64 %v528, i64 %v529, i64 %v530, i64 %v531, i64 %v537, i64 %v538, i64 %v539)
  %v540.p = getelementptr i64, ptr %v527, i64 0
  %v540 = load i64, ptr %v540.p
  %v541 = add i64 0, 0
  %v542.c = icmp ne i64 %v540, %v541
  %v542 = zext i1 %v542.c to i64
  %c.b34 = icmp ne i64 %v542, 0
  br i1 %c.b34, label %b34.t268, label %b34.e269
b34.t268:
  br label %b37
b34.e269:
  br label %b38
b35:
  %v525 = add i64 0, 3
  %v526 = getelementptr i64, ptr %v0, i64 %v525
  %v629 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v526, i64 %v629, i64 %v5)
  br label %b36
b36:
  %v630 = getelementptr i64, ptr @"rt.meta", i64 0
  %st269 = getelementptr i64, ptr %v630, i64 0
  store i64 %v5, ptr %st269
  ret void
b37:
  %v543 = add i64 0, 0
  %v544.p = getelementptr i64, ptr %v527, i64 0
  %v544 = load i64, ptr %v544.p
  %st270 = getelementptr i64, ptr %v0, i64 0
  store i64 %v544, ptr %st270
  %v545.p = getelementptr i64, ptr %v527, i64 1
  %v545 = load i64, ptr %v545.p
  %st271 = getelementptr i64, ptr %v0, i64 1
  store i64 %v545, ptr %st271
  %v546.p = getelementptr i64, ptr %v527, i64 2
  %v546 = load i64, ptr %v546.p
  %st272 = getelementptr i64, ptr %v0, i64 2
  store i64 %v546, ptr %st272
  %v547.p = getelementptr i64, ptr %v527, i64 3
  %v547 = load i64, ptr %v547.p
  %st273 = getelementptr i64, ptr %v0, i64 3
  store i64 %v547, ptr %st273
  %v548.p = getelementptr i64, ptr %v527, i64 4
  %v548 = load i64, ptr %v548.p
  %st274 = getelementptr i64, ptr %v0, i64 4
  store i64 %v548, ptr %st274
  %v549.p = getelementptr i64, ptr %v527, i64 5
  %v549 = load i64, ptr %v549.p
  %st275 = getelementptr i64, ptr %v0, i64 5
  store i64 %v549, ptr %st275
  %v550.p = getelementptr i64, ptr %v467, i64 0
  %v550 = load i64, ptr %v550.p
  call void @"std/io.CloseRoot"(i64 %v550)
  %v551.p = getelementptr i64, ptr %v0, i64 0
  %v551 = load i64, ptr %v551.p
  %v552 = add i64 0, 0
  %v553.c = icmp ne i64 %v551, %v552
  %v553 = zext i1 %v553.c to i64
  %c.b37 = icmp ne i64 %v553, 0
  br i1 %c.b37, label %b37.t277, label %b37.e278
b37.t277:
  br label %b39
b37.e278:
  br label %b40
b38:
  %v556 = getelementptr i64, ptr %s30, i64 0
  %v557.p = getelementptr i64, ptr %v4, i64 0
  %v557 = load i64, ptr %v557.p
  %v558.p = getelementptr i64, ptr %v4, i64 1
  %v558 = load i64, ptr %v558.p
  %v559.p = getelementptr i64, ptr %v4, i64 2
  %v559 = load i64, ptr %v559.p
  %v560.p = getelementptr i64, ptr %v467, i64 0
  %v560 = load i64, ptr %v560.p
  %v561 = getelementptr i64, ptr @"str.24", i64 0
  %v562 = add i64 0, 4
  %v563 = add i64 0, 0
  %v564 = getelementptr i64, ptr %s24, i64 0
  %v565 = ptrtoint ptr %v561 to i64
  %st278 = getelementptr i64, ptr %v564, i64 0
  store i64 %v565, ptr %st278
  %st279 = getelementptr i64, ptr %v564, i64 1
  store i64 %v562, ptr %st279
  %st280 = getelementptr i64, ptr %v564, i64 2
  store i64 %v563, ptr %st280
  %v566.p = getelementptr i64, ptr %v564, i64 0
  %v566 = load i64, ptr %v566.p
  %v567.p = getelementptr i64, ptr %v564, i64 1
  %v567 = load i64, ptr %v567.p
  %v568.p = getelementptr i64, ptr %v564, i64 2
  %v568 = load i64, ptr %v568.p
  call void @"main.show"(ptr %v556, i64 %v557, i64 %v558, i64 %v559, i64 %v560, i64 %v566, i64 %v567, i64 %v568)
  %v569.p = getelementptr i64, ptr %v556, i64 0
  %v569 = load i64, ptr %v569.p
  %v570 = add i64 0, 0
  %v571.c = icmp ne i64 %v569, %v570
  %v571 = zext i1 %v571.c to i64
  %c.b38 = icmp ne i64 %v571, 0
  br i1 %c.b38, label %b38.t282, label %b38.e283
b38.t282:
  br label %b41
b38.e283:
  br label %b42
b39:
  %v554 = add i64 0, 3
  %v555 = getelementptr i64, ptr %v0, i64 %v554
  %v631 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v555, i64 %v631, i64 %v5)
  br label %b40
b40:
  %v632 = getelementptr i64, ptr @"rt.meta", i64 0
  %st283 = getelementptr i64, ptr %v632, i64 0
  store i64 %v5, ptr %st283
  ret void
b41:
  %v572 = add i64 0, 0
  %v573.p = getelementptr i64, ptr %v556, i64 0
  %v573 = load i64, ptr %v573.p
  %st284 = getelementptr i64, ptr %v0, i64 0
  store i64 %v573, ptr %st284
  %v574.p = getelementptr i64, ptr %v556, i64 1
  %v574 = load i64, ptr %v574.p
  %st285 = getelementptr i64, ptr %v0, i64 1
  store i64 %v574, ptr %st285
  %v575.p = getelementptr i64, ptr %v556, i64 2
  %v575 = load i64, ptr %v575.p
  %st286 = getelementptr i64, ptr %v0, i64 2
  store i64 %v575, ptr %st286
  %v576.p = getelementptr i64, ptr %v556, i64 3
  %v576 = load i64, ptr %v576.p
  %st287 = getelementptr i64, ptr %v0, i64 3
  store i64 %v576, ptr %st287
  %v577.p = getelementptr i64, ptr %v556, i64 4
  %v577 = load i64, ptr %v577.p
  %st288 = getelementptr i64, ptr %v0, i64 4
  store i64 %v577, ptr %st288
  %v578.p = getelementptr i64, ptr %v556, i64 5
  %v578 = load i64, ptr %v578.p
  %st289 = getelementptr i64, ptr %v0, i64 5
  store i64 %v578, ptr %st289
  %v579.p = getelementptr i64, ptr %v467, i64 0
  %v579 = load i64, ptr %v579.p
  call void @"std/io.CloseRoot"(i64 %v579)
  %v580.p = getelementptr i64, ptr %v0, i64 0
  %v580 = load i64, ptr %v580.p
  %v581 = add i64 0, 0
  %v582.c = icmp ne i64 %v580, %v581
  %v582 = zext i1 %v582.c to i64
  %c.b41 = icmp ne i64 %v582, 0
  br i1 %c.b41, label %b41.t291, label %b41.e292
b41.t291:
  br label %b43
b41.e292:
  br label %b44
b42:
  %v585 = getelementptr i64, ptr %s31, i64 0
  %v586 = add i64 0, 0
  %st292 = getelementptr i64, ptr %v585, i64 0
  store i64 %v586, ptr %st292
  %v587.p = getelementptr i64, ptr %v585, i64 0
  %v587 = load i64, ptr %v587.p
  %st293 = getelementptr i64, ptr %v0, i64 0
  store i64 %v587, ptr %st293
  %v588.p = getelementptr i64, ptr %v585, i64 1
  %v588 = load i64, ptr %v588.p
  %st294 = getelementptr i64, ptr %v0, i64 1
  store i64 %v588, ptr %st294
  %v589.p = getelementptr i64, ptr %v585, i64 2
  %v589 = load i64, ptr %v589.p
  %st295 = getelementptr i64, ptr %v0, i64 2
  store i64 %v589, ptr %st295
  %v590.p = getelementptr i64, ptr %v585, i64 3
  %v590 = load i64, ptr %v590.p
  %st296 = getelementptr i64, ptr %v0, i64 3
  store i64 %v590, ptr %st296
  %v591.p = getelementptr i64, ptr %v585, i64 4
  %v591 = load i64, ptr %v591.p
  %st297 = getelementptr i64, ptr %v0, i64 4
  store i64 %v591, ptr %st297
  %v592.p = getelementptr i64, ptr %v585, i64 5
  %v592 = load i64, ptr %v592.p
  %st298 = getelementptr i64, ptr %v0, i64 5
  store i64 %v592, ptr %st298
  %v593.p = getelementptr i64, ptr %v467, i64 0
  %v593 = load i64, ptr %v593.p
  call void @"std/io.CloseRoot"(i64 %v593)
  %v594.p = getelementptr i64, ptr %v0, i64 0
  %v594 = load i64, ptr %v594.p
  %v595 = add i64 0, 0
  %v596.c = icmp ne i64 %v594, %v595
  %v596 = zext i1 %v596.c to i64
  %c.b42 = icmp ne i64 %v596, 0
  br i1 %c.b42, label %b42.t300, label %b42.e301
b42.t300:
  br label %b45
b42.e301:
  br label %b46
b43:
  %v583 = add i64 0, 3
  %v584 = getelementptr i64, ptr %v0, i64 %v583
  %v633 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v584, i64 %v633, i64 %v5)
  br label %b44
b44:
  %v634 = getelementptr i64, ptr @"rt.meta", i64 0
  %st301 = getelementptr i64, ptr %v634, i64 0
  store i64 %v5, ptr %st301
  ret void
b45:
  %v597 = add i64 0, 3
  %v598 = getelementptr i64, ptr %v0, i64 %v597
  %v635 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v598, i64 %v635, i64 %v5)
  br label %b46
b46:
  %v636 = getelementptr i64, ptr @"rt.meta", i64 0
  %st302 = getelementptr i64, ptr %v636, i64 0
  store i64 %v5, ptr %st302
  ret void
}

define internal void @"main.why"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v6, i64 3
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v6, i64 4
  store i64 %v5, ptr %st4
  %v56 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v56, i64 0
  %v7 = load i64, ptr %v7.p
  call void @"rt.region_enter"()
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp eq i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t6, label %b0.e7
b0.t6:
  br label %b2
b0.e7:
  br label %b1
b1:
  %v16.p = getelementptr i64, ptr %v6, i64 0
  %v16 = load i64, ptr %v16.p
  %v17 = add i64 0, 1
  %v18.c = icmp eq i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b1 = icmp ne i64 %v18, 0
  br i1 %c.b1, label %b1.t8, label %b1.e9
b1.t8:
  br label %b4
b1.e9:
  br label %b3
b2:
  %v11 = getelementptr i64, ptr @"str.2", i64 0
  %v12 = add i64 0, 9
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15 = ptrtoint ptr %v11 to i64
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st9
  %st10 = getelementptr i64, ptr %v14, i64 1
  store i64 %v12, ptr %st10
  %st11 = getelementptr i64, ptr %v14, i64 2
  store i64 %v13, ptr %st11
  br label %b7
b3:
  %v24.p = getelementptr i64, ptr %v6, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 0, 5
  %v26.c = icmp eq i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b3 = icmp ne i64 %v26, 0
  br i1 %c.b3, label %b3.t13, label %b3.e14
b3.t13:
  br label %b6
b3.e14:
  br label %b5
b4:
  %v19 = getelementptr i64, ptr @"str.3", i64 0
  %v20 = add i64 0, 6
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s2, i64 0
  %v23 = ptrtoint ptr %v19 to i64
  %st14 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st14
  %st15 = getelementptr i64, ptr %v22, i64 1
  store i64 %v20, ptr %st15
  %st16 = getelementptr i64, ptr %v22, i64 2
  store i64 %v21, ptr %st16
  br label %b7
b5:
  %v47 = getelementptr i64, ptr @"str.5", i64 0
  %v48 = add i64 0, 5
  %v49 = add i64 0, 0
  %v50 = getelementptr i64, ptr %s6, i64 0
  %v51 = ptrtoint ptr %v47 to i64
  %st17 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st17
  %st18 = getelementptr i64, ptr %v50, i64 1
  store i64 %v48, ptr %st18
  %st19 = getelementptr i64, ptr %v50, i64 2
  store i64 %v49, ptr %st19
  br label %b7
b6:
  %v27.p = getelementptr i64, ptr %v6, i64 1
  %v27 = load i64, ptr %v27.p
  %v28 = getelementptr i64, ptr @"str.4", i64 0
  %v29 = add i64 0, 6
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s3, i64 0
  %v32 = ptrtoint ptr %v28 to i64
  %st20 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st20
  %st21 = getelementptr i64, ptr %v31, i64 1
  store i64 %v29, ptr %st21
  %st22 = getelementptr i64, ptr %v31, i64 2
  store i64 %v30, ptr %st22
  %v33 = getelementptr i64, ptr %s4, i64 0
  call void @"std/convert.FormatInt"(ptr %v33, i64 %v27)
  %v34.p = getelementptr i64, ptr %v31, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v33, i64 1
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 %v34, %v35
  %v57 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v57, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v31, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v31, i64 1
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v31, i64 2
  %v40 = load i64, ptr %v40.p
  %v41 = call ptr @"rt.cat8"(i64 %v38, i64 %v39, i64 %v40, i64 %v37, i64 %v35)
  %v42 = getelementptr i8, ptr %v41, i64 %v34
  %v43.p = getelementptr i64, ptr %v33, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = inttoptr i64 %v43 to ptr
  call void @"rt.copy8"(ptr %v42, ptr %v44, i64 %v35)
  %v45 = getelementptr i64, ptr %s5, i64 0
  %v46 = ptrtoint ptr %v41 to i64
  %st23 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st23
  %st24 = getelementptr i64, ptr %v45, i64 1
  store i64 %v36, ptr %st24
  %st25 = getelementptr i64, ptr %v45, i64 2
  store i64 %v37, ptr %st25
  br label %b7
b7:
  %v52 = phi ptr [ %v14, %b2 ], [ %v22, %b4 ], [ %v50, %b5 ], [ %v45, %b6 ]
  %v53.p = getelementptr i64, ptr %v52, i64 0
  %v53 = load i64, ptr %v53.p
  %st26 = getelementptr i64, ptr %v0, i64 0
  store i64 %v53, ptr %st26
  %v54.p = getelementptr i64, ptr %v52, i64 1
  %v54 = load i64, ptr %v54.p
  %st27 = getelementptr i64, ptr %v0, i64 1
  store i64 %v54, ptr %st27
  %v55.p = getelementptr i64, ptr %v52, i64 2
  %v55 = load i64, ptr %v55.p
  %st28 = getelementptr i64, ptr %v0, i64 2
  store i64 %v55, ptr %st28
  call void @"rt.region_relocate8"(ptr %v0, i64 %v7)
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %st29 = getelementptr i64, ptr %v58, i64 0
  store i64 %v7, ptr %st29
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
  %v9 = getelementptr i64, ptr @"str.6", i64 0
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
  %v16 = getelementptr i64, ptr @"str.7", i64 0
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
  %v25 = add i64 0, 0
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
  %v69 = add i64 0, 1
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
  %v125 = add i64 0, 2
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
  %s11 = alloca [3 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %s11.z2 = getelementptr i64, ptr %s11, i64 2
  store i64 0, ptr %s11.z2
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
  %v20 = getelementptr i64, ptr @"str.49", i64 0
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
  %v74 = getelementptr i64, ptr @"str.57", i64 0
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
  %v27 = getelementptr i64, ptr @"str.50", i64 0
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
  %v34 = getelementptr i64, ptr @"str.51", i64 0
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
  %v41 = getelementptr i64, ptr @"str.52", i64 0
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
  %v48 = getelementptr i64, ptr @"str.53", i64 0
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
  %v55 = getelementptr i64, ptr @"str.54", i64 0
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
  %v62 = getelementptr i64, ptr @"str.55", i64 0
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
  %v69 = getelementptr i64, ptr @"str.56", i64 0
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
  %v100 = add i64 0, 58
  call void @"rt.print_char"(i64 %v100)
  call void @"rt.print_int"(i64 %v14)
  %v101 = add i64 0, 58
  call void @"rt.print_char"(i64 %v101)
  call void @"rt.print_int"(i64 %v18)
  %v102 = add i64 0, 10
  call void @"rt.print_char"(i64 %v102)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v81 = getelementptr i64, ptr @"str.58", i64 0
  %v82 = add i64 0, 22
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
  %v88 = getelementptr i64, ptr @"str.59", i64 0
  %v89 = add i64 0, 15
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
  %v93 = add i64 0, 2
  %v94.c = icmp eq i64 %v10, %v93
  %v94 = zext i1 %v94.c to i64
  %c.b20 = icmp ne i64 %v94, 0
  br i1 %c.b20, label %b20.t53, label %b20.e54
b20.t53:
  br label %b21
b20.e54:
  br label %b22
b21:
  %v95 = getelementptr i64, ptr @"str.60", i64 0
  %v96 = add i64 0, 15
  %v97 = add i64 0, 0
  %v98 = getelementptr i64, ptr %s11, i64 0
  %v99 = ptrtoint ptr %v95 to i64
  %st54 = getelementptr i64, ptr %v98, i64 0
  store i64 %v99, ptr %st54
  %st55 = getelementptr i64, ptr %v98, i64 1
  store i64 %v96, ptr %st55
  %st56 = getelementptr i64, ptr %v98, i64 2
  store i64 %v97, ptr %st56
  call void @"rt.print_str"(ptr %v98)
  br label %b16
b22:
  br label %b16
}

define internal void @"std/os.Run"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
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
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [2 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
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
  %s12 = alloca [6 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s12.z3 = getelementptr i64, ptr %s12, i64 3
  store i64 0, ptr %s12.z3
  %s12.z4 = getelementptr i64, ptr %s12, i64 4
  store i64 0, ptr %s12.z4
  %s12.z5 = getelementptr i64, ptr %s12, i64 5
  store i64 0, ptr %s12.z5
  %s13 = alloca [1 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s14 = alloca [1 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s15 = alloca [1 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s16 = alloca [5 x i64], align 8
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
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v6, ptr %st5
  %v339 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v339, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v340 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v340, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %v12 = call ptr @"rt.region_alloc8"(i64 %v10, i64 %v11)
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15 = ptrtoint ptr %v12 to i64
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 1
  store i64 %v13, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 2
  store i64 %v10, ptr %st8
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v14, i64 0
  %v17 = load i64, ptr %v17.p
  %st9 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st9
  %v18.p = getelementptr i64, ptr %v14, i64 1
  %v18 = load i64, ptr %v18.p
  %st10 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st10
  %v19.p = getelementptr i64, ptr %v14, i64 2
  %v19 = load i64, ptr %v19.p
  %st11 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st11
  %v20 = getelementptr i64, ptr %s2, i64 0
  %v21.p = getelementptr i64, ptr %v7, i64 0
  %v21 = load i64, ptr %v21.p
  %st12 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st12
  %v22.p = getelementptr i64, ptr %v7, i64 1
  %v22 = load i64, ptr %v22.p
  %st13 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st13
  %v23.p = getelementptr i64, ptr %v7, i64 2
  %v23 = load i64, ptr %v23.p
  %st14 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st14
  %v24 = getelementptr i64, ptr %s4, i64 0
  %v341 = getelementptr i64, ptr @"rt.meta", i64 0
  %v25.p = getelementptr i64, ptr %v341, i64 0
  %v25 = load i64, ptr %v25.p
  %v26 = getelementptr i64, ptr %s5, i64 0
  %v27.p = getelementptr i64, ptr %v20, i64 0
  %v27 = load i64, ptr %v27.p
  %st15 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st15
  %v28.p = getelementptr i64, ptr %v20, i64 1
  %v28 = load i64, ptr %v28.p
  %st16 = getelementptr i64, ptr %v26, i64 1
  store i64 %v28, ptr %st16
  %v29.p = getelementptr i64, ptr %v20, i64 2
  %v29 = load i64, ptr %v29.p
  %st17 = getelementptr i64, ptr %v26, i64 2
  store i64 %v29, ptr %st17
  %v342 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v342, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 0
  %v32.p = getelementptr i64, ptr %v26, i64 1
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s6, i64 0
  %v343 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v343, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = getelementptr i64, ptr %s7, i64 0
  %st18 = getelementptr i64, ptr %v35, i64 0
  store i64 %v31, ptr %st18
  %v344 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v344, i64 0
  %v36 = load i64, ptr %v36.p
  br label %b4
b1:
  %v118.p = getelementptr i64, ptr %v24, i64 0
  %v118 = load i64, ptr %v118.p
  %v119 = add i64 0, 1
  %v120 = xor i64 %v118, %v119
  %c.b1 = icmp ne i64 %v120, 0
  br i1 %c.b1, label %b1.t20, label %b1.e21
b1.t20:
  br label %b21
b1.e21:
  br label %b22
b2:
  %v345 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v345, i64 0
  store i64 %v30, ptr %st21
  %v90 = getelementptr i64, ptr %s9, i64 0
  %v91.p = getelementptr i64, ptr %v16, i64 0
  %v91 = load i64, ptr %v91.p
  %st22 = getelementptr i64, ptr %v90, i64 0
  store i64 %v91, ptr %st22
  %v92.p = getelementptr i64, ptr %v16, i64 1
  %v92 = load i64, ptr %v92.p
  %st23 = getelementptr i64, ptr %v90, i64 1
  store i64 %v92, ptr %st23
  %v93.p = getelementptr i64, ptr %v16, i64 2
  %v93 = load i64, ptr %v93.p
  %st24 = getelementptr i64, ptr %v90, i64 2
  store i64 %v93, ptr %st24
  %v94 = add i64 0, 0
  %v95.p = getelementptr i64, ptr %v90, i64 2
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v90, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v90, i64 1
  %v97 = load i64, ptr %v97.p
  %v100 = add i64 %v96, %v97
  %v101 = call i64 @"rt.tip8"(i64 %v95, i64 %v100)
  %v102 = add i64 0, 0
  %v103.c = icmp ne i64 %v101, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b2 = icmp ne i64 %v103, 0
  br i1 %c.b2, label %b2.t26, label %b2.e27
b2.t26:
  br label %b20
b2.e27:
  br label %b19
b3:
  br label %b2
b4:
  %v346 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v346, i64 0
  store i64 %v36, ptr %st27
  %v37.p = getelementptr i64, ptr %v35, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp slt i64 %v37, %v32
  %v38 = zext i1 %v38.c to i64
  %c.b4 = icmp ne i64 %v38, 0
  br i1 %c.b4, label %b4.t29, label %b4.e30
b4.t29:
  br label %b5
b4.e30:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v347 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v347, i64 0
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v35, i64 0
  %v40 = load i64, ptr %v40.p
  %v348 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41.p = getelementptr i64, ptr %v348, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v26, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.c = icmp uge i64 %v40, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b5 = icmp ne i64 %v43, 0
  br i1 %c.b5, label %b5.t31, label %b5.e32
b5.t31:
  br label %b8
b5.e32:
  br label %b9
b6:
  %v349 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v349, i64 0
  store i64 %v36, ptr %st32
  br label %b3
b7:
  %v350 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v350, i64 0
  store i64 %v41, ptr %st33
  %v87 = add i64 0, 1
  %v88.p = getelementptr i64, ptr %v35, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = add i64 %v88, %v87
  %st34 = getelementptr i64, ptr %v35, i64 0
  store i64 %v89, ptr %st34
  br label %b4
b8:
  %v44 = add i64 0, 8
  call void @"rt.panic"(i64 %v44)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v45.p = getelementptr i64, ptr %v26, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = inttoptr i64 %v45 to ptr
  %v47 = getelementptr i8, ptr %v46, i64 %v40
  %v48.p = getelementptr i8, ptr %v47, i64 0
  %v48.b = load i8, ptr %v48.p
  %v48 = zext i8 %v48.b to i64
  %v49 = add i64 0, 0
  %v50.c = icmp eq i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b9 = icmp ne i64 %v50, 0
  br i1 %c.b9, label %b9.t36, label %b9.e37
b9.t36:
  br label %b10
b9.e37:
  br label %b11
b10:
  %v51 = add i64 0, 0
  %st37 = getelementptr i64, ptr %v24, i64 0
  store i64 %v51, ptr %st37
  %v351 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v351, i64 0
  store i64 %v25, ptr %st38
  br label %b1
b11:
  br label %b12
b12:
  %v52 = add i64 0, 1
  %v53 = add i64 %v9, %v52
  %v54 = getelementptr i64, ptr %s8, i64 0
  %v55.p = getelementptr i64, ptr %v16, i64 0
  %v55 = load i64, ptr %v55.p
  %st39 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st39
  %v56.p = getelementptr i64, ptr %v16, i64 1
  %v56 = load i64, ptr %v56.p
  %st40 = getelementptr i64, ptr %v54, i64 1
  store i64 %v56, ptr %st40
  %v57.p = getelementptr i64, ptr %v16, i64 2
  %v57 = load i64, ptr %v57.p
  %st41 = getelementptr i64, ptr %v54, i64 2
  store i64 %v57, ptr %st41
  %v58.p = getelementptr i64, ptr %v26, i64 1
  %v58 = load i64, ptr %v58.p
  %v59.c = icmp uge i64 %v40, %v58
  %v59 = zext i1 %v59.c to i64
  %c.b12 = icmp ne i64 %v59, 0
  br i1 %c.b12, label %b12.t43, label %b12.e44
b12.t43:
  br label %b13
b12.e44:
  br label %b14
b13:
  %v60 = add i64 0, 9
  call void @"rt.panic"(i64 %v60)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v61.p = getelementptr i64, ptr %v26, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = inttoptr i64 %v61 to ptr
  %v63 = getelementptr i8, ptr %v62, i64 %v40
  %v64.p = getelementptr i8, ptr %v63, i64 0
  %v64.b = load i8, ptr %v64.p
  %v64 = zext i8 %v64.b to i64
  %v65.p = getelementptr i64, ptr %v54, i64 2
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v54, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v54, i64 1
  %v67 = load i64, ptr %v67.p
  %v70 = add i64 %v66, %v67
  %v71 = call i64 @"rt.tip8"(i64 %v65, i64 %v70)
  %v72 = add i64 0, 0
  %v73.c = icmp ne i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b14 = icmp ne i64 %v73, 0
  br i1 %c.b14, label %b14.t45, label %b14.e46
b14.t45:
  br label %b17
b14.e46:
  br label %b16
b15:
  %v68 = phi ptr [ %v77, %b16 ], [ %v74, %b17 ]
  %v69 = phi ptr [ %v78, %b16 ], [ %v75, %b17 ]
  %st46 = getelementptr i8, ptr %v69, i64 0
  %st46.b = trunc i64 %v64 to i8
  store i8 %st46.b, ptr %st46
  %v79.p = getelementptr i64, ptr %v54, i64 1
  %v79 = load i64, ptr %v79.p
  %v80 = add i64 0, 1
  %v81 = add i64 %v79, %v80
  %v82 = getelementptr i64, ptr %s9, i64 0
  %v83 = ptrtoint ptr %v68 to i64
  %st47 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st47
  %st48 = getelementptr i64, ptr %v82, i64 1
  store i64 %v81, ptr %st48
  %st49 = getelementptr i64, ptr %v82, i64 2
  store i64 %v65, ptr %st49
  %v84.p = getelementptr i64, ptr %v82, i64 0
  %v84 = load i64, ptr %v84.p
  %st50 = getelementptr i64, ptr %v16, i64 0
  store i64 %v84, ptr %st50
  %v85.p = getelementptr i64, ptr %v82, i64 1
  %v85 = load i64, ptr %v85.p
  %st51 = getelementptr i64, ptr %v16, i64 1
  store i64 %v85, ptr %st51
  %v86.p = getelementptr i64, ptr %v82, i64 2
  %v86 = load i64, ptr %v86.p
  %st52 = getelementptr i64, ptr %v16, i64 2
  store i64 %v86, ptr %st52
  br label %b7
b16:
  %v76 = add i64 0, 1
  %v77 = call ptr @"rt.slice_grow8"(i64 %v66, i64 %v67, i64 %v65, i64 %v76)
  %v78 = getelementptr i8, ptr %v77, i64 %v67
  br label %b15
b17:
  %v74 = inttoptr i64 %v66 to ptr
  %v75 = getelementptr i8, ptr %v74, i64 %v67
  br label %b15
b18:
  %v98 = phi ptr [ %v107, %b19 ], [ %v104, %b20 ]
  %v99 = phi ptr [ %v108, %b19 ], [ %v105, %b20 ]
  %st53 = getelementptr i8, ptr %v99, i64 0
  %st53.b = trunc i64 %v94 to i8
  store i8 %st53.b, ptr %st53
  %v109.p = getelementptr i64, ptr %v90, i64 1
  %v109 = load i64, ptr %v109.p
  %v110 = add i64 0, 1
  %v111 = add i64 %v109, %v110
  %v112 = getelementptr i64, ptr %s8, i64 0
  %v113 = ptrtoint ptr %v98 to i64
  %st54 = getelementptr i64, ptr %v112, i64 0
  store i64 %v113, ptr %st54
  %st55 = getelementptr i64, ptr %v112, i64 1
  store i64 %v111, ptr %st55
  %st56 = getelementptr i64, ptr %v112, i64 2
  store i64 %v95, ptr %st56
  %v114.p = getelementptr i64, ptr %v112, i64 0
  %v114 = load i64, ptr %v114.p
  %st57 = getelementptr i64, ptr %v16, i64 0
  store i64 %v114, ptr %st57
  %v115.p = getelementptr i64, ptr %v112, i64 1
  %v115 = load i64, ptr %v115.p
  %st58 = getelementptr i64, ptr %v16, i64 1
  store i64 %v115, ptr %st58
  %v116.p = getelementptr i64, ptr %v112, i64 2
  %v116 = load i64, ptr %v116.p
  %st59 = getelementptr i64, ptr %v16, i64 2
  store i64 %v116, ptr %st59
  %v117 = add i64 0, 1
  %st60 = getelementptr i64, ptr %v24, i64 0
  store i64 %v117, ptr %st60
  %v352 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v352, i64 0
  store i64 %v25, ptr %st61
  br label %b1
b19:
  %v106 = add i64 0, 1
  %v107 = call ptr @"rt.slice_grow8"(i64 %v96, i64 %v97, i64 %v95, i64 %v106)
  %v108 = getelementptr i8, ptr %v107, i64 %v97
  br label %b18
b20:
  %v104 = inttoptr i64 %v96 to ptr
  %v105 = getelementptr i8, ptr %v104, i64 %v97
  br label %b18
b21:
  %v121 = add i64 0, 0
  %v122 = add i64 0, 22
  %v123 = getelementptr i64, ptr %s10, i64 0
  %v124 = add i64 0, 0
  %st62 = getelementptr i64, ptr %v123, i64 0
  store i64 %v124, ptr %st62
  %st63 = getelementptr i64, ptr %v123, i64 1
  store i64 %v124, ptr %st63
  %v125 = add i64 0, 5
  %st64 = getelementptr i64, ptr %v123, i64 0
  store i64 %v125, ptr %st64
  %st65 = getelementptr i64, ptr %v123, i64 1
  store i64 %v122, ptr %st65
  %v126 = getelementptr i64, ptr %s11, i64 0
  %v127.p = getelementptr i64, ptr %v123, i64 0
  %v127 = load i64, ptr %v127.p
  %st66 = getelementptr i64, ptr %v126, i64 0
  store i64 %v127, ptr %st66
  %v128.p = getelementptr i64, ptr %v123, i64 1
  %v128 = load i64, ptr %v128.p
  %st67 = getelementptr i64, ptr %v126, i64 1
  store i64 %v128, ptr %st67
  %v129 = add i64 0, 0
  %st68 = getelementptr i64, ptr %v126, i64 2
  store i64 %v129, ptr %st68
  %st69 = getelementptr i64, ptr %v126, i64 3
  store i64 %v129, ptr %st69
  %st70 = getelementptr i64, ptr %v126, i64 4
  store i64 %v129, ptr %st70
  %v130 = getelementptr i64, ptr %s12, i64 0
  %v131 = add i64 0, 1
  %st71 = getelementptr i64, ptr %v130, i64 0
  store i64 %v131, ptr %st71
  %v132.p = getelementptr i64, ptr %v126, i64 0
  %v132 = load i64, ptr %v132.p
  %st72 = getelementptr i64, ptr %v130, i64 1
  store i64 %v132, ptr %st72
  %v133.p = getelementptr i64, ptr %v126, i64 1
  %v133 = load i64, ptr %v133.p
  %st73 = getelementptr i64, ptr %v130, i64 2
  store i64 %v133, ptr %st73
  %v134.p = getelementptr i64, ptr %v126, i64 2
  %v134 = load i64, ptr %v134.p
  %st74 = getelementptr i64, ptr %v130, i64 3
  store i64 %v134, ptr %st74
  %v135.p = getelementptr i64, ptr %v126, i64 3
  %v135 = load i64, ptr %v135.p
  %st75 = getelementptr i64, ptr %v130, i64 4
  store i64 %v135, ptr %st75
  %v136.p = getelementptr i64, ptr %v126, i64 4
  %v136 = load i64, ptr %v136.p
  %st76 = getelementptr i64, ptr %v130, i64 5
  store i64 %v136, ptr %st76
  %st77 = getelementptr i64, ptr %v0, i64 0
  store i64 %v121, ptr %st77
  %v137.p = getelementptr i64, ptr %v130, i64 0
  %v137 = load i64, ptr %v137.p
  %st78 = getelementptr i64, ptr %v0, i64 1
  store i64 %v137, ptr %st78
  %v138.p = getelementptr i64, ptr %v130, i64 1
  %v138 = load i64, ptr %v138.p
  %st79 = getelementptr i64, ptr %v0, i64 2
  store i64 %v138, ptr %st79
  %v139.p = getelementptr i64, ptr %v130, i64 2
  %v139 = load i64, ptr %v139.p
  %st80 = getelementptr i64, ptr %v0, i64 3
  store i64 %v139, ptr %st80
  %v140.p = getelementptr i64, ptr %v130, i64 3
  %v140 = load i64, ptr %v140.p
  %st81 = getelementptr i64, ptr %v0, i64 4
  store i64 %v140, ptr %st81
  %v141.p = getelementptr i64, ptr %v130, i64 4
  %v141 = load i64, ptr %v141.p
  %st82 = getelementptr i64, ptr %v0, i64 5
  store i64 %v141, ptr %st82
  %v142.p = getelementptr i64, ptr %v130, i64 5
  %v142 = load i64, ptr %v142.p
  %st83 = getelementptr i64, ptr %v0, i64 6
  store i64 %v142, ptr %st83
  %v143.p = getelementptr i64, ptr %v0, i64 1
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 0
  %v145.c = icmp ne i64 %v143, %v144
  %v145 = zext i1 %v145.c to i64
  %c.b21 = icmp ne i64 %v145, 0
  br i1 %c.b21, label %b21.t85, label %b21.e86
b21.t85:
  br label %b23
b21.e86:
  br label %b24
b22:
  br label %b25
b23:
  %v146 = add i64 0, 4
  %v147 = getelementptr i64, ptr %v0, i64 %v146
  %v353 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v147, i64 %v353, i64 %v9)
  br label %b24
b24:
  %v354 = getelementptr i64, ptr @"rt.meta", i64 0
  %st86 = getelementptr i64, ptr %v354, i64 0
  store i64 %v9, ptr %st86
  ret void
b25:
  %v355 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v355, i64 0
  %v148 = load i64, ptr %v148.p
  %v149 = add i64 0, 0
  %v150.p = getelementptr i64, ptr %v8, i64 1
  %v150 = load i64, ptr %v150.p
  %v151 = getelementptr i64, ptr %s7, i64 0
  %v356 = getelementptr i64, ptr @"rt.meta", i64 0
  %v152.p = getelementptr i64, ptr %v356, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = getelementptr i64, ptr %s6, i64 0
  %st87 = getelementptr i64, ptr %v153, i64 0
  store i64 %v149, ptr %st87
  %v357 = getelementptr i64, ptr @"rt.meta", i64 0
  %v154.p = getelementptr i64, ptr %v357, i64 0
  %v154 = load i64, ptr %v154.p
  br label %b28
b26:
  %v358 = getelementptr i64, ptr @"rt.meta", i64 0
  %st88 = getelementptr i64, ptr %v358, i64 0
  store i64 %v148, ptr %st88
  %v301 = call i64 @"rt.run"(ptr %v16)
  %v302 = add i64 0, 0
  %v303.c = icmp slt i64 %v301, %v302
  %v303 = zext i1 %v303.c to i64
  %c.b26 = icmp ne i64 %v303, 0
  br i1 %c.b26, label %b26.t90, label %b26.e91
b26.t90:
  br label %b59
b26.e91:
  br label %b60
b27:
  br label %b26
b28:
  %v359 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v359, i64 0
  store i64 %v154, ptr %st91
  %v155.p = getelementptr i64, ptr %v153, i64 0
  %v155 = load i64, ptr %v155.p
  %v156.c = icmp slt i64 %v155, %v150
  %v156 = zext i1 %v156.c to i64
  %c.b28 = icmp ne i64 %v156, 0
  br i1 %c.b28, label %b28.t93, label %b28.e94
b28.t93:
  br label %b29
b28.e94:
  br label %b30
b29:
  call void @"rt.region_enter"()
  %v360 = getelementptr i64, ptr @"rt.meta", i64 0
  %v157.p = getelementptr i64, ptr %v360, i64 0
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v153, i64 0
  %v158 = load i64, ptr %v158.p
  %v361 = getelementptr i64, ptr @"rt.meta", i64 0
  %v159.p = getelementptr i64, ptr %v361, i64 0
  %v159 = load i64, ptr %v159.p
  %v160.p = getelementptr i64, ptr %v8, i64 1
  %v160 = load i64, ptr %v160.p
  %v161.c = icmp uge i64 %v158, %v160
  %v161 = zext i1 %v161.c to i64
  %c.b29 = icmp ne i64 %v161, 0
  br i1 %c.b29, label %b29.t95, label %b29.e96
b29.t95:
  br label %b32
b29.e96:
  br label %b33
b30:
  %v362 = getelementptr i64, ptr @"rt.meta", i64 0
  %st96 = getelementptr i64, ptr %v362, i64 0
  store i64 %v154, ptr %st96
  br label %b27
b31:
  %v363 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v363, i64 0
  store i64 %v159, ptr %st97
  %v298 = add i64 0, 1
  %v299.p = getelementptr i64, ptr %v153, i64 0
  %v299 = load i64, ptr %v299.p
  %v300 = add i64 %v299, %v298
  %st98 = getelementptr i64, ptr %v153, i64 0
  store i64 %v300, ptr %st98
  br label %b28
b32:
  %v162 = add i64 0, 10
  call void @"rt.panic"(i64 %v162)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b33:
  %v163.p = getelementptr i64, ptr %v8, i64 0
  %v163 = load i64, ptr %v163.p
  %v164 = inttoptr i64 %v163 to ptr
  %v165 = add i64 0, 3
  %v166 = mul i64 %v158, %v165
  %v167 = getelementptr i64, ptr %v164, i64 %v166
  %v168 = getelementptr i64, ptr %s5, i64 0
  %v169.p = getelementptr i64, ptr %v167, i64 0
  %v169 = load i64, ptr %v169.p
  %st99 = getelementptr i64, ptr %v168, i64 0
  store i64 %v169, ptr %st99
  %v170.p = getelementptr i64, ptr %v167, i64 1
  %v170 = load i64, ptr %v170.p
  %st100 = getelementptr i64, ptr %v168, i64 1
  store i64 %v170, ptr %st100
  %v171.p = getelementptr i64, ptr %v167, i64 2
  %v171 = load i64, ptr %v171.p
  %st101 = getelementptr i64, ptr %v168, i64 2
  store i64 %v171, ptr %st101
  %v172 = getelementptr i64, ptr %s13, i64 0
  %v364 = getelementptr i64, ptr @"rt.meta", i64 0
  %v173.p = getelementptr i64, ptr %v364, i64 0
  %v173 = load i64, ptr %v173.p
  %v174 = getelementptr i64, ptr %s2, i64 0
  %v175.p = getelementptr i64, ptr %v168, i64 0
  %v175 = load i64, ptr %v175.p
  %st102 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st102
  %v176.p = getelementptr i64, ptr %v168, i64 1
  %v176 = load i64, ptr %v176.p
  %st103 = getelementptr i64, ptr %v174, i64 1
  store i64 %v176, ptr %st103
  %v177.p = getelementptr i64, ptr %v168, i64 2
  %v177 = load i64, ptr %v177.p
  %st104 = getelementptr i64, ptr %v174, i64 2
  store i64 %v177, ptr %st104
  %v365 = getelementptr i64, ptr @"rt.meta", i64 0
  %v178.p = getelementptr i64, ptr %v365, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 0
  %v180.p = getelementptr i64, ptr %v174, i64 1
  %v180 = load i64, ptr %v180.p
  %v181 = getelementptr i64, ptr %s14, i64 0
  %v366 = getelementptr i64, ptr @"rt.meta", i64 0
  %v182.p = getelementptr i64, ptr %v366, i64 0
  %v182 = load i64, ptr %v182.p
  %v183 = getelementptr i64, ptr %s15, i64 0
  %st105 = getelementptr i64, ptr %v183, i64 0
  store i64 %v179, ptr %st105
  %v367 = getelementptr i64, ptr @"rt.meta", i64 0
  %v184.p = getelementptr i64, ptr %v367, i64 0
  %v184 = load i64, ptr %v184.p
  br label %b37
b34:
  %v268.p = getelementptr i64, ptr %v172, i64 0
  %v268 = load i64, ptr %v268.p
  %v269 = add i64 0, 1
  %v270 = xor i64 %v268, %v269
  %c.b34 = icmp ne i64 %v270, 0
  br i1 %c.b34, label %b34.t107, label %b34.e108
b34.t107:
  br label %b54
b34.e108:
  br label %b55
b35:
  %v368 = getelementptr i64, ptr @"rt.meta", i64 0
  %st108 = getelementptr i64, ptr %v368, i64 0
  store i64 %v178, ptr %st108
  %v238 = add i64 0, 1
  %v239 = add i64 %v9, %v238
  %v240 = getelementptr i64, ptr %s9, i64 0
  %v241.p = getelementptr i64, ptr %v16, i64 0
  %v241 = load i64, ptr %v241.p
  %st109 = getelementptr i64, ptr %v240, i64 0
  store i64 %v241, ptr %st109
  %v242.p = getelementptr i64, ptr %v16, i64 1
  %v242 = load i64, ptr %v242.p
  %st110 = getelementptr i64, ptr %v240, i64 1
  store i64 %v242, ptr %st110
  %v243.p = getelementptr i64, ptr %v16, i64 2
  %v243 = load i64, ptr %v243.p
  %st111 = getelementptr i64, ptr %v240, i64 2
  store i64 %v243, ptr %st111
  %v244 = add i64 0, 0
  %v245.p = getelementptr i64, ptr %v240, i64 2
  %v245 = load i64, ptr %v245.p
  %v246.p = getelementptr i64, ptr %v240, i64 0
  %v246 = load i64, ptr %v246.p
  %v247.p = getelementptr i64, ptr %v240, i64 1
  %v247 = load i64, ptr %v247.p
  %v250 = add i64 %v246, %v247
  %v251 = call i64 @"rt.tip8"(i64 %v245, i64 %v250)
  %v252 = add i64 0, 0
  %v253.c = icmp ne i64 %v251, %v252
  %v253 = zext i1 %v253.c to i64
  %c.b35 = icmp ne i64 %v253, 0
  br i1 %c.b35, label %b35.t113, label %b35.e114
b35.t113:
  br label %b53
b35.e114:
  br label %b52
b36:
  br label %b35
b37:
  %v369 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v369, i64 0
  store i64 %v184, ptr %st114
  %v185.p = getelementptr i64, ptr %v183, i64 0
  %v185 = load i64, ptr %v185.p
  %v186.c = icmp slt i64 %v185, %v180
  %v186 = zext i1 %v186.c to i64
  %c.b37 = icmp ne i64 %v186, 0
  br i1 %c.b37, label %b37.t116, label %b37.e117
b37.t116:
  br label %b38
b37.e117:
  br label %b39
b38:
  call void @"rt.region_enter"()
  %v370 = getelementptr i64, ptr @"rt.meta", i64 0
  %v187.p = getelementptr i64, ptr %v370, i64 0
  %v187 = load i64, ptr %v187.p
  %v188.p = getelementptr i64, ptr %v183, i64 0
  %v188 = load i64, ptr %v188.p
  %v371 = getelementptr i64, ptr @"rt.meta", i64 0
  %v189.p = getelementptr i64, ptr %v371, i64 0
  %v189 = load i64, ptr %v189.p
  %v190.p = getelementptr i64, ptr %v174, i64 1
  %v190 = load i64, ptr %v190.p
  %v191.c = icmp uge i64 %v188, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b38 = icmp ne i64 %v191, 0
  br i1 %c.b38, label %b38.t118, label %b38.e119
b38.t118:
  br label %b41
b38.e119:
  br label %b42
b39:
  %v372 = getelementptr i64, ptr @"rt.meta", i64 0
  %st119 = getelementptr i64, ptr %v372, i64 0
  store i64 %v184, ptr %st119
  br label %b36
b40:
  %v373 = getelementptr i64, ptr @"rt.meta", i64 0
  %st120 = getelementptr i64, ptr %v373, i64 0
  store i64 %v189, ptr %st120
  %v235 = add i64 0, 1
  %v236.p = getelementptr i64, ptr %v183, i64 0
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 %v236, %v235
  %st121 = getelementptr i64, ptr %v183, i64 0
  store i64 %v237, ptr %st121
  br label %b37
b41:
  %v192 = add i64 0, 11
  call void @"rt.panic"(i64 %v192)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b42:
  %v193.p = getelementptr i64, ptr %v174, i64 0
  %v193 = load i64, ptr %v193.p
  %v194 = inttoptr i64 %v193 to ptr
  %v195 = getelementptr i8, ptr %v194, i64 %v188
  %v196.p = getelementptr i8, ptr %v195, i64 0
  %v196.b = load i8, ptr %v196.p
  %v196 = zext i8 %v196.b to i64
  %v197 = add i64 0, 0
  %v198.c = icmp eq i64 %v196, %v197
  %v198 = zext i1 %v198.c to i64
  %c.b42 = icmp ne i64 %v198, 0
  br i1 %c.b42, label %b42.t123, label %b42.e124
b42.t123:
  br label %b43
b42.e124:
  br label %b44
b43:
  %v199 = add i64 0, 0
  %st124 = getelementptr i64, ptr %v172, i64 0
  store i64 %v199, ptr %st124
  %v374 = getelementptr i64, ptr @"rt.meta", i64 0
  %st125 = getelementptr i64, ptr %v374, i64 0
  store i64 %v173, ptr %st125
  br label %b34
b44:
  br label %b45
b45:
  %v200 = add i64 0, 1
  %v201 = add i64 %v9, %v200
  %v202 = getelementptr i64, ptr %s8, i64 0
  %v203.p = getelementptr i64, ptr %v16, i64 0
  %v203 = load i64, ptr %v203.p
  %st126 = getelementptr i64, ptr %v202, i64 0
  store i64 %v203, ptr %st126
  %v204.p = getelementptr i64, ptr %v16, i64 1
  %v204 = load i64, ptr %v204.p
  %st127 = getelementptr i64, ptr %v202, i64 1
  store i64 %v204, ptr %st127
  %v205.p = getelementptr i64, ptr %v16, i64 2
  %v205 = load i64, ptr %v205.p
  %st128 = getelementptr i64, ptr %v202, i64 2
  store i64 %v205, ptr %st128
  %v206.p = getelementptr i64, ptr %v174, i64 1
  %v206 = load i64, ptr %v206.p
  %v207.c = icmp uge i64 %v188, %v206
  %v207 = zext i1 %v207.c to i64
  %c.b45 = icmp ne i64 %v207, 0
  br i1 %c.b45, label %b45.t130, label %b45.e131
b45.t130:
  br label %b46
b45.e131:
  br label %b47
b46:
  %v208 = add i64 0, 12
  call void @"rt.panic"(i64 %v208)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v209.p = getelementptr i64, ptr %v174, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = inttoptr i64 %v209 to ptr
  %v211 = getelementptr i8, ptr %v210, i64 %v188
  %v212.p = getelementptr i8, ptr %v211, i64 0
  %v212.b = load i8, ptr %v212.p
  %v212 = zext i8 %v212.b to i64
  %v213.p = getelementptr i64, ptr %v202, i64 2
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v202, i64 0
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v202, i64 1
  %v215 = load i64, ptr %v215.p
  %v218 = add i64 %v214, %v215
  %v219 = call i64 @"rt.tip8"(i64 %v213, i64 %v218)
  %v220 = add i64 0, 0
  %v221.c = icmp ne i64 %v219, %v220
  %v221 = zext i1 %v221.c to i64
  %c.b47 = icmp ne i64 %v221, 0
  br i1 %c.b47, label %b47.t132, label %b47.e133
b47.t132:
  br label %b50
b47.e133:
  br label %b49
b48:
  %v216 = phi ptr [ %v225, %b49 ], [ %v222, %b50 ]
  %v217 = phi ptr [ %v226, %b49 ], [ %v223, %b50 ]
  %st133 = getelementptr i8, ptr %v217, i64 0
  %st133.b = trunc i64 %v212 to i8
  store i8 %st133.b, ptr %st133
  %v227.p = getelementptr i64, ptr %v202, i64 1
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 0, 1
  %v229 = add i64 %v227, %v228
  %v230 = getelementptr i64, ptr %s9, i64 0
  %v231 = ptrtoint ptr %v216 to i64
  %st134 = getelementptr i64, ptr %v230, i64 0
  store i64 %v231, ptr %st134
  %st135 = getelementptr i64, ptr %v230, i64 1
  store i64 %v229, ptr %st135
  %st136 = getelementptr i64, ptr %v230, i64 2
  store i64 %v213, ptr %st136
  %v232.p = getelementptr i64, ptr %v230, i64 0
  %v232 = load i64, ptr %v232.p
  %st137 = getelementptr i64, ptr %v16, i64 0
  store i64 %v232, ptr %st137
  %v233.p = getelementptr i64, ptr %v230, i64 1
  %v233 = load i64, ptr %v233.p
  %st138 = getelementptr i64, ptr %v16, i64 1
  store i64 %v233, ptr %st138
  %v234.p = getelementptr i64, ptr %v230, i64 2
  %v234 = load i64, ptr %v234.p
  %st139 = getelementptr i64, ptr %v16, i64 2
  store i64 %v234, ptr %st139
  br label %b40
b49:
  %v224 = add i64 0, 1
  %v225 = call ptr @"rt.slice_grow8"(i64 %v214, i64 %v215, i64 %v213, i64 %v224)
  %v226 = getelementptr i8, ptr %v225, i64 %v215
  br label %b48
b50:
  %v222 = inttoptr i64 %v214 to ptr
  %v223 = getelementptr i8, ptr %v222, i64 %v215
  br label %b48
b51:
  %v248 = phi ptr [ %v257, %b52 ], [ %v254, %b53 ]
  %v249 = phi ptr [ %v258, %b52 ], [ %v255, %b53 ]
  %st140 = getelementptr i8, ptr %v249, i64 0
  %st140.b = trunc i64 %v244 to i8
  store i8 %st140.b, ptr %st140
  %v259.p = getelementptr i64, ptr %v240, i64 1
  %v259 = load i64, ptr %v259.p
  %v260 = add i64 0, 1
  %v261 = add i64 %v259, %v260
  %v262 = getelementptr i64, ptr %s8, i64 0
  %v263 = ptrtoint ptr %v248 to i64
  %st141 = getelementptr i64, ptr %v262, i64 0
  store i64 %v263, ptr %st141
  %st142 = getelementptr i64, ptr %v262, i64 1
  store i64 %v261, ptr %st142
  %st143 = getelementptr i64, ptr %v262, i64 2
  store i64 %v245, ptr %st143
  %v264.p = getelementptr i64, ptr %v262, i64 0
  %v264 = load i64, ptr %v264.p
  %st144 = getelementptr i64, ptr %v16, i64 0
  store i64 %v264, ptr %st144
  %v265.p = getelementptr i64, ptr %v262, i64 1
  %v265 = load i64, ptr %v265.p
  %st145 = getelementptr i64, ptr %v16, i64 1
  store i64 %v265, ptr %st145
  %v266.p = getelementptr i64, ptr %v262, i64 2
  %v266 = load i64, ptr %v266.p
  %st146 = getelementptr i64, ptr %v16, i64 2
  store i64 %v266, ptr %st146
  %v267 = add i64 0, 1
  %st147 = getelementptr i64, ptr %v172, i64 0
  store i64 %v267, ptr %st147
  %v375 = getelementptr i64, ptr @"rt.meta", i64 0
  %st148 = getelementptr i64, ptr %v375, i64 0
  store i64 %v173, ptr %st148
  br label %b34
b52:
  %v256 = add i64 0, 1
  %v257 = call ptr @"rt.slice_grow8"(i64 %v246, i64 %v247, i64 %v245, i64 %v256)
  %v258 = getelementptr i8, ptr %v257, i64 %v247
  br label %b51
b53:
  %v254 = inttoptr i64 %v246 to ptr
  %v255 = getelementptr i8, ptr %v254, i64 %v247
  br label %b51
b54:
  %v271 = add i64 0, 0
  %v272 = add i64 0, 22
  %v273 = getelementptr i64, ptr %s10, i64 0
  %v274 = add i64 0, 0
  %st149 = getelementptr i64, ptr %v273, i64 0
  store i64 %v274, ptr %st149
  %st150 = getelementptr i64, ptr %v273, i64 1
  store i64 %v274, ptr %st150
  %v275 = add i64 0, 5
  %st151 = getelementptr i64, ptr %v273, i64 0
  store i64 %v275, ptr %st151
  %st152 = getelementptr i64, ptr %v273, i64 1
  store i64 %v272, ptr %st152
  %v276 = getelementptr i64, ptr %s11, i64 0
  %v277.p = getelementptr i64, ptr %v273, i64 0
  %v277 = load i64, ptr %v277.p
  %st153 = getelementptr i64, ptr %v276, i64 0
  store i64 %v277, ptr %st153
  %v278.p = getelementptr i64, ptr %v273, i64 1
  %v278 = load i64, ptr %v278.p
  %st154 = getelementptr i64, ptr %v276, i64 1
  store i64 %v278, ptr %st154
  %v279 = add i64 0, 0
  %st155 = getelementptr i64, ptr %v276, i64 2
  store i64 %v279, ptr %st155
  %st156 = getelementptr i64, ptr %v276, i64 3
  store i64 %v279, ptr %st156
  %st157 = getelementptr i64, ptr %v276, i64 4
  store i64 %v279, ptr %st157
  %v280 = getelementptr i64, ptr %s12, i64 0
  %v281 = add i64 0, 1
  %st158 = getelementptr i64, ptr %v280, i64 0
  store i64 %v281, ptr %st158
  %v282.p = getelementptr i64, ptr %v276, i64 0
  %v282 = load i64, ptr %v282.p
  %st159 = getelementptr i64, ptr %v280, i64 1
  store i64 %v282, ptr %st159
  %v283.p = getelementptr i64, ptr %v276, i64 1
  %v283 = load i64, ptr %v283.p
  %st160 = getelementptr i64, ptr %v280, i64 2
  store i64 %v283, ptr %st160
  %v284.p = getelementptr i64, ptr %v276, i64 2
  %v284 = load i64, ptr %v284.p
  %st161 = getelementptr i64, ptr %v280, i64 3
  store i64 %v284, ptr %st161
  %v285.p = getelementptr i64, ptr %v276, i64 3
  %v285 = load i64, ptr %v285.p
  %st162 = getelementptr i64, ptr %v280, i64 4
  store i64 %v285, ptr %st162
  %v286.p = getelementptr i64, ptr %v276, i64 4
  %v286 = load i64, ptr %v286.p
  %st163 = getelementptr i64, ptr %v280, i64 5
  store i64 %v286, ptr %st163
  %st164 = getelementptr i64, ptr %v0, i64 0
  store i64 %v271, ptr %st164
  %v287.p = getelementptr i64, ptr %v280, i64 0
  %v287 = load i64, ptr %v287.p
  %st165 = getelementptr i64, ptr %v0, i64 1
  store i64 %v287, ptr %st165
  %v288.p = getelementptr i64, ptr %v280, i64 1
  %v288 = load i64, ptr %v288.p
  %st166 = getelementptr i64, ptr %v0, i64 2
  store i64 %v288, ptr %st166
  %v289.p = getelementptr i64, ptr %v280, i64 2
  %v289 = load i64, ptr %v289.p
  %st167 = getelementptr i64, ptr %v0, i64 3
  store i64 %v289, ptr %st167
  %v290.p = getelementptr i64, ptr %v280, i64 3
  %v290 = load i64, ptr %v290.p
  %st168 = getelementptr i64, ptr %v0, i64 4
  store i64 %v290, ptr %st168
  %v291.p = getelementptr i64, ptr %v280, i64 4
  %v291 = load i64, ptr %v291.p
  %st169 = getelementptr i64, ptr %v0, i64 5
  store i64 %v291, ptr %st169
  %v292.p = getelementptr i64, ptr %v280, i64 5
  %v292 = load i64, ptr %v292.p
  %st170 = getelementptr i64, ptr %v0, i64 6
  store i64 %v292, ptr %st170
  %v293.p = getelementptr i64, ptr %v0, i64 1
  %v293 = load i64, ptr %v293.p
  %v294 = add i64 0, 0
  %v295.c = icmp ne i64 %v293, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b54 = icmp ne i64 %v295, 0
  br i1 %c.b54, label %b54.t172, label %b54.e173
b54.t172:
  br label %b56
b54.e173:
  br label %b57
b55:
  br label %b58
b56:
  %v296 = add i64 0, 4
  %v297 = getelementptr i64, ptr %v0, i64 %v296
  %v376 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v297, i64 %v376, i64 %v9)
  br label %b57
b57:
  %v377 = getelementptr i64, ptr @"rt.meta", i64 0
  %st173 = getelementptr i64, ptr %v377, i64 0
  store i64 %v9, ptr %st173
  ret void
b58:
  br label %b31
b59:
  %v304 = add i64 0, 0
  %v305 = getelementptr i64, ptr %s16, i64 0
  %v306 = add i64 0, 0
  %v307 = sub i64 %v306, %v301
  call void @"std/os.errOf"(ptr %v305, i64 %v307)
  %v308 = getelementptr i64, ptr %s12, i64 0
  %v309 = add i64 0, 1
  %st174 = getelementptr i64, ptr %v308, i64 0
  store i64 %v309, ptr %st174
  %v310.p = getelementptr i64, ptr %v305, i64 0
  %v310 = load i64, ptr %v310.p
  %st175 = getelementptr i64, ptr %v308, i64 1
  store i64 %v310, ptr %st175
  %v311.p = getelementptr i64, ptr %v305, i64 1
  %v311 = load i64, ptr %v311.p
  %st176 = getelementptr i64, ptr %v308, i64 2
  store i64 %v311, ptr %st176
  %v312.p = getelementptr i64, ptr %v305, i64 2
  %v312 = load i64, ptr %v312.p
  %st177 = getelementptr i64, ptr %v308, i64 3
  store i64 %v312, ptr %st177
  %v313.p = getelementptr i64, ptr %v305, i64 3
  %v313 = load i64, ptr %v313.p
  %st178 = getelementptr i64, ptr %v308, i64 4
  store i64 %v313, ptr %st178
  %v314.p = getelementptr i64, ptr %v305, i64 4
  %v314 = load i64, ptr %v314.p
  %st179 = getelementptr i64, ptr %v308, i64 5
  store i64 %v314, ptr %st179
  %st180 = getelementptr i64, ptr %v0, i64 0
  store i64 %v304, ptr %st180
  %v315.p = getelementptr i64, ptr %v308, i64 0
  %v315 = load i64, ptr %v315.p
  %st181 = getelementptr i64, ptr %v0, i64 1
  store i64 %v315, ptr %st181
  %v316.p = getelementptr i64, ptr %v308, i64 1
  %v316 = load i64, ptr %v316.p
  %st182 = getelementptr i64, ptr %v0, i64 2
  store i64 %v316, ptr %st182
  %v317.p = getelementptr i64, ptr %v308, i64 2
  %v317 = load i64, ptr %v317.p
  %st183 = getelementptr i64, ptr %v0, i64 3
  store i64 %v317, ptr %st183
  %v318.p = getelementptr i64, ptr %v308, i64 3
  %v318 = load i64, ptr %v318.p
  %st184 = getelementptr i64, ptr %v0, i64 4
  store i64 %v318, ptr %st184
  %v319.p = getelementptr i64, ptr %v308, i64 4
  %v319 = load i64, ptr %v319.p
  %st185 = getelementptr i64, ptr %v0, i64 5
  store i64 %v319, ptr %st185
  %v320.p = getelementptr i64, ptr %v308, i64 5
  %v320 = load i64, ptr %v320.p
  %st186 = getelementptr i64, ptr %v0, i64 6
  store i64 %v320, ptr %st186
  %v321.p = getelementptr i64, ptr %v0, i64 1
  %v321 = load i64, ptr %v321.p
  %v322 = add i64 0, 0
  %v323.c = icmp ne i64 %v321, %v322
  %v323 = zext i1 %v323.c to i64
  %c.b59 = icmp ne i64 %v323, 0
  br i1 %c.b59, label %b59.t188, label %b59.e189
b59.t188:
  br label %b61
b59.e189:
  br label %b62
b60:
  br label %b63
b61:
  %v324 = add i64 0, 4
  %v325 = getelementptr i64, ptr %v0, i64 %v324
  %v378 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v325, i64 %v378, i64 %v9)
  br label %b62
b62:
  %v379 = getelementptr i64, ptr @"rt.meta", i64 0
  %st189 = getelementptr i64, ptr %v379, i64 0
  store i64 %v9, ptr %st189
  ret void
b63:
  %v326 = getelementptr i64, ptr %s12, i64 0
  %v327 = add i64 0, 0
  %st190 = getelementptr i64, ptr %v326, i64 0
  store i64 %v327, ptr %st190
  %st191 = getelementptr i64, ptr %v0, i64 0
  store i64 %v301, ptr %st191
  %v328.p = getelementptr i64, ptr %v326, i64 0
  %v328 = load i64, ptr %v328.p
  %st192 = getelementptr i64, ptr %v0, i64 1
  store i64 %v328, ptr %st192
  %v329.p = getelementptr i64, ptr %v326, i64 1
  %v329 = load i64, ptr %v329.p
  %st193 = getelementptr i64, ptr %v0, i64 2
  store i64 %v329, ptr %st193
  %v330.p = getelementptr i64, ptr %v326, i64 2
  %v330 = load i64, ptr %v330.p
  %st194 = getelementptr i64, ptr %v0, i64 3
  store i64 %v330, ptr %st194
  %v331.p = getelementptr i64, ptr %v326, i64 3
  %v331 = load i64, ptr %v331.p
  %st195 = getelementptr i64, ptr %v0, i64 4
  store i64 %v331, ptr %st195
  %v332.p = getelementptr i64, ptr %v326, i64 4
  %v332 = load i64, ptr %v332.p
  %st196 = getelementptr i64, ptr %v0, i64 5
  store i64 %v332, ptr %st196
  %v333.p = getelementptr i64, ptr %v326, i64 5
  %v333 = load i64, ptr %v333.p
  %st197 = getelementptr i64, ptr %v0, i64 6
  store i64 %v333, ptr %st197
  %v334.p = getelementptr i64, ptr %v0, i64 1
  %v334 = load i64, ptr %v334.p
  %v335 = add i64 0, 0
  %v336.c = icmp ne i64 %v334, %v335
  %v336 = zext i1 %v336.c to i64
  %c.b63 = icmp ne i64 %v336, 0
  br i1 %c.b63, label %b63.t199, label %b63.e200
b63.t199:
  br label %b64
b63.e200:
  br label %b65
b64:
  %v337 = add i64 0, 4
  %v338 = getelementptr i64, ptr %v0, i64 %v337
  %v380 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v338, i64 %v380, i64 %v9)
  br label %b65
b65:
  %v381 = getelementptr i64, ptr @"rt.meta", i64 0
  %st200 = getelementptr i64, ptr %v381, i64 0
  store i64 %v9, ptr %st200
  ret void
}

define internal void @"std/io.WriteFile"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v6, ptr %st5
  %v73 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v73, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = add i64 0, 0
  %v11 = add i64 0, 0
  %v12.c = icmp ne i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v13 = getelementptr i64, ptr %s2, i64 0
  %v14 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st8
  %st9 = getelementptr i64, ptr %v13, i64 1
  store i64 %v14, ptr %st9
  %v15 = add i64 0, 3
  %st10 = getelementptr i64, ptr %v13, i64 0
  store i64 %v15, ptr %st10
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v13, i64 0
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st11
  %v18.p = getelementptr i64, ptr %v13, i64 1
  %v18 = load i64, ptr %v18.p
  %st12 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st12
  %v19 = add i64 0, 0
  %st13 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st13
  %st14 = getelementptr i64, ptr %v16, i64 3
  store i64 %v19, ptr %st14
  %st15 = getelementptr i64, ptr %v16, i64 4
  store i64 %v19, ptr %st15
  %v20 = getelementptr i64, ptr %s4, i64 0
  %v21 = add i64 0, 1
  %st16 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st16
  %v22.p = getelementptr i64, ptr %v16, i64 0
  %v22 = load i64, ptr %v22.p
  %st17 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st17
  %v23.p = getelementptr i64, ptr %v16, i64 1
  %v23 = load i64, ptr %v23.p
  %st18 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st18
  %v24.p = getelementptr i64, ptr %v16, i64 2
  %v24 = load i64, ptr %v24.p
  %st19 = getelementptr i64, ptr %v20, i64 3
  store i64 %v24, ptr %st19
  %v25.p = getelementptr i64, ptr %v16, i64 3
  %v25 = load i64, ptr %v25.p
  %st20 = getelementptr i64, ptr %v20, i64 4
  store i64 %v25, ptr %st20
  %v26.p = getelementptr i64, ptr %v16, i64 4
  %v26 = load i64, ptr %v26.p
  %st21 = getelementptr i64, ptr %v20, i64 5
  store i64 %v26, ptr %st21
  %v27.p = getelementptr i64, ptr %v20, i64 0
  %v27 = load i64, ptr %v27.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v27, ptr %st22
  %v28.p = getelementptr i64, ptr %v20, i64 1
  %v28 = load i64, ptr %v28.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v28, ptr %st23
  %v29.p = getelementptr i64, ptr %v20, i64 2
  %v29 = load i64, ptr %v29.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v29, ptr %st24
  %v30.p = getelementptr i64, ptr %v20, i64 3
  %v30 = load i64, ptr %v30.p
  %st25 = getelementptr i64, ptr %v0, i64 3
  store i64 %v30, ptr %st25
  %v31.p = getelementptr i64, ptr %v20, i64 4
  %v31 = load i64, ptr %v31.p
  %st26 = getelementptr i64, ptr %v0, i64 4
  store i64 %v31, ptr %st26
  %v32.p = getelementptr i64, ptr %v20, i64 5
  %v32 = load i64, ptr %v32.p
  %st27 = getelementptr i64, ptr %v0, i64 5
  store i64 %v32, ptr %st27
  %v33.p = getelementptr i64, ptr %v0, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 0, 0
  %v35.c = icmp ne i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b1 = icmp ne i64 %v35, 0
  br i1 %c.b1, label %b1.t29, label %b1.e30
b1.t29:
  br label %b3
b1.e30:
  br label %b4
b2:
  br label %b5
b3:
  %v36 = add i64 0, 3
  %v37 = getelementptr i64, ptr %v0, i64 %v36
  %v74 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v37, i64 %v74, i64 %v9)
  br label %b4
b4:
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v75, i64 0
  store i64 %v9, ptr %st30
  ret void
b5:
  %v38 = call i64 @"rt.write_file"(ptr %v7, ptr %v8)
  %v39 = add i64 0, 0
  %v40.c = icmp ne i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b5 = icmp ne i64 %v40, 0
  br i1 %c.b5, label %b5.t32, label %b5.e33
b5.t32:
  br label %b6
b5.e33:
  br label %b7
b6:
  %v41 = getelementptr i64, ptr %s5, i64 0
  call void @"std/io.errOf"(ptr %v41, i64 %v38)
  %v42 = getelementptr i64, ptr %s4, i64 0
  %v43 = add i64 0, 1
  %st33 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st33
  %v44.p = getelementptr i64, ptr %v41, i64 0
  %v44 = load i64, ptr %v44.p
  %st34 = getelementptr i64, ptr %v42, i64 1
  store i64 %v44, ptr %st34
  %v45.p = getelementptr i64, ptr %v41, i64 1
  %v45 = load i64, ptr %v45.p
  %st35 = getelementptr i64, ptr %v42, i64 2
  store i64 %v45, ptr %st35
  %v46.p = getelementptr i64, ptr %v41, i64 2
  %v46 = load i64, ptr %v46.p
  %st36 = getelementptr i64, ptr %v42, i64 3
  store i64 %v46, ptr %st36
  %v47.p = getelementptr i64, ptr %v41, i64 3
  %v47 = load i64, ptr %v47.p
  %st37 = getelementptr i64, ptr %v42, i64 4
  store i64 %v47, ptr %st37
  %v48.p = getelementptr i64, ptr %v41, i64 4
  %v48 = load i64, ptr %v48.p
  %st38 = getelementptr i64, ptr %v42, i64 5
  store i64 %v48, ptr %st38
  %v49.p = getelementptr i64, ptr %v42, i64 0
  %v49 = load i64, ptr %v49.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v49, ptr %st39
  %v50.p = getelementptr i64, ptr %v42, i64 1
  %v50 = load i64, ptr %v50.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v50, ptr %st40
  %v51.p = getelementptr i64, ptr %v42, i64 2
  %v51 = load i64, ptr %v51.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v51, ptr %st41
  %v52.p = getelementptr i64, ptr %v42, i64 3
  %v52 = load i64, ptr %v52.p
  %st42 = getelementptr i64, ptr %v0, i64 3
  store i64 %v52, ptr %st42
  %v53.p = getelementptr i64, ptr %v42, i64 4
  %v53 = load i64, ptr %v53.p
  %st43 = getelementptr i64, ptr %v0, i64 4
  store i64 %v53, ptr %st43
  %v54.p = getelementptr i64, ptr %v42, i64 5
  %v54 = load i64, ptr %v54.p
  %st44 = getelementptr i64, ptr %v0, i64 5
  store i64 %v54, ptr %st44
  %v55.p = getelementptr i64, ptr %v0, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = add i64 0, 0
  %v57.c = icmp ne i64 %v55, %v56
  %v57 = zext i1 %v57.c to i64
  %c.b6 = icmp ne i64 %v57, 0
  br i1 %c.b6, label %b6.t46, label %b6.e47
b6.t46:
  br label %b8
b6.e47:
  br label %b9
b7:
  br label %b10
b8:
  %v58 = add i64 0, 3
  %v59 = getelementptr i64, ptr %v0, i64 %v58
  %v76 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v59, i64 %v76, i64 %v9)
  br label %b9
b9:
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v77, i64 0
  store i64 %v9, ptr %st47
  ret void
b10:
  %v60 = getelementptr i64, ptr %s4, i64 0
  %v61 = add i64 0, 0
  %st48 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st48
  %v62.p = getelementptr i64, ptr %v60, i64 0
  %v62 = load i64, ptr %v62.p
  %st49 = getelementptr i64, ptr %v0, i64 0
  store i64 %v62, ptr %st49
  %v63.p = getelementptr i64, ptr %v60, i64 1
  %v63 = load i64, ptr %v63.p
  %st50 = getelementptr i64, ptr %v0, i64 1
  store i64 %v63, ptr %st50
  %v64.p = getelementptr i64, ptr %v60, i64 2
  %v64 = load i64, ptr %v64.p
  %st51 = getelementptr i64, ptr %v0, i64 2
  store i64 %v64, ptr %st51
  %v65.p = getelementptr i64, ptr %v60, i64 3
  %v65 = load i64, ptr %v65.p
  %st52 = getelementptr i64, ptr %v0, i64 3
  store i64 %v65, ptr %st52
  %v66.p = getelementptr i64, ptr %v60, i64 4
  %v66 = load i64, ptr %v66.p
  %st53 = getelementptr i64, ptr %v0, i64 4
  store i64 %v66, ptr %st53
  %v67.p = getelementptr i64, ptr %v60, i64 5
  %v67 = load i64, ptr %v67.p
  %st54 = getelementptr i64, ptr %v0, i64 5
  store i64 %v67, ptr %st54
  %v68.p = getelementptr i64, ptr %v0, i64 0
  %v68 = load i64, ptr %v68.p
  %v69 = add i64 0, 0
  %v70.c = icmp ne i64 %v68, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b10 = icmp ne i64 %v70, 0
  br i1 %c.b10, label %b10.t56, label %b10.e57
b10.t56:
  br label %b11
b10.e57:
  br label %b12
b11:
  %v71 = add i64 0, 3
  %v72 = getelementptr i64, ptr %v0, i64 %v71
  %v78 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v72, i64 %v78, i64 %v9)
  br label %b12
b12:
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v79, i64 0
  store i64 %v9, ptr %st57
  ret void
}

define internal void @"std/io.OpenRoot"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s4 = alloca [2 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
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
  %s9 = alloca [5 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s9.z3 = getelementptr i64, ptr %s9, i64 3
  store i64 0, ptr %s9.z3
  %s9.z4 = getelementptr i64, ptr %s9, i64 4
  store i64 0, ptr %s9.z4
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v151, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 0
  %v7 = add i64 0, 0
  %v8.c = icmp ne i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b0 = icmp ne i64 %v8, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v9 = add i64 0, 1
  %v10 = add i64 0, 0
  %v11 = sub i64 %v10, %v9
  %v12 = getelementptr i64, ptr %s1, i64 0
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15 = getelementptr i64, ptr %s3, i64 0
  %v16 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st5
  %st6 = getelementptr i64, ptr %v15, i64 0
  store i64 %v11, ptr %st6
  %v17 = getelementptr i64, ptr %s4, i64 0
  %v18 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st7
  %st8 = getelementptr i64, ptr %v17, i64 1
  store i64 %v18, ptr %st8
  %v19 = add i64 0, 3
  %st9 = getelementptr i64, ptr %v17, i64 0
  store i64 %v19, ptr %st9
  %v20 = getelementptr i64, ptr %s5, i64 0
  %v21.p = getelementptr i64, ptr %v17, i64 0
  %v21 = load i64, ptr %v21.p
  %st10 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st10
  %v22.p = getelementptr i64, ptr %v17, i64 1
  %v22 = load i64, ptr %v22.p
  %st11 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st11
  %v23 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st12
  %st13 = getelementptr i64, ptr %v20, i64 3
  store i64 %v23, ptr %st13
  %st14 = getelementptr i64, ptr %v20, i64 4
  store i64 %v23, ptr %st14
  %v24 = getelementptr i64, ptr %s6, i64 0
  %v25 = add i64 0, 1
  %st15 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st15
  %v26.p = getelementptr i64, ptr %v20, i64 0
  %v26 = load i64, ptr %v26.p
  %st16 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st16
  %v27.p = getelementptr i64, ptr %v20, i64 1
  %v27 = load i64, ptr %v27.p
  %st17 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st17
  %v28.p = getelementptr i64, ptr %v20, i64 2
  %v28 = load i64, ptr %v28.p
  %st18 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st18
  %v29.p = getelementptr i64, ptr %v20, i64 3
  %v29 = load i64, ptr %v29.p
  %st19 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st19
  %v30.p = getelementptr i64, ptr %v20, i64 4
  %v30 = load i64, ptr %v30.p
  %st20 = getelementptr i64, ptr %v24, i64 5
  store i64 %v30, ptr %st20
  %v31.p = getelementptr i64, ptr %v15, i64 0
  %v31 = load i64, ptr %v31.p
  %st21 = getelementptr i64, ptr %v0, i64 0
  store i64 %v31, ptr %st21
  %v32.p = getelementptr i64, ptr %v24, i64 0
  %v32 = load i64, ptr %v32.p
  %st22 = getelementptr i64, ptr %v0, i64 1
  store i64 %v32, ptr %st22
  %v33.p = getelementptr i64, ptr %v24, i64 1
  %v33 = load i64, ptr %v33.p
  %st23 = getelementptr i64, ptr %v0, i64 2
  store i64 %v33, ptr %st23
  %v34.p = getelementptr i64, ptr %v24, i64 2
  %v34 = load i64, ptr %v34.p
  %st24 = getelementptr i64, ptr %v0, i64 3
  store i64 %v34, ptr %st24
  %v35.p = getelementptr i64, ptr %v24, i64 3
  %v35 = load i64, ptr %v35.p
  %st25 = getelementptr i64, ptr %v0, i64 4
  store i64 %v35, ptr %st25
  %v36.p = getelementptr i64, ptr %v24, i64 4
  %v36 = load i64, ptr %v36.p
  %st26 = getelementptr i64, ptr %v0, i64 5
  store i64 %v36, ptr %st26
  %v37.p = getelementptr i64, ptr %v24, i64 5
  %v37 = load i64, ptr %v37.p
  %st27 = getelementptr i64, ptr %v0, i64 6
  store i64 %v37, ptr %st27
  %v38.p = getelementptr i64, ptr %v0, i64 1
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40.c = icmp ne i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b1 = icmp ne i64 %v40, 0
  br i1 %c.b1, label %b1.t29, label %b1.e30
b1.t29:
  br label %b3
b1.e30:
  br label %b4
b2:
  br label %b5
b3:
  %v41 = add i64 0, 4
  %v42 = getelementptr i64, ptr %v0, i64 %v41
  %v152 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v42, i64 %v152, i64 %v5)
  br label %b4
b4:
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v153, i64 0
  store i64 %v5, ptr %st30
  ret void
b5:
  %v43 = getelementptr i64, ptr %s7, i64 0
  %v44.p = getelementptr i64, ptr %v4, i64 0
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v4, i64 1
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v4, i64 2
  %v46 = load i64, ptr %v46.p
  call void @"std/io.cstr"(ptr %v43, i64 %v44, i64 %v45, i64 %v46)
  %v47 = getelementptr i64, ptr %s8, i64 0
  %v48.p = getelementptr i64, ptr %v43, i64 0
  %v48 = load i64, ptr %v48.p
  %st31 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st31
  %v49.p = getelementptr i64, ptr %v43, i64 1
  %v49 = load i64, ptr %v49.p
  %st32 = getelementptr i64, ptr %v47, i64 1
  store i64 %v49, ptr %st32
  %v50.p = getelementptr i64, ptr %v43, i64 2
  %v50 = load i64, ptr %v50.p
  %st33 = getelementptr i64, ptr %v47, i64 2
  store i64 %v50, ptr %st33
  %v51.p = getelementptr i64, ptr %v47, i64 1
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp eq i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b5 = icmp ne i64 %v53, 0
  br i1 %c.b5, label %b5.t35, label %b5.e36
b5.t35:
  br label %b6
b5.e36:
  br label %b7
b6:
  %v54 = add i64 0, 1
  %v55 = add i64 0, 0
  %v56 = sub i64 %v55, %v54
  %v57 = getelementptr i64, ptr %s3, i64 0
  %v58 = add i64 0, 0
  %v59 = getelementptr i64, ptr %s2, i64 0
  %v60 = getelementptr i64, ptr %s1, i64 0
  %v61 = add i64 0, 0
  %st36 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st36
  %st37 = getelementptr i64, ptr %v60, i64 0
  store i64 %v56, ptr %st37
  %v62 = add i64 0, 22
  %v63 = getelementptr i64, ptr %s4, i64 0
  %v64 = add i64 0, 0
  %st38 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st38
  %st39 = getelementptr i64, ptr %v63, i64 1
  store i64 %v64, ptr %st39
  %v65 = add i64 0, 5
  %st40 = getelementptr i64, ptr %v63, i64 0
  store i64 %v65, ptr %st40
  %st41 = getelementptr i64, ptr %v63, i64 1
  store i64 %v62, ptr %st41
  %v66 = getelementptr i64, ptr %s5, i64 0
  %v67.p = getelementptr i64, ptr %v63, i64 0
  %v67 = load i64, ptr %v67.p
  %st42 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st42
  %v68.p = getelementptr i64, ptr %v63, i64 1
  %v68 = load i64, ptr %v68.p
  %st43 = getelementptr i64, ptr %v66, i64 1
  store i64 %v68, ptr %st43
  %v69 = add i64 0, 0
  %st44 = getelementptr i64, ptr %v66, i64 2
  store i64 %v69, ptr %st44
  %st45 = getelementptr i64, ptr %v66, i64 3
  store i64 %v69, ptr %st45
  %st46 = getelementptr i64, ptr %v66, i64 4
  store i64 %v69, ptr %st46
  %v70 = getelementptr i64, ptr %s6, i64 0
  %v71 = add i64 0, 1
  %st47 = getelementptr i64, ptr %v70, i64 0
  store i64 %v71, ptr %st47
  %v72.p = getelementptr i64, ptr %v66, i64 0
  %v72 = load i64, ptr %v72.p
  %st48 = getelementptr i64, ptr %v70, i64 1
  store i64 %v72, ptr %st48
  %v73.p = getelementptr i64, ptr %v66, i64 1
  %v73 = load i64, ptr %v73.p
  %st49 = getelementptr i64, ptr %v70, i64 2
  store i64 %v73, ptr %st49
  %v74.p = getelementptr i64, ptr %v66, i64 2
  %v74 = load i64, ptr %v74.p
  %st50 = getelementptr i64, ptr %v70, i64 3
  store i64 %v74, ptr %st50
  %v75.p = getelementptr i64, ptr %v66, i64 3
  %v75 = load i64, ptr %v75.p
  %st51 = getelementptr i64, ptr %v70, i64 4
  store i64 %v75, ptr %st51
  %v76.p = getelementptr i64, ptr %v66, i64 4
  %v76 = load i64, ptr %v76.p
  %st52 = getelementptr i64, ptr %v70, i64 5
  store i64 %v76, ptr %st52
  %v77.p = getelementptr i64, ptr %v60, i64 0
  %v77 = load i64, ptr %v77.p
  %st53 = getelementptr i64, ptr %v0, i64 0
  store i64 %v77, ptr %st53
  %v78.p = getelementptr i64, ptr %v70, i64 0
  %v78 = load i64, ptr %v78.p
  %st54 = getelementptr i64, ptr %v0, i64 1
  store i64 %v78, ptr %st54
  %v79.p = getelementptr i64, ptr %v70, i64 1
  %v79 = load i64, ptr %v79.p
  %st55 = getelementptr i64, ptr %v0, i64 2
  store i64 %v79, ptr %st55
  %v80.p = getelementptr i64, ptr %v70, i64 2
  %v80 = load i64, ptr %v80.p
  %st56 = getelementptr i64, ptr %v0, i64 3
  store i64 %v80, ptr %st56
  %v81.p = getelementptr i64, ptr %v70, i64 3
  %v81 = load i64, ptr %v81.p
  %st57 = getelementptr i64, ptr %v0, i64 4
  store i64 %v81, ptr %st57
  %v82.p = getelementptr i64, ptr %v70, i64 4
  %v82 = load i64, ptr %v82.p
  %st58 = getelementptr i64, ptr %v0, i64 5
  store i64 %v82, ptr %st58
  %v83.p = getelementptr i64, ptr %v70, i64 5
  %v83 = load i64, ptr %v83.p
  %st59 = getelementptr i64, ptr %v0, i64 6
  store i64 %v83, ptr %st59
  %v84.p = getelementptr i64, ptr %v0, i64 1
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 0
  %v86.c = icmp ne i64 %v84, %v85
  %v86 = zext i1 %v86.c to i64
  %c.b6 = icmp ne i64 %v86, 0
  br i1 %c.b6, label %b6.t61, label %b6.e62
b6.t61:
  br label %b8
b6.e62:
  br label %b9
b7:
  br label %b10
b8:
  %v87 = add i64 0, 4
  %v88 = getelementptr i64, ptr %v0, i64 %v87
  %v154 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v88, i64 %v154, i64 %v5)
  br label %b9
b9:
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v155, i64 0
  store i64 %v5, ptr %st62
  ret void
b10:
  %v89 = add i64 0, 257
  %v90 = add i64 0, 100
  %v91 = add i64 0, 0
  %v92 = sub i64 %v91, %v90
  %v93.p = getelementptr i64, ptr %v47, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 2686976
  %v95 = add i64 0, 0
  %v96 = add i64 0, 0
  %v97 = add i64 0, 0
  %v98 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v89, i64 %v92, i64 %v93, i64 %v94, i64 %v95, i64 %v96, i64 %v97)
  %v99 = call i64 @"std/io.owned"(i64 %v98)
  %v100 = add i64 0, 0
  %v101.c = icmp slt i64 %v99, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b10 = icmp ne i64 %v101, 0
  br i1 %c.b10, label %b10.t64, label %b10.e65
b10.t64:
  br label %b11
b10.e65:
  br label %b12
b11:
  %v102 = add i64 0, 1
  %v103 = add i64 0, 0
  %v104 = sub i64 %v103, %v102
  %v105 = getelementptr i64, ptr %s1, i64 0
  %v106 = add i64 0, 0
  %v107 = getelementptr i64, ptr %s2, i64 0
  %v108 = getelementptr i64, ptr %s3, i64 0
  %v109 = add i64 0, 0
  %st65 = getelementptr i64, ptr %v108, i64 0
  store i64 %v109, ptr %st65
  %st66 = getelementptr i64, ptr %v108, i64 0
  store i64 %v104, ptr %st66
  %v110 = getelementptr i64, ptr %s9, i64 0
  %v111 = add i64 0, 0
  %v112 = sub i64 %v111, %v99
  call void @"std/io.errOf"(ptr %v110, i64 %v112)
  %v113 = getelementptr i64, ptr %s6, i64 0
  %v114 = add i64 0, 1
  %st67 = getelementptr i64, ptr %v113, i64 0
  store i64 %v114, ptr %st67
  %v115.p = getelementptr i64, ptr %v110, i64 0
  %v115 = load i64, ptr %v115.p
  %st68 = getelementptr i64, ptr %v113, i64 1
  store i64 %v115, ptr %st68
  %v116.p = getelementptr i64, ptr %v110, i64 1
  %v116 = load i64, ptr %v116.p
  %st69 = getelementptr i64, ptr %v113, i64 2
  store i64 %v116, ptr %st69
  %v117.p = getelementptr i64, ptr %v110, i64 2
  %v117 = load i64, ptr %v117.p
  %st70 = getelementptr i64, ptr %v113, i64 3
  store i64 %v117, ptr %st70
  %v118.p = getelementptr i64, ptr %v110, i64 3
  %v118 = load i64, ptr %v118.p
  %st71 = getelementptr i64, ptr %v113, i64 4
  store i64 %v118, ptr %st71
  %v119.p = getelementptr i64, ptr %v110, i64 4
  %v119 = load i64, ptr %v119.p
  %st72 = getelementptr i64, ptr %v113, i64 5
  store i64 %v119, ptr %st72
  %v120.p = getelementptr i64, ptr %v108, i64 0
  %v120 = load i64, ptr %v120.p
  %st73 = getelementptr i64, ptr %v0, i64 0
  store i64 %v120, ptr %st73
  %v121.p = getelementptr i64, ptr %v113, i64 0
  %v121 = load i64, ptr %v121.p
  %st74 = getelementptr i64, ptr %v0, i64 1
  store i64 %v121, ptr %st74
  %v122.p = getelementptr i64, ptr %v113, i64 1
  %v122 = load i64, ptr %v122.p
  %st75 = getelementptr i64, ptr %v0, i64 2
  store i64 %v122, ptr %st75
  %v123.p = getelementptr i64, ptr %v113, i64 2
  %v123 = load i64, ptr %v123.p
  %st76 = getelementptr i64, ptr %v0, i64 3
  store i64 %v123, ptr %st76
  %v124.p = getelementptr i64, ptr %v113, i64 3
  %v124 = load i64, ptr %v124.p
  %st77 = getelementptr i64, ptr %v0, i64 4
  store i64 %v124, ptr %st77
  %v125.p = getelementptr i64, ptr %v113, i64 4
  %v125 = load i64, ptr %v125.p
  %st78 = getelementptr i64, ptr %v0, i64 5
  store i64 %v125, ptr %st78
  %v126.p = getelementptr i64, ptr %v113, i64 5
  %v126 = load i64, ptr %v126.p
  %st79 = getelementptr i64, ptr %v0, i64 6
  store i64 %v126, ptr %st79
  %v127.p = getelementptr i64, ptr %v0, i64 1
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 0, 0
  %v129.c = icmp ne i64 %v127, %v128
  %v129 = zext i1 %v129.c to i64
  %c.b11 = icmp ne i64 %v129, 0
  br i1 %c.b11, label %b11.t81, label %b11.e82
b11.t81:
  br label %b13
b11.e82:
  br label %b14
b12:
  br label %b15
b13:
  %v130 = add i64 0, 4
  %v131 = getelementptr i64, ptr %v0, i64 %v130
  %v156 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v131, i64 %v156, i64 %v5)
  br label %b14
b14:
  %v157 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v157, i64 0
  store i64 %v5, ptr %st82
  ret void
b15:
  %v132 = getelementptr i64, ptr %s3, i64 0
  %v133 = add i64 0, 0
  %v134 = getelementptr i64, ptr %s2, i64 0
  %v135 = getelementptr i64, ptr %s1, i64 0
  %v136 = add i64 0, 0
  %st83 = getelementptr i64, ptr %v135, i64 0
  store i64 %v136, ptr %st83
  %st84 = getelementptr i64, ptr %v135, i64 0
  store i64 %v99, ptr %st84
  %v137 = getelementptr i64, ptr %s6, i64 0
  %v138 = add i64 0, 0
  %st85 = getelementptr i64, ptr %v137, i64 0
  store i64 %v138, ptr %st85
  %v139.p = getelementptr i64, ptr %v135, i64 0
  %v139 = load i64, ptr %v139.p
  %st86 = getelementptr i64, ptr %v0, i64 0
  store i64 %v139, ptr %st86
  %v140.p = getelementptr i64, ptr %v137, i64 0
  %v140 = load i64, ptr %v140.p
  %st87 = getelementptr i64, ptr %v0, i64 1
  store i64 %v140, ptr %st87
  %v141.p = getelementptr i64, ptr %v137, i64 1
  %v141 = load i64, ptr %v141.p
  %st88 = getelementptr i64, ptr %v0, i64 2
  store i64 %v141, ptr %st88
  %v142.p = getelementptr i64, ptr %v137, i64 2
  %v142 = load i64, ptr %v142.p
  %st89 = getelementptr i64, ptr %v0, i64 3
  store i64 %v142, ptr %st89
  %v143.p = getelementptr i64, ptr %v137, i64 3
  %v143 = load i64, ptr %v143.p
  %st90 = getelementptr i64, ptr %v0, i64 4
  store i64 %v143, ptr %st90
  %v144.p = getelementptr i64, ptr %v137, i64 4
  %v144 = load i64, ptr %v144.p
  %st91 = getelementptr i64, ptr %v0, i64 5
  store i64 %v144, ptr %st91
  %v145.p = getelementptr i64, ptr %v137, i64 5
  %v145 = load i64, ptr %v145.p
  %st92 = getelementptr i64, ptr %v0, i64 6
  store i64 %v145, ptr %st92
  %v146.p = getelementptr i64, ptr %v0, i64 1
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 0, 0
  %v148.c = icmp ne i64 %v146, %v147
  %v148 = zext i1 %v148.c to i64
  %c.b15 = icmp ne i64 %v148, 0
  br i1 %c.b15, label %b15.t94, label %b15.e95
b15.t94:
  br label %b16
b15.e95:
  br label %b17
b16:
  %v149 = add i64 0, 4
  %v150 = getelementptr i64, ptr %v0, i64 %v149
  %v158 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v150, i64 %v158, i64 %v5)
  br label %b17
b17:
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %st95 = getelementptr i64, ptr %v159, i64 0
  store i64 %v5, ptr %st95
  ret void
}

define internal void @"main.show"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7) #0 {
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
  %s2 = alloca [3 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %s3 = alloca [7 x i64], align 8
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
  %s3.z6 = getelementptr i64, ptr %s3, i64 6
  store i64 0, ptr %s3.z6
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s5 = alloca [10 x i64], align 8
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
  %s5.z6 = getelementptr i64, ptr %s5, i64 6
  store i64 0, ptr %s5.z6
  %s5.z7 = getelementptr i64, ptr %s5, i64 7
  store i64 0, ptr %s5.z7
  %s5.z8 = getelementptr i64, ptr %s5, i64 8
  store i64 0, ptr %s5.z8
  %s5.z9 = getelementptr i64, ptr %s5, i64 9
  store i64 0, ptr %s5.z9
  %s6 = alloca [4 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s6.z3 = getelementptr i64, ptr %s6, i64 3
  store i64 0, ptr %s6.z3
  %s7 = alloca [7 x i64], align 8
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
  %s7.z6 = getelementptr i64, ptr %s7, i64 6
  store i64 0, ptr %s7.z6
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
  %s19 = alloca [3 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s19.z1 = getelementptr i64, ptr %s19, i64 1
  store i64 0, ptr %s19.z1
  %s19.z2 = getelementptr i64, ptr %s19, i64 2
  store i64 0, ptr %s19.z2
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
  %s27 = alloca [3 x i64], align 8
  %s27.z0 = getelementptr i64, ptr %s27, i64 0
  store i64 0, ptr %s27.z0
  %s27.z1 = getelementptr i64, ptr %s27, i64 1
  store i64 0, ptr %s27.z1
  %s27.z2 = getelementptr i64, ptr %s27, i64 2
  store i64 0, ptr %s27.z2
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
  %v8 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v8, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v8, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v8, i64 2
  store i64 %v3, ptr %st2
  %v9 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v9, i64 0
  store i64 %v4, ptr %st3
  %v10 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v10, i64 0
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v10, i64 1
  store i64 %v6, ptr %st5
  %st6 = getelementptr i64, ptr %v10, i64 2
  store i64 %v7, ptr %st6
  %v328 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v328, i64 0
  %v11 = load i64, ptr %v11.p
  call void @"rt.region_enter"()
  %v12 = getelementptr i64, ptr %s3, i64 0
  %v13.p = getelementptr i64, ptr %v9, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v10, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v10, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.p = getelementptr i64, ptr %v10, i64 2
  %v16 = load i64, ptr %v16.p
  call void @"std/io.OpenUnder"(ptr %v12, i64 %v13, i64 %v14, i64 %v15, i64 %v16)
  %v17 = add i64 0, 1
  %v18 = getelementptr i64, ptr %v12, i64 %v17
  %v19.p = getelementptr i64, ptr %v18, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %v21.c = icmp ne i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b0 = icmp ne i64 %v21, 0
  br i1 %c.b0, label %b0.t8, label %b0.e9
b0.t8:
  br label %b1
b0.e9:
  br label %b2
b1:
  %v22 = add i64 0, 0
  %v23.p = getelementptr i64, ptr %v18, i64 0
  %v23 = load i64, ptr %v23.p
  %st9 = getelementptr i64, ptr %v0, i64 0
  store i64 %v23, ptr %st9
  %v24.p = getelementptr i64, ptr %v18, i64 1
  %v24 = load i64, ptr %v24.p
  %st10 = getelementptr i64, ptr %v0, i64 1
  store i64 %v24, ptr %st10
  %v25.p = getelementptr i64, ptr %v18, i64 2
  %v25 = load i64, ptr %v25.p
  %st11 = getelementptr i64, ptr %v0, i64 2
  store i64 %v25, ptr %st11
  %v26.p = getelementptr i64, ptr %v18, i64 3
  %v26 = load i64, ptr %v26.p
  %st12 = getelementptr i64, ptr %v0, i64 3
  store i64 %v26, ptr %st12
  %v27.p = getelementptr i64, ptr %v18, i64 4
  %v27 = load i64, ptr %v27.p
  %st13 = getelementptr i64, ptr %v0, i64 4
  store i64 %v27, ptr %st13
  %v28.p = getelementptr i64, ptr %v18, i64 5
  %v28 = load i64, ptr %v28.p
  %st14 = getelementptr i64, ptr %v0, i64 5
  store i64 %v28, ptr %st14
  %v29.p = getelementptr i64, ptr %v0, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 0, 0
  %v31.c = icmp ne i64 %v29, %v30
  %v31 = zext i1 %v31.c to i64
  %c.b1 = icmp ne i64 %v31, 0
  br i1 %c.b1, label %b1.t16, label %b1.e17
b1.t16:
  br label %b3
b1.e17:
  br label %b4
b2:
  %v34 = getelementptr i64, ptr %s4, i64 0
  %v35.p = getelementptr i64, ptr %v12, i64 0
  %v35 = load i64, ptr %v35.p
  %st17 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st17
  %v36 = getelementptr i64, ptr %s5, i64 0
  %v37.p = getelementptr i64, ptr %v34, i64 0
  %v37 = load i64, ptr %v37.p
  call void @"std/io.Stat"(ptr %v36, i64 %v37)
  %v38 = add i64 0, 4
  %v39 = getelementptr i64, ptr %v36, i64 %v38
  %v40.p = getelementptr i64, ptr %v39, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 0
  %v42.c = icmp ne i64 %v40, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b2 = icmp ne i64 %v42, 0
  br i1 %c.b2, label %b2.t19, label %b2.e20
b2.t19:
  br label %b5
b2.e20:
  br label %b6
b3:
  %v32 = add i64 0, 3
  %v33 = getelementptr i64, ptr %v0, i64 %v32
  %v329 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v33, i64 %v329, i64 %v11)
  br label %b4
b4:
  %v330 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v330, i64 0
  store i64 %v11, ptr %st20
  ret void
b5:
  %v43 = add i64 0, 0
  %v44.p = getelementptr i64, ptr %v39, i64 0
  %v44 = load i64, ptr %v44.p
  %st21 = getelementptr i64, ptr %v0, i64 0
  store i64 %v44, ptr %st21
  %v45.p = getelementptr i64, ptr %v39, i64 1
  %v45 = load i64, ptr %v45.p
  %st22 = getelementptr i64, ptr %v0, i64 1
  store i64 %v45, ptr %st22
  %v46.p = getelementptr i64, ptr %v39, i64 2
  %v46 = load i64, ptr %v46.p
  %st23 = getelementptr i64, ptr %v0, i64 2
  store i64 %v46, ptr %st23
  %v47.p = getelementptr i64, ptr %v39, i64 3
  %v47 = load i64, ptr %v47.p
  %st24 = getelementptr i64, ptr %v0, i64 3
  store i64 %v47, ptr %st24
  %v48.p = getelementptr i64, ptr %v39, i64 4
  %v48 = load i64, ptr %v48.p
  %st25 = getelementptr i64, ptr %v0, i64 4
  store i64 %v48, ptr %st25
  %v49.p = getelementptr i64, ptr %v39, i64 5
  %v49 = load i64, ptr %v49.p
  %st26 = getelementptr i64, ptr %v0, i64 5
  store i64 %v49, ptr %st26
  %v50.p = getelementptr i64, ptr %v34, i64 0
  %v50 = load i64, ptr %v50.p
  call void @"std/io.Close"(i64 %v50)
  %v51.p = getelementptr i64, ptr %v0, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp ne i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b5 = icmp ne i64 %v53, 0
  br i1 %c.b5, label %b5.t28, label %b5.e29
b5.t28:
  br label %b7
b5.e29:
  br label %b8
b6:
  %v56 = getelementptr i64, ptr %s6, i64 0
  %v57.p = getelementptr i64, ptr %v36, i64 0
  %v57 = load i64, ptr %v57.p
  %st29 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st29
  %v58.p = getelementptr i64, ptr %v36, i64 1
  %v58 = load i64, ptr %v58.p
  %st30 = getelementptr i64, ptr %v56, i64 1
  store i64 %v58, ptr %st30
  %v59.p = getelementptr i64, ptr %v36, i64 2
  %v59 = load i64, ptr %v59.p
  %st31 = getelementptr i64, ptr %v56, i64 2
  store i64 %v59, ptr %st31
  %v60.p = getelementptr i64, ptr %v36, i64 3
  %v60 = load i64, ptr %v60.p
  %st32 = getelementptr i64, ptr %v56, i64 3
  store i64 %v60, ptr %st32
  %v61 = getelementptr i64, ptr %s7, i64 0
  %v62 = getelementptr i64, ptr @"str.25", i64 0
  %v63 = add i64 0, 1
  %v64 = add i64 0, 0
  %v65 = getelementptr i64, ptr %s8, i64 0
  %v66 = ptrtoint ptr %v62 to i64
  %st33 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st33
  %st34 = getelementptr i64, ptr %v65, i64 1
  store i64 %v63, ptr %st34
  %st35 = getelementptr i64, ptr %v65, i64 2
  store i64 %v64, ptr %st35
  %v67.p = getelementptr i64, ptr %v8, i64 1
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v65, i64 1
  %v68 = load i64, ptr %v68.p
  %v69 = add i64 %v67, %v68
  %v331 = getelementptr i64, ptr @"rt.meta", i64 0
  %v70.p = getelementptr i64, ptr %v331, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v8, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v8, i64 1
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v8, i64 2
  %v73 = load i64, ptr %v73.p
  %v74 = call ptr @"rt.cat8"(i64 %v71, i64 %v72, i64 %v73, i64 %v70, i64 %v68)
  %v75 = getelementptr i8, ptr %v74, i64 %v67
  %v76.p = getelementptr i64, ptr %v65, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = inttoptr i64 %v76 to ptr
  call void @"rt.copy8"(ptr %v75, ptr %v77, i64 %v68)
  %v78 = getelementptr i64, ptr %s9, i64 0
  %v79 = ptrtoint ptr %v74 to i64
  %st36 = getelementptr i64, ptr %v78, i64 0
  store i64 %v79, ptr %st36
  %st37 = getelementptr i64, ptr %v78, i64 1
  store i64 %v69, ptr %st37
  %st38 = getelementptr i64, ptr %v78, i64 2
  store i64 %v70, ptr %st38
  %v80.p = getelementptr i64, ptr %v78, i64 1
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v10, i64 1
  %v81 = load i64, ptr %v81.p
  %v82 = add i64 %v80, %v81
  %v332 = getelementptr i64, ptr @"rt.meta", i64 0
  %v83.p = getelementptr i64, ptr %v332, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v78, i64 0
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v78, i64 1
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v78, i64 2
  %v86 = load i64, ptr %v86.p
  %v87 = call ptr @"rt.cat8"(i64 %v84, i64 %v85, i64 %v86, i64 %v83, i64 %v81)
  %v88 = getelementptr i8, ptr %v87, i64 %v80
  %v89.p = getelementptr i64, ptr %v10, i64 0
  %v89 = load i64, ptr %v89.p
  %v90 = inttoptr i64 %v89 to ptr
  call void @"rt.copy8"(ptr %v88, ptr %v90, i64 %v81)
  %v91 = getelementptr i64, ptr %s10, i64 0
  %v92 = ptrtoint ptr %v87 to i64
  %st39 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st39
  %st40 = getelementptr i64, ptr %v91, i64 1
  store i64 %v82, ptr %st40
  %st41 = getelementptr i64, ptr %v91, i64 2
  store i64 %v83, ptr %st41
  %v93.p = getelementptr i64, ptr %v91, i64 0
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v91, i64 1
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v91, i64 2
  %v95 = load i64, ptr %v95.p
  call void @"std/os.ModTime"(ptr %v61, i64 %v93, i64 %v94, i64 %v95)
  %v96.p = getelementptr i64, ptr %v61, i64 0
  %v96 = load i64, ptr %v96.p
  %v97 = add i64 0, 1
  %v98 = getelementptr i64, ptr %v61, i64 %v97
  %v99.p = getelementptr i64, ptr %v98, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 0, 0
  %v101.c = icmp ne i64 %v99, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b6 = icmp ne i64 %v101, 0
  br i1 %c.b6, label %b6.t43, label %b6.e44
b6.t43:
  br label %b9
b6.e44:
  br label %b10
b7:
  %v54 = add i64 0, 3
  %v55 = getelementptr i64, ptr %v0, i64 %v54
  %v333 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v55, i64 %v333, i64 %v11)
  br label %b8
b8:
  %v334 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v334, i64 0
  store i64 %v11, ptr %st44
  ret void
b9:
  %v102 = add i64 0, 0
  %v103.p = getelementptr i64, ptr %v98, i64 0
  %v103 = load i64, ptr %v103.p
  %st45 = getelementptr i64, ptr %v0, i64 0
  store i64 %v103, ptr %st45
  %v104.p = getelementptr i64, ptr %v98, i64 1
  %v104 = load i64, ptr %v104.p
  %st46 = getelementptr i64, ptr %v0, i64 1
  store i64 %v104, ptr %st46
  %v105.p = getelementptr i64, ptr %v98, i64 2
  %v105 = load i64, ptr %v105.p
  %st47 = getelementptr i64, ptr %v0, i64 2
  store i64 %v105, ptr %st47
  %v106.p = getelementptr i64, ptr %v98, i64 3
  %v106 = load i64, ptr %v106.p
  %st48 = getelementptr i64, ptr %v0, i64 3
  store i64 %v106, ptr %st48
  %v107.p = getelementptr i64, ptr %v98, i64 4
  %v107 = load i64, ptr %v107.p
  %st49 = getelementptr i64, ptr %v0, i64 4
  store i64 %v107, ptr %st49
  %v108.p = getelementptr i64, ptr %v98, i64 5
  %v108 = load i64, ptr %v108.p
  %st50 = getelementptr i64, ptr %v0, i64 5
  store i64 %v108, ptr %st50
  %v109.p = getelementptr i64, ptr %v34, i64 0
  %v109 = load i64, ptr %v109.p
  call void @"std/io.Close"(i64 %v109)
  %v110.p = getelementptr i64, ptr %v0, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = add i64 0, 0
  %v112.c = icmp ne i64 %v110, %v111
  %v112 = zext i1 %v112.c to i64
  %c.b9 = icmp ne i64 %v112, 0
  br i1 %c.b9, label %b9.t52, label %b9.e53
b9.t52:
  br label %b11
b9.e53:
  br label %b12
b10:
  %v115 = getelementptr i64, ptr %s11, i64 0
  %v116 = add i64 0, 2
  %v117 = getelementptr i64, ptr %v56, i64 %v116
  %v118.p = getelementptr i64, ptr %v117, i64 0
  %v118 = load i64, ptr %v118.p
  %v119.p = getelementptr i64, ptr %v117, i64 1
  %v119 = load i64, ptr %v119.p
  call void @"main.kindName"(ptr %v115, i64 %v118, i64 %v119)
  %v120 = getelementptr i64, ptr %s10, i64 0
  %v121.p = getelementptr i64, ptr %v115, i64 0
  %v121 = load i64, ptr %v121.p
  %st53 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st53
  %v122.p = getelementptr i64, ptr %v115, i64 1
  %v122 = load i64, ptr %v122.p
  %st54 = getelementptr i64, ptr %v120, i64 1
  store i64 %v122, ptr %st54
  %v123.p = getelementptr i64, ptr %v115, i64 2
  %v123 = load i64, ptr %v123.p
  %st55 = getelementptr i64, ptr %v120, i64 2
  store i64 %v123, ptr %st55
  %v124 = getelementptr i64, ptr @"str.26", i64 0
  %v125 = add i64 0, 7
  %v126 = add i64 0, 0
  %v127 = getelementptr i64, ptr %s9, i64 0
  %v128 = ptrtoint ptr %v124 to i64
  %st56 = getelementptr i64, ptr %v127, i64 0
  store i64 %v128, ptr %st56
  %st57 = getelementptr i64, ptr %v127, i64 1
  store i64 %v125, ptr %st57
  %st58 = getelementptr i64, ptr %v127, i64 2
  store i64 %v126, ptr %st58
  %v130.p = getelementptr i64, ptr %v120, i64 1
  %v130 = load i64, ptr %v130.p
  %v131 = add i64 0, 7
  %v132.c = icmp ne i64 %v130, %v131
  %v132 = zext i1 %v132.c to i64
  %v133 = add i64 0, 0
  %c.b10 = icmp ne i64 %v132, 0
  br i1 %c.b10, label %b10.t60, label %b10.e61
b10.t60:
  br label %b13
b10.e61:
  br label %b14
b11:
  %v113 = add i64 0, 3
  %v114 = getelementptr i64, ptr %v0, i64 %v113
  %v335 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v114, i64 %v335, i64 %v11)
  br label %b12
b12:
  %v336 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v336, i64 0
  store i64 %v11, ptr %st61
  ret void
b13:
  %v129 = phi i64 [ %v133, %b10.t60 ], [ %v148, %b15 ], [ %v149, %b16 ]
  %c.b13 = icmp ne i64 %v129, 0
  br i1 %c.b13, label %b13.t63, label %b13.e64
b13.t63:
  br label %b17
b13.e64:
  br label %b18
b14:
  %v134.p = getelementptr i64, ptr %v120, i64 0
  %v134 = load i64, ptr %v134.p
  %v135 = add i64 0, 4095
  %v136 = and i64 %v134, %v135
  %v137 = add i64 0, 4089
  %v138 = sub i64 %v136, %v137
  %v139 = add i64 0, 0
  %v140.c = icmp slt i64 %v138, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b14 = icmp ne i64 %v140, 0
  br i1 %c.b14, label %b14.t65, label %b14.e66
b14.t65:
  br label %b15
b14.e66:
  br label %b16
b15:
  %v141 = inttoptr i64 %v134 to ptr
  %v142.p = getelementptr i64, ptr %v141, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = add i64 0, 32195265799087474
  %v144 = xor i64 %v142, %v143
  %v145 = add i64 0, 8
  %v146.n = and i64 %v145, 63
  %v146 = shl i64 %v144, %v146.n
  %v147 = add i64 0, 0
  %v148.c = icmp eq i64 %v146, %v147
  %v148 = zext i1 %v148.c to i64
  br label %b13
b16:
  %v149 = call i64 @"rt.str_eq"(ptr %v120, ptr %v127)
  br label %b13
b17:
  %v150.p = getelementptr i64, ptr %v56, i64 0
  %v150 = load i64, ptr %v150.p
  %v151 = getelementptr i64, ptr @"str.27", i64 0
  %v152 = add i64 0, 6
  %v153 = add i64 0, 0
  %v154 = getelementptr i64, ptr %s8, i64 0
  %v155 = ptrtoint ptr %v151 to i64
  %st66 = getelementptr i64, ptr %v154, i64 0
  store i64 %v155, ptr %st66
  %st67 = getelementptr i64, ptr %v154, i64 1
  store i64 %v152, ptr %st67
  %st68 = getelementptr i64, ptr %v154, i64 2
  store i64 %v153, ptr %st68
  %v156 = getelementptr i64, ptr %s12, i64 0
  call void @"std/convert.FormatInt"(ptr %v156, i64 %v150)
  %v157.p = getelementptr i64, ptr %v154, i64 1
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v156, i64 1
  %v158 = load i64, ptr %v158.p
  %v159 = add i64 %v157, %v158
  %v337 = getelementptr i64, ptr @"rt.meta", i64 0
  %v160.p = getelementptr i64, ptr %v337, i64 0
  %v160 = load i64, ptr %v160.p
  %v161.p = getelementptr i64, ptr %v154, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v154, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v154, i64 2
  %v163 = load i64, ptr %v163.p
  %v164 = call ptr @"rt.cat8"(i64 %v161, i64 %v162, i64 %v163, i64 %v160, i64 %v158)
  %v165 = getelementptr i8, ptr %v164, i64 %v157
  %v166.p = getelementptr i64, ptr %v156, i64 0
  %v166 = load i64, ptr %v166.p
  %v167 = inttoptr i64 %v166 to ptr
  call void @"rt.copy8"(ptr %v165, ptr %v167, i64 %v158)
  %v168 = getelementptr i64, ptr %s13, i64 0
  %v169 = ptrtoint ptr %v164 to i64
  %st69 = getelementptr i64, ptr %v168, i64 0
  store i64 %v169, ptr %st69
  %st70 = getelementptr i64, ptr %v168, i64 1
  store i64 %v159, ptr %st70
  %st71 = getelementptr i64, ptr %v168, i64 2
  store i64 %v160, ptr %st71
  br label %b19
b18:
  %v170 = getelementptr i64, ptr @"str.28", i64 0
  %v171 = add i64 0, 0
  %v172 = add i64 0, 0
  %v173 = getelementptr i64, ptr %s14, i64 0
  %v174 = ptrtoint ptr %v170 to i64
  %st72 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st72
  %st73 = getelementptr i64, ptr %v173, i64 1
  store i64 %v171, ptr %st73
  %st74 = getelementptr i64, ptr %v173, i64 2
  store i64 %v172, ptr %st74
  br label %b19
b19:
  %v175 = phi ptr [ %v168, %b17 ], [ %v173, %b18 ]
  %v176 = getelementptr i64, ptr %s15, i64 0
  %v177.p = getelementptr i64, ptr %v175, i64 0
  %v177 = load i64, ptr %v177.p
  %st75 = getelementptr i64, ptr %v176, i64 0
  store i64 %v177, ptr %st75
  %v178.p = getelementptr i64, ptr %v175, i64 1
  %v178 = load i64, ptr %v178.p
  %st76 = getelementptr i64, ptr %v176, i64 1
  store i64 %v178, ptr %st76
  %v179.p = getelementptr i64, ptr %v175, i64 2
  %v179 = load i64, ptr %v179.p
  %st77 = getelementptr i64, ptr %v176, i64 2
  store i64 %v179, ptr %st77
  %v180 = getelementptr i64, ptr %s14, i64 0
  %v181.p = getelementptr i64, ptr %v10, i64 0
  %v181 = load i64, ptr %v181.p
  %st78 = getelementptr i64, ptr %v180, i64 0
  store i64 %v181, ptr %st78
  %v182.p = getelementptr i64, ptr %v10, i64 1
  %v182 = load i64, ptr %v182.p
  %st79 = getelementptr i64, ptr %v180, i64 1
  store i64 %v182, ptr %st79
  %v183.p = getelementptr i64, ptr %v10, i64 2
  %v183 = load i64, ptr %v183.p
  %st80 = getelementptr i64, ptr %v180, i64 2
  store i64 %v183, ptr %st80
  %v184 = getelementptr i64, ptr %s13, i64 0
  %v185.p = getelementptr i64, ptr %v120, i64 0
  %v185 = load i64, ptr %v185.p
  %st81 = getelementptr i64, ptr %v184, i64 0
  store i64 %v185, ptr %st81
  %v186.p = getelementptr i64, ptr %v120, i64 1
  %v186 = load i64, ptr %v186.p
  %st82 = getelementptr i64, ptr %v184, i64 1
  store i64 %v186, ptr %st82
  %v187.p = getelementptr i64, ptr %v120, i64 2
  %v187 = load i64, ptr %v187.p
  %st83 = getelementptr i64, ptr %v184, i64 2
  store i64 %v187, ptr %st83
  %v188 = getelementptr i64, ptr %s8, i64 0
  %v189.p = getelementptr i64, ptr %v176, i64 0
  %v189 = load i64, ptr %v189.p
  %st84 = getelementptr i64, ptr %v188, i64 0
  store i64 %v189, ptr %st84
  %v190.p = getelementptr i64, ptr %v176, i64 1
  %v190 = load i64, ptr %v190.p
  %st85 = getelementptr i64, ptr %v188, i64 1
  store i64 %v190, ptr %st85
  %v191.p = getelementptr i64, ptr %v176, i64 2
  %v191 = load i64, ptr %v191.p
  %st86 = getelementptr i64, ptr %v188, i64 2
  store i64 %v191, ptr %st86
  %v192.p = getelementptr i64, ptr %v56, i64 1
  %v192 = load i64, ptr %v192.p
  %v193.p = getelementptr i64, ptr %v56, i64 1
  %v193 = load i64, ptr %v193.p
  %v194.c = icmp eq i64 %v193, %v96
  %v194 = zext i1 %v194.c to i64
  %v195 = getelementptr i64, ptr @"str.29", i64 0
  %v196 = add i64 0, 2
  %v197 = add i64 0, 0
  %v198 = getelementptr i64, ptr %s9, i64 0
  %v199 = ptrtoint ptr %v195 to i64
  %st87 = getelementptr i64, ptr %v198, i64 0
  store i64 %v199, ptr %st87
  %st88 = getelementptr i64, ptr %v198, i64 1
  store i64 %v196, ptr %st88
  %st89 = getelementptr i64, ptr %v198, i64 2
  store i64 %v197, ptr %st89
  %v200.p = getelementptr i64, ptr %v180, i64 1
  %v200 = load i64, ptr %v200.p
  %v201.p = getelementptr i64, ptr %v198, i64 1
  %v201 = load i64, ptr %v201.p
  %v202 = add i64 %v200, %v201
  %v338 = getelementptr i64, ptr @"rt.meta", i64 0
  %v203.p = getelementptr i64, ptr %v338, i64 0
  %v203 = load i64, ptr %v203.p
  %v204.p = getelementptr i64, ptr %v180, i64 0
  %v204 = load i64, ptr %v204.p
  %v205.p = getelementptr i64, ptr %v180, i64 1
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v180, i64 2
  %v206 = load i64, ptr %v206.p
  %v207 = call ptr @"rt.cat8"(i64 %v204, i64 %v205, i64 %v206, i64 %v203, i64 %v201)
  %v208 = getelementptr i8, ptr %v207, i64 %v200
  %v209.p = getelementptr i64, ptr %v198, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = inttoptr i64 %v209 to ptr
  call void @"rt.copy8"(ptr %v208, ptr %v210, i64 %v201)
  %v211 = getelementptr i64, ptr %s16, i64 0
  %v212 = ptrtoint ptr %v207 to i64
  %st90 = getelementptr i64, ptr %v211, i64 0
  store i64 %v212, ptr %st90
  %st91 = getelementptr i64, ptr %v211, i64 1
  store i64 %v202, ptr %st91
  %st92 = getelementptr i64, ptr %v211, i64 2
  store i64 %v203, ptr %st92
  %v213.p = getelementptr i64, ptr %v211, i64 1
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v184, i64 1
  %v214 = load i64, ptr %v214.p
  %v215 = add i64 %v213, %v214
  %v339 = getelementptr i64, ptr @"rt.meta", i64 0
  %v216.p = getelementptr i64, ptr %v339, i64 0
  %v216 = load i64, ptr %v216.p
  %v217.p = getelementptr i64, ptr %v211, i64 0
  %v217 = load i64, ptr %v217.p
  %v218.p = getelementptr i64, ptr %v211, i64 1
  %v218 = load i64, ptr %v218.p
  %v219.p = getelementptr i64, ptr %v211, i64 2
  %v219 = load i64, ptr %v219.p
  %v220 = call ptr @"rt.cat8"(i64 %v217, i64 %v218, i64 %v219, i64 %v216, i64 %v214)
  %v221 = getelementptr i8, ptr %v220, i64 %v213
  %v222.p = getelementptr i64, ptr %v184, i64 0
  %v222 = load i64, ptr %v222.p
  %v223 = inttoptr i64 %v222 to ptr
  call void @"rt.copy8"(ptr %v221, ptr %v223, i64 %v214)
  %v224 = getelementptr i64, ptr %s17, i64 0
  %v225 = ptrtoint ptr %v220 to i64
  %st93 = getelementptr i64, ptr %v224, i64 0
  store i64 %v225, ptr %st93
  %st94 = getelementptr i64, ptr %v224, i64 1
  store i64 %v215, ptr %st94
  %st95 = getelementptr i64, ptr %v224, i64 2
  store i64 %v216, ptr %st95
  %v226.p = getelementptr i64, ptr %v224, i64 1
  %v226 = load i64, ptr %v226.p
  %v227.p = getelementptr i64, ptr %v188, i64 1
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 %v226, %v227
  %v340 = getelementptr i64, ptr @"rt.meta", i64 0
  %v229.p = getelementptr i64, ptr %v340, i64 0
  %v229 = load i64, ptr %v229.p
  %v230.p = getelementptr i64, ptr %v224, i64 0
  %v230 = load i64, ptr %v230.p
  %v231.p = getelementptr i64, ptr %v224, i64 1
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v224, i64 2
  %v232 = load i64, ptr %v232.p
  %v233 = call ptr @"rt.cat8"(i64 %v230, i64 %v231, i64 %v232, i64 %v229, i64 %v227)
  %v234 = getelementptr i8, ptr %v233, i64 %v226
  %v235.p = getelementptr i64, ptr %v188, i64 0
  %v235 = load i64, ptr %v235.p
  %v236 = inttoptr i64 %v235 to ptr
  call void @"rt.copy8"(ptr %v234, ptr %v236, i64 %v227)
  %v237 = getelementptr i64, ptr %s18, i64 0
  %v238 = ptrtoint ptr %v233 to i64
  %st96 = getelementptr i64, ptr %v237, i64 0
  store i64 %v238, ptr %st96
  %st97 = getelementptr i64, ptr %v237, i64 1
  store i64 %v228, ptr %st97
  %st98 = getelementptr i64, ptr %v237, i64 2
  store i64 %v229, ptr %st98
  %v239 = getelementptr i64, ptr @"str.30", i64 0
  %v240 = add i64 0, 9
  %v241 = add i64 0, 0
  %v242 = getelementptr i64, ptr %s19, i64 0
  %v243 = ptrtoint ptr %v239 to i64
  %st99 = getelementptr i64, ptr %v242, i64 0
  store i64 %v243, ptr %st99
  %st100 = getelementptr i64, ptr %v242, i64 1
  store i64 %v240, ptr %st100
  %st101 = getelementptr i64, ptr %v242, i64 2
  store i64 %v241, ptr %st101
  %v244.p = getelementptr i64, ptr %v237, i64 1
  %v244 = load i64, ptr %v244.p
  %v245.p = getelementptr i64, ptr %v242, i64 1
  %v245 = load i64, ptr %v245.p
  %v246 = add i64 %v244, %v245
  %v341 = getelementptr i64, ptr @"rt.meta", i64 0
  %v247.p = getelementptr i64, ptr %v341, i64 0
  %v247 = load i64, ptr %v247.p
  %v248.p = getelementptr i64, ptr %v237, i64 0
  %v248 = load i64, ptr %v248.p
  %v249.p = getelementptr i64, ptr %v237, i64 1
  %v249 = load i64, ptr %v249.p
  %v250.p = getelementptr i64, ptr %v237, i64 2
  %v250 = load i64, ptr %v250.p
  %v251 = call ptr @"rt.cat8"(i64 %v248, i64 %v249, i64 %v250, i64 %v247, i64 %v245)
  %v252 = getelementptr i8, ptr %v251, i64 %v244
  %v253.p = getelementptr i64, ptr %v242, i64 0
  %v253 = load i64, ptr %v253.p
  %v254 = inttoptr i64 %v253 to ptr
  call void @"rt.copy8"(ptr %v252, ptr %v254, i64 %v245)
  %v255 = getelementptr i64, ptr %s20, i64 0
  %v256 = ptrtoint ptr %v251 to i64
  %st102 = getelementptr i64, ptr %v255, i64 0
  store i64 %v256, ptr %st102
  %st103 = getelementptr i64, ptr %v255, i64 1
  store i64 %v246, ptr %st103
  %st104 = getelementptr i64, ptr %v255, i64 2
  store i64 %v247, ptr %st104
  %v257 = getelementptr i64, ptr %s21, i64 0
  call void @"std/convert.FormatInt"(ptr %v257, i64 %v192)
  %v258.p = getelementptr i64, ptr %v255, i64 1
  %v258 = load i64, ptr %v258.p
  %v259.p = getelementptr i64, ptr %v257, i64 1
  %v259 = load i64, ptr %v259.p
  %v260 = add i64 %v258, %v259
  %v342 = getelementptr i64, ptr @"rt.meta", i64 0
  %v261.p = getelementptr i64, ptr %v342, i64 0
  %v261 = load i64, ptr %v261.p
  %v262.p = getelementptr i64, ptr %v255, i64 0
  %v262 = load i64, ptr %v262.p
  %v263.p = getelementptr i64, ptr %v255, i64 1
  %v263 = load i64, ptr %v263.p
  %v264.p = getelementptr i64, ptr %v255, i64 2
  %v264 = load i64, ptr %v264.p
  %v265 = call ptr @"rt.cat8"(i64 %v262, i64 %v263, i64 %v264, i64 %v261, i64 %v259)
  %v266 = getelementptr i8, ptr %v265, i64 %v258
  %v267.p = getelementptr i64, ptr %v257, i64 0
  %v267 = load i64, ptr %v267.p
  %v268 = inttoptr i64 %v267 to ptr
  call void @"rt.copy8"(ptr %v266, ptr %v268, i64 %v259)
  %v269 = getelementptr i64, ptr %s22, i64 0
  %v270 = ptrtoint ptr %v265 to i64
  %st105 = getelementptr i64, ptr %v269, i64 0
  store i64 %v270, ptr %st105
  %st106 = getelementptr i64, ptr %v269, i64 1
  store i64 %v260, ptr %st106
  %st107 = getelementptr i64, ptr %v269, i64 2
  store i64 %v261, ptr %st107
  %v271 = getelementptr i64, ptr @"str.31", i64 0
  %v272 = add i64 0, 12
  %v273 = add i64 0, 0
  %v274 = getelementptr i64, ptr %s23, i64 0
  %v275 = ptrtoint ptr %v271 to i64
  %st108 = getelementptr i64, ptr %v274, i64 0
  store i64 %v275, ptr %st108
  %st109 = getelementptr i64, ptr %v274, i64 1
  store i64 %v272, ptr %st109
  %st110 = getelementptr i64, ptr %v274, i64 2
  store i64 %v273, ptr %st110
  %v276.p = getelementptr i64, ptr %v269, i64 1
  %v276 = load i64, ptr %v276.p
  %v277.p = getelementptr i64, ptr %v274, i64 1
  %v277 = load i64, ptr %v277.p
  %v278 = add i64 %v276, %v277
  %v343 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279.p = getelementptr i64, ptr %v343, i64 0
  %v279 = load i64, ptr %v279.p
  %v280.p = getelementptr i64, ptr %v269, i64 0
  %v280 = load i64, ptr %v280.p
  %v281.p = getelementptr i64, ptr %v269, i64 1
  %v281 = load i64, ptr %v281.p
  %v282.p = getelementptr i64, ptr %v269, i64 2
  %v282 = load i64, ptr %v282.p
  %v283 = call ptr @"rt.cat8"(i64 %v280, i64 %v281, i64 %v282, i64 %v279, i64 %v277)
  %v284 = getelementptr i8, ptr %v283, i64 %v276
  %v285.p = getelementptr i64, ptr %v274, i64 0
  %v285 = load i64, ptr %v285.p
  %v286 = inttoptr i64 %v285 to ptr
  call void @"rt.copy8"(ptr %v284, ptr %v286, i64 %v277)
  %v287 = getelementptr i64, ptr %s24, i64 0
  %v288 = ptrtoint ptr %v283 to i64
  %st111 = getelementptr i64, ptr %v287, i64 0
  store i64 %v288, ptr %st111
  %st112 = getelementptr i64, ptr %v287, i64 1
  store i64 %v278, ptr %st112
  %st113 = getelementptr i64, ptr %v287, i64 2
  store i64 %v279, ptr %st113
  %c.b19 = icmp ne i64 %v194, 0
  br i1 %c.b19, label %b19.t115, label %b19.e116
b19.t115:
  br label %b20
b19.e116:
  br label %b21
b20:
  %v289 = getelementptr i64, ptr @"str.32", i64 0
  %v290 = add i64 0, 4
  %v291 = add i64 0, 0
  %v292 = getelementptr i64, ptr %s25, i64 0
  %v293 = ptrtoint ptr %v289 to i64
  %st116 = getelementptr i64, ptr %v292, i64 0
  store i64 %v293, ptr %st116
  %st117 = getelementptr i64, ptr %v292, i64 1
  store i64 %v290, ptr %st117
  %st118 = getelementptr i64, ptr %v292, i64 2
  store i64 %v291, ptr %st118
  br label %b22
b21:
  %v294 = getelementptr i64, ptr @"str.33", i64 0
  %v295 = add i64 0, 5
  %v296 = add i64 0, 0
  %v297 = getelementptr i64, ptr %s26, i64 0
  %v298 = ptrtoint ptr %v294 to i64
  %st119 = getelementptr i64, ptr %v297, i64 0
  store i64 %v298, ptr %st119
  %st120 = getelementptr i64, ptr %v297, i64 1
  store i64 %v295, ptr %st120
  %st121 = getelementptr i64, ptr %v297, i64 2
  store i64 %v296, ptr %st121
  br label %b22
b22:
  %v299 = phi ptr [ %v292, %b20 ], [ %v297, %b21 ]
  %v300.p = getelementptr i64, ptr %v287, i64 1
  %v300 = load i64, ptr %v300.p
  %v301.p = getelementptr i64, ptr %v299, i64 1
  %v301 = load i64, ptr %v301.p
  %v302 = add i64 %v300, %v301
  %v344 = getelementptr i64, ptr @"rt.meta", i64 0
  %v303.p = getelementptr i64, ptr %v344, i64 0
  %v303 = load i64, ptr %v303.p
  %v304.p = getelementptr i64, ptr %v287, i64 0
  %v304 = load i64, ptr %v304.p
  %v305.p = getelementptr i64, ptr %v287, i64 1
  %v305 = load i64, ptr %v305.p
  %v306.p = getelementptr i64, ptr %v287, i64 2
  %v306 = load i64, ptr %v306.p
  %v307 = call ptr @"rt.cat8"(i64 %v304, i64 %v305, i64 %v306, i64 %v303, i64 %v301)
  %v308 = getelementptr i8, ptr %v307, i64 %v300
  %v309.p = getelementptr i64, ptr %v299, i64 0
  %v309 = load i64, ptr %v309.p
  %v310 = inttoptr i64 %v309 to ptr
  call void @"rt.copy8"(ptr %v308, ptr %v310, i64 %v301)
  %v311 = getelementptr i64, ptr %s27, i64 0
  %v312 = ptrtoint ptr %v307 to i64
  %st122 = getelementptr i64, ptr %v311, i64 0
  store i64 %v312, ptr %st122
  %st123 = getelementptr i64, ptr %v311, i64 1
  store i64 %v302, ptr %st123
  %st124 = getelementptr i64, ptr %v311, i64 2
  store i64 %v303, ptr %st124
  call void @"rt.print_str"(ptr %v311)
  %v313 = add i64 0, 10
  call void @"rt.print_char"(i64 %v313)
  %v314 = getelementptr i64, ptr %s28, i64 0
  %v315 = add i64 0, 0
  %st125 = getelementptr i64, ptr %v314, i64 0
  store i64 %v315, ptr %st125
  %v316.p = getelementptr i64, ptr %v314, i64 0
  %v316 = load i64, ptr %v316.p
  %st126 = getelementptr i64, ptr %v0, i64 0
  store i64 %v316, ptr %st126
  %v317.p = getelementptr i64, ptr %v314, i64 1
  %v317 = load i64, ptr %v317.p
  %st127 = getelementptr i64, ptr %v0, i64 1
  store i64 %v317, ptr %st127
  %v318.p = getelementptr i64, ptr %v314, i64 2
  %v318 = load i64, ptr %v318.p
  %st128 = getelementptr i64, ptr %v0, i64 2
  store i64 %v318, ptr %st128
  %v319.p = getelementptr i64, ptr %v314, i64 3
  %v319 = load i64, ptr %v319.p
  %st129 = getelementptr i64, ptr %v0, i64 3
  store i64 %v319, ptr %st129
  %v320.p = getelementptr i64, ptr %v314, i64 4
  %v320 = load i64, ptr %v320.p
  %st130 = getelementptr i64, ptr %v0, i64 4
  store i64 %v320, ptr %st130
  %v321.p = getelementptr i64, ptr %v314, i64 5
  %v321 = load i64, ptr %v321.p
  %st131 = getelementptr i64, ptr %v0, i64 5
  store i64 %v321, ptr %st131
  %v322.p = getelementptr i64, ptr %v34, i64 0
  %v322 = load i64, ptr %v322.p
  call void @"std/io.Close"(i64 %v322)
  %v323.p = getelementptr i64, ptr %v0, i64 0
  %v323 = load i64, ptr %v323.p
  %v324 = add i64 0, 0
  %v325.c = icmp ne i64 %v323, %v324
  %v325 = zext i1 %v325.c to i64
  %c.b22 = icmp ne i64 %v325, 0
  br i1 %c.b22, label %b22.t133, label %b22.e134
b22.t133:
  br label %b23
b22.e134:
  br label %b24
b23:
  %v326 = add i64 0, 3
  %v327 = getelementptr i64, ptr %v0, i64 %v326
  %v345 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v327, i64 %v345, i64 %v11)
  br label %b24
b24:
  %v346 = getelementptr i64, ptr @"rt.meta", i64 0
  %st134 = getelementptr i64, ptr %v346, i64 0
  store i64 %v11, ptr %st134
  ret void
}

define internal void @"std/io.CloseRoot"(i64 %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v1 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v0, ptr %st0
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v5, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3.p = getelementptr i64, ptr %v1, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = call i64 @"rt.close"(i64 %v3)
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v6, i64 0
  store i64 %v2, ptr %st1
  ret void
}

define internal i64 @"rt.open"(ptr %v0) #0 {
b0:
  %v1 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v2 = call i64 @"rt.cstr"(ptr %v0, ptr %v1)
  %v3 = add i64 0, 0
  %v4.c = icmp ne i64 %v2, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v5, i64 1027
  store i64 %v2, ptr %st2
  %v6 = add i64 0, 0
  %v7 = sub i64 %v6, %v2
  ret i64 %v7
b2:
  %v8 = add i64 0, 257
  %v9 = add i64 0, -100
  %v10 = ptrtoint ptr %v1 to i64
  %v11 = add i64 0, 524288
  %v12 = add i64 0, 0
  %v13 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12)
  %v14 = add i64 0, 0
  %v15.c = icmp slt i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b2 = icmp ne i64 %v15, 0
  br i1 %c.b2, label %b2.t4, label %b2.e5
b2.t4:
  br label %b3
b2.e5:
  br label %b4
b3:
  %v16 = add i64 0, 0
  %v17 = sub i64 %v16, %v13
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v18, i64 1027
  store i64 %v17, ptr %st5
  ret i64 %v13
b4:
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v20, i64 1027
  store i64 %v19, ptr %st6
  ret i64 %v13
}

define internal i64 @"rt.close"(i64 %v0) #0 {
b0:
  %v1 = add i64 0, 3
  %v2 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v1, i64 %v0)
  %v3 = add i64 0, 0
  %v4.c = icmp slt i64 %v2, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = add i64 0, 0
  %v6 = sub i64 %v5, %v2
  %v7 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v7, i64 1027
  store i64 %v6, ptr %st2
  ret i64 %v6
b2:
  %v8 = add i64 0, 0
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v9, i64 1027
  store i64 %v8, ptr %st3
  ret i64 %v8
}

define internal void @"std/io.OpenUnder"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s5 = alloca [2 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
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
  %s12 = alloca [5 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s12.z3 = getelementptr i64, ptr %s12, i64 3
  store i64 0, ptr %s12.z3
  %s12.z4 = getelementptr i64, ptr %s12, i64 4
  store i64 0, ptr %s12.z4
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
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v271, i64 0
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
  %v11 = add i64 0, 1
  %v12 = add i64 0, 0
  %v13 = sub i64 %v12, %v11
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15 = add i64 0, 0
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17 = getelementptr i64, ptr %s4, i64 0
  %v18 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st6
  %st7 = getelementptr i64, ptr %v17, i64 0
  store i64 %v13, ptr %st7
  %v19 = getelementptr i64, ptr %s5, i64 0
  %v20 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st8
  %st9 = getelementptr i64, ptr %v19, i64 1
  store i64 %v20, ptr %st9
  %v21 = add i64 0, 3
  %st10 = getelementptr i64, ptr %v19, i64 0
  store i64 %v21, ptr %st10
  %v22 = getelementptr i64, ptr %s6, i64 0
  %v23.p = getelementptr i64, ptr %v19, i64 0
  %v23 = load i64, ptr %v23.p
  %st11 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st11
  %v24.p = getelementptr i64, ptr %v19, i64 1
  %v24 = load i64, ptr %v24.p
  %st12 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st12
  %v25 = add i64 0, 0
  %st13 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st13
  %st14 = getelementptr i64, ptr %v22, i64 3
  store i64 %v25, ptr %st14
  %st15 = getelementptr i64, ptr %v22, i64 4
  store i64 %v25, ptr %st15
  %v26 = getelementptr i64, ptr %s7, i64 0
  %v27 = add i64 0, 1
  %st16 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st16
  %v28.p = getelementptr i64, ptr %v22, i64 0
  %v28 = load i64, ptr %v28.p
  %st17 = getelementptr i64, ptr %v26, i64 1
  store i64 %v28, ptr %st17
  %v29.p = getelementptr i64, ptr %v22, i64 1
  %v29 = load i64, ptr %v29.p
  %st18 = getelementptr i64, ptr %v26, i64 2
  store i64 %v29, ptr %st18
  %v30.p = getelementptr i64, ptr %v22, i64 2
  %v30 = load i64, ptr %v30.p
  %st19 = getelementptr i64, ptr %v26, i64 3
  store i64 %v30, ptr %st19
  %v31.p = getelementptr i64, ptr %v22, i64 3
  %v31 = load i64, ptr %v31.p
  %st20 = getelementptr i64, ptr %v26, i64 4
  store i64 %v31, ptr %st20
  %v32.p = getelementptr i64, ptr %v22, i64 4
  %v32 = load i64, ptr %v32.p
  %st21 = getelementptr i64, ptr %v26, i64 5
  store i64 %v32, ptr %st21
  %v33.p = getelementptr i64, ptr %v17, i64 0
  %v33 = load i64, ptr %v33.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v33, ptr %st22
  %v34.p = getelementptr i64, ptr %v26, i64 0
  %v34 = load i64, ptr %v34.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v34, ptr %st23
  %v35.p = getelementptr i64, ptr %v26, i64 1
  %v35 = load i64, ptr %v35.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v35, ptr %st24
  %v36.p = getelementptr i64, ptr %v26, i64 2
  %v36 = load i64, ptr %v36.p
  %st25 = getelementptr i64, ptr %v0, i64 3
  store i64 %v36, ptr %st25
  %v37.p = getelementptr i64, ptr %v26, i64 3
  %v37 = load i64, ptr %v37.p
  %st26 = getelementptr i64, ptr %v0, i64 4
  store i64 %v37, ptr %st26
  %v38.p = getelementptr i64, ptr %v26, i64 4
  %v38 = load i64, ptr %v38.p
  %st27 = getelementptr i64, ptr %v0, i64 5
  store i64 %v38, ptr %st27
  %v39.p = getelementptr i64, ptr %v26, i64 5
  %v39 = load i64, ptr %v39.p
  %st28 = getelementptr i64, ptr %v0, i64 6
  store i64 %v39, ptr %st28
  %v40.p = getelementptr i64, ptr %v0, i64 1
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 0
  %v42.c = icmp ne i64 %v40, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b1 = icmp ne i64 %v42, 0
  br i1 %c.b1, label %b1.t30, label %b1.e31
b1.t30:
  br label %b3
b1.e31:
  br label %b4
b2:
  br label %b5
b3:
  %v43 = add i64 0, 4
  %v44 = getelementptr i64, ptr %v0, i64 %v43
  %v272 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v44, i64 %v272, i64 %v7)
  br label %b4
b4:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v273, i64 0
  store i64 %v7, ptr %st31
  ret void
b5:
  %v45 = getelementptr i64, ptr %s8, i64 0
  %v46.p = getelementptr i64, ptr %v6, i64 0
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v6, i64 1
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v6, i64 2
  %v48 = load i64, ptr %v48.p
  call void @"std/io.cstr"(ptr %v45, i64 %v46, i64 %v47, i64 %v48)
  %v49 = getelementptr i64, ptr %s9, i64 0
  %v50.p = getelementptr i64, ptr %v45, i64 0
  %v50 = load i64, ptr %v50.p
  %st32 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st32
  %v51.p = getelementptr i64, ptr %v45, i64 1
  %v51 = load i64, ptr %v51.p
  %st33 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st33
  %v52.p = getelementptr i64, ptr %v45, i64 2
  %v52 = load i64, ptr %v52.p
  %st34 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st34
  %v53.p = getelementptr i64, ptr %v49, i64 1
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 0
  %v55.c = icmp eq i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b5 = icmp ne i64 %v55, 0
  br i1 %c.b5, label %b5.t36, label %b5.e37
b5.t36:
  br label %b6
b5.e37:
  br label %b7
b6:
  %v56 = add i64 0, 1
  %v57 = add i64 0, 0
  %v58 = sub i64 %v57, %v56
  %v59 = getelementptr i64, ptr %s4, i64 0
  %v60 = add i64 0, 0
  %v61 = getelementptr i64, ptr %s3, i64 0
  %v62 = getelementptr i64, ptr %s2, i64 0
  %v63 = add i64 0, 0
  %st37 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st37
  %st38 = getelementptr i64, ptr %v62, i64 0
  store i64 %v58, ptr %st38
  %v64 = add i64 0, 22
  %v65 = getelementptr i64, ptr %s5, i64 0
  %v66 = add i64 0, 0
  %st39 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st39
  %st40 = getelementptr i64, ptr %v65, i64 1
  store i64 %v66, ptr %st40
  %v67 = add i64 0, 5
  %st41 = getelementptr i64, ptr %v65, i64 0
  store i64 %v67, ptr %st41
  %st42 = getelementptr i64, ptr %v65, i64 1
  store i64 %v64, ptr %st42
  %v68 = getelementptr i64, ptr %s6, i64 0
  %v69.p = getelementptr i64, ptr %v65, i64 0
  %v69 = load i64, ptr %v69.p
  %st43 = getelementptr i64, ptr %v68, i64 0
  store i64 %v69, ptr %st43
  %v70.p = getelementptr i64, ptr %v65, i64 1
  %v70 = load i64, ptr %v70.p
  %st44 = getelementptr i64, ptr %v68, i64 1
  store i64 %v70, ptr %st44
  %v71 = add i64 0, 0
  %st45 = getelementptr i64, ptr %v68, i64 2
  store i64 %v71, ptr %st45
  %st46 = getelementptr i64, ptr %v68, i64 3
  store i64 %v71, ptr %st46
  %st47 = getelementptr i64, ptr %v68, i64 4
  store i64 %v71, ptr %st47
  %v72 = getelementptr i64, ptr %s7, i64 0
  %v73 = add i64 0, 1
  %st48 = getelementptr i64, ptr %v72, i64 0
  store i64 %v73, ptr %st48
  %v74.p = getelementptr i64, ptr %v68, i64 0
  %v74 = load i64, ptr %v74.p
  %st49 = getelementptr i64, ptr %v72, i64 1
  store i64 %v74, ptr %st49
  %v75.p = getelementptr i64, ptr %v68, i64 1
  %v75 = load i64, ptr %v75.p
  %st50 = getelementptr i64, ptr %v72, i64 2
  store i64 %v75, ptr %st50
  %v76.p = getelementptr i64, ptr %v68, i64 2
  %v76 = load i64, ptr %v76.p
  %st51 = getelementptr i64, ptr %v72, i64 3
  store i64 %v76, ptr %st51
  %v77.p = getelementptr i64, ptr %v68, i64 3
  %v77 = load i64, ptr %v77.p
  %st52 = getelementptr i64, ptr %v72, i64 4
  store i64 %v77, ptr %st52
  %v78.p = getelementptr i64, ptr %v68, i64 4
  %v78 = load i64, ptr %v78.p
  %st53 = getelementptr i64, ptr %v72, i64 5
  store i64 %v78, ptr %st53
  %v79.p = getelementptr i64, ptr %v62, i64 0
  %v79 = load i64, ptr %v79.p
  %st54 = getelementptr i64, ptr %v0, i64 0
  store i64 %v79, ptr %st54
  %v80.p = getelementptr i64, ptr %v72, i64 0
  %v80 = load i64, ptr %v80.p
  %st55 = getelementptr i64, ptr %v0, i64 1
  store i64 %v80, ptr %st55
  %v81.p = getelementptr i64, ptr %v72, i64 1
  %v81 = load i64, ptr %v81.p
  %st56 = getelementptr i64, ptr %v0, i64 2
  store i64 %v81, ptr %st56
  %v82.p = getelementptr i64, ptr %v72, i64 2
  %v82 = load i64, ptr %v82.p
  %st57 = getelementptr i64, ptr %v0, i64 3
  store i64 %v82, ptr %st57
  %v83.p = getelementptr i64, ptr %v72, i64 3
  %v83 = load i64, ptr %v83.p
  %st58 = getelementptr i64, ptr %v0, i64 4
  store i64 %v83, ptr %st58
  %v84.p = getelementptr i64, ptr %v72, i64 4
  %v84 = load i64, ptr %v84.p
  %st59 = getelementptr i64, ptr %v0, i64 5
  store i64 %v84, ptr %st59
  %v85.p = getelementptr i64, ptr %v72, i64 5
  %v85 = load i64, ptr %v85.p
  %st60 = getelementptr i64, ptr %v0, i64 6
  store i64 %v85, ptr %st60
  %v86.p = getelementptr i64, ptr %v0, i64 1
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 0, 0
  %v88.c = icmp ne i64 %v86, %v87
  %v88 = zext i1 %v88.c to i64
  %c.b6 = icmp ne i64 %v88, 0
  br i1 %c.b6, label %b6.t62, label %b6.e63
b6.t62:
  br label %b8
b6.e63:
  br label %b9
b7:
  br label %b10
b8:
  %v89 = add i64 0, 4
  %v90 = getelementptr i64, ptr %v0, i64 %v89
  %v274 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v90, i64 %v274, i64 %v7)
  br label %b9
b9:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v275, i64 0
  store i64 %v7, ptr %st63
  ret void
b10:
  %v91 = add i64 0, 0
  %v92 = add i64 0, 8
  %v93 = add i64 0, 8
  %v94 = add i64 0, 0
  %v95 = add i64 0, 0
  %v96 = add i64 0, 0
  %v97 = add i64 0, 0
  %v98 = add i64 0, 0
  %v99 = add i64 0, 0
  %v100 = add i64 0, 0
  %v101 = add i64 0, 0
  %v102 = add i64 0, 0
  %v103 = add i64 0, 0
  %v104 = add i64 0, 0
  %v105 = add i64 0, 0
  %v106 = add i64 0, 0
  %v107 = add i64 0, 10
  %v108 = add i64 0, 0
  %v109 = add i64 0, 0
  %v110 = add i64 0, 0
  %v111 = add i64 0, 0
  %v112 = add i64 0, 0
  %v113 = add i64 0, 0
  %v114 = add i64 0, 0
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %v115.p = getelementptr i64, ptr %v276, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 24
  %v117 = call ptr @"rt.region_alloc8"(i64 %v115, i64 %v116)
  %v118 = add i64 0, 0
  %v119 = getelementptr i8, ptr %v117, i64 %v118
  %st64 = getelementptr i8, ptr %v119, i64 0
  %st64.b = trunc i64 %v91 to i8
  store i8 %st64.b, ptr %st64
  %v120 = add i64 0, 1
  %v121 = getelementptr i8, ptr %v117, i64 %v120
  %st65 = getelementptr i8, ptr %v121, i64 0
  %st65.b = trunc i64 %v92 to i8
  store i8 %st65.b, ptr %st65
  %v122 = add i64 0, 2
  %v123 = getelementptr i8, ptr %v117, i64 %v122
  %st66 = getelementptr i8, ptr %v123, i64 0
  %st66.b = trunc i64 %v93 to i8
  store i8 %st66.b, ptr %st66
  %v124 = add i64 0, 3
  %v125 = getelementptr i8, ptr %v117, i64 %v124
  %st67 = getelementptr i8, ptr %v125, i64 0
  %st67.b = trunc i64 %v94 to i8
  store i8 %st67.b, ptr %st67
  %v126 = add i64 0, 4
  %v127 = getelementptr i8, ptr %v117, i64 %v126
  %st68 = getelementptr i8, ptr %v127, i64 0
  %st68.b = trunc i64 %v95 to i8
  store i8 %st68.b, ptr %st68
  %v128 = add i64 0, 5
  %v129 = getelementptr i8, ptr %v117, i64 %v128
  %st69 = getelementptr i8, ptr %v129, i64 0
  %st69.b = trunc i64 %v96 to i8
  store i8 %st69.b, ptr %st69
  %v130 = add i64 0, 6
  %v131 = getelementptr i8, ptr %v117, i64 %v130
  %st70 = getelementptr i8, ptr %v131, i64 0
  %st70.b = trunc i64 %v97 to i8
  store i8 %st70.b, ptr %st70
  %v132 = add i64 0, 7
  %v133 = getelementptr i8, ptr %v117, i64 %v132
  %st71 = getelementptr i8, ptr %v133, i64 0
  %st71.b = trunc i64 %v98 to i8
  store i8 %st71.b, ptr %st71
  %v134 = add i64 0, 8
  %v135 = getelementptr i8, ptr %v117, i64 %v134
  %st72 = getelementptr i8, ptr %v135, i64 0
  %st72.b = trunc i64 %v99 to i8
  store i8 %st72.b, ptr %st72
  %v136 = add i64 0, 9
  %v137 = getelementptr i8, ptr %v117, i64 %v136
  %st73 = getelementptr i8, ptr %v137, i64 0
  %st73.b = trunc i64 %v100 to i8
  store i8 %st73.b, ptr %st73
  %v138 = add i64 0, 10
  %v139 = getelementptr i8, ptr %v117, i64 %v138
  %st74 = getelementptr i8, ptr %v139, i64 0
  %st74.b = trunc i64 %v101 to i8
  store i8 %st74.b, ptr %st74
  %v140 = add i64 0, 11
  %v141 = getelementptr i8, ptr %v117, i64 %v140
  %st75 = getelementptr i8, ptr %v141, i64 0
  %st75.b = trunc i64 %v102 to i8
  store i8 %st75.b, ptr %st75
  %v142 = add i64 0, 12
  %v143 = getelementptr i8, ptr %v117, i64 %v142
  %st76 = getelementptr i8, ptr %v143, i64 0
  %st76.b = trunc i64 %v103 to i8
  store i8 %st76.b, ptr %st76
  %v144 = add i64 0, 13
  %v145 = getelementptr i8, ptr %v117, i64 %v144
  %st77 = getelementptr i8, ptr %v145, i64 0
  %st77.b = trunc i64 %v104 to i8
  store i8 %st77.b, ptr %st77
  %v146 = add i64 0, 14
  %v147 = getelementptr i8, ptr %v117, i64 %v146
  %st78 = getelementptr i8, ptr %v147, i64 0
  %st78.b = trunc i64 %v105 to i8
  store i8 %st78.b, ptr %st78
  %v148 = add i64 0, 15
  %v149 = getelementptr i8, ptr %v117, i64 %v148
  %st79 = getelementptr i8, ptr %v149, i64 0
  %st79.b = trunc i64 %v106 to i8
  store i8 %st79.b, ptr %st79
  %v150 = add i64 0, 16
  %v151 = getelementptr i8, ptr %v117, i64 %v150
  %st80 = getelementptr i8, ptr %v151, i64 0
  %st80.b = trunc i64 %v107 to i8
  store i8 %st80.b, ptr %st80
  %v152 = add i64 0, 17
  %v153 = getelementptr i8, ptr %v117, i64 %v152
  %st81 = getelementptr i8, ptr %v153, i64 0
  %st81.b = trunc i64 %v108 to i8
  store i8 %st81.b, ptr %st81
  %v154 = add i64 0, 18
  %v155 = getelementptr i8, ptr %v117, i64 %v154
  %st82 = getelementptr i8, ptr %v155, i64 0
  %st82.b = trunc i64 %v109 to i8
  store i8 %st82.b, ptr %st82
  %v156 = add i64 0, 19
  %v157 = getelementptr i8, ptr %v117, i64 %v156
  %st83 = getelementptr i8, ptr %v157, i64 0
  %st83.b = trunc i64 %v110 to i8
  store i8 %st83.b, ptr %st83
  %v158 = add i64 0, 20
  %v159 = getelementptr i8, ptr %v117, i64 %v158
  %st84 = getelementptr i8, ptr %v159, i64 0
  %st84.b = trunc i64 %v111 to i8
  store i8 %st84.b, ptr %st84
  %v160 = add i64 0, 21
  %v161 = getelementptr i8, ptr %v117, i64 %v160
  %st85 = getelementptr i8, ptr %v161, i64 0
  %st85.b = trunc i64 %v112 to i8
  store i8 %st85.b, ptr %st85
  %v162 = add i64 0, 22
  %v163 = getelementptr i8, ptr %v117, i64 %v162
  %st86 = getelementptr i8, ptr %v163, i64 0
  %st86.b = trunc i64 %v113 to i8
  store i8 %st86.b, ptr %st86
  %v164 = add i64 0, 23
  %v165 = getelementptr i8, ptr %v117, i64 %v164
  %st87 = getelementptr i8, ptr %v165, i64 0
  %st87.b = trunc i64 %v114 to i8
  store i8 %st87.b, ptr %st87
  %v166 = add i64 0, 24
  %v167 = getelementptr i64, ptr %s10, i64 0
  %v168 = ptrtoint ptr %v117 to i64
  %st88 = getelementptr i64, ptr %v167, i64 0
  store i64 %v168, ptr %st88
  %st89 = getelementptr i64, ptr %v167, i64 1
  store i64 %v166, ptr %st89
  %st90 = getelementptr i64, ptr %v167, i64 2
  store i64 %v115, ptr %st90
  %v169 = getelementptr i64, ptr %s11, i64 0
  %v170.p = getelementptr i64, ptr %v167, i64 0
  %v170 = load i64, ptr %v170.p
  %st91 = getelementptr i64, ptr %v169, i64 0
  store i64 %v170, ptr %st91
  %v171.p = getelementptr i64, ptr %v167, i64 1
  %v171 = load i64, ptr %v171.p
  %st92 = getelementptr i64, ptr %v169, i64 1
  store i64 %v171, ptr %st92
  %v172.p = getelementptr i64, ptr %v167, i64 2
  %v172 = load i64, ptr %v172.p
  %st93 = getelementptr i64, ptr %v169, i64 2
  store i64 %v172, ptr %st93
  %v173 = add i64 0, 437
  %v174.p = getelementptr i64, ptr %v5, i64 0
  %v174 = load i64, ptr %v174.p
  %v175.p = getelementptr i64, ptr %v49, i64 0
  %v175 = load i64, ptr %v175.p
  %v176.p = getelementptr i64, ptr %v169, i64 0
  %v176 = load i64, ptr %v176.p
  %v177 = add i64 0, 24
  %v178 = add i64 0, 0
  %v179 = add i64 0, 0
  %v180 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v173, i64 %v174, i64 %v175, i64 %v176, i64 %v177, i64 %v178, i64 %v179)
  %v181 = call i64 @"std/io.owned"(i64 %v180)
  %v182 = add i64 0, 18
  %v183 = add i64 0, 0
  %v184 = sub i64 %v183, %v182
  %v185.c = icmp eq i64 %v181, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b10 = icmp ne i64 %v185, 0
  br i1 %c.b10, label %b10.t95, label %b10.e96
b10.t95:
  br label %b11
b10.e96:
  br label %b12
b11:
  %v186 = add i64 0, 1
  %v187 = add i64 0, 0
  %v188 = sub i64 %v187, %v186
  %v189 = getelementptr i64, ptr %s2, i64 0
  %v190 = add i64 0, 0
  %v191 = getelementptr i64, ptr %s3, i64 0
  %v192 = getelementptr i64, ptr %s4, i64 0
  %v193 = add i64 0, 0
  %st96 = getelementptr i64, ptr %v192, i64 0
  store i64 %v193, ptr %st96
  %st97 = getelementptr i64, ptr %v192, i64 0
  store i64 %v188, ptr %st97
  %v194 = getelementptr i64, ptr %s5, i64 0
  %v195 = add i64 0, 0
  %st98 = getelementptr i64, ptr %v194, i64 0
  store i64 %v195, ptr %st98
  %st99 = getelementptr i64, ptr %v194, i64 1
  store i64 %v195, ptr %st99
  %v196 = add i64 0, 1
  %st100 = getelementptr i64, ptr %v194, i64 0
  store i64 %v196, ptr %st100
  %v197 = getelementptr i64, ptr %s6, i64 0
  %v198.p = getelementptr i64, ptr %v194, i64 0
  %v198 = load i64, ptr %v198.p
  %st101 = getelementptr i64, ptr %v197, i64 0
  store i64 %v198, ptr %st101
  %v199.p = getelementptr i64, ptr %v194, i64 1
  %v199 = load i64, ptr %v199.p
  %st102 = getelementptr i64, ptr %v197, i64 1
  store i64 %v199, ptr %st102
  %v200 = add i64 0, 0
  %st103 = getelementptr i64, ptr %v197, i64 2
  store i64 %v200, ptr %st103
  %st104 = getelementptr i64, ptr %v197, i64 3
  store i64 %v200, ptr %st104
  %st105 = getelementptr i64, ptr %v197, i64 4
  store i64 %v200, ptr %st105
  %v201 = getelementptr i64, ptr %s7, i64 0
  %v202 = add i64 0, 1
  %st106 = getelementptr i64, ptr %v201, i64 0
  store i64 %v202, ptr %st106
  %v203.p = getelementptr i64, ptr %v197, i64 0
  %v203 = load i64, ptr %v203.p
  %st107 = getelementptr i64, ptr %v201, i64 1
  store i64 %v203, ptr %st107
  %v204.p = getelementptr i64, ptr %v197, i64 1
  %v204 = load i64, ptr %v204.p
  %st108 = getelementptr i64, ptr %v201, i64 2
  store i64 %v204, ptr %st108
  %v205.p = getelementptr i64, ptr %v197, i64 2
  %v205 = load i64, ptr %v205.p
  %st109 = getelementptr i64, ptr %v201, i64 3
  store i64 %v205, ptr %st109
  %v206.p = getelementptr i64, ptr %v197, i64 3
  %v206 = load i64, ptr %v206.p
  %st110 = getelementptr i64, ptr %v201, i64 4
  store i64 %v206, ptr %st110
  %v207.p = getelementptr i64, ptr %v197, i64 4
  %v207 = load i64, ptr %v207.p
  %st111 = getelementptr i64, ptr %v201, i64 5
  store i64 %v207, ptr %st111
  %v208.p = getelementptr i64, ptr %v192, i64 0
  %v208 = load i64, ptr %v208.p
  %st112 = getelementptr i64, ptr %v0, i64 0
  store i64 %v208, ptr %st112
  %v209.p = getelementptr i64, ptr %v201, i64 0
  %v209 = load i64, ptr %v209.p
  %st113 = getelementptr i64, ptr %v0, i64 1
  store i64 %v209, ptr %st113
  %v210.p = getelementptr i64, ptr %v201, i64 1
  %v210 = load i64, ptr %v210.p
  %st114 = getelementptr i64, ptr %v0, i64 2
  store i64 %v210, ptr %st114
  %v211.p = getelementptr i64, ptr %v201, i64 2
  %v211 = load i64, ptr %v211.p
  %st115 = getelementptr i64, ptr %v0, i64 3
  store i64 %v211, ptr %st115
  %v212.p = getelementptr i64, ptr %v201, i64 3
  %v212 = load i64, ptr %v212.p
  %st116 = getelementptr i64, ptr %v0, i64 4
  store i64 %v212, ptr %st116
  %v213.p = getelementptr i64, ptr %v201, i64 4
  %v213 = load i64, ptr %v213.p
  %st117 = getelementptr i64, ptr %v0, i64 5
  store i64 %v213, ptr %st117
  %v214.p = getelementptr i64, ptr %v201, i64 5
  %v214 = load i64, ptr %v214.p
  %st118 = getelementptr i64, ptr %v0, i64 6
  store i64 %v214, ptr %st118
  %v215.p = getelementptr i64, ptr %v0, i64 1
  %v215 = load i64, ptr %v215.p
  %v216 = add i64 0, 0
  %v217.c = icmp ne i64 %v215, %v216
  %v217 = zext i1 %v217.c to i64
  %c.b11 = icmp ne i64 %v217, 0
  br i1 %c.b11, label %b11.t120, label %b11.e121
b11.t120:
  br label %b13
b11.e121:
  br label %b14
b12:
  br label %b15
b13:
  %v218 = add i64 0, 4
  %v219 = getelementptr i64, ptr %v0, i64 %v218
  %v277 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v219, i64 %v277, i64 %v7)
  br label %b14
b14:
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %st121 = getelementptr i64, ptr %v278, i64 0
  store i64 %v7, ptr %st121
  ret void
b15:
  %v220 = add i64 0, 0
  %v221.c = icmp slt i64 %v181, %v220
  %v221 = zext i1 %v221.c to i64
  %c.b15 = icmp ne i64 %v221, 0
  br i1 %c.b15, label %b15.t123, label %b15.e124
b15.t123:
  br label %b16
b15.e124:
  br label %b17
b16:
  %v222 = add i64 0, 1
  %v223 = add i64 0, 0
  %v224 = sub i64 %v223, %v222
  %v225 = getelementptr i64, ptr %s4, i64 0
  %v226 = add i64 0, 0
  %v227 = getelementptr i64, ptr %s3, i64 0
  %v228 = getelementptr i64, ptr %s2, i64 0
  %v229 = add i64 0, 0
  %st124 = getelementptr i64, ptr %v228, i64 0
  store i64 %v229, ptr %st124
  %st125 = getelementptr i64, ptr %v228, i64 0
  store i64 %v224, ptr %st125
  %v230 = getelementptr i64, ptr %s12, i64 0
  %v231 = add i64 0, 0
  %v232 = sub i64 %v231, %v181
  call void @"std/io.errOf"(ptr %v230, i64 %v232)
  %v233 = getelementptr i64, ptr %s7, i64 0
  %v234 = add i64 0, 1
  %st126 = getelementptr i64, ptr %v233, i64 0
  store i64 %v234, ptr %st126
  %v235.p = getelementptr i64, ptr %v230, i64 0
  %v235 = load i64, ptr %v235.p
  %st127 = getelementptr i64, ptr %v233, i64 1
  store i64 %v235, ptr %st127
  %v236.p = getelementptr i64, ptr %v230, i64 1
  %v236 = load i64, ptr %v236.p
  %st128 = getelementptr i64, ptr %v233, i64 2
  store i64 %v236, ptr %st128
  %v237.p = getelementptr i64, ptr %v230, i64 2
  %v237 = load i64, ptr %v237.p
  %st129 = getelementptr i64, ptr %v233, i64 3
  store i64 %v237, ptr %st129
  %v238.p = getelementptr i64, ptr %v230, i64 3
  %v238 = load i64, ptr %v238.p
  %st130 = getelementptr i64, ptr %v233, i64 4
  store i64 %v238, ptr %st130
  %v239.p = getelementptr i64, ptr %v230, i64 4
  %v239 = load i64, ptr %v239.p
  %st131 = getelementptr i64, ptr %v233, i64 5
  store i64 %v239, ptr %st131
  %v240.p = getelementptr i64, ptr %v228, i64 0
  %v240 = load i64, ptr %v240.p
  %st132 = getelementptr i64, ptr %v0, i64 0
  store i64 %v240, ptr %st132
  %v241.p = getelementptr i64, ptr %v233, i64 0
  %v241 = load i64, ptr %v241.p
  %st133 = getelementptr i64, ptr %v0, i64 1
  store i64 %v241, ptr %st133
  %v242.p = getelementptr i64, ptr %v233, i64 1
  %v242 = load i64, ptr %v242.p
  %st134 = getelementptr i64, ptr %v0, i64 2
  store i64 %v242, ptr %st134
  %v243.p = getelementptr i64, ptr %v233, i64 2
  %v243 = load i64, ptr %v243.p
  %st135 = getelementptr i64, ptr %v0, i64 3
  store i64 %v243, ptr %st135
  %v244.p = getelementptr i64, ptr %v233, i64 3
  %v244 = load i64, ptr %v244.p
  %st136 = getelementptr i64, ptr %v0, i64 4
  store i64 %v244, ptr %st136
  %v245.p = getelementptr i64, ptr %v233, i64 4
  %v245 = load i64, ptr %v245.p
  %st137 = getelementptr i64, ptr %v0, i64 5
  store i64 %v245, ptr %st137
  %v246.p = getelementptr i64, ptr %v233, i64 5
  %v246 = load i64, ptr %v246.p
  %st138 = getelementptr i64, ptr %v0, i64 6
  store i64 %v246, ptr %st138
  %v247.p = getelementptr i64, ptr %v0, i64 1
  %v247 = load i64, ptr %v247.p
  %v248 = add i64 0, 0
  %v249.c = icmp ne i64 %v247, %v248
  %v249 = zext i1 %v249.c to i64
  %c.b16 = icmp ne i64 %v249, 0
  br i1 %c.b16, label %b16.t140, label %b16.e141
b16.t140:
  br label %b18
b16.e141:
  br label %b19
b17:
  br label %b20
b18:
  %v250 = add i64 0, 4
  %v251 = getelementptr i64, ptr %v0, i64 %v250
  %v279 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v251, i64 %v279, i64 %v7)
  br label %b19
b19:
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v280, i64 0
  store i64 %v7, ptr %st141
  ret void
b20:
  %v252 = getelementptr i64, ptr %s2, i64 0
  %v253 = add i64 0, 0
  %v254 = getelementptr i64, ptr %s3, i64 0
  %v255 = getelementptr i64, ptr %s4, i64 0
  %v256 = add i64 0, 0
  %st142 = getelementptr i64, ptr %v255, i64 0
  store i64 %v256, ptr %st142
  %st143 = getelementptr i64, ptr %v255, i64 0
  store i64 %v181, ptr %st143
  %v257 = getelementptr i64, ptr %s7, i64 0
  %v258 = add i64 0, 0
  %st144 = getelementptr i64, ptr %v257, i64 0
  store i64 %v258, ptr %st144
  %v259.p = getelementptr i64, ptr %v255, i64 0
  %v259 = load i64, ptr %v259.p
  %st145 = getelementptr i64, ptr %v0, i64 0
  store i64 %v259, ptr %st145
  %v260.p = getelementptr i64, ptr %v257, i64 0
  %v260 = load i64, ptr %v260.p
  %st146 = getelementptr i64, ptr %v0, i64 1
  store i64 %v260, ptr %st146
  %v261.p = getelementptr i64, ptr %v257, i64 1
  %v261 = load i64, ptr %v261.p
  %st147 = getelementptr i64, ptr %v0, i64 2
  store i64 %v261, ptr %st147
  %v262.p = getelementptr i64, ptr %v257, i64 2
  %v262 = load i64, ptr %v262.p
  %st148 = getelementptr i64, ptr %v0, i64 3
  store i64 %v262, ptr %st148
  %v263.p = getelementptr i64, ptr %v257, i64 3
  %v263 = load i64, ptr %v263.p
  %st149 = getelementptr i64, ptr %v0, i64 4
  store i64 %v263, ptr %st149
  %v264.p = getelementptr i64, ptr %v257, i64 4
  %v264 = load i64, ptr %v264.p
  %st150 = getelementptr i64, ptr %v0, i64 5
  store i64 %v264, ptr %st150
  %v265.p = getelementptr i64, ptr %v257, i64 5
  %v265 = load i64, ptr %v265.p
  %st151 = getelementptr i64, ptr %v0, i64 6
  store i64 %v265, ptr %st151
  %v266.p = getelementptr i64, ptr %v0, i64 1
  %v266 = load i64, ptr %v266.p
  %v267 = add i64 0, 0
  %v268.c = icmp ne i64 %v266, %v267
  %v268 = zext i1 %v268.c to i64
  %c.b20 = icmp ne i64 %v268, 0
  br i1 %c.b20, label %b20.t153, label %b20.e154
b20.t153:
  br label %b21
b20.e154:
  br label %b22
b21:
  %v269 = add i64 0, 4
  %v270 = getelementptr i64, ptr %v0, i64 %v269
  %v281 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v270, i64 %v281, i64 %v7)
  br label %b22
b22:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st154 = getelementptr i64, ptr %v282, i64 0
  store i64 %v7, ptr %st154
  ret void
}

define internal void @"std/io.Stat"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [4 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
  %s1.z2 = getelementptr i64, ptr %s1, i64 2
  store i64 0, ptr %s1.z2
  %s1.z3 = getelementptr i64, ptr %s1, i64 3
  store i64 0, ptr %s1.z3
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
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s10 = alloca [2 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v1, ptr %st0
  %v195 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v195, i64 0
  %v3 = load i64, ptr %v3.p
  call void @"rt.region_enter"()
  %v4 = add i64 0, 0
  %v5 = add i64 0, 0
  %v6.c = icmp ne i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b0 = icmp ne i64 %v6, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v7 = getelementptr i64, ptr %s1, i64 0
  %v8 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v8, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v8, ptr %st5
  %st6 = getelementptr i64, ptr %v7, i64 3
  store i64 %v8, ptr %st6
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st7
  %st8 = getelementptr i64, ptr %v9, i64 1
  store i64 %v10, ptr %st8
  %v11 = add i64 0, 3
  %st9 = getelementptr i64, ptr %v9, i64 0
  store i64 %v11, ptr %st9
  %v12 = getelementptr i64, ptr %s3, i64 0
  %v13.p = getelementptr i64, ptr %v9, i64 0
  %v13 = load i64, ptr %v13.p
  %st10 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st10
  %v14.p = getelementptr i64, ptr %v9, i64 1
  %v14 = load i64, ptr %v14.p
  %st11 = getelementptr i64, ptr %v12, i64 1
  store i64 %v14, ptr %st11
  %v15 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v12, i64 2
  store i64 %v15, ptr %st12
  %st13 = getelementptr i64, ptr %v12, i64 3
  store i64 %v15, ptr %st13
  %st14 = getelementptr i64, ptr %v12, i64 4
  store i64 %v15, ptr %st14
  %v16 = getelementptr i64, ptr %s4, i64 0
  %v17 = add i64 0, 1
  %st15 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st15
  %v18.p = getelementptr i64, ptr %v12, i64 0
  %v18 = load i64, ptr %v18.p
  %st16 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st16
  %v19.p = getelementptr i64, ptr %v12, i64 1
  %v19 = load i64, ptr %v19.p
  %st17 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st17
  %v20.p = getelementptr i64, ptr %v12, i64 2
  %v20 = load i64, ptr %v20.p
  %st18 = getelementptr i64, ptr %v16, i64 3
  store i64 %v20, ptr %st18
  %v21.p = getelementptr i64, ptr %v12, i64 3
  %v21 = load i64, ptr %v21.p
  %st19 = getelementptr i64, ptr %v16, i64 4
  store i64 %v21, ptr %st19
  %v22.p = getelementptr i64, ptr %v12, i64 4
  %v22 = load i64, ptr %v22.p
  %st20 = getelementptr i64, ptr %v16, i64 5
  store i64 %v22, ptr %st20
  %v23.p = getelementptr i64, ptr %v7, i64 0
  %v23 = load i64, ptr %v23.p
  %st21 = getelementptr i64, ptr %v0, i64 0
  store i64 %v23, ptr %st21
  %v24.p = getelementptr i64, ptr %v7, i64 1
  %v24 = load i64, ptr %v24.p
  %st22 = getelementptr i64, ptr %v0, i64 1
  store i64 %v24, ptr %st22
  %v25.p = getelementptr i64, ptr %v7, i64 2
  %v25 = load i64, ptr %v25.p
  %st23 = getelementptr i64, ptr %v0, i64 2
  store i64 %v25, ptr %st23
  %v26.p = getelementptr i64, ptr %v7, i64 3
  %v26 = load i64, ptr %v26.p
  %st24 = getelementptr i64, ptr %v0, i64 3
  store i64 %v26, ptr %st24
  %v27.p = getelementptr i64, ptr %v16, i64 0
  %v27 = load i64, ptr %v27.p
  %st25 = getelementptr i64, ptr %v0, i64 4
  store i64 %v27, ptr %st25
  %v28.p = getelementptr i64, ptr %v16, i64 1
  %v28 = load i64, ptr %v28.p
  %st26 = getelementptr i64, ptr %v0, i64 5
  store i64 %v28, ptr %st26
  %v29.p = getelementptr i64, ptr %v16, i64 2
  %v29 = load i64, ptr %v29.p
  %st27 = getelementptr i64, ptr %v0, i64 6
  store i64 %v29, ptr %st27
  %v30.p = getelementptr i64, ptr %v16, i64 3
  %v30 = load i64, ptr %v30.p
  %st28 = getelementptr i64, ptr %v0, i64 7
  store i64 %v30, ptr %st28
  %v31.p = getelementptr i64, ptr %v16, i64 4
  %v31 = load i64, ptr %v31.p
  %st29 = getelementptr i64, ptr %v0, i64 8
  store i64 %v31, ptr %st29
  %v32.p = getelementptr i64, ptr %v16, i64 5
  %v32 = load i64, ptr %v32.p
  %st30 = getelementptr i64, ptr %v0, i64 9
  store i64 %v32, ptr %st30
  %v33.p = getelementptr i64, ptr %v0, i64 4
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 0, 0
  %v35.c = icmp ne i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b1 = icmp ne i64 %v35, 0
  br i1 %c.b1, label %b1.t32, label %b1.e33
b1.t32:
  br label %b3
b1.e33:
  br label %b4
b2:
  br label %b5
b3:
  %v36 = add i64 0, 7
  %v37 = getelementptr i64, ptr %v0, i64 %v36
  %v196 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v37, i64 %v196, i64 %v3)
  br label %b4
b4:
  %v197 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v197, i64 0
  store i64 %v3, ptr %st33
  ret void
b5:
  %v198 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v198, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40 = call ptr @"rt.region_alloc8"(i64 %v38, i64 %v39)
  %v41 = add i64 0, 0
  %v42 = getelementptr i64, ptr %s5, i64 0
  %v43 = ptrtoint ptr %v40 to i64
  %st34 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st34
  %st35 = getelementptr i64, ptr %v42, i64 1
  store i64 %v41, ptr %st35
  %st36 = getelementptr i64, ptr %v42, i64 2
  store i64 %v38, ptr %st36
  %v44 = getelementptr i64, ptr %s6, i64 0
  %v45.p = getelementptr i64, ptr %v42, i64 0
  %v45 = load i64, ptr %v45.p
  %st37 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st37
  %v46.p = getelementptr i64, ptr %v42, i64 1
  %v46 = load i64, ptr %v46.p
  %st38 = getelementptr i64, ptr %v44, i64 1
  store i64 %v46, ptr %st38
  %v47.p = getelementptr i64, ptr %v42, i64 2
  %v47 = load i64, ptr %v47.p
  %st39 = getelementptr i64, ptr %v44, i64 2
  store i64 %v47, ptr %st39
  %v199 = getelementptr i64, ptr @"rt.meta", i64 0
  %v48.p = getelementptr i64, ptr %v199, i64 0
  %v48 = load i64, ptr %v48.p
  br label %b6
b6:
  %v200 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v200, i64 0
  store i64 %v48, ptr %st40
  %v49.p = getelementptr i64, ptr %v44, i64 1
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 144
  %v51.c = icmp slt i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b6 = icmp ne i64 %v51, 0
  br i1 %c.b6, label %b6.t42, label %b6.e43
b6.t42:
  br label %b7
b6.e43:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v201 = getelementptr i64, ptr @"rt.meta", i64 0
  %v52.p = getelementptr i64, ptr %v201, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 1
  %v54 = add i64 %v3, %v53
  %v55 = getelementptr i64, ptr %s5, i64 0
  %v56.p = getelementptr i64, ptr %v44, i64 0
  %v56 = load i64, ptr %v56.p
  %st43 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st43
  %v57.p = getelementptr i64, ptr %v44, i64 1
  %v57 = load i64, ptr %v57.p
  %st44 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st44
  %v58.p = getelementptr i64, ptr %v44, i64 2
  %v58 = load i64, ptr %v58.p
  %st45 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st45
  %v59 = add i64 0, 0
  %v60.p = getelementptr i64, ptr %v55, i64 2
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v55, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v55, i64 1
  %v62 = load i64, ptr %v62.p
  %v65 = add i64 %v61, %v62
  %v66 = call i64 @"rt.tip8"(i64 %v60, i64 %v65)
  %v67 = add i64 0, 0
  %v68.c = icmp ne i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b7 = icmp ne i64 %v68, 0
  br i1 %c.b7, label %b7.t47, label %b7.e48
b7.t47:
  br label %b11
b7.e48:
  br label %b10
b8:
  %v202 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v202, i64 0
  store i64 %v48, ptr %st48
  %v82 = add i64 0, 5
  %v83.p = getelementptr i64, ptr %v2, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v44, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 0
  %v86 = add i64 0, 0
  %v87 = add i64 0, 0
  %v88 = add i64 0, 0
  %v89 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v82, i64 %v83, i64 %v84, i64 %v85, i64 %v86, i64 %v87, i64 %v88)
  %v90 = add i64 0, 0
  %v91.c = icmp slt i64 %v89, %v90
  %v91 = zext i1 %v91.c to i64
  %c.b8 = icmp ne i64 %v91, 0
  br i1 %c.b8, label %b8.t50, label %b8.e51
b8.t50:
  br label %b12
b8.e51:
  br label %b13
b9:
  %v63 = phi ptr [ %v72, %b10 ], [ %v69, %b11 ]
  %v64 = phi ptr [ %v73, %b10 ], [ %v70, %b11 ]
  %st51 = getelementptr i8, ptr %v64, i64 0
  %st51.b = trunc i64 %v59 to i8
  store i8 %st51.b, ptr %st51
  %v74.p = getelementptr i64, ptr %v55, i64 1
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 1
  %v76 = add i64 %v74, %v75
  %v77 = getelementptr i64, ptr %s7, i64 0
  %v78 = ptrtoint ptr %v63 to i64
  %st52 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st52
  %st53 = getelementptr i64, ptr %v77, i64 1
  store i64 %v76, ptr %st53
  %st54 = getelementptr i64, ptr %v77, i64 2
  store i64 %v60, ptr %st54
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %st55 = getelementptr i64, ptr %v44, i64 0
  store i64 %v79, ptr %st55
  %v80.p = getelementptr i64, ptr %v77, i64 1
  %v80 = load i64, ptr %v80.p
  %st56 = getelementptr i64, ptr %v44, i64 1
  store i64 %v80, ptr %st56
  %v81.p = getelementptr i64, ptr %v77, i64 2
  %v81 = load i64, ptr %v81.p
  %st57 = getelementptr i64, ptr %v44, i64 2
  store i64 %v81, ptr %st57
  br label %b6
b10:
  %v71 = add i64 0, 1
  %v72 = call ptr @"rt.slice_grow8"(i64 %v61, i64 %v62, i64 %v60, i64 %v71)
  %v73 = getelementptr i8, ptr %v72, i64 %v62
  br label %b9
b11:
  %v69 = inttoptr i64 %v61 to ptr
  %v70 = getelementptr i8, ptr %v69, i64 %v62
  br label %b9
b12:
  %v92 = getelementptr i64, ptr %s1, i64 0
  %v93 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v92, i64 0
  store i64 %v93, ptr %st58
  %st59 = getelementptr i64, ptr %v92, i64 1
  store i64 %v93, ptr %st59
  %st60 = getelementptr i64, ptr %v92, i64 2
  store i64 %v93, ptr %st60
  %st61 = getelementptr i64, ptr %v92, i64 3
  store i64 %v93, ptr %st61
  %v94 = getelementptr i64, ptr %s8, i64 0
  %v95 = add i64 0, 0
  %v96 = sub i64 %v95, %v89
  call void @"std/io.errOf"(ptr %v94, i64 %v96)
  %v97 = getelementptr i64, ptr %s4, i64 0
  %v98 = add i64 0, 1
  %st62 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st62
  %v99.p = getelementptr i64, ptr %v94, i64 0
  %v99 = load i64, ptr %v99.p
  %st63 = getelementptr i64, ptr %v97, i64 1
  store i64 %v99, ptr %st63
  %v100.p = getelementptr i64, ptr %v94, i64 1
  %v100 = load i64, ptr %v100.p
  %st64 = getelementptr i64, ptr %v97, i64 2
  store i64 %v100, ptr %st64
  %v101.p = getelementptr i64, ptr %v94, i64 2
  %v101 = load i64, ptr %v101.p
  %st65 = getelementptr i64, ptr %v97, i64 3
  store i64 %v101, ptr %st65
  %v102.p = getelementptr i64, ptr %v94, i64 3
  %v102 = load i64, ptr %v102.p
  %st66 = getelementptr i64, ptr %v97, i64 4
  store i64 %v102, ptr %st66
  %v103.p = getelementptr i64, ptr %v94, i64 4
  %v103 = load i64, ptr %v103.p
  %st67 = getelementptr i64, ptr %v97, i64 5
  store i64 %v103, ptr %st67
  %v104.p = getelementptr i64, ptr %v92, i64 0
  %v104 = load i64, ptr %v104.p
  %st68 = getelementptr i64, ptr %v0, i64 0
  store i64 %v104, ptr %st68
  %v105.p = getelementptr i64, ptr %v92, i64 1
  %v105 = load i64, ptr %v105.p
  %st69 = getelementptr i64, ptr %v0, i64 1
  store i64 %v105, ptr %st69
  %v106.p = getelementptr i64, ptr %v92, i64 2
  %v106 = load i64, ptr %v106.p
  %st70 = getelementptr i64, ptr %v0, i64 2
  store i64 %v106, ptr %st70
  %v107.p = getelementptr i64, ptr %v92, i64 3
  %v107 = load i64, ptr %v107.p
  %st71 = getelementptr i64, ptr %v0, i64 3
  store i64 %v107, ptr %st71
  %v108.p = getelementptr i64, ptr %v97, i64 0
  %v108 = load i64, ptr %v108.p
  %st72 = getelementptr i64, ptr %v0, i64 4
  store i64 %v108, ptr %st72
  %v109.p = getelementptr i64, ptr %v97, i64 1
  %v109 = load i64, ptr %v109.p
  %st73 = getelementptr i64, ptr %v0, i64 5
  store i64 %v109, ptr %st73
  %v110.p = getelementptr i64, ptr %v97, i64 2
  %v110 = load i64, ptr %v110.p
  %st74 = getelementptr i64, ptr %v0, i64 6
  store i64 %v110, ptr %st74
  %v111.p = getelementptr i64, ptr %v97, i64 3
  %v111 = load i64, ptr %v111.p
  %st75 = getelementptr i64, ptr %v0, i64 7
  store i64 %v111, ptr %st75
  %v112.p = getelementptr i64, ptr %v97, i64 4
  %v112 = load i64, ptr %v112.p
  %st76 = getelementptr i64, ptr %v0, i64 8
  store i64 %v112, ptr %st76
  %v113.p = getelementptr i64, ptr %v97, i64 5
  %v113 = load i64, ptr %v113.p
  %st77 = getelementptr i64, ptr %v0, i64 9
  store i64 %v113, ptr %st77
  %v114.p = getelementptr i64, ptr %v0, i64 4
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp ne i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b12 = icmp ne i64 %v116, 0
  br i1 %c.b12, label %b12.t79, label %b12.e80
b12.t79:
  br label %b14
b12.e80:
  br label %b15
b13:
  br label %b16
b14:
  %v117 = add i64 0, 7
  %v118 = getelementptr i64, ptr %v0, i64 %v117
  %v203 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v118, i64 %v203, i64 %v3)
  br label %b15
b15:
  %v204 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v204, i64 0
  store i64 %v3, ptr %st80
  ret void
b16:
  %v119 = add i64 0, 25
  %v120.p = getelementptr i64, ptr %v44, i64 1
  %v120 = load i64, ptr %v120.p
  %v121.c = icmp uge i64 %v119, %v120
  %v121 = zext i1 %v121.c to i64
  %c.b16 = icmp ne i64 %v121, 0
  br i1 %c.b16, label %b16.t82, label %b16.e83
b16.t82:
  br label %b17
b16.e83:
  br label %b18
b17:
  %v122 = add i64 0, 3
  call void @"rt.panic"(i64 %v122)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v123.p = getelementptr i64, ptr %v44, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = inttoptr i64 %v123 to ptr
  %v125 = getelementptr i8, ptr %v124, i64 %v119
  %v126.p = getelementptr i8, ptr %v125, i64 0
  %v126.b = load i8, ptr %v126.p
  %v126 = zext i8 %v126.b to i64
  %v127 = add i64 0, 256
  %v128 = mul i64 %v126, %v127
  %v129 = add i64 0, 24
  %v130.p = getelementptr i64, ptr %v44, i64 1
  %v130 = load i64, ptr %v130.p
  %v131.c = icmp uge i64 %v129, %v130
  %v131 = zext i1 %v131.c to i64
  %c.b18 = icmp ne i64 %v131, 0
  br i1 %c.b18, label %b18.t84, label %b18.e85
b18.t84:
  br label %b19
b18.e85:
  br label %b20
b19:
  %v132 = add i64 0, 4
  call void @"rt.panic"(i64 %v132)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v133.p = getelementptr i64, ptr %v44, i64 0
  %v133 = load i64, ptr %v133.p
  %v134 = inttoptr i64 %v133 to ptr
  %v135 = getelementptr i8, ptr %v134, i64 %v129
  %v136.p = getelementptr i8, ptr %v135, i64 0
  %v136.b = load i8, ptr %v136.p
  %v136 = zext i8 %v136.b to i64
  %v137 = add i64 %v128, %v136
  %v138 = add i64 0, 61440
  %v139 = and i64 %v137, %v138
  %v140 = add i64 0, 32768
  %v141.c = icmp eq i64 %v139, %v140
  %v141 = zext i1 %v141.c to i64
  %c.b20 = icmp ne i64 %v141, 0
  br i1 %c.b20, label %b20.t86, label %b20.e87
b20.t86:
  br label %b21
b20.e87:
  br label %b22
b21:
  %v142 = add i64 0, 8
  br label %b26
b22:
  %v143 = add i64 0, 16384
  %v144.c = icmp eq i64 %v139, %v143
  %v144 = zext i1 %v144.c to i64
  %c.b22 = icmp ne i64 %v144, 0
  br i1 %c.b22, label %b22.t88, label %b22.e89
b22.t88:
  br label %b23
b22.e89:
  br label %b24
b23:
  %v145 = add i64 0, 4
  br label %b25
b24:
  %v146 = add i64 0, 0
  br label %b25
b25:
  %v147 = phi i64 [ %v145, %b23 ], [ %v146, %b24 ]
  br label %b26
b26:
  %v148 = phi i64 [ %v142, %b21 ], [ %v147, %b25 ]
  %v149.p = getelementptr i64, ptr %v44, i64 0
  %v149 = load i64, ptr %v149.p
  %v150.p = getelementptr i64, ptr %v44, i64 1
  %v150 = load i64, ptr %v150.p
  %v151.p = getelementptr i64, ptr %v44, i64 2
  %v151 = load i64, ptr %v151.p
  %v152 = add i64 0, 48
  %v153 = call i64 @"std/io.le64"(i64 %v149, i64 %v150, i64 %v151, i64 %v152)
  %v154.p = getelementptr i64, ptr %v44, i64 0
  %v154 = load i64, ptr %v154.p
  %v155.p = getelementptr i64, ptr %v44, i64 1
  %v155 = load i64, ptr %v155.p
  %v156.p = getelementptr i64, ptr %v44, i64 2
  %v156 = load i64, ptr %v156.p
  %v157 = add i64 0, 88
  %v158 = call i64 @"std/io.le64"(i64 %v154, i64 %v155, i64 %v156, i64 %v157)
  %v159 = add i64 0, 1000000000
  %v160 = mul i64 %v158, %v159
  %v161.p = getelementptr i64, ptr %v44, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v44, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v44, i64 2
  %v163 = load i64, ptr %v163.p
  %v164 = add i64 0, 96
  %v165 = call i64 @"std/io.le64"(i64 %v161, i64 %v162, i64 %v163, i64 %v164)
  %v166 = add i64 %v160, %v165
  %v167 = getelementptr i64, ptr %s9, i64 0
  call void @"std/io.kindOf"(ptr %v167, i64 %v148)
  %v168 = getelementptr i64, ptr %s2, i64 0
  %v169 = add i64 0, 1
  %st89 = getelementptr i64, ptr %v168, i64 0
  store i64 %v169, ptr %st89
  %v170.p = getelementptr i64, ptr %v167, i64 0
  %v170 = load i64, ptr %v170.p
  %st90 = getelementptr i64, ptr %v168, i64 1
  store i64 %v170, ptr %st90
  %v171 = getelementptr i64, ptr %s10, i64 0
  %v172.p = getelementptr i64, ptr %v168, i64 0
  %v172 = load i64, ptr %v172.p
  %st91 = getelementptr i64, ptr %v171, i64 0
  store i64 %v172, ptr %st91
  %v173.p = getelementptr i64, ptr %v168, i64 1
  %v173 = load i64, ptr %v173.p
  %st92 = getelementptr i64, ptr %v171, i64 1
  store i64 %v173, ptr %st92
  %v174 = getelementptr i64, ptr %s1, i64 0
  %v175 = add i64 0, 0
  %st93 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st93
  %st94 = getelementptr i64, ptr %v174, i64 1
  store i64 %v175, ptr %st94
  %st95 = getelementptr i64, ptr %v174, i64 2
  store i64 %v175, ptr %st95
  %st96 = getelementptr i64, ptr %v174, i64 3
  store i64 %v175, ptr %st96
  %st97 = getelementptr i64, ptr %v174, i64 0
  store i64 %v153, ptr %st97
  %st98 = getelementptr i64, ptr %v174, i64 1
  store i64 %v166, ptr %st98
  %v176.p = getelementptr i64, ptr %v171, i64 0
  %v176 = load i64, ptr %v176.p
  %st99 = getelementptr i64, ptr %v174, i64 2
  store i64 %v176, ptr %st99
  %v177.p = getelementptr i64, ptr %v171, i64 1
  %v177 = load i64, ptr %v177.p
  %st100 = getelementptr i64, ptr %v174, i64 3
  store i64 %v177, ptr %st100
  %v178 = getelementptr i64, ptr %s4, i64 0
  %v179 = add i64 0, 0
  %st101 = getelementptr i64, ptr %v178, i64 0
  store i64 %v179, ptr %st101
  %v180.p = getelementptr i64, ptr %v174, i64 0
  %v180 = load i64, ptr %v180.p
  %st102 = getelementptr i64, ptr %v0, i64 0
  store i64 %v180, ptr %st102
  %v181.p = getelementptr i64, ptr %v174, i64 1
  %v181 = load i64, ptr %v181.p
  %st103 = getelementptr i64, ptr %v0, i64 1
  store i64 %v181, ptr %st103
  %v182.p = getelementptr i64, ptr %v174, i64 2
  %v182 = load i64, ptr %v182.p
  %st104 = getelementptr i64, ptr %v0, i64 2
  store i64 %v182, ptr %st104
  %v183.p = getelementptr i64, ptr %v174, i64 3
  %v183 = load i64, ptr %v183.p
  %st105 = getelementptr i64, ptr %v0, i64 3
  store i64 %v183, ptr %st105
  %v184.p = getelementptr i64, ptr %v178, i64 0
  %v184 = load i64, ptr %v184.p
  %st106 = getelementptr i64, ptr %v0, i64 4
  store i64 %v184, ptr %st106
  %v185.p = getelementptr i64, ptr %v178, i64 1
  %v185 = load i64, ptr %v185.p
  %st107 = getelementptr i64, ptr %v0, i64 5
  store i64 %v185, ptr %st107
  %v186.p = getelementptr i64, ptr %v178, i64 2
  %v186 = load i64, ptr %v186.p
  %st108 = getelementptr i64, ptr %v0, i64 6
  store i64 %v186, ptr %st108
  %v187.p = getelementptr i64, ptr %v178, i64 3
  %v187 = load i64, ptr %v187.p
  %st109 = getelementptr i64, ptr %v0, i64 7
  store i64 %v187, ptr %st109
  %v188.p = getelementptr i64, ptr %v178, i64 4
  %v188 = load i64, ptr %v188.p
  %st110 = getelementptr i64, ptr %v0, i64 8
  store i64 %v188, ptr %st110
  %v189.p = getelementptr i64, ptr %v178, i64 5
  %v189 = load i64, ptr %v189.p
  %st111 = getelementptr i64, ptr %v0, i64 9
  store i64 %v189, ptr %st111
  %v190.p = getelementptr i64, ptr %v0, i64 4
  %v190 = load i64, ptr %v190.p
  %v191 = add i64 0, 0
  %v192.c = icmp ne i64 %v190, %v191
  %v192 = zext i1 %v192.c to i64
  %c.b26 = icmp ne i64 %v192, 0
  br i1 %c.b26, label %b26.t113, label %b26.e114
b26.t113:
  br label %b27
b26.e114:
  br label %b28
b27:
  %v193 = add i64 0, 7
  %v194 = getelementptr i64, ptr %v0, i64 %v193
  %v205 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v194, i64 %v205, i64 %v3)
  br label %b28
b28:
  %v206 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v206, i64 0
  store i64 %v3, ptr %st114
  ret void
}

define internal void @"std/io.Close"(i64 %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v1 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v0, ptr %st0
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v5, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3.p = getelementptr i64, ptr %v1, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = call i64 @"rt.close"(i64 %v3)
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v6, i64 0
  store i64 %v2, ptr %st1
  ret void
}

define internal void @"std/os.ModTime"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v44, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = call i64 @"rt.stat"(ptr %v4)
  %v7 = add i64 0, 0
  %v8.c = icmp slt i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b0 = icmp ne i64 %v8, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v9 = add i64 0, 0
  %v10 = getelementptr i64, ptr %s1, i64 0
  %v11 = add i64 0, 0
  %v12 = sub i64 %v11, %v6
  call void @"std/os.errOf"(ptr %v10, i64 %v12)
  %v13 = getelementptr i64, ptr %s2, i64 0
  %v14 = add i64 0, 1
  %st5 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st5
  %v15.p = getelementptr i64, ptr %v10, i64 0
  %v15 = load i64, ptr %v15.p
  %st6 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st6
  %v16.p = getelementptr i64, ptr %v10, i64 1
  %v16 = load i64, ptr %v16.p
  %st7 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st7
  %v17.p = getelementptr i64, ptr %v10, i64 2
  %v17 = load i64, ptr %v17.p
  %st8 = getelementptr i64, ptr %v13, i64 3
  store i64 %v17, ptr %st8
  %v18.p = getelementptr i64, ptr %v10, i64 3
  %v18 = load i64, ptr %v18.p
  %st9 = getelementptr i64, ptr %v13, i64 4
  store i64 %v18, ptr %st9
  %v19.p = getelementptr i64, ptr %v10, i64 4
  %v19 = load i64, ptr %v19.p
  %st10 = getelementptr i64, ptr %v13, i64 5
  store i64 %v19, ptr %st10
  %st11 = getelementptr i64, ptr %v0, i64 0
  store i64 %v9, ptr %st11
  %v20.p = getelementptr i64, ptr %v13, i64 0
  %v20 = load i64, ptr %v20.p
  %st12 = getelementptr i64, ptr %v0, i64 1
  store i64 %v20, ptr %st12
  %v21.p = getelementptr i64, ptr %v13, i64 1
  %v21 = load i64, ptr %v21.p
  %st13 = getelementptr i64, ptr %v0, i64 2
  store i64 %v21, ptr %st13
  %v22.p = getelementptr i64, ptr %v13, i64 2
  %v22 = load i64, ptr %v22.p
  %st14 = getelementptr i64, ptr %v0, i64 3
  store i64 %v22, ptr %st14
  %v23.p = getelementptr i64, ptr %v13, i64 3
  %v23 = load i64, ptr %v23.p
  %st15 = getelementptr i64, ptr %v0, i64 4
  store i64 %v23, ptr %st15
  %v24.p = getelementptr i64, ptr %v13, i64 4
  %v24 = load i64, ptr %v24.p
  %st16 = getelementptr i64, ptr %v0, i64 5
  store i64 %v24, ptr %st16
  %v25.p = getelementptr i64, ptr %v13, i64 5
  %v25 = load i64, ptr %v25.p
  %st17 = getelementptr i64, ptr %v0, i64 6
  store i64 %v25, ptr %st17
  %v26.p = getelementptr i64, ptr %v0, i64 1
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp ne i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b1 = icmp ne i64 %v28, 0
  br i1 %c.b1, label %b1.t19, label %b1.e20
b1.t19:
  br label %b3
b1.e20:
  br label %b4
b2:
  br label %b5
b3:
  %v29 = add i64 0, 4
  %v30 = getelementptr i64, ptr %v0, i64 %v29
  %v45 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v30, i64 %v45, i64 %v5)
  br label %b4
b4:
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v46, i64 0
  store i64 %v5, ptr %st20
  ret void
b5:
  %v31 = getelementptr i64, ptr %s2, i64 0
  %v32 = add i64 0, 0
  %st21 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st21
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v6, ptr %st22
  %v33.p = getelementptr i64, ptr %v31, i64 0
  %v33 = load i64, ptr %v33.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v33, ptr %st23
  %v34.p = getelementptr i64, ptr %v31, i64 1
  %v34 = load i64, ptr %v34.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v34, ptr %st24
  %v35.p = getelementptr i64, ptr %v31, i64 2
  %v35 = load i64, ptr %v35.p
  %st25 = getelementptr i64, ptr %v0, i64 3
  store i64 %v35, ptr %st25
  %v36.p = getelementptr i64, ptr %v31, i64 3
  %v36 = load i64, ptr %v36.p
  %st26 = getelementptr i64, ptr %v0, i64 4
  store i64 %v36, ptr %st26
  %v37.p = getelementptr i64, ptr %v31, i64 4
  %v37 = load i64, ptr %v37.p
  %st27 = getelementptr i64, ptr %v0, i64 5
  store i64 %v37, ptr %st27
  %v38.p = getelementptr i64, ptr %v31, i64 5
  %v38 = load i64, ptr %v38.p
  %st28 = getelementptr i64, ptr %v0, i64 6
  store i64 %v38, ptr %st28
  %v39.p = getelementptr i64, ptr %v0, i64 1
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 0
  %v41.c = icmp ne i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b5 = icmp ne i64 %v41, 0
  br i1 %c.b5, label %b5.t30, label %b5.e31
b5.t30:
  br label %b6
b5.e31:
  br label %b7
b6:
  %v42 = add i64 0, 4
  %v43 = getelementptr i64, ptr %v0, i64 %v42
  %v47 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v43, i64 %v47, i64 %v5)
  br label %b7
b7:
  %v48 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v48, i64 0
  store i64 %v5, ptr %st31
  ret void
}

define internal void @"main.kindName"(ptr %v0, i64 %v1, i64 %v2) #0 {
b0:
  %s0 = alloca [2 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s1 = alloca [2 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
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
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v2, ptr %st1
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v60, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5 = getelementptr i64, ptr %s1, i64 0
  %v6.p = getelementptr i64, ptr %v3, i64 0
  %v6 = load i64, ptr %v6.p
  %st2 = getelementptr i64, ptr %v5, i64 0
  store i64 %v6, ptr %st2
  %v7.p = getelementptr i64, ptr %v3, i64 1
  %v7 = load i64, ptr %v7.p
  %st3 = getelementptr i64, ptr %v5, i64 1
  store i64 %v7, ptr %st3
  %v8.p = getelementptr i64, ptr %v5, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp eq i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v11 = getelementptr i64, ptr @"str.34", i64 0
  %v12 = add i64 0, 4
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15 = ptrtoint ptr %v11 to i64
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 1
  store i64 %v12, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 2
  store i64 %v13, ptr %st8
  %v16.p = getelementptr i64, ptr %v14, i64 0
  %v16 = load i64, ptr %v16.p
  %st9 = getelementptr i64, ptr %v0, i64 0
  store i64 %v16, ptr %st9
  %v17.p = getelementptr i64, ptr %v14, i64 1
  %v17 = load i64, ptr %v17.p
  %st10 = getelementptr i64, ptr %v0, i64 1
  store i64 %v17, ptr %st10
  %v18.p = getelementptr i64, ptr %v14, i64 2
  %v18 = load i64, ptr %v18.p
  %st11 = getelementptr i64, ptr %v0, i64 2
  store i64 %v18, ptr %st11
  call void @"rt.region_relocate8"(ptr %v0, i64 %v4)
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v61, i64 0
  store i64 %v4, ptr %st12
  ret void
b2:
  %v19 = add i64 0, 1
  %v20 = getelementptr i64, ptr %v5, i64 %v19
  %v21 = getelementptr i64, ptr %s3, i64 0
  %v22.p = getelementptr i64, ptr %v20, i64 0
  %v22 = load i64, ptr %v22.p
  %st13 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st13
  %v23.p = getelementptr i64, ptr %v21, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25.c = icmp eq i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b2 = icmp ne i64 %v25, 0
  br i1 %c.b2, label %b2.t15, label %b2.e16
b2.t15:
  br label %b4
b2.e16:
  br label %b3
b3:
  %v31.p = getelementptr i64, ptr %v21, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 0, 1
  %v33.c = icmp eq i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b3 = icmp ne i64 %v33, 0
  br i1 %c.b3, label %b3.t17, label %b3.e18
b3.t17:
  br label %b6
b3.e18:
  br label %b5
b4:
  %v26 = getelementptr i64, ptr @"str.26", i64 0
  %v27 = add i64 0, 7
  %v28 = add i64 0, 0
  %v29 = getelementptr i64, ptr %s2, i64 0
  %v30 = ptrtoint ptr %v26 to i64
  %st18 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st18
  %st19 = getelementptr i64, ptr %v29, i64 1
  store i64 %v27, ptr %st19
  %st20 = getelementptr i64, ptr %v29, i64 2
  store i64 %v28, ptr %st20
  br label %b11
b5:
  %v39.p = getelementptr i64, ptr %v21, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 2
  %v41.c = icmp eq i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b5 = icmp ne i64 %v41, 0
  br i1 %c.b5, label %b5.t22, label %b5.e23
b5.t22:
  br label %b8
b5.e23:
  br label %b7
b6:
  %v34 = getelementptr i64, ptr @"str.35", i64 0
  %v35 = add i64 0, 3
  %v36 = add i64 0, 0
  %v37 = getelementptr i64, ptr %s4, i64 0
  %v38 = ptrtoint ptr %v34 to i64
  %st23 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st23
  %st24 = getelementptr i64, ptr %v37, i64 1
  store i64 %v35, ptr %st24
  %st25 = getelementptr i64, ptr %v37, i64 2
  store i64 %v36, ptr %st25
  br label %b11
b7:
  %v47.p = getelementptr i64, ptr %v21, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 0, 3
  %v49.c = icmp eq i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b7 = icmp ne i64 %v49, 0
  br i1 %c.b7, label %b7.t27, label %b7.e28
b7.t27:
  br label %b10
b7.e28:
  br label %b9
b8:
  %v42 = getelementptr i64, ptr @"str.36", i64 0
  %v43 = add i64 0, 7
  %v44 = add i64 0, 0
  %v45 = getelementptr i64, ptr %s5, i64 0
  %v46 = ptrtoint ptr %v42 to i64
  %st28 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st28
  %st29 = getelementptr i64, ptr %v45, i64 1
  store i64 %v43, ptr %st29
  %st30 = getelementptr i64, ptr %v45, i64 2
  store i64 %v44, ptr %st30
  br label %b11
b9:
  %v55 = getelementptr i64, ptr %s7, i64 0
  br label %b11
b10:
  %v50 = getelementptr i64, ptr @"str.37", i64 0
  %v51 = add i64 0, 9
  %v52 = add i64 0, 0
  %v53 = getelementptr i64, ptr %s6, i64 0
  %v54 = ptrtoint ptr %v50 to i64
  %st31 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st31
  %st32 = getelementptr i64, ptr %v53, i64 1
  store i64 %v51, ptr %st32
  %st33 = getelementptr i64, ptr %v53, i64 2
  store i64 %v52, ptr %st33
  br label %b11
b11:
  %v56 = phi ptr [ %v29, %b4 ], [ %v37, %b6 ], [ %v45, %b8 ], [ %v55, %b9 ], [ %v53, %b10 ]
  %v57.p = getelementptr i64, ptr %v56, i64 0
  %v57 = load i64, ptr %v57.p
  %st34 = getelementptr i64, ptr %v0, i64 0
  store i64 %v57, ptr %st34
  %v58.p = getelementptr i64, ptr %v56, i64 1
  %v58 = load i64, ptr %v58.p
  %st35 = getelementptr i64, ptr %v0, i64 1
  store i64 %v58, ptr %st35
  %v59.p = getelementptr i64, ptr %v56, i64 2
  %v59 = load i64, ptr %v59.p
  %st36 = getelementptr i64, ptr %v0, i64 2
  store i64 %v59, ptr %st36
  call void @"rt.region_relocate8"(ptr %v0, i64 %v4)
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v62, i64 0
  store i64 %v4, ptr %st37
  ret void
}

define internal i64 @"rt.stat"(ptr %v0) #0 {
b0:
  %v1 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v2 = getelementptr i64, ptr @"rt.statbuf", i64 0
  %v3 = call i64 @"rt.cstr"(ptr %v0, ptr %v1)
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
  %v7 = add i64 0, 0
  %v8 = sub i64 %v7, %v3
  ret i64 %v8
b2:
  %v9 = add i64 0, 4
  %v10 = ptrtoint ptr %v1 to i64
  %v11 = ptrtoint ptr %v2 to i64
  %v12 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},~{rcx},~{r11},~{memory}"(i64 %v9, i64 %v10, i64 %v11)
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
  ret i64 %v12
b4:
  %v18 = add i64 0, 0
  %v19 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v19, i64 1027
  store i64 %v18, ptr %st6
  %v20.p = getelementptr i64, ptr %v2, i64 11
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 1000000000
  %v22 = mul i64 %v20, %v21
  %v23.p = getelementptr i64, ptr %v2, i64 12
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 %v22, %v23
  ret i64 %v24
}

define internal void @"std/os.errOf"(ptr %v0, i64 %v1) #0 {
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
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v58, i64 0
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
  %v10 = add i64 0, 0
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
  %v20 = add i64 0, 2
  %v21 = getelementptr i64, ptr %v0, i64 %v20
  %v59 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v21, i64 %v59, i64 %v2)
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v60, i64 0
  store i64 %v2, ptr %st17
  ret void
b4:
  br label %b5
b5:
  %v22 = add i64 0, 13
  %v23.c = icmp eq i64 %v1, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b5 = icmp ne i64 %v23, 0
  br i1 %c.b5, label %b5.t19, label %b5.e20
b5.t19:
  br label %b7
b5.e20:
  br label %b6
b6:
  %v25 = add i64 0, 1
  %v26.c = icmp eq i64 %v1, %v25
  %v26 = zext i1 %v26.c to i64
  br label %b7
b7:
  %v24 = phi i64 [ %v23, %b5.t19 ], [ %v26, %b6 ]
  %c.b7 = icmp ne i64 %v24, 0
  br i1 %c.b7, label %b7.t21, label %b7.e22
b7.t21:
  br label %b9
b7.e22:
  br label %b8
b8:
  %v28 = add i64 0, 30
  %v29.c = icmp eq i64 %v1, %v28
  %v29 = zext i1 %v29.c to i64
  br label %b9
b9:
  %v27 = phi i64 [ %v24, %b7.t21 ], [ %v29, %b8 ]
  %c.b9 = icmp ne i64 %v27, 0
  br i1 %c.b9, label %b9.t23, label %b9.e24
b9.t23:
  br label %b10
b9.e24:
  br label %b11
b10:
  %v30 = getelementptr i64, ptr %s0, i64 0
  %v31 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st24
  %st25 = getelementptr i64, ptr %v30, i64 1
  store i64 %v31, ptr %st25
  %v32 = add i64 0, 1
  %st26 = getelementptr i64, ptr %v30, i64 0
  store i64 %v32, ptr %st26
  %v33 = getelementptr i64, ptr %s1, i64 0
  %v34.p = getelementptr i64, ptr %v30, i64 0
  %v34 = load i64, ptr %v34.p
  %st27 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st27
  %v35.p = getelementptr i64, ptr %v30, i64 1
  %v35 = load i64, ptr %v35.p
  %st28 = getelementptr i64, ptr %v33, i64 1
  store i64 %v35, ptr %st28
  %v36 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v33, i64 2
  store i64 %v36, ptr %st29
  %st30 = getelementptr i64, ptr %v33, i64 3
  store i64 %v36, ptr %st30
  %st31 = getelementptr i64, ptr %v33, i64 4
  store i64 %v36, ptr %st31
  %v37.p = getelementptr i64, ptr %v33, i64 0
  %v37 = load i64, ptr %v37.p
  %st32 = getelementptr i64, ptr %v0, i64 0
  store i64 %v37, ptr %st32
  %v38.p = getelementptr i64, ptr %v33, i64 1
  %v38 = load i64, ptr %v38.p
  %st33 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st33
  %v39.p = getelementptr i64, ptr %v33, i64 2
  %v39 = load i64, ptr %v39.p
  %st34 = getelementptr i64, ptr %v0, i64 2
  store i64 %v39, ptr %st34
  %v40.p = getelementptr i64, ptr %v33, i64 3
  %v40 = load i64, ptr %v40.p
  %st35 = getelementptr i64, ptr %v0, i64 3
  store i64 %v40, ptr %st35
  %v41.p = getelementptr i64, ptr %v33, i64 4
  %v41 = load i64, ptr %v41.p
  %st36 = getelementptr i64, ptr %v0, i64 4
  store i64 %v41, ptr %st36
  %v42 = add i64 0, 2
  %v43 = getelementptr i64, ptr %v0, i64 %v42
  %v61 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v43, i64 %v61, i64 %v2)
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v62, i64 0
  store i64 %v2, ptr %st37
  ret void
b11:
  br label %b12
b12:
  %v44 = getelementptr i64, ptr %s0, i64 0
  %v45 = add i64 0, 0
  %st38 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st38
  %st39 = getelementptr i64, ptr %v44, i64 1
  store i64 %v45, ptr %st39
  %v46 = add i64 0, 5
  %st40 = getelementptr i64, ptr %v44, i64 0
  store i64 %v46, ptr %st40
  %st41 = getelementptr i64, ptr %v44, i64 1
  store i64 %v1, ptr %st41
  %v47 = getelementptr i64, ptr %s1, i64 0
  %v48.p = getelementptr i64, ptr %v44, i64 0
  %v48 = load i64, ptr %v48.p
  %st42 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st42
  %v49.p = getelementptr i64, ptr %v44, i64 1
  %v49 = load i64, ptr %v49.p
  %st43 = getelementptr i64, ptr %v47, i64 1
  store i64 %v49, ptr %st43
  %v50 = add i64 0, 0
  %st44 = getelementptr i64, ptr %v47, i64 2
  store i64 %v50, ptr %st44
  %st45 = getelementptr i64, ptr %v47, i64 3
  store i64 %v50, ptr %st45
  %st46 = getelementptr i64, ptr %v47, i64 4
  store i64 %v50, ptr %st46
  %v51.p = getelementptr i64, ptr %v47, i64 0
  %v51 = load i64, ptr %v51.p
  %st47 = getelementptr i64, ptr %v0, i64 0
  store i64 %v51, ptr %st47
  %v52.p = getelementptr i64, ptr %v47, i64 1
  %v52 = load i64, ptr %v52.p
  %st48 = getelementptr i64, ptr %v0, i64 1
  store i64 %v52, ptr %st48
  %v53.p = getelementptr i64, ptr %v47, i64 2
  %v53 = load i64, ptr %v53.p
  %st49 = getelementptr i64, ptr %v0, i64 2
  store i64 %v53, ptr %st49
  %v54.p = getelementptr i64, ptr %v47, i64 3
  %v54 = load i64, ptr %v54.p
  %st50 = getelementptr i64, ptr %v0, i64 3
  store i64 %v54, ptr %st50
  %v55.p = getelementptr i64, ptr %v47, i64 4
  %v55 = load i64, ptr %v55.p
  %st51 = getelementptr i64, ptr %v0, i64 4
  store i64 %v55, ptr %st51
  %v56 = add i64 0, 2
  %v57 = getelementptr i64, ptr %v0, i64 %v56
  %v63 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v57, i64 %v63, i64 %v2)
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v64, i64 0
  store i64 %v2, ptr %st52
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
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v74, i64 0
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
  %v10 = add i64 0, 0
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
  %v20 = add i64 0, 2
  %v21 = getelementptr i64, ptr %v0, i64 %v20
  %v75 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v21, i64 %v75, i64 %v2)
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v76, i64 0
  store i64 %v2, ptr %st17
  ret void
b4:
  br label %b5
b5:
  %v22 = add i64 0, 13
  %v23.c = icmp eq i64 %v1, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b5 = icmp ne i64 %v23, 0
  br i1 %c.b5, label %b5.t19, label %b5.e20
b5.t19:
  br label %b7
b5.e20:
  br label %b6
b6:
  %v25 = add i64 0, 1
  %v26.c = icmp eq i64 %v1, %v25
  %v26 = zext i1 %v26.c to i64
  br label %b7
b7:
  %v24 = phi i64 [ %v23, %b5.t19 ], [ %v26, %b6 ]
  %c.b7 = icmp ne i64 %v24, 0
  br i1 %c.b7, label %b7.t21, label %b7.e22
b7.t21:
  br label %b9
b7.e22:
  br label %b8
b8:
  %v28 = add i64 0, 30
  %v29.c = icmp eq i64 %v1, %v28
  %v29 = zext i1 %v29.c to i64
  br label %b9
b9:
  %v27 = phi i64 [ %v24, %b7.t21 ], [ %v29, %b8 ]
  %c.b9 = icmp ne i64 %v27, 0
  br i1 %c.b9, label %b9.t23, label %b9.e24
b9.t23:
  br label %b10
b9.e24:
  br label %b11
b10:
  %v30 = getelementptr i64, ptr %s0, i64 0
  %v31 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st24
  %st25 = getelementptr i64, ptr %v30, i64 1
  store i64 %v31, ptr %st25
  %v32 = add i64 0, 1
  %st26 = getelementptr i64, ptr %v30, i64 0
  store i64 %v32, ptr %st26
  %v33 = getelementptr i64, ptr %s1, i64 0
  %v34.p = getelementptr i64, ptr %v30, i64 0
  %v34 = load i64, ptr %v34.p
  %st27 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st27
  %v35.p = getelementptr i64, ptr %v30, i64 1
  %v35 = load i64, ptr %v35.p
  %st28 = getelementptr i64, ptr %v33, i64 1
  store i64 %v35, ptr %st28
  %v36 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v33, i64 2
  store i64 %v36, ptr %st29
  %st30 = getelementptr i64, ptr %v33, i64 3
  store i64 %v36, ptr %st30
  %st31 = getelementptr i64, ptr %v33, i64 4
  store i64 %v36, ptr %st31
  %v37.p = getelementptr i64, ptr %v33, i64 0
  %v37 = load i64, ptr %v37.p
  %st32 = getelementptr i64, ptr %v0, i64 0
  store i64 %v37, ptr %st32
  %v38.p = getelementptr i64, ptr %v33, i64 1
  %v38 = load i64, ptr %v38.p
  %st33 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st33
  %v39.p = getelementptr i64, ptr %v33, i64 2
  %v39 = load i64, ptr %v39.p
  %st34 = getelementptr i64, ptr %v0, i64 2
  store i64 %v39, ptr %st34
  %v40.p = getelementptr i64, ptr %v33, i64 3
  %v40 = load i64, ptr %v40.p
  %st35 = getelementptr i64, ptr %v0, i64 3
  store i64 %v40, ptr %st35
  %v41.p = getelementptr i64, ptr %v33, i64 4
  %v41 = load i64, ptr %v41.p
  %st36 = getelementptr i64, ptr %v0, i64 4
  store i64 %v41, ptr %st36
  %v42 = add i64 0, 2
  %v43 = getelementptr i64, ptr %v0, i64 %v42
  %v77 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v43, i64 %v77, i64 %v2)
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v78, i64 0
  store i64 %v2, ptr %st37
  ret void
b11:
  br label %b12
b12:
  %v44 = add i64 0, 110
  %v45.c = icmp eq i64 %v1, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b12 = icmp ne i64 %v45, 0
  br i1 %c.b12, label %b12.t39, label %b12.e40
b12.t39:
  br label %b13
b12.e40:
  br label %b14
b13:
  %v46 = getelementptr i64, ptr %s0, i64 0
  %v47 = add i64 0, 0
  %st40 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st40
  %st41 = getelementptr i64, ptr %v46, i64 1
  store i64 %v47, ptr %st41
  %v48 = add i64 0, 2
  %st42 = getelementptr i64, ptr %v46, i64 0
  store i64 %v48, ptr %st42
  %v49 = getelementptr i64, ptr %s1, i64 0
  %v50.p = getelementptr i64, ptr %v46, i64 0
  %v50 = load i64, ptr %v50.p
  %st43 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st43
  %v51.p = getelementptr i64, ptr %v46, i64 1
  %v51 = load i64, ptr %v51.p
  %st44 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st44
  %v52 = add i64 0, 0
  %st45 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st45
  %st46 = getelementptr i64, ptr %v49, i64 3
  store i64 %v52, ptr %st46
  %st47 = getelementptr i64, ptr %v49, i64 4
  store i64 %v52, ptr %st47
  %v53.p = getelementptr i64, ptr %v49, i64 0
  %v53 = load i64, ptr %v53.p
  %st48 = getelementptr i64, ptr %v0, i64 0
  store i64 %v53, ptr %st48
  %v54.p = getelementptr i64, ptr %v49, i64 1
  %v54 = load i64, ptr %v54.p
  %st49 = getelementptr i64, ptr %v0, i64 1
  store i64 %v54, ptr %st49
  %v55.p = getelementptr i64, ptr %v49, i64 2
  %v55 = load i64, ptr %v55.p
  %st50 = getelementptr i64, ptr %v0, i64 2
  store i64 %v55, ptr %st50
  %v56.p = getelementptr i64, ptr %v49, i64 3
  %v56 = load i64, ptr %v56.p
  %st51 = getelementptr i64, ptr %v0, i64 3
  store i64 %v56, ptr %st51
  %v57.p = getelementptr i64, ptr %v49, i64 4
  %v57 = load i64, ptr %v57.p
  %st52 = getelementptr i64, ptr %v0, i64 4
  store i64 %v57, ptr %st52
  %v58 = add i64 0, 2
  %v59 = getelementptr i64, ptr %v0, i64 %v58
  %v79 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v59, i64 %v79, i64 %v2)
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v80, i64 0
  store i64 %v2, ptr %st53
  ret void
b14:
  br label %b15
b15:
  %v60 = getelementptr i64, ptr %s0, i64 0
  %v61 = add i64 0, 0
  %st54 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st54
  %st55 = getelementptr i64, ptr %v60, i64 1
  store i64 %v61, ptr %st55
  %v62 = add i64 0, 5
  %st56 = getelementptr i64, ptr %v60, i64 0
  store i64 %v62, ptr %st56
  %st57 = getelementptr i64, ptr %v60, i64 1
  store i64 %v1, ptr %st57
  %v63 = getelementptr i64, ptr %s1, i64 0
  %v64.p = getelementptr i64, ptr %v60, i64 0
  %v64 = load i64, ptr %v64.p
  %st58 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st58
  %v65.p = getelementptr i64, ptr %v60, i64 1
  %v65 = load i64, ptr %v65.p
  %st59 = getelementptr i64, ptr %v63, i64 1
  store i64 %v65, ptr %st59
  %v66 = add i64 0, 0
  %st60 = getelementptr i64, ptr %v63, i64 2
  store i64 %v66, ptr %st60
  %st61 = getelementptr i64, ptr %v63, i64 3
  store i64 %v66, ptr %st61
  %st62 = getelementptr i64, ptr %v63, i64 4
  store i64 %v66, ptr %st62
  %v67.p = getelementptr i64, ptr %v63, i64 0
  %v67 = load i64, ptr %v67.p
  %st63 = getelementptr i64, ptr %v0, i64 0
  store i64 %v67, ptr %st63
  %v68.p = getelementptr i64, ptr %v63, i64 1
  %v68 = load i64, ptr %v68.p
  %st64 = getelementptr i64, ptr %v0, i64 1
  store i64 %v68, ptr %st64
  %v69.p = getelementptr i64, ptr %v63, i64 2
  %v69 = load i64, ptr %v69.p
  %st65 = getelementptr i64, ptr %v0, i64 2
  store i64 %v69, ptr %st65
  %v70.p = getelementptr i64, ptr %v63, i64 3
  %v70 = load i64, ptr %v70.p
  %st66 = getelementptr i64, ptr %v0, i64 3
  store i64 %v70, ptr %st66
  %v71.p = getelementptr i64, ptr %v63, i64 4
  %v71 = load i64, ptr %v71.p
  %st67 = getelementptr i64, ptr %v0, i64 4
  store i64 %v71, ptr %st67
  %v72 = add i64 0, 2
  %v73 = getelementptr i64, ptr %v0, i64 %v72
  %v81 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v73, i64 %v81, i64 %v2)
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v82, i64 0
  store i64 %v2, ptr %st68
  ret void
}

define internal i64 @"std/io.le64"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v2, ptr %st2
  %v33 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v33, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 0
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v6, ptr %st3
  %v8 = add i64 0, 7
  %v9 = add i64 %v3, %v8
  %v10 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v10, i64 0
  store i64 %v9, ptr %st4
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v34, i64 0
  %v11 = load i64, ptr %v11.p
  br label %b1
b1:
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v35, i64 0
  store i64 %v11, ptr %st5
  %v12.p = getelementptr i64, ptr %v10, i64 0
  %v12 = load i64, ptr %v12.p
  %v13.c = icmp sge i64 %v12, %v3
  %v13 = zext i1 %v13.c to i64
  %c.b1 = icmp ne i64 %v13, 0
  br i1 %c.b1, label %b1.t7, label %b1.e8
b1.t7:
  br label %b2
b1.e8:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v36, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 0, 1
  %v16 = add i64 %v5, %v15
  %v17.p = getelementptr i64, ptr %v7, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 256
  %v19 = mul i64 %v17, %v18
  %v20.p = getelementptr i64, ptr %v10, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v4, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.c = icmp uge i64 %v20, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b2 = icmp ne i64 %v22, 0
  br i1 %c.b2, label %b2.t9, label %b2.e10
b2.t9:
  br label %b4
b2.e10:
  br label %b5
b3:
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v37, i64 0
  store i64 %v11, ptr %st10
  %v32.p = getelementptr i64, ptr %v7, i64 0
  %v32 = load i64, ptr %v32.p
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v38, i64 0
  store i64 %v5, ptr %st11
  ret i64 %v32
b4:
  %v23 = add i64 0, 5
  call void @"rt.panic"(i64 %v23)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v24.p = getelementptr i64, ptr %v4, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = inttoptr i64 %v24 to ptr
  %v26 = getelementptr i8, ptr %v25, i64 %v20
  %v27.p = getelementptr i8, ptr %v26, i64 0
  %v27.b = load i8, ptr %v27.p
  %v27 = zext i8 %v27.b to i64
  %v28 = add i64 %v19, %v27
  %st12 = getelementptr i64, ptr %v7, i64 0
  store i64 %v28, ptr %st12
  %v29 = add i64 0, 1
  %v30.p = getelementptr i64, ptr %v10, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = sub i64 %v30, %v29
  %st13 = getelementptr i64, ptr %v10, i64 0
  store i64 %v31, ptr %st13
  br label %b1
}

define internal void @"std/io.kindOf"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v25 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v25, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 8
  %v4.c = icmp eq i64 %v1, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = getelementptr i64, ptr %s0, i64 0
  %v6 = add i64 0, 0
  %st2 = getelementptr i64, ptr %v5, i64 0
  store i64 %v6, ptr %st2
  %v7 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v5, i64 0
  store i64 %v7, ptr %st3
  %v8.p = getelementptr i64, ptr %v5, i64 0
  %v8 = load i64, ptr %v8.p
  %st4 = getelementptr i64, ptr %v0, i64 0
  store i64 %v8, ptr %st4
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v26, i64 0
  store i64 %v2, ptr %st5
  ret void
b2:
  br label %b3
b3:
  %v9 = add i64 0, 4
  %v10.c = icmp eq i64 %v1, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b3 = icmp ne i64 %v10, 0
  br i1 %c.b3, label %b3.t7, label %b3.e8
b3.t7:
  br label %b4
b3.e8:
  br label %b5
b4:
  %v11 = getelementptr i64, ptr %s0, i64 0
  %v12 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st8
  %v13 = add i64 0, 1
  %st9 = getelementptr i64, ptr %v11, i64 0
  store i64 %v13, ptr %st9
  %v14.p = getelementptr i64, ptr %v11, i64 0
  %v14 = load i64, ptr %v14.p
  %st10 = getelementptr i64, ptr %v0, i64 0
  store i64 %v14, ptr %st10
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v27, i64 0
  store i64 %v2, ptr %st11
  ret void
b5:
  br label %b6
b6:
  %v15 = add i64 0, 10
  %v16.c = icmp eq i64 %v1, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b6 = icmp ne i64 %v16, 0
  br i1 %c.b6, label %b6.t13, label %b6.e14
b6.t13:
  br label %b7
b6.e14:
  br label %b8
b7:
  %v17 = getelementptr i64, ptr %s0, i64 0
  %v18 = add i64 0, 0
  %st14 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st14
  %v19 = add i64 0, 2
  %st15 = getelementptr i64, ptr %v17, i64 0
  store i64 %v19, ptr %st15
  %v20.p = getelementptr i64, ptr %v17, i64 0
  %v20 = load i64, ptr %v20.p
  %st16 = getelementptr i64, ptr %v0, i64 0
  store i64 %v20, ptr %st16
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v28, i64 0
  store i64 %v2, ptr %st17
  ret void
b8:
  br label %b9
b9:
  %v21 = getelementptr i64, ptr %s0, i64 0
  %v22 = add i64 0, 0
  %st18 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st18
  %v23 = add i64 0, 3
  %st19 = getelementptr i64, ptr %v21, i64 0
  store i64 %v23, ptr %st19
  %v24.p = getelementptr i64, ptr %v21, i64 0
  %v24 = load i64, ptr %v24.p
  %st20 = getelementptr i64, ptr %v0, i64 0
  store i64 %v24, ptr %st20
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v29, i64 0
  store i64 %v2, ptr %st21
  ret void
}

define internal void @"std/io.cstr"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v115 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v115, i64 0
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
  %v116 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v116, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %v12 = call ptr @"rt.region_alloc8"(i64 %v10, i64 %v11)
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15 = ptrtoint ptr %v12 to i64
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 1
  store i64 %v13, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 2
  store i64 %v10, ptr %st8
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v14, i64 0
  %v17 = load i64, ptr %v17.p
  %st9 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st9
  %v18.p = getelementptr i64, ptr %v14, i64 1
  %v18 = load i64, ptr %v18.p
  %st10 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st10
  %v19.p = getelementptr i64, ptr %v14, i64 2
  %v19 = load i64, ptr %v19.p
  %st11 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st11
  %v20 = add i64 0, 0
  %v21 = getelementptr i64, ptr %s4, i64 0
  %st12 = getelementptr i64, ptr %v21, i64 0
  store i64 %v20, ptr %st12
  %v117 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v117, i64 0
  %v22 = load i64, ptr %v22.p
  br label %b1
b1:
  %v118 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v118, i64 0
  store i64 %v22, ptr %st13
  %v23.p = getelementptr i64, ptr %v21, i64 0
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v6, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp slt i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b1 = icmp ne i64 %v25, 0
  br i1 %c.b1, label %b1.t15, label %b1.e16
b1.t15:
  br label %b2
b1.e16:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v119 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v119, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v21, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v6, i64 1
  %v28 = load i64, ptr %v28.p
  %v29.c = icmp uge i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b2 = icmp ne i64 %v29, 0
  br i1 %c.b2, label %b2.t17, label %b2.e18
b2.t17:
  br label %b4
b2.e18:
  br label %b5
b3:
  %v120 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v120, i64 0
  store i64 %v22, ptr %st18
  %v85 = getelementptr i64, ptr %s5, i64 0
  %v86.p = getelementptr i64, ptr %v16, i64 0
  %v86 = load i64, ptr %v86.p
  %st19 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st19
  %v87.p = getelementptr i64, ptr %v16, i64 1
  %v87 = load i64, ptr %v87.p
  %st20 = getelementptr i64, ptr %v85, i64 1
  store i64 %v87, ptr %st20
  %v88.p = getelementptr i64, ptr %v16, i64 2
  %v88 = load i64, ptr %v88.p
  %st21 = getelementptr i64, ptr %v85, i64 2
  store i64 %v88, ptr %st21
  %v89 = add i64 0, 0
  %v90.p = getelementptr i64, ptr %v85, i64 2
  %v90 = load i64, ptr %v90.p
  %v91.p = getelementptr i64, ptr %v85, i64 0
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v85, i64 1
  %v92 = load i64, ptr %v92.p
  %v95 = add i64 %v91, %v92
  %v96 = call i64 @"rt.tip8"(i64 %v90, i64 %v95)
  %v97 = add i64 0, 0
  %v98.c = icmp ne i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b3 = icmp ne i64 %v98, 0
  br i1 %c.b3, label %b3.t23, label %b3.e24
b3.t23:
  br label %b16
b3.e24:
  br label %b15
b4:
  %v30 = add i64 0, 6
  call void @"rt.panic"(i64 %v30)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v31.p = getelementptr i64, ptr %v6, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = inttoptr i64 %v31 to ptr
  %v33 = getelementptr i8, ptr %v32, i64 %v27
  %v34.p = getelementptr i8, ptr %v33, i64 0
  %v34.b = load i8, ptr %v34.p
  %v34 = zext i8 %v34.b to i64
  %v35 = add i64 0, 0
  %v36.c = icmp eq i64 %v34, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b5 = icmp ne i64 %v36, 0
  br i1 %c.b5, label %b5.t25, label %b5.e26
b5.t25:
  br label %b6
b5.e26:
  br label %b7
b6:
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v121, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 0
  %v39 = call ptr @"rt.region_alloc8"(i64 %v37, i64 %v38)
  %v40 = add i64 0, 0
  %v41 = getelementptr i64, ptr %s2, i64 0
  %v42 = ptrtoint ptr %v39 to i64
  %st26 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st26
  %st27 = getelementptr i64, ptr %v41, i64 1
  store i64 %v40, ptr %st27
  %st28 = getelementptr i64, ptr %v41, i64 2
  store i64 %v37, ptr %st28
  %v43.p = getelementptr i64, ptr %v41, i64 0
  %v43 = load i64, ptr %v43.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v43, ptr %st29
  %v44.p = getelementptr i64, ptr %v41, i64 1
  %v44 = load i64, ptr %v44.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v44, ptr %st30
  %v45.p = getelementptr i64, ptr %v41, i64 2
  %v45 = load i64, ptr %v45.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v45, ptr %st31
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v122, i64 0
  store i64 %v5, ptr %st32
  ret void
b7:
  br label %b8
b8:
  %v46 = add i64 0, 1
  %v47 = add i64 %v5, %v46
  %v48 = getelementptr i64, ptr %s2, i64 0
  %v49.p = getelementptr i64, ptr %v16, i64 0
  %v49 = load i64, ptr %v49.p
  %st33 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st33
  %v50.p = getelementptr i64, ptr %v16, i64 1
  %v50 = load i64, ptr %v50.p
  %st34 = getelementptr i64, ptr %v48, i64 1
  store i64 %v50, ptr %st34
  %v51.p = getelementptr i64, ptr %v16, i64 2
  %v51 = load i64, ptr %v51.p
  %st35 = getelementptr i64, ptr %v48, i64 2
  store i64 %v51, ptr %st35
  %v52.p = getelementptr i64, ptr %v21, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v6, i64 1
  %v53 = load i64, ptr %v53.p
  %v54.c = icmp uge i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b8 = icmp ne i64 %v54, 0
  br i1 %c.b8, label %b8.t37, label %b8.e38
b8.t37:
  br label %b9
b8.e38:
  br label %b10
b9:
  %v55 = add i64 0, 7
  call void @"rt.panic"(i64 %v55)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v56.p = getelementptr i64, ptr %v6, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = inttoptr i64 %v56 to ptr
  %v58 = getelementptr i8, ptr %v57, i64 %v52
  %v59.p = getelementptr i8, ptr %v58, i64 0
  %v59.b = load i8, ptr %v59.p
  %v59 = zext i8 %v59.b to i64
  %v60.p = getelementptr i64, ptr %v48, i64 2
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v48, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v48, i64 1
  %v62 = load i64, ptr %v62.p
  %v65 = add i64 %v61, %v62
  %v66 = call i64 @"rt.tip8"(i64 %v60, i64 %v65)
  %v67 = add i64 0, 0
  %v68.c = icmp ne i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b10 = icmp ne i64 %v68, 0
  br i1 %c.b10, label %b10.t39, label %b10.e40
b10.t39:
  br label %b13
b10.e40:
  br label %b12
b11:
  %v63 = phi ptr [ %v72, %b12 ], [ %v69, %b13 ]
  %v64 = phi ptr [ %v73, %b12 ], [ %v70, %b13 ]
  %st40 = getelementptr i8, ptr %v64, i64 0
  %st40.b = trunc i64 %v59 to i8
  store i8 %st40.b, ptr %st40
  %v74.p = getelementptr i64, ptr %v48, i64 1
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 1
  %v76 = add i64 %v74, %v75
  %v77 = getelementptr i64, ptr %s5, i64 0
  %v78 = ptrtoint ptr %v63 to i64
  %st41 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st41
  %st42 = getelementptr i64, ptr %v77, i64 1
  store i64 %v76, ptr %st42
  %st43 = getelementptr i64, ptr %v77, i64 2
  store i64 %v60, ptr %st43
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %st44 = getelementptr i64, ptr %v16, i64 0
  store i64 %v79, ptr %st44
  %v80.p = getelementptr i64, ptr %v77, i64 1
  %v80 = load i64, ptr %v80.p
  %st45 = getelementptr i64, ptr %v16, i64 1
  store i64 %v80, ptr %st45
  %v81.p = getelementptr i64, ptr %v77, i64 2
  %v81 = load i64, ptr %v81.p
  %st46 = getelementptr i64, ptr %v16, i64 2
  store i64 %v81, ptr %st46
  %v82 = add i64 0, 1
  %v83.p = getelementptr i64, ptr %v21, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 %v83, %v82
  %st47 = getelementptr i64, ptr %v21, i64 0
  store i64 %v84, ptr %st47
  br label %b1
b12:
  %v71 = add i64 0, 1
  %v72 = call ptr @"rt.slice_grow8"(i64 %v61, i64 %v62, i64 %v60, i64 %v71)
  %v73 = getelementptr i8, ptr %v72, i64 %v62
  br label %b11
b13:
  %v69 = inttoptr i64 %v61 to ptr
  %v70 = getelementptr i8, ptr %v69, i64 %v62
  br label %b11
b14:
  %v93 = phi ptr [ %v102, %b15 ], [ %v99, %b16 ]
  %v94 = phi ptr [ %v103, %b15 ], [ %v100, %b16 ]
  %st48 = getelementptr i8, ptr %v94, i64 0
  %st48.b = trunc i64 %v89 to i8
  store i8 %st48.b, ptr %st48
  %v104.p = getelementptr i64, ptr %v85, i64 1
  %v104 = load i64, ptr %v104.p
  %v105 = add i64 0, 1
  %v106 = add i64 %v104, %v105
  %v107 = getelementptr i64, ptr %s2, i64 0
  %v108 = ptrtoint ptr %v93 to i64
  %st49 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st49
  %st50 = getelementptr i64, ptr %v107, i64 1
  store i64 %v106, ptr %st50
  %st51 = getelementptr i64, ptr %v107, i64 2
  store i64 %v90, ptr %st51
  %v109.p = getelementptr i64, ptr %v107, i64 0
  %v109 = load i64, ptr %v109.p
  %st52 = getelementptr i64, ptr %v16, i64 0
  store i64 %v109, ptr %st52
  %v110.p = getelementptr i64, ptr %v107, i64 1
  %v110 = load i64, ptr %v110.p
  %st53 = getelementptr i64, ptr %v16, i64 1
  store i64 %v110, ptr %st53
  %v111.p = getelementptr i64, ptr %v107, i64 2
  %v111 = load i64, ptr %v111.p
  %st54 = getelementptr i64, ptr %v16, i64 2
  store i64 %v111, ptr %st54
  %v112.p = getelementptr i64, ptr %v16, i64 0
  %v112 = load i64, ptr %v112.p
  %st55 = getelementptr i64, ptr %v0, i64 0
  store i64 %v112, ptr %st55
  %v113.p = getelementptr i64, ptr %v16, i64 1
  %v113 = load i64, ptr %v113.p
  %st56 = getelementptr i64, ptr %v0, i64 1
  store i64 %v113, ptr %st56
  %v114.p = getelementptr i64, ptr %v16, i64 2
  %v114 = load i64, ptr %v114.p
  %st57 = getelementptr i64, ptr %v0, i64 2
  store i64 %v114, ptr %st57
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v123, i64 0
  store i64 %v5, ptr %st58
  ret void
b15:
  %v101 = add i64 0, 1
  %v102 = call ptr @"rt.slice_grow8"(i64 %v91, i64 %v92, i64 %v90, i64 %v101)
  %v103 = getelementptr i8, ptr %v102, i64 %v92
  br label %b14
b16:
  %v99 = inttoptr i64 %v91 to ptr
  %v100 = getelementptr i8, ptr %v99, i64 %v92
  br label %b14
}

define internal i64 @"std/io.owned"(i64 %v0) #0 {
b0:
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v17, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = add i64 0, 0
  %v3.c = icmp slt i64 %v0, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v18, i64 0
  store i64 %v1, ptr %st2
  ret i64 %v0
b2:
  br label %b3
b3:
  %v4 = add i64 0, 65536
  %v5.c = icmp sge i64 %v0, %v4
  %v5 = zext i1 %v5.c to i64
  %c.b3 = icmp ne i64 %v5, 0
  br i1 %c.b3, label %b3.t4, label %b3.e5
b3.t4:
  br label %b4
b3.e5:
  br label %b5
b4:
  %v6 = add i64 0, 3
  %v7 = add i64 0, 0
  %v8 = add i64 0, 0
  %v9 = add i64 0, 0
  %v10 = add i64 0, 0
  %v11 = add i64 0, 0
  %v12 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v6, i64 %v0, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11)
  %v13 = add i64 0, 24
  %v14 = add i64 0, 0
  %v15 = sub i64 %v14, %v13
  %v19 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v19, i64 0
  store i64 %v1, ptr %st5
  ret i64 %v15
b5:
  br label %b6
b6:
  %v16 = add i64 0, 0
  %v20 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v20, i64 0
  store i64 %v1, ptr %st6
  ret i64 %v0
}

define internal i64 @"rt.run"(ptr %v0) #0 {
b0:
  call void @"rt.flush"()
  %v1.p = getelementptr i64, ptr %v0, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = inttoptr i64 %v1 to ptr
  %v3.p = getelementptr i64, ptr %v0, i64 1
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.iobuf", i64 0
  %v9 = add i64 0, 0
  %v10 = add i64 0, 0
  %v11 = add i64 0, 1
  br label %b1
b1:
  %v5 = phi i64 [ %v9, %b0 ], [ %v25, %b8 ], [ %v25, %b9 ]
  %v6 = phi i64 [ %v10, %b0 ], [ %v13, %b8 ], [ %v13, %b9 ]
  %v7 = phi i64 [ %v11, %b0 ], [ %v30, %b8 ], [ %v31, %b9 ]
  %v12.c = icmp slt i64 %v5, %v3
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b3
b2:
  %v14 = add i64 0, 0
  %v15.c = icmp ne i64 %v7, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b2 = icmp ne i64 %v15, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b5
b2.e4:
  br label %b4
b3:
  %v8 = phi i64 [ %v6, %b1.e2 ]
  %v32 = getelementptr i64, ptr %v4, i64 %v8
  %v33 = add i64 0, 0
  %st4 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st4
  %v34 = add i64 0, 0
  %v35.c = icmp eq i64 %v8, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b3 = icmp ne i64 %v35, 0
  br i1 %c.b3, label %b3.t6, label %b3.e7
b3.t6:
  br label %b10
b3.e7:
  br label %b11
b4:
  %v13 = phi i64 [ %v6, %b2.e4 ], [ %v23, %b7 ]
  %v24 = add i64 0, 1
  %v25 = add i64 %v5, %v24
  %v26 = getelementptr i8, ptr %v2, i64 %v5
  %v27.p = getelementptr i8, ptr %v26, i64 0
  %v27.b = load i8, ptr %v27.p
  %v27 = zext i8 %v27.b to i64
  %v28 = add i64 0, 0
  %v29.c = icmp eq i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b4 = icmp ne i64 %v29, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b8
b4.e9:
  br label %b9
b5:
  %v16 = add i64 0, 511
  %v17.c = icmp sge i64 %v6, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b5 = icmp ne i64 %v17, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b6
b5.e11:
  br label %b7
b6:
  %v18 = add i64 0, -7
  ret i64 %v18
b7:
  %v19 = getelementptr i64, ptr %v4, i64 %v6
  %v20 = getelementptr i8, ptr %v2, i64 %v5
  %v21 = ptrtoint ptr %v20 to i64
  %st11 = getelementptr i64, ptr %v19, i64 0
  store i64 %v21, ptr %st11
  %v22 = add i64 0, 1
  %v23 = add i64 %v6, %v22
  br label %b4
b8:
  %v30 = add i64 0, 1
  br label %b1
b9:
  %v31 = add i64 0, 0
  br label %b1
b10:
  %v36 = add i64 0, -22
  ret i64 %v36
b11:
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v37, i64 2568
  %v38 = load i64, ptr %v38.p
  %v39 = inttoptr i64 %v38 to ptr
  %v40.p = getelementptr i64, ptr %v39, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 2
  %v42 = add i64 %v40, %v41
  %v43 = getelementptr i64, ptr %v39, i64 %v42
  %v44 = add i64 0, 57
  %v45 = call i64 asm sideeffect "syscall", "={rax},{rax},~{rcx},~{r11},~{memory}"(i64 %v44)
  %v46 = add i64 0, 0
  %v47.c = icmp slt i64 %v45, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b11 = icmp ne i64 %v47, 0
  br i1 %c.b11, label %b11.t13, label %b11.e14
b11.t13:
  br label %b12
b11.e14:
  br label %b13
b12:
  ret i64 %v45
b13:
  %v48 = add i64 0, 0
  %v49.c = icmp eq i64 %v45, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b13 = icmp ne i64 %v49, 0
  br i1 %c.b13, label %b13.t15, label %b13.e16
b13.t15:
  br label %b14
b13.e16:
  br label %b15
b14:
  %v50 = add i64 0, 59
  %v51.p = getelementptr i64, ptr %v4, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = ptrtoint ptr %v4 to i64
  %v53 = ptrtoint ptr %v43 to i64
  %v54 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v50, i64 %v51, i64 %v52, i64 %v53)
  %v55 = add i64 0, 231
  %v56 = add i64 0, 127
  %v57 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v55, i64 %v56)
  %v58 = add i64 0, 127
  ret i64 %v58
b15:
  %v59 = add i64 0, 0
  %st16 = getelementptr i64, ptr %v4, i64 0
  store i64 %v59, ptr %st16
  %v60 = add i64 0, 61
  %v61 = ptrtoint ptr %v4 to i64
  %v62 = add i64 0, 0
  %v63 = add i64 0, 0
  %v64 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v60, i64 %v45, i64 %v61, i64 %v62, i64 %v63)
  %v65 = add i64 0, 0
  %v66.c = icmp slt i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b15 = icmp ne i64 %v66, 0
  br i1 %c.b15, label %b15.t18, label %b15.e19
b15.t18:
  br label %b16
b15.e19:
  br label %b17
b16:
  ret i64 %v64
b17:
  %v67.p = getelementptr i64, ptr %v4, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 127
  %v69 = and i64 %v67, %v68
  %v70 = add i64 0, 0
  %v71.c = icmp ne i64 %v69, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b17 = icmp ne i64 %v71, 0
  br i1 %c.b17, label %b17.t20, label %b17.e21
b17.t20:
  br label %b18
b17.e21:
  br label %b19
b18:
  %v72 = add i64 0, 128
  %v73 = add i64 %v69, %v72
  ret i64 %v73
b19:
  %v74 = add i64 0, 256
  %v75 = sdiv i64 %v67, %v74
  %v76 = add i64 0, 255
  %v77 = and i64 %v75, %v76
  ret i64 %v77
}
