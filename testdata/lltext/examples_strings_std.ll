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
@"str.57" = internal constant [1 x i64] [i64 1869033057]
@"str.58" = internal constant [1 x i64] [i64 7300910]
@"str.59" = internal constant [1 x i64] [i64 7565870]
@"str.60" = internal constant [1 x i64] [i64 25442]
@"str.61" = internal constant [1 x i64] [i64 8815075]
@"str.62" = internal constant [2 x i64] [i64 7307214019182489447, i64 114]
@"str.63" = internal constant [1 x i64] [i64 28519]
@"str.64" = internal constant [1 x i64] [i64 128017496305522]
@"str.65" = internal constant [2 x i64] [i64 -9087273929700900381, i64 2223104898]
@"str.66" = internal constant [1 x i64] [i64 425946393697]
@"str.67" = internal constant [1 x i64] [i64 44]
@"str.68" = internal constant [1 x i64] [i64 12493940349611105]
@"str.69" = internal constant [1 x i64] [i64 7158568744335726689]
@"str.70" = internal constant [1 x i64] [i64 48939036519521]
@"str.71" = internal constant [1 x i64] [i64 8691530144754205410]
@"str.72" = internal constant [3 x i64] [i64 7017206832379076640, i64 2314984767145123954, i64 32]
@"str.73" = internal constant [1 x i64] [i64 137657714976]
@"str.74" = internal constant [1 x i64] [i64 108909130572041]
@"str.75" = internal constant [2 x i64] [i64 685815855770141155, i64 8815075]
@"str.76" = internal constant [1 x i64] [i64 2105464]
@"str.77" = internal constant [3 x i64] [i64 7812730814030547232, i64 7307214018645601391, i64 2829082242872178]
@"str.78" = internal constant [1 x i64] [i64 2105376]
@"str.79" = internal constant [1 x i64] [i64 6430817]
@"str.80" = internal constant [1 x i64] [i64 158861837]
@"str.81" = internal constant [1 x i64] [i64 139628503840]
@"str.82" = internal constant [2 x i64] [i64 7956012401758726511, i64 118121959465067]
@"str.83" = internal constant [1 x i64] [i64 107]
@"str.84" = internal constant [1 x i64] [i64 31083]
@"str.85" = internal constant [1 x i64] [i64 1802398063]
@"str.86" = internal constant [1 x i64] [i64 7303021]
@"str.87" = internal constant [1 x i64] [i64 45]
@"str.88" = internal constant [1 x i64] [i64 98]
@"str.89" = internal constant [1 x i64] [i64 121]
@"str.90" = internal constant [1 x i64] [i64 66]
@"str.91" = internal constant [1 x i64] [i64 124]
@"str.92" = internal constant [1 x i64] [i64 1650549345]
@"str.93" = internal constant [1 x i64] [i64 125779869462343]
@"str.94" = internal constant [2 x i64] [i64 4637117001582723649, i64 8085595]
@"str.95" = internal constant [1 x i64] [i64 34168841658592353]
@"str.96" = internal constant [1 x i64] [i64 1099071971]
@"str.97" = internal constant [2 x i64] [i64 4646159522650612321, i64 8085595]
@"str.98" = internal constant [1 x i64] [i64 25126320053832769]
@"str.99" = internal constant [1 x i64] [i64 1635942883]
@"str.100" = internal constant [1 x i64] [i64 28487]
@"str.101" = internal constant [1 x i64] [i64 20295]
@"str.102" = internal constant [1 x i64] [i64 24903]
@"str.103" = internal constant [1 x i64] [i64 64]
@"str.104" = internal constant [1 x i64] [i64 96]
@"str.105" = internal constant [1 x i64] [i64 91]
@"str.106" = internal constant [1 x i64] [i64 123]
@"str.107" = internal constant [2 x i64] [i64 3275364211029339971, i64 1701869908]
@"str.108" = internal constant [2 x i64] [i64 3275364211029340003, i64 1701869940]
@"str.109" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.110" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.111" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.112" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.113" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.114" = internal constant [1 x i64] [i64 2685]
@"str.115" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.116" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.117" = internal constant [1 x i64] [i64 35899498962976]
@"str.118" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.119" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [55 x i64] [i64 9851629637468161, i64 14918179218259969, i64 11821954608660483, i64 7599829387575297, i64 11259004084813825, i64 4222129818042369, i64 15481128903245827, i64 9007203600039937, i64 9007203683926017, i64 7881303995187201, i64 8725727113379841, i64 3659174865010689, i64 7318349562249217, i64 8162778166591489, i64 8162778216923137, i64 18295877428838402, i64 18295877428838402, i64 18295877428838402, i64 10414580647854081, i64 6192456064303105, i64 9007205881741313, i64 10696052621443073, i64 10977527665262593, i64 12947852569346050, i64 12947852569346050, i64 12947852569346050, i64 12947852049252354, i64 12947852049252354, i64 12947852049252354, i64 11821952276627458, i64 11821952276627458, i64 11821952276627458, i64 10696052436893698, i64 10696052436893698, i64 10696052436893698, i64 24488325440077826, i64 24488325440077826, i64 24488325440077826, i64 7599826569003010, i64 7599826569003010, i64 7599826569003010, i64 14355226010058754, i64 14355226010058754, i64 14355226010058754, i64 7599826367676418, i64 7599826367676418, i64 7599826367676418, i64 14355225808732162, i64 14355225808732162, i64 14355225808732162, i64 20547675631910914, i64 20547675631910914, i64 20547675631910914, i64 3659180451823617, i64 5066550218326017]
@"str.120" = internal constant [1 x i64] [i64 9071397899755888]
@"str.121" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.122" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.123" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.124" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.125" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.126" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.127" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.128" = internal constant [1 x i64] [i64 544497952]
@"str.129" = internal constant [4 x i64] [i64 7598263559392621683, i64 7598263559393601390, i64 7305524086039603054, i64 114]

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
  %v3 = getelementptr i64, ptr @"str.109", i64 0
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
  %v29 = getelementptr i64, ptr @"str.113", i64 0
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
  %v35 = getelementptr i64, ptr @"str.114", i64 0
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
  %v10 = getelementptr i64, ptr @"str.110", i64 0
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
  %v17 = getelementptr i64, ptr @"str.111", i64 0
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
  %v24 = getelementptr i64, ptr @"str.112", i64 0
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
  %v60 = getelementptr i64, ptr @"str.115", i64 0
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
  %v65 = getelementptr i64, ptr @"str.116", i64 0
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
  %v70 = getelementptr i64, ptr @"str.114", i64 0
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
  %v81 = getelementptr i64, ptr @"str.117", i64 0
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
  %v88 = getelementptr i64, ptr @"str.118", i64 0
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
  %v17 = getelementptr i64, ptr @"str.119", i64 0
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
  %v22 = getelementptr i64, ptr @"str.114", i64 0
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
  %s46 = alloca [3 x i64], align 8
  %s46.z0 = getelementptr i64, ptr %s46, i64 0
  store i64 0, ptr %s46.z0
  %s46.z1 = getelementptr i64, ptr %s46, i64 1
  store i64 0, ptr %s46.z1
  %s46.z2 = getelementptr i64, ptr %s46, i64 2
  store i64 0, ptr %s46.z2
  %s47 = alloca [3 x i64], align 8
  %s47.z0 = getelementptr i64, ptr %s47, i64 0
  store i64 0, ptr %s47.z0
  %s47.z1 = getelementptr i64, ptr %s47, i64 1
  store i64 0, ptr %s47.z1
  %s47.z2 = getelementptr i64, ptr %s47, i64 2
  store i64 0, ptr %s47.z2
  %v2804 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v2804, i64 0
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
  %v1442 = getelementptr i64, ptr %s9, i64 0
  %v1443 = getelementptr i64, ptr @"str.57", i64 0
  %v1444 = add i64 0, 4
  %v1445 = add i64 0, 0
  %v1446 = getelementptr i64, ptr %s0, i64 0
  %v1447 = ptrtoint ptr %v1443 to i64
  %st468 = getelementptr i64, ptr %v1446, i64 0
  store i64 %v1447, ptr %st468
  %st469 = getelementptr i64, ptr %v1446, i64 1
  store i64 %v1444, ptr %st469
  %st470 = getelementptr i64, ptr %v1446, i64 2
  store i64 %v1445, ptr %st470
  %v1448.p = getelementptr i64, ptr %v1446, i64 0
  %v1448 = load i64, ptr %v1448.p
  %v1449.p = getelementptr i64, ptr %v1446, i64 1
  %v1449 = load i64, ptr %v1449.p
  %v1450.p = getelementptr i64, ptr %v1446, i64 2
  %v1450 = load i64, ptr %v1450.p
  %v1451 = getelementptr i64, ptr @"str.58", i64 0
  %v1452 = add i64 0, 3
  %v1453 = add i64 0, 0
  %v1454 = getelementptr i64, ptr %s1, i64 0
  %v1455 = ptrtoint ptr %v1451 to i64
  %st471 = getelementptr i64, ptr %v1454, i64 0
  store i64 %v1455, ptr %st471
  %st472 = getelementptr i64, ptr %v1454, i64 1
  store i64 %v1452, ptr %st472
  %st473 = getelementptr i64, ptr %v1454, i64 2
  store i64 %v1453, ptr %st473
  %v1456.p = getelementptr i64, ptr %v1454, i64 0
  %v1456 = load i64, ptr %v1456.p
  %v1457.p = getelementptr i64, ptr %v1454, i64 1
  %v1457 = load i64, ptr %v1457.p
  %v1458.p = getelementptr i64, ptr %v1454, i64 2
  %v1458 = load i64, ptr %v1458.p
  call void @"std/strings.TrimSuffix"(ptr %v1442, i64 %v1448, i64 %v1449, i64 %v1450, i64 %v1456, i64 %v1457, i64 %v1458)
  call void @"rt.print_str"(ptr %v1442)
  %v1459 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1459)
  %v1460 = getelementptr i64, ptr %s10, i64 0
  %v1461 = getelementptr i64, ptr @"str.57", i64 0
  %v1462 = add i64 0, 4
  %v1463 = add i64 0, 0
  %v1464 = getelementptr i64, ptr %s1, i64 0
  %v1465 = ptrtoint ptr %v1461 to i64
  %st474 = getelementptr i64, ptr %v1464, i64 0
  store i64 %v1465, ptr %st474
  %st475 = getelementptr i64, ptr %v1464, i64 1
  store i64 %v1462, ptr %st475
  %st476 = getelementptr i64, ptr %v1464, i64 2
  store i64 %v1463, ptr %st476
  %v1466.p = getelementptr i64, ptr %v1464, i64 0
  %v1466 = load i64, ptr %v1466.p
  %v1467.p = getelementptr i64, ptr %v1464, i64 1
  %v1467 = load i64, ptr %v1467.p
  %v1468.p = getelementptr i64, ptr %v1464, i64 2
  %v1468 = load i64, ptr %v1468.p
  %v1469 = getelementptr i64, ptr @"str.59", i64 0
  %v1470 = add i64 0, 3
  %v1471 = add i64 0, 0
  %v1472 = getelementptr i64, ptr %s0, i64 0
  %v1473 = ptrtoint ptr %v1469 to i64
  %st477 = getelementptr i64, ptr %v1472, i64 0
  store i64 %v1473, ptr %st477
  %st478 = getelementptr i64, ptr %v1472, i64 1
  store i64 %v1470, ptr %st478
  %st479 = getelementptr i64, ptr %v1472, i64 2
  store i64 %v1471, ptr %st479
  %v1474.p = getelementptr i64, ptr %v1472, i64 0
  %v1474 = load i64, ptr %v1474.p
  %v1475.p = getelementptr i64, ptr %v1472, i64 1
  %v1475 = load i64, ptr %v1475.p
  %v1476.p = getelementptr i64, ptr %v1472, i64 2
  %v1476 = load i64, ptr %v1476.p
  call void @"std/strings.TrimSuffix"(ptr %v1460, i64 %v1466, i64 %v1467, i64 %v1468, i64 %v1474, i64 %v1475, i64 %v1476)
  call void @"rt.print_str"(ptr %v1460)
  %v1477 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1477)
  %v1478 = getelementptr i64, ptr %s11, i64 0
  %v1479 = getelementptr i64, ptr @"str.6", i64 0
  %v1480 = add i64 0, 3
  %v1481 = add i64 0, 0
  %v1482 = getelementptr i64, ptr %s0, i64 0
  %v1483 = ptrtoint ptr %v1479 to i64
  %st480 = getelementptr i64, ptr %v1482, i64 0
  store i64 %v1483, ptr %st480
  %st481 = getelementptr i64, ptr %v1482, i64 1
  store i64 %v1480, ptr %st481
  %st482 = getelementptr i64, ptr %v1482, i64 2
  store i64 %v1481, ptr %st482
  %v1484.p = getelementptr i64, ptr %v1482, i64 0
  %v1484 = load i64, ptr %v1484.p
  %v1485.p = getelementptr i64, ptr %v1482, i64 1
  %v1485 = load i64, ptr %v1485.p
  %v1486.p = getelementptr i64, ptr %v1482, i64 2
  %v1486 = load i64, ptr %v1486.p
  %v1487 = getelementptr i64, ptr @"str.4", i64 0
  %v1488 = add i64 0, 0
  %v1489 = add i64 0, 0
  %v1490 = getelementptr i64, ptr %s1, i64 0
  %v1491 = ptrtoint ptr %v1487 to i64
  %st483 = getelementptr i64, ptr %v1490, i64 0
  store i64 %v1491, ptr %st483
  %st484 = getelementptr i64, ptr %v1490, i64 1
  store i64 %v1488, ptr %st484
  %st485 = getelementptr i64, ptr %v1490, i64 2
  store i64 %v1489, ptr %st485
  %v1492.p = getelementptr i64, ptr %v1490, i64 0
  %v1492 = load i64, ptr %v1492.p
  %v1493.p = getelementptr i64, ptr %v1490, i64 1
  %v1493 = load i64, ptr %v1493.p
  %v1494.p = getelementptr i64, ptr %v1490, i64 2
  %v1494 = load i64, ptr %v1494.p
  call void @"std/strings.TrimSuffix"(ptr %v1478, i64 %v1484, i64 %v1485, i64 %v1486, i64 %v1492, i64 %v1493, i64 %v1494)
  call void @"rt.print_str"(ptr %v1478)
  %v1495 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1495)
  %v1496 = getelementptr i64, ptr %s12, i64 0
  %v1497 = getelementptr i64, ptr @"str.4", i64 0
  %v1498 = add i64 0, 0
  %v1499 = add i64 0, 0
  %v1500 = getelementptr i64, ptr %s1, i64 0
  %v1501 = ptrtoint ptr %v1497 to i64
  %st486 = getelementptr i64, ptr %v1500, i64 0
  store i64 %v1501, ptr %st486
  %st487 = getelementptr i64, ptr %v1500, i64 1
  store i64 %v1498, ptr %st487
  %st488 = getelementptr i64, ptr %v1500, i64 2
  store i64 %v1499, ptr %st488
  %v1502.p = getelementptr i64, ptr %v1500, i64 0
  %v1502 = load i64, ptr %v1502.p
  %v1503.p = getelementptr i64, ptr %v1500, i64 1
  %v1503 = load i64, ptr %v1503.p
  %v1504.p = getelementptr i64, ptr %v1500, i64 2
  %v1504 = load i64, ptr %v1504.p
  %v1505 = getelementptr i64, ptr @"str.4", i64 0
  %v1506 = add i64 0, 0
  %v1507 = add i64 0, 0
  %v1508 = getelementptr i64, ptr %s0, i64 0
  %v1509 = ptrtoint ptr %v1505 to i64
  %st489 = getelementptr i64, ptr %v1508, i64 0
  store i64 %v1509, ptr %st489
  %st490 = getelementptr i64, ptr %v1508, i64 1
  store i64 %v1506, ptr %st490
  %st491 = getelementptr i64, ptr %v1508, i64 2
  store i64 %v1507, ptr %st491
  %v1510.p = getelementptr i64, ptr %v1508, i64 0
  %v1510 = load i64, ptr %v1510.p
  %v1511.p = getelementptr i64, ptr %v1508, i64 1
  %v1511 = load i64, ptr %v1511.p
  %v1512.p = getelementptr i64, ptr %v1508, i64 2
  %v1512 = load i64, ptr %v1512.p
  call void @"std/strings.TrimSuffix"(ptr %v1496, i64 %v1502, i64 %v1503, i64 %v1504, i64 %v1510, i64 %v1511, i64 %v1512)
  call void @"rt.print_str"(ptr %v1496)
  %v1513 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1513)
  %v1514 = getelementptr i64, ptr %s13, i64 0
  %v1515 = getelementptr i64, ptr @"str.60", i64 0
  %v1516 = add i64 0, 2
  %v1517 = add i64 0, 0
  %v1518 = getelementptr i64, ptr %s0, i64 0
  %v1519 = ptrtoint ptr %v1515 to i64
  %st492 = getelementptr i64, ptr %v1518, i64 0
  store i64 %v1519, ptr %st492
  %st493 = getelementptr i64, ptr %v1518, i64 1
  store i64 %v1516, ptr %st493
  %st494 = getelementptr i64, ptr %v1518, i64 2
  store i64 %v1517, ptr %st494
  %v1520.p = getelementptr i64, ptr %v1518, i64 0
  %v1520 = load i64, ptr %v1520.p
  %v1521.p = getelementptr i64, ptr %v1518, i64 1
  %v1521 = load i64, ptr %v1521.p
  %v1522.p = getelementptr i64, ptr %v1518, i64 2
  %v1522 = load i64, ptr %v1522.p
  %v1523 = getelementptr i64, ptr @"str.6", i64 0
  %v1524 = add i64 0, 3
  %v1525 = add i64 0, 0
  %v1526 = getelementptr i64, ptr %s1, i64 0
  %v1527 = ptrtoint ptr %v1523 to i64
  %st495 = getelementptr i64, ptr %v1526, i64 0
  store i64 %v1527, ptr %st495
  %st496 = getelementptr i64, ptr %v1526, i64 1
  store i64 %v1524, ptr %st496
  %st497 = getelementptr i64, ptr %v1526, i64 2
  store i64 %v1525, ptr %st497
  %v1528.p = getelementptr i64, ptr %v1526, i64 0
  %v1528 = load i64, ptr %v1528.p
  %v1529.p = getelementptr i64, ptr %v1526, i64 1
  %v1529 = load i64, ptr %v1529.p
  %v1530.p = getelementptr i64, ptr %v1526, i64 2
  %v1530 = load i64, ptr %v1530.p
  call void @"std/strings.TrimSuffix"(ptr %v1514, i64 %v1520, i64 %v1521, i64 %v1522, i64 %v1528, i64 %v1529, i64 %v1530)
  call void @"rt.print_str"(ptr %v1514)
  %v1531 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1531)
  %v1532 = getelementptr i64, ptr %s14, i64 0
  %v1533 = getelementptr i64, ptr @"str.20", i64 0
  %v1534 = add i64 0, 9
  %v1535 = add i64 0, 0
  %v1536 = getelementptr i64, ptr %s1, i64 0
  %v1537 = ptrtoint ptr %v1533 to i64
  %st498 = getelementptr i64, ptr %v1536, i64 0
  store i64 %v1537, ptr %st498
  %st499 = getelementptr i64, ptr %v1536, i64 1
  store i64 %v1534, ptr %st499
  %st500 = getelementptr i64, ptr %v1536, i64 2
  store i64 %v1535, ptr %st500
  %v1538.p = getelementptr i64, ptr %v1536, i64 0
  %v1538 = load i64, ptr %v1538.p
  %v1539.p = getelementptr i64, ptr %v1536, i64 1
  %v1539 = load i64, ptr %v1539.p
  %v1540.p = getelementptr i64, ptr %v1536, i64 2
  %v1540 = load i64, ptr %v1540.p
  %v1541 = getelementptr i64, ptr @"str.61", i64 0
  %v1542 = add i64 0, 3
  %v1543 = add i64 0, 0
  %v1544 = getelementptr i64, ptr %s0, i64 0
  %v1545 = ptrtoint ptr %v1541 to i64
  %st501 = getelementptr i64, ptr %v1544, i64 0
  store i64 %v1545, ptr %st501
  %st502 = getelementptr i64, ptr %v1544, i64 1
  store i64 %v1542, ptr %st502
  %st503 = getelementptr i64, ptr %v1544, i64 2
  store i64 %v1543, ptr %st503
  %v1546.p = getelementptr i64, ptr %v1544, i64 0
  %v1546 = load i64, ptr %v1546.p
  %v1547.p = getelementptr i64, ptr %v1544, i64 1
  %v1547 = load i64, ptr %v1547.p
  %v1548.p = getelementptr i64, ptr %v1544, i64 2
  %v1548 = load i64, ptr %v1548.p
  call void @"std/strings.TrimSuffix"(ptr %v1532, i64 %v1538, i64 %v1539, i64 %v1540, i64 %v1546, i64 %v1547, i64 %v1548)
  call void @"rt.print_str"(ptr %v1532)
  %v1549 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1549)
  %v1550 = getelementptr i64, ptr %s15, i64 0
  %v1551 = getelementptr i64, ptr @"str.9", i64 0
  %v1552 = add i64 0, 6
  %v1553 = add i64 0, 0
  %v1554 = getelementptr i64, ptr %s0, i64 0
  %v1555 = ptrtoint ptr %v1551 to i64
  %st504 = getelementptr i64, ptr %v1554, i64 0
  store i64 %v1555, ptr %st504
  %st505 = getelementptr i64, ptr %v1554, i64 1
  store i64 %v1552, ptr %st505
  %st506 = getelementptr i64, ptr %v1554, i64 2
  store i64 %v1553, ptr %st506
  %v1556.p = getelementptr i64, ptr %v1554, i64 0
  %v1556 = load i64, ptr %v1556.p
  %v1557.p = getelementptr i64, ptr %v1554, i64 1
  %v1557 = load i64, ptr %v1557.p
  %v1558.p = getelementptr i64, ptr %v1554, i64 2
  %v1558 = load i64, ptr %v1558.p
  %v1559 = getelementptr i64, ptr @"str.6", i64 0
  %v1560 = add i64 0, 3
  %v1561 = add i64 0, 0
  %v1562 = getelementptr i64, ptr %s1, i64 0
  %v1563 = ptrtoint ptr %v1559 to i64
  %st507 = getelementptr i64, ptr %v1562, i64 0
  store i64 %v1563, ptr %st507
  %st508 = getelementptr i64, ptr %v1562, i64 1
  store i64 %v1560, ptr %st508
  %st509 = getelementptr i64, ptr %v1562, i64 2
  store i64 %v1561, ptr %st509
  %v1564.p = getelementptr i64, ptr %v1562, i64 0
  %v1564 = load i64, ptr %v1564.p
  %v1565.p = getelementptr i64, ptr %v1562, i64 1
  %v1565 = load i64, ptr %v1565.p
  %v1566.p = getelementptr i64, ptr %v1562, i64 2
  %v1566 = load i64, ptr %v1566.p
  call void @"std/strings.TrimSuffix"(ptr %v1550, i64 %v1556, i64 %v1557, i64 %v1558, i64 %v1564, i64 %v1565, i64 %v1566)
  call void @"rt.print_str"(ptr %v1550)
  %v1567 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1567)
  %v1568 = getelementptr i64, ptr @"str.62", i64 0
  %v1569 = add i64 0, 9
  %v1570 = add i64 0, 0
  %v1571 = getelementptr i64, ptr %s1, i64 0
  %v1572 = ptrtoint ptr %v1568 to i64
  %st510 = getelementptr i64, ptr %v1571, i64 0
  store i64 %v1572, ptr %st510
  %st511 = getelementptr i64, ptr %v1571, i64 1
  store i64 %v1569, ptr %st511
  %st512 = getelementptr i64, ptr %v1571, i64 2
  store i64 %v1570, ptr %st512
  %v1573.p = getelementptr i64, ptr %v1571, i64 0
  %v1573 = load i64, ptr %v1573.p
  %v1574.p = getelementptr i64, ptr %v1571, i64 1
  %v1574 = load i64, ptr %v1574.p
  %v1575.p = getelementptr i64, ptr %v1571, i64 2
  %v1575 = load i64, ptr %v1575.p
  %v1576 = getelementptr i64, ptr @"str.63", i64 0
  %v1577 = add i64 0, 2
  %v1578 = add i64 0, 0
  %v1579 = getelementptr i64, ptr %s0, i64 0
  %v1580 = ptrtoint ptr %v1576 to i64
  %st513 = getelementptr i64, ptr %v1579, i64 0
  store i64 %v1580, ptr %st513
  %st514 = getelementptr i64, ptr %v1579, i64 1
  store i64 %v1577, ptr %st514
  %st515 = getelementptr i64, ptr %v1579, i64 2
  store i64 %v1578, ptr %st515
  %v1581.p = getelementptr i64, ptr %v1579, i64 0
  %v1581 = load i64, ptr %v1581.p
  %v1582.p = getelementptr i64, ptr %v1579, i64 1
  %v1582 = load i64, ptr %v1582.p
  %v1583.p = getelementptr i64, ptr %v1579, i64 2
  %v1583 = load i64, ptr %v1583.p
  %v1584 = call i64 @"std/strings.LastIndex"(i64 %v1573, i64 %v1574, i64 %v1575, i64 %v1581, i64 %v1582, i64 %v1583)
  call void @"rt.print_int"(i64 %v1584)
  %v1585 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1585)
  %v1586 = getelementptr i64, ptr @"str.62", i64 0
  %v1587 = add i64 0, 9
  %v1588 = add i64 0, 0
  %v1589 = getelementptr i64, ptr %s0, i64 0
  %v1590 = ptrtoint ptr %v1586 to i64
  %st516 = getelementptr i64, ptr %v1589, i64 0
  store i64 %v1590, ptr %st516
  %st517 = getelementptr i64, ptr %v1589, i64 1
  store i64 %v1587, ptr %st517
  %st518 = getelementptr i64, ptr %v1589, i64 2
  store i64 %v1588, ptr %st518
  %v1591.p = getelementptr i64, ptr %v1589, i64 0
  %v1591 = load i64, ptr %v1591.p
  %v1592.p = getelementptr i64, ptr %v1589, i64 1
  %v1592 = load i64, ptr %v1592.p
  %v1593.p = getelementptr i64, ptr %v1589, i64 2
  %v1593 = load i64, ptr %v1593.p
  %v1594 = getelementptr i64, ptr @"str.64", i64 0
  %v1595 = add i64 0, 6
  %v1596 = add i64 0, 0
  %v1597 = getelementptr i64, ptr %s1, i64 0
  %v1598 = ptrtoint ptr %v1594 to i64
  %st519 = getelementptr i64, ptr %v1597, i64 0
  store i64 %v1598, ptr %st519
  %st520 = getelementptr i64, ptr %v1597, i64 1
  store i64 %v1595, ptr %st520
  %st521 = getelementptr i64, ptr %v1597, i64 2
  store i64 %v1596, ptr %st521
  %v1599.p = getelementptr i64, ptr %v1597, i64 0
  %v1599 = load i64, ptr %v1599.p
  %v1600.p = getelementptr i64, ptr %v1597, i64 1
  %v1600 = load i64, ptr %v1600.p
  %v1601.p = getelementptr i64, ptr %v1597, i64 2
  %v1601 = load i64, ptr %v1601.p
  %v1602 = call i64 @"std/strings.LastIndex"(i64 %v1591, i64 %v1592, i64 %v1593, i64 %v1599, i64 %v1600, i64 %v1601)
  call void @"rt.print_int"(i64 %v1602)
  %v1603 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1603)
  %v1604 = getelementptr i64, ptr @"str.6", i64 0
  %v1605 = add i64 0, 3
  %v1606 = add i64 0, 0
  %v1607 = getelementptr i64, ptr %s1, i64 0
  %v1608 = ptrtoint ptr %v1604 to i64
  %st522 = getelementptr i64, ptr %v1607, i64 0
  store i64 %v1608, ptr %st522
  %st523 = getelementptr i64, ptr %v1607, i64 1
  store i64 %v1605, ptr %st523
  %st524 = getelementptr i64, ptr %v1607, i64 2
  store i64 %v1606, ptr %st524
  %v1609.p = getelementptr i64, ptr %v1607, i64 0
  %v1609 = load i64, ptr %v1609.p
  %v1610.p = getelementptr i64, ptr %v1607, i64 1
  %v1610 = load i64, ptr %v1610.p
  %v1611.p = getelementptr i64, ptr %v1607, i64 2
  %v1611 = load i64, ptr %v1611.p
  %v1612 = getelementptr i64, ptr @"str.4", i64 0
  %v1613 = add i64 0, 0
  %v1614 = add i64 0, 0
  %v1615 = getelementptr i64, ptr %s0, i64 0
  %v1616 = ptrtoint ptr %v1612 to i64
  %st525 = getelementptr i64, ptr %v1615, i64 0
  store i64 %v1616, ptr %st525
  %st526 = getelementptr i64, ptr %v1615, i64 1
  store i64 %v1613, ptr %st526
  %st527 = getelementptr i64, ptr %v1615, i64 2
  store i64 %v1614, ptr %st527
  %v1617.p = getelementptr i64, ptr %v1615, i64 0
  %v1617 = load i64, ptr %v1617.p
  %v1618.p = getelementptr i64, ptr %v1615, i64 1
  %v1618 = load i64, ptr %v1618.p
  %v1619.p = getelementptr i64, ptr %v1615, i64 2
  %v1619 = load i64, ptr %v1619.p
  %v1620 = call i64 @"std/strings.LastIndex"(i64 %v1609, i64 %v1610, i64 %v1611, i64 %v1617, i64 %v1618, i64 %v1619)
  call void @"rt.print_int"(i64 %v1620)
  %v1621 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1621)
  %v1622 = getelementptr i64, ptr @"str.4", i64 0
  %v1623 = add i64 0, 0
  %v1624 = add i64 0, 0
  %v1625 = getelementptr i64, ptr %s0, i64 0
  %v1626 = ptrtoint ptr %v1622 to i64
  %st528 = getelementptr i64, ptr %v1625, i64 0
  store i64 %v1626, ptr %st528
  %st529 = getelementptr i64, ptr %v1625, i64 1
  store i64 %v1623, ptr %st529
  %st530 = getelementptr i64, ptr %v1625, i64 2
  store i64 %v1624, ptr %st530
  %v1627.p = getelementptr i64, ptr %v1625, i64 0
  %v1627 = load i64, ptr %v1627.p
  %v1628.p = getelementptr i64, ptr %v1625, i64 1
  %v1628 = load i64, ptr %v1628.p
  %v1629.p = getelementptr i64, ptr %v1625, i64 2
  %v1629 = load i64, ptr %v1629.p
  %v1630 = getelementptr i64, ptr @"str.4", i64 0
  %v1631 = add i64 0, 0
  %v1632 = add i64 0, 0
  %v1633 = getelementptr i64, ptr %s1, i64 0
  %v1634 = ptrtoint ptr %v1630 to i64
  %st531 = getelementptr i64, ptr %v1633, i64 0
  store i64 %v1634, ptr %st531
  %st532 = getelementptr i64, ptr %v1633, i64 1
  store i64 %v1631, ptr %st532
  %st533 = getelementptr i64, ptr %v1633, i64 2
  store i64 %v1632, ptr %st533
  %v1635.p = getelementptr i64, ptr %v1633, i64 0
  %v1635 = load i64, ptr %v1635.p
  %v1636.p = getelementptr i64, ptr %v1633, i64 1
  %v1636 = load i64, ptr %v1636.p
  %v1637.p = getelementptr i64, ptr %v1633, i64 2
  %v1637 = load i64, ptr %v1637.p
  %v1638 = call i64 @"std/strings.LastIndex"(i64 %v1627, i64 %v1628, i64 %v1629, i64 %v1635, i64 %v1636, i64 %v1637)
  call void @"rt.print_int"(i64 %v1638)
  %v1639 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1639)
  %v1640 = getelementptr i64, ptr @"str.4", i64 0
  %v1641 = add i64 0, 0
  %v1642 = add i64 0, 0
  %v1643 = getelementptr i64, ptr %s1, i64 0
  %v1644 = ptrtoint ptr %v1640 to i64
  %st534 = getelementptr i64, ptr %v1643, i64 0
  store i64 %v1644, ptr %st534
  %st535 = getelementptr i64, ptr %v1643, i64 1
  store i64 %v1641, ptr %st535
  %st536 = getelementptr i64, ptr %v1643, i64 2
  store i64 %v1642, ptr %st536
  %v1645.p = getelementptr i64, ptr %v1643, i64 0
  %v1645 = load i64, ptr %v1645.p
  %v1646.p = getelementptr i64, ptr %v1643, i64 1
  %v1646 = load i64, ptr %v1646.p
  %v1647.p = getelementptr i64, ptr %v1643, i64 2
  %v1647 = load i64, ptr %v1647.p
  %v1648 = getelementptr i64, ptr @"str.5", i64 0
  %v1649 = add i64 0, 1
  %v1650 = add i64 0, 0
  %v1651 = getelementptr i64, ptr %s0, i64 0
  %v1652 = ptrtoint ptr %v1648 to i64
  %st537 = getelementptr i64, ptr %v1651, i64 0
  store i64 %v1652, ptr %st537
  %st538 = getelementptr i64, ptr %v1651, i64 1
  store i64 %v1649, ptr %st538
  %st539 = getelementptr i64, ptr %v1651, i64 2
  store i64 %v1650, ptr %st539
  %v1653.p = getelementptr i64, ptr %v1651, i64 0
  %v1653 = load i64, ptr %v1653.p
  %v1654.p = getelementptr i64, ptr %v1651, i64 1
  %v1654 = load i64, ptr %v1654.p
  %v1655.p = getelementptr i64, ptr %v1651, i64 2
  %v1655 = load i64, ptr %v1655.p
  %v1656 = call i64 @"std/strings.LastIndex"(i64 %v1645, i64 %v1646, i64 %v1647, i64 %v1653, i64 %v1654, i64 %v1655)
  call void @"rt.print_int"(i64 %v1656)
  %v1657 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1657)
  %v1658 = getelementptr i64, ptr @"str.38", i64 0
  %v1659 = add i64 0, 3
  %v1660 = add i64 0, 0
  %v1661 = getelementptr i64, ptr %s0, i64 0
  %v1662 = ptrtoint ptr %v1658 to i64
  %st540 = getelementptr i64, ptr %v1661, i64 0
  store i64 %v1662, ptr %st540
  %st541 = getelementptr i64, ptr %v1661, i64 1
  store i64 %v1659, ptr %st541
  %st542 = getelementptr i64, ptr %v1661, i64 2
  store i64 %v1660, ptr %st542
  %v1663.p = getelementptr i64, ptr %v1661, i64 0
  %v1663 = load i64, ptr %v1663.p
  %v1664.p = getelementptr i64, ptr %v1661, i64 1
  %v1664 = load i64, ptr %v1664.p
  %v1665.p = getelementptr i64, ptr %v1661, i64 2
  %v1665 = load i64, ptr %v1665.p
  %v1666 = getelementptr i64, ptr @"str.31", i64 0
  %v1667 = add i64 0, 2
  %v1668 = add i64 0, 0
  %v1669 = getelementptr i64, ptr %s1, i64 0
  %v1670 = ptrtoint ptr %v1666 to i64
  %st543 = getelementptr i64, ptr %v1669, i64 0
  store i64 %v1670, ptr %st543
  %st544 = getelementptr i64, ptr %v1669, i64 1
  store i64 %v1667, ptr %st544
  %st545 = getelementptr i64, ptr %v1669, i64 2
  store i64 %v1668, ptr %st545
  %v1671.p = getelementptr i64, ptr %v1669, i64 0
  %v1671 = load i64, ptr %v1671.p
  %v1672.p = getelementptr i64, ptr %v1669, i64 1
  %v1672 = load i64, ptr %v1672.p
  %v1673.p = getelementptr i64, ptr %v1669, i64 2
  %v1673 = load i64, ptr %v1673.p
  %v1674 = call i64 @"std/strings.LastIndex"(i64 %v1663, i64 %v1664, i64 %v1665, i64 %v1671, i64 %v1672, i64 %v1673)
  call void @"rt.print_int"(i64 %v1674)
  %v1675 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1675)
  %v1676 = getelementptr i64, ptr @"str.65", i64 0
  %v1677 = add i64 0, 12
  %v1678 = add i64 0, 0
  %v1679 = getelementptr i64, ptr %s1, i64 0
  %v1680 = ptrtoint ptr %v1676 to i64
  %st546 = getelementptr i64, ptr %v1679, i64 0
  store i64 %v1680, ptr %st546
  %st547 = getelementptr i64, ptr %v1679, i64 1
  store i64 %v1677, ptr %st547
  %st548 = getelementptr i64, ptr %v1679, i64 2
  store i64 %v1678, ptr %st548
  %v1681.p = getelementptr i64, ptr %v1679, i64 0
  %v1681 = load i64, ptr %v1681.p
  %v1682.p = getelementptr i64, ptr %v1679, i64 1
  %v1682 = load i64, ptr %v1682.p
  %v1683.p = getelementptr i64, ptr %v1679, i64 2
  %v1683 = load i64, ptr %v1683.p
  %v1684 = getelementptr i64, ptr @"str.42", i64 0
  %v1685 = add i64 0, 3
  %v1686 = add i64 0, 0
  %v1687 = getelementptr i64, ptr %s0, i64 0
  %v1688 = ptrtoint ptr %v1684 to i64
  %st549 = getelementptr i64, ptr %v1687, i64 0
  store i64 %v1688, ptr %st549
  %st550 = getelementptr i64, ptr %v1687, i64 1
  store i64 %v1685, ptr %st550
  %st551 = getelementptr i64, ptr %v1687, i64 2
  store i64 %v1686, ptr %st551
  %v1689.p = getelementptr i64, ptr %v1687, i64 0
  %v1689 = load i64, ptr %v1689.p
  %v1690.p = getelementptr i64, ptr %v1687, i64 1
  %v1690 = load i64, ptr %v1690.p
  %v1691.p = getelementptr i64, ptr %v1687, i64 2
  %v1691 = load i64, ptr %v1691.p
  %v1692 = call i64 @"std/strings.LastIndex"(i64 %v1681, i64 %v1682, i64 %v1683, i64 %v1689, i64 %v1690, i64 %v1691)
  call void @"rt.print_int"(i64 %v1692)
  %v1693 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1693)
  %v1694 = getelementptr i64, ptr @"str.14", i64 0
  %v1695 = add i64 0, 2
  %v1696 = add i64 0, 0
  %v1697 = getelementptr i64, ptr %s0, i64 0
  %v1698 = ptrtoint ptr %v1694 to i64
  %st552 = getelementptr i64, ptr %v1697, i64 0
  store i64 %v1698, ptr %st552
  %st553 = getelementptr i64, ptr %v1697, i64 1
  store i64 %v1695, ptr %st553
  %st554 = getelementptr i64, ptr %v1697, i64 2
  store i64 %v1696, ptr %st554
  %v1699.p = getelementptr i64, ptr %v1697, i64 0
  %v1699 = load i64, ptr %v1699.p
  %v1700.p = getelementptr i64, ptr %v1697, i64 1
  %v1700 = load i64, ptr %v1700.p
  %v1701.p = getelementptr i64, ptr %v1697, i64 2
  %v1701 = load i64, ptr %v1701.p
  %v1702 = getelementptr i64, ptr @"str.6", i64 0
  %v1703 = add i64 0, 3
  %v1704 = add i64 0, 0
  %v1705 = getelementptr i64, ptr %s1, i64 0
  %v1706 = ptrtoint ptr %v1702 to i64
  %st555 = getelementptr i64, ptr %v1705, i64 0
  store i64 %v1706, ptr %st555
  %st556 = getelementptr i64, ptr %v1705, i64 1
  store i64 %v1703, ptr %st556
  %st557 = getelementptr i64, ptr %v1705, i64 2
  store i64 %v1704, ptr %st557
  %v1707.p = getelementptr i64, ptr %v1705, i64 0
  %v1707 = load i64, ptr %v1707.p
  %v1708.p = getelementptr i64, ptr %v1705, i64 1
  %v1708 = load i64, ptr %v1708.p
  %v1709.p = getelementptr i64, ptr %v1705, i64 2
  %v1709 = load i64, ptr %v1709.p
  %v1710 = call i64 @"std/strings.LastIndex"(i64 %v1699, i64 %v1700, i64 %v1701, i64 %v1707, i64 %v1708, i64 %v1709)
  call void @"rt.print_int"(i64 %v1710)
  %v1711 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1711)
  %v1712 = getelementptr i64, ptr @"str.66", i64 0
  %v1713 = add i64 0, 5
  %v1714 = add i64 0, 0
  %v1715 = getelementptr i64, ptr %s1, i64 0
  %v1716 = ptrtoint ptr %v1712 to i64
  %st558 = getelementptr i64, ptr %v1715, i64 0
  store i64 %v1716, ptr %st558
  %st559 = getelementptr i64, ptr %v1715, i64 1
  store i64 %v1713, ptr %st559
  %st560 = getelementptr i64, ptr %v1715, i64 2
  store i64 %v1714, ptr %st560
  %v1717.p = getelementptr i64, ptr %v1715, i64 0
  %v1717 = load i64, ptr %v1717.p
  %v1718.p = getelementptr i64, ptr %v1715, i64 1
  %v1718 = load i64, ptr %v1718.p
  %v1719.p = getelementptr i64, ptr %v1715, i64 2
  %v1719 = load i64, ptr %v1719.p
  %v1720 = getelementptr i64, ptr @"str.67", i64 0
  %v1721 = add i64 0, 1
  %v1722 = add i64 0, 0
  %v1723 = getelementptr i64, ptr %s0, i64 0
  %v1724 = ptrtoint ptr %v1720 to i64
  %st561 = getelementptr i64, ptr %v1723, i64 0
  store i64 %v1724, ptr %st561
  %st562 = getelementptr i64, ptr %v1723, i64 1
  store i64 %v1721, ptr %st562
  %st563 = getelementptr i64, ptr %v1723, i64 2
  store i64 %v1722, ptr %st563
  %v1725.p = getelementptr i64, ptr %v1723, i64 0
  %v1725 = load i64, ptr %v1725.p
  %v1726.p = getelementptr i64, ptr %v1723, i64 1
  %v1726 = load i64, ptr %v1726.p
  %v1727.p = getelementptr i64, ptr %v1723, i64 2
  %v1727 = load i64, ptr %v1727.p
  call void @"main.showSplit"(i64 %v1717, i64 %v1718, i64 %v1719, i64 %v1725, i64 %v1726, i64 %v1727)
  %v1728 = getelementptr i64, ptr @"str.68", i64 0
  %v1729 = add i64 0, 7
  %v1730 = add i64 0, 0
  %v1731 = getelementptr i64, ptr %s0, i64 0
  %v1732 = ptrtoint ptr %v1728 to i64
  %st564 = getelementptr i64, ptr %v1731, i64 0
  store i64 %v1732, ptr %st564
  %st565 = getelementptr i64, ptr %v1731, i64 1
  store i64 %v1729, ptr %st565
  %st566 = getelementptr i64, ptr %v1731, i64 2
  store i64 %v1730, ptr %st566
  %v1733.p = getelementptr i64, ptr %v1731, i64 0
  %v1733 = load i64, ptr %v1733.p
  %v1734.p = getelementptr i64, ptr %v1731, i64 1
  %v1734 = load i64, ptr %v1734.p
  %v1735.p = getelementptr i64, ptr %v1731, i64 2
  %v1735 = load i64, ptr %v1735.p
  %v1736 = getelementptr i64, ptr @"str.67", i64 0
  %v1737 = add i64 0, 1
  %v1738 = add i64 0, 0
  %v1739 = getelementptr i64, ptr %s1, i64 0
  %v1740 = ptrtoint ptr %v1736 to i64
  %st567 = getelementptr i64, ptr %v1739, i64 0
  store i64 %v1740, ptr %st567
  %st568 = getelementptr i64, ptr %v1739, i64 1
  store i64 %v1737, ptr %st568
  %st569 = getelementptr i64, ptr %v1739, i64 2
  store i64 %v1738, ptr %st569
  %v1741.p = getelementptr i64, ptr %v1739, i64 0
  %v1741 = load i64, ptr %v1741.p
  %v1742.p = getelementptr i64, ptr %v1739, i64 1
  %v1742 = load i64, ptr %v1742.p
  %v1743.p = getelementptr i64, ptr %v1739, i64 2
  %v1743 = load i64, ptr %v1743.p
  call void @"main.showSplit"(i64 %v1733, i64 %v1734, i64 %v1735, i64 %v1741, i64 %v1742, i64 %v1743)
  %v1744 = getelementptr i64, ptr @"str.4", i64 0
  %v1745 = add i64 0, 0
  %v1746 = add i64 0, 0
  %v1747 = getelementptr i64, ptr %s1, i64 0
  %v1748 = ptrtoint ptr %v1744 to i64
  %st570 = getelementptr i64, ptr %v1747, i64 0
  store i64 %v1748, ptr %st570
  %st571 = getelementptr i64, ptr %v1747, i64 1
  store i64 %v1745, ptr %st571
  %st572 = getelementptr i64, ptr %v1747, i64 2
  store i64 %v1746, ptr %st572
  %v1749.p = getelementptr i64, ptr %v1747, i64 0
  %v1749 = load i64, ptr %v1749.p
  %v1750.p = getelementptr i64, ptr %v1747, i64 1
  %v1750 = load i64, ptr %v1750.p
  %v1751.p = getelementptr i64, ptr %v1747, i64 2
  %v1751 = load i64, ptr %v1751.p
  %v1752 = getelementptr i64, ptr @"str.67", i64 0
  %v1753 = add i64 0, 1
  %v1754 = add i64 0, 0
  %v1755 = getelementptr i64, ptr %s0, i64 0
  %v1756 = ptrtoint ptr %v1752 to i64
  %st573 = getelementptr i64, ptr %v1755, i64 0
  store i64 %v1756, ptr %st573
  %st574 = getelementptr i64, ptr %v1755, i64 1
  store i64 %v1753, ptr %st574
  %st575 = getelementptr i64, ptr %v1755, i64 2
  store i64 %v1754, ptr %st575
  %v1757.p = getelementptr i64, ptr %v1755, i64 0
  %v1757 = load i64, ptr %v1757.p
  %v1758.p = getelementptr i64, ptr %v1755, i64 1
  %v1758 = load i64, ptr %v1758.p
  %v1759.p = getelementptr i64, ptr %v1755, i64 2
  %v1759 = load i64, ptr %v1759.p
  call void @"main.showSplit"(i64 %v1749, i64 %v1750, i64 %v1751, i64 %v1757, i64 %v1758, i64 %v1759)
  %v1760 = getelementptr i64, ptr @"str.6", i64 0
  %v1761 = add i64 0, 3
  %v1762 = add i64 0, 0
  %v1763 = getelementptr i64, ptr %s0, i64 0
  %v1764 = ptrtoint ptr %v1760 to i64
  %st576 = getelementptr i64, ptr %v1763, i64 0
  store i64 %v1764, ptr %st576
  %st577 = getelementptr i64, ptr %v1763, i64 1
  store i64 %v1761, ptr %st577
  %st578 = getelementptr i64, ptr %v1763, i64 2
  store i64 %v1762, ptr %st578
  %v1765.p = getelementptr i64, ptr %v1763, i64 0
  %v1765 = load i64, ptr %v1765.p
  %v1766.p = getelementptr i64, ptr %v1763, i64 1
  %v1766 = load i64, ptr %v1766.p
  %v1767.p = getelementptr i64, ptr %v1763, i64 2
  %v1767 = load i64, ptr %v1767.p
  %v1768 = getelementptr i64, ptr @"str.4", i64 0
  %v1769 = add i64 0, 0
  %v1770 = add i64 0, 0
  %v1771 = getelementptr i64, ptr %s1, i64 0
  %v1772 = ptrtoint ptr %v1768 to i64
  %st579 = getelementptr i64, ptr %v1771, i64 0
  store i64 %v1772, ptr %st579
  %st580 = getelementptr i64, ptr %v1771, i64 1
  store i64 %v1769, ptr %st580
  %st581 = getelementptr i64, ptr %v1771, i64 2
  store i64 %v1770, ptr %st581
  %v1773.p = getelementptr i64, ptr %v1771, i64 0
  %v1773 = load i64, ptr %v1773.p
  %v1774.p = getelementptr i64, ptr %v1771, i64 1
  %v1774 = load i64, ptr %v1774.p
  %v1775.p = getelementptr i64, ptr %v1771, i64 2
  %v1775 = load i64, ptr %v1775.p
  call void @"main.showSplit"(i64 %v1765, i64 %v1766, i64 %v1767, i64 %v1773, i64 %v1774, i64 %v1775)
  %v1776 = getelementptr i64, ptr @"str.4", i64 0
  %v1777 = add i64 0, 0
  %v1778 = add i64 0, 0
  %v1779 = getelementptr i64, ptr %s1, i64 0
  %v1780 = ptrtoint ptr %v1776 to i64
  %st582 = getelementptr i64, ptr %v1779, i64 0
  store i64 %v1780, ptr %st582
  %st583 = getelementptr i64, ptr %v1779, i64 1
  store i64 %v1777, ptr %st583
  %st584 = getelementptr i64, ptr %v1779, i64 2
  store i64 %v1778, ptr %st584
  %v1781.p = getelementptr i64, ptr %v1779, i64 0
  %v1781 = load i64, ptr %v1781.p
  %v1782.p = getelementptr i64, ptr %v1779, i64 1
  %v1782 = load i64, ptr %v1782.p
  %v1783.p = getelementptr i64, ptr %v1779, i64 2
  %v1783 = load i64, ptr %v1783.p
  %v1784 = getelementptr i64, ptr @"str.4", i64 0
  %v1785 = add i64 0, 0
  %v1786 = add i64 0, 0
  %v1787 = getelementptr i64, ptr %s0, i64 0
  %v1788 = ptrtoint ptr %v1784 to i64
  %st585 = getelementptr i64, ptr %v1787, i64 0
  store i64 %v1788, ptr %st585
  %st586 = getelementptr i64, ptr %v1787, i64 1
  store i64 %v1785, ptr %st586
  %st587 = getelementptr i64, ptr %v1787, i64 2
  store i64 %v1786, ptr %st587
  %v1789.p = getelementptr i64, ptr %v1787, i64 0
  %v1789 = load i64, ptr %v1789.p
  %v1790.p = getelementptr i64, ptr %v1787, i64 1
  %v1790 = load i64, ptr %v1790.p
  %v1791.p = getelementptr i64, ptr %v1787, i64 2
  %v1791 = load i64, ptr %v1791.p
  call void @"main.showSplit"(i64 %v1781, i64 %v1782, i64 %v1783, i64 %v1789, i64 %v1790, i64 %v1791)
  %v1792 = getelementptr i64, ptr @"str.6", i64 0
  %v1793 = add i64 0, 3
  %v1794 = add i64 0, 0
  %v1795 = getelementptr i64, ptr %s0, i64 0
  %v1796 = ptrtoint ptr %v1792 to i64
  %st588 = getelementptr i64, ptr %v1795, i64 0
  store i64 %v1796, ptr %st588
  %st589 = getelementptr i64, ptr %v1795, i64 1
  store i64 %v1793, ptr %st589
  %st590 = getelementptr i64, ptr %v1795, i64 2
  store i64 %v1794, ptr %st590
  %v1797.p = getelementptr i64, ptr %v1795, i64 0
  %v1797 = load i64, ptr %v1797.p
  %v1798.p = getelementptr i64, ptr %v1795, i64 1
  %v1798 = load i64, ptr %v1798.p
  %v1799.p = getelementptr i64, ptr %v1795, i64 2
  %v1799 = load i64, ptr %v1799.p
  %v1800 = getelementptr i64, ptr @"str.6", i64 0
  %v1801 = add i64 0, 3
  %v1802 = add i64 0, 0
  %v1803 = getelementptr i64, ptr %s1, i64 0
  %v1804 = ptrtoint ptr %v1800 to i64
  %st591 = getelementptr i64, ptr %v1803, i64 0
  store i64 %v1804, ptr %st591
  %st592 = getelementptr i64, ptr %v1803, i64 1
  store i64 %v1801, ptr %st592
  %st593 = getelementptr i64, ptr %v1803, i64 2
  store i64 %v1802, ptr %st593
  %v1805.p = getelementptr i64, ptr %v1803, i64 0
  %v1805 = load i64, ptr %v1805.p
  %v1806.p = getelementptr i64, ptr %v1803, i64 1
  %v1806 = load i64, ptr %v1806.p
  %v1807.p = getelementptr i64, ptr %v1803, i64 2
  %v1807 = load i64, ptr %v1807.p
  call void @"main.showSplit"(i64 %v1797, i64 %v1798, i64 %v1799, i64 %v1805, i64 %v1806, i64 %v1807)
  %v1808 = getelementptr i64, ptr @"str.6", i64 0
  %v1809 = add i64 0, 3
  %v1810 = add i64 0, 0
  %v1811 = getelementptr i64, ptr %s1, i64 0
  %v1812 = ptrtoint ptr %v1808 to i64
  %st594 = getelementptr i64, ptr %v1811, i64 0
  store i64 %v1812, ptr %st594
  %st595 = getelementptr i64, ptr %v1811, i64 1
  store i64 %v1809, ptr %st595
  %st596 = getelementptr i64, ptr %v1811, i64 2
  store i64 %v1810, ptr %st596
  %v1813.p = getelementptr i64, ptr %v1811, i64 0
  %v1813 = load i64, ptr %v1813.p
  %v1814.p = getelementptr i64, ptr %v1811, i64 1
  %v1814 = load i64, ptr %v1814.p
  %v1815.p = getelementptr i64, ptr %v1811, i64 2
  %v1815 = load i64, ptr %v1815.p
  %v1816 = getelementptr i64, ptr @"str.19", i64 0
  %v1817 = add i64 0, 1
  %v1818 = add i64 0, 0
  %v1819 = getelementptr i64, ptr %s0, i64 0
  %v1820 = ptrtoint ptr %v1816 to i64
  %st597 = getelementptr i64, ptr %v1819, i64 0
  store i64 %v1820, ptr %st597
  %st598 = getelementptr i64, ptr %v1819, i64 1
  store i64 %v1817, ptr %st598
  %st599 = getelementptr i64, ptr %v1819, i64 2
  store i64 %v1818, ptr %st599
  %v1821.p = getelementptr i64, ptr %v1819, i64 0
  %v1821 = load i64, ptr %v1821.p
  %v1822.p = getelementptr i64, ptr %v1819, i64 1
  %v1822 = load i64, ptr %v1822.p
  %v1823.p = getelementptr i64, ptr %v1819, i64 2
  %v1823 = load i64, ptr %v1823.p
  call void @"main.showSplit"(i64 %v1813, i64 %v1814, i64 %v1815, i64 %v1821, i64 %v1822, i64 %v1823)
  %v1824 = getelementptr i64, ptr @"str.69", i64 0
  %v1825 = add i64 0, 8
  %v1826 = add i64 0, 0
  %v1827 = getelementptr i64, ptr %s0, i64 0
  %v1828 = ptrtoint ptr %v1824 to i64
  %st600 = getelementptr i64, ptr %v1827, i64 0
  store i64 %v1828, ptr %st600
  %st601 = getelementptr i64, ptr %v1827, i64 1
  store i64 %v1825, ptr %st601
  %st602 = getelementptr i64, ptr %v1827, i64 2
  store i64 %v1826, ptr %st602
  %v1829.p = getelementptr i64, ptr %v1827, i64 0
  %v1829 = load i64, ptr %v1829.p
  %v1830.p = getelementptr i64, ptr %v1827, i64 1
  %v1830 = load i64, ptr %v1830.p
  %v1831.p = getelementptr i64, ptr %v1827, i64 2
  %v1831 = load i64, ptr %v1831.p
  %v1832 = getelementptr i64, ptr @"str.51", i64 0
  %v1833 = add i64 0, 2
  %v1834 = add i64 0, 0
  %v1835 = getelementptr i64, ptr %s1, i64 0
  %v1836 = ptrtoint ptr %v1832 to i64
  %st603 = getelementptr i64, ptr %v1835, i64 0
  store i64 %v1836, ptr %st603
  %st604 = getelementptr i64, ptr %v1835, i64 1
  store i64 %v1833, ptr %st604
  %st605 = getelementptr i64, ptr %v1835, i64 2
  store i64 %v1834, ptr %st605
  %v1837.p = getelementptr i64, ptr %v1835, i64 0
  %v1837 = load i64, ptr %v1837.p
  %v1838.p = getelementptr i64, ptr %v1835, i64 1
  %v1838 = load i64, ptr %v1838.p
  %v1839.p = getelementptr i64, ptr %v1835, i64 2
  %v1839 = load i64, ptr %v1839.p
  call void @"main.showSplit"(i64 %v1829, i64 %v1830, i64 %v1831, i64 %v1837, i64 %v1838, i64 %v1839)
  %v1840 = getelementptr i64, ptr @"str.20", i64 0
  %v1841 = add i64 0, 9
  %v1842 = add i64 0, 0
  %v1843 = getelementptr i64, ptr %s1, i64 0
  %v1844 = ptrtoint ptr %v1840 to i64
  %st606 = getelementptr i64, ptr %v1843, i64 0
  store i64 %v1844, ptr %st606
  %st607 = getelementptr i64, ptr %v1843, i64 1
  store i64 %v1841, ptr %st607
  %st608 = getelementptr i64, ptr %v1843, i64 2
  store i64 %v1842, ptr %st608
  %v1845.p = getelementptr i64, ptr %v1843, i64 0
  %v1845 = load i64, ptr %v1845.p
  %v1846.p = getelementptr i64, ptr %v1843, i64 1
  %v1846 = load i64, ptr %v1846.p
  %v1847.p = getelementptr i64, ptr %v1843, i64 2
  %v1847 = load i64, ptr %v1847.p
  %v1848 = getelementptr i64, ptr @"str.4", i64 0
  %v1849 = add i64 0, 0
  %v1850 = add i64 0, 0
  %v1851 = getelementptr i64, ptr %s0, i64 0
  %v1852 = ptrtoint ptr %v1848 to i64
  %st609 = getelementptr i64, ptr %v1851, i64 0
  store i64 %v1852, ptr %st609
  %st610 = getelementptr i64, ptr %v1851, i64 1
  store i64 %v1849, ptr %st610
  %st611 = getelementptr i64, ptr %v1851, i64 2
  store i64 %v1850, ptr %st611
  %v1853.p = getelementptr i64, ptr %v1851, i64 0
  %v1853 = load i64, ptr %v1853.p
  %v1854.p = getelementptr i64, ptr %v1851, i64 1
  %v1854 = load i64, ptr %v1854.p
  %v1855.p = getelementptr i64, ptr %v1851, i64 2
  %v1855 = load i64, ptr %v1855.p
  call void @"main.showSplit"(i64 %v1845, i64 %v1846, i64 %v1847, i64 %v1853, i64 %v1854, i64 %v1855)
  %v1856 = getelementptr i64, ptr @"str.70", i64 0
  %v1857 = add i64 0, 6
  %v1858 = add i64 0, 0
  %v1859 = getelementptr i64, ptr %s0, i64 0
  %v1860 = ptrtoint ptr %v1856 to i64
  %st612 = getelementptr i64, ptr %v1859, i64 0
  store i64 %v1860, ptr %st612
  %st613 = getelementptr i64, ptr %v1859, i64 1
  store i64 %v1857, ptr %st613
  %st614 = getelementptr i64, ptr %v1859, i64 2
  store i64 %v1858, ptr %st614
  %v1861.p = getelementptr i64, ptr %v1859, i64 0
  %v1861 = load i64, ptr %v1861.p
  %v1862.p = getelementptr i64, ptr %v1859, i64 1
  %v1862 = load i64, ptr %v1862.p
  %v1863.p = getelementptr i64, ptr %v1859, i64 2
  %v1863 = load i64, ptr %v1863.p
  %v1864 = getelementptr i64, ptr @"str.67", i64 0
  %v1865 = add i64 0, 1
  %v1866 = add i64 0, 0
  %v1867 = getelementptr i64, ptr %s1, i64 0
  %v1868 = ptrtoint ptr %v1864 to i64
  %st615 = getelementptr i64, ptr %v1867, i64 0
  store i64 %v1868, ptr %st615
  %st616 = getelementptr i64, ptr %v1867, i64 1
  store i64 %v1865, ptr %st616
  %st617 = getelementptr i64, ptr %v1867, i64 2
  store i64 %v1866, ptr %st617
  %v1869.p = getelementptr i64, ptr %v1867, i64 0
  %v1869 = load i64, ptr %v1869.p
  %v1870.p = getelementptr i64, ptr %v1867, i64 1
  %v1870 = load i64, ptr %v1870.p
  %v1871.p = getelementptr i64, ptr %v1867, i64 2
  %v1871 = load i64, ptr %v1871.p
  call void @"main.showSplit"(i64 %v1861, i64 %v1862, i64 %v1863, i64 %v1869, i64 %v1870, i64 %v1871)
  %v1872 = getelementptr i64, ptr @"str.38", i64 0
  %v1873 = add i64 0, 3
  %v1874 = add i64 0, 0
  %v1875 = getelementptr i64, ptr %s1, i64 0
  %v1876 = ptrtoint ptr %v1872 to i64
  %st618 = getelementptr i64, ptr %v1875, i64 0
  store i64 %v1876, ptr %st618
  %st619 = getelementptr i64, ptr %v1875, i64 1
  store i64 %v1873, ptr %st619
  %st620 = getelementptr i64, ptr %v1875, i64 2
  store i64 %v1874, ptr %st620
  %v1877.p = getelementptr i64, ptr %v1875, i64 0
  %v1877 = load i64, ptr %v1877.p
  %v1878.p = getelementptr i64, ptr %v1875, i64 1
  %v1878 = load i64, ptr %v1878.p
  %v1879.p = getelementptr i64, ptr %v1875, i64 2
  %v1879 = load i64, ptr %v1879.p
  %v1880 = getelementptr i64, ptr @"str.5", i64 0
  %v1881 = add i64 0, 1
  %v1882 = add i64 0, 0
  %v1883 = getelementptr i64, ptr %s0, i64 0
  %v1884 = ptrtoint ptr %v1880 to i64
  %st621 = getelementptr i64, ptr %v1883, i64 0
  store i64 %v1884, ptr %st621
  %st622 = getelementptr i64, ptr %v1883, i64 1
  store i64 %v1881, ptr %st622
  %st623 = getelementptr i64, ptr %v1883, i64 2
  store i64 %v1882, ptr %st623
  %v1885.p = getelementptr i64, ptr %v1883, i64 0
  %v1885 = load i64, ptr %v1885.p
  %v1886.p = getelementptr i64, ptr %v1883, i64 1
  %v1886 = load i64, ptr %v1886.p
  %v1887.p = getelementptr i64, ptr %v1883, i64 2
  %v1887 = load i64, ptr %v1887.p
  call void @"main.showSplit"(i64 %v1877, i64 %v1878, i64 %v1879, i64 %v1885, i64 %v1886, i64 %v1887)
  %v1888 = getelementptr i64, ptr @"str.30", i64 0
  %v1889 = add i64 0, 4
  %v1890 = add i64 0, 0
  %v1891 = getelementptr i64, ptr %s0, i64 0
  %v1892 = ptrtoint ptr %v1888 to i64
  %st624 = getelementptr i64, ptr %v1891, i64 0
  store i64 %v1892, ptr %st624
  %st625 = getelementptr i64, ptr %v1891, i64 1
  store i64 %v1889, ptr %st625
  %st626 = getelementptr i64, ptr %v1891, i64 2
  store i64 %v1890, ptr %st626
  %v1893.p = getelementptr i64, ptr %v1891, i64 0
  %v1893 = load i64, ptr %v1893.p
  %v1894.p = getelementptr i64, ptr %v1891, i64 1
  %v1894 = load i64, ptr %v1894.p
  %v1895.p = getelementptr i64, ptr %v1891, i64 2
  %v1895 = load i64, ptr %v1895.p
  %v1896 = getelementptr i64, ptr @"str.31", i64 0
  %v1897 = add i64 0, 2
  %v1898 = add i64 0, 0
  %v1899 = getelementptr i64, ptr %s1, i64 0
  %v1900 = ptrtoint ptr %v1896 to i64
  %st627 = getelementptr i64, ptr %v1899, i64 0
  store i64 %v1900, ptr %st627
  %st628 = getelementptr i64, ptr %v1899, i64 1
  store i64 %v1897, ptr %st628
  %st629 = getelementptr i64, ptr %v1899, i64 2
  store i64 %v1898, ptr %st629
  %v1901.p = getelementptr i64, ptr %v1899, i64 0
  %v1901 = load i64, ptr %v1901.p
  %v1902.p = getelementptr i64, ptr %v1899, i64 1
  %v1902 = load i64, ptr %v1902.p
  %v1903.p = getelementptr i64, ptr %v1899, i64 2
  %v1903 = load i64, ptr %v1903.p
  call void @"main.showSplit"(i64 %v1893, i64 %v1894, i64 %v1895, i64 %v1901, i64 %v1902, i64 %v1903)
  %v1904 = getelementptr i64, ptr @"str.71", i64 0
  %v1905 = add i64 0, 8
  %v1906 = add i64 0, 0
  %v1907 = getelementptr i64, ptr %s1, i64 0
  %v1908 = ptrtoint ptr %v1904 to i64
  %st630 = getelementptr i64, ptr %v1907, i64 0
  store i64 %v1908, ptr %st630
  %st631 = getelementptr i64, ptr %v1907, i64 1
  store i64 %v1905, ptr %st631
  %st632 = getelementptr i64, ptr %v1907, i64 2
  store i64 %v1906, ptr %st632
  %v1909.p = getelementptr i64, ptr %v1907, i64 0
  %v1909 = load i64, ptr %v1909.p
  %v1910.p = getelementptr i64, ptr %v1907, i64 1
  %v1910 = load i64, ptr %v1910.p
  %v1911.p = getelementptr i64, ptr %v1907, i64 2
  %v1911 = load i64, ptr %v1911.p
  %v1912 = getelementptr i64, ptr @"str.4", i64 0
  %v1913 = add i64 0, 0
  %v1914 = add i64 0, 0
  %v1915 = getelementptr i64, ptr %s0, i64 0
  %v1916 = ptrtoint ptr %v1912 to i64
  %st633 = getelementptr i64, ptr %v1915, i64 0
  store i64 %v1916, ptr %st633
  %st634 = getelementptr i64, ptr %v1915, i64 1
  store i64 %v1913, ptr %st634
  %st635 = getelementptr i64, ptr %v1915, i64 2
  store i64 %v1914, ptr %st635
  %v1917.p = getelementptr i64, ptr %v1915, i64 0
  %v1917 = load i64, ptr %v1917.p
  %v1918.p = getelementptr i64, ptr %v1915, i64 1
  %v1918 = load i64, ptr %v1918.p
  %v1919.p = getelementptr i64, ptr %v1915, i64 2
  %v1919 = load i64, ptr %v1919.p
  call void @"main.showSplit"(i64 %v1909, i64 %v1910, i64 %v1911, i64 %v1917, i64 %v1918, i64 %v1919)
  %v1920 = getelementptr i64, ptr @"str.72", i64 0
  %v1921 = add i64 0, 17
  %v1922 = add i64 0, 0
  %v1923 = getelementptr i64, ptr %s0, i64 0
  %v1924 = ptrtoint ptr %v1920 to i64
  %st636 = getelementptr i64, ptr %v1923, i64 0
  store i64 %v1924, ptr %st636
  %st637 = getelementptr i64, ptr %v1923, i64 1
  store i64 %v1921, ptr %st637
  %st638 = getelementptr i64, ptr %v1923, i64 2
  store i64 %v1922, ptr %st638
  %v1925.p = getelementptr i64, ptr %v1923, i64 0
  %v1925 = load i64, ptr %v1925.p
  %v1926.p = getelementptr i64, ptr %v1923, i64 1
  %v1926 = load i64, ptr %v1926.p
  %v1927.p = getelementptr i64, ptr %v1923, i64 2
  %v1927 = load i64, ptr %v1927.p
  call void @"main.showFields"(i64 %v1925, i64 %v1926, i64 %v1927)
  %v1928 = getelementptr i64, ptr @"str.4", i64 0
  %v1929 = add i64 0, 0
  %v1930 = add i64 0, 0
  %v1931 = getelementptr i64, ptr %s0, i64 0
  %v1932 = ptrtoint ptr %v1928 to i64
  %st639 = getelementptr i64, ptr %v1931, i64 0
  store i64 %v1932, ptr %st639
  %st640 = getelementptr i64, ptr %v1931, i64 1
  store i64 %v1929, ptr %st640
  %st641 = getelementptr i64, ptr %v1931, i64 2
  store i64 %v1930, ptr %st641
  %v1933.p = getelementptr i64, ptr %v1931, i64 0
  %v1933 = load i64, ptr %v1933.p
  %v1934.p = getelementptr i64, ptr %v1931, i64 1
  %v1934 = load i64, ptr %v1934.p
  %v1935.p = getelementptr i64, ptr %v1931, i64 2
  %v1935 = load i64, ptr %v1935.p
  call void @"main.showFields"(i64 %v1933, i64 %v1934, i64 %v1935)
  %v1936 = getelementptr i64, ptr @"str.73", i64 0
  %v1937 = add i64 0, 5
  %v1938 = add i64 0, 0
  %v1939 = getelementptr i64, ptr %s0, i64 0
  %v1940 = ptrtoint ptr %v1936 to i64
  %st642 = getelementptr i64, ptr %v1939, i64 0
  store i64 %v1940, ptr %st642
  %st643 = getelementptr i64, ptr %v1939, i64 1
  store i64 %v1937, ptr %st643
  %st644 = getelementptr i64, ptr %v1939, i64 2
  store i64 %v1938, ptr %st644
  %v1941.p = getelementptr i64, ptr %v1939, i64 0
  %v1941 = load i64, ptr %v1941.p
  %v1942.p = getelementptr i64, ptr %v1939, i64 1
  %v1942 = load i64, ptr %v1942.p
  %v1943.p = getelementptr i64, ptr %v1939, i64 2
  %v1943 = load i64, ptr %v1943.p
  call void @"main.showFields"(i64 %v1941, i64 %v1942, i64 %v1943)
  %v1944 = getelementptr i64, ptr @"str.5", i64 0
  %v1945 = add i64 0, 1
  %v1946 = add i64 0, 0
  %v1947 = getelementptr i64, ptr %s0, i64 0
  %v1948 = ptrtoint ptr %v1944 to i64
  %st645 = getelementptr i64, ptr %v1947, i64 0
  store i64 %v1948, ptr %st645
  %st646 = getelementptr i64, ptr %v1947, i64 1
  store i64 %v1945, ptr %st646
  %st647 = getelementptr i64, ptr %v1947, i64 2
  store i64 %v1946, ptr %st647
  %v1949.p = getelementptr i64, ptr %v1947, i64 0
  %v1949 = load i64, ptr %v1949.p
  %v1950.p = getelementptr i64, ptr %v1947, i64 1
  %v1950 = load i64, ptr %v1950.p
  %v1951.p = getelementptr i64, ptr %v1947, i64 2
  %v1951 = load i64, ptr %v1951.p
  call void @"main.showFields"(i64 %v1949, i64 %v1950, i64 %v1951)
  %v1952 = getelementptr i64, ptr @"str.74", i64 0
  %v1953 = add i64 0, 6
  %v1954 = add i64 0, 0
  %v1955 = getelementptr i64, ptr %s0, i64 0
  %v1956 = ptrtoint ptr %v1952 to i64
  %st648 = getelementptr i64, ptr %v1955, i64 0
  store i64 %v1956, ptr %st648
  %st649 = getelementptr i64, ptr %v1955, i64 1
  store i64 %v1953, ptr %st649
  %st650 = getelementptr i64, ptr %v1955, i64 2
  store i64 %v1954, ptr %st650
  %v1957.p = getelementptr i64, ptr %v1955, i64 0
  %v1957 = load i64, ptr %v1957.p
  %v1958.p = getelementptr i64, ptr %v1955, i64 1
  %v1958 = load i64, ptr %v1958.p
  %v1959.p = getelementptr i64, ptr %v1955, i64 2
  %v1959 = load i64, ptr %v1959.p
  call void @"main.showFields"(i64 %v1957, i64 %v1958, i64 %v1959)
  %v1960 = getelementptr i64, ptr @"str.75", i64 0
  %v1961 = add i64 0, 11
  %v1962 = add i64 0, 0
  %v1963 = getelementptr i64, ptr %s0, i64 0
  %v1964 = ptrtoint ptr %v1960 to i64
  %st651 = getelementptr i64, ptr %v1963, i64 0
  store i64 %v1964, ptr %st651
  %st652 = getelementptr i64, ptr %v1963, i64 1
  store i64 %v1961, ptr %st652
  %st653 = getelementptr i64, ptr %v1963, i64 2
  store i64 %v1962, ptr %st653
  %v1965.p = getelementptr i64, ptr %v1963, i64 0
  %v1965 = load i64, ptr %v1965.p
  %v1966.p = getelementptr i64, ptr %v1963, i64 1
  %v1966 = load i64, ptr %v1966.p
  %v1967.p = getelementptr i64, ptr %v1963, i64 2
  %v1967 = load i64, ptr %v1967.p
  call void @"main.showFields"(i64 %v1965, i64 %v1966, i64 %v1967)
  %v1968 = getelementptr i64, ptr @"str.76", i64 0
  %v1969 = add i64 0, 3
  %v1970 = add i64 0, 0
  %v1971 = getelementptr i64, ptr %s0, i64 0
  %v1972 = ptrtoint ptr %v1968 to i64
  %st654 = getelementptr i64, ptr %v1971, i64 0
  store i64 %v1972, ptr %st654
  %st655 = getelementptr i64, ptr %v1971, i64 1
  store i64 %v1969, ptr %st655
  %st656 = getelementptr i64, ptr %v1971, i64 2
  store i64 %v1970, ptr %st656
  %v1973.p = getelementptr i64, ptr %v1971, i64 0
  %v1973 = load i64, ptr %v1973.p
  %v1974.p = getelementptr i64, ptr %v1971, i64 1
  %v1974 = load i64, ptr %v1974.p
  %v1975.p = getelementptr i64, ptr %v1971, i64 2
  %v1975 = load i64, ptr %v1975.p
  call void @"main.showFields"(i64 %v1973, i64 %v1974, i64 %v1975)
  %v1976 = getelementptr i64, ptr %s16, i64 0
  %v1977 = getelementptr i64, ptr @"str.77", i64 0
  %v1978 = add i64 0, 23
  %v1979 = add i64 0, 0
  %v1980 = getelementptr i64, ptr %s0, i64 0
  %v1981 = ptrtoint ptr %v1977 to i64
  %st657 = getelementptr i64, ptr %v1980, i64 0
  store i64 %v1981, ptr %st657
  %st658 = getelementptr i64, ptr %v1980, i64 1
  store i64 %v1978, ptr %st658
  %st659 = getelementptr i64, ptr %v1980, i64 2
  store i64 %v1979, ptr %st659
  %v1982.p = getelementptr i64, ptr %v1980, i64 0
  %v1982 = load i64, ptr %v1982.p
  %v1983.p = getelementptr i64, ptr %v1980, i64 1
  %v1983 = load i64, ptr %v1983.p
  %v1984.p = getelementptr i64, ptr %v1980, i64 2
  %v1984 = load i64, ptr %v1984.p
  call void @"std/strings.TrimSpace"(ptr %v1976, i64 %v1982, i64 %v1983, i64 %v1984)
  call void @"rt.print_str"(ptr %v1976)
  %v1985 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1985)
  %v1986 = getelementptr i64, ptr %s17, i64 0
  %v1987 = getelementptr i64, ptr @"str.4", i64 0
  %v1988 = add i64 0, 0
  %v1989 = add i64 0, 0
  %v1990 = getelementptr i64, ptr %s0, i64 0
  %v1991 = ptrtoint ptr %v1987 to i64
  %st660 = getelementptr i64, ptr %v1990, i64 0
  store i64 %v1991, ptr %st660
  %st661 = getelementptr i64, ptr %v1990, i64 1
  store i64 %v1988, ptr %st661
  %st662 = getelementptr i64, ptr %v1990, i64 2
  store i64 %v1989, ptr %st662
  %v1992.p = getelementptr i64, ptr %v1990, i64 0
  %v1992 = load i64, ptr %v1992.p
  %v1993.p = getelementptr i64, ptr %v1990, i64 1
  %v1993 = load i64, ptr %v1993.p
  %v1994.p = getelementptr i64, ptr %v1990, i64 2
  %v1994 = load i64, ptr %v1994.p
  call void @"std/strings.TrimSpace"(ptr %v1986, i64 %v1992, i64 %v1993, i64 %v1994)
  call void @"rt.print_str"(ptr %v1986)
  %v1995 = add i64 0, 10
  call void @"rt.print_char"(i64 %v1995)
  %v1996 = getelementptr i64, ptr %s18, i64 0
  %v1997 = getelementptr i64, ptr @"str.78", i64 0
  %v1998 = add i64 0, 3
  %v1999 = add i64 0, 0
  %v2000 = getelementptr i64, ptr %s0, i64 0
  %v2001 = ptrtoint ptr %v1997 to i64
  %st663 = getelementptr i64, ptr %v2000, i64 0
  store i64 %v2001, ptr %st663
  %st664 = getelementptr i64, ptr %v2000, i64 1
  store i64 %v1998, ptr %st664
  %st665 = getelementptr i64, ptr %v2000, i64 2
  store i64 %v1999, ptr %st665
  %v2002.p = getelementptr i64, ptr %v2000, i64 0
  %v2002 = load i64, ptr %v2002.p
  %v2003.p = getelementptr i64, ptr %v2000, i64 1
  %v2003 = load i64, ptr %v2003.p
  %v2004.p = getelementptr i64, ptr %v2000, i64 2
  %v2004 = load i64, ptr %v2004.p
  call void @"std/strings.TrimSpace"(ptr %v1996, i64 %v2002, i64 %v2003, i64 %v2004)
  call void @"rt.print_str"(ptr %v1996)
  %v2005 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2005)
  %v2006 = getelementptr i64, ptr %s19, i64 0
  %v2007 = getelementptr i64, ptr @"str.79", i64 0
  %v2008 = add i64 0, 3
  %v2009 = add i64 0, 0
  %v2010 = getelementptr i64, ptr %s0, i64 0
  %v2011 = ptrtoint ptr %v2007 to i64
  %st666 = getelementptr i64, ptr %v2010, i64 0
  store i64 %v2011, ptr %st666
  %st667 = getelementptr i64, ptr %v2010, i64 1
  store i64 %v2008, ptr %st667
  %st668 = getelementptr i64, ptr %v2010, i64 2
  store i64 %v2009, ptr %st668
  %v2012.p = getelementptr i64, ptr %v2010, i64 0
  %v2012 = load i64, ptr %v2012.p
  %v2013.p = getelementptr i64, ptr %v2010, i64 1
  %v2013 = load i64, ptr %v2013.p
  %v2014.p = getelementptr i64, ptr %v2010, i64 2
  %v2014 = load i64, ptr %v2014.p
  call void @"std/strings.TrimSpace"(ptr %v2006, i64 %v2012, i64 %v2013, i64 %v2014)
  call void @"rt.print_str"(ptr %v2006)
  %v2015 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2015)
  %v2016 = getelementptr i64, ptr %s20, i64 0
  %v2017 = getelementptr i64, ptr @"str.80", i64 0
  %v2018 = add i64 0, 4
  %v2019 = add i64 0, 0
  %v2020 = getelementptr i64, ptr %s0, i64 0
  %v2021 = ptrtoint ptr %v2017 to i64
  %st669 = getelementptr i64, ptr %v2020, i64 0
  store i64 %v2021, ptr %st669
  %st670 = getelementptr i64, ptr %v2020, i64 1
  store i64 %v2018, ptr %st670
  %st671 = getelementptr i64, ptr %v2020, i64 2
  store i64 %v2019, ptr %st671
  %v2022.p = getelementptr i64, ptr %v2020, i64 0
  %v2022 = load i64, ptr %v2022.p
  %v2023.p = getelementptr i64, ptr %v2020, i64 1
  %v2023 = load i64, ptr %v2023.p
  %v2024.p = getelementptr i64, ptr %v2020, i64 2
  %v2024 = load i64, ptr %v2024.p
  call void @"std/strings.TrimSpace"(ptr %v2016, i64 %v2022, i64 %v2023, i64 %v2024)
  call void @"rt.print_str"(ptr %v2016)
  %v2025 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2025)
  %v2026 = getelementptr i64, ptr %s21, i64 0
  %v2027 = getelementptr i64, ptr @"str.81", i64 0
  %v2028 = add i64 0, 5
  %v2029 = add i64 0, 0
  %v2030 = getelementptr i64, ptr %s0, i64 0
  %v2031 = ptrtoint ptr %v2027 to i64
  %st672 = getelementptr i64, ptr %v2030, i64 0
  store i64 %v2031, ptr %st672
  %st673 = getelementptr i64, ptr %v2030, i64 1
  store i64 %v2028, ptr %st673
  %st674 = getelementptr i64, ptr %v2030, i64 2
  store i64 %v2029, ptr %st674
  %v2032.p = getelementptr i64, ptr %v2030, i64 0
  %v2032 = load i64, ptr %v2032.p
  %v2033.p = getelementptr i64, ptr %v2030, i64 1
  %v2033 = load i64, ptr %v2033.p
  %v2034.p = getelementptr i64, ptr %v2030, i64 2
  %v2034 = load i64, ptr %v2034.p
  call void @"std/strings.TrimSpace"(ptr %v2026, i64 %v2032, i64 %v2033, i64 %v2034)
  call void @"rt.print_str"(ptr %v2026)
  %v2035 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2035)
  %v2036 = getelementptr i64, ptr %s22, i64 0
  %v2037 = getelementptr i64, ptr @"str.82", i64 0
  %v2038 = add i64 0, 14
  %v2039 = add i64 0, 0
  %v2040 = getelementptr i64, ptr %s0, i64 0
  %v2041 = ptrtoint ptr %v2037 to i64
  %st675 = getelementptr i64, ptr %v2040, i64 0
  store i64 %v2041, ptr %st675
  %st676 = getelementptr i64, ptr %v2040, i64 1
  store i64 %v2038, ptr %st676
  %st677 = getelementptr i64, ptr %v2040, i64 2
  store i64 %v2039, ptr %st677
  %v2042.p = getelementptr i64, ptr %v2040, i64 0
  %v2042 = load i64, ptr %v2042.p
  %v2043.p = getelementptr i64, ptr %v2040, i64 1
  %v2043 = load i64, ptr %v2043.p
  %v2044.p = getelementptr i64, ptr %v2040, i64 2
  %v2044 = load i64, ptr %v2044.p
  %v2045 = getelementptr i64, ptr @"str.83", i64 0
  %v2046 = add i64 0, 1
  %v2047 = add i64 0, 0
  %v2048 = getelementptr i64, ptr %s1, i64 0
  %v2049 = ptrtoint ptr %v2045 to i64
  %st678 = getelementptr i64, ptr %v2048, i64 0
  store i64 %v2049, ptr %st678
  %st679 = getelementptr i64, ptr %v2048, i64 1
  store i64 %v2046, ptr %st679
  %st680 = getelementptr i64, ptr %v2048, i64 2
  store i64 %v2047, ptr %st680
  %v2050.p = getelementptr i64, ptr %v2048, i64 0
  %v2050 = load i64, ptr %v2050.p
  %v2051.p = getelementptr i64, ptr %v2048, i64 1
  %v2051 = load i64, ptr %v2051.p
  %v2052.p = getelementptr i64, ptr %v2048, i64 2
  %v2052 = load i64, ptr %v2052.p
  %v2053 = getelementptr i64, ptr @"str.84", i64 0
  %v2054 = add i64 0, 2
  %v2055 = add i64 0, 0
  %v2056 = getelementptr i64, ptr %s23, i64 0
  %v2057 = ptrtoint ptr %v2053 to i64
  %st681 = getelementptr i64, ptr %v2056, i64 0
  store i64 %v2057, ptr %st681
  %st682 = getelementptr i64, ptr %v2056, i64 1
  store i64 %v2054, ptr %st682
  %st683 = getelementptr i64, ptr %v2056, i64 2
  store i64 %v2055, ptr %st683
  %v2058.p = getelementptr i64, ptr %v2056, i64 0
  %v2058 = load i64, ptr %v2058.p
  %v2059.p = getelementptr i64, ptr %v2056, i64 1
  %v2059 = load i64, ptr %v2059.p
  %v2060.p = getelementptr i64, ptr %v2056, i64 2
  %v2060 = load i64, ptr %v2060.p
  %v2061 = add i64 0, 2
  call void @"std/strings.Replace"(ptr %v2036, i64 %v2042, i64 %v2043, i64 %v2044, i64 %v2050, i64 %v2051, i64 %v2052, i64 %v2058, i64 %v2059, i64 %v2060, i64 %v2061)
  call void @"rt.print_str"(ptr %v2036)
  %v2062 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2062)
  %v2063 = getelementptr i64, ptr %s24, i64 0
  %v2064 = getelementptr i64, ptr @"str.82", i64 0
  %v2065 = add i64 0, 14
  %v2066 = add i64 0, 0
  %v2067 = getelementptr i64, ptr %s23, i64 0
  %v2068 = ptrtoint ptr %v2064 to i64
  %st684 = getelementptr i64, ptr %v2067, i64 0
  store i64 %v2068, ptr %st684
  %st685 = getelementptr i64, ptr %v2067, i64 1
  store i64 %v2065, ptr %st685
  %st686 = getelementptr i64, ptr %v2067, i64 2
  store i64 %v2066, ptr %st686
  %v2069.p = getelementptr i64, ptr %v2067, i64 0
  %v2069 = load i64, ptr %v2069.p
  %v2070.p = getelementptr i64, ptr %v2067, i64 1
  %v2070 = load i64, ptr %v2070.p
  %v2071.p = getelementptr i64, ptr %v2067, i64 2
  %v2071 = load i64, ptr %v2071.p
  %v2072 = getelementptr i64, ptr @"str.85", i64 0
  %v2073 = add i64 0, 4
  %v2074 = add i64 0, 0
  %v2075 = getelementptr i64, ptr %s1, i64 0
  %v2076 = ptrtoint ptr %v2072 to i64
  %st687 = getelementptr i64, ptr %v2075, i64 0
  store i64 %v2076, ptr %st687
  %st688 = getelementptr i64, ptr %v2075, i64 1
  store i64 %v2073, ptr %st688
  %st689 = getelementptr i64, ptr %v2075, i64 2
  store i64 %v2074, ptr %st689
  %v2077.p = getelementptr i64, ptr %v2075, i64 0
  %v2077 = load i64, ptr %v2077.p
  %v2078.p = getelementptr i64, ptr %v2075, i64 1
  %v2078 = load i64, ptr %v2078.p
  %v2079.p = getelementptr i64, ptr %v2075, i64 2
  %v2079 = load i64, ptr %v2079.p
  %v2080 = getelementptr i64, ptr @"str.86", i64 0
  %v2081 = add i64 0, 3
  %v2082 = add i64 0, 0
  %v2083 = getelementptr i64, ptr %s0, i64 0
  %v2084 = ptrtoint ptr %v2080 to i64
  %st690 = getelementptr i64, ptr %v2083, i64 0
  store i64 %v2084, ptr %st690
  %st691 = getelementptr i64, ptr %v2083, i64 1
  store i64 %v2081, ptr %st691
  %st692 = getelementptr i64, ptr %v2083, i64 2
  store i64 %v2082, ptr %st692
  %v2085.p = getelementptr i64, ptr %v2083, i64 0
  %v2085 = load i64, ptr %v2085.p
  %v2086.p = getelementptr i64, ptr %v2083, i64 1
  %v2086 = load i64, ptr %v2086.p
  %v2087.p = getelementptr i64, ptr %v2083, i64 2
  %v2087 = load i64, ptr %v2087.p
  %v2088 = add i64 0, 1
  %v2089 = add i64 0, 0
  %v2090 = sub i64 %v2089, %v2088
  call void @"std/strings.Replace"(ptr %v2063, i64 %v2069, i64 %v2070, i64 %v2071, i64 %v2077, i64 %v2078, i64 %v2079, i64 %v2085, i64 %v2086, i64 %v2087, i64 %v2090)
  call void @"rt.print_str"(ptr %v2063)
  %v2091 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2091)
  %v2092 = getelementptr i64, ptr %s25, i64 0
  %v2093 = getelementptr i64, ptr @"str.6", i64 0
  %v2094 = add i64 0, 3
  %v2095 = add i64 0, 0
  %v2096 = getelementptr i64, ptr %s0, i64 0
  %v2097 = ptrtoint ptr %v2093 to i64
  %st693 = getelementptr i64, ptr %v2096, i64 0
  store i64 %v2097, ptr %st693
  %st694 = getelementptr i64, ptr %v2096, i64 1
  store i64 %v2094, ptr %st694
  %st695 = getelementptr i64, ptr %v2096, i64 2
  store i64 %v2095, ptr %st695
  %v2098.p = getelementptr i64, ptr %v2096, i64 0
  %v2098 = load i64, ptr %v2098.p
  %v2099.p = getelementptr i64, ptr %v2096, i64 1
  %v2099 = load i64, ptr %v2099.p
  %v2100.p = getelementptr i64, ptr %v2096, i64 2
  %v2100 = load i64, ptr %v2100.p
  %v2101 = getelementptr i64, ptr @"str.4", i64 0
  %v2102 = add i64 0, 0
  %v2103 = add i64 0, 0
  %v2104 = getelementptr i64, ptr %s1, i64 0
  %v2105 = ptrtoint ptr %v2101 to i64
  %st696 = getelementptr i64, ptr %v2104, i64 0
  store i64 %v2105, ptr %st696
  %st697 = getelementptr i64, ptr %v2104, i64 1
  store i64 %v2102, ptr %st697
  %st698 = getelementptr i64, ptr %v2104, i64 2
  store i64 %v2103, ptr %st698
  %v2106.p = getelementptr i64, ptr %v2104, i64 0
  %v2106 = load i64, ptr %v2106.p
  %v2107.p = getelementptr i64, ptr %v2104, i64 1
  %v2107 = load i64, ptr %v2107.p
  %v2108.p = getelementptr i64, ptr %v2104, i64 2
  %v2108 = load i64, ptr %v2108.p
  %v2109 = getelementptr i64, ptr @"str.87", i64 0
  %v2110 = add i64 0, 1
  %v2111 = add i64 0, 0
  %v2112 = getelementptr i64, ptr %s23, i64 0
  %v2113 = ptrtoint ptr %v2109 to i64
  %st699 = getelementptr i64, ptr %v2112, i64 0
  store i64 %v2113, ptr %st699
  %st700 = getelementptr i64, ptr %v2112, i64 1
  store i64 %v2110, ptr %st700
  %st701 = getelementptr i64, ptr %v2112, i64 2
  store i64 %v2111, ptr %st701
  %v2114.p = getelementptr i64, ptr %v2112, i64 0
  %v2114 = load i64, ptr %v2114.p
  %v2115.p = getelementptr i64, ptr %v2112, i64 1
  %v2115 = load i64, ptr %v2115.p
  %v2116.p = getelementptr i64, ptr %v2112, i64 2
  %v2116 = load i64, ptr %v2116.p
  %v2117 = add i64 0, 1
  %v2118 = add i64 0, 0
  %v2119 = sub i64 %v2118, %v2117
  call void @"std/strings.Replace"(ptr %v2092, i64 %v2098, i64 %v2099, i64 %v2100, i64 %v2106, i64 %v2107, i64 %v2108, i64 %v2114, i64 %v2115, i64 %v2116, i64 %v2119)
  call void @"rt.print_str"(ptr %v2092)
  %v2120 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2120)
  %v2121 = getelementptr i64, ptr %s26, i64 0
  %v2122 = getelementptr i64, ptr @"str.6", i64 0
  %v2123 = add i64 0, 3
  %v2124 = add i64 0, 0
  %v2125 = getelementptr i64, ptr %s23, i64 0
  %v2126 = ptrtoint ptr %v2122 to i64
  %st702 = getelementptr i64, ptr %v2125, i64 0
  store i64 %v2126, ptr %st702
  %st703 = getelementptr i64, ptr %v2125, i64 1
  store i64 %v2123, ptr %st703
  %st704 = getelementptr i64, ptr %v2125, i64 2
  store i64 %v2124, ptr %st704
  %v2127.p = getelementptr i64, ptr %v2125, i64 0
  %v2127 = load i64, ptr %v2127.p
  %v2128.p = getelementptr i64, ptr %v2125, i64 1
  %v2128 = load i64, ptr %v2128.p
  %v2129.p = getelementptr i64, ptr %v2125, i64 2
  %v2129 = load i64, ptr %v2129.p
  %v2130 = getelementptr i64, ptr @"str.4", i64 0
  %v2131 = add i64 0, 0
  %v2132 = add i64 0, 0
  %v2133 = getelementptr i64, ptr %s1, i64 0
  %v2134 = ptrtoint ptr %v2130 to i64
  %st705 = getelementptr i64, ptr %v2133, i64 0
  store i64 %v2134, ptr %st705
  %st706 = getelementptr i64, ptr %v2133, i64 1
  store i64 %v2131, ptr %st706
  %st707 = getelementptr i64, ptr %v2133, i64 2
  store i64 %v2132, ptr %st707
  %v2135.p = getelementptr i64, ptr %v2133, i64 0
  %v2135 = load i64, ptr %v2135.p
  %v2136.p = getelementptr i64, ptr %v2133, i64 1
  %v2136 = load i64, ptr %v2136.p
  %v2137.p = getelementptr i64, ptr %v2133, i64 2
  %v2137 = load i64, ptr %v2137.p
  %v2138 = getelementptr i64, ptr @"str.87", i64 0
  %v2139 = add i64 0, 1
  %v2140 = add i64 0, 0
  %v2141 = getelementptr i64, ptr %s0, i64 0
  %v2142 = ptrtoint ptr %v2138 to i64
  %st708 = getelementptr i64, ptr %v2141, i64 0
  store i64 %v2142, ptr %st708
  %st709 = getelementptr i64, ptr %v2141, i64 1
  store i64 %v2139, ptr %st709
  %st710 = getelementptr i64, ptr %v2141, i64 2
  store i64 %v2140, ptr %st710
  %v2143.p = getelementptr i64, ptr %v2141, i64 0
  %v2143 = load i64, ptr %v2143.p
  %v2144.p = getelementptr i64, ptr %v2141, i64 1
  %v2144 = load i64, ptr %v2144.p
  %v2145.p = getelementptr i64, ptr %v2141, i64 2
  %v2145 = load i64, ptr %v2145.p
  %v2146 = add i64 0, 2
  call void @"std/strings.Replace"(ptr %v2121, i64 %v2127, i64 %v2128, i64 %v2129, i64 %v2135, i64 %v2136, i64 %v2137, i64 %v2143, i64 %v2144, i64 %v2145, i64 %v2146)
  call void @"rt.print_str"(ptr %v2121)
  %v2147 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2147)
  %v2148 = getelementptr i64, ptr %s27, i64 0
  %v2149 = getelementptr i64, ptr @"str.4", i64 0
  %v2150 = add i64 0, 0
  %v2151 = add i64 0, 0
  %v2152 = getelementptr i64, ptr %s0, i64 0
  %v2153 = ptrtoint ptr %v2149 to i64
  %st711 = getelementptr i64, ptr %v2152, i64 0
  store i64 %v2153, ptr %st711
  %st712 = getelementptr i64, ptr %v2152, i64 1
  store i64 %v2150, ptr %st712
  %st713 = getelementptr i64, ptr %v2152, i64 2
  store i64 %v2151, ptr %st713
  %v2154.p = getelementptr i64, ptr %v2152, i64 0
  %v2154 = load i64, ptr %v2154.p
  %v2155.p = getelementptr i64, ptr %v2152, i64 1
  %v2155 = load i64, ptr %v2155.p
  %v2156.p = getelementptr i64, ptr %v2152, i64 2
  %v2156 = load i64, ptr %v2156.p
  %v2157 = getelementptr i64, ptr @"str.4", i64 0
  %v2158 = add i64 0, 0
  %v2159 = add i64 0, 0
  %v2160 = getelementptr i64, ptr %s1, i64 0
  %v2161 = ptrtoint ptr %v2157 to i64
  %st714 = getelementptr i64, ptr %v2160, i64 0
  store i64 %v2161, ptr %st714
  %st715 = getelementptr i64, ptr %v2160, i64 1
  store i64 %v2158, ptr %st715
  %st716 = getelementptr i64, ptr %v2160, i64 2
  store i64 %v2159, ptr %st716
  %v2162.p = getelementptr i64, ptr %v2160, i64 0
  %v2162 = load i64, ptr %v2162.p
  %v2163.p = getelementptr i64, ptr %v2160, i64 1
  %v2163 = load i64, ptr %v2163.p
  %v2164.p = getelementptr i64, ptr %v2160, i64 2
  %v2164 = load i64, ptr %v2164.p
  %v2165 = getelementptr i64, ptr @"str.19", i64 0
  %v2166 = add i64 0, 1
  %v2167 = add i64 0, 0
  %v2168 = getelementptr i64, ptr %s23, i64 0
  %v2169 = ptrtoint ptr %v2165 to i64
  %st717 = getelementptr i64, ptr %v2168, i64 0
  store i64 %v2169, ptr %st717
  %st718 = getelementptr i64, ptr %v2168, i64 1
  store i64 %v2166, ptr %st718
  %st719 = getelementptr i64, ptr %v2168, i64 2
  store i64 %v2167, ptr %st719
  %v2170.p = getelementptr i64, ptr %v2168, i64 0
  %v2170 = load i64, ptr %v2170.p
  %v2171.p = getelementptr i64, ptr %v2168, i64 1
  %v2171 = load i64, ptr %v2171.p
  %v2172.p = getelementptr i64, ptr %v2168, i64 2
  %v2172 = load i64, ptr %v2172.p
  %v2173 = add i64 0, 1
  %v2174 = add i64 0, 0
  %v2175 = sub i64 %v2174, %v2173
  call void @"std/strings.Replace"(ptr %v2148, i64 %v2154, i64 %v2155, i64 %v2156, i64 %v2162, i64 %v2163, i64 %v2164, i64 %v2170, i64 %v2171, i64 %v2172, i64 %v2175)
  call void @"rt.print_str"(ptr %v2148)
  %v2176 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2176)
  %v2177 = getelementptr i64, ptr %s28, i64 0
  %v2178 = getelementptr i64, ptr @"str.4", i64 0
  %v2179 = add i64 0, 0
  %v2180 = add i64 0, 0
  %v2181 = getelementptr i64, ptr %s23, i64 0
  %v2182 = ptrtoint ptr %v2178 to i64
  %st720 = getelementptr i64, ptr %v2181, i64 0
  store i64 %v2182, ptr %st720
  %st721 = getelementptr i64, ptr %v2181, i64 1
  store i64 %v2179, ptr %st721
  %st722 = getelementptr i64, ptr %v2181, i64 2
  store i64 %v2180, ptr %st722
  %v2183.p = getelementptr i64, ptr %v2181, i64 0
  %v2183 = load i64, ptr %v2183.p
  %v2184.p = getelementptr i64, ptr %v2181, i64 1
  %v2184 = load i64, ptr %v2184.p
  %v2185.p = getelementptr i64, ptr %v2181, i64 2
  %v2185 = load i64, ptr %v2185.p
  %v2186 = getelementptr i64, ptr @"str.4", i64 0
  %v2187 = add i64 0, 0
  %v2188 = add i64 0, 0
  %v2189 = getelementptr i64, ptr %s1, i64 0
  %v2190 = ptrtoint ptr %v2186 to i64
  %st723 = getelementptr i64, ptr %v2189, i64 0
  store i64 %v2190, ptr %st723
  %st724 = getelementptr i64, ptr %v2189, i64 1
  store i64 %v2187, ptr %st724
  %st725 = getelementptr i64, ptr %v2189, i64 2
  store i64 %v2188, ptr %st725
  %v2191.p = getelementptr i64, ptr %v2189, i64 0
  %v2191 = load i64, ptr %v2191.p
  %v2192.p = getelementptr i64, ptr %v2189, i64 1
  %v2192 = load i64, ptr %v2192.p
  %v2193.p = getelementptr i64, ptr %v2189, i64 2
  %v2193 = load i64, ptr %v2193.p
  %v2194 = getelementptr i64, ptr @"str.19", i64 0
  %v2195 = add i64 0, 1
  %v2196 = add i64 0, 0
  %v2197 = getelementptr i64, ptr %s0, i64 0
  %v2198 = ptrtoint ptr %v2194 to i64
  %st726 = getelementptr i64, ptr %v2197, i64 0
  store i64 %v2198, ptr %st726
  %st727 = getelementptr i64, ptr %v2197, i64 1
  store i64 %v2195, ptr %st727
  %st728 = getelementptr i64, ptr %v2197, i64 2
  store i64 %v2196, ptr %st728
  %v2199.p = getelementptr i64, ptr %v2197, i64 0
  %v2199 = load i64, ptr %v2199.p
  %v2200.p = getelementptr i64, ptr %v2197, i64 1
  %v2200 = load i64, ptr %v2200.p
  %v2201.p = getelementptr i64, ptr %v2197, i64 2
  %v2201 = load i64, ptr %v2201.p
  %v2202 = add i64 0, 0
  call void @"std/strings.Replace"(ptr %v2177, i64 %v2183, i64 %v2184, i64 %v2185, i64 %v2191, i64 %v2192, i64 %v2193, i64 %v2199, i64 %v2200, i64 %v2201, i64 %v2202)
  call void @"rt.print_str"(ptr %v2177)
  %v2203 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2203)
  %v2204 = getelementptr i64, ptr %s29, i64 0
  %v2205 = getelementptr i64, ptr @"str.6", i64 0
  %v2206 = add i64 0, 3
  %v2207 = add i64 0, 0
  %v2208 = getelementptr i64, ptr %s0, i64 0
  %v2209 = ptrtoint ptr %v2205 to i64
  %st729 = getelementptr i64, ptr %v2208, i64 0
  store i64 %v2209, ptr %st729
  %st730 = getelementptr i64, ptr %v2208, i64 1
  store i64 %v2206, ptr %st730
  %st731 = getelementptr i64, ptr %v2208, i64 2
  store i64 %v2207, ptr %st731
  %v2210.p = getelementptr i64, ptr %v2208, i64 0
  %v2210 = load i64, ptr %v2210.p
  %v2211.p = getelementptr i64, ptr %v2208, i64 1
  %v2211 = load i64, ptr %v2211.p
  %v2212.p = getelementptr i64, ptr %v2208, i64 2
  %v2212 = load i64, ptr %v2212.p
  %v2213 = getelementptr i64, ptr @"str.88", i64 0
  %v2214 = add i64 0, 1
  %v2215 = add i64 0, 0
  %v2216 = getelementptr i64, ptr %s1, i64 0
  %v2217 = ptrtoint ptr %v2213 to i64
  %st732 = getelementptr i64, ptr %v2216, i64 0
  store i64 %v2217, ptr %st732
  %st733 = getelementptr i64, ptr %v2216, i64 1
  store i64 %v2214, ptr %st733
  %st734 = getelementptr i64, ptr %v2216, i64 2
  store i64 %v2215, ptr %st734
  %v2218.p = getelementptr i64, ptr %v2216, i64 0
  %v2218 = load i64, ptr %v2218.p
  %v2219.p = getelementptr i64, ptr %v2216, i64 1
  %v2219 = load i64, ptr %v2219.p
  %v2220.p = getelementptr i64, ptr %v2216, i64 2
  %v2220 = load i64, ptr %v2220.p
  %v2221 = getelementptr i64, ptr @"str.4", i64 0
  %v2222 = add i64 0, 0
  %v2223 = add i64 0, 0
  %v2224 = getelementptr i64, ptr %s23, i64 0
  %v2225 = ptrtoint ptr %v2221 to i64
  %st735 = getelementptr i64, ptr %v2224, i64 0
  store i64 %v2225, ptr %st735
  %st736 = getelementptr i64, ptr %v2224, i64 1
  store i64 %v2222, ptr %st736
  %st737 = getelementptr i64, ptr %v2224, i64 2
  store i64 %v2223, ptr %st737
  %v2226.p = getelementptr i64, ptr %v2224, i64 0
  %v2226 = load i64, ptr %v2226.p
  %v2227.p = getelementptr i64, ptr %v2224, i64 1
  %v2227 = load i64, ptr %v2227.p
  %v2228.p = getelementptr i64, ptr %v2224, i64 2
  %v2228 = load i64, ptr %v2228.p
  %v2229 = add i64 0, 1
  %v2230 = add i64 0, 0
  %v2231 = sub i64 %v2230, %v2229
  call void @"std/strings.Replace"(ptr %v2204, i64 %v2210, i64 %v2211, i64 %v2212, i64 %v2218, i64 %v2219, i64 %v2220, i64 %v2226, i64 %v2227, i64 %v2228, i64 %v2231)
  call void @"rt.print_str"(ptr %v2204)
  %v2232 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2232)
  %v2233 = getelementptr i64, ptr %s30, i64 0
  %v2234 = getelementptr i64, ptr @"str.38", i64 0
  %v2235 = add i64 0, 3
  %v2236 = add i64 0, 0
  %v2237 = getelementptr i64, ptr %s23, i64 0
  %v2238 = ptrtoint ptr %v2234 to i64
  %st738 = getelementptr i64, ptr %v2237, i64 0
  store i64 %v2238, ptr %st738
  %st739 = getelementptr i64, ptr %v2237, i64 1
  store i64 %v2235, ptr %st739
  %st740 = getelementptr i64, ptr %v2237, i64 2
  store i64 %v2236, ptr %st740
  %v2239.p = getelementptr i64, ptr %v2237, i64 0
  %v2239 = load i64, ptr %v2239.p
  %v2240.p = getelementptr i64, ptr %v2237, i64 1
  %v2240 = load i64, ptr %v2240.p
  %v2241.p = getelementptr i64, ptr %v2237, i64 2
  %v2241 = load i64, ptr %v2241.p
  %v2242 = getelementptr i64, ptr @"str.5", i64 0
  %v2243 = add i64 0, 1
  %v2244 = add i64 0, 0
  %v2245 = getelementptr i64, ptr %s1, i64 0
  %v2246 = ptrtoint ptr %v2242 to i64
  %st741 = getelementptr i64, ptr %v2245, i64 0
  store i64 %v2246, ptr %st741
  %st742 = getelementptr i64, ptr %v2245, i64 1
  store i64 %v2243, ptr %st742
  %st743 = getelementptr i64, ptr %v2245, i64 2
  store i64 %v2244, ptr %st743
  %v2247.p = getelementptr i64, ptr %v2245, i64 0
  %v2247 = load i64, ptr %v2247.p
  %v2248.p = getelementptr i64, ptr %v2245, i64 1
  %v2248 = load i64, ptr %v2248.p
  %v2249.p = getelementptr i64, ptr %v2245, i64 2
  %v2249 = load i64, ptr %v2249.p
  %v2250 = getelementptr i64, ptr @"str.31", i64 0
  %v2251 = add i64 0, 2
  %v2252 = add i64 0, 0
  %v2253 = getelementptr i64, ptr %s0, i64 0
  %v2254 = ptrtoint ptr %v2250 to i64
  %st744 = getelementptr i64, ptr %v2253, i64 0
  store i64 %v2254, ptr %st744
  %st745 = getelementptr i64, ptr %v2253, i64 1
  store i64 %v2251, ptr %st745
  %st746 = getelementptr i64, ptr %v2253, i64 2
  store i64 %v2252, ptr %st746
  %v2255.p = getelementptr i64, ptr %v2253, i64 0
  %v2255 = load i64, ptr %v2255.p
  %v2256.p = getelementptr i64, ptr %v2253, i64 1
  %v2256 = load i64, ptr %v2256.p
  %v2257.p = getelementptr i64, ptr %v2253, i64 2
  %v2257 = load i64, ptr %v2257.p
  %v2258 = add i64 0, 1
  %v2259 = add i64 0, 0
  %v2260 = sub i64 %v2259, %v2258
  call void @"std/strings.Replace"(ptr %v2233, i64 %v2239, i64 %v2240, i64 %v2241, i64 %v2247, i64 %v2248, i64 %v2249, i64 %v2255, i64 %v2256, i64 %v2257, i64 %v2260)
  call void @"rt.print_str"(ptr %v2233)
  %v2261 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2261)
  %v2262 = getelementptr i64, ptr %s31, i64 0
  %v2263 = getelementptr i64, ptr @"str.30", i64 0
  %v2264 = add i64 0, 4
  %v2265 = add i64 0, 0
  %v2266 = getelementptr i64, ptr %s0, i64 0
  %v2267 = ptrtoint ptr %v2263 to i64
  %st747 = getelementptr i64, ptr %v2266, i64 0
  store i64 %v2267, ptr %st747
  %st748 = getelementptr i64, ptr %v2266, i64 1
  store i64 %v2264, ptr %st748
  %st749 = getelementptr i64, ptr %v2266, i64 2
  store i64 %v2265, ptr %st749
  %v2268.p = getelementptr i64, ptr %v2266, i64 0
  %v2268 = load i64, ptr %v2268.p
  %v2269.p = getelementptr i64, ptr %v2266, i64 1
  %v2269 = load i64, ptr %v2269.p
  %v2270.p = getelementptr i64, ptr %v2266, i64 2
  %v2270 = load i64, ptr %v2270.p
  %v2271 = getelementptr i64, ptr @"str.31", i64 0
  %v2272 = add i64 0, 2
  %v2273 = add i64 0, 0
  %v2274 = getelementptr i64, ptr %s1, i64 0
  %v2275 = ptrtoint ptr %v2271 to i64
  %st750 = getelementptr i64, ptr %v2274, i64 0
  store i64 %v2275, ptr %st750
  %st751 = getelementptr i64, ptr %v2274, i64 1
  store i64 %v2272, ptr %st751
  %st752 = getelementptr i64, ptr %v2274, i64 2
  store i64 %v2273, ptr %st752
  %v2276.p = getelementptr i64, ptr %v2274, i64 0
  %v2276 = load i64, ptr %v2276.p
  %v2277.p = getelementptr i64, ptr %v2274, i64 1
  %v2277 = load i64, ptr %v2277.p
  %v2278.p = getelementptr i64, ptr %v2274, i64 2
  %v2278 = load i64, ptr %v2278.p
  %v2279 = getelementptr i64, ptr @"str.88", i64 0
  %v2280 = add i64 0, 1
  %v2281 = add i64 0, 0
  %v2282 = getelementptr i64, ptr %s23, i64 0
  %v2283 = ptrtoint ptr %v2279 to i64
  %st753 = getelementptr i64, ptr %v2282, i64 0
  store i64 %v2283, ptr %st753
  %st754 = getelementptr i64, ptr %v2282, i64 1
  store i64 %v2280, ptr %st754
  %st755 = getelementptr i64, ptr %v2282, i64 2
  store i64 %v2281, ptr %st755
  %v2284.p = getelementptr i64, ptr %v2282, i64 0
  %v2284 = load i64, ptr %v2284.p
  %v2285.p = getelementptr i64, ptr %v2282, i64 1
  %v2285 = load i64, ptr %v2285.p
  %v2286.p = getelementptr i64, ptr %v2282, i64 2
  %v2286 = load i64, ptr %v2286.p
  %v2287 = add i64 0, 1
  call void @"std/strings.Replace"(ptr %v2262, i64 %v2268, i64 %v2269, i64 %v2270, i64 %v2276, i64 %v2277, i64 %v2278, i64 %v2284, i64 %v2285, i64 %v2286, i64 %v2287)
  call void @"rt.print_str"(ptr %v2262)
  %v2288 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2288)
  %v2289 = getelementptr i64, ptr %s32, i64 0
  %v2290 = getelementptr i64, ptr @"str.6", i64 0
  %v2291 = add i64 0, 3
  %v2292 = add i64 0, 0
  %v2293 = getelementptr i64, ptr %s23, i64 0
  %v2294 = ptrtoint ptr %v2290 to i64
  %st756 = getelementptr i64, ptr %v2293, i64 0
  store i64 %v2294, ptr %st756
  %st757 = getelementptr i64, ptr %v2293, i64 1
  store i64 %v2291, ptr %st757
  %st758 = getelementptr i64, ptr %v2293, i64 2
  store i64 %v2292, ptr %st758
  %v2295.p = getelementptr i64, ptr %v2293, i64 0
  %v2295 = load i64, ptr %v2295.p
  %v2296.p = getelementptr i64, ptr %v2293, i64 1
  %v2296 = load i64, ptr %v2296.p
  %v2297.p = getelementptr i64, ptr %v2293, i64 2
  %v2297 = load i64, ptr %v2297.p
  %v2298 = getelementptr i64, ptr @"str.19", i64 0
  %v2299 = add i64 0, 1
  %v2300 = add i64 0, 0
  %v2301 = getelementptr i64, ptr %s1, i64 0
  %v2302 = ptrtoint ptr %v2298 to i64
  %st759 = getelementptr i64, ptr %v2301, i64 0
  store i64 %v2302, ptr %st759
  %st760 = getelementptr i64, ptr %v2301, i64 1
  store i64 %v2299, ptr %st760
  %st761 = getelementptr i64, ptr %v2301, i64 2
  store i64 %v2300, ptr %st761
  %v2303.p = getelementptr i64, ptr %v2301, i64 0
  %v2303 = load i64, ptr %v2303.p
  %v2304.p = getelementptr i64, ptr %v2301, i64 1
  %v2304 = load i64, ptr %v2304.p
  %v2305.p = getelementptr i64, ptr %v2301, i64 2
  %v2305 = load i64, ptr %v2305.p
  %v2306 = getelementptr i64, ptr @"str.89", i64 0
  %v2307 = add i64 0, 1
  %v2308 = add i64 0, 0
  %v2309 = getelementptr i64, ptr %s0, i64 0
  %v2310 = ptrtoint ptr %v2306 to i64
  %st762 = getelementptr i64, ptr %v2309, i64 0
  store i64 %v2310, ptr %st762
  %st763 = getelementptr i64, ptr %v2309, i64 1
  store i64 %v2307, ptr %st763
  %st764 = getelementptr i64, ptr %v2309, i64 2
  store i64 %v2308, ptr %st764
  %v2311.p = getelementptr i64, ptr %v2309, i64 0
  %v2311 = load i64, ptr %v2311.p
  %v2312.p = getelementptr i64, ptr %v2309, i64 1
  %v2312 = load i64, ptr %v2312.p
  %v2313.p = getelementptr i64, ptr %v2309, i64 2
  %v2313 = load i64, ptr %v2313.p
  %v2314 = add i64 0, 1
  %v2315 = add i64 0, 0
  %v2316 = sub i64 %v2315, %v2314
  call void @"std/strings.Replace"(ptr %v2289, i64 %v2295, i64 %v2296, i64 %v2297, i64 %v2303, i64 %v2304, i64 %v2305, i64 %v2311, i64 %v2312, i64 %v2313, i64 %v2316)
  call void @"rt.print_str"(ptr %v2289)
  %v2317 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2317)
  %v2318 = getelementptr i64, ptr %s33, i64 0
  %v2319 = getelementptr i64, ptr @"str.6", i64 0
  %v2320 = add i64 0, 3
  %v2321 = add i64 0, 0
  %v2322 = getelementptr i64, ptr %s0, i64 0
  %v2323 = ptrtoint ptr %v2319 to i64
  %st765 = getelementptr i64, ptr %v2322, i64 0
  store i64 %v2323, ptr %st765
  %st766 = getelementptr i64, ptr %v2322, i64 1
  store i64 %v2320, ptr %st766
  %st767 = getelementptr i64, ptr %v2322, i64 2
  store i64 %v2321, ptr %st767
  %v2324.p = getelementptr i64, ptr %v2322, i64 0
  %v2324 = load i64, ptr %v2324.p
  %v2325.p = getelementptr i64, ptr %v2322, i64 1
  %v2325 = load i64, ptr %v2325.p
  %v2326.p = getelementptr i64, ptr %v2322, i64 2
  %v2326 = load i64, ptr %v2326.p
  %v2327 = getelementptr i64, ptr @"str.88", i64 0
  %v2328 = add i64 0, 1
  %v2329 = add i64 0, 0
  %v2330 = getelementptr i64, ptr %s1, i64 0
  %v2331 = ptrtoint ptr %v2327 to i64
  %st768 = getelementptr i64, ptr %v2330, i64 0
  store i64 %v2331, ptr %st768
  %st769 = getelementptr i64, ptr %v2330, i64 1
  store i64 %v2328, ptr %st769
  %st770 = getelementptr i64, ptr %v2330, i64 2
  store i64 %v2329, ptr %st770
  %v2332.p = getelementptr i64, ptr %v2330, i64 0
  %v2332 = load i64, ptr %v2332.p
  %v2333.p = getelementptr i64, ptr %v2330, i64 1
  %v2333 = load i64, ptr %v2333.p
  %v2334.p = getelementptr i64, ptr %v2330, i64 2
  %v2334 = load i64, ptr %v2334.p
  %v2335 = getelementptr i64, ptr @"str.90", i64 0
  %v2336 = add i64 0, 1
  %v2337 = add i64 0, 0
  %v2338 = getelementptr i64, ptr %s23, i64 0
  %v2339 = ptrtoint ptr %v2335 to i64
  %st771 = getelementptr i64, ptr %v2338, i64 0
  store i64 %v2339, ptr %st771
  %st772 = getelementptr i64, ptr %v2338, i64 1
  store i64 %v2336, ptr %st772
  %st773 = getelementptr i64, ptr %v2338, i64 2
  store i64 %v2337, ptr %st773
  %v2340.p = getelementptr i64, ptr %v2338, i64 0
  %v2340 = load i64, ptr %v2340.p
  %v2341.p = getelementptr i64, ptr %v2338, i64 1
  %v2341 = load i64, ptr %v2341.p
  %v2342.p = getelementptr i64, ptr %v2338, i64 2
  %v2342 = load i64, ptr %v2342.p
  %v2343 = add i64 0, 0
  call void @"std/strings.Replace"(ptr %v2318, i64 %v2324, i64 %v2325, i64 %v2326, i64 %v2332, i64 %v2333, i64 %v2334, i64 %v2340, i64 %v2341, i64 %v2342, i64 %v2343)
  call void @"rt.print_str"(ptr %v2318)
  %v2344 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2344)
  %v2345 = getelementptr i64, ptr %s34, i64 0
  %v2346 = getelementptr i64, ptr @"str.20", i64 0
  %v2347 = add i64 0, 9
  %v2348 = add i64 0, 0
  %v2349 = getelementptr i64, ptr %s23, i64 0
  %v2350 = ptrtoint ptr %v2346 to i64
  %st774 = getelementptr i64, ptr %v2349, i64 0
  store i64 %v2350, ptr %st774
  %st775 = getelementptr i64, ptr %v2349, i64 1
  store i64 %v2347, ptr %st775
  %st776 = getelementptr i64, ptr %v2349, i64 2
  store i64 %v2348, ptr %st776
  %v2351.p = getelementptr i64, ptr %v2349, i64 0
  %v2351 = load i64, ptr %v2351.p
  %v2352.p = getelementptr i64, ptr %v2349, i64 1
  %v2352 = load i64, ptr %v2352.p
  %v2353.p = getelementptr i64, ptr %v2349, i64 2
  %v2353 = load i64, ptr %v2353.p
  %v2354 = getelementptr i64, ptr @"str.4", i64 0
  %v2355 = add i64 0, 0
  %v2356 = add i64 0, 0
  %v2357 = getelementptr i64, ptr %s1, i64 0
  %v2358 = ptrtoint ptr %v2354 to i64
  %st777 = getelementptr i64, ptr %v2357, i64 0
  store i64 %v2358, ptr %st777
  %st778 = getelementptr i64, ptr %v2357, i64 1
  store i64 %v2355, ptr %st778
  %st779 = getelementptr i64, ptr %v2357, i64 2
  store i64 %v2356, ptr %st779
  %v2359.p = getelementptr i64, ptr %v2357, i64 0
  %v2359 = load i64, ptr %v2359.p
  %v2360.p = getelementptr i64, ptr %v2357, i64 1
  %v2360 = load i64, ptr %v2360.p
  %v2361.p = getelementptr i64, ptr %v2357, i64 2
  %v2361 = load i64, ptr %v2361.p
  %v2362 = getelementptr i64, ptr @"str.91", i64 0
  %v2363 = add i64 0, 1
  %v2364 = add i64 0, 0
  %v2365 = getelementptr i64, ptr %s0, i64 0
  %v2366 = ptrtoint ptr %v2362 to i64
  %st780 = getelementptr i64, ptr %v2365, i64 0
  store i64 %v2366, ptr %st780
  %st781 = getelementptr i64, ptr %v2365, i64 1
  store i64 %v2363, ptr %st781
  %st782 = getelementptr i64, ptr %v2365, i64 2
  store i64 %v2364, ptr %st782
  %v2367.p = getelementptr i64, ptr %v2365, i64 0
  %v2367 = load i64, ptr %v2367.p
  %v2368.p = getelementptr i64, ptr %v2365, i64 1
  %v2368 = load i64, ptr %v2368.p
  %v2369.p = getelementptr i64, ptr %v2365, i64 2
  %v2369 = load i64, ptr %v2369.p
  %v2370 = add i64 0, 1
  %v2371 = add i64 0, 0
  %v2372 = sub i64 %v2371, %v2370
  call void @"std/strings.Replace"(ptr %v2345, i64 %v2351, i64 %v2352, i64 %v2353, i64 %v2359, i64 %v2360, i64 %v2361, i64 %v2367, i64 %v2368, i64 %v2369, i64 %v2372)
  call void @"rt.print_str"(ptr %v2345)
  %v2373 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2373)
  %v2374 = getelementptr i64, ptr %s35, i64 0
  %v2375 = getelementptr i64, ptr @"str.65", i64 0
  %v2376 = add i64 0, 12
  %v2377 = add i64 0, 0
  %v2378 = getelementptr i64, ptr %s0, i64 0
  %v2379 = ptrtoint ptr %v2375 to i64
  %st783 = getelementptr i64, ptr %v2378, i64 0
  store i64 %v2379, ptr %st783
  %st784 = getelementptr i64, ptr %v2378, i64 1
  store i64 %v2376, ptr %st784
  %st785 = getelementptr i64, ptr %v2378, i64 2
  store i64 %v2377, ptr %st785
  %v2380.p = getelementptr i64, ptr %v2378, i64 0
  %v2380 = load i64, ptr %v2380.p
  %v2381.p = getelementptr i64, ptr %v2378, i64 1
  %v2381 = load i64, ptr %v2381.p
  %v2382.p = getelementptr i64, ptr %v2378, i64 2
  %v2382 = load i64, ptr %v2382.p
  %v2383 = getelementptr i64, ptr @"str.21", i64 0
  %v2384 = add i64 0, 3
  %v2385 = add i64 0, 0
  %v2386 = getelementptr i64, ptr %s1, i64 0
  %v2387 = ptrtoint ptr %v2383 to i64
  %st786 = getelementptr i64, ptr %v2386, i64 0
  store i64 %v2387, ptr %st786
  %st787 = getelementptr i64, ptr %v2386, i64 1
  store i64 %v2384, ptr %st787
  %st788 = getelementptr i64, ptr %v2386, i64 2
  store i64 %v2385, ptr %st788
  %v2388.p = getelementptr i64, ptr %v2386, i64 0
  %v2388 = load i64, ptr %v2388.p
  %v2389.p = getelementptr i64, ptr %v2386, i64 1
  %v2389 = load i64, ptr %v2389.p
  %v2390.p = getelementptr i64, ptr %v2386, i64 2
  %v2390 = load i64, ptr %v2390.p
  %v2391 = getelementptr i64, ptr @"str.61", i64 0
  %v2392 = add i64 0, 3
  %v2393 = add i64 0, 0
  %v2394 = getelementptr i64, ptr %s23, i64 0
  %v2395 = ptrtoint ptr %v2391 to i64
  %st789 = getelementptr i64, ptr %v2394, i64 0
  store i64 %v2395, ptr %st789
  %st790 = getelementptr i64, ptr %v2394, i64 1
  store i64 %v2392, ptr %st790
  %st791 = getelementptr i64, ptr %v2394, i64 2
  store i64 %v2393, ptr %st791
  %v2396.p = getelementptr i64, ptr %v2394, i64 0
  %v2396 = load i64, ptr %v2396.p
  %v2397.p = getelementptr i64, ptr %v2394, i64 1
  %v2397 = load i64, ptr %v2397.p
  %v2398.p = getelementptr i64, ptr %v2394, i64 2
  %v2398 = load i64, ptr %v2398.p
  %v2399 = add i64 0, 1
  %v2400 = add i64 0, 0
  %v2401 = sub i64 %v2400, %v2399
  call void @"std/strings.Replace"(ptr %v2374, i64 %v2380, i64 %v2381, i64 %v2382, i64 %v2388, i64 %v2389, i64 %v2390, i64 %v2396, i64 %v2397, i64 %v2398, i64 %v2401)
  call void @"rt.print_str"(ptr %v2374)
  %v2402 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2402)
  %v2403 = getelementptr i64, ptr %s36, i64 0
  %v2404 = getelementptr i64, ptr @"str.6", i64 0
  %v2405 = add i64 0, 3
  %v2406 = add i64 0, 0
  %v2407 = getelementptr i64, ptr %s23, i64 0
  %v2408 = ptrtoint ptr %v2404 to i64
  %st792 = getelementptr i64, ptr %v2407, i64 0
  store i64 %v2408, ptr %st792
  %st793 = getelementptr i64, ptr %v2407, i64 1
  store i64 %v2405, ptr %st793
  %st794 = getelementptr i64, ptr %v2407, i64 2
  store i64 %v2406, ptr %st794
  %v2409.p = getelementptr i64, ptr %v2407, i64 0
  %v2409 = load i64, ptr %v2409.p
  %v2410.p = getelementptr i64, ptr %v2407, i64 1
  %v2410 = load i64, ptr %v2410.p
  %v2411.p = getelementptr i64, ptr %v2407, i64 2
  %v2411 = load i64, ptr %v2411.p
  %v2412 = getelementptr i64, ptr @"str.6", i64 0
  %v2413 = add i64 0, 3
  %v2414 = add i64 0, 0
  %v2415 = getelementptr i64, ptr %s1, i64 0
  %v2416 = ptrtoint ptr %v2412 to i64
  %st795 = getelementptr i64, ptr %v2415, i64 0
  store i64 %v2416, ptr %st795
  %st796 = getelementptr i64, ptr %v2415, i64 1
  store i64 %v2413, ptr %st796
  %st797 = getelementptr i64, ptr %v2415, i64 2
  store i64 %v2414, ptr %st797
  %v2417.p = getelementptr i64, ptr %v2415, i64 0
  %v2417 = load i64, ptr %v2417.p
  %v2418.p = getelementptr i64, ptr %v2415, i64 1
  %v2418 = load i64, ptr %v2418.p
  %v2419.p = getelementptr i64, ptr %v2415, i64 2
  %v2419 = load i64, ptr %v2419.p
  %v2420 = getelementptr i64, ptr @"str.4", i64 0
  %v2421 = add i64 0, 0
  %v2422 = add i64 0, 0
  %v2423 = getelementptr i64, ptr %s0, i64 0
  %v2424 = ptrtoint ptr %v2420 to i64
  %st798 = getelementptr i64, ptr %v2423, i64 0
  store i64 %v2424, ptr %st798
  %st799 = getelementptr i64, ptr %v2423, i64 1
  store i64 %v2421, ptr %st799
  %st800 = getelementptr i64, ptr %v2423, i64 2
  store i64 %v2422, ptr %st800
  %v2425.p = getelementptr i64, ptr %v2423, i64 0
  %v2425 = load i64, ptr %v2425.p
  %v2426.p = getelementptr i64, ptr %v2423, i64 1
  %v2426 = load i64, ptr %v2426.p
  %v2427.p = getelementptr i64, ptr %v2423, i64 2
  %v2427 = load i64, ptr %v2427.p
  %v2428 = add i64 0, 1
  %v2429 = add i64 0, 0
  %v2430 = sub i64 %v2429, %v2428
  call void @"std/strings.Replace"(ptr %v2403, i64 %v2409, i64 %v2410, i64 %v2411, i64 %v2417, i64 %v2418, i64 %v2419, i64 %v2425, i64 %v2426, i64 %v2427, i64 %v2430)
  call void @"rt.print_str"(ptr %v2403)
  %v2431 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2431)
  %v2432 = getelementptr i64, ptr %s37, i64 0
  %v2433 = getelementptr i64, ptr @"str.92", i64 0
  %v2434 = add i64 0, 4
  %v2435 = add i64 0, 0
  %v2436 = getelementptr i64, ptr %s0, i64 0
  %v2437 = ptrtoint ptr %v2433 to i64
  %st801 = getelementptr i64, ptr %v2436, i64 0
  store i64 %v2437, ptr %st801
  %st802 = getelementptr i64, ptr %v2436, i64 1
  store i64 %v2434, ptr %st802
  %st803 = getelementptr i64, ptr %v2436, i64 2
  store i64 %v2435, ptr %st803
  %v2438.p = getelementptr i64, ptr %v2436, i64 0
  %v2438 = load i64, ptr %v2438.p
  %v2439.p = getelementptr i64, ptr %v2436, i64 1
  %v2439 = load i64, ptr %v2439.p
  %v2440.p = getelementptr i64, ptr %v2436, i64 2
  %v2440 = load i64, ptr %v2440.p
  %v2441 = getelementptr i64, ptr @"str.14", i64 0
  %v2442 = add i64 0, 2
  %v2443 = add i64 0, 0
  %v2444 = getelementptr i64, ptr %s1, i64 0
  %v2445 = ptrtoint ptr %v2441 to i64
  %st804 = getelementptr i64, ptr %v2444, i64 0
  store i64 %v2445, ptr %st804
  %st805 = getelementptr i64, ptr %v2444, i64 1
  store i64 %v2442, ptr %st805
  %st806 = getelementptr i64, ptr %v2444, i64 2
  store i64 %v2443, ptr %st806
  %v2446.p = getelementptr i64, ptr %v2444, i64 0
  %v2446 = load i64, ptr %v2446.p
  %v2447.p = getelementptr i64, ptr %v2444, i64 1
  %v2447 = load i64, ptr %v2447.p
  %v2448.p = getelementptr i64, ptr %v2444, i64 2
  %v2448 = load i64, ptr %v2448.p
  %v2449 = getelementptr i64, ptr @"str.14", i64 0
  %v2450 = add i64 0, 2
  %v2451 = add i64 0, 0
  %v2452 = getelementptr i64, ptr %s23, i64 0
  %v2453 = ptrtoint ptr %v2449 to i64
  %st807 = getelementptr i64, ptr %v2452, i64 0
  store i64 %v2453, ptr %st807
  %st808 = getelementptr i64, ptr %v2452, i64 1
  store i64 %v2450, ptr %st808
  %st809 = getelementptr i64, ptr %v2452, i64 2
  store i64 %v2451, ptr %st809
  %v2454.p = getelementptr i64, ptr %v2452, i64 0
  %v2454 = load i64, ptr %v2454.p
  %v2455.p = getelementptr i64, ptr %v2452, i64 1
  %v2455 = load i64, ptr %v2455.p
  %v2456.p = getelementptr i64, ptr %v2452, i64 2
  %v2456 = load i64, ptr %v2456.p
  %v2457 = add i64 0, 1
  %v2458 = add i64 0, 0
  %v2459 = sub i64 %v2458, %v2457
  call void @"std/strings.Replace"(ptr %v2432, i64 %v2438, i64 %v2439, i64 %v2440, i64 %v2446, i64 %v2447, i64 %v2448, i64 %v2454, i64 %v2455, i64 %v2456, i64 %v2459)
  call void @"rt.print_str"(ptr %v2432)
  %v2460 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2460)
  %v2461 = getelementptr i64, ptr %s38, i64 0
  %v2462 = getelementptr i64, ptr @"str.93", i64 0
  %v2463 = add i64 0, 6
  %v2464 = add i64 0, 0
  %v2465 = getelementptr i64, ptr %s23, i64 0
  %v2466 = ptrtoint ptr %v2462 to i64
  %st810 = getelementptr i64, ptr %v2465, i64 0
  store i64 %v2466, ptr %st810
  %st811 = getelementptr i64, ptr %v2465, i64 1
  store i64 %v2463, ptr %st811
  %st812 = getelementptr i64, ptr %v2465, i64 2
  store i64 %v2464, ptr %st812
  %v2467.p = getelementptr i64, ptr %v2465, i64 0
  %v2467 = load i64, ptr %v2467.p
  %v2468.p = getelementptr i64, ptr %v2465, i64 1
  %v2468 = load i64, ptr %v2468.p
  %v2469.p = getelementptr i64, ptr %v2465, i64 2
  %v2469 = load i64, ptr %v2469.p
  call void @"std/strings.ToLower"(ptr %v2461, i64 %v2467, i64 %v2468, i64 %v2469)
  call void @"rt.print_str"(ptr %v2461)
  %v2470 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2470)
  %v2471 = getelementptr i64, ptr %s39, i64 0
  %v2472 = getelementptr i64, ptr @"str.4", i64 0
  %v2473 = add i64 0, 0
  %v2474 = add i64 0, 0
  %v2475 = getelementptr i64, ptr %s23, i64 0
  %v2476 = ptrtoint ptr %v2472 to i64
  %st813 = getelementptr i64, ptr %v2475, i64 0
  store i64 %v2476, ptr %st813
  %st814 = getelementptr i64, ptr %v2475, i64 1
  store i64 %v2473, ptr %st814
  %st815 = getelementptr i64, ptr %v2475, i64 2
  store i64 %v2474, ptr %st815
  %v2477.p = getelementptr i64, ptr %v2475, i64 0
  %v2477 = load i64, ptr %v2477.p
  %v2478.p = getelementptr i64, ptr %v2475, i64 1
  %v2478 = load i64, ptr %v2478.p
  %v2479.p = getelementptr i64, ptr %v2475, i64 2
  %v2479 = load i64, ptr %v2479.p
  call void @"std/strings.ToLower"(ptr %v2471, i64 %v2477, i64 %v2478, i64 %v2479)
  call void @"rt.print_str"(ptr %v2471)
  %v2480 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2480)
  %v2481 = getelementptr i64, ptr %s40, i64 0
  %v2482 = getelementptr i64, ptr @"str.94", i64 0
  %v2483 = add i64 0, 11
  %v2484 = add i64 0, 0
  %v2485 = getelementptr i64, ptr %s23, i64 0
  %v2486 = ptrtoint ptr %v2482 to i64
  %st816 = getelementptr i64, ptr %v2485, i64 0
  store i64 %v2486, ptr %st816
  %st817 = getelementptr i64, ptr %v2485, i64 1
  store i64 %v2483, ptr %st817
  %st818 = getelementptr i64, ptr %v2485, i64 2
  store i64 %v2484, ptr %st818
  %v2487.p = getelementptr i64, ptr %v2485, i64 0
  %v2487 = load i64, ptr %v2487.p
  %v2488.p = getelementptr i64, ptr %v2485, i64 1
  %v2488 = load i64, ptr %v2488.p
  %v2489.p = getelementptr i64, ptr %v2485, i64 2
  %v2489 = load i64, ptr %v2489.p
  call void @"std/strings.ToLower"(ptr %v2481, i64 %v2487, i64 %v2488, i64 %v2489)
  call void @"rt.print_str"(ptr %v2481)
  %v2490 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2490)
  %v2491 = getelementptr i64, ptr %s41, i64 0
  %v2492 = getelementptr i64, ptr @"str.95", i64 0
  %v2493 = add i64 0, 7
  %v2494 = add i64 0, 0
  %v2495 = getelementptr i64, ptr %s23, i64 0
  %v2496 = ptrtoint ptr %v2492 to i64
  %st819 = getelementptr i64, ptr %v2495, i64 0
  store i64 %v2496, ptr %st819
  %st820 = getelementptr i64, ptr %v2495, i64 1
  store i64 %v2493, ptr %st820
  %st821 = getelementptr i64, ptr %v2495, i64 2
  store i64 %v2494, ptr %st821
  %v2497.p = getelementptr i64, ptr %v2495, i64 0
  %v2497 = load i64, ptr %v2497.p
  %v2498.p = getelementptr i64, ptr %v2495, i64 1
  %v2498 = load i64, ptr %v2498.p
  %v2499.p = getelementptr i64, ptr %v2495, i64 2
  %v2499 = load i64, ptr %v2499.p
  call void @"std/strings.ToLower"(ptr %v2491, i64 %v2497, i64 %v2498, i64 %v2499)
  call void @"rt.print_str"(ptr %v2491)
  %v2500 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2500)
  %v2501 = getelementptr i64, ptr %s42, i64 0
  %v2502 = getelementptr i64, ptr @"str.96", i64 0
  %v2503 = add i64 0, 4
  %v2504 = add i64 0, 0
  %v2505 = getelementptr i64, ptr %s23, i64 0
  %v2506 = ptrtoint ptr %v2502 to i64
  %st822 = getelementptr i64, ptr %v2505, i64 0
  store i64 %v2506, ptr %st822
  %st823 = getelementptr i64, ptr %v2505, i64 1
  store i64 %v2503, ptr %st823
  %st824 = getelementptr i64, ptr %v2505, i64 2
  store i64 %v2504, ptr %st824
  %v2507.p = getelementptr i64, ptr %v2505, i64 0
  %v2507 = load i64, ptr %v2507.p
  %v2508.p = getelementptr i64, ptr %v2505, i64 1
  %v2508 = load i64, ptr %v2508.p
  %v2509.p = getelementptr i64, ptr %v2505, i64 2
  %v2509 = load i64, ptr %v2509.p
  call void @"std/strings.ToLower"(ptr %v2501, i64 %v2507, i64 %v2508, i64 %v2509)
  call void @"rt.print_str"(ptr %v2501)
  %v2510 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2510)
  %v2511 = getelementptr i64, ptr %s43, i64 0
  %v2512 = getelementptr i64, ptr @"str.93", i64 0
  %v2513 = add i64 0, 6
  %v2514 = add i64 0, 0
  %v2515 = getelementptr i64, ptr %s23, i64 0
  %v2516 = ptrtoint ptr %v2512 to i64
  %st825 = getelementptr i64, ptr %v2515, i64 0
  store i64 %v2516, ptr %st825
  %st826 = getelementptr i64, ptr %v2515, i64 1
  store i64 %v2513, ptr %st826
  %st827 = getelementptr i64, ptr %v2515, i64 2
  store i64 %v2514, ptr %st827
  %v2517.p = getelementptr i64, ptr %v2515, i64 0
  %v2517 = load i64, ptr %v2517.p
  %v2518.p = getelementptr i64, ptr %v2515, i64 1
  %v2518 = load i64, ptr %v2518.p
  %v2519.p = getelementptr i64, ptr %v2515, i64 2
  %v2519 = load i64, ptr %v2519.p
  call void @"std/strings.ToUpper"(ptr %v2511, i64 %v2517, i64 %v2518, i64 %v2519)
  call void @"rt.print_str"(ptr %v2511)
  %v2520 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2520)
  %v2521 = getelementptr i64, ptr %s44, i64 0
  %v2522 = getelementptr i64, ptr @"str.4", i64 0
  %v2523 = add i64 0, 0
  %v2524 = add i64 0, 0
  %v2525 = getelementptr i64, ptr %s23, i64 0
  %v2526 = ptrtoint ptr %v2522 to i64
  %st828 = getelementptr i64, ptr %v2525, i64 0
  store i64 %v2526, ptr %st828
  %st829 = getelementptr i64, ptr %v2525, i64 1
  store i64 %v2523, ptr %st829
  %st830 = getelementptr i64, ptr %v2525, i64 2
  store i64 %v2524, ptr %st830
  %v2527.p = getelementptr i64, ptr %v2525, i64 0
  %v2527 = load i64, ptr %v2527.p
  %v2528.p = getelementptr i64, ptr %v2525, i64 1
  %v2528 = load i64, ptr %v2528.p
  %v2529.p = getelementptr i64, ptr %v2525, i64 2
  %v2529 = load i64, ptr %v2529.p
  call void @"std/strings.ToUpper"(ptr %v2521, i64 %v2527, i64 %v2528, i64 %v2529)
  call void @"rt.print_str"(ptr %v2521)
  %v2530 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2530)
  %v2531 = getelementptr i64, ptr %s45, i64 0
  %v2532 = getelementptr i64, ptr @"str.97", i64 0
  %v2533 = add i64 0, 11
  %v2534 = add i64 0, 0
  %v2535 = getelementptr i64, ptr %s23, i64 0
  %v2536 = ptrtoint ptr %v2532 to i64
  %st831 = getelementptr i64, ptr %v2535, i64 0
  store i64 %v2536, ptr %st831
  %st832 = getelementptr i64, ptr %v2535, i64 1
  store i64 %v2533, ptr %st832
  %st833 = getelementptr i64, ptr %v2535, i64 2
  store i64 %v2534, ptr %st833
  %v2537.p = getelementptr i64, ptr %v2535, i64 0
  %v2537 = load i64, ptr %v2537.p
  %v2538.p = getelementptr i64, ptr %v2535, i64 1
  %v2538 = load i64, ptr %v2538.p
  %v2539.p = getelementptr i64, ptr %v2535, i64 2
  %v2539 = load i64, ptr %v2539.p
  call void @"std/strings.ToUpper"(ptr %v2531, i64 %v2537, i64 %v2538, i64 %v2539)
  call void @"rt.print_str"(ptr %v2531)
  %v2540 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2540)
  %v2541 = getelementptr i64, ptr %s46, i64 0
  %v2542 = getelementptr i64, ptr @"str.98", i64 0
  %v2543 = add i64 0, 7
  %v2544 = add i64 0, 0
  %v2545 = getelementptr i64, ptr %s23, i64 0
  %v2546 = ptrtoint ptr %v2542 to i64
  %st834 = getelementptr i64, ptr %v2545, i64 0
  store i64 %v2546, ptr %st834
  %st835 = getelementptr i64, ptr %v2545, i64 1
  store i64 %v2543, ptr %st835
  %st836 = getelementptr i64, ptr %v2545, i64 2
  store i64 %v2544, ptr %st836
  %v2547.p = getelementptr i64, ptr %v2545, i64 0
  %v2547 = load i64, ptr %v2547.p
  %v2548.p = getelementptr i64, ptr %v2545, i64 1
  %v2548 = load i64, ptr %v2548.p
  %v2549.p = getelementptr i64, ptr %v2545, i64 2
  %v2549 = load i64, ptr %v2549.p
  call void @"std/strings.ToUpper"(ptr %v2541, i64 %v2547, i64 %v2548, i64 %v2549)
  call void @"rt.print_str"(ptr %v2541)
  %v2550 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2550)
  %v2551 = getelementptr i64, ptr %s47, i64 0
  %v2552 = getelementptr i64, ptr @"str.99", i64 0
  %v2553 = add i64 0, 4
  %v2554 = add i64 0, 0
  %v2555 = getelementptr i64, ptr %s23, i64 0
  %v2556 = ptrtoint ptr %v2552 to i64
  %st837 = getelementptr i64, ptr %v2555, i64 0
  store i64 %v2556, ptr %st837
  %st838 = getelementptr i64, ptr %v2555, i64 1
  store i64 %v2553, ptr %st838
  %st839 = getelementptr i64, ptr %v2555, i64 2
  store i64 %v2554, ptr %st839
  %v2557.p = getelementptr i64, ptr %v2555, i64 0
  %v2557 = load i64, ptr %v2557.p
  %v2558.p = getelementptr i64, ptr %v2555, i64 1
  %v2558 = load i64, ptr %v2558.p
  %v2559.p = getelementptr i64, ptr %v2555, i64 2
  %v2559 = load i64, ptr %v2559.p
  call void @"std/strings.ToUpper"(ptr %v2551, i64 %v2557, i64 %v2558, i64 %v2559)
  call void @"rt.print_str"(ptr %v2551)
  %v2560 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2560)
  %v2561 = getelementptr i64, ptr @"str.100", i64 0
  %v2562 = add i64 0, 2
  %v2563 = add i64 0, 0
  %v2564 = getelementptr i64, ptr %s23, i64 0
  %v2565 = ptrtoint ptr %v2561 to i64
  %st840 = getelementptr i64, ptr %v2564, i64 0
  store i64 %v2565, ptr %st840
  %st841 = getelementptr i64, ptr %v2564, i64 1
  store i64 %v2562, ptr %st841
  %st842 = getelementptr i64, ptr %v2564, i64 2
  store i64 %v2563, ptr %st842
  %v2566.p = getelementptr i64, ptr %v2564, i64 0
  %v2566 = load i64, ptr %v2566.p
  %v2567.p = getelementptr i64, ptr %v2564, i64 1
  %v2567 = load i64, ptr %v2567.p
  %v2568.p = getelementptr i64, ptr %v2564, i64 2
  %v2568 = load i64, ptr %v2568.p
  %v2569 = getelementptr i64, ptr @"str.101", i64 0
  %v2570 = add i64 0, 2
  %v2571 = add i64 0, 0
  %v2572 = getelementptr i64, ptr %s1, i64 0
  %v2573 = ptrtoint ptr %v2569 to i64
  %st843 = getelementptr i64, ptr %v2572, i64 0
  store i64 %v2573, ptr %st843
  %st844 = getelementptr i64, ptr %v2572, i64 1
  store i64 %v2570, ptr %st844
  %st845 = getelementptr i64, ptr %v2572, i64 2
  store i64 %v2571, ptr %st845
  %v2574.p = getelementptr i64, ptr %v2572, i64 0
  %v2574 = load i64, ptr %v2574.p
  %v2575.p = getelementptr i64, ptr %v2572, i64 1
  %v2575 = load i64, ptr %v2575.p
  %v2576.p = getelementptr i64, ptr %v2572, i64 2
  %v2576 = load i64, ptr %v2576.p
  %v2577 = call i64 @"std/strings.EqualFold"(i64 %v2566, i64 %v2567, i64 %v2568, i64 %v2574, i64 %v2575, i64 %v2576)
  %c.b63 = icmp ne i64 %v2577, 0
  br i1 %c.b63, label %b63.t847, label %b63.e848
