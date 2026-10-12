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
@"str.0" = internal constant [2 x i64] [i64 8031924123371070824, i64 6581362]
@"str.1" = internal constant [1 x i64] [i64 478560413032]
@"str.2" = internal constant [1 x i64] [i64 431316168567]
@"str.3" = internal constant [1 x i64] [i64 26984]
@"str.4" = internal constant [0 x i64] zeroinitializer
@"str.5" = internal constant [1 x i64] [i64 97]
@"str.6" = internal constant [1 x i64] [i64 6513249]
@"str.7" = internal constant [1 x i64] [i64 1684234849]
@"str.8" = internal constant [1 x i64] [i64 28524]
@"str.9" = internal constant [1 x i64] [i64 109274191848033]
@"str.10" = internal constant [1 x i64] [i64 1667391843]
@"str.11" = internal constant [1 x i64] [i64 31073759341930595]
@"str.12" = internal constant [1 x i64] [i64 7234923]
@"str.13" = internal constant [1 x i64] [i64 7499108]
@"str.14" = internal constant [1 x i64] [i64 25185]
@"str.15" = internal constant [1 x i64] [i64 1650549089]
@"str.16" = internal constant [1 x i64] [i64 6447457]
@"str.17" = internal constant [1 x i64] [i64 6447459]
@"str.18" = internal constant [1 x i64] [i64 517417236600]
@"str.19" = internal constant [1 x i64] [i64 120]
@"str.20" = internal constant [2 x i64] [i64 -9087273929700900381, i64 134]
@"str.21" = internal constant [1 x i64] [i64 8684003]
@"str.22" = internal constant [1 x i64] [i64 8946147]
@"str.23" = internal constant [1 x i64] [i64 28270021920777587]
@"str.24" = internal constant [1 x i64] [i64 7303014]
@"str.25" = internal constant [1 x i64] [i64 7496034]
@"str.26" = internal constant [1 x i64] [i64 24930]
@"str.27" = internal constant [1 x i64] [i64 111546296789091]
@"str.28" = internal constant [1 x i64] [i64 101]
@"str.29" = internal constant [1 x i64] [i64 1702259046]
@"str.30" = internal constant [1 x i64] [i64 1633771873]
@"str.31" = internal constant [1 x i64] [i64 24929]
@"str.32" = internal constant [1 x i64] [i64 418245599585]
@"str.33" = internal constant [1 x i64] [i64 7089056562649719393]
@"str.34" = internal constant [1 x i64] [i64 108170401899105]
@"str.35" = internal constant [1 x i64] [i64 6447458]
@"str.36" = internal constant [1 x i64] [i64 113723778559847]
@"str.37" = internal constant [1 x i64] [i64 32495402191187815]
@"str.38" = internal constant [1 x i64] [i64 6381921]
@"str.39" = internal constant [1 x i64] [i64 6580538]
@"str.40" = internal constant [1 x i64] [i64 58]
@"str.41" = internal constant [1 x i64] [i64 25705]
@"str.42" = internal constant [1 x i64] [i64 8552931]
@"str.43" = internal constant [1 x i64] [i64 7748971]
@"str.44" = internal constant [1 x i64] [i64 61]
@"str.45" = internal constant [1 x i64] [i64 512132267371]
@"str.46" = internal constant [1 x i64] [i64 30315]
@"str.47" = internal constant [1 x i64] [i64 30269]
@"str.48" = internal constant [1 x i64] [i64 15723]
@"str.49" = internal constant [1 x i64] [i64 37297509915328995]
@"str.50" = internal constant [1 x i64] [i64 27963159324678241]
@"str.51" = internal constant [1 x i64] [i64 22616]
@"str.52" = internal constant [1 x i64] [i64 425996726113]
@"str.53" = internal constant [1 x i64] [i64 47]
@"str.54" = internal constant [1 x i64] [i64 1667391791]
@"str.55" = internal constant [1 x i64] [i64 795042401]
@"str.56" = internal constant [2 x i64] [i64 3424004429463060963, i64 8815075]
@"str.57" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.58" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.59" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.60" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.61" = internal constant [1 x i64] [i64 2685]
@"str.62" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.63" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.64" = internal constant [1 x i64] [i64 35899498962976]
@"str.65" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.66" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [19 x i64] [i64 7599826401230850, i64 7599826401230850, i64 7599826401230850, i64 14355225842286594, i64 14355225842286594, i64 14355225842286594, i64 7318349545472001, i64 10977524242710529, i64 7599826216681474, i64 7599826216681474, i64 7599826216681474, i64 14355225657737218, i64 14355225657737218, i64 14355225657737218, i64 20547675447361538, i64 20547675447361538, i64 20547675447361538, i64 3659176995717121, i64 5066550167994369]
@"str.67" = internal constant [1 x i64] [i64 9071397899755888]
@"str.68" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.69" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.70" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.71" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.72" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.73" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.74" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.75" = internal constant [1 x i64] [i64 544497952]
@"str.76" = internal constant [4 x i64] [i64 7598263559392621683, i64 7598263559393601390, i64 7305524086039603054, i64 114]

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
  %v3 = getelementptr i64, ptr @"str.57", i64 0
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
  %v22 = getelementptr i64, ptr @"str.60", i64 0
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
  %v28 = getelementptr i64, ptr @"str.61", i64 0
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
  %v10 = getelementptr i64, ptr @"str.58", i64 0
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
  %v17 = getelementptr i64, ptr @"str.59", i64 0
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
  %v53 = getelementptr i64, ptr @"str.62", i64 0
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
  %v58 = getelementptr i64, ptr @"str.63", i64 0
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
  %v63 = getelementptr i64, ptr @"str.61", i64 0
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
  %v74 = getelementptr i64, ptr @"str.64", i64 0
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
  %v81 = getelementptr i64, ptr @"str.65", i64 0
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
  %v17 = getelementptr i64, ptr @"str.66", i64 0
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
  %v22 = getelementptr i64, ptr @"str.61", i64 0
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
  %v5 = phi ptr [ %v12, %b4 ], [ %v18, %b6 ], [ %v60, %b18 ]
  %v6 = phi ptr [ %v14, %b4 ], [ %v21, %b6 ], [ %v66, %b18 ]
  ret ptr %v5
b2:
  %v59 = mul i64 %v3, %v1
  %v60 = call ptr @"rt.slice_grow"(i64 %v2, i64 %v3, i64 %v1, i64 %v4, i64 %v38)
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
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %v68 = getelementptr i64, ptr %v67, i64 %v4
  %v34.p = getelementptr i64, ptr %v68, i64 1
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
  %v50 = call ptr @"rt.region_alloc"(i64 %v4, i64 %v49)
  %v52 = add i64 0, 0
  br label %b14
b14:
  %v51 = phi i64 [ %v52, %b13 ], [ %v57, %b15 ]
  %v53.c = icmp slt i64 %v51, %v49
  %v53 = zext i1 %v53.c to i64
  %c.b14 = icmp ne i64 %v53, 0
  br i1 %c.b14, label %b14.t15, label %b14.e16
b14.t15:
  br label %b15
b14.e16:
  br label %b16
b15:
  %v54 = getelementptr i64, ptr %v50, i64 %v51
  %v55 = add i64 0, 0
  %st16 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st16
  %v56 = add i64 0, 1
  %v57 = add i64 %v51, %v56
  br label %b14
b16:
  %st17 = getelementptr i64, ptr %v50, i64 2
  store i64 %v41, ptr %st17
  %v58 = ptrtoint ptr %v50 to i64
  %st18 = getelementptr i64, ptr %v0, i64 3
  store i64 %v58, ptr %st18
  br label %b2
b17:
  %v63.p = getelementptr i64, ptr %v0, i64 3
  %v63 = load i64, ptr %v63.p
  %v64 = inttoptr i64 %v63 to ptr
  %v65 = ptrtoint ptr %v60 to i64
  %st19 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st19
  br label %b18
b18:
  %v66 = getelementptr i64, ptr %v60, i64 %v59
  br label %b1
b19:
  %v61 = add i64 0, 8
  %v62.c = icmp slt i64 %v8, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b19 = icmp ne i64 %v62, 0
  br i1 %c.b19, label %b19.t21, label %b19.e22
b19.t21:
  br label %b18
b19.e22:
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
  %v1442 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v1442, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr @"str.0", i64 0
  %v2 = add i64 0, 11
  %v3 = add i64 0, 0
  %v4 = getelementptr i64, ptr %s0, i64 0
  %v5 = ptrtoint ptr %v1 to i64
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v5, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v6.p = getelementptr i64, ptr %v4, i64 0
  %v6 = load i64, ptr %v6.p
  %v7.p = getelementptr i64, ptr %v4, i64 1
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 2
  %v8 = load i64, ptr %v8.p
  %v9 = getelementptr i64, ptr @"str.1", i64 0
  %v10 = add i64 0, 5
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s1, i64 0
  %v13 = ptrtoint ptr %v9 to i64
  %st3 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st3
  %st4 = getelementptr i64, ptr %v12, i64 1
  store i64 %v10, ptr %st4
  %st5 = getelementptr i64, ptr %v12, i64 2
  store i64 %v11, ptr %st5
  %v14.p = getelementptr i64, ptr %v12, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v12, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.p = getelementptr i64, ptr %v12, i64 2
  %v16 = load i64, ptr %v16.p
  %v17 = call i64 @"std/strings.HasPrefix"(i64 %v6, i64 %v7, i64 %v8, i64 %v14, i64 %v15, i64 %v16)
  %c.b0 = icmp ne i64 %v17, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v18 = add i64 0, 116
  call void @"rt.print_char"(i64 %v18)
  %v19 = add i64 0, 114
  call void @"rt.print_char"(i64 %v19)
  %v20 = add i64 0, 117
  call void @"rt.print_char"(i64 %v20)
  %v21 = add i64 0, 101
  call void @"rt.print_char"(i64 %v21)
  br label %b3
b2:
  %v22 = add i64 0, 102
  call void @"rt.print_char"(i64 %v22)
  %v23 = add i64 0, 97
  call void @"rt.print_char"(i64 %v23)
  %v24 = add i64 0, 108
  call void @"rt.print_char"(i64 %v24)
  %v25 = add i64 0, 115
  call void @"rt.print_char"(i64 %v25)
  %v26 = add i64 0, 101
  call void @"rt.print_char"(i64 %v26)
  br label %b3
b3:
  %v27 = add i64 0, 10
  call void @"rt.print_char"(i64 %v27)
  %v28 = getelementptr i64, ptr @"str.0", i64 0
  %v29 = add i64 0, 11
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s1, i64 0
  %v32 = ptrtoint ptr %v28 to i64
  %st8 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st8
  %st9 = getelementptr i64, ptr %v31, i64 1
  store i64 %v29, ptr %st9
  %st10 = getelementptr i64, ptr %v31, i64 2
  store i64 %v30, ptr %st10
  %v33.p = getelementptr i64, ptr %v31, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v31, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v31, i64 2
  %v35 = load i64, ptr %v35.p
  %v36 = getelementptr i64, ptr @"str.2", i64 0
  %v37 = add i64 0, 5
  %v38 = add i64 0, 0
  %v39 = getelementptr i64, ptr %s0, i64 0
  %v40 = ptrtoint ptr %v36 to i64
  %st11 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st11
  %st12 = getelementptr i64, ptr %v39, i64 1
  store i64 %v37, ptr %st12
  %st13 = getelementptr i64, ptr %v39, i64 2
  store i64 %v38, ptr %st13
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v39, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.p = getelementptr i64, ptr %v39, i64 2
  %v43 = load i64, ptr %v43.p
  %v44 = call i64 @"std/strings.HasPrefix"(i64 %v33, i64 %v34, i64 %v35, i64 %v41, i64 %v42, i64 %v43)
  %c.b3 = icmp ne i64 %v44, 0
  br i1 %c.b3, label %b3.t15, label %b3.e16
b3.t15:
  br label %b4
b3.e16:
  br label %b5
b4:
  %v45 = add i64 0, 116
  call void @"rt.print_char"(i64 %v45)
  %v46 = add i64 0, 114
  call void @"rt.print_char"(i64 %v46)
  %v47 = add i64 0, 117
  call void @"rt.print_char"(i64 %v47)
  %v48 = add i64 0, 101
  call void @"rt.print_char"(i64 %v48)
  br label %b6
b5:
  %v49 = add i64 0, 102
  call void @"rt.print_char"(i64 %v49)
  %v50 = add i64 0, 97
  call void @"rt.print_char"(i64 %v50)
  %v51 = add i64 0, 108
  call void @"rt.print_char"(i64 %v51)
  %v52 = add i64 0, 115
  call void @"rt.print_char"(i64 %v52)
  %v53 = add i64 0, 101
  call void @"rt.print_char"(i64 %v53)
  br label %b6
b6:
  %v54 = add i64 0, 10
  call void @"rt.print_char"(i64 %v54)
  %v55 = getelementptr i64, ptr @"str.3", i64 0
  %v56 = add i64 0, 2
  %v57 = add i64 0, 0
  %v58 = getelementptr i64, ptr %s0, i64 0
  %v59 = ptrtoint ptr %v55 to i64
  %st16 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st16
  %st17 = getelementptr i64, ptr %v58, i64 1
  store i64 %v56, ptr %st17
  %st18 = getelementptr i64, ptr %v58, i64 2
  store i64 %v57, ptr %st18
  %v60.p = getelementptr i64, ptr %v58, i64 0
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v58, i64 1
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v58, i64 2
  %v62 = load i64, ptr %v62.p
  %v63 = getelementptr i64, ptr @"str.1", i64 0
  %v64 = add i64 0, 5
  %v65 = add i64 0, 0
  %v66 = getelementptr i64, ptr %s1, i64 0
  %v67 = ptrtoint ptr %v63 to i64
  %st19 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st19
  %st20 = getelementptr i64, ptr %v66, i64 1
  store i64 %v64, ptr %st20
  %st21 = getelementptr i64, ptr %v66, i64 2
  store i64 %v65, ptr %st21
  %v68.p = getelementptr i64, ptr %v66, i64 0
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v66, i64 1
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v66, i64 2
  %v70 = load i64, ptr %v70.p
  %v71 = call i64 @"std/strings.HasPrefix"(i64 %v60, i64 %v61, i64 %v62, i64 %v68, i64 %v69, i64 %v70)
  %c.b6 = icmp ne i64 %v71, 0
  br i1 %c.b6, label %b6.t23, label %b6.e24
b6.t23:
  br label %b7
b6.e24:
  br label %b8
b7:
  %v72 = add i64 0, 116
  call void @"rt.print_char"(i64 %v72)
  %v73 = add i64 0, 114
  call void @"rt.print_char"(i64 %v73)
  %v74 = add i64 0, 117
  call void @"rt.print_char"(i64 %v74)
  %v75 = add i64 0, 101
  call void @"rt.print_char"(i64 %v75)
  br label %b9
b8:
  %v76 = add i64 0, 102
  call void @"rt.print_char"(i64 %v76)
  %v77 = add i64 0, 97
  call void @"rt.print_char"(i64 %v77)
  %v78 = add i64 0, 108
  call void @"rt.print_char"(i64 %v78)
  %v79 = add i64 0, 115
  call void @"rt.print_char"(i64 %v79)
  %v80 = add i64 0, 101
  call void @"rt.print_char"(i64 %v80)
  br label %b9
b9:
  %v81 = add i64 0, 10
  call void @"rt.print_char"(i64 %v81)
  %v82 = getelementptr i64, ptr @"str.1", i64 0
  %v83 = add i64 0, 5
  %v84 = add i64 0, 0
  %v85 = getelementptr i64, ptr %s1, i64 0
  %v86 = ptrtoint ptr %v82 to i64
  %st24 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st24
  %st25 = getelementptr i64, ptr %v85, i64 1
  store i64 %v83, ptr %st25
  %st26 = getelementptr i64, ptr %v85, i64 2
  store i64 %v84, ptr %st26
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %v90 = getelementptr i64, ptr @"str.4", i64 0
  %v91 = add i64 0, 0
  %v92 = add i64 0, 0
  %v93 = getelementptr i64, ptr %s0, i64 0
  %v94 = ptrtoint ptr %v90 to i64
  %st27 = getelementptr i64, ptr %v93, i64 0
  store i64 %v94, ptr %st27
  %st28 = getelementptr i64, ptr %v93, i64 1
  store i64 %v91, ptr %st28
  %st29 = getelementptr i64, ptr %v93, i64 2
  store i64 %v92, ptr %st29
  %v95.p = getelementptr i64, ptr %v93, i64 0
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v93, i64 1
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v93, i64 2
  %v97 = load i64, ptr %v97.p
  %v98 = call i64 @"std/strings.HasPrefix"(i64 %v87, i64 %v88, i64 %v89, i64 %v95, i64 %v96, i64 %v97)
  %c.b9 = icmp ne i64 %v98, 0
  br i1 %c.b9, label %b9.t31, label %b9.e32
b9.t31:
  br label %b10
b9.e32:
  br label %b11
b10:
  %v99 = add i64 0, 116
  call void @"rt.print_char"(i64 %v99)
  %v100 = add i64 0, 114
  call void @"rt.print_char"(i64 %v100)
  %v101 = add i64 0, 117
  call void @"rt.print_char"(i64 %v101)
  %v102 = add i64 0, 101
  call void @"rt.print_char"(i64 %v102)
  br label %b12
b11:
  %v103 = add i64 0, 102
  call void @"rt.print_char"(i64 %v103)
  %v104 = add i64 0, 97
  call void @"rt.print_char"(i64 %v104)
  %v105 = add i64 0, 108
  call void @"rt.print_char"(i64 %v105)
  %v106 = add i64 0, 115
  call void @"rt.print_char"(i64 %v106)
  %v107 = add i64 0, 101
  call void @"rt.print_char"(i64 %v107)
  br label %b12
b12:
  %v108 = add i64 0, 10
  call void @"rt.print_char"(i64 %v108)
  %v109 = getelementptr i64, ptr @"str.4", i64 0
  %v110 = add i64 0, 0
  %v111 = add i64 0, 0
  %v112 = getelementptr i64, ptr %s0, i64 0
  %v113 = ptrtoint ptr %v109 to i64
  %st32 = getelementptr i64, ptr %v112, i64 0
  store i64 %v113, ptr %st32
  %st33 = getelementptr i64, ptr %v112, i64 1
  store i64 %v110, ptr %st33
  %st34 = getelementptr i64, ptr %v112, i64 2
  store i64 %v111, ptr %st34
  %v114.p = getelementptr i64, ptr %v112, i64 0
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v112, i64 1
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v112, i64 2
  %v116 = load i64, ptr %v116.p
  %v117 = getelementptr i64, ptr @"str.4", i64 0
  %v118 = add i64 0, 0
  %v119 = add i64 0, 0
  %v120 = getelementptr i64, ptr %s1, i64 0
  %v121 = ptrtoint ptr %v117 to i64
  %st35 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st35
  %st36 = getelementptr i64, ptr %v120, i64 1
  store i64 %v118, ptr %st36
  %st37 = getelementptr i64, ptr %v120, i64 2
  store i64 %v119, ptr %st37
  %v122.p = getelementptr i64, ptr %v120, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v120, i64 1
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v120, i64 2
  %v124 = load i64, ptr %v124.p
  %v125 = call i64 @"std/strings.HasPrefix"(i64 %v114, i64 %v115, i64 %v116, i64 %v122, i64 %v123, i64 %v124)
  %c.b12 = icmp ne i64 %v125, 0
  br i1 %c.b12, label %b12.t39, label %b12.e40
b12.t39:
  br label %b13
b12.e40:
  br label %b14
b13:
  %v126 = add i64 0, 116
  call void @"rt.print_char"(i64 %v126)
  %v127 = add i64 0, 114
  call void @"rt.print_char"(i64 %v127)
  %v128 = add i64 0, 117
  call void @"rt.print_char"(i64 %v128)
  %v129 = add i64 0, 101
  call void @"rt.print_char"(i64 %v129)
  br label %b15
b14:
  %v130 = add i64 0, 102
  call void @"rt.print_char"(i64 %v130)
  %v131 = add i64 0, 97
  call void @"rt.print_char"(i64 %v131)
  %v132 = add i64 0, 108
  call void @"rt.print_char"(i64 %v132)
  %v133 = add i64 0, 115
  call void @"rt.print_char"(i64 %v133)
  %v134 = add i64 0, 101
  call void @"rt.print_char"(i64 %v134)
  br label %b15
b15:
  %v135 = add i64 0, 10
  call void @"rt.print_char"(i64 %v135)
  %v136 = getelementptr i64, ptr @"str.4", i64 0
  %v137 = add i64 0, 0
  %v138 = add i64 0, 0
  %v139 = getelementptr i64, ptr %s1, i64 0
  %v140 = ptrtoint ptr %v136 to i64
  %st40 = getelementptr i64, ptr %v139, i64 0
  store i64 %v140, ptr %st40
  %st41 = getelementptr i64, ptr %v139, i64 1
  store i64 %v137, ptr %st41
  %st42 = getelementptr i64, ptr %v139, i64 2
  store i64 %v138, ptr %st42
  %v141.p = getelementptr i64, ptr %v139, i64 0
  %v141 = load i64, ptr %v141.p
  %v142.p = getelementptr i64, ptr %v139, i64 1
  %v142 = load i64, ptr %v142.p
  %v143.p = getelementptr i64, ptr %v139, i64 2
  %v143 = load i64, ptr %v143.p
  %v144 = getelementptr i64, ptr @"str.5", i64 0
  %v145 = add i64 0, 1
  %v146 = add i64 0, 0
  %v147 = getelementptr i64, ptr %s0, i64 0
  %v148 = ptrtoint ptr %v144 to i64
  %st43 = getelementptr i64, ptr %v147, i64 0
  store i64 %v148, ptr %st43
  %st44 = getelementptr i64, ptr %v147, i64 1
  store i64 %v145, ptr %st44
  %st45 = getelementptr i64, ptr %v147, i64 2
  store i64 %v146, ptr %st45
  %v149.p = getelementptr i64, ptr %v147, i64 0
  %v149 = load i64, ptr %v149.p
  %v150.p = getelementptr i64, ptr %v147, i64 1
  %v150 = load i64, ptr %v150.p
  %v151.p = getelementptr i64, ptr %v147, i64 2
  %v151 = load i64, ptr %v151.p
  %v152 = call i64 @"std/strings.HasPrefix"(i64 %v141, i64 %v142, i64 %v143, i64 %v149, i64 %v150, i64 %v151)
  %c.b15 = icmp ne i64 %v152, 0
  br i1 %c.b15, label %b15.t47, label %b15.e48
b15.t47:
  br label %b16
b15.e48:
  br label %b17
b16:
  %v153 = add i64 0, 116
  call void @"rt.print_char"(i64 %v153)
  %v154 = add i64 0, 114
  call void @"rt.print_char"(i64 %v154)
  %v155 = add i64 0, 117
  call void @"rt.print_char"(i64 %v155)
  %v156 = add i64 0, 101
  call void @"rt.print_char"(i64 %v156)
  br label %b18
b17:
  %v157 = add i64 0, 102
  call void @"rt.print_char"(i64 %v157)
  %v158 = add i64 0, 97
  call void @"rt.print_char"(i64 %v158)
  %v159 = add i64 0, 108
  call void @"rt.print_char"(i64 %v159)
  %v160 = add i64 0, 115
  call void @"rt.print_char"(i64 %v160)
  %v161 = add i64 0, 101
  call void @"rt.print_char"(i64 %v161)
  br label %b18
b18:
  %v162 = add i64 0, 10
  call void @"rt.print_char"(i64 %v162)
  %v163 = getelementptr i64, ptr @"str.6", i64 0
  %v164 = add i64 0, 3
  %v165 = add i64 0, 0
  %v166 = getelementptr i64, ptr %s0, i64 0
  %v167 = ptrtoint ptr %v163 to i64
  %st48 = getelementptr i64, ptr %v166, i64 0
  store i64 %v167, ptr %st48
  %st49 = getelementptr i64, ptr %v166, i64 1
  store i64 %v164, ptr %st49
  %st50 = getelementptr i64, ptr %v166, i64 2
  store i64 %v165, ptr %st50
  %v168.p = getelementptr i64, ptr %v166, i64 0
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v166, i64 1
  %v169 = load i64, ptr %v169.p
  %v170.p = getelementptr i64, ptr %v166, i64 2
  %v170 = load i64, ptr %v170.p
  %v171 = getelementptr i64, ptr @"str.6", i64 0
  %v172 = add i64 0, 3
  %v173 = add i64 0, 0
  %v174 = getelementptr i64, ptr %s1, i64 0
  %v175 = ptrtoint ptr %v171 to i64
  %st51 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st51
  %st52 = getelementptr i64, ptr %v174, i64 1
  store i64 %v172, ptr %st52
  %st53 = getelementptr i64, ptr %v174, i64 2
  store i64 %v173, ptr %st53
  %v176.p = getelementptr i64, ptr %v174, i64 0
  %v176 = load i64, ptr %v176.p
  %v177.p = getelementptr i64, ptr %v174, i64 1
  %v177 = load i64, ptr %v177.p
  %v178.p = getelementptr i64, ptr %v174, i64 2
  %v178 = load i64, ptr %v178.p
  %v179 = call i64 @"std/strings.HasPrefix"(i64 %v168, i64 %v169, i64 %v170, i64 %v176, i64 %v177, i64 %v178)
  %c.b18 = icmp ne i64 %v179, 0
  br i1 %c.b18, label %b18.t55, label %b18.e56
b18.t55:
  br label %b19
b18.e56:
  br label %b20
b19:
  %v180 = add i64 0, 116
  call void @"rt.print_char"(i64 %v180)
  %v181 = add i64 0, 114
  call void @"rt.print_char"(i64 %v181)
  %v182 = add i64 0, 117
  call void @"rt.print_char"(i64 %v182)
  %v183 = add i64 0, 101
  call void @"rt.print_char"(i64 %v183)
  br label %b21
b20:
  %v184 = add i64 0, 102
  call void @"rt.print_char"(i64 %v184)
  %v185 = add i64 0, 97
  call void @"rt.print_char"(i64 %v185)
  %v186 = add i64 0, 108
  call void @"rt.print_char"(i64 %v186)
  %v187 = add i64 0, 115
  call void @"rt.print_char"(i64 %v187)
  %v188 = add i64 0, 101
  call void @"rt.print_char"(i64 %v188)
  br label %b21
b21:
  %v189 = add i64 0, 10
  call void @"rt.print_char"(i64 %v189)
  %v190 = getelementptr i64, ptr @"str.6", i64 0
  %v191 = add i64 0, 3
  %v192 = add i64 0, 0
  %v193 = getelementptr i64, ptr %s1, i64 0
  %v194 = ptrtoint ptr %v190 to i64
  %st56 = getelementptr i64, ptr %v193, i64 0
  store i64 %v194, ptr %st56
  %st57 = getelementptr i64, ptr %v193, i64 1
  store i64 %v191, ptr %st57
  %st58 = getelementptr i64, ptr %v193, i64 2
  store i64 %v192, ptr %st58
  %v195.p = getelementptr i64, ptr %v193, i64 0
  %v195 = load i64, ptr %v195.p
  %v196.p = getelementptr i64, ptr %v193, i64 1
  %v196 = load i64, ptr %v196.p
  %v197.p = getelementptr i64, ptr %v193, i64 2
  %v197 = load i64, ptr %v197.p
  %v198 = getelementptr i64, ptr @"str.7", i64 0
  %v199 = add i64 0, 4
  %v200 = add i64 0, 0
  %v201 = getelementptr i64, ptr %s0, i64 0
  %v202 = ptrtoint ptr %v198 to i64
  %st59 = getelementptr i64, ptr %v201, i64 0
  store i64 %v202, ptr %st59
  %st60 = getelementptr i64, ptr %v201, i64 1
  store i64 %v199, ptr %st60
  %st61 = getelementptr i64, ptr %v201, i64 2
  store i64 %v200, ptr %st61
  %v203.p = getelementptr i64, ptr %v201, i64 0
  %v203 = load i64, ptr %v203.p
  %v204.p = getelementptr i64, ptr %v201, i64 1
  %v204 = load i64, ptr %v204.p
  %v205.p = getelementptr i64, ptr %v201, i64 2
  %v205 = load i64, ptr %v205.p
  %v206 = call i64 @"std/strings.HasPrefix"(i64 %v195, i64 %v196, i64 %v197, i64 %v203, i64 %v204, i64 %v205)
  %c.b21 = icmp ne i64 %v206, 0
  br i1 %c.b21, label %b21.t63, label %b21.e64
