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
@"str.2" = internal constant [1 x i64] [i64 27503]
@"str.3" = internal constant [1 x i64] [i64 6578530]
@"str.4" = internal constant [1 x i64] [i64 1701998445]
@"str.5" = internal constant [1 x i64] [i64 35435298515300]
@"str.6" = internal constant [1 x i64] [i64 35435466417522]
@"str.7" = internal constant [1 x i64] [i64 35662966452837]
@"str.8" = internal constant [1 x i64] [i64 110369476603509]
@"str.9" = internal constant [1 x i64] [i64 110386723317092]
@"str.10" = internal constant [1 x i64] [i64 110386891156579]
@"str.11" = internal constant [1 x i64] [i64 28259039740721253]
@"str.12" = internal constant [1 x i64] [i64 32780218601924980]
@"str.13" = internal constant [1 x i64] [i64 2322278983174135852]
@"str.14" = internal constant [2 x i64] [i64 3328210909095473713, i64 14897]
@"str.15" = internal constant [2 x i64] [i64 3328210909095473713, i64 3160625]
@"str.16" = internal constant [3 x i64] [i64 3618417120593983789, i64 3978706198986109744, i64 942684213]
@"str.17" = internal constant [2 x i64] [i64 7359003173147863404, i64 431198333281]
@"str.18" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.19" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.20" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.21" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.22" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.23" = internal constant [1 x i64] [i64 2685]
@"str.24" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.25" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.26" = internal constant [1 x i64] [i64 35899498962976]
@"str.27" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.28" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [16 x i64] [i64 3377699888300039, i64 12666378599268609, i64 16044078319796481, i64 12666378599268609, i64 16044078319796481, i64 4222126697480449, i64 9288676462821635, i64 4785077036777731, i64 1970327269671169, i64 4785077053554947, i64 1970327286448385, i64 13792277465923841, i64 19140302023426305, i64 7599827575636483, i64 8725727532810755, i64 8444252656763393]
@"str.29" = internal constant [1 x i64] [i64 9071397899755888]
@"str.30" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.31" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.32" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.33" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.34" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.35" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.36" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.37" = internal constant [1 x i64] [i64 544497952]
@"str.38" = internal constant [2 x i64] [i64 8317986210835621230, i64 8243102923784873061]
@"str.39" = internal constant [3 x i64] [i64 3419469540996969587, i64 7305524086039668078, i64 114]
@"str.40" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]

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
  %v3 = getelementptr i64, ptr @"str.18", i64 0
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
  %v29 = getelementptr i64, ptr @"str.22", i64 0
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
  %v35 = getelementptr i64, ptr @"str.23", i64 0
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
  %v10 = getelementptr i64, ptr @"str.19", i64 0
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
  %v17 = getelementptr i64, ptr @"str.20", i64 0
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
  %v24 = getelementptr i64, ptr @"str.21", i64 0
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
  %v60 = getelementptr i64, ptr @"str.24", i64 0
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
  %v65 = getelementptr i64, ptr @"str.25", i64 0
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
  %v70 = getelementptr i64, ptr @"str.23", i64 0
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
  %v81 = getelementptr i64, ptr @"str.26", i64 0
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
  %v88 = getelementptr i64, ptr @"str.27", i64 0
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
  %v17 = getelementptr i64, ptr @"str.28", i64 0
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
  %v22 = getelementptr i64, ptr @"str.23", i64 0
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

define internal void @"main.show"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v109, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v9, i64 2571
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v9, i64 2571
  store i64 %v11, ptr %st6
  %v12 = add i64 0, 1
  %v13.c = icmp sge i64 %v10, %v12
  %v13 = zext i1 %v13.c to i64
  %v14.c = icmp sle i64 %v10, %v8
  %v14 = zext i1 %v14.c to i64
  %v15 = and i64 %v13, %v14
  %v16 = sub i64 %v10, %v8
  %v17 = mul i64 %v15, %v16
  %v18 = add i64 %v8, %v17
  call void @"rt.region_enter"()
  %v19.p = getelementptr i64, ptr %v7, i64 0
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
  %v22 = add i64 0, 1
  %v23 = getelementptr i64, ptr %v7, i64 %v22
  %v24 = getelementptr i64, ptr %s1, i64 0
  %v25.p = getelementptr i64, ptr %v23, i64 0
  %v25 = load i64, ptr %v25.p
  %st9 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st9
  %v26.p = getelementptr i64, ptr %v23, i64 1
  %v26 = load i64, ptr %v26.p
  %st10 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st10
  %v27.p = getelementptr i64, ptr %v23, i64 2
  %v27 = load i64, ptr %v27.p
  %st11 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st11
  %v28.p = getelementptr i64, ptr %v23, i64 3
  %v28 = load i64, ptr %v28.p
  %st12 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st12
  %v29.p = getelementptr i64, ptr %v23, i64 4
  %v29 = load i64, ptr %v29.p
  %st13 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st13
  %v30.p = getelementptr i64, ptr %v24, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 2
  %v32.c = icmp eq i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b1 = icmp ne i64 %v32, 0
  br i1 %c.b1, label %b1.t15, label %b1.e16
b1.t15:
  br label %b4
b1.e16:
  br label %b3
b2:
  %v100 = getelementptr i64, ptr @"str.2", i64 0
  %v101 = add i64 0, 2
  %v102 = add i64 0, 0
  %v103 = getelementptr i64, ptr %s10, i64 0
  %v104 = ptrtoint ptr %v100 to i64
  %st16 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st16
  %st17 = getelementptr i64, ptr %v103, i64 1
  store i64 %v101, ptr %st17
  %st18 = getelementptr i64, ptr %v103, i64 2
  store i64 %v102, ptr %st18
  br label %b16
b3:
  %v38.p = getelementptr i64, ptr %v24, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 3
  %v40.c = icmp eq i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b3 = icmp ne i64 %v40, 0
  br i1 %c.b3, label %b3.t20, label %b3.e21
b3.t20:
  br label %b6
b3.e21:
  br label %b5
b4:
  %v33 = getelementptr i64, ptr @"str.12", i64 0
  %v34 = add i64 0, 7
  %v35 = add i64 0, 0
  %v36 = getelementptr i64, ptr %s2, i64 0
  %v37 = ptrtoint ptr %v33 to i64
  %st21 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st21
  %st22 = getelementptr i64, ptr %v36, i64 1
  store i64 %v34, ptr %st22
  %st23 = getelementptr i64, ptr %v36, i64 2
  store i64 %v35, ptr %st23
  br label %b15
b5:
  %v46.p = getelementptr i64, ptr %v24, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 0, 4
  %v48.c = icmp eq i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b5 = icmp ne i64 %v48, 0
  br i1 %c.b5, label %b5.t25, label %b5.e26
b5.t25:
  br label %b8
b5.e26:
  br label %b7
b6:
  %v41 = getelementptr i64, ptr @"str.11", i64 0
  %v42 = add i64 0, 7
  %v43 = add i64 0, 0
  %v44 = getelementptr i64, ptr %s3, i64 0
  %v45 = ptrtoint ptr %v41 to i64
  %st26 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st26
  %st27 = getelementptr i64, ptr %v44, i64 1
  store i64 %v42, ptr %st27
  %st28 = getelementptr i64, ptr %v44, i64 2
  store i64 %v43, ptr %st28
  br label %b15
b7:
  %v54.p = getelementptr i64, ptr %v24, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = add i64 0, 1
  %v56.c = icmp eq i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b7 = icmp ne i64 %v56, 0
  br i1 %c.b7, label %b7.t30, label %b7.e31
b7.t30:
  br label %b10
b7.e31:
  br label %b9
b8:
  %v49 = getelementptr i64, ptr @"str.10", i64 0
  %v50 = add i64 0, 6
  %v51 = add i64 0, 0
  %v52 = getelementptr i64, ptr %s4, i64 0
  %v53 = ptrtoint ptr %v49 to i64
  %st31 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st31
  %st32 = getelementptr i64, ptr %v52, i64 1
  store i64 %v50, ptr %st32
  %st33 = getelementptr i64, ptr %v52, i64 2
  store i64 %v51, ptr %st33
  br label %b15
b9:
  %v62.p = getelementptr i64, ptr %v24, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 0, 5
  %v64.c = icmp eq i64 %v62, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b9 = icmp ne i64 %v64, 0
  br i1 %c.b9, label %b9.t35, label %b9.e36
b9.t35:
  br label %b12
b9.e36:
  br label %b11
b10:
  %v57 = getelementptr i64, ptr @"str.9", i64 0
  %v58 = add i64 0, 6
  %v59 = add i64 0, 0
  %v60 = getelementptr i64, ptr %s5, i64 0
  %v61 = ptrtoint ptr %v57 to i64
  %st36 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st36
  %st37 = getelementptr i64, ptr %v60, i64 1
  store i64 %v58, ptr %st37
  %st38 = getelementptr i64, ptr %v60, i64 2
  store i64 %v59, ptr %st38
  br label %b15
b11:
  %v90.p = getelementptr i64, ptr %v24, i64 0
  %v90 = load i64, ptr %v90.p
  %v91 = add i64 0, 6
  %v92.c = icmp eq i64 %v90, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b11 = icmp ne i64 %v92, 0
  br i1 %c.b11, label %b11.t40, label %b11.e41
b11.t40:
  br label %b14
b11.e41:
  br label %b13
b12:
  %v65.p = getelementptr i64, ptr %v24, i64 1
  %v65 = load i64, ptr %v65.p
  %v66 = getelementptr i64, ptr @"str.7", i64 0
  %v67 = add i64 0, 6
  %v68 = add i64 0, 0
  %v69 = getelementptr i64, ptr %s6, i64 0
  %v70 = ptrtoint ptr %v66 to i64
  %st41 = getelementptr i64, ptr %v69, i64 0
  store i64 %v70, ptr %st41
  %st42 = getelementptr i64, ptr %v69, i64 1
  store i64 %v67, ptr %st42
  %st43 = getelementptr i64, ptr %v69, i64 2
  store i64 %v68, ptr %st43
  %v71 = getelementptr i64, ptr %s7, i64 0
  call void @"std/convert.FormatInt"(ptr %v71, i64 %v65)
  %v72 = add i64 0, 0
  %v73.p = getelementptr i64, ptr %v69, i64 1
  %v73 = load i64, ptr %v73.p
  %v74 = add i64 %v72, %v73
  %v75.p = getelementptr i64, ptr %v71, i64 1
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 %v74, %v75
  %v77.p = getelementptr i64, ptr %v69, i64 1
  %v77 = load i64, ptr %v77.p
  %v78 = sub i64 %v76, %v77
  %v79.p = getelementptr i64, ptr %v69, i64 0
  %v79 = load i64, ptr %v79.p
  %v80.p = getelementptr i64, ptr %v69, i64 1
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v69, i64 2
  %v81 = load i64, ptr %v81.p
  %v82 = call ptr @"rt.cat8"(i64 %v79, i64 %v80, i64 %v81, i64 %v18, i64 %v78)
  %v83.p = getelementptr i64, ptr %v71, i64 1
  %v83 = load i64, ptr %v83.p
  %v84 = getelementptr i8, ptr %v82, i64 %v77
  %v85.p = getelementptr i64, ptr %v71, i64 0
  %v85 = load i64, ptr %v85.p
  %v86 = inttoptr i64 %v85 to ptr
  call void @"rt.copy8"(ptr %v84, ptr %v86, i64 %v83)
  %v87 = add i64 %v77, %v83
  %v88 = getelementptr i64, ptr %s8, i64 0
  %v89 = ptrtoint ptr %v82 to i64
  %st44 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st44
  %st45 = getelementptr i64, ptr %v88, i64 1
  store i64 %v76, ptr %st45
  %st46 = getelementptr i64, ptr %v88, i64 2
  store i64 %v18, ptr %st46
  br label %b15
b13:
  %v98 = add i64 0, 0
  call void @"rt.panic"(i64 %v98)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v93 = getelementptr i64, ptr @"str.3", i64 0
  %v94 = add i64 0, 3
  %v95 = add i64 0, 0
  %v96 = getelementptr i64, ptr %s9, i64 0
  %v97 = ptrtoint ptr %v93 to i64
  %st47 = getelementptr i64, ptr %v96, i64 0
  store i64 %v97, ptr %st47
  %st48 = getelementptr i64, ptr %v96, i64 1
  store i64 %v94, ptr %st48
  %st49 = getelementptr i64, ptr %v96, i64 2
  store i64 %v95, ptr %st49
  br label %b15
b15:
  %v99 = phi ptr [ %v36, %b4 ], [ %v44, %b6 ], [ %v52, %b8 ], [ %v60, %b10 ], [ %v88, %b12 ], [ %v96, %b14 ]
  br label %b16
b16:
  %v105 = phi ptr [ %v103, %b2 ], [ %v99, %b15 ]
  %v106.p = getelementptr i64, ptr %v105, i64 0
  %v106 = load i64, ptr %v106.p
  %st50 = getelementptr i64, ptr %v0, i64 0
  store i64 %v106, ptr %st50
  %v107.p = getelementptr i64, ptr %v105, i64 1
  %v107 = load i64, ptr %v107.p
  %st51 = getelementptr i64, ptr %v0, i64 1
  store i64 %v107, ptr %st51
  %v108.p = getelementptr i64, ptr %v105, i64 2
  %v108 = load i64, ptr %v108.p
  %st52 = getelementptr i64, ptr %v0, i64 2
  store i64 %v108, ptr %st52
  call void @"rt.region_relocate8"(ptr %v0, i64 %v8)
  %v110 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v110, i64 0
  store i64 %v8, ptr %st53
  ret void
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
  %s5 = alloca [9 x i64], align 8
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
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v76, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  %v2 = getelementptr i64, ptr %s1, i64 0
  call void @"main.dialGone"(ptr %v2)
  %v3.p = getelementptr i64, ptr %v2, i64 0
  %v3 = load i64, ptr %v3.p
  %v4.p = getelementptr i64, ptr %v2, i64 1
  %v4 = load i64, ptr %v4.p
  %v5.p = getelementptr i64, ptr %v2, i64 2
  %v5 = load i64, ptr %v5.p
  %v6.p = getelementptr i64, ptr %v2, i64 3
  %v6 = load i64, ptr %v6.p
  %v7.p = getelementptr i64, ptr %v2, i64 4
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v2, i64 5
  %v8 = load i64, ptr %v8.p
  call void @"main.show"(ptr %v1, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8)
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v1, i64 0
  %v10 = load i64, ptr %v10.p
  %st0 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st0
  %v11.p = getelementptr i64, ptr %v1, i64 1
  %v11 = load i64, ptr %v11.p
  %st1 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st1
  %v12.p = getelementptr i64, ptr %v1, i64 2
  %v12 = load i64, ptr %v12.p
  %st2 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st2
  %v13 = getelementptr i64, ptr @"str.5", i64 0
  %v14 = add i64 0, 6
  %v15 = add i64 0, 0
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17 = ptrtoint ptr %v13 to i64
  %st3 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st3
  %st4 = getelementptr i64, ptr %v16, i64 1
  store i64 %v14, ptr %st4
  %st5 = getelementptr i64, ptr %v16, i64 2
  store i64 %v15, ptr %st5
  %v18 = add i64 0, 0
  %v19.p = getelementptr i64, ptr %v16, i64 1
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 %v18, %v19
  %v21.p = getelementptr i64, ptr %v9, i64 1
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 %v20, %v21
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v23.p = getelementptr i64, ptr %v77, i64 0
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v16, i64 1
  %v24 = load i64, ptr %v24.p
  %v25 = sub i64 %v22, %v24
  %v26.p = getelementptr i64, ptr %v16, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v16, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v16, i64 2
  %v28 = load i64, ptr %v28.p
  %v29 = call ptr @"rt.cat8"(i64 %v26, i64 %v27, i64 %v28, i64 %v23, i64 %v25)
  %v30.p = getelementptr i64, ptr %v9, i64 1
  %v30 = load i64, ptr %v30.p
  %v31 = getelementptr i8, ptr %v29, i64 %v24
  %v32.p = getelementptr i64, ptr %v9, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = inttoptr i64 %v32 to ptr
  call void @"rt.copy8"(ptr %v31, ptr %v33, i64 %v30)
  %v34 = add i64 %v24, %v30
  %v35 = getelementptr i64, ptr %s4, i64 0
  %v36 = ptrtoint ptr %v29 to i64
  %st6 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st6
  %st7 = getelementptr i64, ptr %v35, i64 1
  store i64 %v22, ptr %st7
  %st8 = getelementptr i64, ptr %v35, i64 2
  store i64 %v23, ptr %st8
  call void @"rt.print_str"(ptr %v35)
  %v37 = add i64 0, 10
  call void @"rt.print_char"(i64 %v37)
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v78, i64 0
  %v38 = load i64, ptr %v38.p
  call void @"rt.region_enter"()
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v79, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = getelementptr i64, ptr %s5, i64 0
  call void @"main.run"(ptr %v40)
  %v41 = add i64 0, 3
  %v42 = getelementptr i64, ptr %v40, i64 %v41
  %v43 = getelementptr i64, ptr %s4, i64 0
  %v44.p = getelementptr i64, ptr %v40, i64 0
  %v44 = load i64, ptr %v44.p
  %st9 = getelementptr i64, ptr %v43, i64 0
  store i64 %v44, ptr %st9
  %v45.p = getelementptr i64, ptr %v40, i64 1
  %v45 = load i64, ptr %v45.p
  %st10 = getelementptr i64, ptr %v43, i64 1
  store i64 %v45, ptr %st10
  %v46.p = getelementptr i64, ptr %v40, i64 2
  %v46 = load i64, ptr %v46.p
  %st11 = getelementptr i64, ptr %v43, i64 2
  store i64 %v46, ptr %st11
  %v47 = getelementptr i64, ptr %s6, i64 0
  %v48.p = getelementptr i64, ptr %v42, i64 0
  %v48 = load i64, ptr %v48.p
  %st12 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st12
  %v49.p = getelementptr i64, ptr %v42, i64 1
  %v49 = load i64, ptr %v49.p
  %st13 = getelementptr i64, ptr %v47, i64 1
  store i64 %v49, ptr %st13
  %v50.p = getelementptr i64, ptr %v42, i64 2
  %v50 = load i64, ptr %v50.p
  %st14 = getelementptr i64, ptr %v47, i64 2
  store i64 %v50, ptr %st14
  %v51.p = getelementptr i64, ptr %v42, i64 3
  %v51 = load i64, ptr %v51.p
  %st15 = getelementptr i64, ptr %v47, i64 3
  store i64 %v51, ptr %st15
  %v52.p = getelementptr i64, ptr %v42, i64 4
  %v52 = load i64, ptr %v52.p
  %st16 = getelementptr i64, ptr %v47, i64 4
  store i64 %v52, ptr %st16
  %v53.p = getelementptr i64, ptr %v42, i64 5
  %v53 = load i64, ptr %v53.p
  %st17 = getelementptr i64, ptr %v47, i64 5
  store i64 %v53, ptr %st17
  %v54.p = getelementptr i64, ptr %v47, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = add i64 0, 0
  %v56.c = icmp ne i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b0 = icmp ne i64 %v56, 0
  br i1 %c.b0, label %b0.t19, label %b0.e20
b0.t19:
  br label %b1
b0.e20:
  br label %b2
b1:
  %v57 = add i64 0, 1
  %v58 = getelementptr i64, ptr %v47, i64 %v57
  %v59 = getelementptr i64, ptr %s7, i64 0
  %v60.p = getelementptr i64, ptr %v58, i64 0
  %v60 = load i64, ptr %v60.p
  %st20 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st20
  %v61.p = getelementptr i64, ptr %v58, i64 1
  %v61 = load i64, ptr %v61.p
  %st21 = getelementptr i64, ptr %v59, i64 1
  store i64 %v61, ptr %st21
  %v62.p = getelementptr i64, ptr %v58, i64 2
  %v62 = load i64, ptr %v62.p
  %st22 = getelementptr i64, ptr %v59, i64 2
  store i64 %v62, ptr %st22
  %v63.p = getelementptr i64, ptr %v58, i64 3
  %v63 = load i64, ptr %v63.p
  %st23 = getelementptr i64, ptr %v59, i64 3
  store i64 %v63, ptr %st23
  %v64.p = getelementptr i64, ptr %v58, i64 4
  %v64 = load i64, ptr %v64.p
  %st24 = getelementptr i64, ptr %v59, i64 4
  store i64 %v64, ptr %st24
  %v65 = getelementptr i64, ptr @"str.17", i64 0
  %v66 = add i64 0, 13
  %v67 = add i64 0, 0
  %v68 = getelementptr i64, ptr %s3, i64 0
  %v69 = ptrtoint ptr %v65 to i64
  %st25 = getelementptr i64, ptr %v68, i64 0
  store i64 %v69, ptr %st25
  %st26 = getelementptr i64, ptr %v68, i64 1
  store i64 %v66, ptr %st26
  %st27 = getelementptr i64, ptr %v68, i64 2
  store i64 %v67, ptr %st27
  br label %b3
b2:
  br label %b3
b3:
  %v70 = phi ptr [ %v68, %b1 ], [ %v43, %b2 ]
  %v71 = getelementptr i64, ptr %s2, i64 0
  %v72.p = getelementptr i64, ptr %v70, i64 0
  %v72 = load i64, ptr %v72.p
  %st28 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st28
  %v73.p = getelementptr i64, ptr %v70, i64 1
  %v73 = load i64, ptr %v73.p
  %st29 = getelementptr i64, ptr %v71, i64 1
  store i64 %v73, ptr %st29
  %v74.p = getelementptr i64, ptr %v70, i64 2
  %v74 = load i64, ptr %v74.p
  %st30 = getelementptr i64, ptr %v71, i64 2
  store i64 %v74, ptr %st30
  call void @"rt.region_relocate8"(ptr %v71, i64 %v38)
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v80, i64 0
  store i64 %v38, ptr %st31
  call void @"rt.print_str"(ptr %v71)
  %v75 = add i64 0, 10
  call void @"rt.print_char"(i64 %v75)
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v81, i64 0
  store i64 %v0, ptr %st32
  ret void
}