b63.t847:
  br label %b64
b63.e848:
  br label %b65
b64:
  %v2578 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2578)
  %v2579 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2579)
  %v2580 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2580)
  %v2581 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2581)
  br label %b66
b65:
  %v2582 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2582)
  %v2583 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2583)
  %v2584 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2584)
  %v2585 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2585)
  %v2586 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2586)
  br label %b66
b66:
  %v2587 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2587)
  %v2588 = getelementptr i64, ptr @"str.100", i64 0
  %v2589 = add i64 0, 2
  %v2590 = add i64 0, 0
  %v2591 = getelementptr i64, ptr %s1, i64 0
  %v2592 = ptrtoint ptr %v2588 to i64
  %st848 = getelementptr i64, ptr %v2591, i64 0
  store i64 %v2592, ptr %st848
  %st849 = getelementptr i64, ptr %v2591, i64 1
  store i64 %v2589, ptr %st849
  %st850 = getelementptr i64, ptr %v2591, i64 2
  store i64 %v2590, ptr %st850
  %v2593.p = getelementptr i64, ptr %v2591, i64 0
  %v2593 = load i64, ptr %v2593.p
  %v2594.p = getelementptr i64, ptr %v2591, i64 1
  %v2594 = load i64, ptr %v2594.p
  %v2595.p = getelementptr i64, ptr %v2591, i64 2
  %v2595 = load i64, ptr %v2595.p
  %v2596 = getelementptr i64, ptr @"str.102", i64 0
  %v2597 = add i64 0, 2
  %v2598 = add i64 0, 0
  %v2599 = getelementptr i64, ptr %s23, i64 0
  %v2600 = ptrtoint ptr %v2596 to i64
  %st851 = getelementptr i64, ptr %v2599, i64 0
  store i64 %v2600, ptr %st851
  %st852 = getelementptr i64, ptr %v2599, i64 1
  store i64 %v2597, ptr %st852
  %st853 = getelementptr i64, ptr %v2599, i64 2
  store i64 %v2598, ptr %st853
  %v2601.p = getelementptr i64, ptr %v2599, i64 0
  %v2601 = load i64, ptr %v2601.p
  %v2602.p = getelementptr i64, ptr %v2599, i64 1
  %v2602 = load i64, ptr %v2602.p
  %v2603.p = getelementptr i64, ptr %v2599, i64 2
  %v2603 = load i64, ptr %v2603.p
  %v2604 = call i64 @"std/strings.EqualFold"(i64 %v2593, i64 %v2594, i64 %v2595, i64 %v2601, i64 %v2602, i64 %v2603)
  %c.b66 = icmp ne i64 %v2604, 0
  br i1 %c.b66, label %b66.t855, label %b66.e856
