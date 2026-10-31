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
@"str.1" = internal constant [1 x i64] [i64 6712937]
@"str.2" = internal constant [1 x i64] [i64 7233902]
@"str.3" = internal constant [1 x i64] [i64 8751735898823356009]
@"str.4" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.5" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.6" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.7" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.8" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.9" = internal constant [1 x i64] [i64 2685]
@"str.10" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.11" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.12" = internal constant [1 x i64] [i64 35899498962976]
@"str.13" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.14" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [71 x i64] [i64 4503599862251521, i64 7881299633111042, i64 7881299633111042, i64 7881299633111042, i64 5348025379586311, i64 7599825444929793, i64 6755400531575041, i64 10977525182234881, i64 7318350585659649, i64 11540475236319489, i64 7881300555858177, i64 6473925840077057, i64 8444250727383297, i64 12666375378043137, i64 9007200697581825, i64 6755401085223169, i64 10977525735883009, i64 7881301042397441, i64 12103425693057281, i64 5910976222200065, i64 8444251096482049, i64 12666375747141889, i64 9007201066680577, i64 6755405464076801, i64 10977530114736641, i64 4503605667168769, i64 7881305740018177, i64 12103430390678017, i64 16888504994759169, i64 3659181106135553, i64 9007205730746881, i64 10696055607788033, i64 6755406118388225, i64 10977530769048065, i64 7881306075562497, i64 12103430726222337, i64 5910981255365121, i64 8444256163201537, i64 12666380813861377, i64 9851631080309249, i64 5348031905923585, i64 6755406823031297, i64 8725732012327425, i64 5629508090593796, i64 6755408316203524, i64 4222133710356996, i64 6755408836297217, i64 4222134180119041, i64 2814759313342977, i64 5629509617320449, i64 6755409524163076, i64 3940659773833729, i64 7881309682663937, i64 6192460527043073, i64 8162785548567041, i64 3659186105745921, i64 5910985919431169, i64 6755410866340353, i64 8725735703314945, i64 4222136260493825, i64 10977535701549569, i64 3940661317337601, i64 3940661367669249, i64 8725731207021313, i64 14073755764523777, i64 4222131663536897, i64 8444256800736001, i64 5348032191136513, i64 16607031276339969, i64 19984731063976705, i64 28428980365296385]
@"str.15" = internal constant [1 x i64] [i64 9071397899755888]
@"str.16" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.17" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.18" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.19" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.20" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.21" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.22" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.23" = internal constant [1 x i64] [i64 544497952]
@"str.24" = internal constant [3 x i64] [i64 7810191132246109286, i64 8030813629394153065, i64 7497058]
@"str.25" = internal constant [3 x i64] [i64 8533880815701226611, i64 8533880815702274661, i64 125779768734510]
@"str.26" = internal constant [5 x i64] [i64 7310589493174891635, i64 8028904589562572402, i64 7810982780818846817, i64 8299699176509563247, i64 1919246959]
@"str.27" = internal constant [4 x i64] [i64 7598263559392621683, i64 7598263559393601390, i64 7305524086039603054, i64 114]

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
  %v3 = getelementptr i64, ptr @"str.4", i64 0
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
  %v29 = getelementptr i64, ptr @"str.8", i64 0
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
  %v35 = getelementptr i64, ptr @"str.9", i64 0
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
  %v10 = getelementptr i64, ptr @"str.5", i64 0
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
  %v17 = getelementptr i64, ptr @"str.6", i64 0
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
  %v24 = getelementptr i64, ptr @"str.7", i64 0
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
  %v60 = getelementptr i64, ptr @"str.10", i64 0
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
  %v65 = getelementptr i64, ptr @"str.11", i64 0
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
  %v70 = getelementptr i64, ptr @"str.9", i64 0
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
  %v81 = getelementptr i64, ptr @"str.12", i64 0
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
  %v88 = getelementptr i64, ptr @"str.13", i64 0
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
  %v17 = getelementptr i64, ptr @"str.14", i64 0
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
  %v22 = getelementptr i64, ptr @"str.9", i64 0
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
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s6 = alloca [9 x i64], align 8
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
  %s6.z7 = getelementptr i64, ptr %s6, i64 7
  store i64 0, ptr %s6.z7
  %s6.z8 = getelementptr i64, ptr %s6, i64 8
  store i64 0, ptr %s6.z8
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
  %v132 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v132, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  call void @"std/io.ReadStdin"(ptr %v1)
  %v2 = add i64 0, 3
  %v3 = getelementptr i64, ptr %v1, i64 %v2
  %v4 = getelementptr i64, ptr %s1, i64 0
  %v5.p = getelementptr i64, ptr %v1, i64 0
  %v5 = load i64, ptr %v5.p
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v5, ptr %st0
  %v6.p = getelementptr i64, ptr %v1, i64 1
  %v6 = load i64, ptr %v6.p
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v6, ptr %st1
  %v7.p = getelementptr i64, ptr %v1, i64 2
  %v7 = load i64, ptr %v7.p
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v7, ptr %st2
  %v8 = getelementptr i64, ptr %s2, i64 0
  %v9.p = getelementptr i64, ptr %v3, i64 0
  %v9 = load i64, ptr %v9.p
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st3
  %v10.p = getelementptr i64, ptr %v3, i64 1
  %v10 = load i64, ptr %v10.p
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v10, ptr %st4
  %v11.p = getelementptr i64, ptr %v3, i64 2
  %v11 = load i64, ptr %v11.p
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v11, ptr %st5
  %v12.p = getelementptr i64, ptr %v3, i64 3
  %v12 = load i64, ptr %v12.p
  %st6 = getelementptr i64, ptr %v8, i64 3
  store i64 %v12, ptr %st6
  %v13.p = getelementptr i64, ptr %v3, i64 4
  %v13 = load i64, ptr %v13.p
  %st7 = getelementptr i64, ptr %v8, i64 4
  store i64 %v13, ptr %st7
  %v14.p = getelementptr i64, ptr %v3, i64 5
  %v14 = load i64, ptr %v14.p
  %st8 = getelementptr i64, ptr %v8, i64 5
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v8, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 0
  %v17.c = icmp ne i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b0 = icmp ne i64 %v17, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v18 = add i64 0, 1
  %v19 = getelementptr i64, ptr %v8, i64 %v18
  %v20 = getelementptr i64, ptr %s3, i64 0
  %v21.p = getelementptr i64, ptr %v19, i64 0
  %v21 = load i64, ptr %v21.p
  %st11 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st11
  %v22.p = getelementptr i64, ptr %v19, i64 1
  %v22 = load i64, ptr %v22.p
  %st12 = getelementptr i64, ptr %v20, i64 1
  store i64 %v22, ptr %st12
  %v23.p = getelementptr i64, ptr %v19, i64 2
  %v23 = load i64, ptr %v23.p
  %st13 = getelementptr i64, ptr %v20, i64 2
  store i64 %v23, ptr %st13
  %v24.p = getelementptr i64, ptr %v19, i64 3
  %v24 = load i64, ptr %v24.p
  %st14 = getelementptr i64, ptr %v20, i64 3
  store i64 %v24, ptr %st14
  %v25.p = getelementptr i64, ptr %v19, i64 4
  %v25 = load i64, ptr %v25.p
  %st15 = getelementptr i64, ptr %v20, i64 4
  store i64 %v25, ptr %st15
  %v26 = add i64 0, 1
  %v133 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v133, i64 0
  store i64 %v0, ptr %st16
  ret i64 %v26
b2:
  br label %b3
b3:
  %v27 = phi ptr [ %v4, %b2 ]
  %v28 = getelementptr i64, ptr %s4, i64 0
  %v29.p = getelementptr i64, ptr %v27, i64 0
  %v29 = load i64, ptr %v29.p
  %st17 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st17
  %v30.p = getelementptr i64, ptr %v27, i64 1
  %v30 = load i64, ptr %v30.p
  %st18 = getelementptr i64, ptr %v28, i64 1
  store i64 %v30, ptr %st18
  %v31.p = getelementptr i64, ptr %v27, i64 2
  %v31 = load i64, ptr %v31.p
  %st19 = getelementptr i64, ptr %v28, i64 2
  store i64 %v31, ptr %st19
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s5, i64 0
  %st20 = getelementptr i64, ptr %v33, i64 0
  store i64 %v32, ptr %st20
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v134, i64 0
  %v34 = load i64, ptr %v34.p
  br label %b4
b4:
  %v135 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v135, i64 0
  store i64 %v34, ptr %st21
  %v35.p = getelementptr i64, ptr %v33, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v28, i64 1
  %v36 = load i64, ptr %v36.p
  %v37.c = icmp slt i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b4 = icmp ne i64 %v37, 0
  br i1 %c.b4, label %b4.t23, label %b4.e24
b4.t23:
  br label %b5
b4.e24:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v136, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v33, i64 0
  %v39 = load i64, ptr %v39.p
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v137, i64 0
  %v40 = load i64, ptr %v40.p
  br label %b7
b6:
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v138, i64 0
  store i64 %v34, ptr %st24
  %v131 = add i64 0, 0
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v139, i64 0
  store i64 %v0, ptr %st25
  ret i64 %v131
b7:
  %v140 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v140, i64 0
  store i64 %v40, ptr %st26
  %v41.p = getelementptr i64, ptr %v33, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v28, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.c = icmp uge i64 %v41, %v42
  %v43 = zext i1 %v43.c to i64
  %c.b7 = icmp ne i64 %v43, 0
  br i1 %c.b7, label %b7.t28, label %b7.e29
b7.t28:
  br label %b10
b7.e29:
  br label %b11
b8:
  call void @"rt.region_enter"()
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v141, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 1
  %v53.p = getelementptr i64, ptr %v33, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 %v53, %v52
  %st29 = getelementptr i64, ptr %v33, i64 0
  store i64 %v54, ptr %st29
  br label %b7
b9:
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v142, i64 0
  store i64 %v40, ptr %st30
  %v55 = getelementptr i64, ptr %s6, i64 0
  %v56.p = getelementptr i64, ptr %v33, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 0
  %v58.c = icmp slt i64 %v39, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b9 = icmp ne i64 %v58, 0
  br i1 %c.b9, label %b9.t32, label %b9.e33
b9.t32:
  br label %b12
b9.e33:
  br label %b13
b10:
  %v44 = add i64 0, 0
  call void @"rt.panic"(i64 %v44)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v45.p = getelementptr i64, ptr %v28, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = inttoptr i64 %v45 to ptr
  %v47 = getelementptr i8, ptr %v46, i64 %v41
  %v48.p = getelementptr i8, ptr %v47, i64 0
  %v48.b = load i8, ptr %v48.p
  %v48 = zext i8 %v48.b to i64
  %v49 = add i64 0, 10
  %v50.c = icmp ne i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b11 = icmp ne i64 %v50, 0
  br i1 %c.b11, label %b11.t34, label %b11.e35
b11.t34:
  br label %b8
b11.e35:
  br label %b9
b12:
  %v59 = add i64 0, 1
  call void @"rt.panic"(i64 %v59)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v60.c = icmp slt i64 %v56, %v39
  %v60 = zext i1 %v60.c to i64
  %c.b13 = icmp ne i64 %v60, 0
  br i1 %c.b13, label %b13.t36, label %b13.e37
b13.t36:
  br label %b14
b13.e37:
  br label %b15
b14:
  %v61 = add i64 0, 2
  call void @"rt.panic"(i64 %v61)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v62.p = getelementptr i64, ptr %v28, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.c = icmp sgt i64 %v56, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b15 = icmp ne i64 %v63, 0
  br i1 %c.b15, label %b15.t38, label %b15.e39
b15.t38:
  br label %b16
b15.e39:
  br label %b17
b16:
  %v64 = add i64 0, 3
  call void @"rt.panic"(i64 %v64)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v65.p = getelementptr i64, ptr %v28, i64 0
  %v65 = load i64, ptr %v65.p
  %v66 = inttoptr i64 %v65 to ptr
  %v67 = getelementptr i8, ptr %v66, i64 %v39
  %v68 = sub i64 %v56, %v39
  %v69.p = getelementptr i64, ptr %v28, i64 2
  %v69 = load i64, ptr %v69.p
  %v70 = getelementptr i64, ptr %s7, i64 0
  %v71 = ptrtoint ptr %v67 to i64
  %st39 = getelementptr i64, ptr %v70, i64 0
  store i64 %v71, ptr %st39
  %st40 = getelementptr i64, ptr %v70, i64 1
  store i64 %v68, ptr %st40
  %st41 = getelementptr i64, ptr %v70, i64 2
  store i64 %v69, ptr %st41
  %v72.p = getelementptr i64, ptr %v70, i64 0
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v70, i64 1
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v70, i64 2
  %v74 = load i64, ptr %v74.p
  call void @"std/internal/utf8.Parse"(ptr %v55, i64 %v72, i64 %v73, i64 %v74)
  %v75 = add i64 0, 3
  %v76 = getelementptr i64, ptr %v55, i64 %v75
  %v77 = getelementptr i64, ptr %s8, i64 0
  %v78.p = getelementptr i64, ptr %v55, i64 0
  %v78 = load i64, ptr %v78.p
  %st42 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st42
  %v79.p = getelementptr i64, ptr %v55, i64 1
  %v79 = load i64, ptr %v79.p
  %st43 = getelementptr i64, ptr %v77, i64 1
  store i64 %v79, ptr %st43
  %v80.p = getelementptr i64, ptr %v55, i64 2
  %v80 = load i64, ptr %v80.p
  %st44 = getelementptr i64, ptr %v77, i64 2
  store i64 %v80, ptr %st44
  %v81 = getelementptr i64, ptr %s9, i64 0
  %v82.p = getelementptr i64, ptr %v76, i64 0
  %v82 = load i64, ptr %v82.p
  %st45 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st45
  %v83.p = getelementptr i64, ptr %v76, i64 1
  %v83 = load i64, ptr %v83.p
  %st46 = getelementptr i64, ptr %v81, i64 1
  store i64 %v83, ptr %st46
  %v84.p = getelementptr i64, ptr %v76, i64 2
  %v84 = load i64, ptr %v84.p
  %st47 = getelementptr i64, ptr %v81, i64 2
  store i64 %v84, ptr %st47
  %v85.p = getelementptr i64, ptr %v76, i64 3
  %v85 = load i64, ptr %v85.p
  %st48 = getelementptr i64, ptr %v81, i64 3
  store i64 %v85, ptr %st48
  %v86.p = getelementptr i64, ptr %v76, i64 4
  %v86 = load i64, ptr %v86.p
  %st49 = getelementptr i64, ptr %v81, i64 4
  store i64 %v86, ptr %st49
  %v87.p = getelementptr i64, ptr %v76, i64 5
  %v87 = load i64, ptr %v87.p
  %st50 = getelementptr i64, ptr %v81, i64 5
  store i64 %v87, ptr %st50
  %v88 = getelementptr i64, ptr %s10, i64 0
  %v89.p = getelementptr i64, ptr %v77, i64 0
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v77, i64 1
  %v90 = load i64, ptr %v90.p
  %v91.p = getelementptr i64, ptr %v77, i64 2
  %v91 = load i64, ptr %v91.p
  call void @"std/convert.ParseFloat"(ptr %v88, i64 %v89, i64 %v90, i64 %v91)
  %v92.p = getelementptr i64, ptr %v88, i64 0
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 1
  %v94 = getelementptr i64, ptr %v88, i64 %v93
  %v95 = getelementptr i64, ptr %s11, i64 0
  %v96.p = getelementptr i64, ptr %v94, i64 0
  %v96 = load i64, ptr %v96.p
  %st51 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st51
  %v97.p = getelementptr i64, ptr %v94, i64 1
  %v97 = load i64, ptr %v97.p
  %st52 = getelementptr i64, ptr %v95, i64 1
  store i64 %v97, ptr %st52
  %v98.p = getelementptr i64, ptr %v94, i64 2
  %v98 = load i64, ptr %v98.p
  %st53 = getelementptr i64, ptr %v95, i64 2
  store i64 %v98, ptr %st53
  %v99.p = getelementptr i64, ptr %v94, i64 3
  %v99 = load i64, ptr %v99.p
  %st54 = getelementptr i64, ptr %v95, i64 3
  store i64 %v99, ptr %st54
  %v100.p = getelementptr i64, ptr %v94, i64 4
  %v100 = load i64, ptr %v100.p
  %st55 = getelementptr i64, ptr %v95, i64 4
  store i64 %v100, ptr %st55
  %v101.p = getelementptr i64, ptr %v94, i64 5
  %v101 = load i64, ptr %v101.p
  %st56 = getelementptr i64, ptr %v95, i64 5
  store i64 %v101, ptr %st56
  %v102 = call i64 @"std/math.Bits"(i64 %v92)
  %v103.p = getelementptr i64, ptr %v95, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105.c = icmp ne i64 %v103, %v104
  %v105 = zext i1 %v105.c to i64
  %c.b17 = icmp ne i64 %v105, 0
  br i1 %c.b17, label %b17.t58, label %b17.e59
b17.t58:
  br label %b18
b17.e59:
  br label %b19
b18:
  %v106 = add i64 0, 1
  %v107 = getelementptr i64, ptr %v95, i64 %v106
  %v108 = getelementptr i64, ptr %s3, i64 0
  %v109.p = getelementptr i64, ptr %v107, i64 0
  %v109 = load i64, ptr %v109.p
  %st59 = getelementptr i64, ptr %v108, i64 0
  store i64 %v109, ptr %st59
  %v110.p = getelementptr i64, ptr %v107, i64 1
  %v110 = load i64, ptr %v110.p
  %st60 = getelementptr i64, ptr %v108, i64 1
  store i64 %v110, ptr %st60
  %v111.p = getelementptr i64, ptr %v107, i64 2
  %v111 = load i64, ptr %v111.p
  %st61 = getelementptr i64, ptr %v108, i64 2
  store i64 %v111, ptr %st61
  %v112.p = getelementptr i64, ptr %v107, i64 3
  %v112 = load i64, ptr %v112.p
  %st62 = getelementptr i64, ptr %v108, i64 3
  store i64 %v112, ptr %st62
  %v113.p = getelementptr i64, ptr %v107, i64 4
  %v113 = load i64, ptr %v113.p
  %st63 = getelementptr i64, ptr %v108, i64 4
  store i64 %v113, ptr %st63
  %v114.p = getelementptr i64, ptr %v108, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp eq i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b18 = icmp ne i64 %v116, 0
  br i1 %c.b18, label %b18.t65, label %b18.e66
b18.t65:
  br label %b21
b18.e66:
  br label %b20
b19:
  %v120 = add i64 0, 0
  br label %b23
b20:
  %v118 = add i64 0, 2
  br label %b22
b21:
  %v117 = add i64 0, 1
  br label %b22
b22:
  %v119 = phi i64 [ %v118, %b20 ], [ %v117, %b21 ]
  br label %b23
b23:
  %v121 = phi i64 [ %v120, %b19 ], [ %v119, %b22 ]
  %v122 = add i64 0, 1
  %v123.c = icmp eq i64 %v121, %v122
  %v123 = zext i1 %v123.c to i64
  %c.b23 = icmp ne i64 %v123, 0
  br i1 %c.b23, label %b23.t67, label %b23.e68
b23.t67:
  br label %b24
b23.e68:
  br label %b25
b24:
  %v124 = add i64 0, 0
  br label %b26
b25:
  br label %b26
b26:
  %v125 = phi i64 [ %v124, %b24 ], [ %v102, %b25 ]
  call void @"rt.print_int"(i64 %v125)
  %v126 = add i64 0, 32
  call void @"rt.print_char"(i64 %v126)
  call void @"rt.print_int"(i64 %v121)
  %v127 = add i64 0, 10
  call void @"rt.print_char"(i64 %v127)
  %v128 = add i64 0, 1
  %v129.p = getelementptr i64, ptr %v33, i64 0
  %v129 = load i64, ptr %v129.p
  %v130 = add i64 %v129, %v128
  %st68 = getelementptr i64, ptr %v33, i64 0
  store i64 %v130, ptr %st68
  br label %b4
}

define internal void @"std/convert.ParseFloat"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [2 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v134, i64 0
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
  call void @"std/convert.fastFloat"(ptr %v16, i64 %v17, i64 %v18, i64 %v19)
  %v20.p = getelementptr i64, ptr %v16, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 1
  %v21 = load i64, ptr %v21.p
  %c.b0 = icmp ne i64 %v20, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v22 = getelementptr i64, ptr %s2, i64 0
  %v23 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st6
  %st7 = getelementptr i64, ptr %v0, i64 0
  store i64 %v21, ptr %st7
  %v24.p = getelementptr i64, ptr %v22, i64 0
  %v24 = load i64, ptr %v24.p
  %st8 = getelementptr i64, ptr %v0, i64 1
  store i64 %v24, ptr %st8
  %v25.p = getelementptr i64, ptr %v22, i64 1
  %v25 = load i64, ptr %v25.p
  %st9 = getelementptr i64, ptr %v0, i64 2
  store i64 %v25, ptr %st9
  %v26.p = getelementptr i64, ptr %v22, i64 2
  %v26 = load i64, ptr %v26.p
  %st10 = getelementptr i64, ptr %v0, i64 3
  store i64 %v26, ptr %st10
  %v27.p = getelementptr i64, ptr %v22, i64 3
  %v27 = load i64, ptr %v27.p
  %st11 = getelementptr i64, ptr %v0, i64 4
  store i64 %v27, ptr %st11
  %v28.p = getelementptr i64, ptr %v22, i64 4
  %v28 = load i64, ptr %v28.p
  %st12 = getelementptr i64, ptr %v0, i64 5
  store i64 %v28, ptr %st12
  %v29.p = getelementptr i64, ptr %v22, i64 5
  %v29 = load i64, ptr %v29.p
  %st13 = getelementptr i64, ptr %v0, i64 6
  store i64 %v29, ptr %st13
  %v30.p = getelementptr i64, ptr %v0, i64 1
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 0
  %v32.c = icmp ne i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b1 = icmp ne i64 %v32, 0
  br i1 %c.b1, label %b1.t15, label %b1.e16
b1.t15:
  br label %b3
b1.e16:
  br label %b4
b2:
  br label %b5
b3:
  %v33 = add i64 0, 2
  %v34 = getelementptr i64, ptr %v0, i64 %v33
  call void @"rt.err_relocate"(ptr %v34, i64 %v5)
  br label %b4
b4:
  %v135 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v135, i64 0
  store i64 %v5, ptr %st16
  ret void
b5:
  %v35 = getelementptr i64, ptr %s3, i64 0
  %v36.p = getelementptr i64, ptr %v4, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v4, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v4, i64 2
  %v38 = load i64, ptr %v38.p
  call void @"std/internal/floatfmt.ParseBits"(ptr %v35, i64 %v36, i64 %v37, i64 %v38)
  %v39.p = getelementptr i64, ptr %v35, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 1
  %v41 = getelementptr i64, ptr %v35, i64 %v40
  %v42 = getelementptr i64, ptr %s2, i64 0
  %v43.p = getelementptr i64, ptr %v41, i64 0
  %v43 = load i64, ptr %v43.p
  %st17 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st17
  %v44.p = getelementptr i64, ptr %v41, i64 1
  %v44 = load i64, ptr %v44.p
  %st18 = getelementptr i64, ptr %v42, i64 1
  store i64 %v44, ptr %st18
  %v45.p = getelementptr i64, ptr %v41, i64 2
  %v45 = load i64, ptr %v45.p
  %st19 = getelementptr i64, ptr %v42, i64 2
  store i64 %v45, ptr %st19
  %v46.p = getelementptr i64, ptr %v41, i64 3
  %v46 = load i64, ptr %v46.p
  %st20 = getelementptr i64, ptr %v42, i64 3
  store i64 %v46, ptr %st20
  %v47.p = getelementptr i64, ptr %v41, i64 4
  %v47 = load i64, ptr %v47.p
  %st21 = getelementptr i64, ptr %v42, i64 4
  store i64 %v47, ptr %st21
  %v48.p = getelementptr i64, ptr %v41, i64 5
  %v48 = load i64, ptr %v48.p
  %st22 = getelementptr i64, ptr %v42, i64 5
  store i64 %v48, ptr %st22
  %v49.p = getelementptr i64, ptr %v42, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.c = icmp ne i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b5 = icmp ne i64 %v51, 0
  br i1 %c.b5, label %b5.t24, label %b5.e25
b5.t24:
  br label %b6
b5.e25:
  br label %b7
b6:
  %v52 = add i64 0, 1
  %v53 = getelementptr i64, ptr %v42, i64 %v52
  %v54 = getelementptr i64, ptr %s4, i64 0
  %v55.p = getelementptr i64, ptr %v53, i64 0
  %v55 = load i64, ptr %v55.p
  %st25 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st25
  %v56.p = getelementptr i64, ptr %v53, i64 1
  %v56 = load i64, ptr %v56.p
  %st26 = getelementptr i64, ptr %v54, i64 1
  store i64 %v56, ptr %st26
  %v57.p = getelementptr i64, ptr %v53, i64 2
  %v57 = load i64, ptr %v57.p
  %st27 = getelementptr i64, ptr %v54, i64 2
  store i64 %v57, ptr %st27
  %v58.p = getelementptr i64, ptr %v53, i64 3
  %v58 = load i64, ptr %v58.p
  %st28 = getelementptr i64, ptr %v54, i64 3
  store i64 %v58, ptr %st28
  %v59.p = getelementptr i64, ptr %v53, i64 4
  %v59 = load i64, ptr %v59.p
  %st29 = getelementptr i64, ptr %v54, i64 4
  store i64 %v59, ptr %st29
  %v60.p = getelementptr i64, ptr %v54, i64 0
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 11
  %v62.c = icmp eq i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b6 = icmp ne i64 %v62, 0
  br i1 %c.b6, label %b6.t31, label %b6.e32
b6.t31:
  br label %b9
b6.e32:
  br label %b8
b7:
  br label %b20
b8:
  %v64.p = getelementptr i64, ptr %v54, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 12
  %v66.c = icmp eq i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b8 = icmp ne i64 %v66, 0
  br i1 %c.b8, label %b8.t33, label %b8.e34
b8.t33:
  br label %b11
b8.e34:
  br label %b10
b9:
  %v63 = add i64 0, 1
  br label %b12
b10:
  %v68 = add i64 0, 4
  call void @"rt.panic"(i64 %v68)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v67 = add i64 0, 0
  br label %b12
b12:
  %v69 = phi i64 [ %v63, %b9 ], [ %v67, %b11 ]
  %c.b12 = icmp ne i64 %v69, 0
  br i1 %c.b12, label %b12.t35, label %b12.e36
b12.t35:
  br label %b13
b12.e36:
  br label %b14
b13:
  %v70 = add i64 0, 0
  %v71 = getelementptr i64, ptr %s5, i64 0
  %v72 = add i64 0, 0
  %st36 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st36
  %st37 = getelementptr i64, ptr %v71, i64 1
  store i64 %v72, ptr %st37
  %v73 = add i64 0, 0
  %st38 = getelementptr i64, ptr %v71, i64 0
  store i64 %v73, ptr %st38
  %v74 = getelementptr i64, ptr %s6, i64 0
  %v75.p = getelementptr i64, ptr %v71, i64 0
  %v75 = load i64, ptr %v75.p
  %st39 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st39
  %v76.p = getelementptr i64, ptr %v71, i64 1
  %v76 = load i64, ptr %v76.p
  %st40 = getelementptr i64, ptr %v74, i64 1
  store i64 %v76, ptr %st40
  %v77 = add i64 0, 0
  %st41 = getelementptr i64, ptr %v74, i64 2
  store i64 %v77, ptr %st41
  %st42 = getelementptr i64, ptr %v74, i64 3
  store i64 %v77, ptr %st42
  %st43 = getelementptr i64, ptr %v74, i64 4
  store i64 %v77, ptr %st43
  %v78 = getelementptr i64, ptr %s7, i64 0
  %v79 = add i64 0, 1
  %st44 = getelementptr i64, ptr %v78, i64 0
  store i64 %v79, ptr %st44
  %v80.p = getelementptr i64, ptr %v74, i64 0
  %v80 = load i64, ptr %v80.p
  %st45 = getelementptr i64, ptr %v78, i64 1
  store i64 %v80, ptr %st45
  %v81.p = getelementptr i64, ptr %v74, i64 1
  %v81 = load i64, ptr %v81.p
  %st46 = getelementptr i64, ptr %v78, i64 2
  store i64 %v81, ptr %st46
  %v82.p = getelementptr i64, ptr %v74, i64 2
  %v82 = load i64, ptr %v82.p
  %st47 = getelementptr i64, ptr %v78, i64 3
  store i64 %v82, ptr %st47
  %v83.p = getelementptr i64, ptr %v74, i64 3
  %v83 = load i64, ptr %v83.p
  %st48 = getelementptr i64, ptr %v78, i64 4
  store i64 %v83, ptr %st48
  %v84.p = getelementptr i64, ptr %v74, i64 4
  %v84 = load i64, ptr %v84.p
  %st49 = getelementptr i64, ptr %v78, i64 5
  store i64 %v84, ptr %st49
  %st50 = getelementptr i64, ptr %v0, i64 0
  store i64 %v70, ptr %st50
  %v85.p = getelementptr i64, ptr %v78, i64 0
  %v85 = load i64, ptr %v85.p
  %st51 = getelementptr i64, ptr %v0, i64 1
  store i64 %v85, ptr %st51
  %v86.p = getelementptr i64, ptr %v78, i64 1
  %v86 = load i64, ptr %v86.p
  %st52 = getelementptr i64, ptr %v0, i64 2
  store i64 %v86, ptr %st52
  %v87.p = getelementptr i64, ptr %v78, i64 2
  %v87 = load i64, ptr %v87.p
  %st53 = getelementptr i64, ptr %v0, i64 3
  store i64 %v87, ptr %st53
  %v88.p = getelementptr i64, ptr %v78, i64 3
  %v88 = load i64, ptr %v88.p
  %st54 = getelementptr i64, ptr %v0, i64 4
  store i64 %v88, ptr %st54
  %v89.p = getelementptr i64, ptr %v78, i64 4
  %v89 = load i64, ptr %v89.p
  %st55 = getelementptr i64, ptr %v0, i64 5
  store i64 %v89, ptr %st55
  %v90.p = getelementptr i64, ptr %v78, i64 5
  %v90 = load i64, ptr %v90.p
  %st56 = getelementptr i64, ptr %v0, i64 6
  store i64 %v90, ptr %st56
  %v91.p = getelementptr i64, ptr %v0, i64 1
  %v91 = load i64, ptr %v91.p
  %v92 = add i64 0, 0
  %v93.c = icmp ne i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b13 = icmp ne i64 %v93, 0
  br i1 %c.b13, label %b13.t58, label %b13.e59
b13.t58:
  br label %b15
b13.e59:
  br label %b16
b14:
  br label %b17
b15:
  %v94 = add i64 0, 2
  %v95 = getelementptr i64, ptr %v0, i64 %v94
  call void @"rt.err_relocate"(ptr %v95, i64 %v5)
  br label %b16
b16:
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v136, i64 0
  store i64 %v5, ptr %st59
  ret void
b17:
  %v96 = getelementptr i64, ptr %s5, i64 0
  %v97 = add i64 0, 0
  %st60 = getelementptr i64, ptr %v96, i64 0
  store i64 %v97, ptr %st60
  %st61 = getelementptr i64, ptr %v96, i64 1
  store i64 %v97, ptr %st61
  %v98 = add i64 0, 1
  %st62 = getelementptr i64, ptr %v96, i64 0
  store i64 %v98, ptr %st62
  %v99 = getelementptr i64, ptr %s6, i64 0
  %v100.p = getelementptr i64, ptr %v96, i64 0
  %v100 = load i64, ptr %v100.p
  %st63 = getelementptr i64, ptr %v99, i64 0
  store i64 %v100, ptr %st63
  %v101.p = getelementptr i64, ptr %v96, i64 1
  %v101 = load i64, ptr %v101.p
  %st64 = getelementptr i64, ptr %v99, i64 1
  store i64 %v101, ptr %st64
  %v102 = add i64 0, 0
  %st65 = getelementptr i64, ptr %v99, i64 2
  store i64 %v102, ptr %st65
  %st66 = getelementptr i64, ptr %v99, i64 3
  store i64 %v102, ptr %st66
  %st67 = getelementptr i64, ptr %v99, i64 4
  store i64 %v102, ptr %st67
  %v103 = getelementptr i64, ptr %s7, i64 0
  %v104 = add i64 0, 1
  %st68 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st68
  %v105.p = getelementptr i64, ptr %v99, i64 0
  %v105 = load i64, ptr %v105.p
  %st69 = getelementptr i64, ptr %v103, i64 1
  store i64 %v105, ptr %st69
  %v106.p = getelementptr i64, ptr %v99, i64 1
  %v106 = load i64, ptr %v106.p
  %st70 = getelementptr i64, ptr %v103, i64 2
  store i64 %v106, ptr %st70
  %v107.p = getelementptr i64, ptr %v99, i64 2
  %v107 = load i64, ptr %v107.p
  %st71 = getelementptr i64, ptr %v103, i64 3
  store i64 %v107, ptr %st71
  %v108.p = getelementptr i64, ptr %v99, i64 3
  %v108 = load i64, ptr %v108.p
  %st72 = getelementptr i64, ptr %v103, i64 4
  store i64 %v108, ptr %st72
  %v109.p = getelementptr i64, ptr %v99, i64 4
  %v109 = load i64, ptr %v109.p
  %st73 = getelementptr i64, ptr %v103, i64 5
  store i64 %v109, ptr %st73
  %st74 = getelementptr i64, ptr %v0, i64 0
  store i64 %v39, ptr %st74
  %v110.p = getelementptr i64, ptr %v103, i64 0
  %v110 = load i64, ptr %v110.p
  %st75 = getelementptr i64, ptr %v0, i64 1
  store i64 %v110, ptr %st75
  %v111.p = getelementptr i64, ptr %v103, i64 1
  %v111 = load i64, ptr %v111.p
  %st76 = getelementptr i64, ptr %v0, i64 2
  store i64 %v111, ptr %st76
  %v112.p = getelementptr i64, ptr %v103, i64 2
  %v112 = load i64, ptr %v112.p
  %st77 = getelementptr i64, ptr %v0, i64 3
  store i64 %v112, ptr %st77
  %v113.p = getelementptr i64, ptr %v103, i64 3
  %v113 = load i64, ptr %v113.p
  %st78 = getelementptr i64, ptr %v0, i64 4
  store i64 %v113, ptr %st78
  %v114.p = getelementptr i64, ptr %v103, i64 4
  %v114 = load i64, ptr %v114.p
  %st79 = getelementptr i64, ptr %v0, i64 5
  store i64 %v114, ptr %st79
  %v115.p = getelementptr i64, ptr %v103, i64 5
  %v115 = load i64, ptr %v115.p
  %st80 = getelementptr i64, ptr %v0, i64 6
  store i64 %v115, ptr %st80
  %v116.p = getelementptr i64, ptr %v0, i64 1
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 0
  %v118.c = icmp ne i64 %v116, %v117
  %v118 = zext i1 %v118.c to i64
  %c.b17 = icmp ne i64 %v118, 0
  br i1 %c.b17, label %b17.t82, label %b17.e83
b17.t82:
  br label %b18
b17.e83:
  br label %b19
b18:
  %v119 = add i64 0, 2
  %v120 = getelementptr i64, ptr %v0, i64 %v119
  call void @"rt.err_relocate"(ptr %v120, i64 %v5)
  br label %b19
b19:
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v137, i64 0
  store i64 %v5, ptr %st83
  ret void
b20:
  %v121 = getelementptr i64, ptr %s7, i64 0
  %v122 = add i64 0, 0
  %st84 = getelementptr i64, ptr %v121, i64 0
  store i64 %v122, ptr %st84
  %st85 = getelementptr i64, ptr %v0, i64 0
  store i64 %v39, ptr %st85
  %v123.p = getelementptr i64, ptr %v121, i64 0
  %v123 = load i64, ptr %v123.p
  %st86 = getelementptr i64, ptr %v0, i64 1
  store i64 %v123, ptr %st86
  %v124.p = getelementptr i64, ptr %v121, i64 1
  %v124 = load i64, ptr %v124.p
  %st87 = getelementptr i64, ptr %v0, i64 2
  store i64 %v124, ptr %st87
  %v125.p = getelementptr i64, ptr %v121, i64 2
  %v125 = load i64, ptr %v125.p
  %st88 = getelementptr i64, ptr %v0, i64 3
  store i64 %v125, ptr %st88
  %v126.p = getelementptr i64, ptr %v121, i64 3
  %v126 = load i64, ptr %v126.p
  %st89 = getelementptr i64, ptr %v0, i64 4
  store i64 %v126, ptr %st89
  %v127.p = getelementptr i64, ptr %v121, i64 4
  %v127 = load i64, ptr %v127.p
  %st90 = getelementptr i64, ptr %v0, i64 5
  store i64 %v127, ptr %st90
  %v128.p = getelementptr i64, ptr %v121, i64 5
  %v128 = load i64, ptr %v128.p
  %st91 = getelementptr i64, ptr %v0, i64 6
  store i64 %v128, ptr %st91
  %v129.p = getelementptr i64, ptr %v0, i64 1
  %v129 = load i64, ptr %v129.p
  %v130 = add i64 0, 0
  %v131.c = icmp ne i64 %v129, %v130
  %v131 = zext i1 %v131.c to i64
  %c.b20 = icmp ne i64 %v131, 0
  br i1 %c.b20, label %b20.t93, label %b20.e94
b20.t93:
  br label %b21
b20.e94:
  br label %b22
b21:
  %v132 = add i64 0, 2
  %v133 = getelementptr i64, ptr %v0, i64 %v132
  call void @"rt.err_relocate"(ptr %v133, i64 %v5)
  br label %b22
b22:
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %st94 = getelementptr i64, ptr %v138, i64 0
  store i64 %v5, ptr %st94
  ret void
}

