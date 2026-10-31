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
@"str.0" = internal constant [0 x i64] zeroinitializer
@"str.1" = internal constant [1 x i64] [i64 45]
@"str.2" = internal constant [1 x i64] [i64 35662966452837]
@"str.3" = internal constant [1 x i64] [i64 45515621232168]
@"str.4" = internal constant [1 x i64] [i64 110386723317092]
@"str.5" = internal constant [1 x i64] [i64 126879583003168]
@"str.6" = internal constant [1 x i64] [i64 28259039740721253]
@"str.7" = internal constant [2 x i64] [i64 3343762647533447533, i64 138419665012]
@"str.8" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.9" = internal constant [2 x i64] [i64 7017841207689508136, i64 694512738]
@"str.10" = internal constant [2 x i64] [i64 7022344803055789428, i64 7301423]
@"str.11" = internal constant [2 x i64] [i64 7022344803055789428, i64 138419333423]
@"str.12" = internal constant [3 x i64] [i64 7022344803055789428, i64 7812730951727802671, i64 500237086319]
@"str.13" = internal constant [3 x i64] [i64 7022344803055789428, i64 8319108854351620399, i64 32783537688505961]
@"str.14" = internal constant [2 x i64] [i64 7310238724270485551, i64 431211112044]
@"str.15" = internal constant [2 x i64] [i64 7382654471419948584, i64 2701357]
@"str.16" = internal constant [2 x i64] [i64 7959390400869068654, i64 100]
@"str.17" = internal constant [2 x i64] [i64 8314883101509906543, i64 2322294337933041952]
@"str.18" = internal constant [2 x i64] [i64 8462017840422938996, i64 116]
@"str.19" = internal constant [2 x i64] [i64 8679613437945079144, i64 2112116]
@"str.20" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.21" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.22" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.23" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.24" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.25" = internal constant [1 x i64] [i64 2685]
@"str.26" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.27" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.28" = internal constant [1 x i64] [i64 35899498962976]
@"str.29" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.30" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [33 x i64] [i64 7318349981679617, i64 5629500171747330, i64 5629500171747330, i64 5629500171747330, i64 3377700425170951, i64 8725733186732289, i64 18295882394894593, i64 22799482022265089, i64 11259008111345921, i64 13510807925031169, i64 12103433091809537, i64 14073757928784129, i64 4503609072943361, i64 4503609123275010, i64 4503609123275010, i64 4503609123275010, i64 19140307962560769, i64 4503609291047169, i64 10977533788946689, i64 6473934178353409, i64 4222134364668161, i64 3096234508157185, i64 7599827575636483, i64 8725727532810755, i64 8444252656763393, i64 8725731207021313, i64 14073755764523777, i64 4222131663536897, i64 8444256800736001, i64 5348032191136513, i64 16607031276339969, i64 19984731063976705, i64 28428980365296385]
@"str.31" = internal constant [1 x i64] [i64 9071397899755888]
@"str.32" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.33" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.34" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.35" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.36" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.37" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.38" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.39" = internal constant [1 x i64] [i64 544497952]
@"str.40" = internal constant [2 x i64] [i64 3345723106762125161, i64 491327221619]
@"str.41" = internal constant [2 x i64] [i64 7579399195445195891, i64 32199620796034671]
@"str.42" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]
@"str.43" = internal constant [4 x i64] [i64 7598263559392621683, i64 7598263559393601390, i64 7305524086039603054, i64 114]

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
  %v3 = getelementptr i64, ptr @"str.20", i64 0
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
  %v29 = getelementptr i64, ptr @"str.24", i64 0
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
  %v35 = getelementptr i64, ptr @"str.25", i64 0
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
  %v10 = getelementptr i64, ptr @"str.21", i64 0
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
  %v17 = getelementptr i64, ptr @"str.22", i64 0
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
  %v24 = getelementptr i64, ptr @"str.23", i64 0
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
  %v60 = getelementptr i64, ptr @"str.26", i64 0
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
  %v65 = getelementptr i64, ptr @"str.27", i64 0
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
  %v70 = getelementptr i64, ptr @"str.25", i64 0
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
  %v81 = getelementptr i64, ptr @"str.28", i64 0
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
  %v88 = getelementptr i64, ptr @"str.29", i64 0
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
  %v17 = getelementptr i64, ptr @"str.30", i64 0
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
  %v22 = getelementptr i64, ptr @"str.25", i64 0
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

define internal i64 @"main.fds"() #0 {
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
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v44, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  %v2 = getelementptr i64, ptr @"str.14", i64 0
  %v3 = add i64 0, 13
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
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v10, i64 2571
  store i64 %v0, ptr %st3
  call void @"std/io.ReadDir"(ptr %v1, i64 %v7, i64 %v8, i64 %v9)
  %v11 = add i64 0, 3
  %v12 = getelementptr i64, ptr %v1, i64 %v11
  %v13 = getelementptr i64, ptr %s2, i64 0
  %v14.p = getelementptr i64, ptr %v1, i64 0
  %v14 = load i64, ptr %v14.p
  %st4 = getelementptr i64, ptr %v13, i64 0
  store i64 %v14, ptr %st4
  %v15.p = getelementptr i64, ptr %v1, i64 1
  %v15 = load i64, ptr %v15.p
  %st5 = getelementptr i64, ptr %v13, i64 1
  store i64 %v15, ptr %st5
  %v16.p = getelementptr i64, ptr %v1, i64 2
  %v16 = load i64, ptr %v16.p
  %st6 = getelementptr i64, ptr %v13, i64 2
  store i64 %v16, ptr %st6
  %v17 = getelementptr i64, ptr %s3, i64 0
  %v18.p = getelementptr i64, ptr %v12, i64 0
  %v18 = load i64, ptr %v18.p
  %st7 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st7
  %v19.p = getelementptr i64, ptr %v12, i64 1
  %v19 = load i64, ptr %v19.p
  %st8 = getelementptr i64, ptr %v17, i64 1
  store i64 %v19, ptr %st8
  %v20.p = getelementptr i64, ptr %v12, i64 2
  %v20 = load i64, ptr %v20.p
  %st9 = getelementptr i64, ptr %v17, i64 2
  store i64 %v20, ptr %st9
  %v21.p = getelementptr i64, ptr %v12, i64 3
  %v21 = load i64, ptr %v21.p
  %st10 = getelementptr i64, ptr %v17, i64 3
  store i64 %v21, ptr %st10
  %v22.p = getelementptr i64, ptr %v12, i64 4
  %v22 = load i64, ptr %v22.p
  %st11 = getelementptr i64, ptr %v17, i64 4
  store i64 %v22, ptr %st11
  %v23.p = getelementptr i64, ptr %v12, i64 5
  %v23 = load i64, ptr %v23.p
  %st12 = getelementptr i64, ptr %v17, i64 5
  store i64 %v23, ptr %st12
  %v24.p = getelementptr i64, ptr %v17, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 0, 0
  %v26.c = icmp ne i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b0 = icmp ne i64 %v26, 0
  br i1 %c.b0, label %b0.t14, label %b0.e15
b0.t14:
  br label %b1
b0.e15:
  br label %b2
b1:
  %v27 = add i64 0, 1
  %v28 = getelementptr i64, ptr %v17, i64 %v27
  %v29 = getelementptr i64, ptr %s4, i64 0
  %v30.p = getelementptr i64, ptr %v28, i64 0
  %v30 = load i64, ptr %v30.p
  %st15 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st15
  %v31.p = getelementptr i64, ptr %v28, i64 1
  %v31 = load i64, ptr %v31.p
  %st16 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st16
  %v32.p = getelementptr i64, ptr %v28, i64 2
  %v32 = load i64, ptr %v32.p
  %st17 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st17
  %v33.p = getelementptr i64, ptr %v28, i64 3
  %v33 = load i64, ptr %v33.p
  %st18 = getelementptr i64, ptr %v29, i64 3
  store i64 %v33, ptr %st18
  %v34.p = getelementptr i64, ptr %v28, i64 4
  %v34 = load i64, ptr %v34.p
  %st19 = getelementptr i64, ptr %v29, i64 4
  store i64 %v34, ptr %st19
  %v35 = add i64 0, 1
  %v36 = add i64 0, 0
  %v37 = sub i64 %v36, %v35
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v45, i64 0
  store i64 %v0, ptr %st20
  ret i64 %v37
b2:
  br label %b3
b3:
  %v38 = phi ptr [ %v13, %b2 ]
  %v39 = getelementptr i64, ptr %s1, i64 0
  %v40.p = getelementptr i64, ptr %v38, i64 0
  %v40 = load i64, ptr %v40.p
  %st21 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st21
  %v41.p = getelementptr i64, ptr %v38, i64 1
  %v41 = load i64, ptr %v41.p
  %st22 = getelementptr i64, ptr %v39, i64 1
  store i64 %v41, ptr %st22
  %v42.p = getelementptr i64, ptr %v38, i64 2
  %v42 = load i64, ptr %v42.p
  %st23 = getelementptr i64, ptr %v39, i64 2
  store i64 %v42, ptr %st23
  %v43.p = getelementptr i64, ptr %v39, i64 1
  %v43 = load i64, ptr %v43.p
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v46, i64 0
  store i64 %v0, ptr %st24
  ret i64 %v43
}

define internal void @"main.size"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [9 x i64], align 8
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
  %s1.z7 = getelementptr i64, ptr %s1, i64 7
  store i64 0, ptr %s1.z7
  %s1.z8 = getelementptr i64, ptr %s1, i64 8
  store i64 0, ptr %s1.z8
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
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v1, ptr %st0
  %v52 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v52, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2571
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v4, i64 2571
  store i64 %v6, ptr %st1
  %v7 = add i64 0, 1
  %v8.c = icmp sge i64 %v5, %v7
  %v8 = zext i1 %v8.c to i64
  %v9.c = icmp sle i64 %v5, %v3
  %v9 = zext i1 %v9.c to i64
  %v10 = and i64 %v8, %v9
  %v11 = sub i64 %v5, %v3
  %v12 = mul i64 %v10, %v11
  %v13 = add i64 %v3, %v12
  call void @"rt.region_enter"()
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15.p = getelementptr i64, ptr %v2, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v16, i64 2571
  store i64 %v13, ptr %st2
  call void @"std/io.ReadAll"(ptr %v14, i64 %v15)
  %v17 = add i64 0, 3
  %v18 = getelementptr i64, ptr %v14, i64 %v17
  %v19.p = getelementptr i64, ptr %v18, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %v21.c = icmp ne i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b0 = icmp ne i64 %v21, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v22 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v0, i64 0
  store i64 %v22, ptr %st5
  %v23.p = getelementptr i64, ptr %v18, i64 0
  %v23 = load i64, ptr %v23.p
  %st6 = getelementptr i64, ptr %v0, i64 1
  store i64 %v23, ptr %st6
  %v24.p = getelementptr i64, ptr %v18, i64 1
  %v24 = load i64, ptr %v24.p
  %st7 = getelementptr i64, ptr %v0, i64 2
  store i64 %v24, ptr %st7
  %v25.p = getelementptr i64, ptr %v18, i64 2
  %v25 = load i64, ptr %v25.p
  %st8 = getelementptr i64, ptr %v0, i64 3
  store i64 %v25, ptr %st8
  %v26.p = getelementptr i64, ptr %v18, i64 3
  %v26 = load i64, ptr %v26.p
  %st9 = getelementptr i64, ptr %v0, i64 4
  store i64 %v26, ptr %st9
  %v27.p = getelementptr i64, ptr %v18, i64 4
  %v27 = load i64, ptr %v27.p
  %st10 = getelementptr i64, ptr %v0, i64 5
  store i64 %v27, ptr %st10
  %v28.p = getelementptr i64, ptr %v18, i64 5
  %v28 = load i64, ptr %v28.p
  %st11 = getelementptr i64, ptr %v0, i64 6
  store i64 %v28, ptr %st11
  %v29.p = getelementptr i64, ptr %v0, i64 1
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 0, 0
  %v31.c = icmp ne i64 %v29, %v30
  %v31 = zext i1 %v31.c to i64
  %c.b1 = icmp ne i64 %v31, 0
  br i1 %c.b1, label %b1.t13, label %b1.e14
b1.t13:
  br label %b3
b1.e14:
  br label %b4
b2:
  %v34 = getelementptr i64, ptr %s2, i64 0
  %v35.p = getelementptr i64, ptr %v14, i64 0
  %v35 = load i64, ptr %v35.p
  %st14 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st14
  %v36.p = getelementptr i64, ptr %v14, i64 1
  %v36 = load i64, ptr %v36.p
  %st15 = getelementptr i64, ptr %v34, i64 1
  store i64 %v36, ptr %st15
  %v37.p = getelementptr i64, ptr %v14, i64 2
  %v37 = load i64, ptr %v37.p
  %st16 = getelementptr i64, ptr %v34, i64 2
  store i64 %v37, ptr %st16
  %v38.p = getelementptr i64, ptr %v34, i64 1
  %v38 = load i64, ptr %v38.p
  %v39 = getelementptr i64, ptr %s3, i64 0
  %v40 = add i64 0, 0
  %st17 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st17
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v38, ptr %st18
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v41, ptr %st19
  %v42.p = getelementptr i64, ptr %v39, i64 1
  %v42 = load i64, ptr %v42.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v42, ptr %st20
  %v43.p = getelementptr i64, ptr %v39, i64 2
  %v43 = load i64, ptr %v43.p
  %st21 = getelementptr i64, ptr %v0, i64 3
  store i64 %v43, ptr %st21
  %v44.p = getelementptr i64, ptr %v39, i64 3
  %v44 = load i64, ptr %v44.p
  %st22 = getelementptr i64, ptr %v0, i64 4
  store i64 %v44, ptr %st22
  %v45.p = getelementptr i64, ptr %v39, i64 4
  %v45 = load i64, ptr %v45.p
  %st23 = getelementptr i64, ptr %v0, i64 5
  store i64 %v45, ptr %st23
  %v46.p = getelementptr i64, ptr %v39, i64 5
  %v46 = load i64, ptr %v46.p
  %st24 = getelementptr i64, ptr %v0, i64 6
  store i64 %v46, ptr %st24
  %v47.p = getelementptr i64, ptr %v0, i64 1
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 0, 0
  %v49.c = icmp ne i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b2 = icmp ne i64 %v49, 0
  br i1 %c.b2, label %b2.t26, label %b2.e27
b2.t26:
  br label %b5
b2.e27:
  br label %b6
b3:
  %v32 = add i64 0, 2
  %v33 = getelementptr i64, ptr %v0, i64 %v32
  call void @"rt.err_relocate"(ptr %v33, i64 %v3)
  br label %b4
b4:
  %v53 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v53, i64 0
  store i64 %v3, ptr %st27
  ret void
b5:
  %v50 = add i64 0, 2
  %v51 = getelementptr i64, ptr %v0, i64 %v50
  call void @"rt.err_relocate"(ptr %v51, i64 %v3)
  br label %b6
b6:
  %v54 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v54, i64 0
  store i64 %v3, ptr %st28
  ret void
}

define internal void @"main.sizeOf"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2571
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v6, i64 2571
  store i64 %v8, ptr %st3
  %v9 = add i64 0, 1
  %v10.c = icmp sge i64 %v7, %v9
  %v10 = zext i1 %v10.c to i64
  %v11.c = icmp sle i64 %v7, %v5
  %v11 = zext i1 %v11.c to i64
  %v12 = and i64 %v10, %v11
  %v13 = sub i64 %v7, %v5
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v5, %v14
  call void @"rt.region_enter"()
  %v16 = getelementptr i64, ptr %s1, i64 0
  %v17.p = getelementptr i64, ptr %v4, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v4, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v4, i64 2
  %v19 = load i64, ptr %v19.p
  %v20 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v20, i64 2571
  store i64 %v15, ptr %st4
  call void @"std/io.Open"(ptr %v16, i64 %v17, i64 %v18, i64 %v19)
  %v21 = add i64 0, 1
  %v22 = getelementptr i64, ptr %v16, i64 %v21
  %v23.p = getelementptr i64, ptr %v22, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b0 = icmp ne i64 %v25, 0
  br i1 %c.b0, label %b0.t6, label %b0.e7
b0.t6:
  br label %b1
b0.e7:
  br label %b2
b1:
  %v26 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v0, i64 0
  store i64 %v26, ptr %st7
  %v27.p = getelementptr i64, ptr %v22, i64 0
  %v27 = load i64, ptr %v27.p
  %st8 = getelementptr i64, ptr %v0, i64 1
  store i64 %v27, ptr %st8
  %v28.p = getelementptr i64, ptr %v22, i64 1
  %v28 = load i64, ptr %v28.p
  %st9 = getelementptr i64, ptr %v0, i64 2
  store i64 %v28, ptr %st9
  %v29.p = getelementptr i64, ptr %v22, i64 2
  %v29 = load i64, ptr %v29.p
  %st10 = getelementptr i64, ptr %v0, i64 3
  store i64 %v29, ptr %st10
  %v30.p = getelementptr i64, ptr %v22, i64 3
  %v30 = load i64, ptr %v30.p
  %st11 = getelementptr i64, ptr %v0, i64 4
  store i64 %v30, ptr %st11
  %v31.p = getelementptr i64, ptr %v22, i64 4
  %v31 = load i64, ptr %v31.p
  %st12 = getelementptr i64, ptr %v0, i64 5
  store i64 %v31, ptr %st12
  %v32.p = getelementptr i64, ptr %v22, i64 5
  %v32 = load i64, ptr %v32.p
  %st13 = getelementptr i64, ptr %v0, i64 6
  store i64 %v32, ptr %st13
  %v33.p = getelementptr i64, ptr %v0, i64 1
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 0, 0
  %v35.c = icmp ne i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b1 = icmp ne i64 %v35, 0
  br i1 %c.b1, label %b1.t15, label %b1.e16
b1.t15:
  br label %b3
b1.e16:
  br label %b4
b2:
  %v38 = getelementptr i64, ptr %s2, i64 0
  %v39.p = getelementptr i64, ptr %v16, i64 0
  %v39 = load i64, ptr %v39.p
  %st16 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st16
  %v40 = getelementptr i64, ptr %s3, i64 0
  %v41.p = getelementptr i64, ptr %v38, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v42, i64 2571
  store i64 %v15, ptr %st17
  call void @"main.size"(ptr %v40, i64 %v41)
  %v43.p = getelementptr i64, ptr %v40, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = add i64 0, 1
  %v45 = getelementptr i64, ptr %v40, i64 %v44
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v43, ptr %st18
  %v46.p = getelementptr i64, ptr %v45, i64 0
  %v46 = load i64, ptr %v46.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v46, ptr %st19
  %v47.p = getelementptr i64, ptr %v45, i64 1
  %v47 = load i64, ptr %v47.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v47, ptr %st20
  %v48.p = getelementptr i64, ptr %v45, i64 2
  %v48 = load i64, ptr %v48.p
  %st21 = getelementptr i64, ptr %v0, i64 3
  store i64 %v48, ptr %st21
  %v49.p = getelementptr i64, ptr %v45, i64 3
  %v49 = load i64, ptr %v49.p
  %st22 = getelementptr i64, ptr %v0, i64 4
  store i64 %v49, ptr %st22
  %v50.p = getelementptr i64, ptr %v45, i64 4
  %v50 = load i64, ptr %v50.p
  %st23 = getelementptr i64, ptr %v0, i64 5
  store i64 %v50, ptr %st23
  %v51.p = getelementptr i64, ptr %v45, i64 5
  %v51 = load i64, ptr %v51.p
  %st24 = getelementptr i64, ptr %v0, i64 6
  store i64 %v51, ptr %st24
  %v52.p = getelementptr i64, ptr %v38, i64 0
  %v52 = load i64, ptr %v52.p
  call void @"std/io.Close"(i64 %v52)
  %v53.p = getelementptr i64, ptr %v0, i64 1
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 0
  %v55.c = icmp ne i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b2 = icmp ne i64 %v55, 0
  br i1 %c.b2, label %b2.t26, label %b2.e27
b2.t26:
  br label %b5
b2.e27:
  br label %b6
b3:
  %v36 = add i64 0, 2
  %v37 = getelementptr i64, ptr %v0, i64 %v36
  call void @"rt.err_relocate"(ptr %v37, i64 %v5)
  br label %b4
b4:
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v59, i64 0
  store i64 %v5, ptr %st27
  ret void
b5:
  %v56 = add i64 0, 2
  %v57 = getelementptr i64, ptr %v0, i64 %v56
  call void @"rt.err_relocate"(ptr %v57, i64 %v5)
  br label %b6
b6:
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v60, i64 0
  store i64 %v5, ptr %st28
  ret void
}

