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
@"rt.psites" = internal constant [43 x i64] [i64 3940651620106248, i64 9007201502887937, i64 7881301679931393, i64 8444252958752769, i64 3940651620106248, i64 9007201502887937, i64 7881301679931393, i64 6473928222441473, i64 3659178505666561, i64 11540477870342148, i64 5629503510413313, i64 4503602462720004, i64 5629502487003137, i64 2814752384352260, i64 3377702388105217, i64 4503602462720004, i64 5629502487003137, i64 2814752384352260, i64 3377702388105217, i64 4785077120663553, i64 4785077137440772, i64 4785077120663553, i64 4785077137440772, i64 8444252958752769, i64 3940651620106248, i64 9007201502887937, i64 7881301679931393, i64 6473928222441473, i64 3659178505666561, i64 11540477870342148, i64 5629503510413313, i64 4785077120663553, i64 4785077137440772, i64 4785077120663553, i64 4785077137440772, i64 2814752518569992, i64 9570155986157825, i64 3940656468721928, i64 4503606455697665, i64 4785081449185537, i64 7036881397088513, i64 6473930822910209, i64 7599830897524993]
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
  %s0 = alloca [8 x i64], align 8
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
  %s1 = alloca [8 x i64], align 8
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
  %s17 = alloca [1 x i64], align 8
  %s17.z0 = getelementptr i64, ptr %s17, i64 0
  store i64 0, ptr %s17.z0
  %s18 = alloca [1 x i64], align 8
  %s18.z0 = getelementptr i64, ptr %s18, i64 0
  store i64 0, ptr %s18.z0
  %s19 = alloca [3 x i64], align 8
  %s19.z0 = getelementptr i64, ptr %s19, i64 0
  store i64 0, ptr %s19.z0
  %s19.z1 = getelementptr i64, ptr %s19, i64 1
  store i64 0, ptr %s19.z1
  %s19.z2 = getelementptr i64, ptr %s19, i64 2
  store i64 0, ptr %s19.z2
  %s20 = alloca [1 x i64], align 8
  %s20.z0 = getelementptr i64, ptr %s20, i64 0
  store i64 0, ptr %s20.z0
  %s21 = alloca [1 x i64], align 8
  %s21.z0 = getelementptr i64, ptr %s21, i64 0
  store i64 0, ptr %s21.z0
  %v1320 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v1320, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1321 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v1321, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v1322 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v1322, i64 0
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
  %v1323 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v1323, i64 0
  %v5 = load i64, ptr %v5.p
  %v1324 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1325 = getelementptr i64, ptr %v1324, i64 %v5
  %v6.p = getelementptr i64, ptr %v1325, i64 1
  %v6 = load ptr, ptr %v6.p
  %v7 = ptrtoint ptr %v6 to i64
  %st8 = getelementptr i64, ptr %v3, i64 0
  store i64 %v7, ptr %st8
  %v8 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v3, i64 1
  store i64 %v8, ptr %st9
  %st10 = getelementptr i64, ptr %v3, i64 2
  store i64 %v5, ptr %st10
  %v9 = add i64 0, 4
  %v10 = getelementptr i64, ptr %v3, i64 %v9
  %v1326 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v1326, i64 0
  %v11 = load i64, ptr %v11.p
  %v1327 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1328 = getelementptr i64, ptr %v1327, i64 %v11
  %v12.p = getelementptr i64, ptr %v1328, i64 1
  %v12 = load ptr, ptr %v12.p
  %v13 = ptrtoint ptr %v12 to i64
  %st11 = getelementptr i64, ptr %v10, i64 0
  store i64 %v13, ptr %st11
  %v14 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v10, i64 1
  store i64 %v14, ptr %st12
  %st13 = getelementptr i64, ptr %v10, i64 2
  store i64 %v11, ptr %st13
  %v15 = getelementptr i64, ptr %s1, i64 0
  %v16.p = getelementptr i64, ptr %v3, i64 0
  %v16 = load i64, ptr %v16.p
  %st14 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st14
  %v17.p = getelementptr i64, ptr %v3, i64 1
  %v17 = load i64, ptr %v17.p
  %st15 = getelementptr i64, ptr %v15, i64 1
  store i64 %v17, ptr %st15
  %v18.p = getelementptr i64, ptr %v3, i64 2
  %v18 = load i64, ptr %v18.p
  %st16 = getelementptr i64, ptr %v15, i64 2
  store i64 %v18, ptr %st16
  %v19.p = getelementptr i64, ptr %v3, i64 3
  %v19 = load i64, ptr %v19.p
  %st17 = getelementptr i64, ptr %v15, i64 3
  store i64 %v19, ptr %st17
  %v20.p = getelementptr i64, ptr %v3, i64 4
  %v20 = load i64, ptr %v20.p
  %st18 = getelementptr i64, ptr %v15, i64 4
  store i64 %v20, ptr %st18
  %v21.p = getelementptr i64, ptr %v3, i64 5
  %v21 = load i64, ptr %v21.p
  %st19 = getelementptr i64, ptr %v15, i64 5
  store i64 %v21, ptr %st19
  %v22.p = getelementptr i64, ptr %v3, i64 6
  %v22 = load i64, ptr %v22.p
  %st20 = getelementptr i64, ptr %v15, i64 6
  store i64 %v22, ptr %st20
  %v23.p = getelementptr i64, ptr %v3, i64 7
  %v23 = load i64, ptr %v23.p
  %st21 = getelementptr i64, ptr %v15, i64 7
  store i64 %v23, ptr %st21
  %v24 = add i64 0, 4
  %v25 = getelementptr i64, ptr %s2, i64 0
  %v1329 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v1329, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v15, i64 1
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 0, 0
  %v29.c = icmp sgt i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b0 = icmp ne i64 %v29, 0
  br i1 %c.b0, label %b0.t23, label %b0.e24
b0.t23:
  br label %b2
b0.e24:
  br label %b3
b1:
  %v247 = getelementptr i64, ptr %s11, i64 0
  %v248 = add i64 0, 1196654069739148631
  %v249 = getelementptr i64, ptr %s2, i64 0
  %v1330 = getelementptr i64, ptr @"rt.meta", i64 0
  %v250.p = getelementptr i64, ptr %v1330, i64 0
  %v250 = load i64, ptr %v250.p
  %v251.p = getelementptr i64, ptr %v15, i64 1
  %v251 = load i64, ptr %v251.p
  %st24 = getelementptr i64, ptr %v249, i64 0
  store i64 %v251, ptr %st24
  %v1331 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v1331, i64 0
  store i64 %v250, ptr %st25
  br label %b45
b2:
  %v30 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v31 = add i64 0, 2
  %st26 = getelementptr i64, ptr %v30, i64 1026
  store i64 %v31, ptr %st26
  %v32 = getelementptr i64, ptr @"str.0", i64 0
  %v33 = add i64 0, 7
  %v34 = add i64 0, 0
  %v35 = getelementptr i64, ptr %s3, i64 0
  %v36 = ptrtoint ptr %v32 to i64
  %st27 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st27
  %st28 = getelementptr i64, ptr %v35, i64 1
  store i64 %v33, ptr %st28
  %st29 = getelementptr i64, ptr %v35, i64 2
  store i64 %v34, ptr %st29
  call void @"rt.print_str"(ptr %v35)
  %v37 = getelementptr i64, ptr @"str.1", i64 0
  %v38 = add i64 0, 17
  %v39 = add i64 0, 0
  %v40 = getelementptr i64, ptr %s4, i64 0
  %v41 = ptrtoint ptr %v37 to i64
  %st30 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st30
  %st31 = getelementptr i64, ptr %v40, i64 1
  store i64 %v38, ptr %st31
  %st32 = getelementptr i64, ptr %v40, i64 2
  store i64 %v39, ptr %st32
  call void @"rt.print_str"(ptr %v40)
  %v42 = getelementptr i64, ptr @"str.2", i64 0
  %v43 = add i64 0, 1
  %v44 = add i64 0, 0
  %v45 = getelementptr i64, ptr %s5, i64 0
  %v46 = ptrtoint ptr %v42 to i64
  %st33 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st33
  %st34 = getelementptr i64, ptr %v45, i64 1
  store i64 %v43, ptr %st34
  %st35 = getelementptr i64, ptr %v45, i64 2
  store i64 %v44, ptr %st35
  call void @"rt.print_str"(ptr %v45)
  %v47 = getelementptr i64, ptr @"str.3", i64 0
  %v48 = add i64 0, 1
  %v49 = add i64 0, 0
  %v50 = getelementptr i64, ptr %s6, i64 0
  %v51 = ptrtoint ptr %v47 to i64
  %st36 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st36
  %st37 = getelementptr i64, ptr %v50, i64 1
  store i64 %v48, ptr %st37
  %st38 = getelementptr i64, ptr %v50, i64 2
  store i64 %v49, ptr %st38
  call void @"rt.print_str"(ptr %v50)
  %v52 = add i64 0, 0
  call void @"rt.panic"(i64 %v52)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b3:
  br label %b4
b4:
  %v53 = add i64 0, 0
  %v54 = add i64 0, 3
  %v55 = getelementptr i64, ptr %v15, i64 %v54
  %st39 = getelementptr i64, ptr %v55, i64 0
  store i64 %v53, ptr %st39
  %v56 = getelementptr i64, ptr %s7, i64 0
  %v1332 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v1332, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 0, 256
  %v59.c = icmp slt i64 %v24, %v58
  %v59 = zext i1 %v59.c to i64
  %c.b4 = icmp ne i64 %v59, 0
  br i1 %c.b4, label %b4.t41, label %b4.e42
b4.t41:
  br label %b6
b4.e42:
  br label %b7
b5:
  br label %b1
b6:
  br label %b8
b7:
  %v60 = add i64 0, 256
  br label %b8
b8:
  %v61 = phi i64 [ %v24, %b6 ], [ %v60, %b7 ]
  %v1333 = getelementptr i64, ptr @"rt.meta", i64 0
  %v62.p = getelementptr i64, ptr %v1333, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 0, 0
  %v64 = call ptr @"rt.region_alloc"(i64 %v62, i64 %v63)
  %v65 = add i64 0, 0
  %v66 = getelementptr i64, ptr %s6, i64 0
  %v67 = ptrtoint ptr %v64 to i64
  %st42 = getelementptr i64, ptr %v66, i64 0
  store i64 %v67, ptr %st42
  %st43 = getelementptr i64, ptr %v66, i64 1
  store i64 %v65, ptr %st43
  %st44 = getelementptr i64, ptr %v66, i64 2
  store i64 %v62, ptr %st44
  %v68 = getelementptr i64, ptr %s5, i64 0
  %v69.p = getelementptr i64, ptr %v66, i64 0
  %v69 = load i64, ptr %v69.p
  %st45 = getelementptr i64, ptr %v68, i64 0
  store i64 %v69, ptr %st45
  %v70.p = getelementptr i64, ptr %v66, i64 1
  %v70 = load i64, ptr %v70.p
  %st46 = getelementptr i64, ptr %v68, i64 1
  store i64 %v70, ptr %st46
  %v71.p = getelementptr i64, ptr %v66, i64 2
  %v71 = load i64, ptr %v71.p
  %st47 = getelementptr i64, ptr %v68, i64 2
  store i64 %v71, ptr %st47
  %v1334 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v1334, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 0
  %v74 = getelementptr i64, ptr %s8, i64 0
  %v1335 = getelementptr i64, ptr @"rt.meta", i64 0
  %v75.p = getelementptr i64, ptr %v1335, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = getelementptr i64, ptr %s9, i64 0
  %st48 = getelementptr i64, ptr %v76, i64 0
  store i64 %v73, ptr %st48
  %v1336 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v1336, i64 0
  %v77 = load i64, ptr %v77.p
  br label %b11
b9:
  %v1337 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v1337, i64 0
  store i64 %v72, ptr %st49
  %v119 = getelementptr i64, ptr %s4, i64 0
  %v120.p = getelementptr i64, ptr %v68, i64 0
  %v120 = load i64, ptr %v120.p
  %st50 = getelementptr i64, ptr %v119, i64 0
  store i64 %v120, ptr %st50
  %v121.p = getelementptr i64, ptr %v68, i64 1
  %v121 = load i64, ptr %v121.p
  %st51 = getelementptr i64, ptr %v119, i64 1
  store i64 %v121, ptr %st51
  %v122.p = getelementptr i64, ptr %v68, i64 2
  %v122 = load i64, ptr %v122.p
  %st52 = getelementptr i64, ptr %v119, i64 2
  store i64 %v122, ptr %st52
  %v123 = add i64 0, 0
  %v124 = getelementptr i64, ptr %s9, i64 0
  %st53 = getelementptr i64, ptr %v124, i64 0
  store i64 %v123, ptr %st53
  %v1338 = getelementptr i64, ptr @"rt.meta", i64 0
  %v125.p = getelementptr i64, ptr %v1338, i64 0
  %v125 = load i64, ptr %v125.p
  br label %b18
b10:
  br label %b9
b11:
  %v1339 = getelementptr i64, ptr @"rt.meta", i64 0
  %st54 = getelementptr i64, ptr %v1339, i64 0
  store i64 %v77, ptr %st54
  %v78.p = getelementptr i64, ptr %v76, i64 0
  %v78 = load i64, ptr %v78.p
  %v79.c = icmp slt i64 %v78, %v61
  %v79 = zext i1 %v79.c to i64
  %c.b11 = icmp ne i64 %v79, 0
  br i1 %c.b11, label %b11.t56, label %b11.e57
b11.t56:
  br label %b12
b11.e57:
  br label %b13
b12:
  call void @"rt.region_enter"()
  %v1340 = getelementptr i64, ptr @"rt.meta", i64 0
  %v80.p = getelementptr i64, ptr %v1340, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v76, i64 0
  %v81 = load i64, ptr %v81.p
  %v1341 = getelementptr i64, ptr @"rt.meta", i64 0
  %v82.p = getelementptr i64, ptr %v1341, i64 0
  %v82 = load i64, ptr %v82.p
  %v83 = getelementptr i64, ptr %s6, i64 0
  %v84.p = getelementptr i64, ptr %v68, i64 0
  %v84 = load i64, ptr %v84.p
  %st57 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st57
  %v85.p = getelementptr i64, ptr %v68, i64 1
  %v85 = load i64, ptr %v85.p
  %st58 = getelementptr i64, ptr %v83, i64 1
  store i64 %v85, ptr %st58
  %v86.p = getelementptr i64, ptr %v68, i64 2
  %v86 = load i64, ptr %v86.p
  %st59 = getelementptr i64, ptr %v83, i64 2
  store i64 %v86, ptr %st59
  %v87 = add i64 0, 0
  %v88.p = getelementptr i64, ptr %v83, i64 2
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v83, i64 0
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v83, i64 1
  %v90 = load i64, ptr %v90.p
  %v93 = add i64 0, 8
  %v94 = mul i64 %v90, %v93
  %v95 = add i64 %v89, %v94
  %v1342 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1343 = getelementptr i64, ptr %v1342, i64 %v88
  %v96.p = getelementptr i64, ptr %v1343, i64 1
  %v96 = load ptr, ptr %v96.p
  %v97 = ptrtoint ptr %v96 to i64
  %v98.c = icmp eq i64 %v97, %v95
  %v98 = zext i1 %v98.c to i64
  %c.b12 = icmp ne i64 %v98, 0
  br i1 %c.b12, label %b12.t61, label %b12.e62
b12.t61:
  br label %b17
b12.e62:
  br label %b16
b13:
  %v1344 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v1344, i64 0
  store i64 %v77, ptr %st62
  br label %b10
b14:
  %v1345 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v1345, i64 0
  store i64 %v82, ptr %st63
  %v116 = add i64 0, 1
  %v117.p = getelementptr i64, ptr %v76, i64 0
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 %v117, %v116
  %st64 = getelementptr i64, ptr %v76, i64 0
  store i64 %v118, ptr %st64
  br label %b11
b15:
  %v91 = phi ptr [ %v106, %b16 ], [ %v101, %b17 ]
  %v92 = phi ptr [ %v107, %b16 ], [ %v100, %b17 ]
  %st65 = getelementptr i64, ptr %v92, i64 0
  store i64 %v87, ptr %st65
  %v108.p = getelementptr i64, ptr %v83, i64 1
  %v108 = load i64, ptr %v108.p
  %v109 = add i64 0, 1
  %v110 = add i64 %v108, %v109
  %v111 = getelementptr i64, ptr %s4, i64 0
  %v112 = ptrtoint ptr %v91 to i64
  %st66 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st66
  %st67 = getelementptr i64, ptr %v111, i64 1
  store i64 %v110, ptr %st67
  %st68 = getelementptr i64, ptr %v111, i64 2
  store i64 %v88, ptr %st68
  %v113.p = getelementptr i64, ptr %v111, i64 0
  %v113 = load i64, ptr %v113.p
  %st69 = getelementptr i64, ptr %v68, i64 0
  store i64 %v113, ptr %st69
  %v114.p = getelementptr i64, ptr %v111, i64 1
  %v114 = load i64, ptr %v114.p
  %st70 = getelementptr i64, ptr %v68, i64 1
  store i64 %v114, ptr %st70
  %v115.p = getelementptr i64, ptr %v111, i64 2
  %v115 = load i64, ptr %v115.p
  %st71 = getelementptr i64, ptr %v68, i64 2
  store i64 %v115, ptr %st71
  br label %b14
b16:
  %v102 = add i64 0, 1
  %v103 = mul i64 %v90, %v102
  %v104 = add i64 0, 1
  %v105 = add i64 0, 1
  %v106 = call ptr @"rt.slice_grow"(i64 %v89, i64 %v90, i64 %v104, i64 %v88, i64 %v105)
  %v107 = getelementptr i64, ptr %v106, i64 %v103
  br label %b15
b17:
  %v99 = add i64 0, 1
  %v100 = call ptr @"rt.region_alloc"(i64 %v88, i64 %v99)
  %v101 = inttoptr i64 %v89 to ptr
  br label %b15
b18:
  %v1346 = getelementptr i64, ptr @"rt.meta", i64 0
  %st72 = getelementptr i64, ptr %v1346, i64 0
  store i64 %v125, ptr %st72
  %v126.p = getelementptr i64, ptr %v124, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 %v126, %v61
  %v128.c = icmp sle i64 %v127, %v24
  %v128 = zext i1 %v128.c to i64
  %c.b18 = icmp ne i64 %v128, 0
  br i1 %c.b18, label %b18.t74, label %b18.e75
b18.t74:
  br label %b21
b18.e75:
  br label %b22
b19:
  call void @"rt.region_enter"()
  %v1347 = getelementptr i64, ptr @"rt.meta", i64 0
  %v132.p = getelementptr i64, ptr %v1347, i64 0
  %v132 = load i64, ptr %v132.p
  %v1348 = getelementptr i64, ptr @"rt.meta", i64 0
  %v133.p = getelementptr i64, ptr %v1348, i64 0
  %v133 = load i64, ptr %v133.p
  %v134 = add i64 0, 0
  %v135 = getelementptr i64, ptr %s8, i64 0
  %v1349 = getelementptr i64, ptr @"rt.meta", i64 0
  %v136.p = getelementptr i64, ptr %v1349, i64 0
  %v136 = load i64, ptr %v136.p
  %v137 = getelementptr i64, ptr %s10, i64 0
  %st75 = getelementptr i64, ptr %v137, i64 0
  store i64 %v134, ptr %st75
  %v1350 = getelementptr i64, ptr @"rt.meta", i64 0
  %v138.p = getelementptr i64, ptr %v1350, i64 0
  %v138 = load i64, ptr %v138.p
  br label %b25
b20:
  %v1351 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v1351, i64 0
  store i64 %v125, ptr %st76
  %v1352 = getelementptr i64, ptr @"rt.meta", i64 0
  %v190.p = getelementptr i64, ptr %v1352, i64 0
  %v190 = load i64, ptr %v190.p
  %v191 = add i64 0, 0
  %v192.p = getelementptr i64, ptr %v124, i64 0
  %v192 = load i64, ptr %v192.p
  %v193 = sub i64 %v24, %v192
  %v194 = getelementptr i64, ptr %s10, i64 0
  %v1353 = getelementptr i64, ptr @"rt.meta", i64 0
  %v195.p = getelementptr i64, ptr %v1353, i64 0
  %v195 = load i64, ptr %v195.p
  %v196 = getelementptr i64, ptr %s8, i64 0
  %st77 = getelementptr i64, ptr %v196, i64 0
  store i64 %v191, ptr %st77
  %v1354 = getelementptr i64, ptr @"rt.meta", i64 0
  %v197.p = getelementptr i64, ptr %v1354, i64 0
  %v197 = load i64, ptr %v197.p
  br label %b36
b21:
  %v130 = add i64 0, 0
  %v131.c = icmp sgt i64 %v61, %v130
  %v131 = zext i1 %v131.c to i64
  br label %b22
b22:
  %v129 = phi i64 [ %v128, %b18.e75 ], [ %v131, %b21 ]
  %c.b22 = icmp ne i64 %v129, 0
  br i1 %c.b22, label %b22.t79, label %b22.e80
b22.t79:
  br label %b19
b22.e80:
  br label %b20
b23:
  %v1355 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v1355, i64 0
  store i64 %v133, ptr %st80
  %v188.p = getelementptr i64, ptr %v124, i64 0
  %v188 = load i64, ptr %v188.p
  %v189 = add i64 %v188, %v61
  %st81 = getelementptr i64, ptr %v124, i64 0
  store i64 %v189, ptr %st81
  br label %b18
b24:
  br label %b23
b25:
  %v1356 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v1356, i64 0
  store i64 %v138, ptr %st82
  %v139.p = getelementptr i64, ptr %v137, i64 0
  %v139 = load i64, ptr %v139.p
  %v140.c = icmp slt i64 %v139, %v61
  %v140 = zext i1 %v140.c to i64
  %c.b25 = icmp ne i64 %v140, 0
  br i1 %c.b25, label %b25.t84, label %b25.e85
b25.t84:
  br label %b26
b25.e85:
  br label %b27
b26:
  call void @"rt.region_enter"()
  %v1357 = getelementptr i64, ptr @"rt.meta", i64 0
  %v141.p = getelementptr i64, ptr %v1357, i64 0
  %v141 = load i64, ptr %v141.p
  %v142.p = getelementptr i64, ptr %v137, i64 0
  %v142 = load i64, ptr %v142.p
  %v1358 = getelementptr i64, ptr @"rt.meta", i64 0
  %v143.p = getelementptr i64, ptr %v1358, i64 0
  %v143 = load i64, ptr %v143.p
  %v144 = getelementptr i64, ptr %s6, i64 0
  %v145.p = getelementptr i64, ptr %v15, i64 0
  %v145 = load i64, ptr %v145.p
  %st85 = getelementptr i64, ptr %v144, i64 0
  store i64 %v145, ptr %st85
  %v146.p = getelementptr i64, ptr %v15, i64 1
  %v146 = load i64, ptr %v146.p
  %st86 = getelementptr i64, ptr %v144, i64 1
  store i64 %v146, ptr %st86
  %v147.p = getelementptr i64, ptr %v15, i64 2
  %v147 = load i64, ptr %v147.p
  %st87 = getelementptr i64, ptr %v144, i64 2
  store i64 %v147, ptr %st87
  %v148.p = getelementptr i64, ptr %v119, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.c = icmp uge i64 %v142, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b26 = icmp ne i64 %v149, 0
  br i1 %c.b26, label %b26.t89, label %b26.e90
