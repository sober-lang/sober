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
@"str.29" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.30" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.31" = internal constant [1 x i64] [i64 2685]
@"str.32" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.33" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.34" = internal constant [1 x i64] [i64 35899498962976]
@"str.35" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.36" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [30 x i64] [i64 3659174932119553, i64 3659174932119553, i64 8162775364796673, i64 10977525131903233, i64 9570155382178305, i64 12384905266725377, i64 11259005460546050, i64 11259005460546050, i64 11259005460546050, i64 15199655168049666, i64 15199655168049666, i64 15199655168049666, i64 3659174932119553, i64 3659174932119553, i64 8444256448414465, i64 5348031838814977, i64 16607030924018433, i64 19984730711655169, i64 28428980012974849, i64 4222131327992577, i64 8725730871476993, i64 14073755428979457, i64 6473931141677569, i64 4785081298190850, i64 4785081298190850, i64 4785081298190850, i64 7599827491750915, i64 8725727448925187, i64 8444252572877825, i64 3659174932119553]
@"str.37" = internal constant [1 x i64] [i64 9071397899755888]
@"str.38" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.39" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.40" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.41" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.42" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.43" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.44" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.45" = internal constant [1 x i64] [i64 544497952]
@"str.46" = internal constant [3 x i64] [i64 8243122688087061619, i64 8030813629395003695, i64 7497058]
@"str.47" = internal constant [2 x i64] [i64 7741253900700708713, i64 32199620796034675]
@"str.48" = internal constant [2 x i64] [i64 7579399195445195891, i64 32199620796034671]
@"str.49" = internal constant [4 x i64] [i64 7598263559392621683, i64 7598263559393601390, i64 7305524086039603054, i64 114]
@"str.50" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]

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
  %v29 = getelementptr i64, ptr @"str.30", i64 0
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
  %v35 = getelementptr i64, ptr @"str.31", i64 0
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
  %v24 = getelementptr i64, ptr @"str.29", i64 0
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
  %v60 = getelementptr i64, ptr @"str.32", i64 0
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
  %v65 = getelementptr i64, ptr @"str.33", i64 0
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
  %v70 = getelementptr i64, ptr @"str.31", i64 0
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
  %v81 = getelementptr i64, ptr @"str.34", i64 0
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
  %v88 = getelementptr i64, ptr @"str.35", i64 0
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
  %v17 = getelementptr i64, ptr @"str.36", i64 0
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
  %v22 = getelementptr i64, ptr @"str.31", i64 0
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
  call void @"std/convert.FormatInt"(ptr %v129, i64 %v83)
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
  call void @"std/convert.FormatInt"(ptr %v161, i64 %v84)
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
  call void @"std/convert.FormatInt"(ptr %v193, i64 %v85)
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
  call void @"std/convert.FormatInt"(ptr %v332, i64 %v304)
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
  call void @"std/convert.FormatInt"(ptr %v364, i64 %v305)
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
  call void @"std/convert.FormatInt"(ptr %v493, i64 %v469)
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
  call void @"std/convert.FormatInt"(ptr %v525, i64 %v475)
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
  call void @"std/convert.FormatInt"(ptr %v593, i64 %v469)
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
  call void @"std/convert.FormatInt"(ptr %v556, i64 %v469)
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
  %v20 = getelementptr i64, ptr @"str.37", i64 0
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
  %v74 = getelementptr i64, ptr @"str.45", i64 0
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
  %v27 = getelementptr i64, ptr @"str.38", i64 0
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
  %v34 = getelementptr i64, ptr @"str.39", i64 0
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
  %v41 = getelementptr i64, ptr @"str.40", i64 0
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
  %v48 = getelementptr i64, ptr @"str.41", i64 0
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
  %v55 = getelementptr i64, ptr @"str.42", i64 0
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
  %v62 = getelementptr i64, ptr @"str.43", i64 0
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
  %v69 = getelementptr i64, ptr @"str.44", i64 0
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
  %v81 = getelementptr i64, ptr @"str.46", i64 0
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
  %v88 = getelementptr i64, ptr @"str.47", i64 0
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
  %v95 = getelementptr i64, ptr @"str.48", i64 0
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
  %v102 = getelementptr i64, ptr @"str.49", i64 0
  %v103 = add i64 0, 25
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
  %v109 = getelementptr i64, ptr @"str.50", i64 0
  %v110 = add i64 0, 22
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
  %s15 = alloca [5 x i64], align 8
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
  %s24 = alloca [1 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s25 = alloca [1 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v249 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v249, i64 0
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
  %v250 = getelementptr i64, ptr @"rt.meta", i64 0
  %v35.p = getelementptr i64, ptr %v250, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = getelementptr i64, ptr %s6, i64 0
  %v37.p = getelementptr i64, ptr %v27, i64 0
  %v37 = load i64, ptr %v37.p
  %st20 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st20
  %v38 = getelementptr i64, ptr %s7, i64 0
  %v251 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v251, i64 0
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
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v252, i64 0
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v40, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 0, 65536
  %v49 = add i64 0, 2
  %v50 = call i64 @"rt.chunk_open"(i64 %v47, i64 %v48, i64 %v49, i64 %v44)
  %v253 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v253, i64 0
  %v51 = load i64, ptr %v51.p
  br label %b8
b3:
  %v25 = add i64 0, 6
  %v26 = getelementptr i64, ptr %v0, i64 %v25
  %v254 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v26, i64 %v254, i64 %v5)
  br label %b4
b4:
  %v255 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v255, i64 0
  store i64 %v5, ptr %st22
  ret void
b5:
  %v256 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v256, i64 0
  store i64 %v35, ptr %st23
  %v232.p = getelementptr i64, ptr %v30, i64 0
  %v232 = load i64, ptr %v232.p
  %v233.p = getelementptr i64, ptr %v32, i64 0
  %v233 = load i64, ptr %v233.p
  %v234.p = getelementptr i64, ptr %v34, i64 0
  %v234 = load i64, ptr %v234.p
  %v235 = getelementptr i64, ptr %s12, i64 0
  %v236 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v235, i64 0
  store i64 %v236, ptr %st24
  %st25 = getelementptr i64, ptr %v0, i64 0
  store i64 %v232, ptr %st25
  %st26 = getelementptr i64, ptr %v0, i64 1
  store i64 %v233, ptr %st26
  %st27 = getelementptr i64, ptr %v0, i64 2
  store i64 %v234, ptr %st27
  %v237.p = getelementptr i64, ptr %v235, i64 0
  %v237 = load i64, ptr %v237.p
  %st28 = getelementptr i64, ptr %v0, i64 3
  store i64 %v237, ptr %st28
  %v238.p = getelementptr i64, ptr %v235, i64 1
  %v238 = load i64, ptr %v238.p
  %st29 = getelementptr i64, ptr %v0, i64 4
  store i64 %v238, ptr %st29
  %v239.p = getelementptr i64, ptr %v235, i64 2
  %v239 = load i64, ptr %v239.p
  %st30 = getelementptr i64, ptr %v0, i64 5
  store i64 %v239, ptr %st30
  %v240.p = getelementptr i64, ptr %v235, i64 3
  %v240 = load i64, ptr %v240.p
  %st31 = getelementptr i64, ptr %v0, i64 6
  store i64 %v240, ptr %st31
  %v241.p = getelementptr i64, ptr %v235, i64 4
  %v241 = load i64, ptr %v241.p
  %st32 = getelementptr i64, ptr %v0, i64 7
  store i64 %v241, ptr %st32
  %v242.p = getelementptr i64, ptr %v235, i64 5
  %v242 = load i64, ptr %v242.p
  %st33 = getelementptr i64, ptr %v0, i64 8
  store i64 %v242, ptr %st33
  %v243.p = getelementptr i64, ptr %v27, i64 0
  %v243 = load i64, ptr %v243.p
  call void @"std/io.Close"(i64 %v243)
  %v244.p = getelementptr i64, ptr %v0, i64 3
  %v244 = load i64, ptr %v244.p
  %v245 = add i64 0, 0
  %v246.c = icmp ne i64 %v244, %v245
  %v246 = zext i1 %v246.c to i64
  %c.b5 = icmp ne i64 %v246, 0
  br i1 %c.b5, label %b5.t35, label %b5.e36
b5.t35:
  br label %b46
b5.e36:
  br label %b47
b6:
  %v216.p = getelementptr i64, ptr %v38, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 0
  %v218.c = icmp ne i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b6 = icmp ne i64 %v218, 0
  br i1 %c.b6, label %b6.t37, label %b6.e38
b6.t37:
  br label %b42
b6.e38:
  br label %b43
b7:
  %v205.p = getelementptr i64, ptr %v45, i64 0
  %v205 = load i64, ptr %v205.p
  %st38 = getelementptr i64, ptr %v38, i64 0
  store i64 %v205, ptr %st38
  %v206.p = getelementptr i64, ptr %v45, i64 1
  %v206 = load i64, ptr %v206.p
  %st39 = getelementptr i64, ptr %v38, i64 1
  store i64 %v206, ptr %st39
  %v207.p = getelementptr i64, ptr %v45, i64 2
  %v207 = load i64, ptr %v207.p
  %st40 = getelementptr i64, ptr %v38, i64 2
  store i64 %v207, ptr %st40
  %v208.p = getelementptr i64, ptr %v45, i64 3
  %v208 = load i64, ptr %v208.p
  %st41 = getelementptr i64, ptr %v38, i64 3
  store i64 %v208, ptr %st41
  %v209.p = getelementptr i64, ptr %v45, i64 4
  %v209 = load i64, ptr %v209.p
  %st42 = getelementptr i64, ptr %v38, i64 4
  store i64 %v209, ptr %st42
  %v210.p = getelementptr i64, ptr %v45, i64 5
  %v210 = load i64, ptr %v210.p
  %st43 = getelementptr i64, ptr %v38, i64 5
  store i64 %v210, ptr %st43
  %v211.p = getelementptr i64, ptr %v38, i64 0
  %v211 = load i64, ptr %v211.p
  %v212 = add i64 0, 0
  %v213.c = icmp ne i64 %v211, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b7 = icmp ne i64 %v213, 0
  br i1 %c.b7, label %b7.t45, label %b7.e46
b7.t45:
  br label %b40
b7.e46:
  br label %b41
b8:
  %v257 = getelementptr i64, ptr @"rt.meta", i64 0
  %st46 = getelementptr i64, ptr %v257, i64 0
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
  %v258 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v258, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 0
  %v55 = add i64 0, 0
  %v56.c = icmp ne i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b9 = icmp ne i64 %v56, 0
  br i1 %c.b9, label %b9.t50, label %b9.e51
b9.t50:
  br label %b11
b9.e51:
  br label %b12
b10:
  %v259 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v259, i64 0
  store i64 %v51, ptr %st51
  %v192 = getelementptr i64, ptr %s12, i64 0
  %v193 = add i64 0, 0
  %st52 = getelementptr i64, ptr %v192, i64 0
  store i64 %v193, ptr %st52
  %v194.p = getelementptr i64, ptr %v192, i64 0
  %v194 = load i64, ptr %v194.p
  %st53 = getelementptr i64, ptr %v45, i64 0
  store i64 %v194, ptr %st53
  %v195.p = getelementptr i64, ptr %v192, i64 1
  %v195 = load i64, ptr %v195.p
  %st54 = getelementptr i64, ptr %v45, i64 1
  store i64 %v195, ptr %st54
  %v196.p = getelementptr i64, ptr %v192, i64 2
  %v196 = load i64, ptr %v196.p
  %st55 = getelementptr i64, ptr %v45, i64 2
  store i64 %v196, ptr %st55
  %v197.p = getelementptr i64, ptr %v192, i64 3
  %v197 = load i64, ptr %v197.p
  %st56 = getelementptr i64, ptr %v45, i64 3
  store i64 %v197, ptr %st56
  %v198.p = getelementptr i64, ptr %v192, i64 4
  %v198 = load i64, ptr %v198.p
  %st57 = getelementptr i64, ptr %v45, i64 4
  store i64 %v198, ptr %st57
  %v199.p = getelementptr i64, ptr %v192, i64 5
  %v199 = load i64, ptr %v199.p
  %st58 = getelementptr i64, ptr %v45, i64 5
  store i64 %v199, ptr %st58
  call void @"std/io.chunkEnd"(i64 %v50)
  %v200.p = getelementptr i64, ptr %v45, i64 0
  %v200 = load i64, ptr %v200.p
  %v201 = add i64 0, 0
  %v202.c = icmp ne i64 %v200, %v201
  %v202 = zext i1 %v202.c to i64
  %c.b10 = icmp ne i64 %v202, 0
  br i1 %c.b10, label %b10.t60, label %b10.e61
b10.t60:
  br label %b38
b10.e61:
  br label %b39
b11:
  %v57 = getelementptr i64, ptr %s10, i64 0
  %v58 = add i64 0, 0
  %st61 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st61
  %st62 = getelementptr i64, ptr %v57, i64 1
  store i64 %v58, ptr %st62
  %v59 = add i64 0, 4
  %st63 = getelementptr i64, ptr %v57, i64 0
  store i64 %v59, ptr %st63
  %v60 = getelementptr i64, ptr %s11, i64 0
  %v61.p = getelementptr i64, ptr %v57, i64 0
  %v61 = load i64, ptr %v61.p
  %st64 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st64
  %v62.p = getelementptr i64, ptr %v57, i64 1
  %v62 = load i64, ptr %v62.p
  %st65 = getelementptr i64, ptr %v60, i64 1
  store i64 %v62, ptr %st65
  %v63 = add i64 0, 0
  %st66 = getelementptr i64, ptr %v60, i64 2
  store i64 %v63, ptr %st66
  %st67 = getelementptr i64, ptr %v60, i64 3
  store i64 %v63, ptr %st67
  %st68 = getelementptr i64, ptr %v60, i64 4
  store i64 %v63, ptr %st68
  %v64 = getelementptr i64, ptr %s12, i64 0
  %v65 = add i64 0, 1
  %st69 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st69
  %v66.p = getelementptr i64, ptr %v60, i64 0
  %v66 = load i64, ptr %v66.p
  %st70 = getelementptr i64, ptr %v64, i64 1
  store i64 %v66, ptr %st70
  %v67.p = getelementptr i64, ptr %v60, i64 1
  %v67 = load i64, ptr %v67.p
  %st71 = getelementptr i64, ptr %v64, i64 2
  store i64 %v67, ptr %st71
  %v68.p = getelementptr i64, ptr %v60, i64 2
  %v68 = load i64, ptr %v68.p
  %st72 = getelementptr i64, ptr %v64, i64 3
  store i64 %v68, ptr %st72
  %v69.p = getelementptr i64, ptr %v60, i64 3
  %v69 = load i64, ptr %v69.p
  %st73 = getelementptr i64, ptr %v64, i64 4
  store i64 %v69, ptr %st73
  %v70.p = getelementptr i64, ptr %v60, i64 4
  %v70 = load i64, ptr %v70.p
  %st74 = getelementptr i64, ptr %v64, i64 5
  store i64 %v70, ptr %st74
  %v71.p = getelementptr i64, ptr %v64, i64 0
  %v71 = load i64, ptr %v71.p
  %st75 = getelementptr i64, ptr %v45, i64 0
  store i64 %v71, ptr %st75
  %v72.p = getelementptr i64, ptr %v64, i64 1
  %v72 = load i64, ptr %v72.p
  %st76 = getelementptr i64, ptr %v45, i64 1
  store i64 %v72, ptr %st76
  %v73.p = getelementptr i64, ptr %v64, i64 2
  %v73 = load i64, ptr %v73.p
  %st77 = getelementptr i64, ptr %v45, i64 2
  store i64 %v73, ptr %st77
  %v74.p = getelementptr i64, ptr %v64, i64 3
  %v74 = load i64, ptr %v74.p
  %st78 = getelementptr i64, ptr %v45, i64 3
  store i64 %v74, ptr %st78
  %v75.p = getelementptr i64, ptr %v64, i64 4
  %v75 = load i64, ptr %v75.p
  %st79 = getelementptr i64, ptr %v45, i64 4
  store i64 %v75, ptr %st79
  %v76.p = getelementptr i64, ptr %v64, i64 5
  %v76 = load i64, ptr %v76.p
  %st80 = getelementptr i64, ptr %v45, i64 5
  store i64 %v76, ptr %st80
  call void @"std/io.chunkEnd"(i64 %v50)
  %v77.p = getelementptr i64, ptr %v45, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79.c = icmp ne i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b11 = icmp ne i64 %v79, 0
  br i1 %c.b11, label %b11.t82, label %b11.e83
b11.t82:
  br label %b13
b11.e83:
  br label %b14
b12:
  br label %b15
b13:
  %v80 = add i64 0, 3
  %v81 = getelementptr i64, ptr %v45, i64 %v80
  %v260 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v81, i64 %v260, i64 %v46)
  br label %b14
b14:
  %v261 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v261, i64 0
  store i64 %v46, ptr %st83
  br label %b7
b15:
  %v82 = getelementptr i64, ptr %s13, i64 0
  call void @"rt.chunk_next"(i64 %v50, ptr %v82)
  %v83 = getelementptr i64, ptr %s14, i64 0
  %v84.p = getelementptr i64, ptr %v82, i64 0
  %v84 = load i64, ptr %v84.p
  %st84 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st84
  %v85.p = getelementptr i64, ptr %v82, i64 1
  %v85 = load i64, ptr %v85.p
  %st85 = getelementptr i64, ptr %v83, i64 1
  store i64 %v85, ptr %st85
  %v86.p = getelementptr i64, ptr %v82, i64 2
  %v86 = load i64, ptr %v86.p
  %st86 = getelementptr i64, ptr %v83, i64 2
  store i64 %v86, ptr %st86
  %v87.p = getelementptr i64, ptr %v83, i64 1
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 0, 0
  %v89.c = icmp eq i64 %v87, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b15 = icmp ne i64 %v89, 0
  br i1 %c.b15, label %b15.t88, label %b15.e89
b15.t88:
  br label %b16
b15.e89:
  br label %b17
b16:
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %v91.p = getelementptr i64, ptr %v90, i64 1027
  %v91 = load i64, ptr %v91.p
  %v92 = add i64 0, 0
  %v93.c = icmp ne i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b16 = icmp ne i64 %v93, 0
  br i1 %c.b16, label %b16.t90, label %b16.e91
b16.t90:
  br label %b18
b16.e91:
  br label %b19
b17:
  br label %b25
b18:
  %v94 = getelementptr i64, ptr %s15, i64 0
  call void @"std/io.errOf"(ptr %v94, i64 %v91)
  %v95 = getelementptr i64, ptr %s12, i64 0
  %v96 = add i64 0, 1
  %st91 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st91
  %v97.p = getelementptr i64, ptr %v94, i64 0
  %v97 = load i64, ptr %v97.p
  %st92 = getelementptr i64, ptr %v95, i64 1
  store i64 %v97, ptr %st92
  %v98.p = getelementptr i64, ptr %v94, i64 1
  %v98 = load i64, ptr %v98.p
  %st93 = getelementptr i64, ptr %v95, i64 2
  store i64 %v98, ptr %st93
  %v99.p = getelementptr i64, ptr %v94, i64 2
  %v99 = load i64, ptr %v99.p
  %st94 = getelementptr i64, ptr %v95, i64 3
  store i64 %v99, ptr %st94
  %v100.p = getelementptr i64, ptr %v94, i64 3
  %v100 = load i64, ptr %v100.p
  %st95 = getelementptr i64, ptr %v95, i64 4
  store i64 %v100, ptr %st95
  %v101.p = getelementptr i64, ptr %v94, i64 4
  %v101 = load i64, ptr %v101.p
  %st96 = getelementptr i64, ptr %v95, i64 5
  store i64 %v101, ptr %st96
  %v102.p = getelementptr i64, ptr %v95, i64 0
  %v102 = load i64, ptr %v102.p
  %st97 = getelementptr i64, ptr %v45, i64 0
  store i64 %v102, ptr %st97
  %v103.p = getelementptr i64, ptr %v95, i64 1
  %v103 = load i64, ptr %v103.p
  %st98 = getelementptr i64, ptr %v45, i64 1
  store i64 %v103, ptr %st98
  %v104.p = getelementptr i64, ptr %v95, i64 2
  %v104 = load i64, ptr %v104.p
  %st99 = getelementptr i64, ptr %v45, i64 2
  store i64 %v104, ptr %st99
  %v105.p = getelementptr i64, ptr %v95, i64 3
  %v105 = load i64, ptr %v105.p
  %st100 = getelementptr i64, ptr %v45, i64 3
  store i64 %v105, ptr %st100
  %v106.p = getelementptr i64, ptr %v95, i64 4
  %v106 = load i64, ptr %v106.p
  %st101 = getelementptr i64, ptr %v45, i64 4
  store i64 %v106, ptr %st101
  %v107.p = getelementptr i64, ptr %v95, i64 5
  %v107 = load i64, ptr %v107.p
  %st102 = getelementptr i64, ptr %v45, i64 5
  store i64 %v107, ptr %st102
  call void @"std/io.chunkEnd"(i64 %v50)
  %v108.p = getelementptr i64, ptr %v45, i64 0
  %v108 = load i64, ptr %v108.p
  %v109 = add i64 0, 0
  %v110.c = icmp ne i64 %v108, %v109
  %v110 = zext i1 %v110.c to i64
  %c.b18 = icmp ne i64 %v110, 0
  br i1 %c.b18, label %b18.t104, label %b18.e105
b18.t104:
  br label %b20
b18.e105:
  br label %b21
b19:
  br label %b22
b20:
  %v111 = add i64 0, 3
  %v112 = getelementptr i64, ptr %v45, i64 %v111
  %v262 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v112, i64 %v262, i64 %v46)
  br label %b21
b21:
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %st105 = getelementptr i64, ptr %v263, i64 0
  store i64 %v46, ptr %st105
  br label %b7
b22:
  %v113 = getelementptr i64, ptr %s12, i64 0
  %v114 = add i64 0, 0
  %st106 = getelementptr i64, ptr %v113, i64 0
  store i64 %v114, ptr %st106
  %v115.p = getelementptr i64, ptr %v113, i64 0
  %v115 = load i64, ptr %v115.p
  %st107 = getelementptr i64, ptr %v45, i64 0
  store i64 %v115, ptr %st107
  %v116.p = getelementptr i64, ptr %v113, i64 1
  %v116 = load i64, ptr %v116.p
  %st108 = getelementptr i64, ptr %v45, i64 1
  store i64 %v116, ptr %st108
  %v117.p = getelementptr i64, ptr %v113, i64 2
  %v117 = load i64, ptr %v117.p
  %st109 = getelementptr i64, ptr %v45, i64 2
  store i64 %v117, ptr %st109
  %v118.p = getelementptr i64, ptr %v113, i64 3
  %v118 = load i64, ptr %v118.p
  %st110 = getelementptr i64, ptr %v45, i64 3
  store i64 %v118, ptr %st110
  %v119.p = getelementptr i64, ptr %v113, i64 4
  %v119 = load i64, ptr %v119.p
  %st111 = getelementptr i64, ptr %v45, i64 4
  store i64 %v119, ptr %st111
  %v120.p = getelementptr i64, ptr %v113, i64 5
  %v120 = load i64, ptr %v120.p
  %st112 = getelementptr i64, ptr %v45, i64 5
  store i64 %v120, ptr %st112
  call void @"std/io.chunkEnd"(i64 %v50)
  %v121.p = getelementptr i64, ptr %v45, i64 0
  %v121 = load i64, ptr %v121.p
  %v122 = add i64 0, 0
  %v123.c = icmp ne i64 %v121, %v122
  %v123 = zext i1 %v123.c to i64
  %c.b22 = icmp ne i64 %v123, 0
  br i1 %c.b22, label %b22.t114, label %b22.e115
b22.t114:
  br label %b23
b22.e115:
  br label %b24
b23:
  %v124 = add i64 0, 3
  %v125 = getelementptr i64, ptr %v45, i64 %v124
  %v264 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v125, i64 %v264, i64 %v46)
  br label %b24
b24:
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %st115 = getelementptr i64, ptr %v265, i64 0
  store i64 %v46, ptr %st115
  br label %b7
b25:
  %v126 = getelementptr i64, ptr %s13, i64 0
  %v127.p = getelementptr i64, ptr %v83, i64 0
  %v127 = load i64, ptr %v127.p
  %st116 = getelementptr i64, ptr %v126, i64 0
  store i64 %v127, ptr %st116
  %v128.p = getelementptr i64, ptr %v83, i64 1
  %v128 = load i64, ptr %v128.p
  %st117 = getelementptr i64, ptr %v126, i64 1
  store i64 %v128, ptr %st117
  %v129.p = getelementptr i64, ptr %v83, i64 2
  %v129 = load i64, ptr %v129.p
  %st118 = getelementptr i64, ptr %v126, i64 2
  store i64 %v129, ptr %st118
  %v130 = getelementptr i64, ptr %s16, i64 0
  %v131 = add i64 0, 0
  %v132 = getelementptr i64, ptr %s17, i64 0
  %v133 = getelementptr i64, ptr %s18, i64 0
  %v134 = add i64 0, 0
  %st119 = getelementptr i64, ptr %v133, i64 0
  store i64 %v134, ptr %st119
  %st120 = getelementptr i64, ptr %v133, i64 1
  store i64 %v134, ptr %st120
  %st121 = getelementptr i64, ptr %v133, i64 2
  store i64 %v134, ptr %st121
  %v135.p = getelementptr i64, ptr %v126, i64 0
  %v135 = load i64, ptr %v135.p
  %st122 = getelementptr i64, ptr %v133, i64 0
  store i64 %v135, ptr %st122
  %v136.p = getelementptr i64, ptr %v126, i64 1
  %v136 = load i64, ptr %v136.p
  %st123 = getelementptr i64, ptr %v133, i64 1
  store i64 %v136, ptr %st123
  %v137.p = getelementptr i64, ptr %v126, i64 2
  %v137 = load i64, ptr %v137.p
  %st124 = getelementptr i64, ptr %v133, i64 2
  store i64 %v137, ptr %st124
  %v138 = getelementptr i64, ptr %s19, i64 0
  %v139.p = getelementptr i64, ptr %v133, i64 0
  %v139 = load i64, ptr %v139.p
  %st125 = getelementptr i64, ptr %v138, i64 0
  store i64 %v139, ptr %st125
  %v140.p = getelementptr i64, ptr %v133, i64 1
  %v140 = load i64, ptr %v140.p
  %st126 = getelementptr i64, ptr %v138, i64 1
  store i64 %v140, ptr %st126
  %v141.p = getelementptr i64, ptr %v133, i64 2
  %v141 = load i64, ptr %v141.p
  %st127 = getelementptr i64, ptr %v138, i64 2
  store i64 %v141, ptr %st127
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %v142.p = getelementptr i64, ptr %v266, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = getelementptr i64, ptr %s20, i64 0
  %v144.p = getelementptr i64, ptr %v138, i64 0
  %v144 = load i64, ptr %v144.p
  %v145.p = getelementptr i64, ptr %v138, i64 1
  %v145 = load i64, ptr %v145.p
  %v146.p = getelementptr i64, ptr %v138, i64 2
  %v146 = load i64, ptr %v146.p
  call void @"std/io.Raw"(ptr %v143, i64 %v144, i64 %v145, i64 %v146)
  %v147 = getelementptr i64, ptr %s21, i64 0
  %v148.p = getelementptr i64, ptr %v143, i64 0
  %v148 = load i64, ptr %v148.p
  %st128 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st128
  %v149.p = getelementptr i64, ptr %v143, i64 1
  %v149 = load i64, ptr %v149.p
  %st129 = getelementptr i64, ptr %v147, i64 1
  store i64 %v149, ptr %st129
  %v150.p = getelementptr i64, ptr %v143, i64 2
  %v150 = load i64, ptr %v150.p
  %st130 = getelementptr i64, ptr %v147, i64 2
  store i64 %v150, ptr %st130
  %v151.p = getelementptr i64, ptr %v147, i64 1
  %v151 = load i64, ptr %v151.p
  %v152.p = getelementptr i64, ptr %v30, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = add i64 %v152, %v151
  %st131 = getelementptr i64, ptr %v30, i64 0
  store i64 %v153, ptr %st131
  %v154 = add i64 0, 1
  %v155.p = getelementptr i64, ptr %v34, i64 0
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 %v155, %v154
  %st132 = getelementptr i64, ptr %v34, i64 0
  store i64 %v156, ptr %st132
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %v157.p = getelementptr i64, ptr %v267, i64 0
  %v157 = load i64, ptr %v157.p
  %v158 = getelementptr i64, ptr %s22, i64 0
  %v159.p = getelementptr i64, ptr %v147, i64 0
  %v159 = load i64, ptr %v159.p
  %st133 = getelementptr i64, ptr %v158, i64 0
  store i64 %v159, ptr %st133
  %v160.p = getelementptr i64, ptr %v147, i64 1
  %v160 = load i64, ptr %v160.p
  %st134 = getelementptr i64, ptr %v158, i64 1
  store i64 %v160, ptr %st134
  %v161.p = getelementptr i64, ptr %v147, i64 2
  %v161 = load i64, ptr %v161.p
  %st135 = getelementptr i64, ptr %v158, i64 2
  store i64 %v161, ptr %st135
  %v162 = getelementptr i64, ptr %s23, i64 0
  %v163.p = getelementptr i64, ptr %v158, i64 0
  %v163 = load i64, ptr %v163.p
  %st136 = getelementptr i64, ptr %v162, i64 0
  store i64 %v163, ptr %st136
  %v164.p = getelementptr i64, ptr %v158, i64 1
  %v164 = load i64, ptr %v164.p
  %st137 = getelementptr i64, ptr %v162, i64 1
  store i64 %v164, ptr %st137
  %v165.p = getelementptr i64, ptr %v158, i64 2
  %v165 = load i64, ptr %v165.p
  %st138 = getelementptr i64, ptr %v162, i64 2
  store i64 %v165, ptr %st138
  %v166 = getelementptr i64, ptr %s24, i64 0
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v167.p = getelementptr i64, ptr %v268, i64 0
  %v167 = load i64, ptr %v167.p
  %v168 = add i64 0, 0
  %v169 = getelementptr i64, ptr %s25, i64 0
  %st139 = getelementptr i64, ptr %v169, i64 0
  store i64 %v168, ptr %st139
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v170.p = getelementptr i64, ptr %v269, i64 0
  %v170 = load i64, ptr %v170.p
  br label %b29
b26:
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %st140 = getelementptr i64, ptr %v270, i64 0
  store i64 %v142, ptr %st140
  br label %b8
b27:
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v271, i64 0
  store i64 %v157, ptr %st141
  br label %b26
b28:
  br label %b27
b29:
  %v272 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v272, i64 0
  store i64 %v170, ptr %st142
  %v171.p = getelementptr i64, ptr %v169, i64 0
  %v171 = load i64, ptr %v171.p
  %v172.p = getelementptr i64, ptr %v162, i64 1
  %v172 = load i64, ptr %v172.p
  %v173.c = icmp slt i64 %v171, %v172
  %v173 = zext i1 %v173.c to i64
  %c.b29 = icmp ne i64 %v173, 0
  br i1 %c.b29, label %b29.t144, label %b29.e145
b29.t144:
  br label %b30
b29.e145:
  br label %b31
b30:
  call void @"rt.region_enter"()
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %v174.p = getelementptr i64, ptr %v273, i64 0
  %v174 = load i64, ptr %v174.p
  %v175.p = getelementptr i64, ptr %v169, i64 0
  %v175 = load i64, ptr %v175.p
  %v176.p = getelementptr i64, ptr %v162, i64 1
  %v176 = load i64, ptr %v176.p
  %v177.c = icmp uge i64 %v175, %v176
  %v177 = zext i1 %v177.c to i64
  %c.b30 = icmp ne i64 %v177, 0
  br i1 %c.b30, label %b30.t146, label %b30.e147
b30.t146:
  br label %b32
b30.e147:
  br label %b33
b31:
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %st147 = getelementptr i64, ptr %v274, i64 0
  store i64 %v170, ptr %st147
  br label %b28
b32:
  %v178 = add i64 0, 29
  call void @"rt.panic"(i64 %v178)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b33:
  %v179.p = getelementptr i64, ptr %v162, i64 0
  %v179 = load i64, ptr %v179.p
  %v180 = inttoptr i64 %v179 to ptr
  %v181 = getelementptr i8, ptr %v180, i64 %v175
  %v182.p = getelementptr i8, ptr %v181, i64 0
  %v182.b = load i8, ptr %v182.p
  %v182 = zext i8 %v182.b to i64
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %v183.p = getelementptr i64, ptr %v275, i64 0
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 10
  %v185.c = icmp eq i64 %v182, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b33 = icmp ne i64 %v185, 0
  br i1 %c.b33, label %b33.t149, label %b33.e150
b33.t149:
  br label %b35
b33.e150:
  br label %b36
b34:
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %st150 = getelementptr i64, ptr %v276, i64 0
  store i64 %v183, ptr %st150
  %v189 = add i64 0, 1
  %v190.p = getelementptr i64, ptr %v169, i64 0
  %v190 = load i64, ptr %v190.p
  %v191 = add i64 %v190, %v189
  %st151 = getelementptr i64, ptr %v169, i64 0
  store i64 %v191, ptr %st151
  br label %b29
