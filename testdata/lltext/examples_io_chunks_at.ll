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
@"str.1" = internal constant [4 x i64] [i64 7022344803055789428, i64 3418902202392996143, i64 3687730609345749857, i64 1735355438]
@"str.2" = internal constant [1 x i64] [i64 9117586028262768]
@"str.3" = internal constant [1 x i64] [i64 2322295501785690912]
@"str.4" = internal constant [1 x i64] [i64 2108192]
@"str.5" = internal constant [1 x i64] [i64 126879583003168]
@"str.6" = internal constant [3 x i64] [i64 7162245557357341026, i64 8386103967183369067, i64 35435416217699]
@"str.7" = internal constant [1 x i64] [i64 1702195828]
@"str.8" = internal constant [1 x i64] [i64 435728179558]
@"str.9" = internal constant [2 x i64] [i64 3472329328047387238, i64 138415190064]
@"str.10" = internal constant [3 x i64] [i64 2318354787771965984, i64 7018105893571356788, i64 35435299225956]
@"str.11" = internal constant [2 x i64] [i64 7286935696384750689, i64 540697710]
@"str.12" = internal constant [1 x i64] [i64 126943922778912]
@"str.13" = internal constant [3 x i64] [i64 7311146993653867886, i64 4212103097811889952, i64 9129719411926304]
@"str.14" = internal constant [3 x i64] [i64 7311146993653867886, i64 4212103097811889952, i64 16160]
@"str.15" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.16" = internal constant [1 x i64] [i64 45]
@"str.17" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.18" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.19" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.20" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.21" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.22" = internal constant [1 x i64] [i64 2685]
@"str.23" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.24" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.25" = internal constant [1 x i64] [i64 35899498962976]
@"str.26" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.27" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [12 x i64] [i64 10414575329476609, i64 12947850119872513, i64 5910975802769409, i64 9288675540074497, i64 6192450796257281, i64 3659176089747457, i64 3659176089747457, i64 3659176106524673, i64 7599827491750147, i64 8725727448924419, i64 8444252572877057, i64 3659174932120065]
@"str.28" = internal constant [1 x i64] [i64 9071397899755888]
@"str.29" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.30" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.31" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.32" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.33" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.34" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.35" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.36" = internal constant [1 x i64] [i64 544497952]
@"str.37" = internal constant [3 x i64] [i64 7741253900700708713, i64 7093014581490048883, i64 29285]
@"str.38" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]
@"str.39" = internal constant [3 x i64] [i64 8243122688087061619, i64 8030813629395003695, i64 7497058]

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
  %v3 = getelementptr i64, ptr @"str.17", i64 0
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
  %v29 = getelementptr i64, ptr @"str.21", i64 0
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
  %v35 = getelementptr i64, ptr @"str.22", i64 0
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
  %v10 = getelementptr i64, ptr @"str.18", i64 0
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
  %v17 = getelementptr i64, ptr @"str.19", i64 0
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
  %v24 = getelementptr i64, ptr @"str.20", i64 0
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
  %v60 = getelementptr i64, ptr @"str.23", i64 0
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
  %v65 = getelementptr i64, ptr @"str.24", i64 0
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
  %v70 = getelementptr i64, ptr @"str.22", i64 0
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
  %v81 = getelementptr i64, ptr @"str.25", i64 0
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
  %v88 = getelementptr i64, ptr @"str.26", i64 0
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
  %v17 = getelementptr i64, ptr @"str.27", i64 0
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
  %v22 = getelementptr i64, ptr @"str.22", i64 0
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
  %s3 = alloca [9 x i64], align 8
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
  %s3.z7 = getelementptr i64, ptr %s3, i64 7
  store i64 0, ptr %s3.z7
  %s3.z8 = getelementptr i64, ptr %s3, i64 8
  store i64 0, ptr %s3.z8
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
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s12 = alloca [1 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s13 = alloca [1 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %s14 = alloca [1 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s15 = alloca [10 x i64], align 8
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
  %s15.z6 = getelementptr i64, ptr %s15, i64 6
  store i64 0, ptr %s15.z6
  %s15.z7 = getelementptr i64, ptr %s15, i64 7
  store i64 0, ptr %s15.z7
  %s15.z8 = getelementptr i64, ptr %s15, i64 8
  store i64 0, ptr %s15.z8
  %s15.z9 = getelementptr i64, ptr %s15, i64 9
  store i64 0, ptr %s15.z9
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
  %v390 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v390, i64 0
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
  %v10 = getelementptr i64, ptr @"str.1", i64 0
  %v11 = add i64 0, 28
  %v12 = add i64 0, 0
  %v13 = getelementptr i64, ptr %s0, i64 0
  %v14 = ptrtoint ptr %v10 to i64
  %st6 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 1
  store i64 %v11, ptr %st7
  %st8 = getelementptr i64, ptr %v13, i64 2
  store i64 %v12, ptr %st8
  %v15 = getelementptr i64, ptr %s2, i64 0
  %v16.p = getelementptr i64, ptr %v13, i64 0
  %v16 = load i64, ptr %v16.p
  %st9 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st9
  %v17.p = getelementptr i64, ptr %v13, i64 1
  %v17 = load i64, ptr %v17.p
  %st10 = getelementptr i64, ptr %v15, i64 1
  store i64 %v17, ptr %st10
  %v18.p = getelementptr i64, ptr %v13, i64 2
  %v18 = load i64, ptr %v18.p
  %st11 = getelementptr i64, ptr %v15, i64 2
  store i64 %v18, ptr %st11
  %v19 = getelementptr i64, ptr %s3, i64 0
  %v20.p = getelementptr i64, ptr %v6, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v6, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v6, i64 2
  %v22 = load i64, ptr %v22.p
  call void @"std/io.ReadFile"(ptr %v19, i64 %v20, i64 %v21, i64 %v22)
  %v23 = add i64 0, 3
  %v24 = getelementptr i64, ptr %v19, i64 %v23
  %v25 = getelementptr i64, ptr %s0, i64 0
  %v26.p = getelementptr i64, ptr %v19, i64 0
  %v26 = load i64, ptr %v26.p
  %st12 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st12
  %v27.p = getelementptr i64, ptr %v19, i64 1
  %v27 = load i64, ptr %v27.p
  %st13 = getelementptr i64, ptr %v25, i64 1
  store i64 %v27, ptr %st13
  %v28.p = getelementptr i64, ptr %v19, i64 2
  %v28 = load i64, ptr %v28.p
  %st14 = getelementptr i64, ptr %v25, i64 2
  store i64 %v28, ptr %st14
  %v29 = getelementptr i64, ptr %s4, i64 0
  %v30.p = getelementptr i64, ptr %v24, i64 0
  %v30 = load i64, ptr %v30.p
  %st15 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st15
  %v31.p = getelementptr i64, ptr %v24, i64 1
  %v31 = load i64, ptr %v31.p
  %st16 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st16
  %v32.p = getelementptr i64, ptr %v24, i64 2
  %v32 = load i64, ptr %v32.p
  %st17 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st17
  %v33.p = getelementptr i64, ptr %v24, i64 3
  %v33 = load i64, ptr %v33.p
  %st18 = getelementptr i64, ptr %v29, i64 3
  store i64 %v33, ptr %st18
  %v34.p = getelementptr i64, ptr %v24, i64 4
  %v34 = load i64, ptr %v34.p
  %st19 = getelementptr i64, ptr %v29, i64 4
  store i64 %v34, ptr %st19
  %v35.p = getelementptr i64, ptr %v24, i64 5
  %v35 = load i64, ptr %v35.p
  %st20 = getelementptr i64, ptr %v29, i64 5
  store i64 %v35, ptr %st20
  %v36.p = getelementptr i64, ptr %v29, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 0, 0
  %v38.c = icmp ne i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b0 = icmp ne i64 %v38, 0
  br i1 %c.b0, label %b0.t22, label %b0.e23
b0.t22:
  br label %b1
b0.e23:
  br label %b2
b1:
  %v39 = add i64 0, 1
  %v40 = getelementptr i64, ptr %v29, i64 %v39
  %v41 = getelementptr i64, ptr %s5, i64 0
  %v42.p = getelementptr i64, ptr %v40, i64 0
  %v42 = load i64, ptr %v42.p
  %st23 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st23
  %v43.p = getelementptr i64, ptr %v40, i64 1
  %v43 = load i64, ptr %v43.p
  %st24 = getelementptr i64, ptr %v41, i64 1
  store i64 %v43, ptr %st24
  %v44.p = getelementptr i64, ptr %v40, i64 2
  %v44 = load i64, ptr %v44.p
  %st25 = getelementptr i64, ptr %v41, i64 2
  store i64 %v44, ptr %st25
  %v45.p = getelementptr i64, ptr %v40, i64 3
  %v45 = load i64, ptr %v45.p
  %st26 = getelementptr i64, ptr %v41, i64 3
  store i64 %v45, ptr %st26
  %v46.p = getelementptr i64, ptr %v40, i64 4
  %v46 = load i64, ptr %v46.p
  %st27 = getelementptr i64, ptr %v41, i64 4
  store i64 %v46, ptr %st27
  %v47 = add i64 0, 1
  %v391 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v391, i64 0
  store i64 %v0, ptr %st28
  ret i64 %v47
b2:
  br label %b3
b3:
  %v48 = phi ptr [ %v25, %b2 ]
  %v49 = getelementptr i64, ptr %s6, i64 0
  %v50.p = getelementptr i64, ptr %v48, i64 0
  %v50 = load i64, ptr %v50.p
  %st29 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st29
  %v51.p = getelementptr i64, ptr %v48, i64 1
  %v51 = load i64, ptr %v51.p
  %st30 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st30
  %v52.p = getelementptr i64, ptr %v48, i64 2
  %v52 = load i64, ptr %v52.p
  %st31 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st31
  %v53 = getelementptr i64, ptr %s7, i64 0
  %v54.p = getelementptr i64, ptr %v6, i64 0
  %v54 = load i64, ptr %v54.p
  %st32 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st32
  %v55.p = getelementptr i64, ptr %v6, i64 1
  %v55 = load i64, ptr %v55.p
  %st33 = getelementptr i64, ptr %v53, i64 1
  store i64 %v55, ptr %st33
  %v56.p = getelementptr i64, ptr %v6, i64 2
  %v56 = load i64, ptr %v56.p
  %st34 = getelementptr i64, ptr %v53, i64 2
  store i64 %v56, ptr %st34
  %v57 = getelementptr i64, ptr %s8, i64 0
  %v58.p = getelementptr i64, ptr %v15, i64 0
  %v58 = load i64, ptr %v58.p
  %st35 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st35
  %v59.p = getelementptr i64, ptr %v15, i64 1
  %v59 = load i64, ptr %v59.p
  %st36 = getelementptr i64, ptr %v57, i64 1
  store i64 %v59, ptr %st36
  %v60.p = getelementptr i64, ptr %v15, i64 2
  %v60 = load i64, ptr %v60.p
  %st37 = getelementptr i64, ptr %v57, i64 2
  store i64 %v60, ptr %st37
  %v392 = getelementptr i64, ptr @"rt.meta", i64 0
  %v61.p = getelementptr i64, ptr %v392, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 6
  %v63 = call ptr @"rt.region_alloc"(i64 %v61, i64 %v62)
  %v64.p = getelementptr i64, ptr %v53, i64 0
  %v64 = load i64, ptr %v64.p
  %st38 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st38
  %v65.p = getelementptr i64, ptr %v53, i64 1
  %v65 = load i64, ptr %v65.p
  %st39 = getelementptr i64, ptr %v63, i64 1
  store i64 %v65, ptr %st39
  %v66.p = getelementptr i64, ptr %v53, i64 2
  %v66 = load i64, ptr %v66.p
  %st40 = getelementptr i64, ptr %v63, i64 2
  store i64 %v66, ptr %st40
  %v67.p = getelementptr i64, ptr %v57, i64 0
  %v67 = load i64, ptr %v67.p
  %st41 = getelementptr i64, ptr %v63, i64 3
  store i64 %v67, ptr %st41
  %v68.p = getelementptr i64, ptr %v57, i64 1
  %v68 = load i64, ptr %v68.p
  %st42 = getelementptr i64, ptr %v63, i64 4
  store i64 %v68, ptr %st42
  %v69.p = getelementptr i64, ptr %v57, i64 2
  %v69 = load i64, ptr %v69.p
  %st43 = getelementptr i64, ptr %v63, i64 5
  store i64 %v69, ptr %st43
  %v70 = add i64 0, 2
  %v71 = getelementptr i64, ptr %s9, i64 0
  %v72 = ptrtoint ptr %v63 to i64
  %st44 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st44
  %st45 = getelementptr i64, ptr %v71, i64 1
  store i64 %v70, ptr %st45
  %st46 = getelementptr i64, ptr %v71, i64 2
  store i64 %v61, ptr %st46
  %v73 = getelementptr i64, ptr %s10, i64 0
  %v74.p = getelementptr i64, ptr %v71, i64 0
  %v74 = load i64, ptr %v74.p
  %st47 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st47
  %v75.p = getelementptr i64, ptr %v71, i64 1
  %v75 = load i64, ptr %v75.p
  %st48 = getelementptr i64, ptr %v73, i64 1
  store i64 %v75, ptr %st48
  %v76.p = getelementptr i64, ptr %v71, i64 2
  %v76 = load i64, ptr %v76.p
  %st49 = getelementptr i64, ptr %v73, i64 2
  store i64 %v76, ptr %st49
  %v77 = add i64 0, 0
  %v78 = add i64 0, 0
  %v393 = getelementptr i64, ptr @"rt.meta", i64 0
  %v79.p = getelementptr i64, ptr %v393, i64 0
  %v79 = load i64, ptr %v79.p
  %v80 = add i64 0, 2
  %v81 = call ptr @"rt.region_alloc"(i64 %v79, i64 %v80)
  %st50 = getelementptr i64, ptr %v81, i64 0
  store i64 %v77, ptr %st50
  %st51 = getelementptr i64, ptr %v81, i64 1
  store i64 %v78, ptr %st51
  %v82 = add i64 0, 2
  %v83 = getelementptr i64, ptr %s9, i64 0
  %v84 = ptrtoint ptr %v81 to i64
  %st52 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st52
  %st53 = getelementptr i64, ptr %v83, i64 1
  store i64 %v82, ptr %st53
  %st54 = getelementptr i64, ptr %v83, i64 2
  store i64 %v79, ptr %st54
  %v85 = getelementptr i64, ptr %s8, i64 0
  %v86.p = getelementptr i64, ptr %v83, i64 0
  %v86 = load i64, ptr %v86.p
  %st55 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st55
  %v87.p = getelementptr i64, ptr %v83, i64 1
  %v87 = load i64, ptr %v87.p
  %st56 = getelementptr i64, ptr %v85, i64 1
  store i64 %v87, ptr %st56
  %v88.p = getelementptr i64, ptr %v83, i64 2
  %v88 = load i64, ptr %v88.p
  %st57 = getelementptr i64, ptr %v85, i64 2
  store i64 %v88, ptr %st57
  %v89 = add i64 0, 0
  %v90 = add i64 0, 0
  %v394 = getelementptr i64, ptr @"rt.meta", i64 0
  %v91.p = getelementptr i64, ptr %v394, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = add i64 0, 2
  %v93 = call ptr @"rt.region_alloc"(i64 %v91, i64 %v92)
  %st58 = getelementptr i64, ptr %v93, i64 0
  store i64 %v89, ptr %st58
  %st59 = getelementptr i64, ptr %v93, i64 1
  store i64 %v90, ptr %st59
  %v94 = add i64 0, 2
  %v95 = getelementptr i64, ptr %s9, i64 0
  %v96 = ptrtoint ptr %v93 to i64
  %st60 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st60
  %st61 = getelementptr i64, ptr %v95, i64 1
  store i64 %v94, ptr %st61
  %st62 = getelementptr i64, ptr %v95, i64 2
  store i64 %v91, ptr %st62
  %v97 = getelementptr i64, ptr %s7, i64 0
  %v98.p = getelementptr i64, ptr %v95, i64 0
  %v98 = load i64, ptr %v98.p
  %st63 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st63
  %v99.p = getelementptr i64, ptr %v95, i64 1
  %v99 = load i64, ptr %v99.p
  %st64 = getelementptr i64, ptr %v97, i64 1
  store i64 %v99, ptr %st64
  %v100.p = getelementptr i64, ptr %v95, i64 2
  %v100 = load i64, ptr %v100.p
  %st65 = getelementptr i64, ptr %v97, i64 2
  store i64 %v100, ptr %st65
  %v101 = add i64 0, 0
  %v102 = getelementptr i64, ptr %s11, i64 0
  %st66 = getelementptr i64, ptr %v102, i64 0
  store i64 %v101, ptr %st66
  %v103 = add i64 0, 1
  %v104 = getelementptr i64, ptr %s12, i64 0
  %st67 = getelementptr i64, ptr %v104, i64 0
  store i64 %v103, ptr %st67
  %v395 = getelementptr i64, ptr @"rt.meta", i64 0
  %v105.p = getelementptr i64, ptr %v395, i64 0
  %v105 = load i64, ptr %v105.p
  br label %b4
b4:
  %v396 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v396, i64 0
  store i64 %v105, ptr %st68
  %v106.p = getelementptr i64, ptr %v104, i64 0
  %v106 = load i64, ptr %v106.p
  %c.b4 = icmp ne i64 %v106, 0
  br i1 %c.b4, label %b4.t70, label %b4.e71
b4.t70:
  br label %b5
b4.e71:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v397 = getelementptr i64, ptr @"rt.meta", i64 0
  %v107.p = getelementptr i64, ptr %v397, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 0, 1
  %v109 = add i64 %v0, %v108
  %v110 = add i64 0, 0
  %st71 = getelementptr i64, ptr %v104, i64 0
  store i64 %v110, ptr %st71
  %v398 = getelementptr i64, ptr @"rt.meta", i64 0
  %v111.p = getelementptr i64, ptr %v398, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 0, 0
  %v113 = add i64 0, 2
  %v114 = getelementptr i64, ptr %s13, i64 0
  %v399 = getelementptr i64, ptr @"rt.meta", i64 0
  %v115.p = getelementptr i64, ptr %v399, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = getelementptr i64, ptr %s14, i64 0
  %st72 = getelementptr i64, ptr %v116, i64 0
  store i64 %v112, ptr %st72
  %v400 = getelementptr i64, ptr @"rt.meta", i64 0
  %v117.p = getelementptr i64, ptr %v400, i64 0
  %v117 = load i64, ptr %v117.p
  br label %b9
b6:
  %v401 = getelementptr i64, ptr @"rt.meta", i64 0
  %st73 = getelementptr i64, ptr %v401, i64 0
  store i64 %v105, ptr %st73
  %v212.p = getelementptr i64, ptr %v102, i64 0
  %v212 = load i64, ptr %v212.p
  %v213 = add i64 0, 0
  %v214.p = getelementptr i64, ptr %v85, i64 1
  %v214 = load i64, ptr %v214.p
  %v215.c = icmp uge i64 %v213, %v214
  %v215 = zext i1 %v215.c to i64
  %c.b6 = icmp ne i64 %v215, 0
  br i1 %c.b6, label %b6.t75, label %b6.e76
b6.t75:
  br label %b29
b6.e76:
  br label %b30
b7:
  %v402 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v402, i64 0
  store i64 %v111, ptr %st76
  br label %b4
b8:
  br label %b7
b9:
  %v403 = getelementptr i64, ptr @"rt.meta", i64 0
  %st77 = getelementptr i64, ptr %v403, i64 0
  store i64 %v117, ptr %st77
  %v118.p = getelementptr i64, ptr %v116, i64 0
  %v118 = load i64, ptr %v118.p
  %v119.c = icmp slt i64 %v118, %v113
  %v119 = zext i1 %v119.c to i64
  %c.b9 = icmp ne i64 %v119, 0
  br i1 %c.b9, label %b9.t79, label %b9.e80
b9.t79:
  br label %b10
b9.e80:
  br label %b11
b10:
  call void @"rt.region_enter"()
  %v404 = getelementptr i64, ptr @"rt.meta", i64 0
  %v120.p = getelementptr i64, ptr %v404, i64 0
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v116, i64 0
  %v121 = load i64, ptr %v121.p
  %v405 = getelementptr i64, ptr @"rt.meta", i64 0
  %v122.p = getelementptr i64, ptr %v405, i64 0
  %v122 = load i64, ptr %v122.p
  %v123 = getelementptr i64, ptr %s15, i64 0
  %v124.p = getelementptr i64, ptr %v73, i64 1
  %v124 = load i64, ptr %v124.p
  %v125.c = icmp uge i64 %v121, %v124
  %v125 = zext i1 %v125.c to i64
  %c.b10 = icmp ne i64 %v125, 0
  br i1 %c.b10, label %b10.t81, label %b10.e82
b10.t81:
  br label %b13
b10.e82:
  br label %b14
b11:
  %v406 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v406, i64 0
  store i64 %v117, ptr %st82
  br label %b8
b12:
  %v407 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v407, i64 0
  store i64 %v122, ptr %st83
  %v209 = add i64 0, 1
  %v210.p = getelementptr i64, ptr %v116, i64 0
  %v210 = load i64, ptr %v210.p
  %v211 = add i64 %v210, %v209
  %st84 = getelementptr i64, ptr %v116, i64 0
  store i64 %v211, ptr %st84
  br label %b9
b13:
  %v126 = add i64 0, 0
  call void @"rt.panic"(i64 %v126)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v127.p = getelementptr i64, ptr %v73, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = inttoptr i64 %v127 to ptr
  %v129 = add i64 0, 3
  %v130 = mul i64 %v121, %v129
  %v131 = getelementptr i64, ptr %v128, i64 %v130
  %v132.p = getelementptr i64, ptr %v131, i64 0
  %v132 = load i64, ptr %v132.p
  %v133.p = getelementptr i64, ptr %v131, i64 1
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v131, i64 2
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v85, i64 1
  %v135 = load i64, ptr %v135.p
  %v136.c = icmp uge i64 %v121, %v135
  %v136 = zext i1 %v136.c to i64
  %c.b14 = icmp ne i64 %v136, 0
  br i1 %c.b14, label %b14.t86, label %b14.e87
b14.t86:
  br label %b15
b14.e87:
  br label %b16
b15:
  %v137 = add i64 0, 1
  call void @"rt.panic"(i64 %v137)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v138.p = getelementptr i64, ptr %v85, i64 0
  %v138 = load i64, ptr %v138.p
  %v139 = inttoptr i64 %v138 to ptr
  %v140 = add i64 0, 1
  %v141 = mul i64 %v121, %v140
  %v142 = getelementptr i64, ptr %v139, i64 %v141
  %v143.p = getelementptr i64, ptr %v142, i64 0
  %v143 = load i64, ptr %v143.p
  call void @"main.pull"(ptr %v123, i64 %v132, i64 %v133, i64 %v134, i64 %v143)
  %v144.p = getelementptr i64, ptr %v123, i64 3
  %v144 = load i64, ptr %v144.p
  %v145 = add i64 0, 4
  %v146 = getelementptr i64, ptr %v123, i64 %v145
  %v147 = getelementptr i64, ptr %s9, i64 0
  %v148.p = getelementptr i64, ptr %v123, i64 0
  %v148 = load i64, ptr %v148.p
  %st87 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st87
  %v149.p = getelementptr i64, ptr %v123, i64 1
  %v149 = load i64, ptr %v149.p
  %st88 = getelementptr i64, ptr %v147, i64 1
  store i64 %v149, ptr %st88
  %v150.p = getelementptr i64, ptr %v123, i64 2
  %v150 = load i64, ptr %v150.p
  %st89 = getelementptr i64, ptr %v147, i64 2
  store i64 %v150, ptr %st89
  %v151 = getelementptr i64, ptr %s16, i64 0
  %v152.p = getelementptr i64, ptr %v146, i64 0
  %v152 = load i64, ptr %v152.p
  %st90 = getelementptr i64, ptr %v151, i64 0
  store i64 %v152, ptr %st90
  %v153.p = getelementptr i64, ptr %v146, i64 1
  %v153 = load i64, ptr %v153.p
  %st91 = getelementptr i64, ptr %v151, i64 1
  store i64 %v153, ptr %st91
  %v154.p = getelementptr i64, ptr %v146, i64 2
  %v154 = load i64, ptr %v154.p
  %st92 = getelementptr i64, ptr %v151, i64 2
  store i64 %v154, ptr %st92
  %v155.p = getelementptr i64, ptr %v146, i64 3
  %v155 = load i64, ptr %v155.p
  %st93 = getelementptr i64, ptr %v151, i64 3
  store i64 %v155, ptr %st93
  %v156.p = getelementptr i64, ptr %v146, i64 4
  %v156 = load i64, ptr %v156.p
  %st94 = getelementptr i64, ptr %v151, i64 4
  store i64 %v156, ptr %st94
  %v157.p = getelementptr i64, ptr %v146, i64 5
  %v157 = load i64, ptr %v157.p
  %st95 = getelementptr i64, ptr %v151, i64 5
  store i64 %v157, ptr %st95
  %v158.p = getelementptr i64, ptr %v151, i64 0
  %v158 = load i64, ptr %v158.p
  %v159 = add i64 0, 0
  %v160.c = icmp ne i64 %v158, %v159
  %v160 = zext i1 %v160.c to i64
  %c.b16 = icmp ne i64 %v160, 0
  br i1 %c.b16, label %b16.t97, label %b16.e98
b16.t97:
  br label %b17
b16.e98:
  br label %b18
b17:
  %v161 = add i64 0, 1
  %v162 = getelementptr i64, ptr %v151, i64 %v161
  %v163 = getelementptr i64, ptr %s5, i64 0
  %v164.p = getelementptr i64, ptr %v162, i64 0
  %v164 = load i64, ptr %v164.p
  %st98 = getelementptr i64, ptr %v163, i64 0
  store i64 %v164, ptr %st98
  %v165.p = getelementptr i64, ptr %v162, i64 1
  %v165 = load i64, ptr %v165.p
  %st99 = getelementptr i64, ptr %v163, i64 1
  store i64 %v165, ptr %st99
  %v166.p = getelementptr i64, ptr %v162, i64 2
  %v166 = load i64, ptr %v166.p
  %st100 = getelementptr i64, ptr %v163, i64 2
  store i64 %v166, ptr %st100
  %v167.p = getelementptr i64, ptr %v162, i64 3
  %v167 = load i64, ptr %v167.p
  %st101 = getelementptr i64, ptr %v163, i64 3
  store i64 %v167, ptr %st101
  %v168.p = getelementptr i64, ptr %v162, i64 4
  %v168 = load i64, ptr %v168.p
  %st102 = getelementptr i64, ptr %v163, i64 4
  store i64 %v168, ptr %st102
  %v169 = add i64 0, 1
  %v408 = getelementptr i64, ptr @"rt.meta", i64 0
  %st103 = getelementptr i64, ptr %v408, i64 0
  store i64 %v0, ptr %st103
  ret i64 %v169
b18:
  br label %b19
b19:
  %v170.p = getelementptr i64, ptr %v147, i64 1
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 0, 0
  %v172.c = icmp sgt i64 %v170, %v171
  %v172 = zext i1 %v172.c to i64
  %c.b19 = icmp ne i64 %v172, 0
  br i1 %c.b19, label %b19.t105, label %b19.e106
b19.t105:
  br label %b20
b19.e106:
  br label %b21
b20:
  %v173 = add i64 0, 1
  %v174 = add i64 %v0, %v173
  %v175 = add i64 0, 1
  %st106 = getelementptr i64, ptr %v104, i64 0
  store i64 %v175, ptr %st106
  %v176.p = getelementptr i64, ptr %v85, i64 1
  %v176 = load i64, ptr %v176.p
  %v177.c = icmp uge i64 %v121, %v176
  %v177 = zext i1 %v177.c to i64
  %c.b20 = icmp ne i64 %v177, 0
  br i1 %c.b20, label %b20.t108, label %b20.e109
b20.t108:
  br label %b22
b20.e109:
  br label %b23
b21:
  br label %b28
b22:
  %v178 = add i64 0, 2
  call void @"rt.panic"(i64 %v178)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v179.p = getelementptr i64, ptr %v85, i64 0
  %v179 = load i64, ptr %v179.p
  %v180 = inttoptr i64 %v179 to ptr
  %v181 = add i64 0, 1
  %v182 = mul i64 %v121, %v181
  %v183 = getelementptr i64, ptr %v180, i64 %v182
  %st109 = getelementptr i64, ptr %v183, i64 0
  store i64 %v144, ptr %st109
  %v184.p = getelementptr i64, ptr %v97, i64 1
  %v184 = load i64, ptr %v184.p
  %v185.c = icmp uge i64 %v121, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b23 = icmp ne i64 %v185, 0
  br i1 %c.b23, label %b23.t111, label %b23.e112
b23.t111:
  br label %b24
b23.e112:
  br label %b25
b24:
  %v186 = add i64 0, 3
  call void @"rt.panic"(i64 %v186)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  %v187.p = getelementptr i64, ptr %v97, i64 0
  %v187 = load i64, ptr %v187.p
  %v188 = inttoptr i64 %v187 to ptr
  %v189 = add i64 0, 1
  %v190 = mul i64 %v121, %v189
  %v191 = getelementptr i64, ptr %v188, i64 %v190
  %v192.p = getelementptr i64, ptr %v191, i64 0
  %v192 = load i64, ptr %v192.p
  %v193.p = getelementptr i64, ptr %v147, i64 0
  %v193 = load i64, ptr %v193.p
  %v194.p = getelementptr i64, ptr %v147, i64 1
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v147, i64 2
  %v195 = load i64, ptr %v195.p
  %v196 = call i64 @"main.sum"(i64 %v193, i64 %v194, i64 %v195)
  %v197 = add i64 %v192, %v196
  %v198.p = getelementptr i64, ptr %v97, i64 1
  %v198 = load i64, ptr %v198.p
  %v199.c = icmp uge i64 %v121, %v198
  %v199 = zext i1 %v199.c to i64
  %c.b25 = icmp ne i64 %v199, 0
  br i1 %c.b25, label %b25.t113, label %b25.e114
b25.t113:
  br label %b26
b25.e114:
  br label %b27
b26:
  %v200 = add i64 0, 4
  call void @"rt.panic"(i64 %v200)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v201.p = getelementptr i64, ptr %v97, i64 0
  %v201 = load i64, ptr %v201.p
  %v202 = inttoptr i64 %v201 to ptr
  %v203 = add i64 0, 1
  %v204 = mul i64 %v121, %v203
  %v205 = getelementptr i64, ptr %v202, i64 %v204
  %st114 = getelementptr i64, ptr %v205, i64 0
  store i64 %v197, ptr %st114
  %v206 = add i64 0, 1
  %v207.p = getelementptr i64, ptr %v102, i64 0
  %v207 = load i64, ptr %v207.p
  %v208 = add i64 %v207, %v206
  %st115 = getelementptr i64, ptr %v102, i64 0
  store i64 %v208, ptr %st115
  br label %b28
b28:
  br label %b12
b29:
  %v216 = add i64 0, 5
  call void @"rt.panic"(i64 %v216)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v217.p = getelementptr i64, ptr %v85, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = inttoptr i64 %v217 to ptr
  %v219 = add i64 0, 1
  %v220 = mul i64 %v213, %v219
  %v221 = getelementptr i64, ptr %v218, i64 %v220
  %v222.p = getelementptr i64, ptr %v221, i64 0
  %v222 = load i64, ptr %v222.p
  %v223 = add i64 0, 1
  %v224.p = getelementptr i64, ptr %v85, i64 1
  %v224 = load i64, ptr %v224.p
  %v225.c = icmp uge i64 %v223, %v224
  %v225 = zext i1 %v225.c to i64
  %c.b30 = icmp ne i64 %v225, 0
  br i1 %c.b30, label %b30.t117, label %b30.e118
b30.t117:
  br label %b31
b30.e118:
  br label %b32
b31:
  %v226 = add i64 0, 6
  call void @"rt.panic"(i64 %v226)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v227.p = getelementptr i64, ptr %v85, i64 0
  %v227 = load i64, ptr %v227.p
  %v228 = inttoptr i64 %v227 to ptr
  %v229 = add i64 0, 1
  %v230 = mul i64 %v223, %v229
  %v231 = getelementptr i64, ptr %v228, i64 %v230
  %v232.p = getelementptr i64, ptr %v231, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = getelementptr i64, ptr @"str.2", i64 0
  %v234 = add i64 0, 7
  %v235 = add i64 0, 0
  %v236 = getelementptr i64, ptr %s9, i64 0
  %v237 = ptrtoint ptr %v233 to i64
  %st118 = getelementptr i64, ptr %v236, i64 0
  store i64 %v237, ptr %st118
  %st119 = getelementptr i64, ptr %v236, i64 1
  store i64 %v234, ptr %st119
  %st120 = getelementptr i64, ptr %v236, i64 2
  store i64 %v235, ptr %st120
  %v238 = getelementptr i64, ptr %s17, i64 0
  call void @"std/convert.FormatInt"(ptr %v238, i64 %v212)
  %v239.p = getelementptr i64, ptr %v236, i64 1
  %v239 = load i64, ptr %v239.p
  %v240.p = getelementptr i64, ptr %v238, i64 1
  %v240 = load i64, ptr %v240.p
  %v241 = add i64 %v239, %v240
  %v409 = getelementptr i64, ptr @"rt.meta", i64 0
  %v242.p = getelementptr i64, ptr %v409, i64 0
  %v242 = load i64, ptr %v242.p
  %v243.p = getelementptr i64, ptr %v236, i64 0
  %v243 = load i64, ptr %v243.p
  %v244.p = getelementptr i64, ptr %v236, i64 1
  %v244 = load i64, ptr %v244.p
  %v245.p = getelementptr i64, ptr %v236, i64 2
  %v245 = load i64, ptr %v245.p
  %v246 = call ptr @"rt.cat8"(i64 %v243, i64 %v244, i64 %v245, i64 %v242, i64 %v240)
  %v247 = getelementptr i8, ptr %v246, i64 %v239
  %v248.p = getelementptr i64, ptr %v238, i64 0
  %v248 = load i64, ptr %v248.p
  %v249 = inttoptr i64 %v248 to ptr
  call void @"rt.copy8"(ptr %v247, ptr %v249, i64 %v240)
  %v250 = getelementptr i64, ptr %s18, i64 0
  %v251 = ptrtoint ptr %v246 to i64
  %st121 = getelementptr i64, ptr %v250, i64 0
  store i64 %v251, ptr %st121
  %st122 = getelementptr i64, ptr %v250, i64 1
  store i64 %v241, ptr %st122
  %st123 = getelementptr i64, ptr %v250, i64 2
  store i64 %v242, ptr %st123
  %v252 = getelementptr i64, ptr @"str.3", i64 0
  %v253 = add i64 0, 8
  %v254 = add i64 0, 0
  %v255 = getelementptr i64, ptr %s19, i64 0
  %v256 = ptrtoint ptr %v252 to i64
  %st124 = getelementptr i64, ptr %v255, i64 0
  store i64 %v256, ptr %st124
  %st125 = getelementptr i64, ptr %v255, i64 1
  store i64 %v253, ptr %st125
  %st126 = getelementptr i64, ptr %v255, i64 2
  store i64 %v254, ptr %st126
  %v257.p = getelementptr i64, ptr %v250, i64 1
  %v257 = load i64, ptr %v257.p
  %v258.p = getelementptr i64, ptr %v255, i64 1
  %v258 = load i64, ptr %v258.p
  %v259 = add i64 %v257, %v258
  %v410 = getelementptr i64, ptr @"rt.meta", i64 0
  %v260.p = getelementptr i64, ptr %v410, i64 0
  %v260 = load i64, ptr %v260.p
  %v261.p = getelementptr i64, ptr %v250, i64 0
  %v261 = load i64, ptr %v261.p
  %v262.p = getelementptr i64, ptr %v250, i64 1
  %v262 = load i64, ptr %v262.p
  %v263.p = getelementptr i64, ptr %v250, i64 2
  %v263 = load i64, ptr %v263.p
  %v264 = call ptr @"rt.cat8"(i64 %v261, i64 %v262, i64 %v263, i64 %v260, i64 %v258)
  %v265 = getelementptr i8, ptr %v264, i64 %v257
  %v266.p = getelementptr i64, ptr %v255, i64 0
  %v266 = load i64, ptr %v266.p
  %v267 = inttoptr i64 %v266 to ptr
  call void @"rt.copy8"(ptr %v265, ptr %v267, i64 %v258)
  %v268 = getelementptr i64, ptr %s20, i64 0
  %v269 = ptrtoint ptr %v264 to i64
  %st127 = getelementptr i64, ptr %v268, i64 0
  store i64 %v269, ptr %st127
  %st128 = getelementptr i64, ptr %v268, i64 1
  store i64 %v259, ptr %st128
  %st129 = getelementptr i64, ptr %v268, i64 2
  store i64 %v260, ptr %st129
  %v270 = getelementptr i64, ptr %s21, i64 0
  call void @"std/convert.FormatInt"(ptr %v270, i64 %v222)
  %v271.p = getelementptr i64, ptr %v268, i64 1
  %v271 = load i64, ptr %v271.p
  %v272.p = getelementptr i64, ptr %v270, i64 1
  %v272 = load i64, ptr %v272.p
  %v273 = add i64 %v271, %v272
  %v411 = getelementptr i64, ptr @"rt.meta", i64 0
  %v274.p = getelementptr i64, ptr %v411, i64 0
  %v274 = load i64, ptr %v274.p
  %v275.p = getelementptr i64, ptr %v268, i64 0
  %v275 = load i64, ptr %v275.p
  %v276.p = getelementptr i64, ptr %v268, i64 1
  %v276 = load i64, ptr %v276.p
  %v277.p = getelementptr i64, ptr %v268, i64 2
  %v277 = load i64, ptr %v277.p
  %v278 = call ptr @"rt.cat8"(i64 %v275, i64 %v276, i64 %v277, i64 %v274, i64 %v272)
  %v279 = getelementptr i8, ptr %v278, i64 %v271
  %v280.p = getelementptr i64, ptr %v270, i64 0
  %v280 = load i64, ptr %v280.p
  %v281 = inttoptr i64 %v280 to ptr
  call void @"rt.copy8"(ptr %v279, ptr %v281, i64 %v272)
  %v282 = getelementptr i64, ptr %s22, i64 0
  %v283 = ptrtoint ptr %v278 to i64
  %st130 = getelementptr i64, ptr %v282, i64 0
  store i64 %v283, ptr %st130
  %st131 = getelementptr i64, ptr %v282, i64 1
  store i64 %v273, ptr %st131
  %st132 = getelementptr i64, ptr %v282, i64 2
  store i64 %v274, ptr %st132
  %v284 = getelementptr i64, ptr @"str.4", i64 0
  %v285 = add i64 0, 3
  %v286 = add i64 0, 0
  %v287 = getelementptr i64, ptr %s23, i64 0
  %v288 = ptrtoint ptr %v284 to i64
  %st133 = getelementptr i64, ptr %v287, i64 0
  store i64 %v288, ptr %st133
  %st134 = getelementptr i64, ptr %v287, i64 1
  store i64 %v285, ptr %st134
  %st135 = getelementptr i64, ptr %v287, i64 2
  store i64 %v286, ptr %st135
  %v289.p = getelementptr i64, ptr %v282, i64 1
  %v289 = load i64, ptr %v289.p
  %v290.p = getelementptr i64, ptr %v287, i64 1
  %v290 = load i64, ptr %v290.p
  %v291 = add i64 %v289, %v290
  %v412 = getelementptr i64, ptr @"rt.meta", i64 0
  %v292.p = getelementptr i64, ptr %v412, i64 0
  %v292 = load i64, ptr %v292.p
  %v293.p = getelementptr i64, ptr %v282, i64 0
  %v293 = load i64, ptr %v293.p
  %v294.p = getelementptr i64, ptr %v282, i64 1
  %v294 = load i64, ptr %v294.p
  %v295.p = getelementptr i64, ptr %v282, i64 2
  %v295 = load i64, ptr %v295.p
  %v296 = call ptr @"rt.cat8"(i64 %v293, i64 %v294, i64 %v295, i64 %v292, i64 %v290)
  %v297 = getelementptr i8, ptr %v296, i64 %v289
  %v298.p = getelementptr i64, ptr %v287, i64 0
  %v298 = load i64, ptr %v298.p
  %v299 = inttoptr i64 %v298 to ptr
  call void @"rt.copy8"(ptr %v297, ptr %v299, i64 %v290)
  %v300 = getelementptr i64, ptr %s24, i64 0
  %v301 = ptrtoint ptr %v296 to i64
  %st136 = getelementptr i64, ptr %v300, i64 0
  store i64 %v301, ptr %st136
  %st137 = getelementptr i64, ptr %v300, i64 1
  store i64 %v291, ptr %st137
  %st138 = getelementptr i64, ptr %v300, i64 2
  store i64 %v292, ptr %st138
  %v302 = getelementptr i64, ptr %s25, i64 0
  call void @"std/convert.FormatInt"(ptr %v302, i64 %v232)
  %v303.p = getelementptr i64, ptr %v300, i64 1
  %v303 = load i64, ptr %v303.p
  %v304.p = getelementptr i64, ptr %v302, i64 1
  %v304 = load i64, ptr %v304.p
  %v305 = add i64 %v303, %v304
  %v413 = getelementptr i64, ptr @"rt.meta", i64 0
  %v306.p = getelementptr i64, ptr %v413, i64 0
  %v306 = load i64, ptr %v306.p
  %v307.p = getelementptr i64, ptr %v300, i64 0
  %v307 = load i64, ptr %v307.p
  %v308.p = getelementptr i64, ptr %v300, i64 1
  %v308 = load i64, ptr %v308.p
  %v309.p = getelementptr i64, ptr %v300, i64 2
  %v309 = load i64, ptr %v309.p
  %v310 = call ptr @"rt.cat8"(i64 %v307, i64 %v308, i64 %v309, i64 %v306, i64 %v304)
  %v311 = getelementptr i8, ptr %v310, i64 %v303
  %v312.p = getelementptr i64, ptr %v302, i64 0
  %v312 = load i64, ptr %v312.p
  %v313 = inttoptr i64 %v312 to ptr
  call void @"rt.copy8"(ptr %v311, ptr %v313, i64 %v304)
  %v314 = getelementptr i64, ptr %s26, i64 0
  %v315 = ptrtoint ptr %v310 to i64
  %st139 = getelementptr i64, ptr %v314, i64 0
  store i64 %v315, ptr %st139
  %st140 = getelementptr i64, ptr %v314, i64 1
  store i64 %v305, ptr %st140
  %st141 = getelementptr i64, ptr %v314, i64 2
  store i64 %v306, ptr %st141
  %v316 = getelementptr i64, ptr @"str.5", i64 0
  %v317 = add i64 0, 6
  %v318 = add i64 0, 0
  %v319 = getelementptr i64, ptr %s27, i64 0
  %v320 = ptrtoint ptr %v316 to i64
  %st142 = getelementptr i64, ptr %v319, i64 0
  store i64 %v320, ptr %st142
  %st143 = getelementptr i64, ptr %v319, i64 1
  store i64 %v317, ptr %st143
  %st144 = getelementptr i64, ptr %v319, i64 2
  store i64 %v318, ptr %st144
  %v321.p = getelementptr i64, ptr %v314, i64 1
  %v321 = load i64, ptr %v321.p
  %v322.p = getelementptr i64, ptr %v319, i64 1
  %v322 = load i64, ptr %v322.p
  %v323 = add i64 %v321, %v322
  %v414 = getelementptr i64, ptr @"rt.meta", i64 0
  %v324.p = getelementptr i64, ptr %v414, i64 0
  %v324 = load i64, ptr %v324.p
  %v325.p = getelementptr i64, ptr %v314, i64 0
  %v325 = load i64, ptr %v325.p
  %v326.p = getelementptr i64, ptr %v314, i64 1
  %v326 = load i64, ptr %v326.p
  %v327.p = getelementptr i64, ptr %v314, i64 2
  %v327 = load i64, ptr %v327.p
  %v328 = call ptr @"rt.cat8"(i64 %v325, i64 %v326, i64 %v327, i64 %v324, i64 %v322)
  %v329 = getelementptr i8, ptr %v328, i64 %v321
  %v330.p = getelementptr i64, ptr %v319, i64 0
  %v330 = load i64, ptr %v330.p
  %v331 = inttoptr i64 %v330 to ptr
  call void @"rt.copy8"(ptr %v329, ptr %v331, i64 %v322)
  %v332 = getelementptr i64, ptr %s28, i64 0
  %v333 = ptrtoint ptr %v328 to i64
  %st145 = getelementptr i64, ptr %v332, i64 0
  store i64 %v333, ptr %st145
  %st146 = getelementptr i64, ptr %v332, i64 1
  store i64 %v323, ptr %st146
  %st147 = getelementptr i64, ptr %v332, i64 2
  store i64 %v324, ptr %st147
  call void @"rt.print_str"(ptr %v332)
  %v334 = add i64 0, 10
  call void @"rt.print_char"(i64 %v334)
  %v335 = add i64 0, 0
  %v336.p = getelementptr i64, ptr %v97, i64 1
  %v336 = load i64, ptr %v336.p
  %v337.c = icmp uge i64 %v335, %v336
  %v337 = zext i1 %v337.c to i64
  %c.b32 = icmp ne i64 %v337, 0
  br i1 %c.b32, label %b32.t149, label %b32.e150
b32.t149:
  br label %b33
b32.e150:
  br label %b34
b33:
  %v338 = add i64 0, 7
  call void @"rt.panic"(i64 %v338)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b34:
  %v339.p = getelementptr i64, ptr %v97, i64 0
  %v339 = load i64, ptr %v339.p
  %v340 = inttoptr i64 %v339 to ptr
  %v341 = add i64 0, 1
  %v342 = mul i64 %v335, %v341
  %v343 = getelementptr i64, ptr %v340, i64 %v342
  %v344.p = getelementptr i64, ptr %v343, i64 0
  %v344 = load i64, ptr %v344.p
  %v345.p = getelementptr i64, ptr %v49, i64 0
  %v345 = load i64, ptr %v345.p
  %v346.p = getelementptr i64, ptr %v49, i64 1
  %v346 = load i64, ptr %v346.p
  %v347.p = getelementptr i64, ptr %v49, i64 2
  %v347 = load i64, ptr %v347.p
  %v348 = call i64 @"main.sum"(i64 %v345, i64 %v346, i64 %v347)
  %v349.c = icmp eq i64 %v344, %v348
  %v349 = zext i1 %v349.c to i64
  %v350 = getelementptr i64, ptr @"str.6", i64 0
  %v351 = add i64 0, 22
  %v352 = add i64 0, 0
  %v353 = getelementptr i64, ptr %s28, i64 0
  %v354 = ptrtoint ptr %v350 to i64
  %st150 = getelementptr i64, ptr %v353, i64 0
  store i64 %v354, ptr %st150
  %st151 = getelementptr i64, ptr %v353, i64 1
  store i64 %v351, ptr %st151
  %st152 = getelementptr i64, ptr %v353, i64 2
  store i64 %v352, ptr %st152
  %c.b34 = icmp ne i64 %v349, 0
  br i1 %c.b34, label %b34.t154, label %b34.e155
b34.t154:
  br label %b35
b34.e155:
  br label %b36
b35:
  %v355 = getelementptr i64, ptr @"str.7", i64 0
  %v356 = add i64 0, 4
  %v357 = add i64 0, 0
  %v358 = getelementptr i64, ptr %s27, i64 0
  %v359 = ptrtoint ptr %v355 to i64
  %st155 = getelementptr i64, ptr %v358, i64 0
  store i64 %v359, ptr %st155
  %st156 = getelementptr i64, ptr %v358, i64 1
  store i64 %v356, ptr %st156
  %st157 = getelementptr i64, ptr %v358, i64 2
  store i64 %v357, ptr %st157
  br label %b37
b36:
  %v360 = getelementptr i64, ptr @"str.8", i64 0
  %v361 = add i64 0, 5
  %v362 = add i64 0, 0
  %v363 = getelementptr i64, ptr %s26, i64 0
  %v364 = ptrtoint ptr %v360 to i64
  %st158 = getelementptr i64, ptr %v363, i64 0
  store i64 %v364, ptr %st158
  %st159 = getelementptr i64, ptr %v363, i64 1
  store i64 %v361, ptr %st159
  %st160 = getelementptr i64, ptr %v363, i64 2
  store i64 %v362, ptr %st160
  br label %b37
b37:
  %v365 = phi ptr [ %v358, %b35 ], [ %v363, %b36 ]
  %v366.p = getelementptr i64, ptr %v353, i64 1
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v365, i64 1
  %v367 = load i64, ptr %v367.p
  %v368 = add i64 %v366, %v367
  %v415 = getelementptr i64, ptr @"rt.meta", i64 0
  %v369.p = getelementptr i64, ptr %v415, i64 0
  %v369 = load i64, ptr %v369.p
  %v370.p = getelementptr i64, ptr %v353, i64 0
  %v370 = load i64, ptr %v370.p
  %v371.p = getelementptr i64, ptr %v353, i64 1
  %v371 = load i64, ptr %v371.p
  %v372.p = getelementptr i64, ptr %v353, i64 2
  %v372 = load i64, ptr %v372.p
  %v373 = call ptr @"rt.cat8"(i64 %v370, i64 %v371, i64 %v372, i64 %v369, i64 %v367)
  %v374 = getelementptr i8, ptr %v373, i64 %v366
  %v375.p = getelementptr i64, ptr %v365, i64 0
  %v375 = load i64, ptr %v375.p
  %v376 = inttoptr i64 %v375 to ptr
  call void @"rt.copy8"(ptr %v374, ptr %v376, i64 %v367)
  %v377 = getelementptr i64, ptr %s24, i64 0
  %v378 = ptrtoint ptr %v373 to i64
  %st161 = getelementptr i64, ptr %v377, i64 0
  store i64 %v378, ptr %st161
  %st162 = getelementptr i64, ptr %v377, i64 1
  store i64 %v368, ptr %st162
  %st163 = getelementptr i64, ptr %v377, i64 2
  store i64 %v369, ptr %st163
  call void @"rt.print_str"(ptr %v377)
  %v379 = add i64 0, 10
  call void @"rt.print_char"(i64 %v379)
  %v380 = getelementptr i64, ptr %s29, i64 0
  %v381.p = getelementptr i64, ptr %v6, i64 0
  %v381 = load i64, ptr %v381.p
  %v382.p = getelementptr i64, ptr %v6, i64 1
  %v382 = load i64, ptr %v382.p
  %v383.p = getelementptr i64, ptr %v6, i64 2
  %v383 = load i64, ptr %v383.p
  %v384.p = getelementptr i64, ptr %v49, i64 1
  %v384 = load i64, ptr %v384.p
  call void @"main.position"(ptr %v380, i64 %v381, i64 %v382, i64 %v383, i64 %v384)
  %v385.p = getelementptr i64, ptr %v380, i64 0
  %v385 = load i64, ptr %v385.p
  %v386 = add i64 0, 0
  %v387.c = icmp ne i64 %v385, %v386
  %v387 = zext i1 %v387.c to i64
  %c.b37 = icmp ne i64 %v387, 0
  br i1 %c.b37, label %b37.t165, label %b37.e166
b37.t165:
  br label %b38
b37.e166:
  br label %b39
b38:
  %v388 = add i64 0, 1
  %v416 = getelementptr i64, ptr @"rt.meta", i64 0
  %st166 = getelementptr i64, ptr %v416, i64 0
  store i64 %v0, ptr %st166
  ret i64 %v388
b39:
  br label %b40
b40:
  %v389 = add i64 0, 0
  %v417 = getelementptr i64, ptr @"rt.meta", i64 0
  %st167 = getelementptr i64, ptr %v417, i64 0
  store i64 %v0, ptr %st167
  ret i64 %v389
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
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v97, i64 0
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
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v98, i64 0
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
  %v17 = add i64 0, 3
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
  %v99 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v42, i64 %v99, i64 %v5)
  br label %b4
b4:
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v100, i64 0
  store i64 %v5, ptr %st33
  ret void
b5:
  %v43 = getelementptr i64, ptr %s1, i64 0
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %v44.p = getelementptr i64, ptr %v101, i64 0
  %v44 = load i64, ptr %v44.p
  call void @"rt.read_file"(ptr %v4, ptr %v43, i64 %v44)
  %v45 = getelementptr i64, ptr %s5, i64 0
  %v46.p = getelementptr i64, ptr %v43, i64 0
  %v46 = load i64, ptr %v46.p
  %st34 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st34
  %v47.p = getelementptr i64, ptr %v43, i64 1
  %v47 = load i64, ptr %v47.p
  %st35 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st35
  %v48.p = getelementptr i64, ptr %v43, i64 2
  %v48 = load i64, ptr %v48.p
  %st36 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st36
  %v49 = getelementptr i64, ptr @"rt.meta", i64 0
  %v50.p = getelementptr i64, ptr %v49, i64 1027
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 0
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b5 = icmp ne i64 %v52, 0
  br i1 %c.b5, label %b5.t38, label %b5.e39
b5.t38:
  br label %b6
b5.e39:
  br label %b7
b6:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v102, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 0
  %v55 = call ptr @"rt.region_alloc8"(i64 %v53, i64 %v54)
  %v56 = add i64 0, 0
  %v57 = getelementptr i64, ptr %s1, i64 0
  %v58 = ptrtoint ptr %v55 to i64
  %st39 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st39
  %st40 = getelementptr i64, ptr %v57, i64 1
  store i64 %v56, ptr %st40
  %st41 = getelementptr i64, ptr %v57, i64 2
  store i64 %v53, ptr %st41
  %v59 = getelementptr i64, ptr %s6, i64 0
  call void @"std/io.errOf"(ptr %v59, i64 %v50)
  %v60 = getelementptr i64, ptr %s4, i64 0
  %v61 = add i64 0, 1
  %st42 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st42
  %v62.p = getelementptr i64, ptr %v59, i64 0
  %v62 = load i64, ptr %v62.p
  %st43 = getelementptr i64, ptr %v60, i64 1
  store i64 %v62, ptr %st43
  %v63.p = getelementptr i64, ptr %v59, i64 1
  %v63 = load i64, ptr %v63.p
  %st44 = getelementptr i64, ptr %v60, i64 2
  store i64 %v63, ptr %st44
  %v64.p = getelementptr i64, ptr %v59, i64 2
  %v64 = load i64, ptr %v64.p
  %st45 = getelementptr i64, ptr %v60, i64 3
  store i64 %v64, ptr %st45
  %v65.p = getelementptr i64, ptr %v59, i64 3
  %v65 = load i64, ptr %v65.p
  %st46 = getelementptr i64, ptr %v60, i64 4
  store i64 %v65, ptr %st46
  %v66.p = getelementptr i64, ptr %v59, i64 4
  %v66 = load i64, ptr %v66.p
  %st47 = getelementptr i64, ptr %v60, i64 5
  store i64 %v66, ptr %st47
  %v67.p = getelementptr i64, ptr %v57, i64 0
  %v67 = load i64, ptr %v67.p
  %st48 = getelementptr i64, ptr %v0, i64 0
  store i64 %v67, ptr %st48
  %v68.p = getelementptr i64, ptr %v57, i64 1
  %v68 = load i64, ptr %v68.p
  %st49 = getelementptr i64, ptr %v0, i64 1
  store i64 %v68, ptr %st49
  %v69.p = getelementptr i64, ptr %v57, i64 2
  %v69 = load i64, ptr %v69.p
  %st50 = getelementptr i64, ptr %v0, i64 2
  store i64 %v69, ptr %st50
  %v70.p = getelementptr i64, ptr %v60, i64 0
  %v70 = load i64, ptr %v70.p
  %st51 = getelementptr i64, ptr %v0, i64 3
  store i64 %v70, ptr %st51
  %v71.p = getelementptr i64, ptr %v60, i64 1
  %v71 = load i64, ptr %v71.p
  %st52 = getelementptr i64, ptr %v0, i64 4
  store i64 %v71, ptr %st52
  %v72.p = getelementptr i64, ptr %v60, i64 2
  %v72 = load i64, ptr %v72.p
  %st53 = getelementptr i64, ptr %v0, i64 5
  store i64 %v72, ptr %st53
  %v73.p = getelementptr i64, ptr %v60, i64 3
  %v73 = load i64, ptr %v73.p
  %st54 = getelementptr i64, ptr %v0, i64 6
  store i64 %v73, ptr %st54
  %v74.p = getelementptr i64, ptr %v60, i64 4
  %v74 = load i64, ptr %v74.p
  %st55 = getelementptr i64, ptr %v0, i64 7
  store i64 %v74, ptr %st55
  %v75.p = getelementptr i64, ptr %v60, i64 5
  %v75 = load i64, ptr %v75.p
  %st56 = getelementptr i64, ptr %v0, i64 8
  store i64 %v75, ptr %st56
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v76.p = getelementptr i64, ptr %v0, i64 3
  %v76 = load i64, ptr %v76.p
  %v77 = add i64 0, 0
  %v78.c = icmp ne i64 %v76, %v77
  %v78 = zext i1 %v78.c to i64
  %c.b6 = icmp ne i64 %v78, 0
  br i1 %c.b6, label %b6.t58, label %b6.e59
b6.t58:
  br label %b8
b6.e59:
  br label %b9
b7:
  br label %b10
b8:
  %v79 = add i64 0, 6
  %v80 = getelementptr i64, ptr %v0, i64 %v79
  %v103 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v80, i64 %v103, i64 %v5)
  br label %b9
b9:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v104, i64 0
  store i64 %v5, ptr %st59
  ret void
b10:
  %v81 = getelementptr i64, ptr %s4, i64 0
  %v82 = add i64 0, 0
  %st60 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st60
  %v83.p = getelementptr i64, ptr %v45, i64 0
  %v83 = load i64, ptr %v83.p
  %st61 = getelementptr i64, ptr %v0, i64 0
  store i64 %v83, ptr %st61
  %v84.p = getelementptr i64, ptr %v45, i64 1
  %v84 = load i64, ptr %v84.p
  %st62 = getelementptr i64, ptr %v0, i64 1
  store i64 %v84, ptr %st62
  %v85.p = getelementptr i64, ptr %v45, i64 2
  %v85 = load i64, ptr %v85.p
  %st63 = getelementptr i64, ptr %v0, i64 2
  store i64 %v85, ptr %st63
  %v86.p = getelementptr i64, ptr %v81, i64 0
  %v86 = load i64, ptr %v86.p
  %st64 = getelementptr i64, ptr %v0, i64 3
  store i64 %v86, ptr %st64
  %v87.p = getelementptr i64, ptr %v81, i64 1
  %v87 = load i64, ptr %v87.p
  %st65 = getelementptr i64, ptr %v0, i64 4
  store i64 %v87, ptr %st65
  %v88.p = getelementptr i64, ptr %v81, i64 2
  %v88 = load i64, ptr %v88.p
  %st66 = getelementptr i64, ptr %v0, i64 5
  store i64 %v88, ptr %st66
  %v89.p = getelementptr i64, ptr %v81, i64 3
  %v89 = load i64, ptr %v89.p
  %st67 = getelementptr i64, ptr %v0, i64 6
  store i64 %v89, ptr %st67
  %v90.p = getelementptr i64, ptr %v81, i64 4
  %v90 = load i64, ptr %v90.p
  %st68 = getelementptr i64, ptr %v0, i64 7
  store i64 %v90, ptr %st68
  %v91.p = getelementptr i64, ptr %v81, i64 5
  %v91 = load i64, ptr %v91.p
  %st69 = getelementptr i64, ptr %v0, i64 8
  store i64 %v91, ptr %st69
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v92.p = getelementptr i64, ptr %v0, i64 3
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 0
  %v94.c = icmp ne i64 %v92, %v93
  %v94 = zext i1 %v94.c to i64
  %c.b10 = icmp ne i64 %v94, 0
  br i1 %c.b10, label %b10.t71, label %b10.e72
b10.t71:
  br label %b11
b10.e72:
  br label %b12
b11:
  %v95 = add i64 0, 6
  %v96 = getelementptr i64, ptr %v0, i64 %v95
  %v105 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v96, i64 %v105, i64 %v5)
  br label %b12