b26.t89:
  br label %b29
b26.e90:
  br label %b30
b27:
  %v1359 = getelementptr i64, ptr @"rt.meta", i64 0
  %st90 = getelementptr i64, ptr %v1359, i64 0
  store i64 %v138, ptr %st90
  br label %b24
b28:
  %v1360 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v1360, i64 0
  store i64 %v143, ptr %st91
  %v185 = add i64 0, 1
  %v186.p = getelementptr i64, ptr %v137, i64 0
  %v186 = load i64, ptr %v186.p
  %v187 = add i64 %v186, %v185
  %st92 = getelementptr i64, ptr %v137, i64 0
  store i64 %v187, ptr %st92
  br label %b25
b29:
  %v150 = add i64 0, 1
  call void @"rt.panic"(i64 %v150)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v151.p = getelementptr i64, ptr %v119, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = inttoptr i64 %v151 to ptr
  %v153 = add i64 0, 1
  %v154 = mul i64 %v142, %v153
  %v155 = getelementptr i64, ptr %v152, i64 %v154
  %v156.p = getelementptr i64, ptr %v155, i64 0
  %v156 = load i64, ptr %v156.p
  %v157.p = getelementptr i64, ptr %v144, i64 2
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v144, i64 0
  %v158 = load i64, ptr %v158.p
  %v159.p = getelementptr i64, ptr %v144, i64 1
  %v159 = load i64, ptr %v159.p
  %v162 = add i64 0, 8
  %v163 = mul i64 %v159, %v162
  %v164 = add i64 %v158, %v163
  %v1361 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1362 = getelementptr i64, ptr %v1361, i64 %v157
  %v165.p = getelementptr i64, ptr %v1362, i64 1
  %v165 = load ptr, ptr %v165.p
  %v166 = ptrtoint ptr %v165 to i64
  %v167.c = icmp eq i64 %v166, %v164
  %v167 = zext i1 %v167.c to i64
  %c.b30 = icmp ne i64 %v167, 0
  br i1 %c.b30, label %b30.t94, label %b30.e95
b30.t94:
  br label %b33
b30.e95:
  br label %b32
b31:
  %v160 = phi ptr [ %v175, %b32 ], [ %v170, %b33 ]
  %v161 = phi ptr [ %v176, %b32 ], [ %v169, %b33 ]
  %st95 = getelementptr i64, ptr %v161, i64 0
  store i64 %v156, ptr %st95
  %v177.p = getelementptr i64, ptr %v144, i64 1
  %v177 = load i64, ptr %v177.p
  %v178 = add i64 0, 1
  %v179 = add i64 %v177, %v178
  %v180 = getelementptr i64, ptr %s3, i64 0
  %v181 = ptrtoint ptr %v160 to i64
  %st96 = getelementptr i64, ptr %v180, i64 0
  store i64 %v181, ptr %st96
  %st97 = getelementptr i64, ptr %v180, i64 1
  store i64 %v179, ptr %st97
  %st98 = getelementptr i64, ptr %v180, i64 2
  store i64 %v157, ptr %st98
  %v182.p = getelementptr i64, ptr %v180, i64 0
  %v182 = load i64, ptr %v182.p
  %st99 = getelementptr i64, ptr %v15, i64 0
  store i64 %v182, ptr %st99
  %v183.p = getelementptr i64, ptr %v180, i64 1
  %v183 = load i64, ptr %v183.p
  %st100 = getelementptr i64, ptr %v15, i64 1
  store i64 %v183, ptr %st100
  %v184.p = getelementptr i64, ptr %v180, i64 2
  %v184 = load i64, ptr %v184.p
  %st101 = getelementptr i64, ptr %v15, i64 2
  store i64 %v184, ptr %st101
  br label %b28
b32:
  %v171 = add i64 0, 1
  %v172 = mul i64 %v159, %v171
  %v173 = add i64 0, 1
  %v174 = add i64 0, 1
  %v175 = call ptr @"rt.slice_grow"(i64 %v158, i64 %v159, i64 %v173, i64 %v157, i64 %v174)
  %v176 = getelementptr i64, ptr %v175, i64 %v172
  br label %b31
b33:
  %v168 = add i64 0, 1
  %v169 = call ptr @"rt.region_alloc"(i64 %v157, i64 %v168)
  %v170 = inttoptr i64 %v158 to ptr
  br label %b31
b34:
  %v1363 = getelementptr i64, ptr @"rt.meta", i64 0
  %st102 = getelementptr i64, ptr %v1363, i64 0
  store i64 %v190, ptr %st102
  br label %b5
b35:
  br label %b34
b36:
  %v1364 = getelementptr i64, ptr @"rt.meta", i64 0
  %st103 = getelementptr i64, ptr %v1364, i64 0
  store i64 %v197, ptr %st103
  %v198.p = getelementptr i64, ptr %v196, i64 0
  %v198 = load i64, ptr %v198.p
  %v199.c = icmp slt i64 %v198, %v193
  %v199 = zext i1 %v199.c to i64
  %c.b36 = icmp ne i64 %v199, 0
  br i1 %c.b36, label %b36.t105, label %b36.e106
b36.t105:
  br label %b37
b36.e106:
  br label %b38
b37:
  call void @"rt.region_enter"()
  %v1365 = getelementptr i64, ptr @"rt.meta", i64 0
  %v200.p = getelementptr i64, ptr %v1365, i64 0
  %v200 = load i64, ptr %v200.p
  %v201.p = getelementptr i64, ptr %v196, i64 0
  %v201 = load i64, ptr %v201.p
  %v1366 = getelementptr i64, ptr @"rt.meta", i64 0
  %v202.p = getelementptr i64, ptr %v1366, i64 0
  %v202 = load i64, ptr %v202.p
  %v203 = getelementptr i64, ptr %s3, i64 0
  %v204.p = getelementptr i64, ptr %v15, i64 0
  %v204 = load i64, ptr %v204.p
  %st106 = getelementptr i64, ptr %v203, i64 0
  store i64 %v204, ptr %st106
  %v205.p = getelementptr i64, ptr %v15, i64 1
  %v205 = load i64, ptr %v205.p
  %st107 = getelementptr i64, ptr %v203, i64 1
  store i64 %v205, ptr %st107
  %v206.p = getelementptr i64, ptr %v15, i64 2
  %v206 = load i64, ptr %v206.p
  %st108 = getelementptr i64, ptr %v203, i64 2
  store i64 %v206, ptr %st108
  %v207.p = getelementptr i64, ptr %v119, i64 1
  %v207 = load i64, ptr %v207.p
  %v208.c = icmp uge i64 %v201, %v207
  %v208 = zext i1 %v208.c to i64
  %c.b37 = icmp ne i64 %v208, 0
  br i1 %c.b37, label %b37.t110, label %b37.e111
b37.t110:
  br label %b40
b37.e111:
  br label %b41
b38:
  %v1367 = getelementptr i64, ptr @"rt.meta", i64 0
  %st111 = getelementptr i64, ptr %v1367, i64 0
  store i64 %v197, ptr %st111
  br label %b35
b39:
  %v1368 = getelementptr i64, ptr @"rt.meta", i64 0
  %st112 = getelementptr i64, ptr %v1368, i64 0
  store i64 %v202, ptr %st112
  %v244 = add i64 0, 1
  %v245.p = getelementptr i64, ptr %v196, i64 0
  %v245 = load i64, ptr %v245.p
  %v246 = add i64 %v245, %v244
  %st113 = getelementptr i64, ptr %v196, i64 0
  store i64 %v246, ptr %st113
  br label %b36
b40:
  %v209 = add i64 0, 2
  call void @"rt.panic"(i64 %v209)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b41:
  %v210.p = getelementptr i64, ptr %v119, i64 0
  %v210 = load i64, ptr %v210.p
  %v211 = inttoptr i64 %v210 to ptr
  %v212 = add i64 0, 1
  %v213 = mul i64 %v201, %v212
  %v214 = getelementptr i64, ptr %v211, i64 %v213
  %v215.p = getelementptr i64, ptr %v214, i64 0
  %v215 = load i64, ptr %v215.p
  %v216.p = getelementptr i64, ptr %v203, i64 2
  %v216 = load i64, ptr %v216.p
  %v217.p = getelementptr i64, ptr %v203, i64 0
  %v217 = load i64, ptr %v217.p
  %v218.p = getelementptr i64, ptr %v203, i64 1
  %v218 = load i64, ptr %v218.p
  %v221 = add i64 0, 8
  %v222 = mul i64 %v218, %v221
  %v223 = add i64 %v217, %v222
  %v1369 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1370 = getelementptr i64, ptr %v1369, i64 %v216
  %v224.p = getelementptr i64, ptr %v1370, i64 1
  %v224 = load ptr, ptr %v224.p
  %v225 = ptrtoint ptr %v224 to i64
  %v226.c = icmp eq i64 %v225, %v223
  %v226 = zext i1 %v226.c to i64
  %c.b41 = icmp ne i64 %v226, 0
  br i1 %c.b41, label %b41.t115, label %b41.e116
b41.t115:
  br label %b44
b41.e116:
  br label %b43
b42:
  %v219 = phi ptr [ %v234, %b43 ], [ %v229, %b44 ]
  %v220 = phi ptr [ %v235, %b43 ], [ %v228, %b44 ]
  %st116 = getelementptr i64, ptr %v220, i64 0
  store i64 %v215, ptr %st116
  %v236.p = getelementptr i64, ptr %v203, i64 1
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 0, 1
  %v238 = add i64 %v236, %v237
  %v239 = getelementptr i64, ptr %s6, i64 0
  %v240 = ptrtoint ptr %v219 to i64
  %st117 = getelementptr i64, ptr %v239, i64 0
  store i64 %v240, ptr %st117
  %st118 = getelementptr i64, ptr %v239, i64 1
  store i64 %v238, ptr %st118
  %st119 = getelementptr i64, ptr %v239, i64 2
  store i64 %v216, ptr %st119
  %v241.p = getelementptr i64, ptr %v239, i64 0
  %v241 = load i64, ptr %v241.p
  %st120 = getelementptr i64, ptr %v15, i64 0
  store i64 %v241, ptr %st120
  %v242.p = getelementptr i64, ptr %v239, i64 1
  %v242 = load i64, ptr %v242.p
  %st121 = getelementptr i64, ptr %v15, i64 1
  store i64 %v242, ptr %st121
  %v243.p = getelementptr i64, ptr %v239, i64 2
  %v243 = load i64, ptr %v243.p
  %st122 = getelementptr i64, ptr %v15, i64 2
  store i64 %v243, ptr %st122
  br label %b39
b43:
  %v230 = add i64 0, 1
  %v231 = mul i64 %v218, %v230
  %v232 = add i64 0, 1
  %v233 = add i64 0, 1
  %v234 = call ptr @"rt.slice_grow"(i64 %v217, i64 %v218, i64 %v232, i64 %v216, i64 %v233)
  %v235 = getelementptr i64, ptr %v234, i64 %v231
  br label %b42
b44:
  %v227 = add i64 0, 1
  %v228 = call ptr @"rt.region_alloc"(i64 %v216, i64 %v227)
  %v229 = inttoptr i64 %v217 to ptr
  br label %b42
b45:
  %v252.p = getelementptr i64, ptr %v249, i64 0
  %v252 = load i64, ptr %v252.p
  %v1371 = getelementptr i64, ptr @"rt.meta", i64 0
  %v253.p = getelementptr i64, ptr %v1371, i64 0
  %v253 = load i64, ptr %v253.p
  %v254 = add i64 0, 1
  %v255 = call ptr @"rt.region_alloc"(i64 %v253, i64 %v254)
  %st123 = getelementptr i64, ptr %v255, i64 0
  store i64 %v252, ptr %st123
  %v256 = add i64 0, 1
  %v257 = getelementptr i64, ptr %s4, i64 0
  %v258 = ptrtoint ptr %v255 to i64
  %st124 = getelementptr i64, ptr %v257, i64 0
  store i64 %v258, ptr %st124
  %st125 = getelementptr i64, ptr %v257, i64 1
  store i64 %v256, ptr %st125
  %st126 = getelementptr i64, ptr %v257, i64 2
  store i64 %v253, ptr %st126
  %v259.p = getelementptr i64, ptr %v257, i64 0
  %v259 = load i64, ptr %v259.p
  %v260.p = getelementptr i64, ptr %v257, i64 1
  %v260 = load i64, ptr %v260.p
  %v261.p = getelementptr i64, ptr %v257, i64 2
  %v261 = load i64, ptr %v261.p
  call void @"std/task.LocalNew"(ptr %v247, i64 %v248, i64 %v259, i64 %v260, i64 %v261)
  %v262 = getelementptr i64, ptr %s5, i64 0
  %v263.p = getelementptr i64, ptr %v247, i64 0
  %v263 = load i64, ptr %v263.p
  %st127 = getelementptr i64, ptr %v262, i64 0
  store i64 %v263, ptr %st127
  %v264.p = getelementptr i64, ptr %v247, i64 1
  %v264 = load i64, ptr %v264.p
  %st128 = getelementptr i64, ptr %v262, i64 1
  store i64 %v264, ptr %st128
  %v265.p = getelementptr i64, ptr %v247, i64 2
  %v265 = load i64, ptr %v265.p
  %st129 = getelementptr i64, ptr %v262, i64 2
  store i64 %v265, ptr %st129
  %v1372 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v262, i64 %v1372, i64 %v1)
  %v1373 = getelementptr i64, ptr @"rt.meta", i64 0
  %st130 = getelementptr i64, ptr %v1373, i64 0
  store i64 %v1, ptr %st130
  %v266 = getelementptr i64, ptr %s6, i64 0
  %v267.p = getelementptr i64, ptr %v262, i64 0
  %v267 = load i64, ptr %v267.p
  %st131 = getelementptr i64, ptr %v266, i64 0
  store i64 %v267, ptr %st131
  %v268.p = getelementptr i64, ptr %v262, i64 1
  %v268 = load i64, ptr %v268.p
  %st132 = getelementptr i64, ptr %v266, i64 1
  store i64 %v268, ptr %st132
  %v269.p = getelementptr i64, ptr %v262, i64 2
  %v269 = load i64, ptr %v269.p
  %st133 = getelementptr i64, ptr %v266, i64 2
  store i64 %v269, ptr %st133
  %v1374 = getelementptr i64, ptr @"rt.meta", i64 0
  %v270.p = getelementptr i64, ptr %v1374, i64 0
  %v270 = load i64, ptr %v270.p
  call void @"rt.region_enter"()
  %v1375 = getelementptr i64, ptr @"rt.meta", i64 0
  %v271.p = getelementptr i64, ptr %v1375, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = getelementptr i64, ptr %s4, i64 0
  %v273.p = getelementptr i64, ptr %v266, i64 0
  %v273 = load i64, ptr %v273.p
  %st134 = getelementptr i64, ptr %v272, i64 0
  store i64 %v273, ptr %st134
  %v274.p = getelementptr i64, ptr %v266, i64 1
  %v274 = load i64, ptr %v274.p
  %st135 = getelementptr i64, ptr %v272, i64 1
  store i64 %v274, ptr %st135
  %v275.p = getelementptr i64, ptr %v266, i64 2
  %v275 = load i64, ptr %v275.p
  %st136 = getelementptr i64, ptr %v272, i64 2
  store i64 %v275, ptr %st136
  %v276.p = getelementptr i64, ptr %v272, i64 0
  %v276 = load i64, ptr %v276.p
  %v277.p = getelementptr i64, ptr %v272, i64 1
  %v277 = load i64, ptr %v277.p
  %v278.p = getelementptr i64, ptr %v272, i64 2
  %v278 = load i64, ptr %v278.p
  %v279 = add i64 0, 1196654069739148631
  %v280 = call i64 @"std/task.LeaseTake"(i64 %v276, i64 %v277, i64 %v278, i64 %v279)
  %v281 = getelementptr i64, ptr %s1, i64 0
  %v282 = add i64 0, 0
  %st137 = getelementptr i64, ptr %v281, i64 0
  store i64 %v282, ptr %st137
  %st138 = getelementptr i64, ptr %v281, i64 1
  store i64 %v282, ptr %st138
  %st139 = getelementptr i64, ptr %v281, i64 2
  store i64 %v282, ptr %st139
  %st140 = getelementptr i64, ptr %v281, i64 3
  store i64 %v282, ptr %st140
  %st141 = getelementptr i64, ptr %v281, i64 4
  store i64 %v282, ptr %st141
  %st142 = getelementptr i64, ptr %v281, i64 5
  store i64 %v282, ptr %st142
  %st143 = getelementptr i64, ptr %v281, i64 6
  store i64 %v282, ptr %st143
  %st144 = getelementptr i64, ptr %v281, i64 7
  store i64 %v282, ptr %st144
  %v1376 = getelementptr i64, ptr @"rt.meta", i64 0
  %v283.p = getelementptr i64, ptr %v1376, i64 0
  %v283 = load i64, ptr %v283.p
  %v1377 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1378 = getelementptr i64, ptr %v1377, i64 %v283
  %v284.p = getelementptr i64, ptr %v1378, i64 1
  %v284 = load ptr, ptr %v284.p
  %v285 = ptrtoint ptr %v284 to i64
  %st145 = getelementptr i64, ptr %v281, i64 0
  store i64 %v285, ptr %st145
  %v286 = add i64 0, 0
  %st146 = getelementptr i64, ptr %v281, i64 1
  store i64 %v286, ptr %st146
  %st147 = getelementptr i64, ptr %v281, i64 2
  store i64 %v283, ptr %st147
  %v287 = add i64 0, 4
  %v288 = getelementptr i64, ptr %v281, i64 %v287
  %v1379 = getelementptr i64, ptr @"rt.meta", i64 0
  %v289.p = getelementptr i64, ptr %v1379, i64 0
  %v289 = load i64, ptr %v289.p
  %v1380 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1381 = getelementptr i64, ptr %v1380, i64 %v289
  %v290.p = getelementptr i64, ptr %v1381, i64 1
  %v290 = load ptr, ptr %v290.p
  %v291 = ptrtoint ptr %v290 to i64
  %st148 = getelementptr i64, ptr %v288, i64 0
  store i64 %v291, ptr %st148
  %v292 = add i64 0, 0
  %st149 = getelementptr i64, ptr %v288, i64 1
  store i64 %v292, ptr %st149
  %st150 = getelementptr i64, ptr %v288, i64 2
  store i64 %v289, ptr %st150
  %v293 = getelementptr i64, ptr %s0, i64 0
  %v294.p = getelementptr i64, ptr %v281, i64 0
  %v294 = load i64, ptr %v294.p
  %st151 = getelementptr i64, ptr %v293, i64 0
  store i64 %v294, ptr %st151
  %v295.p = getelementptr i64, ptr %v281, i64 1
  %v295 = load i64, ptr %v295.p
  %st152 = getelementptr i64, ptr %v293, i64 1
  store i64 %v295, ptr %st152
  %v296.p = getelementptr i64, ptr %v281, i64 2
  %v296 = load i64, ptr %v296.p
  %st153 = getelementptr i64, ptr %v293, i64 2
  store i64 %v296, ptr %st153
  %v297.p = getelementptr i64, ptr %v281, i64 3
  %v297 = load i64, ptr %v297.p
  %st154 = getelementptr i64, ptr %v293, i64 3
  store i64 %v297, ptr %st154
  %v298.p = getelementptr i64, ptr %v281, i64 4
  %v298 = load i64, ptr %v298.p
  %st155 = getelementptr i64, ptr %v293, i64 4
  store i64 %v298, ptr %st155
  %v299.p = getelementptr i64, ptr %v281, i64 5
  %v299 = load i64, ptr %v299.p
  %st156 = getelementptr i64, ptr %v293, i64 5
  store i64 %v299, ptr %st156
  %v300.p = getelementptr i64, ptr %v281, i64 6
  %v300 = load i64, ptr %v300.p
  %st157 = getelementptr i64, ptr %v293, i64 6
  store i64 %v300, ptr %st157
  %v301.p = getelementptr i64, ptr %v281, i64 7
  %v301 = load i64, ptr %v301.p
  %st158 = getelementptr i64, ptr %v293, i64 7
  store i64 %v301, ptr %st158
  %v302 = getelementptr i64, ptr %s12, i64 0
  %v303.p = getelementptr i64, ptr %v272, i64 0
  %v303 = load i64, ptr %v303.p
  %v304.p = getelementptr i64, ptr %v272, i64 1
  %v304 = load i64, ptr %v304.p
  %v305.p = getelementptr i64, ptr %v272, i64 2
  %v305 = load i64, ptr %v305.p
  call void @"std/task.LeaseBlock"(ptr %v302, i64 %v303, i64 %v304, i64 %v305)
  %v306 = getelementptr i64, ptr %s3, i64 0
  %v307.p = getelementptr i64, ptr %v302, i64 0
  %v307 = load i64, ptr %v307.p
  %st159 = getelementptr i64, ptr %v306, i64 0
  store i64 %v307, ptr %st159
  %v308.p = getelementptr i64, ptr %v302, i64 1
  %v308 = load i64, ptr %v308.p
  %st160 = getelementptr i64, ptr %v306, i64 1
  store i64 %v308, ptr %st160
  %v309.p = getelementptr i64, ptr %v302, i64 2
  %v309 = load i64, ptr %v309.p
  %st161 = getelementptr i64, ptr %v306, i64 2
  store i64 %v309, ptr %st161
  %v310 = add i64 0, 0
  %v311 = getelementptr i64, ptr %s9, i64 0
  %v1382 = getelementptr i64, ptr @"rt.meta", i64 0
  %v312.p = getelementptr i64, ptr %v1382, i64 0
  %v312 = load i64, ptr %v312.p
  %v313 = add i64 0, 0
  %v314.c = icmp slt i64 %v280, %v313
  %v314 = zext i1 %v314.c to i64
  %c.b45 = icmp ne i64 %v314, 0
  br i1 %c.b45, label %b45.t163, label %b45.e164
b45.t163:
  br label %b47
b45.e164:
  br label %b48