define internal void @"std/convert.fastFloat"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v388 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v388, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 0
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v6, ptr %st3
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp sgt i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b0 = icmp ne i64 %v10, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v12 = add i64 0, 0
  %v13.p = getelementptr i64, ptr %v4, i64 1
  %v13 = load i64, ptr %v13.p
  %v14.c = icmp uge i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b1 = icmp ne i64 %v14, 0
  br i1 %c.b1, label %b1.t7, label %b1.e8
b1.t7:
  br label %b3
b1.e8:
  br label %b4
b2:
  %v11 = phi i64 [ %v10, %b0.e6 ], [ %v21, %b4 ]
  %v22.p = getelementptr i64, ptr %v4, i64 1
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 0, 0
  %v24.c = icmp sgt i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b2 = icmp ne i64 %v24, 0
  br i1 %c.b2, label %b2.t9, label %b2.e10
b2.t9:
  br label %b5
b2.e10:
  br label %b6
b3:
  %v15 = add i64 0, 5
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
  %v20 = add i64 0, 45
  %v21.c = icmp eq i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  br label %b2
b5:
  %v26 = add i64 0, 0
  %v27.p = getelementptr i64, ptr %v4, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b5 = icmp ne i64 %v28, 0
  br i1 %c.b5, label %b5.t11, label %b5.e12
b5.t11:
  br label %b7
b5.e12:
  br label %b8
b6:
  %v25 = phi i64 [ %v24, %b2.e10 ], [ %v36, %b10 ]
  %c.b6 = icmp ne i64 %v25, 0
  br i1 %c.b6, label %b6.t13, label %b6.e14
b6.t13:
  br label %b13
b6.e14:
  br label %b14
b7:
  %v29 = add i64 0, 6
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v30.p = getelementptr i64, ptr %v4, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = getelementptr i8, ptr %v31, i64 %v26
  %v33.p = getelementptr i8, ptr %v32, i64 0
  %v33.b = load i8, ptr %v33.p
  %v33 = zext i8 %v33.b to i64
  %v34 = add i64 0, 45
  %v35.c = icmp eq i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b8 = icmp ne i64 %v35, 0
  br i1 %c.b8, label %b8.t15, label %b8.e16
b8.t15:
  br label %b10
b8.e16:
  br label %b9
b9:
  %v37 = add i64 0, 0
  %v38.p = getelementptr i64, ptr %v4, i64 1
  %v38 = load i64, ptr %v38.p
  %v39.c = icmp uge i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b9 = icmp ne i64 %v39, 0
  br i1 %c.b9, label %b9.t17, label %b9.e18
b9.t17:
  br label %b11
b9.e18:
  br label %b12
b10:
  %v36 = phi i64 [ %v35, %b8.t15 ], [ %v46, %b12 ]
  br label %b6
b11:
  %v40 = add i64 0, 7
  call void @"rt.panic"(i64 %v40)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v41.p = getelementptr i64, ptr %v4, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = inttoptr i64 %v41 to ptr
  %v43 = getelementptr i8, ptr %v42, i64 %v37
  %v44.p = getelementptr i8, ptr %v43, i64 0
  %v44.b = load i8, ptr %v44.p
  %v44 = zext i8 %v44.b to i64
  %v45 = add i64 0, 43
  %v46.c = icmp eq i64 %v44, %v45
  %v46 = zext i1 %v46.c to i64
  br label %b10
b13:
  %v47 = add i64 0, 1
  %st18 = getelementptr i64, ptr %v7, i64 0
  store i64 %v47, ptr %st18
  br label %b15
b14:
  br label %b15
b15:
  %v48 = add i64 0, 0
  %v49 = getelementptr i64, ptr %s2, i64 0
  %st19 = getelementptr i64, ptr %v49, i64 0
  store i64 %v48, ptr %st19
  %v50 = add i64 0, 0
  %v51 = getelementptr i64, ptr %s3, i64 0
  %st20 = getelementptr i64, ptr %v51, i64 0
  store i64 %v50, ptr %st20
  %v52 = add i64 0, 0
  %v53 = getelementptr i64, ptr %s4, i64 0
  %st21 = getelementptr i64, ptr %v53, i64 0
  store i64 %v52, ptr %st21
  %v389 = getelementptr i64, ptr @"rt.meta", i64 0
  %v54.p = getelementptr i64, ptr %v389, i64 0
  %v54 = load i64, ptr %v54.p
  br label %b16
b16:
  %v390 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v390, i64 0
  store i64 %v54, ptr %st22
  %v55.p = getelementptr i64, ptr %v7, i64 0
  %v55 = load i64, ptr %v55.p
  %v56.p = getelementptr i64, ptr %v4, i64 1
  %v56 = load i64, ptr %v56.p
  %v57.c = icmp slt i64 %v55, %v56
  %v57 = zext i1 %v57.c to i64
  %c.b16 = icmp ne i64 %v57, 0
  br i1 %c.b16, label %b16.t24, label %b16.e25
b16.t24:
  br label %b19
b16.e25:
  br label %b20
b17:
  call void @"rt.region_enter"()
  %v391 = getelementptr i64, ptr @"rt.meta", i64 0
  %v80.p = getelementptr i64, ptr %v391, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = add i64 0, 1
  %v82 = add i64 %v5, %v81
  %v83.p = getelementptr i64, ptr %v49, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 10
  %v85 = mul i64 %v83, %v84
  %v86.p = getelementptr i64, ptr %v7, i64 0
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v4, i64 1
  %v87 = load i64, ptr %v87.p
  %v88.c = icmp uge i64 %v86, %v87
  %v88 = zext i1 %v88.c to i64
  %c.b17 = icmp ne i64 %v88, 0
  br i1 %c.b17, label %b17.t26, label %b17.e27
b17.t26:
  br label %b27
b17.e27:
  br label %b28
b18:
  %v392 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v392, i64 0
  store i64 %v54, ptr %st27
  %v108.p = getelementptr i64, ptr %v53, i64 0
  %v108 = load i64, ptr %v108.p
  %v109 = add i64 0, 0
  %v110.c = icmp eq i64 %v108, %v109
  %v110 = zext i1 %v110.c to i64
  %c.b18 = icmp ne i64 %v110, 0
  br i1 %c.b18, label %b18.t29, label %b18.e30
b18.t29:
  br label %b32
b18.e30:
  br label %b33
b19:
  %v59.p = getelementptr i64, ptr %v7, i64 0
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v4, i64 1
  %v60 = load i64, ptr %v60.p
  %v61.c = icmp uge i64 %v59, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b19 = icmp ne i64 %v61, 0
  br i1 %c.b19, label %b19.t31, label %b19.e32
b19.t31:
  br label %b21
b19.e32:
  br label %b22
b20:
  %v58 = phi i64 [ %v57, %b16.e25 ], [ %v68, %b22 ]
  %c.b20 = icmp ne i64 %v58, 0
  br i1 %c.b20, label %b20.t33, label %b20.e34
b20.t33:
  br label %b23
b20.e34:
  br label %b24
b21:
  %v62 = add i64 0, 8
  call void @"rt.panic"(i64 %v62)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b22:
  %v63.p = getelementptr i64, ptr %v4, i64 0
  %v63 = load i64, ptr %v63.p
  %v64 = inttoptr i64 %v63 to ptr
  %v65 = getelementptr i8, ptr %v64, i64 %v59
  %v66.p = getelementptr i8, ptr %v65, i64 0
  %v66.b = load i8, ptr %v66.p
  %v66 = zext i8 %v66.b to i64
  %v67 = add i64 0, 48
  %v68.c = icmp sge i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  br label %b20
b23:
  %v70.p = getelementptr i64, ptr %v7, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v4, i64 1
  %v71 = load i64, ptr %v71.p
  %v72.c = icmp uge i64 %v70, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b23 = icmp ne i64 %v72, 0
  br i1 %c.b23, label %b23.t35, label %b23.e36
b23.t35:
  br label %b25
b23.e36:
  br label %b26
b24:
  %v69 = phi i64 [ %v58, %b20.e34 ], [ %v79, %b26 ]
  %c.b24 = icmp ne i64 %v69, 0
  br i1 %c.b24, label %b24.t37, label %b24.e38
b24.t37:
  br label %b17
b24.e38:
  br label %b18
b25:
  %v73 = add i64 0, 9
  call void @"rt.panic"(i64 %v73)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b26:
  %v74.p = getelementptr i64, ptr %v4, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = inttoptr i64 %v74 to ptr
  %v76 = getelementptr i8, ptr %v75, i64 %v70
  %v77.p = getelementptr i8, ptr %v76, i64 0
  %v77.b = load i8, ptr %v77.p
  %v77 = zext i8 %v77.b to i64
  %v78 = add i64 0, 57
  %v79.c = icmp sle i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  br label %b24
b27:
  %v89 = add i64 0, 10
  call void @"rt.panic"(i64 %v89)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b28:
  %v90.p = getelementptr i64, ptr %v4, i64 0
  %v90 = load i64, ptr %v90.p
  %v91 = inttoptr i64 %v90 to ptr
  %v92 = getelementptr i8, ptr %v91, i64 %v86
  %v93.p = getelementptr i8, ptr %v92, i64 0
  %v93.b = load i8, ptr %v93.p
  %v93 = zext i8 %v93.b to i64
  %v94 = add i64 0, 48
  %v95 = sub i64 %v93, %v94
  %v96 = add i64 %v85, %v95
  %st38 = getelementptr i64, ptr %v49, i64 0
  store i64 %v96, ptr %st38
  %v97 = add i64 0, 1
  %v98.p = getelementptr i64, ptr %v53, i64 0
  %v98 = load i64, ptr %v98.p
  %v99 = add i64 %v98, %v97
  %st39 = getelementptr i64, ptr %v53, i64 0
  store i64 %v99, ptr %st39
  %v100.p = getelementptr i64, ptr %v49, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 9007199254740992
  %v102.c = icmp sgt i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b28 = icmp ne i64 %v102, 0
  br i1 %c.b28, label %b28.t41, label %b28.e42
b28.t41:
  br label %b29
b28.e42:
  br label %b30
b29:
  %v103 = add i64 0, 0
  %v104 = add i64 0, 0
  %st42 = getelementptr i64, ptr %v0, i64 0
  store i64 %v103, ptr %st42
  %st43 = getelementptr i64, ptr %v0, i64 1
  store i64 %v104, ptr %st43
  %v393 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v393, i64 0
  store i64 %v5, ptr %st44
  ret void
b30:
  br label %b31
b31:
  %v105 = add i64 0, 1
  %v106.p = getelementptr i64, ptr %v7, i64 0
  %v106 = load i64, ptr %v106.p
  %v107 = add i64 %v106, %v105
  %st45 = getelementptr i64, ptr %v7, i64 0
  store i64 %v107, ptr %st45
  br label %b16
b32:
  %v111 = add i64 0, 0
  %v112 = add i64 0, 0
  %st46 = getelementptr i64, ptr %v0, i64 0
  store i64 %v111, ptr %st46
  %st47 = getelementptr i64, ptr %v0, i64 1
  store i64 %v112, ptr %st47
  %v394 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v394, i64 0
  store i64 %v5, ptr %st48
  ret void
b33:
  br label %b34
b34:
  %v113.p = getelementptr i64, ptr %v7, i64 0
  %v113 = load i64, ptr %v113.p
  %v114.p = getelementptr i64, ptr %v4, i64 1
  %v114 = load i64, ptr %v114.p
  %v115.c = icmp slt i64 %v113, %v114
  %v115 = zext i1 %v115.c to i64
  %c.b34 = icmp ne i64 %v115, 0
  br i1 %c.b34, label %b34.t50, label %b34.e51
b34.t50:
  br label %b35
b34.e51:
  br label %b36
b35:
  %v117.p = getelementptr i64, ptr %v7, i64 0
  %v117 = load i64, ptr %v117.p
  %v118.p = getelementptr i64, ptr %v4, i64 1
  %v118 = load i64, ptr %v118.p
  %v119.c = icmp uge i64 %v117, %v118
  %v119 = zext i1 %v119.c to i64
  %c.b35 = icmp ne i64 %v119, 0
  br i1 %c.b35, label %b35.t52, label %b35.e53
b35.t52:
  br label %b37
b35.e53:
  br label %b38
b36:
  %v116 = phi i64 [ %v115, %b34.e51 ], [ %v126, %b38 ]
  %c.b36 = icmp ne i64 %v116, 0
  br i1 %c.b36, label %b36.t54, label %b36.e55
b36.t54:
  br label %b39
b36.e55:
  br label %b40
b37:
  %v120 = add i64 0, 11
  call void @"rt.panic"(i64 %v120)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b38:
  %v121.p = getelementptr i64, ptr %v4, i64 0
  %v121 = load i64, ptr %v121.p
  %v122 = inttoptr i64 %v121 to ptr
  %v123 = getelementptr i8, ptr %v122, i64 %v117
  %v124.p = getelementptr i8, ptr %v123, i64 0
  %v124.b = load i8, ptr %v124.p
  %v124 = zext i8 %v124.b to i64
  %v125 = add i64 0, 46
  %v126.c = icmp eq i64 %v124, %v125
  %v126 = zext i1 %v126.c to i64
  br label %b36
b39:
  %v127 = add i64 0, 1
  %v128.p = getelementptr i64, ptr %v7, i64 0
  %v128 = load i64, ptr %v128.p
  %v129 = add i64 %v128, %v127
  %st55 = getelementptr i64, ptr %v7, i64 0
  store i64 %v129, ptr %st55
  %v130 = add i64 0, 0
  %v131 = getelementptr i64, ptr %s5, i64 0
  %st56 = getelementptr i64, ptr %v131, i64 0
  store i64 %v130, ptr %st56
  %v395 = getelementptr i64, ptr @"rt.meta", i64 0
  %v132.p = getelementptr i64, ptr %v395, i64 0
  %v132 = load i64, ptr %v132.p
  br label %b41
b40:
  br label %b60
b41:
  %v396 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v396, i64 0
  store i64 %v132, ptr %st57
  %v133.p = getelementptr i64, ptr %v7, i64 0
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v4, i64 1
  %v134 = load i64, ptr %v134.p
  %v135.c = icmp slt i64 %v133, %v134
  %v135 = zext i1 %v135.c to i64
  %c.b41 = icmp ne i64 %v135, 0
  br i1 %c.b41, label %b41.t59, label %b41.e60
b41.t59:
  br label %b44
b41.e60:
  br label %b45
b42:
  call void @"rt.region_enter"()
  %v397 = getelementptr i64, ptr @"rt.meta", i64 0
  %v158.p = getelementptr i64, ptr %v397, i64 0
  %v158 = load i64, ptr %v158.p
  %v159 = add i64 0, 1
  %v160 = add i64 %v5, %v159
  %v161.p = getelementptr i64, ptr %v49, i64 0
  %v161 = load i64, ptr %v161.p
  %v162 = add i64 0, 10
  %v163 = mul i64 %v161, %v162
  %v164.p = getelementptr i64, ptr %v7, i64 0
  %v164 = load i64, ptr %v164.p
  %v165.p = getelementptr i64, ptr %v4, i64 1
  %v165 = load i64, ptr %v165.p
  %v166.c = icmp uge i64 %v164, %v165
  %v166 = zext i1 %v166.c to i64
  %c.b42 = icmp ne i64 %v166, 0
  br i1 %c.b42, label %b42.t61, label %b42.e62
b42.t61:
  br label %b52
b42.e62:
  br label %b53
b43:
  %v398 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v398, i64 0
  store i64 %v132, ptr %st62
  %v186.p = getelementptr i64, ptr %v131, i64 0
  %v186 = load i64, ptr %v186.p
  %v187 = add i64 0, 0
  %v188.c = icmp eq i64 %v186, %v187
  %v188 = zext i1 %v188.c to i64
  %c.b43 = icmp ne i64 %v188, 0
  br i1 %c.b43, label %b43.t64, label %b43.e65
b43.t64:
  br label %b57
b43.e65:
  br label %b58
b44:
  %v137.p = getelementptr i64, ptr %v7, i64 0
  %v137 = load i64, ptr %v137.p
  %v138.p = getelementptr i64, ptr %v4, i64 1
  %v138 = load i64, ptr %v138.p
  %v139.c = icmp uge i64 %v137, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b44 = icmp ne i64 %v139, 0
  br i1 %c.b44, label %b44.t66, label %b44.e67
b44.t66:
  br label %b46
b44.e67:
  br label %b47
b45:
  %v136 = phi i64 [ %v135, %b41.e60 ], [ %v146, %b47 ]
  %c.b45 = icmp ne i64 %v136, 0
  br i1 %c.b45, label %b45.t68, label %b45.e69
b45.t68:
  br label %b48
b45.e69:
  br label %b49
b46:
  %v140 = add i64 0, 12
  call void @"rt.panic"(i64 %v140)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v141.p = getelementptr i64, ptr %v4, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = inttoptr i64 %v141 to ptr
  %v143 = getelementptr i8, ptr %v142, i64 %v137
  %v144.p = getelementptr i8, ptr %v143, i64 0
  %v144.b = load i8, ptr %v144.p
  %v144 = zext i8 %v144.b to i64
  %v145 = add i64 0, 48
  %v146.c = icmp sge i64 %v144, %v145
  %v146 = zext i1 %v146.c to i64
  br label %b45
b48:
  %v148.p = getelementptr i64, ptr %v7, i64 0
  %v148 = load i64, ptr %v148.p
  %v149.p = getelementptr i64, ptr %v4, i64 1
  %v149 = load i64, ptr %v149.p
  %v150.c = icmp uge i64 %v148, %v149
  %v150 = zext i1 %v150.c to i64
  %c.b48 = icmp ne i64 %v150, 0
  br i1 %c.b48, label %b48.t70, label %b48.e71
b48.t70:
  br label %b50
b48.e71:
  br label %b51
b49:
  %v147 = phi i64 [ %v136, %b45.e69 ], [ %v157, %b51 ]
  %c.b49 = icmp ne i64 %v147, 0
  br i1 %c.b49, label %b49.t72, label %b49.e73
b49.t72:
  br label %b42
b49.e73:
  br label %b43
b50:
  %v151 = add i64 0, 13
  call void @"rt.panic"(i64 %v151)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v152.p = getelementptr i64, ptr %v4, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = inttoptr i64 %v152 to ptr
  %v154 = getelementptr i8, ptr %v153, i64 %v148
  %v155.p = getelementptr i8, ptr %v154, i64 0
  %v155.b = load i8, ptr %v155.p
  %v155 = zext i8 %v155.b to i64
  %v156 = add i64 0, 57
  %v157.c = icmp sle i64 %v155, %v156
  %v157 = zext i1 %v157.c to i64
  br label %b49
b52:
  %v167 = add i64 0, 14
  call void @"rt.panic"(i64 %v167)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b53:
  %v168.p = getelementptr i64, ptr %v4, i64 0
  %v168 = load i64, ptr %v168.p
  %v169 = inttoptr i64 %v168 to ptr
  %v170 = getelementptr i8, ptr %v169, i64 %v164
  %v171.p = getelementptr i8, ptr %v170, i64 0
  %v171.b = load i8, ptr %v171.p
  %v171 = zext i8 %v171.b to i64
  %v172 = add i64 0, 48
  %v173 = sub i64 %v171, %v172
  %v174 = add i64 %v163, %v173
  %st73 = getelementptr i64, ptr %v49, i64 0
  store i64 %v174, ptr %st73
  %v175 = add i64 0, 1
  %v176.p = getelementptr i64, ptr %v131, i64 0
  %v176 = load i64, ptr %v176.p
  %v177 = add i64 %v176, %v175
  %st74 = getelementptr i64, ptr %v131, i64 0
  store i64 %v177, ptr %st74
  %v178.p = getelementptr i64, ptr %v49, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 0, 9007199254740992
  %v180.c = icmp sgt i64 %v178, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b53 = icmp ne i64 %v180, 0
  br i1 %c.b53, label %b53.t76, label %b53.e77
b53.t76:
  br label %b54
b53.e77:
  br label %b55
b54:
  %v181 = add i64 0, 0
  %v182 = add i64 0, 0
  %st77 = getelementptr i64, ptr %v0, i64 0
  store i64 %v181, ptr %st77
  %st78 = getelementptr i64, ptr %v0, i64 1
  store i64 %v182, ptr %st78
  %v399 = getelementptr i64, ptr @"rt.meta", i64 0
  %st79 = getelementptr i64, ptr %v399, i64 0
  store i64 %v5, ptr %st79
  ret void
b55:
  br label %b56
b56:
  %v183 = add i64 0, 1
  %v184.p = getelementptr i64, ptr %v7, i64 0
  %v184 = load i64, ptr %v184.p
  %v185 = add i64 %v184, %v183
  %st80 = getelementptr i64, ptr %v7, i64 0
  store i64 %v185, ptr %st80
  br label %b41
b57:
  %v189 = add i64 0, 0
  %v190 = add i64 0, 0
  %st81 = getelementptr i64, ptr %v0, i64 0
  store i64 %v189, ptr %st81
  %st82 = getelementptr i64, ptr %v0, i64 1
  store i64 %v190, ptr %st82
  %v400 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v400, i64 0
  store i64 %v5, ptr %st83
  ret void
b58:
  br label %b59
b59:
  %v191.p = getelementptr i64, ptr %v131, i64 0
  %v191 = load i64, ptr %v191.p
  %v192.p = getelementptr i64, ptr %v51, i64 0
  %v192 = load i64, ptr %v192.p
  %v193 = sub i64 %v192, %v191
  %st84 = getelementptr i64, ptr %v51, i64 0
  store i64 %v193, ptr %st84
  br label %b60
b60:
  %v194.p = getelementptr i64, ptr %v7, i64 0
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v4, i64 1
  %v195 = load i64, ptr %v195.p
  %v196.c = icmp slt i64 %v194, %v195
  %v196 = zext i1 %v196.c to i64
  %c.b60 = icmp ne i64 %v196, 0
  br i1 %c.b60, label %b60.t86, label %b60.e87
b60.t86:
  br label %b61
b60.e87:
  br label %b62
b61:
  %v198.p = getelementptr i64, ptr %v7, i64 0
  %v198 = load i64, ptr %v198.p
  %v199.p = getelementptr i64, ptr %v4, i64 1
  %v199 = load i64, ptr %v199.p
  %v200.c = icmp uge i64 %v198, %v199
  %v200 = zext i1 %v200.c to i64
  %c.b61 = icmp ne i64 %v200, 0
  br i1 %c.b61, label %b61.t88, label %b61.e89
b61.t88:
  br label %b63
b61.e89:
  br label %b64
b62:
  %v197 = phi i64 [ %v196, %b60.e87 ], [ %v208, %b66 ]
  %c.b62 = icmp ne i64 %v197, 0
  br i1 %c.b62, label %b62.t90, label %b62.e91
b62.t90:
  br label %b69
b62.e91:
  br label %b70
b63:
  %v201 = add i64 0, 15
  call void @"rt.panic"(i64 %v201)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b64:
  %v202.p = getelementptr i64, ptr %v4, i64 0
  %v202 = load i64, ptr %v202.p
  %v203 = inttoptr i64 %v202 to ptr
  %v204 = getelementptr i8, ptr %v203, i64 %v198
  %v205.p = getelementptr i8, ptr %v204, i64 0
  %v205.b = load i8, ptr %v205.p
  %v205 = zext i8 %v205.b to i64
  %v206 = add i64 0, 101
  %v207.c = icmp eq i64 %v205, %v206
  %v207 = zext i1 %v207.c to i64
  %c.b64 = icmp ne i64 %v207, 0
  br i1 %c.b64, label %b64.t92, label %b64.e93
b64.t92:
  br label %b66
b64.e93:
  br label %b65
b65:
  %v209.p = getelementptr i64, ptr %v7, i64 0
  %v209 = load i64, ptr %v209.p
  %v210.p = getelementptr i64, ptr %v4, i64 1
  %v210 = load i64, ptr %v210.p
  %v211.c = icmp uge i64 %v209, %v210
  %v211 = zext i1 %v211.c to i64
  %c.b65 = icmp ne i64 %v211, 0
  br i1 %c.b65, label %b65.t94, label %b65.e95
b65.t94:
  br label %b67
b65.e95:
  br label %b68
b66:
  %v208 = phi i64 [ %v207, %b64.t92 ], [ %v218, %b68 ]
  br label %b62
b67:
  %v212 = add i64 0, 16
  call void @"rt.panic"(i64 %v212)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b68:
  %v213.p = getelementptr i64, ptr %v4, i64 0
  %v213 = load i64, ptr %v213.p
  %v214 = inttoptr i64 %v213 to ptr
  %v215 = getelementptr i8, ptr %v214, i64 %v209
  %v216.p = getelementptr i8, ptr %v215, i64 0
  %v216.b = load i8, ptr %v216.p
  %v216 = zext i8 %v216.b to i64
  %v217 = add i64 0, 69
  %v218.c = icmp eq i64 %v216, %v217
  %v218 = zext i1 %v218.c to i64
  br label %b66
b69:
  %v219 = add i64 0, 1
  %v220.p = getelementptr i64, ptr %v7, i64 0
  %v220 = load i64, ptr %v220.p
  %v221 = add i64 %v220, %v219
  %st95 = getelementptr i64, ptr %v7, i64 0
  store i64 %v221, ptr %st95
  %v222 = add i64 0, 0
  %v223 = getelementptr i64, ptr %s5, i64 0
  %st96 = getelementptr i64, ptr %v223, i64 0
  store i64 %v222, ptr %st96
  %v224.p = getelementptr i64, ptr %v7, i64 0
  %v224 = load i64, ptr %v224.p
  %v225.p = getelementptr i64, ptr %v4, i64 1
  %v225 = load i64, ptr %v225.p
  %v226.c = icmp slt i64 %v224, %v225
  %v226 = zext i1 %v226.c to i64
  %c.b69 = icmp ne i64 %v226, 0
  br i1 %c.b69, label %b69.t98, label %b69.e99
b69.t98:
  br label %b71
b69.e99:
  br label %b72
b70:
  br label %b106
b71:
  %v228.p = getelementptr i64, ptr %v7, i64 0
  %v228 = load i64, ptr %v228.p
  %v229.p = getelementptr i64, ptr %v4, i64 1
  %v229 = load i64, ptr %v229.p
  %v230.c = icmp uge i64 %v228, %v229
  %v230 = zext i1 %v230.c to i64
  %c.b71 = icmp ne i64 %v230, 0
  br i1 %c.b71, label %b71.t100, label %b71.e101
b71.t100:
  br label %b73
b71.e101:
  br label %b74
b72:
  %v227 = phi i64 [ %v226, %b69.e99 ], [ %v238, %b76 ]
  %c.b72 = icmp ne i64 %v227, 0
  br i1 %c.b72, label %b72.t102, label %b72.e103
b72.t102:
  br label %b79
b72.e103:
  br label %b80
b73:
  %v231 = add i64 0, 17
  call void @"rt.panic"(i64 %v231)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b74:
  %v232.p = getelementptr i64, ptr %v4, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = inttoptr i64 %v232 to ptr
  %v234 = getelementptr i8, ptr %v233, i64 %v228
  %v235.p = getelementptr i8, ptr %v234, i64 0
  %v235.b = load i8, ptr %v235.p
  %v235 = zext i8 %v235.b to i64
  %v236 = add i64 0, 45
  %v237.c = icmp eq i64 %v235, %v236
  %v237 = zext i1 %v237.c to i64
  %c.b74 = icmp ne i64 %v237, 0
  br i1 %c.b74, label %b74.t104, label %b74.e105
b74.t104:
  br label %b76
b74.e105:
  br label %b75
b75:
  %v239.p = getelementptr i64, ptr %v7, i64 0
  %v239 = load i64, ptr %v239.p
  %v240.p = getelementptr i64, ptr %v4, i64 1
  %v240 = load i64, ptr %v240.p
  %v241.c = icmp uge i64 %v239, %v240
  %v241 = zext i1 %v241.c to i64
  %c.b75 = icmp ne i64 %v241, 0
  br i1 %c.b75, label %b75.t106, label %b75.e107
b75.t106:
  br label %b77
b75.e107:
  br label %b78
b76:
  %v238 = phi i64 [ %v237, %b74.t104 ], [ %v248, %b78 ]
  br label %b72
b77:
  %v242 = add i64 0, 18
  call void @"rt.panic"(i64 %v242)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b78:
  %v243.p = getelementptr i64, ptr %v4, i64 0
  %v243 = load i64, ptr %v243.p
  %v244 = inttoptr i64 %v243 to ptr
  %v245 = getelementptr i8, ptr %v244, i64 %v239
  %v246.p = getelementptr i8, ptr %v245, i64 0
  %v246.b = load i8, ptr %v246.p
  %v246 = zext i8 %v246.b to i64
  %v247 = add i64 0, 43
  %v248.c = icmp eq i64 %v246, %v247
  %v248 = zext i1 %v248.c to i64
  br label %b76
b79:
  %v249.p = getelementptr i64, ptr %v7, i64 0
  %v249 = load i64, ptr %v249.p
  %v250.p = getelementptr i64, ptr %v4, i64 1
  %v250 = load i64, ptr %v250.p
  %v251.c = icmp uge i64 %v249, %v250
  %v251 = zext i1 %v251.c to i64
  %c.b79 = icmp ne i64 %v251, 0
  br i1 %c.b79, label %b79.t108, label %b79.e109
b79.t108:
  br label %b81
b79.e109:
  br label %b82
b80:
  br label %b83
b81:
  %v252 = add i64 0, 19
  call void @"rt.panic"(i64 %v252)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b82:
  %v253.p = getelementptr i64, ptr %v4, i64 0
  %v253 = load i64, ptr %v253.p
  %v254 = inttoptr i64 %v253 to ptr
  %v255 = getelementptr i8, ptr %v254, i64 %v249
  %v256.p = getelementptr i8, ptr %v255, i64 0
  %v256.b = load i8, ptr %v256.p
  %v256 = zext i8 %v256.b to i64
  %v257 = add i64 0, 45
  %v258.c = icmp eq i64 %v256, %v257
  %v258 = zext i1 %v258.c to i64
  %st109 = getelementptr i64, ptr %v223, i64 0
  store i64 %v258, ptr %st109
  %v259 = add i64 0, 1
  %v260.p = getelementptr i64, ptr %v7, i64 0
  %v260 = load i64, ptr %v260.p
  %v261 = add i64 %v260, %v259
  %st110 = getelementptr i64, ptr %v7, i64 0
  store i64 %v261, ptr %st110
  br label %b83
b83:
  %v262 = add i64 0, 0
  %v263 = getelementptr i64, ptr %s6, i64 0
  %st111 = getelementptr i64, ptr %v263, i64 0
  store i64 %v262, ptr %st111
  %v264 = add i64 0, 0
  %v265 = getelementptr i64, ptr %s7, i64 0
  %st112 = getelementptr i64, ptr %v265, i64 0
  store i64 %v264, ptr %st112
  %v401 = getelementptr i64, ptr @"rt.meta", i64 0
  %v266.p = getelementptr i64, ptr %v401, i64 0
  %v266 = load i64, ptr %v266.p
  br label %b84