b21.t63:
  br label %b22
b21.e64:
  br label %b23
b22:
  %v207 = add i64 0, 116
  call void @"rt.print_char"(i64 %v207)
  %v208 = add i64 0, 114
  call void @"rt.print_char"(i64 %v208)
  %v209 = add i64 0, 117
  call void @"rt.print_char"(i64 %v209)
  %v210 = add i64 0, 101
  call void @"rt.print_char"(i64 %v210)
  br label %b24
b23:
  %v211 = add i64 0, 102
  call void @"rt.print_char"(i64 %v211)
  %v212 = add i64 0, 97
  call void @"rt.print_char"(i64 %v212)
  %v213 = add i64 0, 108
  call void @"rt.print_char"(i64 %v213)
  %v214 = add i64 0, 115
  call void @"rt.print_char"(i64 %v214)
  %v215 = add i64 0, 101
  call void @"rt.print_char"(i64 %v215)
  br label %b24
b24:
  %v216 = add i64 0, 10
  call void @"rt.print_char"(i64 %v216)
  %v217 = getelementptr i64, ptr @"str.0", i64 0
  %v218 = add i64 0, 11
  %v219 = add i64 0, 0
  %v220 = getelementptr i64, ptr %s0, i64 0
  %v221 = ptrtoint ptr %v217 to i64
  %st64 = getelementptr i64, ptr %v220, i64 0
  store i64 %v221, ptr %st64
  %st65 = getelementptr i64, ptr %v220, i64 1
  store i64 %v218, ptr %st65
  %st66 = getelementptr i64, ptr %v220, i64 2
  store i64 %v219, ptr %st66
  %v222.p = getelementptr i64, ptr %v220, i64 0
  %v222 = load i64, ptr %v222.p
  %v223.p = getelementptr i64, ptr %v220, i64 1
  %v223 = load i64, ptr %v223.p
  %v224.p = getelementptr i64, ptr %v220, i64 2
  %v224 = load i64, ptr %v224.p
  %v225 = getelementptr i64, ptr @"str.2", i64 0
  %v226 = add i64 0, 5
  %v227 = add i64 0, 0
  %v228 = getelementptr i64, ptr %s1, i64 0
  %v229 = ptrtoint ptr %v225 to i64
  %st67 = getelementptr i64, ptr %v228, i64 0
  store i64 %v229, ptr %st67
  %st68 = getelementptr i64, ptr %v228, i64 1
  store i64 %v226, ptr %st68
  %st69 = getelementptr i64, ptr %v228, i64 2
  store i64 %v227, ptr %st69
  %v230.p = getelementptr i64, ptr %v228, i64 0
  %v230 = load i64, ptr %v230.p
  %v231.p = getelementptr i64, ptr %v228, i64 1
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v228, i64 2
  %v232 = load i64, ptr %v232.p
  %v233 = call i64 @"std/strings.HasSuffix"(i64 %v222, i64 %v223, i64 %v224, i64 %v230, i64 %v231, i64 %v232)
  %c.b24 = icmp ne i64 %v233, 0
  br i1 %c.b24, label %b24.t71, label %b24.e72
b24.t71:
  br label %b25
b24.e72:
  br label %b26
b25:
  %v234 = add i64 0, 116
  call void @"rt.print_char"(i64 %v234)
  %v235 = add i64 0, 114
  call void @"rt.print_char"(i64 %v235)
  %v236 = add i64 0, 117
  call void @"rt.print_char"(i64 %v236)
  %v237 = add i64 0, 101
  call void @"rt.print_char"(i64 %v237)
  br label %b27
b26:
  %v238 = add i64 0, 102
  call void @"rt.print_char"(i64 %v238)
  %v239 = add i64 0, 97
  call void @"rt.print_char"(i64 %v239)
  %v240 = add i64 0, 108
  call void @"rt.print_char"(i64 %v240)
  %v241 = add i64 0, 115
  call void @"rt.print_char"(i64 %v241)
  %v242 = add i64 0, 101
  call void @"rt.print_char"(i64 %v242)
  br label %b27
b27:
  %v243 = add i64 0, 10
  call void @"rt.print_char"(i64 %v243)
  %v244 = getelementptr i64, ptr @"str.0", i64 0
  %v245 = add i64 0, 11
  %v246 = add i64 0, 0
  %v247 = getelementptr i64, ptr %s1, i64 0
  %v248 = ptrtoint ptr %v244 to i64
  %st72 = getelementptr i64, ptr %v247, i64 0
  store i64 %v248, ptr %st72
  %st73 = getelementptr i64, ptr %v247, i64 1
  store i64 %v245, ptr %st73
  %st74 = getelementptr i64, ptr %v247, i64 2
  store i64 %v246, ptr %st74
  %v249.p = getelementptr i64, ptr %v247, i64 0
  %v249 = load i64, ptr %v249.p
  %v250.p = getelementptr i64, ptr %v247, i64 1
  %v250 = load i64, ptr %v250.p
  %v251.p = getelementptr i64, ptr %v247, i64 2
  %v251 = load i64, ptr %v251.p
  %v252 = getelementptr i64, ptr @"str.1", i64 0
  %v253 = add i64 0, 5
  %v254 = add i64 0, 0
  %v255 = getelementptr i64, ptr %s0, i64 0
  %v256 = ptrtoint ptr %v252 to i64
  %st75 = getelementptr i64, ptr %v255, i64 0
  store i64 %v256, ptr %st75
  %st76 = getelementptr i64, ptr %v255, i64 1
  store i64 %v253, ptr %st76
  %st77 = getelementptr i64, ptr %v255, i64 2
  store i64 %v254, ptr %st77
  %v257.p = getelementptr i64, ptr %v255, i64 0
  %v257 = load i64, ptr %v257.p
  %v258.p = getelementptr i64, ptr %v255, i64 1
  %v258 = load i64, ptr %v258.p
  %v259.p = getelementptr i64, ptr %v255, i64 2
  %v259 = load i64, ptr %v259.p
  %v260 = call i64 @"std/strings.HasSuffix"(i64 %v249, i64 %v250, i64 %v251, i64 %v257, i64 %v258, i64 %v259)
  %c.b27 = icmp ne i64 %v260, 0
  br i1 %c.b27, label %b27.t79, label %b27.e80
b27.t79:
  br label %b28
b27.e80:
  br label %b29
b28:
  %v261 = add i64 0, 116
  call void @"rt.print_char"(i64 %v261)
  %v262 = add i64 0, 114
  call void @"rt.print_char"(i64 %v262)
  %v263 = add i64 0, 117
  call void @"rt.print_char"(i64 %v263)
  %v264 = add i64 0, 101
  call void @"rt.print_char"(i64 %v264)
  br label %b30
b29:
  %v265 = add i64 0, 102
  call void @"rt.print_char"(i64 %v265)
  %v266 = add i64 0, 97
  call void @"rt.print_char"(i64 %v266)
  %v267 = add i64 0, 108
  call void @"rt.print_char"(i64 %v267)
  %v268 = add i64 0, 115
  call void @"rt.print_char"(i64 %v268)
  %v269 = add i64 0, 101
  call void @"rt.print_char"(i64 %v269)
  br label %b30
b30:
  %v270 = add i64 0, 10
  call void @"rt.print_char"(i64 %v270)
  %v271 = getelementptr i64, ptr @"str.8", i64 0
  %v272 = add i64 0, 2
  %v273 = add i64 0, 0
  %v274 = getelementptr i64, ptr %s0, i64 0
  %v275 = ptrtoint ptr %v271 to i64
  %st80 = getelementptr i64, ptr %v274, i64 0
  store i64 %v275, ptr %st80
  %st81 = getelementptr i64, ptr %v274, i64 1
  store i64 %v272, ptr %st81
  %st82 = getelementptr i64, ptr %v274, i64 2
  store i64 %v273, ptr %st82
  %v276.p = getelementptr i64, ptr %v274, i64 0
  %v276 = load i64, ptr %v276.p
  %v277.p = getelementptr i64, ptr %v274, i64 1
  %v277 = load i64, ptr %v277.p
  %v278.p = getelementptr i64, ptr %v274, i64 2
  %v278 = load i64, ptr %v278.p
  %v279 = getelementptr i64, ptr @"str.1", i64 0
  %v280 = add i64 0, 5
  %v281 = add i64 0, 0
  %v282 = getelementptr i64, ptr %s1, i64 0
  %v283 = ptrtoint ptr %v279 to i64
  %st83 = getelementptr i64, ptr %v282, i64 0
  store i64 %v283, ptr %st83
  %st84 = getelementptr i64, ptr %v282, i64 1
  store i64 %v280, ptr %st84
  %st85 = getelementptr i64, ptr %v282, i64 2
  store i64 %v281, ptr %st85
  %v284.p = getelementptr i64, ptr %v282, i64 0
  %v284 = load i64, ptr %v284.p
  %v285.p = getelementptr i64, ptr %v282, i64 1
  %v285 = load i64, ptr %v285.p
  %v286.p = getelementptr i64, ptr %v282, i64 2
  %v286 = load i64, ptr %v286.p
  %v287 = call i64 @"std/strings.HasSuffix"(i64 %v276, i64 %v277, i64 %v278, i64 %v284, i64 %v285, i64 %v286)
  %c.b30 = icmp ne i64 %v287, 0
  br i1 %c.b30, label %b30.t87, label %b30.e88
b30.t87:
  br label %b31
b30.e88:
  br label %b32
b31:
  %v288 = add i64 0, 116
  call void @"rt.print_char"(i64 %v288)
  %v289 = add i64 0, 114
  call void @"rt.print_char"(i64 %v289)
  %v290 = add i64 0, 117
  call void @"rt.print_char"(i64 %v290)
  %v291 = add i64 0, 101
  call void @"rt.print_char"(i64 %v291)
  br label %b33
b32:
  %v292 = add i64 0, 102
  call void @"rt.print_char"(i64 %v292)
  %v293 = add i64 0, 97
  call void @"rt.print_char"(i64 %v293)
  %v294 = add i64 0, 108
  call void @"rt.print_char"(i64 %v294)
  %v295 = add i64 0, 115
  call void @"rt.print_char"(i64 %v295)
  %v296 = add i64 0, 101
  call void @"rt.print_char"(i64 %v296)
  br label %b33
b33:
  %v297 = add i64 0, 10
  call void @"rt.print_char"(i64 %v297)
  %v298 = getelementptr i64, ptr @"str.6", i64 0
  %v299 = add i64 0, 3
  %v300 = add i64 0, 0
  %v301 = getelementptr i64, ptr %s1, i64 0
  %v302 = ptrtoint ptr %v298 to i64
  %st88 = getelementptr i64, ptr %v301, i64 0
  store i64 %v302, ptr %st88
  %st89 = getelementptr i64, ptr %v301, i64 1
  store i64 %v299, ptr %st89
  %st90 = getelementptr i64, ptr %v301, i64 2
  store i64 %v300, ptr %st90
  %v303.p = getelementptr i64, ptr %v301, i64 0
  %v303 = load i64, ptr %v303.p
  %v304.p = getelementptr i64, ptr %v301, i64 1
  %v304 = load i64, ptr %v304.p
  %v305.p = getelementptr i64, ptr %v301, i64 2
  %v305 = load i64, ptr %v305.p
  %v306 = getelementptr i64, ptr @"str.4", i64 0
  %v307 = add i64 0, 0
  %v308 = add i64 0, 0
  %v309 = getelementptr i64, ptr %s0, i64 0
  %v310 = ptrtoint ptr %v306 to i64
  %st91 = getelementptr i64, ptr %v309, i64 0
  store i64 %v310, ptr %st91
  %st92 = getelementptr i64, ptr %v309, i64 1
  store i64 %v307, ptr %st92
  %st93 = getelementptr i64, ptr %v309, i64 2
  store i64 %v308, ptr %st93
  %v311.p = getelementptr i64, ptr %v309, i64 0
  %v311 = load i64, ptr %v311.p
  %v312.p = getelementptr i64, ptr %v309, i64 1
  %v312 = load i64, ptr %v312.p
  %v313.p = getelementptr i64, ptr %v309, i64 2
  %v313 = load i64, ptr %v313.p
  %v314 = call i64 @"std/strings.HasSuffix"(i64 %v303, i64 %v304, i64 %v305, i64 %v311, i64 %v312, i64 %v313)
  %c.b33 = icmp ne i64 %v314, 0
  br i1 %c.b33, label %b33.t95, label %b33.e96
b33.t95:
  br label %b34
b33.e96:
  br label %b35
b34:
  %v315 = add i64 0, 116
  call void @"rt.print_char"(i64 %v315)
  %v316 = add i64 0, 114
  call void @"rt.print_char"(i64 %v316)
  %v317 = add i64 0, 117
  call void @"rt.print_char"(i64 %v317)
  %v318 = add i64 0, 101
  call void @"rt.print_char"(i64 %v318)
  br label %b36
b35:
  %v319 = add i64 0, 102
  call void @"rt.print_char"(i64 %v319)
  %v320 = add i64 0, 97
  call void @"rt.print_char"(i64 %v320)
  %v321 = add i64 0, 108
  call void @"rt.print_char"(i64 %v321)
  %v322 = add i64 0, 115
  call void @"rt.print_char"(i64 %v322)
  %v323 = add i64 0, 101
  call void @"rt.print_char"(i64 %v323)
  br label %b36
b36:
  %v324 = add i64 0, 10
  call void @"rt.print_char"(i64 %v324)
  %v325 = getelementptr i64, ptr @"str.4", i64 0
  %v326 = add i64 0, 0
  %v327 = add i64 0, 0
  %v328 = getelementptr i64, ptr %s0, i64 0
  %v329 = ptrtoint ptr %v325 to i64
  %st96 = getelementptr i64, ptr %v328, i64 0
  store i64 %v329, ptr %st96
  %st97 = getelementptr i64, ptr %v328, i64 1
  store i64 %v326, ptr %st97
  %st98 = getelementptr i64, ptr %v328, i64 2
  store i64 %v327, ptr %st98
  %v330.p = getelementptr i64, ptr %v328, i64 0
  %v330 = load i64, ptr %v330.p
  %v331.p = getelementptr i64, ptr %v328, i64 1
  %v331 = load i64, ptr %v331.p
  %v332.p = getelementptr i64, ptr %v328, i64 2
  %v332 = load i64, ptr %v332.p
  %v333 = getelementptr i64, ptr @"str.4", i64 0
  %v334 = add i64 0, 0
  %v335 = add i64 0, 0
  %v336 = getelementptr i64, ptr %s1, i64 0
  %v337 = ptrtoint ptr %v333 to i64
  %st99 = getelementptr i64, ptr %v336, i64 0
  store i64 %v337, ptr %st99
  %st100 = getelementptr i64, ptr %v336, i64 1
  store i64 %v334, ptr %st100
  %st101 = getelementptr i64, ptr %v336, i64 2
  store i64 %v335, ptr %st101
  %v338.p = getelementptr i64, ptr %v336, i64 0
  %v338 = load i64, ptr %v338.p
  %v339.p = getelementptr i64, ptr %v336, i64 1
  %v339 = load i64, ptr %v339.p
  %v340.p = getelementptr i64, ptr %v336, i64 2
  %v340 = load i64, ptr %v340.p
  %v341 = call i64 @"std/strings.HasSuffix"(i64 %v330, i64 %v331, i64 %v332, i64 %v338, i64 %v339, i64 %v340)
  %c.b36 = icmp ne i64 %v341, 0
  br i1 %c.b36, label %b36.t103, label %b36.e104
b36.t103:
  br label %b37
b36.e104:
  br label %b38
b37:
  %v342 = add i64 0, 116
  call void @"rt.print_char"(i64 %v342)
  %v343 = add i64 0, 114
  call void @"rt.print_char"(i64 %v343)
  %v344 = add i64 0, 117
  call void @"rt.print_char"(i64 %v344)
  %v345 = add i64 0, 101
  call void @"rt.print_char"(i64 %v345)
  br label %b39
b38:
  %v346 = add i64 0, 102
  call void @"rt.print_char"(i64 %v346)
  %v347 = add i64 0, 97
  call void @"rt.print_char"(i64 %v347)
  %v348 = add i64 0, 108
  call void @"rt.print_char"(i64 %v348)
  %v349 = add i64 0, 115
  call void @"rt.print_char"(i64 %v349)
  %v350 = add i64 0, 101
  call void @"rt.print_char"(i64 %v350)
  br label %b39
b39:
  %v351 = add i64 0, 10
  call void @"rt.print_char"(i64 %v351)
  %v352 = getelementptr i64, ptr @"str.6", i64 0
  %v353 = add i64 0, 3
  %v354 = add i64 0, 0
  %v355 = getelementptr i64, ptr %s1, i64 0
  %v356 = ptrtoint ptr %v352 to i64
  %st104 = getelementptr i64, ptr %v355, i64 0
  store i64 %v356, ptr %st104
  %st105 = getelementptr i64, ptr %v355, i64 1
  store i64 %v353, ptr %st105
  %st106 = getelementptr i64, ptr %v355, i64 2
  store i64 %v354, ptr %st106
  %v357.p = getelementptr i64, ptr %v355, i64 0
  %v357 = load i64, ptr %v357.p
  %v358.p = getelementptr i64, ptr %v355, i64 1
  %v358 = load i64, ptr %v358.p
  %v359.p = getelementptr i64, ptr %v355, i64 2
  %v359 = load i64, ptr %v359.p
  %v360 = getelementptr i64, ptr @"str.6", i64 0
  %v361 = add i64 0, 3
  %v362 = add i64 0, 0
  %v363 = getelementptr i64, ptr %s0, i64 0
  %v364 = ptrtoint ptr %v360 to i64
  %st107 = getelementptr i64, ptr %v363, i64 0
  store i64 %v364, ptr %st107
  %st108 = getelementptr i64, ptr %v363, i64 1
  store i64 %v361, ptr %st108
  %st109 = getelementptr i64, ptr %v363, i64 2
  store i64 %v362, ptr %st109
  %v365.p = getelementptr i64, ptr %v363, i64 0
  %v365 = load i64, ptr %v365.p
  %v366.p = getelementptr i64, ptr %v363, i64 1
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v363, i64 2
  %v367 = load i64, ptr %v367.p
  %v368 = call i64 @"std/strings.HasSuffix"(i64 %v357, i64 %v358, i64 %v359, i64 %v365, i64 %v366, i64 %v367)
  %c.b39 = icmp ne i64 %v368, 0
  br i1 %c.b39, label %b39.t111, label %b39.e112
b39.t111:
  br label %b40
b39.e112:
  br label %b41
b40:
  %v369 = add i64 0, 116
  call void @"rt.print_char"(i64 %v369)
  %v370 = add i64 0, 114
  call void @"rt.print_char"(i64 %v370)
  %v371 = add i64 0, 117
  call void @"rt.print_char"(i64 %v371)
  %v372 = add i64 0, 101
  call void @"rt.print_char"(i64 %v372)
  br label %b42
b41:
  %v373 = add i64 0, 102
  call void @"rt.print_char"(i64 %v373)
  %v374 = add i64 0, 97
  call void @"rt.print_char"(i64 %v374)
  %v375 = add i64 0, 108
  call void @"rt.print_char"(i64 %v375)
  %v376 = add i64 0, 115
  call void @"rt.print_char"(i64 %v376)
  %v377 = add i64 0, 101
  call void @"rt.print_char"(i64 %v377)
  br label %b42
b42:
  %v378 = add i64 0, 10
  call void @"rt.print_char"(i64 %v378)
  %v379 = getelementptr i64, ptr @"str.9", i64 0
  %v380 = add i64 0, 6
  %v381 = add i64 0, 0
  %v382 = getelementptr i64, ptr %s0, i64 0
  %v383 = ptrtoint ptr %v379 to i64
  %st112 = getelementptr i64, ptr %v382, i64 0
  store i64 %v383, ptr %st112
  %st113 = getelementptr i64, ptr %v382, i64 1
  store i64 %v380, ptr %st113
  %st114 = getelementptr i64, ptr %v382, i64 2
  store i64 %v381, ptr %st114
  %v384.p = getelementptr i64, ptr %v382, i64 0
  %v384 = load i64, ptr %v384.p
  %v385.p = getelementptr i64, ptr %v382, i64 1
  %v385 = load i64, ptr %v385.p
  %v386.p = getelementptr i64, ptr %v382, i64 2
  %v386 = load i64, ptr %v386.p
  %v387 = getelementptr i64, ptr @"str.10", i64 0
  %v388 = add i64 0, 4
  %v389 = add i64 0, 0
  %v390 = getelementptr i64, ptr %s1, i64 0
  %v391 = ptrtoint ptr %v387 to i64
  %st115 = getelementptr i64, ptr %v390, i64 0
  store i64 %v391, ptr %st115
  %st116 = getelementptr i64, ptr %v390, i64 1
  store i64 %v388, ptr %st116
  %st117 = getelementptr i64, ptr %v390, i64 2
  store i64 %v389, ptr %st117
  %v392.p = getelementptr i64, ptr %v390, i64 0
  %v392 = load i64, ptr %v392.p
  %v393.p = getelementptr i64, ptr %v390, i64 1
  %v393 = load i64, ptr %v393.p
  %v394.p = getelementptr i64, ptr %v390, i64 2
  %v394 = load i64, ptr %v394.p
  %v395 = call i64 @"std/strings.HasSuffix"(i64 %v384, i64 %v385, i64 %v386, i64 %v392, i64 %v393, i64 %v394)
  %c.b42 = icmp ne i64 %v395, 0
  br i1 %c.b42, label %b42.t119, label %b42.e120
b42.t119:
  br label %b43
b42.e120:
  br label %b44
b43:
  %v396 = add i64 0, 116
  call void @"rt.print_char"(i64 %v396)
  %v397 = add i64 0, 114
  call void @"rt.print_char"(i64 %v397)
  %v398 = add i64 0, 117
  call void @"rt.print_char"(i64 %v398)
  %v399 = add i64 0, 101
  call void @"rt.print_char"(i64 %v399)
  br label %b45
b44:
  %v400 = add i64 0, 102
  call void @"rt.print_char"(i64 %v400)
  %v401 = add i64 0, 97
  call void @"rt.print_char"(i64 %v401)
  %v402 = add i64 0, 108
  call void @"rt.print_char"(i64 %v402)
  %v403 = add i64 0, 115
  call void @"rt.print_char"(i64 %v403)
  %v404 = add i64 0, 101
  call void @"rt.print_char"(i64 %v404)
  br label %b45