b66.t855:
  br label %b67
b66.e856:
  br label %b68
b67:
  %v2605 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2605)
  %v2606 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2606)
  %v2607 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2607)
  %v2608 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2608)
  br label %b69
b68:
  %v2609 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2609)
  %v2610 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2610)
  %v2611 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2611)
  %v2612 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2612)
  %v2613 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2613)
  br label %b69
b69:
  %v2614 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2614)
  %v2615 = getelementptr i64, ptr @"str.4", i64 0
  %v2616 = add i64 0, 0
  %v2617 = add i64 0, 0
  %v2618 = getelementptr i64, ptr %s23, i64 0
  %v2619 = ptrtoint ptr %v2615 to i64
  %st856 = getelementptr i64, ptr %v2618, i64 0
  store i64 %v2619, ptr %st856
  %st857 = getelementptr i64, ptr %v2618, i64 1
  store i64 %v2616, ptr %st857
  %st858 = getelementptr i64, ptr %v2618, i64 2
  store i64 %v2617, ptr %st858
  %v2620.p = getelementptr i64, ptr %v2618, i64 0
  %v2620 = load i64, ptr %v2620.p
  %v2621.p = getelementptr i64, ptr %v2618, i64 1
  %v2621 = load i64, ptr %v2621.p
  %v2622.p = getelementptr i64, ptr %v2618, i64 2
  %v2622 = load i64, ptr %v2622.p
  %v2623 = getelementptr i64, ptr @"str.4", i64 0
  %v2624 = add i64 0, 0
  %v2625 = add i64 0, 0
  %v2626 = getelementptr i64, ptr %s1, i64 0
  %v2627 = ptrtoint ptr %v2623 to i64
  %st859 = getelementptr i64, ptr %v2626, i64 0
  store i64 %v2627, ptr %st859
  %st860 = getelementptr i64, ptr %v2626, i64 1
  store i64 %v2624, ptr %st860
  %st861 = getelementptr i64, ptr %v2626, i64 2
  store i64 %v2625, ptr %st861
  %v2628.p = getelementptr i64, ptr %v2626, i64 0
  %v2628 = load i64, ptr %v2628.p
  %v2629.p = getelementptr i64, ptr %v2626, i64 1
  %v2629 = load i64, ptr %v2629.p
  %v2630.p = getelementptr i64, ptr %v2626, i64 2
  %v2630 = load i64, ptr %v2630.p
  %v2631 = call i64 @"std/strings.EqualFold"(i64 %v2620, i64 %v2621, i64 %v2622, i64 %v2628, i64 %v2629, i64 %v2630)
  %c.b69 = icmp ne i64 %v2631, 0
  br i1 %c.b69, label %b69.t863, label %b69.e864