b84:
  %v402 = getelementptr i64, ptr @"rt.meta", i64 0
  %st113 = getelementptr i64, ptr %v402, i64 0
  store i64 %v266, ptr %st113
  %v267.p = getelementptr i64, ptr %v7, i64 0
  %v267 = load i64, ptr %v267.p
  %v268.p = getelementptr i64, ptr %v4, i64 1
  %v268 = load i64, ptr %v268.p
  %v269.c = icmp slt i64 %v267, %v268
  %v269 = zext i1 %v269.c to i64
  %c.b84 = icmp ne i64 %v269, 0
  br i1 %c.b84, label %b84.t115, label %b84.e116
b84.t115:
  br label %b87
b84.e116:
  br label %b88
b85:
  call void @"rt.region_enter"()
  %v403 = getelementptr i64, ptr @"rt.meta", i64 0
  %v292.p = getelementptr i64, ptr %v403, i64 0
  %v292 = load i64, ptr %v292.p
  %v293 = add i64 0, 1
  %v294 = add i64 %v5, %v293
  %v295.p = getelementptr i64, ptr %v263, i64 0
  %v295 = load i64, ptr %v295.p
  %v296 = add i64 0, 10
  %v297 = mul i64 %v295, %v296
  %v298.p = getelementptr i64, ptr %v7, i64 0
  %v298 = load i64, ptr %v298.p
  %v299.p = getelementptr i64, ptr %v4, i64 1
  %v299 = load i64, ptr %v299.p
  %v300.c = icmp uge i64 %v298, %v299
  %v300 = zext i1 %v300.c to i64
  %c.b85 = icmp ne i64 %v300, 0
  br i1 %c.b85, label %b85.t117, label %b85.e118
b85.t117:
  br label %b95
b85.e118:
  br label %b96
b86:
  %v404 = getelementptr i64, ptr @"rt.meta", i64 0
  %st118 = getelementptr i64, ptr %v404, i64 0
  store i64 %v266, ptr %st118
  %v320.p = getelementptr i64, ptr %v265, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = add i64 0, 0
  %v322.c = icmp eq i64 %v320, %v321
  %v322 = zext i1 %v322.c to i64
  %c.b86 = icmp ne i64 %v322, 0
  br i1 %c.b86, label %b86.t120, label %b86.e121
b86.t120:
  br label %b100
b86.e121:
  br label %b101
b87:
  %v271.p = getelementptr i64, ptr %v7, i64 0
  %v271 = load i64, ptr %v271.p
  %v272.p = getelementptr i64, ptr %v4, i64 1
  %v272 = load i64, ptr %v272.p
  %v273.c = icmp uge i64 %v271, %v272
  %v273 = zext i1 %v273.c to i64
  %c.b87 = icmp ne i64 %v273, 0
  br i1 %c.b87, label %b87.t122, label %b87.e123
b87.t122:
  br label %b89
b87.e123:
  br label %b90
b88:
  %v270 = phi i64 [ %v269, %b84.e116 ], [ %v280, %b90 ]
  %c.b88 = icmp ne i64 %v270, 0
  br i1 %c.b88, label %b88.t124, label %b88.e125
b88.t124:
  br label %b91
b88.e125:
  br label %b92
b89:
  %v274 = add i64 0, 20
  call void @"rt.panic"(i64 %v274)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b90:
  %v275.p = getelementptr i64, ptr %v4, i64 0
  %v275 = load i64, ptr %v275.p
  %v276 = inttoptr i64 %v275 to ptr
  %v277 = getelementptr i8, ptr %v276, i64 %v271
  %v278.p = getelementptr i8, ptr %v277, i64 0
  %v278.b = load i8, ptr %v278.p
  %v278 = zext i8 %v278.b to i64
  %v279 = add i64 0, 48
  %v280.c = icmp sge i64 %v278, %v279
  %v280 = zext i1 %v280.c to i64
  br label %b88
b91:
  %v282.p = getelementptr i64, ptr %v7, i64 0
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v4, i64 1
  %v283 = load i64, ptr %v283.p
  %v284.c = icmp uge i64 %v282, %v283
  %v284 = zext i1 %v284.c to i64
  %c.b91 = icmp ne i64 %v284, 0
  br i1 %c.b91, label %b91.t126, label %b91.e127
b91.t126:
  br label %b93
b91.e127:
  br label %b94
b92:
  %v281 = phi i64 [ %v270, %b88.e125 ], [ %v291, %b94 ]
  %c.b92 = icmp ne i64 %v281, 0
  br i1 %c.b92, label %b92.t128, label %b92.e129
b92.t128:
  br label %b85
b92.e129:
  br label %b86
b93:
  %v285 = add i64 0, 21
  call void @"rt.panic"(i64 %v285)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b94:
  %v286.p = getelementptr i64, ptr %v4, i64 0
  %v286 = load i64, ptr %v286.p
  %v287 = inttoptr i64 %v286 to ptr
  %v288 = getelementptr i8, ptr %v287, i64 %v282
  %v289.p = getelementptr i8, ptr %v288, i64 0
  %v289.b = load i8, ptr %v289.p
  %v289 = zext i8 %v289.b to i64
  %v290 = add i64 0, 57
  %v291.c = icmp sle i64 %v289, %v290
  %v291 = zext i1 %v291.c to i64
  br label %b92
b95:
  %v301 = add i64 0, 22
  call void @"rt.panic"(i64 %v301)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b96:
  %v302.p = getelementptr i64, ptr %v4, i64 0
  %v302 = load i64, ptr %v302.p
  %v303 = inttoptr i64 %v302 to ptr
  %v304 = getelementptr i8, ptr %v303, i64 %v298
  %v305.p = getelementptr i8, ptr %v304, i64 0
  %v305.b = load i8, ptr %v305.p
  %v305 = zext i8 %v305.b to i64
  %v306 = add i64 0, 48
  %v307 = sub i64 %v305, %v306
  %v308 = add i64 %v297, %v307
  %st129 = getelementptr i64, ptr %v263, i64 0
  store i64 %v308, ptr %st129
  %v309 = add i64 0, 1
  %v310.p = getelementptr i64, ptr %v265, i64 0
  %v310 = load i64, ptr %v310.p
  %v311 = add i64 %v310, %v309
  %st130 = getelementptr i64, ptr %v265, i64 0
  store i64 %v311, ptr %st130
  %v312.p = getelementptr i64, ptr %v263, i64 0
  %v312 = load i64, ptr %v312.p
  %v313 = add i64 0, 1000
  %v314.c = icmp sgt i64 %v312, %v313
  %v314 = zext i1 %v314.c to i64
  %c.b96 = icmp ne i64 %v314, 0
  br i1 %c.b96, label %b96.t132, label %b96.e133
b96.t132:
  br label %b97
b96.e133:
  br label %b98
b97:
  %v315 = add i64 0, 0
  %v316 = add i64 0, 0
  %st133 = getelementptr i64, ptr %v0, i64 0
  store i64 %v315, ptr %st133
  %st134 = getelementptr i64, ptr %v0, i64 1
  store i64 %v316, ptr %st134
  %v405 = getelementptr i64, ptr @"rt.meta", i64 0
  %st135 = getelementptr i64, ptr %v405, i64 0
  store i64 %v5, ptr %st135
  ret void
b98:
  br label %b99
b99:
  %v317 = add i64 0, 1
  %v318.p = getelementptr i64, ptr %v7, i64 0
  %v318 = load i64, ptr %v318.p
  %v319 = add i64 %v318, %v317
  %st136 = getelementptr i64, ptr %v7, i64 0
  store i64 %v319, ptr %st136
  br label %b84
b100:
  %v323 = add i64 0, 0
  %v324 = add i64 0, 0
  %st137 = getelementptr i64, ptr %v0, i64 0
  store i64 %v323, ptr %st137
  %st138 = getelementptr i64, ptr %v0, i64 1
  store i64 %v324, ptr %st138
  %v406 = getelementptr i64, ptr @"rt.meta", i64 0
  %st139 = getelementptr i64, ptr %v406, i64 0
  store i64 %v5, ptr %st139
  ret void
b101:
  br label %b102
b102:
  %v325.p = getelementptr i64, ptr %v223, i64 0
  %v325 = load i64, ptr %v325.p
  %c.b102 = icmp ne i64 %v325, 0
  br i1 %c.b102, label %b102.t141, label %b102.e142
b102.t141:
  br label %b103
b102.e142:
  br label %b104
b103:
  %v326 = add i64 0, 0
  %v327.p = getelementptr i64, ptr %v263, i64 0
  %v327 = load i64, ptr %v327.p
  %v328 = sub i64 %v326, %v327
  br label %b105
b104:
  %v329.p = getelementptr i64, ptr %v263, i64 0
  %v329 = load i64, ptr %v329.p
  br label %b105
b105:
  %v330 = phi i64 [ %v328, %b103 ], [ %v329, %b104 ]
  %v331.p = getelementptr i64, ptr %v51, i64 0
  %v331 = load i64, ptr %v331.p
  %v332 = add i64 %v331, %v330
  %st142 = getelementptr i64, ptr %v51, i64 0
  store i64 %v332, ptr %st142
  br label %b106
b106:
  %v333.p = getelementptr i64, ptr %v7, i64 0
  %v333 = load i64, ptr %v333.p
  %v334.p = getelementptr i64, ptr %v4, i64 1
  %v334 = load i64, ptr %v334.p
  %v335.c = icmp ne i64 %v333, %v334
  %v335 = zext i1 %v335.c to i64
  %c.b106 = icmp ne i64 %v335, 0
  br i1 %c.b106, label %b106.t144, label %b106.e145
b106.t144:
  br label %b108
b106.e145:
  br label %b107
b107:
  %v337.p = getelementptr i64, ptr %v51, i64 0
  %v337 = load i64, ptr %v337.p
  %v338 = add i64 0, 22
  %v339 = add i64 0, 0
  %v340 = sub i64 %v339, %v338
  %v341.c = icmp slt i64 %v337, %v340
  %v341 = zext i1 %v341.c to i64
  br label %b108
b108:
  %v336 = phi i64 [ %v335, %b106.t144 ], [ %v341, %b107 ]
  %c.b108 = icmp ne i64 %v336, 0
  br i1 %c.b108, label %b108.t146, label %b108.e147
b108.t146:
  br label %b110
b108.e147:
  br label %b109
b109:
  %v343.p = getelementptr i64, ptr %v51, i64 0
  %v343 = load i64, ptr %v343.p
  %v344 = add i64 0, 22
  %v345.c = icmp sgt i64 %v343, %v344
  %v345 = zext i1 %v345.c to i64
  br label %b110
b110:
  %v342 = phi i64 [ %v336, %b108.t146 ], [ %v345, %b109 ]
  %c.b110 = icmp ne i64 %v342, 0
  br i1 %c.b110, label %b110.t148, label %b110.e149
b110.t148:
  br label %b111
b110.e149:
  br label %b112
b111:
  %v346 = add i64 0, 0
  %v347 = add i64 0, 0
  %st149 = getelementptr i64, ptr %v0, i64 0
  store i64 %v346, ptr %st149
  %st150 = getelementptr i64, ptr %v0, i64 1
  store i64 %v347, ptr %st150
  %v407 = getelementptr i64, ptr @"rt.meta", i64 0
  %st151 = getelementptr i64, ptr %v407, i64 0
  store i64 %v5, ptr %st151
  ret void
b112:
  br label %b113
b113:
  %v348 = add i64 0, 4607182418800017408
  %v349 = getelementptr i64, ptr %s7, i64 0
  %st152 = getelementptr i64, ptr %v349, i64 0
  store i64 %v348, ptr %st152
  %v350.p = getelementptr i64, ptr %v51, i64 0
  %v350 = load i64, ptr %v350.p
  %v351 = add i64 0, 0
  %v352.c = icmp slt i64 %v350, %v351
  %v352 = zext i1 %v352.c to i64
  %c.b113 = icmp ne i64 %v352, 0
  br i1 %c.b113, label %b113.t154, label %b113.e155
b113.t154:
  br label %b114
b113.e155:
  br label %b115
b114:
  %v353 = add i64 0, 0
  %v354.p = getelementptr i64, ptr %v51, i64 0
  %v354 = load i64, ptr %v354.p
  %v355 = sub i64 %v353, %v354
  br label %b116
b115:
  %v356.p = getelementptr i64, ptr %v51, i64 0
  %v356 = load i64, ptr %v356.p
  br label %b116
b116:
  %v357 = phi i64 [ %v355, %b114 ], [ %v356, %b115 ]
  %v358 = getelementptr i64, ptr %s6, i64 0
  %st155 = getelementptr i64, ptr %v358, i64 0
  store i64 %v357, ptr %st155
  %v408 = getelementptr i64, ptr @"rt.meta", i64 0
  %v359.p = getelementptr i64, ptr %v408, i64 0
  %v359 = load i64, ptr %v359.p
  br label %b117
b117:
  %v409 = getelementptr i64, ptr @"rt.meta", i64 0
  %st156 = getelementptr i64, ptr %v409, i64 0
  store i64 %v359, ptr %st156
  %v360.p = getelementptr i64, ptr %v358, i64 0
  %v360 = load i64, ptr %v360.p
  %v361 = add i64 0, 0
  %v362.c = icmp sgt i64 %v360, %v361
  %v362 = zext i1 %v362.c to i64
  %c.b117 = icmp ne i64 %v362, 0
  br i1 %c.b117, label %b117.t158, label %b117.e159
b117.t158:
  br label %b118
b117.e159:
  br label %b119
b118:
  call void @"rt.region_enter"()
  %v410 = getelementptr i64, ptr @"rt.meta", i64 0
  %v363.p = getelementptr i64, ptr %v410, i64 0
  %v363 = load i64, ptr %v363.p
  %v364 = add i64 0, 1
  %v365 = add i64 %v5, %v364
  %v366.p = getelementptr i64, ptr %v349, i64 0
  %v366 = load i64, ptr %v366.p
  %v367 = add i64 0, 4621819117588971520
  %v368.a = bitcast i64 %v366 to double
  %v368.b = bitcast i64 %v367 to double
  %v368.f = fmul double %v368.a, %v368.b
  %v368 = bitcast double %v368.f to i64
  %st159 = getelementptr i64, ptr %v349, i64 0
  store i64 %v368, ptr %st159
  %v369 = add i64 0, 1
  %v370.p = getelementptr i64, ptr %v358, i64 0
  %v370 = load i64, ptr %v370.p
  %v371 = sub i64 %v370, %v369
  %st160 = getelementptr i64, ptr %v358, i64 0
  store i64 %v371, ptr %st160
  br label %b117
b119:
  %v411 = getelementptr i64, ptr @"rt.meta", i64 0
  %st161 = getelementptr i64, ptr %v411, i64 0
  store i64 %v359, ptr %st161
  %v372.p = getelementptr i64, ptr %v51, i64 0
  %v372 = load i64, ptr %v372.p
  %v373 = add i64 0, 0
  %v374.c = icmp slt i64 %v372, %v373
  %v374 = zext i1 %v374.c to i64
  %c.b119 = icmp ne i64 %v374, 0
  br i1 %c.b119, label %b119.t163, label %b119.e164
b119.t163:
  br label %b120
b119.e164:
  br label %b121
b120:
  %v375.p = getelementptr i64, ptr %v49, i64 0
  %v375 = load i64, ptr %v375.p
  %v376.f = sitofp i64 %v375 to double
  %v376 = bitcast double %v376.f to i64
  %v377.p = getelementptr i64, ptr %v349, i64 0
  %v377 = load i64, ptr %v377.p
  %v378.a = bitcast i64 %v376 to double
  %v378.b = bitcast i64 %v377 to double
  %v378.f = fdiv double %v378.a, %v378.b
  %v378 = bitcast double %v378.f to i64
  br label %b122
b121:
  %v379.p = getelementptr i64, ptr %v49, i64 0
  %v379 = load i64, ptr %v379.p
  %v380.f = sitofp i64 %v379 to double
  %v380 = bitcast double %v380.f to i64
  %v381.p = getelementptr i64, ptr %v349, i64 0
  %v381 = load i64, ptr %v381.p
  %v382.a = bitcast i64 %v380 to double
  %v382.b = bitcast i64 %v381 to double
  %v382.f = fmul double %v382.a, %v382.b
  %v382 = bitcast double %v382.f to i64
  br label %b122
b122:
  %v383 = phi i64 [ %v378, %b120 ], [ %v382, %b121 ]
  %v384 = add i64 0, 1
  %c.b122 = icmp ne i64 %v11, 0
  br i1 %c.b122, label %b122.t165, label %b122.e166
b122.t165:
  br label %b123
b122.e166:
  br label %b124
b123:
  %v385 = add i64 0, -9223372036854775808
  %v386 = xor i64 %v383, %v385
  br label %b125
b124:
  br label %b125
b125:
  %v387 = phi i64 [ %v386, %b123 ], [ %v383, %b124 ]
  %st166 = getelementptr i64, ptr %v0, i64 0
  store i64 %v384, ptr %st166
  %st167 = getelementptr i64, ptr %v0, i64 1
  store i64 %v387, ptr %st167
  %v412 = getelementptr i64, ptr @"rt.meta", i64 0
  %st168 = getelementptr i64, ptr %v412, i64 0
  store i64 %v5, ptr %st168
  ret void
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
  %v10 = add i64 0, 5
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
  %v30 = add i64 0, 6
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
  %v44 = add i64 0, 7
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
  %v56 = add i64 0, 10
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