b45:
  %v405 = add i64 0, 10
  call void @"rt.print_char"(i64 %v405)
  %v406 = getelementptr i64, ptr @"str.11", i64 0
  %v407 = add i64 0, 7
  %v408 = add i64 0, 0
  %v409 = getelementptr i64, ptr %s1, i64 0
  %v410 = ptrtoint ptr %v406 to i64
  %st120 = getelementptr i64, ptr %v409, i64 0
  store i64 %v410, ptr %st120
  %st121 = getelementptr i64, ptr %v409, i64 1
  store i64 %v407, ptr %st121
  %st122 = getelementptr i64, ptr %v409, i64 2
  store i64 %v408, ptr %st122
  %v411.p = getelementptr i64, ptr %v409, i64 0
  %v411 = load i64, ptr %v411.p
  %v412.p = getelementptr i64, ptr %v409, i64 1
  %v412 = load i64, ptr %v412.p
  %v413.p = getelementptr i64, ptr %v409, i64 2
  %v413 = load i64, ptr %v413.p
  %v414 = getelementptr i64, ptr @"str.12", i64 0
  %v415 = add i64 0, 3
  %v416 = add i64 0, 0
  %v417 = getelementptr i64, ptr %s0, i64 0
  %v418 = ptrtoint ptr %v414 to i64
  %st123 = getelementptr i64, ptr %v417, i64 0
  store i64 %v418, ptr %st123
  %st124 = getelementptr i64, ptr %v417, i64 1
  store i64 %v415, ptr %st124
  %st125 = getelementptr i64, ptr %v417, i64 2
  store i64 %v416, ptr %st125
  %v419.p = getelementptr i64, ptr %v417, i64 0
  %v419 = load i64, ptr %v419.p
  %v420.p = getelementptr i64, ptr %v417, i64 1
  %v420 = load i64, ptr %v420.p
  %v421.p = getelementptr i64, ptr %v417, i64 2
  %v421 = load i64, ptr %v421.p
  %v422 = call i64 @"std/strings.Index"(i64 %v411, i64 %v412, i64 %v413, i64 %v419, i64 %v420, i64 %v421)
  call void @"rt.print_int"(i64 %v422)
  %v423 = add i64 0, 10
  call void @"rt.print_char"(i64 %v423)
  %v424 = getelementptr i64, ptr @"str.11", i64 0
  %v425 = add i64 0, 7
  %v426 = add i64 0, 0
  %v427 = getelementptr i64, ptr %s0, i64 0
  %v428 = ptrtoint ptr %v424 to i64
  %st126 = getelementptr i64, ptr %v427, i64 0
  store i64 %v428, ptr %st126
  %st127 = getelementptr i64, ptr %v427, i64 1
  store i64 %v425, ptr %st127
  %st128 = getelementptr i64, ptr %v427, i64 2
  store i64 %v426, ptr %st128
  %v429.p = getelementptr i64, ptr %v427, i64 0
  %v429 = load i64, ptr %v429.p
  %v430.p = getelementptr i64, ptr %v427, i64 1
  %v430 = load i64, ptr %v430.p
  %v431.p = getelementptr i64, ptr %v427, i64 2
  %v431 = load i64, ptr %v431.p
  %v432 = getelementptr i64, ptr @"str.13", i64 0
  %v433 = add i64 0, 3
  %v434 = add i64 0, 0
  %v435 = getelementptr i64, ptr %s1, i64 0
  %v436 = ptrtoint ptr %v432 to i64
  %st129 = getelementptr i64, ptr %v435, i64 0
  store i64 %v436, ptr %st129
  %st130 = getelementptr i64, ptr %v435, i64 1
  store i64 %v433, ptr %st130
  %st131 = getelementptr i64, ptr %v435, i64 2
  store i64 %v434, ptr %st131
  %v437.p = getelementptr i64, ptr %v435, i64 0
  %v437 = load i64, ptr %v437.p
  %v438.p = getelementptr i64, ptr %v435, i64 1
  %v438 = load i64, ptr %v438.p
  %v439.p = getelementptr i64, ptr %v435, i64 2
  %v439 = load i64, ptr %v439.p
  %v440 = call i64 @"std/strings.Index"(i64 %v429, i64 %v430, i64 %v431, i64 %v437, i64 %v438, i64 %v439)
  call void @"rt.print_int"(i64 %v440)
  %v441 = add i64 0, 10
  call void @"rt.print_char"(i64 %v441)
  %v442 = getelementptr i64, ptr @"str.6", i64 0
  %v443 = add i64 0, 3
  %v444 = add i64 0, 0
  %v445 = getelementptr i64, ptr %s1, i64 0
  %v446 = ptrtoint ptr %v442 to i64
  %st132 = getelementptr i64, ptr %v445, i64 0
  store i64 %v446, ptr %st132
  %st133 = getelementptr i64, ptr %v445, i64 1
  store i64 %v443, ptr %st133
  %st134 = getelementptr i64, ptr %v445, i64 2
  store i64 %v444, ptr %st134
  %v447.p = getelementptr i64, ptr %v445, i64 0
  %v447 = load i64, ptr %v447.p
  %v448.p = getelementptr i64, ptr %v445, i64 1
  %v448 = load i64, ptr %v448.p
  %v449.p = getelementptr i64, ptr %v445, i64 2
  %v449 = load i64, ptr %v449.p
  %v450 = getelementptr i64, ptr @"str.4", i64 0
  %v451 = add i64 0, 0
  %v452 = add i64 0, 0
  %v453 = getelementptr i64, ptr %s0, i64 0
  %v454 = ptrtoint ptr %v450 to i64
  %st135 = getelementptr i64, ptr %v453, i64 0
  store i64 %v454, ptr %st135
  %st136 = getelementptr i64, ptr %v453, i64 1
  store i64 %v451, ptr %st136
  %st137 = getelementptr i64, ptr %v453, i64 2
  store i64 %v452, ptr %st137
  %v455.p = getelementptr i64, ptr %v453, i64 0
  %v455 = load i64, ptr %v455.p
  %v456.p = getelementptr i64, ptr %v453, i64 1
  %v456 = load i64, ptr %v456.p
  %v457.p = getelementptr i64, ptr %v453, i64 2
  %v457 = load i64, ptr %v457.p
  %v458 = call i64 @"std/strings.Index"(i64 %v447, i64 %v448, i64 %v449, i64 %v455, i64 %v456, i64 %v457)
  call void @"rt.print_int"(i64 %v458)
  %v459 = add i64 0, 10
  call void @"rt.print_char"(i64 %v459)
  %v460 = getelementptr i64, ptr @"str.4", i64 0
  %v461 = add i64 0, 0
  %v462 = add i64 0, 0
  %v463 = getelementptr i64, ptr %s0, i64 0
  %v464 = ptrtoint ptr %v460 to i64
  %st138 = getelementptr i64, ptr %v463, i64 0
  store i64 %v464, ptr %st138
  %st139 = getelementptr i64, ptr %v463, i64 1
  store i64 %v461, ptr %st139
  %st140 = getelementptr i64, ptr %v463, i64 2
  store i64 %v462, ptr %st140
  %v465.p = getelementptr i64, ptr %v463, i64 0
  %v465 = load i64, ptr %v465.p
  %v466.p = getelementptr i64, ptr %v463, i64 1
  %v466 = load i64, ptr %v466.p
  %v467.p = getelementptr i64, ptr %v463, i64 2
  %v467 = load i64, ptr %v467.p
  %v468 = getelementptr i64, ptr @"str.4", i64 0
  %v469 = add i64 0, 0
  %v470 = add i64 0, 0
  %v471 = getelementptr i64, ptr %s1, i64 0
  %v472 = ptrtoint ptr %v468 to i64
  %st141 = getelementptr i64, ptr %v471, i64 0
  store i64 %v472, ptr %st141
  %st142 = getelementptr i64, ptr %v471, i64 1
  store i64 %v469, ptr %st142
  %st143 = getelementptr i64, ptr %v471, i64 2
  store i64 %v470, ptr %st143
  %v473.p = getelementptr i64, ptr %v471, i64 0
  %v473 = load i64, ptr %v473.p
  %v474.p = getelementptr i64, ptr %v471, i64 1
  %v474 = load i64, ptr %v474.p
  %v475.p = getelementptr i64, ptr %v471, i64 2
  %v475 = load i64, ptr %v475.p
  %v476 = call i64 @"std/strings.Index"(i64 %v465, i64 %v466, i64 %v467, i64 %v473, i64 %v474, i64 %v475)
  call void @"rt.print_int"(i64 %v476)
  %v477 = add i64 0, 10
  call void @"rt.print_char"(i64 %v477)
  %v478 = getelementptr i64, ptr @"str.4", i64 0
  %v479 = add i64 0, 0
  %v480 = add i64 0, 0
  %v481 = getelementptr i64, ptr %s1, i64 0
  %v482 = ptrtoint ptr %v478 to i64
  %st144 = getelementptr i64, ptr %v481, i64 0
  store i64 %v482, ptr %st144
  %st145 = getelementptr i64, ptr %v481, i64 1
  store i64 %v479, ptr %st145
  %st146 = getelementptr i64, ptr %v481, i64 2
  store i64 %v480, ptr %st146
  %v483.p = getelementptr i64, ptr %v481, i64 0
  %v483 = load i64, ptr %v483.p
  %v484.p = getelementptr i64, ptr %v481, i64 1
  %v484 = load i64, ptr %v484.p
  %v485.p = getelementptr i64, ptr %v481, i64 2
  %v485 = load i64, ptr %v485.p
  %v486 = getelementptr i64, ptr @"str.5", i64 0
  %v487 = add i64 0, 1
  %v488 = add i64 0, 0
  %v489 = getelementptr i64, ptr %s0, i64 0
  %v490 = ptrtoint ptr %v486 to i64
  %st147 = getelementptr i64, ptr %v489, i64 0
  store i64 %v490, ptr %st147
  %st148 = getelementptr i64, ptr %v489, i64 1
  store i64 %v487, ptr %st148
  %st149 = getelementptr i64, ptr %v489, i64 2
  store i64 %v488, ptr %st149
  %v491.p = getelementptr i64, ptr %v489, i64 0
  %v491 = load i64, ptr %v491.p
  %v492.p = getelementptr i64, ptr %v489, i64 1
  %v492 = load i64, ptr %v492.p
  %v493.p = getelementptr i64, ptr %v489, i64 2
  %v493 = load i64, ptr %v493.p
  %v494 = call i64 @"std/strings.Index"(i64 %v483, i64 %v484, i64 %v485, i64 %v491, i64 %v492, i64 %v493)
  call void @"rt.print_int"(i64 %v494)
  %v495 = add i64 0, 10
  call void @"rt.print_char"(i64 %v495)
  %v496 = getelementptr i64, ptr @"str.6", i64 0
  %v497 = add i64 0, 3
  %v498 = add i64 0, 0
  %v499 = getelementptr i64, ptr %s0, i64 0
  %v500 = ptrtoint ptr %v496 to i64
  %st150 = getelementptr i64, ptr %v499, i64 0
  store i64 %v500, ptr %st150
  %st151 = getelementptr i64, ptr %v499, i64 1
  store i64 %v497, ptr %st151
  %st152 = getelementptr i64, ptr %v499, i64 2
  store i64 %v498, ptr %st152
  %v501.p = getelementptr i64, ptr %v499, i64 0
  %v501 = load i64, ptr %v501.p
  %v502.p = getelementptr i64, ptr %v499, i64 1
  %v502 = load i64, ptr %v502.p
  %v503.p = getelementptr i64, ptr %v499, i64 2
  %v503 = load i64, ptr %v503.p
  %v504 = getelementptr i64, ptr @"str.6", i64 0
  %v505 = add i64 0, 3
  %v506 = add i64 0, 0
  %v507 = getelementptr i64, ptr %s1, i64 0
  %v508 = ptrtoint ptr %v504 to i64
  %st153 = getelementptr i64, ptr %v507, i64 0
  store i64 %v508, ptr %st153
  %st154 = getelementptr i64, ptr %v507, i64 1
  store i64 %v505, ptr %st154
  %st155 = getelementptr i64, ptr %v507, i64 2
  store i64 %v506, ptr %st155
  %v509.p = getelementptr i64, ptr %v507, i64 0
  %v509 = load i64, ptr %v509.p
  %v510.p = getelementptr i64, ptr %v507, i64 1
  %v510 = load i64, ptr %v510.p
  %v511.p = getelementptr i64, ptr %v507, i64 2
  %v511 = load i64, ptr %v511.p
  %v512 = call i64 @"std/strings.Index"(i64 %v501, i64 %v502, i64 %v503, i64 %v509, i64 %v510, i64 %v511)
  call void @"rt.print_int"(i64 %v512)
  %v513 = add i64 0, 10
  call void @"rt.print_char"(i64 %v513)
  %v514 = getelementptr i64, ptr @"str.14", i64 0
  %v515 = add i64 0, 2
  %v516 = add i64 0, 0
  %v517 = getelementptr i64, ptr %s1, i64 0
  %v518 = ptrtoint ptr %v514 to i64
  %st156 = getelementptr i64, ptr %v517, i64 0
  store i64 %v518, ptr %st156
  %st157 = getelementptr i64, ptr %v517, i64 1
  store i64 %v515, ptr %st157
  %st158 = getelementptr i64, ptr %v517, i64 2
  store i64 %v516, ptr %st158
  %v519.p = getelementptr i64, ptr %v517, i64 0
  %v519 = load i64, ptr %v519.p
  %v520.p = getelementptr i64, ptr %v517, i64 1
  %v520 = load i64, ptr %v520.p
  %v521.p = getelementptr i64, ptr %v517, i64 2
  %v521 = load i64, ptr %v521.p
  %v522 = getelementptr i64, ptr @"str.6", i64 0
  %v523 = add i64 0, 3
  %v524 = add i64 0, 0
  %v525 = getelementptr i64, ptr %s0, i64 0
  %v526 = ptrtoint ptr %v522 to i64
  %st159 = getelementptr i64, ptr %v525, i64 0
  store i64 %v526, ptr %st159
  %st160 = getelementptr i64, ptr %v525, i64 1
  store i64 %v523, ptr %st160
  %st161 = getelementptr i64, ptr %v525, i64 2
  store i64 %v524, ptr %st161
  %v527.p = getelementptr i64, ptr %v525, i64 0
  %v527 = load i64, ptr %v527.p
  %v528.p = getelementptr i64, ptr %v525, i64 1
  %v528 = load i64, ptr %v528.p
  %v529.p = getelementptr i64, ptr %v525, i64 2
  %v529 = load i64, ptr %v529.p
  %v530 = call i64 @"std/strings.Index"(i64 %v519, i64 %v520, i64 %v521, i64 %v527, i64 %v528, i64 %v529)
  call void @"rt.print_int"(i64 %v530)
  %v531 = add i64 0, 10
  call void @"rt.print_char"(i64 %v531)
  %v532 = getelementptr i64, ptr @"str.15", i64 0
  %v533 = add i64 0, 4
  %v534 = add i64 0, 0
  %v535 = getelementptr i64, ptr %s0, i64 0
  %v536 = ptrtoint ptr %v532 to i64
  %st162 = getelementptr i64, ptr %v535, i64 0
  store i64 %v536, ptr %st162
  %st163 = getelementptr i64, ptr %v535, i64 1
  store i64 %v533, ptr %st163
  %st164 = getelementptr i64, ptr %v535, i64 2
  store i64 %v534, ptr %st164
  %v537.p = getelementptr i64, ptr %v535, i64 0
  %v537 = load i64, ptr %v537.p
  %v538.p = getelementptr i64, ptr %v535, i64 1
  %v538 = load i64, ptr %v538.p
  %v539.p = getelementptr i64, ptr %v535, i64 2
  %v539 = load i64, ptr %v539.p
  %v540 = getelementptr i64, ptr @"str.16", i64 0
  %v541 = add i64 0, 3
  %v542 = add i64 0, 0
  %v543 = getelementptr i64, ptr %s1, i64 0
  %v544 = ptrtoint ptr %v540 to i64
  %st165 = getelementptr i64, ptr %v543, i64 0
  store i64 %v544, ptr %st165
  %st166 = getelementptr i64, ptr %v543, i64 1
  store i64 %v541, ptr %st166
  %st167 = getelementptr i64, ptr %v543, i64 2
  store i64 %v542, ptr %st167
  %v545.p = getelementptr i64, ptr %v543, i64 0
  %v545 = load i64, ptr %v545.p
  %v546.p = getelementptr i64, ptr %v543, i64 1
  %v546 = load i64, ptr %v546.p
  %v547.p = getelementptr i64, ptr %v543, i64 2
  %v547 = load i64, ptr %v547.p
  %v548 = call i64 @"std/strings.Index"(i64 %v537, i64 %v538, i64 %v539, i64 %v545, i64 %v546, i64 %v547)
  call void @"rt.print_int"(i64 %v548)
  %v549 = add i64 0, 10
  call void @"rt.print_char"(i64 %v549)
  %v550 = getelementptr i64, ptr @"str.9", i64 0
  %v551 = add i64 0, 6
  %v552 = add i64 0, 0
  %v553 = getelementptr i64, ptr %s1, i64 0
  %v554 = ptrtoint ptr %v550 to i64
  %st168 = getelementptr i64, ptr %v553, i64 0
  store i64 %v554, ptr %st168
  %st169 = getelementptr i64, ptr %v553, i64 1
  store i64 %v551, ptr %st169
  %st170 = getelementptr i64, ptr %v553, i64 2
  store i64 %v552, ptr %st170
  %v555.p = getelementptr i64, ptr %v553, i64 0
  %v555 = load i64, ptr %v555.p
  %v556.p = getelementptr i64, ptr %v553, i64 1
  %v556 = load i64, ptr %v556.p
  %v557.p = getelementptr i64, ptr %v553, i64 2
  %v557 = load i64, ptr %v557.p
  %v558 = getelementptr i64, ptr @"str.17", i64 0
  %v559 = add i64 0, 3
  %v560 = add i64 0, 0
  %v561 = getelementptr i64, ptr %s0, i64 0
  %v562 = ptrtoint ptr %v558 to i64
  %st171 = getelementptr i64, ptr %v561, i64 0
  store i64 %v562, ptr %st171
  %st172 = getelementptr i64, ptr %v561, i64 1
  store i64 %v559, ptr %st172
  %st173 = getelementptr i64, ptr %v561, i64 2
  store i64 %v560, ptr %st173
  %v563.p = getelementptr i64, ptr %v561, i64 0
  %v563 = load i64, ptr %v563.p
  %v564.p = getelementptr i64, ptr %v561, i64 1
  %v564 = load i64, ptr %v564.p
  %v565.p = getelementptr i64, ptr %v561, i64 2
  %v565 = load i64, ptr %v565.p
  %v566 = call i64 @"std/strings.Index"(i64 %v555, i64 %v556, i64 %v557, i64 %v563, i64 %v564, i64 %v565)
  call void @"rt.print_int"(i64 %v566)
  %v567 = add i64 0, 10
  call void @"rt.print_char"(i64 %v567)
  %v568 = getelementptr i64, ptr @"str.18", i64 0
  %v569 = add i64 0, 5
  %v570 = add i64 0, 0
  %v571 = getelementptr i64, ptr %s0, i64 0
  %v572 = ptrtoint ptr %v568 to i64
  %st174 = getelementptr i64, ptr %v571, i64 0
  store i64 %v572, ptr %st174
  %st175 = getelementptr i64, ptr %v571, i64 1
  store i64 %v569, ptr %st175
  %st176 = getelementptr i64, ptr %v571, i64 2
  store i64 %v570, ptr %st176
  %v573.p = getelementptr i64, ptr %v571, i64 0
  %v573 = load i64, ptr %v573.p
  %v574.p = getelementptr i64, ptr %v571, i64 1
  %v574 = load i64, ptr %v574.p
  %v575.p = getelementptr i64, ptr %v571, i64 2
  %v575 = load i64, ptr %v575.p
  %v576 = getelementptr i64, ptr @"str.19", i64 0
  %v577 = add i64 0, 1
  %v578 = add i64 0, 0
  %v579 = getelementptr i64, ptr %s1, i64 0
  %v580 = ptrtoint ptr %v576 to i64
  %st177 = getelementptr i64, ptr %v579, i64 0
  store i64 %v580, ptr %st177
  %st178 = getelementptr i64, ptr %v579, i64 1
  store i64 %v577, ptr %st178
  %st179 = getelementptr i64, ptr %v579, i64 2
  store i64 %v578, ptr %st179
  %v581.p = getelementptr i64, ptr %v579, i64 0
  %v581 = load i64, ptr %v581.p
  %v582.p = getelementptr i64, ptr %v579, i64 1
  %v582 = load i64, ptr %v582.p
  %v583.p = getelementptr i64, ptr %v579, i64 2
  %v583 = load i64, ptr %v583.p
  %v584 = call i64 @"std/strings.Index"(i64 %v573, i64 %v574, i64 %v575, i64 %v581, i64 %v582, i64 %v583)
  call void @"rt.print_int"(i64 %v584)
  %v585 = add i64 0, 10
  call void @"rt.print_char"(i64 %v585)
  %v586 = getelementptr i64, ptr @"str.20", i64 0
  %v587 = add i64 0, 9
  %v588 = add i64 0, 0
  %v589 = getelementptr i64, ptr %s1, i64 0
  %v590 = ptrtoint ptr %v586 to i64
  %st180 = getelementptr i64, ptr %v589, i64 0
  store i64 %v590, ptr %st180
  %st181 = getelementptr i64, ptr %v589, i64 1
  store i64 %v587, ptr %st181
  %st182 = getelementptr i64, ptr %v589, i64 2
  store i64 %v588, ptr %st182
  %v591.p = getelementptr i64, ptr %v589, i64 0
  %v591 = load i64, ptr %v591.p
  %v592.p = getelementptr i64, ptr %v589, i64 1
  %v592 = load i64, ptr %v592.p
  %v593.p = getelementptr i64, ptr %v589, i64 2
  %v593 = load i64, ptr %v593.p
  %v594 = getelementptr i64, ptr @"str.21", i64 0
  %v595 = add i64 0, 3
  %v596 = add i64 0, 0
  %v597 = getelementptr i64, ptr %s0, i64 0
  %v598 = ptrtoint ptr %v594 to i64
  %st183 = getelementptr i64, ptr %v597, i64 0
  store i64 %v598, ptr %st183
  %st184 = getelementptr i64, ptr %v597, i64 1
  store i64 %v595, ptr %st184
  %st185 = getelementptr i64, ptr %v597, i64 2
  store i64 %v596, ptr %st185
  %v599.p = getelementptr i64, ptr %v597, i64 0
  %v599 = load i64, ptr %v599.p
  %v600.p = getelementptr i64, ptr %v597, i64 1
  %v600 = load i64, ptr %v600.p
  %v601.p = getelementptr i64, ptr %v597, i64 2
  %v601 = load i64, ptr %v601.p
  %v602 = call i64 @"std/strings.Index"(i64 %v591, i64 %v592, i64 %v593, i64 %v599, i64 %v600, i64 %v601)
  call void @"rt.print_int"(i64 %v602)
  %v603 = add i64 0, 10
  call void @"rt.print_char"(i64 %v603)
  %v604 = getelementptr i64, ptr @"str.20", i64 0
  %v605 = add i64 0, 9
  %v606 = add i64 0, 0
  %v607 = getelementptr i64, ptr %s0, i64 0
  %v608 = ptrtoint ptr %v604 to i64
  %st186 = getelementptr i64, ptr %v607, i64 0
  store i64 %v608, ptr %st186
  %st187 = getelementptr i64, ptr %v607, i64 1
  store i64 %v605, ptr %st187
  %st188 = getelementptr i64, ptr %v607, i64 2
  store i64 %v606, ptr %st188
  %v609.p = getelementptr i64, ptr %v607, i64 0
  %v609 = load i64, ptr %v609.p
  %v610.p = getelementptr i64, ptr %v607, i64 1
  %v610 = load i64, ptr %v610.p
  %v611.p = getelementptr i64, ptr %v607, i64 2
  %v611 = load i64, ptr %v611.p
  %v612 = getelementptr i64, ptr @"str.22", i64 0
  %v613 = add i64 0, 3
  %v614 = add i64 0, 0
  %v615 = getelementptr i64, ptr %s1, i64 0
  %v616 = ptrtoint ptr %v612 to i64
  %st189 = getelementptr i64, ptr %v615, i64 0
  store i64 %v616, ptr %st189
  %st190 = getelementptr i64, ptr %v615, i64 1
  store i64 %v613, ptr %st190
  %st191 = getelementptr i64, ptr %v615, i64 2
  store i64 %v614, ptr %st191
  %v617.p = getelementptr i64, ptr %v615, i64 0
  %v617 = load i64, ptr %v617.p
  %v618.p = getelementptr i64, ptr %v615, i64 1
  %v618 = load i64, ptr %v618.p
  %v619.p = getelementptr i64, ptr %v615, i64 2
  %v619 = load i64, ptr %v619.p
  %v620 = call i64 @"std/strings.Index"(i64 %v609, i64 %v610, i64 %v611, i64 %v617, i64 %v618, i64 %v619)
  call void @"rt.print_int"(i64 %v620)
  %v621 = add i64 0, 10
  call void @"rt.print_char"(i64 %v621)
  %v622 = getelementptr i64, ptr @"str.23", i64 0
  %v623 = add i64 0, 7
  %v624 = add i64 0, 0
  %v625 = getelementptr i64, ptr %s1, i64 0
  %v626 = ptrtoint ptr %v622 to i64
  %st192 = getelementptr i64, ptr %v625, i64 0
  store i64 %v626, ptr %st192
  %st193 = getelementptr i64, ptr %v625, i64 1
  store i64 %v623, ptr %st193
  %st194 = getelementptr i64, ptr %v625, i64 2
  store i64 %v624, ptr %st194
  %v627.p = getelementptr i64, ptr %v625, i64 0
  %v627 = load i64, ptr %v627.p
  %v628.p = getelementptr i64, ptr %v625, i64 1
  %v628 = load i64, ptr %v628.p
  %v629.p = getelementptr i64, ptr %v625, i64 2
  %v629 = load i64, ptr %v629.p
  %v630 = getelementptr i64, ptr @"str.24", i64 0
  %v631 = add i64 0, 3
  %v632 = add i64 0, 0
  %v633 = getelementptr i64, ptr %s0, i64 0
  %v634 = ptrtoint ptr %v630 to i64
  %st195 = getelementptr i64, ptr %v633, i64 0
  store i64 %v634, ptr %st195
  %st196 = getelementptr i64, ptr %v633, i64 1
  store i64 %v631, ptr %st196
  %st197 = getelementptr i64, ptr %v633, i64 2
  store i64 %v632, ptr %st197
  %v635.p = getelementptr i64, ptr %v633, i64 0
  %v635 = load i64, ptr %v635.p
  %v636.p = getelementptr i64, ptr %v633, i64 1
  %v636 = load i64, ptr %v636.p
  %v637.p = getelementptr i64, ptr %v633, i64 2
  %v637 = load i64, ptr %v637.p
  %v638 = call i64 @"std/strings.Contains"(i64 %v627, i64 %v628, i64 %v629, i64 %v635, i64 %v636, i64 %v637)
  %c.b45 = icmp ne i64 %v638, 0
  br i1 %c.b45, label %b45.t199, label %b45.e200
b45.t199:
  br label %b46
b45.e200:
  br label %b47
b46:
  %v639 = add i64 0, 116
  call void @"rt.print_char"(i64 %v639)
  %v640 = add i64 0, 114
  call void @"rt.print_char"(i64 %v640)
  %v641 = add i64 0, 117
  call void @"rt.print_char"(i64 %v641)
  %v642 = add i64 0, 101
  call void @"rt.print_char"(i64 %v642)
  br label %b48
b47:
  %v643 = add i64 0, 102
  call void @"rt.print_char"(i64 %v643)
  %v644 = add i64 0, 97
  call void @"rt.print_char"(i64 %v644)
  %v645 = add i64 0, 108
  call void @"rt.print_char"(i64 %v645)
  %v646 = add i64 0, 115
  call void @"rt.print_char"(i64 %v646)
  %v647 = add i64 0, 101
  call void @"rt.print_char"(i64 %v647)
  br label %b48
b48:
  %v648 = add i64 0, 10
  call void @"rt.print_char"(i64 %v648)
  %v649 = getelementptr i64, ptr @"str.23", i64 0
  %v650 = add i64 0, 7
  %v651 = add i64 0, 0
  %v652 = getelementptr i64, ptr %s0, i64 0
  %v653 = ptrtoint ptr %v649 to i64
  %st200 = getelementptr i64, ptr %v652, i64 0
  store i64 %v653, ptr %st200
  %st201 = getelementptr i64, ptr %v652, i64 1
  store i64 %v650, ptr %st201
  %st202 = getelementptr i64, ptr %v652, i64 2
  store i64 %v651, ptr %st202
  %v654.p = getelementptr i64, ptr %v652, i64 0
  %v654 = load i64, ptr %v654.p
  %v655.p = getelementptr i64, ptr %v652, i64 1
  %v655 = load i64, ptr %v655.p
  %v656.p = getelementptr i64, ptr %v652, i64 2
  %v656 = load i64, ptr %v656.p
  %v657 = getelementptr i64, ptr @"str.25", i64 0
  %v658 = add i64 0, 3
  %v659 = add i64 0, 0
  %v660 = getelementptr i64, ptr %s1, i64 0
  %v661 = ptrtoint ptr %v657 to i64
  %st203 = getelementptr i64, ptr %v660, i64 0
  store i64 %v661, ptr %st203
  %st204 = getelementptr i64, ptr %v660, i64 1
  store i64 %v658, ptr %st204
  %st205 = getelementptr i64, ptr %v660, i64 2
  store i64 %v659, ptr %st205
  %v662.p = getelementptr i64, ptr %v660, i64 0
  %v662 = load i64, ptr %v662.p
  %v663.p = getelementptr i64, ptr %v660, i64 1
  %v663 = load i64, ptr %v663.p
  %v664.p = getelementptr i64, ptr %v660, i64 2
  %v664 = load i64, ptr %v664.p
  %v665 = call i64 @"std/strings.Contains"(i64 %v654, i64 %v655, i64 %v656, i64 %v662, i64 %v663, i64 %v664)
  %c.b48 = icmp ne i64 %v665, 0
  br i1 %c.b48, label %b48.t207, label %b48.e208
b48.t207:
  br label %b49
b48.e208:
  br label %b50
b49:
  %v666 = add i64 0, 116
  call void @"rt.print_char"(i64 %v666)
  %v667 = add i64 0, 114
  call void @"rt.print_char"(i64 %v667)
  %v668 = add i64 0, 117
  call void @"rt.print_char"(i64 %v668)
  %v669 = add i64 0, 101
  call void @"rt.print_char"(i64 %v669)
  br label %b51
b50:
  %v670 = add i64 0, 102
  call void @"rt.print_char"(i64 %v670)
  %v671 = add i64 0, 97
  call void @"rt.print_char"(i64 %v671)
  %v672 = add i64 0, 108
  call void @"rt.print_char"(i64 %v672)
  %v673 = add i64 0, 115
  call void @"rt.print_char"(i64 %v673)
  %v674 = add i64 0, 101
  call void @"rt.print_char"(i64 %v674)
  br label %b51
b51:
  %v675 = add i64 0, 10
  call void @"rt.print_char"(i64 %v675)
  %v676 = getelementptr i64, ptr @"str.23", i64 0
  %v677 = add i64 0, 7
  %v678 = add i64 0, 0
  %v679 = getelementptr i64, ptr %s1, i64 0
  %v680 = ptrtoint ptr %v676 to i64
  %st208 = getelementptr i64, ptr %v679, i64 0
  store i64 %v680, ptr %st208
  %st209 = getelementptr i64, ptr %v679, i64 1
  store i64 %v677, ptr %st209
  %st210 = getelementptr i64, ptr %v679, i64 2
  store i64 %v678, ptr %st210
  %v681.p = getelementptr i64, ptr %v679, i64 0
  %v681 = load i64, ptr %v681.p
  %v682.p = getelementptr i64, ptr %v679, i64 1
  %v682 = load i64, ptr %v682.p
  %v683.p = getelementptr i64, ptr %v679, i64 2
  %v683 = load i64, ptr %v683.p
  %v684 = getelementptr i64, ptr @"str.4", i64 0
  %v685 = add i64 0, 0
  %v686 = add i64 0, 0
  %v687 = getelementptr i64, ptr %s0, i64 0
  %v688 = ptrtoint ptr %v684 to i64
  %st211 = getelementptr i64, ptr %v687, i64 0
  store i64 %v688, ptr %st211
  %st212 = getelementptr i64, ptr %v687, i64 1
  store i64 %v685, ptr %st212
  %st213 = getelementptr i64, ptr %v687, i64 2
  store i64 %v686, ptr %st213
  %v689.p = getelementptr i64, ptr %v687, i64 0
  %v689 = load i64, ptr %v689.p
  %v690.p = getelementptr i64, ptr %v687, i64 1
  %v690 = load i64, ptr %v690.p
  %v691.p = getelementptr i64, ptr %v687, i64 2
  %v691 = load i64, ptr %v691.p
  %v692 = call i64 @"std/strings.Contains"(i64 %v681, i64 %v682, i64 %v683, i64 %v689, i64 %v690, i64 %v691)
  %c.b51 = icmp ne i64 %v692, 0
  br i1 %c.b51, label %b51.t215, label %b51.e216
b51.t215:
  br label %b52
b51.e216:
  br label %b53
b52:
  %v693 = add i64 0, 116
  call void @"rt.print_char"(i64 %v693)
  %v694 = add i64 0, 114
  call void @"rt.print_char"(i64 %v694)
  %v695 = add i64 0, 117
  call void @"rt.print_char"(i64 %v695)
  %v696 = add i64 0, 101
  call void @"rt.print_char"(i64 %v696)
  br label %b54