b46:
  %v1383 = getelementptr i64, ptr @"rt.meta", i64 0
  %v652.p = getelementptr i64, ptr %v1383, i64 0
  %v652 = load i64, ptr %v652.p
  call void @"rt.region_enter"()
  %v1384 = getelementptr i64, ptr @"rt.meta", i64 0
  %v653.p = getelementptr i64, ptr %v1384, i64 0
  %v653 = load i64, ptr %v653.p
  %v654 = getelementptr i64, ptr %s17, i64 0
  %v1385 = getelementptr i64, ptr @"rt.meta", i64 0
  %v655.p = getelementptr i64, ptr %v1385, i64 0
  %v655 = load i64, ptr %v655.p
  %v656 = add i64 0, 1
  %v657 = add i64 0, 32
  %v659 = add i64 0, 0
  %v660.c = icmp slt i64 %v657, %v659
  %v660 = zext i1 %v660.c to i64
  %c.b46 = icmp ne i64 %v660, 0
  br i1 %c.b46, label %b46.t165, label %b46.e166
b46.t165:
  br label %b117
b46.e166:
  br label %b118
b47:
  %v315 = add i64 0, 2
  %v316 = add i64 %v315, %v310
  %v317.p = getelementptr i64, ptr %v306, i64 1
  %v317 = load i64, ptr %v317.p
  %v318.c = icmp uge i64 %v316, %v317
  %v318 = zext i1 %v318.c to i64
  %c.b47 = icmp ne i64 %v318, 0
  br i1 %c.b47, label %b47.t167, label %b47.e168
b47.t167:
  br label %b49
b47.e168:
  br label %b50
b48:
  br label %b95
b49:
  %v319 = add i64 0, 3
  call void @"rt.panic"(i64 %v319)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b50:
  %v320.p = getelementptr i64, ptr %v306, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = inttoptr i64 %v320 to ptr
  %v322 = add i64 0, 1
  %v323 = mul i64 %v316, %v322
  %v324 = getelementptr i64, ptr %v321, i64 %v323
  %v325.p = getelementptr i64, ptr %v324, i64 0
  %v325 = load i64, ptr %v325.p
  %v326 = getelementptr i64, ptr %s7, i64 0
  %v1386 = getelementptr i64, ptr @"rt.meta", i64 0
  %v327.p = getelementptr i64, ptr %v1386, i64 0
  %v327 = load i64, ptr %v327.p
  %v328.p = getelementptr i64, ptr %v293, i64 1
  %v328 = load i64, ptr %v328.p
  %v329 = add i64 0, 0
  %v330.c = icmp sgt i64 %v328, %v329
  %v330 = zext i1 %v330.c to i64
  %c.b50 = icmp ne i64 %v330, 0
  br i1 %c.b50, label %b50.t169, label %b50.e170
b50.t169:
  br label %b52
b50.e170:
  br label %b53
b51:
  %v1387 = getelementptr i64, ptr @"rt.meta", i64 0
  %st170 = getelementptr i64, ptr %v1387, i64 0
  store i64 %v312, ptr %st170
  br label %b46
b52:
  %v331 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v332 = add i64 0, 2
  %st171 = getelementptr i64, ptr %v331, i64 1026
  store i64 %v332, ptr %st171
  %v333 = getelementptr i64, ptr @"str.0", i64 0
  %v334 = add i64 0, 7
  %v335 = add i64 0, 0
  %v336 = getelementptr i64, ptr %s13, i64 0
  %v337 = ptrtoint ptr %v333 to i64
  %st172 = getelementptr i64, ptr %v336, i64 0
  store i64 %v337, ptr %st172
  %st173 = getelementptr i64, ptr %v336, i64 1
  store i64 %v334, ptr %st173
  %st174 = getelementptr i64, ptr %v336, i64 2
  store i64 %v335, ptr %st174
  call void @"rt.print_str"(ptr %v336)
  %v338 = getelementptr i64, ptr @"str.1", i64 0
  %v339 = add i64 0, 17
  %v340 = add i64 0, 0
  %v341 = getelementptr i64, ptr %s14, i64 0
  %v342 = ptrtoint ptr %v338 to i64
  %st175 = getelementptr i64, ptr %v341, i64 0
  store i64 %v342, ptr %st175
  %st176 = getelementptr i64, ptr %v341, i64 1
  store i64 %v339, ptr %st176
  %st177 = getelementptr i64, ptr %v341, i64 2
  store i64 %v340, ptr %st177
  call void @"rt.print_str"(ptr %v341)
  %v343 = getelementptr i64, ptr @"str.2", i64 0
  %v344 = add i64 0, 1
  %v345 = add i64 0, 0
  %v346 = getelementptr i64, ptr %s15, i64 0
  %v347 = ptrtoint ptr %v343 to i64
  %st178 = getelementptr i64, ptr %v346, i64 0
  store i64 %v347, ptr %st178
  %st179 = getelementptr i64, ptr %v346, i64 1
  store i64 %v344, ptr %st179
  %st180 = getelementptr i64, ptr %v346, i64 2
  store i64 %v345, ptr %st180
  call void @"rt.print_str"(ptr %v346)
  %v348 = getelementptr i64, ptr @"str.3", i64 0
  %v349 = add i64 0, 1
  %v350 = add i64 0, 0
  %v351 = getelementptr i64, ptr %s16, i64 0
  %v352 = ptrtoint ptr %v348 to i64
  %st181 = getelementptr i64, ptr %v351, i64 0
  store i64 %v352, ptr %st181
  %st182 = getelementptr i64, ptr %v351, i64 1
  store i64 %v349, ptr %st182
  %st183 = getelementptr i64, ptr %v351, i64 2
  store i64 %v350, ptr %st183
  call void @"rt.print_str"(ptr %v351)
  %v353 = add i64 0, 4
  call void @"rt.panic"(i64 %v353)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b53:
  br label %b54
b54:
  %v354 = add i64 0, 0
  %v355 = add i64 0, 3
  %v356 = getelementptr i64, ptr %v293, i64 %v355
  %st184 = getelementptr i64, ptr %v356, i64 0
  store i64 %v354, ptr %st184
  %v357 = getelementptr i64, ptr %s8, i64 0
  %v1388 = getelementptr i64, ptr @"rt.meta", i64 0
  %v358.p = getelementptr i64, ptr %v1388, i64 0
  %v358 = load i64, ptr %v358.p
  %v359 = add i64 0, 256
  %v360.c = icmp slt i64 %v325, %v359
  %v360 = zext i1 %v360.c to i64
  %c.b54 = icmp ne i64 %v360, 0
  br i1 %c.b54, label %b54.t186, label %b54.e187
b54.t186:
  br label %b56
b54.e187:
  br label %b57
b55:
  br label %b51
b56:
  br label %b58
b57:
  %v361 = add i64 0, 256
  br label %b58
b58:
  %v362 = phi i64 [ %v325, %b56 ], [ %v361, %b57 ]
  %v1389 = getelementptr i64, ptr @"rt.meta", i64 0
  %v363.p = getelementptr i64, ptr %v1389, i64 0
  %v363 = load i64, ptr %v363.p
  %v364 = add i64 0, 0
  %v365 = call ptr @"rt.region_alloc"(i64 %v363, i64 %v364)
  %v366 = add i64 0, 0
  %v367 = getelementptr i64, ptr %s16, i64 0
  %v368 = ptrtoint ptr %v365 to i64
  %st187 = getelementptr i64, ptr %v367, i64 0
  store i64 %v368, ptr %st187
  %st188 = getelementptr i64, ptr %v367, i64 1
  store i64 %v366, ptr %st188
  %st189 = getelementptr i64, ptr %v367, i64 2
  store i64 %v363, ptr %st189
  %v369 = getelementptr i64, ptr %s15, i64 0
  %v370.p = getelementptr i64, ptr %v367, i64 0
  %v370 = load i64, ptr %v370.p
  %st190 = getelementptr i64, ptr %v369, i64 0
  store i64 %v370, ptr %st190
  %v371.p = getelementptr i64, ptr %v367, i64 1
  %v371 = load i64, ptr %v371.p
  %st191 = getelementptr i64, ptr %v369, i64 1
  store i64 %v371, ptr %st191
  %v372.p = getelementptr i64, ptr %v367, i64 2
  %v372 = load i64, ptr %v372.p
  %st192 = getelementptr i64, ptr %v369, i64 2
  store i64 %v372, ptr %st192
  %v1390 = getelementptr i64, ptr @"rt.meta", i64 0
  %v373.p = getelementptr i64, ptr %v1390, i64 0
  %v373 = load i64, ptr %v373.p
  %v374 = add i64 0, 0
  %v375 = getelementptr i64, ptr %s10, i64 0
  %v1391 = getelementptr i64, ptr @"rt.meta", i64 0
  %v376.p = getelementptr i64, ptr %v1391, i64 0
  %v376 = load i64, ptr %v376.p
  %v377 = getelementptr i64, ptr %s17, i64 0
  %st193 = getelementptr i64, ptr %v377, i64 0
  store i64 %v374, ptr %st193
  %v1392 = getelementptr i64, ptr @"rt.meta", i64 0
  %v378.p = getelementptr i64, ptr %v1392, i64 0
  %v378 = load i64, ptr %v378.p
  br label %b61
b59:
  %v1393 = getelementptr i64, ptr @"rt.meta", i64 0
  %st194 = getelementptr i64, ptr %v1393, i64 0
  store i64 %v373, ptr %st194
  %v420 = getelementptr i64, ptr %s14, i64 0
  %v421.p = getelementptr i64, ptr %v369, i64 0
  %v421 = load i64, ptr %v421.p
  %st195 = getelementptr i64, ptr %v420, i64 0
  store i64 %v421, ptr %st195
  %v422.p = getelementptr i64, ptr %v369, i64 1
  %v422 = load i64, ptr %v422.p
  %st196 = getelementptr i64, ptr %v420, i64 1
  store i64 %v422, ptr %st196
  %v423.p = getelementptr i64, ptr %v369, i64 2
  %v423 = load i64, ptr %v423.p
  %st197 = getelementptr i64, ptr %v420, i64 2
  store i64 %v423, ptr %st197
  %v424 = add i64 0, 0
  %v425 = getelementptr i64, ptr %s17, i64 0
  %st198 = getelementptr i64, ptr %v425, i64 0
  store i64 %v424, ptr %st198
  %v1394 = getelementptr i64, ptr @"rt.meta", i64 0
  %v426.p = getelementptr i64, ptr %v1394, i64 0
  %v426 = load i64, ptr %v426.p
  br label %b68
b60:
  br label %b59
b61:
  %v1395 = getelementptr i64, ptr @"rt.meta", i64 0
  %st199 = getelementptr i64, ptr %v1395, i64 0
  store i64 %v378, ptr %st199
  %v379.p = getelementptr i64, ptr %v377, i64 0
  %v379 = load i64, ptr %v379.p
  %v380.c = icmp slt i64 %v379, %v362
  %v380 = zext i1 %v380.c to i64
  %c.b61 = icmp ne i64 %v380, 0
  br i1 %c.b61, label %b61.t201, label %b61.e202
b61.t201:
  br label %b62
b61.e202:
  br label %b63
b62:
  call void @"rt.region_enter"()
  %v1396 = getelementptr i64, ptr @"rt.meta", i64 0
  %v381.p = getelementptr i64, ptr %v1396, i64 0
  %v381 = load i64, ptr %v381.p
  %v382.p = getelementptr i64, ptr %v377, i64 0
  %v382 = load i64, ptr %v382.p
  %v1397 = getelementptr i64, ptr @"rt.meta", i64 0
  %v383.p = getelementptr i64, ptr %v1397, i64 0
  %v383 = load i64, ptr %v383.p
  %v384 = getelementptr i64, ptr %s16, i64 0
  %v385.p = getelementptr i64, ptr %v369, i64 0
  %v385 = load i64, ptr %v385.p
  %st202 = getelementptr i64, ptr %v384, i64 0
  store i64 %v385, ptr %st202
  %v386.p = getelementptr i64, ptr %v369, i64 1
  %v386 = load i64, ptr %v386.p
  %st203 = getelementptr i64, ptr %v384, i64 1
  store i64 %v386, ptr %st203
  %v387.p = getelementptr i64, ptr %v369, i64 2
  %v387 = load i64, ptr %v387.p
  %st204 = getelementptr i64, ptr %v384, i64 2
  store i64 %v387, ptr %st204
  %v388 = add i64 0, 0
  %v389.p = getelementptr i64, ptr %v384, i64 2
  %v389 = load i64, ptr %v389.p
  %v390.p = getelementptr i64, ptr %v384, i64 0
  %v390 = load i64, ptr %v390.p
  %v391.p = getelementptr i64, ptr %v384, i64 1
  %v391 = load i64, ptr %v391.p
  %v394 = add i64 0, 8
  %v395 = mul i64 %v391, %v394
  %v396 = add i64 %v390, %v395
  %v1398 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1399 = getelementptr i64, ptr %v1398, i64 %v389
  %v397.p = getelementptr i64, ptr %v1399, i64 1
  %v397 = load ptr, ptr %v397.p
  %v398 = ptrtoint ptr %v397 to i64
  %v399.c = icmp eq i64 %v398, %v396
  %v399 = zext i1 %v399.c to i64
  %c.b62 = icmp ne i64 %v399, 0
  br i1 %c.b62, label %b62.t206, label %b62.e207
b62.t206:
  br label %b67
b62.e207:
  br label %b66
b63:
  %v1400 = getelementptr i64, ptr @"rt.meta", i64 0
  %st207 = getelementptr i64, ptr %v1400, i64 0
  store i64 %v378, ptr %st207
  br label %b60
b64:
  %v1401 = getelementptr i64, ptr @"rt.meta", i64 0
  %st208 = getelementptr i64, ptr %v1401, i64 0
  store i64 %v383, ptr %st208
  %v417 = add i64 0, 1
  %v418.p = getelementptr i64, ptr %v377, i64 0
  %v418 = load i64, ptr %v418.p
  %v419 = add i64 %v418, %v417
  %st209 = getelementptr i64, ptr %v377, i64 0
  store i64 %v419, ptr %st209
  br label %b61
b65:
  %v392 = phi ptr [ %v407, %b66 ], [ %v402, %b67 ]
  %v393 = phi ptr [ %v408, %b66 ], [ %v401, %b67 ]
  %st210 = getelementptr i64, ptr %v393, i64 0
  store i64 %v388, ptr %st210
  %v409.p = getelementptr i64, ptr %v384, i64 1
  %v409 = load i64, ptr %v409.p
  %v410 = add i64 0, 1
  %v411 = add i64 %v409, %v410
  %v412 = getelementptr i64, ptr %s14, i64 0
  %v413 = ptrtoint ptr %v392 to i64
  %st211 = getelementptr i64, ptr %v412, i64 0
  store i64 %v413, ptr %st211
  %st212 = getelementptr i64, ptr %v412, i64 1
  store i64 %v411, ptr %st212
  %st213 = getelementptr i64, ptr %v412, i64 2
  store i64 %v389, ptr %st213
  %v414.p = getelementptr i64, ptr %v412, i64 0
  %v414 = load i64, ptr %v414.p
  %st214 = getelementptr i64, ptr %v369, i64 0
  store i64 %v414, ptr %st214
  %v415.p = getelementptr i64, ptr %v412, i64 1
  %v415 = load i64, ptr %v415.p
  %st215 = getelementptr i64, ptr %v369, i64 1
  store i64 %v415, ptr %st215
  %v416.p = getelementptr i64, ptr %v412, i64 2
  %v416 = load i64, ptr %v416.p
  %st216 = getelementptr i64, ptr %v369, i64 2
  store i64 %v416, ptr %st216
  br label %b64
b66:
  %v403 = add i64 0, 1
  %v404 = mul i64 %v391, %v403
  %v405 = add i64 0, 1
  %v406 = add i64 0, 1
  %v407 = call ptr @"rt.slice_grow"(i64 %v390, i64 %v391, i64 %v405, i64 %v389, i64 %v406)
  %v408 = getelementptr i64, ptr %v407, i64 %v404
  br label %b65
b67:
  %v400 = add i64 0, 1
  %v401 = call ptr @"rt.region_alloc"(i64 %v389, i64 %v400)
  %v402 = inttoptr i64 %v390 to ptr
  br label %b65
b68:
  %v1402 = getelementptr i64, ptr @"rt.meta", i64 0
  %st217 = getelementptr i64, ptr %v1402, i64 0
  store i64 %v426, ptr %st217
  %v427.p = getelementptr i64, ptr %v425, i64 0
  %v427 = load i64, ptr %v427.p
  %v428 = add i64 %v427, %v362
  %v429.c = icmp sle i64 %v428, %v325
  %v429 = zext i1 %v429.c to i64
  %c.b68 = icmp ne i64 %v429, 0
  br i1 %c.b68, label %b68.t219, label %b68.e220
b68.t219:
  br label %b71
b68.e220:
  br label %b72
b69:
  call void @"rt.region_enter"()
  %v1403 = getelementptr i64, ptr @"rt.meta", i64 0
  %v433.p = getelementptr i64, ptr %v1403, i64 0
  %v433 = load i64, ptr %v433.p
  %v1404 = getelementptr i64, ptr @"rt.meta", i64 0
  %v434.p = getelementptr i64, ptr %v1404, i64 0
  %v434 = load i64, ptr %v434.p
  %v435 = add i64 0, 0
  %v436 = getelementptr i64, ptr %s10, i64 0
  %v1405 = getelementptr i64, ptr @"rt.meta", i64 0
  %v437.p = getelementptr i64, ptr %v1405, i64 0
  %v437 = load i64, ptr %v437.p
  %v438 = getelementptr i64, ptr %s18, i64 0
  %st220 = getelementptr i64, ptr %v438, i64 0
  store i64 %v435, ptr %st220
  %v1406 = getelementptr i64, ptr @"rt.meta", i64 0
  %v439.p = getelementptr i64, ptr %v1406, i64 0
  %v439 = load i64, ptr %v439.p
  br label %b75
b70:
  %v1407 = getelementptr i64, ptr @"rt.meta", i64 0
  %st221 = getelementptr i64, ptr %v1407, i64 0
  store i64 %v426, ptr %st221
  %v1408 = getelementptr i64, ptr @"rt.meta", i64 0
  %v491.p = getelementptr i64, ptr %v1408, i64 0
  %v491 = load i64, ptr %v491.p
  %v492 = add i64 0, 0
  %v493.p = getelementptr i64, ptr %v425, i64 0
  %v493 = load i64, ptr %v493.p
  %v494 = sub i64 %v325, %v493
  %v495 = getelementptr i64, ptr %s18, i64 0
  %v1409 = getelementptr i64, ptr @"rt.meta", i64 0
  %v496.p = getelementptr i64, ptr %v1409, i64 0
  %v496 = load i64, ptr %v496.p
  %v497 = getelementptr i64, ptr %s10, i64 0
  %st222 = getelementptr i64, ptr %v497, i64 0
  store i64 %v492, ptr %st222
  %v1410 = getelementptr i64, ptr @"rt.meta", i64 0
  %v498.p = getelementptr i64, ptr %v1410, i64 0
  %v498 = load i64, ptr %v498.p
  br label %b86
b71:
  %v431 = add i64 0, 0
  %v432.c = icmp sgt i64 %v362, %v431
  %v432 = zext i1 %v432.c to i64
  br label %b72
b72:
  %v430 = phi i64 [ %v429, %b68.e220 ], [ %v432, %b71 ]
  %c.b72 = icmp ne i64 %v430, 0
  br i1 %c.b72, label %b72.t224, label %b72.e225
b72.t224:
  br label %b69
b72.e225:
  br label %b70
b73:
  %v1411 = getelementptr i64, ptr @"rt.meta", i64 0
  %st225 = getelementptr i64, ptr %v1411, i64 0
  store i64 %v434, ptr %st225
  %v489.p = getelementptr i64, ptr %v425, i64 0
  %v489 = load i64, ptr %v489.p
  %v490 = add i64 %v489, %v362
  %st226 = getelementptr i64, ptr %v425, i64 0
  store i64 %v490, ptr %st226
  br label %b68
b74:
  br label %b73
b75:
  %v1412 = getelementptr i64, ptr @"rt.meta", i64 0
  %st227 = getelementptr i64, ptr %v1412, i64 0
  store i64 %v439, ptr %st227
  %v440.p = getelementptr i64, ptr %v438, i64 0
  %v440 = load i64, ptr %v440.p
  %v441.c = icmp slt i64 %v440, %v362
  %v441 = zext i1 %v441.c to i64
  %c.b75 = icmp ne i64 %v441, 0
  br i1 %c.b75, label %b75.t229, label %b75.e230
b75.t229:
  br label %b76
b75.e230:
  br label %b77
b76:
  call void @"rt.region_enter"()
  %v1413 = getelementptr i64, ptr @"rt.meta", i64 0
  %v442.p = getelementptr i64, ptr %v1413, i64 0
  %v442 = load i64, ptr %v442.p
  %v443.p = getelementptr i64, ptr %v438, i64 0
  %v443 = load i64, ptr %v443.p
  %v1414 = getelementptr i64, ptr @"rt.meta", i64 0
  %v444.p = getelementptr i64, ptr %v1414, i64 0
  %v444 = load i64, ptr %v444.p
  %v445 = getelementptr i64, ptr %s16, i64 0
  %v446.p = getelementptr i64, ptr %v293, i64 0
  %v446 = load i64, ptr %v446.p
  %st230 = getelementptr i64, ptr %v445, i64 0
  store i64 %v446, ptr %st230
  %v447.p = getelementptr i64, ptr %v293, i64 1
  %v447 = load i64, ptr %v447.p
  %st231 = getelementptr i64, ptr %v445, i64 1
  store i64 %v447, ptr %st231
  %v448.p = getelementptr i64, ptr %v293, i64 2
  %v448 = load i64, ptr %v448.p
  %st232 = getelementptr i64, ptr %v445, i64 2
  store i64 %v448, ptr %st232
  %v449.p = getelementptr i64, ptr %v420, i64 1
  %v449 = load i64, ptr %v449.p
  %v450.c = icmp uge i64 %v443, %v449
  %v450 = zext i1 %v450.c to i64
  %c.b76 = icmp ne i64 %v450, 0
  br i1 %c.b76, label %b76.t234, label %b76.e235
b76.t234:
  br label %b79
b76.e235:
  br label %b80
b77:
  %v1415 = getelementptr i64, ptr @"rt.meta", i64 0
  %st235 = getelementptr i64, ptr %v1415, i64 0
  store i64 %v439, ptr %st235
  br label %b74
b78:
  %v1416 = getelementptr i64, ptr @"rt.meta", i64 0
  %st236 = getelementptr i64, ptr %v1416, i64 0
  store i64 %v444, ptr %st236
  %v486 = add i64 0, 1
  %v487.p = getelementptr i64, ptr %v438, i64 0
  %v487 = load i64, ptr %v487.p
  %v488 = add i64 %v487, %v486
  %st237 = getelementptr i64, ptr %v438, i64 0
  store i64 %v488, ptr %st237
  br label %b75