define internal void @"std/io.ReadStdin"(ptr %v0) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [2 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
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
  %s4 = alloca [3 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
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
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v104, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v2, i64 2571
  %v3 = load i64, ptr %v3.p
  %v4 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v2, i64 2571
  store i64 %v4, ptr %st0
  %v5 = add i64 0, 1
  %v6.c = icmp sge i64 %v3, %v5
  %v6 = zext i1 %v6.c to i64
  %v7.c = icmp sle i64 %v3, %v1
  %v7 = zext i1 %v7.c to i64
  %v8 = and i64 %v6, %v7
  %v9 = sub i64 %v3, %v1
  %v10 = mul i64 %v8, %v9
  %v11 = add i64 %v1, %v10
  call void @"rt.region_enter"()
  %v12 = add i64 0, 0
  %v13 = add i64 0, 0
  %v14.c = icmp ne i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v15 = add i64 0, 0
  %v16 = call ptr @"rt.region_alloc8"(i64 %v11, i64 %v15)
  %v17 = add i64 0, 0
  %v18 = getelementptr i64, ptr %s0, i64 0
  %v19 = ptrtoint ptr %v16 to i64
  %st3 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st3
  %st4 = getelementptr i64, ptr %v18, i64 1
  store i64 %v17, ptr %st4
  %st5 = getelementptr i64, ptr %v18, i64 2
  store i64 %v11, ptr %st5
  %v20 = getelementptr i64, ptr %s1, i64 0
  %v21 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st6
  %st7 = getelementptr i64, ptr %v20, i64 1
  store i64 %v21, ptr %st7
  %v22 = add i64 0, 8
  %st8 = getelementptr i64, ptr %v20, i64 0
  store i64 %v22, ptr %st8
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24.p = getelementptr i64, ptr %v20, i64 0
  %v24 = load i64, ptr %v24.p
  %st9 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st9
  %v25.p = getelementptr i64, ptr %v20, i64 1
  %v25 = load i64, ptr %v25.p
  %st10 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st10
  %v26 = add i64 0, 0
  %st11 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st11
  %st12 = getelementptr i64, ptr %v23, i64 3
  store i64 %v26, ptr %st12
  %st13 = getelementptr i64, ptr %v23, i64 4
  store i64 %v26, ptr %st13
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v28 = add i64 0, 1
  %st14 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st14
  %v29.p = getelementptr i64, ptr %v23, i64 0
  %v29 = load i64, ptr %v29.p
  %st15 = getelementptr i64, ptr %v27, i64 1
  store i64 %v29, ptr %st15
  %v30.p = getelementptr i64, ptr %v23, i64 1
  %v30 = load i64, ptr %v30.p
  %st16 = getelementptr i64, ptr %v27, i64 2
  store i64 %v30, ptr %st16
  %v31.p = getelementptr i64, ptr %v23, i64 2
  %v31 = load i64, ptr %v31.p
  %st17 = getelementptr i64, ptr %v27, i64 3
  store i64 %v31, ptr %st17
  %v32.p = getelementptr i64, ptr %v23, i64 3
  %v32 = load i64, ptr %v32.p
  %st18 = getelementptr i64, ptr %v27, i64 4
  store i64 %v32, ptr %st18
  %v33.p = getelementptr i64, ptr %v23, i64 4
  %v33 = load i64, ptr %v33.p
  %st19 = getelementptr i64, ptr %v27, i64 5
  store i64 %v33, ptr %st19
  %v34.p = getelementptr i64, ptr %v18, i64 0
  %v34 = load i64, ptr %v34.p
  %st20 = getelementptr i64, ptr %v0, i64 0
  store i64 %v34, ptr %st20
  %v35.p = getelementptr i64, ptr %v18, i64 1
  %v35 = load i64, ptr %v35.p
  %st21 = getelementptr i64, ptr %v0, i64 1
  store i64 %v35, ptr %st21
  %v36.p = getelementptr i64, ptr %v18, i64 2
  %v36 = load i64, ptr %v36.p
  %st22 = getelementptr i64, ptr %v0, i64 2
  store i64 %v36, ptr %st22
  %v37.p = getelementptr i64, ptr %v27, i64 0
  %v37 = load i64, ptr %v37.p
  %st23 = getelementptr i64, ptr %v0, i64 3
  store i64 %v37, ptr %st23
  %v38.p = getelementptr i64, ptr %v27, i64 1
  %v38 = load i64, ptr %v38.p
  %st24 = getelementptr i64, ptr %v0, i64 4
  store i64 %v38, ptr %st24
  %v39.p = getelementptr i64, ptr %v27, i64 2
  %v39 = load i64, ptr %v39.p
  %st25 = getelementptr i64, ptr %v0, i64 5
  store i64 %v39, ptr %st25
  %v40.p = getelementptr i64, ptr %v27, i64 3
  %v40 = load i64, ptr %v40.p
  %st26 = getelementptr i64, ptr %v0, i64 6
  store i64 %v40, ptr %st26
  %v41.p = getelementptr i64, ptr %v27, i64 4
  %v41 = load i64, ptr %v41.p
  %st27 = getelementptr i64, ptr %v0, i64 7
  store i64 %v41, ptr %st27
  %v42.p = getelementptr i64, ptr %v27, i64 5
  %v42 = load i64, ptr %v42.p
  %st28 = getelementptr i64, ptr %v0, i64 8
  store i64 %v42, ptr %st28
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v43.p = getelementptr i64, ptr %v0, i64 3
  %v43 = load i64, ptr %v43.p
  %v44 = add i64 0, 0
  %v45.c = icmp ne i64 %v43, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b1 = icmp ne i64 %v45, 0
  br i1 %c.b1, label %b1.t30, label %b1.e31
b1.t30:
  br label %b3
b1.e31:
  br label %b4
b2:
  br label %b5
b3:
  %v46 = add i64 0, 4
  %v47 = getelementptr i64, ptr %v0, i64 %v46
  call void @"rt.err_relocate"(ptr %v47, i64 %v1)
  br label %b4
b4:
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v105, i64 0
  store i64 %v1, ptr %st31
  ret void
b5:
  %v48 = add i64 0, 0
  %v49 = add i64 0, 1
  %v50 = add i64 0, 0
  %v51 = sub i64 %v50, %v49
  %v52 = getelementptr i64, ptr %s0, i64 0
  call void @"rt.read_fd"(i64 %v48, i64 %v51, ptr %v52)
  %v53 = getelementptr i64, ptr %s4, i64 0
  %v54.p = getelementptr i64, ptr %v52, i64 0
  %v54 = load i64, ptr %v54.p
  %st32 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st32
  %v55.p = getelementptr i64, ptr %v52, i64 1
  %v55 = load i64, ptr %v55.p
  %st33 = getelementptr i64, ptr %v53, i64 1
  store i64 %v55, ptr %st33
  %v56.p = getelementptr i64, ptr %v52, i64 2
  %v56 = load i64, ptr %v56.p
  %st34 = getelementptr i64, ptr %v53, i64 2
  store i64 %v56, ptr %st34
  %v57 = getelementptr i64, ptr @"rt.meta", i64 0
  %v58.p = getelementptr i64, ptr %v57, i64 1027
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 0
  %v60.c = icmp ne i64 %v58, %v59
  %v60 = zext i1 %v60.c to i64
  %c.b5 = icmp ne i64 %v60, 0
  br i1 %c.b5, label %b5.t36, label %b5.e37
b5.t36:
  br label %b6
b5.e37:
  br label %b7
b6:
  %v61 = add i64 0, 0
  %v62 = call ptr @"rt.region_alloc8"(i64 %v11, i64 %v61)
  %v63 = add i64 0, 0
  %v64 = getelementptr i64, ptr %s0, i64 0
  %v65 = ptrtoint ptr %v62 to i64
  %st37 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st37
  %st38 = getelementptr i64, ptr %v64, i64 1
  store i64 %v63, ptr %st38
  %st39 = getelementptr i64, ptr %v64, i64 2
  store i64 %v11, ptr %st39
  %v66 = getelementptr i64, ptr %s5, i64 0
  call void @"std/io.errOf"(ptr %v66, i64 %v58)
  %v67 = getelementptr i64, ptr %s3, i64 0
  %v68 = add i64 0, 1
  %st40 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st40
  %v69.p = getelementptr i64, ptr %v66, i64 0
  %v69 = load i64, ptr %v69.p
  %st41 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st41
  %v70.p = getelementptr i64, ptr %v66, i64 1
  %v70 = load i64, ptr %v70.p
  %st42 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st42
  %v71.p = getelementptr i64, ptr %v66, i64 2
  %v71 = load i64, ptr %v71.p
  %st43 = getelementptr i64, ptr %v67, i64 3
  store i64 %v71, ptr %st43
  %v72.p = getelementptr i64, ptr %v66, i64 3
  %v72 = load i64, ptr %v72.p
  %st44 = getelementptr i64, ptr %v67, i64 4
  store i64 %v72, ptr %st44
  %v73.p = getelementptr i64, ptr %v66, i64 4
  %v73 = load i64, ptr %v73.p
  %st45 = getelementptr i64, ptr %v67, i64 5
  store i64 %v73, ptr %st45
  %v74.p = getelementptr i64, ptr %v64, i64 0
  %v74 = load i64, ptr %v74.p
  %st46 = getelementptr i64, ptr %v0, i64 0
  store i64 %v74, ptr %st46
  %v75.p = getelementptr i64, ptr %v64, i64 1
  %v75 = load i64, ptr %v75.p
  %st47 = getelementptr i64, ptr %v0, i64 1
  store i64 %v75, ptr %st47
  %v76.p = getelementptr i64, ptr %v64, i64 2
  %v76 = load i64, ptr %v76.p
  %st48 = getelementptr i64, ptr %v0, i64 2
  store i64 %v76, ptr %st48
  %v77.p = getelementptr i64, ptr %v67, i64 0
  %v77 = load i64, ptr %v77.p
  %st49 = getelementptr i64, ptr %v0, i64 3
  store i64 %v77, ptr %st49
  %v78.p = getelementptr i64, ptr %v67, i64 1
  %v78 = load i64, ptr %v78.p
  %st50 = getelementptr i64, ptr %v0, i64 4
  store i64 %v78, ptr %st50
  %v79.p = getelementptr i64, ptr %v67, i64 2
  %v79 = load i64, ptr %v79.p
  %st51 = getelementptr i64, ptr %v0, i64 5
  store i64 %v79, ptr %st51
  %v80.p = getelementptr i64, ptr %v67, i64 3
  %v80 = load i64, ptr %v80.p
  %st52 = getelementptr i64, ptr %v0, i64 6
  store i64 %v80, ptr %st52
  %v81.p = getelementptr i64, ptr %v67, i64 4
  %v81 = load i64, ptr %v81.p
  %st53 = getelementptr i64, ptr %v0, i64 7
  store i64 %v81, ptr %st53
  %v82.p = getelementptr i64, ptr %v67, i64 5
  %v82 = load i64, ptr %v82.p
  %st54 = getelementptr i64, ptr %v0, i64 8
  store i64 %v82, ptr %st54
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v83.p = getelementptr i64, ptr %v0, i64 3
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 0
  %v85.c = icmp ne i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b6 = icmp ne i64 %v85, 0
  br i1 %c.b6, label %b6.t56, label %b6.e57
b6.t56:
  br label %b8
b6.e57:
  br label %b9
b7:
  br label %b10
b8:
  %v86 = add i64 0, 4
  %v87 = getelementptr i64, ptr %v0, i64 %v86
  call void @"rt.err_relocate"(ptr %v87, i64 %v1)
  br label %b9
b9:
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v106, i64 0
  store i64 %v1, ptr %st57
  ret void
b10:
  %v88 = getelementptr i64, ptr %s3, i64 0
  %v89 = add i64 0, 0
  %st58 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st58
  %v90.p = getelementptr i64, ptr %v53, i64 0
  %v90 = load i64, ptr %v90.p
  %st59 = getelementptr i64, ptr %v0, i64 0
  store i64 %v90, ptr %st59
  %v91.p = getelementptr i64, ptr %v53, i64 1
  %v91 = load i64, ptr %v91.p
  %st60 = getelementptr i64, ptr %v0, i64 1
  store i64 %v91, ptr %st60
  %v92.p = getelementptr i64, ptr %v53, i64 2
  %v92 = load i64, ptr %v92.p
  %st61 = getelementptr i64, ptr %v0, i64 2
  store i64 %v92, ptr %st61
  %v93.p = getelementptr i64, ptr %v88, i64 0
  %v93 = load i64, ptr %v93.p
  %st62 = getelementptr i64, ptr %v0, i64 3
  store i64 %v93, ptr %st62
  %v94.p = getelementptr i64, ptr %v88, i64 1
  %v94 = load i64, ptr %v94.p
  %st63 = getelementptr i64, ptr %v0, i64 4
  store i64 %v94, ptr %st63
  %v95.p = getelementptr i64, ptr %v88, i64 2
  %v95 = load i64, ptr %v95.p
  %st64 = getelementptr i64, ptr %v0, i64 5
  store i64 %v95, ptr %st64
  %v96.p = getelementptr i64, ptr %v88, i64 3
  %v96 = load i64, ptr %v96.p
  %st65 = getelementptr i64, ptr %v0, i64 6
  store i64 %v96, ptr %st65
  %v97.p = getelementptr i64, ptr %v88, i64 4
  %v97 = load i64, ptr %v97.p
  %st66 = getelementptr i64, ptr %v0, i64 7
  store i64 %v97, ptr %st66
  %v98.p = getelementptr i64, ptr %v88, i64 5
  %v98 = load i64, ptr %v98.p
  %st67 = getelementptr i64, ptr %v0, i64 8
  store i64 %v98, ptr %st67
  call void @"rt.region_relocate8"(ptr %v0, i64 %v1)
  %v99.p = getelementptr i64, ptr %v0, i64 3
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 0, 0
  %v101.c = icmp ne i64 %v99, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b10 = icmp ne i64 %v101, 0
  br i1 %c.b10, label %b10.t69, label %b10.e70
b10.t69:
  br label %b11
b10.e70:
  br label %b12
b11:
  %v102 = add i64 0, 4
  %v103 = getelementptr i64, ptr %v0, i64 %v102
  call void @"rt.err_relocate"(ptr %v103, i64 %v1)
  br label %b12
b12:
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v107, i64 0
  store i64 %v1, ptr %st70
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
  %v29 = add i64 0, 13
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

define internal void @"std/internal/floatfmt.ParseBits"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [2 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s1.z1 = getelementptr i64, ptr %s1, i64 1
  store i64 0, ptr %s1.z1
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
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v80, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v4, i64 0
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v4, i64 2
  %v9 = load i64, ptr %v9.p
  call void @"std/internal/floatfmt.parseBits"(ptr %v6, i64 %v7, i64 %v8, i64 %v9)
  %v10.p = getelementptr i64, ptr %v6, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v6, i64 1
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 1
  %v13.c = icmp eq i64 %v11, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b0 = icmp ne i64 %v13, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v14 = add i64 0, 0
  %v15 = getelementptr i64, ptr %s2, i64 0
  %v16 = add i64 0, 0
  %st5 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st5
  %st6 = getelementptr i64, ptr %v15, i64 1
  store i64 %v16, ptr %st6
  %v17 = add i64 0, 11
  %st7 = getelementptr i64, ptr %v15, i64 0
  store i64 %v17, ptr %st7
  %v18 = getelementptr i64, ptr %s3, i64 0
  %v19.p = getelementptr i64, ptr %v15, i64 0
  %v19 = load i64, ptr %v19.p
  %st8 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st8
  %v20.p = getelementptr i64, ptr %v15, i64 1
  %v20 = load i64, ptr %v20.p
  %st9 = getelementptr i64, ptr %v18, i64 1
  store i64 %v20, ptr %st9
  %v21 = add i64 0, 0
  %st10 = getelementptr i64, ptr %v18, i64 2
  store i64 %v21, ptr %st10
  %st11 = getelementptr i64, ptr %v18, i64 3
  store i64 %v21, ptr %st11
  %st12 = getelementptr i64, ptr %v18, i64 4
  store i64 %v21, ptr %st12
  %v22 = getelementptr i64, ptr %s4, i64 0
  %v23 = add i64 0, 1
  %st13 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st13
  %v24.p = getelementptr i64, ptr %v18, i64 0
  %v24 = load i64, ptr %v24.p
  %st14 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st14
  %v25.p = getelementptr i64, ptr %v18, i64 1
  %v25 = load i64, ptr %v25.p
  %st15 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st15
  %v26.p = getelementptr i64, ptr %v18, i64 2
  %v26 = load i64, ptr %v26.p
  %st16 = getelementptr i64, ptr %v22, i64 3
  store i64 %v26, ptr %st16
  %v27.p = getelementptr i64, ptr %v18, i64 3
  %v27 = load i64, ptr %v27.p
  %st17 = getelementptr i64, ptr %v22, i64 4
  store i64 %v27, ptr %st17
  %v28.p = getelementptr i64, ptr %v18, i64 4
  %v28 = load i64, ptr %v28.p
  %st18 = getelementptr i64, ptr %v22, i64 5
  store i64 %v28, ptr %st18
  %st19 = getelementptr i64, ptr %v0, i64 0
  store i64 %v14, ptr %st19
  %v29.p = getelementptr i64, ptr %v22, i64 0
  %v29 = load i64, ptr %v29.p
  %st20 = getelementptr i64, ptr %v0, i64 1
  store i64 %v29, ptr %st20
  %v30.p = getelementptr i64, ptr %v22, i64 1
  %v30 = load i64, ptr %v30.p
  %st21 = getelementptr i64, ptr %v0, i64 2
  store i64 %v30, ptr %st21
  %v31.p = getelementptr i64, ptr %v22, i64 2
  %v31 = load i64, ptr %v31.p
  %st22 = getelementptr i64, ptr %v0, i64 3
  store i64 %v31, ptr %st22
  %v32.p = getelementptr i64, ptr %v22, i64 3
  %v32 = load i64, ptr %v32.p
  %st23 = getelementptr i64, ptr %v0, i64 4
  store i64 %v32, ptr %st23
  %v33.p = getelementptr i64, ptr %v22, i64 4
  %v33 = load i64, ptr %v33.p
  %st24 = getelementptr i64, ptr %v0, i64 5
  store i64 %v33, ptr %st24
  %v34.p = getelementptr i64, ptr %v22, i64 5
  %v34 = load i64, ptr %v34.p
  %st25 = getelementptr i64, ptr %v0, i64 6
  store i64 %v34, ptr %st25
  %v35.p = getelementptr i64, ptr %v0, i64 1
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 0
  %v37.c = icmp ne i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b1 = icmp ne i64 %v37, 0
  br i1 %c.b1, label %b1.t27, label %b1.e28
b1.t27:
  br label %b3
b1.e28:
  br label %b4
b2:
  br label %b5
b3:
  %v38 = add i64 0, 2
  %v39 = getelementptr i64, ptr %v0, i64 %v38
  call void @"rt.err_relocate"(ptr %v39, i64 %v5)
  br label %b4
b4:
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v81, i64 0
  store i64 %v5, ptr %st28
  ret void
b5:
  %v40 = add i64 0, 2
  %v41.c = icmp eq i64 %v11, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b5 = icmp ne i64 %v41, 0
  br i1 %c.b5, label %b5.t30, label %b5.e31
b5.t30:
  br label %b6
b5.e31:
  br label %b7
b6:
  %v42 = getelementptr i64, ptr %s2, i64 0
  %v43 = add i64 0, 0
  %st31 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st31
  %st32 = getelementptr i64, ptr %v42, i64 1
  store i64 %v43, ptr %st32
  %v44 = add i64 0, 12
  %st33 = getelementptr i64, ptr %v42, i64 0
  store i64 %v44, ptr %st33
  %v45 = getelementptr i64, ptr %s3, i64 0
  %v46.p = getelementptr i64, ptr %v42, i64 0
  %v46 = load i64, ptr %v46.p
  %st34 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st34
  %v47.p = getelementptr i64, ptr %v42, i64 1
  %v47 = load i64, ptr %v47.p
  %st35 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st35
  %v48 = add i64 0, 0
  %st36 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st36
  %st37 = getelementptr i64, ptr %v45, i64 3
  store i64 %v48, ptr %st37
  %st38 = getelementptr i64, ptr %v45, i64 4
  store i64 %v48, ptr %st38
  %v49 = getelementptr i64, ptr %s4, i64 0
  %v50 = add i64 0, 1
  %st39 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st39
  %v51.p = getelementptr i64, ptr %v45, i64 0
  %v51 = load i64, ptr %v51.p
  %st40 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st40
  %v52.p = getelementptr i64, ptr %v45, i64 1
  %v52 = load i64, ptr %v52.p
  %st41 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st41
  %v53.p = getelementptr i64, ptr %v45, i64 2
  %v53 = load i64, ptr %v53.p
  %st42 = getelementptr i64, ptr %v49, i64 3
  store i64 %v53, ptr %st42
  %v54.p = getelementptr i64, ptr %v45, i64 3
  %v54 = load i64, ptr %v54.p
  %st43 = getelementptr i64, ptr %v49, i64 4
  store i64 %v54, ptr %st43
  %v55.p = getelementptr i64, ptr %v45, i64 4
  %v55 = load i64, ptr %v55.p
  %st44 = getelementptr i64, ptr %v49, i64 5
  store i64 %v55, ptr %st44
  %st45 = getelementptr i64, ptr %v0, i64 0
  store i64 %v10, ptr %st45
  %v56.p = getelementptr i64, ptr %v49, i64 0
  %v56 = load i64, ptr %v56.p
  %st46 = getelementptr i64, ptr %v0, i64 1
  store i64 %v56, ptr %st46
  %v57.p = getelementptr i64, ptr %v49, i64 1
  %v57 = load i64, ptr %v57.p
  %st47 = getelementptr i64, ptr %v0, i64 2
  store i64 %v57, ptr %st47
  %v58.p = getelementptr i64, ptr %v49, i64 2
  %v58 = load i64, ptr %v58.p
  %st48 = getelementptr i64, ptr %v0, i64 3
  store i64 %v58, ptr %st48
  %v59.p = getelementptr i64, ptr %v49, i64 3
  %v59 = load i64, ptr %v59.p
  %st49 = getelementptr i64, ptr %v0, i64 4
  store i64 %v59, ptr %st49
  %v60.p = getelementptr i64, ptr %v49, i64 4
  %v60 = load i64, ptr %v60.p
  %st50 = getelementptr i64, ptr %v0, i64 5
  store i64 %v60, ptr %st50
  %v61.p = getelementptr i64, ptr %v49, i64 5
  %v61 = load i64, ptr %v61.p
  %st51 = getelementptr i64, ptr %v0, i64 6
  store i64 %v61, ptr %st51
  %v62.p = getelementptr i64, ptr %v0, i64 1
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 0, 0
  %v64.c = icmp ne i64 %v62, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b6 = icmp ne i64 %v64, 0
  br i1 %c.b6, label %b6.t53, label %b6.e54
b6.t53:
  br label %b8
b6.e54:
  br label %b9
b7:
  br label %b10
b8:
  %v65 = add i64 0, 2
  %v66 = getelementptr i64, ptr %v0, i64 %v65
  call void @"rt.err_relocate"(ptr %v66, i64 %v5)
  br label %b9
b9:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st54 = getelementptr i64, ptr %v82, i64 0
  store i64 %v5, ptr %st54
  ret void
b10:
  %v67 = getelementptr i64, ptr %s4, i64 0
  %v68 = add i64 0, 0
  %st55 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st55
  %st56 = getelementptr i64, ptr %v0, i64 0
  store i64 %v10, ptr %st56
  %v69.p = getelementptr i64, ptr %v67, i64 0
  %v69 = load i64, ptr %v69.p
  %st57 = getelementptr i64, ptr %v0, i64 1
  store i64 %v69, ptr %st57
  %v70.p = getelementptr i64, ptr %v67, i64 1
  %v70 = load i64, ptr %v70.p
  %st58 = getelementptr i64, ptr %v0, i64 2
  store i64 %v70, ptr %st58
  %v71.p = getelementptr i64, ptr %v67, i64 2
  %v71 = load i64, ptr %v71.p
  %st59 = getelementptr i64, ptr %v0, i64 3
  store i64 %v71, ptr %st59
  %v72.p = getelementptr i64, ptr %v67, i64 3
  %v72 = load i64, ptr %v72.p
  %st60 = getelementptr i64, ptr %v0, i64 4
  store i64 %v72, ptr %st60
  %v73.p = getelementptr i64, ptr %v67, i64 4
  %v73 = load i64, ptr %v73.p
  %st61 = getelementptr i64, ptr %v0, i64 5
  store i64 %v73, ptr %st61
  %v74.p = getelementptr i64, ptr %v67, i64 5
  %v74 = load i64, ptr %v74.p
  %st62 = getelementptr i64, ptr %v0, i64 6
  store i64 %v74, ptr %st62
  %v75.p = getelementptr i64, ptr %v0, i64 1
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 0
  %v77.c = icmp ne i64 %v75, %v76
  %v77 = zext i1 %v77.c to i64
  %c.b10 = icmp ne i64 %v77, 0
  br i1 %c.b10, label %b10.t64, label %b10.e65
b10.t64:
  br label %b11
b10.e65:
  br label %b12
b11:
  %v78 = add i64 0, 2
  %v79 = getelementptr i64, ptr %v0, i64 %v78
  call void @"rt.err_relocate"(ptr %v79, i64 %v5)
  br label %b12
b12:
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st65 = getelementptr i64, ptr %v83, i64 0
  store i64 %v5, ptr %st65
  ret void
}

define internal void @"std/internal/floatfmt.parseBits"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s11 = alloca [2 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s11.z1 = getelementptr i64, ptr %s11, i64 1
  store i64 0, ptr %s11.z1
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v428 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v428, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 0
  %v7 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v7, i64 0
  store i64 %v6, ptr %st3
  %v8 = add i64 0, 0
  %v9 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v9, i64 0
  store i64 %v8, ptr %st4
  %v10.p = getelementptr i64, ptr %v7, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v4, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp slt i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t6, label %b0.e7
b0.t6:
  br label %b1
b0.e7:
  br label %b2
b1:
  %v14.p = getelementptr i64, ptr %v7, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v4, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b1 = icmp ne i64 %v16, 0
  br i1 %c.b1, label %b1.t8, label %b1.e9
b1.t8:
  br label %b3
b1.e9:
  br label %b4
b2:
  %v13 = phi i64 [ %v12, %b0.e7 ], [ %v24, %b6 ]
  %c.b2 = icmp ne i64 %v13, 0
  br i1 %c.b2, label %b2.t10, label %b2.e11
b2.t10:
  br label %b9
b2.e11:
  br label %b10
b3:
  %v17 = add i64 0, 23
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v18.p = getelementptr i64, ptr %v4, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = inttoptr i64 %v18 to ptr
  %v20 = getelementptr i8, ptr %v19, i64 %v14
  %v21.p = getelementptr i8, ptr %v20, i64 0
  %v21.b = load i8, ptr %v21.p
  %v21 = zext i8 %v21.b to i64
  %v22 = add i64 0, 43
  %v23.c = icmp eq i64 %v21, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b4 = icmp ne i64 %v23, 0
  br i1 %c.b4, label %b4.t12, label %b4.e13
b4.t12:
  br label %b6
b4.e13:
  br label %b5
b5:
  %v25.p = getelementptr i64, ptr %v7, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v4, i64 1
  %v26 = load i64, ptr %v26.p
  %v27.c = icmp uge i64 %v25, %v26
  %v27 = zext i1 %v27.c to i64
  %c.b5 = icmp ne i64 %v27, 0
  br i1 %c.b5, label %b5.t14, label %b5.e15
b5.t14:
  br label %b7
b5.e15:
  br label %b8
b6:
  %v24 = phi i64 [ %v23, %b4.t12 ], [ %v34, %b8 ]
  br label %b2
b7:
  %v28 = add i64 0, 24
  call void @"rt.panic"(i64 %v28)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v29.p = getelementptr i64, ptr %v4, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = inttoptr i64 %v29 to ptr
  %v31 = getelementptr i8, ptr %v30, i64 %v25
  %v32.p = getelementptr i8, ptr %v31, i64 0
  %v32.b = load i8, ptr %v32.p
  %v32 = zext i8 %v32.b to i64
  %v33 = add i64 0, 45
  %v34.c = icmp eq i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  br label %b6
b9:
  %v35.p = getelementptr i64, ptr %v7, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v4, i64 1
  %v36 = load i64, ptr %v36.p
  %v37.c = icmp uge i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b9 = icmp ne i64 %v37, 0
  br i1 %c.b9, label %b9.t16, label %b9.e17
b9.t16:
  br label %b11
b9.e17:
  br label %b12
b10:
  br label %b13
b11:
  %v38 = add i64 0, 25
  call void @"rt.panic"(i64 %v38)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v39.p = getelementptr i64, ptr %v4, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = inttoptr i64 %v39 to ptr
  %v41 = getelementptr i8, ptr %v40, i64 %v35
  %v42.p = getelementptr i8, ptr %v41, i64 0
  %v42.b = load i8, ptr %v42.p
  %v42 = zext i8 %v42.b to i64
  %v43 = add i64 0, 45
  %v44.c = icmp eq i64 %v42, %v43
  %v44 = zext i1 %v44.c to i64
  %st17 = getelementptr i64, ptr %v9, i64 0
  store i64 %v44, ptr %st17
  %v45 = add i64 0, 1
  %v46.p = getelementptr i64, ptr %v7, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 %v46, %v45
  %st18 = getelementptr i64, ptr %v7, i64 0
  store i64 %v47, ptr %st18
  br label %b13
b13:
  %v48.p = getelementptr i64, ptr %v9, i64 0
  %v48 = load i64, ptr %v48.p
  %c.b13 = icmp ne i64 %v48, 0
  br i1 %c.b13, label %b13.t20, label %b13.e21
b13.t20:
  br label %b14
b13.e21:
  br label %b15
b14:
  %v49 = add i64 0, 0
  %v50 = add i64 0, 9223372036854775807
  %v51 = sub i64 %v49, %v50
  %v52 = add i64 0, 1
  %v53 = sub i64 %v51, %v52
  br label %b16
b15:
  %v54 = add i64 0, 0
  br label %b16
b16:
  %v55 = phi i64 [ %v53, %b14 ], [ %v54, %b15 ]
  %v56.p = getelementptr i64, ptr %v4, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v4, i64 1
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v4, i64 2
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v7, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = getelementptr i64, ptr @"str.3", i64 0
  %v61 = add i64 0, 8
  %v62 = add i64 0, 0
  %v63 = getelementptr i64, ptr %s3, i64 0
  %v64 = ptrtoint ptr %v60 to i64
  %st21 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st21
  %st22 = getelementptr i64, ptr %v63, i64 1
  store i64 %v61, ptr %st22
  %st23 = getelementptr i64, ptr %v63, i64 2
  store i64 %v62, ptr %st23
  %v65.p = getelementptr i64, ptr %v63, i64 0
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v63, i64 1
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v63, i64 2
  %v67 = load i64, ptr %v67.p
  %v68 = call i64 @"std/internal/floatfmt.wordAt"(i64 %v56, i64 %v57, i64 %v58, i64 %v59, i64 %v65, i64 %v66, i64 %v67)
  %c.b16 = icmp ne i64 %v68, 0
  br i1 %c.b16, label %b16.t25, label %b16.e26
b16.t25:
  br label %b18
b16.e26:
  br label %b17
b17:
  %v70.p = getelementptr i64, ptr %v4, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v4, i64 1
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v4, i64 2
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v7, i64 0
  %v73 = load i64, ptr %v73.p
  %v74 = getelementptr i64, ptr @"str.1", i64 0
  %v75 = add i64 0, 3
  %v76 = add i64 0, 0
  %v77 = getelementptr i64, ptr %s4, i64 0
  %v78 = ptrtoint ptr %v74 to i64
  %st26 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st26
  %st27 = getelementptr i64, ptr %v77, i64 1
  store i64 %v75, ptr %st27
  %st28 = getelementptr i64, ptr %v77, i64 2
  store i64 %v76, ptr %st28
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %v80.p = getelementptr i64, ptr %v77, i64 1
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v77, i64 2
  %v81 = load i64, ptr %v81.p
  %v82 = call i64 @"std/internal/floatfmt.wordAt"(i64 %v70, i64 %v71, i64 %v72, i64 %v73, i64 %v79, i64 %v80, i64 %v81)
  br label %b18
b18:
  %v69 = phi i64 [ %v68, %b16.t25 ], [ %v82, %b17 ]
  %c.b18 = icmp ne i64 %v69, 0
  br i1 %c.b18, label %b18.t30, label %b18.e31
b18.t30:
  br label %b19
b18.e31:
  br label %b20
b19:
  %v83.p = getelementptr i64, ptr %v4, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v4, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v4, i64 2
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v7, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = getelementptr i64, ptr @"str.3", i64 0
  %v88 = add i64 0, 8
  %v89 = add i64 0, 0
  %v90 = getelementptr i64, ptr %s5, i64 0
  %v91 = ptrtoint ptr %v87 to i64
  %st31 = getelementptr i64, ptr %v90, i64 0
  store i64 %v91, ptr %st31
  %st32 = getelementptr i64, ptr %v90, i64 1
  store i64 %v88, ptr %st32
  %st33 = getelementptr i64, ptr %v90, i64 2
  store i64 %v89, ptr %st33
  %v92.p = getelementptr i64, ptr %v90, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v90, i64 1
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v90, i64 2
  %v94 = load i64, ptr %v94.p
  %v95 = call i64 @"std/internal/floatfmt.wordAt"(i64 %v83, i64 %v84, i64 %v85, i64 %v86, i64 %v92, i64 %v93, i64 %v94)
  %c.b19 = icmp ne i64 %v95, 0
  br i1 %c.b19, label %b19.t35, label %b19.e36
b19.t35:
  br label %b21
b19.e36:
  br label %b22
b20:
  br label %b27
b21:
  %v96 = add i64 0, 8
  br label %b23
b22:
  %v97 = add i64 0, 3
  br label %b23
b23:
  %v98 = phi i64 [ %v96, %b21 ], [ %v97, %b22 ]
  %v99.p = getelementptr i64, ptr %v7, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 %v99, %v98
  %v101.p = getelementptr i64, ptr %v4, i64 1
  %v101 = load i64, ptr %v101.p
  %v102.c = icmp ne i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b23 = icmp ne i64 %v102, 0
  br i1 %c.b23, label %b23.t37, label %b23.e38
b23.t37:
  br label %b24
b23.e38:
  br label %b25
b24:
  %v103 = add i64 0, 0
  %v104 = add i64 0, 1
  %st38 = getelementptr i64, ptr %v0, i64 0
  store i64 %v103, ptr %st38
  %st39 = getelementptr i64, ptr %v0, i64 1
  store i64 %v104, ptr %st39
  %v429 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v429, i64 0
  store i64 %v5, ptr %st40
  ret void
b25:
  br label %b26
b26:
  %v105 = add i64 0, 9218868437227405312
  %v106 = or i64 %v55, %v105
  %v107 = add i64 0, 0
  %st41 = getelementptr i64, ptr %v0, i64 0
  store i64 %v106, ptr %st41
  %st42 = getelementptr i64, ptr %v0, i64 1
  store i64 %v107, ptr %st42
  %v430 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v430, i64 0
  store i64 %v5, ptr %st43
  ret void
b27:
  %v108.p = getelementptr i64, ptr %v4, i64 0
  %v108 = load i64, ptr %v108.p
  %v109.p = getelementptr i64, ptr %v4, i64 1
  %v109 = load i64, ptr %v109.p
  %v110.p = getelementptr i64, ptr %v4, i64 2
  %v110 = load i64, ptr %v110.p
  %v111.p = getelementptr i64, ptr %v7, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = getelementptr i64, ptr @"str.2", i64 0
  %v113 = add i64 0, 3
  %v114 = add i64 0, 0
  %v115 = getelementptr i64, ptr %s4, i64 0
  %v116 = ptrtoint ptr %v112 to i64
  %st44 = getelementptr i64, ptr %v115, i64 0
  store i64 %v116, ptr %st44
  %st45 = getelementptr i64, ptr %v115, i64 1
  store i64 %v113, ptr %st45
  %st46 = getelementptr i64, ptr %v115, i64 2
  store i64 %v114, ptr %st46
  %v117.p = getelementptr i64, ptr %v115, i64 0
  %v117 = load i64, ptr %v117.p
  %v118.p = getelementptr i64, ptr %v115, i64 1
  %v118 = load i64, ptr %v118.p
  %v119.p = getelementptr i64, ptr %v115, i64 2
  %v119 = load i64, ptr %v119.p
  %v120 = call i64 @"std/internal/floatfmt.wordAt"(i64 %v108, i64 %v109, i64 %v110, i64 %v111, i64 %v117, i64 %v118, i64 %v119)
  %c.b27 = icmp ne i64 %v120, 0
  br i1 %c.b27, label %b27.t48, label %b27.e49
b27.t48:
  br label %b28
b27.e49:
  br label %b29
b28:
  %v121.p = getelementptr i64, ptr %v7, i64 0
  %v121 = load i64, ptr %v121.p
  %v122 = add i64 0, 3
  %v123 = add i64 %v121, %v122
  %v124.p = getelementptr i64, ptr %v4, i64 1
  %v124 = load i64, ptr %v124.p
  %v125.c = icmp ne i64 %v123, %v124
  %v125 = zext i1 %v125.c to i64
  %c.b28 = icmp ne i64 %v125, 0
  br i1 %c.b28, label %b28.t50, label %b28.e51
b28.t50:
  br label %b31
b28.e51:
  br label %b30
b29:
  br label %b35
b30:
  %v127.p = getelementptr i64, ptr %v7, i64 0
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 0, 0
  %v129.c = icmp ne i64 %v127, %v128
  %v129 = zext i1 %v129.c to i64
  br label %b31
b31:
  %v126 = phi i64 [ %v125, %b28.t50 ], [ %v129, %b30 ]
  %c.b31 = icmp ne i64 %v126, 0
  br i1 %c.b31, label %b31.t52, label %b31.e53
b31.t52:
  br label %b32
b31.e53:
  br label %b33
b32:
  %v130 = add i64 0, 0
  %v131 = add i64 0, 1
  %st53 = getelementptr i64, ptr %v0, i64 0
  store i64 %v130, ptr %st53
  %st54 = getelementptr i64, ptr %v0, i64 1
  store i64 %v131, ptr %st54
  %v431 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v431, i64 0
  store i64 %v5, ptr %st55
  ret void
b33:
  br label %b34
b34:
  %v132 = add i64 0, 9221120237041090561
  %v133 = add i64 0, 0
  %st56 = getelementptr i64, ptr %v0, i64 0
  store i64 %v132, ptr %st56
  %st57 = getelementptr i64, ptr %v0, i64 1
  store i64 %v133, ptr %st57
  %v432 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v432, i64 0
  store i64 %v5, ptr %st58
  ret void
b35:
  %v433 = getelementptr i64, ptr @"rt.meta", i64 0
  %v134.p = getelementptr i64, ptr %v433, i64 0
  %v134 = load i64, ptr %v134.p
  %v135 = add i64 0, 0
  %v136 = call ptr @"rt.region_alloc"(i64 %v134, i64 %v135)
  %v137 = add i64 0, 0
  %v138 = getelementptr i64, ptr %s4, i64 0
  %v139 = ptrtoint ptr %v136 to i64
  %st59 = getelementptr i64, ptr %v138, i64 0
  store i64 %v139, ptr %st59
  %st60 = getelementptr i64, ptr %v138, i64 1
  store i64 %v137, ptr %st60
  %st61 = getelementptr i64, ptr %v138, i64 2
  store i64 %v134, ptr %st61
  %v140 = getelementptr i64, ptr %s3, i64 0
  %v141.p = getelementptr i64, ptr %v138, i64 0
  %v141 = load i64, ptr %v141.p
  %st62 = getelementptr i64, ptr %v140, i64 0
  store i64 %v141, ptr %st62
  %v142.p = getelementptr i64, ptr %v138, i64 1
  %v142 = load i64, ptr %v142.p
  %st63 = getelementptr i64, ptr %v140, i64 1
  store i64 %v142, ptr %st63
  %v143.p = getelementptr i64, ptr %v138, i64 2
  %v143 = load i64, ptr %v143.p
  %st64 = getelementptr i64, ptr %v140, i64 2
  store i64 %v143, ptr %st64
  %v144 = add i64 0, 0
  %v145 = getelementptr i64, ptr %s6, i64 0
  %st65 = getelementptr i64, ptr %v145, i64 0
  store i64 %v144, ptr %st65
  %v146 = add i64 0, 0
  %v147 = getelementptr i64, ptr %s7, i64 0
  %st66 = getelementptr i64, ptr %v147, i64 0
  store i64 %v146, ptr %st66
  %v148 = add i64 0, 0
  %v149 = getelementptr i64, ptr %s8, i64 0
  %st67 = getelementptr i64, ptr %v149, i64 0
  store i64 %v148, ptr %st67
  %v434 = getelementptr i64, ptr @"rt.meta", i64 0
  %v150.p = getelementptr i64, ptr %v434, i64 0
  %v150 = load i64, ptr %v150.p
  br label %b36
b36:
  %v435 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v435, i64 0
  store i64 %v150, ptr %st68
  %v151.p = getelementptr i64, ptr %v7, i64 0
  %v151 = load i64, ptr %v151.p
  %v152.p = getelementptr i64, ptr %v4, i64 1
  %v152 = load i64, ptr %v152.p
  %v153.c = icmp slt i64 %v151, %v152
  %v153 = zext i1 %v153.c to i64
  %c.b36 = icmp ne i64 %v153, 0
  br i1 %c.b36, label %b36.t70, label %b36.e71
b36.t70:
  br label %b39
b36.e71:
  br label %b40
b37:
  call void @"rt.region_enter"()
  %v436 = getelementptr i64, ptr @"rt.meta", i64 0
  %v191.p = getelementptr i64, ptr %v436, i64 0
  %v191 = load i64, ptr %v191.p
  %v192.p = getelementptr i64, ptr %v7, i64 0
  %v192 = load i64, ptr %v192.p
  %v193.p = getelementptr i64, ptr %v4, i64 1
  %v193 = load i64, ptr %v193.p
  %v194.c = icmp uge i64 %v192, %v193
  %v194 = zext i1 %v194.c to i64
  %c.b37 = icmp ne i64 %v194, 0
  br i1 %c.b37, label %b37.t72, label %b37.e73
b37.t72:
  br label %b53
b37.e73:
  br label %b54
b38:
  %v437 = getelementptr i64, ptr @"rt.meta", i64 0
  %st73 = getelementptr i64, ptr %v437, i64 0
  store i64 %v150, ptr %st73
  %v273.p = getelementptr i64, ptr %v149, i64 0
  %v273 = load i64, ptr %v273.p
  %v274 = add i64 0, 0
  %v275.c = icmp eq i64 %v273, %v274
  %v275 = zext i1 %v275.c to i64
  %c.b38 = icmp ne i64 %v275, 0
  br i1 %c.b38, label %b38.t75, label %b38.e76
b38.t75:
  br label %b73
b38.e76:
  br label %b74
b39:
  %v155.p = getelementptr i64, ptr %v7, i64 0
  %v155 = load i64, ptr %v155.p
  %v156.p = getelementptr i64, ptr %v4, i64 1
  %v156 = load i64, ptr %v156.p
  %v157.c = icmp uge i64 %v155, %v156
  %v157 = zext i1 %v157.c to i64
  %c.b39 = icmp ne i64 %v157, 0
  br i1 %c.b39, label %b39.t77, label %b39.e78
b39.t77:
  br label %b41
b39.e78:
  br label %b42
b40:
  %v154 = phi i64 [ %v153, %b36.e71 ], [ %v176, %b48 ]
  %c.b40 = icmp ne i64 %v154, 0
  br i1 %c.b40, label %b40.t79, label %b40.e80
b40.t79:
  br label %b37
b40.e80:
  br label %b38
b41:
  %v158 = add i64 0, 26
  call void @"rt.panic"(i64 %v158)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b42:
  %v159.p = getelementptr i64, ptr %v4, i64 0
  %v159 = load i64, ptr %v159.p
  %v160 = inttoptr i64 %v159 to ptr
  %v161 = getelementptr i8, ptr %v160, i64 %v155
  %v162.p = getelementptr i8, ptr %v161, i64 0
  %v162.b = load i8, ptr %v162.p
  %v162 = zext i8 %v162.b to i64
  %v163 = add i64 0, 48
  %v164.c = icmp sge i64 %v162, %v163
  %v164 = zext i1 %v164.c to i64
  %c.b42 = icmp ne i64 %v164, 0
  br i1 %c.b42, label %b42.t81, label %b42.e82
b42.t81:
  br label %b43
b42.e82:
  br label %b44
b43:
  %v166.p = getelementptr i64, ptr %v7, i64 0
  %v166 = load i64, ptr %v166.p
  %v167.p = getelementptr i64, ptr %v4, i64 1
  %v167 = load i64, ptr %v167.p
  %v168.c = icmp uge i64 %v166, %v167
  %v168 = zext i1 %v168.c to i64
  %c.b43 = icmp ne i64 %v168, 0
  br i1 %c.b43, label %b43.t83, label %b43.e84
b43.t83:
  br label %b45
b43.e84:
  br label %b46
b44:
  %v165 = phi i64 [ %v164, %b42.e82 ], [ %v175, %b46 ]
  %c.b44 = icmp ne i64 %v165, 0
  br i1 %c.b44, label %b44.t85, label %b44.e86
b44.t85:
  br label %b48
b44.e86:
  br label %b47
b45:
  %v169 = add i64 0, 27
  call void @"rt.panic"(i64 %v169)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b46:
  %v170.p = getelementptr i64, ptr %v4, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = inttoptr i64 %v170 to ptr
  %v172 = getelementptr i8, ptr %v171, i64 %v166
  %v173.p = getelementptr i8, ptr %v172, i64 0
  %v173.b = load i8, ptr %v173.p
  %v173 = zext i8 %v173.b to i64
  %v174 = add i64 0, 57
  %v175.c = icmp sle i64 %v173, %v174
  %v175 = zext i1 %v175.c to i64
  br label %b44
b47:
  %v177.p = getelementptr i64, ptr %v7, i64 0
  %v177 = load i64, ptr %v177.p
  %v178.p = getelementptr i64, ptr %v4, i64 1
  %v178 = load i64, ptr %v178.p
  %v179.c = icmp uge i64 %v177, %v178
  %v179 = zext i1 %v179.c to i64
  %c.b47 = icmp ne i64 %v179, 0
  br i1 %c.b47, label %b47.t87, label %b47.e88
b47.t87:
  br label %b49
b47.e88:
  br label %b50
b48:
  %v176 = phi i64 [ %v165, %b44.t85 ], [ %v187, %b52 ]
  br label %b40
b49:
  %v180 = add i64 0, 28
  call void @"rt.panic"(i64 %v180)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b50:
  %v181.p = getelementptr i64, ptr %v4, i64 0
  %v181 = load i64, ptr %v181.p
  %v182 = inttoptr i64 %v181 to ptr
  %v183 = getelementptr i8, ptr %v182, i64 %v177
  %v184.p = getelementptr i8, ptr %v183, i64 0
  %v184.b = load i8, ptr %v184.p
  %v184 = zext i8 %v184.b to i64
  %v185 = add i64 0, 46
  %v186.c = icmp eq i64 %v184, %v185
  %v186 = zext i1 %v186.c to i64
  %c.b50 = icmp ne i64 %v186, 0
  br i1 %c.b50, label %b50.t89, label %b50.e90
b50.t89:
  br label %b51
b50.e90:
  br label %b52
b51:
  %v188.p = getelementptr i64, ptr %v147, i64 0
  %v188 = load i64, ptr %v188.p
  %v189 = add i64 0, 1
  %v190 = xor i64 %v188, %v189
  br label %b52
b52:
  %v187 = phi i64 [ %v186, %b50.e90 ], [ %v190, %b51 ]
  br label %b48
b53:
  %v195 = add i64 0, 29
  call void @"rt.panic"(i64 %v195)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b54:
  %v196.p = getelementptr i64, ptr %v4, i64 0
  %v196 = load i64, ptr %v196.p
  %v197 = inttoptr i64 %v196 to ptr
  %v198 = getelementptr i8, ptr %v197, i64 %v192
  %v199.p = getelementptr i8, ptr %v198, i64 0
  %v199.b = load i8, ptr %v199.p
  %v199 = zext i8 %v199.b to i64
  %v200 = add i64 0, 46
  %v201.c = icmp eq i64 %v199, %v200
  %v201 = zext i1 %v201.c to i64
  %c.b54 = icmp ne i64 %v201, 0
  br i1 %c.b54, label %b54.t91, label %b54.e92
b54.t91:
  br label %b55
b54.e92:
  br label %b56
b55:
  %v202 = add i64 0, 1
  %v203 = add i64 %v5, %v202
  %v204 = add i64 0, 1
  %st92 = getelementptr i64, ptr %v147, i64 0
  store i64 %v204, ptr %st92
  br label %b72
b56:
  %v205 = add i64 0, 1
  %v206.p = getelementptr i64, ptr %v149, i64 0
  %v206 = load i64, ptr %v206.p
  %v207 = add i64 %v206, %v205
  %st93 = getelementptr i64, ptr %v149, i64 0
  store i64 %v207, ptr %st93
  %v208.p = getelementptr i64, ptr %v140, i64 1
  %v208 = load i64, ptr %v208.p
  %v209 = add i64 0, 0
  %v210.c = icmp sgt i64 %v208, %v209
  %v210 = zext i1 %v210.c to i64
  %c.b56 = icmp ne i64 %v210, 0
  br i1 %c.b56, label %b56.t95, label %b56.e96
b56.t95:
  br label %b58
b56.e96:
  br label %b57
b57:
  %v212.p = getelementptr i64, ptr %v7, i64 0
  %v212 = load i64, ptr %v212.p
  %v213.p = getelementptr i64, ptr %v4, i64 1
  %v213 = load i64, ptr %v213.p
  %v214.c = icmp uge i64 %v212, %v213
  %v214 = zext i1 %v214.c to i64
  %c.b57 = icmp ne i64 %v214, 0
  br i1 %c.b57, label %b57.t97, label %b57.e98
b57.t97:
  br label %b59
b57.e98:
  br label %b60
b58:
  %v211 = phi i64 [ %v210, %b56.t95 ], [ %v221, %b60 ]
  %c.b58 = icmp ne i64 %v211, 0
  br i1 %c.b58, label %b58.t99, label %b58.e100
b58.t99:
  br label %b61
b58.e100:
  br label %b62
b59:
  %v215 = add i64 0, 30
  call void @"rt.panic"(i64 %v215)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b60:
  %v216.p = getelementptr i64, ptr %v4, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = inttoptr i64 %v216 to ptr
  %v218 = getelementptr i8, ptr %v217, i64 %v212
  %v219.p = getelementptr i8, ptr %v218, i64 0
  %v219.b = load i8, ptr %v219.p
  %v219 = zext i8 %v219.b to i64
  %v220 = add i64 0, 48
  %v221.c = icmp ne i64 %v219, %v220
  %v221 = zext i1 %v221.c to i64
  br label %b58
b61:
  %v222 = add i64 0, 1
  %v223 = add i64 %v5, %v222
  %v224 = getelementptr i64, ptr %s4, i64 0
  %v225.p = getelementptr i64, ptr %v140, i64 0
  %v225 = load i64, ptr %v225.p
  %st100 = getelementptr i64, ptr %v224, i64 0
  store i64 %v225, ptr %st100
  %v226.p = getelementptr i64, ptr %v140, i64 1
  %v226 = load i64, ptr %v226.p
  %st101 = getelementptr i64, ptr %v224, i64 1
  store i64 %v226, ptr %st101
  %v227.p = getelementptr i64, ptr %v140, i64 2
  %v227 = load i64, ptr %v227.p
  %st102 = getelementptr i64, ptr %v224, i64 2
  store i64 %v227, ptr %st102
  %v228.p = getelementptr i64, ptr %v7, i64 0
  %v228 = load i64, ptr %v228.p
  %v229.p = getelementptr i64, ptr %v4, i64 1
  %v229 = load i64, ptr %v229.p
  %v230.c = icmp uge i64 %v228, %v229
  %v230 = zext i1 %v230.c to i64
  %c.b61 = icmp ne i64 %v230, 0
  br i1 %c.b61, label %b61.t104, label %b61.e105
b61.t104:
  br label %b63
b61.e105:
  br label %b64
b62:
  br label %b68
b63:
  %v231 = add i64 0, 31
  call void @"rt.panic"(i64 %v231)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b64:
  %v232.p = getelementptr i64, ptr %v4, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = inttoptr i64 %v232 to ptr
  %v234 = getelementptr i8, ptr %v233, i64 %v228
  %v235.p = getelementptr i8, ptr %v234, i64 0
  %v235.b = load i8, ptr %v235.p
  %v235 = zext i8 %v235.b to i64
  %v236 = add i64 0, 48
  %v237 = sub i64 %v235, %v236
  %v238.p = getelementptr i64, ptr %v224, i64 2
  %v238 = load i64, ptr %v238.p
  %v239.p = getelementptr i64, ptr %v224, i64 0
  %v239 = load i64, ptr %v239.p
  %v240.p = getelementptr i64, ptr %v224, i64 1
  %v240 = load i64, ptr %v240.p
  %v243 = add i64 0, 8
  %v244 = mul i64 %v240, %v243
  %v245 = add i64 %v239, %v244
  %v438 = getelementptr i64, ptr @"rt.meta", i64 0
  %v439 = getelementptr i64, ptr %v438, i64 %v238
  %v246.p = getelementptr i64, ptr %v439, i64 1
  %v246 = load ptr, ptr %v246.p
  %v247 = ptrtoint ptr %v246 to i64
  %v248.c = icmp eq i64 %v247, %v245
  %v248 = zext i1 %v248.c to i64
  %c.b64 = icmp ne i64 %v248, 0
  br i1 %c.b64, label %b64.t106, label %b64.e107
b64.t106:
  br label %b67
b64.e107:
  br label %b66
b65:
  %v241 = phi ptr [ %v256, %b66 ], [ %v251, %b67 ]
  %v242 = phi ptr [ %v257, %b66 ], [ %v250, %b67 ]
  %st107 = getelementptr i64, ptr %v242, i64 0
  store i64 %v237, ptr %st107
  %v258.p = getelementptr i64, ptr %v224, i64 1
  %v258 = load i64, ptr %v258.p
  %v259 = add i64 0, 1
  %v260 = add i64 %v258, %v259
  %v261 = getelementptr i64, ptr %s5, i64 0
  %v262 = ptrtoint ptr %v241 to i64
  %st108 = getelementptr i64, ptr %v261, i64 0
  store i64 %v262, ptr %st108
  %st109 = getelementptr i64, ptr %v261, i64 1
  store i64 %v260, ptr %st109
  %st110 = getelementptr i64, ptr %v261, i64 2
  store i64 %v238, ptr %st110
  %v263.p = getelementptr i64, ptr %v261, i64 0
  %v263 = load i64, ptr %v263.p
  %st111 = getelementptr i64, ptr %v140, i64 0
  store i64 %v263, ptr %st111
  %v264.p = getelementptr i64, ptr %v261, i64 1
  %v264 = load i64, ptr %v264.p
  %st112 = getelementptr i64, ptr %v140, i64 1
  store i64 %v264, ptr %st112
  %v265.p = getelementptr i64, ptr %v261, i64 2
  %v265 = load i64, ptr %v265.p
  %st113 = getelementptr i64, ptr %v140, i64 2
  store i64 %v265, ptr %st113
  br label %b68
b66:
  %v252 = add i64 0, 1
  %v253 = mul i64 %v240, %v252
  %v254 = add i64 0, 1
  %v255 = add i64 0, 1
  %v256 = call ptr @"rt.slice_grow"(i64 %v239, i64 %v240, i64 %v254, i64 %v238, i64 %v255)
  %v257 = getelementptr i64, ptr %v256, i64 %v253
  br label %b65
b67:
  %v249 = add i64 0, 1
  %v250 = call ptr @"rt.region_alloc"(i64 %v238, i64 %v249)
  %v251 = inttoptr i64 %v239 to ptr
  br label %b65
b68:
  %v266.p = getelementptr i64, ptr %v147, i64 0
  %v266 = load i64, ptr %v266.p
  %c.b68 = icmp ne i64 %v266, 0
  br i1 %c.b68, label %b68.t115, label %b68.e116
b68.t115:
  br label %b69
b68.e116:
  br label %b70
b69:
  %v267 = add i64 0, 1
  %v268.p = getelementptr i64, ptr %v145, i64 0
  %v268 = load i64, ptr %v268.p
  %v269 = sub i64 %v268, %v267
  %st116 = getelementptr i64, ptr %v145, i64 0
  store i64 %v269, ptr %st116
  br label %b71
b70:
  br label %b71
b71:
  br label %b72
b72:
  %v270 = add i64 0, 1
  %v271.p = getelementptr i64, ptr %v7, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 %v271, %v270
  %st117 = getelementptr i64, ptr %v7, i64 0
  store i64 %v272, ptr %st117
  br label %b36
b73:
  %v276 = add i64 0, 0
  %v277 = add i64 0, 1
  %st118 = getelementptr i64, ptr %v0, i64 0
  store i64 %v276, ptr %st118
  %st119 = getelementptr i64, ptr %v0, i64 1
  store i64 %v277, ptr %st119
  %v440 = getelementptr i64, ptr @"rt.meta", i64 0
  %st120 = getelementptr i64, ptr %v440, i64 0
  store i64 %v5, ptr %st120
  ret void
b74:
  br label %b75
b75:
  %v278.p = getelementptr i64, ptr %v7, i64 0
  %v278 = load i64, ptr %v278.p
  %v279.p = getelementptr i64, ptr %v4, i64 1
  %v279 = load i64, ptr %v279.p
  %v280.c = icmp slt i64 %v278, %v279
  %v280 = zext i1 %v280.c to i64
  %c.b75 = icmp ne i64 %v280, 0
  br i1 %c.b75, label %b75.t122, label %b75.e123
b75.t122:
  br label %b76
b75.e123:
  br label %b77
b76:
  %v282.p = getelementptr i64, ptr %v7, i64 0
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v4, i64 1
  %v283 = load i64, ptr %v283.p
  %v284.c = icmp uge i64 %v282, %v283
  %v284 = zext i1 %v284.c to i64
  %c.b76 = icmp ne i64 %v284, 0
  br i1 %c.b76, label %b76.t124, label %b76.e125
b76.t124:
  br label %b78
b76.e125:
  br label %b79
b77:
  %v281 = phi i64 [ %v280, %b75.e123 ], [ %v292, %b81 ]
  %c.b77 = icmp ne i64 %v281, 0
  br i1 %c.b77, label %b77.t126, label %b77.e127
b77.t126:
  br label %b84
b77.e127:
  br label %b85
b78:
  %v285 = add i64 0, 32
  call void @"rt.panic"(i64 %v285)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b79:
  %v286.p = getelementptr i64, ptr %v4, i64 0
  %v286 = load i64, ptr %v286.p
  %v287 = inttoptr i64 %v286 to ptr
  %v288 = getelementptr i8, ptr %v287, i64 %v282
  %v289.p = getelementptr i8, ptr %v288, i64 0
  %v289.b = load i8, ptr %v289.p
  %v289 = zext i8 %v289.b to i64
  %v290 = add i64 0, 101
  %v291.c = icmp eq i64 %v289, %v290
  %v291 = zext i1 %v291.c to i64
  %c.b79 = icmp ne i64 %v291, 0
  br i1 %c.b79, label %b79.t128, label %b79.e129
b79.t128:
  br label %b81
b79.e129:
  br label %b80
b80:
  %v293.p = getelementptr i64, ptr %v7, i64 0
  %v293 = load i64, ptr %v293.p
  %v294.p = getelementptr i64, ptr %v4, i64 1
  %v294 = load i64, ptr %v294.p
  %v295.c = icmp uge i64 %v293, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b80 = icmp ne i64 %v295, 0
  br i1 %c.b80, label %b80.t130, label %b80.e131
b80.t130:
  br label %b82
b80.e131:
  br label %b83
b81:
  %v292 = phi i64 [ %v291, %b79.t128 ], [ %v302, %b83 ]
  br label %b77
b82:
  %v296 = add i64 0, 33
  call void @"rt.panic"(i64 %v296)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b83:
  %v297.p = getelementptr i64, ptr %v4, i64 0
  %v297 = load i64, ptr %v297.p
  %v298 = inttoptr i64 %v297 to ptr
  %v299 = getelementptr i8, ptr %v298, i64 %v293
  %v300.p = getelementptr i8, ptr %v299, i64 0
  %v300.b = load i8, ptr %v300.p
  %v300 = zext i8 %v300.b to i64
  %v301 = add i64 0, 69
  %v302.c = icmp eq i64 %v300, %v301
  %v302 = zext i1 %v302.c to i64
  br label %b81
b84:
  %v303 = add i64 0, 1
  %v304.p = getelementptr i64, ptr %v7, i64 0
  %v304 = load i64, ptr %v304.p
  %v305 = add i64 %v304, %v303
  %st131 = getelementptr i64, ptr %v7, i64 0
  store i64 %v305, ptr %st131
  %v306 = add i64 0, 0
  %v307 = getelementptr i64, ptr %s9, i64 0
  %st132 = getelementptr i64, ptr %v307, i64 0
  store i64 %v306, ptr %st132
  %v308.p = getelementptr i64, ptr %v7, i64 0
  %v308 = load i64, ptr %v308.p
  %v309.p = getelementptr i64, ptr %v4, i64 1
  %v309 = load i64, ptr %v309.p
  %v310.c = icmp slt i64 %v308, %v309
  %v310 = zext i1 %v310.c to i64
  %c.b84 = icmp ne i64 %v310, 0
  br i1 %c.b84, label %b84.t134, label %b84.e135
b84.t134:
  br label %b86
b84.e135:
  br label %b87
b85:
  br label %b121
b86:
  %v312.p = getelementptr i64, ptr %v7, i64 0
  %v312 = load i64, ptr %v312.p
  %v313.p = getelementptr i64, ptr %v4, i64 1
  %v313 = load i64, ptr %v313.p
  %v314.c = icmp uge i64 %v312, %v313
  %v314 = zext i1 %v314.c to i64
  %c.b86 = icmp ne i64 %v314, 0
  br i1 %c.b86, label %b86.t136, label %b86.e137
b86.t136:
  br label %b88
b86.e137:
  br label %b89
b87:
  %v311 = phi i64 [ %v310, %b84.e135 ], [ %v322, %b91 ]
  %c.b87 = icmp ne i64 %v311, 0
  br i1 %c.b87, label %b87.t138, label %b87.e139
b87.t138:
  br label %b94
b87.e139:
  br label %b95
b88:
  %v315 = add i64 0, 34
  call void @"rt.panic"(i64 %v315)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b89:
  %v316.p = getelementptr i64, ptr %v4, i64 0
  %v316 = load i64, ptr %v316.p
  %v317 = inttoptr i64 %v316 to ptr
  %v318 = getelementptr i8, ptr %v317, i64 %v312
  %v319.p = getelementptr i8, ptr %v318, i64 0
  %v319.b = load i8, ptr %v319.p
  %v319 = zext i8 %v319.b to i64
  %v320 = add i64 0, 43
  %v321.c = icmp eq i64 %v319, %v320
  %v321 = zext i1 %v321.c to i64
  %c.b89 = icmp ne i64 %v321, 0
  br i1 %c.b89, label %b89.t140, label %b89.e141
b89.t140:
  br label %b91
b89.e141:
  br label %b90
b90:
  %v323.p = getelementptr i64, ptr %v7, i64 0
  %v323 = load i64, ptr %v323.p
  %v324.p = getelementptr i64, ptr %v4, i64 1
  %v324 = load i64, ptr %v324.p
  %v325.c = icmp uge i64 %v323, %v324
  %v325 = zext i1 %v325.c to i64
  %c.b90 = icmp ne i64 %v325, 0
  br i1 %c.b90, label %b90.t142, label %b90.e143
b90.t142:
  br label %b92
b90.e143:
  br label %b93
b91:
  %v322 = phi i64 [ %v321, %b89.t140 ], [ %v332, %b93 ]
  br label %b87
b92:
  %v326 = add i64 0, 35
  call void @"rt.panic"(i64 %v326)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b93:
  %v327.p = getelementptr i64, ptr %v4, i64 0
  %v327 = load i64, ptr %v327.p
  %v328 = inttoptr i64 %v327 to ptr
  %v329 = getelementptr i8, ptr %v328, i64 %v323
  %v330.p = getelementptr i8, ptr %v329, i64 0
  %v330.b = load i8, ptr %v330.p
  %v330 = zext i8 %v330.b to i64
  %v331 = add i64 0, 45
  %v332.c = icmp eq i64 %v330, %v331
  %v332 = zext i1 %v332.c to i64
  br label %b91
b94:
  %v333.p = getelementptr i64, ptr %v7, i64 0
  %v333 = load i64, ptr %v333.p
  %v334.p = getelementptr i64, ptr %v4, i64 1
  %v334 = load i64, ptr %v334.p
  %v335.c = icmp uge i64 %v333, %v334
  %v335 = zext i1 %v335.c to i64
  %c.b94 = icmp ne i64 %v335, 0
  br i1 %c.b94, label %b94.t144, label %b94.e145
b94.t144:
  br label %b96
b94.e145:
  br label %b97
b95:
  br label %b98
b96:
  %v336 = add i64 0, 36
  call void @"rt.panic"(i64 %v336)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b97:
  %v337.p = getelementptr i64, ptr %v4, i64 0
  %v337 = load i64, ptr %v337.p
  %v338 = inttoptr i64 %v337 to ptr
  %v339 = getelementptr i8, ptr %v338, i64 %v333
  %v340.p = getelementptr i8, ptr %v339, i64 0
  %v340.b = load i8, ptr %v340.p
  %v340 = zext i8 %v340.b to i64
  %v341 = add i64 0, 45
  %v342.c = icmp eq i64 %v340, %v341
  %v342 = zext i1 %v342.c to i64
  %st145 = getelementptr i64, ptr %v307, i64 0
  store i64 %v342, ptr %st145
  %v343 = add i64 0, 1
  %v344.p = getelementptr i64, ptr %v7, i64 0
  %v344 = load i64, ptr %v344.p
  %v345 = add i64 %v344, %v343
  %st146 = getelementptr i64, ptr %v7, i64 0
  store i64 %v345, ptr %st146
  br label %b98
b98:
  %v346.p = getelementptr i64, ptr %v7, i64 0
  %v346 = load i64, ptr %v346.p
  %v347.p = getelementptr i64, ptr %v4, i64 1
  %v347 = load i64, ptr %v347.p
  %v348.c = icmp sge i64 %v346, %v347
  %v348 = zext i1 %v348.c to i64
  %c.b98 = icmp ne i64 %v348, 0
  br i1 %c.b98, label %b98.t148, label %b98.e149
b98.t148:
  br label %b99
b98.e149:
  br label %b100
b99:
  %v349 = add i64 0, 0
  %v350 = add i64 0, 1
  %st149 = getelementptr i64, ptr %v0, i64 0
  store i64 %v349, ptr %st149
  %st150 = getelementptr i64, ptr %v0, i64 1
  store i64 %v350, ptr %st150
  %v441 = getelementptr i64, ptr @"rt.meta", i64 0
  %st151 = getelementptr i64, ptr %v441, i64 0
  store i64 %v5, ptr %st151
  ret void
b100:
  br label %b101
b101:
  %v351 = add i64 0, 0
  %v352 = getelementptr i64, ptr %s10, i64 0
  %st152 = getelementptr i64, ptr %v352, i64 0
  store i64 %v351, ptr %st152
  %v442 = getelementptr i64, ptr @"rt.meta", i64 0
  %v353.p = getelementptr i64, ptr %v442, i64 0
  %v353 = load i64, ptr %v353.p
  br label %b102
b102:
  %v443 = getelementptr i64, ptr @"rt.meta", i64 0
  %st153 = getelementptr i64, ptr %v443, i64 0
  store i64 %v353, ptr %st153
  %v354.p = getelementptr i64, ptr %v7, i64 0
  %v354 = load i64, ptr %v354.p
  %v355.p = getelementptr i64, ptr %v4, i64 1
  %v355 = load i64, ptr %v355.p
  %v356.c = icmp slt i64 %v354, %v355
  %v356 = zext i1 %v356.c to i64
  %c.b102 = icmp ne i64 %v356, 0
  br i1 %c.b102, label %b102.t155, label %b102.e156
b102.t155:
  br label %b105
b102.e156:
  br label %b106
b103:
  call void @"rt.region_enter"()
  %v444 = getelementptr i64, ptr @"rt.meta", i64 0
  %v379.p = getelementptr i64, ptr %v444, i64 0
  %v379 = load i64, ptr %v379.p
  %v380.p = getelementptr i64, ptr %v352, i64 0
  %v380 = load i64, ptr %v380.p
  %v381 = add i64 0, 100000000
  %v382.c = icmp slt i64 %v380, %v381
  %v382 = zext i1 %v382.c to i64
  %c.b103 = icmp ne i64 %v382, 0
  br i1 %c.b103, label %b103.t157, label %b103.e158
b103.t157:
  br label %b113
b103.e158:
  br label %b114
b104:
  %v445 = getelementptr i64, ptr @"rt.meta", i64 0
  %st158 = getelementptr i64, ptr %v445, i64 0
  store i64 %v353, ptr %st158
  %v402.p = getelementptr i64, ptr %v307, i64 0
  %v402 = load i64, ptr %v402.p
  %c.b104 = icmp ne i64 %v402, 0
  br i1 %c.b104, label %b104.t160, label %b104.e161
b104.t160:
  br label %b118
b104.e161:
  br label %b119
b105:
  %v358.p = getelementptr i64, ptr %v7, i64 0
  %v358 = load i64, ptr %v358.p
  %v359.p = getelementptr i64, ptr %v4, i64 1
  %v359 = load i64, ptr %v359.p
  %v360.c = icmp uge i64 %v358, %v359
  %v360 = zext i1 %v360.c to i64
  %c.b105 = icmp ne i64 %v360, 0
  br i1 %c.b105, label %b105.t162, label %b105.e163
b105.t162:
  br label %b107
b105.e163:
  br label %b108
b106:
  %v357 = phi i64 [ %v356, %b102.e156 ], [ %v367, %b108 ]
  %c.b106 = icmp ne i64 %v357, 0
  br i1 %c.b106, label %b106.t164, label %b106.e165
b106.t164:
  br label %b109
b106.e165:
  br label %b110
b107:
  %v361 = add i64 0, 37
  call void @"rt.panic"(i64 %v361)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b108:
  %v362.p = getelementptr i64, ptr %v4, i64 0
  %v362 = load i64, ptr %v362.p
  %v363 = inttoptr i64 %v362 to ptr
  %v364 = getelementptr i8, ptr %v363, i64 %v358
  %v365.p = getelementptr i8, ptr %v364, i64 0
  %v365.b = load i8, ptr %v365.p
  %v365 = zext i8 %v365.b to i64
  %v366 = add i64 0, 48
  %v367.c = icmp sge i64 %v365, %v366
  %v367 = zext i1 %v367.c to i64
  br label %b106
b109:
  %v369.p = getelementptr i64, ptr %v7, i64 0
  %v369 = load i64, ptr %v369.p
  %v370.p = getelementptr i64, ptr %v4, i64 1
  %v370 = load i64, ptr %v370.p
  %v371.c = icmp uge i64 %v369, %v370
  %v371 = zext i1 %v371.c to i64
  %c.b109 = icmp ne i64 %v371, 0
  br i1 %c.b109, label %b109.t166, label %b109.e167
b109.t166:
  br label %b111
b109.e167:
  br label %b112
b110:
  %v368 = phi i64 [ %v357, %b106.e165 ], [ %v378, %b112 ]
  %c.b110 = icmp ne i64 %v368, 0
  br i1 %c.b110, label %b110.t168, label %b110.e169
b110.t168:
  br label %b103
b110.e169:
  br label %b104
b111:
  %v372 = add i64 0, 38
  call void @"rt.panic"(i64 %v372)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b112:
  %v373.p = getelementptr i64, ptr %v4, i64 0
  %v373 = load i64, ptr %v373.p
  %v374 = inttoptr i64 %v373 to ptr
  %v375 = getelementptr i8, ptr %v374, i64 %v369
  %v376.p = getelementptr i8, ptr %v375, i64 0
  %v376.b = load i8, ptr %v376.p
  %v376 = zext i8 %v376.b to i64
  %v377 = add i64 0, 57
  %v378.c = icmp sle i64 %v376, %v377
  %v378 = zext i1 %v378.c to i64
  br label %b110
b113:
  %v383 = add i64 0, 1
  %v384 = add i64 %v5, %v383
  %v385.p = getelementptr i64, ptr %v352, i64 0
  %v385 = load i64, ptr %v385.p
  %v386 = add i64 0, 10
  %v387 = mul i64 %v385, %v386
  %v388.p = getelementptr i64, ptr %v7, i64 0
  %v388 = load i64, ptr %v388.p
  %v389.p = getelementptr i64, ptr %v4, i64 1
  %v389 = load i64, ptr %v389.p
  %v390.c = icmp uge i64 %v388, %v389
  %v390 = zext i1 %v390.c to i64
  %c.b113 = icmp ne i64 %v390, 0
  br i1 %c.b113, label %b113.t170, label %b113.e171
b113.t170:
  br label %b115
b113.e171:
  br label %b116
b114:
  br label %b117
b115:
  %v391 = add i64 0, 39
  call void @"rt.panic"(i64 %v391)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b116:
  %v392.p = getelementptr i64, ptr %v4, i64 0
  %v392 = load i64, ptr %v392.p
  %v393 = inttoptr i64 %v392 to ptr
  %v394 = getelementptr i8, ptr %v393, i64 %v388
  %v395.p = getelementptr i8, ptr %v394, i64 0
  %v395.b = load i8, ptr %v395.p
  %v395 = zext i8 %v395.b to i64
  %v396 = add i64 %v387, %v395
  %v397 = add i64 0, 48
  %v398 = sub i64 %v396, %v397
  %st171 = getelementptr i64, ptr %v352, i64 0
  store i64 %v398, ptr %st171
  br label %b117
b117:
  %v399 = add i64 0, 1
  %v400.p = getelementptr i64, ptr %v7, i64 0
  %v400 = load i64, ptr %v400.p
  %v401 = add i64 %v400, %v399
  %st172 = getelementptr i64, ptr %v7, i64 0
  store i64 %v401, ptr %st172
  br label %b102
b118:
  %v403.p = getelementptr i64, ptr %v145, i64 0
  %v403 = load i64, ptr %v403.p
  %v404.p = getelementptr i64, ptr %v352, i64 0
  %v404 = load i64, ptr %v404.p
  %v405 = sub i64 %v403, %v404
  %st173 = getelementptr i64, ptr %v145, i64 0
  store i64 %v405, ptr %st173
  br label %b120
b119:
  %v406.p = getelementptr i64, ptr %v145, i64 0
  %v406 = load i64, ptr %v406.p
  %v407.p = getelementptr i64, ptr %v352, i64 0
  %v407 = load i64, ptr %v407.p
  %v408 = add i64 %v406, %v407
  %st174 = getelementptr i64, ptr %v145, i64 0
  store i64 %v408, ptr %st174
  br label %b120
b120:
  br label %b121
b121:
  %v409.p = getelementptr i64, ptr %v7, i64 0
  %v409 = load i64, ptr %v409.p
  %v410.p = getelementptr i64, ptr %v4, i64 1
  %v410 = load i64, ptr %v410.p
  %v411.c = icmp ne i64 %v409, %v410
  %v411 = zext i1 %v411.c to i64
  %c.b121 = icmp ne i64 %v411, 0
  br i1 %c.b121, label %b121.t176, label %b121.e177
b121.t176:
  br label %b122
b121.e177:
  br label %b123
b122:
  %v412 = add i64 0, 0
  %v413 = add i64 0, 1
  %st177 = getelementptr i64, ptr %v0, i64 0
  store i64 %v412, ptr %st177
  %st178 = getelementptr i64, ptr %v0, i64 1
  store i64 %v413, ptr %st178
  %v446 = getelementptr i64, ptr @"rt.meta", i64 0
  %st179 = getelementptr i64, ptr %v446, i64 0
  store i64 %v5, ptr %st179
  ret void
b123:
  br label %b124
b124:
  %v414 = getelementptr i64, ptr %s11, i64 0
  %v415 = add i64 0, 1
  %v416 = add i64 %v5, %v415
  %v417.p = getelementptr i64, ptr %v145, i64 0
  %v417 = load i64, ptr %v417.p
  %v418 = getelementptr i64, ptr @"rt.meta", i64 0
  %st180 = getelementptr i64, ptr %v418, i64 2572
  store i64 %v416, ptr %st180
  call void @"std/internal/floatfmt.decimalBits"(ptr %v414, ptr %v140, i64 %v417)
  %v419.p = getelementptr i64, ptr %v414, i64 0
  %v419 = load i64, ptr %v419.p
  %v420.p = getelementptr i64, ptr %v414, i64 1
  %v420 = load i64, ptr %v420.p
  %v421 = add i64 0, 1
  %v422 = xor i64 %v420, %v421
  %c.b124 = icmp ne i64 %v422, 0
  br i1 %c.b124, label %b124.t182, label %b124.e183
b124.t182:
  br label %b125
b124.e183:
  br label %b126
b125:
  %v423 = add i64 0, 9218868437227405312
  %v424 = or i64 %v55, %v423
  %v425 = add i64 0, 2
  %st183 = getelementptr i64, ptr %v0, i64 0
  store i64 %v424, ptr %st183
  %st184 = getelementptr i64, ptr %v0, i64 1
  store i64 %v425, ptr %st184
  %v447 = getelementptr i64, ptr @"rt.meta", i64 0
  %st185 = getelementptr i64, ptr %v447, i64 0
  store i64 %v5, ptr %st185
  ret void
b126:
  br label %b127
b127:
  %v426 = or i64 %v55, %v419
  %v427 = add i64 0, 0
  %st186 = getelementptr i64, ptr %v0, i64 0
  store i64 %v426, ptr %st186
  %st187 = getelementptr i64, ptr %v0, i64 1
  store i64 %v427, ptr %st187
  %v448 = getelementptr i64, ptr @"rt.meta", i64 0
  %st188 = getelementptr i64, ptr %v448, i64 0
  store i64 %v5, ptr %st188
  ret void
}

define internal i64 @"std/internal/floatfmt.wordAt"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s4 = alloca [1 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
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
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v60, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = getelementptr i64, ptr %s2, i64 0
  %v11.p = getelementptr i64, ptr %v8, i64 0
  %v11 = load i64, ptr %v11.p
  %st6 = getelementptr i64, ptr %v10, i64 0
  store i64 %v11, ptr %st6
  %v12.p = getelementptr i64, ptr %v8, i64 1
  %v12 = load i64, ptr %v12.p
  %st7 = getelementptr i64, ptr %v10, i64 1
  store i64 %v12, ptr %st7
  %v13.p = getelementptr i64, ptr %v8, i64 2
  %v13 = load i64, ptr %v13.p
  %st8 = getelementptr i64, ptr %v10, i64 2
  store i64 %v13, ptr %st8
  %v14.p = getelementptr i64, ptr %v10, i64 1
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 %v3, %v14
  %v16.p = getelementptr i64, ptr %v7, i64 1
  %v16 = load i64, ptr %v16.p
  %v17.c = icmp sgt i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b0 = icmp ne i64 %v17, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v18 = add i64 0, 0
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v61, i64 0
  store i64 %v9, ptr %st11
  ret i64 %v18
b2:
  br label %b3
b3:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v62, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %v21.p = getelementptr i64, ptr %v10, i64 1
  %v21 = load i64, ptr %v21.p
  %v22 = getelementptr i64, ptr %s3, i64 0
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %v23.p = getelementptr i64, ptr %v63, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = getelementptr i64, ptr %s4, i64 0
  %st12 = getelementptr i64, ptr %v24, i64 0
  store i64 %v20, ptr %st12
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %v25.p = getelementptr i64, ptr %v64, i64 0
  %v25 = load i64, ptr %v25.p
  br label %b6
b4:
  %v65 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v65, i64 0
  store i64 %v19, ptr %st13
  %v59 = add i64 0, 1
  %v66 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v66, i64 0
  store i64 %v9, ptr %st14
  ret i64 %v59
b5:
  br label %b4
b6:
  %v67 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v67, i64 0
  store i64 %v25, ptr %st15
  %v26.p = getelementptr i64, ptr %v24, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.c = icmp slt i64 %v26, %v21
  %v27 = zext i1 %v27.c to i64
  %c.b6 = icmp ne i64 %v27, 0
  br i1 %c.b6, label %b6.t17, label %b6.e18
b6.t17:
  br label %b7
b6.e18:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v68 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v68, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v24, i64 0
  %v29 = load i64, ptr %v29.p
  %v69 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v69, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 %v3, %v29
  %v32.p = getelementptr i64, ptr %v7, i64 1
  %v32 = load i64, ptr %v32.p
  %v33.c = icmp uge i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b7 = icmp ne i64 %v33, 0
  br i1 %c.b7, label %b7.t19, label %b7.e20
b7.t19:
  br label %b10
b7.e20:
  br label %b11
b8:
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v70, i64 0
  store i64 %v25, ptr %st20
  br label %b5
b9:
  %v71 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v71, i64 0
  store i64 %v30, ptr %st21
  %v56 = add i64 0, 1
  %v57.p = getelementptr i64, ptr %v24, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 %v57, %v56
  %st22 = getelementptr i64, ptr %v24, i64 0
  store i64 %v58, ptr %st22
  br label %b6
b10:
  %v34 = add i64 0, 40
  call void @"rt.panic"(i64 %v34)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v35.p = getelementptr i64, ptr %v7, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = inttoptr i64 %v35 to ptr
  %v37 = getelementptr i8, ptr %v36, i64 %v31
  %v38.p = getelementptr i8, ptr %v37, i64 0
  %v38.b = load i8, ptr %v38.p
  %v38 = zext i8 %v38.b to i64
  %v39 = add i64 0, 65
  %v40.c = icmp sge i64 %v38, %v39
  %v40 = zext i1 %v40.c to i64
  %c.b11 = icmp ne i64 %v40, 0
  br i1 %c.b11, label %b11.t24, label %b11.e25
b11.t24:
  br label %b12
b11.e25:
  br label %b13
b12:
  %v42 = add i64 0, 90
  %v43.c = icmp sle i64 %v38, %v42
  %v43 = zext i1 %v43.c to i64
  br label %b13
b13:
  %v41 = phi i64 [ %v40, %b11.e25 ], [ %v43, %b12 ]
  %c.b13 = icmp ne i64 %v41, 0
  br i1 %c.b13, label %b13.t26, label %b13.e27
b13.t26:
  br label %b14
b13.e27:
  br label %b15
b14:
  %v44 = add i64 0, 32
  %v45 = add i64 %v38, %v44
  br label %b16
b15:
  br label %b16
b16:
  %v46 = phi i64 [ %v45, %b14 ], [ %v38, %b15 ]
  %v47.p = getelementptr i64, ptr %v10, i64 1
  %v47 = load i64, ptr %v47.p
  %v48.c = icmp uge i64 %v29, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b16 = icmp ne i64 %v48, 0
  br i1 %c.b16, label %b16.t28, label %b16.e29
b16.t28:
  br label %b17
b16.e29:
  br label %b18
b17:
  %v49 = add i64 0, 41
  call void @"rt.panic"(i64 %v49)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v50.p = getelementptr i64, ptr %v10, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = inttoptr i64 %v50 to ptr
  %v52 = getelementptr i8, ptr %v51, i64 %v29
  %v53.p = getelementptr i8, ptr %v52, i64 0
  %v53.b = load i8, ptr %v53.p
  %v53 = zext i8 %v53.b to i64
  %v54.c = icmp ne i64 %v46, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b18 = icmp ne i64 %v54, 0
  br i1 %c.b18, label %b18.t30, label %b18.e31
b18.t30:
  br label %b19
b18.e31:
  br label %b20
b19:
  %v55 = add i64 0, 0
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v72, i64 0
  store i64 %v9, ptr %st31
  ret i64 %v55
b20:
  br label %b21
b21:
  br label %b9
}

define internal void @"std/internal/floatfmt.decimalBits"(ptr %v0, ptr %v1, i64 %v2) #0 {
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
  %v262 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v262, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2572
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %v7.c = icmp eq i64 %v5, %v6
  %v7 = zext i1 %v7.c to i64
  %v8 = mul i64 %v7, %v3
  %v9 = add i64 %v5, %v8
  %v10.p = getelementptr i64, ptr %v1, i64 1
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %v12.c = icmp eq i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v13 = add i64 0, 0
  %v14 = add i64 0, 1
  %st2 = getelementptr i64, ptr %v0, i64 0
  store i64 %v13, ptr %st2
  %st3 = getelementptr i64, ptr %v0, i64 1
  store i64 %v14, ptr %st3
  %v263 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v263, i64 0
  store i64 %v3, ptr %st4
  ret void
b2:
  br label %b3
b3:
  %v15.p = getelementptr i64, ptr %v1, i64 1
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 %v15, %v2
  %v17 = add i64 0, 324
  %v18 = add i64 0, 0
  %v19 = sub i64 %v18, %v17
  %v20.c = icmp slt i64 %v16, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b3 = icmp ne i64 %v20, 0
  br i1 %c.b3, label %b3.t6, label %b3.e7
b3.t6:
  br label %b4
b3.e7:
  br label %b5
b4:
  %v21 = add i64 0, 0
  %v22 = add i64 0, 1
  %st7 = getelementptr i64, ptr %v0, i64 0
  store i64 %v21, ptr %st7
  %st8 = getelementptr i64, ptr %v0, i64 1
  store i64 %v22, ptr %st8
  %v264 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v264, i64 0
  store i64 %v3, ptr %st9
  ret void
b5:
  br label %b6
b6:
  %v23 = add i64 0, 310
  %v24.c = icmp sgt i64 %v16, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b6 = icmp ne i64 %v24, 0
  br i1 %c.b6, label %b6.t11, label %b6.e12
b6.t11:
  br label %b7
b6.e12:
  br label %b8
b7:
  %v25 = add i64 0, 0
  %v26 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v25, ptr %st12
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v26, ptr %st13
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v265, i64 0
  store i64 %v3, ptr %st14
  ret void
b8:
  br label %b9
b9:
  %v27 = add i64 0, 0
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v266, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 1
  %v30 = call ptr @"rt.region_alloc"(i64 %v28, i64 %v29)
  %st15 = getelementptr i64, ptr %v30, i64 0
  store i64 %v27, ptr %st15
  %v31 = add i64 0, 1
  %v32 = getelementptr i64, ptr %s0, i64 0
  %v33 = ptrtoint ptr %v30 to i64
  %st16 = getelementptr i64, ptr %v32, i64 0
  store i64 %v33, ptr %st16
  %st17 = getelementptr i64, ptr %v32, i64 1
  store i64 %v31, ptr %st17
  %st18 = getelementptr i64, ptr %v32, i64 2
  store i64 %v28, ptr %st18
  %v34 = getelementptr i64, ptr %s1, i64 0
  %v35.p = getelementptr i64, ptr %v32, i64 0
  %v35 = load i64, ptr %v35.p
  %st19 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st19
  %v36.p = getelementptr i64, ptr %v32, i64 1
  %v36 = load i64, ptr %v36.p
  %st20 = getelementptr i64, ptr %v34, i64 1
  store i64 %v36, ptr %st20
  %v37.p = getelementptr i64, ptr %v32, i64 2
  %v37 = load i64, ptr %v37.p
  %st21 = getelementptr i64, ptr %v34, i64 2
  store i64 %v37, ptr %st21
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v267, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40.p = getelementptr i64, ptr %v1, i64 1
  %v40 = load i64, ptr %v40.p
  %v41 = getelementptr i64, ptr %s2, i64 0
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v268, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = getelementptr i64, ptr %s3, i64 0
  %st22 = getelementptr i64, ptr %v43, i64 0
  store i64 %v39, ptr %st22
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v44.p = getelementptr i64, ptr %v269, i64 0
  %v44 = load i64, ptr %v44.p
  br label %b12
b10:
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v270, i64 0
  store i64 %v38, ptr %st23
  %v64 = add i64 0, 1
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v271, i64 0
  %v65 = load i64, ptr %v65.p
  %v66 = add i64 0, 1
  %v67 = call ptr @"rt.region_alloc"(i64 %v65, i64 %v66)
  %st24 = getelementptr i64, ptr %v67, i64 0
  store i64 %v64, ptr %st24
  %v68 = add i64 0, 1
  %v69 = getelementptr i64, ptr %s0, i64 0
  %v70 = ptrtoint ptr %v67 to i64
  %st25 = getelementptr i64, ptr %v69, i64 0
  store i64 %v70, ptr %st25
  %st26 = getelementptr i64, ptr %v69, i64 1
  store i64 %v68, ptr %st26
  %st27 = getelementptr i64, ptr %v69, i64 2
  store i64 %v65, ptr %st27
  %v71 = getelementptr i64, ptr %s4, i64 0
  %v72.p = getelementptr i64, ptr %v69, i64 0
  %v72 = load i64, ptr %v72.p
  %st28 = getelementptr i64, ptr %v71, i64 0
  store i64 %v72, ptr %st28
  %v73.p = getelementptr i64, ptr %v69, i64 1
  %v73 = load i64, ptr %v73.p
  %st29 = getelementptr i64, ptr %v71, i64 1
  store i64 %v73, ptr %st29
  %v74.p = getelementptr i64, ptr %v69, i64 2
  %v74 = load i64, ptr %v74.p
  %st30 = getelementptr i64, ptr %v71, i64 2
  store i64 %v74, ptr %st30
  %v75 = add i64 0, 0
  %v76.c = icmp sge i64 %v2, %v75
  %v76 = zext i1 %v76.c to i64
  %c.b10 = icmp ne i64 %v76, 0
  br i1 %c.b10, label %b10.t32, label %b10.e33
b10.t32:
  br label %b18
b10.e33:
  br label %b19
b11:
  br label %b10
b12:
  %v272 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v272, i64 0
  store i64 %v44, ptr %st33
  %v45.p = getelementptr i64, ptr %v43, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.c = icmp slt i64 %v45, %v40
  %v46 = zext i1 %v46.c to i64
  %c.b12 = icmp ne i64 %v46, 0
  br i1 %c.b12, label %b12.t35, label %b12.e36
b12.t35:
  br label %b13
b12.e36:
  br label %b14
b13:
  call void @"rt.region_enter"()
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %v47.p = getelementptr i64, ptr %v273, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v43, i64 0
  %v48 = load i64, ptr %v48.p
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v274, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 10
  %v51.p = getelementptr i64, ptr %v1, i64 1
  %v51 = load i64, ptr %v51.p
  %v52.c = icmp uge i64 %v48, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b13 = icmp ne i64 %v52, 0
  br i1 %c.b13, label %b13.t37, label %b13.e38
b13.t37:
  br label %b16
b13.e38:
  br label %b17
b14:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v275, i64 0
  store i64 %v44, ptr %st38
  br label %b11
b15:
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v276, i64 0
  store i64 %v49, ptr %st39
  %v61 = add i64 0, 1
  %v62.p = getelementptr i64, ptr %v43, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 %v62, %v61
  %st40 = getelementptr i64, ptr %v43, i64 0
  store i64 %v63, ptr %st40
  br label %b12
b16:
  %v53 = add i64 0, 42
  call void @"rt.panic"(i64 %v53)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v54.p = getelementptr i64, ptr %v1, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = inttoptr i64 %v54 to ptr
  %v56 = add i64 0, 1
  %v57 = mul i64 %v48, %v56
  %v58 = getelementptr i64, ptr %v55, i64 %v57
  %v59.p = getelementptr i64, ptr %v58, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v60, i64 2572
  store i64 %v3, ptr %st41
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v34, i64 %v50, i64 %v59)
  br label %b15
b18:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v277, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79 = getelementptr i64, ptr %s3, i64 0
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %v80.p = getelementptr i64, ptr %v278, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = getelementptr i64, ptr %s2, i64 0
  %st42 = getelementptr i64, ptr %v81, i64 0
  store i64 %v78, ptr %st42
  %v279 = getelementptr i64, ptr @"rt.meta", i64 0
  %v82.p = getelementptr i64, ptr %v279, i64 0
  %v82 = load i64, ptr %v82.p
  br label %b22
b19:
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %v94.p = getelementptr i64, ptr %v280, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 0, 0
  %v96 = add i64 0, 0
  %v97 = sub i64 %v96, %v2
  %v98 = getelementptr i64, ptr %s2, i64 0
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %v99.p = getelementptr i64, ptr %v281, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = getelementptr i64, ptr %s3, i64 0
  %st43 = getelementptr i64, ptr %v100, i64 0
  store i64 %v95, ptr %st43
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %v101.p = getelementptr i64, ptr %v282, i64 0
  %v101 = load i64, ptr %v101.p
  br label %b28
b20:
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v283, i64 0
  store i64 %v77, ptr %st44
  br label %b32
b21:
  br label %b20
b22:
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v284, i64 0
  store i64 %v82, ptr %st45
  %v83.p = getelementptr i64, ptr %v81, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.c = icmp slt i64 %v83, %v2
  %v84 = zext i1 %v84.c to i64
  %c.b22 = icmp ne i64 %v84, 0
  br i1 %c.b22, label %b22.t47, label %b22.e48
b22.t47:
  br label %b23
b22.e48:
  br label %b24
b23:
  call void @"rt.region_enter"()
  %v285 = getelementptr i64, ptr @"rt.meta", i64 0
  %v85.p = getelementptr i64, ptr %v285, i64 0
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v81, i64 0
  %v86 = load i64, ptr %v86.p
  %v286 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v286, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 0, 10
  %v89 = add i64 0, 0
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v90, i64 2572
  store i64 %v3, ptr %st48
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v34, i64 %v88, i64 %v89)
  br label %b25