define internal void @"main.firstLine"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s7 = alloca [9 x i64], align 8
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
  %s7.z7 = getelementptr i64, ptr %s7, i64 7
  store i64 0, ptr %s7.z7
  %s7.z8 = getelementptr i64, ptr %s7, i64 8
  store i64 0, ptr %s7.z8
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
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
  %s10 = alloca [1 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s11 = alloca [9 x i64], align 8
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
  %s11.z6 = getelementptr i64, ptr %s11, i64 6
  store i64 0, ptr %s11.z6
  %s11.z7 = getelementptr i64, ptr %s11, i64 7
  store i64 0, ptr %s11.z7
  %s11.z8 = getelementptr i64, ptr %s11, i64 8
  store i64 0, ptr %s11.z8
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
  %s14 = alloca [6 x i64], align 8
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
  %s14.z5 = getelementptr i64, ptr %s14, i64 5
  store i64 0, ptr %s14.z5
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v172 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v172, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2571
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v6, i64 2571
  store i64 %v8, ptr %st3
  %v9 = add i64 0, 1
  %v10.c = icmp sge i64 %v7, %v9
  %v10 = zext i1 %v10.c to i64
  %v11.c = icmp sle i64 %v7, %v5
  %v11 = zext i1 %v11.c to i64
  %v12 = and i64 %v10, %v11
  %v13 = sub i64 %v7, %v5
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v5, %v14
  call void @"rt.region_enter"()
  %v16 = getelementptr i64, ptr %s1, i64 0
  %v17.p = getelementptr i64, ptr %v4, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v4, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v4, i64 2
  %v19 = load i64, ptr %v19.p
  %v20 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v20, i64 2571
  store i64 %v15, ptr %st4
  call void @"std/io.Open"(ptr %v16, i64 %v17, i64 %v18, i64 %v19)
  %v21 = add i64 0, 1
  %v22 = getelementptr i64, ptr %v16, i64 %v21
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24.p = getelementptr i64, ptr %v16, i64 0
  %v24 = load i64, ptr %v24.p
  %st5 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st5
  %v25 = getelementptr i64, ptr %s3, i64 0
  %v26.p = getelementptr i64, ptr %v22, i64 0
  %v26 = load i64, ptr %v26.p
  %st6 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st6
  %v27.p = getelementptr i64, ptr %v22, i64 1
  %v27 = load i64, ptr %v27.p
  %st7 = getelementptr i64, ptr %v25, i64 1
  store i64 %v27, ptr %st7
  %v28.p = getelementptr i64, ptr %v22, i64 2
  %v28 = load i64, ptr %v28.p
  %st8 = getelementptr i64, ptr %v25, i64 2
  store i64 %v28, ptr %st8
  %v29.p = getelementptr i64, ptr %v22, i64 3
  %v29 = load i64, ptr %v29.p
  %st9 = getelementptr i64, ptr %v25, i64 3
  store i64 %v29, ptr %st9
  %v30.p = getelementptr i64, ptr %v22, i64 4
  %v30 = load i64, ptr %v30.p
  %st10 = getelementptr i64, ptr %v25, i64 4
  store i64 %v30, ptr %st10
  %v31.p = getelementptr i64, ptr %v22, i64 5
  %v31 = load i64, ptr %v31.p
  %st11 = getelementptr i64, ptr %v25, i64 5
  store i64 %v31, ptr %st11
  %v32.p = getelementptr i64, ptr %v25, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 0
  %v34.c = icmp ne i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b0 = icmp ne i64 %v34, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v35 = add i64 0, 1
  %v36 = getelementptr i64, ptr %v25, i64 %v35
  %v37 = getelementptr i64, ptr %s4, i64 0
  %v38.p = getelementptr i64, ptr %v36, i64 0
  %v38 = load i64, ptr %v38.p
  %st14 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st14
  %v39.p = getelementptr i64, ptr %v36, i64 1
  %v39 = load i64, ptr %v39.p
  %st15 = getelementptr i64, ptr %v37, i64 1
  store i64 %v39, ptr %st15
  %v40.p = getelementptr i64, ptr %v36, i64 2
  %v40 = load i64, ptr %v40.p
  %st16 = getelementptr i64, ptr %v37, i64 2
  store i64 %v40, ptr %st16
  %v41.p = getelementptr i64, ptr %v36, i64 3
  %v41 = load i64, ptr %v41.p
  %st17 = getelementptr i64, ptr %v37, i64 3
  store i64 %v41, ptr %st17
  %v42.p = getelementptr i64, ptr %v36, i64 4
  %v42 = load i64, ptr %v42.p
  %st18 = getelementptr i64, ptr %v37, i64 4
  store i64 %v42, ptr %st18
  %v43 = getelementptr i64, ptr @"str.3", i64 0
  %v44 = add i64 0, 6
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s5, i64 0
  %v47 = ptrtoint ptr %v43 to i64
  %st19 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st19
  %st20 = getelementptr i64, ptr %v46, i64 1
  store i64 %v44, ptr %st20
  %st21 = getelementptr i64, ptr %v46, i64 2
  store i64 %v45, ptr %st21
  %v48.p = getelementptr i64, ptr %v46, i64 0
  %v48 = load i64, ptr %v48.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v48, ptr %st22
  %v49.p = getelementptr i64, ptr %v46, i64 1
  %v49 = load i64, ptr %v49.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v49, ptr %st23
  %v50.p = getelementptr i64, ptr %v46, i64 2
  %v50 = load i64, ptr %v50.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v50, ptr %st24
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v173 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v173, i64 0
  store i64 %v5, ptr %st25
  ret void
b2:
  br label %b3
b3:
  %v51 = phi ptr [ %v23, %b2 ]
  %v52 = getelementptr i64, ptr %s6, i64 0
  %v53.p = getelementptr i64, ptr %v51, i64 0
  %v53 = load i64, ptr %v53.p
  %st26 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st26
  %v54 = getelementptr i64, ptr %s7, i64 0
  %v55.p = getelementptr i64, ptr %v52, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v56, i64 2571
  store i64 %v15, ptr %st27
  call void @"std/io.ReadAll"(ptr %v54, i64 %v55)
  %v57 = add i64 0, 3
  %v58 = getelementptr i64, ptr %v54, i64 %v57
  %v59 = getelementptr i64, ptr %s5, i64 0
  %v60.p = getelementptr i64, ptr %v54, i64 0
  %v60 = load i64, ptr %v60.p
  %st28 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st28
  %v61.p = getelementptr i64, ptr %v54, i64 1
  %v61 = load i64, ptr %v61.p
  %st29 = getelementptr i64, ptr %v59, i64 1
  store i64 %v61, ptr %st29
  %v62.p = getelementptr i64, ptr %v54, i64 2
  %v62 = load i64, ptr %v62.p
  %st30 = getelementptr i64, ptr %v59, i64 2
  store i64 %v62, ptr %st30
  %v63 = getelementptr i64, ptr %s8, i64 0
  %v64.p = getelementptr i64, ptr %v58, i64 0
  %v64 = load i64, ptr %v64.p
  %st31 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st31
  %v65.p = getelementptr i64, ptr %v58, i64 1
  %v65 = load i64, ptr %v65.p
  %st32 = getelementptr i64, ptr %v63, i64 1
  store i64 %v65, ptr %st32
  %v66.p = getelementptr i64, ptr %v58, i64 2
  %v66 = load i64, ptr %v66.p
  %st33 = getelementptr i64, ptr %v63, i64 2
  store i64 %v66, ptr %st33
  %v67.p = getelementptr i64, ptr %v58, i64 3
  %v67 = load i64, ptr %v67.p
  %st34 = getelementptr i64, ptr %v63, i64 3
  store i64 %v67, ptr %st34
  %v68.p = getelementptr i64, ptr %v58, i64 4
  %v68 = load i64, ptr %v68.p
  %st35 = getelementptr i64, ptr %v63, i64 4
  store i64 %v68, ptr %st35
  %v69.p = getelementptr i64, ptr %v58, i64 5
  %v69 = load i64, ptr %v69.p
  %st36 = getelementptr i64, ptr %v63, i64 5
  store i64 %v69, ptr %st36
  %v70.p = getelementptr i64, ptr %v63, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = add i64 0, 0
  %v72.c = icmp ne i64 %v70, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b3 = icmp ne i64 %v72, 0
  br i1 %c.b3, label %b3.t38, label %b3.e39
b3.t38:
  br label %b4
b3.e39:
  br label %b5
b4:
  %v73 = add i64 0, 1
  %v74 = getelementptr i64, ptr %v63, i64 %v73
  %v75 = getelementptr i64, ptr %s4, i64 0
  %v76.p = getelementptr i64, ptr %v74, i64 0
  %v76 = load i64, ptr %v76.p
  %st39 = getelementptr i64, ptr %v75, i64 0
  store i64 %v76, ptr %st39
  %v77.p = getelementptr i64, ptr %v74, i64 1
  %v77 = load i64, ptr %v77.p
  %st40 = getelementptr i64, ptr %v75, i64 1
  store i64 %v77, ptr %st40
  %v78.p = getelementptr i64, ptr %v74, i64 2
  %v78 = load i64, ptr %v78.p
  %st41 = getelementptr i64, ptr %v75, i64 2
  store i64 %v78, ptr %st41
  %v79.p = getelementptr i64, ptr %v74, i64 3
  %v79 = load i64, ptr %v79.p
  %st42 = getelementptr i64, ptr %v75, i64 3
  store i64 %v79, ptr %st42
  %v80.p = getelementptr i64, ptr %v74, i64 4
  %v80 = load i64, ptr %v80.p
  %st43 = getelementptr i64, ptr %v75, i64 4
  store i64 %v80, ptr %st43
  %v81 = getelementptr i64, ptr @"str.9", i64 0
  %v82 = add i64 0, 12
  %v83 = add i64 0, 0
  %v84 = getelementptr i64, ptr %s9, i64 0
  %v85 = ptrtoint ptr %v81 to i64
  %st44 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st44
  %st45 = getelementptr i64, ptr %v84, i64 1
  store i64 %v82, ptr %st45
  %st46 = getelementptr i64, ptr %v84, i64 2
  store i64 %v83, ptr %st46
  %v86.p = getelementptr i64, ptr %v84, i64 0
  %v86 = load i64, ptr %v86.p
  %st47 = getelementptr i64, ptr %v0, i64 0
  store i64 %v86, ptr %st47
  %v87.p = getelementptr i64, ptr %v84, i64 1
  %v87 = load i64, ptr %v87.p
  %st48 = getelementptr i64, ptr %v0, i64 1
  store i64 %v87, ptr %st48
  %v88.p = getelementptr i64, ptr %v84, i64 2
  %v88 = load i64, ptr %v88.p
  %st49 = getelementptr i64, ptr %v0, i64 2
  store i64 %v88, ptr %st49
  %v89.p = getelementptr i64, ptr %v52, i64 0
  %v89 = load i64, ptr %v89.p
  call void @"std/io.Close"(i64 %v89)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v174 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v174, i64 0
  store i64 %v5, ptr %st50
  ret void
b5:
  br label %b6
b6:
  %v90 = phi ptr [ %v59, %b5 ]
  %v91 = getelementptr i64, ptr %s9, i64 0
  %v92.p = getelementptr i64, ptr %v90, i64 0
  %v92 = load i64, ptr %v92.p
  %st51 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st51
  %v93.p = getelementptr i64, ptr %v90, i64 1
  %v93 = load i64, ptr %v93.p
  %st52 = getelementptr i64, ptr %v91, i64 1
  store i64 %v93, ptr %st52
  %v94.p = getelementptr i64, ptr %v90, i64 2
  %v94 = load i64, ptr %v94.p
  %st53 = getelementptr i64, ptr %v91, i64 2
  store i64 %v94, ptr %st53
  %v95 = add i64 0, 0
  %v96 = getelementptr i64, ptr %s10, i64 0
  %st54 = getelementptr i64, ptr %v96, i64 0
  store i64 %v95, ptr %st54
  %v175 = getelementptr i64, ptr @"rt.meta", i64 0
  %v97.p = getelementptr i64, ptr %v175, i64 0
  %v97 = load i64, ptr %v97.p
  br label %b7
b7:
  %v176 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v176, i64 0
  store i64 %v97, ptr %st55
  %v98.p = getelementptr i64, ptr %v96, i64 0
  %v98 = load i64, ptr %v98.p
  %v99.p = getelementptr i64, ptr %v91, i64 1
  %v99 = load i64, ptr %v99.p
  %v100.c = icmp slt i64 %v98, %v99
  %v100 = zext i1 %v100.c to i64
  %c.b7 = icmp ne i64 %v100, 0
  br i1 %c.b7, label %b7.t57, label %b7.e58
b7.t57:
  br label %b10
b7.e58:
  br label %b11
b8:
  call void @"rt.region_enter"()
  %v177 = getelementptr i64, ptr @"rt.meta", i64 0
  %v112.p = getelementptr i64, ptr %v177, i64 0
  %v112 = load i64, ptr %v112.p
  %v113 = add i64 0, 1
  %v114.p = getelementptr i64, ptr %v96, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 %v114, %v113
  %st58 = getelementptr i64, ptr %v96, i64 0
  store i64 %v115, ptr %st58
  br label %b7
b9:
  %v178 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v178, i64 0
  store i64 %v97, ptr %st59
  %v116 = getelementptr i64, ptr %s11, i64 0
  %v117 = add i64 0, 0
  %v118.p = getelementptr i64, ptr %v96, i64 0
  %v118 = load i64, ptr %v118.p
  %v119 = add i64 0, 0
  %v120.c = icmp slt i64 %v117, %v119
  %v120 = zext i1 %v120.c to i64
  %c.b9 = icmp ne i64 %v120, 0
  br i1 %c.b9, label %b9.t61, label %b9.e62
b9.t61:
  br label %b14
b9.e62:
  br label %b15
b10:
  %v102.p = getelementptr i64, ptr %v96, i64 0
  %v102 = load i64, ptr %v102.p
  %v103.p = getelementptr i64, ptr %v91, i64 1
  %v103 = load i64, ptr %v103.p
  %v104.c = icmp uge i64 %v102, %v103
  %v104 = zext i1 %v104.c to i64
  %c.b10 = icmp ne i64 %v104, 0
  br i1 %c.b10, label %b10.t63, label %b10.e64
b10.t63:
  br label %b12
b10.e64:
  br label %b13
b11:
  %v101 = phi i64 [ %v100, %b7.e58 ], [ %v111, %b13 ]
  %c.b11 = icmp ne i64 %v101, 0
  br i1 %c.b11, label %b11.t65, label %b11.e66
b11.t65:
  br label %b8
b11.e66:
  br label %b9
b12:
  %v105 = add i64 0, 0
  call void @"rt.panic"(i64 %v105)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v106.p = getelementptr i64, ptr %v91, i64 0
  %v106 = load i64, ptr %v106.p
  %v107 = inttoptr i64 %v106 to ptr
  %v108 = getelementptr i8, ptr %v107, i64 %v102
  %v109.p = getelementptr i8, ptr %v108, i64 0
  %v109.b = load i8, ptr %v109.p
  %v109 = zext i8 %v109.b to i64
  %v110 = add i64 0, 10
  %v111.c = icmp ne i64 %v109, %v110
  %v111 = zext i1 %v111.c to i64
  br label %b11
b14:
  %v121 = add i64 0, 1
  call void @"rt.panic"(i64 %v121)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v122.c = icmp slt i64 %v118, %v117
  %v122 = zext i1 %v122.c to i64
  %c.b15 = icmp ne i64 %v122, 0
  br i1 %c.b15, label %b15.t67, label %b15.e68
b15.t67:
  br label %b16
b15.e68:
  br label %b17
b16:
  %v123 = add i64 0, 2
  call void @"rt.panic"(i64 %v123)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v124.p = getelementptr i64, ptr %v91, i64 1
  %v124 = load i64, ptr %v124.p
  %v125.c = icmp sgt i64 %v118, %v124
  %v125 = zext i1 %v125.c to i64
  %c.b17 = icmp ne i64 %v125, 0
  br i1 %c.b17, label %b17.t69, label %b17.e70
b17.t69:
  br label %b18
b17.e70:
  br label %b19
b18:
  %v126 = add i64 0, 3
  call void @"rt.panic"(i64 %v126)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v127.p = getelementptr i64, ptr %v91, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = inttoptr i64 %v127 to ptr
  %v129 = getelementptr i8, ptr %v128, i64 %v117
  %v130 = sub i64 %v118, %v117
  %v131.p = getelementptr i64, ptr %v91, i64 2
  %v131 = load i64, ptr %v131.p
  %v132 = getelementptr i64, ptr %s12, i64 0
  %v133 = ptrtoint ptr %v129 to i64
  %st70 = getelementptr i64, ptr %v132, i64 0
  store i64 %v133, ptr %st70
  %st71 = getelementptr i64, ptr %v132, i64 1
  store i64 %v130, ptr %st71
  %st72 = getelementptr i64, ptr %v132, i64 2
  store i64 %v131, ptr %st72
  %v134.p = getelementptr i64, ptr %v132, i64 0
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v132, i64 1
  %v135 = load i64, ptr %v135.p
  %v136.p = getelementptr i64, ptr %v132, i64 2
  %v136 = load i64, ptr %v136.p
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %st73 = getelementptr i64, ptr %v137, i64 2571
  store i64 %v15, ptr %st73
  call void @"std/internal/utf8.Parse"(ptr %v116, i64 %v134, i64 %v135, i64 %v136)
  %v138 = add i64 0, 3
  %v139 = getelementptr i64, ptr %v116, i64 %v138
  %v140 = getelementptr i64, ptr %s13, i64 0
  %v141.p = getelementptr i64, ptr %v116, i64 0
  %v141 = load i64, ptr %v141.p
  %st74 = getelementptr i64, ptr %v140, i64 0
  store i64 %v141, ptr %st74
  %v142.p = getelementptr i64, ptr %v116, i64 1
  %v142 = load i64, ptr %v142.p
  %st75 = getelementptr i64, ptr %v140, i64 1
  store i64 %v142, ptr %st75
  %v143.p = getelementptr i64, ptr %v116, i64 2
  %v143 = load i64, ptr %v143.p
  %st76 = getelementptr i64, ptr %v140, i64 2
  store i64 %v143, ptr %st76
  %v144 = getelementptr i64, ptr %s14, i64 0
  %v145.p = getelementptr i64, ptr %v139, i64 0
  %v145 = load i64, ptr %v145.p
  %st77 = getelementptr i64, ptr %v144, i64 0
  store i64 %v145, ptr %st77
  %v146.p = getelementptr i64, ptr %v139, i64 1
  %v146 = load i64, ptr %v146.p
  %st78 = getelementptr i64, ptr %v144, i64 1
  store i64 %v146, ptr %st78
  %v147.p = getelementptr i64, ptr %v139, i64 2
  %v147 = load i64, ptr %v147.p
  %st79 = getelementptr i64, ptr %v144, i64 2
  store i64 %v147, ptr %st79
  %v148.p = getelementptr i64, ptr %v139, i64 3
  %v148 = load i64, ptr %v148.p
  %st80 = getelementptr i64, ptr %v144, i64 3
  store i64 %v148, ptr %st80
  %v149.p = getelementptr i64, ptr %v139, i64 4
  %v149 = load i64, ptr %v149.p
  %st81 = getelementptr i64, ptr %v144, i64 4
  store i64 %v149, ptr %st81
  %v150.p = getelementptr i64, ptr %v139, i64 5
  %v150 = load i64, ptr %v150.p
  %st82 = getelementptr i64, ptr %v144, i64 5
  store i64 %v150, ptr %st82
  %v151.p = getelementptr i64, ptr %v144, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = add i64 0, 0
  %v153.c = icmp ne i64 %v151, %v152
  %v153 = zext i1 %v153.c to i64
  %c.b19 = icmp ne i64 %v153, 0
  br i1 %c.b19, label %b19.t84, label %b19.e85
b19.t84:
  br label %b20
b19.e85:
  br label %b21
b20:
  %v154 = add i64 0, 1
  %v155 = getelementptr i64, ptr %v144, i64 %v154
  %v156 = getelementptr i64, ptr %s4, i64 0
  %v157.p = getelementptr i64, ptr %v155, i64 0
  %v157 = load i64, ptr %v157.p
  %st85 = getelementptr i64, ptr %v156, i64 0
  store i64 %v157, ptr %st85
  %v158.p = getelementptr i64, ptr %v155, i64 1
  %v158 = load i64, ptr %v158.p
  %st86 = getelementptr i64, ptr %v156, i64 1
  store i64 %v158, ptr %st86
  %v159.p = getelementptr i64, ptr %v155, i64 2
  %v159 = load i64, ptr %v159.p
  %st87 = getelementptr i64, ptr %v156, i64 2
  store i64 %v159, ptr %st87
  %v160.p = getelementptr i64, ptr %v155, i64 3
  %v160 = load i64, ptr %v160.p
  %st88 = getelementptr i64, ptr %v156, i64 3
  store i64 %v160, ptr %st88
  %v161.p = getelementptr i64, ptr %v155, i64 4
  %v161 = load i64, ptr %v161.p
  %st89 = getelementptr i64, ptr %v156, i64 4
  store i64 %v161, ptr %st89
  %v162 = getelementptr i64, ptr @"str.15", i64 0
  %v163 = add i64 0, 11
  %v164 = add i64 0, 0
  %v165 = getelementptr i64, ptr %s12, i64 0
  %v166 = ptrtoint ptr %v162 to i64
  %st90 = getelementptr i64, ptr %v165, i64 0
  store i64 %v166, ptr %st90
  %st91 = getelementptr i64, ptr %v165, i64 1
  store i64 %v163, ptr %st91
  %st92 = getelementptr i64, ptr %v165, i64 2
  store i64 %v164, ptr %st92
  br label %b22
b21:
  br label %b22
b22:
  %v167 = phi ptr [ %v165, %b20 ], [ %v140, %b21 ]
  %v168.p = getelementptr i64, ptr %v167, i64 0
  %v168 = load i64, ptr %v168.p
  %st93 = getelementptr i64, ptr %v0, i64 0
  store i64 %v168, ptr %st93
  %v169.p = getelementptr i64, ptr %v167, i64 1
  %v169 = load i64, ptr %v169.p
  %st94 = getelementptr i64, ptr %v0, i64 1
  store i64 %v169, ptr %st94
  %v170.p = getelementptr i64, ptr %v167, i64 2
  %v170 = load i64, ptr %v170.p
  %st95 = getelementptr i64, ptr %v0, i64 2
  store i64 %v170, ptr %st95
  %v171.p = getelementptr i64, ptr %v52, i64 0
  %v171 = load i64, ptr %v171.p
  call void @"std/io.Close"(i64 %v171)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v179 = getelementptr i64, ptr @"rt.meta", i64 0
  %st96 = getelementptr i64, ptr %v179, i64 0
  store i64 %v5, ptr %st96
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
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
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
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v83, i64 0
  %v7 = load i64, ptr %v7.p
  %v8 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v8, i64 2571
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v8, i64 2571
  store i64 %v10, ptr %st5
  %v11 = add i64 0, 1
  %v12.c = icmp sge i64 %v9, %v11
  %v12 = zext i1 %v12.c to i64
  %v13.c = icmp sle i64 %v9, %v7
  %v13 = zext i1 %v13.c to i64
  %v14 = and i64 %v12, %v13
  %v15 = sub i64 %v9, %v7
  %v16 = mul i64 %v14, %v15
  %v17 = add i64 %v7, %v16
  call void @"rt.region_enter"()
  %v18.p = getelementptr i64, ptr %v6, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %v20.c = icmp eq i64 %v18, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b0 = icmp ne i64 %v20, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b2
b0.e8:
  br label %b1
b1:
  %v26.p = getelementptr i64, ptr %v6, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 1
  %v28.c = icmp eq i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b1 = icmp ne i64 %v28, 0
  br i1 %c.b1, label %b1.t9, label %b1.e10
b1.t9:
  br label %b4
b1.e10:
  br label %b3
b2:
  %v21 = getelementptr i64, ptr @"str.16", i64 0
  %v22 = add i64 0, 9
  %v23 = add i64 0, 0
  %v24 = getelementptr i64, ptr %s1, i64 0
  %v25 = ptrtoint ptr %v21 to i64
  %st10 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st10
  %st11 = getelementptr i64, ptr %v24, i64 1
  store i64 %v22, ptr %st11
  %st12 = getelementptr i64, ptr %v24, i64 2
  store i64 %v23, ptr %st12
  br label %b11
b3:
  %v34.p = getelementptr i64, ptr %v6, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 2
  %v36.c = icmp eq i64 %v34, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b3 = icmp ne i64 %v36, 0
  br i1 %c.b3, label %b3.t14, label %b3.e15
b3.t14:
  br label %b6
b3.e15:
  br label %b5
b4:
  %v29 = getelementptr i64, ptr @"str.4", i64 0
  %v30 = add i64 0, 6
  %v31 = add i64 0, 0
  %v32 = getelementptr i64, ptr %s2, i64 0
  %v33 = ptrtoint ptr %v29 to i64
  %st15 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st15
  %st16 = getelementptr i64, ptr %v32, i64 1
  store i64 %v30, ptr %st16
  %st17 = getelementptr i64, ptr %v32, i64 2
  store i64 %v31, ptr %st17
  br label %b11
b5:
  %v42.p = getelementptr i64, ptr %v6, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 0, 3
  %v44.c = icmp eq i64 %v42, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b5 = icmp ne i64 %v44, 0
  br i1 %c.b5, label %b5.t19, label %b5.e20
b5.t19:
  br label %b8
b5.e20:
  br label %b7
b6:
  %v37 = getelementptr i64, ptr @"str.18", i64 0
  %v38 = add i64 0, 9
  %v39 = add i64 0, 0
  %v40 = getelementptr i64, ptr %s3, i64 0
  %v41 = ptrtoint ptr %v37 to i64
  %st20 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st20
  %st21 = getelementptr i64, ptr %v40, i64 1
  store i64 %v38, ptr %st21
  %st22 = getelementptr i64, ptr %v40, i64 2
  store i64 %v39, ptr %st22
  br label %b11
b7:
  %v50.p = getelementptr i64, ptr %v6, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 5
  %v52.c = icmp eq i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b7 = icmp ne i64 %v52, 0
  br i1 %c.b7, label %b7.t24, label %b7.e25
b7.t24:
  br label %b10
b7.e25:
  br label %b9
b8:
  %v45 = getelementptr i64, ptr @"str.6", i64 0
  %v46 = add i64 0, 7
  %v47 = add i64 0, 0
  %v48 = getelementptr i64, ptr %s4, i64 0
  %v49 = ptrtoint ptr %v45 to i64
  %st25 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st25
  %st26 = getelementptr i64, ptr %v48, i64 1
  store i64 %v46, ptr %st26
  %st27 = getelementptr i64, ptr %v48, i64 2
  store i64 %v47, ptr %st27
  br label %b11
b9:
  %v78 = add i64 0, 4
  call void @"rt.panic"(i64 %v78)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v53.p = getelementptr i64, ptr %v6, i64 1
  %v53 = load i64, ptr %v53.p
  %v54 = getelementptr i64, ptr @"str.2", i64 0
  %v55 = add i64 0, 6
  %v56 = add i64 0, 0
  %v57 = getelementptr i64, ptr %s5, i64 0
  %v58 = ptrtoint ptr %v54 to i64
  %st28 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st28
  %st29 = getelementptr i64, ptr %v57, i64 1
  store i64 %v55, ptr %st29
  %st30 = getelementptr i64, ptr %v57, i64 2
  store i64 %v56, ptr %st30
  %v59 = getelementptr i64, ptr %s6, i64 0
  call void @"std/convert.FormatInt"(ptr %v59, i64 %v53)
  %v60 = add i64 0, 0
  %v61.p = getelementptr i64, ptr %v57, i64 1
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 %v60, %v61
  %v63.p = getelementptr i64, ptr %v59, i64 1
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 %v62, %v63
  %v65.p = getelementptr i64, ptr %v57, i64 1
  %v65 = load i64, ptr %v65.p
  %v66 = sub i64 %v64, %v65
  %v67.p = getelementptr i64, ptr %v57, i64 0
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v57, i64 1
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v57, i64 2
  %v69 = load i64, ptr %v69.p
  %v70 = call ptr @"rt.cat8"(i64 %v67, i64 %v68, i64 %v69, i64 %v17, i64 %v66)
  %v71.p = getelementptr i64, ptr %v59, i64 1
  %v71 = load i64, ptr %v71.p
  %v72 = getelementptr i8, ptr %v70, i64 %v65
  %v73.p = getelementptr i64, ptr %v59, i64 0
  %v73 = load i64, ptr %v73.p
  %v74 = inttoptr i64 %v73 to ptr
  call void @"rt.copy8"(ptr %v72, ptr %v74, i64 %v71)
  %v75 = add i64 %v65, %v71
  %v76 = getelementptr i64, ptr %s7, i64 0
  %v77 = ptrtoint ptr %v70 to i64
  %st31 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st31
  %st32 = getelementptr i64, ptr %v76, i64 1
  store i64 %v64, ptr %st32
  %st33 = getelementptr i64, ptr %v76, i64 2
  store i64 %v17, ptr %st33
  br label %b11
b11:
  %v79 = phi ptr [ %v24, %b2 ], [ %v32, %b4 ], [ %v40, %b6 ], [ %v48, %b8 ], [ %v76, %b10 ]
  %v80.p = getelementptr i64, ptr %v79, i64 0
  %v80 = load i64, ptr %v80.p
  %st34 = getelementptr i64, ptr %v0, i64 0
  store i64 %v80, ptr %st34
  %v81.p = getelementptr i64, ptr %v79, i64 1
  %v81 = load i64, ptr %v81.p
  %st35 = getelementptr i64, ptr %v0, i64 1
  store i64 %v81, ptr %st35
  %v82.p = getelementptr i64, ptr %v79, i64 2
  %v82 = load i64, ptr %v82.p
  %st36 = getelementptr i64, ptr %v0, i64 2
  store i64 %v82, ptr %st36
  call void @"rt.region_relocate8"(ptr %v0, i64 %v7)
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v84, i64 0
  store i64 %v7, ptr %st37
  ret void
}