b69.t863:
  br label %b70
b69.e864:
  br label %b71
b70:
  %v2632 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2632)
  %v2633 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2633)
  %v2634 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2634)
  %v2635 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2635)
  br label %b72
b71:
  %v2636 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2636)
  %v2637 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2637)
  %v2638 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2638)
  %v2639 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2639)
  %v2640 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2640)
  br label %b72
b72:
  %v2641 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2641)
  %v2642 = getelementptr i64, ptr @"str.5", i64 0
  %v2643 = add i64 0, 1
  %v2644 = add i64 0, 0
  %v2645 = getelementptr i64, ptr %s1, i64 0
  %v2646 = ptrtoint ptr %v2642 to i64
  %st864 = getelementptr i64, ptr %v2645, i64 0
  store i64 %v2646, ptr %st864
  %st865 = getelementptr i64, ptr %v2645, i64 1
  store i64 %v2643, ptr %st865
  %st866 = getelementptr i64, ptr %v2645, i64 2
  store i64 %v2644, ptr %st866
  %v2647.p = getelementptr i64, ptr %v2645, i64 0
  %v2647 = load i64, ptr %v2647.p
  %v2648.p = getelementptr i64, ptr %v2645, i64 1
  %v2648 = load i64, ptr %v2648.p
  %v2649.p = getelementptr i64, ptr %v2645, i64 2
  %v2649 = load i64, ptr %v2649.p
  %v2650 = getelementptr i64, ptr @"str.4", i64 0
  %v2651 = add i64 0, 0
  %v2652 = add i64 0, 0
  %v2653 = getelementptr i64, ptr %s23, i64 0
  %v2654 = ptrtoint ptr %v2650 to i64
  %st867 = getelementptr i64, ptr %v2653, i64 0
  store i64 %v2654, ptr %st867
  %st868 = getelementptr i64, ptr %v2653, i64 1
  store i64 %v2651, ptr %st868
  %st869 = getelementptr i64, ptr %v2653, i64 2
  store i64 %v2652, ptr %st869
  %v2655.p = getelementptr i64, ptr %v2653, i64 0
  %v2655 = load i64, ptr %v2655.p
  %v2656.p = getelementptr i64, ptr %v2653, i64 1
  %v2656 = load i64, ptr %v2656.p
  %v2657.p = getelementptr i64, ptr %v2653, i64 2
  %v2657 = load i64, ptr %v2657.p
  %v2658 = call i64 @"std/strings.EqualFold"(i64 %v2647, i64 %v2648, i64 %v2649, i64 %v2655, i64 %v2656, i64 %v2657)
  %c.b72 = icmp ne i64 %v2658, 0
  br i1 %c.b72, label %b72.t871, label %b72.e872