b79:
  %v451 = add i64 0, 5
  call void @"rt.panic"(i64 %v451)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b80:
  %v452.p = getelementptr i64, ptr %v420, i64 0
  %v452 = load i64, ptr %v452.p
  %v453 = inttoptr i64 %v452 to ptr
  %v454 = add i64 0, 1
  %v455 = mul i64 %v443, %v454
  %v456 = getelementptr i64, ptr %v453, i64 %v455
  %v457.p = getelementptr i64, ptr %v456, i64 0
  %v457 = load i64, ptr %v457.p
  %v458.p = getelementptr i64, ptr %v445, i64 2
  %v458 = load i64, ptr %v458.p
  %v459.p = getelementptr i64, ptr %v445, i64 0
  %v459 = load i64, ptr %v459.p
  %v460.p = getelementptr i64, ptr %v445, i64 1
  %v460 = load i64, ptr %v460.p
  %v463 = add i64 0, 8
  %v464 = mul i64 %v460, %v463
  %v465 = add i64 %v459, %v464
  %v1417 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1418 = getelementptr i64, ptr %v1417, i64 %v458
  %v466.p = getelementptr i64, ptr %v1418, i64 1
  %v466 = load ptr, ptr %v466.p
  %v467 = ptrtoint ptr %v466 to i64
  %v468.c = icmp eq i64 %v467, %v465
  %v468 = zext i1 %v468.c to i64
  %c.b80 = icmp ne i64 %v468, 0
  br i1 %c.b80, label %b80.t239, label %b80.e240
b80.t239:
  br label %b83
b80.e240:
  br label %b82
b81:
  %v461 = phi ptr [ %v476, %b82 ], [ %v471, %b83 ]
  %v462 = phi ptr [ %v477, %b82 ], [ %v470, %b83 ]
  %st240 = getelementptr i64, ptr %v462, i64 0
  store i64 %v457, ptr %st240
  %v478.p = getelementptr i64, ptr %v445, i64 1
  %v478 = load i64, ptr %v478.p
  %v479 = add i64 0, 1
  %v480 = add i64 %v478, %v479
  %v481 = getelementptr i64, ptr %s13, i64 0
  %v482 = ptrtoint ptr %v461 to i64
  %st241 = getelementptr i64, ptr %v481, i64 0
  store i64 %v482, ptr %st241
  %st242 = getelementptr i64, ptr %v481, i64 1
  store i64 %v480, ptr %st242
  %st243 = getelementptr i64, ptr %v481, i64 2
  store i64 %v458, ptr %st243
  %v483.p = getelementptr i64, ptr %v481, i64 0
  %v483 = load i64, ptr %v483.p
  %st244 = getelementptr i64, ptr %v293, i64 0
  store i64 %v483, ptr %st244
  %v484.p = getelementptr i64, ptr %v481, i64 1
  %v484 = load i64, ptr %v484.p
  %st245 = getelementptr i64, ptr %v293, i64 1
  store i64 %v484, ptr %st245
  %v485.p = getelementptr i64, ptr %v481, i64 2
  %v485 = load i64, ptr %v485.p
  %st246 = getelementptr i64, ptr %v293, i64 2
  store i64 %v485, ptr %st246
  br label %b78
b82:
  %v472 = add i64 0, 1
  %v473 = mul i64 %v460, %v472
  %v474 = add i64 0, 1
  %v475 = add i64 0, 1
  %v476 = call ptr @"rt.slice_grow"(i64 %v459, i64 %v460, i64 %v474, i64 %v458, i64 %v475)
  %v477 = getelementptr i64, ptr %v476, i64 %v473
  br label %b81
b83:
  %v469 = add i64 0, 1
  %v470 = call ptr @"rt.region_alloc"(i64 %v458, i64 %v469)
  %v471 = inttoptr i64 %v459 to ptr
  br label %b81
b84:
  %v1419 = getelementptr i64, ptr @"rt.meta", i64 0
  %st247 = getelementptr i64, ptr %v1419, i64 0
  store i64 %v491, ptr %st247
  br label %b55
b85:
  br label %b84
b86:
  %v1420 = getelementptr i64, ptr @"rt.meta", i64 0
  %st248 = getelementptr i64, ptr %v1420, i64 0
  store i64 %v498, ptr %st248
  %v499.p = getelementptr i64, ptr %v497, i64 0
  %v499 = load i64, ptr %v499.p
  %v500.c = icmp slt i64 %v499, %v494
  %v500 = zext i1 %v500.c to i64
  %c.b86 = icmp ne i64 %v500, 0
  br i1 %c.b86, label %b86.t250, label %b86.e251
b86.t250:
  br label %b87
b86.e251:
  br label %b88
b87:
  call void @"rt.region_enter"()
  %v1421 = getelementptr i64, ptr @"rt.meta", i64 0
  %v501.p = getelementptr i64, ptr %v1421, i64 0
  %v501 = load i64, ptr %v501.p
  %v502.p = getelementptr i64, ptr %v497, i64 0
  %v502 = load i64, ptr %v502.p
  %v1422 = getelementptr i64, ptr @"rt.meta", i64 0
  %v503.p = getelementptr i64, ptr %v1422, i64 0
  %v503 = load i64, ptr %v503.p
  %v504 = getelementptr i64, ptr %s13, i64 0
  %v505.p = getelementptr i64, ptr %v293, i64 0
  %v505 = load i64, ptr %v505.p
  %st251 = getelementptr i64, ptr %v504, i64 0
  store i64 %v505, ptr %st251
  %v506.p = getelementptr i64, ptr %v293, i64 1
  %v506 = load i64, ptr %v506.p
  %st252 = getelementptr i64, ptr %v504, i64 1
  store i64 %v506, ptr %st252
  %v507.p = getelementptr i64, ptr %v293, i64 2
  %v507 = load i64, ptr %v507.p
  %st253 = getelementptr i64, ptr %v504, i64 2
  store i64 %v507, ptr %st253
  %v508.p = getelementptr i64, ptr %v420, i64 1
  %v508 = load i64, ptr %v508.p
  %v509.c = icmp uge i64 %v502, %v508
  %v509 = zext i1 %v509.c to i64
  %c.b87 = icmp ne i64 %v509, 0
  br i1 %c.b87, label %b87.t255, label %b87.e256
b87.t255:
  br label %b90
b87.e256:
  br label %b91
b88:
  %v1423 = getelementptr i64, ptr @"rt.meta", i64 0
  %st256 = getelementptr i64, ptr %v1423, i64 0
  store i64 %v498, ptr %st256
  br label %b85
b89:
  %v1424 = getelementptr i64, ptr @"rt.meta", i64 0
  %st257 = getelementptr i64, ptr %v1424, i64 0
  store i64 %v503, ptr %st257
  %v545 = add i64 0, 1
  %v546.p = getelementptr i64, ptr %v497, i64 0
  %v546 = load i64, ptr %v546.p
  %v547 = add i64 %v546, %v545
  %st258 = getelementptr i64, ptr %v497, i64 0
  store i64 %v547, ptr %st258
  br label %b86
b90:
  %v510 = add i64 0, 6
  call void @"rt.panic"(i64 %v510)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b91:
  %v511.p = getelementptr i64, ptr %v420, i64 0
  %v511 = load i64, ptr %v511.p
  %v512 = inttoptr i64 %v511 to ptr
  %v513 = add i64 0, 1
  %v514 = mul i64 %v502, %v513
  %v515 = getelementptr i64, ptr %v512, i64 %v514
  %v516.p = getelementptr i64, ptr %v515, i64 0
  %v516 = load i64, ptr %v516.p
  %v517.p = getelementptr i64, ptr %v504, i64 2
  %v517 = load i64, ptr %v517.p
  %v518.p = getelementptr i64, ptr %v504, i64 0
  %v518 = load i64, ptr %v518.p
  %v519.p = getelementptr i64, ptr %v504, i64 1
  %v519 = load i64, ptr %v519.p
  %v522 = add i64 0, 8
  %v523 = mul i64 %v519, %v522
  %v524 = add i64 %v518, %v523
  %v1425 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1426 = getelementptr i64, ptr %v1425, i64 %v517
  %v525.p = getelementptr i64, ptr %v1426, i64 1
  %v525 = load ptr, ptr %v525.p
  %v526 = ptrtoint ptr %v525 to i64
  %v527.c = icmp eq i64 %v526, %v524
  %v527 = zext i1 %v527.c to i64
  %c.b91 = icmp ne i64 %v527, 0
  br i1 %c.b91, label %b91.t260, label %b91.e261
b91.t260:
  br label %b94
b91.e261:
  br label %b93
b92:
  %v520 = phi ptr [ %v535, %b93 ], [ %v530, %b94 ]
  %v521 = phi ptr [ %v536, %b93 ], [ %v529, %b94 ]
  %st261 = getelementptr i64, ptr %v521, i64 0
  store i64 %v516, ptr %st261
  %v537.p = getelementptr i64, ptr %v504, i64 1
  %v537 = load i64, ptr %v537.p
  %v538 = add i64 0, 1
  %v539 = add i64 %v537, %v538
  %v540 = getelementptr i64, ptr %s16, i64 0
  %v541 = ptrtoint ptr %v520 to i64
  %st262 = getelementptr i64, ptr %v540, i64 0
  store i64 %v541, ptr %st262
  %st263 = getelementptr i64, ptr %v540, i64 1
  store i64 %v539, ptr %st263
  %st264 = getelementptr i64, ptr %v540, i64 2
  store i64 %v517, ptr %st264
  %v542.p = getelementptr i64, ptr %v540, i64 0
  %v542 = load i64, ptr %v542.p
  %st265 = getelementptr i64, ptr %v293, i64 0
  store i64 %v542, ptr %st265
  %v543.p = getelementptr i64, ptr %v540, i64 1
  %v543 = load i64, ptr %v543.p
  %st266 = getelementptr i64, ptr %v293, i64 1
  store i64 %v543, ptr %st266
  %v544.p = getelementptr i64, ptr %v540, i64 2
  %v544 = load i64, ptr %v544.p
  %st267 = getelementptr i64, ptr %v293, i64 2
  store i64 %v544, ptr %st267
  br label %b89
b93:
  %v531 = add i64 0, 1
  %v532 = mul i64 %v519, %v531
  %v533 = add i64 0, 1
  %v534 = add i64 0, 1
  %v535 = call ptr @"rt.slice_grow"(i64 %v518, i64 %v519, i64 %v533, i64 %v517, i64 %v534)
  %v536 = getelementptr i64, ptr %v535, i64 %v532
  br label %b92
b94:
  %v528 = add i64 0, 1
  %v529 = call ptr @"rt.region_alloc"(i64 %v517, i64 %v528)
  %v530 = inttoptr i64 %v518 to ptr
  br label %b92
b95:
  %v548 = add i64 0, 2
  %v549 = add i64 %v280, %v548
  %v550 = getelementptr i64, ptr %s7, i64 0
  %st268 = getelementptr i64, ptr %v550, i64 0
  store i64 %v549, ptr %st268
  %v551 = add i64 0, 0
  %v552 = getelementptr i64, ptr %s17, i64 0
  %st269 = getelementptr i64, ptr %v552, i64 0
  store i64 %v551, ptr %st269
  %v1427 = getelementptr i64, ptr @"rt.meta", i64 0
  %v553.p = getelementptr i64, ptr %v1427, i64 0
  %v553 = load i64, ptr %v553.p
  br label %b96
b96:
  %v1428 = getelementptr i64, ptr @"rt.meta", i64 0
  %st270 = getelementptr i64, ptr %v1428, i64 0
  store i64 %v553, ptr %st270
  %v554.p = getelementptr i64, ptr %v552, i64 0
  %v554 = load i64, ptr %v554.p
  %v555.c = icmp slt i64 %v554, %v310
  %v555 = zext i1 %v555.c to i64
  %c.b96 = icmp ne i64 %v555, 0
  br i1 %c.b96, label %b96.t272, label %b96.e273
b96.t272:
  br label %b97
b96.e273:
  br label %b98
b97:
  call void @"rt.region_enter"()
  %v1429 = getelementptr i64, ptr @"rt.meta", i64 0
  %v556.p = getelementptr i64, ptr %v1429, i64 0
  %v556 = load i64, ptr %v556.p
  %v557 = add i64 0, 1
  %v558 = add i64 0, 2
  %v559.p = getelementptr i64, ptr %v552, i64 0
  %v559 = load i64, ptr %v559.p
  %v560 = add i64 %v558, %v559
  %v561.p = getelementptr i64, ptr %v306, i64 1
  %v561 = load i64, ptr %v561.p
  %v562.c = icmp uge i64 %v560, %v561
  %v562 = zext i1 %v562.c to i64
  %c.b97 = icmp ne i64 %v562, 0
  br i1 %c.b97, label %b97.t274, label %b97.e275
b97.t274:
  br label %b99
b97.e275:
  br label %b100
b98:
  %v1430 = getelementptr i64, ptr @"rt.meta", i64 0
  %st275 = getelementptr i64, ptr %v1430, i64 0
  store i64 %v553, ptr %st275
  %v576 = add i64 0, 2
  %v577 = add i64 %v576, %v310
  %v578.p = getelementptr i64, ptr %v306, i64 1
  %v578 = load i64, ptr %v578.p
  %v579.c = icmp uge i64 %v577, %v578
  %v579 = zext i1 %v579.c to i64
  %c.b98 = icmp ne i64 %v579, 0
  br i1 %c.b98, label %b98.t277, label %b98.e278
b98.t277:
  br label %b101
b98.e278:
  br label %b102
b99:
  %v563 = add i64 0, 7
  call void @"rt.panic"(i64 %v563)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b100:
  %v564.p = getelementptr i64, ptr %v306, i64 0
  %v564 = load i64, ptr %v564.p
  %v565 = inttoptr i64 %v564 to ptr
  %v566 = add i64 0, 1
  %v567 = mul i64 %v560, %v566
  %v568 = getelementptr i64, ptr %v565, i64 %v567
  %v569.p = getelementptr i64, ptr %v568, i64 0
  %v569 = load i64, ptr %v569.p
  %v570 = add i64 %v557, %v569
  %v571.p = getelementptr i64, ptr %v550, i64 0
  %v571 = load i64, ptr %v571.p
  %v572 = add i64 %v571, %v570
  %st278 = getelementptr i64, ptr %v550, i64 0
  store i64 %v572, ptr %st278
  %v573 = add i64 0, 1
  %v574.p = getelementptr i64, ptr %v552, i64 0
  %v574 = load i64, ptr %v574.p
  %v575 = add i64 %v574, %v573
  %st279 = getelementptr i64, ptr %v552, i64 0
  store i64 %v575, ptr %st279
  br label %b96
b101:
  %v580 = add i64 0, 8
  call void @"rt.panic"(i64 %v580)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b102:
  %v581.p = getelementptr i64, ptr %v306, i64 0
  %v581 = load i64, ptr %v581.p
  %v582 = inttoptr i64 %v581 to ptr
  %v583 = add i64 0, 1
  %v584 = mul i64 %v577, %v583
  %v585 = getelementptr i64, ptr %v582, i64 %v584
  %v586.p = getelementptr i64, ptr %v585, i64 0
  %v586 = load i64, ptr %v586.p
  %v587 = add i64 0, 4
  %v588.p = getelementptr i64, ptr %v550, i64 0
  %v588 = load i64, ptr %v588.p
  %v589 = add i64 0, 0
  %v590.p = getelementptr i64, ptr %v306, i64 0
  %v590 = load i64, ptr %v590.p
  %v591 = call i64 @"rt.lease_op"(i64 %v587, i64 %v590, i64 %v588, i64 %v589)
  %v592 = add i64 0, 1
  %v593 = add i64 0, 32
  %v595 = add i64 0, 0
  %v596.c = icmp slt i64 %v593, %v595
  %v596 = zext i1 %v596.c to i64
  %c.b102 = icmp ne i64 %v596, 0
  br i1 %c.b102, label %b102.t281, label %b102.e282
b102.t281:
  br label %b103
b102.e282:
  br label %b104
b103:
  %v597 = add i64 0, 9
  call void @"rt.panic"(i64 %v597)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b104:
  %v598 = add i64 0, 63
  %v599.c = icmp sgt i64 %v593, %v598
  %v599 = zext i1 %v599.c to i64
  %c.b104 = icmp ne i64 %v599, 0
  br i1 %c.b104, label %b104.t283, label %b104.e284
b104.t283:
  br label %b106
b104.e284:
  br label %b107
b105:
  %v594 = phi i64 [ %v600, %b106 ], [ %v601, %b107 ]
  %v602 = add i64 %v591, %v594
  %v603 = add i64 0, 5
  %v604.p = getelementptr i64, ptr %v550, i64 0
  %v604 = load i64, ptr %v604.p
  %v605.p = getelementptr i64, ptr %v306, i64 0
  %v605 = load i64, ptr %v605.p
  %v606 = call i64 @"rt.lease_op"(i64 %v603, i64 %v605, i64 %v604, i64 %v602)
  %v607.p = getelementptr i64, ptr %v550, i64 0
  %v607 = load i64, ptr %v607.p
  %v608 = add i64 0, 1
  %v609 = add i64 %v607, %v608
  %v610 = getelementptr i64, ptr %s14, i64 0
  %v611.p = getelementptr i64, ptr %v306, i64 0
  %v611 = load i64, ptr %v611.p
  %v612 = add i64 0, 3
  %v613.n = and i64 %v612, 63
  %v613 = shl i64 %v609, %v613.n
  %v614 = add i64 %v611, %v613
  %st284 = getelementptr i64, ptr %v610, i64 0
  store i64 %v614, ptr %st284
  %st285 = getelementptr i64, ptr %v610, i64 1
  store i64 %v586, ptr %st285
  %v615.p = getelementptr i64, ptr %v306, i64 2
  %v615 = load i64, ptr %v615.p
  %st286 = getelementptr i64, ptr %v610, i64 2
  store i64 %v615, ptr %st286
  %v616.p = getelementptr i64, ptr %v610, i64 0
  %v616 = load i64, ptr %v616.p
  %st287 = getelementptr i64, ptr %v293, i64 0
  store i64 %v616, ptr %st287
  %v617.p = getelementptr i64, ptr %v610, i64 1
  %v617 = load i64, ptr %v617.p
  %st288 = getelementptr i64, ptr %v293, i64 1
  store i64 %v617, ptr %st288
  %v618.p = getelementptr i64, ptr %v610, i64 2
  %v618 = load i64, ptr %v618.p
  %st289 = getelementptr i64, ptr %v293, i64 2
  store i64 %v618, ptr %st289
  %v619 = add i64 0, 3
  %v620 = getelementptr i64, ptr %v293, i64 %v619
  %st290 = getelementptr i64, ptr %v620, i64 0
  store i64 %v602, ptr %st290
  %v621 = add i64 0, 4
  %v622 = getelementptr i64, ptr %v293, i64 %v621
  %v623.p = getelementptr i64, ptr %v306, i64 0
  %v623 = load i64, ptr %v623.p
  %st291 = getelementptr i64, ptr %v622, i64 0
  store i64 %v623, ptr %st291
  %v624.p = getelementptr i64, ptr %v306, i64 1
  %v624 = load i64, ptr %v624.p
  %st292 = getelementptr i64, ptr %v622, i64 1
  store i64 %v624, ptr %st292
  %v625.p = getelementptr i64, ptr %v306, i64 2
  %v625 = load i64, ptr %v625.p
  %st293 = getelementptr i64, ptr %v622, i64 2
  store i64 %v625, ptr %st293
  %v626.p = getelementptr i64, ptr %v550, i64 0
  %v626 = load i64, ptr %v626.p
  %v627 = add i64 0, 1
  %v628 = add i64 %v626, %v627
  %v629 = add i64 0, 7
  %v630 = getelementptr i64, ptr %v293, i64 %v629
  %st294 = getelementptr i64, ptr %v630, i64 0
  store i64 %v628, ptr %st294
  %v631 = add i64 0, 0
  %v632.c = icmp eq i64 %v602, %v631
  %v632 = zext i1 %v632.c to i64
  %c.b105 = icmp ne i64 %v632, 0
  br i1 %c.b105, label %b105.t296, label %b105.e297
b105.t296:
  br label %b108
b105.e297:
  br label %b109
b106:
  %v600 = add i64 0, 0
  br label %b105
b107:
  %v601.n = and i64 %v593, 63
  %v601 = shl i64 %v592, %v601.n
  br label %b105
b108:
  %v633 = add i64 0, 0
  %v634 = getelementptr i64, ptr %s8, i64 0
  %st297 = getelementptr i64, ptr %v634, i64 0
  store i64 %v633, ptr %st297
  %v1431 = getelementptr i64, ptr @"rt.meta", i64 0
  %v635.p = getelementptr i64, ptr %v1431, i64 0
  %v635 = load i64, ptr %v635.p
  br label %b110
b109:
  br label %b115
b110:
  %v1432 = getelementptr i64, ptr @"rt.meta", i64 0
  %st298 = getelementptr i64, ptr %v1432, i64 0
  store i64 %v635, ptr %st298
  %v636.p = getelementptr i64, ptr %v634, i64 0
  %v636 = load i64, ptr %v636.p
  %v637.c = icmp slt i64 %v636, %v586
  %v637 = zext i1 %v637.c to i64
  %c.b110 = icmp ne i64 %v637, 0
  br i1 %c.b110, label %b110.t300, label %b110.e301
b110.t300:
  br label %b111
b110.e301:
  br label %b112
b111:
  call void @"rt.region_enter"()
  %v1433 = getelementptr i64, ptr @"rt.meta", i64 0
  %v638.p = getelementptr i64, ptr %v1433, i64 0
  %v638 = load i64, ptr %v638.p
  %v639.p = getelementptr i64, ptr %v634, i64 0
  %v639 = load i64, ptr %v639.p
  %v640 = add i64 0, 0
  %v641.p = getelementptr i64, ptr %v293, i64 1
  %v641 = load i64, ptr %v641.p
  %v642.c = icmp uge i64 %v639, %v641
  %v642 = zext i1 %v642.c to i64
  %c.b111 = icmp ne i64 %v642, 0
  br i1 %c.b111, label %b111.t302, label %b111.e303
b111.t302:
  br label %b113
b111.e303:
  br label %b114
b112:
  %v1434 = getelementptr i64, ptr @"rt.meta", i64 0
  %st303 = getelementptr i64, ptr %v1434, i64 0
  store i64 %v635, ptr %st303
  br label %b115
b113:
  %v643 = add i64 0, 10
  call void @"rt.panic"(i64 %v643)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b114:
  %v644.p = getelementptr i64, ptr %v293, i64 0
  %v644 = load i64, ptr %v644.p
  %v645 = inttoptr i64 %v644 to ptr
  %v646 = add i64 0, 1
  %v647 = mul i64 %v639, %v646
  %v648 = getelementptr i64, ptr %v645, i64 %v647
  %st304 = getelementptr i64, ptr %v648, i64 0
  store i64 %v640, ptr %st304
  %v649 = add i64 0, 1
  %v650.p = getelementptr i64, ptr %v634, i64 0
  %v650 = load i64, ptr %v650.p
  %v651 = add i64 %v650, %v649
  %st305 = getelementptr i64, ptr %v634, i64 0
  store i64 %v651, ptr %st305
  br label %b110