b24:
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v287, i64 0
  store i64 %v82, ptr %st49
  br label %b21
b25:
  %v288 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v288, i64 0
  store i64 %v87, ptr %st50
  %v91 = add i64 0, 1
  %v92.p = getelementptr i64, ptr %v81, i64 0
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 %v92, %v91
  %st51 = getelementptr i64, ptr %v81, i64 0
  store i64 %v93, ptr %st51
  br label %b22
b26:
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v289, i64 0
  store i64 %v94, ptr %st52
  br label %b32
b27:
  br label %b26
b28:
  %v290 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v290, i64 0
  store i64 %v101, ptr %st53
  %v102.p = getelementptr i64, ptr %v100, i64 0
  %v102 = load i64, ptr %v102.p
  %v103.c = icmp slt i64 %v102, %v97
  %v103 = zext i1 %v103.c to i64
  %c.b28 = icmp ne i64 %v103, 0
  br i1 %c.b28, label %b28.t55, label %b28.e56
b28.t55:
  br label %b29
b28.e56:
  br label %b30
b29:
  call void @"rt.region_enter"()
  %v291 = getelementptr i64, ptr @"rt.meta", i64 0
  %v104.p = getelementptr i64, ptr %v291, i64 0
  %v104 = load i64, ptr %v104.p
  %v105.p = getelementptr i64, ptr %v100, i64 0
  %v105 = load i64, ptr %v105.p
  %v292 = getelementptr i64, ptr @"rt.meta", i64 0
  %v106.p = getelementptr i64, ptr %v292, i64 0
  %v106 = load i64, ptr %v106.p
  %v107 = add i64 0, 10
  %v108 = add i64 0, 0
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v109, i64 2572
  store i64 %v3, ptr %st56
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v71, i64 %v107, i64 %v108)
  br label %b31