b72.t871:
  br label %b73
b72.e872:
  br label %b74
b73:
  %v2659 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2659)
  %v2660 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2660)
  %v2661 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2661)
  %v2662 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2662)
  br label %b75
b74:
  %v2663 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2663)
  %v2664 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2664)
  %v2665 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2665)
  %v2666 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2666)
  %v2667 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2667)
  br label %b75
b75:
  %v2668 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2668)
  %v2669 = getelementptr i64, ptr @"str.103", i64 0
  %v2670 = add i64 0, 1
  %v2671 = add i64 0, 0
  %v2672 = getelementptr i64, ptr %s23, i64 0
  %v2673 = ptrtoint ptr %v2669 to i64
  %st872 = getelementptr i64, ptr %v2672, i64 0
  store i64 %v2673, ptr %st872
  %st873 = getelementptr i64, ptr %v2672, i64 1
  store i64 %v2670, ptr %st873
  %st874 = getelementptr i64, ptr %v2672, i64 2
  store i64 %v2671, ptr %st874
  %v2674.p = getelementptr i64, ptr %v2672, i64 0
  %v2674 = load i64, ptr %v2674.p
  %v2675.p = getelementptr i64, ptr %v2672, i64 1
  %v2675 = load i64, ptr %v2675.p
  %v2676.p = getelementptr i64, ptr %v2672, i64 2
  %v2676 = load i64, ptr %v2676.p
  %v2677 = getelementptr i64, ptr @"str.104", i64 0
  %v2678 = add i64 0, 1
  %v2679 = add i64 0, 0
  %v2680 = getelementptr i64, ptr %s1, i64 0
  %v2681 = ptrtoint ptr %v2677 to i64
  %st875 = getelementptr i64, ptr %v2680, i64 0
  store i64 %v2681, ptr %st875
  %st876 = getelementptr i64, ptr %v2680, i64 1
  store i64 %v2678, ptr %st876
  %st877 = getelementptr i64, ptr %v2680, i64 2
  store i64 %v2679, ptr %st877
  %v2682.p = getelementptr i64, ptr %v2680, i64 0
  %v2682 = load i64, ptr %v2682.p
  %v2683.p = getelementptr i64, ptr %v2680, i64 1
  %v2683 = load i64, ptr %v2683.p
  %v2684.p = getelementptr i64, ptr %v2680, i64 2
  %v2684 = load i64, ptr %v2684.p
  %v2685 = call i64 @"std/strings.EqualFold"(i64 %v2674, i64 %v2675, i64 %v2676, i64 %v2682, i64 %v2683, i64 %v2684)
  %c.b75 = icmp ne i64 %v2685, 0
  br i1 %c.b75, label %b75.t879, label %b75.e880
b75.t879:
  br label %b76
b75.e880:
  br label %b77
b76:
  %v2686 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2686)
  %v2687 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2687)
  %v2688 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2688)
  %v2689 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2689)
  br label %b78
b77:
  %v2690 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2690)
  %v2691 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2691)
  %v2692 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2692)
  %v2693 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2693)
  %v2694 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2694)
  br label %b78
b78:
  %v2695 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2695)
  %v2696 = getelementptr i64, ptr @"str.105", i64 0
  %v2697 = add i64 0, 1
  %v2698 = add i64 0, 0
  %v2699 = getelementptr i64, ptr %s1, i64 0
  %v2700 = ptrtoint ptr %v2696 to i64
  %st880 = getelementptr i64, ptr %v2699, i64 0
  store i64 %v2700, ptr %st880
  %st881 = getelementptr i64, ptr %v2699, i64 1
  store i64 %v2697, ptr %st881
  %st882 = getelementptr i64, ptr %v2699, i64 2
  store i64 %v2698, ptr %st882
  %v2701.p = getelementptr i64, ptr %v2699, i64 0
  %v2701 = load i64, ptr %v2701.p
  %v2702.p = getelementptr i64, ptr %v2699, i64 1
  %v2702 = load i64, ptr %v2702.p
  %v2703.p = getelementptr i64, ptr %v2699, i64 2
  %v2703 = load i64, ptr %v2703.p
  %v2704 = getelementptr i64, ptr @"str.106", i64 0
  %v2705 = add i64 0, 1
  %v2706 = add i64 0, 0
  %v2707 = getelementptr i64, ptr %s23, i64 0
  %v2708 = ptrtoint ptr %v2704 to i64
  %st883 = getelementptr i64, ptr %v2707, i64 0
  store i64 %v2708, ptr %st883
  %st884 = getelementptr i64, ptr %v2707, i64 1
  store i64 %v2705, ptr %st884
  %st885 = getelementptr i64, ptr %v2707, i64 2
  store i64 %v2706, ptr %st885
  %v2709.p = getelementptr i64, ptr %v2707, i64 0
  %v2709 = load i64, ptr %v2709.p
  %v2710.p = getelementptr i64, ptr %v2707, i64 1
  %v2710 = load i64, ptr %v2710.p
  %v2711.p = getelementptr i64, ptr %v2707, i64 2
  %v2711 = load i64, ptr %v2711.p
  %v2712 = call i64 @"std/strings.EqualFold"(i64 %v2701, i64 %v2702, i64 %v2703, i64 %v2709, i64 %v2710, i64 %v2711)
  %c.b78 = icmp ne i64 %v2712, 0
  br i1 %c.b78, label %b78.t887, label %b78.e888
b78.t887:
  br label %b79
b78.e888:
  br label %b80
b79:
  %v2713 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2713)
  %v2714 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2714)
  %v2715 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2715)
  %v2716 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2716)
  br label %b81
b80:
  %v2717 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2717)
  %v2718 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2718)
  %v2719 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2719)
  %v2720 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2720)
  %v2721 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2721)
  br label %b81
b81:
  %v2722 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2722)
  %v2723 = getelementptr i64, ptr @"str.107", i64 0
  %v2724 = add i64 0, 12
  %v2725 = add i64 0, 0
  %v2726 = getelementptr i64, ptr %s23, i64 0
  %v2727 = ptrtoint ptr %v2723 to i64
  %st888 = getelementptr i64, ptr %v2726, i64 0
  store i64 %v2727, ptr %st888
  %st889 = getelementptr i64, ptr %v2726, i64 1
  store i64 %v2724, ptr %st889
  %st890 = getelementptr i64, ptr %v2726, i64 2
  store i64 %v2725, ptr %st890
  %v2728.p = getelementptr i64, ptr %v2726, i64 0
  %v2728 = load i64, ptr %v2728.p
  %v2729.p = getelementptr i64, ptr %v2726, i64 1
  %v2729 = load i64, ptr %v2729.p
  %v2730.p = getelementptr i64, ptr %v2726, i64 2
  %v2730 = load i64, ptr %v2730.p
  %v2731 = getelementptr i64, ptr @"str.108", i64 0
  %v2732 = add i64 0, 12
  %v2733 = add i64 0, 0
  %v2734 = getelementptr i64, ptr %s1, i64 0
  %v2735 = ptrtoint ptr %v2731 to i64
  %st891 = getelementptr i64, ptr %v2734, i64 0
  store i64 %v2735, ptr %st891
  %st892 = getelementptr i64, ptr %v2734, i64 1
  store i64 %v2732, ptr %st892
  %st893 = getelementptr i64, ptr %v2734, i64 2
  store i64 %v2733, ptr %st893
  %v2736.p = getelementptr i64, ptr %v2734, i64 0
  %v2736 = load i64, ptr %v2736.p
  %v2737.p = getelementptr i64, ptr %v2734, i64 1
  %v2737 = load i64, ptr %v2737.p
  %v2738.p = getelementptr i64, ptr %v2734, i64 2
  %v2738 = load i64, ptr %v2738.p
  %v2739 = call i64 @"std/strings.EqualFold"(i64 %v2728, i64 %v2729, i64 %v2730, i64 %v2736, i64 %v2737, i64 %v2738)
  %c.b81 = icmp ne i64 %v2739, 0
  br i1 %c.b81, label %b81.t895, label %b81.e896
b81.t895:
  br label %b82
b81.e896:
  br label %b83
b82:
  %v2740 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2740)
  %v2741 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2741)
  %v2742 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2742)
  %v2743 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2743)
  br label %b84
b83:
  %v2744 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2744)
  %v2745 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2745)
  %v2746 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2746)
  %v2747 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2747)
  %v2748 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2748)
  br label %b84
b84:
  %v2749 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2749)
  %v2750 = getelementptr i64, ptr @"str.96", i64 0
  %v2751 = add i64 0, 4
  %v2752 = add i64 0, 0
  %v2753 = getelementptr i64, ptr %s1, i64 0
  %v2754 = ptrtoint ptr %v2750 to i64
  %st896 = getelementptr i64, ptr %v2753, i64 0
  store i64 %v2754, ptr %st896
  %st897 = getelementptr i64, ptr %v2753, i64 1
  store i64 %v2751, ptr %st897
  %st898 = getelementptr i64, ptr %v2753, i64 2
  store i64 %v2752, ptr %st898
  %v2755.p = getelementptr i64, ptr %v2753, i64 0
  %v2755 = load i64, ptr %v2755.p
  %v2756.p = getelementptr i64, ptr %v2753, i64 1
  %v2756 = load i64, ptr %v2756.p
  %v2757.p = getelementptr i64, ptr %v2753, i64 2
  %v2757 = load i64, ptr %v2757.p
  %v2758 = getelementptr i64, ptr @"str.99", i64 0
  %v2759 = add i64 0, 4
  %v2760 = add i64 0, 0
  %v2761 = getelementptr i64, ptr %s23, i64 0
  %v2762 = ptrtoint ptr %v2758 to i64
  %st899 = getelementptr i64, ptr %v2761, i64 0
  store i64 %v2762, ptr %st899
  %st900 = getelementptr i64, ptr %v2761, i64 1
  store i64 %v2759, ptr %st900
  %st901 = getelementptr i64, ptr %v2761, i64 2
  store i64 %v2760, ptr %st901
  %v2763.p = getelementptr i64, ptr %v2761, i64 0
  %v2763 = load i64, ptr %v2763.p
  %v2764.p = getelementptr i64, ptr %v2761, i64 1
  %v2764 = load i64, ptr %v2764.p
  %v2765.p = getelementptr i64, ptr %v2761, i64 2
  %v2765 = load i64, ptr %v2765.p
  %v2766 = call i64 @"std/strings.EqualFold"(i64 %v2755, i64 %v2756, i64 %v2757, i64 %v2763, i64 %v2764, i64 %v2765)
  %c.b84 = icmp ne i64 %v2766, 0
  br i1 %c.b84, label %b84.t903, label %b84.e904
b84.t903:
  br label %b85
b84.e904:
  br label %b86
b85:
  %v2767 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2767)
  %v2768 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2768)
  %v2769 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2769)
  %v2770 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2770)
  br label %b87
b86:
  %v2771 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2771)
  %v2772 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2772)
  %v2773 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2773)
  %v2774 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2774)
  %v2775 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2775)
  br label %b87
b87:
  %v2776 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2776)
  %v2777 = getelementptr i64, ptr @"str.6", i64 0
  %v2778 = add i64 0, 3
  %v2779 = add i64 0, 0
  %v2780 = getelementptr i64, ptr %s23, i64 0
  %v2781 = ptrtoint ptr %v2777 to i64
  %st904 = getelementptr i64, ptr %v2780, i64 0
  store i64 %v2781, ptr %st904
  %st905 = getelementptr i64, ptr %v2780, i64 1
  store i64 %v2778, ptr %st905
  %st906 = getelementptr i64, ptr %v2780, i64 2
  store i64 %v2779, ptr %st906
  %v2782.p = getelementptr i64, ptr %v2780, i64 0
  %v2782 = load i64, ptr %v2782.p
  %v2783.p = getelementptr i64, ptr %v2780, i64 1
  %v2783 = load i64, ptr %v2783.p
  %v2784.p = getelementptr i64, ptr %v2780, i64 2
  %v2784 = load i64, ptr %v2784.p
  %v2785 = getelementptr i64, ptr @"str.7", i64 0
  %v2786 = add i64 0, 4
  %v2787 = add i64 0, 0
  %v2788 = getelementptr i64, ptr %s1, i64 0
  %v2789 = ptrtoint ptr %v2785 to i64
  %st907 = getelementptr i64, ptr %v2788, i64 0
  store i64 %v2789, ptr %st907
  %st908 = getelementptr i64, ptr %v2788, i64 1
  store i64 %v2786, ptr %st908
  %st909 = getelementptr i64, ptr %v2788, i64 2
  store i64 %v2787, ptr %st909
  %v2790.p = getelementptr i64, ptr %v2788, i64 0
  %v2790 = load i64, ptr %v2790.p
  %v2791.p = getelementptr i64, ptr %v2788, i64 1
  %v2791 = load i64, ptr %v2791.p
  %v2792.p = getelementptr i64, ptr %v2788, i64 2
  %v2792 = load i64, ptr %v2792.p
  %v2793 = call i64 @"std/strings.EqualFold"(i64 %v2782, i64 %v2783, i64 %v2784, i64 %v2790, i64 %v2791, i64 %v2792)
  %c.b87 = icmp ne i64 %v2793, 0
  br i1 %c.b87, label %b87.t911, label %b87.e912
b87.t911:
  br label %b88
b87.e912:
  br label %b89
b88:
  %v2794 = add i64 0, 116
  call void @"rt.print_char"(i64 %v2794)
  %v2795 = add i64 0, 114
  call void @"rt.print_char"(i64 %v2795)
  %v2796 = add i64 0, 117
  call void @"rt.print_char"(i64 %v2796)
  %v2797 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2797)
  br label %b90
b89:
  %v2798 = add i64 0, 102
  call void @"rt.print_char"(i64 %v2798)
  %v2799 = add i64 0, 97
  call void @"rt.print_char"(i64 %v2799)
  %v2800 = add i64 0, 108
  call void @"rt.print_char"(i64 %v2800)
  %v2801 = add i64 0, 115
  call void @"rt.print_char"(i64 %v2801)
  %v2802 = add i64 0, 101
  call void @"rt.print_char"(i64 %v2802)
  br label %b90
b90:
  %v2803 = add i64 0, 10
  call void @"rt.print_char"(i64 %v2803)
  %v2805 = getelementptr i64, ptr @"rt.meta", i64 0
  %st912 = getelementptr i64, ptr %v2805, i64 0
  store i64 %v0, ptr %st912
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
  %v28 = add i64 0, 53
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
  %v34 = add i64 0, 50
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
  %v36 = add i64 0, 51
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
  %v39 = add i64 0, 52
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

define internal void @"std/strings.TrimSuffix"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v55 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v55, i64 0
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
  %v25.p = getelementptr i64, ptr %v10, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v14, i64 1
  %v26 = load i64, ptr %v26.p
  %v27 = sub i64 %v25, %v26
  %v28.p = getelementptr i64, ptr %v14, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v14, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v14, i64 2
  %v30 = load i64, ptr %v30.p
  %v31 = call i64 @"std/strings.hasPrefixAt"(i64 %v22, i64 %v23, i64 %v24, i64 %v27, i64 %v28, i64 %v29, i64 %v30)
  br label %b2
b2:
  %v21 = phi i64 [ %v20, %b0.e14 ], [ %v31, %b1 ]
  %c.b2 = icmp ne i64 %v21, 0
  br i1 %c.b2, label %b2.t15, label %b2.e16
b2.t15:
  br label %b3
b2.e16:
  br label %b4
b3:
  %v32 = add i64 0, 0
  %v33.p = getelementptr i64, ptr %v10, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v14, i64 1
  %v34 = load i64, ptr %v34.p
  %v35 = sub i64 %v33, %v34
  %v36 = add i64 0, 0
  %v37.c = icmp slt i64 %v32, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b3 = icmp ne i64 %v37, 0
  br i1 %c.b3, label %b3.t17, label %b3.e18
b3.t17:
  br label %b5
b3.e18:
  br label %b6
b4:
  br label %b11
b5:
  %v38 = add i64 0, 35
  call void @"rt.panic"(i64 %v38)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v39.c = icmp slt i64 %v35, %v32
  %v39 = zext i1 %v39.c to i64
  %c.b6 = icmp ne i64 %v39, 0
  br i1 %c.b6, label %b6.t19, label %b6.e20
b6.t19:
  br label %b7
b6.e20:
  br label %b8
b7:
  %v40 = add i64 0, 36
  call void @"rt.panic"(i64 %v40)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v41.p = getelementptr i64, ptr %v10, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.c = icmp sgt i64 %v35, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b8 = icmp ne i64 %v42, 0
  br i1 %c.b8, label %b8.t21, label %b8.e22
b8.t21:
  br label %b9
b8.e22:
  br label %b10
b9:
  %v43 = add i64 0, 37
  call void @"rt.panic"(i64 %v43)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v44.p = getelementptr i64, ptr %v10, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = inttoptr i64 %v44 to ptr
  %v46 = getelementptr i8, ptr %v45, i64 %v32
  %v47 = sub i64 %v35, %v32
  %v48.p = getelementptr i64, ptr %v10, i64 2
  %v48 = load i64, ptr %v48.p
  %v49 = getelementptr i64, ptr %s4, i64 0
  %v50 = ptrtoint ptr %v46 to i64
  %st22 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st22
  %st23 = getelementptr i64, ptr %v49, i64 1
  store i64 %v47, ptr %st23
  %st24 = getelementptr i64, ptr %v49, i64 2
  store i64 %v48, ptr %st24
  br label %b11
b11:
  %v51 = phi ptr [ %v7, %b4 ], [ %v49, %b10 ]
  %v52.p = getelementptr i64, ptr %v51, i64 0
  %v52 = load i64, ptr %v52.p
  %st25 = getelementptr i64, ptr %v0, i64 0
  store i64 %v52, ptr %st25
  %v53.p = getelementptr i64, ptr %v51, i64 1
  %v53 = load i64, ptr %v53.p
  %st26 = getelementptr i64, ptr %v0, i64 1
  store i64 %v53, ptr %st26
  %v54.p = getelementptr i64, ptr %v51, i64 2
  %v54 = load i64, ptr %v54.p
  %st27 = getelementptr i64, ptr %v0, i64 2
  store i64 %v54, ptr %st27
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v56 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v56, i64 0
  store i64 %v9, ptr %st28
  ret void
}

define internal i64 @"std/strings.LastIndex"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v16 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v16, i64 0
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
  %v15 = call i64 @"std/strings.lastIndexAt"(i64 %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14)
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v17, i64 0
  store i64 %v8, ptr %st6
  ret i64 %v15
}

define internal void @"main.showSplit"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v35, i64 0
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
  call void @"std/strings.Split"(ptr %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14, i64 %v15)
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v9, i64 0
  %v17 = load i64, ptr %v17.p
  %st6 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st6
  %v18.p = getelementptr i64, ptr %v9, i64 1
  %v18 = load i64, ptr %v18.p
  %st7 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st7
  %v19.p = getelementptr i64, ptr %v9, i64 2
  %v19 = load i64, ptr %v19.p
  %st8 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st8
  %v20.p = getelementptr i64, ptr %v16, i64 1
  %v20 = load i64, ptr %v20.p
  %v21 = getelementptr i64, ptr %s4, i64 0
  %v22.p = getelementptr i64, ptr %v16, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v16, i64 1
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v16, i64 2
  %v24 = load i64, ptr %v24.p
  %v25 = getelementptr i64, ptr @"str.91", i64 0
  %v26 = add i64 0, 1
  %v27 = add i64 0, 0
  %v28 = getelementptr i64, ptr %s5, i64 0
  %v29 = ptrtoint ptr %v25 to i64
  %st9 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st9
  %st10 = getelementptr i64, ptr %v28, i64 1
  store i64 %v26, ptr %st10
  %st11 = getelementptr i64, ptr %v28, i64 2
  store i64 %v27, ptr %st11
  %v30.p = getelementptr i64, ptr %v28, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v28, i64 1
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v28, i64 2
  %v32 = load i64, ptr %v32.p
  call void @"std/strings.Join"(ptr %v21, i64 %v22, i64 %v23, i64 %v24, i64 %v30, i64 %v31, i64 %v32)
  call void @"rt.print_int"(i64 %v20)
  %v33 = add i64 0, 32
  call void @"rt.print_char"(i64 %v33)
  call void @"rt.print_str"(ptr %v21)
  %v34 = add i64 0, 10
  call void @"rt.print_char"(i64 %v34)
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v36, i64 0
  store i64 %v8, ptr %st12
  ret void
}

define internal void @"main.showFields"(i64 %v0, i64 %v1, i64 %v2) #0 {
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
  %v3 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v3, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v3, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v3, i64 2
  store i64 %v2, ptr %st2
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v28, i64 0
  %v4 = load i64, ptr %v4.p
  call void @"rt.region_enter"()
  %v5 = getelementptr i64, ptr %s1, i64 0
  %v6.p = getelementptr i64, ptr %v3, i64 0
  %v6 = load i64, ptr %v6.p
  %v7.p = getelementptr i64, ptr %v3, i64 1
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v3, i64 2
  %v8 = load i64, ptr %v8.p
  call void @"std/strings.Fields"(ptr %v5, i64 %v6, i64 %v7, i64 %v8)
  %v9 = getelementptr i64, ptr %s2, i64 0
  %v10.p = getelementptr i64, ptr %v5, i64 0
  %v10 = load i64, ptr %v10.p
  %st3 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st3
  %v11.p = getelementptr i64, ptr %v5, i64 1
  %v11 = load i64, ptr %v11.p
  %st4 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st4
  %v12.p = getelementptr i64, ptr %v5, i64 2
  %v12 = load i64, ptr %v12.p
  %st5 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st5
  %v13.p = getelementptr i64, ptr %v9, i64 1
  %v13 = load i64, ptr %v13.p
  %v14 = getelementptr i64, ptr %s3, i64 0
  %v15.p = getelementptr i64, ptr %v9, i64 0
  %v15 = load i64, ptr %v15.p
  %v16.p = getelementptr i64, ptr %v9, i64 1
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v9, i64 2
  %v17 = load i64, ptr %v17.p
  %v18 = getelementptr i64, ptr @"str.91", i64 0
  %v19 = add i64 0, 1
  %v20 = add i64 0, 0
  %v21 = getelementptr i64, ptr %s4, i64 0
  %v22 = ptrtoint ptr %v18 to i64
  %st6 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st6
  %st7 = getelementptr i64, ptr %v21, i64 1
  store i64 %v19, ptr %st7
  %st8 = getelementptr i64, ptr %v21, i64 2
  store i64 %v20, ptr %st8
  %v23.p = getelementptr i64, ptr %v21, i64 0
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v21, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v21, i64 2
  %v25 = load i64, ptr %v25.p
  call void @"std/strings.Join"(ptr %v14, i64 %v15, i64 %v16, i64 %v17, i64 %v23, i64 %v24, i64 %v25)
  call void @"rt.print_int"(i64 %v13)
  %v26 = add i64 0, 32
  call void @"rt.print_char"(i64 %v26)
  call void @"rt.print_str"(ptr %v14)
  %v27 = add i64 0, 10
  call void @"rt.print_char"(i64 %v27)
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v29, i64 0
  store i64 %v4, ptr %st9
  ret void
}

define internal void @"std/strings.TrimSpace"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v12.p = getelementptr i64, ptr %v6, i64 1
  %v12 = load i64, ptr %v12.p
  %v13 = getelementptr i64, ptr %s3, i64 0
  %st7 = getelementptr i64, ptr %v13, i64 0
  store i64 %v12, ptr %st7
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v81, i64 0
  %v14 = load i64, ptr %v14.p
  br label %b1
b1:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v82, i64 0
  store i64 %v14, ptr %st8
  %v15.p = getelementptr i64, ptr %v11, i64 0
  %v15 = load i64, ptr %v15.p
  %v16.p = getelementptr i64, ptr %v13, i64 0
  %v16 = load i64, ptr %v16.p
  %v17.c = icmp slt i64 %v15, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b1 = icmp ne i64 %v17, 0
  br i1 %c.b1, label %b1.t10, label %b1.e11
b1.t10:
  br label %b4
b1.e11:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v83, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 1
  %v30.p = getelementptr i64, ptr %v11, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 %v30, %v29
  %st11 = getelementptr i64, ptr %v11, i64 0
  store i64 %v31, ptr %st11
  br label %b1
b3:
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v84, i64 0
  store i64 %v14, ptr %st12
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v85, i64 0
  %v32 = load i64, ptr %v32.p
  br label %b8
b4:
  %v19.p = getelementptr i64, ptr %v11, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v6, i64 1
  %v20 = load i64, ptr %v20.p
  %v21.c = icmp uge i64 %v19, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b4 = icmp ne i64 %v21, 0
  br i1 %c.b4, label %b4.t14, label %b4.e15
b4.t14:
  br label %b6
b4.e15:
  br label %b7
b5:
  %v18 = phi i64 [ %v17, %b1.e11 ], [ %v27, %b7 ]
  %c.b5 = icmp ne i64 %v18, 0
  br i1 %c.b5, label %b5.t16, label %b5.e17
b5.t16:
  br label %b2
b5.e17:
  br label %b3
b6:
  %v22 = add i64 0, 13
  call void @"rt.panic"(i64 %v22)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v23.p = getelementptr i64, ptr %v6, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = inttoptr i64 %v23 to ptr
  %v25 = getelementptr i8, ptr %v24, i64 %v19
  %v26.p = getelementptr i8, ptr %v25, i64 0
  %v26.b = load i8, ptr %v26.p
  %v26 = zext i8 %v26.b to i64
  %v27 = call i64 @"std/strings.isSpace"(i64 %v26)
  br label %b5
b8:
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v86, i64 0
  store i64 %v32, ptr %st17
  %v33.p = getelementptr i64, ptr %v13, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v11, i64 0
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp sgt i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b8 = icmp ne i64 %v35, 0
  br i1 %c.b8, label %b8.t19, label %b8.e20
b8.t19:
  br label %b11
b8.e20:
  br label %b12
b9:
  call void @"rt.region_enter"()
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %v48.p = getelementptr i64, ptr %v87, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 1
  %v50.p = getelementptr i64, ptr %v13, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = sub i64 %v50, %v49
  %st20 = getelementptr i64, ptr %v13, i64 0
  store i64 %v51, ptr %st20
  br label %b8
b10:
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v88, i64 0
  store i64 %v32, ptr %st21
  %v52.p = getelementptr i64, ptr %v11, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 0
  %v54.c = icmp eq i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b10 = icmp ne i64 %v54, 0
  br i1 %c.b10, label %b10.t23, label %b10.e24
b10.t23:
  br label %b15
b10.e24:
  br label %b16
b11:
  %v37.p = getelementptr i64, ptr %v13, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 1
  %v39 = sub i64 %v37, %v38
  %v40.p = getelementptr i64, ptr %v6, i64 1
  %v40 = load i64, ptr %v40.p
  %v41.c = icmp uge i64 %v39, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b11 = icmp ne i64 %v41, 0
  br i1 %c.b11, label %b11.t25, label %b11.e26
b11.t25:
  br label %b13
b11.e26:
  br label %b14
b12:
  %v36 = phi i64 [ %v35, %b8.e20 ], [ %v47, %b14 ]
  %c.b12 = icmp ne i64 %v36, 0
  br i1 %c.b12, label %b12.t27, label %b12.e28
b12.t27:
  br label %b9
b12.e28:
  br label %b10
b13:
  %v42 = add i64 0, 14
  call void @"rt.panic"(i64 %v42)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v43.p = getelementptr i64, ptr %v6, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = inttoptr i64 %v43 to ptr
  %v45 = getelementptr i8, ptr %v44, i64 %v39
  %v46.p = getelementptr i8, ptr %v45, i64 0
  %v46.b = load i8, ptr %v46.p
  %v46 = zext i8 %v46.b to i64
  %v47 = call i64 @"std/strings.isSpace"(i64 %v46)
  br label %b12
b15:
  %v56.p = getelementptr i64, ptr %v13, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v6, i64 1
  %v57 = load i64, ptr %v57.p
  %v58.c = icmp eq i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  br label %b16
b16:
  %v55 = phi i64 [ %v54, %b10.e24 ], [ %v58, %b15 ]
  %c.b16 = icmp ne i64 %v55, 0
  br i1 %c.b16, label %b16.t29, label %b16.e30
b16.t29:
  br label %b17
b16.e30:
  br label %b18
b17:
  br label %b25
b18:
  %v59.p = getelementptr i64, ptr %v11, i64 0
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v13, i64 0
  %v60 = load i64, ptr %v60.p
  %v61 = add i64 0, 0
  %v62.c = icmp slt i64 %v59, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b18 = icmp ne i64 %v62, 0
  br i1 %c.b18, label %b18.t31, label %b18.e32
b18.t31:
  br label %b19
b18.e32:
  br label %b20
b19:
  %v63 = add i64 0, 15
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v64.c = icmp slt i64 %v60, %v59
  %v64 = zext i1 %v64.c to i64
  %c.b20 = icmp ne i64 %v64, 0
  br i1 %c.b20, label %b20.t33, label %b20.e34
b20.t33:
  br label %b21
b20.e34:
  br label %b22
b21:
  %v65 = add i64 0, 16
  call void @"rt.panic"(i64 %v65)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b22:
  %v66.p = getelementptr i64, ptr %v6, i64 1
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp sgt i64 %v60, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b22 = icmp ne i64 %v67, 0
  br i1 %c.b22, label %b22.t35, label %b22.e36
b22.t35:
  br label %b23
b22.e36:
  br label %b24
b23:
  %v68 = add i64 0, 17
  call void @"rt.panic"(i64 %v68)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b24:
  %v69.p = getelementptr i64, ptr %v6, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = inttoptr i64 %v69 to ptr
  %v71 = getelementptr i8, ptr %v70, i64 %v59
  %v72 = sub i64 %v60, %v59
  %v73.p = getelementptr i64, ptr %v6, i64 2
  %v73 = load i64, ptr %v73.p
  %v74 = getelementptr i64, ptr %s4, i64 0
  %v75 = ptrtoint ptr %v71 to i64
  %st36 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st36
  %st37 = getelementptr i64, ptr %v74, i64 1
  store i64 %v72, ptr %st37
  %st38 = getelementptr i64, ptr %v74, i64 2
  store i64 %v73, ptr %st38
  br label %b25
b25:
  %v76 = phi ptr [ %v4, %b17 ], [ %v74, %b24 ]
  %v77.p = getelementptr i64, ptr %v76, i64 0
  %v77 = load i64, ptr %v77.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v77, ptr %st39
  %v78.p = getelementptr i64, ptr %v76, i64 1
  %v78 = load i64, ptr %v78.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v78, ptr %st40
  %v79.p = getelementptr i64, ptr %v76, i64 2
  %v79 = load i64, ptr %v79.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v79, ptr %st41
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v89, i64 0
  store i64 %v5, ptr %st42
  ret void
}