b53:
  %v697 = add i64 0, 102
  call void @"rt.print_char"(i64 %v697)
  %v698 = add i64 0, 97
  call void @"rt.print_char"(i64 %v698)
  %v699 = add i64 0, 108
  call void @"rt.print_char"(i64 %v699)
  %v700 = add i64 0, 115
  call void @"rt.print_char"(i64 %v700)
  %v701 = add i64 0, 101
  call void @"rt.print_char"(i64 %v701)
  br label %b54
b54:
  %v702 = add i64 0, 10
  call void @"rt.print_char"(i64 %v702)
  %v703 = getelementptr i64, ptr @"str.4", i64 0
  %v704 = add i64 0, 0
  %v705 = add i64 0, 0
  %v706 = getelementptr i64, ptr %s0, i64 0
  %v707 = ptrtoint ptr %v703 to i64
  %st216 = getelementptr i64, ptr %v706, i64 0
  store i64 %v707, ptr %st216
  %st217 = getelementptr i64, ptr %v706, i64 1
  store i64 %v704, ptr %st217
  %st218 = getelementptr i64, ptr %v706, i64 2
  store i64 %v705, ptr %st218
  %v708.p = getelementptr i64, ptr %v706, i64 0
  %v708 = load i64, ptr %v708.p
  %v709.p = getelementptr i64, ptr %v706, i64 1
  %v709 = load i64, ptr %v709.p
  %v710.p = getelementptr i64, ptr %v706, i64 2
  %v710 = load i64, ptr %v710.p
  %v711 = getelementptr i64, ptr @"str.4", i64 0
  %v712 = add i64 0, 0
  %v713 = add i64 0, 0
  %v714 = getelementptr i64, ptr %s1, i64 0
  %v715 = ptrtoint ptr %v711 to i64
  %st219 = getelementptr i64, ptr %v714, i64 0
  store i64 %v715, ptr %st219
  %st220 = getelementptr i64, ptr %v714, i64 1
  store i64 %v712, ptr %st220
  %st221 = getelementptr i64, ptr %v714, i64 2
  store i64 %v713, ptr %st221
  %v716.p = getelementptr i64, ptr %v714, i64 0
  %v716 = load i64, ptr %v716.p
  %v717.p = getelementptr i64, ptr %v714, i64 1
  %v717 = load i64, ptr %v717.p
  %v718.p = getelementptr i64, ptr %v714, i64 2
  %v718 = load i64, ptr %v718.p
  %v719 = call i64 @"std/strings.Contains"(i64 %v708, i64 %v709, i64 %v710, i64 %v716, i64 %v717, i64 %v718)
  %c.b54 = icmp ne i64 %v719, 0
  br i1 %c.b54, label %b54.t223, label %b54.e224
b54.t223:
  br label %b55
b54.e224:
  br label %b56
b55:
  %v720 = add i64 0, 116
  call void @"rt.print_char"(i64 %v720)
  %v721 = add i64 0, 114
  call void @"rt.print_char"(i64 %v721)
  %v722 = add i64 0, 117
  call void @"rt.print_char"(i64 %v722)
  %v723 = add i64 0, 101
  call void @"rt.print_char"(i64 %v723)
  br label %b57
b56:
  %v724 = add i64 0, 102
  call void @"rt.print_char"(i64 %v724)
  %v725 = add i64 0, 97
  call void @"rt.print_char"(i64 %v725)
  %v726 = add i64 0, 108
  call void @"rt.print_char"(i64 %v726)
  %v727 = add i64 0, 115
  call void @"rt.print_char"(i64 %v727)
  %v728 = add i64 0, 101
  call void @"rt.print_char"(i64 %v728)
  br label %b57
b57:
  %v729 = add i64 0, 10
  call void @"rt.print_char"(i64 %v729)
  %v730 = getelementptr i64, ptr @"str.4", i64 0
  %v731 = add i64 0, 0
  %v732 = add i64 0, 0
  %v733 = getelementptr i64, ptr %s1, i64 0
  %v734 = ptrtoint ptr %v730 to i64
  %st224 = getelementptr i64, ptr %v733, i64 0
  store i64 %v734, ptr %st224
  %st225 = getelementptr i64, ptr %v733, i64 1
  store i64 %v731, ptr %st225
  %st226 = getelementptr i64, ptr %v733, i64 2
  store i64 %v732, ptr %st226
  %v735.p = getelementptr i64, ptr %v733, i64 0
  %v735 = load i64, ptr %v735.p
  %v736.p = getelementptr i64, ptr %v733, i64 1
  %v736 = load i64, ptr %v736.p
  %v737.p = getelementptr i64, ptr %v733, i64 2
  %v737 = load i64, ptr %v737.p
  %v738 = getelementptr i64, ptr @"str.5", i64 0
  %v739 = add i64 0, 1
  %v740 = add i64 0, 0
  %v741 = getelementptr i64, ptr %s0, i64 0
  %v742 = ptrtoint ptr %v738 to i64
  %st227 = getelementptr i64, ptr %v741, i64 0
  store i64 %v742, ptr %st227
  %st228 = getelementptr i64, ptr %v741, i64 1
  store i64 %v739, ptr %st228
  %st229 = getelementptr i64, ptr %v741, i64 2
  store i64 %v740, ptr %st229
  %v743.p = getelementptr i64, ptr %v741, i64 0
  %v743 = load i64, ptr %v743.p
  %v744.p = getelementptr i64, ptr %v741, i64 1
  %v744 = load i64, ptr %v744.p
  %v745.p = getelementptr i64, ptr %v741, i64 2
  %v745 = load i64, ptr %v745.p
  %v746 = call i64 @"std/strings.Contains"(i64 %v735, i64 %v736, i64 %v737, i64 %v743, i64 %v744, i64 %v745)
  %c.b57 = icmp ne i64 %v746, 0
  br i1 %c.b57, label %b57.t231, label %b57.e232
b57.t231:
  br label %b58
b57.e232:
  br label %b59
b58:
  %v747 = add i64 0, 116
  call void @"rt.print_char"(i64 %v747)
  %v748 = add i64 0, 114
  call void @"rt.print_char"(i64 %v748)
  %v749 = add i64 0, 117
  call void @"rt.print_char"(i64 %v749)
  %v750 = add i64 0, 101
  call void @"rt.print_char"(i64 %v750)
  br label %b60
b59:
  %v751 = add i64 0, 102
  call void @"rt.print_char"(i64 %v751)
  %v752 = add i64 0, 97
  call void @"rt.print_char"(i64 %v752)
  %v753 = add i64 0, 108
  call void @"rt.print_char"(i64 %v753)
  %v754 = add i64 0, 115
  call void @"rt.print_char"(i64 %v754)
  %v755 = add i64 0, 101
  call void @"rt.print_char"(i64 %v755)
  br label %b60
b60:
  %v756 = add i64 0, 10
  call void @"rt.print_char"(i64 %v756)
  %v757 = getelementptr i64, ptr @"str.14", i64 0
  %v758 = add i64 0, 2
  %v759 = add i64 0, 0
  %v760 = getelementptr i64, ptr %s0, i64 0
  %v761 = ptrtoint ptr %v757 to i64
  %st232 = getelementptr i64, ptr %v760, i64 0
  store i64 %v761, ptr %st232
  %st233 = getelementptr i64, ptr %v760, i64 1
  store i64 %v758, ptr %st233
  %st234 = getelementptr i64, ptr %v760, i64 2
  store i64 %v759, ptr %st234
  %v762.p = getelementptr i64, ptr %v760, i64 0
  %v762 = load i64, ptr %v762.p
  %v763.p = getelementptr i64, ptr %v760, i64 1
  %v763 = load i64, ptr %v763.p
  %v764.p = getelementptr i64, ptr %v760, i64 2
  %v764 = load i64, ptr %v764.p
  %v765 = getelementptr i64, ptr @"str.26", i64 0
  %v766 = add i64 0, 2
  %v767 = add i64 0, 0
  %v768 = getelementptr i64, ptr %s1, i64 0
  %v769 = ptrtoint ptr %v765 to i64
  %st235 = getelementptr i64, ptr %v768, i64 0
  store i64 %v769, ptr %st235
  %st236 = getelementptr i64, ptr %v768, i64 1
  store i64 %v766, ptr %st236
  %st237 = getelementptr i64, ptr %v768, i64 2
  store i64 %v767, ptr %st237
  %v770.p = getelementptr i64, ptr %v768, i64 0
  %v770 = load i64, ptr %v770.p
  %v771.p = getelementptr i64, ptr %v768, i64 1
  %v771 = load i64, ptr %v771.p
  %v772.p = getelementptr i64, ptr %v768, i64 2
  %v772 = load i64, ptr %v772.p
  %v773 = call i64 @"std/strings.Contains"(i64 %v762, i64 %v763, i64 %v764, i64 %v770, i64 %v771, i64 %v772)
  %c.b60 = icmp ne i64 %v773, 0
  br i1 %c.b60, label %b60.t239, label %b60.e240
b60.t239:
  br label %b61
b60.e240:
  br label %b62
b61:
  %v774 = add i64 0, 116
  call void @"rt.print_char"(i64 %v774)
  %v775 = add i64 0, 114
  call void @"rt.print_char"(i64 %v775)
  %v776 = add i64 0, 117
  call void @"rt.print_char"(i64 %v776)
  %v777 = add i64 0, 101
  call void @"rt.print_char"(i64 %v777)
  br label %b63
b62:
  %v778 = add i64 0, 102
  call void @"rt.print_char"(i64 %v778)
  %v779 = add i64 0, 97
  call void @"rt.print_char"(i64 %v779)
  %v780 = add i64 0, 108
  call void @"rt.print_char"(i64 %v780)
  %v781 = add i64 0, 115
  call void @"rt.print_char"(i64 %v781)
  %v782 = add i64 0, 101
  call void @"rt.print_char"(i64 %v782)
  br label %b63