b35:
  %v186 = add i64 0, 1
  %v187.p = getelementptr i64, ptr %v32, i64 0
  %v187 = load i64, ptr %v187.p
  %v188 = add i64 %v187, %v186
  %st152 = getelementptr i64, ptr %v32, i64 0
  store i64 %v188, ptr %st152
  br label %b37
b36:
  br label %b37
b37:
  br label %b34
b38:
  %v203 = add i64 0, 3
  %v204 = getelementptr i64, ptr %v45, i64 %v203
  %v277 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v204, i64 %v277, i64 %v46)
  br label %b39
b39:
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %st153 = getelementptr i64, ptr %v278, i64 0
  store i64 %v46, ptr %st153
  br label %b7
b40:
  %v214 = add i64 0, 3
  %v215 = getelementptr i64, ptr %v38, i64 %v214
  %v279 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v215, i64 %v279, i64 %v39)
  br label %b41
b41:
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %st154 = getelementptr i64, ptr %v280, i64 0
  store i64 %v39, ptr %st154
  br label %b6
b42:
  %v219 = add i64 0, 0
  %st155 = getelementptr i64, ptr %v0, i64 0
  store i64 %v219, ptr %st155
  %st156 = getelementptr i64, ptr %v0, i64 1
  store i64 %v219, ptr %st156
  %st157 = getelementptr i64, ptr %v0, i64 2
  store i64 %v219, ptr %st157
  %v220.p = getelementptr i64, ptr %v38, i64 0
  %v220 = load i64, ptr %v220.p
  %st158 = getelementptr i64, ptr %v0, i64 3
  store i64 %v220, ptr %st158
  %v221.p = getelementptr i64, ptr %v38, i64 1
  %v221 = load i64, ptr %v221.p
  %st159 = getelementptr i64, ptr %v0, i64 4
  store i64 %v221, ptr %st159
  %v222.p = getelementptr i64, ptr %v38, i64 2
  %v222 = load i64, ptr %v222.p
  %st160 = getelementptr i64, ptr %v0, i64 5
  store i64 %v222, ptr %st160
  %v223.p = getelementptr i64, ptr %v38, i64 3
  %v223 = load i64, ptr %v223.p
  %st161 = getelementptr i64, ptr %v0, i64 6
  store i64 %v223, ptr %st161
  %v224.p = getelementptr i64, ptr %v38, i64 4
  %v224 = load i64, ptr %v224.p
  %st162 = getelementptr i64, ptr %v0, i64 7
  store i64 %v224, ptr %st162
  %v225.p = getelementptr i64, ptr %v38, i64 5
  %v225 = load i64, ptr %v225.p
  %st163 = getelementptr i64, ptr %v0, i64 8
  store i64 %v225, ptr %st163
  %v226.p = getelementptr i64, ptr %v27, i64 0
  %v226 = load i64, ptr %v226.p
  call void @"std/io.Close"(i64 %v226)
  %v227.p = getelementptr i64, ptr %v0, i64 3
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 0, 0
  %v229.c = icmp ne i64 %v227, %v228
  %v229 = zext i1 %v229.c to i64
  %c.b42 = icmp ne i64 %v229, 0
  br i1 %c.b42, label %b42.t165, label %b42.e166
b42.t165:
  br label %b44
b42.e166:
  br label %b45
b43:
  br label %b5
b44:
  %v230 = add i64 0, 6
  %v231 = getelementptr i64, ptr %v0, i64 %v230
  %v281 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v231, i64 %v281, i64 %v5)
  br label %b45
b45:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st166 = getelementptr i64, ptr %v282, i64 0
  store i64 %v5, ptr %st166
  ret void
b46:
  %v247 = add i64 0, 6
  %v248 = getelementptr i64, ptr %v0, i64 %v247
  %v283 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v248, i64 %v283, i64 %v5)
  br label %b47