define internal void @"main.main"() #0 {
b0:
  %s0 = alloca [7 x i64], align 8
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
  %s6 = alloca [7 x i64], align 8
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
  %s6.z6 = getelementptr i64, ptr %s6, i64 6
  store i64 0, ptr %s6.z6
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
  %s10 = alloca [7 x i64], align 8
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
  %s10.z6 = getelementptr i64, ptr %s10, i64 6
  store i64 0, ptr %s10.z6
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
  %s15 = alloca [1 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s16 = alloca [7 x i64], align 8
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
  %s16.z6 = getelementptr i64, ptr %s16, i64 6
  store i64 0, ptr %s16.z6
  %s17 = alloca [3 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s17.z1 = getelementptr i64, ptr %s17, i64 1
  store i64 0, ptr %s17.z1
  %s17.z2 = getelementptr i64, ptr %s17, i64 2
  store i64 0, ptr %s17.z2
  %v262 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v262, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = call i64 @"main.fds"()
  %v2 = getelementptr i64, ptr %s0, i64 0
  %v3 = getelementptr i64, ptr @"str.12", i64 0
  %v4 = add i64 0, 21
  %v5 = add i64 0, 0
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7 = ptrtoint ptr %v3 to i64
  %st0 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st0
  %st1 = getelementptr i64, ptr %v6, i64 1
  store i64 %v4, ptr %st1
  %st2 = getelementptr i64, ptr %v6, i64 2
  store i64 %v5, ptr %st2
  %v8.p = getelementptr i64, ptr %v6, i64 0
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v6, i64 1
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v6, i64 2
  %v10 = load i64, ptr %v10.p
  call void @"main.sizeOf"(ptr %v2, i64 %v8, i64 %v9, i64 %v10)
  %v11.p = getelementptr i64, ptr %v2, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 1
  %v13 = getelementptr i64, ptr %v2, i64 %v12
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15.p = getelementptr i64, ptr %v13, i64 0
  %v15 = load i64, ptr %v15.p
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st3
  %v16.p = getelementptr i64, ptr %v13, i64 1
  %v16 = load i64, ptr %v16.p
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st4
  %v17.p = getelementptr i64, ptr %v13, i64 2
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st5
  %v18.p = getelementptr i64, ptr %v13, i64 3
  %v18 = load i64, ptr %v18.p
  %st6 = getelementptr i64, ptr %v14, i64 3
  store i64 %v18, ptr %st6
  %v19.p = getelementptr i64, ptr %v13, i64 4
  %v19 = load i64, ptr %v19.p
  %st7 = getelementptr i64, ptr %v14, i64 4
  store i64 %v19, ptr %st7
  %v20.p = getelementptr i64, ptr %v13, i64 5
  %v20 = load i64, ptr %v20.p
  %st8 = getelementptr i64, ptr %v14, i64 5
  store i64 %v20, ptr %st8
  %v21.p = getelementptr i64, ptr %v14, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 0, 0
  %v23.c = icmp eq i64 %v21, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b0 = icmp ne i64 %v23, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v24 = getelementptr i64, ptr @"str.19", i64 0
  %v25 = add i64 0, 11
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s1, i64 0
  %v28 = ptrtoint ptr %v24 to i64
  %st11 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st11
  %st12 = getelementptr i64, ptr %v27, i64 1
  store i64 %v25, ptr %st12
  %st13 = getelementptr i64, ptr %v27, i64 2
  store i64 %v26, ptr %st13
  %v29 = getelementptr i64, ptr %s3, i64 0
  call void @"std/convert.FormatInt"(ptr %v29, i64 %v11)
  %v30 = getelementptr i64, ptr @"str.5", i64 0
  %v31 = add i64 0, 6
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34 = ptrtoint ptr %v30 to i64
  %st14 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st14
  %st15 = getelementptr i64, ptr %v33, i64 1
  store i64 %v31, ptr %st15
  %st16 = getelementptr i64, ptr %v33, i64 2
  store i64 %v32, ptr %st16
  %v35 = add i64 0, 0
  %v36.p = getelementptr i64, ptr %v27, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 %v35, %v36
  %v38.p = getelementptr i64, ptr %v29, i64 1
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 %v37, %v38
  %v40.p = getelementptr i64, ptr %v33, i64 1
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 %v39, %v40
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v263, i64 0
  %v42 = load i64, ptr %v42.p
  %v43.p = getelementptr i64, ptr %v27, i64 1
  %v43 = load i64, ptr %v43.p
  %v44 = sub i64 %v41, %v43
  %v45.p = getelementptr i64, ptr %v27, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v27, i64 1
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v27, i64 2
  %v47 = load i64, ptr %v47.p
  %v48 = call ptr @"rt.cat8"(i64 %v45, i64 %v46, i64 %v47, i64 %v42, i64 %v44)
  %v49.p = getelementptr i64, ptr %v29, i64 1
  %v49 = load i64, ptr %v49.p
  %v50 = getelementptr i8, ptr %v48, i64 %v43
  %v51.p = getelementptr i64, ptr %v29, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  call void @"rt.copy8"(ptr %v50, ptr %v52, i64 %v49)
  %v53 = add i64 %v43, %v49
  %v54.p = getelementptr i64, ptr %v33, i64 1
  %v54 = load i64, ptr %v54.p
  %v55 = getelementptr i8, ptr %v48, i64 %v53
  %v56.p = getelementptr i64, ptr %v33, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = inttoptr i64 %v56 to ptr
  call void @"rt.copy8"(ptr %v55, ptr %v57, i64 %v54)
  %v58 = add i64 %v53, %v54
  %v59 = getelementptr i64, ptr %s5, i64 0
  %v60 = ptrtoint ptr %v48 to i64
  %st17 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st17
  %st18 = getelementptr i64, ptr %v59, i64 1
  store i64 %v41, ptr %st18
  %st19 = getelementptr i64, ptr %v59, i64 2
  store i64 %v42, ptr %st19
  call void @"rt.print_str"(ptr %v59)
  %v61 = add i64 0, 10
  call void @"rt.print_char"(i64 %v61)
  br label %b3
b2:
  br label %b3
b3:
  %v62 = getelementptr i64, ptr %s6, i64 0
  %v63 = getelementptr i64, ptr @"str.13", i64 0
  %v64 = add i64 0, 23
  %v65 = add i64 0, 0
  %v66 = getelementptr i64, ptr %s5, i64 0
  %v67 = ptrtoint ptr %v63 to i64
  %st20 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st20
  %st21 = getelementptr i64, ptr %v66, i64 1
  store i64 %v64, ptr %st21
  %st22 = getelementptr i64, ptr %v66, i64 2
  store i64 %v65, ptr %st22
  %v68.p = getelementptr i64, ptr %v66, i64 0
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v66, i64 1
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v66, i64 2
  %v70 = load i64, ptr %v70.p
  call void @"main.sizeOf"(ptr %v62, i64 %v68, i64 %v69, i64 %v70)
  %v71.p = getelementptr i64, ptr %v62, i64 0
  %v71 = load i64, ptr %v71.p
  %v72 = add i64 0, 1
  %v73 = getelementptr i64, ptr %v62, i64 %v72
  %v74 = getelementptr i64, ptr %s7, i64 0
  %v75.p = getelementptr i64, ptr %v73, i64 0
  %v75 = load i64, ptr %v75.p
  %st23 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st23
  %v76.p = getelementptr i64, ptr %v73, i64 1
  %v76 = load i64, ptr %v76.p
  %st24 = getelementptr i64, ptr %v74, i64 1
  store i64 %v76, ptr %st24
  %v77.p = getelementptr i64, ptr %v73, i64 2
  %v77 = load i64, ptr %v77.p
  %st25 = getelementptr i64, ptr %v74, i64 2
  store i64 %v77, ptr %st25
  %v78.p = getelementptr i64, ptr %v73, i64 3
  %v78 = load i64, ptr %v78.p
  %st26 = getelementptr i64, ptr %v74, i64 3
  store i64 %v78, ptr %st26
  %v79.p = getelementptr i64, ptr %v73, i64 4
  %v79 = load i64, ptr %v79.p
  %st27 = getelementptr i64, ptr %v74, i64 4
  store i64 %v79, ptr %st27
  %v80.p = getelementptr i64, ptr %v73, i64 5
  %v80 = load i64, ptr %v80.p
  %st28 = getelementptr i64, ptr %v74, i64 5
  store i64 %v80, ptr %st28
  %v81.p = getelementptr i64, ptr %v74, i64 0
  %v81 = load i64, ptr %v81.p
  %v82 = add i64 0, 0
  %v83.c = icmp ne i64 %v81, %v82
  %v83 = zext i1 %v83.c to i64
  %c.b3 = icmp ne i64 %v83, 0
  br i1 %c.b3, label %b3.t30, label %b3.e31
b3.t30:
  br label %b4
b3.e31:
  br label %b5
b4:
  %v84 = add i64 0, 1
  %v85 = getelementptr i64, ptr %v74, i64 %v84
  %v86 = getelementptr i64, ptr %s8, i64 0
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %st31 = getelementptr i64, ptr %v86, i64 0
  store i64 %v87, ptr %st31
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %st32 = getelementptr i64, ptr %v86, i64 1
  store i64 %v88, ptr %st32
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %st33 = getelementptr i64, ptr %v86, i64 2
  store i64 %v89, ptr %st33
  %v90.p = getelementptr i64, ptr %v85, i64 3
  %v90 = load i64, ptr %v90.p
  %st34 = getelementptr i64, ptr %v86, i64 3
  store i64 %v90, ptr %st34
  %v91.p = getelementptr i64, ptr %v85, i64 4
  %v91 = load i64, ptr %v91.p
  %st35 = getelementptr i64, ptr %v86, i64 4
  store i64 %v91, ptr %st35
  %v92 = getelementptr i64, ptr %s9, i64 0
  %v93.p = getelementptr i64, ptr %v86, i64 0
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v86, i64 1
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v86, i64 2
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v86, i64 3
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v86, i64 4
  %v97 = load i64, ptr %v97.p
  call void @"main.why"(ptr %v92, i64 %v93, i64 %v94, i64 %v95, i64 %v96, i64 %v97)
  %v98 = getelementptr i64, ptr %s5, i64 0
  %v99.p = getelementptr i64, ptr %v92, i64 0
  %v99 = load i64, ptr %v99.p
  %st36 = getelementptr i64, ptr %v98, i64 0
  store i64 %v99, ptr %st36
  %v100.p = getelementptr i64, ptr %v92, i64 1
  %v100 = load i64, ptr %v100.p
  %st37 = getelementptr i64, ptr %v98, i64 1
  store i64 %v100, ptr %st37
  %v101.p = getelementptr i64, ptr %v92, i64 2
  %v101 = load i64, ptr %v101.p
  %st38 = getelementptr i64, ptr %v98, i64 2
  store i64 %v101, ptr %st38
  %v102 = getelementptr i64, ptr @"str.7", i64 0
  %v103 = add i64 0, 13
  %v104 = add i64 0, 0
  %v105 = getelementptr i64, ptr %s4, i64 0
  %v106 = ptrtoint ptr %v102 to i64
  %st39 = getelementptr i64, ptr %v105, i64 0
  store i64 %v106, ptr %st39
  %st40 = getelementptr i64, ptr %v105, i64 1
  store i64 %v103, ptr %st40
  %st41 = getelementptr i64, ptr %v105, i64 2
  store i64 %v104, ptr %st41
  %v107 = add i64 0, 0
  %v108.p = getelementptr i64, ptr %v105, i64 1
  %v108 = load i64, ptr %v108.p
  %v109 = add i64 %v107, %v108
  %v110.p = getelementptr i64, ptr %v98, i64 1
  %v110 = load i64, ptr %v110.p
  %v111 = add i64 %v109, %v110
  %v264 = getelementptr i64, ptr @"rt.meta", i64 0
  %v112.p = getelementptr i64, ptr %v264, i64 0
  %v112 = load i64, ptr %v112.p
  %v113.p = getelementptr i64, ptr %v105, i64 1
  %v113 = load i64, ptr %v113.p
  %v114 = sub i64 %v111, %v113
  %v115.p = getelementptr i64, ptr %v105, i64 0
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v105, i64 1
  %v116 = load i64, ptr %v116.p
  %v117.p = getelementptr i64, ptr %v105, i64 2
  %v117 = load i64, ptr %v117.p
  %v118 = call ptr @"rt.cat8"(i64 %v115, i64 %v116, i64 %v117, i64 %v112, i64 %v114)
  %v119.p = getelementptr i64, ptr %v98, i64 1
  %v119 = load i64, ptr %v119.p
  %v120 = getelementptr i8, ptr %v118, i64 %v113
  %v121.p = getelementptr i64, ptr %v98, i64 0
  %v121 = load i64, ptr %v121.p
  %v122 = inttoptr i64 %v121 to ptr
  call void @"rt.copy8"(ptr %v120, ptr %v122, i64 %v119)
  %v123 = add i64 %v113, %v119
  %v124 = getelementptr i64, ptr %s1, i64 0
  %v125 = ptrtoint ptr %v118 to i64
  %st42 = getelementptr i64, ptr %v124, i64 0
  store i64 %v125, ptr %st42
  %st43 = getelementptr i64, ptr %v124, i64 1
  store i64 %v111, ptr %st43
  %st44 = getelementptr i64, ptr %v124, i64 2
  store i64 %v112, ptr %st44
  call void @"rt.print_str"(ptr %v124)
  %v126 = add i64 0, 10
  call void @"rt.print_char"(i64 %v126)
  br label %b6
b5:
  br label %b6
b6:
  %v127 = getelementptr i64, ptr %s10, i64 0
  %v128 = getelementptr i64, ptr @"str.10", i64 0
  %v129 = add i64 0, 11
  %v130 = add i64 0, 0
  %v131 = getelementptr i64, ptr %s1, i64 0
  %v132 = ptrtoint ptr %v128 to i64
  %st45 = getelementptr i64, ptr %v131, i64 0
  store i64 %v132, ptr %st45
  %st46 = getelementptr i64, ptr %v131, i64 1
  store i64 %v129, ptr %st46
  %st47 = getelementptr i64, ptr %v131, i64 2
  store i64 %v130, ptr %st47
  %v133.p = getelementptr i64, ptr %v131, i64 0
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v131, i64 1
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v131, i64 2
  %v135 = load i64, ptr %v135.p
  call void @"main.sizeOf"(ptr %v127, i64 %v133, i64 %v134, i64 %v135)
  %v136.p = getelementptr i64, ptr %v127, i64 0
  %v136 = load i64, ptr %v136.p
  %v137 = add i64 0, 1
  %v138 = getelementptr i64, ptr %v127, i64 %v137
  %v139 = getelementptr i64, ptr %s11, i64 0
  %v140.p = getelementptr i64, ptr %v138, i64 0
  %v140 = load i64, ptr %v140.p
  %st48 = getelementptr i64, ptr %v139, i64 0
  store i64 %v140, ptr %st48
  %v141.p = getelementptr i64, ptr %v138, i64 1
  %v141 = load i64, ptr %v141.p
  %st49 = getelementptr i64, ptr %v139, i64 1
  store i64 %v141, ptr %st49
  %v142.p = getelementptr i64, ptr %v138, i64 2
  %v142 = load i64, ptr %v142.p
  %st50 = getelementptr i64, ptr %v139, i64 2
  store i64 %v142, ptr %st50
  %v143.p = getelementptr i64, ptr %v138, i64 3
  %v143 = load i64, ptr %v143.p
  %st51 = getelementptr i64, ptr %v139, i64 3
  store i64 %v143, ptr %st51
  %v144.p = getelementptr i64, ptr %v138, i64 4
  %v144 = load i64, ptr %v144.p
  %st52 = getelementptr i64, ptr %v139, i64 4
  store i64 %v144, ptr %st52
  %v145.p = getelementptr i64, ptr %v138, i64 5
  %v145 = load i64, ptr %v145.p
  %st53 = getelementptr i64, ptr %v139, i64 5
  store i64 %v145, ptr %st53
  %v146.p = getelementptr i64, ptr %v139, i64 0
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 0, 0
  %v148.c = icmp ne i64 %v146, %v147
  %v148 = zext i1 %v148.c to i64
  %c.b6 = icmp ne i64 %v148, 0
  br i1 %c.b6, label %b6.t55, label %b6.e56
b6.t55:
  br label %b7
b6.e56:
  br label %b8
b7:
  %v149 = add i64 0, 1
  %v150 = getelementptr i64, ptr %v139, i64 %v149
  %v151 = getelementptr i64, ptr %s8, i64 0
  %v152.p = getelementptr i64, ptr %v150, i64 0
  %v152 = load i64, ptr %v152.p
  %st56 = getelementptr i64, ptr %v151, i64 0
  store i64 %v152, ptr %st56
  %v153.p = getelementptr i64, ptr %v150, i64 1
  %v153 = load i64, ptr %v153.p
  %st57 = getelementptr i64, ptr %v151, i64 1
  store i64 %v153, ptr %st57
  %v154.p = getelementptr i64, ptr %v150, i64 2
  %v154 = load i64, ptr %v154.p
  %st58 = getelementptr i64, ptr %v151, i64 2
  store i64 %v154, ptr %st58
  %v155.p = getelementptr i64, ptr %v150, i64 3
  %v155 = load i64, ptr %v155.p
  %st59 = getelementptr i64, ptr %v151, i64 3
  store i64 %v155, ptr %st59
  %v156.p = getelementptr i64, ptr %v150, i64 4
  %v156 = load i64, ptr %v156.p
  %st60 = getelementptr i64, ptr %v151, i64 4
  store i64 %v156, ptr %st60
  %v157 = getelementptr i64, ptr %s12, i64 0
  %v158.p = getelementptr i64, ptr %v151, i64 0
  %v158 = load i64, ptr %v158.p
  %v159.p = getelementptr i64, ptr %v151, i64 1
  %v159 = load i64, ptr %v159.p
  %v160.p = getelementptr i64, ptr %v151, i64 2
  %v160 = load i64, ptr %v160.p
  %v161.p = getelementptr i64, ptr %v151, i64 3
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v151, i64 4
  %v162 = load i64, ptr %v162.p
  call void @"main.why"(ptr %v157, i64 %v158, i64 %v159, i64 %v160, i64 %v161, i64 %v162)
  %v163 = getelementptr i64, ptr %s1, i64 0
  %v164.p = getelementptr i64, ptr %v157, i64 0
  %v164 = load i64, ptr %v164.p
  %st61 = getelementptr i64, ptr %v163, i64 0
  store i64 %v164, ptr %st61
  %v165.p = getelementptr i64, ptr %v157, i64 1
  %v165 = load i64, ptr %v165.p
  %st62 = getelementptr i64, ptr %v163, i64 1
  store i64 %v165, ptr %st62
  %v166.p = getelementptr i64, ptr %v157, i64 2
  %v166 = load i64, ptr %v166.p
  %st63 = getelementptr i64, ptr %v163, i64 2
  store i64 %v166, ptr %st63
  %v167 = getelementptr i64, ptr @"str.11", i64 0
  %v168 = add i64 0, 13
  %v169 = add i64 0, 0
  %v170 = getelementptr i64, ptr %s4, i64 0
  %v171 = ptrtoint ptr %v167 to i64
  %st64 = getelementptr i64, ptr %v170, i64 0
  store i64 %v171, ptr %st64
  %st65 = getelementptr i64, ptr %v170, i64 1
  store i64 %v168, ptr %st65
  %st66 = getelementptr i64, ptr %v170, i64 2
  store i64 %v169, ptr %st66
  %v172 = add i64 0, 0
  %v173.p = getelementptr i64, ptr %v170, i64 1
  %v173 = load i64, ptr %v173.p
  %v174 = add i64 %v172, %v173
  %v175.p = getelementptr i64, ptr %v163, i64 1
  %v175 = load i64, ptr %v175.p
  %v176 = add i64 %v174, %v175
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %v177.p = getelementptr i64, ptr %v265, i64 0
  %v177 = load i64, ptr %v177.p
  %v178.p = getelementptr i64, ptr %v170, i64 1
  %v178 = load i64, ptr %v178.p
  %v179 = sub i64 %v176, %v178
  %v180.p = getelementptr i64, ptr %v170, i64 0
  %v180 = load i64, ptr %v180.p
  %v181.p = getelementptr i64, ptr %v170, i64 1
  %v181 = load i64, ptr %v181.p
  %v182.p = getelementptr i64, ptr %v170, i64 2
  %v182 = load i64, ptr %v182.p
  %v183 = call ptr @"rt.cat8"(i64 %v180, i64 %v181, i64 %v182, i64 %v177, i64 %v179)
  %v184.p = getelementptr i64, ptr %v163, i64 1
  %v184 = load i64, ptr %v184.p
  %v185 = getelementptr i8, ptr %v183, i64 %v178
  %v186.p = getelementptr i64, ptr %v163, i64 0
  %v186 = load i64, ptr %v186.p
  %v187 = inttoptr i64 %v186 to ptr
  call void @"rt.copy8"(ptr %v185, ptr %v187, i64 %v184)
  %v188 = add i64 %v178, %v184
  %v189 = getelementptr i64, ptr %s5, i64 0
  %v190 = ptrtoint ptr %v183 to i64
  %st67 = getelementptr i64, ptr %v189, i64 0
  store i64 %v190, ptr %st67
  %st68 = getelementptr i64, ptr %v189, i64 1
  store i64 %v176, ptr %st68
  %st69 = getelementptr i64, ptr %v189, i64 2
  store i64 %v177, ptr %st69
  call void @"rt.print_str"(ptr %v189)
  %v191 = add i64 0, 10
  call void @"rt.print_char"(i64 %v191)
  br label %b9
b8:
  br label %b9
b9:
  %v192 = getelementptr i64, ptr %s13, i64 0
  %v193 = getelementptr i64, ptr @"str.12", i64 0
  %v194 = add i64 0, 21
  %v195 = add i64 0, 0
  %v196 = getelementptr i64, ptr %s5, i64 0
  %v197 = ptrtoint ptr %v193 to i64
  %st70 = getelementptr i64, ptr %v196, i64 0
  store i64 %v197, ptr %st70
  %st71 = getelementptr i64, ptr %v196, i64 1
  store i64 %v194, ptr %st71
  %st72 = getelementptr i64, ptr %v196, i64 2
  store i64 %v195, ptr %st72
  %v198.p = getelementptr i64, ptr %v196, i64 0
  %v198 = load i64, ptr %v198.p
  %v199.p = getelementptr i64, ptr %v196, i64 1
  %v199 = load i64, ptr %v199.p
  %v200.p = getelementptr i64, ptr %v196, i64 2
  %v200 = load i64, ptr %v200.p
  call void @"main.firstLine"(ptr %v192, i64 %v198, i64 %v199, i64 %v200)
  call void @"rt.print_str"(ptr %v192)
  %v201 = add i64 0, 10
  call void @"rt.print_char"(i64 %v201)
  %v202 = getelementptr i64, ptr %s14, i64 0
  %v203 = getelementptr i64, ptr @"str.13", i64 0
  %v204 = add i64 0, 23
  %v205 = add i64 0, 0
  %v206 = getelementptr i64, ptr %s5, i64 0
  %v207 = ptrtoint ptr %v203 to i64
  %st73 = getelementptr i64, ptr %v206, i64 0
  store i64 %v207, ptr %st73
  %st74 = getelementptr i64, ptr %v206, i64 1
  store i64 %v204, ptr %st74
  %st75 = getelementptr i64, ptr %v206, i64 2
  store i64 %v205, ptr %st75
  %v208.p = getelementptr i64, ptr %v206, i64 0
  %v208 = load i64, ptr %v208.p
  %v209.p = getelementptr i64, ptr %v206, i64 1
  %v209 = load i64, ptr %v209.p
  %v210.p = getelementptr i64, ptr %v206, i64 2
  %v210 = load i64, ptr %v210.p
  call void @"main.firstLine"(ptr %v202, i64 %v208, i64 %v209, i64 %v210)
  call void @"rt.print_str"(ptr %v202)
  %v211 = add i64 0, 10
  call void @"rt.print_char"(i64 %v211)
  %v212 = add i64 0, 0
  %v213 = getelementptr i64, ptr %s15, i64 0
  %st76 = getelementptr i64, ptr %v213, i64 0
  store i64 %v212, ptr %st76
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %v214.p = getelementptr i64, ptr %v266, i64 0
  %v214 = load i64, ptr %v214.p
  br label %b10
b10:
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %st77 = getelementptr i64, ptr %v267, i64 0
  store i64 %v214, ptr %st77
  %v215.p = getelementptr i64, ptr %v213, i64 0
  %v215 = load i64, ptr %v215.p
  %v216 = add i64 0, 100
  %v217.c = icmp slt i64 %v215, %v216
  %v217 = zext i1 %v217.c to i64
  %c.b10 = icmp ne i64 %v217, 0
  br i1 %c.b10, label %b10.t79, label %b10.e80
b10.t79:
  br label %b11
b10.e80:
  br label %b12
b11:
  call void @"rt.region_enter"()
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v218.p = getelementptr i64, ptr %v268, i64 0
  %v218 = load i64, ptr %v218.p
  %v219 = getelementptr i64, ptr %s16, i64 0
  %v220 = getelementptr i64, ptr @"str.12", i64 0
  %v221 = add i64 0, 21
  %v222 = add i64 0, 0
  %v223 = getelementptr i64, ptr %s5, i64 0
  %v224 = ptrtoint ptr %v220 to i64
  %st80 = getelementptr i64, ptr %v223, i64 0
  store i64 %v224, ptr %st80
  %st81 = getelementptr i64, ptr %v223, i64 1
  store i64 %v221, ptr %st81
  %st82 = getelementptr i64, ptr %v223, i64 2
  store i64 %v222, ptr %st82
  %v225.p = getelementptr i64, ptr %v223, i64 0
  %v225 = load i64, ptr %v225.p
  %v226.p = getelementptr i64, ptr %v223, i64 1
  %v226 = load i64, ptr %v226.p
  %v227.p = getelementptr i64, ptr %v223, i64 2
  %v227 = load i64, ptr %v227.p
  call void @"main.sizeOf"(ptr %v219, i64 %v225, i64 %v226, i64 %v227)
  %v228.p = getelementptr i64, ptr %v219, i64 0
  %v228 = load i64, ptr %v228.p
  %v229 = add i64 0, 1
  %v230 = getelementptr i64, ptr %v219, i64 %v229
  %v231 = add i64 0, 1
  %v232.p = getelementptr i64, ptr %v213, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = add i64 %v232, %v231
  %st83 = getelementptr i64, ptr %v213, i64 0
  store i64 %v233, ptr %st83
  br label %b10
b12:
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v269, i64 0
  store i64 %v214, ptr %st84
  %v234 = call i64 @"main.fds"()
  %v235 = sub i64 %v234, %v1
  %v236 = getelementptr i64, ptr @"str.17", i64 0
  %v237 = add i64 0, 16
  %v238 = add i64 0, 0
  %v239 = getelementptr i64, ptr %s5, i64 0
  %v240 = ptrtoint ptr %v236 to i64
  %st85 = getelementptr i64, ptr %v239, i64 0
  store i64 %v240, ptr %st85
  %st86 = getelementptr i64, ptr %v239, i64 1
  store i64 %v237, ptr %st86
  %st87 = getelementptr i64, ptr %v239, i64 2
  store i64 %v238, ptr %st87
  %v241 = getelementptr i64, ptr %s17, i64 0
  call void @"std/convert.FormatInt"(ptr %v241, i64 %v235)
  %v242 = add i64 0, 0
  %v243.p = getelementptr i64, ptr %v239, i64 1
  %v243 = load i64, ptr %v243.p
  %v244 = add i64 %v242, %v243
  %v245.p = getelementptr i64, ptr %v241, i64 1
  %v245 = load i64, ptr %v245.p
  %v246 = add i64 %v244, %v245
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %v247.p = getelementptr i64, ptr %v270, i64 0
  %v247 = load i64, ptr %v247.p
  %v248.p = getelementptr i64, ptr %v239, i64 1
  %v248 = load i64, ptr %v248.p
  %v249 = sub i64 %v246, %v248
  %v250.p = getelementptr i64, ptr %v239, i64 0
  %v250 = load i64, ptr %v250.p
  %v251.p = getelementptr i64, ptr %v239, i64 1
  %v251 = load i64, ptr %v251.p
  %v252.p = getelementptr i64, ptr %v239, i64 2
  %v252 = load i64, ptr %v252.p
  %v253 = call ptr @"rt.cat8"(i64 %v250, i64 %v251, i64 %v252, i64 %v247, i64 %v249)
  %v254.p = getelementptr i64, ptr %v241, i64 1
  %v254 = load i64, ptr %v254.p
  %v255 = getelementptr i8, ptr %v253, i64 %v248
  %v256.p = getelementptr i64, ptr %v241, i64 0
  %v256 = load i64, ptr %v256.p
  %v257 = inttoptr i64 %v256 to ptr
  call void @"rt.copy8"(ptr %v255, ptr %v257, i64 %v254)
  %v258 = add i64 %v248, %v254
  %v259 = getelementptr i64, ptr %s4, i64 0
  %v260 = ptrtoint ptr %v253 to i64
  %st88 = getelementptr i64, ptr %v259, i64 0
  store i64 %v260, ptr %st88
  %st89 = getelementptr i64, ptr %v259, i64 1
  store i64 %v246, ptr %st89
  %st90 = getelementptr i64, ptr %v259, i64 2
  store i64 %v247, ptr %st90
  call void @"rt.print_str"(ptr %v259)
  %v261 = add i64 0, 10
  call void @"rt.print_char"(i64 %v261)
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v271, i64 0
  store i64 %v0, ptr %st91
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
  %v30 = add i64 0, 1
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
  %v44 = add i64 0, 2
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
  %v56 = add i64 0, 5
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
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v105, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2571
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v6, i64 2571
  store i64 %v8, ptr %st3
  %v9 = add i64 0, 1
  %v10.c = icmp sge i64 %v7, %v9
  %v10 = zext i1 %v10.c to i64
  %v11.c = icmp sle i64 %v7, %v5
  %v11 = zext i1 %v11.c to i64
  %v12 = and i64 %v10, %v11
  %v13 = sub i64 %v7, %v5
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v5, %v14
  call void @"rt.region_enter"()
  %v16 = add i64 0, 0
  %v17 = add i64 0, 0
  %v18.c = icmp ne i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v19 = add i64 0, 1
  %v20 = add i64 0, 0
  %v21 = sub i64 %v20, %v19
  %v22 = getelementptr i64, ptr %s1, i64 0
  %v23 = add i64 0, 0
  %v24 = getelementptr i64, ptr %s2, i64 0
  %v25 = getelementptr i64, ptr %s3, i64 0
  %v26 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st6
  %st7 = getelementptr i64, ptr %v25, i64 0
  store i64 %v21, ptr %st7
  %v27 = getelementptr i64, ptr %s4, i64 0
  %v28 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st8
  %st9 = getelementptr i64, ptr %v27, i64 1
  store i64 %v28, ptr %st9
  %v29 = add i64 0, 3
  %st10 = getelementptr i64, ptr %v27, i64 0
  store i64 %v29, ptr %st10
  %v30 = getelementptr i64, ptr %s5, i64 0
  %v31.p = getelementptr i64, ptr %v27, i64 0
  %v31 = load i64, ptr %v31.p
  %st11 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st11
  %v32.p = getelementptr i64, ptr %v27, i64 1
  %v32 = load i64, ptr %v32.p
  %st12 = getelementptr i64, ptr %v30, i64 1
  store i64 %v32, ptr %st12
  %v33 = add i64 0, 0
  %st13 = getelementptr i64, ptr %v30, i64 2
  store i64 %v33, ptr %st13
  %st14 = getelementptr i64, ptr %v30, i64 3
  store i64 %v33, ptr %st14
  %st15 = getelementptr i64, ptr %v30, i64 4
  store i64 %v33, ptr %st15
  %v34 = getelementptr i64, ptr %s6, i64 0
  %v35 = add i64 0, 1
  %st16 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st16
  %v36.p = getelementptr i64, ptr %v30, i64 0
  %v36 = load i64, ptr %v36.p
  %st17 = getelementptr i64, ptr %v34, i64 1
  store i64 %v36, ptr %st17
  %v37.p = getelementptr i64, ptr %v30, i64 1
  %v37 = load i64, ptr %v37.p
  %st18 = getelementptr i64, ptr %v34, i64 2
  store i64 %v37, ptr %st18
  %v38.p = getelementptr i64, ptr %v30, i64 2
  %v38 = load i64, ptr %v38.p
  %st19 = getelementptr i64, ptr %v34, i64 3
  store i64 %v38, ptr %st19
  %v39.p = getelementptr i64, ptr %v30, i64 3
  %v39 = load i64, ptr %v39.p
  %st20 = getelementptr i64, ptr %v34, i64 4
  store i64 %v39, ptr %st20
  %v40.p = getelementptr i64, ptr %v30, i64 4
  %v40 = load i64, ptr %v40.p
  %st21 = getelementptr i64, ptr %v34, i64 5
  store i64 %v40, ptr %st21
  %v41.p = getelementptr i64, ptr %v25, i64 0
  %v41 = load i64, ptr %v41.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v41, ptr %st22
  %v42.p = getelementptr i64, ptr %v34, i64 0
  %v42 = load i64, ptr %v42.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v42, ptr %st23
  %v43.p = getelementptr i64, ptr %v34, i64 1
  %v43 = load i64, ptr %v43.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v43, ptr %st24
  %v44.p = getelementptr i64, ptr %v34, i64 2
  %v44 = load i64, ptr %v44.p
  %st25 = getelementptr i64, ptr %v0, i64 3
  store i64 %v44, ptr %st25
  %v45.p = getelementptr i64, ptr %v34, i64 3
  %v45 = load i64, ptr %v45.p
  %st26 = getelementptr i64, ptr %v0, i64 4
  store i64 %v45, ptr %st26
  %v46.p = getelementptr i64, ptr %v34, i64 4
  %v46 = load i64, ptr %v46.p
  %st27 = getelementptr i64, ptr %v0, i64 5
  store i64 %v46, ptr %st27
  %v47.p = getelementptr i64, ptr %v34, i64 5
  %v47 = load i64, ptr %v47.p
  %st28 = getelementptr i64, ptr %v0, i64 6
  store i64 %v47, ptr %st28
  %v48.p = getelementptr i64, ptr %v0, i64 1
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 0
  %v50.c = icmp ne i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b1 = icmp ne i64 %v50, 0
  br i1 %c.b1, label %b1.t30, label %b1.e31
b1.t30:
  br label %b3
b1.e31:
  br label %b4
b2:
  br label %b5
b3:
  %v51 = add i64 0, 2
  %v52 = getelementptr i64, ptr %v0, i64 %v51
  call void @"rt.err_relocate"(ptr %v52, i64 %v5)
  br label %b4
b4:
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v106, i64 0
  store i64 %v5, ptr %st31
  ret void
b5:
  %v53 = call i64 @"rt.open"(ptr %v4)
  %v54 = add i64 0, 0
  %v55.c = icmp slt i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b5 = icmp ne i64 %v55, 0
  br i1 %c.b5, label %b5.t33, label %b5.e34
b5.t33:
  br label %b6
b5.e34:
  br label %b7
b6:
  %v56 = add i64 0, 1
  %v57 = add i64 0, 0
  %v58 = sub i64 %v57, %v56
  %v59 = getelementptr i64, ptr %s3, i64 0
  %v60 = add i64 0, 0
  %v61 = getelementptr i64, ptr %s2, i64 0
  %v62 = getelementptr i64, ptr %s1, i64 0
  %v63 = add i64 0, 0
  %st34 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st34
  %st35 = getelementptr i64, ptr %v62, i64 0
  store i64 %v58, ptr %st35
  %v64 = getelementptr i64, ptr %s7, i64 0
  %v65 = add i64 0, 0
  %v66 = sub i64 %v65, %v53
  call void @"std/io.errOf"(ptr %v64, i64 %v66)
  %v67 = getelementptr i64, ptr %s6, i64 0
  %v68 = add i64 0, 1
  %st36 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st36
  %v69.p = getelementptr i64, ptr %v64, i64 0
  %v69 = load i64, ptr %v69.p
  %st37 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st37
  %v70.p = getelementptr i64, ptr %v64, i64 1
  %v70 = load i64, ptr %v70.p
  %st38 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st38
  %v71.p = getelementptr i64, ptr %v64, i64 2
  %v71 = load i64, ptr %v71.p
  %st39 = getelementptr i64, ptr %v67, i64 3
  store i64 %v71, ptr %st39
  %v72.p = getelementptr i64, ptr %v64, i64 3
  %v72 = load i64, ptr %v72.p
  %st40 = getelementptr i64, ptr %v67, i64 4
  store i64 %v72, ptr %st40
  %v73.p = getelementptr i64, ptr %v64, i64 4
  %v73 = load i64, ptr %v73.p
  %st41 = getelementptr i64, ptr %v67, i64 5
  store i64 %v73, ptr %st41
  %v74.p = getelementptr i64, ptr %v62, i64 0
  %v74 = load i64, ptr %v74.p
  %st42 = getelementptr i64, ptr %v0, i64 0
  store i64 %v74, ptr %st42
  %v75.p = getelementptr i64, ptr %v67, i64 0
  %v75 = load i64, ptr %v75.p
  %st43 = getelementptr i64, ptr %v0, i64 1
  store i64 %v75, ptr %st43
  %v76.p = getelementptr i64, ptr %v67, i64 1
  %v76 = load i64, ptr %v76.p
  %st44 = getelementptr i64, ptr %v0, i64 2
  store i64 %v76, ptr %st44
  %v77.p = getelementptr i64, ptr %v67, i64 2
  %v77 = load i64, ptr %v77.p
  %st45 = getelementptr i64, ptr %v0, i64 3
  store i64 %v77, ptr %st45
  %v78.p = getelementptr i64, ptr %v67, i64 3
  %v78 = load i64, ptr %v78.p
  %st46 = getelementptr i64, ptr %v0, i64 4
  store i64 %v78, ptr %st46
  %v79.p = getelementptr i64, ptr %v67, i64 4
  %v79 = load i64, ptr %v79.p
  %st47 = getelementptr i64, ptr %v0, i64 5
  store i64 %v79, ptr %st47
  %v80.p = getelementptr i64, ptr %v67, i64 5
  %v80 = load i64, ptr %v80.p
  %st48 = getelementptr i64, ptr %v0, i64 6
  store i64 %v80, ptr %st48
  %v81.p = getelementptr i64, ptr %v0, i64 1
  %v81 = load i64, ptr %v81.p
  %v82 = add i64 0, 0
  %v83.c = icmp ne i64 %v81, %v82
  %v83 = zext i1 %v83.c to i64
  %c.b6 = icmp ne i64 %v83, 0
  br i1 %c.b6, label %b6.t50, label %b6.e51
b6.t50:
  br label %b8
b6.e51:
  br label %b9
b7:
  br label %b10
b8:
  %v84 = add i64 0, 2
  %v85 = getelementptr i64, ptr %v0, i64 %v84
  call void @"rt.err_relocate"(ptr %v85, i64 %v5)
  br label %b9
b9:
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v107, i64 0
  store i64 %v5, ptr %st51
  ret void
b10:
  %v86 = getelementptr i64, ptr %s1, i64 0
  %v87 = add i64 0, 0
  %v88 = getelementptr i64, ptr %s2, i64 0
  %v89 = getelementptr i64, ptr %s3, i64 0
  %v90 = add i64 0, 0
  %st52 = getelementptr i64, ptr %v89, i64 0
  store i64 %v90, ptr %st52
  %st53 = getelementptr i64, ptr %v89, i64 0
  store i64 %v53, ptr %st53
  %v91 = getelementptr i64, ptr %s6, i64 0
  %v92 = add i64 0, 0
  %st54 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st54
  %v93.p = getelementptr i64, ptr %v89, i64 0
  %v93 = load i64, ptr %v93.p
  %st55 = getelementptr i64, ptr %v0, i64 0
  store i64 %v93, ptr %st55
  %v94.p = getelementptr i64, ptr %v91, i64 0
  %v94 = load i64, ptr %v94.p
  %st56 = getelementptr i64, ptr %v0, i64 1
  store i64 %v94, ptr %st56
  %v95.p = getelementptr i64, ptr %v91, i64 1
  %v95 = load i64, ptr %v95.p
  %st57 = getelementptr i64, ptr %v0, i64 2
  store i64 %v95, ptr %st57
  %v96.p = getelementptr i64, ptr %v91, i64 2
  %v96 = load i64, ptr %v96.p
  %st58 = getelementptr i64, ptr %v0, i64 3
  store i64 %v96, ptr %st58
  %v97.p = getelementptr i64, ptr %v91, i64 3
  %v97 = load i64, ptr %v97.p
  %st59 = getelementptr i64, ptr %v0, i64 4
  store i64 %v97, ptr %st59
  %v98.p = getelementptr i64, ptr %v91, i64 4
  %v98 = load i64, ptr %v98.p
  %st60 = getelementptr i64, ptr %v0, i64 5
  store i64 %v98, ptr %st60
  %v99.p = getelementptr i64, ptr %v91, i64 5
  %v99 = load i64, ptr %v99.p
  %st61 = getelementptr i64, ptr %v0, i64 6
  store i64 %v99, ptr %st61
  %v100.p = getelementptr i64, ptr %v0, i64 1
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 0
  %v102.c = icmp ne i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b10 = icmp ne i64 %v102, 0
  br i1 %c.b10, label %b10.t63, label %b10.e64
b10.t63:
  br label %b11
b10.e64:
  br label %b12
b11:
  %v103 = add i64 0, 2
  %v104 = getelementptr i64, ptr %v0, i64 %v103
  call void @"rt.err_relocate"(ptr %v104, i64 %v5)
  br label %b12
b12:
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st64 = getelementptr i64, ptr %v108, i64 0
  store i64 %v5, ptr %st64
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
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v106, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2571
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %st1 = getelementptr i64, ptr %v4, i64 2571
  store i64 %v6, ptr %st1
  %v7 = add i64 0, 1
  %v8.c = icmp sge i64 %v5, %v7
  %v8 = zext i1 %v8.c to i64
  %v9.c = icmp sle i64 %v5, %v3
  %v9 = zext i1 %v9.c to i64
  %v10 = and i64 %v8, %v9
  %v11 = sub i64 %v5, %v3
  %v12 = mul i64 %v10, %v11
  %v13 = add i64 %v3, %v12
  call void @"rt.region_enter"()
  %v14 = add i64 0, 0
  %v15 = add i64 0, 0
  %v16.c = icmp ne i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t3, label %b0.e4
b0.t3:
  br label %b1
b0.e4:
  br label %b2
b1:
  %v17 = add i64 0, 0
  %v18 = call ptr @"rt.region_alloc8"(i64 %v13, i64 %v17)
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr %s1, i64 0
  %v21 = ptrtoint ptr %v18 to i64
  %st4 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st4
  %st5 = getelementptr i64, ptr %v20, i64 1
  store i64 %v19, ptr %st5
  %st6 = getelementptr i64, ptr %v20, i64 2
  store i64 %v13, ptr %st6
  %v22 = getelementptr i64, ptr %s2, i64 0
  %v23 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st7
  %st8 = getelementptr i64, ptr %v22, i64 1
  store i64 %v23, ptr %st8
  %v24 = add i64 0, 3
  %st9 = getelementptr i64, ptr %v22, i64 0
  store i64 %v24, ptr %st9
  %v25 = getelementptr i64, ptr %s3, i64 0
  %v26.p = getelementptr i64, ptr %v22, i64 0
  %v26 = load i64, ptr %v26.p
  %st10 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st10
  %v27.p = getelementptr i64, ptr %v22, i64 1
  %v27 = load i64, ptr %v27.p
  %st11 = getelementptr i64, ptr %v25, i64 1
  store i64 %v27, ptr %st11
  %v28 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v25, i64 2
  store i64 %v28, ptr %st12
  %st13 = getelementptr i64, ptr %v25, i64 3
  store i64 %v28, ptr %st13
  %st14 = getelementptr i64, ptr %v25, i64 4
  store i64 %v28, ptr %st14
  %v29 = getelementptr i64, ptr %s4, i64 0
  %v30 = add i64 0, 1
  %st15 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st15
  %v31.p = getelementptr i64, ptr %v25, i64 0
  %v31 = load i64, ptr %v31.p
  %st16 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st16
  %v32.p = getelementptr i64, ptr %v25, i64 1
  %v32 = load i64, ptr %v32.p
  %st17 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st17
  %v33.p = getelementptr i64, ptr %v25, i64 2
  %v33 = load i64, ptr %v33.p
  %st18 = getelementptr i64, ptr %v29, i64 3
  store i64 %v33, ptr %st18
  %v34.p = getelementptr i64, ptr %v25, i64 3
  %v34 = load i64, ptr %v34.p
  %st19 = getelementptr i64, ptr %v29, i64 4
  store i64 %v34, ptr %st19
  %v35.p = getelementptr i64, ptr %v25, i64 4
  %v35 = load i64, ptr %v35.p
  %st20 = getelementptr i64, ptr %v29, i64 5
  store i64 %v35, ptr %st20
  %v36.p = getelementptr i64, ptr %v20, i64 0
  %v36 = load i64, ptr %v36.p
  %st21 = getelementptr i64, ptr %v0, i64 0
  store i64 %v36, ptr %st21
  %v37.p = getelementptr i64, ptr %v20, i64 1
  %v37 = load i64, ptr %v37.p
  %st22 = getelementptr i64, ptr %v0, i64 1
  store i64 %v37, ptr %st22
  %v38.p = getelementptr i64, ptr %v20, i64 2
  %v38 = load i64, ptr %v38.p
  %st23 = getelementptr i64, ptr %v0, i64 2
  store i64 %v38, ptr %st23
  %v39.p = getelementptr i64, ptr %v29, i64 0
  %v39 = load i64, ptr %v39.p
  %st24 = getelementptr i64, ptr %v0, i64 3
  store i64 %v39, ptr %st24
  %v40.p = getelementptr i64, ptr %v29, i64 1
  %v40 = load i64, ptr %v40.p
  %st25 = getelementptr i64, ptr %v0, i64 4
  store i64 %v40, ptr %st25
  %v41.p = getelementptr i64, ptr %v29, i64 2
  %v41 = load i64, ptr %v41.p
  %st26 = getelementptr i64, ptr %v0, i64 5
  store i64 %v41, ptr %st26
  %v42.p = getelementptr i64, ptr %v29, i64 3
  %v42 = load i64, ptr %v42.p
  %st27 = getelementptr i64, ptr %v0, i64 6
  store i64 %v42, ptr %st27
  %v43.p = getelementptr i64, ptr %v29, i64 4
  %v43 = load i64, ptr %v43.p
  %st28 = getelementptr i64, ptr %v0, i64 7
  store i64 %v43, ptr %st28
  %v44.p = getelementptr i64, ptr %v29, i64 5
  %v44 = load i64, ptr %v44.p
  %st29 = getelementptr i64, ptr %v0, i64 8
  store i64 %v44, ptr %st29
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v45.p = getelementptr i64, ptr %v0, i64 3
  %v45 = load i64, ptr %v45.p
  %v46 = add i64 0, 0
  %v47.c = icmp ne i64 %v45, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b1 = icmp ne i64 %v47, 0
  br i1 %c.b1, label %b1.t31, label %b1.e32
b1.t31:
  br label %b3
b1.e32:
  br label %b4
b2:
  br label %b5
b3:
  %v48 = add i64 0, 4
  %v49 = getelementptr i64, ptr %v0, i64 %v48
  call void @"rt.err_relocate"(ptr %v49, i64 %v3)
  br label %b4
b4:
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v107, i64 0
  store i64 %v3, ptr %st32
  ret void
b5:
  %v50.p = getelementptr i64, ptr %v2, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 1
  %v52 = add i64 0, 0
  %v53 = sub i64 %v52, %v51
  %v54 = getelementptr i64, ptr %s1, i64 0
  call void @"rt.read_fd"(i64 %v50, i64 %v53, ptr %v54)
  %v55 = getelementptr i64, ptr %s5, i64 0
  %v56.p = getelementptr i64, ptr %v54, i64 0
  %v56 = load i64, ptr %v56.p
  %st33 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st33
  %v57.p = getelementptr i64, ptr %v54, i64 1
  %v57 = load i64, ptr %v57.p
  %st34 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st34
  %v58.p = getelementptr i64, ptr %v54, i64 2
  %v58 = load i64, ptr %v58.p
  %st35 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st35
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v59, i64 1027
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 0
  %v62.c = icmp ne i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b5 = icmp ne i64 %v62, 0
  br i1 %c.b5, label %b5.t37, label %b5.e38
b5.t37:
  br label %b6
b5.e38:
  br label %b7
b6:
  %v63 = add i64 0, 0
  %v64 = call ptr @"rt.region_alloc8"(i64 %v13, i64 %v63)
  %v65 = add i64 0, 0
  %v66 = getelementptr i64, ptr %s1, i64 0
  %v67 = ptrtoint ptr %v64 to i64
  %st38 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st38
  %st39 = getelementptr i64, ptr %v66, i64 1
  store i64 %v65, ptr %st39
  %st40 = getelementptr i64, ptr %v66, i64 2
  store i64 %v13, ptr %st40
  %v68 = getelementptr i64, ptr %s6, i64 0
  call void @"std/io.errOf"(ptr %v68, i64 %v60)
  %v69 = getelementptr i64, ptr %s4, i64 0
  %v70 = add i64 0, 1
  %st41 = getelementptr i64, ptr %v69, i64 0
  store i64 %v70, ptr %st41
  %v71.p = getelementptr i64, ptr %v68, i64 0
  %v71 = load i64, ptr %v71.p
  %st42 = getelementptr i64, ptr %v69, i64 1
  store i64 %v71, ptr %st42
  %v72.p = getelementptr i64, ptr %v68, i64 1
  %v72 = load i64, ptr %v72.p
  %st43 = getelementptr i64, ptr %v69, i64 2
  store i64 %v72, ptr %st43
  %v73.p = getelementptr i64, ptr %v68, i64 2
  %v73 = load i64, ptr %v73.p
  %st44 = getelementptr i64, ptr %v69, i64 3
  store i64 %v73, ptr %st44
  %v74.p = getelementptr i64, ptr %v68, i64 3
  %v74 = load i64, ptr %v74.p
  %st45 = getelementptr i64, ptr %v69, i64 4
  store i64 %v74, ptr %st45
  %v75.p = getelementptr i64, ptr %v68, i64 4
  %v75 = load i64, ptr %v75.p
  %st46 = getelementptr i64, ptr %v69, i64 5
  store i64 %v75, ptr %st46
  %v76.p = getelementptr i64, ptr %v66, i64 0
  %v76 = load i64, ptr %v76.p
  %st47 = getelementptr i64, ptr %v0, i64 0
  store i64 %v76, ptr %st47
  %v77.p = getelementptr i64, ptr %v66, i64 1
  %v77 = load i64, ptr %v77.p
  %st48 = getelementptr i64, ptr %v0, i64 1
  store i64 %v77, ptr %st48
  %v78.p = getelementptr i64, ptr %v66, i64 2
  %v78 = load i64, ptr %v78.p
  %st49 = getelementptr i64, ptr %v0, i64 2
  store i64 %v78, ptr %st49
  %v79.p = getelementptr i64, ptr %v69, i64 0
  %v79 = load i64, ptr %v79.p
  %st50 = getelementptr i64, ptr %v0, i64 3
  store i64 %v79, ptr %st50
  %v80.p = getelementptr i64, ptr %v69, i64 1
  %v80 = load i64, ptr %v80.p
  %st51 = getelementptr i64, ptr %v0, i64 4
  store i64 %v80, ptr %st51
  %v81.p = getelementptr i64, ptr %v69, i64 2
  %v81 = load i64, ptr %v81.p
  %st52 = getelementptr i64, ptr %v0, i64 5
  store i64 %v81, ptr %st52
  %v82.p = getelementptr i64, ptr %v69, i64 3
  %v82 = load i64, ptr %v82.p
  %st53 = getelementptr i64, ptr %v0, i64 6
  store i64 %v82, ptr %st53
  %v83.p = getelementptr i64, ptr %v69, i64 4
  %v83 = load i64, ptr %v83.p
  %st54 = getelementptr i64, ptr %v0, i64 7
  store i64 %v83, ptr %st54
  %v84.p = getelementptr i64, ptr %v69, i64 5
  %v84 = load i64, ptr %v84.p
  %st55 = getelementptr i64, ptr %v0, i64 8
  store i64 %v84, ptr %st55
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v85.p = getelementptr i64, ptr %v0, i64 3
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 0, 0
  %v87.c = icmp ne i64 %v85, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b6 = icmp ne i64 %v87, 0
  br i1 %c.b6, label %b6.t57, label %b6.e58
b6.t57:
  br label %b8
b6.e58:
  br label %b9
b7:
  br label %b10
b8:
  %v88 = add i64 0, 4
  %v89 = getelementptr i64, ptr %v0, i64 %v88
  call void @"rt.err_relocate"(ptr %v89, i64 %v3)
  br label %b9
b9:
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v108, i64 0
  store i64 %v3, ptr %st58
  ret void
b10:
  %v90 = getelementptr i64, ptr %s4, i64 0
  %v91 = add i64 0, 0
  %st59 = getelementptr i64, ptr %v90, i64 0
  store i64 %v91, ptr %st59
  %v92.p = getelementptr i64, ptr %v55, i64 0
  %v92 = load i64, ptr %v92.p
  %st60 = getelementptr i64, ptr %v0, i64 0
  store i64 %v92, ptr %st60
  %v93.p = getelementptr i64, ptr %v55, i64 1
  %v93 = load i64, ptr %v93.p
  %st61 = getelementptr i64, ptr %v0, i64 1
  store i64 %v93, ptr %st61
  %v94.p = getelementptr i64, ptr %v55, i64 2
  %v94 = load i64, ptr %v94.p
  %st62 = getelementptr i64, ptr %v0, i64 2
  store i64 %v94, ptr %st62
  %v95.p = getelementptr i64, ptr %v90, i64 0
  %v95 = load i64, ptr %v95.p
  %st63 = getelementptr i64, ptr %v0, i64 3
  store i64 %v95, ptr %st63
  %v96.p = getelementptr i64, ptr %v90, i64 1
  %v96 = load i64, ptr %v96.p
  %st64 = getelementptr i64, ptr %v0, i64 4
  store i64 %v96, ptr %st64
  %v97.p = getelementptr i64, ptr %v90, i64 2
  %v97 = load i64, ptr %v97.p
  %st65 = getelementptr i64, ptr %v0, i64 5
  store i64 %v97, ptr %st65
  %v98.p = getelementptr i64, ptr %v90, i64 3
  %v98 = load i64, ptr %v98.p
  %st66 = getelementptr i64, ptr %v0, i64 6
  store i64 %v98, ptr %st66
  %v99.p = getelementptr i64, ptr %v90, i64 4
  %v99 = load i64, ptr %v99.p
  %st67 = getelementptr i64, ptr %v0, i64 7
  store i64 %v99, ptr %st67
  %v100.p = getelementptr i64, ptr %v90, i64 5
  %v100 = load i64, ptr %v100.p
  %st68 = getelementptr i64, ptr %v0, i64 8
  store i64 %v100, ptr %st68
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v101.p = getelementptr i64, ptr %v0, i64 3
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 0, 0
  %v103.c = icmp ne i64 %v101, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b10 = icmp ne i64 %v103, 0
  br i1 %c.b10, label %b10.t70, label %b10.e71
b10.t70:
  br label %b11
b10.e71:
  br label %b12
b11:
  %v104 = add i64 0, 4
  %v105 = getelementptr i64, ptr %v0, i64 %v104
  call void @"rt.err_relocate"(ptr %v105, i64 %v3)
  br label %b12
b12:
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %st71 = getelementptr i64, ptr %v109, i64 0
  store i64 %v3, ptr %st71
  ret void
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

define internal i64 @"std/io.dot"(i64 %v0, i64 %v1, i64 %v2) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v3, i64 2
  store i64 %v2, ptr %st2
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v45, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5.p = getelementptr i64, ptr %v3, i64 1
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 1
  %v7.c = icmp eq i64 %v5, %v6
  %v7 = zext i1 %v7.c to i64
  %c.b0 = icmp ne i64 %v7, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v9 = add i64 0, 0
  %v10.p = getelementptr i64, ptr %v3, i64 1
  %v10 = load i64, ptr %v10.p
  %v11.c = icmp uge i64 %v9, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b1 = icmp ne i64 %v11, 0
  br i1 %c.b1, label %b1.t6, label %b1.e7
b1.t6:
  br label %b3
b1.e7:
  br label %b4
b2:
  %v8 = phi i64 [ %v7, %b0.e5 ], [ %v18, %b4 ]
  %c.b2 = icmp ne i64 %v8, 0
  br i1 %c.b2, label %b2.t8, label %b2.e9
b2.t8:
  br label %b6
b2.e9:
  br label %b5
b3:
  %v12 = add i64 0, 5
  call void @"rt.panic"(i64 %v12)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v13.p = getelementptr i64, ptr %v3, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = inttoptr i64 %v13 to ptr
  %v15 = getelementptr i8, ptr %v14, i64 %v9
  %v16.p = getelementptr i8, ptr %v15, i64 0
  %v16.b = load i8, ptr %v16.p
  %v16 = zext i8 %v16.b to i64
  %v17 = add i64 0, 46
  %v18.c = icmp eq i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  br label %b2
b5:
  %v20.p = getelementptr i64, ptr %v3, i64 1
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 2
  %v22.c = icmp eq i64 %v20, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b5 = icmp ne i64 %v22, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  %v19 = phi i64 [ %v8, %b2.t8 ], [ %v34, %b12 ]
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v46, i64 0
  store i64 %v4, ptr %st11
  ret i64 %v19
b7:
  %v24 = add i64 0, 0
  %v25.p = getelementptr i64, ptr %v3, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp uge i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b7 = icmp ne i64 %v26, 0
  br i1 %c.b7, label %b7.t13, label %b7.e14
b7.t13:
  br label %b9
b7.e14:
  br label %b10
b8:
  %v23 = phi i64 [ %v22, %b5.e11 ], [ %v33, %b10 ]
  %c.b8 = icmp ne i64 %v23, 0
  br i1 %c.b8, label %b8.t15, label %b8.e16
b8.t15:
  br label %b11
b8.e16:
  br label %b12
b9:
  %v27 = add i64 0, 6
  call void @"rt.panic"(i64 %v27)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v28.p = getelementptr i64, ptr %v3, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = inttoptr i64 %v28 to ptr
  %v30 = getelementptr i8, ptr %v29, i64 %v24
  %v31.p = getelementptr i8, ptr %v30, i64 0
  %v31.b = load i8, ptr %v31.p
  %v31 = zext i8 %v31.b to i64
  %v32 = add i64 0, 46
  %v33.c = icmp eq i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  br label %b8
b11:
  %v35 = add i64 0, 1
  %v36.p = getelementptr i64, ptr %v3, i64 1
  %v36 = load i64, ptr %v36.p
  %v37.c = icmp uge i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b11 = icmp ne i64 %v37, 0
  br i1 %c.b11, label %b11.t17, label %b11.e18
b11.t17:
  br label %b13
b11.e18:
  br label %b14
b12:
  %v34 = phi i64 [ %v23, %b8.e16 ], [ %v44, %b14 ]
  br label %b6
b13:
  %v38 = add i64 0, 7
  call void @"rt.panic"(i64 %v38)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v39.p = getelementptr i64, ptr %v3, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = inttoptr i64 %v39 to ptr
  %v41 = getelementptr i8, ptr %v40, i64 %v35
  %v42.p = getelementptr i8, ptr %v41, i64 0
  %v42.b = load i8, ptr %v42.p
  %v42 = zext i8 %v42.b to i64
  %v43 = add i64 0, 46
  %v44.c = icmp eq i64 %v42, %v43
  %v44 = zext i1 %v44.c to i64
  br label %b12
}

define internal i64 @"std/io.less"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v77, i64 0
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
  %v17 = add i64 0, 0
  %v18 = getelementptr i64, ptr %s4, i64 0
  %st12 = getelementptr i64, ptr %v18, i64 0
  store i64 %v17, ptr %st12
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v78, i64 0
  %v19 = load i64, ptr %v19.p
  br label %b1
b1:
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v79, i64 0
  store i64 %v19, ptr %st13
  %v20.p = getelementptr i64, ptr %v18, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v9, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.c = icmp slt i64 %v20, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b1 = icmp ne i64 %v22, 0
  br i1 %c.b1, label %b1.t15, label %b1.e16
b1.t15:
  br label %b4
b1.e16:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %v45.p = getelementptr i64, ptr %v80, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = add i64 0, 1
  %v47.p = getelementptr i64, ptr %v18, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 %v47, %v46
  %st16 = getelementptr i64, ptr %v18, i64 0
  store i64 %v48, ptr %st16
  br label %b1
b3:
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v81, i64 0
  store i64 %v19, ptr %st17
  %v49.p = getelementptr i64, ptr %v18, i64 0
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v9, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.c = icmp slt i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b3 = icmp ne i64 %v51, 0
  br i1 %c.b3, label %b3.t19, label %b3.e20
b3.t19:
  br label %b12
b3.e20:
  br label %b13
b4:
  %v24.p = getelementptr i64, ptr %v18, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v13, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp slt i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  br label %b5
b5:
  %v23 = phi i64 [ %v22, %b1.e16 ], [ %v26, %b4 ]
  %c.b5 = icmp ne i64 %v23, 0
  br i1 %c.b5, label %b5.t21, label %b5.e22
b5.t21:
  br label %b6
b5.e22:
  br label %b7
b6:
  %v28.p = getelementptr i64, ptr %v18, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v9, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.c = icmp uge i64 %v28, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b6 = icmp ne i64 %v30, 0
  br i1 %c.b6, label %b6.t23, label %b6.e24
b6.t23:
  br label %b8
b6.e24:
  br label %b9
b7:
  %v27 = phi i64 [ %v23, %b5.e22 ], [ %v44, %b11 ]
  %c.b7 = icmp ne i64 %v27, 0
  br i1 %c.b7, label %b7.t25, label %b7.e26
b7.t25:
  br label %b2
b7.e26:
  br label %b3
b8:
  %v31 = add i64 0, 8
  call void @"rt.panic"(i64 %v31)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v32.p = getelementptr i64, ptr %v9, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = inttoptr i64 %v32 to ptr
  %v34 = getelementptr i8, ptr %v33, i64 %v28
  %v35.p = getelementptr i8, ptr %v34, i64 0
  %v35.b = load i8, ptr %v35.p
  %v35 = zext i8 %v35.b to i64
  %v36.p = getelementptr i64, ptr %v18, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v13, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b9 = icmp ne i64 %v38, 0
  br i1 %c.b9, label %b9.t27, label %b9.e28
b9.t27:
  br label %b10
b9.e28:
  br label %b11
b10:
  %v39 = add i64 0, 9
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v40.p = getelementptr i64, ptr %v13, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = getelementptr i8, ptr %v41, i64 %v36
  %v43.p = getelementptr i8, ptr %v42, i64 0
  %v43.b = load i8, ptr %v43.p
  %v43 = zext i8 %v43.b to i64
  %v44.c = icmp eq i64 %v35, %v43
  %v44 = zext i1 %v44.c to i64
  br label %b7
b12:
  %v53.p = getelementptr i64, ptr %v18, i64 0
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v13, i64 1
  %v54 = load i64, ptr %v54.p
  %v55.c = icmp slt i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  br label %b13
b13:
  %v52 = phi i64 [ %v51, %b3.e20 ], [ %v55, %b12 ]
  %c.b13 = icmp ne i64 %v52, 0
  br i1 %c.b13, label %b13.t29, label %b13.e30
b13.t29:
  br label %b14
b13.e30:
  br label %b15
b14:
  %v56.p = getelementptr i64, ptr %v18, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v9, i64 1
  %v57 = load i64, ptr %v57.p
  %v58.c = icmp uge i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b14 = icmp ne i64 %v58, 0
  br i1 %c.b14, label %b14.t31, label %b14.e32
b14.t31:
  br label %b16
b14.e32:
  br label %b17
b15:
  %v73.p = getelementptr i64, ptr %v9, i64 1
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v13, i64 1
  %v74 = load i64, ptr %v74.p
  %v75.c = icmp slt i64 %v73, %v74
  %v75 = zext i1 %v75.c to i64
  br label %b20
b16:
  %v59 = add i64 0, 10
  call void @"rt.panic"(i64 %v59)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v60.p = getelementptr i64, ptr %v9, i64 0
  %v60 = load i64, ptr %v60.p
  %v61 = inttoptr i64 %v60 to ptr
  %v62 = getelementptr i8, ptr %v61, i64 %v56
  %v63.p = getelementptr i8, ptr %v62, i64 0
  %v63.b = load i8, ptr %v63.p
  %v63 = zext i8 %v63.b to i64
  %v64.p = getelementptr i64, ptr %v18, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v13, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.c = icmp uge i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b17 = icmp ne i64 %v66, 0
  br i1 %c.b17, label %b17.t33, label %b17.e34
b17.t33:
  br label %b18
b17.e34:
  br label %b19
b18:
  %v67 = add i64 0, 11
  call void @"rt.panic"(i64 %v67)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v68.p = getelementptr i64, ptr %v13, i64 0
  %v68 = load i64, ptr %v68.p
  %v69 = inttoptr i64 %v68 to ptr
  %v70 = getelementptr i8, ptr %v69, i64 %v64
  %v71.p = getelementptr i8, ptr %v70, i64 0
  %v71.b = load i8, ptr %v71.p
  %v71 = zext i8 %v71.b to i64
  %v72.c = icmp slt i64 %v63, %v71
  %v72 = zext i1 %v72.c to i64
  br label %b20
b20:
  %v76 = phi i64 [ %v75, %b15 ], [ %v72, %b19 ]
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v82, i64 0
  store i64 %v8, ptr %st34
  ret i64 %v76
}