b12:
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st72 = getelementptr i64, ptr %v106, i64 0
  store i64 %v5, ptr %st72
  ret void
}

define internal void @"main.pull"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s7 = alloca [2 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
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
  %s10 = alloca [1 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
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
  %s19 = alloca [3 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s19.z1 = getelementptr i64, ptr %s19, i64 1
  store i64 0, ptr %s19.z1
  %s19.z2 = getelementptr i64, ptr %s19, i64 2
  store i64 0, ptr %s19.z2
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v255 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v255, i64 0
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
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v16, ptr %st7
  %v256 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v256, i64 0
  %v17 = load i64, ptr %v17.p
  %v257 = getelementptr i64, ptr @"rt.meta", i64 0
  %v258 = getelementptr i64, ptr %v257, i64 %v17
  %v18.p = getelementptr i64, ptr %v258, i64 1
  %v18 = load ptr, ptr %v18.p
  %v19 = ptrtoint ptr %v18 to i64
  %st8 = getelementptr i64, ptr %v0, i64 0
  store i64 %v19, ptr %st8
  %v20 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v0, i64 1
  store i64 %v20, ptr %st9
  %st10 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st10
  %st11 = getelementptr i64, ptr %v0, i64 3
  store i64 %v16, ptr %st11
  %v21.p = getelementptr i64, ptr %v12, i64 0
  %v21 = load i64, ptr %v21.p
  %st12 = getelementptr i64, ptr %v0, i64 4
  store i64 %v21, ptr %st12
  %v22.p = getelementptr i64, ptr %v12, i64 1
  %v22 = load i64, ptr %v22.p
  %st13 = getelementptr i64, ptr %v0, i64 5
  store i64 %v22, ptr %st13
  %v23.p = getelementptr i64, ptr %v12, i64 2
  %v23 = load i64, ptr %v23.p
  %st14 = getelementptr i64, ptr %v0, i64 6
  store i64 %v23, ptr %st14
  %v24.p = getelementptr i64, ptr %v12, i64 3
  %v24 = load i64, ptr %v24.p
  %st15 = getelementptr i64, ptr %v0, i64 7
  store i64 %v24, ptr %st15
  %v25.p = getelementptr i64, ptr %v12, i64 4
  %v25 = load i64, ptr %v25.p
  %st16 = getelementptr i64, ptr %v0, i64 8
  store i64 %v25, ptr %st16
  %v26.p = getelementptr i64, ptr %v12, i64 5
  %v26 = load i64, ptr %v26.p
  %st17 = getelementptr i64, ptr %v0, i64 9
  store i64 %v26, ptr %st17
  call void @"rt.region_relocate8"(ptr %v0, i64 %v6)
  %v27.p = getelementptr i64, ptr %v0, i64 4
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 0, 0
  %v29.c = icmp ne i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b1 = icmp ne i64 %v29, 0
  br i1 %c.b1, label %b1.t19, label %b1.e20
b1.t19:
  br label %b3
b1.e20:
  br label %b4
b2:
  %v32 = getelementptr i64, ptr %s2, i64 0
  %v33.p = getelementptr i64, ptr %v7, i64 0
  %v33 = load i64, ptr %v33.p
  %st20 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st20
  %v259 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v259, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 0
  %v36 = call ptr @"rt.region_alloc8"(i64 %v34, i64 %v35)
  %v37 = add i64 0, 0
  %v38 = getelementptr i64, ptr %s3, i64 0
  %v39 = ptrtoint ptr %v36 to i64
  %st21 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st21
  %st22 = getelementptr i64, ptr %v38, i64 1
  store i64 %v37, ptr %st22
  %st23 = getelementptr i64, ptr %v38, i64 2
  store i64 %v34, ptr %st23
  %v40 = getelementptr i64, ptr %s4, i64 0
  %v41.p = getelementptr i64, ptr %v38, i64 0
  %v41 = load i64, ptr %v41.p
  %st24 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st24
  %v42.p = getelementptr i64, ptr %v38, i64 1
  %v42 = load i64, ptr %v42.p
  %st25 = getelementptr i64, ptr %v40, i64 1
  store i64 %v42, ptr %st25
  %v43.p = getelementptr i64, ptr %v38, i64 2
  %v43 = load i64, ptr %v43.p
  %st26 = getelementptr i64, ptr %v40, i64 2
  store i64 %v43, ptr %st26
  %v260 = getelementptr i64, ptr @"rt.meta", i64 0
  %v44.p = getelementptr i64, ptr %v260, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = getelementptr i64, ptr %s5, i64 0
  %v46.p = getelementptr i64, ptr %v32, i64 0
  %v46 = load i64, ptr %v46.p
  %st27 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st27
  %v47 = getelementptr i64, ptr %s6, i64 0
  %v261 = getelementptr i64, ptr @"rt.meta", i64 0
  %v48.p = getelementptr i64, ptr %v261, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 0
  %v50.c = icmp slt i64 %v4, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b2 = icmp ne i64 %v50, 0
  br i1 %c.b2, label %b2.t29, label %b2.e30
b2.t29:
  br label %b7
b2.e30:
  br label %b8
b3:
  %v30 = add i64 0, 7
  %v31 = getelementptr i64, ptr %v0, i64 %v30
  %v262 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v31, i64 %v262, i64 %v6)
  br label %b4
b4:
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v263, i64 0
  store i64 %v6, ptr %st30
  ret void
b5:
  %v264 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v264, i64 0
  store i64 %v44, ptr %st31
  %v236.p = getelementptr i64, ptr %v40, i64 1
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 %v4, %v236
  %v238 = getelementptr i64, ptr %s11, i64 0
  %v239 = add i64 0, 0
  %st32 = getelementptr i64, ptr %v238, i64 0
  store i64 %v239, ptr %st32
  %v240.p = getelementptr i64, ptr %v40, i64 0
  %v240 = load i64, ptr %v240.p
  %st33 = getelementptr i64, ptr %v0, i64 0
  store i64 %v240, ptr %st33
  %v241.p = getelementptr i64, ptr %v40, i64 1
  %v241 = load i64, ptr %v241.p
  %st34 = getelementptr i64, ptr %v0, i64 1
  store i64 %v241, ptr %st34
  %v242.p = getelementptr i64, ptr %v40, i64 2
  %v242 = load i64, ptr %v242.p
  %st35 = getelementptr i64, ptr %v0, i64 2
  store i64 %v242, ptr %st35
  %st36 = getelementptr i64, ptr %v0, i64 3
  store i64 %v237, ptr %st36
  %v243.p = getelementptr i64, ptr %v238, i64 0
  %v243 = load i64, ptr %v243.p
  %st37 = getelementptr i64, ptr %v0, i64 4
  store i64 %v243, ptr %st37
  %v244.p = getelementptr i64, ptr %v238, i64 1
  %v244 = load i64, ptr %v244.p
  %st38 = getelementptr i64, ptr %v0, i64 5
  store i64 %v244, ptr %st38
  %v245.p = getelementptr i64, ptr %v238, i64 2
  %v245 = load i64, ptr %v245.p
  %st39 = getelementptr i64, ptr %v0, i64 6
  store i64 %v245, ptr %st39
  %v246.p = getelementptr i64, ptr %v238, i64 3
  %v246 = load i64, ptr %v246.p
  %st40 = getelementptr i64, ptr %v0, i64 7
  store i64 %v246, ptr %st40
  %v247.p = getelementptr i64, ptr %v238, i64 4
  %v247 = load i64, ptr %v247.p
  %st41 = getelementptr i64, ptr %v0, i64 8
  store i64 %v247, ptr %st41
  %v248.p = getelementptr i64, ptr %v238, i64 5
  %v248 = load i64, ptr %v248.p
  %st42 = getelementptr i64, ptr %v0, i64 9
  store i64 %v248, ptr %st42
  %v249.p = getelementptr i64, ptr %v32, i64 0
  %v249 = load i64, ptr %v249.p
  call void @"std/io.Close"(i64 %v249)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v6)
  %v250.p = getelementptr i64, ptr %v0, i64 4
  %v250 = load i64, ptr %v250.p
  %v251 = add i64 0, 0
  %v252.c = icmp ne i64 %v250, %v251
  %v252 = zext i1 %v252.c to i64
  %c.b5 = icmp ne i64 %v252, 0
  br i1 %c.b5, label %b5.t44, label %b5.e45
b5.t44:
  br label %b40
b5.e45:
  br label %b41
b6:
  %v216.p = getelementptr i64, ptr %v47, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 0
  %v218.c = icmp ne i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b6 = icmp ne i64 %v218, 0
  br i1 %c.b6, label %b6.t46, label %b6.e47
b6.t46:
  br label %b36
b6.e47:
  br label %b37
b7:
  %v51 = add i64 0, 22
  %v52 = getelementptr i64, ptr %s7, i64 0
  %v53 = add i64 0, 0
  %st47 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st47
  %st48 = getelementptr i64, ptr %v52, i64 1
  store i64 %v53, ptr %st48
  %v54 = add i64 0, 5
  %st49 = getelementptr i64, ptr %v52, i64 0
  store i64 %v54, ptr %st49
  %st50 = getelementptr i64, ptr %v52, i64 1
  store i64 %v51, ptr %st50
  %v55 = getelementptr i64, ptr %s8, i64 0
  %v56.p = getelementptr i64, ptr %v52, i64 0
  %v56 = load i64, ptr %v56.p
  %st51 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st51
  %v57.p = getelementptr i64, ptr %v52, i64 1
  %v57 = load i64, ptr %v57.p
  %st52 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st52
  %v58 = add i64 0, 0
  %st53 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st53
  %st54 = getelementptr i64, ptr %v55, i64 3
  store i64 %v58, ptr %st54
  %st55 = getelementptr i64, ptr %v55, i64 4
  store i64 %v58, ptr %st55
  %v59 = getelementptr i64, ptr %s9, i64 0
  %v60 = add i64 0, 1
  %st56 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st56
  %v61.p = getelementptr i64, ptr %v55, i64 0
  %v61 = load i64, ptr %v61.p
  %st57 = getelementptr i64, ptr %v59, i64 1
  store i64 %v61, ptr %st57
  %v62.p = getelementptr i64, ptr %v55, i64 1
  %v62 = load i64, ptr %v62.p
  %st58 = getelementptr i64, ptr %v59, i64 2
  store i64 %v62, ptr %st58
  %v63.p = getelementptr i64, ptr %v55, i64 2
  %v63 = load i64, ptr %v63.p
  %st59 = getelementptr i64, ptr %v59, i64 3
  store i64 %v63, ptr %st59
  %v64.p = getelementptr i64, ptr %v55, i64 3
  %v64 = load i64, ptr %v64.p
  %st60 = getelementptr i64, ptr %v59, i64 4
  store i64 %v64, ptr %st60
  %v65.p = getelementptr i64, ptr %v55, i64 4
  %v65 = load i64, ptr %v65.p
  %st61 = getelementptr i64, ptr %v59, i64 5
  store i64 %v65, ptr %st61
  %v66.p = getelementptr i64, ptr %v59, i64 0
  %v66 = load i64, ptr %v66.p
  %st62 = getelementptr i64, ptr %v47, i64 0
  store i64 %v66, ptr %st62
  %v67.p = getelementptr i64, ptr %v59, i64 1
  %v67 = load i64, ptr %v67.p
  %st63 = getelementptr i64, ptr %v47, i64 1
  store i64 %v67, ptr %st63
  %v68.p = getelementptr i64, ptr %v59, i64 2
  %v68 = load i64, ptr %v68.p
  %st64 = getelementptr i64, ptr %v47, i64 2
  store i64 %v68, ptr %st64
  %v69.p = getelementptr i64, ptr %v59, i64 3
  %v69 = load i64, ptr %v69.p
  %st65 = getelementptr i64, ptr %v47, i64 3
  store i64 %v69, ptr %st65
  %v70.p = getelementptr i64, ptr %v59, i64 4
  %v70 = load i64, ptr %v70.p
  %st66 = getelementptr i64, ptr %v47, i64 4
  store i64 %v70, ptr %st66
  %v71.p = getelementptr i64, ptr %v59, i64 5
  %v71 = load i64, ptr %v71.p
  %st67 = getelementptr i64, ptr %v47, i64 5
  store i64 %v71, ptr %st67
  %v72.p = getelementptr i64, ptr %v47, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 0
  %v74.c = icmp ne i64 %v72, %v73
  %v74 = zext i1 %v74.c to i64
  %c.b7 = icmp ne i64 %v74, 0
  br i1 %c.b7, label %b7.t69, label %b7.e70
b7.t69:
  br label %b9
b7.e70:
  br label %b10
b8:
  br label %b11
b9:
  %v75 = add i64 0, 3
  %v76 = getelementptr i64, ptr %v47, i64 %v75
  %v265 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v76, i64 %v265, i64 %v48)
  br label %b10