b30:
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v293, i64 0
  store i64 %v101, ptr %st57
  br label %b27
b31:
  %v294 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v294, i64 0
  store i64 %v106, ptr %st58
  %v110 = add i64 0, 1
  %v111.p = getelementptr i64, ptr %v100, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 %v111, %v110
  %st59 = getelementptr i64, ptr %v100, i64 0
  store i64 %v112, ptr %st59
  br label %b28
b32:
  %v113 = add i64 0, 52
  %v114 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v114, i64 2572
  store i64 %v3, ptr %st60
  %v115 = call i64 @"std/internal/floatfmt.bnBitLen"(ptr %v34)
  %v116 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v116, i64 2572
  store i64 %v3, ptr %st61
  %v117 = call i64 @"std/internal/floatfmt.bnBitLen"(ptr %v71)
  %v118 = sub i64 %v115, %v117
  %v119 = sub i64 %v113, %v118
  %v120 = getelementptr i64, ptr %s3, i64 0
  %st62 = getelementptr i64, ptr %v120, i64 0
  store i64 %v119, ptr %st62
  %v121 = add i64 0, 0
  %v122 = getelementptr i64, ptr %s2, i64 0
  %st63 = getelementptr i64, ptr %v122, i64 0
  store i64 %v121, ptr %st63
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %v123.p = getelementptr i64, ptr %v295, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 0, 0
  %v125 = call ptr @"rt.region_alloc"(i64 %v123, i64 %v124)
  %v126 = add i64 0, 0
  %v127 = getelementptr i64, ptr %s0, i64 0
  %v128 = ptrtoint ptr %v125 to i64
  %st64 = getelementptr i64, ptr %v127, i64 0
  store i64 %v128, ptr %st64
  %st65 = getelementptr i64, ptr %v127, i64 1
  store i64 %v126, ptr %st65
  %st66 = getelementptr i64, ptr %v127, i64 2
  store i64 %v123, ptr %st66
  %v129 = getelementptr i64, ptr %s5, i64 0
  %v130.p = getelementptr i64, ptr %v127, i64 0
  %v130 = load i64, ptr %v130.p
  %st67 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st67
  %v131.p = getelementptr i64, ptr %v127, i64 1
  %v131 = load i64, ptr %v131.p
  %st68 = getelementptr i64, ptr %v129, i64 1
  store i64 %v131, ptr %st68
  %v132.p = getelementptr i64, ptr %v127, i64 2
  %v132 = load i64, ptr %v132.p
  %st69 = getelementptr i64, ptr %v129, i64 2
  store i64 %v132, ptr %st69
  %v296 = getelementptr i64, ptr @"rt.meta", i64 0
  %v133.p = getelementptr i64, ptr %v296, i64 0
  %v133 = load i64, ptr %v133.p
  %v134 = add i64 0, 0
  %v135 = call ptr @"rt.region_alloc"(i64 %v133, i64 %v134)
  %v136 = add i64 0, 0
  %v137 = getelementptr i64, ptr %s0, i64 0
  %v138 = ptrtoint ptr %v135 to i64
  %st70 = getelementptr i64, ptr %v137, i64 0
  store i64 %v138, ptr %st70
  %st71 = getelementptr i64, ptr %v137, i64 1
  store i64 %v136, ptr %st71
  %st72 = getelementptr i64, ptr %v137, i64 2
  store i64 %v133, ptr %st72
  %v139 = getelementptr i64, ptr %s6, i64 0
  %v140.p = getelementptr i64, ptr %v137, i64 0
  %v140 = load i64, ptr %v140.p
  %st73 = getelementptr i64, ptr %v139, i64 0
  store i64 %v140, ptr %st73
  %v141.p = getelementptr i64, ptr %v137, i64 1
  %v141 = load i64, ptr %v141.p
  %st74 = getelementptr i64, ptr %v139, i64 1
  store i64 %v141, ptr %st74
  %v142.p = getelementptr i64, ptr %v137, i64 2
  %v142 = load i64, ptr %v142.p
  %st75 = getelementptr i64, ptr %v139, i64 2
  store i64 %v142, ptr %st75
  %v143 = add i64 0, 0
  %v144 = getelementptr i64, ptr %s7, i64 0
  %st76 = getelementptr i64, ptr %v144, i64 0
  store i64 %v143, ptr %st76
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %v145.p = getelementptr i64, ptr %v297, i64 0
  %v145 = load i64, ptr %v145.p
  br label %b33
b33:
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %st77 = getelementptr i64, ptr %v298, i64 0
  store i64 %v145, ptr %st77
  %v146.p = getelementptr i64, ptr %v144, i64 0
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 0, 4
  %v148.c = icmp slt i64 %v146, %v147
  %v148 = zext i1 %v148.c to i64
  %c.b33 = icmp ne i64 %v148, 0
  br i1 %c.b33, label %b33.t79, label %b33.e80
b33.t79:
  br label %b34
b33.e80:
  br label %b35
b34:
  call void @"rt.region_enter"()
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %v149.p = getelementptr i64, ptr %v299, i64 0
  %v149 = load i64, ptr %v149.p
  %v150.c = icmp slt i64 %v3, %v3
  %v150 = zext i1 %v150.c to i64
  %v151 = sub i64 %v3, %v3
  %v152 = mul i64 %v150, %v151
  %v153 = add i64 %v3, %v152
  %v154.p = getelementptr i64, ptr %v120, i64 0
  %v154 = load i64, ptr %v154.p
  %v155.c = icmp slt i64 %v153, %v3
  %v155 = zext i1 %v155.c to i64
  %v156 = sub i64 %v153, %v3
  %v157 = mul i64 %v155, %v156
  %v158 = add i64 %v3, %v157
  %v159.c = icmp slt i64 %v158, %v3
  %v159 = zext i1 %v159.c to i64
  %v160 = sub i64 %v158, %v3
  %v161 = mul i64 %v159, %v160
  %v162 = add i64 %v3, %v161
  %v163 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v163, i64 2572
  store i64 %v162, ptr %st80
  %v164 = call i64 @"std/internal/floatfmt.bnDivScaled"(ptr %v34, ptr %v71, i64 %v154, ptr %v129, ptr %v139)
  %st81 = getelementptr i64, ptr %v122, i64 0
  store i64 %v164, ptr %st81
  %v165.p = getelementptr i64, ptr %v122, i64 0
  %v165 = load i64, ptr %v165.p
  %v166 = add i64 0, 4503599627370496
  %v167.c = icmp slt i64 %v165, %v166
  %v167 = zext i1 %v167.c to i64
  %c.b34 = icmp ne i64 %v167, 0
  br i1 %c.b34, label %b34.t83, label %b34.e84
b34.t83:
  br label %b36
b34.e84:
  br label %b37
b35:
  %v300 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v300, i64 0
  store i64 %v145, ptr %st84
  %v181 = add i64 0, 0
  %v182.p = getelementptr i64, ptr %v120, i64 0
  %v182 = load i64, ptr %v182.p
  %v183 = sub i64 %v181, %v182
  %v184 = add i64 0, 1075
  %v185 = add i64 %v183, %v184
  %v186 = getelementptr i64, ptr %s8, i64 0
  %st85 = getelementptr i64, ptr %v186, i64 0
  store i64 %v185, ptr %st85
  %v187.p = getelementptr i64, ptr %v186, i64 0
  %v187 = load i64, ptr %v187.p
  %v188 = add i64 0, 0
  %v189.c = icmp sle i64 %v187, %v188
  %v189 = zext i1 %v189.c to i64
  %c.b35 = icmp ne i64 %v189, 0
  br i1 %c.b35, label %b35.t87, label %b35.e88
b35.t87:
  br label %b42
b35.e88:
  br label %b43
b36:
  %v168 = add i64 0, 1
  %v169.p = getelementptr i64, ptr %v120, i64 0
  %v169 = load i64, ptr %v169.p
  %v170 = add i64 %v169, %v168
  %st88 = getelementptr i64, ptr %v120, i64 0
  store i64 %v170, ptr %st88
  br label %b41
b37:
  %v171.p = getelementptr i64, ptr %v122, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = add i64 0, 9007199254740992
  %v173.c = icmp sge i64 %v171, %v172
  %v173 = zext i1 %v173.c to i64
  %c.b37 = icmp ne i64 %v173, 0
  br i1 %c.b37, label %b37.t90, label %b37.e91
b37.t90:
  br label %b38
b37.e91:
  br label %b39
b38:
  %v174 = add i64 0, 1
  %v175.p = getelementptr i64, ptr %v120, i64 0
  %v175 = load i64, ptr %v175.p
  %v176 = sub i64 %v175, %v174
  %st91 = getelementptr i64, ptr %v120, i64 0
  store i64 %v176, ptr %st91
  br label %b40
b39:
  %v177 = add i64 0, 4
  %st92 = getelementptr i64, ptr %v144, i64 0
  store i64 %v177, ptr %st92
  br label %b40
b40:
  br label %b41
b41:
  %v178 = add i64 0, 1
  %v179.p = getelementptr i64, ptr %v144, i64 0
  %v179 = load i64, ptr %v179.p
  %v180 = add i64 %v179, %v178
  %st93 = getelementptr i64, ptr %v144, i64 0
  store i64 %v180, ptr %st93
  br label %b33
b42:
  %v190 = add i64 0, 1074
  %st94 = getelementptr i64, ptr %v120, i64 0
  store i64 %v190, ptr %st94
  %v191.c = icmp slt i64 %v3, %v3
  %v191 = zext i1 %v191.c to i64
  %v192 = sub i64 %v3, %v3
  %v193 = mul i64 %v191, %v192
  %v194 = add i64 %v3, %v193
  %v195.p = getelementptr i64, ptr %v120, i64 0
  %v195 = load i64, ptr %v195.p
  %v196.c = icmp slt i64 %v194, %v3
  %v196 = zext i1 %v196.c to i64
  %v197 = sub i64 %v194, %v3
  %v198 = mul i64 %v196, %v197
  %v199 = add i64 %v3, %v198
  %v200.c = icmp slt i64 %v199, %v3
  %v200 = zext i1 %v200.c to i64
  %v201 = sub i64 %v199, %v3
  %v202 = mul i64 %v200, %v201
  %v203 = add i64 %v3, %v202
  %v204 = getelementptr i64, ptr @"rt.meta", i64 0
  %st95 = getelementptr i64, ptr %v204, i64 2572
  store i64 %v203, ptr %st95
  %v205 = call i64 @"std/internal/floatfmt.bnDivScaled"(ptr %v34, ptr %v71, i64 %v195, ptr %v129, ptr %v139)
  %st96 = getelementptr i64, ptr %v122, i64 0
  store i64 %v205, ptr %st96
  %v206 = add i64 0, 0
  %st97 = getelementptr i64, ptr %v186, i64 0
  store i64 %v206, ptr %st97
  br label %b44
b43:
  br label %b44
b44:
  %v207 = add i64 0, 2
  %v208 = add i64 0, 0
  %v209 = getelementptr i64, ptr @"rt.meta", i64 0
  %st98 = getelementptr i64, ptr %v209, i64 2572
  store i64 %v3, ptr %st98
  call void @"std/internal/floatfmt.bnMulAdd"(ptr %v129, i64 %v207, i64 %v208)
  %v210.c = icmp slt i64 %v3, %v3
  %v210 = zext i1 %v210.c to i64
  %v211 = sub i64 %v3, %v3
  %v212 = mul i64 %v210, %v211
  %v213 = add i64 %v3, %v212
  %v214 = getelementptr i64, ptr @"rt.meta", i64 0
  %st99 = getelementptr i64, ptr %v214, i64 2572
  store i64 %v213, ptr %st99
  %v215 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v129, ptr %v139)
  %v216 = add i64 0, 0
  %v217.c = icmp sgt i64 %v215, %v216
  %v217 = zext i1 %v217.c to i64
  %c.b44 = icmp ne i64 %v217, 0
  br i1 %c.b44, label %b44.t101, label %b44.e102
b44.t101:
  br label %b46
b44.e102:
  br label %b45
b45:
  %v219 = add i64 0, 0
  %v220.c = icmp eq i64 %v215, %v219
  %v220 = zext i1 %v220.c to i64
  %c.b45 = icmp ne i64 %v220, 0
  br i1 %c.b45, label %b45.t103, label %b45.e104
b45.t103:
  br label %b47
b45.e104:
  br label %b48
b46:
  %v218 = phi i64 [ %v217, %b44.t101 ], [ %v221, %b48 ]
  %c.b46 = icmp ne i64 %v218, 0
  br i1 %c.b46, label %b46.t105, label %b46.e106
b46.t105:
  br label %b49
b46.e106:
  br label %b50
b47:
  %v222.p = getelementptr i64, ptr %v122, i64 0
  %v222 = load i64, ptr %v222.p
  %v223 = add i64 0, 2
  %v224 = srem i64 %v222, %v223
  %v225 = add i64 0, 1
  %v226.c = icmp eq i64 %v224, %v225
  %v226 = zext i1 %v226.c to i64
  br label %b48
b48:
  %v221 = phi i64 [ %v220, %b45.e104 ], [ %v226, %b47 ]
  br label %b46
b49:
  %v227 = add i64 0, 1
  %v228.p = getelementptr i64, ptr %v122, i64 0
  %v228 = load i64, ptr %v228.p
  %v229 = add i64 %v228, %v227
  %st106 = getelementptr i64, ptr %v122, i64 0
  store i64 %v229, ptr %st106
  br label %b51
b50:
  br label %b51
b51:
  %v230.p = getelementptr i64, ptr %v186, i64 0
  %v230 = load i64, ptr %v230.p
  %v231 = add i64 0, 0
  %v232.c = icmp eq i64 %v230, %v231
  %v232 = zext i1 %v232.c to i64
  %c.b51 = icmp ne i64 %v232, 0
  br i1 %c.b51, label %b51.t108, label %b51.e109
b51.t108:
  br label %b52
b51.e109:
  br label %b53
b52:
  %v233.p = getelementptr i64, ptr %v122, i64 0
  %v233 = load i64, ptr %v233.p
  %v234 = add i64 0, 1
  %st109 = getelementptr i64, ptr %v0, i64 0
  store i64 %v233, ptr %st109
  %st110 = getelementptr i64, ptr %v0, i64 1
  store i64 %v234, ptr %st110
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %st111 = getelementptr i64, ptr %v301, i64 0
  store i64 %v3, ptr %st111
  ret void
b53:
  br label %b54
b54:
  %v235.p = getelementptr i64, ptr %v122, i64 0
  %v235 = load i64, ptr %v235.p
  %v236 = add i64 0, 9007199254740992
  %v237.c = icmp eq i64 %v235, %v236
  %v237 = zext i1 %v237.c to i64
  %c.b54 = icmp ne i64 %v237, 0
  br i1 %c.b54, label %b54.t113, label %b54.e114
b54.t113:
  br label %b55
b54.e114:
  br label %b56
b55:
  %v238 = add i64 0, 4503599627370496
  %st114 = getelementptr i64, ptr %v122, i64 0
  store i64 %v238, ptr %st114
  %v239 = add i64 0, 1
  %v240.p = getelementptr i64, ptr %v186, i64 0
  %v240 = load i64, ptr %v240.p
  %v241 = add i64 %v240, %v239
  %st115 = getelementptr i64, ptr %v186, i64 0
  store i64 %v241, ptr %st115
  br label %b57
b56:
  br label %b57
b57:
  %v242.p = getelementptr i64, ptr %v186, i64 0
  %v242 = load i64, ptr %v242.p
  %v243 = add i64 0, 2047
  %v244.c = icmp sge i64 %v242, %v243
  %v244 = zext i1 %v244.c to i64
  %c.b57 = icmp ne i64 %v244, 0
  br i1 %c.b57, label %b57.t117, label %b57.e118
b57.t117:
  br label %b58
b57.e118:
  br label %b59
b58:
  %v245 = add i64 0, 0
  %v246 = add i64 0, 0
  %st118 = getelementptr i64, ptr %v0, i64 0
  store i64 %v245, ptr %st118
  %st119 = getelementptr i64, ptr %v0, i64 1
  store i64 %v246, ptr %st119
  %v302 = getelementptr i64, ptr @"rt.meta", i64 0
  %st120 = getelementptr i64, ptr %v302, i64 0
  store i64 %v3, ptr %st120
  ret void
b59:
  br label %b60
b60:
  %v247.p = getelementptr i64, ptr %v186, i64 0
  %v247 = load i64, ptr %v247.p
  %v248 = add i64 0, 52
  %v250 = add i64 0, 0
  %v251.c = icmp slt i64 %v248, %v250
  %v251 = zext i1 %v251.c to i64
  %c.b60 = icmp ne i64 %v251, 0
  br i1 %c.b60, label %b60.t122, label %b60.e123
b60.t122:
  br label %b61
b60.e123:
  br label %b62
b61:
  %v252 = add i64 0, 43
  call void @"rt.panic"(i64 %v252)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b62:
  %v253 = add i64 0, 63
  %v254.c = icmp sgt i64 %v248, %v253
  %v254 = zext i1 %v254.c to i64
  %c.b62 = icmp ne i64 %v254, 0
  br i1 %c.b62, label %b62.t124, label %b62.e125
b62.t124:
  br label %b64
b62.e125:
  br label %b65
b63:
  %v249 = phi i64 [ %v255, %b64 ], [ %v256, %b65 ]
  %v257.p = getelementptr i64, ptr %v122, i64 0
  %v257 = load i64, ptr %v257.p
  %v258 = add i64 0, 4503599627370496
  %v259 = sub i64 %v257, %v258
  %v260 = or i64 %v249, %v259
  %v261 = add i64 0, 1
  %st125 = getelementptr i64, ptr %v0, i64 0
  store i64 %v260, ptr %st125
  %st126 = getelementptr i64, ptr %v0, i64 1
  store i64 %v261, ptr %st126
  %v303 = getelementptr i64, ptr @"rt.meta", i64 0
  %st127 = getelementptr i64, ptr %v303, i64 0
  store i64 %v3, ptr %st127
  ret void
b64:
  %v255 = add i64 0, 0
  br label %b63
b65:
  %v256.n = and i64 %v248, 63
  %v256 = shl i64 %v247, %v256.n
  br label %b63
}

define internal i64 @"std/internal/floatfmt.bnDivScaled"(ptr %v0, ptr %v1, i64 %v2, ptr %v3, ptr %v4) #0 {
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
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v83, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2572
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %v9.c = icmp eq i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %v10 = mul i64 %v9, %v5
  %v11 = add i64 %v7, %v10
  %v12.c = icmp slt i64 %v11, %v11
  %v12 = zext i1 %v12.c to i64
  %v13 = sub i64 %v11, %v11
  %v14 = mul i64 %v12, %v13
  %v15 = add i64 %v11, %v14
  %v16 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v16, i64 2572
  store i64 %v15, ptr %st0
  call void @"std/internal/floatfmt.bnSet"(ptr %v3, ptr %v0)
  %v17.c = icmp slt i64 %v11, %v11
  %v17 = zext i1 %v17.c to i64
  %v18 = sub i64 %v11, %v11
  %v19 = mul i64 %v17, %v18
  %v20 = add i64 %v11, %v19
  %v21 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v21, i64 2572
  store i64 %v20, ptr %st1
  call void @"std/internal/floatfmt.bnSet"(ptr %v4, ptr %v1)
  %v22 = add i64 0, 0
  %v23.c = icmp sge i64 %v2, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b0 = icmp ne i64 %v23, 0
  br i1 %c.b0, label %b0.t3, label %b0.e4
b0.t3:
  br label %b1
b0.e4:
  br label %b2
b1:
  %v24 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v24, i64 2572
  store i64 %v11, ptr %st4
  call void @"std/internal/floatfmt.bnShl"(ptr %v3, i64 %v2)
  br label %b3
b2:
  %v25 = add i64 0, 0
  %v26 = sub i64 %v25, %v2
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v27, i64 2572
  store i64 %v11, ptr %st5
  call void @"std/internal/floatfmt.bnShl"(ptr %v4, i64 %v26)
  br label %b3
b3:
  %v28 = add i64 0, 0
  %v29 = getelementptr i64, ptr %s0, i64 0
  %st6 = getelementptr i64, ptr %v29, i64 0
  store i64 %v28, ptr %st6
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v84, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 0
  %v32 = call ptr @"rt.region_alloc"(i64 %v30, i64 %v31)
  %v33 = add i64 0, 0
  %v34 = getelementptr i64, ptr %s1, i64 0
  %v35 = ptrtoint ptr %v32 to i64
  %st7 = getelementptr i64, ptr %v34, i64 0
  store i64 %v35, ptr %st7
  %st8 = getelementptr i64, ptr %v34, i64 1
  store i64 %v33, ptr %st8
  %st9 = getelementptr i64, ptr %v34, i64 2
  store i64 %v30, ptr %st9
  %v36 = getelementptr i64, ptr %s2, i64 0
  %v37.p = getelementptr i64, ptr %v34, i64 0
  %v37 = load i64, ptr %v37.p
  %st10 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st10
  %v38.p = getelementptr i64, ptr %v34, i64 1
  %v38 = load i64, ptr %v38.p
  %st11 = getelementptr i64, ptr %v36, i64 1
  store i64 %v38, ptr %st11
  %v39.p = getelementptr i64, ptr %v34, i64 2
  %v39 = load i64, ptr %v39.p
  %st12 = getelementptr i64, ptr %v36, i64 2
  store i64 %v39, ptr %st12
  %v40 = add i64 0, 55
  %v41 = getelementptr i64, ptr %s3, i64 0
  %st13 = getelementptr i64, ptr %v41, i64 0
  store i64 %v40, ptr %st13
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v85, i64 0
  %v42 = load i64, ptr %v42.p
  br label %b4
b4:
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v86, i64 0
  store i64 %v42, ptr %st14
  %v43.p = getelementptr i64, ptr %v41, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = add i64 0, 0
  %v45.c = icmp sge i64 %v43, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b4 = icmp ne i64 %v45, 0
  br i1 %c.b4, label %b4.t16, label %b4.e17
b4.t16:
  br label %b5
b4.e17:
  br label %b6
b5:
  call void @"rt.region_enter"()
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v87, i64 0
  %v46 = load i64, ptr %v46.p
  %v47.c = icmp slt i64 %v5, %v11
  %v47 = zext i1 %v47.c to i64
  %v48 = sub i64 %v5, %v11
  %v49 = mul i64 %v47, %v48
  %v50 = add i64 %v11, %v49
  %v51 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v51, i64 2572
  store i64 %v50, ptr %st17
  call void @"std/internal/floatfmt.bnSet"(ptr %v36, ptr %v4)
  %v52.p = getelementptr i64, ptr %v41, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v53, i64 2572
  store i64 %v5, ptr %st18
  call void @"std/internal/floatfmt.bnShl"(ptr %v36, i64 %v52)
  %v54.c = icmp slt i64 %v11, %v5
  %v54 = zext i1 %v54.c to i64
  %v55 = sub i64 %v11, %v5
  %v56 = mul i64 %v54, %v55
  %v57 = add i64 %v5, %v56
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v58, i64 2572
  store i64 %v57, ptr %st19
  %v59 = call i64 @"std/internal/floatfmt.bnCmp"(ptr %v3, ptr %v36)
  %v60 = add i64 0, 0
  %v61.c = icmp sge i64 %v59, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b5 = icmp ne i64 %v61, 0
  br i1 %c.b5, label %b5.t21, label %b5.e22
b5.t21:
  br label %b7
b5.e22:
  br label %b8
b6:
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v88, i64 0
  store i64 %v42, ptr %st22
  %v82.p = getelementptr i64, ptr %v29, i64 0
  %v82 = load i64, ptr %v82.p
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v89, i64 0
  store i64 %v5, ptr %st23
  ret i64 %v82
b7:
  %v62.c = icmp slt i64 %v11, %v5
  %v62 = zext i1 %v62.c to i64
  %v63 = sub i64 %v11, %v5
  %v64 = mul i64 %v62, %v63
  %v65 = add i64 %v5, %v64
  %v66 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v66, i64 2572
  store i64 %v65, ptr %st24
  call void @"std/internal/floatfmt.bnSub"(ptr %v3, ptr %v36)
  %v67.p = getelementptr i64, ptr %v29, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 1
  %v69.p = getelementptr i64, ptr %v41, i64 0
  %v69 = load i64, ptr %v69.p
  %v71 = add i64 0, 0
  %v72.c = icmp slt i64 %v69, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b7 = icmp ne i64 %v72, 0
  br i1 %c.b7, label %b7.t26, label %b7.e27
b7.t26:
  br label %b9
