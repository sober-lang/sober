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
@"str.0" = internal constant [1 x i64] [i64 9071397899755888]
@"str.1" = internal constant [3 x i64] [i64 8242523201870983024, i64 7312272751943971937, i64 100]
@"str.2" = internal constant [1 x i64] [i64 123]
@"str.3" = internal constant [1 x i64] [i64 125]
@"str.4" = internal constant [2 x i64] [i64 7233135243688898416, i64 29382749080150867]
@"str.5" = internal constant [1 x i64] [i64 118]
@"str.6" = internal constant [1 x i64] [i64 8250]
@"str.7" = internal constant [2 x i64] [i64 7165029294424678772, i64 111533746318433]
@"str.8" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.9" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.10" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.11" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.12" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.13" = internal constant [1 x i64] [i64 2685]
@"str.14" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.15" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.16" = internal constant [1 x i64] [i64 35899498962976]
@"str.17" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.18" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [26 x i64] [i64 3940651720769544, i64 9007201603551233, i64 7881301780594689, i64 8444253193633793, i64 3940651720769544, i64 9007201603551233, i64 7881301780594689, i64 6473928457322497, i64 3659178740547585, i64 11540478105223172, i64 5629503745294337, i64 3940651720769544, i64 9007201603551233, i64 7881301780594689, i64 2814752535347204, i64 3377702539100161, i64 4785077254881281, i64 4785077271658500, i64 2814752669564936, i64 9570156355256577, i64 3940656837820680, i64 4503606824796417, i64 4785081818284289, i64 7036881766187265, i64 6473931175231745, i64 7599831249846529]
@"str.19" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.20" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.21" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.22" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.23" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.24" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.25" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.26" = internal constant [1 x i64] [i64 544497952]
@"str.27" = internal constant [3 x i64] [i64 7813586406133232755, i64 8030813603792646191, i64 7497058]
@"str.28" = internal constant [3 x i64] [i64 7742639336019227763, i64 8030813599563871279, i64 7497058]

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
  %v3 = getelementptr i64, ptr @"str.8", i64 0
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
  %v29 = getelementptr i64, ptr @"str.12", i64 0
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
  %v35 = getelementptr i64, ptr @"str.13", i64 0
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
  %v10 = getelementptr i64, ptr @"str.9", i64 0
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
  %v17 = getelementptr i64, ptr @"str.10", i64 0
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
  %v24 = getelementptr i64, ptr @"str.11", i64 0
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
  %v60 = getelementptr i64, ptr @"str.14", i64 0
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
  %v65 = getelementptr i64, ptr @"str.15", i64 0
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
  %v70 = getelementptr i64, ptr @"str.13", i64 0
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
  %v81 = getelementptr i64, ptr @"str.16", i64 0
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
  %v88 = getelementptr i64, ptr @"str.17", i64 0
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
  %v17 = getelementptr i64, ptr @"str.18", i64 0
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
  %v22 = getelementptr i64, ptr @"str.13", i64 0
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
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s12 = alloca [1 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
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
  %s19 = alloca [1 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s20 = alloca [1 x i64], align 8
  %s20.z0 = getelementptr i64, ptr %s20, i64 0
  store i64 0, ptr %s20.z0
  %s21 = alloca [1 x i64], align 8
  %s21.z0 = getelementptr i64, ptr %s21, i64 0
  store i64 0, ptr %s21.z0
  %s22 = alloca [1 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %v977 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v977, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v978 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v978, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v979 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v979, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr %s0, i64 0
  %v4 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v4, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v4, ptr %st1
  %st2 = getelementptr i64, ptr %v3, i64 2
  store i64 %v4, ptr %st2
  %st3 = getelementptr i64, ptr %v3, i64 3
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v3, i64 4
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v3, i64 5
  store i64 %v4, ptr %st5
  %st6 = getelementptr i64, ptr %v3, i64 6
  store i64 %v4, ptr %st6
  %st7 = getelementptr i64, ptr %v3, i64 7
  store i64 %v4, ptr %st7
  %st8 = getelementptr i64, ptr %v3, i64 8
  store i64 %v4, ptr %st8
  %v980 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v980, i64 0
  %v5 = load i64, ptr %v5.p
  %v981 = getelementptr i64, ptr @"rt.meta", i64 0
  %v982 = getelementptr i64, ptr %v981, i64 %v5
  %v6.p = getelementptr i64, ptr %v982, i64 1
  %v6 = load ptr, ptr %v6.p
  %v7 = ptrtoint ptr %v6 to i64
  %st9 = getelementptr i64, ptr %v3, i64 0
  store i64 %v7, ptr %st9
  %v8 = add i64 0, 0
  %st10 = getelementptr i64, ptr %v3, i64 1
  store i64 %v8, ptr %st10
  %st11 = getelementptr i64, ptr %v3, i64 2
  store i64 %v5, ptr %st11
  %v9 = add i64 0, 4
  %v10 = getelementptr i64, ptr %v3, i64 %v9
  %v983 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v983, i64 0
  %v11 = load i64, ptr %v11.p
  %v984 = getelementptr i64, ptr @"rt.meta", i64 0
  %v985 = getelementptr i64, ptr %v984, i64 %v11
  %v12.p = getelementptr i64, ptr %v985, i64 1
  %v12 = load ptr, ptr %v12.p
  %v13 = ptrtoint ptr %v12 to i64
  %st12 = getelementptr i64, ptr %v10, i64 0
  store i64 %v13, ptr %st12
  %v14 = add i64 0, 0
  %st13 = getelementptr i64, ptr %v10, i64 1
  store i64 %v14, ptr %st13
  %st14 = getelementptr i64, ptr %v10, i64 2
  store i64 %v11, ptr %st14
  %v15 = getelementptr i64, ptr %s1, i64 0
  %v16.p = getelementptr i64, ptr %v3, i64 0
  %v16 = load i64, ptr %v16.p
  %st15 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st15
  %v17.p = getelementptr i64, ptr %v3, i64 1
  %v17 = load i64, ptr %v17.p
  %st16 = getelementptr i64, ptr %v15, i64 1
  store i64 %v17, ptr %st16
  %v18.p = getelementptr i64, ptr %v3, i64 2
  %v18 = load i64, ptr %v18.p
  %st17 = getelementptr i64, ptr %v15, i64 2
  store i64 %v18, ptr %st17
  %v19.p = getelementptr i64, ptr %v3, i64 3
  %v19 = load i64, ptr %v19.p
  %st18 = getelementptr i64, ptr %v15, i64 3
  store i64 %v19, ptr %st18
  %v20.p = getelementptr i64, ptr %v3, i64 4
  %v20 = load i64, ptr %v20.p
  %st19 = getelementptr i64, ptr %v15, i64 4
  store i64 %v20, ptr %st19
  %v21.p = getelementptr i64, ptr %v3, i64 5
  %v21 = load i64, ptr %v21.p
  %st20 = getelementptr i64, ptr %v15, i64 5
  store i64 %v21, ptr %st20
  %v22.p = getelementptr i64, ptr %v3, i64 6
  %v22 = load i64, ptr %v22.p
  %st21 = getelementptr i64, ptr %v15, i64 6
  store i64 %v22, ptr %st21
  %v23.p = getelementptr i64, ptr %v3, i64 7
  %v23 = load i64, ptr %v23.p
  %st22 = getelementptr i64, ptr %v15, i64 7
  store i64 %v23, ptr %st22
  %v24.p = getelementptr i64, ptr %v3, i64 8
  %v24 = load i64, ptr %v24.p
  %st23 = getelementptr i64, ptr %v15, i64 8
  store i64 %v24, ptr %st23
  %v25 = getelementptr i64, ptr %s2, i64 0
  %v986 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v986, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v987 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v987, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 64
  %v30 = getelementptr i64, ptr %s4, i64 0
  %v988 = getelementptr i64, ptr @"rt.meta", i64 0
  %v31.p = getelementptr i64, ptr %v988, i64 0
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v15, i64 1
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 0
  %v34.c = icmp sgt i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b0 = icmp ne i64 %v34, 0
  br i1 %c.b0, label %b0.t25, label %b0.e26
b0.t25:
  br label %b4
b0.e26:
  br label %b5
b1:
  %v252 = getelementptr i64, ptr %s13, i64 0
  %v253 = add i64 0, 2845814786215520742
  %v254 = getelementptr i64, ptr %s2, i64 0
  %v989 = getelementptr i64, ptr @"rt.meta", i64 0
  %v255.p = getelementptr i64, ptr %v989, i64 0
  %v255 = load i64, ptr %v255.p
  %v256.p = getelementptr i64, ptr %v15, i64 1
  %v256 = load i64, ptr %v256.p
  %st26 = getelementptr i64, ptr %v254, i64 0
  store i64 %v256, ptr %st26
  %v990 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v990, i64 0
  store i64 %v255, ptr %st27
  br label %b47
b2:
  br label %b1
b3:
  br label %b2
b4:
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v36 = add i64 0, 2
  %st28 = getelementptr i64, ptr %v35, i64 1026
  store i64 %v36, ptr %st28
  %v37 = getelementptr i64, ptr @"str.0", i64 0
  %v38 = add i64 0, 7
  %v39 = add i64 0, 0
  %v40 = getelementptr i64, ptr %s5, i64 0
  %v41 = ptrtoint ptr %v37 to i64
  %st29 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st29
  %st30 = getelementptr i64, ptr %v40, i64 1
  store i64 %v38, ptr %st30
  %st31 = getelementptr i64, ptr %v40, i64 2
  store i64 %v39, ptr %st31
  call void @"rt.print_str"(ptr %v40)
  %v42 = getelementptr i64, ptr @"str.1", i64 0
  %v43 = add i64 0, 17
  %v44 = add i64 0, 0
  %v45 = getelementptr i64, ptr %s6, i64 0
  %v46 = ptrtoint ptr %v42 to i64
  %st32 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st32
  %st33 = getelementptr i64, ptr %v45, i64 1
  store i64 %v43, ptr %st33
  %st34 = getelementptr i64, ptr %v45, i64 2
  store i64 %v44, ptr %st34
  call void @"rt.print_str"(ptr %v45)
  %v47 = getelementptr i64, ptr @"str.2", i64 0
  %v48 = add i64 0, 1
  %v49 = add i64 0, 0
  %v50 = getelementptr i64, ptr %s7, i64 0
  %v51 = ptrtoint ptr %v47 to i64
  %st35 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st35
  %st36 = getelementptr i64, ptr %v50, i64 1
  store i64 %v48, ptr %st36
  %st37 = getelementptr i64, ptr %v50, i64 2
  store i64 %v49, ptr %st37
  call void @"rt.print_str"(ptr %v50)
  %v52 = getelementptr i64, ptr @"str.3", i64 0
  %v53 = add i64 0, 1
  %v54 = add i64 0, 0
  %v55 = getelementptr i64, ptr %s8, i64 0
  %v56 = ptrtoint ptr %v52 to i64
  %st38 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st38
  %st39 = getelementptr i64, ptr %v55, i64 1
  store i64 %v53, ptr %st39
  %st40 = getelementptr i64, ptr %v55, i64 2
  store i64 %v54, ptr %st40
  call void @"rt.print_str"(ptr %v55)
  %v57 = add i64 0, 0
  call void @"rt.panic"(i64 %v57)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  br label %b6
b6:
  %v58 = add i64 0, 0
  %v59 = add i64 0, 3
  %v60 = getelementptr i64, ptr %v15, i64 %v59
  %st41 = getelementptr i64, ptr %v60, i64 0
  store i64 %v58, ptr %st41
  %v61 = getelementptr i64, ptr %s9, i64 0
  %v991 = getelementptr i64, ptr @"rt.meta", i64 0
  %v62.p = getelementptr i64, ptr %v991, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 0, 256
  %v64.c = icmp slt i64 %v29, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b6 = icmp ne i64 %v64, 0
  br i1 %c.b6, label %b6.t43, label %b6.e44
b6.t43:
  br label %b8
b6.e44:
  br label %b9
b7:
  br label %b3
b8:
  br label %b10
b9:
  %v65 = add i64 0, 256
  br label %b10
b10:
  %v66 = phi i64 [ %v29, %b8 ], [ %v65, %b9 ]
  %v992 = getelementptr i64, ptr @"rt.meta", i64 0
  %v67.p = getelementptr i64, ptr %v992, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 0
  %v69 = call ptr @"rt.region_alloc"(i64 %v67, i64 %v68)
  %v70 = add i64 0, 0
  %v71 = getelementptr i64, ptr %s8, i64 0
  %v72 = ptrtoint ptr %v69 to i64
  %st44 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st44
  %st45 = getelementptr i64, ptr %v71, i64 1
  store i64 %v70, ptr %st45
  %st46 = getelementptr i64, ptr %v71, i64 2
  store i64 %v67, ptr %st46
  %v73 = getelementptr i64, ptr %s7, i64 0
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
  %v993 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v993, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79 = getelementptr i64, ptr %s10, i64 0
  %v994 = getelementptr i64, ptr @"rt.meta", i64 0
  %v80.p = getelementptr i64, ptr %v994, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = getelementptr i64, ptr %s11, i64 0
  %st50 = getelementptr i64, ptr %v81, i64 0
  store i64 %v78, ptr %st50
  %v995 = getelementptr i64, ptr @"rt.meta", i64 0
  %v82.p = getelementptr i64, ptr %v995, i64 0
  %v82 = load i64, ptr %v82.p
  br label %b13
b11:
  %v996 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v996, i64 0
  store i64 %v77, ptr %st51
  %v124 = getelementptr i64, ptr %s6, i64 0
  %v125.p = getelementptr i64, ptr %v73, i64 0
  %v125 = load i64, ptr %v125.p
  %st52 = getelementptr i64, ptr %v124, i64 0
  store i64 %v125, ptr %st52
  %v126.p = getelementptr i64, ptr %v73, i64 1
  %v126 = load i64, ptr %v126.p
  %st53 = getelementptr i64, ptr %v124, i64 1
  store i64 %v126, ptr %st53
  %v127.p = getelementptr i64, ptr %v73, i64 2
  %v127 = load i64, ptr %v127.p
  %st54 = getelementptr i64, ptr %v124, i64 2
  store i64 %v127, ptr %st54
  %v128 = add i64 0, 0
  %v129 = getelementptr i64, ptr %s11, i64 0
  %st55 = getelementptr i64, ptr %v129, i64 0
  store i64 %v128, ptr %st55
  %v997 = getelementptr i64, ptr @"rt.meta", i64 0
  %v130.p = getelementptr i64, ptr %v997, i64 0
  %v130 = load i64, ptr %v130.p
  br label %b20
b12:
  br label %b11
b13:
  %v998 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v998, i64 0
  store i64 %v82, ptr %st56
  %v83.p = getelementptr i64, ptr %v81, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.c = icmp slt i64 %v83, %v66
  %v84 = zext i1 %v84.c to i64
  %c.b13 = icmp ne i64 %v84, 0
  br i1 %c.b13, label %b13.t58, label %b13.e59
b13.t58:
  br label %b14
b13.e59:
  br label %b15
b14:
  call void @"rt.region_enter"()
  %v999 = getelementptr i64, ptr @"rt.meta", i64 0
  %v85.p = getelementptr i64, ptr %v999, i64 0
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v81, i64 0
  %v86 = load i64, ptr %v86.p
  %v1000 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v1000, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = getelementptr i64, ptr %s8, i64 0
  %v89.p = getelementptr i64, ptr %v73, i64 0
  %v89 = load i64, ptr %v89.p
  %st59 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st59
  %v90.p = getelementptr i64, ptr %v73, i64 1
  %v90 = load i64, ptr %v90.p
  %st60 = getelementptr i64, ptr %v88, i64 1
  store i64 %v90, ptr %st60
  %v91.p = getelementptr i64, ptr %v73, i64 2
  %v91 = load i64, ptr %v91.p
  %st61 = getelementptr i64, ptr %v88, i64 2
  store i64 %v91, ptr %st61
  %v92 = add i64 0, 0
  %v93.p = getelementptr i64, ptr %v88, i64 2
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v88, i64 0
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v88, i64 1
  %v95 = load i64, ptr %v95.p
  %v98 = add i64 0, 8
  %v99 = mul i64 %v95, %v98
  %v100 = add i64 %v94, %v99
  %v1001 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1002 = getelementptr i64, ptr %v1001, i64 %v93
  %v101.p = getelementptr i64, ptr %v1002, i64 1
  %v101 = load ptr, ptr %v101.p
  %v102 = ptrtoint ptr %v101 to i64
  %v103.c = icmp eq i64 %v102, %v100
  %v103 = zext i1 %v103.c to i64
  %c.b14 = icmp ne i64 %v103, 0
  br i1 %c.b14, label %b14.t63, label %b14.e64
b14.t63:
  br label %b19
b14.e64:
  br label %b18
b15:
  %v1003 = getelementptr i64, ptr @"rt.meta", i64 0
  %st64 = getelementptr i64, ptr %v1003, i64 0
  store i64 %v82, ptr %st64
  br label %b12
b16:
  %v1004 = getelementptr i64, ptr @"rt.meta", i64 0
  %st65 = getelementptr i64, ptr %v1004, i64 0
  store i64 %v87, ptr %st65
  %v121 = add i64 0, 1
  %v122.p = getelementptr i64, ptr %v81, i64 0
  %v122 = load i64, ptr %v122.p
  %v123 = add i64 %v122, %v121
  %st66 = getelementptr i64, ptr %v81, i64 0
  store i64 %v123, ptr %st66
  br label %b13
b17:
  %v96 = phi ptr [ %v111, %b18 ], [ %v106, %b19 ]
  %v97 = phi ptr [ %v112, %b18 ], [ %v105, %b19 ]
  %st67 = getelementptr i64, ptr %v97, i64 0
  store i64 %v92, ptr %st67
  %v113.p = getelementptr i64, ptr %v88, i64 1
  %v113 = load i64, ptr %v113.p
  %v114 = add i64 0, 1
  %v115 = add i64 %v113, %v114
  %v116 = getelementptr i64, ptr %s6, i64 0
  %v117 = ptrtoint ptr %v96 to i64
  %st68 = getelementptr i64, ptr %v116, i64 0
  store i64 %v117, ptr %st68
  %st69 = getelementptr i64, ptr %v116, i64 1
  store i64 %v115, ptr %st69
  %st70 = getelementptr i64, ptr %v116, i64 2
  store i64 %v93, ptr %st70
  %v118.p = getelementptr i64, ptr %v116, i64 0
  %v118 = load i64, ptr %v118.p
  %st71 = getelementptr i64, ptr %v73, i64 0
  store i64 %v118, ptr %st71
  %v119.p = getelementptr i64, ptr %v116, i64 1
  %v119 = load i64, ptr %v119.p
  %st72 = getelementptr i64, ptr %v73, i64 1
  store i64 %v119, ptr %st72
  %v120.p = getelementptr i64, ptr %v116, i64 2
  %v120 = load i64, ptr %v120.p
  %st73 = getelementptr i64, ptr %v73, i64 2
  store i64 %v120, ptr %st73
  br label %b16
b18:
  %v107 = add i64 0, 1
  %v108 = mul i64 %v95, %v107
  %v109 = add i64 0, 1
  %v110 = add i64 0, 1
  %v111 = call ptr @"rt.slice_grow"(i64 %v94, i64 %v95, i64 %v109, i64 %v93, i64 %v110)
  %v112 = getelementptr i64, ptr %v111, i64 %v108
  br label %b17
b19:
  %v104 = add i64 0, 1
  %v105 = call ptr @"rt.region_alloc"(i64 %v93, i64 %v104)
  %v106 = inttoptr i64 %v94 to ptr
  br label %b17
b20:
  %v1005 = getelementptr i64, ptr @"rt.meta", i64 0
  %st74 = getelementptr i64, ptr %v1005, i64 0
  store i64 %v130, ptr %st74
  %v131.p = getelementptr i64, ptr %v129, i64 0
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 %v131, %v66
  %v133.c = icmp sle i64 %v132, %v29
  %v133 = zext i1 %v133.c to i64
  %c.b20 = icmp ne i64 %v133, 0
  br i1 %c.b20, label %b20.t76, label %b20.e77
b20.t76:
  br label %b23
b20.e77:
  br label %b24
b21:
  call void @"rt.region_enter"()
  %v1006 = getelementptr i64, ptr @"rt.meta", i64 0
  %v137.p = getelementptr i64, ptr %v1006, i64 0
  %v137 = load i64, ptr %v137.p
  %v1007 = getelementptr i64, ptr @"rt.meta", i64 0
  %v138.p = getelementptr i64, ptr %v1007, i64 0
  %v138 = load i64, ptr %v138.p
  %v139 = add i64 0, 0
  %v140 = getelementptr i64, ptr %s10, i64 0
  %v1008 = getelementptr i64, ptr @"rt.meta", i64 0
  %v141.p = getelementptr i64, ptr %v1008, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = getelementptr i64, ptr %s12, i64 0
  %st77 = getelementptr i64, ptr %v142, i64 0
  store i64 %v139, ptr %st77
  %v1009 = getelementptr i64, ptr @"rt.meta", i64 0
  %v143.p = getelementptr i64, ptr %v1009, i64 0
  %v143 = load i64, ptr %v143.p
  br label %b27
b22:
  %v1010 = getelementptr i64, ptr @"rt.meta", i64 0
  %st78 = getelementptr i64, ptr %v1010, i64 0
  store i64 %v130, ptr %st78
  %v1011 = getelementptr i64, ptr @"rt.meta", i64 0
  %v195.p = getelementptr i64, ptr %v1011, i64 0
  %v195 = load i64, ptr %v195.p
  %v196 = add i64 0, 0
  %v197.p = getelementptr i64, ptr %v129, i64 0
  %v197 = load i64, ptr %v197.p
  %v198 = sub i64 %v29, %v197
  %v199 = getelementptr i64, ptr %s12, i64 0
  %v1012 = getelementptr i64, ptr @"rt.meta", i64 0
  %v200.p = getelementptr i64, ptr %v1012, i64 0
  %v200 = load i64, ptr %v200.p
  %v201 = getelementptr i64, ptr %s10, i64 0
  %st79 = getelementptr i64, ptr %v201, i64 0
  store i64 %v196, ptr %st79
  %v1013 = getelementptr i64, ptr @"rt.meta", i64 0
  %v202.p = getelementptr i64, ptr %v1013, i64 0
  %v202 = load i64, ptr %v202.p
  br label %b38
b23:
  %v135 = add i64 0, 0
  %v136.c = icmp sgt i64 %v66, %v135
  %v136 = zext i1 %v136.c to i64
  br label %b24
b24:
  %v134 = phi i64 [ %v133, %b20.e77 ], [ %v136, %b23 ]
  %c.b24 = icmp ne i64 %v134, 0
  br i1 %c.b24, label %b24.t81, label %b24.e82
b24.t81:
  br label %b21
b24.e82:
  br label %b22
b25:
  %v1014 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v1014, i64 0
  store i64 %v138, ptr %st82
  %v193.p = getelementptr i64, ptr %v129, i64 0
  %v193 = load i64, ptr %v193.p
  %v194 = add i64 %v193, %v66
  %st83 = getelementptr i64, ptr %v129, i64 0
  store i64 %v194, ptr %st83
  br label %b20
b26:
  br label %b25
b27:
  %v1015 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v1015, i64 0
  store i64 %v143, ptr %st84
  %v144.p = getelementptr i64, ptr %v142, i64 0
  %v144 = load i64, ptr %v144.p
  %v145.c = icmp slt i64 %v144, %v66
  %v145 = zext i1 %v145.c to i64
  %c.b27 = icmp ne i64 %v145, 0
  br i1 %c.b27, label %b27.t86, label %b27.e87
b27.t86:
  br label %b28
b27.e87:
  br label %b29
b28:
  call void @"rt.region_enter"()
  %v1016 = getelementptr i64, ptr @"rt.meta", i64 0
  %v146.p = getelementptr i64, ptr %v1016, i64 0
  %v146 = load i64, ptr %v146.p
  %v147.p = getelementptr i64, ptr %v142, i64 0
  %v147 = load i64, ptr %v147.p
  %v1017 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v1017, i64 0
  %v148 = load i64, ptr %v148.p
  %v149 = getelementptr i64, ptr %s8, i64 0
  %v150.p = getelementptr i64, ptr %v15, i64 0
  %v150 = load i64, ptr %v150.p
  %st87 = getelementptr i64, ptr %v149, i64 0
  store i64 %v150, ptr %st87
  %v151.p = getelementptr i64, ptr %v15, i64 1
  %v151 = load i64, ptr %v151.p
  %st88 = getelementptr i64, ptr %v149, i64 1
  store i64 %v151, ptr %st88
  %v152.p = getelementptr i64, ptr %v15, i64 2
  %v152 = load i64, ptr %v152.p
  %st89 = getelementptr i64, ptr %v149, i64 2
  store i64 %v152, ptr %st89
  %v153.p = getelementptr i64, ptr %v124, i64 1
  %v153 = load i64, ptr %v153.p
  %v154.c = icmp uge i64 %v147, %v153
  %v154 = zext i1 %v154.c to i64
  %c.b28 = icmp ne i64 %v154, 0
  br i1 %c.b28, label %b28.t91, label %b28.e92
b28.t91:
  br label %b31
b28.e92:
  br label %b32
b29:
  %v1018 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v1018, i64 0
  store i64 %v143, ptr %st92
  br label %b26
b30:
  %v1019 = getelementptr i64, ptr @"rt.meta", i64 0
  %st93 = getelementptr i64, ptr %v1019, i64 0
  store i64 %v148, ptr %st93
  %v190 = add i64 0, 1
  %v191.p = getelementptr i64, ptr %v142, i64 0
  %v191 = load i64, ptr %v191.p
  %v192 = add i64 %v191, %v190
  %st94 = getelementptr i64, ptr %v142, i64 0
  store i64 %v192, ptr %st94
  br label %b27
b31:
  %v155 = add i64 0, 1
  call void @"rt.panic"(i64 %v155)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v156.p = getelementptr i64, ptr %v124, i64 0
  %v156 = load i64, ptr %v156.p
  %v157 = inttoptr i64 %v156 to ptr
  %v158 = add i64 0, 1
  %v159 = mul i64 %v147, %v158
  %v160 = getelementptr i64, ptr %v157, i64 %v159
  %v161.p = getelementptr i64, ptr %v160, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v149, i64 2
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v149, i64 0
  %v163 = load i64, ptr %v163.p
  %v164.p = getelementptr i64, ptr %v149, i64 1
  %v164 = load i64, ptr %v164.p
  %v167 = add i64 0, 8
  %v168 = mul i64 %v164, %v167
  %v169 = add i64 %v163, %v168
  %v1020 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1021 = getelementptr i64, ptr %v1020, i64 %v162
  %v170.p = getelementptr i64, ptr %v1021, i64 1
  %v170 = load ptr, ptr %v170.p
  %v171 = ptrtoint ptr %v170 to i64
  %v172.c = icmp eq i64 %v171, %v169
  %v172 = zext i1 %v172.c to i64
  %c.b32 = icmp ne i64 %v172, 0
  br i1 %c.b32, label %b32.t96, label %b32.e97
b32.t96:
  br label %b35
b32.e97:
  br label %b34
b33:
  %v165 = phi ptr [ %v180, %b34 ], [ %v175, %b35 ]
  %v166 = phi ptr [ %v181, %b34 ], [ %v174, %b35 ]
  %st97 = getelementptr i64, ptr %v166, i64 0
  store i64 %v161, ptr %st97
  %v182.p = getelementptr i64, ptr %v149, i64 1
  %v182 = load i64, ptr %v182.p
  %v183 = add i64 0, 1
  %v184 = add i64 %v182, %v183
  %v185 = getelementptr i64, ptr %s5, i64 0
  %v186 = ptrtoint ptr %v165 to i64
  %st98 = getelementptr i64, ptr %v185, i64 0
  store i64 %v186, ptr %st98
  %st99 = getelementptr i64, ptr %v185, i64 1
  store i64 %v184, ptr %st99
  %st100 = getelementptr i64, ptr %v185, i64 2
  store i64 %v162, ptr %st100
  %v187.p = getelementptr i64, ptr %v185, i64 0
  %v187 = load i64, ptr %v187.p
  %st101 = getelementptr i64, ptr %v15, i64 0
  store i64 %v187, ptr %st101
  %v188.p = getelementptr i64, ptr %v185, i64 1
  %v188 = load i64, ptr %v188.p
  %st102 = getelementptr i64, ptr %v15, i64 1
  store i64 %v188, ptr %st102
  %v189.p = getelementptr i64, ptr %v185, i64 2
  %v189 = load i64, ptr %v189.p
  %st103 = getelementptr i64, ptr %v15, i64 2
  store i64 %v189, ptr %st103
  br label %b30
b34:
  %v176 = add i64 0, 1
  %v177 = mul i64 %v164, %v176
  %v178 = add i64 0, 1
  %v179 = add i64 0, 1
  %v180 = call ptr @"rt.slice_grow"(i64 %v163, i64 %v164, i64 %v178, i64 %v162, i64 %v179)
  %v181 = getelementptr i64, ptr %v180, i64 %v177
  br label %b33
b35:
  %v173 = add i64 0, 1
  %v174 = call ptr @"rt.region_alloc"(i64 %v162, i64 %v173)
  %v175 = inttoptr i64 %v163 to ptr
  br label %b33
b36:
  %v1022 = getelementptr i64, ptr @"rt.meta", i64 0
  %st104 = getelementptr i64, ptr %v1022, i64 0
  store i64 %v195, ptr %st104
  br label %b7
b37:
  br label %b36
b38:
  %v1023 = getelementptr i64, ptr @"rt.meta", i64 0
  %st105 = getelementptr i64, ptr %v1023, i64 0
  store i64 %v202, ptr %st105
  %v203.p = getelementptr i64, ptr %v201, i64 0
  %v203 = load i64, ptr %v203.p
  %v204.c = icmp slt i64 %v203, %v198
  %v204 = zext i1 %v204.c to i64
  %c.b38 = icmp ne i64 %v204, 0
  br i1 %c.b38, label %b38.t107, label %b38.e108
b38.t107:
  br label %b39
b38.e108:
  br label %b40
b39:
  call void @"rt.region_enter"()
  %v1024 = getelementptr i64, ptr @"rt.meta", i64 0
  %v205.p = getelementptr i64, ptr %v1024, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v201, i64 0
  %v206 = load i64, ptr %v206.p
  %v1025 = getelementptr i64, ptr @"rt.meta", i64 0
  %v207.p = getelementptr i64, ptr %v1025, i64 0
  %v207 = load i64, ptr %v207.p
  %v208 = getelementptr i64, ptr %s5, i64 0
  %v209.p = getelementptr i64, ptr %v15, i64 0
  %v209 = load i64, ptr %v209.p
  %st108 = getelementptr i64, ptr %v208, i64 0
  store i64 %v209, ptr %st108
  %v210.p = getelementptr i64, ptr %v15, i64 1
  %v210 = load i64, ptr %v210.p
  %st109 = getelementptr i64, ptr %v208, i64 1
  store i64 %v210, ptr %st109
  %v211.p = getelementptr i64, ptr %v15, i64 2
  %v211 = load i64, ptr %v211.p
  %st110 = getelementptr i64, ptr %v208, i64 2
  store i64 %v211, ptr %st110
  %v212.p = getelementptr i64, ptr %v124, i64 1
  %v212 = load i64, ptr %v212.p
  %v213.c = icmp uge i64 %v206, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b39 = icmp ne i64 %v213, 0
  br i1 %c.b39, label %b39.t112, label %b39.e113
b39.t112:
  br label %b42
b39.e113:
  br label %b43
b40:
  %v1026 = getelementptr i64, ptr @"rt.meta", i64 0
  %st113 = getelementptr i64, ptr %v1026, i64 0
  store i64 %v202, ptr %st113
  br label %b37
b41:
  %v1027 = getelementptr i64, ptr @"rt.meta", i64 0
  %st114 = getelementptr i64, ptr %v1027, i64 0
  store i64 %v207, ptr %st114
  %v249 = add i64 0, 1
  %v250.p = getelementptr i64, ptr %v201, i64 0
  %v250 = load i64, ptr %v250.p
  %v251 = add i64 %v250, %v249
  %st115 = getelementptr i64, ptr %v201, i64 0
  store i64 %v251, ptr %st115
  br label %b38
b42:
  %v214 = add i64 0, 2
  call void @"rt.panic"(i64 %v214)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b43:
  %v215.p = getelementptr i64, ptr %v124, i64 0
  %v215 = load i64, ptr %v215.p
  %v216 = inttoptr i64 %v215 to ptr
  %v217 = add i64 0, 1
  %v218 = mul i64 %v206, %v217
  %v219 = getelementptr i64, ptr %v216, i64 %v218
  %v220.p = getelementptr i64, ptr %v219, i64 0
  %v220 = load i64, ptr %v220.p
  %v221.p = getelementptr i64, ptr %v208, i64 2
  %v221 = load i64, ptr %v221.p
  %v222.p = getelementptr i64, ptr %v208, i64 0
  %v222 = load i64, ptr %v222.p
  %v223.p = getelementptr i64, ptr %v208, i64 1
  %v223 = load i64, ptr %v223.p
  %v226 = add i64 0, 8
  %v227 = mul i64 %v223, %v226
  %v228 = add i64 %v222, %v227
  %v1028 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1029 = getelementptr i64, ptr %v1028, i64 %v221
  %v229.p = getelementptr i64, ptr %v1029, i64 1
  %v229 = load ptr, ptr %v229.p
  %v230 = ptrtoint ptr %v229 to i64
  %v231.c = icmp eq i64 %v230, %v228
  %v231 = zext i1 %v231.c to i64
  %c.b43 = icmp ne i64 %v231, 0
  br i1 %c.b43, label %b43.t117, label %b43.e118
b43.t117:
  br label %b46
b43.e118:
  br label %b45
b44:
  %v224 = phi ptr [ %v239, %b45 ], [ %v234, %b46 ]
  %v225 = phi ptr [ %v240, %b45 ], [ %v233, %b46 ]
  %st118 = getelementptr i64, ptr %v225, i64 0
  store i64 %v220, ptr %st118
  %v241.p = getelementptr i64, ptr %v208, i64 1
  %v241 = load i64, ptr %v241.p
  %v242 = add i64 0, 1
  %v243 = add i64 %v241, %v242
  %v244 = getelementptr i64, ptr %s8, i64 0
  %v245 = ptrtoint ptr %v224 to i64
  %st119 = getelementptr i64, ptr %v244, i64 0
  store i64 %v245, ptr %st119
  %st120 = getelementptr i64, ptr %v244, i64 1
  store i64 %v243, ptr %st120
  %st121 = getelementptr i64, ptr %v244, i64 2
  store i64 %v221, ptr %st121
  %v246.p = getelementptr i64, ptr %v244, i64 0
  %v246 = load i64, ptr %v246.p
  %st122 = getelementptr i64, ptr %v15, i64 0
  store i64 %v246, ptr %st122
  %v247.p = getelementptr i64, ptr %v244, i64 1
  %v247 = load i64, ptr %v247.p
  %st123 = getelementptr i64, ptr %v15, i64 1
  store i64 %v247, ptr %st123
  %v248.p = getelementptr i64, ptr %v244, i64 2
  %v248 = load i64, ptr %v248.p
  %st124 = getelementptr i64, ptr %v15, i64 2
  store i64 %v248, ptr %st124
  br label %b41
b45:
  %v235 = add i64 0, 1
  %v236 = mul i64 %v223, %v235
  %v237 = add i64 0, 1
  %v238 = add i64 0, 1
  %v239 = call ptr @"rt.slice_grow"(i64 %v222, i64 %v223, i64 %v237, i64 %v221, i64 %v238)
  %v240 = getelementptr i64, ptr %v239, i64 %v236
  br label %b44
b46:
  %v232 = add i64 0, 1
  %v233 = call ptr @"rt.region_alloc"(i64 %v221, i64 %v232)
  %v234 = inttoptr i64 %v222 to ptr
  br label %b44
b47:
  %v257.p = getelementptr i64, ptr %v254, i64 0
  %v257 = load i64, ptr %v257.p
  %v1030 = getelementptr i64, ptr @"rt.meta", i64 0
  %v258.p = getelementptr i64, ptr %v1030, i64 0
  %v258 = load i64, ptr %v258.p
  %v259 = add i64 0, 1
  %v260 = call ptr @"rt.region_alloc"(i64 %v258, i64 %v259)
  %st125 = getelementptr i64, ptr %v260, i64 0
  store i64 %v257, ptr %st125
  %v261 = add i64 0, 1
  %v262 = getelementptr i64, ptr %s6, i64 0
  %v263 = ptrtoint ptr %v260 to i64
  %st126 = getelementptr i64, ptr %v262, i64 0
  store i64 %v263, ptr %st126
  %st127 = getelementptr i64, ptr %v262, i64 1
  store i64 %v261, ptr %st127
  %st128 = getelementptr i64, ptr %v262, i64 2
  store i64 %v258, ptr %st128
  %v264.p = getelementptr i64, ptr %v262, i64 0
  %v264 = load i64, ptr %v264.p
  %v265.p = getelementptr i64, ptr %v262, i64 1
  %v265 = load i64, ptr %v265.p
  %v266.p = getelementptr i64, ptr %v262, i64 2
  %v266 = load i64, ptr %v266.p
  call void @"std/task.LocalNew"(ptr %v252, i64 %v253, i64 %v264, i64 %v265, i64 %v266)
  %v267 = getelementptr i64, ptr %s7, i64 0
  %v268.p = getelementptr i64, ptr %v252, i64 0
  %v268 = load i64, ptr %v268.p
  %st129 = getelementptr i64, ptr %v267, i64 0
  store i64 %v268, ptr %st129
  %v269.p = getelementptr i64, ptr %v252, i64 1
  %v269 = load i64, ptr %v269.p
  %st130 = getelementptr i64, ptr %v267, i64 1
  store i64 %v269, ptr %st130
  %v270.p = getelementptr i64, ptr %v252, i64 2
  %v270 = load i64, ptr %v270.p
  %st131 = getelementptr i64, ptr %v267, i64 2
  store i64 %v270, ptr %st131
  %v1031 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v267, i64 %v1031, i64 %v1)
  %v1032 = getelementptr i64, ptr @"rt.meta", i64 0
  %st132 = getelementptr i64, ptr %v1032, i64 0
  store i64 %v1, ptr %st132
  %v271 = getelementptr i64, ptr %s8, i64 0
  %v272.p = getelementptr i64, ptr %v267, i64 0
  %v272 = load i64, ptr %v272.p
  %st133 = getelementptr i64, ptr %v271, i64 0
  store i64 %v272, ptr %st133
  %v273.p = getelementptr i64, ptr %v267, i64 1
  %v273 = load i64, ptr %v273.p
  %st134 = getelementptr i64, ptr %v271, i64 1
  store i64 %v273, ptr %st134
  %v274.p = getelementptr i64, ptr %v267, i64 2
  %v274 = load i64, ptr %v274.p
  %st135 = getelementptr i64, ptr %v271, i64 2
  store i64 %v274, ptr %st135
  %v1033 = getelementptr i64, ptr @"rt.meta", i64 0
  %v275.p = getelementptr i64, ptr %v1033, i64 0
  %v275 = load i64, ptr %v275.p
  %v276 = add i64 0, 1
  %v277 = add i64 0, 4
  %v278 = getelementptr i64, ptr %s3, i64 0
  %v1034 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279.p = getelementptr i64, ptr %v1034, i64 0
  %v279 = load i64, ptr %v279.p
  %v280 = getelementptr i64, ptr %s4, i64 0
  %st136 = getelementptr i64, ptr %v280, i64 0
  store i64 %v276, ptr %st136
  %v1035 = getelementptr i64, ptr @"rt.meta", i64 0
  %v281.p = getelementptr i64, ptr %v1035, i64 0
  %v281 = load i64, ptr %v281.p
  br label %b50
b48:
  %v1036 = getelementptr i64, ptr @"rt.meta", i64 0
  %st137 = getelementptr i64, ptr %v1036, i64 0
  store i64 %v275, ptr %st137
  %v1037 = getelementptr i64, ptr @"rt.meta", i64 0
  %st138 = getelementptr i64, ptr %v1037, i64 0
  store i64 %v0, ptr %st138
  ret void
b49:
  br label %b48
b50:
  %v1038 = getelementptr i64, ptr @"rt.meta", i64 0
  %st139 = getelementptr i64, ptr %v1038, i64 0
  store i64 %v281, ptr %st139
  %v282.p = getelementptr i64, ptr %v280, i64 0
  %v282 = load i64, ptr %v282.p
  %v283.c = icmp slt i64 %v282, %v277
  %v283 = zext i1 %v283.c to i64
  %c.b50 = icmp ne i64 %v283, 0
  br i1 %c.b50, label %b50.t141, label %b50.e142
b50.t141:
  br label %b51
b50.e142:
  br label %b52
b51:
  call void @"rt.region_enter"()
  %v1039 = getelementptr i64, ptr @"rt.meta", i64 0
  %v284.p = getelementptr i64, ptr %v1039, i64 0
  %v284 = load i64, ptr %v284.p
  %v285.p = getelementptr i64, ptr %v280, i64 0
  %v285 = load i64, ptr %v285.p
  %v1040 = getelementptr i64, ptr @"rt.meta", i64 0
  %v286.p = getelementptr i64, ptr %v1040, i64 0
  %v286 = load i64, ptr %v286.p
  %v1041 = getelementptr i64, ptr @"rt.meta", i64 0
  %v287.p = getelementptr i64, ptr %v1041, i64 0
  %v287 = load i64, ptr %v287.p
  call void @"rt.region_enter"()
  %v1042 = getelementptr i64, ptr @"rt.meta", i64 0
  %v288.p = getelementptr i64, ptr %v1042, i64 0
  %v288 = load i64, ptr %v288.p
  %v289 = getelementptr i64, ptr %s6, i64 0
  %v290.p = getelementptr i64, ptr %v271, i64 0
  %v290 = load i64, ptr %v290.p
  %st142 = getelementptr i64, ptr %v289, i64 0
  store i64 %v290, ptr %st142
  %v291.p = getelementptr i64, ptr %v271, i64 1
  %v291 = load i64, ptr %v291.p
  %st143 = getelementptr i64, ptr %v289, i64 1
  store i64 %v291, ptr %st143
  %v292.p = getelementptr i64, ptr %v271, i64 2
  %v292 = load i64, ptr %v292.p
  %st144 = getelementptr i64, ptr %v289, i64 2
  store i64 %v292, ptr %st144
  %v293.p = getelementptr i64, ptr %v289, i64 0
  %v293 = load i64, ptr %v293.p
  %v294.p = getelementptr i64, ptr %v289, i64 1
  %v294 = load i64, ptr %v294.p
  %v295.p = getelementptr i64, ptr %v289, i64 2
  %v295 = load i64, ptr %v295.p
  %v296 = add i64 0, 2845814786215520742
  %v297 = call i64 @"std/task.LeaseTake"(i64 %v293, i64 %v294, i64 %v295, i64 %v296)
  %v298 = getelementptr i64, ptr %s1, i64 0
  %v299 = add i64 0, 0
  %st145 = getelementptr i64, ptr %v298, i64 0
  store i64 %v299, ptr %st145
  %st146 = getelementptr i64, ptr %v298, i64 1
  store i64 %v299, ptr %st146
  %st147 = getelementptr i64, ptr %v298, i64 2
  store i64 %v299, ptr %st147
  %st148 = getelementptr i64, ptr %v298, i64 3
  store i64 %v299, ptr %st148
  %st149 = getelementptr i64, ptr %v298, i64 4
  store i64 %v299, ptr %st149
  %st150 = getelementptr i64, ptr %v298, i64 5
  store i64 %v299, ptr %st150
  %st151 = getelementptr i64, ptr %v298, i64 6
  store i64 %v299, ptr %st151
  %st152 = getelementptr i64, ptr %v298, i64 7
  store i64 %v299, ptr %st152
  %st153 = getelementptr i64, ptr %v298, i64 8
  store i64 %v299, ptr %st153
  %v1043 = getelementptr i64, ptr @"rt.meta", i64 0
  %v300.p = getelementptr i64, ptr %v1043, i64 0
  %v300 = load i64, ptr %v300.p
  %v1044 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1045 = getelementptr i64, ptr %v1044, i64 %v300
  %v301.p = getelementptr i64, ptr %v1045, i64 1
  %v301 = load ptr, ptr %v301.p
  %v302 = ptrtoint ptr %v301 to i64
  %st154 = getelementptr i64, ptr %v298, i64 0
  store i64 %v302, ptr %st154
  %v303 = add i64 0, 0
  %st155 = getelementptr i64, ptr %v298, i64 1
  store i64 %v303, ptr %st155
  %st156 = getelementptr i64, ptr %v298, i64 2
  store i64 %v300, ptr %st156
  %v304 = add i64 0, 4
  %v305 = getelementptr i64, ptr %v298, i64 %v304
  %v1046 = getelementptr i64, ptr @"rt.meta", i64 0
  %v306.p = getelementptr i64, ptr %v1046, i64 0
  %v306 = load i64, ptr %v306.p
  %v1047 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1048 = getelementptr i64, ptr %v1047, i64 %v306
  %v307.p = getelementptr i64, ptr %v1048, i64 1
  %v307 = load ptr, ptr %v307.p
  %v308 = ptrtoint ptr %v307 to i64
  %st157 = getelementptr i64, ptr %v305, i64 0
  store i64 %v308, ptr %st157
  %v309 = add i64 0, 0
  %st158 = getelementptr i64, ptr %v305, i64 1
  store i64 %v309, ptr %st158
  %st159 = getelementptr i64, ptr %v305, i64 2
  store i64 %v306, ptr %st159
  %v310 = getelementptr i64, ptr %s0, i64 0
  %v311.p = getelementptr i64, ptr %v298, i64 0
  %v311 = load i64, ptr %v311.p
  %st160 = getelementptr i64, ptr %v310, i64 0
  store i64 %v311, ptr %st160
  %v312.p = getelementptr i64, ptr %v298, i64 1
  %v312 = load i64, ptr %v312.p
  %st161 = getelementptr i64, ptr %v310, i64 1
  store i64 %v312, ptr %st161
  %v313.p = getelementptr i64, ptr %v298, i64 2
  %v313 = load i64, ptr %v313.p
  %st162 = getelementptr i64, ptr %v310, i64 2
  store i64 %v313, ptr %st162
  %v314.p = getelementptr i64, ptr %v298, i64 3
  %v314 = load i64, ptr %v314.p
  %st163 = getelementptr i64, ptr %v310, i64 3
  store i64 %v314, ptr %st163
  %v315.p = getelementptr i64, ptr %v298, i64 4
  %v315 = load i64, ptr %v315.p
  %st164 = getelementptr i64, ptr %v310, i64 4
  store i64 %v315, ptr %st164
  %v316.p = getelementptr i64, ptr %v298, i64 5
  %v316 = load i64, ptr %v316.p
  %st165 = getelementptr i64, ptr %v310, i64 5
  store i64 %v316, ptr %st165
  %v317.p = getelementptr i64, ptr %v298, i64 6
  %v317 = load i64, ptr %v317.p
  %st166 = getelementptr i64, ptr %v310, i64 6
  store i64 %v317, ptr %st166
  %v318.p = getelementptr i64, ptr %v298, i64 7
  %v318 = load i64, ptr %v318.p
  %st167 = getelementptr i64, ptr %v310, i64 7
  store i64 %v318, ptr %st167
  %v319.p = getelementptr i64, ptr %v298, i64 8
  %v319 = load i64, ptr %v319.p
  %st168 = getelementptr i64, ptr %v310, i64 8
  store i64 %v319, ptr %st168
  %v320 = getelementptr i64, ptr %s14, i64 0
  %v321.p = getelementptr i64, ptr %v289, i64 0
  %v321 = load i64, ptr %v321.p
  %v322.p = getelementptr i64, ptr %v289, i64 1
  %v322 = load i64, ptr %v322.p
  %v323.p = getelementptr i64, ptr %v289, i64 2
  %v323 = load i64, ptr %v323.p
  call void @"std/task.LeaseBlock"(ptr %v320, i64 %v321, i64 %v322, i64 %v323)
  %v324 = getelementptr i64, ptr %s5, i64 0
  %v325.p = getelementptr i64, ptr %v320, i64 0
  %v325 = load i64, ptr %v325.p
  %st169 = getelementptr i64, ptr %v324, i64 0
  store i64 %v325, ptr %st169
  %v326.p = getelementptr i64, ptr %v320, i64 1
  %v326 = load i64, ptr %v326.p
  %st170 = getelementptr i64, ptr %v324, i64 1
  store i64 %v326, ptr %st170
  %v327.p = getelementptr i64, ptr %v320, i64 2
  %v327 = load i64, ptr %v327.p
  %st171 = getelementptr i64, ptr %v324, i64 2
  store i64 %v327, ptr %st171
  %v328 = add i64 0, 0
  %v329 = getelementptr i64, ptr %s11, i64 0
  %v1049 = getelementptr i64, ptr @"rt.meta", i64 0
  %v330.p = getelementptr i64, ptr %v1049, i64 0
  %v330 = load i64, ptr %v330.p
  %v331 = add i64 0, 0
  %v332.c = icmp slt i64 %v297, %v331
  %v332 = zext i1 %v332.c to i64
  %c.b51 = icmp ne i64 %v332, 0
  br i1 %c.b51, label %b51.t173, label %b51.e174
b51.t173:
  br label %b55
b51.e174:
  br label %b56
b52:
  %v1050 = getelementptr i64, ptr @"rt.meta", i64 0
  %st174 = getelementptr i64, ptr %v1050, i64 0
  store i64 %v281, ptr %st174
  br label %b49
b53:
  %v1051 = getelementptr i64, ptr @"rt.meta", i64 0
  %st175 = getelementptr i64, ptr %v1051, i64 0
  store i64 %v286, ptr %st175
  %v974 = add i64 0, 1
  %v975.p = getelementptr i64, ptr %v280, i64 0
  %v975 = load i64, ptr %v975.p
  %v976 = add i64 %v975, %v974
  %st176 = getelementptr i64, ptr %v280, i64 0
  store i64 %v976, ptr %st176
  br label %b50
b54:
  %v670 = getelementptr i64, ptr %s19, i64 0
  %v1052 = getelementptr i64, ptr @"rt.meta", i64 0
  %v671.p = getelementptr i64, ptr %v1052, i64 0
  %v671 = load i64, ptr %v671.p
  %v672 = getelementptr i64, ptr %s9, i64 0
  %v1053 = getelementptr i64, ptr @"rt.meta", i64 0
  %v673.p = getelementptr i64, ptr %v1053, i64 0
  %v673 = load i64, ptr %v673.p
  %v674 = getelementptr i64, ptr %s11, i64 0
  %v1054 = getelementptr i64, ptr @"rt.meta", i64 0
  %v675.p = getelementptr i64, ptr %v1054, i64 0
  %v675 = load i64, ptr %v675.p
  %v676.p = getelementptr i64, ptr %v310, i64 1
  %v676 = load i64, ptr %v676.p
  %st177 = getelementptr i64, ptr %v674, i64 0
  store i64 %v676, ptr %st177
  %v1055 = getelementptr i64, ptr @"rt.meta", i64 0
  %st178 = getelementptr i64, ptr %v1055, i64 0
  store i64 %v675, ptr %st178
  br label %b126
b55:
  %v333 = add i64 0, 2
  %v334 = add i64 %v333, %v328
  %v335.p = getelementptr i64, ptr %v324, i64 1
  %v335 = load i64, ptr %v335.p
  %v336.c = icmp uge i64 %v334, %v335
  %v336 = zext i1 %v336.c to i64
  %c.b55 = icmp ne i64 %v336, 0
  br i1 %c.b55, label %b55.t180, label %b55.e181
b55.t180:
  br label %b57
b55.e181:
  br label %b58
b56:
  br label %b103
b57:
  %v337 = add i64 0, 3
  call void @"rt.panic"(i64 %v337)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b58:
  %v338.p = getelementptr i64, ptr %v324, i64 0
  %v338 = load i64, ptr %v338.p
  %v339 = inttoptr i64 %v338 to ptr
  %v340 = add i64 0, 1
  %v341 = mul i64 %v334, %v340
  %v342 = getelementptr i64, ptr %v339, i64 %v341
  %v343.p = getelementptr i64, ptr %v342, i64 0
  %v343 = load i64, ptr %v343.p
  %v344 = getelementptr i64, ptr %s9, i64 0
  %v1056 = getelementptr i64, ptr @"rt.meta", i64 0
  %v345.p = getelementptr i64, ptr %v1056, i64 0
  %v345 = load i64, ptr %v345.p
  %v346.p = getelementptr i64, ptr %v310, i64 1
  %v346 = load i64, ptr %v346.p
  %v347 = add i64 0, 0
  %v348.c = icmp sgt i64 %v346, %v347
  %v348 = zext i1 %v348.c to i64
  %c.b58 = icmp ne i64 %v348, 0
  br i1 %c.b58, label %b58.t182, label %b58.e183
b58.t182:
  br label %b60
b58.e183:
  br label %b61
b59:
  %v1057 = getelementptr i64, ptr @"rt.meta", i64 0
  %st183 = getelementptr i64, ptr %v1057, i64 0
  store i64 %v330, ptr %st183
  br label %b54
b60:
  %v349 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v350 = add i64 0, 2
  %st184 = getelementptr i64, ptr %v349, i64 1026
  store i64 %v350, ptr %st184
  %v351 = getelementptr i64, ptr @"str.0", i64 0
  %v352 = add i64 0, 7
  %v353 = add i64 0, 0
  %v354 = getelementptr i64, ptr %s15, i64 0
  %v355 = ptrtoint ptr %v351 to i64
  %st185 = getelementptr i64, ptr %v354, i64 0
  store i64 %v355, ptr %st185
  %st186 = getelementptr i64, ptr %v354, i64 1
  store i64 %v352, ptr %st186
  %st187 = getelementptr i64, ptr %v354, i64 2
  store i64 %v353, ptr %st187
  call void @"rt.print_str"(ptr %v354)
  %v356 = getelementptr i64, ptr @"str.1", i64 0
  %v357 = add i64 0, 17
  %v358 = add i64 0, 0
  %v359 = getelementptr i64, ptr %s16, i64 0
  %v360 = ptrtoint ptr %v356 to i64
  %st188 = getelementptr i64, ptr %v359, i64 0
  store i64 %v360, ptr %st188
  %st189 = getelementptr i64, ptr %v359, i64 1
  store i64 %v357, ptr %st189
  %st190 = getelementptr i64, ptr %v359, i64 2
  store i64 %v358, ptr %st190
  call void @"rt.print_str"(ptr %v359)
  %v361 = getelementptr i64, ptr @"str.2", i64 0
  %v362 = add i64 0, 1
  %v363 = add i64 0, 0
  %v364 = getelementptr i64, ptr %s17, i64 0
  %v365 = ptrtoint ptr %v361 to i64
  %st191 = getelementptr i64, ptr %v364, i64 0
  store i64 %v365, ptr %st191
  %st192 = getelementptr i64, ptr %v364, i64 1
  store i64 %v362, ptr %st192
  %st193 = getelementptr i64, ptr %v364, i64 2
  store i64 %v363, ptr %st193
  call void @"rt.print_str"(ptr %v364)
  %v366 = getelementptr i64, ptr @"str.3", i64 0
  %v367 = add i64 0, 1
  %v368 = add i64 0, 0
  %v369 = getelementptr i64, ptr %s18, i64 0
  %v370 = ptrtoint ptr %v366 to i64
  %st194 = getelementptr i64, ptr %v369, i64 0
  store i64 %v370, ptr %st194
  %st195 = getelementptr i64, ptr %v369, i64 1
  store i64 %v367, ptr %st195
  %st196 = getelementptr i64, ptr %v369, i64 2
  store i64 %v368, ptr %st196
  call void @"rt.print_str"(ptr %v369)
  %v371 = add i64 0, 4
  call void @"rt.panic"(i64 %v371)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b61:
  br label %b62
b62:
  %v372 = add i64 0, 0
  %v373 = add i64 0, 3
  %v374 = getelementptr i64, ptr %v310, i64 %v373
  %st197 = getelementptr i64, ptr %v374, i64 0
  store i64 %v372, ptr %st197
  %v375 = getelementptr i64, ptr %s10, i64 0
  %v1058 = getelementptr i64, ptr @"rt.meta", i64 0
  %v376.p = getelementptr i64, ptr %v1058, i64 0
  %v376 = load i64, ptr %v376.p
  %v377 = add i64 0, 256
  %v378.c = icmp slt i64 %v343, %v377
  %v378 = zext i1 %v378.c to i64
  %c.b62 = icmp ne i64 %v378, 0
  br i1 %c.b62, label %b62.t199, label %b62.e200
b62.t199:
  br label %b64
b62.e200:
  br label %b65
b63:
  br label %b59
b64:
  br label %b66
b65:
  %v379 = add i64 0, 256
  br label %b66
b66:
  %v380 = phi i64 [ %v343, %b64 ], [ %v379, %b65 ]
  %v1059 = getelementptr i64, ptr @"rt.meta", i64 0
  %v381.p = getelementptr i64, ptr %v1059, i64 0
  %v381 = load i64, ptr %v381.p
  %v382 = add i64 0, 0
  %v383 = call ptr @"rt.region_alloc"(i64 %v381, i64 %v382)
  %v384 = add i64 0, 0
  %v385 = getelementptr i64, ptr %s18, i64 0
  %v386 = ptrtoint ptr %v383 to i64
  %st200 = getelementptr i64, ptr %v385, i64 0
  store i64 %v386, ptr %st200
  %st201 = getelementptr i64, ptr %v385, i64 1
  store i64 %v384, ptr %st201
  %st202 = getelementptr i64, ptr %v385, i64 2
  store i64 %v381, ptr %st202
  %v387 = getelementptr i64, ptr %s17, i64 0
  %v388.p = getelementptr i64, ptr %v385, i64 0
  %v388 = load i64, ptr %v388.p
  %st203 = getelementptr i64, ptr %v387, i64 0
  store i64 %v388, ptr %st203
  %v389.p = getelementptr i64, ptr %v385, i64 1
  %v389 = load i64, ptr %v389.p
  %st204 = getelementptr i64, ptr %v387, i64 1
  store i64 %v389, ptr %st204
  %v390.p = getelementptr i64, ptr %v385, i64 2
  %v390 = load i64, ptr %v390.p
  %st205 = getelementptr i64, ptr %v387, i64 2
  store i64 %v390, ptr %st205
  %v1060 = getelementptr i64, ptr @"rt.meta", i64 0
  %v391.p = getelementptr i64, ptr %v1060, i64 0
  %v391 = load i64, ptr %v391.p
  %v392 = add i64 0, 0
  %v393 = getelementptr i64, ptr %s12, i64 0
  %v1061 = getelementptr i64, ptr @"rt.meta", i64 0
  %v394.p = getelementptr i64, ptr %v1061, i64 0
  %v394 = load i64, ptr %v394.p
  %v395 = getelementptr i64, ptr %s19, i64 0
  %st206 = getelementptr i64, ptr %v395, i64 0
  store i64 %v392, ptr %st206
  %v1062 = getelementptr i64, ptr @"rt.meta", i64 0
  %v396.p = getelementptr i64, ptr %v1062, i64 0
  %v396 = load i64, ptr %v396.p
  br label %b69
b67:
  %v1063 = getelementptr i64, ptr @"rt.meta", i64 0
  %st207 = getelementptr i64, ptr %v1063, i64 0
  store i64 %v391, ptr %st207
  %v438 = getelementptr i64, ptr %s16, i64 0
  %v439.p = getelementptr i64, ptr %v387, i64 0
  %v439 = load i64, ptr %v439.p
  %st208 = getelementptr i64, ptr %v438, i64 0
  store i64 %v439, ptr %st208
  %v440.p = getelementptr i64, ptr %v387, i64 1
  %v440 = load i64, ptr %v440.p
  %st209 = getelementptr i64, ptr %v438, i64 1
  store i64 %v440, ptr %st209
  %v441.p = getelementptr i64, ptr %v387, i64 2
  %v441 = load i64, ptr %v441.p
  %st210 = getelementptr i64, ptr %v438, i64 2
  store i64 %v441, ptr %st210
  %v442 = add i64 0, 0
  %v443 = getelementptr i64, ptr %s19, i64 0
  %st211 = getelementptr i64, ptr %v443, i64 0
  store i64 %v442, ptr %st211
  %v1064 = getelementptr i64, ptr @"rt.meta", i64 0
  %v444.p = getelementptr i64, ptr %v1064, i64 0
  %v444 = load i64, ptr %v444.p
  br label %b76
b68:
  br label %b67
b69:
  %v1065 = getelementptr i64, ptr @"rt.meta", i64 0
  %st212 = getelementptr i64, ptr %v1065, i64 0
  store i64 %v396, ptr %st212
  %v397.p = getelementptr i64, ptr %v395, i64 0
  %v397 = load i64, ptr %v397.p
  %v398.c = icmp slt i64 %v397, %v380
  %v398 = zext i1 %v398.c to i64
  %c.b69 = icmp ne i64 %v398, 0
  br i1 %c.b69, label %b69.t214, label %b69.e215
b69.t214:
  br label %b70
b69.e215:
  br label %b71
b70:
  call void @"rt.region_enter"()
  %v1066 = getelementptr i64, ptr @"rt.meta", i64 0
  %v399.p = getelementptr i64, ptr %v1066, i64 0
  %v399 = load i64, ptr %v399.p
  %v400.p = getelementptr i64, ptr %v395, i64 0
  %v400 = load i64, ptr %v400.p
  %v1067 = getelementptr i64, ptr @"rt.meta", i64 0
  %v401.p = getelementptr i64, ptr %v1067, i64 0
  %v401 = load i64, ptr %v401.p
  %v402 = getelementptr i64, ptr %s18, i64 0
  %v403.p = getelementptr i64, ptr %v387, i64 0
  %v403 = load i64, ptr %v403.p
  %st215 = getelementptr i64, ptr %v402, i64 0
  store i64 %v403, ptr %st215
  %v404.p = getelementptr i64, ptr %v387, i64 1
  %v404 = load i64, ptr %v404.p
  %st216 = getelementptr i64, ptr %v402, i64 1
  store i64 %v404, ptr %st216
  %v405.p = getelementptr i64, ptr %v387, i64 2
  %v405 = load i64, ptr %v405.p
  %st217 = getelementptr i64, ptr %v402, i64 2
  store i64 %v405, ptr %st217
  %v406 = add i64 0, 0
  %v407.p = getelementptr i64, ptr %v402, i64 2
  %v407 = load i64, ptr %v407.p
  %v408.p = getelementptr i64, ptr %v402, i64 0
  %v408 = load i64, ptr %v408.p
  %v409.p = getelementptr i64, ptr %v402, i64 1
  %v409 = load i64, ptr %v409.p
  %v412 = add i64 0, 8
  %v413 = mul i64 %v409, %v412
  %v414 = add i64 %v408, %v413
  %v1068 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1069 = getelementptr i64, ptr %v1068, i64 %v407
  %v415.p = getelementptr i64, ptr %v1069, i64 1
  %v415 = load ptr, ptr %v415.p
  %v416 = ptrtoint ptr %v415 to i64
  %v417.c = icmp eq i64 %v416, %v414
  %v417 = zext i1 %v417.c to i64
  %c.b70 = icmp ne i64 %v417, 0
  br i1 %c.b70, label %b70.t219, label %b70.e220
b70.t219:
  br label %b75
b70.e220:
  br label %b74
b71:
  %v1070 = getelementptr i64, ptr @"rt.meta", i64 0
  %st220 = getelementptr i64, ptr %v1070, i64 0
  store i64 %v396, ptr %st220
  br label %b68
b72:
  %v1071 = getelementptr i64, ptr @"rt.meta", i64 0
  %st221 = getelementptr i64, ptr %v1071, i64 0
  store i64 %v401, ptr %st221
  %v435 = add i64 0, 1
  %v436.p = getelementptr i64, ptr %v395, i64 0
  %v436 = load i64, ptr %v436.p
  %v437 = add i64 %v436, %v435
  %st222 = getelementptr i64, ptr %v395, i64 0
  store i64 %v437, ptr %st222
  br label %b69
b73:
  %v410 = phi ptr [ %v425, %b74 ], [ %v420, %b75 ]
  %v411 = phi ptr [ %v426, %b74 ], [ %v419, %b75 ]
  %st223 = getelementptr i64, ptr %v411, i64 0
  store i64 %v406, ptr %st223
  %v427.p = getelementptr i64, ptr %v402, i64 1
  %v427 = load i64, ptr %v427.p
  %v428 = add i64 0, 1
  %v429 = add i64 %v427, %v428
  %v430 = getelementptr i64, ptr %s16, i64 0
  %v431 = ptrtoint ptr %v410 to i64
  %st224 = getelementptr i64, ptr %v430, i64 0
  store i64 %v431, ptr %st224
  %st225 = getelementptr i64, ptr %v430, i64 1
  store i64 %v429, ptr %st225
  %st226 = getelementptr i64, ptr %v430, i64 2
  store i64 %v407, ptr %st226
  %v432.p = getelementptr i64, ptr %v430, i64 0
  %v432 = load i64, ptr %v432.p
  %st227 = getelementptr i64, ptr %v387, i64 0
  store i64 %v432, ptr %st227
  %v433.p = getelementptr i64, ptr %v430, i64 1
  %v433 = load i64, ptr %v433.p
  %st228 = getelementptr i64, ptr %v387, i64 1
  store i64 %v433, ptr %st228
  %v434.p = getelementptr i64, ptr %v430, i64 2
  %v434 = load i64, ptr %v434.p
  %st229 = getelementptr i64, ptr %v387, i64 2
  store i64 %v434, ptr %st229
  br label %b72
b74:
  %v421 = add i64 0, 1
  %v422 = mul i64 %v409, %v421
  %v423 = add i64 0, 1
  %v424 = add i64 0, 1
  %v425 = call ptr @"rt.slice_grow"(i64 %v408, i64 %v409, i64 %v423, i64 %v407, i64 %v424)
  %v426 = getelementptr i64, ptr %v425, i64 %v422
  br label %b73
b75:
  %v418 = add i64 0, 1
  %v419 = call ptr @"rt.region_alloc"(i64 %v407, i64 %v418)
  %v420 = inttoptr i64 %v408 to ptr
  br label %b73
b76:
  %v1072 = getelementptr i64, ptr @"rt.meta", i64 0
  %st230 = getelementptr i64, ptr %v1072, i64 0
  store i64 %v444, ptr %st230
  %v445.p = getelementptr i64, ptr %v443, i64 0
  %v445 = load i64, ptr %v445.p
  %v446 = add i64 %v445, %v380
  %v447.c = icmp sle i64 %v446, %v343
  %v447 = zext i1 %v447.c to i64
  %c.b76 = icmp ne i64 %v447, 0
  br i1 %c.b76, label %b76.t232, label %b76.e233
b76.t232:
  br label %b79
b76.e233:
  br label %b80
b77:
  call void @"rt.region_enter"()
  %v1073 = getelementptr i64, ptr @"rt.meta", i64 0
  %v451.p = getelementptr i64, ptr %v1073, i64 0
  %v451 = load i64, ptr %v451.p
  %v1074 = getelementptr i64, ptr @"rt.meta", i64 0
  %v452.p = getelementptr i64, ptr %v1074, i64 0
  %v452 = load i64, ptr %v452.p
  %v453 = add i64 0, 0
  %v454 = getelementptr i64, ptr %s12, i64 0
  %v1075 = getelementptr i64, ptr @"rt.meta", i64 0
  %v455.p = getelementptr i64, ptr %v1075, i64 0
  %v455 = load i64, ptr %v455.p
  %v456 = getelementptr i64, ptr %s20, i64 0
  %st233 = getelementptr i64, ptr %v456, i64 0
  store i64 %v453, ptr %st233
  %v1076 = getelementptr i64, ptr @"rt.meta", i64 0
  %v457.p = getelementptr i64, ptr %v1076, i64 0
  %v457 = load i64, ptr %v457.p
  br label %b83
b78:
  %v1077 = getelementptr i64, ptr @"rt.meta", i64 0
  %st234 = getelementptr i64, ptr %v1077, i64 0
  store i64 %v444, ptr %st234
  %v1078 = getelementptr i64, ptr @"rt.meta", i64 0
  %v509.p = getelementptr i64, ptr %v1078, i64 0
  %v509 = load i64, ptr %v509.p
  %v510 = add i64 0, 0
  %v511.p = getelementptr i64, ptr %v443, i64 0
  %v511 = load i64, ptr %v511.p
  %v512 = sub i64 %v343, %v511
  %v513 = getelementptr i64, ptr %s20, i64 0
  %v1079 = getelementptr i64, ptr @"rt.meta", i64 0
  %v514.p = getelementptr i64, ptr %v1079, i64 0
  %v514 = load i64, ptr %v514.p
  %v515 = getelementptr i64, ptr %s12, i64 0
  %st235 = getelementptr i64, ptr %v515, i64 0
  store i64 %v510, ptr %st235
  %v1080 = getelementptr i64, ptr @"rt.meta", i64 0
  %v516.p = getelementptr i64, ptr %v1080, i64 0
  %v516 = load i64, ptr %v516.p
  br label %b94
b79:
  %v449 = add i64 0, 0
  %v450.c = icmp sgt i64 %v380, %v449
  %v450 = zext i1 %v450.c to i64
  br label %b80
b80:
  %v448 = phi i64 [ %v447, %b76.e233 ], [ %v450, %b79 ]
  %c.b80 = icmp ne i64 %v448, 0
  br i1 %c.b80, label %b80.t237, label %b80.e238
b80.t237:
  br label %b77
b80.e238:
  br label %b78
b81:
  %v1081 = getelementptr i64, ptr @"rt.meta", i64 0
  %st238 = getelementptr i64, ptr %v1081, i64 0
  store i64 %v452, ptr %st238
  %v507.p = getelementptr i64, ptr %v443, i64 0
  %v507 = load i64, ptr %v507.p
  %v508 = add i64 %v507, %v380
  %st239 = getelementptr i64, ptr %v443, i64 0
  store i64 %v508, ptr %st239
  br label %b76
b82:
  br label %b81
b83:
  %v1082 = getelementptr i64, ptr @"rt.meta", i64 0
  %st240 = getelementptr i64, ptr %v1082, i64 0
  store i64 %v457, ptr %st240
  %v458.p = getelementptr i64, ptr %v456, i64 0
  %v458 = load i64, ptr %v458.p
  %v459.c = icmp slt i64 %v458, %v380
  %v459 = zext i1 %v459.c to i64
  %c.b83 = icmp ne i64 %v459, 0
  br i1 %c.b83, label %b83.t242, label %b83.e243
b83.t242:
  br label %b84
b83.e243:
  br label %b85
b84:
  call void @"rt.region_enter"()
  %v1083 = getelementptr i64, ptr @"rt.meta", i64 0
  %v460.p = getelementptr i64, ptr %v1083, i64 0
  %v460 = load i64, ptr %v460.p
  %v461.p = getelementptr i64, ptr %v456, i64 0
  %v461 = load i64, ptr %v461.p
  %v1084 = getelementptr i64, ptr @"rt.meta", i64 0
  %v462.p = getelementptr i64, ptr %v1084, i64 0
  %v462 = load i64, ptr %v462.p
  %v463 = getelementptr i64, ptr %s18, i64 0
  %v464.p = getelementptr i64, ptr %v310, i64 0
  %v464 = load i64, ptr %v464.p
  %st243 = getelementptr i64, ptr %v463, i64 0
  store i64 %v464, ptr %st243
  %v465.p = getelementptr i64, ptr %v310, i64 1
  %v465 = load i64, ptr %v465.p
  %st244 = getelementptr i64, ptr %v463, i64 1
  store i64 %v465, ptr %st244
  %v466.p = getelementptr i64, ptr %v310, i64 2
  %v466 = load i64, ptr %v466.p
  %st245 = getelementptr i64, ptr %v463, i64 2
  store i64 %v466, ptr %st245
  %v467.p = getelementptr i64, ptr %v438, i64 1
  %v467 = load i64, ptr %v467.p
  %v468.c = icmp uge i64 %v461, %v467
  %v468 = zext i1 %v468.c to i64
  %c.b84 = icmp ne i64 %v468, 0
  br i1 %c.b84, label %b84.t247, label %b84.e248
b84.t247:
  br label %b87
b84.e248:
  br label %b88
b85:
  %v1085 = getelementptr i64, ptr @"rt.meta", i64 0
  %st248 = getelementptr i64, ptr %v1085, i64 0
  store i64 %v457, ptr %st248
  br label %b82
b86:
  %v1086 = getelementptr i64, ptr @"rt.meta", i64 0
  %st249 = getelementptr i64, ptr %v1086, i64 0
  store i64 %v462, ptr %st249
  %v504 = add i64 0, 1
  %v505.p = getelementptr i64, ptr %v456, i64 0
  %v505 = load i64, ptr %v505.p
  %v506 = add i64 %v505, %v504
  %st250 = getelementptr i64, ptr %v456, i64 0
  store i64 %v506, ptr %st250
  br label %b83
b87:
  %v469 = add i64 0, 5
  call void @"rt.panic"(i64 %v469)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b88:
  %v470.p = getelementptr i64, ptr %v438, i64 0
  %v470 = load i64, ptr %v470.p
  %v471 = inttoptr i64 %v470 to ptr
  %v472 = add i64 0, 1
  %v473 = mul i64 %v461, %v472
  %v474 = getelementptr i64, ptr %v471, i64 %v473
  %v475.p = getelementptr i64, ptr %v474, i64 0
  %v475 = load i64, ptr %v475.p
  %v476.p = getelementptr i64, ptr %v463, i64 2
  %v476 = load i64, ptr %v476.p
  %v477.p = getelementptr i64, ptr %v463, i64 0
  %v477 = load i64, ptr %v477.p
  %v478.p = getelementptr i64, ptr %v463, i64 1
  %v478 = load i64, ptr %v478.p
  %v481 = add i64 0, 8
  %v482 = mul i64 %v478, %v481
  %v483 = add i64 %v477, %v482
  %v1087 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1088 = getelementptr i64, ptr %v1087, i64 %v476
  %v484.p = getelementptr i64, ptr %v1088, i64 1
  %v484 = load ptr, ptr %v484.p
  %v485 = ptrtoint ptr %v484 to i64
  %v486.c = icmp eq i64 %v485, %v483
  %v486 = zext i1 %v486.c to i64
  %c.b88 = icmp ne i64 %v486, 0
  br i1 %c.b88, label %b88.t252, label %b88.e253
b88.t252:
  br label %b91
b88.e253:
  br label %b90
b89:
  %v479 = phi ptr [ %v494, %b90 ], [ %v489, %b91 ]
  %v480 = phi ptr [ %v495, %b90 ], [ %v488, %b91 ]
  %st253 = getelementptr i64, ptr %v480, i64 0
  store i64 %v475, ptr %st253
  %v496.p = getelementptr i64, ptr %v463, i64 1
  %v496 = load i64, ptr %v496.p
  %v497 = add i64 0, 1
  %v498 = add i64 %v496, %v497
  %v499 = getelementptr i64, ptr %s15, i64 0
  %v500 = ptrtoint ptr %v479 to i64
  %st254 = getelementptr i64, ptr %v499, i64 0
  store i64 %v500, ptr %st254
  %st255 = getelementptr i64, ptr %v499, i64 1
  store i64 %v498, ptr %st255
  %st256 = getelementptr i64, ptr %v499, i64 2
  store i64 %v476, ptr %st256
  %v501.p = getelementptr i64, ptr %v499, i64 0
  %v501 = load i64, ptr %v501.p
  %st257 = getelementptr i64, ptr %v310, i64 0
  store i64 %v501, ptr %st257
  %v502.p = getelementptr i64, ptr %v499, i64 1
  %v502 = load i64, ptr %v502.p
  %st258 = getelementptr i64, ptr %v310, i64 1
  store i64 %v502, ptr %st258
  %v503.p = getelementptr i64, ptr %v499, i64 2
  %v503 = load i64, ptr %v503.p
  %st259 = getelementptr i64, ptr %v310, i64 2
  store i64 %v503, ptr %st259
  br label %b86
b90:
  %v490 = add i64 0, 1
  %v491 = mul i64 %v478, %v490
  %v492 = add i64 0, 1
  %v493 = add i64 0, 1
  %v494 = call ptr @"rt.slice_grow"(i64 %v477, i64 %v478, i64 %v492, i64 %v476, i64 %v493)
  %v495 = getelementptr i64, ptr %v494, i64 %v491
  br label %b89
b91:
  %v487 = add i64 0, 1
  %v488 = call ptr @"rt.region_alloc"(i64 %v476, i64 %v487)
  %v489 = inttoptr i64 %v477 to ptr
  br label %b89
b92:
  %v1089 = getelementptr i64, ptr @"rt.meta", i64 0
  %st260 = getelementptr i64, ptr %v1089, i64 0
  store i64 %v509, ptr %st260
  br label %b63
b93:
  br label %b92
b94:
  %v1090 = getelementptr i64, ptr @"rt.meta", i64 0
  %st261 = getelementptr i64, ptr %v1090, i64 0
  store i64 %v516, ptr %st261
  %v517.p = getelementptr i64, ptr %v515, i64 0
  %v517 = load i64, ptr %v517.p
  %v518.c = icmp slt i64 %v517, %v512
  %v518 = zext i1 %v518.c to i64
  %c.b94 = icmp ne i64 %v518, 0
  br i1 %c.b94, label %b94.t263, label %b94.e264
b94.t263:
  br label %b95
b94.e264:
  br label %b96
b95:
  call void @"rt.region_enter"()
  %v1091 = getelementptr i64, ptr @"rt.meta", i64 0
  %v519.p = getelementptr i64, ptr %v1091, i64 0
  %v519 = load i64, ptr %v519.p
  %v520.p = getelementptr i64, ptr %v515, i64 0
  %v520 = load i64, ptr %v520.p
  %v1092 = getelementptr i64, ptr @"rt.meta", i64 0
  %v521.p = getelementptr i64, ptr %v1092, i64 0
  %v521 = load i64, ptr %v521.p
  %v522 = getelementptr i64, ptr %s15, i64 0
  %v523.p = getelementptr i64, ptr %v310, i64 0
  %v523 = load i64, ptr %v523.p
  %st264 = getelementptr i64, ptr %v522, i64 0
  store i64 %v523, ptr %st264
  %v524.p = getelementptr i64, ptr %v310, i64 1
  %v524 = load i64, ptr %v524.p
  %st265 = getelementptr i64, ptr %v522, i64 1
  store i64 %v524, ptr %st265
  %v525.p = getelementptr i64, ptr %v310, i64 2
  %v525 = load i64, ptr %v525.p
  %st266 = getelementptr i64, ptr %v522, i64 2
  store i64 %v525, ptr %st266
  %v526.p = getelementptr i64, ptr %v438, i64 1
  %v526 = load i64, ptr %v526.p
  %v527.c = icmp uge i64 %v520, %v526
  %v527 = zext i1 %v527.c to i64
  %c.b95 = icmp ne i64 %v527, 0
  br i1 %c.b95, label %b95.t268, label %b95.e269
b95.t268:
  br label %b98
b95.e269:
  br label %b99
b96:
  %v1093 = getelementptr i64, ptr @"rt.meta", i64 0
  %st269 = getelementptr i64, ptr %v1093, i64 0
  store i64 %v516, ptr %st269
  br label %b93
b97:
  %v1094 = getelementptr i64, ptr @"rt.meta", i64 0
  %st270 = getelementptr i64, ptr %v1094, i64 0
  store i64 %v521, ptr %st270
  %v563 = add i64 0, 1
  %v564.p = getelementptr i64, ptr %v515, i64 0
  %v564 = load i64, ptr %v564.p
  %v565 = add i64 %v564, %v563
  %st271 = getelementptr i64, ptr %v515, i64 0
  store i64 %v565, ptr %st271
  br label %b94
b98:
  %v528 = add i64 0, 6
  call void @"rt.panic"(i64 %v528)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b99:
  %v529.p = getelementptr i64, ptr %v438, i64 0
  %v529 = load i64, ptr %v529.p
  %v530 = inttoptr i64 %v529 to ptr
  %v531 = add i64 0, 1
  %v532 = mul i64 %v520, %v531
  %v533 = getelementptr i64, ptr %v530, i64 %v532
  %v534.p = getelementptr i64, ptr %v533, i64 0
  %v534 = load i64, ptr %v534.p
  %v535.p = getelementptr i64, ptr %v522, i64 2
  %v535 = load i64, ptr %v535.p
  %v536.p = getelementptr i64, ptr %v522, i64 0
  %v536 = load i64, ptr %v536.p
  %v537.p = getelementptr i64, ptr %v522, i64 1
  %v537 = load i64, ptr %v537.p
  %v540 = add i64 0, 8
  %v541 = mul i64 %v537, %v540
  %v542 = add i64 %v536, %v541
  %v1095 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1096 = getelementptr i64, ptr %v1095, i64 %v535
  %v543.p = getelementptr i64, ptr %v1096, i64 1
  %v543 = load ptr, ptr %v543.p
  %v544 = ptrtoint ptr %v543 to i64
  %v545.c = icmp eq i64 %v544, %v542
  %v545 = zext i1 %v545.c to i64
  %c.b99 = icmp ne i64 %v545, 0
  br i1 %c.b99, label %b99.t273, label %b99.e274
b99.t273:
  br label %b102
b99.e274:
  br label %b101
b100:
  %v538 = phi ptr [ %v553, %b101 ], [ %v548, %b102 ]
  %v539 = phi ptr [ %v554, %b101 ], [ %v547, %b102 ]
  %st274 = getelementptr i64, ptr %v539, i64 0
  store i64 %v534, ptr %st274
  %v555.p = getelementptr i64, ptr %v522, i64 1
  %v555 = load i64, ptr %v555.p
  %v556 = add i64 0, 1
  %v557 = add i64 %v555, %v556
  %v558 = getelementptr i64, ptr %s18, i64 0
  %v559 = ptrtoint ptr %v538 to i64
  %st275 = getelementptr i64, ptr %v558, i64 0
  store i64 %v559, ptr %st275
  %st276 = getelementptr i64, ptr %v558, i64 1
  store i64 %v557, ptr %st276
  %st277 = getelementptr i64, ptr %v558, i64 2
  store i64 %v535, ptr %st277
  %v560.p = getelementptr i64, ptr %v558, i64 0
  %v560 = load i64, ptr %v560.p
  %st278 = getelementptr i64, ptr %v310, i64 0
  store i64 %v560, ptr %st278
  %v561.p = getelementptr i64, ptr %v558, i64 1
  %v561 = load i64, ptr %v561.p
  %st279 = getelementptr i64, ptr %v310, i64 1
  store i64 %v561, ptr %st279
  %v562.p = getelementptr i64, ptr %v558, i64 2
  %v562 = load i64, ptr %v562.p
  %st280 = getelementptr i64, ptr %v310, i64 2
  store i64 %v562, ptr %st280
  br label %b97
b101:
  %v549 = add i64 0, 1
  %v550 = mul i64 %v537, %v549
  %v551 = add i64 0, 1
  %v552 = add i64 0, 1
  %v553 = call ptr @"rt.slice_grow"(i64 %v536, i64 %v537, i64 %v551, i64 %v535, i64 %v552)
  %v554 = getelementptr i64, ptr %v553, i64 %v550
  br label %b100
b102:
  %v546 = add i64 0, 1
  %v547 = call ptr @"rt.region_alloc"(i64 %v535, i64 %v546)
  %v548 = inttoptr i64 %v536 to ptr
  br label %b100
b103:
  %v566 = add i64 0, 2
  %v567 = add i64 %v297, %v566
  %v568 = getelementptr i64, ptr %s9, i64 0
  %st281 = getelementptr i64, ptr %v568, i64 0
  store i64 %v567, ptr %st281
  %v569 = add i64 0, 0
  %v570 = getelementptr i64, ptr %s19, i64 0
  %st282 = getelementptr i64, ptr %v570, i64 0
  store i64 %v569, ptr %st282
  %v1097 = getelementptr i64, ptr @"rt.meta", i64 0
  %v571.p = getelementptr i64, ptr %v1097, i64 0
  %v571 = load i64, ptr %v571.p
  br label %b104
b104:
  %v1098 = getelementptr i64, ptr @"rt.meta", i64 0
  %st283 = getelementptr i64, ptr %v1098, i64 0
  store i64 %v571, ptr %st283
  %v572.p = getelementptr i64, ptr %v570, i64 0
  %v572 = load i64, ptr %v572.p
  %v573.c = icmp slt i64 %v572, %v328
  %v573 = zext i1 %v573.c to i64
  %c.b104 = icmp ne i64 %v573, 0
  br i1 %c.b104, label %b104.t285, label %b104.e286
b104.t285:
  br label %b105
b104.e286:
  br label %b106
b105:
  call void @"rt.region_enter"()
  %v1099 = getelementptr i64, ptr @"rt.meta", i64 0
  %v574.p = getelementptr i64, ptr %v1099, i64 0
  %v574 = load i64, ptr %v574.p
  %v575 = add i64 0, 1
  %v576 = add i64 0, 2
  %v577.p = getelementptr i64, ptr %v570, i64 0
  %v577 = load i64, ptr %v577.p
  %v578 = add i64 %v576, %v577
  %v579.p = getelementptr i64, ptr %v324, i64 1
  %v579 = load i64, ptr %v579.p
  %v580.c = icmp uge i64 %v578, %v579
  %v580 = zext i1 %v580.c to i64
  %c.b105 = icmp ne i64 %v580, 0
  br i1 %c.b105, label %b105.t287, label %b105.e288
b105.t287:
  br label %b107
b105.e288:
  br label %b108
b106:
  %v1100 = getelementptr i64, ptr @"rt.meta", i64 0
  %st288 = getelementptr i64, ptr %v1100, i64 0
  store i64 %v571, ptr %st288
  %v594 = add i64 0, 2
  %v595 = add i64 %v594, %v328
  %v596.p = getelementptr i64, ptr %v324, i64 1
  %v596 = load i64, ptr %v596.p
  %v597.c = icmp uge i64 %v595, %v596
  %v597 = zext i1 %v597.c to i64
  %c.b106 = icmp ne i64 %v597, 0
  br i1 %c.b106, label %b106.t290, label %b106.e291
b106.t290:
  br label %b109
b106.e291:
  br label %b110
b107:
  %v581 = add i64 0, 7
  call void @"rt.panic"(i64 %v581)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b108:
  %v582.p = getelementptr i64, ptr %v324, i64 0
  %v582 = load i64, ptr %v582.p
  %v583 = inttoptr i64 %v582 to ptr
  %v584 = add i64 0, 1
  %v585 = mul i64 %v578, %v584
  %v586 = getelementptr i64, ptr %v583, i64 %v585
  %v587.p = getelementptr i64, ptr %v586, i64 0
  %v587 = load i64, ptr %v587.p
  %v588 = add i64 %v575, %v587
  %v589.p = getelementptr i64, ptr %v568, i64 0
  %v589 = load i64, ptr %v589.p
  %v590 = add i64 %v589, %v588
  %st291 = getelementptr i64, ptr %v568, i64 0
  store i64 %v590, ptr %st291
  %v591 = add i64 0, 1
  %v592.p = getelementptr i64, ptr %v570, i64 0
  %v592 = load i64, ptr %v592.p
  %v593 = add i64 %v592, %v591
  %st292 = getelementptr i64, ptr %v570, i64 0
  store i64 %v593, ptr %st292
  br label %b104
b109:
  %v598 = add i64 0, 8
  call void @"rt.panic"(i64 %v598)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b110:
  %v599.p = getelementptr i64, ptr %v324, i64 0
  %v599 = load i64, ptr %v599.p
  %v600 = inttoptr i64 %v599 to ptr
  %v601 = add i64 0, 1
  %v602 = mul i64 %v595, %v601
  %v603 = getelementptr i64, ptr %v600, i64 %v602
  %v604.p = getelementptr i64, ptr %v603, i64 0
  %v604 = load i64, ptr %v604.p
  %v605 = add i64 0, 4
  %v606.p = getelementptr i64, ptr %v568, i64 0
  %v606 = load i64, ptr %v606.p
  %v607 = add i64 0, 0
  %v608.p = getelementptr i64, ptr %v324, i64 0
  %v608 = load i64, ptr %v608.p
  %v609 = call i64 @"rt.lease_op"(i64 %v605, i64 %v608, i64 %v606, i64 %v607)
  %v610 = add i64 0, 1
  %v611 = add i64 0, 32
  %v613 = add i64 0, 0
  %v614.c = icmp slt i64 %v611, %v613
  %v614 = zext i1 %v614.c to i64
  %c.b110 = icmp ne i64 %v614, 0
  br i1 %c.b110, label %b110.t294, label %b110.e295
b110.t294:
  br label %b111
b110.e295:
  br label %b112
b111:
  %v615 = add i64 0, 9
  call void @"rt.panic"(i64 %v615)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b112:
  %v616 = add i64 0, 63
  %v617.c = icmp sgt i64 %v611, %v616
  %v617 = zext i1 %v617.c to i64
  %c.b112 = icmp ne i64 %v617, 0
  br i1 %c.b112, label %b112.t296, label %b112.e297
b112.t296:
  br label %b114
b112.e297:
  br label %b115
b113:
  %v612 = phi i64 [ %v618, %b114 ], [ %v619, %b115 ]
  %v620 = add i64 %v609, %v612
  %v621 = add i64 0, 5
  %v622.p = getelementptr i64, ptr %v568, i64 0
  %v622 = load i64, ptr %v622.p
  %v623.p = getelementptr i64, ptr %v324, i64 0
  %v623 = load i64, ptr %v623.p
  %v624 = call i64 @"rt.lease_op"(i64 %v621, i64 %v623, i64 %v622, i64 %v620)
  %v625.p = getelementptr i64, ptr %v568, i64 0
  %v625 = load i64, ptr %v625.p
  %v626 = add i64 0, 1
  %v627 = add i64 %v625, %v626
  %v628 = getelementptr i64, ptr %s16, i64 0
  %v629.p = getelementptr i64, ptr %v324, i64 0
  %v629 = load i64, ptr %v629.p
  %v630 = add i64 0, 3
  %v631.n = and i64 %v630, 63
  %v631 = shl i64 %v627, %v631.n
  %v632 = add i64 %v629, %v631
  %st297 = getelementptr i64, ptr %v628, i64 0
  store i64 %v632, ptr %st297
  %st298 = getelementptr i64, ptr %v628, i64 1
  store i64 %v604, ptr %st298
  %v633.p = getelementptr i64, ptr %v324, i64 2
  %v633 = load i64, ptr %v633.p
  %st299 = getelementptr i64, ptr %v628, i64 2
  store i64 %v633, ptr %st299
  %v634.p = getelementptr i64, ptr %v628, i64 0
  %v634 = load i64, ptr %v634.p
  %st300 = getelementptr i64, ptr %v310, i64 0
  store i64 %v634, ptr %st300
  %v635.p = getelementptr i64, ptr %v628, i64 1
  %v635 = load i64, ptr %v635.p
  %st301 = getelementptr i64, ptr %v310, i64 1
  store i64 %v635, ptr %st301
  %v636.p = getelementptr i64, ptr %v628, i64 2
  %v636 = load i64, ptr %v636.p
  %st302 = getelementptr i64, ptr %v310, i64 2
  store i64 %v636, ptr %st302
  %v637 = add i64 0, 3
  %v638 = getelementptr i64, ptr %v310, i64 %v637
  %st303 = getelementptr i64, ptr %v638, i64 0
  store i64 %v620, ptr %st303
  %v639 = add i64 0, 4
  %v640 = getelementptr i64, ptr %v310, i64 %v639
  %v641.p = getelementptr i64, ptr %v324, i64 0
  %v641 = load i64, ptr %v641.p
  %st304 = getelementptr i64, ptr %v640, i64 0
  store i64 %v641, ptr %st304
  %v642.p = getelementptr i64, ptr %v324, i64 1
  %v642 = load i64, ptr %v642.p
  %st305 = getelementptr i64, ptr %v640, i64 1
  store i64 %v642, ptr %st305
  %v643.p = getelementptr i64, ptr %v324, i64 2
  %v643 = load i64, ptr %v643.p
  %st306 = getelementptr i64, ptr %v640, i64 2
  store i64 %v643, ptr %st306
  %v644.p = getelementptr i64, ptr %v568, i64 0
  %v644 = load i64, ptr %v644.p
  %v645 = add i64 0, 1
  %v646 = add i64 %v644, %v645
  %v647 = add i64 0, 7
  %v648 = getelementptr i64, ptr %v310, i64 %v647
  %st307 = getelementptr i64, ptr %v648, i64 0
  store i64 %v646, ptr %st307
  %v649 = add i64 0, 0
  %v650.c = icmp eq i64 %v620, %v649
  %v650 = zext i1 %v650.c to i64
  %c.b113 = icmp ne i64 %v650, 0
  br i1 %c.b113, label %b113.t309, label %b113.e310
b113.t309:
  br label %b116
b113.e310:
  br label %b117
b114:
  %v618 = add i64 0, 0
  br label %b113
b115:
  %v619.n = and i64 %v611, 63
  %v619 = shl i64 %v610, %v619.n
  br label %b113
b116:
  %v651 = add i64 0, 0
  %v652 = getelementptr i64, ptr %s10, i64 0
  %st310 = getelementptr i64, ptr %v652, i64 0
  store i64 %v651, ptr %st310
  %v1101 = getelementptr i64, ptr @"rt.meta", i64 0
  %v653.p = getelementptr i64, ptr %v1101, i64 0
  %v653 = load i64, ptr %v653.p
  br label %b118
b117:
  br label %b123
b118:
  %v1102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st311 = getelementptr i64, ptr %v1102, i64 0
  store i64 %v653, ptr %st311
  %v654.p = getelementptr i64, ptr %v652, i64 0
  %v654 = load i64, ptr %v654.p
  %v655.c = icmp slt i64 %v654, %v604
  %v655 = zext i1 %v655.c to i64
  %c.b118 = icmp ne i64 %v655, 0
  br i1 %c.b118, label %b118.t313, label %b118.e314
b118.t313:
  br label %b119
b118.e314:
  br label %b120
b119:
  call void @"rt.region_enter"()
  %v1103 = getelementptr i64, ptr @"rt.meta", i64 0
  %v656.p = getelementptr i64, ptr %v1103, i64 0
  %v656 = load i64, ptr %v656.p
  %v657.p = getelementptr i64, ptr %v652, i64 0
  %v657 = load i64, ptr %v657.p
  %v658 = add i64 0, 0
  %v659.p = getelementptr i64, ptr %v310, i64 1
  %v659 = load i64, ptr %v659.p
  %v660.c = icmp uge i64 %v657, %v659
  %v660 = zext i1 %v660.c to i64
  %c.b119 = icmp ne i64 %v660, 0
  br i1 %c.b119, label %b119.t315, label %b119.e316
b119.t315:
  br label %b121
b119.e316:
  br label %b122
b120:
  %v1104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st316 = getelementptr i64, ptr %v1104, i64 0
  store i64 %v653, ptr %st316
  br label %b123
b121:
  %v661 = add i64 0, 10
  call void @"rt.panic"(i64 %v661)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b122:
  %v662.p = getelementptr i64, ptr %v310, i64 0
  %v662 = load i64, ptr %v662.p
  %v663 = inttoptr i64 %v662 to ptr
  %v664 = add i64 0, 1
  %v665 = mul i64 %v657, %v664
  %v666 = getelementptr i64, ptr %v663, i64 %v665
  %st317 = getelementptr i64, ptr %v666, i64 0
  store i64 %v658, ptr %st317
  %v667 = add i64 0, 1
  %v668.p = getelementptr i64, ptr %v652, i64 0
  %v668 = load i64, ptr %v668.p
  %v669 = add i64 %v668, %v667
  %st318 = getelementptr i64, ptr %v652, i64 0
  store i64 %v669, ptr %st318
  br label %b118
b123:
  br label %b54
b124:
  %v969.p = getelementptr i64, ptr %v670, i64 0
  %v969 = load i64, ptr %v969.p
  %v970.p = getelementptr i64, ptr %v289, i64 0
  %v970 = load i64, ptr %v970.p
  %v971.p = getelementptr i64, ptr %v289, i64 1
  %v971 = load i64, ptr %v971.p
  %v972.p = getelementptr i64, ptr %v289, i64 2
  %v972 = load i64, ptr %v972.p
  call void @"std/task.LeaseGive"(i64 %v970, i64 %v971, i64 %v972, i64 %v297)
  %v1105 = getelementptr i64, ptr @"rt.meta", i64 0
  %st319 = getelementptr i64, ptr %v1105, i64 0
  store i64 %v287, ptr %st319
  call void @"rt.print_int"(i64 %v969)
  %v973 = add i64 0, 10
  call void @"rt.print_char"(i64 %v973)
  br label %b53
b125:
  %v968.p = getelementptr i64, ptr %v672, i64 0
  %v968 = load i64, ptr %v968.p
  %st320 = getelementptr i64, ptr %v670, i64 0
  store i64 %v968, ptr %st320
  %v1106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st321 = getelementptr i64, ptr %v1106, i64 0
  store i64 %v671, ptr %st321
  br label %b124
b126:
  %v677.p = getelementptr i64, ptr %v674, i64 0
  %v677 = load i64, ptr %v677.p
  %v678 = add i64 0, 0
  %v679.c = icmp eq i64 %v677, %v678
  %v679 = zext i1 %v679.c to i64
  %c.b126 = icmp ne i64 %v679, 0
  br i1 %c.b126, label %b126.t323, label %b126.e324
b126.t323:
  br label %b127
b126.e324:
  br label %b128
b127:
  %v680 = add i64 0, 64
  %v681 = getelementptr i64, ptr %s10, i64 0
  %v1107 = getelementptr i64, ptr @"rt.meta", i64 0
  %v682.p = getelementptr i64, ptr %v1107, i64 0
  %v682 = load i64, ptr %v682.p
  %v683.p = getelementptr i64, ptr %v310, i64 1
  %v683 = load i64, ptr %v683.p
  %v684 = add i64 0, 0
  %v685.c = icmp sgt i64 %v683, %v684
  %v685 = zext i1 %v685.c to i64
  %c.b127 = icmp ne i64 %v685, 0
  br i1 %c.b127, label %b127.t325, label %b127.e326
b127.t325:
  br label %b130
b127.e326:
  br label %b131
b128:
  br label %b173
b129:
  br label %b173
b130:
  %v686 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v687 = add i64 0, 2
  %st326 = getelementptr i64, ptr %v686, i64 1026
  store i64 %v687, ptr %st326
  %v688 = getelementptr i64, ptr @"str.0", i64 0
  %v689 = add i64 0, 7
  %v690 = add i64 0, 0
  %v691 = getelementptr i64, ptr %s5, i64 0
  %v692 = ptrtoint ptr %v688 to i64
  %st327 = getelementptr i64, ptr %v691, i64 0
  store i64 %v692, ptr %st327
  %st328 = getelementptr i64, ptr %v691, i64 1
  store i64 %v689, ptr %st328
  %st329 = getelementptr i64, ptr %v691, i64 2
  store i64 %v690, ptr %st329
  call void @"rt.print_str"(ptr %v691)
  %v693 = getelementptr i64, ptr @"str.1", i64 0
  %v694 = add i64 0, 17
  %v695 = add i64 0, 0
  %v696 = getelementptr i64, ptr %s16, i64 0
  %v697 = ptrtoint ptr %v693 to i64
  %st330 = getelementptr i64, ptr %v696, i64 0
  store i64 %v697, ptr %st330
  %st331 = getelementptr i64, ptr %v696, i64 1
  store i64 %v694, ptr %st331
  %st332 = getelementptr i64, ptr %v696, i64 2
  store i64 %v695, ptr %st332
  call void @"rt.print_str"(ptr %v696)
  %v698 = getelementptr i64, ptr @"str.2", i64 0
  %v699 = add i64 0, 1
  %v700 = add i64 0, 0
  %v701 = getelementptr i64, ptr %s17, i64 0
  %v702 = ptrtoint ptr %v698 to i64
  %st333 = getelementptr i64, ptr %v701, i64 0
  store i64 %v702, ptr %st333
  %st334 = getelementptr i64, ptr %v701, i64 1
  store i64 %v699, ptr %st334
  %st335 = getelementptr i64, ptr %v701, i64 2
  store i64 %v700, ptr %st335
  call void @"rt.print_str"(ptr %v701)
  %v703 = getelementptr i64, ptr @"str.3", i64 0
  %v704 = add i64 0, 1
  %v705 = add i64 0, 0
  %v706 = getelementptr i64, ptr %s18, i64 0
  %v707 = ptrtoint ptr %v703 to i64
  %st336 = getelementptr i64, ptr %v706, i64 0
  store i64 %v707, ptr %st336
  %st337 = getelementptr i64, ptr %v706, i64 1
  store i64 %v704, ptr %st337
  %st338 = getelementptr i64, ptr %v706, i64 2
  store i64 %v705, ptr %st338
  call void @"rt.print_str"(ptr %v706)
  %v708 = add i64 0, 11
  call void @"rt.panic"(i64 %v708)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b131:
  br label %b132
b132:
  %v709 = add i64 0, 0
  %v710 = add i64 0, 3
  %v711 = getelementptr i64, ptr %v310, i64 %v710
  %st339 = getelementptr i64, ptr %v711, i64 0
  store i64 %v709, ptr %st339
  %v712 = getelementptr i64, ptr %s12, i64 0
  %v1108 = getelementptr i64, ptr @"rt.meta", i64 0
  %v713.p = getelementptr i64, ptr %v1108, i64 0
  %v713 = load i64, ptr %v713.p
  %v714 = add i64 0, 256
  %v715.c = icmp slt i64 %v680, %v714
  %v715 = zext i1 %v715.c to i64
  %c.b132 = icmp ne i64 %v715, 0
  br i1 %c.b132, label %b132.t341, label %b132.e342
b132.t341:
  br label %b134
b132.e342:
  br label %b135
b133:
  br label %b129
b134:
  br label %b136
b135:
  %v716 = add i64 0, 256
  br label %b136
b136:
  %v717 = phi i64 [ %v680, %b134 ], [ %v716, %b135 ]
  %v1109 = getelementptr i64, ptr @"rt.meta", i64 0
  %v718.p = getelementptr i64, ptr %v1109, i64 0
  %v718 = load i64, ptr %v718.p
  %v719 = add i64 0, 0
  %v720 = call ptr @"rt.region_alloc"(i64 %v718, i64 %v719)
  %v721 = add i64 0, 0
  %v722 = getelementptr i64, ptr %s18, i64 0
  %v723 = ptrtoint ptr %v720 to i64
  %st342 = getelementptr i64, ptr %v722, i64 0
  store i64 %v723, ptr %st342
  %st343 = getelementptr i64, ptr %v722, i64 1
  store i64 %v721, ptr %st343
  %st344 = getelementptr i64, ptr %v722, i64 2
  store i64 %v718, ptr %st344
  %v724 = getelementptr i64, ptr %s17, i64 0
  %v725.p = getelementptr i64, ptr %v722, i64 0
  %v725 = load i64, ptr %v725.p
  %st345 = getelementptr i64, ptr %v724, i64 0
  store i64 %v725, ptr %st345
  %v726.p = getelementptr i64, ptr %v722, i64 1
  %v726 = load i64, ptr %v726.p
  %st346 = getelementptr i64, ptr %v724, i64 1
  store i64 %v726, ptr %st346
  %v727.p = getelementptr i64, ptr %v722, i64 2
  %v727 = load i64, ptr %v727.p
  %st347 = getelementptr i64, ptr %v724, i64 2
  store i64 %v727, ptr %st347
  %v1110 = getelementptr i64, ptr @"rt.meta", i64 0
  %v728.p = getelementptr i64, ptr %v1110, i64 0
  %v728 = load i64, ptr %v728.p
  %v729 = add i64 0, 0
  %v730 = getelementptr i64, ptr %s20, i64 0
  %v1111 = getelementptr i64, ptr @"rt.meta", i64 0
  %v731.p = getelementptr i64, ptr %v1111, i64 0
  %v731 = load i64, ptr %v731.p
  %v732 = getelementptr i64, ptr %s21, i64 0
  %st348 = getelementptr i64, ptr %v732, i64 0
  store i64 %v729, ptr %st348
  %v1112 = getelementptr i64, ptr @"rt.meta", i64 0
  %v733.p = getelementptr i64, ptr %v1112, i64 0
  %v733 = load i64, ptr %v733.p
  br label %b139
b137:
  %v1113 = getelementptr i64, ptr @"rt.meta", i64 0
  %st349 = getelementptr i64, ptr %v1113, i64 0
  store i64 %v728, ptr %st349
  %v775 = getelementptr i64, ptr %s16, i64 0
  %v776.p = getelementptr i64, ptr %v724, i64 0
  %v776 = load i64, ptr %v776.p
  %st350 = getelementptr i64, ptr %v775, i64 0
  store i64 %v776, ptr %st350
  %v777.p = getelementptr i64, ptr %v724, i64 1
  %v777 = load i64, ptr %v777.p
  %st351 = getelementptr i64, ptr %v775, i64 1
  store i64 %v777, ptr %st351
  %v778.p = getelementptr i64, ptr %v724, i64 2
  %v778 = load i64, ptr %v778.p
  %st352 = getelementptr i64, ptr %v775, i64 2
  store i64 %v778, ptr %st352
  %v779 = add i64 0, 0
  %v780 = getelementptr i64, ptr %s21, i64 0
  %st353 = getelementptr i64, ptr %v780, i64 0
  store i64 %v779, ptr %st353
  %v1114 = getelementptr i64, ptr @"rt.meta", i64 0
  %v781.p = getelementptr i64, ptr %v1114, i64 0
  %v781 = load i64, ptr %v781.p
  br label %b146
b138:
  br label %b137
b139:
  %v1115 = getelementptr i64, ptr @"rt.meta", i64 0
  %st354 = getelementptr i64, ptr %v1115, i64 0
  store i64 %v733, ptr %st354
  %v734.p = getelementptr i64, ptr %v732, i64 0
  %v734 = load i64, ptr %v734.p
  %v735.c = icmp slt i64 %v734, %v717
  %v735 = zext i1 %v735.c to i64
  %c.b139 = icmp ne i64 %v735, 0
  br i1 %c.b139, label %b139.t356, label %b139.e357
b139.t356:
  br label %b140
b139.e357:
  br label %b141
b140:
  call void @"rt.region_enter"()
  %v1116 = getelementptr i64, ptr @"rt.meta", i64 0
  %v736.p = getelementptr i64, ptr %v1116, i64 0
  %v736 = load i64, ptr %v736.p
  %v737.p = getelementptr i64, ptr %v732, i64 0
  %v737 = load i64, ptr %v737.p
  %v1117 = getelementptr i64, ptr @"rt.meta", i64 0
  %v738.p = getelementptr i64, ptr %v1117, i64 0
  %v738 = load i64, ptr %v738.p
  %v739 = getelementptr i64, ptr %s18, i64 0
  %v740.p = getelementptr i64, ptr %v724, i64 0
  %v740 = load i64, ptr %v740.p
  %st357 = getelementptr i64, ptr %v739, i64 0
  store i64 %v740, ptr %st357
  %v741.p = getelementptr i64, ptr %v724, i64 1
  %v741 = load i64, ptr %v741.p
  %st358 = getelementptr i64, ptr %v739, i64 1
  store i64 %v741, ptr %st358
  %v742.p = getelementptr i64, ptr %v724, i64 2
  %v742 = load i64, ptr %v742.p
  %st359 = getelementptr i64, ptr %v739, i64 2
  store i64 %v742, ptr %st359
  %v743 = add i64 0, 0
  %v744.p = getelementptr i64, ptr %v739, i64 2
  %v744 = load i64, ptr %v744.p
  %v745.p = getelementptr i64, ptr %v739, i64 0
  %v745 = load i64, ptr %v745.p
  %v746.p = getelementptr i64, ptr %v739, i64 1
  %v746 = load i64, ptr %v746.p
  %v749 = add i64 0, 8
  %v750 = mul i64 %v746, %v749
  %v751 = add i64 %v745, %v750
  %v1118 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1119 = getelementptr i64, ptr %v1118, i64 %v744
  %v752.p = getelementptr i64, ptr %v1119, i64 1
  %v752 = load ptr, ptr %v752.p
  %v753 = ptrtoint ptr %v752 to i64
  %v754.c = icmp eq i64 %v753, %v751
  %v754 = zext i1 %v754.c to i64
  %c.b140 = icmp ne i64 %v754, 0
  br i1 %c.b140, label %b140.t361, label %b140.e362
b140.t361:
  br label %b145
b140.e362:
  br label %b144
b141:
  %v1120 = getelementptr i64, ptr @"rt.meta", i64 0
  %st362 = getelementptr i64, ptr %v1120, i64 0
  store i64 %v733, ptr %st362
  br label %b138
b142:
  %v1121 = getelementptr i64, ptr @"rt.meta", i64 0
  %st363 = getelementptr i64, ptr %v1121, i64 0
  store i64 %v738, ptr %st363
  %v772 = add i64 0, 1
  %v773.p = getelementptr i64, ptr %v732, i64 0
  %v773 = load i64, ptr %v773.p
  %v774 = add i64 %v773, %v772
  %st364 = getelementptr i64, ptr %v732, i64 0
  store i64 %v774, ptr %st364
  br label %b139
b143:
  %v747 = phi ptr [ %v762, %b144 ], [ %v757, %b145 ]
  %v748 = phi ptr [ %v763, %b144 ], [ %v756, %b145 ]
  %st365 = getelementptr i64, ptr %v748, i64 0
  store i64 %v743, ptr %st365
  %v764.p = getelementptr i64, ptr %v739, i64 1
  %v764 = load i64, ptr %v764.p
  %v765 = add i64 0, 1
  %v766 = add i64 %v764, %v765
  %v767 = getelementptr i64, ptr %s16, i64 0
  %v768 = ptrtoint ptr %v747 to i64
  %st366 = getelementptr i64, ptr %v767, i64 0
  store i64 %v768, ptr %st366
  %st367 = getelementptr i64, ptr %v767, i64 1
  store i64 %v766, ptr %st367
  %st368 = getelementptr i64, ptr %v767, i64 2
  store i64 %v744, ptr %st368
  %v769.p = getelementptr i64, ptr %v767, i64 0
  %v769 = load i64, ptr %v769.p
  %st369 = getelementptr i64, ptr %v724, i64 0
  store i64 %v769, ptr %st369
  %v770.p = getelementptr i64, ptr %v767, i64 1
  %v770 = load i64, ptr %v770.p
  %st370 = getelementptr i64, ptr %v724, i64 1
  store i64 %v770, ptr %st370
  %v771.p = getelementptr i64, ptr %v767, i64 2
  %v771 = load i64, ptr %v771.p
  %st371 = getelementptr i64, ptr %v724, i64 2
  store i64 %v771, ptr %st371
  br label %b142
b144:
  %v758 = add i64 0, 1
  %v759 = mul i64 %v746, %v758
  %v760 = add i64 0, 1
  %v761 = add i64 0, 1
  %v762 = call ptr @"rt.slice_grow"(i64 %v745, i64 %v746, i64 %v760, i64 %v744, i64 %v761)
  %v763 = getelementptr i64, ptr %v762, i64 %v759
  br label %b143
b145:
  %v755 = add i64 0, 1
  %v756 = call ptr @"rt.region_alloc"(i64 %v744, i64 %v755)
  %v757 = inttoptr i64 %v745 to ptr
  br label %b143
b146:
  %v1122 = getelementptr i64, ptr @"rt.meta", i64 0
  %st372 = getelementptr i64, ptr %v1122, i64 0
  store i64 %v781, ptr %st372
  %v782.p = getelementptr i64, ptr %v780, i64 0
  %v782 = load i64, ptr %v782.p
  %v783 = add i64 %v782, %v717
  %v784.c = icmp sle i64 %v783, %v680
  %v784 = zext i1 %v784.c to i64
  %c.b146 = icmp ne i64 %v784, 0
  br i1 %c.b146, label %b146.t374, label %b146.e375
b146.t374:
  br label %b149
b146.e375:
  br label %b150
b147:
  call void @"rt.region_enter"()
  %v1123 = getelementptr i64, ptr @"rt.meta", i64 0
  %v788.p = getelementptr i64, ptr %v1123, i64 0
  %v788 = load i64, ptr %v788.p
  %v1124 = getelementptr i64, ptr @"rt.meta", i64 0
  %v789.p = getelementptr i64, ptr %v1124, i64 0
  %v789 = load i64, ptr %v789.p
  %v790 = add i64 0, 0
  %v791 = getelementptr i64, ptr %s20, i64 0
  %v1125 = getelementptr i64, ptr @"rt.meta", i64 0
  %v792.p = getelementptr i64, ptr %v1125, i64 0
  %v792 = load i64, ptr %v792.p
  %v793 = getelementptr i64, ptr %s22, i64 0
  %st375 = getelementptr i64, ptr %v793, i64 0
  store i64 %v790, ptr %st375
  %v1126 = getelementptr i64, ptr @"rt.meta", i64 0
  %v794.p = getelementptr i64, ptr %v1126, i64 0
  %v794 = load i64, ptr %v794.p
  br label %b153
b148:
  %v1127 = getelementptr i64, ptr @"rt.meta", i64 0
  %st376 = getelementptr i64, ptr %v1127, i64 0
  store i64 %v781, ptr %st376
  %v1128 = getelementptr i64, ptr @"rt.meta", i64 0
  %v846.p = getelementptr i64, ptr %v1128, i64 0
  %v846 = load i64, ptr %v846.p
  %v847 = add i64 0, 0
  %v848.p = getelementptr i64, ptr %v780, i64 0
  %v848 = load i64, ptr %v848.p
  %v849 = sub i64 %v680, %v848
  %v850 = getelementptr i64, ptr %s22, i64 0
  %v1129 = getelementptr i64, ptr @"rt.meta", i64 0
  %v851.p = getelementptr i64, ptr %v1129, i64 0
  %v851 = load i64, ptr %v851.p
  %v852 = getelementptr i64, ptr %s20, i64 0
  %st377 = getelementptr i64, ptr %v852, i64 0
  store i64 %v847, ptr %st377
  %v1130 = getelementptr i64, ptr @"rt.meta", i64 0
  %v853.p = getelementptr i64, ptr %v1130, i64 0
  %v853 = load i64, ptr %v853.p
  br label %b164
b149:
  %v786 = add i64 0, 0
  %v787.c = icmp sgt i64 %v717, %v786
  %v787 = zext i1 %v787.c to i64
  br label %b150
b150:
  %v785 = phi i64 [ %v784, %b146.e375 ], [ %v787, %b149 ]
  %c.b150 = icmp ne i64 %v785, 0
  br i1 %c.b150, label %b150.t379, label %b150.e380
b150.t379:
  br label %b147
b150.e380:
  br label %b148
b151:
  %v1131 = getelementptr i64, ptr @"rt.meta", i64 0
  %st380 = getelementptr i64, ptr %v1131, i64 0
  store i64 %v789, ptr %st380
  %v844.p = getelementptr i64, ptr %v780, i64 0
  %v844 = load i64, ptr %v844.p
  %v845 = add i64 %v844, %v717
  %st381 = getelementptr i64, ptr %v780, i64 0
  store i64 %v845, ptr %st381
  br label %b146
b152:
  br label %b151
b153:
  %v1132 = getelementptr i64, ptr @"rt.meta", i64 0
  %st382 = getelementptr i64, ptr %v1132, i64 0
  store i64 %v794, ptr %st382
  %v795.p = getelementptr i64, ptr %v793, i64 0
  %v795 = load i64, ptr %v795.p
  %v796.c = icmp slt i64 %v795, %v717
  %v796 = zext i1 %v796.c to i64
  %c.b153 = icmp ne i64 %v796, 0
  br i1 %c.b153, label %b153.t384, label %b153.e385
b153.t384:
  br label %b154
b153.e385:
  br label %b155
b154:
  call void @"rt.region_enter"()
  %v1133 = getelementptr i64, ptr @"rt.meta", i64 0
  %v797.p = getelementptr i64, ptr %v1133, i64 0
  %v797 = load i64, ptr %v797.p
  %v798.p = getelementptr i64, ptr %v793, i64 0
  %v798 = load i64, ptr %v798.p
  %v1134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v799.p = getelementptr i64, ptr %v1134, i64 0
  %v799 = load i64, ptr %v799.p
  %v800 = getelementptr i64, ptr %s18, i64 0
  %v801.p = getelementptr i64, ptr %v310, i64 0
  %v801 = load i64, ptr %v801.p
  %st385 = getelementptr i64, ptr %v800, i64 0
  store i64 %v801, ptr %st385
  %v802.p = getelementptr i64, ptr %v310, i64 1
  %v802 = load i64, ptr %v802.p
  %st386 = getelementptr i64, ptr %v800, i64 1
  store i64 %v802, ptr %st386
  %v803.p = getelementptr i64, ptr %v310, i64 2
  %v803 = load i64, ptr %v803.p
  %st387 = getelementptr i64, ptr %v800, i64 2
  store i64 %v803, ptr %st387
  %v804.p = getelementptr i64, ptr %v775, i64 1
  %v804 = load i64, ptr %v804.p
  %v805.c = icmp uge i64 %v798, %v804
  %v805 = zext i1 %v805.c to i64
  %c.b154 = icmp ne i64 %v805, 0
  br i1 %c.b154, label %b154.t389, label %b154.e390
b154.t389:
  br label %b157
b154.e390:
  br label %b158
b155:
  %v1135 = getelementptr i64, ptr @"rt.meta", i64 0
  %st390 = getelementptr i64, ptr %v1135, i64 0
  store i64 %v794, ptr %st390
  br label %b152
b156:
  %v1136 = getelementptr i64, ptr @"rt.meta", i64 0
  %st391 = getelementptr i64, ptr %v1136, i64 0
  store i64 %v799, ptr %st391
  %v841 = add i64 0, 1
  %v842.p = getelementptr i64, ptr %v793, i64 0
  %v842 = load i64, ptr %v842.p
  %v843 = add i64 %v842, %v841
  %st392 = getelementptr i64, ptr %v793, i64 0
  store i64 %v843, ptr %st392
  br label %b153
b157:
  %v806 = add i64 0, 12
  call void @"rt.panic"(i64 %v806)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b158:
  %v807.p = getelementptr i64, ptr %v775, i64 0
  %v807 = load i64, ptr %v807.p
  %v808 = inttoptr i64 %v807 to ptr
  %v809 = add i64 0, 1
  %v810 = mul i64 %v798, %v809
  %v811 = getelementptr i64, ptr %v808, i64 %v810
  %v812.p = getelementptr i64, ptr %v811, i64 0
  %v812 = load i64, ptr %v812.p
  %v813.p = getelementptr i64, ptr %v800, i64 2
  %v813 = load i64, ptr %v813.p
  %v814.p = getelementptr i64, ptr %v800, i64 0
  %v814 = load i64, ptr %v814.p
  %v815.p = getelementptr i64, ptr %v800, i64 1
  %v815 = load i64, ptr %v815.p
  %v818 = add i64 0, 8
  %v819 = mul i64 %v815, %v818
  %v820 = add i64 %v814, %v819
  %v1137 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1138 = getelementptr i64, ptr %v1137, i64 %v813
  %v821.p = getelementptr i64, ptr %v1138, i64 1
  %v821 = load ptr, ptr %v821.p
  %v822 = ptrtoint ptr %v821 to i64
  %v823.c = icmp eq i64 %v822, %v820
  %v823 = zext i1 %v823.c to i64
  %c.b158 = icmp ne i64 %v823, 0
  br i1 %c.b158, label %b158.t394, label %b158.e395
b158.t394:
  br label %b161
b158.e395:
  br label %b160
b159:
  %v816 = phi ptr [ %v831, %b160 ], [ %v826, %b161 ]
  %v817 = phi ptr [ %v832, %b160 ], [ %v825, %b161 ]
  %st395 = getelementptr i64, ptr %v817, i64 0
  store i64 %v812, ptr %st395
  %v833.p = getelementptr i64, ptr %v800, i64 1
  %v833 = load i64, ptr %v833.p
  %v834 = add i64 0, 1
  %v835 = add i64 %v833, %v834
  %v836 = getelementptr i64, ptr %s5, i64 0
  %v837 = ptrtoint ptr %v816 to i64
  %st396 = getelementptr i64, ptr %v836, i64 0
  store i64 %v837, ptr %st396
  %st397 = getelementptr i64, ptr %v836, i64 1
  store i64 %v835, ptr %st397
  %st398 = getelementptr i64, ptr %v836, i64 2
  store i64 %v813, ptr %st398
  %v838.p = getelementptr i64, ptr %v836, i64 0
  %v838 = load i64, ptr %v838.p
  %st399 = getelementptr i64, ptr %v310, i64 0
  store i64 %v838, ptr %st399
  %v839.p = getelementptr i64, ptr %v836, i64 1
  %v839 = load i64, ptr %v839.p
  %st400 = getelementptr i64, ptr %v310, i64 1
  store i64 %v839, ptr %st400
  %v840.p = getelementptr i64, ptr %v836, i64 2
  %v840 = load i64, ptr %v840.p
  %st401 = getelementptr i64, ptr %v310, i64 2
  store i64 %v840, ptr %st401
  br label %b156
b160:
  %v827 = add i64 0, 1
  %v828 = mul i64 %v815, %v827
  %v829 = add i64 0, 1
  %v830 = add i64 0, 1
  %v831 = call ptr @"rt.slice_grow"(i64 %v814, i64 %v815, i64 %v829, i64 %v813, i64 %v830)
  %v832 = getelementptr i64, ptr %v831, i64 %v828
  br label %b159
b161:
  %v824 = add i64 0, 1
  %v825 = call ptr @"rt.region_alloc"(i64 %v813, i64 %v824)
  %v826 = inttoptr i64 %v814 to ptr
  br label %b159
b162:
  %v1139 = getelementptr i64, ptr @"rt.meta", i64 0
  %st402 = getelementptr i64, ptr %v1139, i64 0
  store i64 %v846, ptr %st402
  br label %b133
b163:
  br label %b162
b164:
  %v1140 = getelementptr i64, ptr @"rt.meta", i64 0
  %st403 = getelementptr i64, ptr %v1140, i64 0
  store i64 %v853, ptr %st403
  %v854.p = getelementptr i64, ptr %v852, i64 0
  %v854 = load i64, ptr %v854.p
  %v855.c = icmp slt i64 %v854, %v849
  %v855 = zext i1 %v855.c to i64
  %c.b164 = icmp ne i64 %v855, 0
  br i1 %c.b164, label %b164.t405, label %b164.e406
b164.t405:
  br label %b165
b164.e406:
  br label %b166
b165:
  call void @"rt.region_enter"()
  %v1141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v856.p = getelementptr i64, ptr %v1141, i64 0
  %v856 = load i64, ptr %v856.p
  %v857.p = getelementptr i64, ptr %v852, i64 0
  %v857 = load i64, ptr %v857.p
  %v1142 = getelementptr i64, ptr @"rt.meta", i64 0
  %v858.p = getelementptr i64, ptr %v1142, i64 0
  %v858 = load i64, ptr %v858.p
  %v859 = getelementptr i64, ptr %s5, i64 0
  %v860.p = getelementptr i64, ptr %v310, i64 0
  %v860 = load i64, ptr %v860.p
  %st406 = getelementptr i64, ptr %v859, i64 0
  store i64 %v860, ptr %st406
  %v861.p = getelementptr i64, ptr %v310, i64 1
  %v861 = load i64, ptr %v861.p
  %st407 = getelementptr i64, ptr %v859, i64 1
  store i64 %v861, ptr %st407
  %v862.p = getelementptr i64, ptr %v310, i64 2
  %v862 = load i64, ptr %v862.p
  %st408 = getelementptr i64, ptr %v859, i64 2
  store i64 %v862, ptr %st408
  %v863.p = getelementptr i64, ptr %v775, i64 1
  %v863 = load i64, ptr %v863.p
  %v864.c = icmp uge i64 %v857, %v863
  %v864 = zext i1 %v864.c to i64
  %c.b165 = icmp ne i64 %v864, 0
  br i1 %c.b165, label %b165.t410, label %b165.e411
b165.t410:
  br label %b168
b165.e411:
  br label %b169
b166:
  %v1143 = getelementptr i64, ptr @"rt.meta", i64 0
  %st411 = getelementptr i64, ptr %v1143, i64 0
  store i64 %v853, ptr %st411
  br label %b163
b167:
  %v1144 = getelementptr i64, ptr @"rt.meta", i64 0
  %st412 = getelementptr i64, ptr %v1144, i64 0
  store i64 %v858, ptr %st412
  %v900 = add i64 0, 1
  %v901.p = getelementptr i64, ptr %v852, i64 0
  %v901 = load i64, ptr %v901.p
  %v902 = add i64 %v901, %v900
  %st413 = getelementptr i64, ptr %v852, i64 0
  store i64 %v902, ptr %st413
  br label %b164
b168:
  %v865 = add i64 0, 13
  call void @"rt.panic"(i64 %v865)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b169:
  %v866.p = getelementptr i64, ptr %v775, i64 0
  %v866 = load i64, ptr %v866.p
  %v867 = inttoptr i64 %v866 to ptr
  %v868 = add i64 0, 1
  %v869 = mul i64 %v857, %v868
  %v870 = getelementptr i64, ptr %v867, i64 %v869
  %v871.p = getelementptr i64, ptr %v870, i64 0
  %v871 = load i64, ptr %v871.p
  %v872.p = getelementptr i64, ptr %v859, i64 2
  %v872 = load i64, ptr %v872.p
  %v873.p = getelementptr i64, ptr %v859, i64 0
  %v873 = load i64, ptr %v873.p
  %v874.p = getelementptr i64, ptr %v859, i64 1
  %v874 = load i64, ptr %v874.p
  %v877 = add i64 0, 8
  %v878 = mul i64 %v874, %v877
  %v879 = add i64 %v873, %v878
  %v1145 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1146 = getelementptr i64, ptr %v1145, i64 %v872
  %v880.p = getelementptr i64, ptr %v1146, i64 1
  %v880 = load ptr, ptr %v880.p
  %v881 = ptrtoint ptr %v880 to i64
  %v882.c = icmp eq i64 %v881, %v879
  %v882 = zext i1 %v882.c to i64
  %c.b169 = icmp ne i64 %v882, 0
  br i1 %c.b169, label %b169.t415, label %b169.e416
b169.t415:
  br label %b172
b169.e416:
  br label %b171
b170:
  %v875 = phi ptr [ %v890, %b171 ], [ %v885, %b172 ]
  %v876 = phi ptr [ %v891, %b171 ], [ %v884, %b172 ]
  %st416 = getelementptr i64, ptr %v876, i64 0
  store i64 %v871, ptr %st416
  %v892.p = getelementptr i64, ptr %v859, i64 1
  %v892 = load i64, ptr %v892.p
  %v893 = add i64 0, 1
  %v894 = add i64 %v892, %v893
  %v895 = getelementptr i64, ptr %s18, i64 0
  %v896 = ptrtoint ptr %v875 to i64
  %st417 = getelementptr i64, ptr %v895, i64 0
  store i64 %v896, ptr %st417
  %st418 = getelementptr i64, ptr %v895, i64 1
  store i64 %v894, ptr %st418
  %st419 = getelementptr i64, ptr %v895, i64 2
  store i64 %v872, ptr %st419
  %v897.p = getelementptr i64, ptr %v895, i64 0
  %v897 = load i64, ptr %v897.p
  %st420 = getelementptr i64, ptr %v310, i64 0
  store i64 %v897, ptr %st420
  %v898.p = getelementptr i64, ptr %v895, i64 1
  %v898 = load i64, ptr %v898.p
  %st421 = getelementptr i64, ptr %v310, i64 1
  store i64 %v898, ptr %st421
  %v899.p = getelementptr i64, ptr %v895, i64 2
  %v899 = load i64, ptr %v899.p
  %st422 = getelementptr i64, ptr %v310, i64 2
  store i64 %v899, ptr %st422
  br label %b167
b171:
  %v886 = add i64 0, 1
  %v887 = mul i64 %v874, %v886
  %v888 = add i64 0, 1
  %v889 = add i64 0, 1
  %v890 = call ptr @"rt.slice_grow"(i64 %v873, i64 %v874, i64 %v888, i64 %v872, i64 %v889)
  %v891 = getelementptr i64, ptr %v890, i64 %v887
  br label %b170
b172:
  %v883 = add i64 0, 1
  %v884 = call ptr @"rt.region_alloc"(i64 %v872, i64 %v883)
  %v885 = inttoptr i64 %v873 to ptr
  br label %b170
b173:
  %v903 = add i64 0, 63
  %v904 = and i64 %v285, %v903
  %v905 = getelementptr i64, ptr %s10, i64 0
  %v1147 = getelementptr i64, ptr @"rt.meta", i64 0
  %v906.p = getelementptr i64, ptr %v1147, i64 0
  %v906 = load i64, ptr %v906.p
  %v907 = add i64 0, 32
  %v909 = add i64 0, 0
  %v910.c = icmp slt i64 %v907, %v909
  %v910 = zext i1 %v910.c to i64
  %c.b173 = icmp ne i64 %v910, 0
  br i1 %c.b173, label %b173.t424, label %b173.e425
b173.t424:
  br label %b175
b173.e425:
  br label %b176
b174:
  %v929 = add i64 0, 1
  %v930 = add i64 0, 8
  %v931 = getelementptr i64, ptr %v310, i64 %v930
  %v932.p = getelementptr i64, ptr %v931, i64 0
  %v932 = load i64, ptr %v932.p
  %v933 = add i64 %v932, %v929
  %st425 = getelementptr i64, ptr %v931, i64 0
  store i64 %v933, ptr %st425
  %v934 = add i64 0, 63
  %v935 = and i64 %v285, %v934
  %v936 = getelementptr i64, ptr %s10, i64 0
  %v1148 = getelementptr i64, ptr @"rt.meta", i64 0
  %v937.p = getelementptr i64, ptr %v1148, i64 0
  %v937 = load i64, ptr %v937.p
  %v938.p = getelementptr i64, ptr %v310, i64 1
  %v938 = load i64, ptr %v938.p
  %v939.c = icmp uge i64 %v935, %v938
  %v939 = zext i1 %v939.c to i64
  %c.b174 = icmp ne i64 %v939, 0
  br i1 %c.b174, label %b174.t427, label %b174.e428
b174.t427:
  br label %b186
b174.e428:
  br label %b187
b175:
  %v911 = add i64 0, 14
  call void @"rt.panic"(i64 %v911)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b176:
  %v912 = add i64 0, 63
  %v913.c = icmp sgt i64 %v907, %v912
  %v913 = zext i1 %v913.c to i64
  %c.b176 = icmp ne i64 %v913, 0
  br i1 %c.b176, label %b176.t429, label %b176.e430
b176.t429:
  br label %b178
b176.e430:
  br label %b179
b177:
  %v908 = phi i64 [ %v915, %b178 ], [ %v916, %b179 ]
  %v917 = add i64 0, 0
  %v918.c = icmp ne i64 %v908, %v917
  %v918 = zext i1 %v918.c to i64
  %c.b177 = icmp ne i64 %v918, 0
  br i1 %c.b177, label %b177.t431, label %b177.e432
b177.t431:
  br label %b180
b177.e432:
  br label %b181
b178:
  %v914 = add i64 0, 63
  %v915.n = and i64 %v914, 63
  %v915 = ashr i64 %v285, %v915.n
  br label %b177
b179:
  %v916.n = and i64 %v907, 63
  %v916 = ashr i64 %v285, %v916.n
  br label %b177
b180:
  call void @"std/pool.badScratch"(i64 %v285)
  br label %b182
b181:
  br label %b182
b182:
  %v919.p = getelementptr i64, ptr %v310, i64 3
  %v919 = load i64, ptr %v919.p
  %v920 = or i64 %v919, %v285
  %v921.p = getelementptr i64, ptr %v310, i64 1
  %v921 = load i64, ptr %v921.p
  %v922.c = icmp uge i64 %v904, %v921
  %v922 = zext i1 %v922.c to i64
  %c.b182 = icmp ne i64 %v922, 0
  br i1 %c.b182, label %b182.t433, label %b182.e434
b182.t433:
  br label %b183
b182.e434:
  br label %b184
b183:
  %v923 = add i64 0, 15
  call void @"rt.panic"(i64 %v923)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b184:
  %v924.p = getelementptr i64, ptr %v310, i64 0
  %v924 = load i64, ptr %v924.p
  %v925 = inttoptr i64 %v924 to ptr
  %v926 = add i64 0, 1
  %v927 = mul i64 %v904, %v926
  %v928 = getelementptr i64, ptr %v925, i64 %v927
  %st434 = getelementptr i64, ptr %v928, i64 0
  store i64 %v920, ptr %st434
  br label %b174
b185:
  %v963.p = getelementptr i64, ptr %v936, i64 0
  %v963 = load i64, ptr %v963.p
  %v964 = add i64 0, 10
  %v965 = mul i64 %v963, %v964
  %v966.p = getelementptr i64, ptr %v310, i64 8
  %v966 = load i64, ptr %v966.p
  %v967 = add i64 %v965, %v966
  %st435 = getelementptr i64, ptr %v672, i64 0
  store i64 %v967, ptr %st435
  %v1149 = getelementptr i64, ptr @"rt.meta", i64 0
  %st436 = getelementptr i64, ptr %v1149, i64 0
  store i64 %v673, ptr %st436
  br label %b125
b186:
  %v940 = add i64 0, 16
  call void @"rt.panic"(i64 %v940)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b187:
  %v941.p = getelementptr i64, ptr %v310, i64 0
  %v941 = load i64, ptr %v941.p
  %v942 = inttoptr i64 %v941 to ptr
  %v943 = add i64 0, 1
  %v944 = mul i64 %v935, %v943
  %v945 = getelementptr i64, ptr %v942, i64 %v944
  %v946.p = getelementptr i64, ptr %v945, i64 0
  %v946 = load i64, ptr %v946.p
  %v947.p = getelementptr i64, ptr %v310, i64 3
  %v947 = load i64, ptr %v947.p
  %v948 = xor i64 %v946, %v947
  %v949 = add i64 0, 32
  %v951 = add i64 0, 0
  %v952.c = icmp slt i64 %v949, %v951
  %v952 = zext i1 %v952.c to i64
  %c.b187 = icmp ne i64 %v952, 0
  br i1 %c.b187, label %b187.t438, label %b187.e439
b187.t438:
  br label %b188
b187.e439:
  br label %b189
b188:
  %v953 = add i64 0, 17
  call void @"rt.panic"(i64 %v953)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b189:
  %v954 = add i64 0, 63
  %v955.c = icmp sgt i64 %v949, %v954
  %v955 = zext i1 %v955.c to i64
  %c.b189 = icmp ne i64 %v955, 0
  br i1 %c.b189, label %b189.t440, label %b189.e441
b189.t440:
  br label %b191
b189.e441:
  br label %b192
b190:
  %v950 = phi i64 [ %v957, %b191 ], [ %v958, %b192 ]
  %v959 = add i64 0, 0
  %v960.c = icmp eq i64 %v950, %v959
  %v960 = zext i1 %v960.c to i64
  %c.b190 = icmp ne i64 %v960, 0
  br i1 %c.b190, label %b190.t442, label %b190.e443
b190.t442:
  br label %b193
b190.e443:
  br label %b194
b191:
  %v956 = add i64 0, 63
  %v957.n = and i64 %v956, 63
  %v957 = ashr i64 %v948, %v957.n
  br label %b190
b192:
  %v958.n = and i64 %v949, 63
  %v958 = ashr i64 %v948, %v958.n
  br label %b190
b193:
  br label %b195
b194:
  %v961 = add i64 0, 0
  br label %b195
b195:
  %v962 = phi i64 [ %v948, %b193 ], [ %v961, %b194 ]
  %st443 = getelementptr i64, ptr %v936, i64 0
  store i64 %v962, ptr %st443
  %v1150 = getelementptr i64, ptr @"rt.meta", i64 0
  %st444 = getelementptr i64, ptr %v1150, i64 0
  store i64 %v937, ptr %st444
  br label %b185
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
  %v20 = add i64 0, 8
  %v21.c = icmp eq i64 %v6, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b0 = icmp ne i64 %v21, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b2
b0.e3:
  br label %b1
b1:
  %v22 = getelementptr i64, ptr @"str.0", i64 0
  %v23 = add i64 0, 7
  %v24 = add i64 0, 0
  %v25 = getelementptr i64, ptr %s0, i64 0
  %v26 = ptrtoint ptr %v22 to i64
  %st3 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st3
  %st4 = getelementptr i64, ptr %v25, i64 1
  store i64 %v23, ptr %st4
  %st5 = getelementptr i64, ptr %v25, i64 2
  store i64 %v24, ptr %st5
  call void @"rt.print_str"(ptr %v25)
  %v27 = add i64 0, 1
  %v28.c = icmp eq i64 %v6, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b1 = icmp ne i64 %v28, 0
  br i1 %c.b1, label %b1.t7, label %b1.e8
b1.t7:
  br label %b4
b1.e8:
  br label %b5
b2:
  %v76 = getelementptr i64, ptr @"str.26", i64 0
  %v77 = add i64 0, 4
  %v78 = add i64 0, 0
  %v79 = getelementptr i64, ptr %s8, i64 0
  %v80 = ptrtoint ptr %v76 to i64
  %st8 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st8
  %st9 = getelementptr i64, ptr %v79, i64 1
  store i64 %v77, ptr %st9
  %st10 = getelementptr i64, ptr %v79, i64 2
  store i64 %v78, ptr %st10
  call void @"rt.print_str"(ptr %v79)
  %v81 = add i64 0, 0
  %v82.c = icmp eq i64 %v10, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b2 = icmp ne i64 %v82, 0
  br i1 %c.b2, label %b2.t12, label %b2.e13
b2.t12:
  br label %b19
b2.e13:
  br label %b20
b3:
  br label %b2
b4:
  %v29 = getelementptr i64, ptr @"str.19", i64 0
  %v30 = add i64 0, 18
  %v31 = add i64 0, 0
  %v32 = getelementptr i64, ptr %s1, i64 0
  %v33 = ptrtoint ptr %v29 to i64
  %st13 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st13
  %st14 = getelementptr i64, ptr %v32, i64 1
  store i64 %v30, ptr %st14
  %st15 = getelementptr i64, ptr %v32, i64 2
  store i64 %v31, ptr %st15
  call void @"rt.print_str"(ptr %v32)
  br label %b3
b5:
  %v34 = add i64 0, 2
  %v35.c = icmp eq i64 %v6, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b5 = icmp ne i64 %v35, 0
  br i1 %c.b5, label %b5.t17, label %b5.e18
b5.t17:
  br label %b6
b5.e18:
  br label %b7
b6:
  %v36 = getelementptr i64, ptr @"str.20", i64 0
  %v37 = add i64 0, 25
  %v38 = add i64 0, 0
  %v39 = getelementptr i64, ptr %s2, i64 0
  %v40 = ptrtoint ptr %v36 to i64
  %st18 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st18
  %st19 = getelementptr i64, ptr %v39, i64 1
  store i64 %v37, ptr %st19
  %st20 = getelementptr i64, ptr %v39, i64 2
  store i64 %v38, ptr %st20
  call void @"rt.print_str"(ptr %v39)
  br label %b3
b7:
  %v41 = add i64 0, 3
  %v42.c = icmp eq i64 %v6, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b7 = icmp ne i64 %v42, 0
  br i1 %c.b7, label %b7.t22, label %b7.e23
b7.t22:
  br label %b8
b7.e23:
  br label %b9
b8:
  %v43 = getelementptr i64, ptr @"str.21", i64 0
  %v44 = add i64 0, 27
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s3, i64 0
  %v47 = ptrtoint ptr %v43 to i64
  %st23 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st23
  %st24 = getelementptr i64, ptr %v46, i64 1
  store i64 %v44, ptr %st24
  %st25 = getelementptr i64, ptr %v46, i64 2
  store i64 %v45, ptr %st25
  call void @"rt.print_str"(ptr %v46)
  br label %b3
b9:
  %v48 = add i64 0, 4
  %v49.c = icmp eq i64 %v6, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b9 = icmp ne i64 %v49, 0
  br i1 %c.b9, label %b9.t27, label %b9.e28
b9.t27:
  br label %b10
b9.e28:
  br label %b11
b10:
  %v50 = getelementptr i64, ptr @"str.22", i64 0
  %v51 = add i64 0, 21
  %v52 = add i64 0, 0
  %v53 = getelementptr i64, ptr %s4, i64 0
  %v54 = ptrtoint ptr %v50 to i64
  %st28 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st28
  %st29 = getelementptr i64, ptr %v53, i64 1
  store i64 %v51, ptr %st29
  %st30 = getelementptr i64, ptr %v53, i64 2
  store i64 %v52, ptr %st30
  call void @"rt.print_str"(ptr %v53)
  br label %b3
b11:
  %v55 = add i64 0, 5
  %v56.c = icmp eq i64 %v6, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b11 = icmp ne i64 %v56, 0
  br i1 %c.b11, label %b11.t32, label %b11.e33
b11.t32:
  br label %b12
b11.e33:
  br label %b13
b12:
  %v57 = getelementptr i64, ptr @"str.23", i64 0
  %v58 = add i64 0, 22
  %v59 = add i64 0, 0
  %v60 = getelementptr i64, ptr %s5, i64 0
  %v61 = ptrtoint ptr %v57 to i64
  %st33 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st33
  %st34 = getelementptr i64, ptr %v60, i64 1
  store i64 %v58, ptr %st34
  %st35 = getelementptr i64, ptr %v60, i64 2
  store i64 %v59, ptr %st35
  call void @"rt.print_str"(ptr %v60)
  br label %b3
b13:
  %v62 = add i64 0, 6
  %v63.c = icmp eq i64 %v6, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b13 = icmp ne i64 %v63, 0
  br i1 %c.b13, label %b13.t37, label %b13.e38
b13.t37:
  br label %b14
b13.e38:
  br label %b15
b14:
  %v64 = getelementptr i64, ptr @"str.24", i64 0
  %v65 = add i64 0, 16
  %v66 = add i64 0, 0
  %v67 = getelementptr i64, ptr %s6, i64 0
  %v68 = ptrtoint ptr %v64 to i64
  %st38 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st38
  %st39 = getelementptr i64, ptr %v67, i64 1
  store i64 %v65, ptr %st39
  %st40 = getelementptr i64, ptr %v67, i64 2
  store i64 %v66, ptr %st40
  call void @"rt.print_str"(ptr %v67)
  br label %b3
b15:
  %v69 = add i64 0, 7
  %v70.c = icmp eq i64 %v6, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b15 = icmp ne i64 %v70, 0
  br i1 %c.b15, label %b15.t42, label %b15.e43
b15.t42:
  br label %b16
b15.e43:
  br label %b17
b16:
  %v71 = getelementptr i64, ptr @"str.25", i64 0
  %v72 = add i64 0, 24
  %v73 = add i64 0, 0
  %v74 = getelementptr i64, ptr %s7, i64 0
  %v75 = ptrtoint ptr %v71 to i64
  %st43 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st43
  %st44 = getelementptr i64, ptr %v74, i64 1
  store i64 %v72, ptr %st44
  %st45 = getelementptr i64, ptr %v74, i64 2
  store i64 %v73, ptr %st45
  call void @"rt.print_str"(ptr %v74)
  br label %b3
b17:
  br label %b3
b18:
  %v95 = add i64 0, 58
  call void @"rt.print_char"(i64 %v95)
  call void @"rt.print_int"(i64 %v14)
  %v96 = add i64 0, 58
  call void @"rt.print_char"(i64 %v96)
  call void @"rt.print_int"(i64 %v18)
  %v97 = add i64 0, 10
  call void @"rt.print_char"(i64 %v97)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v83 = getelementptr i64, ptr @"str.27", i64 0
  %v84 = add i64 0, 19
  %v85 = add i64 0, 0
  %v86 = getelementptr i64, ptr %s9, i64 0
  %v87 = ptrtoint ptr %v83 to i64
  %st46 = getelementptr i64, ptr %v86, i64 0
  store i64 %v87, ptr %st46
  %st47 = getelementptr i64, ptr %v86, i64 1
  store i64 %v84, ptr %st47
  %st48 = getelementptr i64, ptr %v86, i64 2
  store i64 %v85, ptr %st48
  call void @"rt.print_str"(ptr %v86)
  br label %b18
b20:
  %v88 = add i64 0, 1
  %v89.c = icmp eq i64 %v10, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b20 = icmp ne i64 %v89, 0
  br i1 %c.b20, label %b20.t50, label %b20.e51
b20.t50:
  br label %b21
b20.e51:
  br label %b22
b21:
  %v90 = getelementptr i64, ptr @"str.28", i64 0
  %v91 = add i64 0, 19
  %v92 = add i64 0, 0
  %v93 = getelementptr i64, ptr %s10, i64 0
  %v94 = ptrtoint ptr %v90 to i64
  %st51 = getelementptr i64, ptr %v93, i64 0
  store i64 %v94, ptr %st51
  %st52 = getelementptr i64, ptr %v93, i64 1
  store i64 %v91, ptr %st52
  %st53 = getelementptr i64, ptr %v93, i64 2
  store i64 %v92, ptr %st53
  call void @"rt.print_str"(ptr %v93)
  br label %b18
b22:
  br label %b18
}

define internal void @"std/task.LocalNew"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s6 = alloca [1 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v2, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v3, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v4, ptr %st2
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v263, i64 0
  %v6 = load i64, ptr %v6.p
  call void @"rt.region_enter"()
  %v7.p = getelementptr i64, ptr %v5, i64 1
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 2
  %v9 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v9, i64 0
  store i64 %v8, ptr %st3
  %v10 = add i64 0, 0
  %v11 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st4
  %v264 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v264, i64 0
  %v12 = load i64, ptr %v12.p
  br label %b1
b1:
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v265, i64 0
  store i64 %v12, ptr %st5
  %v13.p = getelementptr i64, ptr %v11, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.c = icmp slt i64 %v13, %v7
  %v14 = zext i1 %v14.c to i64
  %c.b1 = icmp ne i64 %v14, 0
  br i1 %c.b1, label %b1.t7, label %b1.e8
b1.t7:
  br label %b2
b1.e8:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v266, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 1
  %v17.p = getelementptr i64, ptr %v11, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v5, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp uge i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b2 = icmp ne i64 %v19, 0
  br i1 %c.b2, label %b2.t9, label %b2.e10
b2.t9:
  br label %b4
b2.e10:
  br label %b5
b3:
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v267, i64 0
  store i64 %v12, ptr %st10
  %v33 = add i64 0, 0
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v268, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 0
  %v36 = call ptr @"rt.region_alloc"(i64 %v34, i64 %v35)
  %v37 = add i64 0, 0
  %v38 = getelementptr i64, ptr %s3, i64 0
  %v39 = ptrtoint ptr %v36 to i64
  %st11 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st11
  %st12 = getelementptr i64, ptr %v38, i64 1
  store i64 %v37, ptr %st12
  %st13 = getelementptr i64, ptr %v38, i64 2
  store i64 %v34, ptr %st13
  %v40 = add i64 0, 0
  %v41 = add i64 0, 0
  %v42.p = getelementptr i64, ptr %v38, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = call i64 @"rt.lease_op"(i64 %v33, i64 %v42, i64 %v40, i64 %v41)
  %v44 = add i64 0, 3
  %v45 = add i64 %v44, %v7
  %v46.p = getelementptr i64, ptr %v9, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = mul i64 %v43, %v46
  %v48 = add i64 %v45, %v47
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v269, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51 = call ptr @"rt.region_alloc"(i64 %v49, i64 %v50)
  %v52 = add i64 0, 0
  %v53 = getelementptr i64, ptr %s3, i64 0
  %v54 = ptrtoint ptr %v51 to i64
  %st14 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st14
  %st15 = getelementptr i64, ptr %v53, i64 1
  store i64 %v52, ptr %st15
  %st16 = getelementptr i64, ptr %v53, i64 2
  store i64 %v49, ptr %st16
  %v55 = getelementptr i64, ptr %s4, i64 0
  %v56.p = getelementptr i64, ptr %v53, i64 0
  %v56 = load i64, ptr %v56.p
  %st17 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st17
  %v57.p = getelementptr i64, ptr %v53, i64 1
  %v57 = load i64, ptr %v57.p
  %st18 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st18
  %v58.p = getelementptr i64, ptr %v53, i64 2
  %v58 = load i64, ptr %v58.p
  %st19 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st19
  %v59 = getelementptr i64, ptr %s3, i64 0
  %v60.p = getelementptr i64, ptr %v55, i64 0
  %v60 = load i64, ptr %v60.p
  %st20 = getelementptr i64, ptr %v59, i64 0
  store i64 %v60, ptr %st20
  %v61.p = getelementptr i64, ptr %v55, i64 1
  %v61 = load i64, ptr %v61.p
  %st21 = getelementptr i64, ptr %v59, i64 1
  store i64 %v61, ptr %st21
  %v62.p = getelementptr i64, ptr %v55, i64 2
  %v62 = load i64, ptr %v62.p
  %st22 = getelementptr i64, ptr %v59, i64 2
  store i64 %v62, ptr %st22
  %v63.p = getelementptr i64, ptr %v59, i64 2
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v59, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v59, i64 1
  %v65 = load i64, ptr %v65.p
  %v68 = add i64 0, 8
  %v69 = mul i64 %v65, %v68
  %v70 = add i64 %v64, %v69
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %v271 = getelementptr i64, ptr %v270, i64 %v63
  %v71.p = getelementptr i64, ptr %v271, i64 1
  %v71 = load ptr, ptr %v71.p
  %v72 = ptrtoint ptr %v71 to i64
  %v73.c = icmp eq i64 %v72, %v70
  %v73 = zext i1 %v73.c to i64
  %c.b3 = icmp ne i64 %v73, 0
  br i1 %c.b3, label %b3.t24, label %b3.e25
b3.t24:
  br label %b8
b3.e25:
  br label %b7
b4:
  %v20 = add i64 0, 24
  call void @"rt.panic"(i64 %v20)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v21.p = getelementptr i64, ptr %v5, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = inttoptr i64 %v21 to ptr
  %v23 = add i64 0, 1
  %v24 = mul i64 %v17, %v23
  %v25 = getelementptr i64, ptr %v22, i64 %v24
  %v26.p = getelementptr i64, ptr %v25, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 %v16, %v26
  %v28.p = getelementptr i64, ptr %v9, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 %v28, %v27
  %st25 = getelementptr i64, ptr %v9, i64 0
  store i64 %v29, ptr %st25
  %v30 = add i64 0, 1
  %v31.p = getelementptr i64, ptr %v11, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 %v31, %v30
  %st26 = getelementptr i64, ptr %v11, i64 0
  store i64 %v32, ptr %st26
  br label %b1
b6:
  %v66 = phi ptr [ %v81, %b7 ], [ %v76, %b8 ]
  %v67 = phi ptr [ %v82, %b7 ], [ %v75, %b8 ]
  %st27 = getelementptr i64, ptr %v67, i64 0
  store i64 %v1, ptr %st27
  %v83.p = getelementptr i64, ptr %v59, i64 1
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 1
  %v85 = add i64 %v83, %v84
  %v86 = getelementptr i64, ptr %s5, i64 0
  %v87 = ptrtoint ptr %v66 to i64
  %st28 = getelementptr i64, ptr %v86, i64 0
  store i64 %v87, ptr %st28
  %st29 = getelementptr i64, ptr %v86, i64 1
  store i64 %v85, ptr %st29
  %st30 = getelementptr i64, ptr %v86, i64 2
  store i64 %v63, ptr %st30
  %v88.p = getelementptr i64, ptr %v86, i64 0
  %v88 = load i64, ptr %v88.p
  %st31 = getelementptr i64, ptr %v55, i64 0
  store i64 %v88, ptr %st31
  %v89.p = getelementptr i64, ptr %v86, i64 1
  %v89 = load i64, ptr %v89.p
  %st32 = getelementptr i64, ptr %v55, i64 1
  store i64 %v89, ptr %st32
  %v90.p = getelementptr i64, ptr %v86, i64 2
  %v90 = load i64, ptr %v90.p
  %st33 = getelementptr i64, ptr %v55, i64 2
  store i64 %v90, ptr %st33
  %v91 = getelementptr i64, ptr %s5, i64 0
  %v92.p = getelementptr i64, ptr %v55, i64 0
  %v92 = load i64, ptr %v92.p
  %st34 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st34
  %v93.p = getelementptr i64, ptr %v55, i64 1
  %v93 = load i64, ptr %v93.p
  %st35 = getelementptr i64, ptr %v91, i64 1
  store i64 %v93, ptr %st35
  %v94.p = getelementptr i64, ptr %v55, i64 2
  %v94 = load i64, ptr %v94.p
  %st36 = getelementptr i64, ptr %v91, i64 2
  store i64 %v94, ptr %st36
  %v95.p = getelementptr i64, ptr %v91, i64 2
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v91, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v91, i64 1
  %v97 = load i64, ptr %v97.p
  %v100 = add i64 0, 8
  %v101 = mul i64 %v97, %v100
  %v102 = add i64 %v96, %v101
  %v272 = getelementptr i64, ptr @"rt.meta", i64 0
  %v273 = getelementptr i64, ptr %v272, i64 %v95
  %v103.p = getelementptr i64, ptr %v273, i64 1
  %v103 = load ptr, ptr %v103.p
  %v104 = ptrtoint ptr %v103 to i64
  %v105.c = icmp eq i64 %v104, %v102
  %v105 = zext i1 %v105.c to i64
  %c.b6 = icmp ne i64 %v105, 0
  br i1 %c.b6, label %b6.t38, label %b6.e39
b6.t38:
  br label %b11
b6.e39:
  br label %b10
b7:
  %v77 = add i64 0, 1
  %v78 = mul i64 %v65, %v77
  %v79 = add i64 0, 1
  %v80 = add i64 0, 1
  %v81 = call ptr @"rt.slice_grow"(i64 %v64, i64 %v65, i64 %v79, i64 %v63, i64 %v80)
  %v82 = getelementptr i64, ptr %v81, i64 %v78
  br label %b6
b8:
  %v74 = add i64 0, 1
  %v75 = call ptr @"rt.region_alloc"(i64 %v63, i64 %v74)
  %v76 = inttoptr i64 %v64 to ptr
  br label %b6
b9:
  %v98 = phi ptr [ %v113, %b10 ], [ %v108, %b11 ]
  %v99 = phi ptr [ %v114, %b10 ], [ %v107, %b11 ]
  %st39 = getelementptr i64, ptr %v99, i64 0
  store i64 %v7, ptr %st39
  %v115.p = getelementptr i64, ptr %v91, i64 1
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 1
  %v117 = add i64 %v115, %v116
  %v118 = getelementptr i64, ptr %s3, i64 0
  %v119 = ptrtoint ptr %v98 to i64
  %st40 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st40
  %st41 = getelementptr i64, ptr %v118, i64 1
  store i64 %v117, ptr %st41
  %st42 = getelementptr i64, ptr %v118, i64 2
  store i64 %v95, ptr %st42
  %v120.p = getelementptr i64, ptr %v118, i64 0
  %v120 = load i64, ptr %v120.p
  %st43 = getelementptr i64, ptr %v55, i64 0
  store i64 %v120, ptr %st43
  %v121.p = getelementptr i64, ptr %v118, i64 1
  %v121 = load i64, ptr %v121.p
  %st44 = getelementptr i64, ptr %v55, i64 1
  store i64 %v121, ptr %st44
  %v122.p = getelementptr i64, ptr %v118, i64 2
  %v122 = load i64, ptr %v122.p
  %st45 = getelementptr i64, ptr %v55, i64 2
  store i64 %v122, ptr %st45
  %v123 = add i64 0, 0
  %st46 = getelementptr i64, ptr %v11, i64 0
  store i64 %v123, ptr %st46
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %v124.p = getelementptr i64, ptr %v274, i64 0
  %v124 = load i64, ptr %v124.p
  br label %b12
b10:
  %v109 = add i64 0, 1
  %v110 = mul i64 %v97, %v109
  %v111 = add i64 0, 1
  %v112 = add i64 0, 1
  %v113 = call ptr @"rt.slice_grow"(i64 %v96, i64 %v97, i64 %v111, i64 %v95, i64 %v112)
  %v114 = getelementptr i64, ptr %v113, i64 %v110
  br label %b9
b11:
  %v106 = add i64 0, 1
  %v107 = call ptr @"rt.region_alloc"(i64 %v95, i64 %v106)
  %v108 = inttoptr i64 %v96 to ptr
  br label %b9
b12:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v275, i64 0
  store i64 %v124, ptr %st47
  %v125.p = getelementptr i64, ptr %v11, i64 0
  %v125 = load i64, ptr %v125.p
  %v126.c = icmp slt i64 %v125, %v7
  %v126 = zext i1 %v126.c to i64
  %c.b12 = icmp ne i64 %v126, 0
  br i1 %c.b12, label %b12.t49, label %b12.e50
b12.t49:
  br label %b13
b12.e50:
  br label %b14
b13:
  call void @"rt.region_enter"()
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %v127.p = getelementptr i64, ptr %v276, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 0, 1
  %v129 = add i64 %v6, %v128
  %v130 = getelementptr i64, ptr %s3, i64 0
  %v131.p = getelementptr i64, ptr %v55, i64 0
  %v131 = load i64, ptr %v131.p
  %st50 = getelementptr i64, ptr %v130, i64 0
  store i64 %v131, ptr %st50
  %v132.p = getelementptr i64, ptr %v55, i64 1
  %v132 = load i64, ptr %v132.p
  %st51 = getelementptr i64, ptr %v130, i64 1
  store i64 %v132, ptr %st51
  %v133.p = getelementptr i64, ptr %v55, i64 2
  %v133 = load i64, ptr %v133.p
  %st52 = getelementptr i64, ptr %v130, i64 2
  store i64 %v133, ptr %st52
  %v134.p = getelementptr i64, ptr %v11, i64 0
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v5, i64 1
  %v135 = load i64, ptr %v135.p
  %v136.c = icmp uge i64 %v134, %v135
  %v136 = zext i1 %v136.c to i64
  %c.b13 = icmp ne i64 %v136, 0
  br i1 %c.b13, label %b13.t54, label %b13.e55
b13.t54:
  br label %b15
b13.e55:
  br label %b16
b14:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v277, i64 0
  store i64 %v124, ptr %st55
  %v175 = getelementptr i64, ptr %s5, i64 0
  %v176.p = getelementptr i64, ptr %v55, i64 0
  %v176 = load i64, ptr %v176.p
  %st56 = getelementptr i64, ptr %v175, i64 0
  store i64 %v176, ptr %st56
  %v177.p = getelementptr i64, ptr %v55, i64 1
  %v177 = load i64, ptr %v177.p
  %st57 = getelementptr i64, ptr %v175, i64 1
  store i64 %v177, ptr %st57
  %v178.p = getelementptr i64, ptr %v55, i64 2
  %v178 = load i64, ptr %v178.p
  %st58 = getelementptr i64, ptr %v175, i64 2
  store i64 %v178, ptr %st58
  %v179.p = getelementptr i64, ptr %v175, i64 2
  %v179 = load i64, ptr %v179.p
  %v180.p = getelementptr i64, ptr %v175, i64 0
  %v180 = load i64, ptr %v180.p
  %v181.p = getelementptr i64, ptr %v175, i64 1
  %v181 = load i64, ptr %v181.p
  %v184 = add i64 0, 8
  %v185 = mul i64 %v181, %v184
  %v186 = add i64 %v180, %v185
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279 = getelementptr i64, ptr %v278, i64 %v179
  %v187.p = getelementptr i64, ptr %v279, i64 1
  %v187 = load ptr, ptr %v187.p
  %v188 = ptrtoint ptr %v187 to i64
  %v189.c = icmp eq i64 %v188, %v186
  %v189 = zext i1 %v189.c to i64
  %c.b14 = icmp ne i64 %v189, 0
  br i1 %c.b14, label %b14.t60, label %b14.e61
b14.t60:
  br label %b22
b14.e61:
  br label %b21
b15:
  %v137 = add i64 0, 25
  call void @"rt.panic"(i64 %v137)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v138.p = getelementptr i64, ptr %v5, i64 0
  %v138 = load i64, ptr %v138.p
  %v139 = inttoptr i64 %v138 to ptr
  %v140 = add i64 0, 1
  %v141 = mul i64 %v134, %v140
  %v142 = getelementptr i64, ptr %v139, i64 %v141
  %v143.p = getelementptr i64, ptr %v142, i64 0
  %v143 = load i64, ptr %v143.p
  %v144.p = getelementptr i64, ptr %v130, i64 2
  %v144 = load i64, ptr %v144.p
  %v145.p = getelementptr i64, ptr %v130, i64 0
  %v145 = load i64, ptr %v145.p
  %v146.p = getelementptr i64, ptr %v130, i64 1
  %v146 = load i64, ptr %v146.p
  %v149 = add i64 0, 8
  %v150 = mul i64 %v146, %v149
  %v151 = add i64 %v145, %v150
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %v281 = getelementptr i64, ptr %v280, i64 %v144
  %v152.p = getelementptr i64, ptr %v281, i64 1
  %v152 = load ptr, ptr %v152.p
  %v153 = ptrtoint ptr %v152 to i64
  %v154.c = icmp eq i64 %v153, %v151
  %v154 = zext i1 %v154.c to i64
  %c.b16 = icmp ne i64 %v154, 0
  br i1 %c.b16, label %b16.t62, label %b16.e63
b16.t62:
  br label %b19
b16.e63:
  br label %b18
b17:
  %v147 = phi ptr [ %v162, %b18 ], [ %v157, %b19 ]
  %v148 = phi ptr [ %v163, %b18 ], [ %v156, %b19 ]
  %st63 = getelementptr i64, ptr %v148, i64 0
  store i64 %v143, ptr %st63
  %v164.p = getelementptr i64, ptr %v130, i64 1
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 0, 1
  %v166 = add i64 %v164, %v165
  %v167 = getelementptr i64, ptr %s5, i64 0
  %v168 = ptrtoint ptr %v147 to i64
  %st64 = getelementptr i64, ptr %v167, i64 0
  store i64 %v168, ptr %st64
  %st65 = getelementptr i64, ptr %v167, i64 1
  store i64 %v166, ptr %st65
  %st66 = getelementptr i64, ptr %v167, i64 2
  store i64 %v144, ptr %st66
  %v169.p = getelementptr i64, ptr %v167, i64 0
  %v169 = load i64, ptr %v169.p
  %st67 = getelementptr i64, ptr %v55, i64 0
  store i64 %v169, ptr %st67
  %v170.p = getelementptr i64, ptr %v167, i64 1
  %v170 = load i64, ptr %v170.p
  %st68 = getelementptr i64, ptr %v55, i64 1
  store i64 %v170, ptr %st68
  %v171.p = getelementptr i64, ptr %v167, i64 2
  %v171 = load i64, ptr %v171.p
  %st69 = getelementptr i64, ptr %v55, i64 2
  store i64 %v171, ptr %st69
  %v172 = add i64 0, 1
  %v173.p = getelementptr i64, ptr %v11, i64 0
  %v173 = load i64, ptr %v173.p
  %v174 = add i64 %v173, %v172
  %st70 = getelementptr i64, ptr %v11, i64 0
  store i64 %v174, ptr %st70
  br label %b12
b18:
  %v158 = add i64 0, 1
  %v159 = mul i64 %v146, %v158
  %v160 = add i64 0, 1
  %v161 = add i64 0, 1
  %v162 = call ptr @"rt.slice_grow"(i64 %v145, i64 %v146, i64 %v160, i64 %v144, i64 %v161)
  %v163 = getelementptr i64, ptr %v162, i64 %v159
  br label %b17
b19:
  %v155 = add i64 0, 1
  %v156 = call ptr @"rt.region_alloc"(i64 %v144, i64 %v155)
  %v157 = inttoptr i64 %v145 to ptr
  br label %b17
b20:
  %v182 = phi ptr [ %v197, %b21 ], [ %v192, %b22 ]
  %v183 = phi ptr [ %v198, %b21 ], [ %v191, %b22 ]
  %st71 = getelementptr i64, ptr %v183, i64 0
  store i64 %v43, ptr %st71
  %v199.p = getelementptr i64, ptr %v175, i64 1
  %v199 = load i64, ptr %v199.p
  %v200 = add i64 0, 1
  %v201 = add i64 %v199, %v200
  %v202 = getelementptr i64, ptr %s3, i64 0
  %v203 = ptrtoint ptr %v182 to i64
  %st72 = getelementptr i64, ptr %v202, i64 0
  store i64 %v203, ptr %st72
  %st73 = getelementptr i64, ptr %v202, i64 1
  store i64 %v201, ptr %st73
  %st74 = getelementptr i64, ptr %v202, i64 2
  store i64 %v179, ptr %st74
  %v204.p = getelementptr i64, ptr %v202, i64 0
  %v204 = load i64, ptr %v204.p
  %st75 = getelementptr i64, ptr %v55, i64 0
  store i64 %v204, ptr %st75
  %v205.p = getelementptr i64, ptr %v202, i64 1
  %v205 = load i64, ptr %v205.p
  %st76 = getelementptr i64, ptr %v55, i64 1
  store i64 %v205, ptr %st76
  %v206.p = getelementptr i64, ptr %v202, i64 2
  %v206 = load i64, ptr %v206.p
  %st77 = getelementptr i64, ptr %v55, i64 2
  store i64 %v206, ptr %st77
  %v207.p = getelementptr i64, ptr %v55, i64 1
  %v207 = load i64, ptr %v207.p
  %v208 = getelementptr i64, ptr %s6, i64 0
  %st78 = getelementptr i64, ptr %v208, i64 0
  store i64 %v207, ptr %st78
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %v209.p = getelementptr i64, ptr %v282, i64 0
  %v209 = load i64, ptr %v209.p
  br label %b23
b21:
  %v193 = add i64 0, 1
  %v194 = mul i64 %v181, %v193
  %v195 = add i64 0, 1
  %v196 = add i64 0, 1
  %v197 = call ptr @"rt.slice_grow"(i64 %v180, i64 %v181, i64 %v195, i64 %v179, i64 %v196)
  %v198 = getelementptr i64, ptr %v197, i64 %v194
  br label %b20
b22:
  %v190 = add i64 0, 1
  %v191 = call ptr @"rt.region_alloc"(i64 %v179, i64 %v190)
  %v192 = inttoptr i64 %v180 to ptr
  br label %b20
b23:
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %st79 = getelementptr i64, ptr %v283, i64 0
  store i64 %v209, ptr %st79
  %v210.p = getelementptr i64, ptr %v208, i64 0
  %v210 = load i64, ptr %v210.p
  %v211.c = icmp slt i64 %v210, %v48
  %v211 = zext i1 %v211.c to i64
  %c.b23 = icmp ne i64 %v211, 0
  br i1 %c.b23, label %b23.t81, label %b23.e82
b23.t81:
  br label %b24
b23.e82:
  br label %b25
b24:
  call void @"rt.region_enter"()
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %v212.p = getelementptr i64, ptr %v284, i64 0
  %v212 = load i64, ptr %v212.p
  %v213 = add i64 0, 1
  %v214 = add i64 %v6, %v213
  %v215 = getelementptr i64, ptr %s3, i64 0
  %v216.p = getelementptr i64, ptr %v55, i64 0
  %v216 = load i64, ptr %v216.p
  %st82 = getelementptr i64, ptr %v215, i64 0
  store i64 %v216, ptr %st82
  %v217.p = getelementptr i64, ptr %v55, i64 1
  %v217 = load i64, ptr %v217.p
  %st83 = getelementptr i64, ptr %v215, i64 1
  store i64 %v217, ptr %st83
  %v218.p = getelementptr i64, ptr %v55, i64 2
  %v218 = load i64, ptr %v218.p
  %st84 = getelementptr i64, ptr %v215, i64 2
  store i64 %v218, ptr %st84
  %v219 = add i64 0, 0
  %v220.p = getelementptr i64, ptr %v215, i64 2
  %v220 = load i64, ptr %v220.p
  %v221.p = getelementptr i64, ptr %v215, i64 0
  %v221 = load i64, ptr %v221.p
  %v222.p = getelementptr i64, ptr %v215, i64 1
  %v222 = load i64, ptr %v222.p
  %v225 = add i64 0, 8
  %v226 = mul i64 %v222, %v225
  %v227 = add i64 %v221, %v226
  %v285 = getelementptr i64, ptr @"rt.meta", i64 0
  %v286 = getelementptr i64, ptr %v285, i64 %v220
  %v228.p = getelementptr i64, ptr %v286, i64 1
  %v228 = load ptr, ptr %v228.p
  %v229 = ptrtoint ptr %v228 to i64
  %v230.c = icmp eq i64 %v229, %v227
  %v230 = zext i1 %v230.c to i64
  %c.b24 = icmp ne i64 %v230, 0
  br i1 %c.b24, label %b24.t86, label %b24.e87
b24.t86:
  br label %b28
b24.e87:
  br label %b27
b25:
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %st87 = getelementptr i64, ptr %v287, i64 0
  store i64 %v209, ptr %st87
  %v251 = getelementptr i64, ptr %s5, i64 0
  %v252.p = getelementptr i64, ptr %v55, i64 0
  %v252 = load i64, ptr %v252.p
  %st88 = getelementptr i64, ptr %v251, i64 0
  store i64 %v252, ptr %st88
  %v253.p = getelementptr i64, ptr %v55, i64 1
  %v253 = load i64, ptr %v253.p
  %st89 = getelementptr i64, ptr %v251, i64 1
  store i64 %v253, ptr %st89
  %v254.p = getelementptr i64, ptr %v55, i64 2
  %v254 = load i64, ptr %v254.p
  %st90 = getelementptr i64, ptr %v251, i64 2
  store i64 %v254, ptr %st90
  %v255 = getelementptr i64, ptr %s3, i64 0
  %v256 = add i64 0, 0
  %st91 = getelementptr i64, ptr %v255, i64 0
  store i64 %v256, ptr %st91
  %st92 = getelementptr i64, ptr %v255, i64 1
  store i64 %v256, ptr %st92
  %st93 = getelementptr i64, ptr %v255, i64 2
  store i64 %v256, ptr %st93
  %v257.p = getelementptr i64, ptr %v251, i64 0
  %v257 = load i64, ptr %v257.p
  %st94 = getelementptr i64, ptr %v255, i64 0
  store i64 %v257, ptr %st94
  %v258.p = getelementptr i64, ptr %v251, i64 1
  %v258 = load i64, ptr %v258.p
  %st95 = getelementptr i64, ptr %v255, i64 1
  store i64 %v258, ptr %st95
  %v259.p = getelementptr i64, ptr %v251, i64 2
  %v259 = load i64, ptr %v259.p
  %st96 = getelementptr i64, ptr %v255, i64 2
  store i64 %v259, ptr %st96
  %v260.p = getelementptr i64, ptr %v255, i64 0
  %v260 = load i64, ptr %v260.p
  %st97 = getelementptr i64, ptr %v0, i64 0
  store i64 %v260, ptr %st97
  %v261.p = getelementptr i64, ptr %v255, i64 1
  %v261 = load i64, ptr %v261.p
  %st98 = getelementptr i64, ptr %v0, i64 1
  store i64 %v261, ptr %st98
  %v262.p = getelementptr i64, ptr %v255, i64 2
  %v262 = load i64, ptr %v262.p
  %st99 = getelementptr i64, ptr %v0, i64 2
  store i64 %v262, ptr %st99
  %v288 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v0, i64 %v288, i64 %v6)
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %st100 = getelementptr i64, ptr %v289, i64 0
  store i64 %v6, ptr %st100
  ret void
b26:
  %v223 = phi ptr [ %v238, %b27 ], [ %v233, %b28 ]
  %v224 = phi ptr [ %v239, %b27 ], [ %v232, %b28 ]
  %st101 = getelementptr i64, ptr %v224, i64 0
  store i64 %v219, ptr %st101
  %v240.p = getelementptr i64, ptr %v215, i64 1
  %v240 = load i64, ptr %v240.p
  %v241 = add i64 0, 1
  %v242 = add i64 %v240, %v241
  %v243 = getelementptr i64, ptr %s5, i64 0
  %v244 = ptrtoint ptr %v223 to i64
  %st102 = getelementptr i64, ptr %v243, i64 0
  store i64 %v244, ptr %st102
  %st103 = getelementptr i64, ptr %v243, i64 1
  store i64 %v242, ptr %st103
  %st104 = getelementptr i64, ptr %v243, i64 2
  store i64 %v220, ptr %st104
  %v245.p = getelementptr i64, ptr %v243, i64 0
  %v245 = load i64, ptr %v245.p
  %st105 = getelementptr i64, ptr %v55, i64 0
  store i64 %v245, ptr %st105
  %v246.p = getelementptr i64, ptr %v243, i64 1
  %v246 = load i64, ptr %v246.p
  %st106 = getelementptr i64, ptr %v55, i64 1
  store i64 %v246, ptr %st106
  %v247.p = getelementptr i64, ptr %v243, i64 2
  %v247 = load i64, ptr %v247.p
  %st107 = getelementptr i64, ptr %v55, i64 2
  store i64 %v247, ptr %st107
  %v248 = add i64 0, 1
  %v249.p = getelementptr i64, ptr %v208, i64 0
  %v249 = load i64, ptr %v249.p
  %v250 = add i64 %v249, %v248
  %st108 = getelementptr i64, ptr %v208, i64 0
  store i64 %v250, ptr %st108
  br label %b23
b27:
  %v234 = add i64 0, 1
  %v235 = mul i64 %v222, %v234
  %v236 = add i64 0, 1
  %v237 = add i64 0, 1
  %v238 = call ptr @"rt.slice_grow"(i64 %v221, i64 %v222, i64 %v236, i64 %v220, i64 %v237)
  %v239 = getelementptr i64, ptr %v238, i64 %v235
  br label %b26
b28:
  %v231 = add i64 0, 1
  %v232 = call ptr @"rt.region_alloc"(i64 %v220, i64 %v231)
  %v233 = inttoptr i64 %v221 to ptr
  br label %b26
}