define internal void @"main.dialGone"(ptr %v0) #0 {
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
  %s10 = alloca [1 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
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
  %s17 = alloca [3 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s17.z1 = getelementptr i64, ptr %s17, i64 1
  store i64 0, ptr %s17.z1
  %s17.z2 = getelementptr i64, ptr %s17, i64 2
  store i64 0, ptr %s17.z2
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
  %s19 = alloca [5 x i64], align 8
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
  %s23 = alloca [5 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %s23.z1 = getelementptr i64, ptr %s23, i64 1
  store i64 0, ptr %s23.z1
  %s23.z2 = getelementptr i64, ptr %s23, i64 2
  store i64 0, ptr %s23.z2
  %s23.z3 = getelementptr i64, ptr %s23, i64 3
  store i64 0, ptr %s23.z3
  %s23.z4 = getelementptr i64, ptr %s23, i64 4
  store i64 0, ptr %s23.z4
  %s24 = alloca [1 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s25 = alloca [1 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
  %v462 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v462, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = add i64 0, 0
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v2, ptr %st0
  %v463 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v463, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"str.15", i64 0
  %v6 = add i64 0, 11
  %v7 = add i64 0, 0
  %v8 = getelementptr i64, ptr %s1, i64 0
  %v9 = ptrtoint ptr %v5 to i64
  %st1 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st1
  %st2 = getelementptr i64, ptr %v8, i64 1
  store i64 %v6, ptr %st2
  %st3 = getelementptr i64, ptr %v8, i64 2
  store i64 %v7, ptr %st3
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v8, i64 0
  %v11 = load i64, ptr %v11.p
  %st4 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st4
  %v12.p = getelementptr i64, ptr %v8, i64 1
  %v12 = load i64, ptr %v12.p
  %st5 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st5
  %v13.p = getelementptr i64, ptr %v8, i64 2
  %v13 = load i64, ptr %v13.p
  %st6 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st6
  %v14 = getelementptr i64, ptr %s3, i64 0
  %v464 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v464, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 0
  %v17 = add i64 0, 0
  %v18.c = icmp ne i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t8, label %b0.e9
b0.t8:
  br label %b3
b0.e9:
  br label %b4
b1:
  %v465 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v465, i64 0
  store i64 %v4, ptr %st9
  %v466 = getelementptr i64, ptr @"rt.meta", i64 0
  %v146.p = getelementptr i64, ptr %v466, i64 0
  %v146 = load i64, ptr %v146.p
  %v147.p = getelementptr i64, ptr %v3, i64 0
  %v147 = load i64, ptr %v147.p
  %v148 = getelementptr i64, ptr @"str.14", i64 0
  %v149 = add i64 0, 10
  %v150 = add i64 0, 0
  %v151 = getelementptr i64, ptr %s8, i64 0
  %v152 = ptrtoint ptr %v148 to i64
  %st10 = getelementptr i64, ptr %v151, i64 0
  store i64 %v152, ptr %st10
  %st11 = getelementptr i64, ptr %v151, i64 1
  store i64 %v149, ptr %st11
  %st12 = getelementptr i64, ptr %v151, i64 2
  store i64 %v150, ptr %st12
  %v153 = getelementptr i64, ptr %s14, i64 0
  call void @"std/convert.FormatInt"(ptr %v153, i64 %v147)
  %v154 = add i64 0, 0
  %v155.p = getelementptr i64, ptr %v151, i64 1
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 %v154, %v155
  %v157.p = getelementptr i64, ptr %v153, i64 1
  %v157 = load i64, ptr %v157.p
  %v158 = add i64 %v156, %v157
  %v467 = getelementptr i64, ptr @"rt.meta", i64 0
  %v159.p = getelementptr i64, ptr %v467, i64 0
  %v159 = load i64, ptr %v159.p
  %v160.p = getelementptr i64, ptr %v151, i64 1
  %v160 = load i64, ptr %v160.p
  %v161 = sub i64 %v158, %v160
  %v162.p = getelementptr i64, ptr %v151, i64 0
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v151, i64 1
  %v163 = load i64, ptr %v163.p
  %v164.p = getelementptr i64, ptr %v151, i64 2
  %v164 = load i64, ptr %v164.p
  %v165 = call ptr @"rt.cat8"(i64 %v162, i64 %v163, i64 %v164, i64 %v159, i64 %v161)
  %v166.p = getelementptr i64, ptr %v153, i64 1
  %v166 = load i64, ptr %v166.p
  %v167 = getelementptr i8, ptr %v165, i64 %v160
  %v168.p = getelementptr i64, ptr %v153, i64 0
  %v168 = load i64, ptr %v168.p
  %v169 = inttoptr i64 %v168 to ptr
  call void @"rt.copy8"(ptr %v167, ptr %v169, i64 %v166)
  %v170 = add i64 %v160, %v166
  %v171 = getelementptr i64, ptr %s2, i64 0
  %v172 = ptrtoint ptr %v165 to i64
  %st13 = getelementptr i64, ptr %v171, i64 0
  store i64 %v172, ptr %st13
  %st14 = getelementptr i64, ptr %v171, i64 1
  store i64 %v158, ptr %st14
  %st15 = getelementptr i64, ptr %v171, i64 2
  store i64 %v159, ptr %st15
  %v173 = getelementptr i64, ptr %s1, i64 0
  %v174.p = getelementptr i64, ptr %v171, i64 0
  %v174 = load i64, ptr %v174.p
  %st16 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st16
  %v175.p = getelementptr i64, ptr %v171, i64 1
  %v175 = load i64, ptr %v175.p
  %st17 = getelementptr i64, ptr %v173, i64 1
  store i64 %v175, ptr %st17
  %v176.p = getelementptr i64, ptr %v171, i64 2
  %v176 = load i64, ptr %v176.p
  %st18 = getelementptr i64, ptr %v173, i64 2
  store i64 %v176, ptr %st18
  %v177 = getelementptr i64, ptr %s6, i64 0
  %v468 = getelementptr i64, ptr @"rt.meta", i64 0
  %v178.p = getelementptr i64, ptr %v468, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 0
  %v180 = add i64 0, 0
  %v181.c = icmp ne i64 %v179, %v180
  %v181 = zext i1 %v181.c to i64
  %c.b1 = icmp ne i64 %v181, 0
  br i1 %c.b1, label %b1.t20, label %b1.e21
b1.t20:
  br label %b27
b1.e21:
  br label %b28
b2:
  %v131.p = getelementptr i64, ptr %v14, i64 0
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 0, 0
  %v133.c = icmp ne i64 %v131, %v132
  %v133 = zext i1 %v133.c to i64
  %c.b2 = icmp ne i64 %v133, 0
  br i1 %c.b2, label %b2.t22, label %b2.e23
b2.t22:
  br label %b21
b2.e23:
  br label %b22
b3:
  %v19 = getelementptr i64, ptr %s4, i64 0
  %v20 = add i64 0, 0
  %st23 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st23
  %st24 = getelementptr i64, ptr %v19, i64 1
  store i64 %v20, ptr %st24
  %v21 = add i64 0, 3
  %st25 = getelementptr i64, ptr %v19, i64 0
  store i64 %v21, ptr %st25
  %v22 = getelementptr i64, ptr %s5, i64 0
  %v23.p = getelementptr i64, ptr %v19, i64 0
  %v23 = load i64, ptr %v23.p
  %st26 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st26
  %v24.p = getelementptr i64, ptr %v19, i64 1
  %v24 = load i64, ptr %v24.p
  %st27 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st27
  %v25 = add i64 0, 0
  %st28 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st28
  %st29 = getelementptr i64, ptr %v22, i64 3
  store i64 %v25, ptr %st29
  %st30 = getelementptr i64, ptr %v22, i64 4
  store i64 %v25, ptr %st30
  %v26 = getelementptr i64, ptr %s6, i64 0
  %v27 = add i64 0, 1
  %st31 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st31
  %v28.p = getelementptr i64, ptr %v22, i64 0
  %v28 = load i64, ptr %v28.p
  %st32 = getelementptr i64, ptr %v26, i64 1
  store i64 %v28, ptr %st32
  %v29.p = getelementptr i64, ptr %v22, i64 1
  %v29 = load i64, ptr %v29.p
  %st33 = getelementptr i64, ptr %v26, i64 2
  store i64 %v29, ptr %st33
  %v30.p = getelementptr i64, ptr %v22, i64 2
  %v30 = load i64, ptr %v30.p
  %st34 = getelementptr i64, ptr %v26, i64 3
  store i64 %v30, ptr %st34
  %v31.p = getelementptr i64, ptr %v22, i64 3
  %v31 = load i64, ptr %v31.p
  %st35 = getelementptr i64, ptr %v26, i64 4
  store i64 %v31, ptr %st35
  %v32.p = getelementptr i64, ptr %v22, i64 4
  %v32 = load i64, ptr %v32.p
  %st36 = getelementptr i64, ptr %v26, i64 5
  store i64 %v32, ptr %st36
  %v33.p = getelementptr i64, ptr %v26, i64 0
  %v33 = load i64, ptr %v33.p
  %st37 = getelementptr i64, ptr %v14, i64 0
  store i64 %v33, ptr %st37
  %v34.p = getelementptr i64, ptr %v26, i64 1
  %v34 = load i64, ptr %v34.p
  %st38 = getelementptr i64, ptr %v14, i64 1
  store i64 %v34, ptr %st38
  %v35.p = getelementptr i64, ptr %v26, i64 2
  %v35 = load i64, ptr %v35.p
  %st39 = getelementptr i64, ptr %v14, i64 2
  store i64 %v35, ptr %st39
  %v36.p = getelementptr i64, ptr %v26, i64 3
  %v36 = load i64, ptr %v36.p
  %st40 = getelementptr i64, ptr %v14, i64 3
  store i64 %v36, ptr %st40
  %v37.p = getelementptr i64, ptr %v26, i64 4
  %v37 = load i64, ptr %v37.p
  %st41 = getelementptr i64, ptr %v14, i64 4
  store i64 %v37, ptr %st41
  %v38.p = getelementptr i64, ptr %v26, i64 5
  %v38 = load i64, ptr %v38.p
  %st42 = getelementptr i64, ptr %v14, i64 5
  store i64 %v38, ptr %st42
  %v39.p = getelementptr i64, ptr %v14, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 0
  %v41.c = icmp ne i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b3 = icmp ne i64 %v41, 0
  br i1 %c.b3, label %b3.t44, label %b3.e45
b3.t44:
  br label %b5
b3.e45:
  br label %b6
b4:
  br label %b7
b5:
  %v42 = add i64 0, 1
  %v43 = getelementptr i64, ptr %v14, i64 %v42
  call void @"rt.err_relocate"(ptr %v43, i64 %v15)
  br label %b6
b6:
  %v469 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v469, i64 0
  store i64 %v15, ptr %st45
  br label %b2
b7:
  %v44 = getelementptr i64, ptr %s7, i64 0
  %v45.p = getelementptr i64, ptr %v10, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v10, i64 1
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v10, i64 2
  %v47 = load i64, ptr %v47.p
  call void @"std/net.sockaddr"(ptr %v44, i64 %v45, i64 %v46, i64 %v47)
  %v48 = getelementptr i64, ptr %s8, i64 0
  %v49.p = getelementptr i64, ptr %v44, i64 0
  %v49 = load i64, ptr %v49.p
  %st46 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st46
  %v50.p = getelementptr i64, ptr %v44, i64 1
  %v50 = load i64, ptr %v50.p
  %st47 = getelementptr i64, ptr %v48, i64 1
  store i64 %v50, ptr %st47
  %v51.p = getelementptr i64, ptr %v44, i64 2
  %v51 = load i64, ptr %v51.p
  %st48 = getelementptr i64, ptr %v48, i64 2
  store i64 %v51, ptr %st48
  %v52.p = getelementptr i64, ptr %v48, i64 1
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 16
  %v54.c = icmp ne i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b7 = icmp ne i64 %v54, 0
  br i1 %c.b7, label %b7.t50, label %b7.e51
b7.t50:
  br label %b8
b7.e51:
  br label %b9
b8:
  %v55 = getelementptr i64, ptr %s4, i64 0
  %v56 = add i64 0, 0
  %st51 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st51
  %st52 = getelementptr i64, ptr %v55, i64 1
  store i64 %v56, ptr %st52
  %v57 = add i64 0, 6
  %st53 = getelementptr i64, ptr %v55, i64 0
  store i64 %v57, ptr %st53
  %v58 = getelementptr i64, ptr %s5, i64 0
  %v59.p = getelementptr i64, ptr %v55, i64 0
  %v59 = load i64, ptr %v59.p
  %st54 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st54
  %v60.p = getelementptr i64, ptr %v55, i64 1
  %v60 = load i64, ptr %v60.p
  %st55 = getelementptr i64, ptr %v58, i64 1
  store i64 %v60, ptr %st55
  %v61 = add i64 0, 0
  %st56 = getelementptr i64, ptr %v58, i64 2
  store i64 %v61, ptr %st56
  %st57 = getelementptr i64, ptr %v58, i64 3
  store i64 %v61, ptr %st57
  %st58 = getelementptr i64, ptr %v58, i64 4
  store i64 %v61, ptr %st58
  %v62 = getelementptr i64, ptr %s6, i64 0
  %v63 = add i64 0, 1
  %st59 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st59
  %v64.p = getelementptr i64, ptr %v58, i64 0
  %v64 = load i64, ptr %v64.p
  %st60 = getelementptr i64, ptr %v62, i64 1
  store i64 %v64, ptr %st60
  %v65.p = getelementptr i64, ptr %v58, i64 1
  %v65 = load i64, ptr %v65.p
  %st61 = getelementptr i64, ptr %v62, i64 2
  store i64 %v65, ptr %st61
  %v66.p = getelementptr i64, ptr %v58, i64 2
  %v66 = load i64, ptr %v66.p
  %st62 = getelementptr i64, ptr %v62, i64 3
  store i64 %v66, ptr %st62
  %v67.p = getelementptr i64, ptr %v58, i64 3
  %v67 = load i64, ptr %v67.p
  %st63 = getelementptr i64, ptr %v62, i64 4
  store i64 %v67, ptr %st63
  %v68.p = getelementptr i64, ptr %v58, i64 4
  %v68 = load i64, ptr %v68.p
  %st64 = getelementptr i64, ptr %v62, i64 5
  store i64 %v68, ptr %st64
  %v69.p = getelementptr i64, ptr %v62, i64 0
  %v69 = load i64, ptr %v69.p
  %st65 = getelementptr i64, ptr %v14, i64 0
  store i64 %v69, ptr %st65
  %v70.p = getelementptr i64, ptr %v62, i64 1
  %v70 = load i64, ptr %v70.p
  %st66 = getelementptr i64, ptr %v14, i64 1
  store i64 %v70, ptr %st66
  %v71.p = getelementptr i64, ptr %v62, i64 2
  %v71 = load i64, ptr %v71.p
  %st67 = getelementptr i64, ptr %v14, i64 2
  store i64 %v71, ptr %st67
  %v72.p = getelementptr i64, ptr %v62, i64 3
  %v72 = load i64, ptr %v72.p
  %st68 = getelementptr i64, ptr %v14, i64 3
  store i64 %v72, ptr %st68
  %v73.p = getelementptr i64, ptr %v62, i64 4
  %v73 = load i64, ptr %v73.p
  %st69 = getelementptr i64, ptr %v14, i64 4
  store i64 %v73, ptr %st69
  %v74.p = getelementptr i64, ptr %v62, i64 5
  %v74 = load i64, ptr %v74.p
  %st70 = getelementptr i64, ptr %v14, i64 5
  store i64 %v74, ptr %st70
  %v75.p = getelementptr i64, ptr %v14, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 0
  %v77.c = icmp ne i64 %v75, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b8 = icmp ne i64 %v77, 0
  br i1 %c.b8, label %b8.t72, label %b8.e73
b8.t72:
  br label %b10
b8.e73:
  br label %b11
b9:
  br label %b12
b10:
  %v78 = add i64 0, 1
  %v79 = getelementptr i64, ptr %v14, i64 %v78
  call void @"rt.err_relocate"(ptr %v79, i64 %v15)
  br label %b11
b11:
  %v470 = getelementptr i64, ptr @"rt.meta", i64 0
  %st73 = getelementptr i64, ptr %v470, i64 0
  store i64 %v15, ptr %st73
  br label %b2
b12:
  %v80.p = getelementptr i64, ptr %v48, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v48, i64 1
  %v81 = load i64, ptr %v81.p
  %v82.p = getelementptr i64, ptr %v48, i64 2
  %v82 = load i64, ptr %v82.p
  %v83 = call i64 @"std/net.listenFd"(i64 %v80, i64 %v81, i64 %v82)
  %v84 = add i64 0, 0
  %v85.c = icmp slt i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b12 = icmp ne i64 %v85, 0
  br i1 %c.b12, label %b12.t75, label %b12.e76
b12.t75:
  br label %b13
b12.e76:
  br label %b14
b13:
  %v86 = getelementptr i64, ptr %s9, i64 0
  %v87 = add i64 0, 0
  %v88 = sub i64 %v87, %v83
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v89, i64 2571
  store i64 %v15, ptr %st76
  call void @"std/net.errOf"(ptr %v86, i64 %v88)
  %v90 = getelementptr i64, ptr %s6, i64 0
  %v91 = add i64 0, 1
  %st77 = getelementptr i64, ptr %v90, i64 0
  store i64 %v91, ptr %st77
  %v92.p = getelementptr i64, ptr %v86, i64 0
  %v92 = load i64, ptr %v92.p
  %st78 = getelementptr i64, ptr %v90, i64 1
  store i64 %v92, ptr %st78
  %v93.p = getelementptr i64, ptr %v86, i64 1
  %v93 = load i64, ptr %v93.p
  %st79 = getelementptr i64, ptr %v90, i64 2
  store i64 %v93, ptr %st79
  %v94.p = getelementptr i64, ptr %v86, i64 2
  %v94 = load i64, ptr %v94.p
  %st80 = getelementptr i64, ptr %v90, i64 3
  store i64 %v94, ptr %st80
  %v95.p = getelementptr i64, ptr %v86, i64 3
  %v95 = load i64, ptr %v95.p
  %st81 = getelementptr i64, ptr %v90, i64 4
  store i64 %v95, ptr %st81
  %v96.p = getelementptr i64, ptr %v86, i64 4
  %v96 = load i64, ptr %v96.p
  %st82 = getelementptr i64, ptr %v90, i64 5
  store i64 %v96, ptr %st82
  %v97.p = getelementptr i64, ptr %v90, i64 0
  %v97 = load i64, ptr %v97.p
  %st83 = getelementptr i64, ptr %v14, i64 0
  store i64 %v97, ptr %st83
  %v98.p = getelementptr i64, ptr %v90, i64 1
  %v98 = load i64, ptr %v98.p
  %st84 = getelementptr i64, ptr %v14, i64 1
  store i64 %v98, ptr %st84
  %v99.p = getelementptr i64, ptr %v90, i64 2
  %v99 = load i64, ptr %v99.p
  %st85 = getelementptr i64, ptr %v14, i64 2
  store i64 %v99, ptr %st85
  %v100.p = getelementptr i64, ptr %v90, i64 3
  %v100 = load i64, ptr %v100.p
  %st86 = getelementptr i64, ptr %v14, i64 3
  store i64 %v100, ptr %st86
  %v101.p = getelementptr i64, ptr %v90, i64 4
  %v101 = load i64, ptr %v101.p
  %st87 = getelementptr i64, ptr %v14, i64 4
  store i64 %v101, ptr %st87
  %v102.p = getelementptr i64, ptr %v90, i64 5
  %v102 = load i64, ptr %v102.p
  %st88 = getelementptr i64, ptr %v14, i64 5
  store i64 %v102, ptr %st88
  %v103.p = getelementptr i64, ptr %v14, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105.c = icmp ne i64 %v103, %v104
  %v105 = zext i1 %v105.c to i64
  %c.b13 = icmp ne i64 %v105, 0
  br i1 %c.b13, label %b13.t90, label %b13.e91
b13.t90:
  br label %b15
b13.e91:
  br label %b16
b14:
  br label %b17
b15:
  %v106 = add i64 0, 1
  %v107 = getelementptr i64, ptr %v14, i64 %v106
  call void @"rt.err_relocate"(ptr %v107, i64 %v15)
  br label %b16
b16:
  %v471 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v471, i64 0
  store i64 %v15, ptr %st91
  br label %b2
b17:
  %v108 = getelementptr i64, ptr %s10, i64 0
  %v109 = add i64 0, 0
  %v110 = getelementptr i64, ptr %s11, i64 0
  %v111 = getelementptr i64, ptr %s12, i64 0
  %v112 = add i64 0, 0
  %st92 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st92
  %st93 = getelementptr i64, ptr %v111, i64 0
  store i64 %v83, ptr %st93
  %v113 = getelementptr i64, ptr %s13, i64 0
  %v114.p = getelementptr i64, ptr %v111, i64 0
  %v114 = load i64, ptr %v114.p
  %st94 = getelementptr i64, ptr %v113, i64 0
  store i64 %v114, ptr %st94
  %v472 = getelementptr i64, ptr @"rt.meta", i64 0
  %v115.p = getelementptr i64, ptr %v472, i64 0
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v113, i64 0
  %v116 = load i64, ptr %v116.p
  %v117 = call i64 @"std/net.Port"(i64 %v116)
  %st95 = getelementptr i64, ptr %v3, i64 0
  store i64 %v117, ptr %st95
  br label %b18
b18:
  %v473 = getelementptr i64, ptr @"rt.meta", i64 0
  %st96 = getelementptr i64, ptr %v473, i64 0
  store i64 %v115, ptr %st96
  %v118 = getelementptr i64, ptr %s6, i64 0
  %v119 = add i64 0, 0
  %st97 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st97
  %v120.p = getelementptr i64, ptr %v118, i64 0
  %v120 = load i64, ptr %v120.p
  %st98 = getelementptr i64, ptr %v14, i64 0
  store i64 %v120, ptr %st98
  %v121.p = getelementptr i64, ptr %v118, i64 1
  %v121 = load i64, ptr %v121.p
  %st99 = getelementptr i64, ptr %v14, i64 1
  store i64 %v121, ptr %st99
  %v122.p = getelementptr i64, ptr %v118, i64 2
  %v122 = load i64, ptr %v122.p
  %st100 = getelementptr i64, ptr %v14, i64 2
  store i64 %v122, ptr %st100
  %v123.p = getelementptr i64, ptr %v118, i64 3
  %v123 = load i64, ptr %v123.p
  %st101 = getelementptr i64, ptr %v14, i64 3
  store i64 %v123, ptr %st101
  %v124.p = getelementptr i64, ptr %v118, i64 4
  %v124 = load i64, ptr %v124.p
  %st102 = getelementptr i64, ptr %v14, i64 4
  store i64 %v124, ptr %st102
  %v125.p = getelementptr i64, ptr %v118, i64 5
  %v125 = load i64, ptr %v125.p
  %st103 = getelementptr i64, ptr %v14, i64 5
  store i64 %v125, ptr %st103
  call void @"std/net.closeFd"(i64 %v83)
  %v126.p = getelementptr i64, ptr %v14, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 0, 0
  %v128.c = icmp ne i64 %v126, %v127
  %v128 = zext i1 %v128.c to i64
  %c.b18 = icmp ne i64 %v128, 0
  br i1 %c.b18, label %b18.t105, label %b18.e106
b18.t105:
  br label %b19
b18.e106:
  br label %b20
b19:
  %v129 = add i64 0, 1
  %v130 = getelementptr i64, ptr %v14, i64 %v129
  call void @"rt.err_relocate"(ptr %v130, i64 %v15)
  br label %b20
b20:
  %v474 = getelementptr i64, ptr @"rt.meta", i64 0
  %st106 = getelementptr i64, ptr %v474, i64 0
  store i64 %v15, ptr %st106
  br label %b2
b21:
  %v134 = add i64 0, 0
  %v135.p = getelementptr i64, ptr %v14, i64 0
  %v135 = load i64, ptr %v135.p
  %st107 = getelementptr i64, ptr %v0, i64 0
  store i64 %v135, ptr %st107
  %v136.p = getelementptr i64, ptr %v14, i64 1
  %v136 = load i64, ptr %v136.p
  %st108 = getelementptr i64, ptr %v0, i64 1
  store i64 %v136, ptr %st108
  %v137.p = getelementptr i64, ptr %v14, i64 2
  %v137 = load i64, ptr %v137.p
  %st109 = getelementptr i64, ptr %v0, i64 2
  store i64 %v137, ptr %st109
  %v138.p = getelementptr i64, ptr %v14, i64 3
  %v138 = load i64, ptr %v138.p
  %st110 = getelementptr i64, ptr %v0, i64 3
  store i64 %v138, ptr %st110
  %v139.p = getelementptr i64, ptr %v14, i64 4
  %v139 = load i64, ptr %v139.p
  %st111 = getelementptr i64, ptr %v0, i64 4
  store i64 %v139, ptr %st111
  %v140.p = getelementptr i64, ptr %v14, i64 5
  %v140 = load i64, ptr %v140.p
  %st112 = getelementptr i64, ptr %v0, i64 5
  store i64 %v140, ptr %st112
  %v141.p = getelementptr i64, ptr %v0, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 0, 0
  %v143.c = icmp ne i64 %v141, %v142
  %v143 = zext i1 %v143.c to i64
  %c.b21 = icmp ne i64 %v143, 0
  br i1 %c.b21, label %b21.t114, label %b21.e115
b21.t114:
  br label %b23
b21.e115:
  br label %b24
b22:
  br label %b1
b23:
  %v144 = add i64 0, 1
  %v145 = getelementptr i64, ptr %v0, i64 %v144
  call void @"rt.err_relocate"(ptr %v145, i64 %v1)
  br label %b24
b24:
  %v475 = getelementptr i64, ptr @"rt.meta", i64 0
  %st115 = getelementptr i64, ptr %v475, i64 0
  store i64 %v1, ptr %st115
  ret void
b25:
  %v476 = getelementptr i64, ptr @"rt.meta", i64 0
  %st116 = getelementptr i64, ptr %v476, i64 0
  store i64 %v146, ptr %st116
  %v449 = getelementptr i64, ptr %s15, i64 0
  %v450 = add i64 0, 0
  %st117 = getelementptr i64, ptr %v449, i64 0
  store i64 %v450, ptr %st117
  %v451.p = getelementptr i64, ptr %v449, i64 0
  %v451 = load i64, ptr %v451.p
  %st118 = getelementptr i64, ptr %v0, i64 0
  store i64 %v451, ptr %st118
  %v452.p = getelementptr i64, ptr %v449, i64 1
  %v452 = load i64, ptr %v452.p
  %st119 = getelementptr i64, ptr %v0, i64 1
  store i64 %v452, ptr %st119
  %v453.p = getelementptr i64, ptr %v449, i64 2
  %v453 = load i64, ptr %v453.p
  %st120 = getelementptr i64, ptr %v0, i64 2
  store i64 %v453, ptr %st120
  %v454.p = getelementptr i64, ptr %v449, i64 3
  %v454 = load i64, ptr %v454.p
  %st121 = getelementptr i64, ptr %v0, i64 3
  store i64 %v454, ptr %st121
  %v455.p = getelementptr i64, ptr %v449, i64 4
  %v455 = load i64, ptr %v455.p
  %st122 = getelementptr i64, ptr %v0, i64 4
  store i64 %v455, ptr %st122
  %v456.p = getelementptr i64, ptr %v449, i64 5
  %v456 = load i64, ptr %v456.p
  %st123 = getelementptr i64, ptr %v0, i64 5
  store i64 %v456, ptr %st123
  %v457.p = getelementptr i64, ptr %v0, i64 0
  %v457 = load i64, ptr %v457.p
  %v458 = add i64 0, 0
  %v459.c = icmp ne i64 %v457, %v458
  %v459 = zext i1 %v459.c to i64
  %c.b25 = icmp ne i64 %v459, 0
  br i1 %c.b25, label %b25.t125, label %b25.e126
b25.t125:
  br label %b68
b25.e126:
  br label %b69
b26:
  %v434.p = getelementptr i64, ptr %v177, i64 0
  %v434 = load i64, ptr %v434.p
  %v435 = add i64 0, 0
  %v436.c = icmp ne i64 %v434, %v435
  %v436 = zext i1 %v436.c to i64
  %c.b26 = icmp ne i64 %v436, 0
  br i1 %c.b26, label %b26.t127, label %b26.e128
b26.t127:
  br label %b64
b26.e128:
  br label %b65
b27:
  %v182 = getelementptr i64, ptr %s4, i64 0
  %v183 = add i64 0, 0
  %st128 = getelementptr i64, ptr %v182, i64 0
  store i64 %v183, ptr %st128
  %st129 = getelementptr i64, ptr %v182, i64 1
  store i64 %v183, ptr %st129
  %v184 = add i64 0, 3
  %st130 = getelementptr i64, ptr %v182, i64 0
  store i64 %v184, ptr %st130
  %v185 = getelementptr i64, ptr %s5, i64 0
  %v186.p = getelementptr i64, ptr %v182, i64 0
  %v186 = load i64, ptr %v186.p
  %st131 = getelementptr i64, ptr %v185, i64 0
  store i64 %v186, ptr %st131
  %v187.p = getelementptr i64, ptr %v182, i64 1
  %v187 = load i64, ptr %v187.p
  %st132 = getelementptr i64, ptr %v185, i64 1
  store i64 %v187, ptr %st132
  %v188 = add i64 0, 0
  %st133 = getelementptr i64, ptr %v185, i64 2
  store i64 %v188, ptr %st133
  %st134 = getelementptr i64, ptr %v185, i64 3
  store i64 %v188, ptr %st134
  %st135 = getelementptr i64, ptr %v185, i64 4
  store i64 %v188, ptr %st135
  %v189 = getelementptr i64, ptr %s15, i64 0
  %v190 = add i64 0, 1
  %st136 = getelementptr i64, ptr %v189, i64 0
  store i64 %v190, ptr %st136
  %v191.p = getelementptr i64, ptr %v185, i64 0
  %v191 = load i64, ptr %v191.p
  %st137 = getelementptr i64, ptr %v189, i64 1
  store i64 %v191, ptr %st137
  %v192.p = getelementptr i64, ptr %v185, i64 1
  %v192 = load i64, ptr %v192.p
  %st138 = getelementptr i64, ptr %v189, i64 2
  store i64 %v192, ptr %st138
  %v193.p = getelementptr i64, ptr %v185, i64 2
  %v193 = load i64, ptr %v193.p
  %st139 = getelementptr i64, ptr %v189, i64 3
  store i64 %v193, ptr %st139
  %v194.p = getelementptr i64, ptr %v185, i64 3
  %v194 = load i64, ptr %v194.p
  %st140 = getelementptr i64, ptr %v189, i64 4
  store i64 %v194, ptr %st140
  %v195.p = getelementptr i64, ptr %v185, i64 4
  %v195 = load i64, ptr %v195.p
  %st141 = getelementptr i64, ptr %v189, i64 5
  store i64 %v195, ptr %st141
  %v196.p = getelementptr i64, ptr %v189, i64 0
  %v196 = load i64, ptr %v196.p
  %st142 = getelementptr i64, ptr %v177, i64 0
  store i64 %v196, ptr %st142
  %v197.p = getelementptr i64, ptr %v189, i64 1
  %v197 = load i64, ptr %v197.p
  %st143 = getelementptr i64, ptr %v177, i64 1
  store i64 %v197, ptr %st143
  %v198.p = getelementptr i64, ptr %v189, i64 2
  %v198 = load i64, ptr %v198.p
  %st144 = getelementptr i64, ptr %v177, i64 2
  store i64 %v198, ptr %st144
  %v199.p = getelementptr i64, ptr %v189, i64 3
  %v199 = load i64, ptr %v199.p
  %st145 = getelementptr i64, ptr %v177, i64 3
  store i64 %v199, ptr %st145
  %v200.p = getelementptr i64, ptr %v189, i64 4
  %v200 = load i64, ptr %v200.p
  %st146 = getelementptr i64, ptr %v177, i64 4
  store i64 %v200, ptr %st146
  %v201.p = getelementptr i64, ptr %v189, i64 5
  %v201 = load i64, ptr %v201.p
  %st147 = getelementptr i64, ptr %v177, i64 5
  store i64 %v201, ptr %st147
  %v202.p = getelementptr i64, ptr %v177, i64 0
  %v202 = load i64, ptr %v202.p
  %v203 = add i64 0, 0
  %v204.c = icmp ne i64 %v202, %v203
  %v204 = zext i1 %v204.c to i64
  %c.b27 = icmp ne i64 %v204, 0
  br i1 %c.b27, label %b27.t149, label %b27.e150
b27.t149:
  br label %b29
b27.e150:
  br label %b30
b28:
  br label %b31
b29:
  %v205 = add i64 0, 1
  %v206 = getelementptr i64, ptr %v177, i64 %v205
  call void @"rt.err_relocate"(ptr %v206, i64 %v178)
  br label %b30
b30:
  %v477 = getelementptr i64, ptr @"rt.meta", i64 0
  %st150 = getelementptr i64, ptr %v477, i64 0
  store i64 %v178, ptr %st150
  br label %b26
b31:
  %v207 = getelementptr i64, ptr %s16, i64 0
  %v208.p = getelementptr i64, ptr %v173, i64 0
  %v208 = load i64, ptr %v208.p
  %v209.p = getelementptr i64, ptr %v173, i64 1
  %v209 = load i64, ptr %v209.p
  %v210.p = getelementptr i64, ptr %v173, i64 2
  %v210 = load i64, ptr %v210.p
  %v211 = getelementptr i64, ptr @"rt.meta", i64 0
  %st151 = getelementptr i64, ptr %v211, i64 2571
  store i64 %v178, ptr %st151
  call void @"std/net.sockaddr"(ptr %v207, i64 %v208, i64 %v209, i64 %v210)
  %v212 = getelementptr i64, ptr %s17, i64 0
  %v213.p = getelementptr i64, ptr %v207, i64 0
  %v213 = load i64, ptr %v213.p
  %st152 = getelementptr i64, ptr %v212, i64 0
  store i64 %v213, ptr %st152
  %v214.p = getelementptr i64, ptr %v207, i64 1
  %v214 = load i64, ptr %v214.p
  %st153 = getelementptr i64, ptr %v212, i64 1
  store i64 %v214, ptr %st153
  %v215.p = getelementptr i64, ptr %v207, i64 2
  %v215 = load i64, ptr %v215.p
  %st154 = getelementptr i64, ptr %v212, i64 2
  store i64 %v215, ptr %st154
  %v216.p = getelementptr i64, ptr %v212, i64 1
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 0, 16
  %v218.c = icmp ne i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b31 = icmp ne i64 %v218, 0
  br i1 %c.b31, label %b31.t156, label %b31.e157
b31.t156:
  br label %b32
b31.e157:
  br label %b33
b32:
  %v219 = getelementptr i64, ptr %s4, i64 0
  %v220 = add i64 0, 0
  %st157 = getelementptr i64, ptr %v219, i64 0
  store i64 %v220, ptr %st157
  %st158 = getelementptr i64, ptr %v219, i64 1
  store i64 %v220, ptr %st158
  %v221 = add i64 0, 6
  %st159 = getelementptr i64, ptr %v219, i64 0
  store i64 %v221, ptr %st159
  %v222 = getelementptr i64, ptr %s5, i64 0
  %v223.p = getelementptr i64, ptr %v219, i64 0
  %v223 = load i64, ptr %v223.p
  %st160 = getelementptr i64, ptr %v222, i64 0
  store i64 %v223, ptr %st160
  %v224.p = getelementptr i64, ptr %v219, i64 1
  %v224 = load i64, ptr %v224.p
  %st161 = getelementptr i64, ptr %v222, i64 1
  store i64 %v224, ptr %st161
  %v225 = add i64 0, 0
  %st162 = getelementptr i64, ptr %v222, i64 2
  store i64 %v225, ptr %st162
  %st163 = getelementptr i64, ptr %v222, i64 3
  store i64 %v225, ptr %st163
  %st164 = getelementptr i64, ptr %v222, i64 4
  store i64 %v225, ptr %st164
  %v226 = getelementptr i64, ptr %s15, i64 0
  %v227 = add i64 0, 1
  %st165 = getelementptr i64, ptr %v226, i64 0
  store i64 %v227, ptr %st165
  %v228.p = getelementptr i64, ptr %v222, i64 0
  %v228 = load i64, ptr %v228.p
  %st166 = getelementptr i64, ptr %v226, i64 1
  store i64 %v228, ptr %st166
  %v229.p = getelementptr i64, ptr %v222, i64 1
  %v229 = load i64, ptr %v229.p
  %st167 = getelementptr i64, ptr %v226, i64 2
  store i64 %v229, ptr %st167
  %v230.p = getelementptr i64, ptr %v222, i64 2
  %v230 = load i64, ptr %v230.p
  %st168 = getelementptr i64, ptr %v226, i64 3
  store i64 %v230, ptr %st168
  %v231.p = getelementptr i64, ptr %v222, i64 3
  %v231 = load i64, ptr %v231.p
  %st169 = getelementptr i64, ptr %v226, i64 4
  store i64 %v231, ptr %st169
  %v232.p = getelementptr i64, ptr %v222, i64 4
  %v232 = load i64, ptr %v232.p
  %st170 = getelementptr i64, ptr %v226, i64 5
  store i64 %v232, ptr %st170
  %v233.p = getelementptr i64, ptr %v226, i64 0
  %v233 = load i64, ptr %v233.p
  %st171 = getelementptr i64, ptr %v177, i64 0
  store i64 %v233, ptr %st171
  %v234.p = getelementptr i64, ptr %v226, i64 1
  %v234 = load i64, ptr %v234.p
  %st172 = getelementptr i64, ptr %v177, i64 1
  store i64 %v234, ptr %st172
  %v235.p = getelementptr i64, ptr %v226, i64 2
  %v235 = load i64, ptr %v235.p
  %st173 = getelementptr i64, ptr %v177, i64 2
  store i64 %v235, ptr %st173
  %v236.p = getelementptr i64, ptr %v226, i64 3
  %v236 = load i64, ptr %v236.p
  %st174 = getelementptr i64, ptr %v177, i64 3
  store i64 %v236, ptr %st174
  %v237.p = getelementptr i64, ptr %v226, i64 4
  %v237 = load i64, ptr %v237.p
  %st175 = getelementptr i64, ptr %v177, i64 4
  store i64 %v237, ptr %st175
  %v238.p = getelementptr i64, ptr %v226, i64 5
  %v238 = load i64, ptr %v238.p
  %st176 = getelementptr i64, ptr %v177, i64 5
  store i64 %v238, ptr %st176
  %v239.p = getelementptr i64, ptr %v177, i64 0
  %v239 = load i64, ptr %v239.p
  %v240 = add i64 0, 0
  %v241.c = icmp ne i64 %v239, %v240
  %v241 = zext i1 %v241.c to i64
  %c.b32 = icmp ne i64 %v241, 0
  br i1 %c.b32, label %b32.t178, label %b32.e179
b32.t178:
  br label %b34
b32.e179:
  br label %b35
b33:
  br label %b36
b34:
  %v242 = add i64 0, 1
  %v243 = getelementptr i64, ptr %v177, i64 %v242
  call void @"rt.err_relocate"(ptr %v243, i64 %v178)
  br label %b35
b35:
  %v478 = getelementptr i64, ptr @"rt.meta", i64 0
  %st179 = getelementptr i64, ptr %v478, i64 0
  store i64 %v178, ptr %st179
  br label %b26
b36:
  %v244 = add i64 0, 41
  %v245 = add i64 0, 2
  %v246 = add i64 0, 526337
  %v247 = add i64 0, 0
  %v248 = add i64 0, 0
  %v249 = add i64 0, 0
  %v250 = add i64 0, 0
  %v251 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v244, i64 %v245, i64 %v246, i64 %v247, i64 %v248, i64 %v249, i64 %v250)
  %v252 = add i64 0, 0
  %v253.c = icmp slt i64 %v251, %v252
  %v253 = zext i1 %v253.c to i64
  %c.b36 = icmp ne i64 %v253, 0
  br i1 %c.b36, label %b36.t181, label %b36.e182
b36.t181:
  br label %b37
b36.e182:
  br label %b38
b37:
  %v254 = getelementptr i64, ptr %s18, i64 0
  %v255 = add i64 0, 0
  %v256 = sub i64 %v255, %v251
  %v257 = getelementptr i64, ptr @"rt.meta", i64 0
  %st182 = getelementptr i64, ptr %v257, i64 2571
  store i64 %v178, ptr %st182
  call void @"std/net.errOf"(ptr %v254, i64 %v256)
  %v258 = getelementptr i64, ptr %s15, i64 0
  %v259 = add i64 0, 1
  %st183 = getelementptr i64, ptr %v258, i64 0
  store i64 %v259, ptr %st183
  %v260.p = getelementptr i64, ptr %v254, i64 0
  %v260 = load i64, ptr %v260.p
  %st184 = getelementptr i64, ptr %v258, i64 1
  store i64 %v260, ptr %st184
  %v261.p = getelementptr i64, ptr %v254, i64 1
  %v261 = load i64, ptr %v261.p
  %st185 = getelementptr i64, ptr %v258, i64 2
  store i64 %v261, ptr %st185
  %v262.p = getelementptr i64, ptr %v254, i64 2
  %v262 = load i64, ptr %v262.p
  %st186 = getelementptr i64, ptr %v258, i64 3
  store i64 %v262, ptr %st186
  %v263.p = getelementptr i64, ptr %v254, i64 3
  %v263 = load i64, ptr %v263.p
  %st187 = getelementptr i64, ptr %v258, i64 4
  store i64 %v263, ptr %st187
  %v264.p = getelementptr i64, ptr %v254, i64 4
  %v264 = load i64, ptr %v264.p
  %st188 = getelementptr i64, ptr %v258, i64 5
  store i64 %v264, ptr %st188
  %v265.p = getelementptr i64, ptr %v258, i64 0
  %v265 = load i64, ptr %v265.p
  %st189 = getelementptr i64, ptr %v177, i64 0
  store i64 %v265, ptr %st189
  %v266.p = getelementptr i64, ptr %v258, i64 1
  %v266 = load i64, ptr %v266.p
  %st190 = getelementptr i64, ptr %v177, i64 1
  store i64 %v266, ptr %st190
  %v267.p = getelementptr i64, ptr %v258, i64 2
  %v267 = load i64, ptr %v267.p
  %st191 = getelementptr i64, ptr %v177, i64 2
  store i64 %v267, ptr %st191
  %v268.p = getelementptr i64, ptr %v258, i64 3
  %v268 = load i64, ptr %v268.p
  %st192 = getelementptr i64, ptr %v177, i64 3
  store i64 %v268, ptr %st192
  %v269.p = getelementptr i64, ptr %v258, i64 4
  %v269 = load i64, ptr %v269.p
  %st193 = getelementptr i64, ptr %v177, i64 4
  store i64 %v269, ptr %st193
  %v270.p = getelementptr i64, ptr %v258, i64 5
  %v270 = load i64, ptr %v270.p
  %st194 = getelementptr i64, ptr %v177, i64 5
  store i64 %v270, ptr %st194
  %v271.p = getelementptr i64, ptr %v177, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 0, 0
  %v273.c = icmp ne i64 %v271, %v272
  %v273 = zext i1 %v273.c to i64
  %c.b37 = icmp ne i64 %v273, 0
  br i1 %c.b37, label %b37.t196, label %b37.e197
b37.t196:
  br label %b39
b37.e197:
  br label %b40
b38:
  br label %b41
b39:
  %v274 = add i64 0, 1
  %v275 = getelementptr i64, ptr %v177, i64 %v274
  call void @"rt.err_relocate"(ptr %v275, i64 %v178)
  br label %b40
b40:
  %v479 = getelementptr i64, ptr @"rt.meta", i64 0
  %st197 = getelementptr i64, ptr %v479, i64 0
  store i64 %v178, ptr %st197
  br label %b26
b41:
  %v276 = add i64 0, 42
  %v277.p = getelementptr i64, ptr %v212, i64 0
  %v277 = load i64, ptr %v277.p
  %v278 = add i64 0, 16
  %v279 = add i64 0, 0
  %v280 = add i64 0, 0
  %v281 = add i64 0, 0
  %v282 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v276, i64 %v251, i64 %v277, i64 %v278, i64 %v279, i64 %v280, i64 %v281)
  %v283 = getelementptr i64, ptr %s13, i64 0
  %st198 = getelementptr i64, ptr %v283, i64 0
  store i64 %v282, ptr %st198
  %v284.p = getelementptr i64, ptr %v283, i64 0
  %v284 = load i64, ptr %v284.p
  %v285 = add i64 0, 4
  %v286 = call i64 @"std/net.again"(i64 %v284, i64 %v251, i64 %v285)
  %v287 = add i64 0, 0
  %v288.c = icmp slt i64 %v286, %v287
  %v288 = zext i1 %v288.c to i64
  %c.b41 = icmp ne i64 %v288, 0
  br i1 %c.b41, label %b41.t200, label %b41.e201
b41.t200:
  br label %b42
b41.e201:
  br label %b43
b42:
  %v289 = add i64 0, 3
  %v290 = add i64 0, 0
  %v291 = add i64 0, 0
  %v292 = add i64 0, 0
  %v293 = add i64 0, 0
  %v294 = add i64 0, 0
  %v295 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v289, i64 %v251, i64 %v290, i64 %v291, i64 %v292, i64 %v293, i64 %v294)
  %v296 = getelementptr i64, ptr %s19, i64 0
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %st201 = getelementptr i64, ptr %v297, i64 2571
  store i64 %v178, ptr %st201
  call void @"std/net.waitErr"(ptr %v296, i64 %v286)
  %v298 = getelementptr i64, ptr %s15, i64 0
  %v299 = add i64 0, 1
  %st202 = getelementptr i64, ptr %v298, i64 0
  store i64 %v299, ptr %st202
  %v300.p = getelementptr i64, ptr %v296, i64 0
  %v300 = load i64, ptr %v300.p
  %st203 = getelementptr i64, ptr %v298, i64 1
  store i64 %v300, ptr %st203
  %v301.p = getelementptr i64, ptr %v296, i64 1
  %v301 = load i64, ptr %v301.p
  %st204 = getelementptr i64, ptr %v298, i64 2
  store i64 %v301, ptr %st204
  %v302.p = getelementptr i64, ptr %v296, i64 2
  %v302 = load i64, ptr %v302.p
  %st205 = getelementptr i64, ptr %v298, i64 3
  store i64 %v302, ptr %st205
  %v303.p = getelementptr i64, ptr %v296, i64 3
  %v303 = load i64, ptr %v303.p
  %st206 = getelementptr i64, ptr %v298, i64 4
  store i64 %v303, ptr %st206
  %v304.p = getelementptr i64, ptr %v296, i64 4
  %v304 = load i64, ptr %v304.p
  %st207 = getelementptr i64, ptr %v298, i64 5
  store i64 %v304, ptr %st207
  %v305.p = getelementptr i64, ptr %v298, i64 0
  %v305 = load i64, ptr %v305.p
  %st208 = getelementptr i64, ptr %v177, i64 0
  store i64 %v305, ptr %st208
  %v306.p = getelementptr i64, ptr %v298, i64 1
  %v306 = load i64, ptr %v306.p
  %st209 = getelementptr i64, ptr %v177, i64 1
  store i64 %v306, ptr %st209
  %v307.p = getelementptr i64, ptr %v298, i64 2
  %v307 = load i64, ptr %v307.p
  %st210 = getelementptr i64, ptr %v177, i64 2
  store i64 %v307, ptr %st210
  %v308.p = getelementptr i64, ptr %v298, i64 3
  %v308 = load i64, ptr %v308.p
  %st211 = getelementptr i64, ptr %v177, i64 3
  store i64 %v308, ptr %st211
  %v309.p = getelementptr i64, ptr %v298, i64 4
  %v309 = load i64, ptr %v309.p
  %st212 = getelementptr i64, ptr %v177, i64 4
  store i64 %v309, ptr %st212
  %v310.p = getelementptr i64, ptr %v298, i64 5
  %v310 = load i64, ptr %v310.p
  %st213 = getelementptr i64, ptr %v177, i64 5
  store i64 %v310, ptr %st213
  %v311.p = getelementptr i64, ptr %v177, i64 0
  %v311 = load i64, ptr %v311.p
  %v312 = add i64 0, 0
  %v313.c = icmp ne i64 %v311, %v312
  %v313 = zext i1 %v313.c to i64
  %c.b42 = icmp ne i64 %v313, 0
  br i1 %c.b42, label %b42.t215, label %b42.e216
b42.t215:
  br label %b44
b42.e216:
  br label %b45
b43:
  %v316 = add i64 0, 0
  %v317.c = icmp eq i64 %v286, %v316
  %v317 = zext i1 %v317.c to i64
  %c.b43 = icmp ne i64 %v317, 0
  br i1 %c.b43, label %b43.t217, label %b43.e218
b43.t217:
  br label %b46
b43.e218:
  br label %b47
b44:
  %v314 = add i64 0, 1
  %v315 = getelementptr i64, ptr %v177, i64 %v314
  call void @"rt.err_relocate"(ptr %v315, i64 %v178)
  br label %b45
b45:
  %v480 = getelementptr i64, ptr @"rt.meta", i64 0
  %st218 = getelementptr i64, ptr %v480, i64 0
  store i64 %v178, ptr %st218
  br label %b26
b46:
  %v318 = add i64 0, 0
  %v319 = add i64 0, 0
  %v320 = add i64 0, 0
  %v321 = add i64 0, 0
  %v322 = add i64 0, 4
  %v323 = call ptr @"rt.region_alloc8"(i64 %v178, i64 %v322)
  %v324 = add i64 0, 0
  %v325 = getelementptr i8, ptr %v323, i64 %v324
  %st219 = getelementptr i8, ptr %v325, i64 0
  %st219.b = trunc i64 %v318 to i8
  store i8 %st219.b, ptr %st219
  %v326 = add i64 0, 1
  %v327 = getelementptr i8, ptr %v323, i64 %v326
  %st220 = getelementptr i8, ptr %v327, i64 0
  %st220.b = trunc i64 %v319 to i8
  store i8 %st220.b, ptr %st220
  %v328 = add i64 0, 2
  %v329 = getelementptr i8, ptr %v323, i64 %v328
  %st221 = getelementptr i8, ptr %v329, i64 0
  %st221.b = trunc i64 %v320 to i8
  store i8 %st221.b, ptr %st221
  %v330 = add i64 0, 3
  %v331 = getelementptr i8, ptr %v323, i64 %v330
  %st222 = getelementptr i8, ptr %v331, i64 0
  %st222.b = trunc i64 %v321 to i8
  store i8 %st222.b, ptr %st222
  %v332 = add i64 0, 4
  %v333 = getelementptr i64, ptr %s20, i64 0
  %v334 = ptrtoint ptr %v323 to i64
  %st223 = getelementptr i64, ptr %v333, i64 0
  store i64 %v334, ptr %st223
  %st224 = getelementptr i64, ptr %v333, i64 1
  store i64 %v332, ptr %st224
  %st225 = getelementptr i64, ptr %v333, i64 2
  store i64 %v178, ptr %st225
  %v335 = getelementptr i64, ptr %s21, i64 0
  %v336.p = getelementptr i64, ptr %v333, i64 0
  %v336 = load i64, ptr %v336.p
  %st226 = getelementptr i64, ptr %v335, i64 0
  store i64 %v336, ptr %st226
  %v337.p = getelementptr i64, ptr %v333, i64 1
  %v337 = load i64, ptr %v337.p
  %st227 = getelementptr i64, ptr %v335, i64 1
  store i64 %v337, ptr %st227
  %v338.p = getelementptr i64, ptr %v333, i64 2
  %v338 = load i64, ptr %v338.p
  %st228 = getelementptr i64, ptr %v335, i64 2
  store i64 %v338, ptr %st228
  %v339 = add i64 0, 4
  %v340 = add i64 0, 0
  %v341 = add i64 0, 0
  %v342 = add i64 0, 0
  %v343 = add i64 0, 4
  %v344 = call ptr @"rt.region_alloc8"(i64 %v178, i64 %v343)
  %v345 = add i64 0, 0
  %v346 = getelementptr i8, ptr %v344, i64 %v345
  %st229 = getelementptr i8, ptr %v346, i64 0
  %st229.b = trunc i64 %v339 to i8
  store i8 %st229.b, ptr %st229
  %v347 = add i64 0, 1
  %v348 = getelementptr i8, ptr %v344, i64 %v347
  %st230 = getelementptr i8, ptr %v348, i64 0
  %st230.b = trunc i64 %v340 to i8
  store i8 %st230.b, ptr %st230
  %v349 = add i64 0, 2
  %v350 = getelementptr i8, ptr %v344, i64 %v349
  %st231 = getelementptr i8, ptr %v350, i64 0
  %st231.b = trunc i64 %v341 to i8
  store i8 %st231.b, ptr %st231
  %v351 = add i64 0, 3
  %v352 = getelementptr i8, ptr %v344, i64 %v351
  %st232 = getelementptr i8, ptr %v352, i64 0
  %st232.b = trunc i64 %v342 to i8
  store i8 %st232.b, ptr %st232
  %v353 = add i64 0, 4
  %v354 = getelementptr i64, ptr %s20, i64 0
  %v355 = ptrtoint ptr %v344 to i64
  %st233 = getelementptr i64, ptr %v354, i64 0
  store i64 %v355, ptr %st233
  %st234 = getelementptr i64, ptr %v354, i64 1
  store i64 %v353, ptr %st234
  %st235 = getelementptr i64, ptr %v354, i64 2
  store i64 %v178, ptr %st235
  %v356 = getelementptr i64, ptr %s22, i64 0
  %v357.p = getelementptr i64, ptr %v354, i64 0
  %v357 = load i64, ptr %v357.p
  %st236 = getelementptr i64, ptr %v356, i64 0
  store i64 %v357, ptr %st236
  %v358.p = getelementptr i64, ptr %v354, i64 1
  %v358 = load i64, ptr %v358.p
  %st237 = getelementptr i64, ptr %v356, i64 1
  store i64 %v358, ptr %st237
  %v359.p = getelementptr i64, ptr %v354, i64 2
  %v359 = load i64, ptr %v359.p
  %st238 = getelementptr i64, ptr %v356, i64 2
  store i64 %v359, ptr %st238
  %v360 = add i64 0, 55
  %v361 = add i64 0, 1
  %v362 = add i64 0, 4
  %v363.p = getelementptr i64, ptr %v335, i64 0
  %v363 = load i64, ptr %v363.p
  %v364.p = getelementptr i64, ptr %v356, i64 0
  %v364 = load i64, ptr %v364.p
  %v365 = add i64 0, 0
  %v366 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v360, i64 %v251, i64 %v361, i64 %v362, i64 %v363, i64 %v364, i64 %v365)
  %v367 = add i64 0, 0
  %v368.c = icmp slt i64 %v366, %v367
  %v368 = zext i1 %v368.c to i64
  %c.b46 = icmp ne i64 %v368, 0
  br i1 %c.b46, label %b46.t240, label %b46.e241
b46.t240:
  br label %b48
b46.e241:
  br label %b49
b47:
  br label %b55
b48:
  br label %b54
b49:
  %v369 = add i64 0, 0
  %v370 = add i64 0, 0
  %v371.p = getelementptr i64, ptr %v335, i64 1
  %v371 = load i64, ptr %v371.p
  %v372.c = icmp uge i64 %v370, %v371
  %v372 = zext i1 %v372.c to i64
  %c.b49 = icmp ne i64 %v372, 0
  br i1 %c.b49, label %b49.t242, label %b49.e243
b49.t242:
  br label %b50
b49.e243:
  br label %b51
b50:
  %v373 = add i64 0, 1
  call void @"rt.panic"(i64 %v373)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v374.p = getelementptr i64, ptr %v335, i64 0
  %v374 = load i64, ptr %v374.p
  %v375 = inttoptr i64 %v374 to ptr
  %v376 = getelementptr i8, ptr %v375, i64 %v370
  %v377.p = getelementptr i8, ptr %v376, i64 0
  %v377.b = load i8, ptr %v377.p
  %v377 = zext i8 %v377.b to i64
  %v378 = add i64 0, 1
  %v379.p = getelementptr i64, ptr %v335, i64 1
  %v379 = load i64, ptr %v379.p
  %v380.c = icmp uge i64 %v378, %v379
  %v380 = zext i1 %v380.c to i64
  %c.b51 = icmp ne i64 %v380, 0
  br i1 %c.b51, label %b51.t244, label %b51.e245
b51.t244:
  br label %b52
b51.e245:
  br label %b53
b52:
  %v381 = add i64 0, 2
  call void @"rt.panic"(i64 %v381)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b53:
  %v382.p = getelementptr i64, ptr %v335, i64 0
  %v382 = load i64, ptr %v382.p
  %v383 = inttoptr i64 %v382 to ptr
  %v384 = getelementptr i8, ptr %v383, i64 %v378
  %v385.p = getelementptr i8, ptr %v384, i64 0
  %v385.b = load i8, ptr %v385.p
  %v385 = zext i8 %v385.b to i64
  %v386 = add i64 0, 256
  %v387 = mul i64 %v385, %v386
  %v388 = add i64 %v377, %v387
  %v389 = sub i64 %v369, %v388
  br label %b54
b54:
  %v390 = phi i64 [ %v366, %b48 ], [ %v389, %b53 ]
  %st245 = getelementptr i64, ptr %v283, i64 0
  store i64 %v390, ptr %st245
  br label %b55
b55:
  br label %b56
b56:
  %v391.p = getelementptr i64, ptr %v283, i64 0
  %v391 = load i64, ptr %v391.p
  %v392 = add i64 0, 0
  %v393.c = icmp slt i64 %v391, %v392
  %v393 = zext i1 %v393.c to i64
  %c.b56 = icmp ne i64 %v393, 0
  br i1 %c.b56, label %b56.t247, label %b56.e248
b56.t247:
  br label %b57
b56.e248:
  br label %b58
b57:
  %v394 = add i64 0, 3
  %v395 = add i64 0, 0
  %v396 = add i64 0, 0
  %v397 = add i64 0, 0
  %v398 = add i64 0, 0
  %v399 = add i64 0, 0
  %v400 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v394, i64 %v251, i64 %v395, i64 %v396, i64 %v397, i64 %v398, i64 %v399)
  %v401 = getelementptr i64, ptr %s23, i64 0
  %v402 = add i64 0, 0
  %v403.p = getelementptr i64, ptr %v283, i64 0
  %v403 = load i64, ptr %v403.p
  %v404 = sub i64 %v402, %v403
  %v405 = getelementptr i64, ptr @"rt.meta", i64 0
  %st248 = getelementptr i64, ptr %v405, i64 2571
  store i64 %v178, ptr %st248
  call void @"std/net.errOf"(ptr %v401, i64 %v404)
  %v406 = getelementptr i64, ptr %s15, i64 0
  %v407 = add i64 0, 1
  %st249 = getelementptr i64, ptr %v406, i64 0
  store i64 %v407, ptr %st249
  %v408.p = getelementptr i64, ptr %v401, i64 0
  %v408 = load i64, ptr %v408.p
  %st250 = getelementptr i64, ptr %v406, i64 1
  store i64 %v408, ptr %st250
  %v409.p = getelementptr i64, ptr %v401, i64 1
  %v409 = load i64, ptr %v409.p
  %st251 = getelementptr i64, ptr %v406, i64 2
  store i64 %v409, ptr %st251
  %v410.p = getelementptr i64, ptr %v401, i64 2
  %v410 = load i64, ptr %v410.p
  %st252 = getelementptr i64, ptr %v406, i64 3
  store i64 %v410, ptr %st252
  %v411.p = getelementptr i64, ptr %v401, i64 3
  %v411 = load i64, ptr %v411.p
  %st253 = getelementptr i64, ptr %v406, i64 4
  store i64 %v411, ptr %st253
  %v412.p = getelementptr i64, ptr %v401, i64 4
  %v412 = load i64, ptr %v412.p
  %st254 = getelementptr i64, ptr %v406, i64 5
  store i64 %v412, ptr %st254
  %v413.p = getelementptr i64, ptr %v406, i64 0
  %v413 = load i64, ptr %v413.p
  %st255 = getelementptr i64, ptr %v177, i64 0
  store i64 %v413, ptr %st255
  %v414.p = getelementptr i64, ptr %v406, i64 1
  %v414 = load i64, ptr %v414.p
  %st256 = getelementptr i64, ptr %v177, i64 1
  store i64 %v414, ptr %st256
  %v415.p = getelementptr i64, ptr %v406, i64 2
  %v415 = load i64, ptr %v415.p
  %st257 = getelementptr i64, ptr %v177, i64 2
  store i64 %v415, ptr %st257
  %v416.p = getelementptr i64, ptr %v406, i64 3
  %v416 = load i64, ptr %v416.p
  %st258 = getelementptr i64, ptr %v177, i64 3
  store i64 %v416, ptr %st258
  %v417.p = getelementptr i64, ptr %v406, i64 4
  %v417 = load i64, ptr %v417.p
  %st259 = getelementptr i64, ptr %v177, i64 4
  store i64 %v417, ptr %st259
  %v418.p = getelementptr i64, ptr %v406, i64 5
  %v418 = load i64, ptr %v418.p
  %st260 = getelementptr i64, ptr %v177, i64 5
  store i64 %v418, ptr %st260
  %v419.p = getelementptr i64, ptr %v177, i64 0
  %v419 = load i64, ptr %v419.p
  %v420 = add i64 0, 0
  %v421.c = icmp ne i64 %v419, %v420
  %v421 = zext i1 %v421.c to i64
  %c.b57 = icmp ne i64 %v421, 0
  br i1 %c.b57, label %b57.t262, label %b57.e263