b10:
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v266, i64 0
  store i64 %v48, ptr %st70
  br label %b6
b11:
  %v77 = getelementptr i64, ptr %s10, i64 0
  %v78.p = getelementptr i64, ptr %v45, i64 0
  %v78 = load i64, ptr %v78.p
  %st71 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st71
  %v79 = getelementptr i64, ptr %s9, i64 0
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %v80.p = getelementptr i64, ptr %v267, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v77, i64 0
  %v81 = load i64, ptr %v81.p
  %v82 = add i64 0, 65536
  %v83 = add i64 0, 2
  %v84 = call i64 @"rt.chunk_open"(i64 %v81, i64 %v82, i64 %v83, i64 %v4)
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v85.p = getelementptr i64, ptr %v268, i64 0
  %v85 = load i64, ptr %v85.p
  br label %b13
b12:
  %v205.p = getelementptr i64, ptr %v79, i64 0
  %v205 = load i64, ptr %v205.p
  %st72 = getelementptr i64, ptr %v47, i64 0
  store i64 %v205, ptr %st72
  %v206.p = getelementptr i64, ptr %v79, i64 1
  %v206 = load i64, ptr %v206.p
  %st73 = getelementptr i64, ptr %v47, i64 1
  store i64 %v206, ptr %st73
  %v207.p = getelementptr i64, ptr %v79, i64 2
  %v207 = load i64, ptr %v207.p
  %st74 = getelementptr i64, ptr %v47, i64 2
  store i64 %v207, ptr %st74
  %v208.p = getelementptr i64, ptr %v79, i64 3
  %v208 = load i64, ptr %v208.p
  %st75 = getelementptr i64, ptr %v47, i64 3
  store i64 %v208, ptr %st75
  %v209.p = getelementptr i64, ptr %v79, i64 4
  %v209 = load i64, ptr %v209.p
  %st76 = getelementptr i64, ptr %v47, i64 4
  store i64 %v209, ptr %st76
  %v210.p = getelementptr i64, ptr %v79, i64 5
  %v210 = load i64, ptr %v210.p
  %st77 = getelementptr i64, ptr %v47, i64 5
  store i64 %v210, ptr %st77
  %v211.p = getelementptr i64, ptr %v47, i64 0
  %v211 = load i64, ptr %v211.p
  %v212 = add i64 0, 0
  %v213.c = icmp ne i64 %v211, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b12 = icmp ne i64 %v213, 0
  br i1 %c.b12, label %b12.t79, label %b12.e80
b12.t79:
  br label %b34
b12.e80:
  br label %b35
b13:
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v269, i64 0
  store i64 %v85, ptr %st80
  %v86 = add i64 0, 1
  %c.b13 = icmp ne i64 %v86, 0
  br i1 %c.b13, label %b13.t82, label %b13.e83
b13.t82:
  br label %b14
b13.e83:
  br label %b15
b14:
  call void @"rt.region_enter"()
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v270, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 0, 0
  %v89 = add i64 0, 0
  %v90.c = icmp ne i64 %v88, %v89
  %v90 = zext i1 %v90.c to i64
  %c.b14 = icmp ne i64 %v90, 0
  br i1 %c.b14, label %b14.t84, label %b14.e85
b14.t84:
  br label %b16
b14.e85:
  br label %b17
b15:
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %st85 = getelementptr i64, ptr %v271, i64 0
  store i64 %v85, ptr %st85
  %v192 = getelementptr i64, ptr %s11, i64 0
  %v193 = add i64 0, 0
  %st86 = getelementptr i64, ptr %v192, i64 0
  store i64 %v193, ptr %st86
  %v194.p = getelementptr i64, ptr %v192, i64 0
  %v194 = load i64, ptr %v194.p
  %st87 = getelementptr i64, ptr %v79, i64 0
  store i64 %v194, ptr %st87
  %v195.p = getelementptr i64, ptr %v192, i64 1
  %v195 = load i64, ptr %v195.p
  %st88 = getelementptr i64, ptr %v79, i64 1
  store i64 %v195, ptr %st88
  %v196.p = getelementptr i64, ptr %v192, i64 2
  %v196 = load i64, ptr %v196.p
  %st89 = getelementptr i64, ptr %v79, i64 2
  store i64 %v196, ptr %st89
  %v197.p = getelementptr i64, ptr %v192, i64 3
  %v197 = load i64, ptr %v197.p
  %st90 = getelementptr i64, ptr %v79, i64 3
  store i64 %v197, ptr %st90
  %v198.p = getelementptr i64, ptr %v192, i64 4
  %v198 = load i64, ptr %v198.p
  %st91 = getelementptr i64, ptr %v79, i64 4
  store i64 %v198, ptr %st91
  %v199.p = getelementptr i64, ptr %v192, i64 5
  %v199 = load i64, ptr %v199.p
  %st92 = getelementptr i64, ptr %v79, i64 5
  store i64 %v199, ptr %st92
  call void @"std/io.chunkEnd"(i64 %v84)
  %v200.p = getelementptr i64, ptr %v79, i64 0
  %v200 = load i64, ptr %v200.p
  %v201 = add i64 0, 0
  %v202.c = icmp ne i64 %v200, %v201
  %v202 = zext i1 %v202.c to i64
  %c.b15 = icmp ne i64 %v202, 0
  br i1 %c.b15, label %b15.t94, label %b15.e95
b15.t94:
  br label %b32
b15.e95:
  br label %b33
b16:
  %v91 = getelementptr i64, ptr %s7, i64 0
  %v92 = add i64 0, 0
  %st95 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st95
  %st96 = getelementptr i64, ptr %v91, i64 1
  store i64 %v92, ptr %st96
  %v93 = add i64 0, 3
  %st97 = getelementptr i64, ptr %v91, i64 0
  store i64 %v93, ptr %st97
  %v94 = getelementptr i64, ptr %s8, i64 0
  %v95.p = getelementptr i64, ptr %v91, i64 0
  %v95 = load i64, ptr %v95.p
  %st98 = getelementptr i64, ptr %v94, i64 0
  store i64 %v95, ptr %st98
  %v96.p = getelementptr i64, ptr %v91, i64 1
  %v96 = load i64, ptr %v96.p
  %st99 = getelementptr i64, ptr %v94, i64 1
  store i64 %v96, ptr %st99
  %v97 = add i64 0, 0
  %st100 = getelementptr i64, ptr %v94, i64 2
  store i64 %v97, ptr %st100
  %st101 = getelementptr i64, ptr %v94, i64 3
  store i64 %v97, ptr %st101
  %st102 = getelementptr i64, ptr %v94, i64 4
  store i64 %v97, ptr %st102
  %v98 = getelementptr i64, ptr %s11, i64 0
  %v99 = add i64 0, 1
  %st103 = getelementptr i64, ptr %v98, i64 0
  store i64 %v99, ptr %st103
  %v100.p = getelementptr i64, ptr %v94, i64 0
  %v100 = load i64, ptr %v100.p
  %st104 = getelementptr i64, ptr %v98, i64 1
  store i64 %v100, ptr %st104
  %v101.p = getelementptr i64, ptr %v94, i64 1
  %v101 = load i64, ptr %v101.p
  %st105 = getelementptr i64, ptr %v98, i64 2
  store i64 %v101, ptr %st105
  %v102.p = getelementptr i64, ptr %v94, i64 2
  %v102 = load i64, ptr %v102.p
  %st106 = getelementptr i64, ptr %v98, i64 3
  store i64 %v102, ptr %st106
  %v103.p = getelementptr i64, ptr %v94, i64 3
  %v103 = load i64, ptr %v103.p
  %st107 = getelementptr i64, ptr %v98, i64 4
  store i64 %v103, ptr %st107
  %v104.p = getelementptr i64, ptr %v94, i64 4
  %v104 = load i64, ptr %v104.p
  %st108 = getelementptr i64, ptr %v98, i64 5
  store i64 %v104, ptr %st108
  %v105.p = getelementptr i64, ptr %v98, i64 0
  %v105 = load i64, ptr %v105.p
  %st109 = getelementptr i64, ptr %v79, i64 0
  store i64 %v105, ptr %st109
  %v106.p = getelementptr i64, ptr %v98, i64 1
  %v106 = load i64, ptr %v106.p
  %st110 = getelementptr i64, ptr %v79, i64 1
  store i64 %v106, ptr %st110
  %v107.p = getelementptr i64, ptr %v98, i64 2
  %v107 = load i64, ptr %v107.p
  %st111 = getelementptr i64, ptr %v79, i64 2
  store i64 %v107, ptr %st111
  %v108.p = getelementptr i64, ptr %v98, i64 3
  %v108 = load i64, ptr %v108.p
  %st112 = getelementptr i64, ptr %v79, i64 3
  store i64 %v108, ptr %st112
  %v109.p = getelementptr i64, ptr %v98, i64 4
  %v109 = load i64, ptr %v109.p
  %st113 = getelementptr i64, ptr %v79, i64 4
  store i64 %v109, ptr %st113
  %v110.p = getelementptr i64, ptr %v98, i64 5
  %v110 = load i64, ptr %v110.p
  %st114 = getelementptr i64, ptr %v79, i64 5
  store i64 %v110, ptr %st114
  call void @"std/io.chunkEnd"(i64 %v84)
  %v111.p = getelementptr i64, ptr %v79, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 0, 0
  %v113.c = icmp ne i64 %v111, %v112
  %v113 = zext i1 %v113.c to i64
  %c.b16 = icmp ne i64 %v113, 0
  br i1 %c.b16, label %b16.t116, label %b16.e117
b16.t116:
  br label %b18
b16.e117:
  br label %b19
b17:
  br label %b20
b18:
  %v114 = add i64 0, 3
  %v115 = getelementptr i64, ptr %v79, i64 %v114
  %v272 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v115, i64 %v272, i64 %v80)
  br label %b19
b19:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v273, i64 0
  store i64 %v80, ptr %st117
  br label %b12