b63:
  %v783 = add i64 0, 10
  call void @"rt.print_char"(i64 %v783)
  %v784 = getelementptr i64, ptr @"str.27", i64 0
  %v785 = add i64 0, 6
  %v786 = add i64 0, 0
  %v787 = getelementptr i64, ptr %s1, i64 0
  %v788 = ptrtoint ptr %v784 to i64
  %st240 = getelementptr i64, ptr %v787, i64 0
  store i64 %v788, ptr %st240
  %st241 = getelementptr i64, ptr %v787, i64 1
  store i64 %v785, ptr %st241
  %st242 = getelementptr i64, ptr %v787, i64 2
  store i64 %v786, ptr %st242
  %v789.p = getelementptr i64, ptr %v787, i64 0
  %v789 = load i64, ptr %v789.p
  %v790.p = getelementptr i64, ptr %v787, i64 1
  %v790 = load i64, ptr %v790.p
  %v791.p = getelementptr i64, ptr %v787, i64 2
  %v791 = load i64, ptr %v791.p
  %v792 = getelementptr i64, ptr @"str.28", i64 0
  %v793 = add i64 0, 1
  %v794 = add i64 0, 0
  %v795 = getelementptr i64, ptr %s0, i64 0
  %v796 = ptrtoint ptr %v792 to i64
  %st243 = getelementptr i64, ptr %v795, i64 0
  store i64 %v796, ptr %st243
  %st244 = getelementptr i64, ptr %v795, i64 1
  store i64 %v793, ptr %st244
  %st245 = getelementptr i64, ptr %v795, i64 2
  store i64 %v794, ptr %st245
  %v797.p = getelementptr i64, ptr %v795, i64 0
  %v797 = load i64, ptr %v797.p
  %v798.p = getelementptr i64, ptr %v795, i64 1
  %v798 = load i64, ptr %v798.p
  %v799.p = getelementptr i64, ptr %v795, i64 2
  %v799 = load i64, ptr %v799.p
  %v800 = call i64 @"std/strings.Count"(i64 %v789, i64 %v790, i64 %v791, i64 %v797, i64 %v798, i64 %v799)
  call void @"rt.print_int"(i64 %v800)
  %v801 = add i64 0, 10
  call void @"rt.print_char"(i64 %v801)
  %v802 = getelementptr i64, ptr @"str.29", i64 0
  %v803 = add i64 0, 4
  %v804 = add i64 0, 0
  %v805 = getelementptr i64, ptr %s0, i64 0
  %v806 = ptrtoint ptr %v802 to i64
  %st246 = getelementptr i64, ptr %v805, i64 0
  store i64 %v806, ptr %st246
  %st247 = getelementptr i64, ptr %v805, i64 1
  store i64 %v803, ptr %st247
  %st248 = getelementptr i64, ptr %v805, i64 2
  store i64 %v804, ptr %st248
  %v807.p = getelementptr i64, ptr %v805, i64 0
  %v807 = load i64, ptr %v807.p
  %v808.p = getelementptr i64, ptr %v805, i64 1
  %v808 = load i64, ptr %v808.p
  %v809.p = getelementptr i64, ptr %v805, i64 2
  %v809 = load i64, ptr %v809.p
  %v810 = getelementptr i64, ptr @"str.4", i64 0
  %v811 = add i64 0, 0
  %v812 = add i64 0, 0
  %v813 = getelementptr i64, ptr %s1, i64 0
  %v814 = ptrtoint ptr %v810 to i64
  %st249 = getelementptr i64, ptr %v813, i64 0
  store i64 %v814, ptr %st249
  %st250 = getelementptr i64, ptr %v813, i64 1
  store i64 %v811, ptr %st250
  %st251 = getelementptr i64, ptr %v813, i64 2
  store i64 %v812, ptr %st251
  %v815.p = getelementptr i64, ptr %v813, i64 0
  %v815 = load i64, ptr %v815.p
  %v816.p = getelementptr i64, ptr %v813, i64 1
  %v816 = load i64, ptr %v816.p
  %v817.p = getelementptr i64, ptr %v813, i64 2
  %v817 = load i64, ptr %v817.p
  %v818 = call i64 @"std/strings.Count"(i64 %v807, i64 %v808, i64 %v809, i64 %v815, i64 %v816, i64 %v817)
  call void @"rt.print_int"(i64 %v818)
  %v819 = add i64 0, 10
  call void @"rt.print_char"(i64 %v819)
  %v820 = getelementptr i64, ptr @"str.4", i64 0
  %v821 = add i64 0, 0
  %v822 = add i64 0, 0
  %v823 = getelementptr i64, ptr %s1, i64 0
  %v824 = ptrtoint ptr %v820 to i64
  %st252 = getelementptr i64, ptr %v823, i64 0
  store i64 %v824, ptr %st252
  %st253 = getelementptr i64, ptr %v823, i64 1
  store i64 %v821, ptr %st253
  %st254 = getelementptr i64, ptr %v823, i64 2
  store i64 %v822, ptr %st254
  %v825.p = getelementptr i64, ptr %v823, i64 0
  %v825 = load i64, ptr %v825.p
  %v826.p = getelementptr i64, ptr %v823, i64 1
  %v826 = load i64, ptr %v826.p
  %v827.p = getelementptr i64, ptr %v823, i64 2
  %v827 = load i64, ptr %v827.p
  %v828 = getelementptr i64, ptr @"str.4", i64 0
  %v829 = add i64 0, 0
  %v830 = add i64 0, 0
  %v831 = getelementptr i64, ptr %s0, i64 0
  %v832 = ptrtoint ptr %v828 to i64
  %st255 = getelementptr i64, ptr %v831, i64 0
  store i64 %v832, ptr %st255
  %st256 = getelementptr i64, ptr %v831, i64 1
  store i64 %v829, ptr %st256
  %st257 = getelementptr i64, ptr %v831, i64 2
  store i64 %v830, ptr %st257
  %v833.p = getelementptr i64, ptr %v831, i64 0
  %v833 = load i64, ptr %v833.p
  %v834.p = getelementptr i64, ptr %v831, i64 1
  %v834 = load i64, ptr %v834.p
  %v835.p = getelementptr i64, ptr %v831, i64 2
  %v835 = load i64, ptr %v835.p
  %v836 = call i64 @"std/strings.Count"(i64 %v825, i64 %v826, i64 %v827, i64 %v833, i64 %v834, i64 %v835)
  call void @"rt.print_int"(i64 %v836)
  %v837 = add i64 0, 10
  call void @"rt.print_char"(i64 %v837)
  %v838 = getelementptr i64, ptr @"str.30", i64 0
  %v839 = add i64 0, 4
  %v840 = add i64 0, 0
  %v841 = getelementptr i64, ptr %s0, i64 0
  %v842 = ptrtoint ptr %v838 to i64
  %st258 = getelementptr i64, ptr %v841, i64 0
  store i64 %v842, ptr %st258
  %st259 = getelementptr i64, ptr %v841, i64 1
  store i64 %v839, ptr %st259
  %st260 = getelementptr i64, ptr %v841, i64 2
  store i64 %v840, ptr %st260
  %v843.p = getelementptr i64, ptr %v841, i64 0
  %v843 = load i64, ptr %v843.p
  %v844.p = getelementptr i64, ptr %v841, i64 1
  %v844 = load i64, ptr %v844.p
  %v845.p = getelementptr i64, ptr %v841, i64 2
  %v845 = load i64, ptr %v845.p
  %v846 = getelementptr i64, ptr @"str.31", i64 0
  %v847 = add i64 0, 2
  %v848 = add i64 0, 0
  %v849 = getelementptr i64, ptr %s1, i64 0
  %v850 = ptrtoint ptr %v846 to i64
  %st261 = getelementptr i64, ptr %v849, i64 0
  store i64 %v850, ptr %st261
  %st262 = getelementptr i64, ptr %v849, i64 1
  store i64 %v847, ptr %st262
  %st263 = getelementptr i64, ptr %v849, i64 2
  store i64 %v848, ptr %st263
  %v851.p = getelementptr i64, ptr %v849, i64 0
  %v851 = load i64, ptr %v851.p
  %v852.p = getelementptr i64, ptr %v849, i64 1
  %v852 = load i64, ptr %v852.p
  %v853.p = getelementptr i64, ptr %v849, i64 2
  %v853 = load i64, ptr %v853.p
  %v854 = call i64 @"std/strings.Count"(i64 %v843, i64 %v844, i64 %v845, i64 %v851, i64 %v852, i64 %v853)
  call void @"rt.print_int"(i64 %v854)
  %v855 = add i64 0, 10
  call void @"rt.print_char"(i64 %v855)
  %v856 = getelementptr i64, ptr @"str.32", i64 0
  %v857 = add i64 0, 5
  %v858 = add i64 0, 0
  %v859 = getelementptr i64, ptr %s1, i64 0
  %v860 = ptrtoint ptr %v856 to i64
  %st264 = getelementptr i64, ptr %v859, i64 0
  store i64 %v860, ptr %st264
  %st265 = getelementptr i64, ptr %v859, i64 1
  store i64 %v857, ptr %st265
  %st266 = getelementptr i64, ptr %v859, i64 2
  store i64 %v858, ptr %st266
  %v861.p = getelementptr i64, ptr %v859, i64 0
  %v861 = load i64, ptr %v861.p
  %v862.p = getelementptr i64, ptr %v859, i64 1
  %v862 = load i64, ptr %v862.p
  %v863.p = getelementptr i64, ptr %v859, i64 2
  %v863 = load i64, ptr %v863.p
  %v864 = getelementptr i64, ptr @"str.31", i64 0
  %v865 = add i64 0, 2
  %v866 = add i64 0, 0
  %v867 = getelementptr i64, ptr %s0, i64 0
  %v868 = ptrtoint ptr %v864 to i64
  %st267 = getelementptr i64, ptr %v867, i64 0
  store i64 %v868, ptr %st267
  %st268 = getelementptr i64, ptr %v867, i64 1
  store i64 %v865, ptr %st268
  %st269 = getelementptr i64, ptr %v867, i64 2
  store i64 %v866, ptr %st269
  %v869.p = getelementptr i64, ptr %v867, i64 0
  %v869 = load i64, ptr %v869.p
  %v870.p = getelementptr i64, ptr %v867, i64 1
  %v870 = load i64, ptr %v870.p
  %v871.p = getelementptr i64, ptr %v867, i64 2
  %v871 = load i64, ptr %v871.p
  %v872 = call i64 @"std/strings.Count"(i64 %v861, i64 %v862, i64 %v863, i64 %v869, i64 %v870, i64 %v871)
  call void @"rt.print_int"(i64 %v872)
  %v873 = add i64 0, 10
  call void @"rt.print_char"(i64 %v873)
  %v874 = getelementptr i64, ptr @"str.6", i64 0
  %v875 = add i64 0, 3
  %v876 = add i64 0, 0
  %v877 = getelementptr i64, ptr %s0, i64 0
  %v878 = ptrtoint ptr %v874 to i64
  %st270 = getelementptr i64, ptr %v877, i64 0
  store i64 %v878, ptr %st270
  %st271 = getelementptr i64, ptr %v877, i64 1
  store i64 %v875, ptr %st271
  %st272 = getelementptr i64, ptr %v877, i64 2
  store i64 %v876, ptr %st272
  %v879.p = getelementptr i64, ptr %v877, i64 0
  %v879 = load i64, ptr %v879.p
  %v880.p = getelementptr i64, ptr %v877, i64 1
  %v880 = load i64, ptr %v880.p
  %v881.p = getelementptr i64, ptr %v877, i64 2
  %v881 = load i64, ptr %v881.p
  %v882 = getelementptr i64, ptr @"str.7", i64 0
  %v883 = add i64 0, 4
  %v884 = add i64 0, 0
  %v885 = getelementptr i64, ptr %s1, i64 0
  %v886 = ptrtoint ptr %v882 to i64
  %st273 = getelementptr i64, ptr %v885, i64 0
  store i64 %v886, ptr %st273
  %st274 = getelementptr i64, ptr %v885, i64 1
  store i64 %v883, ptr %st274
  %st275 = getelementptr i64, ptr %v885, i64 2
  store i64 %v884, ptr %st275
  %v887.p = getelementptr i64, ptr %v885, i64 0
  %v887 = load i64, ptr %v887.p
  %v888.p = getelementptr i64, ptr %v885, i64 1
  %v888 = load i64, ptr %v888.p
  %v889.p = getelementptr i64, ptr %v885, i64 2
  %v889 = load i64, ptr %v889.p
  %v890 = call i64 @"std/strings.Count"(i64 %v879, i64 %v880, i64 %v881, i64 %v887, i64 %v888, i64 %v889)
  call void @"rt.print_int"(i64 %v890)
  %v891 = add i64 0, 10
  call void @"rt.print_char"(i64 %v891)
  %v892 = getelementptr i64, ptr @"str.33", i64 0
  %v893 = add i64 0, 8
  %v894 = add i64 0, 0
  %v895 = getelementptr i64, ptr %s1, i64 0
  %v896 = ptrtoint ptr %v892 to i64
  %st276 = getelementptr i64, ptr %v895, i64 0
  store i64 %v896, ptr %st276
  %st277 = getelementptr i64, ptr %v895, i64 1
  store i64 %v893, ptr %st277
  %st278 = getelementptr i64, ptr %v895, i64 2
  store i64 %v894, ptr %st278
  %v897.p = getelementptr i64, ptr %v895, i64 0
  %v897 = load i64, ptr %v897.p
  %v898.p = getelementptr i64, ptr %v895, i64 1
  %v898 = load i64, ptr %v898.p
  %v899.p = getelementptr i64, ptr %v895, i64 2
  %v899 = load i64, ptr %v899.p
  %v900 = getelementptr i64, ptr @"str.6", i64 0
  %v901 = add i64 0, 3
  %v902 = add i64 0, 0
  %v903 = getelementptr i64, ptr %s0, i64 0
  %v904 = ptrtoint ptr %v900 to i64
  %st279 = getelementptr i64, ptr %v903, i64 0
  store i64 %v904, ptr %st279
  %st280 = getelementptr i64, ptr %v903, i64 1
  store i64 %v901, ptr %st280
  %st281 = getelementptr i64, ptr %v903, i64 2
  store i64 %v902, ptr %st281
  %v905.p = getelementptr i64, ptr %v903, i64 0
  %v905 = load i64, ptr %v905.p
  %v906.p = getelementptr i64, ptr %v903, i64 1
  %v906 = load i64, ptr %v906.p
  %v907.p = getelementptr i64, ptr %v903, i64 2
  %v907 = load i64, ptr %v907.p
  %v908 = call i64 @"std/strings.Count"(i64 %v897, i64 %v898, i64 %v899, i64 %v905, i64 %v906, i64 %v907)
  call void @"rt.print_int"(i64 %v908)
  %v909 = add i64 0, 10
  call void @"rt.print_char"(i64 %v909)
  %v910 = getelementptr i64, ptr @"str.20", i64 0
  %v911 = add i64 0, 9
  %v912 = add i64 0, 0
  %v913 = getelementptr i64, ptr %s0, i64 0
  %v914 = ptrtoint ptr %v910 to i64
  %st282 = getelementptr i64, ptr %v913, i64 0
  store i64 %v914, ptr %st282
  %st283 = getelementptr i64, ptr %v913, i64 1
  store i64 %v911, ptr %st283
  %st284 = getelementptr i64, ptr %v913, i64 2
  store i64 %v912, ptr %st284
  %v915.p = getelementptr i64, ptr %v913, i64 0
  %v915 = load i64, ptr %v915.p
  %v916.p = getelementptr i64, ptr %v913, i64 1
  %v916 = load i64, ptr %v916.p
  %v917.p = getelementptr i64, ptr %v913, i64 2
  %v917 = load i64, ptr %v917.p
  %v918 = getelementptr i64, ptr @"str.4", i64 0
  %v919 = add i64 0, 0
  %v920 = add i64 0, 0
  %v921 = getelementptr i64, ptr %s1, i64 0
  %v922 = ptrtoint ptr %v918 to i64
  %st285 = getelementptr i64, ptr %v921, i64 0
  store i64 %v922, ptr %st285
  %st286 = getelementptr i64, ptr %v921, i64 1
  store i64 %v919, ptr %st286
  %st287 = getelementptr i64, ptr %v921, i64 2
  store i64 %v920, ptr %st287
  %v923.p = getelementptr i64, ptr %v921, i64 0
  %v923 = load i64, ptr %v923.p
  %v924.p = getelementptr i64, ptr %v921, i64 1
  %v924 = load i64, ptr %v924.p
  %v925.p = getelementptr i64, ptr %v921, i64 2
  %v925 = load i64, ptr %v925.p
  %v926 = call i64 @"std/strings.Count"(i64 %v915, i64 %v916, i64 %v917, i64 %v923, i64 %v924, i64 %v925)
  call void @"rt.print_int"(i64 %v926)
  %v927 = add i64 0, 10
  call void @"rt.print_char"(i64 %v927)
  %v928 = getelementptr i64, ptr @"str.34", i64 0
  %v929 = add i64 0, 6
  %v930 = add i64 0, 0
  %v931 = getelementptr i64, ptr %s1, i64 0
  %v932 = ptrtoint ptr %v928 to i64
  %st288 = getelementptr i64, ptr %v931, i64 0
  store i64 %v932, ptr %st288
  %st289 = getelementptr i64, ptr %v931, i64 1
  store i64 %v929, ptr %st289
  %st290 = getelementptr i64, ptr %v931, i64 2
  store i64 %v930, ptr %st290
  %v933.p = getelementptr i64, ptr %v931, i64 0
  %v933 = load i64, ptr %v933.p
  %v934.p = getelementptr i64, ptr %v931, i64 1
  %v934 = load i64, ptr %v934.p
  %v935.p = getelementptr i64, ptr %v931, i64 2
  %v935 = load i64, ptr %v935.p
  %v936 = getelementptr i64, ptr @"str.35", i64 0
  %v937 = add i64 0, 3
  %v938 = add i64 0, 0
  %v939 = getelementptr i64, ptr %s0, i64 0
  %v940 = ptrtoint ptr %v936 to i64
  %st291 = getelementptr i64, ptr %v939, i64 0
  store i64 %v940, ptr %st291
  %st292 = getelementptr i64, ptr %v939, i64 1
  store i64 %v937, ptr %st292
  %st293 = getelementptr i64, ptr %v939, i64 2
  store i64 %v938, ptr %st293
  %v941.p = getelementptr i64, ptr %v939, i64 0
  %v941 = load i64, ptr %v941.p
  %v942.p = getelementptr i64, ptr %v939, i64 1
  %v942 = load i64, ptr %v942.p
  %v943.p = getelementptr i64, ptr %v939, i64 2
  %v943 = load i64, ptr %v943.p
  %v944 = call i64 @"std/strings.Count"(i64 %v933, i64 %v934, i64 %v935, i64 %v941, i64 %v942, i64 %v943)
  call void @"rt.print_int"(i64 %v944)
  %v945 = add i64 0, 10
  call void @"rt.print_char"(i64 %v945)
  %v946 = getelementptr i64, ptr @"str.36", i64 0
  %v947 = add i64 0, 6
  %v948 = add i64 0, 0
  %v949 = getelementptr i64, ptr %s0, i64 0
  %v950 = ptrtoint ptr %v946 to i64
  %st294 = getelementptr i64, ptr %v949, i64 0
  store i64 %v950, ptr %st294
  %st295 = getelementptr i64, ptr %v949, i64 1
  store i64 %v947, ptr %st295
  %st296 = getelementptr i64, ptr %v949, i64 2
  store i64 %v948, ptr %st296
  %v951.p = getelementptr i64, ptr %v949, i64 0
  %v951 = load i64, ptr %v951.p
  %v952.p = getelementptr i64, ptr %v949, i64 1
  %v952 = load i64, ptr %v952.p
  %v953.p = getelementptr i64, ptr %v949, i64 2
  %v953 = load i64, ptr %v953.p
  %v954 = add i64 0, 108
  %v955 = call i64 @"std/strings.IndexByte"(i64 %v951, i64 %v952, i64 %v953, i64 %v954)
  call void @"rt.print_int"(i64 %v955)
  %v956 = add i64 0, 10
  call void @"rt.print_char"(i64 %v956)
  %v957 = getelementptr i64, ptr @"str.37", i64 0
  %v958 = add i64 0, 7
  %v959 = add i64 0, 0
  %v960 = getelementptr i64, ptr %s0, i64 0
  %v961 = ptrtoint ptr %v957 to i64
  %st297 = getelementptr i64, ptr %v960, i64 0
  store i64 %v961, ptr %st297
  %st298 = getelementptr i64, ptr %v960, i64 1
  store i64 %v958, ptr %st298
  %st299 = getelementptr i64, ptr %v960, i64 2
  store i64 %v959, ptr %st299
  %v962.p = getelementptr i64, ptr %v960, i64 0
  %v962 = load i64, ptr %v962.p
  %v963.p = getelementptr i64, ptr %v960, i64 1
  %v963 = load i64, ptr %v963.p
  %v964.p = getelementptr i64, ptr %v960, i64 2
  %v964 = load i64, ptr %v964.p
  %v965 = add i64 0, 104
  %v966 = call i64 @"std/strings.IndexByte"(i64 %v962, i64 %v963, i64 %v964, i64 %v965)
  call void @"rt.print_int"(i64 %v966)
  %v967 = add i64 0, 10
  call void @"rt.print_char"(i64 %v967)
  %v968 = getelementptr i64, ptr @"str.36", i64 0
  %v969 = add i64 0, 6
  %v970 = add i64 0, 0
  %v971 = getelementptr i64, ptr %s0, i64 0
  %v972 = ptrtoint ptr %v968 to i64
  %st300 = getelementptr i64, ptr %v971, i64 0
  store i64 %v972, ptr %st300
  %st301 = getelementptr i64, ptr %v971, i64 1
  store i64 %v969, ptr %st301
  %st302 = getelementptr i64, ptr %v971, i64 2
  store i64 %v970, ptr %st302
  %v973.p = getelementptr i64, ptr %v971, i64 0
  %v973 = load i64, ptr %v973.p
  %v974.p = getelementptr i64, ptr %v971, i64 1
  %v974 = load i64, ptr %v974.p
  %v975.p = getelementptr i64, ptr %v971, i64 2
  %v975 = load i64, ptr %v975.p
  %v976 = add i64 0, 120
  %v977 = call i64 @"std/strings.IndexByte"(i64 %v973, i64 %v974, i64 %v975, i64 %v976)
  call void @"rt.print_int"(i64 %v977)
  %v978 = add i64 0, 10
  call void @"rt.print_char"(i64 %v978)
  %v979 = getelementptr i64, ptr @"str.4", i64 0
  %v980 = add i64 0, 0
  %v981 = add i64 0, 0
  %v982 = getelementptr i64, ptr %s0, i64 0
  %v983 = ptrtoint ptr %v979 to i64
  %st303 = getelementptr i64, ptr %v982, i64 0
  store i64 %v983, ptr %st303
  %st304 = getelementptr i64, ptr %v982, i64 1
  store i64 %v980, ptr %st304
  %st305 = getelementptr i64, ptr %v982, i64 2
  store i64 %v981, ptr %st305
  %v984.p = getelementptr i64, ptr %v982, i64 0
  %v984 = load i64, ptr %v984.p
  %v985.p = getelementptr i64, ptr %v982, i64 1
  %v985 = load i64, ptr %v985.p
  %v986.p = getelementptr i64, ptr %v982, i64 2
  %v986 = load i64, ptr %v986.p
  %v987 = add i64 0, 97
  %v988 = call i64 @"std/strings.IndexByte"(i64 %v984, i64 %v985, i64 %v986, i64 %v987)
  call void @"rt.print_int"(i64 %v988)
  %v989 = add i64 0, 10
  call void @"rt.print_char"(i64 %v989)
  %v990 = getelementptr i64, ptr @"str.38", i64 0
  %v991 = add i64 0, 3
  %v992 = add i64 0, 0
  %v993 = getelementptr i64, ptr %s0, i64 0
  %v994 = ptrtoint ptr %v990 to i64
  %st306 = getelementptr i64, ptr %v993, i64 0
  store i64 %v994, ptr %st306
  %st307 = getelementptr i64, ptr %v993, i64 1
  store i64 %v991, ptr %st307
  %st308 = getelementptr i64, ptr %v993, i64 2
  store i64 %v992, ptr %st308
  %v995.p = getelementptr i64, ptr %v993, i64 0
  %v995 = load i64, ptr %v995.p
  %v996.p = getelementptr i64, ptr %v993, i64 1
  %v996 = load i64, ptr %v996.p
  %v997.p = getelementptr i64, ptr %v993, i64 2
  %v997 = load i64, ptr %v997.p
  %v998 = add i64 0, 97
  %v999 = call i64 @"std/strings.IndexByte"(i64 %v995, i64 %v996, i64 %v997, i64 %v998)
  call void @"rt.print_int"(i64 %v999)
  %v1000 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1000)
  %v1001 = getelementptr i64, ptr @"str.6", i64 0
  %v1002 = add i64 0, 3
  %v1003 = add i64 0, 0
  %v1004 = getelementptr i64, ptr %s0, i64 0
  %v1005 = ptrtoint ptr %v1001 to i64
  %st309 = getelementptr i64, ptr %v1004, i64 0
  store i64 %v1005, ptr %st309
  %st310 = getelementptr i64, ptr %v1004, i64 1
  store i64 %v1002, ptr %st310
  %st311 = getelementptr i64, ptr %v1004, i64 2
  store i64 %v1003, ptr %st311
  %v1006.p = getelementptr i64, ptr %v1004, i64 0
  %v1006 = load i64, ptr %v1006.p
  %v1007.p = getelementptr i64, ptr %v1004, i64 1
  %v1007 = load i64, ptr %v1007.p
  %v1008.p = getelementptr i64, ptr %v1004, i64 2
  %v1008 = load i64, ptr %v1008.p
  %v1009 = add i64 0, 99
  %v1010 = call i64 @"std/strings.IndexByte"(i64 %v1006, i64 %v1007, i64 %v1008, i64 %v1009)
  call void @"rt.print_int"(i64 %v1010)
  %v1011 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1011)
  %v1012 = getelementptr i64, ptr %s2, i64 0
  %v1013 = getelementptr i64, ptr @"str.39", i64 0
  %v1014 = add i64 0, 3
  %v1015 = add i64 0, 0
  %v1016 = getelementptr i64, ptr %s0, i64 0
  %v1017 = ptrtoint ptr %v1013 to i64
  %st312 = getelementptr i64, ptr %v1016, i64 0
  store i64 %v1017, ptr %st312
  %st313 = getelementptr i64, ptr %v1016, i64 1
  store i64 %v1014, ptr %st313
  %st314 = getelementptr i64, ptr %v1016, i64 2
  store i64 %v1015, ptr %st314
  %v1018.p = getelementptr i64, ptr %v1016, i64 0
  %v1018 = load i64, ptr %v1018.p
  %v1019.p = getelementptr i64, ptr %v1016, i64 1
  %v1019 = load i64, ptr %v1019.p
  %v1020.p = getelementptr i64, ptr %v1016, i64 2
  %v1020 = load i64, ptr %v1020.p
  %v1021 = getelementptr i64, ptr @"str.40", i64 0
  %v1022 = add i64 0, 1
  %v1023 = add i64 0, 0
  %v1024 = getelementptr i64, ptr %s1, i64 0
  %v1025 = ptrtoint ptr %v1021 to i64
  %st315 = getelementptr i64, ptr %v1024, i64 0
  store i64 %v1025, ptr %st315
  %st316 = getelementptr i64, ptr %v1024, i64 1
  store i64 %v1022, ptr %st316
  %st317 = getelementptr i64, ptr %v1024, i64 2
  store i64 %v1023, ptr %st317
  %v1026.p = getelementptr i64, ptr %v1024, i64 0
  %v1026 = load i64, ptr %v1026.p
  %v1027.p = getelementptr i64, ptr %v1024, i64 1
  %v1027 = load i64, ptr %v1027.p
  %v1028.p = getelementptr i64, ptr %v1024, i64 2
  %v1028 = load i64, ptr %v1028.p
  call void @"std/strings.TrimPrefix"(ptr %v1012, i64 %v1018, i64 %v1019, i64 %v1020, i64 %v1026, i64 %v1027, i64 %v1028)
  call void @"rt.print_str"(ptr %v1012)
  %v1029 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1029)
  %v1030 = getelementptr i64, ptr %s3, i64 0
  %v1031 = getelementptr i64, ptr @"str.41", i64 0
  %v1032 = add i64 0, 2
  %v1033 = add i64 0, 0
  %v1034 = getelementptr i64, ptr %s1, i64 0
  %v1035 = ptrtoint ptr %v1031 to i64
  %st318 = getelementptr i64, ptr %v1034, i64 0
  store i64 %v1035, ptr %st318
  %st319 = getelementptr i64, ptr %v1034, i64 1
  store i64 %v1032, ptr %st319
  %st320 = getelementptr i64, ptr %v1034, i64 2
  store i64 %v1033, ptr %st320
  %v1036.p = getelementptr i64, ptr %v1034, i64 0
  %v1036 = load i64, ptr %v1036.p
  %v1037.p = getelementptr i64, ptr %v1034, i64 1
  %v1037 = load i64, ptr %v1037.p
  %v1038.p = getelementptr i64, ptr %v1034, i64 2
  %v1038 = load i64, ptr %v1038.p
  %v1039 = getelementptr i64, ptr @"str.40", i64 0
  %v1040 = add i64 0, 1
  %v1041 = add i64 0, 0
  %v1042 = getelementptr i64, ptr %s0, i64 0
  %v1043 = ptrtoint ptr %v1039 to i64
  %st321 = getelementptr i64, ptr %v1042, i64 0
  store i64 %v1043, ptr %st321
  %st322 = getelementptr i64, ptr %v1042, i64 1
  store i64 %v1040, ptr %st322
  %st323 = getelementptr i64, ptr %v1042, i64 2
  store i64 %v1041, ptr %st323
  %v1044.p = getelementptr i64, ptr %v1042, i64 0
  %v1044 = load i64, ptr %v1044.p
  %v1045.p = getelementptr i64, ptr %v1042, i64 1
  %v1045 = load i64, ptr %v1045.p
  %v1046.p = getelementptr i64, ptr %v1042, i64 2
  %v1046 = load i64, ptr %v1046.p
  call void @"std/strings.TrimPrefix"(ptr %v1030, i64 %v1036, i64 %v1037, i64 %v1038, i64 %v1044, i64 %v1045, i64 %v1046)
  call void @"rt.print_str"(ptr %v1030)
  %v1047 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1047)
  %v1048 = getelementptr i64, ptr %s4, i64 0
  %v1049 = getelementptr i64, ptr @"str.6", i64 0
  %v1050 = add i64 0, 3
  %v1051 = add i64 0, 0
  %v1052 = getelementptr i64, ptr %s0, i64 0
  %v1053 = ptrtoint ptr %v1049 to i64
  %st324 = getelementptr i64, ptr %v1052, i64 0
  store i64 %v1053, ptr %st324
  %st325 = getelementptr i64, ptr %v1052, i64 1
  store i64 %v1050, ptr %st325
  %st326 = getelementptr i64, ptr %v1052, i64 2
  store i64 %v1051, ptr %st326
  %v1054.p = getelementptr i64, ptr %v1052, i64 0
  %v1054 = load i64, ptr %v1054.p
  %v1055.p = getelementptr i64, ptr %v1052, i64 1
  %v1055 = load i64, ptr %v1055.p
  %v1056.p = getelementptr i64, ptr %v1052, i64 2
  %v1056 = load i64, ptr %v1056.p
  %v1057 = getelementptr i64, ptr @"str.4", i64 0
  %v1058 = add i64 0, 0
  %v1059 = add i64 0, 0
  %v1060 = getelementptr i64, ptr %s1, i64 0
  %v1061 = ptrtoint ptr %v1057 to i64
  %st327 = getelementptr i64, ptr %v1060, i64 0
  store i64 %v1061, ptr %st327
  %st328 = getelementptr i64, ptr %v1060, i64 1
  store i64 %v1058, ptr %st328
  %st329 = getelementptr i64, ptr %v1060, i64 2
  store i64 %v1059, ptr %st329
  %v1062.p = getelementptr i64, ptr %v1060, i64 0
  %v1062 = load i64, ptr %v1062.p
  %v1063.p = getelementptr i64, ptr %v1060, i64 1
  %v1063 = load i64, ptr %v1063.p
  %v1064.p = getelementptr i64, ptr %v1060, i64 2
  %v1064 = load i64, ptr %v1064.p
  call void @"std/strings.TrimPrefix"(ptr %v1048, i64 %v1054, i64 %v1055, i64 %v1056, i64 %v1062, i64 %v1063, i64 %v1064)
  call void @"rt.print_str"(ptr %v1048)
  %v1065 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1065)
  %v1066 = getelementptr i64, ptr %s5, i64 0
  %v1067 = getelementptr i64, ptr @"str.4", i64 0
  %v1068 = add i64 0, 0
  %v1069 = add i64 0, 0
  %v1070 = getelementptr i64, ptr %s1, i64 0
  %v1071 = ptrtoint ptr %v1067 to i64
  %st330 = getelementptr i64, ptr %v1070, i64 0
  store i64 %v1071, ptr %st330
  %st331 = getelementptr i64, ptr %v1070, i64 1
  store i64 %v1068, ptr %st331
  %st332 = getelementptr i64, ptr %v1070, i64 2
  store i64 %v1069, ptr %st332
  %v1072.p = getelementptr i64, ptr %v1070, i64 0
  %v1072 = load i64, ptr %v1072.p
  %v1073.p = getelementptr i64, ptr %v1070, i64 1
  %v1073 = load i64, ptr %v1073.p
  %v1074.p = getelementptr i64, ptr %v1070, i64 2
  %v1074 = load i64, ptr %v1074.p
  %v1075 = getelementptr i64, ptr @"str.4", i64 0
  %v1076 = add i64 0, 0
  %v1077 = add i64 0, 0
  %v1078 = getelementptr i64, ptr %s0, i64 0
  %v1079 = ptrtoint ptr %v1075 to i64
  %st333 = getelementptr i64, ptr %v1078, i64 0
  store i64 %v1079, ptr %st333
  %st334 = getelementptr i64, ptr %v1078, i64 1
  store i64 %v1076, ptr %st334
  %st335 = getelementptr i64, ptr %v1078, i64 2
  store i64 %v1077, ptr %st335
  %v1080.p = getelementptr i64, ptr %v1078, i64 0
  %v1080 = load i64, ptr %v1080.p
  %v1081.p = getelementptr i64, ptr %v1078, i64 1
  %v1081 = load i64, ptr %v1081.p
  %v1082.p = getelementptr i64, ptr %v1078, i64 2
  %v1082 = load i64, ptr %v1082.p
  call void @"std/strings.TrimPrefix"(ptr %v1066, i64 %v1072, i64 %v1073, i64 %v1074, i64 %v1080, i64 %v1081, i64 %v1082)
  call void @"rt.print_str"(ptr %v1066)
  %v1083 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1083)
  %v1084 = getelementptr i64, ptr %s6, i64 0
  %v1085 = getelementptr i64, ptr @"str.14", i64 0
  %v1086 = add i64 0, 2
  %v1087 = add i64 0, 0
  %v1088 = getelementptr i64, ptr %s0, i64 0
  %v1089 = ptrtoint ptr %v1085 to i64
  %st336 = getelementptr i64, ptr %v1088, i64 0
  store i64 %v1089, ptr %st336
  %st337 = getelementptr i64, ptr %v1088, i64 1
  store i64 %v1086, ptr %st337
  %st338 = getelementptr i64, ptr %v1088, i64 2
  store i64 %v1087, ptr %st338
  %v1090.p = getelementptr i64, ptr %v1088, i64 0
  %v1090 = load i64, ptr %v1090.p
  %v1091.p = getelementptr i64, ptr %v1088, i64 1
  %v1091 = load i64, ptr %v1091.p
  %v1092.p = getelementptr i64, ptr %v1088, i64 2
  %v1092 = load i64, ptr %v1092.p
  %v1093 = getelementptr i64, ptr @"str.6", i64 0
  %v1094 = add i64 0, 3
  %v1095 = add i64 0, 0
  %v1096 = getelementptr i64, ptr %s1, i64 0
  %v1097 = ptrtoint ptr %v1093 to i64
  %st339 = getelementptr i64, ptr %v1096, i64 0
  store i64 %v1097, ptr %st339
  %st340 = getelementptr i64, ptr %v1096, i64 1
  store i64 %v1094, ptr %st340
  %st341 = getelementptr i64, ptr %v1096, i64 2
  store i64 %v1095, ptr %st341
  %v1098.p = getelementptr i64, ptr %v1096, i64 0
  %v1098 = load i64, ptr %v1098.p
  %v1099.p = getelementptr i64, ptr %v1096, i64 1
  %v1099 = load i64, ptr %v1099.p
  %v1100.p = getelementptr i64, ptr %v1096, i64 2
  %v1100 = load i64, ptr %v1100.p
  call void @"std/strings.TrimPrefix"(ptr %v1084, i64 %v1090, i64 %v1091, i64 %v1092, i64 %v1098, i64 %v1099, i64 %v1100)
  call void @"rt.print_str"(ptr %v1084)
  %v1101 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1101)
  %v1102 = getelementptr i64, ptr %s7, i64 0
  %v1103 = getelementptr i64, ptr @"str.20", i64 0
  %v1104 = add i64 0, 9
  %v1105 = add i64 0, 0
  %v1106 = getelementptr i64, ptr %s1, i64 0
  %v1107 = ptrtoint ptr %v1103 to i64
  %st342 = getelementptr i64, ptr %v1106, i64 0
  store i64 %v1107, ptr %st342
  %st343 = getelementptr i64, ptr %v1106, i64 1
  store i64 %v1104, ptr %st343
  %st344 = getelementptr i64, ptr %v1106, i64 2
  store i64 %v1105, ptr %st344
  %v1108.p = getelementptr i64, ptr %v1106, i64 0
  %v1108 = load i64, ptr %v1108.p
  %v1109.p = getelementptr i64, ptr %v1106, i64 1
  %v1109 = load i64, ptr %v1109.p
  %v1110.p = getelementptr i64, ptr %v1106, i64 2
  %v1110 = load i64, ptr %v1110.p
  %v1111 = getelementptr i64, ptr @"str.42", i64 0
  %v1112 = add i64 0, 3
  %v1113 = add i64 0, 0
  %v1114 = getelementptr i64, ptr %s0, i64 0
  %v1115 = ptrtoint ptr %v1111 to i64
  %st345 = getelementptr i64, ptr %v1114, i64 0
  store i64 %v1115, ptr %st345
  %st346 = getelementptr i64, ptr %v1114, i64 1
  store i64 %v1112, ptr %st346
  %st347 = getelementptr i64, ptr %v1114, i64 2
  store i64 %v1113, ptr %st347
  %v1116.p = getelementptr i64, ptr %v1114, i64 0
  %v1116 = load i64, ptr %v1116.p
  %v1117.p = getelementptr i64, ptr %v1114, i64 1
  %v1117 = load i64, ptr %v1117.p
  %v1118.p = getelementptr i64, ptr %v1114, i64 2
  %v1118 = load i64, ptr %v1118.p
  call void @"std/strings.TrimPrefix"(ptr %v1102, i64 %v1108, i64 %v1109, i64 %v1110, i64 %v1116, i64 %v1117, i64 %v1118)
  call void @"rt.print_str"(ptr %v1102)
  %v1119 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1119)
  %v1120 = getelementptr i64, ptr %s8, i64 0
  %v1121 = getelementptr i64, ptr @"str.9", i64 0
  %v1122 = add i64 0, 6
  %v1123 = add i64 0, 0
  %v1124 = getelementptr i64, ptr %s0, i64 0
  %v1125 = ptrtoint ptr %v1121 to i64
  %st348 = getelementptr i64, ptr %v1124, i64 0
  store i64 %v1125, ptr %st348
  %st349 = getelementptr i64, ptr %v1124, i64 1
  store i64 %v1122, ptr %st349
  %st350 = getelementptr i64, ptr %v1124, i64 2
  store i64 %v1123, ptr %st350
  %v1126.p = getelementptr i64, ptr %v1124, i64 0
  %v1126 = load i64, ptr %v1126.p
  %v1127.p = getelementptr i64, ptr %v1124, i64 1
  %v1127 = load i64, ptr %v1127.p
  %v1128.p = getelementptr i64, ptr %v1124, i64 2
  %v1128 = load i64, ptr %v1128.p
  %v1129 = getelementptr i64, ptr @"str.6", i64 0
  %v1130 = add i64 0, 3
  %v1131 = add i64 0, 0
  %v1132 = getelementptr i64, ptr %s1, i64 0
  %v1133 = ptrtoint ptr %v1129 to i64
  %st351 = getelementptr i64, ptr %v1132, i64 0
  store i64 %v1133, ptr %st351
  %st352 = getelementptr i64, ptr %v1132, i64 1
  store i64 %v1130, ptr %st352
  %st353 = getelementptr i64, ptr %v1132, i64 2
  store i64 %v1131, ptr %st353
  %v1134.p = getelementptr i64, ptr %v1132, i64 0
  %v1134 = load i64, ptr %v1134.p
  %v1135.p = getelementptr i64, ptr %v1132, i64 1
  %v1135 = load i64, ptr %v1135.p
  %v1136.p = getelementptr i64, ptr %v1132, i64 2
  %v1136 = load i64, ptr %v1136.p
  call void @"std/strings.TrimPrefix"(ptr %v1120, i64 %v1126, i64 %v1127, i64 %v1128, i64 %v1134, i64 %v1135, i64 %v1136)
  call void @"rt.print_str"(ptr %v1120)
  %v1137 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1137)
  %v1138 = getelementptr i64, ptr @"str.43", i64 0
  %v1139 = add i64 0, 3
  %v1140 = add i64 0, 0
  %v1141 = getelementptr i64, ptr %s1, i64 0
  %v1142 = ptrtoint ptr %v1138 to i64
  %st354 = getelementptr i64, ptr %v1141, i64 0
  store i64 %v1142, ptr %st354
  %st355 = getelementptr i64, ptr %v1141, i64 1
  store i64 %v1139, ptr %st355
  %st356 = getelementptr i64, ptr %v1141, i64 2
  store i64 %v1140, ptr %st356
  %v1143.p = getelementptr i64, ptr %v1141, i64 0
  %v1143 = load i64, ptr %v1143.p
  %v1144.p = getelementptr i64, ptr %v1141, i64 1
  %v1144 = load i64, ptr %v1144.p
  %v1145.p = getelementptr i64, ptr %v1141, i64 2
  %v1145 = load i64, ptr %v1145.p
  %v1146 = getelementptr i64, ptr @"str.44", i64 0
  %v1147 = add i64 0, 1
  %v1148 = add i64 0, 0
  %v1149 = getelementptr i64, ptr %s0, i64 0
  %v1150 = ptrtoint ptr %v1146 to i64
  %st357 = getelementptr i64, ptr %v1149, i64 0
  store i64 %v1150, ptr %st357
  %st358 = getelementptr i64, ptr %v1149, i64 1
  store i64 %v1147, ptr %st358
  %st359 = getelementptr i64, ptr %v1149, i64 2
  store i64 %v1148, ptr %st359
  %v1151.p = getelementptr i64, ptr %v1149, i64 0
  %v1151 = load i64, ptr %v1151.p
  %v1152.p = getelementptr i64, ptr %v1149, i64 1
  %v1152 = load i64, ptr %v1152.p
  %v1153.p = getelementptr i64, ptr %v1149, i64 2
  %v1153 = load i64, ptr %v1153.p
  call void @"main.showCut"(i64 %v1143, i64 %v1144, i64 %v1145, i64 %v1151, i64 %v1152, i64 %v1153)
  %v1154 = getelementptr i64, ptr @"str.45", i64 0
  %v1155 = add i64 0, 5
  %v1156 = add i64 0, 0
  %v1157 = getelementptr i64, ptr %s0, i64 0
  %v1158 = ptrtoint ptr %v1154 to i64
  %st360 = getelementptr i64, ptr %v1157, i64 0
  store i64 %v1158, ptr %st360
  %st361 = getelementptr i64, ptr %v1157, i64 1
  store i64 %v1155, ptr %st361
  %st362 = getelementptr i64, ptr %v1157, i64 2
  store i64 %v1156, ptr %st362
  %v1159.p = getelementptr i64, ptr %v1157, i64 0
  %v1159 = load i64, ptr %v1159.p
  %v1160.p = getelementptr i64, ptr %v1157, i64 1
  %v1160 = load i64, ptr %v1160.p
  %v1161.p = getelementptr i64, ptr %v1157, i64 2
  %v1161 = load i64, ptr %v1161.p
  %v1162 = getelementptr i64, ptr @"str.44", i64 0
  %v1163 = add i64 0, 1
  %v1164 = add i64 0, 0
  %v1165 = getelementptr i64, ptr %s1, i64 0
  %v1166 = ptrtoint ptr %v1162 to i64
  %st363 = getelementptr i64, ptr %v1165, i64 0
  store i64 %v1166, ptr %st363
  %st364 = getelementptr i64, ptr %v1165, i64 1
  store i64 %v1163, ptr %st364
  %st365 = getelementptr i64, ptr %v1165, i64 2
  store i64 %v1164, ptr %st365
  %v1167.p = getelementptr i64, ptr %v1165, i64 0
  %v1167 = load i64, ptr %v1167.p
  %v1168.p = getelementptr i64, ptr %v1165, i64 1
  %v1168 = load i64, ptr %v1168.p
  %v1169.p = getelementptr i64, ptr %v1165, i64 2
  %v1169 = load i64, ptr %v1169.p
  call void @"main.showCut"(i64 %v1159, i64 %v1160, i64 %v1161, i64 %v1167, i64 %v1168, i64 %v1169)
  %v1170 = getelementptr i64, ptr @"str.46", i64 0
  %v1171 = add i64 0, 2
  %v1172 = add i64 0, 0
  %v1173 = getelementptr i64, ptr %s1, i64 0
  %v1174 = ptrtoint ptr %v1170 to i64
  %st366 = getelementptr i64, ptr %v1173, i64 0
  store i64 %v1174, ptr %st366
  %st367 = getelementptr i64, ptr %v1173, i64 1
  store i64 %v1171, ptr %st367
  %st368 = getelementptr i64, ptr %v1173, i64 2
  store i64 %v1172, ptr %st368
  %v1175.p = getelementptr i64, ptr %v1173, i64 0
  %v1175 = load i64, ptr %v1175.p
  %v1176.p = getelementptr i64, ptr %v1173, i64 1
  %v1176 = load i64, ptr %v1176.p
  %v1177.p = getelementptr i64, ptr %v1173, i64 2
  %v1177 = load i64, ptr %v1177.p
  %v1178 = getelementptr i64, ptr @"str.44", i64 0
  %v1179 = add i64 0, 1
  %v1180 = add i64 0, 0
  %v1181 = getelementptr i64, ptr %s0, i64 0
  %v1182 = ptrtoint ptr %v1178 to i64
  %st369 = getelementptr i64, ptr %v1181, i64 0
  store i64 %v1182, ptr %st369
  %st370 = getelementptr i64, ptr %v1181, i64 1
  store i64 %v1179, ptr %st370
  %st371 = getelementptr i64, ptr %v1181, i64 2
  store i64 %v1180, ptr %st371
  %v1183.p = getelementptr i64, ptr %v1181, i64 0
  %v1183 = load i64, ptr %v1183.p
  %v1184.p = getelementptr i64, ptr %v1181, i64 1
  %v1184 = load i64, ptr %v1184.p
  %v1185.p = getelementptr i64, ptr %v1181, i64 2
  %v1185 = load i64, ptr %v1185.p
  call void @"main.showCut"(i64 %v1175, i64 %v1176, i64 %v1177, i64 %v1183, i64 %v1184, i64 %v1185)
  %v1186 = getelementptr i64, ptr @"str.4", i64 0
  %v1187 = add i64 0, 0
  %v1188 = add i64 0, 0
  %v1189 = getelementptr i64, ptr %s0, i64 0
  %v1190 = ptrtoint ptr %v1186 to i64
  %st372 = getelementptr i64, ptr %v1189, i64 0
  store i64 %v1190, ptr %st372
  %st373 = getelementptr i64, ptr %v1189, i64 1
  store i64 %v1187, ptr %st373
  %st374 = getelementptr i64, ptr %v1189, i64 2
  store i64 %v1188, ptr %st374
  %v1191.p = getelementptr i64, ptr %v1189, i64 0
  %v1191 = load i64, ptr %v1191.p
  %v1192.p = getelementptr i64, ptr %v1189, i64 1
  %v1192 = load i64, ptr %v1192.p
  %v1193.p = getelementptr i64, ptr %v1189, i64 2
  %v1193 = load i64, ptr %v1193.p
  %v1194 = getelementptr i64, ptr @"str.44", i64 0
  %v1195 = add i64 0, 1
  %v1196 = add i64 0, 0
  %v1197 = getelementptr i64, ptr %s1, i64 0
  %v1198 = ptrtoint ptr %v1194 to i64
  %st375 = getelementptr i64, ptr %v1197, i64 0
  store i64 %v1198, ptr %st375
  %st376 = getelementptr i64, ptr %v1197, i64 1
  store i64 %v1195, ptr %st376
  %st377 = getelementptr i64, ptr %v1197, i64 2
  store i64 %v1196, ptr %st377
  %v1199.p = getelementptr i64, ptr %v1197, i64 0
  %v1199 = load i64, ptr %v1199.p
  %v1200.p = getelementptr i64, ptr %v1197, i64 1
  %v1200 = load i64, ptr %v1200.p
  %v1201.p = getelementptr i64, ptr %v1197, i64 2
  %v1201 = load i64, ptr %v1201.p
  call void @"main.showCut"(i64 %v1191, i64 %v1192, i64 %v1193, i64 %v1199, i64 %v1200, i64 %v1201)
  %v1202 = getelementptr i64, ptr @"str.6", i64 0
  %v1203 = add i64 0, 3
  %v1204 = add i64 0, 0
  %v1205 = getelementptr i64, ptr %s1, i64 0
  %v1206 = ptrtoint ptr %v1202 to i64
  %st378 = getelementptr i64, ptr %v1205, i64 0
  store i64 %v1206, ptr %st378
  %st379 = getelementptr i64, ptr %v1205, i64 1
  store i64 %v1203, ptr %st379
  %st380 = getelementptr i64, ptr %v1205, i64 2
  store i64 %v1204, ptr %st380
  %v1207.p = getelementptr i64, ptr %v1205, i64 0
  %v1207 = load i64, ptr %v1207.p
  %v1208.p = getelementptr i64, ptr %v1205, i64 1
  %v1208 = load i64, ptr %v1208.p
  %v1209.p = getelementptr i64, ptr %v1205, i64 2
  %v1209 = load i64, ptr %v1209.p
  %v1210 = getelementptr i64, ptr @"str.4", i64 0
  %v1211 = add i64 0, 0
  %v1212 = add i64 0, 0
  %v1213 = getelementptr i64, ptr %s0, i64 0
  %v1214 = ptrtoint ptr %v1210 to i64
  %st381 = getelementptr i64, ptr %v1213, i64 0
  store i64 %v1214, ptr %st381
  %st382 = getelementptr i64, ptr %v1213, i64 1
  store i64 %v1211, ptr %st382
  %st383 = getelementptr i64, ptr %v1213, i64 2
  store i64 %v1212, ptr %st383
  %v1215.p = getelementptr i64, ptr %v1213, i64 0
  %v1215 = load i64, ptr %v1215.p
  %v1216.p = getelementptr i64, ptr %v1213, i64 1
  %v1216 = load i64, ptr %v1216.p
  %v1217.p = getelementptr i64, ptr %v1213, i64 2
  %v1217 = load i64, ptr %v1217.p
  call void @"main.showCut"(i64 %v1207, i64 %v1208, i64 %v1209, i64 %v1215, i64 %v1216, i64 %v1217)
  %v1218 = getelementptr i64, ptr @"str.47", i64 0
  %v1219 = add i64 0, 2
  %v1220 = add i64 0, 0
  %v1221 = getelementptr i64, ptr %s0, i64 0
  %v1222 = ptrtoint ptr %v1218 to i64
  %st384 = getelementptr i64, ptr %v1221, i64 0
  store i64 %v1222, ptr %st384
  %st385 = getelementptr i64, ptr %v1221, i64 1
  store i64 %v1219, ptr %st385
  %st386 = getelementptr i64, ptr %v1221, i64 2
  store i64 %v1220, ptr %st386
  %v1223.p = getelementptr i64, ptr %v1221, i64 0
  %v1223 = load i64, ptr %v1223.p
  %v1224.p = getelementptr i64, ptr %v1221, i64 1
  %v1224 = load i64, ptr %v1224.p
  %v1225.p = getelementptr i64, ptr %v1221, i64 2
  %v1225 = load i64, ptr %v1225.p
  %v1226 = getelementptr i64, ptr @"str.44", i64 0
  %v1227 = add i64 0, 1
  %v1228 = add i64 0, 0
  %v1229 = getelementptr i64, ptr %s1, i64 0
  %v1230 = ptrtoint ptr %v1226 to i64
  %st387 = getelementptr i64, ptr %v1229, i64 0
  store i64 %v1230, ptr %st387
  %st388 = getelementptr i64, ptr %v1229, i64 1
  store i64 %v1227, ptr %st388
  %st389 = getelementptr i64, ptr %v1229, i64 2
  store i64 %v1228, ptr %st389
  %v1231.p = getelementptr i64, ptr %v1229, i64 0
  %v1231 = load i64, ptr %v1231.p
  %v1232.p = getelementptr i64, ptr %v1229, i64 1
  %v1232 = load i64, ptr %v1232.p
  %v1233.p = getelementptr i64, ptr %v1229, i64 2
  %v1233 = load i64, ptr %v1233.p
  call void @"main.showCut"(i64 %v1223, i64 %v1224, i64 %v1225, i64 %v1231, i64 %v1232, i64 %v1233)
  %v1234 = getelementptr i64, ptr @"str.48", i64 0
  %v1235 = add i64 0, 2
  %v1236 = add i64 0, 0
  %v1237 = getelementptr i64, ptr %s1, i64 0
  %v1238 = ptrtoint ptr %v1234 to i64
  %st390 = getelementptr i64, ptr %v1237, i64 0
  store i64 %v1238, ptr %st390
  %st391 = getelementptr i64, ptr %v1237, i64 1
  store i64 %v1235, ptr %st391
  %st392 = getelementptr i64, ptr %v1237, i64 2
  store i64 %v1236, ptr %st392
  %v1239.p = getelementptr i64, ptr %v1237, i64 0
  %v1239 = load i64, ptr %v1239.p
  %v1240.p = getelementptr i64, ptr %v1237, i64 1
  %v1240 = load i64, ptr %v1240.p
  %v1241.p = getelementptr i64, ptr %v1237, i64 2
  %v1241 = load i64, ptr %v1241.p
  %v1242 = getelementptr i64, ptr @"str.44", i64 0
  %v1243 = add i64 0, 1
  %v1244 = add i64 0, 0
  %v1245 = getelementptr i64, ptr %s0, i64 0
  %v1246 = ptrtoint ptr %v1242 to i64
  %st393 = getelementptr i64, ptr %v1245, i64 0
  store i64 %v1246, ptr %st393
  %st394 = getelementptr i64, ptr %v1245, i64 1
  store i64 %v1243, ptr %st394
  %st395 = getelementptr i64, ptr %v1245, i64 2
  store i64 %v1244, ptr %st395
  %v1247.p = getelementptr i64, ptr %v1245, i64 0
  %v1247 = load i64, ptr %v1247.p
  %v1248.p = getelementptr i64, ptr %v1245, i64 1
  %v1248 = load i64, ptr %v1248.p
  %v1249.p = getelementptr i64, ptr %v1245, i64 2
  %v1249 = load i64, ptr %v1249.p
  call void @"main.showCut"(i64 %v1239, i64 %v1240, i64 %v1241, i64 %v1247, i64 %v1248, i64 %v1249)
  %v1250 = getelementptr i64, ptr @"str.49", i64 0
  %v1251 = add i64 0, 7
  %v1252 = add i64 0, 0
  %v1253 = getelementptr i64, ptr %s0, i64 0
  %v1254 = ptrtoint ptr %v1250 to i64
  %st396 = getelementptr i64, ptr %v1253, i64 0
  store i64 %v1254, ptr %st396
  %st397 = getelementptr i64, ptr %v1253, i64 1
  store i64 %v1251, ptr %st397
  %st398 = getelementptr i64, ptr %v1253, i64 2
  store i64 %v1252, ptr %st398
  %v1255.p = getelementptr i64, ptr %v1253, i64 0
  %v1255 = load i64, ptr %v1255.p
  %v1256.p = getelementptr i64, ptr %v1253, i64 1
  %v1256 = load i64, ptr %v1256.p
  %v1257.p = getelementptr i64, ptr %v1253, i64 2
  %v1257 = load i64, ptr %v1257.p
  %v1258 = getelementptr i64, ptr @"str.44", i64 0
  %v1259 = add i64 0, 1
  %v1260 = add i64 0, 0
  %v1261 = getelementptr i64, ptr %s1, i64 0
  %v1262 = ptrtoint ptr %v1258 to i64
  %st399 = getelementptr i64, ptr %v1261, i64 0
  store i64 %v1262, ptr %st399
  %st400 = getelementptr i64, ptr %v1261, i64 1
  store i64 %v1259, ptr %st400
  %st401 = getelementptr i64, ptr %v1261, i64 2
  store i64 %v1260, ptr %st401
  %v1263.p = getelementptr i64, ptr %v1261, i64 0
  %v1263 = load i64, ptr %v1263.p
  %v1264.p = getelementptr i64, ptr %v1261, i64 1
  %v1264 = load i64, ptr %v1264.p
  %v1265.p = getelementptr i64, ptr %v1261, i64 2
  %v1265 = load i64, ptr %v1265.p
  call void @"main.showCut"(i64 %v1255, i64 %v1256, i64 %v1257, i64 %v1263, i64 %v1264, i64 %v1265)
  %v1266 = getelementptr i64, ptr @"str.50", i64 0
  %v1267 = add i64 0, 7
  %v1268 = add i64 0, 0
  %v1269 = getelementptr i64, ptr %s1, i64 0
  %v1270 = ptrtoint ptr %v1266 to i64
  %st402 = getelementptr i64, ptr %v1269, i64 0
  store i64 %v1270, ptr %st402
  %st403 = getelementptr i64, ptr %v1269, i64 1
  store i64 %v1267, ptr %st403
  %st404 = getelementptr i64, ptr %v1269, i64 2
  store i64 %v1268, ptr %st404
  %v1271.p = getelementptr i64, ptr %v1269, i64 0
  %v1271 = load i64, ptr %v1271.p
  %v1272.p = getelementptr i64, ptr %v1269, i64 1
  %v1272 = load i64, ptr %v1272.p
  %v1273.p = getelementptr i64, ptr %v1269, i64 2
  %v1273 = load i64, ptr %v1273.p
  %v1274 = getelementptr i64, ptr @"str.51", i64 0
  %v1275 = add i64 0, 2
  %v1276 = add i64 0, 0
  %v1277 = getelementptr i64, ptr %s0, i64 0
  %v1278 = ptrtoint ptr %v1274 to i64
  %st405 = getelementptr i64, ptr %v1277, i64 0
  store i64 %v1278, ptr %st405
  %st406 = getelementptr i64, ptr %v1277, i64 1
  store i64 %v1275, ptr %st406
  %st407 = getelementptr i64, ptr %v1277, i64 2
  store i64 %v1276, ptr %st407
  %v1279.p = getelementptr i64, ptr %v1277, i64 0
  %v1279 = load i64, ptr %v1279.p
  %v1280.p = getelementptr i64, ptr %v1277, i64 1
  %v1280 = load i64, ptr %v1280.p
  %v1281.p = getelementptr i64, ptr %v1277, i64 2
  %v1281 = load i64, ptr %v1281.p
  call void @"main.showCut"(i64 %v1271, i64 %v1272, i64 %v1273, i64 %v1279, i64 %v1280, i64 %v1281)
  %v1282 = getelementptr i64, ptr @"str.20", i64 0
  %v1283 = add i64 0, 9
  %v1284 = add i64 0, 0
  %v1285 = getelementptr i64, ptr %s0, i64 0
  %v1286 = ptrtoint ptr %v1282 to i64
  %st408 = getelementptr i64, ptr %v1285, i64 0
  store i64 %v1286, ptr %st408
  %st409 = getelementptr i64, ptr %v1285, i64 1
  store i64 %v1283, ptr %st409
  %st410 = getelementptr i64, ptr %v1285, i64 2
  store i64 %v1284, ptr %st410
  %v1287.p = getelementptr i64, ptr %v1285, i64 0
  %v1287 = load i64, ptr %v1287.p
  %v1288.p = getelementptr i64, ptr %v1285, i64 1
  %v1288 = load i64, ptr %v1288.p
  %v1289.p = getelementptr i64, ptr %v1285, i64 2
  %v1289 = load i64, ptr %v1289.p
  %v1290 = getelementptr i64, ptr @"str.21", i64 0
  %v1291 = add i64 0, 3
  %v1292 = add i64 0, 0
  %v1293 = getelementptr i64, ptr %s1, i64 0
  %v1294 = ptrtoint ptr %v1290 to i64
  %st411 = getelementptr i64, ptr %v1293, i64 0
  store i64 %v1294, ptr %st411
  %st412 = getelementptr i64, ptr %v1293, i64 1
  store i64 %v1291, ptr %st412
  %st413 = getelementptr i64, ptr %v1293, i64 2
  store i64 %v1292, ptr %st413
  %v1295.p = getelementptr i64, ptr %v1293, i64 0
  %v1295 = load i64, ptr %v1295.p
  %v1296.p = getelementptr i64, ptr %v1293, i64 1
  %v1296 = load i64, ptr %v1296.p
  %v1297.p = getelementptr i64, ptr %v1293, i64 2
  %v1297 = load i64, ptr %v1297.p
  call void @"main.showCut"(i64 %v1287, i64 %v1288, i64 %v1289, i64 %v1295, i64 %v1296, i64 %v1297)
  %v1298 = getelementptr i64, ptr @"str.52", i64 0
  %v1299 = add i64 0, 5
  %v1300 = add i64 0, 0
  %v1301 = getelementptr i64, ptr %s1, i64 0
  %v1302 = ptrtoint ptr %v1298 to i64
  %st414 = getelementptr i64, ptr %v1301, i64 0
  store i64 %v1302, ptr %st414
  %st415 = getelementptr i64, ptr %v1301, i64 1
  store i64 %v1299, ptr %st415
  %st416 = getelementptr i64, ptr %v1301, i64 2
  store i64 %v1300, ptr %st416
  %v1303.p = getelementptr i64, ptr %v1301, i64 0
  %v1303 = load i64, ptr %v1303.p
  %v1304.p = getelementptr i64, ptr %v1301, i64 1
  %v1304 = load i64, ptr %v1304.p
  %v1305.p = getelementptr i64, ptr %v1301, i64 2
  %v1305 = load i64, ptr %v1305.p
  %v1306 = getelementptr i64, ptr @"str.53", i64 0
  %v1307 = add i64 0, 1
  %v1308 = add i64 0, 0
  %v1309 = getelementptr i64, ptr %s0, i64 0
  %v1310 = ptrtoint ptr %v1306 to i64
  %st417 = getelementptr i64, ptr %v1309, i64 0
  store i64 %v1310, ptr %st417
  %st418 = getelementptr i64, ptr %v1309, i64 1
  store i64 %v1307, ptr %st418
  %st419 = getelementptr i64, ptr %v1309, i64 2
  store i64 %v1308, ptr %st419
  %v1311.p = getelementptr i64, ptr %v1309, i64 0
  %v1311 = load i64, ptr %v1311.p
  %v1312.p = getelementptr i64, ptr %v1309, i64 1
  %v1312 = load i64, ptr %v1312.p
  %v1313.p = getelementptr i64, ptr %v1309, i64 2
  %v1313 = load i64, ptr %v1313.p
  call void @"main.showCutLast"(i64 %v1303, i64 %v1304, i64 %v1305, i64 %v1311, i64 %v1312, i64 %v1313)
  %v1314 = getelementptr i64, ptr @"str.6", i64 0
  %v1315 = add i64 0, 3
  %v1316 = add i64 0, 0
  %v1317 = getelementptr i64, ptr %s0, i64 0
  %v1318 = ptrtoint ptr %v1314 to i64
  %st420 = getelementptr i64, ptr %v1317, i64 0
  store i64 %v1318, ptr %st420
  %st421 = getelementptr i64, ptr %v1317, i64 1
  store i64 %v1315, ptr %st421
  %st422 = getelementptr i64, ptr %v1317, i64 2
  store i64 %v1316, ptr %st422
  %v1319.p = getelementptr i64, ptr %v1317, i64 0
  %v1319 = load i64, ptr %v1319.p
  %v1320.p = getelementptr i64, ptr %v1317, i64 1
  %v1320 = load i64, ptr %v1320.p
  %v1321.p = getelementptr i64, ptr %v1317, i64 2
  %v1321 = load i64, ptr %v1321.p
  %v1322 = getelementptr i64, ptr @"str.53", i64 0
  %v1323 = add i64 0, 1
  %v1324 = add i64 0, 0
  %v1325 = getelementptr i64, ptr %s1, i64 0
  %v1326 = ptrtoint ptr %v1322 to i64
  %st423 = getelementptr i64, ptr %v1325, i64 0
  store i64 %v1326, ptr %st423
  %st424 = getelementptr i64, ptr %v1325, i64 1
  store i64 %v1323, ptr %st424
  %st425 = getelementptr i64, ptr %v1325, i64 2
  store i64 %v1324, ptr %st425
  %v1327.p = getelementptr i64, ptr %v1325, i64 0
  %v1327 = load i64, ptr %v1327.p
  %v1328.p = getelementptr i64, ptr %v1325, i64 1
  %v1328 = load i64, ptr %v1328.p
  %v1329.p = getelementptr i64, ptr %v1325, i64 2
  %v1329 = load i64, ptr %v1329.p
  call void @"main.showCutLast"(i64 %v1319, i64 %v1320, i64 %v1321, i64 %v1327, i64 %v1328, i64 %v1329)
  %v1330 = getelementptr i64, ptr @"str.54", i64 0
  %v1331 = add i64 0, 4
  %v1332 = add i64 0, 0
  %v1333 = getelementptr i64, ptr %s1, i64 0
  %v1334 = ptrtoint ptr %v1330 to i64
  %st426 = getelementptr i64, ptr %v1333, i64 0
  store i64 %v1334, ptr %st426
  %st427 = getelementptr i64, ptr %v1333, i64 1
  store i64 %v1331, ptr %st427
  %st428 = getelementptr i64, ptr %v1333, i64 2
  store i64 %v1332, ptr %st428
  %v1335.p = getelementptr i64, ptr %v1333, i64 0
  %v1335 = load i64, ptr %v1335.p
  %v1336.p = getelementptr i64, ptr %v1333, i64 1
  %v1336 = load i64, ptr %v1336.p
  %v1337.p = getelementptr i64, ptr %v1333, i64 2
  %v1337 = load i64, ptr %v1337.p
  %v1338 = getelementptr i64, ptr @"str.53", i64 0
  %v1339 = add i64 0, 1
  %v1340 = add i64 0, 0
  %v1341 = getelementptr i64, ptr %s0, i64 0
  %v1342 = ptrtoint ptr %v1338 to i64
  %st429 = getelementptr i64, ptr %v1341, i64 0
  store i64 %v1342, ptr %st429
  %st430 = getelementptr i64, ptr %v1341, i64 1
  store i64 %v1339, ptr %st430
  %st431 = getelementptr i64, ptr %v1341, i64 2
  store i64 %v1340, ptr %st431
  %v1343.p = getelementptr i64, ptr %v1341, i64 0
  %v1343 = load i64, ptr %v1343.p
  %v1344.p = getelementptr i64, ptr %v1341, i64 1
  %v1344 = load i64, ptr %v1344.p
  %v1345.p = getelementptr i64, ptr %v1341, i64 2
  %v1345 = load i64, ptr %v1345.p
  call void @"main.showCutLast"(i64 %v1335, i64 %v1336, i64 %v1337, i64 %v1343, i64 %v1344, i64 %v1345)
  %v1346 = getelementptr i64, ptr @"str.55", i64 0
  %v1347 = add i64 0, 4
  %v1348 = add i64 0, 0
  %v1349 = getelementptr i64, ptr %s0, i64 0
  %v1350 = ptrtoint ptr %v1346 to i64
  %st432 = getelementptr i64, ptr %v1349, i64 0
  store i64 %v1350, ptr %st432
  %st433 = getelementptr i64, ptr %v1349, i64 1
  store i64 %v1347, ptr %st433
  %st434 = getelementptr i64, ptr %v1349, i64 2
  store i64 %v1348, ptr %st434
  %v1351.p = getelementptr i64, ptr %v1349, i64 0
  %v1351 = load i64, ptr %v1351.p
  %v1352.p = getelementptr i64, ptr %v1349, i64 1
  %v1352 = load i64, ptr %v1352.p
  %v1353.p = getelementptr i64, ptr %v1349, i64 2
  %v1353 = load i64, ptr %v1353.p
  %v1354 = getelementptr i64, ptr @"str.53", i64 0
  %v1355 = add i64 0, 1
  %v1356 = add i64 0, 0
  %v1357 = getelementptr i64, ptr %s1, i64 0
  %v1358 = ptrtoint ptr %v1354 to i64
  %st435 = getelementptr i64, ptr %v1357, i64 0
  store i64 %v1358, ptr %st435
  %st436 = getelementptr i64, ptr %v1357, i64 1
  store i64 %v1355, ptr %st436
  %st437 = getelementptr i64, ptr %v1357, i64 2
  store i64 %v1356, ptr %st437
  %v1359.p = getelementptr i64, ptr %v1357, i64 0
  %v1359 = load i64, ptr %v1359.p
  %v1360.p = getelementptr i64, ptr %v1357, i64 1
  %v1360 = load i64, ptr %v1360.p
  %v1361.p = getelementptr i64, ptr %v1357, i64 2
  %v1361 = load i64, ptr %v1361.p
  call void @"main.showCutLast"(i64 %v1351, i64 %v1352, i64 %v1353, i64 %v1359, i64 %v1360, i64 %v1361)
  %v1362 = getelementptr i64, ptr @"str.6", i64 0
  %v1363 = add i64 0, 3
  %v1364 = add i64 0, 0
  %v1365 = getelementptr i64, ptr %s1, i64 0
  %v1366 = ptrtoint ptr %v1362 to i64
  %st438 = getelementptr i64, ptr %v1365, i64 0
  store i64 %v1366, ptr %st438
  %st439 = getelementptr i64, ptr %v1365, i64 1
  store i64 %v1363, ptr %st439
  %st440 = getelementptr i64, ptr %v1365, i64 2
  store i64 %v1364, ptr %st440
  %v1367.p = getelementptr i64, ptr %v1365, i64 0
  %v1367 = load i64, ptr %v1367.p
  %v1368.p = getelementptr i64, ptr %v1365, i64 1
  %v1368 = load i64, ptr %v1368.p
  %v1369.p = getelementptr i64, ptr %v1365, i64 2
  %v1369 = load i64, ptr %v1369.p
  %v1370 = getelementptr i64, ptr @"str.4", i64 0
  %v1371 = add i64 0, 0
  %v1372 = add i64 0, 0
  %v1373 = getelementptr i64, ptr %s0, i64 0
  %v1374 = ptrtoint ptr %v1370 to i64
  %st441 = getelementptr i64, ptr %v1373, i64 0
  store i64 %v1374, ptr %st441
  %st442 = getelementptr i64, ptr %v1373, i64 1
  store i64 %v1371, ptr %st442
  %st443 = getelementptr i64, ptr %v1373, i64 2
  store i64 %v1372, ptr %st443
  %v1375.p = getelementptr i64, ptr %v1373, i64 0
  %v1375 = load i64, ptr %v1375.p
  %v1376.p = getelementptr i64, ptr %v1373, i64 1
  %v1376 = load i64, ptr %v1376.p
  %v1377.p = getelementptr i64, ptr %v1373, i64 2
  %v1377 = load i64, ptr %v1377.p
  call void @"main.showCutLast"(i64 %v1367, i64 %v1368, i64 %v1369, i64 %v1375, i64 %v1376, i64 %v1377)
  %v1378 = getelementptr i64, ptr @"str.4", i64 0
  %v1379 = add i64 0, 0
  %v1380 = add i64 0, 0
  %v1381 = getelementptr i64, ptr %s0, i64 0
  %v1382 = ptrtoint ptr %v1378 to i64
  %st444 = getelementptr i64, ptr %v1381, i64 0
  store i64 %v1382, ptr %st444
  %st445 = getelementptr i64, ptr %v1381, i64 1
  store i64 %v1379, ptr %st445
  %st446 = getelementptr i64, ptr %v1381, i64 2
  store i64 %v1380, ptr %st446
  %v1383.p = getelementptr i64, ptr %v1381, i64 0
  %v1383 = load i64, ptr %v1383.p
  %v1384.p = getelementptr i64, ptr %v1381, i64 1
  %v1384 = load i64, ptr %v1384.p
  %v1385.p = getelementptr i64, ptr %v1381, i64 2
  %v1385 = load i64, ptr %v1385.p
  %v1386 = getelementptr i64, ptr @"str.4", i64 0
  %v1387 = add i64 0, 0
  %v1388 = add i64 0, 0
  %v1389 = getelementptr i64, ptr %s1, i64 0
  %v1390 = ptrtoint ptr %v1386 to i64
  %st447 = getelementptr i64, ptr %v1389, i64 0
  store i64 %v1390, ptr %st447
  %st448 = getelementptr i64, ptr %v1389, i64 1
  store i64 %v1387, ptr %st448
  %st449 = getelementptr i64, ptr %v1389, i64 2
  store i64 %v1388, ptr %st449
  %v1391.p = getelementptr i64, ptr %v1389, i64 0
  %v1391 = load i64, ptr %v1391.p
  %v1392.p = getelementptr i64, ptr %v1389, i64 1
  %v1392 = load i64, ptr %v1392.p
  %v1393.p = getelementptr i64, ptr %v1389, i64 2
  %v1393 = load i64, ptr %v1393.p
  call void @"main.showCutLast"(i64 %v1383, i64 %v1384, i64 %v1385, i64 %v1391, i64 %v1392, i64 %v1393)
  %v1394 = getelementptr i64, ptr @"str.50", i64 0
  %v1395 = add i64 0, 7
  %v1396 = add i64 0, 0
  %v1397 = getelementptr i64, ptr %s1, i64 0
  %v1398 = ptrtoint ptr %v1394 to i64
  %st450 = getelementptr i64, ptr %v1397, i64 0
  store i64 %v1398, ptr %st450
  %st451 = getelementptr i64, ptr %v1397, i64 1
  store i64 %v1395, ptr %st451
  %st452 = getelementptr i64, ptr %v1397, i64 2
  store i64 %v1396, ptr %st452
  %v1399.p = getelementptr i64, ptr %v1397, i64 0
  %v1399 = load i64, ptr %v1399.p
  %v1400.p = getelementptr i64, ptr %v1397, i64 1
  %v1400 = load i64, ptr %v1400.p
  %v1401.p = getelementptr i64, ptr %v1397, i64 2
  %v1401 = load i64, ptr %v1401.p
  %v1402 = getelementptr i64, ptr @"str.51", i64 0
  %v1403 = add i64 0, 2
  %v1404 = add i64 0, 0
  %v1405 = getelementptr i64, ptr %s0, i64 0
  %v1406 = ptrtoint ptr %v1402 to i64
  %st453 = getelementptr i64, ptr %v1405, i64 0
  store i64 %v1406, ptr %st453
  %st454 = getelementptr i64, ptr %v1405, i64 1
  store i64 %v1403, ptr %st454
  %st455 = getelementptr i64, ptr %v1405, i64 2
  store i64 %v1404, ptr %st455
  %v1407.p = getelementptr i64, ptr %v1405, i64 0
  %v1407 = load i64, ptr %v1407.p
  %v1408.p = getelementptr i64, ptr %v1405, i64 1
  %v1408 = load i64, ptr %v1408.p
  %v1409.p = getelementptr i64, ptr %v1405, i64 2
  %v1409 = load i64, ptr %v1409.p
  call void @"main.showCutLast"(i64 %v1399, i64 %v1400, i64 %v1401, i64 %v1407, i64 %v1408, i64 %v1409)
  %v1410 = getelementptr i64, ptr @"str.56", i64 0
  %v1411 = add i64 0, 11
  %v1412 = add i64 0, 0
  %v1413 = getelementptr i64, ptr %s0, i64 0
  %v1414 = ptrtoint ptr %v1410 to i64
  %st456 = getelementptr i64, ptr %v1413, i64 0
  store i64 %v1414, ptr %st456
  %st457 = getelementptr i64, ptr %v1413, i64 1
  store i64 %v1411, ptr %st457
  %st458 = getelementptr i64, ptr %v1413, i64 2
  store i64 %v1412, ptr %st458
  %v1415.p = getelementptr i64, ptr %v1413, i64 0
  %v1415 = load i64, ptr %v1415.p
  %v1416.p = getelementptr i64, ptr %v1413, i64 1
  %v1416 = load i64, ptr %v1416.p
  %v1417.p = getelementptr i64, ptr %v1413, i64 2
  %v1417 = load i64, ptr %v1417.p
  %v1418 = getelementptr i64, ptr @"str.53", i64 0
  %v1419 = add i64 0, 1
  %v1420 = add i64 0, 0
  %v1421 = getelementptr i64, ptr %s1, i64 0
  %v1422 = ptrtoint ptr %v1418 to i64
  %st459 = getelementptr i64, ptr %v1421, i64 0
  store i64 %v1422, ptr %st459
  %st460 = getelementptr i64, ptr %v1421, i64 1
  store i64 %v1419, ptr %st460
  %st461 = getelementptr i64, ptr %v1421, i64 2
  store i64 %v1420, ptr %st461
  %v1423.p = getelementptr i64, ptr %v1421, i64 0
  %v1423 = load i64, ptr %v1423.p
  %v1424.p = getelementptr i64, ptr %v1421, i64 1
  %v1424 = load i64, ptr %v1424.p
  %v1425.p = getelementptr i64, ptr %v1421, i64 2
  %v1425 = load i64, ptr %v1425.p
  call void @"main.showCutLast"(i64 %v1415, i64 %v1416, i64 %v1417, i64 %v1423, i64 %v1424, i64 %v1425)
  %v1426 = getelementptr i64, ptr @"str.38", i64 0
  %v1427 = add i64 0, 3
  %v1428 = add i64 0, 0
  %v1429 = getelementptr i64, ptr %s1, i64 0
  %v1430 = ptrtoint ptr %v1426 to i64
  %st462 = getelementptr i64, ptr %v1429, i64 0
  store i64 %v1430, ptr %st462
  %st463 = getelementptr i64, ptr %v1429, i64 1
  store i64 %v1427, ptr %st463
  %st464 = getelementptr i64, ptr %v1429, i64 2
  store i64 %v1428, ptr %st464
  %v1431.p = getelementptr i64, ptr %v1429, i64 0
  %v1431 = load i64, ptr %v1431.p
  %v1432.p = getelementptr i64, ptr %v1429, i64 1
  %v1432 = load i64, ptr %v1432.p
  %v1433.p = getelementptr i64, ptr %v1429, i64 2
  %v1433 = load i64, ptr %v1433.p
  %v1434 = getelementptr i64, ptr @"str.31", i64 0
  %v1435 = add i64 0, 2
  %v1436 = add i64 0, 0
  %v1437 = getelementptr i64, ptr %s0, i64 0
  %v1438 = ptrtoint ptr %v1434 to i64
  %st465 = getelementptr i64, ptr %v1437, i64 0
  store i64 %v1438, ptr %st465
  %st466 = getelementptr i64, ptr %v1437, i64 1
  store i64 %v1435, ptr %st466
  %st467 = getelementptr i64, ptr %v1437, i64 2
  store i64 %v1436, ptr %st467
  %v1439.p = getelementptr i64, ptr %v1437, i64 0
  %v1439 = load i64, ptr %v1439.p
  %v1440.p = getelementptr i64, ptr %v1437, i64 1
  %v1440 = load i64, ptr %v1440.p
  %v1441.p = getelementptr i64, ptr %v1437, i64 2
  %v1441 = load i64, ptr %v1441.p
  call void @"main.showCutLast"(i64 %v1431, i64 %v1432, i64 %v1433, i64 %v1439, i64 %v1440, i64 %v1441)
  %v1443 = getelementptr i64, ptr @"rt.meta", i64 0
  %st468 = getelementptr i64, ptr %v1443, i64 0
  store i64 %v0, ptr %st468
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