define internal void @"std/strings.Replace"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10) #0 {
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
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [1 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s10 = alloca [1 x i64], align 8
  %s10.z0 = getelementptr i64, ptr %s10, i64 0
  store i64 0, ptr %s10.z0
  %s11 = alloca [1 x i64], align 8
  %s11.z0 = getelementptr i64, ptr %s11, i64 0
  store i64 0, ptr %s11.z0
  %s12 = alloca [3 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
  %s13 = alloca [1 x i64], align 8
  %s13.z0 = getelementptr i64, ptr %s13, i64 0
  store i64 0, ptr %s13.z0
  %v11 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v11, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v11, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v11, i64 2
  store i64 %v3, ptr %st2
  %v12 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v12, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v12, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v12, i64 2
  store i64 %v6, ptr %st5
  %v13 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v13, i64 0
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 1
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v13, i64 2
  store i64 %v9, ptr %st8
  %v265 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v265, i64 0
  %v14 = load i64, ptr %v14.p
  call void @"rt.region_enter"()
  %v15 = getelementptr i64, ptr %s3, i64 0
  %v16.p = getelementptr i64, ptr %v11, i64 0
  %v16 = load i64, ptr %v16.p
  %st9 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st9
  %v17.p = getelementptr i64, ptr %v11, i64 1
  %v17 = load i64, ptr %v17.p
  %st10 = getelementptr i64, ptr %v15, i64 1
  store i64 %v17, ptr %st10
  %v18.p = getelementptr i64, ptr %v11, i64 2
  %v18 = load i64, ptr %v18.p
  %st11 = getelementptr i64, ptr %v15, i64 2
  store i64 %v18, ptr %st11
  %v19 = getelementptr i64, ptr %s4, i64 0
  %v20.p = getelementptr i64, ptr %v12, i64 0
  %v20 = load i64, ptr %v20.p
  %st12 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st12
  %v21.p = getelementptr i64, ptr %v12, i64 1
  %v21 = load i64, ptr %v21.p
  %st13 = getelementptr i64, ptr %v19, i64 1
  store i64 %v21, ptr %st13
  %v22.p = getelementptr i64, ptr %v12, i64 2
  %v22 = load i64, ptr %v22.p
  %st14 = getelementptr i64, ptr %v19, i64 2
  store i64 %v22, ptr %st14
  %v23 = getelementptr i64, ptr %s5, i64 0
  %v24.p = getelementptr i64, ptr %v13, i64 0
  %v24 = load i64, ptr %v24.p
  %st15 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st15
  %v25.p = getelementptr i64, ptr %v13, i64 1
  %v25 = load i64, ptr %v25.p
  %st16 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st16
  %v26.p = getelementptr i64, ptr %v13, i64 2
  %v26 = load i64, ptr %v26.p
  %st17 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st17
  %v27 = add i64 0, 0
  %v28.c = icmp eq i64 %v10, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b0 = icmp ne i64 %v28, 0
  br i1 %c.b0, label %b0.t19, label %b0.e20
b0.t19:
  br label %b1
b0.e20:
  br label %b2
b1:
  %v29.p = getelementptr i64, ptr %v11, i64 0
  %v29 = load i64, ptr %v29.p
  %st20 = getelementptr i64, ptr %v0, i64 0
  store i64 %v29, ptr %st20
  %v30.p = getelementptr i64, ptr %v11, i64 1
  %v30 = load i64, ptr %v30.p
  %st21 = getelementptr i64, ptr %v0, i64 1
  store i64 %v30, ptr %st21
  %v31.p = getelementptr i64, ptr %v11, i64 2
  %v31 = load i64, ptr %v31.p
  %st22 = getelementptr i64, ptr %v0, i64 2
  store i64 %v31, ptr %st22
  call void @"rt.region_relocate8"(ptr %v0, i64 %v14)
  %v266 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v266, i64 0
  store i64 %v14, ptr %st23
  ret void
b2:
  br label %b3
b3:
  %v32.p = getelementptr i64, ptr %v19, i64 1
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 0
  %v34.c = icmp sgt i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b3 = icmp ne i64 %v34, 0
  br i1 %c.b3, label %b3.t25, label %b3.e26
b3.t25:
  br label %b4
b3.e26:
  br label %b5
b4:
  %v36.p = getelementptr i64, ptr %v15, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v15, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v15, i64 2
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40.p = getelementptr i64, ptr %v19, i64 0
  %v40 = load i64, ptr %v40.p
  %v41.p = getelementptr i64, ptr %v19, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v19, i64 2
  %v42 = load i64, ptr %v42.p
  %v43 = call i64 @"std/strings.indexAt"(i64 %v36, i64 %v37, i64 %v38, i64 %v39, i64 %v40, i64 %v41, i64 %v42)
  %v44 = add i64 0, 0
  %v45.c = icmp slt i64 %v43, %v44
  %v45 = zext i1 %v45.c to i64
  br label %b5
b5:
  %v35 = phi i64 [ %v34, %b3.e26 ], [ %v45, %b4 ]
  %c.b5 = icmp ne i64 %v35, 0
  br i1 %c.b5, label %b5.t27, label %b5.e28
b5.t27:
  br label %b6
b5.e28:
  br label %b7
b6:
  %v46.p = getelementptr i64, ptr %v11, i64 0
  %v46 = load i64, ptr %v46.p
  %st28 = getelementptr i64, ptr %v0, i64 0
  store i64 %v46, ptr %st28
  %v47.p = getelementptr i64, ptr %v11, i64 1
  %v47 = load i64, ptr %v47.p
  %st29 = getelementptr i64, ptr %v0, i64 1
  store i64 %v47, ptr %st29
  %v48.p = getelementptr i64, ptr %v11, i64 2
  %v48 = load i64, ptr %v48.p
  %st30 = getelementptr i64, ptr %v0, i64 2
  store i64 %v48, ptr %st30
  call void @"rt.region_relocate8"(ptr %v0, i64 %v14)
  %v267 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v267, i64 0
  store i64 %v14, ptr %st31
  ret void
b7:
  br label %b8
b8:
  %v268 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v268, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51 = call ptr @"rt.region_alloc8"(i64 %v49, i64 %v50)
  %v52 = add i64 0, 0
  %v53 = getelementptr i64, ptr %s6, i64 0
  %v54 = ptrtoint ptr %v51 to i64
  %st32 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st32
  %st33 = getelementptr i64, ptr %v53, i64 1
  store i64 %v52, ptr %st33
  %st34 = getelementptr i64, ptr %v53, i64 2
  store i64 %v49, ptr %st34
  %v55 = getelementptr i64, ptr %s7, i64 0
  %v56.p = getelementptr i64, ptr %v53, i64 0
  %v56 = load i64, ptr %v56.p
  %st35 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st35
  %v57.p = getelementptr i64, ptr %v53, i64 1
  %v57 = load i64, ptr %v57.p
  %st36 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st36
  %v58.p = getelementptr i64, ptr %v53, i64 2
  %v58 = load i64, ptr %v58.p
  %st37 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st37
  %v59 = add i64 0, 0
  %v60 = getelementptr i64, ptr %s8, i64 0
  %st38 = getelementptr i64, ptr %v60, i64 0
  store i64 %v59, ptr %st38
  %v61 = add i64 0, 0
  %v62 = getelementptr i64, ptr %s9, i64 0
  %st39 = getelementptr i64, ptr %v62, i64 0
  store i64 %v61, ptr %st39
  %v63.p = getelementptr i64, ptr %v19, i64 1
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 0, 0
  %v65.c = icmp eq i64 %v63, %v64
  %v65 = zext i1 %v65.c to i64
  %c.b8 = icmp ne i64 %v65, 0
  br i1 %c.b8, label %b8.t41, label %b8.e42
b8.t41:
  br label %b9
b8.e42:
  br label %b10
b9:
  %v66 = add i64 0, 0
  br label %b11
b10:
  %v67.p = getelementptr i64, ptr %v15, i64 0
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v15, i64 1
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v15, i64 2
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 0
  %v71.p = getelementptr i64, ptr %v19, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v19, i64 1
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v19, i64 2
  %v73 = load i64, ptr %v73.p
  %v74 = call i64 @"std/strings.indexAt"(i64 %v67, i64 %v68, i64 %v69, i64 %v70, i64 %v71, i64 %v72, i64 %v73)
  br label %b11
b11:
  %v75 = phi i64 [ %v66, %b9 ], [ %v74, %b10 ]
  %v76 = getelementptr i64, ptr %s10, i64 0
  %st42 = getelementptr i64, ptr %v76, i64 0
  store i64 %v75, ptr %st42
  %v269 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v269, i64 0
  %v77 = load i64, ptr %v77.p
  br label %b12
b12:
  %v270 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v270, i64 0
  store i64 %v77, ptr %st43
  %v78.p = getelementptr i64, ptr %v76, i64 0
  %v78 = load i64, ptr %v78.p
  %v79 = add i64 0, 0
  %v80.c = icmp sge i64 %v78, %v79
  %v80 = zext i1 %v80.c to i64
  %c.b12 = icmp ne i64 %v80, 0
  br i1 %c.b12, label %b12.t45, label %b12.e46
b12.t45:
  br label %b15
b12.e46:
  br label %b16
b13:
  call void @"rt.region_enter"()
  %v271 = getelementptr i64, ptr @"rt.meta", i64 0
  %v87.p = getelementptr i64, ptr %v271, i64 0
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v62, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = getelementptr i64, ptr %s11, i64 0
  %st46 = getelementptr i64, ptr %v89, i64 0
  store i64 %v88, ptr %st46
  %v272 = getelementptr i64, ptr @"rt.meta", i64 0
  %v90.p = getelementptr i64, ptr %v272, i64 0
  %v90 = load i64, ptr %v90.p
  br label %b19
b14:
  %v273 = getelementptr i64, ptr @"rt.meta", i64 0
  %st47 = getelementptr i64, ptr %v273, i64 0
  store i64 %v77, ptr %st47
  %v274 = getelementptr i64, ptr @"rt.meta", i64 0
  %v218.p = getelementptr i64, ptr %v274, i64 0
  %v218 = load i64, ptr %v218.p
  br label %b41
b15:
  %v82 = add i64 0, 0
  %v83.c = icmp slt i64 %v10, %v82
  %v83 = zext i1 %v83.c to i64
  %c.b15 = icmp ne i64 %v83, 0
  br i1 %c.b15, label %b15.t49, label %b15.e50
b15.t49:
  br label %b18
b15.e50:
  br label %b17
b16:
  %v81 = phi i64 [ %v80, %b12.e46 ], [ %v84, %b18 ]
  %c.b16 = icmp ne i64 %v81, 0
  br i1 %c.b16, label %b16.t51, label %b16.e52
b16.t51:
  br label %b13
b16.e52:
  br label %b14
b17:
  %v85.p = getelementptr i64, ptr %v60, i64 0
  %v85 = load i64, ptr %v85.p
  %v86.c = icmp slt i64 %v85, %v10
  %v86 = zext i1 %v86.c to i64
  br label %b18
b18:
  %v84 = phi i64 [ %v83, %b15.t49 ], [ %v86, %b17 ]
  br label %b16
b19:
  %v275 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v275, i64 0
  store i64 %v90, ptr %st52
  %v91.p = getelementptr i64, ptr %v89, i64 0
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v76, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.c = icmp slt i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b19 = icmp ne i64 %v93, 0
  br i1 %c.b19, label %b19.t54, label %b19.e55
b19.t54:
  br label %b20
b19.e55:
  br label %b21
b20:
  call void @"rt.region_enter"()
  %v276 = getelementptr i64, ptr @"rt.meta", i64 0
  %v94.p = getelementptr i64, ptr %v276, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 0, 1
  %v96 = add i64 %v14, %v95
  %v97 = getelementptr i64, ptr %s6, i64 0
  %v98.p = getelementptr i64, ptr %v55, i64 0
  %v98 = load i64, ptr %v98.p
  %st55 = getelementptr i64, ptr %v97, i64 0
  store i64 %v98, ptr %st55
  %v99.p = getelementptr i64, ptr %v55, i64 1
  %v99 = load i64, ptr %v99.p
  %st56 = getelementptr i64, ptr %v97, i64 1
  store i64 %v99, ptr %st56
  %v100.p = getelementptr i64, ptr %v55, i64 2
  %v100 = load i64, ptr %v100.p
  %st57 = getelementptr i64, ptr %v97, i64 2
  store i64 %v100, ptr %st57
  %v101.p = getelementptr i64, ptr %v89, i64 0
  %v101 = load i64, ptr %v101.p
  %v102.p = getelementptr i64, ptr %v15, i64 1
  %v102 = load i64, ptr %v102.p
  %v103.c = icmp uge i64 %v101, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b20 = icmp ne i64 %v103, 0
  br i1 %c.b20, label %b20.t59, label %b20.e60
b20.t59:
  br label %b22
b20.e60:
  br label %b23
b21:
  %v277 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v277, i64 0
  store i64 %v90, ptr %st60
  %v134 = add i64 0, 0
  %v135 = getelementptr i64, ptr %s13, i64 0
  %st61 = getelementptr i64, ptr %v135, i64 0
  store i64 %v134, ptr %st61
  %v278 = getelementptr i64, ptr @"rt.meta", i64 0
  %v136.p = getelementptr i64, ptr %v278, i64 0
  %v136 = load i64, ptr %v136.p
  br label %b27
b22:
  %v104 = add i64 0, 7
  call void @"rt.panic"(i64 %v104)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v105.p = getelementptr i64, ptr %v15, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = inttoptr i64 %v105 to ptr
  %v107 = getelementptr i8, ptr %v106, i64 %v101
  %v108.p = getelementptr i8, ptr %v107, i64 0
  %v108.b = load i8, ptr %v108.p
  %v108 = zext i8 %v108.b to i64
  %v109.p = getelementptr i64, ptr %v97, i64 2
  %v109 = load i64, ptr %v109.p
  %v110.p = getelementptr i64, ptr %v97, i64 0
  %v110 = load i64, ptr %v110.p
  %v111.p = getelementptr i64, ptr %v97, i64 1
  %v111 = load i64, ptr %v111.p
  %v114 = add i64 %v110, %v111
  %v115 = call i64 @"rt.tip8"(i64 %v109, i64 %v114)
  %v116 = add i64 0, 0
  %v117.c = icmp ne i64 %v115, %v116
  %v117 = zext i1 %v117.c to i64
  %c.b23 = icmp ne i64 %v117, 0
  br i1 %c.b23, label %b23.t63, label %b23.e64
b23.t63:
  br label %b26
b23.e64:
  br label %b25
b24:
  %v112 = phi ptr [ %v121, %b25 ], [ %v118, %b26 ]
  %v113 = phi ptr [ %v122, %b25 ], [ %v119, %b26 ]
  %st64 = getelementptr i8, ptr %v113, i64 0
  %st64.b = trunc i64 %v108 to i8
  store i8 %st64.b, ptr %st64
  %v123.p = getelementptr i64, ptr %v97, i64 1
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 0, 1
  %v125 = add i64 %v123, %v124
  %v126 = getelementptr i64, ptr %s12, i64 0
  %v127 = ptrtoint ptr %v112 to i64
  %st65 = getelementptr i64, ptr %v126, i64 0
  store i64 %v127, ptr %st65
  %st66 = getelementptr i64, ptr %v126, i64 1
  store i64 %v125, ptr %st66
  %st67 = getelementptr i64, ptr %v126, i64 2
  store i64 %v109, ptr %st67
  %v128.p = getelementptr i64, ptr %v126, i64 0
  %v128 = load i64, ptr %v128.p
  %st68 = getelementptr i64, ptr %v55, i64 0
  store i64 %v128, ptr %st68
  %v129.p = getelementptr i64, ptr %v126, i64 1
  %v129 = load i64, ptr %v129.p
  %st69 = getelementptr i64, ptr %v55, i64 1
  store i64 %v129, ptr %st69
  %v130.p = getelementptr i64, ptr %v126, i64 2
  %v130 = load i64, ptr %v130.p
  %st70 = getelementptr i64, ptr %v55, i64 2
  store i64 %v130, ptr %st70
  %v131 = add i64 0, 1
  %v132.p = getelementptr i64, ptr %v89, i64 0
  %v132 = load i64, ptr %v132.p
  %v133 = add i64 %v132, %v131
  %st71 = getelementptr i64, ptr %v89, i64 0
  store i64 %v133, ptr %st71
  br label %b19
b25:
  %v120 = add i64 0, 1
  %v121 = call ptr @"rt.slice_grow8"(i64 %v110, i64 %v111, i64 %v109, i64 %v120)
  %v122 = getelementptr i8, ptr %v121, i64 %v111
  br label %b24
b26:
  %v118 = inttoptr i64 %v110 to ptr
  %v119 = getelementptr i8, ptr %v118, i64 %v111
  br label %b24
b27:
  %v279 = getelementptr i64, ptr @"rt.meta", i64 0
  %st72 = getelementptr i64, ptr %v279, i64 0
  store i64 %v136, ptr %st72
  %v137.p = getelementptr i64, ptr %v135, i64 0
  %v137 = load i64, ptr %v137.p
  %v138.p = getelementptr i64, ptr %v23, i64 1
  %v138 = load i64, ptr %v138.p
  %v139.c = icmp slt i64 %v137, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b27 = icmp ne i64 %v139, 0
  br i1 %c.b27, label %b27.t74, label %b27.e75
b27.t74:
  br label %b28
b27.e75:
  br label %b29
b28:
  call void @"rt.region_enter"()
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %v140.p = getelementptr i64, ptr %v280, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = add i64 0, 1
  %v142 = add i64 %v14, %v141
  %v143 = getelementptr i64, ptr %s12, i64 0
  %v144.p = getelementptr i64, ptr %v55, i64 0
  %v144 = load i64, ptr %v144.p
  %st75 = getelementptr i64, ptr %v143, i64 0
  store i64 %v144, ptr %st75
  %v145.p = getelementptr i64, ptr %v55, i64 1
  %v145 = load i64, ptr %v145.p
  %st76 = getelementptr i64, ptr %v143, i64 1
  store i64 %v145, ptr %st76
  %v146.p = getelementptr i64, ptr %v55, i64 2
  %v146 = load i64, ptr %v146.p
  %st77 = getelementptr i64, ptr %v143, i64 2
  store i64 %v146, ptr %st77
  %v147.p = getelementptr i64, ptr %v135, i64 0
  %v147 = load i64, ptr %v147.p
  %v148.p = getelementptr i64, ptr %v23, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.c = icmp uge i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b28 = icmp ne i64 %v149, 0
  br i1 %c.b28, label %b28.t79, label %b28.e80
b28.t79:
  br label %b30
b28.e80:
  br label %b31
b29:
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v281, i64 0
  store i64 %v136, ptr %st80
  %v180 = add i64 0, 1
  %v181.p = getelementptr i64, ptr %v60, i64 0
  %v181 = load i64, ptr %v181.p
  %v182 = add i64 %v181, %v180
  %st81 = getelementptr i64, ptr %v60, i64 0
  store i64 %v182, ptr %st81
  %v183.p = getelementptr i64, ptr %v19, i64 1
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 0
  %v185.c = icmp eq i64 %v183, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b29 = icmp ne i64 %v185, 0
  br i1 %c.b29, label %b29.t83, label %b29.e84
b29.t83:
  br label %b35
b29.e84:
  br label %b36
b30:
  %v150 = add i64 0, 8
  call void @"rt.panic"(i64 %v150)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b31:
  %v151.p = getelementptr i64, ptr %v23, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = inttoptr i64 %v151 to ptr
  %v153 = getelementptr i8, ptr %v152, i64 %v147
  %v154.p = getelementptr i8, ptr %v153, i64 0
  %v154.b = load i8, ptr %v154.p
  %v154 = zext i8 %v154.b to i64
  %v155.p = getelementptr i64, ptr %v143, i64 2
  %v155 = load i64, ptr %v155.p
  %v156.p = getelementptr i64, ptr %v143, i64 0
  %v156 = load i64, ptr %v156.p
  %v157.p = getelementptr i64, ptr %v143, i64 1
  %v157 = load i64, ptr %v157.p
  %v160 = add i64 %v156, %v157
  %v161 = call i64 @"rt.tip8"(i64 %v155, i64 %v160)
  %v162 = add i64 0, 0
  %v163.c = icmp ne i64 %v161, %v162
  %v163 = zext i1 %v163.c to i64
  %c.b31 = icmp ne i64 %v163, 0
  br i1 %c.b31, label %b31.t85, label %b31.e86
b31.t85:
  br label %b34
b31.e86:
  br label %b33
b32:
  %v158 = phi ptr [ %v167, %b33 ], [ %v164, %b34 ]
  %v159 = phi ptr [ %v168, %b33 ], [ %v165, %b34 ]
  %st86 = getelementptr i8, ptr %v159, i64 0
  %st86.b = trunc i64 %v154 to i8
  store i8 %st86.b, ptr %st86
  %v169.p = getelementptr i64, ptr %v143, i64 1
  %v169 = load i64, ptr %v169.p
  %v170 = add i64 0, 1
  %v171 = add i64 %v169, %v170
  %v172 = getelementptr i64, ptr %s6, i64 0
  %v173 = ptrtoint ptr %v158 to i64
  %st87 = getelementptr i64, ptr %v172, i64 0
  store i64 %v173, ptr %st87
  %st88 = getelementptr i64, ptr %v172, i64 1
  store i64 %v171, ptr %st88
  %st89 = getelementptr i64, ptr %v172, i64 2
  store i64 %v155, ptr %st89
  %v174.p = getelementptr i64, ptr %v172, i64 0
  %v174 = load i64, ptr %v174.p
  %st90 = getelementptr i64, ptr %v55, i64 0
  store i64 %v174, ptr %st90
  %v175.p = getelementptr i64, ptr %v172, i64 1
  %v175 = load i64, ptr %v175.p
  %st91 = getelementptr i64, ptr %v55, i64 1
  store i64 %v175, ptr %st91
  %v176.p = getelementptr i64, ptr %v172, i64 2
  %v176 = load i64, ptr %v176.p
  %st92 = getelementptr i64, ptr %v55, i64 2
  store i64 %v176, ptr %st92
  %v177 = add i64 0, 1
  %v178.p = getelementptr i64, ptr %v135, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = add i64 %v178, %v177
  %st93 = getelementptr i64, ptr %v135, i64 0
  store i64 %v179, ptr %st93
  br label %b27
b33:
  %v166 = add i64 0, 1
  %v167 = call ptr @"rt.slice_grow8"(i64 %v156, i64 %v157, i64 %v155, i64 %v166)
  %v168 = getelementptr i8, ptr %v167, i64 %v157
  br label %b32
b34:
  %v164 = inttoptr i64 %v156 to ptr
  %v165 = getelementptr i8, ptr %v164, i64 %v157
  br label %b32
b35:
  %v186 = add i64 0, 1
  %v187 = add i64 %v14, %v186
  %v188.p = getelementptr i64, ptr %v76, i64 0
  %v188 = load i64, ptr %v188.p
  %st94 = getelementptr i64, ptr %v62, i64 0
  store i64 %v188, ptr %st94
  %v189 = add i64 0, 1
  %v190 = add i64 %v14, %v189
  %v191.p = getelementptr i64, ptr %v76, i64 0
  %v191 = load i64, ptr %v191.p
  %v192.p = getelementptr i64, ptr %v15, i64 1
  %v192 = load i64, ptr %v192.p
  %v193.c = icmp eq i64 %v191, %v192
  %v193 = zext i1 %v193.c to i64
  %c.b35 = icmp ne i64 %v193, 0
  br i1 %c.b35, label %b35.t96, label %b35.e97
b35.t96:
  br label %b37
b35.e97:
  br label %b38
b36:
  %v203 = add i64 0, 1
  %v204 = add i64 %v14, %v203
  %v205.p = getelementptr i64, ptr %v76, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v19, i64 1
  %v206 = load i64, ptr %v206.p
  %v207 = add i64 %v205, %v206
  %st97 = getelementptr i64, ptr %v62, i64 0
  store i64 %v207, ptr %st97
  %v208 = add i64 0, 1
  %v209 = add i64 %v14, %v208
  %v210.p = getelementptr i64, ptr %v15, i64 0
  %v210 = load i64, ptr %v210.p
  %v211.p = getelementptr i64, ptr %v15, i64 1
  %v211 = load i64, ptr %v211.p
  %v212.p = getelementptr i64, ptr %v15, i64 2
  %v212 = load i64, ptr %v212.p
  %v213.p = getelementptr i64, ptr %v62, i64 0
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v19, i64 0
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v19, i64 1
  %v215 = load i64, ptr %v215.p
  %v216.p = getelementptr i64, ptr %v19, i64 2
  %v216 = load i64, ptr %v216.p
  %v217 = call i64 @"std/strings.indexAt"(i64 %v210, i64 %v211, i64 %v212, i64 %v213, i64 %v214, i64 %v215, i64 %v216)
  %st98 = getelementptr i64, ptr %v76, i64 0
  store i64 %v217, ptr %st98
  br label %b40
b37:
  %v194 = add i64 0, 1
  %v195 = add i64 0, 0
  %v196 = sub i64 %v195, %v194
  br label %b39
b38:
  %v197.p = getelementptr i64, ptr %v15, i64 0
  %v197 = load i64, ptr %v197.p
  %v198.p = getelementptr i64, ptr %v15, i64 1
  %v198 = load i64, ptr %v198.p
  %v199.p = getelementptr i64, ptr %v15, i64 2
  %v199 = load i64, ptr %v199.p
  %v200.p = getelementptr i64, ptr %v76, i64 0
  %v200 = load i64, ptr %v200.p
  %v201 = call i64 @"std/strings.runeEnd"(i64 %v197, i64 %v198, i64 %v199, i64 %v200)
  br label %b39
b39:
  %v202 = phi i64 [ %v196, %b37 ], [ %v201, %b38 ]
  %st99 = getelementptr i64, ptr %v76, i64 0
  store i64 %v202, ptr %st99
  br label %b40
b40:
  br label %b12
b41:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st100 = getelementptr i64, ptr %v282, i64 0
  store i64 %v218, ptr %st100
  %v219.p = getelementptr i64, ptr %v62, i64 0
  %v219 = load i64, ptr %v219.p
  %v220.p = getelementptr i64, ptr %v15, i64 1
  %v220 = load i64, ptr %v220.p
  %v221.c = icmp slt i64 %v219, %v220
  %v221 = zext i1 %v221.c to i64
  %c.b41 = icmp ne i64 %v221, 0
  br i1 %c.b41, label %b41.t102, label %b41.e103
b41.t102:
  br label %b42
b41.e103:
  br label %b43
b42:
  call void @"rt.region_enter"()
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %v222.p = getelementptr i64, ptr %v283, i64 0
  %v222 = load i64, ptr %v222.p
  %v223 = add i64 0, 1
  %v224 = add i64 %v14, %v223
  %v225 = getelementptr i64, ptr %s6, i64 0
  %v226.p = getelementptr i64, ptr %v55, i64 0
  %v226 = load i64, ptr %v226.p
  %st103 = getelementptr i64, ptr %v225, i64 0
  store i64 %v226, ptr %st103
  %v227.p = getelementptr i64, ptr %v55, i64 1
  %v227 = load i64, ptr %v227.p
  %st104 = getelementptr i64, ptr %v225, i64 1
  store i64 %v227, ptr %st104
  %v228.p = getelementptr i64, ptr %v55, i64 2
  %v228 = load i64, ptr %v228.p
  %st105 = getelementptr i64, ptr %v225, i64 2
  store i64 %v228, ptr %st105
  %v229.p = getelementptr i64, ptr %v62, i64 0
  %v229 = load i64, ptr %v229.p
  %v230.p = getelementptr i64, ptr %v15, i64 1
  %v230 = load i64, ptr %v230.p
  %v231.c = icmp uge i64 %v229, %v230
  %v231 = zext i1 %v231.c to i64
  %c.b42 = icmp ne i64 %v231, 0
  br i1 %c.b42, label %b42.t107, label %b42.e108
b42.t107:
  br label %b44
b42.e108:
  br label %b45
b43:
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %st108 = getelementptr i64, ptr %v284, i64 0
  store i64 %v218, ptr %st108
  %v262.p = getelementptr i64, ptr %v55, i64 0
  %v262 = load i64, ptr %v262.p
  %st109 = getelementptr i64, ptr %v0, i64 0
  store i64 %v262, ptr %st109
  %v263.p = getelementptr i64, ptr %v55, i64 1
  %v263 = load i64, ptr %v263.p
  %st110 = getelementptr i64, ptr %v0, i64 1
  store i64 %v263, ptr %st110
  %v264.p = getelementptr i64, ptr %v55, i64 2
  %v264 = load i64, ptr %v264.p
  %st111 = getelementptr i64, ptr %v0, i64 2
  store i64 %v264, ptr %st111
  call void @"rt.region_relocate8"(ptr %v0, i64 %v14)
  %v285 = getelementptr i64, ptr @"rt.meta", i64 0
  %st112 = getelementptr i64, ptr %v285, i64 0
  store i64 %v14, ptr %st112
  ret void
b44:
  %v232 = add i64 0, 9
  call void @"rt.panic"(i64 %v232)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b45:
  %v233.p = getelementptr i64, ptr %v15, i64 0
  %v233 = load i64, ptr %v233.p
  %v234 = inttoptr i64 %v233 to ptr
  %v235 = getelementptr i8, ptr %v234, i64 %v229
  %v236.p = getelementptr i8, ptr %v235, i64 0
  %v236.b = load i8, ptr %v236.p
  %v236 = zext i8 %v236.b to i64
  %v237.p = getelementptr i64, ptr %v225, i64 2
  %v237 = load i64, ptr %v237.p
  %v238.p = getelementptr i64, ptr %v225, i64 0
  %v238 = load i64, ptr %v238.p
  %v239.p = getelementptr i64, ptr %v225, i64 1
  %v239 = load i64, ptr %v239.p
  %v242 = add i64 %v238, %v239
  %v243 = call i64 @"rt.tip8"(i64 %v237, i64 %v242)
  %v244 = add i64 0, 0
  %v245.c = icmp ne i64 %v243, %v244
  %v245 = zext i1 %v245.c to i64
  %c.b45 = icmp ne i64 %v245, 0
  br i1 %c.b45, label %b45.t114, label %b45.e115
b45.t114:
  br label %b48
b45.e115:
  br label %b47
b46:
  %v240 = phi ptr [ %v249, %b47 ], [ %v246, %b48 ]
  %v241 = phi ptr [ %v250, %b47 ], [ %v247, %b48 ]
  %st115 = getelementptr i8, ptr %v241, i64 0
  %st115.b = trunc i64 %v236 to i8
  store i8 %st115.b, ptr %st115
  %v251.p = getelementptr i64, ptr %v225, i64 1
  %v251 = load i64, ptr %v251.p
  %v252 = add i64 0, 1
  %v253 = add i64 %v251, %v252
  %v254 = getelementptr i64, ptr %s12, i64 0
  %v255 = ptrtoint ptr %v240 to i64
  %st116 = getelementptr i64, ptr %v254, i64 0
  store i64 %v255, ptr %st116
  %st117 = getelementptr i64, ptr %v254, i64 1
  store i64 %v253, ptr %st117
  %st118 = getelementptr i64, ptr %v254, i64 2
  store i64 %v237, ptr %st118
  %v256.p = getelementptr i64, ptr %v254, i64 0
  %v256 = load i64, ptr %v256.p
  %st119 = getelementptr i64, ptr %v55, i64 0
  store i64 %v256, ptr %st119
  %v257.p = getelementptr i64, ptr %v254, i64 1
  %v257 = load i64, ptr %v257.p
  %st120 = getelementptr i64, ptr %v55, i64 1
  store i64 %v257, ptr %st120
  %v258.p = getelementptr i64, ptr %v254, i64 2
  %v258 = load i64, ptr %v258.p
  %st121 = getelementptr i64, ptr %v55, i64 2
  store i64 %v258, ptr %st121
  %v259 = add i64 0, 1
  %v260.p = getelementptr i64, ptr %v62, i64 0
  %v260 = load i64, ptr %v260.p
  %v261 = add i64 %v260, %v259
  %st122 = getelementptr i64, ptr %v62, i64 0
  store i64 %v261, ptr %st122
  br label %b41
b47:
  %v248 = add i64 0, 1
  %v249 = call ptr @"rt.slice_grow8"(i64 %v238, i64 %v239, i64 %v237, i64 %v248)
  %v250 = getelementptr i8, ptr %v249, i64 %v239
  br label %b46
b48:
  %v246 = inttoptr i64 %v238 to ptr
  %v247 = getelementptr i8, ptr %v246, i64 %v239
  br label %b46
}

define internal void @"std/strings.ToLower"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v16 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v16, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v4, i64 0
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v4, i64 2
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 65
  %v11 = add i64 0, 90
  %v12 = add i64 0, 32
  call void @"std/strings.mapCase"(ptr %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12)
  %v13.p = getelementptr i64, ptr %v6, i64 0
  %v13 = load i64, ptr %v13.p
  %st3 = getelementptr i64, ptr %v0, i64 0
  store i64 %v13, ptr %st3
  %v14.p = getelementptr i64, ptr %v6, i64 1
  %v14 = load i64, ptr %v14.p
  %st4 = getelementptr i64, ptr %v0, i64 1
  store i64 %v14, ptr %st4
  %v15.p = getelementptr i64, ptr %v6, i64 2
  %v15 = load i64, ptr %v15.p
  %st5 = getelementptr i64, ptr %v0, i64 2
  store i64 %v15, ptr %st5
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v17, i64 0
  store i64 %v5, ptr %st6
  ret void
}

define internal void @"std/strings.ToUpper"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v18, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = getelementptr i64, ptr %s1, i64 0
  %v7.p = getelementptr i64, ptr %v4, i64 0
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 1
  %v8 = load i64, ptr %v8.p
  %v9.p = getelementptr i64, ptr %v4, i64 2
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 97
  %v11 = add i64 0, 122
  %v12 = add i64 0, 32
  %v13 = add i64 0, 0
  %v14 = sub i64 %v13, %v12
  call void @"std/strings.mapCase"(ptr %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v14)
  %v15.p = getelementptr i64, ptr %v6, i64 0
  %v15 = load i64, ptr %v15.p
  %st3 = getelementptr i64, ptr %v0, i64 0
  store i64 %v15, ptr %st3
  %v16.p = getelementptr i64, ptr %v6, i64 1
  %v16 = load i64, ptr %v16.p
  %st4 = getelementptr i64, ptr %v0, i64 1
  store i64 %v16, ptr %st4
  %v17.p = getelementptr i64, ptr %v6, i64 2
  %v17 = load i64, ptr %v17.p
  %st5 = getelementptr i64, ptr %v0, i64 2
  store i64 %v17, ptr %st5
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v19 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v19, i64 0
  store i64 %v5, ptr %st6
  ret void
}

define internal i64 @"std/strings.EqualFold"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v54 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v54, i64 0
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
  %v19.c = icmp ne i64 %v17, %v18
  %v19 = zext i1 %v19.c to i64
  %c.b0 = icmp ne i64 %v19, 0
  br i1 %c.b0, label %b0.t13, label %b0.e14
b0.t13:
  br label %b1
b0.e14:
  br label %b2
b1:
  %v20 = add i64 0, 0
  %v55 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v55, i64 0
  store i64 %v8, ptr %st14
  ret i64 %v20
b2:
  br label %b3
b3:
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s4, i64 0
  %st15 = getelementptr i64, ptr %v22, i64 0
  store i64 %v21, ptr %st15
  %v56 = getelementptr i64, ptr @"rt.meta", i64 0
  %v23.p = getelementptr i64, ptr %v56, i64 0
  %v23 = load i64, ptr %v23.p
  br label %b4
b4:
  %v57 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v57, i64 0
  store i64 %v23, ptr %st16
  %v24.p = getelementptr i64, ptr %v22, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v9, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp slt i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b4 = icmp ne i64 %v26, 0
  br i1 %c.b4, label %b4.t18, label %b4.e19
b4.t18:
  br label %b7
b4.e19:
  br label %b8
b5:
  call void @"rt.region_enter"()
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %v47.p = getelementptr i64, ptr %v58, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 0, 1
  %v49.p = getelementptr i64, ptr %v22, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 %v49, %v48
  %st19 = getelementptr i64, ptr %v22, i64 0
  store i64 %v50, ptr %st19
  br label %b4
b6:
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v59, i64 0
  store i64 %v23, ptr %st20
  %v51.p = getelementptr i64, ptr %v22, i64 0
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v9, i64 1
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp eq i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v60, i64 0
  store i64 %v8, ptr %st21
  ret i64 %v53
b7:
  %v28.p = getelementptr i64, ptr %v22, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v9, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.c = icmp uge i64 %v28, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b7 = icmp ne i64 %v30, 0
  br i1 %c.b7, label %b7.t23, label %b7.e24
b7.t23:
  br label %b9
b7.e24:
  br label %b10
b8:
  %v27 = phi i64 [ %v26, %b4.e19 ], [ %v46, %b12 ]
  %c.b8 = icmp ne i64 %v27, 0
  br i1 %c.b8, label %b8.t25, label %b8.e26
b8.t25:
  br label %b5
b8.e26:
  br label %b6
b9:
  %v31 = add i64 0, 0
  call void @"rt.panic"(i64 %v31)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v32.p = getelementptr i64, ptr %v9, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = inttoptr i64 %v32 to ptr
  %v34 = getelementptr i8, ptr %v33, i64 %v28
  %v35.p = getelementptr i8, ptr %v34, i64 0
  %v35.b = load i8, ptr %v35.p
  %v35 = zext i8 %v35.b to i64
  %v36 = call i64 @"std/strings.foldByte"(i64 %v35)
  %v37.p = getelementptr i64, ptr %v22, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v13, i64 1
  %v38 = load i64, ptr %v38.p
  %v39.c = icmp uge i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b10 = icmp ne i64 %v39, 0
  br i1 %c.b10, label %b10.t27, label %b10.e28
b10.t27:
  br label %b11
b10.e28:
  br label %b12
b11:
  %v40 = add i64 0, 1
  call void @"rt.panic"(i64 %v40)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v41.p = getelementptr i64, ptr %v13, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = inttoptr i64 %v41 to ptr
  %v43 = getelementptr i8, ptr %v42, i64 %v37
  %v44.p = getelementptr i8, ptr %v43, i64 0
  %v44.b = load i8, ptr %v44.p
  %v44 = zext i8 %v44.b to i64
  %v45 = call i64 @"std/strings.foldByte"(i64 %v44)
  %v46.c = icmp eq i64 %v36, %v45
  %v46 = zext i1 %v46.c to i64
  br label %b8
}

define internal i64 @"std/strings.foldByte"(i64 %v0) #0 {
b0:
  %v13 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v13, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = add i64 0, 65
  %v3.c = icmp sge i64 %v0, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = add i64 0, 90
  %v6.c = icmp sle i64 %v0, %v5
  %v6 = zext i1 %v6.c to i64
  br label %b2
b2:
  %v4 = phi i64 [ %v3, %b0.e2 ], [ %v6, %b1 ]
  %c.b2 = icmp ne i64 %v4, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v7 = add i64 0, 32
  %v8 = add i64 %v0, %v7
  %v9 = add i64 0, 256
  %v10.c = icmp uge i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b3 = icmp ne i64 %v10, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b5
b3.e6:
  br label %b6
b4:
  br label %b7
b5:
  %v11 = add i64 0, 2
  call void @"rt.panic"(i64 %v11)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  br label %b7
b7:
  %v12 = phi i64 [ %v0, %b4 ], [ %v8, %b6 ]
  %v14 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v1, ptr %st6
  ret i64 %v12
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
  %v20 = getelementptr i64, ptr @"str.120", i64 0
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
  %v74 = getelementptr i64, ptr @"str.128", i64 0
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
  %v27 = getelementptr i64, ptr @"str.121", i64 0
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
  %v34 = getelementptr i64, ptr @"str.122", i64 0
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
  %v41 = getelementptr i64, ptr @"str.123", i64 0
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
  %v48 = getelementptr i64, ptr @"str.124", i64 0
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
  %v55 = getelementptr i64, ptr @"str.125", i64 0
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
  %v62 = getelementptr i64, ptr @"str.126", i64 0
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
  %v69 = getelementptr i64, ptr @"str.127", i64 0
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
  %v81 = getelementptr i64, ptr @"str.129", i64 0
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

define internal void @"std/strings.mapCase"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %v116 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v116, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
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
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v13, ptr %st6
  %v117 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v117, i64 0
  %v15 = load i64, ptr %v15.p
  br label %b1
b1:
  %v118 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v118, i64 0
  store i64 %v15, ptr %st7
  %v16.p = getelementptr i64, ptr %v14, i64 0
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v9, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.c = icmp slt i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b1 = icmp ne i64 %v18, 0
  br i1 %c.b1, label %b1.t9, label %b1.e10
b1.t9:
  br label %b4
b1.e10:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v119 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v119, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 1
  %v41.p = getelementptr i64, ptr %v14, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 %v41, %v40
  %st10 = getelementptr i64, ptr %v14, i64 0
  store i64 %v42, ptr %st10
  br label %b1
b3:
  %v120 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v120, i64 0
  store i64 %v15, ptr %st11
  %v43.p = getelementptr i64, ptr %v14, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v9, i64 1
  %v44 = load i64, ptr %v44.p
  %v45.c = icmp eq i64 %v43, %v44
  %v45 = zext i1 %v45.c to i64
  %c.b3 = icmp ne i64 %v45, 0
  br i1 %c.b3, label %b3.t13, label %b3.e14
b3.t13:
  br label %b12
b3.e14:
  br label %b13
b4:
  %v20.p = getelementptr i64, ptr %v14, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v9, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.c = icmp uge i64 %v20, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b4 = icmp ne i64 %v22, 0
  br i1 %c.b4, label %b4.t15, label %b4.e16
b4.t15:
  br label %b6
b4.e16:
  br label %b7
b5:
  %v19 = phi i64 [ %v18, %b1.e10 ], [ %v29, %b9 ]
  %c.b5 = icmp ne i64 %v19, 0
  br i1 %c.b5, label %b5.t17, label %b5.e18
b5.t17:
  br label %b2
b5.e18:
  br label %b3
b6:
  %v23 = add i64 0, 3
  call void @"rt.panic"(i64 %v23)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v24.p = getelementptr i64, ptr %v9, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = inttoptr i64 %v24 to ptr
  %v26 = getelementptr i8, ptr %v25, i64 %v20
  %v27.p = getelementptr i8, ptr %v26, i64 0
  %v27.b = load i8, ptr %v27.p
  %v27 = zext i8 %v27.b to i64
  %v28.c = icmp slt i64 %v27, %v4
  %v28 = zext i1 %v28.c to i64
  %c.b7 = icmp ne i64 %v28, 0
  br i1 %c.b7, label %b7.t19, label %b7.e20
b7.t19:
  br label %b9
b7.e20:
  br label %b8
b8:
  %v30.p = getelementptr i64, ptr %v14, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v9, i64 1
  %v31 = load i64, ptr %v31.p
  %v32.c = icmp uge i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b8 = icmp ne i64 %v32, 0
  br i1 %c.b8, label %b8.t21, label %b8.e22
b8.t21:
  br label %b10
b8.e22:
  br label %b11
b9:
  %v29 = phi i64 [ %v28, %b7.t19 ], [ %v38, %b11 ]
  br label %b5
b10:
  %v33 = add i64 0, 4
  call void @"rt.panic"(i64 %v33)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v34.p = getelementptr i64, ptr %v9, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = inttoptr i64 %v34 to ptr
  %v36 = getelementptr i8, ptr %v35, i64 %v30
  %v37.p = getelementptr i8, ptr %v36, i64 0
  %v37.b = load i8, ptr %v37.p
  %v37 = zext i8 %v37.b to i64
  %v38.c = icmp sgt i64 %v37, %v5
  %v38 = zext i1 %v38.c to i64
  br label %b9