b47:
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %st167 = getelementptr i64, ptr %v284, i64 0
  store i64 %v5, ptr %st167
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
  %s13 = alloca [2 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s13.z1 = getelementptr i64, ptr %s13, i64 1
  store i64 0, ptr %s13.z1
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
  %s16 = alloca [3 x i64], align 8
  %s16.z0 = getelementptr i64, ptr %s16, i64 0
  store i64 0, ptr %s16.z0
  %s16.z1 = getelementptr i64, ptr %s16, i64 1
  store i64 0, ptr %s16.z1
  %s16.z2 = getelementptr i64, ptr %s16, i64 2
  store i64 0, ptr %s16.z2
  %s17 = alloca [5 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s17.z1 = getelementptr i64, ptr %s17, i64 1
  store i64 0, ptr %s17.z1
  %s17.z2 = getelementptr i64, ptr %s17, i64 2
  store i64 0, ptr %s17.z2
  %s17.z3 = getelementptr i64, ptr %s17, i64 3
  store i64 0, ptr %s17.z3
  %s17.z4 = getelementptr i64, ptr %s17, i64 4
  store i64 0, ptr %s17.z4
  %s18 = alloca [1 x i64], align 8
  %s18.z0 = getelementptr i64, ptr %s18, i64 0
  store i64 0, ptr %s18.z0
  %s19 = alloca [1 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
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
  %s23 = alloca [1 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %s24 = alloca [1 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s25 = alloca [1 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
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
  %s29 = alloca [1 x i64], align 8
  %s29.z0 = getelementptr i64, ptr %s29, i64 0
  store i64 0, ptr %s29.z0
  %s30 = alloca [1 x i64], align 8
  %s30.z0 = getelementptr i64, ptr %s30, i64 0
  store i64 0, ptr %s30.z0
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
  %s34 = alloca [3 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
  %s34.z1 = getelementptr i64, ptr %s34, i64 1
  store i64 0, ptr %s34.z1
  %s34.z2 = getelementptr i64, ptr %s34, i64 2
  store i64 0, ptr %s34.z2
  %s35 = alloca [9 x i64], align 8
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
  %s35.z6 = getelementptr i64, ptr %s35, i64 6
  store i64 0, ptr %s35.z6
  %s35.z7 = getelementptr i64, ptr %s35, i64 7
  store i64 0, ptr %s35.z7
  %s35.z8 = getelementptr i64, ptr %s35, i64 8
  store i64 0, ptr %s35.z8
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
  %s45 = alloca [3 x i64], align 8
  %s45.z0 = getelementptr i64, ptr %s45, i64 0
  store i64 0, ptr %s45.z0
  %s45.z1 = getelementptr i64, ptr %s45, i64 1
  store i64 0, ptr %s45.z1
  %s45.z2 = getelementptr i64, ptr %s45, i64 2
  store i64 0, ptr %s45.z2
  %s46 = alloca [1 x i64], align 8
  %s46.z0 = getelementptr i64, ptr %s46, i64 0
  store i64 0, ptr %s46.z0
  %s47 = alloca [1 x i64], align 8
  %s47.z0 = getelementptr i64, ptr %s47, i64 0
  store i64 0, ptr %s47.z0
  %s48 = alloca [3 x i64], align 8
  %s48.z0 = getelementptr i64, ptr %s48, i64 0
  store i64 0, ptr %s48.z0
  %s48.z1 = getelementptr i64, ptr %s48, i64 1
  store i64 0, ptr %s48.z1
  %s48.z2 = getelementptr i64, ptr %s48, i64 2
  store i64 0, ptr %s48.z2
  %s49 = alloca [9 x i64], align 8
  %s49.z0 = getelementptr i64, ptr %s49, i64 0
  store i64 0, ptr %s49.z0
  %s49.z1 = getelementptr i64, ptr %s49, i64 1
  store i64 0, ptr %s49.z1
  %s49.z2 = getelementptr i64, ptr %s49, i64 2
  store i64 0, ptr %s49.z2
  %s49.z3 = getelementptr i64, ptr %s49, i64 3
  store i64 0, ptr %s49.z3
  %s49.z4 = getelementptr i64, ptr %s49, i64 4
  store i64 0, ptr %s49.z4
  %s49.z5 = getelementptr i64, ptr %s49, i64 5
  store i64 0, ptr %s49.z5
  %s49.z6 = getelementptr i64, ptr %s49, i64 6
  store i64 0, ptr %s49.z6
  %s49.z7 = getelementptr i64, ptr %s49, i64 7
  store i64 0, ptr %s49.z7
  %s49.z8 = getelementptr i64, ptr %s49, i64 8
  store i64 0, ptr %s49.z8
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
  %s58 = alloca [3 x i64], align 8
  %s58.z0 = getelementptr i64, ptr %s58, i64 0
  store i64 0, ptr %s58.z0
  %s58.z1 = getelementptr i64, ptr %s58, i64 1
  store i64 0, ptr %s58.z1
  %s58.z2 = getelementptr i64, ptr %s58, i64 2
  store i64 0, ptr %s58.z2
  %s59 = alloca [9 x i64], align 8
  %s59.z0 = getelementptr i64, ptr %s59, i64 0
  store i64 0, ptr %s59.z0
  %s59.z1 = getelementptr i64, ptr %s59, i64 1
  store i64 0, ptr %s59.z1
  %s59.z2 = getelementptr i64, ptr %s59, i64 2
  store i64 0, ptr %s59.z2
  %s59.z3 = getelementptr i64, ptr %s59, i64 3
  store i64 0, ptr %s59.z3
  %s59.z4 = getelementptr i64, ptr %s59, i64 4
  store i64 0, ptr %s59.z4
  %s59.z5 = getelementptr i64, ptr %s59, i64 5
  store i64 0, ptr %s59.z5
  %s59.z6 = getelementptr i64, ptr %s59, i64 6
  store i64 0, ptr %s59.z6
  %s59.z7 = getelementptr i64, ptr %s59, i64 7
  store i64 0, ptr %s59.z7
  %s59.z8 = getelementptr i64, ptr %s59, i64 8
  store i64 0, ptr %s59.z8
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v756 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v756, i64 0
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
  %v757 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v757, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = getelementptr i64, ptr %s5, i64 0
  %v36.p = getelementptr i64, ptr %v28, i64 0
  %v36 = load i64, ptr %v36.p
  %st18 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st18
  %v37 = getelementptr i64, ptr %s6, i64 0
  %v758 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v758, i64 0
  %v38 = load i64, ptr %v38.p
  %v759 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v759, i64 0
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
  %v760 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v760, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = getelementptr i64, ptr %s9, i64 0
  %v51.p = getelementptr i64, ptr %v35, i64 0
  %v51 = load i64, ptr %v51.p
  %st25 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st25
  %v52 = getelementptr i64, ptr %s10, i64 0
  %v761 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v761, i64 0
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
  %v762 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v762, i64 0
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v54, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 65536
  %v63 = add i64 0, 2
  %v64 = call i64 @"rt.chunk_open"(i64 %v61, i64 %v62, i64 %v63, i64 %v58)
  %v763 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v763, i64 0
  %v65 = load i64, ptr %v65.p
  br label %b10
b3:
  %v26 = add i64 0, 5
  %v27 = getelementptr i64, ptr %v0, i64 %v26
  %v764 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v27, i64 %v764, i64 %v6)
  br label %b4
b4:
  %v765 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v765, i64 0
  store i64 %v6, ptr %st27
  ret void
b5:
  %v766 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v766, i64 0
  store i64 %v34, ptr %st28
  %v740.p = getelementptr i64, ptr %v31, i64 0
  %v740 = load i64, ptr %v740.p
  %v741.p = getelementptr i64, ptr %v33, i64 0
  %v741 = load i64, ptr %v741.p
  %v742 = getelementptr i64, ptr %s15, i64 0
  %v743 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v742, i64 0
  store i64 %v743, ptr %st29
  %st30 = getelementptr i64, ptr %v0, i64 0
  store i64 %v740, ptr %st30
  %st31 = getelementptr i64, ptr %v0, i64 1
  store i64 %v741, ptr %st31
  %v744.p = getelementptr i64, ptr %v742, i64 0
  %v744 = load i64, ptr %v744.p
  %st32 = getelementptr i64, ptr %v0, i64 2
  store i64 %v744, ptr %st32
  %v745.p = getelementptr i64, ptr %v742, i64 1
  %v745 = load i64, ptr %v745.p
  %st33 = getelementptr i64, ptr %v0, i64 3
  store i64 %v745, ptr %st33
  %v746.p = getelementptr i64, ptr %v742, i64 2
  %v746 = load i64, ptr %v746.p
  %st34 = getelementptr i64, ptr %v0, i64 4
  store i64 %v746, ptr %st34
  %v747.p = getelementptr i64, ptr %v742, i64 3
  %v747 = load i64, ptr %v747.p
  %st35 = getelementptr i64, ptr %v0, i64 5
  store i64 %v747, ptr %st35
  %v748.p = getelementptr i64, ptr %v742, i64 4
  %v748 = load i64, ptr %v748.p
  %st36 = getelementptr i64, ptr %v0, i64 6
  store i64 %v748, ptr %st36
  %v749.p = getelementptr i64, ptr %v742, i64 5
  %v749 = load i64, ptr %v749.p
  %st37 = getelementptr i64, ptr %v0, i64 7
  store i64 %v749, ptr %st37
  %v750.p = getelementptr i64, ptr %v28, i64 0
  %v750 = load i64, ptr %v750.p
  call void @"std/io.Close"(i64 %v750)
  %v751.p = getelementptr i64, ptr %v0, i64 2
  %v751 = load i64, ptr %v751.p
  %v752 = add i64 0, 0
  %v753.c = icmp ne i64 %v751, %v752
  %v753 = zext i1 %v753.c to i64
  %c.b5 = icmp ne i64 %v753, 0
  br i1 %c.b5, label %b5.t39, label %b5.e40
b5.t39:
  br label %b103
b5.e40:
  br label %b104
b6:
  %v724.p = getelementptr i64, ptr %v37, i64 0
  %v724 = load i64, ptr %v724.p
  %v725 = add i64 0, 0
  %v726.c = icmp ne i64 %v724, %v725
  %v726 = zext i1 %v726.c to i64
  %c.b6 = icmp ne i64 %v726, 0
  br i1 %c.b6, label %b6.t41, label %b6.e42
b6.t41:
  br label %b99
b6.e42:
  br label %b100
b7:
  %v767 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v767, i64 0
  store i64 %v49, ptr %st42
  %v577.p = getelementptr i64, ptr %v45, i64 1
  %v577 = load i64, ptr %v577.p
  %v578 = add i64 0, 0
  %v579.c = icmp sgt i64 %v577, %v578
  %v579 = zext i1 %v579.c to i64
  %c.b7 = icmp ne i64 %v579, 0
  br i1 %c.b7, label %b7.t44, label %b7.e45
b7.t44:
  br label %b87
b7.e45:
  br label %b88
b8:
  %v562.p = getelementptr i64, ptr %v52, i64 0
  %v562 = load i64, ptr %v562.p
  %v563 = add i64 0, 0
  %v564.c = icmp ne i64 %v562, %v563
  %v564 = zext i1 %v564.c to i64
  %c.b8 = icmp ne i64 %v564, 0
  br i1 %c.b8, label %b8.t46, label %b8.e47
b8.t46:
  br label %b83
b8.e47:
  br label %b84
b9:
  %v551.p = getelementptr i64, ptr %v59, i64 0
  %v551 = load i64, ptr %v551.p
  %st47 = getelementptr i64, ptr %v52, i64 0
  store i64 %v551, ptr %st47
  %v552.p = getelementptr i64, ptr %v59, i64 1
  %v552 = load i64, ptr %v552.p
  %st48 = getelementptr i64, ptr %v52, i64 1
  store i64 %v552, ptr %st48
  %v553.p = getelementptr i64, ptr %v59, i64 2
  %v553 = load i64, ptr %v553.p
  %st49 = getelementptr i64, ptr %v52, i64 2
  store i64 %v553, ptr %st49
  %v554.p = getelementptr i64, ptr %v59, i64 3
  %v554 = load i64, ptr %v554.p
  %st50 = getelementptr i64, ptr %v52, i64 3
  store i64 %v554, ptr %st50
  %v555.p = getelementptr i64, ptr %v59, i64 4
  %v555 = load i64, ptr %v555.p
  %st51 = getelementptr i64, ptr %v52, i64 4
  store i64 %v555, ptr %st51
  %v556.p = getelementptr i64, ptr %v59, i64 5
  %v556 = load i64, ptr %v556.p
  %st52 = getelementptr i64, ptr %v52, i64 5
  store i64 %v556, ptr %st52
  %v557.p = getelementptr i64, ptr %v52, i64 0
  %v557 = load i64, ptr %v557.p
  %v558 = add i64 0, 0
  %v559.c = icmp ne i64 %v557, %v558
  %v559 = zext i1 %v559.c to i64
  %c.b9 = icmp ne i64 %v559, 0
  br i1 %c.b9, label %b9.t54, label %b9.e55
b9.t54:
  br label %b81
b9.e55:
  br label %b82
b10:
  %v768 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v768, i64 0
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
  %v769 = getelementptr i64, ptr @"rt.meta", i64 0
  %v67.p = getelementptr i64, ptr %v769, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 0
  %v69 = add i64 0, 0
  %v70.c = icmp ne i64 %v68, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b11 = icmp ne i64 %v70, 0
  br i1 %c.b11, label %b11.t59, label %b11.e60
b11.t59:
  br label %b13
b11.e60:
  br label %b14
b12:
  %v770 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v770, i64 0
  store i64 %v65, ptr %st60
  %v538 = getelementptr i64, ptr %s15, i64 0
  %v539 = add i64 0, 0
  %st61 = getelementptr i64, ptr %v538, i64 0
  store i64 %v539, ptr %st61
  %v540.p = getelementptr i64, ptr %v538, i64 0
  %v540 = load i64, ptr %v540.p
  %st62 = getelementptr i64, ptr %v59, i64 0
  store i64 %v540, ptr %st62
  %v541.p = getelementptr i64, ptr %v538, i64 1
  %v541 = load i64, ptr %v541.p
  %st63 = getelementptr i64, ptr %v59, i64 1
  store i64 %v541, ptr %st63
  %v542.p = getelementptr i64, ptr %v538, i64 2
  %v542 = load i64, ptr %v542.p
  %st64 = getelementptr i64, ptr %v59, i64 2
  store i64 %v542, ptr %st64
  %v543.p = getelementptr i64, ptr %v538, i64 3
  %v543 = load i64, ptr %v543.p
  %st65 = getelementptr i64, ptr %v59, i64 3
  store i64 %v543, ptr %st65
  %v544.p = getelementptr i64, ptr %v538, i64 4
  %v544 = load i64, ptr %v544.p
  %st66 = getelementptr i64, ptr %v59, i64 4
  store i64 %v544, ptr %st66
  %v545.p = getelementptr i64, ptr %v538, i64 5
  %v545 = load i64, ptr %v545.p
  %st67 = getelementptr i64, ptr %v59, i64 5
  store i64 %v545, ptr %st67
  call void @"std/io.chunkEnd"(i64 %v64)
  %v546.p = getelementptr i64, ptr %v59, i64 0
  %v546 = load i64, ptr %v546.p
  %v547 = add i64 0, 0
  %v548.c = icmp ne i64 %v546, %v547
  %v548 = zext i1 %v548.c to i64
  %c.b12 = icmp ne i64 %v548, 0
  br i1 %c.b12, label %b12.t69, label %b12.e70
b12.t69:
  br label %b79
b12.e70:
  br label %b80
b13:
  %v71 = getelementptr i64, ptr %s13, i64 0
  %v72 = add i64 0, 0
  %st70 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st70
  %st71 = getelementptr i64, ptr %v71, i64 1
  store i64 %v72, ptr %st71
  %v73 = add i64 0, 4
  %st72 = getelementptr i64, ptr %v71, i64 0
  store i64 %v73, ptr %st72
  %v74 = getelementptr i64, ptr %s14, i64 0
  %v75.p = getelementptr i64, ptr %v71, i64 0
  %v75 = load i64, ptr %v75.p
  %st73 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st73
  %v76.p = getelementptr i64, ptr %v71, i64 1
  %v76 = load i64, ptr %v76.p
  %st74 = getelementptr i64, ptr %v74, i64 1
  store i64 %v76, ptr %st74
  %v77 = add i64 0, 0
  %st75 = getelementptr i64, ptr %v74, i64 2
  store i64 %v77, ptr %st75
  %st76 = getelementptr i64, ptr %v74, i64 3
  store i64 %v77, ptr %st76
  %st77 = getelementptr i64, ptr %v74, i64 4
  store i64 %v77, ptr %st77
  %v78 = getelementptr i64, ptr %s15, i64 0
  %v79 = add i64 0, 1
  %st78 = getelementptr i64, ptr %v78, i64 0
  store i64 %v79, ptr %st78
  %v80.p = getelementptr i64, ptr %v74, i64 0
  %v80 = load i64, ptr %v80.p
  %st79 = getelementptr i64, ptr %v78, i64 1
  store i64 %v80, ptr %st79
  %v81.p = getelementptr i64, ptr %v74, i64 1
  %v81 = load i64, ptr %v81.p
  %st80 = getelementptr i64, ptr %v78, i64 2
  store i64 %v81, ptr %st80
  %v82.p = getelementptr i64, ptr %v74, i64 2
  %v82 = load i64, ptr %v82.p
  %st81 = getelementptr i64, ptr %v78, i64 3
  store i64 %v82, ptr %st81
  %v83.p = getelementptr i64, ptr %v74, i64 3
  %v83 = load i64, ptr %v83.p
  %st82 = getelementptr i64, ptr %v78, i64 4
  store i64 %v83, ptr %st82
  %v84.p = getelementptr i64, ptr %v74, i64 4
  %v84 = load i64, ptr %v84.p
  %st83 = getelementptr i64, ptr %v78, i64 5
  store i64 %v84, ptr %st83
  %v85.p = getelementptr i64, ptr %v78, i64 0
  %v85 = load i64, ptr %v85.p
  %st84 = getelementptr i64, ptr %v59, i64 0
  store i64 %v85, ptr %st84
  %v86.p = getelementptr i64, ptr %v78, i64 1
  %v86 = load i64, ptr %v86.p
  %st85 = getelementptr i64, ptr %v59, i64 1
  store i64 %v86, ptr %st85
  %v87.p = getelementptr i64, ptr %v78, i64 2
  %v87 = load i64, ptr %v87.p
  %st86 = getelementptr i64, ptr %v59, i64 2
  store i64 %v87, ptr %st86
  %v88.p = getelementptr i64, ptr %v78, i64 3
  %v88 = load i64, ptr %v88.p
  %st87 = getelementptr i64, ptr %v59, i64 3
  store i64 %v88, ptr %st87
  %v89.p = getelementptr i64, ptr %v78, i64 4
  %v89 = load i64, ptr %v89.p
  %st88 = getelementptr i64, ptr %v59, i64 4
  store i64 %v89, ptr %st88
  %v90.p = getelementptr i64, ptr %v78, i64 5
  %v90 = load i64, ptr %v90.p
  %st89 = getelementptr i64, ptr %v59, i64 5
  store i64 %v90, ptr %st89
  call void @"std/io.chunkEnd"(i64 %v64)
  %v91.p = getelementptr i64, ptr %v59, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = add i64 0, 0
  %v93.c = icmp ne i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b13 = icmp ne i64 %v93, 0
  br i1 %c.b13, label %b13.t91, label %b13.e92
b13.t91:
  br label %b15
b13.e92:
  br label %b16
b14:
  br label %b17
b15:
  %v94 = add i64 0, 3
  %v95 = getelementptr i64, ptr %v59, i64 %v94
  %v771 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v95, i64 %v771, i64 %v60)
  br label %b16
b16:
  %v772 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v772, i64 0
  store i64 %v60, ptr %st92
  br label %b9
b17:
  %v96 = getelementptr i64, ptr %s7, i64 0
  call void @"rt.chunk_next"(i64 %v64, ptr %v96)
  %v97 = getelementptr i64, ptr %s16, i64 0
  %v98.p = getelementptr i64, ptr %v96, i64 0
  %v98 = load i64, ptr %v98.p
  %st93 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st93
  %v99.p = getelementptr i64, ptr %v96, i64 1
  %v99 = load i64, ptr %v99.p
  %st94 = getelementptr i64, ptr %v97, i64 1
  store i64 %v99, ptr %st94
  %v100.p = getelementptr i64, ptr %v96, i64 2
  %v100 = load i64, ptr %v100.p
  %st95 = getelementptr i64, ptr %v97, i64 2
  store i64 %v100, ptr %st95
  %v101.p = getelementptr i64, ptr %v97, i64 1
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 0
  %v103.c = icmp eq i64 %v101, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b17 = icmp ne i64 %v103, 0
  br i1 %c.b17, label %b17.t97, label %b17.e98
b17.t97:
  br label %b18
b17.e98:
  br label %b19
b18:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %v105.p = getelementptr i64, ptr %v104, i64 1027
  %v105 = load i64, ptr %v105.p
  %v106 = add i64 0, 0
  %v107.c = icmp ne i64 %v105, %v106
  %v107 = zext i1 %v107.c to i64
  %c.b18 = icmp ne i64 %v107, 0
  br i1 %c.b18, label %b18.t99, label %b18.e100
b18.t99:
  br label %b20
b18.e100:
  br label %b21
b19:
  br label %b27
b20:
  %v108 = getelementptr i64, ptr %s17, i64 0
  call void @"std/io.errOf"(ptr %v108, i64 %v105)
  %v109 = getelementptr i64, ptr %s15, i64 0
  %v110 = add i64 0, 1
  %st100 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st100
  %v111.p = getelementptr i64, ptr %v108, i64 0
  %v111 = load i64, ptr %v111.p
  %st101 = getelementptr i64, ptr %v109, i64 1
  store i64 %v111, ptr %st101
  %v112.p = getelementptr i64, ptr %v108, i64 1
  %v112 = load i64, ptr %v112.p
  %st102 = getelementptr i64, ptr %v109, i64 2
  store i64 %v112, ptr %st102
  %v113.p = getelementptr i64, ptr %v108, i64 2
  %v113 = load i64, ptr %v113.p
  %st103 = getelementptr i64, ptr %v109, i64 3
  store i64 %v113, ptr %st103
  %v114.p = getelementptr i64, ptr %v108, i64 3
  %v114 = load i64, ptr %v114.p
  %st104 = getelementptr i64, ptr %v109, i64 4
  store i64 %v114, ptr %st104
  %v115.p = getelementptr i64, ptr %v108, i64 4
  %v115 = load i64, ptr %v115.p
  %st105 = getelementptr i64, ptr %v109, i64 5
  store i64 %v115, ptr %st105
  %v116.p = getelementptr i64, ptr %v109, i64 0
  %v116 = load i64, ptr %v116.p
  %st106 = getelementptr i64, ptr %v59, i64 0
  store i64 %v116, ptr %st106
  %v117.p = getelementptr i64, ptr %v109, i64 1
  %v117 = load i64, ptr %v117.p
  %st107 = getelementptr i64, ptr %v59, i64 1
  store i64 %v117, ptr %st107
  %v118.p = getelementptr i64, ptr %v109, i64 2
  %v118 = load i64, ptr %v118.p
  %st108 = getelementptr i64, ptr %v59, i64 2
  store i64 %v118, ptr %st108
  %v119.p = getelementptr i64, ptr %v109, i64 3
  %v119 = load i64, ptr %v119.p
  %st109 = getelementptr i64, ptr %v59, i64 3
  store i64 %v119, ptr %st109
  %v120.p = getelementptr i64, ptr %v109, i64 4
  %v120 = load i64, ptr %v120.p
  %st110 = getelementptr i64, ptr %v59, i64 4
  store i64 %v120, ptr %st110
  %v121.p = getelementptr i64, ptr %v109, i64 5
  %v121 = load i64, ptr %v121.p
  %st111 = getelementptr i64, ptr %v59, i64 5
  store i64 %v121, ptr %st111
  call void @"std/io.chunkEnd"(i64 %v64)
  %v122.p = getelementptr i64, ptr %v59, i64 0
  %v122 = load i64, ptr %v122.p
  %v123 = add i64 0, 0
  %v124.c = icmp ne i64 %v122, %v123
  %v124 = zext i1 %v124.c to i64
  %c.b20 = icmp ne i64 %v124, 0
  br i1 %c.b20, label %b20.t113, label %b20.e114
b20.t113:
  br label %b22
b20.e114:
  br label %b23
b21:
  br label %b24
b22:
  %v125 = add i64 0, 3
  %v126 = getelementptr i64, ptr %v59, i64 %v125
  %v773 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v126, i64 %v773, i64 %v60)
  br label %b23
b23:
  %v774 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v774, i64 0
  store i64 %v60, ptr %st114
  br label %b9
b24:
  %v127 = getelementptr i64, ptr %s15, i64 0
  %v128 = add i64 0, 0
  %st115 = getelementptr i64, ptr %v127, i64 0
  store i64 %v128, ptr %st115
  %v129.p = getelementptr i64, ptr %v127, i64 0
  %v129 = load i64, ptr %v129.p
  %st116 = getelementptr i64, ptr %v59, i64 0
  store i64 %v129, ptr %st116
  %v130.p = getelementptr i64, ptr %v127, i64 1
  %v130 = load i64, ptr %v130.p
  %st117 = getelementptr i64, ptr %v59, i64 1
  store i64 %v130, ptr %st117
  %v131.p = getelementptr i64, ptr %v127, i64 2
  %v131 = load i64, ptr %v131.p
  %st118 = getelementptr i64, ptr %v59, i64 2
  store i64 %v131, ptr %st118
  %v132.p = getelementptr i64, ptr %v127, i64 3
  %v132 = load i64, ptr %v132.p
  %st119 = getelementptr i64, ptr %v59, i64 3
  store i64 %v132, ptr %st119
  %v133.p = getelementptr i64, ptr %v127, i64 4
  %v133 = load i64, ptr %v133.p
  %st120 = getelementptr i64, ptr %v59, i64 4
  store i64 %v133, ptr %st120
  %v134.p = getelementptr i64, ptr %v127, i64 5
  %v134 = load i64, ptr %v134.p
  %st121 = getelementptr i64, ptr %v59, i64 5
  store i64 %v134, ptr %st121
  call void @"std/io.chunkEnd"(i64 %v64)
  %v135.p = getelementptr i64, ptr %v59, i64 0
  %v135 = load i64, ptr %v135.p
  %v136 = add i64 0, 0
  %v137.c = icmp ne i64 %v135, %v136
  %v137 = zext i1 %v137.c to i64
  %c.b24 = icmp ne i64 %v137, 0
  br i1 %c.b24, label %b24.t123, label %b24.e124
b24.t123:
  br label %b25
b24.e124:
  br label %b26
b25:
  %v138 = add i64 0, 3
  %v139 = getelementptr i64, ptr %v59, i64 %v138
  %v775 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v139, i64 %v775, i64 %v60)
  br label %b26
b26:
  %v776 = getelementptr i64, ptr @"rt.meta", i64 0
  %st124 = getelementptr i64, ptr %v776, i64 0
  store i64 %v60, ptr %st124
  br label %b9
b27:
  %v140 = getelementptr i64, ptr %s7, i64 0
  %v141.p = getelementptr i64, ptr %v97, i64 0
  %v141 = load i64, ptr %v141.p
  %st125 = getelementptr i64, ptr %v140, i64 0
  store i64 %v141, ptr %st125
  %v142.p = getelementptr i64, ptr %v97, i64 1
  %v142 = load i64, ptr %v142.p
  %st126 = getelementptr i64, ptr %v140, i64 1
  store i64 %v142, ptr %st126
  %v143.p = getelementptr i64, ptr %v97, i64 2
  %v143 = load i64, ptr %v143.p
  %st127 = getelementptr i64, ptr %v140, i64 2
  store i64 %v143, ptr %st127
  %v144 = getelementptr i64, ptr %s18, i64 0
  %v145 = add i64 0, 0
  %v146 = getelementptr i64, ptr %s19, i64 0
  %v147 = getelementptr i64, ptr %s20, i64 0
  %v148 = add i64 0, 0
  %st128 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st128
  %st129 = getelementptr i64, ptr %v147, i64 1
  store i64 %v148, ptr %st129
  %st130 = getelementptr i64, ptr %v147, i64 2
  store i64 %v148, ptr %st130
  %v149.p = getelementptr i64, ptr %v140, i64 0
  %v149 = load i64, ptr %v149.p
  %st131 = getelementptr i64, ptr %v147, i64 0
  store i64 %v149, ptr %st131
  %v150.p = getelementptr i64, ptr %v140, i64 1
  %v150 = load i64, ptr %v150.p
  %st132 = getelementptr i64, ptr %v147, i64 1
  store i64 %v150, ptr %st132
  %v151.p = getelementptr i64, ptr %v140, i64 2
  %v151 = load i64, ptr %v151.p
  %st133 = getelementptr i64, ptr %v147, i64 2
  store i64 %v151, ptr %st133
  %v152 = getelementptr i64, ptr %s21, i64 0
  %v153.p = getelementptr i64, ptr %v147, i64 0
  %v153 = load i64, ptr %v153.p
  %st134 = getelementptr i64, ptr %v152, i64 0
  store i64 %v153, ptr %st134
  %v154.p = getelementptr i64, ptr %v147, i64 1
  %v154 = load i64, ptr %v154.p
  %st135 = getelementptr i64, ptr %v152, i64 1
  store i64 %v154, ptr %st135
  %v155.p = getelementptr i64, ptr %v147, i64 2
  %v155 = load i64, ptr %v155.p
  %st136 = getelementptr i64, ptr %v152, i64 2
  store i64 %v155, ptr %st136
  %v777 = getelementptr i64, ptr @"rt.meta", i64 0
  %v156.p = getelementptr i64, ptr %v777, i64 0
  %v156 = load i64, ptr %v156.p
  %v157 = getelementptr i64, ptr %s22, i64 0
  %v158.p = getelementptr i64, ptr %v152, i64 0
  %v158 = load i64, ptr %v158.p
  %st137 = getelementptr i64, ptr %v157, i64 0
  store i64 %v158, ptr %st137
  %v159.p = getelementptr i64, ptr %v152, i64 1
  %v159 = load i64, ptr %v159.p
  %st138 = getelementptr i64, ptr %v157, i64 1
  store i64 %v159, ptr %st138
  %v160.p = getelementptr i64, ptr %v152, i64 2
  %v160 = load i64, ptr %v160.p
  %st139 = getelementptr i64, ptr %v157, i64 2
  store i64 %v160, ptr %st139
  %v161 = add i64 0, 0
  %v162 = getelementptr i64, ptr %s23, i64 0
  %st140 = getelementptr i64, ptr %v162, i64 0
  store i64 %v161, ptr %st140
  %v778 = getelementptr i64, ptr @"rt.meta", i64 0
  %v163.p = getelementptr i64, ptr %v778, i64 0
  %v163 = load i64, ptr %v163.p
  br label %b29
b28:
  %v779 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v779, i64 0
  store i64 %v156, ptr %st141
  br label %b10
b29:
  %v780 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v780, i64 0
  store i64 %v163, ptr %st142
  %v164.p = getelementptr i64, ptr %v162, i64 0
  %v164 = load i64, ptr %v164.p
  %v165.p = getelementptr i64, ptr %v157, i64 1
  %v165 = load i64, ptr %v165.p
  %v166.c = icmp slt i64 %v164, %v165
  %v166 = zext i1 %v166.c to i64
  %c.b29 = icmp ne i64 %v166, 0
  br i1 %c.b29, label %b29.t144, label %b29.e145
b29.t144:
  br label %b30
b29.e145:
  br label %b31
b30:
  call void @"rt.region_enter"()
  %v781 = getelementptr i64, ptr @"rt.meta", i64 0
  %v167.p = getelementptr i64, ptr %v781, i64 0
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v162, i64 0
  %v168 = load i64, ptr %v168.p
  %v169 = getelementptr i64, ptr %s24, i64 0
  %st145 = getelementptr i64, ptr %v169, i64 0
  store i64 %v168, ptr %st145
  %v782 = getelementptr i64, ptr @"rt.meta", i64 0
  %v170.p = getelementptr i64, ptr %v782, i64 0
  %v170 = load i64, ptr %v170.p
  br label %b32
b31:
  %v783 = getelementptr i64, ptr @"rt.meta", i64 0
  %st146 = getelementptr i64, ptr %v783, i64 0
  store i64 %v163, ptr %st146
  br label %b28
b32:
  %v784 = getelementptr i64, ptr @"rt.meta", i64 0
  %st147 = getelementptr i64, ptr %v784, i64 0
  store i64 %v170, ptr %st147
  %v171.p = getelementptr i64, ptr %v169, i64 0
  %v171 = load i64, ptr %v171.p
  %v172.p = getelementptr i64, ptr %v157, i64 1
  %v172 = load i64, ptr %v172.p
  %v173.c = icmp slt i64 %v171, %v172
  %v173 = zext i1 %v173.c to i64
  %c.b32 = icmp ne i64 %v173, 0
  br i1 %c.b32, label %b32.t149, label %b32.e150
b32.t149:
  br label %b35
b32.e150:
  br label %b36
b33:
  call void @"rt.region_enter"()
  %v785 = getelementptr i64, ptr @"rt.meta", i64 0
  %v185.p = getelementptr i64, ptr %v785, i64 0
  %v185 = load i64, ptr %v185.p
  %v186 = add i64 0, 1
  %v187.p = getelementptr i64, ptr %v169, i64 0
  %v187 = load i64, ptr %v187.p
  %v188 = add i64 %v187, %v186
  %st150 = getelementptr i64, ptr %v169, i64 0
  store i64 %v188, ptr %st150
  br label %b32
b34:
  %v786 = getelementptr i64, ptr @"rt.meta", i64 0
  %st151 = getelementptr i64, ptr %v786, i64 0
  store i64 %v170, ptr %st151
  %v189.p = getelementptr i64, ptr %v169, i64 0
  %v189 = load i64, ptr %v189.p
  %v190.p = getelementptr i64, ptr %v157, i64 1
  %v190 = load i64, ptr %v190.p
  %v191.c = icmp eq i64 %v189, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b34 = icmp ne i64 %v191, 0
  br i1 %c.b34, label %b34.t153, label %b34.e154
b34.t153:
  br label %b39
b34.e154:
  br label %b40
b35:
  %v175.p = getelementptr i64, ptr %v169, i64 0
  %v175 = load i64, ptr %v175.p
  %v176.p = getelementptr i64, ptr %v157, i64 1
  %v176 = load i64, ptr %v176.p
  %v177.c = icmp uge i64 %v175, %v176
  %v177 = zext i1 %v177.c to i64
  %c.b35 = icmp ne i64 %v177, 0
  br i1 %c.b35, label %b35.t155, label %b35.e156
b35.t155:
  br label %b37
b35.e156:
  br label %b38
b36:
  %v174 = phi i64 [ %v173, %b32.e150 ], [ %v184, %b38 ]
  %c.b36 = icmp ne i64 %v174, 0
  br i1 %c.b36, label %b36.t157, label %b36.e158
b36.t157:
  br label %b33
b36.e158:
  br label %b34
b37:
  %v178 = add i64 0, 4
  call void @"rt.panic"(i64 %v178)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b38:
  %v179.p = getelementptr i64, ptr %v157, i64 0
  %v179 = load i64, ptr %v179.p
  %v180 = inttoptr i64 %v179 to ptr
  %v181 = getelementptr i8, ptr %v180, i64 %v175
  %v182.p = getelementptr i8, ptr %v181, i64 0
  %v182.b = load i8, ptr %v182.p
  %v182 = zext i8 %v182.b to i64
  %v183 = add i64 0, 10
  %v184.c = icmp ne i64 %v182, %v183
  %v184 = zext i1 %v184.c to i64
  br label %b36
b39:
  %v192.p = getelementptr i64, ptr %v162, i64 0
  %v192 = load i64, ptr %v192.p
  %v193 = getelementptr i64, ptr %s25, i64 0
  %st158 = getelementptr i64, ptr %v193, i64 0
  store i64 %v192, ptr %st158
  %v787 = getelementptr i64, ptr @"rt.meta", i64 0
  %v194.p = getelementptr i64, ptr %v787, i64 0
  %v194 = load i64, ptr %v194.p
  br label %b41
b40:
  %v239.p = getelementptr i64, ptr %v45, i64 1
  %v239 = load i64, ptr %v239.p
  %v240 = add i64 0, 0
  %v241.c = icmp eq i64 %v239, %v240
  %v241 = zext i1 %v241.c to i64
  %c.b40 = icmp ne i64 %v241, 0
  br i1 %c.b40, label %b40.t160, label %b40.e161
b40.t160:
  br label %b49
b40.e161:
  br label %b50
b41:
  %v788 = getelementptr i64, ptr @"rt.meta", i64 0
  %st161 = getelementptr i64, ptr %v788, i64 0
  store i64 %v194, ptr %st161
  %v195.p = getelementptr i64, ptr %v193, i64 0
  %v195 = load i64, ptr %v195.p
  %v196.p = getelementptr i64, ptr %v157, i64 1
  %v196 = load i64, ptr %v196.p
  %v197.c = icmp slt i64 %v195, %v196
  %v197 = zext i1 %v197.c to i64
  %c.b41 = icmp ne i64 %v197, 0
  br i1 %c.b41, label %b41.t163, label %b41.e164
b41.t163:
  br label %b42
b41.e164:
  br label %b43
b42:
  call void @"rt.region_enter"()
  %v789 = getelementptr i64, ptr @"rt.meta", i64 0
  %v198.p = getelementptr i64, ptr %v789, i64 0
  %v198 = load i64, ptr %v198.p
  %v199 = add i64 0, 1
  %v200 = add i64 %v6, %v199
  %v201 = getelementptr i64, ptr %s26, i64 0
  %v202.p = getelementptr i64, ptr %v45, i64 0
  %v202 = load i64, ptr %v202.p
  %st164 = getelementptr i64, ptr %v201, i64 0
  store i64 %v202, ptr %st164
  %v203.p = getelementptr i64, ptr %v45, i64 1
  %v203 = load i64, ptr %v203.p
  %st165 = getelementptr i64, ptr %v201, i64 1
  store i64 %v203, ptr %st165
  %v204.p = getelementptr i64, ptr %v45, i64 2
  %v204 = load i64, ptr %v204.p
  %st166 = getelementptr i64, ptr %v201, i64 2
  store i64 %v204, ptr %st166
  %v205.p = getelementptr i64, ptr %v193, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v157, i64 1
  %v206 = load i64, ptr %v206.p
  %v207.c = icmp uge i64 %v205, %v206
  %v207 = zext i1 %v207.c to i64
  %c.b42 = icmp ne i64 %v207, 0
  br i1 %c.b42, label %b42.t168, label %b42.e169
b42.t168:
  br label %b44
b42.e169:
  br label %b45
b43:
  %v790 = getelementptr i64, ptr @"rt.meta", i64 0
  %st169 = getelementptr i64, ptr %v790, i64 0
  store i64 %v194, ptr %st169
  %v238.p = getelementptr i64, ptr %v157, i64 1
  %v238 = load i64, ptr %v238.p
  %st170 = getelementptr i64, ptr %v162, i64 0
  store i64 %v238, ptr %st170
  br label %b78
b44:
  %v208 = add i64 0, 5
  call void @"rt.panic"(i64 %v208)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b45:
  %v209.p = getelementptr i64, ptr %v157, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = inttoptr i64 %v209 to ptr
  %v211 = getelementptr i8, ptr %v210, i64 %v205
  %v212.p = getelementptr i8, ptr %v211, i64 0
  %v212.b = load i8, ptr %v212.p
  %v212 = zext i8 %v212.b to i64
  %v213.p = getelementptr i64, ptr %v201, i64 2
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v201, i64 0
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v201, i64 1
  %v215 = load i64, ptr %v215.p
  %v218 = add i64 %v214, %v215
  %v219 = call i64 @"rt.tip8"(i64 %v213, i64 %v218)
  %v220 = add i64 0, 0
  %v221.c = icmp ne i64 %v219, %v220
  %v221 = zext i1 %v221.c to i64
  %c.b45 = icmp ne i64 %v221, 0
  br i1 %c.b45, label %b45.t172, label %b45.e173
b45.t172:
  br label %b48
b45.e173:
  br label %b47
b46:
  %v216 = phi ptr [ %v225, %b47 ], [ %v222, %b48 ]
  %v217 = phi ptr [ %v226, %b47 ], [ %v223, %b48 ]
  %st173 = getelementptr i8, ptr %v217, i64 0
  %st173.b = trunc i64 %v212 to i8
  store i8 %st173.b, ptr %st173
  %v227.p = getelementptr i64, ptr %v201, i64 1
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 0, 1
  %v229 = add i64 %v227, %v228
  %v230 = getelementptr i64, ptr %s27, i64 0
  %v231 = ptrtoint ptr %v216 to i64
  %st174 = getelementptr i64, ptr %v230, i64 0
  store i64 %v231, ptr %st174
  %st175 = getelementptr i64, ptr %v230, i64 1
  store i64 %v229, ptr %st175
  %st176 = getelementptr i64, ptr %v230, i64 2
  store i64 %v213, ptr %st176
  %v232.p = getelementptr i64, ptr %v230, i64 0
  %v232 = load i64, ptr %v232.p
  %st177 = getelementptr i64, ptr %v45, i64 0
  store i64 %v232, ptr %st177
  %v233.p = getelementptr i64, ptr %v230, i64 1
  %v233 = load i64, ptr %v233.p
  %st178 = getelementptr i64, ptr %v45, i64 1
  store i64 %v233, ptr %st178
  %v234.p = getelementptr i64, ptr %v230, i64 2
  %v234 = load i64, ptr %v234.p
  %st179 = getelementptr i64, ptr %v45, i64 2
  store i64 %v234, ptr %st179
  %v235 = add i64 0, 1
  %v236.p = getelementptr i64, ptr %v193, i64 0
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 %v236, %v235
  %st180 = getelementptr i64, ptr %v193, i64 0
  store i64 %v237, ptr %st180
  br label %b41
b47:
  %v224 = add i64 0, 1
  %v225 = call ptr @"rt.slice_grow8"(i64 %v214, i64 %v215, i64 %v213, i64 %v224)
  %v226 = getelementptr i8, ptr %v225, i64 %v215
  br label %b46
b48:
  %v222 = inttoptr i64 %v214 to ptr
  %v223 = getelementptr i8, ptr %v222, i64 %v215
  br label %b46
b49:
  %v242 = getelementptr i64, ptr %s28, i64 0
  %v243.p = getelementptr i64, ptr %v162, i64 0
  %v243 = load i64, ptr %v243.p
  %v244.p = getelementptr i64, ptr %v169, i64 0
  %v244 = load i64, ptr %v244.p
  %v245 = add i64 0, 0
  %v246.c = icmp slt i64 %v243, %v245
  %v246 = zext i1 %v246.c to i64
  %c.b49 = icmp ne i64 %v246, 0
  br i1 %c.b49, label %b49.t182, label %b49.e183
b49.t182:
  br label %b51
b49.e183:
  br label %b52
b50:
  %v377 = getelementptr i64, ptr %s44, i64 0
  %v378 = getelementptr i64, ptr %s45, i64 0
  %v379.p = getelementptr i64, ptr %v45, i64 0
  %v379 = load i64, ptr %v379.p
  %v380.p = getelementptr i64, ptr %v45, i64 1
  %v380 = load i64, ptr %v380.p
  %v381.p = getelementptr i64, ptr %v45, i64 2
  %v381 = load i64, ptr %v381.p
  %v382.p = getelementptr i64, ptr %v162, i64 0
  %v382 = load i64, ptr %v382.p
  %v383.p = getelementptr i64, ptr %v169, i64 0
  %v383 = load i64, ptr %v383.p
  %v384 = add i64 0, 0
  %v385.c = icmp slt i64 %v382, %v384
  %v385 = zext i1 %v385.c to i64
  %c.b50 = icmp ne i64 %v385, 0
  br i1 %c.b50, label %b50.t184, label %b50.e185
b50.t184:
  br label %b64
b50.e185:
  br label %b65
b51:
  %v247 = add i64 0, 6
  call void @"rt.panic"(i64 %v247)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b52:
  %v248.c = icmp slt i64 %v244, %v243
  %v248 = zext i1 %v248.c to i64
  %c.b52 = icmp ne i64 %v248, 0
  br i1 %c.b52, label %b52.t186, label %b52.e187
b52.t186:
  br label %b53
b52.e187:
  br label %b54
b53:
  %v249 = add i64 0, 7
  call void @"rt.panic"(i64 %v249)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b54:
  %v250.p = getelementptr i64, ptr %v157, i64 1
  %v250 = load i64, ptr %v250.p
  %v251.c = icmp sgt i64 %v244, %v250
  %v251 = zext i1 %v251.c to i64
  %c.b54 = icmp ne i64 %v251, 0
  br i1 %c.b54, label %b54.t188, label %b54.e189
b54.t188:
  br label %b55
b54.e189:
  br label %b56
b55:
  %v252 = add i64 0, 8
  call void @"rt.panic"(i64 %v252)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b56:
  %v253.p = getelementptr i64, ptr %v157, i64 0
  %v253 = load i64, ptr %v253.p
  %v254 = inttoptr i64 %v253 to ptr
  %v255 = getelementptr i8, ptr %v254, i64 %v243
  %v256 = sub i64 %v244, %v243
  %v257.p = getelementptr i64, ptr %v157, i64 2
  %v257 = load i64, ptr %v257.p
  %v258 = getelementptr i64, ptr %s27, i64 0
  %v259 = ptrtoint ptr %v255 to i64
  %st189 = getelementptr i64, ptr %v258, i64 0
  store i64 %v259, ptr %st189
  %st190 = getelementptr i64, ptr %v258, i64 1
  store i64 %v256, ptr %st190
  %st191 = getelementptr i64, ptr %v258, i64 2
  store i64 %v257, ptr %st191
  %v260.p = getelementptr i64, ptr %v258, i64 0
  %v260 = load i64, ptr %v260.p
  %v261.p = getelementptr i64, ptr %v258, i64 1
  %v261 = load i64, ptr %v261.p
  %v262.p = getelementptr i64, ptr %v258, i64 2
  %v262 = load i64, ptr %v262.p
  call void @"std/io.dropCR"(ptr %v242, i64 %v260, i64 %v261, i64 %v262)
  %v263 = getelementptr i64, ptr %s26, i64 0
  %v264.p = getelementptr i64, ptr %v242, i64 0
  %v264 = load i64, ptr %v264.p
  %st192 = getelementptr i64, ptr %v263, i64 0
  store i64 %v264, ptr %st192
  %v265.p = getelementptr i64, ptr %v242, i64 1
  %v265 = load i64, ptr %v265.p
  %st193 = getelementptr i64, ptr %v263, i64 1
  store i64 %v265, ptr %st193
  %v266.p = getelementptr i64, ptr %v242, i64 2
  %v266 = load i64, ptr %v266.p
  %st194 = getelementptr i64, ptr %v263, i64 2
  store i64 %v266, ptr %st194
  %v267 = getelementptr i64, ptr %s29, i64 0
  %v268 = add i64 0, 0
  %v269 = getelementptr i64, ptr %s30, i64 0
  %v270 = getelementptr i64, ptr %s31, i64 0
  %v271 = add i64 0, 0
  %st195 = getelementptr i64, ptr %v270, i64 0
  store i64 %v271, ptr %st195
  %st196 = getelementptr i64, ptr %v270, i64 1
  store i64 %v271, ptr %st196
  %st197 = getelementptr i64, ptr %v270, i64 2
  store i64 %v271, ptr %st197
  %v272.p = getelementptr i64, ptr %v263, i64 0
  %v272 = load i64, ptr %v272.p
  %st198 = getelementptr i64, ptr %v270, i64 0
  store i64 %v272, ptr %st198
  %v273.p = getelementptr i64, ptr %v263, i64 1
  %v273 = load i64, ptr %v273.p
  %st199 = getelementptr i64, ptr %v270, i64 1
  store i64 %v273, ptr %st199
  %v274.p = getelementptr i64, ptr %v263, i64 2
  %v274 = load i64, ptr %v274.p
  %st200 = getelementptr i64, ptr %v270, i64 2
  store i64 %v274, ptr %st200
  %v275 = getelementptr i64, ptr %s32, i64 0
  %v276.p = getelementptr i64, ptr %v270, i64 0
  %v276 = load i64, ptr %v276.p
  %st201 = getelementptr i64, ptr %v275, i64 0
  store i64 %v276, ptr %st201
  %v277.p = getelementptr i64, ptr %v270, i64 1
  %v277 = load i64, ptr %v277.p
  %st202 = getelementptr i64, ptr %v275, i64 1
  store i64 %v277, ptr %st202
  %v278.p = getelementptr i64, ptr %v270, i64 2
  %v278 = load i64, ptr %v278.p
  %st203 = getelementptr i64, ptr %v275, i64 2
  store i64 %v278, ptr %st203
  %v791 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279.p = getelementptr i64, ptr %v791, i64 0
  %v279 = load i64, ptr %v279.p
  %v280 = getelementptr i64, ptr %s33, i64 0
  %v281.p = getelementptr i64, ptr %v275, i64 0
  %v281 = load i64, ptr %v281.p
  %v282.p = getelementptr i64, ptr %v275, i64 1
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v275, i64 2
  %v283 = load i64, ptr %v283.p
  call void @"std/io.Raw"(ptr %v280, i64 %v281, i64 %v282, i64 %v283)
  %v284 = getelementptr i64, ptr %s34, i64 0
  %v285.p = getelementptr i64, ptr %v280, i64 0
  %v285 = load i64, ptr %v285.p
  %st204 = getelementptr i64, ptr %v284, i64 0
  store i64 %v285, ptr %st204
  %v286.p = getelementptr i64, ptr %v280, i64 1
  %v286 = load i64, ptr %v286.p
  %st205 = getelementptr i64, ptr %v284, i64 1
  store i64 %v286, ptr %st205
  %v287.p = getelementptr i64, ptr %v280, i64 2
  %v287 = load i64, ptr %v287.p
  %st206 = getelementptr i64, ptr %v284, i64 2
  store i64 %v287, ptr %st206
  %v288.p = getelementptr i64, ptr %v31, i64 0
  %v288 = load i64, ptr %v288.p
  %v289.c = icmp slt i64 %v288, %v4
  %v289 = zext i1 %v289.c to i64
  %c.b56 = icmp ne i64 %v289, 0
  br i1 %c.b56, label %b56.t208, label %b56.e209
b56.t208:
  br label %b58
b56.e209:
  br label %b59
b57:
  %v792 = getelementptr i64, ptr @"rt.meta", i64 0
  %st209 = getelementptr i64, ptr %v792, i64 0
  store i64 %v279, ptr %st209
  br label %b77
b58:
  %v793 = getelementptr i64, ptr @"rt.meta", i64 0
  %v290.p = getelementptr i64, ptr %v793, i64 0
  %v290 = load i64, ptr %v290.p
  call void @"rt.region_enter"()
  %v794 = getelementptr i64, ptr @"rt.meta", i64 0
  %v291.p = getelementptr i64, ptr %v794, i64 0
  %v291 = load i64, ptr %v291.p
  %v292 = getelementptr i64, ptr %s35, i64 0
  %v293.p = getelementptr i64, ptr %v284, i64 0
  %v293 = load i64, ptr %v293.p
  %v294.p = getelementptr i64, ptr %v284, i64 1
  %v294 = load i64, ptr %v294.p
  %v295.p = getelementptr i64, ptr %v284, i64 2
  %v295 = load i64, ptr %v295.p
  call void @"std/internal/utf8.Parse"(ptr %v292, i64 %v293, i64 %v294, i64 %v295)
  %v296 = add i64 0, 3
  %v297 = getelementptr i64, ptr %v292, i64 %v296
  %v298 = getelementptr i64, ptr %s36, i64 0
  %v299.p = getelementptr i64, ptr %v292, i64 0
  %v299 = load i64, ptr %v299.p
  %st210 = getelementptr i64, ptr %v298, i64 0
  store i64 %v299, ptr %st210
  %v300.p = getelementptr i64, ptr %v292, i64 1
  %v300 = load i64, ptr %v300.p
  %st211 = getelementptr i64, ptr %v298, i64 1
  store i64 %v300, ptr %st211
  %v301.p = getelementptr i64, ptr %v292, i64 2
  %v301 = load i64, ptr %v301.p
  %st212 = getelementptr i64, ptr %v298, i64 2
  store i64 %v301, ptr %st212
  %v302 = getelementptr i64, ptr %s15, i64 0
  %v303.p = getelementptr i64, ptr %v297, i64 0
  %v303 = load i64, ptr %v303.p
  %st213 = getelementptr i64, ptr %v302, i64 0
  store i64 %v303, ptr %st213
  %v304.p = getelementptr i64, ptr %v297, i64 1
  %v304 = load i64, ptr %v304.p
  %st214 = getelementptr i64, ptr %v302, i64 1
  store i64 %v304, ptr %st214
  %v305.p = getelementptr i64, ptr %v297, i64 2
  %v305 = load i64, ptr %v305.p
  %st215 = getelementptr i64, ptr %v302, i64 2
  store i64 %v305, ptr %st215
  %v306.p = getelementptr i64, ptr %v297, i64 3
  %v306 = load i64, ptr %v306.p
  %st216 = getelementptr i64, ptr %v302, i64 3
  store i64 %v306, ptr %st216
  %v307.p = getelementptr i64, ptr %v297, i64 4
  %v307 = load i64, ptr %v307.p
  %st217 = getelementptr i64, ptr %v302, i64 4
  store i64 %v307, ptr %st217
  %v308.p = getelementptr i64, ptr %v297, i64 5
  %v308 = load i64, ptr %v308.p
  %st218 = getelementptr i64, ptr %v302, i64 5
  store i64 %v308, ptr %st218
  %v309.p = getelementptr i64, ptr %v302, i64 0
  %v309 = load i64, ptr %v309.p
  %v310 = add i64 0, 0
  %v311.c = icmp ne i64 %v309, %v310
  %v311 = zext i1 %v311.c to i64
  %c.b58 = icmp ne i64 %v311, 0
  br i1 %c.b58, label %b58.t220, label %b58.e221
b58.t220:
  br label %b60
b58.e221:
  br label %b61
b59:
  br label %b63
b60:
  %v312 = add i64 0, 1
  %v313 = getelementptr i64, ptr %v302, i64 %v312
  %v314 = getelementptr i64, ptr %s14, i64 0
  %v315.p = getelementptr i64, ptr %v313, i64 0
  %v315 = load i64, ptr %v315.p
  %st221 = getelementptr i64, ptr %v314, i64 0
  store i64 %v315, ptr %st221
  %v316.p = getelementptr i64, ptr %v313, i64 1
  %v316 = load i64, ptr %v316.p
  %st222 = getelementptr i64, ptr %v314, i64 1
  store i64 %v316, ptr %st222
  %v317.p = getelementptr i64, ptr %v313, i64 2
  %v317 = load i64, ptr %v317.p
  %st223 = getelementptr i64, ptr %v314, i64 2
  store i64 %v317, ptr %st223
  %v318.p = getelementptr i64, ptr %v313, i64 3
  %v318 = load i64, ptr %v318.p
  %st224 = getelementptr i64, ptr %v314, i64 3
  store i64 %v318, ptr %st224
  %v319.p = getelementptr i64, ptr %v313, i64 4
  %v319 = load i64, ptr %v319.p
  %st225 = getelementptr i64, ptr %v314, i64 4
  store i64 %v319, ptr %st225
  %v320 = getelementptr i64, ptr @"str.20", i64 0
  %v321 = add i64 0, 1
  %v322 = add i64 0, 0
  %v323 = getelementptr i64, ptr %s37, i64 0
  %v324 = ptrtoint ptr %v320 to i64
  %st226 = getelementptr i64, ptr %v323, i64 0
  store i64 %v324, ptr %st226
  %st227 = getelementptr i64, ptr %v323, i64 1
  store i64 %v321, ptr %st227
  %st228 = getelementptr i64, ptr %v323, i64 2
  store i64 %v322, ptr %st228
  br label %b62
b61:
  br label %b62
b62:
  %v325 = phi ptr [ %v323, %b60 ], [ %v298, %b61 ]
  %v326 = getelementptr i64, ptr %s38, i64 0
  %v327.p = getelementptr i64, ptr %v325, i64 0
  %v327 = load i64, ptr %v327.p
  %st229 = getelementptr i64, ptr %v326, i64 0
  store i64 %v327, ptr %st229
  %v328.p = getelementptr i64, ptr %v325, i64 1
  %v328 = load i64, ptr %v328.p
  %st230 = getelementptr i64, ptr %v326, i64 1
  store i64 %v328, ptr %st230
  %v329.p = getelementptr i64, ptr %v325, i64 2
  %v329 = load i64, ptr %v329.p
  %st231 = getelementptr i64, ptr %v326, i64 2
  store i64 %v329, ptr %st231
  call void @"rt.region_relocate8"(ptr %v326, i64 %v290)
  %v795 = getelementptr i64, ptr @"rt.meta", i64 0
  %st232 = getelementptr i64, ptr %v795, i64 0
  store i64 %v290, ptr %st232
  %v330 = getelementptr i64, ptr %s39, i64 0
  %v331.p = getelementptr i64, ptr %v326, i64 0
  %v331 = load i64, ptr %v331.p
  %st233 = getelementptr i64, ptr %v330, i64 0
  store i64 %v331, ptr %st233
  %v332.p = getelementptr i64, ptr %v326, i64 1
  %v332 = load i64, ptr %v332.p
  %st234 = getelementptr i64, ptr %v330, i64 1
  store i64 %v332, ptr %st234
  %v333.p = getelementptr i64, ptr %v326, i64 2
  %v333 = load i64, ptr %v333.p
  %st235 = getelementptr i64, ptr %v330, i64 2
  store i64 %v333, ptr %st235
  %v334 = getelementptr i64, ptr @"str.21", i64 0
  %v335 = add i64 0, 3
  %v336 = add i64 0, 0
  %v337 = getelementptr i64, ptr %s40, i64 0
  %v338 = ptrtoint ptr %v334 to i64
  %st236 = getelementptr i64, ptr %v337, i64 0
  store i64 %v338, ptr %st236
  %st237 = getelementptr i64, ptr %v337, i64 1
  store i64 %v335, ptr %st237
  %st238 = getelementptr i64, ptr %v337, i64 2
  store i64 %v336, ptr %st238
  %v339.p = getelementptr i64, ptr %v337, i64 1
  %v339 = load i64, ptr %v339.p
  %v340.p = getelementptr i64, ptr %v330, i64 1
  %v340 = load i64, ptr %v340.p
  %v341 = add i64 %v339, %v340
  %v796 = getelementptr i64, ptr @"rt.meta", i64 0
  %v342.p = getelementptr i64, ptr %v796, i64 0
  %v342 = load i64, ptr %v342.p
  %v343.p = getelementptr i64, ptr %v337, i64 0
  %v343 = load i64, ptr %v343.p
  %v344.p = getelementptr i64, ptr %v337, i64 1
  %v344 = load i64, ptr %v344.p
  %v345.p = getelementptr i64, ptr %v337, i64 2
  %v345 = load i64, ptr %v345.p
  %v346 = call ptr @"rt.cat8"(i64 %v343, i64 %v344, i64 %v345, i64 %v342, i64 %v340)
  %v347 = getelementptr i8, ptr %v346, i64 %v339
  %v348.p = getelementptr i64, ptr %v330, i64 0
  %v348 = load i64, ptr %v348.p
  %v349 = inttoptr i64 %v348 to ptr
  call void @"rt.copy8"(ptr %v347, ptr %v349, i64 %v340)
  %v350 = getelementptr i64, ptr %s41, i64 0
  %v351 = ptrtoint ptr %v346 to i64
  %st239 = getelementptr i64, ptr %v350, i64 0
  store i64 %v351, ptr %st239
  %st240 = getelementptr i64, ptr %v350, i64 1
  store i64 %v341, ptr %st240
  %st241 = getelementptr i64, ptr %v350, i64 2
  store i64 %v342, ptr %st241
  %v352 = getelementptr i64, ptr @"str.22", i64 0
  %v353 = add i64 0, 1
  %v354 = add i64 0, 0
  %v355 = getelementptr i64, ptr %s42, i64 0
  %v356 = ptrtoint ptr %v352 to i64
  %st242 = getelementptr i64, ptr %v355, i64 0
  store i64 %v356, ptr %st242
  %st243 = getelementptr i64, ptr %v355, i64 1
  store i64 %v353, ptr %st243
  %st244 = getelementptr i64, ptr %v355, i64 2
  store i64 %v354, ptr %st244
  %v357.p = getelementptr i64, ptr %v350, i64 1
  %v357 = load i64, ptr %v357.p
  %v358.p = getelementptr i64, ptr %v355, i64 1
  %v358 = load i64, ptr %v358.p
  %v359 = add i64 %v357, %v358
  %v797 = getelementptr i64, ptr @"rt.meta", i64 0
  %v360.p = getelementptr i64, ptr %v797, i64 0
  %v360 = load i64, ptr %v360.p
  %v361.p = getelementptr i64, ptr %v350, i64 0
  %v361 = load i64, ptr %v361.p
  %v362.p = getelementptr i64, ptr %v350, i64 1
  %v362 = load i64, ptr %v362.p
  %v363.p = getelementptr i64, ptr %v350, i64 2
  %v363 = load i64, ptr %v363.p
  %v364 = call ptr @"rt.cat8"(i64 %v361, i64 %v362, i64 %v363, i64 %v360, i64 %v358)
  %v365 = getelementptr i8, ptr %v364, i64 %v357
  %v366.p = getelementptr i64, ptr %v355, i64 0
  %v366 = load i64, ptr %v366.p
  %v367 = inttoptr i64 %v366 to ptr
  call void @"rt.copy8"(ptr %v365, ptr %v367, i64 %v358)
  %v368 = getelementptr i64, ptr %s43, i64 0
  %v369 = ptrtoint ptr %v364 to i64
  %st245 = getelementptr i64, ptr %v368, i64 0
  store i64 %v369, ptr %st245
  %st246 = getelementptr i64, ptr %v368, i64 1
  store i64 %v359, ptr %st246
  %st247 = getelementptr i64, ptr %v368, i64 2
  store i64 %v360, ptr %st247
  call void @"rt.print_str"(ptr %v368)
  %v370 = add i64 0, 10
  call void @"rt.print_char"(i64 %v370)
  br label %b63
b63:
  %v371 = add i64 0, 1
  %v372.p = getelementptr i64, ptr %v31, i64 0
  %v372 = load i64, ptr %v372.p
  %v373 = add i64 %v372, %v371
  %st248 = getelementptr i64, ptr %v31, i64 0
  store i64 %v373, ptr %st248
  %v374.p = getelementptr i64, ptr %v284, i64 1
  %v374 = load i64, ptr %v374.p
  %v375.p = getelementptr i64, ptr %v33, i64 0
  %v375 = load i64, ptr %v375.p
  %v376 = add i64 %v375, %v374
  %st249 = getelementptr i64, ptr %v33, i64 0
  store i64 %v376, ptr %st249
  br label %b57
b64:
  %v386 = add i64 0, 9
  call void @"rt.panic"(i64 %v386)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b65:
  %v387.c = icmp slt i64 %v383, %v382
  %v387 = zext i1 %v387.c to i64
  %c.b65 = icmp ne i64 %v387, 0
  br i1 %c.b65, label %b65.t251, label %b65.e252
b65.t251:
  br label %b66
b65.e252:
  br label %b67
b66:
  %v388 = add i64 0, 10
  call void @"rt.panic"(i64 %v388)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b67:
  %v389.p = getelementptr i64, ptr %v157, i64 1
  %v389 = load i64, ptr %v389.p
  %v390.c = icmp sgt i64 %v383, %v389
  %v390 = zext i1 %v390.c to i64
  %c.b67 = icmp ne i64 %v390, 0
  br i1 %c.b67, label %b67.t253, label %b67.e254
b67.t253:
  br label %b68
b67.e254:
  br label %b69
b68:
  %v391 = add i64 0, 11
  call void @"rt.panic"(i64 %v391)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b69:
  %v392.p = getelementptr i64, ptr %v157, i64 0
  %v392 = load i64, ptr %v392.p
  %v393 = inttoptr i64 %v392 to ptr
  %v394 = getelementptr i8, ptr %v393, i64 %v382
  %v395 = sub i64 %v383, %v382
  %v396.p = getelementptr i64, ptr %v157, i64 2
  %v396 = load i64, ptr %v396.p
  %v397 = getelementptr i64, ptr %s43, i64 0
  %v398 = ptrtoint ptr %v394 to i64
  %st254 = getelementptr i64, ptr %v397, i64 0
  store i64 %v398, ptr %st254
  %st255 = getelementptr i64, ptr %v397, i64 1
  store i64 %v395, ptr %st255
  %st256 = getelementptr i64, ptr %v397, i64 2
  store i64 %v396, ptr %st256
  %v399.p = getelementptr i64, ptr %v397, i64 0
  %v399 = load i64, ptr %v399.p
  %v400.p = getelementptr i64, ptr %v397, i64 1
  %v400 = load i64, ptr %v400.p
  %v401.p = getelementptr i64, ptr %v397, i64 2
  %v401 = load i64, ptr %v401.p
  call void @"std/io.joined"(ptr %v378, i64 %v379, i64 %v380, i64 %v381, i64 %v399, i64 %v400, i64 %v401)
  %v402.p = getelementptr i64, ptr %v378, i64 0
  %v402 = load i64, ptr %v402.p
  %v403.p = getelementptr i64, ptr %v378, i64 1
  %v403 = load i64, ptr %v403.p
  %v404.p = getelementptr i64, ptr %v378, i64 2
  %v404 = load i64, ptr %v404.p
  call void @"std/io.dropCR"(ptr %v377, i64 %v402, i64 %v403, i64 %v404)
  %v405 = getelementptr i64, ptr %s42, i64 0
  %v406.p = getelementptr i64, ptr %v377, i64 0
  %v406 = load i64, ptr %v406.p
  %st257 = getelementptr i64, ptr %v405, i64 0
  store i64 %v406, ptr %st257
  %v407.p = getelementptr i64, ptr %v377, i64 1
  %v407 = load i64, ptr %v407.p
  %st258 = getelementptr i64, ptr %v405, i64 1
  store i64 %v407, ptr %st258
  %v408.p = getelementptr i64, ptr %v377, i64 2
  %v408 = load i64, ptr %v408.p
  %st259 = getelementptr i64, ptr %v405, i64 2
  store i64 %v408, ptr %st259
  %v409 = getelementptr i64, ptr %s46, i64 0
  %v410 = add i64 0, 0
  %v411 = getelementptr i64, ptr %s47, i64 0
  %v412 = getelementptr i64, ptr %s41, i64 0
  %v413 = add i64 0, 0
  %st260 = getelementptr i64, ptr %v412, i64 0
  store i64 %v413, ptr %st260
  %st261 = getelementptr i64, ptr %v412, i64 1
  store i64 %v413, ptr %st261
  %st262 = getelementptr i64, ptr %v412, i64 2
  store i64 %v413, ptr %st262
  %v414.p = getelementptr i64, ptr %v405, i64 0
  %v414 = load i64, ptr %v414.p
  %st263 = getelementptr i64, ptr %v412, i64 0
  store i64 %v414, ptr %st263
  %v415.p = getelementptr i64, ptr %v405, i64 1
  %v415 = load i64, ptr %v415.p
  %st264 = getelementptr i64, ptr %v412, i64 1
  store i64 %v415, ptr %st264
  %v416.p = getelementptr i64, ptr %v405, i64 2
  %v416 = load i64, ptr %v416.p
  %st265 = getelementptr i64, ptr %v412, i64 2
  store i64 %v416, ptr %st265
  %v417 = getelementptr i64, ptr %s40, i64 0
  %v418.p = getelementptr i64, ptr %v412, i64 0
  %v418 = load i64, ptr %v418.p
  %st266 = getelementptr i64, ptr %v417, i64 0
  store i64 %v418, ptr %st266
  %v419.p = getelementptr i64, ptr %v412, i64 1
  %v419 = load i64, ptr %v419.p
  %st267 = getelementptr i64, ptr %v417, i64 1
  store i64 %v419, ptr %st267
  %v420.p = getelementptr i64, ptr %v412, i64 2
  %v420 = load i64, ptr %v420.p
  %st268 = getelementptr i64, ptr %v417, i64 2
  store i64 %v420, ptr %st268
  %v798 = getelementptr i64, ptr @"rt.meta", i64 0
  %v421.p = getelementptr i64, ptr %v798, i64 0
  %v421 = load i64, ptr %v421.p
  %v422 = getelementptr i64, ptr %s48, i64 0
  %v423.p = getelementptr i64, ptr %v417, i64 0
  %v423 = load i64, ptr %v423.p
  %v424.p = getelementptr i64, ptr %v417, i64 1
  %v424 = load i64, ptr %v424.p
  %v425.p = getelementptr i64, ptr %v417, i64 2
  %v425 = load i64, ptr %v425.p
  call void @"std/io.Raw"(ptr %v422, i64 %v423, i64 %v424, i64 %v425)
  %v426 = getelementptr i64, ptr %s39, i64 0
  %v427.p = getelementptr i64, ptr %v422, i64 0
  %v427 = load i64, ptr %v427.p
  %st269 = getelementptr i64, ptr %v426, i64 0
  store i64 %v427, ptr %st269
  %v428.p = getelementptr i64, ptr %v422, i64 1
  %v428 = load i64, ptr %v428.p
  %st270 = getelementptr i64, ptr %v426, i64 1
  store i64 %v428, ptr %st270
  %v429.p = getelementptr i64, ptr %v422, i64 2
  %v429 = load i64, ptr %v429.p
  %st271 = getelementptr i64, ptr %v426, i64 2
  store i64 %v429, ptr %st271
  %v430.p = getelementptr i64, ptr %v31, i64 0
  %v430 = load i64, ptr %v430.p
  %v431.c = icmp slt i64 %v430, %v4
  %v431 = zext i1 %v431.c to i64
  %c.b69 = icmp ne i64 %v431, 0
  br i1 %c.b69, label %b69.t273, label %b69.e274
b69.t273:
  br label %b71
b69.e274:
  br label %b72
b70:
  %v799 = getelementptr i64, ptr @"rt.meta", i64 0
  %st274 = getelementptr i64, ptr %v799, i64 0
  store i64 %v421, ptr %st274
  %v519 = add i64 0, 1
  %v520 = add i64 %v6, %v519
  %v521 = add i64 0, 0
  %v522 = call ptr @"rt.region_alloc8"(i64 %v520, i64 %v521)
  %v523 = add i64 0, 0
  %v524 = getelementptr i64, ptr %s39, i64 0
  %v525 = ptrtoint ptr %v522 to i64
  %st275 = getelementptr i64, ptr %v524, i64 0
  store i64 %v525, ptr %st275
  %st276 = getelementptr i64, ptr %v524, i64 1
  store i64 %v523, ptr %st276
  %st277 = getelementptr i64, ptr %v524, i64 2
  store i64 %v520, ptr %st277
  %v526 = getelementptr i64, ptr %s40, i64 0
  %v527.p = getelementptr i64, ptr %v524, i64 0
  %v527 = load i64, ptr %v527.p
  %st278 = getelementptr i64, ptr %v526, i64 0
  store i64 %v527, ptr %st278
  %v528.p = getelementptr i64, ptr %v524, i64 1
  %v528 = load i64, ptr %v528.p
  %st279 = getelementptr i64, ptr %v526, i64 1
  store i64 %v528, ptr %st279
  %v529.p = getelementptr i64, ptr %v524, i64 2
  %v529 = load i64, ptr %v529.p
  %st280 = getelementptr i64, ptr %v526, i64 2
  store i64 %v529, ptr %st280
  %v530 = add i64 0, 1
  %v531 = add i64 %v6, %v530
  call void @"rt.region_relocate8"(ptr %v526, i64 %v531)
  %v532.p = getelementptr i64, ptr %v526, i64 0
  %v532 = load i64, ptr %v532.p
  %st281 = getelementptr i64, ptr %v45, i64 0
  store i64 %v532, ptr %st281
  %v533.p = getelementptr i64, ptr %v526, i64 1
  %v533 = load i64, ptr %v533.p
  %st282 = getelementptr i64, ptr %v45, i64 1
  store i64 %v533, ptr %st282
  %v534.p = getelementptr i64, ptr %v526, i64 2
  %v534 = load i64, ptr %v534.p
  %st283 = getelementptr i64, ptr %v45, i64 2
  store i64 %v534, ptr %st283
  br label %b77
b71:
  %v800 = getelementptr i64, ptr @"rt.meta", i64 0
  %v432.p = getelementptr i64, ptr %v800, i64 0
  %v432 = load i64, ptr %v432.p
  call void @"rt.region_enter"()
  %v801 = getelementptr i64, ptr @"rt.meta", i64 0
  %v433.p = getelementptr i64, ptr %v801, i64 0
  %v433 = load i64, ptr %v433.p
  %v434 = getelementptr i64, ptr %s49, i64 0
  %v435.p = getelementptr i64, ptr %v426, i64 0
  %v435 = load i64, ptr %v435.p
  %v436.p = getelementptr i64, ptr %v426, i64 1
  %v436 = load i64, ptr %v436.p
  %v437.p = getelementptr i64, ptr %v426, i64 2
  %v437 = load i64, ptr %v437.p
  call void @"std/internal/utf8.Parse"(ptr %v434, i64 %v435, i64 %v436, i64 %v437)
  %v438 = add i64 0, 3
  %v439 = getelementptr i64, ptr %v434, i64 %v438
  %v440 = getelementptr i64, ptr %s37, i64 0
  %v441.p = getelementptr i64, ptr %v434, i64 0
  %v441 = load i64, ptr %v441.p
  %st284 = getelementptr i64, ptr %v440, i64 0
  store i64 %v441, ptr %st284
  %v442.p = getelementptr i64, ptr %v434, i64 1
  %v442 = load i64, ptr %v442.p
  %st285 = getelementptr i64, ptr %v440, i64 1
  store i64 %v442, ptr %st285
  %v443.p = getelementptr i64, ptr %v434, i64 2
  %v443 = load i64, ptr %v443.p
  %st286 = getelementptr i64, ptr %v440, i64 2
  store i64 %v443, ptr %st286
  %v444 = getelementptr i64, ptr %s15, i64 0
  %v445.p = getelementptr i64, ptr %v439, i64 0
  %v445 = load i64, ptr %v445.p
  %st287 = getelementptr i64, ptr %v444, i64 0
  store i64 %v445, ptr %st287
  %v446.p = getelementptr i64, ptr %v439, i64 1
  %v446 = load i64, ptr %v446.p
  %st288 = getelementptr i64, ptr %v444, i64 1
  store i64 %v446, ptr %st288
  %v447.p = getelementptr i64, ptr %v439, i64 2
  %v447 = load i64, ptr %v447.p
  %st289 = getelementptr i64, ptr %v444, i64 2
  store i64 %v447, ptr %st289
  %v448.p = getelementptr i64, ptr %v439, i64 3
  %v448 = load i64, ptr %v448.p
  %st290 = getelementptr i64, ptr %v444, i64 3
  store i64 %v448, ptr %st290
  %v449.p = getelementptr i64, ptr %v439, i64 4
  %v449 = load i64, ptr %v449.p
  %st291 = getelementptr i64, ptr %v444, i64 4
  store i64 %v449, ptr %st291
  %v450.p = getelementptr i64, ptr %v439, i64 5
  %v450 = load i64, ptr %v450.p
  %st292 = getelementptr i64, ptr %v444, i64 5
  store i64 %v450, ptr %st292
  %v451.p = getelementptr i64, ptr %v444, i64 0
  %v451 = load i64, ptr %v451.p
  %v452 = add i64 0, 0
  %v453.c = icmp ne i64 %v451, %v452
  %v453 = zext i1 %v453.c to i64
  %c.b71 = icmp ne i64 %v453, 0
  br i1 %c.b71, label %b71.t294, label %b71.e295
b71.t294:
  br label %b73
b71.e295:
  br label %b74
b72:
  br label %b76
b73:
  %v454 = add i64 0, 1
  %v455 = getelementptr i64, ptr %v444, i64 %v454
  %v456 = getelementptr i64, ptr %s14, i64 0
  %v457.p = getelementptr i64, ptr %v455, i64 0
  %v457 = load i64, ptr %v457.p
  %st295 = getelementptr i64, ptr %v456, i64 0
  store i64 %v457, ptr %st295
  %v458.p = getelementptr i64, ptr %v455, i64 1
  %v458 = load i64, ptr %v458.p
  %st296 = getelementptr i64, ptr %v456, i64 1
  store i64 %v458, ptr %st296
  %v459.p = getelementptr i64, ptr %v455, i64 2
  %v459 = load i64, ptr %v459.p
  %st297 = getelementptr i64, ptr %v456, i64 2
  store i64 %v459, ptr %st297
  %v460.p = getelementptr i64, ptr %v455, i64 3
  %v460 = load i64, ptr %v460.p
  %st298 = getelementptr i64, ptr %v456, i64 3
  store i64 %v460, ptr %st298
  %v461.p = getelementptr i64, ptr %v455, i64 4
  %v461 = load i64, ptr %v461.p
  %st299 = getelementptr i64, ptr %v456, i64 4
  store i64 %v461, ptr %st299
  %v462 = getelementptr i64, ptr @"str.20", i64 0
  %v463 = add i64 0, 1
  %v464 = add i64 0, 0
  %v465 = getelementptr i64, ptr %s36, i64 0
  %v466 = ptrtoint ptr %v462 to i64
  %st300 = getelementptr i64, ptr %v465, i64 0
  store i64 %v466, ptr %st300
  %st301 = getelementptr i64, ptr %v465, i64 1
  store i64 %v463, ptr %st301
  %st302 = getelementptr i64, ptr %v465, i64 2
  store i64 %v464, ptr %st302
  br label %b75
b74:
  br label %b75
b75:
  %v467 = phi ptr [ %v465, %b73 ], [ %v440, %b74 ]
  %v468 = getelementptr i64, ptr %s50, i64 0
  %v469.p = getelementptr i64, ptr %v467, i64 0
  %v469 = load i64, ptr %v469.p
  %st303 = getelementptr i64, ptr %v468, i64 0
  store i64 %v469, ptr %st303
  %v470.p = getelementptr i64, ptr %v467, i64 1
  %v470 = load i64, ptr %v470.p
  %st304 = getelementptr i64, ptr %v468, i64 1
  store i64 %v470, ptr %st304
  %v471.p = getelementptr i64, ptr %v467, i64 2
  %v471 = load i64, ptr %v471.p
  %st305 = getelementptr i64, ptr %v468, i64 2
  store i64 %v471, ptr %st305
  call void @"rt.region_relocate8"(ptr %v468, i64 %v432)
  %v802 = getelementptr i64, ptr @"rt.meta", i64 0
  %st306 = getelementptr i64, ptr %v802, i64 0
  store i64 %v432, ptr %st306
  %v472 = getelementptr i64, ptr %s51, i64 0
  %v473.p = getelementptr i64, ptr %v468, i64 0
  %v473 = load i64, ptr %v473.p
  %st307 = getelementptr i64, ptr %v472, i64 0
  store i64 %v473, ptr %st307
  %v474.p = getelementptr i64, ptr %v468, i64 1
  %v474 = load i64, ptr %v474.p
  %st308 = getelementptr i64, ptr %v472, i64 1
  store i64 %v474, ptr %st308
  %v475.p = getelementptr i64, ptr %v468, i64 2
  %v475 = load i64, ptr %v475.p
  %st309 = getelementptr i64, ptr %v472, i64 2
  store i64 %v475, ptr %st309
  %v476 = getelementptr i64, ptr @"str.21", i64 0
  %v477 = add i64 0, 3
  %v478 = add i64 0, 0
  %v479 = getelementptr i64, ptr %s52, i64 0
  %v480 = ptrtoint ptr %v476 to i64
  %st310 = getelementptr i64, ptr %v479, i64 0
  store i64 %v480, ptr %st310
  %st311 = getelementptr i64, ptr %v479, i64 1
  store i64 %v477, ptr %st311
  %st312 = getelementptr i64, ptr %v479, i64 2
  store i64 %v478, ptr %st312
  %v481.p = getelementptr i64, ptr %v479, i64 1
  %v481 = load i64, ptr %v481.p
  %v482.p = getelementptr i64, ptr %v472, i64 1
  %v482 = load i64, ptr %v482.p
  %v483 = add i64 %v481, %v482
  %v803 = getelementptr i64, ptr @"rt.meta", i64 0
  %v484.p = getelementptr i64, ptr %v803, i64 0
  %v484 = load i64, ptr %v484.p
  %v485.p = getelementptr i64, ptr %v479, i64 0
  %v485 = load i64, ptr %v485.p
  %v486.p = getelementptr i64, ptr %v479, i64 1
  %v486 = load i64, ptr %v486.p
  %v487.p = getelementptr i64, ptr %v479, i64 2
  %v487 = load i64, ptr %v487.p
  %v488 = call ptr @"rt.cat8"(i64 %v485, i64 %v486, i64 %v487, i64 %v484, i64 %v482)
  %v489 = getelementptr i8, ptr %v488, i64 %v481
  %v490.p = getelementptr i64, ptr %v472, i64 0
  %v490 = load i64, ptr %v490.p
  %v491 = inttoptr i64 %v490 to ptr
  call void @"rt.copy8"(ptr %v489, ptr %v491, i64 %v482)
  %v492 = getelementptr i64, ptr %s53, i64 0
  %v493 = ptrtoint ptr %v488 to i64
  %st313 = getelementptr i64, ptr %v492, i64 0
  store i64 %v493, ptr %st313
  %st314 = getelementptr i64, ptr %v492, i64 1
  store i64 %v483, ptr %st314
  %st315 = getelementptr i64, ptr %v492, i64 2
  store i64 %v484, ptr %st315
  %v494 = getelementptr i64, ptr @"str.22", i64 0
  %v495 = add i64 0, 1
  %v496 = add i64 0, 0
  %v497 = getelementptr i64, ptr %s54, i64 0
  %v498 = ptrtoint ptr %v494 to i64
  %st316 = getelementptr i64, ptr %v497, i64 0
  store i64 %v498, ptr %st316
  %st317 = getelementptr i64, ptr %v497, i64 1
  store i64 %v495, ptr %st317
  %st318 = getelementptr i64, ptr %v497, i64 2
  store i64 %v496, ptr %st318
  %v499.p = getelementptr i64, ptr %v492, i64 1
  %v499 = load i64, ptr %v499.p
  %v500.p = getelementptr i64, ptr %v497, i64 1
  %v500 = load i64, ptr %v500.p
  %v501 = add i64 %v499, %v500
  %v804 = getelementptr i64, ptr @"rt.meta", i64 0
  %v502.p = getelementptr i64, ptr %v804, i64 0
  %v502 = load i64, ptr %v502.p
  %v503.p = getelementptr i64, ptr %v492, i64 0
  %v503 = load i64, ptr %v503.p
  %v504.p = getelementptr i64, ptr %v492, i64 1
  %v504 = load i64, ptr %v504.p
  %v505.p = getelementptr i64, ptr %v492, i64 2
  %v505 = load i64, ptr %v505.p
  %v506 = call ptr @"rt.cat8"(i64 %v503, i64 %v504, i64 %v505, i64 %v502, i64 %v500)
  %v507 = getelementptr i8, ptr %v506, i64 %v499
  %v508.p = getelementptr i64, ptr %v497, i64 0
  %v508 = load i64, ptr %v508.p
  %v509 = inttoptr i64 %v508 to ptr
  call void @"rt.copy8"(ptr %v507, ptr %v509, i64 %v500)
  %v510 = getelementptr i64, ptr %s55, i64 0
  %v511 = ptrtoint ptr %v506 to i64
  %st319 = getelementptr i64, ptr %v510, i64 0
  store i64 %v511, ptr %st319
  %st320 = getelementptr i64, ptr %v510, i64 1
  store i64 %v501, ptr %st320
  %st321 = getelementptr i64, ptr %v510, i64 2
  store i64 %v502, ptr %st321
  call void @"rt.print_str"(ptr %v510)
  %v512 = add i64 0, 10
  call void @"rt.print_char"(i64 %v512)
  br label %b76
b76:
  %v513 = add i64 0, 1
  %v514.p = getelementptr i64, ptr %v31, i64 0
  %v514 = load i64, ptr %v514.p
  %v515 = add i64 %v514, %v513
  %st322 = getelementptr i64, ptr %v31, i64 0
  store i64 %v515, ptr %st322
  %v516.p = getelementptr i64, ptr %v426, i64 1
  %v516 = load i64, ptr %v516.p
  %v517.p = getelementptr i64, ptr %v33, i64 0
  %v517 = load i64, ptr %v517.p
  %v518 = add i64 %v517, %v516
  %st323 = getelementptr i64, ptr %v33, i64 0
  store i64 %v518, ptr %st323
  br label %b70
b77:
  %v535.p = getelementptr i64, ptr %v169, i64 0
  %v535 = load i64, ptr %v535.p
  %v536 = add i64 0, 1
  %v537 = add i64 %v535, %v536
  %st324 = getelementptr i64, ptr %v162, i64 0
  store i64 %v537, ptr %st324
  br label %b78
b78:
  br label %b29
b79:
  %v549 = add i64 0, 3
  %v550 = getelementptr i64, ptr %v59, i64 %v549
  %v805 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v550, i64 %v805, i64 %v60)
  br label %b80
b80:
  %v806 = getelementptr i64, ptr @"rt.meta", i64 0
  %st325 = getelementptr i64, ptr %v806, i64 0
  store i64 %v60, ptr %st325
  br label %b9
b81:
  %v560 = add i64 0, 3
  %v561 = getelementptr i64, ptr %v52, i64 %v560
  %v807 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v561, i64 %v807, i64 %v53)
  br label %b82
b82:
  %v808 = getelementptr i64, ptr @"rt.meta", i64 0
  %st326 = getelementptr i64, ptr %v808, i64 0
  store i64 %v53, ptr %st326
  br label %b8
b83:
  %v565 = add i64 0, 0
  %v566.p = getelementptr i64, ptr %v52, i64 0
  %v566 = load i64, ptr %v566.p
  %st327 = getelementptr i64, ptr %v37, i64 0
  store i64 %v566, ptr %st327
  %v567.p = getelementptr i64, ptr %v52, i64 1
  %v567 = load i64, ptr %v567.p
  %st328 = getelementptr i64, ptr %v37, i64 1
  store i64 %v567, ptr %st328
  %v568.p = getelementptr i64, ptr %v52, i64 2
  %v568 = load i64, ptr %v568.p
  %st329 = getelementptr i64, ptr %v37, i64 2
  store i64 %v568, ptr %st329
  %v569.p = getelementptr i64, ptr %v52, i64 3
  %v569 = load i64, ptr %v569.p
  %st330 = getelementptr i64, ptr %v37, i64 3
  store i64 %v569, ptr %st330
  %v570.p = getelementptr i64, ptr %v52, i64 4
  %v570 = load i64, ptr %v570.p
  %st331 = getelementptr i64, ptr %v37, i64 4
  store i64 %v570, ptr %st331
  %v571.p = getelementptr i64, ptr %v52, i64 5
  %v571 = load i64, ptr %v571.p
  %st332 = getelementptr i64, ptr %v37, i64 5
  store i64 %v571, ptr %st332
  %v572.p = getelementptr i64, ptr %v37, i64 0
  %v572 = load i64, ptr %v572.p
  %v573 = add i64 0, 0
  %v574.c = icmp ne i64 %v572, %v573
  %v574 = zext i1 %v574.c to i64
  %c.b83 = icmp ne i64 %v574, 0
  br i1 %c.b83, label %b83.t334, label %b83.e335
b83.t334:
  br label %b85
b83.e335:
  br label %b86
b84:
  br label %b7
b85:
  %v575 = add i64 0, 3
  %v576 = getelementptr i64, ptr %v37, i64 %v575
  %v809 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v576, i64 %v809, i64 %v38)
  br label %b86