b20:
  %v116 = getelementptr i64, ptr %s3, i64 0
  call void @"rt.chunk_next"(i64 %v84, ptr %v116)
  %v117 = getelementptr i64, ptr %s12, i64 0
  %v118.p = getelementptr i64, ptr %v116, i64 0
  %v118 = load i64, ptr %v118.p
  %st118 = getelementptr i64, ptr %v117, i64 0
  store i64 %v118, ptr %st118
  %v119.p = getelementptr i64, ptr %v116, i64 1
  %v119 = load i64, ptr %v119.p
  %st119 = getelementptr i64, ptr %v117, i64 1
  store i64 %v119, ptr %st119
  %v120.p = getelementptr i64, ptr %v116, i64 2
  %v120 = load i64, ptr %v120.p
  %st120 = getelementptr i64, ptr %v117, i64 2
  store i64 %v120, ptr %st120
  %v121.p = getelementptr i64, ptr %v117, i64 1
  %v121 = load i64, ptr %v121.p
  %v122 = add i64 0, 0
  %v123.c = icmp eq i64 %v121, %v122
  %v123 = zext i1 %v123.c to i64
  %c.b20 = icmp ne i64 %v123, 0
  br i1 %c.b20, label %b20.t122, label %b20.e123
b20.t122:
  br label %b21
b20.e123:
  br label %b22
b21:
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %v125.p = getelementptr i64, ptr %v124, i64 1027
  %v125 = load i64, ptr %v125.p
  %v126 = add i64 0, 0
  %v127.c = icmp ne i64 %v125, %v126
  %v127 = zext i1 %v127.c to i64
  %c.b21 = icmp ne i64 %v127, 0
  br i1 %c.b21, label %b21.t124, label %b21.e125
b21.t124:
  br label %b23
b21.e125:
  br label %b24
b22:
  br label %b30
b23:
  %v128 = getelementptr i64, ptr %s13, i64 0
  call void @"std/io.errOf"(ptr %v128, i64 %v125)
  %v129 = getelementptr i64, ptr %s11, i64 0
  %v130 = add i64 0, 1
  %st125 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st125
  %v131.p = getelementptr i64, ptr %v128, i64 0
  %v131 = load i64, ptr %v131.p
  %st126 = getelementptr i64, ptr %v129, i64 1
  store i64 %v131, ptr %st126
  %v132.p = getelementptr i64, ptr %v128, i64 1
  %v132 = load i64, ptr %v132.p
  %st127 = getelementptr i64, ptr %v129, i64 2
  store i64 %v132, ptr %st127
  %v133.p = getelementptr i64, ptr %v128, i64 2
  %v133 = load i64, ptr %v133.p
  %st128 = getelementptr i64, ptr %v129, i64 3
  store i64 %v133, ptr %st128
  %v134.p = getelementptr i64, ptr %v128, i64 3
  %v134 = load i64, ptr %v134.p
  %st129 = getelementptr i64, ptr %v129, i64 4
  store i64 %v134, ptr %st129
  %v135.p = getelementptr i64, ptr %v128, i64 4
  %v135 = load i64, ptr %v135.p
  %st130 = getelementptr i64, ptr %v129, i64 5
  store i64 %v135, ptr %st130
  %v136.p = getelementptr i64, ptr %v129, i64 0
  %v136 = load i64, ptr %v136.p
  %st131 = getelementptr i64, ptr %v79, i64 0
  store i64 %v136, ptr %st131
  %v137.p = getelementptr i64, ptr %v129, i64 1
  %v137 = load i64, ptr %v137.p
  %st132 = getelementptr i64, ptr %v79, i64 1
  store i64 %v137, ptr %st132
  %v138.p = getelementptr i64, ptr %v129, i64 2
  %v138 = load i64, ptr %v138.p
  %st133 = getelementptr i64, ptr %v79, i64 2
  store i64 %v138, ptr %st133
  %v139.p = getelementptr i64, ptr %v129, i64 3
  %v139 = load i64, ptr %v139.p
  %st134 = getelementptr i64, ptr %v79, i64 3
  store i64 %v139, ptr %st134
  %v140.p = getelementptr i64, ptr %v129, i64 4
  %v140 = load i64, ptr %v140.p
  %st135 = getelementptr i64, ptr %v79, i64 4
  store i64 %v140, ptr %st135
  %v141.p = getelementptr i64, ptr %v129, i64 5
  %v141 = load i64, ptr %v141.p
  %st136 = getelementptr i64, ptr %v79, i64 5
  store i64 %v141, ptr %st136
  call void @"std/io.chunkEnd"(i64 %v84)
  %v142.p = getelementptr i64, ptr %v79, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = add i64 0, 0
  %v144.c = icmp ne i64 %v142, %v143
  %v144 = zext i1 %v144.c to i64
  %c.b23 = icmp ne i64 %v144, 0
  br i1 %c.b23, label %b23.t138, label %b23.e139
b23.t138:
  br label %b25
b23.e139:
  br label %b26
b24:
  br label %b27
b25:
  %v145 = add i64 0, 3
  %v146 = getelementptr i64, ptr %v79, i64 %v145
  %v274 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v146, i64 %v274, i64 %v80)
  br label %b26
b26:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st139 = getelementptr i64, ptr %v275, i64 0
  store i64 %v80, ptr %st139
  br label %b12
b27:
  %v147 = getelementptr i64, ptr %s11, i64 0
  %v148 = add i64 0, 0
  %st140 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st140
  %v149.p = getelementptr i64, ptr %v147, i64 0
  %v149 = load i64, ptr %v149.p
  %st141 = getelementptr i64, ptr %v79, i64 0
  store i64 %v149, ptr %st141
  %v150.p = getelementptr i64, ptr %v147, i64 1
  %v150 = load i64, ptr %v150.p
  %st142 = getelementptr i64, ptr %v79, i64 1
  store i64 %v150, ptr %st142
  %v151.p = getelementptr i64, ptr %v147, i64 2
  %v151 = load i64, ptr %v151.p
  %st143 = getelementptr i64, ptr %v79, i64 2
  store i64 %v151, ptr %st143
  %v152.p = getelementptr i64, ptr %v147, i64 3
  %v152 = load i64, ptr %v152.p
  %st144 = getelementptr i64, ptr %v79, i64 3
  store i64 %v152, ptr %st144
  %v153.p = getelementptr i64, ptr %v147, i64 4
  %v153 = load i64, ptr %v153.p
  %st145 = getelementptr i64, ptr %v79, i64 4
  store i64 %v153, ptr %st145
  %v154.p = getelementptr i64, ptr %v147, i64 5
  %v154 = load i64, ptr %v154.p
  %st146 = getelementptr i64, ptr %v79, i64 5
  store i64 %v154, ptr %st146
  call void @"std/io.chunkEnd"(i64 %v84)
  %v155.p = getelementptr i64, ptr %v79, i64 0
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 0, 0
  %v157.c = icmp ne i64 %v155, %v156
  %v157 = zext i1 %v157.c to i64
  %c.b27 = icmp ne i64 %v157, 0
  br i1 %c.b27, label %b27.t148, label %b27.e149
b27.t148:
  br label %b28
b27.e149:
  br label %b29
b28:
  %v158 = add i64 0, 3
  %v159 = getelementptr i64, ptr %v79, i64 %v158
  %v276 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v159, i64 %v276, i64 %v80)
  br label %b29
b29:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st149 = getelementptr i64, ptr %v277, i64 0
  store i64 %v80, ptr %st149
  br label %b12
b30:
  %v160 = getelementptr i64, ptr %s3, i64 0
  %v161.p = getelementptr i64, ptr %v117, i64 0
  %v161 = load i64, ptr %v161.p
  %st150 = getelementptr i64, ptr %v160, i64 0
  store i64 %v161, ptr %st150
  %v162.p = getelementptr i64, ptr %v117, i64 1
  %v162 = load i64, ptr %v162.p
  %st151 = getelementptr i64, ptr %v160, i64 1
  store i64 %v162, ptr %st151
  %v163.p = getelementptr i64, ptr %v117, i64 2
  %v163 = load i64, ptr %v163.p
  %st152 = getelementptr i64, ptr %v160, i64 2
  store i64 %v163, ptr %st152
  %v164 = getelementptr i64, ptr %s14, i64 0
  %v165 = add i64 0, 0
  %v166 = getelementptr i64, ptr %s15, i64 0
  %v167 = getelementptr i64, ptr %s16, i64 0
  %v168 = add i64 0, 0
  %st153 = getelementptr i64, ptr %v167, i64 0
  store i64 %v168, ptr %st153
  %st154 = getelementptr i64, ptr %v167, i64 1
  store i64 %v168, ptr %st154
  %st155 = getelementptr i64, ptr %v167, i64 2
  store i64 %v168, ptr %st155
  %v169.p = getelementptr i64, ptr %v160, i64 0
  %v169 = load i64, ptr %v169.p
  %st156 = getelementptr i64, ptr %v167, i64 0
  store i64 %v169, ptr %st156
  %v170.p = getelementptr i64, ptr %v160, i64 1
  %v170 = load i64, ptr %v170.p
  %st157 = getelementptr i64, ptr %v167, i64 1
  store i64 %v170, ptr %st157
  %v171.p = getelementptr i64, ptr %v160, i64 2
  %v171 = load i64, ptr %v171.p
  %st158 = getelementptr i64, ptr %v167, i64 2
  store i64 %v171, ptr %st158
  %v172 = getelementptr i64, ptr %s17, i64 0
  %v173.p = getelementptr i64, ptr %v167, i64 0
  %v173 = load i64, ptr %v173.p
  %st159 = getelementptr i64, ptr %v172, i64 0
  store i64 %v173, ptr %st159
  %v174.p = getelementptr i64, ptr %v167, i64 1
  %v174 = load i64, ptr %v174.p
  %st160 = getelementptr i64, ptr %v172, i64 1
  store i64 %v174, ptr %st160
  %v175.p = getelementptr i64, ptr %v167, i64 2
  %v175 = load i64, ptr %v175.p
  %st161 = getelementptr i64, ptr %v172, i64 2
  store i64 %v175, ptr %st161
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %v176.p = getelementptr i64, ptr %v278, i64 0
  %v176 = load i64, ptr %v176.p
  %v177 = add i64 0, 1
  %v178 = add i64 %v6, %v177
  %v179 = getelementptr i64, ptr %s18, i64 0
  %v180.p = getelementptr i64, ptr %v172, i64 0
  %v180 = load i64, ptr %v180.p
  %v181.p = getelementptr i64, ptr %v172, i64 1
  %v181 = load i64, ptr %v181.p
  %v182.p = getelementptr i64, ptr %v172, i64 2
  %v182 = load i64, ptr %v182.p
  call void @"std/io.Raw"(ptr %v179, i64 %v180, i64 %v181, i64 %v182)
  %v183 = getelementptr i64, ptr %s19, i64 0
  %v184.p = getelementptr i64, ptr %v179, i64 0
  %v184 = load i64, ptr %v184.p
  %st162 = getelementptr i64, ptr %v183, i64 0
  store i64 %v184, ptr %st162
  %v185.p = getelementptr i64, ptr %v179, i64 1
  %v185 = load i64, ptr %v185.p
  %st163 = getelementptr i64, ptr %v183, i64 1
  store i64 %v185, ptr %st163
  %v186.p = getelementptr i64, ptr %v179, i64 2
  %v186 = load i64, ptr %v186.p
  %st164 = getelementptr i64, ptr %v183, i64 2
  store i64 %v186, ptr %st164
  %v187 = add i64 0, 1
  %v188 = add i64 %v6, %v187
  call void @"rt.region_relocate8"(ptr %v183, i64 %v188)
  %v189.p = getelementptr i64, ptr %v183, i64 0
  %v189 = load i64, ptr %v189.p
  %st165 = getelementptr i64, ptr %v40, i64 0
  store i64 %v189, ptr %st165
  %v190.p = getelementptr i64, ptr %v183, i64 1
  %v190 = load i64, ptr %v190.p
  %st166 = getelementptr i64, ptr %v40, i64 1
  store i64 %v190, ptr %st166
  %v191.p = getelementptr i64, ptr %v183, i64 2
  %v191 = load i64, ptr %v191.p
  %st167 = getelementptr i64, ptr %v40, i64 2
  store i64 %v191, ptr %st167
  call void @"std/io.chunkEnd"(i64 %v84)
  br label %b5
b31:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v203 = add i64 0, 3
  %v204 = getelementptr i64, ptr %v79, i64 %v203
  %v279 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v204, i64 %v279, i64 %v80)
  br label %b33
b33:
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %st168 = getelementptr i64, ptr %v280, i64 0
  store i64 %v80, ptr %st168
  br label %b12
b34:
  %v214 = add i64 0, 3
  %v215 = getelementptr i64, ptr %v47, i64 %v214
  %v281 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v215, i64 %v281, i64 %v48)
  br label %b35
b35:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st169 = getelementptr i64, ptr %v282, i64 0
  store i64 %v48, ptr %st169
  br label %b6
b36:
  %v219 = add i64 0, 0
  %st170 = getelementptr i64, ptr %v0, i64 0
  store i64 %v219, ptr %st170
  %st171 = getelementptr i64, ptr %v0, i64 1
  store i64 %v219, ptr %st171
  %st172 = getelementptr i64, ptr %v0, i64 2
  store i64 %v219, ptr %st172
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %v220.p = getelementptr i64, ptr %v283, i64 0
  %v220 = load i64, ptr %v220.p
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %v285 = getelementptr i64, ptr %v284, i64 %v220
  %v221.p = getelementptr i64, ptr %v285, i64 1
  %v221 = load ptr, ptr %v221.p
  %v222 = ptrtoint ptr %v221 to i64
  %st173 = getelementptr i64, ptr %v0, i64 0
  store i64 %v222, ptr %st173
  %v223 = add i64 0, 0
  %st174 = getelementptr i64, ptr %v0, i64 1
  store i64 %v223, ptr %st174
  %st175 = getelementptr i64, ptr %v0, i64 2
  store i64 %v220, ptr %st175
  %st176 = getelementptr i64, ptr %v0, i64 3
  store i64 %v219, ptr %st176
  %v224.p = getelementptr i64, ptr %v47, i64 0
  %v224 = load i64, ptr %v224.p
  %st177 = getelementptr i64, ptr %v0, i64 4
  store i64 %v224, ptr %st177
  %v225.p = getelementptr i64, ptr %v47, i64 1
  %v225 = load i64, ptr %v225.p
  %st178 = getelementptr i64, ptr %v0, i64 5
  store i64 %v225, ptr %st178
  %v226.p = getelementptr i64, ptr %v47, i64 2
  %v226 = load i64, ptr %v226.p
  %st179 = getelementptr i64, ptr %v0, i64 6
  store i64 %v226, ptr %st179
  %v227.p = getelementptr i64, ptr %v47, i64 3
  %v227 = load i64, ptr %v227.p
  %st180 = getelementptr i64, ptr %v0, i64 7
  store i64 %v227, ptr %st180
  %v228.p = getelementptr i64, ptr %v47, i64 4
  %v228 = load i64, ptr %v228.p
  %st181 = getelementptr i64, ptr %v0, i64 8
  store i64 %v228, ptr %st181
  %v229.p = getelementptr i64, ptr %v47, i64 5
  %v229 = load i64, ptr %v229.p
  %st182 = getelementptr i64, ptr %v0, i64 9
  store i64 %v229, ptr %st182
  %v230.p = getelementptr i64, ptr %v32, i64 0
  %v230 = load i64, ptr %v230.p
  call void @"std/io.Close"(i64 %v230)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v6)
  %v231.p = getelementptr i64, ptr %v0, i64 4
  %v231 = load i64, ptr %v231.p
  %v232 = add i64 0, 0
  %v233.c = icmp ne i64 %v231, %v232
  %v233 = zext i1 %v233.c to i64
  %c.b36 = icmp ne i64 %v233, 0
  br i1 %c.b36, label %b36.t184, label %b36.e185
b36.t184:
  br label %b38
b36.e185:
  br label %b39
b37:
  br label %b5
b38:
  %v234 = add i64 0, 7
  %v235 = getelementptr i64, ptr %v0, i64 %v234
  %v286 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v235, i64 %v286, i64 %v6)
  br label %b39
b39:
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %st185 = getelementptr i64, ptr %v287, i64 0
  store i64 %v6, ptr %st185
  ret void
b40:
  %v253 = add i64 0, 7
  %v254 = getelementptr i64, ptr %v0, i64 %v253
  %v288 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v254, i64 %v288, i64 %v6)
  br label %b41
b41:
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %st186 = getelementptr i64, ptr %v289, i64 0
  store i64 %v6, ptr %st186
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
  %v20 = getelementptr i64, ptr @"str.28", i64 0
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
  %v74 = getelementptr i64, ptr @"str.36", i64 0
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
  %v27 = getelementptr i64, ptr @"str.29", i64 0
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
  %v34 = getelementptr i64, ptr @"str.30", i64 0
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
  %v41 = getelementptr i64, ptr @"str.31", i64 0
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
  %v48 = getelementptr i64, ptr @"str.32", i64 0
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
  %v55 = getelementptr i64, ptr @"str.33", i64 0
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
  %v62 = getelementptr i64, ptr @"str.34", i64 0
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
  %v69 = getelementptr i64, ptr @"str.35", i64 0
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
  %v81 = getelementptr i64, ptr @"str.37", i64 0
  %v82 = add i64 0, 18
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
  %v88 = getelementptr i64, ptr @"str.38", i64 0
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
  %v95 = getelementptr i64, ptr @"str.39", i64 0
  %v96 = add i64 0, 19
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

define internal i64 @"main.sum"(i64 %v0, i64 %v1, i64 %v2) #0 {
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
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v3, i64 2
  store i64 %v2, ptr %st2
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v40, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5 = add i64 0, 0
  %v6 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v6, i64 0
  store i64 %v5, ptr %st3
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v41, i64 0
  %v7 = load i64, ptr %v7.p
  %v8 = getelementptr i64, ptr %s2, i64 0
  %v9.p = getelementptr i64, ptr %v3, i64 0
  %v9 = load i64, ptr %v9.p
  %st4 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st4
  %v10.p = getelementptr i64, ptr %v3, i64 1
  %v10 = load i64, ptr %v10.p
  %st5 = getelementptr i64, ptr %v8, i64 1
  store i64 %v10, ptr %st5
  %v11.p = getelementptr i64, ptr %v3, i64 2
  %v11 = load i64, ptr %v11.p
  %st6 = getelementptr i64, ptr %v8, i64 2
  store i64 %v11, ptr %st6
  %v12 = getelementptr i64, ptr %s3, i64 0
  %v13.p = getelementptr i64, ptr %v8, i64 0
  %v13 = load i64, ptr %v13.p
  %st7 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st7
  %v14.p = getelementptr i64, ptr %v8, i64 1
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v12, i64 1
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v8, i64 2
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v12, i64 2
  store i64 %v15, ptr %st9
  %v16 = getelementptr i64, ptr %s4, i64 0
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v42, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 0
  %v19 = getelementptr i64, ptr %s5, i64 0
  %st10 = getelementptr i64, ptr %v19, i64 0
  store i64 %v18, ptr %st10
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v43, i64 0
  %v20 = load i64, ptr %v20.p
  br label %b3
b1:
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v44, i64 0
  store i64 %v7, ptr %st11
  %v39.p = getelementptr i64, ptr %v6, i64 0
  %v39 = load i64, ptr %v39.p
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v45, i64 0
  store i64 %v4, ptr %st12
  ret i64 %v39
b2:
  br label %b1
b3:
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v46, i64 0
  store i64 %v20, ptr %st13
  %v21.p = getelementptr i64, ptr %v19, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v12, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp slt i64 %v21, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b3 = icmp ne i64 %v23, 0
  br i1 %c.b3, label %b3.t15, label %b3.e16
b3.t15:
  br label %b4
b3.e16:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v47 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v47, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v19, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v12, i64 1
  %v26 = load i64, ptr %v26.p
  %v27.c = icmp uge i64 %v25, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b4 = icmp ne i64 %v27, 0
  br i1 %c.b4, label %b4.t17, label %b4.e18
b4.t17:
  br label %b6
b4.e18:
  br label %b7
b5:
  %v48 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v48, i64 0
  store i64 %v20, ptr %st18
  br label %b2
b6:
  %v28 = add i64 0, 11
  call void @"rt.panic"(i64 %v28)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v29.p = getelementptr i64, ptr %v12, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = inttoptr i64 %v29 to ptr
  %v31 = getelementptr i8, ptr %v30, i64 %v25
  %v32.p = getelementptr i8, ptr %v31, i64 0
  %v32.b = load i8, ptr %v32.p
  %v32 = zext i8 %v32.b to i64
  %v49 = getelementptr i64, ptr @"rt.meta", i64 0
  %v33.p = getelementptr i64, ptr %v49, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v6, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 %v34, %v32
  %st19 = getelementptr i64, ptr %v6, i64 0
  store i64 %v35, ptr %st19
  br label %b8
b8:
  %v50 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v50, i64 0
  store i64 %v33, ptr %st20
  %v36 = add i64 0, 1
  %v37.p = getelementptr i64, ptr %v19, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 %v37, %v36
  %st21 = getelementptr i64, ptr %v19, i64 0
  store i64 %v38, ptr %st21
  br label %b3
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
  %v9 = getelementptr i64, ptr @"str.15", i64 0
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
  %v16 = getelementptr i64, ptr @"str.16", i64 0
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

define internal void @"main.position"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s6 = alloca [2 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
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
  %s26 = alloca [6 x i64], align 8
  %s26.z0 = getelementptr i64, ptr %s26, i64 0
  store i64 0, ptr %s26.z0
  %s26.z1 = getelementptr i64, ptr %s26, i64 1
  store i64 0, ptr %s26.z1
  %s26.z2 = getelementptr i64, ptr %s26, i64 2
  store i64 0, ptr %s26.z2
  %s26.z3 = getelementptr i64, ptr %s26, i64 3
  store i64 0, ptr %s26.z3
  %s26.z4 = getelementptr i64, ptr %s26, i64 4
  store i64 0, ptr %s26.z4
  %s26.z5 = getelementptr i64, ptr %s26, i64 5
  store i64 0, ptr %s26.z5
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
  %s30 = alloca [3 x i64], align 8
  %s30.z0 = getelementptr i64, ptr %s30, i64 0
  store i64 0, ptr %s30.z0
  %s30.z1 = getelementptr i64, ptr %s30, i64 1
  store i64 0, ptr %s30.z1
  %s30.z2 = getelementptr i64, ptr %s30, i64 2
  store i64 0, ptr %s30.z2
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
  %s32 = alloca [6 x i64], align 8
  %s32.z0 = getelementptr i64, ptr %s32, i64 0
  store i64 0, ptr %s32.z0
  %s32.z1 = getelementptr i64, ptr %s32, i64 1
  store i64 0, ptr %s32.z1
  %s32.z2 = getelementptr i64, ptr %s32, i64 2
  store i64 0, ptr %s32.z2
  %s32.z3 = getelementptr i64, ptr %s32, i64 3
  store i64 0, ptr %s32.z3
  %s32.z4 = getelementptr i64, ptr %s32, i64 4
  store i64 0, ptr %s32.z4
  %s32.z5 = getelementptr i64, ptr %s32, i64 5
  store i64 0, ptr %s32.z5
  %s33 = alloca [5 x i64], align 8
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
  %s34 = alloca [3 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
  %s34.z1 = getelementptr i64, ptr %s34, i64 1
  store i64 0, ptr %s34.z1
  %s34.z2 = getelementptr i64, ptr %s34, i64 2
  store i64 0, ptr %s34.z2
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
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v746 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v746, i64 0
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
  %v17.p = getelementptr i64, ptr %v12, i64 0
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v0, i64 0
  store i64 %v17, ptr %st5
  %v18.p = getelementptr i64, ptr %v12, i64 1
  %v18 = load i64, ptr %v18.p
  %st6 = getelementptr i64, ptr %v0, i64 1
  store i64 %v18, ptr %st6
  %v19.p = getelementptr i64, ptr %v12, i64 2
  %v19 = load i64, ptr %v19.p
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v19, ptr %st7
  %v20.p = getelementptr i64, ptr %v12, i64 3
  %v20 = load i64, ptr %v20.p
  %st8 = getelementptr i64, ptr %v0, i64 3
  store i64 %v20, ptr %st8
  %v21.p = getelementptr i64, ptr %v12, i64 4
  %v21 = load i64, ptr %v21.p
  %st9 = getelementptr i64, ptr %v0, i64 4
  store i64 %v21, ptr %st9
  %v22.p = getelementptr i64, ptr %v12, i64 5
  %v22 = load i64, ptr %v22.p
  %st10 = getelementptr i64, ptr %v0, i64 5
  store i64 %v22, ptr %st10
  %v23.p = getelementptr i64, ptr %v0, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b1 = icmp ne i64 %v25, 0
  br i1 %c.b1, label %b1.t12, label %b1.e13
b1.t12:
  br label %b3
b1.e13:
  br label %b4
b2:
  %v28 = getelementptr i64, ptr %s2, i64 0
  %v29.p = getelementptr i64, ptr %v7, i64 0
  %v29 = load i64, ptr %v29.p
  %st13 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st13
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s3, i64 0
  %st14 = getelementptr i64, ptr %v31, i64 0
  store i64 %v30, ptr %st14
  %v747 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v747, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34.p = getelementptr i64, ptr %v28, i64 0
  %v34 = load i64, ptr %v34.p
  %st15 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st15
  %v35 = add i64 0, 100000
  %v36 = getelementptr i64, ptr %s5, i64 0
  %v748 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v748, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 0
  %v39.c = icmp slt i64 %v35, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b2 = icmp ne i64 %v39, 0
  br i1 %c.b2, label %b2.t17, label %b2.e18
b2.t17:
  br label %b7
b2.e18:
  br label %b8
b3:
  %v26 = add i64 0, 3
  %v27 = getelementptr i64, ptr %v0, i64 %v26
  %v749 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v27, i64 %v749, i64 %v6)
  br label %b4
b4:
  %v750 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v750, i64 0
  store i64 %v6, ptr %st18
  ret void
b5:
  %v751 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v751, i64 0
  store i64 %v32, ptr %st19
  %v213 = getelementptr i64, ptr %s19, i64 0
  %v214.p = getelementptr i64, ptr %v28, i64 0
  %v214 = load i64, ptr %v214.p
  call void @"std/io.ReadAll"(ptr %v213, i64 %v214)
  %v215 = add i64 0, 3
  %v216 = getelementptr i64, ptr %v213, i64 %v215
  %v217.p = getelementptr i64, ptr %v216, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = add i64 0, 0
  %v219.c = icmp ne i64 %v217, %v218
  %v219 = zext i1 %v219.c to i64
  %c.b5 = icmp ne i64 %v219, 0
  br i1 %c.b5, label %b5.t21, label %b5.e22
b5.t21:
  br label %b40
b5.e22:
  br label %b41
b6:
  %v197.p = getelementptr i64, ptr %v36, i64 0
  %v197 = load i64, ptr %v197.p
  %v198 = add i64 0, 0
  %v199.c = icmp ne i64 %v197, %v198
  %v199 = zext i1 %v199.c to i64
  %c.b6 = icmp ne i64 %v199, 0
  br i1 %c.b6, label %b6.t23, label %b6.e24
b6.t23:
  br label %b36
b6.e24:
  br label %b37
b7:
  %v40 = add i64 0, 22
  %v41 = getelementptr i64, ptr %s6, i64 0
  %v42 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st24
  %st25 = getelementptr i64, ptr %v41, i64 1
  store i64 %v42, ptr %st25
  %v43 = add i64 0, 5
  %st26 = getelementptr i64, ptr %v41, i64 0
  store i64 %v43, ptr %st26
  %st27 = getelementptr i64, ptr %v41, i64 1
  store i64 %v40, ptr %st27
  %v44 = getelementptr i64, ptr %s7, i64 0
  %v45.p = getelementptr i64, ptr %v41, i64 0
  %v45 = load i64, ptr %v45.p
  %st28 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st28
  %v46.p = getelementptr i64, ptr %v41, i64 1
  %v46 = load i64, ptr %v46.p
  %st29 = getelementptr i64, ptr %v44, i64 1
  store i64 %v46, ptr %st29
  %v47 = add i64 0, 0
  %st30 = getelementptr i64, ptr %v44, i64 2
  store i64 %v47, ptr %st30
  %st31 = getelementptr i64, ptr %v44, i64 3
  store i64 %v47, ptr %st31
  %st32 = getelementptr i64, ptr %v44, i64 4
  store i64 %v47, ptr %st32
  %v48 = getelementptr i64, ptr %s8, i64 0
  %v49 = add i64 0, 1
  %st33 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st33
  %v50.p = getelementptr i64, ptr %v44, i64 0
  %v50 = load i64, ptr %v50.p
  %st34 = getelementptr i64, ptr %v48, i64 1
  store i64 %v50, ptr %st34
  %v51.p = getelementptr i64, ptr %v44, i64 1
  %v51 = load i64, ptr %v51.p
  %st35 = getelementptr i64, ptr %v48, i64 2
  store i64 %v51, ptr %st35
  %v52.p = getelementptr i64, ptr %v44, i64 2
  %v52 = load i64, ptr %v52.p
  %st36 = getelementptr i64, ptr %v48, i64 3
  store i64 %v52, ptr %st36
  %v53.p = getelementptr i64, ptr %v44, i64 3
  %v53 = load i64, ptr %v53.p
  %st37 = getelementptr i64, ptr %v48, i64 4
  store i64 %v53, ptr %st37
  %v54.p = getelementptr i64, ptr %v44, i64 4
  %v54 = load i64, ptr %v54.p
  %st38 = getelementptr i64, ptr %v48, i64 5
  store i64 %v54, ptr %st38
  %v55.p = getelementptr i64, ptr %v48, i64 0
  %v55 = load i64, ptr %v55.p
  %st39 = getelementptr i64, ptr %v36, i64 0
  store i64 %v55, ptr %st39
  %v56.p = getelementptr i64, ptr %v48, i64 1
  %v56 = load i64, ptr %v56.p
  %st40 = getelementptr i64, ptr %v36, i64 1
  store i64 %v56, ptr %st40
  %v57.p = getelementptr i64, ptr %v48, i64 2
  %v57 = load i64, ptr %v57.p
  %st41 = getelementptr i64, ptr %v36, i64 2
  store i64 %v57, ptr %st41
  %v58.p = getelementptr i64, ptr %v48, i64 3
  %v58 = load i64, ptr %v58.p
  %st42 = getelementptr i64, ptr %v36, i64 3
  store i64 %v58, ptr %st42
  %v59.p = getelementptr i64, ptr %v48, i64 4
  %v59 = load i64, ptr %v59.p
  %st43 = getelementptr i64, ptr %v36, i64 4
  store i64 %v59, ptr %st43
  %v60.p = getelementptr i64, ptr %v48, i64 5
  %v60 = load i64, ptr %v60.p
  %st44 = getelementptr i64, ptr %v36, i64 5
  store i64 %v60, ptr %st44
  %v61.p = getelementptr i64, ptr %v36, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 0
  %v63.c = icmp ne i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b7 = icmp ne i64 %v63, 0
  br i1 %c.b7, label %b7.t46, label %b7.e47
b7.t46:
  br label %b9
b7.e47:
  br label %b10
b8:
  br label %b11
b9:
  %v64 = add i64 0, 3
  %v65 = getelementptr i64, ptr %v36, i64 %v64
  %v752 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v65, i64 %v752, i64 %v37)
  br label %b10