define internal i64 @"std/task.LeaseTake"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v2, ptr %st2
  %v119 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v119, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6.p = getelementptr i64, ptr %v4, i64 1
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp eq i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b0 = icmp ne i64 %v8, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b2
b0.e5:
  br label %b1
b1:
  %v10 = add i64 0, 0
  %v11.p = getelementptr i64, ptr %v4, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp uge i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t6, label %b1.e7
b1.t6:
  br label %b3
b1.e7:
  br label %b4
b2:
  %v9 = phi i64 [ %v8, %b0.t4 ], [ %v20, %b4 ]
  %c.b2 = icmp ne i64 %v9, 0
  br i1 %c.b2, label %b2.t8, label %b2.e9
b2.t8:
  br label %b5
b2.e9:
  br label %b6
b3:
  %v13 = add i64 0, 19
  call void @"rt.panic"(i64 %v13)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v14.p = getelementptr i64, ptr %v4, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = inttoptr i64 %v14 to ptr
  %v16 = add i64 0, 1
  %v17 = mul i64 %v10, %v16
  %v18 = getelementptr i64, ptr %v15, i64 %v17
  %v19.p = getelementptr i64, ptr %v18, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.c = icmp ne i64 %v19, %v3
  %v20 = zext i1 %v20.c to i64
  br label %b2