b86:
  %v810 = getelementptr i64, ptr @"rt.meta", i64 0
  %st335 = getelementptr i64, ptr %v810, i64 0
  store i64 %v38, ptr %st335
  br label %b6
b87:
  %v580 = getelementptr i64, ptr %s56, i64 0
  %v581 = getelementptr i64, ptr %s57, i64 0
  %v582.p = getelementptr i64, ptr %v45, i64 0
  %v582 = load i64, ptr %v582.p
  %v583.p = getelementptr i64, ptr %v45, i64 1
  %v583 = load i64, ptr %v583.p
  %v584.p = getelementptr i64, ptr %v45, i64 2
  %v584 = load i64, ptr %v584.p
  %v811 = getelementptr i64, ptr @"rt.meta", i64 0
  %v585.p = getelementptr i64, ptr %v811, i64 0
  %v585 = load i64, ptr %v585.p
  %v586 = add i64 0, 0
  %v587 = call ptr @"rt.region_alloc8"(i64 %v585, i64 %v586)
  %v588 = add i64 0, 0
  %v589 = getelementptr i64, ptr %s22, i64 0
  %v590 = ptrtoint ptr %v587 to i64
  %st336 = getelementptr i64, ptr %v589, i64 0
  store i64 %v590, ptr %st336
  %st337 = getelementptr i64, ptr %v589, i64 1
  store i64 %v588, ptr %st337
  %st338 = getelementptr i64, ptr %v589, i64 2
  store i64 %v585, ptr %st338
  %v591.p = getelementptr i64, ptr %v589, i64 0
  %v591 = load i64, ptr %v591.p
  %v592.p = getelementptr i64, ptr %v589, i64 1
  %v592 = load i64, ptr %v592.p
  %v593.p = getelementptr i64, ptr %v589, i64 2
  %v593 = load i64, ptr %v593.p
  call void @"std/io.joined"(ptr %v581, i64 %v582, i64 %v583, i64 %v584, i64 %v591, i64 %v592, i64 %v593)
  %v594.p = getelementptr i64, ptr %v581, i64 0
  %v594 = load i64, ptr %v594.p
  %v595.p = getelementptr i64, ptr %v581, i64 1
  %v595 = load i64, ptr %v595.p
  %v596.p = getelementptr i64, ptr %v581, i64 2
  %v596 = load i64, ptr %v596.p
  call void @"std/io.dropCR"(ptr %v580, i64 %v594, i64 %v595, i64 %v596)
  %v597 = getelementptr i64, ptr %s21, i64 0
  %v598.p = getelementptr i64, ptr %v580, i64 0
  %v598 = load i64, ptr %v598.p
  %st339 = getelementptr i64, ptr %v597, i64 0
  store i64 %v598, ptr %st339
  %v599.p = getelementptr i64, ptr %v580, i64 1
  %v599 = load i64, ptr %v599.p
  %st340 = getelementptr i64, ptr %v597, i64 1
  store i64 %v599, ptr %st340
  %v600.p = getelementptr i64, ptr %v580, i64 2
  %v600 = load i64, ptr %v600.p
  %st341 = getelementptr i64, ptr %v597, i64 2
  store i64 %v600, ptr %st341
  %v601 = getelementptr i64, ptr %s9, i64 0
  %v602 = add i64 0, 0
  %v603 = getelementptr i64, ptr %s11, i64 0
  %v604 = getelementptr i64, ptr %s20, i64 0
  %v605 = add i64 0, 0
  %st342 = getelementptr i64, ptr %v604, i64 0
  store i64 %v605, ptr %st342
  %st343 = getelementptr i64, ptr %v604, i64 1
  store i64 %v605, ptr %st343
  %st344 = getelementptr i64, ptr %v604, i64 2
  store i64 %v605, ptr %st344
  %v606.p = getelementptr i64, ptr %v597, i64 0
  %v606 = load i64, ptr %v606.p
  %st345 = getelementptr i64, ptr %v604, i64 0
  store i64 %v606, ptr %st345
  %v607.p = getelementptr i64, ptr %v597, i64 1
  %v607 = load i64, ptr %v607.p
  %st346 = getelementptr i64, ptr %v604, i64 1
  store i64 %v607, ptr %st346
  %v608.p = getelementptr i64, ptr %v597, i64 2
  %v608 = load i64, ptr %v608.p
  %st347 = getelementptr i64, ptr %v604, i64 2
  store i64 %v608, ptr %st347
  %v609 = getelementptr i64, ptr %s7, i64 0
  %v610.p = getelementptr i64, ptr %v604, i64 0
  %v610 = load i64, ptr %v610.p
  %st348 = getelementptr i64, ptr %v609, i64 0
  store i64 %v610, ptr %st348
  %v611.p = getelementptr i64, ptr %v604, i64 1
  %v611 = load i64, ptr %v611.p
  %st349 = getelementptr i64, ptr %v609, i64 1
  store i64 %v611, ptr %st349
  %v612.p = getelementptr i64, ptr %v604, i64 2
  %v612 = load i64, ptr %v612.p
  %st350 = getelementptr i64, ptr %v609, i64 2
  store i64 %v612, ptr %st350
  %v812 = getelementptr i64, ptr @"rt.meta", i64 0
  %v613.p = getelementptr i64, ptr %v812, i64 0
  %v613 = load i64, ptr %v613.p
  %v614 = getelementptr i64, ptr %s58, i64 0
  %v615.p = getelementptr i64, ptr %v609, i64 0
  %v615 = load i64, ptr %v615.p
  %v616.p = getelementptr i64, ptr %v609, i64 1
  %v616 = load i64, ptr %v616.p
  %v617.p = getelementptr i64, ptr %v609, i64 2
  %v617 = load i64, ptr %v617.p
  call void @"std/io.Raw"(ptr %v614, i64 %v615, i64 %v616, i64 %v617)
  %v618 = getelementptr i64, ptr %s16, i64 0
  %v619.p = getelementptr i64, ptr %v614, i64 0
  %v619 = load i64, ptr %v619.p
  %st351 = getelementptr i64, ptr %v618, i64 0
  store i64 %v619, ptr %st351
  %v620.p = getelementptr i64, ptr %v614, i64 1
  %v620 = load i64, ptr %v620.p
  %st352 = getelementptr i64, ptr %v618, i64 1
  store i64 %v620, ptr %st352
  %v621.p = getelementptr i64, ptr %v614, i64 2
  %v621 = load i64, ptr %v621.p
  %st353 = getelementptr i64, ptr %v618, i64 2
  store i64 %v621, ptr %st353
  %v622.p = getelementptr i64, ptr %v31, i64 0
  %v622 = load i64, ptr %v622.p
  %v623.c = icmp slt i64 %v622, %v4
  %v623 = zext i1 %v623.c to i64
  %c.b87 = icmp ne i64 %v623, 0
  br i1 %c.b87, label %b87.t355, label %b87.e356
b87.t355:
  br label %b90
b87.e356:
  br label %b91
b88:
  br label %b96
b89:
  %v813 = getelementptr i64, ptr @"rt.meta", i64 0
  %st356 = getelementptr i64, ptr %v813, i64 0
  store i64 %v613, ptr %st356
  br label %b96