b115:
  br label %b46
b116:
  %v705 = add i64 0, 0
  %v706 = add i64 0, 5
  %v707 = getelementptr i64, ptr %s17, i64 0
  %v1435 = getelementptr i64, ptr @"rt.meta", i64 0
  %v708.p = getelementptr i64, ptr %v1435, i64 0
  %v708 = load i64, ptr %v708.p
  %v709 = add i64 0, 32
  %v711 = add i64 0, 0
  %v712.c = icmp slt i64 %v709, %v711
  %v712 = zext i1 %v712.c to i64
  %c.b116 = icmp ne i64 %v712, 0
  br i1 %c.b116, label %b116.t307, label %b116.e308
b116.t307:
  br label %b134
b116.e308:
  br label %b135
b117:
  %v661 = add i64 0, 11
  call void @"rt.panic"(i64 %v661)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b118:
  %v662 = add i64 0, 63
  %v663.c = icmp sgt i64 %v657, %v662
  %v663 = zext i1 %v663.c to i64
  %c.b118 = icmp ne i64 %v663, 0
  br i1 %c.b118, label %b118.t309, label %b118.e310
b118.t309:
  br label %b120
b118.e310:
  br label %b121
b119:
  %v658 = phi i64 [ %v664, %b120 ], [ %v665, %b121 ]
  %v666 = add i64 0, 3
  %v667 = getelementptr i64, ptr %v293, i64 %v666
  %v668.p = getelementptr i64, ptr %v667, i64 0
  %v668 = load i64, ptr %v668.p
  %v669 = add i64 %v668, %v658
  %st310 = getelementptr i64, ptr %v667, i64 0
  store i64 %v669, ptr %st310
  %v670.p = getelementptr i64, ptr %v293, i64 7
  %v670 = load i64, ptr %v670.p
  %v671 = add i64 0, 0
  %v672.c = icmp sgt i64 %v670, %v671
  %v672 = zext i1 %v672.c to i64
  %c.b119 = icmp ne i64 %v672, 0
  br i1 %c.b119, label %b119.t312, label %b119.e313
b119.t312:
  br label %b122
b119.e313:
  br label %b123
b120:
  %v664 = add i64 0, 0
  br label %b119
b121:
  %v665.n = and i64 %v657, 63
  %v665 = shl i64 %v656, %v665.n
  br label %b119
b122:
  %v673 = add i64 0, 5
  %v674 = add i64 0, 4
  %v675 = getelementptr i64, ptr %v293, i64 %v674
  %v676.p = getelementptr i64, ptr %v293, i64 7
  %v676 = load i64, ptr %v676.p
  %v677 = add i64 0, 1
  %v678 = sub i64 %v676, %v677
  %v679.p = getelementptr i64, ptr %v293, i64 3
  %v679 = load i64, ptr %v679.p
  %v680.p = getelementptr i64, ptr %v675, i64 0
  %v680 = load i64, ptr %v680.p
  %v681 = call i64 @"rt.lease_op"(i64 %v673, i64 %v680, i64 %v678, i64 %v679)
  br label %b124
b123:
  br label %b124
b124:
  %v682.p = getelementptr i64, ptr %v293, i64 3
  %v682 = load i64, ptr %v682.p
  %v683 = add i64 0, 0
  %v684.c = icmp eq i64 %v682, %v683
  %v684 = zext i1 %v684.c to i64
  %c.b124 = icmp ne i64 %v684, 0
  br i1 %c.b124, label %b124.t314, label %b124.e315
b124.t314:
  br label %b125
b124.e315:
  br label %b126
b125:
  %v685 = add i64 0, 0
  %v686 = getelementptr i64, ptr %s7, i64 0
  %st315 = getelementptr i64, ptr %v686, i64 0
  store i64 %v685, ptr %st315
  %v1436 = getelementptr i64, ptr @"rt.meta", i64 0
  %v687.p = getelementptr i64, ptr %v1436, i64 0
  %v687 = load i64, ptr %v687.p
  br label %b127
b126:
  br label %b132
b127:
  %v1437 = getelementptr i64, ptr @"rt.meta", i64 0
  %st316 = getelementptr i64, ptr %v1437, i64 0
  store i64 %v687, ptr %st316
  %v688.p = getelementptr i64, ptr %v686, i64 0
  %v688 = load i64, ptr %v688.p
  %v689.p = getelementptr i64, ptr %v293, i64 1
  %v689 = load i64, ptr %v689.p
  %v690.c = icmp slt i64 %v688, %v689
  %v690 = zext i1 %v690.c to i64
  %c.b127 = icmp ne i64 %v690, 0
  br i1 %c.b127, label %b127.t318, label %b127.e319
b127.t318:
  br label %b128
b127.e319:
  br label %b129
b128:
  call void @"rt.region_enter"()
  %v1438 = getelementptr i64, ptr @"rt.meta", i64 0
  %v691.p = getelementptr i64, ptr %v1438, i64 0
  %v691 = load i64, ptr %v691.p
  %v692.p = getelementptr i64, ptr %v686, i64 0
  %v692 = load i64, ptr %v692.p
  %v693 = add i64 0, 0
  %v694.p = getelementptr i64, ptr %v293, i64 1
  %v694 = load i64, ptr %v694.p
  %v695.c = icmp uge i64 %v692, %v694
  %v695 = zext i1 %v695.c to i64
  %c.b128 = icmp ne i64 %v695, 0
  br i1 %c.b128, label %b128.t320, label %b128.e321
b128.t320:
  br label %b130
b128.e321:
  br label %b131
b129:
  %v1439 = getelementptr i64, ptr @"rt.meta", i64 0
  %st321 = getelementptr i64, ptr %v1439, i64 0
  store i64 %v687, ptr %st321
  br label %b132
b130:
  %v696 = add i64 0, 12
  call void @"rt.panic"(i64 %v696)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b131:
  %v697.p = getelementptr i64, ptr %v293, i64 0
  %v697 = load i64, ptr %v697.p
  %v698 = inttoptr i64 %v697 to ptr
  %v699 = add i64 0, 1
  %v700 = mul i64 %v692, %v699
  %v701 = getelementptr i64, ptr %v698, i64 %v700
  %st322 = getelementptr i64, ptr %v701, i64 0
  store i64 %v693, ptr %st322
  %v702 = add i64 0, 1
  %v703.p = getelementptr i64, ptr %v686, i64 0
  %v703 = load i64, ptr %v703.p
  %v704 = add i64 %v703, %v702
  %st323 = getelementptr i64, ptr %v686, i64 0
  store i64 %v704, ptr %st323
  br label %b127
b132:
  br label %b116
b133:
  %v731 = getelementptr i64, ptr %s17, i64 0
  %v1440 = getelementptr i64, ptr @"rt.meta", i64 0
  %v732.p = getelementptr i64, ptr %v1440, i64 0
  %v732 = load i64, ptr %v732.p
  %v733 = add i64 0, 1
  %v734 = add i64 0, 32
  %v736 = add i64 0, 0
  %v737.c = icmp slt i64 %v734, %v736
  %v737 = zext i1 %v737.c to i64
  %c.b133 = icmp ne i64 %v737, 0
  br i1 %c.b133, label %b133.t325, label %b133.e326
b133.t325:
  br label %b145
b133.e326:
  br label %b146
b134:
  %v713 = add i64 0, 13
  call void @"rt.panic"(i64 %v713)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b135:
  %v714 = add i64 0, 63
  %v715.c = icmp sgt i64 %v709, %v714
  %v715 = zext i1 %v715.c to i64
  %c.b135 = icmp ne i64 %v715, 0
  br i1 %c.b135, label %b135.t327, label %b135.e328
b135.t327:
  br label %b137
b135.e328:
  br label %b138
b136:
  %v710 = phi i64 [ %v717, %b137 ], [ %v718, %b138 ]
  %v719 = add i64 0, 0
  %v720.c = icmp ne i64 %v710, %v719
  %v720 = zext i1 %v720.c to i64
  %c.b136 = icmp ne i64 %v720, 0
  br i1 %c.b136, label %b136.t329, label %b136.e330
b136.t329:
  br label %b139
b136.e330:
  br label %b140
b137:
  %v716 = add i64 0, 63
  %v717.n = and i64 %v716, 63
  %v717 = ashr i64 %v706, %v717.n
  br label %b136
b138:
  %v718.n = and i64 %v709, 63
  %v718 = ashr i64 %v706, %v718.n
  br label %b136
b139:
  call void @"std/pool.badScratch"(i64 %v706)
  br label %b141
b140:
  br label %b141
b141:
  %v721.p = getelementptr i64, ptr %v293, i64 3
  %v721 = load i64, ptr %v721.p
  %v722 = or i64 %v721, %v706
  %v723.p = getelementptr i64, ptr %v293, i64 1
  %v723 = load i64, ptr %v723.p
  %v724.c = icmp uge i64 %v705, %v723
  %v724 = zext i1 %v724.c to i64
  %c.b141 = icmp ne i64 %v724, 0
  br i1 %c.b141, label %b141.t331, label %b141.e332
b141.t331:
  br label %b142
b141.e332:
  br label %b143
b142:
  %v725 = add i64 0, 14
  call void @"rt.panic"(i64 %v725)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b143:
  %v726.p = getelementptr i64, ptr %v293, i64 0
  %v726 = load i64, ptr %v726.p
  %v727 = inttoptr i64 %v726 to ptr
  %v728 = add i64 0, 1
  %v729 = mul i64 %v705, %v728
  %v730 = getelementptr i64, ptr %v727, i64 %v729
  %st332 = getelementptr i64, ptr %v730, i64 0
  store i64 %v722, ptr %st332
  br label %b133
b144:
  %v782 = add i64 0, 1
  %v783 = add i64 0, 6
  %v784 = getelementptr i64, ptr %s17, i64 0
  %v1441 = getelementptr i64, ptr @"rt.meta", i64 0
  %v785.p = getelementptr i64, ptr %v1441, i64 0
  %v785 = load i64, ptr %v785.p
  %v786 = add i64 0, 32
  %v788 = add i64 0, 0
  %v789.c = icmp slt i64 %v786, %v788
  %v789 = zext i1 %v789.c to i64
  %c.b144 = icmp ne i64 %v789, 0
  br i1 %c.b144, label %b144.t334, label %b144.e335
b144.t334:
  br label %b162
b144.e335:
  br label %b163
b145:
  %v738 = add i64 0, 15
  call void @"rt.panic"(i64 %v738)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b146:
  %v739 = add i64 0, 63
  %v740.c = icmp sgt i64 %v734, %v739
  %v740 = zext i1 %v740.c to i64
  %c.b146 = icmp ne i64 %v740, 0
  br i1 %c.b146, label %b146.t336, label %b146.e337
b146.t336:
  br label %b148
b146.e337:
  br label %b149
b147:
  %v735 = phi i64 [ %v741, %b148 ], [ %v742, %b149 ]
  %v743 = add i64 0, 3
  %v744 = getelementptr i64, ptr %v293, i64 %v743
  %v745.p = getelementptr i64, ptr %v744, i64 0
  %v745 = load i64, ptr %v745.p
  %v746 = add i64 %v745, %v735
  %st337 = getelementptr i64, ptr %v744, i64 0
  store i64 %v746, ptr %st337
  %v747.p = getelementptr i64, ptr %v293, i64 7
  %v747 = load i64, ptr %v747.p
  %v748 = add i64 0, 0
  %v749.c = icmp sgt i64 %v747, %v748
  %v749 = zext i1 %v749.c to i64
  %c.b147 = icmp ne i64 %v749, 0
  br i1 %c.b147, label %b147.t339, label %b147.e340
b147.t339:
  br label %b150
b147.e340:
  br label %b151
b148:
  %v741 = add i64 0, 0
  br label %b147
b149:
  %v742.n = and i64 %v734, 63
  %v742 = shl i64 %v733, %v742.n
  br label %b147
b150:
  %v750 = add i64 0, 5
  %v751 = add i64 0, 4
  %v752 = getelementptr i64, ptr %v293, i64 %v751
  %v753.p = getelementptr i64, ptr %v293, i64 7
  %v753 = load i64, ptr %v753.p
  %v754 = add i64 0, 1
  %v755 = sub i64 %v753, %v754
  %v756.p = getelementptr i64, ptr %v293, i64 3
  %v756 = load i64, ptr %v756.p
  %v757.p = getelementptr i64, ptr %v752, i64 0
  %v757 = load i64, ptr %v757.p
  %v758 = call i64 @"rt.lease_op"(i64 %v750, i64 %v757, i64 %v755, i64 %v756)
  br label %b152
b151:
  br label %b152
b152:
  %v759.p = getelementptr i64, ptr %v293, i64 3
  %v759 = load i64, ptr %v759.p
  %v760 = add i64 0, 0
  %v761.c = icmp eq i64 %v759, %v760
  %v761 = zext i1 %v761.c to i64
  %c.b152 = icmp ne i64 %v761, 0
  br i1 %c.b152, label %b152.t341, label %b152.e342
b152.t341:
  br label %b153
b152.e342:
  br label %b154
b153:
  %v762 = add i64 0, 0
  %v763 = getelementptr i64, ptr %s7, i64 0
  %st342 = getelementptr i64, ptr %v763, i64 0
  store i64 %v762, ptr %st342
  %v1442 = getelementptr i64, ptr @"rt.meta", i64 0
  %v764.p = getelementptr i64, ptr %v1442, i64 0
  %v764 = load i64, ptr %v764.p
  br label %b155
b154:
  br label %b160
b155:
  %v1443 = getelementptr i64, ptr @"rt.meta", i64 0
  %st343 = getelementptr i64, ptr %v1443, i64 0
  store i64 %v764, ptr %st343
  %v765.p = getelementptr i64, ptr %v763, i64 0
  %v765 = load i64, ptr %v765.p
  %v766.p = getelementptr i64, ptr %v293, i64 1
  %v766 = load i64, ptr %v766.p
  %v767.c = icmp slt i64 %v765, %v766
  %v767 = zext i1 %v767.c to i64
  %c.b155 = icmp ne i64 %v767, 0
  br i1 %c.b155, label %b155.t345, label %b155.e346
b155.t345:
  br label %b156
b155.e346:
  br label %b157
b156:
  call void @"rt.region_enter"()
  %v1444 = getelementptr i64, ptr @"rt.meta", i64 0
  %v768.p = getelementptr i64, ptr %v1444, i64 0
  %v768 = load i64, ptr %v768.p
  %v769.p = getelementptr i64, ptr %v763, i64 0
  %v769 = load i64, ptr %v769.p
  %v770 = add i64 0, 0
  %v771.p = getelementptr i64, ptr %v293, i64 1
  %v771 = load i64, ptr %v771.p
  %v772.c = icmp uge i64 %v769, %v771
  %v772 = zext i1 %v772.c to i64
  %c.b156 = icmp ne i64 %v772, 0
  br i1 %c.b156, label %b156.t347, label %b156.e348
b156.t347:
  br label %b158
b156.e348:
  br label %b159
b157:
  %v1445 = getelementptr i64, ptr @"rt.meta", i64 0
  %st348 = getelementptr i64, ptr %v1445, i64 0
  store i64 %v764, ptr %st348
  br label %b160
b158:
  %v773 = add i64 0, 16
  call void @"rt.panic"(i64 %v773)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b159:
  %v774.p = getelementptr i64, ptr %v293, i64 0
  %v774 = load i64, ptr %v774.p
  %v775 = inttoptr i64 %v774 to ptr
  %v776 = add i64 0, 1
  %v777 = mul i64 %v769, %v776
  %v778 = getelementptr i64, ptr %v775, i64 %v777
  %st349 = getelementptr i64, ptr %v778, i64 0
  store i64 %v770, ptr %st349
  %v779 = add i64 0, 1
  %v780.p = getelementptr i64, ptr %v763, i64 0
  %v780 = load i64, ptr %v780.p
  %v781 = add i64 %v780, %v779
  %st350 = getelementptr i64, ptr %v763, i64 0
  store i64 %v781, ptr %st350
  br label %b155
b160:
  br label %b144
b161:
  %v808 = add i64 0, 0
  %v809 = getelementptr i64, ptr %s17, i64 0
  %v1446 = getelementptr i64, ptr @"rt.meta", i64 0
  %v810.p = getelementptr i64, ptr %v1446, i64 0
  %v810 = load i64, ptr %v810.p
  %v811.p = getelementptr i64, ptr %v293, i64 1
  %v811 = load i64, ptr %v811.p
  %v812.c = icmp uge i64 %v808, %v811
  %v812 = zext i1 %v812.c to i64
  %c.b161 = icmp ne i64 %v812, 0
  br i1 %c.b161, label %b161.t352, label %b161.e353
b161.t352:
  br label %b173
b161.e353:
  br label %b174
b162:
  %v790 = add i64 0, 17
  call void @"rt.panic"(i64 %v790)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b163:
  %v791 = add i64 0, 63
  %v792.c = icmp sgt i64 %v786, %v791
  %v792 = zext i1 %v792.c to i64
  %c.b163 = icmp ne i64 %v792, 0
  br i1 %c.b163, label %b163.t354, label %b163.e355
b163.t354:
  br label %b165
b163.e355:
  br label %b166
b164:
  %v787 = phi i64 [ %v794, %b165 ], [ %v795, %b166 ]
  %v796 = add i64 0, 0
  %v797.c = icmp ne i64 %v787, %v796
  %v797 = zext i1 %v797.c to i64
  %c.b164 = icmp ne i64 %v797, 0
  br i1 %c.b164, label %b164.t356, label %b164.e357
b164.t356:
  br label %b167
b164.e357:
  br label %b168
b165:
  %v793 = add i64 0, 63
  %v794.n = and i64 %v793, 63
  %v794 = ashr i64 %v783, %v794.n
  br label %b164
b166:
  %v795.n = and i64 %v786, 63
  %v795 = ashr i64 %v783, %v795.n
  br label %b164
b167:
  call void @"std/pool.badScratch"(i64 %v783)
  br label %b169
b168:
  br label %b169
b169:
  %v798.p = getelementptr i64, ptr %v293, i64 3
  %v798 = load i64, ptr %v798.p
  %v799 = or i64 %v798, %v783
  %v800.p = getelementptr i64, ptr %v293, i64 1
  %v800 = load i64, ptr %v800.p
  %v801.c = icmp uge i64 %v782, %v800
  %v801 = zext i1 %v801.c to i64
  %c.b169 = icmp ne i64 %v801, 0
  br i1 %c.b169, label %b169.t358, label %b169.e359
b169.t358:
  br label %b170
b169.e359:
  br label %b171
b170:
  %v802 = add i64 0, 18
  call void @"rt.panic"(i64 %v802)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b171:
  %v803.p = getelementptr i64, ptr %v293, i64 0
  %v803 = load i64, ptr %v803.p
  %v804 = inttoptr i64 %v803 to ptr
  %v805 = add i64 0, 1
  %v806 = mul i64 %v782, %v805
  %v807 = getelementptr i64, ptr %v804, i64 %v806
  %st359 = getelementptr i64, ptr %v807, i64 0
  store i64 %v799, ptr %st359
  br label %b161
b172:
  %v836.p = getelementptr i64, ptr %v809, i64 0
  %v836 = load i64, ptr %v836.p
  %v837 = add i64 0, 10
  %v838 = mul i64 %v836, %v837
  %v839 = add i64 0, 1
  %v840 = getelementptr i64, ptr %s7, i64 0
  %v1447 = getelementptr i64, ptr @"rt.meta", i64 0
  %v841.p = getelementptr i64, ptr %v1447, i64 0
  %v841 = load i64, ptr %v841.p
  %v842.p = getelementptr i64, ptr %v293, i64 1
  %v842 = load i64, ptr %v842.p
  %v843.c = icmp uge i64 %v839, %v842
  %v843 = zext i1 %v843.c to i64
  %c.b172 = icmp ne i64 %v843, 0
  br i1 %c.b172, label %b172.t361, label %b172.e362
b172.t361:
  br label %b184
b172.e362:
  br label %b185
b173:
  %v813 = add i64 0, 19
  call void @"rt.panic"(i64 %v813)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b174:
  %v814.p = getelementptr i64, ptr %v293, i64 0
  %v814 = load i64, ptr %v814.p
  %v815 = inttoptr i64 %v814 to ptr
  %v816 = add i64 0, 1
  %v817 = mul i64 %v808, %v816
  %v818 = getelementptr i64, ptr %v815, i64 %v817
  %v819.p = getelementptr i64, ptr %v818, i64 0
  %v819 = load i64, ptr %v819.p
  %v820.p = getelementptr i64, ptr %v293, i64 3
  %v820 = load i64, ptr %v820.p
  %v821 = xor i64 %v819, %v820
  %v822 = add i64 0, 32
  %v824 = add i64 0, 0
  %v825.c = icmp slt i64 %v822, %v824
  %v825 = zext i1 %v825.c to i64
  %c.b174 = icmp ne i64 %v825, 0
  br i1 %c.b174, label %b174.t363, label %b174.e364
b174.t363:
  br label %b175
b174.e364:
  br label %b176
b175:
  %v826 = add i64 0, 20
  call void @"rt.panic"(i64 %v826)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b176:
  %v827 = add i64 0, 63
  %v828.c = icmp sgt i64 %v822, %v827
  %v828 = zext i1 %v828.c to i64
  %c.b176 = icmp ne i64 %v828, 0
  br i1 %c.b176, label %b176.t365, label %b176.e366
b176.t365:
  br label %b178
b176.e366:
  br label %b179
b177:
  %v823 = phi i64 [ %v830, %b178 ], [ %v831, %b179 ]
  %v832 = add i64 0, 0
  %v833.c = icmp eq i64 %v823, %v832
  %v833 = zext i1 %v833.c to i64
  %c.b177 = icmp ne i64 %v833, 0
  br i1 %c.b177, label %b177.t367, label %b177.e368
b177.t367:
  br label %b180
b177.e368:
  br label %b181
b178:
  %v829 = add i64 0, 63
  %v830.n = and i64 %v829, 63
  %v830 = ashr i64 %v821, %v830.n
  br label %b177
b179:
  %v831.n = and i64 %v822, 63
  %v831 = ashr i64 %v821, %v831.n
  br label %b177
b180:
  br label %b182
b181:
  %v834 = add i64 0, 0
  br label %b182