b5:
  %v21 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v22 = add i64 0, 2
  %st9 = getelementptr i64, ptr %v21, i64 1026
  store i64 %v22, ptr %st9
  %v23 = getelementptr i64, ptr @"str.0", i64 0
  %v24 = add i64 0, 7
  %v25 = add i64 0, 0
  %v26 = getelementptr i64, ptr %s1, i64 0
  %v27 = ptrtoint ptr %v23 to i64
  %st10 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st10
  %st11 = getelementptr i64, ptr %v26, i64 1
  store i64 %v24, ptr %st11
  %st12 = getelementptr i64, ptr %v26, i64 2
  store i64 %v25, ptr %st12
  call void @"rt.print_str"(ptr %v26)
  %v28 = getelementptr i64, ptr @"str.7", i64 0
  %v29 = add i64 0, 14
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s2, i64 0
  %v32 = ptrtoint ptr %v28 to i64
  %st13 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st13
  %st14 = getelementptr i64, ptr %v31, i64 1
  store i64 %v29, ptr %st14
  %st15 = getelementptr i64, ptr %v31, i64 2
  store i64 %v30, ptr %st15
  call void @"rt.print_str"(ptr %v31)
  %v33 = getelementptr i64, ptr @"str.2", i64 0
  %v34 = add i64 0, 1
  %v35 = add i64 0, 0
  %v36 = getelementptr i64, ptr %s3, i64 0
  %v37 = ptrtoint ptr %v33 to i64
  %st16 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st16
  %st17 = getelementptr i64, ptr %v36, i64 1
  store i64 %v34, ptr %st17
  %st18 = getelementptr i64, ptr %v36, i64 2
  store i64 %v35, ptr %st18
  call void @"rt.print_str"(ptr %v36)
  %v38 = getelementptr i64, ptr @"str.3", i64 0
  %v39 = add i64 0, 1
  %v40 = add i64 0, 0
  %v41 = getelementptr i64, ptr %s4, i64 0
  %v42 = ptrtoint ptr %v38 to i64
  %st19 = getelementptr i64, ptr %v41, i64 0
  store i64 %v42, ptr %st19
  %st20 = getelementptr i64, ptr %v41, i64 1
  store i64 %v39, ptr %st20
  %st21 = getelementptr i64, ptr %v41, i64 2
  store i64 %v40, ptr %st21
  call void @"rt.print_str"(ptr %v41)
  %v43 = add i64 0, 20
  call void @"rt.panic"(i64 %v43)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  br label %b7