define internal void @"std/io.ReadDir"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s10 = alloca [3 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s10.z1 = getelementptr i64, ptr %s10, i64 1
  store i64 0, ptr %s10.z1
  %s10.z2 = getelementptr i64, ptr %s10, i64 2
  store i64 0, ptr %s10.z2
  %s11 = alloca [9 x i64], align 8
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
  %s11.z6 = getelementptr i64, ptr %s11, i64 6
  store i64 0, ptr %s11.z6
  %s11.z7 = getelementptr i64, ptr %s11, i64 7
  store i64 0, ptr %s11.z7
  %s11.z8 = getelementptr i64, ptr %s11, i64 8
  store i64 0, ptr %s11.z8
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
  %s14 = alloca [1 x i64], align 8
  %s14.z0 = getelementptr i64, ptr %s14, i64 0
  store i64 0, ptr %s14.z0
  %s15 = alloca [1 x i64], align 8
  %s15.z0 = getelementptr i64, ptr %s15, i64 0
  store i64 0, ptr %s15.z0
  %s16 = alloca [4 x i64], align 8
  %s16.z0 = getelementptr i64, ptr %s16, i64 0
  store i64 0, ptr %s16.z0
  %s16.z1 = getelementptr i64, ptr %s16, i64 1
  store i64 0, ptr %s16.z1
  %s16.z2 = getelementptr i64, ptr %s16, i64 2
  store i64 0, ptr %s16.z2
  %s16.z3 = getelementptr i64, ptr %s16, i64 3
  store i64 0, ptr %s16.z3
  %s17 = alloca [4 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s17.z1 = getelementptr i64, ptr %s17, i64 1
  store i64 0, ptr %s17.z1
  %s17.z2 = getelementptr i64, ptr %s17, i64 2
  store i64 0, ptr %s17.z2
  %s17.z3 = getelementptr i64, ptr %s17, i64 3
  store i64 0, ptr %s17.z3
  %s18 = alloca [3 x i64], align 8
  %s18.z0 = getelementptr i64, ptr %s18, i64 0
  store i64 0, ptr %s18.z0
  %s18.z1 = getelementptr i64, ptr %s18, i64 1
  store i64 0, ptr %s18.z1
  %s18.z2 = getelementptr i64, ptr %s18, i64 2
  store i64 0, ptr %s18.z2
  %s19 = alloca [4 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s19.z1 = getelementptr i64, ptr %s19, i64 1
  store i64 0, ptr %s19.z1
  %s19.z2 = getelementptr i64, ptr %s19, i64 2
  store i64 0, ptr %s19.z2
  %s19.z3 = getelementptr i64, ptr %s19, i64 3
  store i64 0, ptr %s19.z3
  %s20 = alloca [4 x i64], align 8
  %s20.z0 = getelementptr i64, ptr %s20, i64 0
  store i64 0, ptr %s20.z0
  %s20.z1 = getelementptr i64, ptr %s20, i64 1
  store i64 0, ptr %s20.z1
  %s20.z2 = getelementptr i64, ptr %s20, i64 2
  store i64 0, ptr %s20.z2
  %s20.z3 = getelementptr i64, ptr %s20, i64 3
  store i64 0, ptr %s20.z3
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v427 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v427, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2571
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v6, i64 2571
  store i64 %v8, ptr %st3
  %v9 = add i64 0, 1
  %v10.c = icmp sge i64 %v7, %v9
  %v10 = zext i1 %v10.c to i64
  %v11.c = icmp sle i64 %v7, %v5
  %v11 = zext i1 %v11.c to i64
  %v12 = and i64 %v10, %v11
  %v13 = sub i64 %v7, %v5
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v5, %v14
  call void @"rt.region_enter"()
  %v16 = add i64 0, 0
  %v17 = add i64 0, 0
  %v18.c = icmp ne i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v428 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v428, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %v21 = call ptr @"rt.region_alloc"(i64 %v19, i64 %v20)
  %v22 = add i64 0, 0
  %v23 = getelementptr i64, ptr %s1, i64 0
  %v24 = ptrtoint ptr %v21 to i64
  %st6 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st6
  %st7 = getelementptr i64, ptr %v23, i64 1
  store i64 %v22, ptr %st7
  %st8 = getelementptr i64, ptr %v23, i64 2
  store i64 %v19, ptr %st8
  %v25 = getelementptr i64, ptr %s2, i64 0
  %v26 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st9
  %st10 = getelementptr i64, ptr %v25, i64 1
  store i64 %v26, ptr %st10
  %v27 = add i64 0, 3
  %st11 = getelementptr i64, ptr %v25, i64 0
  store i64 %v27, ptr %st11
  %v28 = getelementptr i64, ptr %s3, i64 0
  %v29.p = getelementptr i64, ptr %v25, i64 0
  %v29 = load i64, ptr %v29.p
  %st12 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st12
  %v30.p = getelementptr i64, ptr %v25, i64 1
  %v30 = load i64, ptr %v30.p
  %st13 = getelementptr i64, ptr %v28, i64 1
  store i64 %v30, ptr %st13
  %v31 = add i64 0, 0
  %st14 = getelementptr i64, ptr %v28, i64 2
  store i64 %v31, ptr %st14
  %st15 = getelementptr i64, ptr %v28, i64 3
  store i64 %v31, ptr %st15
  %st16 = getelementptr i64, ptr %v28, i64 4
  store i64 %v31, ptr %st16
  %v32 = getelementptr i64, ptr %s4, i64 0
  %v33 = add i64 0, 1
  %st17 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st17
  %v34.p = getelementptr i64, ptr %v28, i64 0
  %v34 = load i64, ptr %v34.p
  %st18 = getelementptr i64, ptr %v32, i64 1
  store i64 %v34, ptr %st18
  %v35.p = getelementptr i64, ptr %v28, i64 1
  %v35 = load i64, ptr %v35.p
  %st19 = getelementptr i64, ptr %v32, i64 2
  store i64 %v35, ptr %st19
  %v36.p = getelementptr i64, ptr %v28, i64 2
  %v36 = load i64, ptr %v36.p
  %st20 = getelementptr i64, ptr %v32, i64 3
  store i64 %v36, ptr %st20
  %v37.p = getelementptr i64, ptr %v28, i64 3
  %v37 = load i64, ptr %v37.p
  %st21 = getelementptr i64, ptr %v32, i64 4
  store i64 %v37, ptr %st21
  %v38.p = getelementptr i64, ptr %v28, i64 4
  %v38 = load i64, ptr %v38.p
  %st22 = getelementptr i64, ptr %v32, i64 5
  store i64 %v38, ptr %st22
  %v39.p = getelementptr i64, ptr %v23, i64 0
  %v39 = load i64, ptr %v39.p
  %st23 = getelementptr i64, ptr %v0, i64 0
  store i64 %v39, ptr %st23
  %v40.p = getelementptr i64, ptr %v23, i64 1
  %v40 = load i64, ptr %v40.p
  %st24 = getelementptr i64, ptr %v0, i64 1
  store i64 %v40, ptr %st24
  %v41.p = getelementptr i64, ptr %v23, i64 2
  %v41 = load i64, ptr %v41.p
  %st25 = getelementptr i64, ptr %v0, i64 2
  store i64 %v41, ptr %st25
  %v42.p = getelementptr i64, ptr %v32, i64 0
  %v42 = load i64, ptr %v42.p
  %st26 = getelementptr i64, ptr %v0, i64 3
  store i64 %v42, ptr %st26
  %v43.p = getelementptr i64, ptr %v32, i64 1
  %v43 = load i64, ptr %v43.p
  %st27 = getelementptr i64, ptr %v0, i64 4
  store i64 %v43, ptr %st27
  %v44.p = getelementptr i64, ptr %v32, i64 2
  %v44 = load i64, ptr %v44.p
  %st28 = getelementptr i64, ptr %v0, i64 5
  store i64 %v44, ptr %st28
  %v45.p = getelementptr i64, ptr %v32, i64 3
  %v45 = load i64, ptr %v45.p
  %st29 = getelementptr i64, ptr %v0, i64 6
  store i64 %v45, ptr %st29
  %v46.p = getelementptr i64, ptr %v32, i64 4
  %v46 = load i64, ptr %v46.p
  %st30 = getelementptr i64, ptr %v0, i64 7
  store i64 %v46, ptr %st30
  %v47.p = getelementptr i64, ptr %v32, i64 5
  %v47 = load i64, ptr %v47.p
  %st31 = getelementptr i64, ptr %v0, i64 8
  store i64 %v47, ptr %st31
  %v48.p = getelementptr i64, ptr %v0, i64 2
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp sgt i64 %v48, %v5
  %v49 = zext i1 %v49.c to i64
  %c.b1 = icmp ne i64 %v49, 0
  br i1 %c.b1, label %b1.t33, label %b1.e34
b1.t33:
  br label %b3
b1.e34:
  br label %b4
b2:
  br label %b10
b3:
  %v50.p = getelementptr i64, ptr %v0, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = inttoptr i64 %v50 to ptr
  %v52.p = getelementptr i64, ptr %v0, i64 1
  %v52 = load i64, ptr %v52.p
  %v54 = add i64 0, 0
  br label %b5
b4:
  %v61.p = getelementptr i64, ptr %v0, i64 3
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 0
  %v63.c = icmp ne i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b4 = icmp ne i64 %v63, 0
  br i1 %c.b4, label %b4.t35, label %b4.e36
b4.t35:
  br label %b8
b4.e36:
  br label %b9
b5:
  %v53 = phi i64 [ %v54, %b3 ], [ %v60, %b6 ]
  %v55.c = icmp slt i64 %v53, %v52
  %v55 = zext i1 %v55.c to i64
  %c.b5 = icmp ne i64 %v55, 0
  br i1 %c.b5, label %b5.t37, label %b5.e38
b5.t37:
  br label %b6
b5.e38:
  br label %b7
b6:
  %v56 = add i64 0, 4
  %v57 = mul i64 %v53, %v56
  %v58 = getelementptr i64, ptr %v51, i64 %v57
  call void @"rt.region_relocate8"(ptr %v58, i64 %v5)
  %v59 = add i64 0, 1
  %v60 = add i64 %v53, %v59
  br label %b5
b7:
  %v429 = add i64 0, 4
  call void @"rt.region_relocate"(ptr %v0, i64 %v429, i64 %v5)
  br label %b4
b8:
  %v64 = add i64 0, 4
  %v65 = getelementptr i64, ptr %v0, i64 %v64
  call void @"rt.err_relocate"(ptr %v65, i64 %v5)
  br label %b9
b9:
  %v430 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v430, i64 0
  store i64 %v5, ptr %st38
  ret void
b10:
  %v66 = getelementptr i64, ptr %s1, i64 0
  call void @"rt.read_dir"(ptr %v4, ptr %v66, i64 %v15)
  %v67 = getelementptr i64, ptr %s5, i64 0
  %v68.p = getelementptr i64, ptr %v66, i64 0
  %v68 = load i64, ptr %v68.p
  %st39 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st39
  %v69.p = getelementptr i64, ptr %v66, i64 1
  %v69 = load i64, ptr %v69.p
  %st40 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st40
  %v70.p = getelementptr i64, ptr %v66, i64 2
  %v70 = load i64, ptr %v70.p
  %st41 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st41
  %v71 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v71, i64 1027
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 0
  %v74.c = icmp ne i64 %v72, %v73
  %v74 = zext i1 %v74.c to i64
  %c.b10 = icmp ne i64 %v74, 0
  br i1 %c.b10, label %b10.t43, label %b10.e44
b10.t43:
  br label %b11
b10.e44:
  br label %b12
b11:
  %v431 = getelementptr i64, ptr @"rt.meta", i64 0
  %v75.p = getelementptr i64, ptr %v431, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 0
  %v77 = call ptr @"rt.region_alloc"(i64 %v75, i64 %v76)
  %v78 = add i64 0, 0
  %v79 = getelementptr i64, ptr %s1, i64 0
  %v80 = ptrtoint ptr %v77 to i64
  %st44 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st44
  %st45 = getelementptr i64, ptr %v79, i64 1
  store i64 %v78, ptr %st45
  %st46 = getelementptr i64, ptr %v79, i64 2
  store i64 %v75, ptr %st46
  %v81 = getelementptr i64, ptr %s6, i64 0
  call void @"std/io.errOf"(ptr %v81, i64 %v72)
  %v82 = getelementptr i64, ptr %s4, i64 0
  %v83 = add i64 0, 1
  %st47 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st47
  %v84.p = getelementptr i64, ptr %v81, i64 0
  %v84 = load i64, ptr %v84.p
  %st48 = getelementptr i64, ptr %v82, i64 1
  store i64 %v84, ptr %st48
  %v85.p = getelementptr i64, ptr %v81, i64 1
  %v85 = load i64, ptr %v85.p
  %st49 = getelementptr i64, ptr %v82, i64 2
  store i64 %v85, ptr %st49
  %v86.p = getelementptr i64, ptr %v81, i64 2
  %v86 = load i64, ptr %v86.p
  %st50 = getelementptr i64, ptr %v82, i64 3
  store i64 %v86, ptr %st50
  %v87.p = getelementptr i64, ptr %v81, i64 3
  %v87 = load i64, ptr %v87.p
  %st51 = getelementptr i64, ptr %v82, i64 4
  store i64 %v87, ptr %st51
  %v88.p = getelementptr i64, ptr %v81, i64 4
  %v88 = load i64, ptr %v88.p
  %st52 = getelementptr i64, ptr %v82, i64 5
  store i64 %v88, ptr %st52
  %v89.p = getelementptr i64, ptr %v79, i64 0
  %v89 = load i64, ptr %v89.p
  %st53 = getelementptr i64, ptr %v0, i64 0
  store i64 %v89, ptr %st53
  %v90.p = getelementptr i64, ptr %v79, i64 1
  %v90 = load i64, ptr %v90.p
  %st54 = getelementptr i64, ptr %v0, i64 1
  store i64 %v90, ptr %st54
  %v91.p = getelementptr i64, ptr %v79, i64 2
  %v91 = load i64, ptr %v91.p
  %st55 = getelementptr i64, ptr %v0, i64 2
  store i64 %v91, ptr %st55
  %v92.p = getelementptr i64, ptr %v82, i64 0
  %v92 = load i64, ptr %v92.p
  %st56 = getelementptr i64, ptr %v0, i64 3
  store i64 %v92, ptr %st56
  %v93.p = getelementptr i64, ptr %v82, i64 1
  %v93 = load i64, ptr %v93.p
  %st57 = getelementptr i64, ptr %v0, i64 4
  store i64 %v93, ptr %st57
  %v94.p = getelementptr i64, ptr %v82, i64 2
  %v94 = load i64, ptr %v94.p
  %st58 = getelementptr i64, ptr %v0, i64 5
  store i64 %v94, ptr %st58
  %v95.p = getelementptr i64, ptr %v82, i64 3
  %v95 = load i64, ptr %v95.p
  %st59 = getelementptr i64, ptr %v0, i64 6
  store i64 %v95, ptr %st59
  %v96.p = getelementptr i64, ptr %v82, i64 4
  %v96 = load i64, ptr %v96.p
  %st60 = getelementptr i64, ptr %v0, i64 7
  store i64 %v96, ptr %st60
  %v97.p = getelementptr i64, ptr %v82, i64 5
  %v97 = load i64, ptr %v97.p
  %st61 = getelementptr i64, ptr %v0, i64 8
  store i64 %v97, ptr %st61
  %v98.p = getelementptr i64, ptr %v0, i64 2
  %v98 = load i64, ptr %v98.p
  %v99.c = icmp sgt i64 %v98, %v5
  %v99 = zext i1 %v99.c to i64
  %c.b11 = icmp ne i64 %v99, 0
  br i1 %c.b11, label %b11.t63, label %b11.e64
b11.t63:
  br label %b13
b11.e64:
  br label %b14
b12:
  br label %b20
b13:
  %v100.p = getelementptr i64, ptr %v0, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = inttoptr i64 %v100 to ptr
  %v102.p = getelementptr i64, ptr %v0, i64 1
  %v102 = load i64, ptr %v102.p
  %v104 = add i64 0, 0
  br label %b15
b14:
  %v111.p = getelementptr i64, ptr %v0, i64 3
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 0, 0
  %v113.c = icmp ne i64 %v111, %v112
  %v113 = zext i1 %v113.c to i64
  %c.b14 = icmp ne i64 %v113, 0
  br i1 %c.b14, label %b14.t65, label %b14.e66
b14.t65:
  br label %b18
b14.e66:
  br label %b19
b15:
  %v103 = phi i64 [ %v104, %b13 ], [ %v110, %b16 ]
  %v105.c = icmp slt i64 %v103, %v102
  %v105 = zext i1 %v105.c to i64
  %c.b15 = icmp ne i64 %v105, 0
  br i1 %c.b15, label %b15.t67, label %b15.e68
b15.t67:
  br label %b16
b15.e68:
  br label %b17
b16:
  %v106 = add i64 0, 4
  %v107 = mul i64 %v103, %v106
  %v108 = getelementptr i64, ptr %v101, i64 %v107
  call void @"rt.region_relocate8"(ptr %v108, i64 %v5)
  %v109 = add i64 0, 1
  %v110 = add i64 %v103, %v109
  br label %b15
b17:
  %v432 = add i64 0, 4
  call void @"rt.region_relocate"(ptr %v0, i64 %v432, i64 %v5)
  br label %b14
b18:
  %v114 = add i64 0, 4
  %v115 = getelementptr i64, ptr %v0, i64 %v114
  call void @"rt.err_relocate"(ptr %v115, i64 %v5)
  br label %b19
b19:
  %v433 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v433, i64 0
  store i64 %v5, ptr %st68
  ret void
b20:
  %v434 = getelementptr i64, ptr @"rt.meta", i64 0
  %v116.p = getelementptr i64, ptr %v434, i64 0
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 0
  %v118 = call ptr @"rt.region_alloc"(i64 %v116, i64 %v117)
  %v119 = add i64 0, 0
  %v120 = getelementptr i64, ptr %s1, i64 0
  %v121 = ptrtoint ptr %v118 to i64
  %st69 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st69
  %st70 = getelementptr i64, ptr %v120, i64 1
  store i64 %v119, ptr %st70
  %st71 = getelementptr i64, ptr %v120, i64 2
  store i64 %v116, ptr %st71
  %v122 = getelementptr i64, ptr %s7, i64 0
  %v123.p = getelementptr i64, ptr %v120, i64 0
  %v123 = load i64, ptr %v123.p
  %st72 = getelementptr i64, ptr %v122, i64 0
  store i64 %v123, ptr %st72
  %v124.p = getelementptr i64, ptr %v120, i64 1
  %v124 = load i64, ptr %v124.p
  %st73 = getelementptr i64, ptr %v122, i64 1
  store i64 %v124, ptr %st73
  %v125.p = getelementptr i64, ptr %v120, i64 2
  %v125 = load i64, ptr %v125.p
  %st74 = getelementptr i64, ptr %v122, i64 2
  store i64 %v125, ptr %st74
  %v126 = add i64 0, 0
  %v127 = getelementptr i64, ptr %s8, i64 0
  %st75 = getelementptr i64, ptr %v127, i64 0
  store i64 %v126, ptr %st75
  %v435 = getelementptr i64, ptr @"rt.meta", i64 0
  %v128.p = getelementptr i64, ptr %v435, i64 0
  %v128 = load i64, ptr %v128.p
  br label %b21
b21:
  %v436 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v436, i64 0
  store i64 %v128, ptr %st76
  %v129.p = getelementptr i64, ptr %v127, i64 0
  %v129 = load i64, ptr %v129.p
  %v130.p = getelementptr i64, ptr %v67, i64 1
  %v130 = load i64, ptr %v130.p
  %v131.c = icmp slt i64 %v129, %v130
  %v131 = zext i1 %v131.c to i64
  %c.b21 = icmp ne i64 %v131, 0
  br i1 %c.b21, label %b21.t78, label %b21.e79
b21.t78:
  br label %b22
b21.e79:
  br label %b23
b22:
  call void @"rt.region_enter"()
  %v437 = getelementptr i64, ptr @"rt.meta", i64 0
  %v132.p = getelementptr i64, ptr %v437, i64 0
  %v132 = load i64, ptr %v132.p
  %v133.p = getelementptr i64, ptr %v127, i64 0
  %v133 = load i64, ptr %v133.p
  %v134 = add i64 0, 1
  %v135 = add i64 %v133, %v134
  %v136 = getelementptr i64, ptr %s9, i64 0
  %st79 = getelementptr i64, ptr %v136, i64 0
  store i64 %v135, ptr %st79
  %v438 = getelementptr i64, ptr @"rt.meta", i64 0
  %v137.p = getelementptr i64, ptr %v438, i64 0
  %v137 = load i64, ptr %v137.p
  br label %b24
b23:
  %v439 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v439, i64 0
  store i64 %v128, ptr %st80
  %v292 = add i64 0, 1
  %v293 = getelementptr i64, ptr %s9, i64 0
  %st81 = getelementptr i64, ptr %v293, i64 0
  store i64 %v292, ptr %st81
  %v440 = getelementptr i64, ptr @"rt.meta", i64 0
  %v294.p = getelementptr i64, ptr %v440, i64 0
  %v294 = load i64, ptr %v294.p
  br label %b52
b24:
  %v441 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v441, i64 0
  store i64 %v137, ptr %st82
  %v138.p = getelementptr i64, ptr %v136, i64 0
  %v138 = load i64, ptr %v138.p
  %v139.p = getelementptr i64, ptr %v67, i64 1
  %v139 = load i64, ptr %v139.p
  %v140.c = icmp uge i64 %v138, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b24 = icmp ne i64 %v140, 0
  br i1 %c.b24, label %b24.t84, label %b24.e85
b24.t84:
  br label %b27
b24.e85:
  br label %b28
b25:
  call void @"rt.region_enter"()
  %v442 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v442, i64 0
  %v148 = load i64, ptr %v148.p
  %v149 = add i64 0, 1
  %v150.p = getelementptr i64, ptr %v136, i64 0
  %v150 = load i64, ptr %v150.p
  %v151 = add i64 %v150, %v149
  %st85 = getelementptr i64, ptr %v136, i64 0
  store i64 %v151, ptr %st85
  br label %b24
b26:
  %v443 = getelementptr i64, ptr @"rt.meta", i64 0
  %st86 = getelementptr i64, ptr %v443, i64 0
  store i64 %v137, ptr %st86
  %v152.p = getelementptr i64, ptr %v127, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = add i64 0, 1
  %v154 = add i64 %v152, %v153
  %v155.p = getelementptr i64, ptr %v136, i64 0
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 0, 0
  %v157.c = icmp slt i64 %v154, %v156
  %v157 = zext i1 %v157.c to i64
  %c.b26 = icmp ne i64 %v157, 0
  br i1 %c.b26, label %b26.t88, label %b26.e89
b26.t88:
  br label %b29
b26.e89:
  br label %b30
b27:
  %v141 = add i64 0, 12
  call void @"rt.panic"(i64 %v141)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b28:
  %v142.p = getelementptr i64, ptr %v67, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = inttoptr i64 %v142 to ptr
  %v144 = getelementptr i8, ptr %v143, i64 %v138
  %v145.p = getelementptr i8, ptr %v144, i64 0
  %v145.b = load i8, ptr %v145.p
  %v145 = zext i8 %v145.b to i64
  %v146 = add i64 0, 0
  %v147.c = icmp ne i64 %v145, %v146
  %v147 = zext i1 %v147.c to i64
  %c.b28 = icmp ne i64 %v147, 0
  br i1 %c.b28, label %b28.t90, label %b28.e91
b28.t90:
  br label %b25
b28.e91:
  br label %b26
b29:
  %v158 = add i64 0, 13
  call void @"rt.panic"(i64 %v158)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v159.c = icmp slt i64 %v155, %v154
  %v159 = zext i1 %v159.c to i64
  %c.b30 = icmp ne i64 %v159, 0
  br i1 %c.b30, label %b30.t92, label %b30.e93
b30.t92:
  br label %b31
b30.e93:
  br label %b32
b31:
  %v160 = add i64 0, 14
  call void @"rt.panic"(i64 %v160)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v161.p = getelementptr i64, ptr %v67, i64 1
  %v161 = load i64, ptr %v161.p
  %v162.c = icmp sgt i64 %v155, %v161
  %v162 = zext i1 %v162.c to i64
  %c.b32 = icmp ne i64 %v162, 0
  br i1 %c.b32, label %b32.t94, label %b32.e95
b32.t94:
  br label %b33
b32.e95:
  br label %b34
b33:
  %v163 = add i64 0, 15
  call void @"rt.panic"(i64 %v163)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b34:
  %v164.p = getelementptr i64, ptr %v67, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = inttoptr i64 %v164 to ptr
  %v166 = getelementptr i8, ptr %v165, i64 %v154
  %v167 = sub i64 %v155, %v154
  %v168.p = getelementptr i64, ptr %v67, i64 2
  %v168 = load i64, ptr %v168.p
  %v169 = getelementptr i64, ptr %s1, i64 0
  %v170 = ptrtoint ptr %v166 to i64
  %st95 = getelementptr i64, ptr %v169, i64 0
  store i64 %v170, ptr %st95
  %st96 = getelementptr i64, ptr %v169, i64 1
  store i64 %v167, ptr %st96
  %st97 = getelementptr i64, ptr %v169, i64 2
  store i64 %v168, ptr %st97
  %v171 = getelementptr i64, ptr %s10, i64 0
  %v172.p = getelementptr i64, ptr %v169, i64 0
  %v172 = load i64, ptr %v172.p
  %st98 = getelementptr i64, ptr %v171, i64 0
  store i64 %v172, ptr %st98
  %v173.p = getelementptr i64, ptr %v169, i64 1
  %v173 = load i64, ptr %v173.p
  %st99 = getelementptr i64, ptr %v171, i64 1
  store i64 %v173, ptr %st99
  %v174.p = getelementptr i64, ptr %v169, i64 2
  %v174 = load i64, ptr %v174.p
  %st100 = getelementptr i64, ptr %v171, i64 2
  store i64 %v174, ptr %st100
  %v175.p = getelementptr i64, ptr %v171, i64 0
  %v175 = load i64, ptr %v175.p
  %v176.p = getelementptr i64, ptr %v171, i64 1
  %v176 = load i64, ptr %v176.p
  %v177.p = getelementptr i64, ptr %v171, i64 2
  %v177 = load i64, ptr %v177.p
  %v178 = call i64 @"std/io.dot"(i64 %v175, i64 %v176, i64 %v177)
  %v179 = add i64 0, 1
  %v180 = xor i64 %v178, %v179
  %c.b34 = icmp ne i64 %v180, 0
  br i1 %c.b34, label %b34.t102, label %b34.e103
b34.t102:
  br label %b35
b34.e103:
  br label %b36
b35:
  %v181 = getelementptr i64, ptr %s11, i64 0
  %v182.p = getelementptr i64, ptr %v171, i64 0
  %v182 = load i64, ptr %v182.p
  %v183.p = getelementptr i64, ptr %v171, i64 1
  %v183 = load i64, ptr %v183.p
  %v184.p = getelementptr i64, ptr %v171, i64 2
  %v184 = load i64, ptr %v184.p
  call void @"std/internal/utf8.Parse"(ptr %v181, i64 %v182, i64 %v183, i64 %v184)
  %v185 = add i64 0, 3
  %v186 = getelementptr i64, ptr %v181, i64 %v185
  %v187.p = getelementptr i64, ptr %v186, i64 0
  %v187 = load i64, ptr %v187.p
  %v188 = add i64 0, 0
  %v189.c = icmp ne i64 %v187, %v188
  %v189 = zext i1 %v189.c to i64
  %c.b35 = icmp ne i64 %v189, 0
  br i1 %c.b35, label %b35.t104, label %b35.e105
b35.t104:
  br label %b37
b35.e105:
  br label %b38
b36:
  br label %b51
b37:
  %v190 = add i64 0, 0
  %st105 = getelementptr i64, ptr %v0, i64 0
  store i64 %v190, ptr %st105
  %st106 = getelementptr i64, ptr %v0, i64 1
  store i64 %v190, ptr %st106
  %st107 = getelementptr i64, ptr %v0, i64 2
  store i64 %v190, ptr %st107
  %v444 = getelementptr i64, ptr @"rt.meta", i64 0
  %v191.p = getelementptr i64, ptr %v444, i64 0
  %v191 = load i64, ptr %v191.p
  %v445 = getelementptr i64, ptr @"rt.meta", i64 0
  %v446 = getelementptr i64, ptr %v445, i64 %v191
  %v192.p = getelementptr i64, ptr %v446, i64 1
  %v192 = load ptr, ptr %v192.p
  %v193 = ptrtoint ptr %v192 to i64
  %st108 = getelementptr i64, ptr %v0, i64 0
  store i64 %v193, ptr %st108
  %v194 = add i64 0, 0
  %st109 = getelementptr i64, ptr %v0, i64 1
  store i64 %v194, ptr %st109
  %st110 = getelementptr i64, ptr %v0, i64 2
  store i64 %v191, ptr %st110
  %v195.p = getelementptr i64, ptr %v186, i64 0
  %v195 = load i64, ptr %v195.p
  %st111 = getelementptr i64, ptr %v0, i64 3
  store i64 %v195, ptr %st111
  %v196.p = getelementptr i64, ptr %v186, i64 1
  %v196 = load i64, ptr %v196.p
  %st112 = getelementptr i64, ptr %v0, i64 4
  store i64 %v196, ptr %st112
  %v197.p = getelementptr i64, ptr %v186, i64 2
  %v197 = load i64, ptr %v197.p
  %st113 = getelementptr i64, ptr %v0, i64 5
  store i64 %v197, ptr %st113
  %v198.p = getelementptr i64, ptr %v186, i64 3
  %v198 = load i64, ptr %v198.p
  %st114 = getelementptr i64, ptr %v0, i64 6
  store i64 %v198, ptr %st114
  %v199.p = getelementptr i64, ptr %v186, i64 4
  %v199 = load i64, ptr %v199.p
  %st115 = getelementptr i64, ptr %v0, i64 7
  store i64 %v199, ptr %st115
  %v200.p = getelementptr i64, ptr %v186, i64 5
  %v200 = load i64, ptr %v200.p
  %st116 = getelementptr i64, ptr %v0, i64 8
  store i64 %v200, ptr %st116
  %v201.p = getelementptr i64, ptr %v0, i64 2
  %v201 = load i64, ptr %v201.p
  %v202.c = icmp sgt i64 %v201, %v5
  %v202 = zext i1 %v202.c to i64
  %c.b37 = icmp ne i64 %v202, 0
  br i1 %c.b37, label %b37.t118, label %b37.e119
b37.t118:
  br label %b39
b37.e119:
  br label %b40
b38:
  %v219 = getelementptr i64, ptr %s1, i64 0
  %v220.p = getelementptr i64, ptr %v181, i64 0
  %v220 = load i64, ptr %v220.p
  %st119 = getelementptr i64, ptr %v219, i64 0
  store i64 %v220, ptr %st119
  %v221.p = getelementptr i64, ptr %v181, i64 1
  %v221 = load i64, ptr %v221.p
  %st120 = getelementptr i64, ptr %v219, i64 1
  store i64 %v221, ptr %st120
  %v222.p = getelementptr i64, ptr %v181, i64 2
  %v222 = load i64, ptr %v222.p
  %st121 = getelementptr i64, ptr %v219, i64 2
  store i64 %v222, ptr %st121
  %v223 = add i64 0, 1
  %v224 = add i64 %v5, %v223
  %v225 = getelementptr i64, ptr %s12, i64 0
  %v226.p = getelementptr i64, ptr %v122, i64 0
  %v226 = load i64, ptr %v226.p
  %st122 = getelementptr i64, ptr %v225, i64 0
  store i64 %v226, ptr %st122
  %v227.p = getelementptr i64, ptr %v122, i64 1
  %v227 = load i64, ptr %v227.p
  %st123 = getelementptr i64, ptr %v225, i64 1
  store i64 %v227, ptr %st123
  %v228.p = getelementptr i64, ptr %v122, i64 2
  %v228 = load i64, ptr %v228.p
  %st124 = getelementptr i64, ptr %v225, i64 2
  store i64 %v228, ptr %st124
  %v229 = getelementptr i64, ptr %s13, i64 0
  %v230.p = getelementptr i64, ptr %v219, i64 0
  %v230 = load i64, ptr %v230.p
  %st125 = getelementptr i64, ptr %v229, i64 0
  store i64 %v230, ptr %st125
  %v231.p = getelementptr i64, ptr %v219, i64 1
  %v231 = load i64, ptr %v231.p
  %st126 = getelementptr i64, ptr %v229, i64 1
  store i64 %v231, ptr %st126
  %v232.p = getelementptr i64, ptr %v219, i64 2
  %v232 = load i64, ptr %v232.p
  %st127 = getelementptr i64, ptr %v229, i64 2
  store i64 %v232, ptr %st127
  %v233 = getelementptr i64, ptr %s14, i64 0
  %v234.p = getelementptr i64, ptr %v127, i64 0
  %v234 = load i64, ptr %v234.p
  %v235.p = getelementptr i64, ptr %v67, i64 1
  %v235 = load i64, ptr %v235.p
  %v236.c = icmp uge i64 %v234, %v235
  %v236 = zext i1 %v236.c to i64
  %c.b38 = icmp ne i64 %v236, 0
  br i1 %c.b38, label %b38.t129, label %b38.e130
b38.t129:
  br label %b46
b38.e130:
  br label %b47
b39:
  %v203.p = getelementptr i64, ptr %v0, i64 0
  %v203 = load i64, ptr %v203.p
  %v204 = inttoptr i64 %v203 to ptr
  %v205.p = getelementptr i64, ptr %v0, i64 1
  %v205 = load i64, ptr %v205.p
  %v207 = add i64 0, 0
  br label %b41
b40:
  %v214.p = getelementptr i64, ptr %v0, i64 3
  %v214 = load i64, ptr %v214.p
  %v215 = add i64 0, 0
  %v216.c = icmp ne i64 %v214, %v215
  %v216 = zext i1 %v216.c to i64
  %c.b40 = icmp ne i64 %v216, 0
  br i1 %c.b40, label %b40.t131, label %b40.e132
b40.t131:
  br label %b44
b40.e132:
  br label %b45
b41:
  %v206 = phi i64 [ %v207, %b39 ], [ %v213, %b42 ]
  %v208.c = icmp slt i64 %v206, %v205
  %v208 = zext i1 %v208.c to i64
  %c.b41 = icmp ne i64 %v208, 0
  br i1 %c.b41, label %b41.t133, label %b41.e134
b41.t133:
  br label %b42
b41.e134:
  br label %b43
b42:
  %v209 = add i64 0, 4
  %v210 = mul i64 %v206, %v209
  %v211 = getelementptr i64, ptr %v204, i64 %v210
  call void @"rt.region_relocate8"(ptr %v211, i64 %v5)
  %v212 = add i64 0, 1
  %v213 = add i64 %v206, %v212
  br label %b41
b43:
  %v447 = add i64 0, 4
  call void @"rt.region_relocate"(ptr %v0, i64 %v447, i64 %v5)
  br label %b40
b44:
  %v217 = add i64 0, 4
  %v218 = getelementptr i64, ptr %v0, i64 %v217
  call void @"rt.err_relocate"(ptr %v218, i64 %v5)
  br label %b45
b45:
  %v448 = getelementptr i64, ptr @"rt.meta", i64 0
  %st134 = getelementptr i64, ptr %v448, i64 0
  store i64 %v5, ptr %st134
  ret void
b46:
  %v237 = add i64 0, 16
  call void @"rt.panic"(i64 %v237)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v238.p = getelementptr i64, ptr %v67, i64 0
  %v238 = load i64, ptr %v238.p
  %v239 = inttoptr i64 %v238 to ptr
  %v240 = getelementptr i8, ptr %v239, i64 %v234
  %v241.p = getelementptr i8, ptr %v240, i64 0
  %v241.b = load i8, ptr %v241.p
  %v241 = zext i8 %v241.b to i64
  call void @"std/io.kindOf"(ptr %v233, i64 %v241)
  %v242 = getelementptr i64, ptr %s15, i64 0
  %v243.p = getelementptr i64, ptr %v233, i64 0
  %v243 = load i64, ptr %v243.p
  %st135 = getelementptr i64, ptr %v242, i64 0
  store i64 %v243, ptr %st135
  %v244 = getelementptr i64, ptr %s16, i64 0
  %v245 = add i64 0, 0
  %st136 = getelementptr i64, ptr %v244, i64 0
  store i64 %v245, ptr %st136
  %st137 = getelementptr i64, ptr %v244, i64 1
  store i64 %v245, ptr %st137
  %st138 = getelementptr i64, ptr %v244, i64 2
  store i64 %v245, ptr %st138
  %st139 = getelementptr i64, ptr %v244, i64 3
  store i64 %v245, ptr %st139
  %v246.p = getelementptr i64, ptr %v229, i64 0
  %v246 = load i64, ptr %v246.p
  %st140 = getelementptr i64, ptr %v244, i64 0
  store i64 %v246, ptr %st140
  %v247.p = getelementptr i64, ptr %v229, i64 1
  %v247 = load i64, ptr %v247.p
  %st141 = getelementptr i64, ptr %v244, i64 1
  store i64 %v247, ptr %st141
  %v248.p = getelementptr i64, ptr %v229, i64 2
  %v248 = load i64, ptr %v248.p
  %st142 = getelementptr i64, ptr %v244, i64 2
  store i64 %v248, ptr %st142
  %v249.p = getelementptr i64, ptr %v242, i64 0
  %v249 = load i64, ptr %v249.p
  %st143 = getelementptr i64, ptr %v244, i64 3
  store i64 %v249, ptr %st143
  %v250 = getelementptr i64, ptr %s17, i64 0
  %v251.p = getelementptr i64, ptr %v244, i64 0
  %v251 = load i64, ptr %v251.p
  %st144 = getelementptr i64, ptr %v250, i64 0
  store i64 %v251, ptr %st144
  %v252.p = getelementptr i64, ptr %v244, i64 1
  %v252 = load i64, ptr %v252.p
  %st145 = getelementptr i64, ptr %v250, i64 1
  store i64 %v252, ptr %st145
  %v253.p = getelementptr i64, ptr %v244, i64 2
  %v253 = load i64, ptr %v253.p
  %st146 = getelementptr i64, ptr %v250, i64 2
  store i64 %v253, ptr %st146
  %v254.p = getelementptr i64, ptr %v244, i64 3
  %v254 = load i64, ptr %v254.p
  %st147 = getelementptr i64, ptr %v250, i64 3
  store i64 %v254, ptr %st147
  %v255.p = getelementptr i64, ptr %v225, i64 2
  %v255 = load i64, ptr %v255.p
  %v256.p = getelementptr i64, ptr %v225, i64 0
  %v256 = load i64, ptr %v256.p
  %v257.p = getelementptr i64, ptr %v225, i64 1
  %v257 = load i64, ptr %v257.p
  %v260 = add i64 0, 32
  %v261 = mul i64 %v257, %v260
  %v262 = add i64 %v256, %v261
  %v449 = getelementptr i64, ptr @"rt.meta", i64 0
  %v450 = getelementptr i64, ptr %v449, i64 %v255
  %v263.p = getelementptr i64, ptr %v450, i64 1
  %v263 = load ptr, ptr %v263.p
  %v264 = ptrtoint ptr %v263 to i64
  %v265.c = icmp eq i64 %v264, %v262
  %v265 = zext i1 %v265.c to i64
  %c.b47 = icmp ne i64 %v265, 0
  br i1 %c.b47, label %b47.t149, label %b47.e150
b47.t149:
  br label %b50
b47.e150:
  br label %b49
b48:
  %v258 = phi ptr [ %v273, %b49 ], [ %v268, %b50 ]
  %v259 = phi ptr [ %v274, %b49 ], [ %v267, %b50 ]
  call void @"rt.region_relocate8"(ptr %v250, i64 %v255)
  %v275.p = getelementptr i64, ptr %v250, i64 0
  %v275 = load i64, ptr %v275.p
  %st150 = getelementptr i64, ptr %v259, i64 0
  store i64 %v275, ptr %st150
  %v276.p = getelementptr i64, ptr %v250, i64 1
  %v276 = load i64, ptr %v276.p
  %st151 = getelementptr i64, ptr %v259, i64 1
  store i64 %v276, ptr %st151
  %v277.p = getelementptr i64, ptr %v250, i64 2
  %v277 = load i64, ptr %v277.p
  %st152 = getelementptr i64, ptr %v259, i64 2
  store i64 %v277, ptr %st152
  %v278.p = getelementptr i64, ptr %v250, i64 3
  %v278 = load i64, ptr %v278.p
  %st153 = getelementptr i64, ptr %v259, i64 3
  store i64 %v278, ptr %st153
  %v279.p = getelementptr i64, ptr %v225, i64 1
  %v279 = load i64, ptr %v279.p
  %v280 = add i64 0, 1
  %v281 = add i64 %v279, %v280
  %v282 = getelementptr i64, ptr %s18, i64 0
  %v283 = ptrtoint ptr %v258 to i64
  %st154 = getelementptr i64, ptr %v282, i64 0
  store i64 %v283, ptr %st154
  %st155 = getelementptr i64, ptr %v282, i64 1
  store i64 %v281, ptr %st155
  %st156 = getelementptr i64, ptr %v282, i64 2
  store i64 %v255, ptr %st156
  %v284.p = getelementptr i64, ptr %v282, i64 0
  %v284 = load i64, ptr %v284.p
  %st157 = getelementptr i64, ptr %v122, i64 0
  store i64 %v284, ptr %st157
  %v285.p = getelementptr i64, ptr %v282, i64 1
  %v285 = load i64, ptr %v285.p
  %st158 = getelementptr i64, ptr %v122, i64 1
  store i64 %v285, ptr %st158
  %v286.p = getelementptr i64, ptr %v282, i64 2
  %v286 = load i64, ptr %v286.p
  %st159 = getelementptr i64, ptr %v122, i64 2
  store i64 %v286, ptr %st159
  br label %b51
b49:
  %v269 = add i64 0, 4
  %v270 = mul i64 %v257, %v269
  %v271 = add i64 0, 4
  %v272 = add i64 0, 1
  %v273 = call ptr @"rt.slice_grow"(i64 %v256, i64 %v257, i64 %v271, i64 %v255, i64 %v272)
  %v274 = getelementptr i64, ptr %v273, i64 %v270
  br label %b48
b50:
  %v266 = add i64 0, 4
  %v267 = call ptr @"rt.region_alloc"(i64 %v255, i64 %v266)
  %v268 = inttoptr i64 %v256 to ptr
  br label %b48
b51:
  %v287 = add i64 0, 1
  %v288 = add i64 %v5, %v287
  %v289.p = getelementptr i64, ptr %v136, i64 0
  %v289 = load i64, ptr %v289.p
  %v290 = add i64 0, 1
  %v291 = add i64 %v289, %v290
  %st160 = getelementptr i64, ptr %v127, i64 0
  store i64 %v291, ptr %st160
  br label %b21
b52:
  %v451 = getelementptr i64, ptr @"rt.meta", i64 0
  %st161 = getelementptr i64, ptr %v451, i64 0
  store i64 %v294, ptr %st161
  %v295.p = getelementptr i64, ptr %v293, i64 0
  %v295 = load i64, ptr %v295.p
  %v296.p = getelementptr i64, ptr %v122, i64 1
  %v296 = load i64, ptr %v296.p
  %v297.c = icmp slt i64 %v295, %v296
  %v297 = zext i1 %v297.c to i64
  %c.b52 = icmp ne i64 %v297, 0
  br i1 %c.b52, label %b52.t163, label %b52.e164
b52.t163:
  br label %b53
b52.e164:
  br label %b54
b53:
  call void @"rt.region_enter"()
  %v452 = getelementptr i64, ptr @"rt.meta", i64 0
  %v298.p = getelementptr i64, ptr %v452, i64 0
  %v298 = load i64, ptr %v298.p
  %v299.p = getelementptr i64, ptr %v293, i64 0
  %v299 = load i64, ptr %v299.p
  %v300.p = getelementptr i64, ptr %v122, i64 1
  %v300 = load i64, ptr %v300.p
  %v301.c = icmp uge i64 %v299, %v300
  %v301 = zext i1 %v301.c to i64
  %c.b53 = icmp ne i64 %v301, 0
  br i1 %c.b53, label %b53.t165, label %b53.e166
b53.t165:
  br label %b55
b53.e166:
  br label %b56
b54:
  %v453 = getelementptr i64, ptr @"rt.meta", i64 0
  %st166 = getelementptr i64, ptr %v453, i64 0
  store i64 %v294, ptr %st166
  %v398 = getelementptr i64, ptr %s4, i64 0
  %v399 = add i64 0, 0
  %st167 = getelementptr i64, ptr %v398, i64 0
  store i64 %v399, ptr %st167
  %v400.p = getelementptr i64, ptr %v122, i64 0
  %v400 = load i64, ptr %v400.p
  %st168 = getelementptr i64, ptr %v0, i64 0
  store i64 %v400, ptr %st168
  %v401.p = getelementptr i64, ptr %v122, i64 1
  %v401 = load i64, ptr %v401.p
  %st169 = getelementptr i64, ptr %v0, i64 1
  store i64 %v401, ptr %st169
  %v402.p = getelementptr i64, ptr %v122, i64 2
  %v402 = load i64, ptr %v402.p
  %st170 = getelementptr i64, ptr %v0, i64 2
  store i64 %v402, ptr %st170
  %v403.p = getelementptr i64, ptr %v398, i64 0
  %v403 = load i64, ptr %v403.p
  %st171 = getelementptr i64, ptr %v0, i64 3
  store i64 %v403, ptr %st171
  %v404.p = getelementptr i64, ptr %v398, i64 1
  %v404 = load i64, ptr %v404.p
  %st172 = getelementptr i64, ptr %v0, i64 4
  store i64 %v404, ptr %st172
  %v405.p = getelementptr i64, ptr %v398, i64 2
  %v405 = load i64, ptr %v405.p
  %st173 = getelementptr i64, ptr %v0, i64 5
  store i64 %v405, ptr %st173
  %v406.p = getelementptr i64, ptr %v398, i64 3
  %v406 = load i64, ptr %v406.p
  %st174 = getelementptr i64, ptr %v0, i64 6
  store i64 %v406, ptr %st174
  %v407.p = getelementptr i64, ptr %v398, i64 4
  %v407 = load i64, ptr %v407.p
  %st175 = getelementptr i64, ptr %v0, i64 7
  store i64 %v407, ptr %st175
  %v408.p = getelementptr i64, ptr %v398, i64 5
  %v408 = load i64, ptr %v408.p
  %st176 = getelementptr i64, ptr %v0, i64 8
  store i64 %v408, ptr %st176
  %v409.p = getelementptr i64, ptr %v0, i64 2
  %v409 = load i64, ptr %v409.p
  %v410.c = icmp sgt i64 %v409, %v5
  %v410 = zext i1 %v410.c to i64
  %c.b54 = icmp ne i64 %v410, 0
  br i1 %c.b54, label %b54.t178, label %b54.e179
b54.t178:
  br label %b70
b54.e179:
  br label %b71
b55:
  %v302 = add i64 0, 17
  call void @"rt.panic"(i64 %v302)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b56:
  %v303.p = getelementptr i64, ptr %v122, i64 0
  %v303 = load i64, ptr %v303.p
  %v304 = inttoptr i64 %v303 to ptr
  %v305 = add i64 0, 4
  %v306 = mul i64 %v299, %v305
  %v307 = getelementptr i64, ptr %v304, i64 %v306
  %v308 = getelementptr i64, ptr %s16, i64 0
  %v309.p = getelementptr i64, ptr %v307, i64 0
  %v309 = load i64, ptr %v309.p
  %st179 = getelementptr i64, ptr %v308, i64 0
  store i64 %v309, ptr %st179
  %v310.p = getelementptr i64, ptr %v307, i64 1
  %v310 = load i64, ptr %v310.p
  %st180 = getelementptr i64, ptr %v308, i64 1
  store i64 %v310, ptr %st180
  %v311.p = getelementptr i64, ptr %v307, i64 2
  %v311 = load i64, ptr %v311.p
  %st181 = getelementptr i64, ptr %v308, i64 2
  store i64 %v311, ptr %st181
  %v312.p = getelementptr i64, ptr %v307, i64 3
  %v312 = load i64, ptr %v312.p
  %st182 = getelementptr i64, ptr %v308, i64 3
  store i64 %v312, ptr %st182
  %v313.p = getelementptr i64, ptr %v293, i64 0
  %v313 = load i64, ptr %v313.p
  %v314 = getelementptr i64, ptr %s15, i64 0
  %st183 = getelementptr i64, ptr %v314, i64 0
  store i64 %v313, ptr %st183
  %v454 = getelementptr i64, ptr @"rt.meta", i64 0
  %v315.p = getelementptr i64, ptr %v454, i64 0
  %v315 = load i64, ptr %v315.p
  br label %b57
b57:
  %v455 = getelementptr i64, ptr @"rt.meta", i64 0
  %st184 = getelementptr i64, ptr %v455, i64 0
  store i64 %v315, ptr %st184
  %v316.p = getelementptr i64, ptr %v314, i64 0
  %v316 = load i64, ptr %v316.p
  %v317 = add i64 0, 0
  %v318.c = icmp sgt i64 %v316, %v317
  %v318 = zext i1 %v318.c to i64
  %c.b57 = icmp ne i64 %v318, 0
  br i1 %c.b57, label %b57.t186, label %b57.e187
b57.t186:
  br label %b60
b57.e187:
  br label %b61
b58:
  call void @"rt.region_enter"()
  %v456 = getelementptr i64, ptr @"rt.meta", i64 0
  %v338.p = getelementptr i64, ptr %v456, i64 0
  %v338 = load i64, ptr %v338.p
  %v339.p = getelementptr i64, ptr %v314, i64 0
  %v339 = load i64, ptr %v339.p
  %v340.p = getelementptr i64, ptr %v314, i64 0
  %v340 = load i64, ptr %v340.p
  %v341 = add i64 0, 1
  %v342 = sub i64 %v340, %v341
  %v343.p = getelementptr i64, ptr %v122, i64 1
  %v343 = load i64, ptr %v343.p
  %v344.c = icmp uge i64 %v342, %v343
  %v344 = zext i1 %v344.c to i64
  %c.b58 = icmp ne i64 %v344, 0
  br i1 %c.b58, label %b58.t188, label %b58.e189
b58.t188:
  br label %b64
b58.e189:
  br label %b65
b59:
  %v457 = getelementptr i64, ptr @"rt.meta", i64 0
  %st189 = getelementptr i64, ptr %v457, i64 0
  store i64 %v315, ptr %st189
  %v372.p = getelementptr i64, ptr %v314, i64 0
  %v372 = load i64, ptr %v372.p
  %v373.p = getelementptr i64, ptr %v122, i64 1
  %v373 = load i64, ptr %v373.p
  %v374.c = icmp uge i64 %v372, %v373
  %v374 = zext i1 %v374.c to i64
  %c.b59 = icmp ne i64 %v374, 0
  br i1 %c.b59, label %b59.t191, label %b59.e192
b59.t191:
  br label %b68
b59.e192:
  br label %b69
b60:
  %v320.p = getelementptr i64, ptr %v308, i64 0
  %v320 = load i64, ptr %v320.p
  %v321.p = getelementptr i64, ptr %v308, i64 1
  %v321 = load i64, ptr %v321.p
  %v322.p = getelementptr i64, ptr %v308, i64 2
  %v322 = load i64, ptr %v322.p
  %v323.p = getelementptr i64, ptr %v314, i64 0
  %v323 = load i64, ptr %v323.p
  %v324 = add i64 0, 1
  %v325 = sub i64 %v323, %v324
  %v326.p = getelementptr i64, ptr %v122, i64 1
  %v326 = load i64, ptr %v326.p
  %v327.c = icmp uge i64 %v325, %v326
  %v327 = zext i1 %v327.c to i64
  %c.b60 = icmp ne i64 %v327, 0
  br i1 %c.b60, label %b60.t193, label %b60.e194
b60.t193:
  br label %b62
b60.e194:
  br label %b63
b61:
  %v319 = phi i64 [ %v318, %b57.e187 ], [ %v337, %b63 ]
  %c.b61 = icmp ne i64 %v319, 0
  br i1 %c.b61, label %b61.t195, label %b61.e196
b61.t195:
  br label %b58
b61.e196:
  br label %b59
b62:
  %v328 = add i64 0, 18
  call void @"rt.panic"(i64 %v328)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b63:
  %v329.p = getelementptr i64, ptr %v122, i64 0
  %v329 = load i64, ptr %v329.p
  %v330 = inttoptr i64 %v329 to ptr
  %v331 = add i64 0, 4
  %v332 = mul i64 %v325, %v331
  %v333 = getelementptr i64, ptr %v330, i64 %v332
  %v334.p = getelementptr i64, ptr %v333, i64 0
  %v334 = load i64, ptr %v334.p
  %v335.p = getelementptr i64, ptr %v333, i64 1
  %v335 = load i64, ptr %v335.p
  %v336.p = getelementptr i64, ptr %v333, i64 2
  %v336 = load i64, ptr %v336.p
  %v337 = call i64 @"std/io.less"(i64 %v320, i64 %v321, i64 %v322, i64 %v334, i64 %v335, i64 %v336)
  br label %b61
b64:
  %v345 = add i64 0, 19
  call void @"rt.panic"(i64 %v345)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b65:
  %v346.p = getelementptr i64, ptr %v122, i64 0
  %v346 = load i64, ptr %v346.p
  %v347 = inttoptr i64 %v346 to ptr
  %v348 = add i64 0, 4
  %v349 = mul i64 %v342, %v348
  %v350 = getelementptr i64, ptr %v347, i64 %v349
  %v351.p = getelementptr i64, ptr %v122, i64 1
  %v351 = load i64, ptr %v351.p
  %v352.c = icmp uge i64 %v339, %v351
  %v352 = zext i1 %v352.c to i64
  %c.b65 = icmp ne i64 %v352, 0
  br i1 %c.b65, label %b65.t197, label %b65.e198
b65.t197:
  br label %b66
b65.e198:
  br label %b67
b66:
  %v353 = add i64 0, 20
  call void @"rt.panic"(i64 %v353)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b67:
  %v354 = getelementptr i64, ptr %s19, i64 0
  %v355.p = getelementptr i64, ptr %v350, i64 0
  %v355 = load i64, ptr %v355.p
  %st198 = getelementptr i64, ptr %v354, i64 0
  store i64 %v355, ptr %st198
  %v356.p = getelementptr i64, ptr %v350, i64 1
  %v356 = load i64, ptr %v356.p
  %st199 = getelementptr i64, ptr %v354, i64 1
  store i64 %v356, ptr %st199
  %v357.p = getelementptr i64, ptr %v350, i64 2
  %v357 = load i64, ptr %v357.p
  %st200 = getelementptr i64, ptr %v354, i64 2
  store i64 %v357, ptr %st200
  %v358.p = getelementptr i64, ptr %v350, i64 3
  %v358 = load i64, ptr %v358.p
  %st201 = getelementptr i64, ptr %v354, i64 3
  store i64 %v358, ptr %st201
  %v359.p = getelementptr i64, ptr %v122, i64 2
  %v359 = load i64, ptr %v359.p
  call void @"rt.region_relocate8"(ptr %v354, i64 %v359)
  %v360.p = getelementptr i64, ptr %v122, i64 0
  %v360 = load i64, ptr %v360.p
  %v361 = inttoptr i64 %v360 to ptr
  %v362 = add i64 0, 4
  %v363 = mul i64 %v339, %v362
  %v364 = getelementptr i64, ptr %v361, i64 %v363
  %v365.p = getelementptr i64, ptr %v354, i64 0
  %v365 = load i64, ptr %v365.p
  %st202 = getelementptr i64, ptr %v364, i64 0
  store i64 %v365, ptr %st202
  %v366.p = getelementptr i64, ptr %v354, i64 1
  %v366 = load i64, ptr %v366.p
  %st203 = getelementptr i64, ptr %v364, i64 1
  store i64 %v366, ptr %st203
  %v367.p = getelementptr i64, ptr %v354, i64 2
  %v367 = load i64, ptr %v367.p
  %st204 = getelementptr i64, ptr %v364, i64 2
  store i64 %v367, ptr %st204
  %v368.p = getelementptr i64, ptr %v354, i64 3
  %v368 = load i64, ptr %v368.p
  %st205 = getelementptr i64, ptr %v364, i64 3
  store i64 %v368, ptr %st205
  %v369 = add i64 0, 1
  %v370.p = getelementptr i64, ptr %v314, i64 0
  %v370 = load i64, ptr %v370.p
  %v371 = sub i64 %v370, %v369
  %st206 = getelementptr i64, ptr %v314, i64 0
  store i64 %v371, ptr %st206
  br label %b57
b68:
  %v375 = add i64 0, 21
  call void @"rt.panic"(i64 %v375)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b69:
  %v376 = getelementptr i64, ptr %s20, i64 0
  %v377.p = getelementptr i64, ptr %v308, i64 0
  %v377 = load i64, ptr %v377.p
  %st207 = getelementptr i64, ptr %v376, i64 0
  store i64 %v377, ptr %st207
  %v378.p = getelementptr i64, ptr %v308, i64 1
  %v378 = load i64, ptr %v378.p
  %st208 = getelementptr i64, ptr %v376, i64 1
  store i64 %v378, ptr %st208
  %v379.p = getelementptr i64, ptr %v308, i64 2
  %v379 = load i64, ptr %v379.p
  %st209 = getelementptr i64, ptr %v376, i64 2
  store i64 %v379, ptr %st209
  %v380.p = getelementptr i64, ptr %v308, i64 3
  %v380 = load i64, ptr %v380.p
  %st210 = getelementptr i64, ptr %v376, i64 3
  store i64 %v380, ptr %st210
  %v381.p = getelementptr i64, ptr %v122, i64 2
  %v381 = load i64, ptr %v381.p
  call void @"rt.region_relocate8"(ptr %v376, i64 %v381)
  %v382.p = getelementptr i64, ptr %v376, i64 0
  %v382 = load i64, ptr %v382.p
  %st211 = getelementptr i64, ptr %v308, i64 0
  store i64 %v382, ptr %st211
  %v383.p = getelementptr i64, ptr %v376, i64 1
  %v383 = load i64, ptr %v383.p
  %st212 = getelementptr i64, ptr %v308, i64 1
  store i64 %v383, ptr %st212
  %v384.p = getelementptr i64, ptr %v376, i64 2
  %v384 = load i64, ptr %v384.p
  %st213 = getelementptr i64, ptr %v308, i64 2
  store i64 %v384, ptr %st213
  %v385.p = getelementptr i64, ptr %v376, i64 3
  %v385 = load i64, ptr %v385.p
  %st214 = getelementptr i64, ptr %v308, i64 3
  store i64 %v385, ptr %st214
  %v386.p = getelementptr i64, ptr %v122, i64 0
  %v386 = load i64, ptr %v386.p
  %v387 = inttoptr i64 %v386 to ptr
  %v388 = add i64 0, 4
  %v389 = mul i64 %v372, %v388
  %v390 = getelementptr i64, ptr %v387, i64 %v389
  %v391.p = getelementptr i64, ptr %v376, i64 0
  %v391 = load i64, ptr %v391.p
  %st215 = getelementptr i64, ptr %v390, i64 0
  store i64 %v391, ptr %st215
  %v392.p = getelementptr i64, ptr %v376, i64 1
  %v392 = load i64, ptr %v392.p
  %st216 = getelementptr i64, ptr %v390, i64 1
  store i64 %v392, ptr %st216
  %v393.p = getelementptr i64, ptr %v376, i64 2
  %v393 = load i64, ptr %v393.p
  %st217 = getelementptr i64, ptr %v390, i64 2
  store i64 %v393, ptr %st217
  %v394.p = getelementptr i64, ptr %v376, i64 3
  %v394 = load i64, ptr %v394.p
  %st218 = getelementptr i64, ptr %v390, i64 3
  store i64 %v394, ptr %st218
  %v395 = add i64 0, 1
  %v396.p = getelementptr i64, ptr %v293, i64 0
  %v396 = load i64, ptr %v396.p
  %v397 = add i64 %v396, %v395
  %st219 = getelementptr i64, ptr %v293, i64 0
  store i64 %v397, ptr %st219
  br label %b52
b70:
  %v411.p = getelementptr i64, ptr %v0, i64 0
  %v411 = load i64, ptr %v411.p
  %v412 = inttoptr i64 %v411 to ptr
  %v413.p = getelementptr i64, ptr %v0, i64 1
  %v413 = load i64, ptr %v413.p
  %v415 = add i64 0, 0
  br label %b72
b71:
  %v422.p = getelementptr i64, ptr %v0, i64 3
  %v422 = load i64, ptr %v422.p
  %v423 = add i64 0, 0
  %v424.c = icmp ne i64 %v422, %v423
  %v424 = zext i1 %v424.c to i64
  %c.b71 = icmp ne i64 %v424, 0
  br i1 %c.b71, label %b71.t221, label %b71.e222
b71.t221:
  br label %b75
b71.e222:
  br label %b76
b72:
  %v414 = phi i64 [ %v415, %b70 ], [ %v421, %b73 ]
  %v416.c = icmp slt i64 %v414, %v413
  %v416 = zext i1 %v416.c to i64
  %c.b72 = icmp ne i64 %v416, 0
  br i1 %c.b72, label %b72.t223, label %b72.e224
b72.t223:
  br label %b73
b72.e224:
  br label %b74
b73:
  %v417 = add i64 0, 4
  %v418 = mul i64 %v414, %v417
  %v419 = getelementptr i64, ptr %v412, i64 %v418
  call void @"rt.region_relocate8"(ptr %v419, i64 %v5)
  %v420 = add i64 0, 1
  %v421 = add i64 %v414, %v420
  br label %b72
b74:
  %v458 = add i64 0, 4
  call void @"rt.region_relocate"(ptr %v0, i64 %v458, i64 %v5)
  br label %b71
b75:
  %v425 = add i64 0, 4
  %v426 = getelementptr i64, ptr %v0, i64 %v425
  call void @"rt.err_relocate"(ptr %v426, i64 %v5)
  br label %b76
b76:
  %v459 = getelementptr i64, ptr @"rt.meta", i64 0
  %st224 = getelementptr i64, ptr %v459, i64 0
  store i64 %v5, ptr %st224
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
  %v54 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v54, i64 0
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
  %v13 = add i64 0, 9223372036854775807
  %v14 = add i64 0, 0
  %v15 = sub i64 %v14, %v13
  %v16 = add i64 0, 1
  %v17 = sub i64 %v15, %v16
  %v18.c = icmp eq i64 %v1, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v19 = getelementptr i64, ptr @"str.8", i64 0
  %v20 = add i64 0, 20
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s0, i64 0
  %v23 = ptrtoint ptr %v19 to i64
  %st3 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st3
  %st4 = getelementptr i64, ptr %v22, i64 1
  store i64 %v20, ptr %st4
  %st5 = getelementptr i64, ptr %v22, i64 2
  store i64 %v21, ptr %st5
  br label %b6
b2:
  %v24 = add i64 0, 0
  %v25.c = icmp slt i64 %v1, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b2 = icmp ne i64 %v25, 0
  br i1 %c.b2, label %b2.t7, label %b2.e8
b2.t7:
  br label %b3
b2.e8:
  br label %b4
b3:
  %v26 = getelementptr i64, ptr @"str.1", i64 0
  %v27 = add i64 0, 1
  %v28 = add i64 0, 0
  %v29 = getelementptr i64, ptr %s1, i64 0
  %v30 = ptrtoint ptr %v26 to i64
  %st8 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st8
  %st9 = getelementptr i64, ptr %v29, i64 1
  store i64 %v27, ptr %st9
  %st10 = getelementptr i64, ptr %v29, i64 2
  store i64 %v28, ptr %st10
  %v31 = getelementptr i64, ptr %s2, i64 0
  %v32 = add i64 0, 0
  %v33 = sub i64 %v32, %v1
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v34, i64 2571
  store i64 %v12, ptr %st11
  call void @"std/convert.formatUint"(ptr %v31, i64 %v33)
  %v35.p = getelementptr i64, ptr %v29, i64 1
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v31, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 %v35, %v36
  %v38.p = getelementptr i64, ptr %v29, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v29, i64 1
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v29, i64 2
  %v40 = load i64, ptr %v40.p
  %v41 = call ptr @"rt.cat8"(i64 %v38, i64 %v39, i64 %v40, i64 %v12, i64 %v36)
  %v42 = getelementptr i8, ptr %v41, i64 %v35
  %v43.p = getelementptr i64, ptr %v31, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = inttoptr i64 %v43 to ptr
  call void @"rt.copy8"(ptr %v42, ptr %v44, i64 %v36)
  %v45 = getelementptr i64, ptr %s3, i64 0
  %v46 = ptrtoint ptr %v41 to i64
  %st12 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st12
  %st13 = getelementptr i64, ptr %v45, i64 1
  store i64 %v37, ptr %st13
  %st14 = getelementptr i64, ptr %v45, i64 2
  store i64 %v12, ptr %st14
  br label %b5
b4:
  %v47 = getelementptr i64, ptr %s4, i64 0
  %v48 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v48, i64 2571
  store i64 %v12, ptr %st15
  call void @"std/convert.formatUint"(ptr %v47, i64 %v1)
  br label %b5
b5:
  %v49 = phi ptr [ %v45, %b3 ], [ %v47, %b4 ]
  br label %b6
b6:
  %v50 = phi ptr [ %v22, %b1 ], [ %v49, %b5 ]
  %v51.p = getelementptr i64, ptr %v50, i64 0
  %v51 = load i64, ptr %v51.p
  %st16 = getelementptr i64, ptr %v0, i64 0
  store i64 %v51, ptr %st16
  %v52.p = getelementptr i64, ptr %v50, i64 1
  %v52 = load i64, ptr %v52.p
  %st17 = getelementptr i64, ptr %v0, i64 1
  store i64 %v52, ptr %st17
  %v53.p = getelementptr i64, ptr %v50, i64 2
  %v53 = load i64, ptr %v53.p
  %st18 = getelementptr i64, ptr %v0, i64 2
  store i64 %v53, ptr %st18
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v55 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v55, i64 0
  store i64 %v2, ptr %st19
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
  %v166 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v166, i64 0
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
  %v14 = call ptr @"rt.region_alloc8"(i64 %v12, i64 %v13)
  %v15 = add i64 0, 0
  %v16 = getelementptr i64, ptr %s0, i64 0
  %v17 = ptrtoint ptr %v14 to i64
  %st1 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st1
  %st2 = getelementptr i64, ptr %v16, i64 1
  store i64 %v15, ptr %st2
  %st3 = getelementptr i64, ptr %v16, i64 2
  store i64 %v12, ptr %st3
  %v18 = getelementptr i64, ptr %s1, i64 0
  %v19.p = getelementptr i64, ptr %v16, i64 0
  %v19 = load i64, ptr %v19.p
  %st4 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st4
  %v20.p = getelementptr i64, ptr %v16, i64 1
  %v20 = load i64, ptr %v20.p
  %st5 = getelementptr i64, ptr %v18, i64 1
  store i64 %v20, ptr %st5
  %v21.p = getelementptr i64, ptr %v16, i64 2
  %v21 = load i64, ptr %v21.p
  %st6 = getelementptr i64, ptr %v18, i64 2
  store i64 %v21, ptr %st6
  %v22 = getelementptr i64, ptr %s2, i64 0
  %st7 = getelementptr i64, ptr %v22, i64 0
  store i64 %v1, ptr %st7
  %v23 = getelementptr i64, ptr %s0, i64 0
  %v24.p = getelementptr i64, ptr %v18, i64 0
  %v24 = load i64, ptr %v24.p
  %st8 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st8
  %v25.p = getelementptr i64, ptr %v18, i64 1
  %v25 = load i64, ptr %v25.p
  %st9 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st9
  %v26.p = getelementptr i64, ptr %v18, i64 2
  %v26 = load i64, ptr %v26.p
  %st10 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st10
  %v27 = add i64 0, 48
  %v28.p = getelementptr i64, ptr %v22, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 10
  %v30 = srem i64 %v28, %v29
  %v31 = add i64 %v27, %v30
  %v32 = add i64 0, 256
  %v33.c = icmp uge i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b0 = icmp ne i64 %v33, 0
  br i1 %c.b0, label %b0.t12, label %b0.e13
b0.t12:
  br label %b1
b0.e13:
  br label %b2
b1:
  %v34 = add i64 0, 22
  call void @"rt.panic"(i64 %v34)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v35.p = getelementptr i64, ptr %v23, i64 2
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v23, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v23, i64 1
  %v37 = load i64, ptr %v37.p
  %v40 = add i64 %v36, %v37
  %v41 = call i64 @"rt.tip8"(i64 %v35, i64 %v40)
  %v42 = add i64 0, 0
  %v43.c = icmp ne i64 %v41, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b2 = icmp ne i64 %v43, 0
  br i1 %c.b2, label %b2.t14, label %b2.e15
b2.t14:
  br label %b5
b2.e15:
  br label %b4
b3:
  %v38 = phi ptr [ %v47, %b4 ], [ %v44, %b5 ]
  %v39 = phi ptr [ %v48, %b4 ], [ %v45, %b5 ]
  %st15 = getelementptr i8, ptr %v39, i64 0
  %st15.b = trunc i64 %v31 to i8
  store i8 %st15.b, ptr %st15
  %v49.p = getelementptr i64, ptr %v23, i64 1
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 1
  %v51 = add i64 %v49, %v50
  %v52 = getelementptr i64, ptr %s3, i64 0
  %v53 = ptrtoint ptr %v38 to i64
  %st16 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st16
  %st17 = getelementptr i64, ptr %v52, i64 1
  store i64 %v51, ptr %st17
  %st18 = getelementptr i64, ptr %v52, i64 2
  store i64 %v35, ptr %st18
  %v54.p = getelementptr i64, ptr %v52, i64 0
  %v54 = load i64, ptr %v54.p
  %st19 = getelementptr i64, ptr %v18, i64 0
  store i64 %v54, ptr %st19
  %v55.p = getelementptr i64, ptr %v52, i64 1
  %v55 = load i64, ptr %v55.p
  %st20 = getelementptr i64, ptr %v18, i64 1
  store i64 %v55, ptr %st20
  %v56.p = getelementptr i64, ptr %v52, i64 2
  %v56 = load i64, ptr %v56.p
  %st21 = getelementptr i64, ptr %v18, i64 2
  store i64 %v56, ptr %st21
  %v57.p = getelementptr i64, ptr %v22, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 0, 10
  %v59 = sdiv i64 %v57, %v58
  %st22 = getelementptr i64, ptr %v22, i64 0
  store i64 %v59, ptr %st22
  %v167 = getelementptr i64, ptr @"rt.meta", i64 0
  %v60.p = getelementptr i64, ptr %v167, i64 0
  %v60 = load i64, ptr %v60.p
  br label %b6
b4:
  %v46 = add i64 0, 1
  %v47 = call ptr @"rt.slice_grow8"(i64 %v36, i64 %v37, i64 %v35, i64 %v46)
  %v48 = getelementptr i8, ptr %v47, i64 %v37
  br label %b3
b5:
  %v44 = inttoptr i64 %v36 to ptr
  %v45 = getelementptr i8, ptr %v44, i64 %v37
  br label %b3
b6:
  %v168 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v168, i64 0
  store i64 %v60, ptr %st23
  %v61.p = getelementptr i64, ptr %v22, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 0
  %v63.c = icmp sgt i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b6 = icmp ne i64 %v63, 0
  br i1 %c.b6, label %b6.t25, label %b6.e26
b6.t25:
  br label %b7
b6.e26:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v169 = getelementptr i64, ptr @"rt.meta", i64 0
  %v64.p = getelementptr i64, ptr %v169, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 1
  %v66 = add i64 %v2, %v65
  %v67 = getelementptr i64, ptr %s3, i64 0
  %v68.p = getelementptr i64, ptr %v18, i64 0
  %v68 = load i64, ptr %v68.p
  %st26 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st26
  %v69.p = getelementptr i64, ptr %v18, i64 1
  %v69 = load i64, ptr %v69.p
  %st27 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st27
  %v70.p = getelementptr i64, ptr %v18, i64 2
  %v70 = load i64, ptr %v70.p
  %st28 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st28
  %v71 = add i64 0, 48
  %v72.p = getelementptr i64, ptr %v22, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 10
  %v74 = srem i64 %v72, %v73
  %v75 = add i64 %v71, %v74
  %v76 = add i64 0, 256
  %v77.c = icmp uge i64 %v75, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b7 = icmp ne i64 %v77, 0
  br i1 %c.b7, label %b7.t30, label %b7.e31
b7.t30:
  br label %b9
b7.e31:
  br label %b10
b8:
  %v170 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v170, i64 0
  store i64 %v60, ptr %st31
  %v106 = add i64 0, 0
  %v107 = call ptr @"rt.region_alloc8"(i64 %v12, i64 %v106)
  %v108 = add i64 0, 0
  %v109 = getelementptr i64, ptr %s0, i64 0
  %v110 = ptrtoint ptr %v107 to i64
  %st32 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st32
  %st33 = getelementptr i64, ptr %v109, i64 1
  store i64 %v108, ptr %st33
  %st34 = getelementptr i64, ptr %v109, i64 2
  store i64 %v12, ptr %st34
  %v111 = getelementptr i64, ptr %s3, i64 0
  %v112.p = getelementptr i64, ptr %v109, i64 0
  %v112 = load i64, ptr %v112.p
  %st35 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st35
  %v113.p = getelementptr i64, ptr %v109, i64 1
  %v113 = load i64, ptr %v113.p
  %st36 = getelementptr i64, ptr %v111, i64 1
  store i64 %v113, ptr %st36
  %v114.p = getelementptr i64, ptr %v109, i64 2
  %v114 = load i64, ptr %v114.p
  %st37 = getelementptr i64, ptr %v111, i64 2
  store i64 %v114, ptr %st37
  %v115.p = getelementptr i64, ptr %v18, i64 1
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 1
  %v117 = sub i64 %v115, %v116
  %v118 = getelementptr i64, ptr %s4, i64 0
  %st38 = getelementptr i64, ptr %v118, i64 0
  store i64 %v117, ptr %st38
  %v171 = getelementptr i64, ptr @"rt.meta", i64 0
  %v119.p = getelementptr i64, ptr %v171, i64 0
  %v119 = load i64, ptr %v119.p
  br label %b14
b9:
  %v78 = add i64 0, 23
  call void @"rt.panic"(i64 %v78)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v79.p = getelementptr i64, ptr %v67, i64 2
  %v79 = load i64, ptr %v79.p
  %v80.p = getelementptr i64, ptr %v67, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v67, i64 1
  %v81 = load i64, ptr %v81.p
  %v84 = add i64 %v80, %v81
  %v85 = call i64 @"rt.tip8"(i64 %v79, i64 %v84)
  %v86 = add i64 0, 0
  %v87.c = icmp ne i64 %v85, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b10 = icmp ne i64 %v87, 0
  br i1 %c.b10, label %b10.t40, label %b10.e41
b10.t40:
  br label %b13
b10.e41:
  br label %b12
b11:
  %v82 = phi ptr [ %v91, %b12 ], [ %v88, %b13 ]
  %v83 = phi ptr [ %v92, %b12 ], [ %v89, %b13 ]
  %st41 = getelementptr i8, ptr %v83, i64 0
  %st41.b = trunc i64 %v75 to i8
  store i8 %st41.b, ptr %st41
  %v93.p = getelementptr i64, ptr %v67, i64 1
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 1
  %v95 = add i64 %v93, %v94
  %v96 = getelementptr i64, ptr %s0, i64 0
  %v97 = ptrtoint ptr %v82 to i64
  %st42 = getelementptr i64, ptr %v96, i64 0
  store i64 %v97, ptr %st42
  %st43 = getelementptr i64, ptr %v96, i64 1
  store i64 %v95, ptr %st43
  %st44 = getelementptr i64, ptr %v96, i64 2
  store i64 %v79, ptr %st44
  %v98.p = getelementptr i64, ptr %v96, i64 0
  %v98 = load i64, ptr %v98.p
  %st45 = getelementptr i64, ptr %v18, i64 0
  store i64 %v98, ptr %st45
  %v99.p = getelementptr i64, ptr %v96, i64 1
  %v99 = load i64, ptr %v99.p
  %st46 = getelementptr i64, ptr %v18, i64 1
  store i64 %v99, ptr %st46
  %v100.p = getelementptr i64, ptr %v96, i64 2
  %v100 = load i64, ptr %v100.p
  %st47 = getelementptr i64, ptr %v18, i64 2
  store i64 %v100, ptr %st47
  %v101 = add i64 0, 1
  %v102 = add i64 %v2, %v101
  %v103.p = getelementptr i64, ptr %v22, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 10
  %v105 = sdiv i64 %v103, %v104
  %st48 = getelementptr i64, ptr %v22, i64 0
  store i64 %v105, ptr %st48
  br label %b6
b12:
  %v90 = add i64 0, 1
  %v91 = call ptr @"rt.slice_grow8"(i64 %v80, i64 %v81, i64 %v79, i64 %v90)
  %v92 = getelementptr i8, ptr %v91, i64 %v81
  br label %b11
b13:
  %v88 = inttoptr i64 %v80 to ptr
  %v89 = getelementptr i8, ptr %v88, i64 %v81
  br label %b11
b14:
  %v172 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v172, i64 0
  store i64 %v119, ptr %st49
  %v120.p = getelementptr i64, ptr %v118, i64 0
  %v120 = load i64, ptr %v120.p
  %v121 = add i64 0, 0
  %v122.c = icmp sge i64 %v120, %v121
  %v122 = zext i1 %v122.c to i64
  %c.b14 = icmp ne i64 %v122, 0
  br i1 %c.b14, label %b14.t51, label %b14.e52
b14.t51:
  br label %b15
b14.e52:
  br label %b16
b15:
  call void @"rt.region_enter"()
  %v173 = getelementptr i64, ptr @"rt.meta", i64 0
  %v123.p = getelementptr i64, ptr %v173, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 0, 1
  %v125 = add i64 %v2, %v124
  %v126 = getelementptr i64, ptr %s0, i64 0
  %v127.p = getelementptr i64, ptr %v111, i64 0
  %v127 = load i64, ptr %v127.p
  %st52 = getelementptr i64, ptr %v126, i64 0
  store i64 %v127, ptr %st52
  %v128.p = getelementptr i64, ptr %v111, i64 1
  %v128 = load i64, ptr %v128.p
  %st53 = getelementptr i64, ptr %v126, i64 1
  store i64 %v128, ptr %st53
  %v129.p = getelementptr i64, ptr %v111, i64 2
  %v129 = load i64, ptr %v129.p
  %st54 = getelementptr i64, ptr %v126, i64 2
  store i64 %v129, ptr %st54
  %v130.p = getelementptr i64, ptr %v118, i64 0
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v18, i64 1
  %v131 = load i64, ptr %v131.p
  %v132.c = icmp uge i64 %v130, %v131
  %v132 = zext i1 %v132.c to i64
  %c.b15 = icmp ne i64 %v132, 0
  br i1 %c.b15, label %b15.t56, label %b15.e57
b15.t56:
  br label %b17
b15.e57:
  br label %b18
b16:
  %v174 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v174, i64 0
  store i64 %v119, ptr %st57
  %v163.p = getelementptr i64, ptr %v111, i64 0
  %v163 = load i64, ptr %v163.p
  %st58 = getelementptr i64, ptr %v0, i64 0
  store i64 %v163, ptr %st58
  %v164.p = getelementptr i64, ptr %v111, i64 1
  %v164 = load i64, ptr %v164.p
  %st59 = getelementptr i64, ptr %v0, i64 1
  store i64 %v164, ptr %st59
  %v165.p = getelementptr i64, ptr %v111, i64 2
  %v165 = load i64, ptr %v165.p
  %st60 = getelementptr i64, ptr %v0, i64 2
  store i64 %v165, ptr %st60
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v175 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v175, i64 0
  store i64 %v2, ptr %st61
  ret void
b17:
  %v133 = add i64 0, 24
  call void @"rt.panic"(i64 %v133)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v134.p = getelementptr i64, ptr %v18, i64 0
  %v134 = load i64, ptr %v134.p
  %v135 = inttoptr i64 %v134 to ptr
  %v136 = getelementptr i8, ptr %v135, i64 %v130
  %v137.p = getelementptr i8, ptr %v136, i64 0
  %v137.b = load i8, ptr %v137.p
  %v137 = zext i8 %v137.b to i64
  %v138.p = getelementptr i64, ptr %v126, i64 2
  %v138 = load i64, ptr %v138.p
  %v139.p = getelementptr i64, ptr %v126, i64 0
  %v139 = load i64, ptr %v139.p
  %v140.p = getelementptr i64, ptr %v126, i64 1
  %v140 = load i64, ptr %v140.p
  %v143 = add i64 %v139, %v140
  %v144 = call i64 @"rt.tip8"(i64 %v138, i64 %v143)
  %v145 = add i64 0, 0
  %v146.c = icmp ne i64 %v144, %v145
  %v146 = zext i1 %v146.c to i64
  %c.b18 = icmp ne i64 %v146, 0
  br i1 %c.b18, label %b18.t63, label %b18.e64
b18.t63:
  br label %b21
b18.e64:
  br label %b20
b19:
  %v141 = phi ptr [ %v150, %b20 ], [ %v147, %b21 ]
  %v142 = phi ptr [ %v151, %b20 ], [ %v148, %b21 ]
  %st64 = getelementptr i8, ptr %v142, i64 0
  %st64.b = trunc i64 %v137 to i8
  store i8 %st64.b, ptr %st64
  %v152.p = getelementptr i64, ptr %v126, i64 1
  %v152 = load i64, ptr %v152.p
  %v153 = add i64 0, 1
  %v154 = add i64 %v152, %v153
  %v155 = getelementptr i64, ptr %s5, i64 0
  %v156 = ptrtoint ptr %v141 to i64
  %st65 = getelementptr i64, ptr %v155, i64 0
  store i64 %v156, ptr %st65
  %st66 = getelementptr i64, ptr %v155, i64 1
  store i64 %v154, ptr %st66
  %st67 = getelementptr i64, ptr %v155, i64 2
  store i64 %v138, ptr %st67
  %v157.p = getelementptr i64, ptr %v155, i64 0
  %v157 = load i64, ptr %v157.p
  %st68 = getelementptr i64, ptr %v111, i64 0
  store i64 %v157, ptr %st68
  %v158.p = getelementptr i64, ptr %v155, i64 1
  %v158 = load i64, ptr %v158.p
  %st69 = getelementptr i64, ptr %v111, i64 1
  store i64 %v158, ptr %st69
  %v159.p = getelementptr i64, ptr %v155, i64 2
  %v159 = load i64, ptr %v159.p
  %st70 = getelementptr i64, ptr %v111, i64 2
  store i64 %v159, ptr %st70
  %v160 = add i64 0, 1
  %v161.p = getelementptr i64, ptr %v118, i64 0
  %v161 = load i64, ptr %v161.p
  %v162 = sub i64 %v161, %v160
  %st71 = getelementptr i64, ptr %v118, i64 0
  store i64 %v162, ptr %st71
  br label %b14
b20:
  %v149 = add i64 0, 1
  %v150 = call ptr @"rt.slice_grow8"(i64 %v139, i64 %v140, i64 %v138, i64 %v149)
  %v151 = getelementptr i8, ptr %v150, i64 %v140
  br label %b19
b21:
  %v147 = inttoptr i64 %v139 to ptr
  %v148 = getelementptr i8, ptr %v147, i64 %v140
  br label %b19
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
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v75, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2571
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v6, i64 2571
  store i64 %v8, ptr %st3
  %v9 = add i64 0, 1
  %v10.c = icmp sge i64 %v7, %v9
  %v10 = zext i1 %v10.c to i64
  %v11.c = icmp sle i64 %v7, %v5
  %v11 = zext i1 %v11.c to i64
  %v12 = and i64 %v10, %v11
  %v13 = sub i64 %v7, %v5
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v5, %v14
  call void @"rt.region_enter"()
  %v16.p = getelementptr i64, ptr %v4, i64 0
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v4, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v4, i64 2
  %v18 = load i64, ptr %v18.p
  %v19 = call i64 @"std/strings.IndexInvalid"(i64 %v16, i64 %v17, i64 %v18)
  %v20 = add i64 0, 0
  %v21.c = icmp sge i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b0 = icmp ne i64 %v21, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v22 = getelementptr i64, ptr @"str.0", i64 0
  %v23 = add i64 0, 0
  %v24 = add i64 0, 0
  %v25 = getelementptr i64, ptr %s1, i64 0
  %v26 = ptrtoint ptr %v22 to i64
  %st6 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st6
  %st7 = getelementptr i64, ptr %v25, i64 1
  store i64 %v23, ptr %st7
  %st8 = getelementptr i64, ptr %v25, i64 2
  store i64 %v24, ptr %st8
  %v27 = getelementptr i64, ptr %s2, i64 0
  %v28 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st9
  %st10 = getelementptr i64, ptr %v27, i64 1
  store i64 %v28, ptr %st10
  %v29 = add i64 0, 11
  %st11 = getelementptr i64, ptr %v27, i64 0
  store i64 %v29, ptr %st11
  %st12 = getelementptr i64, ptr %v27, i64 1
  store i64 %v19, ptr %st12
  %v30 = getelementptr i64, ptr %s3, i64 0
  %v31.p = getelementptr i64, ptr %v27, i64 0
  %v31 = load i64, ptr %v31.p
  %st13 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st13
  %v32.p = getelementptr i64, ptr %v27, i64 1
  %v32 = load i64, ptr %v32.p
  %st14 = getelementptr i64, ptr %v30, i64 1
  store i64 %v32, ptr %st14
  %v33 = add i64 0, 0
  %st15 = getelementptr i64, ptr %v30, i64 2
  store i64 %v33, ptr %st15
  %st16 = getelementptr i64, ptr %v30, i64 3
  store i64 %v33, ptr %st16
  %st17 = getelementptr i64, ptr %v30, i64 4
  store i64 %v33, ptr %st17
  %v34 = getelementptr i64, ptr %s4, i64 0
  %v35 = add i64 0, 1
  %st18 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st18
  %v36.p = getelementptr i64, ptr %v30, i64 0
  %v36 = load i64, ptr %v36.p
  %st19 = getelementptr i64, ptr %v34, i64 1
  store i64 %v36, ptr %st19
  %v37.p = getelementptr i64, ptr %v30, i64 1
  %v37 = load i64, ptr %v37.p
  %st20 = getelementptr i64, ptr %v34, i64 2
  store i64 %v37, ptr %st20
  %v38.p = getelementptr i64, ptr %v30, i64 2
  %v38 = load i64, ptr %v38.p
  %st21 = getelementptr i64, ptr %v34, i64 3
  store i64 %v38, ptr %st21
  %v39.p = getelementptr i64, ptr %v30, i64 3
  %v39 = load i64, ptr %v39.p
  %st22 = getelementptr i64, ptr %v34, i64 4
  store i64 %v39, ptr %st22
  %v40.p = getelementptr i64, ptr %v30, i64 4
  %v40 = load i64, ptr %v40.p
  %st23 = getelementptr i64, ptr %v34, i64 5
  store i64 %v40, ptr %st23
  %v41.p = getelementptr i64, ptr %v25, i64 0
  %v41 = load i64, ptr %v41.p
  %st24 = getelementptr i64, ptr %v0, i64 0
  store i64 %v41, ptr %st24
  %v42.p = getelementptr i64, ptr %v25, i64 1
  %v42 = load i64, ptr %v42.p
  %st25 = getelementptr i64, ptr %v0, i64 1
  store i64 %v42, ptr %st25
  %v43.p = getelementptr i64, ptr %v25, i64 2
  %v43 = load i64, ptr %v43.p
  %st26 = getelementptr i64, ptr %v0, i64 2
  store i64 %v43, ptr %st26
  %v44.p = getelementptr i64, ptr %v34, i64 0
  %v44 = load i64, ptr %v44.p
  %st27 = getelementptr i64, ptr %v0, i64 3
  store i64 %v44, ptr %st27
  %v45.p = getelementptr i64, ptr %v34, i64 1
  %v45 = load i64, ptr %v45.p
  %st28 = getelementptr i64, ptr %v0, i64 4
  store i64 %v45, ptr %st28
  %v46.p = getelementptr i64, ptr %v34, i64 2
  %v46 = load i64, ptr %v46.p
  %st29 = getelementptr i64, ptr %v0, i64 5
  store i64 %v46, ptr %st29
  %v47.p = getelementptr i64, ptr %v34, i64 3
  %v47 = load i64, ptr %v47.p
  %st30 = getelementptr i64, ptr %v0, i64 6
  store i64 %v47, ptr %st30
  %v48.p = getelementptr i64, ptr %v34, i64 4
  %v48 = load i64, ptr %v48.p
  %st31 = getelementptr i64, ptr %v0, i64 7
  store i64 %v48, ptr %st31
  %v49.p = getelementptr i64, ptr %v34, i64 5
  %v49 = load i64, ptr %v49.p
  %st32 = getelementptr i64, ptr %v0, i64 8
  store i64 %v49, ptr %st32
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v50.p = getelementptr i64, ptr %v0, i64 3
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 0
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b1 = icmp ne i64 %v52, 0
  br i1 %c.b1, label %b1.t34, label %b1.e35
b1.t34:
  br label %b3
b1.e35:
  br label %b4
b2:
  br label %b5
b3:
  %v53 = add i64 0, 4
  %v54 = getelementptr i64, ptr %v0, i64 %v53
  call void @"rt.err_relocate"(ptr %v54, i64 %v5)
  br label %b4
b4:
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v76, i64 0
  store i64 %v5, ptr %st35
  ret void
b5:
  %v55 = getelementptr i64, ptr %s1, i64 0
  %v56.p = getelementptr i64, ptr %v4, i64 0
  %v56 = load i64, ptr %v56.p
  %st36 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st36
  %v57.p = getelementptr i64, ptr %v4, i64 1
  %v57 = load i64, ptr %v57.p
  %st37 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st37
  %v58.p = getelementptr i64, ptr %v4, i64 2
  %v58 = load i64, ptr %v58.p
  %st38 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st38
  %v59 = getelementptr i64, ptr %s4, i64 0
  %v60 = add i64 0, 0
  %st39 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st39
  %v61.p = getelementptr i64, ptr %v55, i64 0
  %v61 = load i64, ptr %v61.p
  %st40 = getelementptr i64, ptr %v0, i64 0
  store i64 %v61, ptr %st40
  %v62.p = getelementptr i64, ptr %v55, i64 1
  %v62 = load i64, ptr %v62.p
  %st41 = getelementptr i64, ptr %v0, i64 1
  store i64 %v62, ptr %st41
  %v63.p = getelementptr i64, ptr %v55, i64 2
  %v63 = load i64, ptr %v63.p
  %st42 = getelementptr i64, ptr %v0, i64 2
  store i64 %v63, ptr %st42
  %v64.p = getelementptr i64, ptr %v59, i64 0
  %v64 = load i64, ptr %v64.p
  %st43 = getelementptr i64, ptr %v0, i64 3
  store i64 %v64, ptr %st43
  %v65.p = getelementptr i64, ptr %v59, i64 1
  %v65 = load i64, ptr %v65.p
  %st44 = getelementptr i64, ptr %v0, i64 4
  store i64 %v65, ptr %st44
  %v66.p = getelementptr i64, ptr %v59, i64 2
  %v66 = load i64, ptr %v66.p
  %st45 = getelementptr i64, ptr %v0, i64 5
  store i64 %v66, ptr %st45
  %v67.p = getelementptr i64, ptr %v59, i64 3
  %v67 = load i64, ptr %v67.p
  %st46 = getelementptr i64, ptr %v0, i64 6
  store i64 %v67, ptr %st46
  %v68.p = getelementptr i64, ptr %v59, i64 4
  %v68 = load i64, ptr %v68.p
  %st47 = getelementptr i64, ptr %v0, i64 7
  store i64 %v68, ptr %st47
  %v69.p = getelementptr i64, ptr %v59, i64 5
  %v69 = load i64, ptr %v69.p
  %st48 = getelementptr i64, ptr %v0, i64 8
  store i64 %v69, ptr %st48
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v70.p = getelementptr i64, ptr %v0, i64 3
  %v70 = load i64, ptr %v70.p
  %v71 = add i64 0, 0
  %v72.c = icmp ne i64 %v70, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b5 = icmp ne i64 %v72, 0
  br i1 %c.b5, label %b5.t50, label %b5.e51
b5.t50:
  br label %b6
b5.e51:
  br label %b7
b6:
  %v73 = add i64 0, 4
  %v74 = getelementptr i64, ptr %v0, i64 %v73
  call void @"rt.err_relocate"(ptr %v74, i64 %v5)
  br label %b7
b7:
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v77, i64 0
  store i64 %v5, ptr %st51
  ret void
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
  %v13 = add i64 0, 25
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
  %v22 = add i64 0, 26
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
  %v8 = add i64 0, 27
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
  %v35 = add i64 0, 28
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
  %v52 = add i64 0, 29
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
  %v74 = add i64 0, 30
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
  %v106 = add i64 0, 31
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
  %v121 = add i64 0, 32
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

define internal void @"rt.err_relocate"(ptr %v0, i64 %v1) #0 {
b0:
  %v2 = add i64 0, 2
  %v3 = getelementptr i64, ptr %v0, i64 %v2
  %v4 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v3, i64 %v4, i64 %v1)
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
  %v20 = getelementptr i64, ptr @"str.31", i64 0
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
  %v74 = getelementptr i64, ptr @"str.39", i64 0
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
  %v27 = getelementptr i64, ptr @"str.32", i64 0
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
  %v34 = getelementptr i64, ptr @"str.33", i64 0
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
  %v41 = getelementptr i64, ptr @"str.34", i64 0
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
  %v48 = getelementptr i64, ptr @"str.35", i64 0
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
  %v55 = getelementptr i64, ptr @"str.36", i64 0
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
  %v62 = getelementptr i64, ptr @"str.37", i64 0
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
  %v69 = getelementptr i64, ptr @"str.38", i64 0
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
  %v107 = add i64 0, 58
  call void @"rt.print_char"(i64 %v107)
  call void @"rt.print_int"(i64 %v14)
  %v108 = add i64 0, 58
  call void @"rt.print_char"(i64 %v108)
  call void @"rt.print_int"(i64 %v18)
  %v109 = add i64 0, 10
  call void @"rt.print_char"(i64 %v109)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v81 = getelementptr i64, ptr @"str.40", i64 0
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
  %v88 = getelementptr i64, ptr @"str.41", i64 0
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
  %v95 = getelementptr i64, ptr @"str.42", i64 0
  %v96 = add i64 0, 22
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
  %v102 = getelementptr i64, ptr @"str.43", i64 0
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