b182:
  %v835 = phi i64 [ %v821, %b180 ], [ %v834, %b181 ]
  %st368 = getelementptr i64, ptr %v809, i64 0
  store i64 %v835, ptr %st368
  %v1448 = getelementptr i64, ptr @"rt.meta", i64 0
  %st369 = getelementptr i64, ptr %v1448, i64 0
  store i64 %v810, ptr %st369
  br label %b172
b183:
  %v867.p = getelementptr i64, ptr %v840, i64 0
  %v867 = load i64, ptr %v867.p
  %v868 = add i64 %v838, %v867
  %v1449 = getelementptr i64, ptr @"rt.meta", i64 0
  %st370 = getelementptr i64, ptr %v1449, i64 0
  store i64 %v652, ptr %st370
  %v869.p = getelementptr i64, ptr %v272, i64 0
  %v869 = load i64, ptr %v869.p
  %v870.p = getelementptr i64, ptr %v272, i64 1
  %v870 = load i64, ptr %v870.p
  %v871.p = getelementptr i64, ptr %v272, i64 2
  %v871 = load i64, ptr %v871.p
  call void @"std/task.LeaseGive"(i64 %v869, i64 %v870, i64 %v871, i64 %v280)
  %v1450 = getelementptr i64, ptr @"rt.meta", i64 0
  %st371 = getelementptr i64, ptr %v1450, i64 0
  store i64 %v270, ptr %st371
  %v1451 = getelementptr i64, ptr @"rt.meta", i64 0
  %v872.p = getelementptr i64, ptr %v1451, i64 0
  %v872 = load i64, ptr %v872.p
  call void @"rt.region_enter"()
  %v1452 = getelementptr i64, ptr @"rt.meta", i64 0
  %v873.p = getelementptr i64, ptr %v1452, i64 0
  %v873 = load i64, ptr %v873.p
  %v874 = getelementptr i64, ptr %s4, i64 0
  %v875.p = getelementptr i64, ptr %v266, i64 0
  %v875 = load i64, ptr %v875.p
  %st372 = getelementptr i64, ptr %v874, i64 0
  store i64 %v875, ptr %st372
  %v876.p = getelementptr i64, ptr %v266, i64 1
  %v876 = load i64, ptr %v876.p
  %st373 = getelementptr i64, ptr %v874, i64 1
  store i64 %v876, ptr %st373
  %v877.p = getelementptr i64, ptr %v266, i64 2
  %v877 = load i64, ptr %v877.p
  %st374 = getelementptr i64, ptr %v874, i64 2
  store i64 %v877, ptr %st374
  %v878.p = getelementptr i64, ptr %v874, i64 0
  %v878 = load i64, ptr %v878.p
  %v879.p = getelementptr i64, ptr %v874, i64 1
  %v879 = load i64, ptr %v879.p
  %v880.p = getelementptr i64, ptr %v874, i64 2
  %v880 = load i64, ptr %v880.p
  %v881 = add i64 0, 1196654069739148631
  %v882 = call i64 @"std/task.LeaseTake"(i64 %v878, i64 %v879, i64 %v880, i64 %v881)
  %v883 = getelementptr i64, ptr %s0, i64 0
  %v884 = add i64 0, 0
  %st375 = getelementptr i64, ptr %v883, i64 0
  store i64 %v884, ptr %st375
  %st376 = getelementptr i64, ptr %v883, i64 1
  store i64 %v884, ptr %st376
  %st377 = getelementptr i64, ptr %v883, i64 2
  store i64 %v884, ptr %st377
  %st378 = getelementptr i64, ptr %v883, i64 3
  store i64 %v884, ptr %st378
  %st379 = getelementptr i64, ptr %v883, i64 4
  store i64 %v884, ptr %st379
  %st380 = getelementptr i64, ptr %v883, i64 5
  store i64 %v884, ptr %st380
  %st381 = getelementptr i64, ptr %v883, i64 6
  store i64 %v884, ptr %st381
  %st382 = getelementptr i64, ptr %v883, i64 7
  store i64 %v884, ptr %st382
  %v1453 = getelementptr i64, ptr @"rt.meta", i64 0
  %v885.p = getelementptr i64, ptr %v1453, i64 0
  %v885 = load i64, ptr %v885.p
  %v1454 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1455 = getelementptr i64, ptr %v1454, i64 %v885
  %v886.p = getelementptr i64, ptr %v1455, i64 1
  %v886 = load ptr, ptr %v886.p
  %v887 = ptrtoint ptr %v886 to i64
  %st383 = getelementptr i64, ptr %v883, i64 0
  store i64 %v887, ptr %st383
  %v888 = add i64 0, 0
  %st384 = getelementptr i64, ptr %v883, i64 1
  store i64 %v888, ptr %st384
  %st385 = getelementptr i64, ptr %v883, i64 2
  store i64 %v885, ptr %st385
  %v889 = add i64 0, 4
  %v890 = getelementptr i64, ptr %v883, i64 %v889
  %v1456 = getelementptr i64, ptr @"rt.meta", i64 0
  %v891.p = getelementptr i64, ptr %v1456, i64 0
  %v891 = load i64, ptr %v891.p
  %v1457 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1458 = getelementptr i64, ptr %v1457, i64 %v891
  %v892.p = getelementptr i64, ptr %v1458, i64 1
  %v892 = load ptr, ptr %v892.p
  %v893 = ptrtoint ptr %v892 to i64
  %st386 = getelementptr i64, ptr %v890, i64 0
  store i64 %v893, ptr %st386
  %v894 = add i64 0, 0
  %st387 = getelementptr i64, ptr %v890, i64 1
  store i64 %v894, ptr %st387
  %st388 = getelementptr i64, ptr %v890, i64 2
  store i64 %v891, ptr %st388
  %v895 = getelementptr i64, ptr %s1, i64 0
  %v896.p = getelementptr i64, ptr %v883, i64 0
  %v896 = load i64, ptr %v896.p
  %st389 = getelementptr i64, ptr %v895, i64 0
  store i64 %v896, ptr %st389
  %v897.p = getelementptr i64, ptr %v883, i64 1
  %v897 = load i64, ptr %v897.p
  %st390 = getelementptr i64, ptr %v895, i64 1
  store i64 %v897, ptr %st390
  %v898.p = getelementptr i64, ptr %v883, i64 2
  %v898 = load i64, ptr %v898.p
  %st391 = getelementptr i64, ptr %v895, i64 2
  store i64 %v898, ptr %st391
  %v899.p = getelementptr i64, ptr %v883, i64 3
  %v899 = load i64, ptr %v899.p
  %st392 = getelementptr i64, ptr %v895, i64 3
  store i64 %v899, ptr %st392
  %v900.p = getelementptr i64, ptr %v883, i64 4
  %v900 = load i64, ptr %v900.p
  %st393 = getelementptr i64, ptr %v895, i64 4
  store i64 %v900, ptr %st393
  %v901.p = getelementptr i64, ptr %v883, i64 5
  %v901 = load i64, ptr %v901.p
  %st394 = getelementptr i64, ptr %v895, i64 5
  store i64 %v901, ptr %st394
  %v902.p = getelementptr i64, ptr %v883, i64 6
  %v902 = load i64, ptr %v902.p
  %st395 = getelementptr i64, ptr %v895, i64 6
  store i64 %v902, ptr %st395
  %v903.p = getelementptr i64, ptr %v883, i64 7
  %v903 = load i64, ptr %v903.p
  %st396 = getelementptr i64, ptr %v895, i64 7
  store i64 %v903, ptr %st396
  %v904 = getelementptr i64, ptr %s19, i64 0
  %v905.p = getelementptr i64, ptr %v874, i64 0
  %v905 = load i64, ptr %v905.p
  %v906.p = getelementptr i64, ptr %v874, i64 1
  %v906 = load i64, ptr %v906.p
  %v907.p = getelementptr i64, ptr %v874, i64 2
  %v907 = load i64, ptr %v907.p
  call void @"std/task.LeaseBlock"(ptr %v904, i64 %v905, i64 %v906, i64 %v907)
  %v908 = getelementptr i64, ptr %s3, i64 0
  %v909.p = getelementptr i64, ptr %v904, i64 0
  %v909 = load i64, ptr %v909.p
  %st397 = getelementptr i64, ptr %v908, i64 0
  store i64 %v909, ptr %st397
  %v910.p = getelementptr i64, ptr %v904, i64 1
  %v910 = load i64, ptr %v910.p
  %st398 = getelementptr i64, ptr %v908, i64 1
  store i64 %v910, ptr %st398
  %v911.p = getelementptr i64, ptr %v904, i64 2
  %v911 = load i64, ptr %v911.p
  %st399 = getelementptr i64, ptr %v908, i64 2
  store i64 %v911, ptr %st399
  %v912 = add i64 0, 0
  %v913 = getelementptr i64, ptr %s9, i64 0
  %v1459 = getelementptr i64, ptr @"rt.meta", i64 0
  %v914.p = getelementptr i64, ptr %v1459, i64 0
  %v914 = load i64, ptr %v914.p
  %v915 = add i64 0, 0
  %v916.c = icmp slt i64 %v882, %v915
  %v916 = zext i1 %v916.c to i64
  %c.b183 = icmp ne i64 %v916, 0
  br i1 %c.b183, label %b183.t401, label %b183.e402
b183.t401:
  br label %b195
b183.e402:
  br label %b196
b184:
  %v844 = add i64 0, 21
  call void @"rt.panic"(i64 %v844)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b185:
  %v845.p = getelementptr i64, ptr %v293, i64 0
  %v845 = load i64, ptr %v845.p
  %v846 = inttoptr i64 %v845 to ptr
  %v847 = add i64 0, 1
  %v848 = mul i64 %v839, %v847
  %v849 = getelementptr i64, ptr %v846, i64 %v848
  %v850.p = getelementptr i64, ptr %v849, i64 0
  %v850 = load i64, ptr %v850.p
  %v851.p = getelementptr i64, ptr %v293, i64 3
  %v851 = load i64, ptr %v851.p
  %v852 = xor i64 %v850, %v851
  %v853 = add i64 0, 32
  %v855 = add i64 0, 0
  %v856.c = icmp slt i64 %v853, %v855
  %v856 = zext i1 %v856.c to i64
  %c.b185 = icmp ne i64 %v856, 0
  br i1 %c.b185, label %b185.t403, label %b185.e404
b185.t403:
  br label %b186
b185.e404:
  br label %b187
b186:
  %v857 = add i64 0, 22
  call void @"rt.panic"(i64 %v857)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b187:
  %v858 = add i64 0, 63
  %v859.c = icmp sgt i64 %v853, %v858
  %v859 = zext i1 %v859.c to i64
  %c.b187 = icmp ne i64 %v859, 0
  br i1 %c.b187, label %b187.t405, label %b187.e406
b187.t405:
  br label %b189
b187.e406:
  br label %b190
b188:
  %v854 = phi i64 [ %v861, %b189 ], [ %v862, %b190 ]
  %v863 = add i64 0, 0
  %v864.c = icmp eq i64 %v854, %v863
  %v864 = zext i1 %v864.c to i64
  %c.b188 = icmp ne i64 %v864, 0
  br i1 %c.b188, label %b188.t407, label %b188.e408
b188.t407:
  br label %b191
b188.e408:
  br label %b192
b189:
  %v860 = add i64 0, 63
  %v861.n = and i64 %v860, 63
  %v861 = ashr i64 %v852, %v861.n
  br label %b188
b190:
  %v862.n = and i64 %v853, 63
  %v862 = ashr i64 %v852, %v862.n
  br label %b188
b191:
  br label %b193
b192:
  %v865 = add i64 0, 0
  br label %b193
b193:
  %v866 = phi i64 [ %v852, %b191 ], [ %v865, %b192 ]
  %st408 = getelementptr i64, ptr %v840, i64 0
  store i64 %v866, ptr %st408
  %v1460 = getelementptr i64, ptr @"rt.meta", i64 0
  %st409 = getelementptr i64, ptr %v1460, i64 0
  store i64 %v841, ptr %st409
  br label %b183
b194:
  %v1254 = add i64 0, 0
  %v1255 = getelementptr i64, ptr %s20, i64 0
  %v1461 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1256.p = getelementptr i64, ptr %v1461, i64 0
  %v1256 = load i64, ptr %v1256.p
  %v1257.p = getelementptr i64, ptr %v895, i64 1
  %v1257 = load i64, ptr %v1257.p
  %v1258.c = icmp uge i64 %v1254, %v1257
  %v1258 = zext i1 %v1258.c to i64
  %c.b194 = icmp ne i64 %v1258, 0
  br i1 %c.b194, label %b194.t411, label %b194.e412
b194.t411:
  br label %b265
b194.e412:
  br label %b266
b195:
  %v917 = add i64 0, 2
  %v918 = add i64 %v917, %v912
  %v919.p = getelementptr i64, ptr %v908, i64 1
  %v919 = load i64, ptr %v919.p
  %v920.c = icmp uge i64 %v918, %v919
  %v920 = zext i1 %v920.c to i64
  %c.b195 = icmp ne i64 %v920, 0
  br i1 %c.b195, label %b195.t413, label %b195.e414
b195.t413:
  br label %b197
b195.e414:
  br label %b198
b196:
  br label %b243
b197:
  %v921 = add i64 0, 23
  call void @"rt.panic"(i64 %v921)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b198:
  %v922.p = getelementptr i64, ptr %v908, i64 0
  %v922 = load i64, ptr %v922.p
  %v923 = inttoptr i64 %v922 to ptr
  %v924 = add i64 0, 1
  %v925 = mul i64 %v918, %v924
  %v926 = getelementptr i64, ptr %v923, i64 %v925
  %v927.p = getelementptr i64, ptr %v926, i64 0
  %v927 = load i64, ptr %v927.p
  %v928 = getelementptr i64, ptr %s8, i64 0
  %v1462 = getelementptr i64, ptr @"rt.meta", i64 0
  %v929.p = getelementptr i64, ptr %v1462, i64 0
  %v929 = load i64, ptr %v929.p
  %v930.p = getelementptr i64, ptr %v895, i64 1
  %v930 = load i64, ptr %v930.p
  %v931 = add i64 0, 0
  %v932.c = icmp sgt i64 %v930, %v931
  %v932 = zext i1 %v932.c to i64
  %c.b198 = icmp ne i64 %v932, 0
  br i1 %c.b198, label %b198.t415, label %b198.e416
b198.t415:
  br label %b200
b198.e416:
  br label %b201
b199:
  %v1463 = getelementptr i64, ptr @"rt.meta", i64 0
  %st416 = getelementptr i64, ptr %v1463, i64 0
  store i64 %v914, ptr %st416
  br label %b194
b200:
  %v933 = getelementptr i64, ptr @"rt.meta", i64 0
  call void @"rt.flush"()
  %v934 = add i64 0, 2
  %st417 = getelementptr i64, ptr %v933, i64 1026
  store i64 %v934, ptr %st417
  %v935 = getelementptr i64, ptr @"str.0", i64 0
  %v936 = add i64 0, 7
  %v937 = add i64 0, 0
  %v938 = getelementptr i64, ptr %s14, i64 0
  %v939 = ptrtoint ptr %v935 to i64
  %st418 = getelementptr i64, ptr %v938, i64 0
  store i64 %v939, ptr %st418
  %st419 = getelementptr i64, ptr %v938, i64 1
  store i64 %v936, ptr %st419
  %st420 = getelementptr i64, ptr %v938, i64 2
  store i64 %v937, ptr %st420
  call void @"rt.print_str"(ptr %v938)
  %v940 = getelementptr i64, ptr @"str.1", i64 0
  %v941 = add i64 0, 17
  %v942 = add i64 0, 0
  %v943 = getelementptr i64, ptr %s15, i64 0
  %v944 = ptrtoint ptr %v940 to i64
  %st421 = getelementptr i64, ptr %v943, i64 0
  store i64 %v944, ptr %st421
  %st422 = getelementptr i64, ptr %v943, i64 1
  store i64 %v941, ptr %st422
  %st423 = getelementptr i64, ptr %v943, i64 2
  store i64 %v942, ptr %st423
  call void @"rt.print_str"(ptr %v943)
  %v945 = getelementptr i64, ptr @"str.2", i64 0
  %v946 = add i64 0, 1
  %v947 = add i64 0, 0
  %v948 = getelementptr i64, ptr %s16, i64 0
  %v949 = ptrtoint ptr %v945 to i64
  %st424 = getelementptr i64, ptr %v948, i64 0
  store i64 %v949, ptr %st424
  %st425 = getelementptr i64, ptr %v948, i64 1
  store i64 %v946, ptr %st425
  %st426 = getelementptr i64, ptr %v948, i64 2
  store i64 %v947, ptr %st426
  call void @"rt.print_str"(ptr %v948)
  %v950 = getelementptr i64, ptr @"str.3", i64 0
  %v951 = add i64 0, 1
  %v952 = add i64 0, 0
  %v953 = getelementptr i64, ptr %s13, i64 0
  %v954 = ptrtoint ptr %v950 to i64
  %st427 = getelementptr i64, ptr %v953, i64 0
  store i64 %v954, ptr %st427
  %st428 = getelementptr i64, ptr %v953, i64 1
  store i64 %v951, ptr %st428
  %st429 = getelementptr i64, ptr %v953, i64 2
  store i64 %v952, ptr %st429
  call void @"rt.print_str"(ptr %v953)
  %v955 = add i64 0, 24
  call void @"rt.panic"(i64 %v955)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b201:
  br label %b202
b202:
  %v956 = add i64 0, 0
  %v957 = add i64 0, 3
  %v958 = getelementptr i64, ptr %v895, i64 %v957
  %st430 = getelementptr i64, ptr %v958, i64 0
  store i64 %v956, ptr %st430
  %v959 = getelementptr i64, ptr %s10, i64 0
  %v1464 = getelementptr i64, ptr @"rt.meta", i64 0
  %v960.p = getelementptr i64, ptr %v1464, i64 0
  %v960 = load i64, ptr %v960.p
  %v961 = add i64 0, 256
  %v962.c = icmp slt i64 %v927, %v961
  %v962 = zext i1 %v962.c to i64
  %c.b202 = icmp ne i64 %v962, 0
  br i1 %c.b202, label %b202.t432, label %b202.e433
b202.t432:
  br label %b204
b202.e433:
  br label %b205
b203:
  br label %b199
b204:
  br label %b206
b205:
  %v963 = add i64 0, 256
  br label %b206
b206:
  %v964 = phi i64 [ %v927, %b204 ], [ %v963, %b205 ]
  %v1465 = getelementptr i64, ptr @"rt.meta", i64 0
  %v965.p = getelementptr i64, ptr %v1465, i64 0
  %v965 = load i64, ptr %v965.p
  %v966 = add i64 0, 0
  %v967 = call ptr @"rt.region_alloc"(i64 %v965, i64 %v966)
  %v968 = add i64 0, 0
  %v969 = getelementptr i64, ptr %s13, i64 0
  %v970 = ptrtoint ptr %v967 to i64
  %st433 = getelementptr i64, ptr %v969, i64 0
  store i64 %v970, ptr %st433
  %st434 = getelementptr i64, ptr %v969, i64 1
  store i64 %v968, ptr %st434
  %st435 = getelementptr i64, ptr %v969, i64 2
  store i64 %v965, ptr %st435
  %v971 = getelementptr i64, ptr %s16, i64 0
  %v972.p = getelementptr i64, ptr %v969, i64 0
  %v972 = load i64, ptr %v972.p
  %st436 = getelementptr i64, ptr %v971, i64 0
  store i64 %v972, ptr %st436
  %v973.p = getelementptr i64, ptr %v969, i64 1
  %v973 = load i64, ptr %v973.p
  %st437 = getelementptr i64, ptr %v971, i64 1
  store i64 %v973, ptr %st437
  %v974.p = getelementptr i64, ptr %v969, i64 2
  %v974 = load i64, ptr %v974.p
  %st438 = getelementptr i64, ptr %v971, i64 2
  store i64 %v974, ptr %st438
  %v1466 = getelementptr i64, ptr @"rt.meta", i64 0
  %v975.p = getelementptr i64, ptr %v1466, i64 0
  %v975 = load i64, ptr %v975.p
  %v976 = add i64 0, 0
  %v977 = getelementptr i64, ptr %s18, i64 0
  %v1467 = getelementptr i64, ptr @"rt.meta", i64 0
  %v978.p = getelementptr i64, ptr %v1467, i64 0
  %v978 = load i64, ptr %v978.p
  %v979 = getelementptr i64, ptr %s20, i64 0
  %st439 = getelementptr i64, ptr %v979, i64 0
  store i64 %v976, ptr %st439
  %v1468 = getelementptr i64, ptr @"rt.meta", i64 0
  %v980.p = getelementptr i64, ptr %v1468, i64 0
  %v980 = load i64, ptr %v980.p
  br label %b209
b207:
  %v1469 = getelementptr i64, ptr @"rt.meta", i64 0
  %st440 = getelementptr i64, ptr %v1469, i64 0
  store i64 %v975, ptr %st440
  %v1022 = getelementptr i64, ptr %s15, i64 0
  %v1023.p = getelementptr i64, ptr %v971, i64 0
  %v1023 = load i64, ptr %v1023.p
  %st441 = getelementptr i64, ptr %v1022, i64 0
  store i64 %v1023, ptr %st441
  %v1024.p = getelementptr i64, ptr %v971, i64 1
  %v1024 = load i64, ptr %v1024.p
  %st442 = getelementptr i64, ptr %v1022, i64 1
  store i64 %v1024, ptr %st442
  %v1025.p = getelementptr i64, ptr %v971, i64 2
  %v1025 = load i64, ptr %v1025.p
  %st443 = getelementptr i64, ptr %v1022, i64 2
  store i64 %v1025, ptr %st443
  %v1026 = add i64 0, 0
  %v1027 = getelementptr i64, ptr %s20, i64 0
  %st444 = getelementptr i64, ptr %v1027, i64 0
  store i64 %v1026, ptr %st444
  %v1470 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1028.p = getelementptr i64, ptr %v1470, i64 0
  %v1028 = load i64, ptr %v1028.p
  br label %b216
b208:
  br label %b207
b209:
  %v1471 = getelementptr i64, ptr @"rt.meta", i64 0
  %st445 = getelementptr i64, ptr %v1471, i64 0
  store i64 %v980, ptr %st445
  %v981.p = getelementptr i64, ptr %v979, i64 0
  %v981 = load i64, ptr %v981.p
  %v982.c = icmp slt i64 %v981, %v964
  %v982 = zext i1 %v982.c to i64
  %c.b209 = icmp ne i64 %v982, 0
  br i1 %c.b209, label %b209.t447, label %b209.e448
b209.t447:
  br label %b210
b209.e448:
  br label %b211