b57.t262:
  br label %b59
b57.e263:
  br label %b60
b58:
  br label %b61
b59:
  %v422 = add i64 0, 1
  %v423 = getelementptr i64, ptr %v177, i64 %v422
  call void @"rt.err_relocate"(ptr %v423, i64 %v178)
  br label %b60
b60:
  %v481 = getelementptr i64, ptr @"rt.meta", i64 0
  %st263 = getelementptr i64, ptr %v481, i64 0
  store i64 %v178, ptr %st263
  br label %b26
b61:
  %v424 = getelementptr i64, ptr %s12, i64 0
  %v482 = getelementptr i64, ptr @"rt.meta", i64 0
  %v425.p = getelementptr i64, ptr %v482, i64 0
  %v425 = load i64, ptr %v425.p
  %v426 = getelementptr i64, ptr %s11, i64 0
  %v427 = add i64 0, 0
  %v428 = getelementptr i64, ptr %s10, i64 0
  %v429 = getelementptr i64, ptr %s24, i64 0
  %v430 = add i64 0, 0
  %st264 = getelementptr i64, ptr %v429, i64 0
  store i64 %v430, ptr %st264
  %st265 = getelementptr i64, ptr %v429, i64 0
  store i64 %v251, ptr %st265
  %v431 = getelementptr i64, ptr %s25, i64 0
  %v432.p = getelementptr i64, ptr %v429, i64 0
  %v432 = load i64, ptr %v432.p
  %st266 = getelementptr i64, ptr %v431, i64 0
  store i64 %v432, ptr %st266
  %v483 = getelementptr i64, ptr @"rt.meta", i64 0
  %v433.p = getelementptr i64, ptr %v483, i64 0
  %v433 = load i64, ptr %v433.p
  call void @"std/net.closeFd"(i64 %v251)
  br label %b25
b62:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b63:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b64:
  %v437 = add i64 0, 0
  %v438.p = getelementptr i64, ptr %v177, i64 0
  %v438 = load i64, ptr %v438.p
  %st267 = getelementptr i64, ptr %v0, i64 0
  store i64 %v438, ptr %st267
  %v439.p = getelementptr i64, ptr %v177, i64 1
  %v439 = load i64, ptr %v439.p
  %st268 = getelementptr i64, ptr %v0, i64 1
  store i64 %v439, ptr %st268
  %v440.p = getelementptr i64, ptr %v177, i64 2
  %v440 = load i64, ptr %v440.p
  %st269 = getelementptr i64, ptr %v0, i64 2
  store i64 %v440, ptr %st269
  %v441.p = getelementptr i64, ptr %v177, i64 3
  %v441 = load i64, ptr %v441.p
  %st270 = getelementptr i64, ptr %v0, i64 3
  store i64 %v441, ptr %st270
  %v442.p = getelementptr i64, ptr %v177, i64 4
  %v442 = load i64, ptr %v442.p
  %st271 = getelementptr i64, ptr %v0, i64 4
  store i64 %v442, ptr %st271
  %v443.p = getelementptr i64, ptr %v177, i64 5
  %v443 = load i64, ptr %v443.p
  %st272 = getelementptr i64, ptr %v0, i64 5
  store i64 %v443, ptr %st272
  %v444.p = getelementptr i64, ptr %v0, i64 0
  %v444 = load i64, ptr %v444.p
  %v445 = add i64 0, 0
  %v446.c = icmp ne i64 %v444, %v445
  %v446 = zext i1 %v446.c to i64
  %c.b64 = icmp ne i64 %v446, 0
  br i1 %c.b64, label %b64.t274, label %b64.e275
b64.t274:
  br label %b66
b64.e275:
  br label %b67
b65:
  br label %b25
b66:
  %v447 = add i64 0, 1
  %v448 = getelementptr i64, ptr %v0, i64 %v447
  call void @"rt.err_relocate"(ptr %v448, i64 %v1)
  br label %b67
b67:
  %v484 = getelementptr i64, ptr @"rt.meta", i64 0
  %st275 = getelementptr i64, ptr %v484, i64 0
  store i64 %v1, ptr %st275
  ret void
b68:
  %v460 = add i64 0, 1
  %v461 = getelementptr i64, ptr %v0, i64 %v460
  call void @"rt.err_relocate"(ptr %v461, i64 %v1)
  br label %b69