b7:
  %v44 = add i64 0, 1
  %v45.p = getelementptr i64, ptr %v4, i64 1
  %v45 = load i64, ptr %v45.p
  %v46.c = icmp uge i64 %v44, %v45
  %v46 = zext i1 %v46.c to i64
  %c.b7 = icmp ne i64 %v46, 0
  br i1 %c.b7, label %b7.t23, label %b7.e24
b7.t23:
  br label %b8
b7.e24:
  br label %b9
b8:
  %v47 = add i64 0, 21
  call void @"rt.panic"(i64 %v47)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v48.p = getelementptr i64, ptr %v4, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = inttoptr i64 %v48 to ptr
  %v50 = add i64 0, 1
  %v51 = mul i64 %v44, %v50
  %v52 = getelementptr i64, ptr %v49, i64 %v51
  %v53.p = getelementptr i64, ptr %v52, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 2
  %v55 = add i64 %v54, %v53
  %v56.p = getelementptr i64, ptr %v4, i64 1
  %v56 = load i64, ptr %v56.p
  %v57.c = icmp uge i64 %v55, %v56
  %v57 = zext i1 %v57.c to i64
  %c.b9 = icmp ne i64 %v57, 0
  br i1 %c.b9, label %b9.t25, label %b9.e26
b9.t25:
  br label %b10