b210:
  call void @"rt.region_enter"()
  %v1472 = getelementptr i64, ptr @"rt.meta", i64 0
  %v983.p = getelementptr i64, ptr %v1472, i64 0
  %v983 = load i64, ptr %v983.p
  %v984.p = getelementptr i64, ptr %v979, i64 0
  %v984 = load i64, ptr %v984.p
  %v1473 = getelementptr i64, ptr @"rt.meta", i64 0
  %v985.p = getelementptr i64, ptr %v1473, i64 0
  %v985 = load i64, ptr %v985.p
  %v986 = getelementptr i64, ptr %s13, i64 0
  %v987.p = getelementptr i64, ptr %v971, i64 0
  %v987 = load i64, ptr %v987.p
  %st448 = getelementptr i64, ptr %v986, i64 0
  store i64 %v987, ptr %st448
  %v988.p = getelementptr i64, ptr %v971, i64 1
  %v988 = load i64, ptr %v988.p
  %st449 = getelementptr i64, ptr %v986, i64 1
  store i64 %v988, ptr %st449
  %v989.p = getelementptr i64, ptr %v971, i64 2
  %v989 = load i64, ptr %v989.p
  %st450 = getelementptr i64, ptr %v986, i64 2
  store i64 %v989, ptr %st450
  %v990 = add i64 0, 0
  %v991.p = getelementptr i64, ptr %v986, i64 2
  %v991 = load i64, ptr %v991.p
  %v992.p = getelementptr i64, ptr %v986, i64 0
  %v992 = load i64, ptr %v992.p
  %v993.p = getelementptr i64, ptr %v986, i64 1
  %v993 = load i64, ptr %v993.p
  %v996 = add i64 0, 8
  %v997 = mul i64 %v993, %v996
  %v998 = add i64 %v992, %v997
  %v1474 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1475 = getelementptr i64, ptr %v1474, i64 %v991
  %v999.p = getelementptr i64, ptr %v1475, i64 1
  %v999 = load ptr, ptr %v999.p
  %v1000 = ptrtoint ptr %v999 to i64
  %v1001.c = icmp eq i64 %v1000, %v998
  %v1001 = zext i1 %v1001.c to i64
  %c.b210 = icmp ne i64 %v1001, 0
  br i1 %c.b210, label %b210.t452, label %b210.e453
b210.t452:
  br label %b215
b210.e453:
  br label %b214
b211:
  %v1476 = getelementptr i64, ptr @"rt.meta", i64 0
  %st453 = getelementptr i64, ptr %v1476, i64 0
  store i64 %v980, ptr %st453
  br label %b208
b212:
  %v1477 = getelementptr i64, ptr @"rt.meta", i64 0
  %st454 = getelementptr i64, ptr %v1477, i64 0
  store i64 %v985, ptr %st454
  %v1019 = add i64 0, 1
  %v1020.p = getelementptr i64, ptr %v979, i64 0
  %v1020 = load i64, ptr %v1020.p
  %v1021 = add i64 %v1020, %v1019
  %st455 = getelementptr i64, ptr %v979, i64 0
  store i64 %v1021, ptr %st455
  br label %b209
b213:
  %v994 = phi ptr [ %v1009, %b214 ], [ %v1004, %b215 ]
  %v995 = phi ptr [ %v1010, %b214 ], [ %v1003, %b215 ]
  %st456 = getelementptr i64, ptr %v995, i64 0
  store i64 %v990, ptr %st456
  %v1011.p = getelementptr i64, ptr %v986, i64 1
  %v1011 = load i64, ptr %v1011.p
  %v1012 = add i64 0, 1
  %v1013 = add i64 %v1011, %v1012
  %v1014 = getelementptr i64, ptr %s15, i64 0
  %v1015 = ptrtoint ptr %v994 to i64
  %st457 = getelementptr i64, ptr %v1014, i64 0
  store i64 %v1015, ptr %st457
  %st458 = getelementptr i64, ptr %v1014, i64 1
  store i64 %v1013, ptr %st458
  %st459 = getelementptr i64, ptr %v1014, i64 2
  store i64 %v991, ptr %st459
  %v1016.p = getelementptr i64, ptr %v1014, i64 0
  %v1016 = load i64, ptr %v1016.p
  %st460 = getelementptr i64, ptr %v971, i64 0
  store i64 %v1016, ptr %st460
  %v1017.p = getelementptr i64, ptr %v1014, i64 1
  %v1017 = load i64, ptr %v1017.p
  %st461 = getelementptr i64, ptr %v971, i64 1
  store i64 %v1017, ptr %st461
  %v1018.p = getelementptr i64, ptr %v1014, i64 2
  %v1018 = load i64, ptr %v1018.p
  %st462 = getelementptr i64, ptr %v971, i64 2
  store i64 %v1018, ptr %st462
  br label %b212
b214:
  %v1005 = add i64 0, 1
  %v1006 = mul i64 %v993, %v1005
  %v1007 = add i64 0, 1
  %v1008 = add i64 0, 1
  %v1009 = call ptr @"rt.slice_grow"(i64 %v992, i64 %v993, i64 %v1007, i64 %v991, i64 %v1008)
  %v1010 = getelementptr i64, ptr %v1009, i64 %v1006
  br label %b213
b215:
  %v1002 = add i64 0, 1
  %v1003 = call ptr @"rt.region_alloc"(i64 %v991, i64 %v1002)
  %v1004 = inttoptr i64 %v992 to ptr
  br label %b213
b216:
  %v1478 = getelementptr i64, ptr @"rt.meta", i64 0
  %st463 = getelementptr i64, ptr %v1478, i64 0
  store i64 %v1028, ptr %st463
  %v1029.p = getelementptr i64, ptr %v1027, i64 0
  %v1029 = load i64, ptr %v1029.p
  %v1030 = add i64 %v1029, %v964
  %v1031.c = icmp sle i64 %v1030, %v927
  %v1031 = zext i1 %v1031.c to i64
  %c.b216 = icmp ne i64 %v1031, 0
  br i1 %c.b216, label %b216.t465, label %b216.e466
b216.t465:
  br label %b219
b216.e466:
  br label %b220
b217:
  call void @"rt.region_enter"()
  %v1479 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1035.p = getelementptr i64, ptr %v1479, i64 0
  %v1035 = load i64, ptr %v1035.p
  %v1480 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1036.p = getelementptr i64, ptr %v1480, i64 0
  %v1036 = load i64, ptr %v1036.p
  %v1037 = add i64 0, 0
  %v1038 = getelementptr i64, ptr %s18, i64 0
  %v1481 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1039.p = getelementptr i64, ptr %v1481, i64 0
  %v1039 = load i64, ptr %v1039.p
  %v1040 = getelementptr i64, ptr %s21, i64 0
  %st466 = getelementptr i64, ptr %v1040, i64 0
  store i64 %v1037, ptr %st466
  %v1482 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1041.p = getelementptr i64, ptr %v1482, i64 0
  %v1041 = load i64, ptr %v1041.p
  br label %b223
b218:
  %v1483 = getelementptr i64, ptr @"rt.meta", i64 0
  %st467 = getelementptr i64, ptr %v1483, i64 0
  store i64 %v1028, ptr %st467
  %v1484 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1093.p = getelementptr i64, ptr %v1484, i64 0
  %v1093 = load i64, ptr %v1093.p
  %v1094 = add i64 0, 0
  %v1095.p = getelementptr i64, ptr %v1027, i64 0
  %v1095 = load i64, ptr %v1095.p
  %v1096 = sub i64 %v927, %v1095
  %v1097 = getelementptr i64, ptr %s21, i64 0
  %v1485 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1098.p = getelementptr i64, ptr %v1485, i64 0
  %v1098 = load i64, ptr %v1098.p
  %v1099 = getelementptr i64, ptr %s18, i64 0
  %st468 = getelementptr i64, ptr %v1099, i64 0
  store i64 %v1094, ptr %st468
  %v1486 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1100.p = getelementptr i64, ptr %v1486, i64 0
  %v1100 = load i64, ptr %v1100.p
  br label %b234
b219:
  %v1033 = add i64 0, 0
  %v1034.c = icmp sgt i64 %v964, %v1033
  %v1034 = zext i1 %v1034.c to i64
  br label %b220
b220:
  %v1032 = phi i64 [ %v1031, %b216.e466 ], [ %v1034, %b219 ]
  %c.b220 = icmp ne i64 %v1032, 0
  br i1 %c.b220, label %b220.t470, label %b220.e471
b220.t470:
  br label %b217
b220.e471:
  br label %b218
b221:
  %v1487 = getelementptr i64, ptr @"rt.meta", i64 0
  %st471 = getelementptr i64, ptr %v1487, i64 0
  store i64 %v1036, ptr %st471
  %v1091.p = getelementptr i64, ptr %v1027, i64 0
  %v1091 = load i64, ptr %v1091.p
  %v1092 = add i64 %v1091, %v964
  %st472 = getelementptr i64, ptr %v1027, i64 0
  store i64 %v1092, ptr %st472
  br label %b216
b222:
  br label %b221
b223:
  %v1488 = getelementptr i64, ptr @"rt.meta", i64 0
  %st473 = getelementptr i64, ptr %v1488, i64 0
  store i64 %v1041, ptr %st473
  %v1042.p = getelementptr i64, ptr %v1040, i64 0
  %v1042 = load i64, ptr %v1042.p
  %v1043.c = icmp slt i64 %v1042, %v964
  %v1043 = zext i1 %v1043.c to i64
  %c.b223 = icmp ne i64 %v1043, 0
  br i1 %c.b223, label %b223.t475, label %b223.e476
b223.t475:
  br label %b224
b223.e476:
  br label %b225
b224:
  call void @"rt.region_enter"()
  %v1489 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1044.p = getelementptr i64, ptr %v1489, i64 0
  %v1044 = load i64, ptr %v1044.p
  %v1045.p = getelementptr i64, ptr %v1040, i64 0
  %v1045 = load i64, ptr %v1045.p
  %v1490 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1046.p = getelementptr i64, ptr %v1490, i64 0
  %v1046 = load i64, ptr %v1046.p
  %v1047 = getelementptr i64, ptr %s13, i64 0
  %v1048.p = getelementptr i64, ptr %v895, i64 0
  %v1048 = load i64, ptr %v1048.p
  %st476 = getelementptr i64, ptr %v1047, i64 0
  store i64 %v1048, ptr %st476
  %v1049.p = getelementptr i64, ptr %v895, i64 1
  %v1049 = load i64, ptr %v1049.p
  %st477 = getelementptr i64, ptr %v1047, i64 1
  store i64 %v1049, ptr %st477
  %v1050.p = getelementptr i64, ptr %v895, i64 2
  %v1050 = load i64, ptr %v1050.p
  %st478 = getelementptr i64, ptr %v1047, i64 2
  store i64 %v1050, ptr %st478
  %v1051.p = getelementptr i64, ptr %v1022, i64 1
  %v1051 = load i64, ptr %v1051.p
  %v1052.c = icmp uge i64 %v1045, %v1051
  %v1052 = zext i1 %v1052.c to i64
  %c.b224 = icmp ne i64 %v1052, 0
  br i1 %c.b224, label %b224.t480, label %b224.e481
b224.t480:
  br label %b227
b224.e481:
  br label %b228
b225:
  %v1491 = getelementptr i64, ptr @"rt.meta", i64 0
  %st481 = getelementptr i64, ptr %v1491, i64 0
  store i64 %v1041, ptr %st481
  br label %b222
b226:
  %v1492 = getelementptr i64, ptr @"rt.meta", i64 0
  %st482 = getelementptr i64, ptr %v1492, i64 0
  store i64 %v1046, ptr %st482
  %v1088 = add i64 0, 1
  %v1089.p = getelementptr i64, ptr %v1040, i64 0
  %v1089 = load i64, ptr %v1089.p
  %v1090 = add i64 %v1089, %v1088
  %st483 = getelementptr i64, ptr %v1040, i64 0
  store i64 %v1090, ptr %st483
  br label %b223
b227:
  %v1053 = add i64 0, 25
  call void @"rt.panic"(i64 %v1053)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b228:
  %v1054.p = getelementptr i64, ptr %v1022, i64 0
  %v1054 = load i64, ptr %v1054.p
  %v1055 = inttoptr i64 %v1054 to ptr
  %v1056 = add i64 0, 1
  %v1057 = mul i64 %v1045, %v1056
  %v1058 = getelementptr i64, ptr %v1055, i64 %v1057
  %v1059.p = getelementptr i64, ptr %v1058, i64 0
  %v1059 = load i64, ptr %v1059.p
  %v1060.p = getelementptr i64, ptr %v1047, i64 2
  %v1060 = load i64, ptr %v1060.p
  %v1061.p = getelementptr i64, ptr %v1047, i64 0
  %v1061 = load i64, ptr %v1061.p
  %v1062.p = getelementptr i64, ptr %v1047, i64 1
  %v1062 = load i64, ptr %v1062.p
  %v1065 = add i64 0, 8
  %v1066 = mul i64 %v1062, %v1065
  %v1067 = add i64 %v1061, %v1066
  %v1493 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1494 = getelementptr i64, ptr %v1493, i64 %v1060
  %v1068.p = getelementptr i64, ptr %v1494, i64 1
  %v1068 = load ptr, ptr %v1068.p
  %v1069 = ptrtoint ptr %v1068 to i64
  %v1070.c = icmp eq i64 %v1069, %v1067
  %v1070 = zext i1 %v1070.c to i64
  %c.b228 = icmp ne i64 %v1070, 0
  br i1 %c.b228, label %b228.t485, label %b228.e486
b228.t485:
  br label %b231
b228.e486:
  br label %b230
b229:
  %v1063 = phi ptr [ %v1078, %b230 ], [ %v1073, %b231 ]
  %v1064 = phi ptr [ %v1079, %b230 ], [ %v1072, %b231 ]
  %st486 = getelementptr i64, ptr %v1064, i64 0
  store i64 %v1059, ptr %st486
  %v1080.p = getelementptr i64, ptr %v1047, i64 1
  %v1080 = load i64, ptr %v1080.p
  %v1081 = add i64 0, 1
  %v1082 = add i64 %v1080, %v1081
  %v1083 = getelementptr i64, ptr %s14, i64 0
  %v1084 = ptrtoint ptr %v1063 to i64
  %st487 = getelementptr i64, ptr %v1083, i64 0
  store i64 %v1084, ptr %st487
  %st488 = getelementptr i64, ptr %v1083, i64 1
  store i64 %v1082, ptr %st488
  %st489 = getelementptr i64, ptr %v1083, i64 2
  store i64 %v1060, ptr %st489
  %v1085.p = getelementptr i64, ptr %v1083, i64 0
  %v1085 = load i64, ptr %v1085.p
  %st490 = getelementptr i64, ptr %v895, i64 0
  store i64 %v1085, ptr %st490
  %v1086.p = getelementptr i64, ptr %v1083, i64 1
  %v1086 = load i64, ptr %v1086.p
  %st491 = getelementptr i64, ptr %v895, i64 1
  store i64 %v1086, ptr %st491
  %v1087.p = getelementptr i64, ptr %v1083, i64 2
  %v1087 = load i64, ptr %v1087.p
  %st492 = getelementptr i64, ptr %v895, i64 2
  store i64 %v1087, ptr %st492
  br label %b226
b230:
  %v1074 = add i64 0, 1
  %v1075 = mul i64 %v1062, %v1074
  %v1076 = add i64 0, 1
  %v1077 = add i64 0, 1
  %v1078 = call ptr @"rt.slice_grow"(i64 %v1061, i64 %v1062, i64 %v1076, i64 %v1060, i64 %v1077)
  %v1079 = getelementptr i64, ptr %v1078, i64 %v1075
  br label %b229
b231:
  %v1071 = add i64 0, 1
  %v1072 = call ptr @"rt.region_alloc"(i64 %v1060, i64 %v1071)
  %v1073 = inttoptr i64 %v1061 to ptr
  br label %b229
b232:
  %v1495 = getelementptr i64, ptr @"rt.meta", i64 0
  %st493 = getelementptr i64, ptr %v1495, i64 0
  store i64 %v1093, ptr %st493
  br label %b203
b233:
  br label %b232
b234:
  %v1496 = getelementptr i64, ptr @"rt.meta", i64 0
  %st494 = getelementptr i64, ptr %v1496, i64 0
  store i64 %v1100, ptr %st494
  %v1101.p = getelementptr i64, ptr %v1099, i64 0
  %v1101 = load i64, ptr %v1101.p
  %v1102.c = icmp slt i64 %v1101, %v1096
  %v1102 = zext i1 %v1102.c to i64
  %c.b234 = icmp ne i64 %v1102, 0
  br i1 %c.b234, label %b234.t496, label %b234.e497
b234.t496:
  br label %b235
b234.e497:
  br label %b236
b235:
  call void @"rt.region_enter"()
  %v1497 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1103.p = getelementptr i64, ptr %v1497, i64 0
  %v1103 = load i64, ptr %v1103.p
  %v1104.p = getelementptr i64, ptr %v1099, i64 0
  %v1104 = load i64, ptr %v1104.p
  %v1498 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1105.p = getelementptr i64, ptr %v1498, i64 0
  %v1105 = load i64, ptr %v1105.p
  %v1106 = getelementptr i64, ptr %s14, i64 0
  %v1107.p = getelementptr i64, ptr %v895, i64 0
  %v1107 = load i64, ptr %v1107.p
  %st497 = getelementptr i64, ptr %v1106, i64 0
  store i64 %v1107, ptr %st497
  %v1108.p = getelementptr i64, ptr %v895, i64 1
  %v1108 = load i64, ptr %v1108.p
  %st498 = getelementptr i64, ptr %v1106, i64 1
  store i64 %v1108, ptr %st498
  %v1109.p = getelementptr i64, ptr %v895, i64 2
  %v1109 = load i64, ptr %v1109.p
  %st499 = getelementptr i64, ptr %v1106, i64 2
  store i64 %v1109, ptr %st499
  %v1110.p = getelementptr i64, ptr %v1022, i64 1
  %v1110 = load i64, ptr %v1110.p
  %v1111.c = icmp uge i64 %v1104, %v1110
  %v1111 = zext i1 %v1111.c to i64
  %c.b235 = icmp ne i64 %v1111, 0
  br i1 %c.b235, label %b235.t501, label %b235.e502
b235.t501:
  br label %b238
b235.e502:
  br label %b239
b236:
  %v1499 = getelementptr i64, ptr @"rt.meta", i64 0
  %st502 = getelementptr i64, ptr %v1499, i64 0
  store i64 %v1100, ptr %st502
  br label %b233
b237:
  %v1500 = getelementptr i64, ptr @"rt.meta", i64 0
  %st503 = getelementptr i64, ptr %v1500, i64 0
  store i64 %v1105, ptr %st503
  %v1147 = add i64 0, 1
  %v1148.p = getelementptr i64, ptr %v1099, i64 0
  %v1148 = load i64, ptr %v1148.p
  %v1149 = add i64 %v1148, %v1147
  %st504 = getelementptr i64, ptr %v1099, i64 0
  store i64 %v1149, ptr %st504
  br label %b234
b238:
  %v1112 = add i64 0, 26
  call void @"rt.panic"(i64 %v1112)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b239:
  %v1113.p = getelementptr i64, ptr %v1022, i64 0
  %v1113 = load i64, ptr %v1113.p
  %v1114 = inttoptr i64 %v1113 to ptr
  %v1115 = add i64 0, 1
  %v1116 = mul i64 %v1104, %v1115
  %v1117 = getelementptr i64, ptr %v1114, i64 %v1116
  %v1118.p = getelementptr i64, ptr %v1117, i64 0
  %v1118 = load i64, ptr %v1118.p
  %v1119.p = getelementptr i64, ptr %v1106, i64 2
  %v1119 = load i64, ptr %v1119.p
  %v1120.p = getelementptr i64, ptr %v1106, i64 0
  %v1120 = load i64, ptr %v1120.p
  %v1121.p = getelementptr i64, ptr %v1106, i64 1
  %v1121 = load i64, ptr %v1121.p
  %v1124 = add i64 0, 8
  %v1125 = mul i64 %v1121, %v1124
  %v1126 = add i64 %v1120, %v1125
  %v1501 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1502 = getelementptr i64, ptr %v1501, i64 %v1119
  %v1127.p = getelementptr i64, ptr %v1502, i64 1
  %v1127 = load ptr, ptr %v1127.p
  %v1128 = ptrtoint ptr %v1127 to i64
  %v1129.c = icmp eq i64 %v1128, %v1126
  %v1129 = zext i1 %v1129.c to i64
  %c.b239 = icmp ne i64 %v1129, 0
  br i1 %c.b239, label %b239.t506, label %b239.e507
b239.t506:
  br label %b242
b239.e507:
  br label %b241
b240:
  %v1122 = phi ptr [ %v1137, %b241 ], [ %v1132, %b242 ]
  %v1123 = phi ptr [ %v1138, %b241 ], [ %v1131, %b242 ]
  %st507 = getelementptr i64, ptr %v1123, i64 0
  store i64 %v1118, ptr %st507
  %v1139.p = getelementptr i64, ptr %v1106, i64 1
  %v1139 = load i64, ptr %v1139.p
  %v1140 = add i64 0, 1
  %v1141 = add i64 %v1139, %v1140
  %v1142 = getelementptr i64, ptr %s13, i64 0
  %v1143 = ptrtoint ptr %v1122 to i64
  %st508 = getelementptr i64, ptr %v1142, i64 0
  store i64 %v1143, ptr %st508
  %st509 = getelementptr i64, ptr %v1142, i64 1
  store i64 %v1141, ptr %st509
  %st510 = getelementptr i64, ptr %v1142, i64 2
  store i64 %v1119, ptr %st510
  %v1144.p = getelementptr i64, ptr %v1142, i64 0
  %v1144 = load i64, ptr %v1144.p
  %st511 = getelementptr i64, ptr %v895, i64 0
  store i64 %v1144, ptr %st511
  %v1145.p = getelementptr i64, ptr %v1142, i64 1
  %v1145 = load i64, ptr %v1145.p
  %st512 = getelementptr i64, ptr %v895, i64 1
  store i64 %v1145, ptr %st512
  %v1146.p = getelementptr i64, ptr %v1142, i64 2
  %v1146 = load i64, ptr %v1146.p
  %st513 = getelementptr i64, ptr %v895, i64 2
  store i64 %v1146, ptr %st513
  br label %b237
b241:
  %v1133 = add i64 0, 1
  %v1134 = mul i64 %v1121, %v1133
  %v1135 = add i64 0, 1
  %v1136 = add i64 0, 1
  %v1137 = call ptr @"rt.slice_grow"(i64 %v1120, i64 %v1121, i64 %v1135, i64 %v1119, i64 %v1136)
  %v1138 = getelementptr i64, ptr %v1137, i64 %v1134
  br label %b240
b242:
  %v1130 = add i64 0, 1
  %v1131 = call ptr @"rt.region_alloc"(i64 %v1119, i64 %v1130)
  %v1132 = inttoptr i64 %v1120 to ptr
  br label %b240