b90:
  %v814 = getelementptr i64, ptr @"rt.meta", i64 0
  %v624.p = getelementptr i64, ptr %v814, i64 0
  %v624 = load i64, ptr %v624.p
  call void @"rt.region_enter"()
  %v815 = getelementptr i64, ptr @"rt.meta", i64 0
  %v625.p = getelementptr i64, ptr %v815, i64 0
  %v625 = load i64, ptr %v625.p
  %v626 = getelementptr i64, ptr %s59, i64 0
  %v627.p = getelementptr i64, ptr %v618, i64 0
  %v627 = load i64, ptr %v627.p
  %v628.p = getelementptr i64, ptr %v618, i64 1
  %v628 = load i64, ptr %v628.p
  %v629.p = getelementptr i64, ptr %v618, i64 2
  %v629 = load i64, ptr %v629.p
  call void @"std/internal/utf8.Parse"(ptr %v626, i64 %v627, i64 %v628, i64 %v629)
  %v630 = add i64 0, 3
  %v631 = getelementptr i64, ptr %v626, i64 %v630
  %v632 = getelementptr i64, ptr %s34, i64 0
  %v633.p = getelementptr i64, ptr %v626, i64 0
  %v633 = load i64, ptr %v633.p
  %st357 = getelementptr i64, ptr %v632, i64 0
  store i64 %v633, ptr %st357
  %v634.p = getelementptr i64, ptr %v626, i64 1
  %v634 = load i64, ptr %v634.p
  %st358 = getelementptr i64, ptr %v632, i64 1
  store i64 %v634, ptr %st358
  %v635.p = getelementptr i64, ptr %v626, i64 2
  %v635 = load i64, ptr %v635.p
  %st359 = getelementptr i64, ptr %v632, i64 2
  store i64 %v635, ptr %st359
  %v636 = getelementptr i64, ptr %s15, i64 0
  %v637.p = getelementptr i64, ptr %v631, i64 0
  %v637 = load i64, ptr %v637.p
  %st360 = getelementptr i64, ptr %v636, i64 0
  store i64 %v637, ptr %st360
  %v638.p = getelementptr i64, ptr %v631, i64 1
  %v638 = load i64, ptr %v638.p
  %st361 = getelementptr i64, ptr %v636, i64 1
  store i64 %v638, ptr %st361
  %v639.p = getelementptr i64, ptr %v631, i64 2
  %v639 = load i64, ptr %v639.p
  %st362 = getelementptr i64, ptr %v636, i64 2
  store i64 %v639, ptr %st362
  %v640.p = getelementptr i64, ptr %v631, i64 3
  %v640 = load i64, ptr %v640.p
  %st363 = getelementptr i64, ptr %v636, i64 3
  store i64 %v640, ptr %st363
  %v641.p = getelementptr i64, ptr %v631, i64 4
  %v641 = load i64, ptr %v641.p
  %st364 = getelementptr i64, ptr %v636, i64 4
  store i64 %v641, ptr %st364
  %v642.p = getelementptr i64, ptr %v631, i64 5
  %v642 = load i64, ptr %v642.p
  %st365 = getelementptr i64, ptr %v636, i64 5
  store i64 %v642, ptr %st365
  %v643.p = getelementptr i64, ptr %v636, i64 0
  %v643 = load i64, ptr %v643.p
  %v644 = add i64 0, 0
  %v645.c = icmp ne i64 %v643, %v644
  %v645 = zext i1 %v645.c to i64
  %c.b90 = icmp ne i64 %v645, 0
  br i1 %c.b90, label %b90.t367, label %b90.e368
b90.t367:
  br label %b92
b90.e368:
  br label %b93
b91:
  br label %b95
b92:
  %v646 = add i64 0, 1
  %v647 = getelementptr i64, ptr %v636, i64 %v646
  %v648 = getelementptr i64, ptr %s14, i64 0
  %v649.p = getelementptr i64, ptr %v647, i64 0
  %v649 = load i64, ptr %v649.p
  %st368 = getelementptr i64, ptr %v648, i64 0
  store i64 %v649, ptr %st368
  %v650.p = getelementptr i64, ptr %v647, i64 1
  %v650 = load i64, ptr %v650.p
  %st369 = getelementptr i64, ptr %v648, i64 1
  store i64 %v650, ptr %st369
  %v651.p = getelementptr i64, ptr %v647, i64 2
  %v651 = load i64, ptr %v651.p
  %st370 = getelementptr i64, ptr %v648, i64 2
  store i64 %v651, ptr %st370
  %v652.p = getelementptr i64, ptr %v647, i64 3
  %v652 = load i64, ptr %v652.p
  %st371 = getelementptr i64, ptr %v648, i64 3
  store i64 %v652, ptr %st371
  %v653.p = getelementptr i64, ptr %v647, i64 4
  %v653 = load i64, ptr %v653.p
  %st372 = getelementptr i64, ptr %v648, i64 4
  store i64 %v653, ptr %st372
  %v654 = getelementptr i64, ptr @"str.20", i64 0
  %v655 = add i64 0, 1
  %v656 = add i64 0, 0
  %v657 = getelementptr i64, ptr %s32, i64 0
  %v658 = ptrtoint ptr %v654 to i64
  %st373 = getelementptr i64, ptr %v657, i64 0
  store i64 %v658, ptr %st373
  %st374 = getelementptr i64, ptr %v657, i64 1
  store i64 %v655, ptr %st374
  %st375 = getelementptr i64, ptr %v657, i64 2
  store i64 %v656, ptr %st375
  br label %b94
b93:
  br label %b94
b94:
  %v659 = phi ptr [ %v657, %b92 ], [ %v632, %b93 ]
  %v660 = getelementptr i64, ptr %s31, i64 0
  %v661.p = getelementptr i64, ptr %v659, i64 0
  %v661 = load i64, ptr %v661.p
  %st376 = getelementptr i64, ptr %v660, i64 0
  store i64 %v661, ptr %st376
  %v662.p = getelementptr i64, ptr %v659, i64 1
  %v662 = load i64, ptr %v662.p
  %st377 = getelementptr i64, ptr %v660, i64 1
  store i64 %v662, ptr %st377
  %v663.p = getelementptr i64, ptr %v659, i64 2
  %v663 = load i64, ptr %v663.p
  %st378 = getelementptr i64, ptr %v660, i64 2
  store i64 %v663, ptr %st378
  call void @"rt.region_relocate8"(ptr %v660, i64 %v624)
  %v816 = getelementptr i64, ptr @"rt.meta", i64 0
  %st379 = getelementptr i64, ptr %v816, i64 0
  store i64 %v624, ptr %st379
  %v664 = getelementptr i64, ptr %s26, i64 0
  %v665.p = getelementptr i64, ptr %v660, i64 0
  %v665 = load i64, ptr %v665.p
  %st380 = getelementptr i64, ptr %v664, i64 0
  store i64 %v665, ptr %st380
  %v666.p = getelementptr i64, ptr %v660, i64 1
  %v666 = load i64, ptr %v666.p
  %st381 = getelementptr i64, ptr %v664, i64 1
  store i64 %v666, ptr %st381
  %v667.p = getelementptr i64, ptr %v660, i64 2
  %v667 = load i64, ptr %v667.p
  %st382 = getelementptr i64, ptr %v664, i64 2
  store i64 %v667, ptr %st382
  %v668 = getelementptr i64, ptr @"str.21", i64 0
  %v669 = add i64 0, 3
  %v670 = add i64 0, 0
  %v671 = getelementptr i64, ptr %s27, i64 0
  %v672 = ptrtoint ptr %v668 to i64
  %st383 = getelementptr i64, ptr %v671, i64 0
  store i64 %v672, ptr %st383
  %st384 = getelementptr i64, ptr %v671, i64 1
  store i64 %v669, ptr %st384
  %st385 = getelementptr i64, ptr %v671, i64 2
  store i64 %v670, ptr %st385
  %v673.p = getelementptr i64, ptr %v671, i64 1
  %v673 = load i64, ptr %v673.p
  %v674.p = getelementptr i64, ptr %v664, i64 1
  %v674 = load i64, ptr %v674.p
  %v675 = add i64 %v673, %v674
  %v817 = getelementptr i64, ptr @"rt.meta", i64 0
  %v676.p = getelementptr i64, ptr %v817, i64 0
  %v676 = load i64, ptr %v676.p
  %v677.p = getelementptr i64, ptr %v671, i64 0
  %v677 = load i64, ptr %v677.p
  %v678.p = getelementptr i64, ptr %v671, i64 1
  %v678 = load i64, ptr %v678.p
  %v679.p = getelementptr i64, ptr %v671, i64 2
  %v679 = load i64, ptr %v679.p
  %v680 = call ptr @"rt.cat8"(i64 %v677, i64 %v678, i64 %v679, i64 %v676, i64 %v674)
  %v681 = getelementptr i8, ptr %v680, i64 %v673
  %v682.p = getelementptr i64, ptr %v664, i64 0
  %v682 = load i64, ptr %v682.p
  %v683 = inttoptr i64 %v682 to ptr
  call void @"rt.copy8"(ptr %v681, ptr %v683, i64 %v674)
  %v684 = getelementptr i64, ptr %s39, i64 0
  %v685 = ptrtoint ptr %v680 to i64
  %st386 = getelementptr i64, ptr %v684, i64 0
  store i64 %v685, ptr %st386
  %st387 = getelementptr i64, ptr %v684, i64 1
  store i64 %v675, ptr %st387
  %st388 = getelementptr i64, ptr %v684, i64 2
  store i64 %v676, ptr %st388
  %v686 = getelementptr i64, ptr @"str.22", i64 0
  %v687 = add i64 0, 1
  %v688 = add i64 0, 0
  %v689 = getelementptr i64, ptr %s41, i64 0
  %v690 = ptrtoint ptr %v686 to i64
  %st389 = getelementptr i64, ptr %v689, i64 0
  store i64 %v690, ptr %st389
  %st390 = getelementptr i64, ptr %v689, i64 1
  store i64 %v687, ptr %st390
  %st391 = getelementptr i64, ptr %v689, i64 2
  store i64 %v688, ptr %st391
  %v691.p = getelementptr i64, ptr %v684, i64 1
  %v691 = load i64, ptr %v691.p
  %v692.p = getelementptr i64, ptr %v689, i64 1
  %v692 = load i64, ptr %v692.p
  %v693 = add i64 %v691, %v692
  %v818 = getelementptr i64, ptr @"rt.meta", i64 0
  %v694.p = getelementptr i64, ptr %v818, i64 0
  %v694 = load i64, ptr %v694.p
  %v695.p = getelementptr i64, ptr %v684, i64 0
  %v695 = load i64, ptr %v695.p
  %v696.p = getelementptr i64, ptr %v684, i64 1
  %v696 = load i64, ptr %v696.p
  %v697.p = getelementptr i64, ptr %v684, i64 2
  %v697 = load i64, ptr %v697.p
  %v698 = call ptr @"rt.cat8"(i64 %v695, i64 %v696, i64 %v697, i64 %v694, i64 %v692)
  %v699 = getelementptr i8, ptr %v698, i64 %v691
  %v700.p = getelementptr i64, ptr %v689, i64 0
  %v700 = load i64, ptr %v700.p
  %v701 = inttoptr i64 %v700 to ptr
  call void @"rt.copy8"(ptr %v699, ptr %v701, i64 %v692)
  %v702 = getelementptr i64, ptr %s42, i64 0
  %v703 = ptrtoint ptr %v698 to i64
  %st392 = getelementptr i64, ptr %v702, i64 0
  store i64 %v703, ptr %st392
  %st393 = getelementptr i64, ptr %v702, i64 1
  store i64 %v693, ptr %st393
  %st394 = getelementptr i64, ptr %v702, i64 2
  store i64 %v694, ptr %st394
  call void @"rt.print_str"(ptr %v702)
  %v704 = add i64 0, 10
  call void @"rt.print_char"(i64 %v704)
  br label %b95
b95:
  %v705 = add i64 0, 1
  %v706.p = getelementptr i64, ptr %v31, i64 0
  %v706 = load i64, ptr %v706.p
  %v707 = add i64 %v706, %v705
  %st395 = getelementptr i64, ptr %v31, i64 0
  store i64 %v707, ptr %st395
  %v708.p = getelementptr i64, ptr %v618, i64 1
  %v708 = load i64, ptr %v708.p
  %v709.p = getelementptr i64, ptr %v33, i64 0
  %v709 = load i64, ptr %v709.p
  %v710 = add i64 %v709, %v708
  %st396 = getelementptr i64, ptr %v33, i64 0
  store i64 %v710, ptr %st396
  br label %b89
b96:
  %v711 = getelementptr i64, ptr %s15, i64 0
  %v712 = add i64 0, 0
  %st397 = getelementptr i64, ptr %v711, i64 0
  store i64 %v712, ptr %st397
  %v713.p = getelementptr i64, ptr %v711, i64 0
  %v713 = load i64, ptr %v713.p
  %st398 = getelementptr i64, ptr %v37, i64 0
  store i64 %v713, ptr %st398
  %v714.p = getelementptr i64, ptr %v711, i64 1
  %v714 = load i64, ptr %v714.p
  %st399 = getelementptr i64, ptr %v37, i64 1
  store i64 %v714, ptr %st399
  %v715.p = getelementptr i64, ptr %v711, i64 2
  %v715 = load i64, ptr %v715.p
  %st400 = getelementptr i64, ptr %v37, i64 2
  store i64 %v715, ptr %st400
  %v716.p = getelementptr i64, ptr %v711, i64 3
  %v716 = load i64, ptr %v716.p
  %st401 = getelementptr i64, ptr %v37, i64 3
  store i64 %v716, ptr %st401
  %v717.p = getelementptr i64, ptr %v711, i64 4
  %v717 = load i64, ptr %v717.p
  %st402 = getelementptr i64, ptr %v37, i64 4
  store i64 %v717, ptr %st402
  %v718.p = getelementptr i64, ptr %v711, i64 5
  %v718 = load i64, ptr %v718.p
  %st403 = getelementptr i64, ptr %v37, i64 5
  store i64 %v718, ptr %st403
  %v719.p = getelementptr i64, ptr %v37, i64 0
  %v719 = load i64, ptr %v719.p
  %v720 = add i64 0, 0
  %v721.c = icmp ne i64 %v719, %v720
  %v721 = zext i1 %v721.c to i64
  %c.b96 = icmp ne i64 %v721, 0
  br i1 %c.b96, label %b96.t405, label %b96.e406
b96.t405:
  br label %b97
b96.e406:
  br label %b98
b97:
  %v722 = add i64 0, 3
  %v723 = getelementptr i64, ptr %v37, i64 %v722
  %v819 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v723, i64 %v819, i64 %v38)
  br label %b98
b98:
  %v820 = getelementptr i64, ptr @"rt.meta", i64 0
  %st406 = getelementptr i64, ptr %v820, i64 0
  store i64 %v38, ptr %st406
  br label %b6
b99:
  %v727 = add i64 0, 0
  %st407 = getelementptr i64, ptr %v0, i64 0
  store i64 %v727, ptr %st407
  %st408 = getelementptr i64, ptr %v0, i64 1
  store i64 %v727, ptr %st408
  %v728.p = getelementptr i64, ptr %v37, i64 0
  %v728 = load i64, ptr %v728.p
  %st409 = getelementptr i64, ptr %v0, i64 2
  store i64 %v728, ptr %st409
  %v729.p = getelementptr i64, ptr %v37, i64 1
  %v729 = load i64, ptr %v729.p
  %st410 = getelementptr i64, ptr %v0, i64 3
  store i64 %v729, ptr %st410
  %v730.p = getelementptr i64, ptr %v37, i64 2
  %v730 = load i64, ptr %v730.p
  %st411 = getelementptr i64, ptr %v0, i64 4
  store i64 %v730, ptr %st411
  %v731.p = getelementptr i64, ptr %v37, i64 3
  %v731 = load i64, ptr %v731.p
  %st412 = getelementptr i64, ptr %v0, i64 5
  store i64 %v731, ptr %st412
  %v732.p = getelementptr i64, ptr %v37, i64 4
  %v732 = load i64, ptr %v732.p
  %st413 = getelementptr i64, ptr %v0, i64 6
  store i64 %v732, ptr %st413
  %v733.p = getelementptr i64, ptr %v37, i64 5
  %v733 = load i64, ptr %v733.p
  %st414 = getelementptr i64, ptr %v0, i64 7
  store i64 %v733, ptr %st414
  %v734.p = getelementptr i64, ptr %v28, i64 0
  %v734 = load i64, ptr %v734.p
  call void @"std/io.Close"(i64 %v734)
  %v735.p = getelementptr i64, ptr %v0, i64 2
  %v735 = load i64, ptr %v735.p
  %v736 = add i64 0, 0
  %v737.c = icmp ne i64 %v735, %v736
  %v737 = zext i1 %v737.c to i64
  %c.b99 = icmp ne i64 %v737, 0
  br i1 %c.b99, label %b99.t416, label %b99.e417
b99.t416:
  br label %b101
b99.e417:
  br label %b102
b100:
  br label %b5
b101:
  %v738 = add i64 0, 5
  %v739 = getelementptr i64, ptr %v0, i64 %v738
  %v821 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v739, i64 %v821, i64 %v6)
  br label %b102
b102:
  %v822 = getelementptr i64, ptr @"rt.meta", i64 0
  %st417 = getelementptr i64, ptr %v822, i64 0
  store i64 %v6, ptr %st417
  ret void
b103:
  %v754 = add i64 0, 5
  %v755 = getelementptr i64, ptr %v0, i64 %v754
  %v823 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v755, i64 %v823, i64 %v6)
  br label %b104
b104:
  %v824 = getelementptr i64, ptr @"rt.meta", i64 0
  %st418 = getelementptr i64, ptr %v824, i64 0
  store i64 %v6, ptr %st418
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
  %s15 = alloca [1 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s16 = alloca [1 x i64], align 8
  %s16.z0 = getelementptr i64, ptr %s16, i64 0
  store i64 0, ptr %s16.z0
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
  %s21 = alloca [9 x i64], align 8
  %s21.z0 = getelementptr i64, ptr %s21, i64 0
  store i64 0, ptr %s21.z0
  %s21.z1 = getelementptr i64, ptr %s21, i64 1
  store i64 0, ptr %s21.z1
  %s21.z2 = getelementptr i64, ptr %s21, i64 2
  store i64 0, ptr %s21.z2
  %s21.z3 = getelementptr i64, ptr %s21, i64 3
  store i64 0, ptr %s21.z3
  %s21.z4 = getelementptr i64, ptr %s21, i64 4
  store i64 0, ptr %s21.z4
  %s21.z5 = getelementptr i64, ptr %s21, i64 5
  store i64 0, ptr %s21.z5
  %s21.z6 = getelementptr i64, ptr %s21, i64 6
  store i64 0, ptr %s21.z6
  %s21.z7 = getelementptr i64, ptr %s21, i64 7
  store i64 0, ptr %s21.z7
  %s21.z8 = getelementptr i64, ptr %s21, i64 8
  store i64 0, ptr %s21.z8
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v293, i64 0
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
  %v294 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v294, i64 0
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
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41.p = getelementptr i64, ptr %v295, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = getelementptr i64, ptr %s6, i64 0
  %v43.p = getelementptr i64, ptr %v27, i64 0
  %v43 = load i64, ptr %v43.p
  %st22 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st22
  %v44 = getelementptr i64, ptr %s7, i64 0
  %v296 = getelementptr i64, ptr @"rt.meta", i64 0
  %v45.p = getelementptr i64, ptr %v296, i64 0
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
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %v52.p = getelementptr i64, ptr %v297, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v46, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 65536
  %v55 = add i64 0, 2
  %v56 = call i64 @"rt.chunk_open"(i64 %v53, i64 %v54, i64 %v55, i64 %v50)
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v298, i64 0
  %v57 = load i64, ptr %v57.p
  br label %b8
b3:
  %v25 = add i64 0, 4
  %v26 = getelementptr i64, ptr %v0, i64 %v25
  %v299 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v26, i64 %v299, i64 %v5)
  br label %b4
b4:
  %v300 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v300, i64 0
  store i64 %v5, ptr %st24
  ret void
b5:
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v301, i64 0
  store i64 %v41, ptr %st25
  %v210 = getelementptr i64, ptr %s21, i64 0
  %v211.p = getelementptr i64, ptr %v4, i64 0
  %v211 = load i64, ptr %v211.p
  %v212.p = getelementptr i64, ptr %v4, i64 1
  %v212 = load i64, ptr %v212.p
  %v213.p = getelementptr i64, ptr %v4, i64 2
  %v213 = load i64, ptr %v213.p
  call void @"std/io.ReadFile"(ptr %v210, i64 %v211, i64 %v212, i64 %v213)
  %v214 = add i64 0, 3
  %v215 = getelementptr i64, ptr %v210, i64 %v214
  %v216.p = getelementptr i64, ptr %v215, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 0
  %v218.c = icmp ne i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b5 = icmp ne i64 %v218, 0
  br i1 %c.b5, label %b5.t27, label %b5.e28
b5.t27:
  br label %b38
b5.e28:
  br label %b39
b6:
  %v194.p = getelementptr i64, ptr %v44, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = add i64 0, 0
  %v196.c = icmp ne i64 %v194, %v195
  %v196 = zext i1 %v196.c to i64
  %c.b6 = icmp ne i64 %v196, 0
  br i1 %c.b6, label %b6.t29, label %b6.e30
b6.t29:
  br label %b34
b6.e30:
  br label %b35
b7:
  %v183.p = getelementptr i64, ptr %v51, i64 0
  %v183 = load i64, ptr %v183.p
  %st30 = getelementptr i64, ptr %v44, i64 0
  store i64 %v183, ptr %st30
  %v184.p = getelementptr i64, ptr %v51, i64 1
  %v184 = load i64, ptr %v184.p
  %st31 = getelementptr i64, ptr %v44, i64 1
  store i64 %v184, ptr %st31
  %v185.p = getelementptr i64, ptr %v51, i64 2
  %v185 = load i64, ptr %v185.p
  %st32 = getelementptr i64, ptr %v44, i64 2
  store i64 %v185, ptr %st32
  %v186.p = getelementptr i64, ptr %v51, i64 3
  %v186 = load i64, ptr %v186.p
  %st33 = getelementptr i64, ptr %v44, i64 3
  store i64 %v186, ptr %st33
  %v187.p = getelementptr i64, ptr %v51, i64 4
  %v187 = load i64, ptr %v187.p
  %st34 = getelementptr i64, ptr %v44, i64 4
  store i64 %v187, ptr %st34
  %v188.p = getelementptr i64, ptr %v51, i64 5
  %v188 = load i64, ptr %v188.p
  %st35 = getelementptr i64, ptr %v44, i64 5
  store i64 %v188, ptr %st35
  %v189.p = getelementptr i64, ptr %v44, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = add i64 0, 0
  %v191.c = icmp ne i64 %v189, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b7 = icmp ne i64 %v191, 0
  br i1 %c.b7, label %b7.t37, label %b7.e38
b7.t37:
  br label %b32
b7.e38:
  br label %b33
b8:
  %v302 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v302, i64 0
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
  %v303 = getelementptr i64, ptr @"rt.meta", i64 0
  %v59.p = getelementptr i64, ptr %v303, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 0
  %v61 = add i64 0, 0
  %v62.c = icmp ne i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b9 = icmp ne i64 %v62, 0
  br i1 %c.b9, label %b9.t42, label %b9.e43
b9.t42:
  br label %b11
b9.e43:
  br label %b12
b10:
  %v304 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v304, i64 0
  store i64 %v57, ptr %st43
  %v170 = getelementptr i64, ptr %s12, i64 0
  %v171 = add i64 0, 0
  %st44 = getelementptr i64, ptr %v170, i64 0
  store i64 %v171, ptr %st44
  %v172.p = getelementptr i64, ptr %v170, i64 0
  %v172 = load i64, ptr %v172.p
  %st45 = getelementptr i64, ptr %v51, i64 0
  store i64 %v172, ptr %st45
  %v173.p = getelementptr i64, ptr %v170, i64 1
  %v173 = load i64, ptr %v173.p
  %st46 = getelementptr i64, ptr %v51, i64 1
  store i64 %v173, ptr %st46
  %v174.p = getelementptr i64, ptr %v170, i64 2
  %v174 = load i64, ptr %v174.p
  %st47 = getelementptr i64, ptr %v51, i64 2
  store i64 %v174, ptr %st47
  %v175.p = getelementptr i64, ptr %v170, i64 3
  %v175 = load i64, ptr %v175.p
  %st48 = getelementptr i64, ptr %v51, i64 3
  store i64 %v175, ptr %st48
  %v176.p = getelementptr i64, ptr %v170, i64 4
  %v176 = load i64, ptr %v176.p
  %st49 = getelementptr i64, ptr %v51, i64 4
  store i64 %v176, ptr %st49
  %v177.p = getelementptr i64, ptr %v170, i64 5
  %v177 = load i64, ptr %v177.p
  %st50 = getelementptr i64, ptr %v51, i64 5
  store i64 %v177, ptr %st50
  call void @"std/io.chunkEnd"(i64 %v56)
  %v178.p = getelementptr i64, ptr %v51, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 0
  %v180.c = icmp ne i64 %v178, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b10 = icmp ne i64 %v180, 0
  br i1 %c.b10, label %b10.t52, label %b10.e53
b10.t52:
  br label %b30
b10.e53:
  br label %b31
b11:
  %v63 = getelementptr i64, ptr %s10, i64 0
  %v64 = add i64 0, 0
  %st53 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st53
  %st54 = getelementptr i64, ptr %v63, i64 1
  store i64 %v64, ptr %st54
  %v65 = add i64 0, 4
  %st55 = getelementptr i64, ptr %v63, i64 0
  store i64 %v65, ptr %st55
  %v66 = getelementptr i64, ptr %s11, i64 0
  %v67.p = getelementptr i64, ptr %v63, i64 0
  %v67 = load i64, ptr %v67.p
  %st56 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st56
  %v68.p = getelementptr i64, ptr %v63, i64 1
  %v68 = load i64, ptr %v68.p
  %st57 = getelementptr i64, ptr %v66, i64 1
  store i64 %v68, ptr %st57
  %v69 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v66, i64 2
  store i64 %v69, ptr %st58
  %st59 = getelementptr i64, ptr %v66, i64 3
  store i64 %v69, ptr %st59
  %st60 = getelementptr i64, ptr %v66, i64 4
  store i64 %v69, ptr %st60
  %v70 = getelementptr i64, ptr %s12, i64 0
  %v71 = add i64 0, 1
  %st61 = getelementptr i64, ptr %v70, i64 0
  store i64 %v71, ptr %st61
  %v72.p = getelementptr i64, ptr %v66, i64 0
  %v72 = load i64, ptr %v72.p
  %st62 = getelementptr i64, ptr %v70, i64 1
  store i64 %v72, ptr %st62
  %v73.p = getelementptr i64, ptr %v66, i64 1
  %v73 = load i64, ptr %v73.p
  %st63 = getelementptr i64, ptr %v70, i64 2
  store i64 %v73, ptr %st63
  %v74.p = getelementptr i64, ptr %v66, i64 2
  %v74 = load i64, ptr %v74.p
  %st64 = getelementptr i64, ptr %v70, i64 3
  store i64 %v74, ptr %st64
  %v75.p = getelementptr i64, ptr %v66, i64 3
  %v75 = load i64, ptr %v75.p
  %st65 = getelementptr i64, ptr %v70, i64 4
  store i64 %v75, ptr %st65
  %v76.p = getelementptr i64, ptr %v66, i64 4
  %v76 = load i64, ptr %v76.p
  %st66 = getelementptr i64, ptr %v70, i64 5
  store i64 %v76, ptr %st66
  %v77.p = getelementptr i64, ptr %v70, i64 0
  %v77 = load i64, ptr %v77.p
  %st67 = getelementptr i64, ptr %v51, i64 0
  store i64 %v77, ptr %st67
  %v78.p = getelementptr i64, ptr %v70, i64 1
  %v78 = load i64, ptr %v78.p
  %st68 = getelementptr i64, ptr %v51, i64 1
  store i64 %v78, ptr %st68
  %v79.p = getelementptr i64, ptr %v70, i64 2
  %v79 = load i64, ptr %v79.p
  %st69 = getelementptr i64, ptr %v51, i64 2
  store i64 %v79, ptr %st69
  %v80.p = getelementptr i64, ptr %v70, i64 3
  %v80 = load i64, ptr %v80.p
  %st70 = getelementptr i64, ptr %v51, i64 3
  store i64 %v80, ptr %st70
  %v81.p = getelementptr i64, ptr %v70, i64 4
  %v81 = load i64, ptr %v81.p
  %st71 = getelementptr i64, ptr %v51, i64 4
  store i64 %v81, ptr %st71
  %v82.p = getelementptr i64, ptr %v70, i64 5
  %v82 = load i64, ptr %v82.p
  %st72 = getelementptr i64, ptr %v51, i64 5
  store i64 %v82, ptr %st72
  call void @"std/io.chunkEnd"(i64 %v56)
  %v83.p = getelementptr i64, ptr %v51, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 0
  %v85.c = icmp ne i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b11 = icmp ne i64 %v85, 0
  br i1 %c.b11, label %b11.t74, label %b11.e75
b11.t74:
  br label %b13
b11.e75:
  br label %b14
b12:
  br label %b15
b13:
  %v86 = add i64 0, 3
  %v87 = getelementptr i64, ptr %v51, i64 %v86
  %v305 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v87, i64 %v305, i64 %v52)
  br label %b14
b14:
  %v306 = getelementptr i64, ptr @"rt.meta", i64 0
  %st75 = getelementptr i64, ptr %v306, i64 0
  store i64 %v52, ptr %st75
  br label %b7
b15:
  %v88 = getelementptr i64, ptr %s3, i64 0
  call void @"rt.chunk_next"(i64 %v56, ptr %v88)
  %v89 = getelementptr i64, ptr %s13, i64 0
  %v90.p = getelementptr i64, ptr %v88, i64 0
  %v90 = load i64, ptr %v90.p
  %st76 = getelementptr i64, ptr %v89, i64 0
  store i64 %v90, ptr %st76
  %v91.p = getelementptr i64, ptr %v88, i64 1
  %v91 = load i64, ptr %v91.p
  %st77 = getelementptr i64, ptr %v89, i64 1
  store i64 %v91, ptr %st77
  %v92.p = getelementptr i64, ptr %v88, i64 2
  %v92 = load i64, ptr %v92.p
  %st78 = getelementptr i64, ptr %v89, i64 2
  store i64 %v92, ptr %st78
  %v93.p = getelementptr i64, ptr %v89, i64 1
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 0
  %v95.c = icmp eq i64 %v93, %v94
  %v95 = zext i1 %v95.c to i64
  %c.b15 = icmp ne i64 %v95, 0
  br i1 %c.b15, label %b15.t80, label %b15.e81
b15.t80:
  br label %b16
b15.e81:
  br label %b17
b16:
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v97.p = getelementptr i64, ptr %v96, i64 1027
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 0, 0
  %v99.c = icmp ne i64 %v97, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b16 = icmp ne i64 %v99, 0
  br i1 %c.b16, label %b16.t82, label %b16.e83
b16.t82:
  br label %b18
b16.e83:
  br label %b19
b17:
  br label %b25
b18:
  %v100 = getelementptr i64, ptr %s14, i64 0
  call void @"std/io.errOf"(ptr %v100, i64 %v97)
  %v101 = getelementptr i64, ptr %s12, i64 0
  %v102 = add i64 0, 1
  %st83 = getelementptr i64, ptr %v101, i64 0
  store i64 %v102, ptr %st83
  %v103.p = getelementptr i64, ptr %v100, i64 0
  %v103 = load i64, ptr %v103.p
  %st84 = getelementptr i64, ptr %v101, i64 1
  store i64 %v103, ptr %st84
  %v104.p = getelementptr i64, ptr %v100, i64 1
  %v104 = load i64, ptr %v104.p
  %st85 = getelementptr i64, ptr %v101, i64 2
  store i64 %v104, ptr %st85
  %v105.p = getelementptr i64, ptr %v100, i64 2
  %v105 = load i64, ptr %v105.p
  %st86 = getelementptr i64, ptr %v101, i64 3
  store i64 %v105, ptr %st86
  %v106.p = getelementptr i64, ptr %v100, i64 3
  %v106 = load i64, ptr %v106.p
  %st87 = getelementptr i64, ptr %v101, i64 4
  store i64 %v106, ptr %st87
  %v107.p = getelementptr i64, ptr %v100, i64 4
  %v107 = load i64, ptr %v107.p
  %st88 = getelementptr i64, ptr %v101, i64 5
  store i64 %v107, ptr %st88
  %v108.p = getelementptr i64, ptr %v101, i64 0
  %v108 = load i64, ptr %v108.p
  %st89 = getelementptr i64, ptr %v51, i64 0
  store i64 %v108, ptr %st89
  %v109.p = getelementptr i64, ptr %v101, i64 1
  %v109 = load i64, ptr %v109.p
  %st90 = getelementptr i64, ptr %v51, i64 1
  store i64 %v109, ptr %st90
  %v110.p = getelementptr i64, ptr %v101, i64 2
  %v110 = load i64, ptr %v110.p
  %st91 = getelementptr i64, ptr %v51, i64 2
  store i64 %v110, ptr %st91
  %v111.p = getelementptr i64, ptr %v101, i64 3
  %v111 = load i64, ptr %v111.p
  %st92 = getelementptr i64, ptr %v51, i64 3
  store i64 %v111, ptr %st92
  %v112.p = getelementptr i64, ptr %v101, i64 4
  %v112 = load i64, ptr %v112.p
  %st93 = getelementptr i64, ptr %v51, i64 4
  store i64 %v112, ptr %st93
  %v113.p = getelementptr i64, ptr %v101, i64 5
  %v113 = load i64, ptr %v113.p
  %st94 = getelementptr i64, ptr %v51, i64 5
  store i64 %v113, ptr %st94
  call void @"std/io.chunkEnd"(i64 %v56)
  %v114.p = getelementptr i64, ptr %v51, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp ne i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b18 = icmp ne i64 %v116, 0
  br i1 %c.b18, label %b18.t96, label %b18.e97