b7.e27:
  br label %b10
b8:
  br label %b14
b9:
  %v73 = add i64 0, 44
  call void @"rt.panic"(i64 %v73)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v74 = add i64 0, 63
  %v75.c = icmp sgt i64 %v69, %v74
  %v75 = zext i1 %v75.c to i64
  %c.b10 = icmp ne i64 %v75, 0
  br i1 %c.b10, label %b10.t28, label %b10.e29
b10.t28:
  br label %b12
b10.e29:
  br label %b13
b11:
  %v70 = phi i64 [ %v76, %b12 ], [ %v77, %b13 ]
  %v78 = or i64 %v67, %v70
  %st29 = getelementptr i64, ptr %v29, i64 0
  store i64 %v78, ptr %st29
  br label %b14
b12:
  %v76 = add i64 0, 0
  br label %b11
b13:
  %v77.n = and i64 %v69, 63
  %v77 = shl i64 %v68, %v77.n
  br label %b11
b14:
  %v79 = add i64 0, 1
  %v80.p = getelementptr i64, ptr %v41, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = sub i64 %v80, %v79
  %st30 = getelementptr i64, ptr %v41, i64 0
  store i64 %v81, ptr %st30
  br label %b4
}

define internal i64 @"std/internal/floatfmt.bitLen"(i64 %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v27, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v2, i64 0
  store i64 %v0, ptr %st0
  %v3 = add i64 0, 0
  %v4 = getelementptr i64, ptr %s1, i64 0
  %st1 = getelementptr i64, ptr %v4, i64 0
  store i64 %v3, ptr %st1
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v28, i64 0
  %v5 = load i64, ptr %v5.p
  br label %b1
b1:
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v29, i64 0
  store i64 %v5, ptr %st2
  %v6.p = getelementptr i64, ptr %v2, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp sgt i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b1 = icmp ne i64 %v8, 0
  br i1 %c.b1, label %b1.t4, label %b1.e5
b1.t4:
  br label %b2
b1.e5:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v30 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v30, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 1
  %v11 = add i64 %v1, %v10
  %v12.p = getelementptr i64, ptr %v2, i64 0
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 1
  %v15 = add i64 0, 0
  %v16.c = icmp slt i64 %v13, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b2 = icmp ne i64 %v16, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b4
b2.e7:
  br label %b5
b3:
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v31, i64 0
  store i64 %v5, ptr %st7
  %v26.p = getelementptr i64, ptr %v4, i64 0
  %v26 = load i64, ptr %v26.p
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v32, i64 0
  store i64 %v1, ptr %st8
  ret i64 %v26
b4:
  %v17 = add i64 0, 45
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v18 = add i64 0, 63
  %v19.c = icmp sgt i64 %v13, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b5 = icmp ne i64 %v19, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b7
b5.e11:
  br label %b8
b6:
  %v14 = phi i64 [ %v21, %b7 ], [ %v22, %b8 ]
  %st11 = getelementptr i64, ptr %v2, i64 0
  store i64 %v14, ptr %st11
  %v23 = add i64 0, 1
  %v24.p = getelementptr i64, ptr %v4, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 %v24, %v23
  %st12 = getelementptr i64, ptr %v4, i64 0
  store i64 %v25, ptr %st12
  br label %b1
b7:
  %v20 = add i64 0, 63
  %v21.n = and i64 %v20, 63
  %v21 = ashr i64 %v12, %v21.n
  br label %b6
b8:
  %v22.n = and i64 %v13, 63
  %v22 = ashr i64 %v12, %v22.n
  br label %b6
}

define internal void @"std/internal/floatfmt.bnSet"(ptr %v0, ptr %v1) #0 {
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
  %v128 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v128, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 0
  %v10 = call ptr @"rt.region_alloc"(i64 %v8, i64 %v9)
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s0, i64 0
  %v13 = ptrtoint ptr %v10 to i64
  %st0 = getelementptr i64, ptr %v12, i64 0
  store i64 %v13, ptr %st0
  %st1 = getelementptr i64, ptr %v12, i64 1
  store i64 %v11, ptr %st1
  %st2 = getelementptr i64, ptr %v12, i64 2
  store i64 %v8, ptr %st2
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v15.p = getelementptr i64, ptr %v12, i64 0
  %v15 = load i64, ptr %v15.p
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v15, ptr %st3
  %v16.p = getelementptr i64, ptr %v12, i64 1
  %v16 = load i64, ptr %v16.p
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v16, ptr %st4
  %v17.p = getelementptr i64, ptr %v12, i64 2
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v17, ptr %st5
  %v129 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v14, i64 %v129, i64 %v8)
  %v18.p = getelementptr i64, ptr %v14, i64 0
  %v18 = load i64, ptr %v18.p
  %st6 = getelementptr i64, ptr %v0, i64 0
  store i64 %v18, ptr %st6
  %v19.p = getelementptr i64, ptr %v14, i64 1
  %v19 = load i64, ptr %v19.p
  %st7 = getelementptr i64, ptr %v0, i64 1
  store i64 %v19, ptr %st7
  %v20.p = getelementptr i64, ptr %v14, i64 2
  %v20 = load i64, ptr %v20.p
  %st8 = getelementptr i64, ptr %v0, i64 2
  store i64 %v20, ptr %st8
  %v21 = add i64 0, 0
  %v22 = add i64 0, 0
  %v23.p = getelementptr i64, ptr %v1, i64 1
  %v23 = load i64, ptr %v23.p
  %v24 = sub i64 %v23, %v22
  %v25.c = icmp sle i64 %v24, %v21
  %v25 = zext i1 %v25.c to i64
  %c.b0 = icmp ne i64 %v25, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  %v130 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v130, i64 0
  store i64 %v2, ptr %st11
  ret void
b2:
  %v26.c = icmp sge i64 %v22, %v21
  %v26 = zext i1 %v26.c to i64
  %v27.p = getelementptr i64, ptr %v1, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp sle i64 %v23, %v27
  %v28 = zext i1 %v28.c to i64
  %v29 = and i64 %v26, %v28
  %v30.c = icmp ne i64 %v29, %v21
  %v30 = zext i1 %v30.c to i64
  %c.b2 = icmp ne i64 %v30, 0
  br i1 %c.b2, label %b2.t13, label %b2.e14
b2.t13:
  br label %b4
b2.e14:
  br label %b3
b3:
  %v131 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v131, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 0
  %v74.p = getelementptr i64, ptr %v1, i64 1
  %v74 = load i64, ptr %v74.p
  %v75 = getelementptr i64, ptr %s3, i64 0
  %v132 = getelementptr i64, ptr @"rt.meta", i64 0
  %v76.p = getelementptr i64, ptr %v132, i64 0
  %v76 = load i64, ptr %v76.p
  %v77 = getelementptr i64, ptr %s4, i64 0
  %st14 = getelementptr i64, ptr %v77, i64 0
  store i64 %v73, ptr %st14
  %v133 = getelementptr i64, ptr @"rt.meta", i64 0
  %v78.p = getelementptr i64, ptr %v133, i64 0
  %v78 = load i64, ptr %v78.p
  br label %b10
b4:
  %v31 = getelementptr i64, ptr %s0, i64 0
  %v32.p = getelementptr i64, ptr %v0, i64 0
  %v32 = load i64, ptr %v32.p
  %st15 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st15
  %v33.p = getelementptr i64, ptr %v0, i64 1
  %v33 = load i64, ptr %v33.p
  %st16 = getelementptr i64, ptr %v31, i64 1
  store i64 %v33, ptr %st16
  %v34.p = getelementptr i64, ptr %v0, i64 2
  %v34 = load i64, ptr %v34.p
  %st17 = getelementptr i64, ptr %v31, i64 2
  store i64 %v34, ptr %st17
  %v35.p = getelementptr i64, ptr %v31, i64 2
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v31, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v31, i64 1
  %v37 = load i64, ptr %v37.p
  %v40 = add i64 0, 8
  %v41 = mul i64 %v37, %v40
  %v42 = add i64 %v36, %v41
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v135 = getelementptr i64, ptr %v134, i64 %v35
  %v43.p = getelementptr i64, ptr %v135, i64 1
  %v43 = load ptr, ptr %v43.p
  %v44 = ptrtoint ptr %v43 to i64
  %v45.c = icmp eq i64 %v44, %v42
  %v45 = zext i1 %v45.c to i64
  %c.b4 = icmp ne i64 %v45, 0
  br i1 %c.b4, label %b4.t19, label %b4.e20
b4.t19:
  br label %b7
b4.e20:
  br label %b6
b5:
  %v38 = phi ptr [ %v55, %b6 ], [ %v49, %b7 ]
  %v39 = phi ptr [ %v57, %b6 ], [ %v48, %b7 ]
  %v58.p = getelementptr i64, ptr %v1, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = inttoptr i64 %v58 to ptr
  %v60 = add i64 0, 1
  %v61 = mul i64 %v22, %v60
  %v62 = getelementptr i64, ptr %v59, i64 %v61
  %v63 = add i64 0, 1
  %v64 = mul i64 %v24, %v63
  call void @"rt.copy"(ptr %v39, ptr %v62, i64 %v64)
  %v65.p = getelementptr i64, ptr %v31, i64 1
  %v65 = load i64, ptr %v65.p
  %v66 = add i64 %v65, %v24
  %v67 = getelementptr i64, ptr %s2, i64 0
  %v68 = ptrtoint ptr %v38 to i64
  %st20 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st20
  %st21 = getelementptr i64, ptr %v67, i64 1
  store i64 %v66, ptr %st21
  %st22 = getelementptr i64, ptr %v67, i64 2
  store i64 %v35, ptr %st22
  %v69.p = getelementptr i64, ptr %v67, i64 0
  %v69 = load i64, ptr %v69.p
  %st23 = getelementptr i64, ptr %v0, i64 0
  store i64 %v69, ptr %st23
  %v70.p = getelementptr i64, ptr %v67, i64 1
  %v70 = load i64, ptr %v70.p
  %st24 = getelementptr i64, ptr %v0, i64 1
  store i64 %v70, ptr %st24
  %v71.p = getelementptr i64, ptr %v67, i64 2
  %v71 = load i64, ptr %v71.p
  %st25 = getelementptr i64, ptr %v0, i64 2
  store i64 %v71, ptr %st25
  br label %b1
b6:
  %v50 = add i64 0, 1
  %v51 = mul i64 %v37, %v50
  %v52 = add i64 0, 1
  %v53 = mul i64 %v24, %v52
  %v54 = add i64 %v51, %v53
  %v55 = call ptr @"rt.region_alloc"(i64 %v35, i64 %v54)
  %v56 = inttoptr i64 %v36 to ptr
  call void @"rt.copy"(ptr %v55, ptr %v56, i64 %v51)
  %v57 = getelementptr i64, ptr %v55, i64 %v51
  br label %b5
b7:
  %v46 = add i64 0, 1
  %v47 = mul i64 %v24, %v46
  %v48 = call ptr @"rt.region_alloc"(i64 %v35, i64 %v47)
  %v49 = inttoptr i64 %v36 to ptr
  br label %b5
b8:
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v136, i64 0
  store i64 %v72, ptr %st26
  br label %b1
b9:
  br label %b8
b10:
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v137, i64 0
  store i64 %v78, ptr %st27
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %v80.c = icmp slt i64 %v79, %v74
  %v80 = zext i1 %v80.c to i64
  %c.b10 = icmp ne i64 %v80, 0
  br i1 %c.b10, label %b10.t29, label %b10.e30
b10.t29:
  br label %b11
b10.e30:
  br label %b12
b11:
  call void @"rt.region_enter"()
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %v81.p = getelementptr i64, ptr %v138, i64 0
  %v81 = load i64, ptr %v81.p
  %v82.p = getelementptr i64, ptr %v77, i64 0
  %v82 = load i64, ptr %v82.p
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %v83.p = getelementptr i64, ptr %v139, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = getelementptr i64, ptr %s5, i64 0
  %v85.p = getelementptr i64, ptr %v0, i64 0
  %v85 = load i64, ptr %v85.p
  %st30 = getelementptr i64, ptr %v84, i64 0
  store i64 %v85, ptr %st30
  %v86.p = getelementptr i64, ptr %v0, i64 1
  %v86 = load i64, ptr %v86.p
  %st31 = getelementptr i64, ptr %v84, i64 1
  store i64 %v86, ptr %st31
  %v87.p = getelementptr i64, ptr %v0, i64 2
  %v87 = load i64, ptr %v87.p
  %st32 = getelementptr i64, ptr %v84, i64 2
  store i64 %v87, ptr %st32
  %v88.p = getelementptr i64, ptr %v1, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.c = icmp uge i64 %v82, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b11 = icmp ne i64 %v89, 0
  br i1 %c.b11, label %b11.t34, label %b11.e35
b11.t34:
  br label %b14
b11.e35:
  br label %b15
b12:
  %v140 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v140, i64 0
  store i64 %v78, ptr %st35
  br label %b9
b13:
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %st36 = getelementptr i64, ptr %v141, i64 0
  store i64 %v83, ptr %st36
  %v125 = add i64 0, 1
  %v126.p = getelementptr i64, ptr %v77, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 %v126, %v125
  %st37 = getelementptr i64, ptr %v77, i64 0
  store i64 %v127, ptr %st37
  br label %b10
b14:
  %v90 = add i64 0, 46
  call void @"rt.panic"(i64 %v90)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v91.p = getelementptr i64, ptr %v1, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = inttoptr i64 %v91 to ptr
  %v93 = add i64 0, 1
  %v94 = mul i64 %v82, %v93
  %v95 = getelementptr i64, ptr %v92, i64 %v94
  %v96.p = getelementptr i64, ptr %v95, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v84, i64 2
  %v97 = load i64, ptr %v97.p
  %v98.p = getelementptr i64, ptr %v84, i64 0
  %v98 = load i64, ptr %v98.p
  %v99.p = getelementptr i64, ptr %v84, i64 1
  %v99 = load i64, ptr %v99.p
  %v102 = add i64 0, 8
  %v103 = mul i64 %v99, %v102
  %v104 = add i64 %v98, %v103
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %v143 = getelementptr i64, ptr %v142, i64 %v97
  %v105.p = getelementptr i64, ptr %v143, i64 1
  %v105 = load ptr, ptr %v105.p
  %v106 = ptrtoint ptr %v105 to i64
  %v107.c = icmp eq i64 %v106, %v104
  %v107 = zext i1 %v107.c to i64
  %c.b15 = icmp ne i64 %v107, 0
  br i1 %c.b15, label %b15.t39, label %b15.e40
b15.t39:
  br label %b18
b15.e40:
  br label %b17
b16:
  %v100 = phi ptr [ %v115, %b17 ], [ %v110, %b18 ]
  %v101 = phi ptr [ %v116, %b17 ], [ %v109, %b18 ]
  %st40 = getelementptr i64, ptr %v101, i64 0
  store i64 %v96, ptr %st40
  %v117.p = getelementptr i64, ptr %v84, i64 1
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 0, 1
  %v119 = add i64 %v117, %v118
  %v120 = getelementptr i64, ptr %s6, i64 0
  %v121 = ptrtoint ptr %v100 to i64
  %st41 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st41
  %st42 = getelementptr i64, ptr %v120, i64 1
  store i64 %v119, ptr %st42
  %st43 = getelementptr i64, ptr %v120, i64 2
  store i64 %v97, ptr %st43
  %v122.p = getelementptr i64, ptr %v120, i64 0
  %v122 = load i64, ptr %v122.p
  %st44 = getelementptr i64, ptr %v0, i64 0
  store i64 %v122, ptr %st44
  %v123.p = getelementptr i64, ptr %v120, i64 1
  %v123 = load i64, ptr %v123.p
  %st45 = getelementptr i64, ptr %v0, i64 1
  store i64 %v123, ptr %st45
  %v124.p = getelementptr i64, ptr %v120, i64 2
  %v124 = load i64, ptr %v124.p
  %st46 = getelementptr i64, ptr %v0, i64 2
  store i64 %v124, ptr %st46
  br label %b13
b17:
  %v111 = add i64 0, 1
  %v112 = mul i64 %v99, %v111
  %v113 = add i64 0, 1
  %v114 = add i64 0, 1
  %v115 = call ptr @"rt.slice_grow"(i64 %v98, i64 %v99, i64 %v113, i64 %v97, i64 %v114)
  %v116 = getelementptr i64, ptr %v115, i64 %v112
  br label %b16
b18:
  %v108 = add i64 0, 1
  %v109 = call ptr @"rt.region_alloc"(i64 %v97, i64 %v108)
  %v110 = inttoptr i64 %v98 to ptr
  br label %b16
}

define internal void @"std/internal/floatfmt.bnMulAdd"(ptr %v0, i64 %v1, i64 %v2) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
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
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v93, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2572
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %v7.c = icmp eq i64 %v5, %v6
  %v7 = zext i1 %v7.c to i64
  %v8 = mul i64 %v7, %v3
  %v9 = add i64 %v5, %v8
  %v10 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v10, i64 0
  store i64 %v2, ptr %st0
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v94, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.p = getelementptr i64, ptr %v0, i64 1
  %v13 = load i64, ptr %v13.p
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v95, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s2, i64 0
  %st1 = getelementptr i64, ptr %v16, i64 0
  store i64 %v12, ptr %st1
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v96, i64 0
  %v17 = load i64, ptr %v17.p
  br label %b3
b1:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v97, i64 0
  store i64 %v11, ptr %st2
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %v50.p = getelementptr i64, ptr %v98, i64 0
  %v50 = load i64, ptr %v50.p
  br label %b11
b2:
  br label %b1
b3:
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v99, i64 0
  store i64 %v17, ptr %st3
  %v18.p = getelementptr i64, ptr %v16, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp slt i64 %v18, %v13
  %v19 = zext i1 %v19.c to i64
  %c.b3 = icmp ne i64 %v19, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b4
b3.e6:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v100, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 0
  %v21 = load i64, ptr %v21.p
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v101, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v0, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.c = icmp uge i64 %v21, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b4 = icmp ne i64 %v24, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b7
b4.e8:
  br label %b8
b5:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v102, i64 0
  store i64 %v17, ptr %st8
  br label %b2
b6:
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v103, i64 0
  store i64 %v22, ptr %st9
  %v47 = add i64 0, 1
  %v48.p = getelementptr i64, ptr %v16, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 %v48, %v47
  %st10 = getelementptr i64, ptr %v16, i64 0
  store i64 %v49, ptr %st10
  br label %b3
b7:
  %v25 = add i64 0, 47
  call void @"rt.panic"(i64 %v25)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v26.p = getelementptr i64, ptr %v0, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = inttoptr i64 %v26 to ptr
  %v28 = add i64 0, 1
  %v29 = mul i64 %v21, %v28
  %v30 = getelementptr i64, ptr %v27, i64 %v29
  %v31.p = getelementptr i64, ptr %v30, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = mul i64 %v31, %v1
  %v33.p = getelementptr i64, ptr %v10, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = add i64 %v32, %v33
  %v35 = add i64 0, 1073741824
  %v36 = srem i64 %v34, %v35
  %v37.p = getelementptr i64, ptr %v0, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v21, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b8 = icmp ne i64 %v38, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b9
b8.e13:
  br label %b10
b9:
  %v39 = add i64 0, 48
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v40.p = getelementptr i64, ptr %v0, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v21, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %st13 = getelementptr i64, ptr %v44, i64 0
  store i64 %v36, ptr %st13
  %v45 = add i64 0, 1073741824
  %v46 = sdiv i64 %v34, %v45
  %st14 = getelementptr i64, ptr %v10, i64 0
  store i64 %v46, ptr %st14
  br label %b6
b11:
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v104, i64 0
  store i64 %v50, ptr %st15
  %v51.p = getelementptr i64, ptr %v10, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 0, 0
  %v53.c = icmp sgt i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b11 = icmp ne i64 %v53, 0
  br i1 %c.b11, label %b11.t17, label %b11.e18
b11.t17:
  br label %b12
b11.e18:
  br label %b13
b12:
  call void @"rt.region_enter"()
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %v54.p = getelementptr i64, ptr %v105, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = getelementptr i64, ptr %s3, i64 0
  %v56.p = getelementptr i64, ptr %v0, i64 0
  %v56 = load i64, ptr %v56.p
  %st18 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st18
  %v57.p = getelementptr i64, ptr %v0, i64 1
  %v57 = load i64, ptr %v57.p
  %st19 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st19
  %v58.p = getelementptr i64, ptr %v0, i64 2
  %v58 = load i64, ptr %v58.p
  %st20 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st20
  %v59.p = getelementptr i64, ptr %v10, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 1073741824
  %v61 = srem i64 %v59, %v60
  %v62.p = getelementptr i64, ptr %v55, i64 2
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v55, i64 0
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v55, i64 1
  %v64 = load i64, ptr %v64.p
  %v67 = add i64 0, 8
  %v68 = mul i64 %v64, %v67
  %v69 = add i64 %v63, %v68
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %v107 = getelementptr i64, ptr %v106, i64 %v62
  %v70.p = getelementptr i64, ptr %v107, i64 1
  %v70 = load ptr, ptr %v70.p
  %v71 = ptrtoint ptr %v70 to i64
  %v72.c = icmp eq i64 %v71, %v69
  %v72 = zext i1 %v72.c to i64
  %c.b12 = icmp ne i64 %v72, 0
  br i1 %c.b12, label %b12.t22, label %b12.e23
b12.t22:
  br label %b16
b12.e23:
  br label %b15
b13:
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v108, i64 0
  store i64 %v50, ptr %st23
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v109, i64 0
  store i64 %v3, ptr %st24
  ret void
b14:
  %v65 = phi ptr [ %v80, %b15 ], [ %v75, %b16 ]
  %v66 = phi ptr [ %v81, %b15 ], [ %v74, %b16 ]
  %st25 = getelementptr i64, ptr %v66, i64 0
  store i64 %v61, ptr %st25
  %v82.p = getelementptr i64, ptr %v55, i64 1
  %v82 = load i64, ptr %v82.p
  %v83 = add i64 0, 1
  %v84 = add i64 %v82, %v83
  %v85 = getelementptr i64, ptr %s4, i64 0
  %v86 = ptrtoint ptr %v65 to i64
  %st26 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st26
  %st27 = getelementptr i64, ptr %v85, i64 1
  store i64 %v84, ptr %st27
  %st28 = getelementptr i64, ptr %v85, i64 2
  store i64 %v62, ptr %st28
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v87, ptr %st29
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v88, ptr %st30
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v89, ptr %st31
  %v90.p = getelementptr i64, ptr %v10, i64 0
  %v90 = load i64, ptr %v90.p
  %v91 = add i64 0, 1073741824
  %v92 = sdiv i64 %v90, %v91
  %st32 = getelementptr i64, ptr %v10, i64 0
  store i64 %v92, ptr %st32
  br label %b11
b15:
  %v76 = add i64 0, 1
  %v77 = mul i64 %v64, %v76
  %v78 = add i64 0, 1
  %v79 = add i64 0, 1
  %v80 = call ptr @"rt.slice_grow"(i64 %v63, i64 %v64, i64 %v78, i64 %v62, i64 %v79)
  %v81 = getelementptr i64, ptr %v80, i64 %v77
  br label %b14
b16:
  %v73 = add i64 0, 1
  %v74 = call ptr @"rt.region_alloc"(i64 %v62, i64 %v73)
  %v75 = inttoptr i64 %v63 to ptr
  br label %b14
}