b69:
  %v485 = getelementptr i64, ptr @"rt.meta", i64 0
  %st276 = getelementptr i64, ptr %v485, i64 0
  store i64 %v1, ptr %st276
  ret void
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
  %s10 = alloca [1 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
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
  %s21 = alloca [5 x i64], align 8
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
  %s22 = alloca [1 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %s23 = alloca [5 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %s23.z1 = getelementptr i64, ptr %s23, i64 1
  store i64 0, ptr %s23.z1
  %s23.z2 = getelementptr i64, ptr %s23, i64 2
  store i64 0, ptr %s23.z2
  %s23.z3 = getelementptr i64, ptr %s23, i64 3
  store i64 0, ptr %s23.z3
  %s23.z4 = getelementptr i64, ptr %s23, i64 4
  store i64 0, ptr %s23.z4
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
  %s27 = alloca [5 x i64], align 8
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
  %s28 = alloca [1 x i64], align 8
  %s28.z0 = getelementptr i64, ptr %s28, i64 0
  store i64 0, ptr %s28.z0
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
  %s33 = alloca [6 x i64], align 8
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
  %s34 = alloca [1 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
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
  %s36 = alloca [5 x i64], align 8
  %s36.z0 = getelementptr i64, ptr %s36, i64 0
  store i64 0, ptr %s36.z0
  %s36.z1 = getelementptr i64, ptr %s36, i64 1
  store i64 0, ptr %s36.z1
  %s36.z2 = getelementptr i64, ptr %s36, i64 2
  store i64 0, ptr %s36.z2
  %s36.z3 = getelementptr i64, ptr %s36, i64 3
  store i64 0, ptr %s36.z3
  %s36.z4 = getelementptr i64, ptr %s36, i64 4
  store i64 0, ptr %s36.z4
  %s37 = alloca [5 x i64], align 8
  %s37.z0 = getelementptr i64, ptr %s37, i64 0
  store i64 0, ptr %s37.z0
  %s37.z1 = getelementptr i64, ptr %s37, i64 1
  store i64 0, ptr %s37.z1
  %s37.z2 = getelementptr i64, ptr %s37, i64 2
  store i64 0, ptr %s37.z2
  %s37.z3 = getelementptr i64, ptr %s37, i64 3
  store i64 0, ptr %s37.z3
  %s37.z4 = getelementptr i64, ptr %s37, i64 4
  store i64 0, ptr %s37.z4
  %s38 = alloca [1 x i64], align 8
  %s38.z0 = getelementptr i64, ptr %s38, i64 0
  store i64 0, ptr %s38.z0
  %s39 = alloca [1 x i64], align 8
  %s39.z0 = getelementptr i64, ptr %s39, i64 0
  store i64 0, ptr %s39.z0
  %s40 = alloca [1 x i64], align 8
  %s40.z0 = getelementptr i64, ptr %s40, i64 0
  store i64 0, ptr %s40.z0
  %s41 = alloca [1 x i64], align 8
  %s41.z0 = getelementptr i64, ptr %s41, i64 0
  store i64 0, ptr %s41.z0
  %s42 = alloca [1 x i64], align 8
  %s42.z0 = getelementptr i64, ptr %s42, i64 0
  store i64 0, ptr %s42.z0
  %s43 = alloca [3 x i64], align 8
  %s43.z0 = getelementptr i64, ptr %s43, i64 0
  store i64 0, ptr %s43.z0
  %s43.z1 = getelementptr i64, ptr %s43, i64 1
  store i64 0, ptr %s43.z1
  %s43.z2 = getelementptr i64, ptr %s43, i64 2
  store i64 0, ptr %s43.z2
  %s44 = alloca [6 x i64], align 8
  %s44.z0 = getelementptr i64, ptr %s44, i64 0
  store i64 0, ptr %s44.z0
  %s44.z1 = getelementptr i64, ptr %s44, i64 1
  store i64 0, ptr %s44.z1
  %s44.z2 = getelementptr i64, ptr %s44, i64 2
  store i64 0, ptr %s44.z2
  %s44.z3 = getelementptr i64, ptr %s44, i64 3
  store i64 0, ptr %s44.z3
  %s44.z4 = getelementptr i64, ptr %s44, i64 4
  store i64 0, ptr %s44.z4
  %s44.z5 = getelementptr i64, ptr %s44, i64 5
  store i64 0, ptr %s44.z5
  %s45 = alloca [3 x i64], align 8
  %s45.z0 = getelementptr i64, ptr %s45, i64 0
  store i64 0, ptr %s45.z0
  %s45.z1 = getelementptr i64, ptr %s45, i64 1
  store i64 0, ptr %s45.z1
  %s45.z2 = getelementptr i64, ptr %s45, i64 2
  store i64 0, ptr %s45.z2
  %s46 = alloca [6 x i64], align 8
  %s46.z0 = getelementptr i64, ptr %s46, i64 0
  store i64 0, ptr %s46.z0
  %s46.z1 = getelementptr i64, ptr %s46, i64 1
  store i64 0, ptr %s46.z1
  %s46.z2 = getelementptr i64, ptr %s46, i64 2
  store i64 0, ptr %s46.z2
  %s46.z3 = getelementptr i64, ptr %s46, i64 3
  store i64 0, ptr %s46.z3
  %s46.z4 = getelementptr i64, ptr %s46, i64 4
  store i64 0, ptr %s46.z4
  %s46.z5 = getelementptr i64, ptr %s46, i64 5
  store i64 0, ptr %s46.z5
  %s47 = alloca [3 x i64], align 8
  %s47.z0 = getelementptr i64, ptr %s47, i64 0
  store i64 0, ptr %s47.z0
  %s47.z1 = getelementptr i64, ptr %s47, i64 1
  store i64 0, ptr %s47.z1
  %s47.z2 = getelementptr i64, ptr %s47, i64 2
  store i64 0, ptr %s47.z2
  %s48 = alloca [3 x i64], align 8
  %s48.z0 = getelementptr i64, ptr %s48, i64 0
  store i64 0, ptr %s48.z0
  %s48.z1 = getelementptr i64, ptr %s48, i64 1
  store i64 0, ptr %s48.z1
  %s48.z2 = getelementptr i64, ptr %s48, i64 2
  store i64 0, ptr %s48.z2
  %s49 = alloca [3 x i64], align 8
  %s49.z0 = getelementptr i64, ptr %s49, i64 0
  store i64 0, ptr %s49.z0
  %s49.z1 = getelementptr i64, ptr %s49, i64 1
  store i64 0, ptr %s49.z1
  %s49.z2 = getelementptr i64, ptr %s49, i64 2
  store i64 0, ptr %s49.z2
  %v733 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v733, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = getelementptr i64, ptr @"str.0", i64 0
  %v3 = add i64 0, 0
  %v4 = add i64 0, 0
  %v5 = getelementptr i64, ptr %s0, i64 0
  %v6 = ptrtoint ptr %v2 to i64
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v6, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v3, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v4, ptr %st2
  %v7 = getelementptr i64, ptr %s1, i64 0
  %v8.p = getelementptr i64, ptr %v5, i64 0
  %v8 = load i64, ptr %v8.p
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st3
  %v9.p = getelementptr i64, ptr %v5, i64 1
  %v9 = load i64, ptr %v9.p
  %st4 = getelementptr i64, ptr %v7, i64 1
  store i64 %v9, ptr %st4
  %v10.p = getelementptr i64, ptr %v5, i64 2
  %v10 = load i64, ptr %v10.p
  %st5 = getelementptr i64, ptr %v7, i64 2
  store i64 %v10, ptr %st5
  %v734 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v734, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = getelementptr i64, ptr @"str.15", i64 0
  %v13 = add i64 0, 11
  %v14 = add i64 0, 0
  %v15 = getelementptr i64, ptr %s0, i64 0
  %v16 = ptrtoint ptr %v12 to i64
  %st6 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st6
  %st7 = getelementptr i64, ptr %v15, i64 1
  store i64 %v13, ptr %st7
  %st8 = getelementptr i64, ptr %v15, i64 2
  store i64 %v14, ptr %st8
  %v17 = getelementptr i64, ptr %s2, i64 0
  %v18.p = getelementptr i64, ptr %v15, i64 0
  %v18 = load i64, ptr %v18.p
  %st9 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st9
  %v19.p = getelementptr i64, ptr %v15, i64 1
  %v19 = load i64, ptr %v19.p
  %st10 = getelementptr i64, ptr %v17, i64 1
  store i64 %v19, ptr %st10
  %v20.p = getelementptr i64, ptr %v15, i64 2
  %v20 = load i64, ptr %v20.p
  %st11 = getelementptr i64, ptr %v17, i64 2
  store i64 %v20, ptr %st11
  %v21 = getelementptr i64, ptr %s3, i64 0
  %v735 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v735, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 0, 0
  %v24 = add i64 0, 0
  %v25.c = icmp ne i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b0 = icmp ne i64 %v25, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b3
b0.e14:
  br label %b4
b1:
  %v736 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v736, i64 0
  store i64 %v11, ptr %st14
  %v717 = getelementptr i64, ptr %s35, i64 0
  %v718 = add i64 0, 0
  %st15 = getelementptr i64, ptr %v717, i64 0
  store i64 %v718, ptr %st15
  %v719.p = getelementptr i64, ptr %v7, i64 0
  %v719 = load i64, ptr %v719.p
  %st16 = getelementptr i64, ptr %v0, i64 0
  store i64 %v719, ptr %st16
  %v720.p = getelementptr i64, ptr %v7, i64 1
  %v720 = load i64, ptr %v720.p
  %st17 = getelementptr i64, ptr %v0, i64 1
  store i64 %v720, ptr %st17
  %v721.p = getelementptr i64, ptr %v7, i64 2
  %v721 = load i64, ptr %v721.p
  %st18 = getelementptr i64, ptr %v0, i64 2
  store i64 %v721, ptr %st18
  %v722.p = getelementptr i64, ptr %v717, i64 0
  %v722 = load i64, ptr %v722.p
  %st19 = getelementptr i64, ptr %v0, i64 3
  store i64 %v722, ptr %st19
  %v723.p = getelementptr i64, ptr %v717, i64 1
  %v723 = load i64, ptr %v723.p
  %st20 = getelementptr i64, ptr %v0, i64 4
  store i64 %v723, ptr %st20
  %v724.p = getelementptr i64, ptr %v717, i64 2
  %v724 = load i64, ptr %v724.p
  %st21 = getelementptr i64, ptr %v0, i64 5
  store i64 %v724, ptr %st21
  %v725.p = getelementptr i64, ptr %v717, i64 3
  %v725 = load i64, ptr %v725.p
  %st22 = getelementptr i64, ptr %v0, i64 6
  store i64 %v725, ptr %st22
  %v726.p = getelementptr i64, ptr %v717, i64 4
  %v726 = load i64, ptr %v726.p
  %st23 = getelementptr i64, ptr %v0, i64 7
  store i64 %v726, ptr %st23
  %v727.p = getelementptr i64, ptr %v717, i64 5
  %v727 = load i64, ptr %v727.p
  %st24 = getelementptr i64, ptr %v0, i64 8
  store i64 %v727, ptr %st24
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v728.p = getelementptr i64, ptr %v0, i64 3
  %v728 = load i64, ptr %v728.p
  %v729 = add i64 0, 0
  %v730.c = icmp ne i64 %v728, %v729
  %v730 = zext i1 %v730.c to i64
  %c.b1 = icmp ne i64 %v730, 0
  br i1 %c.b1, label %b1.t26, label %b1.e27
b1.t26:
  br label %b105
b1.e27:
  br label %b106
b2:
  %v698.p = getelementptr i64, ptr %v21, i64 0
  %v698 = load i64, ptr %v698.p
  %v699 = add i64 0, 0
  %v700.c = icmp ne i64 %v698, %v699
  %v700 = zext i1 %v700.c to i64
  %c.b2 = icmp ne i64 %v700, 0
  br i1 %c.b2, label %b2.t28, label %b2.e29
b2.t28:
  br label %b101
b2.e29:
  br label %b102
b3:
  %v26 = getelementptr i64, ptr %s4, i64 0
  %v27 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st29
  %st30 = getelementptr i64, ptr %v26, i64 1
  store i64 %v27, ptr %st30
  %v28 = add i64 0, 3
  %st31 = getelementptr i64, ptr %v26, i64 0
  store i64 %v28, ptr %st31
  %v29 = getelementptr i64, ptr %s5, i64 0
  %v30.p = getelementptr i64, ptr %v26, i64 0
  %v30 = load i64, ptr %v30.p
  %st32 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st32
  %v31.p = getelementptr i64, ptr %v26, i64 1
  %v31 = load i64, ptr %v31.p
  %st33 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st33
  %v32 = add i64 0, 0
  %st34 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st34
  %st35 = getelementptr i64, ptr %v29, i64 3
  store i64 %v32, ptr %st35
  %st36 = getelementptr i64, ptr %v29, i64 4
  store i64 %v32, ptr %st36
  %v33 = getelementptr i64, ptr %s6, i64 0
  %v34 = add i64 0, 1
  %st37 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st37
  %v35.p = getelementptr i64, ptr %v29, i64 0
  %v35 = load i64, ptr %v35.p
  %st38 = getelementptr i64, ptr %v33, i64 1
  store i64 %v35, ptr %st38
  %v36.p = getelementptr i64, ptr %v29, i64 1
  %v36 = load i64, ptr %v36.p
  %st39 = getelementptr i64, ptr %v33, i64 2
  store i64 %v36, ptr %st39
  %v37.p = getelementptr i64, ptr %v29, i64 2
  %v37 = load i64, ptr %v37.p
  %st40 = getelementptr i64, ptr %v33, i64 3
  store i64 %v37, ptr %st40
  %v38.p = getelementptr i64, ptr %v29, i64 3
  %v38 = load i64, ptr %v38.p
  %st41 = getelementptr i64, ptr %v33, i64 4
  store i64 %v38, ptr %st41
  %v39.p = getelementptr i64, ptr %v29, i64 4
  %v39 = load i64, ptr %v39.p
  %st42 = getelementptr i64, ptr %v33, i64 5
  store i64 %v39, ptr %st42
  %v40.p = getelementptr i64, ptr %v33, i64 0
  %v40 = load i64, ptr %v40.p
  %st43 = getelementptr i64, ptr %v21, i64 0
  store i64 %v40, ptr %st43
  %v41.p = getelementptr i64, ptr %v33, i64 1
  %v41 = load i64, ptr %v41.p
  %st44 = getelementptr i64, ptr %v21, i64 1
  store i64 %v41, ptr %st44
  %v42.p = getelementptr i64, ptr %v33, i64 2
  %v42 = load i64, ptr %v42.p
  %st45 = getelementptr i64, ptr %v21, i64 2
  store i64 %v42, ptr %st45
  %v43.p = getelementptr i64, ptr %v33, i64 3
  %v43 = load i64, ptr %v43.p
  %st46 = getelementptr i64, ptr %v21, i64 3
  store i64 %v43, ptr %st46
  %v44.p = getelementptr i64, ptr %v33, i64 4
  %v44 = load i64, ptr %v44.p
  %st47 = getelementptr i64, ptr %v21, i64 4
  store i64 %v44, ptr %st47
  %v45.p = getelementptr i64, ptr %v33, i64 5
  %v45 = load i64, ptr %v45.p
  %st48 = getelementptr i64, ptr %v21, i64 5
  store i64 %v45, ptr %st48
  %v46.p = getelementptr i64, ptr %v21, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 0, 0
  %v48.c = icmp ne i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b3 = icmp ne i64 %v48, 0
  br i1 %c.b3, label %b3.t50, label %b3.e51
b3.t50:
  br label %b5
b3.e51:
  br label %b6
b4:
  br label %b7
b5:
  %v49 = add i64 0, 1
  %v50 = getelementptr i64, ptr %v21, i64 %v49
  call void @"rt.err_relocate"(ptr %v50, i64 %v22)
  br label %b6
b6:
  %v737 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v737, i64 0
  store i64 %v22, ptr %st51
  br label %b2
b7:
  %v51 = getelementptr i64, ptr %s7, i64 0
  %v52.p = getelementptr i64, ptr %v17, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v17, i64 1
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v17, i64 2
  %v54 = load i64, ptr %v54.p
  call void @"std/net.sockaddr"(ptr %v51, i64 %v52, i64 %v53, i64 %v54)
  %v55 = getelementptr i64, ptr %s8, i64 0
  %v56.p = getelementptr i64, ptr %v51, i64 0
  %v56 = load i64, ptr %v56.p
  %st52 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st52
  %v57.p = getelementptr i64, ptr %v51, i64 1
  %v57 = load i64, ptr %v57.p
  %st53 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st53
  %v58.p = getelementptr i64, ptr %v51, i64 2
  %v58 = load i64, ptr %v58.p
  %st54 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st54
  %v59.p = getelementptr i64, ptr %v55, i64 1
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 16
  %v61.c = icmp ne i64 %v59, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b7 = icmp ne i64 %v61, 0
  br i1 %c.b7, label %b7.t56, label %b7.e57
b7.t56:
  br label %b8
b7.e57:
  br label %b9
b8:
  %v62 = getelementptr i64, ptr %s4, i64 0
  %v63 = add i64 0, 0
  %st57 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st57
  %st58 = getelementptr i64, ptr %v62, i64 1
  store i64 %v63, ptr %st58
  %v64 = add i64 0, 6
  %st59 = getelementptr i64, ptr %v62, i64 0
  store i64 %v64, ptr %st59
  %v65 = getelementptr i64, ptr %s5, i64 0
  %v66.p = getelementptr i64, ptr %v62, i64 0
  %v66 = load i64, ptr %v66.p
  %st60 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st60
  %v67.p = getelementptr i64, ptr %v62, i64 1
  %v67 = load i64, ptr %v67.p
  %st61 = getelementptr i64, ptr %v65, i64 1
  store i64 %v67, ptr %st61
  %v68 = add i64 0, 0
  %st62 = getelementptr i64, ptr %v65, i64 2
  store i64 %v68, ptr %st62
  %st63 = getelementptr i64, ptr %v65, i64 3
  store i64 %v68, ptr %st63
  %st64 = getelementptr i64, ptr %v65, i64 4
  store i64 %v68, ptr %st64
  %v69 = getelementptr i64, ptr %s6, i64 0
  %v70 = add i64 0, 1
  %st65 = getelementptr i64, ptr %v69, i64 0
  store i64 %v70, ptr %st65
  %v71.p = getelementptr i64, ptr %v65, i64 0
  %v71 = load i64, ptr %v71.p
  %st66 = getelementptr i64, ptr %v69, i64 1
  store i64 %v71, ptr %st66
  %v72.p = getelementptr i64, ptr %v65, i64 1
  %v72 = load i64, ptr %v72.p
  %st67 = getelementptr i64, ptr %v69, i64 2
  store i64 %v72, ptr %st67
  %v73.p = getelementptr i64, ptr %v65, i64 2
  %v73 = load i64, ptr %v73.p
  %st68 = getelementptr i64, ptr %v69, i64 3
  store i64 %v73, ptr %st68
  %v74.p = getelementptr i64, ptr %v65, i64 3
  %v74 = load i64, ptr %v74.p
  %st69 = getelementptr i64, ptr %v69, i64 4
  store i64 %v74, ptr %st69
  %v75.p = getelementptr i64, ptr %v65, i64 4
  %v75 = load i64, ptr %v75.p
  %st70 = getelementptr i64, ptr %v69, i64 5
  store i64 %v75, ptr %st70
  %v76.p = getelementptr i64, ptr %v69, i64 0
  %v76 = load i64, ptr %v76.p
  %st71 = getelementptr i64, ptr %v21, i64 0
  store i64 %v76, ptr %st71
  %v77.p = getelementptr i64, ptr %v69, i64 1
  %v77 = load i64, ptr %v77.p
  %st72 = getelementptr i64, ptr %v21, i64 1
  store i64 %v77, ptr %st72
  %v78.p = getelementptr i64, ptr %v69, i64 2
  %v78 = load i64, ptr %v78.p
  %st73 = getelementptr i64, ptr %v21, i64 2
  store i64 %v78, ptr %st73
  %v79.p = getelementptr i64, ptr %v69, i64 3
  %v79 = load i64, ptr %v79.p
  %st74 = getelementptr i64, ptr %v21, i64 3
  store i64 %v79, ptr %st74
  %v80.p = getelementptr i64, ptr %v69, i64 4
  %v80 = load i64, ptr %v80.p
  %st75 = getelementptr i64, ptr %v21, i64 4
  store i64 %v80, ptr %st75
  %v81.p = getelementptr i64, ptr %v69, i64 5
  %v81 = load i64, ptr %v81.p
  %st76 = getelementptr i64, ptr %v21, i64 5
  store i64 %v81, ptr %st76
  %v82.p = getelementptr i64, ptr %v21, i64 0
  %v82 = load i64, ptr %v82.p
  %v83 = add i64 0, 0
  %v84.c = icmp ne i64 %v82, %v83
  %v84 = zext i1 %v84.c to i64
  %c.b8 = icmp ne i64 %v84, 0
  br i1 %c.b8, label %b8.t78, label %b8.e79
b8.t78:
  br label %b10
b8.e79:
  br label %b11
b9:
  br label %b12
b10:
  %v85 = add i64 0, 1
  %v86 = getelementptr i64, ptr %v21, i64 %v85
  call void @"rt.err_relocate"(ptr %v86, i64 %v22)
  br label %b11
b11:
  %v738 = getelementptr i64, ptr @"rt.meta", i64 0
  %st79 = getelementptr i64, ptr %v738, i64 0
  store i64 %v22, ptr %st79
  br label %b2
b12:
  %v87.p = getelementptr i64, ptr %v55, i64 0
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v55, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v55, i64 2
  %v89 = load i64, ptr %v89.p
  %v90 = call i64 @"std/net.listenFd"(i64 %v87, i64 %v88, i64 %v89)
  %v91 = add i64 0, 0
  %v92.c = icmp slt i64 %v90, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b12 = icmp ne i64 %v92, 0
  br i1 %c.b12, label %b12.t81, label %b12.e82
b12.t81:
  br label %b13
b12.e82:
  br label %b14
b13:
  %v93 = getelementptr i64, ptr %s9, i64 0
  %v94 = add i64 0, 0
  %v95 = sub i64 %v94, %v90
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v96, i64 2571
  store i64 %v22, ptr %st82
  call void @"std/net.errOf"(ptr %v93, i64 %v95)
  %v97 = getelementptr i64, ptr %s6, i64 0
  %v98 = add i64 0, 1
  %st83 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st83
  %v99.p = getelementptr i64, ptr %v93, i64 0
  %v99 = load i64, ptr %v99.p
  %st84 = getelementptr i64, ptr %v97, i64 1
  store i64 %v99, ptr %st84
  %v100.p = getelementptr i64, ptr %v93, i64 1
  %v100 = load i64, ptr %v100.p
  %st85 = getelementptr i64, ptr %v97, i64 2
  store i64 %v100, ptr %st85
  %v101.p = getelementptr i64, ptr %v93, i64 2
  %v101 = load i64, ptr %v101.p
  %st86 = getelementptr i64, ptr %v97, i64 3
  store i64 %v101, ptr %st86
  %v102.p = getelementptr i64, ptr %v93, i64 3
  %v102 = load i64, ptr %v102.p
  %st87 = getelementptr i64, ptr %v97, i64 4
  store i64 %v102, ptr %st87
  %v103.p = getelementptr i64, ptr %v93, i64 4
  %v103 = load i64, ptr %v103.p
  %st88 = getelementptr i64, ptr %v97, i64 5
  store i64 %v103, ptr %st88
  %v104.p = getelementptr i64, ptr %v97, i64 0
  %v104 = load i64, ptr %v104.p
  %st89 = getelementptr i64, ptr %v21, i64 0
  store i64 %v104, ptr %st89
  %v105.p = getelementptr i64, ptr %v97, i64 1
  %v105 = load i64, ptr %v105.p
  %st90 = getelementptr i64, ptr %v21, i64 1
  store i64 %v105, ptr %st90
  %v106.p = getelementptr i64, ptr %v97, i64 2
  %v106 = load i64, ptr %v106.p
  %st91 = getelementptr i64, ptr %v21, i64 2
  store i64 %v106, ptr %st91
  %v107.p = getelementptr i64, ptr %v97, i64 3
  %v107 = load i64, ptr %v107.p
  %st92 = getelementptr i64, ptr %v21, i64 3
  store i64 %v107, ptr %st92
  %v108.p = getelementptr i64, ptr %v97, i64 4
  %v108 = load i64, ptr %v108.p
  %st93 = getelementptr i64, ptr %v21, i64 4
  store i64 %v108, ptr %st93
  %v109.p = getelementptr i64, ptr %v97, i64 5
  %v109 = load i64, ptr %v109.p
  %st94 = getelementptr i64, ptr %v21, i64 5
  store i64 %v109, ptr %st94
  %v110.p = getelementptr i64, ptr %v21, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = add i64 0, 0
  %v112.c = icmp ne i64 %v110, %v111
  %v112 = zext i1 %v112.c to i64
  %c.b13 = icmp ne i64 %v112, 0
  br i1 %c.b13, label %b13.t96, label %b13.e97
b13.t96:
  br label %b15
b13.e97:
  br label %b16
b14:
  br label %b17
b15:
  %v113 = add i64 0, 1
  %v114 = getelementptr i64, ptr %v21, i64 %v113
  call void @"rt.err_relocate"(ptr %v114, i64 %v22)
  br label %b16
b16:
  %v739 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v739, i64 0
  store i64 %v22, ptr %st97
  br label %b2
b17:
  %v115 = getelementptr i64, ptr %s10, i64 0
  %v116 = add i64 0, 0
  %v117 = getelementptr i64, ptr %s11, i64 0
  %v118 = getelementptr i64, ptr %s12, i64 0
  %v119 = add i64 0, 0
  %st98 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st98
  %st99 = getelementptr i64, ptr %v118, i64 0
  store i64 %v90, ptr %st99
  %v120 = getelementptr i64, ptr %s13, i64 0
  %v121.p = getelementptr i64, ptr %v118, i64 0
  %v121 = load i64, ptr %v121.p
  %st100 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st100
  %v740 = getelementptr i64, ptr @"rt.meta", i64 0
  %v122.p = getelementptr i64, ptr %v740, i64 0
  %v122 = load i64, ptr %v122.p
  %v741 = getelementptr i64, ptr @"rt.meta", i64 0
  %v123.p = getelementptr i64, ptr %v741, i64 0
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v120, i64 0
  %v124 = load i64, ptr %v124.p
  %v125 = call i64 @"std/net.Port"(i64 %v124)
  %v126 = getelementptr i64, ptr @"str.14", i64 0
  %v127 = add i64 0, 10
  %v128 = add i64 0, 0
  %v129 = getelementptr i64, ptr %s14, i64 0
  %v130 = ptrtoint ptr %v126 to i64
  %st101 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st101
  %st102 = getelementptr i64, ptr %v129, i64 1
  store i64 %v127, ptr %st102
  %st103 = getelementptr i64, ptr %v129, i64 2
  store i64 %v128, ptr %st103
  %v131 = getelementptr i64, ptr %s15, i64 0
  call void @"std/convert.FormatInt"(ptr %v131, i64 %v125)
  %v132 = add i64 0, 0
  %v133.p = getelementptr i64, ptr %v129, i64 1
  %v133 = load i64, ptr %v133.p
  %v134 = add i64 %v132, %v133
  %v135.p = getelementptr i64, ptr %v131, i64 1
  %v135 = load i64, ptr %v135.p
  %v136 = add i64 %v134, %v135
  %v742 = getelementptr i64, ptr @"rt.meta", i64 0
  %v137.p = getelementptr i64, ptr %v742, i64 0
  %v137 = load i64, ptr %v137.p
  %v138.p = getelementptr i64, ptr %v129, i64 1
  %v138 = load i64, ptr %v138.p
  %v139 = sub i64 %v136, %v138
  %v140.p = getelementptr i64, ptr %v129, i64 0
  %v140 = load i64, ptr %v140.p
  %v141.p = getelementptr i64, ptr %v129, i64 1
  %v141 = load i64, ptr %v141.p
  %v142.p = getelementptr i64, ptr %v129, i64 2
  %v142 = load i64, ptr %v142.p
  %v143 = call ptr @"rt.cat8"(i64 %v140, i64 %v141, i64 %v142, i64 %v137, i64 %v139)
  %v144.p = getelementptr i64, ptr %v131, i64 1
  %v144 = load i64, ptr %v144.p
  %v145 = getelementptr i8, ptr %v143, i64 %v138
  %v146.p = getelementptr i64, ptr %v131, i64 0
  %v146 = load i64, ptr %v146.p
  %v147 = inttoptr i64 %v146 to ptr
  call void @"rt.copy8"(ptr %v145, ptr %v147, i64 %v144)
  %v148 = add i64 %v138, %v144
  %v149 = getelementptr i64, ptr %s16, i64 0
  %v150 = ptrtoint ptr %v143 to i64
  %st104 = getelementptr i64, ptr %v149, i64 0
  store i64 %v150, ptr %st104
  %st105 = getelementptr i64, ptr %v149, i64 1
  store i64 %v136, ptr %st105
  %st106 = getelementptr i64, ptr %v149, i64 2
  store i64 %v137, ptr %st106
  %v151 = getelementptr i64, ptr %s17, i64 0
  %v152.p = getelementptr i64, ptr %v149, i64 0
  %v152 = load i64, ptr %v152.p
  %st107 = getelementptr i64, ptr %v151, i64 0
  store i64 %v152, ptr %st107
  %v153.p = getelementptr i64, ptr %v149, i64 1
  %v153 = load i64, ptr %v153.p
  %st108 = getelementptr i64, ptr %v151, i64 1
  store i64 %v153, ptr %st108
  %v154.p = getelementptr i64, ptr %v149, i64 2
  %v154 = load i64, ptr %v154.p
  %st109 = getelementptr i64, ptr %v151, i64 2
  store i64 %v154, ptr %st109
  %v155 = getelementptr i64, ptr %s6, i64 0
  %v743 = getelementptr i64, ptr @"rt.meta", i64 0
  %v156.p = getelementptr i64, ptr %v743, i64 0
  %v156 = load i64, ptr %v156.p
  %v157 = add i64 0, 0
  %v158 = add i64 0, 0
  %v159.c = icmp ne i64 %v157, %v158
  %v159 = zext i1 %v159.c to i64
  %c.b17 = icmp ne i64 %v159, 0
  br i1 %c.b17, label %b17.t111, label %b17.e112
b17.t111:
  br label %b21
b17.e112:
  br label %b22
b18:
  %v744 = getelementptr i64, ptr @"rt.meta", i64 0
  %st112 = getelementptr i64, ptr %v744, i64 0
  store i64 %v122, ptr %st112
  %v685 = getelementptr i64, ptr %s35, i64 0
  %v686 = add i64 0, 0
  %st113 = getelementptr i64, ptr %v685, i64 0
  store i64 %v686, ptr %st113
  %v687.p = getelementptr i64, ptr %v685, i64 0
  %v687 = load i64, ptr %v687.p
  %st114 = getelementptr i64, ptr %v21, i64 0
  store i64 %v687, ptr %st114
  %v688.p = getelementptr i64, ptr %v685, i64 1
  %v688 = load i64, ptr %v688.p
  %st115 = getelementptr i64, ptr %v21, i64 1
  store i64 %v688, ptr %st115
  %v689.p = getelementptr i64, ptr %v685, i64 2
  %v689 = load i64, ptr %v689.p
  %st116 = getelementptr i64, ptr %v21, i64 2
  store i64 %v689, ptr %st116
  %v690.p = getelementptr i64, ptr %v685, i64 3
  %v690 = load i64, ptr %v690.p
  %st117 = getelementptr i64, ptr %v21, i64 3
  store i64 %v690, ptr %st117
  %v691.p = getelementptr i64, ptr %v685, i64 4
  %v691 = load i64, ptr %v691.p
  %st118 = getelementptr i64, ptr %v21, i64 4
  store i64 %v691, ptr %st118
  %v692.p = getelementptr i64, ptr %v685, i64 5
  %v692 = load i64, ptr %v692.p
  %st119 = getelementptr i64, ptr %v21, i64 5
  store i64 %v692, ptr %st119
  call void @"std/net.closeFd"(i64 %v90)
  %v693.p = getelementptr i64, ptr %v21, i64 0
  %v693 = load i64, ptr %v693.p
  %v694 = add i64 0, 0
  %v695.c = icmp ne i64 %v693, %v694
  %v695 = zext i1 %v695.c to i64
  %c.b18 = icmp ne i64 %v695, 0
  br i1 %c.b18, label %b18.t121, label %b18.e122
b18.t121:
  br label %b99
b18.e122:
  br label %b100
b19:
  %v745 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v745, i64 0
  store i64 %v123, ptr %st122
  br label %b18
b20:
  %v666.p = getelementptr i64, ptr %v155, i64 0
  %v666 = load i64, ptr %v666.p
  %v667 = add i64 0, 0
  %v668.c = icmp ne i64 %v666, %v667
  %v668 = zext i1 %v668.c to i64
  %c.b20 = icmp ne i64 %v668, 0
  br i1 %c.b20, label %b20.t124, label %b20.e125
b20.t124:
  br label %b95
b20.e125:
  br label %b96
b21:
  %v160 = getelementptr i64, ptr %s4, i64 0
  %v161 = add i64 0, 0
  %st125 = getelementptr i64, ptr %v160, i64 0
  store i64 %v161, ptr %st125
  %st126 = getelementptr i64, ptr %v160, i64 1
  store i64 %v161, ptr %st126
  %v162 = add i64 0, 3
  %st127 = getelementptr i64, ptr %v160, i64 0
  store i64 %v162, ptr %st127
  %v163 = getelementptr i64, ptr %s5, i64 0
  %v164.p = getelementptr i64, ptr %v160, i64 0
  %v164 = load i64, ptr %v164.p
  %st128 = getelementptr i64, ptr %v163, i64 0
  store i64 %v164, ptr %st128
  %v165.p = getelementptr i64, ptr %v160, i64 1
  %v165 = load i64, ptr %v165.p
  %st129 = getelementptr i64, ptr %v163, i64 1
  store i64 %v165, ptr %st129
  %v166 = add i64 0, 0
  %st130 = getelementptr i64, ptr %v163, i64 2
  store i64 %v166, ptr %st130
  %st131 = getelementptr i64, ptr %v163, i64 3
  store i64 %v166, ptr %st131
  %st132 = getelementptr i64, ptr %v163, i64 4
  store i64 %v166, ptr %st132
  %v167 = getelementptr i64, ptr %s18, i64 0
  %v168 = add i64 0, 1
  %st133 = getelementptr i64, ptr %v167, i64 0
  store i64 %v168, ptr %st133
  %v169.p = getelementptr i64, ptr %v163, i64 0
  %v169 = load i64, ptr %v169.p
  %st134 = getelementptr i64, ptr %v167, i64 1
  store i64 %v169, ptr %st134
  %v170.p = getelementptr i64, ptr %v163, i64 1
  %v170 = load i64, ptr %v170.p
  %st135 = getelementptr i64, ptr %v167, i64 2
  store i64 %v170, ptr %st135
  %v171.p = getelementptr i64, ptr %v163, i64 2
  %v171 = load i64, ptr %v171.p
  %st136 = getelementptr i64, ptr %v167, i64 3
  store i64 %v171, ptr %st136
  %v172.p = getelementptr i64, ptr %v163, i64 3
  %v172 = load i64, ptr %v172.p
  %st137 = getelementptr i64, ptr %v167, i64 4
  store i64 %v172, ptr %st137
  %v173.p = getelementptr i64, ptr %v163, i64 4
  %v173 = load i64, ptr %v173.p
  %st138 = getelementptr i64, ptr %v167, i64 5
  store i64 %v173, ptr %st138
  %v174.p = getelementptr i64, ptr %v167, i64 0
  %v174 = load i64, ptr %v174.p
  %st139 = getelementptr i64, ptr %v155, i64 0
  store i64 %v174, ptr %st139
  %v175.p = getelementptr i64, ptr %v167, i64 1
  %v175 = load i64, ptr %v175.p
  %st140 = getelementptr i64, ptr %v155, i64 1
  store i64 %v175, ptr %st140
  %v176.p = getelementptr i64, ptr %v167, i64 2
  %v176 = load i64, ptr %v176.p
  %st141 = getelementptr i64, ptr %v155, i64 2
  store i64 %v176, ptr %st141
  %v177.p = getelementptr i64, ptr %v167, i64 3
  %v177 = load i64, ptr %v177.p
  %st142 = getelementptr i64, ptr %v155, i64 3
  store i64 %v177, ptr %st142
  %v178.p = getelementptr i64, ptr %v167, i64 4
  %v178 = load i64, ptr %v178.p
  %st143 = getelementptr i64, ptr %v155, i64 4
  store i64 %v178, ptr %st143
  %v179.p = getelementptr i64, ptr %v167, i64 5
  %v179 = load i64, ptr %v179.p
  %st144 = getelementptr i64, ptr %v155, i64 5
  store i64 %v179, ptr %st144
  %v180.p = getelementptr i64, ptr %v155, i64 0
  %v180 = load i64, ptr %v180.p
  %v181 = add i64 0, 0
  %v182.c = icmp ne i64 %v180, %v181
  %v182 = zext i1 %v182.c to i64
  %c.b21 = icmp ne i64 %v182, 0
  br i1 %c.b21, label %b21.t146, label %b21.e147
b21.t146:
  br label %b23
b21.e147:
  br label %b24
b22:
  br label %b25
b23:
  %v183 = add i64 0, 1
  %v184 = getelementptr i64, ptr %v155, i64 %v183
  call void @"rt.err_relocate"(ptr %v184, i64 %v156)
  br label %b24
b24:
  %v746 = getelementptr i64, ptr @"rt.meta", i64 0
  %st147 = getelementptr i64, ptr %v746, i64 0
  store i64 %v156, ptr %st147
  br label %b20
b25:
  %v185 = getelementptr i64, ptr %s19, i64 0
  %v186.p = getelementptr i64, ptr %v151, i64 0
  %v186 = load i64, ptr %v186.p
  %v187.p = getelementptr i64, ptr %v151, i64 1
  %v187 = load i64, ptr %v187.p
  %v188.p = getelementptr i64, ptr %v151, i64 2
  %v188 = load i64, ptr %v188.p
  %v189 = getelementptr i64, ptr @"rt.meta", i64 0
  %st148 = getelementptr i64, ptr %v189, i64 2571
  store i64 %v156, ptr %st148
  call void @"std/net.sockaddr"(ptr %v185, i64 %v186, i64 %v187, i64 %v188)
  %v190 = getelementptr i64, ptr %s20, i64 0
  %v191.p = getelementptr i64, ptr %v185, i64 0
  %v191 = load i64, ptr %v191.p
  %st149 = getelementptr i64, ptr %v190, i64 0
  store i64 %v191, ptr %st149
  %v192.p = getelementptr i64, ptr %v185, i64 1
  %v192 = load i64, ptr %v192.p
  %st150 = getelementptr i64, ptr %v190, i64 1
  store i64 %v192, ptr %st150
  %v193.p = getelementptr i64, ptr %v185, i64 2
  %v193 = load i64, ptr %v193.p
  %st151 = getelementptr i64, ptr %v190, i64 2
  store i64 %v193, ptr %st151
  %v194.p = getelementptr i64, ptr %v190, i64 1
  %v194 = load i64, ptr %v194.p
  %v195 = add i64 0, 16
  %v196.c = icmp ne i64 %v194, %v195
  %v196 = zext i1 %v196.c to i64
  %c.b25 = icmp ne i64 %v196, 0
  br i1 %c.b25, label %b25.t153, label %b25.e154
b25.t153:
  br label %b26
b25.e154:
  br label %b27
b26:
  %v197 = getelementptr i64, ptr %s4, i64 0
  %v198 = add i64 0, 0
  %st154 = getelementptr i64, ptr %v197, i64 0
  store i64 %v198, ptr %st154
  %st155 = getelementptr i64, ptr %v197, i64 1
  store i64 %v198, ptr %st155
  %v199 = add i64 0, 6
  %st156 = getelementptr i64, ptr %v197, i64 0
  store i64 %v199, ptr %st156
  %v200 = getelementptr i64, ptr %s5, i64 0
  %v201.p = getelementptr i64, ptr %v197, i64 0
  %v201 = load i64, ptr %v201.p
  %st157 = getelementptr i64, ptr %v200, i64 0
  store i64 %v201, ptr %st157
  %v202.p = getelementptr i64, ptr %v197, i64 1
  %v202 = load i64, ptr %v202.p
  %st158 = getelementptr i64, ptr %v200, i64 1
  store i64 %v202, ptr %st158
  %v203 = add i64 0, 0
  %st159 = getelementptr i64, ptr %v200, i64 2
  store i64 %v203, ptr %st159
  %st160 = getelementptr i64, ptr %v200, i64 3
  store i64 %v203, ptr %st160
  %st161 = getelementptr i64, ptr %v200, i64 4
  store i64 %v203, ptr %st161
  %v204 = getelementptr i64, ptr %s18, i64 0
  %v205 = add i64 0, 1
  %st162 = getelementptr i64, ptr %v204, i64 0
  store i64 %v205, ptr %st162
  %v206.p = getelementptr i64, ptr %v200, i64 0
  %v206 = load i64, ptr %v206.p
  %st163 = getelementptr i64, ptr %v204, i64 1
  store i64 %v206, ptr %st163
  %v207.p = getelementptr i64, ptr %v200, i64 1
  %v207 = load i64, ptr %v207.p
  %st164 = getelementptr i64, ptr %v204, i64 2
  store i64 %v207, ptr %st164
  %v208.p = getelementptr i64, ptr %v200, i64 2
  %v208 = load i64, ptr %v208.p
  %st165 = getelementptr i64, ptr %v204, i64 3
  store i64 %v208, ptr %st165
  %v209.p = getelementptr i64, ptr %v200, i64 3
  %v209 = load i64, ptr %v209.p
  %st166 = getelementptr i64, ptr %v204, i64 4
  store i64 %v209, ptr %st166
  %v210.p = getelementptr i64, ptr %v200, i64 4
  %v210 = load i64, ptr %v210.p
  %st167 = getelementptr i64, ptr %v204, i64 5
  store i64 %v210, ptr %st167
  %v211.p = getelementptr i64, ptr %v204, i64 0
  %v211 = load i64, ptr %v211.p
  %st168 = getelementptr i64, ptr %v155, i64 0
  store i64 %v211, ptr %st168
  %v212.p = getelementptr i64, ptr %v204, i64 1
  %v212 = load i64, ptr %v212.p
  %st169 = getelementptr i64, ptr %v155, i64 1
  store i64 %v212, ptr %st169
  %v213.p = getelementptr i64, ptr %v204, i64 2
  %v213 = load i64, ptr %v213.p
  %st170 = getelementptr i64, ptr %v155, i64 2
  store i64 %v213, ptr %st170
  %v214.p = getelementptr i64, ptr %v204, i64 3
  %v214 = load i64, ptr %v214.p
  %st171 = getelementptr i64, ptr %v155, i64 3
  store i64 %v214, ptr %st171
  %v215.p = getelementptr i64, ptr %v204, i64 4
  %v215 = load i64, ptr %v215.p
  %st172 = getelementptr i64, ptr %v155, i64 4
  store i64 %v215, ptr %st172
  %v216.p = getelementptr i64, ptr %v204, i64 5
  %v216 = load i64, ptr %v216.p
  %st173 = getelementptr i64, ptr %v155, i64 5
  store i64 %v216, ptr %st173
  %v217.p = getelementptr i64, ptr %v155, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = add i64 0, 0
  %v219.c = icmp ne i64 %v217, %v218
  %v219 = zext i1 %v219.c to i64
  %c.b26 = icmp ne i64 %v219, 0
  br i1 %c.b26, label %b26.t175, label %b26.e176
b26.t175:
  br label %b28
b26.e176:
  br label %b29
b27:
  br label %b30
b28:
  %v220 = add i64 0, 1
  %v221 = getelementptr i64, ptr %v155, i64 %v220
  call void @"rt.err_relocate"(ptr %v221, i64 %v156)
  br label %b29
b29:
  %v747 = getelementptr i64, ptr @"rt.meta", i64 0
  %st176 = getelementptr i64, ptr %v747, i64 0
  store i64 %v156, ptr %st176
  br label %b20
b30:
  %v222 = add i64 0, 41
  %v223 = add i64 0, 2
  %v224 = add i64 0, 526337
  %v225 = add i64 0, 0
  %v226 = add i64 0, 0
  %v227 = add i64 0, 0
  %v228 = add i64 0, 0
  %v229 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v222, i64 %v223, i64 %v224, i64 %v225, i64 %v226, i64 %v227, i64 %v228)
  %v230 = add i64 0, 0
  %v231.c = icmp slt i64 %v229, %v230
  %v231 = zext i1 %v231.c to i64
  %c.b30 = icmp ne i64 %v231, 0
  br i1 %c.b30, label %b30.t178, label %b30.e179
b30.t178:
  br label %b31
b30.e179:
  br label %b32
b31:
  %v232 = getelementptr i64, ptr %s21, i64 0
  %v233 = add i64 0, 0
  %v234 = sub i64 %v233, %v229
  %v235 = getelementptr i64, ptr @"rt.meta", i64 0
  %st179 = getelementptr i64, ptr %v235, i64 2571
  store i64 %v156, ptr %st179
  call void @"std/net.errOf"(ptr %v232, i64 %v234)
  %v236 = getelementptr i64, ptr %s18, i64 0
  %v237 = add i64 0, 1
  %st180 = getelementptr i64, ptr %v236, i64 0
  store i64 %v237, ptr %st180
  %v238.p = getelementptr i64, ptr %v232, i64 0
  %v238 = load i64, ptr %v238.p
  %st181 = getelementptr i64, ptr %v236, i64 1
  store i64 %v238, ptr %st181
  %v239.p = getelementptr i64, ptr %v232, i64 1
  %v239 = load i64, ptr %v239.p
  %st182 = getelementptr i64, ptr %v236, i64 2
  store i64 %v239, ptr %st182
  %v240.p = getelementptr i64, ptr %v232, i64 2
  %v240 = load i64, ptr %v240.p
  %st183 = getelementptr i64, ptr %v236, i64 3
  store i64 %v240, ptr %st183
  %v241.p = getelementptr i64, ptr %v232, i64 3
  %v241 = load i64, ptr %v241.p
  %st184 = getelementptr i64, ptr %v236, i64 4
  store i64 %v241, ptr %st184
  %v242.p = getelementptr i64, ptr %v232, i64 4
  %v242 = load i64, ptr %v242.p
  %st185 = getelementptr i64, ptr %v236, i64 5
  store i64 %v242, ptr %st185
  %v243.p = getelementptr i64, ptr %v236, i64 0
  %v243 = load i64, ptr %v243.p
  %st186 = getelementptr i64, ptr %v155, i64 0
  store i64 %v243, ptr %st186
  %v244.p = getelementptr i64, ptr %v236, i64 1
  %v244 = load i64, ptr %v244.p
  %st187 = getelementptr i64, ptr %v155, i64 1
  store i64 %v244, ptr %st187
  %v245.p = getelementptr i64, ptr %v236, i64 2
  %v245 = load i64, ptr %v245.p
  %st188 = getelementptr i64, ptr %v155, i64 2
  store i64 %v245, ptr %st188
  %v246.p = getelementptr i64, ptr %v236, i64 3
  %v246 = load i64, ptr %v246.p
  %st189 = getelementptr i64, ptr %v155, i64 3
  store i64 %v246, ptr %st189
  %v247.p = getelementptr i64, ptr %v236, i64 4
  %v247 = load i64, ptr %v247.p
  %st190 = getelementptr i64, ptr %v155, i64 4
  store i64 %v247, ptr %st190
  %v248.p = getelementptr i64, ptr %v236, i64 5
  %v248 = load i64, ptr %v248.p
  %st191 = getelementptr i64, ptr %v155, i64 5
  store i64 %v248, ptr %st191
  %v249.p = getelementptr i64, ptr %v155, i64 0
  %v249 = load i64, ptr %v249.p
  %v250 = add i64 0, 0
  %v251.c = icmp ne i64 %v249, %v250
  %v251 = zext i1 %v251.c to i64
  %c.b31 = icmp ne i64 %v251, 0
  br i1 %c.b31, label %b31.t193, label %b31.e194
b31.t193:
  br label %b33
b31.e194:
  br label %b34
b32:
  br label %b35
b33:
  %v252 = add i64 0, 1
  %v253 = getelementptr i64, ptr %v155, i64 %v252
  call void @"rt.err_relocate"(ptr %v253, i64 %v156)
  br label %b34
b34:
  %v748 = getelementptr i64, ptr @"rt.meta", i64 0
  %st194 = getelementptr i64, ptr %v748, i64 0
  store i64 %v156, ptr %st194
  br label %b20
b35:
  %v254 = add i64 0, 42
  %v255.p = getelementptr i64, ptr %v190, i64 0
  %v255 = load i64, ptr %v255.p
  %v256 = add i64 0, 16
  %v257 = add i64 0, 0
  %v258 = add i64 0, 0
  %v259 = add i64 0, 0
  %v260 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v254, i64 %v229, i64 %v255, i64 %v256, i64 %v257, i64 %v258, i64 %v259)
  %v261 = getelementptr i64, ptr %s22, i64 0
  %st195 = getelementptr i64, ptr %v261, i64 0
  store i64 %v260, ptr %st195
  %v262.p = getelementptr i64, ptr %v261, i64 0
  %v262 = load i64, ptr %v262.p
  %v263 = add i64 0, 4
  %v264 = call i64 @"std/net.again"(i64 %v262, i64 %v229, i64 %v263)
  %v265 = add i64 0, 0
  %v266.c = icmp slt i64 %v264, %v265
  %v266 = zext i1 %v266.c to i64
  %c.b35 = icmp ne i64 %v266, 0
  br i1 %c.b35, label %b35.t197, label %b35.e198
b35.t197:
  br label %b36
b35.e198:
  br label %b37
b36:
  %v267 = add i64 0, 3
  %v268 = add i64 0, 0
  %v269 = add i64 0, 0
  %v270 = add i64 0, 0
  %v271 = add i64 0, 0
  %v272 = add i64 0, 0
  %v273 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v267, i64 %v229, i64 %v268, i64 %v269, i64 %v270, i64 %v271, i64 %v272)
  %v274 = getelementptr i64, ptr %s23, i64 0
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st198 = getelementptr i64, ptr %v275, i64 2571
  store i64 %v156, ptr %st198
  call void @"std/net.waitErr"(ptr %v274, i64 %v264)
  %v276 = getelementptr i64, ptr %s18, i64 0
  %v277 = add i64 0, 1
  %st199 = getelementptr i64, ptr %v276, i64 0
  store i64 %v277, ptr %st199
  %v278.p = getelementptr i64, ptr %v274, i64 0
  %v278 = load i64, ptr %v278.p
  %st200 = getelementptr i64, ptr %v276, i64 1
  store i64 %v278, ptr %st200
  %v279.p = getelementptr i64, ptr %v274, i64 1
  %v279 = load i64, ptr %v279.p
  %st201 = getelementptr i64, ptr %v276, i64 2
  store i64 %v279, ptr %st201
  %v280.p = getelementptr i64, ptr %v274, i64 2
  %v280 = load i64, ptr %v280.p
  %st202 = getelementptr i64, ptr %v276, i64 3
  store i64 %v280, ptr %st202
  %v281.p = getelementptr i64, ptr %v274, i64 3
  %v281 = load i64, ptr %v281.p
  %st203 = getelementptr i64, ptr %v276, i64 4
  store i64 %v281, ptr %st203
  %v282.p = getelementptr i64, ptr %v274, i64 4
  %v282 = load i64, ptr %v282.p
  %st204 = getelementptr i64, ptr %v276, i64 5
  store i64 %v282, ptr %st204
  %v283.p = getelementptr i64, ptr %v276, i64 0
  %v283 = load i64, ptr %v283.p
  %st205 = getelementptr i64, ptr %v155, i64 0
  store i64 %v283, ptr %st205
  %v284.p = getelementptr i64, ptr %v276, i64 1
  %v284 = load i64, ptr %v284.p
  %st206 = getelementptr i64, ptr %v155, i64 1
  store i64 %v284, ptr %st206
  %v285.p = getelementptr i64, ptr %v276, i64 2
  %v285 = load i64, ptr %v285.p
  %st207 = getelementptr i64, ptr %v155, i64 2
  store i64 %v285, ptr %st207
  %v286.p = getelementptr i64, ptr %v276, i64 3
  %v286 = load i64, ptr %v286.p
  %st208 = getelementptr i64, ptr %v155, i64 3
  store i64 %v286, ptr %st208
  %v287.p = getelementptr i64, ptr %v276, i64 4
  %v287 = load i64, ptr %v287.p
  %st209 = getelementptr i64, ptr %v155, i64 4
  store i64 %v287, ptr %st209
  %v288.p = getelementptr i64, ptr %v276, i64 5
  %v288 = load i64, ptr %v288.p
  %st210 = getelementptr i64, ptr %v155, i64 5
  store i64 %v288, ptr %st210
  %v289.p = getelementptr i64, ptr %v155, i64 0
  %v289 = load i64, ptr %v289.p
  %v290 = add i64 0, 0
  %v291.c = icmp ne i64 %v289, %v290
  %v291 = zext i1 %v291.c to i64
  %c.b36 = icmp ne i64 %v291, 0
  br i1 %c.b36, label %b36.t212, label %b36.e213
b36.t212:
  br label %b38
b36.e213:
  br label %b39
b37:
  %v294 = add i64 0, 0
  %v295.c = icmp eq i64 %v264, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b37 = icmp ne i64 %v295, 0
  br i1 %c.b37, label %b37.t214, label %b37.e215
b37.t214:
  br label %b40
b37.e215:
  br label %b41
b38:
  %v292 = add i64 0, 1
  %v293 = getelementptr i64, ptr %v155, i64 %v292
  call void @"rt.err_relocate"(ptr %v293, i64 %v156)
  br label %b39
b39:
  %v749 = getelementptr i64, ptr @"rt.meta", i64 0
  %st215 = getelementptr i64, ptr %v749, i64 0
  store i64 %v156, ptr %st215
  br label %b20
b40:
  %v296 = add i64 0, 0
  %v297 = add i64 0, 0
  %v298 = add i64 0, 0
  %v299 = add i64 0, 0
  %v300 = add i64 0, 4
  %v301 = call ptr @"rt.region_alloc8"(i64 %v156, i64 %v300)
  %v302 = add i64 0, 0
  %v303 = getelementptr i8, ptr %v301, i64 %v302
  %st216 = getelementptr i8, ptr %v303, i64 0
  %st216.b = trunc i64 %v296 to i8
  store i8 %st216.b, ptr %st216
  %v304 = add i64 0, 1
  %v305 = getelementptr i8, ptr %v301, i64 %v304
  %st217 = getelementptr i8, ptr %v305, i64 0
  %st217.b = trunc i64 %v297 to i8
  store i8 %st217.b, ptr %st217
  %v306 = add i64 0, 2
  %v307 = getelementptr i8, ptr %v301, i64 %v306
  %st218 = getelementptr i8, ptr %v307, i64 0
  %st218.b = trunc i64 %v298 to i8
  store i8 %st218.b, ptr %st218
  %v308 = add i64 0, 3
  %v309 = getelementptr i8, ptr %v301, i64 %v308
  %st219 = getelementptr i8, ptr %v309, i64 0
  %st219.b = trunc i64 %v299 to i8
  store i8 %st219.b, ptr %st219
  %v310 = add i64 0, 4
  %v311 = getelementptr i64, ptr %s24, i64 0
  %v312 = ptrtoint ptr %v301 to i64
  %st220 = getelementptr i64, ptr %v311, i64 0
  store i64 %v312, ptr %st220
  %st221 = getelementptr i64, ptr %v311, i64 1
  store i64 %v310, ptr %st221
  %st222 = getelementptr i64, ptr %v311, i64 2
  store i64 %v156, ptr %st222
  %v313 = getelementptr i64, ptr %s25, i64 0
  %v314.p = getelementptr i64, ptr %v311, i64 0
  %v314 = load i64, ptr %v314.p
  %st223 = getelementptr i64, ptr %v313, i64 0
  store i64 %v314, ptr %st223
  %v315.p = getelementptr i64, ptr %v311, i64 1
  %v315 = load i64, ptr %v315.p
  %st224 = getelementptr i64, ptr %v313, i64 1
  store i64 %v315, ptr %st224
  %v316.p = getelementptr i64, ptr %v311, i64 2
  %v316 = load i64, ptr %v316.p
  %st225 = getelementptr i64, ptr %v313, i64 2
  store i64 %v316, ptr %st225
  %v317 = add i64 0, 4
  %v318 = add i64 0, 0
  %v319 = add i64 0, 0
  %v320 = add i64 0, 0
  %v321 = add i64 0, 4
  %v322 = call ptr @"rt.region_alloc8"(i64 %v156, i64 %v321)
  %v323 = add i64 0, 0
  %v324 = getelementptr i8, ptr %v322, i64 %v323
  %st226 = getelementptr i8, ptr %v324, i64 0
  %st226.b = trunc i64 %v317 to i8
  store i8 %st226.b, ptr %st226
  %v325 = add i64 0, 1
  %v326 = getelementptr i8, ptr %v322, i64 %v325
  %st227 = getelementptr i8, ptr %v326, i64 0
  %st227.b = trunc i64 %v318 to i8
  store i8 %st227.b, ptr %st227
  %v327 = add i64 0, 2
  %v328 = getelementptr i8, ptr %v322, i64 %v327
  %st228 = getelementptr i8, ptr %v328, i64 0
  %st228.b = trunc i64 %v319 to i8
  store i8 %st228.b, ptr %st228
  %v329 = add i64 0, 3
  %v330 = getelementptr i8, ptr %v322, i64 %v329
  %st229 = getelementptr i8, ptr %v330, i64 0
  %st229.b = trunc i64 %v320 to i8
  store i8 %st229.b, ptr %st229
  %v331 = add i64 0, 4
  %v332 = getelementptr i64, ptr %s24, i64 0
  %v333 = ptrtoint ptr %v322 to i64
  %st230 = getelementptr i64, ptr %v332, i64 0
  store i64 %v333, ptr %st230
  %st231 = getelementptr i64, ptr %v332, i64 1
  store i64 %v331, ptr %st231
  %st232 = getelementptr i64, ptr %v332, i64 2
  store i64 %v156, ptr %st232
  %v334 = getelementptr i64, ptr %s26, i64 0
  %v335.p = getelementptr i64, ptr %v332, i64 0
  %v335 = load i64, ptr %v335.p
  %st233 = getelementptr i64, ptr %v334, i64 0
  store i64 %v335, ptr %st233
  %v336.p = getelementptr i64, ptr %v332, i64 1
  %v336 = load i64, ptr %v336.p
  %st234 = getelementptr i64, ptr %v334, i64 1
  store i64 %v336, ptr %st234
  %v337.p = getelementptr i64, ptr %v332, i64 2
  %v337 = load i64, ptr %v337.p
  %st235 = getelementptr i64, ptr %v334, i64 2
  store i64 %v337, ptr %st235
  %v338 = add i64 0, 55
  %v339 = add i64 0, 1
  %v340 = add i64 0, 4
  %v341.p = getelementptr i64, ptr %v313, i64 0
  %v341 = load i64, ptr %v341.p
  %v342.p = getelementptr i64, ptr %v334, i64 0
  %v342 = load i64, ptr %v342.p
  %v343 = add i64 0, 0
  %v344 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v338, i64 %v229, i64 %v339, i64 %v340, i64 %v341, i64 %v342, i64 %v343)
  %v345 = add i64 0, 0
  %v346.c = icmp slt i64 %v344, %v345
  %v346 = zext i1 %v346.c to i64
  %c.b40 = icmp ne i64 %v346, 0
  br i1 %c.b40, label %b40.t237, label %b40.e238
b40.t237:
  br label %b42
b40.e238:
  br label %b43
b41:
  br label %b49
b42:
  br label %b48
b43:
  %v347 = add i64 0, 0
  %v348 = add i64 0, 0
  %v349.p = getelementptr i64, ptr %v313, i64 1
  %v349 = load i64, ptr %v349.p
  %v350.c = icmp uge i64 %v348, %v349
  %v350 = zext i1 %v350.c to i64
  %c.b43 = icmp ne i64 %v350, 0
  br i1 %c.b43, label %b43.t239, label %b43.e240
b43.t239:
  br label %b44
b43.e240:
  br label %b45
b44:
  %v351 = add i64 0, 3
  call void @"rt.panic"(i64 %v351)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b45:
  %v352.p = getelementptr i64, ptr %v313, i64 0
  %v352 = load i64, ptr %v352.p
  %v353 = inttoptr i64 %v352 to ptr
  %v354 = getelementptr i8, ptr %v353, i64 %v348
  %v355.p = getelementptr i8, ptr %v354, i64 0
  %v355.b = load i8, ptr %v355.p
  %v355 = zext i8 %v355.b to i64
  %v356 = add i64 0, 1
  %v357.p = getelementptr i64, ptr %v313, i64 1
  %v357 = load i64, ptr %v357.p
  %v358.c = icmp uge i64 %v356, %v357
  %v358 = zext i1 %v358.c to i64
  %c.b45 = icmp ne i64 %v358, 0
  br i1 %c.b45, label %b45.t241, label %b45.e242
b45.t241:
  br label %b46
b45.e242:
  br label %b47
b46:
  %v359 = add i64 0, 4
  call void @"rt.panic"(i64 %v359)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v360.p = getelementptr i64, ptr %v313, i64 0
  %v360 = load i64, ptr %v360.p
  %v361 = inttoptr i64 %v360 to ptr
  %v362 = getelementptr i8, ptr %v361, i64 %v356
  %v363.p = getelementptr i8, ptr %v362, i64 0
  %v363.b = load i8, ptr %v363.p
  %v363 = zext i8 %v363.b to i64
  %v364 = add i64 0, 256
  %v365 = mul i64 %v363, %v364
  %v366 = add i64 %v355, %v365
  %v367 = sub i64 %v347, %v366
  br label %b48
b48:
  %v368 = phi i64 [ %v344, %b42 ], [ %v367, %b47 ]
  %st242 = getelementptr i64, ptr %v261, i64 0
  store i64 %v368, ptr %st242
  br label %b49
b49:
  br label %b50
b50:
  %v369.p = getelementptr i64, ptr %v261, i64 0
  %v369 = load i64, ptr %v369.p
  %v370 = add i64 0, 0
  %v371.c = icmp slt i64 %v369, %v370
  %v371 = zext i1 %v371.c to i64
  %c.b50 = icmp ne i64 %v371, 0
  br i1 %c.b50, label %b50.t244, label %b50.e245
b50.t244:
  br label %b51
b50.e245:
  br label %b52
b51:
  %v372 = add i64 0, 3
  %v373 = add i64 0, 0
  %v374 = add i64 0, 0
  %v375 = add i64 0, 0
  %v376 = add i64 0, 0
  %v377 = add i64 0, 0
  %v378 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v372, i64 %v229, i64 %v373, i64 %v374, i64 %v375, i64 %v376, i64 %v377)
  %v379 = getelementptr i64, ptr %s27, i64 0
  %v380 = add i64 0, 0
  %v381.p = getelementptr i64, ptr %v261, i64 0
  %v381 = load i64, ptr %v381.p
  %v382 = sub i64 %v380, %v381
  %v383 = getelementptr i64, ptr @"rt.meta", i64 0
  %st245 = getelementptr i64, ptr %v383, i64 2571
  store i64 %v156, ptr %st245
  call void @"std/net.errOf"(ptr %v379, i64 %v382)
  %v384 = getelementptr i64, ptr %s18, i64 0
  %v385 = add i64 0, 1
  %st246 = getelementptr i64, ptr %v384, i64 0
  store i64 %v385, ptr %st246
  %v386.p = getelementptr i64, ptr %v379, i64 0
  %v386 = load i64, ptr %v386.p
  %st247 = getelementptr i64, ptr %v384, i64 1
  store i64 %v386, ptr %st247
  %v387.p = getelementptr i64, ptr %v379, i64 1
  %v387 = load i64, ptr %v387.p
  %st248 = getelementptr i64, ptr %v384, i64 2
  store i64 %v387, ptr %st248
  %v388.p = getelementptr i64, ptr %v379, i64 2
  %v388 = load i64, ptr %v388.p
  %st249 = getelementptr i64, ptr %v384, i64 3
  store i64 %v388, ptr %st249
  %v389.p = getelementptr i64, ptr %v379, i64 3
  %v389 = load i64, ptr %v389.p
  %st250 = getelementptr i64, ptr %v384, i64 4
  store i64 %v389, ptr %st250
  %v390.p = getelementptr i64, ptr %v379, i64 4
  %v390 = load i64, ptr %v390.p
  %st251 = getelementptr i64, ptr %v384, i64 5
  store i64 %v390, ptr %st251
  %v391.p = getelementptr i64, ptr %v384, i64 0
  %v391 = load i64, ptr %v391.p
  %st252 = getelementptr i64, ptr %v155, i64 0
  store i64 %v391, ptr %st252
  %v392.p = getelementptr i64, ptr %v384, i64 1
  %v392 = load i64, ptr %v392.p
  %st253 = getelementptr i64, ptr %v155, i64 1
  store i64 %v392, ptr %st253
  %v393.p = getelementptr i64, ptr %v384, i64 2
  %v393 = load i64, ptr %v393.p
  %st254 = getelementptr i64, ptr %v155, i64 2
  store i64 %v393, ptr %st254
  %v394.p = getelementptr i64, ptr %v384, i64 3
  %v394 = load i64, ptr %v394.p
  %st255 = getelementptr i64, ptr %v155, i64 3
  store i64 %v394, ptr %st255
  %v395.p = getelementptr i64, ptr %v384, i64 4
  %v395 = load i64, ptr %v395.p
  %st256 = getelementptr i64, ptr %v155, i64 4
  store i64 %v395, ptr %st256
  %v396.p = getelementptr i64, ptr %v384, i64 5
  %v396 = load i64, ptr %v396.p
  %st257 = getelementptr i64, ptr %v155, i64 5
  store i64 %v396, ptr %st257
  %v397.p = getelementptr i64, ptr %v155, i64 0
  %v397 = load i64, ptr %v397.p
  %v398 = add i64 0, 0
  %v399.c = icmp ne i64 %v397, %v398
  %v399 = zext i1 %v399.c to i64
  %c.b51 = icmp ne i64 %v399, 0
  br i1 %c.b51, label %b51.t259, label %b51.e260