b10:
  %v753 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v753, i64 0
  store i64 %v37, ptr %st47
  br label %b6
b11:
  %v66 = getelementptr i64, ptr %s9, i64 0
  %v67.p = getelementptr i64, ptr %v33, i64 0
  %v67 = load i64, ptr %v67.p
  %st48 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st48
  %v68 = getelementptr i64, ptr %s8, i64 0
  %v754 = getelementptr i64, ptr @"rt.meta", i64 0
  %v69.p = getelementptr i64, ptr %v754, i64 0
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v66, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = add i64 0, 65536
  %v72 = add i64 0, 2
  %v73 = call i64 @"rt.chunk_open"(i64 %v70, i64 %v71, i64 %v72, i64 %v35)
  %v755 = getelementptr i64, ptr @"rt.meta", i64 0
  %v74.p = getelementptr i64, ptr %v755, i64 0
  %v74 = load i64, ptr %v74.p
  br label %b13
b12:
  %v186.p = getelementptr i64, ptr %v68, i64 0
  %v186 = load i64, ptr %v186.p
  %st49 = getelementptr i64, ptr %v36, i64 0
  store i64 %v186, ptr %st49
  %v187.p = getelementptr i64, ptr %v68, i64 1
  %v187 = load i64, ptr %v187.p
  %st50 = getelementptr i64, ptr %v36, i64 1
  store i64 %v187, ptr %st50
  %v188.p = getelementptr i64, ptr %v68, i64 2
  %v188 = load i64, ptr %v188.p
  %st51 = getelementptr i64, ptr %v36, i64 2
  store i64 %v188, ptr %st51
  %v189.p = getelementptr i64, ptr %v68, i64 3
  %v189 = load i64, ptr %v189.p
  %st52 = getelementptr i64, ptr %v36, i64 3
  store i64 %v189, ptr %st52
  %v190.p = getelementptr i64, ptr %v68, i64 4
  %v190 = load i64, ptr %v190.p
  %st53 = getelementptr i64, ptr %v36, i64 4
  store i64 %v190, ptr %st53
  %v191.p = getelementptr i64, ptr %v68, i64 5
  %v191 = load i64, ptr %v191.p
  %st54 = getelementptr i64, ptr %v36, i64 5
  store i64 %v191, ptr %st54
  %v192.p = getelementptr i64, ptr %v36, i64 0
  %v192 = load i64, ptr %v192.p
  %v193 = add i64 0, 0
  %v194.c = icmp ne i64 %v192, %v193
  %v194 = zext i1 %v194.c to i64
  %c.b12 = icmp ne i64 %v194, 0
  br i1 %c.b12, label %b12.t56, label %b12.e57
b12.t56:
  br label %b34
b12.e57:
  br label %b35
b13:
  %v756 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v756, i64 0
  store i64 %v74, ptr %st57
  %v75 = add i64 0, 1
  %c.b13 = icmp ne i64 %v75, 0
  br i1 %c.b13, label %b13.t59, label %b13.e60
b13.t59:
  br label %b14
b13.e60:
  br label %b15
b14:
  call void @"rt.region_enter"()
  %v757 = getelementptr i64, ptr @"rt.meta", i64 0
  %v76.p = getelementptr i64, ptr %v757, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = add i64 0, 0
  %v78 = add i64 0, 0
  %v79.c = icmp ne i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b14 = icmp ne i64 %v79, 0
  br i1 %c.b14, label %b14.t61, label %b14.e62
b14.t61:
  br label %b16
b14.e62:
  br label %b17
b15:
  %v758 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v758, i64 0
  store i64 %v74, ptr %st62
  %v173 = getelementptr i64, ptr %s10, i64 0
  %v174 = add i64 0, 0
  %st63 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st63
  %v175.p = getelementptr i64, ptr %v173, i64 0
  %v175 = load i64, ptr %v175.p
  %st64 = getelementptr i64, ptr %v68, i64 0
  store i64 %v175, ptr %st64
  %v176.p = getelementptr i64, ptr %v173, i64 1
  %v176 = load i64, ptr %v176.p
  %st65 = getelementptr i64, ptr %v68, i64 1
  store i64 %v176, ptr %st65
  %v177.p = getelementptr i64, ptr %v173, i64 2
  %v177 = load i64, ptr %v177.p
  %st66 = getelementptr i64, ptr %v68, i64 2
  store i64 %v177, ptr %st66
  %v178.p = getelementptr i64, ptr %v173, i64 3
  %v178 = load i64, ptr %v178.p
  %st67 = getelementptr i64, ptr %v68, i64 3
  store i64 %v178, ptr %st67
  %v179.p = getelementptr i64, ptr %v173, i64 4
  %v179 = load i64, ptr %v179.p
  %st68 = getelementptr i64, ptr %v68, i64 4
  store i64 %v179, ptr %st68
  %v180.p = getelementptr i64, ptr %v173, i64 5
  %v180 = load i64, ptr %v180.p
  %st69 = getelementptr i64, ptr %v68, i64 5
  store i64 %v180, ptr %st69
  call void @"std/io.chunkEnd"(i64 %v73)
  %v181.p = getelementptr i64, ptr %v68, i64 0
  %v181 = load i64, ptr %v181.p
  %v182 = add i64 0, 0
  %v183.c = icmp ne i64 %v181, %v182
  %v183 = zext i1 %v183.c to i64
  %c.b15 = icmp ne i64 %v183, 0
  br i1 %c.b15, label %b15.t71, label %b15.e72
b15.t71:
  br label %b32
b15.e72:
  br label %b33
b16:
  %v80 = getelementptr i64, ptr %s6, i64 0
  %v81 = add i64 0, 0
  %st72 = getelementptr i64, ptr %v80, i64 0
  store i64 %v81, ptr %st72
  %st73 = getelementptr i64, ptr %v80, i64 1
  store i64 %v81, ptr %st73
  %v82 = add i64 0, 3
  %st74 = getelementptr i64, ptr %v80, i64 0
  store i64 %v82, ptr %st74
  %v83 = getelementptr i64, ptr %s7, i64 0
  %v84.p = getelementptr i64, ptr %v80, i64 0
  %v84 = load i64, ptr %v84.p
  %st75 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st75
  %v85.p = getelementptr i64, ptr %v80, i64 1
  %v85 = load i64, ptr %v85.p
  %st76 = getelementptr i64, ptr %v83, i64 1
  store i64 %v85, ptr %st76
  %v86 = add i64 0, 0
  %st77 = getelementptr i64, ptr %v83, i64 2
  store i64 %v86, ptr %st77
  %st78 = getelementptr i64, ptr %v83, i64 3
  store i64 %v86, ptr %st78
  %st79 = getelementptr i64, ptr %v83, i64 4
  store i64 %v86, ptr %st79
  %v87 = getelementptr i64, ptr %s10, i64 0
  %v88 = add i64 0, 1
  %st80 = getelementptr i64, ptr %v87, i64 0
  store i64 %v88, ptr %st80
  %v89.p = getelementptr i64, ptr %v83, i64 0
  %v89 = load i64, ptr %v89.p
  %st81 = getelementptr i64, ptr %v87, i64 1
  store i64 %v89, ptr %st81
  %v90.p = getelementptr i64, ptr %v83, i64 1
  %v90 = load i64, ptr %v90.p
  %st82 = getelementptr i64, ptr %v87, i64 2
  store i64 %v90, ptr %st82
  %v91.p = getelementptr i64, ptr %v83, i64 2
  %v91 = load i64, ptr %v91.p
  %st83 = getelementptr i64, ptr %v87, i64 3
  store i64 %v91, ptr %st83
  %v92.p = getelementptr i64, ptr %v83, i64 3
  %v92 = load i64, ptr %v92.p
  %st84 = getelementptr i64, ptr %v87, i64 4
  store i64 %v92, ptr %st84
  %v93.p = getelementptr i64, ptr %v83, i64 4
  %v93 = load i64, ptr %v93.p
  %st85 = getelementptr i64, ptr %v87, i64 5
  store i64 %v93, ptr %st85
  %v94.p = getelementptr i64, ptr %v87, i64 0
  %v94 = load i64, ptr %v94.p
  %st86 = getelementptr i64, ptr %v68, i64 0
  store i64 %v94, ptr %st86
  %v95.p = getelementptr i64, ptr %v87, i64 1
  %v95 = load i64, ptr %v95.p
  %st87 = getelementptr i64, ptr %v68, i64 1
  store i64 %v95, ptr %st87
  %v96.p = getelementptr i64, ptr %v87, i64 2
  %v96 = load i64, ptr %v96.p
  %st88 = getelementptr i64, ptr %v68, i64 2
  store i64 %v96, ptr %st88
  %v97.p = getelementptr i64, ptr %v87, i64 3
  %v97 = load i64, ptr %v97.p
  %st89 = getelementptr i64, ptr %v68, i64 3
  store i64 %v97, ptr %st89
  %v98.p = getelementptr i64, ptr %v87, i64 4
  %v98 = load i64, ptr %v98.p
  %st90 = getelementptr i64, ptr %v68, i64 4
  store i64 %v98, ptr %st90
  %v99.p = getelementptr i64, ptr %v87, i64 5
  %v99 = load i64, ptr %v99.p
  %st91 = getelementptr i64, ptr %v68, i64 5
  store i64 %v99, ptr %st91
  call void @"std/io.chunkEnd"(i64 %v73)
  %v100.p = getelementptr i64, ptr %v68, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 0
  %v102.c = icmp ne i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b16 = icmp ne i64 %v102, 0
  br i1 %c.b16, label %b16.t93, label %b16.e94
b16.t93:
  br label %b18
b16.e94:
  br label %b19
b17:
  br label %b20
b18:
  %v103 = add i64 0, 3
  %v104 = getelementptr i64, ptr %v68, i64 %v103
  %v759 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v104, i64 %v759, i64 %v69)
  br label %b19
b19:
  %v760 = getelementptr i64, ptr @"rt.meta", i64 0
  %st94 = getelementptr i64, ptr %v760, i64 0
  store i64 %v69, ptr %st94
  br label %b12
b20:
  %v105 = getelementptr i64, ptr %s11, i64 0
  call void @"rt.chunk_next"(i64 %v73, ptr %v105)
  %v106 = getelementptr i64, ptr %s12, i64 0
  %v107.p = getelementptr i64, ptr %v105, i64 0
  %v107 = load i64, ptr %v107.p
  %st95 = getelementptr i64, ptr %v106, i64 0
  store i64 %v107, ptr %st95
  %v108.p = getelementptr i64, ptr %v105, i64 1
  %v108 = load i64, ptr %v108.p
  %st96 = getelementptr i64, ptr %v106, i64 1
  store i64 %v108, ptr %st96
  %v109.p = getelementptr i64, ptr %v105, i64 2
  %v109 = load i64, ptr %v109.p
  %st97 = getelementptr i64, ptr %v106, i64 2
  store i64 %v109, ptr %st97
  %v110.p = getelementptr i64, ptr %v106, i64 1
  %v110 = load i64, ptr %v110.p
  %v111 = add i64 0, 0
  %v112.c = icmp eq i64 %v110, %v111
  %v112 = zext i1 %v112.c to i64
  %c.b20 = icmp ne i64 %v112, 0
  br i1 %c.b20, label %b20.t99, label %b20.e100
b20.t99:
  br label %b21
b20.e100:
  br label %b22
b21:
  %v113 = getelementptr i64, ptr @"rt.meta", i64 0
  %v114.p = getelementptr i64, ptr %v113, i64 1027
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp ne i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b21 = icmp ne i64 %v116, 0
  br i1 %c.b21, label %b21.t101, label %b21.e102
b21.t101:
  br label %b23
b21.e102:
  br label %b24
b22:
  br label %b30
b23:
  %v117 = getelementptr i64, ptr %s13, i64 0
  call void @"std/io.errOf"(ptr %v117, i64 %v114)
  %v118 = getelementptr i64, ptr %s10, i64 0
  %v119 = add i64 0, 1
  %st102 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st102
  %v120.p = getelementptr i64, ptr %v117, i64 0
  %v120 = load i64, ptr %v120.p
  %st103 = getelementptr i64, ptr %v118, i64 1
  store i64 %v120, ptr %st103
  %v121.p = getelementptr i64, ptr %v117, i64 1
  %v121 = load i64, ptr %v121.p
  %st104 = getelementptr i64, ptr %v118, i64 2
  store i64 %v121, ptr %st104
  %v122.p = getelementptr i64, ptr %v117, i64 2
  %v122 = load i64, ptr %v122.p
  %st105 = getelementptr i64, ptr %v118, i64 3
  store i64 %v122, ptr %st105
  %v123.p = getelementptr i64, ptr %v117, i64 3
  %v123 = load i64, ptr %v123.p
  %st106 = getelementptr i64, ptr %v118, i64 4
  store i64 %v123, ptr %st106
  %v124.p = getelementptr i64, ptr %v117, i64 4
  %v124 = load i64, ptr %v124.p
  %st107 = getelementptr i64, ptr %v118, i64 5
  store i64 %v124, ptr %st107
  %v125.p = getelementptr i64, ptr %v118, i64 0
  %v125 = load i64, ptr %v125.p
  %st108 = getelementptr i64, ptr %v68, i64 0
  store i64 %v125, ptr %st108
  %v126.p = getelementptr i64, ptr %v118, i64 1
  %v126 = load i64, ptr %v126.p
  %st109 = getelementptr i64, ptr %v68, i64 1
  store i64 %v126, ptr %st109
  %v127.p = getelementptr i64, ptr %v118, i64 2
  %v127 = load i64, ptr %v127.p
  %st110 = getelementptr i64, ptr %v68, i64 2
  store i64 %v127, ptr %st110
  %v128.p = getelementptr i64, ptr %v118, i64 3
  %v128 = load i64, ptr %v128.p
  %st111 = getelementptr i64, ptr %v68, i64 3
  store i64 %v128, ptr %st111
  %v129.p = getelementptr i64, ptr %v118, i64 4
  %v129 = load i64, ptr %v129.p
  %st112 = getelementptr i64, ptr %v68, i64 4
  store i64 %v129, ptr %st112
  %v130.p = getelementptr i64, ptr %v118, i64 5
  %v130 = load i64, ptr %v130.p
  %st113 = getelementptr i64, ptr %v68, i64 5
  store i64 %v130, ptr %st113
  call void @"std/io.chunkEnd"(i64 %v73)
  %v131.p = getelementptr i64, ptr %v68, i64 0
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 0, 0
  %v133.c = icmp ne i64 %v131, %v132
  %v133 = zext i1 %v133.c to i64
  %c.b23 = icmp ne i64 %v133, 0
  br i1 %c.b23, label %b23.t115, label %b23.e116
b23.t115:
  br label %b25
b23.e116:
  br label %b26
b24:
  br label %b27
b25:
  %v134 = add i64 0, 3
  %v135 = getelementptr i64, ptr %v68, i64 %v134
  %v761 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v135, i64 %v761, i64 %v69)
  br label %b26
b26:
  %v762 = getelementptr i64, ptr @"rt.meta", i64 0
  %st116 = getelementptr i64, ptr %v762, i64 0
  store i64 %v69, ptr %st116
  br label %b12
b27:
  %v136 = getelementptr i64, ptr %s10, i64 0
  %v137 = add i64 0, 0
  %st117 = getelementptr i64, ptr %v136, i64 0
  store i64 %v137, ptr %st117
  %v138.p = getelementptr i64, ptr %v136, i64 0
  %v138 = load i64, ptr %v138.p
  %st118 = getelementptr i64, ptr %v68, i64 0
  store i64 %v138, ptr %st118
  %v139.p = getelementptr i64, ptr %v136, i64 1
  %v139 = load i64, ptr %v139.p
  %st119 = getelementptr i64, ptr %v68, i64 1
  store i64 %v139, ptr %st119
  %v140.p = getelementptr i64, ptr %v136, i64 2
  %v140 = load i64, ptr %v140.p
  %st120 = getelementptr i64, ptr %v68, i64 2
  store i64 %v140, ptr %st120
  %v141.p = getelementptr i64, ptr %v136, i64 3
  %v141 = load i64, ptr %v141.p
  %st121 = getelementptr i64, ptr %v68, i64 3
  store i64 %v141, ptr %st121
  %v142.p = getelementptr i64, ptr %v136, i64 4
  %v142 = load i64, ptr %v142.p
  %st122 = getelementptr i64, ptr %v68, i64 4
  store i64 %v142, ptr %st122
  %v143.p = getelementptr i64, ptr %v136, i64 5
  %v143 = load i64, ptr %v143.p
  %st123 = getelementptr i64, ptr %v68, i64 5
  store i64 %v143, ptr %st123
  call void @"std/io.chunkEnd"(i64 %v73)
  %v144.p = getelementptr i64, ptr %v68, i64 0
  %v144 = load i64, ptr %v144.p
  %v145 = add i64 0, 0
  %v146.c = icmp ne i64 %v144, %v145
  %v146 = zext i1 %v146.c to i64
  %c.b27 = icmp ne i64 %v146, 0
  br i1 %c.b27, label %b27.t125, label %b27.e126
b27.t125:
  br label %b28
b27.e126:
  br label %b29
b28:
  %v147 = add i64 0, 3
  %v148 = getelementptr i64, ptr %v68, i64 %v147
  %v763 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v148, i64 %v763, i64 %v69)
  br label %b29
b29:
  %v764 = getelementptr i64, ptr @"rt.meta", i64 0
  %st126 = getelementptr i64, ptr %v764, i64 0
  store i64 %v69, ptr %st126
  br label %b12
b30:
  %v149 = getelementptr i64, ptr %s11, i64 0
  %v150.p = getelementptr i64, ptr %v106, i64 0
  %v150 = load i64, ptr %v150.p
  %st127 = getelementptr i64, ptr %v149, i64 0
  store i64 %v150, ptr %st127
  %v151.p = getelementptr i64, ptr %v106, i64 1
  %v151 = load i64, ptr %v151.p
  %st128 = getelementptr i64, ptr %v149, i64 1
  store i64 %v151, ptr %st128
  %v152.p = getelementptr i64, ptr %v106, i64 2
  %v152 = load i64, ptr %v152.p
  %st129 = getelementptr i64, ptr %v149, i64 2
  store i64 %v152, ptr %st129
  %v153 = getelementptr i64, ptr %s14, i64 0
  %v154 = add i64 0, 0
  %v155 = getelementptr i64, ptr %s15, i64 0
  %v156 = getelementptr i64, ptr %s16, i64 0
  %v157 = add i64 0, 0
  %st130 = getelementptr i64, ptr %v156, i64 0
  store i64 %v157, ptr %st130
  %st131 = getelementptr i64, ptr %v156, i64 1
  store i64 %v157, ptr %st131
  %st132 = getelementptr i64, ptr %v156, i64 2
  store i64 %v157, ptr %st132
  %v158.p = getelementptr i64, ptr %v149, i64 0
  %v158 = load i64, ptr %v158.p
  %st133 = getelementptr i64, ptr %v156, i64 0
  store i64 %v158, ptr %st133
  %v159.p = getelementptr i64, ptr %v149, i64 1
  %v159 = load i64, ptr %v159.p
  %st134 = getelementptr i64, ptr %v156, i64 1
  store i64 %v159, ptr %st134
  %v160.p = getelementptr i64, ptr %v149, i64 2
  %v160 = load i64, ptr %v160.p
  %st135 = getelementptr i64, ptr %v156, i64 2
  store i64 %v160, ptr %st135
  %v161 = getelementptr i64, ptr %s17, i64 0
  %v162.p = getelementptr i64, ptr %v156, i64 0
  %v162 = load i64, ptr %v162.p
  %st136 = getelementptr i64, ptr %v161, i64 0
  store i64 %v162, ptr %st136
  %v163.p = getelementptr i64, ptr %v156, i64 1
  %v163 = load i64, ptr %v163.p
  %st137 = getelementptr i64, ptr %v161, i64 1
  store i64 %v163, ptr %st137
  %v164.p = getelementptr i64, ptr %v156, i64 2
  %v164 = load i64, ptr %v164.p
  %st138 = getelementptr i64, ptr %v161, i64 2
  store i64 %v164, ptr %st138
  %v765 = getelementptr i64, ptr @"rt.meta", i64 0
  %v165.p = getelementptr i64, ptr %v765, i64 0
  %v165 = load i64, ptr %v165.p
  %v166 = getelementptr i64, ptr %s18, i64 0
  %v167.p = getelementptr i64, ptr %v161, i64 0
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v161, i64 1
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v161, i64 2
  %v169 = load i64, ptr %v169.p
  call void @"std/io.Raw"(ptr %v166, i64 %v167, i64 %v168, i64 %v169)
  %v170.p = getelementptr i64, ptr %v166, i64 1
  %v170 = load i64, ptr %v170.p
  %v171.p = getelementptr i64, ptr %v31, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = add i64 %v171, %v170
  %st139 = getelementptr i64, ptr %v31, i64 0
  store i64 %v172, ptr %st139
  br label %b31
b31:
  %v766 = getelementptr i64, ptr @"rt.meta", i64 0
  %st140 = getelementptr i64, ptr %v766, i64 0
  store i64 %v165, ptr %st140
  br label %b13
b32:
  %v184 = add i64 0, 3
  %v185 = getelementptr i64, ptr %v68, i64 %v184
  %v767 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v185, i64 %v767, i64 %v69)
  br label %b33
b33:
  %v768 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v768, i64 0
  store i64 %v69, ptr %st141
  br label %b12
b34:
  %v195 = add i64 0, 3
  %v196 = getelementptr i64, ptr %v36, i64 %v195
  %v769 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v196, i64 %v769, i64 %v37)
  br label %b35
b35:
  %v770 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v770, i64 0
  store i64 %v37, ptr %st142
  br label %b6
b36:
  %v200 = add i64 0, 0
  %v201.p = getelementptr i64, ptr %v36, i64 0
  %v201 = load i64, ptr %v201.p
  %st143 = getelementptr i64, ptr %v0, i64 0
  store i64 %v201, ptr %st143
  %v202.p = getelementptr i64, ptr %v36, i64 1
  %v202 = load i64, ptr %v202.p
  %st144 = getelementptr i64, ptr %v0, i64 1
  store i64 %v202, ptr %st144
  %v203.p = getelementptr i64, ptr %v36, i64 2
  %v203 = load i64, ptr %v203.p
  %st145 = getelementptr i64, ptr %v0, i64 2
  store i64 %v203, ptr %st145
  %v204.p = getelementptr i64, ptr %v36, i64 3
  %v204 = load i64, ptr %v204.p
  %st146 = getelementptr i64, ptr %v0, i64 3
  store i64 %v204, ptr %st146
  %v205.p = getelementptr i64, ptr %v36, i64 4
  %v205 = load i64, ptr %v205.p
  %st147 = getelementptr i64, ptr %v0, i64 4
  store i64 %v205, ptr %st147
  %v206.p = getelementptr i64, ptr %v36, i64 5
  %v206 = load i64, ptr %v206.p
  %st148 = getelementptr i64, ptr %v0, i64 5
  store i64 %v206, ptr %st148
  %v207.p = getelementptr i64, ptr %v28, i64 0
  %v207 = load i64, ptr %v207.p
  call void @"std/io.Close"(i64 %v207)
  %v208.p = getelementptr i64, ptr %v0, i64 0
  %v208 = load i64, ptr %v208.p
  %v209 = add i64 0, 0
  %v210.c = icmp ne i64 %v208, %v209
  %v210 = zext i1 %v210.c to i64
  %c.b36 = icmp ne i64 %v210, 0
  br i1 %c.b36, label %b36.t150, label %b36.e151
b36.t150:
  br label %b38
b36.e151:
  br label %b39
b37:
  br label %b5
b38:
  %v211 = add i64 0, 3
  %v212 = getelementptr i64, ptr %v0, i64 %v211
  %v771 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v212, i64 %v771, i64 %v6)
  br label %b39
b39:
  %v772 = getelementptr i64, ptr @"rt.meta", i64 0
  %st151 = getelementptr i64, ptr %v772, i64 0
  store i64 %v6, ptr %st151
  ret void