define internal void @"std/internal/floatfmt.bnShl"(ptr %v0, i64 %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
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
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v268, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 30
  %v10 = sdiv i64 %v1, %v9
  %v11 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st0
  %v12 = add i64 0, 30
  %v13 = srem i64 %v1, %v12
  %v14 = add i64 0, 0
  %v15.c = icmp sgt i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b0 = icmp ne i64 %v15, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v16 = add i64 0, 0
  %v17 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v17, i64 0
  store i64 %v16, ptr %st3
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v18.p = getelementptr i64, ptr %v269, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %v20.p = getelementptr i64, ptr %v0, i64 1
  %v20 = load i64, ptr %v20.p
  %v21 = getelementptr i64, ptr %s2, i64 0
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v270, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = getelementptr i64, ptr %s3, i64 0
  %st4 = getelementptr i64, ptr %v23, i64 0
  store i64 %v19, ptr %st4
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v271, i64 0
  %v24 = load i64, ptr %v24.p
  br label %b5
b2:
  br label %b24
b3:
  %v272 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v272, i64 0
  store i64 %v18, ptr %st5
  %v64.p = getelementptr i64, ptr %v17, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 0
  %v66.c = icmp sgt i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b3 = icmp ne i64 %v66, 0
  br i1 %c.b3, label %b3.t7, label %b3.e8
b3.t7:
  br label %b18
b3.e8:
  br label %b19
b4:
  br label %b3
b5:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v273, i64 0
  store i64 %v24, ptr %st8
  %v25.p = getelementptr i64, ptr %v23, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp slt i64 %v25, %v20
  %v26 = zext i1 %v26.c to i64
  %c.b5 = icmp ne i64 %v26, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b6
b5.e11:
  br label %b7
b6:
  call void @"rt.region_enter"()
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v274, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v23, i64 0
  %v28 = load i64, ptr %v28.p
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v275, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v0, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.c = icmp uge i64 %v28, %v30
  %v31 = zext i1 %v31.c to i64
  %c.b6 = icmp ne i64 %v31, 0
  br i1 %c.b6, label %b6.t12, label %b6.e13
b6.t12:
  br label %b9
b6.e13:
  br label %b10
b7:
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v276, i64 0
  store i64 %v24, ptr %st13
  br label %b4
b8:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v277, i64 0
  store i64 %v29, ptr %st14
  %v61 = add i64 0, 1
  %v62.p = getelementptr i64, ptr %v23, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 %v62, %v61
  %st15 = getelementptr i64, ptr %v23, i64 0
  store i64 %v63, ptr %st15
  br label %b5
b9:
  %v32 = add i64 0, 49
  call void @"rt.panic"(i64 %v32)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v33.p = getelementptr i64, ptr %v0, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = inttoptr i64 %v33 to ptr
  %v35 = add i64 0, 1
  %v36 = mul i64 %v28, %v35
  %v37 = getelementptr i64, ptr %v34, i64 %v36
  %v38.p = getelementptr i64, ptr %v37, i64 0
  %v38 = load i64, ptr %v38.p
  %v40 = add i64 0, 0
  %v41.c = icmp slt i64 %v13, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b10 = icmp ne i64 %v41, 0
  br i1 %c.b10, label %b10.t17, label %b10.e18
b10.t17:
  br label %b11
b10.e18:
  br label %b12
b11:
  %v42 = add i64 0, 50
  call void @"rt.panic"(i64 %v42)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v43 = add i64 0, 63
  %v44.c = icmp sgt i64 %v13, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b12 = icmp ne i64 %v44, 0
  br i1 %c.b12, label %b12.t19, label %b12.e20
b12.t19:
  br label %b14
b12.e20:
  br label %b15
b13:
  %v39 = phi i64 [ %v45, %b14 ], [ %v46, %b15 ]
  %v47.p = getelementptr i64, ptr %v17, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 %v39, %v47
  %v49 = add i64 0, 1073741824
  %v50 = srem i64 %v48, %v49
  %v51.p = getelementptr i64, ptr %v0, i64 1
  %v51 = load i64, ptr %v51.p
  %v52.c = icmp uge i64 %v28, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b13 = icmp ne i64 %v52, 0
  br i1 %c.b13, label %b13.t21, label %b13.e22
b13.t21:
  br label %b16
b13.e22:
  br label %b17
b14:
  %v45 = add i64 0, 0
  br label %b13
b15:
  %v46.n = and i64 %v13, 63
  %v46 = shl i64 %v38, %v46.n
  br label %b13
b16:
  %v53 = add i64 0, 51
  call void @"rt.panic"(i64 %v53)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v54.p = getelementptr i64, ptr %v0, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = inttoptr i64 %v54 to ptr
  %v56 = add i64 0, 1
  %v57 = mul i64 %v28, %v56
  %v58 = getelementptr i64, ptr %v55, i64 %v57
  %st22 = getelementptr i64, ptr %v58, i64 0
  store i64 %v50, ptr %st22
  %v59 = add i64 0, 1073741824
  %v60 = sdiv i64 %v48, %v59
  %st23 = getelementptr i64, ptr %v17, i64 0
  store i64 %v60, ptr %st23
  br label %b8
b18:
  %v67 = getelementptr i64, ptr %s4, i64 0
  %v68.p = getelementptr i64, ptr %v0, i64 0
  %v68 = load i64, ptr %v68.p
  %st24 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st24
  %v69.p = getelementptr i64, ptr %v0, i64 1
  %v69 = load i64, ptr %v69.p
  %st25 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st25
  %v70.p = getelementptr i64, ptr %v0, i64 2
  %v70 = load i64, ptr %v70.p
  %st26 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st26
  %v71.p = getelementptr i64, ptr %v17, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v67, i64 2
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v67, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v67, i64 1
  %v74 = load i64, ptr %v74.p
  %v77 = add i64 0, 8
  %v78 = mul i64 %v74, %v77
  %v79 = add i64 %v73, %v78
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279 = getelementptr i64, ptr %v278, i64 %v72
  %v80.p = getelementptr i64, ptr %v279, i64 1
  %v80 = load ptr, ptr %v80.p
  %v81 = ptrtoint ptr %v80 to i64
  %v82.c = icmp eq i64 %v81, %v79
  %v82 = zext i1 %v82.c to i64
  %c.b18 = icmp ne i64 %v82, 0
  br i1 %c.b18, label %b18.t28, label %b18.e29
b18.t28:
  br label %b22
b18.e29:
  br label %b21
b19:
  br label %b23
b20:
  %v75 = phi ptr [ %v90, %b21 ], [ %v85, %b22 ]
  %v76 = phi ptr [ %v91, %b21 ], [ %v84, %b22 ]
  %st29 = getelementptr i64, ptr %v76, i64 0
  store i64 %v71, ptr %st29
  %v92.p = getelementptr i64, ptr %v67, i64 1
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 1
  %v94 = add i64 %v92, %v93
  %v95 = getelementptr i64, ptr %s5, i64 0
  %v96 = ptrtoint ptr %v75 to i64
  %st30 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st30
  %st31 = getelementptr i64, ptr %v95, i64 1
  store i64 %v94, ptr %st31
  %st32 = getelementptr i64, ptr %v95, i64 2
  store i64 %v72, ptr %st32
  %v97.p = getelementptr i64, ptr %v95, i64 0
  %v97 = load i64, ptr %v97.p
  %st33 = getelementptr i64, ptr %v0, i64 0
  store i64 %v97, ptr %st33
  %v98.p = getelementptr i64, ptr %v95, i64 1
  %v98 = load i64, ptr %v98.p
  %st34 = getelementptr i64, ptr %v0, i64 1
  store i64 %v98, ptr %st34
  %v99.p = getelementptr i64, ptr %v95, i64 2
  %v99 = load i64, ptr %v99.p
  %st35 = getelementptr i64, ptr %v0, i64 2
  store i64 %v99, ptr %st35
  br label %b23
b21:
  %v86 = add i64 0, 1
  %v87 = mul i64 %v74, %v86
  %v88 = add i64 0, 1
  %v89 = add i64 0, 1
  %v90 = call ptr @"rt.slice_grow"(i64 %v73, i64 %v74, i64 %v88, i64 %v72, i64 %v89)
  %v91 = getelementptr i64, ptr %v90, i64 %v87
  br label %b20
b22:
  %v83 = add i64 0, 1
  %v84 = call ptr @"rt.region_alloc"(i64 %v72, i64 %v83)
  %v85 = inttoptr i64 %v73 to ptr
  br label %b20
b23:
  br label %b24
b24:
  %v100.p = getelementptr i64, ptr %v11, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 0
  %v102.c = icmp sgt i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b24 = icmp ne i64 %v102, 0
  br i1 %c.b24, label %b24.t37, label %b24.e38
b24.t37:
  br label %b25
b24.e38:
  br label %b26
b25:
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %v103.p = getelementptr i64, ptr %v280, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105 = call ptr @"rt.region_alloc"(i64 %v103, i64 %v104)
  %v106 = add i64 0, 0
  %v107 = getelementptr i64, ptr %s5, i64 0
  %v108 = ptrtoint ptr %v105 to i64
  %st38 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st38
  %st39 = getelementptr i64, ptr %v107, i64 1
  store i64 %v106, ptr %st39
  %st40 = getelementptr i64, ptr %v107, i64 2
  store i64 %v103, ptr %st40
  %v109 = getelementptr i64, ptr %s4, i64 0
  %v110.p = getelementptr i64, ptr %v107, i64 0
  %v110 = load i64, ptr %v110.p
  %st41 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st41
  %v111.p = getelementptr i64, ptr %v107, i64 1
  %v111 = load i64, ptr %v111.p
  %st42 = getelementptr i64, ptr %v109, i64 1
  store i64 %v111, ptr %st42
  %v112.p = getelementptr i64, ptr %v107, i64 2
  %v112 = load i64, ptr %v112.p
  %st43 = getelementptr i64, ptr %v109, i64 2
  store i64 %v112, ptr %st43
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %v113.p = getelementptr i64, ptr %v281, i64 0
  %v113 = load i64, ptr %v113.p
  br label %b27
b26:
  br label %b51
b27:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v282, i64 0
  store i64 %v113, ptr %st44
  %v114.p = getelementptr i64, ptr %v11, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 0
  %v116.c = icmp sgt i64 %v114, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b27 = icmp ne i64 %v116, 0
  br i1 %c.b27, label %b27.t46, label %b27.e47
b27.t46:
  br label %b28
b27.e47:
  br label %b29
b28:
  call void @"rt.region_enter"()
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %v117.p = getelementptr i64, ptr %v283, i64 0
  %v117 = load i64, ptr %v117.p
  %v118 = getelementptr i64, ptr %s5, i64 0
  %v119.p = getelementptr i64, ptr %v109, i64 0
  %v119 = load i64, ptr %v119.p
  %st47 = getelementptr i64, ptr %v118, i64 0
  store i64 %v119, ptr %st47
  %v120.p = getelementptr i64, ptr %v109, i64 1
  %v120 = load i64, ptr %v120.p
  %st48 = getelementptr i64, ptr %v118, i64 1
  store i64 %v120, ptr %st48
  %v121.p = getelementptr i64, ptr %v109, i64 2
  %v121 = load i64, ptr %v121.p
  %st49 = getelementptr i64, ptr %v118, i64 2
  store i64 %v121, ptr %st49
  %v122 = add i64 0, 0
  %v123.p = getelementptr i64, ptr %v118, i64 2
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v118, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v118, i64 1
  %v125 = load i64, ptr %v125.p
  %v128 = add i64 0, 8
  %v129 = mul i64 %v125, %v128
  %v130 = add i64 %v124, %v129
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %v285 = getelementptr i64, ptr %v284, i64 %v123
  %v131.p = getelementptr i64, ptr %v285, i64 1
  %v131 = load ptr, ptr %v131.p
  %v132 = ptrtoint ptr %v131 to i64
  %v133.c = icmp eq i64 %v132, %v130
  %v133 = zext i1 %v133.c to i64
  %c.b28 = icmp ne i64 %v133, 0
  br i1 %c.b28, label %b28.t51, label %b28.e52
b28.t51:
  br label %b32
b28.e52:
  br label %b31
b29:
  %v286 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v286, i64 0
  store i64 %v113, ptr %st52
  %v154 = add i64 0, 0
  %v155 = add i64 0, 0
  %v156.p = getelementptr i64, ptr %v0, i64 1
  %v156 = load i64, ptr %v156.p
  %v157 = sub i64 %v156, %v155
  %v158.c = icmp sle i64 %v157, %v154
  %v158 = zext i1 %v158.c to i64
  %c.b29 = icmp ne i64 %v158, 0
  br i1 %c.b29, label %b29.t54, label %b29.e55
b29.t54:
  br label %b33
b29.e55:
  br label %b34
b30:
  %v126 = phi ptr [ %v141, %b31 ], [ %v136, %b32 ]
  %v127 = phi ptr [ %v142, %b31 ], [ %v135, %b32 ]
  %st55 = getelementptr i64, ptr %v127, i64 0
  store i64 %v122, ptr %st55
  %v143.p = getelementptr i64, ptr %v118, i64 1
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 1
  %v145 = add i64 %v143, %v144
  %v146 = getelementptr i64, ptr %s6, i64 0
  %v147 = ptrtoint ptr %v126 to i64
  %st56 = getelementptr i64, ptr %v146, i64 0
  store i64 %v147, ptr %st56
  %st57 = getelementptr i64, ptr %v146, i64 1
  store i64 %v145, ptr %st57
  %st58 = getelementptr i64, ptr %v146, i64 2
  store i64 %v123, ptr %st58
  %v148.p = getelementptr i64, ptr %v146, i64 0
  %v148 = load i64, ptr %v148.p
  %st59 = getelementptr i64, ptr %v109, i64 0
  store i64 %v148, ptr %st59
  %v149.p = getelementptr i64, ptr %v146, i64 1
  %v149 = load i64, ptr %v149.p
  %st60 = getelementptr i64, ptr %v109, i64 1
  store i64 %v149, ptr %st60
  %v150.p = getelementptr i64, ptr %v146, i64 2
  %v150 = load i64, ptr %v150.p
  %st61 = getelementptr i64, ptr %v109, i64 2
  store i64 %v150, ptr %st61
  %v151 = add i64 0, 1
  %v152.p = getelementptr i64, ptr %v11, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = sub i64 %v152, %v151
  %st62 = getelementptr i64, ptr %v11, i64 0
  store i64 %v153, ptr %st62
  br label %b27
b31:
  %v137 = add i64 0, 1
  %v138 = mul i64 %v125, %v137
  %v139 = add i64 0, 1
  %v140 = add i64 0, 1
  %v141 = call ptr @"rt.slice_grow"(i64 %v124, i64 %v125, i64 %v139, i64 %v123, i64 %v140)
  %v142 = getelementptr i64, ptr %v141, i64 %v138
  br label %b30
b32:
  %v134 = add i64 0, 1
  %v135 = call ptr @"rt.region_alloc"(i64 %v123, i64 %v134)
  %v136 = inttoptr i64 %v124 to ptr
  br label %b30
b33:
  %v261 = getelementptr i64, ptr %s5, i64 0
  %v262.p = getelementptr i64, ptr %v109, i64 0
  %v262 = load i64, ptr %v262.p
  %st63 = getelementptr i64, ptr %v261, i64 0
  store i64 %v262, ptr %st63
  %v263.p = getelementptr i64, ptr %v109, i64 1
  %v263 = load i64, ptr %v263.p
  %st64 = getelementptr i64, ptr %v261, i64 1
  store i64 %v263, ptr %st64
  %v264.p = getelementptr i64, ptr %v109, i64 2
  %v264 = load i64, ptr %v264.p
  %st65 = getelementptr i64, ptr %v261, i64 2
  store i64 %v264, ptr %st65
  %v287 = add i64 0, 1
  call void @"rt.region_relocate"(ptr %v261, i64 %v287, i64 %v8)
  %v265.p = getelementptr i64, ptr %v261, i64 0
  %v265 = load i64, ptr %v265.p
  %st66 = getelementptr i64, ptr %v0, i64 0
  store i64 %v265, ptr %st66
  %v266.p = getelementptr i64, ptr %v261, i64 1
  %v266 = load i64, ptr %v266.p
  %st67 = getelementptr i64, ptr %v0, i64 1
  store i64 %v266, ptr %st67
  %v267.p = getelementptr i64, ptr %v261, i64 2
  %v267 = load i64, ptr %v267.p
  %st68 = getelementptr i64, ptr %v0, i64 2
  store i64 %v267, ptr %st68
  br label %b51
b34:
  %v159.c = icmp sge i64 %v155, %v154
  %v159 = zext i1 %v159.c to i64
  %v160.p = getelementptr i64, ptr %v0, i64 1
  %v160 = load i64, ptr %v160.p
  %v161.c = icmp sle i64 %v156, %v160
  %v161 = zext i1 %v161.c to i64
  %v162 = and i64 %v159, %v161
  %v163.c = icmp ne i64 %v162, %v154
  %v163 = zext i1 %v163.c to i64
  %c.b34 = icmp ne i64 %v163, 0
  br i1 %c.b34, label %b34.t70, label %b34.e71
b34.t70:
  br label %b36
b34.e71:
  br label %b35
b35:
  %v288 = getelementptr i64, ptr @"rt.meta", i64 0
  %v205.p = getelementptr i64, ptr %v288, i64 0
  %v205 = load i64, ptr %v205.p
  %v206 = add i64 0, 0
  %v207.p = getelementptr i64, ptr %v0, i64 1
  %v207 = load i64, ptr %v207.p
  %v208 = getelementptr i64, ptr %s1, i64 0
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %v209.p = getelementptr i64, ptr %v289, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = getelementptr i64, ptr %s3, i64 0
  %st71 = getelementptr i64, ptr %v210, i64 0
  store i64 %v206, ptr %st71
  %v290 = getelementptr i64, ptr @"rt.meta", i64 0
  %v211.p = getelementptr i64, ptr %v290, i64 0
  %v211 = load i64, ptr %v211.p
  br label %b42
b36:
  %v164 = getelementptr i64, ptr %s6, i64 0
  %v165.p = getelementptr i64, ptr %v109, i64 0
  %v165 = load i64, ptr %v165.p
  %st72 = getelementptr i64, ptr %v164, i64 0
  store i64 %v165, ptr %st72
  %v166.p = getelementptr i64, ptr %v109, i64 1
  %v166 = load i64, ptr %v166.p
  %st73 = getelementptr i64, ptr %v164, i64 1
  store i64 %v166, ptr %st73
  %v167.p = getelementptr i64, ptr %v109, i64 2
  %v167 = load i64, ptr %v167.p
  %st74 = getelementptr i64, ptr %v164, i64 2
  store i64 %v167, ptr %st74
  %v168.p = getelementptr i64, ptr %v164, i64 2
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v164, i64 0
  %v169 = load i64, ptr %v169.p
  %v170.p = getelementptr i64, ptr %v164, i64 1
  %v170 = load i64, ptr %v170.p
  %v173 = add i64 0, 8
  %v174 = mul i64 %v170, %v173
  %v175 = add i64 %v169, %v174
  %v291 = getelementptr i64, ptr @"rt.meta", i64 0
  %v292 = getelementptr i64, ptr %v291, i64 %v168
  %v176.p = getelementptr i64, ptr %v292, i64 1
  %v176 = load ptr, ptr %v176.p
  %v177 = ptrtoint ptr %v176 to i64
  %v178.c = icmp eq i64 %v177, %v175
  %v178 = zext i1 %v178.c to i64
  %c.b36 = icmp ne i64 %v178, 0
  br i1 %c.b36, label %b36.t76, label %b36.e77
b36.t76:
  br label %b39
b36.e77:
  br label %b38
b37:
  %v171 = phi ptr [ %v188, %b38 ], [ %v182, %b39 ]
  %v172 = phi ptr [ %v190, %b38 ], [ %v181, %b39 ]
  %v191.p = getelementptr i64, ptr %v0, i64 0
  %v191 = load i64, ptr %v191.p
  %v192 = inttoptr i64 %v191 to ptr
  %v193 = add i64 0, 1
  %v194 = mul i64 %v155, %v193
  %v195 = getelementptr i64, ptr %v192, i64 %v194
  %v196 = add i64 0, 1
  %v197 = mul i64 %v157, %v196
  call void @"rt.copy"(ptr %v172, ptr %v195, i64 %v197)
  %v198.p = getelementptr i64, ptr %v164, i64 1
  %v198 = load i64, ptr %v198.p
  %v199 = add i64 %v198, %v157
  %v200 = getelementptr i64, ptr %s5, i64 0
  %v201 = ptrtoint ptr %v171 to i64
  %st77 = getelementptr i64, ptr %v200, i64 0
  store i64 %v201, ptr %st77
  %st78 = getelementptr i64, ptr %v200, i64 1
  store i64 %v199, ptr %st78
  %st79 = getelementptr i64, ptr %v200, i64 2
  store i64 %v168, ptr %st79
  %v202.p = getelementptr i64, ptr %v200, i64 0
  %v202 = load i64, ptr %v202.p
  %st80 = getelementptr i64, ptr %v109, i64 0
  store i64 %v202, ptr %st80
  %v203.p = getelementptr i64, ptr %v200, i64 1
  %v203 = load i64, ptr %v203.p
  %st81 = getelementptr i64, ptr %v109, i64 1
  store i64 %v203, ptr %st81
  %v204.p = getelementptr i64, ptr %v200, i64 2
  %v204 = load i64, ptr %v204.p
  %st82 = getelementptr i64, ptr %v109, i64 2
  store i64 %v204, ptr %st82
  br label %b33
b38:
  %v183 = add i64 0, 1
  %v184 = mul i64 %v170, %v183
  %v185 = add i64 0, 1
  %v186 = mul i64 %v157, %v185
  %v187 = add i64 %v184, %v186
  %v188 = call ptr @"rt.region_alloc"(i64 %v168, i64 %v187)
  %v189 = inttoptr i64 %v169 to ptr
  call void @"rt.copy"(ptr %v188, ptr %v189, i64 %v184)
  %v190 = getelementptr i64, ptr %v188, i64 %v184
  br label %b37
b39:
  %v179 = add i64 0, 1
  %v180 = mul i64 %v157, %v179
  %v181 = call ptr @"rt.region_alloc"(i64 %v168, i64 %v180)
  %v182 = inttoptr i64 %v169 to ptr
  br label %b37
b40:
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v293, i64 0
  store i64 %v205, ptr %st83
  br label %b33
b41:
  br label %b40
b42:
  %v294 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v294, i64 0
  store i64 %v211, ptr %st84
  %v212.p = getelementptr i64, ptr %v210, i64 0
  %v212 = load i64, ptr %v212.p
  %v213.c = icmp slt i64 %v212, %v207
  %v213 = zext i1 %v213.c to i64
  %c.b42 = icmp ne i64 %v213, 0
  br i1 %c.b42, label %b42.t86, label %b42.e87
b42.t86:
  br label %b43
b42.e87:
  br label %b44
b43:
  call void @"rt.region_enter"()
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %v214.p = getelementptr i64, ptr %v295, i64 0
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v210, i64 0
  %v215 = load i64, ptr %v215.p
  %v296 = getelementptr i64, ptr @"rt.meta", i64 0
  %v216.p = getelementptr i64, ptr %v296, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = getelementptr i64, ptr %s7, i64 0
  %v218.p = getelementptr i64, ptr %v109, i64 0
  %v218 = load i64, ptr %v218.p
  %st87 = getelementptr i64, ptr %v217, i64 0
  store i64 %v218, ptr %st87
  %v219.p = getelementptr i64, ptr %v109, i64 1
  %v219 = load i64, ptr %v219.p
  %st88 = getelementptr i64, ptr %v217, i64 1
  store i64 %v219, ptr %st88
  %v220.p = getelementptr i64, ptr %v109, i64 2
  %v220 = load i64, ptr %v220.p
  %st89 = getelementptr i64, ptr %v217, i64 2
  store i64 %v220, ptr %st89
  %v221.p = getelementptr i64, ptr %v0, i64 1
  %v221 = load i64, ptr %v221.p
  %v222.c = icmp uge i64 %v215, %v221
  %v222 = zext i1 %v222.c to i64
  %c.b43 = icmp ne i64 %v222, 0
  br i1 %c.b43, label %b43.t91, label %b43.e92
b43.t91:
  br label %b46
b43.e92:
  br label %b47
b44:
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v297, i64 0
  store i64 %v211, ptr %st92
  br label %b41
b45:
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %st93 = getelementptr i64, ptr %v298, i64 0
  store i64 %v216, ptr %st93
  %v258 = add i64 0, 1
  %v259.p = getelementptr i64, ptr %v210, i64 0
  %v259 = load i64, ptr %v259.p
  %v260 = add i64 %v259, %v258
  %st94 = getelementptr i64, ptr %v210, i64 0
  store i64 %v260, ptr %st94
  br label %b42
b46:
  %v223 = add i64 0, 52
  call void @"rt.panic"(i64 %v223)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v224.p = getelementptr i64, ptr %v0, i64 0
  %v224 = load i64, ptr %v224.p
  %v225 = inttoptr i64 %v224 to ptr
  %v226 = add i64 0, 1
  %v227 = mul i64 %v215, %v226
  %v228 = getelementptr i64, ptr %v225, i64 %v227
  %v229.p = getelementptr i64, ptr %v228, i64 0
  %v229 = load i64, ptr %v229.p
  %v230.p = getelementptr i64, ptr %v217, i64 2
  %v230 = load i64, ptr %v230.p
  %v231.p = getelementptr i64, ptr %v217, i64 0
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v217, i64 1
  %v232 = load i64, ptr %v232.p
  %v235 = add i64 0, 8
  %v236 = mul i64 %v232, %v235
  %v237 = add i64 %v231, %v236
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %v300 = getelementptr i64, ptr %v299, i64 %v230
  %v238.p = getelementptr i64, ptr %v300, i64 1
  %v238 = load ptr, ptr %v238.p
  %v239 = ptrtoint ptr %v238 to i64
  %v240.c = icmp eq i64 %v239, %v237
  %v240 = zext i1 %v240.c to i64
  %c.b47 = icmp ne i64 %v240, 0
  br i1 %c.b47, label %b47.t96, label %b47.e97
b47.t96:
  br label %b50
b47.e97:
  br label %b49
b48:
  %v233 = phi ptr [ %v248, %b49 ], [ %v243, %b50 ]
  %v234 = phi ptr [ %v249, %b49 ], [ %v242, %b50 ]
  %st97 = getelementptr i64, ptr %v234, i64 0
  store i64 %v229, ptr %st97
  %v250.p = getelementptr i64, ptr %v217, i64 1
  %v250 = load i64, ptr %v250.p
  %v251 = add i64 0, 1
  %v252 = add i64 %v250, %v251
  %v253 = getelementptr i64, ptr %s8, i64 0
  %v254 = ptrtoint ptr %v233 to i64
  %st98 = getelementptr i64, ptr %v253, i64 0
  store i64 %v254, ptr %st98
  %st99 = getelementptr i64, ptr %v253, i64 1
  store i64 %v252, ptr %st99
  %st100 = getelementptr i64, ptr %v253, i64 2
  store i64 %v230, ptr %st100
  %v255.p = getelementptr i64, ptr %v253, i64 0
  %v255 = load i64, ptr %v255.p
  %st101 = getelementptr i64, ptr %v109, i64 0
  store i64 %v255, ptr %st101
  %v256.p = getelementptr i64, ptr %v253, i64 1
  %v256 = load i64, ptr %v256.p
  %st102 = getelementptr i64, ptr %v109, i64 1
  store i64 %v256, ptr %st102
  %v257.p = getelementptr i64, ptr %v253, i64 2
  %v257 = load i64, ptr %v257.p
  %st103 = getelementptr i64, ptr %v109, i64 2
  store i64 %v257, ptr %st103
  br label %b45
b49:
  %v244 = add i64 0, 1
  %v245 = mul i64 %v232, %v244
  %v246 = add i64 0, 1
  %v247 = add i64 0, 1
  %v248 = call ptr @"rt.slice_grow"(i64 %v231, i64 %v232, i64 %v246, i64 %v230, i64 %v247)
  %v249 = getelementptr i64, ptr %v248, i64 %v245
  br label %b48
b50:
  %v241 = add i64 0, 1
  %v242 = call ptr @"rt.region_alloc"(i64 %v230, i64 %v241)
  %v243 = inttoptr i64 %v231 to ptr
  br label %b48
b51:
  %v301 = getelementptr i64, ptr @"rt.meta", i64 0
  %st104 = getelementptr i64, ptr %v301, i64 0
  store i64 %v2, ptr %st104
  ret void
}

define internal i64 @"std/internal/floatfmt.bnTop"(ptr %v0) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v34, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v2, i64 2572
  %v3 = load i64, ptr %v3.p
  %v4 = add i64 0, 0
  %v5.c = icmp eq i64 %v3, %v4
  %v5 = zext i1 %v5.c to i64
  %v6 = mul i64 %v5, %v1
  %v7 = add i64 %v3, %v6
  %v8.p = getelementptr i64, ptr %v0, i64 1
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 1
  %v10 = sub i64 %v8, %v9
  %v11 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st0
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v35, i64 0
  %v12 = load i64, ptr %v12.p
  br label %b1
b1:
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v36, i64 0
  store i64 %v12, ptr %st1
  %v13.p = getelementptr i64, ptr %v11, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15.c = icmp sge i64 %v13, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b1 = icmp ne i64 %v15, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b4
b1.e4:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v37, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 0, 1
  %v31.p = getelementptr i64, ptr %v11, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = sub i64 %v31, %v30
  %st4 = getelementptr i64, ptr %v11, i64 0
  store i64 %v32, ptr %st4
  br label %b1
b3:
  %v38 = getelementptr i64, ptr @"rt.meta", i64 0
  %st5 = getelementptr i64, ptr %v38, i64 0
  store i64 %v12, ptr %st5
  %v33.p = getelementptr i64, ptr %v11, i64 0
  %v33 = load i64, ptr %v33.p
  %v39 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v39, i64 0
  store i64 %v1, ptr %st6
  ret i64 %v33
b4:
  %v17.p = getelementptr i64, ptr %v11, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v0, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp uge i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b4 = icmp ne i64 %v19, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b6
b4.e9:
  br label %b7
b5:
  %v16 = phi i64 [ %v15, %b1.e4 ], [ %v28, %b7 ]
  %c.b5 = icmp ne i64 %v16, 0
  br i1 %c.b5, label %b5.t10, label %b5.e11
b5.t10:
  br label %b2
b5.e11:
  br label %b3
b6:
  %v20 = add i64 0, 53
  call void @"rt.panic"(i64 %v20)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v21.p = getelementptr i64, ptr %v0, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = inttoptr i64 %v21 to ptr
  %v23 = add i64 0, 1
  %v24 = mul i64 %v17, %v23
  %v25 = getelementptr i64, ptr %v22, i64 %v24
  %v26.p = getelementptr i64, ptr %v25, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.c = icmp eq i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  br label %b5
}

define internal i64 @"std/internal/floatfmt.bnBitLen"(ptr %v0) #0 {
b0:
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v26, i64 0
  %v1 = load i64, ptr %v1.p
  %v2 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v2, i64 2572
  %v3 = load i64, ptr %v3.p
  %v4 = add i64 0, 0
  %v5.c = icmp eq i64 %v3, %v4
  %v5 = zext i1 %v5.c to i64
  %v6 = mul i64 %v5, %v1
  %v7 = add i64 %v3, %v6
  %v8 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v8, i64 2572
  store i64 %v7, ptr %st0
  %v9 = call i64 @"std/internal/floatfmt.bnTop"(ptr %v0)
  %v10 = add i64 0, 0
  %v11.c = icmp slt i64 %v9, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b0 = icmp ne i64 %v11, 0
  br i1 %c.b0, label %b0.t2, label %b0.e3
b0.t2:
  br label %b1
b0.e3:
  br label %b2
b1:
  %v12 = add i64 0, 0
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v27, i64 0
  store i64 %v1, ptr %st3
  ret i64 %v12
b2:
  br label %b3
b3:
  %v13 = add i64 0, 30
  %v14 = mul i64 %v9, %v13
  %v15.p = getelementptr i64, ptr %v0, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.c = icmp uge i64 %v9, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b3 = icmp ne i64 %v16, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b4
b3.e6:
  br label %b5
b4:
  %v17 = add i64 0, 54
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
  %v18.p = getelementptr i64, ptr %v0, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = inttoptr i64 %v18 to ptr
  %v20 = add i64 0, 1
  %v21 = mul i64 %v9, %v20
  %v22 = getelementptr i64, ptr %v19, i64 %v21
  %v23.p = getelementptr i64, ptr %v22, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = call i64 @"std/internal/floatfmt.bitLen"(i64 %v23)
  %v25 = add i64 %v14, %v24
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v28, i64 0
  store i64 %v1, ptr %st6
  ret i64 %v25
}

define internal i64 @"std/internal/floatfmt.bnCmp"(ptr %v0, ptr %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v77, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %st0 = getelementptr i64, ptr %v9, i64 2572
  store i64 %v8, ptr %st0
  %v10 = call i64 @"std/internal/floatfmt.bnTop"(ptr %v0)
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v11, i64 2572
  store i64 %v8, ptr %st1
  %v12 = call i64 @"std/internal/floatfmt.bnTop"(ptr %v1)
  %v13.c = icmp ne i64 %v10, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b0 = icmp ne i64 %v13, 0
  br i1 %c.b0, label %b0.t3, label %b0.e4
b0.t3:
  br label %b1
b0.e4:
  br label %b2
b1:
  %v14.c = icmp sgt i64 %v10, %v12
  %v14 = zext i1 %v14.c to i64
  %c.b1 = icmp ne i64 %v14, 0
  br i1 %c.b1, label %b1.t5, label %b1.e6
b1.t5:
  br label %b3
b1.e6:
  br label %b4
b2:
  br label %b6
b3:
  %v15 = add i64 0, 1
  br label %b5
b4:
  %v16 = add i64 0, 1
  %v17 = add i64 0, 0
  %v18 = sub i64 %v17, %v16
  br label %b5
b5:
  %v19 = phi i64 [ %v15, %b3 ], [ %v18, %b4 ]
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v78, i64 0
  store i64 %v2, ptr %st6
  ret i64 %v19
b6:
  %v20 = getelementptr i64, ptr %s0, i64 0
  %st7 = getelementptr i64, ptr %v20, i64 0
  store i64 %v10, ptr %st7
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v79, i64 0
  %v21 = load i64, ptr %v21.p
  br label %b7
b7:
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v80, i64 0
  store i64 %v21, ptr %st8
  %v22.p = getelementptr i64, ptr %v20, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 0, 0
  %v24.c = icmp sge i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b7 = icmp ne i64 %v24, 0
  br i1 %c.b7, label %b7.t10, label %b7.e11
b7.t10:
  br label %b8
b7.e11:
  br label %b9
b8:
  call void @"rt.region_enter"()
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %v25.p = getelementptr i64, ptr %v81, i64 0
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v20, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v0, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v26, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b8 = icmp ne i64 %v28, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b10
b8.e13:
  br label %b11
b9:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v82, i64 0
  store i64 %v21, ptr %st13
  %v76 = add i64 0, 0
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v83, i64 0
  store i64 %v2, ptr %st14
  ret i64 %v76
b10:
  %v29 = add i64 0, 55
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v30.p = getelementptr i64, ptr %v0, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = add i64 0, 1
  %v33 = mul i64 %v26, %v32
  %v34 = getelementptr i64, ptr %v31, i64 %v33
  %v35.p = getelementptr i64, ptr %v34, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v20, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v1, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b11 = icmp ne i64 %v38, 0
  br i1 %c.b11, label %b11.t16, label %b11.e17
b11.t16:
  br label %b12
b11.e17:
  br label %b13
b12:
  %v39 = add i64 0, 56
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v40.p = getelementptr i64, ptr %v1, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v36, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %v45.p = getelementptr i64, ptr %v44, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.c = icmp ne i64 %v35, %v45
  %v46 = zext i1 %v46.c to i64
  %c.b13 = icmp ne i64 %v46, 0
  br i1 %c.b13, label %b13.t18, label %b13.e19
b13.t18:
  br label %b14
b13.e19:
  br label %b15
b14:
  %v47.p = getelementptr i64, ptr %v20, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v0, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp uge i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b14 = icmp ne i64 %v49, 0
  br i1 %c.b14, label %b14.t20, label %b14.e21
b14.t20:
  br label %b16
b14.e21:
  br label %b17
b15:
  br label %b23
b16:
  %v50 = add i64 0, 57
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v51.p = getelementptr i64, ptr %v0, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = add i64 0, 1
  %v54 = mul i64 %v47, %v53
  %v55 = getelementptr i64, ptr %v52, i64 %v54
  %v56.p = getelementptr i64, ptr %v55, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v20, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v1, i64 1
  %v58 = load i64, ptr %v58.p
  %v59.c = icmp uge i64 %v57, %v58
  %v59 = zext i1 %v59.c to i64
  %c.b17 = icmp ne i64 %v59, 0
  br i1 %c.b17, label %b17.t22, label %b17.e23
b17.t22:
  br label %b18
b17.e23:
  br label %b19
b18:
  %v60 = add i64 0, 58
  call void @"rt.panic"(i64 %v60)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v61.p = getelementptr i64, ptr %v1, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = inttoptr i64 %v61 to ptr
  %v63 = add i64 0, 1
  %v64 = mul i64 %v57, %v63
  %v65 = getelementptr i64, ptr %v62, i64 %v64
  %v66.p = getelementptr i64, ptr %v65, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp sgt i64 %v56, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b19 = icmp ne i64 %v67, 0
  br i1 %c.b19, label %b19.t24, label %b19.e25
b19.t24:
  br label %b20
b19.e25:
  br label %b21
b20:
  %v68 = add i64 0, 1
  br label %b22
b21:
  %v69 = add i64 0, 1
  %v70 = add i64 0, 0
  %v71 = sub i64 %v70, %v69
  br label %b22
b22:
  %v72 = phi i64 [ %v68, %b20 ], [ %v71, %b21 ]
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v84, i64 0
  store i64 %v2, ptr %st25
  ret i64 %v72
b23:
  %v73 = add i64 0, 1
  %v74.p = getelementptr i64, ptr %v20, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = sub i64 %v74, %v73
  %st26 = getelementptr i64, ptr %v20, i64 0
  store i64 %v75, ptr %st26
  br label %b7
}

define internal void @"std/internal/floatfmt.bnSub"(ptr %v0, ptr %v1) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %s2 = alloca [1 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %v73 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v73, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = add i64 0, 0
  %v10 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v10, i64 0
  store i64 %v9, ptr %st0
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v74, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.p = getelementptr i64, ptr %v0, i64 1
  %v13 = load i64, ptr %v13.p
  %v14 = getelementptr i64, ptr %s1, i64 0
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v75, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s2, i64 0
  %st1 = getelementptr i64, ptr %v16, i64 0
  store i64 %v12, ptr %st1
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v76, i64 0
  %v17 = load i64, ptr %v17.p
  br label %b3
b1:
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v77, i64 0
  store i64 %v11, ptr %st2
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v78, i64 0
  store i64 %v2, ptr %st3
  ret void
b2:
  br label %b1
b3:
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v79, i64 0
  store i64 %v17, ptr %st4
  %v18.p = getelementptr i64, ptr %v16, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.c = icmp slt i64 %v18, %v13
  %v19 = zext i1 %v19.c to i64
  %c.b3 = icmp ne i64 %v19, 0
  br i1 %c.b3, label %b3.t6, label %b3.e7
b3.t6:
  br label %b4
b3.e7:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v80, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 0
  %v21 = load i64, ptr %v21.p
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v81, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v0, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.c = icmp uge i64 %v21, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b4 = icmp ne i64 %v24, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b7
b4.e9:
  br label %b8
b5:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v82, i64 0
  store i64 %v17, ptr %st9
  br label %b2
b6:
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v83, i64 0
  store i64 %v22, ptr %st10
  %v70 = add i64 0, 1
  %v71.p = getelementptr i64, ptr %v16, i64 0
  %v71 = load i64, ptr %v71.p
  %v72 = add i64 %v71, %v70
  %st11 = getelementptr i64, ptr %v16, i64 0
  store i64 %v72, ptr %st11
  br label %b3
b7:
  %v25 = add i64 0, 59
  call void @"rt.panic"(i64 %v25)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v26.p = getelementptr i64, ptr %v0, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = inttoptr i64 %v26 to ptr
  %v28 = add i64 0, 1
  %v29 = mul i64 %v21, %v28
  %v30 = getelementptr i64, ptr %v27, i64 %v29
  %v31.p = getelementptr i64, ptr %v30, i64 0
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v1, i64 1
  %v32 = load i64, ptr %v32.p
  %v33.c = icmp slt i64 %v21, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b8 = icmp ne i64 %v33, 0
  br i1 %c.b8, label %b8.t13, label %b8.e14
b8.t13:
  br label %b9
b8.e14:
  br label %b10
b9:
  %v34.p = getelementptr i64, ptr %v1, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp uge i64 %v21, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b9 = icmp ne i64 %v35, 0
  br i1 %c.b9, label %b9.t15, label %b9.e16
b9.t15:
  br label %b11
b9.e16:
  br label %b12
b10:
  %v43 = add i64 0, 0
  br label %b13
b11:
  %v36 = add i64 0, 60
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v37.p = getelementptr i64, ptr %v1, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = inttoptr i64 %v37 to ptr
  %v39 = add i64 0, 1
  %v40 = mul i64 %v21, %v39
  %v41 = getelementptr i64, ptr %v38, i64 %v40
  %v42.p = getelementptr i64, ptr %v41, i64 0
  %v42 = load i64, ptr %v42.p
  br label %b13
b13:
  %v44 = phi i64 [ %v43, %b10 ], [ %v42, %b12 ]
  %v45 = sub i64 %v31, %v44
  %v46.p = getelementptr i64, ptr %v10, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = sub i64 %v45, %v46
  %v48 = add i64 0, 0
  %v49.c = icmp slt i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b13 = icmp ne i64 %v49, 0
  br i1 %c.b13, label %b13.t17, label %b13.e18
b13.t17:
  br label %b14
b13.e18:
  br label %b15
b14:
  %v50 = add i64 0, 1073741824
  %v51 = add i64 %v47, %v50
  %v52.p = getelementptr i64, ptr %v0, i64 1
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp uge i64 %v21, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b14 = icmp ne i64 %v53, 0
  br i1 %c.b14, label %b14.t19, label %b14.e20
b14.t19:
  br label %b16
b14.e20:
  br label %b17
b15:
  %v61.p = getelementptr i64, ptr %v0, i64 1
  %v61 = load i64, ptr %v61.p
  %v62.c = icmp uge i64 %v21, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b15 = icmp ne i64 %v62, 0
  br i1 %c.b15, label %b15.t21, label %b15.e22
b15.t21:
  br label %b18
b15.e22:
  br label %b19
b16:
  %v54 = add i64 0, 61
  call void @"rt.panic"(i64 %v54)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v55.p = getelementptr i64, ptr %v0, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = inttoptr i64 %v55 to ptr
  %v57 = add i64 0, 1
  %v58 = mul i64 %v21, %v57
  %v59 = getelementptr i64, ptr %v56, i64 %v58
  %st22 = getelementptr i64, ptr %v59, i64 0
  store i64 %v51, ptr %st22
  %v60 = add i64 0, 1
  %st23 = getelementptr i64, ptr %v10, i64 0
  store i64 %v60, ptr %st23
  br label %b20
b18:
  %v63 = add i64 0, 62
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v64.p = getelementptr i64, ptr %v0, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = inttoptr i64 %v64 to ptr
  %v66 = add i64 0, 1
  %v67 = mul i64 %v21, %v66
  %v68 = getelementptr i64, ptr %v65, i64 %v67
  %st24 = getelementptr i64, ptr %v68, i64 0
  store i64 %v47, ptr %st24
  %v69 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v10, i64 0
  store i64 %v69, ptr %st25
  br label %b20
b20:
  br label %b6
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
  %v13 = add i64 0, 63
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
  %v22 = add i64 0, 64
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
  %v8 = add i64 0, 65
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
  %v35 = add i64 0, 66
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
  %v52 = add i64 0, 67
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
  %v74 = add i64 0, 68
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
  %v106 = add i64 0, 69
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
  %v121 = add i64 0, 70
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

define internal void @"rt.err_relocate"(ptr %v0, i64 %v1) #0 {
b0:
  %v2 = add i64 0, 2
  %v3 = getelementptr i64, ptr %v0, i64 %v2
  %v4 = add i64 0, 2
  call void @"rt.region_relocate"(ptr %v3, i64 %v4, i64 %v1)
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
  %v20 = getelementptr i64, ptr @"str.15", i64 0
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
  %v74 = getelementptr i64, ptr @"str.23", i64 0
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
  %v27 = getelementptr i64, ptr @"str.16", i64 0
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
  %v34 = getelementptr i64, ptr @"str.17", i64 0
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
  %v41 = getelementptr i64, ptr @"str.18", i64 0
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
  %v48 = getelementptr i64, ptr @"str.19", i64 0
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
  %v55 = getelementptr i64, ptr @"str.20", i64 0
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
  %v62 = getelementptr i64, ptr @"str.21", i64 0
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
  %v69 = getelementptr i64, ptr @"str.22", i64 0
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
  %v81 = getelementptr i64, ptr @"str.24", i64 0
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
  %v88 = getelementptr i64, ptr @"str.25", i64 0
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
  %v95 = getelementptr i64, ptr @"str.26", i64 0
  %v96 = add i64 0, 36
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
  %v102 = getelementptr i64, ptr @"str.27", i64 0
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