b18.t96:
  br label %b20
b18.e97:
  br label %b21
b19:
  br label %b22
b20:
  %v117 = add i64 0, 3
  %v118 = getelementptr i64, ptr %v51, i64 %v117
  %v307 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v118, i64 %v307, i64 %v52)
  br label %b21
b21:
  %v308 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v308, i64 0
  store i64 %v52, ptr %st97
  br label %b7
b22:
  %v119 = getelementptr i64, ptr %s12, i64 0
  %v120 = add i64 0, 0
  %st98 = getelementptr i64, ptr %v119, i64 0
  store i64 %v120, ptr %st98
  %v121.p = getelementptr i64, ptr %v119, i64 0
  %v121 = load i64, ptr %v121.p
  %st99 = getelementptr i64, ptr %v51, i64 0
  store i64 %v121, ptr %st99
  %v122.p = getelementptr i64, ptr %v119, i64 1
  %v122 = load i64, ptr %v122.p
  %st100 = getelementptr i64, ptr %v51, i64 1
  store i64 %v122, ptr %st100
  %v123.p = getelementptr i64, ptr %v119, i64 2
  %v123 = load i64, ptr %v123.p
  %st101 = getelementptr i64, ptr %v51, i64 2
  store i64 %v123, ptr %st101
  %v124.p = getelementptr i64, ptr %v119, i64 3
  %v124 = load i64, ptr %v124.p
  %st102 = getelementptr i64, ptr %v51, i64 3
  store i64 %v124, ptr %st102
  %v125.p = getelementptr i64, ptr %v119, i64 4
  %v125 = load i64, ptr %v125.p
  %st103 = getelementptr i64, ptr %v51, i64 4
  store i64 %v125, ptr %st103
  %v126.p = getelementptr i64, ptr %v119, i64 5
  %v126 = load i64, ptr %v126.p
  %st104 = getelementptr i64, ptr %v51, i64 5
  store i64 %v126, ptr %st104
  call void @"std/io.chunkEnd"(i64 %v56)
  %v127.p = getelementptr i64, ptr %v51, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 0, 0
  %v129.c = icmp ne i64 %v127, %v128
  %v129 = zext i1 %v129.c to i64
  %c.b22 = icmp ne i64 %v129, 0
  br i1 %c.b22, label %b22.t106, label %b22.e107
b22.t106:
  br label %b23
b22.e107:
  br label %b24
b23:
  %v130 = add i64 0, 3
  %v131 = getelementptr i64, ptr %v51, i64 %v130
  %v309 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v131, i64 %v309, i64 %v52)
  br label %b24
b24:
  %v310 = getelementptr i64, ptr @"rt.meta", i64 0
  %st107 = getelementptr i64, ptr %v310, i64 0
  store i64 %v52, ptr %st107
  br label %b7
b25:
  %v132 = getelementptr i64, ptr %s3, i64 0
  %v133.p = getelementptr i64, ptr %v89, i64 0
  %v133 = load i64, ptr %v133.p
  %st108 = getelementptr i64, ptr %v132, i64 0
  store i64 %v133, ptr %st108
  %v134.p = getelementptr i64, ptr %v89, i64 1
  %v134 = load i64, ptr %v134.p
  %st109 = getelementptr i64, ptr %v132, i64 1
  store i64 %v134, ptr %st109
  %v135.p = getelementptr i64, ptr %v89, i64 2
  %v135 = load i64, ptr %v135.p
  %st110 = getelementptr i64, ptr %v132, i64 2
  store i64 %v135, ptr %st110
  %v136 = getelementptr i64, ptr %s15, i64 0
  %v137 = add i64 0, 0
  %v138 = getelementptr i64, ptr %s16, i64 0
  %v139 = getelementptr i64, ptr %s17, i64 0
  %v140 = add i64 0, 0
  %st111 = getelementptr i64, ptr %v139, i64 0
  store i64 %v140, ptr %st111
  %st112 = getelementptr i64, ptr %v139, i64 1
  store i64 %v140, ptr %st112
  %st113 = getelementptr i64, ptr %v139, i64 2
  store i64 %v140, ptr %st113
  %v141.p = getelementptr i64, ptr %v132, i64 0
  %v141 = load i64, ptr %v141.p
  %st114 = getelementptr i64, ptr %v139, i64 0
  store i64 %v141, ptr %st114
  %v142.p = getelementptr i64, ptr %v132, i64 1
  %v142 = load i64, ptr %v142.p
  %st115 = getelementptr i64, ptr %v139, i64 1
  store i64 %v142, ptr %st115
  %v143.p = getelementptr i64, ptr %v132, i64 2
  %v143 = load i64, ptr %v143.p
  %st116 = getelementptr i64, ptr %v139, i64 2
  store i64 %v143, ptr %st116
  %v144 = getelementptr i64, ptr %s18, i64 0
  %v145.p = getelementptr i64, ptr %v139, i64 0
  %v145 = load i64, ptr %v145.p
  %st117 = getelementptr i64, ptr %v144, i64 0
  store i64 %v145, ptr %st117
  %v146.p = getelementptr i64, ptr %v139, i64 1
  %v146 = load i64, ptr %v146.p
  %st118 = getelementptr i64, ptr %v144, i64 1
  store i64 %v146, ptr %st118
  %v147.p = getelementptr i64, ptr %v139, i64 2
  %v147 = load i64, ptr %v147.p
  %st119 = getelementptr i64, ptr %v144, i64 2
  store i64 %v147, ptr %st119
  %v311 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v311, i64 0
  %v148 = load i64, ptr %v148.p
  %v149.p = getelementptr i64, ptr %v40, i64 0
  %v149 = load i64, ptr %v149.p
  %v150 = add i64 0, 0
  %v151.c = icmp eq i64 %v149, %v150
  %v151 = zext i1 %v151.c to i64
  %c.b25 = icmp ne i64 %v151, 0
  br i1 %c.b25, label %b25.t121, label %b25.e122
b25.t121:
  br label %b27
b25.e122:
  br label %b28
b26:
  %v312 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v312, i64 0
  store i64 %v148, ptr %st122
  br label %b8
b27:
  %v152 = add i64 0, 1
  %v153 = add i64 %v5, %v152
  %v154 = getelementptr i64, ptr %s19, i64 0
  %v155.p = getelementptr i64, ptr %v144, i64 0
  %v155 = load i64, ptr %v155.p
  %v156.p = getelementptr i64, ptr %v144, i64 1
  %v156 = load i64, ptr %v156.p
  %v157.p = getelementptr i64, ptr %v144, i64 2
  %v157 = load i64, ptr %v157.p
  call void @"std/io.Raw"(ptr %v154, i64 %v155, i64 %v156, i64 %v157)
  %v158 = getelementptr i64, ptr %s20, i64 0
  %v159.p = getelementptr i64, ptr %v154, i64 0
  %v159 = load i64, ptr %v159.p
  %st123 = getelementptr i64, ptr %v158, i64 0
  store i64 %v159, ptr %st123
  %v160.p = getelementptr i64, ptr %v154, i64 1
  %v160 = load i64, ptr %v160.p
  %st124 = getelementptr i64, ptr %v158, i64 1
  store i64 %v160, ptr %st124
  %v161.p = getelementptr i64, ptr %v154, i64 2
  %v161 = load i64, ptr %v161.p
  %st125 = getelementptr i64, ptr %v158, i64 2
  store i64 %v161, ptr %st125
  %v162 = add i64 0, 1
  %v163 = add i64 %v5, %v162
  call void @"rt.region_relocate8"(ptr %v158, i64 %v163)
  %v164.p = getelementptr i64, ptr %v158, i64 0
  %v164 = load i64, ptr %v164.p
  %st126 = getelementptr i64, ptr %v35, i64 0
  store i64 %v164, ptr %st126
  %v165.p = getelementptr i64, ptr %v158, i64 1
  %v165 = load i64, ptr %v165.p
  %st127 = getelementptr i64, ptr %v35, i64 1
  store i64 %v165, ptr %st127
  %v166.p = getelementptr i64, ptr %v158, i64 2
  %v166 = load i64, ptr %v166.p
  %st128 = getelementptr i64, ptr %v35, i64 2
  store i64 %v166, ptr %st128
  br label %b29
b28:
  br label %b29
b29:
  %v167 = add i64 0, 1
  %v168.p = getelementptr i64, ptr %v40, i64 0
  %v168 = load i64, ptr %v168.p
  %v169 = add i64 %v168, %v167
  %st129 = getelementptr i64, ptr %v40, i64 0
  store i64 %v169, ptr %st129
  br label %b26
b30:
  %v181 = add i64 0, 3
  %v182 = getelementptr i64, ptr %v51, i64 %v181
  %v313 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v182, i64 %v313, i64 %v52)
  br label %b31
b31:
  %v314 = getelementptr i64, ptr @"rt.meta", i64 0
  %st130 = getelementptr i64, ptr %v314, i64 0
  store i64 %v52, ptr %st130
  br label %b7
b32:
  %v192 = add i64 0, 3
  %v193 = getelementptr i64, ptr %v44, i64 %v192
  %v315 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v193, i64 %v315, i64 %v45)
  br label %b33
b33:
  %v316 = getelementptr i64, ptr @"rt.meta", i64 0
  %st131 = getelementptr i64, ptr %v316, i64 0
  store i64 %v45, ptr %st131
  br label %b6
b34:
  %v197 = add i64 0, 0
  %st132 = getelementptr i64, ptr %v0, i64 0
  store i64 %v197, ptr %st132
  %v198.p = getelementptr i64, ptr %v44, i64 0
  %v198 = load i64, ptr %v198.p
  %st133 = getelementptr i64, ptr %v0, i64 1
  store i64 %v198, ptr %st133
  %v199.p = getelementptr i64, ptr %v44, i64 1
  %v199 = load i64, ptr %v199.p
  %st134 = getelementptr i64, ptr %v0, i64 2
  store i64 %v199, ptr %st134
  %v200.p = getelementptr i64, ptr %v44, i64 2
  %v200 = load i64, ptr %v200.p
  %st135 = getelementptr i64, ptr %v0, i64 3
  store i64 %v200, ptr %st135
  %v201.p = getelementptr i64, ptr %v44, i64 3
  %v201 = load i64, ptr %v201.p
  %st136 = getelementptr i64, ptr %v0, i64 4
  store i64 %v201, ptr %st136
  %v202.p = getelementptr i64, ptr %v44, i64 4
  %v202 = load i64, ptr %v202.p
  %st137 = getelementptr i64, ptr %v0, i64 5
  store i64 %v202, ptr %st137
  %v203.p = getelementptr i64, ptr %v44, i64 5
  %v203 = load i64, ptr %v203.p
  %st138 = getelementptr i64, ptr %v0, i64 6
  store i64 %v203, ptr %st138
  %v204.p = getelementptr i64, ptr %v27, i64 0
  %v204 = load i64, ptr %v204.p
  call void @"std/io.Close"(i64 %v204)
  %v205.p = getelementptr i64, ptr %v0, i64 1
  %v205 = load i64, ptr %v205.p
  %v206 = add i64 0, 0
  %v207.c = icmp ne i64 %v205, %v206
  %v207 = zext i1 %v207.c to i64
  %c.b34 = icmp ne i64 %v207, 0
  br i1 %c.b34, label %b34.t140, label %b34.e141
b34.t140:
  br label %b36
b34.e141:
  br label %b37
b35:
  br label %b5
b36:
  %v208 = add i64 0, 4
  %v209 = getelementptr i64, ptr %v0, i64 %v208
  %v317 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v209, i64 %v317, i64 %v5)
  br label %b37
b37:
  %v318 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v318, i64 0
  store i64 %v5, ptr %st141
  ret void
b38:
  %v219 = add i64 0, 0
  %st142 = getelementptr i64, ptr %v0, i64 0
  store i64 %v219, ptr %st142
  %v220.p = getelementptr i64, ptr %v215, i64 0
  %v220 = load i64, ptr %v220.p
  %st143 = getelementptr i64, ptr %v0, i64 1
  store i64 %v220, ptr %st143
  %v221.p = getelementptr i64, ptr %v215, i64 1
  %v221 = load i64, ptr %v221.p
  %st144 = getelementptr i64, ptr %v0, i64 2
  store i64 %v221, ptr %st144
  %v222.p = getelementptr i64, ptr %v215, i64 2
  %v222 = load i64, ptr %v222.p
  %st145 = getelementptr i64, ptr %v0, i64 3
  store i64 %v222, ptr %st145
  %v223.p = getelementptr i64, ptr %v215, i64 3
  %v223 = load i64, ptr %v223.p
  %st146 = getelementptr i64, ptr %v0, i64 4
  store i64 %v223, ptr %st146
  %v224.p = getelementptr i64, ptr %v215, i64 4
  %v224 = load i64, ptr %v224.p
  %st147 = getelementptr i64, ptr %v0, i64 5
  store i64 %v224, ptr %st147
  %v225.p = getelementptr i64, ptr %v215, i64 5
  %v225 = load i64, ptr %v225.p
  %st148 = getelementptr i64, ptr %v0, i64 6
  store i64 %v225, ptr %st148
  %v226.p = getelementptr i64, ptr %v27, i64 0
  %v226 = load i64, ptr %v226.p
  call void @"std/io.Close"(i64 %v226)
  %v227.p = getelementptr i64, ptr %v0, i64 1
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 0, 0
  %v229.c = icmp ne i64 %v227, %v228
  %v229 = zext i1 %v229.c to i64
  %c.b38 = icmp ne i64 %v229, 0
  br i1 %c.b38, label %b38.t150, label %b38.e151
b38.t150:
  br label %b40
b38.e151:
  br label %b41
b39:
  %v232 = getelementptr i64, ptr %s18, i64 0
  %v233.p = getelementptr i64, ptr %v210, i64 0
  %v233 = load i64, ptr %v233.p
  %st151 = getelementptr i64, ptr %v232, i64 0
  store i64 %v233, ptr %st151
  %v234.p = getelementptr i64, ptr %v210, i64 1
  %v234 = load i64, ptr %v234.p
  %st152 = getelementptr i64, ptr %v232, i64 1
  store i64 %v234, ptr %st152
  %v235.p = getelementptr i64, ptr %v210, i64 2
  %v235 = load i64, ptr %v235.p
  %st153 = getelementptr i64, ptr %v232, i64 2
  store i64 %v235, ptr %st153
  %v236.p = getelementptr i64, ptr %v40, i64 0
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 0, 2
  %v238.c = icmp sgt i64 %v236, %v237
  %v238 = zext i1 %v238.c to i64
  %c.b39 = icmp ne i64 %v238, 0
  br i1 %c.b39, label %b39.t155, label %b39.e156
b39.t155:
  br label %b42
b39.e156:
  br label %b43
b40:
  %v230 = add i64 0, 4
  %v231 = getelementptr i64, ptr %v0, i64 %v230
  %v319 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v231, i64 %v319, i64 %v5)
  br label %b41
b41:
  %v320 = getelementptr i64, ptr @"rt.meta", i64 0
  %st156 = getelementptr i64, ptr %v320, i64 0
  store i64 %v5, ptr %st156
  ret void
b42:
  %v240.p = getelementptr i64, ptr %v35, i64 1
  %v240 = load i64, ptr %v240.p
  %v241 = add i64 0, 65536
  %v242.c = icmp eq i64 %v240, %v241
  %v242 = zext i1 %v242.c to i64
  br label %b43
b43:
  %v239 = phi i64 [ %v238, %b39.e156 ], [ %v242, %b42 ]
  %v243 = getelementptr i64, ptr %s6, i64 0
  %st157 = getelementptr i64, ptr %v243, i64 0
  store i64 %v239, ptr %st157
  %v321 = getelementptr i64, ptr @"rt.meta", i64 0
  %v244.p = getelementptr i64, ptr %v321, i64 0
  %v244 = load i64, ptr %v244.p
  %v245 = add i64 0, 0
  %v246.p = getelementptr i64, ptr %v35, i64 1
  %v246 = load i64, ptr %v246.p
  %v247 = getelementptr i64, ptr %s8, i64 0
  %v322 = getelementptr i64, ptr @"rt.meta", i64 0
  %v248.p = getelementptr i64, ptr %v322, i64 0
  %v248 = load i64, ptr %v248.p
  %v249 = getelementptr i64, ptr %s16, i64 0
  %st158 = getelementptr i64, ptr %v249, i64 0
  store i64 %v245, ptr %st158
  %v323 = getelementptr i64, ptr @"rt.meta", i64 0
  %v250.p = getelementptr i64, ptr %v323, i64 0
  %v250 = load i64, ptr %v250.p
  br label %b46
b44:
  %v324 = getelementptr i64, ptr @"rt.meta", i64 0
  %st159 = getelementptr i64, ptr %v324, i64 0
  store i64 %v244, ptr %st159
  %v278.p = getelementptr i64, ptr %v243, i64 0
  %v278 = load i64, ptr %v278.p
  %v279 = getelementptr i64, ptr %s12, i64 0
  %v280 = add i64 0, 0
  %st160 = getelementptr i64, ptr %v279, i64 0
  store i64 %v280, ptr %st160
  %st161 = getelementptr i64, ptr %v0, i64 0
  store i64 %v278, ptr %st161
  %v281.p = getelementptr i64, ptr %v279, i64 0
  %v281 = load i64, ptr %v281.p
  %st162 = getelementptr i64, ptr %v0, i64 1
  store i64 %v281, ptr %st162
  %v282.p = getelementptr i64, ptr %v279, i64 1
  %v282 = load i64, ptr %v282.p
  %st163 = getelementptr i64, ptr %v0, i64 2
  store i64 %v282, ptr %st163
  %v283.p = getelementptr i64, ptr %v279, i64 2
  %v283 = load i64, ptr %v283.p
  %st164 = getelementptr i64, ptr %v0, i64 3
  store i64 %v283, ptr %st164
  %v284.p = getelementptr i64, ptr %v279, i64 3
  %v284 = load i64, ptr %v284.p
  %st165 = getelementptr i64, ptr %v0, i64 4
  store i64 %v284, ptr %st165
  %v285.p = getelementptr i64, ptr %v279, i64 4
  %v285 = load i64, ptr %v285.p
  %st166 = getelementptr i64, ptr %v0, i64 5
  store i64 %v285, ptr %st166
  %v286.p = getelementptr i64, ptr %v279, i64 5
  %v286 = load i64, ptr %v286.p
  %st167 = getelementptr i64, ptr %v0, i64 6
  store i64 %v286, ptr %st167
  %v287.p = getelementptr i64, ptr %v27, i64 0
  %v287 = load i64, ptr %v287.p
  call void @"std/io.Close"(i64 %v287)
  %v288.p = getelementptr i64, ptr %v0, i64 1
  %v288 = load i64, ptr %v288.p
  %v289 = add i64 0, 0
  %v290.c = icmp ne i64 %v288, %v289
  %v290 = zext i1 %v290.c to i64
  %c.b44 = icmp ne i64 %v290, 0
  br i1 %c.b44, label %b44.t169, label %b44.e170
b44.t169:
  br label %b56
b44.e170:
  br label %b57
b45:
  br label %b44
b46:
  %v325 = getelementptr i64, ptr @"rt.meta", i64 0
  %st170 = getelementptr i64, ptr %v325, i64 0
  store i64 %v250, ptr %st170
  %v251.p = getelementptr i64, ptr %v249, i64 0
  %v251 = load i64, ptr %v251.p
  %v252.c = icmp slt i64 %v251, %v246
  %v252 = zext i1 %v252.c to i64
  %c.b46 = icmp ne i64 %v252, 0
  br i1 %c.b46, label %b46.t172, label %b46.e173
b46.t172:
  br label %b47
b46.e173:
  br label %b48
b47:
  call void @"rt.region_enter"()
  %v326 = getelementptr i64, ptr @"rt.meta", i64 0
  %v253.p = getelementptr i64, ptr %v326, i64 0
  %v253 = load i64, ptr %v253.p
  %v254.p = getelementptr i64, ptr %v249, i64 0
  %v254 = load i64, ptr %v254.p
  %v327 = getelementptr i64, ptr @"rt.meta", i64 0
  %v255.p = getelementptr i64, ptr %v327, i64 0
  %v255 = load i64, ptr %v255.p
  %v256 = add i64 0, 1
  %v257 = add i64 %v5, %v256
  %v258.p = getelementptr i64, ptr %v243, i64 0
  %v258 = load i64, ptr %v258.p
  %c.b47 = icmp ne i64 %v258, 0
  br i1 %c.b47, label %b47.t174, label %b47.e175
b47.t174:
  br label %b50
b47.e175:
  br label %b51
b48:
  %v328 = getelementptr i64, ptr @"rt.meta", i64 0
  %st175 = getelementptr i64, ptr %v328, i64 0
  store i64 %v250, ptr %st175
  br label %b45
b49:
  %v329 = getelementptr i64, ptr @"rt.meta", i64 0
  %st176 = getelementptr i64, ptr %v329, i64 0
  store i64 %v255, ptr %st176
  %v275 = add i64 0, 1
  %v276.p = getelementptr i64, ptr %v249, i64 0
  %v276 = load i64, ptr %v276.p
  %v277 = add i64 %v276, %v275
  %st177 = getelementptr i64, ptr %v249, i64 0
  store i64 %v277, ptr %st177
  br label %b46
b50:
  %v260.p = getelementptr i64, ptr %v35, i64 1
  %v260 = load i64, ptr %v260.p
  %v261.c = icmp uge i64 %v254, %v260
  %v261 = zext i1 %v261.c to i64
  %c.b50 = icmp ne i64 %v261, 0
  br i1 %c.b50, label %b50.t179, label %b50.e180
b50.t179:
  br label %b52
b50.e180:
  br label %b53
b51:
  %v259 = phi i64 [ %v258, %b47.e175 ], [ %v274, %b55 ]
  %st180 = getelementptr i64, ptr %v243, i64 0
  store i64 %v259, ptr %st180
  br label %b49
b52:
  %v262 = add i64 0, 2
  call void @"rt.panic"(i64 %v262)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b53:
  %v263.p = getelementptr i64, ptr %v35, i64 0
  %v263 = load i64, ptr %v263.p
  %v264 = inttoptr i64 %v263 to ptr
  %v265 = getelementptr i8, ptr %v264, i64 %v254
  %v266.p = getelementptr i8, ptr %v265, i64 0
  %v266.b = load i8, ptr %v266.p
  %v266 = zext i8 %v266.b to i64
  %v267.p = getelementptr i64, ptr %v232, i64 1
  %v267 = load i64, ptr %v267.p
  %v268.c = icmp uge i64 %v254, %v267
  %v268 = zext i1 %v268.c to i64
  %c.b53 = icmp ne i64 %v268, 0
  br i1 %c.b53, label %b53.t182, label %b53.e183
b53.t182:
  br label %b54
b53.e183:
  br label %b55
b54:
  %v269 = add i64 0, 3
  call void @"rt.panic"(i64 %v269)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b55:
  %v270.p = getelementptr i64, ptr %v232, i64 0
  %v270 = load i64, ptr %v270.p
  %v271 = inttoptr i64 %v270 to ptr
  %v272 = getelementptr i8, ptr %v271, i64 %v254
  %v273.p = getelementptr i8, ptr %v272, i64 0
  %v273.b = load i8, ptr %v273.p
  %v273 = zext i8 %v273.b to i64
  %v274.c = icmp eq i64 %v266, %v273
  %v274 = zext i1 %v274.c to i64
  br label %b51
b56:
  %v291 = add i64 0, 4
  %v292 = getelementptr i64, ptr %v0, i64 %v291
  %v330 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v292, i64 %v330, i64 %v5)
  br label %b57
b57:
  %v331 = getelementptr i64, ptr @"rt.meta", i64 0
  %st183 = getelementptr i64, ptr %v331, i64 0
  store i64 %v5, ptr %st183
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
  %s8 = alloca [2 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
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
  %s13 = alloca [5 x i64], align 8
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
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v281, i64 0
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
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v282, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34.p = getelementptr i64, ptr %v28, i64 0
  %v34 = load i64, ptr %v34.p
  %st16 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st16
  %v35 = getelementptr i64, ptr %s5, i64 0
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v283, i64 0
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
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %v43.p = getelementptr i64, ptr %v284, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v37, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = add i64 0, 65536
  %v46 = add i64 0, 2
  %v47 = call i64 @"rt.chunk_open"(i64 %v44, i64 %v45, i64 %v46, i64 %v41)
  %v285 = getelementptr i64, ptr @"rt.meta", i64 0
  %v48.p = getelementptr i64, ptr %v285, i64 0
  %v48 = load i64, ptr %v48.p
  br label %b8
b3:
  %v26 = add i64 0, 4
  %v27 = getelementptr i64, ptr %v0, i64 %v26
  %v286 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v27, i64 %v286, i64 %v6)
  br label %b4
b4:
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v287, i64 0
  store i64 %v6, ptr %st18
  ret void
b5:
  %v288 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v288, i64 0
  store i64 %v32, ptr %st19
  %v238 = getelementptr i64, ptr %s19, i64 0
  %v239.p = getelementptr i64, ptr %v28, i64 0
  %v239 = load i64, ptr %v239.p
  call void @"std/io.ReadAll"(ptr %v238, i64 %v239)
  %v240 = add i64 0, 3
  %v241 = getelementptr i64, ptr %v238, i64 %v240
  %v242.p = getelementptr i64, ptr %v241, i64 0
  %v242 = load i64, ptr %v242.p
  %v243 = add i64 0, 0
  %v244.c = icmp ne i64 %v242, %v243
  %v244 = zext i1 %v244.c to i64
  %c.b5 = icmp ne i64 %v244, 0
  br i1 %c.b5, label %b5.t21, label %b5.e22
b5.t21:
  br label %b48
b5.e22:
  br label %b49
b6:
  %v222.p = getelementptr i64, ptr %v35, i64 0
  %v222 = load i64, ptr %v222.p
  %v223 = add i64 0, 0
  %v224.c = icmp ne i64 %v222, %v223
  %v224 = zext i1 %v224.c to i64
  %c.b6 = icmp ne i64 %v224, 0
  br i1 %c.b6, label %b6.t23, label %b6.e24
b6.t23:
  br label %b44
b6.e24:
  br label %b45
b7:
  %v211.p = getelementptr i64, ptr %v42, i64 0
  %v211 = load i64, ptr %v211.p
  %st24 = getelementptr i64, ptr %v35, i64 0
  store i64 %v211, ptr %st24
  %v212.p = getelementptr i64, ptr %v42, i64 1
  %v212 = load i64, ptr %v212.p
  %st25 = getelementptr i64, ptr %v35, i64 1
  store i64 %v212, ptr %st25
  %v213.p = getelementptr i64, ptr %v42, i64 2
  %v213 = load i64, ptr %v213.p
  %st26 = getelementptr i64, ptr %v35, i64 2
  store i64 %v213, ptr %st26
  %v214.p = getelementptr i64, ptr %v42, i64 3
  %v214 = load i64, ptr %v214.p
  %st27 = getelementptr i64, ptr %v35, i64 3
  store i64 %v214, ptr %st27
  %v215.p = getelementptr i64, ptr %v42, i64 4
  %v215 = load i64, ptr %v215.p
  %st28 = getelementptr i64, ptr %v35, i64 4
  store i64 %v215, ptr %st28
  %v216.p = getelementptr i64, ptr %v42, i64 5
  %v216 = load i64, ptr %v216.p
  %st29 = getelementptr i64, ptr %v35, i64 5
  store i64 %v216, ptr %st29
  %v217.p = getelementptr i64, ptr %v35, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = add i64 0, 0
  %v219.c = icmp ne i64 %v217, %v218
  %v219 = zext i1 %v219.c to i64
  %c.b7 = icmp ne i64 %v219, 0
  br i1 %c.b7, label %b7.t31, label %b7.e32
b7.t31:
  br label %b42
b7.e32:
  br label %b43
b8:
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v289, i64 0
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
  %v290 = getelementptr i64, ptr @"rt.meta", i64 0
  %v50.p = getelementptr i64, ptr %v290, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 0
  %v52 = add i64 0, 0
  %v53.c = icmp ne i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b9 = icmp ne i64 %v53, 0
  br i1 %c.b9, label %b9.t36, label %b9.e37
b9.t36:
  br label %b11
b9.e37:
  br label %b12
b10:
  %v291 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v291, i64 0
  store i64 %v48, ptr %st37
  %v198 = getelementptr i64, ptr %s10, i64 0
  %v199 = add i64 0, 0
  %st38 = getelementptr i64, ptr %v198, i64 0
  store i64 %v199, ptr %st38
  %v200.p = getelementptr i64, ptr %v198, i64 0
  %v200 = load i64, ptr %v200.p
  %st39 = getelementptr i64, ptr %v42, i64 0
  store i64 %v200, ptr %st39
  %v201.p = getelementptr i64, ptr %v198, i64 1
  %v201 = load i64, ptr %v201.p
  %st40 = getelementptr i64, ptr %v42, i64 1
  store i64 %v201, ptr %st40
  %v202.p = getelementptr i64, ptr %v198, i64 2
  %v202 = load i64, ptr %v202.p
  %st41 = getelementptr i64, ptr %v42, i64 2
  store i64 %v202, ptr %st41
  %v203.p = getelementptr i64, ptr %v198, i64 3
  %v203 = load i64, ptr %v203.p
  %st42 = getelementptr i64, ptr %v42, i64 3
  store i64 %v203, ptr %st42
  %v204.p = getelementptr i64, ptr %v198, i64 4
  %v204 = load i64, ptr %v204.p
  %st43 = getelementptr i64, ptr %v42, i64 4
  store i64 %v204, ptr %st43
  %v205.p = getelementptr i64, ptr %v198, i64 5
  %v205 = load i64, ptr %v205.p
  %st44 = getelementptr i64, ptr %v42, i64 5
  store i64 %v205, ptr %st44
  call void @"std/io.chunkEnd"(i64 %v47)
  %v206.p = getelementptr i64, ptr %v42, i64 0
  %v206 = load i64, ptr %v206.p
  %v207 = add i64 0, 0
  %v208.c = icmp ne i64 %v206, %v207
  %v208 = zext i1 %v208.c to i64
  %c.b10 = icmp ne i64 %v208, 0
  br i1 %c.b10, label %b10.t46, label %b10.e47
b10.t46:
  br label %b40
b10.e47:
  br label %b41
b11:
  %v54 = getelementptr i64, ptr %s8, i64 0
  %v55 = add i64 0, 0
  %st47 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st47
  %st48 = getelementptr i64, ptr %v54, i64 1
  store i64 %v55, ptr %st48
  %v56 = add i64 0, 4
  %st49 = getelementptr i64, ptr %v54, i64 0
  store i64 %v56, ptr %st49
  %v57 = getelementptr i64, ptr %s9, i64 0
  %v58.p = getelementptr i64, ptr %v54, i64 0
  %v58 = load i64, ptr %v58.p
  %st50 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st50
  %v59.p = getelementptr i64, ptr %v54, i64 1
  %v59 = load i64, ptr %v59.p
  %st51 = getelementptr i64, ptr %v57, i64 1
  store i64 %v59, ptr %st51
  %v60 = add i64 0, 0
  %st52 = getelementptr i64, ptr %v57, i64 2
  store i64 %v60, ptr %st52
  %st53 = getelementptr i64, ptr %v57, i64 3
  store i64 %v60, ptr %st53
  %st54 = getelementptr i64, ptr %v57, i64 4
  store i64 %v60, ptr %st54
  %v61 = getelementptr i64, ptr %s10, i64 0
  %v62 = add i64 0, 1
  %st55 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st55
  %v63.p = getelementptr i64, ptr %v57, i64 0
  %v63 = load i64, ptr %v63.p
  %st56 = getelementptr i64, ptr %v61, i64 1
  store i64 %v63, ptr %st56
  %v64.p = getelementptr i64, ptr %v57, i64 1
  %v64 = load i64, ptr %v64.p
  %st57 = getelementptr i64, ptr %v61, i64 2
  store i64 %v64, ptr %st57
  %v65.p = getelementptr i64, ptr %v57, i64 2
  %v65 = load i64, ptr %v65.p
  %st58 = getelementptr i64, ptr %v61, i64 3
  store i64 %v65, ptr %st58
  %v66.p = getelementptr i64, ptr %v57, i64 3
  %v66 = load i64, ptr %v66.p
  %st59 = getelementptr i64, ptr %v61, i64 4
  store i64 %v66, ptr %st59
  %v67.p = getelementptr i64, ptr %v57, i64 4
  %v67 = load i64, ptr %v67.p
  %st60 = getelementptr i64, ptr %v61, i64 5
  store i64 %v67, ptr %st60
  %v68.p = getelementptr i64, ptr %v61, i64 0
  %v68 = load i64, ptr %v68.p
  %st61 = getelementptr i64, ptr %v42, i64 0
  store i64 %v68, ptr %st61
  %v69.p = getelementptr i64, ptr %v61, i64 1
  %v69 = load i64, ptr %v69.p
  %st62 = getelementptr i64, ptr %v42, i64 1
  store i64 %v69, ptr %st62
  %v70.p = getelementptr i64, ptr %v61, i64 2
  %v70 = load i64, ptr %v70.p
  %st63 = getelementptr i64, ptr %v42, i64 2
  store i64 %v70, ptr %st63
  %v71.p = getelementptr i64, ptr %v61, i64 3
  %v71 = load i64, ptr %v71.p
  %st64 = getelementptr i64, ptr %v42, i64 3
  store i64 %v71, ptr %st64
  %v72.p = getelementptr i64, ptr %v61, i64 4
  %v72 = load i64, ptr %v72.p
  %st65 = getelementptr i64, ptr %v42, i64 4
  store i64 %v72, ptr %st65
  %v73.p = getelementptr i64, ptr %v61, i64 5
  %v73 = load i64, ptr %v73.p
  %st66 = getelementptr i64, ptr %v42, i64 5
  store i64 %v73, ptr %st66
  call void @"std/io.chunkEnd"(i64 %v47)
  %v74.p = getelementptr i64, ptr %v42, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 0
  %v76.c = icmp ne i64 %v74, %v75
  %v76 = zext i1 %v76.c to i64
  %c.b11 = icmp ne i64 %v76, 0
  br i1 %c.b11, label %b11.t68, label %b11.e69