b51.t259:
  br label %b53
b51.e260:
  br label %b54
b52:
  br label %b55
b53:
  %v400 = add i64 0, 1
  %v401 = getelementptr i64, ptr %v155, i64 %v400
  call void @"rt.err_relocate"(ptr %v401, i64 %v156)
  br label %b54
b54:
  %v750 = getelementptr i64, ptr @"rt.meta", i64 0
  %st260 = getelementptr i64, ptr %v750, i64 0
  store i64 %v156, ptr %st260
  br label %b20
b55:
  %v402 = getelementptr i64, ptr %s28, i64 0
  %v751 = getelementptr i64, ptr @"rt.meta", i64 0
  %v403.p = getelementptr i64, ptr %v751, i64 0
  %v403 = load i64, ptr %v403.p
  %v404 = getelementptr i64, ptr %s29, i64 0
  %v405 = add i64 0, 0
  %v406 = getelementptr i64, ptr %s30, i64 0
  %v407 = getelementptr i64, ptr %s31, i64 0
  %v408 = add i64 0, 0
  %st261 = getelementptr i64, ptr %v407, i64 0
  store i64 %v408, ptr %st261
  %st262 = getelementptr i64, ptr %v407, i64 0
  store i64 %v229, ptr %st262
  %v409 = getelementptr i64, ptr %s32, i64 0
  %v410.p = getelementptr i64, ptr %v407, i64 0
  %v410 = load i64, ptr %v410.p
  %st263 = getelementptr i64, ptr %v409, i64 0
  store i64 %v410, ptr %st263
  %v752 = getelementptr i64, ptr @"rt.meta", i64 0
  %v411.p = getelementptr i64, ptr %v752, i64 0
  %v411 = load i64, ptr %v411.p
  %v412 = getelementptr i64, ptr %s33, i64 0
  %v413.p = getelementptr i64, ptr %v409, i64 0
  %v413 = load i64, ptr %v413.p
  %v414 = getelementptr i64, ptr @"str.8", i64 0
  %v415 = add i64 0, 6
  %v416 = add i64 0, 0
  %v417 = getelementptr i64, ptr %s26, i64 0
  %v418 = ptrtoint ptr %v414 to i64
  %st264 = getelementptr i64, ptr %v417, i64 0
  store i64 %v418, ptr %st264
  %st265 = getelementptr i64, ptr %v417, i64 1
  store i64 %v415, ptr %st265
  %st266 = getelementptr i64, ptr %v417, i64 2
  store i64 %v416, ptr %st266
  %v419.p = getelementptr i64, ptr %v417, i64 0
  %v419 = load i64, ptr %v419.p
  %v420.p = getelementptr i64, ptr %v417, i64 1
  %v420 = load i64, ptr %v420.p
  %v421.p = getelementptr i64, ptr %v417, i64 2
  %v421 = load i64, ptr %v421.p
  call void @"std/net.Send"(ptr %v412, i64 %v413, i64 %v419, i64 %v420, i64 %v421)
  %v422.p = getelementptr i64, ptr %v412, i64 0
  %v422 = load i64, ptr %v422.p
  %v423 = add i64 0, 0
  %v424.c = icmp ne i64 %v422, %v423
  %v424 = zext i1 %v424.c to i64
  %c.b55 = icmp ne i64 %v424, 0
  br i1 %c.b55, label %b55.t268, label %b55.e269
b55.t268:
  br label %b58
b55.e269:
  br label %b59
b56:
  %v653 = getelementptr i64, ptr %s35, i64 0
  %v654 = add i64 0, 0
  %st269 = getelementptr i64, ptr %v653, i64 0
  store i64 %v654, ptr %st269
  %v655.p = getelementptr i64, ptr %v653, i64 0
  %v655 = load i64, ptr %v655.p
  %st270 = getelementptr i64, ptr %v155, i64 0
  store i64 %v655, ptr %st270
  %v656.p = getelementptr i64, ptr %v653, i64 1
  %v656 = load i64, ptr %v656.p
  %st271 = getelementptr i64, ptr %v155, i64 1
  store i64 %v656, ptr %st271
  %v657.p = getelementptr i64, ptr %v653, i64 2
  %v657 = load i64, ptr %v657.p
  %st272 = getelementptr i64, ptr %v155, i64 2
  store i64 %v657, ptr %st272
  %v658.p = getelementptr i64, ptr %v653, i64 3
  %v658 = load i64, ptr %v658.p
  %st273 = getelementptr i64, ptr %v155, i64 3
  store i64 %v658, ptr %st273
  %v659.p = getelementptr i64, ptr %v653, i64 4
  %v659 = load i64, ptr %v659.p
  %st274 = getelementptr i64, ptr %v155, i64 4
  store i64 %v659, ptr %st274
  %v660.p = getelementptr i64, ptr %v653, i64 5
  %v660 = load i64, ptr %v660.p
  %st275 = getelementptr i64, ptr %v155, i64 5
  store i64 %v660, ptr %st275
  %v661.p = getelementptr i64, ptr %v155, i64 0
  %v661 = load i64, ptr %v661.p
  %v662 = add i64 0, 0
  %v663.c = icmp ne i64 %v661, %v662
  %v663 = zext i1 %v663.c to i64
  %c.b56 = icmp ne i64 %v663, 0
  br i1 %c.b56, label %b56.t277, label %b56.e278
b56.t277:
  br label %b93
b56.e278:
  br label %b94
b57:
  %v753 = getelementptr i64, ptr @"rt.meta", i64 0
  %st278 = getelementptr i64, ptr %v753, i64 0
  store i64 %v411, ptr %st278
  call void @"std/net.closeFd"(i64 %v229)
  br label %b56
b58:
  %v425 = add i64 0, 0
  %st279 = getelementptr i64, ptr %v0, i64 0
  store i64 %v425, ptr %st279
  %st280 = getelementptr i64, ptr %v0, i64 1
  store i64 %v425, ptr %st280
  %st281 = getelementptr i64, ptr %v0, i64 2
  store i64 %v425, ptr %st281
  %v754 = getelementptr i64, ptr @"rt.meta", i64 0
  %v426.p = getelementptr i64, ptr %v754, i64 0
  %v426 = load i64, ptr %v426.p
  %v755 = getelementptr i64, ptr @"rt.meta", i64 0
  %v756 = getelementptr i64, ptr %v755, i64 %v426
  %v427.p = getelementptr i64, ptr %v756, i64 1
  %v427 = load ptr, ptr %v427.p
  %v428 = ptrtoint ptr %v427 to i64
  %st282 = getelementptr i64, ptr %v0, i64 0
  store i64 %v428, ptr %st282
  %v429 = add i64 0, 0
  %st283 = getelementptr i64, ptr %v0, i64 1
  store i64 %v429, ptr %st283
  %st284 = getelementptr i64, ptr %v0, i64 2
  store i64 %v426, ptr %st284
  %v430.p = getelementptr i64, ptr %v412, i64 0
  %v430 = load i64, ptr %v430.p
  %st285 = getelementptr i64, ptr %v0, i64 3
  store i64 %v430, ptr %st285
  %v431.p = getelementptr i64, ptr %v412, i64 1
  %v431 = load i64, ptr %v431.p
  %st286 = getelementptr i64, ptr %v0, i64 4
  store i64 %v431, ptr %st286
  %v432.p = getelementptr i64, ptr %v412, i64 2
  %v432 = load i64, ptr %v432.p
  %st287 = getelementptr i64, ptr %v0, i64 5
  store i64 %v432, ptr %st287
  %v433.p = getelementptr i64, ptr %v412, i64 3
  %v433 = load i64, ptr %v433.p
  %st288 = getelementptr i64, ptr %v0, i64 6
  store i64 %v433, ptr %st288
  %v434.p = getelementptr i64, ptr %v412, i64 4
  %v434 = load i64, ptr %v434.p
  %st289 = getelementptr i64, ptr %v0, i64 7
  store i64 %v434, ptr %st289
  %v435.p = getelementptr i64, ptr %v412, i64 5
  %v435 = load i64, ptr %v435.p
  %st290 = getelementptr i64, ptr %v0, i64 8
  store i64 %v435, ptr %st290
  call void @"std/net.closeFd"(i64 %v229)
  call void @"std/net.closeFd"(i64 %v90)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v436.p = getelementptr i64, ptr %v0, i64 3
  %v436 = load i64, ptr %v436.p
  %v437 = add i64 0, 0
  %v438.c = icmp ne i64 %v436, %v437
  %v438 = zext i1 %v438.c to i64
  %c.b58 = icmp ne i64 %v438, 0
  br i1 %c.b58, label %b58.t292, label %b58.e293
b58.t292:
  br label %b60
b58.e293:
  br label %b61
b59:
  %v757 = getelementptr i64, ptr @"rt.meta", i64 0
  %v441.p = getelementptr i64, ptr %v757, i64 0
  %v441 = load i64, ptr %v441.p
  %v442 = getelementptr i64, ptr %s34, i64 0
  %v443.p = getelementptr i64, ptr %v120, i64 0
  %v443 = load i64, ptr %v443.p
  %st293 = getelementptr i64, ptr %v442, i64 0
  store i64 %v443, ptr %st293
  %v444 = getelementptr i64, ptr %s18, i64 0
  %v758 = getelementptr i64, ptr @"rt.meta", i64 0
  %v445.p = getelementptr i64, ptr %v758, i64 0
  %v445 = load i64, ptr %v445.p
  %v759 = getelementptr i64, ptr @"rt.meta", i64 0
  %v446.p = getelementptr i64, ptr %v759, i64 0
  %v446 = load i64, ptr %v446.p
  br label %b64
b60:
  %v439 = add i64 0, 4
  %v440 = getelementptr i64, ptr %v0, i64 %v439
  call void @"rt.err_relocate"(ptr %v440, i64 %v1)
  br label %b61
b61:
  %v760 = getelementptr i64, ptr @"rt.meta", i64 0
  %st294 = getelementptr i64, ptr %v760, i64 0
  store i64 %v1, ptr %st294
  ret void
b62:
  %v761 = getelementptr i64, ptr @"rt.meta", i64 0
  %st295 = getelementptr i64, ptr %v761, i64 0
  store i64 %v441, ptr %st295
  %v573 = getelementptr i64, ptr %s43, i64 0
  %v574 = getelementptr i64, ptr %s44, i64 0
  %v575.p = getelementptr i64, ptr %v409, i64 0
  %v575 = load i64, ptr %v575.p
  call void @"main.drain"(ptr %v574, i64 %v575)
  %v576.p = getelementptr i64, ptr %v574, i64 0
  %v576 = load i64, ptr %v576.p
  %v577.p = getelementptr i64, ptr %v574, i64 1
  %v577 = load i64, ptr %v577.p
  %v578.p = getelementptr i64, ptr %v574, i64 2
  %v578 = load i64, ptr %v578.p
  %v579.p = getelementptr i64, ptr %v574, i64 3
  %v579 = load i64, ptr %v579.p
  %v580.p = getelementptr i64, ptr %v574, i64 4
  %v580 = load i64, ptr %v580.p
  %v581.p = getelementptr i64, ptr %v574, i64 5
  %v581 = load i64, ptr %v581.p
  call void @"main.show"(ptr %v573, i64 %v576, i64 %v577, i64 %v578, i64 %v579, i64 %v580, i64 %v581)
  %v582 = getelementptr i64, ptr %s26, i64 0
  %v583.p = getelementptr i64, ptr %v573, i64 0
  %v583 = load i64, ptr %v583.p
  %st296 = getelementptr i64, ptr %v582, i64 0
  store i64 %v583, ptr %st296
  %v584.p = getelementptr i64, ptr %v573, i64 1
  %v584 = load i64, ptr %v584.p
  %st297 = getelementptr i64, ptr %v582, i64 1
  store i64 %v584, ptr %st297
  %v585.p = getelementptr i64, ptr %v573, i64 2
  %v585 = load i64, ptr %v585.p
  %st298 = getelementptr i64, ptr %v582, i64 2
  store i64 %v585, ptr %st298
  %v586 = getelementptr i64, ptr %s45, i64 0
  %v587 = getelementptr i64, ptr %s46, i64 0
  %v588.p = getelementptr i64, ptr %v409, i64 0
  %v588 = load i64, ptr %v588.p
  %v589 = getelementptr i64, ptr @"str.4", i64 0
  %v590 = add i64 0, 4
  %v591 = add i64 0, 0
  %v592 = getelementptr i64, ptr %s25, i64 0
  %v593 = ptrtoint ptr %v589 to i64
  %st299 = getelementptr i64, ptr %v592, i64 0
  store i64 %v593, ptr %st299
  %st300 = getelementptr i64, ptr %v592, i64 1
  store i64 %v590, ptr %st300
  %st301 = getelementptr i64, ptr %v592, i64 2
  store i64 %v591, ptr %st301
  %v594.p = getelementptr i64, ptr %v592, i64 0
  %v594 = load i64, ptr %v594.p
  %v595.p = getelementptr i64, ptr %v592, i64 1
  %v595 = load i64, ptr %v595.p
  %v596.p = getelementptr i64, ptr %v592, i64 2
  %v596 = load i64, ptr %v596.p
  call void @"std/net.Send"(ptr %v587, i64 %v588, i64 %v594, i64 %v595, i64 %v596)
  %v597.p = getelementptr i64, ptr %v587, i64 0
  %v597 = load i64, ptr %v597.p
  %v598.p = getelementptr i64, ptr %v587, i64 1
  %v598 = load i64, ptr %v598.p
  %v599.p = getelementptr i64, ptr %v587, i64 2
  %v599 = load i64, ptr %v599.p
  %v600.p = getelementptr i64, ptr %v587, i64 3
  %v600 = load i64, ptr %v600.p
  %v601.p = getelementptr i64, ptr %v587, i64 4
  %v601 = load i64, ptr %v601.p
  %v602.p = getelementptr i64, ptr %v587, i64 5
  %v602 = load i64, ptr %v602.p
  call void @"main.show"(ptr %v586, i64 %v597, i64 %v598, i64 %v599, i64 %v600, i64 %v601, i64 %v602)
  %v603 = getelementptr i64, ptr %s24, i64 0
  %v604.p = getelementptr i64, ptr %v586, i64 0
  %v604 = load i64, ptr %v604.p
  %st302 = getelementptr i64, ptr %v603, i64 0
  store i64 %v604, ptr %st302
  %v605.p = getelementptr i64, ptr %v586, i64 1
  %v605 = load i64, ptr %v605.p
  %st303 = getelementptr i64, ptr %v603, i64 1
  store i64 %v605, ptr %st303
  %v606.p = getelementptr i64, ptr %v586, i64 2
  %v606 = load i64, ptr %v606.p
  %st304 = getelementptr i64, ptr %v603, i64 2
  store i64 %v606, ptr %st304
  %v607 = getelementptr i64, ptr @"str.6", i64 0
  %v608 = add i64 0, 6
  %v609 = add i64 0, 0
  %v610 = getelementptr i64, ptr %s47, i64 0
  %v611 = ptrtoint ptr %v607 to i64
  %st305 = getelementptr i64, ptr %v610, i64 0
  store i64 %v611, ptr %st305
  %st306 = getelementptr i64, ptr %v610, i64 1
  store i64 %v608, ptr %st306
  %st307 = getelementptr i64, ptr %v610, i64 2
  store i64 %v609, ptr %st307
  %v612 = getelementptr i64, ptr @"str.13", i64 0
  %v613 = add i64 0, 8
  %v614 = add i64 0, 0
  %v615 = getelementptr i64, ptr %s48, i64 0
  %v616 = ptrtoint ptr %v612 to i64
  %st308 = getelementptr i64, ptr %v615, i64 0
  store i64 %v616, ptr %st308
  %st309 = getelementptr i64, ptr %v615, i64 1
  store i64 %v613, ptr %st309
  %st310 = getelementptr i64, ptr %v615, i64 2
  store i64 %v614, ptr %st310
  %v617 = add i64 0, 0
  %v618.p = getelementptr i64, ptr %v610, i64 1
  %v618 = load i64, ptr %v618.p
  %v619 = add i64 %v617, %v618
  %v620.p = getelementptr i64, ptr %v582, i64 1
  %v620 = load i64, ptr %v620.p
  %v621 = add i64 %v619, %v620
  %v622.p = getelementptr i64, ptr %v615, i64 1
  %v622 = load i64, ptr %v622.p
  %v623 = add i64 %v621, %v622
  %v624.p = getelementptr i64, ptr %v603, i64 1
  %v624 = load i64, ptr %v624.p
  %v625 = add i64 %v623, %v624
  %v762 = getelementptr i64, ptr @"rt.meta", i64 0
  %v626.p = getelementptr i64, ptr %v762, i64 0
  %v626 = load i64, ptr %v626.p
  %v627.p = getelementptr i64, ptr %v610, i64 1
  %v627 = load i64, ptr %v627.p
  %v628 = sub i64 %v625, %v627
  %v629.p = getelementptr i64, ptr %v610, i64 0
  %v629 = load i64, ptr %v629.p
  %v630.p = getelementptr i64, ptr %v610, i64 1
  %v630 = load i64, ptr %v630.p
  %v631.p = getelementptr i64, ptr %v610, i64 2
  %v631 = load i64, ptr %v631.p
  %v632 = call ptr @"rt.cat8"(i64 %v629, i64 %v630, i64 %v631, i64 %v626, i64 %v628)
  %v633.p = getelementptr i64, ptr %v582, i64 1
  %v633 = load i64, ptr %v633.p
  %v634 = getelementptr i8, ptr %v632, i64 %v627
  %v635.p = getelementptr i64, ptr %v582, i64 0
  %v635 = load i64, ptr %v635.p
  %v636 = inttoptr i64 %v635 to ptr
  call void @"rt.copy8"(ptr %v634, ptr %v636, i64 %v633)
  %v637 = add i64 %v627, %v633
  %v638.p = getelementptr i64, ptr %v615, i64 1
  %v638 = load i64, ptr %v638.p
  %v639 = getelementptr i8, ptr %v632, i64 %v637
  %v640.p = getelementptr i64, ptr %v615, i64 0
  %v640 = load i64, ptr %v640.p
  %v641 = inttoptr i64 %v640 to ptr
  call void @"rt.copy8"(ptr %v639, ptr %v641, i64 %v638)
  %v642 = add i64 %v637, %v638
  %v643.p = getelementptr i64, ptr %v603, i64 1
  %v643 = load i64, ptr %v643.p
  %v644 = getelementptr i8, ptr %v632, i64 %v642
  %v645.p = getelementptr i64, ptr %v603, i64 0
  %v645 = load i64, ptr %v645.p
  %v646 = inttoptr i64 %v645 to ptr
  call void @"rt.copy8"(ptr %v644, ptr %v646, i64 %v643)
  %v647 = add i64 %v642, %v643
  %v648 = getelementptr i64, ptr %s49, i64 0
  %v649 = ptrtoint ptr %v632 to i64
  %st311 = getelementptr i64, ptr %v648, i64 0
  store i64 %v649, ptr %st311
  %st312 = getelementptr i64, ptr %v648, i64 1
  store i64 %v625, ptr %st312
  %st313 = getelementptr i64, ptr %v648, i64 2
  store i64 %v626, ptr %st313
  %v650.p = getelementptr i64, ptr %v648, i64 0
  %v650 = load i64, ptr %v650.p
  %st314 = getelementptr i64, ptr %v7, i64 0
  store i64 %v650, ptr %st314
  %v651.p = getelementptr i64, ptr %v648, i64 1
  %v651 = load i64, ptr %v651.p
  %st315 = getelementptr i64, ptr %v7, i64 1
  store i64 %v651, ptr %st315
  %v652.p = getelementptr i64, ptr %v648, i64 2
  %v652 = load i64, ptr %v652.p
  %st316 = getelementptr i64, ptr %v7, i64 2
  store i64 %v652, ptr %st316
  br label %b57
b63:
  %v554.p = getelementptr i64, ptr %v444, i64 0
  %v554 = load i64, ptr %v554.p
  %v555 = add i64 0, 0
  %v556.c = icmp ne i64 %v554, %v555
  %v556 = zext i1 %v556.c to i64
  %c.b63 = icmp ne i64 %v556, 0
  br i1 %c.b63, label %b63.t318, label %b63.e319
b63.t318:
  br label %b89
b63.e319:
  br label %b90
b64:
  %v763 = getelementptr i64, ptr @"rt.meta", i64 0
  %st319 = getelementptr i64, ptr %v763, i64 0
  store i64 %v446, ptr %st319
  %v447 = add i64 0, 1
  %c.b64 = icmp ne i64 %v447, 0
  br i1 %c.b64, label %b64.t321, label %b64.e322
b64.t321:
  br label %b65
b64.e322:
  br label %b66
b65:
  call void @"rt.region_enter"()
  %v764 = getelementptr i64, ptr @"rt.meta", i64 0
  %v448.p = getelementptr i64, ptr %v764, i64 0
  %v448 = load i64, ptr %v448.p
  %v449 = add i64 0, 0
  %v450 = add i64 0, 0
  %v451.c = icmp ne i64 %v449, %v450
  %v451 = zext i1 %v451.c to i64
  %c.b65 = icmp ne i64 %v451, 0
  br i1 %c.b65, label %b65.t323, label %b65.e324
b65.t323:
  br label %b67
b65.e324:
  br label %b68
b66:
  %v765 = getelementptr i64, ptr @"rt.meta", i64 0
  %st324 = getelementptr i64, ptr %v765, i64 0
  store i64 %v446, ptr %st324
  %v541 = getelementptr i64, ptr %s35, i64 0
  %v542 = add i64 0, 0
  %st325 = getelementptr i64, ptr %v541, i64 0
  store i64 %v542, ptr %st325
  %v543.p = getelementptr i64, ptr %v541, i64 0
  %v543 = load i64, ptr %v543.p
  %st326 = getelementptr i64, ptr %v444, i64 0
  store i64 %v543, ptr %st326
  %v544.p = getelementptr i64, ptr %v541, i64 1
  %v544 = load i64, ptr %v544.p
  %st327 = getelementptr i64, ptr %v444, i64 1
  store i64 %v544, ptr %st327
  %v545.p = getelementptr i64, ptr %v541, i64 2
  %v545 = load i64, ptr %v545.p
  %st328 = getelementptr i64, ptr %v444, i64 2
  store i64 %v545, ptr %st328
  %v546.p = getelementptr i64, ptr %v541, i64 3
  %v546 = load i64, ptr %v546.p
  %st329 = getelementptr i64, ptr %v444, i64 3
  store i64 %v546, ptr %st329
  %v547.p = getelementptr i64, ptr %v541, i64 4
  %v547 = load i64, ptr %v547.p
  %st330 = getelementptr i64, ptr %v444, i64 4
  store i64 %v547, ptr %st330
  %v548.p = getelementptr i64, ptr %v541, i64 5
  %v548 = load i64, ptr %v548.p
  %st331 = getelementptr i64, ptr %v444, i64 5
  store i64 %v548, ptr %st331
  %v549.p = getelementptr i64, ptr %v444, i64 0
  %v549 = load i64, ptr %v549.p
  %v550 = add i64 0, 0
  %v551.c = icmp ne i64 %v549, %v550
  %v551 = zext i1 %v551.c to i64
  %c.b66 = icmp ne i64 %v551, 0
  br i1 %c.b66, label %b66.t333, label %b66.e334
b66.t333:
  br label %b87
b66.e334:
  br label %b88
b67:
  %v452 = getelementptr i64, ptr %s4, i64 0
  %v453 = add i64 0, 0
  %st334 = getelementptr i64, ptr %v452, i64 0
  store i64 %v453, ptr %st334
  %st335 = getelementptr i64, ptr %v452, i64 1
  store i64 %v453, ptr %st335
  %v454 = add i64 0, 3
  %st336 = getelementptr i64, ptr %v452, i64 0
  store i64 %v454, ptr %st336
  %v455 = getelementptr i64, ptr %s5, i64 0
  %v456.p = getelementptr i64, ptr %v452, i64 0
  %v456 = load i64, ptr %v456.p
  %st337 = getelementptr i64, ptr %v455, i64 0
  store i64 %v456, ptr %st337
  %v457.p = getelementptr i64, ptr %v452, i64 1
  %v457 = load i64, ptr %v457.p
  %st338 = getelementptr i64, ptr %v455, i64 1
  store i64 %v457, ptr %st338
  %v458 = add i64 0, 0
  %st339 = getelementptr i64, ptr %v455, i64 2
  store i64 %v458, ptr %st339
  %st340 = getelementptr i64, ptr %v455, i64 3
  store i64 %v458, ptr %st340
  %st341 = getelementptr i64, ptr %v455, i64 4
  store i64 %v458, ptr %st341
  %v459 = getelementptr i64, ptr %s35, i64 0
  %v460 = add i64 0, 1
  %st342 = getelementptr i64, ptr %v459, i64 0
  store i64 %v460, ptr %st342
  %v461.p = getelementptr i64, ptr %v455, i64 0
  %v461 = load i64, ptr %v461.p
  %st343 = getelementptr i64, ptr %v459, i64 1
  store i64 %v461, ptr %st343
  %v462.p = getelementptr i64, ptr %v455, i64 1
  %v462 = load i64, ptr %v462.p
  %st344 = getelementptr i64, ptr %v459, i64 2
  store i64 %v462, ptr %st344
  %v463.p = getelementptr i64, ptr %v455, i64 2
  %v463 = load i64, ptr %v463.p
  %st345 = getelementptr i64, ptr %v459, i64 3
  store i64 %v463, ptr %st345
  %v464.p = getelementptr i64, ptr %v455, i64 3
  %v464 = load i64, ptr %v464.p
  %st346 = getelementptr i64, ptr %v459, i64 4
  store i64 %v464, ptr %st346
  %v465.p = getelementptr i64, ptr %v455, i64 4
  %v465 = load i64, ptr %v465.p
  %st347 = getelementptr i64, ptr %v459, i64 5
  store i64 %v465, ptr %st347
  %v466.p = getelementptr i64, ptr %v459, i64 0
  %v466 = load i64, ptr %v466.p
  %st348 = getelementptr i64, ptr %v444, i64 0
  store i64 %v466, ptr %st348
  %v467.p = getelementptr i64, ptr %v459, i64 1
  %v467 = load i64, ptr %v467.p
  %st349 = getelementptr i64, ptr %v444, i64 1
  store i64 %v467, ptr %st349
  %v468.p = getelementptr i64, ptr %v459, i64 2
  %v468 = load i64, ptr %v468.p
  %st350 = getelementptr i64, ptr %v444, i64 2
  store i64 %v468, ptr %st350
  %v469.p = getelementptr i64, ptr %v459, i64 3
  %v469 = load i64, ptr %v469.p
  %st351 = getelementptr i64, ptr %v444, i64 3
  store i64 %v469, ptr %st351
  %v470.p = getelementptr i64, ptr %v459, i64 4
  %v470 = load i64, ptr %v470.p
  %st352 = getelementptr i64, ptr %v444, i64 4
  store i64 %v470, ptr %st352
  %v471.p = getelementptr i64, ptr %v459, i64 5
  %v471 = load i64, ptr %v471.p
  %st353 = getelementptr i64, ptr %v444, i64 5
  store i64 %v471, ptr %st353
  %v472.p = getelementptr i64, ptr %v444, i64 0
  %v472 = load i64, ptr %v472.p
  %v473 = add i64 0, 0
  %v474.c = icmp ne i64 %v472, %v473
  %v474 = zext i1 %v474.c to i64
  %c.b67 = icmp ne i64 %v474, 0
  br i1 %c.b67, label %b67.t355, label %b67.e356
b67.t355:
  br label %b69
b67.e356:
  br label %b70
b68:
  br label %b71
b69:
  %v475 = add i64 0, 1
  %v476 = getelementptr i64, ptr %v444, i64 %v475
  call void @"rt.err_relocate"(ptr %v476, i64 %v445)
  br label %b70
b70:
  %v766 = getelementptr i64, ptr @"rt.meta", i64 0
  %st356 = getelementptr i64, ptr %v766, i64 0
  store i64 %v445, ptr %st356
  br label %b63
b71:
  %v477 = add i64 0, 3
  %v478.p = getelementptr i64, ptr %v442, i64 0
  %v478 = load i64, ptr %v478.p
  %v479 = add i64 0, 0
  %v480 = add i64 0, 0
  %v481 = call i64 @"rt.netop"(i64 %v477, i64 %v478, i64 %v479, i64 %v480)
  %v482.p = getelementptr i64, ptr %v442, i64 0
  %v482 = load i64, ptr %v482.p
  %v483 = add i64 0, 1
  %v484 = call i64 @"std/net.again"(i64 %v481, i64 %v482, i64 %v483)
  %v485 = add i64 0, 0
  %v486.c = icmp slt i64 %v484, %v485
  %v486 = zext i1 %v486.c to i64
  %c.b71 = icmp ne i64 %v486, 0
  br i1 %c.b71, label %b71.t358, label %b71.e359
b71.t358:
  br label %b72
b71.e359:
  br label %b73
b72:
  %v487 = getelementptr i64, ptr %s36, i64 0
  call void @"std/net.waitErr"(ptr %v487, i64 %v484)
  %v488 = getelementptr i64, ptr %s35, i64 0
  %v489 = add i64 0, 1
  %st359 = getelementptr i64, ptr %v488, i64 0
  store i64 %v489, ptr %st359
  %v490.p = getelementptr i64, ptr %v487, i64 0
  %v490 = load i64, ptr %v490.p
  %st360 = getelementptr i64, ptr %v488, i64 1
  store i64 %v490, ptr %st360
  %v491.p = getelementptr i64, ptr %v487, i64 1
  %v491 = load i64, ptr %v491.p
  %st361 = getelementptr i64, ptr %v488, i64 2
  store i64 %v491, ptr %st361
  %v492.p = getelementptr i64, ptr %v487, i64 2
  %v492 = load i64, ptr %v492.p
  %st362 = getelementptr i64, ptr %v488, i64 3
  store i64 %v492, ptr %st362
  %v493.p = getelementptr i64, ptr %v487, i64 3
  %v493 = load i64, ptr %v493.p
  %st363 = getelementptr i64, ptr %v488, i64 4
  store i64 %v493, ptr %st363
  %v494.p = getelementptr i64, ptr %v487, i64 4
  %v494 = load i64, ptr %v494.p
  %st364 = getelementptr i64, ptr %v488, i64 5
  store i64 %v494, ptr %st364
  %v495.p = getelementptr i64, ptr %v488, i64 0
  %v495 = load i64, ptr %v495.p
  %st365 = getelementptr i64, ptr %v444, i64 0
  store i64 %v495, ptr %st365
  %v496.p = getelementptr i64, ptr %v488, i64 1
  %v496 = load i64, ptr %v496.p
  %st366 = getelementptr i64, ptr %v444, i64 1
  store i64 %v496, ptr %st366
  %v497.p = getelementptr i64, ptr %v488, i64 2
  %v497 = load i64, ptr %v497.p
  %st367 = getelementptr i64, ptr %v444, i64 2
  store i64 %v497, ptr %st367
  %v498.p = getelementptr i64, ptr %v488, i64 3
  %v498 = load i64, ptr %v498.p
  %st368 = getelementptr i64, ptr %v444, i64 3
  store i64 %v498, ptr %st368
  %v499.p = getelementptr i64, ptr %v488, i64 4
  %v499 = load i64, ptr %v499.p
  %st369 = getelementptr i64, ptr %v444, i64 4
  store i64 %v499, ptr %st369
  %v500.p = getelementptr i64, ptr %v488, i64 5
  %v500 = load i64, ptr %v500.p
  %st370 = getelementptr i64, ptr %v444, i64 5
  store i64 %v500, ptr %st370
  %v501.p = getelementptr i64, ptr %v444, i64 0
  %v501 = load i64, ptr %v501.p
  %v502 = add i64 0, 0
  %v503.c = icmp ne i64 %v501, %v502
  %v503 = zext i1 %v503.c to i64
  %c.b72 = icmp ne i64 %v503, 0
  br i1 %c.b72, label %b72.t372, label %b72.e373
b72.t372:
  br label %b74
b72.e373:
  br label %b75
b73:
  br label %b76
b74:
  %v504 = add i64 0, 1
  %v505 = getelementptr i64, ptr %v444, i64 %v504
  call void @"rt.err_relocate"(ptr %v505, i64 %v445)
  br label %b75
b75:
  %v767 = getelementptr i64, ptr @"rt.meta", i64 0
  %st373 = getelementptr i64, ptr %v767, i64 0
  store i64 %v445, ptr %st373
  br label %b63
b76:
  %v506 = add i64 0, 1
  %v507.c = icmp eq i64 %v484, %v506
  %v507 = zext i1 %v507.c to i64
  %c.b76 = icmp ne i64 %v507, 0
  br i1 %c.b76, label %b76.t375, label %b76.e376
b76.t375:
  br label %b77
b76.e376:
  br label %b78
b77:
  %v508 = add i64 0, 0
  %v509.c = icmp slt i64 %v481, %v508
  %v509 = zext i1 %v509.c to i64
  %c.b77 = icmp ne i64 %v509, 0
  br i1 %c.b77, label %b77.t377, label %b77.e378
b77.t377:
  br label %b79
b77.e378:
  br label %b80
b78:
  br label %b86
b79:
  %v510 = getelementptr i64, ptr %s37, i64 0
  %v511 = add i64 0, 0
  %v512 = sub i64 %v511, %v481
  call void @"std/net.errOf"(ptr %v510, i64 %v512)
  %v513 = getelementptr i64, ptr %s35, i64 0
  %v514 = add i64 0, 1
  %st378 = getelementptr i64, ptr %v513, i64 0
  store i64 %v514, ptr %st378
  %v515.p = getelementptr i64, ptr %v510, i64 0
  %v515 = load i64, ptr %v515.p
  %st379 = getelementptr i64, ptr %v513, i64 1
  store i64 %v515, ptr %st379
  %v516.p = getelementptr i64, ptr %v510, i64 1
  %v516 = load i64, ptr %v516.p
  %st380 = getelementptr i64, ptr %v513, i64 2
  store i64 %v516, ptr %st380
  %v517.p = getelementptr i64, ptr %v510, i64 2
  %v517 = load i64, ptr %v517.p
  %st381 = getelementptr i64, ptr %v513, i64 3
  store i64 %v517, ptr %st381
  %v518.p = getelementptr i64, ptr %v510, i64 3
  %v518 = load i64, ptr %v518.p
  %st382 = getelementptr i64, ptr %v513, i64 4
  store i64 %v518, ptr %st382
  %v519.p = getelementptr i64, ptr %v510, i64 4
  %v519 = load i64, ptr %v519.p
  %st383 = getelementptr i64, ptr %v513, i64 5
  store i64 %v519, ptr %st383
  %v520.p = getelementptr i64, ptr %v513, i64 0
  %v520 = load i64, ptr %v520.p
  %st384 = getelementptr i64, ptr %v444, i64 0
  store i64 %v520, ptr %st384
  %v521.p = getelementptr i64, ptr %v513, i64 1
  %v521 = load i64, ptr %v521.p
  %st385 = getelementptr i64, ptr %v444, i64 1
  store i64 %v521, ptr %st385
  %v522.p = getelementptr i64, ptr %v513, i64 2
  %v522 = load i64, ptr %v522.p
  %st386 = getelementptr i64, ptr %v444, i64 2
  store i64 %v522, ptr %st386
  %v523.p = getelementptr i64, ptr %v513, i64 3
  %v523 = load i64, ptr %v523.p
  %st387 = getelementptr i64, ptr %v444, i64 3
  store i64 %v523, ptr %st387
  %v524.p = getelementptr i64, ptr %v513, i64 4
  %v524 = load i64, ptr %v524.p
  %st388 = getelementptr i64, ptr %v444, i64 4
  store i64 %v524, ptr %st388
  %v525.p = getelementptr i64, ptr %v513, i64 5
  %v525 = load i64, ptr %v525.p
  %st389 = getelementptr i64, ptr %v444, i64 5
  store i64 %v525, ptr %st389
  %v526.p = getelementptr i64, ptr %v444, i64 0
  %v526 = load i64, ptr %v526.p
  %v527 = add i64 0, 0
  %v528.c = icmp ne i64 %v526, %v527
  %v528 = zext i1 %v528.c to i64
  %c.b79 = icmp ne i64 %v528, 0
  br i1 %c.b79, label %b79.t391, label %b79.e392
b79.t391:
  br label %b81
b79.e392:
  br label %b82
b80:
  br label %b83
b81:
  %v529 = add i64 0, 1
  %v530 = getelementptr i64, ptr %v444, i64 %v529
  call void @"rt.err_relocate"(ptr %v530, i64 %v445)
  br label %b82
b82:
  %v768 = getelementptr i64, ptr @"rt.meta", i64 0
  %st392 = getelementptr i64, ptr %v768, i64 0
  store i64 %v445, ptr %st392
  br label %b63
b83:
  %v531 = getelementptr i64, ptr %s38, i64 0
  %v769 = getelementptr i64, ptr @"rt.meta", i64 0
  %v532.p = getelementptr i64, ptr %v769, i64 0
  %v532 = load i64, ptr %v532.p
  %v533 = getelementptr i64, ptr %s39, i64 0
  %v534 = add i64 0, 0
  %v535 = getelementptr i64, ptr %s40, i64 0
  %v536 = getelementptr i64, ptr %s41, i64 0
  %v537 = add i64 0, 0
  %st393 = getelementptr i64, ptr %v536, i64 0
  store i64 %v537, ptr %st393
  %st394 = getelementptr i64, ptr %v536, i64 0
  store i64 %v481, ptr %st394
  %v538 = getelementptr i64, ptr %s42, i64 0
  %v539.p = getelementptr i64, ptr %v536, i64 0
  %v539 = load i64, ptr %v539.p
  %st395 = getelementptr i64, ptr %v538, i64 0
  store i64 %v539, ptr %st395
  %v770 = getelementptr i64, ptr @"rt.meta", i64 0
  %v540.p = getelementptr i64, ptr %v770, i64 0
  %v540 = load i64, ptr %v540.p
  call void @"std/net.closeFd"(i64 %v481)
  br label %b62