b243:
  %v1150 = add i64 0, 2
  %v1151 = add i64 %v882, %v1150
  %v1152 = getelementptr i64, ptr %s8, i64 0
  %st514 = getelementptr i64, ptr %v1152, i64 0
  store i64 %v1151, ptr %st514
  %v1153 = add i64 0, 0
  %v1154 = getelementptr i64, ptr %s20, i64 0
  %st515 = getelementptr i64, ptr %v1154, i64 0
  store i64 %v1153, ptr %st515
  %v1503 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1155.p = getelementptr i64, ptr %v1503, i64 0
  %v1155 = load i64, ptr %v1155.p
  br label %b244
b244:
  %v1504 = getelementptr i64, ptr @"rt.meta", i64 0
  %st516 = getelementptr i64, ptr %v1504, i64 0
  store i64 %v1155, ptr %st516
  %v1156.p = getelementptr i64, ptr %v1154, i64 0
  %v1156 = load i64, ptr %v1156.p
  %v1157.c = icmp slt i64 %v1156, %v912
  %v1157 = zext i1 %v1157.c to i64
  %c.b244 = icmp ne i64 %v1157, 0
  br i1 %c.b244, label %b244.t518, label %b244.e519
b244.t518:
  br label %b245
b244.e519:
  br label %b246
b245:
  call void @"rt.region_enter"()
  %v1505 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1158.p = getelementptr i64, ptr %v1505, i64 0
  %v1158 = load i64, ptr %v1158.p
  %v1159 = add i64 0, 1
  %v1160 = add i64 0, 2
  %v1161.p = getelementptr i64, ptr %v1154, i64 0
  %v1161 = load i64, ptr %v1161.p
  %v1162 = add i64 %v1160, %v1161
  %v1163.p = getelementptr i64, ptr %v908, i64 1
  %v1163 = load i64, ptr %v1163.p
  %v1164.c = icmp uge i64 %v1162, %v1163
  %v1164 = zext i1 %v1164.c to i64
  %c.b245 = icmp ne i64 %v1164, 0
  br i1 %c.b245, label %b245.t520, label %b245.e521
b245.t520:
  br label %b247
b245.e521:
  br label %b248
b246:
  %v1506 = getelementptr i64, ptr @"rt.meta", i64 0
  %st521 = getelementptr i64, ptr %v1506, i64 0
  store i64 %v1155, ptr %st521
  %v1178 = add i64 0, 2
  %v1179 = add i64 %v1178, %v912
  %v1180.p = getelementptr i64, ptr %v908, i64 1
  %v1180 = load i64, ptr %v1180.p
  %v1181.c = icmp uge i64 %v1179, %v1180
  %v1181 = zext i1 %v1181.c to i64
  %c.b246 = icmp ne i64 %v1181, 0
  br i1 %c.b246, label %b246.t523, label %b246.e524
b246.t523:
  br label %b249
b246.e524:
  br label %b250
b247:
  %v1165 = add i64 0, 27
  call void @"rt.panic"(i64 %v1165)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b248:
  %v1166.p = getelementptr i64, ptr %v908, i64 0
  %v1166 = load i64, ptr %v1166.p
  %v1167 = inttoptr i64 %v1166 to ptr
  %v1168 = add i64 0, 1
  %v1169 = mul i64 %v1162, %v1168
  %v1170 = getelementptr i64, ptr %v1167, i64 %v1169
  %v1171.p = getelementptr i64, ptr %v1170, i64 0
  %v1171 = load i64, ptr %v1171.p
  %v1172 = add i64 %v1159, %v1171
  %v1173.p = getelementptr i64, ptr %v1152, i64 0
  %v1173 = load i64, ptr %v1173.p
  %v1174 = add i64 %v1173, %v1172
  %st524 = getelementptr i64, ptr %v1152, i64 0
  store i64 %v1174, ptr %st524
  %v1175 = add i64 0, 1
  %v1176.p = getelementptr i64, ptr %v1154, i64 0
  %v1176 = load i64, ptr %v1176.p
  %v1177 = add i64 %v1176, %v1175
  %st525 = getelementptr i64, ptr %v1154, i64 0
  store i64 %v1177, ptr %st525
  br label %b244
b249:
  %v1182 = add i64 0, 28
  call void @"rt.panic"(i64 %v1182)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b250:
  %v1183.p = getelementptr i64, ptr %v908, i64 0
  %v1183 = load i64, ptr %v1183.p
  %v1184 = inttoptr i64 %v1183 to ptr
  %v1185 = add i64 0, 1
  %v1186 = mul i64 %v1179, %v1185
  %v1187 = getelementptr i64, ptr %v1184, i64 %v1186
  %v1188.p = getelementptr i64, ptr %v1187, i64 0
  %v1188 = load i64, ptr %v1188.p
  %v1189 = add i64 0, 4
  %v1190.p = getelementptr i64, ptr %v1152, i64 0
  %v1190 = load i64, ptr %v1190.p
  %v1191 = add i64 0, 0
  %v1192.p = getelementptr i64, ptr %v908, i64 0
  %v1192 = load i64, ptr %v1192.p
  %v1193 = call i64 @"rt.lease_op"(i64 %v1189, i64 %v1192, i64 %v1190, i64 %v1191)
  %v1194 = add i64 0, 1
  %v1195 = add i64 0, 32
  %v1197 = add i64 0, 0
  %v1198.c = icmp slt i64 %v1195, %v1197
  %v1198 = zext i1 %v1198.c to i64
  %c.b250 = icmp ne i64 %v1198, 0
  br i1 %c.b250, label %b250.t527, label %b250.e528
b250.t527:
  br label %b251
b250.e528:
  br label %b252
b251:
  %v1199 = add i64 0, 29
  call void @"rt.panic"(i64 %v1199)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b252:
  %v1200 = add i64 0, 63
  %v1201.c = icmp sgt i64 %v1195, %v1200
  %v1201 = zext i1 %v1201.c to i64
  %c.b252 = icmp ne i64 %v1201, 0
  br i1 %c.b252, label %b252.t529, label %b252.e530
b252.t529:
  br label %b254
b252.e530:
  br label %b255
b253:
  %v1196 = phi i64 [ %v1202, %b254 ], [ %v1203, %b255 ]
  %v1204 = add i64 %v1193, %v1196
  %v1205 = add i64 0, 5
  %v1206.p = getelementptr i64, ptr %v1152, i64 0
  %v1206 = load i64, ptr %v1206.p
  %v1207.p = getelementptr i64, ptr %v908, i64 0
  %v1207 = load i64, ptr %v1207.p
  %v1208 = call i64 @"rt.lease_op"(i64 %v1205, i64 %v1207, i64 %v1206, i64 %v1204)
  %v1209.p = getelementptr i64, ptr %v1152, i64 0
  %v1209 = load i64, ptr %v1209.p
  %v1210 = add i64 0, 1
  %v1211 = add i64 %v1209, %v1210
  %v1212 = getelementptr i64, ptr %s15, i64 0
  %v1213.p = getelementptr i64, ptr %v908, i64 0
  %v1213 = load i64, ptr %v1213.p
  %v1214 = add i64 0, 3
  %v1215.n = and i64 %v1214, 63
  %v1215 = shl i64 %v1211, %v1215.n
  %v1216 = add i64 %v1213, %v1215
  %st530 = getelementptr i64, ptr %v1212, i64 0
  store i64 %v1216, ptr %st530
  %st531 = getelementptr i64, ptr %v1212, i64 1
  store i64 %v1188, ptr %st531
  %v1217.p = getelementptr i64, ptr %v908, i64 2
  %v1217 = load i64, ptr %v1217.p
  %st532 = getelementptr i64, ptr %v1212, i64 2
  store i64 %v1217, ptr %st532
  %v1218.p = getelementptr i64, ptr %v1212, i64 0
  %v1218 = load i64, ptr %v1218.p
  %st533 = getelementptr i64, ptr %v895, i64 0
  store i64 %v1218, ptr %st533
  %v1219.p = getelementptr i64, ptr %v1212, i64 1
  %v1219 = load i64, ptr %v1219.p
  %st534 = getelementptr i64, ptr %v895, i64 1
  store i64 %v1219, ptr %st534
  %v1220.p = getelementptr i64, ptr %v1212, i64 2
  %v1220 = load i64, ptr %v1220.p
  %st535 = getelementptr i64, ptr %v895, i64 2
  store i64 %v1220, ptr %st535
  %v1221 = add i64 0, 3
  %v1222 = getelementptr i64, ptr %v895, i64 %v1221
  %st536 = getelementptr i64, ptr %v1222, i64 0
  store i64 %v1204, ptr %st536
  %v1223 = add i64 0, 4
  %v1224 = getelementptr i64, ptr %v895, i64 %v1223
  %v1225.p = getelementptr i64, ptr %v908, i64 0
  %v1225 = load i64, ptr %v1225.p
  %st537 = getelementptr i64, ptr %v1224, i64 0
  store i64 %v1225, ptr %st537
  %v1226.p = getelementptr i64, ptr %v908, i64 1
  %v1226 = load i64, ptr %v1226.p
  %st538 = getelementptr i64, ptr %v1224, i64 1
  store i64 %v1226, ptr %st538
  %v1227.p = getelementptr i64, ptr %v908, i64 2
  %v1227 = load i64, ptr %v1227.p
  %st539 = getelementptr i64, ptr %v1224, i64 2
  store i64 %v1227, ptr %st539
  %v1228.p = getelementptr i64, ptr %v1152, i64 0
  %v1228 = load i64, ptr %v1228.p
  %v1229 = add i64 0, 1
  %v1230 = add i64 %v1228, %v1229
  %v1231 = add i64 0, 7
  %v1232 = getelementptr i64, ptr %v895, i64 %v1231
  %st540 = getelementptr i64, ptr %v1232, i64 0
  store i64 %v1230, ptr %st540
  %v1233 = add i64 0, 0
  %v1234.c = icmp eq i64 %v1204, %v1233
  %v1234 = zext i1 %v1234.c to i64
  %c.b253 = icmp ne i64 %v1234, 0
  br i1 %c.b253, label %b253.t542, label %b253.e543
b253.t542:
  br label %b256
b253.e543:
  br label %b257
b254:
  %v1202 = add i64 0, 0
  br label %b253
b255:
  %v1203.n = and i64 %v1195, 63
  %v1203 = shl i64 %v1194, %v1203.n
  br label %b253
b256:
  %v1235 = add i64 0, 0
  %v1236 = getelementptr i64, ptr %s10, i64 0
  %st543 = getelementptr i64, ptr %v1236, i64 0
  store i64 %v1235, ptr %st543
  %v1507 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1237.p = getelementptr i64, ptr %v1507, i64 0
  %v1237 = load i64, ptr %v1237.p
  br label %b258
b257:
  br label %b263
b258:
  %v1508 = getelementptr i64, ptr @"rt.meta", i64 0
  %st544 = getelementptr i64, ptr %v1508, i64 0
  store i64 %v1237, ptr %st544
  %v1238.p = getelementptr i64, ptr %v1236, i64 0
  %v1238 = load i64, ptr %v1238.p
  %v1239.c = icmp slt i64 %v1238, %v1188
  %v1239 = zext i1 %v1239.c to i64
  %c.b258 = icmp ne i64 %v1239, 0
  br i1 %c.b258, label %b258.t546, label %b258.e547
b258.t546:
  br label %b259
b258.e547:
  br label %b260
b259:
  call void @"rt.region_enter"()
  %v1509 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1240.p = getelementptr i64, ptr %v1509, i64 0
  %v1240 = load i64, ptr %v1240.p
  %v1241.p = getelementptr i64, ptr %v1236, i64 0
  %v1241 = load i64, ptr %v1241.p
  %v1242 = add i64 0, 0
  %v1243.p = getelementptr i64, ptr %v895, i64 1
  %v1243 = load i64, ptr %v1243.p
  %v1244.c = icmp uge i64 %v1241, %v1243
  %v1244 = zext i1 %v1244.c to i64
  %c.b259 = icmp ne i64 %v1244, 0
  br i1 %c.b259, label %b259.t548, label %b259.e549
b259.t548:
  br label %b261
b259.e549:
  br label %b262
b260:
  %v1510 = getelementptr i64, ptr @"rt.meta", i64 0
  %st549 = getelementptr i64, ptr %v1510, i64 0
  store i64 %v1237, ptr %st549
  br label %b263
b261:
  %v1245 = add i64 0, 30
  call void @"rt.panic"(i64 %v1245)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b262:
  %v1246.p = getelementptr i64, ptr %v895, i64 0
  %v1246 = load i64, ptr %v1246.p
  %v1247 = inttoptr i64 %v1246 to ptr
  %v1248 = add i64 0, 1
  %v1249 = mul i64 %v1241, %v1248
  %v1250 = getelementptr i64, ptr %v1247, i64 %v1249
  %st550 = getelementptr i64, ptr %v1250, i64 0
  store i64 %v1242, ptr %st550
  %v1251 = add i64 0, 1
  %v1252.p = getelementptr i64, ptr %v1236, i64 0
  %v1252 = load i64, ptr %v1252.p
  %v1253 = add i64 %v1252, %v1251
  %st551 = getelementptr i64, ptr %v1236, i64 0
  store i64 %v1253, ptr %st551
  br label %b258
b263:
  br label %b194
b264:
  %v1282.p = getelementptr i64, ptr %v1255, i64 0
  %v1282 = load i64, ptr %v1282.p
  %v1283 = add i64 0, 10
  %v1284 = mul i64 %v1282, %v1283
  %v1285 = add i64 0, 1
  %v1286 = getelementptr i64, ptr %s8, i64 0
  %v1511 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1287.p = getelementptr i64, ptr %v1511, i64 0
  %v1287 = load i64, ptr %v1287.p
  %v1288.p = getelementptr i64, ptr %v895, i64 1
  %v1288 = load i64, ptr %v1288.p
  %v1289.c = icmp uge i64 %v1285, %v1288
  %v1289 = zext i1 %v1289.c to i64
  %c.b264 = icmp ne i64 %v1289, 0
  br i1 %c.b264, label %b264.t553, label %b264.e554
b264.t553:
  br label %b276
b264.e554:
  br label %b277
b265:
  %v1259 = add i64 0, 31
  call void @"rt.panic"(i64 %v1259)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b266:
  %v1260.p = getelementptr i64, ptr %v895, i64 0
  %v1260 = load i64, ptr %v1260.p
  %v1261 = inttoptr i64 %v1260 to ptr
  %v1262 = add i64 0, 1
  %v1263 = mul i64 %v1254, %v1262
  %v1264 = getelementptr i64, ptr %v1261, i64 %v1263
  %v1265.p = getelementptr i64, ptr %v1264, i64 0
  %v1265 = load i64, ptr %v1265.p
  %v1266.p = getelementptr i64, ptr %v895, i64 3
  %v1266 = load i64, ptr %v1266.p
  %v1267 = xor i64 %v1265, %v1266
  %v1268 = add i64 0, 32
  %v1270 = add i64 0, 0
  %v1271.c = icmp slt i64 %v1268, %v1270
  %v1271 = zext i1 %v1271.c to i64
  %c.b266 = icmp ne i64 %v1271, 0
  br i1 %c.b266, label %b266.t555, label %b266.e556
b266.t555:
  br label %b267
b266.e556:
  br label %b268
b267:
  %v1272 = add i64 0, 32
  call void @"rt.panic"(i64 %v1272)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b268:
  %v1273 = add i64 0, 63
  %v1274.c = icmp sgt i64 %v1268, %v1273
  %v1274 = zext i1 %v1274.c to i64
  %c.b268 = icmp ne i64 %v1274, 0
  br i1 %c.b268, label %b268.t557, label %b268.e558
b268.t557:
  br label %b270
b268.e558:
  br label %b271
b269:
  %v1269 = phi i64 [ %v1276, %b270 ], [ %v1277, %b271 ]
  %v1278 = add i64 0, 0
  %v1279.c = icmp eq i64 %v1269, %v1278
  %v1279 = zext i1 %v1279.c to i64
  %c.b269 = icmp ne i64 %v1279, 0
  br i1 %c.b269, label %b269.t559, label %b269.e560
b269.t559:
  br label %b272
b269.e560:
  br label %b273
b270:
  %v1275 = add i64 0, 63
  %v1276.n = and i64 %v1275, 63
  %v1276 = ashr i64 %v1267, %v1276.n
  br label %b269
b271:
  %v1277.n = and i64 %v1268, 63
  %v1277 = ashr i64 %v1267, %v1277.n
  br label %b269
b272:
  br label %b274
b273:
  %v1280 = add i64 0, 0
  br label %b274
b274:
  %v1281 = phi i64 [ %v1267, %b272 ], [ %v1280, %b273 ]
  %st560 = getelementptr i64, ptr %v1255, i64 0
  store i64 %v1281, ptr %st560
  %v1512 = getelementptr i64, ptr @"rt.meta", i64 0
  %st561 = getelementptr i64, ptr %v1512, i64 0
  store i64 %v1256, ptr %st561
  br label %b264
b275:
  %v1313.p = getelementptr i64, ptr %v1286, i64 0
  %v1313 = load i64, ptr %v1313.p
  %v1314 = add i64 %v1284, %v1313
  %v1315.p = getelementptr i64, ptr %v874, i64 0
  %v1315 = load i64, ptr %v1315.p
  %v1316.p = getelementptr i64, ptr %v874, i64 1
  %v1316 = load i64, ptr %v1316.p
  %v1317.p = getelementptr i64, ptr %v874, i64 2
  %v1317 = load i64, ptr %v1317.p
  call void @"std/task.LeaseGive"(i64 %v1315, i64 %v1316, i64 %v1317, i64 %v882)
  %v1513 = getelementptr i64, ptr @"rt.meta", i64 0
  %st562 = getelementptr i64, ptr %v1513, i64 0
  store i64 %v872, ptr %st562
  call void @"rt.print_int"(i64 %v868)
  %v1318 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1318)
  call void @"rt.print_int"(i64 %v1314)
  %v1319 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1319)
  %v1514 = getelementptr i64, ptr @"rt.meta", i64 0
  %st563 = getelementptr i64, ptr %v1514, i64 0
  store i64 %v0, ptr %st563
  ret void
b276:
  %v1290 = add i64 0, 33
  call void @"rt.panic"(i64 %v1290)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b277:
  %v1291.p = getelementptr i64, ptr %v895, i64 0
  %v1291 = load i64, ptr %v1291.p
  %v1292 = inttoptr i64 %v1291 to ptr
  %v1293 = add i64 0, 1
  %v1294 = mul i64 %v1285, %v1293
  %v1295 = getelementptr i64, ptr %v1292, i64 %v1294
  %v1296.p = getelementptr i64, ptr %v1295, i64 0
  %v1296 = load i64, ptr %v1296.p
  %v1297.p = getelementptr i64, ptr %v895, i64 3
  %v1297 = load i64, ptr %v1297.p
  %v1298 = xor i64 %v1296, %v1297
  %v1299 = add i64 0, 32
  %v1301 = add i64 0, 0
  %v1302.c = icmp slt i64 %v1299, %v1301
  %v1302 = zext i1 %v1302.c to i64
  %c.b277 = icmp ne i64 %v1302, 0
  br i1 %c.b277, label %b277.t565, label %b277.e566
b277.t565:
  br label %b278
b277.e566:
  br label %b279
b278:
  %v1303 = add i64 0, 34
  call void @"rt.panic"(i64 %v1303)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b279:
  %v1304 = add i64 0, 63
  %v1305.c = icmp sgt i64 %v1299, %v1304
  %v1305 = zext i1 %v1305.c to i64
  %c.b279 = icmp ne i64 %v1305, 0
  br i1 %c.b279, label %b279.t567, label %b279.e568
b279.t567:
  br label %b281
b279.e568:
  br label %b282
b280:
  %v1300 = phi i64 [ %v1307, %b281 ], [ %v1308, %b282 ]
  %v1309 = add i64 0, 0
  %v1310.c = icmp eq i64 %v1300, %v1309
  %v1310 = zext i1 %v1310.c to i64
  %c.b280 = icmp ne i64 %v1310, 0
  br i1 %c.b280, label %b280.t569, label %b280.e570
b280.t569:
  br label %b283
b280.e570:
  br label %b284
b281:
  %v1306 = add i64 0, 63
  %v1307.n = and i64 %v1306, 63
  %v1307 = ashr i64 %v1298, %v1307.n
  br label %b280
b282:
  %v1308.n = and i64 %v1299, 63
  %v1308 = ashr i64 %v1298, %v1308.n
  br label %b280
b283:
  br label %b285
b284:
  %v1311 = add i64 0, 0
  br label %b285
b285:
  %v1312 = phi i64 [ %v1298, %b283 ], [ %v1311, %b284 ]
  %st570 = getelementptr i64, ptr %v1286, i64 0
  store i64 %v1312, ptr %st570
  %v1515 = getelementptr i64, ptr @"rt.meta", i64 0
  %st571 = getelementptr i64, ptr %v1515, i64 0
  store i64 %v1287, ptr %st571
  br label %b275
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
  %v20 = add i64 0, 41
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
  %v137 = add i64 0, 42
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
  %v13 = add i64 0, 36
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
  %v43 = add i64 0, 37
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
  %v47 = add i64 0, 38
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
  %v58 = add i64 0, 39
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
  %v91 = add i64 0, 40
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
  %v12 = add i64 0, 4
  %v13.c = icmp eq i64 %v0, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b4 = icmp ne i64 %v13, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v14.p = getelementptr i64, ptr %v7, i64 0
  %v14 = load i64, ptr %v14.p
  ret i64 %v14
b6:
  %v15 = add i64 0, 5
  %v16.c = icmp eq i64 %v0, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b6 = icmp ne i64 %v16, 0
  br i1 %c.b6, label %b6.t7, label %b6.e8
b6.t7:
  br label %b7
b6.e8:
  br label %b8
b7:
  %st8 = getelementptr i64, ptr %v7, i64 0
  store i64 %v3, ptr %st8
  ret i64 %v8
b8:
  %v17 = add i64 0, 3
  %v18.c = icmp eq i64 %v0, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b8 = icmp ne i64 %v18, 0
  br i1 %c.b8, label %b8.t10, label %b8.e11
b8.t10:
  br label %b9
b8.e11:
  br label %b10
b9:
  %st11 = getelementptr i64, ptr %v7, i64 0
  store i64 %v8, ptr %st11
  ret i64 %v8
b10:
  %v19.p = getelementptr i64, ptr %v7, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.c = icmp ne i64 %v19, %v8
  %v20 = zext i1 %v20.c to i64
  %c.b10 = icmp ne i64 %v20, 0
  br i1 %c.b10, label %b10.t13, label %b10.e14
b10.t13:
  br label %b11
b10.e14:
  br label %b12
b11:
  ret i64 %v8
b12:
  %st14 = getelementptr i64, ptr %v7, i64 0
  store i64 %v9, ptr %st14
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
  %v37 = add i64 0, 35
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