define internal i64 @"std/strings.HasPrefix"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v29, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %st6 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st6
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %st7 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st7
  %v12.p = getelementptr i64, ptr %v6, i64 2
  %v12 = load i64, ptr %v12.p
  %st8 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st8
  %v13 = getelementptr i64, ptr %s3, i64 0
  %v14.p = getelementptr i64, ptr %v7, i64 0
  %v14 = load i64, ptr %v14.p
  %st9 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st9
  %v15.p = getelementptr i64, ptr %v7, i64 1
  %v15 = load i64, ptr %v15.p
  %st10 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st10
  %v16.p = getelementptr i64, ptr %v7, i64 2
  %v16 = load i64, ptr %v16.p
  %st11 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st11
  %v17.p = getelementptr i64, ptr %v9, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v13, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp sge i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b0 = icmp ne i64 %v19, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v21.p = getelementptr i64, ptr %v9, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v9, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v9, i64 2
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25.p = getelementptr i64, ptr %v13, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v13, i64 1
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v13, i64 2
  %v27 = load i64, ptr %v27.p
  %v28 = call i64 @"std/strings.hasPrefixAt"(i64 %v21, i64 %v22, i64 %v23, i64 %v24, i64 %v25, i64 %v26, i64 %v27)
  br label %b2
b2:
  %v20 = phi i64 [ %v19, %b0.e14 ], [ %v28, %b1 ]
  %v30 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v30, i64 0
  store i64 %v8, ptr %st14
  ret i64 %v20
}