b84:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b85:
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b86:
  br label %b64
b87:
  %v552 = add i64 0, 1
  %v553 = getelementptr i64, ptr %v444, i64 %v552
  call void @"rt.err_relocate"(ptr %v553, i64 %v445)
  br label %b88
b88:
  %v771 = getelementptr i64, ptr @"rt.meta", i64 0
  %st396 = getelementptr i64, ptr %v771, i64 0
  store i64 %v445, ptr %st396
  br label %b63
b89:
  %v557 = add i64 0, 0
  %st397 = getelementptr i64, ptr %v0, i64 0
  store i64 %v557, ptr %st397
  %st398 = getelementptr i64, ptr %v0, i64 1
  store i64 %v557, ptr %st398
  %st399 = getelementptr i64, ptr %v0, i64 2
  store i64 %v557, ptr %st399
  %v772 = getelementptr i64, ptr @"rt.meta", i64 0
  %v558.p = getelementptr i64, ptr %v772, i64 0
  %v558 = load i64, ptr %v558.p
  %v773 = getelementptr i64, ptr @"rt.meta", i64 0
  %v774 = getelementptr i64, ptr %v773, i64 %v558
  %v559.p = getelementptr i64, ptr %v774, i64 1
  %v559 = load ptr, ptr %v559.p
  %v560 = ptrtoint ptr %v559 to i64
  %st400 = getelementptr i64, ptr %v0, i64 0
  store i64 %v560, ptr %st400
  %v561 = add i64 0, 0
  %st401 = getelementptr i64, ptr %v0, i64 1
  store i64 %v561, ptr %st401
  %st402 = getelementptr i64, ptr %v0, i64 2
  store i64 %v558, ptr %st402
  %v562.p = getelementptr i64, ptr %v444, i64 0
  %v562 = load i64, ptr %v562.p
  %st403 = getelementptr i64, ptr %v0, i64 3
  store i64 %v562, ptr %st403
  %v563.p = getelementptr i64, ptr %v444, i64 1
  %v563 = load i64, ptr %v563.p
  %st404 = getelementptr i64, ptr %v0, i64 4
  store i64 %v563, ptr %st404
  %v564.p = getelementptr i64, ptr %v444, i64 2
  %v564 = load i64, ptr %v564.p
  %st405 = getelementptr i64, ptr %v0, i64 5
  store i64 %v564, ptr %st405
  %v565.p = getelementptr i64, ptr %v444, i64 3
  %v565 = load i64, ptr %v565.p
  %st406 = getelementptr i64, ptr %v0, i64 6
  store i64 %v565, ptr %st406
  %v566.p = getelementptr i64, ptr %v444, i64 4
  %v566 = load i64, ptr %v566.p
  %st407 = getelementptr i64, ptr %v0, i64 7
  store i64 %v566, ptr %st407
  %v567.p = getelementptr i64, ptr %v444, i64 5
  %v567 = load i64, ptr %v567.p
  %st408 = getelementptr i64, ptr %v0, i64 8
  store i64 %v567, ptr %st408
  call void @"std/net.closeFd"(i64 %v229)
  call void @"std/net.closeFd"(i64 %v90)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v568.p = getelementptr i64, ptr %v0, i64 3
  %v568 = load i64, ptr %v568.p
  %v569 = add i64 0, 0
  %v570.c = icmp ne i64 %v568, %v569
  %v570 = zext i1 %v570.c to i64
  %c.b89 = icmp ne i64 %v570, 0
  br i1 %c.b89, label %b89.t410, label %b89.e411
b89.t410:
  br label %b91
b89.e411:
  br label %b92
b90:
  br label %b62
b91:
  %v571 = add i64 0, 4
  %v572 = getelementptr i64, ptr %v0, i64 %v571
  call void @"rt.err_relocate"(ptr %v572, i64 %v1)
  br label %b92
b92:
  %v775 = getelementptr i64, ptr @"rt.meta", i64 0
  %st411 = getelementptr i64, ptr %v775, i64 0
  store i64 %v1, ptr %st411
  ret void
b93:
  %v664 = add i64 0, 1
  %v665 = getelementptr i64, ptr %v155, i64 %v664
  call void @"rt.err_relocate"(ptr %v665, i64 %v156)
  br label %b94
b94:
  %v776 = getelementptr i64, ptr @"rt.meta", i64 0
  %st412 = getelementptr i64, ptr %v776, i64 0
  store i64 %v156, ptr %st412
  br label %b20
b95:
  %v669 = add i64 0, 0
  %st413 = getelementptr i64, ptr %v0, i64 0
  store i64 %v669, ptr %st413
  %st414 = getelementptr i64, ptr %v0, i64 1
  store i64 %v669, ptr %st414
  %st415 = getelementptr i64, ptr %v0, i64 2
  store i64 %v669, ptr %st415
  %v777 = getelementptr i64, ptr @"rt.meta", i64 0
  %v670.p = getelementptr i64, ptr %v777, i64 0
  %v670 = load i64, ptr %v670.p
  %v778 = getelementptr i64, ptr @"rt.meta", i64 0
  %v779 = getelementptr i64, ptr %v778, i64 %v670
  %v671.p = getelementptr i64, ptr %v779, i64 1
  %v671 = load ptr, ptr %v671.p
  %v672 = ptrtoint ptr %v671 to i64
  %st416 = getelementptr i64, ptr %v0, i64 0
  store i64 %v672, ptr %st416
  %v673 = add i64 0, 0
  %st417 = getelementptr i64, ptr %v0, i64 1
  store i64 %v673, ptr %st417
  %st418 = getelementptr i64, ptr %v0, i64 2
  store i64 %v670, ptr %st418
  %v674.p = getelementptr i64, ptr %v155, i64 0
  %v674 = load i64, ptr %v674.p
  %st419 = getelementptr i64, ptr %v0, i64 3
  store i64 %v674, ptr %st419
  %v675.p = getelementptr i64, ptr %v155, i64 1
  %v675 = load i64, ptr %v675.p
  %st420 = getelementptr i64, ptr %v0, i64 4
  store i64 %v675, ptr %st420
  %v676.p = getelementptr i64, ptr %v155, i64 2
  %v676 = load i64, ptr %v676.p
  %st421 = getelementptr i64, ptr %v0, i64 5
  store i64 %v676, ptr %st421
  %v677.p = getelementptr i64, ptr %v155, i64 3
  %v677 = load i64, ptr %v677.p
  %st422 = getelementptr i64, ptr %v0, i64 6
  store i64 %v677, ptr %st422
  %v678.p = getelementptr i64, ptr %v155, i64 4
  %v678 = load i64, ptr %v678.p
  %st423 = getelementptr i64, ptr %v0, i64 7
  store i64 %v678, ptr %st423
  %v679.p = getelementptr i64, ptr %v155, i64 5
  %v679 = load i64, ptr %v679.p
  %st424 = getelementptr i64, ptr %v0, i64 8
  store i64 %v679, ptr %st424
  call void @"std/net.closeFd"(i64 %v90)
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v680.p = getelementptr i64, ptr %v0, i64 3
  %v680 = load i64, ptr %v680.p
  %v681 = add i64 0, 0
  %v682.c = icmp ne i64 %v680, %v681
  %v682 = zext i1 %v682.c to i64
  %c.b95 = icmp ne i64 %v682, 0
  br i1 %c.b95, label %b95.t426, label %b95.e427
b95.t426:
  br label %b97
b95.e427:
  br label %b98
b96:
  br label %b19
b97:
  %v683 = add i64 0, 4
  %v684 = getelementptr i64, ptr %v0, i64 %v683
  call void @"rt.err_relocate"(ptr %v684, i64 %v1)
  br label %b98
b98:
  %v780 = getelementptr i64, ptr @"rt.meta", i64 0
  %st427 = getelementptr i64, ptr %v780, i64 0
  store i64 %v1, ptr %st427
  ret void
b99:
  %v696 = add i64 0, 1
  %v697 = getelementptr i64, ptr %v21, i64 %v696
  call void @"rt.err_relocate"(ptr %v697, i64 %v22)
  br label %b100
b100:
  %v781 = getelementptr i64, ptr @"rt.meta", i64 0
  %st428 = getelementptr i64, ptr %v781, i64 0
  store i64 %v22, ptr %st428
  br label %b2
b101:
  %v701 = add i64 0, 0
  %st429 = getelementptr i64, ptr %v0, i64 0
  store i64 %v701, ptr %st429
  %st430 = getelementptr i64, ptr %v0, i64 1
  store i64 %v701, ptr %st430
  %st431 = getelementptr i64, ptr %v0, i64 2
  store i64 %v701, ptr %st431
  %v782 = getelementptr i64, ptr @"rt.meta", i64 0
  %v702.p = getelementptr i64, ptr %v782, i64 0
  %v702 = load i64, ptr %v702.p
  %v783 = getelementptr i64, ptr @"rt.meta", i64 0
  %v784 = getelementptr i64, ptr %v783, i64 %v702
  %v703.p = getelementptr i64, ptr %v784, i64 1
  %v703 = load ptr, ptr %v703.p
  %v704 = ptrtoint ptr %v703 to i64
  %st432 = getelementptr i64, ptr %v0, i64 0
  store i64 %v704, ptr %st432
  %v705 = add i64 0, 0
  %st433 = getelementptr i64, ptr %v0, i64 1
  store i64 %v705, ptr %st433
  %st434 = getelementptr i64, ptr %v0, i64 2
  store i64 %v702, ptr %st434
  %v706.p = getelementptr i64, ptr %v21, i64 0
  %v706 = load i64, ptr %v706.p
  %st435 = getelementptr i64, ptr %v0, i64 3
  store i64 %v706, ptr %st435
  %v707.p = getelementptr i64, ptr %v21, i64 1
  %v707 = load i64, ptr %v707.p
  %st436 = getelementptr i64, ptr %v0, i64 4
  store i64 %v707, ptr %st436
  %v708.p = getelementptr i64, ptr %v21, i64 2
  %v708 = load i64, ptr %v708.p
  %st437 = getelementptr i64, ptr %v0, i64 5
  store i64 %v708, ptr %st437
  %v709.p = getelementptr i64, ptr %v21, i64 3
  %v709 = load i64, ptr %v709.p
  %st438 = getelementptr i64, ptr %v0, i64 6
  store i64 %v709, ptr %st438
  %v710.p = getelementptr i64, ptr %v21, i64 4
  %v710 = load i64, ptr %v710.p
  %st439 = getelementptr i64, ptr %v0, i64 7
  store i64 %v710, ptr %st439
  %v711.p = getelementptr i64, ptr %v21, i64 5
  %v711 = load i64, ptr %v711.p
  %st440 = getelementptr i64, ptr %v0, i64 8
  store i64 %v711, ptr %st440
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v712.p = getelementptr i64, ptr %v0, i64 3
  %v712 = load i64, ptr %v712.p
  %v713 = add i64 0, 0
  %v714.c = icmp ne i64 %v712, %v713
  %v714 = zext i1 %v714.c to i64
  %c.b101 = icmp ne i64 %v714, 0
  br i1 %c.b101, label %b101.t442, label %b101.e443
b101.t442:
  br label %b103
b101.e443:
  br label %b104
b102:
  br label %b1
b103:
  %v715 = add i64 0, 4
  %v716 = getelementptr i64, ptr %v0, i64 %v715
  call void @"rt.err_relocate"(ptr %v716, i64 %v1)
  br label %b104
b104:
  %v785 = getelementptr i64, ptr @"rt.meta", i64 0
  %st443 = getelementptr i64, ptr %v785, i64 0
  store i64 %v1, ptr %st443
  ret void
b105:
  %v731 = add i64 0, 4
  %v732 = getelementptr i64, ptr %v0, i64 %v731
  call void @"rt.err_relocate"(ptr %v732, i64 %v1)
  br label %b106
b106:
  %v786 = getelementptr i64, ptr @"rt.meta", i64 0
  %st444 = getelementptr i64, ptr %v786, i64 0
  store i64 %v1, ptr %st444
  ret void
}

define internal void @"main.drain"(ptr %v0, i64 %v1) #0 {
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
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v1, ptr %st0
  %v178 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v178, i64 0
  %v3 = load i64, ptr %v3.p
  call void @"rt.region_enter"()
  %v179 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v179, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr %s1, i64 0
  %v6.p = getelementptr i64, ptr %v2, i64 0
  %v6 = load i64, ptr %v6.p
  %st1 = getelementptr i64, ptr %v5, i64 0
  store i64 %v6, ptr %st1
  %v7 = getelementptr i64, ptr %s2, i64 0
  %v180 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v180, i64 0
  %v8 = load i64, ptr %v8.p
  %v181 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v181, i64 0
  %v9 = load i64, ptr %v9.p
  br label %b3
b1:
  %v182 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v182, i64 0
  store i64 %v4, ptr %st2
  %v165 = getelementptr i64, ptr %s5, i64 0
  %v166 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v165, i64 0
  store i64 %v166, ptr %st3
  %v167.p = getelementptr i64, ptr %v165, i64 0
  %v167 = load i64, ptr %v167.p
  %st4 = getelementptr i64, ptr %v0, i64 0
  store i64 %v167, ptr %st4
  %v168.p = getelementptr i64, ptr %v165, i64 1
  %v168 = load i64, ptr %v168.p
  %st5 = getelementptr i64, ptr %v0, i64 1
  store i64 %v168, ptr %st5
  %v169.p = getelementptr i64, ptr %v165, i64 2
  %v169 = load i64, ptr %v169.p
  %st6 = getelementptr i64, ptr %v0, i64 2
  store i64 %v169, ptr %st6
  %v170.p = getelementptr i64, ptr %v165, i64 3
  %v170 = load i64, ptr %v170.p
  %st7 = getelementptr i64, ptr %v0, i64 3
  store i64 %v170, ptr %st7
  %v171.p = getelementptr i64, ptr %v165, i64 4
  %v171 = load i64, ptr %v171.p
  %st8 = getelementptr i64, ptr %v0, i64 4
  store i64 %v171, ptr %st8
  %v172.p = getelementptr i64, ptr %v165, i64 5
  %v172 = load i64, ptr %v172.p
  %st9 = getelementptr i64, ptr %v0, i64 5
  store i64 %v172, ptr %st9
  %v173.p = getelementptr i64, ptr %v0, i64 0
  %v173 = load i64, ptr %v173.p
  %v174 = add i64 0, 0
  %v175.c = icmp ne i64 %v173, %v174
  %v175 = zext i1 %v175.c to i64
  %c.b1 = icmp ne i64 %v175, 0
  br i1 %c.b1, label %b1.t11, label %b1.e12
b1.t11:
  br label %b43
b1.e12:
  br label %b44
b2:
  %v150.p = getelementptr i64, ptr %v7, i64 0
  %v150 = load i64, ptr %v150.p
  %v151 = add i64 0, 0
  %v152.c = icmp ne i64 %v150, %v151
  %v152 = zext i1 %v152.c to i64
  %c.b2 = icmp ne i64 %v152, 0
  br i1 %c.b2, label %b2.t13, label %b2.e14
b2.t13:
  br label %b39
b2.e14:
  br label %b40
b3:
  %v183 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v183, i64 0
  store i64 %v9, ptr %st14
  %v10 = add i64 0, 1
  %c.b3 = icmp ne i64 %v10, 0
  br i1 %c.b3, label %b3.t16, label %b3.e17
b3.t16:
  br label %b4
b3.e17:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v184 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v184, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13 = add i64 0, 0
  %v14.c = icmp ne i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b4 = icmp ne i64 %v14, 0
  br i1 %c.b4, label %b4.t18, label %b4.e19
b4.t18:
  br label %b6
b4.e19:
  br label %b7
b5:
  %v185 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v185, i64 0
  store i64 %v9, ptr %st19
  %v137 = getelementptr i64, ptr %s5, i64 0
  %v138 = add i64 0, 0
  %st20 = getelementptr i64, ptr %v137, i64 0
  store i64 %v138, ptr %st20
  %v139.p = getelementptr i64, ptr %v137, i64 0
  %v139 = load i64, ptr %v139.p
  %st21 = getelementptr i64, ptr %v7, i64 0
  store i64 %v139, ptr %st21
  %v140.p = getelementptr i64, ptr %v137, i64 1
  %v140 = load i64, ptr %v140.p
  %st22 = getelementptr i64, ptr %v7, i64 1
  store i64 %v140, ptr %st22
  %v141.p = getelementptr i64, ptr %v137, i64 2
  %v141 = load i64, ptr %v141.p
  %st23 = getelementptr i64, ptr %v7, i64 2
  store i64 %v141, ptr %st23
  %v142.p = getelementptr i64, ptr %v137, i64 3
  %v142 = load i64, ptr %v142.p
  %st24 = getelementptr i64, ptr %v7, i64 3
  store i64 %v142, ptr %st24
  %v143.p = getelementptr i64, ptr %v137, i64 4
  %v143 = load i64, ptr %v143.p
  %st25 = getelementptr i64, ptr %v7, i64 4
  store i64 %v143, ptr %st25
  %v144.p = getelementptr i64, ptr %v137, i64 5
  %v144 = load i64, ptr %v144.p
  %st26 = getelementptr i64, ptr %v7, i64 5
  store i64 %v144, ptr %st26
  %v145.p = getelementptr i64, ptr %v7, i64 0
  %v145 = load i64, ptr %v145.p
  %v146 = add i64 0, 0
  %v147.c = icmp ne i64 %v145, %v146
  %v147 = zext i1 %v147.c to i64
  %c.b5 = icmp ne i64 %v147, 0
  br i1 %c.b5, label %b5.t28, label %b5.e29
b5.t28:
  br label %b37
b5.e29:
  br label %b38
b6:
  %v15 = getelementptr i64, ptr %s3, i64 0
  %v16 = add i64 0, 0
  %st29 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st29
  %st30 = getelementptr i64, ptr %v15, i64 1
  store i64 %v16, ptr %st30
  %v17 = add i64 0, 3
  %st31 = getelementptr i64, ptr %v15, i64 0
  store i64 %v17, ptr %st31
  %v18 = getelementptr i64, ptr %s4, i64 0
  %v19.p = getelementptr i64, ptr %v15, i64 0
  %v19 = load i64, ptr %v19.p
  %st32 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st32
  %v20.p = getelementptr i64, ptr %v15, i64 1
  %v20 = load i64, ptr %v20.p
  %st33 = getelementptr i64, ptr %v18, i64 1
  store i64 %v20, ptr %st33
  %v21 = add i64 0, 0
  %st34 = getelementptr i64, ptr %v18, i64 2
  store i64 %v21, ptr %st34
  %st35 = getelementptr i64, ptr %v18, i64 3
  store i64 %v21, ptr %st35
  %st36 = getelementptr i64, ptr %v18, i64 4
  store i64 %v21, ptr %st36
  %v22 = getelementptr i64, ptr %s5, i64 0
  %v23 = add i64 0, 1
  %st37 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st37
  %v24.p = getelementptr i64, ptr %v18, i64 0
  %v24 = load i64, ptr %v24.p
  %st38 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st38
  %v25.p = getelementptr i64, ptr %v18, i64 1
  %v25 = load i64, ptr %v25.p
  %st39 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st39
  %v26.p = getelementptr i64, ptr %v18, i64 2
  %v26 = load i64, ptr %v26.p
  %st40 = getelementptr i64, ptr %v22, i64 3
  store i64 %v26, ptr %st40
  %v27.p = getelementptr i64, ptr %v18, i64 3
  %v27 = load i64, ptr %v27.p
  %st41 = getelementptr i64, ptr %v22, i64 4
  store i64 %v27, ptr %st41
  %v28.p = getelementptr i64, ptr %v18, i64 4
  %v28 = load i64, ptr %v28.p
  %st42 = getelementptr i64, ptr %v22, i64 5
  store i64 %v28, ptr %st42
  %v29.p = getelementptr i64, ptr %v22, i64 0
  %v29 = load i64, ptr %v29.p
  %st43 = getelementptr i64, ptr %v7, i64 0
  store i64 %v29, ptr %st43
  %v30.p = getelementptr i64, ptr %v22, i64 1
  %v30 = load i64, ptr %v30.p
  %st44 = getelementptr i64, ptr %v7, i64 1
  store i64 %v30, ptr %st44
  %v31.p = getelementptr i64, ptr %v22, i64 2
  %v31 = load i64, ptr %v31.p
  %st45 = getelementptr i64, ptr %v7, i64 2
  store i64 %v31, ptr %st45
  %v32.p = getelementptr i64, ptr %v22, i64 3
  %v32 = load i64, ptr %v32.p
  %st46 = getelementptr i64, ptr %v7, i64 3
  store i64 %v32, ptr %st46
  %v33.p = getelementptr i64, ptr %v22, i64 4
  %v33 = load i64, ptr %v33.p
  %st47 = getelementptr i64, ptr %v7, i64 4
  store i64 %v33, ptr %st47
  %v34.p = getelementptr i64, ptr %v22, i64 5
  %v34 = load i64, ptr %v34.p
  %st48 = getelementptr i64, ptr %v7, i64 5
  store i64 %v34, ptr %st48
  %v35.p = getelementptr i64, ptr %v7, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 0
  %v37.c = icmp ne i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b6 = icmp ne i64 %v37, 0
  br i1 %c.b6, label %b6.t50, label %b6.e51
b6.t50:
  br label %b8
b6.e51:
  br label %b9
b7:
  br label %b10
b8:
  %v38 = add i64 0, 1
  %v39 = getelementptr i64, ptr %v7, i64 %v38
  call void @"rt.err_relocate"(ptr %v39, i64 %v8)
  br label %b9
b9:
  %v186 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v186, i64 0
  store i64 %v8, ptr %st51
  br label %b2
b10:
  %v187 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v187, i64 0
  %v40 = load i64, ptr %v40.p
  call void @"rt.region_enter"()
  %v188 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41.p = getelementptr i64, ptr %v188, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v5, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 0, 65536
  %v44 = add i64 0, 1099511627776
  %v45 = add i64 %v43, %v44
  %v46 = getelementptr i64, ptr %s6, i64 0
  call void @"rt.read_fd"(i64 %v42, i64 %v45, ptr %v46)
  %v47 = getelementptr i64, ptr %s7, i64 0
  %v48.p = getelementptr i64, ptr %v46, i64 0
  %v48 = load i64, ptr %v48.p
  %st52 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st52
  %v49.p = getelementptr i64, ptr %v46, i64 1
  %v49 = load i64, ptr %v49.p
  %st53 = getelementptr i64, ptr %v47, i64 1
  store i64 %v49, ptr %st53
  %v50.p = getelementptr i64, ptr %v46, i64 2
  %v50 = load i64, ptr %v50.p
  %st54 = getelementptr i64, ptr %v47, i64 2
  store i64 %v50, ptr %st54
  %v51 = getelementptr i64, ptr @"rt.meta", i64 0
  %v52.p = getelementptr i64, ptr %v51, i64 1027
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 0
  %v54.c = icmp ne i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b10 = icmp ne i64 %v54, 0
  br i1 %c.b10, label %b10.t56, label %b10.e57
b10.t56:
  br label %b11
b10.e57:
  br label %b12
b11:
  %v55 = add i64 0, 0
  %v56 = sub i64 %v55, %v52
  br label %b17
b12:
  %v57.p = getelementptr i64, ptr %v47, i64 1
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 0, 0
  %v59.c = icmp eq i64 %v57, %v58
  %v59 = zext i1 %v59.c to i64
  %c.b12 = icmp ne i64 %v59, 0
  br i1 %c.b12, label %b12.t58, label %b12.e59
b12.t58:
  br label %b13
b12.e59:
  br label %b14
b13:
  %v60 = add i64 0, 0
  br label %b16
b14:
  %v61 = getelementptr i64, ptr %s6, i64 0
  %v62.p = getelementptr i64, ptr %v47, i64 0
  %v62 = load i64, ptr %v62.p
  %st59 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st59
  %v63.p = getelementptr i64, ptr %v47, i64 1
  %v63 = load i64, ptr %v63.p
  %st60 = getelementptr i64, ptr %v61, i64 1
  store i64 %v63, ptr %st60
  %v64.p = getelementptr i64, ptr %v47, i64 2
  %v64 = load i64, ptr %v64.p
  %st61 = getelementptr i64, ptr %v61, i64 2
  store i64 %v64, ptr %st61
  %v189 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v189, i64 0
  %v65 = load i64, ptr %v65.p
  br label %b15
b15:
  %v190 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v190, i64 0
  store i64 %v65, ptr %st62
  %v66.p = getelementptr i64, ptr %v47, i64 1
  %v66 = load i64, ptr %v66.p
  br label %b16
b16:
  %v67 = phi i64 [ %v60, %b13 ], [ %v66, %b15 ]
  br label %b17
b17:
  %v68 = phi i64 [ %v56, %b11 ], [ %v67, %b16 ]
  %v191 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v191, i64 0
  store i64 %v40, ptr %st63
  %v69.p = getelementptr i64, ptr %v5, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 1
  %v71 = call i64 @"std/net.again"(i64 %v68, i64 %v69, i64 %v70)
  %v72 = add i64 0, 0
  %v73.c = icmp slt i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b17 = icmp ne i64 %v73, 0
  br i1 %c.b17, label %b17.t65, label %b17.e66
b17.t65:
  br label %b18
b17.e66:
  br label %b19
b18:
  %v74 = getelementptr i64, ptr %s8, i64 0
  call void @"std/net.waitErr"(ptr %v74, i64 %v71)
  %v75 = getelementptr i64, ptr %s5, i64 0
  %v76 = add i64 0, 1
  %st66 = getelementptr i64, ptr %v75, i64 0
  store i64 %v76, ptr %st66
  %v77.p = getelementptr i64, ptr %v74, i64 0
  %v77 = load i64, ptr %v77.p
  %st67 = getelementptr i64, ptr %v75, i64 1
  store i64 %v77, ptr %st67
  %v78.p = getelementptr i64, ptr %v74, i64 1
  %v78 = load i64, ptr %v78.p
  %st68 = getelementptr i64, ptr %v75, i64 2
  store i64 %v78, ptr %st68
  %v79.p = getelementptr i64, ptr %v74, i64 2
  %v79 = load i64, ptr %v79.p
  %st69 = getelementptr i64, ptr %v75, i64 3
  store i64 %v79, ptr %st69
  %v80.p = getelementptr i64, ptr %v74, i64 3
  %v80 = load i64, ptr %v80.p
  %st70 = getelementptr i64, ptr %v75, i64 4
  store i64 %v80, ptr %st70
  %v81.p = getelementptr i64, ptr %v74, i64 4
  %v81 = load i64, ptr %v81.p
  %st71 = getelementptr i64, ptr %v75, i64 5
  store i64 %v81, ptr %st71
  %v82.p = getelementptr i64, ptr %v75, i64 0
  %v82 = load i64, ptr %v82.p
  %st72 = getelementptr i64, ptr %v7, i64 0
  store i64 %v82, ptr %st72
  %v83.p = getelementptr i64, ptr %v75, i64 1
  %v83 = load i64, ptr %v83.p
  %st73 = getelementptr i64, ptr %v7, i64 1
  store i64 %v83, ptr %st73
  %v84.p = getelementptr i64, ptr %v75, i64 2
  %v84 = load i64, ptr %v84.p
  %st74 = getelementptr i64, ptr %v7, i64 2
  store i64 %v84, ptr %st74
  %v85.p = getelementptr i64, ptr %v75, i64 3
  %v85 = load i64, ptr %v85.p
  %st75 = getelementptr i64, ptr %v7, i64 3
  store i64 %v85, ptr %st75
  %v86.p = getelementptr i64, ptr %v75, i64 4
  %v86 = load i64, ptr %v86.p
  %st76 = getelementptr i64, ptr %v7, i64 4
  store i64 %v86, ptr %st76
  %v87.p = getelementptr i64, ptr %v75, i64 5
  %v87 = load i64, ptr %v87.p
  %st77 = getelementptr i64, ptr %v7, i64 5
  store i64 %v87, ptr %st77
  %v88.p = getelementptr i64, ptr %v7, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = add i64 0, 0
  %v90.c = icmp ne i64 %v88, %v89
  %v90 = zext i1 %v90.c to i64
  %c.b18 = icmp ne i64 %v90, 0
  br i1 %c.b18, label %b18.t79, label %b18.e80
b18.t79:
  br label %b20
b18.e80:
  br label %b21
b19:
  br label %b22
b20:
  %v91 = add i64 0, 1
  %v92 = getelementptr i64, ptr %v7, i64 %v91
  call void @"rt.err_relocate"(ptr %v92, i64 %v8)
  br label %b21
b21:
  %v192 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v192, i64 0
  store i64 %v8, ptr %st80
  br label %b2
b22:
  %v93 = add i64 0, 1
  %v94.c = icmp eq i64 %v71, %v93
  %v94 = zext i1 %v94.c to i64
  %c.b22 = icmp ne i64 %v94, 0
  br i1 %c.b22, label %b22.t82, label %b22.e83
b22.t82:
  br label %b23
b22.e83:
  br label %b24
b23:
  %v96 = add i64 0, 0
  %v97.c = icmp slt i64 %v68, %v96
  %v97 = zext i1 %v97.c to i64
  br label %b24
b24:
  %v95 = phi i64 [ %v94, %b22.e83 ], [ %v97, %b23 ]
  %c.b24 = icmp ne i64 %v95, 0
  br i1 %c.b24, label %b24.t84, label %b24.e85
b24.t84:
  br label %b25
b24.e85:
  br label %b26
b25:
  %v98 = getelementptr i64, ptr %s9, i64 0
  %v99 = add i64 0, 0
  %v100 = sub i64 %v99, %v68
  call void @"std/net.errOf"(ptr %v98, i64 %v100)
  %v101 = getelementptr i64, ptr %s5, i64 0
  %v102 = add i64 0, 1
  %st85 = getelementptr i64, ptr %v101, i64 0
  store i64 %v102, ptr %st85
  %v103.p = getelementptr i64, ptr %v98, i64 0
  %v103 = load i64, ptr %v103.p
  %st86 = getelementptr i64, ptr %v101, i64 1
  store i64 %v103, ptr %st86
  %v104.p = getelementptr i64, ptr %v98, i64 1
  %v104 = load i64, ptr %v104.p
  %st87 = getelementptr i64, ptr %v101, i64 2
  store i64 %v104, ptr %st87
  %v105.p = getelementptr i64, ptr %v98, i64 2
  %v105 = load i64, ptr %v105.p
  %st88 = getelementptr i64, ptr %v101, i64 3
  store i64 %v105, ptr %st88
  %v106.p = getelementptr i64, ptr %v98, i64 3
  %v106 = load i64, ptr %v106.p
  %st89 = getelementptr i64, ptr %v101, i64 4
  store i64 %v106, ptr %st89
  %v107.p = getelementptr i64, ptr %v98, i64 4
  %v107 = load i64, ptr %v107.p
  %st90 = getelementptr i64, ptr %v101, i64 5
  store i64 %v107, ptr %st90
  %v108.p = getelementptr i64, ptr %v101, i64 0
  %v108 = load i64, ptr %v108.p
  %st91 = getelementptr i64, ptr %v7, i64 0
  store i64 %v108, ptr %st91
  %v109.p = getelementptr i64, ptr %v101, i64 1
  %v109 = load i64, ptr %v109.p
  %st92 = getelementptr i64, ptr %v7, i64 1
  store i64 %v109, ptr %st92
  %v110.p = getelementptr i64, ptr %v101, i64 2
  %v110 = load i64, ptr %v110.p
  %st93 = getelementptr i64, ptr %v7, i64 2
  store i64 %v110, ptr %st93
  %v111.p = getelementptr i64, ptr %v101, i64 3
  %v111 = load i64, ptr %v111.p
  %st94 = getelementptr i64, ptr %v7, i64 3
  store i64 %v111, ptr %st94
  %v112.p = getelementptr i64, ptr %v101, i64 4
  %v112 = load i64, ptr %v112.p
  %st95 = getelementptr i64, ptr %v7, i64 4
  store i64 %v112, ptr %st95
  %v113.p = getelementptr i64, ptr %v101, i64 5
  %v113 = load i64, ptr %v113.p
  %st96 = getelementptr i64, ptr %v7, i64 5
  store i64 %v113, ptr %st96
  %v114.p = getelementptr i64, ptr %v7, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp ne i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b25 = icmp ne i64 %v116, 0
  br i1 %c.b25, label %b25.t98, label %b25.e99
b25.t98:
  br label %b27
b25.e99:
  br label %b28
b26:
  br label %b29
b27:
  %v117 = add i64 0, 1
  %v118 = getelementptr i64, ptr %v7, i64 %v117
  call void @"rt.err_relocate"(ptr %v118, i64 %v8)
  br label %b28
b28:
  %v193 = getelementptr i64, ptr @"rt.meta", i64 0
  %st99 = getelementptr i64, ptr %v193, i64 0
  store i64 %v8, ptr %st99
  br label %b2
b29:
  %v119 = add i64 0, 1
  %v120.c = icmp eq i64 %v71, %v119
  %v120 = zext i1 %v120.c to i64
  %c.b29 = icmp ne i64 %v120, 0
  br i1 %c.b29, label %b29.t101, label %b29.e102
b29.t101:
  br label %b30
b29.e102:
  br label %b31
b30:
  %v122 = add i64 0, 0
  %v123.c = icmp eq i64 %v68, %v122
  %v123 = zext i1 %v123.c to i64
  br label %b31
b31:
  %v121 = phi i64 [ %v120, %b29.e102 ], [ %v123, %b30 ]
  %c.b31 = icmp ne i64 %v121, 0
  br i1 %c.b31, label %b31.t103, label %b31.e104
b31.t103:
  br label %b32
b31.e104:
  br label %b33
b32:
  %v124 = getelementptr i64, ptr %s5, i64 0
  %v125 = add i64 0, 0
  %st104 = getelementptr i64, ptr %v124, i64 0
  store i64 %v125, ptr %st104
  %v126.p = getelementptr i64, ptr %v124, i64 0
  %v126 = load i64, ptr %v126.p
  %st105 = getelementptr i64, ptr %v7, i64 0
  store i64 %v126, ptr %st105
  %v127.p = getelementptr i64, ptr %v124, i64 1
  %v127 = load i64, ptr %v127.p
  %st106 = getelementptr i64, ptr %v7, i64 1
  store i64 %v127, ptr %st106
  %v128.p = getelementptr i64, ptr %v124, i64 2
  %v128 = load i64, ptr %v128.p
  %st107 = getelementptr i64, ptr %v7, i64 2
  store i64 %v128, ptr %st107
  %v129.p = getelementptr i64, ptr %v124, i64 3
  %v129 = load i64, ptr %v129.p
  %st108 = getelementptr i64, ptr %v7, i64 3
  store i64 %v129, ptr %st108
  %v130.p = getelementptr i64, ptr %v124, i64 4
  %v130 = load i64, ptr %v130.p
  %st109 = getelementptr i64, ptr %v7, i64 4
  store i64 %v130, ptr %st109
  %v131.p = getelementptr i64, ptr %v124, i64 5
  %v131 = load i64, ptr %v131.p
  %st110 = getelementptr i64, ptr %v7, i64 5
  store i64 %v131, ptr %st110
  %v132.p = getelementptr i64, ptr %v7, i64 0
  %v132 = load i64, ptr %v132.p
  %v133 = add i64 0, 0
  %v134.c = icmp ne i64 %v132, %v133
  %v134 = zext i1 %v134.c to i64
  %c.b32 = icmp ne i64 %v134, 0
  br i1 %c.b32, label %b32.t112, label %b32.e113
b32.t112:
  br label %b34
b32.e113:
  br label %b35
b33:
  br label %b36
b34:
  %v135 = add i64 0, 1
  %v136 = getelementptr i64, ptr %v7, i64 %v135
  call void @"rt.err_relocate"(ptr %v136, i64 %v8)
  br label %b35
b35:
  %v194 = getelementptr i64, ptr @"rt.meta", i64 0
  %st113 = getelementptr i64, ptr %v194, i64 0
  store i64 %v8, ptr %st113
  br label %b2
b36:
  br label %b3
b37:
  %v148 = add i64 0, 1
  %v149 = getelementptr i64, ptr %v7, i64 %v148
  call void @"rt.err_relocate"(ptr %v149, i64 %v8)
  br label %b38
b38:
  %v195 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v195, i64 0
  store i64 %v8, ptr %st114
  br label %b2
b39:
  %v153 = add i64 0, 0
  %v154.p = getelementptr i64, ptr %v7, i64 0
  %v154 = load i64, ptr %v154.p
  %st115 = getelementptr i64, ptr %v0, i64 0
  store i64 %v154, ptr %st115
  %v155.p = getelementptr i64, ptr %v7, i64 1
  %v155 = load i64, ptr %v155.p
  %st116 = getelementptr i64, ptr %v0, i64 1
  store i64 %v155, ptr %st116
  %v156.p = getelementptr i64, ptr %v7, i64 2
  %v156 = load i64, ptr %v156.p
  %st117 = getelementptr i64, ptr %v0, i64 2
  store i64 %v156, ptr %st117
  %v157.p = getelementptr i64, ptr %v7, i64 3
  %v157 = load i64, ptr %v157.p
  %st118 = getelementptr i64, ptr %v0, i64 3
  store i64 %v157, ptr %st118
  %v158.p = getelementptr i64, ptr %v7, i64 4
  %v158 = load i64, ptr %v158.p
  %st119 = getelementptr i64, ptr %v0, i64 4
  store i64 %v158, ptr %st119
  %v159.p = getelementptr i64, ptr %v7, i64 5
  %v159 = load i64, ptr %v159.p
  %st120 = getelementptr i64, ptr %v0, i64 5
  store i64 %v159, ptr %st120
  %v160.p = getelementptr i64, ptr %v0, i64 0
  %v160 = load i64, ptr %v160.p
  %v161 = add i64 0, 0
  %v162.c = icmp ne i64 %v160, %v161
  %v162 = zext i1 %v162.c to i64
  %c.b39 = icmp ne i64 %v162, 0
  br i1 %c.b39, label %b39.t122, label %b39.e123
b39.t122:
  br label %b41
b39.e123:
  br label %b42
b40:
  br label %b1
b41:
  %v163 = add i64 0, 1
  %v164 = getelementptr i64, ptr %v0, i64 %v163
  call void @"rt.err_relocate"(ptr %v164, i64 %v3)
  br label %b42
b42:
  %v196 = getelementptr i64, ptr @"rt.meta", i64 0
  %st123 = getelementptr i64, ptr %v196, i64 0
  store i64 %v3, ptr %st123
  ret void