b40:
  %v220 = add i64 0, 0
  %v221.p = getelementptr i64, ptr %v216, i64 0
  %v221 = load i64, ptr %v221.p
  %st152 = getelementptr i64, ptr %v0, i64 0
  store i64 %v221, ptr %st152
  %v222.p = getelementptr i64, ptr %v216, i64 1
  %v222 = load i64, ptr %v222.p
  %st153 = getelementptr i64, ptr %v0, i64 1
  store i64 %v222, ptr %st153
  %v223.p = getelementptr i64, ptr %v216, i64 2
  %v223 = load i64, ptr %v223.p
  %st154 = getelementptr i64, ptr %v0, i64 2
  store i64 %v223, ptr %st154
  %v224.p = getelementptr i64, ptr %v216, i64 3
  %v224 = load i64, ptr %v224.p
  %st155 = getelementptr i64, ptr %v0, i64 3
  store i64 %v224, ptr %st155
  %v225.p = getelementptr i64, ptr %v216, i64 4
  %v225 = load i64, ptr %v225.p
  %st156 = getelementptr i64, ptr %v0, i64 4
  store i64 %v225, ptr %st156
  %v226.p = getelementptr i64, ptr %v216, i64 5
  %v226 = load i64, ptr %v226.p
  %st157 = getelementptr i64, ptr %v0, i64 5
  store i64 %v226, ptr %st157
  %v227.p = getelementptr i64, ptr %v28, i64 0
  %v227 = load i64, ptr %v227.p
  call void @"std/io.Close"(i64 %v227)
  %v228.p = getelementptr i64, ptr %v0, i64 0
  %v228 = load i64, ptr %v228.p
  %v229 = add i64 0, 0
  %v230.c = icmp ne i64 %v228, %v229
  %v230 = zext i1 %v230.c to i64
  %c.b40 = icmp ne i64 %v230, 0
  br i1 %c.b40, label %b40.t159, label %b40.e160
b40.t159:
  br label %b42
b40.e160:
  br label %b43
b41:
  %v233 = getelementptr i64, ptr %s17, i64 0
  %v234.p = getelementptr i64, ptr %v213, i64 0
  %v234 = load i64, ptr %v234.p
  %st160 = getelementptr i64, ptr %v233, i64 0
  store i64 %v234, ptr %st160
  %v235.p = getelementptr i64, ptr %v213, i64 1
  %v235 = load i64, ptr %v235.p
  %st161 = getelementptr i64, ptr %v233, i64 1
  store i64 %v235, ptr %st161
  %v236.p = getelementptr i64, ptr %v213, i64 2
  %v236 = load i64, ptr %v236.p
  %st162 = getelementptr i64, ptr %v233, i64 2
  store i64 %v236, ptr %st162
  %v237.p = getelementptr i64, ptr %v31, i64 0
  %v237 = load i64, ptr %v237.p
  %v238.p = getelementptr i64, ptr %v233, i64 1
  %v238 = load i64, ptr %v238.p
  %v239 = getelementptr i64, ptr @"str.9", i64 0
  %v240 = add i64 0, 13
  %v241 = add i64 0, 0
  %v242 = getelementptr i64, ptr %s16, i64 0
  %v243 = ptrtoint ptr %v239 to i64
  %st163 = getelementptr i64, ptr %v242, i64 0
  store i64 %v243, ptr %st163
  %st164 = getelementptr i64, ptr %v242, i64 1
  store i64 %v240, ptr %st164
  %st165 = getelementptr i64, ptr %v242, i64 2
  store i64 %v241, ptr %st165
  %v244 = getelementptr i64, ptr %s20, i64 0
  call void @"std/convert.FormatInt"(ptr %v244, i64 %v237)
  %v245.p = getelementptr i64, ptr %v242, i64 1
  %v245 = load i64, ptr %v245.p
  %v246.p = getelementptr i64, ptr %v244, i64 1
  %v246 = load i64, ptr %v246.p
  %v247 = add i64 %v245, %v246
  %v773 = getelementptr i64, ptr @"rt.meta", i64 0
  %v248.p = getelementptr i64, ptr %v773, i64 0
  %v248 = load i64, ptr %v248.p
  %v249.p = getelementptr i64, ptr %v242, i64 0
  %v249 = load i64, ptr %v249.p
  %v250.p = getelementptr i64, ptr %v242, i64 1
  %v250 = load i64, ptr %v250.p
  %v251.p = getelementptr i64, ptr %v242, i64 2
  %v251 = load i64, ptr %v251.p
  %v252 = call ptr @"rt.cat8"(i64 %v249, i64 %v250, i64 %v251, i64 %v248, i64 %v246)
  %v253 = getelementptr i8, ptr %v252, i64 %v245
  %v254.p = getelementptr i64, ptr %v244, i64 0
  %v254 = load i64, ptr %v254.p
  %v255 = inttoptr i64 %v254 to ptr
  call void @"rt.copy8"(ptr %v253, ptr %v255, i64 %v246)
  %v256 = getelementptr i64, ptr %s11, i64 0
  %v257 = ptrtoint ptr %v252 to i64
  %st166 = getelementptr i64, ptr %v256, i64 0
  store i64 %v257, ptr %st166
  %st167 = getelementptr i64, ptr %v256, i64 1
  store i64 %v247, ptr %st167
  %st168 = getelementptr i64, ptr %v256, i64 2
  store i64 %v248, ptr %st168
  %v258 = getelementptr i64, ptr @"str.10", i64 0
  %v259 = add i64 0, 22
  %v260 = add i64 0, 0
  %v261 = getelementptr i64, ptr %s12, i64 0
  %v262 = ptrtoint ptr %v258 to i64
  %st169 = getelementptr i64, ptr %v261, i64 0
  store i64 %v262, ptr %st169
  %st170 = getelementptr i64, ptr %v261, i64 1
  store i64 %v259, ptr %st170
  %st171 = getelementptr i64, ptr %v261, i64 2
  store i64 %v260, ptr %st171
  %v263.p = getelementptr i64, ptr %v256, i64 1
  %v263 = load i64, ptr %v263.p
  %v264.p = getelementptr i64, ptr %v261, i64 1
  %v264 = load i64, ptr %v264.p
  %v265 = add i64 %v263, %v264
  %v774 = getelementptr i64, ptr @"rt.meta", i64 0
  %v266.p = getelementptr i64, ptr %v774, i64 0
  %v266 = load i64, ptr %v266.p
  %v267.p = getelementptr i64, ptr %v256, i64 0
  %v267 = load i64, ptr %v267.p
  %v268.p = getelementptr i64, ptr %v256, i64 1
  %v268 = load i64, ptr %v268.p
  %v269.p = getelementptr i64, ptr %v256, i64 2
  %v269 = load i64, ptr %v269.p
  %v270 = call ptr @"rt.cat8"(i64 %v267, i64 %v268, i64 %v269, i64 %v266, i64 %v264)
  %v271 = getelementptr i8, ptr %v270, i64 %v263
  %v272.p = getelementptr i64, ptr %v261, i64 0
  %v272 = load i64, ptr %v272.p
  %v273 = inttoptr i64 %v272 to ptr
  call void @"rt.copy8"(ptr %v271, ptr %v273, i64 %v264)
  %v274 = getelementptr i64, ptr %s21, i64 0
  %v275 = ptrtoint ptr %v270 to i64
  %st172 = getelementptr i64, ptr %v274, i64 0
  store i64 %v275, ptr %st172
  %st173 = getelementptr i64, ptr %v274, i64 1
  store i64 %v265, ptr %st173
  %st174 = getelementptr i64, ptr %v274, i64 2
  store i64 %v266, ptr %st174
  %v276 = getelementptr i64, ptr %s22, i64 0
  call void @"std/convert.FormatInt"(ptr %v276, i64 %v238)
  %v277.p = getelementptr i64, ptr %v274, i64 1
  %v277 = load i64, ptr %v277.p
  %v278.p = getelementptr i64, ptr %v276, i64 1
  %v278 = load i64, ptr %v278.p
  %v279 = add i64 %v277, %v278
  %v775 = getelementptr i64, ptr @"rt.meta", i64 0
  %v280.p = getelementptr i64, ptr %v775, i64 0
  %v280 = load i64, ptr %v280.p
  %v281.p = getelementptr i64, ptr %v274, i64 0
  %v281 = load i64, ptr %v281.p
  %v282.p = getelementptr i64, ptr %v274, i64 1
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v274, i64 2
  %v283 = load i64, ptr %v283.p
  %v284 = call ptr @"rt.cat8"(i64 %v281, i64 %v282, i64 %v283, i64 %v280, i64 %v278)
  %v285 = getelementptr i8, ptr %v284, i64 %v277
  %v286.p = getelementptr i64, ptr %v276, i64 0
  %v286 = load i64, ptr %v286.p
  %v287 = inttoptr i64 %v286 to ptr
  call void @"rt.copy8"(ptr %v285, ptr %v287, i64 %v278)
  %v288 = getelementptr i64, ptr %s23, i64 0
  %v289 = ptrtoint ptr %v284 to i64
  %st175 = getelementptr i64, ptr %v288, i64 0
  store i64 %v289, ptr %st175
  %st176 = getelementptr i64, ptr %v288, i64 1
  store i64 %v279, ptr %st176
  %st177 = getelementptr i64, ptr %v288, i64 2
  store i64 %v280, ptr %st177
  %v290 = getelementptr i64, ptr @"str.5", i64 0
  %v291 = add i64 0, 6
  %v292 = add i64 0, 0
  %v293 = getelementptr i64, ptr %s24, i64 0
  %v294 = ptrtoint ptr %v290 to i64
  %st178 = getelementptr i64, ptr %v293, i64 0
  store i64 %v294, ptr %st178
  %st179 = getelementptr i64, ptr %v293, i64 1
  store i64 %v291, ptr %st179
  %st180 = getelementptr i64, ptr %v293, i64 2
  store i64 %v292, ptr %st180
  %v295.p = getelementptr i64, ptr %v288, i64 1
  %v295 = load i64, ptr %v295.p
  %v296.p = getelementptr i64, ptr %v293, i64 1
  %v296 = load i64, ptr %v296.p
  %v297 = add i64 %v295, %v296
  %v776 = getelementptr i64, ptr @"rt.meta", i64 0
  %v298.p = getelementptr i64, ptr %v776, i64 0
  %v298 = load i64, ptr %v298.p
  %v299.p = getelementptr i64, ptr %v288, i64 0
  %v299 = load i64, ptr %v299.p
  %v300.p = getelementptr i64, ptr %v288, i64 1
  %v300 = load i64, ptr %v300.p
  %v301.p = getelementptr i64, ptr %v288, i64 2
  %v301 = load i64, ptr %v301.p
  %v302 = call ptr @"rt.cat8"(i64 %v299, i64 %v300, i64 %v301, i64 %v298, i64 %v296)
  %v303 = getelementptr i8, ptr %v302, i64 %v295
  %v304.p = getelementptr i64, ptr %v293, i64 0
  %v304 = load i64, ptr %v304.p
  %v305 = inttoptr i64 %v304 to ptr
  call void @"rt.copy8"(ptr %v303, ptr %v305, i64 %v296)
  %v306 = getelementptr i64, ptr %s25, i64 0
  %v307 = ptrtoint ptr %v302 to i64
  %st181 = getelementptr i64, ptr %v306, i64 0
  store i64 %v307, ptr %st181
  %st182 = getelementptr i64, ptr %v306, i64 1
  store i64 %v297, ptr %st182
  %st183 = getelementptr i64, ptr %v306, i64 2
  store i64 %v298, ptr %st183
  call void @"rt.print_str"(ptr %v306)
  %v308 = add i64 0, 10
  call void @"rt.print_char"(i64 %v308)
  %v309 = add i64 0, 0
  %v310 = getelementptr i64, ptr %s4, i64 0
  %st184 = getelementptr i64, ptr %v310, i64 0
  store i64 %v309, ptr %st184
  %v777 = getelementptr i64, ptr @"rt.meta", i64 0
  %v311.p = getelementptr i64, ptr %v777, i64 0
  %v311 = load i64, ptr %v311.p
  %v312 = getelementptr i64, ptr %s9, i64 0
  %v313.p = getelementptr i64, ptr %v28, i64 0
  %v313 = load i64, ptr %v313.p
  %st185 = getelementptr i64, ptr %v312, i64 0
  store i64 %v313, ptr %st185
  %v314 = getelementptr i64, ptr %s10, i64 0
  %v778 = getelementptr i64, ptr @"rt.meta", i64 0
  %v315.p = getelementptr i64, ptr %v778, i64 0
  %v315 = load i64, ptr %v315.p
  %v316 = add i64 0, 0
  %v317.c = icmp slt i64 %v4, %v316
  %v317 = zext i1 %v317.c to i64
  %c.b41 = icmp ne i64 %v317, 0
  br i1 %c.b41, label %b41.t187, label %b41.e188
b41.t187:
  br label %b46
b41.e188:
  br label %b47
b42:
  %v231 = add i64 0, 3
  %v232 = getelementptr i64, ptr %v0, i64 %v231
  %v779 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v232, i64 %v779, i64 %v6)
  br label %b43
b43:
  %v780 = getelementptr i64, ptr @"rt.meta", i64 0
  %st188 = getelementptr i64, ptr %v780, i64 0
  store i64 %v6, ptr %st188
  ret void
b44:
  %v781 = getelementptr i64, ptr @"rt.meta", i64 0
  %st189 = getelementptr i64, ptr %v781, i64 0
  store i64 %v311, ptr %st189
  %v487.p = getelementptr i64, ptr %v310, i64 0
  %v487 = load i64, ptr %v487.p
  %v488 = getelementptr i64, ptr @"str.11", i64 0
  %v489 = add i64 0, 12
  %v490 = add i64 0, 0
  %v491 = getelementptr i64, ptr %s21, i64 0
  %v492 = ptrtoint ptr %v488 to i64
  %st190 = getelementptr i64, ptr %v491, i64 0
  store i64 %v492, ptr %st190
  %st191 = getelementptr i64, ptr %v491, i64 1
  store i64 %v489, ptr %st191
  %st192 = getelementptr i64, ptr %v491, i64 2
  store i64 %v490, ptr %st192
  %v493 = getelementptr i64, ptr %s30, i64 0
  call void @"std/convert.FormatInt"(ptr %v493, i64 %v487)
  %v494.p = getelementptr i64, ptr %v491, i64 1
  %v494 = load i64, ptr %v494.p
  %v495.p = getelementptr i64, ptr %v493, i64 1
  %v495 = load i64, ptr %v495.p
  %v496 = add i64 %v494, %v495
  %v782 = getelementptr i64, ptr @"rt.meta", i64 0
  %v497.p = getelementptr i64, ptr %v782, i64 0
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
  %v505 = getelementptr i64, ptr %s23, i64 0
  %v506 = ptrtoint ptr %v501 to i64
  %st193 = getelementptr i64, ptr %v505, i64 0
  store i64 %v506, ptr %st193
  %st194 = getelementptr i64, ptr %v505, i64 1
  store i64 %v496, ptr %st194
  %st195 = getelementptr i64, ptr %v505, i64 2
  store i64 %v497, ptr %st195
  %v507 = getelementptr i64, ptr @"str.12", i64 0
  %v508 = add i64 0, 6
  %v509 = add i64 0, 0
  %v510 = getelementptr i64, ptr %s25, i64 0
  %v511 = ptrtoint ptr %v507 to i64
  %st196 = getelementptr i64, ptr %v510, i64 0
  store i64 %v511, ptr %st196
  %st197 = getelementptr i64, ptr %v510, i64 1
  store i64 %v508, ptr %st197
  %st198 = getelementptr i64, ptr %v510, i64 2
  store i64 %v509, ptr %st198
  %v512.p = getelementptr i64, ptr %v505, i64 1
  %v512 = load i64, ptr %v512.p
  %v513.p = getelementptr i64, ptr %v510, i64 1
  %v513 = load i64, ptr %v513.p
  %v514 = add i64 %v512, %v513
  %v783 = getelementptr i64, ptr @"rt.meta", i64 0
  %v515.p = getelementptr i64, ptr %v783, i64 0
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
  %v523 = getelementptr i64, ptr %s24, i64 0
  %v524 = ptrtoint ptr %v519 to i64
  %st199 = getelementptr i64, ptr %v523, i64 0
  store i64 %v524, ptr %st199
  %st200 = getelementptr i64, ptr %v523, i64 1
  store i64 %v514, ptr %st200
  %st201 = getelementptr i64, ptr %v523, i64 2
  store i64 %v515, ptr %st201
  call void @"rt.print_str"(ptr %v523)
  %v525 = add i64 0, 10
  call void @"rt.print_char"(i64 %v525)
  %v526 = getelementptr i64, ptr %s9, i64 0
  %v527.p = getelementptr i64, ptr %v28, i64 0
  %v527 = load i64, ptr %v527.p
  %st202 = getelementptr i64, ptr %v526, i64 0
  store i64 %v527, ptr %st202
  %v528 = add i64 0, 1
  %v529 = add i64 0, 0
  %v530 = sub i64 %v529, %v528
  %v531 = getelementptr i64, ptr %s27, i64 0
  %v784 = getelementptr i64, ptr @"rt.meta", i64 0
  %v532.p = getelementptr i64, ptr %v784, i64 0
  %v532 = load i64, ptr %v532.p
  %v533 = add i64 0, 0
  %v534.c = icmp slt i64 %v530, %v533
  %v534 = zext i1 %v534.c to i64
  %c.b44 = icmp ne i64 %v534, 0
  br i1 %c.b44, label %b44.t204, label %b44.e205
b44.t204:
  br label %b80
b44.e205:
  br label %b81
b45:
  %v471.p = getelementptr i64, ptr %v314, i64 0
  %v471 = load i64, ptr %v471.p
  %v472 = add i64 0, 0
  %v473.c = icmp ne i64 %v471, %v472
  %v473 = zext i1 %v473.c to i64
  %c.b45 = icmp ne i64 %v473, 0
  br i1 %c.b45, label %b45.t206, label %b45.e207
b45.t206:
  br label %b75
b45.e207:
  br label %b76
b46:
  %v318 = add i64 0, 22
  %v319 = getelementptr i64, ptr %s6, i64 0
  %v320 = add i64 0, 0
  %st207 = getelementptr i64, ptr %v319, i64 0
  store i64 %v320, ptr %st207
  %st208 = getelementptr i64, ptr %v319, i64 1
  store i64 %v320, ptr %st208
  %v321 = add i64 0, 5
  %st209 = getelementptr i64, ptr %v319, i64 0
  store i64 %v321, ptr %st209
  %st210 = getelementptr i64, ptr %v319, i64 1
  store i64 %v318, ptr %st210
  %v322 = getelementptr i64, ptr %s7, i64 0
  %v323.p = getelementptr i64, ptr %v319, i64 0
  %v323 = load i64, ptr %v323.p
  %st211 = getelementptr i64, ptr %v322, i64 0
  store i64 %v323, ptr %st211
  %v324.p = getelementptr i64, ptr %v319, i64 1
  %v324 = load i64, ptr %v324.p
  %st212 = getelementptr i64, ptr %v322, i64 1
  store i64 %v324, ptr %st212
  %v325 = add i64 0, 0
  %st213 = getelementptr i64, ptr %v322, i64 2
  store i64 %v325, ptr %st213
  %st214 = getelementptr i64, ptr %v322, i64 3
  store i64 %v325, ptr %st214
  %st215 = getelementptr i64, ptr %v322, i64 4
  store i64 %v325, ptr %st215
  %v326 = getelementptr i64, ptr %s26, i64 0
  %v327 = add i64 0, 1
  %st216 = getelementptr i64, ptr %v326, i64 0
  store i64 %v327, ptr %st216
  %v328.p = getelementptr i64, ptr %v322, i64 0
  %v328 = load i64, ptr %v328.p
  %st217 = getelementptr i64, ptr %v326, i64 1
  store i64 %v328, ptr %st217
  %v329.p = getelementptr i64, ptr %v322, i64 1
  %v329 = load i64, ptr %v329.p
  %st218 = getelementptr i64, ptr %v326, i64 2
  store i64 %v329, ptr %st218
  %v330.p = getelementptr i64, ptr %v322, i64 2
  %v330 = load i64, ptr %v330.p
  %st219 = getelementptr i64, ptr %v326, i64 3
  store i64 %v330, ptr %st219
  %v331.p = getelementptr i64, ptr %v322, i64 3
  %v331 = load i64, ptr %v331.p
  %st220 = getelementptr i64, ptr %v326, i64 4
  store i64 %v331, ptr %st220
  %v332.p = getelementptr i64, ptr %v322, i64 4
  %v332 = load i64, ptr %v332.p
  %st221 = getelementptr i64, ptr %v326, i64 5
  store i64 %v332, ptr %st221
  %v333.p = getelementptr i64, ptr %v326, i64 0
  %v333 = load i64, ptr %v333.p
  %st222 = getelementptr i64, ptr %v314, i64 0
  store i64 %v333, ptr %st222
  %v334.p = getelementptr i64, ptr %v326, i64 1
  %v334 = load i64, ptr %v334.p
  %st223 = getelementptr i64, ptr %v314, i64 1
  store i64 %v334, ptr %st223
  %v335.p = getelementptr i64, ptr %v326, i64 2
  %v335 = load i64, ptr %v335.p
  %st224 = getelementptr i64, ptr %v314, i64 2
  store i64 %v335, ptr %st224
  %v336.p = getelementptr i64, ptr %v326, i64 3
  %v336 = load i64, ptr %v336.p
  %st225 = getelementptr i64, ptr %v314, i64 3
  store i64 %v336, ptr %st225
  %v337.p = getelementptr i64, ptr %v326, i64 4
  %v337 = load i64, ptr %v337.p
  %st226 = getelementptr i64, ptr %v314, i64 4
  store i64 %v337, ptr %st226
  %v338.p = getelementptr i64, ptr %v326, i64 5
  %v338 = load i64, ptr %v338.p
  %st227 = getelementptr i64, ptr %v314, i64 5
  store i64 %v338, ptr %st227
  %v339.p = getelementptr i64, ptr %v314, i64 0
  %v339 = load i64, ptr %v339.p
  %v340 = add i64 0, 0
  %v341.c = icmp ne i64 %v339, %v340
  %v341 = zext i1 %v341.c to i64
  %c.b46 = icmp ne i64 %v341, 0
  br i1 %c.b46, label %b46.t229, label %b46.e230
b46.t229:
  br label %b48
b46.e230:
  br label %b49
b47:
  br label %b50
b48:
  %v342 = add i64 0, 3
  %v343 = getelementptr i64, ptr %v314, i64 %v342
  %v785 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v343, i64 %v785, i64 %v315)
  br label %b49
b49:
  %v786 = getelementptr i64, ptr @"rt.meta", i64 0
  %st230 = getelementptr i64, ptr %v786, i64 0
  store i64 %v315, ptr %st230
  br label %b45
b50:
  %v344 = getelementptr i64, ptr %s15, i64 0
  %v345.p = getelementptr i64, ptr %v312, i64 0
  %v345 = load i64, ptr %v345.p
  %st231 = getelementptr i64, ptr %v344, i64 0
  store i64 %v345, ptr %st231
  %v346 = getelementptr i64, ptr %s26, i64 0
  %v787 = getelementptr i64, ptr @"rt.meta", i64 0
  %v347.p = getelementptr i64, ptr %v787, i64 0
  %v347 = load i64, ptr %v347.p
  %v348.p = getelementptr i64, ptr %v344, i64 0
  %v348 = load i64, ptr %v348.p
  %v349 = add i64 0, 65536
  %v350 = add i64 0, 2
  %v351 = call i64 @"rt.chunk_open"(i64 %v348, i64 %v349, i64 %v350, i64 %v4)
  %v788 = getelementptr i64, ptr @"rt.meta", i64 0
  %v352.p = getelementptr i64, ptr %v788, i64 0
  %v352 = load i64, ptr %v352.p
  br label %b52
b51:
  %v460.p = getelementptr i64, ptr %v346, i64 0
  %v460 = load i64, ptr %v460.p
  %st232 = getelementptr i64, ptr %v314, i64 0
  store i64 %v460, ptr %st232
  %v461.p = getelementptr i64, ptr %v346, i64 1
  %v461 = load i64, ptr %v461.p
  %st233 = getelementptr i64, ptr %v314, i64 1
  store i64 %v461, ptr %st233
  %v462.p = getelementptr i64, ptr %v346, i64 2
  %v462 = load i64, ptr %v462.p
  %st234 = getelementptr i64, ptr %v314, i64 2
  store i64 %v462, ptr %st234
  %v463.p = getelementptr i64, ptr %v346, i64 3
  %v463 = load i64, ptr %v463.p
  %st235 = getelementptr i64, ptr %v314, i64 3
  store i64 %v463, ptr %st235
  %v464.p = getelementptr i64, ptr %v346, i64 4
  %v464 = load i64, ptr %v464.p
  %st236 = getelementptr i64, ptr %v314, i64 4
  store i64 %v464, ptr %st236
  %v465.p = getelementptr i64, ptr %v346, i64 5
  %v465 = load i64, ptr %v465.p
  %st237 = getelementptr i64, ptr %v314, i64 5
  store i64 %v465, ptr %st237
  %v466.p = getelementptr i64, ptr %v314, i64 0
  %v466 = load i64, ptr %v466.p
  %v467 = add i64 0, 0
  %v468.c = icmp ne i64 %v466, %v467
  %v468 = zext i1 %v468.c to i64
  %c.b51 = icmp ne i64 %v468, 0
  br i1 %c.b51, label %b51.t239, label %b51.e240
b51.t239:
  br label %b73
b51.e240:
  br label %b74
b52:
  %v789 = getelementptr i64, ptr @"rt.meta", i64 0
  %st240 = getelementptr i64, ptr %v789, i64 0
  store i64 %v352, ptr %st240
  %v353 = add i64 0, 1
  %c.b52 = icmp ne i64 %v353, 0
  br i1 %c.b52, label %b52.t242, label %b52.e243
b52.t242:
  br label %b53
b52.e243:
  br label %b54
b53:
  call void @"rt.region_enter"()
  %v790 = getelementptr i64, ptr @"rt.meta", i64 0
  %v354.p = getelementptr i64, ptr %v790, i64 0
  %v354 = load i64, ptr %v354.p
  %v355 = add i64 0, 0
  %v356 = add i64 0, 0
  %v357.c = icmp ne i64 %v355, %v356
  %v357 = zext i1 %v357.c to i64
  %c.b53 = icmp ne i64 %v357, 0
  br i1 %c.b53, label %b53.t244, label %b53.e245
b53.t244:
  br label %b55
b53.e245:
  br label %b56
b54:
  %v791 = getelementptr i64, ptr @"rt.meta", i64 0
  %st245 = getelementptr i64, ptr %v791, i64 0
  store i64 %v352, ptr %st245
  %v447 = getelementptr i64, ptr %s27, i64 0
  %v448 = add i64 0, 0
  %st246 = getelementptr i64, ptr %v447, i64 0
  store i64 %v448, ptr %st246
  %v449.p = getelementptr i64, ptr %v447, i64 0
  %v449 = load i64, ptr %v449.p
  %st247 = getelementptr i64, ptr %v346, i64 0
  store i64 %v449, ptr %st247
  %v450.p = getelementptr i64, ptr %v447, i64 1
  %v450 = load i64, ptr %v450.p
  %st248 = getelementptr i64, ptr %v346, i64 1
  store i64 %v450, ptr %st248
  %v451.p = getelementptr i64, ptr %v447, i64 2
  %v451 = load i64, ptr %v451.p
  %st249 = getelementptr i64, ptr %v346, i64 2
  store i64 %v451, ptr %st249
  %v452.p = getelementptr i64, ptr %v447, i64 3
  %v452 = load i64, ptr %v452.p
  %st250 = getelementptr i64, ptr %v346, i64 3
  store i64 %v452, ptr %st250
  %v453.p = getelementptr i64, ptr %v447, i64 4
  %v453 = load i64, ptr %v453.p
  %st251 = getelementptr i64, ptr %v346, i64 4
  store i64 %v453, ptr %st251
  %v454.p = getelementptr i64, ptr %v447, i64 5
  %v454 = load i64, ptr %v454.p
  %st252 = getelementptr i64, ptr %v346, i64 5
  store i64 %v454, ptr %st252
  call void @"std/io.chunkEnd"(i64 %v351)
  %v455.p = getelementptr i64, ptr %v346, i64 0
  %v455 = load i64, ptr %v455.p
  %v456 = add i64 0, 0
  %v457.c = icmp ne i64 %v455, %v456
  %v457 = zext i1 %v457.c to i64
  %c.b54 = icmp ne i64 %v457, 0
  br i1 %c.b54, label %b54.t254, label %b54.e255
