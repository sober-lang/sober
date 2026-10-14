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
@"str.0" = internal constant [4 x i64] [i64 7022344803055789428, i64 3418902202392996143, i64 3759788203383677793, i64 1735355438]
@"str.1" = internal constant [3 x i64] [i64 7022344803055789428, i64 7812730951727802671, i64 500237086319]
@"str.2" = internal constant [3 x i64] [i64 7022344803055789428, i64 8390326387146189103, i64 500237086329]
@"str.3" = internal constant [1 x i64] [i64 8250]
@"str.4" = internal constant [1 x i64] [i64 2318354787771965984]
@"str.5" = internal constant [2 x i64] [i64 7308895159849414176, i64 2108531]
@"str.6" = internal constant [1 x i64] [i64 32487744482075424]
@"str.7" = internal constant [3 x i64] [i64 7022344803055789428, i64 7380399659676559663, i64 1954051118]
@"str.8" = internal constant [1 x i64] [i64 8224]
@"str.9" = internal constant [1 x i64] [i64 2318354787670256672]
@"str.10" = internal constant [1 x i64] [i64 126879583003168]
@"str.11" = internal constant [3 x i64] [i64 7307218078149928299, i64 8295758552806024736, i64 138419662700]
@"str.12" = internal constant [1 x i64] [i64 1702195828]
@"str.13" = internal constant [1 x i64] [i64 435728179558]
@"str.14" = internal constant [1 x i64] [i64 35705882567013]
@"str.15" = internal constant [3 x i64] [i64 7234307576302018618, i64 2334386829831072032, i64 2036625250]
@"str.16" = internal constant [1 x i64] [i64 4137018]
@"str.17" = internal constant [3 x i64] [i64 7022344803055789428, i64 8319108854351620399, i64 32783537688505961]
@"str.18" = internal constant [3 x i64] [i64 4208453775988582765, i64 8462094514430897696, i64 25710]
@"str.19" = internal constant [2 x i64] [i64 4208453775988582765, i64 16160]
@"str.20" = internal constant [1 x i64] [i64 63]
@"str.21" = internal constant [1 x i64] [i64 5972000]
@"str.22" = internal constant [1 x i64] [i64 93]
@"str.23" = internal constant [0 x i64] zeroinitializer
@"str.24" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.25" = internal constant [1 x i64] [i64 45]
@"str.26" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.27" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.28" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.29" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.30" = internal constant [1 x i64] [i64 2685]
@"str.31" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.32" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.33" = internal constant [1 x i64] [i64 35899498962976]
@"str.34" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.35" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [30 x i64] [i64 3659174898565121, i64 3659174898565121, i64 8162775364796673, i64 10977525131903233, i64 9570152462942721, i64 12384902347489793, i64 11259002541310466, i64 11259002541310466, i64 11259002541310466, i64 15199652248814082, i64 15199652248814082, i64 15199652248814082, i64 3659174898565121, i64 3659174898565121, i64 8444250140181249, i64 5348025530581761, i64 16607024615785217, i64 19984724403421953, i64 28428973704741633, i64 4222125019759361, i64 8725724563243777, i64 14073749120746241, i64 6473928222441985, i64 4785078378955266, i64 4785078378955266, i64 4785078378955266, i64 7599826921325571, i64 8725726878499843, i64 8444252002452481, i64 3659174898565121]
@"str.36" = internal constant [1 x i64] [i64 9071397899755888]
@"str.37" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.38" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.39" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.40" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.41" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.42" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.43" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.44" = internal constant [1 x i64] [i64 544497952]
@"str.45" = internal constant [3 x i64] [i64 8243122688087061619, i64 8030813629395003695, i64 7497058]
@"str.46" = internal constant [2 x i64] [i64 7741253900700708713, i64 32199620796034675]
@"str.47" = internal constant [2 x i64] [i64 7579399195445195891, i64 32199620796034671]
@"str.48" = internal constant [3 x i64] [i64 4064063760403559539, i64 8030813380303680815, i64 7497058]
@"str.49" = internal constant [4 x i64] [i64 7598263559392621683, i64 7598263559393601390, i64 7305524086039603054, i64 114]

define internal void @"rt.flush"() #0 {
b0:
  %v0 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2 = add i64 0, 0
  br label %b1
b1:
  %v1 = phi i64 [ %v2, %b0 ], [ %v1, %b4 ], [ %v18, %b6 ]
  %v3.p = getelementptr i64, ptr %v0, i64 1028
  %v3 = load i64, ptr %v3.p
  %v4 = sub i64 %v3, %v1
  %v5 = add i64 0, 0
  %v6.c = icmp sgt i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b1 = icmp ne i64 %v6, 0
  br i1 %c.b1, label %b1.t1, label %b1.e2
b1.t1:
  br label %b2
b1.e2:
  br label %b3
b2:
  %v7 = add i64 0, 8248
  %v8 = add i64 %v7, %v1
  %v9 = getelementptr i8, ptr %v0, i64 %v8
  %v10 = ptrtoint ptr %v9 to i64
  %v11.p = getelementptr i64, ptr %v0, i64 1026
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 1
  %v13 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v12, i64 %v11, i64 %v10, i64 %v4)
  %v14 = add i64 0, -4
  %v15.c = icmp eq i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b2 = icmp ne i64 %v15, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b4
b2.e4:
  br label %b5
b3:
  %v19 = add i64 0, 0
  %st4 = getelementptr i64, ptr %v0, i64 1028
  store i64 %v19, ptr %st4
  ret void
b4:
  br label %b1
b5:
  %v16 = add i64 0, 0
  %v17.c = icmp sle i64 %v13, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b5 = icmp ne i64 %v17, 0
  br i1 %c.b5, label %b5.t6, label %b5.e7
b5.t6:
  br label %b3
b5.e7:
  br label %b6
b6:
  %v18 = add i64 %v1, %v13
  br label %b1
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
  %v16 = load i64, ptr %v16.p
  %v17 = getelementptr i8, ptr %v6, i64 %v7
  %v18.p = getelementptr i64, ptr %v17, i64 0
  %v18 = load i64, ptr %v18.p
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
  %v52 = load i64, ptr %v52.p
  %v53 = getelementptr i8, ptr %v6, i64 %v50
  %v54.p = getelementptr i64, ptr %v53, i64 0
  %v54 = load i64, ptr %v54.p
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
  %v23 = load i64, ptr %v23.p
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
  %v1 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v2 = add i64 0, 2
  %st0 = getelementptr i64, ptr %v1, i64 1026
  store i64 %v2, ptr %st0
  %v3 = getelementptr i64, ptr @"str.26", i64 0
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
  %v22 = getelementptr i64, ptr @"str.29", i64 0
  %v23 = add i64 0, 9
  %v24 = add i64 0, 0
  %v25 = getelementptr i64, ptr %s3, i64 0
  %v26 = ptrtoint ptr %v22 to i64
  %st6 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st6
  %st7 = getelementptr i64, ptr %v25, i64 1
  store i64 %v23, ptr %st7
  %st8 = getelementptr i64, ptr %v25, i64 2
  store i64 %v24, ptr %st8
  call void @"rt.print_str"(ptr %v25)
  %v27.p = getelementptr i64, ptr %v1, i64 0
  %v27 = load i64, ptr %v27.p
  call void @"rt.print_int"(i64 %v27)
  %v28 = getelementptr i64, ptr @"str.30", i64 0
  %v29 = add i64 0, 2
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s4, i64 0
  %v32 = ptrtoint ptr %v28 to i64
  %st9 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st9
  %st10 = getelementptr i64, ptr %v31, i64 1
  store i64 %v29, ptr %st10
  %st11 = getelementptr i64, ptr %v31, i64 2
  store i64 %v30, ptr %st11
  call void @"rt.print_str"(ptr %v31)
  %v33.p = getelementptr i64, ptr %v1, i64 1029
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v1, i64 1030
  %v34 = load i64, ptr %v34.p
  %v39 = add i64 0, 1
  %v40 = add i64 0, 0
  br label %b6
b2:
  %v10 = getelementptr i64, ptr @"str.27", i64 0
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
  %v17 = getelementptr i64, ptr @"str.28", i64 0
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
  br label %b1
b6:
  %v35 = phi i64 [ %v39, %b1 ], [ %v71, %b10 ]
  %v36 = phi i64 [ %v40, %b1 ], [ %v37, %b10 ]
  %v41.c = icmp sle i64 %v35, %v27
  %v41 = zext i1 %v41.c to i64
  %c.b6 = icmp ne i64 %v41, 0
  br i1 %c.b6, label %b6.t21, label %b6.e22
b6.t21:
  br label %b7
b6.e22:
  br label %b11
b7:
  %v42 = getelementptr i64, ptr %v1, i64 %v35
  %v43.p = getelementptr i64, ptr %v42, i64 1
  %v43 = load i64, ptr %v43.p
  %v44 = mul i64 %v35, %v34
  %v45 = add i64 %v33, %v44
  %v46 = sub i64 %v43, %v45
  %v47 = add i64 0, 0
  %v48.c = icmp sgt i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b7 = icmp ne i64 %v48, 0
  br i1 %c.b7, label %b7.t23, label %b7.e24
b7.t23:
  br label %b8
b7.e24:
  br label %b10
b8:
  %v49 = add i64 0, 16
  %v50.c = icmp slt i64 %v36, %v49
  %v50 = zext i1 %v50.c to i64
  %v51 = add i64 0, 1
  %v52 = add i64 %v36, %v51
  %c.b8 = icmp ne i64 %v50, 0
  br i1 %c.b8, label %b8.t25, label %b8.e26
b8.t25:
  br label %b9
b8.e26:
  br label %b10
b9:
  %v53 = getelementptr i64, ptr @"str.31", i64 0
  %v54 = add i64 0, 16
  %v55 = add i64 0, 0
  %v56 = getelementptr i64, ptr %s5, i64 0
  %v57 = ptrtoint ptr %v53 to i64
  %st26 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st26
  %st27 = getelementptr i64, ptr %v56, i64 1
  store i64 %v54, ptr %st27
  %st28 = getelementptr i64, ptr %v56, i64 2
  store i64 %v55, ptr %st28
  call void @"rt.print_str"(ptr %v56)
  call void @"rt.print_int"(i64 %v35)
  %v58 = getelementptr i64, ptr @"str.32", i64 0
  %v59 = add i64 0, 14
  %v60 = add i64 0, 0
  %v61 = getelementptr i64, ptr %s6, i64 0
  %v62 = ptrtoint ptr %v58 to i64
  %st29 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st29
  %st30 = getelementptr i64, ptr %v61, i64 1
  store i64 %v59, ptr %st30
  %st31 = getelementptr i64, ptr %v61, i64 2
  store i64 %v60, ptr %st31
  call void @"rt.print_str"(ptr %v61)
  call void @"rt.print_int"(i64 %v46)
  %v63 = getelementptr i64, ptr @"str.30", i64 0
  %v64 = add i64 0, 2
  %v65 = add i64 0, 0
  %v66 = getelementptr i64, ptr %s7, i64 0
  %v67 = ptrtoint ptr %v63 to i64
  %st32 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st32
  %st33 = getelementptr i64, ptr %v66, i64 1
  store i64 %v64, ptr %st33
  %st34 = getelementptr i64, ptr %v66, i64 2
  store i64 %v65, ptr %st34
  call void @"rt.print_str"(ptr %v66)
  %v68 = add i64 0, 1
  %v69 = add i64 %v36, %v68
  br label %b10
b10:
  %v37 = phi i64 [ %v36, %b7.e24 ], [ %v52, %b8.e26 ], [ %v69, %b9 ]
  %v70 = add i64 0, 1
  %v71 = add i64 %v35, %v70
  br label %b6
b11:
  %v38 = phi i64 [ %v36, %b6.e22 ]
  %v72 = add i64 0, 16
  %v73.c = icmp sgt i64 %v38, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b11 = icmp ne i64 %v73, 0
  br i1 %c.b11, label %b11.t36, label %b11.e37
b11.t36:
  br label %b12
b11.e37:
  br label %b13
b12:
  %v74 = getelementptr i64, ptr @"str.33", i64 0
  %v75 = add i64 0, 6
  %v76 = add i64 0, 0
  %v77 = getelementptr i64, ptr %s8, i64 0
  %v78 = ptrtoint ptr %v74 to i64
  %st37 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st37
  %st38 = getelementptr i64, ptr %v77, i64 1
  store i64 %v75, ptr %st38
  %st39 = getelementptr i64, ptr %v77, i64 2
  store i64 %v76, ptr %st39
  call void @"rt.print_str"(ptr %v77)
  %v79 = add i64 0, 16
  %v80 = sub i64 %v38, %v79
  call void @"rt.print_int"(i64 %v80)
  %v81 = getelementptr i64, ptr @"str.34", i64 0
  %v82 = add i64 0, 34
  %v83 = add i64 0, 0
  %v84 = getelementptr i64, ptr %s9, i64 0
  %v85 = ptrtoint ptr %v81 to i64
  %st40 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st40
  %st41 = getelementptr i64, ptr %v84, i64 1
  store i64 %v82, ptr %st41
  %st42 = getelementptr i64, ptr %v84, i64 2
  store i64 %v83, ptr %st42
  call void @"rt.print_str"(ptr %v84)
  br label %b13
b13:
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
  %v17 = getelementptr i64, ptr @"str.35", i64 0
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
  %v22 = getelementptr i64, ptr @"str.30", i64 0
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
  %v5 = phi ptr [ %v12, %b4 ], [ %v18, %b6 ], [ %v62, %b18 ]
  %v6 = phi ptr [ %v14, %b4 ], [ %v21, %b6 ], [ %v68, %b18 ]
  ret ptr %v5
b2:
  %v61 = mul i64 %v3, %v1
  %v62 = call ptr @"rt.slice_grow"(i64 %v2, i64 %v3, i64 %v1, i64 %v4, i64 %v38)
  %c.b2 = icmp ne i64 %v38, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b18
b2.e4:
  br label %b19
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
  %v69 = getelementptr i64, ptr @"rt.meta", i64 0
  %v70 = getelementptr i64, ptr %v69, i64 %v4
  %v34.p = getelementptr i64, ptr %v70, i64 1
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
  %v52 = call ptr @"rt.region_alloc"(i64 %v4, i64 %v49)
  %v54 = add i64 0, 0
  br label %b14
b14:
  %v53 = phi i64 [ %v54, %b13 ], [ %v59, %b15 ]
  %v55.c = icmp slt i64 %v53, %v49
  %v55 = zext i1 %v55.c to i64
  %c.b14 = icmp ne i64 %v55, 0
  br i1 %c.b14, label %b14.t16, label %b14.e17
b14.t16:
  br label %b15
b14.e17:
  br label %b16
b15:
  %v56 = getelementptr i64, ptr %v52, i64 %v53
  %v57 = add i64 0, 0
  %st17 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st17
  %v58 = add i64 0, 1
  %v59 = add i64 %v53, %v58
  br label %b14
b16:
  %st18 = getelementptr i64, ptr %v52, i64 2
  store i64 %v41, ptr %st18
  %v60 = ptrtoint ptr %v52 to i64
  %st19 = getelementptr i64, ptr %v0, i64 3
  store i64 %v60, ptr %st19
  br label %b2
b17:
  %v65.p = getelementptr i64, ptr %v0, i64 3
  %v65 = load i64, ptr %v65.p
  %v66 = inttoptr i64 %v65 to ptr
  %v67 = ptrtoint ptr %v62 to i64
  %st20 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st20
  br label %b18
b18:
  %v68 = getelementptr i64, ptr %v62, i64 %v61
  br label %b1
b19:
  %v63 = add i64 0, 8
  %v64.c = icmp slt i64 %v8, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b19 = icmp ne i64 %v64, 0
  br i1 %c.b19, label %b19.t22, label %b19.e23
b19.t22:
  br label %b18
b19.e23:
  br label %b17
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

define internal i64 @"main.main"() #0 {
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
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s10 = alloca [1 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s11 = alloca [3 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %s11.z2 = getelementptr i64, ptr %s11, i64 2
  store i64 0, ptr %s11.z2
  %s12 = alloca [9 x i64], align 8
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
  %s12.z7 = getelementptr i64, ptr %s12, i64 7
  store i64 0, ptr %s12.z7
  %s12.z8 = getelementptr i64, ptr %s12, i64 8
  store i64 0, ptr %s12.z8
  %s13 = alloca [6 x i64], align 8
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
  %s14 = alloca [5 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s14.z1 = getelementptr i64, ptr %s14, i64 1
  store i64 0, ptr %s14.z1
  %s14.z2 = getelementptr i64, ptr %s14, i64 2
  store i64 0, ptr %s14.z2
  %s14.z3 = getelementptr i64, ptr %s14, i64 3
  store i64 0, ptr %s14.z3
  %s14.z4 = getelementptr i64, ptr %s14, i64 4
  store i64 0, ptr %s14.z4
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
  %s28 = alloca [3 x i64], align 8
  %s28.z0 = getelementptr i64, ptr %s28, i64 0
  store i64 0, ptr %s28.z0
  %s28.z1 = getelementptr i64, ptr %s28, i64 1
  store i64 0, ptr %s28.z1
  %s28.z2 = getelementptr i64, ptr %s28, i64 2
  store i64 0, ptr %s28.z2
  %s29 = alloca [3 x i64], align 8
  %s29.z0 = getelementptr i64, ptr %s29, i64 0
  store i64 0, ptr %s29.z0
  %s29.z1 = getelementptr i64, ptr %s29, i64 1
  store i64 0, ptr %s29.z1
  %s29.z2 = getelementptr i64, ptr %s29, i64 2
  store i64 0, ptr %s29.z2
  %s30 = alloca [8 x i64], align 8
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
  %s30.z6 = getelementptr i64, ptr %s30, i64 6
  store i64 0, ptr %s30.z6
  %s30.z7 = getelementptr i64, ptr %s30, i64 7
  store i64 0, ptr %s30.z7
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
  %s33 = alloca [7 x i64], align 8
  %s33.z0 = getelementptr i64, ptr %s33, i64 0
  store i64 0, ptr %s33.z0
  %s33.z1 = getelementptr i64, ptr %s33, i64 1
  store i64 0, ptr %s33.z1
  %s33.z2 = getelementptr i64, ptr %s33, i64 2
  store i64 0, ptr %s33.z2
  %s33.z3 = getelementptr i64, ptr %s33, i64 3
  store i64 0, ptr %s33.z3
  %s33.z4 = getelementptr i64, ptr %s33, i64 4
  store i64 0, ptr %s33.z4
  %s33.z5 = getelementptr i64, ptr %s33, i64 5
  store i64 0, ptr %s33.z5
  %s33.z6 = getelementptr i64, ptr %s33, i64 6
  store i64 0, ptr %s33.z6
  %s34 = alloca [7 x i64], align 8
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
  %s34.z6 = getelementptr i64, ptr %s34, i64 6
  store i64 0, ptr %s34.z6
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
  %s38 = alloca [3 x i64], align 8
  %s38.z0 = getelementptr i64, ptr %s38, i64 0
  store i64 0, ptr %s38.z0
  %s38.z1 = getelementptr i64, ptr %s38, i64 1
  store i64 0, ptr %s38.z1
  %s38.z2 = getelementptr i64, ptr %s38, i64 2
  store i64 0, ptr %s38.z2
  %s39 = alloca [9 x i64], align 8
  %s39.z0 = getelementptr i64, ptr %s39, i64 0
  store i64 0, ptr %s39.z0
  %s39.z1 = getelementptr i64, ptr %s39, i64 1
  store i64 0, ptr %s39.z1
  %s39.z2 = getelementptr i64, ptr %s39, i64 2
  store i64 0, ptr %s39.z2
  %s39.z3 = getelementptr i64, ptr %s39, i64 3
  store i64 0, ptr %s39.z3
  %s39.z4 = getelementptr i64, ptr %s39, i64 4
  store i64 0, ptr %s39.z4
  %s39.z5 = getelementptr i64, ptr %s39, i64 5
  store i64 0, ptr %s39.z5
  %s39.z6 = getelementptr i64, ptr %s39, i64 6
  store i64 0, ptr %s39.z6
  %s39.z7 = getelementptr i64, ptr %s39, i64 7
  store i64 0, ptr %s39.z7
  %s39.z8 = getelementptr i64, ptr %s39, i64 8
  store i64 0, ptr %s39.z8
  %v678 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v678, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr @"str.0", i64 0
  %v2 = add i64 0, 28
  %v3 = add i64 0, 0
  %v4 = getelementptr i64, ptr %s0, i64 0
  %v5 = ptrtoint ptr %v1 to i64
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v5, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
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
  %v679 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v679, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = getelementptr i64, ptr %s0, i64 0
  %v12.p = getelementptr i64, ptr %v6, i64 0
  %v12 = load i64, ptr %v12.p
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st6
  %v13.p = getelementptr i64, ptr %v6, i64 1
  %v13 = load i64, ptr %v13.p
  %st7 = getelementptr i64, ptr %v11, i64 1
  store i64 %v13, ptr %st7
  %v14.p = getelementptr i64, ptr %v6, i64 2
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v11, i64 2
  store i64 %v14, ptr %st8
  %v15 = getelementptr i64, ptr @"str.1", i64 0
  %v16 = add i64 0, 21
  %v17 = add i64 0, 0
  %v18 = getelementptr i64, ptr %s2, i64 0
  %v19 = ptrtoint ptr %v15 to i64
  %st9 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st9
  %st10 = getelementptr i64, ptr %v18, i64 1
  store i64 %v16, ptr %st10
  %st11 = getelementptr i64, ptr %v18, i64 2
  store i64 %v17, ptr %st11
  %v20 = getelementptr i64, ptr %s3, i64 0
  %v21.p = getelementptr i64, ptr %v18, i64 0
  %v21 = load i64, ptr %v21.p
  %st12 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st12
  %v22.p = getelementptr i64, ptr %v18, i64 1
  %v22 = load i64, ptr %v22.p
  %st13 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st13
  %v23.p = getelementptr i64, ptr %v18, i64 2
  %v23 = load i64, ptr %v23.p
  %st14 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st14
  %v24 = getelementptr i64, ptr @"str.2", i64 0
  %v25 = add i64 0, 21
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s4, i64 0
  %v28 = ptrtoint ptr %v24 to i64
  %st15 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st15
  %st16 = getelementptr i64, ptr %v27, i64 1
  store i64 %v25, ptr %st16
  %st17 = getelementptr i64, ptr %v27, i64 2
  store i64 %v26, ptr %st17
  %v29 = getelementptr i64, ptr %s5, i64 0
  %v30.p = getelementptr i64, ptr %v27, i64 0
  %v30 = load i64, ptr %v30.p
  %st18 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st18
  %v31.p = getelementptr i64, ptr %v27, i64 1
  %v31 = load i64, ptr %v31.p
  %st19 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st19
  %v32.p = getelementptr i64, ptr %v27, i64 2
  %v32 = load i64, ptr %v32.p
  %st20 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st20
  %v680 = getelementptr i64, ptr @"rt.meta", i64 0
  %v33.p = getelementptr i64, ptr %v680, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 0, 9
  %v35 = call ptr @"rt.region_alloc"(i64 %v33, i64 %v34)
  %v36.p = getelementptr i64, ptr %v11, i64 0
  %v36 = load i64, ptr %v36.p
  %st21 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st21
  %v37.p = getelementptr i64, ptr %v11, i64 1
  %v37 = load i64, ptr %v37.p
  %st22 = getelementptr i64, ptr %v35, i64 1
  store i64 %v37, ptr %st22
  %v38.p = getelementptr i64, ptr %v11, i64 2
  %v38 = load i64, ptr %v38.p
  %st23 = getelementptr i64, ptr %v35, i64 2
  store i64 %v38, ptr %st23
  %v39.p = getelementptr i64, ptr %v20, i64 0
  %v39 = load i64, ptr %v39.p
  %st24 = getelementptr i64, ptr %v35, i64 3
  store i64 %v39, ptr %st24
  %v40.p = getelementptr i64, ptr %v20, i64 1
  %v40 = load i64, ptr %v40.p
  %st25 = getelementptr i64, ptr %v35, i64 4
  store i64 %v40, ptr %st25
  %v41.p = getelementptr i64, ptr %v20, i64 2
  %v41 = load i64, ptr %v41.p
  %st26 = getelementptr i64, ptr %v35, i64 5
  store i64 %v41, ptr %st26
  %v42.p = getelementptr i64, ptr %v29, i64 0
  %v42 = load i64, ptr %v42.p
  %st27 = getelementptr i64, ptr %v35, i64 6
  store i64 %v42, ptr %st27
  %v43.p = getelementptr i64, ptr %v29, i64 1
  %v43 = load i64, ptr %v43.p
  %st28 = getelementptr i64, ptr %v35, i64 7
  store i64 %v43, ptr %st28
  %v44.p = getelementptr i64, ptr %v29, i64 2
  %v44 = load i64, ptr %v44.p
  %st29 = getelementptr i64, ptr %v35, i64 8
  store i64 %v44, ptr %st29
  %v45 = add i64 0, 3
  %v46 = getelementptr i64, ptr %s6, i64 0
  %v47 = ptrtoint ptr %v35 to i64
  %st30 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st30
  %st31 = getelementptr i64, ptr %v46, i64 1
  store i64 %v45, ptr %st31
  %st32 = getelementptr i64, ptr %v46, i64 2
  store i64 %v33, ptr %st32
  %v48 = getelementptr i64, ptr %s7, i64 0
  %v49.p = getelementptr i64, ptr %v46, i64 0
  %v49 = load i64, ptr %v49.p
  %st33 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st33
  %v50.p = getelementptr i64, ptr %v46, i64 1
  %v50 = load i64, ptr %v50.p
  %st34 = getelementptr i64, ptr %v48, i64 1
  store i64 %v50, ptr %st34
  %v51.p = getelementptr i64, ptr %v46, i64 2
  %v51 = load i64, ptr %v51.p
  %st35 = getelementptr i64, ptr %v48, i64 2
  store i64 %v51, ptr %st35
  %v52 = getelementptr i64, ptr %s8, i64 0
  %v53.p = getelementptr i64, ptr %v48, i64 0
  %v53 = load i64, ptr %v53.p
  %st36 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st36
  %v54.p = getelementptr i64, ptr %v48, i64 1
  %v54 = load i64, ptr %v54.p
  %st37 = getelementptr i64, ptr %v52, i64 1
  store i64 %v54, ptr %st37
  %v55.p = getelementptr i64, ptr %v48, i64 2
  %v55 = load i64, ptr %v55.p
  %st38 = getelementptr i64, ptr %v52, i64 2
  store i64 %v55, ptr %st38
  %v56 = getelementptr i64, ptr %s9, i64 0
  %v681 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v681, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 0, 0
  %v59 = getelementptr i64, ptr %s10, i64 0
  %st39 = getelementptr i64, ptr %v59, i64 0
  store i64 %v58, ptr %st39
  %v682 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v682, i64 0
  %v60 = load i64, ptr %v60.p
  br label %b3
b1:
  %v683 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v683, i64 0
  store i64 %v10, ptr %st40
  %v684 = getelementptr i64, ptr @"rt.meta", i64 0
  %v229.p = getelementptr i64, ptr %v684, i64 0
  %v229 = load i64, ptr %v229.p
  %v230 = getelementptr i64, ptr @"str.7", i64 0
  %v231 = add i64 0, 20
  %v232 = add i64 0, 0
  %v233 = getelementptr i64, ptr %s8, i64 0
  %v234 = ptrtoint ptr %v230 to i64
  %st41 = getelementptr i64, ptr %v233, i64 0
  store i64 %v234, ptr %st41
  %st42 = getelementptr i64, ptr %v233, i64 1
  store i64 %v231, ptr %st42
  %st43 = getelementptr i64, ptr %v233, i64 2
  store i64 %v232, ptr %st43
  %v235 = getelementptr i64, ptr %s7, i64 0
  %v236.p = getelementptr i64, ptr %v233, i64 0
  %v236 = load i64, ptr %v236.p
  %st44 = getelementptr i64, ptr %v235, i64 0
  store i64 %v236, ptr %st44
  %v237.p = getelementptr i64, ptr %v233, i64 1
  %v237 = load i64, ptr %v237.p
  %st45 = getelementptr i64, ptr %v235, i64 1
  store i64 %v237, ptr %st45
  %v238.p = getelementptr i64, ptr %v233, i64 2
  %v238 = load i64, ptr %v238.p
  %st46 = getelementptr i64, ptr %v235, i64 2
  store i64 %v238, ptr %st46
  %v239 = getelementptr i64, ptr @"str.2", i64 0
  %v240 = add i64 0, 21
  %v241 = add i64 0, 0
  %v242 = getelementptr i64, ptr %s6, i64 0
  %v243 = ptrtoint ptr %v239 to i64
  %st47 = getelementptr i64, ptr %v242, i64 0
  store i64 %v243, ptr %st47
  %st48 = getelementptr i64, ptr %v242, i64 1
  store i64 %v240, ptr %st48
  %st49 = getelementptr i64, ptr %v242, i64 2
  store i64 %v241, ptr %st49
  %v244 = getelementptr i64, ptr %s5, i64 0
  %v245.p = getelementptr i64, ptr %v242, i64 0
  %v245 = load i64, ptr %v245.p
  %st50 = getelementptr i64, ptr %v244, i64 0
  store i64 %v245, ptr %st50
  %v246.p = getelementptr i64, ptr %v242, i64 1
  %v246 = load i64, ptr %v246.p
  %st51 = getelementptr i64, ptr %v244, i64 1
  store i64 %v246, ptr %st51
  %v247.p = getelementptr i64, ptr %v242, i64 2
  %v247 = load i64, ptr %v247.p
  %st52 = getelementptr i64, ptr %v244, i64 2
  store i64 %v247, ptr %st52
  %v248 = getelementptr i64, ptr %s4, i64 0
  %v249.p = getelementptr i64, ptr %v6, i64 0
  %v249 = load i64, ptr %v249.p
  %st53 = getelementptr i64, ptr %v248, i64 0
  store i64 %v249, ptr %st53
  %v250.p = getelementptr i64, ptr %v6, i64 1
  %v250 = load i64, ptr %v250.p
  %st54 = getelementptr i64, ptr %v248, i64 1
  store i64 %v250, ptr %st54
  %v251.p = getelementptr i64, ptr %v6, i64 2
  %v251 = load i64, ptr %v251.p
  %st55 = getelementptr i64, ptr %v248, i64 2
  store i64 %v251, ptr %st55
  %v685 = getelementptr i64, ptr @"rt.meta", i64 0
  %v252.p = getelementptr i64, ptr %v685, i64 0
  %v252 = load i64, ptr %v252.p
  %v253 = add i64 0, 9
  %v254 = call ptr @"rt.region_alloc"(i64 %v252, i64 %v253)
  %v255.p = getelementptr i64, ptr %v235, i64 0
  %v255 = load i64, ptr %v255.p
  %st56 = getelementptr i64, ptr %v254, i64 0
  store i64 %v255, ptr %st56
  %v256.p = getelementptr i64, ptr %v235, i64 1
  %v256 = load i64, ptr %v256.p
  %st57 = getelementptr i64, ptr %v254, i64 1
  store i64 %v256, ptr %st57
  %v257.p = getelementptr i64, ptr %v235, i64 2
  %v257 = load i64, ptr %v257.p
  %st58 = getelementptr i64, ptr %v254, i64 2
  store i64 %v257, ptr %st58
  %v258.p = getelementptr i64, ptr %v244, i64 0
  %v258 = load i64, ptr %v258.p
  %st59 = getelementptr i64, ptr %v254, i64 3
  store i64 %v258, ptr %st59
  %v259.p = getelementptr i64, ptr %v244, i64 1
  %v259 = load i64, ptr %v259.p
  %st60 = getelementptr i64, ptr %v254, i64 4
  store i64 %v259, ptr %st60
  %v260.p = getelementptr i64, ptr %v244, i64 2
  %v260 = load i64, ptr %v260.p
  %st61 = getelementptr i64, ptr %v254, i64 5
  store i64 %v260, ptr %st61
  %v261.p = getelementptr i64, ptr %v248, i64 0
  %v261 = load i64, ptr %v261.p
  %st62 = getelementptr i64, ptr %v254, i64 6
  store i64 %v261, ptr %st62
  %v262.p = getelementptr i64, ptr %v248, i64 1
  %v262 = load i64, ptr %v262.p
  %st63 = getelementptr i64, ptr %v254, i64 7
  store i64 %v262, ptr %st63
  %v263.p = getelementptr i64, ptr %v248, i64 2
  %v263 = load i64, ptr %v263.p
  %st64 = getelementptr i64, ptr %v254, i64 8
  store i64 %v263, ptr %st64
  %v264 = add i64 0, 3
  %v265 = getelementptr i64, ptr %s3, i64 0
  %v266 = ptrtoint ptr %v254 to i64
  %st65 = getelementptr i64, ptr %v265, i64 0
  store i64 %v266, ptr %st65
  %st66 = getelementptr i64, ptr %v265, i64 1
  store i64 %v264, ptr %st66
  %st67 = getelementptr i64, ptr %v265, i64 2
  store i64 %v252, ptr %st67
  %v267 = getelementptr i64, ptr %s2, i64 0
  %v268.p = getelementptr i64, ptr %v265, i64 0
  %v268 = load i64, ptr %v268.p
  %st68 = getelementptr i64, ptr %v267, i64 0
  store i64 %v268, ptr %st68
  %v269.p = getelementptr i64, ptr %v265, i64 1
  %v269 = load i64, ptr %v269.p
  %st69 = getelementptr i64, ptr %v267, i64 1
  store i64 %v269, ptr %st69
  %v270.p = getelementptr i64, ptr %v265, i64 2
  %v270 = load i64, ptr %v270.p
  %st70 = getelementptr i64, ptr %v267, i64 2
  store i64 %v270, ptr %st70
  %v271 = getelementptr i64, ptr %s0, i64 0
  %v272.p = getelementptr i64, ptr %v267, i64 0
  %v272 = load i64, ptr %v272.p
  %st71 = getelementptr i64, ptr %v271, i64 0
  store i64 %v272, ptr %st71
  %v273.p = getelementptr i64, ptr %v267, i64 1
  %v273 = load i64, ptr %v273.p
  %st72 = getelementptr i64, ptr %v271, i64 1
  store i64 %v273, ptr %st72
  %v274.p = getelementptr i64, ptr %v267, i64 2
  %v274 = load i64, ptr %v274.p
  %st73 = getelementptr i64, ptr %v271, i64 2
  store i64 %v274, ptr %st73
  %v275 = getelementptr i64, ptr %s10, i64 0
  %v686 = getelementptr i64, ptr @"rt.meta", i64 0
  %v276.p = getelementptr i64, ptr %v686, i64 0
  %v276 = load i64, ptr %v276.p
  %v277 = add i64 0, 0
  %v278 = getelementptr i64, ptr %s9, i64 0
  %st74 = getelementptr i64, ptr %v278, i64 0
  store i64 %v277, ptr %st74
  %v687 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279.p = getelementptr i64, ptr %v687, i64 0
  %v279 = load i64, ptr %v279.p
  br label %b14
b2:
  br label %b1
b3:
  %v688 = getelementptr i64, ptr @"rt.meta", i64 0
  %st75 = getelementptr i64, ptr %v688, i64 0
  store i64 %v60, ptr %st75
  %v61.p = getelementptr i64, ptr %v59, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v52, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.c = icmp slt i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b3 = icmp ne i64 %v63, 0
  br i1 %c.b3, label %b3.t77, label %b3.e78
b3.t77:
  br label %b4
b3.e78:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v689 = getelementptr i64, ptr @"rt.meta", i64 0
  %v64.p = getelementptr i64, ptr %v689, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v59, i64 0
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v52, i64 1
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp uge i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b4 = icmp ne i64 %v67, 0
  br i1 %c.b4, label %b4.t79, label %b4.e80
b4.t79:
  br label %b6
b4.e80:
  br label %b7
b5:
  %v690 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v690, i64 0
  store i64 %v60, ptr %st80
  br label %b2
b6:
  %v68 = add i64 0, 0
  call void @"rt.panic"(i64 %v68)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v69.p = getelementptr i64, ptr %v52, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = inttoptr i64 %v69 to ptr
  %v71 = add i64 0, 3
  %v72 = mul i64 %v65, %v71
  %v73 = getelementptr i64, ptr %v70, i64 %v72
  %v74 = getelementptr i64, ptr %s11, i64 0
  %v75.p = getelementptr i64, ptr %v73, i64 0
  %v75 = load i64, ptr %v75.p
  %st81 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st81
  %v76.p = getelementptr i64, ptr %v73, i64 1
  %v76 = load i64, ptr %v76.p
  %st82 = getelementptr i64, ptr %v74, i64 1
  store i64 %v76, ptr %st82
  %v77.p = getelementptr i64, ptr %v73, i64 2
  %v77 = load i64, ptr %v77.p
  %st83 = getelementptr i64, ptr %v74, i64 2
  store i64 %v77, ptr %st83
  %v691 = getelementptr i64, ptr @"rt.meta", i64 0
  %v78.p = getelementptr i64, ptr %v691, i64 0
  %v78 = load i64, ptr %v78.p
  %v79 = getelementptr i64, ptr %s12, i64 0
  %v80.p = getelementptr i64, ptr %v74, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v74, i64 1
  %v81 = load i64, ptr %v81.p
  %v82.p = getelementptr i64, ptr %v74, i64 2
  %v82 = load i64, ptr %v82.p
  call void @"main.count"(ptr %v79, i64 %v80, i64 %v81, i64 %v82)
  %v83.p = getelementptr i64, ptr %v79, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v79, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v79, i64 2
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 0, 3
  %v87 = getelementptr i64, ptr %v79, i64 %v86
  %v88 = getelementptr i64, ptr %s13, i64 0
  %v89.p = getelementptr i64, ptr %v87, i64 0
  %v89 = load i64, ptr %v89.p
  %st84 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st84
  %v90.p = getelementptr i64, ptr %v87, i64 1
  %v90 = load i64, ptr %v90.p
  %st85 = getelementptr i64, ptr %v88, i64 1
  store i64 %v90, ptr %st85
  %v91.p = getelementptr i64, ptr %v87, i64 2
  %v91 = load i64, ptr %v91.p
  %st86 = getelementptr i64, ptr %v88, i64 2
  store i64 %v91, ptr %st86
  %v92.p = getelementptr i64, ptr %v87, i64 3
  %v92 = load i64, ptr %v92.p
  %st87 = getelementptr i64, ptr %v88, i64 3
  store i64 %v92, ptr %st87
  %v93.p = getelementptr i64, ptr %v87, i64 4
  %v93 = load i64, ptr %v93.p
  %st88 = getelementptr i64, ptr %v88, i64 4
  store i64 %v93, ptr %st88
  %v94.p = getelementptr i64, ptr %v87, i64 5
  %v94 = load i64, ptr %v94.p
  %st89 = getelementptr i64, ptr %v88, i64 5
  store i64 %v94, ptr %st89
  %v95.p = getelementptr i64, ptr %v88, i64 0
  %v95 = load i64, ptr %v95.p
  %v96 = add i64 0, 0
  %v97.c = icmp ne i64 %v95, %v96
  %v97 = zext i1 %v97.c to i64
  %c.b7 = icmp ne i64 %v97, 0
  br i1 %c.b7, label %b7.t91, label %b7.e92
b7.t91:
  br label %b9
b7.e92:
  br label %b10
b8:
  %v692 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v692, i64 0
  store i64 %v78, ptr %st92
  %v226 = add i64 0, 1
  %v227.p = getelementptr i64, ptr %v59, i64 0
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 %v227, %v226
  %st93 = getelementptr i64, ptr %v59, i64 0
  store i64 %v228, ptr %st93
  br label %b3
b9:
  %v98 = add i64 0, 1
  %v99 = getelementptr i64, ptr %v88, i64 %v98
  %v100 = getelementptr i64, ptr %s14, i64 0
  %v101.p = getelementptr i64, ptr %v99, i64 0
  %v101 = load i64, ptr %v101.p
  %st94 = getelementptr i64, ptr %v100, i64 0
  store i64 %v101, ptr %st94
  %v102.p = getelementptr i64, ptr %v99, i64 1
  %v102 = load i64, ptr %v102.p
  %st95 = getelementptr i64, ptr %v100, i64 1
  store i64 %v102, ptr %st95
  %v103.p = getelementptr i64, ptr %v99, i64 2
  %v103 = load i64, ptr %v103.p
  %st96 = getelementptr i64, ptr %v100, i64 2
  store i64 %v103, ptr %st96
  %v104.p = getelementptr i64, ptr %v99, i64 3
  %v104 = load i64, ptr %v104.p
  %st97 = getelementptr i64, ptr %v100, i64 3
  store i64 %v104, ptr %st97
  %v105.p = getelementptr i64, ptr %v99, i64 4
  %v105 = load i64, ptr %v105.p
  %st98 = getelementptr i64, ptr %v100, i64 4
  store i64 %v105, ptr %st98
  %v106 = add i64 0, 1
  %v693 = getelementptr i64, ptr @"rt.meta", i64 0
  %st99 = getelementptr i64, ptr %v693, i64 0
  store i64 %v0, ptr %st99
  ret i64 %v106
b10:
  br label %b11
b11:
  %v107 = getelementptr i64, ptr %s15, i64 0
  %v108.p = getelementptr i64, ptr %v74, i64 0
  %v108 = load i64, ptr %v108.p
  %st100 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st100
  %v109.p = getelementptr i64, ptr %v74, i64 1
  %v109 = load i64, ptr %v109.p
  %st101 = getelementptr i64, ptr %v107, i64 1
  store i64 %v109, ptr %st101
  %v110.p = getelementptr i64, ptr %v74, i64 2
  %v110 = load i64, ptr %v110.p
  %st102 = getelementptr i64, ptr %v107, i64 2
  store i64 %v110, ptr %st102
  %v111 = getelementptr i64, ptr @"str.3", i64 0
  %v112 = add i64 0, 2
  %v113 = add i64 0, 0
  %v114 = getelementptr i64, ptr %s16, i64 0
  %v115 = ptrtoint ptr %v111 to i64
  %st103 = getelementptr i64, ptr %v114, i64 0
  store i64 %v115, ptr %st103
  %st104 = getelementptr i64, ptr %v114, i64 1
  store i64 %v112, ptr %st104
  %st105 = getelementptr i64, ptr %v114, i64 2
  store i64 %v113, ptr %st105
  %v116.p = getelementptr i64, ptr %v107, i64 1
  %v116 = load i64, ptr %v116.p
  %v117.p = getelementptr i64, ptr %v114, i64 1
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 %v116, %v117
  %v694 = getelementptr i64, ptr @"rt.meta", i64 0
  %v119.p = getelementptr i64, ptr %v694, i64 0
  %v119 = load i64, ptr %v119.p
  %v120.p = getelementptr i64, ptr %v107, i64 0
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v107, i64 1
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v107, i64 2
  %v122 = load i64, ptr %v122.p
  %v123 = call ptr @"rt.cat8"(i64 %v120, i64 %v121, i64 %v122, i64 %v119, i64 %v117)
  %v124 = getelementptr i8, ptr %v123, i64 %v116
  %v125.p = getelementptr i64, ptr %v114, i64 0
  %v125 = load i64, ptr %v125.p
  %v126 = inttoptr i64 %v125 to ptr
  call void @"rt.copy8"(ptr %v124, ptr %v126, i64 %v117)
  %v127 = getelementptr i64, ptr %s17, i64 0
  %v128 = ptrtoint ptr %v123 to i64
  %st106 = getelementptr i64, ptr %v127, i64 0
  store i64 %v128, ptr %st106
  %st107 = getelementptr i64, ptr %v127, i64 1
  store i64 %v118, ptr %st107
  %st108 = getelementptr i64, ptr %v127, i64 2
  store i64 %v119, ptr %st108
  %v129 = getelementptr i64, ptr %s18, i64 0
  call void @"std/strings.FormatInt"(ptr %v129, i64 %v83)
  %v130.p = getelementptr i64, ptr %v127, i64 1
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v129, i64 1
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 %v130, %v131
  %v695 = getelementptr i64, ptr @"rt.meta", i64 0
  %v133.p = getelementptr i64, ptr %v695, i64 0
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v127, i64 0
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v127, i64 1
  %v135 = load i64, ptr %v135.p
  %v136.p = getelementptr i64, ptr %v127, i64 2
  %v136 = load i64, ptr %v136.p
  %v137 = call ptr @"rt.cat8"(i64 %v134, i64 %v135, i64 %v136, i64 %v133, i64 %v131)
  %v138 = getelementptr i8, ptr %v137, i64 %v130
  %v139.p = getelementptr i64, ptr %v129, i64 0
  %v139 = load i64, ptr %v139.p
  %v140 = inttoptr i64 %v139 to ptr
  call void @"rt.copy8"(ptr %v138, ptr %v140, i64 %v131)
  %v141 = getelementptr i64, ptr %s19, i64 0
  %v142 = ptrtoint ptr %v137 to i64
  %st109 = getelementptr i64, ptr %v141, i64 0
  store i64 %v142, ptr %st109
  %st110 = getelementptr i64, ptr %v141, i64 1
  store i64 %v132, ptr %st110
  %st111 = getelementptr i64, ptr %v141, i64 2
  store i64 %v133, ptr %st111
  %v143 = getelementptr i64, ptr @"str.4", i64 0
  %v144 = add i64 0, 8
  %v145 = add i64 0, 0
  %v146 = getelementptr i64, ptr %s20, i64 0
  %v147 = ptrtoint ptr %v143 to i64
  %st112 = getelementptr i64, ptr %v146, i64 0
  store i64 %v147, ptr %st112
  %st113 = getelementptr i64, ptr %v146, i64 1
  store i64 %v144, ptr %st113
  %st114 = getelementptr i64, ptr %v146, i64 2
  store i64 %v145, ptr %st114
  %v148.p = getelementptr i64, ptr %v141, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.p = getelementptr i64, ptr %v146, i64 1
  %v149 = load i64, ptr %v149.p
  %v150 = add i64 %v148, %v149
  %v696 = getelementptr i64, ptr @"rt.meta", i64 0
  %v151.p = getelementptr i64, ptr %v696, i64 0
  %v151 = load i64, ptr %v151.p
  %v152.p = getelementptr i64, ptr %v141, i64 0
  %v152 = load i64, ptr %v152.p
  %v153.p = getelementptr i64, ptr %v141, i64 1
  %v153 = load i64, ptr %v153.p
  %v154.p = getelementptr i64, ptr %v141, i64 2
  %v154 = load i64, ptr %v154.p
  %v155 = call ptr @"rt.cat8"(i64 %v152, i64 %v153, i64 %v154, i64 %v151, i64 %v149)
  %v156 = getelementptr i8, ptr %v155, i64 %v148
  %v157.p = getelementptr i64, ptr %v146, i64 0
  %v157 = load i64, ptr %v157.p
  %v158 = inttoptr i64 %v157 to ptr
  call void @"rt.copy8"(ptr %v156, ptr %v158, i64 %v149)
  %v159 = getelementptr i64, ptr %s21, i64 0
  %v160 = ptrtoint ptr %v155 to i64
  %st115 = getelementptr i64, ptr %v159, i64 0
  store i64 %v160, ptr %st115
  %st116 = getelementptr i64, ptr %v159, i64 1
  store i64 %v150, ptr %st116
  %st117 = getelementptr i64, ptr %v159, i64 2
  store i64 %v151, ptr %st117
  %v161 = getelementptr i64, ptr %s22, i64 0
  call void @"std/strings.FormatInt"(ptr %v161, i64 %v84)
  %v162.p = getelementptr i64, ptr %v159, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v161, i64 1
  %v163 = load i64, ptr %v163.p
  %v164 = add i64 %v162, %v163
  %v697 = getelementptr i64, ptr @"rt.meta", i64 0
  %v165.p = getelementptr i64, ptr %v697, i64 0
  %v165 = load i64, ptr %v165.p
  %v166.p = getelementptr i64, ptr %v159, i64 0
  %v166 = load i64, ptr %v166.p
  %v167.p = getelementptr i64, ptr %v159, i64 1
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v159, i64 2
  %v168 = load i64, ptr %v168.p
  %v169 = call ptr @"rt.cat8"(i64 %v166, i64 %v167, i64 %v168, i64 %v165, i64 %v163)
  %v170 = getelementptr i8, ptr %v169, i64 %v162
  %v171.p = getelementptr i64, ptr %v161, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = inttoptr i64 %v171 to ptr
  call void @"rt.copy8"(ptr %v170, ptr %v172, i64 %v163)
  %v173 = getelementptr i64, ptr %s23, i64 0
  %v174 = ptrtoint ptr %v169 to i64
  %st118 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st118
  %st119 = getelementptr i64, ptr %v173, i64 1
  store i64 %v164, ptr %st119
  %st120 = getelementptr i64, ptr %v173, i64 2
  store i64 %v165, ptr %st120
  %v175 = getelementptr i64, ptr @"str.5", i64 0
  %v176 = add i64 0, 11
  %v177 = add i64 0, 0
  %v178 = getelementptr i64, ptr %s24, i64 0
  %v179 = ptrtoint ptr %v175 to i64
  %st121 = getelementptr i64, ptr %v178, i64 0
  store i64 %v179, ptr %st121
  %st122 = getelementptr i64, ptr %v178, i64 1
  store i64 %v176, ptr %st122
  %st123 = getelementptr i64, ptr %v178, i64 2
  store i64 %v177, ptr %st123
  %v180.p = getelementptr i64, ptr %v173, i64 1
  %v180 = load i64, ptr %v180.p
  %v181.p = getelementptr i64, ptr %v178, i64 1
  %v181 = load i64, ptr %v181.p
  %v182 = add i64 %v180, %v181
  %v698 = getelementptr i64, ptr @"rt.meta", i64 0
  %v183.p = getelementptr i64, ptr %v698, i64 0
  %v183 = load i64, ptr %v183.p
  %v184.p = getelementptr i64, ptr %v173, i64 0
  %v184 = load i64, ptr %v184.p
  %v185.p = getelementptr i64, ptr %v173, i64 1
  %v185 = load i64, ptr %v185.p
  %v186.p = getelementptr i64, ptr %v173, i64 2
  %v186 = load i64, ptr %v186.p
  %v187 = call ptr @"rt.cat8"(i64 %v184, i64 %v185, i64 %v186, i64 %v183, i64 %v181)
  %v188 = getelementptr i8, ptr %v187, i64 %v180
  %v189.p = getelementptr i64, ptr %v178, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = inttoptr i64 %v189 to ptr
  call void @"rt.copy8"(ptr %v188, ptr %v190, i64 %v181)
  %v191 = getelementptr i64, ptr %s25, i64 0
  %v192 = ptrtoint ptr %v187 to i64
  %st124 = getelementptr i64, ptr %v191, i64 0
  store i64 %v192, ptr %st124
  %st125 = getelementptr i64, ptr %v191, i64 1
  store i64 %v182, ptr %st125
  %st126 = getelementptr i64, ptr %v191, i64 2
  store i64 %v183, ptr %st126
  %v193 = getelementptr i64, ptr %s26, i64 0
  call void @"std/strings.FormatInt"(ptr %v193, i64 %v85)
  %v194.p = getelementptr i64, ptr %v191, i64 1
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v193, i64 1
  %v195 = load i64, ptr %v195.p
  %v196 = add i64 %v194, %v195
  %v699 = getelementptr i64, ptr @"rt.meta", i64 0
  %v197.p = getelementptr i64, ptr %v699, i64 0
  %v197 = load i64, ptr %v197.p
  %v198.p = getelementptr i64, ptr %v191, i64 0
  %v198 = load i64, ptr %v198.p
  %v199.p = getelementptr i64, ptr %v191, i64 1
  %v199 = load i64, ptr %v199.p
  %v200.p = getelementptr i64, ptr %v191, i64 2
  %v200 = load i64, ptr %v200.p
  %v201 = call ptr @"rt.cat8"(i64 %v198, i64 %v199, i64 %v200, i64 %v197, i64 %v195)
  %v202 = getelementptr i8, ptr %v201, i64 %v194
  %v203.p = getelementptr i64, ptr %v193, i64 0
  %v203 = load i64, ptr %v203.p
  %v204 = inttoptr i64 %v203 to ptr
  call void @"rt.copy8"(ptr %v202, ptr %v204, i64 %v195)
  %v205 = getelementptr i64, ptr %s27, i64 0
  %v206 = ptrtoint ptr %v201 to i64
  %st127 = getelementptr i64, ptr %v205, i64 0
  store i64 %v206, ptr %st127
  %st128 = getelementptr i64, ptr %v205, i64 1
  store i64 %v196, ptr %st128
  %st129 = getelementptr i64, ptr %v205, i64 2
  store i64 %v197, ptr %st129
  %v207 = getelementptr i64, ptr @"str.6", i64 0
  %v208 = add i64 0, 7
  %v209 = add i64 0, 0
  %v210 = getelementptr i64, ptr %s28, i64 0
  %v211 = ptrtoint ptr %v207 to i64
  %st130 = getelementptr i64, ptr %v210, i64 0
  store i64 %v211, ptr %st130
  %st131 = getelementptr i64, ptr %v210, i64 1
  store i64 %v208, ptr %st131
  %st132 = getelementptr i64, ptr %v210, i64 2
  store i64 %v209, ptr %st132
  %v212.p = getelementptr i64, ptr %v205, i64 1
  %v212 = load i64, ptr %v212.p
  %v213.p = getelementptr i64, ptr %v210, i64 1
  %v213 = load i64, ptr %v213.p
  %v214 = add i64 %v212, %v213
  %v700 = getelementptr i64, ptr @"rt.meta", i64 0
  %v215.p = getelementptr i64, ptr %v700, i64 0
  %v215 = load i64, ptr %v215.p
  %v216.p = getelementptr i64, ptr %v205, i64 0
  %v216 = load i64, ptr %v216.p
  %v217.p = getelementptr i64, ptr %v205, i64 1
  %v217 = load i64, ptr %v217.p
  %v218.p = getelementptr i64, ptr %v205, i64 2
  %v218 = load i64, ptr %v218.p
  %v219 = call ptr @"rt.cat8"(i64 %v216, i64 %v217, i64 %v218, i64 %v215, i64 %v213)
  %v220 = getelementptr i8, ptr %v219, i64 %v212
  %v221.p = getelementptr i64, ptr %v210, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = inttoptr i64 %v221 to ptr
  call void @"rt.copy8"(ptr %v220, ptr %v222, i64 %v213)
  %v223 = getelementptr i64, ptr %s29, i64 0
  %v224 = ptrtoint ptr %v219 to i64
  %st133 = getelementptr i64, ptr %v223, i64 0
  store i64 %v224, ptr %st133
  %st134 = getelementptr i64, ptr %v223, i64 1
  store i64 %v214, ptr %st134
  %st135 = getelementptr i64, ptr %v223, i64 2
  store i64 %v215, ptr %st135
  call void @"rt.print_str"(ptr %v223)
  %v225 = add i64 0, 10
  call void @"rt.print_char"(i64 %v225)
  br label %b8
b12:
  %v701 = getelementptr i64, ptr @"rt.meta", i64 0
  %st136 = getelementptr i64, ptr %v701, i64 0
  store i64 %v229, ptr %st136
  %v702 = getelementptr i64, ptr @"rt.meta", i64 0
  %v400.p = getelementptr i64, ptr %v702, i64 0
  %v400 = load i64, ptr %v400.p
  call void @"rt.region_enter"()
  %v703 = getelementptr i64, ptr @"rt.meta", i64 0
  %v401.p = getelementptr i64, ptr %v703, i64 0
  %v401 = load i64, ptr %v401.p
  %v402 = getelementptr i64, ptr %s33, i64 0
  %v403.p = getelementptr i64, ptr %v6, i64 0
  %v403 = load i64, ptr %v403.p
  %v404.p = getelementptr i64, ptr %v6, i64 1
  %v404 = load i64, ptr %v404.p
  %v405.p = getelementptr i64, ptr %v6, i64 2
  %v405 = load i64, ptr %v405.p
  call void @"main.kept"(ptr %v402, i64 %v403, i64 %v404, i64 %v405)
  %v406.p = getelementptr i64, ptr %v402, i64 0
  %v406 = load i64, ptr %v406.p
  %v407 = add i64 0, 1
  %v408 = getelementptr i64, ptr %v402, i64 %v407
  %v409 = getelementptr i64, ptr %s13, i64 0
  %v410.p = getelementptr i64, ptr %v408, i64 0
  %v410 = load i64, ptr %v410.p
  %st137 = getelementptr i64, ptr %v409, i64 0
  store i64 %v410, ptr %st137
  %v411.p = getelementptr i64, ptr %v408, i64 1
  %v411 = load i64, ptr %v411.p
  %st138 = getelementptr i64, ptr %v409, i64 1
  store i64 %v411, ptr %st138
  %v412.p = getelementptr i64, ptr %v408, i64 2
  %v412 = load i64, ptr %v412.p
  %st139 = getelementptr i64, ptr %v409, i64 2
  store i64 %v412, ptr %st139
  %v413.p = getelementptr i64, ptr %v408, i64 3
  %v413 = load i64, ptr %v413.p
  %st140 = getelementptr i64, ptr %v409, i64 3
  store i64 %v413, ptr %st140
  %v414.p = getelementptr i64, ptr %v408, i64 4
  %v414 = load i64, ptr %v414.p
  %st141 = getelementptr i64, ptr %v409, i64 4
  store i64 %v414, ptr %st141
  %v415.p = getelementptr i64, ptr %v408, i64 5
  %v415 = load i64, ptr %v415.p
  %st142 = getelementptr i64, ptr %v409, i64 5
  store i64 %v415, ptr %st142
  %v416.p = getelementptr i64, ptr %v409, i64 0
  %v416 = load i64, ptr %v416.p
  %v417 = add i64 0, 0
  %v418.c = icmp ne i64 %v416, %v417
  %v418 = zext i1 %v418.c to i64
  %c.b12 = icmp ne i64 %v418, 0
  br i1 %c.b12, label %b12.t144, label %b12.e145
b12.t144:
  br label %b23
b12.e145:
  br label %b24
b13:
  br label %b12
b14:
  %v704 = getelementptr i64, ptr @"rt.meta", i64 0
  %st145 = getelementptr i64, ptr %v704, i64 0
  store i64 %v279, ptr %st145
  %v280.p = getelementptr i64, ptr %v278, i64 0
  %v280 = load i64, ptr %v280.p
  %v281.p = getelementptr i64, ptr %v271, i64 1
  %v281 = load i64, ptr %v281.p
  %v282.c = icmp slt i64 %v280, %v281
  %v282 = zext i1 %v282.c to i64
  %c.b14 = icmp ne i64 %v282, 0
  br i1 %c.b14, label %b14.t147, label %b14.e148
b14.t147:
  br label %b15
b14.e148:
  br label %b16
b15:
  call void @"rt.region_enter"()
  %v705 = getelementptr i64, ptr @"rt.meta", i64 0
  %v283.p = getelementptr i64, ptr %v705, i64 0
  %v283 = load i64, ptr %v283.p
  %v284.p = getelementptr i64, ptr %v278, i64 0
  %v284 = load i64, ptr %v284.p
  %v285.p = getelementptr i64, ptr %v271, i64 1
  %v285 = load i64, ptr %v285.p
  %v286.c = icmp uge i64 %v284, %v285
  %v286 = zext i1 %v286.c to i64
  %c.b15 = icmp ne i64 %v286, 0
  br i1 %c.b15, label %b15.t149, label %b15.e150
b15.t149:
  br label %b17
b15.e150:
  br label %b18
b16:
  %v706 = getelementptr i64, ptr @"rt.meta", i64 0
  %st150 = getelementptr i64, ptr %v706, i64 0
  store i64 %v279, ptr %st150
  br label %b13
b17:
  %v287 = add i64 0, 1
  call void @"rt.panic"(i64 %v287)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v288.p = getelementptr i64, ptr %v271, i64 0
  %v288 = load i64, ptr %v288.p
  %v289 = inttoptr i64 %v288 to ptr
  %v290 = add i64 0, 3
  %v291 = mul i64 %v284, %v290
  %v292 = getelementptr i64, ptr %v289, i64 %v291
  %v293 = getelementptr i64, ptr %s29, i64 0
  %v294.p = getelementptr i64, ptr %v292, i64 0
  %v294 = load i64, ptr %v294.p
  %st151 = getelementptr i64, ptr %v293, i64 0
  store i64 %v294, ptr %st151
  %v295.p = getelementptr i64, ptr %v292, i64 1
  %v295 = load i64, ptr %v295.p
  %st152 = getelementptr i64, ptr %v293, i64 1
  store i64 %v295, ptr %st152
  %v296.p = getelementptr i64, ptr %v292, i64 2
  %v296 = load i64, ptr %v296.p
  %st153 = getelementptr i64, ptr %v293, i64 2
  store i64 %v296, ptr %st153
  %v707 = getelementptr i64, ptr @"rt.meta", i64 0
  %v297.p = getelementptr i64, ptr %v707, i64 0
  %v297 = load i64, ptr %v297.p
  call void @"rt.print_str"(ptr %v293)
  %v298 = add i64 0, 10
  call void @"rt.print_char"(i64 %v298)
  %v299 = getelementptr i64, ptr %s30, i64 0
  %v300.p = getelementptr i64, ptr %v293, i64 0
  %v300 = load i64, ptr %v300.p
  %v301.p = getelementptr i64, ptr %v293, i64 1
  %v301 = load i64, ptr %v301.p
  %v302.p = getelementptr i64, ptr %v293, i64 2
  %v302 = load i64, ptr %v302.p
  %v303 = add i64 0, 3
  call void @"main.lines"(ptr %v299, i64 %v300, i64 %v301, i64 %v302, i64 %v303)
  %v304.p = getelementptr i64, ptr %v299, i64 0
  %v304 = load i64, ptr %v304.p
  %v305.p = getelementptr i64, ptr %v299, i64 1
  %v305 = load i64, ptr %v305.p
  %v306 = add i64 0, 2
  %v307 = getelementptr i64, ptr %v299, i64 %v306
  %v308 = getelementptr i64, ptr %s13, i64 0
  %v309.p = getelementptr i64, ptr %v307, i64 0
  %v309 = load i64, ptr %v309.p
  %st154 = getelementptr i64, ptr %v308, i64 0
  store i64 %v309, ptr %st154
  %v310.p = getelementptr i64, ptr %v307, i64 1
  %v310 = load i64, ptr %v310.p
  %st155 = getelementptr i64, ptr %v308, i64 1
  store i64 %v310, ptr %st155
  %v311.p = getelementptr i64, ptr %v307, i64 2
  %v311 = load i64, ptr %v311.p
  %st156 = getelementptr i64, ptr %v308, i64 2
  store i64 %v311, ptr %st156
  %v312.p = getelementptr i64, ptr %v307, i64 3
  %v312 = load i64, ptr %v312.p
  %st157 = getelementptr i64, ptr %v308, i64 3
  store i64 %v312, ptr %st157
  %v313.p = getelementptr i64, ptr %v307, i64 4
  %v313 = load i64, ptr %v313.p
  %st158 = getelementptr i64, ptr %v308, i64 4
  store i64 %v313, ptr %st158
  %v314.p = getelementptr i64, ptr %v307, i64 5
  %v314 = load i64, ptr %v314.p
  %st159 = getelementptr i64, ptr %v308, i64 5
  store i64 %v314, ptr %st159
  %v315.p = getelementptr i64, ptr %v308, i64 0
  %v315 = load i64, ptr %v315.p
  %v316 = add i64 0, 0
  %v317.c = icmp ne i64 %v315, %v316
  %v317 = zext i1 %v317.c to i64
  %c.b18 = icmp ne i64 %v317, 0
  br i1 %c.b18, label %b18.t161, label %b18.e162
b18.t161:
  br label %b20
b18.e162:
  br label %b21
b19:
  %v708 = getelementptr i64, ptr @"rt.meta", i64 0
  %st162 = getelementptr i64, ptr %v708, i64 0
  store i64 %v297, ptr %st162
  %v397 = add i64 0, 1
  %v398.p = getelementptr i64, ptr %v278, i64 0
  %v398 = load i64, ptr %v398.p
  %v399 = add i64 %v398, %v397
  %st163 = getelementptr i64, ptr %v278, i64 0
  store i64 %v399, ptr %st163
  br label %b14
b20:
  %v318 = add i64 0, 1
  %v319 = getelementptr i64, ptr %v308, i64 %v318
  %v320 = getelementptr i64, ptr %s14, i64 0
  %v321.p = getelementptr i64, ptr %v319, i64 0
  %v321 = load i64, ptr %v321.p
  %st164 = getelementptr i64, ptr %v320, i64 0
  store i64 %v321, ptr %st164
  %v322.p = getelementptr i64, ptr %v319, i64 1
  %v322 = load i64, ptr %v322.p
  %st165 = getelementptr i64, ptr %v320, i64 1
  store i64 %v322, ptr %st165
  %v323.p = getelementptr i64, ptr %v319, i64 2
  %v323 = load i64, ptr %v323.p
  %st166 = getelementptr i64, ptr %v320, i64 2
  store i64 %v323, ptr %st166
  %v324.p = getelementptr i64, ptr %v319, i64 3
  %v324 = load i64, ptr %v324.p
  %st167 = getelementptr i64, ptr %v320, i64 3
  store i64 %v324, ptr %st167
  %v325.p = getelementptr i64, ptr %v319, i64 4
  %v325 = load i64, ptr %v325.p
  %st168 = getelementptr i64, ptr %v320, i64 4
  store i64 %v325, ptr %st168
  %v326 = add i64 0, 1
  %v709 = getelementptr i64, ptr @"rt.meta", i64 0
  %st169 = getelementptr i64, ptr %v709, i64 0
  store i64 %v0, ptr %st169
  ret i64 %v326
b21:
  br label %b22
b22:
  %v327 = getelementptr i64, ptr @"str.8", i64 0
  %v328 = add i64 0, 2
  %v329 = add i64 0, 0
  %v330 = getelementptr i64, ptr %s28, i64 0
  %v331 = ptrtoint ptr %v327 to i64
  %st170 = getelementptr i64, ptr %v330, i64 0
  store i64 %v331, ptr %st170
  %st171 = getelementptr i64, ptr %v330, i64 1
  store i64 %v328, ptr %st171
  %st172 = getelementptr i64, ptr %v330, i64 2
  store i64 %v329, ptr %st172
  %v332 = getelementptr i64, ptr %s31, i64 0
  call void @"std/strings.FormatInt"(ptr %v332, i64 %v304)
  %v333.p = getelementptr i64, ptr %v330, i64 1
  %v333 = load i64, ptr %v333.p
  %v334.p = getelementptr i64, ptr %v332, i64 1
  %v334 = load i64, ptr %v334.p
  %v335 = add i64 %v333, %v334
  %v710 = getelementptr i64, ptr @"rt.meta", i64 0
  %v336.p = getelementptr i64, ptr %v710, i64 0
  %v336 = load i64, ptr %v336.p
  %v337.p = getelementptr i64, ptr %v330, i64 0
  %v337 = load i64, ptr %v337.p
  %v338.p = getelementptr i64, ptr %v330, i64 1
  %v338 = load i64, ptr %v338.p
  %v339.p = getelementptr i64, ptr %v330, i64 2
  %v339 = load i64, ptr %v339.p
  %v340 = call ptr @"rt.cat8"(i64 %v337, i64 %v338, i64 %v339, i64 %v336, i64 %v334)
  %v341 = getelementptr i8, ptr %v340, i64 %v333
  %v342.p = getelementptr i64, ptr %v332, i64 0
  %v342 = load i64, ptr %v342.p
  %v343 = inttoptr i64 %v342 to ptr
  call void @"rt.copy8"(ptr %v341, ptr %v343, i64 %v334)
  %v344 = getelementptr i64, ptr %s27, i64 0
  %v345 = ptrtoint ptr %v340 to i64
  %st173 = getelementptr i64, ptr %v344, i64 0
  store i64 %v345, ptr %st173
  %st174 = getelementptr i64, ptr %v344, i64 1
  store i64 %v335, ptr %st174
  %st175 = getelementptr i64, ptr %v344, i64 2
  store i64 %v336, ptr %st175
  %v346 = getelementptr i64, ptr @"str.9", i64 0
  %v347 = add i64 0, 8
  %v348 = add i64 0, 0
  %v349 = getelementptr i64, ptr %s25, i64 0
  %v350 = ptrtoint ptr %v346 to i64
  %st176 = getelementptr i64, ptr %v349, i64 0
  store i64 %v350, ptr %st176
  %st177 = getelementptr i64, ptr %v349, i64 1
  store i64 %v347, ptr %st177
  %st178 = getelementptr i64, ptr %v349, i64 2
  store i64 %v348, ptr %st178
  %v351.p = getelementptr i64, ptr %v344, i64 1
  %v351 = load i64, ptr %v351.p
  %v352.p = getelementptr i64, ptr %v349, i64 1
  %v352 = load i64, ptr %v352.p
  %v353 = add i64 %v351, %v352
  %v711 = getelementptr i64, ptr @"rt.meta", i64 0
  %v354.p = getelementptr i64, ptr %v711, i64 0
  %v354 = load i64, ptr %v354.p
  %v355.p = getelementptr i64, ptr %v344, i64 0
  %v355 = load i64, ptr %v355.p
  %v356.p = getelementptr i64, ptr %v344, i64 1
  %v356 = load i64, ptr %v356.p
  %v357.p = getelementptr i64, ptr %v344, i64 2
  %v357 = load i64, ptr %v357.p
  %v358 = call ptr @"rt.cat8"(i64 %v355, i64 %v356, i64 %v357, i64 %v354, i64 %v352)
  %v359 = getelementptr i8, ptr %v358, i64 %v351
  %v360.p = getelementptr i64, ptr %v349, i64 0
  %v360 = load i64, ptr %v360.p
  %v361 = inttoptr i64 %v360 to ptr
  call void @"rt.copy8"(ptr %v359, ptr %v361, i64 %v352)
  %v362 = getelementptr i64, ptr %s24, i64 0
  %v363 = ptrtoint ptr %v358 to i64
  %st179 = getelementptr i64, ptr %v362, i64 0
  store i64 %v363, ptr %st179
  %st180 = getelementptr i64, ptr %v362, i64 1
  store i64 %v353, ptr %st180
  %st181 = getelementptr i64, ptr %v362, i64 2
  store i64 %v354, ptr %st181
  %v364 = getelementptr i64, ptr %s32, i64 0
  call void @"std/strings.FormatInt"(ptr %v364, i64 %v305)
  %v365.p = getelementptr i64, ptr %v362, i64 1
  %v365 = load i64, ptr %v365.p
  %v366.p = getelementptr i64, ptr %v364, i64 1
  %v366 = load i64, ptr %v366.p
  %v367 = add i64 %v365, %v366
  %v712 = getelementptr i64, ptr @"rt.meta", i64 0
  %v368.p = getelementptr i64, ptr %v712, i64 0
  %v368 = load i64, ptr %v368.p
  %v369.p = getelementptr i64, ptr %v362, i64 0
  %v369 = load i64, ptr %v369.p
  %v370.p = getelementptr i64, ptr %v362, i64 1
  %v370 = load i64, ptr %v370.p
  %v371.p = getelementptr i64, ptr %v362, i64 2
  %v371 = load i64, ptr %v371.p
  %v372 = call ptr @"rt.cat8"(i64 %v369, i64 %v370, i64 %v371, i64 %v368, i64 %v366)
  %v373 = getelementptr i8, ptr %v372, i64 %v365
  %v374.p = getelementptr i64, ptr %v364, i64 0
  %v374 = load i64, ptr %v374.p
  %v375 = inttoptr i64 %v374 to ptr
  call void @"rt.copy8"(ptr %v373, ptr %v375, i64 %v366)
  %v376 = getelementptr i64, ptr %s23, i64 0
  %v377 = ptrtoint ptr %v372 to i64
  %st182 = getelementptr i64, ptr %v376, i64 0
  store i64 %v377, ptr %st182
  %st183 = getelementptr i64, ptr %v376, i64 1
  store i64 %v367, ptr %st183
  %st184 = getelementptr i64, ptr %v376, i64 2
  store i64 %v368, ptr %st184
  %v378 = getelementptr i64, ptr @"str.10", i64 0
  %v379 = add i64 0, 6
  %v380 = add i64 0, 0
  %v381 = getelementptr i64, ptr %s21, i64 0
  %v382 = ptrtoint ptr %v378 to i64
  %st185 = getelementptr i64, ptr %v381, i64 0
  store i64 %v382, ptr %st185
  %st186 = getelementptr i64, ptr %v381, i64 1
  store i64 %v379, ptr %st186
  %st187 = getelementptr i64, ptr %v381, i64 2
  store i64 %v380, ptr %st187
  %v383.p = getelementptr i64, ptr %v376, i64 1
  %v383 = load i64, ptr %v383.p
  %v384.p = getelementptr i64, ptr %v381, i64 1
  %v384 = load i64, ptr %v384.p
  %v385 = add i64 %v383, %v384
  %v713 = getelementptr i64, ptr @"rt.meta", i64 0
  %v386.p = getelementptr i64, ptr %v713, i64 0
  %v386 = load i64, ptr %v386.p
  %v387.p = getelementptr i64, ptr %v376, i64 0
  %v387 = load i64, ptr %v387.p
  %v388.p = getelementptr i64, ptr %v376, i64 1
  %v388 = load i64, ptr %v388.p
  %v389.p = getelementptr i64, ptr %v376, i64 2
  %v389 = load i64, ptr %v389.p
  %v390 = call ptr @"rt.cat8"(i64 %v387, i64 %v388, i64 %v389, i64 %v386, i64 %v384)
  %v391 = getelementptr i8, ptr %v390, i64 %v383
  %v392.p = getelementptr i64, ptr %v381, i64 0
  %v392 = load i64, ptr %v392.p
  %v393 = inttoptr i64 %v392 to ptr
  call void @"rt.copy8"(ptr %v391, ptr %v393, i64 %v384)
  %v394 = getelementptr i64, ptr %s20, i64 0
  %v395 = ptrtoint ptr %v390 to i64
  %st188 = getelementptr i64, ptr %v394, i64 0
  store i64 %v395, ptr %st188
  %st189 = getelementptr i64, ptr %v394, i64 1
  store i64 %v385, ptr %st189
  %st190 = getelementptr i64, ptr %v394, i64 2
  store i64 %v386, ptr %st190
  call void @"rt.print_str"(ptr %v394)
  %v396 = add i64 0, 10
  call void @"rt.print_char"(i64 %v396)
  br label %b19
b23:
  %v419 = add i64 0, 1
  %v420 = getelementptr i64, ptr %v409, i64 %v419
  %v421 = getelementptr i64, ptr %s14, i64 0
  %v422.p = getelementptr i64, ptr %v420, i64 0
  %v422 = load i64, ptr %v422.p
  %st191 = getelementptr i64, ptr %v421, i64 0
  store i64 %v422, ptr %st191
  %v423.p = getelementptr i64, ptr %v420, i64 1
  %v423 = load i64, ptr %v423.p
  %st192 = getelementptr i64, ptr %v421, i64 1
  store i64 %v423, ptr %st192
  %v424.p = getelementptr i64, ptr %v420, i64 2
  %v424 = load i64, ptr %v424.p
  %st193 = getelementptr i64, ptr %v421, i64 2
  store i64 %v424, ptr %st193
  %v425.p = getelementptr i64, ptr %v420, i64 3
  %v425 = load i64, ptr %v425.p
  %st194 = getelementptr i64, ptr %v421, i64 3
  store i64 %v425, ptr %st194
  %v426.p = getelementptr i64, ptr %v420, i64 4
  %v426 = load i64, ptr %v426.p
  %st195 = getelementptr i64, ptr %v421, i64 4
  store i64 %v426, ptr %st195
  %v427 = add i64 0, 0
  br label %b25
b24:
  br label %b25
b25:
  %v428 = phi i64 [ %v427, %b23 ], [ %v406, %b24 ]
  %v714 = getelementptr i64, ptr @"rt.meta", i64 0
  %st196 = getelementptr i64, ptr %v714, i64 0
  store i64 %v400, ptr %st196
  %v429 = getelementptr i64, ptr @"str.11", i64 0
  %v430 = add i64 0, 21
  %v431 = add i64 0, 0
  %v432 = getelementptr i64, ptr %s0, i64 0
  %v433 = ptrtoint ptr %v429 to i64
  %st197 = getelementptr i64, ptr %v432, i64 0
  store i64 %v433, ptr %st197
  %st198 = getelementptr i64, ptr %v432, i64 1
  store i64 %v430, ptr %st198
  %st199 = getelementptr i64, ptr %v432, i64 2
  store i64 %v431, ptr %st199
  %c.b25 = icmp ne i64 %v428, 0
  br i1 %c.b25, label %b25.t201, label %b25.e202
b25.t201:
  br label %b26
b25.e202:
  br label %b27
b26:
  %v434 = getelementptr i64, ptr @"str.12", i64 0
  %v435 = add i64 0, 4
  %v436 = add i64 0, 0
  %v437 = getelementptr i64, ptr %s2, i64 0
  %v438 = ptrtoint ptr %v434 to i64
  %st202 = getelementptr i64, ptr %v437, i64 0
  store i64 %v438, ptr %st202
  %st203 = getelementptr i64, ptr %v437, i64 1
  store i64 %v435, ptr %st203
  %st204 = getelementptr i64, ptr %v437, i64 2
  store i64 %v436, ptr %st204
  br label %b28
b27:
  %v439 = getelementptr i64, ptr @"str.13", i64 0
  %v440 = add i64 0, 5
  %v441 = add i64 0, 0
  %v442 = getelementptr i64, ptr %s3, i64 0
  %v443 = ptrtoint ptr %v439 to i64
  %st205 = getelementptr i64, ptr %v442, i64 0
  store i64 %v443, ptr %st205
  %st206 = getelementptr i64, ptr %v442, i64 1
  store i64 %v440, ptr %st206
  %st207 = getelementptr i64, ptr %v442, i64 2
  store i64 %v441, ptr %st207
  br label %b28
b28:
  %v444 = phi ptr [ %v437, %b26 ], [ %v442, %b27 ]
  %v445.p = getelementptr i64, ptr %v432, i64 1
  %v445 = load i64, ptr %v445.p
  %v446.p = getelementptr i64, ptr %v444, i64 1
  %v446 = load i64, ptr %v446.p
  %v447 = add i64 %v445, %v446
  %v715 = getelementptr i64, ptr @"rt.meta", i64 0
  %v448.p = getelementptr i64, ptr %v715, i64 0
  %v448 = load i64, ptr %v448.p
  %v449.p = getelementptr i64, ptr %v432, i64 0
  %v449 = load i64, ptr %v449.p
  %v450.p = getelementptr i64, ptr %v432, i64 1
  %v450 = load i64, ptr %v450.p
  %v451.p = getelementptr i64, ptr %v432, i64 2
  %v451 = load i64, ptr %v451.p
  %v452 = call ptr @"rt.cat8"(i64 %v449, i64 %v450, i64 %v451, i64 %v448, i64 %v446)
  %v453 = getelementptr i8, ptr %v452, i64 %v445
  %v454.p = getelementptr i64, ptr %v444, i64 0
  %v454 = load i64, ptr %v454.p
  %v455 = inttoptr i64 %v454 to ptr
  call void @"rt.copy8"(ptr %v453, ptr %v455, i64 %v446)
  %v456 = getelementptr i64, ptr %s4, i64 0
  %v457 = ptrtoint ptr %v452 to i64
  %st208 = getelementptr i64, ptr %v456, i64 0
  store i64 %v457, ptr %st208
  %st209 = getelementptr i64, ptr %v456, i64 1
  store i64 %v447, ptr %st209
  %st210 = getelementptr i64, ptr %v456, i64 2
  store i64 %v448, ptr %st210
  call void @"rt.print_str"(ptr %v456)
  %v458 = add i64 0, 10
  call void @"rt.print_char"(i64 %v458)
  %v716 = getelementptr i64, ptr @"rt.meta", i64 0
  %v459.p = getelementptr i64, ptr %v716, i64 0
  %v459 = load i64, ptr %v459.p
  %v460 = add i64 0, 0
  %v461 = add i64 0, 3
  %v462 = getelementptr i64, ptr %s9, i64 0
  %v717 = getelementptr i64, ptr @"rt.meta", i64 0
  %v463.p = getelementptr i64, ptr %v717, i64 0
  %v463 = load i64, ptr %v463.p
  %v464 = getelementptr i64, ptr %s10, i64 0
  %st211 = getelementptr i64, ptr %v464, i64 0
  store i64 %v460, ptr %st211
  %v718 = getelementptr i64, ptr @"rt.meta", i64 0
  %v465.p = getelementptr i64, ptr %v718, i64 0
  %v465 = load i64, ptr %v465.p
  br label %b31
b29:
  %v719 = getelementptr i64, ptr @"rt.meta", i64 0
  %st212 = getelementptr i64, ptr %v719, i64 0
  store i64 %v459, ptr %st212
  %v630 = getelementptr i64, ptr %s39, i64 0
  %v631 = getelementptr i64, ptr @"str.17", i64 0
  %v632 = add i64 0, 23
  %v633 = add i64 0, 0
  %v634 = getelementptr i64, ptr %s25, i64 0
  %v635 = ptrtoint ptr %v631 to i64
  %st213 = getelementptr i64, ptr %v634, i64 0
  store i64 %v635, ptr %st213
  %st214 = getelementptr i64, ptr %v634, i64 1
  store i64 %v632, ptr %st214
  %st215 = getelementptr i64, ptr %v634, i64 2
  store i64 %v633, ptr %st215
  %v636.p = getelementptr i64, ptr %v634, i64 0
  %v636 = load i64, ptr %v636.p
  %v637.p = getelementptr i64, ptr %v634, i64 1
  %v637 = load i64, ptr %v637.p
  %v638.p = getelementptr i64, ptr %v634, i64 2
  %v638 = load i64, ptr %v638.p
  call void @"main.count"(ptr %v630, i64 %v636, i64 %v637, i64 %v638)
  %v639.p = getelementptr i64, ptr %v630, i64 0
  %v639 = load i64, ptr %v639.p
  %v640.p = getelementptr i64, ptr %v630, i64 1
  %v640 = load i64, ptr %v640.p
  %v641.p = getelementptr i64, ptr %v630, i64 2
  %v641 = load i64, ptr %v641.p
  %v642 = add i64 0, 3
  %v643 = getelementptr i64, ptr %v630, i64 %v642
  %v644 = getelementptr i64, ptr %s13, i64 0
  %v645.p = getelementptr i64, ptr %v643, i64 0
  %v645 = load i64, ptr %v645.p
  %st216 = getelementptr i64, ptr %v644, i64 0
  store i64 %v645, ptr %st216
  %v646.p = getelementptr i64, ptr %v643, i64 1
  %v646 = load i64, ptr %v646.p
  %st217 = getelementptr i64, ptr %v644, i64 1
  store i64 %v646, ptr %st217
  %v647.p = getelementptr i64, ptr %v643, i64 2
  %v647 = load i64, ptr %v647.p
  %st218 = getelementptr i64, ptr %v644, i64 2
  store i64 %v647, ptr %st218
  %v648.p = getelementptr i64, ptr %v643, i64 3
  %v648 = load i64, ptr %v648.p
  %st219 = getelementptr i64, ptr %v644, i64 3
  store i64 %v648, ptr %st219
  %v649.p = getelementptr i64, ptr %v643, i64 4
  %v649 = load i64, ptr %v649.p
  %st220 = getelementptr i64, ptr %v644, i64 4
  store i64 %v649, ptr %st220
  %v650.p = getelementptr i64, ptr %v643, i64 5
  %v650 = load i64, ptr %v650.p
  %st221 = getelementptr i64, ptr %v644, i64 5
  store i64 %v650, ptr %st221
  %v651.p = getelementptr i64, ptr %v644, i64 0
  %v651 = load i64, ptr %v651.p
  %v652 = add i64 0, 0
  %v653.c = icmp ne i64 %v651, %v652
  %v653 = zext i1 %v653.c to i64
  %c.b29 = icmp ne i64 %v653, 0
  br i1 %c.b29, label %b29.t223, label %b29.e224
b29.t223:
  br label %b41
b29.e224:
  br label %b42
b30:
  br label %b29
b31:
  %v720 = getelementptr i64, ptr @"rt.meta", i64 0
  %st224 = getelementptr i64, ptr %v720, i64 0
  store i64 %v465, ptr %st224
  %v466.p = getelementptr i64, ptr %v464, i64 0
  %v466 = load i64, ptr %v466.p
  %v467.c = icmp slt i64 %v466, %v461
  %v467 = zext i1 %v467.c to i64
  %c.b31 = icmp ne i64 %v467, 0
  br i1 %c.b31, label %b31.t226, label %b31.e227
b31.t226:
  br label %b32
b31.e227:
  br label %b33
b32:
  call void @"rt.region_enter"()
  %v721 = getelementptr i64, ptr @"rt.meta", i64 0
  %v468.p = getelementptr i64, ptr %v721, i64 0
  %v468 = load i64, ptr %v468.p
  %v469.p = getelementptr i64, ptr %v464, i64 0
  %v469 = load i64, ptr %v469.p
  %v722 = getelementptr i64, ptr @"rt.meta", i64 0
  %v470.p = getelementptr i64, ptr %v722, i64 0
  %v470 = load i64, ptr %v470.p
  %v471 = getelementptr i64, ptr %s34, i64 0
  %v472.p = getelementptr i64, ptr %v6, i64 0
  %v472 = load i64, ptr %v472.p
  %v473.p = getelementptr i64, ptr %v6, i64 1
  %v473 = load i64, ptr %v473.p
  %v474.p = getelementptr i64, ptr %v6, i64 2
  %v474 = load i64, ptr %v474.p
  call void @"main.early"(ptr %v471, i64 %v472, i64 %v473, i64 %v474, i64 %v469)
  %v475.p = getelementptr i64, ptr %v471, i64 0
  %v475 = load i64, ptr %v475.p
  %v476 = add i64 0, 1
  %v477 = getelementptr i64, ptr %v471, i64 %v476
  %v478 = getelementptr i64, ptr %s13, i64 0
  %v479.p = getelementptr i64, ptr %v477, i64 0
  %v479 = load i64, ptr %v479.p
  %st227 = getelementptr i64, ptr %v478, i64 0
  store i64 %v479, ptr %st227
  %v480.p = getelementptr i64, ptr %v477, i64 1
  %v480 = load i64, ptr %v480.p
  %st228 = getelementptr i64, ptr %v478, i64 1
  store i64 %v480, ptr %st228
  %v481.p = getelementptr i64, ptr %v477, i64 2
  %v481 = load i64, ptr %v481.p
  %st229 = getelementptr i64, ptr %v478, i64 2
  store i64 %v481, ptr %st229
  %v482.p = getelementptr i64, ptr %v477, i64 3
  %v482 = load i64, ptr %v482.p
  %st230 = getelementptr i64, ptr %v478, i64 3
  store i64 %v482, ptr %st230
  %v483.p = getelementptr i64, ptr %v477, i64 4
  %v483 = load i64, ptr %v483.p
  %st231 = getelementptr i64, ptr %v478, i64 4
  store i64 %v483, ptr %st231
  %v484.p = getelementptr i64, ptr %v477, i64 5
  %v484 = load i64, ptr %v484.p
  %st232 = getelementptr i64, ptr %v478, i64 5
  store i64 %v484, ptr %st232
  %v485.p = getelementptr i64, ptr %v478, i64 0
  %v485 = load i64, ptr %v485.p
  %v486 = add i64 0, 0
  %v487.c = icmp eq i64 %v485, %v486
  %v487 = zext i1 %v487.c to i64
  %c.b32 = icmp ne i64 %v487, 0
  br i1 %c.b32, label %b32.t234, label %b32.e235
b32.t234:
  br label %b35
b32.e235:
  br label %b36
b33:
  %v723 = getelementptr i64, ptr @"rt.meta", i64 0
  %st235 = getelementptr i64, ptr %v723, i64 0
  store i64 %v465, ptr %st235
  br label %b30
b34:
  %v724 = getelementptr i64, ptr @"rt.meta", i64 0
  %st236 = getelementptr i64, ptr %v724, i64 0
  store i64 %v470, ptr %st236
  %v627 = add i64 0, 1
  %v628.p = getelementptr i64, ptr %v464, i64 0
  %v628 = load i64, ptr %v628.p
  %v629 = add i64 %v628, %v627
  %st237 = getelementptr i64, ptr %v464, i64 0
  store i64 %v629, ptr %st237
  br label %b31
b35:
  %v488 = getelementptr i64, ptr @"str.14", i64 0
  %v489 = add i64 0, 6
  %v490 = add i64 0, 0
  %v491 = getelementptr i64, ptr %s4, i64 0
  %v492 = ptrtoint ptr %v488 to i64
  %st238 = getelementptr i64, ptr %v491, i64 0
  store i64 %v492, ptr %st238
  %st239 = getelementptr i64, ptr %v491, i64 1
  store i64 %v489, ptr %st239
  %st240 = getelementptr i64, ptr %v491, i64 2
  store i64 %v490, ptr %st240
  %v493 = getelementptr i64, ptr %s35, i64 0
  call void @"std/strings.FormatInt"(ptr %v493, i64 %v469)
  %v494.p = getelementptr i64, ptr %v491, i64 1
  %v494 = load i64, ptr %v494.p
  %v495.p = getelementptr i64, ptr %v493, i64 1
  %v495 = load i64, ptr %v495.p
  %v496 = add i64 %v494, %v495
  %v725 = getelementptr i64, ptr @"rt.meta", i64 0
  %v497.p = getelementptr i64, ptr %v725, i64 0
  %v497 = load i64, ptr %v497.p
  %v498.p = getelementptr i64, ptr %v491, i64 0
  %v498 = load i64, ptr %v498.p
  %v499.p = getelementptr i64, ptr %v491, i64 1
  %v499 = load i64, ptr %v499.p
  %v500.p = getelementptr i64, ptr %v491, i64 2
  %v500 = load i64, ptr %v500.p
  %v501 = call ptr @"rt.cat8"(i64 %v498, i64 %v499, i64 %v500, i64 %v497, i64 %v495)
  %v502 = getelementptr i8, ptr %v501, i64 %v494
  %v503.p = getelementptr i64, ptr %v493, i64 0
  %v503 = load i64, ptr %v503.p
  %v504 = inttoptr i64 %v503 to ptr
  call void @"rt.copy8"(ptr %v502, ptr %v504, i64 %v495)
  %v505 = getelementptr i64, ptr %s3, i64 0
  %v506 = ptrtoint ptr %v501 to i64
  %st241 = getelementptr i64, ptr %v505, i64 0
  store i64 %v506, ptr %st241
  %st242 = getelementptr i64, ptr %v505, i64 1
  store i64 %v496, ptr %st242
  %st243 = getelementptr i64, ptr %v505, i64 2
  store i64 %v497, ptr %st243
  %v507 = getelementptr i64, ptr @"str.3", i64 0
  %v508 = add i64 0, 2
  %v509 = add i64 0, 0
  %v510 = getelementptr i64, ptr %s2, i64 0
  %v511 = ptrtoint ptr %v507 to i64
  %st244 = getelementptr i64, ptr %v510, i64 0
  store i64 %v511, ptr %st244
  %st245 = getelementptr i64, ptr %v510, i64 1
  store i64 %v508, ptr %st245
  %st246 = getelementptr i64, ptr %v510, i64 2
  store i64 %v509, ptr %st246
  %v512.p = getelementptr i64, ptr %v505, i64 1
  %v512 = load i64, ptr %v512.p
  %v513.p = getelementptr i64, ptr %v510, i64 1
  %v513 = load i64, ptr %v513.p
  %v514 = add i64 %v512, %v513
  %v726 = getelementptr i64, ptr @"rt.meta", i64 0
  %v515.p = getelementptr i64, ptr %v726, i64 0
  %v515 = load i64, ptr %v515.p
  %v516.p = getelementptr i64, ptr %v505, i64 0
  %v516 = load i64, ptr %v516.p
  %v517.p = getelementptr i64, ptr %v505, i64 1
  %v517 = load i64, ptr %v517.p
  %v518.p = getelementptr i64, ptr %v505, i64 2
  %v518 = load i64, ptr %v518.p
  %v519 = call ptr @"rt.cat8"(i64 %v516, i64 %v517, i64 %v518, i64 %v515, i64 %v513)
  %v520 = getelementptr i8, ptr %v519, i64 %v512
  %v521.p = getelementptr i64, ptr %v510, i64 0
  %v521 = load i64, ptr %v521.p
  %v522 = inttoptr i64 %v521 to ptr
  call void @"rt.copy8"(ptr %v520, ptr %v522, i64 %v513)
  %v523 = getelementptr i64, ptr %s0, i64 0
  %v524 = ptrtoint ptr %v519 to i64
  %st247 = getelementptr i64, ptr %v523, i64 0
  store i64 %v524, ptr %st247
  %st248 = getelementptr i64, ptr %v523, i64 1
  store i64 %v514, ptr %st248
  %st249 = getelementptr i64, ptr %v523, i64 2
  store i64 %v515, ptr %st249
  %v525 = getelementptr i64, ptr %s36, i64 0
  call void @"std/strings.FormatInt"(ptr %v525, i64 %v475)
  %v526.p = getelementptr i64, ptr %v523, i64 1
  %v526 = load i64, ptr %v526.p
  %v527.p = getelementptr i64, ptr %v525, i64 1
  %v527 = load i64, ptr %v527.p
  %v528 = add i64 %v526, %v527
  %v727 = getelementptr i64, ptr @"rt.meta", i64 0
  %v529.p = getelementptr i64, ptr %v727, i64 0
  %v529 = load i64, ptr %v529.p
  %v530.p = getelementptr i64, ptr %v523, i64 0
  %v530 = load i64, ptr %v530.p
  %v531.p = getelementptr i64, ptr %v523, i64 1
  %v531 = load i64, ptr %v531.p
  %v532.p = getelementptr i64, ptr %v523, i64 2
  %v532 = load i64, ptr %v532.p
  %v533 = call ptr @"rt.cat8"(i64 %v530, i64 %v531, i64 %v532, i64 %v529, i64 %v527)
  %v534 = getelementptr i8, ptr %v533, i64 %v526
  %v535.p = getelementptr i64, ptr %v525, i64 0
  %v535 = load i64, ptr %v535.p
  %v536 = inttoptr i64 %v535 to ptr
  call void @"rt.copy8"(ptr %v534, ptr %v536, i64 %v527)
  %v537 = getelementptr i64, ptr %s5, i64 0
  %v538 = ptrtoint ptr %v533 to i64
  %st250 = getelementptr i64, ptr %v537, i64 0
  store i64 %v538, ptr %st250
  %st251 = getelementptr i64, ptr %v537, i64 1
  store i64 %v528, ptr %st251
  %st252 = getelementptr i64, ptr %v537, i64 2
  store i64 %v529, ptr %st252
  call void @"rt.print_str"(ptr %v537)
  %v539 = add i64 0, 10
  call void @"rt.print_char"(i64 %v539)
  br label %b40
b36:
  %v540 = add i64 0, 1
  %v541 = getelementptr i64, ptr %v478, i64 %v540
  %v542 = getelementptr i64, ptr %s14, i64 0
  %v543.p = getelementptr i64, ptr %v541, i64 0
  %v543 = load i64, ptr %v543.p
  %st253 = getelementptr i64, ptr %v542, i64 0
  store i64 %v543, ptr %st253
  %v544.p = getelementptr i64, ptr %v541, i64 1
  %v544 = load i64, ptr %v544.p
  %st254 = getelementptr i64, ptr %v542, i64 1
  store i64 %v544, ptr %st254
  %v545.p = getelementptr i64, ptr %v541, i64 2
  %v545 = load i64, ptr %v545.p
  %st255 = getelementptr i64, ptr %v542, i64 2
  store i64 %v545, ptr %st255
  %v546.p = getelementptr i64, ptr %v541, i64 3
  %v546 = load i64, ptr %v546.p
  %st256 = getelementptr i64, ptr %v542, i64 3
  store i64 %v546, ptr %st256
  %v547.p = getelementptr i64, ptr %v541, i64 4
  %v547 = load i64, ptr %v547.p
  %st257 = getelementptr i64, ptr %v542, i64 4
  store i64 %v547, ptr %st257
  %v548.p = getelementptr i64, ptr %v542, i64 0
  %v548 = load i64, ptr %v548.p
  %v549 = add i64 0, 0
  %v550.c = icmp eq i64 %v548, %v549
  %v550 = zext i1 %v550.c to i64
  %c.b36 = icmp ne i64 %v550, 0
  br i1 %c.b36, label %b36.t259, label %b36.e260
b36.t259:
  br label %b38
b36.e260:
  br label %b37
b37:
  %v588 = getelementptr i64, ptr @"str.14", i64 0
  %v589 = add i64 0, 6
  %v590 = add i64 0, 0
  %v591 = getelementptr i64, ptr %s21, i64 0
  %v592 = ptrtoint ptr %v588 to i64
  %st260 = getelementptr i64, ptr %v591, i64 0
  store i64 %v592, ptr %st260
  %st261 = getelementptr i64, ptr %v591, i64 1
  store i64 %v589, ptr %st261
  %st262 = getelementptr i64, ptr %v591, i64 2
  store i64 %v590, ptr %st262
  %v593 = getelementptr i64, ptr %s38, i64 0
  call void @"std/strings.FormatInt"(ptr %v593, i64 %v469)
  %v594.p = getelementptr i64, ptr %v591, i64 1
  %v594 = load i64, ptr %v594.p
  %v595.p = getelementptr i64, ptr %v593, i64 1
  %v595 = load i64, ptr %v595.p
  %v596 = add i64 %v594, %v595
  %v728 = getelementptr i64, ptr @"rt.meta", i64 0
  %v597.p = getelementptr i64, ptr %v728, i64 0
  %v597 = load i64, ptr %v597.p
  %v598.p = getelementptr i64, ptr %v591, i64 0
  %v598 = load i64, ptr %v598.p
  %v599.p = getelementptr i64, ptr %v591, i64 1
  %v599 = load i64, ptr %v599.p
  %v600.p = getelementptr i64, ptr %v591, i64 2
  %v600 = load i64, ptr %v600.p
  %v601 = call ptr @"rt.cat8"(i64 %v598, i64 %v599, i64 %v600, i64 %v597, i64 %v595)
  %v602 = getelementptr i8, ptr %v601, i64 %v594
  %v603.p = getelementptr i64, ptr %v593, i64 0
  %v603 = load i64, ptr %v603.p
  %v604 = inttoptr i64 %v603 to ptr
  call void @"rt.copy8"(ptr %v602, ptr %v604, i64 %v595)
  %v605 = getelementptr i64, ptr %s23, i64 0
  %v606 = ptrtoint ptr %v601 to i64
  %st263 = getelementptr i64, ptr %v605, i64 0
  store i64 %v606, ptr %st263
  %st264 = getelementptr i64, ptr %v605, i64 1
  store i64 %v596, ptr %st264
  %st265 = getelementptr i64, ptr %v605, i64 2
  store i64 %v597, ptr %st265
  %v607 = getelementptr i64, ptr @"str.16", i64 0
  %v608 = add i64 0, 3
  %v609 = add i64 0, 0
  %v610 = getelementptr i64, ptr %s24, i64 0
  %v611 = ptrtoint ptr %v607 to i64
  %st266 = getelementptr i64, ptr %v610, i64 0
  store i64 %v611, ptr %st266
  %st267 = getelementptr i64, ptr %v610, i64 1
  store i64 %v608, ptr %st267
  %st268 = getelementptr i64, ptr %v610, i64 2
  store i64 %v609, ptr %st268
  %v612.p = getelementptr i64, ptr %v605, i64 1
  %v612 = load i64, ptr %v612.p
  %v613.p = getelementptr i64, ptr %v610, i64 1
  %v613 = load i64, ptr %v613.p
  %v614 = add i64 %v612, %v613
  %v729 = getelementptr i64, ptr @"rt.meta", i64 0
  %v615.p = getelementptr i64, ptr %v729, i64 0
  %v615 = load i64, ptr %v615.p
  %v616.p = getelementptr i64, ptr %v605, i64 0
  %v616 = load i64, ptr %v616.p
  %v617.p = getelementptr i64, ptr %v605, i64 1
  %v617 = load i64, ptr %v617.p
  %v618.p = getelementptr i64, ptr %v605, i64 2
  %v618 = load i64, ptr %v618.p
  %v619 = call ptr @"rt.cat8"(i64 %v616, i64 %v617, i64 %v618, i64 %v615, i64 %v613)
  %v620 = getelementptr i8, ptr %v619, i64 %v612
  %v621.p = getelementptr i64, ptr %v610, i64 0
  %v621 = load i64, ptr %v621.p
  %v622 = inttoptr i64 %v621 to ptr
  call void @"rt.copy8"(ptr %v620, ptr %v622, i64 %v613)
  %v623 = getelementptr i64, ptr %s25, i64 0
  %v624 = ptrtoint ptr %v619 to i64
  %st269 = getelementptr i64, ptr %v623, i64 0
  store i64 %v624, ptr %st269
  %st270 = getelementptr i64, ptr %v623, i64 1
  store i64 %v614, ptr %st270
  %st271 = getelementptr i64, ptr %v623, i64 2
  store i64 %v615, ptr %st271
  br label %b39
b38:
  %v551 = getelementptr i64, ptr @"str.14", i64 0
  %v552 = add i64 0, 6
  %v553 = add i64 0, 0
  %v554 = getelementptr i64, ptr %s6, i64 0
  %v555 = ptrtoint ptr %v551 to i64
  %st272 = getelementptr i64, ptr %v554, i64 0
  store i64 %v555, ptr %st272
  %st273 = getelementptr i64, ptr %v554, i64 1
  store i64 %v552, ptr %st273
  %st274 = getelementptr i64, ptr %v554, i64 2
  store i64 %v553, ptr %st274
  %v556 = getelementptr i64, ptr %s37, i64 0
  call void @"std/strings.FormatInt"(ptr %v556, i64 %v469)
  %v557.p = getelementptr i64, ptr %v554, i64 1
  %v557 = load i64, ptr %v557.p
  %v558.p = getelementptr i64, ptr %v556, i64 1
  %v558 = load i64, ptr %v558.p
  %v559 = add i64 %v557, %v558
  %v730 = getelementptr i64, ptr @"rt.meta", i64 0
  %v560.p = getelementptr i64, ptr %v730, i64 0
  %v560 = load i64, ptr %v560.p
  %v561.p = getelementptr i64, ptr %v554, i64 0
  %v561 = load i64, ptr %v561.p
  %v562.p = getelementptr i64, ptr %v554, i64 1
  %v562 = load i64, ptr %v562.p
  %v563.p = getelementptr i64, ptr %v554, i64 2
  %v563 = load i64, ptr %v563.p
  %v564 = call ptr @"rt.cat8"(i64 %v561, i64 %v562, i64 %v563, i64 %v560, i64 %v558)
  %v565 = getelementptr i8, ptr %v564, i64 %v557
  %v566.p = getelementptr i64, ptr %v556, i64 0
  %v566 = load i64, ptr %v566.p
  %v567 = inttoptr i64 %v566 to ptr
  call void @"rt.copy8"(ptr %v565, ptr %v567, i64 %v558)
  %v568 = getelementptr i64, ptr %s7, i64 0
  %v569 = ptrtoint ptr %v564 to i64
  %st275 = getelementptr i64, ptr %v568, i64 0
  store i64 %v569, ptr %st275
  %st276 = getelementptr i64, ptr %v568, i64 1
  store i64 %v559, ptr %st276
  %st277 = getelementptr i64, ptr %v568, i64 2
  store i64 %v560, ptr %st277
  %v570 = getelementptr i64, ptr @"str.15", i64 0
  %v571 = add i64 0, 20
  %v572 = add i64 0, 0
  %v573 = getelementptr i64, ptr %s8, i64 0
  %v574 = ptrtoint ptr %v570 to i64
  %st278 = getelementptr i64, ptr %v573, i64 0
  store i64 %v574, ptr %st278
  %st279 = getelementptr i64, ptr %v573, i64 1
  store i64 %v571, ptr %st279
  %st280 = getelementptr i64, ptr %v573, i64 2
  store i64 %v572, ptr %st280
  %v575.p = getelementptr i64, ptr %v568, i64 1
  %v575 = load i64, ptr %v575.p
  %v576.p = getelementptr i64, ptr %v573, i64 1
  %v576 = load i64, ptr %v576.p
  %v577 = add i64 %v575, %v576
  %v731 = getelementptr i64, ptr @"rt.meta", i64 0
  %v578.p = getelementptr i64, ptr %v731, i64 0
  %v578 = load i64, ptr %v578.p
  %v579.p = getelementptr i64, ptr %v568, i64 0
  %v579 = load i64, ptr %v579.p
  %v580.p = getelementptr i64, ptr %v568, i64 1
  %v580 = load i64, ptr %v580.p
  %v581.p = getelementptr i64, ptr %v568, i64 2
  %v581 = load i64, ptr %v581.p
  %v582 = call ptr @"rt.cat8"(i64 %v579, i64 %v580, i64 %v581, i64 %v578, i64 %v576)
  %v583 = getelementptr i8, ptr %v582, i64 %v575
  %v584.p = getelementptr i64, ptr %v573, i64 0
  %v584 = load i64, ptr %v584.p
  %v585 = inttoptr i64 %v584 to ptr
  call void @"rt.copy8"(ptr %v583, ptr %v585, i64 %v576)
  %v586 = getelementptr i64, ptr %s20, i64 0
  %v587 = ptrtoint ptr %v582 to i64
  %st281 = getelementptr i64, ptr %v586, i64 0
  store i64 %v587, ptr %st281
  %st282 = getelementptr i64, ptr %v586, i64 1
  store i64 %v577, ptr %st282
  %st283 = getelementptr i64, ptr %v586, i64 2
  store i64 %v578, ptr %st283
  br label %b39
b39:
  %v625 = phi ptr [ %v623, %b37 ], [ %v586, %b38 ]
  call void @"rt.print_str"(ptr %v625)
  %v626 = add i64 0, 10
  call void @"rt.print_char"(i64 %v626)
  br label %b40
b40:
  br label %b34
b41:
  %v654 = add i64 0, 1
  %v655 = getelementptr i64, ptr %v644, i64 %v654
  %v656 = getelementptr i64, ptr %s14, i64 0
  %v657.p = getelementptr i64, ptr %v655, i64 0
  %v657 = load i64, ptr %v657.p
  %st284 = getelementptr i64, ptr %v656, i64 0
  store i64 %v657, ptr %st284
  %v658.p = getelementptr i64, ptr %v655, i64 1
  %v658 = load i64, ptr %v658.p
  %st285 = getelementptr i64, ptr %v656, i64 1
  store i64 %v658, ptr %st285
  %v659.p = getelementptr i64, ptr %v655, i64 2
  %v659 = load i64, ptr %v659.p
  %st286 = getelementptr i64, ptr %v656, i64 2
  store i64 %v659, ptr %st286
  %v660.p = getelementptr i64, ptr %v655, i64 3
  %v660 = load i64, ptr %v660.p
  %st287 = getelementptr i64, ptr %v656, i64 3
  store i64 %v660, ptr %st287
  %v661.p = getelementptr i64, ptr %v655, i64 4
  %v661 = load i64, ptr %v661.p
  %st288 = getelementptr i64, ptr %v656, i64 4
  store i64 %v661, ptr %st288
  %v662.p = getelementptr i64, ptr %v656, i64 0
  %v662 = load i64, ptr %v662.p
  %v663 = add i64 0, 1
  %v664.c = icmp eq i64 %v662, %v663
  %v664 = zext i1 %v664.c to i64
  %c.b41 = icmp ne i64 %v664, 0
  br i1 %c.b41, label %b41.t290, label %b41.e291
b41.t290:
  br label %b44
b41.e291:
  br label %b43
b42:
  br label %b46
b43:
  %v670 = getelementptr i64, ptr @"str.19", i64 0
  %v671 = add i64 0, 10
  %v672 = add i64 0, 0
  %v673 = getelementptr i64, ptr %s24, i64 0
  %v674 = ptrtoint ptr %v670 to i64
  %st291 = getelementptr i64, ptr %v673, i64 0
  store i64 %v674, ptr %st291
  %st292 = getelementptr i64, ptr %v673, i64 1
  store i64 %v671, ptr %st292
  %st293 = getelementptr i64, ptr %v673, i64 2
  store i64 %v672, ptr %st293
  br label %b45
b44:
  %v665 = getelementptr i64, ptr @"str.18", i64 0
  %v666 = add i64 0, 18
  %v667 = add i64 0, 0
  %v668 = getelementptr i64, ptr %s25, i64 0
  %v669 = ptrtoint ptr %v665 to i64
  %st294 = getelementptr i64, ptr %v668, i64 0
  store i64 %v669, ptr %st294
  %st295 = getelementptr i64, ptr %v668, i64 1
  store i64 %v666, ptr %st295
  %st296 = getelementptr i64, ptr %v668, i64 2
  store i64 %v667, ptr %st296
  br label %b45
b45:
  %v675 = phi ptr [ %v673, %b43 ], [ %v668, %b44 ]
  call void @"rt.print_str"(ptr %v675)
  %v676 = add i64 0, 10
  call void @"rt.print_char"(i64 %v676)
  br label %b46
b46:
  %v677 = add i64 0, 0
  %v732 = getelementptr i64, ptr @"rt.meta", i64 0
  %st297 = getelementptr i64, ptr %v732, i64 0
  store i64 %v0, ptr %st297
  ret i64 %v677
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
  %v258 = phi i64 [ %v262, %b59.t96 ], [ %v367, %b84.e142 ], [ %v367, %b85.e144 ], [ %v367, %b86.e146 ], [ %v367, %b87.t147 ], [ %v361, %b88 ]
  %st97 = getelementptr i64, ptr %v1, i64 2573
  store i64 %v258, ptr %st97
  %v385 = call i64 @"main.main"()
  call void @"rt.depth_report"()
  %v386 = add i64 0, 256
  %v387.c = icmp uge i64 %v385, %v386
  %v387 = zext i1 %v387.c to i64
  %c.b60 = icmp ne i64 %v387, 0
  br i1 %c.b60, label %b60.t99, label %b60.e100
b60.t99:
  br label %b90
b60.e100:
  br label %b91
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
  br i1 %c.b63, label %b63.t101, label %b63.e102
b63.t101:
  br label %b64
b63.e102:
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
  br i1 %c.b64, label %b64.t103, label %b64.e104
b64.t103:
  br label %b65
b64.e104:
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
  br i1 %c.b65, label %b65.t105, label %b65.e106
b65.t105:
  br label %b66
b65.e106:
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
  br i1 %c.b66, label %b66.t107, label %b66.e108
b66.t107:
  br label %b67
b66.e108:
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
  br i1 %c.b67, label %b67.t109, label %b67.e110
b67.t109:
  br label %b68
b67.e110:
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
  br i1 %c.b68, label %b68.t111, label %b68.e112
b68.t111:
  br label %b69
b68.e112:
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
  br i1 %c.b69, label %b69.t113, label %b69.e114
b69.t113:
  br label %b70
b69.e114:
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
  br i1 %c.b70, label %b70.t115, label %b70.e116
b70.t115:
  br label %b71
b70.e116:
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
  br i1 %c.b71, label %b71.t117, label %b71.e118
b71.t117:
  br label %b72
b71.e118:
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
  br i1 %c.b72, label %b72.t119, label %b72.e120
b72.t119:
  br label %b73
b72.e120:
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
  br i1 %c.b73, label %b73.t121, label %b73.e122
b73.t121:
  br label %b74
b73.e122:
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
  br i1 %c.b74, label %b74.t123, label %b74.e124
b74.t123:
  br label %b75
b74.e124:
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
  br i1 %c.b75, label %b75.t125, label %b75.e126
b75.t125:
  br label %b76
b75.e126:
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
  br i1 %c.b76, label %b76.t127, label %b76.e128
b76.t127:
  br label %b77
b76.e128:
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
  br i1 %c.b77, label %b77.t129, label %b77.e130
b77.t129:
  br label %b78
b77.e130:
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
  br i1 %c.b78, label %b78.t131, label %b78.e132
b78.t131:
  br label %b79
b78.e132:
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
  br i1 %c.b79, label %b79.t133, label %b79.e134
b79.t133:
  br label %b80
b79.e134:
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
  br i1 %c.b80, label %b80.t135, label %b80.e136
b80.t135:
  br label %b81
b80.e136:
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
  br i1 %c.b81, label %b81.t137, label %b81.e138
b81.t137:
  br label %b82
b81.e138:
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
  br i1 %c.b83, label %b83.t139, label %b83.e140
b83.t139:
  br label %b84
b83.e140:
  br label %b85
b84:
  %v370 = add i64 0, 19
  %v371.c = icmp sgt i64 %v362, %v370
  %v371 = zext i1 %v371.c to i64
  %c.b84 = icmp ne i64 %v371, 0
  br i1 %c.b84, label %b84.t141, label %b84.e142
b84.t141:
  br label %b88
b84.e142:
  br label %b60
b85:
  %v372 = add i64 0, 48
  %v373.c = icmp sge i64 %v366, %v372
  %v373 = zext i1 %v373.c to i64
  %c.b85 = icmp ne i64 %v373, 0
  br i1 %c.b85, label %b85.t143, label %b85.e144
b85.t143:
  br label %b86
b85.e144:
  br label %b60
b86:
  %v374 = add i64 0, 57
  %v375.c = icmp sle i64 %v366, %v374
  %v375 = zext i1 %v375.c to i64
  %c.b86 = icmp ne i64 %v375, 0
  br i1 %c.b86, label %b86.t145, label %b86.e146
b86.t145:
  br label %b87
b86.e146:
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
  br i1 %c.b87, label %b87.t147, label %b87.e148
b87.t147:
  br label %b60
b87.e148:
  br label %b89
b88:
  br label %b60
b89:
  %v383 = add i64 0, 1
  %v384 = add i64 %v362, %v383
  br label %b83
b90:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b91:
  %v388 = add i64 0, 231
  %v389 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v388, i64 %v385)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 0)
  unreachable
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
  %v20 = getelementptr i64, ptr @"str.36", i64 0
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
  %v74 = getelementptr i64, ptr @"str.44", i64 0
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
  %v27 = getelementptr i64, ptr @"str.37", i64 0
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
  %v34 = getelementptr i64, ptr @"str.38", i64 0
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
  %v41 = getelementptr i64, ptr @"str.39", i64 0
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
  %v48 = getelementptr i64, ptr @"str.40", i64 0
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
  %v55 = getelementptr i64, ptr @"str.41", i64 0
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
  %v62 = getelementptr i64, ptr @"str.42", i64 0
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
  %v69 = getelementptr i64, ptr @"str.43", i64 0
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
  %v114 = add i64 0, 58
  call void @"rt.print_char"(i64 %v114)
  call void @"rt.print_int"(i64 %v14)
  %v115 = add i64 0, 58
  call void @"rt.print_char"(i64 %v115)
  call void @"rt.print_int"(i64 %v18)
  %v116 = add i64 0, 10
  call void @"rt.print_char"(i64 %v116)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v81 = getelementptr i64, ptr @"str.45", i64 0
  %v82 = add i64 0, 19
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
  %v88 = getelementptr i64, ptr @"str.46", i64 0
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
  %v95 = getelementptr i64, ptr @"str.47", i64 0
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
  %v100 = add i64 0, 3
  %v101.c = icmp eq i64 %v10, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b22 = icmp ne i64 %v101, 0
  br i1 %c.b22, label %b22.t58, label %b22.e59
b22.t58:
  br label %b23
b22.e59:
  br label %b24
b23:
  %v102 = getelementptr i64, ptr @"str.48", i64 0
  %v103 = add i64 0, 19
  %v104 = add i64 0, 0
  %v105 = getelementptr i64, ptr %s12, i64 0
  %v106 = ptrtoint ptr %v102 to i64
  %st59 = getelementptr i64, ptr %v105, i64 0
  store i64 %v106, ptr %st59
  %st60 = getelementptr i64, ptr %v105, i64 1
  store i64 %v103, ptr %st60
  %st61 = getelementptr i64, ptr %v105, i64 2
  store i64 %v104, ptr %st61
  call void @"rt.print_str"(ptr %v105)
  br label %b16
b24:
  %v107 = add i64 0, 4
  %v108.c = icmp eq i64 %v10, %v107
  %v108 = zext i1 %v108.c to i64
  %c.b24 = icmp ne i64 %v108, 0
  br i1 %c.b24, label %b24.t63, label %b24.e64
b24.t63:
  br label %b25
b24.e64:
  br label %b26
b25:
  %v109 = getelementptr i64, ptr @"str.49", i64 0
  %v110 = add i64 0, 25
  %v111 = add i64 0, 0
  %v112 = getelementptr i64, ptr %s13, i64 0
  %v113 = ptrtoint ptr %v109 to i64
  %st64 = getelementptr i64, ptr %v112, i64 0
  store i64 %v113, ptr %st64
  %st65 = getelementptr i64, ptr %v112, i64 1
  store i64 %v110, ptr %st65
  %st66 = getelementptr i64, ptr %v112, i64 2
  store i64 %v111, ptr %st66
  call void @"rt.print_str"(ptr %v112)
  br label %b16
b26:
  br label %b16
}

define internal void @"main.count"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [6 x i64], align 8
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
  %s9.z5 = getelementptr i64, ptr %s9, i64 5
  store i64 0, ptr %s9.z5
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
  %s13 = alloca [6 x i64], align 8
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
  %s22 = alloca [1 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %s23 = alloca [1 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v221 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v221, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v4, i64 0
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v4, i64 2
  %v9 = load i64, ptr %v9.p
  call void @"std/io.Open"(ptr %v6, i64 %v7, i64 %v8, i64 %v9)
  %v10 = add i64 0, 1
  %v11 = getelementptr i64, ptr %v6, i64 %v10
  %v12.p = getelementptr i64, ptr %v11, i64 0
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 0
  %v14.c = icmp ne i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v15 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v0, i64 0
  store i64 %v15, ptr %st5
  %st6 = getelementptr i64, ptr %v0, i64 1
  store i64 %v15, ptr %st6
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v15, ptr %st7
  %v16.p = getelementptr i64, ptr %v11, i64 0
  %v16 = load i64, ptr %v16.p
  %st8 = getelementptr i64, ptr %v0, i64 3
  store i64 %v16, ptr %st8
  %v17.p = getelementptr i64, ptr %v11, i64 1
  %v17 = load i64, ptr %v17.p
  %st9 = getelementptr i64, ptr %v0, i64 4
  store i64 %v17, ptr %st9
  %v18.p = getelementptr i64, ptr %v11, i64 2
  %v18 = load i64, ptr %v18.p
  %st10 = getelementptr i64, ptr %v0, i64 5
  store i64 %v18, ptr %st10
  %v19.p = getelementptr i64, ptr %v11, i64 3
  %v19 = load i64, ptr %v19.p
  %st11 = getelementptr i64, ptr %v0, i64 6
  store i64 %v19, ptr %st11
  %v20.p = getelementptr i64, ptr %v11, i64 4
  %v20 = load i64, ptr %v20.p
  %st12 = getelementptr i64, ptr %v0, i64 7
  store i64 %v20, ptr %st12
  %v21.p = getelementptr i64, ptr %v11, i64 5
  %v21 = load i64, ptr %v21.p
  %st13 = getelementptr i64, ptr %v0, i64 8
  store i64 %v21, ptr %st13
  %v22.p = getelementptr i64, ptr %v0, i64 3
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 0, 0
  %v24.c = icmp ne i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b1 = icmp ne i64 %v24, 0
  br i1 %c.b1, label %b1.t15, label %b1.e16
b1.t15:
  br label %b3
b1.e16:
  br label %b4
b2:
  %v27 = getelementptr i64, ptr %s2, i64 0
  %v28.p = getelementptr i64, ptr %v6, i64 0
  %v28 = load i64, ptr %v28.p
  %st16 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st16
  %v29 = add i64 0, 0
  %v30 = getelementptr i64, ptr %s3, i64 0
  %st17 = getelementptr i64, ptr %v30, i64 0
  store i64 %v29, ptr %st17
  %v31 = add i64 0, 0
  %v32 = getelementptr i64, ptr %s4, i64 0
  %st18 = getelementptr i64, ptr %v32, i64 0
  store i64 %v31, ptr %st18
  %v33 = add i64 0, 0
  %v34 = getelementptr i64, ptr %s5, i64 0
  %st19 = getelementptr i64, ptr %v34, i64 0
  store i64 %v33, ptr %st19
  %v222 = getelementptr i64, ptr @"rt.meta", i64 0
  %v35.p = getelementptr i64, ptr %v222, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = getelementptr i64, ptr %s6, i64 0
  %v37.p = getelementptr i64, ptr %v27, i64 0
  %v37 = load i64, ptr %v37.p
  %st20 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st20
  %v38 = getelementptr i64, ptr %s7, i64 0
  %v223 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v223, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = getelementptr i64, ptr %s8, i64 0
  %v41.p = getelementptr i64, ptr %v36, i64 0
  %v41 = load i64, ptr %v41.p
  %st21 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st21
  %v42 = add i64 0, 1
  %v43 = add i64 0, 0
  %v44 = sub i64 %v43, %v42
  %v45 = getelementptr i64, ptr %s9, i64 0
  %v224 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v224, i64 0
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v40, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 0, 65536
  %v49 = add i64 0, 2
  %v50 = call i64 @"rt.chunk_open"(i64 %v47, i64 %v48, i64 %v49, i64 %v44)
  %v225 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v225, i64 0
  %v51 = load i64, ptr %v51.p
  br label %b8
b3:
  %v25 = add i64 0, 6
  %v26 = getelementptr i64, ptr %v0, i64 %v25
  %v226 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v26, i64 %v226, i64 %v5)
  br label %b4
b4:
  %v227 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v227, i64 0
  store i64 %v5, ptr %st22
  ret void
b5:
  %v228 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v228, i64 0
  store i64 %v35, ptr %st23
  %v204.p = getelementptr i64, ptr %v30, i64 0
  %v204 = load i64, ptr %v204.p
  %v205.p = getelementptr i64, ptr %v32, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v34, i64 0
  %v206 = load i64, ptr %v206.p
  %v207 = getelementptr i64, ptr %s13, i64 0
  %v208 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v207, i64 0
  store i64 %v208, ptr %st24
  %st25 = getelementptr i64, ptr %v0, i64 0
  store i64 %v204, ptr %st25
  %st26 = getelementptr i64, ptr %v0, i64 1
  store i64 %v205, ptr %st26
  %st27 = getelementptr i64, ptr %v0, i64 2
  store i64 %v206, ptr %st27
  %v209.p = getelementptr i64, ptr %v207, i64 0
  %v209 = load i64, ptr %v209.p
  %st28 = getelementptr i64, ptr %v0, i64 3
  store i64 %v209, ptr %st28
  %v210.p = getelementptr i64, ptr %v207, i64 1
  %v210 = load i64, ptr %v210.p
  %st29 = getelementptr i64, ptr %v0, i64 4
  store i64 %v210, ptr %st29
  %v211.p = getelementptr i64, ptr %v207, i64 2
  %v211 = load i64, ptr %v211.p
  %st30 = getelementptr i64, ptr %v0, i64 5
  store i64 %v211, ptr %st30
  %v212.p = getelementptr i64, ptr %v207, i64 3
  %v212 = load i64, ptr %v212.p
  %st31 = getelementptr i64, ptr %v0, i64 6
  store i64 %v212, ptr %st31
  %v213.p = getelementptr i64, ptr %v207, i64 4
  %v213 = load i64, ptr %v213.p
  %st32 = getelementptr i64, ptr %v0, i64 7
  store i64 %v213, ptr %st32
  %v214.p = getelementptr i64, ptr %v207, i64 5
  %v214 = load i64, ptr %v214.p
  %st33 = getelementptr i64, ptr %v0, i64 8
  store i64 %v214, ptr %st33
  %v215.p = getelementptr i64, ptr %v27, i64 0
  %v215 = load i64, ptr %v215.p
  call void @"std/io.Close"(i64 %v215)
  %v216.p = getelementptr i64, ptr %v0, i64 3
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 0
  %v218.c = icmp ne i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b5 = icmp ne i64 %v218, 0
  br i1 %c.b5, label %b5.t35, label %b5.e36
b5.t35:
  br label %b41
b5.e36:
  br label %b42
b6:
  %v188.p = getelementptr i64, ptr %v38, i64 0
  %v188 = load i64, ptr %v188.p
  %v189 = add i64 0, 0
  %v190.c = icmp ne i64 %v188, %v189
  %v190 = zext i1 %v190.c to i64
  %c.b6 = icmp ne i64 %v190, 0
  br i1 %c.b6, label %b6.t37, label %b6.e38
b6.t37:
  br label %b37
b6.e38:
  br label %b38
b7:
  %v177.p = getelementptr i64, ptr %v45, i64 0
  %v177 = load i64, ptr %v177.p
  %st38 = getelementptr i64, ptr %v38, i64 0
  store i64 %v177, ptr %st38
  %v178.p = getelementptr i64, ptr %v45, i64 1
  %v178 = load i64, ptr %v178.p
  %st39 = getelementptr i64, ptr %v38, i64 1
  store i64 %v178, ptr %st39
  %v179.p = getelementptr i64, ptr %v45, i64 2
  %v179 = load i64, ptr %v179.p
  %st40 = getelementptr i64, ptr %v38, i64 2
  store i64 %v179, ptr %st40
  %v180.p = getelementptr i64, ptr %v45, i64 3
  %v180 = load i64, ptr %v180.p
  %st41 = getelementptr i64, ptr %v38, i64 3
  store i64 %v180, ptr %st41
  %v181.p = getelementptr i64, ptr %v45, i64 4
  %v181 = load i64, ptr %v181.p
  %st42 = getelementptr i64, ptr %v38, i64 4
  store i64 %v181, ptr %st42
  %v182.p = getelementptr i64, ptr %v45, i64 5
  %v182 = load i64, ptr %v182.p
  %st43 = getelementptr i64, ptr %v38, i64 5
  store i64 %v182, ptr %st43
  %v183.p = getelementptr i64, ptr %v38, i64 0
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 0
  %v185.c = icmp ne i64 %v183, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b7 = icmp ne i64 %v185, 0
  br i1 %c.b7, label %b7.t45, label %b7.e46
b7.t45:
  br label %b35
b7.e46:
  br label %b36
b8:
  %v229 = getelementptr i64, ptr @"rt.meta", i64 0
  %st46 = getelementptr i64, ptr %v229, i64 0
  store i64 %v51, ptr %st46
  %v52 = add i64 0, 1
  %c.b8 = icmp ne i64 %v52, 0
  br i1 %c.b8, label %b8.t48, label %b8.e49
b8.t48:
  br label %b9
b8.e49:
  br label %b10
b9:
  call void @"rt.region_enter"()
  %v230 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v230, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = getelementptr i64, ptr %s10, i64 0
  call void @"rt.chunk_next"(i64 %v50, ptr %v54)
  %v55 = getelementptr i64, ptr %s11, i64 0
  %v56.p = getelementptr i64, ptr %v54, i64 0
  %v56 = load i64, ptr %v56.p
  %st49 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st49
  %v57.p = getelementptr i64, ptr %v54, i64 1
  %v57 = load i64, ptr %v57.p
  %st50 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st50
  %v58.p = getelementptr i64, ptr %v54, i64 2
  %v58 = load i64, ptr %v58.p
  %st51 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st51
  %v59.p = getelementptr i64, ptr %v55, i64 1
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 0
  %v61.c = icmp eq i64 %v59, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b9 = icmp ne i64 %v61, 0
  br i1 %c.b9, label %b9.t53, label %b9.e54
b9.t53:
  br label %b11
b9.e54:
  br label %b12
b10:
  %v231 = getelementptr i64, ptr @"rt.meta", i64 0
  %st54 = getelementptr i64, ptr %v231, i64 0
  store i64 %v51, ptr %st54
  %v164 = getelementptr i64, ptr %s13, i64 0
  %v165 = add i64 0, 0
  %st55 = getelementptr i64, ptr %v164, i64 0
  store i64 %v165, ptr %st55
  %v166.p = getelementptr i64, ptr %v164, i64 0
  %v166 = load i64, ptr %v166.p
  %st56 = getelementptr i64, ptr %v45, i64 0
  store i64 %v166, ptr %st56
  %v167.p = getelementptr i64, ptr %v164, i64 1
  %v167 = load i64, ptr %v167.p
  %st57 = getelementptr i64, ptr %v45, i64 1
  store i64 %v167, ptr %st57
  %v168.p = getelementptr i64, ptr %v164, i64 2
  %v168 = load i64, ptr %v168.p
  %st58 = getelementptr i64, ptr %v45, i64 2
  store i64 %v168, ptr %st58
  %v169.p = getelementptr i64, ptr %v164, i64 3
  %v169 = load i64, ptr %v169.p
  %st59 = getelementptr i64, ptr %v45, i64 3
  store i64 %v169, ptr %st59
  %v170.p = getelementptr i64, ptr %v164, i64 4
  %v170 = load i64, ptr %v170.p
  %st60 = getelementptr i64, ptr %v45, i64 4
  store i64 %v170, ptr %st60
  %v171.p = getelementptr i64, ptr %v164, i64 5
  %v171 = load i64, ptr %v171.p
  %st61 = getelementptr i64, ptr %v45, i64 5
  store i64 %v171, ptr %st61
  call void @"std/io.chunkEnd"(i64 %v50)
  %v172.p = getelementptr i64, ptr %v45, i64 0
  %v172 = load i64, ptr %v172.p
  %v173 = add i64 0, 0
  %v174.c = icmp ne i64 %v172, %v173
  %v174 = zext i1 %v174.c to i64
  %c.b10 = icmp ne i64 %v174, 0
  br i1 %c.b10, label %b10.t63, label %b10.e64
b10.t63:
  br label %b33
b10.e64:
  br label %b34
b11:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %v63.p = getelementptr i64, ptr %v62, i64 1027
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 0, 0
  %v65.c = icmp ne i64 %v63, %v64
  %v65 = zext i1 %v65.c to i64
  %c.b11 = icmp ne i64 %v65, 0
  br i1 %c.b11, label %b11.t65, label %b11.e66
b11.t65:
  br label %b13
b11.e66:
  br label %b14
b12:
  br label %b20
b13:
  %v66 = getelementptr i64, ptr %s12, i64 0
  call void @"std/io.errOf"(ptr %v66, i64 %v63)
  %v67 = getelementptr i64, ptr %s13, i64 0
  %v68 = add i64 0, 1
  %st66 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st66
  %v69.p = getelementptr i64, ptr %v66, i64 0
  %v69 = load i64, ptr %v69.p
  %st67 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st67
  %v70.p = getelementptr i64, ptr %v66, i64 1
  %v70 = load i64, ptr %v70.p
  %st68 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st68
  %v71.p = getelementptr i64, ptr %v66, i64 2
  %v71 = load i64, ptr %v71.p
  %st69 = getelementptr i64, ptr %v67, i64 3
  store i64 %v71, ptr %st69
  %v72.p = getelementptr i64, ptr %v66, i64 3
  %v72 = load i64, ptr %v72.p
  %st70 = getelementptr i64, ptr %v67, i64 4
  store i64 %v72, ptr %st70
  %v73.p = getelementptr i64, ptr %v66, i64 4
  %v73 = load i64, ptr %v73.p
  %st71 = getelementptr i64, ptr %v67, i64 5
  store i64 %v73, ptr %st71
  %v74.p = getelementptr i64, ptr %v67, i64 0
  %v74 = load i64, ptr %v74.p
  %st72 = getelementptr i64, ptr %v45, i64 0
  store i64 %v74, ptr %st72
  %v75.p = getelementptr i64, ptr %v67, i64 1
  %v75 = load i64, ptr %v75.p
  %st73 = getelementptr i64, ptr %v45, i64 1
  store i64 %v75, ptr %st73
  %v76.p = getelementptr i64, ptr %v67, i64 2
  %v76 = load i64, ptr %v76.p
  %st74 = getelementptr i64, ptr %v45, i64 2
  store i64 %v76, ptr %st74
  %v77.p = getelementptr i64, ptr %v67, i64 3
  %v77 = load i64, ptr %v77.p
  %st75 = getelementptr i64, ptr %v45, i64 3
  store i64 %v77, ptr %st75
  %v78.p = getelementptr i64, ptr %v67, i64 4
  %v78 = load i64, ptr %v78.p
  %st76 = getelementptr i64, ptr %v45, i64 4
  store i64 %v78, ptr %st76
  %v79.p = getelementptr i64, ptr %v67, i64 5
  %v79 = load i64, ptr %v79.p
  %st77 = getelementptr i64, ptr %v45, i64 5
  store i64 %v79, ptr %st77
  call void @"std/io.chunkEnd"(i64 %v50)
  %v80.p = getelementptr i64, ptr %v45, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = add i64 0, 0
  %v82.c = icmp ne i64 %v80, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b13 = icmp ne i64 %v82, 0
  br i1 %c.b13, label %b13.t79, label %b13.e80
b13.t79:
  br label %b15
b13.e80:
  br label %b16
b14:
  br label %b17
b15:
  %v83 = add i64 0, 3
  %v84 = getelementptr i64, ptr %v45, i64 %v83
  %v232 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v84, i64 %v232, i64 %v46)
  br label %b16
b16:
  %v233 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v233, i64 0
  store i64 %v46, ptr %st80
  br label %b7
b17:
  %v85 = getelementptr i64, ptr %s13, i64 0
  %v86 = add i64 0, 0
  %st81 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st81
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %st82 = getelementptr i64, ptr %v45, i64 0
  store i64 %v87, ptr %st82
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %st83 = getelementptr i64, ptr %v45, i64 1
  store i64 %v88, ptr %st83
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %st84 = getelementptr i64, ptr %v45, i64 2
  store i64 %v89, ptr %st84
  %v90.p = getelementptr i64, ptr %v85, i64 3
  %v90 = load i64, ptr %v90.p
  %st85 = getelementptr i64, ptr %v45, i64 3
  store i64 %v90, ptr %st85
  %v91.p = getelementptr i64, ptr %v85, i64 4
  %v91 = load i64, ptr %v91.p
  %st86 = getelementptr i64, ptr %v45, i64 4
  store i64 %v91, ptr %st86
  %v92.p = getelementptr i64, ptr %v85, i64 5
  %v92 = load i64, ptr %v92.p
  %st87 = getelementptr i64, ptr %v45, i64 5
  store i64 %v92, ptr %st87
  call void @"std/io.chunkEnd"(i64 %v50)
  %v93.p = getelementptr i64, ptr %v45, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 0
  %v95.c = icmp ne i64 %v93, %v94
  %v95 = zext i1 %v95.c to i64
  %c.b17 = icmp ne i64 %v95, 0
  br i1 %c.b17, label %b17.t89, label %b17.e90
b17.t89:
  br label %b18
b17.e90:
  br label %b19
b18:
  %v96 = add i64 0, 3
  %v97 = getelementptr i64, ptr %v45, i64 %v96
  %v234 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v97, i64 %v234, i64 %v46)
  br label %b19
b19:
  %v235 = getelementptr i64, ptr @"rt.meta", i64 0
  %st90 = getelementptr i64, ptr %v235, i64 0
  store i64 %v46, ptr %st90
  br label %b7
b20:
  %v98 = getelementptr i64, ptr %s10, i64 0
  %v99.p = getelementptr i64, ptr %v55, i64 0
  %v99 = load i64, ptr %v99.p
  %st91 = getelementptr i64, ptr %v98, i64 0
  store i64 %v99, ptr %st91
  %v100.p = getelementptr i64, ptr %v55, i64 1
  %v100 = load i64, ptr %v100.p
  %st92 = getelementptr i64, ptr %v98, i64 1
  store i64 %v100, ptr %st92
  %v101.p = getelementptr i64, ptr %v55, i64 2
  %v101 = load i64, ptr %v101.p
  %st93 = getelementptr i64, ptr %v98, i64 2
  store i64 %v101, ptr %st93
  %v102 = getelementptr i64, ptr %s14, i64 0
  %v103 = add i64 0, 0
  %v104 = getelementptr i64, ptr %s15, i64 0
  %v105 = getelementptr i64, ptr %s16, i64 0
  %v106 = add i64 0, 0
  %st94 = getelementptr i64, ptr %v105, i64 0
  store i64 %v106, ptr %st94
  %st95 = getelementptr i64, ptr %v105, i64 1
  store i64 %v106, ptr %st95
  %st96 = getelementptr i64, ptr %v105, i64 2
  store i64 %v106, ptr %st96
  %v107.p = getelementptr i64, ptr %v98, i64 0
  %v107 = load i64, ptr %v107.p
  %st97 = getelementptr i64, ptr %v105, i64 0
  store i64 %v107, ptr %st97
  %v108.p = getelementptr i64, ptr %v98, i64 1
  %v108 = load i64, ptr %v108.p
  %st98 = getelementptr i64, ptr %v105, i64 1
  store i64 %v108, ptr %st98
  %v109.p = getelementptr i64, ptr %v98, i64 2
  %v109 = load i64, ptr %v109.p
  %st99 = getelementptr i64, ptr %v105, i64 2
  store i64 %v109, ptr %st99
  %v110 = getelementptr i64, ptr %s17, i64 0
  %v111.p = getelementptr i64, ptr %v105, i64 0
  %v111 = load i64, ptr %v111.p
  %st100 = getelementptr i64, ptr %v110, i64 0
  store i64 %v111, ptr %st100
  %v112.p = getelementptr i64, ptr %v105, i64 1
  %v112 = load i64, ptr %v112.p
  %st101 = getelementptr i64, ptr %v110, i64 1
  store i64 %v112, ptr %st101
  %v113.p = getelementptr i64, ptr %v105, i64 2
  %v113 = load i64, ptr %v113.p
  %st102 = getelementptr i64, ptr %v110, i64 2
  store i64 %v113, ptr %st102
  %v236 = getelementptr i64, ptr @"rt.meta", i64 0
  %v114.p = getelementptr i64, ptr %v236, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = getelementptr i64, ptr %s18, i64 0
  %v116.p = getelementptr i64, ptr %v110, i64 0
  %v116 = load i64, ptr %v116.p
  %v117.p = getelementptr i64, ptr %v110, i64 1
  %v117 = load i64, ptr %v117.p
  %v118.p = getelementptr i64, ptr %v110, i64 2
  %v118 = load i64, ptr %v118.p
  call void @"std/io.Raw"(ptr %v115, i64 %v116, i64 %v117, i64 %v118)
  %v119 = getelementptr i64, ptr %s19, i64 0
  %v120.p = getelementptr i64, ptr %v115, i64 0
  %v120 = load i64, ptr %v120.p
  %st103 = getelementptr i64, ptr %v119, i64 0
  store i64 %v120, ptr %st103
  %v121.p = getelementptr i64, ptr %v115, i64 1
  %v121 = load i64, ptr %v121.p
  %st104 = getelementptr i64, ptr %v119, i64 1
  store i64 %v121, ptr %st104
  %v122.p = getelementptr i64, ptr %v115, i64 2
  %v122 = load i64, ptr %v122.p
  %st105 = getelementptr i64, ptr %v119, i64 2
  store i64 %v122, ptr %st105
  %v123.p = getelementptr i64, ptr %v119, i64 1
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v30, i64 0
  %v124 = load i64, ptr %v124.p
  %v125 = add i64 %v124, %v123
  %st106 = getelementptr i64, ptr %v30, i64 0
  store i64 %v125, ptr %st106
  %v126 = add i64 0, 1
  %v127.p = getelementptr i64, ptr %v34, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 %v127, %v126
  %st107 = getelementptr i64, ptr %v34, i64 0
  store i64 %v128, ptr %st107
  %v237 = getelementptr i64, ptr @"rt.meta", i64 0
  %v129.p = getelementptr i64, ptr %v237, i64 0
  %v129 = load i64, ptr %v129.p
  %v130 = getelementptr i64, ptr %s20, i64 0
  %v131.p = getelementptr i64, ptr %v119, i64 0
  %v131 = load i64, ptr %v131.p
  %st108 = getelementptr i64, ptr %v130, i64 0
  store i64 %v131, ptr %st108
  %v132.p = getelementptr i64, ptr %v119, i64 1
  %v132 = load i64, ptr %v132.p
  %st109 = getelementptr i64, ptr %v130, i64 1
  store i64 %v132, ptr %st109
  %v133.p = getelementptr i64, ptr %v119, i64 2
  %v133 = load i64, ptr %v133.p
  %st110 = getelementptr i64, ptr %v130, i64 2
  store i64 %v133, ptr %st110
  %v134 = getelementptr i64, ptr %s21, i64 0
  %v135.p = getelementptr i64, ptr %v130, i64 0
  %v135 = load i64, ptr %v135.p
  %st111 = getelementptr i64, ptr %v134, i64 0
  store i64 %v135, ptr %st111
  %v136.p = getelementptr i64, ptr %v130, i64 1
  %v136 = load i64, ptr %v136.p
  %st112 = getelementptr i64, ptr %v134, i64 1
  store i64 %v136, ptr %st112
  %v137.p = getelementptr i64, ptr %v130, i64 2
  %v137 = load i64, ptr %v137.p
  %st113 = getelementptr i64, ptr %v134, i64 2
  store i64 %v137, ptr %st113
  %v138 = getelementptr i64, ptr %s22, i64 0
  %v238 = getelementptr i64, ptr @"rt.meta", i64 0
  %v139.p = getelementptr i64, ptr %v238, i64 0
  %v139 = load i64, ptr %v139.p
  %v140 = add i64 0, 0
  %v141 = getelementptr i64, ptr %s23, i64 0
  %st114 = getelementptr i64, ptr %v141, i64 0
  store i64 %v140, ptr %st114
  %v239 = getelementptr i64, ptr @"rt.meta", i64 0
  %v142.p = getelementptr i64, ptr %v239, i64 0
  %v142 = load i64, ptr %v142.p
  br label %b24
b21:
  %v240 = getelementptr i64, ptr @"rt.meta", i64 0
  %st115 = getelementptr i64, ptr %v240, i64 0
  store i64 %v114, ptr %st115
  br label %b8
b22:
  %v241 = getelementptr i64, ptr @"rt.meta", i64 0
  %st116 = getelementptr i64, ptr %v241, i64 0
  store i64 %v129, ptr %st116
  br label %b21
b23:
  br label %b22
b24:
  %v242 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v242, i64 0
  store i64 %v142, ptr %st117
  %v143.p = getelementptr i64, ptr %v141, i64 0
  %v143 = load i64, ptr %v143.p
  %v144.p = getelementptr i64, ptr %v134, i64 1
  %v144 = load i64, ptr %v144.p
  %v145.c = icmp slt i64 %v143, %v144
  %v145 = zext i1 %v145.c to i64
  %c.b24 = icmp ne i64 %v145, 0
  br i1 %c.b24, label %b24.t119, label %b24.e120
b24.t119:
  br label %b25
b24.e120:
  br label %b26
b25:
  call void @"rt.region_enter"()
  %v243 = getelementptr i64, ptr @"rt.meta", i64 0
  %v146.p = getelementptr i64, ptr %v243, i64 0
  %v146 = load i64, ptr %v146.p
  %v147.p = getelementptr i64, ptr %v141, i64 0
  %v147 = load i64, ptr %v147.p
  %v148.p = getelementptr i64, ptr %v134, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.c = icmp uge i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b25 = icmp ne i64 %v149, 0
  br i1 %c.b25, label %b25.t121, label %b25.e122
b25.t121:
  br label %b27
b25.e122:
  br label %b28
b26:
  %v244 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v244, i64 0
  store i64 %v142, ptr %st122
  br label %b23
b27:
  %v150 = add i64 0, 29
  call void @"rt.panic"(i64 %v150)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b28:
  %v151.p = getelementptr i64, ptr %v134, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = inttoptr i64 %v151 to ptr
  %v153 = getelementptr i8, ptr %v152, i64 %v147
  %v154.p = getelementptr i8, ptr %v153, i64 0
  %v154.b = load i8, ptr %v154.p
  %v154 = zext i8 %v154.b to i64
  %v245 = getelementptr i64, ptr @"rt.meta", i64 0
  %v155.p = getelementptr i64, ptr %v245, i64 0
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 0, 10
  %v157.c = icmp eq i64 %v154, %v156
  %v157 = zext i1 %v157.c to i64
  %c.b28 = icmp ne i64 %v157, 0
  br i1 %c.b28, label %b28.t124, label %b28.e125
b28.t124:
  br label %b30
b28.e125:
  br label %b31
b29:
  %v246 = getelementptr i64, ptr @"rt.meta", i64 0
  %st125 = getelementptr i64, ptr %v246, i64 0
  store i64 %v155, ptr %st125
  %v161 = add i64 0, 1
  %v162.p = getelementptr i64, ptr %v141, i64 0
  %v162 = load i64, ptr %v162.p
  %v163 = add i64 %v162, %v161
  %st126 = getelementptr i64, ptr %v141, i64 0
  store i64 %v163, ptr %st126
  br label %b24
b30:
  %v158 = add i64 0, 1
  %v159.p = getelementptr i64, ptr %v32, i64 0
  %v159 = load i64, ptr %v159.p
  %v160 = add i64 %v159, %v158
  %st127 = getelementptr i64, ptr %v32, i64 0
  store i64 %v160, ptr %st127
  br label %b32
b31:
  br label %b32
b32:
  br label %b29
b33:
  %v175 = add i64 0, 3
  %v176 = getelementptr i64, ptr %v45, i64 %v175
  %v247 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v176, i64 %v247, i64 %v46)
  br label %b34
b34:
  %v248 = getelementptr i64, ptr @"rt.meta", i64 0
  %st128 = getelementptr i64, ptr %v248, i64 0
  store i64 %v46, ptr %st128
  br label %b7
b35:
  %v186 = add i64 0, 3
  %v187 = getelementptr i64, ptr %v38, i64 %v186
  %v249 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v187, i64 %v249, i64 %v39)
  br label %b36
b36:
  %v250 = getelementptr i64, ptr @"rt.meta", i64 0
  %st129 = getelementptr i64, ptr %v250, i64 0
  store i64 %v39, ptr %st129
  br label %b6
b37:
  %v191 = add i64 0, 0
  %st130 = getelementptr i64, ptr %v0, i64 0
  store i64 %v191, ptr %st130
  %st131 = getelementptr i64, ptr %v0, i64 1
  store i64 %v191, ptr %st131
  %st132 = getelementptr i64, ptr %v0, i64 2
  store i64 %v191, ptr %st132
  %v192.p = getelementptr i64, ptr %v38, i64 0
  %v192 = load i64, ptr %v192.p
  %st133 = getelementptr i64, ptr %v0, i64 3
  store i64 %v192, ptr %st133
  %v193.p = getelementptr i64, ptr %v38, i64 1
  %v193 = load i64, ptr %v193.p
  %st134 = getelementptr i64, ptr %v0, i64 4
  store i64 %v193, ptr %st134
  %v194.p = getelementptr i64, ptr %v38, i64 2
  %v194 = load i64, ptr %v194.p
  %st135 = getelementptr i64, ptr %v0, i64 5
  store i64 %v194, ptr %st135
  %v195.p = getelementptr i64, ptr %v38, i64 3
  %v195 = load i64, ptr %v195.p
  %st136 = getelementptr i64, ptr %v0, i64 6
  store i64 %v195, ptr %st136
  %v196.p = getelementptr i64, ptr %v38, i64 4
  %v196 = load i64, ptr %v196.p
  %st137 = getelementptr i64, ptr %v0, i64 7
  store i64 %v196, ptr %st137
  %v197.p = getelementptr i64, ptr %v38, i64 5
  %v197 = load i64, ptr %v197.p
  %st138 = getelementptr i64, ptr %v0, i64 8
  store i64 %v197, ptr %st138
  %v198.p = getelementptr i64, ptr %v27, i64 0
  %v198 = load i64, ptr %v198.p
  call void @"std/io.Close"(i64 %v198)
  %v199.p = getelementptr i64, ptr %v0, i64 3
  %v199 = load i64, ptr %v199.p
  %v200 = add i64 0, 0
  %v201.c = icmp ne i64 %v199, %v200
  %v201 = zext i1 %v201.c to i64
  %c.b37 = icmp ne i64 %v201, 0
  br i1 %c.b37, label %b37.t140, label %b37.e141
b37.t140:
  br label %b39
b37.e141:
  br label %b40
b38:
  br label %b5
b39:
  %v202 = add i64 0, 6
  %v203 = getelementptr i64, ptr %v0, i64 %v202
  %v251 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v203, i64 %v251, i64 %v5)
  br label %b40
b40:
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v252, i64 0
  store i64 %v5, ptr %st141
  ret void
b41:
  %v219 = add i64 0, 6
  %v220 = getelementptr i64, ptr %v0, i64 %v219
  %v253 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v220, i64 %v253, i64 %v5)
  br label %b42
b42:
  %v254 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v254, i64 0
  store i64 %v5, ptr %st142
  ret void
}

define internal void @"std/strings.FormatInt"(ptr %v0, i64 %v1) #0 {
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
  %v9 = getelementptr i64, ptr @"str.24", i64 0
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
  %v16 = getelementptr i64, ptr @"str.25", i64 0
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
  call void @"std/strings.utoa"(ptr %v21, i64 %v23)
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
  call void @"std/strings.utoa"(ptr %v37, i64 %v1)
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

define internal void @"main.lines"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
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
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
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
  %s13 = alloca [3 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s13.z1 = getelementptr i64, ptr %s13, i64 1
  store i64 0, ptr %s13.z1
  %s13.z2 = getelementptr i64, ptr %s13, i64 2
  store i64 0, ptr %s13.z2
  %s14 = alloca [5 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s14.z1 = getelementptr i64, ptr %s14, i64 1
  store i64 0, ptr %s14.z1
  %s14.z2 = getelementptr i64, ptr %s14, i64 2
  store i64 0, ptr %s14.z2
  %s14.z3 = getelementptr i64, ptr %s14, i64 3
  store i64 0, ptr %s14.z3
  %s14.z4 = getelementptr i64, ptr %s14, i64 4
  store i64 0, ptr %s14.z4
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
  %s16 = alloca [1 x i64], align 8
  %s16.z0 = getelementptr i64, ptr %s16, i64 0
  store i64 0, ptr %s16.z0
  %s17 = alloca [1 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
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
  %s21 = alloca [1 x i64], align 8
  %s21.z0 = getelementptr i64, ptr %s21, i64 0
  store i64 0, ptr %s21.z0
  %s22 = alloca [1 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %s23 = alloca [1 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
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
  %s27 = alloca [1 x i64], align 8
  %s27.z0 = getelementptr i64, ptr %s27, i64 0
  store i64 0, ptr %s27.z0
  %s28 = alloca [1 x i64], align 8
  %s28.z0 = getelementptr i64, ptr %s28, i64 0
  store i64 0, ptr %s28.z0
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
  %s33 = alloca [9 x i64], align 8
  %s33.z0 = getelementptr i64, ptr %s33, i64 0
  store i64 0, ptr %s33.z0
  %s33.z1 = getelementptr i64, ptr %s33, i64 1
  store i64 0, ptr %s33.z1
  %s33.z2 = getelementptr i64, ptr %s33, i64 2
  store i64 0, ptr %s33.z2
  %s33.z3 = getelementptr i64, ptr %s33, i64 3
  store i64 0, ptr %s33.z3
  %s33.z4 = getelementptr i64, ptr %s33, i64 4
  store i64 0, ptr %s33.z4
  %s33.z5 = getelementptr i64, ptr %s33, i64 5
  store i64 0, ptr %s33.z5
  %s33.z6 = getelementptr i64, ptr %s33, i64 6
  store i64 0, ptr %s33.z6
  %s33.z7 = getelementptr i64, ptr %s33, i64 7
  store i64 0, ptr %s33.z7
  %s33.z8 = getelementptr i64, ptr %s33, i64 8
  store i64 0, ptr %s33.z8
  %s34 = alloca [3 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
  %s34.z1 = getelementptr i64, ptr %s34, i64 1
  store i64 0, ptr %s34.z1
  %s34.z2 = getelementptr i64, ptr %s34, i64 2
  store i64 0, ptr %s34.z2
  %s35 = alloca [5 x i64], align 8
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
  %s38 = alloca [3 x i64], align 8
  %s38.z0 = getelementptr i64, ptr %s38, i64 0
  store i64 0, ptr %s38.z0
  %s38.z1 = getelementptr i64, ptr %s38, i64 1
  store i64 0, ptr %s38.z1
  %s38.z2 = getelementptr i64, ptr %s38, i64 2
  store i64 0, ptr %s38.z2
  %s39 = alloca [3 x i64], align 8
  %s39.z0 = getelementptr i64, ptr %s39, i64 0
  store i64 0, ptr %s39.z0
  %s39.z1 = getelementptr i64, ptr %s39, i64 1
  store i64 0, ptr %s39.z1
  %s39.z2 = getelementptr i64, ptr %s39, i64 2
  store i64 0, ptr %s39.z2
  %s40 = alloca [3 x i64], align 8
  %s40.z0 = getelementptr i64, ptr %s40, i64 0
  store i64 0, ptr %s40.z0
  %s40.z1 = getelementptr i64, ptr %s40, i64 1
  store i64 0, ptr %s40.z1
  %s40.z2 = getelementptr i64, ptr %s40, i64 2
  store i64 0, ptr %s40.z2
  %s41 = alloca [3 x i64], align 8
  %s41.z0 = getelementptr i64, ptr %s41, i64 0
  store i64 0, ptr %s41.z0
  %s41.z1 = getelementptr i64, ptr %s41, i64 1
  store i64 0, ptr %s41.z1
  %s41.z2 = getelementptr i64, ptr %s41, i64 2
  store i64 0, ptr %s41.z2
  %s42 = alloca [3 x i64], align 8
  %s42.z0 = getelementptr i64, ptr %s42, i64 0
  store i64 0, ptr %s42.z0
  %s42.z1 = getelementptr i64, ptr %s42, i64 1
  store i64 0, ptr %s42.z1
  %s42.z2 = getelementptr i64, ptr %s42, i64 2
  store i64 0, ptr %s42.z2
  %s43 = alloca [3 x i64], align 8
  %s43.z0 = getelementptr i64, ptr %s43, i64 0
  store i64 0, ptr %s43.z0
  %s43.z1 = getelementptr i64, ptr %s43, i64 1
  store i64 0, ptr %s43.z1
  %s43.z2 = getelementptr i64, ptr %s43, i64 2
  store i64 0, ptr %s43.z2
  %s44 = alloca [3 x i64], align 8
  %s44.z0 = getelementptr i64, ptr %s44, i64 0
  store i64 0, ptr %s44.z0
  %s44.z1 = getelementptr i64, ptr %s44, i64 1
  store i64 0, ptr %s44.z1
  %s44.z2 = getelementptr i64, ptr %s44, i64 2
  store i64 0, ptr %s44.z2
  %s45 = alloca [1 x i64], align 8
  %s45.z0 = getelementptr i64, ptr %s45, i64 0
  store i64 0, ptr %s45.z0
  %s46 = alloca [1 x i64], align 8
  %s46.z0 = getelementptr i64, ptr %s46, i64 0
  store i64 0, ptr %s46.z0
  %s47 = alloca [3 x i64], align 8
  %s47.z0 = getelementptr i64, ptr %s47, i64 0
  store i64 0, ptr %s47.z0
  %s47.z1 = getelementptr i64, ptr %s47, i64 1
  store i64 0, ptr %s47.z1
  %s47.z2 = getelementptr i64, ptr %s47, i64 2
  store i64 0, ptr %s47.z2
  %s48 = alloca [9 x i64], align 8
  %s48.z0 = getelementptr i64, ptr %s48, i64 0
  store i64 0, ptr %s48.z0
  %s48.z1 = getelementptr i64, ptr %s48, i64 1
  store i64 0, ptr %s48.z1
  %s48.z2 = getelementptr i64, ptr %s48, i64 2
  store i64 0, ptr %s48.z2
  %s48.z3 = getelementptr i64, ptr %s48, i64 3
  store i64 0, ptr %s48.z3
  %s48.z4 = getelementptr i64, ptr %s48, i64 4
  store i64 0, ptr %s48.z4
  %s48.z5 = getelementptr i64, ptr %s48, i64 5
  store i64 0, ptr %s48.z5
  %s48.z6 = getelementptr i64, ptr %s48, i64 6
  store i64 0, ptr %s48.z6
  %s48.z7 = getelementptr i64, ptr %s48, i64 7
  store i64 0, ptr %s48.z7
  %s48.z8 = getelementptr i64, ptr %s48, i64 8
  store i64 0, ptr %s48.z8
  %s49 = alloca [3 x i64], align 8
  %s49.z0 = getelementptr i64, ptr %s49, i64 0
  store i64 0, ptr %s49.z0
  %s49.z1 = getelementptr i64, ptr %s49, i64 1
  store i64 0, ptr %s49.z1
  %s49.z2 = getelementptr i64, ptr %s49, i64 2
  store i64 0, ptr %s49.z2
  %s50 = alloca [3 x i64], align 8
  %s50.z0 = getelementptr i64, ptr %s50, i64 0
  store i64 0, ptr %s50.z0
  %s50.z1 = getelementptr i64, ptr %s50, i64 1
  store i64 0, ptr %s50.z1
  %s50.z2 = getelementptr i64, ptr %s50, i64 2
  store i64 0, ptr %s50.z2
  %s51 = alloca [3 x i64], align 8
  %s51.z0 = getelementptr i64, ptr %s51, i64 0
  store i64 0, ptr %s51.z0
  %s51.z1 = getelementptr i64, ptr %s51, i64 1
  store i64 0, ptr %s51.z1
  %s51.z2 = getelementptr i64, ptr %s51, i64 2
  store i64 0, ptr %s51.z2
  %s52 = alloca [3 x i64], align 8
  %s52.z0 = getelementptr i64, ptr %s52, i64 0
  store i64 0, ptr %s52.z0
  %s52.z1 = getelementptr i64, ptr %s52, i64 1
  store i64 0, ptr %s52.z1
  %s52.z2 = getelementptr i64, ptr %s52, i64 2
  store i64 0, ptr %s52.z2
  %s53 = alloca [3 x i64], align 8
  %s53.z0 = getelementptr i64, ptr %s53, i64 0
  store i64 0, ptr %s53.z0
  %s53.z1 = getelementptr i64, ptr %s53, i64 1
  store i64 0, ptr %s53.z1
  %s53.z2 = getelementptr i64, ptr %s53, i64 2
  store i64 0, ptr %s53.z2
  %s54 = alloca [3 x i64], align 8
  %s54.z0 = getelementptr i64, ptr %s54, i64 0
  store i64 0, ptr %s54.z0
  %s54.z1 = getelementptr i64, ptr %s54, i64 1
  store i64 0, ptr %s54.z1
  %s54.z2 = getelementptr i64, ptr %s54, i64 2
  store i64 0, ptr %s54.z2
  %s55 = alloca [3 x i64], align 8
  %s55.z0 = getelementptr i64, ptr %s55, i64 0
  store i64 0, ptr %s55.z0
  %s55.z1 = getelementptr i64, ptr %s55, i64 1
  store i64 0, ptr %s55.z1
  %s55.z2 = getelementptr i64, ptr %s55, i64 2
  store i64 0, ptr %s55.z2
  %s56 = alloca [3 x i64], align 8
  %s56.z0 = getelementptr i64, ptr %s56, i64 0
  store i64 0, ptr %s56.z0
  %s56.z1 = getelementptr i64, ptr %s56, i64 1
  store i64 0, ptr %s56.z1
  %s56.z2 = getelementptr i64, ptr %s56, i64 2
  store i64 0, ptr %s56.z2
  %s57 = alloca [3 x i64], align 8
  %s57.z0 = getelementptr i64, ptr %s57, i64 0
  store i64 0, ptr %s57.z0
  %s57.z1 = getelementptr i64, ptr %s57, i64 1
  store i64 0, ptr %s57.z1
  %s57.z2 = getelementptr i64, ptr %s57, i64 2
  store i64 0, ptr %s57.z2
  %s58 = alloca [9 x i64], align 8
  %s58.z0 = getelementptr i64, ptr %s58, i64 0
  store i64 0, ptr %s58.z0
  %s58.z1 = getelementptr i64, ptr %s58, i64 1
  store i64 0, ptr %s58.z1
  %s58.z2 = getelementptr i64, ptr %s58, i64 2
  store i64 0, ptr %s58.z2
  %s58.z3 = getelementptr i64, ptr %s58, i64 3
  store i64 0, ptr %s58.z3
  %s58.z4 = getelementptr i64, ptr %s58, i64 4
  store i64 0, ptr %s58.z4
  %s58.z5 = getelementptr i64, ptr %s58, i64 5
  store i64 0, ptr %s58.z5
  %s58.z6 = getelementptr i64, ptr %s58, i64 6
  store i64 0, ptr %s58.z6
  %s58.z7 = getelementptr i64, ptr %s58, i64 7
  store i64 0, ptr %s58.z7
  %s58.z8 = getelementptr i64, ptr %s58, i64 8
  store i64 0, ptr %s58.z8
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v728 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v728, i64 0
  %v6 = load i64, ptr %v6.p
  call void @"rt.region_enter"()
  %v7 = getelementptr i64, ptr %s1, i64 0
  %v8.p = getelementptr i64, ptr %v5, i64 0
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v5, i64 1
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v5, i64 2
  %v10 = load i64, ptr %v10.p
  call void @"std/io.Open"(ptr %v7, i64 %v8, i64 %v9, i64 %v10)
  %v11 = add i64 0, 1
  %v12 = getelementptr i64, ptr %v7, i64 %v11
  %v13.p = getelementptr i64, ptr %v12, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15.c = icmp ne i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b0 = icmp ne i64 %v15, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v16 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v0, i64 0
  store i64 %v16, ptr %st5
  %st6 = getelementptr i64, ptr %v0, i64 1
  store i64 %v16, ptr %st6
  %v17.p = getelementptr i64, ptr %v12, i64 0
  %v17 = load i64, ptr %v17.p
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st7
  %v18.p = getelementptr i64, ptr %v12, i64 1
  %v18 = load i64, ptr %v18.p
  %st8 = getelementptr i64, ptr %v0, i64 3
  store i64 %v18, ptr %st8
  %v19.p = getelementptr i64, ptr %v12, i64 2
  %v19 = load i64, ptr %v19.p
  %st9 = getelementptr i64, ptr %v0, i64 4
  store i64 %v19, ptr %st9
  %v20.p = getelementptr i64, ptr %v12, i64 3
  %v20 = load i64, ptr %v20.p
  %st10 = getelementptr i64, ptr %v0, i64 5
  store i64 %v20, ptr %st10
  %v21.p = getelementptr i64, ptr %v12, i64 4
  %v21 = load i64, ptr %v21.p
  %st11 = getelementptr i64, ptr %v0, i64 6
  store i64 %v21, ptr %st11
  %v22.p = getelementptr i64, ptr %v12, i64 5
  %v22 = load i64, ptr %v22.p
  %st12 = getelementptr i64, ptr %v0, i64 7
  store i64 %v22, ptr %st12
  %v23.p = getelementptr i64, ptr %v0, i64 2
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b1 = icmp ne i64 %v25, 0
  br i1 %c.b1, label %b1.t14, label %b1.e15
b1.t14:
  br label %b3
b1.e15:
  br label %b4
b2:
  %v28 = getelementptr i64, ptr %s2, i64 0
  %v29.p = getelementptr i64, ptr %v7, i64 0
  %v29 = load i64, ptr %v29.p
  %st15 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st15
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s3, i64 0
  %st16 = getelementptr i64, ptr %v31, i64 0
  store i64 %v30, ptr %st16
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s4, i64 0
  %st17 = getelementptr i64, ptr %v33, i64 0
  store i64 %v32, ptr %st17
  %v729 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v729, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = getelementptr i64, ptr %s5, i64 0
  %v36.p = getelementptr i64, ptr %v28, i64 0
  %v36 = load i64, ptr %v36.p
  %st18 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st18
  %v37 = getelementptr i64, ptr %s6, i64 0
  %v730 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v730, i64 0
  %v38 = load i64, ptr %v38.p
  %v731 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v731, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 0
  %v41 = call ptr @"rt.region_alloc8"(i64 %v39, i64 %v40)
  %v42 = add i64 0, 0
  %v43 = getelementptr i64, ptr %s7, i64 0
  %v44 = ptrtoint ptr %v41 to i64
  %st19 = getelementptr i64, ptr %v43, i64 0
  store i64 %v44, ptr %st19
  %st20 = getelementptr i64, ptr %v43, i64 1
  store i64 %v42, ptr %st20
  %st21 = getelementptr i64, ptr %v43, i64 2
  store i64 %v39, ptr %st21
  %v45 = getelementptr i64, ptr %s8, i64 0
  %v46.p = getelementptr i64, ptr %v43, i64 0
  %v46 = load i64, ptr %v46.p
  %st22 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st22
  %v47.p = getelementptr i64, ptr %v43, i64 1
  %v47 = load i64, ptr %v47.p
  %st23 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st23
  %v48.p = getelementptr i64, ptr %v43, i64 2
  %v48 = load i64, ptr %v48.p
  %st24 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st24
  %v732 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v732, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = getelementptr i64, ptr %s9, i64 0
  %v51.p = getelementptr i64, ptr %v35, i64 0
  %v51 = load i64, ptr %v51.p
  %st25 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st25
  %v52 = getelementptr i64, ptr %s10, i64 0
  %v733 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v733, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = getelementptr i64, ptr %s11, i64 0
  %v55.p = getelementptr i64, ptr %v50, i64 0
  %v55 = load i64, ptr %v55.p
  %st26 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st26
  %v56 = add i64 0, 1
  %v57 = add i64 0, 0
  %v58 = sub i64 %v57, %v56
  %v59 = getelementptr i64, ptr %s12, i64 0
  %v734 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v734, i64 0
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v54, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 65536
  %v63 = add i64 0, 2
  %v64 = call i64 @"rt.chunk_open"(i64 %v61, i64 %v62, i64 %v63, i64 %v58)
  %v735 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v735, i64 0
  %v65 = load i64, ptr %v65.p
  br label %b10
b3:
  %v26 = add i64 0, 5
  %v27 = getelementptr i64, ptr %v0, i64 %v26
  %v736 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v27, i64 %v736, i64 %v6)
  br label %b4
b4:
  %v737 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v737, i64 0
  store i64 %v6, ptr %st27
  ret void
b5:
  %v738 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v738, i64 0
  store i64 %v34, ptr %st28
  %v712.p = getelementptr i64, ptr %v31, i64 0
  %v712 = load i64, ptr %v712.p
  %v713.p = getelementptr i64, ptr %v33, i64 0
  %v713 = load i64, ptr %v713.p
  %v714 = getelementptr i64, ptr %s15, i64 0
  %v715 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v714, i64 0
  store i64 %v715, ptr %st29
  %st30 = getelementptr i64, ptr %v0, i64 0
  store i64 %v712, ptr %st30
  %st31 = getelementptr i64, ptr %v0, i64 1
  store i64 %v713, ptr %st31
  %v716.p = getelementptr i64, ptr %v714, i64 0
  %v716 = load i64, ptr %v716.p
  %st32 = getelementptr i64, ptr %v0, i64 2
  store i64 %v716, ptr %st32
  %v717.p = getelementptr i64, ptr %v714, i64 1
  %v717 = load i64, ptr %v717.p
  %st33 = getelementptr i64, ptr %v0, i64 3
  store i64 %v717, ptr %st33
  %v718.p = getelementptr i64, ptr %v714, i64 2
  %v718 = load i64, ptr %v718.p
  %st34 = getelementptr i64, ptr %v0, i64 4
  store i64 %v718, ptr %st34
  %v719.p = getelementptr i64, ptr %v714, i64 3
  %v719 = load i64, ptr %v719.p
  %st35 = getelementptr i64, ptr %v0, i64 5
  store i64 %v719, ptr %st35
  %v720.p = getelementptr i64, ptr %v714, i64 4
  %v720 = load i64, ptr %v720.p
  %st36 = getelementptr i64, ptr %v0, i64 6
  store i64 %v720, ptr %st36
  %v721.p = getelementptr i64, ptr %v714, i64 5
  %v721 = load i64, ptr %v721.p
  %st37 = getelementptr i64, ptr %v0, i64 7
  store i64 %v721, ptr %st37
  %v722.p = getelementptr i64, ptr %v28, i64 0
  %v722 = load i64, ptr %v722.p
  call void @"std/io.Close"(i64 %v722)
  %v723.p = getelementptr i64, ptr %v0, i64 2
  %v723 = load i64, ptr %v723.p
  %v724 = add i64 0, 0
  %v725.c = icmp ne i64 %v723, %v724
  %v725 = zext i1 %v725.c to i64
  %c.b5 = icmp ne i64 %v725, 0
  br i1 %c.b5, label %b5.t39, label %b5.e40
b5.t39:
  br label %b98
b5.e40:
  br label %b99
b6:
  %v696.p = getelementptr i64, ptr %v37, i64 0
  %v696 = load i64, ptr %v696.p
  %v697 = add i64 0, 0
  %v698.c = icmp ne i64 %v696, %v697
  %v698 = zext i1 %v698.c to i64
  %c.b6 = icmp ne i64 %v698, 0
  br i1 %c.b6, label %b6.t41, label %b6.e42
b6.t41:
  br label %b94
b6.e42:
  br label %b95
b7:
  %v739 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v739, i64 0
  store i64 %v49, ptr %st42
  %v549.p = getelementptr i64, ptr %v45, i64 1
  %v549 = load i64, ptr %v549.p
  %v550 = add i64 0, 0
  %v551.c = icmp sgt i64 %v549, %v550
  %v551 = zext i1 %v551.c to i64
  %c.b7 = icmp ne i64 %v551, 0
  br i1 %c.b7, label %b7.t44, label %b7.e45
b7.t44:
  br label %b82
b7.e45:
  br label %b83
b8:
  %v534.p = getelementptr i64, ptr %v52, i64 0
  %v534 = load i64, ptr %v534.p
  %v535 = add i64 0, 0
  %v536.c = icmp ne i64 %v534, %v535
  %v536 = zext i1 %v536.c to i64
  %c.b8 = icmp ne i64 %v536, 0
  br i1 %c.b8, label %b8.t46, label %b8.e47
b8.t46:
  br label %b78
b8.e47:
  br label %b79
b9:
  %v523.p = getelementptr i64, ptr %v59, i64 0
  %v523 = load i64, ptr %v523.p
  %st47 = getelementptr i64, ptr %v52, i64 0
  store i64 %v523, ptr %st47
  %v524.p = getelementptr i64, ptr %v59, i64 1
  %v524 = load i64, ptr %v524.p
  %st48 = getelementptr i64, ptr %v52, i64 1
  store i64 %v524, ptr %st48
  %v525.p = getelementptr i64, ptr %v59, i64 2
  %v525 = load i64, ptr %v525.p
  %st49 = getelementptr i64, ptr %v52, i64 2
  store i64 %v525, ptr %st49
  %v526.p = getelementptr i64, ptr %v59, i64 3
  %v526 = load i64, ptr %v526.p
  %st50 = getelementptr i64, ptr %v52, i64 3
  store i64 %v526, ptr %st50
  %v527.p = getelementptr i64, ptr %v59, i64 4
  %v527 = load i64, ptr %v527.p
  %st51 = getelementptr i64, ptr %v52, i64 4
  store i64 %v527, ptr %st51
  %v528.p = getelementptr i64, ptr %v59, i64 5
  %v528 = load i64, ptr %v528.p
  %st52 = getelementptr i64, ptr %v52, i64 5
  store i64 %v528, ptr %st52
  %v529.p = getelementptr i64, ptr %v52, i64 0
  %v529 = load i64, ptr %v529.p
  %v530 = add i64 0, 0
  %v531.c = icmp ne i64 %v529, %v530
  %v531 = zext i1 %v531.c to i64
  %c.b9 = icmp ne i64 %v531, 0
  br i1 %c.b9, label %b9.t54, label %b9.e55
b9.t54:
  br label %b76
b9.e55:
  br label %b77
b10:
  %v740 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v740, i64 0
  store i64 %v65, ptr %st55
  %v66 = add i64 0, 1
  %c.b10 = icmp ne i64 %v66, 0
  br i1 %c.b10, label %b10.t57, label %b10.e58
b10.t57:
  br label %b11
b10.e58:
  br label %b12
b11:
  call void @"rt.region_enter"()
  %v741 = getelementptr i64, ptr @"rt.meta", i64 0
  %v67.p = getelementptr i64, ptr %v741, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = getelementptr i64, ptr %s7, i64 0
  call void @"rt.chunk_next"(i64 %v64, ptr %v68)
  %v69 = getelementptr i64, ptr %s13, i64 0
  %v70.p = getelementptr i64, ptr %v68, i64 0
  %v70 = load i64, ptr %v70.p
  %st58 = getelementptr i64, ptr %v69, i64 0
  store i64 %v70, ptr %st58
  %v71.p = getelementptr i64, ptr %v68, i64 1
  %v71 = load i64, ptr %v71.p
  %st59 = getelementptr i64, ptr %v69, i64 1
  store i64 %v71, ptr %st59
  %v72.p = getelementptr i64, ptr %v68, i64 2
  %v72 = load i64, ptr %v72.p
  %st60 = getelementptr i64, ptr %v69, i64 2
  store i64 %v72, ptr %st60
  %v73.p = getelementptr i64, ptr %v69, i64 1
  %v73 = load i64, ptr %v73.p
  %v74 = add i64 0, 0
  %v75.c = icmp eq i64 %v73, %v74
  %v75 = zext i1 %v75.c to i64
  %c.b11 = icmp ne i64 %v75, 0
  br i1 %c.b11, label %b11.t62, label %b11.e63
b11.t62:
  br label %b13
b11.e63:
  br label %b14
b12:
  %v742 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v742, i64 0
  store i64 %v65, ptr %st63
  %v510 = getelementptr i64, ptr %s15, i64 0
  %v511 = add i64 0, 0
  %st64 = getelementptr i64, ptr %v510, i64 0
  store i64 %v511, ptr %st64
  %v512.p = getelementptr i64, ptr %v510, i64 0
  %v512 = load i64, ptr %v512.p
  %st65 = getelementptr i64, ptr %v59, i64 0
  store i64 %v512, ptr %st65
  %v513.p = getelementptr i64, ptr %v510, i64 1
  %v513 = load i64, ptr %v513.p
  %st66 = getelementptr i64, ptr %v59, i64 1
  store i64 %v513, ptr %st66
  %v514.p = getelementptr i64, ptr %v510, i64 2
  %v514 = load i64, ptr %v514.p
  %st67 = getelementptr i64, ptr %v59, i64 2
  store i64 %v514, ptr %st67
  %v515.p = getelementptr i64, ptr %v510, i64 3
  %v515 = load i64, ptr %v515.p
  %st68 = getelementptr i64, ptr %v59, i64 3
  store i64 %v515, ptr %st68
  %v516.p = getelementptr i64, ptr %v510, i64 4
  %v516 = load i64, ptr %v516.p
  %st69 = getelementptr i64, ptr %v59, i64 4
  store i64 %v516, ptr %st69
  %v517.p = getelementptr i64, ptr %v510, i64 5
  %v517 = load i64, ptr %v517.p
  %st70 = getelementptr i64, ptr %v59, i64 5
  store i64 %v517, ptr %st70
  call void @"std/io.chunkEnd"(i64 %v64)
  %v518.p = getelementptr i64, ptr %v59, i64 0
  %v518 = load i64, ptr %v518.p
  %v519 = add i64 0, 0
  %v520.c = icmp ne i64 %v518, %v519
  %v520 = zext i1 %v520.c to i64
  %c.b12 = icmp ne i64 %v520, 0
  br i1 %c.b12, label %b12.t72, label %b12.e73
b12.t72:
  br label %b74
b12.e73:
  br label %b75
b13:
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v76, i64 1027
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79.c = icmp ne i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b13 = icmp ne i64 %v79, 0
  br i1 %c.b13, label %b13.t74, label %b13.e75
b13.t74:
  br label %b15
b13.e75:
  br label %b16
b14:
  br label %b22
b15:
  %v80 = getelementptr i64, ptr %s14, i64 0
  call void @"std/io.errOf"(ptr %v80, i64 %v77)
  %v81 = getelementptr i64, ptr %s15, i64 0
  %v82 = add i64 0, 1
  %st75 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st75
  %v83.p = getelementptr i64, ptr %v80, i64 0
  %v83 = load i64, ptr %v83.p
  %st76 = getelementptr i64, ptr %v81, i64 1
  store i64 %v83, ptr %st76
  %v84.p = getelementptr i64, ptr %v80, i64 1
  %v84 = load i64, ptr %v84.p
  %st77 = getelementptr i64, ptr %v81, i64 2
  store i64 %v84, ptr %st77
  %v85.p = getelementptr i64, ptr %v80, i64 2
  %v85 = load i64, ptr %v85.p
  %st78 = getelementptr i64, ptr %v81, i64 3
  store i64 %v85, ptr %st78
  %v86.p = getelementptr i64, ptr %v80, i64 3
  %v86 = load i64, ptr %v86.p
  %st79 = getelementptr i64, ptr %v81, i64 4
  store i64 %v86, ptr %st79
  %v87.p = getelementptr i64, ptr %v80, i64 4
  %v87 = load i64, ptr %v87.p
  %st80 = getelementptr i64, ptr %v81, i64 5
  store i64 %v87, ptr %st80
  %v88.p = getelementptr i64, ptr %v81, i64 0
  %v88 = load i64, ptr %v88.p
  %st81 = getelementptr i64, ptr %v59, i64 0
  store i64 %v88, ptr %st81
  %v89.p = getelementptr i64, ptr %v81, i64 1
  %v89 = load i64, ptr %v89.p
  %st82 = getelementptr i64, ptr %v59, i64 1
  store i64 %v89, ptr %st82
  %v90.p = getelementptr i64, ptr %v81, i64 2
  %v90 = load i64, ptr %v90.p
  %st83 = getelementptr i64, ptr %v59, i64 2
  store i64 %v90, ptr %st83
  %v91.p = getelementptr i64, ptr %v81, i64 3
  %v91 = load i64, ptr %v91.p
  %st84 = getelementptr i64, ptr %v59, i64 3
  store i64 %v91, ptr %st84
  %v92.p = getelementptr i64, ptr %v81, i64 4
  %v92 = load i64, ptr %v92.p
  %st85 = getelementptr i64, ptr %v59, i64 4
  store i64 %v92, ptr %st85
  %v93.p = getelementptr i64, ptr %v81, i64 5
  %v93 = load i64, ptr %v93.p
  %st86 = getelementptr i64, ptr %v59, i64 5
  store i64 %v93, ptr %st86
  call void @"std/io.chunkEnd"(i64 %v64)
  %v94.p = getelementptr i64, ptr %v59, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 0, 0
  %v96.c = icmp ne i64 %v94, %v95
  %v96 = zext i1 %v96.c to i64
  %c.b15 = icmp ne i64 %v96, 0
  br i1 %c.b15, label %b15.t88, label %b15.e89
b15.t88:
  br label %b17
b15.e89:
  br label %b18
b16:
  br label %b19
b17:
  %v97 = add i64 0, 3
  %v98 = getelementptr i64, ptr %v59, i64 %v97
  %v743 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v98, i64 %v743, i64 %v60)
  br label %b18
b18:
  %v744 = getelementptr i64, ptr @"rt.meta", i64 0
  %st89 = getelementptr i64, ptr %v744, i64 0
  store i64 %v60, ptr %st89
  br label %b9
b19:
  %v99 = getelementptr i64, ptr %s15, i64 0
  %v100 = add i64 0, 0
  %st90 = getelementptr i64, ptr %v99, i64 0
  store i64 %v100, ptr %st90
  %v101.p = getelementptr i64, ptr %v99, i64 0
  %v101 = load i64, ptr %v101.p
  %st91 = getelementptr i64, ptr %v59, i64 0
  store i64 %v101, ptr %st91
  %v102.p = getelementptr i64, ptr %v99, i64 1
  %v102 = load i64, ptr %v102.p
  %st92 = getelementptr i64, ptr %v59, i64 1
  store i64 %v102, ptr %st92
  %v103.p = getelementptr i64, ptr %v99, i64 2
  %v103 = load i64, ptr %v103.p
  %st93 = getelementptr i64, ptr %v59, i64 2
  store i64 %v103, ptr %st93
  %v104.p = getelementptr i64, ptr %v99, i64 3
  %v104 = load i64, ptr %v104.p
  %st94 = getelementptr i64, ptr %v59, i64 3
  store i64 %v104, ptr %st94
  %v105.p = getelementptr i64, ptr %v99, i64 4
  %v105 = load i64, ptr %v105.p
  %st95 = getelementptr i64, ptr %v59, i64 4
  store i64 %v105, ptr %st95
  %v106.p = getelementptr i64, ptr %v99, i64 5
  %v106 = load i64, ptr %v106.p
  %st96 = getelementptr i64, ptr %v59, i64 5
  store i64 %v106, ptr %st96
  call void @"std/io.chunkEnd"(i64 %v64)
  %v107.p = getelementptr i64, ptr %v59, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 0, 0
  %v109.c = icmp ne i64 %v107, %v108
  %v109 = zext i1 %v109.c to i64
  %c.b19 = icmp ne i64 %v109, 0
  br i1 %c.b19, label %b19.t98, label %b19.e99
b19.t98:
  br label %b20
b19.e99:
  br label %b21
b20:
  %v110 = add i64 0, 3
  %v111 = getelementptr i64, ptr %v59, i64 %v110
  %v745 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v111, i64 %v745, i64 %v60)
  br label %b21
b21:
  %v746 = getelementptr i64, ptr @"rt.meta", i64 0
  %st99 = getelementptr i64, ptr %v746, i64 0
  store i64 %v60, ptr %st99
  br label %b9
b22:
  %v112 = getelementptr i64, ptr %s7, i64 0
  %v113.p = getelementptr i64, ptr %v69, i64 0
  %v113 = load i64, ptr %v113.p
  %st100 = getelementptr i64, ptr %v112, i64 0
  store i64 %v113, ptr %st100
  %v114.p = getelementptr i64, ptr %v69, i64 1
  %v114 = load i64, ptr %v114.p
  %st101 = getelementptr i64, ptr %v112, i64 1
  store i64 %v114, ptr %st101
  %v115.p = getelementptr i64, ptr %v69, i64 2
  %v115 = load i64, ptr %v115.p
  %st102 = getelementptr i64, ptr %v112, i64 2
  store i64 %v115, ptr %st102
  %v116 = getelementptr i64, ptr %s16, i64 0
  %v117 = add i64 0, 0
  %v118 = getelementptr i64, ptr %s17, i64 0
  %v119 = getelementptr i64, ptr %s18, i64 0
  %v120 = add i64 0, 0
  %st103 = getelementptr i64, ptr %v119, i64 0
  store i64 %v120, ptr %st103
  %st104 = getelementptr i64, ptr %v119, i64 1
  store i64 %v120, ptr %st104
  %st105 = getelementptr i64, ptr %v119, i64 2
  store i64 %v120, ptr %st105
  %v121.p = getelementptr i64, ptr %v112, i64 0
  %v121 = load i64, ptr %v121.p
  %st106 = getelementptr i64, ptr %v119, i64 0
  store i64 %v121, ptr %st106
  %v122.p = getelementptr i64, ptr %v112, i64 1
  %v122 = load i64, ptr %v122.p
  %st107 = getelementptr i64, ptr %v119, i64 1
  store i64 %v122, ptr %st107
  %v123.p = getelementptr i64, ptr %v112, i64 2
  %v123 = load i64, ptr %v123.p
  %st108 = getelementptr i64, ptr %v119, i64 2
  store i64 %v123, ptr %st108
  %v124 = getelementptr i64, ptr %s19, i64 0
  %v125.p = getelementptr i64, ptr %v119, i64 0
  %v125 = load i64, ptr %v125.p
  %st109 = getelementptr i64, ptr %v124, i64 0
  store i64 %v125, ptr %st109
  %v126.p = getelementptr i64, ptr %v119, i64 1
  %v126 = load i64, ptr %v126.p
  %st110 = getelementptr i64, ptr %v124, i64 1
  store i64 %v126, ptr %st110
  %v127.p = getelementptr i64, ptr %v119, i64 2
  %v127 = load i64, ptr %v127.p
  %st111 = getelementptr i64, ptr %v124, i64 2
  store i64 %v127, ptr %st111
  %v747 = getelementptr i64, ptr @"rt.meta", i64 0
  %v128.p = getelementptr i64, ptr %v747, i64 0
  %v128 = load i64, ptr %v128.p
  %v129 = getelementptr i64, ptr %s20, i64 0
  %v130.p = getelementptr i64, ptr %v124, i64 0
  %v130 = load i64, ptr %v130.p
  %st112 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st112
  %v131.p = getelementptr i64, ptr %v124, i64 1
  %v131 = load i64, ptr %v131.p
  %st113 = getelementptr i64, ptr %v129, i64 1
  store i64 %v131, ptr %st113
  %v132.p = getelementptr i64, ptr %v124, i64 2
  %v132 = load i64, ptr %v132.p
  %st114 = getelementptr i64, ptr %v129, i64 2
  store i64 %v132, ptr %st114
  %v133 = add i64 0, 0
  %v134 = getelementptr i64, ptr %s21, i64 0
  %st115 = getelementptr i64, ptr %v134, i64 0
  store i64 %v133, ptr %st115
  %v748 = getelementptr i64, ptr @"rt.meta", i64 0
  %v135.p = getelementptr i64, ptr %v748, i64 0
  %v135 = load i64, ptr %v135.p
  br label %b24
b23:
  %v749 = getelementptr i64, ptr @"rt.meta", i64 0
  %st116 = getelementptr i64, ptr %v749, i64 0
  store i64 %v128, ptr %st116
  br label %b10
b24:
  %v750 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v750, i64 0
  store i64 %v135, ptr %st117
  %v136.p = getelementptr i64, ptr %v134, i64 0
  %v136 = load i64, ptr %v136.p
  %v137.p = getelementptr i64, ptr %v129, i64 1
  %v137 = load i64, ptr %v137.p
  %v138.c = icmp slt i64 %v136, %v137
  %v138 = zext i1 %v138.c to i64
  %c.b24 = icmp ne i64 %v138, 0
  br i1 %c.b24, label %b24.t119, label %b24.e120
b24.t119:
  br label %b25
b24.e120:
  br label %b26
b25:
  call void @"rt.region_enter"()
  %v751 = getelementptr i64, ptr @"rt.meta", i64 0
  %v139.p = getelementptr i64, ptr %v751, i64 0
  %v139 = load i64, ptr %v139.p
  %v140.p = getelementptr i64, ptr %v134, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = getelementptr i64, ptr %s22, i64 0
  %st120 = getelementptr i64, ptr %v141, i64 0
  store i64 %v140, ptr %st120
  %v752 = getelementptr i64, ptr @"rt.meta", i64 0
  %v142.p = getelementptr i64, ptr %v752, i64 0
  %v142 = load i64, ptr %v142.p
  br label %b27
b26:
  %v753 = getelementptr i64, ptr @"rt.meta", i64 0
  %st121 = getelementptr i64, ptr %v753, i64 0
  store i64 %v135, ptr %st121
  br label %b23
b27:
  %v754 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v754, i64 0
  store i64 %v142, ptr %st122
  %v143.p = getelementptr i64, ptr %v141, i64 0
  %v143 = load i64, ptr %v143.p
  %v144.p = getelementptr i64, ptr %v129, i64 1
  %v144 = load i64, ptr %v144.p
  %v145.c = icmp slt i64 %v143, %v144
  %v145 = zext i1 %v145.c to i64
  %c.b27 = icmp ne i64 %v145, 0
  br i1 %c.b27, label %b27.t124, label %b27.e125
b27.t124:
  br label %b30
b27.e125:
  br label %b31
b28:
  call void @"rt.region_enter"()
  %v755 = getelementptr i64, ptr @"rt.meta", i64 0
  %v157.p = getelementptr i64, ptr %v755, i64 0
  %v157 = load i64, ptr %v157.p
  %v158 = add i64 0, 1
  %v159.p = getelementptr i64, ptr %v141, i64 0
  %v159 = load i64, ptr %v159.p
  %v160 = add i64 %v159, %v158
  %st125 = getelementptr i64, ptr %v141, i64 0
  store i64 %v160, ptr %st125
  br label %b27
b29:
  %v756 = getelementptr i64, ptr @"rt.meta", i64 0
  %st126 = getelementptr i64, ptr %v756, i64 0
  store i64 %v142, ptr %st126
  %v161.p = getelementptr i64, ptr %v141, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v129, i64 1
  %v162 = load i64, ptr %v162.p
  %v163.c = icmp eq i64 %v161, %v162
  %v163 = zext i1 %v163.c to i64
  %c.b29 = icmp ne i64 %v163, 0
  br i1 %c.b29, label %b29.t128, label %b29.e129
b29.t128:
  br label %b34
b29.e129:
  br label %b35
b30:
  %v147.p = getelementptr i64, ptr %v141, i64 0
  %v147 = load i64, ptr %v147.p
  %v148.p = getelementptr i64, ptr %v129, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.c = icmp uge i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b30 = icmp ne i64 %v149, 0
  br i1 %c.b30, label %b30.t130, label %b30.e131
b30.t130:
  br label %b32
b30.e131:
  br label %b33
b31:
  %v146 = phi i64 [ %v145, %b27.e125 ], [ %v156, %b33 ]
  %c.b31 = icmp ne i64 %v146, 0
  br i1 %c.b31, label %b31.t132, label %b31.e133
b31.t132:
  br label %b28
b31.e133:
  br label %b29
b32:
  %v150 = add i64 0, 4
  call void @"rt.panic"(i64 %v150)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b33:
  %v151.p = getelementptr i64, ptr %v129, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = inttoptr i64 %v151 to ptr
  %v153 = getelementptr i8, ptr %v152, i64 %v147
  %v154.p = getelementptr i8, ptr %v153, i64 0
  %v154.b = load i8, ptr %v154.p
  %v154 = zext i8 %v154.b to i64
  %v155 = add i64 0, 10
  %v156.c = icmp ne i64 %v154, %v155
  %v156 = zext i1 %v156.c to i64
  br label %b31
b34:
  %v164.p = getelementptr i64, ptr %v134, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = getelementptr i64, ptr %s23, i64 0
  %st133 = getelementptr i64, ptr %v165, i64 0
  store i64 %v164, ptr %st133
  %v757 = getelementptr i64, ptr @"rt.meta", i64 0
  %v166.p = getelementptr i64, ptr %v757, i64 0
  %v166 = load i64, ptr %v166.p
  br label %b36
b35:
  %v211.p = getelementptr i64, ptr %v45, i64 1
  %v211 = load i64, ptr %v211.p
  %v212 = add i64 0, 0
  %v213.c = icmp eq i64 %v211, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b35 = icmp ne i64 %v213, 0
  br i1 %c.b35, label %b35.t135, label %b35.e136
b35.t135:
  br label %b44
b35.e136:
  br label %b45
b36:
  %v758 = getelementptr i64, ptr @"rt.meta", i64 0
  %st136 = getelementptr i64, ptr %v758, i64 0
  store i64 %v166, ptr %st136
  %v167.p = getelementptr i64, ptr %v165, i64 0
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v129, i64 1
  %v168 = load i64, ptr %v168.p
  %v169.c = icmp slt i64 %v167, %v168
  %v169 = zext i1 %v169.c to i64
  %c.b36 = icmp ne i64 %v169, 0
  br i1 %c.b36, label %b36.t138, label %b36.e139
b36.t138:
  br label %b37
b36.e139:
  br label %b38
b37:
  call void @"rt.region_enter"()
  %v759 = getelementptr i64, ptr @"rt.meta", i64 0
  %v170.p = getelementptr i64, ptr %v759, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 0, 1
  %v172 = add i64 %v6, %v171
  %v173 = getelementptr i64, ptr %s24, i64 0
  %v174.p = getelementptr i64, ptr %v45, i64 0
  %v174 = load i64, ptr %v174.p
  %st139 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st139
  %v175.p = getelementptr i64, ptr %v45, i64 1
  %v175 = load i64, ptr %v175.p
  %st140 = getelementptr i64, ptr %v173, i64 1
  store i64 %v175, ptr %st140
  %v176.p = getelementptr i64, ptr %v45, i64 2
  %v176 = load i64, ptr %v176.p
  %st141 = getelementptr i64, ptr %v173, i64 2
  store i64 %v176, ptr %st141
  %v177.p = getelementptr i64, ptr %v165, i64 0
  %v177 = load i64, ptr %v177.p
  %v178.p = getelementptr i64, ptr %v129, i64 1
  %v178 = load i64, ptr %v178.p
  %v179.c = icmp uge i64 %v177, %v178
  %v179 = zext i1 %v179.c to i64
  %c.b37 = icmp ne i64 %v179, 0
  br i1 %c.b37, label %b37.t143, label %b37.e144
b37.t143:
  br label %b39
b37.e144:
  br label %b40
b38:
  %v760 = getelementptr i64, ptr @"rt.meta", i64 0
  %st144 = getelementptr i64, ptr %v760, i64 0
  store i64 %v166, ptr %st144
  %v210.p = getelementptr i64, ptr %v129, i64 1
  %v210 = load i64, ptr %v210.p
  %st145 = getelementptr i64, ptr %v134, i64 0
  store i64 %v210, ptr %st145
  br label %b73
b39:
  %v180 = add i64 0, 5
  call void @"rt.panic"(i64 %v180)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b40:
  %v181.p = getelementptr i64, ptr %v129, i64 0
  %v181 = load i64, ptr %v181.p
  %v182 = inttoptr i64 %v181 to ptr
  %v183 = getelementptr i8, ptr %v182, i64 %v177
  %v184.p = getelementptr i8, ptr %v183, i64 0
  %v184.b = load i8, ptr %v184.p
  %v184 = zext i8 %v184.b to i64
  %v185.p = getelementptr i64, ptr %v173, i64 2
  %v185 = load i64, ptr %v185.p
  %v186.p = getelementptr i64, ptr %v173, i64 0
  %v186 = load i64, ptr %v186.p
  %v187.p = getelementptr i64, ptr %v173, i64 1
  %v187 = load i64, ptr %v187.p
  %v190 = add i64 %v186, %v187
  %v191 = call i64 @"rt.tip8"(i64 %v185, i64 %v190)
  %v192 = add i64 0, 0
  %v193.c = icmp ne i64 %v191, %v192
  %v193 = zext i1 %v193.c to i64
  %c.b40 = icmp ne i64 %v193, 0
  br i1 %c.b40, label %b40.t147, label %b40.e148
b40.t147:
  br label %b43
b40.e148:
  br label %b42
b41:
  %v188 = phi ptr [ %v197, %b42 ], [ %v194, %b43 ]
  %v189 = phi ptr [ %v198, %b42 ], [ %v195, %b43 ]
  %st148 = getelementptr i8, ptr %v189, i64 0
  %st148.b = trunc i64 %v184 to i8
  store i8 %st148.b, ptr %st148
  %v199.p = getelementptr i64, ptr %v173, i64 1
  %v199 = load i64, ptr %v199.p
  %v200 = add i64 0, 1
  %v201 = add i64 %v199, %v200
  %v202 = getelementptr i64, ptr %s25, i64 0
  %v203 = ptrtoint ptr %v188 to i64
  %st149 = getelementptr i64, ptr %v202, i64 0
  store i64 %v203, ptr %st149
  %st150 = getelementptr i64, ptr %v202, i64 1
  store i64 %v201, ptr %st150
  %st151 = getelementptr i64, ptr %v202, i64 2
  store i64 %v185, ptr %st151
  %v204.p = getelementptr i64, ptr %v202, i64 0
  %v204 = load i64, ptr %v204.p
  %st152 = getelementptr i64, ptr %v45, i64 0
  store i64 %v204, ptr %st152
  %v205.p = getelementptr i64, ptr %v202, i64 1
  %v205 = load i64, ptr %v205.p
  %st153 = getelementptr i64, ptr %v45, i64 1
  store i64 %v205, ptr %st153
  %v206.p = getelementptr i64, ptr %v202, i64 2
  %v206 = load i64, ptr %v206.p
  %st154 = getelementptr i64, ptr %v45, i64 2
  store i64 %v206, ptr %st154
  %v207 = add i64 0, 1
  %v208.p = getelementptr i64, ptr %v165, i64 0
  %v208 = load i64, ptr %v208.p
  %v209 = add i64 %v208, %v207
  %st155 = getelementptr i64, ptr %v165, i64 0
  store i64 %v209, ptr %st155
  br label %b36
b42:
  %v196 = add i64 0, 1
  %v197 = call ptr @"rt.slice_grow8"(i64 %v186, i64 %v187, i64 %v185, i64 %v196)
  %v198 = getelementptr i8, ptr %v197, i64 %v187
  br label %b41
b43:
  %v194 = inttoptr i64 %v186 to ptr
  %v195 = getelementptr i8, ptr %v194, i64 %v187
  br label %b41
b44:
  %v214 = getelementptr i64, ptr %s26, i64 0
  %v215.p = getelementptr i64, ptr %v134, i64 0
  %v215 = load i64, ptr %v215.p
  %v216.p = getelementptr i64, ptr %v141, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 0
  %v218.c = icmp slt i64 %v215, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b44 = icmp ne i64 %v218, 0
  br i1 %c.b44, label %b44.t157, label %b44.e158
b44.t157:
  br label %b46
b44.e158:
  br label %b47
b45:
  %v349 = getelementptr i64, ptr %s43, i64 0
  %v350 = getelementptr i64, ptr %s44, i64 0
  %v351.p = getelementptr i64, ptr %v45, i64 0
  %v351 = load i64, ptr %v351.p
  %v352.p = getelementptr i64, ptr %v45, i64 1
  %v352 = load i64, ptr %v352.p
  %v353.p = getelementptr i64, ptr %v45, i64 2
  %v353 = load i64, ptr %v353.p
  %v354.p = getelementptr i64, ptr %v134, i64 0
  %v354 = load i64, ptr %v354.p
  %v355.p = getelementptr i64, ptr %v141, i64 0
  %v355 = load i64, ptr %v355.p
  %v356 = add i64 0, 0
  %v357.c = icmp slt i64 %v354, %v356
  %v357 = zext i1 %v357.c to i64
  %c.b45 = icmp ne i64 %v357, 0
  br i1 %c.b45, label %b45.t159, label %b45.e160
b45.t159:
  br label %b59
b45.e160:
  br label %b60
b46:
  %v219 = add i64 0, 6
  call void @"rt.panic"(i64 %v219)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v220.c = icmp slt i64 %v216, %v215
  %v220 = zext i1 %v220.c to i64
  %c.b47 = icmp ne i64 %v220, 0
  br i1 %c.b47, label %b47.t161, label %b47.e162
b47.t161:
  br label %b48
b47.e162:
  br label %b49
b48:
  %v221 = add i64 0, 7
  call void @"rt.panic"(i64 %v221)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b49:
  %v222.p = getelementptr i64, ptr %v129, i64 1
  %v222 = load i64, ptr %v222.p
  %v223.c = icmp sgt i64 %v216, %v222
  %v223 = zext i1 %v223.c to i64
  %c.b49 = icmp ne i64 %v223, 0
  br i1 %c.b49, label %b49.t163, label %b49.e164
b49.t163:
  br label %b50
b49.e164:
  br label %b51
b50:
  %v224 = add i64 0, 8
  call void @"rt.panic"(i64 %v224)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v225.p = getelementptr i64, ptr %v129, i64 0
  %v225 = load i64, ptr %v225.p
  %v226 = inttoptr i64 %v225 to ptr
  %v227 = getelementptr i8, ptr %v226, i64 %v215
  %v228 = sub i64 %v216, %v215
  %v229.p = getelementptr i64, ptr %v129, i64 2
  %v229 = load i64, ptr %v229.p
  %v230 = getelementptr i64, ptr %s25, i64 0
  %v231 = ptrtoint ptr %v227 to i64
  %st164 = getelementptr i64, ptr %v230, i64 0
  store i64 %v231, ptr %st164
  %st165 = getelementptr i64, ptr %v230, i64 1
  store i64 %v228, ptr %st165
  %st166 = getelementptr i64, ptr %v230, i64 2
  store i64 %v229, ptr %st166
  %v232.p = getelementptr i64, ptr %v230, i64 0
  %v232 = load i64, ptr %v232.p
  %v233.p = getelementptr i64, ptr %v230, i64 1
  %v233 = load i64, ptr %v233.p
  %v234.p = getelementptr i64, ptr %v230, i64 2
  %v234 = load i64, ptr %v234.p
  call void @"std/io.dropCR"(ptr %v214, i64 %v232, i64 %v233, i64 %v234)
  %v235 = getelementptr i64, ptr %s24, i64 0
  %v236.p = getelementptr i64, ptr %v214, i64 0
  %v236 = load i64, ptr %v236.p
  %st167 = getelementptr i64, ptr %v235, i64 0
  store i64 %v236, ptr %st167
  %v237.p = getelementptr i64, ptr %v214, i64 1
  %v237 = load i64, ptr %v237.p
  %st168 = getelementptr i64, ptr %v235, i64 1
  store i64 %v237, ptr %st168
  %v238.p = getelementptr i64, ptr %v214, i64 2
  %v238 = load i64, ptr %v238.p
  %st169 = getelementptr i64, ptr %v235, i64 2
  store i64 %v238, ptr %st169
  %v239 = getelementptr i64, ptr %s27, i64 0
  %v240 = add i64 0, 0
  %v241 = getelementptr i64, ptr %s28, i64 0
  %v242 = getelementptr i64, ptr %s29, i64 0
  %v243 = add i64 0, 0
  %st170 = getelementptr i64, ptr %v242, i64 0
  store i64 %v243, ptr %st170
  %st171 = getelementptr i64, ptr %v242, i64 1
  store i64 %v243, ptr %st171
  %st172 = getelementptr i64, ptr %v242, i64 2
  store i64 %v243, ptr %st172
  %v244.p = getelementptr i64, ptr %v235, i64 0
  %v244 = load i64, ptr %v244.p
  %st173 = getelementptr i64, ptr %v242, i64 0
  store i64 %v244, ptr %st173
  %v245.p = getelementptr i64, ptr %v235, i64 1
  %v245 = load i64, ptr %v245.p
  %st174 = getelementptr i64, ptr %v242, i64 1
  store i64 %v245, ptr %st174
  %v246.p = getelementptr i64, ptr %v235, i64 2
  %v246 = load i64, ptr %v246.p
  %st175 = getelementptr i64, ptr %v242, i64 2
  store i64 %v246, ptr %st175
  %v247 = getelementptr i64, ptr %s30, i64 0
  %v248.p = getelementptr i64, ptr %v242, i64 0
  %v248 = load i64, ptr %v248.p
  %st176 = getelementptr i64, ptr %v247, i64 0
  store i64 %v248, ptr %st176
  %v249.p = getelementptr i64, ptr %v242, i64 1
  %v249 = load i64, ptr %v249.p
  %st177 = getelementptr i64, ptr %v247, i64 1
  store i64 %v249, ptr %st177
  %v250.p = getelementptr i64, ptr %v242, i64 2
  %v250 = load i64, ptr %v250.p
  %st178 = getelementptr i64, ptr %v247, i64 2
  store i64 %v250, ptr %st178
  %v761 = getelementptr i64, ptr @"rt.meta", i64 0
  %v251.p = getelementptr i64, ptr %v761, i64 0
  %v251 = load i64, ptr %v251.p
  %v252 = getelementptr i64, ptr %s31, i64 0
  %v253.p = getelementptr i64, ptr %v247, i64 0
  %v253 = load i64, ptr %v253.p
  %v254.p = getelementptr i64, ptr %v247, i64 1
  %v254 = load i64, ptr %v254.p
  %v255.p = getelementptr i64, ptr %v247, i64 2
  %v255 = load i64, ptr %v255.p
  call void @"std/io.Raw"(ptr %v252, i64 %v253, i64 %v254, i64 %v255)
  %v256 = getelementptr i64, ptr %s32, i64 0
  %v257.p = getelementptr i64, ptr %v252, i64 0
  %v257 = load i64, ptr %v257.p
  %st179 = getelementptr i64, ptr %v256, i64 0
  store i64 %v257, ptr %st179
  %v258.p = getelementptr i64, ptr %v252, i64 1
  %v258 = load i64, ptr %v258.p
  %st180 = getelementptr i64, ptr %v256, i64 1
  store i64 %v258, ptr %st180
  %v259.p = getelementptr i64, ptr %v252, i64 2
  %v259 = load i64, ptr %v259.p
  %st181 = getelementptr i64, ptr %v256, i64 2
  store i64 %v259, ptr %st181
  %v260.p = getelementptr i64, ptr %v31, i64 0
  %v260 = load i64, ptr %v260.p
  %v261.c = icmp slt i64 %v260, %v4
  %v261 = zext i1 %v261.c to i64
  %c.b51 = icmp ne i64 %v261, 0
  br i1 %c.b51, label %b51.t183, label %b51.e184
b51.t183:
  br label %b53
b51.e184:
  br label %b54
b52:
  %v762 = getelementptr i64, ptr @"rt.meta", i64 0
  %st184 = getelementptr i64, ptr %v762, i64 0
  store i64 %v251, ptr %st184
  br label %b72
b53:
  %v763 = getelementptr i64, ptr @"rt.meta", i64 0
  %v262.p = getelementptr i64, ptr %v763, i64 0
  %v262 = load i64, ptr %v262.p
  call void @"rt.region_enter"()
  %v764 = getelementptr i64, ptr @"rt.meta", i64 0
  %v263.p = getelementptr i64, ptr %v764, i64 0
  %v263 = load i64, ptr %v263.p
  %v264 = getelementptr i64, ptr %s33, i64 0
  %v265.p = getelementptr i64, ptr %v256, i64 0
  %v265 = load i64, ptr %v265.p
  %v266.p = getelementptr i64, ptr %v256, i64 1
  %v266 = load i64, ptr %v266.p
  %v267.p = getelementptr i64, ptr %v256, i64 2
  %v267 = load i64, ptr %v267.p
  call void @"std/utf8.Parse"(ptr %v264, i64 %v265, i64 %v266, i64 %v267)
  %v268 = add i64 0, 3
  %v269 = getelementptr i64, ptr %v264, i64 %v268
  %v270 = getelementptr i64, ptr %s34, i64 0
  %v271.p = getelementptr i64, ptr %v264, i64 0
  %v271 = load i64, ptr %v271.p
  %st185 = getelementptr i64, ptr %v270, i64 0
  store i64 %v271, ptr %st185
  %v272.p = getelementptr i64, ptr %v264, i64 1
  %v272 = load i64, ptr %v272.p
  %st186 = getelementptr i64, ptr %v270, i64 1
  store i64 %v272, ptr %st186
  %v273.p = getelementptr i64, ptr %v264, i64 2
  %v273 = load i64, ptr %v273.p
  %st187 = getelementptr i64, ptr %v270, i64 2
  store i64 %v273, ptr %st187
  %v274 = getelementptr i64, ptr %s15, i64 0
  %v275.p = getelementptr i64, ptr %v269, i64 0
  %v275 = load i64, ptr %v275.p
  %st188 = getelementptr i64, ptr %v274, i64 0
  store i64 %v275, ptr %st188
  %v276.p = getelementptr i64, ptr %v269, i64 1
  %v276 = load i64, ptr %v276.p
  %st189 = getelementptr i64, ptr %v274, i64 1
  store i64 %v276, ptr %st189
  %v277.p = getelementptr i64, ptr %v269, i64 2
  %v277 = load i64, ptr %v277.p
  %st190 = getelementptr i64, ptr %v274, i64 2
  store i64 %v277, ptr %st190
  %v278.p = getelementptr i64, ptr %v269, i64 3
  %v278 = load i64, ptr %v278.p
  %st191 = getelementptr i64, ptr %v274, i64 3
  store i64 %v278, ptr %st191
  %v279.p = getelementptr i64, ptr %v269, i64 4
  %v279 = load i64, ptr %v279.p
  %st192 = getelementptr i64, ptr %v274, i64 4
  store i64 %v279, ptr %st192
  %v280.p = getelementptr i64, ptr %v269, i64 5
  %v280 = load i64, ptr %v280.p
  %st193 = getelementptr i64, ptr %v274, i64 5
  store i64 %v280, ptr %st193
  %v281.p = getelementptr i64, ptr %v274, i64 0
  %v281 = load i64, ptr %v281.p
  %v282 = add i64 0, 0
  %v283.c = icmp ne i64 %v281, %v282
  %v283 = zext i1 %v283.c to i64
  %c.b53 = icmp ne i64 %v283, 0
  br i1 %c.b53, label %b53.t195, label %b53.e196
b53.t195:
  br label %b55
b53.e196:
  br label %b56
b54:
  br label %b58
b55:
  %v284 = add i64 0, 1
  %v285 = getelementptr i64, ptr %v274, i64 %v284
  %v286 = getelementptr i64, ptr %s35, i64 0
  %v287.p = getelementptr i64, ptr %v285, i64 0
  %v287 = load i64, ptr %v287.p
  %st196 = getelementptr i64, ptr %v286, i64 0
  store i64 %v287, ptr %st196
  %v288.p = getelementptr i64, ptr %v285, i64 1
  %v288 = load i64, ptr %v288.p
  %st197 = getelementptr i64, ptr %v286, i64 1
  store i64 %v288, ptr %st197
  %v289.p = getelementptr i64, ptr %v285, i64 2
  %v289 = load i64, ptr %v289.p
  %st198 = getelementptr i64, ptr %v286, i64 2
  store i64 %v289, ptr %st198
  %v290.p = getelementptr i64, ptr %v285, i64 3
  %v290 = load i64, ptr %v290.p
  %st199 = getelementptr i64, ptr %v286, i64 3
  store i64 %v290, ptr %st199
  %v291.p = getelementptr i64, ptr %v285, i64 4
  %v291 = load i64, ptr %v291.p
  %st200 = getelementptr i64, ptr %v286, i64 4
  store i64 %v291, ptr %st200
  %v292 = getelementptr i64, ptr @"str.20", i64 0
  %v293 = add i64 0, 1
  %v294 = add i64 0, 0
  %v295 = getelementptr i64, ptr %s36, i64 0
  %v296 = ptrtoint ptr %v292 to i64
  %st201 = getelementptr i64, ptr %v295, i64 0
  store i64 %v296, ptr %st201
  %st202 = getelementptr i64, ptr %v295, i64 1
  store i64 %v293, ptr %st202
  %st203 = getelementptr i64, ptr %v295, i64 2
  store i64 %v294, ptr %st203
  br label %b57
b56:
  br label %b57
b57:
  %v297 = phi ptr [ %v295, %b55 ], [ %v270, %b56 ]
  %v298 = getelementptr i64, ptr %s37, i64 0
  %v299.p = getelementptr i64, ptr %v297, i64 0
  %v299 = load i64, ptr %v299.p
  %st204 = getelementptr i64, ptr %v298, i64 0
  store i64 %v299, ptr %st204
  %v300.p = getelementptr i64, ptr %v297, i64 1
  %v300 = load i64, ptr %v300.p
  %st205 = getelementptr i64, ptr %v298, i64 1
  store i64 %v300, ptr %st205
  %v301.p = getelementptr i64, ptr %v297, i64 2
  %v301 = load i64, ptr %v301.p
  %st206 = getelementptr i64, ptr %v298, i64 2
  store i64 %v301, ptr %st206
  call void @"rt.region_relocate8"(ptr %v298, i64 %v262)
  %v765 = getelementptr i64, ptr @"rt.meta", i64 0
  %st207 = getelementptr i64, ptr %v765, i64 0
  store i64 %v262, ptr %st207
  %v302 = getelementptr i64, ptr %s38, i64 0
  %v303.p = getelementptr i64, ptr %v298, i64 0
  %v303 = load i64, ptr %v303.p
  %st208 = getelementptr i64, ptr %v302, i64 0
  store i64 %v303, ptr %st208
  %v304.p = getelementptr i64, ptr %v298, i64 1
  %v304 = load i64, ptr %v304.p
  %st209 = getelementptr i64, ptr %v302, i64 1
  store i64 %v304, ptr %st209
  %v305.p = getelementptr i64, ptr %v298, i64 2
  %v305 = load i64, ptr %v305.p
  %st210 = getelementptr i64, ptr %v302, i64 2
  store i64 %v305, ptr %st210
  %v306 = getelementptr i64, ptr @"str.21", i64 0
  %v307 = add i64 0, 3
  %v308 = add i64 0, 0
  %v309 = getelementptr i64, ptr %s39, i64 0
  %v310 = ptrtoint ptr %v306 to i64
  %st211 = getelementptr i64, ptr %v309, i64 0
  store i64 %v310, ptr %st211
  %st212 = getelementptr i64, ptr %v309, i64 1
  store i64 %v307, ptr %st212
  %st213 = getelementptr i64, ptr %v309, i64 2
  store i64 %v308, ptr %st213
  %v311.p = getelementptr i64, ptr %v309, i64 1
  %v311 = load i64, ptr %v311.p
  %v312.p = getelementptr i64, ptr %v302, i64 1
  %v312 = load i64, ptr %v312.p
  %v313 = add i64 %v311, %v312
  %v766 = getelementptr i64, ptr @"rt.meta", i64 0
  %v314.p = getelementptr i64, ptr %v766, i64 0
  %v314 = load i64, ptr %v314.p
  %v315.p = getelementptr i64, ptr %v309, i64 0
  %v315 = load i64, ptr %v315.p
  %v316.p = getelementptr i64, ptr %v309, i64 1
  %v316 = load i64, ptr %v316.p
  %v317.p = getelementptr i64, ptr %v309, i64 2
  %v317 = load i64, ptr %v317.p
  %v318 = call ptr @"rt.cat8"(i64 %v315, i64 %v316, i64 %v317, i64 %v314, i64 %v312)
  %v319 = getelementptr i8, ptr %v318, i64 %v311
  %v320.p = getelementptr i64, ptr %v302, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = inttoptr i64 %v320 to ptr
  call void @"rt.copy8"(ptr %v319, ptr %v321, i64 %v312)
  %v322 = getelementptr i64, ptr %s40, i64 0
  %v323 = ptrtoint ptr %v318 to i64
  %st214 = getelementptr i64, ptr %v322, i64 0
  store i64 %v323, ptr %st214
  %st215 = getelementptr i64, ptr %v322, i64 1
  store i64 %v313, ptr %st215
  %st216 = getelementptr i64, ptr %v322, i64 2
  store i64 %v314, ptr %st216
  %v324 = getelementptr i64, ptr @"str.22", i64 0
  %v325 = add i64 0, 1
  %v326 = add i64 0, 0
  %v327 = getelementptr i64, ptr %s41, i64 0
  %v328 = ptrtoint ptr %v324 to i64
  %st217 = getelementptr i64, ptr %v327, i64 0
  store i64 %v328, ptr %st217
  %st218 = getelementptr i64, ptr %v327, i64 1
  store i64 %v325, ptr %st218
  %st219 = getelementptr i64, ptr %v327, i64 2
  store i64 %v326, ptr %st219
  %v329.p = getelementptr i64, ptr %v322, i64 1
  %v329 = load i64, ptr %v329.p
  %v330.p = getelementptr i64, ptr %v327, i64 1
  %v330 = load i64, ptr %v330.p
  %v331 = add i64 %v329, %v330
  %v767 = getelementptr i64, ptr @"rt.meta", i64 0
  %v332.p = getelementptr i64, ptr %v767, i64 0
  %v332 = load i64, ptr %v332.p
  %v333.p = getelementptr i64, ptr %v322, i64 0
  %v333 = load i64, ptr %v333.p
  %v334.p = getelementptr i64, ptr %v322, i64 1
  %v334 = load i64, ptr %v334.p
  %v335.p = getelementptr i64, ptr %v322, i64 2
  %v335 = load i64, ptr %v335.p
  %v336 = call ptr @"rt.cat8"(i64 %v333, i64 %v334, i64 %v335, i64 %v332, i64 %v330)
  %v337 = getelementptr i8, ptr %v336, i64 %v329
  %v338.p = getelementptr i64, ptr %v327, i64 0
  %v338 = load i64, ptr %v338.p
  %v339 = inttoptr i64 %v338 to ptr
  call void @"rt.copy8"(ptr %v337, ptr %v339, i64 %v330)
  %v340 = getelementptr i64, ptr %s42, i64 0
  %v341 = ptrtoint ptr %v336 to i64
  %st220 = getelementptr i64, ptr %v340, i64 0
  store i64 %v341, ptr %st220
  %st221 = getelementptr i64, ptr %v340, i64 1
  store i64 %v331, ptr %st221
  %st222 = getelementptr i64, ptr %v340, i64 2
  store i64 %v332, ptr %st222
  call void @"rt.print_str"(ptr %v340)
  %v342 = add i64 0, 10
  call void @"rt.print_char"(i64 %v342)
  br label %b58
b58:
  %v343 = add i64 0, 1
  %v344.p = getelementptr i64, ptr %v31, i64 0
  %v344 = load i64, ptr %v344.p
  %v345 = add i64 %v344, %v343
  %st223 = getelementptr i64, ptr %v31, i64 0
  store i64 %v345, ptr %st223
  %v346.p = getelementptr i64, ptr %v256, i64 1
  %v346 = load i64, ptr %v346.p
  %v347.p = getelementptr i64, ptr %v33, i64 0
  %v347 = load i64, ptr %v347.p
  %v348 = add i64 %v347, %v346
  %st224 = getelementptr i64, ptr %v33, i64 0
  store i64 %v348, ptr %st224
  br label %b52
b59:
  %v358 = add i64 0, 9
  call void @"rt.panic"(i64 %v358)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b60:
  %v359.c = icmp slt i64 %v355, %v354
  %v359 = zext i1 %v359.c to i64
  %c.b60 = icmp ne i64 %v359, 0
  br i1 %c.b60, label %b60.t226, label %b60.e227
b60.t226:
  br label %b61
b60.e227:
  br label %b62
b61:
  %v360 = add i64 0, 10
  call void @"rt.panic"(i64 %v360)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b62:
  %v361.p = getelementptr i64, ptr %v129, i64 1
  %v361 = load i64, ptr %v361.p
  %v362.c = icmp sgt i64 %v355, %v361
  %v362 = zext i1 %v362.c to i64
  %c.b62 = icmp ne i64 %v362, 0
  br i1 %c.b62, label %b62.t228, label %b62.e229
b62.t228:
  br label %b63
b62.e229:
  br label %b64
b63:
  %v363 = add i64 0, 11
  call void @"rt.panic"(i64 %v363)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b64:
  %v364.p = getelementptr i64, ptr %v129, i64 0
  %v364 = load i64, ptr %v364.p
  %v365 = inttoptr i64 %v364 to ptr
  %v366 = getelementptr i8, ptr %v365, i64 %v354
  %v367 = sub i64 %v355, %v354
  %v368.p = getelementptr i64, ptr %v129, i64 2
  %v368 = load i64, ptr %v368.p
  %v369 = getelementptr i64, ptr %s42, i64 0
  %v370 = ptrtoint ptr %v366 to i64
  %st229 = getelementptr i64, ptr %v369, i64 0
  store i64 %v370, ptr %st229
  %st230 = getelementptr i64, ptr %v369, i64 1
  store i64 %v367, ptr %st230
  %st231 = getelementptr i64, ptr %v369, i64 2
  store i64 %v368, ptr %st231
  %v371.p = getelementptr i64, ptr %v369, i64 0
  %v371 = load i64, ptr %v371.p
  %v372.p = getelementptr i64, ptr %v369, i64 1
  %v372 = load i64, ptr %v372.p
  %v373.p = getelementptr i64, ptr %v369, i64 2
  %v373 = load i64, ptr %v373.p
  call void @"std/io.joined"(ptr %v350, i64 %v351, i64 %v352, i64 %v353, i64 %v371, i64 %v372, i64 %v373)
  %v374.p = getelementptr i64, ptr %v350, i64 0
  %v374 = load i64, ptr %v374.p
  %v375.p = getelementptr i64, ptr %v350, i64 1
  %v375 = load i64, ptr %v375.p
  %v376.p = getelementptr i64, ptr %v350, i64 2
  %v376 = load i64, ptr %v376.p
  call void @"std/io.dropCR"(ptr %v349, i64 %v374, i64 %v375, i64 %v376)
  %v377 = getelementptr i64, ptr %s41, i64 0
  %v378.p = getelementptr i64, ptr %v349, i64 0
  %v378 = load i64, ptr %v378.p
  %st232 = getelementptr i64, ptr %v377, i64 0
  store i64 %v378, ptr %st232
  %v379.p = getelementptr i64, ptr %v349, i64 1
  %v379 = load i64, ptr %v379.p
  %st233 = getelementptr i64, ptr %v377, i64 1
  store i64 %v379, ptr %st233
  %v380.p = getelementptr i64, ptr %v349, i64 2
  %v380 = load i64, ptr %v380.p
  %st234 = getelementptr i64, ptr %v377, i64 2
  store i64 %v380, ptr %st234
  %v381 = getelementptr i64, ptr %s45, i64 0
  %v382 = add i64 0, 0
  %v383 = getelementptr i64, ptr %s46, i64 0
  %v384 = getelementptr i64, ptr %s40, i64 0
  %v385 = add i64 0, 0
  %st235 = getelementptr i64, ptr %v384, i64 0
  store i64 %v385, ptr %st235
  %st236 = getelementptr i64, ptr %v384, i64 1
  store i64 %v385, ptr %st236
  %st237 = getelementptr i64, ptr %v384, i64 2
  store i64 %v385, ptr %st237
  %v386.p = getelementptr i64, ptr %v377, i64 0
  %v386 = load i64, ptr %v386.p
  %st238 = getelementptr i64, ptr %v384, i64 0
  store i64 %v386, ptr %st238
  %v387.p = getelementptr i64, ptr %v377, i64 1
  %v387 = load i64, ptr %v387.p
  %st239 = getelementptr i64, ptr %v384, i64 1
  store i64 %v387, ptr %st239
  %v388.p = getelementptr i64, ptr %v377, i64 2
  %v388 = load i64, ptr %v388.p
  %st240 = getelementptr i64, ptr %v384, i64 2
  store i64 %v388, ptr %st240
  %v389 = getelementptr i64, ptr %s39, i64 0
  %v390.p = getelementptr i64, ptr %v384, i64 0
  %v390 = load i64, ptr %v390.p
  %st241 = getelementptr i64, ptr %v389, i64 0
  store i64 %v390, ptr %st241
  %v391.p = getelementptr i64, ptr %v384, i64 1
  %v391 = load i64, ptr %v391.p
  %st242 = getelementptr i64, ptr %v389, i64 1
  store i64 %v391, ptr %st242
  %v392.p = getelementptr i64, ptr %v384, i64 2
  %v392 = load i64, ptr %v392.p
  %st243 = getelementptr i64, ptr %v389, i64 2
  store i64 %v392, ptr %st243
  %v768 = getelementptr i64, ptr @"rt.meta", i64 0
  %v393.p = getelementptr i64, ptr %v768, i64 0
  %v393 = load i64, ptr %v393.p
  %v394 = getelementptr i64, ptr %s47, i64 0
  %v395.p = getelementptr i64, ptr %v389, i64 0
  %v395 = load i64, ptr %v395.p
  %v396.p = getelementptr i64, ptr %v389, i64 1
  %v396 = load i64, ptr %v396.p
  %v397.p = getelementptr i64, ptr %v389, i64 2
  %v397 = load i64, ptr %v397.p
  call void @"std/io.Raw"(ptr %v394, i64 %v395, i64 %v396, i64 %v397)
  %v398 = getelementptr i64, ptr %s38, i64 0
  %v399.p = getelementptr i64, ptr %v394, i64 0
  %v399 = load i64, ptr %v399.p
  %st244 = getelementptr i64, ptr %v398, i64 0
  store i64 %v399, ptr %st244
  %v400.p = getelementptr i64, ptr %v394, i64 1
  %v400 = load i64, ptr %v400.p
  %st245 = getelementptr i64, ptr %v398, i64 1
  store i64 %v400, ptr %st245
  %v401.p = getelementptr i64, ptr %v394, i64 2
  %v401 = load i64, ptr %v401.p
  %st246 = getelementptr i64, ptr %v398, i64 2
  store i64 %v401, ptr %st246
  %v402.p = getelementptr i64, ptr %v31, i64 0
  %v402 = load i64, ptr %v402.p
  %v403.c = icmp slt i64 %v402, %v4
  %v403 = zext i1 %v403.c to i64
  %c.b64 = icmp ne i64 %v403, 0
  br i1 %c.b64, label %b64.t248, label %b64.e249
b64.t248:
  br label %b66
b64.e249:
  br label %b67
b65:
  %v769 = getelementptr i64, ptr @"rt.meta", i64 0
  %st249 = getelementptr i64, ptr %v769, i64 0
  store i64 %v393, ptr %st249
  %v491 = add i64 0, 1
  %v492 = add i64 %v6, %v491
  %v493 = add i64 0, 0
  %v494 = call ptr @"rt.region_alloc8"(i64 %v492, i64 %v493)
  %v495 = add i64 0, 0
  %v496 = getelementptr i64, ptr %s38, i64 0
  %v497 = ptrtoint ptr %v494 to i64
  %st250 = getelementptr i64, ptr %v496, i64 0
  store i64 %v497, ptr %st250
  %st251 = getelementptr i64, ptr %v496, i64 1
  store i64 %v495, ptr %st251
  %st252 = getelementptr i64, ptr %v496, i64 2
  store i64 %v492, ptr %st252
  %v498 = getelementptr i64, ptr %s39, i64 0
  %v499.p = getelementptr i64, ptr %v496, i64 0
  %v499 = load i64, ptr %v499.p
  %st253 = getelementptr i64, ptr %v498, i64 0
  store i64 %v499, ptr %st253
  %v500.p = getelementptr i64, ptr %v496, i64 1
  %v500 = load i64, ptr %v500.p
  %st254 = getelementptr i64, ptr %v498, i64 1
  store i64 %v500, ptr %st254
  %v501.p = getelementptr i64, ptr %v496, i64 2
  %v501 = load i64, ptr %v501.p
  %st255 = getelementptr i64, ptr %v498, i64 2
  store i64 %v501, ptr %st255
  %v502 = add i64 0, 1
  %v503 = add i64 %v6, %v502
  call void @"rt.region_relocate8"(ptr %v498, i64 %v503)
  %v504.p = getelementptr i64, ptr %v498, i64 0
  %v504 = load i64, ptr %v504.p
  %st256 = getelementptr i64, ptr %v45, i64 0
  store i64 %v504, ptr %st256
  %v505.p = getelementptr i64, ptr %v498, i64 1
  %v505 = load i64, ptr %v505.p
  %st257 = getelementptr i64, ptr %v45, i64 1
  store i64 %v505, ptr %st257
  %v506.p = getelementptr i64, ptr %v498, i64 2
  %v506 = load i64, ptr %v506.p
  %st258 = getelementptr i64, ptr %v45, i64 2
  store i64 %v506, ptr %st258
  br label %b72
b66:
  %v770 = getelementptr i64, ptr @"rt.meta", i64 0
  %v404.p = getelementptr i64, ptr %v770, i64 0
  %v404 = load i64, ptr %v404.p
  call void @"rt.region_enter"()
  %v771 = getelementptr i64, ptr @"rt.meta", i64 0
  %v405.p = getelementptr i64, ptr %v771, i64 0
  %v405 = load i64, ptr %v405.p
  %v406 = getelementptr i64, ptr %s48, i64 0
  %v407.p = getelementptr i64, ptr %v398, i64 0
  %v407 = load i64, ptr %v407.p
  %v408.p = getelementptr i64, ptr %v398, i64 1
  %v408 = load i64, ptr %v408.p
  %v409.p = getelementptr i64, ptr %v398, i64 2
  %v409 = load i64, ptr %v409.p
  call void @"std/utf8.Parse"(ptr %v406, i64 %v407, i64 %v408, i64 %v409)
  %v410 = add i64 0, 3
  %v411 = getelementptr i64, ptr %v406, i64 %v410
  %v412 = getelementptr i64, ptr %s36, i64 0
  %v413.p = getelementptr i64, ptr %v406, i64 0
  %v413 = load i64, ptr %v413.p
  %st259 = getelementptr i64, ptr %v412, i64 0
  store i64 %v413, ptr %st259
  %v414.p = getelementptr i64, ptr %v406, i64 1
  %v414 = load i64, ptr %v414.p
  %st260 = getelementptr i64, ptr %v412, i64 1
  store i64 %v414, ptr %st260
  %v415.p = getelementptr i64, ptr %v406, i64 2
  %v415 = load i64, ptr %v415.p
  %st261 = getelementptr i64, ptr %v412, i64 2
  store i64 %v415, ptr %st261
  %v416 = getelementptr i64, ptr %s15, i64 0
  %v417.p = getelementptr i64, ptr %v411, i64 0
  %v417 = load i64, ptr %v417.p
  %st262 = getelementptr i64, ptr %v416, i64 0
  store i64 %v417, ptr %st262
  %v418.p = getelementptr i64, ptr %v411, i64 1
  %v418 = load i64, ptr %v418.p
  %st263 = getelementptr i64, ptr %v416, i64 1
  store i64 %v418, ptr %st263
  %v419.p = getelementptr i64, ptr %v411, i64 2
  %v419 = load i64, ptr %v419.p
  %st264 = getelementptr i64, ptr %v416, i64 2
  store i64 %v419, ptr %st264
  %v420.p = getelementptr i64, ptr %v411, i64 3
  %v420 = load i64, ptr %v420.p
  %st265 = getelementptr i64, ptr %v416, i64 3
  store i64 %v420, ptr %st265
  %v421.p = getelementptr i64, ptr %v411, i64 4
  %v421 = load i64, ptr %v421.p
  %st266 = getelementptr i64, ptr %v416, i64 4
  store i64 %v421, ptr %st266
  %v422.p = getelementptr i64, ptr %v411, i64 5
  %v422 = load i64, ptr %v422.p
  %st267 = getelementptr i64, ptr %v416, i64 5
  store i64 %v422, ptr %st267
  %v423.p = getelementptr i64, ptr %v416, i64 0
  %v423 = load i64, ptr %v423.p
  %v424 = add i64 0, 0
  %v425.c = icmp ne i64 %v423, %v424
  %v425 = zext i1 %v425.c to i64
  %c.b66 = icmp ne i64 %v425, 0
  br i1 %c.b66, label %b66.t269, label %b66.e270
b66.t269:
  br label %b68
b66.e270:
  br label %b69
b67:
  br label %b71
b68:
  %v426 = add i64 0, 1
  %v427 = getelementptr i64, ptr %v416, i64 %v426
  %v428 = getelementptr i64, ptr %s35, i64 0
  %v429.p = getelementptr i64, ptr %v427, i64 0
  %v429 = load i64, ptr %v429.p
  %st270 = getelementptr i64, ptr %v428, i64 0
  store i64 %v429, ptr %st270
  %v430.p = getelementptr i64, ptr %v427, i64 1
  %v430 = load i64, ptr %v430.p
  %st271 = getelementptr i64, ptr %v428, i64 1
  store i64 %v430, ptr %st271
  %v431.p = getelementptr i64, ptr %v427, i64 2
  %v431 = load i64, ptr %v431.p
  %st272 = getelementptr i64, ptr %v428, i64 2
  store i64 %v431, ptr %st272
  %v432.p = getelementptr i64, ptr %v427, i64 3
  %v432 = load i64, ptr %v432.p
  %st273 = getelementptr i64, ptr %v428, i64 3
  store i64 %v432, ptr %st273
  %v433.p = getelementptr i64, ptr %v427, i64 4
  %v433 = load i64, ptr %v433.p
  %st274 = getelementptr i64, ptr %v428, i64 4
  store i64 %v433, ptr %st274
  %v434 = getelementptr i64, ptr @"str.20", i64 0
  %v435 = add i64 0, 1
  %v436 = add i64 0, 0
  %v437 = getelementptr i64, ptr %s34, i64 0
  %v438 = ptrtoint ptr %v434 to i64
  %st275 = getelementptr i64, ptr %v437, i64 0
  store i64 %v438, ptr %st275
  %st276 = getelementptr i64, ptr %v437, i64 1
  store i64 %v435, ptr %st276
  %st277 = getelementptr i64, ptr %v437, i64 2
  store i64 %v436, ptr %st277
  br label %b70
b69:
  br label %b70
b70:
  %v439 = phi ptr [ %v437, %b68 ], [ %v412, %b69 ]
  %v440 = getelementptr i64, ptr %s49, i64 0
  %v441.p = getelementptr i64, ptr %v439, i64 0
  %v441 = load i64, ptr %v441.p
  %st278 = getelementptr i64, ptr %v440, i64 0
  store i64 %v441, ptr %st278
  %v442.p = getelementptr i64, ptr %v439, i64 1
  %v442 = load i64, ptr %v442.p
  %st279 = getelementptr i64, ptr %v440, i64 1
  store i64 %v442, ptr %st279
  %v443.p = getelementptr i64, ptr %v439, i64 2
  %v443 = load i64, ptr %v443.p
  %st280 = getelementptr i64, ptr %v440, i64 2
  store i64 %v443, ptr %st280
  call void @"rt.region_relocate8"(ptr %v440, i64 %v404)
  %v772 = getelementptr i64, ptr @"rt.meta", i64 0
  %st281 = getelementptr i64, ptr %v772, i64 0
  store i64 %v404, ptr %st281
  %v444 = getelementptr i64, ptr %s50, i64 0
  %v445.p = getelementptr i64, ptr %v440, i64 0
  %v445 = load i64, ptr %v445.p
  %st282 = getelementptr i64, ptr %v444, i64 0
  store i64 %v445, ptr %st282
  %v446.p = getelementptr i64, ptr %v440, i64 1
  %v446 = load i64, ptr %v446.p
  %st283 = getelementptr i64, ptr %v444, i64 1
  store i64 %v446, ptr %st283
  %v447.p = getelementptr i64, ptr %v440, i64 2
  %v447 = load i64, ptr %v447.p
  %st284 = getelementptr i64, ptr %v444, i64 2
  store i64 %v447, ptr %st284
  %v448 = getelementptr i64, ptr @"str.21", i64 0
  %v449 = add i64 0, 3
  %v450 = add i64 0, 0
  %v451 = getelementptr i64, ptr %s51, i64 0
  %v452 = ptrtoint ptr %v448 to i64
  %st285 = getelementptr i64, ptr %v451, i64 0
  store i64 %v452, ptr %st285
  %st286 = getelementptr i64, ptr %v451, i64 1
  store i64 %v449, ptr %st286
  %st287 = getelementptr i64, ptr %v451, i64 2
  store i64 %v450, ptr %st287
  %v453.p = getelementptr i64, ptr %v451, i64 1
  %v453 = load i64, ptr %v453.p
  %v454.p = getelementptr i64, ptr %v444, i64 1
  %v454 = load i64, ptr %v454.p
  %v455 = add i64 %v453, %v454
  %v773 = getelementptr i64, ptr @"rt.meta", i64 0
  %v456.p = getelementptr i64, ptr %v773, i64 0
  %v456 = load i64, ptr %v456.p
  %v457.p = getelementptr i64, ptr %v451, i64 0
  %v457 = load i64, ptr %v457.p
  %v458.p = getelementptr i64, ptr %v451, i64 1
  %v458 = load i64, ptr %v458.p
  %v459.p = getelementptr i64, ptr %v451, i64 2
  %v459 = load i64, ptr %v459.p
  %v460 = call ptr @"rt.cat8"(i64 %v457, i64 %v458, i64 %v459, i64 %v456, i64 %v454)
  %v461 = getelementptr i8, ptr %v460, i64 %v453
  %v462.p = getelementptr i64, ptr %v444, i64 0
  %v462 = load i64, ptr %v462.p
  %v463 = inttoptr i64 %v462 to ptr
  call void @"rt.copy8"(ptr %v461, ptr %v463, i64 %v454)
  %v464 = getelementptr i64, ptr %s52, i64 0
  %v465 = ptrtoint ptr %v460 to i64
  %st288 = getelementptr i64, ptr %v464, i64 0
  store i64 %v465, ptr %st288
  %st289 = getelementptr i64, ptr %v464, i64 1
  store i64 %v455, ptr %st289
  %st290 = getelementptr i64, ptr %v464, i64 2
  store i64 %v456, ptr %st290
  %v466 = getelementptr i64, ptr @"str.22", i64 0
  %v467 = add i64 0, 1
  %v468 = add i64 0, 0
  %v469 = getelementptr i64, ptr %s53, i64 0
  %v470 = ptrtoint ptr %v466 to i64
  %st291 = getelementptr i64, ptr %v469, i64 0
  store i64 %v470, ptr %st291
  %st292 = getelementptr i64, ptr %v469, i64 1
  store i64 %v467, ptr %st292
  %st293 = getelementptr i64, ptr %v469, i64 2
  store i64 %v468, ptr %st293
  %v471.p = getelementptr i64, ptr %v464, i64 1
  %v471 = load i64, ptr %v471.p
  %v472.p = getelementptr i64, ptr %v469, i64 1
  %v472 = load i64, ptr %v472.p
  %v473 = add i64 %v471, %v472
  %v774 = getelementptr i64, ptr @"rt.meta", i64 0
  %v474.p = getelementptr i64, ptr %v774, i64 0
  %v474 = load i64, ptr %v474.p
  %v475.p = getelementptr i64, ptr %v464, i64 0
  %v475 = load i64, ptr %v475.p
  %v476.p = getelementptr i64, ptr %v464, i64 1
  %v476 = load i64, ptr %v476.p
  %v477.p = getelementptr i64, ptr %v464, i64 2
  %v477 = load i64, ptr %v477.p
  %v478 = call ptr @"rt.cat8"(i64 %v475, i64 %v476, i64 %v477, i64 %v474, i64 %v472)
  %v479 = getelementptr i8, ptr %v478, i64 %v471
  %v480.p = getelementptr i64, ptr %v469, i64 0
  %v480 = load i64, ptr %v480.p
  %v481 = inttoptr i64 %v480 to ptr
  call void @"rt.copy8"(ptr %v479, ptr %v481, i64 %v472)
  %v482 = getelementptr i64, ptr %s54, i64 0
  %v483 = ptrtoint ptr %v478 to i64
  %st294 = getelementptr i64, ptr %v482, i64 0
  store i64 %v483, ptr %st294
  %st295 = getelementptr i64, ptr %v482, i64 1
  store i64 %v473, ptr %st295
  %st296 = getelementptr i64, ptr %v482, i64 2
  store i64 %v474, ptr %st296
  call void @"rt.print_str"(ptr %v482)
  %v484 = add i64 0, 10
  call void @"rt.print_char"(i64 %v484)
  br label %b71
b71:
  %v485 = add i64 0, 1
  %v486.p = getelementptr i64, ptr %v31, i64 0
  %v486 = load i64, ptr %v486.p
  %v487 = add i64 %v486, %v485
  %st297 = getelementptr i64, ptr %v31, i64 0
  store i64 %v487, ptr %st297
  %v488.p = getelementptr i64, ptr %v398, i64 1
  %v488 = load i64, ptr %v488.p
  %v489.p = getelementptr i64, ptr %v33, i64 0
  %v489 = load i64, ptr %v489.p
  %v490 = add i64 %v489, %v488
  %st298 = getelementptr i64, ptr %v33, i64 0
  store i64 %v490, ptr %st298
  br label %b65
b72:
  %v507.p = getelementptr i64, ptr %v141, i64 0
  %v507 = load i64, ptr %v507.p
  %v508 = add i64 0, 1
  %v509 = add i64 %v507, %v508
  %st299 = getelementptr i64, ptr %v134, i64 0
  store i64 %v509, ptr %st299
  br label %b73
b73:
  br label %b24
b74:
  %v521 = add i64 0, 3
  %v522 = getelementptr i64, ptr %v59, i64 %v521
  %v775 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v522, i64 %v775, i64 %v60)
  br label %b75
b75:
  %v776 = getelementptr i64, ptr @"rt.meta", i64 0
  %st300 = getelementptr i64, ptr %v776, i64 0
  store i64 %v60, ptr %st300
  br label %b9
b76:
  %v532 = add i64 0, 3
  %v533 = getelementptr i64, ptr %v52, i64 %v532
  %v777 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v533, i64 %v777, i64 %v53)
  br label %b77
b77:
  %v778 = getelementptr i64, ptr @"rt.meta", i64 0
  %st301 = getelementptr i64, ptr %v778, i64 0
  store i64 %v53, ptr %st301
  br label %b8
b78:
  %v537 = add i64 0, 0
  %v538.p = getelementptr i64, ptr %v52, i64 0
  %v538 = load i64, ptr %v538.p
  %st302 = getelementptr i64, ptr %v37, i64 0
  store i64 %v538, ptr %st302
  %v539.p = getelementptr i64, ptr %v52, i64 1
  %v539 = load i64, ptr %v539.p
  %st303 = getelementptr i64, ptr %v37, i64 1
  store i64 %v539, ptr %st303
  %v540.p = getelementptr i64, ptr %v52, i64 2
  %v540 = load i64, ptr %v540.p
  %st304 = getelementptr i64, ptr %v37, i64 2
  store i64 %v540, ptr %st304
  %v541.p = getelementptr i64, ptr %v52, i64 3
  %v541 = load i64, ptr %v541.p
  %st305 = getelementptr i64, ptr %v37, i64 3
  store i64 %v541, ptr %st305
  %v542.p = getelementptr i64, ptr %v52, i64 4
  %v542 = load i64, ptr %v542.p
  %st306 = getelementptr i64, ptr %v37, i64 4
  store i64 %v542, ptr %st306
  %v543.p = getelementptr i64, ptr %v52, i64 5
  %v543 = load i64, ptr %v543.p
  %st307 = getelementptr i64, ptr %v37, i64 5
  store i64 %v543, ptr %st307
  %v544.p = getelementptr i64, ptr %v37, i64 0
  %v544 = load i64, ptr %v544.p
  %v545 = add i64 0, 0
  %v546.c = icmp ne i64 %v544, %v545
  %v546 = zext i1 %v546.c to i64
  %c.b78 = icmp ne i64 %v546, 0
  br i1 %c.b78, label %b78.t309, label %b78.e310
b78.t309:
  br label %b80
b78.e310:
  br label %b81
b79:
  br label %b7
b80:
  %v547 = add i64 0, 3
  %v548 = getelementptr i64, ptr %v37, i64 %v547
  %v779 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v548, i64 %v779, i64 %v38)
  br label %b81
b81:
  %v780 = getelementptr i64, ptr @"rt.meta", i64 0
  %st310 = getelementptr i64, ptr %v780, i64 0
  store i64 %v38, ptr %st310
  br label %b6
b82:
  %v552 = getelementptr i64, ptr %s55, i64 0
  %v553 = getelementptr i64, ptr %s56, i64 0
  %v554.p = getelementptr i64, ptr %v45, i64 0
  %v554 = load i64, ptr %v554.p
  %v555.p = getelementptr i64, ptr %v45, i64 1
  %v555 = load i64, ptr %v555.p
  %v556.p = getelementptr i64, ptr %v45, i64 2
  %v556 = load i64, ptr %v556.p
  %v781 = getelementptr i64, ptr @"rt.meta", i64 0
  %v557.p = getelementptr i64, ptr %v781, i64 0
  %v557 = load i64, ptr %v557.p
  %v558 = add i64 0, 0
  %v559 = call ptr @"rt.region_alloc8"(i64 %v557, i64 %v558)
  %v560 = add i64 0, 0
  %v561 = getelementptr i64, ptr %s20, i64 0
  %v562 = ptrtoint ptr %v559 to i64
  %st311 = getelementptr i64, ptr %v561, i64 0
  store i64 %v562, ptr %st311
  %st312 = getelementptr i64, ptr %v561, i64 1
  store i64 %v560, ptr %st312
  %st313 = getelementptr i64, ptr %v561, i64 2
  store i64 %v557, ptr %st313
  %v563.p = getelementptr i64, ptr %v561, i64 0
  %v563 = load i64, ptr %v563.p
  %v564.p = getelementptr i64, ptr %v561, i64 1
  %v564 = load i64, ptr %v564.p
  %v565.p = getelementptr i64, ptr %v561, i64 2
  %v565 = load i64, ptr %v565.p
  call void @"std/io.joined"(ptr %v553, i64 %v554, i64 %v555, i64 %v556, i64 %v563, i64 %v564, i64 %v565)
  %v566.p = getelementptr i64, ptr %v553, i64 0
  %v566 = load i64, ptr %v566.p
  %v567.p = getelementptr i64, ptr %v553, i64 1
  %v567 = load i64, ptr %v567.p
  %v568.p = getelementptr i64, ptr %v553, i64 2
  %v568 = load i64, ptr %v568.p
  call void @"std/io.dropCR"(ptr %v552, i64 %v566, i64 %v567, i64 %v568)
  %v569 = getelementptr i64, ptr %s19, i64 0
  %v570.p = getelementptr i64, ptr %v552, i64 0
  %v570 = load i64, ptr %v570.p
  %st314 = getelementptr i64, ptr %v569, i64 0
  store i64 %v570, ptr %st314
  %v571.p = getelementptr i64, ptr %v552, i64 1
  %v571 = load i64, ptr %v571.p
  %st315 = getelementptr i64, ptr %v569, i64 1
  store i64 %v571, ptr %st315
  %v572.p = getelementptr i64, ptr %v552, i64 2
  %v572 = load i64, ptr %v572.p
  %st316 = getelementptr i64, ptr %v569, i64 2
  store i64 %v572, ptr %st316
  %v573 = getelementptr i64, ptr %s9, i64 0
  %v574 = add i64 0, 0
  %v575 = getelementptr i64, ptr %s11, i64 0
  %v576 = getelementptr i64, ptr %s18, i64 0
  %v577 = add i64 0, 0
  %st317 = getelementptr i64, ptr %v576, i64 0
  store i64 %v577, ptr %st317
  %st318 = getelementptr i64, ptr %v576, i64 1
  store i64 %v577, ptr %st318
  %st319 = getelementptr i64, ptr %v576, i64 2
  store i64 %v577, ptr %st319
  %v578.p = getelementptr i64, ptr %v569, i64 0
  %v578 = load i64, ptr %v578.p
  %st320 = getelementptr i64, ptr %v576, i64 0
  store i64 %v578, ptr %st320
  %v579.p = getelementptr i64, ptr %v569, i64 1
  %v579 = load i64, ptr %v579.p
  %st321 = getelementptr i64, ptr %v576, i64 1
  store i64 %v579, ptr %st321
  %v580.p = getelementptr i64, ptr %v569, i64 2
  %v580 = load i64, ptr %v580.p
  %st322 = getelementptr i64, ptr %v576, i64 2
  store i64 %v580, ptr %st322
  %v581 = getelementptr i64, ptr %s7, i64 0
  %v582.p = getelementptr i64, ptr %v576, i64 0
  %v582 = load i64, ptr %v582.p
  %st323 = getelementptr i64, ptr %v581, i64 0
  store i64 %v582, ptr %st323
  %v583.p = getelementptr i64, ptr %v576, i64 1
  %v583 = load i64, ptr %v583.p
  %st324 = getelementptr i64, ptr %v581, i64 1
  store i64 %v583, ptr %st324
  %v584.p = getelementptr i64, ptr %v576, i64 2
  %v584 = load i64, ptr %v584.p
  %st325 = getelementptr i64, ptr %v581, i64 2
  store i64 %v584, ptr %st325
  %v782 = getelementptr i64, ptr @"rt.meta", i64 0
  %v585.p = getelementptr i64, ptr %v782, i64 0
  %v585 = load i64, ptr %v585.p
  %v586 = getelementptr i64, ptr %s57, i64 0
  %v587.p = getelementptr i64, ptr %v581, i64 0
  %v587 = load i64, ptr %v587.p
  %v588.p = getelementptr i64, ptr %v581, i64 1
  %v588 = load i64, ptr %v588.p
  %v589.p = getelementptr i64, ptr %v581, i64 2
  %v589 = load i64, ptr %v589.p
  call void @"std/io.Raw"(ptr %v586, i64 %v587, i64 %v588, i64 %v589)
  %v590 = getelementptr i64, ptr %s13, i64 0
  %v591.p = getelementptr i64, ptr %v586, i64 0
  %v591 = load i64, ptr %v591.p
  %st326 = getelementptr i64, ptr %v590, i64 0
  store i64 %v591, ptr %st326
  %v592.p = getelementptr i64, ptr %v586, i64 1
  %v592 = load i64, ptr %v592.p
  %st327 = getelementptr i64, ptr %v590, i64 1
  store i64 %v592, ptr %st327
  %v593.p = getelementptr i64, ptr %v586, i64 2
  %v593 = load i64, ptr %v593.p
  %st328 = getelementptr i64, ptr %v590, i64 2
  store i64 %v593, ptr %st328
  %v594.p = getelementptr i64, ptr %v31, i64 0
  %v594 = load i64, ptr %v594.p
  %v595.c = icmp slt i64 %v594, %v4
  %v595 = zext i1 %v595.c to i64
  %c.b82 = icmp ne i64 %v595, 0
  br i1 %c.b82, label %b82.t330, label %b82.e331
b82.t330:
  br label %b85
b82.e331:
  br label %b86
b83:
  br label %b91
b84:
  %v783 = getelementptr i64, ptr @"rt.meta", i64 0
  %st331 = getelementptr i64, ptr %v783, i64 0
  store i64 %v585, ptr %st331
  br label %b91
b85:
  %v784 = getelementptr i64, ptr @"rt.meta", i64 0
  %v596.p = getelementptr i64, ptr %v784, i64 0
  %v596 = load i64, ptr %v596.p
  call void @"rt.region_enter"()
  %v785 = getelementptr i64, ptr @"rt.meta", i64 0
  %v597.p = getelementptr i64, ptr %v785, i64 0
  %v597 = load i64, ptr %v597.p
  %v598 = getelementptr i64, ptr %s58, i64 0
  %v599.p = getelementptr i64, ptr %v590, i64 0
  %v599 = load i64, ptr %v599.p
  %v600.p = getelementptr i64, ptr %v590, i64 1
  %v600 = load i64, ptr %v600.p
  %v601.p = getelementptr i64, ptr %v590, i64 2
  %v601 = load i64, ptr %v601.p
  call void @"std/utf8.Parse"(ptr %v598, i64 %v599, i64 %v600, i64 %v601)
  %v602 = add i64 0, 3
  %v603 = getelementptr i64, ptr %v598, i64 %v602
  %v604 = getelementptr i64, ptr %s32, i64 0
  %v605.p = getelementptr i64, ptr %v598, i64 0
  %v605 = load i64, ptr %v605.p
  %st332 = getelementptr i64, ptr %v604, i64 0
  store i64 %v605, ptr %st332
  %v606.p = getelementptr i64, ptr %v598, i64 1
  %v606 = load i64, ptr %v606.p
  %st333 = getelementptr i64, ptr %v604, i64 1
  store i64 %v606, ptr %st333
  %v607.p = getelementptr i64, ptr %v598, i64 2
  %v607 = load i64, ptr %v607.p
  %st334 = getelementptr i64, ptr %v604, i64 2
  store i64 %v607, ptr %st334
  %v608 = getelementptr i64, ptr %s15, i64 0
  %v609.p = getelementptr i64, ptr %v603, i64 0
  %v609 = load i64, ptr %v609.p
  %st335 = getelementptr i64, ptr %v608, i64 0
  store i64 %v609, ptr %st335
  %v610.p = getelementptr i64, ptr %v603, i64 1
  %v610 = load i64, ptr %v610.p
  %st336 = getelementptr i64, ptr %v608, i64 1
  store i64 %v610, ptr %st336
  %v611.p = getelementptr i64, ptr %v603, i64 2
  %v611 = load i64, ptr %v611.p
  %st337 = getelementptr i64, ptr %v608, i64 2
  store i64 %v611, ptr %st337
  %v612.p = getelementptr i64, ptr %v603, i64 3
  %v612 = load i64, ptr %v612.p
  %st338 = getelementptr i64, ptr %v608, i64 3
  store i64 %v612, ptr %st338
  %v613.p = getelementptr i64, ptr %v603, i64 4
  %v613 = load i64, ptr %v613.p
  %st339 = getelementptr i64, ptr %v608, i64 4
  store i64 %v613, ptr %st339
  %v614.p = getelementptr i64, ptr %v603, i64 5
  %v614 = load i64, ptr %v614.p
  %st340 = getelementptr i64, ptr %v608, i64 5
  store i64 %v614, ptr %st340
  %v615.p = getelementptr i64, ptr %v608, i64 0
  %v615 = load i64, ptr %v615.p
  %v616 = add i64 0, 0
  %v617.c = icmp ne i64 %v615, %v616
  %v617 = zext i1 %v617.c to i64
  %c.b85 = icmp ne i64 %v617, 0
  br i1 %c.b85, label %b85.t342, label %b85.e343
b85.t342:
  br label %b87
b85.e343:
  br label %b88
b86:
  br label %b90
b87:
  %v618 = add i64 0, 1
  %v619 = getelementptr i64, ptr %v608, i64 %v618
  %v620 = getelementptr i64, ptr %s35, i64 0
  %v621.p = getelementptr i64, ptr %v619, i64 0
  %v621 = load i64, ptr %v621.p
  %st343 = getelementptr i64, ptr %v620, i64 0
  store i64 %v621, ptr %st343
  %v622.p = getelementptr i64, ptr %v619, i64 1
  %v622 = load i64, ptr %v622.p
  %st344 = getelementptr i64, ptr %v620, i64 1
  store i64 %v622, ptr %st344
  %v623.p = getelementptr i64, ptr %v619, i64 2
  %v623 = load i64, ptr %v623.p
  %st345 = getelementptr i64, ptr %v620, i64 2
  store i64 %v623, ptr %st345
  %v624.p = getelementptr i64, ptr %v619, i64 3
  %v624 = load i64, ptr %v624.p
  %st346 = getelementptr i64, ptr %v620, i64 3
  store i64 %v624, ptr %st346
  %v625.p = getelementptr i64, ptr %v619, i64 4
  %v625 = load i64, ptr %v625.p
  %st347 = getelementptr i64, ptr %v620, i64 4
  store i64 %v625, ptr %st347
  %v626 = getelementptr i64, ptr @"str.20", i64 0
  %v627 = add i64 0, 1
  %v628 = add i64 0, 0
  %v629 = getelementptr i64, ptr %s30, i64 0
  %v630 = ptrtoint ptr %v626 to i64
  %st348 = getelementptr i64, ptr %v629, i64 0
  store i64 %v630, ptr %st348
  %st349 = getelementptr i64, ptr %v629, i64 1
  store i64 %v627, ptr %st349
  %st350 = getelementptr i64, ptr %v629, i64 2
  store i64 %v628, ptr %st350
  br label %b89
b88:
  br label %b89
b89:
  %v631 = phi ptr [ %v629, %b87 ], [ %v604, %b88 ]
  %v632 = getelementptr i64, ptr %s29, i64 0
  %v633.p = getelementptr i64, ptr %v631, i64 0
  %v633 = load i64, ptr %v633.p
  %st351 = getelementptr i64, ptr %v632, i64 0
  store i64 %v633, ptr %st351
  %v634.p = getelementptr i64, ptr %v631, i64 1
  %v634 = load i64, ptr %v634.p
  %st352 = getelementptr i64, ptr %v632, i64 1
  store i64 %v634, ptr %st352
  %v635.p = getelementptr i64, ptr %v631, i64 2
  %v635 = load i64, ptr %v635.p
  %st353 = getelementptr i64, ptr %v632, i64 2
  store i64 %v635, ptr %st353
  call void @"rt.region_relocate8"(ptr %v632, i64 %v596)
  %v786 = getelementptr i64, ptr @"rt.meta", i64 0
  %st354 = getelementptr i64, ptr %v786, i64 0
  store i64 %v596, ptr %st354
  %v636 = getelementptr i64, ptr %s24, i64 0
  %v637.p = getelementptr i64, ptr %v632, i64 0
  %v637 = load i64, ptr %v637.p
  %st355 = getelementptr i64, ptr %v636, i64 0
  store i64 %v637, ptr %st355
  %v638.p = getelementptr i64, ptr %v632, i64 1
  %v638 = load i64, ptr %v638.p
  %st356 = getelementptr i64, ptr %v636, i64 1
  store i64 %v638, ptr %st356
  %v639.p = getelementptr i64, ptr %v632, i64 2
  %v639 = load i64, ptr %v639.p
  %st357 = getelementptr i64, ptr %v636, i64 2
  store i64 %v639, ptr %st357
  %v640 = getelementptr i64, ptr @"str.21", i64 0
  %v641 = add i64 0, 3
  %v642 = add i64 0, 0
  %v643 = getelementptr i64, ptr %s25, i64 0
  %v644 = ptrtoint ptr %v640 to i64
  %st358 = getelementptr i64, ptr %v643, i64 0
  store i64 %v644, ptr %st358
  %st359 = getelementptr i64, ptr %v643, i64 1
  store i64 %v641, ptr %st359
  %st360 = getelementptr i64, ptr %v643, i64 2
  store i64 %v642, ptr %st360
  %v645.p = getelementptr i64, ptr %v643, i64 1
  %v645 = load i64, ptr %v645.p
  %v646.p = getelementptr i64, ptr %v636, i64 1
  %v646 = load i64, ptr %v646.p
  %v647 = add i64 %v645, %v646
  %v787 = getelementptr i64, ptr @"rt.meta", i64 0
  %v648.p = getelementptr i64, ptr %v787, i64 0
  %v648 = load i64, ptr %v648.p
  %v649.p = getelementptr i64, ptr %v643, i64 0
  %v649 = load i64, ptr %v649.p
  %v650.p = getelementptr i64, ptr %v643, i64 1
  %v650 = load i64, ptr %v650.p
  %v651.p = getelementptr i64, ptr %v643, i64 2
  %v651 = load i64, ptr %v651.p
  %v652 = call ptr @"rt.cat8"(i64 %v649, i64 %v650, i64 %v651, i64 %v648, i64 %v646)
  %v653 = getelementptr i8, ptr %v652, i64 %v645
  %v654.p = getelementptr i64, ptr %v636, i64 0
  %v654 = load i64, ptr %v654.p
  %v655 = inttoptr i64 %v654 to ptr
  call void @"rt.copy8"(ptr %v653, ptr %v655, i64 %v646)
  %v656 = getelementptr i64, ptr %s38, i64 0
  %v657 = ptrtoint ptr %v652 to i64
  %st361 = getelementptr i64, ptr %v656, i64 0
  store i64 %v657, ptr %st361
  %st362 = getelementptr i64, ptr %v656, i64 1
  store i64 %v647, ptr %st362
  %st363 = getelementptr i64, ptr %v656, i64 2
  store i64 %v648, ptr %st363
  %v658 = getelementptr i64, ptr @"str.22", i64 0
  %v659 = add i64 0, 1
  %v660 = add i64 0, 0
  %v661 = getelementptr i64, ptr %s40, i64 0
  %v662 = ptrtoint ptr %v658 to i64
  %st364 = getelementptr i64, ptr %v661, i64 0
  store i64 %v662, ptr %st364
  %st365 = getelementptr i64, ptr %v661, i64 1
  store i64 %v659, ptr %st365
  %st366 = getelementptr i64, ptr %v661, i64 2
  store i64 %v660, ptr %st366
  %v663.p = getelementptr i64, ptr %v656, i64 1
  %v663 = load i64, ptr %v663.p
  %v664.p = getelementptr i64, ptr %v661, i64 1
  %v664 = load i64, ptr %v664.p
  %v665 = add i64 %v663, %v664
  %v788 = getelementptr i64, ptr @"rt.meta", i64 0
  %v666.p = getelementptr i64, ptr %v788, i64 0
  %v666 = load i64, ptr %v666.p
  %v667.p = getelementptr i64, ptr %v656, i64 0
  %v667 = load i64, ptr %v667.p
  %v668.p = getelementptr i64, ptr %v656, i64 1
  %v668 = load i64, ptr %v668.p
  %v669.p = getelementptr i64, ptr %v656, i64 2
  %v669 = load i64, ptr %v669.p
  %v670 = call ptr @"rt.cat8"(i64 %v667, i64 %v668, i64 %v669, i64 %v666, i64 %v664)
  %v671 = getelementptr i8, ptr %v670, i64 %v663
  %v672.p = getelementptr i64, ptr %v661, i64 0
  %v672 = load i64, ptr %v672.p
  %v673 = inttoptr i64 %v672 to ptr
  call void @"rt.copy8"(ptr %v671, ptr %v673, i64 %v664)
  %v674 = getelementptr i64, ptr %s41, i64 0
  %v675 = ptrtoint ptr %v670 to i64
  %st367 = getelementptr i64, ptr %v674, i64 0
  store i64 %v675, ptr %st367
  %st368 = getelementptr i64, ptr %v674, i64 1
  store i64 %v665, ptr %st368
  %st369 = getelementptr i64, ptr %v674, i64 2
  store i64 %v666, ptr %st369
  call void @"rt.print_str"(ptr %v674)
  %v676 = add i64 0, 10
  call void @"rt.print_char"(i64 %v676)
  br label %b90
b90:
  %v677 = add i64 0, 1
  %v678.p = getelementptr i64, ptr %v31, i64 0
  %v678 = load i64, ptr %v678.p
  %v679 = add i64 %v678, %v677
  %st370 = getelementptr i64, ptr %v31, i64 0
  store i64 %v679, ptr %st370
  %v680.p = getelementptr i64, ptr %v590, i64 1
  %v680 = load i64, ptr %v680.p
  %v681.p = getelementptr i64, ptr %v33, i64 0
  %v681 = load i64, ptr %v681.p
  %v682 = add i64 %v681, %v680
  %st371 = getelementptr i64, ptr %v33, i64 0
  store i64 %v682, ptr %st371
  br label %b84
b91:
  %v683 = getelementptr i64, ptr %s15, i64 0
  %v684 = add i64 0, 0
  %st372 = getelementptr i64, ptr %v683, i64 0
  store i64 %v684, ptr %st372
  %v685.p = getelementptr i64, ptr %v683, i64 0
  %v685 = load i64, ptr %v685.p
  %st373 = getelementptr i64, ptr %v37, i64 0
  store i64 %v685, ptr %st373
  %v686.p = getelementptr i64, ptr %v683, i64 1
  %v686 = load i64, ptr %v686.p
  %st374 = getelementptr i64, ptr %v37, i64 1
  store i64 %v686, ptr %st374
  %v687.p = getelementptr i64, ptr %v683, i64 2
  %v687 = load i64, ptr %v687.p
  %st375 = getelementptr i64, ptr %v37, i64 2
  store i64 %v687, ptr %st375
  %v688.p = getelementptr i64, ptr %v683, i64 3
  %v688 = load i64, ptr %v688.p
  %st376 = getelementptr i64, ptr %v37, i64 3
  store i64 %v688, ptr %st376
  %v689.p = getelementptr i64, ptr %v683, i64 4
  %v689 = load i64, ptr %v689.p
  %st377 = getelementptr i64, ptr %v37, i64 4
  store i64 %v689, ptr %st377
  %v690.p = getelementptr i64, ptr %v683, i64 5
  %v690 = load i64, ptr %v690.p
  %st378 = getelementptr i64, ptr %v37, i64 5
  store i64 %v690, ptr %st378
  %v691.p = getelementptr i64, ptr %v37, i64 0
  %v691 = load i64, ptr %v691.p
  %v692 = add i64 0, 0
  %v693.c = icmp ne i64 %v691, %v692
  %v693 = zext i1 %v693.c to i64
  %c.b91 = icmp ne i64 %v693, 0
  br i1 %c.b91, label %b91.t380, label %b91.e381
b91.t380:
  br label %b92
b91.e381:
  br label %b93
b92:
  %v694 = add i64 0, 3
  %v695 = getelementptr i64, ptr %v37, i64 %v694
  %v789 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v695, i64 %v789, i64 %v38)
  br label %b93
b93:
  %v790 = getelementptr i64, ptr @"rt.meta", i64 0
  %st381 = getelementptr i64, ptr %v790, i64 0
  store i64 %v38, ptr %st381
  br label %b6
b94:
  %v699 = add i64 0, 0
  %st382 = getelementptr i64, ptr %v0, i64 0
  store i64 %v699, ptr %st382
  %st383 = getelementptr i64, ptr %v0, i64 1
  store i64 %v699, ptr %st383
  %v700.p = getelementptr i64, ptr %v37, i64 0
  %v700 = load i64, ptr %v700.p
  %st384 = getelementptr i64, ptr %v0, i64 2
  store i64 %v700, ptr %st384
  %v701.p = getelementptr i64, ptr %v37, i64 1
  %v701 = load i64, ptr %v701.p
  %st385 = getelementptr i64, ptr %v0, i64 3
  store i64 %v701, ptr %st385
  %v702.p = getelementptr i64, ptr %v37, i64 2
  %v702 = load i64, ptr %v702.p
  %st386 = getelementptr i64, ptr %v0, i64 4
  store i64 %v702, ptr %st386
  %v703.p = getelementptr i64, ptr %v37, i64 3
  %v703 = load i64, ptr %v703.p
  %st387 = getelementptr i64, ptr %v0, i64 5
  store i64 %v703, ptr %st387
  %v704.p = getelementptr i64, ptr %v37, i64 4
  %v704 = load i64, ptr %v704.p
  %st388 = getelementptr i64, ptr %v0, i64 6
  store i64 %v704, ptr %st388
  %v705.p = getelementptr i64, ptr %v37, i64 5
  %v705 = load i64, ptr %v705.p
  %st389 = getelementptr i64, ptr %v0, i64 7
  store i64 %v705, ptr %st389
  %v706.p = getelementptr i64, ptr %v28, i64 0
  %v706 = load i64, ptr %v706.p
  call void @"std/io.Close"(i64 %v706)
  %v707.p = getelementptr i64, ptr %v0, i64 2
  %v707 = load i64, ptr %v707.p
  %v708 = add i64 0, 0
  %v709.c = icmp ne i64 %v707, %v708
  %v709 = zext i1 %v709.c to i64
  %c.b94 = icmp ne i64 %v709, 0
  br i1 %c.b94, label %b94.t391, label %b94.e392
b94.t391:
  br label %b96
b94.e392:
  br label %b97
b95:
  br label %b5
b96:
  %v710 = add i64 0, 5
  %v711 = getelementptr i64, ptr %v0, i64 %v710
  %v791 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v711, i64 %v791, i64 %v6)
  br label %b97
b97:
  %v792 = getelementptr i64, ptr @"rt.meta", i64 0
  %st392 = getelementptr i64, ptr %v792, i64 0
  store i64 %v6, ptr %st392
  ret void
b98:
  %v726 = add i64 0, 5
  %v727 = getelementptr i64, ptr %v0, i64 %v726
  %v793 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v727, i64 %v793, i64 %v6)
  br label %b99
b99:
  %v794 = getelementptr i64, ptr @"rt.meta", i64 0
  %st393 = getelementptr i64, ptr %v794, i64 0
  store i64 %v6, ptr %st393
  ret void
}

define internal void @"main.kept"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [1 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
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
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [6 x i64], align 8
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
  %s9.z5 = getelementptr i64, ptr %s9, i64 5
  store i64 0, ptr %s9.z5
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
  %s19 = alloca [9 x i64], align 8
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
  %s19.z6 = getelementptr i64, ptr %s19, i64 6
  store i64 0, ptr %s19.z6
  %s19.z7 = getelementptr i64, ptr %s19, i64 7
  store i64 0, ptr %s19.z7
  %s19.z8 = getelementptr i64, ptr %s19, i64 8
  store i64 0, ptr %s19.z8
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v266, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v4, i64 0
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v4, i64 2
  %v9 = load i64, ptr %v9.p
  call void @"std/io.Open"(ptr %v6, i64 %v7, i64 %v8, i64 %v9)
  %v10 = add i64 0, 1
  %v11 = getelementptr i64, ptr %v6, i64 %v10
  %v12.p = getelementptr i64, ptr %v11, i64 0
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 0
  %v14.c = icmp ne i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v15 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v0, i64 0
  store i64 %v15, ptr %st5
  %v16.p = getelementptr i64, ptr %v11, i64 0
  %v16 = load i64, ptr %v16.p
  %st6 = getelementptr i64, ptr %v0, i64 1
  store i64 %v16, ptr %st6
  %v17.p = getelementptr i64, ptr %v11, i64 1
  %v17 = load i64, ptr %v17.p
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st7
  %v18.p = getelementptr i64, ptr %v11, i64 2
  %v18 = load i64, ptr %v18.p
  %st8 = getelementptr i64, ptr %v0, i64 3
  store i64 %v18, ptr %st8
  %v19.p = getelementptr i64, ptr %v11, i64 3
  %v19 = load i64, ptr %v19.p
  %st9 = getelementptr i64, ptr %v0, i64 4
  store i64 %v19, ptr %st9
  %v20.p = getelementptr i64, ptr %v11, i64 4
  %v20 = load i64, ptr %v20.p
  %st10 = getelementptr i64, ptr %v0, i64 5
  store i64 %v20, ptr %st10
  %v21.p = getelementptr i64, ptr %v11, i64 5
  %v21 = load i64, ptr %v21.p
  %st11 = getelementptr i64, ptr %v0, i64 6
  store i64 %v21, ptr %st11
  %v22.p = getelementptr i64, ptr %v0, i64 1
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 0, 0
  %v24.c = icmp ne i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b1 = icmp ne i64 %v24, 0
  br i1 %c.b1, label %b1.t13, label %b1.e14
b1.t13:
  br label %b3
b1.e14:
  br label %b4
b2:
  %v27 = getelementptr i64, ptr %s2, i64 0
  %v28.p = getelementptr i64, ptr %v6, i64 0
  %v28 = load i64, ptr %v28.p
  %st14 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st14
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v267, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 0, 0
  %v31 = call ptr @"rt.region_alloc8"(i64 %v29, i64 %v30)
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s3, i64 0
  %v34 = ptrtoint ptr %v31 to i64
  %st15 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st15
  %st16 = getelementptr i64, ptr %v33, i64 1
  store i64 %v32, ptr %st16
  %st17 = getelementptr i64, ptr %v33, i64 2
  store i64 %v29, ptr %st17
  %v35 = getelementptr i64, ptr %s4, i64 0
  %v36.p = getelementptr i64, ptr %v33, i64 0
  %v36 = load i64, ptr %v36.p
  %st18 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st18
  %v37.p = getelementptr i64, ptr %v33, i64 1
  %v37 = load i64, ptr %v37.p
  %st19 = getelementptr i64, ptr %v35, i64 1
  store i64 %v37, ptr %st19
  %v38.p = getelementptr i64, ptr %v33, i64 2
  %v38 = load i64, ptr %v38.p
  %st20 = getelementptr i64, ptr %v35, i64 2
  store i64 %v38, ptr %st20
  %v39 = add i64 0, 0
  %v40 = getelementptr i64, ptr %s5, i64 0
  %st21 = getelementptr i64, ptr %v40, i64 0
  store i64 %v39, ptr %st21
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41.p = getelementptr i64, ptr %v268, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = getelementptr i64, ptr %s6, i64 0
  %v43.p = getelementptr i64, ptr %v27, i64 0
  %v43 = load i64, ptr %v43.p
  %st22 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st22
  %v44 = getelementptr i64, ptr %s7, i64 0
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v45.p = getelementptr i64, ptr %v269, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = getelementptr i64, ptr %s8, i64 0
  %v47.p = getelementptr i64, ptr %v42, i64 0
  %v47 = load i64, ptr %v47.p
  %st23 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st23
  %v48 = add i64 0, 1
  %v49 = add i64 0, 0
  %v50 = sub i64 %v49, %v48
  %v51 = getelementptr i64, ptr %s9, i64 0
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %v52.p = getelementptr i64, ptr %v270, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v46, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 65536
  %v55 = add i64 0, 2
  %v56 = call i64 @"rt.chunk_open"(i64 %v53, i64 %v54, i64 %v55, i64 %v50)
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v271, i64 0
  %v57 = load i64, ptr %v57.p
  br label %b8
b3:
  %v25 = add i64 0, 4
  %v26 = getelementptr i64, ptr %v0, i64 %v25
  %v272 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v26, i64 %v272, i64 %v5)
  br label %b4
b4:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v273, i64 0
  store i64 %v5, ptr %st24
  ret void
b5:
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v274, i64 0
  store i64 %v41, ptr %st25
  %v183 = getelementptr i64, ptr %s19, i64 0
  %v184.p = getelementptr i64, ptr %v4, i64 0
  %v184 = load i64, ptr %v184.p
  %v185.p = getelementptr i64, ptr %v4, i64 1
  %v185 = load i64, ptr %v185.p
  %v186.p = getelementptr i64, ptr %v4, i64 2
  %v186 = load i64, ptr %v186.p
  call void @"std/io.ReadFile"(ptr %v183, i64 %v184, i64 %v185, i64 %v186)
  %v187 = add i64 0, 3
  %v188 = getelementptr i64, ptr %v183, i64 %v187
  %v189.p = getelementptr i64, ptr %v188, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = add i64 0, 0
  %v191.c = icmp ne i64 %v189, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b5 = icmp ne i64 %v191, 0
  br i1 %c.b5, label %b5.t27, label %b5.e28
b5.t27:
  br label %b33
b5.e28:
  br label %b34
b6:
  %v167.p = getelementptr i64, ptr %v44, i64 0
  %v167 = load i64, ptr %v167.p
  %v168 = add i64 0, 0
  %v169.c = icmp ne i64 %v167, %v168
  %v169 = zext i1 %v169.c to i64
  %c.b6 = icmp ne i64 %v169, 0
  br i1 %c.b6, label %b6.t29, label %b6.e30
b6.t29:
  br label %b29
b6.e30:
  br label %b30
b7:
  %v156.p = getelementptr i64, ptr %v51, i64 0
  %v156 = load i64, ptr %v156.p
  %st30 = getelementptr i64, ptr %v44, i64 0
  store i64 %v156, ptr %st30
  %v157.p = getelementptr i64, ptr %v51, i64 1
  %v157 = load i64, ptr %v157.p
  %st31 = getelementptr i64, ptr %v44, i64 1
  store i64 %v157, ptr %st31
  %v158.p = getelementptr i64, ptr %v51, i64 2
  %v158 = load i64, ptr %v158.p
  %st32 = getelementptr i64, ptr %v44, i64 2
  store i64 %v158, ptr %st32
  %v159.p = getelementptr i64, ptr %v51, i64 3
  %v159 = load i64, ptr %v159.p
  %st33 = getelementptr i64, ptr %v44, i64 3
  store i64 %v159, ptr %st33
  %v160.p = getelementptr i64, ptr %v51, i64 4
  %v160 = load i64, ptr %v160.p
  %st34 = getelementptr i64, ptr %v44, i64 4
  store i64 %v160, ptr %st34
  %v161.p = getelementptr i64, ptr %v51, i64 5
  %v161 = load i64, ptr %v161.p
  %st35 = getelementptr i64, ptr %v44, i64 5
  store i64 %v161, ptr %st35
  %v162.p = getelementptr i64, ptr %v44, i64 0
  %v162 = load i64, ptr %v162.p
  %v163 = add i64 0, 0
  %v164.c = icmp ne i64 %v162, %v163
  %v164 = zext i1 %v164.c to i64
  %c.b7 = icmp ne i64 %v164, 0
  br i1 %c.b7, label %b7.t37, label %b7.e38
b7.t37:
  br label %b27
b7.e38:
  br label %b28
b8:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v275, i64 0
  store i64 %v57, ptr %st38
  %v58 = add i64 0, 1
  %c.b8 = icmp ne i64 %v58, 0
  br i1 %c.b8, label %b8.t40, label %b8.e41
b8.t40:
  br label %b9
b8.e41:
  br label %b10
b9:
  call void @"rt.region_enter"()
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %v59.p = getelementptr i64, ptr %v276, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = getelementptr i64, ptr %s3, i64 0
  call void @"rt.chunk_next"(i64 %v56, ptr %v60)
  %v61 = getelementptr i64, ptr %s10, i64 0
  %v62.p = getelementptr i64, ptr %v60, i64 0
  %v62 = load i64, ptr %v62.p
  %st41 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st41
  %v63.p = getelementptr i64, ptr %v60, i64 1
  %v63 = load i64, ptr %v63.p
  %st42 = getelementptr i64, ptr %v61, i64 1
  store i64 %v63, ptr %st42
  %v64.p = getelementptr i64, ptr %v60, i64 2
  %v64 = load i64, ptr %v64.p
  %st43 = getelementptr i64, ptr %v61, i64 2
  store i64 %v64, ptr %st43
  %v65.p = getelementptr i64, ptr %v61, i64 1
  %v65 = load i64, ptr %v65.p
  %v66 = add i64 0, 0
  %v67.c = icmp eq i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b9 = icmp ne i64 %v67, 0
  br i1 %c.b9, label %b9.t45, label %b9.e46
b9.t45:
  br label %b11
b9.e46:
  br label %b12
b10:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st46 = getelementptr i64, ptr %v277, i64 0
  store i64 %v57, ptr %st46
  %v143 = getelementptr i64, ptr %s12, i64 0
  %v144 = add i64 0, 0
  %st47 = getelementptr i64, ptr %v143, i64 0
  store i64 %v144, ptr %st47
  %v145.p = getelementptr i64, ptr %v143, i64 0
  %v145 = load i64, ptr %v145.p
  %st48 = getelementptr i64, ptr %v51, i64 0
  store i64 %v145, ptr %st48
  %v146.p = getelementptr i64, ptr %v143, i64 1
  %v146 = load i64, ptr %v146.p
  %st49 = getelementptr i64, ptr %v51, i64 1
  store i64 %v146, ptr %st49
  %v147.p = getelementptr i64, ptr %v143, i64 2
  %v147 = load i64, ptr %v147.p
  %st50 = getelementptr i64, ptr %v51, i64 2
  store i64 %v147, ptr %st50
  %v148.p = getelementptr i64, ptr %v143, i64 3
  %v148 = load i64, ptr %v148.p
  %st51 = getelementptr i64, ptr %v51, i64 3
  store i64 %v148, ptr %st51
  %v149.p = getelementptr i64, ptr %v143, i64 4
  %v149 = load i64, ptr %v149.p
  %st52 = getelementptr i64, ptr %v51, i64 4
  store i64 %v149, ptr %st52
  %v150.p = getelementptr i64, ptr %v143, i64 5
  %v150 = load i64, ptr %v150.p
  %st53 = getelementptr i64, ptr %v51, i64 5
  store i64 %v150, ptr %st53
  call void @"std/io.chunkEnd"(i64 %v56)
  %v151.p = getelementptr i64, ptr %v51, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = add i64 0, 0
  %v153.c = icmp ne i64 %v151, %v152
  %v153 = zext i1 %v153.c to i64
  %c.b10 = icmp ne i64 %v153, 0
  br i1 %c.b10, label %b10.t55, label %b10.e56
b10.t55:
  br label %b25
b10.e56:
  br label %b26
b11:
  %v68 = getelementptr i64, ptr @"rt.meta", i64 0
  %v69.p = getelementptr i64, ptr %v68, i64 1027
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 0
  %v71.c = icmp ne i64 %v69, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b11 = icmp ne i64 %v71, 0
  br i1 %c.b11, label %b11.t57, label %b11.e58
b11.t57:
  br label %b13
b11.e58:
  br label %b14
b12:
  br label %b20
b13:
  %v72 = getelementptr i64, ptr %s11, i64 0
  call void @"std/io.errOf"(ptr %v72, i64 %v69)
  %v73 = getelementptr i64, ptr %s12, i64 0
  %v74 = add i64 0, 1
  %st58 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st58
  %v75.p = getelementptr i64, ptr %v72, i64 0
  %v75 = load i64, ptr %v75.p
  %st59 = getelementptr i64, ptr %v73, i64 1
  store i64 %v75, ptr %st59
  %v76.p = getelementptr i64, ptr %v72, i64 1
  %v76 = load i64, ptr %v76.p
  %st60 = getelementptr i64, ptr %v73, i64 2
  store i64 %v76, ptr %st60
  %v77.p = getelementptr i64, ptr %v72, i64 2
  %v77 = load i64, ptr %v77.p
  %st61 = getelementptr i64, ptr %v73, i64 3
  store i64 %v77, ptr %st61
  %v78.p = getelementptr i64, ptr %v72, i64 3
  %v78 = load i64, ptr %v78.p
  %st62 = getelementptr i64, ptr %v73, i64 4
  store i64 %v78, ptr %st62
  %v79.p = getelementptr i64, ptr %v72, i64 4
  %v79 = load i64, ptr %v79.p
  %st63 = getelementptr i64, ptr %v73, i64 5
  store i64 %v79, ptr %st63
  %v80.p = getelementptr i64, ptr %v73, i64 0
  %v80 = load i64, ptr %v80.p
  %st64 = getelementptr i64, ptr %v51, i64 0
  store i64 %v80, ptr %st64
  %v81.p = getelementptr i64, ptr %v73, i64 1
  %v81 = load i64, ptr %v81.p
  %st65 = getelementptr i64, ptr %v51, i64 1
  store i64 %v81, ptr %st65
  %v82.p = getelementptr i64, ptr %v73, i64 2
  %v82 = load i64, ptr %v82.p
  %st66 = getelementptr i64, ptr %v51, i64 2
  store i64 %v82, ptr %st66
  %v83.p = getelementptr i64, ptr %v73, i64 3
  %v83 = load i64, ptr %v83.p
  %st67 = getelementptr i64, ptr %v51, i64 3
  store i64 %v83, ptr %st67
  %v84.p = getelementptr i64, ptr %v73, i64 4
  %v84 = load i64, ptr %v84.p
  %st68 = getelementptr i64, ptr %v51, i64 4
  store i64 %v84, ptr %st68
  %v85.p = getelementptr i64, ptr %v73, i64 5
  %v85 = load i64, ptr %v85.p
  %st69 = getelementptr i64, ptr %v51, i64 5
  store i64 %v85, ptr %st69
  call void @"std/io.chunkEnd"(i64 %v56)
  %v86.p = getelementptr i64, ptr %v51, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 0, 0
  %v88.c = icmp ne i64 %v86, %v87
  %v88 = zext i1 %v88.c to i64
  %c.b13 = icmp ne i64 %v88, 0
  br i1 %c.b13, label %b13.t71, label %b13.e72
b13.t71:
  br label %b15
b13.e72:
  br label %b16
b14:
  br label %b17
b15:
  %v89 = add i64 0, 3
  %v90 = getelementptr i64, ptr %v51, i64 %v89
  %v278 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v90, i64 %v278, i64 %v52)
  br label %b16
b16:
  %v279 = getelementptr i64, ptr @"rt.meta", i64 0
  %st72 = getelementptr i64, ptr %v279, i64 0
  store i64 %v52, ptr %st72
  br label %b7
b17:
  %v91 = getelementptr i64, ptr %s12, i64 0
  %v92 = add i64 0, 0
  %st73 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st73
  %v93.p = getelementptr i64, ptr %v91, i64 0
  %v93 = load i64, ptr %v93.p
  %st74 = getelementptr i64, ptr %v51, i64 0
  store i64 %v93, ptr %st74
  %v94.p = getelementptr i64, ptr %v91, i64 1
  %v94 = load i64, ptr %v94.p
  %st75 = getelementptr i64, ptr %v51, i64 1
  store i64 %v94, ptr %st75
  %v95.p = getelementptr i64, ptr %v91, i64 2
  %v95 = load i64, ptr %v95.p
  %st76 = getelementptr i64, ptr %v51, i64 2
  store i64 %v95, ptr %st76
  %v96.p = getelementptr i64, ptr %v91, i64 3
  %v96 = load i64, ptr %v96.p
  %st77 = getelementptr i64, ptr %v51, i64 3
  store i64 %v96, ptr %st77
  %v97.p = getelementptr i64, ptr %v91, i64 4
  %v97 = load i64, ptr %v97.p
  %st78 = getelementptr i64, ptr %v51, i64 4
  store i64 %v97, ptr %st78
  %v98.p = getelementptr i64, ptr %v91, i64 5
  %v98 = load i64, ptr %v98.p
  %st79 = getelementptr i64, ptr %v51, i64 5
  store i64 %v98, ptr %st79
  call void @"std/io.chunkEnd"(i64 %v56)
  %v99.p = getelementptr i64, ptr %v51, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 0, 0
  %v101.c = icmp ne i64 %v99, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b17 = icmp ne i64 %v101, 0
  br i1 %c.b17, label %b17.t81, label %b17.e82
b17.t81:
  br label %b18
b17.e82:
  br label %b19
b18:
  %v102 = add i64 0, 3
  %v103 = getelementptr i64, ptr %v51, i64 %v102
  %v280 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v103, i64 %v280, i64 %v52)
  br label %b19
b19:
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v281, i64 0
  store i64 %v52, ptr %st82
  br label %b7
b20:
  %v104 = getelementptr i64, ptr %s3, i64 0
  %v105.p = getelementptr i64, ptr %v61, i64 0
  %v105 = load i64, ptr %v105.p
  %st83 = getelementptr i64, ptr %v104, i64 0
  store i64 %v105, ptr %st83
  %v106.p = getelementptr i64, ptr %v61, i64 1
  %v106 = load i64, ptr %v106.p
  %st84 = getelementptr i64, ptr %v104, i64 1
  store i64 %v106, ptr %st84
  %v107.p = getelementptr i64, ptr %v61, i64 2
  %v107 = load i64, ptr %v107.p
  %st85 = getelementptr i64, ptr %v104, i64 2
  store i64 %v107, ptr %st85
  %v108 = getelementptr i64, ptr %s13, i64 0
  %v109 = add i64 0, 0
  %v110 = getelementptr i64, ptr %s14, i64 0
  %v111 = getelementptr i64, ptr %s15, i64 0
  %v112 = add i64 0, 0
  %st86 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st86
  %st87 = getelementptr i64, ptr %v111, i64 1
  store i64 %v112, ptr %st87
  %st88 = getelementptr i64, ptr %v111, i64 2
  store i64 %v112, ptr %st88
  %v113.p = getelementptr i64, ptr %v104, i64 0
  %v113 = load i64, ptr %v113.p
  %st89 = getelementptr i64, ptr %v111, i64 0
  store i64 %v113, ptr %st89
  %v114.p = getelementptr i64, ptr %v104, i64 1
  %v114 = load i64, ptr %v114.p
  %st90 = getelementptr i64, ptr %v111, i64 1
  store i64 %v114, ptr %st90
  %v115.p = getelementptr i64, ptr %v104, i64 2
  %v115 = load i64, ptr %v115.p
  %st91 = getelementptr i64, ptr %v111, i64 2
  store i64 %v115, ptr %st91
  %v116 = getelementptr i64, ptr %s16, i64 0
  %v117.p = getelementptr i64, ptr %v111, i64 0
  %v117 = load i64, ptr %v117.p
  %st92 = getelementptr i64, ptr %v116, i64 0
  store i64 %v117, ptr %st92
  %v118.p = getelementptr i64, ptr %v111, i64 1
  %v118 = load i64, ptr %v118.p
  %st93 = getelementptr i64, ptr %v116, i64 1
  store i64 %v118, ptr %st93
  %v119.p = getelementptr i64, ptr %v111, i64 2
  %v119 = load i64, ptr %v119.p
  %st94 = getelementptr i64, ptr %v116, i64 2
  store i64 %v119, ptr %st94
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %v120.p = getelementptr i64, ptr %v282, i64 0
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v40, i64 0
  %v121 = load i64, ptr %v121.p
  %v122 = add i64 0, 0
  %v123.c = icmp eq i64 %v121, %v122
  %v123 = zext i1 %v123.c to i64
  %c.b20 = icmp ne i64 %v123, 0
  br i1 %c.b20, label %b20.t96, label %b20.e97
b20.t96:
  br label %b22
b20.e97:
  br label %b23
b21:
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v283, i64 0
  store i64 %v120, ptr %st97
  br label %b8
b22:
  %v124 = add i64 0, 1
  %v125 = add i64 %v5, %v124
  %v126 = getelementptr i64, ptr %s17, i64 0
  %v127.p = getelementptr i64, ptr %v116, i64 0
  %v127 = load i64, ptr %v127.p
  %v128.p = getelementptr i64, ptr %v116, i64 1
  %v128 = load i64, ptr %v128.p
  %v129.p = getelementptr i64, ptr %v116, i64 2
  %v129 = load i64, ptr %v129.p
  %v130 = getelementptr i64, ptr @"rt.meta", i64 0
  %st98 = getelementptr i64, ptr %v130, i64 2571
  store i64 %v125, ptr %st98
  call void @"std/io.Raw"(ptr %v126, i64 %v127, i64 %v128, i64 %v129)
  %v131 = getelementptr i64, ptr %s18, i64 0
  %v132.p = getelementptr i64, ptr %v126, i64 0
  %v132 = load i64, ptr %v132.p
  %st99 = getelementptr i64, ptr %v131, i64 0
  store i64 %v132, ptr %st99
  %v133.p = getelementptr i64, ptr %v126, i64 1
  %v133 = load i64, ptr %v133.p
  %st100 = getelementptr i64, ptr %v131, i64 1
  store i64 %v133, ptr %st100
  %v134.p = getelementptr i64, ptr %v126, i64 2
  %v134 = load i64, ptr %v134.p
  %st101 = getelementptr i64, ptr %v131, i64 2
  store i64 %v134, ptr %st101
  %v135 = add i64 0, 1
  %v136 = add i64 %v5, %v135
  call void @"rt.region_relocate8"(ptr %v131, i64 %v136)
  %v137.p = getelementptr i64, ptr %v131, i64 0
  %v137 = load i64, ptr %v137.p
  %st102 = getelementptr i64, ptr %v35, i64 0
  store i64 %v137, ptr %st102
  %v138.p = getelementptr i64, ptr %v131, i64 1
  %v138 = load i64, ptr %v138.p
  %st103 = getelementptr i64, ptr %v35, i64 1
  store i64 %v138, ptr %st103
  %v139.p = getelementptr i64, ptr %v131, i64 2
  %v139 = load i64, ptr %v139.p
  %st104 = getelementptr i64, ptr %v35, i64 2
  store i64 %v139, ptr %st104
  br label %b24
b23:
  br label %b24
b24:
  %v140 = add i64 0, 1
  %v141.p = getelementptr i64, ptr %v40, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 %v141, %v140
  %st105 = getelementptr i64, ptr %v40, i64 0
  store i64 %v142, ptr %st105
  br label %b21
b25:
  %v154 = add i64 0, 3
  %v155 = getelementptr i64, ptr %v51, i64 %v154
  %v284 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v155, i64 %v284, i64 %v52)
  br label %b26
b26:
  %v285 = getelementptr i64, ptr @"rt.meta", i64 0
  %st106 = getelementptr i64, ptr %v285, i64 0
  store i64 %v52, ptr %st106
  br label %b7
b27:
  %v165 = add i64 0, 3
  %v166 = getelementptr i64, ptr %v44, i64 %v165
  %v286 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v166, i64 %v286, i64 %v45)
  br label %b28
b28:
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %st107 = getelementptr i64, ptr %v287, i64 0
  store i64 %v45, ptr %st107
  br label %b6
b29:
  %v170 = add i64 0, 0
  %st108 = getelementptr i64, ptr %v0, i64 0
  store i64 %v170, ptr %st108
  %v171.p = getelementptr i64, ptr %v44, i64 0
  %v171 = load i64, ptr %v171.p
  %st109 = getelementptr i64, ptr %v0, i64 1
  store i64 %v171, ptr %st109
  %v172.p = getelementptr i64, ptr %v44, i64 1
  %v172 = load i64, ptr %v172.p
  %st110 = getelementptr i64, ptr %v0, i64 2
  store i64 %v172, ptr %st110
  %v173.p = getelementptr i64, ptr %v44, i64 2
  %v173 = load i64, ptr %v173.p
  %st111 = getelementptr i64, ptr %v0, i64 3
  store i64 %v173, ptr %st111
  %v174.p = getelementptr i64, ptr %v44, i64 3
  %v174 = load i64, ptr %v174.p
  %st112 = getelementptr i64, ptr %v0, i64 4
  store i64 %v174, ptr %st112
  %v175.p = getelementptr i64, ptr %v44, i64 4
  %v175 = load i64, ptr %v175.p
  %st113 = getelementptr i64, ptr %v0, i64 5
  store i64 %v175, ptr %st113
  %v176.p = getelementptr i64, ptr %v44, i64 5
  %v176 = load i64, ptr %v176.p
  %st114 = getelementptr i64, ptr %v0, i64 6
  store i64 %v176, ptr %st114
  %v177.p = getelementptr i64, ptr %v27, i64 0
  %v177 = load i64, ptr %v177.p
  call void @"std/io.Close"(i64 %v177)
  %v178.p = getelementptr i64, ptr %v0, i64 1
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 0
  %v180.c = icmp ne i64 %v178, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b29 = icmp ne i64 %v180, 0
  br i1 %c.b29, label %b29.t116, label %b29.e117
b29.t116:
  br label %b31
b29.e117:
  br label %b32
b30:
  br label %b5
b31:
  %v181 = add i64 0, 4
  %v182 = getelementptr i64, ptr %v0, i64 %v181
  %v288 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v182, i64 %v288, i64 %v5)
  br label %b32
b32:
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v289, i64 0
  store i64 %v5, ptr %st117
  ret void
b33:
  %v192 = add i64 0, 0
  %st118 = getelementptr i64, ptr %v0, i64 0
  store i64 %v192, ptr %st118
  %v193.p = getelementptr i64, ptr %v188, i64 0
  %v193 = load i64, ptr %v193.p
  %st119 = getelementptr i64, ptr %v0, i64 1
  store i64 %v193, ptr %st119
  %v194.p = getelementptr i64, ptr %v188, i64 1
  %v194 = load i64, ptr %v194.p
  %st120 = getelementptr i64, ptr %v0, i64 2
  store i64 %v194, ptr %st120
  %v195.p = getelementptr i64, ptr %v188, i64 2
  %v195 = load i64, ptr %v195.p
  %st121 = getelementptr i64, ptr %v0, i64 3
  store i64 %v195, ptr %st121
  %v196.p = getelementptr i64, ptr %v188, i64 3
  %v196 = load i64, ptr %v196.p
  %st122 = getelementptr i64, ptr %v0, i64 4
  store i64 %v196, ptr %st122
  %v197.p = getelementptr i64, ptr %v188, i64 4
  %v197 = load i64, ptr %v197.p
  %st123 = getelementptr i64, ptr %v0, i64 5
  store i64 %v197, ptr %st123
  %v198.p = getelementptr i64, ptr %v188, i64 5
  %v198 = load i64, ptr %v198.p
  %st124 = getelementptr i64, ptr %v0, i64 6
  store i64 %v198, ptr %st124
  %v199.p = getelementptr i64, ptr %v27, i64 0
  %v199 = load i64, ptr %v199.p
  call void @"std/io.Close"(i64 %v199)
  %v200.p = getelementptr i64, ptr %v0, i64 1
  %v200 = load i64, ptr %v200.p
  %v201 = add i64 0, 0
  %v202.c = icmp ne i64 %v200, %v201
  %v202 = zext i1 %v202.c to i64
  %c.b33 = icmp ne i64 %v202, 0
  br i1 %c.b33, label %b33.t126, label %b33.e127
b33.t126:
  br label %b35
b33.e127:
  br label %b36
b34:
  %v205 = getelementptr i64, ptr %s16, i64 0
  %v206.p = getelementptr i64, ptr %v183, i64 0
  %v206 = load i64, ptr %v206.p
  %st127 = getelementptr i64, ptr %v205, i64 0
  store i64 %v206, ptr %st127
  %v207.p = getelementptr i64, ptr %v183, i64 1
  %v207 = load i64, ptr %v207.p
  %st128 = getelementptr i64, ptr %v205, i64 1
  store i64 %v207, ptr %st128
  %v208.p = getelementptr i64, ptr %v183, i64 2
  %v208 = load i64, ptr %v208.p
  %st129 = getelementptr i64, ptr %v205, i64 2
  store i64 %v208, ptr %st129
  %v209.p = getelementptr i64, ptr %v40, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = add i64 0, 2
  %v211.c = icmp sgt i64 %v209, %v210
  %v211 = zext i1 %v211.c to i64
  %c.b34 = icmp ne i64 %v211, 0
  br i1 %c.b34, label %b34.t131, label %b34.e132
b34.t131:
  br label %b37
b34.e132:
  br label %b38
b35:
  %v203 = add i64 0, 4
  %v204 = getelementptr i64, ptr %v0, i64 %v203
  %v290 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v204, i64 %v290, i64 %v5)
  br label %b36
b36:
  %v291 = getelementptr i64, ptr @"rt.meta", i64 0
  %st132 = getelementptr i64, ptr %v291, i64 0
  store i64 %v5, ptr %st132
  ret void
b37:
  %v213.p = getelementptr i64, ptr %v35, i64 1
  %v213 = load i64, ptr %v213.p
  %v214 = add i64 0, 65536
  %v215.c = icmp eq i64 %v213, %v214
  %v215 = zext i1 %v215.c to i64
  br label %b38
b38:
  %v212 = phi i64 [ %v211, %b34.e132 ], [ %v215, %b37 ]
  %v216 = getelementptr i64, ptr %s6, i64 0
  %st133 = getelementptr i64, ptr %v216, i64 0
  store i64 %v212, ptr %st133
  %v292 = getelementptr i64, ptr @"rt.meta", i64 0
  %v217.p = getelementptr i64, ptr %v292, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = add i64 0, 0
  %v219.p = getelementptr i64, ptr %v35, i64 1
  %v219 = load i64, ptr %v219.p
  %v220 = getelementptr i64, ptr %s8, i64 0
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %v221.p = getelementptr i64, ptr %v293, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = getelementptr i64, ptr %s14, i64 0
  %st134 = getelementptr i64, ptr %v222, i64 0
  store i64 %v218, ptr %st134
  %v294 = getelementptr i64, ptr @"rt.meta", i64 0
  %v223.p = getelementptr i64, ptr %v294, i64 0
  %v223 = load i64, ptr %v223.p
  br label %b41
b39:
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %st135 = getelementptr i64, ptr %v295, i64 0
  store i64 %v217, ptr %st135
  %v251.p = getelementptr i64, ptr %v216, i64 0
  %v251 = load i64, ptr %v251.p
  %v252 = getelementptr i64, ptr %s12, i64 0
  %v253 = add i64 0, 0
  %st136 = getelementptr i64, ptr %v252, i64 0
  store i64 %v253, ptr %st136
  %st137 = getelementptr i64, ptr %v0, i64 0
  store i64 %v251, ptr %st137
  %v254.p = getelementptr i64, ptr %v252, i64 0
  %v254 = load i64, ptr %v254.p
  %st138 = getelementptr i64, ptr %v0, i64 1
  store i64 %v254, ptr %st138
  %v255.p = getelementptr i64, ptr %v252, i64 1
  %v255 = load i64, ptr %v255.p
  %st139 = getelementptr i64, ptr %v0, i64 2
  store i64 %v255, ptr %st139
  %v256.p = getelementptr i64, ptr %v252, i64 2
  %v256 = load i64, ptr %v256.p
  %st140 = getelementptr i64, ptr %v0, i64 3
  store i64 %v256, ptr %st140
  %v257.p = getelementptr i64, ptr %v252, i64 3
  %v257 = load i64, ptr %v257.p
  %st141 = getelementptr i64, ptr %v0, i64 4
  store i64 %v257, ptr %st141
  %v258.p = getelementptr i64, ptr %v252, i64 4
  %v258 = load i64, ptr %v258.p
  %st142 = getelementptr i64, ptr %v0, i64 5
  store i64 %v258, ptr %st142
  %v259.p = getelementptr i64, ptr %v252, i64 5
  %v259 = load i64, ptr %v259.p
  %st143 = getelementptr i64, ptr %v0, i64 6
  store i64 %v259, ptr %st143
  %v260.p = getelementptr i64, ptr %v27, i64 0
  %v260 = load i64, ptr %v260.p
  call void @"std/io.Close"(i64 %v260)
  %v261.p = getelementptr i64, ptr %v0, i64 1
  %v261 = load i64, ptr %v261.p
  %v262 = add i64 0, 0
  %v263.c = icmp ne i64 %v261, %v262
  %v263 = zext i1 %v263.c to i64
  %c.b39 = icmp ne i64 %v263, 0
  br i1 %c.b39, label %b39.t145, label %b39.e146
b39.t145:
  br label %b51
b39.e146:
  br label %b52
b40:
  br label %b39
b41:
  %v296 = getelementptr i64, ptr @"rt.meta", i64 0
  %st146 = getelementptr i64, ptr %v296, i64 0
  store i64 %v223, ptr %st146
  %v224.p = getelementptr i64, ptr %v222, i64 0
  %v224 = load i64, ptr %v224.p
  %v225.c = icmp slt i64 %v224, %v219
  %v225 = zext i1 %v225.c to i64
  %c.b41 = icmp ne i64 %v225, 0
  br i1 %c.b41, label %b41.t148, label %b41.e149
b41.t148:
  br label %b42
b41.e149:
  br label %b43
b42:
  call void @"rt.region_enter"()
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %v226.p = getelementptr i64, ptr %v297, i64 0
  %v226 = load i64, ptr %v226.p
  %v227.p = getelementptr i64, ptr %v222, i64 0
  %v227 = load i64, ptr %v227.p
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %v228.p = getelementptr i64, ptr %v298, i64 0
  %v228 = load i64, ptr %v228.p
  %v229 = add i64 0, 1
  %v230 = add i64 %v5, %v229
  %v231.p = getelementptr i64, ptr %v216, i64 0
  %v231 = load i64, ptr %v231.p
  %c.b42 = icmp ne i64 %v231, 0
  br i1 %c.b42, label %b42.t150, label %b42.e151
b42.t150:
  br label %b45
b42.e151:
  br label %b46
b43:
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %st151 = getelementptr i64, ptr %v299, i64 0
  store i64 %v223, ptr %st151
  br label %b40
b44:
  %v300 = getelementptr i64, ptr @"rt.meta", i64 0
  %st152 = getelementptr i64, ptr %v300, i64 0
  store i64 %v228, ptr %st152
  %v248 = add i64 0, 1
  %v249.p = getelementptr i64, ptr %v222, i64 0
  %v249 = load i64, ptr %v249.p
  %v250 = add i64 %v249, %v248
  %st153 = getelementptr i64, ptr %v222, i64 0
  store i64 %v250, ptr %st153
  br label %b41
b45:
  %v233.p = getelementptr i64, ptr %v35, i64 1
  %v233 = load i64, ptr %v233.p
  %v234.c = icmp uge i64 %v227, %v233
  %v234 = zext i1 %v234.c to i64
  %c.b45 = icmp ne i64 %v234, 0
  br i1 %c.b45, label %b45.t155, label %b45.e156
b45.t155:
  br label %b47
b45.e156:
  br label %b48
b46:
  %v232 = phi i64 [ %v231, %b42.e151 ], [ %v247, %b50 ]
  %st156 = getelementptr i64, ptr %v216, i64 0
  store i64 %v232, ptr %st156
  br label %b44
b47:
  %v235 = add i64 0, 2
  call void @"rt.panic"(i64 %v235)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b48:
  %v236.p = getelementptr i64, ptr %v35, i64 0
  %v236 = load i64, ptr %v236.p
  %v237 = inttoptr i64 %v236 to ptr
  %v238 = getelementptr i8, ptr %v237, i64 %v227
  %v239.p = getelementptr i8, ptr %v238, i64 0
  %v239.b = load i8, ptr %v239.p
  %v239 = zext i8 %v239.b to i64
  %v240.p = getelementptr i64, ptr %v205, i64 1
  %v240 = load i64, ptr %v240.p
  %v241.c = icmp uge i64 %v227, %v240
  %v241 = zext i1 %v241.c to i64
  %c.b48 = icmp ne i64 %v241, 0
  br i1 %c.b48, label %b48.t158, label %b48.e159
b48.t158:
  br label %b49
b48.e159:
  br label %b50
b49:
  %v242 = add i64 0, 3
  call void @"rt.panic"(i64 %v242)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b50:
  %v243.p = getelementptr i64, ptr %v205, i64 0
  %v243 = load i64, ptr %v243.p
  %v244 = inttoptr i64 %v243 to ptr
  %v245 = getelementptr i8, ptr %v244, i64 %v227
  %v246.p = getelementptr i8, ptr %v245, i64 0
  %v246.b = load i8, ptr %v246.p
  %v246 = zext i8 %v246.b to i64
  %v247.c = icmp eq i64 %v239, %v246
  %v247 = zext i1 %v247.c to i64
  br label %b46
b51:
  %v264 = add i64 0, 4
  %v265 = getelementptr i64, ptr %v0, i64 %v264
  %v301 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v265, i64 %v301, i64 %v5)
  br label %b52
b52:
  %v302 = getelementptr i64, ptr @"rt.meta", i64 0
  %st159 = getelementptr i64, ptr %v302, i64 0
  store i64 %v5, ptr %st159
  ret void
}

define internal void @"main.early"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
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
  %s6 = alloca [1 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
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
  %s10 = alloca [5 x i64], align 8
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
  %s12 = alloca [1 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s13 = alloca [1 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
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
  %s17 = alloca [2 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s17.z1 = getelementptr i64, ptr %s17, i64 1
  store i64 0, ptr %s17.z1
  %s18 = alloca [5 x i64], align 8
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
  %s19 = alloca [9 x i64], align 8
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
  %s19.z6 = getelementptr i64, ptr %s19, i64 6
  store i64 0, ptr %s19.z6
  %s19.z7 = getelementptr i64, ptr %s19, i64 7
  store i64 0, ptr %s19.z7
  %s19.z8 = getelementptr i64, ptr %s19, i64 8
  store i64 0, ptr %s19.z8
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v253 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v253, i64 0
  %v6 = load i64, ptr %v6.p
  call void @"rt.region_enter"()
  %v7 = getelementptr i64, ptr %s1, i64 0
  %v8.p = getelementptr i64, ptr %v5, i64 0
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v5, i64 1
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v5, i64 2
  %v10 = load i64, ptr %v10.p
  call void @"std/io.Open"(ptr %v7, i64 %v8, i64 %v9, i64 %v10)
  %v11 = add i64 0, 1
  %v12 = getelementptr i64, ptr %v7, i64 %v11
  %v13.p = getelementptr i64, ptr %v12, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15.c = icmp ne i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b0 = icmp ne i64 %v15, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v16 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v0, i64 0
  store i64 %v16, ptr %st5
  %v17.p = getelementptr i64, ptr %v12, i64 0
  %v17 = load i64, ptr %v17.p
  %st6 = getelementptr i64, ptr %v0, i64 1
  store i64 %v17, ptr %st6
  %v18.p = getelementptr i64, ptr %v12, i64 1
  %v18 = load i64, ptr %v18.p
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v18, ptr %st7
  %v19.p = getelementptr i64, ptr %v12, i64 2
  %v19 = load i64, ptr %v19.p
  %st8 = getelementptr i64, ptr %v0, i64 3
  store i64 %v19, ptr %st8
  %v20.p = getelementptr i64, ptr %v12, i64 3
  %v20 = load i64, ptr %v20.p
  %st9 = getelementptr i64, ptr %v0, i64 4
  store i64 %v20, ptr %st9
  %v21.p = getelementptr i64, ptr %v12, i64 4
  %v21 = load i64, ptr %v21.p
  %st10 = getelementptr i64, ptr %v0, i64 5
  store i64 %v21, ptr %st10
  %v22.p = getelementptr i64, ptr %v12, i64 5
  %v22 = load i64, ptr %v22.p
  %st11 = getelementptr i64, ptr %v0, i64 6
  store i64 %v22, ptr %st11
  %v23.p = getelementptr i64, ptr %v0, i64 1
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b1 = icmp ne i64 %v25, 0
  br i1 %c.b1, label %b1.t13, label %b1.e14
b1.t13:
  br label %b3
b1.e14:
  br label %b4
b2:
  %v28 = getelementptr i64, ptr %s2, i64 0
  %v29.p = getelementptr i64, ptr %v7, i64 0
  %v29 = load i64, ptr %v29.p
  %st14 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st14
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s3, i64 0
  %st15 = getelementptr i64, ptr %v31, i64 0
  store i64 %v30, ptr %st15
  %v254 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v254, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34.p = getelementptr i64, ptr %v28, i64 0
  %v34 = load i64, ptr %v34.p
  %st16 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st16
  %v35 = getelementptr i64, ptr %s5, i64 0
  %v255 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v255, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = getelementptr i64, ptr %s6, i64 0
  %v38.p = getelementptr i64, ptr %v33, i64 0
  %v38 = load i64, ptr %v38.p
  %st17 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st17
  %v39 = add i64 0, 1
  %v40 = add i64 0, 0
  %v41 = sub i64 %v40, %v39
  %v42 = getelementptr i64, ptr %s7, i64 0
  %v256 = getelementptr i64, ptr @"rt.meta", i64 0
  %v43.p = getelementptr i64, ptr %v256, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v37, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = add i64 0, 65536
  %v46 = add i64 0, 2
  %v47 = call i64 @"rt.chunk_open"(i64 %v44, i64 %v45, i64 %v46, i64 %v41)
  %v257 = getelementptr i64, ptr @"rt.meta", i64 0
  %v48.p = getelementptr i64, ptr %v257, i64 0
  %v48 = load i64, ptr %v48.p
  br label %b8
b3:
  %v26 = add i64 0, 4
  %v27 = getelementptr i64, ptr %v0, i64 %v26
  %v258 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v27, i64 %v258, i64 %v6)
  br label %b4
b4:
  %v259 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v259, i64 0
  store i64 %v6, ptr %st18
  ret void
b5:
  %v260 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v260, i64 0
  store i64 %v32, ptr %st19
  %v210 = getelementptr i64, ptr %s19, i64 0
  %v211.p = getelementptr i64, ptr %v28, i64 0
  %v211 = load i64, ptr %v211.p
  call void @"std/io.ReadAll"(ptr %v210, i64 %v211)
  %v212 = add i64 0, 3
  %v213 = getelementptr i64, ptr %v210, i64 %v212
  %v214.p = getelementptr i64, ptr %v213, i64 0
  %v214 = load i64, ptr %v214.p
  %v215 = add i64 0, 0
  %v216.c = icmp ne i64 %v214, %v215
  %v216 = zext i1 %v216.c to i64
  %c.b5 = icmp ne i64 %v216, 0
  br i1 %c.b5, label %b5.t21, label %b5.e22
b5.t21:
  br label %b43
b5.e22:
  br label %b44
b6:
  %v194.p = getelementptr i64, ptr %v35, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = add i64 0, 0
  %v196.c = icmp ne i64 %v194, %v195
  %v196 = zext i1 %v196.c to i64
  %c.b6 = icmp ne i64 %v196, 0
  br i1 %c.b6, label %b6.t23, label %b6.e24
b6.t23:
  br label %b39
b6.e24:
  br label %b40
b7:
  %v183.p = getelementptr i64, ptr %v42, i64 0
  %v183 = load i64, ptr %v183.p
  %st24 = getelementptr i64, ptr %v35, i64 0
  store i64 %v183, ptr %st24
  %v184.p = getelementptr i64, ptr %v42, i64 1
  %v184 = load i64, ptr %v184.p
  %st25 = getelementptr i64, ptr %v35, i64 1
  store i64 %v184, ptr %st25
  %v185.p = getelementptr i64, ptr %v42, i64 2
  %v185 = load i64, ptr %v185.p
  %st26 = getelementptr i64, ptr %v35, i64 2
  store i64 %v185, ptr %st26
  %v186.p = getelementptr i64, ptr %v42, i64 3
  %v186 = load i64, ptr %v186.p
  %st27 = getelementptr i64, ptr %v35, i64 3
  store i64 %v186, ptr %st27
  %v187.p = getelementptr i64, ptr %v42, i64 4
  %v187 = load i64, ptr %v187.p
  %st28 = getelementptr i64, ptr %v35, i64 4
  store i64 %v187, ptr %st28
  %v188.p = getelementptr i64, ptr %v42, i64 5
  %v188 = load i64, ptr %v188.p
  %st29 = getelementptr i64, ptr %v35, i64 5
  store i64 %v188, ptr %st29
  %v189.p = getelementptr i64, ptr %v35, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = add i64 0, 0
  %v191.c = icmp ne i64 %v189, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b7 = icmp ne i64 %v191, 0
  br i1 %c.b7, label %b7.t31, label %b7.e32
b7.t31:
  br label %b37
b7.e32:
  br label %b38
b8:
  %v261 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v261, i64 0
  store i64 %v48, ptr %st32
  %v49 = add i64 0, 1
  %c.b8 = icmp ne i64 %v49, 0
  br i1 %c.b8, label %b8.t34, label %b8.e35
b8.t34:
  br label %b9
b8.e35:
  br label %b10
b9:
  call void @"rt.region_enter"()
  %v262 = getelementptr i64, ptr @"rt.meta", i64 0
  %v50.p = getelementptr i64, ptr %v262, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = getelementptr i64, ptr %s8, i64 0
  call void @"rt.chunk_next"(i64 %v47, ptr %v51)
  %v52 = getelementptr i64, ptr %s9, i64 0
  %v53.p = getelementptr i64, ptr %v51, i64 0
  %v53 = load i64, ptr %v53.p
  %st35 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st35
  %v54.p = getelementptr i64, ptr %v51, i64 1
  %v54 = load i64, ptr %v54.p
  %st36 = getelementptr i64, ptr %v52, i64 1
  store i64 %v54, ptr %st36
  %v55.p = getelementptr i64, ptr %v51, i64 2
  %v55 = load i64, ptr %v55.p
  %st37 = getelementptr i64, ptr %v52, i64 2
  store i64 %v55, ptr %st37
  %v56.p = getelementptr i64, ptr %v52, i64 1
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 0
  %v58.c = icmp eq i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b9 = icmp ne i64 %v58, 0
  br i1 %c.b9, label %b9.t39, label %b9.e40
b9.t39:
  br label %b11
b9.e40:
  br label %b12
b10:
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v263, i64 0
  store i64 %v48, ptr %st40
  %v170 = getelementptr i64, ptr %s11, i64 0
  %v171 = add i64 0, 0
  %st41 = getelementptr i64, ptr %v170, i64 0
  store i64 %v171, ptr %st41
  %v172.p = getelementptr i64, ptr %v170, i64 0
  %v172 = load i64, ptr %v172.p
  %st42 = getelementptr i64, ptr %v42, i64 0
  store i64 %v172, ptr %st42
  %v173.p = getelementptr i64, ptr %v170, i64 1
  %v173 = load i64, ptr %v173.p
  %st43 = getelementptr i64, ptr %v42, i64 1
  store i64 %v173, ptr %st43
  %v174.p = getelementptr i64, ptr %v170, i64 2
  %v174 = load i64, ptr %v174.p
  %st44 = getelementptr i64, ptr %v42, i64 2
  store i64 %v174, ptr %st44
  %v175.p = getelementptr i64, ptr %v170, i64 3
  %v175 = load i64, ptr %v175.p
  %st45 = getelementptr i64, ptr %v42, i64 3
  store i64 %v175, ptr %st45
  %v176.p = getelementptr i64, ptr %v170, i64 4
  %v176 = load i64, ptr %v176.p
  %st46 = getelementptr i64, ptr %v42, i64 4
  store i64 %v176, ptr %st46
  %v177.p = getelementptr i64, ptr %v170, i64 5
  %v177 = load i64, ptr %v177.p
  %st47 = getelementptr i64, ptr %v42, i64 5
  store i64 %v177, ptr %st47
  call void @"std/io.chunkEnd"(i64 %v47)
  %v178.p = getelementptr i64, ptr %v42, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 0
  %v180.c = icmp ne i64 %v178, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b10 = icmp ne i64 %v180, 0
  br i1 %c.b10, label %b10.t49, label %b10.e50
b10.t49:
  br label %b35
b10.e50:
  br label %b36
b11:
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v59, i64 1027
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 0
  %v62.c = icmp ne i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b11 = icmp ne i64 %v62, 0
  br i1 %c.b11, label %b11.t51, label %b11.e52
b11.t51:
  br label %b13
b11.e52:
  br label %b14
b12:
  br label %b20
b13:
  %v63 = getelementptr i64, ptr %s10, i64 0
  call void @"std/io.errOf"(ptr %v63, i64 %v60)
  %v64 = getelementptr i64, ptr %s11, i64 0
  %v65 = add i64 0, 1
  %st52 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st52
  %v66.p = getelementptr i64, ptr %v63, i64 0
  %v66 = load i64, ptr %v66.p
  %st53 = getelementptr i64, ptr %v64, i64 1
  store i64 %v66, ptr %st53
  %v67.p = getelementptr i64, ptr %v63, i64 1
  %v67 = load i64, ptr %v67.p
  %st54 = getelementptr i64, ptr %v64, i64 2
  store i64 %v67, ptr %st54
  %v68.p = getelementptr i64, ptr %v63, i64 2
  %v68 = load i64, ptr %v68.p
  %st55 = getelementptr i64, ptr %v64, i64 3
  store i64 %v68, ptr %st55
  %v69.p = getelementptr i64, ptr %v63, i64 3
  %v69 = load i64, ptr %v69.p
  %st56 = getelementptr i64, ptr %v64, i64 4
  store i64 %v69, ptr %st56
  %v70.p = getelementptr i64, ptr %v63, i64 4
  %v70 = load i64, ptr %v70.p
  %st57 = getelementptr i64, ptr %v64, i64 5
  store i64 %v70, ptr %st57
  %v71.p = getelementptr i64, ptr %v64, i64 0
  %v71 = load i64, ptr %v71.p
  %st58 = getelementptr i64, ptr %v42, i64 0
  store i64 %v71, ptr %st58
  %v72.p = getelementptr i64, ptr %v64, i64 1
  %v72 = load i64, ptr %v72.p
  %st59 = getelementptr i64, ptr %v42, i64 1
  store i64 %v72, ptr %st59
  %v73.p = getelementptr i64, ptr %v64, i64 2
  %v73 = load i64, ptr %v73.p
  %st60 = getelementptr i64, ptr %v42, i64 2
  store i64 %v73, ptr %st60
  %v74.p = getelementptr i64, ptr %v64, i64 3
  %v74 = load i64, ptr %v74.p
  %st61 = getelementptr i64, ptr %v42, i64 3
  store i64 %v74, ptr %st61
  %v75.p = getelementptr i64, ptr %v64, i64 4
  %v75 = load i64, ptr %v75.p
  %st62 = getelementptr i64, ptr %v42, i64 4
  store i64 %v75, ptr %st62
  %v76.p = getelementptr i64, ptr %v64, i64 5
  %v76 = load i64, ptr %v76.p
  %st63 = getelementptr i64, ptr %v42, i64 5
  store i64 %v76, ptr %st63
  call void @"std/io.chunkEnd"(i64 %v47)
  %v77.p = getelementptr i64, ptr %v42, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79.c = icmp ne i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b13 = icmp ne i64 %v79, 0
  br i1 %c.b13, label %b13.t65, label %b13.e66
b13.t65:
  br label %b15
b13.e66:
  br label %b16
b14:
  br label %b17
b15:
  %v80 = add i64 0, 3
  %v81 = getelementptr i64, ptr %v42, i64 %v80
  %v264 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v81, i64 %v264, i64 %v43)
  br label %b16
b16:
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %st66 = getelementptr i64, ptr %v265, i64 0
  store i64 %v43, ptr %st66
  br label %b7
b17:
  %v82 = getelementptr i64, ptr %s11, i64 0
  %v83 = add i64 0, 0
  %st67 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st67
  %v84.p = getelementptr i64, ptr %v82, i64 0
  %v84 = load i64, ptr %v84.p
  %st68 = getelementptr i64, ptr %v42, i64 0
  store i64 %v84, ptr %st68
  %v85.p = getelementptr i64, ptr %v82, i64 1
  %v85 = load i64, ptr %v85.p
  %st69 = getelementptr i64, ptr %v42, i64 1
  store i64 %v85, ptr %st69
  %v86.p = getelementptr i64, ptr %v82, i64 2
  %v86 = load i64, ptr %v86.p
  %st70 = getelementptr i64, ptr %v42, i64 2
  store i64 %v86, ptr %st70
  %v87.p = getelementptr i64, ptr %v82, i64 3
  %v87 = load i64, ptr %v87.p
  %st71 = getelementptr i64, ptr %v42, i64 3
  store i64 %v87, ptr %st71
  %v88.p = getelementptr i64, ptr %v82, i64 4
  %v88 = load i64, ptr %v88.p
  %st72 = getelementptr i64, ptr %v42, i64 4
  store i64 %v88, ptr %st72
  %v89.p = getelementptr i64, ptr %v82, i64 5
  %v89 = load i64, ptr %v89.p
  %st73 = getelementptr i64, ptr %v42, i64 5
  store i64 %v89, ptr %st73
  call void @"std/io.chunkEnd"(i64 %v47)
  %v90.p = getelementptr i64, ptr %v42, i64 0
  %v90 = load i64, ptr %v90.p
  %v91 = add i64 0, 0
  %v92.c = icmp ne i64 %v90, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b17 = icmp ne i64 %v92, 0
  br i1 %c.b17, label %b17.t75, label %b17.e76
b17.t75:
  br label %b18
b17.e76:
  br label %b19
b18:
  %v93 = add i64 0, 3
  %v94 = getelementptr i64, ptr %v42, i64 %v93
  %v266 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v94, i64 %v266, i64 %v43)
  br label %b19
b19:
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v267, i64 0
  store i64 %v43, ptr %st76
  br label %b7
b20:
  %v95 = getelementptr i64, ptr %s8, i64 0
  %v96.p = getelementptr i64, ptr %v52, i64 0
  %v96 = load i64, ptr %v96.p
  %st77 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st77
  %v97.p = getelementptr i64, ptr %v52, i64 1
  %v97 = load i64, ptr %v97.p
  %st78 = getelementptr i64, ptr %v95, i64 1
  store i64 %v97, ptr %st78
  %v98.p = getelementptr i64, ptr %v52, i64 2
  %v98 = load i64, ptr %v98.p
  %st79 = getelementptr i64, ptr %v95, i64 2
  store i64 %v98, ptr %st79
  %v99 = getelementptr i64, ptr %s12, i64 0
  %v100 = add i64 0, 0
  %v101 = getelementptr i64, ptr %s13, i64 0
  %v102 = getelementptr i64, ptr %s14, i64 0
  %v103 = add i64 0, 0
  %st80 = getelementptr i64, ptr %v102, i64 0
  store i64 %v103, ptr %st80
  %st81 = getelementptr i64, ptr %v102, i64 1
  store i64 %v103, ptr %st81
  %st82 = getelementptr i64, ptr %v102, i64 2
  store i64 %v103, ptr %st82
  %v104.p = getelementptr i64, ptr %v95, i64 0
  %v104 = load i64, ptr %v104.p
  %st83 = getelementptr i64, ptr %v102, i64 0
  store i64 %v104, ptr %st83
  %v105.p = getelementptr i64, ptr %v95, i64 1
  %v105 = load i64, ptr %v105.p
  %st84 = getelementptr i64, ptr %v102, i64 1
  store i64 %v105, ptr %st84
  %v106.p = getelementptr i64, ptr %v95, i64 2
  %v106 = load i64, ptr %v106.p
  %st85 = getelementptr i64, ptr %v102, i64 2
  store i64 %v106, ptr %st85
  %v107 = getelementptr i64, ptr %s15, i64 0
  %v108.p = getelementptr i64, ptr %v102, i64 0
  %v108 = load i64, ptr %v108.p
  %st86 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st86
  %v109.p = getelementptr i64, ptr %v102, i64 1
  %v109 = load i64, ptr %v109.p
  %st87 = getelementptr i64, ptr %v107, i64 1
  store i64 %v109, ptr %st87
  %v110.p = getelementptr i64, ptr %v102, i64 2
  %v110 = load i64, ptr %v110.p
  %st88 = getelementptr i64, ptr %v107, i64 2
  store i64 %v110, ptr %st88
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v111.p = getelementptr i64, ptr %v268, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 0, 1
  %v113.p = getelementptr i64, ptr %v31, i64 0
  %v113 = load i64, ptr %v113.p
  %v114 = add i64 %v113, %v112
  %st89 = getelementptr i64, ptr %v31, i64 0
  store i64 %v114, ptr %st89
  %v115.p = getelementptr i64, ptr %v31, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 2
  %v117.c = icmp eq i64 %v115, %v116
  %v117 = zext i1 %v117.c to i64
  %c.b20 = icmp ne i64 %v117, 0
  br i1 %c.b20, label %b20.t91, label %b20.e92
b20.t91:
  br label %b22
b20.e92:
  br label %b23
b21:
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v269, i64 0
  store i64 %v111, ptr %st92
  br label %b8
b22:
  %v118 = add i64 0, 0
  %v119.c = icmp eq i64 %v4, %v118
  %v119 = zext i1 %v119.c to i64
  %c.b22 = icmp ne i64 %v119, 0
  br i1 %c.b22, label %b22.t94, label %b22.e95
b22.t94:
  br label %b24
b22.e95:
  br label %b25
b23:
  br label %b34
b24:
  call void @"std/io.chunkEnd"(i64 %v47)
  br label %b5
b25:
  br label %b26
b26:
  %v120 = add i64 0, 1
  %v121.c = icmp eq i64 %v4, %v120
  %v121 = zext i1 %v121.c to i64
  %c.b26 = icmp ne i64 %v121, 0
  br i1 %c.b26, label %b26.t96, label %b26.e97
b26.t96:
  br label %b27
b26.e97:
  br label %b28
b27:
  %v122 = add i64 0, 100
  %v123 = getelementptr i64, ptr %s16, i64 0
  %v124.p = getelementptr i64, ptr %v107, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v107, i64 1
  %v125 = load i64, ptr %v125.p
  %v126.p = getelementptr i64, ptr %v107, i64 2
  %v126 = load i64, ptr %v126.p
  call void @"std/io.Raw"(ptr %v123, i64 %v124, i64 %v125, i64 %v126)
  %v127.p = getelementptr i64, ptr %v123, i64 1
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 %v122, %v127
  %v129 = getelementptr i64, ptr %s11, i64 0
  %v130 = add i64 0, 0
  %st97 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st97
  %st98 = getelementptr i64, ptr %v0, i64 0
  store i64 %v128, ptr %st98
  %v131.p = getelementptr i64, ptr %v129, i64 0
  %v131 = load i64, ptr %v131.p
  %st99 = getelementptr i64, ptr %v0, i64 1
  store i64 %v131, ptr %st99
  %v132.p = getelementptr i64, ptr %v129, i64 1
  %v132 = load i64, ptr %v132.p
  %st100 = getelementptr i64, ptr %v0, i64 2
  store i64 %v132, ptr %st100
  %v133.p = getelementptr i64, ptr %v129, i64 2
  %v133 = load i64, ptr %v133.p
  %st101 = getelementptr i64, ptr %v0, i64 3
  store i64 %v133, ptr %st101
  %v134.p = getelementptr i64, ptr %v129, i64 3
  %v134 = load i64, ptr %v134.p
  %st102 = getelementptr i64, ptr %v0, i64 4
  store i64 %v134, ptr %st102
  %v135.p = getelementptr i64, ptr %v129, i64 4
  %v135 = load i64, ptr %v135.p
  %st103 = getelementptr i64, ptr %v0, i64 5
  store i64 %v135, ptr %st103
  %v136.p = getelementptr i64, ptr %v129, i64 5
  %v136 = load i64, ptr %v136.p
  %st104 = getelementptr i64, ptr %v0, i64 6
  store i64 %v136, ptr %st104
  call void @"std/io.chunkEnd"(i64 %v47)
  %v137.p = getelementptr i64, ptr %v28, i64 0
  %v137 = load i64, ptr %v137.p
  call void @"std/io.Close"(i64 %v137)
  %v138.p = getelementptr i64, ptr %v0, i64 1
  %v138 = load i64, ptr %v138.p
  %v139 = add i64 0, 0
  %v140.c = icmp ne i64 %v138, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b27 = icmp ne i64 %v140, 0
  br i1 %c.b27, label %b27.t106, label %b27.e107
b27.t106:
  br label %b29
b27.e107:
  br label %b30
b28:
  br label %b31
b29:
  %v141 = add i64 0, 4
  %v142 = getelementptr i64, ptr %v0, i64 %v141
  %v270 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v142, i64 %v270, i64 %v6)
  br label %b30
b30:
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %st107 = getelementptr i64, ptr %v271, i64 0
  store i64 %v6, ptr %st107
  ret void
b31:
  %v143 = add i64 0, 0
  %v144 = getelementptr i64, ptr %s17, i64 0
  %v145 = add i64 0, 0
  %st108 = getelementptr i64, ptr %v144, i64 0
  store i64 %v145, ptr %st108
  %st109 = getelementptr i64, ptr %v144, i64 1
  store i64 %v145, ptr %st109
  %v146 = add i64 0, 0
  %st110 = getelementptr i64, ptr %v144, i64 0
  store i64 %v146, ptr %st110
  %v147 = getelementptr i64, ptr %s18, i64 0
  %v148.p = getelementptr i64, ptr %v144, i64 0
  %v148 = load i64, ptr %v148.p
  %st111 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st111
  %v149.p = getelementptr i64, ptr %v144, i64 1
  %v149 = load i64, ptr %v149.p
  %st112 = getelementptr i64, ptr %v147, i64 1
  store i64 %v149, ptr %st112
  %v150 = add i64 0, 0
  %st113 = getelementptr i64, ptr %v147, i64 2
  store i64 %v150, ptr %st113
  %st114 = getelementptr i64, ptr %v147, i64 3
  store i64 %v150, ptr %st114
  %st115 = getelementptr i64, ptr %v147, i64 4
  store i64 %v150, ptr %st115
  %v151 = getelementptr i64, ptr %s11, i64 0
  %v152 = add i64 0, 1
  %st116 = getelementptr i64, ptr %v151, i64 0
  store i64 %v152, ptr %st116
  %v153.p = getelementptr i64, ptr %v147, i64 0
  %v153 = load i64, ptr %v153.p
  %st117 = getelementptr i64, ptr %v151, i64 1
  store i64 %v153, ptr %st117
  %v154.p = getelementptr i64, ptr %v147, i64 1
  %v154 = load i64, ptr %v154.p
  %st118 = getelementptr i64, ptr %v151, i64 2
  store i64 %v154, ptr %st118
  %v155.p = getelementptr i64, ptr %v147, i64 2
  %v155 = load i64, ptr %v155.p
  %st119 = getelementptr i64, ptr %v151, i64 3
  store i64 %v155, ptr %st119
  %v156.p = getelementptr i64, ptr %v147, i64 3
  %v156 = load i64, ptr %v156.p
  %st120 = getelementptr i64, ptr %v151, i64 4
  store i64 %v156, ptr %st120
  %v157.p = getelementptr i64, ptr %v147, i64 4
  %v157 = load i64, ptr %v157.p
  %st121 = getelementptr i64, ptr %v151, i64 5
  store i64 %v157, ptr %st121
  %st122 = getelementptr i64, ptr %v0, i64 0
  store i64 %v143, ptr %st122
  %v158.p = getelementptr i64, ptr %v151, i64 0
  %v158 = load i64, ptr %v158.p
  %st123 = getelementptr i64, ptr %v0, i64 1
  store i64 %v158, ptr %st123
  %v159.p = getelementptr i64, ptr %v151, i64 1
  %v159 = load i64, ptr %v159.p
  %st124 = getelementptr i64, ptr %v0, i64 2
  store i64 %v159, ptr %st124
  %v160.p = getelementptr i64, ptr %v151, i64 2
  %v160 = load i64, ptr %v160.p
  %st125 = getelementptr i64, ptr %v0, i64 3
  store i64 %v160, ptr %st125
  %v161.p = getelementptr i64, ptr %v151, i64 3
  %v161 = load i64, ptr %v161.p
  %st126 = getelementptr i64, ptr %v0, i64 4
  store i64 %v161, ptr %st126
  %v162.p = getelementptr i64, ptr %v151, i64 4
  %v162 = load i64, ptr %v162.p
  %st127 = getelementptr i64, ptr %v0, i64 5
  store i64 %v162, ptr %st127
  %v163.p = getelementptr i64, ptr %v151, i64 5
  %v163 = load i64, ptr %v163.p
  %st128 = getelementptr i64, ptr %v0, i64 6
  store i64 %v163, ptr %st128
  call void @"std/io.chunkEnd"(i64 %v47)
  %v164.p = getelementptr i64, ptr %v28, i64 0
  %v164 = load i64, ptr %v164.p
  call void @"std/io.Close"(i64 %v164)
  %v165.p = getelementptr i64, ptr %v0, i64 1
  %v165 = load i64, ptr %v165.p
  %v166 = add i64 0, 0
  %v167.c = icmp ne i64 %v165, %v166
  %v167 = zext i1 %v167.c to i64
  %c.b31 = icmp ne i64 %v167, 0
  br i1 %c.b31, label %b31.t130, label %b31.e131
b31.t130:
  br label %b32
b31.e131:
  br label %b33
b32:
  %v168 = add i64 0, 4
  %v169 = getelementptr i64, ptr %v0, i64 %v168
  %v272 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v169, i64 %v272, i64 %v6)
  br label %b33
b33:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st131 = getelementptr i64, ptr %v273, i64 0
  store i64 %v6, ptr %st131
  ret void
b34:
  br label %b21
b35:
  %v181 = add i64 0, 3
  %v182 = getelementptr i64, ptr %v42, i64 %v181
  %v274 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v182, i64 %v274, i64 %v43)
  br label %b36
b36:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st132 = getelementptr i64, ptr %v275, i64 0
  store i64 %v43, ptr %st132
  br label %b7
b37:
  %v192 = add i64 0, 3
  %v193 = getelementptr i64, ptr %v35, i64 %v192
  %v276 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v193, i64 %v276, i64 %v36)
  br label %b38
b38:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st133 = getelementptr i64, ptr %v277, i64 0
  store i64 %v36, ptr %st133
  br label %b6
b39:
  %v197 = add i64 0, 0
  %st134 = getelementptr i64, ptr %v0, i64 0
  store i64 %v197, ptr %st134
  %v198.p = getelementptr i64, ptr %v35, i64 0
  %v198 = load i64, ptr %v198.p
  %st135 = getelementptr i64, ptr %v0, i64 1
  store i64 %v198, ptr %st135
  %v199.p = getelementptr i64, ptr %v35, i64 1
  %v199 = load i64, ptr %v199.p
  %st136 = getelementptr i64, ptr %v0, i64 2
  store i64 %v199, ptr %st136
  %v200.p = getelementptr i64, ptr %v35, i64 2
  %v200 = load i64, ptr %v200.p
  %st137 = getelementptr i64, ptr %v0, i64 3
  store i64 %v200, ptr %st137
  %v201.p = getelementptr i64, ptr %v35, i64 3
  %v201 = load i64, ptr %v201.p
  %st138 = getelementptr i64, ptr %v0, i64 4
  store i64 %v201, ptr %st138
  %v202.p = getelementptr i64, ptr %v35, i64 4
  %v202 = load i64, ptr %v202.p
  %st139 = getelementptr i64, ptr %v0, i64 5
  store i64 %v202, ptr %st139
  %v203.p = getelementptr i64, ptr %v35, i64 5
  %v203 = load i64, ptr %v203.p
  %st140 = getelementptr i64, ptr %v0, i64 6
  store i64 %v203, ptr %st140
  %v204.p = getelementptr i64, ptr %v28, i64 0
  %v204 = load i64, ptr %v204.p
  call void @"std/io.Close"(i64 %v204)
  %v205.p = getelementptr i64, ptr %v0, i64 1
  %v205 = load i64, ptr %v205.p
  %v206 = add i64 0, 0
  %v207.c = icmp ne i64 %v205, %v206
  %v207 = zext i1 %v207.c to i64
  %c.b39 = icmp ne i64 %v207, 0
  br i1 %c.b39, label %b39.t142, label %b39.e143
b39.t142:
  br label %b41
b39.e143:
  br label %b42
b40:
  br label %b5
b41:
  %v208 = add i64 0, 4
  %v209 = getelementptr i64, ptr %v0, i64 %v208
  %v278 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v209, i64 %v278, i64 %v6)
  br label %b42
b42:
  %v279 = getelementptr i64, ptr @"rt.meta", i64 0
  %st143 = getelementptr i64, ptr %v279, i64 0
  store i64 %v6, ptr %st143
  ret void
b43:
  %v217 = add i64 0, 0
  %st144 = getelementptr i64, ptr %v0, i64 0
  store i64 %v217, ptr %st144
  %v218.p = getelementptr i64, ptr %v213, i64 0
  %v218 = load i64, ptr %v218.p
  %st145 = getelementptr i64, ptr %v0, i64 1
  store i64 %v218, ptr %st145
  %v219.p = getelementptr i64, ptr %v213, i64 1
  %v219 = load i64, ptr %v219.p
  %st146 = getelementptr i64, ptr %v0, i64 2
  store i64 %v219, ptr %st146
  %v220.p = getelementptr i64, ptr %v213, i64 2
  %v220 = load i64, ptr %v220.p
  %st147 = getelementptr i64, ptr %v0, i64 3
  store i64 %v220, ptr %st147
  %v221.p = getelementptr i64, ptr %v213, i64 3
  %v221 = load i64, ptr %v221.p
  %st148 = getelementptr i64, ptr %v0, i64 4
  store i64 %v221, ptr %st148
  %v222.p = getelementptr i64, ptr %v213, i64 4
  %v222 = load i64, ptr %v222.p
  %st149 = getelementptr i64, ptr %v0, i64 5
  store i64 %v222, ptr %st149
  %v223.p = getelementptr i64, ptr %v213, i64 5
  %v223 = load i64, ptr %v223.p
  %st150 = getelementptr i64, ptr %v0, i64 6
  store i64 %v223, ptr %st150
  %v224.p = getelementptr i64, ptr %v28, i64 0
  %v224 = load i64, ptr %v224.p
  call void @"std/io.Close"(i64 %v224)
  %v225.p = getelementptr i64, ptr %v0, i64 1
  %v225 = load i64, ptr %v225.p
  %v226 = add i64 0, 0
  %v227.c = icmp ne i64 %v225, %v226
  %v227 = zext i1 %v227.c to i64
  %c.b43 = icmp ne i64 %v227, 0
  br i1 %c.b43, label %b43.t152, label %b43.e153
b43.t152:
  br label %b45
b43.e153:
  br label %b46
b44:
  %v230 = getelementptr i64, ptr %s15, i64 0
  %v231.p = getelementptr i64, ptr %v210, i64 0
  %v231 = load i64, ptr %v231.p
  %st153 = getelementptr i64, ptr %v230, i64 0
  store i64 %v231, ptr %st153
  %v232.p = getelementptr i64, ptr %v210, i64 1
  %v232 = load i64, ptr %v232.p
  %st154 = getelementptr i64, ptr %v230, i64 1
  store i64 %v232, ptr %st154
  %v233.p = getelementptr i64, ptr %v210, i64 2
  %v233 = load i64, ptr %v233.p
  %st155 = getelementptr i64, ptr %v230, i64 2
  store i64 %v233, ptr %st155
  %v234.p = getelementptr i64, ptr %v31, i64 0
  %v234 = load i64, ptr %v234.p
  %v235 = add i64 0, 1000000
  %v236 = mul i64 %v234, %v235
  %v237.p = getelementptr i64, ptr %v230, i64 1
  %v237 = load i64, ptr %v237.p
  %v238 = add i64 %v236, %v237
  %v239 = getelementptr i64, ptr %s11, i64 0
  %v240 = add i64 0, 0
  %st156 = getelementptr i64, ptr %v239, i64 0
  store i64 %v240, ptr %st156
  %st157 = getelementptr i64, ptr %v0, i64 0
  store i64 %v238, ptr %st157
  %v241.p = getelementptr i64, ptr %v239, i64 0
  %v241 = load i64, ptr %v241.p
  %st158 = getelementptr i64, ptr %v0, i64 1
  store i64 %v241, ptr %st158
  %v242.p = getelementptr i64, ptr %v239, i64 1
  %v242 = load i64, ptr %v242.p
  %st159 = getelementptr i64, ptr %v0, i64 2
  store i64 %v242, ptr %st159
  %v243.p = getelementptr i64, ptr %v239, i64 2
  %v243 = load i64, ptr %v243.p
  %st160 = getelementptr i64, ptr %v0, i64 3
  store i64 %v243, ptr %st160
  %v244.p = getelementptr i64, ptr %v239, i64 3
  %v244 = load i64, ptr %v244.p
  %st161 = getelementptr i64, ptr %v0, i64 4
  store i64 %v244, ptr %st161
  %v245.p = getelementptr i64, ptr %v239, i64 4
  %v245 = load i64, ptr %v245.p
  %st162 = getelementptr i64, ptr %v0, i64 5
  store i64 %v245, ptr %st162
  %v246.p = getelementptr i64, ptr %v239, i64 5
  %v246 = load i64, ptr %v246.p
  %st163 = getelementptr i64, ptr %v0, i64 6
  store i64 %v246, ptr %st163
  %v247.p = getelementptr i64, ptr %v28, i64 0
  %v247 = load i64, ptr %v247.p
  call void @"std/io.Close"(i64 %v247)
  %v248.p = getelementptr i64, ptr %v0, i64 1
  %v248 = load i64, ptr %v248.p
  %v249 = add i64 0, 0
  %v250.c = icmp ne i64 %v248, %v249
  %v250 = zext i1 %v250.c to i64
  %c.b44 = icmp ne i64 %v250, 0
  br i1 %c.b44, label %b44.t165, label %b44.e166
b44.t165:
  br label %b47
b44.e166:
  br label %b48
b45:
  %v228 = add i64 0, 4
  %v229 = getelementptr i64, ptr %v0, i64 %v228
  %v280 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v229, i64 %v280, i64 %v6)
  br label %b46
b46:
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %st166 = getelementptr i64, ptr %v281, i64 0
  store i64 %v6, ptr %st166
  ret void
b47:
  %v251 = add i64 0, 4
  %v252 = getelementptr i64, ptr %v0, i64 %v251
  %v282 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v252, i64 %v282, i64 %v6)
  br label %b48
b48:
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %st167 = getelementptr i64, ptr %v283, i64 0
  store i64 %v6, ptr %st167
  ret void
}

define internal void @"std/io.Open"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v58, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = call i64 @"rt.open"(ptr %v4)
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
  %v19 = sub i64 %v18, %v6
  call void @"std/io.errOf"(ptr %v17, i64 %v19)
  %v20 = getelementptr i64, ptr %s5, i64 0
  %v21 = add i64 0, 1
  %st7 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st7
  %v22.p = getelementptr i64, ptr %v17, i64 0
  %v22 = load i64, ptr %v22.p
  %st8 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st8
  %v23.p = getelementptr i64, ptr %v17, i64 1
  %v23 = load i64, ptr %v23.p
  %st9 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st9
  %v24.p = getelementptr i64, ptr %v17, i64 2
  %v24 = load i64, ptr %v24.p
  %st10 = getelementptr i64, ptr %v20, i64 3
  store i64 %v24, ptr %st10
  %v25.p = getelementptr i64, ptr %v17, i64 3
  %v25 = load i64, ptr %v25.p
  %st11 = getelementptr i64, ptr %v20, i64 4
  store i64 %v25, ptr %st11
  %v26.p = getelementptr i64, ptr %v17, i64 4
  %v26 = load i64, ptr %v26.p
  %st12 = getelementptr i64, ptr %v20, i64 5
  store i64 %v26, ptr %st12
  %v27.p = getelementptr i64, ptr %v15, i64 0
  %v27 = load i64, ptr %v27.p
  %st13 = getelementptr i64, ptr %v0, i64 0
  store i64 %v27, ptr %st13
  %v28.p = getelementptr i64, ptr %v20, i64 0
  %v28 = load i64, ptr %v28.p
  %st14 = getelementptr i64, ptr %v0, i64 1
  store i64 %v28, ptr %st14
  %v29.p = getelementptr i64, ptr %v20, i64 1
  %v29 = load i64, ptr %v29.p
  %st15 = getelementptr i64, ptr %v0, i64 2
  store i64 %v29, ptr %st15
  %v30.p = getelementptr i64, ptr %v20, i64 2
  %v30 = load i64, ptr %v30.p
  %st16 = getelementptr i64, ptr %v0, i64 3
  store i64 %v30, ptr %st16
  %v31.p = getelementptr i64, ptr %v20, i64 3
  %v31 = load i64, ptr %v31.p
  %st17 = getelementptr i64, ptr %v0, i64 4
  store i64 %v31, ptr %st17
  %v32.p = getelementptr i64, ptr %v20, i64 4
  %v32 = load i64, ptr %v32.p
  %st18 = getelementptr i64, ptr %v0, i64 5
  store i64 %v32, ptr %st18
  %v33.p = getelementptr i64, ptr %v20, i64 5
  %v33 = load i64, ptr %v33.p
  %st19 = getelementptr i64, ptr %v0, i64 6
  store i64 %v33, ptr %st19
  %v34.p = getelementptr i64, ptr %v0, i64 1
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 0
  %v36.c = icmp ne i64 %v34, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b1 = icmp ne i64 %v36, 0
  br i1 %c.b1, label %b1.t21, label %b1.e22
b1.t21:
  br label %b3
b1.e22:
  br label %b4
b2:
  br label %b5
b3:
  %v37 = add i64 0, 4
  %v38 = getelementptr i64, ptr %v0, i64 %v37
  %v59 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v38, i64 %v59, i64 %v5)
  br label %b4
b4:
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v60, i64 0
  store i64 %v5, ptr %st22
  ret void
b5:
  %v39 = getelementptr i64, ptr %s3, i64 0
  %v40 = add i64 0, 0
  %v41 = getelementptr i64, ptr %s2, i64 0
  %v42 = getelementptr i64, ptr %s1, i64 0
  %v43 = add i64 0, 0
  %st23 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st23
  %st24 = getelementptr i64, ptr %v42, i64 0
  store i64 %v6, ptr %st24
  %v44 = getelementptr i64, ptr %s5, i64 0
  %v45 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st25
  %v46.p = getelementptr i64, ptr %v42, i64 0
  %v46 = load i64, ptr %v46.p
  %st26 = getelementptr i64, ptr %v0, i64 0
  store i64 %v46, ptr %st26
  %v47.p = getelementptr i64, ptr %v44, i64 0
  %v47 = load i64, ptr %v47.p
  %st27 = getelementptr i64, ptr %v0, i64 1
  store i64 %v47, ptr %st27
  %v48.p = getelementptr i64, ptr %v44, i64 1
  %v48 = load i64, ptr %v48.p
  %st28 = getelementptr i64, ptr %v0, i64 2
  store i64 %v48, ptr %st28
  %v49.p = getelementptr i64, ptr %v44, i64 2
  %v49 = load i64, ptr %v49.p
  %st29 = getelementptr i64, ptr %v0, i64 3
  store i64 %v49, ptr %st29
  %v50.p = getelementptr i64, ptr %v44, i64 3
  %v50 = load i64, ptr %v50.p
  %st30 = getelementptr i64, ptr %v0, i64 4
  store i64 %v50, ptr %st30
  %v51.p = getelementptr i64, ptr %v44, i64 4
  %v51 = load i64, ptr %v51.p
  %st31 = getelementptr i64, ptr %v0, i64 5
  store i64 %v51, ptr %st31
  %v52.p = getelementptr i64, ptr %v44, i64 5
  %v52 = load i64, ptr %v52.p
  %st32 = getelementptr i64, ptr %v0, i64 6
  store i64 %v52, ptr %st32
  %v53.p = getelementptr i64, ptr %v0, i64 1
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 0
  %v55.c = icmp ne i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b5 = icmp ne i64 %v55, 0
  br i1 %c.b5, label %b5.t34, label %b5.e35
b5.t34:
  br label %b6
b5.e35:
  br label %b7
b6:
  %v56 = add i64 0, 4
  %v57 = getelementptr i64, ptr %v0, i64 %v56
  %v61 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v57, i64 %v61, i64 %v5)
  br label %b7
b7:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v62, i64 0
  store i64 %v5, ptr %st35
  ret void
}

define internal i64 @"rt.chunk_open"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 38
  %v7 = call ptr @"rt.region_alloc"(i64 %v5, i64 %v6)
  %v8 = ptrtoint ptr %v7 to i64
  %v9 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v9, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v1, ptr %st2
  %st3 = getelementptr i64, ptr %v7, i64 3
  store i64 %v2, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 13
  store i64 %v3, ptr %st4
  %v10 = add i64 0, -1
  %st5 = getelementptr i64, ptr %v7, i64 5
  store i64 %v10, ptr %st5
  %st6 = getelementptr i64, ptr %v7, i64 6
  store i64 %v9, ptr %st6
  %st7 = getelementptr i64, ptr %v7, i64 7
  store i64 %v9, ptr %st7
  %st8 = getelementptr i64, ptr %v7, i64 8
  store i64 %v9, ptr %st8
  %st9 = getelementptr i64, ptr %v7, i64 10
  store i64 %v9, ptr %st9
  %st10 = getelementptr i64, ptr %v7, i64 11
  store i64 %v9, ptr %st10
  %st11 = getelementptr i64, ptr %v7, i64 12
  store i64 %v9, ptr %st11
  %v11 = add i64 0, -9223372036854775806
  %st12 = getelementptr i64, ptr %v7, i64 14
  store i64 %v11, ptr %st12
  %st13 = getelementptr i64, ptr %v7, i64 15
  store i64 %v8, ptr %st13
  %v12 = add i64 0, -9223372036854775806
  %st14 = getelementptr i64, ptr %v7, i64 17
  store i64 %v12, ptr %st14
  %st15 = getelementptr i64, ptr %v7, i64 18
  store i64 %v8, ptr %st15
  %v13 = add i64 0, -9223372036854775806
  %st16 = getelementptr i64, ptr %v7, i64 20
  store i64 %v13, ptr %st16
  %st17 = getelementptr i64, ptr %v7, i64 21
  store i64 %v8, ptr %st17
  %v14 = add i64 0, -9223372036854775806
  %st18 = getelementptr i64, ptr %v7, i64 23
  store i64 %v14, ptr %st18
  %st19 = getelementptr i64, ptr %v7, i64 24
  store i64 %v8, ptr %st19
  %v15 = add i64 0, -9223372036854775806
  %st20 = getelementptr i64, ptr %v7, i64 26
  store i64 %v15, ptr %st20
  %st21 = getelementptr i64, ptr %v7, i64 27
  store i64 %v8, ptr %st21
  %v16 = add i64 0, -9223372036854775806
  %st22 = getelementptr i64, ptr %v7, i64 29
  store i64 %v16, ptr %st22
  %st23 = getelementptr i64, ptr %v7, i64 30
  store i64 %v8, ptr %st23
  %v17 = add i64 0, -9223372036854775806
  %st24 = getelementptr i64, ptr %v7, i64 32
  store i64 %v17, ptr %st24
  %st25 = getelementptr i64, ptr %v7, i64 33
  store i64 %v8, ptr %st25
  %v18 = add i64 0, -9223372036854775806
  %st26 = getelementptr i64, ptr %v7, i64 35
  store i64 %v18, ptr %st26
  %st27 = getelementptr i64, ptr %v7, i64 36
  store i64 %v8, ptr %st27
  br label %b1
b1:
  %v19 = add i64 0, 3
  %v20.n = and i64 %v19, 63
  %v20 = ashr i64 %v1, %v20.n
  %v21 = mul i64 %v2, %v20
  %v22 = call ptr @"rt.region_alloc"(i64 %v5, i64 %v21)
  %v23 = ptrtoint ptr %v22 to i64
  br label %b3
b2:
  call void @"rt.chunk_submit"(i64 %v8, i64 %v9)
  %v36 = add i64 0, 1
  %v37 = add i64 %v9, %v36
  %v38.c = icmp eq i64 %v37, %v2
  %v38 = zext i1 %v38.c to i64
  %v39 = mul i64 %v2, %v38
  %v40 = sub i64 %v37, %v39
  %st28 = getelementptr i64, ptr %v7, i64 7
  store i64 %v40, ptr %st28
  ret i64 %v8
b3:
  %v24 = phi i64 [ %v9, %b1 ], [ %v35, %b4 ]
  %v25.c = icmp slt i64 %v24, %v2
  %v25 = zext i1 %v25.c to i64
  %c.b3 = icmp ne i64 %v25, 0
  br i1 %c.b3, label %b3.t30, label %b3.e31
b3.t30:
  br label %b4
b3.e31:
  br label %b2
b4:
  %v26 = add i64 0, 112
  %v27 = add i64 0, 24
  %v28 = mul i64 %v24, %v27
  %v29 = add i64 %v26, %v28
  %v30 = add i64 %v8, %v29
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = mul i64 %v24, %v1
  %v33 = add i64 %v23, %v32
  %st31 = getelementptr i64, ptr %v31, i64 2
  store i64 %v33, ptr %st31
  %v34 = add i64 0, 1
  %v35 = add i64 %v24, %v34
  br label %b3
}

define internal void @"rt.chunk_next"(i64 %v0, ptr %v1) #0 {
b0:
  %v2 = inttoptr i64 %v0 to ptr
  %v3 = add i64 0, 0
  %v4 = add i64 0, -9223372036854775806
  %v5.p = getelementptr i64, ptr %v2, i64 3
  %v5 = load i64, ptr %v5.p
  %v6.p = getelementptr i64, ptr %v2, i64 5
  %v6 = load i64, ptr %v6.p
  %v7.c = icmp sge i64 %v6, %v3
  %v7 = zext i1 %v7.c to i64
  %c.b0 = icmp ne i64 %v7, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v8 = add i64 0, 112
  %v9 = add i64 0, 24
  %v10 = mul i64 %v6, %v9
  %v11 = add i64 %v8, %v10
  %v12 = add i64 %v0, %v11
  %v13 = inttoptr i64 %v12 to ptr
  %st2 = getelementptr i64, ptr %v13, i64 0
  store i64 %v4, ptr %st2
  %v14 = add i64 0, -1
  %st3 = getelementptr i64, ptr %v2, i64 5
  store i64 %v14, ptr %st3
  br label %b2
b2:
  %v15.p = getelementptr i64, ptr %v2, i64 6
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 112
  %v17 = add i64 0, 24
  %v18 = mul i64 %v15, %v17
  %v19 = add i64 %v16, %v18
  %v20 = add i64 %v0, %v19
  %v21 = inttoptr i64 %v20 to ptr
  %v22.p = getelementptr i64, ptr %v21, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp eq i64 %v22, %v4
  %v23 = zext i1 %v23.c to i64
  %c.b2 = icmp ne i64 %v23, 0
  br i1 %c.b2, label %b2.t5, label %b2.e6
b2.t5:
  br label %b5
b2.e6:
  br label %b4
b3:
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %v68.p = getelementptr i64, ptr %v67, i64 0
  %v68 = load i64, ptr %v68.p
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %v75 = getelementptr i64, ptr %v74, i64 %v68
  %v69.p = getelementptr i64, ptr %v75, i64 1
  %v69 = load ptr, ptr %v69.p
  %v70 = ptrtoint ptr %v69 to i64
  %st6 = getelementptr i64, ptr %v1, i64 0
  store i64 %v70, ptr %st6
  %v71 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v1, i64 1
  store i64 %v71, ptr %st7
  %st8 = getelementptr i64, ptr %v1, i64 2
  store i64 %v68, ptr %st8
  %v72.p = getelementptr i64, ptr %v2, i64 12
  %v72 = load i64, ptr %v72.p
  %v73 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v73, i64 1027
  store i64 %v72, ptr %st9
  ret void
b4:
  %v31.p = getelementptr i64, ptr %v21, i64 0
  %v31 = load i64, ptr %v31.p
  %v32.c = icmp sle i64 %v31, %v3
  %v32 = zext i1 %v32.c to i64
  %c.b4 = icmp ne i64 %v32, 0
  br i1 %c.b4, label %b4.t11, label %b4.e12
b4.t11:
  br label %b8
b4.e12:
  br label %b9
b5:
  %v24.p = getelementptr i64, ptr %v2, i64 8
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp ne i64 %v24, %v3
  %v25 = zext i1 %v25.c to i64
  %c.b5 = icmp ne i64 %v25, 0
  br i1 %c.b5, label %b5.t13, label %b5.e14
b5.t13:
  br label %b6
b5.e14:
  br label %b7
b6:
  br label %b3
b7:
  call void @"rt.chunk_submit"(i64 %v0, i64 %v15)
  %v26 = add i64 0, 1
  %v27 = add i64 %v15, %v26
  %v28.c = icmp eq i64 %v27, %v5
  %v28 = zext i1 %v28.c to i64
  %v29 = mul i64 %v5, %v28
  %v30 = sub i64 %v27, %v29
  %st14 = getelementptr i64, ptr %v2, i64 7
  store i64 %v30, ptr %st14
  br label %b4
b8:
  %v33 = add i64 0, 1
  %st15 = getelementptr i64, ptr %v2, i64 8
  store i64 %v33, ptr %st15
  %st16 = getelementptr i64, ptr %v21, i64 0
  store i64 %v4, ptr %st16
  %v34 = sub i64 %v3, %v31
  %st17 = getelementptr i64, ptr %v2, i64 12
  store i64 %v34, ptr %st17
  br label %b3
b9:
  %st18 = getelementptr i64, ptr %v2, i64 5
  store i64 %v15, ptr %st18
  %v35 = add i64 0, 1
  %v36 = add i64 %v15, %v35
  %v37.c = icmp eq i64 %v36, %v5
  %v37 = zext i1 %v37.c to i64
  %v38 = mul i64 %v5, %v37
  %v39 = sub i64 %v36, %v38
  %st19 = getelementptr i64, ptr %v2, i64 6
  store i64 %v39, ptr %st19
  %v40.p = getelementptr i64, ptr %v2, i64 13
  %v40 = load i64, ptr %v40.p
  %v41.c = icmp sge i64 %v40, %v3
  %v41 = zext i1 %v41.c to i64
  %v42 = mul i64 %v31, %v41
  %v43 = add i64 %v40, %v42
  %st20 = getelementptr i64, ptr %v2, i64 13
  store i64 %v43, ptr %st20
  %v44.p = getelementptr i64, ptr %v2, i64 7
  %v44 = load i64, ptr %v44.p
  %v45 = add i64 0, 112
  %v46 = add i64 0, 24
  %v47 = mul i64 %v44, %v46
  %v48 = add i64 %v45, %v47
  %v49 = add i64 %v0, %v48
  %v50 = inttoptr i64 %v49 to ptr
  %v51.p = getelementptr i64, ptr %v50, i64 0
  %v51 = load i64, ptr %v51.p
  %v52.c = icmp eq i64 %v51, %v4
  %v52 = zext i1 %v52.c to i64
  %v53.c = icmp ne i64 %v44, %v15
  %v53 = zext i1 %v53.c to i64
  %v54 = and i64 %v52, %v53
  %v55.p = getelementptr i64, ptr %v2, i64 8
  %v55 = load i64, ptr %v55.p
  %v56.c = icmp eq i64 %v55, %v3
  %v56 = zext i1 %v56.c to i64
  %v57 = and i64 %v54, %v56
  %c.b9 = icmp ne i64 %v57, 0
  br i1 %c.b9, label %b9.t22, label %b9.e23
b9.t22:
  br label %b10
b9.e23:
  br label %b11
b10:
  call void @"rt.chunk_submit"(i64 %v0, i64 %v44)
  %v58 = add i64 0, 1
  %v59 = add i64 %v44, %v58
  %v60.c = icmp eq i64 %v59, %v5
  %v60 = zext i1 %v60.c to i64
  %v61 = mul i64 %v5, %v60
  %v62 = sub i64 %v59, %v61
  %st23 = getelementptr i64, ptr %v2, i64 7
  store i64 %v62, ptr %st23
  br label %b11
b11:
  %v63.p = getelementptr i64, ptr %v21, i64 2
  %v63 = load i64, ptr %v63.p
  %st24 = getelementptr i64, ptr %v1, i64 0
  store i64 %v63, ptr %st24
  %st25 = getelementptr i64, ptr %v1, i64 1
  store i64 %v31, ptr %st25
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v64, i64 0
  %v65 = load i64, ptr %v65.p
  %st26 = getelementptr i64, ptr %v1, i64 2
  store i64 %v65, ptr %st26
  %v66 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v66, i64 1027
  store i64 %v3, ptr %st27
  ret void
}

define internal i64 @"rt.chunk_close"(i64 %v0) #0 {
b0:
  %v1 = inttoptr i64 %v0 to ptr
  %v2 = add i64 0, 0
  %v3.p = getelementptr i64, ptr %v1, i64 5
  %v3 = load i64, ptr %v3.p
  %v4.c = icmp sge i64 %v3, %v2
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = add i64 0, 112
  %v6 = add i64 0, 24
  %v7 = mul i64 %v3, %v6
  %v8 = add i64 %v5, %v7
  %v9 = add i64 %v0, %v8
  %v10 = inttoptr i64 %v9 to ptr
  %v11 = add i64 0, -9223372036854775806
  %st2 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st2
  %v12 = add i64 0, -1
  %st3 = getelementptr i64, ptr %v1, i64 5
  store i64 %v12, ptr %st3
  br label %b2
b2:
  %v13.p = getelementptr i64, ptr %v1, i64 14
  %v13 = load i64, ptr %v13.p
  %v14 = sub i64 %v2, %v13
  %v15.c = icmp sgt i64 %v2, %v13
  %v15 = zext i1 %v15.c to i64
  %v16 = mul i64 %v14, %v15
  %v17 = add i64 %v13, %v16
  %v18 = add i64 %v2, %v17
  %v19.p = getelementptr i64, ptr %v1, i64 17
  %v19 = load i64, ptr %v19.p
  %v20 = sub i64 %v2, %v19
  %v21.c = icmp sgt i64 %v2, %v19
  %v21 = zext i1 %v21.c to i64
  %v22 = mul i64 %v20, %v21
  %v23 = add i64 %v19, %v22
  %v24 = add i64 %v18, %v23
  %v25.p = getelementptr i64, ptr %v1, i64 20
  %v25 = load i64, ptr %v25.p
  %v26 = sub i64 %v2, %v25
  %v27.c = icmp sgt i64 %v2, %v25
  %v27 = zext i1 %v27.c to i64
  %v28 = mul i64 %v26, %v27
  %v29 = add i64 %v25, %v28
  %v30 = add i64 %v24, %v29
  %v31.p = getelementptr i64, ptr %v1, i64 23
  %v31 = load i64, ptr %v31.p
  %v32 = sub i64 %v2, %v31
  %v33.c = icmp sgt i64 %v2, %v31
  %v33 = zext i1 %v33.c to i64
  %v34 = mul i64 %v32, %v33
  %v35 = add i64 %v31, %v34
  %v36 = add i64 %v30, %v35
  %v37.p = getelementptr i64, ptr %v1, i64 26
  %v37 = load i64, ptr %v37.p
  %v38 = sub i64 %v2, %v37
  %v39.c = icmp sgt i64 %v2, %v37
  %v39 = zext i1 %v39.c to i64
  %v40 = mul i64 %v38, %v39
  %v41 = add i64 %v37, %v40
  %v42 = add i64 %v36, %v41
  %v43.p = getelementptr i64, ptr %v1, i64 29
  %v43 = load i64, ptr %v43.p
  %v44 = sub i64 %v2, %v43
  %v45.c = icmp sgt i64 %v2, %v43
  %v45 = zext i1 %v45.c to i64
  %v46 = mul i64 %v44, %v45
  %v47 = add i64 %v43, %v46
  %v48 = add i64 %v42, %v47
  %v49.p = getelementptr i64, ptr %v1, i64 32
  %v49 = load i64, ptr %v49.p
  %v50 = sub i64 %v2, %v49
  %v51.c = icmp sgt i64 %v2, %v49
  %v51 = zext i1 %v51.c to i64
  %v52 = mul i64 %v50, %v51
  %v53 = add i64 %v49, %v52
  %v54 = add i64 %v48, %v53
  %v55.p = getelementptr i64, ptr %v1, i64 35
  %v55 = load i64, ptr %v55.p
  %v56 = sub i64 %v2, %v55
  %v57.c = icmp sgt i64 %v2, %v55
  %v57 = zext i1 %v57.c to i64
  %v58 = mul i64 %v56, %v57
  %v59 = add i64 %v55, %v58
  %v60 = add i64 %v54, %v59
  %v61.c = icmp sgt i64 %v60, %v2
  %v61 = zext i1 %v61.c to i64
  %v62.p = getelementptr i64, ptr %v1, i64 13
  %v62 = load i64, ptr %v62.p
  %v63.c = icmp slt i64 %v62, %v2
  %v63 = zext i1 %v63.c to i64
  %v64 = and i64 %v61, %v63
  %c.b2 = icmp ne i64 %v64, 0
  br i1 %c.b2, label %b2.t5, label %b2.e6
b2.t5:
  br label %b3
b2.e6:
  br label %b4
b3:
  %v65 = add i64 0, 8
  %v66.p = getelementptr i64, ptr %v1, i64 0
  %v66 = load i64, ptr %v66.p
  %v67 = sub i64 %v2, %v60
  %v68 = add i64 0, 1
  %v69 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v65, i64 %v66, i64 %v67, i64 %v68)
  br label %b4
b4:
  ret i64 %v2
}

define internal void @"rt.chunk_submit"(i64 %v0, i64 %v1) #0 {
b0:
  %v2 = inttoptr i64 %v0 to ptr
  %v3 = add i64 0, 112
  %v4 = add i64 0, 24
  %v5 = mul i64 %v1, %v4
  %v6 = add i64 %v3, %v5
  %v7 = add i64 %v0, %v6
  %v8 = inttoptr i64 %v7 to ptr
  %v9.p = getelementptr i64, ptr %v2, i64 2
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v8, i64 2
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v2, i64 0
  %v11 = load i64, ptr %v11.p
  br label %b1
b1:
  %v12.p = getelementptr i64, ptr %v2, i64 13
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 0
  %v14.c = icmp sge i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %v15 = add i64 0, 17
  %v16 = mul i64 %v14, %v15
  br label %b2
b2:
  %v17 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v16, i64 %v11, i64 %v10, i64 %v9, i64 %v12)
  %v18 = add i64 0, -4
  %v19.c = icmp eq i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b2 = icmp ne i64 %v19, 0
  br i1 %c.b2, label %b2.t1, label %b2.e2
b2.t1:
  br label %b3
b2.e2:
  br label %b4
b3:
  br label %b2
b4:
  %st2 = getelementptr i64, ptr %v8, i64 0
  store i64 %v17, ptr %st2
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
  %v10 = add i64 0, 1
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
  %v32 = add i64 0, 2
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
  %v46 = add i64 0, 3
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

define internal void @"std/io.chunkEnd"(i64 %v0) #0 {
b0:
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v3, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = call i64 @"rt.chunk_close"(i64 %v0)
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  ret void
}

define internal void @"std/io.Raw"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v9, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6.p = getelementptr i64, ptr %v4, i64 0
  %v6 = load i64, ptr %v6.p
  %st3 = getelementptr i64, ptr %v0, i64 0
  store i64 %v6, ptr %st3
  %v7.p = getelementptr i64, ptr %v4, i64 1
  %v7 = load i64, ptr %v7.p
  %st4 = getelementptr i64, ptr %v0, i64 1
  store i64 %v7, ptr %st4
  %v8.p = getelementptr i64, ptr %v4, i64 2
  %v8 = load i64, ptr %v8.p
  %st5 = getelementptr i64, ptr %v0, i64 2
  store i64 %v8, ptr %st5
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v5, ptr %st6
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

define internal void @"std/io.ReadAll"(ptr %v0, i64 %v1) #0 {
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
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v1, ptr %st0
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v61, i64 0
  %v3 = load i64, ptr %v3.p
  call void @"rt.region_enter"()
  %v4.p = getelementptr i64, ptr %v2, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 1
  %v6 = add i64 0, 0
  %v7 = sub i64 %v6, %v5
  %v8 = getelementptr i64, ptr %s1, i64 0
  call void @"rt.read_fd"(i64 %v4, i64 %v7, ptr %v8)
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v8, i64 0
  %v10 = load i64, ptr %v10.p
  %st1 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st1
  %v11.p = getelementptr i64, ptr %v8, i64 1
  %v11 = load i64, ptr %v11.p
  %st2 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st2
  %v12.p = getelementptr i64, ptr %v8, i64 2
  %v12 = load i64, ptr %v12.p
  %st3 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st3
  %v13 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v13, i64 1027
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 0, 0
  %v16.c = icmp ne i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v62, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 0
  %v19 = call ptr @"rt.region_alloc8"(i64 %v17, i64 %v18)
  %v20 = add i64 0, 0
  %v21 = getelementptr i64, ptr %s1, i64 0
  %v22 = ptrtoint ptr %v19 to i64
  %st6 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st6
  %st7 = getelementptr i64, ptr %v21, i64 1
  store i64 %v20, ptr %st7
  %st8 = getelementptr i64, ptr %v21, i64 2
  store i64 %v17, ptr %st8
  %v23 = getelementptr i64, ptr %s3, i64 0
  call void @"std/io.errOf"(ptr %v23, i64 %v14)
  %v24 = getelementptr i64, ptr %s4, i64 0
  %v25 = add i64 0, 1
  %st9 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st9
  %v26.p = getelementptr i64, ptr %v23, i64 0
  %v26 = load i64, ptr %v26.p
  %st10 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st10
  %v27.p = getelementptr i64, ptr %v23, i64 1
  %v27 = load i64, ptr %v27.p
  %st11 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st11
  %v28.p = getelementptr i64, ptr %v23, i64 2
  %v28 = load i64, ptr %v28.p
  %st12 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st12
  %v29.p = getelementptr i64, ptr %v23, i64 3
  %v29 = load i64, ptr %v29.p
  %st13 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st13
  %v30.p = getelementptr i64, ptr %v23, i64 4
  %v30 = load i64, ptr %v30.p
  %st14 = getelementptr i64, ptr %v24, i64 5
  store i64 %v30, ptr %st14
  %v31.p = getelementptr i64, ptr %v21, i64 0
  %v31 = load i64, ptr %v31.p
  %st15 = getelementptr i64, ptr %v0, i64 0
  store i64 %v31, ptr %st15
  %v32.p = getelementptr i64, ptr %v21, i64 1
  %v32 = load i64, ptr %v32.p
  %st16 = getelementptr i64, ptr %v0, i64 1
  store i64 %v32, ptr %st16
  %v33.p = getelementptr i64, ptr %v21, i64 2
  %v33 = load i64, ptr %v33.p
  %st17 = getelementptr i64, ptr %v0, i64 2
  store i64 %v33, ptr %st17
  %v34.p = getelementptr i64, ptr %v24, i64 0
  %v34 = load i64, ptr %v34.p
  %st18 = getelementptr i64, ptr %v0, i64 3
  store i64 %v34, ptr %st18
  %v35.p = getelementptr i64, ptr %v24, i64 1
  %v35 = load i64, ptr %v35.p
  %st19 = getelementptr i64, ptr %v0, i64 4
  store i64 %v35, ptr %st19
  %v36.p = getelementptr i64, ptr %v24, i64 2
  %v36 = load i64, ptr %v36.p
  %st20 = getelementptr i64, ptr %v0, i64 5
  store i64 %v36, ptr %st20
  %v37.p = getelementptr i64, ptr %v24, i64 3
  %v37 = load i64, ptr %v37.p
  %st21 = getelementptr i64, ptr %v0, i64 6
  store i64 %v37, ptr %st21
  %v38.p = getelementptr i64, ptr %v24, i64 4
  %v38 = load i64, ptr %v38.p
  %st22 = getelementptr i64, ptr %v0, i64 7
  store i64 %v38, ptr %st22
  %v39.p = getelementptr i64, ptr %v24, i64 5
  %v39 = load i64, ptr %v39.p
  %st23 = getelementptr i64, ptr %v0, i64 8
  store i64 %v39, ptr %st23
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v40.p = getelementptr i64, ptr %v0, i64 3
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 0
  %v42.c = icmp ne i64 %v40, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b1 = icmp ne i64 %v42, 0
  br i1 %c.b1, label %b1.t25, label %b1.e26
b1.t25:
  br label %b3
b1.e26:
  br label %b4
b2:
  br label %b5
b3:
  %v43 = add i64 0, 6
  %v44 = getelementptr i64, ptr %v0, i64 %v43
  %v63 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v44, i64 %v63, i64 %v3)
  br label %b4
b4:
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v64, i64 0
  store i64 %v3, ptr %st26
  ret void
b5:
  %v45 = getelementptr i64, ptr %s4, i64 0
  %v46 = add i64 0, 0
  %st27 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st27
  %v47.p = getelementptr i64, ptr %v9, i64 0
  %v47 = load i64, ptr %v47.p
  %st28 = getelementptr i64, ptr %v0, i64 0
  store i64 %v47, ptr %st28
  %v48.p = getelementptr i64, ptr %v9, i64 1
  %v48 = load i64, ptr %v48.p
  %st29 = getelementptr i64, ptr %v0, i64 1
  store i64 %v48, ptr %st29
  %v49.p = getelementptr i64, ptr %v9, i64 2
  %v49 = load i64, ptr %v49.p
  %st30 = getelementptr i64, ptr %v0, i64 2
  store i64 %v49, ptr %st30
  %v50.p = getelementptr i64, ptr %v45, i64 0
  %v50 = load i64, ptr %v50.p
  %st31 = getelementptr i64, ptr %v0, i64 3
  store i64 %v50, ptr %st31
  %v51.p = getelementptr i64, ptr %v45, i64 1
  %v51 = load i64, ptr %v51.p
  %st32 = getelementptr i64, ptr %v0, i64 4
  store i64 %v51, ptr %st32
  %v52.p = getelementptr i64, ptr %v45, i64 2
  %v52 = load i64, ptr %v52.p
  %st33 = getelementptr i64, ptr %v0, i64 5
  store i64 %v52, ptr %st33
  %v53.p = getelementptr i64, ptr %v45, i64 3
  %v53 = load i64, ptr %v53.p
  %st34 = getelementptr i64, ptr %v0, i64 6
  store i64 %v53, ptr %st34
  %v54.p = getelementptr i64, ptr %v45, i64 4
  %v54 = load i64, ptr %v54.p
  %st35 = getelementptr i64, ptr %v0, i64 7
  store i64 %v54, ptr %st35
  %v55.p = getelementptr i64, ptr %v45, i64 5
  %v55 = load i64, ptr %v55.p
  %st36 = getelementptr i64, ptr %v0, i64 8
  store i64 %v55, ptr %st36
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v56.p = getelementptr i64, ptr %v0, i64 3
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 0
  %v58.c = icmp ne i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b5 = icmp ne i64 %v58, 0
  br i1 %c.b5, label %b5.t38, label %b5.e39
b5.t38:
  br label %b6
b5.e39:
  br label %b7
b6:
  %v59 = add i64 0, 6
  %v60 = getelementptr i64, ptr %v0, i64 %v59
  %v65 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v60, i64 %v65, i64 %v3)
  br label %b7
b7:
  %v66 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v66, i64 0
  store i64 %v3, ptr %st39
  ret void
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

define internal void @"std/io.ReadFile"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v59, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  call void @"rt.read_file"(ptr %v4, ptr %v6)
  %v7 = getelementptr i64, ptr %s2, i64 0
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st3
  %v9.p = getelementptr i64, ptr %v6, i64 1
  %v9 = load i64, ptr %v9.p
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v9, ptr %st4
  %v10.p = getelementptr i64, ptr %v6, i64 2
  %v10 = load i64, ptr %v10.p
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v10, ptr %st5
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v11, i64 1027
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 0
  %v14.c = icmp ne i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v60, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 0
  %v17 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v16)
  %v18 = add i64 0, 0
  %v19 = getelementptr i64, ptr %s1, i64 0
  %v20 = ptrtoint ptr %v17 to i64
  %st8 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st8
  %st9 = getelementptr i64, ptr %v19, i64 1
  store i64 %v18, ptr %st9
  %st10 = getelementptr i64, ptr %v19, i64 2
  store i64 %v15, ptr %st10
  %v21 = getelementptr i64, ptr %s3, i64 0
  call void @"std/io.errOf"(ptr %v21, i64 %v12)
  %v22 = getelementptr i64, ptr %s4, i64 0
  %v23 = add i64 0, 1
  %st11 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st11
  %v24.p = getelementptr i64, ptr %v21, i64 0
  %v24 = load i64, ptr %v24.p
  %st12 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st12
  %v25.p = getelementptr i64, ptr %v21, i64 1
  %v25 = load i64, ptr %v25.p
  %st13 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st13
  %v26.p = getelementptr i64, ptr %v21, i64 2
  %v26 = load i64, ptr %v26.p
  %st14 = getelementptr i64, ptr %v22, i64 3
  store i64 %v26, ptr %st14
  %v27.p = getelementptr i64, ptr %v21, i64 3
  %v27 = load i64, ptr %v27.p
  %st15 = getelementptr i64, ptr %v22, i64 4
  store i64 %v27, ptr %st15
  %v28.p = getelementptr i64, ptr %v21, i64 4
  %v28 = load i64, ptr %v28.p
  %st16 = getelementptr i64, ptr %v22, i64 5
  store i64 %v28, ptr %st16
  %v29.p = getelementptr i64, ptr %v19, i64 0
  %v29 = load i64, ptr %v29.p
  %st17 = getelementptr i64, ptr %v0, i64 0
  store i64 %v29, ptr %st17
  %v30.p = getelementptr i64, ptr %v19, i64 1
  %v30 = load i64, ptr %v30.p
  %st18 = getelementptr i64, ptr %v0, i64 1
  store i64 %v30, ptr %st18
  %v31.p = getelementptr i64, ptr %v19, i64 2
  %v31 = load i64, ptr %v31.p
  %st19 = getelementptr i64, ptr %v0, i64 2
  store i64 %v31, ptr %st19
  %v32.p = getelementptr i64, ptr %v22, i64 0
  %v32 = load i64, ptr %v32.p
  %st20 = getelementptr i64, ptr %v0, i64 3
  store i64 %v32, ptr %st20
  %v33.p = getelementptr i64, ptr %v22, i64 1
  %v33 = load i64, ptr %v33.p
  %st21 = getelementptr i64, ptr %v0, i64 4
  store i64 %v33, ptr %st21
  %v34.p = getelementptr i64, ptr %v22, i64 2
  %v34 = load i64, ptr %v34.p
  %st22 = getelementptr i64, ptr %v0, i64 5
  store i64 %v34, ptr %st22
  %v35.p = getelementptr i64, ptr %v22, i64 3
  %v35 = load i64, ptr %v35.p
  %st23 = getelementptr i64, ptr %v0, i64 6
  store i64 %v35, ptr %st23
  %v36.p = getelementptr i64, ptr %v22, i64 4
  %v36 = load i64, ptr %v36.p
  %st24 = getelementptr i64, ptr %v0, i64 7
  store i64 %v36, ptr %st24
  %v37.p = getelementptr i64, ptr %v22, i64 5
  %v37 = load i64, ptr %v37.p
  %st25 = getelementptr i64, ptr %v0, i64 8
  store i64 %v37, ptr %st25
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v38.p = getelementptr i64, ptr %v0, i64 3
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40.c = icmp ne i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b1 = icmp ne i64 %v40, 0
  br i1 %c.b1, label %b1.t27, label %b1.e28
b1.t27:
  br label %b3
b1.e28:
  br label %b4
b2:
  br label %b5
b3:
  %v41 = add i64 0, 6
  %v42 = getelementptr i64, ptr %v0, i64 %v41
  %v61 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v42, i64 %v61, i64 %v5)
  br label %b4
b4:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v62, i64 0
  store i64 %v5, ptr %st28
  ret void
b5:
  %v43 = getelementptr i64, ptr %s4, i64 0
  %v44 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v43, i64 0
  store i64 %v44, ptr %st29
  %v45.p = getelementptr i64, ptr %v7, i64 0
  %v45 = load i64, ptr %v45.p
  %st30 = getelementptr i64, ptr %v0, i64 0
  store i64 %v45, ptr %st30
  %v46.p = getelementptr i64, ptr %v7, i64 1
  %v46 = load i64, ptr %v46.p
  %st31 = getelementptr i64, ptr %v0, i64 1
  store i64 %v46, ptr %st31
  %v47.p = getelementptr i64, ptr %v7, i64 2
  %v47 = load i64, ptr %v47.p
  %st32 = getelementptr i64, ptr %v0, i64 2
  store i64 %v47, ptr %st32
  %v48.p = getelementptr i64, ptr %v43, i64 0
  %v48 = load i64, ptr %v48.p
  %st33 = getelementptr i64, ptr %v0, i64 3
  store i64 %v48, ptr %st33
  %v49.p = getelementptr i64, ptr %v43, i64 1
  %v49 = load i64, ptr %v49.p
  %st34 = getelementptr i64, ptr %v0, i64 4
  store i64 %v49, ptr %st34
  %v50.p = getelementptr i64, ptr %v43, i64 2
  %v50 = load i64, ptr %v50.p
  %st35 = getelementptr i64, ptr %v0, i64 5
  store i64 %v50, ptr %st35
  %v51.p = getelementptr i64, ptr %v43, i64 3
  %v51 = load i64, ptr %v51.p
  %st36 = getelementptr i64, ptr %v0, i64 6
  store i64 %v51, ptr %st36
  %v52.p = getelementptr i64, ptr %v43, i64 4
  %v52 = load i64, ptr %v52.p
  %st37 = getelementptr i64, ptr %v0, i64 7
  store i64 %v52, ptr %st37
  %v53.p = getelementptr i64, ptr %v43, i64 5
  %v53 = load i64, ptr %v53.p
  %st38 = getelementptr i64, ptr %v0, i64 8
  store i64 %v53, ptr %st38
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v54.p = getelementptr i64, ptr %v0, i64 3
  %v54 = load i64, ptr %v54.p
  %v55 = add i64 0, 0
  %v56.c = icmp ne i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b5 = icmp ne i64 %v56, 0
  br i1 %c.b5, label %b5.t40, label %b5.e41
b5.t40:
  br label %b6
b5.e41:
  br label %b7
b6:
  %v57 = add i64 0, 6
  %v58 = getelementptr i64, ptr %v0, i64 %v57
  %v63 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v58, i64 %v63, i64 %v5)
  br label %b7
b7:
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v64, i64 0
  store i64 %v5, ptr %st41
  ret void
}

define internal void @"std/io.dropCR"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v47 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v47, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6.p = getelementptr i64, ptr %v4, i64 1
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp sgt i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b0 = icmp ne i64 %v8, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v10.p = getelementptr i64, ptr %v4, i64 1
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 1
  %v12 = sub i64 %v10, %v11
  %v13.p = getelementptr i64, ptr %v4, i64 1
  %v13 = load i64, ptr %v13.p
  %v14.c = icmp uge i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b1 = icmp ne i64 %v14, 0
  br i1 %c.b1, label %b1.t6, label %b1.e7
b1.t6:
  br label %b3
b1.e7:
  br label %b4
b2:
  %v9 = phi i64 [ %v8, %b0.e5 ], [ %v21, %b4 ]
  %c.b2 = icmp ne i64 %v9, 0
  br i1 %c.b2, label %b2.t8, label %b2.e9
b2.t8:
  br label %b5
b2.e9:
  br label %b6
b3:
  %v15 = add i64 0, 22
  call void @"rt.panic"(i64 %v15)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v16.p = getelementptr i64, ptr %v4, i64 0
  %v16 = load i64, ptr %v16.p
  %v17 = inttoptr i64 %v16 to ptr
  %v18 = getelementptr i8, ptr %v17, i64 %v12
  %v19.p = getelementptr i8, ptr %v18, i64 0
  %v19.b = load i8, ptr %v19.p
  %v19 = zext i8 %v19.b to i64
  %v20 = add i64 0, 13
  %v21.c = icmp eq i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  br label %b2
b5:
  %v22 = add i64 0, 0
  %v23.p = getelementptr i64, ptr %v4, i64 1
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 1
  %v25 = sub i64 %v23, %v24
  %v26 = add i64 0, 0
  %v27.c = icmp slt i64 %v22, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b5 = icmp ne i64 %v27, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  br label %b13
b7:
  %v28 = add i64 0, 23
  call void @"rt.panic"(i64 %v28)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v29.c = icmp slt i64 %v25, %v22
  %v29 = zext i1 %v29.c to i64
  %c.b8 = icmp ne i64 %v29, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b9
b8.e13:
  br label %b10
b9:
  %v30 = add i64 0, 24
  call void @"rt.panic"(i64 %v30)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v31.p = getelementptr i64, ptr %v4, i64 1
  %v31 = load i64, ptr %v31.p
  %v32.c = icmp sgt i64 %v25, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b10 = icmp ne i64 %v32, 0
  br i1 %c.b10, label %b10.t14, label %b10.e15
b10.t14:
  br label %b11
b10.e15:
  br label %b12
b11:
  %v33 = add i64 0, 25
  call void @"rt.panic"(i64 %v33)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v34.p = getelementptr i64, ptr %v4, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = inttoptr i64 %v34 to ptr
  %v36 = getelementptr i8, ptr %v35, i64 %v22
  %v37 = sub i64 %v25, %v22
  %v38.p = getelementptr i64, ptr %v4, i64 2
  %v38 = load i64, ptr %v38.p
  %v39 = getelementptr i64, ptr %s1, i64 0
  %v40 = ptrtoint ptr %v36 to i64
  %st15 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st15
  %st16 = getelementptr i64, ptr %v39, i64 1
  store i64 %v37, ptr %st16
  %st17 = getelementptr i64, ptr %v39, i64 2
  store i64 %v38, ptr %st17
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v41, ptr %st18
  %v42.p = getelementptr i64, ptr %v39, i64 1
  %v42 = load i64, ptr %v42.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v42, ptr %st19
  %v43.p = getelementptr i64, ptr %v39, i64 2
  %v43 = load i64, ptr %v43.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v43, ptr %st20
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v48 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v48, i64 0
  store i64 %v5, ptr %st21
  ret void
b13:
  %v44.p = getelementptr i64, ptr %v4, i64 0
  %v44 = load i64, ptr %v44.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v44, ptr %st22
  %v45.p = getelementptr i64, ptr %v4, i64 1
  %v45 = load i64, ptr %v45.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v45, ptr %st23
  %v46.p = getelementptr i64, ptr %v4, i64 2
  %v46 = load i64, ptr %v46.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v46, ptr %st24
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v49 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v49, i64 0
  store i64 %v5, ptr %st25
  ret void
}

define internal void @"std/utf8.Parse"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v65 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v65, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6.p = getelementptr i64, ptr %v4, i64 0
  %v6 = load i64, ptr %v6.p
  %v7.p = getelementptr i64, ptr %v4, i64 1
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 2
  %v8 = load i64, ptr %v8.p
  %v9 = call i64 @"std/utf8.IndexInvalid"(i64 %v6, i64 %v7, i64 %v8)
  %v10 = add i64 0, 0
  %v11.c = icmp sge i64 %v9, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b0 = icmp ne i64 %v11, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v12 = getelementptr i64, ptr @"str.23", i64 0
  %v13 = add i64 0, 0
  %v14 = add i64 0, 0
  %v15 = getelementptr i64, ptr %s1, i64 0
  %v16 = ptrtoint ptr %v12 to i64
  %st5 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st5
  %st6 = getelementptr i64, ptr %v15, i64 1
  store i64 %v13, ptr %st6
  %st7 = getelementptr i64, ptr %v15, i64 2
  store i64 %v14, ptr %st7
  %v17 = getelementptr i64, ptr %s2, i64 0
  %v18 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st8
  %st9 = getelementptr i64, ptr %v17, i64 1
  store i64 %v18, ptr %st9
  %v19 = add i64 0, 4
  %st10 = getelementptr i64, ptr %v17, i64 0
  store i64 %v19, ptr %st10
  %st11 = getelementptr i64, ptr %v17, i64 1
  store i64 %v9, ptr %st11
  %v20 = getelementptr i64, ptr %s3, i64 0
  %v21.p = getelementptr i64, ptr %v17, i64 0
  %v21 = load i64, ptr %v21.p
  %st12 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st12
  %v22.p = getelementptr i64, ptr %v17, i64 1
  %v22 = load i64, ptr %v22.p
  %st13 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st13
  %v23 = add i64 0, 0
  %st14 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st14
  %st15 = getelementptr i64, ptr %v20, i64 3
  store i64 %v23, ptr %st15
  %st16 = getelementptr i64, ptr %v20, i64 4
  store i64 %v23, ptr %st16
  %v24 = getelementptr i64, ptr %s4, i64 0
  %v25 = add i64 0, 1
  %st17 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st17
  %v26.p = getelementptr i64, ptr %v20, i64 0
  %v26 = load i64, ptr %v26.p
  %st18 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st18
  %v27.p = getelementptr i64, ptr %v20, i64 1
  %v27 = load i64, ptr %v27.p
  %st19 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st19
  %v28.p = getelementptr i64, ptr %v20, i64 2
  %v28 = load i64, ptr %v28.p
  %st20 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st20
  %v29.p = getelementptr i64, ptr %v20, i64 3
  %v29 = load i64, ptr %v29.p
  %st21 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st21
  %v30.p = getelementptr i64, ptr %v20, i64 4
  %v30 = load i64, ptr %v30.p
  %st22 = getelementptr i64, ptr %v24, i64 5
  store i64 %v30, ptr %st22
  %v31.p = getelementptr i64, ptr %v15, i64 0
  %v31 = load i64, ptr %v31.p
  %st23 = getelementptr i64, ptr %v0, i64 0
  store i64 %v31, ptr %st23
  %v32.p = getelementptr i64, ptr %v15, i64 1
  %v32 = load i64, ptr %v32.p
  %st24 = getelementptr i64, ptr %v0, i64 1
  store i64 %v32, ptr %st24
  %v33.p = getelementptr i64, ptr %v15, i64 2
  %v33 = load i64, ptr %v33.p
  %st25 = getelementptr i64, ptr %v0, i64 2
  store i64 %v33, ptr %st25
  %v34.p = getelementptr i64, ptr %v24, i64 0
  %v34 = load i64, ptr %v34.p
  %st26 = getelementptr i64, ptr %v0, i64 3
  store i64 %v34, ptr %st26
  %v35.p = getelementptr i64, ptr %v24, i64 1
  %v35 = load i64, ptr %v35.p
  %st27 = getelementptr i64, ptr %v0, i64 4
  store i64 %v35, ptr %st27
  %v36.p = getelementptr i64, ptr %v24, i64 2
  %v36 = load i64, ptr %v36.p
  %st28 = getelementptr i64, ptr %v0, i64 5
  store i64 %v36, ptr %st28
  %v37.p = getelementptr i64, ptr %v24, i64 3
  %v37 = load i64, ptr %v37.p
  %st29 = getelementptr i64, ptr %v0, i64 6
  store i64 %v37, ptr %st29
  %v38.p = getelementptr i64, ptr %v24, i64 4
  %v38 = load i64, ptr %v38.p
  %st30 = getelementptr i64, ptr %v0, i64 7
  store i64 %v38, ptr %st30
  %v39.p = getelementptr i64, ptr %v24, i64 5
  %v39 = load i64, ptr %v39.p
  %st31 = getelementptr i64, ptr %v0, i64 8
  store i64 %v39, ptr %st31
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v40.p = getelementptr i64, ptr %v0, i64 3
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 0
  %v42.c = icmp ne i64 %v40, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b1 = icmp ne i64 %v42, 0
  br i1 %c.b1, label %b1.t33, label %b1.e34
b1.t33:
  br label %b3
b1.e34:
  br label %b4
b2:
  br label %b5
b3:
  %v43 = add i64 0, 6
  %v44 = getelementptr i64, ptr %v0, i64 %v43
  %v66 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v44, i64 %v66, i64 %v5)
  br label %b4
b4:
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v67, i64 0
  store i64 %v5, ptr %st34
  ret void
b5:
  %v45 = getelementptr i64, ptr %s1, i64 0
  %v46.p = getelementptr i64, ptr %v4, i64 0
  %v46 = load i64, ptr %v46.p
  %st35 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st35
  %v47.p = getelementptr i64, ptr %v4, i64 1
  %v47 = load i64, ptr %v47.p
  %st36 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st36
  %v48.p = getelementptr i64, ptr %v4, i64 2
  %v48 = load i64, ptr %v48.p
  %st37 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st37
  %v49 = getelementptr i64, ptr %s4, i64 0
  %v50 = add i64 0, 0
  %st38 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st38
  %v51.p = getelementptr i64, ptr %v45, i64 0
  %v51 = load i64, ptr %v51.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v51, ptr %st39
  %v52.p = getelementptr i64, ptr %v45, i64 1
  %v52 = load i64, ptr %v52.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v52, ptr %st40
  %v53.p = getelementptr i64, ptr %v45, i64 2
  %v53 = load i64, ptr %v53.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v53, ptr %st41
  %v54.p = getelementptr i64, ptr %v49, i64 0
  %v54 = load i64, ptr %v54.p
  %st42 = getelementptr i64, ptr %v0, i64 3
  store i64 %v54, ptr %st42
  %v55.p = getelementptr i64, ptr %v49, i64 1
  %v55 = load i64, ptr %v55.p
  %st43 = getelementptr i64, ptr %v0, i64 4
  store i64 %v55, ptr %st43
  %v56.p = getelementptr i64, ptr %v49, i64 2
  %v56 = load i64, ptr %v56.p
  %st44 = getelementptr i64, ptr %v0, i64 5
  store i64 %v56, ptr %st44
  %v57.p = getelementptr i64, ptr %v49, i64 3
  %v57 = load i64, ptr %v57.p
  %st45 = getelementptr i64, ptr %v0, i64 6
  store i64 %v57, ptr %st45
  %v58.p = getelementptr i64, ptr %v49, i64 4
  %v58 = load i64, ptr %v58.p
  %st46 = getelementptr i64, ptr %v0, i64 7
  store i64 %v58, ptr %st46
  %v59.p = getelementptr i64, ptr %v49, i64 5
  %v59 = load i64, ptr %v59.p
  %st47 = getelementptr i64, ptr %v0, i64 8
  store i64 %v59, ptr %st47
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v60.p = getelementptr i64, ptr %v0, i64 3
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 0
  %v62.c = icmp ne i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b5 = icmp ne i64 %v62, 0
  br i1 %c.b5, label %b5.t49, label %b5.e50
b5.t49:
  br label %b6
b5.e50:
  br label %b7
b6:
  %v63 = add i64 0, 6
  %v64 = getelementptr i64, ptr %v0, i64 %v63
  %v68 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v64, i64 %v68, i64 %v5)
  br label %b7
b7:
  %v69 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v69, i64 0
  store i64 %v5, ptr %st50
  ret void
}

define internal void @"std/io.joined"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [1 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
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
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v139, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v140 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v140, i64 0
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
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v141, i64 0
  %v20 = load i64, ptr %v20.p
  %v21 = getelementptr i64, ptr %s2, i64 0
  %v22.p = getelementptr i64, ptr %v7, i64 0
  %v22 = load i64, ptr %v22.p
  %st12 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st12
  %v23.p = getelementptr i64, ptr %v7, i64 1
  %v23 = load i64, ptr %v23.p
  %st13 = getelementptr i64, ptr %v21, i64 1
  store i64 %v23, ptr %st13
  %v24.p = getelementptr i64, ptr %v7, i64 2
  %v24 = load i64, ptr %v24.p
  %st14 = getelementptr i64, ptr %v21, i64 2
  store i64 %v24, ptr %st14
  %v25 = getelementptr i64, ptr %s4, i64 0
  %v26.p = getelementptr i64, ptr %v21, i64 0
  %v26 = load i64, ptr %v26.p
  %st15 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st15
  %v27.p = getelementptr i64, ptr %v21, i64 1
  %v27 = load i64, ptr %v27.p
  %st16 = getelementptr i64, ptr %v25, i64 1
  store i64 %v27, ptr %st16
  %v28.p = getelementptr i64, ptr %v21, i64 2
  %v28 = load i64, ptr %v28.p
  %st17 = getelementptr i64, ptr %v25, i64 2
  store i64 %v28, ptr %st17
  %v29 = getelementptr i64, ptr %s5, i64 0
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v142, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 0
  %v32 = getelementptr i64, ptr %s6, i64 0
  %st18 = getelementptr i64, ptr %v32, i64 0
  store i64 %v31, ptr %st18
  %v143 = getelementptr i64, ptr @"rt.meta", i64 0
  %v33.p = getelementptr i64, ptr %v143, i64 0
  %v33 = load i64, ptr %v33.p
  br label %b3
b1:
  %v144 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v144, i64 0
  store i64 %v20, ptr %st19
  %v145 = getelementptr i64, ptr @"rt.meta", i64 0
  %v78.p = getelementptr i64, ptr %v145, i64 0
  %v78 = load i64, ptr %v78.p
  %v79 = getelementptr i64, ptr %s4, i64 0
  %v80.p = getelementptr i64, ptr %v8, i64 0
  %v80 = load i64, ptr %v80.p
  %st20 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st20
  %v81.p = getelementptr i64, ptr %v8, i64 1
  %v81 = load i64, ptr %v81.p
  %st21 = getelementptr i64, ptr %v79, i64 1
  store i64 %v81, ptr %st21
  %v82.p = getelementptr i64, ptr %v8, i64 2
  %v82 = load i64, ptr %v82.p
  %st22 = getelementptr i64, ptr %v79, i64 2
  store i64 %v82, ptr %st22
  %v83 = getelementptr i64, ptr %s2, i64 0
  %v84.p = getelementptr i64, ptr %v79, i64 0
  %v84 = load i64, ptr %v84.p
  %st23 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st23
  %v85.p = getelementptr i64, ptr %v79, i64 1
  %v85 = load i64, ptr %v85.p
  %st24 = getelementptr i64, ptr %v83, i64 1
  store i64 %v85, ptr %st24
  %v86.p = getelementptr i64, ptr %v79, i64 2
  %v86 = load i64, ptr %v86.p
  %st25 = getelementptr i64, ptr %v83, i64 2
  store i64 %v86, ptr %st25
  %v87 = getelementptr i64, ptr %s6, i64 0
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %v88.p = getelementptr i64, ptr %v146, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = add i64 0, 0
  %v90 = getelementptr i64, ptr %s5, i64 0
  %st26 = getelementptr i64, ptr %v90, i64 0
  store i64 %v89, ptr %st26
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %v91.p = getelementptr i64, ptr %v147, i64 0
  %v91 = load i64, ptr %v91.p
  br label %b14
b2:
  br label %b1
b3:
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v148, i64 0
  store i64 %v33, ptr %st27
  %v34.p = getelementptr i64, ptr %v32, i64 0
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v25, i64 1
  %v35 = load i64, ptr %v35.p
  %v36.c = icmp slt i64 %v34, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b3 = icmp ne i64 %v36, 0
  br i1 %c.b3, label %b3.t29, label %b3.e30
b3.t29:
  br label %b4
b3.e30:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v149, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v32, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v25, i64 1
  %v39 = load i64, ptr %v39.p
  %v40.c = icmp uge i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b4 = icmp ne i64 %v40, 0
  br i1 %c.b4, label %b4.t31, label %b4.e32
b4.t31:
  br label %b6
b4.e32:
  br label %b7
b5:
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v150, i64 0
  store i64 %v33, ptr %st32
  br label %b2
b6:
  %v41 = add i64 0, 12
  call void @"rt.panic"(i64 %v41)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v42.p = getelementptr i64, ptr %v25, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = inttoptr i64 %v42 to ptr
  %v44 = getelementptr i8, ptr %v43, i64 %v38
  %v45.p = getelementptr i8, ptr %v44, i64 0
  %v45.b = load i8, ptr %v45.p
  %v45 = zext i8 %v45.b to i64
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v151, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 0, 1
  %v48 = add i64 %v9, %v47
  %v49 = getelementptr i64, ptr %s7, i64 0
  %v50.p = getelementptr i64, ptr %v16, i64 0
  %v50 = load i64, ptr %v50.p
  %st33 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st33
  %v51.p = getelementptr i64, ptr %v16, i64 1
  %v51 = load i64, ptr %v51.p
  %st34 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st34
  %v52.p = getelementptr i64, ptr %v16, i64 2
  %v52 = load i64, ptr %v52.p
  %st35 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st35
  %v53.p = getelementptr i64, ptr %v49, i64 2
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v49, i64 0
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v49, i64 1
  %v55 = load i64, ptr %v55.p
  %v58 = add i64 %v54, %v55
  %v59 = call i64 @"rt.tip8"(i64 %v53, i64 %v58)
  %v60 = add i64 0, 0
  %v61.c = icmp ne i64 %v59, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b7 = icmp ne i64 %v61, 0
  br i1 %c.b7, label %b7.t37, label %b7.e38
b7.t37:
  br label %b11
b7.e38:
  br label %b10
b8:
  %v152 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v152, i64 0
  store i64 %v46, ptr %st38
  %v75 = add i64 0, 1
  %v76.p = getelementptr i64, ptr %v32, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = add i64 %v76, %v75
  %st39 = getelementptr i64, ptr %v32, i64 0
  store i64 %v77, ptr %st39
  br label %b3
b9:
  %v56 = phi ptr [ %v65, %b10 ], [ %v62, %b11 ]
  %v57 = phi ptr [ %v66, %b10 ], [ %v63, %b11 ]
  %st40 = getelementptr i8, ptr %v57, i64 0
  %st40.b = trunc i64 %v45 to i8
  store i8 %st40.b, ptr %st40
  %v67.p = getelementptr i64, ptr %v49, i64 1
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 1
  %v69 = add i64 %v67, %v68
  %v70 = getelementptr i64, ptr %s8, i64 0
  %v71 = ptrtoint ptr %v56 to i64
  %st41 = getelementptr i64, ptr %v70, i64 0
  store i64 %v71, ptr %st41
  %st42 = getelementptr i64, ptr %v70, i64 1
  store i64 %v69, ptr %st42
  %st43 = getelementptr i64, ptr %v70, i64 2
  store i64 %v53, ptr %st43
  %v72.p = getelementptr i64, ptr %v70, i64 0
  %v72 = load i64, ptr %v72.p
  %st44 = getelementptr i64, ptr %v16, i64 0
  store i64 %v72, ptr %st44
  %v73.p = getelementptr i64, ptr %v70, i64 1
  %v73 = load i64, ptr %v73.p
  %st45 = getelementptr i64, ptr %v16, i64 1
  store i64 %v73, ptr %st45
  %v74.p = getelementptr i64, ptr %v70, i64 2
  %v74 = load i64, ptr %v74.p
  %st46 = getelementptr i64, ptr %v16, i64 2
  store i64 %v74, ptr %st46
  br label %b8
b10:
  %v64 = add i64 0, 1
  %v65 = call ptr @"rt.slice_grow8"(i64 %v54, i64 %v55, i64 %v53, i64 %v64)
  %v66 = getelementptr i8, ptr %v65, i64 %v55
  br label %b9
b11:
  %v62 = inttoptr i64 %v54 to ptr
  %v63 = getelementptr i8, ptr %v62, i64 %v55
  br label %b9
b12:
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v153, i64 0
  store i64 %v78, ptr %st47
  %v136.p = getelementptr i64, ptr %v16, i64 0
  %v136 = load i64, ptr %v136.p
  %st48 = getelementptr i64, ptr %v0, i64 0
  store i64 %v136, ptr %st48
  %v137.p = getelementptr i64, ptr %v16, i64 1
  %v137 = load i64, ptr %v137.p
  %st49 = getelementptr i64, ptr %v0, i64 1
  store i64 %v137, ptr %st49
  %v138.p = getelementptr i64, ptr %v16, i64 2
  %v138 = load i64, ptr %v138.p
  %st50 = getelementptr i64, ptr %v0, i64 2
  store i64 %v138, ptr %st50
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v154 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v154, i64 0
  store i64 %v9, ptr %st51
  ret void
b13:
  br label %b12
b14:
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v155, i64 0
  store i64 %v91, ptr %st52
  %v92.p = getelementptr i64, ptr %v90, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v83, i64 1
  %v93 = load i64, ptr %v93.p
  %v94.c = icmp slt i64 %v92, %v93
  %v94 = zext i1 %v94.c to i64
  %c.b14 = icmp ne i64 %v94, 0
  br i1 %c.b14, label %b14.t54, label %b14.e55
b14.t54:
  br label %b15
b14.e55:
  br label %b16
b15:
  call void @"rt.region_enter"()
  %v156 = getelementptr i64, ptr @"rt.meta", i64 0
  %v95.p = getelementptr i64, ptr %v156, i64 0
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v90, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v83, i64 1
  %v97 = load i64, ptr %v97.p
  %v98.c = icmp uge i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b15 = icmp ne i64 %v98, 0
  br i1 %c.b15, label %b15.t56, label %b15.e57
b15.t56:
  br label %b17
b15.e57:
  br label %b18
b16:
  %v157 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v157, i64 0
  store i64 %v91, ptr %st57
  br label %b13
b17:
  %v99 = add i64 0, 13
  call void @"rt.panic"(i64 %v99)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v100.p = getelementptr i64, ptr %v83, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = inttoptr i64 %v100 to ptr
  %v102 = getelementptr i8, ptr %v101, i64 %v96
  %v103.p = getelementptr i8, ptr %v102, i64 0
  %v103.b = load i8, ptr %v103.p
  %v103 = zext i8 %v103.b to i64
  %v158 = getelementptr i64, ptr @"rt.meta", i64 0
  %v104.p = getelementptr i64, ptr %v158, i64 0
  %v104 = load i64, ptr %v104.p
  %v105 = add i64 0, 1
  %v106 = add i64 %v9, %v105
  %v107 = getelementptr i64, ptr %s8, i64 0
  %v108.p = getelementptr i64, ptr %v16, i64 0
  %v108 = load i64, ptr %v108.p
  %st58 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st58
  %v109.p = getelementptr i64, ptr %v16, i64 1
  %v109 = load i64, ptr %v109.p
  %st59 = getelementptr i64, ptr %v107, i64 1
  store i64 %v109, ptr %st59
  %v110.p = getelementptr i64, ptr %v16, i64 2
  %v110 = load i64, ptr %v110.p
  %st60 = getelementptr i64, ptr %v107, i64 2
  store i64 %v110, ptr %st60
  %v111.p = getelementptr i64, ptr %v107, i64 2
  %v111 = load i64, ptr %v111.p
  %v112.p = getelementptr i64, ptr %v107, i64 0
  %v112 = load i64, ptr %v112.p
  %v113.p = getelementptr i64, ptr %v107, i64 1
  %v113 = load i64, ptr %v113.p
  %v116 = add i64 %v112, %v113
  %v117 = call i64 @"rt.tip8"(i64 %v111, i64 %v116)
  %v118 = add i64 0, 0
  %v119.c = icmp ne i64 %v117, %v118
  %v119 = zext i1 %v119.c to i64
  %c.b18 = icmp ne i64 %v119, 0
  br i1 %c.b18, label %b18.t62, label %b18.e63
b18.t62:
  br label %b22
b18.e63:
  br label %b21
b19:
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v159, i64 0
  store i64 %v104, ptr %st63
  %v133 = add i64 0, 1
  %v134.p = getelementptr i64, ptr %v90, i64 0
  %v134 = load i64, ptr %v134.p
  %v135 = add i64 %v134, %v133
  %st64 = getelementptr i64, ptr %v90, i64 0
  store i64 %v135, ptr %st64
  br label %b14
b20:
  %v114 = phi ptr [ %v123, %b21 ], [ %v120, %b22 ]
  %v115 = phi ptr [ %v124, %b21 ], [ %v121, %b22 ]
  %st65 = getelementptr i8, ptr %v115, i64 0
  %st65.b = trunc i64 %v103 to i8
  store i8 %st65.b, ptr %st65
  %v125.p = getelementptr i64, ptr %v107, i64 1
  %v125 = load i64, ptr %v125.p
  %v126 = add i64 0, 1
  %v127 = add i64 %v125, %v126
  %v128 = getelementptr i64, ptr %s7, i64 0
  %v129 = ptrtoint ptr %v114 to i64
  %st66 = getelementptr i64, ptr %v128, i64 0
  store i64 %v129, ptr %st66
  %st67 = getelementptr i64, ptr %v128, i64 1
  store i64 %v127, ptr %st67
  %st68 = getelementptr i64, ptr %v128, i64 2
  store i64 %v111, ptr %st68
  %v130.p = getelementptr i64, ptr %v128, i64 0
  %v130 = load i64, ptr %v130.p
  %st69 = getelementptr i64, ptr %v16, i64 0
  store i64 %v130, ptr %st69
  %v131.p = getelementptr i64, ptr %v128, i64 1
  %v131 = load i64, ptr %v131.p
  %st70 = getelementptr i64, ptr %v16, i64 1
  store i64 %v131, ptr %st70
  %v132.p = getelementptr i64, ptr %v128, i64 2
  %v132 = load i64, ptr %v132.p
  %st71 = getelementptr i64, ptr %v16, i64 2
  store i64 %v132, ptr %st71
  br label %b19
b21:
  %v122 = add i64 0, 1
  %v123 = call ptr @"rt.slice_grow8"(i64 %v112, i64 %v113, i64 %v111, i64 %v122)
  %v124 = getelementptr i8, ptr %v123, i64 %v113
  br label %b20
b22:
  %v120 = inttoptr i64 %v112 to ptr
  %v121 = getelementptr i8, ptr %v120, i64 %v113
  br label %b20
}

define internal i64 @"std/utf8.IndexInvalid"(i64 %v0, i64 %v1, i64 %v2) #0 {
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
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v3, i64 2
  store i64 %v2, ptr %st2
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v146, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5 = add i64 0, 0
  %v6 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v6, i64 0
  store i64 %v5, ptr %st3
  %v7 = add i64 0, 1
  %v8 = add i64 0, 0
  %v9 = sub i64 %v8, %v7
  %v10 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v10, i64 0
  store i64 %v9, ptr %st4
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v147, i64 0
  %v11 = load i64, ptr %v11.p
  br label %b1
b1:
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v148, i64 0
  store i64 %v11, ptr %st5
  %v12.p = getelementptr i64, ptr %v10, i64 0
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 0
  %v14.c = icmp slt i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b1 = icmp ne i64 %v14, 0
  br i1 %c.b1, label %b1.t7, label %b1.e8
b1.t7:
  br label %b4
b1.e8:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v149, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 1
  %v21 = add i64 %v4, %v20
  %v22.p = getelementptr i64, ptr %v3, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v3, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v3, i64 2
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v6, i64 0
  %v25 = load i64, ptr %v25.p
  %v26 = call i64 @"std/utf8.validPrefix"(i64 %v22, i64 %v23, i64 %v24, i64 %v25)
  %st8 = getelementptr i64, ptr %v6, i64 0
  store i64 %v26, ptr %st8
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v150, i64 0
  %v27 = load i64, ptr %v27.p
  br label %b6
b3:
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v151, i64 0
  store i64 %v11, ptr %st9
  %v145.p = getelementptr i64, ptr %v10, i64 0
  %v145 = load i64, ptr %v145.p
  %v152 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v152, i64 0
  store i64 %v4, ptr %st10
  ret i64 %v145
b4:
  %v16.p = getelementptr i64, ptr %v6, i64 0
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v3, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.c = icmp slt i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  br label %b5
b5:
  %v15 = phi i64 [ %v14, %b1.e8 ], [ %v18, %b4 ]
  %c.b5 = icmp ne i64 %v15, 0
  br i1 %c.b5, label %b5.t12, label %b5.e13
b5.t12:
  br label %b2
b5.e13:
  br label %b3
b6:
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v153, i64 0
  store i64 %v27, ptr %st13
  %v28.p = getelementptr i64, ptr %v6, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v3, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.c = icmp slt i64 %v28, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b6 = icmp ne i64 %v30, 0
  br i1 %c.b6, label %b6.t15, label %b6.e16
b6.t15:
  br label %b9
b6.e16:
  br label %b10
b7:
  call void @"rt.region_enter"()
  %v154 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v154, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 0, 1
  %v44.p = getelementptr i64, ptr %v6, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = add i64 %v44, %v43
  %st16 = getelementptr i64, ptr %v6, i64 0
  store i64 %v45, ptr %st16
  br label %b6
b8:
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v155, i64 0
  store i64 %v27, ptr %st17
  %v46.p = getelementptr i64, ptr %v6, i64 0
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v3, i64 1
  %v47 = load i64, ptr %v47.p
  %v48.c = icmp sge i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b8 = icmp ne i64 %v48, 0
  br i1 %c.b8, label %b8.t19, label %b8.e20
b8.t19:
  br label %b13
b8.e20:
  br label %b14
b9:
  %v32.p = getelementptr i64, ptr %v6, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v3, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.c = icmp uge i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b9 = icmp ne i64 %v34, 0
  br i1 %c.b9, label %b9.t21, label %b9.e22
b9.t21:
  br label %b11
b9.e22:
  br label %b12
b10:
  %v31 = phi i64 [ %v30, %b6.e16 ], [ %v41, %b12 ]
  %c.b10 = icmp ne i64 %v31, 0
  br i1 %c.b10, label %b10.t23, label %b10.e24
b10.t23:
  br label %b7
b10.e24:
  br label %b8
b11:
  %v35 = add i64 0, 14
  call void @"rt.panic"(i64 %v35)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v36.p = getelementptr i64, ptr %v3, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = inttoptr i64 %v36 to ptr
  %v38 = getelementptr i8, ptr %v37, i64 %v32
  %v39.p = getelementptr i8, ptr %v38, i64 0
  %v39.b = load i8, ptr %v39.p
  %v39 = zext i8 %v39.b to i64
  %v40 = add i64 0, 128
  %v41.c = icmp slt i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  br label %b10
b13:
  br label %b3
b14:
  br label %b15
b15:
  %v49.p = getelementptr i64, ptr %v6, i64 0
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v3, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.c = icmp uge i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b15 = icmp ne i64 %v51, 0
  br i1 %c.b15, label %b15.t25, label %b15.e26
b15.t25:
  br label %b16
b15.e26:
  br label %b17
b16:
  %v52 = add i64 0, 15
  call void @"rt.panic"(i64 %v52)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v53.p = getelementptr i64, ptr %v3, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = inttoptr i64 %v53 to ptr
  %v55 = getelementptr i8, ptr %v54, i64 %v49
  %v56.p = getelementptr i8, ptr %v55, i64 0
  %v56.b = load i8, ptr %v56.p
  %v56 = zext i8 %v56.b to i64
  %v57 = add i64 0, 194
  %v58.c = icmp sge i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b17 = icmp ne i64 %v58, 0
  br i1 %c.b17, label %b17.t27, label %b17.e28
b17.t27:
  br label %b18
b17.e28:
  br label %b19
b18:
  %v60 = add i64 0, 223
  %v61.c = icmp sle i64 %v56, %v60
  %v61 = zext i1 %v61.c to i64
  br label %b19
b19:
  %v59 = phi i64 [ %v58, %b17.e28 ], [ %v61, %b18 ]
  %c.b19 = icmp ne i64 %v59, 0
  br i1 %c.b19, label %b19.t29, label %b19.e30
b19.t29:
  br label %b20
b19.e30:
  br label %b21
b20:
  %v63.p = getelementptr i64, ptr %v6, i64 0
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 0, 1
  %v65 = add i64 %v63, %v64
  %v66.p = getelementptr i64, ptr %v3, i64 1
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp slt i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  br label %b21
b21:
  %v62 = phi i64 [ %v59, %b19.e30 ], [ %v67, %b20 ]
  %c.b21 = icmp ne i64 %v62, 0
  br i1 %c.b21, label %b21.t31, label %b21.e32
b21.t31:
  br label %b22
b21.e32:
  br label %b23
b22:
  %v69.p = getelementptr i64, ptr %v6, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 1
  %v71 = add i64 %v69, %v70
  %v72.p = getelementptr i64, ptr %v3, i64 1
  %v72 = load i64, ptr %v72.p
  %v73.c = icmp uge i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b22 = icmp ne i64 %v73, 0
  br i1 %c.b22, label %b22.t33, label %b22.e34
b22.t33:
  br label %b24
b22.e34:
  br label %b25
b23:
  %v68 = phi i64 [ %v62, %b21.e32 ], [ %v82, %b25 ]
  %c.b23 = icmp ne i64 %v68, 0
  br i1 %c.b23, label %b23.t35, label %b23.e36
b23.t35:
  br label %b26
b23.e36:
  br label %b27
b24:
  %v74 = add i64 0, 16
  call void @"rt.panic"(i64 %v74)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  %v75.p = getelementptr i64, ptr %v3, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = inttoptr i64 %v75 to ptr
  %v77 = getelementptr i8, ptr %v76, i64 %v71
  %v78.p = getelementptr i8, ptr %v77, i64 0
  %v78.b = load i8, ptr %v78.p
  %v78 = zext i8 %v78.b to i64
  %v79 = add i64 0, 192
  %v80 = and i64 %v78, %v79
  %v81 = add i64 0, 128
  %v82.c = icmp eq i64 %v80, %v81
  %v82 = zext i1 %v82.c to i64
  br label %b23
b26:
  %v83 = add i64 0, 2
  %v84.p = getelementptr i64, ptr %v6, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 %v84, %v83
  %st36 = getelementptr i64, ptr %v6, i64 0
  store i64 %v85, ptr %st36
  br label %b1
b27:
  br label %b28
b28:
  %v86 = add i64 0, 225
  %v87.c = icmp sge i64 %v56, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b28 = icmp ne i64 %v87, 0
  br i1 %c.b28, label %b28.t38, label %b28.e39
b28.t38:
  br label %b29
b28.e39:
  br label %b30
b29:
  %v89 = add i64 0, 239
  %v90.c = icmp sle i64 %v56, %v89
  %v90 = zext i1 %v90.c to i64
  br label %b30
b30:
  %v88 = phi i64 [ %v87, %b28.e39 ], [ %v90, %b29 ]
  %c.b30 = icmp ne i64 %v88, 0
  br i1 %c.b30, label %b30.t40, label %b30.e41
b30.t40:
  br label %b31
b30.e41:
  br label %b32
b31:
  %v92 = add i64 0, 237
  %v93.c = icmp ne i64 %v56, %v92
  %v93 = zext i1 %v93.c to i64
  br label %b32
b32:
  %v91 = phi i64 [ %v88, %b30.e41 ], [ %v93, %b31 ]
  %c.b32 = icmp ne i64 %v91, 0
  br i1 %c.b32, label %b32.t42, label %b32.e43
b32.t42:
  br label %b33
b32.e43:
  br label %b34
b33:
  %v95.p = getelementptr i64, ptr %v6, i64 0
  %v95 = load i64, ptr %v95.p
  %v96 = add i64 0, 2
  %v97 = add i64 %v95, %v96
  %v98.p = getelementptr i64, ptr %v3, i64 1
  %v98 = load i64, ptr %v98.p
  %v99.c = icmp slt i64 %v97, %v98
  %v99 = zext i1 %v99.c to i64
  br label %b34
b34:
  %v94 = phi i64 [ %v91, %b32.e43 ], [ %v99, %b33 ]
  %c.b34 = icmp ne i64 %v94, 0
  br i1 %c.b34, label %b34.t44, label %b34.e45
b34.t44:
  br label %b35
b34.e45:
  br label %b36
b35:
  %v101.p = getelementptr i64, ptr %v6, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 1
  %v103 = add i64 %v101, %v102
  %v104.p = getelementptr i64, ptr %v3, i64 1
  %v104 = load i64, ptr %v104.p
  %v105.c = icmp uge i64 %v103, %v104
  %v105 = zext i1 %v105.c to i64
  %c.b35 = icmp ne i64 %v105, 0
  br i1 %c.b35, label %b35.t46, label %b35.e47
b35.t46:
  br label %b37
b35.e47:
  br label %b38
b36:
  %v100 = phi i64 [ %v94, %b34.e45 ], [ %v114, %b38 ]
  %c.b36 = icmp ne i64 %v100, 0
  br i1 %c.b36, label %b36.t48, label %b36.e49
b36.t48:
  br label %b39
b36.e49:
  br label %b40
b37:
  %v106 = add i64 0, 17
  call void @"rt.panic"(i64 %v106)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b38:
  %v107.p = getelementptr i64, ptr %v3, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = inttoptr i64 %v107 to ptr
  %v109 = getelementptr i8, ptr %v108, i64 %v103
  %v110.p = getelementptr i8, ptr %v109, i64 0
  %v110.b = load i8, ptr %v110.p
  %v110 = zext i8 %v110.b to i64
  %v111 = add i64 0, 192
  %v112 = and i64 %v110, %v111
  %v113 = add i64 0, 128
  %v114.c = icmp eq i64 %v112, %v113
  %v114 = zext i1 %v114.c to i64
  br label %b36
b39:
  %v116.p = getelementptr i64, ptr %v6, i64 0
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 2
  %v118 = add i64 %v116, %v117
  %v119.p = getelementptr i64, ptr %v3, i64 1
  %v119 = load i64, ptr %v119.p
  %v120.c = icmp uge i64 %v118, %v119
  %v120 = zext i1 %v120.c to i64
  %c.b39 = icmp ne i64 %v120, 0
  br i1 %c.b39, label %b39.t50, label %b39.e51
b39.t50:
  br label %b41
b39.e51:
  br label %b42
b40:
  %v115 = phi i64 [ %v100, %b36.e49 ], [ %v129, %b42 ]
  %c.b40 = icmp ne i64 %v115, 0
  br i1 %c.b40, label %b40.t52, label %b40.e53
b40.t52:
  br label %b43
b40.e53:
  br label %b44
b41:
  %v121 = add i64 0, 18
  call void @"rt.panic"(i64 %v121)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b42:
  %v122.p = getelementptr i64, ptr %v3, i64 0
  %v122 = load i64, ptr %v122.p
  %v123 = inttoptr i64 %v122 to ptr
  %v124 = getelementptr i8, ptr %v123, i64 %v118
  %v125.p = getelementptr i8, ptr %v124, i64 0
  %v125.b = load i8, ptr %v125.p
  %v125 = zext i8 %v125.b to i64
  %v126 = add i64 0, 192
  %v127 = and i64 %v125, %v126
  %v128 = add i64 0, 128
  %v129.c = icmp eq i64 %v127, %v128
  %v129 = zext i1 %v129.c to i64
  br label %b40
b43:
  %v130 = add i64 0, 3
  %v131.p = getelementptr i64, ptr %v6, i64 0
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 %v131, %v130
  %st53 = getelementptr i64, ptr %v6, i64 0
  store i64 %v132, ptr %st53
  br label %b1
b44:
  br label %b45
b45:
  %v133.p = getelementptr i64, ptr %v3, i64 0
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v3, i64 1
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v3, i64 2
  %v135 = load i64, ptr %v135.p
  %v136.p = getelementptr i64, ptr %v6, i64 0
  %v136 = load i64, ptr %v136.p
  %v137 = call i64 @"std/utf8.seqLen"(i64 %v133, i64 %v134, i64 %v135, i64 %v136)
  %v138 = add i64 0, 0
  %v139.c = icmp eq i64 %v137, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b45 = icmp ne i64 %v139, 0
  br i1 %c.b45, label %b45.t55, label %b45.e56
b45.t55:
  br label %b46
b45.e56:
  br label %b47
b46:
  %v140 = add i64 0, 1
  %v141 = add i64 %v4, %v140
  %v142.p = getelementptr i64, ptr %v6, i64 0
  %v142 = load i64, ptr %v142.p
  %st56 = getelementptr i64, ptr %v10, i64 0
  store i64 %v142, ptr %st56
  br label %b48
b47:
  %v143.p = getelementptr i64, ptr %v6, i64 0
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 %v143, %v137
  %st57 = getelementptr i64, ptr %v6, i64 0
  store i64 %v144, ptr %st57
  br label %b48
b48:
  br label %b1
}

define internal i64 @"std/utf8.validPrefix"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v2, ptr %st2
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v6, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v7 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v5, ptr %st3
  ret i64 %v3
}

define internal i64 @"std/utf8.seqLen"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v2, ptr %st2
  %v111 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v111, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6.p = getelementptr i64, ptr %v4, i64 1
  %v6 = load i64, ptr %v6.p
  %v7.c = icmp uge i64 %v3, %v6
  %v7 = zext i1 %v7.c to i64
  %c.b0 = icmp ne i64 %v7, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v8 = add i64 0, 19
  call void @"rt.panic"(i64 %v8)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v9.p = getelementptr i64, ptr %v4, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = inttoptr i64 %v9 to ptr
  %v11 = getelementptr i8, ptr %v10, i64 %v3
  %v12.p = getelementptr i8, ptr %v11, i64 0
  %v12.b = load i8, ptr %v12.p
  %v12 = zext i8 %v12.b to i64
  %v13 = add i64 0, 0
  %v14.c = icmp sge i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b2 = icmp ne i64 %v14, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b3
b2.e7:
  br label %b4
b3:
  %v16 = add i64 0, 128
  %v17.c = icmp slt i64 %v12, %v16
  %v17 = zext i1 %v17.c to i64
  br label %b4
b4:
  %v15 = phi i64 [ %v14, %b2.e7 ], [ %v17, %b3 ]
  %c.b4 = icmp ne i64 %v15, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b5
b4.e9:
  br label %b6
b5:
  %v18 = add i64 0, 1
  %v112 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v112, i64 0
  store i64 %v5, ptr %st9
  ret i64 %v18
b6:
  br label %b7
b7:
  %v19 = add i64 0, 194
  %v20.c = icmp sge i64 %v12, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b7 = icmp ne i64 %v20, 0
  br i1 %c.b7, label %b7.t11, label %b7.e12
b7.t11:
  br label %b8
b7.e12:
  br label %b9
b8:
  %v22 = add i64 0, 223
  %v23.c = icmp sle i64 %v12, %v22
  %v23 = zext i1 %v23.c to i64
  br label %b9
b9:
  %v21 = phi i64 [ %v20, %b7.e12 ], [ %v23, %b8 ]
  %c.b9 = icmp ne i64 %v21, 0
  br i1 %c.b9, label %b9.t13, label %b9.e14
b9.t13:
  br label %b10
b9.e14:
  br label %b11
b10:
  %v24.p = getelementptr i64, ptr %v4, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v4, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v4, i64 2
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 1
  %v28 = add i64 %v3, %v27
  %v29 = add i64 0, 128
  %v30 = add i64 0, 191
  %v31 = call i64 @"std/utf8.cont"(i64 %v24, i64 %v25, i64 %v26, i64 %v28, i64 %v29, i64 %v30)
  %c.b10 = icmp ne i64 %v31, 0
  br i1 %c.b10, label %b10.t15, label %b10.e16
b10.t15:
  br label %b12
b10.e16:
  br label %b13
b11:
  br label %b15
b12:
  %v32 = add i64 0, 2
  br label %b14
b13:
  %v33 = add i64 0, 0
  br label %b14
b14:
  %v34 = phi i64 [ %v32, %b12 ], [ %v33, %b13 ]
  %v113 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v113, i64 0
  store i64 %v5, ptr %st16
  ret i64 %v34
b15:
  %v35 = add i64 0, 224
  %v36.c = icmp sge i64 %v12, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b15 = icmp ne i64 %v36, 0
  br i1 %c.b15, label %b15.t18, label %b15.e19
b15.t18:
  br label %b16
b15.e19:
  br label %b17
b16:
  %v38 = add i64 0, 239
  %v39.c = icmp sle i64 %v12, %v38
  %v39 = zext i1 %v39.c to i64
  br label %b17
b17:
  %v37 = phi i64 [ %v36, %b15.e19 ], [ %v39, %b16 ]
  %c.b17 = icmp ne i64 %v37, 0
  br i1 %c.b17, label %b17.t20, label %b17.e21
b17.t20:
  br label %b18
b17.e21:
  br label %b19
b18:
  %v40 = add i64 0, 224
  %v41.c = icmp eq i64 %v12, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b18 = icmp ne i64 %v41, 0
  br i1 %c.b18, label %b18.t22, label %b18.e23
b18.t22:
  br label %b20
b18.e23:
  br label %b21
b19:
  br label %b31
b20:
  %v42 = add i64 0, 160
  br label %b22
b21:
  %v43 = add i64 0, 128
  br label %b22
b22:
  %v44 = phi i64 [ %v42, %b20 ], [ %v43, %b21 ]
  %v45 = add i64 0, 237
  %v46.c = icmp eq i64 %v12, %v45
  %v46 = zext i1 %v46.c to i64
  %c.b22 = icmp ne i64 %v46, 0
  br i1 %c.b22, label %b22.t24, label %b22.e25
b22.t24:
  br label %b23
b22.e25:
  br label %b24
b23:
  %v47 = add i64 0, 159
  br label %b25
b24:
  %v48 = add i64 0, 191
  br label %b25
b25:
  %v49 = phi i64 [ %v47, %b23 ], [ %v48, %b24 ]
  %v50.p = getelementptr i64, ptr %v4, i64 0
  %v50 = load i64, ptr %v50.p
  %v51.p = getelementptr i64, ptr %v4, i64 1
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v4, i64 2
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 1
  %v54 = add i64 %v3, %v53
  %v55 = call i64 @"std/utf8.cont"(i64 %v50, i64 %v51, i64 %v52, i64 %v54, i64 %v44, i64 %v49)
  %c.b25 = icmp ne i64 %v55, 0
  br i1 %c.b25, label %b25.t26, label %b25.e27
b25.t26:
  br label %b26
b25.e27:
  br label %b27
b26:
  %v57.p = getelementptr i64, ptr %v4, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v4, i64 1
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v4, i64 2
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 2
  %v61 = add i64 %v3, %v60
  %v62 = add i64 0, 128
  %v63 = add i64 0, 191
  %v64 = call i64 @"std/utf8.cont"(i64 %v57, i64 %v58, i64 %v59, i64 %v61, i64 %v62, i64 %v63)
  br label %b27
b27:
  %v56 = phi i64 [ %v55, %b25.e27 ], [ %v64, %b26 ]
  %c.b27 = icmp ne i64 %v56, 0
  br i1 %c.b27, label %b27.t28, label %b27.e29
b27.t28:
  br label %b28
b27.e29:
  br label %b29
b28:
  %v65 = add i64 0, 3
  br label %b30
b29:
  %v66 = add i64 0, 0
  br label %b30
b30:
  %v67 = phi i64 [ %v65, %b28 ], [ %v66, %b29 ]
  %v114 = getelementptr i64, ptr @"rt.meta", i64 0
  %st29 = getelementptr i64, ptr %v114, i64 0
  store i64 %v5, ptr %st29
  ret i64 %v67
b31:
  %v68 = add i64 0, 240
  %v69.c = icmp sge i64 %v12, %v68
  %v69 = zext i1 %v69.c to i64
  %c.b31 = icmp ne i64 %v69, 0
  br i1 %c.b31, label %b31.t31, label %b31.e32
b31.t31:
  br label %b32
b31.e32:
  br label %b33
b32:
  %v71 = add i64 0, 244
  %v72.c = icmp sle i64 %v12, %v71
  %v72 = zext i1 %v72.c to i64
  br label %b33
b33:
  %v70 = phi i64 [ %v69, %b31.e32 ], [ %v72, %b32 ]
  %c.b33 = icmp ne i64 %v70, 0
  br i1 %c.b33, label %b33.t33, label %b33.e34
b33.t33:
  br label %b34
b33.e34:
  br label %b35
b34:
  %v73 = add i64 0, 240
  %v74.c = icmp eq i64 %v12, %v73
  %v74 = zext i1 %v74.c to i64
  %c.b34 = icmp ne i64 %v74, 0
  br i1 %c.b34, label %b34.t35, label %b34.e36
b34.t35:
  br label %b36
b34.e36:
  br label %b37
b35:
  br label %b49
b36:
  %v75 = add i64 0, 144
  br label %b38
b37:
  %v76 = add i64 0, 128
  br label %b38
b38:
  %v77 = phi i64 [ %v75, %b36 ], [ %v76, %b37 ]
  %v78 = add i64 0, 244
  %v79.c = icmp eq i64 %v12, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b38 = icmp ne i64 %v79, 0
  br i1 %c.b38, label %b38.t37, label %b38.e38
b38.t37:
  br label %b39
b38.e38:
  br label %b40
b39:
  %v80 = add i64 0, 143
  br label %b41
b40:
  %v81 = add i64 0, 191
  br label %b41
b41:
  %v82 = phi i64 [ %v80, %b39 ], [ %v81, %b40 ]
  %v83.p = getelementptr i64, ptr %v4, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v4, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v4, i64 2
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 0, 1
  %v87 = add i64 %v3, %v86
  %v88 = call i64 @"std/utf8.cont"(i64 %v83, i64 %v84, i64 %v85, i64 %v87, i64 %v77, i64 %v82)
  %c.b41 = icmp ne i64 %v88, 0
  br i1 %c.b41, label %b41.t39, label %b41.e40
b41.t39:
  br label %b42
b41.e40:
  br label %b43
b42:
  %v90.p = getelementptr i64, ptr %v4, i64 0
  %v90 = load i64, ptr %v90.p
  %v91.p = getelementptr i64, ptr %v4, i64 1
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v4, i64 2
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 2
  %v94 = add i64 %v3, %v93
  %v95 = add i64 0, 128
  %v96 = add i64 0, 191
  %v97 = call i64 @"std/utf8.cont"(i64 %v90, i64 %v91, i64 %v92, i64 %v94, i64 %v95, i64 %v96)
  br label %b43
b43:
  %v89 = phi i64 [ %v88, %b41.e40 ], [ %v97, %b42 ]
  %c.b43 = icmp ne i64 %v89, 0
  br i1 %c.b43, label %b43.t41, label %b43.e42
b43.t41:
  br label %b44
b43.e42:
  br label %b45
b44:
  %v99.p = getelementptr i64, ptr %v4, i64 0
  %v99 = load i64, ptr %v99.p
  %v100.p = getelementptr i64, ptr %v4, i64 1
  %v100 = load i64, ptr %v100.p
  %v101.p = getelementptr i64, ptr %v4, i64 2
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 3
  %v103 = add i64 %v3, %v102
  %v104 = add i64 0, 128
  %v105 = add i64 0, 191
  %v106 = call i64 @"std/utf8.cont"(i64 %v99, i64 %v100, i64 %v101, i64 %v103, i64 %v104, i64 %v105)
  br label %b45
b45:
  %v98 = phi i64 [ %v89, %b43.e42 ], [ %v106, %b44 ]
  %c.b45 = icmp ne i64 %v98, 0
  br i1 %c.b45, label %b45.t43, label %b45.e44
b45.t43:
  br label %b46
b45.e44:
  br label %b47
b46:
  %v107 = add i64 0, 4
  br label %b48
b47:
  %v108 = add i64 0, 0
  br label %b48
b48:
  %v109 = phi i64 [ %v107, %b46 ], [ %v108, %b47 ]
  %v115 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v115, i64 0
  store i64 %v5, ptr %st44
  ret i64 %v109
b49:
  %v110 = add i64 0, 0
  %v116 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v116, i64 0
  store i64 %v5, ptr %st45
  ret i64 %v110
}

define internal i64 @"std/utf8.cont"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v28, i64 0
  %v7 = load i64, ptr %v7.p
  call void @"rt.region_enter"()
  %v8.p = getelementptr i64, ptr %v6, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.c = icmp slt i64 %v3, %v8
  %v9 = zext i1 %v9.c to i64
  %c.b0 = icmp ne i64 %v9, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp uge i64 %v3, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t6, label %b1.e7
b1.t6:
  br label %b3
b1.e7:
  br label %b4
b2:
  %v10 = phi i64 [ %v9, %b0.e5 ], [ %v18, %b4 ]
  %c.b2 = icmp ne i64 %v10, 0
  br i1 %c.b2, label %b2.t8, label %b2.e9
b2.t8:
  br label %b5
b2.e9:
  br label %b6
b3:
  %v13 = add i64 0, 20
  call void @"rt.panic"(i64 %v13)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v14.p = getelementptr i64, ptr %v6, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = inttoptr i64 %v14 to ptr
  %v16 = getelementptr i8, ptr %v15, i64 %v3
  %v17.p = getelementptr i8, ptr %v16, i64 0
  %v17.b = load i8, ptr %v17.p
  %v17 = zext i8 %v17.b to i64
  %v18.c = icmp sge i64 %v17, %v4
  %v18 = zext i1 %v18.c to i64
  br label %b2
b5:
  %v20.p = getelementptr i64, ptr %v6, i64 1
  %v20 = load i64, ptr %v20.p
  %v21.c = icmp uge i64 %v3, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b5 = icmp ne i64 %v21, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  %v19 = phi i64 [ %v10, %b2.e9 ], [ %v27, %b8 ]
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v29, i64 0
  store i64 %v7, ptr %st11
  ret i64 %v19
b7:
  %v22 = add i64 0, 21
  call void @"rt.panic"(i64 %v22)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v23.p = getelementptr i64, ptr %v6, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = inttoptr i64 %v23 to ptr
  %v25 = getelementptr i8, ptr %v24, i64 %v3
  %v26.p = getelementptr i8, ptr %v25, i64 0
  %v26.b = load i8, ptr %v26.p
  %v26 = zext i8 %v26.b to i64
  %v27.c = icmp sle i64 %v26, %v5
  %v27 = zext i1 %v27.c to i64
  br label %b6
}

define internal void @"std/strings.utoa"(ptr %v0, i64 %v1) #0 {
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
  %v25 = add i64 0, 26
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
  %v69 = add i64 0, 27
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
  %v125 = add i64 0, 28
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