b43:
  %v176 = add i64 0, 1
  %v177 = getelementptr i64, ptr %v0, i64 %v176
  call void @"rt.err_relocate"(ptr %v177, i64 %v3)
  br label %b44
b44:
  %v197 = getelementptr i64, ptr @"rt.meta", i64 0
  %st124 = getelementptr i64, ptr %v197, i64 0
  store i64 %v3, ptr %st124
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
  %v13 = add i64 0, 32
  %v14.c = icmp eq i64 %v1, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b2
b0.e3:
  br label %b1
b1:
  %v16 = add i64 0, 104
  %v17.c = icmp eq i64 %v1, %v16
  %v17 = zext i1 %v17.c to i64
  br label %b2
b2:
  %v15 = phi i64 [ %v14, %b0.t2 ], [ %v17, %b1 ]
  %c.b2 = icmp ne i64 %v15, 0
  br i1 %c.b2, label %b2.t4, label %b2.e5
b2.t4:
  br label %b4
b2.e5:
  br label %b3
b3:
  %v19 = add i64 0, 111
  %v20.c = icmp eq i64 %v1, %v19
  %v20 = zext i1 %v20.c to i64
  br label %b4
b4:
  %v18 = phi i64 [ %v15, %b2.t4 ], [ %v20, %b3 ]
  %c.b4 = icmp ne i64 %v18, 0
  br i1 %c.b4, label %b4.t6, label %b4.e7
b4.t6:
  br label %b5
b4.e7:
  br label %b6
b5:
  %v21 = getelementptr i64, ptr %s0, i64 0
  %v22 = add i64 0, 0
  %st7 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st7
  %st8 = getelementptr i64, ptr %v21, i64 1
  store i64 %v22, ptr %st8
  %v23 = add i64 0, 4
  %st9 = getelementptr i64, ptr %v21, i64 0
  store i64 %v23, ptr %st9
  %v24 = getelementptr i64, ptr %s1, i64 0
  %v25.p = getelementptr i64, ptr %v21, i64 0
  %v25 = load i64, ptr %v25.p
  %st10 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st10
  %v26.p = getelementptr i64, ptr %v21, i64 1
  %v26 = load i64, ptr %v26.p
  %st11 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st11
  %v27 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st12
  %st13 = getelementptr i64, ptr %v24, i64 3
  store i64 %v27, ptr %st13
  %st14 = getelementptr i64, ptr %v24, i64 4
  store i64 %v27, ptr %st14
  %v28.p = getelementptr i64, ptr %v24, i64 0
  %v28 = load i64, ptr %v28.p
  %st15 = getelementptr i64, ptr %v0, i64 0
  store i64 %v28, ptr %st15
  %v29.p = getelementptr i64, ptr %v24, i64 1
  %v29 = load i64, ptr %v29.p
  %st16 = getelementptr i64, ptr %v0, i64 1
  store i64 %v29, ptr %st16
  %v30.p = getelementptr i64, ptr %v24, i64 2
  %v30 = load i64, ptr %v30.p
  %st17 = getelementptr i64, ptr %v0, i64 2
  store i64 %v30, ptr %st17
  %v31.p = getelementptr i64, ptr %v24, i64 3
  %v31 = load i64, ptr %v31.p
  %st18 = getelementptr i64, ptr %v0, i64 3
  store i64 %v31, ptr %st18
  %v32.p = getelementptr i64, ptr %v24, i64 4
  %v32 = load i64, ptr %v32.p
  %st19 = getelementptr i64, ptr %v0, i64 4
  store i64 %v32, ptr %st19
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v98, i64 0
  store i64 %v2, ptr %st20
  ret void
b6:
  br label %b7
b7:
  %v33 = add i64 0, 110
  %v34.c = icmp eq i64 %v1, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b7 = icmp ne i64 %v34, 0
  br i1 %c.b7, label %b7.t22, label %b7.e23
b7.t22:
  br label %b8
b7.e23:
  br label %b9
b8:
  %v35 = add i64 0, 0
  %v36 = add i64 0, 0
  %v37.c = icmp ne i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b8 = icmp ne i64 %v37, 0
  br i1 %c.b8, label %b8.t24, label %b8.e25
b8.t24:
  br label %b10
b8.e25:
  br label %b11
b9:
  br label %b13
b10:
  %v38 = getelementptr i64, ptr %s0, i64 0
  %v39 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st25
  %st26 = getelementptr i64, ptr %v38, i64 1
  store i64 %v39, ptr %st26
  %v40 = add i64 0, 3
  %st27 = getelementptr i64, ptr %v38, i64 0
  store i64 %v40, ptr %st27
  br label %b12
b11:
  %v41 = getelementptr i64, ptr %s2, i64 0
  %v42 = add i64 0, 0
  %st28 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st28
  %st29 = getelementptr i64, ptr %v41, i64 1
  store i64 %v42, ptr %st29
  %v43 = add i64 0, 2
  %st30 = getelementptr i64, ptr %v41, i64 0
  store i64 %v43, ptr %st30
  br label %b12
b12:
  %v44 = phi ptr [ %v38, %b10 ], [ %v41, %b11 ]
  %v45 = getelementptr i64, ptr %s1, i64 0
  %v46.p = getelementptr i64, ptr %v44, i64 0
  %v46 = load i64, ptr %v46.p
  %st31 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st31
  %v47.p = getelementptr i64, ptr %v44, i64 1
  %v47 = load i64, ptr %v47.p
  %st32 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st32
  %v48 = add i64 0, 0
  %st33 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st33
  %st34 = getelementptr i64, ptr %v45, i64 3
  store i64 %v48, ptr %st34
  %st35 = getelementptr i64, ptr %v45, i64 4
  store i64 %v48, ptr %st35
  %v49.p = getelementptr i64, ptr %v45, i64 0
  %v49 = load i64, ptr %v49.p
  %st36 = getelementptr i64, ptr %v0, i64 0
  store i64 %v49, ptr %st36
  %v50.p = getelementptr i64, ptr %v45, i64 1
  %v50 = load i64, ptr %v50.p
  %st37 = getelementptr i64, ptr %v0, i64 1
  store i64 %v50, ptr %st37
  %v51.p = getelementptr i64, ptr %v45, i64 2
  %v51 = load i64, ptr %v51.p
  %st38 = getelementptr i64, ptr %v0, i64 2
  store i64 %v51, ptr %st38
  %v52.p = getelementptr i64, ptr %v45, i64 3
  %v52 = load i64, ptr %v52.p
  %st39 = getelementptr i64, ptr %v0, i64 3
  store i64 %v52, ptr %st39
  %v53.p = getelementptr i64, ptr %v45, i64 4
  %v53 = load i64, ptr %v53.p
  %st40 = getelementptr i64, ptr %v0, i64 4
  store i64 %v53, ptr %st40
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v99, i64 0
  store i64 %v2, ptr %st41
  ret void
b13:
  %v54 = add i64 0, 125
  %v55.c = icmp eq i64 %v1, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b13 = icmp ne i64 %v55, 0
  br i1 %c.b13, label %b13.t43, label %b13.e44
b13.t43:
  br label %b14
b13.e44:
  br label %b15
b14:
  %v56 = getelementptr i64, ptr %s2, i64 0
  %v57 = add i64 0, 0
  %st44 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st44
  %st45 = getelementptr i64, ptr %v56, i64 1
  store i64 %v57, ptr %st45
  %v58 = add i64 0, 3
  %st46 = getelementptr i64, ptr %v56, i64 0
  store i64 %v58, ptr %st46
  %v59 = getelementptr i64, ptr %s1, i64 0
  %v60.p = getelementptr i64, ptr %v56, i64 0
  %v60 = load i64, ptr %v60.p
  %st47 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st47
  %v61.p = getelementptr i64, ptr %v56, i64 1
  %v61 = load i64, ptr %v61.p
  %st48 = getelementptr i64, ptr %v59, i64 1
  store i64 %v61, ptr %st48
  %v62 = add i64 0, 0
  %st49 = getelementptr i64, ptr %v59, i64 2
  store i64 %v62, ptr %st49
  %st50 = getelementptr i64, ptr %v59, i64 3
  store i64 %v62, ptr %st50
  %st51 = getelementptr i64, ptr %v59, i64 4
  store i64 %v62, ptr %st51
  %v63.p = getelementptr i64, ptr %v59, i64 0
  %v63 = load i64, ptr %v63.p
  %st52 = getelementptr i64, ptr %v0, i64 0
  store i64 %v63, ptr %st52
  %v64.p = getelementptr i64, ptr %v59, i64 1
  %v64 = load i64, ptr %v64.p
  %st53 = getelementptr i64, ptr %v0, i64 1
  store i64 %v64, ptr %st53
  %v65.p = getelementptr i64, ptr %v59, i64 2
  %v65 = load i64, ptr %v65.p
  %st54 = getelementptr i64, ptr %v0, i64 2
  store i64 %v65, ptr %st54
  %v66.p = getelementptr i64, ptr %v59, i64 3
  %v66 = load i64, ptr %v66.p
  %st55 = getelementptr i64, ptr %v0, i64 3
  store i64 %v66, ptr %st55
  %v67.p = getelementptr i64, ptr %v59, i64 4
  %v67 = load i64, ptr %v67.p
  %st56 = getelementptr i64, ptr %v0, i64 4
  store i64 %v67, ptr %st56
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v100, i64 0
  store i64 %v2, ptr %st57
  ret void
b15:
  br label %b16
b16:
  %v68 = add i64 0, 13
  %v69.c = icmp eq i64 %v1, %v68
  %v69 = zext i1 %v69.c to i64
  %c.b16 = icmp ne i64 %v69, 0
  br i1 %c.b16, label %b16.t59, label %b16.e60
b16.t59:
  br label %b18
b16.e60:
  br label %b17
b17:
  %v71 = add i64 0, 1
  %v72.c = icmp eq i64 %v1, %v71
  %v72 = zext i1 %v72.c to i64
  br label %b18
b18:
  %v70 = phi i64 [ %v69, %b16.t59 ], [ %v72, %b17 ]
  %c.b18 = icmp ne i64 %v70, 0
  br i1 %c.b18, label %b18.t61, label %b18.e62
b18.t61:
  br label %b19
b18.e62:
  br label %b20
b19:
  %v73 = getelementptr i64, ptr %s2, i64 0
  %v74 = add i64 0, 0
  %st62 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st62
  %st63 = getelementptr i64, ptr %v73, i64 1
  store i64 %v74, ptr %st63
  %v75 = add i64 0, 1
  %st64 = getelementptr i64, ptr %v73, i64 0
  store i64 %v75, ptr %st64
  %v76 = getelementptr i64, ptr %s1, i64 0
  %v77.p = getelementptr i64, ptr %v73, i64 0
  %v77 = load i64, ptr %v77.p
  %st65 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st65
  %v78.p = getelementptr i64, ptr %v73, i64 1
  %v78 = load i64, ptr %v78.p
  %st66 = getelementptr i64, ptr %v76, i64 1
  store i64 %v78, ptr %st66
  %v79 = add i64 0, 0
  %st67 = getelementptr i64, ptr %v76, i64 2
  store i64 %v79, ptr %st67
  %st68 = getelementptr i64, ptr %v76, i64 3
  store i64 %v79, ptr %st68
  %st69 = getelementptr i64, ptr %v76, i64 4
  store i64 %v79, ptr %st69
  %v80.p = getelementptr i64, ptr %v76, i64 0
  %v80 = load i64, ptr %v80.p
  %st70 = getelementptr i64, ptr %v0, i64 0
  store i64 %v80, ptr %st70
  %v81.p = getelementptr i64, ptr %v76, i64 1
  %v81 = load i64, ptr %v81.p
  %st71 = getelementptr i64, ptr %v0, i64 1
  store i64 %v81, ptr %st71
  %v82.p = getelementptr i64, ptr %v76, i64 2
  %v82 = load i64, ptr %v82.p
  %st72 = getelementptr i64, ptr %v0, i64 2
  store i64 %v82, ptr %st72
  %v83.p = getelementptr i64, ptr %v76, i64 3
  %v83 = load i64, ptr %v83.p
  %st73 = getelementptr i64, ptr %v0, i64 3
  store i64 %v83, ptr %st73
  %v84.p = getelementptr i64, ptr %v76, i64 4
  %v84 = load i64, ptr %v84.p
  %st74 = getelementptr i64, ptr %v0, i64 4
  store i64 %v84, ptr %st74
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %st75 = getelementptr i64, ptr %v101, i64 0
  store i64 %v2, ptr %st75
  ret void
b20:
  br label %b21
b21:
  %v85 = getelementptr i64, ptr %s2, i64 0
  %v86 = add i64 0, 0
  %st76 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st76
  %st77 = getelementptr i64, ptr %v85, i64 1
  store i64 %v86, ptr %st77
  %v87 = add i64 0, 5
  %st78 = getelementptr i64, ptr %v85, i64 0
  store i64 %v87, ptr %st78
  %st79 = getelementptr i64, ptr %v85, i64 1
  store i64 %v1, ptr %st79
  %v88 = getelementptr i64, ptr %s1, i64 0
  %v89.p = getelementptr i64, ptr %v85, i64 0
  %v89 = load i64, ptr %v89.p
  %st80 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st80
  %v90.p = getelementptr i64, ptr %v85, i64 1
  %v90 = load i64, ptr %v90.p
  %st81 = getelementptr i64, ptr %v88, i64 1
  store i64 %v90, ptr %st81
  %v91 = add i64 0, 0
  %st82 = getelementptr i64, ptr %v88, i64 2
  store i64 %v91, ptr %st82
  %st83 = getelementptr i64, ptr %v88, i64 3
  store i64 %v91, ptr %st83
  %st84 = getelementptr i64, ptr %v88, i64 4
  store i64 %v91, ptr %st84
  %v92.p = getelementptr i64, ptr %v88, i64 0
  %v92 = load i64, ptr %v92.p
  %st85 = getelementptr i64, ptr %v0, i64 0
  store i64 %v92, ptr %st85
  %v93.p = getelementptr i64, ptr %v88, i64 1
  %v93 = load i64, ptr %v93.p
  %st86 = getelementptr i64, ptr %v0, i64 1
  store i64 %v93, ptr %st86
  %v94.p = getelementptr i64, ptr %v88, i64 2
  %v94 = load i64, ptr %v94.p
  %st87 = getelementptr i64, ptr %v0, i64 2
  store i64 %v94, ptr %st87
  %v95.p = getelementptr i64, ptr %v88, i64 3
  %v95 = load i64, ptr %v95.p
  %st88 = getelementptr i64, ptr %v0, i64 3
  store i64 %v95, ptr %st88
  %v96.p = getelementptr i64, ptr %v88, i64 4
  %v96 = load i64, ptr %v96.p
  %st89 = getelementptr i64, ptr %v0, i64 4
  store i64 %v96, ptr %st89
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st90 = getelementptr i64, ptr %v102, i64 0
  store i64 %v2, ptr %st90
  ret void
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
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v38, i64 0
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
  %v14 = add i64 0, 110
  %v15 = sub i64 %v13, %v14
  %v16.c = icmp eq i64 %v1, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v17 = getelementptr i64, ptr %s0, i64 0
  %v18 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st3
  %st4 = getelementptr i64, ptr %v17, i64 1
  store i64 %v18, ptr %st4
  %v19 = add i64 0, 3
  %st5 = getelementptr i64, ptr %v17, i64 0
  store i64 %v19, ptr %st5
  %v20 = getelementptr i64, ptr %s1, i64 0
  %v21.p = getelementptr i64, ptr %v17, i64 0
  %v21 = load i64, ptr %v21.p
  %st6 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st6
  %v22.p = getelementptr i64, ptr %v17, i64 1
  %v22 = load i64, ptr %v22.p
  %st7 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st7
  %v23 = add i64 0, 0
  %st8 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st8
  %st9 = getelementptr i64, ptr %v20, i64 3
  store i64 %v23, ptr %st9
  %st10 = getelementptr i64, ptr %v20, i64 4
  store i64 %v23, ptr %st10
  %v24.p = getelementptr i64, ptr %v20, i64 0
  %v24 = load i64, ptr %v24.p
  %st11 = getelementptr i64, ptr %v0, i64 0
  store i64 %v24, ptr %st11
  %v25.p = getelementptr i64, ptr %v20, i64 1
  %v25 = load i64, ptr %v25.p
  %st12 = getelementptr i64, ptr %v0, i64 1
  store i64 %v25, ptr %st12
  %v26.p = getelementptr i64, ptr %v20, i64 2
  %v26 = load i64, ptr %v26.p
  %st13 = getelementptr i64, ptr %v0, i64 2
  store i64 %v26, ptr %st13
  %v27.p = getelementptr i64, ptr %v20, i64 3
  %v27 = load i64, ptr %v27.p
  %st14 = getelementptr i64, ptr %v0, i64 3
  store i64 %v27, ptr %st14
  %v28.p = getelementptr i64, ptr %v20, i64 4
  %v28 = load i64, ptr %v28.p
  %st15 = getelementptr i64, ptr %v0, i64 4
  store i64 %v28, ptr %st15
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v39 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v39, i64 0
  store i64 %v2, ptr %st16
  ret void
b2:
  br label %b3
b3:
  %v29 = getelementptr i64, ptr %s2, i64 0
  %v30 = add i64 0, 0
  %v31 = sub i64 %v30, %v1
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v32, i64 2571
  store i64 %v12, ptr %st17
  call void @"std/net.errOf"(ptr %v29, i64 %v31)
  %v33.p = getelementptr i64, ptr %v29, i64 0
  %v33 = load i64, ptr %v33.p
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v33, ptr %st18
  %v34.p = getelementptr i64, ptr %v29, i64 1
  %v34 = load i64, ptr %v34.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v34, ptr %st19
  %v35.p = getelementptr i64, ptr %v29, i64 2
  %v35 = load i64, ptr %v35.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v35, ptr %st20
  %v36.p = getelementptr i64, ptr %v29, i64 3
  %v36 = load i64, ptr %v36.p
  %st21 = getelementptr i64, ptr %v0, i64 3
  store i64 %v36, ptr %st21
  %v37.p = getelementptr i64, ptr %v29, i64 4
  %v37 = load i64, ptr %v37.p
  %st22 = getelementptr i64, ptr %v0, i64 4
  store i64 %v37, ptr %st22
  call void @"rt.err_relocate"(ptr %v0, i64 %v2)
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v40, i64 0
  store i64 %v2, ptr %st23
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
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v298, i64 0
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
  %st4 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st4
  %v18.p = getelementptr i64, ptr %v4, i64 1
  %v18 = load i64, ptr %v18.p
  %st5 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st5
  %v19.p = getelementptr i64, ptr %v4, i64 2
  %v19 = load i64, ptr %v19.p
  %st6 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st6
  %v20 = add i64 0, 2
  %v21 = add i64 0, 0
  %v22 = add i64 0, 0
  %v23 = add i64 0, 0
  %v24 = add i64 0, 4
  %v25 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v24)
  %v26 = add i64 0, 0
  %v27 = getelementptr i8, ptr %v25, i64 %v26
  %st7 = getelementptr i8, ptr %v27, i64 0
  %st7.b = trunc i64 %v20 to i8
  store i8 %st7.b, ptr %st7
  %v28 = add i64 0, 1
  %v29 = getelementptr i8, ptr %v25, i64 %v28
  %st8 = getelementptr i8, ptr %v29, i64 0
  %st8.b = trunc i64 %v21 to i8
  store i8 %st8.b, ptr %st8
  %v30 = add i64 0, 2
  %v31 = getelementptr i8, ptr %v25, i64 %v30
  %st9 = getelementptr i8, ptr %v31, i64 0
  %st9.b = trunc i64 %v22 to i8
  store i8 %st9.b, ptr %st9
  %v32 = add i64 0, 3
  %v33 = getelementptr i8, ptr %v25, i64 %v32
  %st10 = getelementptr i8, ptr %v33, i64 0
  %st10.b = trunc i64 %v23 to i8
  store i8 %st10.b, ptr %st10
  %v34 = add i64 0, 4
  %v35 = getelementptr i64, ptr %s2, i64 0
  %v36 = ptrtoint ptr %v25 to i64
  %st11 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st11
  %st12 = getelementptr i64, ptr %v35, i64 1
  store i64 %v34, ptr %st12
  %st13 = getelementptr i64, ptr %v35, i64 2
  store i64 %v15, ptr %st13
  %v37 = getelementptr i64, ptr %s3, i64 0
  %v38.p = getelementptr i64, ptr %v35, i64 0
  %v38 = load i64, ptr %v38.p
  %st14 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st14
  %v39.p = getelementptr i64, ptr %v35, i64 1
  %v39 = load i64, ptr %v39.p
  %st15 = getelementptr i64, ptr %v37, i64 1
  store i64 %v39, ptr %st15
  %v40.p = getelementptr i64, ptr %v35, i64 2
  %v40 = load i64, ptr %v40.p
  %st16 = getelementptr i64, ptr %v37, i64 2
  store i64 %v40, ptr %st16
  %v41 = add i64 0, 0
  %v42 = getelementptr i64, ptr %s4, i64 0
  %st17 = getelementptr i64, ptr %v42, i64 0
  store i64 %v41, ptr %st17
  %v43 = add i64 0, 0
  %v44 = getelementptr i64, ptr %s5, i64 0
  %st18 = getelementptr i64, ptr %v44, i64 0
  store i64 %v43, ptr %st18
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s6, i64 0
  %st19 = getelementptr i64, ptr %v46, i64 0
  store i64 %v45, ptr %st19
  %v47 = add i64 0, 0
  %v48 = getelementptr i64, ptr %s7, i64 0
  %st20 = getelementptr i64, ptr %v48, i64 0
  store i64 %v47, ptr %st20
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v299, i64 0
  %v49 = load i64, ptr %v49.p
  br label %b1
b1:
  %v300 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v300, i64 0
  store i64 %v49, ptr %st21
  %v50.p = getelementptr i64, ptr %v48, i64 0
  %v50 = load i64, ptr %v50.p
  %v51.p = getelementptr i64, ptr %v16, i64 1
  %v51 = load i64, ptr %v51.p
  %v52.c = icmp slt i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b1 = icmp ne i64 %v52, 0
  br i1 %c.b1, label %b1.t23, label %b1.e24
b1.t23:
  br label %b2
b1.e24:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %v53.p = getelementptr i64, ptr %v301, i64 0
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v48, i64 0
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v16, i64 1
  %v55 = load i64, ptr %v55.p
  %v56.c = icmp uge i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b2 = icmp ne i64 %v56, 0
  br i1 %c.b2, label %b2.t25, label %b2.e26
b2.t25:
  br label %b4
b2.e26:
  br label %b5
b3:
  %v302 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v302, i64 0
  store i64 %v49, ptr %st26
  %v172.p = getelementptr i64, ptr %v46, i64 0
  %v172 = load i64, ptr %v172.p
  %v173 = add i64 0, 4
  %v174.c = icmp ne i64 %v172, %v173
  %v174 = zext i1 %v174.c to i64
  %c.b3 = icmp ne i64 %v174, 0
  br i1 %c.b3, label %b3.t28, label %b3.e29
b3.t28:
  br label %b34
b3.e29:
  br label %b33
b4:
  %v57 = add i64 0, 5
  call void @"rt.panic"(i64 %v57)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v58.p = getelementptr i64, ptr %v16, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = inttoptr i64 %v58 to ptr
  %v60 = getelementptr i8, ptr %v59, i64 %v54
  %v61.p = getelementptr i8, ptr %v60, i64 0
  %v61.b = load i8, ptr %v61.p
  %v61 = zext i8 %v61.b to i64
  %v62 = add i64 0, 48
  %v63.c = icmp sge i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b5 = icmp ne i64 %v63, 0
  br i1 %c.b5, label %b5.t30, label %b5.e31
b5.t30:
  br label %b6
b5.e31:
  br label %b7
b6:
  %v65 = add i64 0, 57
  %v66.c = icmp sle i64 %v61, %v65
  %v66 = zext i1 %v66.c to i64
  br label %b7
b7:
  %v64 = phi i64 [ %v63, %b5.e31 ], [ %v66, %b6 ]
  %c.b7 = icmp ne i64 %v64, 0
  br i1 %c.b7, label %b7.t32, label %b7.e33
b7.t32:
  br label %b8
b7.e33:
  br label %b9
b8:
  %v67 = add i64 0, 1
  %v68 = add i64 %v5, %v67
  %v69.p = getelementptr i64, ptr %v42, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 10
  %v71 = mul i64 %v69, %v70
  %v72 = add i64 %v71, %v61
  %v73 = add i64 0, 48
  %v74 = sub i64 %v72, %v73
  %st33 = getelementptr i64, ptr %v42, i64 0
  store i64 %v74, ptr %st33
  %v75 = add i64 0, 1
  %v76.p = getelementptr i64, ptr %v44, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = add i64 %v76, %v75
  %st34 = getelementptr i64, ptr %v44, i64 0
  store i64 %v77, ptr %st34
  %v78.p = getelementptr i64, ptr %v42, i64 0
  %v78 = load i64, ptr %v78.p
  %v79 = add i64 0, 65535
  %v80.c = icmp sgt i64 %v78, %v79
  %v80 = zext i1 %v80.c to i64
  %c.b8 = icmp ne i64 %v80, 0
  br i1 %c.b8, label %b8.t36, label %b8.e37
b8.t36:
  br label %b10
b8.e37:
  br label %b11
b9:
  %v90 = add i64 0, 46
  %v91.c = icmp eq i64 %v61, %v90
  %v91 = zext i1 %v91.c to i64
  %c.b9 = icmp ne i64 %v91, 0
  br i1 %c.b9, label %b9.t38, label %b9.e39
b9.t38:
  br label %b13
b9.e39:
  br label %b14
b10:
  %v303 = getelementptr i64, ptr @"rt.meta", i64 0
  %v81.p = getelementptr i64, ptr %v303, i64 0
  %v81 = load i64, ptr %v81.p
  %v82 = add i64 0, 0
  %v83 = call ptr @"rt.region_alloc8"(i64 %v81, i64 %v82)
  %v84 = add i64 0, 0
  %v85 = getelementptr i64, ptr %s2, i64 0
  %v86 = ptrtoint ptr %v83 to i64
  %st39 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st39
  %st40 = getelementptr i64, ptr %v85, i64 1
  store i64 %v84, ptr %st40
  %st41 = getelementptr i64, ptr %v85, i64 2
  store i64 %v81, ptr %st41
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %st42 = getelementptr i64, ptr %v0, i64 0
  store i64 %v87, ptr %st42
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %st43 = getelementptr i64, ptr %v0, i64 1
  store i64 %v88, ptr %st43
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %st44 = getelementptr i64, ptr %v0, i64 2
  store i64 %v89, ptr %st44
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v304 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v304, i64 0
  store i64 %v5, ptr %st45
  ret void
b11:
  br label %b12
b12:
  br label %b32
b13:
  %v93.p = getelementptr i64, ptr %v46, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 3
  %v95.c = icmp slt i64 %v93, %v94
  %v95 = zext i1 %v95.c to i64
  br label %b14
b14:
  %v92 = phi i64 [ %v91, %b9.e39 ], [ %v95, %b13 ]
  %c.b14 = icmp ne i64 %v92, 0
  br i1 %c.b14, label %b14.t47, label %b14.e48
b14.t47:
  br label %b16
b14.e48:
  br label %b15
b15:
  %v97 = add i64 0, 58
  %v98.c = icmp eq i64 %v61, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b15 = icmp ne i64 %v98, 0
  br i1 %c.b15, label %b15.t49, label %b15.e50
b15.t49:
  br label %b17
b15.e50:
  br label %b18
b16:
  %v96 = phi i64 [ %v92, %b14.t47 ], [ %v99, %b18 ]
  %c.b16 = icmp ne i64 %v96, 0
  br i1 %c.b16, label %b16.t51, label %b16.e52
b16.t51:
  br label %b19
b16.e52:
  br label %b20
b17:
  %v100.p = getelementptr i64, ptr %v46, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 3
  %v102.c = icmp eq i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  br label %b18
b18:
  %v99 = phi i64 [ %v98, %b15.e50 ], [ %v102, %b17 ]
  br label %b16
b19:
  %v103.p = getelementptr i64, ptr %v44, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105.c = icmp eq i64 %v103, %v104
  %v105 = zext i1 %v105.c to i64
  %c.b19 = icmp ne i64 %v105, 0
  br i1 %c.b19, label %b19.t53, label %b19.e54
b19.t53:
  br label %b22
b19.e54:
  br label %b21
b20:
  %v305 = getelementptr i64, ptr @"rt.meta", i64 0
  %v160.p = getelementptr i64, ptr %v305, i64 0
  %v160 = load i64, ptr %v160.p
  %v161 = add i64 0, 0
  %v162 = call ptr @"rt.region_alloc8"(i64 %v160, i64 %v161)
  %v163 = add i64 0, 0
  %v164 = getelementptr i64, ptr %s8, i64 0
  %v165 = ptrtoint ptr %v162 to i64
  %st54 = getelementptr i64, ptr %v164, i64 0
  store i64 %v165, ptr %st54
  %st55 = getelementptr i64, ptr %v164, i64 1
  store i64 %v163, ptr %st55
  %st56 = getelementptr i64, ptr %v164, i64 2
  store i64 %v160, ptr %st56
  %v166.p = getelementptr i64, ptr %v164, i64 0
  %v166 = load i64, ptr %v166.p
  %st57 = getelementptr i64, ptr %v0, i64 0
  store i64 %v166, ptr %st57
  %v167.p = getelementptr i64, ptr %v164, i64 1
  %v167 = load i64, ptr %v167.p
  %st58 = getelementptr i64, ptr %v0, i64 1
  store i64 %v167, ptr %st58
  %v168.p = getelementptr i64, ptr %v164, i64 2
  %v168 = load i64, ptr %v168.p
  %st59 = getelementptr i64, ptr %v0, i64 2
  store i64 %v168, ptr %st59
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v306 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v306, i64 0
  store i64 %v5, ptr %st60
  ret void
b21:
  %v107.p = getelementptr i64, ptr %v42, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 0, 255
  %v109.c = icmp sgt i64 %v107, %v108
  %v109 = zext i1 %v109.c to i64
  br label %b22
b22:
  %v106 = phi i64 [ %v105, %b19.t53 ], [ %v109, %b21 ]
  %c.b22 = icmp ne i64 %v106, 0
  br i1 %c.b22, label %b22.t62, label %b22.e63
b22.t62:
  br label %b23
b22.e63:
  br label %b24
b23:
  %v307 = getelementptr i64, ptr @"rt.meta", i64 0
  %v110.p = getelementptr i64, ptr %v307, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = add i64 0, 0
  %v112 = call ptr @"rt.region_alloc8"(i64 %v110, i64 %v111)
  %v113 = add i64 0, 0
  %v114 = getelementptr i64, ptr %s2, i64 0
  %v115 = ptrtoint ptr %v112 to i64
  %st63 = getelementptr i64, ptr %v114, i64 0
  store i64 %v115, ptr %st63
  %st64 = getelementptr i64, ptr %v114, i64 1
  store i64 %v113, ptr %st64
  %st65 = getelementptr i64, ptr %v114, i64 2
  store i64 %v110, ptr %st65
  %v116.p = getelementptr i64, ptr %v114, i64 0
  %v116 = load i64, ptr %v116.p
  %st66 = getelementptr i64, ptr %v0, i64 0
  store i64 %v116, ptr %st66
  %v117.p = getelementptr i64, ptr %v114, i64 1
  %v117 = load i64, ptr %v117.p
  %st67 = getelementptr i64, ptr %v0, i64 1
  store i64 %v117, ptr %st67
  %v118.p = getelementptr i64, ptr %v114, i64 2
  %v118 = load i64, ptr %v118.p
  %st68 = getelementptr i64, ptr %v0, i64 2
  store i64 %v118, ptr %st68
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v308 = getelementptr i64, ptr @"rt.meta", i64 0
  %st69 = getelementptr i64, ptr %v308, i64 0
  store i64 %v5, ptr %st69
  ret void
b24:
  br label %b25
b25:
  %v119 = add i64 0, 1
  %v120 = add i64 %v5, %v119
  %v121 = getelementptr i64, ptr %s2, i64 0
  %v122.p = getelementptr i64, ptr %v37, i64 0
  %v122 = load i64, ptr %v122.p
  %st70 = getelementptr i64, ptr %v121, i64 0
  store i64 %v122, ptr %st70
  %v123.p = getelementptr i64, ptr %v37, i64 1
  %v123 = load i64, ptr %v123.p
  %st71 = getelementptr i64, ptr %v121, i64 1
  store i64 %v123, ptr %st71
  %v124.p = getelementptr i64, ptr %v37, i64 2
  %v124 = load i64, ptr %v124.p
  %st72 = getelementptr i64, ptr %v121, i64 2
  store i64 %v124, ptr %st72
  %v125.p = getelementptr i64, ptr %v42, i64 0
  %v125 = load i64, ptr %v125.p
  %v126 = add i64 0, 256
  %v127.c = icmp uge i64 %v125, %v126
  %v127 = zext i1 %v127.c to i64
  %c.b25 = icmp ne i64 %v127, 0
  br i1 %c.b25, label %b25.t74, label %b25.e75
b25.t74:
  br label %b26
b25.e75:
  br label %b27
b26:
  %v128 = add i64 0, 6
  call void @"rt.panic"(i64 %v128)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v129.p = getelementptr i64, ptr %v121, i64 2
  %v129 = load i64, ptr %v129.p
  %v130.p = getelementptr i64, ptr %v121, i64 0
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v121, i64 1
  %v131 = load i64, ptr %v131.p
  %v134 = add i64 %v130, %v131
  %v135 = call i64 @"rt.tip8"(i64 %v129, i64 %v134)
  %v136 = add i64 0, 0
  %v137.c = icmp ne i64 %v135, %v136
  %v137 = zext i1 %v137.c to i64
  %c.b27 = icmp ne i64 %v137, 0
  br i1 %c.b27, label %b27.t76, label %b27.e77
b27.t76:
  br label %b30
b27.e77:
  br label %b29
b28:
  %v132 = phi ptr [ %v141, %b29 ], [ %v138, %b30 ]
  %v133 = phi ptr [ %v142, %b29 ], [ %v139, %b30 ]
  %st77 = getelementptr i8, ptr %v133, i64 0
  %st77.b = trunc i64 %v125 to i8
  store i8 %st77.b, ptr %st77
  %v143.p = getelementptr i64, ptr %v121, i64 1
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 1
  %v145 = add i64 %v143, %v144
  %v146 = getelementptr i64, ptr %s8, i64 0
  %v147 = ptrtoint ptr %v132 to i64
  %st78 = getelementptr i64, ptr %v146, i64 0
  store i64 %v147, ptr %st78
  %st79 = getelementptr i64, ptr %v146, i64 1
  store i64 %v145, ptr %st79
  %st80 = getelementptr i64, ptr %v146, i64 2
  store i64 %v129, ptr %st80
  %v148.p = getelementptr i64, ptr %v146, i64 0
  %v148 = load i64, ptr %v148.p
  %st81 = getelementptr i64, ptr %v37, i64 0
  store i64 %v148, ptr %st81
  %v149.p = getelementptr i64, ptr %v146, i64 1
  %v149 = load i64, ptr %v149.p
  %st82 = getelementptr i64, ptr %v37, i64 1
  store i64 %v149, ptr %st82
  %v150.p = getelementptr i64, ptr %v146, i64 2
  %v150 = load i64, ptr %v150.p
  %st83 = getelementptr i64, ptr %v37, i64 2
  store i64 %v150, ptr %st83
  %v151 = add i64 0, 1
  %v152.p = getelementptr i64, ptr %v46, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = add i64 %v152, %v151
  %st84 = getelementptr i64, ptr %v46, i64 0
  store i64 %v153, ptr %st84
  %v154 = add i64 0, 1
  %v155 = add i64 %v5, %v154
  %v156 = add i64 0, 0
  %st85 = getelementptr i64, ptr %v42, i64 0
  store i64 %v156, ptr %st85
  %v157 = add i64 0, 1
  %v158 = add i64 %v5, %v157
  %v159 = add i64 0, 0
  %st86 = getelementptr i64, ptr %v44, i64 0
  store i64 %v159, ptr %st86
  br label %b31
b29:
  %v140 = add i64 0, 1
  %v141 = call ptr @"rt.slice_grow8"(i64 %v130, i64 %v131, i64 %v129, i64 %v140)
  %v142 = getelementptr i8, ptr %v141, i64 %v131
  br label %b28
b30:
  %v138 = inttoptr i64 %v130 to ptr
  %v139 = getelementptr i8, ptr %v138, i64 %v131
  br label %b28
b31:
  br label %b32
b32:
  %v169 = add i64 0, 1
  %v170.p = getelementptr i64, ptr %v48, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 %v170, %v169
  %st87 = getelementptr i64, ptr %v48, i64 0
  store i64 %v171, ptr %st87
  br label %b1
b33:
  %v176.p = getelementptr i64, ptr %v44, i64 0
  %v176 = load i64, ptr %v176.p
  %v177 = add i64 0, 0
  %v178.c = icmp eq i64 %v176, %v177
  %v178 = zext i1 %v178.c to i64
  br label %b34
b34:
  %v175 = phi i64 [ %v174, %b3.t28 ], [ %v178, %b33 ]
  %c.b34 = icmp ne i64 %v175, 0
  br i1 %c.b34, label %b34.t89, label %b34.e90
b34.t89:
  br label %b35
b34.e90:
  br label %b36
b35:
  %v179 = add i64 0, 0
  %v180 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v179)
  %v181 = add i64 0, 0
  %v182 = getelementptr i64, ptr %s8, i64 0
  %v183 = ptrtoint ptr %v180 to i64
  %st90 = getelementptr i64, ptr %v182, i64 0
  store i64 %v183, ptr %st90
  %st91 = getelementptr i64, ptr %v182, i64 1
  store i64 %v181, ptr %st91
  %st92 = getelementptr i64, ptr %v182, i64 2
  store i64 %v15, ptr %st92
  %v184.p = getelementptr i64, ptr %v182, i64 0
  %v184 = load i64, ptr %v184.p
  %st93 = getelementptr i64, ptr %v0, i64 0
  store i64 %v184, ptr %st93
  %v185.p = getelementptr i64, ptr %v182, i64 1
  %v185 = load i64, ptr %v185.p
  %st94 = getelementptr i64, ptr %v0, i64 1
  store i64 %v185, ptr %st94
  %v186.p = getelementptr i64, ptr %v182, i64 2
  %v186 = load i64, ptr %v186.p
  %st95 = getelementptr i64, ptr %v0, i64 2
  store i64 %v186, ptr %st95
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v309 = getelementptr i64, ptr @"rt.meta", i64 0
  %st96 = getelementptr i64, ptr %v309, i64 0
  store i64 %v5, ptr %st96
  ret void