b54.t254:
  br label %b71
b54.e255:
  br label %b72
b55:
  %v358 = getelementptr i64, ptr %s6, i64 0
  %v359 = add i64 0, 0
  %st255 = getelementptr i64, ptr %v358, i64 0
  store i64 %v359, ptr %st255
  %st256 = getelementptr i64, ptr %v358, i64 1
  store i64 %v359, ptr %st256
  %v360 = add i64 0, 3
  %st257 = getelementptr i64, ptr %v358, i64 0
  store i64 %v360, ptr %st257
  %v361 = getelementptr i64, ptr %s7, i64 0
  %v362.p = getelementptr i64, ptr %v358, i64 0
  %v362 = load i64, ptr %v362.p
  %st258 = getelementptr i64, ptr %v361, i64 0
  store i64 %v362, ptr %st258
  %v363.p = getelementptr i64, ptr %v358, i64 1
  %v363 = load i64, ptr %v363.p
  %st259 = getelementptr i64, ptr %v361, i64 1
  store i64 %v363, ptr %st259
  %v364 = add i64 0, 0
  %st260 = getelementptr i64, ptr %v361, i64 2
  store i64 %v364, ptr %st260
  %st261 = getelementptr i64, ptr %v361, i64 3
  store i64 %v364, ptr %st261
  %st262 = getelementptr i64, ptr %v361, i64 4
  store i64 %v364, ptr %st262
  %v365 = getelementptr i64, ptr %s27, i64 0
  %v366 = add i64 0, 1
  %st263 = getelementptr i64, ptr %v365, i64 0
  store i64 %v366, ptr %st263
  %v367.p = getelementptr i64, ptr %v361, i64 0
  %v367 = load i64, ptr %v367.p
  %st264 = getelementptr i64, ptr %v365, i64 1
  store i64 %v367, ptr %st264
  %v368.p = getelementptr i64, ptr %v361, i64 1
  %v368 = load i64, ptr %v368.p
  %st265 = getelementptr i64, ptr %v365, i64 2
  store i64 %v368, ptr %st265
  %v369.p = getelementptr i64, ptr %v361, i64 2
  %v369 = load i64, ptr %v369.p
  %st266 = getelementptr i64, ptr %v365, i64 3
  store i64 %v369, ptr %st266
  %v370.p = getelementptr i64, ptr %v361, i64 3
  %v370 = load i64, ptr %v370.p
  %st267 = getelementptr i64, ptr %v365, i64 4
  store i64 %v370, ptr %st267
  %v371.p = getelementptr i64, ptr %v361, i64 4
  %v371 = load i64, ptr %v371.p
  %st268 = getelementptr i64, ptr %v365, i64 5
  store i64 %v371, ptr %st268
  %v372.p = getelementptr i64, ptr %v365, i64 0
  %v372 = load i64, ptr %v372.p
  %st269 = getelementptr i64, ptr %v346, i64 0
  store i64 %v372, ptr %st269
  %v373.p = getelementptr i64, ptr %v365, i64 1
  %v373 = load i64, ptr %v373.p
  %st270 = getelementptr i64, ptr %v346, i64 1
  store i64 %v373, ptr %st270
  %v374.p = getelementptr i64, ptr %v365, i64 2
  %v374 = load i64, ptr %v374.p
  %st271 = getelementptr i64, ptr %v346, i64 2
  store i64 %v374, ptr %st271
  %v375.p = getelementptr i64, ptr %v365, i64 3
  %v375 = load i64, ptr %v375.p
  %st272 = getelementptr i64, ptr %v346, i64 3
  store i64 %v375, ptr %st272
  %v376.p = getelementptr i64, ptr %v365, i64 4
  %v376 = load i64, ptr %v376.p
  %st273 = getelementptr i64, ptr %v346, i64 4
  store i64 %v376, ptr %st273
  %v377.p = getelementptr i64, ptr %v365, i64 5
  %v377 = load i64, ptr %v377.p
  %st274 = getelementptr i64, ptr %v346, i64 5
  store i64 %v377, ptr %st274
  call void @"std/io.chunkEnd"(i64 %v351)
  %v378.p = getelementptr i64, ptr %v346, i64 0
  %v378 = load i64, ptr %v378.p
  %v379 = add i64 0, 0
  %v380.c = icmp ne i64 %v378, %v379
  %v380 = zext i1 %v380.c to i64
  %c.b55 = icmp ne i64 %v380, 0
  br i1 %c.b55, label %b55.t276, label %b55.e277
b55.t276:
  br label %b57
b55.e277:
  br label %b58
b56:
  br label %b59
b57:
  %v381 = add i64 0, 3
  %v382 = getelementptr i64, ptr %v346, i64 %v381
  %v792 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v382, i64 %v792, i64 %v347)
  br label %b58
b58:
  %v793 = getelementptr i64, ptr @"rt.meta", i64 0
  %st277 = getelementptr i64, ptr %v793, i64 0
  store i64 %v347, ptr %st277
  br label %b51
b59:
  %v383 = getelementptr i64, ptr %s25, i64 0
  call void @"rt.chunk_next"(i64 %v351, ptr %v383)
  %v384 = getelementptr i64, ptr %s24, i64 0
  %v385.p = getelementptr i64, ptr %v383, i64 0
  %v385 = load i64, ptr %v385.p
  %st278 = getelementptr i64, ptr %v384, i64 0
  store i64 %v385, ptr %st278
  %v386.p = getelementptr i64, ptr %v383, i64 1
  %v386 = load i64, ptr %v386.p
  %st279 = getelementptr i64, ptr %v384, i64 1
  store i64 %v386, ptr %st279
  %v387.p = getelementptr i64, ptr %v383, i64 2
  %v387 = load i64, ptr %v387.p
  %st280 = getelementptr i64, ptr %v384, i64 2
  store i64 %v387, ptr %st280
  %v388.p = getelementptr i64, ptr %v384, i64 1
  %v388 = load i64, ptr %v388.p
  %v389 = add i64 0, 0
  %v390.c = icmp eq i64 %v388, %v389
  %v390 = zext i1 %v390.c to i64
  %c.b59 = icmp ne i64 %v390, 0
  br i1 %c.b59, label %b59.t282, label %b59.e283
b59.t282:
  br label %b60
b59.e283:
  br label %b61
b60:
  %v391 = getelementptr i64, ptr @"rt.meta", i64 0
  %v392.p = getelementptr i64, ptr %v391, i64 1027
  %v392 = load i64, ptr %v392.p
  %v393 = add i64 0, 0
  %v394.c = icmp ne i64 %v392, %v393
  %v394 = zext i1 %v394.c to i64
  %c.b60 = icmp ne i64 %v394, 0
  br i1 %c.b60, label %b60.t284, label %b60.e285
b60.t284:
  br label %b62
b60.e285:
  br label %b63
b61:
  br label %b69
b62:
  %v395 = getelementptr i64, ptr %s28, i64 0
  call void @"std/io.errOf"(ptr %v395, i64 %v392)
  %v396 = getelementptr i64, ptr %s27, i64 0
  %v397 = add i64 0, 1
  %st285 = getelementptr i64, ptr %v396, i64 0
  store i64 %v397, ptr %st285
  %v398.p = getelementptr i64, ptr %v395, i64 0
  %v398 = load i64, ptr %v398.p
  %st286 = getelementptr i64, ptr %v396, i64 1
  store i64 %v398, ptr %st286
  %v399.p = getelementptr i64, ptr %v395, i64 1
  %v399 = load i64, ptr %v399.p
  %st287 = getelementptr i64, ptr %v396, i64 2
  store i64 %v399, ptr %st287
  %v400.p = getelementptr i64, ptr %v395, i64 2
  %v400 = load i64, ptr %v400.p
  %st288 = getelementptr i64, ptr %v396, i64 3
  store i64 %v400, ptr %st288
  %v401.p = getelementptr i64, ptr %v395, i64 3
  %v401 = load i64, ptr %v401.p
  %st289 = getelementptr i64, ptr %v396, i64 4
  store i64 %v401, ptr %st289
  %v402.p = getelementptr i64, ptr %v395, i64 4
  %v402 = load i64, ptr %v402.p
  %st290 = getelementptr i64, ptr %v396, i64 5
  store i64 %v402, ptr %st290
  %v403.p = getelementptr i64, ptr %v396, i64 0
  %v403 = load i64, ptr %v403.p
  %st291 = getelementptr i64, ptr %v346, i64 0
  store i64 %v403, ptr %st291
  %v404.p = getelementptr i64, ptr %v396, i64 1
  %v404 = load i64, ptr %v404.p
  %st292 = getelementptr i64, ptr %v346, i64 1
  store i64 %v404, ptr %st292
  %v405.p = getelementptr i64, ptr %v396, i64 2
  %v405 = load i64, ptr %v405.p
  %st293 = getelementptr i64, ptr %v346, i64 2
  store i64 %v405, ptr %st293
  %v406.p = getelementptr i64, ptr %v396, i64 3
  %v406 = load i64, ptr %v406.p
  %st294 = getelementptr i64, ptr %v346, i64 3
  store i64 %v406, ptr %st294
  %v407.p = getelementptr i64, ptr %v396, i64 4
  %v407 = load i64, ptr %v407.p
  %st295 = getelementptr i64, ptr %v346, i64 4
  store i64 %v407, ptr %st295
  %v408.p = getelementptr i64, ptr %v396, i64 5
  %v408 = load i64, ptr %v408.p
  %st296 = getelementptr i64, ptr %v346, i64 5
  store i64 %v408, ptr %st296
  call void @"std/io.chunkEnd"(i64 %v351)
  %v409.p = getelementptr i64, ptr %v346, i64 0
  %v409 = load i64, ptr %v409.p
  %v410 = add i64 0, 0
  %v411.c = icmp ne i64 %v409, %v410
  %v411 = zext i1 %v411.c to i64
  %c.b62 = icmp ne i64 %v411, 0
  br i1 %c.b62, label %b62.t298, label %b62.e299
b62.t298:
  br label %b64
b62.e299:
  br label %b65
b63:
  br label %b66
b64:
  %v412 = add i64 0, 3
  %v413 = getelementptr i64, ptr %v346, i64 %v412
  %v794 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v413, i64 %v794, i64 %v347)
  br label %b65
b65:
  %v795 = getelementptr i64, ptr @"rt.meta", i64 0
  %st299 = getelementptr i64, ptr %v795, i64 0
  store i64 %v347, ptr %st299
  br label %b51
b66:
  %v414 = getelementptr i64, ptr %s27, i64 0
  %v415 = add i64 0, 0
  %st300 = getelementptr i64, ptr %v414, i64 0
  store i64 %v415, ptr %st300
  %v416.p = getelementptr i64, ptr %v414, i64 0
  %v416 = load i64, ptr %v416.p
  %st301 = getelementptr i64, ptr %v346, i64 0
  store i64 %v416, ptr %st301
  %v417.p = getelementptr i64, ptr %v414, i64 1
  %v417 = load i64, ptr %v417.p
  %st302 = getelementptr i64, ptr %v346, i64 1
  store i64 %v417, ptr %st302
  %v418.p = getelementptr i64, ptr %v414, i64 2
  %v418 = load i64, ptr %v418.p
  %st303 = getelementptr i64, ptr %v346, i64 2
  store i64 %v418, ptr %st303
  %v419.p = getelementptr i64, ptr %v414, i64 3
  %v419 = load i64, ptr %v419.p
  %st304 = getelementptr i64, ptr %v346, i64 3
  store i64 %v419, ptr %st304
  %v420.p = getelementptr i64, ptr %v414, i64 4
  %v420 = load i64, ptr %v420.p
  %st305 = getelementptr i64, ptr %v346, i64 4
  store i64 %v420, ptr %st305
  %v421.p = getelementptr i64, ptr %v414, i64 5
  %v421 = load i64, ptr %v421.p
  %st306 = getelementptr i64, ptr %v346, i64 5
  store i64 %v421, ptr %st306
  call void @"std/io.chunkEnd"(i64 %v351)
  %v422.p = getelementptr i64, ptr %v346, i64 0
  %v422 = load i64, ptr %v422.p
  %v423 = add i64 0, 0
  %v424.c = icmp ne i64 %v422, %v423
  %v424 = zext i1 %v424.c to i64
  %c.b66 = icmp ne i64 %v424, 0
  br i1 %c.b66, label %b66.t308, label %b66.e309
b66.t308:
  br label %b67
b66.e309:
  br label %b68
b67:
  %v425 = add i64 0, 3
  %v426 = getelementptr i64, ptr %v346, i64 %v425
  %v796 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v426, i64 %v796, i64 %v347)
  br label %b68
b68:
  %v797 = getelementptr i64, ptr @"rt.meta", i64 0
  %st309 = getelementptr i64, ptr %v797, i64 0
  store i64 %v347, ptr %st309
  br label %b51
b69:
  %v427 = getelementptr i64, ptr %s25, i64 0
  %v428.p = getelementptr i64, ptr %v384, i64 0
  %v428 = load i64, ptr %v428.p
  %st310 = getelementptr i64, ptr %v427, i64 0
  store i64 %v428, ptr %st310
  %v429.p = getelementptr i64, ptr %v384, i64 1
  %v429 = load i64, ptr %v429.p
  %st311 = getelementptr i64, ptr %v427, i64 1
  store i64 %v429, ptr %st311
  %v430.p = getelementptr i64, ptr %v384, i64 2
  %v430 = load i64, ptr %v430.p
  %st312 = getelementptr i64, ptr %v427, i64 2
  store i64 %v430, ptr %st312
  %v431 = getelementptr i64, ptr %s14, i64 0
  %v432 = add i64 0, 0
  %v433 = getelementptr i64, ptr %s29, i64 0
  %v434 = getelementptr i64, ptr %s23, i64 0
  %v435 = add i64 0, 0
  %st313 = getelementptr i64, ptr %v434, i64 0
  store i64 %v435, ptr %st313
  %st314 = getelementptr i64, ptr %v434, i64 1
  store i64 %v435, ptr %st314
  %st315 = getelementptr i64, ptr %v434, i64 2
  store i64 %v435, ptr %st315
  %v436.p = getelementptr i64, ptr %v427, i64 0
  %v436 = load i64, ptr %v436.p
  %st316 = getelementptr i64, ptr %v434, i64 0
  store i64 %v436, ptr %st316
  %v437.p = getelementptr i64, ptr %v427, i64 1
  %v437 = load i64, ptr %v437.p
  %st317 = getelementptr i64, ptr %v434, i64 1
  store i64 %v437, ptr %st317
  %v438.p = getelementptr i64, ptr %v427, i64 2
  %v438 = load i64, ptr %v438.p
  %st318 = getelementptr i64, ptr %v434, i64 2
  store i64 %v438, ptr %st318
  %v439 = getelementptr i64, ptr %s21, i64 0
  %v440.p = getelementptr i64, ptr %v434, i64 0
  %v440 = load i64, ptr %v440.p
  %st319 = getelementptr i64, ptr %v439, i64 0
  store i64 %v440, ptr %st319
  %v441.p = getelementptr i64, ptr %v434, i64 1
  %v441 = load i64, ptr %v441.p
  %st320 = getelementptr i64, ptr %v439, i64 1
  store i64 %v441, ptr %st320
  %v442.p = getelementptr i64, ptr %v434, i64 2
  %v442 = load i64, ptr %v442.p
  %st321 = getelementptr i64, ptr %v439, i64 2
  store i64 %v442, ptr %st321
  %v798 = getelementptr i64, ptr @"rt.meta", i64 0
  %v443.p = getelementptr i64, ptr %v798, i64 0
  %v443 = load i64, ptr %v443.p
  %v444 = add i64 0, 1
  %v445.p = getelementptr i64, ptr %v310, i64 0
  %v445 = load i64, ptr %v445.p
  %v446 = add i64 %v445, %v444
  %st322 = getelementptr i64, ptr %v310, i64 0
  store i64 %v446, ptr %st322
  br label %b70
b70:
  %v799 = getelementptr i64, ptr @"rt.meta", i64 0
  %st323 = getelementptr i64, ptr %v799, i64 0
  store i64 %v443, ptr %st323
  br label %b52
b71:
  %v458 = add i64 0, 3
  %v459 = getelementptr i64, ptr %v346, i64 %v458
  %v800 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v459, i64 %v800, i64 %v347)
  br label %b72
b72:
  %v801 = getelementptr i64, ptr @"rt.meta", i64 0
  %st324 = getelementptr i64, ptr %v801, i64 0
  store i64 %v347, ptr %st324
  br label %b51
b73:
  %v469 = add i64 0, 3
  %v470 = getelementptr i64, ptr %v314, i64 %v469
  %v802 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v470, i64 %v802, i64 %v315)
  br label %b74
b74:
  %v803 = getelementptr i64, ptr @"rt.meta", i64 0
  %st325 = getelementptr i64, ptr %v803, i64 0
  store i64 %v315, ptr %st325
  br label %b45
b75:
  %v474 = add i64 0, 0
  %v475.p = getelementptr i64, ptr %v314, i64 0
  %v475 = load i64, ptr %v475.p
  %st326 = getelementptr i64, ptr %v0, i64 0
  store i64 %v475, ptr %st326
  %v476.p = getelementptr i64, ptr %v314, i64 1
  %v476 = load i64, ptr %v476.p
  %st327 = getelementptr i64, ptr %v0, i64 1
  store i64 %v476, ptr %st327
  %v477.p = getelementptr i64, ptr %v314, i64 2
  %v477 = load i64, ptr %v477.p
  %st328 = getelementptr i64, ptr %v0, i64 2
  store i64 %v477, ptr %st328
  %v478.p = getelementptr i64, ptr %v314, i64 3
  %v478 = load i64, ptr %v478.p
  %st329 = getelementptr i64, ptr %v0, i64 3
  store i64 %v478, ptr %st329
  %v479.p = getelementptr i64, ptr %v314, i64 4
  %v479 = load i64, ptr %v479.p
  %st330 = getelementptr i64, ptr %v0, i64 4
  store i64 %v479, ptr %st330
  %v480.p = getelementptr i64, ptr %v314, i64 5
  %v480 = load i64, ptr %v480.p
  %st331 = getelementptr i64, ptr %v0, i64 5
  store i64 %v480, ptr %st331
  %v481.p = getelementptr i64, ptr %v28, i64 0
  %v481 = load i64, ptr %v481.p
  call void @"std/io.Close"(i64 %v481)
  %v482.p = getelementptr i64, ptr %v0, i64 0
  %v482 = load i64, ptr %v482.p
  %v483 = add i64 0, 0
  %v484.c = icmp ne i64 %v482, %v483
  %v484 = zext i1 %v484.c to i64
  %c.b75 = icmp ne i64 %v484, 0
  br i1 %c.b75, label %b75.t333, label %b75.e334
b75.t333:
  br label %b77
b75.e334:
  br label %b78
b76:
  br label %b44
b77:
  %v485 = add i64 0, 3
  %v486 = getelementptr i64, ptr %v0, i64 %v485
  %v804 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v486, i64 %v804, i64 %v6)
  br label %b78
b78:
  %v805 = getelementptr i64, ptr @"rt.meta", i64 0
  %st334 = getelementptr i64, ptr %v805, i64 0
  store i64 %v6, ptr %st334
  ret void
b79:
  %v684 = getelementptr i64, ptr %s32, i64 0
  %v685.p = getelementptr i64, ptr %v531, i64 0
  %v685 = load i64, ptr %v685.p
  %st335 = getelementptr i64, ptr %v684, i64 0
  store i64 %v685, ptr %st335
  %v686.p = getelementptr i64, ptr %v531, i64 1
  %v686 = load i64, ptr %v686.p
  %st336 = getelementptr i64, ptr %v684, i64 1
  store i64 %v686, ptr %st336
  %v687.p = getelementptr i64, ptr %v531, i64 2
  %v687 = load i64, ptr %v687.p
  %st337 = getelementptr i64, ptr %v684, i64 2
  store i64 %v687, ptr %st337
  %v688.p = getelementptr i64, ptr %v531, i64 3
  %v688 = load i64, ptr %v688.p
  %st338 = getelementptr i64, ptr %v684, i64 3
  store i64 %v688, ptr %st338
  %v689.p = getelementptr i64, ptr %v531, i64 4
  %v689 = load i64, ptr %v689.p
  %st339 = getelementptr i64, ptr %v684, i64 4
  store i64 %v689, ptr %st339
  %v690.p = getelementptr i64, ptr %v531, i64 5
  %v690 = load i64, ptr %v690.p
  %st340 = getelementptr i64, ptr %v684, i64 5
  store i64 %v690, ptr %st340
  %v691.p = getelementptr i64, ptr %v684, i64 0
  %v691 = load i64, ptr %v691.p
  %v692 = add i64 0, 0
  %v693.c = icmp ne i64 %v691, %v692
  %v693 = zext i1 %v693.c to i64
  %c.b79 = icmp ne i64 %v693, 0
  br i1 %c.b79, label %b79.t342, label %b79.e343
b79.t342:
  br label %b108
b79.e343:
  br label %b109
b80:
  %v535 = add i64 0, 22
  %v536 = getelementptr i64, ptr %s6, i64 0
  %v537 = add i64 0, 0
  %st343 = getelementptr i64, ptr %v536, i64 0
  store i64 %v537, ptr %st343
  %st344 = getelementptr i64, ptr %v536, i64 1
  store i64 %v537, ptr %st344
  %v538 = add i64 0, 5
  %st345 = getelementptr i64, ptr %v536, i64 0
  store i64 %v538, ptr %st345
  %st346 = getelementptr i64, ptr %v536, i64 1
  store i64 %v535, ptr %st346
  %v539 = getelementptr i64, ptr %s7, i64 0
  %v540.p = getelementptr i64, ptr %v536, i64 0
  %v540 = load i64, ptr %v540.p
  %st347 = getelementptr i64, ptr %v539, i64 0
  store i64 %v540, ptr %st347
  %v541.p = getelementptr i64, ptr %v536, i64 1
  %v541 = load i64, ptr %v541.p
  %st348 = getelementptr i64, ptr %v539, i64 1
  store i64 %v541, ptr %st348
  %v542 = add i64 0, 0
  %st349 = getelementptr i64, ptr %v539, i64 2
  store i64 %v542, ptr %st349
  %st350 = getelementptr i64, ptr %v539, i64 3
  store i64 %v542, ptr %st350
  %st351 = getelementptr i64, ptr %v539, i64 4
  store i64 %v542, ptr %st351
  %v543 = getelementptr i64, ptr %s31, i64 0
  %v544 = add i64 0, 1
  %st352 = getelementptr i64, ptr %v543, i64 0
  store i64 %v544, ptr %st352
  %v545.p = getelementptr i64, ptr %v539, i64 0
  %v545 = load i64, ptr %v545.p
  %st353 = getelementptr i64, ptr %v543, i64 1
  store i64 %v545, ptr %st353
  %v546.p = getelementptr i64, ptr %v539, i64 1
  %v546 = load i64, ptr %v546.p
  %st354 = getelementptr i64, ptr %v543, i64 2
  store i64 %v546, ptr %st354
  %v547.p = getelementptr i64, ptr %v539, i64 2
  %v547 = load i64, ptr %v547.p
  %st355 = getelementptr i64, ptr %v543, i64 3
  store i64 %v547, ptr %st355
  %v548.p = getelementptr i64, ptr %v539, i64 3
  %v548 = load i64, ptr %v548.p
  %st356 = getelementptr i64, ptr %v543, i64 4
  store i64 %v548, ptr %st356
  %v549.p = getelementptr i64, ptr %v539, i64 4
  %v549 = load i64, ptr %v549.p
  %st357 = getelementptr i64, ptr %v543, i64 5
  store i64 %v549, ptr %st357
  %v550.p = getelementptr i64, ptr %v543, i64 0
  %v550 = load i64, ptr %v550.p
  %st358 = getelementptr i64, ptr %v531, i64 0
  store i64 %v550, ptr %st358
  %v551.p = getelementptr i64, ptr %v543, i64 1
  %v551 = load i64, ptr %v551.p
  %st359 = getelementptr i64, ptr %v531, i64 1
  store i64 %v551, ptr %st359
  %v552.p = getelementptr i64, ptr %v543, i64 2
  %v552 = load i64, ptr %v552.p
  %st360 = getelementptr i64, ptr %v531, i64 2
  store i64 %v552, ptr %st360
  %v553.p = getelementptr i64, ptr %v543, i64 3
  %v553 = load i64, ptr %v553.p
  %st361 = getelementptr i64, ptr %v531, i64 3
  store i64 %v553, ptr %st361
  %v554.p = getelementptr i64, ptr %v543, i64 4
  %v554 = load i64, ptr %v554.p
  %st362 = getelementptr i64, ptr %v531, i64 4
  store i64 %v554, ptr %st362
  %v555.p = getelementptr i64, ptr %v543, i64 5
  %v555 = load i64, ptr %v555.p
  %st363 = getelementptr i64, ptr %v531, i64 5
  store i64 %v555, ptr %st363
  %v556.p = getelementptr i64, ptr %v531, i64 0
  %v556 = load i64, ptr %v556.p
  %v557 = add i64 0, 0
  %v558.c = icmp ne i64 %v556, %v557
  %v558 = zext i1 %v558.c to i64
  %c.b80 = icmp ne i64 %v558, 0
  br i1 %c.b80, label %b80.t365, label %b80.e366
b80.t365:
  br label %b82
b80.e366:
  br label %b83
b81:
  br label %b84
b82:
  %v559 = add i64 0, 3
  %v560 = getelementptr i64, ptr %v531, i64 %v559
  %v806 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v560, i64 %v806, i64 %v532)
  br label %b83
b83:
  %v807 = getelementptr i64, ptr @"rt.meta", i64 0
  %st366 = getelementptr i64, ptr %v807, i64 0
  store i64 %v532, ptr %st366
  br label %b79
b84:
  %v561 = getelementptr i64, ptr %s15, i64 0
  %v562.p = getelementptr i64, ptr %v526, i64 0
  %v562 = load i64, ptr %v562.p
  %st367 = getelementptr i64, ptr %v561, i64 0
  store i64 %v562, ptr %st367
  %v563 = getelementptr i64, ptr %s31, i64 0
  %v808 = getelementptr i64, ptr @"rt.meta", i64 0
  %v564.p = getelementptr i64, ptr %v808, i64 0
  %v564 = load i64, ptr %v564.p
  %v565.p = getelementptr i64, ptr %v561, i64 0
  %v565 = load i64, ptr %v565.p
  %v566 = add i64 0, 65536
  %v567 = add i64 0, 2
  %v568 = call i64 @"rt.chunk_open"(i64 %v565, i64 %v566, i64 %v567, i64 %v530)
  %v809 = getelementptr i64, ptr @"rt.meta", i64 0
  %v569.p = getelementptr i64, ptr %v809, i64 0
  %v569 = load i64, ptr %v569.p
  br label %b86