b11.t68:
  br label %b13
b11.e69:
  br label %b14
b12:
  br label %b15
b13:
  %v77 = add i64 0, 3
  %v78 = getelementptr i64, ptr %v42, i64 %v77
  %v292 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v78, i64 %v292, i64 %v43)
  br label %b14
b14:
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %st69 = getelementptr i64, ptr %v293, i64 0
  store i64 %v43, ptr %st69
  br label %b7
b15:
  %v79 = getelementptr i64, ptr %s11, i64 0
  call void @"rt.chunk_next"(i64 %v47, ptr %v79)
  %v80 = getelementptr i64, ptr %s12, i64 0
  %v81.p = getelementptr i64, ptr %v79, i64 0
  %v81 = load i64, ptr %v81.p
  %st70 = getelementptr i64, ptr %v80, i64 0
  store i64 %v81, ptr %st70
  %v82.p = getelementptr i64, ptr %v79, i64 1
  %v82 = load i64, ptr %v82.p
  %st71 = getelementptr i64, ptr %v80, i64 1
  store i64 %v82, ptr %st71
  %v83.p = getelementptr i64, ptr %v79, i64 2
  %v83 = load i64, ptr %v83.p
  %st72 = getelementptr i64, ptr %v80, i64 2
  store i64 %v83, ptr %st72
  %v84.p = getelementptr i64, ptr %v80, i64 1
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 0
  %v86.c = icmp eq i64 %v84, %v85
  %v86 = zext i1 %v86.c to i64
  %c.b15 = icmp ne i64 %v86, 0
  br i1 %c.b15, label %b15.t74, label %b15.e75
b15.t74:
  br label %b16
b15.e75:
  br label %b17
b16:
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %v88.p = getelementptr i64, ptr %v87, i64 1027
  %v88 = load i64, ptr %v88.p
  %v89 = add i64 0, 0
  %v90.c = icmp ne i64 %v88, %v89
  %v90 = zext i1 %v90.c to i64
  %c.b16 = icmp ne i64 %v90, 0
  br i1 %c.b16, label %b16.t76, label %b16.e77
b16.t76:
  br label %b18
b16.e77:
  br label %b19
b17:
  br label %b25
b18:
  %v91 = getelementptr i64, ptr %s13, i64 0
  call void @"std/io.errOf"(ptr %v91, i64 %v88)
  %v92 = getelementptr i64, ptr %s10, i64 0
  %v93 = add i64 0, 1
  %st77 = getelementptr i64, ptr %v92, i64 0
  store i64 %v93, ptr %st77
  %v94.p = getelementptr i64, ptr %v91, i64 0
  %v94 = load i64, ptr %v94.p
  %st78 = getelementptr i64, ptr %v92, i64 1
  store i64 %v94, ptr %st78
  %v95.p = getelementptr i64, ptr %v91, i64 1
  %v95 = load i64, ptr %v95.p
  %st79 = getelementptr i64, ptr %v92, i64 2
  store i64 %v95, ptr %st79
  %v96.p = getelementptr i64, ptr %v91, i64 2
  %v96 = load i64, ptr %v96.p
  %st80 = getelementptr i64, ptr %v92, i64 3
  store i64 %v96, ptr %st80
  %v97.p = getelementptr i64, ptr %v91, i64 3
  %v97 = load i64, ptr %v97.p
  %st81 = getelementptr i64, ptr %v92, i64 4
  store i64 %v97, ptr %st81
  %v98.p = getelementptr i64, ptr %v91, i64 4
  %v98 = load i64, ptr %v98.p
  %st82 = getelementptr i64, ptr %v92, i64 5
  store i64 %v98, ptr %st82
  %v99.p = getelementptr i64, ptr %v92, i64 0
  %v99 = load i64, ptr %v99.p
  %st83 = getelementptr i64, ptr %v42, i64 0
  store i64 %v99, ptr %st83
  %v100.p = getelementptr i64, ptr %v92, i64 1
  %v100 = load i64, ptr %v100.p
  %st84 = getelementptr i64, ptr %v42, i64 1
  store i64 %v100, ptr %st84
  %v101.p = getelementptr i64, ptr %v92, i64 2
  %v101 = load i64, ptr %v101.p
  %st85 = getelementptr i64, ptr %v42, i64 2
  store i64 %v101, ptr %st85
  %v102.p = getelementptr i64, ptr %v92, i64 3
  %v102 = load i64, ptr %v102.p
  %st86 = getelementptr i64, ptr %v42, i64 3
  store i64 %v102, ptr %st86
  %v103.p = getelementptr i64, ptr %v92, i64 4
  %v103 = load i64, ptr %v103.p
  %st87 = getelementptr i64, ptr %v42, i64 4
  store i64 %v103, ptr %st87
  %v104.p = getelementptr i64, ptr %v92, i64 5
  %v104 = load i64, ptr %v104.p
  %st88 = getelementptr i64, ptr %v42, i64 5
  store i64 %v104, ptr %st88
  call void @"std/io.chunkEnd"(i64 %v47)
  %v105.p = getelementptr i64, ptr %v42, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = add i64 0, 0
  %v107.c = icmp ne i64 %v105, %v106
  %v107 = zext i1 %v107.c to i64
  %c.b18 = icmp ne i64 %v107, 0
  br i1 %c.b18, label %b18.t90, label %b18.e91
b18.t90:
  br label %b20
b18.e91:
  br label %b21
b19:
  br label %b22
b20:
  %v108 = add i64 0, 3
  %v109 = getelementptr i64, ptr %v42, i64 %v108
  %v294 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v109, i64 %v294, i64 %v43)
  br label %b21
b21:
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v295, i64 0
  store i64 %v43, ptr %st91
  br label %b7
b22:
  %v110 = getelementptr i64, ptr %s10, i64 0
  %v111 = add i64 0, 0
  %st92 = getelementptr i64, ptr %v110, i64 0
  store i64 %v111, ptr %st92
  %v112.p = getelementptr i64, ptr %v110, i64 0
  %v112 = load i64, ptr %v112.p
  %st93 = getelementptr i64, ptr %v42, i64 0
  store i64 %v112, ptr %st93
  %v113.p = getelementptr i64, ptr %v110, i64 1
  %v113 = load i64, ptr %v113.p
  %st94 = getelementptr i64, ptr %v42, i64 1
  store i64 %v113, ptr %st94
  %v114.p = getelementptr i64, ptr %v110, i64 2
  %v114 = load i64, ptr %v114.p
  %st95 = getelementptr i64, ptr %v42, i64 2
  store i64 %v114, ptr %st95
  %v115.p = getelementptr i64, ptr %v110, i64 3
  %v115 = load i64, ptr %v115.p
  %st96 = getelementptr i64, ptr %v42, i64 3
  store i64 %v115, ptr %st96
  %v116.p = getelementptr i64, ptr %v110, i64 4
  %v116 = load i64, ptr %v116.p
  %st97 = getelementptr i64, ptr %v42, i64 4
  store i64 %v116, ptr %st97
  %v117.p = getelementptr i64, ptr %v110, i64 5
  %v117 = load i64, ptr %v117.p
  %st98 = getelementptr i64, ptr %v42, i64 5
  store i64 %v117, ptr %st98
  call void @"std/io.chunkEnd"(i64 %v47)
  %v118.p = getelementptr i64, ptr %v42, i64 0
  %v118 = load i64, ptr %v118.p
  %v119 = add i64 0, 0
  %v120.c = icmp ne i64 %v118, %v119
  %v120 = zext i1 %v120.c to i64
  %c.b22 = icmp ne i64 %v120, 0
  br i1 %c.b22, label %b22.t100, label %b22.e101
b22.t100:
  br label %b23
b22.e101:
  br label %b24
b23:
  %v121 = add i64 0, 3
  %v122 = getelementptr i64, ptr %v42, i64 %v121
  %v296 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v122, i64 %v296, i64 %v43)
  br label %b24
b24:
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %st101 = getelementptr i64, ptr %v297, i64 0
  store i64 %v43, ptr %st101
  br label %b7
b25:
  %v123 = getelementptr i64, ptr %s11, i64 0
  %v124.p = getelementptr i64, ptr %v80, i64 0
  %v124 = load i64, ptr %v124.p
  %st102 = getelementptr i64, ptr %v123, i64 0
  store i64 %v124, ptr %st102
  %v125.p = getelementptr i64, ptr %v80, i64 1
  %v125 = load i64, ptr %v125.p
  %st103 = getelementptr i64, ptr %v123, i64 1
  store i64 %v125, ptr %st103
  %v126.p = getelementptr i64, ptr %v80, i64 2
  %v126 = load i64, ptr %v126.p
  %st104 = getelementptr i64, ptr %v123, i64 2
  store i64 %v126, ptr %st104
  %v127 = getelementptr i64, ptr %s14, i64 0
  %v128 = add i64 0, 0
  %v129 = getelementptr i64, ptr %s15, i64 0
  %v130 = getelementptr i64, ptr %s16, i64 0
  %v131 = add i64 0, 0
  %st105 = getelementptr i64, ptr %v130, i64 0
  store i64 %v131, ptr %st105
  %st106 = getelementptr i64, ptr %v130, i64 1
  store i64 %v131, ptr %st106
  %st107 = getelementptr i64, ptr %v130, i64 2
  store i64 %v131, ptr %st107
  %v132.p = getelementptr i64, ptr %v123, i64 0
  %v132 = load i64, ptr %v132.p
  %st108 = getelementptr i64, ptr %v130, i64 0
  store i64 %v132, ptr %st108
  %v133.p = getelementptr i64, ptr %v123, i64 1
  %v133 = load i64, ptr %v133.p
  %st109 = getelementptr i64, ptr %v130, i64 1
  store i64 %v133, ptr %st109
  %v134.p = getelementptr i64, ptr %v123, i64 2
  %v134 = load i64, ptr %v134.p
  %st110 = getelementptr i64, ptr %v130, i64 2
  store i64 %v134, ptr %st110
  %v135 = getelementptr i64, ptr %s17, i64 0
  %v136.p = getelementptr i64, ptr %v130, i64 0
  %v136 = load i64, ptr %v136.p
  %st111 = getelementptr i64, ptr %v135, i64 0
  store i64 %v136, ptr %st111
  %v137.p = getelementptr i64, ptr %v130, i64 1
  %v137 = load i64, ptr %v137.p
  %st112 = getelementptr i64, ptr %v135, i64 1
  store i64 %v137, ptr %st112
  %v138.p = getelementptr i64, ptr %v130, i64 2
  %v138 = load i64, ptr %v138.p
  %st113 = getelementptr i64, ptr %v135, i64 2
  store i64 %v138, ptr %st113
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %v139.p = getelementptr i64, ptr %v298, i64 0
  %v139 = load i64, ptr %v139.p
  %v140 = add i64 0, 1
  %v141.p = getelementptr i64, ptr %v31, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 %v141, %v140
  %st114 = getelementptr i64, ptr %v31, i64 0
  store i64 %v142, ptr %st114
  %v143.p = getelementptr i64, ptr %v31, i64 0
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 2
  %v145.c = icmp eq i64 %v143, %v144
  %v145 = zext i1 %v145.c to i64
  %c.b25 = icmp ne i64 %v145, 0
  br i1 %c.b25, label %b25.t116, label %b25.e117
b25.t116:
  br label %b27
b25.e117:
  br label %b28
b26:
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v299, i64 0
  store i64 %v139, ptr %st117
  br label %b8
b27:
  %v146 = add i64 0, 0
  %v147.c = icmp eq i64 %v4, %v146
  %v147 = zext i1 %v147.c to i64
  %c.b27 = icmp ne i64 %v147, 0
  br i1 %c.b27, label %b27.t119, label %b27.e120
b27.t119:
  br label %b29
b27.e120:
  br label %b30
b28:
  br label %b39
b29:
  call void @"std/io.chunkEnd"(i64 %v47)
  br label %b5
b30:
  br label %b31
b31:
  %v148 = add i64 0, 1
  %v149.c = icmp eq i64 %v4, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b31 = icmp ne i64 %v149, 0
  br i1 %c.b31, label %b31.t121, label %b31.e122
b31.t121:
  br label %b32
b31.e122:
  br label %b33
b32:
  %v150 = add i64 0, 100
  %v151 = getelementptr i64, ptr %s18, i64 0
  %v152.p = getelementptr i64, ptr %v135, i64 0
  %v152 = load i64, ptr %v152.p
  %v153.p = getelementptr i64, ptr %v135, i64 1
  %v153 = load i64, ptr %v153.p
  %v154.p = getelementptr i64, ptr %v135, i64 2
  %v154 = load i64, ptr %v154.p
  call void @"std/io.Raw"(ptr %v151, i64 %v152, i64 %v153, i64 %v154)
  %v155.p = getelementptr i64, ptr %v151, i64 1
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 %v150, %v155
  %v157 = getelementptr i64, ptr %s10, i64 0
  %v158 = add i64 0, 0
  %st122 = getelementptr i64, ptr %v157, i64 0
  store i64 %v158, ptr %st122
  %st123 = getelementptr i64, ptr %v0, i64 0
  store i64 %v156, ptr %st123
  %v159.p = getelementptr i64, ptr %v157, i64 0
  %v159 = load i64, ptr %v159.p
  %st124 = getelementptr i64, ptr %v0, i64 1
  store i64 %v159, ptr %st124
  %v160.p = getelementptr i64, ptr %v157, i64 1
  %v160 = load i64, ptr %v160.p
  %st125 = getelementptr i64, ptr %v0, i64 2
  store i64 %v160, ptr %st125
  %v161.p = getelementptr i64, ptr %v157, i64 2
  %v161 = load i64, ptr %v161.p
  %st126 = getelementptr i64, ptr %v0, i64 3
  store i64 %v161, ptr %st126
  %v162.p = getelementptr i64, ptr %v157, i64 3
  %v162 = load i64, ptr %v162.p
  %st127 = getelementptr i64, ptr %v0, i64 4
  store i64 %v162, ptr %st127
  %v163.p = getelementptr i64, ptr %v157, i64 4
  %v163 = load i64, ptr %v163.p
  %st128 = getelementptr i64, ptr %v0, i64 5
  store i64 %v163, ptr %st128
  %v164.p = getelementptr i64, ptr %v157, i64 5
  %v164 = load i64, ptr %v164.p
  %st129 = getelementptr i64, ptr %v0, i64 6
  store i64 %v164, ptr %st129
  call void @"std/io.chunkEnd"(i64 %v47)
  %v165.p = getelementptr i64, ptr %v28, i64 0
  %v165 = load i64, ptr %v165.p
  call void @"std/io.Close"(i64 %v165)
  %v166.p = getelementptr i64, ptr %v0, i64 1
  %v166 = load i64, ptr %v166.p
  %v167 = add i64 0, 0
  %v168.c = icmp ne i64 %v166, %v167
  %v168 = zext i1 %v168.c to i64
  %c.b32 = icmp ne i64 %v168, 0
  br i1 %c.b32, label %b32.t131, label %b32.e132
b32.t131:
  br label %b34
b32.e132:
  br label %b35
b33:
  br label %b36
b34:
  %v169 = add i64 0, 4
  %v170 = getelementptr i64, ptr %v0, i64 %v169
  %v300 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v170, i64 %v300, i64 %v6)
  br label %b35
b35:
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %st132 = getelementptr i64, ptr %v301, i64 0
  store i64 %v6, ptr %st132
  ret void
b36:
  %v171 = add i64 0, 0
  %v172 = getelementptr i64, ptr %s8, i64 0
  %v173 = add i64 0, 0
  %st133 = getelementptr i64, ptr %v172, i64 0
  store i64 %v173, ptr %st133
  %st134 = getelementptr i64, ptr %v172, i64 1
  store i64 %v173, ptr %st134
  %v174 = add i64 0, 0
  %st135 = getelementptr i64, ptr %v172, i64 0
  store i64 %v174, ptr %st135
  %v175 = getelementptr i64, ptr %s9, i64 0
  %v176.p = getelementptr i64, ptr %v172, i64 0
  %v176 = load i64, ptr %v176.p
  %st136 = getelementptr i64, ptr %v175, i64 0
  store i64 %v176, ptr %st136
  %v177.p = getelementptr i64, ptr %v172, i64 1
  %v177 = load i64, ptr %v177.p
  %st137 = getelementptr i64, ptr %v175, i64 1
  store i64 %v177, ptr %st137
  %v178 = add i64 0, 0
  %st138 = getelementptr i64, ptr %v175, i64 2
  store i64 %v178, ptr %st138
  %st139 = getelementptr i64, ptr %v175, i64 3
  store i64 %v178, ptr %st139
  %st140 = getelementptr i64, ptr %v175, i64 4
  store i64 %v178, ptr %st140
  %v179 = getelementptr i64, ptr %s10, i64 0
  %v180 = add i64 0, 1
  %st141 = getelementptr i64, ptr %v179, i64 0
  store i64 %v180, ptr %st141
  %v181.p = getelementptr i64, ptr %v175, i64 0
  %v181 = load i64, ptr %v181.p
  %st142 = getelementptr i64, ptr %v179, i64 1
  store i64 %v181, ptr %st142
  %v182.p = getelementptr i64, ptr %v175, i64 1
  %v182 = load i64, ptr %v182.p
  %st143 = getelementptr i64, ptr %v179, i64 2
  store i64 %v182, ptr %st143
  %v183.p = getelementptr i64, ptr %v175, i64 2
  %v183 = load i64, ptr %v183.p
  %st144 = getelementptr i64, ptr %v179, i64 3
  store i64 %v183, ptr %st144
  %v184.p = getelementptr i64, ptr %v175, i64 3
  %v184 = load i64, ptr %v184.p
  %st145 = getelementptr i64, ptr %v179, i64 4
  store i64 %v184, ptr %st145
  %v185.p = getelementptr i64, ptr %v175, i64 4
  %v185 = load i64, ptr %v185.p
  %st146 = getelementptr i64, ptr %v179, i64 5
  store i64 %v185, ptr %st146
  %st147 = getelementptr i64, ptr %v0, i64 0
  store i64 %v171, ptr %st147
  %v186.p = getelementptr i64, ptr %v179, i64 0
  %v186 = load i64, ptr %v186.p
  %st148 = getelementptr i64, ptr %v0, i64 1
  store i64 %v186, ptr %st148
  %v187.p = getelementptr i64, ptr %v179, i64 1
  %v187 = load i64, ptr %v187.p
  %st149 = getelementptr i64, ptr %v0, i64 2
  store i64 %v187, ptr %st149
  %v188.p = getelementptr i64, ptr %v179, i64 2
  %v188 = load i64, ptr %v188.p
  %st150 = getelementptr i64, ptr %v0, i64 3
  store i64 %v188, ptr %st150
  %v189.p = getelementptr i64, ptr %v179, i64 3
  %v189 = load i64, ptr %v189.p
  %st151 = getelementptr i64, ptr %v0, i64 4
  store i64 %v189, ptr %st151
  %v190.p = getelementptr i64, ptr %v179, i64 4
  %v190 = load i64, ptr %v190.p
  %st152 = getelementptr i64, ptr %v0, i64 5
  store i64 %v190, ptr %st152
  %v191.p = getelementptr i64, ptr %v179, i64 5
  %v191 = load i64, ptr %v191.p
  %st153 = getelementptr i64, ptr %v0, i64 6
  store i64 %v191, ptr %st153
  call void @"std/io.chunkEnd"(i64 %v47)
  %v192.p = getelementptr i64, ptr %v28, i64 0
  %v192 = load i64, ptr %v192.p
  call void @"std/io.Close"(i64 %v192)
  %v193.p = getelementptr i64, ptr %v0, i64 1
  %v193 = load i64, ptr %v193.p
  %v194 = add i64 0, 0
  %v195.c = icmp ne i64 %v193, %v194
  %v195 = zext i1 %v195.c to i64
  %c.b36 = icmp ne i64 %v195, 0
  br i1 %c.b36, label %b36.t155, label %b36.e156
b36.t155:
  br label %b37
b36.e156:
  br label %b38
b37:
  %v196 = add i64 0, 4
  %v197 = getelementptr i64, ptr %v0, i64 %v196
  %v302 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v197, i64 %v302, i64 %v6)
  br label %b38
b38:
  %v303 = getelementptr i64, ptr @"rt.meta", i64 0
  %st156 = getelementptr i64, ptr %v303, i64 0
  store i64 %v6, ptr %st156
  ret void
b39:
  br label %b26
b40:
  %v209 = add i64 0, 3
  %v210 = getelementptr i64, ptr %v42, i64 %v209
  %v304 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v210, i64 %v304, i64 %v43)
  br label %b41
b41:
  %v305 = getelementptr i64, ptr @"rt.meta", i64 0
  %st157 = getelementptr i64, ptr %v305, i64 0
  store i64 %v43, ptr %st157
  br label %b7
b42:
  %v220 = add i64 0, 3
  %v221 = getelementptr i64, ptr %v35, i64 %v220
  %v306 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v221, i64 %v306, i64 %v36)
  br label %b43
b43:
  %v307 = getelementptr i64, ptr @"rt.meta", i64 0
  %st158 = getelementptr i64, ptr %v307, i64 0
  store i64 %v36, ptr %st158
  br label %b6
b44:
  %v225 = add i64 0, 0
  %st159 = getelementptr i64, ptr %v0, i64 0
  store i64 %v225, ptr %st159
  %v226.p = getelementptr i64, ptr %v35, i64 0
  %v226 = load i64, ptr %v226.p
  %st160 = getelementptr i64, ptr %v0, i64 1
  store i64 %v226, ptr %st160
  %v227.p = getelementptr i64, ptr %v35, i64 1
  %v227 = load i64, ptr %v227.p
  %st161 = getelementptr i64, ptr %v0, i64 2
  store i64 %v227, ptr %st161
  %v228.p = getelementptr i64, ptr %v35, i64 2
  %v228 = load i64, ptr %v228.p
  %st162 = getelementptr i64, ptr %v0, i64 3
  store i64 %v228, ptr %st162
  %v229.p = getelementptr i64, ptr %v35, i64 3
  %v229 = load i64, ptr %v229.p
  %st163 = getelementptr i64, ptr %v0, i64 4
  store i64 %v229, ptr %st163
  %v230.p = getelementptr i64, ptr %v35, i64 4
  %v230 = load i64, ptr %v230.p
  %st164 = getelementptr i64, ptr %v0, i64 5
  store i64 %v230, ptr %st164
  %v231.p = getelementptr i64, ptr %v35, i64 5
  %v231 = load i64, ptr %v231.p
  %st165 = getelementptr i64, ptr %v0, i64 6
  store i64 %v231, ptr %st165
  %v232.p = getelementptr i64, ptr %v28, i64 0
  %v232 = load i64, ptr %v232.p
  call void @"std/io.Close"(i64 %v232)
  %v233.p = getelementptr i64, ptr %v0, i64 1
  %v233 = load i64, ptr %v233.p
  %v234 = add i64 0, 0
  %v235.c = icmp ne i64 %v233, %v234
  %v235 = zext i1 %v235.c to i64
  %c.b44 = icmp ne i64 %v235, 0
  br i1 %c.b44, label %b44.t167, label %b44.e168
b44.t167:
  br label %b46
b44.e168:
  br label %b47
b45:
  br label %b5
b46:
  %v236 = add i64 0, 4
  %v237 = getelementptr i64, ptr %v0, i64 %v236
  %v308 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v237, i64 %v308, i64 %v6)
  br label %b47
b47:
  %v309 = getelementptr i64, ptr @"rt.meta", i64 0
  %st168 = getelementptr i64, ptr %v309, i64 0
  store i64 %v6, ptr %st168
  ret void
b48:
  %v245 = add i64 0, 0
  %st169 = getelementptr i64, ptr %v0, i64 0
  store i64 %v245, ptr %st169
  %v246.p = getelementptr i64, ptr %v241, i64 0
  %v246 = load i64, ptr %v246.p
  %st170 = getelementptr i64, ptr %v0, i64 1
  store i64 %v246, ptr %st170
  %v247.p = getelementptr i64, ptr %v241, i64 1
  %v247 = load i64, ptr %v247.p
  %st171 = getelementptr i64, ptr %v0, i64 2
  store i64 %v247, ptr %st171
  %v248.p = getelementptr i64, ptr %v241, i64 2
  %v248 = load i64, ptr %v248.p
  %st172 = getelementptr i64, ptr %v0, i64 3
  store i64 %v248, ptr %st172
  %v249.p = getelementptr i64, ptr %v241, i64 3
  %v249 = load i64, ptr %v249.p
  %st173 = getelementptr i64, ptr %v0, i64 4
  store i64 %v249, ptr %st173
  %v250.p = getelementptr i64, ptr %v241, i64 4
  %v250 = load i64, ptr %v250.p
  %st174 = getelementptr i64, ptr %v0, i64 5
  store i64 %v250, ptr %st174
  %v251.p = getelementptr i64, ptr %v241, i64 5
  %v251 = load i64, ptr %v251.p
  %st175 = getelementptr i64, ptr %v0, i64 6
  store i64 %v251, ptr %st175
  %v252.p = getelementptr i64, ptr %v28, i64 0
  %v252 = load i64, ptr %v252.p
  call void @"std/io.Close"(i64 %v252)
  %v253.p = getelementptr i64, ptr %v0, i64 1
  %v253 = load i64, ptr %v253.p
  %v254 = add i64 0, 0
  %v255.c = icmp ne i64 %v253, %v254
  %v255 = zext i1 %v255.c to i64
  %c.b48 = icmp ne i64 %v255, 0
  br i1 %c.b48, label %b48.t177, label %b48.e178
b48.t177:
  br label %b50
b48.e178:
  br label %b51
b49:
  %v258 = getelementptr i64, ptr %s17, i64 0
  %v259.p = getelementptr i64, ptr %v238, i64 0
  %v259 = load i64, ptr %v259.p
  %st178 = getelementptr i64, ptr %v258, i64 0
  store i64 %v259, ptr %st178
  %v260.p = getelementptr i64, ptr %v238, i64 1
  %v260 = load i64, ptr %v260.p
  %st179 = getelementptr i64, ptr %v258, i64 1
  store i64 %v260, ptr %st179
  %v261.p = getelementptr i64, ptr %v238, i64 2
  %v261 = load i64, ptr %v261.p
  %st180 = getelementptr i64, ptr %v258, i64 2
  store i64 %v261, ptr %st180
  %v262.p = getelementptr i64, ptr %v31, i64 0
  %v262 = load i64, ptr %v262.p
  %v263 = add i64 0, 1000000
  %v264 = mul i64 %v262, %v263
  %v265.p = getelementptr i64, ptr %v258, i64 1
  %v265 = load i64, ptr %v265.p
  %v266 = add i64 %v264, %v265
  %v267 = getelementptr i64, ptr %s10, i64 0
  %v268 = add i64 0, 0
  %st181 = getelementptr i64, ptr %v267, i64 0
  store i64 %v268, ptr %st181
  %st182 = getelementptr i64, ptr %v0, i64 0
  store i64 %v266, ptr %st182
  %v269.p = getelementptr i64, ptr %v267, i64 0
  %v269 = load i64, ptr %v269.p
  %st183 = getelementptr i64, ptr %v0, i64 1
  store i64 %v269, ptr %st183
  %v270.p = getelementptr i64, ptr %v267, i64 1
  %v270 = load i64, ptr %v270.p
  %st184 = getelementptr i64, ptr %v0, i64 2
  store i64 %v270, ptr %st184
  %v271.p = getelementptr i64, ptr %v267, i64 2
  %v271 = load i64, ptr %v271.p
  %st185 = getelementptr i64, ptr %v0, i64 3
  store i64 %v271, ptr %st185
  %v272.p = getelementptr i64, ptr %v267, i64 3
  %v272 = load i64, ptr %v272.p
  %st186 = getelementptr i64, ptr %v0, i64 4
  store i64 %v272, ptr %st186
  %v273.p = getelementptr i64, ptr %v267, i64 4
  %v273 = load i64, ptr %v273.p
  %st187 = getelementptr i64, ptr %v0, i64 5
  store i64 %v273, ptr %st187
  %v274.p = getelementptr i64, ptr %v267, i64 5
  %v274 = load i64, ptr %v274.p
  %st188 = getelementptr i64, ptr %v0, i64 6
  store i64 %v274, ptr %st188
  %v275.p = getelementptr i64, ptr %v28, i64 0
  %v275 = load i64, ptr %v275.p
  call void @"std/io.Close"(i64 %v275)
  %v276.p = getelementptr i64, ptr %v0, i64 1
  %v276 = load i64, ptr %v276.p
  %v277 = add i64 0, 0
  %v278.c = icmp ne i64 %v276, %v277
  %v278 = zext i1 %v278.c to i64
  %c.b49 = icmp ne i64 %v278, 0
  br i1 %c.b49, label %b49.t190, label %b49.e191
b49.t190:
  br label %b52
b49.e191:
  br label %b53
b50:
  %v256 = add i64 0, 4
  %v257 = getelementptr i64, ptr %v0, i64 %v256
  %v310 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v257, i64 %v310, i64 %v6)
  br label %b51
b51:
  %v311 = getelementptr i64, ptr @"rt.meta", i64 0
  %st191 = getelementptr i64, ptr %v311, i64 0
  store i64 %v6, ptr %st191
  ret void
b52:
  %v279 = add i64 0, 4
  %v280 = getelementptr i64, ptr %v0, i64 %v279
  %v312 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v280, i64 %v312, i64 %v6)
  br label %b53
b53:
  %v313 = getelementptr i64, ptr @"rt.meta", i64 0
  %st192 = getelementptr i64, ptr %v313, i64 0
  store i64 %v6, ptr %st192
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v95, i64 0
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
  %v19 = add i64 0, 4
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
  %v96 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v42, i64 %v96, i64 %v5)
  br label %b4
b4:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v97, i64 0
  store i64 %v5, ptr %st30
  ret void
b5:
  %v43 = call i64 @"rt.open"(ptr %v4)
  %v44 = add i64 0, 0
  %v45.c = icmp slt i64 %v43, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b5 = icmp ne i64 %v45, 0
  br i1 %c.b5, label %b5.t32, label %b5.e33
b5.t32:
  br label %b6
b5.e33:
  br label %b7