b36:
  br label %b37
b37:
  %v187 = add i64 0, 2
  %v188.p = getelementptr i64, ptr %v42, i64 0
  %v188 = load i64, ptr %v188.p
  %v189 = add i64 0, 256
  %v190 = sdiv i64 %v188, %v189
  %v191 = add i64 0, 256
  %v192.c = icmp uge i64 %v190, %v191
  %v192 = zext i1 %v192.c to i64
  %c.b37 = icmp ne i64 %v192, 0
  br i1 %c.b37, label %b37.t98, label %b37.e99
b37.t98:
  br label %b38
b37.e99:
  br label %b39
b38:
  %v193 = add i64 0, 7
  call void @"rt.panic"(i64 %v193)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b39:
  %v194.p = getelementptr i64, ptr %v37, i64 1
  %v194 = load i64, ptr %v194.p
  %v195.c = icmp uge i64 %v187, %v194
  %v195 = zext i1 %v195.c to i64
  %c.b39 = icmp ne i64 %v195, 0
  br i1 %c.b39, label %b39.t100, label %b39.e101
b39.t100:
  br label %b40
b39.e101:
  br label %b41
b40:
  %v196 = add i64 0, 8
  call void @"rt.panic"(i64 %v196)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b41:
  %v197.p = getelementptr i64, ptr %v37, i64 0
  %v197 = load i64, ptr %v197.p
  %v198 = inttoptr i64 %v197 to ptr
  %v199 = getelementptr i8, ptr %v198, i64 %v187
  %st101 = getelementptr i8, ptr %v199, i64 0
  %st101.b = trunc i64 %v190 to i8
  store i8 %st101.b, ptr %st101
  %v200 = add i64 0, 3
  %v201.p = getelementptr i64, ptr %v42, i64 0
  %v201 = load i64, ptr %v201.p
  %v202 = add i64 0, 256
  %v203 = srem i64 %v201, %v202
  %v204 = add i64 0, 256
  %v205.c = icmp uge i64 %v203, %v204
  %v205 = zext i1 %v205.c to i64
  %c.b41 = icmp ne i64 %v205, 0
  br i1 %c.b41, label %b41.t103, label %b41.e104
b41.t103:
  br label %b42
b41.e104:
  br label %b43
b42:
  %v206 = add i64 0, 9
  call void @"rt.panic"(i64 %v206)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b43:
  %v207.p = getelementptr i64, ptr %v37, i64 1
  %v207 = load i64, ptr %v207.p
  %v208.c = icmp uge i64 %v200, %v207
  %v208 = zext i1 %v208.c to i64
  %c.b43 = icmp ne i64 %v208, 0
  br i1 %c.b43, label %b43.t105, label %b43.e106
b43.t105:
  br label %b44
b43.e106:
  br label %b45
b44:
  %v209 = add i64 0, 10
  call void @"rt.panic"(i64 %v209)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b45:
  %v210.p = getelementptr i64, ptr %v37, i64 0
  %v210 = load i64, ptr %v210.p
  %v211 = inttoptr i64 %v210 to ptr
  %v212 = getelementptr i8, ptr %v211, i64 %v200
  %st106 = getelementptr i8, ptr %v212, i64 0
  %st106.b = trunc i64 %v203 to i8
  store i8 %st106.b, ptr %st106
  %v213 = add i64 0, 0
  %v214 = getelementptr i64, ptr %s9, i64 0
  %st107 = getelementptr i64, ptr %v214, i64 0
  store i64 %v213, ptr %st107
  %v215 = add i64 0, 0
  %v216 = add i64 0, 8
  %v217.p = getelementptr i64, ptr %v214, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = sub i64 %v216, %v217
  %v219 = add i64 0, 0
  %v220.c = icmp sle i64 %v218, %v219
  %v220 = zext i1 %v220.c to i64
  %c.b45 = icmp ne i64 %v220, 0
  br i1 %c.b45, label %b45.t109, label %b45.e110
b45.t109:
  br label %b46
b45.e110:
  br label %b47
b46:
  %v295.p = getelementptr i64, ptr %v37, i64 0
  %v295 = load i64, ptr %v295.p
  %st110 = getelementptr i64, ptr %v0, i64 0
  store i64 %v295, ptr %st110
  %v296.p = getelementptr i64, ptr %v37, i64 1
  %v296 = load i64, ptr %v296.p
  %st111 = getelementptr i64, ptr %v0, i64 1
  store i64 %v296, ptr %st111
  %v297.p = getelementptr i64, ptr %v37, i64 2
  %v297 = load i64, ptr %v297.p
  %st112 = getelementptr i64, ptr %v0, i64 2
  store i64 %v297, ptr %st112
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v310 = getelementptr i64, ptr @"rt.meta", i64 0
  %st113 = getelementptr i64, ptr %v310, i64 0
  store i64 %v5, ptr %st113
  ret void
b47:
  %v221 = getelementptr i64, ptr %s8, i64 0
  %v222.p = getelementptr i64, ptr %v37, i64 0
  %v222 = load i64, ptr %v222.p
  %st114 = getelementptr i64, ptr %v221, i64 0
  store i64 %v222, ptr %st114
  %v223.p = getelementptr i64, ptr %v37, i64 1
  %v223 = load i64, ptr %v223.p
  %st115 = getelementptr i64, ptr %v221, i64 1
  store i64 %v223, ptr %st115
  %v224.p = getelementptr i64, ptr %v37, i64 2
  %v224 = load i64, ptr %v224.p
  %st116 = getelementptr i64, ptr %v221, i64 2
  store i64 %v224, ptr %st116
  %v225.p = getelementptr i64, ptr %v221, i64 2
  %v225 = load i64, ptr %v225.p
  %v226.p = getelementptr i64, ptr %v221, i64 0
  %v226 = load i64, ptr %v226.p
  %v227.p = getelementptr i64, ptr %v221, i64 1
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 %v226, %v227
  %v231 = getelementptr i64, ptr @"rt.btip", i64 0
  %v232 = getelementptr i64, ptr %v231, i64 %v225
  %v233.p = getelementptr i64, ptr %v232, i64 0
  %v233 = load i64, ptr %v233.p
  %v234.c = icmp eq i64 %v233, %v228
  %v234 = zext i1 %v234.c to i64
  %c.b47 = icmp ne i64 %v234, 0
  br i1 %c.b47, label %b47.t118, label %b47.e119
b47.t118:
  br label %b51
b47.e119:
  br label %b49
b48:
  %v229 = phi ptr [ %v264, %b49 ], [ %v261, %b50 ]
  %v230 = phi ptr [ %v266, %b49 ], [ %v262, %b50 ]
  %v267 = add i64 0, 255
  %v268 = and i64 %v215, %v267
  %v269 = add i64 0, 72340172838076673
  %v270 = mul i64 %v268, %v269
  %v271 = add i64 0, 3
  %v272.n = and i64 %v271, 63
  %v272 = ashr i64 %v218, %v272.n
  %v274 = add i64 0, 0
  br label %b57
b49:
  %v263 = add i64 %v227, %v218
  %v264 = call ptr @"rt.region_alloc8"(i64 %v225, i64 %v263)
  %v265 = inttoptr i64 %v226 to ptr
  call void @"rt.copy8"(ptr %v264, ptr %v265, i64 %v227)
  %v266 = getelementptr i8, ptr %v264, i64 %v227
  br label %b48
b50:
  %v261 = inttoptr i64 %v226 to ptr
  %v262 = getelementptr i8, ptr %v261, i64 %v227
  br label %b48
b51:
  %v235 = add i64 0, 7
  %v236 = add i64 %v228, %v235
  %v237 = add i64 0, -8
  %v238 = and i64 %v236, %v237
  %v239 = add i64 %v228, %v218
  %v240 = add i64 0, 7
  %v241 = add i64 %v239, %v240
  %v242 = add i64 0, -8
  %v243 = and i64 %v241, %v242
  %v244 = getelementptr i64, ptr @"rt.meta", i64 0
  %v245 = getelementptr i64, ptr %v244, i64 %v225
  %v246.p = getelementptr i64, ptr %v245, i64 1
  %v246 = load i64, ptr %v246.p
  %v247.c = icmp sle i64 %v239, %v238
  %v247 = zext i1 %v247.c to i64
  %v248.c = icmp eq i64 %v246, %v238
  %v248 = zext i1 %v248.c to i64
  %v249 = or i64 %v247, %v248
  %v250 = add i64 0, 0
  %v251.c = icmp ne i64 %v249, %v250
  %v251 = zext i1 %v251.c to i64
  %c.b51 = icmp ne i64 %v251, 0
  br i1 %c.b51, label %b51.t120, label %b51.e121
b51.t120:
  br label %b52
b51.e121:
  br label %b49
b52:
  %v252.c = icmp sgt i64 %v243, %v246
  %v252 = zext i1 %v252.c to i64
  %c.b52 = icmp ne i64 %v252, 0
  br i1 %c.b52, label %b52.t122, label %b52.e123
b52.t122:
  br label %b53
b52.e123:
  br label %b54
b53:
  %v253.p = getelementptr i64, ptr %v244, i64 1029
  %v253 = load i64, ptr %v253.p
  %v254 = add i64 0, 1
  %v255 = add i64 %v225, %v254
  %v256.p = getelementptr i64, ptr %v244, i64 1030
  %v256 = load i64, ptr %v256.p
  %v257 = mul i64 %v255, %v256
  %v258 = add i64 %v253, %v257
  %v259.c = icmp sgt i64 %v243, %v258
  %v259 = zext i1 %v259.c to i64
  %c.b53 = icmp ne i64 %v259, 0
  br i1 %c.b53, label %b53.t124, label %b53.e125
b53.t124:
  br label %b55
b53.e125:
  br label %b56
b54:
  %st125 = getelementptr i64, ptr %v232, i64 0
  store i64 %v239, ptr %st125
  br label %b50
b55:
  %v260 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v260)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b56:
  %st126 = getelementptr i64, ptr %v245, i64 1
  store i64 %v243, ptr %st126
  br label %b54
b57:
  %v273 = phi i64 [ %v274, %b48 ], [ %v280, %b58 ]
  %v275.c = icmp slt i64 %v273, %v272
  %v275 = zext i1 %v275.c to i64
  %c.b57 = icmp ne i64 %v275, 0
  br i1 %c.b57, label %b57.t128, label %b57.e129
b57.t128:
  br label %b58
b57.e129:
  br label %b59
b58:
  %v276 = add i64 0, 3
  %v277.n = and i64 %v276, 63
  %v277 = shl i64 %v273, %v277.n
  %v278 = getelementptr i8, ptr %v230, i64 %v277
  %st129 = getelementptr i64, ptr %v278, i64 0
  store i64 %v270, ptr %st129, align 1
  %v279 = add i64 0, 1
  %v280 = add i64 %v273, %v279
  br label %b57
b59:
  %v282 = add i64 0, 3
  %v283.n = and i64 %v282, 63
  %v283 = shl i64 %v272, %v283.n
  br label %b60
b60:
  %v281 = phi i64 [ %v283, %b59 ], [ %v287, %b61 ]
  %v284.c = icmp slt i64 %v281, %v218
  %v284 = zext i1 %v284.c to i64
  %c.b60 = icmp ne i64 %v284, 0
  br i1 %c.b60, label %b60.t131, label %b60.e132
b60.t131:
  br label %b61
b60.e132:
  br label %b62
b61:
  %v285 = getelementptr i8, ptr %v230, i64 %v281
  %st132 = getelementptr i8, ptr %v285, i64 0
  %st132.b = trunc i64 %v215 to i8
  store i8 %st132.b, ptr %st132
  %v286 = add i64 0, 1
  %v287 = add i64 %v281, %v286
  br label %b60
b62:
  %v288.p = getelementptr i64, ptr %v221, i64 1
  %v288 = load i64, ptr %v288.p
  %v289 = add i64 %v288, %v218
  %v290 = getelementptr i64, ptr %s2, i64 0
  %v291 = ptrtoint ptr %v229 to i64
  %st133 = getelementptr i64, ptr %v290, i64 0
  store i64 %v291, ptr %st133
  %st134 = getelementptr i64, ptr %v290, i64 1
  store i64 %v289, ptr %st134
  %st135 = getelementptr i64, ptr %v290, i64 2
  store i64 %v225, ptr %st135
  %v292.p = getelementptr i64, ptr %v290, i64 0
  %v292 = load i64, ptr %v292.p
  %st136 = getelementptr i64, ptr %v37, i64 0
  store i64 %v292, ptr %st136
  %v293.p = getelementptr i64, ptr %v290, i64 1
  %v293 = load i64, ptr %v293.p
  %st137 = getelementptr i64, ptr %v37, i64 1
  store i64 %v293, ptr %st137
  %v294.p = getelementptr i64, ptr %v290, i64 2
  %v294 = load i64, ptr %v294.p
  %st138 = getelementptr i64, ptr %v37, i64 2
  store i64 %v294, ptr %st138
  %st139 = getelementptr i64, ptr %v214, i64 0
  store i64 %v216, ptr %st139
  br label %b46
}

define internal i64 @"std/net.listenFd"(i64 %v0, i64 %v1, i64 %v2) #0 {
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
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v3, i64 2
  store i64 %v2, ptr %st2
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v92, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5 = add i64 0, 41
  %v6 = add i64 0, 2
  %v7 = add i64 0, 526337
  %v8 = add i64 0, 0
  %v9 = add i64 0, 0
  %v10 = add i64 0, 0
  %v11 = add i64 0, 0
  %v12 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11)
  %v13 = add i64 0, 0
  %v14.c = icmp slt i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v93, i64 0
  store i64 %v4, ptr %st5
  ret i64 %v12
b2:
  br label %b3
b3:
  %v15 = add i64 0, 1
  %v16 = add i64 0, 0
  %v17 = add i64 0, 0
  %v18 = add i64 0, 0
  %v19 = add i64 0, 4
  %v20 = call ptr @"rt.region_alloc8"(i64 %v4, i64 %v19)
  %v21 = add i64 0, 0
  %v22 = getelementptr i8, ptr %v20, i64 %v21
  %st6 = getelementptr i8, ptr %v22, i64 0
  %st6.b = trunc i64 %v15 to i8
  store i8 %st6.b, ptr %st6
  %v23 = add i64 0, 1
  %v24 = getelementptr i8, ptr %v20, i64 %v23
  %st7 = getelementptr i8, ptr %v24, i64 0
  %st7.b = trunc i64 %v16 to i8
  store i8 %st7.b, ptr %st7
  %v25 = add i64 0, 2
  %v26 = getelementptr i8, ptr %v20, i64 %v25
  %st8 = getelementptr i8, ptr %v26, i64 0
  %st8.b = trunc i64 %v17 to i8
  store i8 %st8.b, ptr %st8
  %v27 = add i64 0, 3
  %v28 = getelementptr i8, ptr %v20, i64 %v27
  %st9 = getelementptr i8, ptr %v28, i64 0
  %st9.b = trunc i64 %v18 to i8
  store i8 %st9.b, ptr %st9
  %v29 = add i64 0, 4
  %v30 = getelementptr i64, ptr %s1, i64 0
  %v31 = ptrtoint ptr %v20 to i64
  %st10 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st10
  %st11 = getelementptr i64, ptr %v30, i64 1
  store i64 %v29, ptr %st11
  %st12 = getelementptr i64, ptr %v30, i64 2
  store i64 %v4, ptr %st12
  %v32 = getelementptr i64, ptr %s2, i64 0
  %v33.p = getelementptr i64, ptr %v30, i64 0
  %v33 = load i64, ptr %v33.p
  %st13 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st13
  %v34.p = getelementptr i64, ptr %v30, i64 1
  %v34 = load i64, ptr %v34.p
  %st14 = getelementptr i64, ptr %v32, i64 1
  store i64 %v34, ptr %st14
  %v35.p = getelementptr i64, ptr %v30, i64 2
  %v35 = load i64, ptr %v35.p
  %st15 = getelementptr i64, ptr %v32, i64 2
  store i64 %v35, ptr %st15
  %v36 = add i64 0, 54
  %v37 = add i64 0, 1
  %v38 = add i64 0, 2
  %v39.p = getelementptr i64, ptr %v32, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 4
  %v41 = add i64 0, 0
  %v42 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v36, i64 %v12, i64 %v37, i64 %v38, i64 %v39, i64 %v40, i64 %v41)
  %v43 = add i64 0, 0
  %v44.c = icmp slt i64 %v42, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b3 = icmp ne i64 %v44, 0
  br i1 %c.b3, label %b3.t17, label %b3.e18
b3.t17:
  br label %b4
b3.e18:
  br label %b5
b4:
  br label %b6
b5:
  %v45 = add i64 0, 54
  %v46 = add i64 0, 1
  %v47 = add i64 0, 15
  %v48.p = getelementptr i64, ptr %v32, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 4
  %v50 = add i64 0, 0
  %v51 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v45, i64 %v12, i64 %v46, i64 %v47, i64 %v48, i64 %v49, i64 %v50)
  br label %b6
b6:
  %v52 = phi i64 [ %v42, %b4 ], [ %v51, %b5 ]
  %v53 = add i64 0, 0
  %v54.c = icmp slt i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b6 = icmp ne i64 %v54, 0
  br i1 %c.b6, label %b6.t19, label %b6.e20
b6.t19:
  br label %b7
b6.e20:
  br label %b8
b7:
  br label %b9
b8:
  %v55 = add i64 0, 54
  %v56 = add i64 0, 6
  %v57 = add i64 0, 1
  %v58.p = getelementptr i64, ptr %v32, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 4
  %v60 = add i64 0, 0
  %v61 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v55, i64 %v12, i64 %v56, i64 %v57, i64 %v58, i64 %v59, i64 %v60)
  br label %b9
b9:
  %v62 = phi i64 [ %v52, %b7 ], [ %v61, %b8 ]
  %v63 = add i64 0, 0
  %v64.c = icmp slt i64 %v62, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b9 = icmp ne i64 %v64, 0
  br i1 %c.b9, label %b9.t21, label %b9.e22
b9.t21:
  br label %b10
b9.e22:
  br label %b11
b10:
  br label %b12
b11:
  %v65 = add i64 0, 49
  %v66.p = getelementptr i64, ptr %v3, i64 0
  %v66 = load i64, ptr %v66.p
  %v67 = add i64 0, 16
  %v68 = add i64 0, 0
  %v69 = add i64 0, 0
  %v70 = add i64 0, 0
  %v71 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v65, i64 %v12, i64 %v66, i64 %v67, i64 %v68, i64 %v69, i64 %v70)
  br label %b12
b12:
  %v72 = phi i64 [ %v62, %b10 ], [ %v71, %b11 ]
  %v73 = add i64 0, 0
  %v74.c = icmp slt i64 %v72, %v73
  %v74 = zext i1 %v74.c to i64
  %c.b12 = icmp ne i64 %v74, 0
  br i1 %c.b12, label %b12.t23, label %b12.e24
b12.t23:
  br label %b13
b12.e24:
  br label %b14
b13:
  br label %b15
b14:
  %v75 = add i64 0, 50
  %v76 = add i64 0, 65535
  %v77 = add i64 0, 0
  %v78 = add i64 0, 0
  %v79 = add i64 0, 0
  %v80 = add i64 0, 0
  %v81 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v75, i64 %v12, i64 %v76, i64 %v77, i64 %v78, i64 %v79, i64 %v80)
  br label %b15
b15:
  %v82 = phi i64 [ %v72, %b13 ], [ %v81, %b14 ]
  %v83 = add i64 0, 0
  %v84.c = icmp slt i64 %v82, %v83
  %v84 = zext i1 %v84.c to i64
  %c.b15 = icmp ne i64 %v84, 0
  br i1 %c.b15, label %b15.t25, label %b15.e26
b15.t25:
  br label %b16
b15.e26:
  br label %b17
b16:
  %v85 = add i64 0, 3
  %v86 = add i64 0, 0
  %v87 = add i64 0, 0
  %v88 = add i64 0, 0
  %v89 = add i64 0, 0
  %v90 = add i64 0, 0
  %v91 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v85, i64 %v12, i64 %v86, i64 %v87, i64 %v88, i64 %v89, i64 %v90)
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v94, i64 0
  store i64 %v4, ptr %st26
  ret i64 %v82
b17:
  br label %b18
b18:
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v95, i64 0
  store i64 %v4, ptr %st27
  ret i64 %v12
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
  %v1 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v1, i64 0
  store i64 %v0, ptr %st0
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v36, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = getelementptr i64, ptr %s1, i64 0
  %v4.p = getelementptr i64, ptr %v1, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v5, i64 2571
  store i64 %v2, ptr %st1
  call void @"std/net.boundAddr"(ptr %v3, i64 %v4)
  %v6 = getelementptr i64, ptr %s2, i64 0
  %v7.p = getelementptr i64, ptr %v3, i64 0
  %v7 = load i64, ptr %v7.p
  %st2 = getelementptr i64, ptr %v6, i64 0
  store i64 %v7, ptr %st2
  %v8.p = getelementptr i64, ptr %v3, i64 1
  %v8 = load i64, ptr %v8.p
  %st3 = getelementptr i64, ptr %v6, i64 1
  store i64 %v8, ptr %st3
  %v9.p = getelementptr i64, ptr %v3, i64 2
  %v9 = load i64, ptr %v9.p
  %st4 = getelementptr i64, ptr %v6, i64 2
  store i64 %v9, ptr %st4
  %v10.p = getelementptr i64, ptr %v6, i64 1
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 16
  %v12.c = icmp ne i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t6, label %b0.e7
b0.t6:
  br label %b1
b0.e7:
  br label %b2
b1:
  %v13 = add i64 0, 1
  %v14 = add i64 0, 0
  %v15 = sub i64 %v14, %v13
  br label %b7
b2:
  %v16 = add i64 0, 2
  %v17.p = getelementptr i64, ptr %v6, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.c = icmp uge i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b2 = icmp ne i64 %v18, 0
  br i1 %c.b2, label %b2.t8, label %b2.e9
b2.t8:
  br label %b3
b2.e9:
  br label %b4
b3:
  %v19 = add i64 0, 11
  call void @"rt.panic"(i64 %v19)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v20.p = getelementptr i64, ptr %v6, i64 0
  %v20 = load i64, ptr %v20.p
  %v21 = inttoptr i64 %v20 to ptr
  %v22 = getelementptr i8, ptr %v21, i64 %v16
  %v23.p = getelementptr i8, ptr %v22, i64 0
  %v23.b = load i8, ptr %v23.p
  %v23 = zext i8 %v23.b to i64
  %v24 = add i64 0, 256
  %v25 = mul i64 %v23, %v24
  %v26 = add i64 0, 3
  %v27.p = getelementptr i64, ptr %v6, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b4 = icmp ne i64 %v28, 0
  br i1 %c.b4, label %b4.t10, label %b4.e11
b4.t10:
  br label %b5
b4.e11:
  br label %b6
b5:
  %v29 = add i64 0, 12
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v30.p = getelementptr i64, ptr %v6, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = getelementptr i8, ptr %v31, i64 %v26
  %v33.p = getelementptr i8, ptr %v32, i64 0
  %v33.b = load i8, ptr %v33.p
  %v33 = zext i8 %v33.b to i64
  %v34 = add i64 %v25, %v33
  br label %b7
b7:
  %v35 = phi i64 [ %v15, %b1 ], [ %v34, %b6 ]
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v37, i64 0
  store i64 %v2, ptr %st11
  ret i64 %v35
}

define internal void @"std/net.boundAddr"(ptr %v0, i64 %v1) #0 {
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
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v109, i64 0
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
  %v14 = add i64 0, 0
  %v15 = add i64 0, 0
  %v16 = add i64 0, 0
  %v17 = add i64 0, 0
  %v18 = add i64 0, 0
  %v19 = add i64 0, 0
  %v20 = add i64 0, 0
  %v21 = add i64 0, 0
  %v22 = add i64 0, 0
  %v23 = add i64 0, 0
  %v24 = add i64 0, 0
  %v25 = add i64 0, 0
  %v26 = add i64 0, 0
  %v27 = add i64 0, 0
  %v28 = add i64 0, 0
  %v29 = add i64 0, 16
  %v30 = call ptr @"rt.region_alloc8"(i64 %v12, i64 %v29)
  %v31 = add i64 0, 0
  %v32 = getelementptr i8, ptr %v30, i64 %v31
  %st1 = getelementptr i8, ptr %v32, i64 0
  %st1.b = trunc i64 %v13 to i8
  store i8 %st1.b, ptr %st1
  %v33 = add i64 0, 1
  %v34 = getelementptr i8, ptr %v30, i64 %v33
  %st2 = getelementptr i8, ptr %v34, i64 0
  %st2.b = trunc i64 %v14 to i8
  store i8 %st2.b, ptr %st2
  %v35 = add i64 0, 2
  %v36 = getelementptr i8, ptr %v30, i64 %v35
  %st3 = getelementptr i8, ptr %v36, i64 0
  %st3.b = trunc i64 %v15 to i8
  store i8 %st3.b, ptr %st3
  %v37 = add i64 0, 3
  %v38 = getelementptr i8, ptr %v30, i64 %v37
  %st4 = getelementptr i8, ptr %v38, i64 0
  %st4.b = trunc i64 %v16 to i8
  store i8 %st4.b, ptr %st4
  %v39 = add i64 0, 4
  %v40 = getelementptr i8, ptr %v30, i64 %v39
  %st5 = getelementptr i8, ptr %v40, i64 0
  %st5.b = trunc i64 %v17 to i8
  store i8 %st5.b, ptr %st5
  %v41 = add i64 0, 5
  %v42 = getelementptr i8, ptr %v30, i64 %v41
  %st6 = getelementptr i8, ptr %v42, i64 0
  %st6.b = trunc i64 %v18 to i8
  store i8 %st6.b, ptr %st6
  %v43 = add i64 0, 6
  %v44 = getelementptr i8, ptr %v30, i64 %v43
  %st7 = getelementptr i8, ptr %v44, i64 0
  %st7.b = trunc i64 %v19 to i8
  store i8 %st7.b, ptr %st7
  %v45 = add i64 0, 7
  %v46 = getelementptr i8, ptr %v30, i64 %v45
  %st8 = getelementptr i8, ptr %v46, i64 0
  %st8.b = trunc i64 %v20 to i8
  store i8 %st8.b, ptr %st8
  %v47 = add i64 0, 8
  %v48 = getelementptr i8, ptr %v30, i64 %v47
  %st9 = getelementptr i8, ptr %v48, i64 0
  %st9.b = trunc i64 %v21 to i8
  store i8 %st9.b, ptr %st9
  %v49 = add i64 0, 9
  %v50 = getelementptr i8, ptr %v30, i64 %v49
  %st10 = getelementptr i8, ptr %v50, i64 0
  %st10.b = trunc i64 %v22 to i8
  store i8 %st10.b, ptr %st10
  %v51 = add i64 0, 10
  %v52 = getelementptr i8, ptr %v30, i64 %v51
  %st11 = getelementptr i8, ptr %v52, i64 0
  %st11.b = trunc i64 %v23 to i8
  store i8 %st11.b, ptr %st11
  %v53 = add i64 0, 11
  %v54 = getelementptr i8, ptr %v30, i64 %v53
  %st12 = getelementptr i8, ptr %v54, i64 0
  %st12.b = trunc i64 %v24 to i8
  store i8 %st12.b, ptr %st12
  %v55 = add i64 0, 12
  %v56 = getelementptr i8, ptr %v30, i64 %v55
  %st13 = getelementptr i8, ptr %v56, i64 0
  %st13.b = trunc i64 %v25 to i8
  store i8 %st13.b, ptr %st13
  %v57 = add i64 0, 13
  %v58 = getelementptr i8, ptr %v30, i64 %v57
  %st14 = getelementptr i8, ptr %v58, i64 0
  %st14.b = trunc i64 %v26 to i8
  store i8 %st14.b, ptr %st14
  %v59 = add i64 0, 14
  %v60 = getelementptr i8, ptr %v30, i64 %v59
  %st15 = getelementptr i8, ptr %v60, i64 0
  %st15.b = trunc i64 %v27 to i8
  store i8 %st15.b, ptr %st15
  %v61 = add i64 0, 15
  %v62 = getelementptr i8, ptr %v30, i64 %v61
  %st16 = getelementptr i8, ptr %v62, i64 0
  %st16.b = trunc i64 %v28 to i8
  store i8 %st16.b, ptr %st16
  %v63 = add i64 0, 16
  %v64 = getelementptr i64, ptr %s0, i64 0
  %v65 = ptrtoint ptr %v30 to i64
  %st17 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st17
  %st18 = getelementptr i64, ptr %v64, i64 1
  store i64 %v63, ptr %st18
  %st19 = getelementptr i64, ptr %v64, i64 2
  store i64 %v12, ptr %st19
  %v66 = getelementptr i64, ptr %s1, i64 0
  %v67.p = getelementptr i64, ptr %v64, i64 0
  %v67 = load i64, ptr %v67.p
  %st20 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st20
  %v68.p = getelementptr i64, ptr %v64, i64 1
  %v68 = load i64, ptr %v68.p
  %st21 = getelementptr i64, ptr %v66, i64 1
  store i64 %v68, ptr %st21
  %v69.p = getelementptr i64, ptr %v64, i64 2
  %v69 = load i64, ptr %v69.p
  %st22 = getelementptr i64, ptr %v66, i64 2
  store i64 %v69, ptr %st22
  %v70 = add i64 0, 16
  %v71 = add i64 0, 0
  %v72 = add i64 0, 0
  %v73 = add i64 0, 0
  %v74 = add i64 0, 4
  %v75 = call ptr @"rt.region_alloc8"(i64 %v12, i64 %v74)
  %v76 = add i64 0, 0
  %v77 = getelementptr i8, ptr %v75, i64 %v76
  %st23 = getelementptr i8, ptr %v77, i64 0
  %st23.b = trunc i64 %v70 to i8
  store i8 %st23.b, ptr %st23
  %v78 = add i64 0, 1
  %v79 = getelementptr i8, ptr %v75, i64 %v78
  %st24 = getelementptr i8, ptr %v79, i64 0
  %st24.b = trunc i64 %v71 to i8
  store i8 %st24.b, ptr %st24
  %v80 = add i64 0, 2
  %v81 = getelementptr i8, ptr %v75, i64 %v80
  %st25 = getelementptr i8, ptr %v81, i64 0
  %st25.b = trunc i64 %v72 to i8
  store i8 %st25.b, ptr %st25
  %v82 = add i64 0, 3
  %v83 = getelementptr i8, ptr %v75, i64 %v82
  %st26 = getelementptr i8, ptr %v83, i64 0
  %st26.b = trunc i64 %v73 to i8
  store i8 %st26.b, ptr %st26
  %v84 = add i64 0, 4
  %v85 = getelementptr i64, ptr %s0, i64 0
  %v86 = ptrtoint ptr %v75 to i64
  %st27 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st27
  %st28 = getelementptr i64, ptr %v85, i64 1
  store i64 %v84, ptr %st28
  %st29 = getelementptr i64, ptr %v85, i64 2
  store i64 %v12, ptr %st29
  %v87 = getelementptr i64, ptr %s2, i64 0
  %v88.p = getelementptr i64, ptr %v85, i64 0
  %v88 = load i64, ptr %v88.p
  %st30 = getelementptr i64, ptr %v87, i64 0
  store i64 %v88, ptr %st30
  %v89.p = getelementptr i64, ptr %v85, i64 1
  %v89 = load i64, ptr %v89.p
  %st31 = getelementptr i64, ptr %v87, i64 1
  store i64 %v89, ptr %st31
  %v90.p = getelementptr i64, ptr %v85, i64 2
  %v90 = load i64, ptr %v90.p
  %st32 = getelementptr i64, ptr %v87, i64 2
  store i64 %v90, ptr %st32
  %v91 = add i64 0, 51
  %v92.p = getelementptr i64, ptr %v66, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v87, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 0
  %v95 = add i64 0, 0
  %v96 = add i64 0, 0
  %v97 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v91, i64 %v1, i64 %v92, i64 %v93, i64 %v94, i64 %v95, i64 %v96)
  %v98 = add i64 0, 0
  %v99.c = icmp slt i64 %v97, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b0 = icmp ne i64 %v99, 0
  br i1 %c.b0, label %b0.t34, label %b0.e35
b0.t34:
  br label %b1
b0.e35:
  br label %b2
b1:
  %v100 = add i64 0, 0
  %v101 = call ptr @"rt.region_alloc8"(i64 %v12, i64 %v100)
  %v102 = add i64 0, 0
  %v103 = getelementptr i64, ptr %s0, i64 0
  %v104 = ptrtoint ptr %v101 to i64
  %st35 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st35
  %st36 = getelementptr i64, ptr %v103, i64 1
  store i64 %v102, ptr %st36
  %st37 = getelementptr i64, ptr %v103, i64 2
  store i64 %v12, ptr %st37
  br label %b3
b2:
  br label %b3
b3:
  %v105 = phi ptr [ %v103, %b1 ], [ %v66, %b2 ]
  %v106.p = getelementptr i64, ptr %v105, i64 0
  %v106 = load i64, ptr %v106.p
  %st38 = getelementptr i64, ptr %v0, i64 0
  store i64 %v106, ptr %st38
  %v107.p = getelementptr i64, ptr %v105, i64 1
  %v107 = load i64, ptr %v107.p
  %st39 = getelementptr i64, ptr %v0, i64 1
  store i64 %v107, ptr %st39
  %v108.p = getelementptr i64, ptr %v105, i64 2
  %v108 = load i64, ptr %v108.p
  %st40 = getelementptr i64, ptr %v0, i64 2
  store i64 %v108, ptr %st40
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v110 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v110, i64 0
  store i64 %v2, ptr %st41
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
  %v13 = add i64 0, 3
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
  %v34 = add i64 0, 1
  %v35 = getelementptr i64, ptr %v0, i64 %v34
  call void @"rt.err_relocate"(ptr %v35, i64 %v7)
  br label %b4
b4:
  %v120 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v120, i64 0
  store i64 %v7, ptr %st28
  ret void
b5:
  %v36 = add i64 0, 0
  %v37 = getelementptr i64, ptr %s5, i64 0
  %st29 = getelementptr i64, ptr %v37, i64 0
  store i64 %v36, ptr %st29
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v121, i64 0
  %v38 = load i64, ptr %v38.p
  br label %b6
b6:
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v122, i64 0
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
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v123, i64 0
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
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v124, i64 0
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
  %v74 = add i64 0, 1
  %v75 = getelementptr i64, ptr %v0, i64 %v74
  call void @"rt.err_relocate"(ptr %v75, i64 %v7)
  br label %b12
b12:
  %v125 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v125, i64 0
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
  %v100 = add i64 0, 1
  %v101 = getelementptr i64, ptr %v0, i64 %v100
  call void @"rt.err_relocate"(ptr %v101, i64 %v7)
  br label %b19
b19:
  %v126 = getelementptr i64, ptr @"rt.meta", i64 0
  %st78 = getelementptr i64, ptr %v126, i64 0
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
  %v117 = add i64 0, 1
  %v118 = getelementptr i64, ptr %v0, i64 %v117
  call void @"rt.err_relocate"(ptr %v118, i64 %v7)
  br label %b25
b25:
  %v127 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v127, i64 0
  store i64 %v7, ptr %st82
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
  %v19 = getelementptr i64, ptr @"str.16", i64 0
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
  %v34 = add i64 0, 13
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
  %v78 = add i64 0, 14
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
  %v133 = add i64 0, 15
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

define internal void @"rt.err_relocate"(ptr %v0, i64 %v1) #0 {
b0:
  %v2 = add i64 0, 2
  %v3 = getelementptr i64, ptr %v0, i64 %v2
  %v4 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v3, i64 %v4, i64 %v1)
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
  %v21 = add i64 0, 16384
  %v22 = add i64 0, 44
  %v23 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %v22, i64 %v1, i64 %v2, i64 %v3, i64 %v21, i64 %v4, i64 %v4)
  ret i64 %v23
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
  %v24 = add i64 0, 3
  %v25 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v24, i64 %v1)
  %v26.c = icmp sgt i64 %v25, %v4
  %v26 = zext i1 %v26.c to i64
  %v27 = sub i64 %v25, %v4
  %v28 = mul i64 %v26, %v27
  %v29 = sub i64 %v25, %v28
  ret i64 %v29
b4:
  %v18 = add i64 0, 526336
  %v19 = add i64 0, 288
  %v20 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v19, i64 %v1, i64 %v4, i64 %v4, i64 %v18)
  ret i64 %v20
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
  %v11 = add i64 0, 7
  %v12.c = icmp eq i64 %v0, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b7 = icmp ne i64 %v12, 0
  br i1 %c.b7, label %b7.t7, label %b7.e8
b7.t7:
  br label %b10
b7.e8:
  br label %b9
b8:
  ret i64 %v4
b9:
  %v13 = add i64 0, 8
  %v14.c = icmp eq i64 %v0, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b9 = icmp ne i64 %v14, 0
  br i1 %c.b9, label %b9.t9, label %b9.e10
b9.t9:
  br label %b12
b9.e10:
  br label %b11
b10:
  ret i64 %v4
b11:
  %v16 = add i64 0, 5
  %v17.c = icmp eq i64 %v0, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b11 = icmp ne i64 %v17, 0
  br i1 %c.b11, label %b11.t11, label %b11.e12
b11.t11:
  br label %b6
b11.e12:
  br label %b3
b12:
  %v15 = add i64 0, 1
  ret i64 %v15
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
  %v20 = getelementptr i64, ptr @"str.29", i64 0
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
  %v74 = getelementptr i64, ptr @"str.37", i64 0
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
  %v27 = getelementptr i64, ptr @"str.30", i64 0
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
  %v34 = getelementptr i64, ptr @"str.31", i64 0
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
  %v41 = getelementptr i64, ptr @"str.32", i64 0
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
  %v48 = getelementptr i64, ptr @"str.33", i64 0
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
  %v55 = getelementptr i64, ptr @"str.34", i64 0
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
  %v62 = getelementptr i64, ptr @"str.35", i64 0
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
  %v69 = getelementptr i64, ptr @"str.36", i64 0
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
  %v81 = getelementptr i64, ptr @"str.38", i64 0
  %v82 = add i64 0, 16
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
  %v88 = getelementptr i64, ptr @"str.39", i64 0
  %v89 = add i64 0, 17
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
  %v95 = getelementptr i64, ptr @"str.40", i64 0
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