define internal i64 @"std/strings.HasSuffix"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v31, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %st6 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st6
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %st7 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st7
  %v12.p = getelementptr i64, ptr %v6, i64 2
  %v12 = load i64, ptr %v12.p
  %st8 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st8
  %v13 = getelementptr i64, ptr %s3, i64 0
  %v14.p = getelementptr i64, ptr %v7, i64 0
  %v14 = load i64, ptr %v14.p
  %st9 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st9
  %v15.p = getelementptr i64, ptr %v7, i64 1
  %v15 = load i64, ptr %v15.p
  %st10 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st10
  %v16.p = getelementptr i64, ptr %v7, i64 2
  %v16 = load i64, ptr %v16.p
  %st11 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st11
  %v17.p = getelementptr i64, ptr %v9, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v13, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp sge i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b0 = icmp ne i64 %v19, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v21.p = getelementptr i64, ptr %v9, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v9, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v9, i64 2
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v9, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v13, i64 1
  %v25 = load i64, ptr %v25.p
  %v26 = sub i64 %v24, %v25
  %v27.p = getelementptr i64, ptr %v13, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v13, i64 1
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v13, i64 2
  %v29 = load i64, ptr %v29.p
  %v30 = call i64 @"std/strings.hasPrefixAt"(i64 %v21, i64 %v22, i64 %v23, i64 %v26, i64 %v27, i64 %v28, i64 %v29)
  br label %b2
b2:
  %v20 = phi i64 [ %v19, %b0.e14 ], [ %v30, %b1 ]
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v32, i64 0
  store i64 %v8, ptr %st14
  ret i64 %v20
}

define internal i64 @"std/strings.Index"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v17, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9.p = getelementptr i64, ptr %v6, i64 0
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v6, i64 1
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v6, i64 2
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.p = getelementptr i64, ptr %v7, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v7, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v7, i64 2
  %v15 = load i64, ptr %v15.p
  %v16 = call i64 @"std/strings.indexAt"(i64 %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14, i64 %v15)
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v18, i64 0
  store i64 %v8, ptr %st6
  ret i64 %v16
}

define internal i64 @"std/strings.Contains"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v18, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9.p = getelementptr i64, ptr %v6, i64 0
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v6, i64 1
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v6, i64 2
  %v11 = load i64, ptr %v11.p
  %v12.p = getelementptr i64, ptr %v7, i64 0
  %v12 = load i64, ptr %v12.p
  %v13.p = getelementptr i64, ptr %v7, i64 1
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v7, i64 2
  %v14 = load i64, ptr %v14.p
  %v15 = call i64 @"std/strings.Index"(i64 %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14)
  %v16 = add i64 0, 0
  %v17.c = icmp sge i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %v19 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v19, i64 0
  store i64 %v8, ptr %st6
  ret i64 %v17
}

define internal i64 @"std/strings.Count"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v34, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %st6 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st6
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %st7 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st7
  %v12.p = getelementptr i64, ptr %v6, i64 2
  %v12 = load i64, ptr %v12.p
  %st8 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st8
  %v13 = getelementptr i64, ptr %s3, i64 0
  %v14.p = getelementptr i64, ptr %v7, i64 0
  %v14 = load i64, ptr %v14.p
  %st9 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st9
  %v15.p = getelementptr i64, ptr %v7, i64 1
  %v15 = load i64, ptr %v15.p
  %st10 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st10
  %v16.p = getelementptr i64, ptr %v7, i64 2
  %v16 = load i64, ptr %v16.p
  %st11 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st11
  %v17.p = getelementptr i64, ptr %v13, i64 1
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 0
  %v19.c = icmp eq i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b0 = icmp ne i64 %v19, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v20.p = getelementptr i64, ptr %v9, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v9, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v9, i64 2
  %v22 = load i64, ptr %v22.p
  %v23 = call i64 @"std/strings.runeCount"(i64 %v20, i64 %v21, i64 %v22)
  %v24 = add i64 0, 1
  %v25 = add i64 %v23, %v24
  br label %b3
b2:
  %v26.p = getelementptr i64, ptr %v9, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v9, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v9, i64 2
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v13, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v13, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v13, i64 2
  %v31 = load i64, ptr %v31.p
  %v32 = call i64 @"std/strings.countFrom"(i64 %v26, i64 %v27, i64 %v28, i64 %v29, i64 %v30, i64 %v31)
  br label %b3
b3:
  %v33 = phi i64 [ %v25, %b1 ], [ %v32, %b2 ]
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v35, i64 0
  store i64 %v8, ptr %st14
  ret i64 %v33
}

define internal i64 @"std/strings.IndexByte"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v2, ptr %st2
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v41, i64 0
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
  %v10 = add i64 0, 0
  %v11 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st6
  %v12 = add i64 0, 1
  %v13 = add i64 0, 0
  %v14 = sub i64 %v13, %v12
  %v15 = getelementptr i64, ptr %s3, i64 0
  %st7 = getelementptr i64, ptr %v15, i64 0
  store i64 %v14, ptr %st7
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v42, i64 0
  %v16 = load i64, ptr %v16.p
  br label %b1
b1:
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v43, i64 0
  store i64 %v16, ptr %st8
  %v17.p = getelementptr i64, ptr %v15, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 0
  %v19.c = icmp slt i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b1 = icmp ne i64 %v19, 0
  br i1 %c.b1, label %b1.t10, label %b1.e11
b1.t10:
  br label %b4
b1.e11:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v44, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v11, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v6, i64 1
  %v26 = load i64, ptr %v26.p
  %v27.c = icmp uge i64 %v25, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b2 = icmp ne i64 %v27, 0
  br i1 %c.b2, label %b2.t12, label %b2.e13
b2.t12:
  br label %b6
b2.e13:
  br label %b7
b3:
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v45, i64 0
  store i64 %v16, ptr %st13
  %v40.p = getelementptr i64, ptr %v15, i64 0
  %v40 = load i64, ptr %v40.p
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v46, i64 0
  store i64 %v5, ptr %st14
  ret i64 %v40
b4:
  %v21.p = getelementptr i64, ptr %v11, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v6, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp slt i64 %v21, %v22
  %v23 = zext i1 %v23.c to i64
  br label %b5
b5:
  %v20 = phi i64 [ %v19, %b1.e11 ], [ %v23, %b4 ]
  %c.b5 = icmp ne i64 %v20, 0
  br i1 %c.b5, label %b5.t16, label %b5.e17
b5.t16:
  br label %b2
b5.e17:
  br label %b3
b6:
  %v28 = add i64 0, 17
  call void @"rt.panic"(i64 %v28)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v29.p = getelementptr i64, ptr %v6, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = inttoptr i64 %v29 to ptr
  %v31 = getelementptr i8, ptr %v30, i64 %v25
  %v32.p = getelementptr i8, ptr %v31, i64 0
  %v32.b = load i8, ptr %v32.p
  %v32 = zext i8 %v32.b to i64
  %v33.c = icmp eq i64 %v32, %v3
  %v33 = zext i1 %v33.c to i64
  %c.b7 = icmp ne i64 %v33, 0
  br i1 %c.b7, label %b7.t18, label %b7.e19
b7.t18:
  br label %b8
b7.e19:
  br label %b9
b8:
  %v34 = add i64 0, 1
  %v35 = add i64 %v5, %v34
  %v36.p = getelementptr i64, ptr %v11, i64 0
  %v36 = load i64, ptr %v36.p
  %st19 = getelementptr i64, ptr %v15, i64 0
  store i64 %v36, ptr %st19
  br label %b10
b9:
  br label %b10
b10:
  %v37 = add i64 0, 1
  %v38.p = getelementptr i64, ptr %v11, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 %v38, %v37
  %st20 = getelementptr i64, ptr %v11, i64 0
  store i64 %v39, ptr %st20
  br label %b1
}

define internal void @"std/strings.TrimPrefix"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v51 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v51, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v7, i64 0
  %v11 = load i64, ptr %v11.p
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st6
  %v12.p = getelementptr i64, ptr %v7, i64 1
  %v12 = load i64, ptr %v12.p
  %st7 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st7
  %v13.p = getelementptr i64, ptr %v7, i64 2
  %v13 = load i64, ptr %v13.p
  %st8 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st8
  %v14 = getelementptr i64, ptr %s3, i64 0
  %v15.p = getelementptr i64, ptr %v8, i64 0
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v8, i64 1
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st10
  %v17.p = getelementptr i64, ptr %v8, i64 2
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st11
  %v18.p = getelementptr i64, ptr %v10, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v14, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.c = icmp sge i64 %v18, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b0 = icmp ne i64 %v20, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v22.p = getelementptr i64, ptr %v10, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v10, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v10, i64 2
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 0, 0
  %v26.p = getelementptr i64, ptr %v14, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v14, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v14, i64 2
  %v28 = load i64, ptr %v28.p
  %v29 = call i64 @"std/strings.hasPrefixAt"(i64 %v22, i64 %v23, i64 %v24, i64 %v25, i64 %v26, i64 %v27, i64 %v28)
  br label %b2
b2:
  %v21 = phi i64 [ %v20, %b0.e14 ], [ %v29, %b1 ]
  %c.b2 = icmp ne i64 %v21, 0
  br i1 %c.b2, label %b2.t15, label %b2.e16
b2.t15:
  br label %b3
b2.e16:
  br label %b4
b3:
  %v30.p = getelementptr i64, ptr %v14, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v10, i64 1
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 0, 0
  %v33.c = icmp slt i64 %v30, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b3 = icmp ne i64 %v33, 0
  br i1 %c.b3, label %b3.t17, label %b3.e18
b3.t17:
  br label %b5
b3.e18:
  br label %b6
b4:
  br label %b11
b5:
  %v34 = add i64 0, 14
  call void @"rt.panic"(i64 %v34)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v35.c = icmp slt i64 %v31, %v30
  %v35 = zext i1 %v35.c to i64
  %c.b6 = icmp ne i64 %v35, 0
  br i1 %c.b6, label %b6.t19, label %b6.e20
b6.t19:
  br label %b7
b6.e20:
  br label %b8
b7:
  %v36 = add i64 0, 15
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v37.p = getelementptr i64, ptr %v10, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp sgt i64 %v31, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b8 = icmp ne i64 %v38, 0
  br i1 %c.b8, label %b8.t21, label %b8.e22
b8.t21:
  br label %b9
b8.e22:
  br label %b10
b9:
  %v39 = add i64 0, 16
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v40.p = getelementptr i64, ptr %v10, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = getelementptr i8, ptr %v41, i64 %v30
  %v43 = sub i64 %v31, %v30
  %v44.p = getelementptr i64, ptr %v10, i64 2
  %v44 = load i64, ptr %v44.p
  %v45 = getelementptr i64, ptr %s4, i64 0
  %v46 = ptrtoint ptr %v42 to i64
  %st22 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st22
  %st23 = getelementptr i64, ptr %v45, i64 1
  store i64 %v43, ptr %st23
  %st24 = getelementptr i64, ptr %v45, i64 2
  store i64 %v44, ptr %st24
  br label %b11
b11:
  %v47 = phi ptr [ %v7, %b4 ], [ %v45, %b10 ]
  %v48.p = getelementptr i64, ptr %v47, i64 0
  %v48 = load i64, ptr %v48.p
  %st25 = getelementptr i64, ptr %v0, i64 0
  store i64 %v48, ptr %st25
  %v49.p = getelementptr i64, ptr %v47, i64 1
  %v49 = load i64, ptr %v49.p
  %st26 = getelementptr i64, ptr %v0, i64 1
  store i64 %v49, ptr %st26
  %v50.p = getelementptr i64, ptr %v47, i64 2
  %v50 = load i64, ptr %v50.p
  %st27 = getelementptr i64, ptr %v0, i64 2
  store i64 %v50, ptr %st27
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v52 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v52, i64 0
  store i64 %v9, ptr %st28
  ret void
}

define internal void @"main.showCut"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %s2 = alloca [7 x i64], align 8
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
  %s2.z6 = getelementptr i64, ptr %s2, i64 6
  store i64 0, ptr %s2.z6
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v39 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v39, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.p = getelementptr i64, ptr %v6, i64 2
  %v12 = load i64, ptr %v12.p
  %v13.p = getelementptr i64, ptr %v7, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v7, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v7, i64 2
  %v15 = load i64, ptr %v15.p
  call void @"std/strings.Cut"(ptr %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14, i64 %v15)
  %v16 = add i64 0, 3
  %v17 = getelementptr i64, ptr %v9, i64 %v16
  %v18.p = getelementptr i64, ptr %v9, i64 6
  %v18 = load i64, ptr %v18.p
  %v19 = getelementptr i64, ptr %s3, i64 0
  %v20.p = getelementptr i64, ptr %v9, i64 0
  %v20 = load i64, ptr %v20.p
  %st6 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st6
  %v21.p = getelementptr i64, ptr %v9, i64 1
  %v21 = load i64, ptr %v21.p
  %st7 = getelementptr i64, ptr %v19, i64 1
  store i64 %v21, ptr %st7
  %v22.p = getelementptr i64, ptr %v9, i64 2
  %v22 = load i64, ptr %v22.p
  %st8 = getelementptr i64, ptr %v19, i64 2
  store i64 %v22, ptr %st8
  %v23 = getelementptr i64, ptr %s4, i64 0
  %v24.p = getelementptr i64, ptr %v17, i64 0
  %v24 = load i64, ptr %v24.p
  %st9 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st9
  %v25.p = getelementptr i64, ptr %v17, i64 1
  %v25 = load i64, ptr %v25.p
  %st10 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st10
  %v26.p = getelementptr i64, ptr %v17, i64 2
  %v26 = load i64, ptr %v26.p
  %st11 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st11
  call void @"rt.print_str"(ptr %v19)
  %v27 = add i64 0, 32
  call void @"rt.print_char"(i64 %v27)
  call void @"rt.print_str"(ptr %v23)
  %v28 = add i64 0, 32
  call void @"rt.print_char"(i64 %v28)
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v29 = add i64 0, 116
  call void @"rt.print_char"(i64 %v29)
  %v30 = add i64 0, 114
  call void @"rt.print_char"(i64 %v30)
  %v31 = add i64 0, 117
  call void @"rt.print_char"(i64 %v31)
  %v32 = add i64 0, 101
  call void @"rt.print_char"(i64 %v32)
  br label %b3
b2:
  %v33 = add i64 0, 102
  call void @"rt.print_char"(i64 %v33)
  %v34 = add i64 0, 97
  call void @"rt.print_char"(i64 %v34)
  %v35 = add i64 0, 108
  call void @"rt.print_char"(i64 %v35)
  %v36 = add i64 0, 115
  call void @"rt.print_char"(i64 %v36)
  %v37 = add i64 0, 101
  call void @"rt.print_char"(i64 %v37)
  br label %b3
b3:
  %v38 = add i64 0, 10
  call void @"rt.print_char"(i64 %v38)
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v40, i64 0
  store i64 %v8, ptr %st14
  ret void
}

define internal void @"main.showCutLast"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %s2 = alloca [7 x i64], align 8
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
  %s2.z6 = getelementptr i64, ptr %s2, i64 6
  store i64 0, ptr %s2.z6
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v39 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v39, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.p = getelementptr i64, ptr %v6, i64 2
  %v12 = load i64, ptr %v12.p
  %v13.p = getelementptr i64, ptr %v7, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v7, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v7, i64 2
  %v15 = load i64, ptr %v15.p
  call void @"std/strings.CutLast"(ptr %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14, i64 %v15)
  %v16 = add i64 0, 3
  %v17 = getelementptr i64, ptr %v9, i64 %v16
  %v18.p = getelementptr i64, ptr %v9, i64 6
  %v18 = load i64, ptr %v18.p
  %v19 = getelementptr i64, ptr %s3, i64 0
  %v20.p = getelementptr i64, ptr %v9, i64 0
  %v20 = load i64, ptr %v20.p
  %st6 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st6
  %v21.p = getelementptr i64, ptr %v9, i64 1
  %v21 = load i64, ptr %v21.p
  %st7 = getelementptr i64, ptr %v19, i64 1
  store i64 %v21, ptr %st7
  %v22.p = getelementptr i64, ptr %v9, i64 2
  %v22 = load i64, ptr %v22.p
  %st8 = getelementptr i64, ptr %v19, i64 2
  store i64 %v22, ptr %st8
  %v23 = getelementptr i64, ptr %s4, i64 0
  %v24.p = getelementptr i64, ptr %v17, i64 0
  %v24 = load i64, ptr %v24.p
  %st9 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st9
  %v25.p = getelementptr i64, ptr %v17, i64 1
  %v25 = load i64, ptr %v25.p
  %st10 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st10
  %v26.p = getelementptr i64, ptr %v17, i64 2
  %v26 = load i64, ptr %v26.p
  %st11 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st11
  call void @"rt.print_str"(ptr %v19)
  %v27 = add i64 0, 32
  call void @"rt.print_char"(i64 %v27)
  call void @"rt.print_str"(ptr %v23)
  %v28 = add i64 0, 32
  call void @"rt.print_char"(i64 %v28)
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v29 = add i64 0, 116
  call void @"rt.print_char"(i64 %v29)
  %v30 = add i64 0, 114
  call void @"rt.print_char"(i64 %v30)
  %v31 = add i64 0, 117
  call void @"rt.print_char"(i64 %v31)
  %v32 = add i64 0, 101
  call void @"rt.print_char"(i64 %v32)
  br label %b3
b2:
  %v33 = add i64 0, 102
  call void @"rt.print_char"(i64 %v33)
  %v34 = add i64 0, 97
  call void @"rt.print_char"(i64 %v34)
  %v35 = add i64 0, 108
  call void @"rt.print_char"(i64 %v35)
  %v36 = add i64 0, 115
  call void @"rt.print_char"(i64 %v36)
  %v37 = add i64 0, 101
  call void @"rt.print_char"(i64 %v37)
  br label %b3
b3:
  %v38 = add i64 0, 10
  call void @"rt.print_char"(i64 %v38)
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v40, i64 0
  store i64 %v8, ptr %st14
  ret void
}

define internal void @"std/strings.CutLast"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v84, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v7, i64 0
  %v11 = load i64, ptr %v11.p
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st6
  %v12.p = getelementptr i64, ptr %v7, i64 1
  %v12 = load i64, ptr %v12.p
  %st7 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st7
  %v13.p = getelementptr i64, ptr %v7, i64 2
  %v13 = load i64, ptr %v13.p
  %st8 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st8
  %v14 = getelementptr i64, ptr %s3, i64 0
  %v15.p = getelementptr i64, ptr %v8, i64 0
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v8, i64 1
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st10
  %v17.p = getelementptr i64, ptr %v8, i64 2
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st11
  %v18.p = getelementptr i64, ptr %v10, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v10, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v10, i64 2
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v14, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v14, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v14, i64 2
  %v23 = load i64, ptr %v23.p
  %v24 = call i64 @"std/strings.lastIndexAt"(i64 %v18, i64 %v19, i64 %v20, i64 %v21, i64 %v22, i64 %v23)
  %v25 = add i64 0, 0
  %v26.c = icmp slt i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b0 = icmp ne i64 %v26, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v27 = getelementptr i64, ptr @"str.4", i64 0
  %v28 = add i64 0, 0
  %v29 = add i64 0, 0
  %v30 = getelementptr i64, ptr %s4, i64 0
  %v31 = ptrtoint ptr %v27 to i64
  %st14 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st14
  %st15 = getelementptr i64, ptr %v30, i64 1
  store i64 %v28, ptr %st15
  %st16 = getelementptr i64, ptr %v30, i64 2
  store i64 %v29, ptr %st16
  %v32 = add i64 0, 0
  %v33.p = getelementptr i64, ptr %v7, i64 0
  %v33 = load i64, ptr %v33.p
  %st17 = getelementptr i64, ptr %v0, i64 0
  store i64 %v33, ptr %st17
  %v34.p = getelementptr i64, ptr %v7, i64 1
  %v34 = load i64, ptr %v34.p
  %st18 = getelementptr i64, ptr %v0, i64 1
  store i64 %v34, ptr %st18
  %v35.p = getelementptr i64, ptr %v7, i64 2
  %v35 = load i64, ptr %v35.p
  %st19 = getelementptr i64, ptr %v0, i64 2
  store i64 %v35, ptr %st19
  %v36.p = getelementptr i64, ptr %v30, i64 0
  %v36 = load i64, ptr %v36.p
  %st20 = getelementptr i64, ptr %v0, i64 3
  store i64 %v36, ptr %st20
  %v37.p = getelementptr i64, ptr %v30, i64 1
  %v37 = load i64, ptr %v37.p
  %st21 = getelementptr i64, ptr %v0, i64 4
  store i64 %v37, ptr %st21
  %v38.p = getelementptr i64, ptr %v30, i64 2
  %v38 = load i64, ptr %v38.p
  %st22 = getelementptr i64, ptr %v0, i64 5
  store i64 %v38, ptr %st22
  %st23 = getelementptr i64, ptr %v0, i64 6
  store i64 %v32, ptr %st23
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v39 = add i64 0, 3
  %v40 = getelementptr i64, ptr %v0, i64 %v39
  call void @"rt.region_relocate8"(ptr %v40, i64 %v9)
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v85, i64 0
  store i64 %v9, ptr %st24
  ret void