b12:
  %v46.p = getelementptr i64, ptr %v7, i64 0
  %v46 = load i64, ptr %v46.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v46, ptr %st22
  %v47.p = getelementptr i64, ptr %v7, i64 1
  %v47 = load i64, ptr %v47.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v47, ptr %st23
  %v48.p = getelementptr i64, ptr %v7, i64 2
  %v48 = load i64, ptr %v48.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v48, ptr %st24
  call void @"rt.region_relocate8"(ptr %v0, i64 %v8)
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v121, i64 0
  store i64 %v8, ptr %st25
  ret void
b13:
  br label %b14
b14:
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v122, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51 = call ptr @"rt.region_alloc8"(i64 %v49, i64 %v50)
  %v52 = add i64 0, 0
  %v53 = getelementptr i64, ptr %s3, i64 0
  %v54 = ptrtoint ptr %v51 to i64
  %st26 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st26
  %st27 = getelementptr i64, ptr %v53, i64 1
  store i64 %v52, ptr %st27
  %st28 = getelementptr i64, ptr %v53, i64 2
  store i64 %v49, ptr %st28
  %v55 = getelementptr i64, ptr %s4, i64 0
  %v56.p = getelementptr i64, ptr %v53, i64 0
  %v56 = load i64, ptr %v56.p
  %st29 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st29
  %v57.p = getelementptr i64, ptr %v53, i64 1
  %v57 = load i64, ptr %v57.p
  %st30 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st30
  %v58.p = getelementptr i64, ptr %v53, i64 2
  %v58 = load i64, ptr %v58.p
  %st31 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st31
  %v59 = add i64 0, 0
  %v60 = getelementptr i64, ptr %s5, i64 0
  %st32 = getelementptr i64, ptr %v60, i64 0
  store i64 %v59, ptr %st32
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %v61.p = getelementptr i64, ptr %v123, i64 0
  %v61 = load i64, ptr %v61.p
  br label %b15
b15:
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v124, i64 0
  store i64 %v61, ptr %st33
  %v62.p = getelementptr i64, ptr %v60, i64 0
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v9, i64 1
  %v63 = load i64, ptr %v63.p
  %v64.c = icmp slt i64 %v62, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b15 = icmp ne i64 %v64, 0
  br i1 %c.b15, label %b15.t35, label %b15.e36
b15.t35:
  br label %b16
b15.e36:
  br label %b17
b16:
  call void @"rt.region_enter"()
  %v125 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65.p = getelementptr i64, ptr %v125, i64 0
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v60, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v9, i64 1
  %v67 = load i64, ptr %v67.p
  %v68.c = icmp uge i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b16 = icmp ne i64 %v68, 0
  br i1 %c.b16, label %b16.t37, label %b16.e38
b16.t37:
  br label %b18
b16.e38:
  br label %b19
b17:
  %v126 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v126, i64 0
  store i64 %v61, ptr %st38
  %v113.p = getelementptr i64, ptr %v55, i64 0
  %v113 = load i64, ptr %v113.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v113, ptr %st39
  %v114.p = getelementptr i64, ptr %v55, i64 1
  %v114 = load i64, ptr %v114.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v114, ptr %st40
  %v115.p = getelementptr i64, ptr %v55, i64 2
  %v115 = load i64, ptr %v115.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v115, ptr %st41
  call void @"rt.region_relocate8"(ptr %v0, i64 %v8)
  %v127 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v127, i64 0
  store i64 %v8, ptr %st42
  ret void
b18:
  %v69 = add i64 0, 5
  call void @"rt.panic"(i64 %v69)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v70.p = getelementptr i64, ptr %v9, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = inttoptr i64 %v70 to ptr
  %v72 = getelementptr i8, ptr %v71, i64 %v66
  %v73.p = getelementptr i8, ptr %v72, i64 0
  %v73.b = load i8, ptr %v73.p
  %v73 = zext i8 %v73.b to i64
  %v74 = add i64 0, 1
  %v75 = add i64 %v8, %v74
  %v76 = getelementptr i64, ptr %s3, i64 0
  %v77.p = getelementptr i64, ptr %v55, i64 0
  %v77 = load i64, ptr %v77.p
  %st43 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st43
  %v78.p = getelementptr i64, ptr %v55, i64 1
  %v78 = load i64, ptr %v78.p
  %st44 = getelementptr i64, ptr %v76, i64 1
  store i64 %v78, ptr %st44
  %v79.p = getelementptr i64, ptr %v55, i64 2
  %v79 = load i64, ptr %v79.p
  %st45 = getelementptr i64, ptr %v76, i64 2
  store i64 %v79, ptr %st45
  %v80.c = icmp sge i64 %v73, %v4
  %v80 = zext i1 %v80.c to i64
  %c.b19 = icmp ne i64 %v80, 0
  br i1 %c.b19, label %b19.t47, label %b19.e48
b19.t47:
  br label %b20
b19.e48:
  br label %b21
b20:
  %v82.c = icmp sle i64 %v73, %v5
  %v82 = zext i1 %v82.c to i64
  br label %b21
b21:
  %v81 = phi i64 [ %v80, %b19.e48 ], [ %v82, %b20 ]
  %c.b21 = icmp ne i64 %v81, 0
  br i1 %c.b21, label %b21.t49, label %b21.e50
b21.t49:
  br label %b22
b21.e50:
  br label %b23
b22:
  %v83 = add i64 %v73, %v6
  %v84 = add i64 0, 256
  %v85.c = icmp uge i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b22 = icmp ne i64 %v85, 0
  br i1 %c.b22, label %b22.t51, label %b22.e52
b22.t51:
  br label %b24
b22.e52:
  br label %b25
b23:
  br label %b26
b24:
  %v86 = add i64 0, 6
  call void @"rt.panic"(i64 %v86)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  br label %b26
b26:
  %v87 = phi i64 [ %v73, %b23 ], [ %v83, %b25 ]
  %v88.p = getelementptr i64, ptr %v76, i64 2
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v76, i64 0
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v76, i64 1
  %v90 = load i64, ptr %v90.p
  %v93 = add i64 %v89, %v90
  %v94 = call i64 @"rt.tip8"(i64 %v88, i64 %v93)
  %v95 = add i64 0, 0
  %v96.c = icmp ne i64 %v94, %v95
  %v96 = zext i1 %v96.c to i64
  %c.b26 = icmp ne i64 %v96, 0
  br i1 %c.b26, label %b26.t53, label %b26.e54
b26.t53:
  br label %b29
b26.e54:
  br label %b28
b27:
  %v91 = phi ptr [ %v100, %b28 ], [ %v97, %b29 ]
  %v92 = phi ptr [ %v101, %b28 ], [ %v98, %b29 ]
  %st54 = getelementptr i8, ptr %v92, i64 0
  %st54.b = trunc i64 %v87 to i8
  store i8 %st54.b, ptr %st54
  %v102.p = getelementptr i64, ptr %v76, i64 1
  %v102 = load i64, ptr %v102.p
  %v103 = add i64 0, 1
  %v104 = add i64 %v102, %v103
  %v105 = getelementptr i64, ptr %s6, i64 0
  %v106 = ptrtoint ptr %v91 to i64
  %st55 = getelementptr i64, ptr %v105, i64 0
  store i64 %v106, ptr %st55
  %st56 = getelementptr i64, ptr %v105, i64 1
  store i64 %v104, ptr %st56
  %st57 = getelementptr i64, ptr %v105, i64 2
  store i64 %v88, ptr %st57
  %v107.p = getelementptr i64, ptr %v105, i64 0
  %v107 = load i64, ptr %v107.p
  %st58 = getelementptr i64, ptr %v55, i64 0
  store i64 %v107, ptr %st58
  %v108.p = getelementptr i64, ptr %v105, i64 1
  %v108 = load i64, ptr %v108.p
  %st59 = getelementptr i64, ptr %v55, i64 1
  store i64 %v108, ptr %st59
  %v109.p = getelementptr i64, ptr %v105, i64 2
  %v109 = load i64, ptr %v109.p
  %st60 = getelementptr i64, ptr %v55, i64 2
  store i64 %v109, ptr %st60
  %v110 = add i64 0, 1
  %v111.p = getelementptr i64, ptr %v60, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 %v111, %v110
  %st61 = getelementptr i64, ptr %v60, i64 0
  store i64 %v112, ptr %st61
  br label %b15
b28:
  %v99 = add i64 0, 1
  %v100 = call ptr @"rt.slice_grow8"(i64 %v89, i64 %v90, i64 %v88, i64 %v99)
  %v101 = getelementptr i8, ptr %v100, i64 %v90
  br label %b27
b29:
  %v97 = inttoptr i64 %v89 to ptr
  %v98 = getelementptr i8, ptr %v97, i64 %v90
  br label %b27
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

define internal i64 @"std/strings.runeEnd"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v2, ptr %st2
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v31, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6 = add i64 0, 1
  %v7 = add i64 %v3, %v6
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v7, ptr %st3
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v32, i64 0
  %v9 = load i64, ptr %v9.p
  br label %b1
b1:
  %v33 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v33, i64 0
  store i64 %v9, ptr %st4
  %v10.p = getelementptr i64, ptr %v8, i64 0
  %v10 = load i64, ptr %v10.p
  %v11.p = getelementptr i64, ptr %v4, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp slt i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b1 = icmp ne i64 %v12, 0
  br i1 %c.b1, label %b1.t6, label %b1.e7
b1.t6:
  br label %b4
b1.e7:
  br label %b5
b2:
  call void @"rt.region_enter"()
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v34, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 1
  %v28.p = getelementptr i64, ptr %v8, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 %v28, %v27
  %st7 = getelementptr i64, ptr %v8, i64 0
  store i64 %v29, ptr %st7
  br label %b1
b3:
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v35, i64 0
  store i64 %v9, ptr %st8
  %v30.p = getelementptr i64, ptr %v8, i64 0
  %v30 = load i64, ptr %v30.p
  %v36 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v36, i64 0
  store i64 %v5, ptr %st9
  ret i64 %v30
b4:
  %v14.p = getelementptr i64, ptr %v8, i64 0
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v4, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b4 = icmp ne i64 %v16, 0
  br i1 %c.b4, label %b4.t11, label %b4.e12
b4.t11:
  br label %b6
b4.e12:
  br label %b7
b5:
  %v13 = phi i64 [ %v12, %b1.e7 ], [ %v25, %b7 ]
  %c.b5 = icmp ne i64 %v13, 0
  br i1 %c.b5, label %b5.t13, label %b5.e14
b5.t13:
  br label %b2
b5.e14:
  br label %b3
b6:
  %v17 = add i64 0, 10
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v18.p = getelementptr i64, ptr %v4, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = inttoptr i64 %v18 to ptr
  %v20 = getelementptr i8, ptr %v19, i64 %v14
  %v21.p = getelementptr i8, ptr %v20, i64 0
  %v21.b = load i8, ptr %v21.p
  %v21 = zext i8 %v21.b to i64
  %v22 = add i64 0, 192
  %v23 = and i64 %v21, %v22
  %v24 = add i64 0, 128
  %v25.c = icmp eq i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  br label %b5
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
  %v40 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v40, i64 0
  %v9 = load i64, ptr %v9.p
  call void @"rt.region_enter"()
  %v10 = add i64 0, 0
  %v11 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v10, ptr %st6
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v41, i64 0
  %v12 = load i64, ptr %v12.p
  br label %b1
b1:
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v42, i64 0
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
  br label %b2
b1.e10:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v43, i64 0
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v11, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 %v3, %v17
  %v19.p = getelementptr i64, ptr %v7, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.c = icmp uge i64 %v18, %v19
  %v20 = zext i1 %v20.c to i64
  %c.b2 = icmp ne i64 %v20, 0
  br i1 %c.b2, label %b2.t11, label %b2.e12
b2.t11:
  br label %b4
b2.e12:
  br label %b5
b3:
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v44, i64 0
  store i64 %v12, ptr %st12
  %v39 = add i64 0, 1
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v45, i64 0
  store i64 %v9, ptr %st13
  ret i64 %v39
b4:
  %v21 = add i64 0, 11
  call void @"rt.panic"(i64 %v21)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b5:
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
  %c.b5 = icmp ne i64 %v28, 0
  br i1 %c.b5, label %b5.t15, label %b5.e16
b5.t15:
  br label %b6
b5.e16:
  br label %b7
b6:
  %v29 = add i64 0, 12
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v30.p = getelementptr i64, ptr %v8, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = getelementptr i8, ptr %v31, i64 %v26
  %v33.p = getelementptr i8, ptr %v32, i64 0
  %v33.b = load i8, ptr %v33.p
  %v33 = zext i8 %v33.b to i64
  %v34.c = icmp ne i64 %v25, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b7 = icmp ne i64 %v34, 0
  br i1 %c.b7, label %b7.t17, label %b7.e18
b7.t17:
  br label %b8
b7.e18:
  br label %b9
b8:
  %v35 = add i64 0, 0
  %v46 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v46, i64 0
  store i64 %v9, ptr %st18
  ret i64 %v35
b9:
  br label %b10
b10:
  %v36 = add i64 0, 1
  %v37.p = getelementptr i64, ptr %v11, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 %v37, %v36
  %st19 = getelementptr i64, ptr %v11, i64 0
  store i64 %v38, ptr %st19
  br label %b1
}

define internal i64 @"std/strings.isSpace"(i64 %v0) #0 {
b0:
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v10, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = add i64 0, 32
  %v3.c = icmp eq i64 %v0, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v5 = add i64 0, 9
  %v6.c = icmp sge i64 %v0, %v5
  %v6 = zext i1 %v6.c to i64
  %c.b1 = icmp ne i64 %v6, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b3
b1.e4:
  br label %b4
b2:
  %v4 = phi i64 [ %v3, %b0.t1 ], [ %v7, %b4 ]
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v11, i64 0
  store i64 %v1, ptr %st4
  ret i64 %v4
b3:
  %v8 = add i64 0, 13
  %v9.c = icmp sle i64 %v0, %v8
  %v9 = zext i1 %v9.c to i64
  br label %b4
b4:
  %v7 = phi i64 [ %v6, %b1.e4 ], [ %v9, %b3 ]
  br label %b2
}

define internal void @"std/strings.Fields"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v141, i64 0
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
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v142, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %v12 = call ptr @"rt.region_alloc"(i64 %v10, i64 %v11)
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
  %v143 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v143, i64 0
  %v22 = load i64, ptr %v22.p
  br label %b1
b1:
  %v144 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v144, i64 0
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
  %v145 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v145, i64 0
  %v26 = load i64, ptr %v26.p
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v146, i64 0
  %v27 = load i64, ptr %v27.p
  br label %b4
b3:
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v147, i64 0
  store i64 %v22, ptr %st16
  %v125.p = getelementptr i64, ptr %v16, i64 0
  %v125 = load i64, ptr %v125.p
  %st17 = getelementptr i64, ptr %v0, i64 0
  store i64 %v125, ptr %st17
  %v126.p = getelementptr i64, ptr %v16, i64 1
  %v126 = load i64, ptr %v126.p
  %st18 = getelementptr i64, ptr %v0, i64 1
  store i64 %v126, ptr %st18
  %v127.p = getelementptr i64, ptr %v16, i64 2
  %v127 = load i64, ptr %v127.p
  %st19 = getelementptr i64, ptr %v0, i64 2
  store i64 %v127, ptr %st19
  %v128.p = getelementptr i64, ptr %v0, i64 2
  %v128 = load i64, ptr %v128.p
  %v129.c = icmp sgt i64 %v128, %v5
  %v129 = zext i1 %v129.c to i64
  %c.b3 = icmp ne i64 %v129, 0
  br i1 %c.b3, label %b3.t21, label %b3.e22
b3.t21:
  br label %b30
b3.e22:
  br label %b31
b4:
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v148, i64 0
  store i64 %v27, ptr %st22
  %v28.p = getelementptr i64, ptr %v21, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v6, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.c = icmp slt i64 %v28, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b4 = icmp ne i64 %v30, 0
  br i1 %c.b4, label %b4.t24, label %b4.e25
b4.t24:
  br label %b7
b4.e25:
  br label %b8
b5:
  call void @"rt.region_enter"()
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41.p = getelementptr i64, ptr %v149, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 1
  %v43.p = getelementptr i64, ptr %v21, i64 0
  %v43 = load i64, ptr %v43.p
  %v44 = add i64 %v43, %v42
  %st25 = getelementptr i64, ptr %v21, i64 0
  store i64 %v44, ptr %st25
  br label %b4
b6:
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v150, i64 0
  store i64 %v27, ptr %st26
  %v45.p = getelementptr i64, ptr %v21, i64 0
  %v45 = load i64, ptr %v45.p
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %v46.p = getelementptr i64, ptr %v151, i64 0
  %v46 = load i64, ptr %v46.p
  br label %b11
b7:
  %v32.p = getelementptr i64, ptr %v21, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v6, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.c = icmp uge i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b7 = icmp ne i64 %v34, 0
  br i1 %c.b7, label %b7.t28, label %b7.e29
b7.t28:
  br label %b9
b7.e29:
  br label %b10
b8:
  %v31 = phi i64 [ %v30, %b4.e25 ], [ %v40, %b10 ]
  %c.b8 = icmp ne i64 %v31, 0
  br i1 %c.b8, label %b8.t30, label %b8.e31
b8.t30:
  br label %b5
b8.e31:
  br label %b6
b9:
  %v35 = add i64 0, 21
  call void @"rt.panic"(i64 %v35)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v36.p = getelementptr i64, ptr %v6, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = inttoptr i64 %v36 to ptr
  %v38 = getelementptr i8, ptr %v37, i64 %v32
  %v39.p = getelementptr i8, ptr %v38, i64 0
  %v39.b = load i8, ptr %v39.p
  %v39 = zext i8 %v39.b to i64
  %v40 = call i64 @"std/strings.isSpace"(i64 %v39)
  br label %b8
b11:
  %v152 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v152, i64 0
  store i64 %v46, ptr %st31
  %v47.p = getelementptr i64, ptr %v21, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v6, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp slt i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b11 = icmp ne i64 %v49, 0
  br i1 %c.b11, label %b11.t33, label %b11.e34
b11.t33:
  br label %b14
b11.e34:
  br label %b15
b12:
  call void @"rt.region_enter"()
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %v62.p = getelementptr i64, ptr %v153, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = add i64 0, 1
  %v64.p = getelementptr i64, ptr %v21, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 %v64, %v63
  %st34 = getelementptr i64, ptr %v21, i64 0
  store i64 %v65, ptr %st34
  br label %b11
b13:
  %v154 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v154, i64 0
  store i64 %v46, ptr %st35
  %v66.p = getelementptr i64, ptr %v21, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp sgt i64 %v66, %v45
  %v67 = zext i1 %v67.c to i64
  %c.b13 = icmp ne i64 %v67, 0
  br i1 %c.b13, label %b13.t37, label %b13.e38
b13.t37:
  br label %b18
b13.e38:
  br label %b19
b14:
  %v51.p = getelementptr i64, ptr %v21, i64 0
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v6, i64 1
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp uge i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b14 = icmp ne i64 %v53, 0
  br i1 %c.b14, label %b14.t39, label %b14.e40
b14.t39:
  br label %b16
b14.e40:
  br label %b17
b15:
  %v50 = phi i64 [ %v49, %b11.e34 ], [ %v61, %b17 ]
  %c.b15 = icmp ne i64 %v50, 0
  br i1 %c.b15, label %b15.t41, label %b15.e42
b15.t41:
  br label %b12
b15.e42:
  br label %b13
b16:
  %v54 = add i64 0, 22
  call void @"rt.panic"(i64 %v54)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v55.p = getelementptr i64, ptr %v6, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = inttoptr i64 %v55 to ptr
  %v57 = getelementptr i8, ptr %v56, i64 %v51
  %v58.p = getelementptr i8, ptr %v57, i64 0
  %v58.b = load i8, ptr %v58.p
  %v58 = zext i8 %v58.b to i64
  %v59 = call i64 @"std/strings.isSpace"(i64 %v58)
  %v60 = add i64 0, 1
  %v61 = xor i64 %v59, %v60
  br label %b15
b18:
  %v68 = add i64 0, 1
  %v69 = add i64 %v5, %v68
  %v70 = getelementptr i64, ptr %s2, i64 0
  %v71.p = getelementptr i64, ptr %v16, i64 0
  %v71 = load i64, ptr %v71.p
  %st42 = getelementptr i64, ptr %v70, i64 0
  store i64 %v71, ptr %st42
  %v72.p = getelementptr i64, ptr %v16, i64 1
  %v72 = load i64, ptr %v72.p
  %st43 = getelementptr i64, ptr %v70, i64 1
  store i64 %v72, ptr %st43
  %v73.p = getelementptr i64, ptr %v16, i64 2
  %v73 = load i64, ptr %v73.p
  %st44 = getelementptr i64, ptr %v70, i64 2
  store i64 %v73, ptr %st44
  %v74.p = getelementptr i64, ptr %v21, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 0
  %v76.c = icmp slt i64 %v45, %v75
  %v76 = zext i1 %v76.c to i64
  %c.b18 = icmp ne i64 %v76, 0
  br i1 %c.b18, label %b18.t46, label %b18.e47
b18.t46:
  br label %b20
b18.e47:
  br label %b21
b19:
  br label %b29
b20:
  %v77 = add i64 0, 23
  call void @"rt.panic"(i64 %v77)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v78.c = icmp slt i64 %v74, %v45
  %v78 = zext i1 %v78.c to i64
  %c.b21 = icmp ne i64 %v78, 0
  br i1 %c.b21, label %b21.t48, label %b21.e49
b21.t48:
  br label %b22
b21.e49:
  br label %b23
b22:
  %v79 = add i64 0, 24
  call void @"rt.panic"(i64 %v79)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v80.p = getelementptr i64, ptr %v6, i64 1
  %v80 = load i64, ptr %v80.p
  %v81.c = icmp sgt i64 %v74, %v80
  %v81 = zext i1 %v81.c to i64
  %c.b23 = icmp ne i64 %v81, 0
  br i1 %c.b23, label %b23.t50, label %b23.e51
b23.t50:
  br label %b24
b23.e51:
  br label %b25
b24:
  %v82 = add i64 0, 25
  call void @"rt.panic"(i64 %v82)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  %v83.p = getelementptr i64, ptr %v6, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = inttoptr i64 %v83 to ptr
  %v85 = getelementptr i8, ptr %v84, i64 %v45
  %v86 = sub i64 %v74, %v45
  %v87.p = getelementptr i64, ptr %v6, i64 2
  %v87 = load i64, ptr %v87.p
  %v88 = getelementptr i64, ptr %s5, i64 0
  %v89 = ptrtoint ptr %v85 to i64
  %st51 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st51
  %st52 = getelementptr i64, ptr %v88, i64 1
  store i64 %v86, ptr %st52
  %st53 = getelementptr i64, ptr %v88, i64 2
  store i64 %v87, ptr %st53
  %v90 = getelementptr i64, ptr %s6, i64 0
  %v91.p = getelementptr i64, ptr %v88, i64 0
  %v91 = load i64, ptr %v91.p
  %st54 = getelementptr i64, ptr %v90, i64 0
  store i64 %v91, ptr %st54
  %v92.p = getelementptr i64, ptr %v88, i64 1
  %v92 = load i64, ptr %v92.p
  %st55 = getelementptr i64, ptr %v90, i64 1
  store i64 %v92, ptr %st55
  %v93.p = getelementptr i64, ptr %v88, i64 2
  %v93 = load i64, ptr %v93.p
  %st56 = getelementptr i64, ptr %v90, i64 2
  store i64 %v93, ptr %st56
  %v94.p = getelementptr i64, ptr %v70, i64 2
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v70, i64 0
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v70, i64 1
  %v96 = load i64, ptr %v96.p
  %v99 = add i64 0, 24
  %v100 = mul i64 %v96, %v99
  %v101 = add i64 %v95, %v100
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %v156 = getelementptr i64, ptr %v155, i64 %v94
  %v102.p = getelementptr i64, ptr %v156, i64 1
  %v102 = load ptr, ptr %v102.p
  %v103 = ptrtoint ptr %v102 to i64
  %v104.c = icmp eq i64 %v103, %v101
  %v104 = zext i1 %v104.c to i64
  %c.b25 = icmp ne i64 %v104, 0
  br i1 %c.b25, label %b25.t58, label %b25.e59
b25.t58:
  br label %b28
b25.e59:
  br label %b27
b26:
  %v97 = phi ptr [ %v112, %b27 ], [ %v107, %b28 ]
  %v98 = phi ptr [ %v113, %b27 ], [ %v106, %b28 ]
  call void @"rt.region_relocate8"(ptr %v90, i64 %v94)
  %v114.p = getelementptr i64, ptr %v90, i64 0
  %v114 = load i64, ptr %v114.p
  %st59 = getelementptr i64, ptr %v98, i64 0
  store i64 %v114, ptr %st59
  %v115.p = getelementptr i64, ptr %v90, i64 1
  %v115 = load i64, ptr %v115.p
  %st60 = getelementptr i64, ptr %v98, i64 1
  store i64 %v115, ptr %st60
  %v116.p = getelementptr i64, ptr %v90, i64 2
  %v116 = load i64, ptr %v116.p
  %st61 = getelementptr i64, ptr %v98, i64 2
  store i64 %v116, ptr %st61
  %v117.p = getelementptr i64, ptr %v70, i64 1
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 0, 1
  %v119 = add i64 %v117, %v118
  %v120 = getelementptr i64, ptr %s7, i64 0
  %v121 = ptrtoint ptr %v97 to i64
  %st62 = getelementptr i64, ptr %v120, i64 0
  store i64 %v121, ptr %st62
  %st63 = getelementptr i64, ptr %v120, i64 1
  store i64 %v119, ptr %st63
  %st64 = getelementptr i64, ptr %v120, i64 2
  store i64 %v94, ptr %st64
  %v122.p = getelementptr i64, ptr %v120, i64 0
  %v122 = load i64, ptr %v122.p
  %st65 = getelementptr i64, ptr %v16, i64 0
  store i64 %v122, ptr %st65
  %v123.p = getelementptr i64, ptr %v120, i64 1
  %v123 = load i64, ptr %v123.p
  %st66 = getelementptr i64, ptr %v16, i64 1
  store i64 %v123, ptr %st66
  %v124.p = getelementptr i64, ptr %v120, i64 2
  %v124 = load i64, ptr %v124.p
  %st67 = getelementptr i64, ptr %v16, i64 2
  store i64 %v124, ptr %st67
  br label %b29
b27:
  %v108 = add i64 0, 3
  %v109 = mul i64 %v96, %v108
  %v110 = add i64 0, 3
  %v111 = add i64 0, 1
  %v112 = call ptr @"rt.slice_grow"(i64 %v95, i64 %v96, i64 %v110, i64 %v94, i64 %v111)
  %v113 = getelementptr i64, ptr %v112, i64 %v109
  br label %b26
b28:
  %v105 = add i64 0, 3
  %v106 = call ptr @"rt.region_alloc"(i64 %v94, i64 %v105)
  %v107 = inttoptr i64 %v95 to ptr
  br label %b26
b29:
  br label %b1
b30:
  %v130.p = getelementptr i64, ptr %v0, i64 0
  %v130 = load i64, ptr %v130.p
  %v131 = inttoptr i64 %v130 to ptr
  %v132.p = getelementptr i64, ptr %v0, i64 1
  %v132 = load i64, ptr %v132.p
  %v134 = add i64 0, 0
  br label %b32
b31:
  %v157 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v157, i64 0
  store i64 %v5, ptr %st68
  ret void
b32:
  %v133 = phi i64 [ %v134, %b30 ], [ %v140, %b33 ]
  %v135.c = icmp slt i64 %v133, %v132
  %v135 = zext i1 %v135.c to i64
  %c.b32 = icmp ne i64 %v135, 0
  br i1 %c.b32, label %b32.t70, label %b32.e71
b32.t70:
  br label %b33
b32.e71:
  br label %b34
b33:
  %v136 = add i64 0, 3
  %v137 = mul i64 %v133, %v136
  %v138 = getelementptr i64, ptr %v131, i64 %v137
  call void @"rt.region_relocate8"(ptr %v138, i64 %v5)
  %v139 = add i64 0, 1
  %v140 = add i64 %v133, %v139
  br label %b32
b34:
  %v158 = add i64 0, 3
  call void @"rt.region_relocate"(ptr %v0, i64 %v158, i64 %v5)
  br label %b31
}

define internal void @"std/strings.Join"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v145 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v145, i64 0
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
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v146, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = add i64 0, 0
  %v16 = call ptr @"rt.region_alloc8"(i64 %v14, i64 %v15)
  %v17 = add i64 0, 0
  %v18 = getelementptr i64, ptr %s3, i64 0
  %v19 = ptrtoint ptr %v16 to i64
  %st9 = getelementptr i64, ptr %v18, i64 0
  store i64 %v19, ptr %st9
  %st10 = getelementptr i64, ptr %v18, i64 1
  store i64 %v17, ptr %st10
  %st11 = getelementptr i64, ptr %v18, i64 2
  store i64 %v14, ptr %st11
  %v20 = getelementptr i64, ptr %s4, i64 0
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
  %v24 = add i64 0, 0
  %v25 = getelementptr i64, ptr %s5, i64 0
  %st15 = getelementptr i64, ptr %v25, i64 0
  store i64 %v24, ptr %st15
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v147, i64 0
  %v26 = load i64, ptr %v26.p
  br label %b1
b1:
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v148, i64 0
  store i64 %v26, ptr %st16
  %v27.p = getelementptr i64, ptr %v25, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v7, i64 1
  %v28 = load i64, ptr %v28.p
  %v29.c = icmp slt i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b1 = icmp ne i64 %v29, 0
  br i1 %c.b1, label %b1.t18, label %b1.e19
b1.t18:
  br label %b2
b1.e19:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v149, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v25, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = add i64 0, 0
  %v33.c = icmp sgt i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b2 = icmp ne i64 %v33, 0
  br i1 %c.b2, label %b2.t20, label %b2.e21
b2.t20:
  br label %b4
b2.e21:
  br label %b5
b3:
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v150, i64 0
  store i64 %v26, ptr %st21
  %v142.p = getelementptr i64, ptr %v20, i64 0
  %v142 = load i64, ptr %v142.p
  %st22 = getelementptr i64, ptr %v0, i64 0
  store i64 %v142, ptr %st22
  %v143.p = getelementptr i64, ptr %v20, i64 1
  %v143 = load i64, ptr %v143.p
  %st23 = getelementptr i64, ptr %v0, i64 1
  store i64 %v143, ptr %st23
  %v144.p = getelementptr i64, ptr %v20, i64 2
  %v144 = load i64, ptr %v144.p
  %st24 = getelementptr i64, ptr %v0, i64 2
  store i64 %v144, ptr %st24
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v151, i64 0
  store i64 %v9, ptr %st25
  ret void
b4:
  %v34 = add i64 0, 0
  %v35 = getelementptr i64, ptr %s6, i64 0
  %st26 = getelementptr i64, ptr %v35, i64 0
  store i64 %v34, ptr %st26
  %v152 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v152, i64 0
  %v36 = load i64, ptr %v36.p
  br label %b6
b5:
  br label %b14
b6:
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v153, i64 0
  store i64 %v36, ptr %st27
  %v37.p = getelementptr i64, ptr %v35, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v10, i64 1
  %v38 = load i64, ptr %v38.p
  %v39.c = icmp slt i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b6 = icmp ne i64 %v39, 0
  br i1 %c.b6, label %b6.t29, label %b6.e30
b6.t29:
  br label %b7
b6.e30:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v154 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v154, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 1
  %v42 = add i64 %v9, %v41
  %v43 = getelementptr i64, ptr %s3, i64 0
  %v44.p = getelementptr i64, ptr %v20, i64 0
  %v44 = load i64, ptr %v44.p
  %st30 = getelementptr i64, ptr %v43, i64 0
  store i64 %v44, ptr %st30
  %v45.p = getelementptr i64, ptr %v20, i64 1
  %v45 = load i64, ptr %v45.p
  %st31 = getelementptr i64, ptr %v43, i64 1
  store i64 %v45, ptr %st31
  %v46.p = getelementptr i64, ptr %v20, i64 2
  %v46 = load i64, ptr %v46.p
  %st32 = getelementptr i64, ptr %v43, i64 2
  store i64 %v46, ptr %st32
  %v47.p = getelementptr i64, ptr %v35, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v10, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp uge i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b7 = icmp ne i64 %v49, 0
  br i1 %c.b7, label %b7.t34, label %b7.e35
b7.t34:
  br label %b9
b7.e35:
  br label %b10
b8:
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v155, i64 0
  store i64 %v36, ptr %st35
  br label %b14
b9:
  %v50 = add i64 0, 18
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v51.p = getelementptr i64, ptr %v10, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = getelementptr i8, ptr %v52, i64 %v47
  %v54.p = getelementptr i8, ptr %v53, i64 0
  %v54.b = load i8, ptr %v54.p
  %v54 = zext i8 %v54.b to i64
  %v55.p = getelementptr i64, ptr %v43, i64 2
  %v55 = load i64, ptr %v55.p
  %v56.p = getelementptr i64, ptr %v43, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v43, i64 1
  %v57 = load i64, ptr %v57.p
  %v60 = add i64 %v56, %v57
  %v61 = call i64 @"rt.tip8"(i64 %v55, i64 %v60)
  %v62 = add i64 0, 0
  %v63.c = icmp ne i64 %v61, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b10 = icmp ne i64 %v63, 0
  br i1 %c.b10, label %b10.t37, label %b10.e38
b10.t37:
  br label %b13
b10.e38:
  br label %b12
b11:
  %v58 = phi ptr [ %v67, %b12 ], [ %v64, %b13 ]
  %v59 = phi ptr [ %v68, %b12 ], [ %v65, %b13 ]
  %st38 = getelementptr i8, ptr %v59, i64 0
  %st38.b = trunc i64 %v54 to i8
  store i8 %st38.b, ptr %st38
  %v69.p = getelementptr i64, ptr %v43, i64 1
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 1
  %v71 = add i64 %v69, %v70
  %v72 = getelementptr i64, ptr %s7, i64 0
  %v73 = ptrtoint ptr %v58 to i64
  %st39 = getelementptr i64, ptr %v72, i64 0
  store i64 %v73, ptr %st39
  %st40 = getelementptr i64, ptr %v72, i64 1
  store i64 %v71, ptr %st40
  %st41 = getelementptr i64, ptr %v72, i64 2
  store i64 %v55, ptr %st41
  %v74.p = getelementptr i64, ptr %v72, i64 0
  %v74 = load i64, ptr %v74.p
  %st42 = getelementptr i64, ptr %v20, i64 0
  store i64 %v74, ptr %st42
  %v75.p = getelementptr i64, ptr %v72, i64 1
  %v75 = load i64, ptr %v75.p
  %st43 = getelementptr i64, ptr %v20, i64 1
  store i64 %v75, ptr %st43
  %v76.p = getelementptr i64, ptr %v72, i64 2
  %v76 = load i64, ptr %v76.p
  %st44 = getelementptr i64, ptr %v20, i64 2
  store i64 %v76, ptr %st44
  %v77 = add i64 0, 1
  %v78.p = getelementptr i64, ptr %v35, i64 0
  %v78 = load i64, ptr %v78.p
  %v79 = add i64 %v78, %v77
  %st45 = getelementptr i64, ptr %v35, i64 0
  store i64 %v79, ptr %st45
  br label %b6
b12:
  %v66 = add i64 0, 1
  %v67 = call ptr @"rt.slice_grow8"(i64 %v56, i64 %v57, i64 %v55, i64 %v66)
  %v68 = getelementptr i8, ptr %v67, i64 %v57
  br label %b11
b13:
  %v64 = inttoptr i64 %v56 to ptr
  %v65 = getelementptr i8, ptr %v64, i64 %v57
  br label %b11
b14:
  %v80.p = getelementptr i64, ptr %v25, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v7, i64 1
  %v81 = load i64, ptr %v81.p
  %v82.c = icmp uge i64 %v80, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b14 = icmp ne i64 %v82, 0
  br i1 %c.b14, label %b14.t47, label %b14.e48
b14.t47:
  br label %b15
b14.e48:
  br label %b16
b15:
  %v83 = add i64 0, 19
  call void @"rt.panic"(i64 %v83)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v84.p = getelementptr i64, ptr %v7, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = inttoptr i64 %v84 to ptr
  %v86 = add i64 0, 3
  %v87 = mul i64 %v80, %v86
  %v88 = getelementptr i64, ptr %v85, i64 %v87
  %v89 = getelementptr i64, ptr %s7, i64 0
  %v90.p = getelementptr i64, ptr %v88, i64 0
  %v90 = load i64, ptr %v90.p
  %st48 = getelementptr i64, ptr %v89, i64 0
  store i64 %v90, ptr %st48
  %v91.p = getelementptr i64, ptr %v88, i64 1
  %v91 = load i64, ptr %v91.p
  %st49 = getelementptr i64, ptr %v89, i64 1
  store i64 %v91, ptr %st49
  %v92.p = getelementptr i64, ptr %v88, i64 2
  %v92 = load i64, ptr %v92.p
  %st50 = getelementptr i64, ptr %v89, i64 2
  store i64 %v92, ptr %st50
  %v93 = add i64 0, 0
  %v94 = getelementptr i64, ptr %s6, i64 0
  %st51 = getelementptr i64, ptr %v94, i64 0
  store i64 %v93, ptr %st51
  %v156 = getelementptr i64, ptr @"rt.meta", i64 0
  %v95.p = getelementptr i64, ptr %v156, i64 0
  %v95 = load i64, ptr %v95.p
  br label %b17
b17:
  %v157 = getelementptr i64, ptr @"rt.meta", i64 0
  %st52 = getelementptr i64, ptr %v157, i64 0
  store i64 %v95, ptr %st52
  %v96.p = getelementptr i64, ptr %v94, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v89, i64 1
  %v97 = load i64, ptr %v97.p
  %v98.c = icmp slt i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b17 = icmp ne i64 %v98, 0
  br i1 %c.b17, label %b17.t54, label %b17.e55
b17.t54:
  br label %b18
b17.e55:
  br label %b19