b9.e26:
  br label %b11
b10:
  %v58 = add i64 0, 22
  call void @"rt.panic"(i64 %v58)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v59.p = getelementptr i64, ptr %v4, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = inttoptr i64 %v59 to ptr
  %v61 = add i64 0, 1
  %v62 = mul i64 %v55, %v61
  %v63 = getelementptr i64, ptr %v60, i64 %v62
  %v64.p = getelementptr i64, ptr %v63, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 1
  %v66 = add i64 0, 0
  %v67 = add i64 0, 0
  %v68.p = getelementptr i64, ptr %v4, i64 0
  %v68 = load i64, ptr %v68.p
  %v69 = call i64 @"rt.lease_op"(i64 %v65, i64 %v68, i64 %v66, i64 %v67)
  %v70 = add i64 0, 0
  %v71.c = icmp slt i64 %v69, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b11 = icmp ne i64 %v71, 0
  br i1 %c.b11, label %b11.t27, label %b11.e28
b11.t27:
  br label %b13
b11.e28:
  br label %b12
b12:
  %v73.c = icmp sge i64 %v69, %v64
  %v73 = zext i1 %v73.c to i64
  br label %b13
b13:
  %v72 = phi i64 [ %v71, %b11.t27 ], [ %v73, %b12 ]
  %c.b13 = icmp ne i64 %v72, 0
  br i1 %c.b13, label %b13.t29, label %b13.e30