b85:
  %v673.p = getelementptr i64, ptr %v563, i64 0
  %v673 = load i64, ptr %v673.p
  %st368 = getelementptr i64, ptr %v531, i64 0
  store i64 %v673, ptr %st368
  %v674.p = getelementptr i64, ptr %v563, i64 1
  %v674 = load i64, ptr %v674.p
  %st369 = getelementptr i64, ptr %v531, i64 1
  store i64 %v674, ptr %st369
  %v675.p = getelementptr i64, ptr %v563, i64 2
  %v675 = load i64, ptr %v675.p
  %st370 = getelementptr i64, ptr %v531, i64 2
  store i64 %v675, ptr %st370
  %v676.p = getelementptr i64, ptr %v563, i64 3
  %v676 = load i64, ptr %v676.p
  %st371 = getelementptr i64, ptr %v531, i64 3
  store i64 %v676, ptr %st371
  %v677.p = getelementptr i64, ptr %v563, i64 4
  %v677 = load i64, ptr %v677.p
  %st372 = getelementptr i64, ptr %v531, i64 4
  store i64 %v677, ptr %st372
  %v678.p = getelementptr i64, ptr %v563, i64 5
  %v678 = load i64, ptr %v678.p
  %st373 = getelementptr i64, ptr %v531, i64 5
  store i64 %v678, ptr %st373
  %v679.p = getelementptr i64, ptr %v531, i64 0
  %v679 = load i64, ptr %v679.p
  %v680 = add i64 0, 0
  %v681.c = icmp ne i64 %v679, %v680
  %v681 = zext i1 %v681.c to i64
  %c.b85 = icmp ne i64 %v681, 0
  br i1 %c.b85, label %b85.t375, label %b85.e376
b85.t375:
  br label %b106
b85.e376:
  br label %b107
b86:
  %v810 = getelementptr i64, ptr @"rt.meta", i64 0
  %st376 = getelementptr i64, ptr %v810, i64 0
  store i64 %v569, ptr %st376
  %v570 = add i64 0, 1
  %c.b86 = icmp ne i64 %v570, 0
  br i1 %c.b86, label %b86.t378, label %b86.e379
b86.t378:
  br label %b87
b86.e379:
  br label %b88
b87:
  call void @"rt.region_enter"()
  %v811 = getelementptr i64, ptr @"rt.meta", i64 0
  %v571.p = getelementptr i64, ptr %v811, i64 0
  %v571 = load i64, ptr %v571.p
  %v572 = add i64 0, 0
  %v573 = add i64 0, 0
  %v574.c = icmp ne i64 %v572, %v573
  %v574 = zext i1 %v574.c to i64
  %c.b87 = icmp ne i64 %v574, 0
  br i1 %c.b87, label %b87.t380, label %b87.e381
b87.t380:
  br label %b89
b87.e381:
  br label %b90
b88:
  %v812 = getelementptr i64, ptr @"rt.meta", i64 0
  %st381 = getelementptr i64, ptr %v812, i64 0
  store i64 %v569, ptr %st381
  %v660 = getelementptr i64, ptr %s32, i64 0
  %v661 = add i64 0, 0
  %st382 = getelementptr i64, ptr %v660, i64 0
  store i64 %v661, ptr %st382
  %v662.p = getelementptr i64, ptr %v660, i64 0
  %v662 = load i64, ptr %v662.p
  %st383 = getelementptr i64, ptr %v563, i64 0
  store i64 %v662, ptr %st383
  %v663.p = getelementptr i64, ptr %v660, i64 1
  %v663 = load i64, ptr %v663.p
  %st384 = getelementptr i64, ptr %v563, i64 1
  store i64 %v663, ptr %st384
  %v664.p = getelementptr i64, ptr %v660, i64 2
  %v664 = load i64, ptr %v664.p
  %st385 = getelementptr i64, ptr %v563, i64 2
  store i64 %v664, ptr %st385
  %v665.p = getelementptr i64, ptr %v660, i64 3
  %v665 = load i64, ptr %v665.p
  %st386 = getelementptr i64, ptr %v563, i64 3
  store i64 %v665, ptr %st386
  %v666.p = getelementptr i64, ptr %v660, i64 4
  %v666 = load i64, ptr %v666.p
  %st387 = getelementptr i64, ptr %v563, i64 4
  store i64 %v666, ptr %st387
  %v667.p = getelementptr i64, ptr %v660, i64 5
  %v667 = load i64, ptr %v667.p
  %st388 = getelementptr i64, ptr %v563, i64 5
  store i64 %v667, ptr %st388
  call void @"std/io.chunkEnd"(i64 %v568)
  %v668.p = getelementptr i64, ptr %v563, i64 0
  %v668 = load i64, ptr %v668.p
  %v669 = add i64 0, 0
  %v670.c = icmp ne i64 %v668, %v669
  %v670 = zext i1 %v670.c to i64
  %c.b88 = icmp ne i64 %v670, 0
  br i1 %c.b88, label %b88.t390, label %b88.e391
b88.t390:
  br label %b104
b88.e391:
  br label %b105
b89:
  %v575 = getelementptr i64, ptr %s6, i64 0
  %v576 = add i64 0, 0
  %st391 = getelementptr i64, ptr %v575, i64 0
  store i64 %v576, ptr %st391
  %st392 = getelementptr i64, ptr %v575, i64 1
  store i64 %v576, ptr %st392
  %v577 = add i64 0, 3
  %st393 = getelementptr i64, ptr %v575, i64 0
  store i64 %v577, ptr %st393
  %v578 = getelementptr i64, ptr %s7, i64 0
  %v579.p = getelementptr i64, ptr %v575, i64 0
  %v579 = load i64, ptr %v579.p
  %st394 = getelementptr i64, ptr %v578, i64 0
  store i64 %v579, ptr %st394
  %v580.p = getelementptr i64, ptr %v575, i64 1
  %v580 = load i64, ptr %v580.p
  %st395 = getelementptr i64, ptr %v578, i64 1
  store i64 %v580, ptr %st395
  %v581 = add i64 0, 0
  %st396 = getelementptr i64, ptr %v578, i64 2
  store i64 %v581, ptr %st396
  %st397 = getelementptr i64, ptr %v578, i64 3
  store i64 %v581, ptr %st397
  %st398 = getelementptr i64, ptr %v578, i64 4
  store i64 %v581, ptr %st398
  %v582 = getelementptr i64, ptr %s32, i64 0
  %v583 = add i64 0, 1
  %st399 = getelementptr i64, ptr %v582, i64 0
  store i64 %v583, ptr %st399
  %v584.p = getelementptr i64, ptr %v578, i64 0
  %v584 = load i64, ptr %v584.p
  %st400 = getelementptr i64, ptr %v582, i64 1
  store i64 %v584, ptr %st400
  %v585.p = getelementptr i64, ptr %v578, i64 1
  %v585 = load i64, ptr %v585.p
  %st401 = getelementptr i64, ptr %v582, i64 2
  store i64 %v585, ptr %st401
  %v586.p = getelementptr i64, ptr %v578, i64 2
  %v586 = load i64, ptr %v586.p
  %st402 = getelementptr i64, ptr %v582, i64 3
  store i64 %v586, ptr %st402
  %v587.p = getelementptr i64, ptr %v578, i64 3
  %v587 = load i64, ptr %v587.p
  %st403 = getelementptr i64, ptr %v582, i64 4
  store i64 %v587, ptr %st403
  %v588.p = getelementptr i64, ptr %v578, i64 4
  %v588 = load i64, ptr %v588.p
  %st404 = getelementptr i64, ptr %v582, i64 5
  store i64 %v588, ptr %st404
  %v589.p = getelementptr i64, ptr %v582, i64 0
  %v589 = load i64, ptr %v589.p
  %st405 = getelementptr i64, ptr %v563, i64 0
  store i64 %v589, ptr %st405
  %v590.p = getelementptr i64, ptr %v582, i64 1
  %v590 = load i64, ptr %v590.p
  %st406 = getelementptr i64, ptr %v563, i64 1
  store i64 %v590, ptr %st406
  %v591.p = getelementptr i64, ptr %v582, i64 2
  %v591 = load i64, ptr %v591.p
  %st407 = getelementptr i64, ptr %v563, i64 2
  store i64 %v591, ptr %st407
  %v592.p = getelementptr i64, ptr %v582, i64 3
  %v592 = load i64, ptr %v592.p
  %st408 = getelementptr i64, ptr %v563, i64 3
  store i64 %v592, ptr %st408
  %v593.p = getelementptr i64, ptr %v582, i64 4
  %v593 = load i64, ptr %v593.p
  %st409 = getelementptr i64, ptr %v563, i64 4
  store i64 %v593, ptr %st409
  %v594.p = getelementptr i64, ptr %v582, i64 5
  %v594 = load i64, ptr %v594.p
  %st410 = getelementptr i64, ptr %v563, i64 5
  store i64 %v594, ptr %st410
  call void @"std/io.chunkEnd"(i64 %v568)
  %v595.p = getelementptr i64, ptr %v563, i64 0
  %v595 = load i64, ptr %v595.p
  %v596 = add i64 0, 0
  %v597.c = icmp ne i64 %v595, %v596
  %v597 = zext i1 %v597.c to i64
  %c.b89 = icmp ne i64 %v597, 0
  br i1 %c.b89, label %b89.t412, label %b89.e413
b89.t412:
  br label %b91
b89.e413:
  br label %b92
b90:
  br label %b93
b91:
  %v598 = add i64 0, 3
  %v599 = getelementptr i64, ptr %v563, i64 %v598
  %v813 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v599, i64 %v813, i64 %v564)
  br label %b92
b92:
  %v814 = getelementptr i64, ptr @"rt.meta", i64 0
  %st413 = getelementptr i64, ptr %v814, i64 0
  store i64 %v564, ptr %st413
  br label %b85
b93:
  %v600 = getelementptr i64, ptr %s24, i64 0
  call void @"rt.chunk_next"(i64 %v568, ptr %v600)
  %v601 = getelementptr i64, ptr %s25, i64 0
  %v602.p = getelementptr i64, ptr %v600, i64 0
  %v602 = load i64, ptr %v602.p
  %st414 = getelementptr i64, ptr %v601, i64 0
  store i64 %v602, ptr %st414
  %v603.p = getelementptr i64, ptr %v600, i64 1
  %v603 = load i64, ptr %v603.p
  %st415 = getelementptr i64, ptr %v601, i64 1
  store i64 %v603, ptr %st415
  %v604.p = getelementptr i64, ptr %v600, i64 2
  %v604 = load i64, ptr %v604.p
  %st416 = getelementptr i64, ptr %v601, i64 2
  store i64 %v604, ptr %st416
  %v605.p = getelementptr i64, ptr %v601, i64 1
  %v605 = load i64, ptr %v605.p
  %v606 = add i64 0, 0
  %v607.c = icmp eq i64 %v605, %v606
  %v607 = zext i1 %v607.c to i64
  %c.b93 = icmp ne i64 %v607, 0
  br i1 %c.b93, label %b93.t418, label %b93.e419
b93.t418:
  br label %b94
b93.e419:
  br label %b95
b94:
  %v608 = getelementptr i64, ptr @"rt.meta", i64 0
  %v609.p = getelementptr i64, ptr %v608, i64 1027
  %v609 = load i64, ptr %v609.p
  %v610 = add i64 0, 0
  %v611.c = icmp ne i64 %v609, %v610
  %v611 = zext i1 %v611.c to i64
  %c.b94 = icmp ne i64 %v611, 0
  br i1 %c.b94, label %b94.t420, label %b94.e421
b94.t420:
  br label %b96
b94.e421:
  br label %b97
b95:
  br label %b103
b96:
  %v612 = getelementptr i64, ptr %s33, i64 0
  call void @"std/io.errOf"(ptr %v612, i64 %v609)
  %v613 = getelementptr i64, ptr %s32, i64 0
  %v614 = add i64 0, 1
  %st421 = getelementptr i64, ptr %v613, i64 0
  store i64 %v614, ptr %st421
  %v615.p = getelementptr i64, ptr %v612, i64 0
  %v615 = load i64, ptr %v615.p
  %st422 = getelementptr i64, ptr %v613, i64 1
  store i64 %v615, ptr %st422
  %v616.p = getelementptr i64, ptr %v612, i64 1
  %v616 = load i64, ptr %v616.p
  %st423 = getelementptr i64, ptr %v613, i64 2
  store i64 %v616, ptr %st423
  %v617.p = getelementptr i64, ptr %v612, i64 2
  %v617 = load i64, ptr %v617.p
  %st424 = getelementptr i64, ptr %v613, i64 3
  store i64 %v617, ptr %st424
  %v618.p = getelementptr i64, ptr %v612, i64 3
  %v618 = load i64, ptr %v618.p
  %st425 = getelementptr i64, ptr %v613, i64 4
  store i64 %v618, ptr %st425
  %v619.p = getelementptr i64, ptr %v612, i64 4
  %v619 = load i64, ptr %v619.p
  %st426 = getelementptr i64, ptr %v613, i64 5
  store i64 %v619, ptr %st426
  %v620.p = getelementptr i64, ptr %v613, i64 0
  %v620 = load i64, ptr %v620.p
  %st427 = getelementptr i64, ptr %v563, i64 0
  store i64 %v620, ptr %st427
  %v621.p = getelementptr i64, ptr %v613, i64 1
  %v621 = load i64, ptr %v621.p
  %st428 = getelementptr i64, ptr %v563, i64 1
  store i64 %v621, ptr %st428
  %v622.p = getelementptr i64, ptr %v613, i64 2
  %v622 = load i64, ptr %v622.p
  %st429 = getelementptr i64, ptr %v563, i64 2
  store i64 %v622, ptr %st429
  %v623.p = getelementptr i64, ptr %v613, i64 3
  %v623 = load i64, ptr %v623.p
  %st430 = getelementptr i64, ptr %v563, i64 3
  store i64 %v623, ptr %st430
  %v624.p = getelementptr i64, ptr %v613, i64 4
  %v624 = load i64, ptr %v624.p
  %st431 = getelementptr i64, ptr %v563, i64 4
  store i64 %v624, ptr %st431
  %v625.p = getelementptr i64, ptr %v613, i64 5
  %v625 = load i64, ptr %v625.p
  %st432 = getelementptr i64, ptr %v563, i64 5
  store i64 %v625, ptr %st432
  call void @"std/io.chunkEnd"(i64 %v568)
  %v626.p = getelementptr i64, ptr %v563, i64 0
  %v626 = load i64, ptr %v626.p
  %v627 = add i64 0, 0
  %v628.c = icmp ne i64 %v626, %v627
  %v628 = zext i1 %v628.c to i64
  %c.b96 = icmp ne i64 %v628, 0
  br i1 %c.b96, label %b96.t434, label %b96.e435
b96.t434:
  br label %b98
b96.e435:
  br label %b99
b97:
  br label %b100
b98:
  %v629 = add i64 0, 3
  %v630 = getelementptr i64, ptr %v563, i64 %v629
  %v815 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v630, i64 %v815, i64 %v564)
  br label %b99
b99:
  %v816 = getelementptr i64, ptr @"rt.meta", i64 0
  %st435 = getelementptr i64, ptr %v816, i64 0
  store i64 %v564, ptr %st435
  br label %b85
b100:
  %v631 = getelementptr i64, ptr %s32, i64 0
  %v632 = add i64 0, 0
  %st436 = getelementptr i64, ptr %v631, i64 0
  store i64 %v632, ptr %st436
  %v633.p = getelementptr i64, ptr %v631, i64 0
  %v633 = load i64, ptr %v633.p
  %st437 = getelementptr i64, ptr %v563, i64 0
  store i64 %v633, ptr %st437
  %v634.p = getelementptr i64, ptr %v631, i64 1
  %v634 = load i64, ptr %v634.p
  %st438 = getelementptr i64, ptr %v563, i64 1
  store i64 %v634, ptr %st438
  %v635.p = getelementptr i64, ptr %v631, i64 2
  %v635 = load i64, ptr %v635.p
  %st439 = getelementptr i64, ptr %v563, i64 2
  store i64 %v635, ptr %st439
  %v636.p = getelementptr i64, ptr %v631, i64 3
  %v636 = load i64, ptr %v636.p
  %st440 = getelementptr i64, ptr %v563, i64 3
  store i64 %v636, ptr %st440
  %v637.p = getelementptr i64, ptr %v631, i64 4
  %v637 = load i64, ptr %v637.p
  %st441 = getelementptr i64, ptr %v563, i64 4
  store i64 %v637, ptr %st441
  %v638.p = getelementptr i64, ptr %v631, i64 5
  %v638 = load i64, ptr %v638.p
  %st442 = getelementptr i64, ptr %v563, i64 5
  store i64 %v638, ptr %st442
  call void @"std/io.chunkEnd"(i64 %v568)
  %v639.p = getelementptr i64, ptr %v563, i64 0
  %v639 = load i64, ptr %v639.p
  %v640 = add i64 0, 0
  %v641.c = icmp ne i64 %v639, %v640
  %v641 = zext i1 %v641.c to i64
  %c.b100 = icmp ne i64 %v641, 0
  br i1 %c.b100, label %b100.t444, label %b100.e445
b100.t444:
  br label %b101
b100.e445:
  br label %b102
b101:
  %v642 = add i64 0, 3
  %v643 = getelementptr i64, ptr %v563, i64 %v642
  %v817 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v643, i64 %v817, i64 %v564)
  br label %b102
b102:
  %v818 = getelementptr i64, ptr @"rt.meta", i64 0
  %st445 = getelementptr i64, ptr %v818, i64 0
  store i64 %v564, ptr %st445
  br label %b85
b103:
  %v644 = getelementptr i64, ptr %s24, i64 0
  %v645.p = getelementptr i64, ptr %v601, i64 0
  %v645 = load i64, ptr %v645.p
  %st446 = getelementptr i64, ptr %v644, i64 0
  store i64 %v645, ptr %st446
  %v646.p = getelementptr i64, ptr %v601, i64 1
  %v646 = load i64, ptr %v646.p
  %st447 = getelementptr i64, ptr %v644, i64 1
  store i64 %v646, ptr %st447
  %v647.p = getelementptr i64, ptr %v601, i64 2
  %v647 = load i64, ptr %v647.p
  %st448 = getelementptr i64, ptr %v644, i64 2
  store i64 %v647, ptr %st448
  %v648 = getelementptr i64, ptr %s29, i64 0
  %v649 = add i64 0, 0
  %v650 = getelementptr i64, ptr %s14, i64 0
  %v651 = getelementptr i64, ptr %s23, i64 0
  %v652 = add i64 0, 0
  %st449 = getelementptr i64, ptr %v651, i64 0
  store i64 %v652, ptr %st449
  %st450 = getelementptr i64, ptr %v651, i64 1
  store i64 %v652, ptr %st450
  %st451 = getelementptr i64, ptr %v651, i64 2
  store i64 %v652, ptr %st451
  %v653.p = getelementptr i64, ptr %v644, i64 0
  %v653 = load i64, ptr %v653.p
  %st452 = getelementptr i64, ptr %v651, i64 0
  store i64 %v653, ptr %st452
  %v654.p = getelementptr i64, ptr %v644, i64 1
  %v654 = load i64, ptr %v654.p
  %st453 = getelementptr i64, ptr %v651, i64 1
  store i64 %v654, ptr %st453
  %v655.p = getelementptr i64, ptr %v644, i64 2
  %v655 = load i64, ptr %v655.p
  %st454 = getelementptr i64, ptr %v651, i64 2
  store i64 %v655, ptr %st454
  %v656 = getelementptr i64, ptr %s21, i64 0
  %v657.p = getelementptr i64, ptr %v651, i64 0
  %v657 = load i64, ptr %v657.p
  %st455 = getelementptr i64, ptr %v656, i64 0
  store i64 %v657, ptr %st455
  %v658.p = getelementptr i64, ptr %v651, i64 1
  %v658 = load i64, ptr %v658.p
  %st456 = getelementptr i64, ptr %v656, i64 1
  store i64 %v658, ptr %st456
  %v659.p = getelementptr i64, ptr %v651, i64 2
  %v659 = load i64, ptr %v659.p
  %st457 = getelementptr i64, ptr %v656, i64 2
  store i64 %v659, ptr %st457
  br label %b86
b104:
  %v671 = add i64 0, 3
  %v672 = getelementptr i64, ptr %v563, i64 %v671
  %v819 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v672, i64 %v819, i64 %v564)
  br label %b105
b105:
  %v820 = getelementptr i64, ptr @"rt.meta", i64 0
  %st458 = getelementptr i64, ptr %v820, i64 0
  store i64 %v564, ptr %st458
  br label %b85
b106:
  %v682 = add i64 0, 3
  %v683 = getelementptr i64, ptr %v531, i64 %v682
  %v821 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v683, i64 %v821, i64 %v532)
  br label %b107
b107:
  %v822 = getelementptr i64, ptr @"rt.meta", i64 0
  %st459 = getelementptr i64, ptr %v822, i64 0
  store i64 %v532, ptr %st459
  br label %b79
b108:
  %v694 = add i64 0, 1
  %v695 = getelementptr i64, ptr %v684, i64 %v694
  %v696 = getelementptr i64, ptr %s7, i64 0
  %v697.p = getelementptr i64, ptr %v695, i64 0
  %v697 = load i64, ptr %v697.p
  %st460 = getelementptr i64, ptr %v696, i64 0
  store i64 %v697, ptr %st460
  %v698.p = getelementptr i64, ptr %v695, i64 1
  %v698 = load i64, ptr %v698.p
  %st461 = getelementptr i64, ptr %v696, i64 1
  store i64 %v698, ptr %st461
  %v699.p = getelementptr i64, ptr %v695, i64 2
  %v699 = load i64, ptr %v699.p
  %st462 = getelementptr i64, ptr %v696, i64 2
  store i64 %v699, ptr %st462
  %v700.p = getelementptr i64, ptr %v695, i64 3
  %v700 = load i64, ptr %v700.p
  %st463 = getelementptr i64, ptr %v696, i64 3
  store i64 %v700, ptr %st463
  %v701.p = getelementptr i64, ptr %v695, i64 4
  %v701 = load i64, ptr %v701.p
  %st464 = getelementptr i64, ptr %v696, i64 4
  store i64 %v701, ptr %st464
  %v702.p = getelementptr i64, ptr %v696, i64 0
  %v702 = load i64, ptr %v702.p
  %v703 = add i64 0, 5
  %v704.c = icmp eq i64 %v702, %v703
  %v704 = zext i1 %v704.c to i64
  %c.b108 = icmp ne i64 %v704, 0
  br i1 %c.b108, label %b108.t466, label %b108.e467
b108.t466:
  br label %b111
b108.e467:
  br label %b110
b109:
  br label %b113
b110:
  %v725 = getelementptr i64, ptr @"str.14", i64 0
  %v726 = add i64 0, 18
  %v727 = add i64 0, 0
  %v728 = getelementptr i64, ptr %s24, i64 0
  %v729 = ptrtoint ptr %v725 to i64
  %st467 = getelementptr i64, ptr %v728, i64 0
  store i64 %v729, ptr %st467
  %st468 = getelementptr i64, ptr %v728, i64 1
  store i64 %v726, ptr %st468
  %st469 = getelementptr i64, ptr %v728, i64 2
  store i64 %v727, ptr %st469
  br label %b112
b111:
  %v705.p = getelementptr i64, ptr %v696, i64 1
  %v705 = load i64, ptr %v705.p
  %v706 = getelementptr i64, ptr @"str.13", i64 0
  %v707 = add i64 0, 23
  %v708 = add i64 0, 0
  %v709 = getelementptr i64, ptr %s21, i64 0
  %v710 = ptrtoint ptr %v706 to i64
  %st470 = getelementptr i64, ptr %v709, i64 0
  store i64 %v710, ptr %st470
  %st471 = getelementptr i64, ptr %v709, i64 1
  store i64 %v707, ptr %st471
  %st472 = getelementptr i64, ptr %v709, i64 2
  store i64 %v708, ptr %st472
  %v711 = getelementptr i64, ptr %s34, i64 0
  call void @"std/convert.FormatInt"(ptr %v711, i64 %v705)
  %v712.p = getelementptr i64, ptr %v709, i64 1
  %v712 = load i64, ptr %v712.p
  %v713.p = getelementptr i64, ptr %v711, i64 1
  %v713 = load i64, ptr %v713.p
  %v714 = add i64 %v712, %v713
  %v823 = getelementptr i64, ptr @"rt.meta", i64 0
  %v715.p = getelementptr i64, ptr %v823, i64 0
  %v715 = load i64, ptr %v715.p
  %v716.p = getelementptr i64, ptr %v709, i64 0
  %v716 = load i64, ptr %v716.p
  %v717.p = getelementptr i64, ptr %v709, i64 1
  %v717 = load i64, ptr %v717.p
  %v718.p = getelementptr i64, ptr %v709, i64 2
  %v718 = load i64, ptr %v718.p
  %v719 = call ptr @"rt.cat8"(i64 %v716, i64 %v717, i64 %v718, i64 %v715, i64 %v713)
  %v720 = getelementptr i8, ptr %v719, i64 %v712
  %v721.p = getelementptr i64, ptr %v711, i64 0
  %v721 = load i64, ptr %v721.p
  %v722 = inttoptr i64 %v721 to ptr
  call void @"rt.copy8"(ptr %v720, ptr %v722, i64 %v713)
  %v723 = getelementptr i64, ptr %s23, i64 0
  %v724 = ptrtoint ptr %v719 to i64
  %st473 = getelementptr i64, ptr %v723, i64 0
  store i64 %v724, ptr %st473
  %st474 = getelementptr i64, ptr %v723, i64 1
  store i64 %v714, ptr %st474
  %st475 = getelementptr i64, ptr %v723, i64 2
  store i64 %v715, ptr %st475
  br label %b112
b112:
  %v730 = phi ptr [ %v728, %b110 ], [ %v723, %b111 ]
  call void @"rt.print_str"(ptr %v730)
  %v731 = add i64 0, 10
  call void @"rt.print_char"(i64 %v731)
  br label %b113
b113:
  %v732 = getelementptr i64, ptr %s35, i64 0
  %v733 = add i64 0, 0
  %st476 = getelementptr i64, ptr %v732, i64 0
  store i64 %v733, ptr %st476
  %v734.p = getelementptr i64, ptr %v732, i64 0
  %v734 = load i64, ptr %v734.p
  %st477 = getelementptr i64, ptr %v0, i64 0
  store i64 %v734, ptr %st477
  %v735.p = getelementptr i64, ptr %v732, i64 1
  %v735 = load i64, ptr %v735.p
  %st478 = getelementptr i64, ptr %v0, i64 1
  store i64 %v735, ptr %st478
  %v736.p = getelementptr i64, ptr %v732, i64 2
  %v736 = load i64, ptr %v736.p
  %st479 = getelementptr i64, ptr %v0, i64 2
  store i64 %v736, ptr %st479
  %v737.p = getelementptr i64, ptr %v732, i64 3
  %v737 = load i64, ptr %v737.p
  %st480 = getelementptr i64, ptr %v0, i64 3
  store i64 %v737, ptr %st480
  %v738.p = getelementptr i64, ptr %v732, i64 4
  %v738 = load i64, ptr %v738.p
  %st481 = getelementptr i64, ptr %v0, i64 4
  store i64 %v738, ptr %st481
  %v739.p = getelementptr i64, ptr %v732, i64 5
  %v739 = load i64, ptr %v739.p
  %st482 = getelementptr i64, ptr %v0, i64 5
  store i64 %v739, ptr %st482
  %v740.p = getelementptr i64, ptr %v28, i64 0
  %v740 = load i64, ptr %v740.p
  call void @"std/io.Close"(i64 %v740)
  %v741.p = getelementptr i64, ptr %v0, i64 0
  %v741 = load i64, ptr %v741.p
  %v742 = add i64 0, 0
  %v743.c = icmp ne i64 %v741, %v742
  %v743 = zext i1 %v743.c to i64
  %c.b113 = icmp ne i64 %v743, 0
  br i1 %c.b113, label %b113.t484, label %b113.e485
b113.t484:
  br label %b114
b113.e485:
  br label %b115
b114:
  %v744 = add i64 0, 3
  %v745 = getelementptr i64, ptr %v0, i64 %v744
  %v824 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v745, i64 %v824, i64 %v6)
  br label %b115
b115:
  %v825 = getelementptr i64, ptr @"rt.meta", i64 0
  %st485 = getelementptr i64, ptr %v825, i64 0
  store i64 %v6, ptr %st485
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
  %v15 = add i64 0, 3
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
  %v25 = add i64 0, 8
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
  %v69 = add i64 0, 9
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
  %v125 = add i64 0, 10
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