b2:
  br label %b3
b3:
  %v41 = add i64 0, 0
  %v42 = add i64 0, 0
  %v43.c = icmp slt i64 %v41, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b3 = icmp ne i64 %v43, 0
  br i1 %c.b3, label %b3.t26, label %b3.e27
b3.t26:
  br label %b4
b3.e27:
  br label %b5
b4:
  %v44 = add i64 0, 0
  call void @"rt.panic"(i64 %v44)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v45.c = icmp slt i64 %v24, %v41
  %v45 = zext i1 %v45.c to i64
  %c.b5 = icmp ne i64 %v45, 0
  br i1 %c.b5, label %b5.t28, label %b5.e29
b5.t28:
  br label %b6
b5.e29:
  br label %b7
b6:
  %v46 = add i64 0, 1
  call void @"rt.panic"(i64 %v46)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v47.p = getelementptr i64, ptr %v10, i64 1
  %v47 = load i64, ptr %v47.p
  %v48.c = icmp sgt i64 %v24, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b7 = icmp ne i64 %v48, 0
  br i1 %c.b7, label %b7.t30, label %b7.e31
b7.t30:
  br label %b8
b7.e31:
  br label %b9
b8:
  %v49 = add i64 0, 2
  call void @"rt.panic"(i64 %v49)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v50.p = getelementptr i64, ptr %v10, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = inttoptr i64 %v50 to ptr
  %v52 = getelementptr i8, ptr %v51, i64 %v41
  %v53 = sub i64 %v24, %v41
  %v54.p = getelementptr i64, ptr %v10, i64 2
  %v54 = load i64, ptr %v54.p
  %v55 = getelementptr i64, ptr %s4, i64 0
  %v56 = ptrtoint ptr %v52 to i64
  %st31 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st31
  %st32 = getelementptr i64, ptr %v55, i64 1
  store i64 %v53, ptr %st32
  %st33 = getelementptr i64, ptr %v55, i64 2
  store i64 %v54, ptr %st33
  %v57.p = getelementptr i64, ptr %v14, i64 1
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 %v24, %v57
  %v59.p = getelementptr i64, ptr %v10, i64 1
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 0
  %v61.c = icmp slt i64 %v58, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b9 = icmp ne i64 %v61, 0
  br i1 %c.b9, label %b9.t35, label %b9.e36
b9.t35:
  br label %b10
b9.e36:
  br label %b11
b10:
  %v62 = add i64 0, 3
  call void @"rt.panic"(i64 %v62)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v63.c = icmp slt i64 %v59, %v58
  %v63 = zext i1 %v63.c to i64
  %c.b11 = icmp ne i64 %v63, 0
  br i1 %c.b11, label %b11.t37, label %b11.e38
b11.t37:
  br label %b12
b11.e38:
  br label %b13
b12:
  %v64 = add i64 0, 4
  call void @"rt.panic"(i64 %v64)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v65.p = getelementptr i64, ptr %v10, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.c = icmp sgt i64 %v59, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b13 = icmp ne i64 %v66, 0
  br i1 %c.b13, label %b13.t39, label %b13.e40
b13.t39:
  br label %b14
b13.e40:
  br label %b15
b14:
  %v67 = add i64 0, 5
  call void @"rt.panic"(i64 %v67)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v68.p = getelementptr i64, ptr %v10, i64 0
  %v68 = load i64, ptr %v68.p
  %v69 = inttoptr i64 %v68 to ptr
  %v70 = getelementptr i8, ptr %v69, i64 %v58
  %v71 = sub i64 %v59, %v58
  %v72.p = getelementptr i64, ptr %v10, i64 2
  %v72 = load i64, ptr %v72.p
  %v73 = getelementptr i64, ptr %s5, i64 0
  %v74 = ptrtoint ptr %v70 to i64
  %st40 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st40
  %st41 = getelementptr i64, ptr %v73, i64 1
  store i64 %v71, ptr %st41
  %st42 = getelementptr i64, ptr %v73, i64 2
  store i64 %v72, ptr %st42
  %v75 = add i64 0, 1
  %v76.p = getelementptr i64, ptr %v55, i64 0
  %v76 = load i64, ptr %v76.p
  %st43 = getelementptr i64, ptr %v0, i64 0
  store i64 %v76, ptr %st43
  %v77.p = getelementptr i64, ptr %v55, i64 1
  %v77 = load i64, ptr %v77.p
  %st44 = getelementptr i64, ptr %v0, i64 1
  store i64 %v77, ptr %st44
  %v78.p = getelementptr i64, ptr %v55, i64 2
  %v78 = load i64, ptr %v78.p
  %st45 = getelementptr i64, ptr %v0, i64 2
  store i64 %v78, ptr %st45
  %v79.p = getelementptr i64, ptr %v73, i64 0
  %v79 = load i64, ptr %v79.p
  %st46 = getelementptr i64, ptr %v0, i64 3
  store i64 %v79, ptr %st46
  %v80.p = getelementptr i64, ptr %v73, i64 1
  %v80 = load i64, ptr %v80.p
  %st47 = getelementptr i64, ptr %v0, i64 4
  store i64 %v80, ptr %st47
  %v81.p = getelementptr i64, ptr %v73, i64 2
  %v81 = load i64, ptr %v81.p
  %st48 = getelementptr i64, ptr %v0, i64 5
  store i64 %v81, ptr %st48
  %st49 = getelementptr i64, ptr %v0, i64 6
  store i64 %v75, ptr %st49
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v82 = add i64 0, 3
  %v83 = getelementptr i64, ptr %v0, i64 %v82
  call void @"rt.region_relocate8"(ptr %v83, i64 %v9)
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v86, i64 0
  store i64 %v9, ptr %st50
  ret void
}

define internal i64 @"std/strings.lastIndexAt"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v33 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v33, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9.p = getelementptr i64, ptr %v6, i64 1
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v7, i64 1
  %v10 = load i64, ptr %v10.p
  %v11 = sub i64 %v9, %v10
  %v12 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v12, i64 0
  store i64 %v11, ptr %st6
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v34, i64 0
  %v13 = load i64, ptr %v13.p
  br label %b1
b1:
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v35, i64 0
  store i64 %v13, ptr %st7
  %v14.p = getelementptr i64, ptr %v12, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 0, 0
  %v16.c = icmp sge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b1 = icmp ne i64 %v16, 0
  br i1 %c.b1, label %b1.t9, label %b1.e10
b1.t9:
  br label %b4
b1.e10:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v36, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 1
  %v30.p = getelementptr i64, ptr %v12, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = sub i64 %v30, %v29
  %st10 = getelementptr i64, ptr %v12, i64 0
  store i64 %v31, ptr %st10
  br label %b1
b3:
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v37, i64 0
  store i64 %v13, ptr %st11
  %v32.p = getelementptr i64, ptr %v12, i64 0
  %v32 = load i64, ptr %v32.p
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v38, i64 0
  store i64 %v8, ptr %st12
  ret i64 %v32
b4:
  %v18.p = getelementptr i64, ptr %v6, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v6, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v6, i64 2
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v12, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v7, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v7, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v7, i64 2
  %v24 = load i64, ptr %v24.p
  %v25 = call i64 @"std/strings.hasPrefixAt"(i64 %v18, i64 %v19, i64 %v20, i64 %v21, i64 %v22, i64 %v23, i64 %v24)
  %v26 = add i64 0, 1
  %v27 = xor i64 %v25, %v26
  br label %b5
b5:
  %v17 = phi i64 [ %v16, %b1.e10 ], [ %v27, %b4 ]
  %c.b5 = icmp ne i64 %v17, 0
  br i1 %c.b5, label %b5.t14, label %b5.e15
b5.t14:
  br label %b2
b5.e15:
  br label %b3
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
  %v20 = getelementptr i64, ptr @"str.67", i64 0
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
  %v74 = getelementptr i64, ptr @"str.75", i64 0
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
  %v27 = getelementptr i64, ptr @"str.68", i64 0
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
  %v34 = getelementptr i64, ptr @"str.69", i64 0
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
  %v41 = getelementptr i64, ptr @"str.70", i64 0
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
  %v48 = getelementptr i64, ptr @"str.71", i64 0
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
  %v55 = getelementptr i64, ptr @"str.72", i64 0
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
  %v62 = getelementptr i64, ptr @"str.73", i64 0
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
  %v69 = getelementptr i64, ptr @"str.74", i64 0
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
  %v81 = getelementptr i64, ptr @"str.76", i64 0
  %v82 = add i64 0, 25
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

define internal i64 @"std/strings.hasPrefixAt"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v2, ptr %st2
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v6, ptr %st5
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v42, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = add i64 0, 0
  %v11 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st6
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v43, i64 0
  %v12 = load i64, ptr %v12.p
  br label %b1
b1:
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v44, i64 0
  store i64 %v12, ptr %st7
  %v13.p = getelementptr i64, ptr %v11, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v8, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.c = icmp slt i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b1 = icmp ne i64 %v15, 0
  br i1 %c.b1, label %b1.t9, label %b1.e10
b1.t9:
  br label %b4
b1.e10:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %v35.p = getelementptr i64, ptr %v45, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 1
  %v37.p = getelementptr i64, ptr %v11, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 %v37, %v36
  %st10 = getelementptr i64, ptr %v11, i64 0
  store i64 %v38, ptr %st10
  br label %b1
b3:
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v46, i64 0
  store i64 %v12, ptr %st11
  %v39.p = getelementptr i64, ptr %v11, i64 0
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v8, i64 1
  %v40 = load i64, ptr %v40.p
  %v41.c = icmp eq i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  %v47 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v47, i64 0
  store i64 %v9, ptr %st12
  ret i64 %v41
b4:
  %v17.p = getelementptr i64, ptr %v11, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 %v3, %v17
  %v19.p = getelementptr i64, ptr %v7, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.c = icmp uge i64 %v18, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b4 = icmp ne i64 %v20, 0
  br i1 %c.b4, label %b4.t14, label %b4.e15
b4.t14:
  br label %b6
b4.e15:
  br label %b7
b5:
  %v16 = phi i64 [ %v15, %b1.e10 ], [ %v34, %b9 ]
  %c.b5 = icmp ne i64 %v16, 0
  br i1 %c.b5, label %b5.t16, label %b5.e17
b5.t16:
  br label %b2
b5.e17:
  br label %b3
b6:
  %v21 = add i64 0, 6
  call void @"rt.panic"(i64 %v21)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v22.p = getelementptr i64, ptr %v7, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = inttoptr i64 %v22 to ptr
  %v24 = getelementptr i8, ptr %v23, i64 %v18
  %v25.p = getelementptr i8, ptr %v24, i64 0
  %v25.b = load i8, ptr %v25.p
  %v25 = zext i8 %v25.b to i64
  %v26.p = getelementptr i64, ptr %v11, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v8, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b7 = icmp ne i64 %v28, 0
  br i1 %c.b7, label %b7.t18, label %b7.e19
b7.t18:
  br label %b8
b7.e19:
  br label %b9
b8:
  %v29 = add i64 0, 7
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v30.p = getelementptr i64, ptr %v8, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = getelementptr i8, ptr %v31, i64 %v26
  %v33.p = getelementptr i8, ptr %v32, i64 0
  %v33.b = load i8, ptr %v33.p
  %v33 = zext i8 %v33.b to i64
  %v34.c = icmp eq i64 %v25, %v33
  %v34 = zext i1 %v34.c to i64
  br label %b5
}

define internal void @"std/strings.Cut"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v85, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v7, i64 0
  %v11 = load i64, ptr %v11.p
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st6
  %v12.p = getelementptr i64, ptr %v7, i64 1
  %v12 = load i64, ptr %v12.p
  %st7 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st7
  %v13.p = getelementptr i64, ptr %v7, i64 2
  %v13 = load i64, ptr %v13.p
  %st8 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st8
  %v14 = getelementptr i64, ptr %s3, i64 0
  %v15.p = getelementptr i64, ptr %v8, i64 0
  %v15 = load i64, ptr %v15.p
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st9
  %v16.p = getelementptr i64, ptr %v8, i64 1
  %v16 = load i64, ptr %v16.p
  %st10 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st10
  %v17.p = getelementptr i64, ptr %v8, i64 2
  %v17 = load i64, ptr %v17.p
  %st11 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st11
  %v18.p = getelementptr i64, ptr %v10, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v10, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v10, i64 2
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 0
  %v22.p = getelementptr i64, ptr %v14, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v14, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v14, i64 2
  %v24 = load i64, ptr %v24.p
  %v25 = call i64 @"std/strings.indexAt"(i64 %v18, i64 %v19, i64 %v20, i64 %v21, i64 %v22, i64 %v23, i64 %v24)
  %v26 = add i64 0, 0
  %v27.c = icmp slt i64 %v25, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b0 = icmp ne i64 %v27, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v28 = getelementptr i64, ptr @"str.4", i64 0
  %v29 = add i64 0, 0
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s4, i64 0
  %v32 = ptrtoint ptr %v28 to i64
  %st14 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st14
  %st15 = getelementptr i64, ptr %v31, i64 1
  store i64 %v29, ptr %st15
  %st16 = getelementptr i64, ptr %v31, i64 2
  store i64 %v30, ptr %st16
  %v33 = add i64 0, 0
  %v34.p = getelementptr i64, ptr %v7, i64 0
  %v34 = load i64, ptr %v34.p
  %st17 = getelementptr i64, ptr %v0, i64 0
  store i64 %v34, ptr %st17
  %v35.p = getelementptr i64, ptr %v7, i64 1
  %v35 = load i64, ptr %v35.p
  %st18 = getelementptr i64, ptr %v0, i64 1
  store i64 %v35, ptr %st18
  %v36.p = getelementptr i64, ptr %v7, i64 2
  %v36 = load i64, ptr %v36.p
  %st19 = getelementptr i64, ptr %v0, i64 2
  store i64 %v36, ptr %st19
  %v37.p = getelementptr i64, ptr %v31, i64 0
  %v37 = load i64, ptr %v37.p
  %st20 = getelementptr i64, ptr %v0, i64 3
  store i64 %v37, ptr %st20
  %v38.p = getelementptr i64, ptr %v31, i64 1
  %v38 = load i64, ptr %v38.p
  %st21 = getelementptr i64, ptr %v0, i64 4
  store i64 %v38, ptr %st21
  %v39.p = getelementptr i64, ptr %v31, i64 2
  %v39 = load i64, ptr %v39.p
  %st22 = getelementptr i64, ptr %v0, i64 5
  store i64 %v39, ptr %st22
  %st23 = getelementptr i64, ptr %v0, i64 6
  store i64 %v33, ptr %st23
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v40 = add i64 0, 3
  %v41 = getelementptr i64, ptr %v0, i64 %v40
  call void @"rt.region_relocate8"(ptr %v41, i64 %v9)
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v86, i64 0
  store i64 %v9, ptr %st24
  ret void
b2:
  br label %b3
b3:
  %v42 = add i64 0, 0
  %v43 = add i64 0, 0
  %v44.c = icmp slt i64 %v42, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b3 = icmp ne i64 %v44, 0
  br i1 %c.b3, label %b3.t26, label %b3.e27
b3.t26:
  br label %b4
b3.e27:
  br label %b5
b4:
  %v45 = add i64 0, 8
  call void @"rt.panic"(i64 %v45)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v46.c = icmp slt i64 %v25, %v42
  %v46 = zext i1 %v46.c to i64
  %c.b5 = icmp ne i64 %v46, 0
  br i1 %c.b5, label %b5.t28, label %b5.e29
b5.t28:
  br label %b6
b5.e29:
  br label %b7
b6:
  %v47 = add i64 0, 9
  call void @"rt.panic"(i64 %v47)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v48.p = getelementptr i64, ptr %v10, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp sgt i64 %v25, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b7 = icmp ne i64 %v49, 0
  br i1 %c.b7, label %b7.t30, label %b7.e31
b7.t30:
  br label %b8
b7.e31:
  br label %b9
b8:
  %v50 = add i64 0, 10
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v51.p = getelementptr i64, ptr %v10, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = getelementptr i8, ptr %v52, i64 %v42
  %v54 = sub i64 %v25, %v42
  %v55.p = getelementptr i64, ptr %v10, i64 2
  %v55 = load i64, ptr %v55.p
  %v56 = getelementptr i64, ptr %s4, i64 0
  %v57 = ptrtoint ptr %v53 to i64
  %st31 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st31
  %st32 = getelementptr i64, ptr %v56, i64 1
  store i64 %v54, ptr %st32
  %st33 = getelementptr i64, ptr %v56, i64 2
  store i64 %v55, ptr %st33
  %v58.p = getelementptr i64, ptr %v14, i64 1
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 %v25, %v58
  %v60.p = getelementptr i64, ptr %v10, i64 1
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 0
  %v62.c = icmp slt i64 %v59, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b9 = icmp ne i64 %v62, 0
  br i1 %c.b9, label %b9.t35, label %b9.e36
b9.t35:
  br label %b10
b9.e36:
  br label %b11
b10:
  %v63 = add i64 0, 11
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v64.c = icmp slt i64 %v60, %v59
  %v64 = zext i1 %v64.c to i64
  %c.b11 = icmp ne i64 %v64, 0
  br i1 %c.b11, label %b11.t37, label %b11.e38
b11.t37:
  br label %b12
b11.e38:
  br label %b13
b12:
  %v65 = add i64 0, 12
  call void @"rt.panic"(i64 %v65)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v66.p = getelementptr i64, ptr %v10, i64 1
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp sgt i64 %v60, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b13 = icmp ne i64 %v67, 0
  br i1 %c.b13, label %b13.t39, label %b13.e40
b13.t39:
  br label %b14
b13.e40:
  br label %b15
b14:
  %v68 = add i64 0, 13
  call void @"rt.panic"(i64 %v68)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v69.p = getelementptr i64, ptr %v10, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = inttoptr i64 %v69 to ptr
  %v71 = getelementptr i8, ptr %v70, i64 %v59
  %v72 = sub i64 %v60, %v59
  %v73.p = getelementptr i64, ptr %v10, i64 2
  %v73 = load i64, ptr %v73.p
  %v74 = getelementptr i64, ptr %s5, i64 0
  %v75 = ptrtoint ptr %v71 to i64
  %st40 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st40
  %st41 = getelementptr i64, ptr %v74, i64 1
  store i64 %v72, ptr %st41
  %st42 = getelementptr i64, ptr %v74, i64 2
  store i64 %v73, ptr %st42
  %v76 = add i64 0, 1
  %v77.p = getelementptr i64, ptr %v56, i64 0
  %v77 = load i64, ptr %v77.p
  %st43 = getelementptr i64, ptr %v0, i64 0
  store i64 %v77, ptr %st43
  %v78.p = getelementptr i64, ptr %v56, i64 1
  %v78 = load i64, ptr %v78.p
  %st44 = getelementptr i64, ptr %v0, i64 1
  store i64 %v78, ptr %st44
  %v79.p = getelementptr i64, ptr %v56, i64 2
  %v79 = load i64, ptr %v79.p
  %st45 = getelementptr i64, ptr %v0, i64 2
  store i64 %v79, ptr %st45
  %v80.p = getelementptr i64, ptr %v74, i64 0
  %v80 = load i64, ptr %v80.p
  %st46 = getelementptr i64, ptr %v0, i64 3
  store i64 %v80, ptr %st46
  %v81.p = getelementptr i64, ptr %v74, i64 1
  %v81 = load i64, ptr %v81.p
  %st47 = getelementptr i64, ptr %v0, i64 4
  store i64 %v81, ptr %st47
  %v82.p = getelementptr i64, ptr %v74, i64 2
  %v82 = load i64, ptr %v82.p
  %st48 = getelementptr i64, ptr %v0, i64 5
  store i64 %v82, ptr %st48
  %st49 = getelementptr i64, ptr %v0, i64 6
  store i64 %v76, ptr %st49
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v83 = add i64 0, 3
  %v84 = getelementptr i64, ptr %v0, i64 %v83
  call void @"rt.region_relocate8"(ptr %v84, i64 %v9)
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v87, i64 0
  store i64 %v9, ptr %st50
  ret void
}

define internal i64 @"std/strings.indexAt"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v2, ptr %st2
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v6, ptr %st5
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v41, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v3, ptr %st6
  %v11 = add i64 0, 1
  %v12 = add i64 0, 0
  %v13 = sub i64 %v12, %v11
  %v14 = getelementptr i64, ptr %s3, i64 0
  %st7 = getelementptr i64, ptr %v14, i64 0
  store i64 %v13, ptr %st7
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v42, i64 0
  %v15 = load i64, ptr %v15.p
  br label %b1
b1:
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v43, i64 0
  store i64 %v15, ptr %st8
  %v16.p = getelementptr i64, ptr %v14, i64 0
  %v16 = load i64, ptr %v16.p
  %v17 = add i64 0, 0
  %v18.c = icmp slt i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b1 = icmp ne i64 %v18, 0
  br i1 %c.b1, label %b1.t10, label %b1.e11
b1.t10:
  br label %b4
b1.e11:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %v25.p = getelementptr i64, ptr %v44, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v7, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v7, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v7, i64 2
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v10, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v8, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v8, i64 1
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v8, i64 2
  %v32 = load i64, ptr %v32.p
  %v33 = call i64 @"std/strings.hasPrefixAt"(i64 %v26, i64 %v27, i64 %v28, i64 %v29, i64 %v30, i64 %v31, i64 %v32)
  %c.b2 = icmp ne i64 %v33, 0
  br i1 %c.b2, label %b2.t12, label %b2.e13
b2.t12:
  br label %b6
b2.e13:
  br label %b7
b3:
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v45, i64 0
  store i64 %v15, ptr %st13
  %v40.p = getelementptr i64, ptr %v14, i64 0
  %v40 = load i64, ptr %v40.p
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v46, i64 0
  store i64 %v9, ptr %st14
  ret i64 %v40
b4:
  %v20.p = getelementptr i64, ptr %v10, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v8, i64 1
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 %v20, %v21
  %v23.p = getelementptr i64, ptr %v7, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.c = icmp sle i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  br label %b5
b5:
  %v19 = phi i64 [ %v18, %b1.e11 ], [ %v24, %b4 ]
  %c.b5 = icmp ne i64 %v19, 0
  br i1 %c.b5, label %b5.t16, label %b5.e17
b5.t16:
  br label %b2
b5.e17:
  br label %b3
b6:
  %v34 = add i64 0, 1
  %v35 = add i64 %v9, %v34
  %v36.p = getelementptr i64, ptr %v10, i64 0
  %v36 = load i64, ptr %v36.p
  %st17 = getelementptr i64, ptr %v14, i64 0
  store i64 %v36, ptr %st17
  br label %b8
b7:
  br label %b8
b8:
  %v37 = add i64 0, 1
  %v38.p = getelementptr i64, ptr %v10, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 %v38, %v37
  %st18 = getelementptr i64, ptr %v10, i64 0
  store i64 %v39, ptr %st18
  br label %b1
}

define internal i64 @"std/strings.runeCount"(i64 %v0, i64 %v1, i64 %v2) #0 {
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
  %v33 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v33, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5 = add i64 0, 0
  %v6 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v6, i64 0
  store i64 %v5, ptr %st3
  %v7 = add i64 0, 0
  %v8 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v8, i64 0
  store i64 %v7, ptr %st4
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v34, i64 0
  %v9 = load i64, ptr %v9.p
  br label %b1
b1:
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v35, i64 0
  store i64 %v9, ptr %st5
  %v10.p = getelementptr i64, ptr %v8, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v3, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp slt i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t7, label %b1.e8
b1.t7:
  br label %b2
b1.e8:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v36, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v8, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v3, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b2 = icmp ne i64 %v16, 0
  br i1 %c.b2, label %b2.t9, label %b2.e10
b2.t9:
  br label %b4
b2.e10:
  br label %b5
b3:
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v37, i64 0
  store i64 %v9, ptr %st10
  %v32.p = getelementptr i64, ptr %v6, i64 0
  %v32 = load i64, ptr %v32.p
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v38, i64 0
  store i64 %v4, ptr %st11
  ret i64 %v32
b4:
  %v17 = add i64 0, 18
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v18.p = getelementptr i64, ptr %v3, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = inttoptr i64 %v18 to ptr
  %v20 = getelementptr i8, ptr %v19, i64 %v14
  %v21.p = getelementptr i8, ptr %v20, i64 0
  %v21.b = load i8, ptr %v21.p
  %v21 = zext i8 %v21.b to i64
  %v22 = add i64 0, 192
  %v23 = and i64 %v21, %v22
  %v24 = add i64 0, 128
  %v25.c = icmp ne i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b5 = icmp ne i64 %v25, 0
  br i1 %c.b5, label %b5.t13, label %b5.e14
b5.t13:
  br label %b6
b5.e14:
  br label %b7
b6:
  %v26 = add i64 0, 1
  %v27.p = getelementptr i64, ptr %v6, i64 0
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 %v27, %v26
  %st14 = getelementptr i64, ptr %v6, i64 0
  store i64 %v28, ptr %st14
  br label %b8
b7:
  br label %b8
b8:
  %v29 = add i64 0, 1
  %v30.p = getelementptr i64, ptr %v8, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 %v30, %v29
  %st15 = getelementptr i64, ptr %v8, i64 0
  store i64 %v31, ptr %st15
  br label %b1
}

define internal i64 @"std/strings.countFrom"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v6 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v2, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v5, ptr %st5
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v38, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9 = add i64 0, 0
  %v10 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v9, ptr %st6
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s3, i64 0
  %st7 = getelementptr i64, ptr %v12, i64 0
  store i64 %v11, ptr %st7
  %v39 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v39, i64 0
  %v13 = load i64, ptr %v13.p
  br label %b1
b1:
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v40, i64 0
  store i64 %v13, ptr %st8
  %v14.p = getelementptr i64, ptr %v12, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v7, i64 1
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 %v14, %v15
  %v17.p = getelementptr i64, ptr %v6, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.c = icmp sle i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b1 = icmp ne i64 %v18, 0
  br i1 %c.b1, label %b1.t10, label %b1.e11
b1.t10:
  br label %b2
b1.e11:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v41, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v6, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v6, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v6, i64 2
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v12, i64 0
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v7, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v7, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v7, i64 2
  %v26 = load i64, ptr %v26.p
  %v27 = call i64 @"std/strings.hasPrefixAt"(i64 %v20, i64 %v21, i64 %v22, i64 %v23, i64 %v24, i64 %v25, i64 %v26)
  %c.b2 = icmp ne i64 %v27, 0
  br i1 %c.b2, label %b2.t12, label %b2.e13
b2.t12:
  br label %b4
b2.e13:
  br label %b5
b3:
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v42, i64 0
  store i64 %v13, ptr %st13
  %v37.p = getelementptr i64, ptr %v10, i64 0
  %v37 = load i64, ptr %v37.p
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v43, i64 0
  store i64 %v8, ptr %st14
  ret i64 %v37
b4:
  %v28 = add i64 0, 1
  %v29.p = getelementptr i64, ptr %v10, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 %v29, %v28
  %st15 = getelementptr i64, ptr %v10, i64 0
  store i64 %v30, ptr %st15
  %v31.p = getelementptr i64, ptr %v7, i64 1
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v12, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 %v32, %v31
  %st16 = getelementptr i64, ptr %v12, i64 0
  store i64 %v33, ptr %st16
  br label %b6
b5:
  %v34 = add i64 0, 1
  %v35.p = getelementptr i64, ptr %v12, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 %v35, %v34
  %st17 = getelementptr i64, ptr %v12, i64 0
  store i64 %v36, ptr %st17
  br label %b6
b6:
  br label %b1
}