b13.t29:
  br label %b14
b13.e30:
  br label %b15
b14:
  %v74 = add i64 0, 0
  %v75 = add i64 0, 1
  %v76 = sub i64 %v74, %v75
  %v120 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v120, i64 0
  store i64 %v5, ptr %st30
  ret i64 %v76
b15:
  br label %b16
b16:
  %v77 = add i64 0, 2
  %v78 = getelementptr i64, ptr %s5, i64 0
  %st31 = getelementptr i64, ptr %v78, i64 0
  store i64 %v77, ptr %st31
  %v79 = add i64 0, 0
  %v80 = getelementptr i64, ptr %s6, i64 0
  %st32 = getelementptr i64, ptr %v80, i64 0
  store i64 %v79, ptr %st32
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %v81.p = getelementptr i64, ptr %v121, i64 0
  %v81 = load i64, ptr %v81.p
  br label %b17
b17:
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v122, i64 0
  store i64 %v81, ptr %st33
  %v82.p = getelementptr i64, ptr %v80, i64 0
  %v82 = load i64, ptr %v82.p
  %v83.c = icmp slt i64 %v82, %v53
  %v83 = zext i1 %v83.c to i64
  %c.b17 = icmp ne i64 %v83, 0
  br i1 %c.b17, label %b17.t35, label %b17.e36