b18:
  call void @"rt.region_enter"()
  %v158 = getelementptr i64, ptr @"rt.meta", i64 0
  %v99.p = getelementptr i64, ptr %v158, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 0, 1
  %v101 = add i64 %v9, %v100
  %v102 = getelementptr i64, ptr %s3, i64 0
  %v103.p = getelementptr i64, ptr %v20, i64 0
  %v103 = load i64, ptr %v103.p
  %st55 = getelementptr i64, ptr %v102, i64 0
  store i64 %v103, ptr %st55
  %v104.p = getelementptr i64, ptr %v20, i64 1
  %v104 = load i64, ptr %v104.p
  %st56 = getelementptr i64, ptr %v102, i64 1
  store i64 %v104, ptr %st56
  %v105.p = getelementptr i64, ptr %v20, i64 2
  %v105 = load i64, ptr %v105.p
  %st57 = getelementptr i64, ptr %v102, i64 2
  store i64 %v105, ptr %st57
  %v106.p = getelementptr i64, ptr %v94, i64 0
  %v106 = load i64, ptr %v106.p
  %v107.p = getelementptr i64, ptr %v89, i64 1
  %v107 = load i64, ptr %v107.p
  %v108.c = icmp uge i64 %v106, %v107
  %v108 = zext i1 %v108.c to i64
  %c.b18 = icmp ne i64 %v108, 0
  br i1 %c.b18, label %b18.t59, label %b18.e60
b18.t59:
  br label %b20
b18.e60:
  br label %b21
b19:
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v159, i64 0
  store i64 %v95, ptr %st60
  %v139 = add i64 0, 1
  %v140.p = getelementptr i64, ptr %v25, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = add i64 %v140, %v139
  %st61 = getelementptr i64, ptr %v25, i64 0
  store i64 %v141, ptr %st61
  br label %b1
b20:
  %v109 = add i64 0, 20
  call void @"rt.panic"(i64 %v109)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v110.p = getelementptr i64, ptr %v89, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = inttoptr i64 %v110 to ptr
  %v112 = getelementptr i8, ptr %v111, i64 %v106
  %v113.p = getelementptr i8, ptr %v112, i64 0
  %v113.b = load i8, ptr %v113.p
  %v113 = zext i8 %v113.b to i64
  %v114.p = getelementptr i64, ptr %v102, i64 2
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v102, i64 0
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v102, i64 1
  %v116 = load i64, ptr %v116.p
  %v119 = add i64 %v115, %v116
  %v120 = call i64 @"rt.tip8"(i64 %v114, i64 %v119)
  %v121 = add i64 0, 0
  %v122.c = icmp ne i64 %v120, %v121
  %v122 = zext i1 %v122.c to i64
  %c.b21 = icmp ne i64 %v122, 0
  br i1 %c.b21, label %b21.t63, label %b21.e64
b21.t63:
  br label %b24
b21.e64:
  br label %b23
b22:
  %v117 = phi ptr [ %v126, %b23 ], [ %v123, %b24 ]
  %v118 = phi ptr [ %v127, %b23 ], [ %v124, %b24 ]
  %st64 = getelementptr i8, ptr %v118, i64 0
  %st64.b = trunc i64 %v113 to i8
  store i8 %st64.b, ptr %st64
  %v128.p = getelementptr i64, ptr %v102, i64 1
  %v128 = load i64, ptr %v128.p
  %v129 = add i64 0, 1
  %v130 = add i64 %v128, %v129
  %v131 = getelementptr i64, ptr %s8, i64 0
  %v132 = ptrtoint ptr %v117 to i64
  %st65 = getelementptr i64, ptr %v131, i64 0
  store i64 %v132, ptr %st65
  %st66 = getelementptr i64, ptr %v131, i64 1
  store i64 %v130, ptr %st66
  %st67 = getelementptr i64, ptr %v131, i64 2
  store i64 %v114, ptr %st67
  %v133.p = getelementptr i64, ptr %v131, i64 0
  %v133 = load i64, ptr %v133.p
  %st68 = getelementptr i64, ptr %v20, i64 0
  store i64 %v133, ptr %st68
  %v134.p = getelementptr i64, ptr %v131, i64 1
  %v134 = load i64, ptr %v134.p
  %st69 = getelementptr i64, ptr %v20, i64 1
  store i64 %v134, ptr %st69
  %v135.p = getelementptr i64, ptr %v131, i64 2
  %v135 = load i64, ptr %v135.p
  %st70 = getelementptr i64, ptr %v20, i64 2
  store i64 %v135, ptr %st70
  %v136 = add i64 0, 1
  %v137.p = getelementptr i64, ptr %v94, i64 0
  %v137 = load i64, ptr %v137.p
  %v138 = add i64 %v137, %v136
  %st71 = getelementptr i64, ptr %v94, i64 0
  store i64 %v138, ptr %st71
  br label %b17
b23:
  %v125 = add i64 0, 1
  %v126 = call ptr @"rt.slice_grow8"(i64 %v115, i64 %v116, i64 %v114, i64 %v125)
  %v127 = getelementptr i8, ptr %v126, i64 %v116
  br label %b22
b24:
  %v123 = inttoptr i64 %v115 to ptr
  %v124 = getelementptr i8, ptr %v123, i64 %v116
  br label %b22
}

define internal void @"std/strings.Split"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v279 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v279, i64 0
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
  %v280 = getelementptr i64, ptr @"rt.meta", i64 0
  %v18.p = getelementptr i64, ptr %v280, i64 0
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %v20 = call ptr @"rt.region_alloc"(i64 %v18, i64 %v19)
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s4, i64 0
  %v23 = ptrtoint ptr %v20 to i64
  %st12 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st12
  %st13 = getelementptr i64, ptr %v22, i64 1
  store i64 %v21, ptr %st13
  %st14 = getelementptr i64, ptr %v22, i64 2
  store i64 %v18, ptr %st14
  %v24 = getelementptr i64, ptr %s5, i64 0
  %v25.p = getelementptr i64, ptr %v22, i64 0
  %v25 = load i64, ptr %v25.p
  %st15 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st15
  %v26.p = getelementptr i64, ptr %v22, i64 1
  %v26 = load i64, ptr %v26.p
  %st16 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st16
  %v27.p = getelementptr i64, ptr %v22, i64 2
  %v27 = load i64, ptr %v27.p
  %st17 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st17
  %v28.p = getelementptr i64, ptr %v14, i64 1
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 0
  %v30.c = icmp eq i64 %v28, %v29
  %v30 = zext i1 %v30.c to i64
  %c.b0 = icmp ne i64 %v30, 0
  br i1 %c.b0, label %b0.t19, label %b0.e20
b0.t19:
  br label %b1
b0.e20:
  br label %b2
b1:
  %v31 = add i64 0, 0
  %v32 = getelementptr i64, ptr %s6, i64 0
  %st20 = getelementptr i64, ptr %v32, i64 0
  store i64 %v31, ptr %st20
  %v281 = getelementptr i64, ptr @"rt.meta", i64 0
  %v33.p = getelementptr i64, ptr %v281, i64 0
  %v33 = load i64, ptr %v33.p
  br label %b3
b2:
  br label %b20
b3:
  %v282 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v282, i64 0
  store i64 %v33, ptr %st21
  %v34.p = getelementptr i64, ptr %v32, i64 0
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v10, i64 1
  %v35 = load i64, ptr %v35.p
  %v36.c = icmp slt i64 %v34, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b3 = icmp ne i64 %v36, 0
  br i1 %c.b3, label %b3.t23, label %b3.e24
b3.t23:
  br label %b4
b3.e24:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v283 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v283, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v10, i64 0
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v10, i64 1
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v10, i64 2
  %v40 = load i64, ptr %v40.p
  %v41.p = getelementptr i64, ptr %v32, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = call i64 @"std/strings.runeEnd"(i64 %v38, i64 %v39, i64 %v40, i64 %v41)
  %v43 = add i64 0, 1
  %v44 = add i64 %v9, %v43
  %v45 = getelementptr i64, ptr %s4, i64 0
  %v46.p = getelementptr i64, ptr %v24, i64 0
  %v46 = load i64, ptr %v46.p
  %st24 = getelementptr i64, ptr %v45, i64 0
  store i64 %v46, ptr %st24
  %v47.p = getelementptr i64, ptr %v24, i64 1
  %v47 = load i64, ptr %v47.p
  %st25 = getelementptr i64, ptr %v45, i64 1
  store i64 %v47, ptr %st25
  %v48.p = getelementptr i64, ptr %v24, i64 2
  %v48 = load i64, ptr %v48.p
  %st26 = getelementptr i64, ptr %v45, i64 2
  store i64 %v48, ptr %st26
  %v49.p = getelementptr i64, ptr %v32, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.c = icmp slt i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b4 = icmp ne i64 %v51, 0
  br i1 %c.b4, label %b4.t28, label %b4.e29
b4.t28:
  br label %b6
b4.e29:
  br label %b7
b5:
  %v284 = getelementptr i64, ptr @"rt.meta", i64 0
  %st29 = getelementptr i64, ptr %v284, i64 0
  store i64 %v33, ptr %st29
  %v102.p = getelementptr i64, ptr %v24, i64 0
  %v102 = load i64, ptr %v102.p
  %st30 = getelementptr i64, ptr %v0, i64 0
  store i64 %v102, ptr %st30
  %v103.p = getelementptr i64, ptr %v24, i64 1
  %v103 = load i64, ptr %v103.p
  %st31 = getelementptr i64, ptr %v0, i64 1
  store i64 %v103, ptr %st31
  %v104.p = getelementptr i64, ptr %v24, i64 2
  %v104 = load i64, ptr %v104.p
  %st32 = getelementptr i64, ptr %v0, i64 2
  store i64 %v104, ptr %st32
  %v105.p = getelementptr i64, ptr %v0, i64 2
  %v105 = load i64, ptr %v105.p
  %v106.c = icmp sgt i64 %v105, %v9
  %v106 = zext i1 %v106.c to i64
  %c.b5 = icmp ne i64 %v106, 0
  br i1 %c.b5, label %b5.t34, label %b5.e35
b5.t34:
  br label %b15
b5.e35:
  br label %b16
b6:
  %v52 = add i64 0, 26
  call void @"rt.panic"(i64 %v52)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v53.c = icmp slt i64 %v42, %v49
  %v53 = zext i1 %v53.c to i64
  %c.b7 = icmp ne i64 %v53, 0
  br i1 %c.b7, label %b7.t36, label %b7.e37
b7.t36:
  br label %b8
b7.e37:
  br label %b9
b8:
  %v54 = add i64 0, 27
  call void @"rt.panic"(i64 %v54)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b9:
  %v55.p = getelementptr i64, ptr %v10, i64 1
  %v55 = load i64, ptr %v55.p
  %v56.c = icmp sgt i64 %v42, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b9 = icmp ne i64 %v56, 0
  br i1 %c.b9, label %b9.t38, label %b9.e39
b9.t38:
  br label %b10
b9.e39:
  br label %b11
b10:
  %v57 = add i64 0, 28
  call void @"rt.panic"(i64 %v57)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v58.p = getelementptr i64, ptr %v10, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = inttoptr i64 %v58 to ptr
  %v60 = getelementptr i8, ptr %v59, i64 %v49
  %v61 = sub i64 %v42, %v49
  %v62.p = getelementptr i64, ptr %v10, i64 2
  %v62 = load i64, ptr %v62.p
  %v63 = getelementptr i64, ptr %s7, i64 0
  %v64 = ptrtoint ptr %v60 to i64
  %st39 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st39
  %st40 = getelementptr i64, ptr %v63, i64 1
  store i64 %v61, ptr %st40
  %st41 = getelementptr i64, ptr %v63, i64 2
  store i64 %v62, ptr %st41
  %v65 = getelementptr i64, ptr %s8, i64 0
  %v66.p = getelementptr i64, ptr %v63, i64 0
  %v66 = load i64, ptr %v66.p
  %st42 = getelementptr i64, ptr %v65, i64 0
  store i64 %v66, ptr %st42
  %v67.p = getelementptr i64, ptr %v63, i64 1
  %v67 = load i64, ptr %v67.p
  %st43 = getelementptr i64, ptr %v65, i64 1
  store i64 %v67, ptr %st43
  %v68.p = getelementptr i64, ptr %v63, i64 2
  %v68 = load i64, ptr %v68.p
  %st44 = getelementptr i64, ptr %v65, i64 2
  store i64 %v68, ptr %st44
  %v69.p = getelementptr i64, ptr %v45, i64 2
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v45, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v45, i64 1
  %v71 = load i64, ptr %v71.p
  %v74 = add i64 0, 24
  %v75 = mul i64 %v71, %v74
  %v76 = add i64 %v70, %v75
  %v285 = getelementptr i64, ptr @"rt.meta", i64 0
  %v286 = getelementptr i64, ptr %v285, i64 %v69
  %v77.p = getelementptr i64, ptr %v286, i64 1
  %v77 = load ptr, ptr %v77.p
  %v78 = ptrtoint ptr %v77 to i64
  %v79.c = icmp eq i64 %v78, %v76
  %v79 = zext i1 %v79.c to i64
  %c.b11 = icmp ne i64 %v79, 0
  br i1 %c.b11, label %b11.t46, label %b11.e47
b11.t46:
  br label %b14
b11.e47:
  br label %b13
b12:
  %v72 = phi ptr [ %v87, %b13 ], [ %v82, %b14 ]
  %v73 = phi ptr [ %v88, %b13 ], [ %v81, %b14 ]
  call void @"rt.region_relocate8"(ptr %v65, i64 %v69)
  %v89.p = getelementptr i64, ptr %v65, i64 0
  %v89 = load i64, ptr %v89.p
  %st47 = getelementptr i64, ptr %v73, i64 0
  store i64 %v89, ptr %st47
  %v90.p = getelementptr i64, ptr %v65, i64 1
  %v90 = load i64, ptr %v90.p
  %st48 = getelementptr i64, ptr %v73, i64 1
  store i64 %v90, ptr %st48
  %v91.p = getelementptr i64, ptr %v65, i64 2
  %v91 = load i64, ptr %v91.p
  %st49 = getelementptr i64, ptr %v73, i64 2
  store i64 %v91, ptr %st49
  %v92.p = getelementptr i64, ptr %v45, i64 1
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 1
  %v94 = add i64 %v92, %v93
  %v95 = getelementptr i64, ptr %s9, i64 0
  %v96 = ptrtoint ptr %v72 to i64
  %st50 = getelementptr i64, ptr %v95, i64 0
  store i64 %v96, ptr %st50
  %st51 = getelementptr i64, ptr %v95, i64 1
  store i64 %v94, ptr %st51
  %st52 = getelementptr i64, ptr %v95, i64 2
  store i64 %v69, ptr %st52
  %v97.p = getelementptr i64, ptr %v95, i64 0
  %v97 = load i64, ptr %v97.p
  %st53 = getelementptr i64, ptr %v24, i64 0
  store i64 %v97, ptr %st53
  %v98.p = getelementptr i64, ptr %v95, i64 1
  %v98 = load i64, ptr %v98.p
  %st54 = getelementptr i64, ptr %v24, i64 1
  store i64 %v98, ptr %st54
  %v99.p = getelementptr i64, ptr %v95, i64 2
  %v99 = load i64, ptr %v99.p
  %st55 = getelementptr i64, ptr %v24, i64 2
  store i64 %v99, ptr %st55
  %v100 = add i64 0, 1
  %v101 = add i64 %v9, %v100
  %st56 = getelementptr i64, ptr %v32, i64 0
  store i64 %v42, ptr %st56
  br label %b3
b13:
  %v83 = add i64 0, 3
  %v84 = mul i64 %v71, %v83
  %v85 = add i64 0, 3
  %v86 = add i64 0, 1
  %v87 = call ptr @"rt.slice_grow"(i64 %v70, i64 %v71, i64 %v85, i64 %v69, i64 %v86)
  %v88 = getelementptr i64, ptr %v87, i64 %v84
  br label %b12
b14:
  %v80 = add i64 0, 3
  %v81 = call ptr @"rt.region_alloc"(i64 %v69, i64 %v80)
  %v82 = inttoptr i64 %v70 to ptr
  br label %b12
b15:
  %v107.p = getelementptr i64, ptr %v0, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = inttoptr i64 %v107 to ptr
  %v109.p = getelementptr i64, ptr %v0, i64 1
  %v109 = load i64, ptr %v109.p
  %v111 = add i64 0, 0
  br label %b17
b16:
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v287, i64 0
  store i64 %v9, ptr %st57
  ret void
b17:
  %v110 = phi i64 [ %v111, %b15 ], [ %v117, %b18 ]
  %v112.c = icmp slt i64 %v110, %v109
  %v112 = zext i1 %v112.c to i64
  %c.b17 = icmp ne i64 %v112, 0
  br i1 %c.b17, label %b17.t59, label %b17.e60
b17.t59:
  br label %b18
b17.e60:
  br label %b19
b18:
  %v113 = add i64 0, 3
  %v114 = mul i64 %v110, %v113
  %v115 = getelementptr i64, ptr %v108, i64 %v114
  call void @"rt.region_relocate8"(ptr %v115, i64 %v9)
  %v116 = add i64 0, 1
  %v117 = add i64 %v110, %v116
  br label %b17
b19:
  %v288 = add i64 0, 3
  call void @"rt.region_relocate"(ptr %v0, i64 %v288, i64 %v9)
  br label %b16
b20:
  %v118 = add i64 0, 0
  %v119 = getelementptr i64, ptr %s6, i64 0
  %st60 = getelementptr i64, ptr %v119, i64 0
  store i64 %v118, ptr %st60
  %v120.p = getelementptr i64, ptr %v10, i64 0
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v10, i64 1
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v10, i64 2
  %v122 = load i64, ptr %v122.p
  %v123 = add i64 0, 0
  %v124.p = getelementptr i64, ptr %v14, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v14, i64 1
  %v125 = load i64, ptr %v125.p
  %v126.p = getelementptr i64, ptr %v14, i64 2
  %v126 = load i64, ptr %v126.p
  %v127 = call i64 @"std/strings.indexAt"(i64 %v120, i64 %v121, i64 %v122, i64 %v123, i64 %v124, i64 %v125, i64 %v126)
  %v128 = getelementptr i64, ptr %s10, i64 0
  %st61 = getelementptr i64, ptr %v128, i64 0
  store i64 %v127, ptr %st61
  %v289 = getelementptr i64, ptr @"rt.meta", i64 0
  %v129.p = getelementptr i64, ptr %v289, i64 0
  %v129 = load i64, ptr %v129.p
  br label %b21
b21:
  %v290 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v290, i64 0
  store i64 %v129, ptr %st62
  %v130.p = getelementptr i64, ptr %v128, i64 0
  %v130 = load i64, ptr %v130.p
  %v131 = add i64 0, 0
  %v132.c = icmp sge i64 %v130, %v131
  %v132 = zext i1 %v132.c to i64
  %c.b21 = icmp ne i64 %v132, 0
  br i1 %c.b21, label %b21.t64, label %b21.e65
b21.t64:
  br label %b22
b21.e65:
  br label %b23
b22:
  call void @"rt.region_enter"()
  %v291 = getelementptr i64, ptr @"rt.meta", i64 0
  %v133.p = getelementptr i64, ptr %v291, i64 0
  %v133 = load i64, ptr %v133.p
  %v134 = add i64 0, 1
  %v135 = add i64 %v9, %v134
  %v136 = getelementptr i64, ptr %s9, i64 0
  %v137.p = getelementptr i64, ptr %v24, i64 0
  %v137 = load i64, ptr %v137.p
  %st65 = getelementptr i64, ptr %v136, i64 0
  store i64 %v137, ptr %st65
  %v138.p = getelementptr i64, ptr %v24, i64 1
  %v138 = load i64, ptr %v138.p
  %st66 = getelementptr i64, ptr %v136, i64 1
  store i64 %v138, ptr %st66
  %v139.p = getelementptr i64, ptr %v24, i64 2
  %v139 = load i64, ptr %v139.p
  %st67 = getelementptr i64, ptr %v136, i64 2
  store i64 %v139, ptr %st67
  %v140.p = getelementptr i64, ptr %v119, i64 0
  %v140 = load i64, ptr %v140.p
  %v141.p = getelementptr i64, ptr %v128, i64 0
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 0, 0
  %v143.c = icmp slt i64 %v140, %v142
  %v143 = zext i1 %v143.c to i64
  %c.b22 = icmp ne i64 %v143, 0
  br i1 %c.b22, label %b22.t69, label %b22.e70
b22.t69:
  br label %b24
b22.e70:
  br label %b25
b23:
  %v292 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v292, i64 0
  store i64 %v129, ptr %st70
  %v207 = getelementptr i64, ptr %s11, i64 0
  %v208.p = getelementptr i64, ptr %v24, i64 0
  %v208 = load i64, ptr %v208.p
  %st71 = getelementptr i64, ptr %v207, i64 0
  store i64 %v208, ptr %st71
  %v209.p = getelementptr i64, ptr %v24, i64 1
  %v209 = load i64, ptr %v209.p
  %st72 = getelementptr i64, ptr %v207, i64 1
  store i64 %v209, ptr %st72
  %v210.p = getelementptr i64, ptr %v24, i64 2
  %v210 = load i64, ptr %v210.p
  %st73 = getelementptr i64, ptr %v207, i64 2
  store i64 %v210, ptr %st73
  %v211.p = getelementptr i64, ptr %v119, i64 0
  %v211 = load i64, ptr %v211.p
  %v212.p = getelementptr i64, ptr %v10, i64 1
  %v212 = load i64, ptr %v212.p
  %v213 = add i64 0, 0
  %v214.c = icmp slt i64 %v211, %v213
  %v214 = zext i1 %v214.c to i64
  %c.b23 = icmp ne i64 %v214, 0
  br i1 %c.b23, label %b23.t75, label %b23.e76
b23.t75:
  br label %b33
b23.e76:
  br label %b34
b24:
  %v144 = add i64 0, 29
  call void @"rt.panic"(i64 %v144)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  %v145.c = icmp slt i64 %v141, %v140
  %v145 = zext i1 %v145.c to i64
  %c.b25 = icmp ne i64 %v145, 0
  br i1 %c.b25, label %b25.t77, label %b25.e78
b25.t77:
  br label %b26
b25.e78:
  br label %b27
b26:
  %v146 = add i64 0, 30
  call void @"rt.panic"(i64 %v146)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v147.p = getelementptr i64, ptr %v10, i64 1
  %v147 = load i64, ptr %v147.p
  %v148.c = icmp sgt i64 %v141, %v147
  %v148 = zext i1 %v148.c to i64
  %c.b27 = icmp ne i64 %v148, 0
  br i1 %c.b27, label %b27.t79, label %b27.e80
b27.t79:
  br label %b28
b27.e80:
  br label %b29
b28:
  %v149 = add i64 0, 31
  call void @"rt.panic"(i64 %v149)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b29:
  %v150.p = getelementptr i64, ptr %v10, i64 0
  %v150 = load i64, ptr %v150.p
  %v151 = inttoptr i64 %v150 to ptr
  %v152 = getelementptr i8, ptr %v151, i64 %v140
  %v153 = sub i64 %v141, %v140
  %v154.p = getelementptr i64, ptr %v10, i64 2
  %v154 = load i64, ptr %v154.p
  %v155 = getelementptr i64, ptr %s7, i64 0
  %v156 = ptrtoint ptr %v152 to i64
  %st80 = getelementptr i64, ptr %v155, i64 0
  store i64 %v156, ptr %st80
  %st81 = getelementptr i64, ptr %v155, i64 1
  store i64 %v153, ptr %st81
  %st82 = getelementptr i64, ptr %v155, i64 2
  store i64 %v154, ptr %st82
  %v157 = getelementptr i64, ptr %s4, i64 0
  %v158.p = getelementptr i64, ptr %v155, i64 0
  %v158 = load i64, ptr %v158.p
  %st83 = getelementptr i64, ptr %v157, i64 0
  store i64 %v158, ptr %st83
  %v159.p = getelementptr i64, ptr %v155, i64 1
  %v159 = load i64, ptr %v159.p
  %st84 = getelementptr i64, ptr %v157, i64 1
  store i64 %v159, ptr %st84
  %v160.p = getelementptr i64, ptr %v155, i64 2
  %v160 = load i64, ptr %v160.p
  %st85 = getelementptr i64, ptr %v157, i64 2
  store i64 %v160, ptr %st85
  %v161.p = getelementptr i64, ptr %v136, i64 2
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v136, i64 0
  %v162 = load i64, ptr %v162.p
  %v163.p = getelementptr i64, ptr %v136, i64 1
  %v163 = load i64, ptr %v163.p
  %v166 = add i64 0, 24
  %v167 = mul i64 %v163, %v166
  %v168 = add i64 %v162, %v167
  %v293 = getelementptr i64, ptr @"rt.meta", i64 0
  %v294 = getelementptr i64, ptr %v293, i64 %v161
  %v169.p = getelementptr i64, ptr %v294, i64 1
  %v169 = load ptr, ptr %v169.p
  %v170 = ptrtoint ptr %v169 to i64
  %v171.c = icmp eq i64 %v170, %v168
  %v171 = zext i1 %v171.c to i64
  %c.b29 = icmp ne i64 %v171, 0
  br i1 %c.b29, label %b29.t87, label %b29.e88
b29.t87:
  br label %b32
b29.e88:
  br label %b31
b30:
  %v164 = phi ptr [ %v179, %b31 ], [ %v174, %b32 ]
  %v165 = phi ptr [ %v180, %b31 ], [ %v173, %b32 ]
  call void @"rt.region_relocate8"(ptr %v157, i64 %v161)
  %v181.p = getelementptr i64, ptr %v157, i64 0
  %v181 = load i64, ptr %v181.p
  %st88 = getelementptr i64, ptr %v165, i64 0
  store i64 %v181, ptr %st88
  %v182.p = getelementptr i64, ptr %v157, i64 1
  %v182 = load i64, ptr %v182.p
  %st89 = getelementptr i64, ptr %v165, i64 1
  store i64 %v182, ptr %st89
  %v183.p = getelementptr i64, ptr %v157, i64 2
  %v183 = load i64, ptr %v183.p
  %st90 = getelementptr i64, ptr %v165, i64 2
  store i64 %v183, ptr %st90
  %v184.p = getelementptr i64, ptr %v136, i64 1
  %v184 = load i64, ptr %v184.p
  %v185 = add i64 0, 1
  %v186 = add i64 %v184, %v185
  %v187 = getelementptr i64, ptr %s11, i64 0
  %v188 = ptrtoint ptr %v164 to i64
  %st91 = getelementptr i64, ptr %v187, i64 0
  store i64 %v188, ptr %st91
  %st92 = getelementptr i64, ptr %v187, i64 1
  store i64 %v186, ptr %st92
  %st93 = getelementptr i64, ptr %v187, i64 2
  store i64 %v161, ptr %st93
  %v189.p = getelementptr i64, ptr %v187, i64 0
  %v189 = load i64, ptr %v189.p
  %st94 = getelementptr i64, ptr %v24, i64 0
  store i64 %v189, ptr %st94
  %v190.p = getelementptr i64, ptr %v187, i64 1
  %v190 = load i64, ptr %v190.p
  %st95 = getelementptr i64, ptr %v24, i64 1
  store i64 %v190, ptr %st95
  %v191.p = getelementptr i64, ptr %v187, i64 2
  %v191 = load i64, ptr %v191.p
  %st96 = getelementptr i64, ptr %v24, i64 2
  store i64 %v191, ptr %st96
  %v192 = add i64 0, 1
  %v193 = add i64 %v9, %v192
  %v194.p = getelementptr i64, ptr %v128, i64 0
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v14, i64 1
  %v195 = load i64, ptr %v195.p
  %v196 = add i64 %v194, %v195
  %st97 = getelementptr i64, ptr %v119, i64 0
  store i64 %v196, ptr %st97
  %v197 = add i64 0, 1
  %v198 = add i64 %v9, %v197
  %v199.p = getelementptr i64, ptr %v10, i64 0
  %v199 = load i64, ptr %v199.p
  %v200.p = getelementptr i64, ptr %v10, i64 1
  %v200 = load i64, ptr %v200.p
  %v201.p = getelementptr i64, ptr %v10, i64 2
  %v201 = load i64, ptr %v201.p
  %v202.p = getelementptr i64, ptr %v119, i64 0
  %v202 = load i64, ptr %v202.p
  %v203.p = getelementptr i64, ptr %v14, i64 0
  %v203 = load i64, ptr %v203.p
  %v204.p = getelementptr i64, ptr %v14, i64 1
  %v204 = load i64, ptr %v204.p
  %v205.p = getelementptr i64, ptr %v14, i64 2
  %v205 = load i64, ptr %v205.p
  %v206 = call i64 @"std/strings.indexAt"(i64 %v199, i64 %v200, i64 %v201, i64 %v202, i64 %v203, i64 %v204, i64 %v205)
  %st98 = getelementptr i64, ptr %v128, i64 0
  store i64 %v206, ptr %st98
  br label %b21
b31:
  %v175 = add i64 0, 3
  %v176 = mul i64 %v163, %v175
  %v177 = add i64 0, 3
  %v178 = add i64 0, 1
  %v179 = call ptr @"rt.slice_grow"(i64 %v162, i64 %v163, i64 %v177, i64 %v161, i64 %v178)
  %v180 = getelementptr i64, ptr %v179, i64 %v176
  br label %b30
b32:
  %v172 = add i64 0, 3
  %v173 = call ptr @"rt.region_alloc"(i64 %v161, i64 %v172)
  %v174 = inttoptr i64 %v162 to ptr
  br label %b30
b33:
  %v215 = add i64 0, 32
  call void @"rt.panic"(i64 %v215)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b34:
  %v216.c = icmp slt i64 %v212, %v211
  %v216 = zext i1 %v216.c to i64
  %c.b34 = icmp ne i64 %v216, 0
  br i1 %c.b34, label %b34.t100, label %b34.e101
b34.t100:
  br label %b35
b34.e101:
  br label %b36
b35:
  %v217 = add i64 0, 33
  call void @"rt.panic"(i64 %v217)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b36:
  %v218.p = getelementptr i64, ptr %v10, i64 1
  %v218 = load i64, ptr %v218.p
  %v219.c = icmp sgt i64 %v212, %v218
  %v219 = zext i1 %v219.c to i64
  %c.b36 = icmp ne i64 %v219, 0
  br i1 %c.b36, label %b36.t102, label %b36.e103
b36.t102:
  br label %b37
b36.e103:
  br label %b38
b37:
  %v220 = add i64 0, 34
  call void @"rt.panic"(i64 %v220)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b38:
  %v221.p = getelementptr i64, ptr %v10, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = inttoptr i64 %v221 to ptr
  %v223 = getelementptr i8, ptr %v222, i64 %v211
  %v224 = sub i64 %v212, %v211
  %v225.p = getelementptr i64, ptr %v10, i64 2
  %v225 = load i64, ptr %v225.p
  %v226 = getelementptr i64, ptr %s7, i64 0
  %v227 = ptrtoint ptr %v223 to i64
  %st103 = getelementptr i64, ptr %v226, i64 0
  store i64 %v227, ptr %st103
  %st104 = getelementptr i64, ptr %v226, i64 1
  store i64 %v224, ptr %st104
  %st105 = getelementptr i64, ptr %v226, i64 2
  store i64 %v225, ptr %st105
  %v228 = getelementptr i64, ptr %s9, i64 0
  %v229.p = getelementptr i64, ptr %v226, i64 0
  %v229 = load i64, ptr %v229.p
  %st106 = getelementptr i64, ptr %v228, i64 0
  store i64 %v229, ptr %st106
  %v230.p = getelementptr i64, ptr %v226, i64 1
  %v230 = load i64, ptr %v230.p
  %st107 = getelementptr i64, ptr %v228, i64 1
  store i64 %v230, ptr %st107
  %v231.p = getelementptr i64, ptr %v226, i64 2
  %v231 = load i64, ptr %v231.p
  %st108 = getelementptr i64, ptr %v228, i64 2
  store i64 %v231, ptr %st108
  %v232.p = getelementptr i64, ptr %v207, i64 2
  %v232 = load i64, ptr %v232.p
  %v233.p = getelementptr i64, ptr %v207, i64 0
  %v233 = load i64, ptr %v233.p
  %v234.p = getelementptr i64, ptr %v207, i64 1
  %v234 = load i64, ptr %v234.p
  %v237 = add i64 0, 24
  %v238 = mul i64 %v234, %v237
  %v239 = add i64 %v233, %v238
  %v295 = getelementptr i64, ptr @"rt.meta", i64 0
  %v296 = getelementptr i64, ptr %v295, i64 %v232
  %v240.p = getelementptr i64, ptr %v296, i64 1
  %v240 = load ptr, ptr %v240.p
  %v241 = ptrtoint ptr %v240 to i64
  %v242.c = icmp eq i64 %v241, %v239
  %v242 = zext i1 %v242.c to i64
  %c.b38 = icmp ne i64 %v242, 0
  br i1 %c.b38, label %b38.t110, label %b38.e111
b38.t110:
  br label %b41
b38.e111:
  br label %b40
b39:
  %v235 = phi ptr [ %v250, %b40 ], [ %v245, %b41 ]
  %v236 = phi ptr [ %v251, %b40 ], [ %v244, %b41 ]
  call void @"rt.region_relocate8"(ptr %v228, i64 %v232)
  %v252.p = getelementptr i64, ptr %v228, i64 0
  %v252 = load i64, ptr %v252.p
  %st111 = getelementptr i64, ptr %v236, i64 0
  store i64 %v252, ptr %st111
  %v253.p = getelementptr i64, ptr %v228, i64 1
  %v253 = load i64, ptr %v253.p
  %st112 = getelementptr i64, ptr %v236, i64 1
  store i64 %v253, ptr %st112
  %v254.p = getelementptr i64, ptr %v228, i64 2
  %v254 = load i64, ptr %v254.p
  %st113 = getelementptr i64, ptr %v236, i64 2
  store i64 %v254, ptr %st113
  %v255.p = getelementptr i64, ptr %v207, i64 1
  %v255 = load i64, ptr %v255.p
  %v256 = add i64 0, 1
  %v257 = add i64 %v255, %v256
  %v258 = getelementptr i64, ptr %s12, i64 0
  %v259 = ptrtoint ptr %v235 to i64
  %st114 = getelementptr i64, ptr %v258, i64 0
  store i64 %v259, ptr %st114
  %st115 = getelementptr i64, ptr %v258, i64 1
  store i64 %v257, ptr %st115
  %st116 = getelementptr i64, ptr %v258, i64 2
  store i64 %v232, ptr %st116
  %v260.p = getelementptr i64, ptr %v258, i64 0
  %v260 = load i64, ptr %v260.p
  %st117 = getelementptr i64, ptr %v24, i64 0
  store i64 %v260, ptr %st117
  %v261.p = getelementptr i64, ptr %v258, i64 1
  %v261 = load i64, ptr %v261.p
  %st118 = getelementptr i64, ptr %v24, i64 1
  store i64 %v261, ptr %st118
  %v262.p = getelementptr i64, ptr %v258, i64 2
  %v262 = load i64, ptr %v262.p
  %st119 = getelementptr i64, ptr %v24, i64 2
  store i64 %v262, ptr %st119
  %v263.p = getelementptr i64, ptr %v24, i64 0
  %v263 = load i64, ptr %v263.p
  %st120 = getelementptr i64, ptr %v0, i64 0
  store i64 %v263, ptr %st120
  %v264.p = getelementptr i64, ptr %v24, i64 1
  %v264 = load i64, ptr %v264.p
  %st121 = getelementptr i64, ptr %v0, i64 1
  store i64 %v264, ptr %st121
  %v265.p = getelementptr i64, ptr %v24, i64 2
  %v265 = load i64, ptr %v265.p
  %st122 = getelementptr i64, ptr %v0, i64 2
  store i64 %v265, ptr %st122
  %v266.p = getelementptr i64, ptr %v0, i64 2
  %v266 = load i64, ptr %v266.p
  %v267.c = icmp sgt i64 %v266, %v9
  %v267 = zext i1 %v267.c to i64
  %c.b39 = icmp ne i64 %v267, 0
  br i1 %c.b39, label %b39.t124, label %b39.e125
b39.t124:
  br label %b42
b39.e125:
  br label %b43
b40:
  %v246 = add i64 0, 3
  %v247 = mul i64 %v234, %v246
  %v248 = add i64 0, 3
  %v249 = add i64 0, 1
  %v250 = call ptr @"rt.slice_grow"(i64 %v233, i64 %v234, i64 %v248, i64 %v232, i64 %v249)
  %v251 = getelementptr i64, ptr %v250, i64 %v247
  br label %b39
b41:
  %v243 = add i64 0, 3
  %v244 = call ptr @"rt.region_alloc"(i64 %v232, i64 %v243)
  %v245 = inttoptr i64 %v233 to ptr
  br label %b39
b42:
  %v268.p = getelementptr i64, ptr %v0, i64 0
  %v268 = load i64, ptr %v268.p
  %v269 = inttoptr i64 %v268 to ptr
  %v270.p = getelementptr i64, ptr %v0, i64 1
  %v270 = load i64, ptr %v270.p
  %v272 = add i64 0, 0
  br label %b44
b43:
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %st125 = getelementptr i64, ptr %v297, i64 0
  store i64 %v9, ptr %st125
  ret void
b44:
  %v271 = phi i64 [ %v272, %b42 ], [ %v278, %b45 ]
  %v273.c = icmp slt i64 %v271, %v270
  %v273 = zext i1 %v273.c to i64
  %c.b44 = icmp ne i64 %v273, 0
  br i1 %c.b44, label %b44.t127, label %b44.e128
b44.t127:
  br label %b45
b44.e128:
  br label %b46
b45:
  %v274 = add i64 0, 3
  %v275 = mul i64 %v271, %v274
  %v276 = getelementptr i64, ptr %v269, i64 %v275
  call void @"rt.region_relocate8"(ptr %v276, i64 %v9)
  %v277 = add i64 0, 1
  %v278 = add i64 %v271, %v277
  br label %b44
b46:
  %v298 = add i64 0, 3
  call void @"rt.region_relocate"(ptr %v0, i64 %v298, i64 %v9)
  br label %b43
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
  %v44 = add i64 0, 38
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
  %v46 = add i64 0, 39
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
  %v49 = add i64 0, 40
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
  %v62 = add i64 0, 41
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
  %v64 = add i64 0, 42
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
  %v67 = add i64 0, 43
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
  %v45 = add i64 0, 44
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
  %v47 = add i64 0, 45
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
  %v50 = add i64 0, 46
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
  %v63 = add i64 0, 47
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
  %v65 = add i64 0, 48
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
  %v68 = add i64 0, 49
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
  %v17 = add i64 0, 54
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