b6:
  %v46 = add i64 0, 1
  %v47 = add i64 0, 0
  %v48 = sub i64 %v47, %v46
  %v49 = getelementptr i64, ptr %s3, i64 0
  %v50 = add i64 0, 0
  %v51 = getelementptr i64, ptr %s2, i64 0
  %v52 = getelementptr i64, ptr %s1, i64 0
  %v53 = add i64 0, 0
  %st33 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st33
  %st34 = getelementptr i64, ptr %v52, i64 0
  store i64 %v48, ptr %st34
  %v54 = getelementptr i64, ptr %s7, i64 0
  %v55 = add i64 0, 0
  %v56 = sub i64 %v55, %v43
  call void @"std/io.errOf"(ptr %v54, i64 %v56)
  %v57 = getelementptr i64, ptr %s6, i64 0
  %v58 = add i64 0, 1
  %st35 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st35
  %v59.p = getelementptr i64, ptr %v54, i64 0
  %v59 = load i64, ptr %v59.p
  %st36 = getelementptr i64, ptr %v57, i64 1
  store i64 %v59, ptr %st36
  %v60.p = getelementptr i64, ptr %v54, i64 1
  %v60 = load i64, ptr %v60.p
  %st37 = getelementptr i64, ptr %v57, i64 2
  store i64 %v60, ptr %st37
  %v61.p = getelementptr i64, ptr %v54, i64 2
  %v61 = load i64, ptr %v61.p
  %st38 = getelementptr i64, ptr %v57, i64 3
  store i64 %v61, ptr %st38
  %v62.p = getelementptr i64, ptr %v54, i64 3
  %v62 = load i64, ptr %v62.p
  %st39 = getelementptr i64, ptr %v57, i64 4
  store i64 %v62, ptr %st39
  %v63.p = getelementptr i64, ptr %v54, i64 4
  %v63 = load i64, ptr %v63.p
  %st40 = getelementptr i64, ptr %v57, i64 5
  store i64 %v63, ptr %st40
  %v64.p = getelementptr i64, ptr %v52, i64 0
  %v64 = load i64, ptr %v64.p
  %st41 = getelementptr i64, ptr %v0, i64 0
  store i64 %v64, ptr %st41
  %v65.p = getelementptr i64, ptr %v57, i64 0
  %v65 = load i64, ptr %v65.p
  %st42 = getelementptr i64, ptr %v0, i64 1
  store i64 %v65, ptr %st42
  %v66.p = getelementptr i64, ptr %v57, i64 1
  %v66 = load i64, ptr %v66.p
  %st43 = getelementptr i64, ptr %v0, i64 2
  store i64 %v66, ptr %st43
  %v67.p = getelementptr i64, ptr %v57, i64 2
  %v67 = load i64, ptr %v67.p
  %st44 = getelementptr i64, ptr %v0, i64 3
  store i64 %v67, ptr %st44
  %v68.p = getelementptr i64, ptr %v57, i64 3
  %v68 = load i64, ptr %v68.p
  %st45 = getelementptr i64, ptr %v0, i64 4
  store i64 %v68, ptr %st45
  %v69.p = getelementptr i64, ptr %v57, i64 4
  %v69 = load i64, ptr %v69.p
  %st46 = getelementptr i64, ptr %v0, i64 5
  store i64 %v69, ptr %st46
  %v70.p = getelementptr i64, ptr %v57, i64 5
  %v70 = load i64, ptr %v70.p
  %st47 = getelementptr i64, ptr %v0, i64 6
  store i64 %v70, ptr %st47
  %v71.p = getelementptr i64, ptr %v0, i64 1
  %v71 = load i64, ptr %v71.p
  %v72 = add i64 0, 0
  %v73.c = icmp ne i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b6 = icmp ne i64 %v73, 0
  br i1 %c.b6, label %b6.t49, label %b6.e50
b6.t49:
  br label %b8
b6.e50:
  br label %b9
b7:
  br label %b10
b8:
  %v74 = add i64 0, 4
  %v75 = getelementptr i64, ptr %v0, i64 %v74
  %v98 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v75, i64 %v98, i64 %v5)
  br label %b9
b9:
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v99, i64 0
  store i64 %v5, ptr %st50
  ret void
b10:
  %v76 = getelementptr i64, ptr %s1, i64 0
  %v77 = add i64 0, 0
  %v78 = getelementptr i64, ptr %s2, i64 0
  %v79 = getelementptr i64, ptr %s3, i64 0
  %v80 = add i64 0, 0
  %st51 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st51
  %st52 = getelementptr i64, ptr %v79, i64 0
  store i64 %v43, ptr %st52
  %v81 = getelementptr i64, ptr %s6, i64 0
  %v82 = add i64 0, 0
  %st53 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st53
  %v83.p = getelementptr i64, ptr %v79, i64 0
  %v83 = load i64, ptr %v83.p
  %st54 = getelementptr i64, ptr %v0, i64 0
  store i64 %v83, ptr %st54
  %v84.p = getelementptr i64, ptr %v81, i64 0
  %v84 = load i64, ptr %v84.p
  %st55 = getelementptr i64, ptr %v0, i64 1
  store i64 %v84, ptr %st55
  %v85.p = getelementptr i64, ptr %v81, i64 1
  %v85 = load i64, ptr %v85.p
  %st56 = getelementptr i64, ptr %v0, i64 2
  store i64 %v85, ptr %st56
  %v86.p = getelementptr i64, ptr %v81, i64 2
  %v86 = load i64, ptr %v86.p
  %st57 = getelementptr i64, ptr %v0, i64 3
  store i64 %v86, ptr %st57
  %v87.p = getelementptr i64, ptr %v81, i64 3
  %v87 = load i64, ptr %v87.p
  %st58 = getelementptr i64, ptr %v0, i64 4
  store i64 %v87, ptr %st58
  %v88.p = getelementptr i64, ptr %v81, i64 4
  %v88 = load i64, ptr %v88.p
  %st59 = getelementptr i64, ptr %v0, i64 5
  store i64 %v88, ptr %st59
  %v89.p = getelementptr i64, ptr %v81, i64 5
  %v89 = load i64, ptr %v89.p
  %st60 = getelementptr i64, ptr %v0, i64 6
  store i64 %v89, ptr %st60
  %v90.p = getelementptr i64, ptr %v0, i64 1
  %v90 = load i64, ptr %v90.p
  %v91 = add i64 0, 0
  %v92.c = icmp ne i64 %v90, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b10 = icmp ne i64 %v92, 0
  br i1 %c.b10, label %b10.t62, label %b10.e63
b10.t62:
  br label %b11
b10.e63:
  br label %b12
b11:
  %v93 = add i64 0, 4
  %v94 = getelementptr i64, ptr %v0, i64 %v93
  %v100 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v94, i64 %v100, i64 %v5)
  br label %b12
b12:
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v101, i64 0
  store i64 %v5, ptr %st63
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
  %v48 = add i64 0, 3
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
  %v62 = add i64 0, 6
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
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v1, ptr %st0
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v98, i64 0
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
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v99, i64 0
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %v9 = call ptr @"rt.region_alloc8"(i64 %v7, i64 %v8)
  %v10 = add i64 0, 0
  %v11 = getelementptr i64, ptr %s1, i64 0
  %v12 = ptrtoint ptr %v9 to i64
  %st3 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st3
  %st4 = getelementptr i64, ptr %v11, i64 1
  store i64 %v10, ptr %st4
  %st5 = getelementptr i64, ptr %v11, i64 2
  store i64 %v7, ptr %st5
  %v13 = getelementptr i64, ptr %s2, i64 0
  %v14 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 1
  store i64 %v14, ptr %st7
  %v15 = add i64 0, 4
  %st8 = getelementptr i64, ptr %v13, i64 0
  store i64 %v15, ptr %st8
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v13, i64 0
  %v17 = load i64, ptr %v17.p
  %st9 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st9
  %v18.p = getelementptr i64, ptr %v13, i64 1
  %v18 = load i64, ptr %v18.p
  %st10 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st10
  %v19 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st11
  %st12 = getelementptr i64, ptr %v16, i64 3
  store i64 %v19, ptr %st12
  %st13 = getelementptr i64, ptr %v16, i64 4
  store i64 %v19, ptr %st13
  %v20 = getelementptr i64, ptr %s4, i64 0
  %v21 = add i64 0, 1
  %st14 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st14
  %v22.p = getelementptr i64, ptr %v16, i64 0
  %v22 = load i64, ptr %v22.p
  %st15 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st15
  %v23.p = getelementptr i64, ptr %v16, i64 1
  %v23 = load i64, ptr %v23.p
  %st16 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st16
  %v24.p = getelementptr i64, ptr %v16, i64 2
  %v24 = load i64, ptr %v24.p
  %st17 = getelementptr i64, ptr %v20, i64 3
  store i64 %v24, ptr %st17
  %v25.p = getelementptr i64, ptr %v16, i64 3
  %v25 = load i64, ptr %v25.p
  %st18 = getelementptr i64, ptr %v20, i64 4
  store i64 %v25, ptr %st18
  %v26.p = getelementptr i64, ptr %v16, i64 4
  %v26 = load i64, ptr %v26.p
  %st19 = getelementptr i64, ptr %v20, i64 5
  store i64 %v26, ptr %st19
  %v27.p = getelementptr i64, ptr %v11, i64 0
  %v27 = load i64, ptr %v27.p
  %st20 = getelementptr i64, ptr %v0, i64 0
  store i64 %v27, ptr %st20
  %v28.p = getelementptr i64, ptr %v11, i64 1
  %v28 = load i64, ptr %v28.p
  %st21 = getelementptr i64, ptr %v0, i64 1
  store i64 %v28, ptr %st21
  %v29.p = getelementptr i64, ptr %v11, i64 2
  %v29 = load i64, ptr %v29.p
  %st22 = getelementptr i64, ptr %v0, i64 2
  store i64 %v29, ptr %st22
  %v30.p = getelementptr i64, ptr %v20, i64 0
  %v30 = load i64, ptr %v30.p
  %st23 = getelementptr i64, ptr %v0, i64 3
  store i64 %v30, ptr %st23
  %v31.p = getelementptr i64, ptr %v20, i64 1
  %v31 = load i64, ptr %v31.p
  %st24 = getelementptr i64, ptr %v0, i64 4
  store i64 %v31, ptr %st24
  %v32.p = getelementptr i64, ptr %v20, i64 2
  %v32 = load i64, ptr %v32.p
  %st25 = getelementptr i64, ptr %v0, i64 5
  store i64 %v32, ptr %st25
  %v33.p = getelementptr i64, ptr %v20, i64 3
  %v33 = load i64, ptr %v33.p
  %st26 = getelementptr i64, ptr %v0, i64 6
  store i64 %v33, ptr %st26
  %v34.p = getelementptr i64, ptr %v20, i64 4
  %v34 = load i64, ptr %v34.p
  %st27 = getelementptr i64, ptr %v0, i64 7
  store i64 %v34, ptr %st27
  %v35.p = getelementptr i64, ptr %v20, i64 5
  %v35 = load i64, ptr %v35.p
  %st28 = getelementptr i64, ptr %v0, i64 8
  store i64 %v35, ptr %st28
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v36.p = getelementptr i64, ptr %v0, i64 3
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 0, 0
  %v38.c = icmp ne i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b1 = icmp ne i64 %v38, 0
  br i1 %c.b1, label %b1.t30, label %b1.e31
b1.t30:
  br label %b3
b1.e31:
  br label %b4
b2:
  br label %b5
b3:
  %v39 = add i64 0, 6
  %v40 = getelementptr i64, ptr %v0, i64 %v39
  %v100 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v40, i64 %v100, i64 %v3)
  br label %b4
b4:
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v101, i64 0
  store i64 %v3, ptr %st31
  ret void
b5:
  %v41.p = getelementptr i64, ptr %v2, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 1
  %v43 = add i64 0, 0
  %v44 = sub i64 %v43, %v42
  %v45 = getelementptr i64, ptr %s1, i64 0
  call void @"rt.read_fd"(i64 %v41, i64 %v44, ptr %v45)
  %v46 = getelementptr i64, ptr %s5, i64 0
  %v47.p = getelementptr i64, ptr %v45, i64 0
  %v47 = load i64, ptr %v47.p
  %st32 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st32
  %v48.p = getelementptr i64, ptr %v45, i64 1
  %v48 = load i64, ptr %v48.p
  %st33 = getelementptr i64, ptr %v46, i64 1
  store i64 %v48, ptr %st33
  %v49.p = getelementptr i64, ptr %v45, i64 2
  %v49 = load i64, ptr %v49.p
  %st34 = getelementptr i64, ptr %v46, i64 2
  store i64 %v49, ptr %st34
  %v50 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v50, i64 1027
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp ne i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b5 = icmp ne i64 %v53, 0
  br i1 %c.b5, label %b5.t36, label %b5.e37
b5.t36:
  br label %b6
b5.e37:
  br label %b7
b6:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %v54.p = getelementptr i64, ptr %v102, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = add i64 0, 0
  %v56 = call ptr @"rt.region_alloc8"(i64 %v54, i64 %v55)
  %v57 = add i64 0, 0
  %v58 = getelementptr i64, ptr %s1, i64 0
  %v59 = ptrtoint ptr %v56 to i64
  %st37 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st37
  %st38 = getelementptr i64, ptr %v58, i64 1
  store i64 %v57, ptr %st38
  %st39 = getelementptr i64, ptr %v58, i64 2
  store i64 %v54, ptr %st39
  %v60 = getelementptr i64, ptr %s6, i64 0
  call void @"std/io.errOf"(ptr %v60, i64 %v51)
  %v61 = getelementptr i64, ptr %s4, i64 0
  %v62 = add i64 0, 1
  %st40 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st40
  %v63.p = getelementptr i64, ptr %v60, i64 0
  %v63 = load i64, ptr %v63.p
  %st41 = getelementptr i64, ptr %v61, i64 1
  store i64 %v63, ptr %st41
  %v64.p = getelementptr i64, ptr %v60, i64 1
  %v64 = load i64, ptr %v64.p
  %st42 = getelementptr i64, ptr %v61, i64 2
  store i64 %v64, ptr %st42
  %v65.p = getelementptr i64, ptr %v60, i64 2
  %v65 = load i64, ptr %v65.p
  %st43 = getelementptr i64, ptr %v61, i64 3
  store i64 %v65, ptr %st43
  %v66.p = getelementptr i64, ptr %v60, i64 3
  %v66 = load i64, ptr %v66.p
  %st44 = getelementptr i64, ptr %v61, i64 4
  store i64 %v66, ptr %st44
  %v67.p = getelementptr i64, ptr %v60, i64 4
  %v67 = load i64, ptr %v67.p
  %st45 = getelementptr i64, ptr %v61, i64 5
  store i64 %v67, ptr %st45
  %v68.p = getelementptr i64, ptr %v58, i64 0
  %v68 = load i64, ptr %v68.p
  %st46 = getelementptr i64, ptr %v0, i64 0
  store i64 %v68, ptr %st46
  %v69.p = getelementptr i64, ptr %v58, i64 1
  %v69 = load i64, ptr %v69.p
  %st47 = getelementptr i64, ptr %v0, i64 1
  store i64 %v69, ptr %st47
  %v70.p = getelementptr i64, ptr %v58, i64 2
  %v70 = load i64, ptr %v70.p
  %st48 = getelementptr i64, ptr %v0, i64 2
  store i64 %v70, ptr %st48
  %v71.p = getelementptr i64, ptr %v61, i64 0
  %v71 = load i64, ptr %v71.p
  %st49 = getelementptr i64, ptr %v0, i64 3
  store i64 %v71, ptr %st49
  %v72.p = getelementptr i64, ptr %v61, i64 1
  %v72 = load i64, ptr %v72.p
  %st50 = getelementptr i64, ptr %v0, i64 4
  store i64 %v72, ptr %st50
  %v73.p = getelementptr i64, ptr %v61, i64 2
  %v73 = load i64, ptr %v73.p
  %st51 = getelementptr i64, ptr %v0, i64 5
  store i64 %v73, ptr %st51
  %v74.p = getelementptr i64, ptr %v61, i64 3
  %v74 = load i64, ptr %v74.p
  %st52 = getelementptr i64, ptr %v0, i64 6
  store i64 %v74, ptr %st52
  %v75.p = getelementptr i64, ptr %v61, i64 4
  %v75 = load i64, ptr %v75.p
  %st53 = getelementptr i64, ptr %v0, i64 7
  store i64 %v75, ptr %st53
  %v76.p = getelementptr i64, ptr %v61, i64 5
  %v76 = load i64, ptr %v76.p
  %st54 = getelementptr i64, ptr %v0, i64 8
  store i64 %v76, ptr %st54
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v77.p = getelementptr i64, ptr %v0, i64 3
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79.c = icmp ne i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b6 = icmp ne i64 %v79, 0
  br i1 %c.b6, label %b6.t56, label %b6.e57
b6.t56:
  br label %b8
b6.e57:
  br label %b9
b7:
  br label %b10
b8:
  %v80 = add i64 0, 6
  %v81 = getelementptr i64, ptr %v0, i64 %v80
  %v103 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v81, i64 %v103, i64 %v3)
  br label %b9
b9:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v104, i64 0
  store i64 %v3, ptr %st57
  ret void
b10:
  %v82 = getelementptr i64, ptr %s4, i64 0
  %v83 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st58
  %v84.p = getelementptr i64, ptr %v46, i64 0
  %v84 = load i64, ptr %v84.p
  %st59 = getelementptr i64, ptr %v0, i64 0
  store i64 %v84, ptr %st59
  %v85.p = getelementptr i64, ptr %v46, i64 1
  %v85 = load i64, ptr %v85.p
  %st60 = getelementptr i64, ptr %v0, i64 1
  store i64 %v85, ptr %st60
  %v86.p = getelementptr i64, ptr %v46, i64 2
  %v86 = load i64, ptr %v86.p
  %st61 = getelementptr i64, ptr %v0, i64 2
  store i64 %v86, ptr %st61
  %v87.p = getelementptr i64, ptr %v82, i64 0
  %v87 = load i64, ptr %v87.p
  %st62 = getelementptr i64, ptr %v0, i64 3
  store i64 %v87, ptr %st62
  %v88.p = getelementptr i64, ptr %v82, i64 1
  %v88 = load i64, ptr %v88.p
  %st63 = getelementptr i64, ptr %v0, i64 4
  store i64 %v88, ptr %st63
  %v89.p = getelementptr i64, ptr %v82, i64 2
  %v89 = load i64, ptr %v89.p
  %st64 = getelementptr i64, ptr %v0, i64 5
  store i64 %v89, ptr %st64
  %v90.p = getelementptr i64, ptr %v82, i64 3
  %v90 = load i64, ptr %v90.p
  %st65 = getelementptr i64, ptr %v0, i64 6
  store i64 %v90, ptr %st65
  %v91.p = getelementptr i64, ptr %v82, i64 4
  %v91 = load i64, ptr %v91.p
  %st66 = getelementptr i64, ptr %v0, i64 7
  store i64 %v91, ptr %st66
  %v92.p = getelementptr i64, ptr %v82, i64 5
  %v92 = load i64, ptr %v92.p
  %st67 = getelementptr i64, ptr %v0, i64 8
  store i64 %v92, ptr %st67
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v93.p = getelementptr i64, ptr %v0, i64 3
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 0
  %v95.c = icmp ne i64 %v93, %v94
  %v95 = zext i1 %v95.c to i64
  %c.b10 = icmp ne i64 %v95, 0
  br i1 %c.b10, label %b10.t69, label %b10.e70
b10.t69:
  br label %b11
b10.e70:
  br label %b12
b11:
  %v96 = add i64 0, 6
  %v97 = getelementptr i64, ptr %v0, i64 %v96
  %v105 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v97, i64 %v105, i64 %v3)
  br label %b12
b12:
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v106, i64 0
  store i64 %v3, ptr %st70
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v96, i64 0
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
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v97, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 0
  %v11 = call ptr @"rt.region_alloc8"(i64 %v9, i64 %v10)
  %v12 = add i64 0, 0
  %v13 = getelementptr i64, ptr %s1, i64 0
  %v14 = ptrtoint ptr %v11 to i64
  %st5 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st5
  %st6 = getelementptr i64, ptr %v13, i64 1
  store i64 %v12, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 2
  store i64 %v9, ptr %st7
  %v15 = getelementptr i64, ptr %s2, i64 0
  %v16 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st8
  %st9 = getelementptr i64, ptr %v15, i64 1
  store i64 %v16, ptr %st9
  %v17 = add i64 0, 4
  %st10 = getelementptr i64, ptr %v15, i64 0
  store i64 %v17, ptr %st10
  %v18 = getelementptr i64, ptr %s3, i64 0
  %v19.p = getelementptr i64, ptr %v15, i64 0
  %v19 = load i64, ptr %v19.p
  %st11 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st11
  %v20.p = getelementptr i64, ptr %v15, i64 1
  %v20 = load i64, ptr %v20.p
  %st12 = getelementptr i64, ptr %v18, i64 1
  store i64 %v20, ptr %st12
  %v21 = add i64 0, 0
  %st13 = getelementptr i64, ptr %v18, i64 2
  store i64 %v21, ptr %st13
  %st14 = getelementptr i64, ptr %v18, i64 3
  store i64 %v21, ptr %st14
  %st15 = getelementptr i64, ptr %v18, i64 4
  store i64 %v21, ptr %st15
  %v22 = getelementptr i64, ptr %s4, i64 0
  %v23 = add i64 0, 1
  %st16 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st16
  %v24.p = getelementptr i64, ptr %v18, i64 0
  %v24 = load i64, ptr %v24.p
  %st17 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st17
  %v25.p = getelementptr i64, ptr %v18, i64 1
  %v25 = load i64, ptr %v25.p
  %st18 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st18
  %v26.p = getelementptr i64, ptr %v18, i64 2
  %v26 = load i64, ptr %v26.p
  %st19 = getelementptr i64, ptr %v22, i64 3
  store i64 %v26, ptr %st19
  %v27.p = getelementptr i64, ptr %v18, i64 3
  %v27 = load i64, ptr %v27.p
  %st20 = getelementptr i64, ptr %v22, i64 4
  store i64 %v27, ptr %st20
  %v28.p = getelementptr i64, ptr %v18, i64 4
  %v28 = load i64, ptr %v28.p
  %st21 = getelementptr i64, ptr %v22, i64 5
  store i64 %v28, ptr %st21
  %v29.p = getelementptr i64, ptr %v13, i64 0
  %v29 = load i64, ptr %v29.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v29, ptr %st22
  %v30.p = getelementptr i64, ptr %v13, i64 1
  %v30 = load i64, ptr %v30.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v30, ptr %st23
  %v31.p = getelementptr i64, ptr %v13, i64 2
  %v31 = load i64, ptr %v31.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v31, ptr %st24
  %v32.p = getelementptr i64, ptr %v22, i64 0
  %v32 = load i64, ptr %v32.p
  %st25 = getelementptr i64, ptr %v0, i64 3
  store i64 %v32, ptr %st25
  %v33.p = getelementptr i64, ptr %v22, i64 1
  %v33 = load i64, ptr %v33.p
  %st26 = getelementptr i64, ptr %v0, i64 4
  store i64 %v33, ptr %st26
  %v34.p = getelementptr i64, ptr %v22, i64 2
  %v34 = load i64, ptr %v34.p
  %st27 = getelementptr i64, ptr %v0, i64 5
  store i64 %v34, ptr %st27
  %v35.p = getelementptr i64, ptr %v22, i64 3
  %v35 = load i64, ptr %v35.p
  %st28 = getelementptr i64, ptr %v0, i64 6
  store i64 %v35, ptr %st28
  %v36.p = getelementptr i64, ptr %v22, i64 4
  %v36 = load i64, ptr %v36.p
  %st29 = getelementptr i64, ptr %v0, i64 7
  store i64 %v36, ptr %st29
  %v37.p = getelementptr i64, ptr %v22, i64 5
  %v37 = load i64, ptr %v37.p
  %st30 = getelementptr i64, ptr %v0, i64 8
  store i64 %v37, ptr %st30
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v38.p = getelementptr i64, ptr %v0, i64 3
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40.c = icmp ne i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b1 = icmp ne i64 %v40, 0
  br i1 %c.b1, label %b1.t32, label %b1.e33
b1.t32:
  br label %b3
b1.e33:
  br label %b4
b2:
  br label %b5
b3:
  %v41 = add i64 0, 6
  %v42 = getelementptr i64, ptr %v0, i64 %v41
  %v98 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v42, i64 %v98, i64 %v5)
  br label %b4
b4:
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v99, i64 0
  store i64 %v5, ptr %st33
  ret void
b5:
  %v43 = getelementptr i64, ptr %s1, i64 0
  call void @"rt.read_file"(ptr %v4, ptr %v43)
  %v44 = getelementptr i64, ptr %s5, i64 0
  %v45.p = getelementptr i64, ptr %v43, i64 0
  %v45 = load i64, ptr %v45.p
  %st34 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st34
  %v46.p = getelementptr i64, ptr %v43, i64 1
  %v46 = load i64, ptr %v46.p
  %st35 = getelementptr i64, ptr %v44, i64 1
  store i64 %v46, ptr %st35
  %v47.p = getelementptr i64, ptr %v43, i64 2
  %v47 = load i64, ptr %v47.p
  %st36 = getelementptr i64, ptr %v44, i64 2
  store i64 %v47, ptr %st36
  %v48 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v48, i64 1027
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.c = icmp ne i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b5 = icmp ne i64 %v51, 0
  br i1 %c.b5, label %b5.t38, label %b5.e39
b5.t38:
  br label %b6
b5.e39:
  br label %b7
b6:
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %v52.p = getelementptr i64, ptr %v100, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 0
  %v54 = call ptr @"rt.region_alloc8"(i64 %v52, i64 %v53)
  %v55 = add i64 0, 0
  %v56 = getelementptr i64, ptr %s1, i64 0
  %v57 = ptrtoint ptr %v54 to i64
  %st39 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st39
  %st40 = getelementptr i64, ptr %v56, i64 1
  store i64 %v55, ptr %st40
  %st41 = getelementptr i64, ptr %v56, i64 2
  store i64 %v52, ptr %st41
  %v58 = getelementptr i64, ptr %s6, i64 0
  call void @"std/io.errOf"(ptr %v58, i64 %v49)
  %v59 = getelementptr i64, ptr %s4, i64 0
  %v60 = add i64 0, 1
  %st42 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st42
  %v61.p = getelementptr i64, ptr %v58, i64 0
  %v61 = load i64, ptr %v61.p
  %st43 = getelementptr i64, ptr %v59, i64 1
  store i64 %v61, ptr %st43
  %v62.p = getelementptr i64, ptr %v58, i64 1
  %v62 = load i64, ptr %v62.p
  %st44 = getelementptr i64, ptr %v59, i64 2
  store i64 %v62, ptr %st44
  %v63.p = getelementptr i64, ptr %v58, i64 2
  %v63 = load i64, ptr %v63.p
  %st45 = getelementptr i64, ptr %v59, i64 3
  store i64 %v63, ptr %st45
  %v64.p = getelementptr i64, ptr %v58, i64 3
  %v64 = load i64, ptr %v64.p
  %st46 = getelementptr i64, ptr %v59, i64 4
  store i64 %v64, ptr %st46
  %v65.p = getelementptr i64, ptr %v58, i64 4
  %v65 = load i64, ptr %v65.p
  %st47 = getelementptr i64, ptr %v59, i64 5
  store i64 %v65, ptr %st47
  %v66.p = getelementptr i64, ptr %v56, i64 0
  %v66 = load i64, ptr %v66.p
  %st48 = getelementptr i64, ptr %v0, i64 0
  store i64 %v66, ptr %st48
  %v67.p = getelementptr i64, ptr %v56, i64 1
  %v67 = load i64, ptr %v67.p
  %st49 = getelementptr i64, ptr %v0, i64 1
  store i64 %v67, ptr %st49
  %v68.p = getelementptr i64, ptr %v56, i64 2
  %v68 = load i64, ptr %v68.p
  %st50 = getelementptr i64, ptr %v0, i64 2
  store i64 %v68, ptr %st50
  %v69.p = getelementptr i64, ptr %v59, i64 0
  %v69 = load i64, ptr %v69.p
  %st51 = getelementptr i64, ptr %v0, i64 3
  store i64 %v69, ptr %st51
  %v70.p = getelementptr i64, ptr %v59, i64 1
  %v70 = load i64, ptr %v70.p
  %st52 = getelementptr i64, ptr %v0, i64 4
  store i64 %v70, ptr %st52
  %v71.p = getelementptr i64, ptr %v59, i64 2
  %v71 = load i64, ptr %v71.p
  %st53 = getelementptr i64, ptr %v0, i64 5
  store i64 %v71, ptr %st53
  %v72.p = getelementptr i64, ptr %v59, i64 3
  %v72 = load i64, ptr %v72.p
  %st54 = getelementptr i64, ptr %v0, i64 6
  store i64 %v72, ptr %st54
  %v73.p = getelementptr i64, ptr %v59, i64 4
  %v73 = load i64, ptr %v73.p
  %st55 = getelementptr i64, ptr %v0, i64 7
  store i64 %v73, ptr %st55
  %v74.p = getelementptr i64, ptr %v59, i64 5
  %v74 = load i64, ptr %v74.p
  %st56 = getelementptr i64, ptr %v0, i64 8
  store i64 %v74, ptr %st56
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v75.p = getelementptr i64, ptr %v0, i64 3
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 0
  %v77.c = icmp ne i64 %v75, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b6 = icmp ne i64 %v77, 0
  br i1 %c.b6, label %b6.t58, label %b6.e59
b6.t58:
  br label %b8
b6.e59:
  br label %b9
b7:
  br label %b10
b8:
  %v78 = add i64 0, 6
  %v79 = getelementptr i64, ptr %v0, i64 %v78
  %v101 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v79, i64 %v101, i64 %v5)
  br label %b9
b9:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v102, i64 0
  store i64 %v5, ptr %st59
  ret void
b10:
  %v80 = getelementptr i64, ptr %s4, i64 0
  %v81 = add i64 0, 0
  %st60 = getelementptr i64, ptr %v80, i64 0
  store i64 %v81, ptr %st60
  %v82.p = getelementptr i64, ptr %v44, i64 0
  %v82 = load i64, ptr %v82.p
  %st61 = getelementptr i64, ptr %v0, i64 0
  store i64 %v82, ptr %st61
  %v83.p = getelementptr i64, ptr %v44, i64 1
  %v83 = load i64, ptr %v83.p
  %st62 = getelementptr i64, ptr %v0, i64 1
  store i64 %v83, ptr %st62
  %v84.p = getelementptr i64, ptr %v44, i64 2
  %v84 = load i64, ptr %v84.p
  %st63 = getelementptr i64, ptr %v0, i64 2
  store i64 %v84, ptr %st63
  %v85.p = getelementptr i64, ptr %v80, i64 0
  %v85 = load i64, ptr %v85.p
  %st64 = getelementptr i64, ptr %v0, i64 3
  store i64 %v85, ptr %st64
  %v86.p = getelementptr i64, ptr %v80, i64 1
  %v86 = load i64, ptr %v86.p
  %st65 = getelementptr i64, ptr %v0, i64 4
  store i64 %v86, ptr %st65
  %v87.p = getelementptr i64, ptr %v80, i64 2
  %v87 = load i64, ptr %v87.p
  %st66 = getelementptr i64, ptr %v0, i64 5
  store i64 %v87, ptr %st66
  %v88.p = getelementptr i64, ptr %v80, i64 3
  %v88 = load i64, ptr %v88.p
  %st67 = getelementptr i64, ptr %v0, i64 6
  store i64 %v88, ptr %st67
  %v89.p = getelementptr i64, ptr %v80, i64 4
  %v89 = load i64, ptr %v89.p
  %st68 = getelementptr i64, ptr %v0, i64 7
  store i64 %v89, ptr %st68
  %v90.p = getelementptr i64, ptr %v80, i64 5
  %v90 = load i64, ptr %v90.p
  %st69 = getelementptr i64, ptr %v0, i64 8
  store i64 %v90, ptr %st69
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v91.p = getelementptr i64, ptr %v0, i64 3
  %v91 = load i64, ptr %v91.p
  %v92 = add i64 0, 0
  %v93.c = icmp ne i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b10 = icmp ne i64 %v93, 0
  br i1 %c.b10, label %b10.t71, label %b10.e72
b10.t71:
  br label %b11
b10.e72:
  br label %b12
b11:
  %v94 = add i64 0, 6
  %v95 = getelementptr i64, ptr %v0, i64 %v94
  %v103 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v95, i64 %v103, i64 %v5)
  br label %b12
b12:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st72 = getelementptr i64, ptr %v104, i64 0
  store i64 %v5, ptr %st72
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

define internal void @"std/internal/utf8.Parse"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v9 = call i64 @"std/strings.IndexInvalid"(i64 %v6, i64 %v7, i64 %v8)
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
  %v19 = add i64 0, 12
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

define internal i64 @"std/strings.IndexInvalid"(i64 %v0, i64 %v1, i64 %v2) #0 {
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
  %v26 = call i64 @"std/strings.validPrefix"(i64 %v22, i64 %v23, i64 %v24, i64 %v25)
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
  %v137 = call i64 @"std/strings.seqLen"(i64 %v133, i64 %v134, i64 %v135, i64 %v136)
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

define internal i64 @"std/strings.validPrefix"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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

define internal i64 @"std/strings.seqLen"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v31 = call i64 @"std/strings.cont"(i64 %v24, i64 %v25, i64 %v26, i64 %v28, i64 %v29, i64 %v30)
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
  %v55 = call i64 @"std/strings.cont"(i64 %v50, i64 %v51, i64 %v52, i64 %v54, i64 %v44, i64 %v49)
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
  %v64 = call i64 @"std/strings.cont"(i64 %v57, i64 %v58, i64 %v59, i64 %v61, i64 %v62, i64 %v63)
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
  %v88 = call i64 @"std/strings.cont"(i64 %v83, i64 %v84, i64 %v85, i64 %v87, i64 %v77, i64 %v82)
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
  %v97 = call i64 @"std/strings.cont"(i64 %v90, i64 %v91, i64 %v92, i64 %v94, i64 %v95, i64 %v96)
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
  %v106 = call i64 @"std/strings.cont"(i64 %v99, i64 %v100, i64 %v101, i64 %v103, i64 %v104, i64 %v105)
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

define internal i64 @"std/strings.cont"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