b17.t35:
  br label %b18
b17.e36:
  br label %b19
b18:
  call void @"rt.region_enter"()
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %v84.p = getelementptr i64, ptr %v123, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 1
  %v86 = add i64 0, 2
  %v87.p = getelementptr i64, ptr %v80, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 %v86, %v87
  %v89.p = getelementptr i64, ptr %v4, i64 1
  %v89 = load i64, ptr %v89.p
  %v90.c = icmp uge i64 %v88, %v89
  %v90 = zext i1 %v90.c to i64
  %c.b18 = icmp ne i64 %v90, 0
  br i1 %c.b18, label %b18.t37, label %b18.e38
b18.t37:
  br label %b20
b18.e38:
  br label %b21
b19:
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v124, i64 0
  store i64 %v81, ptr %st38
  %v104 = add i64 0, 3
  %v105 = add i64 %v104, %v53
  %v106.p = getelementptr i64, ptr %v78, i64 0
  %v106 = load i64, ptr %v106.p
  %v107 = mul i64 %v69, %v106
  %v108 = add i64 %v105, %v107
  %v109 = add i64 0, 2
  %v110 = add i64 0, 0
  %v111.p = getelementptr i64, ptr %v4, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = call i64 @"rt.lease_op"(i64 %v109, i64 %v111, i64 %v108, i64 %v110)
  %v113 = add i64 0, 1
  %v114.c = icmp eq i64 %v112, %v113
  %v114 = zext i1 %v114.c to i64
  %c.b19 = icmp ne i64 %v114, 0
  br i1 %c.b19, label %b19.t40, label %b19.e41
b19.t40:
  br label %b22
b19.e41:
  br label %b23
b20:
  %v91 = add i64 0, 23
  call void @"rt.panic"(i64 %v91)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v92.p = getelementptr i64, ptr %v4, i64 0
  %v92 = load i64, ptr %v92.p
  %v93 = inttoptr i64 %v92 to ptr
  %v94 = add i64 0, 1
  %v95 = mul i64 %v88, %v94
  %v96 = getelementptr i64, ptr %v93, i64 %v95
  %v97.p = getelementptr i64, ptr %v96, i64 0
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 %v85, %v97
  %v99.p = getelementptr i64, ptr %v78, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 %v99, %v98
  %st41 = getelementptr i64, ptr %v78, i64 0
  store i64 %v100, ptr %st41
  %v101 = add i64 0, 1
  %v102.p = getelementptr i64, ptr %v80, i64 0
  %v102 = load i64, ptr %v102.p
  %v103 = add i64 %v102, %v101
  %st42 = getelementptr i64, ptr %v80, i64 0
  store i64 %v103, ptr %st42
  br label %b17
b22:
  br label %b24
b23:
  %v115 = add i64 0, 0
  %v116 = add i64 0, 1
  %v117 = sub i64 %v115, %v116
  br label %b24
b24:
  %v118 = phi i64 [ %v108, %b22 ], [ %v117, %b23 ]
  %v125 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v125, i64 0
  store i64 %v5, ptr %st43
  ret i64 %v118
}

define internal void @"std/task.LeaseBlock"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v10 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v0, i64 %v10, i64 %v5)
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v5, ptr %st6
  ret void
}

define internal i64 @"rt.lease_op"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v4 = add i64 0, 3
  %v5.n = and i64 %v4, 63
  %v5 = shl i64 %v2, %v5.n
  %v6 = add i64 %v1, %v5
  %v7 = inttoptr i64 %v6 to ptr
  %v8 = add i64 0, 0
  %v9 = add i64 0, 1
  %v10.c = icmp eq i64 %v0, %v8
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  ret i64 %v9
b2:
  %v11.c = icmp eq i64 %v0, %v9
  %v11 = zext i1 %v11.c to i64
  %c.b2 = icmp ne i64 %v11, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  ret i64 %v8
b4:
  %v12 = add i64 0, 6
  %v13.c = icmp eq i64 %v0, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b4 = icmp ne i64 %v13, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  ret i64 %v8
b6:
  %v14 = add i64 0, 4
  %v15.c = icmp eq i64 %v0, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b6 = icmp ne i64 %v15, 0
  br i1 %c.b6, label %b6.t7, label %b6.e8
b6.t7:
  br label %b7
b6.e8:
  br label %b8
b7:
  %v16.p = getelementptr i64, ptr %v7, i64 0
  %v16 = load i64, ptr %v16.p
  ret i64 %v16
b8:
  %v17 = add i64 0, 5
  %v18.c = icmp eq i64 %v0, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b8 = icmp ne i64 %v18, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b9
b8.e10:
  br label %b10
b9:
  %st10 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st10
  ret i64 %v8
b10:
  %v19 = add i64 0, 3
  %v20.c = icmp eq i64 %v0, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b10 = icmp ne i64 %v20, 0
  br i1 %c.b10, label %b10.t12, label %b10.e13
b10.t12:
  br label %b11
b10.e13:
  br label %b12
b11:
  %st13 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st13
  ret i64 %v8
b12:
  %v21.p = getelementptr i64, ptr %v7, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.c = icmp ne i64 %v21, %v8
  %v22 = zext i1 %v22.c to i64
  %c.b12 = icmp ne i64 %v22, 0
  br i1 %c.b12, label %b12.t15, label %b12.e16
b12.t15:
  br label %b13
b12.e16:
  br label %b14
b13:
  ret i64 %v8
b14:
  %st16 = getelementptr i64, ptr %v7, i64 0
  store i64 %v9, ptr %st16
  ret i64 %v9
}

define internal void @"std/pool.badScratch"(i64 %v0) #0 {
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
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v38, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = getelementptr i64, ptr %s0, i64 0
  %v3 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v3, ptr %st0
  %st1 = getelementptr i64, ptr %v2, i64 0
  store i64 %v0, ptr %st1
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v5 = add i64 0, 2
  %st2 = getelementptr i64, ptr %v4, i64 1026
  store i64 %v5, ptr %st2
  %v6 = getelementptr i64, ptr @"str.0", i64 0
  %v7 = add i64 0, 7
  %v8 = add i64 0, 0
  %v9 = getelementptr i64, ptr %s1, i64 0
  %v10 = ptrtoint ptr %v6 to i64
  %st3 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st3
  %st4 = getelementptr i64, ptr %v9, i64 1
  store i64 %v7, ptr %st4
  %st5 = getelementptr i64, ptr %v9, i64 2
  store i64 %v8, ptr %st5
  call void @"rt.print_str"(ptr %v9)
  %v11 = getelementptr i64, ptr @"str.4", i64 0
  %v12 = add i64 0, 15
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %v15 = ptrtoint ptr %v11 to i64
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 1
  store i64 %v12, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 2
  store i64 %v13, ptr %st8
  call void @"rt.print_str"(ptr %v14)
  %v16 = getelementptr i64, ptr @"str.2", i64 0
  %v17 = add i64 0, 1
  %v18 = add i64 0, 0
  %v19 = getelementptr i64, ptr %s3, i64 0
  %v20 = ptrtoint ptr %v16 to i64
  %st9 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st9
  %st10 = getelementptr i64, ptr %v19, i64 1
  store i64 %v17, ptr %st10
  %st11 = getelementptr i64, ptr %v19, i64 2
  store i64 %v18, ptr %st11
  call void @"rt.print_str"(ptr %v19)
  %v21 = getelementptr i64, ptr @"str.5", i64 0
  %v22 = add i64 0, 1
  %v23 = add i64 0, 0
  %v24 = getelementptr i64, ptr %s4, i64 0
  %v25 = ptrtoint ptr %v21 to i64
  %st12 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st12
  %st13 = getelementptr i64, ptr %v24, i64 1
  store i64 %v22, ptr %st13
  %st14 = getelementptr i64, ptr %v24, i64 2
  store i64 %v23, ptr %st14
  call void @"rt.print_str"(ptr %v24)
  %v26 = getelementptr i64, ptr @"str.6", i64 0
  %v27 = add i64 0, 2
  %v28 = add i64 0, 0
  %v29 = getelementptr i64, ptr %s5, i64 0
  %v30 = ptrtoint ptr %v26 to i64
  %st15 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st15
  %st16 = getelementptr i64, ptr %v29, i64 1
  store i64 %v27, ptr %st16
  %st17 = getelementptr i64, ptr %v29, i64 2
  store i64 %v28, ptr %st17
  call void @"rt.print_str"(ptr %v29)
  %v31.p = getelementptr i64, ptr %v2, i64 0
  %v31 = load i64, ptr %v31.p
  call void @"rt.print_int"(i64 %v31)
  %v32 = getelementptr i64, ptr @"str.3", i64 0
  %v33 = add i64 0, 1
  %v34 = add i64 0, 0
  %v35 = getelementptr i64, ptr %s6, i64 0
  %v36 = ptrtoint ptr %v32 to i64
  %st18 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st18
  %st19 = getelementptr i64, ptr %v35, i64 1
  store i64 %v33, ptr %st19
  %st20 = getelementptr i64, ptr %v35, i64 2
  store i64 %v34, ptr %st20
  call void @"rt.print_str"(ptr %v35)
  %v37 = add i64 0, 18
  call void @"rt.panic"(i64 %v37)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
}

define internal void @"std/task.LeaseGive"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v12 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v12, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 0
  %v7.c = icmp sge i64 %v3, %v6
  %v7 = zext i1 %v7.c to i64
  %c.b0 = icmp ne i64 %v7, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v8 = add i64 0, 3
  %v9 = add i64 0, 0
  %v10.p = getelementptr i64, ptr %v4, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = call i64 @"rt.lease_op"(i64 %v8, i64 %v10, i64 %v3, i64 %v9)
  br label %b3
b2:
  br label %b3
b3:
  %v13 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v13, i64 0
  store i64 %v5, ptr %st5
  ret void
}
