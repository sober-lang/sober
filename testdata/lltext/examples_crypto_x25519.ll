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
@"str.0" = internal constant [1 x i64] [i64 6451042]
@"str.1" = internal constant [1 x i64] [i64 828597874]
@"str.2" = internal constant [1 x i64] [i64 845375090]
@"str.3" = internal constant [1 x i64] [i64 1919508848]
@"str.4" = internal constant [1 x i64] [i64 212372649065]
@"str.5" = internal constant [1 x i64] [i64 435459550305]
@"str.6" = internal constant [1 x i64] [i64 110386873460851]
@"str.7" = internal constant [1 x i64] [i64 13563787812893801]
@"str.8" = internal constant [8 x i64] [i64 3472328296227682608, i64 3472328296227680304, i64 3472328296227680304, i64 3472328296227680304, i64 3472328296227680304, i64 3472328296227680304, i64 3472328296227680304, i64 3472328296227680304]
@"str.9" = internal constant [8 x i64] [i64 3545238222317629794, i64 3616499576577013813, i64 4121692386155182128, i64 7003490184119728435, i64 7306301174636229217, i64 4135211762086732849, i64 7219664069986706738, i64 7003155905976296037]
@"str.10" = internal constant [8 x i64] [i64 3616784332925056357, i64 3703138881071626295, i64 7221861997323891814, i64 7147887026819511600, i64 3472617696261321011, i64 7292281293149267510, i64 4121978264228225894, i64 3691038961715722083]
@"str.11" = internal constant [8 x i64] [i64 3630245864321201204, i64 3977294439698817847, i64 3846409863177004080, i64 7004564604511675494, i64 4123386527451788898, i64 7148962148036000051, i64 3834588820359361842, i64 3617852190761695538]
@"str.12" = internal constant [8 x i64] [i64 3689119034025207137, i64 3618468797693911650, i64 3544386100853629541, i64 7147320584977135415, i64 3487533662464063536, i64 7149571500041320753, i64 7162466568908386658, i64 3761969346639914081]
@"str.13" = internal constant [8 x i64] [i64 3761742864421512035, i64 3546978551720272996, i64 7076343824559519287, i64 4121411831039867184, i64 7220731677876117860, i64 3616445916161193520, i64 3473176020585363811, i64 3544392488227976247]
@"str.14" = internal constant [8 x i64] [i64 3763150445466563897, i64 7221293549829305911, i64 7148677593600975159, i64 4063992026010629218, i64 4050531796087300664, i64 3617852170058676535, i64 3762255450887042661, i64 3978148755905012023]
@"str.15" = internal constant [8 x i64] [i64 3775205494507332148, i64 7148117739513721188, i64 3546925770752680245, i64 3847869817872135481, i64 3544953264874271075, i64 3775196471505530981, i64 7293920656463323954, i64 7219377277152344375]
@"str.16" = internal constant [8 x i64] [i64 3977581399281775459, i64 3474868387285656633, i64 7220503189877515576, i64 7364573071148593766, i64 3688560671871808051, i64 3991932233667655988, i64 3834031337952654389, i64 3617856391141734199]
@"str.17" = internal constant [2 x i64] [i64 3978425819141910832, i64 7378413942531504440]
@"str.18" = internal constant [8 x i64] [i64 3978429127058536037, i64 7089844709798131765, i64 3774352264860874035, i64 7149295312121771058, i64 7162188172665172535, i64 7076057933550859826, i64 3918469433003159601, i64 7148447572298903652]
@"str.19" = internal constant [8 x i64] [i64 3991425559898973029, i64 7378364468800600376, i64 7292788374298965046, i64 7162238973454149219, i64 3978148751657678178, i64 3472664768297526067, i64 3630804214331357236, i64 3833462010056816995]
@"str.20" = internal constant [1 x i64] [i64 5207098233617336653]
@"str.21" = internal constant [8 x i64] [i64 7003207604578039607, i64 7221299219182727991, i64 3618415127796212531, i64 3833748789200564533, i64 3979042637380609636, i64 7003723288302281317, i64 3846463747903664482, i64 7003769437876806705]
@"str.22" = internal constant [8 x i64] [i64 7005179038254903860, i64 7161347261034803766, i64 7292280180833464673, i64 7365979354358243890, i64 7077187333920471095, i64 4050814366213748322, i64 3688510102068159283, i64 4122816981183312177]
@"str.23" = internal constant [8 x i64] [i64 7076672587139735860, i64 3559361248118387809, i64 3775813310477775415, i64 3833238590082723896, i64 4135202975372488805, i64 3689403816062760756, i64 7148165031331771959, i64 3617577085187482929]
@"str.24" = internal constant [8 x i64] [i64 7076900374253417825, i64 7221912566181998694, i64 7076339399984767539, i64 7234018180680921656, i64 7003206496426209846, i64 4049124421911589219, i64 3761686780721901621, i64 3774967810983485794]
@"str.25" = internal constant [8 x i64] [i64 7293359902009943093, i64 7076387809282765366, i64 7077519201650686263, i64 3919650308337709880, i64 4121410907621516854, i64 7234529646894724658, i64 3977349415293838129, i64 7090126399657764454]
@"str.26" = internal constant [2 x i64] [i64 7598263500303858035, i64 99]
@"str.27" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.28" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.29" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.30" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.31" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.32" = internal constant [1 x i64] [i64 2685]
@"str.33" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.34" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.35" = internal constant [1 x i64] [i64 35899498962976]
@"str.36" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.37" = internal constant [1 x i64] [i64 139141276781]
@"str.38" = internal constant [1 x i64] [i64 10]
@"str.39" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [87 x i64] [i64 8725724647129091, i64 6473925001216257, i64 9851624721744129, i64 7881300639744513, i64 3659176022639105, i64 1688851185664513, i64 4222125992837633, i64 1688851202441729, i64 1688851353436673, i64 6473925991072257, i64 2814751293833729, i64 1688851420545537, i64 1688851437322753, i64 4785076248248833, i64 7036876061934084, i64 4503601875517953, i64 7599826619335169, i64 5910976775848449, i64 2814752032031233, i64 5910976792625665, i64 2814752048808449, i64 1688852427178497, i64 1688852443955713, i64 1688852460732929, i64 1688852477510145, i64 1688852494287361, i64 6192452205543937, i64 8162777042518529, i64 9851626902782465, i64 12947851646599681, i64 15762601413706241, i64 18858826157523457, i64 21673575924630017, i64 24769800668447233, i64 27584550435553793, i64 30680775179371009, i64 6192452289430017, i64 13229326707196417, i64 14918176567460353, i64 23080950892069377, i64 25895700659175937, i64 34058474983784961, i64 36873224750891521, i64 45035999075500545, i64 47850748842607105, i64 56013523167216129, i64 3377702790758913, i64 3377702807536129, i64 3377702824313345, i64 3377702841090561, i64 3377702857867777, i64 3377702874644993, i64 3377702891422209, i64 3377702908199425, i64 3377702924976641, i64 3377702941753857, i64 2814753357431297, i64 1688853484143105, i64 2814753625866753, i64 6192453396726273, i64 9288678140543492, i64 7881303273767425, i64 14073752761401860, i64 2814753692975617, i64 4503603670680065, i64 3096228803904001, i64 3096228820681217, i64 3096228837458433, i64 3096228854235649, i64 3377703847723521, i64 3377703864500737, i64 3377703881277953, i64 3377703898055169, i64 3377703914832385, i64 7599828682932737, i64 12103428310303233, i64 15199653054120452, i64 20829152588333572, i64 3377704032272897, i64 9288678610305537, i64 8162778703462915, i64 5348024825938689, i64 9288674516665089, i64 9288674533442305, i64 6755400045036289, i64 6755400061813505, i64 8725724965896963]
@"str.40" = internal constant [1 x i64] [i64 9071397899755888]
@"str.41" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.42" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.43" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.44" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.45" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.46" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.47" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.48" = internal constant [1 x i64] [i64 544497952]
@"str.49" = internal constant [3 x i64] [i64 8673773953232761443, i64 8030813383705310514, i64 7497058]
@"str.50" = internal constant [3 x i64] [i64 8104634774752359539, i64 8030813637946863476, i64 7497058]
@"str.51" = internal constant [4 x i64] [i64 8104634774752359539, i64 3545798772505145204, i64 4121133636616990521, i64 125779768734510]
@"str.52" = internal constant [3 x i64] [i64 3420595415134008435, i64 7305524086039930216, i64 114]

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
  %v3 = getelementptr i64, ptr @"str.27", i64 0
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
  %v29 = getelementptr i64, ptr @"str.31", i64 0
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
  %v35 = getelementptr i64, ptr @"str.32", i64 0
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
  %v10 = getelementptr i64, ptr @"str.28", i64 0
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
  %v17 = getelementptr i64, ptr @"str.29", i64 0
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
  %v24 = getelementptr i64, ptr @"str.30", i64 0
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
  %v60 = getelementptr i64, ptr @"str.33", i64 0
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
  %v65 = getelementptr i64, ptr @"str.34", i64 0
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
  %v70 = getelementptr i64, ptr @"str.32", i64 0
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
  %v81 = getelementptr i64, ptr @"str.35", i64 0
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
  %v88 = getelementptr i64, ptr @"str.36", i64 0
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
  %v0 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v0, i64 2573
  %v1 = load i64, ptr %v1.p
  %v2 = add i64 0, 1099511627776
  %v3 = and i64 %v1, %v2
  %v4 = add i64 0, 0
  %v5.c = icmp eq i64 %v3, %v4
  %v5 = zext i1 %v5.c to i64
  %c.b0 = icmp ne i64 %v5, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v6 = add i64 0, 157
  %v7 = add i64 0, 66
  %v8 = add i64 0, 0
  %v9 = add i64 0, 0
  %v10 = add i64 0, 0
  %v11 = add i64 0, 0
  %v12 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},~{rcx},~{r11},~{memory}"(i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11)
  call void @"rt.flush"()
  %v13 = add i64 0, 2
  %st2 = getelementptr i64, ptr %v0, i64 1026
  store i64 %v13, ptr %st2
  %v14 = getelementptr i64, ptr @"str.37", i64 0
  %v15 = add i64 0, 5
  %v16 = add i64 0, 0
  %v17 = getelementptr i64, ptr %s0, i64 0
  %v18 = ptrtoint ptr %v14 to i64
  %st3 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st3
  %st4 = getelementptr i64, ptr %v17, i64 1
  store i64 %v15, ptr %st4
  %st5 = getelementptr i64, ptr %v17, i64 2
  store i64 %v16, ptr %st5
  call void @"rt.print_str"(ptr %v17)
  call void @"rt.print_int"(i64 %v12)
  %v19 = getelementptr i64, ptr @"str.38", i64 0
  %v20 = add i64 0, 1
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s1, i64 0
  %v23 = ptrtoint ptr %v19 to i64
  %st6 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st6
  %st7 = getelementptr i64, ptr %v22, i64 1
  store i64 %v20, ptr %st7
  %st8 = getelementptr i64, ptr %v22, i64 2
  store i64 %v21, ptr %st8
  call void @"rt.print_str"(ptr %v22)
  call void @"rt.flush"()
  %v24 = add i64 0, 1
  %st9 = getelementptr i64, ptr %v0, i64 1026
  store i64 %v24, ptr %st9
  br label %b2
b2:
  %v25.p = getelementptr i64, ptr %v0, i64 2573
  %v25 = load i64, ptr %v25.p
  %v26 = add i64 0, 1099511627775
  %v27 = and i64 %v25, %v26
  %v28 = add i64 0, 0
  %v29.c = icmp eq i64 %v27, %v28
  %v29 = zext i1 %v29.c to i64
  %c.b2 = icmp ne i64 %v29, 0
  br i1 %c.b2, label %b2.t11, label %b2.e12
b2.t11:
  br label %b4
b2.e12:
  br label %b3
b3:
  %v32 = add i64 0, 1023
  br label %b5
b4:
  ret void
b5:
  %v30 = phi i64 [ %v32, %b3 ], [ %v41, %b6.e16 ]
  %v33 = add i64 0, 0
  %v34.c = icmp sgt i64 %v30, %v33
  %v34 = zext i1 %v34.c to i64
  %v35 = add i64 0, 0
  %c.b5 = icmp ne i64 %v34, 0
  br i1 %c.b5, label %b5.t13, label %b5.e14
b5.t13:
  br label %b6
b5.e14:
  br label %b7
b6:
  %v36 = getelementptr i64, ptr %v0, i64 %v30
  %v37.p = getelementptr i64, ptr %v36, i64 1
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 0
  %v39.c = icmp ne i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %v40 = add i64 0, 1
  %v41 = sub i64 %v30, %v40
  %c.b6 = icmp ne i64 %v39, 0
  br i1 %c.b6, label %b6.t15, label %b6.e16
b6.t15:
  br label %b7
b6.e16:
  br label %b5
b7:
  %v31 = phi i64 [ %v35, %b5.e14 ], [ %v30, %b6.t15 ]
  call void @"rt.flush"()
  %v42 = add i64 0, 2
  %st16 = getelementptr i64, ptr %v0, i64 1026
  store i64 %v42, ptr %st16
  %v43 = getelementptr i64, ptr @"str.39", i64 0
  %v44 = add i64 0, 18
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s2, i64 0
  %v47 = ptrtoint ptr %v43 to i64
  %st17 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st17
  %st18 = getelementptr i64, ptr %v46, i64 1
  store i64 %v44, ptr %st18
  %st19 = getelementptr i64, ptr %v46, i64 2
  store i64 %v45, ptr %st19
  call void @"rt.print_str"(ptr %v46)
  call void @"rt.print_int"(i64 %v31)
  %v48 = getelementptr i64, ptr @"str.32", i64 0
  %v49 = add i64 0, 2
  %v50 = add i64 0, 0
  %v51 = getelementptr i64, ptr %s3, i64 0
  %v52 = ptrtoint ptr %v48 to i64
  %st20 = getelementptr i64, ptr %v51, i64 0
  store i64 %v52, ptr %st20
  %st21 = getelementptr i64, ptr %v51, i64 1
  store i64 %v49, ptr %st21
  %st22 = getelementptr i64, ptr %v51, i64 2
  store i64 %v50, ptr %st22
  call void @"rt.print_str"(ptr %v51)
  call void @"rt.flush"()
  %v53 = add i64 0, 1
  %st23 = getelementptr i64, ptr %v0, i64 1026
  store i64 %v53, ptr %st23
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
  %v28 = add i64 0, 0
  ret i64 %v28
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
  %v31 = add i64 0, 0
  ret i64 %v31
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
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %v65 = getelementptr i64, ptr %v64, i64 %v2
  %v5.p = getelementptr i64, ptr %v65, i64 1
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
  %v23 = phi i64 [ %v54, %b15 ], [ %v58, %b17 ]
  %v61 = add i64 0, 3
  %v62 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %v61, i64 %v17)
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v63, i64 1027
  store i64 %v23, ptr %st11
  ret void
b7:
  %v34 = phi i64 [ %v40, %b8 ], [ %v39, %b9 ]
  %v41.p = getelementptr i64, ptr %v1, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v1, i64 1
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 %v41, %v42
  call void @"rt.extend8"(i64 %v2, i64 %v43, i64 %v34)
  %v44 = add i64 0, 0
  %v45 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %v44, i64 %v17, i64 %v43, i64 %v34)
  %v47 = add i64 0, 0
  %v48.c = icmp sgt i64 %v45, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b7 = icmp ne i64 %v48, 0
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
  %v46 = phi i64 [ %v45, %b11 ], [ %v49, %b12 ]
  call void @"rt.extend8"(i64 %v2, i64 %v43, i64 %v46)
  %v50 = add i64 0, -4
  %v51.c = icmp eq i64 %v45, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b10 = icmp ne i64 %v51, 0
  br i1 %c.b10, label %b10.t15, label %b10.e16
b10.t15:
  br label %b13
b10.e16:
  br label %b14
b11:
  br label %b10
b12:
  %v49 = add i64 0, 0
  br label %b10
b13:
  br label %b5
b14:
  %v52 = add i64 0, 0
  %v53.c = icmp eq i64 %v45, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b14 = icmp ne i64 %v53, 0
  br i1 %c.b14, label %b14.t17, label %b14.e18
b14.t17:
  br label %b15
b14.e18:
  br label %b16
b15:
  %v54 = add i64 0, 0
  br label %b6
b16:
  %v55 = add i64 0, 0
  %v56.c = icmp slt i64 %v45, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b16 = icmp ne i64 %v56, 0
  br i1 %c.b16, label %b16.t19, label %b16.e20
b16.t19:
  br label %b17
b16.e20:
  br label %b18
b17:
  %v57 = add i64 0, 0
  %v58 = sub i64 %v57, %v45
  br label %b6
b18:
  %v59.p = getelementptr i64, ptr %v1, i64 1
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 %v59, %v45
  %st20 = getelementptr i64, ptr %v1, i64 1
  store i64 %v60, ptr %st20
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
  %v27 = add i64 0, 1
  %v28 = add i64 %v19, %v27
  %v29.p = getelementptr i64, ptr %v0, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v0, i64 1
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 %v29, %v30
  call void @"rt.extend8"(i64 %v2, i64 %v31, i64 %v28)
  %v32 = inttoptr i64 %v31 to ptr
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
  %v56 = add i64 0, 2
  %v57 = add i64 %v48, %v56
  %v58.p = getelementptr i64, ptr %v1, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v1, i64 1
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 %v58, %v59
  call void @"rt.extend8"(i64 %v2, i64 %v60, i64 %v57)
  %v61 = inttoptr i64 %v60 to ptr
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

define internal void @"main.unhex"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
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
  %s2 = alloca [3 x i64], align 8
  %s2.z0 = getelementptr i64, ptr %s2, i64 0
  store i64 0, ptr %s2.z0
  %s2.z1 = getelementptr i64, ptr %s2, i64 1
  store i64 0, ptr %s2.z1
  %s2.z2 = getelementptr i64, ptr %s2, i64 2
  store i64 0, ptr %s2.z2
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v30 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v30, i64 0
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
  call void @"std/hex.Parse"(ptr %v16, i64 %v17, i64 %v18, i64 %v19)
  %v21 = add i64 0, 3
  %v22 = getelementptr i64, ptr %v16, i64 %v21
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24.p = getelementptr i64, ptr %v16, i64 0
  %v24 = load i64, ptr %v24.p
  %st5 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st5
  %v25.p = getelementptr i64, ptr %v16, i64 1
  %v25 = load i64, ptr %v25.p
  %st6 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st6
  %v26.p = getelementptr i64, ptr %v16, i64 2
  %v26 = load i64, ptr %v26.p
  %st7 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st7
  %v27.p = getelementptr i64, ptr %v23, i64 0
  %v27 = load i64, ptr %v27.p
  %st8 = getelementptr i64, ptr %v0, i64 0
  store i64 %v27, ptr %st8
  %v28.p = getelementptr i64, ptr %v23, i64 1
  %v28 = load i64, ptr %v28.p
  %st9 = getelementptr i64, ptr %v0, i64 1
  store i64 %v28, ptr %st9
  %v29.p = getelementptr i64, ptr %v23, i64 2
  %v29 = load i64, ptr %v29.p
  %st10 = getelementptr i64, ptr %v0, i64 2
  store i64 %v29, ptr %st10
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v31 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v31, i64 0
  store i64 %v5, ptr %st11
  ret void
}

define internal void @"main.key"(ptr %v0, i64 %v1) #0 {
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
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v88, i64 0
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
  %v22 = add i64 0, 2654435761
  %v23 = mul i64 %v1, %v22
  %v24 = add i64 0, 12345
  %v25 = add i64 %v23, %v24
  %v26 = getelementptr i64, ptr %s2, i64 0
  %st7 = getelementptr i64, ptr %v26, i64 0
  store i64 %v25, ptr %st7
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v89, i64 0
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 0, 0
  %v29 = add i64 0, 32
  %v30 = getelementptr i64, ptr %s3, i64 0
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %v31.p = getelementptr i64, ptr %v90, i64 0
  %v31 = load i64, ptr %v31.p
  %v32 = getelementptr i64, ptr %s4, i64 0
  %st8 = getelementptr i64, ptr %v32, i64 0
  store i64 %v28, ptr %st8
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %v33.p = getelementptr i64, ptr %v91, i64 0
  %v33 = load i64, ptr %v33.p
  br label %b3
b1:
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v92, i64 0
  store i64 %v27, ptr %st9
  %v85.p = getelementptr i64, ptr %v18, i64 0
  %v85 = load i64, ptr %v85.p
  %st10 = getelementptr i64, ptr %v0, i64 0
  store i64 %v85, ptr %st10
  %v86.p = getelementptr i64, ptr %v18, i64 1
  %v86 = load i64, ptr %v86.p
  %st11 = getelementptr i64, ptr %v0, i64 1
  store i64 %v86, ptr %st11
  %v87.p = getelementptr i64, ptr %v18, i64 2
  %v87 = load i64, ptr %v87.p
  %st12 = getelementptr i64, ptr %v0, i64 2
  store i64 %v87, ptr %st12
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v93, i64 0
  store i64 %v2, ptr %st13
  ret void
b2:
  br label %b1
b3:
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v94, i64 0
  store i64 %v33, ptr %st14
  %v34.p = getelementptr i64, ptr %v32, i64 0
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp slt i64 %v34, %v29
  %v35 = zext i1 %v35.c to i64
  %c.b3 = icmp ne i64 %v35, 0
  br i1 %c.b3, label %b3.t16, label %b3.e17
b3.t16:
  br label %b4
b3.e17:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v95, i64 0
  %v36 = load i64, ptr %v36.p
  %v37.p = getelementptr i64, ptr %v32, i64 0
  %v37 = load i64, ptr %v37.p
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v96, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 1
  %v40 = add i64 %v2, %v39
  %v41.p = getelementptr i64, ptr %v26, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 6364136223846793005
  %v43 = mul i64 %v41, %v42
  %v44 = add i64 0, 1442695040888963407
  %v45 = add i64 %v43, %v44
  %st17 = getelementptr i64, ptr %v26, i64 0
  store i64 %v45, ptr %st17
  %v46 = add i64 0, 1
  %v47 = add i64 %v2, %v46
  %v48 = getelementptr i64, ptr %s0, i64 0
  %v49.p = getelementptr i64, ptr %v18, i64 0
  %v49 = load i64, ptr %v49.p
  %st18 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st18
  %v50.p = getelementptr i64, ptr %v18, i64 1
  %v50 = load i64, ptr %v50.p
  %st19 = getelementptr i64, ptr %v48, i64 1
  store i64 %v50, ptr %st19
  %v51.p = getelementptr i64, ptr %v18, i64 2
  %v51 = load i64, ptr %v51.p
  %st20 = getelementptr i64, ptr %v48, i64 2
  store i64 %v51, ptr %st20
  %v52.p = getelementptr i64, ptr %v26, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 0, 33
  %v54.n = and i64 %v53, 63
  %v54 = ashr i64 %v52, %v54.n
  %v55 = add i64 0, 255
  %v56 = and i64 %v54, %v55
  %v57 = add i64 0, 256
  %v58.c = icmp uge i64 %v56, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b4 = icmp ne i64 %v58, 0
  br i1 %c.b4, label %b4.t22, label %b4.e23
b4.t22:
  br label %b7
b4.e23:
  br label %b8
b5:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v97, i64 0
  store i64 %v33, ptr %st23
  br label %b2
b6:
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v98, i64 0
  store i64 %v38, ptr %st24
  %v82 = add i64 0, 1
  %v83.p = getelementptr i64, ptr %v32, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 %v83, %v82
  %st25 = getelementptr i64, ptr %v32, i64 0
  store i64 %v84, ptr %st25
  br label %b3
b7:
  %v59 = add i64 0, 0
  call void @"rt.panic"(i64 %v59)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v60.p = getelementptr i64, ptr %v48, i64 2
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v48, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v48, i64 1
  %v62 = load i64, ptr %v62.p
  %v65 = add i64 %v61, %v62
  %v66 = call i64 @"rt.tip8"(i64 %v60, i64 %v65)
  %v67 = add i64 0, 0
  %v68.c = icmp ne i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b8 = icmp ne i64 %v68, 0
  br i1 %c.b8, label %b8.t27, label %b8.e28
b8.t27:
  br label %b11
b8.e28:
  br label %b10
b9:
  %v63 = phi ptr [ %v72, %b10 ], [ %v69, %b11 ]
  %v64 = phi ptr [ %v73, %b10 ], [ %v70, %b11 ]
  %st28 = getelementptr i8, ptr %v64, i64 0
  %st28.b = trunc i64 %v56 to i8
  store i8 %st28.b, ptr %st28
  %v74.p = getelementptr i64, ptr %v48, i64 1
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 1
  %v76 = add i64 %v74, %v75
  %v77 = getelementptr i64, ptr %s5, i64 0
  %v78 = ptrtoint ptr %v63 to i64
  %st29 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st29
  %st30 = getelementptr i64, ptr %v77, i64 1
  store i64 %v76, ptr %st30
  %st31 = getelementptr i64, ptr %v77, i64 2
  store i64 %v60, ptr %st31
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %st32 = getelementptr i64, ptr %v18, i64 0
  store i64 %v79, ptr %st32
  %v80.p = getelementptr i64, ptr %v77, i64 1
  %v80 = load i64, ptr %v80.p
  %st33 = getelementptr i64, ptr %v18, i64 1
  store i64 %v80, ptr %st33
  %v81.p = getelementptr i64, ptr %v77, i64 2
  %v81 = load i64, ptr %v81.p
  %st34 = getelementptr i64, ptr %v18, i64 2
  store i64 %v81, ptr %st34
  br label %b6
b10:
  %v71 = add i64 0, 1
  %v72 = call ptr @"rt.slice_grow8"(i64 %v61, i64 %v62, i64 %v60, i64 %v71)
  %v73 = getelementptr i8, ptr %v72, i64 %v62
  br label %b9
b11:
  %v69 = inttoptr i64 %v61 to ptr
  %v70 = getelementptr i8, ptr %v69, i64 %v62
  br label %b9
}

define internal void @"main.show"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v41, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v10, i64 2571
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v10, i64 2571
  store i64 %v12, ptr %st6
  %v13 = add i64 0, 1
  %v14.c = icmp sge i64 %v11, %v13
  %v14 = zext i1 %v14.c to i64
  %v15.c = icmp sle i64 %v11, %v9
  %v15 = zext i1 %v15.c to i64
  %v16 = and i64 %v14, %v15
  %v17 = sub i64 %v11, %v9
  %v18 = mul i64 %v16, %v17
  %v19 = add i64 %v9, %v18
  call void @"rt.region_enter"()
  %v20.p = getelementptr i64, ptr %v7, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v7, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v7, i64 2
  %v22 = load i64, ptr %v22.p
  %v23 = getelementptr i64, ptr %s2, i64 0
  %v24.p = getelementptr i64, ptr %v8, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v8, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v8, i64 2
  %v26 = load i64, ptr %v26.p
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v27, i64 2571
  store i64 %v19, ptr %st7
  call void @"main.unhex"(ptr %v23, i64 %v24, i64 %v25, i64 %v26)
  %v28.p = getelementptr i64, ptr %v23, i64 0
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v23, i64 1
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v23, i64 2
  %v30 = load i64, ptr %v30.p
  %v31 = call i64 @"std/crypto.Equal"(i64 %v20, i64 %v21, i64 %v22, i64 %v28, i64 %v29, i64 %v30)
  %c.b0 = icmp ne i64 %v31, 0
  br i1 %c.b0, label %b0.t9, label %b0.e10
b0.t9:
  br label %b1
b0.e10:
  br label %b2
b1:
  br label %b3
b2:
  %v32 = getelementptr i64, ptr @"str.20", i64 0
  %v33 = add i64 0, 8
  %v34 = add i64 0, 0
  %v35 = getelementptr i64, ptr %s3, i64 0
  %v36 = ptrtoint ptr %v32 to i64
  %st10 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st10
  %st11 = getelementptr i64, ptr %v35, i64 1
  store i64 %v33, ptr %st11
  %st12 = getelementptr i64, ptr %v35, i64 2
  store i64 %v34, ptr %st12
  br label %b3
b3:
  %v37 = phi ptr [ %v8, %b1 ], [ %v35, %b2 ]
  %v38.p = getelementptr i64, ptr %v37, i64 0
  %v38 = load i64, ptr %v38.p
  %st13 = getelementptr i64, ptr %v0, i64 0
  store i64 %v38, ptr %st13
  %v39.p = getelementptr i64, ptr %v37, i64 1
  %v39 = load i64, ptr %v39.p
  %st14 = getelementptr i64, ptr %v0, i64 1
  store i64 %v39, ptr %st14
  %v40.p = getelementptr i64, ptr %v37, i64 2
  %v40 = load i64, ptr %v40.p
  %st15 = getelementptr i64, ptr %v0, i64 2
  store i64 %v40, ptr %st15
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v42, i64 0
  store i64 %v9, ptr %st16
  ret void
}

define internal void @"main.pairWant"(ptr %v0, i64 %v1) #0 {
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
  %v34 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v34, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v3 = add i64 0, 0
  %v4.c = icmp eq i64 %v1, %v3
  %v4 = zext i1 %v4.c to i64
  %c.b0 = icmp ne i64 %v4, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b2
b0.e2:
  br label %b1
b1:
  %v10 = add i64 0, 4
  %v11.c = icmp eq i64 %v1, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b1 = icmp ne i64 %v11, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b4
b1.e4:
  br label %b3
b2:
  %v5 = getelementptr i64, ptr @"str.12", i64 0
  %v6 = add i64 0, 64
  %v7 = add i64 0, 0
  %v8 = getelementptr i64, ptr %s0, i64 0
  %v9 = ptrtoint ptr %v5 to i64
  %st4 = getelementptr i64, ptr %v8, i64 0
  store i64 %v9, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 1
  store i64 %v6, ptr %st5
  %st6 = getelementptr i64, ptr %v8, i64 2
  store i64 %v7, ptr %st6
  br label %b8
b3:
  %v17 = add i64 0, 8
  %v18.c = icmp eq i64 %v1, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b3 = icmp ne i64 %v18, 0
  br i1 %c.b3, label %b3.t8, label %b3.e9
b3.t8:
  br label %b6
b3.e9:
  br label %b5
b4:
  %v12 = getelementptr i64, ptr @"str.11", i64 0
  %v13 = add i64 0, 64
  %v14 = add i64 0, 0
  %v15 = getelementptr i64, ptr %s1, i64 0
  %v16 = ptrtoint ptr %v12 to i64
  %st9 = getelementptr i64, ptr %v15, i64 0
  store i64 %v16, ptr %st9
  %st10 = getelementptr i64, ptr %v15, i64 1
  store i64 %v13, ptr %st10
  %st11 = getelementptr i64, ptr %v15, i64 2
  store i64 %v14, ptr %st11
  br label %b8
b5:
  %v24 = getelementptr i64, ptr @"str.13", i64 0
  %v25 = add i64 0, 64
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v28 = ptrtoint ptr %v24 to i64
  %st12 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st12
  %st13 = getelementptr i64, ptr %v27, i64 1
  store i64 %v25, ptr %st13
  %st14 = getelementptr i64, ptr %v27, i64 2
  store i64 %v26, ptr %st14
  br label %b8
b6:
  %v19 = getelementptr i64, ptr @"str.19", i64 0
  %v20 = add i64 0, 64
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s2, i64 0
  %v23 = ptrtoint ptr %v19 to i64
  %st15 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st15
  %st16 = getelementptr i64, ptr %v22, i64 1
  store i64 %v20, ptr %st16
  %st17 = getelementptr i64, ptr %v22, i64 2
  store i64 %v21, ptr %st17
  br label %b8
b7:
  %v29 = getelementptr i64, ptr %s4, i64 0
  br label %b8
b8:
  %v30 = phi ptr [ %v8, %b2 ], [ %v15, %b4 ], [ %v27, %b5 ], [ %v22, %b6 ], [ %v29, %b7 ]
  %v31.p = getelementptr i64, ptr %v30, i64 0
  %v31 = load i64, ptr %v31.p
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v31, ptr %st18
  %v32.p = getelementptr i64, ptr %v30, i64 1
  %v32 = load i64, ptr %v32.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v32, ptr %st19
  %v33.p = getelementptr i64, ptr %v30, i64 2
  %v33 = load i64, ptr %v33.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v33, ptr %st20
  call void @"rt.region_relocate8"(ptr %v0, i64 %v2)
  %v35 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v35, i64 0
  store i64 %v2, ptr %st21
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
  %s34 = alloca [1 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
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
  %s48 = alloca [3 x i64], align 8
  %s48.z0 = getelementptr i64, ptr %s48, i64 0
  store i64 0, ptr %s48.z0
  %s48.z1 = getelementptr i64, ptr %s48, i64 1
  store i64 0, ptr %s48.z1
  %s48.z2 = getelementptr i64, ptr %s48, i64 2
  store i64 0, ptr %s48.z2
  %v415 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v415, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr @"str.1", i64 0
  %v2 = add i64 0, 4
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
  %v7 = getelementptr i64, ptr %s2, i64 0
  %v8 = getelementptr i64, ptr %s3, i64 0
  %v9 = getelementptr i64, ptr @"str.24", i64 0
  %v10 = add i64 0, 64
  %v11 = add i64 0, 0
  %v12 = getelementptr i64, ptr %s4, i64 0
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
  call void @"main.unhex"(ptr %v8, i64 %v14, i64 %v15, i64 %v16)
  %v17.p = getelementptr i64, ptr %v8, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v8, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v8, i64 2
  %v19 = load i64, ptr %v19.p
  %v20 = getelementptr i64, ptr %s5, i64 0
  %v21 = getelementptr i64, ptr @"str.18", i64 0
  %v22 = add i64 0, 64
  %v23 = add i64 0, 0
  %v24 = getelementptr i64, ptr %s6, i64 0
  %v25 = ptrtoint ptr %v21 to i64
  %st6 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st6
  %st7 = getelementptr i64, ptr %v24, i64 1
  store i64 %v22, ptr %st7
  %st8 = getelementptr i64, ptr %v24, i64 2
  store i64 %v23, ptr %st8
  %v26.p = getelementptr i64, ptr %v24, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v24, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v24, i64 2
  %v28 = load i64, ptr %v28.p
  call void @"main.unhex"(ptr %v20, i64 %v26, i64 %v27, i64 %v28)
  %v29.p = getelementptr i64, ptr %v20, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v20, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v20, i64 2
  %v31 = load i64, ptr %v31.p
  call void @"std/crypto/x25519.Shared"(ptr %v7, i64 %v17, i64 %v18, i64 %v19, i64 %v29, i64 %v30, i64 %v31)
  %v32.p = getelementptr i64, ptr %v7, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v7, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v7, i64 2
  %v34 = load i64, ptr %v34.p
  %v35 = getelementptr i64, ptr @"str.16", i64 0
  %v36 = add i64 0, 64
  %v37 = add i64 0, 0
  %v38 = getelementptr i64, ptr %s7, i64 0
  %v39 = ptrtoint ptr %v35 to i64
  %st9 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st9
  %st10 = getelementptr i64, ptr %v38, i64 1
  store i64 %v36, ptr %st10
  %st11 = getelementptr i64, ptr %v38, i64 2
  store i64 %v37, ptr %st11
  %v40.p = getelementptr i64, ptr %v38, i64 0
  %v40 = load i64, ptr %v40.p
  %v41.p = getelementptr i64, ptr %v38, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v38, i64 2
  %v42 = load i64, ptr %v42.p
  call void @"main.show"(ptr %v6, i64 %v32, i64 %v33, i64 %v34, i64 %v40, i64 %v41, i64 %v42)
  call void @"rt.print_str"(ptr %v4)
  %v43 = add i64 0, 32
  call void @"rt.print_char"(i64 %v43)
  call void @"rt.print_str"(ptr %v6)
  %v44 = add i64 0, 10
  call void @"rt.print_char"(i64 %v44)
  %v45 = getelementptr i64, ptr @"str.2", i64 0
  %v46 = add i64 0, 4
  %v47 = add i64 0, 0
  %v48 = getelementptr i64, ptr %s7, i64 0
  %v49 = ptrtoint ptr %v45 to i64
  %st12 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st12
  %st13 = getelementptr i64, ptr %v48, i64 1
  store i64 %v46, ptr %st13
  %st14 = getelementptr i64, ptr %v48, i64 2
  store i64 %v47, ptr %st14
  %v50 = getelementptr i64, ptr %s8, i64 0
  %v51 = getelementptr i64, ptr %s9, i64 0
  %v52 = getelementptr i64, ptr %s10, i64 0
  %v53 = getelementptr i64, ptr @"str.15", i64 0
  %v54 = add i64 0, 64
  %v55 = add i64 0, 0
  %v56 = getelementptr i64, ptr %s6, i64 0
  %v57 = ptrtoint ptr %v53 to i64
  %st15 = getelementptr i64, ptr %v56, i64 0
  store i64 %v57, ptr %st15
  %st16 = getelementptr i64, ptr %v56, i64 1
  store i64 %v54, ptr %st16
  %st17 = getelementptr i64, ptr %v56, i64 2
  store i64 %v55, ptr %st17
  %v58.p = getelementptr i64, ptr %v56, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v56, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v56, i64 2
  %v60 = load i64, ptr %v60.p
  call void @"main.unhex"(ptr %v52, i64 %v58, i64 %v59, i64 %v60)
  %v61.p = getelementptr i64, ptr %v52, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v52, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v52, i64 2
  %v63 = load i64, ptr %v63.p
  %v64 = getelementptr i64, ptr %s11, i64 0
  %v65 = getelementptr i64, ptr @"str.10", i64 0
  %v66 = add i64 0, 64
  %v67 = add i64 0, 0
  %v68 = getelementptr i64, ptr %s4, i64 0
  %v69 = ptrtoint ptr %v65 to i64
  %st18 = getelementptr i64, ptr %v68, i64 0
  store i64 %v69, ptr %st18
  %st19 = getelementptr i64, ptr %v68, i64 1
  store i64 %v66, ptr %st19
  %st20 = getelementptr i64, ptr %v68, i64 2
  store i64 %v67, ptr %st20
  %v70.p = getelementptr i64, ptr %v68, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v68, i64 1
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v68, i64 2
  %v72 = load i64, ptr %v72.p
  call void @"main.unhex"(ptr %v64, i64 %v70, i64 %v71, i64 %v72)
  %v73.p = getelementptr i64, ptr %v64, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v64, i64 1
  %v74 = load i64, ptr %v74.p
  %v75.p = getelementptr i64, ptr %v64, i64 2
  %v75 = load i64, ptr %v75.p
  call void @"std/crypto/x25519.Shared"(ptr %v51, i64 %v61, i64 %v62, i64 %v63, i64 %v73, i64 %v74, i64 %v75)
  %v76.p = getelementptr i64, ptr %v51, i64 0
  %v76 = load i64, ptr %v76.p
  %v77.p = getelementptr i64, ptr %v51, i64 1
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v51, i64 2
  %v78 = load i64, ptr %v78.p
  %v79 = getelementptr i64, ptr @"str.14", i64 0
  %v80 = add i64 0, 64
  %v81 = add i64 0, 0
  %v82 = getelementptr i64, ptr %s0, i64 0
  %v83 = ptrtoint ptr %v79 to i64
  %st21 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st21
  %st22 = getelementptr i64, ptr %v82, i64 1
  store i64 %v80, ptr %st22
  %st23 = getelementptr i64, ptr %v82, i64 2
  store i64 %v81, ptr %st23
  %v84.p = getelementptr i64, ptr %v82, i64 0
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v82, i64 1
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v82, i64 2
  %v86 = load i64, ptr %v86.p
  call void @"main.show"(ptr %v50, i64 %v76, i64 %v77, i64 %v78, i64 %v84, i64 %v85, i64 %v86)
  call void @"rt.print_str"(ptr %v48)
  %v87 = add i64 0, 32
  call void @"rt.print_char"(i64 %v87)
  call void @"rt.print_str"(ptr %v50)
  %v88 = add i64 0, 10
  call void @"rt.print_char"(i64 %v88)
  %v89 = getelementptr i64, ptr %s12, i64 0
  %v90 = getelementptr i64, ptr @"str.8", i64 0
  %v91 = add i64 0, 64
  %v92 = add i64 0, 0
  %v93 = getelementptr i64, ptr %s0, i64 0
  %v94 = ptrtoint ptr %v90 to i64
  %st24 = getelementptr i64, ptr %v93, i64 0
  store i64 %v94, ptr %st24
  %st25 = getelementptr i64, ptr %v93, i64 1
  store i64 %v91, ptr %st25
  %st26 = getelementptr i64, ptr %v93, i64 2
  store i64 %v92, ptr %st26
  %v95.p = getelementptr i64, ptr %v93, i64 0
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v93, i64 1
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v93, i64 2
  %v97 = load i64, ptr %v97.p
  call void @"main.unhex"(ptr %v89, i64 %v95, i64 %v96, i64 %v97)
  %v98 = getelementptr i64, ptr %s4, i64 0
  %v99.p = getelementptr i64, ptr %v89, i64 0
  %v99 = load i64, ptr %v99.p
  %st27 = getelementptr i64, ptr %v98, i64 0
  store i64 %v99, ptr %st27
  %v100.p = getelementptr i64, ptr %v89, i64 1
  %v100 = load i64, ptr %v100.p
  %st28 = getelementptr i64, ptr %v98, i64 1
  store i64 %v100, ptr %st28
  %v101.p = getelementptr i64, ptr %v89, i64 2
  %v101 = load i64, ptr %v101.p
  %st29 = getelementptr i64, ptr %v98, i64 2
  store i64 %v101, ptr %st29
  %v102 = getelementptr i64, ptr %s0, i64 0
  %v103.p = getelementptr i64, ptr %v98, i64 0
  %v103 = load i64, ptr %v103.p
  %st30 = getelementptr i64, ptr %v102, i64 0
  store i64 %v103, ptr %st30
  %v104.p = getelementptr i64, ptr %v98, i64 1
  %v104 = load i64, ptr %v104.p
  %st31 = getelementptr i64, ptr %v102, i64 1
  store i64 %v104, ptr %st31
  %v105.p = getelementptr i64, ptr %v98, i64 2
  %v105 = load i64, ptr %v105.p
  %st32 = getelementptr i64, ptr %v102, i64 2
  store i64 %v105, ptr %st32
  %v416 = getelementptr i64, ptr @"rt.meta", i64 0
  %v106.p = getelementptr i64, ptr %v416, i64 0
  %v106 = load i64, ptr %v106.p
  %v107 = add i64 0, 0
  %v108 = add i64 0, 100
  %v109 = getelementptr i64, ptr %s13, i64 0
  %v417 = getelementptr i64, ptr @"rt.meta", i64 0
  %v110.p = getelementptr i64, ptr %v417, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = getelementptr i64, ptr %s14, i64 0
  %st33 = getelementptr i64, ptr %v111, i64 0
  store i64 %v107, ptr %st33
  %v418 = getelementptr i64, ptr @"rt.meta", i64 0
  %v112.p = getelementptr i64, ptr %v418, i64 0
  %v112 = load i64, ptr %v112.p
  br label %b3
b1:
  %v419 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v419, i64 0
  store i64 %v106, ptr %st34
  %v175 = getelementptr i64, ptr @"str.7", i64 0
  %v176 = add i64 0, 7
  %v177 = add i64 0, 0
  %v178 = getelementptr i64, ptr %s19, i64 0
  %v179 = ptrtoint ptr %v175 to i64
  %st35 = getelementptr i64, ptr %v178, i64 0
  store i64 %v179, ptr %st35
  %st36 = getelementptr i64, ptr %v178, i64 1
  store i64 %v176, ptr %st36
  %st37 = getelementptr i64, ptr %v178, i64 2
  store i64 %v177, ptr %st37
  %v180 = getelementptr i64, ptr %s20, i64 0
  %v181.p = getelementptr i64, ptr %v98, i64 0
  %v181 = load i64, ptr %v181.p
  %v182.p = getelementptr i64, ptr %v98, i64 1
  %v182 = load i64, ptr %v182.p
  %v183.p = getelementptr i64, ptr %v98, i64 2
  %v183 = load i64, ptr %v183.p
  %v184 = getelementptr i64, ptr @"str.9", i64 0
  %v185 = add i64 0, 64
  %v186 = add i64 0, 0
  %v187 = getelementptr i64, ptr %s17, i64 0
  %v188 = ptrtoint ptr %v184 to i64
  %st38 = getelementptr i64, ptr %v187, i64 0
  store i64 %v188, ptr %st38
  %st39 = getelementptr i64, ptr %v187, i64 1
  store i64 %v185, ptr %st39
  %st40 = getelementptr i64, ptr %v187, i64 2
  store i64 %v186, ptr %st40
  %v189.p = getelementptr i64, ptr %v187, i64 0
  %v189 = load i64, ptr %v189.p
  %v190.p = getelementptr i64, ptr %v187, i64 1
  %v190 = load i64, ptr %v190.p
  %v191.p = getelementptr i64, ptr %v187, i64 2
  %v191 = load i64, ptr %v191.p
  call void @"main.show"(ptr %v180, i64 %v181, i64 %v182, i64 %v183, i64 %v189, i64 %v190, i64 %v191)
  call void @"rt.print_str"(ptr %v178)
  %v192 = add i64 0, 32
  call void @"rt.print_char"(i64 %v192)
  call void @"rt.print_str"(ptr %v180)
  %v193 = add i64 0, 10
  call void @"rt.print_char"(i64 %v193)
  %v194 = getelementptr i64, ptr %s21, i64 0
  %v195 = getelementptr i64, ptr @"str.21", i64 0
  %v196 = add i64 0, 64
  %v197 = add i64 0, 0
  %v198 = getelementptr i64, ptr %s17, i64 0
  %v199 = ptrtoint ptr %v195 to i64
  %st41 = getelementptr i64, ptr %v198, i64 0
  store i64 %v199, ptr %st41
  %st42 = getelementptr i64, ptr %v198, i64 1
  store i64 %v196, ptr %st42
  %st43 = getelementptr i64, ptr %v198, i64 2
  store i64 %v197, ptr %st43
  %v200.p = getelementptr i64, ptr %v198, i64 0
  %v200 = load i64, ptr %v200.p
  %v201.p = getelementptr i64, ptr %v198, i64 1
  %v201 = load i64, ptr %v201.p
  %v202.p = getelementptr i64, ptr %v198, i64 2
  %v202 = load i64, ptr %v202.p
  call void @"main.unhex"(ptr %v194, i64 %v200, i64 %v201, i64 %v202)
  %v203 = getelementptr i64, ptr %s19, i64 0
  %v204.p = getelementptr i64, ptr %v194, i64 0
  %v204 = load i64, ptr %v204.p
  %st44 = getelementptr i64, ptr %v203, i64 0
  store i64 %v204, ptr %st44
  %v205.p = getelementptr i64, ptr %v194, i64 1
  %v205 = load i64, ptr %v205.p
  %st45 = getelementptr i64, ptr %v203, i64 1
  store i64 %v205, ptr %st45
  %v206.p = getelementptr i64, ptr %v194, i64 2
  %v206 = load i64, ptr %v206.p
  %st46 = getelementptr i64, ptr %v203, i64 2
  store i64 %v206, ptr %st46
  %v207 = getelementptr i64, ptr %s22, i64 0
  %v208 = getelementptr i64, ptr @"str.25", i64 0
  %v209 = add i64 0, 64
  %v210 = add i64 0, 0
  %v211 = getelementptr i64, ptr %s17, i64 0
  %v212 = ptrtoint ptr %v208 to i64
  %st47 = getelementptr i64, ptr %v211, i64 0
  store i64 %v212, ptr %st47
  %st48 = getelementptr i64, ptr %v211, i64 1
  store i64 %v209, ptr %st48
  %st49 = getelementptr i64, ptr %v211, i64 2
  store i64 %v210, ptr %st49
  %v213.p = getelementptr i64, ptr %v211, i64 0
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v211, i64 1
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v211, i64 2
  %v215 = load i64, ptr %v215.p
  call void @"main.unhex"(ptr %v207, i64 %v213, i64 %v214, i64 %v215)
  %v216 = getelementptr i64, ptr %s6, i64 0
  %v217.p = getelementptr i64, ptr %v207, i64 0
  %v217 = load i64, ptr %v217.p
  %st50 = getelementptr i64, ptr %v216, i64 0
  store i64 %v217, ptr %st50
  %v218.p = getelementptr i64, ptr %v207, i64 1
  %v218 = load i64, ptr %v218.p
  %st51 = getelementptr i64, ptr %v216, i64 1
  store i64 %v218, ptr %st51
  %v219.p = getelementptr i64, ptr %v207, i64 2
  %v219 = load i64, ptr %v219.p
  %st52 = getelementptr i64, ptr %v216, i64 2
  store i64 %v219, ptr %st52
  %v220 = getelementptr i64, ptr @"str.5", i64 0
  %v221 = add i64 0, 5
  %v222 = add i64 0, 0
  %v223 = getelementptr i64, ptr %s17, i64 0
  %v224 = ptrtoint ptr %v220 to i64
  %st53 = getelementptr i64, ptr %v223, i64 0
  store i64 %v224, ptr %st53
  %st54 = getelementptr i64, ptr %v223, i64 1
  store i64 %v221, ptr %st54
  %st55 = getelementptr i64, ptr %v223, i64 2
  store i64 %v222, ptr %st55
  %v225 = getelementptr i64, ptr %s23, i64 0
  %v226 = getelementptr i64, ptr %s24, i64 0
  %v227.p = getelementptr i64, ptr %v203, i64 0
  %v227 = load i64, ptr %v227.p
  %v228.p = getelementptr i64, ptr %v203, i64 1
  %v228 = load i64, ptr %v228.p
  %v229.p = getelementptr i64, ptr %v203, i64 2
  %v229 = load i64, ptr %v229.p
  call void @"std/crypto/x25519.Base"(ptr %v226, i64 %v227, i64 %v228, i64 %v229)
  %v230.p = getelementptr i64, ptr %v226, i64 0
  %v230 = load i64, ptr %v230.p
  %v231.p = getelementptr i64, ptr %v226, i64 1
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v226, i64 2
  %v232 = load i64, ptr %v232.p
  call void @"std/hex.Format"(ptr %v225, i64 %v230, i64 %v231, i64 %v232)
  call void @"rt.print_str"(ptr %v223)
  %v233 = add i64 0, 32
  call void @"rt.print_char"(i64 %v233)
  call void @"rt.print_str"(ptr %v225)
  %v234 = add i64 0, 10
  call void @"rt.print_char"(i64 %v234)
  %v235 = getelementptr i64, ptr @"str.0", i64 0
  %v236 = add i64 0, 3
  %v237 = add i64 0, 0
  %v238 = getelementptr i64, ptr %s17, i64 0
  %v239 = ptrtoint ptr %v235 to i64
  %st56 = getelementptr i64, ptr %v238, i64 0
  store i64 %v239, ptr %st56
  %st57 = getelementptr i64, ptr %v238, i64 1
  store i64 %v236, ptr %st57
  %st58 = getelementptr i64, ptr %v238, i64 2
  store i64 %v237, ptr %st58
  %v240 = getelementptr i64, ptr %s25, i64 0
  %v241 = getelementptr i64, ptr %s26, i64 0
  %v242.p = getelementptr i64, ptr %v216, i64 0
  %v242 = load i64, ptr %v242.p
  %v243.p = getelementptr i64, ptr %v216, i64 1
  %v243 = load i64, ptr %v243.p
  %v244.p = getelementptr i64, ptr %v216, i64 2
  %v244 = load i64, ptr %v244.p
  call void @"std/crypto/x25519.Base"(ptr %v241, i64 %v242, i64 %v243, i64 %v244)
  %v245.p = getelementptr i64, ptr %v241, i64 0
  %v245 = load i64, ptr %v245.p
  %v246.p = getelementptr i64, ptr %v241, i64 1
  %v246 = load i64, ptr %v246.p
  %v247.p = getelementptr i64, ptr %v241, i64 2
  %v247 = load i64, ptr %v247.p
  call void @"std/hex.Format"(ptr %v240, i64 %v245, i64 %v246, i64 %v247)
  call void @"rt.print_str"(ptr %v238)
  %v248 = add i64 0, 32
  call void @"rt.print_char"(i64 %v248)
  call void @"rt.print_str"(ptr %v240)
  %v249 = add i64 0, 10
  call void @"rt.print_char"(i64 %v249)
  %v250 = getelementptr i64, ptr @"str.23", i64 0
  %v251 = add i64 0, 64
  %v252 = add i64 0, 0
  %v253 = getelementptr i64, ptr %s17, i64 0
  %v254 = ptrtoint ptr %v250 to i64
  %st59 = getelementptr i64, ptr %v253, i64 0
  store i64 %v254, ptr %st59
  %st60 = getelementptr i64, ptr %v253, i64 1
  store i64 %v251, ptr %st60
  %st61 = getelementptr i64, ptr %v253, i64 2
  store i64 %v252, ptr %st61
  %v255 = getelementptr i64, ptr %s27, i64 0
  %v256.p = getelementptr i64, ptr %v253, i64 0
  %v256 = load i64, ptr %v256.p
  %st62 = getelementptr i64, ptr %v255, i64 0
  store i64 %v256, ptr %st62
  %v257.p = getelementptr i64, ptr %v253, i64 1
  %v257 = load i64, ptr %v257.p
  %st63 = getelementptr i64, ptr %v255, i64 1
  store i64 %v257, ptr %st63
  %v258.p = getelementptr i64, ptr %v253, i64 2
  %v258 = load i64, ptr %v258.p
  %st64 = getelementptr i64, ptr %v255, i64 2
  store i64 %v258, ptr %st64
  %v259 = getelementptr i64, ptr @"str.6", i64 0
  %v260 = add i64 0, 6
  %v261 = add i64 0, 0
  %v262 = getelementptr i64, ptr %s17, i64 0
  %v263 = ptrtoint ptr %v259 to i64
  %st65 = getelementptr i64, ptr %v262, i64 0
  store i64 %v263, ptr %st65
  %st66 = getelementptr i64, ptr %v262, i64 1
  store i64 %v260, ptr %st66
  %st67 = getelementptr i64, ptr %v262, i64 2
  store i64 %v261, ptr %st67
  %v264 = getelementptr i64, ptr %s28, i64 0
  %v265 = getelementptr i64, ptr %s29, i64 0
  %v266.p = getelementptr i64, ptr %v203, i64 0
  %v266 = load i64, ptr %v266.p
  %v267.p = getelementptr i64, ptr %v203, i64 1
  %v267 = load i64, ptr %v267.p
  %v268.p = getelementptr i64, ptr %v203, i64 2
  %v268 = load i64, ptr %v268.p
  %v269 = getelementptr i64, ptr %s30, i64 0
  %v270.p = getelementptr i64, ptr %v216, i64 0
  %v270 = load i64, ptr %v270.p
  %v271.p = getelementptr i64, ptr %v216, i64 1
  %v271 = load i64, ptr %v271.p
  %v272.p = getelementptr i64, ptr %v216, i64 2
  %v272 = load i64, ptr %v272.p
  call void @"std/crypto/x25519.Base"(ptr %v269, i64 %v270, i64 %v271, i64 %v272)
  %v273.p = getelementptr i64, ptr %v269, i64 0
  %v273 = load i64, ptr %v273.p
  %v274.p = getelementptr i64, ptr %v269, i64 1
  %v274 = load i64, ptr %v274.p
  %v275.p = getelementptr i64, ptr %v269, i64 2
  %v275 = load i64, ptr %v275.p
  call void @"std/crypto/x25519.Shared"(ptr %v265, i64 %v266, i64 %v267, i64 %v268, i64 %v273, i64 %v274, i64 %v275)
  %v276.p = getelementptr i64, ptr %v265, i64 0
  %v276 = load i64, ptr %v276.p
  %v277.p = getelementptr i64, ptr %v265, i64 1
  %v277 = load i64, ptr %v277.p
  %v278.p = getelementptr i64, ptr %v265, i64 2
  %v278 = load i64, ptr %v278.p
  %v279.p = getelementptr i64, ptr %v255, i64 0
  %v279 = load i64, ptr %v279.p
  %v280.p = getelementptr i64, ptr %v255, i64 1
  %v280 = load i64, ptr %v280.p
  %v281.p = getelementptr i64, ptr %v255, i64 2
  %v281 = load i64, ptr %v281.p
  call void @"main.show"(ptr %v264, i64 %v276, i64 %v277, i64 %v278, i64 %v279, i64 %v280, i64 %v281)
  %v282 = getelementptr i64, ptr %s31, i64 0
  %v283 = getelementptr i64, ptr %s32, i64 0
  %v284.p = getelementptr i64, ptr %v216, i64 0
  %v284 = load i64, ptr %v284.p
  %v285.p = getelementptr i64, ptr %v216, i64 1
  %v285 = load i64, ptr %v285.p
  %v286.p = getelementptr i64, ptr %v216, i64 2
  %v286 = load i64, ptr %v286.p
  %v287 = getelementptr i64, ptr %s33, i64 0
  %v288.p = getelementptr i64, ptr %v203, i64 0
  %v288 = load i64, ptr %v288.p
  %v289.p = getelementptr i64, ptr %v203, i64 1
  %v289 = load i64, ptr %v289.p
  %v290.p = getelementptr i64, ptr %v203, i64 2
  %v290 = load i64, ptr %v290.p
  call void @"std/crypto/x25519.Base"(ptr %v287, i64 %v288, i64 %v289, i64 %v290)
  %v291.p = getelementptr i64, ptr %v287, i64 0
  %v291 = load i64, ptr %v291.p
  %v292.p = getelementptr i64, ptr %v287, i64 1
  %v292 = load i64, ptr %v292.p
  %v293.p = getelementptr i64, ptr %v287, i64 2
  %v293 = load i64, ptr %v293.p
  call void @"std/crypto/x25519.Shared"(ptr %v283, i64 %v284, i64 %v285, i64 %v286, i64 %v291, i64 %v292, i64 %v293)
  %v294.p = getelementptr i64, ptr %v283, i64 0
  %v294 = load i64, ptr %v294.p
  %v295.p = getelementptr i64, ptr %v283, i64 1
  %v295 = load i64, ptr %v295.p
  %v296.p = getelementptr i64, ptr %v283, i64 2
  %v296 = load i64, ptr %v296.p
  %v297.p = getelementptr i64, ptr %v255, i64 0
  %v297 = load i64, ptr %v297.p
  %v298.p = getelementptr i64, ptr %v255, i64 1
  %v298 = load i64, ptr %v298.p
  %v299.p = getelementptr i64, ptr %v255, i64 2
  %v299 = load i64, ptr %v299.p
  call void @"main.show"(ptr %v282, i64 %v294, i64 %v295, i64 %v296, i64 %v297, i64 %v298, i64 %v299)
  call void @"rt.print_str"(ptr %v262)
  %v300 = add i64 0, 32
  call void @"rt.print_char"(i64 %v300)
  call void @"rt.print_str"(ptr %v264)
  %v301 = add i64 0, 32
  call void @"rt.print_char"(i64 %v301)
  call void @"rt.print_str"(ptr %v282)
  %v302 = add i64 0, 10
  call void @"rt.print_char"(i64 %v302)
  %v303 = add i64 0, 0
  %v304 = getelementptr i64, ptr %s14, i64 0
  %st68 = getelementptr i64, ptr %v304, i64 0
  store i64 %v303, ptr %st68
  %v420 = getelementptr i64, ptr @"rt.meta", i64 0
  %v305.p = getelementptr i64, ptr %v420, i64 0
  %v305 = load i64, ptr %v305.p
  %v306 = add i64 0, 0
  %v307 = add i64 0, 16
  %v308 = getelementptr i64, ptr %s13, i64 0
  %v421 = getelementptr i64, ptr @"rt.meta", i64 0
  %v309.p = getelementptr i64, ptr %v421, i64 0
  %v309 = load i64, ptr %v309.p
  %v310 = getelementptr i64, ptr %s34, i64 0
  %st69 = getelementptr i64, ptr %v310, i64 0
  store i64 %v306, ptr %st69
  %v422 = getelementptr i64, ptr @"rt.meta", i64 0
  %v311.p = getelementptr i64, ptr %v422, i64 0
  %v311 = load i64, ptr %v311.p
  br label %b12
b2:
  br label %b1
b3:
  %v423 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v423, i64 0
  store i64 %v112, ptr %st70
  %v113.p = getelementptr i64, ptr %v111, i64 0
  %v113 = load i64, ptr %v113.p
  %v114.c = icmp slt i64 %v113, %v108
  %v114 = zext i1 %v114.c to i64
  %c.b3 = icmp ne i64 %v114, 0
  br i1 %c.b3, label %b3.t72, label %b3.e73
b3.t72:
  br label %b4
b3.e73:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v424 = getelementptr i64, ptr @"rt.meta", i64 0
  %v115.p = getelementptr i64, ptr %v424, i64 0
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v111, i64 0
  %v116 = load i64, ptr %v116.p
  %v425 = getelementptr i64, ptr @"rt.meta", i64 0
  %v117.p = getelementptr i64, ptr %v425, i64 0
  %v117 = load i64, ptr %v117.p
  %v118 = getelementptr i64, ptr %s15, i64 0
  %v119.p = getelementptr i64, ptr %v98, i64 0
  %v119 = load i64, ptr %v119.p
  %v120.p = getelementptr i64, ptr %v98, i64 1
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v98, i64 2
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v102, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v102, i64 1
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v102, i64 2
  %v124 = load i64, ptr %v124.p
  call void @"std/crypto/x25519.Shared"(ptr %v118, i64 %v119, i64 %v120, i64 %v121, i64 %v122, i64 %v123, i64 %v124)
  %v125 = getelementptr i64, ptr %s6, i64 0
  %v126.p = getelementptr i64, ptr %v118, i64 0
  %v126 = load i64, ptr %v126.p
  %st73 = getelementptr i64, ptr %v125, i64 0
  store i64 %v126, ptr %st73
  %v127.p = getelementptr i64, ptr %v118, i64 1
  %v127 = load i64, ptr %v127.p
  %st74 = getelementptr i64, ptr %v125, i64 1
  store i64 %v127, ptr %st74
  %v128.p = getelementptr i64, ptr %v118, i64 2
  %v128 = load i64, ptr %v128.p
  %st75 = getelementptr i64, ptr %v125, i64 2
  store i64 %v128, ptr %st75
  %v129 = add i64 0, 1
  %v130 = add i64 %v0, %v129
  %v131 = getelementptr i64, ptr %s7, i64 0
  %v132.p = getelementptr i64, ptr %v98, i64 0
  %v132 = load i64, ptr %v132.p
  %st76 = getelementptr i64, ptr %v131, i64 0
  store i64 %v132, ptr %st76
  %v133.p = getelementptr i64, ptr %v98, i64 1
  %v133 = load i64, ptr %v133.p
  %st77 = getelementptr i64, ptr %v131, i64 1
  store i64 %v133, ptr %st77
  %v134.p = getelementptr i64, ptr %v98, i64 2
  %v134 = load i64, ptr %v134.p
  %st78 = getelementptr i64, ptr %v131, i64 2
  store i64 %v134, ptr %st78
  %v135 = add i64 0, 1
  %v136 = add i64 %v0, %v135
  call void @"rt.region_relocate8"(ptr %v131, i64 %v136)
  %v137.p = getelementptr i64, ptr %v131, i64 0
  %v137 = load i64, ptr %v137.p
  %st79 = getelementptr i64, ptr %v102, i64 0
  store i64 %v137, ptr %st79
  %v138.p = getelementptr i64, ptr %v131, i64 1
  %v138 = load i64, ptr %v138.p
  %st80 = getelementptr i64, ptr %v102, i64 1
  store i64 %v138, ptr %st80
  %v139.p = getelementptr i64, ptr %v131, i64 2
  %v139 = load i64, ptr %v139.p
  %st81 = getelementptr i64, ptr %v102, i64 2
  store i64 %v139, ptr %st81
  %v140 = add i64 0, 1
  %v141 = add i64 %v0, %v140
  %v142 = getelementptr i64, ptr %s16, i64 0
  %v143.p = getelementptr i64, ptr %v125, i64 0
  %v143 = load i64, ptr %v143.p
  %st82 = getelementptr i64, ptr %v142, i64 0
  store i64 %v143, ptr %st82
  %v144.p = getelementptr i64, ptr %v125, i64 1
  %v144 = load i64, ptr %v144.p
  %st83 = getelementptr i64, ptr %v142, i64 1
  store i64 %v144, ptr %st83
  %v145.p = getelementptr i64, ptr %v125, i64 2
  %v145 = load i64, ptr %v145.p
  %st84 = getelementptr i64, ptr %v142, i64 2
  store i64 %v145, ptr %st84
  %v146 = add i64 0, 1
  %v147 = add i64 %v0, %v146
  call void @"rt.region_relocate8"(ptr %v142, i64 %v147)
  %v148.p = getelementptr i64, ptr %v142, i64 0
  %v148 = load i64, ptr %v148.p
  %st85 = getelementptr i64, ptr %v98, i64 0
  store i64 %v148, ptr %st85
  %v149.p = getelementptr i64, ptr %v142, i64 1
  %v149 = load i64, ptr %v149.p
  %st86 = getelementptr i64, ptr %v98, i64 1
  store i64 %v149, ptr %st86
  %v150.p = getelementptr i64, ptr %v142, i64 2
  %v150 = load i64, ptr %v150.p
  %st87 = getelementptr i64, ptr %v98, i64 2
  store i64 %v150, ptr %st87
  %v151 = add i64 0, 0
  %v152.c = icmp eq i64 %v116, %v151
  %v152 = zext i1 %v152.c to i64
  %c.b4 = icmp ne i64 %v152, 0
  br i1 %c.b4, label %b4.t89, label %b4.e90
b4.t89:
  br label %b7
b4.e90:
  br label %b8
b5:
  %v426 = getelementptr i64, ptr @"rt.meta", i64 0
  %st90 = getelementptr i64, ptr %v426, i64 0
  store i64 %v112, ptr %st90
  br label %b2
b6:
  %v427 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v427, i64 0
  store i64 %v117, ptr %st91
  %v172 = add i64 0, 1
  %v173.p = getelementptr i64, ptr %v111, i64 0
  %v173 = load i64, ptr %v173.p
  %v174 = add i64 %v173, %v172
  %st92 = getelementptr i64, ptr %v111, i64 0
  store i64 %v174, ptr %st92
  br label %b3
b7:
  %v153 = getelementptr i64, ptr @"str.4", i64 0
  %v154 = add i64 0, 5
  %v155 = add i64 0, 0
  %v156 = getelementptr i64, ptr %s17, i64 0
  %v157 = ptrtoint ptr %v153 to i64
  %st93 = getelementptr i64, ptr %v156, i64 0
  store i64 %v157, ptr %st93
  %st94 = getelementptr i64, ptr %v156, i64 1
  store i64 %v154, ptr %st94
  %st95 = getelementptr i64, ptr %v156, i64 2
  store i64 %v155, ptr %st95
  %v158 = getelementptr i64, ptr %s18, i64 0
  %v159.p = getelementptr i64, ptr %v98, i64 0
  %v159 = load i64, ptr %v159.p
  %v160.p = getelementptr i64, ptr %v98, i64 1
  %v160 = load i64, ptr %v160.p
  %v161.p = getelementptr i64, ptr %v98, i64 2
  %v161 = load i64, ptr %v161.p
  %v162 = getelementptr i64, ptr @"str.22", i64 0
  %v163 = add i64 0, 64
  %v164 = add i64 0, 0
  %v165 = getelementptr i64, ptr %s19, i64 0
  %v166 = ptrtoint ptr %v162 to i64
  %st96 = getelementptr i64, ptr %v165, i64 0
  store i64 %v166, ptr %st96
  %st97 = getelementptr i64, ptr %v165, i64 1
  store i64 %v163, ptr %st97
  %st98 = getelementptr i64, ptr %v165, i64 2
  store i64 %v164, ptr %st98
  %v167.p = getelementptr i64, ptr %v165, i64 0
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v165, i64 1
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v165, i64 2
  %v169 = load i64, ptr %v169.p
  call void @"main.show"(ptr %v158, i64 %v159, i64 %v160, i64 %v161, i64 %v167, i64 %v168, i64 %v169)
  call void @"rt.print_str"(ptr %v156)
  %v170 = add i64 0, 32
  call void @"rt.print_char"(i64 %v170)
  call void @"rt.print_str"(ptr %v158)
  %v171 = add i64 0, 10
  call void @"rt.print_char"(i64 %v171)
  br label %b9
b8:
  br label %b9
b9:
  br label %b6
b10:
  %v428 = getelementptr i64, ptr @"rt.meta", i64 0
  %st99 = getelementptr i64, ptr %v428, i64 0
  store i64 %v305, ptr %st99
  %v407 = getelementptr i64, ptr @"str.26", i64 0
  %v408 = add i64 0, 9
  %v409 = add i64 0, 0
  %v410 = getelementptr i64, ptr %s44, i64 0
  %v411 = ptrtoint ptr %v407 to i64
  %st100 = getelementptr i64, ptr %v410, i64 0
  store i64 %v411, ptr %st100
  %st101 = getelementptr i64, ptr %v410, i64 1
  store i64 %v408, ptr %st101
  %st102 = getelementptr i64, ptr %v410, i64 2
  store i64 %v409, ptr %st102
  %v412.p = getelementptr i64, ptr %v304, i64 0
  %v412 = load i64, ptr %v412.p
  call void @"rt.print_str"(ptr %v410)
  %v413 = add i64 0, 32
  call void @"rt.print_char"(i64 %v413)
  call void @"rt.print_int"(i64 %v412)
  %v414 = add i64 0, 10
  call void @"rt.print_char"(i64 %v414)
  %v429 = getelementptr i64, ptr @"rt.meta", i64 0
  %st103 = getelementptr i64, ptr %v429, i64 0
  store i64 %v0, ptr %st103
  ret void
b11:
  br label %b10
b12:
  %v430 = getelementptr i64, ptr @"rt.meta", i64 0
  %st104 = getelementptr i64, ptr %v430, i64 0
  store i64 %v311, ptr %st104
  %v312.p = getelementptr i64, ptr %v310, i64 0
  %v312 = load i64, ptr %v312.p
  %v313.c = icmp slt i64 %v312, %v307
  %v313 = zext i1 %v313.c to i64
  %c.b12 = icmp ne i64 %v313, 0
  br i1 %c.b12, label %b12.t106, label %b12.e107
b12.t106:
  br label %b13
b12.e107:
  br label %b14
b13:
  call void @"rt.region_enter"()
  %v431 = getelementptr i64, ptr @"rt.meta", i64 0
  %v314.p = getelementptr i64, ptr %v431, i64 0
  %v314 = load i64, ptr %v314.p
  %v315.p = getelementptr i64, ptr %v310, i64 0
  %v315 = load i64, ptr %v315.p
  %v432 = getelementptr i64, ptr @"rt.meta", i64 0
  %v316.p = getelementptr i64, ptr %v432, i64 0
  %v316 = load i64, ptr %v316.p
  %v317 = getelementptr i64, ptr %s35, i64 0
  %v318 = add i64 0, 2
  %v319 = mul i64 %v318, %v315
  call void @"main.key"(ptr %v317, i64 %v319)
  %v320 = getelementptr i64, ptr %s17, i64 0
  %v321.p = getelementptr i64, ptr %v317, i64 0
  %v321 = load i64, ptr %v321.p
  %st107 = getelementptr i64, ptr %v320, i64 0
  store i64 %v321, ptr %st107
  %v322.p = getelementptr i64, ptr %v317, i64 1
  %v322 = load i64, ptr %v322.p
  %st108 = getelementptr i64, ptr %v320, i64 1
  store i64 %v322, ptr %st108
  %v323.p = getelementptr i64, ptr %v317, i64 2
  %v323 = load i64, ptr %v323.p
  %st109 = getelementptr i64, ptr %v320, i64 2
  store i64 %v323, ptr %st109
  %v324 = getelementptr i64, ptr %s36, i64 0
  %v325 = add i64 0, 2
  %v326 = mul i64 %v325, %v315
  %v327 = add i64 0, 1
  %v328 = add i64 %v326, %v327
  call void @"main.key"(ptr %v324, i64 %v328)
  %v329 = getelementptr i64, ptr %s37, i64 0
  %v330.p = getelementptr i64, ptr %v324, i64 0
  %v330 = load i64, ptr %v330.p
  %st110 = getelementptr i64, ptr %v329, i64 0
  store i64 %v330, ptr %st110
  %v331.p = getelementptr i64, ptr %v324, i64 1
  %v331 = load i64, ptr %v331.p
  %st111 = getelementptr i64, ptr %v329, i64 1
  store i64 %v331, ptr %st111
  %v332.p = getelementptr i64, ptr %v324, i64 2
  %v332 = load i64, ptr %v332.p
  %st112 = getelementptr i64, ptr %v329, i64 2
  store i64 %v332, ptr %st112
  %v333 = getelementptr i64, ptr %s38, i64 0
  %v334.p = getelementptr i64, ptr %v320, i64 0
  %v334 = load i64, ptr %v334.p
  %v335.p = getelementptr i64, ptr %v320, i64 1
  %v335 = load i64, ptr %v335.p
  %v336.p = getelementptr i64, ptr %v320, i64 2
  %v336 = load i64, ptr %v336.p
  %v337 = getelementptr i64, ptr %s39, i64 0
  %v338.p = getelementptr i64, ptr %v329, i64 0
  %v338 = load i64, ptr %v338.p
  %v339.p = getelementptr i64, ptr %v329, i64 1
  %v339 = load i64, ptr %v339.p
  %v340.p = getelementptr i64, ptr %v329, i64 2
  %v340 = load i64, ptr %v340.p
  call void @"std/crypto/x25519.Base"(ptr %v337, i64 %v338, i64 %v339, i64 %v340)
  %v341.p = getelementptr i64, ptr %v337, i64 0
  %v341 = load i64, ptr %v341.p
  %v342.p = getelementptr i64, ptr %v337, i64 1
  %v342 = load i64, ptr %v342.p
  %v343.p = getelementptr i64, ptr %v337, i64 2
  %v343 = load i64, ptr %v343.p
  call void @"std/crypto/x25519.Shared"(ptr %v333, i64 %v334, i64 %v335, i64 %v336, i64 %v341, i64 %v342, i64 %v343)
  %v344 = getelementptr i64, ptr %s40, i64 0
  %v345.p = getelementptr i64, ptr %v333, i64 0
  %v345 = load i64, ptr %v345.p
  %st113 = getelementptr i64, ptr %v344, i64 0
  store i64 %v345, ptr %st113
  %v346.p = getelementptr i64, ptr %v333, i64 1
  %v346 = load i64, ptr %v346.p
  %st114 = getelementptr i64, ptr %v344, i64 1
  store i64 %v346, ptr %st114
  %v347.p = getelementptr i64, ptr %v333, i64 2
  %v347 = load i64, ptr %v347.p
  %st115 = getelementptr i64, ptr %v344, i64 2
  store i64 %v347, ptr %st115
  %v348 = getelementptr i64, ptr %s41, i64 0
  %v349.p = getelementptr i64, ptr %v329, i64 0
  %v349 = load i64, ptr %v349.p
  %v350.p = getelementptr i64, ptr %v329, i64 1
  %v350 = load i64, ptr %v350.p
  %v351.p = getelementptr i64, ptr %v329, i64 2
  %v351 = load i64, ptr %v351.p
  %v352 = getelementptr i64, ptr %s42, i64 0
  %v353.p = getelementptr i64, ptr %v320, i64 0
  %v353 = load i64, ptr %v353.p
  %v354.p = getelementptr i64, ptr %v320, i64 1
  %v354 = load i64, ptr %v354.p
  %v355.p = getelementptr i64, ptr %v320, i64 2
  %v355 = load i64, ptr %v355.p
  call void @"std/crypto/x25519.Base"(ptr %v352, i64 %v353, i64 %v354, i64 %v355)
  %v356.p = getelementptr i64, ptr %v352, i64 0
  %v356 = load i64, ptr %v356.p
  %v357.p = getelementptr i64, ptr %v352, i64 1
  %v357 = load i64, ptr %v357.p
  %v358.p = getelementptr i64, ptr %v352, i64 2
  %v358 = load i64, ptr %v358.p
  call void @"std/crypto/x25519.Shared"(ptr %v348, i64 %v349, i64 %v350, i64 %v351, i64 %v356, i64 %v357, i64 %v358)
  %v359 = getelementptr i64, ptr %s43, i64 0
  %v360.p = getelementptr i64, ptr %v348, i64 0
  %v360 = load i64, ptr %v360.p
  %st116 = getelementptr i64, ptr %v359, i64 0
  store i64 %v360, ptr %st116
  %v361.p = getelementptr i64, ptr %v348, i64 1
  %v361 = load i64, ptr %v361.p
  %st117 = getelementptr i64, ptr %v359, i64 1
  store i64 %v361, ptr %st117
  %v362.p = getelementptr i64, ptr %v348, i64 2
  %v362 = load i64, ptr %v362.p
  %st118 = getelementptr i64, ptr %v359, i64 2
  store i64 %v362, ptr %st118
  %v363.p = getelementptr i64, ptr %v344, i64 0
  %v363 = load i64, ptr %v363.p
  %v364.p = getelementptr i64, ptr %v344, i64 1
  %v364 = load i64, ptr %v364.p
  %v365.p = getelementptr i64, ptr %v344, i64 2
  %v365 = load i64, ptr %v365.p
  %v366.p = getelementptr i64, ptr %v359, i64 0
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v359, i64 1
  %v367 = load i64, ptr %v367.p
  %v368.p = getelementptr i64, ptr %v359, i64 2
  %v368 = load i64, ptr %v368.p
  %v369 = call i64 @"std/crypto.Equal"(i64 %v363, i64 %v364, i64 %v365, i64 %v366, i64 %v367, i64 %v368)
  %c.b13 = icmp ne i64 %v369, 0
  br i1 %c.b13, label %b13.t120, label %b13.e121
b13.t120:
  br label %b16
b13.e121:
  br label %b17
b14:
  %v433 = getelementptr i64, ptr @"rt.meta", i64 0
  %st121 = getelementptr i64, ptr %v433, i64 0
  store i64 %v311, ptr %st121
  br label %b11
b15:
  %v434 = getelementptr i64, ptr @"rt.meta", i64 0
  %st122 = getelementptr i64, ptr %v434, i64 0
  store i64 %v316, ptr %st122
  %v404 = add i64 0, 1
  %v405.p = getelementptr i64, ptr %v310, i64 0
  %v405 = load i64, ptr %v405.p
  %v406 = add i64 %v405, %v404
  %st123 = getelementptr i64, ptr %v310, i64 0
  store i64 %v406, ptr %st123
  br label %b12
b16:
  %v370 = add i64 0, 1
  %v371 = add i64 %v0, %v370
  %v372.p = getelementptr i64, ptr %v304, i64 0
  %v372 = load i64, ptr %v372.p
  %v373 = add i64 0, 1
  %v374 = add i64 %v372, %v373
  %st124 = getelementptr i64, ptr %v304, i64 0
  store i64 %v374, ptr %st124
  br label %b18
b17:
  br label %b18
b18:
  %v375 = add i64 0, 4
  %v376 = srem i64 %v315, %v375
  %v377 = add i64 0, 0
  %v378.c = icmp eq i64 %v376, %v377
  %v378 = zext i1 %v378.c to i64
  %c.b18 = icmp ne i64 %v378, 0
  br i1 %c.b18, label %b18.t126, label %b18.e127
b18.t126:
  br label %b19
b18.e127:
  br label %b20
b19:
  %v379 = getelementptr i64, ptr @"str.3", i64 0
  %v380 = add i64 0, 4
  %v381 = add i64 0, 0
  %v382 = getelementptr i64, ptr %s44, i64 0
  %v383 = ptrtoint ptr %v379 to i64
  %st127 = getelementptr i64, ptr %v382, i64 0
  store i64 %v383, ptr %st127
  %st128 = getelementptr i64, ptr %v382, i64 1
  store i64 %v380, ptr %st128
  %st129 = getelementptr i64, ptr %v382, i64 2
  store i64 %v381, ptr %st129
  %v384 = getelementptr i64, ptr %s45, i64 0
  %v385 = getelementptr i64, ptr %s46, i64 0
  %v386.p = getelementptr i64, ptr %v320, i64 0
  %v386 = load i64, ptr %v386.p
  %v387.p = getelementptr i64, ptr %v320, i64 1
  %v387 = load i64, ptr %v387.p
  %v388.p = getelementptr i64, ptr %v320, i64 2
  %v388 = load i64, ptr %v388.p
  call void @"std/crypto/x25519.Base"(ptr %v385, i64 %v386, i64 %v387, i64 %v388)
  %v389.p = getelementptr i64, ptr %v385, i64 0
  %v389 = load i64, ptr %v389.p
  %v390.p = getelementptr i64, ptr %v385, i64 1
  %v390 = load i64, ptr %v390.p
  %v391.p = getelementptr i64, ptr %v385, i64 2
  %v391 = load i64, ptr %v391.p
  call void @"std/hex.Format"(ptr %v384, i64 %v389, i64 %v390, i64 %v391)
  %v392 = getelementptr i64, ptr %s47, i64 0
  %v393.p = getelementptr i64, ptr %v344, i64 0
  %v393 = load i64, ptr %v393.p
  %v394.p = getelementptr i64, ptr %v344, i64 1
  %v394 = load i64, ptr %v394.p
  %v395.p = getelementptr i64, ptr %v344, i64 2
  %v395 = load i64, ptr %v395.p
  %v396 = getelementptr i64, ptr %s48, i64 0
  call void @"main.pairWant"(ptr %v396, i64 %v315)
  %v397.p = getelementptr i64, ptr %v396, i64 0
  %v397 = load i64, ptr %v397.p
  %v398.p = getelementptr i64, ptr %v396, i64 1
  %v398 = load i64, ptr %v398.p
  %v399.p = getelementptr i64, ptr %v396, i64 2
  %v399 = load i64, ptr %v399.p
  call void @"main.show"(ptr %v392, i64 %v393, i64 %v394, i64 %v395, i64 %v397, i64 %v398, i64 %v399)
  call void @"rt.print_str"(ptr %v382)
  %v400 = add i64 0, 32
  call void @"rt.print_char"(i64 %v400)
  call void @"rt.print_int"(i64 %v315)
  %v401 = add i64 0, 32
  call void @"rt.print_char"(i64 %v401)
  call void @"rt.print_str"(ptr %v384)
  %v402 = add i64 0, 32
  call void @"rt.print_char"(i64 %v402)
  call void @"rt.print_str"(ptr %v392)
  %v403 = add i64 0, 10
  call void @"rt.print_char"(i64 %v403)
  br label %b21
b20:
  br label %b21
b21:
  br label %b15
}

define internal i64 @"std/crypto.Equal"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5) #0 {
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
  %v52 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v52, i64 0
  %v8 = load i64, ptr %v8.p
  call void @"rt.region_enter"()
  %v9.p = getelementptr i64, ptr %v6, i64 1
  %v9 = load i64, ptr %v9.p
  %v10.p = getelementptr i64, ptr %v7, i64 1
  %v10 = load i64, ptr %v10.p
  %v11.c = icmp ne i64 %v9, %v10
  %v11 = zext i1 %v11.c to i64
  %c.b0 = icmp ne i64 %v11, 0
  br i1 %c.b0, label %b0.t7, label %b0.e8
b0.t7:
  br label %b1
b0.e8:
  br label %b2
b1:
  %v12 = add i64 0, 0
  %v53 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v53, i64 0
  store i64 %v8, ptr %st8
  ret i64 %v12
b2:
  br label %b3
b3:
  %v13 = add i64 0, 0
  %v14 = getelementptr i64, ptr %s2, i64 0
  %st9 = getelementptr i64, ptr %v14, i64 0
  store i64 %v13, ptr %st9
  %v54 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v54, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 0
  %v17.p = getelementptr i64, ptr %v6, i64 1
  %v17 = load i64, ptr %v17.p
  %v18 = getelementptr i64, ptr %s3, i64 0
  %v55 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v55, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = getelementptr i64, ptr %s4, i64 0
  %st10 = getelementptr i64, ptr %v20, i64 0
  store i64 %v16, ptr %st10
  %v56 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v56, i64 0
  %v21 = load i64, ptr %v21.p
  br label %b6
b4:
  %v57 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v57, i64 0
  store i64 %v15, ptr %st11
  %v49.p = getelementptr i64, ptr %v14, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 0
  %v51.c = icmp eq i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v58, i64 0
  store i64 %v8, ptr %st12
  ret i64 %v51
b5:
  br label %b4
b6:
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v59, i64 0
  store i64 %v21, ptr %st13
  %v22.p = getelementptr i64, ptr %v20, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp slt i64 %v22, %v17
  %v23 = zext i1 %v23.c to i64
  %c.b6 = icmp ne i64 %v23, 0
  br i1 %c.b6, label %b6.t15, label %b6.e16
b6.t15:
  br label %b7
b6.e16:
  br label %b8
b7:
  call void @"rt.region_enter"()
  %v60 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v60, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v20, i64 0
  %v25 = load i64, ptr %v25.p
  %v61 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v61, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 1
  %v28 = add i64 %v8, %v27
  %v29.p = getelementptr i64, ptr %v14, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v6, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.c = icmp uge i64 %v25, %v30
  %v31 = zext i1 %v31.c to i64
  %c.b7 = icmp ne i64 %v31, 0
  br i1 %c.b7, label %b7.t17, label %b7.e18
b7.t17:
  br label %b10
b7.e18:
  br label %b11
b8:
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v62, i64 0
  store i64 %v21, ptr %st18
  br label %b5
b9:
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v63, i64 0
  store i64 %v26, ptr %st19
  %v46 = add i64 0, 1
  %v47.p = getelementptr i64, ptr %v20, i64 0
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 %v47, %v46
  %st20 = getelementptr i64, ptr %v20, i64 0
  store i64 %v48, ptr %st20
  br label %b6
b10:
  %v32 = add i64 0, 1
  call void @"rt.panic"(i64 %v32)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v33.p = getelementptr i64, ptr %v6, i64 0
  %v33 = load i64, ptr %v33.p
  %v34 = inttoptr i64 %v33 to ptr
  %v35 = getelementptr i8, ptr %v34, i64 %v25
  %v36.p = getelementptr i8, ptr %v35, i64 0
  %v36.b = load i8, ptr %v36.p
  %v36 = zext i8 %v36.b to i64
  %v37.p = getelementptr i64, ptr %v7, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v25, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b11 = icmp ne i64 %v38, 0
  br i1 %c.b11, label %b11.t22, label %b11.e23
b11.t22:
  br label %b12
b11.e23:
  br label %b13
b12:
  %v39 = add i64 0, 2
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v40.p = getelementptr i64, ptr %v7, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = getelementptr i8, ptr %v41, i64 %v25
  %v43.p = getelementptr i8, ptr %v42, i64 0
  %v43.b = load i8, ptr %v43.p
  %v43 = zext i8 %v43.b to i64
  %v44 = xor i64 %v36, %v43
  %v45 = or i64 %v29, %v44
  %st23 = getelementptr i64, ptr %v14, i64 0
  store i64 %v45, ptr %st23
  br label %b9
}

define internal void @"std/crypto/x25519.Base"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v83, i64 0
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
  %v16 = add i64 0, 9
  %v17 = add i64 0, 1
  %v18 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v17)
  %v19 = add i64 0, 0
  %v20 = getelementptr i8, ptr %v18, i64 %v19
  %st4 = getelementptr i8, ptr %v20, i64 0
  %st4.b = trunc i64 %v16 to i8
  store i8 %st4.b, ptr %st4
  %v21 = add i64 0, 1
  %v22 = getelementptr i64, ptr %s1, i64 0
  %v23 = ptrtoint ptr %v18 to i64
  %st5 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st5
  %st6 = getelementptr i64, ptr %v22, i64 1
  store i64 %v21, ptr %st6
  %st7 = getelementptr i64, ptr %v22, i64 2
  store i64 %v15, ptr %st7
  %v24 = getelementptr i64, ptr %s2, i64 0
  %v25.p = getelementptr i64, ptr %v22, i64 0
  %v25 = load i64, ptr %v25.p
  %st8 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st8
  %v26.p = getelementptr i64, ptr %v22, i64 1
  %v26 = load i64, ptr %v26.p
  %st9 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st9
  %v27.p = getelementptr i64, ptr %v22, i64 2
  %v27 = load i64, ptr %v27.p
  %st10 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st10
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v84, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 1
  %v30 = add i64 0, 32
  %v31 = getelementptr i64, ptr %s3, i64 0
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v85, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s4, i64 0
  %st11 = getelementptr i64, ptr %v33, i64 0
  store i64 %v29, ptr %st11
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v86, i64 0
  %v34 = load i64, ptr %v34.p
  br label %b3
b1:
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v87, i64 0
  store i64 %v28, ptr %st12
  %v72 = getelementptr i64, ptr %s6, i64 0
  %v73.p = getelementptr i64, ptr %v4, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v4, i64 1
  %v74 = load i64, ptr %v74.p
  %v75.p = getelementptr i64, ptr %v4, i64 2
  %v75 = load i64, ptr %v75.p
  %v76.p = getelementptr i64, ptr %v24, i64 0
  %v76 = load i64, ptr %v76.p
  %v77.p = getelementptr i64, ptr %v24, i64 1
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v24, i64 2
  %v78 = load i64, ptr %v78.p
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v79, i64 2571
  store i64 %v15, ptr %st13
  call void @"std/crypto/x25519.Shared"(ptr %v72, i64 %v73, i64 %v74, i64 %v75, i64 %v76, i64 %v77, i64 %v78)
  %v80.p = getelementptr i64, ptr %v72, i64 0
  %v80 = load i64, ptr %v80.p
  %st14 = getelementptr i64, ptr %v0, i64 0
  store i64 %v80, ptr %st14
  %v81.p = getelementptr i64, ptr %v72, i64 1
  %v81 = load i64, ptr %v81.p
  %st15 = getelementptr i64, ptr %v0, i64 1
  store i64 %v81, ptr %st15
  %v82.p = getelementptr i64, ptr %v72, i64 2
  %v82 = load i64, ptr %v82.p
  %st16 = getelementptr i64, ptr %v0, i64 2
  store i64 %v82, ptr %st16
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v88, i64 0
  store i64 %v5, ptr %st17
  ret void
b2:
  br label %b1
b3:
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v89, i64 0
  store i64 %v34, ptr %st18
  %v35.p = getelementptr i64, ptr %v33, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.c = icmp slt i64 %v35, %v30
  %v36 = zext i1 %v36.c to i64
  %c.b3 = icmp ne i64 %v36, 0
  br i1 %c.b3, label %b3.t20, label %b3.e21
b3.t20:
  br label %b4
b3.e21:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v90, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v33, i64 0
  %v38 = load i64, ptr %v38.p
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v91, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 1
  %v41 = add i64 %v5, %v40
  %v42 = getelementptr i64, ptr %s1, i64 0
  %v43.p = getelementptr i64, ptr %v24, i64 0
  %v43 = load i64, ptr %v43.p
  %st21 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st21
  %v44.p = getelementptr i64, ptr %v24, i64 1
  %v44 = load i64, ptr %v44.p
  %st22 = getelementptr i64, ptr %v42, i64 1
  store i64 %v44, ptr %st22
  %v45.p = getelementptr i64, ptr %v24, i64 2
  %v45 = load i64, ptr %v45.p
  %st23 = getelementptr i64, ptr %v42, i64 2
  store i64 %v45, ptr %st23
  %v46 = add i64 0, 0
  %v47.p = getelementptr i64, ptr %v42, i64 2
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v42, i64 0
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v42, i64 1
  %v49 = load i64, ptr %v49.p
  %v52 = add i64 %v48, %v49
  %v53 = call i64 @"rt.tip8"(i64 %v47, i64 %v52)
  %v54 = add i64 0, 0
  %v55.c = icmp ne i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b4 = icmp ne i64 %v55, 0
  br i1 %c.b4, label %b4.t25, label %b4.e26
b4.t25:
  br label %b9
b4.e26:
  br label %b8
b5:
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v92, i64 0
  store i64 %v34, ptr %st26
  br label %b2
b6:
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v93, i64 0
  store i64 %v39, ptr %st27
  %v69 = add i64 0, 1
  %v70.p = getelementptr i64, ptr %v33, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = add i64 %v70, %v69
  %st28 = getelementptr i64, ptr %v33, i64 0
  store i64 %v71, ptr %st28
  br label %b3
b7:
  %v50 = phi ptr [ %v59, %b8 ], [ %v56, %b9 ]
  %v51 = phi ptr [ %v60, %b8 ], [ %v57, %b9 ]
  %st29 = getelementptr i8, ptr %v51, i64 0
  %st29.b = trunc i64 %v46 to i8
  store i8 %st29.b, ptr %st29
  %v61.p = getelementptr i64, ptr %v42, i64 1
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 0, 1
  %v63 = add i64 %v61, %v62
  %v64 = getelementptr i64, ptr %s5, i64 0
  %v65 = ptrtoint ptr %v50 to i64
  %st30 = getelementptr i64, ptr %v64, i64 0
  store i64 %v65, ptr %st30
  %st31 = getelementptr i64, ptr %v64, i64 1
  store i64 %v63, ptr %st31
  %st32 = getelementptr i64, ptr %v64, i64 2
  store i64 %v47, ptr %st32
  %v66.p = getelementptr i64, ptr %v64, i64 0
  %v66 = load i64, ptr %v66.p
  %st33 = getelementptr i64, ptr %v24, i64 0
  store i64 %v66, ptr %st33
  %v67.p = getelementptr i64, ptr %v64, i64 1
  %v67 = load i64, ptr %v67.p
  %st34 = getelementptr i64, ptr %v24, i64 1
  store i64 %v67, ptr %st34
  %v68.p = getelementptr i64, ptr %v64, i64 2
  %v68 = load i64, ptr %v68.p
  %st35 = getelementptr i64, ptr %v24, i64 2
  store i64 %v68, ptr %st35
  br label %b6
b8:
  %v58 = add i64 0, 1
  %v59 = call ptr @"rt.slice_grow8"(i64 %v48, i64 %v49, i64 %v47, i64 %v58)
  %v60 = getelementptr i8, ptr %v59, i64 %v49
  br label %b7
b9:
  %v56 = inttoptr i64 %v48 to ptr
  %v57 = getelementptr i8, ptr %v56, i64 %v49
  br label %b7
}

define internal void @"std/crypto/x25519.Shared"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v6, ptr %st5
  %v480 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v480, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v10, i64 2571
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v10, i64 2571
  store i64 %v12, ptr %st6
  %v13 = add i64 0, 1
  %v14.c = icmp sge i64 %v11, %v13
  %v14 = zext i1 %v14.c to i64
  %v15.c = icmp sle i64 %v11, %v9
  %v15 = zext i1 %v15.c to i64
  %v16 = and i64 %v14, %v15
  %v17 = sub i64 %v11, %v9
  %v18 = mul i64 %v16, %v17
  %v19 = add i64 %v9, %v18
  call void @"rt.region_enter"()
  %v481 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v481, i64 0
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 0
  %v22 = call ptr @"rt.region_alloc"(i64 %v20, i64 %v21)
  %v23 = add i64 0, 0
  %v24 = getelementptr i64, ptr %s2, i64 0
  %v25 = ptrtoint ptr %v22 to i64
  %st7 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st7
  %st8 = getelementptr i64, ptr %v24, i64 1
  store i64 %v23, ptr %st8
  %st9 = getelementptr i64, ptr %v24, i64 2
  store i64 %v20, ptr %st9
  %v26 = getelementptr i64, ptr %s3, i64 0
  %v27.p = getelementptr i64, ptr %v24, i64 0
  %v27 = load i64, ptr %v27.p
  %st10 = getelementptr i64, ptr %v26, i64 0
  store i64 %v27, ptr %st10
  %v28.p = getelementptr i64, ptr %v24, i64 1
  %v28 = load i64, ptr %v28.p
  %st11 = getelementptr i64, ptr %v26, i64 1
  store i64 %v28, ptr %st11
  %v29.p = getelementptr i64, ptr %v24, i64 2
  %v29 = load i64, ptr %v29.p
  %st12 = getelementptr i64, ptr %v26, i64 2
  store i64 %v29, ptr %st12
  %v482 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v482, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 0
  %v32 = add i64 0, 32
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v483 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v483, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = getelementptr i64, ptr %s5, i64 0
  %st13 = getelementptr i64, ptr %v35, i64 0
  store i64 %v31, ptr %st13
  %v484 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v484, i64 0
  %v36 = load i64, ptr %v36.p
  br label %b3
b1:
  %v485 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v485, i64 0
  store i64 %v30, ptr %st14
  %v86 = add i64 0, 0
  %v87 = add i64 0, 0
  %v88.p = getelementptr i64, ptr %v26, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.c = icmp uge i64 %v87, %v88
  %v89 = zext i1 %v89.c to i64
  %c.b1 = icmp ne i64 %v89, 0
  br i1 %c.b1, label %b1.t16, label %b1.e17
b1.t16:
  br label %b12
b1.e17:
  br label %b13
b2:
  br label %b1
b3:
  %v486 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v486, i64 0
  store i64 %v36, ptr %st17
  %v37.p = getelementptr i64, ptr %v35, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp slt i64 %v37, %v32
  %v38 = zext i1 %v38.c to i64
  %c.b3 = icmp ne i64 %v38, 0
  br i1 %c.b3, label %b3.t19, label %b3.e20
b3.t19:
  br label %b4
b3.e20:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v487 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v487, i64 0
  %v39 = load i64, ptr %v39.p
  %v40.p = getelementptr i64, ptr %v35, i64 0
  %v40 = load i64, ptr %v40.p
  %v488 = getelementptr i64, ptr @"rt.meta", i64 0
  %v41.p = getelementptr i64, ptr %v488, i64 0
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 1
  %v43 = add i64 %v9, %v42
  %v44 = getelementptr i64, ptr %s2, i64 0
  %v45.p = getelementptr i64, ptr %v26, i64 0
  %v45 = load i64, ptr %v45.p
  %st20 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st20
  %v46.p = getelementptr i64, ptr %v26, i64 1
  %v46 = load i64, ptr %v46.p
  %st21 = getelementptr i64, ptr %v44, i64 1
  store i64 %v46, ptr %st21
  %v47.p = getelementptr i64, ptr %v26, i64 2
  %v47 = load i64, ptr %v47.p
  %st22 = getelementptr i64, ptr %v44, i64 2
  store i64 %v47, ptr %st22
  %v48.p = getelementptr i64, ptr %v7, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp uge i64 %v40, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b4 = icmp ne i64 %v49, 0
  br i1 %c.b4, label %b4.t24, label %b4.e25
b4.t24:
  br label %b7
b4.e25:
  br label %b8
b5:
  %v489 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v489, i64 0
  store i64 %v36, ptr %st25
  br label %b2
b6:
  %v490 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v490, i64 0
  store i64 %v41, ptr %st26
  %v83 = add i64 0, 1
  %v84.p = getelementptr i64, ptr %v35, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 %v84, %v83
  %st27 = getelementptr i64, ptr %v35, i64 0
  store i64 %v85, ptr %st27
  br label %b3
b7:
  %v50 = add i64 0, 3
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v51.p = getelementptr i64, ptr %v7, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = getelementptr i8, ptr %v52, i64 %v40
  %v54.p = getelementptr i8, ptr %v53, i64 0
  %v54.b = load i8, ptr %v54.p
  %v54 = zext i8 %v54.b to i64
  %v55.p = getelementptr i64, ptr %v44, i64 2
  %v55 = load i64, ptr %v55.p
  %v56.p = getelementptr i64, ptr %v44, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v44, i64 1
  %v57 = load i64, ptr %v57.p
  %v60 = add i64 0, 8
  %v61 = mul i64 %v57, %v60
  %v62 = add i64 %v56, %v61
  %v491 = getelementptr i64, ptr @"rt.meta", i64 0
  %v492 = getelementptr i64, ptr %v491, i64 %v55
  %v63.p = getelementptr i64, ptr %v492, i64 1
  %v63 = load ptr, ptr %v63.p
  %v64 = ptrtoint ptr %v63 to i64
  %v65.c = icmp eq i64 %v64, %v62
  %v65 = zext i1 %v65.c to i64
  %c.b8 = icmp ne i64 %v65, 0
  br i1 %c.b8, label %b8.t29, label %b8.e30
b8.t29:
  br label %b11
b8.e30:
  br label %b10
b9:
  %v58 = phi ptr [ %v73, %b10 ], [ %v68, %b11 ]
  %v59 = phi ptr [ %v74, %b10 ], [ %v67, %b11 ]
  %st30 = getelementptr i64, ptr %v59, i64 0
  store i64 %v54, ptr %st30
  %v75.p = getelementptr i64, ptr %v44, i64 1
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 1
  %v77 = add i64 %v75, %v76
  %v78 = getelementptr i64, ptr %s6, i64 0
  %v79 = ptrtoint ptr %v58 to i64
  %st31 = getelementptr i64, ptr %v78, i64 0
  store i64 %v79, ptr %st31
  %st32 = getelementptr i64, ptr %v78, i64 1
  store i64 %v77, ptr %st32
  %st33 = getelementptr i64, ptr %v78, i64 2
  store i64 %v55, ptr %st33
  %v80.p = getelementptr i64, ptr %v78, i64 0
  %v80 = load i64, ptr %v80.p
  %st34 = getelementptr i64, ptr %v26, i64 0
  store i64 %v80, ptr %st34
  %v81.p = getelementptr i64, ptr %v78, i64 1
  %v81 = load i64, ptr %v81.p
  %st35 = getelementptr i64, ptr %v26, i64 1
  store i64 %v81, ptr %st35
  %v82.p = getelementptr i64, ptr %v78, i64 2
  %v82 = load i64, ptr %v82.p
  %st36 = getelementptr i64, ptr %v26, i64 2
  store i64 %v82, ptr %st36
  br label %b6
b10:
  %v69 = add i64 0, 1
  %v70 = mul i64 %v57, %v69
  %v71 = add i64 0, 1
  %v72 = add i64 0, 1
  %v73 = call ptr @"rt.slice_grow"(i64 %v56, i64 %v57, i64 %v71, i64 %v55, i64 %v72)
  %v74 = getelementptr i64, ptr %v73, i64 %v70
  br label %b9
b11:
  %v66 = add i64 0, 1
  %v67 = call ptr @"rt.region_alloc"(i64 %v55, i64 %v66)
  %v68 = inttoptr i64 %v56 to ptr
  br label %b9
b12:
  %v90 = add i64 0, 4
  call void @"rt.panic"(i64 %v90)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v91.p = getelementptr i64, ptr %v26, i64 0
  %v91 = load i64, ptr %v91.p
  %v92 = inttoptr i64 %v91 to ptr
  %v93 = add i64 0, 1
  %v94 = mul i64 %v87, %v93
  %v95 = getelementptr i64, ptr %v92, i64 %v94
  %v96.p = getelementptr i64, ptr %v95, i64 0
  %v96 = load i64, ptr %v96.p
  %v97 = add i64 0, 248
  %v98 = and i64 %v96, %v97
  %v99.p = getelementptr i64, ptr %v26, i64 1
  %v99 = load i64, ptr %v99.p
  %v100.c = icmp uge i64 %v86, %v99
  %v100 = zext i1 %v100.c to i64
  %c.b13 = icmp ne i64 %v100, 0
  br i1 %c.b13, label %b13.t38, label %b13.e39
b13.t38:
  br label %b14
b13.e39:
  br label %b15
b14:
  %v101 = add i64 0, 5
  call void @"rt.panic"(i64 %v101)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v102.p = getelementptr i64, ptr %v26, i64 0
  %v102 = load i64, ptr %v102.p
  %v103 = inttoptr i64 %v102 to ptr
  %v104 = add i64 0, 1
  %v105 = mul i64 %v86, %v104
  %v106 = getelementptr i64, ptr %v103, i64 %v105
  %st39 = getelementptr i64, ptr %v106, i64 0
  store i64 %v98, ptr %st39
  %v107 = add i64 0, 31
  %v108 = add i64 0, 31
  %v109.p = getelementptr i64, ptr %v26, i64 1
  %v109 = load i64, ptr %v109.p
  %v110.c = icmp uge i64 %v108, %v109
  %v110 = zext i1 %v110.c to i64
  %c.b15 = icmp ne i64 %v110, 0
  br i1 %c.b15, label %b15.t41, label %b15.e42
b15.t41:
  br label %b16
b15.e42:
  br label %b17
b16:
  %v111 = add i64 0, 6
  call void @"rt.panic"(i64 %v111)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v112.p = getelementptr i64, ptr %v26, i64 0
  %v112 = load i64, ptr %v112.p
  %v113 = inttoptr i64 %v112 to ptr
  %v114 = add i64 0, 1
  %v115 = mul i64 %v108, %v114
  %v116 = getelementptr i64, ptr %v113, i64 %v115
  %v117.p = getelementptr i64, ptr %v116, i64 0
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 0, 127
  %v119 = and i64 %v117, %v118
  %v120 = add i64 0, 64
  %v121 = or i64 %v119, %v120
  %v122.p = getelementptr i64, ptr %v26, i64 1
  %v122 = load i64, ptr %v122.p
  %v123.c = icmp uge i64 %v107, %v122
  %v123 = zext i1 %v123.c to i64
  %c.b17 = icmp ne i64 %v123, 0
  br i1 %c.b17, label %b17.t43, label %b17.e44
b17.t43:
  br label %b18
b17.e44:
  br label %b19
b18:
  %v124 = add i64 0, 7
  call void @"rt.panic"(i64 %v124)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b19:
  %v125.p = getelementptr i64, ptr %v26, i64 0
  %v125 = load i64, ptr %v125.p
  %v126 = inttoptr i64 %v125 to ptr
  %v127 = add i64 0, 1
  %v128 = mul i64 %v107, %v127
  %v129 = getelementptr i64, ptr %v126, i64 %v128
  %st44 = getelementptr i64, ptr %v129, i64 0
  store i64 %v121, ptr %st44
  %v130 = add i64 0, 0
  %v131 = call ptr @"rt.region_alloc"(i64 %v19, i64 %v130)
  %v132 = add i64 0, 0
  %v133 = getelementptr i64, ptr %s6, i64 0
  %v134 = ptrtoint ptr %v131 to i64
  %st45 = getelementptr i64, ptr %v133, i64 0
  store i64 %v134, ptr %st45
  %st46 = getelementptr i64, ptr %v133, i64 1
  store i64 %v132, ptr %st46
  %st47 = getelementptr i64, ptr %v133, i64 2
  store i64 %v19, ptr %st47
  %v135 = getelementptr i64, ptr %s2, i64 0
  %v136.p = getelementptr i64, ptr %v133, i64 0
  %v136 = load i64, ptr %v136.p
  %st48 = getelementptr i64, ptr %v135, i64 0
  store i64 %v136, ptr %st48
  %v137.p = getelementptr i64, ptr %v133, i64 1
  %v137 = load i64, ptr %v137.p
  %st49 = getelementptr i64, ptr %v135, i64 1
  store i64 %v137, ptr %st49
  %v138.p = getelementptr i64, ptr %v133, i64 2
  %v138 = load i64, ptr %v138.p
  %st50 = getelementptr i64, ptr %v135, i64 2
  store i64 %v138, ptr %st50
  %v139 = add i64 0, 0
  %v140 = add i64 0, 0
  %v141 = add i64 0, 85
  %v142 = add i64 0, 0
  %v143 = sub i64 %v141, %v140
  %v144.c = icmp sle i64 %v143, %v139
  %v144 = zext i1 %v144.c to i64
  %c.b19 = icmp ne i64 %v144, 0
  br i1 %c.b19, label %b19.t52, label %b19.e53
b19.t52:
  br label %b20
b19.e53:
  br label %b21
b20:
  %v187 = getelementptr i64, ptr %s7, i64 0
  %v188.p = getelementptr i64, ptr %v135, i64 0
  %v188 = load i64, ptr %v188.p
  %st53 = getelementptr i64, ptr %v187, i64 0
  store i64 %v188, ptr %st53
  %v189.p = getelementptr i64, ptr %v135, i64 1
  %v189 = load i64, ptr %v189.p
  %st54 = getelementptr i64, ptr %v187, i64 1
  store i64 %v189, ptr %st54
  %v190.p = getelementptr i64, ptr %v135, i64 2
  %v190 = load i64, ptr %v190.p
  %st55 = getelementptr i64, ptr %v187, i64 2
  store i64 %v190, ptr %st55
  %v191 = add i64 0, 0
  %v192 = add i64 0, 85
  %v193 = getelementptr i64, ptr %s6, i64 0
  %v194.p = getelementptr i64, ptr %v187, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = add i64 0, 3
  %v196.n = and i64 %v195, 63
  %v196 = shl i64 %v191, %v196.n
  %v197 = add i64 %v194, %v196
  %st56 = getelementptr i64, ptr %v193, i64 0
  store i64 %v197, ptr %st56
  %st57 = getelementptr i64, ptr %v193, i64 1
  store i64 %v192, ptr %st57
  %v198.p = getelementptr i64, ptr %v187, i64 2
  %v198 = load i64, ptr %v198.p
  %st58 = getelementptr i64, ptr %v193, i64 2
  store i64 %v198, ptr %st58
  %v199 = getelementptr i64, ptr %s8, i64 0
  %v200.p = getelementptr i64, ptr %v193, i64 0
  %v200 = load i64, ptr %v200.p
  %st59 = getelementptr i64, ptr %v199, i64 0
  store i64 %v200, ptr %st59
  %v201.p = getelementptr i64, ptr %v193, i64 1
  %v201 = load i64, ptr %v201.p
  %st60 = getelementptr i64, ptr %v199, i64 1
  store i64 %v201, ptr %st60
  %v202.p = getelementptr i64, ptr %v193, i64 2
  %v202 = load i64, ptr %v202.p
  %st61 = getelementptr i64, ptr %v199, i64 2
  store i64 %v202, ptr %st61
  %v203.p = getelementptr i64, ptr %v187, i64 0
  %v203 = load i64, ptr %v203.p
  %v204 = add i64 0, 1
  %v205 = add i64 %v9, %v204
  %v206 = add i64 0, 0
  %v207.p = getelementptr i64, ptr %v8, i64 0
  %v207 = load i64, ptr %v207.p
  %v208.p = getelementptr i64, ptr %v8, i64 1
  %v208 = load i64, ptr %v208.p
  %v209.p = getelementptr i64, ptr %v8, i64 2
  %v209 = load i64, ptr %v209.p
  %v210 = getelementptr i64, ptr @"rt.meta", i64 0
  %st62 = getelementptr i64, ptr %v210, i64 2572
  store i64 %v205, ptr %st62
  call void @"std/crypto/x25519.unpack"(ptr %v199, i64 %v206, i64 %v207, i64 %v208, i64 %v209)
  %v211 = add i64 0, 5
  %v212 = add i64 0, 1
  %v213.p = getelementptr i64, ptr %v199, i64 1
  %v213 = load i64, ptr %v213.p
  %v214.c = icmp uge i64 %v211, %v213
  %v214 = zext i1 %v214.c to i64
  %c.b20 = icmp ne i64 %v214, 0
  br i1 %c.b20, label %b20.t64, label %b20.e65
b20.t64:
  br label %b28
b20.e65:
  br label %b29
b21:
  %v145 = getelementptr i64, ptr %s6, i64 0
  %v146.p = getelementptr i64, ptr %v135, i64 0
  %v146 = load i64, ptr %v146.p
  %st65 = getelementptr i64, ptr %v145, i64 0
  store i64 %v146, ptr %st65
  %v147.p = getelementptr i64, ptr %v135, i64 1
  %v147 = load i64, ptr %v147.p
  %st66 = getelementptr i64, ptr %v145, i64 1
  store i64 %v147, ptr %st66
  %v148.p = getelementptr i64, ptr %v135, i64 2
  %v148 = load i64, ptr %v148.p
  %st67 = getelementptr i64, ptr %v145, i64 2
  store i64 %v148, ptr %st67
  %v149.p = getelementptr i64, ptr %v145, i64 2
  %v149 = load i64, ptr %v149.p
  %v150.p = getelementptr i64, ptr %v145, i64 0
  %v150 = load i64, ptr %v150.p
  %v151.p = getelementptr i64, ptr %v145, i64 1
  %v151 = load i64, ptr %v151.p
  %v154 = add i64 0, 8
  %v155 = mul i64 %v151, %v154
  %v156 = add i64 %v150, %v155
  %v493 = getelementptr i64, ptr @"rt.meta", i64 0
  %v494 = getelementptr i64, ptr %v493, i64 %v149
  %v157.p = getelementptr i64, ptr %v494, i64 1
  %v157 = load ptr, ptr %v157.p
  %v158 = ptrtoint ptr %v157 to i64
  %v159.c = icmp eq i64 %v158, %v156
  %v159 = zext i1 %v159.c to i64
  %c.b21 = icmp ne i64 %v159, 0
  br i1 %c.b21, label %b21.t69, label %b21.e70
b21.t69:
  br label %b24
b21.e70:
  br label %b23
b22:
  %v152 = phi ptr [ %v169, %b23 ], [ %v163, %b24 ]
  %v153 = phi ptr [ %v171, %b23 ], [ %v162, %b24 ]
  %v173 = add i64 0, 0
  br label %b25
b23:
  %v164 = add i64 0, 1
  %v165 = mul i64 %v151, %v164
  %v166 = add i64 0, 1
  %v167 = mul i64 %v143, %v166
  %v168 = add i64 %v165, %v167
  %v169 = call ptr @"rt.region_alloc"(i64 %v149, i64 %v168)
  %v170 = inttoptr i64 %v150 to ptr
  call void @"rt.copy"(ptr %v169, ptr %v170, i64 %v165)
  %v171 = getelementptr i64, ptr %v169, i64 %v165
  br label %b22
b24:
  %v160 = add i64 0, 1
  %v161 = mul i64 %v143, %v160
  %v162 = call ptr @"rt.region_alloc"(i64 %v149, i64 %v161)
  %v163 = inttoptr i64 %v150 to ptr
  br label %b22
b25:
  %v172 = phi i64 [ %v173, %b22 ], [ %v179, %b26 ]
  %v174.c = icmp slt i64 %v172, %v143
  %v174 = zext i1 %v174.c to i64
  %c.b25 = icmp ne i64 %v174, 0
  br i1 %c.b25, label %b25.t71, label %b25.e72
b25.t71:
  br label %b26
b25.e72:
  br label %b27
b26:
  %v175 = add i64 0, 1
  %v176 = mul i64 %v172, %v175
  %v177 = getelementptr i64, ptr %v153, i64 %v176
  %st72 = getelementptr i64, ptr %v177, i64 0
  store i64 %v142, ptr %st72
  %v178 = add i64 0, 1
  %v179 = add i64 %v172, %v178
  br label %b25
b27:
  %v180.p = getelementptr i64, ptr %v145, i64 1
  %v180 = load i64, ptr %v180.p
  %v181 = add i64 %v180, %v143
  %v182 = getelementptr i64, ptr %s7, i64 0
  %v183 = ptrtoint ptr %v152 to i64
  %st73 = getelementptr i64, ptr %v182, i64 0
  store i64 %v183, ptr %st73
  %st74 = getelementptr i64, ptr %v182, i64 1
  store i64 %v181, ptr %st74
  %st75 = getelementptr i64, ptr %v182, i64 2
  store i64 %v149, ptr %st75
  %v184.p = getelementptr i64, ptr %v182, i64 0
  %v184 = load i64, ptr %v184.p
  %st76 = getelementptr i64, ptr %v135, i64 0
  store i64 %v184, ptr %st76
  %v185.p = getelementptr i64, ptr %v182, i64 1
  %v185 = load i64, ptr %v185.p
  %st77 = getelementptr i64, ptr %v135, i64 1
  store i64 %v185, ptr %st77
  %v186.p = getelementptr i64, ptr %v182, i64 2
  %v186 = load i64, ptr %v186.p
  %st78 = getelementptr i64, ptr %v135, i64 2
  store i64 %v186, ptr %st78
  br label %b20
b28:
  %v215 = add i64 0, 8
  call void @"rt.panic"(i64 %v215)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b29:
  %v216.p = getelementptr i64, ptr %v199, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = inttoptr i64 %v216 to ptr
  %v218 = add i64 0, 1
  %v219 = mul i64 %v211, %v218
  %v220 = getelementptr i64, ptr %v217, i64 %v219
  %st79 = getelementptr i64, ptr %v220, i64 0
  store i64 %v212, ptr %st79
  %v495 = getelementptr i64, ptr @"rt.meta", i64 0
  %v221.p = getelementptr i64, ptr %v495, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = add i64 0, 0
  %v223 = add i64 0, 5
  %v224 = getelementptr i64, ptr %s5, i64 0
  %v496 = getelementptr i64, ptr @"rt.meta", i64 0
  %v225.p = getelementptr i64, ptr %v496, i64 0
  %v225 = load i64, ptr %v225.p
  %v226 = getelementptr i64, ptr %s4, i64 0
  %st80 = getelementptr i64, ptr %v226, i64 0
  store i64 %v222, ptr %st80
  %v497 = getelementptr i64, ptr @"rt.meta", i64 0
  %v227.p = getelementptr i64, ptr %v497, i64 0
  %v227 = load i64, ptr %v227.p
  br label %b32
b30:
  %v498 = getelementptr i64, ptr @"rt.meta", i64 0
  %st81 = getelementptr i64, ptr %v498, i64 0
  store i64 %v221, ptr %st81
  %v257 = add i64 0, 20
  %v258 = add i64 0, 1
  %v259.p = getelementptr i64, ptr %v199, i64 1
  %v259 = load i64, ptr %v259.p
  %v260.c = icmp uge i64 %v257, %v259
  %v260 = zext i1 %v260.c to i64
  %c.b30 = icmp ne i64 %v260, 0
  br i1 %c.b30, label %b30.t83, label %b30.e84
b30.t83:
  br label %b40
b30.e84:
  br label %b41
b31:
  br label %b30
b32:
  %v499 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v499, i64 0
  store i64 %v227, ptr %st84
  %v228.p = getelementptr i64, ptr %v226, i64 0
  %v228 = load i64, ptr %v228.p
  %v229.c = icmp slt i64 %v228, %v223
  %v229 = zext i1 %v229.c to i64
  %c.b32 = icmp ne i64 %v229, 0
  br i1 %c.b32, label %b32.t86, label %b32.e87
b32.t86:
  br label %b33
b32.e87:
  br label %b34
b33:
  call void @"rt.region_enter"()
  %v500 = getelementptr i64, ptr @"rt.meta", i64 0
  %v230.p = getelementptr i64, ptr %v500, i64 0
  %v230 = load i64, ptr %v230.p
  %v231.p = getelementptr i64, ptr %v226, i64 0
  %v231 = load i64, ptr %v231.p
  %v501 = getelementptr i64, ptr @"rt.meta", i64 0
  %v232.p = getelementptr i64, ptr %v501, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = add i64 0, 15
  %v234 = add i64 %v233, %v231
  %v235 = add i64 0, 0
  %v236 = add i64 %v235, %v231
  %v237.p = getelementptr i64, ptr %v199, i64 1
  %v237 = load i64, ptr %v237.p
  %v238.c = icmp uge i64 %v236, %v237
  %v238 = zext i1 %v238.c to i64
  %c.b33 = icmp ne i64 %v238, 0
  br i1 %c.b33, label %b33.t88, label %b33.e89
b33.t88:
  br label %b36
b33.e89:
  br label %b37
b34:
  %v502 = getelementptr i64, ptr @"rt.meta", i64 0
  %st89 = getelementptr i64, ptr %v502, i64 0
  store i64 %v227, ptr %st89
  br label %b31
b35:
  %v503 = getelementptr i64, ptr @"rt.meta", i64 0
  %st90 = getelementptr i64, ptr %v503, i64 0
  store i64 %v232, ptr %st90
  %v254 = add i64 0, 1
  %v255.p = getelementptr i64, ptr %v226, i64 0
  %v255 = load i64, ptr %v255.p
  %v256 = add i64 %v255, %v254
  %st91 = getelementptr i64, ptr %v226, i64 0
  store i64 %v256, ptr %st91
  br label %b32
b36:
  %v239 = add i64 0, 9
  call void @"rt.panic"(i64 %v239)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b37:
  %v240.p = getelementptr i64, ptr %v199, i64 0
  %v240 = load i64, ptr %v240.p
  %v241 = inttoptr i64 %v240 to ptr
  %v242 = add i64 0, 1
  %v243 = mul i64 %v236, %v242
  %v244 = getelementptr i64, ptr %v241, i64 %v243
  %v245.p = getelementptr i64, ptr %v244, i64 0
  %v245 = load i64, ptr %v245.p
  %v246.p = getelementptr i64, ptr %v199, i64 1
  %v246 = load i64, ptr %v246.p
  %v247.c = icmp uge i64 %v234, %v246
  %v247 = zext i1 %v247.c to i64
  %c.b37 = icmp ne i64 %v247, 0
  br i1 %c.b37, label %b37.t93, label %b37.e94
b37.t93:
  br label %b38
b37.e94:
  br label %b39
b38:
  %v248 = add i64 0, 10
  call void @"rt.panic"(i64 %v248)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b39:
  %v249.p = getelementptr i64, ptr %v199, i64 0
  %v249 = load i64, ptr %v249.p
  %v250 = inttoptr i64 %v249 to ptr
  %v251 = add i64 0, 1
  %v252 = mul i64 %v234, %v251
  %v253 = getelementptr i64, ptr %v250, i64 %v252
  %st94 = getelementptr i64, ptr %v253, i64 0
  store i64 %v245, ptr %st94
  br label %b35
b40:
  %v261 = add i64 0, 11
  call void @"rt.panic"(i64 %v261)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b41:
  %v262.p = getelementptr i64, ptr %v199, i64 0
  %v262 = load i64, ptr %v262.p
  %v263 = inttoptr i64 %v262 to ptr
  %v264 = add i64 0, 1
  %v265 = mul i64 %v257, %v264
  %v266 = getelementptr i64, ptr %v263, i64 %v265
  %st95 = getelementptr i64, ptr %v266, i64 0
  store i64 %v258, ptr %st95
  %v267 = add i64 0, 75
  %v268 = add i64 0, 121665
  %v269.p = getelementptr i64, ptr %v199, i64 1
  %v269 = load i64, ptr %v269.p
  %v270.c = icmp uge i64 %v267, %v269
  %v270 = zext i1 %v270.c to i64
  %c.b41 = icmp ne i64 %v270, 0
  br i1 %c.b41, label %b41.t97, label %b41.e98
b41.t97:
  br label %b42
b41.e98:
  br label %b43
b42:
  %v271 = add i64 0, 12
  call void @"rt.panic"(i64 %v271)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b43:
  %v272.p = getelementptr i64, ptr %v199, i64 0
  %v272 = load i64, ptr %v272.p
  %v273 = inttoptr i64 %v272 to ptr
  %v274 = add i64 0, 1
  %v275 = mul i64 %v267, %v274
  %v276 = getelementptr i64, ptr %v273, i64 %v275
  %st98 = getelementptr i64, ptr %v276, i64 0
  store i64 %v268, ptr %st98
  %v277 = add i64 0, 0
  %v278 = getelementptr i64, ptr %s4, i64 0
  %st99 = getelementptr i64, ptr %v278, i64 0
  store i64 %v277, ptr %st99
  %v504 = getelementptr i64, ptr @"rt.meta", i64 0
  %v279.p = getelementptr i64, ptr %v504, i64 0
  %v279 = load i64, ptr %v279.p
  %v280 = add i64 0, 0
  %v281 = add i64 0, 255
  %v282 = getelementptr i64, ptr %s5, i64 0
  %v505 = getelementptr i64, ptr @"rt.meta", i64 0
  %v283.p = getelementptr i64, ptr %v505, i64 0
  %v283 = load i64, ptr %v283.p
  %v284 = getelementptr i64, ptr %s9, i64 0
  %st100 = getelementptr i64, ptr %v284, i64 0
  store i64 %v280, ptr %st100
  %v506 = getelementptr i64, ptr @"rt.meta", i64 0
  %v285.p = getelementptr i64, ptr %v506, i64 0
  %v285 = load i64, ptr %v285.p
  br label %b46
b44:
  %v507 = getelementptr i64, ptr @"rt.meta", i64 0
  %st101 = getelementptr i64, ptr %v507, i64 0
  store i64 %v279, ptr %st101
  %v447.p = getelementptr i64, ptr %v278, i64 0
  %v447 = load i64, ptr %v447.p
  %v448 = add i64 0, 0
  %v449 = sub i64 %v448, %v447
  %v450 = add i64 0, 1
  %v451 = add i64 %v9, %v450
  %v452 = add i64 0, 5
  %v453 = add i64 0, 15
  %v454 = getelementptr i64, ptr @"rt.meta", i64 0
  %st102 = getelementptr i64, ptr %v454, i64 2572
  store i64 %v451, ptr %st102
  call void @"std/crypto/x25519.cswap"(ptr %v199, i64 %v452, i64 %v453, i64 %v449)
  %v455 = add i64 0, 1
  %v456 = add i64 %v9, %v455
  %v457 = add i64 0, 10
  %v458 = add i64 0, 20
  %v459 = getelementptr i64, ptr @"rt.meta", i64 0
  %st103 = getelementptr i64, ptr %v459, i64 2572
  store i64 %v456, ptr %st103
  call void @"std/crypto/x25519.cswap"(ptr %v199, i64 %v457, i64 %v458, i64 %v449)
  %v460 = add i64 0, 1
  %v461 = add i64 %v9, %v460
  %v462 = add i64 0, 80
  %v463 = add i64 0, 10
  %v464 = getelementptr i64, ptr @"rt.meta", i64 0
  %st104 = getelementptr i64, ptr %v464, i64 2572
  store i64 %v461, ptr %st104
  call void @"std/crypto/x25519.invert"(ptr %v199, i64 %v203, i64 %v462, i64 %v463)
  %v465 = add i64 0, 1
  %v466 = add i64 %v9, %v465
  %v467 = add i64 0, 80
  %v468 = add i64 0, 5
  %v469 = add i64 0, 80
  %v470 = getelementptr i64, ptr @"rt.meta", i64 0
  %st105 = getelementptr i64, ptr %v470, i64 2572
  store i64 %v466, ptr %st105
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v467, i64 %v468, i64 %v469)
  %v471 = getelementptr i64, ptr %s10, i64 0
  %v472.p = getelementptr i64, ptr %v199, i64 0
  %v472 = load i64, ptr %v472.p
  %v473.p = getelementptr i64, ptr %v199, i64 1
  %v473 = load i64, ptr %v473.p
  %v474.p = getelementptr i64, ptr %v199, i64 2
  %v474 = load i64, ptr %v474.p
  %v475 = add i64 0, 80
  %v476 = getelementptr i64, ptr @"rt.meta", i64 0
  %st106 = getelementptr i64, ptr %v476, i64 2571
  store i64 %v19, ptr %st106
  call void @"std/crypto/x25519.pack"(ptr %v471, i64 %v472, i64 %v473, i64 %v474, i64 %v475)
  %v477.p = getelementptr i64, ptr %v471, i64 0
  %v477 = load i64, ptr %v477.p
  %st107 = getelementptr i64, ptr %v0, i64 0
  store i64 %v477, ptr %st107
  %v478.p = getelementptr i64, ptr %v471, i64 1
  %v478 = load i64, ptr %v478.p
  %st108 = getelementptr i64, ptr %v0, i64 1
  store i64 %v478, ptr %st108
  %v479.p = getelementptr i64, ptr %v471, i64 2
  %v479 = load i64, ptr %v479.p
  %st109 = getelementptr i64, ptr %v0, i64 2
  store i64 %v479, ptr %st109
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v508 = getelementptr i64, ptr @"rt.meta", i64 0
  %st110 = getelementptr i64, ptr %v508, i64 0
  store i64 %v9, ptr %st110
  ret void
b45:
  br label %b44
b46:
  %v509 = getelementptr i64, ptr @"rt.meta", i64 0
  %st111 = getelementptr i64, ptr %v509, i64 0
  store i64 %v285, ptr %st111
  %v286.p = getelementptr i64, ptr %v284, i64 0
  %v286 = load i64, ptr %v286.p
  %v287.c = icmp slt i64 %v286, %v281
  %v287 = zext i1 %v287.c to i64
  %c.b46 = icmp ne i64 %v287, 0
  br i1 %c.b46, label %b46.t113, label %b46.e114
b46.t113:
  br label %b47
b46.e114:
  br label %b48
b47:
  call void @"rt.region_enter"()
  %v510 = getelementptr i64, ptr @"rt.meta", i64 0
  %v288.p = getelementptr i64, ptr %v510, i64 0
  %v288 = load i64, ptr %v288.p
  %v289.p = getelementptr i64, ptr %v284, i64 0
  %v289 = load i64, ptr %v289.p
  %v511 = getelementptr i64, ptr @"rt.meta", i64 0
  %v290.p = getelementptr i64, ptr %v511, i64 0
  %v290 = load i64, ptr %v290.p
  %v291 = add i64 0, 254
  %v292 = sub i64 %v291, %v289
  %v293 = add i64 0, 8
  %v294 = sdiv i64 %v292, %v293
  %v295.p = getelementptr i64, ptr %v26, i64 1
  %v295 = load i64, ptr %v295.p
  %v296.c = icmp uge i64 %v294, %v295
  %v296 = zext i1 %v296.c to i64
  %c.b47 = icmp ne i64 %v296, 0
  br i1 %c.b47, label %b47.t115, label %b47.e116
b47.t115:
  br label %b50
b47.e116:
  br label %b51
b48:
  %v512 = getelementptr i64, ptr @"rt.meta", i64 0
  %st116 = getelementptr i64, ptr %v512, i64 0
  store i64 %v285, ptr %st116
  br label %b45
b49:
  %v513 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v513, i64 0
  store i64 %v290, ptr %st117
  %v444 = add i64 0, 1
  %v445.p = getelementptr i64, ptr %v284, i64 0
  %v445 = load i64, ptr %v445.p
  %v446 = add i64 %v445, %v444
  %st118 = getelementptr i64, ptr %v284, i64 0
  store i64 %v446, ptr %st118
  br label %b46
b50:
  %v297 = add i64 0, 13
  call void @"rt.panic"(i64 %v297)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v298.p = getelementptr i64, ptr %v26, i64 0
  %v298 = load i64, ptr %v298.p
  %v299 = inttoptr i64 %v298 to ptr
  %v300 = add i64 0, 1
  %v301 = mul i64 %v294, %v300
  %v302 = getelementptr i64, ptr %v299, i64 %v301
  %v303.p = getelementptr i64, ptr %v302, i64 0
  %v303 = load i64, ptr %v303.p
  %v304 = add i64 0, 8
  %v305 = srem i64 %v292, %v304
  %v307 = add i64 0, 64
  %v308.c = icmp uge i64 %v305, %v307
  %v308 = zext i1 %v308.c to i64
  %c.b51 = icmp ne i64 %v308, 0
  br i1 %c.b51, label %b51.t120, label %b51.e121
b51.t120:
  br label %b52
b51.e121:
  br label %b53
b52:
  %v309 = add i64 0, 0
  %v310.c = icmp slt i64 %v305, %v309
  %v310 = zext i1 %v310.c to i64
  %c.b52 = icmp ne i64 %v310, 0
  br i1 %c.b52, label %b52.t122, label %b52.e123
b52.t122:
  br label %b55
b52.e123:
  br label %b56
b53:
  %v314.n = and i64 %v305, 63
  %v314 = ashr i64 %v303, %v314.n
  br label %b54
b54:
  %v306 = phi i64 [ %v314, %b53 ], [ %v313, %b56 ]
  %v315 = add i64 0, 1
  %v316 = and i64 %v306, %v315
  %v317 = add i64 0, 1
  %v318 = add i64 %v9, %v317
  %v319.p = getelementptr i64, ptr %v278, i64 0
  %v319 = load i64, ptr %v319.p
  %v320 = xor i64 %v319, %v316
  %st123 = getelementptr i64, ptr %v278, i64 0
  store i64 %v320, ptr %st123
  %v321.p = getelementptr i64, ptr %v278, i64 0
  %v321 = load i64, ptr %v321.p
  %v322 = add i64 0, 0
  %v323 = sub i64 %v322, %v321
  %v324 = add i64 0, 1
  %v325 = add i64 %v9, %v324
  %v326 = add i64 0, 5
  %v327 = add i64 0, 15
  %v328 = getelementptr i64, ptr @"rt.meta", i64 0
  %st124 = getelementptr i64, ptr %v328, i64 2572
  store i64 %v325, ptr %st124
  call void @"std/crypto/x25519.cswap"(ptr %v199, i64 %v326, i64 %v327, i64 %v323)
  %v329 = add i64 0, 1
  %v330 = add i64 %v9, %v329
  %v331 = add i64 0, 10
  %v332 = add i64 0, 20
  %v333 = getelementptr i64, ptr @"rt.meta", i64 0
  %st125 = getelementptr i64, ptr %v333, i64 2572
  store i64 %v330, ptr %st125
  call void @"std/crypto/x25519.cswap"(ptr %v199, i64 %v331, i64 %v332, i64 %v323)
  %v334 = add i64 0, 1
  %v335 = add i64 %v9, %v334
  %st126 = getelementptr i64, ptr %v278, i64 0
  store i64 %v316, ptr %st126
  %v336 = add i64 0, 1
  %v337 = add i64 %v9, %v336
  %v338 = add i64 0, 25
  %v339 = add i64 0, 5
  %v340 = add i64 0, 10
  %v341 = getelementptr i64, ptr @"rt.meta", i64 0
  %st127 = getelementptr i64, ptr %v341, i64 2572
  store i64 %v337, ptr %st127
  call void @"std/crypto/x25519.fadd"(ptr %v199, i64 %v338, i64 %v339, i64 %v340)
  %v342 = add i64 0, 1
  %v343 = add i64 %v9, %v342
  %v344 = add i64 0, 30
  %v345 = add i64 0, 25
  %v346 = add i64 0, 25
  %v347 = getelementptr i64, ptr @"rt.meta", i64 0
  %st128 = getelementptr i64, ptr %v347, i64 2572
  store i64 %v343, ptr %st128
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v344, i64 %v345, i64 %v346)
  %v348 = add i64 0, 1
  %v349 = add i64 %v9, %v348
  %v350 = add i64 0, 35
  %v351 = add i64 0, 5
  %v352 = add i64 0, 10
  %v353 = getelementptr i64, ptr @"rt.meta", i64 0
  %st129 = getelementptr i64, ptr %v353, i64 2572
  store i64 %v349, ptr %st129
  call void @"std/crypto/x25519.fsub"(ptr %v199, i64 %v350, i64 %v351, i64 %v352)
  %v354 = add i64 0, 1
  %v355 = add i64 %v9, %v354
  %v356 = add i64 0, 40
  %v357 = add i64 0, 35
  %v358 = add i64 0, 35
  %v359 = getelementptr i64, ptr @"rt.meta", i64 0
  %st130 = getelementptr i64, ptr %v359, i64 2572
  store i64 %v355, ptr %st130
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v356, i64 %v357, i64 %v358)
  %v360 = add i64 0, 1
  %v361 = add i64 %v9, %v360
  %v362 = add i64 0, 45
  %v363 = add i64 0, 30
  %v364 = add i64 0, 40
  %v365 = getelementptr i64, ptr @"rt.meta", i64 0
  %st131 = getelementptr i64, ptr %v365, i64 2572
  store i64 %v361, ptr %st131
  call void @"std/crypto/x25519.fsub"(ptr %v199, i64 %v362, i64 %v363, i64 %v364)
  %v366 = add i64 0, 1
  %v367 = add i64 %v9, %v366
  %v368 = add i64 0, 50
  %v369 = add i64 0, 15
  %v370 = add i64 0, 20
  %v371 = getelementptr i64, ptr @"rt.meta", i64 0
  %st132 = getelementptr i64, ptr %v371, i64 2572
  store i64 %v367, ptr %st132
  call void @"std/crypto/x25519.fadd"(ptr %v199, i64 %v368, i64 %v369, i64 %v370)
  %v372 = add i64 0, 1
  %v373 = add i64 %v9, %v372
  %v374 = add i64 0, 55
  %v375 = add i64 0, 15
  %v376 = add i64 0, 20
  %v377 = getelementptr i64, ptr @"rt.meta", i64 0
  %st133 = getelementptr i64, ptr %v377, i64 2572
  store i64 %v373, ptr %st133
  call void @"std/crypto/x25519.fsub"(ptr %v199, i64 %v374, i64 %v375, i64 %v376)
  %v378 = add i64 0, 1
  %v379 = add i64 %v9, %v378
  %v380 = add i64 0, 60
  %v381 = add i64 0, 55
  %v382 = add i64 0, 25
  %v383 = getelementptr i64, ptr @"rt.meta", i64 0
  %st134 = getelementptr i64, ptr %v383, i64 2572
  store i64 %v379, ptr %st134
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v380, i64 %v381, i64 %v382)
  %v384 = add i64 0, 1
  %v385 = add i64 %v9, %v384
  %v386 = add i64 0, 65
  %v387 = add i64 0, 50
  %v388 = add i64 0, 35
  %v389 = getelementptr i64, ptr @"rt.meta", i64 0
  %st135 = getelementptr i64, ptr %v389, i64 2572
  store i64 %v385, ptr %st135
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v386, i64 %v387, i64 %v388)
  %v390 = add i64 0, 1
  %v391 = add i64 %v9, %v390
  %v392 = add i64 0, 70
  %v393 = add i64 0, 60
  %v394 = add i64 0, 65
  %v395 = getelementptr i64, ptr @"rt.meta", i64 0
  %st136 = getelementptr i64, ptr %v395, i64 2572
  store i64 %v391, ptr %st136
  call void @"std/crypto/x25519.fadd"(ptr %v199, i64 %v392, i64 %v393, i64 %v394)
  %v396 = add i64 0, 1
  %v397 = add i64 %v9, %v396
  %v398 = add i64 0, 15
  %v399 = add i64 0, 70
  %v400 = add i64 0, 70
  %v401 = getelementptr i64, ptr @"rt.meta", i64 0
  %st137 = getelementptr i64, ptr %v401, i64 2572
  store i64 %v397, ptr %st137
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v398, i64 %v399, i64 %v400)
  %v402 = add i64 0, 1
  %v403 = add i64 %v9, %v402
  %v404 = add i64 0, 70
  %v405 = add i64 0, 60
  %v406 = add i64 0, 65
  %v407 = getelementptr i64, ptr @"rt.meta", i64 0
  %st138 = getelementptr i64, ptr %v407, i64 2572
  store i64 %v403, ptr %st138
  call void @"std/crypto/x25519.fsub"(ptr %v199, i64 %v404, i64 %v405, i64 %v406)
  %v408 = add i64 0, 1
  %v409 = add i64 %v9, %v408
  %v410 = add i64 0, 70
  %v411 = add i64 0, 70
  %v412 = add i64 0, 70
  %v413 = getelementptr i64, ptr @"rt.meta", i64 0
  %st139 = getelementptr i64, ptr %v413, i64 2572
  store i64 %v409, ptr %st139
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v410, i64 %v411, i64 %v412)
  %v414 = add i64 0, 1
  %v415 = add i64 %v9, %v414
  %v416 = add i64 0, 20
  %v417 = add i64 0, 0
  %v418 = add i64 0, 70
  %v419 = getelementptr i64, ptr @"rt.meta", i64 0
  %st140 = getelementptr i64, ptr %v419, i64 2572
  store i64 %v415, ptr %st140
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v416, i64 %v417, i64 %v418)
  %v420 = add i64 0, 1
  %v421 = add i64 %v9, %v420
  %v422 = add i64 0, 5
  %v423 = add i64 0, 30
  %v424 = add i64 0, 40
  %v425 = getelementptr i64, ptr @"rt.meta", i64 0
  %st141 = getelementptr i64, ptr %v425, i64 2572
  store i64 %v421, ptr %st141
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v422, i64 %v423, i64 %v424)
  %v426 = add i64 0, 1
  %v427 = add i64 %v9, %v426
  %v428 = add i64 0, 70
  %v429 = add i64 0, 75
  %v430 = add i64 0, 45
  %v431 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v431, i64 2572
  store i64 %v427, ptr %st142
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v428, i64 %v429, i64 %v430)
  %v432 = add i64 0, 1
  %v433 = add i64 %v9, %v432
  %v434 = add i64 0, 70
  %v435 = add i64 0, 30
  %v436 = add i64 0, 70
  %v437 = getelementptr i64, ptr @"rt.meta", i64 0
  %st143 = getelementptr i64, ptr %v437, i64 2572
  store i64 %v433, ptr %st143
  call void @"std/crypto/x25519.fadd"(ptr %v199, i64 %v434, i64 %v435, i64 %v436)
  %v438 = add i64 0, 1
  %v439 = add i64 %v9, %v438
  %v440 = add i64 0, 10
  %v441 = add i64 0, 45
  %v442 = add i64 0, 70
  %v443 = getelementptr i64, ptr @"rt.meta", i64 0
  %st144 = getelementptr i64, ptr %v443, i64 2572
  store i64 %v439, ptr %st144
  call void @"std/crypto/x25519.fmul"(ptr %v199, i64 %v203, i64 %v440, i64 %v441, i64 %v442)
  br label %b49
b55:
  %v311 = add i64 0, 14
  call void @"rt.panic"(i64 %v311)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b56:
  %v312 = add i64 0, 63
  %v313.n = and i64 %v312, 63
  %v313 = ashr i64 %v303, %v313.n
  br label %b54
}

define internal void @"std/crypto/x25519.cswap"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v88, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v5, i64 2572
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp eq i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %v9 = mul i64 %v8, %v4
  %v10 = add i64 %v6, %v9
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v89, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13 = add i64 0, 5
  %v14 = getelementptr i64, ptr %s0, i64 0
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v90, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s1, i64 0
  %st0 = getelementptr i64, ptr %v16, i64 0
  store i64 %v12, ptr %st0
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v91, i64 0
  %v17 = load i64, ptr %v17.p
  br label %b3
b1:
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v92, i64 0
  store i64 %v11, ptr %st1
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v93, i64 0
  store i64 %v4, ptr %st2
  ret void
b2:
  br label %b1
b3:
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v94, i64 0
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
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v95, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 0
  %v21 = load i64, ptr %v21.p
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v96, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 %v1, %v21
  %v24.p = getelementptr i64, ptr %v0, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp uge i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b4 = icmp ne i64 %v25, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b7
b4.e8:
  br label %b8
b5:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v97, i64 0
  store i64 %v17, ptr %st8
  br label %b2
b6:
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v98, i64 0
  store i64 %v22, ptr %st9
  %v85 = add i64 0, 1
  %v86.p = getelementptr i64, ptr %v16, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 %v86, %v85
  %st10 = getelementptr i64, ptr %v16, i64 0
  store i64 %v87, ptr %st10
  br label %b3
b7:
  %v26 = add i64 0, 15
  call void @"rt.panic"(i64 %v26)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v27.p = getelementptr i64, ptr %v0, i64 0
  %v27 = load i64, ptr %v27.p
  %v28 = inttoptr i64 %v27 to ptr
  %v29 = add i64 0, 1
  %v30 = mul i64 %v23, %v29
  %v31 = getelementptr i64, ptr %v28, i64 %v30
  %v32.p = getelementptr i64, ptr %v31, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 %v2, %v21
  %v34.p = getelementptr i64, ptr %v0, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp uge i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b8 = icmp ne i64 %v35, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b9
b8.e13:
  br label %b10
b9:
  %v36 = add i64 0, 16
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v37.p = getelementptr i64, ptr %v0, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = inttoptr i64 %v37 to ptr
  %v39 = add i64 0, 1
  %v40 = mul i64 %v33, %v39
  %v41 = getelementptr i64, ptr %v38, i64 %v40
  %v42.p = getelementptr i64, ptr %v41, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = xor i64 %v32, %v42
  %v44 = and i64 %v43, %v3
  %v45 = add i64 %v1, %v21
  %v46 = add i64 %v1, %v21
  %v47.p = getelementptr i64, ptr %v0, i64 1
  %v47 = load i64, ptr %v47.p
  %v48.c = icmp uge i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b10 = icmp ne i64 %v48, 0
  br i1 %c.b10, label %b10.t14, label %b10.e15
b10.t14:
  br label %b11
b10.e15:
  br label %b12
b11:
  %v49 = add i64 0, 17
  call void @"rt.panic"(i64 %v49)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v50.p = getelementptr i64, ptr %v0, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = inttoptr i64 %v50 to ptr
  %v52 = add i64 0, 1
  %v53 = mul i64 %v46, %v52
  %v54 = getelementptr i64, ptr %v51, i64 %v53
  %v55.p = getelementptr i64, ptr %v54, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = xor i64 %v55, %v44
  %v57.p = getelementptr i64, ptr %v0, i64 1
  %v57 = load i64, ptr %v57.p
  %v58.c = icmp uge i64 %v45, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b12 = icmp ne i64 %v58, 0
  br i1 %c.b12, label %b12.t16, label %b12.e17
b12.t16:
  br label %b13
b12.e17:
  br label %b14
b13:
  %v59 = add i64 0, 18
  call void @"rt.panic"(i64 %v59)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v60.p = getelementptr i64, ptr %v0, i64 0
  %v60 = load i64, ptr %v60.p
  %v61 = inttoptr i64 %v60 to ptr
  %v62 = add i64 0, 1
  %v63 = mul i64 %v45, %v62
  %v64 = getelementptr i64, ptr %v61, i64 %v63
  %st17 = getelementptr i64, ptr %v64, i64 0
  store i64 %v56, ptr %st17
  %v65 = add i64 %v2, %v21
  %v66 = add i64 %v2, %v21
  %v67.p = getelementptr i64, ptr %v0, i64 1
  %v67 = load i64, ptr %v67.p
  %v68.c = icmp uge i64 %v66, %v67
  %v68 = zext i1 %v68.c to i64
  %c.b14 = icmp ne i64 %v68, 0
  br i1 %c.b14, label %b14.t19, label %b14.e20
b14.t19:
  br label %b15
b14.e20:
  br label %b16
b15:
  %v69 = add i64 0, 19
  call void @"rt.panic"(i64 %v69)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v70.p = getelementptr i64, ptr %v0, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = inttoptr i64 %v70 to ptr
  %v72 = add i64 0, 1
  %v73 = mul i64 %v66, %v72
  %v74 = getelementptr i64, ptr %v71, i64 %v73
  %v75.p = getelementptr i64, ptr %v74, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = xor i64 %v75, %v44
  %v77.p = getelementptr i64, ptr %v0, i64 1
  %v77 = load i64, ptr %v77.p
  %v78.c = icmp uge i64 %v65, %v77
  %v78 = zext i1 %v78.c to i64
  %c.b16 = icmp ne i64 %v78, 0
  br i1 %c.b16, label %b16.t21, label %b16.e22
b16.t21:
  br label %b17
b16.e22:
  br label %b18
b17:
  %v79 = add i64 0, 20
  call void @"rt.panic"(i64 %v79)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v80.p = getelementptr i64, ptr %v0, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = inttoptr i64 %v80 to ptr
  %v82 = add i64 0, 1
  %v83 = mul i64 %v65, %v82
  %v84 = getelementptr i64, ptr %v81, i64 %v83
  %st22 = getelementptr i64, ptr %v84, i64 0
  store i64 %v76, ptr %st22
  br label %b6
}

define internal void @"std/crypto/x25519.carry"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
b0:
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v94, i64 0
  %v7 = load i64, ptr %v7.p
  %v8 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v8, i64 2572
  %v9 = load i64, ptr %v9.p
  %v10 = add i64 0, 0
  %v11.c = icmp eq i64 %v9, %v10
  %v11 = zext i1 %v11.c to i64
  %v12 = mul i64 %v11, %v7
  %v13 = add i64 %v9, %v12
  %v14 = add i64 0, 51
  %v15.n = and i64 %v14, 63
  %v15 = ashr i64 %v2, %v15.n
  %v16 = add i64 %v3, %v15
  %v17 = add i64 0, 51
  %v18.n = and i64 %v17, 63
  %v18 = ashr i64 %v16, %v18.n
  %v19 = add i64 %v4, %v18
  %v20 = add i64 0, 51
  %v21.n = and i64 %v20, 63
  %v21 = ashr i64 %v19, %v21.n
  %v22 = add i64 %v5, %v21
  %v23 = add i64 0, 51
  %v24.n = and i64 %v23, 63
  %v24 = ashr i64 %v22, %v24.n
  %v25 = add i64 %v6, %v24
  %v26 = add i64 0, 51
  %v27.n = and i64 %v26, 63
  %v27 = ashr i64 %v25, %v27.n
  %v28 = add i64 0, 2251799813685247
  %v29 = and i64 %v2, %v28
  %v30 = add i64 0, 19
  %v31 = mul i64 %v30, %v27
  %v32 = add i64 %v29, %v31
  %v33 = add i64 0, 2251799813685247
  %v34 = and i64 %v32, %v33
  %v35.p = getelementptr i64, ptr %v0, i64 1
  %v35 = load i64, ptr %v35.p
  %v36.c = icmp uge i64 %v1, %v35
  %v36 = zext i1 %v36.c to i64
  %c.b0 = icmp ne i64 %v36, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v37 = add i64 0, 21
  call void @"rt.panic"(i64 %v37)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v38.p = getelementptr i64, ptr %v0, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = inttoptr i64 %v38 to ptr
  %v40 = add i64 0, 1
  %v41 = mul i64 %v1, %v40
  %v42 = getelementptr i64, ptr %v39, i64 %v41
  %st2 = getelementptr i64, ptr %v42, i64 0
  store i64 %v34, ptr %st2
  %v43 = add i64 0, 1
  %v44 = add i64 %v1, %v43
  %v45 = add i64 0, 2251799813685247
  %v46 = and i64 %v16, %v45
  %v47 = add i64 0, 51
  %v48.n = and i64 %v47, 63
  %v48 = ashr i64 %v32, %v48.n
  %v49 = add i64 %v46, %v48
  %v50.p = getelementptr i64, ptr %v0, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.c = icmp uge i64 %v44, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b2 = icmp ne i64 %v51, 0
  br i1 %c.b2, label %b2.t4, label %b2.e5
b2.t4:
  br label %b3
b2.e5:
  br label %b4
b3:
  %v52 = add i64 0, 22
  call void @"rt.panic"(i64 %v52)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v53.p = getelementptr i64, ptr %v0, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = inttoptr i64 %v53 to ptr
  %v55 = add i64 0, 1
  %v56 = mul i64 %v44, %v55
  %v57 = getelementptr i64, ptr %v54, i64 %v56
  %st5 = getelementptr i64, ptr %v57, i64 0
  store i64 %v49, ptr %st5
  %v58 = add i64 0, 2
  %v59 = add i64 %v1, %v58
  %v60 = add i64 0, 2251799813685247
  %v61 = and i64 %v19, %v60
  %v62.p = getelementptr i64, ptr %v0, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.c = icmp uge i64 %v59, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b4 = icmp ne i64 %v63, 0
  br i1 %c.b4, label %b4.t7, label %b4.e8
b4.t7:
  br label %b5
b4.e8:
  br label %b6
b5:
  %v64 = add i64 0, 23
  call void @"rt.panic"(i64 %v64)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v65.p = getelementptr i64, ptr %v0, i64 0
  %v65 = load i64, ptr %v65.p
  %v66 = inttoptr i64 %v65 to ptr
  %v67 = add i64 0, 1
  %v68 = mul i64 %v59, %v67
  %v69 = getelementptr i64, ptr %v66, i64 %v68
  %st8 = getelementptr i64, ptr %v69, i64 0
  store i64 %v61, ptr %st8
  %v70 = add i64 0, 3
  %v71 = add i64 %v1, %v70
  %v72 = add i64 0, 2251799813685247
  %v73 = and i64 %v22, %v72
  %v74.p = getelementptr i64, ptr %v0, i64 1
  %v74 = load i64, ptr %v74.p
  %v75.c = icmp uge i64 %v71, %v74
  %v75 = zext i1 %v75.c to i64
  %c.b6 = icmp ne i64 %v75, 0
  br i1 %c.b6, label %b6.t10, label %b6.e11
b6.t10:
  br label %b7
b6.e11:
  br label %b8
b7:
  %v76 = add i64 0, 24
  call void @"rt.panic"(i64 %v76)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v77.p = getelementptr i64, ptr %v0, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = inttoptr i64 %v77 to ptr
  %v79 = add i64 0, 1
  %v80 = mul i64 %v71, %v79
  %v81 = getelementptr i64, ptr %v78, i64 %v80
  %st11 = getelementptr i64, ptr %v81, i64 0
  store i64 %v73, ptr %st11
  %v82 = add i64 0, 4
  %v83 = add i64 %v1, %v82
  %v84 = add i64 0, 2251799813685247
  %v85 = and i64 %v25, %v84
  %v86.p = getelementptr i64, ptr %v0, i64 1
  %v86 = load i64, ptr %v86.p
  %v87.c = icmp uge i64 %v83, %v86
  %v87 = zext i1 %v87.c to i64
  %c.b8 = icmp ne i64 %v87, 0
  br i1 %c.b8, label %b8.t13, label %b8.e14
b8.t13:
  br label %b9
b8.e14:
  br label %b10
b9:
  %v88 = add i64 0, 25
  call void @"rt.panic"(i64 %v88)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v89.p = getelementptr i64, ptr %v0, i64 0
  %v89 = load i64, ptr %v89.p
  %v90 = inttoptr i64 %v89 to ptr
  %v91 = add i64 0, 1
  %v92 = mul i64 %v83, %v91
  %v93 = getelementptr i64, ptr %v90, i64 %v92
  %st14 = getelementptr i64, ptr %v93, i64 0
  store i64 %v85, ptr %st14
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v95, i64 0
  store i64 %v7, ptr %st15
  ret void
}

define internal void @"std/crypto/x25519.fadd"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v123, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v5, i64 2572
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp eq i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %v9 = mul i64 %v8, %v4
  %v10 = add i64 %v6, %v9
  %v11.p = getelementptr i64, ptr %v0, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp uge i64 %v2, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v13 = add i64 0, 26
  call void @"rt.panic"(i64 %v13)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v14.p = getelementptr i64, ptr %v0, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = inttoptr i64 %v14 to ptr
  %v16 = add i64 0, 1
  %v17 = mul i64 %v2, %v16
  %v18 = getelementptr i64, ptr %v15, i64 %v17
  %v19.p = getelementptr i64, ptr %v18, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v0, i64 1
  %v20 = load i64, ptr %v20.p
  %v21.c = icmp uge i64 %v3, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b2 = icmp ne i64 %v21, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v22 = add i64 0, 27
  call void @"rt.panic"(i64 %v22)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v23.p = getelementptr i64, ptr %v0, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = inttoptr i64 %v23 to ptr
  %v25 = add i64 0, 1
  %v26 = mul i64 %v3, %v25
  %v27 = getelementptr i64, ptr %v24, i64 %v26
  %v28.p = getelementptr i64, ptr %v27, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 %v19, %v28
  %v30 = add i64 0, 1
  %v31 = add i64 %v2, %v30
  %v32.p = getelementptr i64, ptr %v0, i64 1
  %v32 = load i64, ptr %v32.p
  %v33.c = icmp uge i64 %v31, %v32
  %v33 = zext i1 %v33.c to i64
  %c.b4 = icmp ne i64 %v33, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v34 = add i64 0, 28
  call void @"rt.panic"(i64 %v34)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v35.p = getelementptr i64, ptr %v0, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = inttoptr i64 %v35 to ptr
  %v37 = add i64 0, 1
  %v38 = mul i64 %v31, %v37
  %v39 = getelementptr i64, ptr %v36, i64 %v38
  %v40.p = getelementptr i64, ptr %v39, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = add i64 0, 1
  %v42 = add i64 %v3, %v41
  %v43.p = getelementptr i64, ptr %v0, i64 1
  %v43 = load i64, ptr %v43.p
  %v44.c = icmp uge i64 %v42, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b6 = icmp ne i64 %v44, 0
  br i1 %c.b6, label %b6.t7, label %b6.e8
b6.t7:
  br label %b7
b6.e8:
  br label %b8
b7:
  %v45 = add i64 0, 29
  call void @"rt.panic"(i64 %v45)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v46.p = getelementptr i64, ptr %v0, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = inttoptr i64 %v46 to ptr
  %v48 = add i64 0, 1
  %v49 = mul i64 %v42, %v48
  %v50 = getelementptr i64, ptr %v47, i64 %v49
  %v51.p = getelementptr i64, ptr %v50, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = add i64 %v40, %v51
  %v53 = add i64 0, 2
  %v54 = add i64 %v2, %v53
  %v55.p = getelementptr i64, ptr %v0, i64 1
  %v55 = load i64, ptr %v55.p
  %v56.c = icmp uge i64 %v54, %v55
  %v56 = zext i1 %v56.c to i64
  %c.b8 = icmp ne i64 %v56, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b9
b8.e10:
  br label %b10
b9:
  %v57 = add i64 0, 30
  call void @"rt.panic"(i64 %v57)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v58.p = getelementptr i64, ptr %v0, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = inttoptr i64 %v58 to ptr
  %v60 = add i64 0, 1
  %v61 = mul i64 %v54, %v60
  %v62 = getelementptr i64, ptr %v59, i64 %v61
  %v63.p = getelementptr i64, ptr %v62, i64 0
  %v63 = load i64, ptr %v63.p
  %v64 = add i64 0, 2
  %v65 = add i64 %v3, %v64
  %v66.p = getelementptr i64, ptr %v0, i64 1
  %v66 = load i64, ptr %v66.p
  %v67.c = icmp uge i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b10 = icmp ne i64 %v67, 0
  br i1 %c.b10, label %b10.t11, label %b10.e12
b10.t11:
  br label %b11
b10.e12:
  br label %b12
b11:
  %v68 = add i64 0, 31
  call void @"rt.panic"(i64 %v68)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v69.p = getelementptr i64, ptr %v0, i64 0
  %v69 = load i64, ptr %v69.p
  %v70 = inttoptr i64 %v69 to ptr
  %v71 = add i64 0, 1
  %v72 = mul i64 %v65, %v71
  %v73 = getelementptr i64, ptr %v70, i64 %v72
  %v74.p = getelementptr i64, ptr %v73, i64 0
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 %v63, %v74
  %v76 = add i64 0, 3
  %v77 = add i64 %v2, %v76
  %v78.p = getelementptr i64, ptr %v0, i64 1
  %v78 = load i64, ptr %v78.p
  %v79.c = icmp uge i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b12 = icmp ne i64 %v79, 0
  br i1 %c.b12, label %b12.t13, label %b12.e14
b12.t13:
  br label %b13
b12.e14:
  br label %b14
b13:
  %v80 = add i64 0, 32
  call void @"rt.panic"(i64 %v80)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v81.p = getelementptr i64, ptr %v0, i64 0
  %v81 = load i64, ptr %v81.p
  %v82 = inttoptr i64 %v81 to ptr
  %v83 = add i64 0, 1
  %v84 = mul i64 %v77, %v83
  %v85 = getelementptr i64, ptr %v82, i64 %v84
  %v86.p = getelementptr i64, ptr %v85, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 0, 3
  %v88 = add i64 %v3, %v87
  %v89.p = getelementptr i64, ptr %v0, i64 1
  %v89 = load i64, ptr %v89.p
  %v90.c = icmp uge i64 %v88, %v89
  %v90 = zext i1 %v90.c to i64
  %c.b14 = icmp ne i64 %v90, 0
  br i1 %c.b14, label %b14.t15, label %b14.e16
b14.t15:
  br label %b15
b14.e16:
  br label %b16
b15:
  %v91 = add i64 0, 33
  call void @"rt.panic"(i64 %v91)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v92.p = getelementptr i64, ptr %v0, i64 0
  %v92 = load i64, ptr %v92.p
  %v93 = inttoptr i64 %v92 to ptr
  %v94 = add i64 0, 1
  %v95 = mul i64 %v88, %v94
  %v96 = getelementptr i64, ptr %v93, i64 %v95
  %v97.p = getelementptr i64, ptr %v96, i64 0
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 %v86, %v97
  %v99 = add i64 0, 4
  %v100 = add i64 %v2, %v99
  %v101.p = getelementptr i64, ptr %v0, i64 1
  %v101 = load i64, ptr %v101.p
  %v102.c = icmp uge i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b16 = icmp ne i64 %v102, 0
  br i1 %c.b16, label %b16.t17, label %b16.e18
b16.t17:
  br label %b17
b16.e18:
  br label %b18
b17:
  %v103 = add i64 0, 34
  call void @"rt.panic"(i64 %v103)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v104.p = getelementptr i64, ptr %v0, i64 0
  %v104 = load i64, ptr %v104.p
  %v105 = inttoptr i64 %v104 to ptr
  %v106 = add i64 0, 1
  %v107 = mul i64 %v100, %v106
  %v108 = getelementptr i64, ptr %v105, i64 %v107
  %v109.p = getelementptr i64, ptr %v108, i64 0
  %v109 = load i64, ptr %v109.p
  %v110 = add i64 0, 4
  %v111 = add i64 %v3, %v110
  %v112.p = getelementptr i64, ptr %v0, i64 1
  %v112 = load i64, ptr %v112.p
  %v113.c = icmp uge i64 %v111, %v112
  %v113 = zext i1 %v113.c to i64
  %c.b18 = icmp ne i64 %v113, 0
  br i1 %c.b18, label %b18.t19, label %b18.e20
b18.t19:
  br label %b19
b18.e20:
  br label %b20
b19:
  %v114 = add i64 0, 35
  call void @"rt.panic"(i64 %v114)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v115.p = getelementptr i64, ptr %v0, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = inttoptr i64 %v115 to ptr
  %v117 = add i64 0, 1
  %v118 = mul i64 %v111, %v117
  %v119 = getelementptr i64, ptr %v116, i64 %v118
  %v120.p = getelementptr i64, ptr %v119, i64 0
  %v120 = load i64, ptr %v120.p
  %v121 = add i64 %v109, %v120
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v122, i64 2572
  store i64 %v10, ptr %st20
  call void @"std/crypto/x25519.carry"(ptr %v0, i64 %v1, i64 %v29, i64 %v52, i64 %v75, i64 %v98, i64 %v121)
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v124, i64 0
  store i64 %v4, ptr %st21
  ret void
}

define internal void @"std/crypto/x25519.fsub"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v133 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v133, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v5, i64 2572
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp eq i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %v9 = mul i64 %v8, %v4
  %v10 = add i64 %v6, %v9
  %v11.p = getelementptr i64, ptr %v0, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp uge i64 %v2, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v13 = add i64 0, 36
  call void @"rt.panic"(i64 %v13)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v14.p = getelementptr i64, ptr %v0, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = inttoptr i64 %v14 to ptr
  %v16 = add i64 0, 1
  %v17 = mul i64 %v2, %v16
  %v18 = getelementptr i64, ptr %v15, i64 %v17
  %v19.p = getelementptr i64, ptr %v18, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 4503599627370458
  %v21 = add i64 %v19, %v20
  %v22.p = getelementptr i64, ptr %v0, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.c = icmp uge i64 %v3, %v22
  %v23 = zext i1 %v23.c to i64
  %c.b2 = icmp ne i64 %v23, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v24 = add i64 0, 37
  call void @"rt.panic"(i64 %v24)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v25.p = getelementptr i64, ptr %v0, i64 0
  %v25 = load i64, ptr %v25.p
  %v26 = inttoptr i64 %v25 to ptr
  %v27 = add i64 0, 1
  %v28 = mul i64 %v3, %v27
  %v29 = getelementptr i64, ptr %v26, i64 %v28
  %v30.p = getelementptr i64, ptr %v29, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = sub i64 %v21, %v30
  %v32 = add i64 0, 1
  %v33 = add i64 %v2, %v32
  %v34.p = getelementptr i64, ptr %v0, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp uge i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b4 = icmp ne i64 %v35, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v36 = add i64 0, 38
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v37.p = getelementptr i64, ptr %v0, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = inttoptr i64 %v37 to ptr
  %v39 = add i64 0, 1
  %v40 = mul i64 %v33, %v39
  %v41 = getelementptr i64, ptr %v38, i64 %v40
  %v42.p = getelementptr i64, ptr %v41, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 0, 4503599627370494
  %v44 = add i64 %v42, %v43
  %v45 = add i64 0, 1
  %v46 = add i64 %v3, %v45
  %v47.p = getelementptr i64, ptr %v0, i64 1
  %v47 = load i64, ptr %v47.p
  %v48.c = icmp uge i64 %v46, %v47
  %v48 = zext i1 %v48.c to i64
  %c.b6 = icmp ne i64 %v48, 0
  br i1 %c.b6, label %b6.t7, label %b6.e8
b6.t7:
  br label %b7
b6.e8:
  br label %b8
b7:
  %v49 = add i64 0, 39
  call void @"rt.panic"(i64 %v49)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v50.p = getelementptr i64, ptr %v0, i64 0
  %v50 = load i64, ptr %v50.p
  %v51 = inttoptr i64 %v50 to ptr
  %v52 = add i64 0, 1
  %v53 = mul i64 %v46, %v52
  %v54 = getelementptr i64, ptr %v51, i64 %v53
  %v55.p = getelementptr i64, ptr %v54, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = sub i64 %v44, %v55
  %v57 = add i64 0, 2
  %v58 = add i64 %v2, %v57
  %v59.p = getelementptr i64, ptr %v0, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.c = icmp uge i64 %v58, %v59
  %v60 = zext i1 %v60.c to i64
  %c.b8 = icmp ne i64 %v60, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b9
b8.e10:
  br label %b10
b9:
  %v61 = add i64 0, 40
  call void @"rt.panic"(i64 %v61)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v62.p = getelementptr i64, ptr %v0, i64 0
  %v62 = load i64, ptr %v62.p
  %v63 = inttoptr i64 %v62 to ptr
  %v64 = add i64 0, 1
  %v65 = mul i64 %v58, %v64
  %v66 = getelementptr i64, ptr %v63, i64 %v65
  %v67.p = getelementptr i64, ptr %v66, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 0, 4503599627370494
  %v69 = add i64 %v67, %v68
  %v70 = add i64 0, 2
  %v71 = add i64 %v3, %v70
  %v72.p = getelementptr i64, ptr %v0, i64 1
  %v72 = load i64, ptr %v72.p
  %v73.c = icmp uge i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b10 = icmp ne i64 %v73, 0
  br i1 %c.b10, label %b10.t11, label %b10.e12
b10.t11:
  br label %b11
b10.e12:
  br label %b12
b11:
  %v74 = add i64 0, 41
  call void @"rt.panic"(i64 %v74)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v75.p = getelementptr i64, ptr %v0, i64 0
  %v75 = load i64, ptr %v75.p
  %v76 = inttoptr i64 %v75 to ptr
  %v77 = add i64 0, 1
  %v78 = mul i64 %v71, %v77
  %v79 = getelementptr i64, ptr %v76, i64 %v78
  %v80.p = getelementptr i64, ptr %v79, i64 0
  %v80 = load i64, ptr %v80.p
  %v81 = sub i64 %v69, %v80
  %v82 = add i64 0, 3
  %v83 = add i64 %v2, %v82
  %v84.p = getelementptr i64, ptr %v0, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.c = icmp uge i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b12 = icmp ne i64 %v85, 0
  br i1 %c.b12, label %b12.t13, label %b12.e14
b12.t13:
  br label %b13
b12.e14:
  br label %b14
b13:
  %v86 = add i64 0, 42
  call void @"rt.panic"(i64 %v86)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v87.p = getelementptr i64, ptr %v0, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = inttoptr i64 %v87 to ptr
  %v89 = add i64 0, 1
  %v90 = mul i64 %v83, %v89
  %v91 = getelementptr i64, ptr %v88, i64 %v90
  %v92.p = getelementptr i64, ptr %v91, i64 0
  %v92 = load i64, ptr %v92.p
  %v93 = add i64 0, 4503599627370494
  %v94 = add i64 %v92, %v93
  %v95 = add i64 0, 3
  %v96 = add i64 %v3, %v95
  %v97.p = getelementptr i64, ptr %v0, i64 1
  %v97 = load i64, ptr %v97.p
  %v98.c = icmp uge i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b14 = icmp ne i64 %v98, 0
  br i1 %c.b14, label %b14.t15, label %b14.e16
b14.t15:
  br label %b15
b14.e16:
  br label %b16
b15:
  %v99 = add i64 0, 43
  call void @"rt.panic"(i64 %v99)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v100.p = getelementptr i64, ptr %v0, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = inttoptr i64 %v100 to ptr
  %v102 = add i64 0, 1
  %v103 = mul i64 %v96, %v102
  %v104 = getelementptr i64, ptr %v101, i64 %v103
  %v105.p = getelementptr i64, ptr %v104, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = sub i64 %v94, %v105
  %v107 = add i64 0, 4
  %v108 = add i64 %v2, %v107
  %v109.p = getelementptr i64, ptr %v0, i64 1
  %v109 = load i64, ptr %v109.p
  %v110.c = icmp uge i64 %v108, %v109
  %v110 = zext i1 %v110.c to i64
  %c.b16 = icmp ne i64 %v110, 0
  br i1 %c.b16, label %b16.t17, label %b16.e18
b16.t17:
  br label %b17
b16.e18:
  br label %b18
b17:
  %v111 = add i64 0, 44
  call void @"rt.panic"(i64 %v111)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v112.p = getelementptr i64, ptr %v0, i64 0
  %v112 = load i64, ptr %v112.p
  %v113 = inttoptr i64 %v112 to ptr
  %v114 = add i64 0, 1
  %v115 = mul i64 %v108, %v114
  %v116 = getelementptr i64, ptr %v113, i64 %v115
  %v117.p = getelementptr i64, ptr %v116, i64 0
  %v117 = load i64, ptr %v117.p
  %v118 = add i64 0, 4503599627370494
  %v119 = add i64 %v117, %v118
  %v120 = add i64 0, 4
  %v121 = add i64 %v3, %v120
  %v122.p = getelementptr i64, ptr %v0, i64 1
  %v122 = load i64, ptr %v122.p
  %v123.c = icmp uge i64 %v121, %v122
  %v123 = zext i1 %v123.c to i64
  %c.b18 = icmp ne i64 %v123, 0
  br i1 %c.b18, label %b18.t19, label %b18.e20
b18.t19:
  br label %b19
b18.e20:
  br label %b20
b19:
  %v124 = add i64 0, 45
  call void @"rt.panic"(i64 %v124)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v125.p = getelementptr i64, ptr %v0, i64 0
  %v125 = load i64, ptr %v125.p
  %v126 = inttoptr i64 %v125 to ptr
  %v127 = add i64 0, 1
  %v128 = mul i64 %v121, %v127
  %v129 = getelementptr i64, ptr %v126, i64 %v128
  %v130.p = getelementptr i64, ptr %v129, i64 0
  %v130 = load i64, ptr %v130.p
  %v131 = sub i64 %v119, %v130
  %v132 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v132, i64 2572
  store i64 %v10, ptr %st20
  call void @"std/crypto/x25519.carry"(ptr %v0, i64 %v1, i64 %v31, i64 %v56, i64 %v81, i64 %v106, i64 %v131)
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v134, i64 0
  store i64 %v4, ptr %st21
  ret void
}

define internal void @"std/crypto/x25519.fmul"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
b0:
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v26, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2572
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %v9.c = icmp eq i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %v10 = mul i64 %v9, %v5
  %v11 = add i64 %v7, %v10
  %v12 = add i64 0, 0
  %v13 = add i64 0, 1
  %v14.c = icmp eq i64 %v12, %v13
  %v14 = zext i1 %v14.c to i64
  %c.b0 = icmp ne i64 %v14, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v15 = add i64 0, 8
  %v16 = mul i64 %v15, %v2
  %v17 = add i64 %v1, %v16
  %v18 = add i64 0, 8
  %v19 = mul i64 %v18, %v3
  %v20 = add i64 %v1, %v19
  %v21 = add i64 0, 8
  %v22 = mul i64 %v21, %v4
  %v23 = add i64 %v1, %v22
  %v24 = add i64 0, 0
  %v27 = getelementptr i64, ptr @"rt.meta", i64 0
  %st2 = getelementptr i64, ptr %v27, i64 0
  store i64 %v5, ptr %st2
  ret void
b2:
  br label %b3
b3:
  %v25 = getelementptr i64, ptr @"rt.meta", i64 0
  %st3 = getelementptr i64, ptr %v25, i64 2572
  store i64 %v11, ptr %st3
  call void @"std/crypto/x25519.fmulS"(ptr %v0, i64 %v2, i64 %v3, i64 %v4)
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v28, i64 0
  store i64 %v5, ptr %st4
  ret void
}

define internal void @"std/crypto/x25519.fmulS"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %v350 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v350, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v5, i64 2572
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp eq i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %v9 = mul i64 %v8, %v4
  %v10 = add i64 %v6, %v9
  %v11.p = getelementptr i64, ptr %v0, i64 1
  %v11 = load i64, ptr %v11.p
  %v12.c = icmp uge i64 %v2, %v11
  %v12 = zext i1 %v12.c to i64
  %c.b0 = icmp ne i64 %v12, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v13 = add i64 0, 46
  call void @"rt.panic"(i64 %v13)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v14.p = getelementptr i64, ptr %v0, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = inttoptr i64 %v14 to ptr
  %v16 = add i64 0, 1
  %v17 = mul i64 %v2, %v16
  %v18 = getelementptr i64, ptr %v15, i64 %v17
  %v19.p = getelementptr i64, ptr %v18, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 12
  %v21.n = and i64 %v20, 63
  %v21 = shl i64 %v19, %v21.n
  %v22 = add i64 0, 1
  %v23 = add i64 %v2, %v22
  %v24.p = getelementptr i64, ptr %v0, i64 1
  %v24 = load i64, ptr %v24.p
  %v25.c = icmp uge i64 %v23, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b2 = icmp ne i64 %v25, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v26 = add i64 0, 47
  call void @"rt.panic"(i64 %v26)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v27.p = getelementptr i64, ptr %v0, i64 0
  %v27 = load i64, ptr %v27.p
  %v28 = inttoptr i64 %v27 to ptr
  %v29 = add i64 0, 1
  %v30 = mul i64 %v23, %v29
  %v31 = getelementptr i64, ptr %v28, i64 %v30
  %v32.p = getelementptr i64, ptr %v31, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 12
  %v34.n = and i64 %v33, 63
  %v34 = shl i64 %v32, %v34.n
  %v35 = add i64 0, 2
  %v36 = add i64 %v2, %v35
  %v37.p = getelementptr i64, ptr %v0, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b4 = icmp ne i64 %v38, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v39 = add i64 0, 48
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v40.p = getelementptr i64, ptr %v0, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v36, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %v45.p = getelementptr i64, ptr %v44, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = add i64 0, 12
  %v47.n = and i64 %v46, 63
  %v47 = shl i64 %v45, %v47.n
  %v48 = add i64 0, 3
  %v49 = add i64 %v2, %v48
  %v50.p = getelementptr i64, ptr %v0, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.c = icmp uge i64 %v49, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b6 = icmp ne i64 %v51, 0
  br i1 %c.b6, label %b6.t7, label %b6.e8
b6.t7:
  br label %b7
b6.e8:
  br label %b8
b7:
  %v52 = add i64 0, 49
  call void @"rt.panic"(i64 %v52)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v53.p = getelementptr i64, ptr %v0, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = inttoptr i64 %v53 to ptr
  %v55 = add i64 0, 1
  %v56 = mul i64 %v49, %v55
  %v57 = getelementptr i64, ptr %v54, i64 %v56
  %v58.p = getelementptr i64, ptr %v57, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 12
  %v60.n = and i64 %v59, 63
  %v60 = shl i64 %v58, %v60.n
  %v61 = add i64 0, 4
  %v62 = add i64 %v2, %v61
  %v63.p = getelementptr i64, ptr %v0, i64 1
  %v63 = load i64, ptr %v63.p
  %v64.c = icmp uge i64 %v62, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b8 = icmp ne i64 %v64, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b9
b8.e10:
  br label %b10
b9:
  %v65 = add i64 0, 50
  call void @"rt.panic"(i64 %v65)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v66.p = getelementptr i64, ptr %v0, i64 0
  %v66 = load i64, ptr %v66.p
  %v67 = inttoptr i64 %v66 to ptr
  %v68 = add i64 0, 1
  %v69 = mul i64 %v62, %v68
  %v70 = getelementptr i64, ptr %v67, i64 %v69
  %v71.p = getelementptr i64, ptr %v70, i64 0
  %v71 = load i64, ptr %v71.p
  %v72 = add i64 0, 12
  %v73.n = and i64 %v72, 63
  %v73 = shl i64 %v71, %v73.n
  %v74.p = getelementptr i64, ptr %v0, i64 1
  %v74 = load i64, ptr %v74.p
  %v75.c = icmp uge i64 %v3, %v74
  %v75 = zext i1 %v75.c to i64
  %c.b10 = icmp ne i64 %v75, 0
  br i1 %c.b10, label %b10.t11, label %b10.e12
b10.t11:
  br label %b11
b10.e12:
  br label %b12
b11:
  %v76 = add i64 0, 51
  call void @"rt.panic"(i64 %v76)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v77.p = getelementptr i64, ptr %v0, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = inttoptr i64 %v77 to ptr
  %v79 = add i64 0, 1
  %v80 = mul i64 %v3, %v79
  %v81 = getelementptr i64, ptr %v78, i64 %v80
  %v82.p = getelementptr i64, ptr %v81, i64 0
  %v82 = load i64, ptr %v82.p
  %v83 = add i64 0, 1
  %v84 = add i64 %v3, %v83
  %v85.p = getelementptr i64, ptr %v0, i64 1
  %v85 = load i64, ptr %v85.p
  %v86.c = icmp uge i64 %v84, %v85
  %v86 = zext i1 %v86.c to i64
  %c.b12 = icmp ne i64 %v86, 0
  br i1 %c.b12, label %b12.t13, label %b12.e14
b12.t13:
  br label %b13
b12.e14:
  br label %b14
b13:
  %v87 = add i64 0, 52
  call void @"rt.panic"(i64 %v87)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v88.p = getelementptr i64, ptr %v0, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = inttoptr i64 %v88 to ptr
  %v90 = add i64 0, 1
  %v91 = mul i64 %v84, %v90
  %v92 = getelementptr i64, ptr %v89, i64 %v91
  %v93.p = getelementptr i64, ptr %v92, i64 0
  %v93 = load i64, ptr %v93.p
  %v94 = add i64 0, 2
  %v95 = add i64 %v3, %v94
  %v96.p = getelementptr i64, ptr %v0, i64 1
  %v96 = load i64, ptr %v96.p
  %v97.c = icmp uge i64 %v95, %v96
  %v97 = zext i1 %v97.c to i64
  %c.b14 = icmp ne i64 %v97, 0
  br i1 %c.b14, label %b14.t15, label %b14.e16
b14.t15:
  br label %b15
b14.e16:
  br label %b16
b15:
  %v98 = add i64 0, 53
  call void @"rt.panic"(i64 %v98)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v99.p = getelementptr i64, ptr %v0, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = inttoptr i64 %v99 to ptr
  %v101 = add i64 0, 1
  %v102 = mul i64 %v95, %v101
  %v103 = getelementptr i64, ptr %v100, i64 %v102
  %v104.p = getelementptr i64, ptr %v103, i64 0
  %v104 = load i64, ptr %v104.p
  %v105 = add i64 0, 3
  %v106 = add i64 %v3, %v105
  %v107.p = getelementptr i64, ptr %v0, i64 1
  %v107 = load i64, ptr %v107.p
  %v108.c = icmp uge i64 %v106, %v107
  %v108 = zext i1 %v108.c to i64
  %c.b16 = icmp ne i64 %v108, 0
  br i1 %c.b16, label %b16.t17, label %b16.e18
b16.t17:
  br label %b17
b16.e18:
  br label %b18
b17:
  %v109 = add i64 0, 54
  call void @"rt.panic"(i64 %v109)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v110.p = getelementptr i64, ptr %v0, i64 0
  %v110 = load i64, ptr %v110.p
  %v111 = inttoptr i64 %v110 to ptr
  %v112 = add i64 0, 1
  %v113 = mul i64 %v106, %v112
  %v114 = getelementptr i64, ptr %v111, i64 %v113
  %v115.p = getelementptr i64, ptr %v114, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 4
  %v117 = add i64 %v3, %v116
  %v118.p = getelementptr i64, ptr %v0, i64 1
  %v118 = load i64, ptr %v118.p
  %v119.c = icmp uge i64 %v117, %v118
  %v119 = zext i1 %v119.c to i64
  %c.b18 = icmp ne i64 %v119, 0
  br i1 %c.b18, label %b18.t19, label %b18.e20
b18.t19:
  br label %b19
b18.e20:
  br label %b20
b19:
  %v120 = add i64 0, 55
  call void @"rt.panic"(i64 %v120)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v121.p = getelementptr i64, ptr %v0, i64 0
  %v121 = load i64, ptr %v121.p
  %v122 = inttoptr i64 %v121 to ptr
  %v123 = add i64 0, 1
  %v124 = mul i64 %v117, %v123
  %v125 = getelementptr i64, ptr %v122, i64 %v124
  %v126.p = getelementptr i64, ptr %v125, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 0, 19
  %v128 = mul i64 %v127, %v93
  %v129 = add i64 0, 19
  %v130 = mul i64 %v129, %v104
  %v131 = add i64 0, 19
  %v132 = mul i64 %v131, %v115
  %v133 = add i64 0, 19
  %v134 = mul i64 %v133, %v126
  %v135 = mul i64 %v21, %v82
  %v136 = add i64 0, 12
  %v137.n = and i64 %v136, 63
  %v137 = ashr i64 %v135, %v137.n
  %v138 = add i64 0, 4503599627370495
  %v139 = and i64 %v137, %v138
  %v140 = mul i64 %v34, %v134
  %v141 = add i64 0, 12
  %v142.n = and i64 %v141, 63
  %v142 = ashr i64 %v140, %v142.n
  %v143 = add i64 0, 4503599627370495
  %v144 = and i64 %v142, %v143
  %v145 = add i64 %v139, %v144
  %v146 = mul i64 %v47, %v132
  %v147 = add i64 0, 12
  %v148.n = and i64 %v147, 63
  %v148 = ashr i64 %v146, %v148.n
  %v149 = add i64 0, 4503599627370495
  %v150 = and i64 %v148, %v149
  %v151 = add i64 %v145, %v150
  %v152 = mul i64 %v60, %v130
  %v153 = add i64 0, 12
  %v154.n = and i64 %v153, 63
  %v154 = ashr i64 %v152, %v154.n
  %v155 = add i64 0, 4503599627370495
  %v156 = and i64 %v154, %v155
  %v157 = add i64 %v151, %v156
  %v158 = mul i64 %v73, %v128
  %v159 = add i64 0, 12
  %v160.n = and i64 %v159, 63
  %v160 = ashr i64 %v158, %v160.n
  %v161 = add i64 0, 4503599627370495
  %v162 = and i64 %v160, %v161
  %v163 = add i64 %v157, %v162
  %v164.a = zext i64 %v21 to i128
  %v164.b = zext i64 %v82 to i128
  %v164.p = mul i128 %v164.a, %v164.b
  %v164.h = lshr i128 %v164.p, 64
  %v164 = trunc i128 %v164.h to i64
  %v165.a = zext i64 %v34 to i128
  %v165.b = zext i64 %v134 to i128
  %v165.p = mul i128 %v165.a, %v165.b
  %v165.h = lshr i128 %v165.p, 64
  %v165 = trunc i128 %v165.h to i64
  %v166 = add i64 %v164, %v165
  %v167.a = zext i64 %v47 to i128
  %v167.b = zext i64 %v132 to i128
  %v167.p = mul i128 %v167.a, %v167.b
  %v167.h = lshr i128 %v167.p, 64
  %v167 = trunc i128 %v167.h to i64
  %v168 = add i64 %v166, %v167
  %v169.a = zext i64 %v60 to i128
  %v169.b = zext i64 %v130 to i128
  %v169.p = mul i128 %v169.a, %v169.b
  %v169.h = lshr i128 %v169.p, 64
  %v169 = trunc i128 %v169.h to i64
  %v170 = add i64 %v168, %v169
  %v171.a = zext i64 %v73 to i128
  %v171.b = zext i64 %v128 to i128
  %v171.p = mul i128 %v171.a, %v171.b
  %v171.h = lshr i128 %v171.p, 64
  %v171 = trunc i128 %v171.h to i64
  %v172 = add i64 %v170, %v171
  %v173 = mul i64 %v21, %v93
  %v174 = add i64 0, 12
  %v175.n = and i64 %v174, 63
  %v175 = ashr i64 %v173, %v175.n
  %v176 = add i64 0, 4503599627370495
  %v177 = and i64 %v175, %v176
  %v178 = mul i64 %v34, %v82
  %v179 = add i64 0, 12
  %v180.n = and i64 %v179, 63
  %v180 = ashr i64 %v178, %v180.n
  %v181 = add i64 0, 4503599627370495
  %v182 = and i64 %v180, %v181
  %v183 = add i64 %v177, %v182
  %v184 = mul i64 %v47, %v134
  %v185 = add i64 0, 12
  %v186.n = and i64 %v185, 63
  %v186 = ashr i64 %v184, %v186.n
  %v187 = add i64 0, 4503599627370495
  %v188 = and i64 %v186, %v187
  %v189 = add i64 %v183, %v188
  %v190 = mul i64 %v60, %v132
  %v191 = add i64 0, 12
  %v192.n = and i64 %v191, 63
  %v192 = ashr i64 %v190, %v192.n
  %v193 = add i64 0, 4503599627370495
  %v194 = and i64 %v192, %v193
  %v195 = add i64 %v189, %v194
  %v196 = mul i64 %v73, %v130
  %v197 = add i64 0, 12
  %v198.n = and i64 %v197, 63
  %v198 = ashr i64 %v196, %v198.n
  %v199 = add i64 0, 4503599627370495
  %v200 = and i64 %v198, %v199
  %v201 = add i64 %v195, %v200
  %v202.a = zext i64 %v21 to i128
  %v202.b = zext i64 %v93 to i128
  %v202.p = mul i128 %v202.a, %v202.b
  %v202.h = lshr i128 %v202.p, 64
  %v202 = trunc i128 %v202.h to i64
  %v203.a = zext i64 %v34 to i128
  %v203.b = zext i64 %v82 to i128
  %v203.p = mul i128 %v203.a, %v203.b
  %v203.h = lshr i128 %v203.p, 64
  %v203 = trunc i128 %v203.h to i64
  %v204 = add i64 %v202, %v203
  %v205.a = zext i64 %v47 to i128
  %v205.b = zext i64 %v134 to i128
  %v205.p = mul i128 %v205.a, %v205.b
  %v205.h = lshr i128 %v205.p, 64
  %v205 = trunc i128 %v205.h to i64
  %v206 = add i64 %v204, %v205
  %v207.a = zext i64 %v60 to i128
  %v207.b = zext i64 %v132 to i128
  %v207.p = mul i128 %v207.a, %v207.b
  %v207.h = lshr i128 %v207.p, 64
  %v207 = trunc i128 %v207.h to i64
  %v208 = add i64 %v206, %v207
  %v209.a = zext i64 %v73 to i128
  %v209.b = zext i64 %v130 to i128
  %v209.p = mul i128 %v209.a, %v209.b
  %v209.h = lshr i128 %v209.p, 64
  %v209 = trunc i128 %v209.h to i64
  %v210 = add i64 %v208, %v209
  %v211 = mul i64 %v21, %v104
  %v212 = add i64 0, 12
  %v213.n = and i64 %v212, 63
  %v213 = ashr i64 %v211, %v213.n
  %v214 = add i64 0, 4503599627370495
  %v215 = and i64 %v213, %v214
  %v216 = mul i64 %v34, %v93
  %v217 = add i64 0, 12
  %v218.n = and i64 %v217, 63
  %v218 = ashr i64 %v216, %v218.n
  %v219 = add i64 0, 4503599627370495
  %v220 = and i64 %v218, %v219
  %v221 = add i64 %v215, %v220
  %v222 = mul i64 %v47, %v82
  %v223 = add i64 0, 12
  %v224.n = and i64 %v223, 63
  %v224 = ashr i64 %v222, %v224.n
  %v225 = add i64 0, 4503599627370495
  %v226 = and i64 %v224, %v225
  %v227 = add i64 %v221, %v226
  %v228 = mul i64 %v60, %v134
  %v229 = add i64 0, 12
  %v230.n = and i64 %v229, 63
  %v230 = ashr i64 %v228, %v230.n
  %v231 = add i64 0, 4503599627370495
  %v232 = and i64 %v230, %v231
  %v233 = add i64 %v227, %v232
  %v234 = mul i64 %v73, %v132
  %v235 = add i64 0, 12
  %v236.n = and i64 %v235, 63
  %v236 = ashr i64 %v234, %v236.n
  %v237 = add i64 0, 4503599627370495
  %v238 = and i64 %v236, %v237
  %v239 = add i64 %v233, %v238
  %v240.a = zext i64 %v21 to i128
  %v240.b = zext i64 %v104 to i128
  %v240.p = mul i128 %v240.a, %v240.b
  %v240.h = lshr i128 %v240.p, 64
  %v240 = trunc i128 %v240.h to i64
  %v241.a = zext i64 %v34 to i128
  %v241.b = zext i64 %v93 to i128
  %v241.p = mul i128 %v241.a, %v241.b
  %v241.h = lshr i128 %v241.p, 64
  %v241 = trunc i128 %v241.h to i64
  %v242 = add i64 %v240, %v241
  %v243.a = zext i64 %v47 to i128
  %v243.b = zext i64 %v82 to i128
  %v243.p = mul i128 %v243.a, %v243.b
  %v243.h = lshr i128 %v243.p, 64
  %v243 = trunc i128 %v243.h to i64
  %v244 = add i64 %v242, %v243
  %v245.a = zext i64 %v60 to i128
  %v245.b = zext i64 %v134 to i128
  %v245.p = mul i128 %v245.a, %v245.b
  %v245.h = lshr i128 %v245.p, 64
  %v245 = trunc i128 %v245.h to i64
  %v246 = add i64 %v244, %v245
  %v247.a = zext i64 %v73 to i128
  %v247.b = zext i64 %v132 to i128
  %v247.p = mul i128 %v247.a, %v247.b
  %v247.h = lshr i128 %v247.p, 64
  %v247 = trunc i128 %v247.h to i64
  %v248 = add i64 %v246, %v247
  %v249 = mul i64 %v21, %v115
  %v250 = add i64 0, 12
  %v251.n = and i64 %v250, 63
  %v251 = ashr i64 %v249, %v251.n
  %v252 = add i64 0, 4503599627370495
  %v253 = and i64 %v251, %v252
  %v254 = mul i64 %v34, %v104
  %v255 = add i64 0, 12
  %v256.n = and i64 %v255, 63
  %v256 = ashr i64 %v254, %v256.n
  %v257 = add i64 0, 4503599627370495
  %v258 = and i64 %v256, %v257
  %v259 = add i64 %v253, %v258
  %v260 = mul i64 %v47, %v93
  %v261 = add i64 0, 12
  %v262.n = and i64 %v261, 63
  %v262 = ashr i64 %v260, %v262.n
  %v263 = add i64 0, 4503599627370495
  %v264 = and i64 %v262, %v263
  %v265 = add i64 %v259, %v264
  %v266 = mul i64 %v60, %v82
  %v267 = add i64 0, 12
  %v268.n = and i64 %v267, 63
  %v268 = ashr i64 %v266, %v268.n
  %v269 = add i64 0, 4503599627370495
  %v270 = and i64 %v268, %v269
  %v271 = add i64 %v265, %v270
  %v272 = mul i64 %v73, %v134
  %v273 = add i64 0, 12
  %v274.n = and i64 %v273, 63
  %v274 = ashr i64 %v272, %v274.n
  %v275 = add i64 0, 4503599627370495
  %v276 = and i64 %v274, %v275
  %v277 = add i64 %v271, %v276
  %v278.a = zext i64 %v21 to i128
  %v278.b = zext i64 %v115 to i128
  %v278.p = mul i128 %v278.a, %v278.b
  %v278.h = lshr i128 %v278.p, 64
  %v278 = trunc i128 %v278.h to i64
  %v279.a = zext i64 %v34 to i128
  %v279.b = zext i64 %v104 to i128
  %v279.p = mul i128 %v279.a, %v279.b
  %v279.h = lshr i128 %v279.p, 64
  %v279 = trunc i128 %v279.h to i64
  %v280 = add i64 %v278, %v279
  %v281.a = zext i64 %v47 to i128
  %v281.b = zext i64 %v93 to i128
  %v281.p = mul i128 %v281.a, %v281.b
  %v281.h = lshr i128 %v281.p, 64
  %v281 = trunc i128 %v281.h to i64
  %v282 = add i64 %v280, %v281
  %v283.a = zext i64 %v60 to i128
  %v283.b = zext i64 %v82 to i128
  %v283.p = mul i128 %v283.a, %v283.b
  %v283.h = lshr i128 %v283.p, 64
  %v283 = trunc i128 %v283.h to i64
  %v284 = add i64 %v282, %v283
  %v285.a = zext i64 %v73 to i128
  %v285.b = zext i64 %v134 to i128
  %v285.p = mul i128 %v285.a, %v285.b
  %v285.h = lshr i128 %v285.p, 64
  %v285 = trunc i128 %v285.h to i64
  %v286 = add i64 %v284, %v285
  %v287 = mul i64 %v21, %v126
  %v288 = add i64 0, 12
  %v289.n = and i64 %v288, 63
  %v289 = ashr i64 %v287, %v289.n
  %v290 = add i64 0, 4503599627370495
  %v291 = and i64 %v289, %v290
  %v292 = mul i64 %v34, %v115
  %v293 = add i64 0, 12
  %v294.n = and i64 %v293, 63
  %v294 = ashr i64 %v292, %v294.n
  %v295 = add i64 0, 4503599627370495
  %v296 = and i64 %v294, %v295
  %v297 = add i64 %v291, %v296
  %v298 = mul i64 %v47, %v104
  %v299 = add i64 0, 12
  %v300.n = and i64 %v299, 63
  %v300 = ashr i64 %v298, %v300.n
  %v301 = add i64 0, 4503599627370495
  %v302 = and i64 %v300, %v301
  %v303 = add i64 %v297, %v302
  %v304 = mul i64 %v60, %v93
  %v305 = add i64 0, 12
  %v306.n = and i64 %v305, 63
  %v306 = ashr i64 %v304, %v306.n
  %v307 = add i64 0, 4503599627370495
  %v308 = and i64 %v306, %v307
  %v309 = add i64 %v303, %v308
  %v310 = mul i64 %v73, %v82
  %v311 = add i64 0, 12
  %v312.n = and i64 %v311, 63
  %v312 = ashr i64 %v310, %v312.n
  %v313 = add i64 0, 4503599627370495
  %v314 = and i64 %v312, %v313
  %v315 = add i64 %v309, %v314
  %v316.a = zext i64 %v21 to i128
  %v316.b = zext i64 %v126 to i128
  %v316.p = mul i128 %v316.a, %v316.b
  %v316.h = lshr i128 %v316.p, 64
  %v316 = trunc i128 %v316.h to i64
  %v317.a = zext i64 %v34 to i128
  %v317.b = zext i64 %v115 to i128
  %v317.p = mul i128 %v317.a, %v317.b
  %v317.h = lshr i128 %v317.p, 64
  %v317 = trunc i128 %v317.h to i64
  %v318 = add i64 %v316, %v317
  %v319.a = zext i64 %v47 to i128
  %v319.b = zext i64 %v104 to i128
  %v319.p = mul i128 %v319.a, %v319.b
  %v319.h = lshr i128 %v319.p, 64
  %v319 = trunc i128 %v319.h to i64
  %v320 = add i64 %v318, %v319
  %v321.a = zext i64 %v60 to i128
  %v321.b = zext i64 %v93 to i128
  %v321.p = mul i128 %v321.a, %v321.b
  %v321.h = lshr i128 %v321.p, 64
  %v321 = trunc i128 %v321.h to i64
  %v322 = add i64 %v320, %v321
  %v323.a = zext i64 %v73 to i128
  %v323.b = zext i64 %v82 to i128
  %v323.p = mul i128 %v323.a, %v323.b
  %v323.h = lshr i128 %v323.p, 64
  %v323 = trunc i128 %v323.h to i64
  %v324 = add i64 %v322, %v323
  %v325 = add i64 0, 2
  %v326 = mul i64 %v325, %v324
  %v327 = add i64 0, 19
  %v328 = add i64 0, 2251799813685247
  %v329 = and i64 %v326, %v328
  %v330 = mul i64 %v327, %v329
  %v331 = add i64 %v163, %v330
  %v332 = add i64 0, 2
  %v333 = mul i64 %v332, %v172
  %v334 = add i64 %v201, %v333
  %v335 = add i64 0, 19
  %v336 = add i64 0, 51
  %v337.n = and i64 %v336, 63
  %v337 = ashr i64 %v326, %v337.n
  %v338 = mul i64 %v335, %v337
  %v339 = add i64 %v334, %v338
  %v340 = add i64 0, 2
  %v341 = mul i64 %v340, %v210
  %v342 = add i64 %v239, %v341
  %v343 = add i64 0, 2
  %v344 = mul i64 %v343, %v248
  %v345 = add i64 %v277, %v344
  %v346 = add i64 0, 2
  %v347 = mul i64 %v346, %v286
  %v348 = add i64 %v315, %v347
  %v349 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v349, i64 2572
  store i64 %v10, ptr %st20
  call void @"std/crypto/x25519.carry"(ptr %v0, i64 %v1, i64 %v331, i64 %v339, i64 %v342, i64 %v345, i64 %v348)
  %v351 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v351, i64 0
  store i64 %v4, ptr %st21
  ret void
}

define internal void @"std/crypto/x25519.invert"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [1 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s1 = alloca [1 x i64], align 8
  %s1.z0 = getelementptr i64, ptr %s1, i64 0
  store i64 0, ptr %s1.z0
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v75, i64 0
  %v4 = load i64, ptr %v4.p
  %v5 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v5, i64 2572
  %v6 = load i64, ptr %v6.p
  %v7 = add i64 0, 0
  %v8.c = icmp eq i64 %v6, %v7
  %v8 = zext i1 %v8.c to i64
  %v9 = mul i64 %v8, %v4
  %v10 = add i64 %v6, %v9
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v76, i64 0
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13 = add i64 0, 5
  %v14 = getelementptr i64, ptr %s0, i64 0
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v77, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s1, i64 0
  %st0 = getelementptr i64, ptr %v16, i64 0
  store i64 %v12, ptr %st0
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v78, i64 0
  %v17 = load i64, ptr %v17.p
  br label %b3
b1:
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st1 = getelementptr i64, ptr %v79, i64 0
  store i64 %v11, ptr %st1
  %v36 = add i64 0, 1
  %v37.p = getelementptr i64, ptr %v0, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v2, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b1 = icmp ne i64 %v38, 0
  br i1 %c.b1, label %b1.t3, label %b1.e4
b1.t3:
  br label %b9
b1.e4:
  br label %b10
b2:
  br label %b1
b3:
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v80, i64 0
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
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %v20.p = getelementptr i64, ptr %v81, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 0
  %v21 = load i64, ptr %v21.p
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v82, i64 0
  %v22 = load i64, ptr %v22.p
  %v23 = add i64 %v2, %v21
  %v24 = add i64 0, 0
  %v25.p = getelementptr i64, ptr %v0, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.c = icmp uge i64 %v23, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b4 = icmp ne i64 %v26, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b7
b4.e9:
  br label %b8
b5:
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v83, i64 0
  store i64 %v17, ptr %st9
  br label %b2
b6:
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v84, i64 0
  store i64 %v22, ptr %st10
  %v33 = add i64 0, 1
  %v34.p = getelementptr i64, ptr %v16, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 %v34, %v33
  %st11 = getelementptr i64, ptr %v16, i64 0
  store i64 %v35, ptr %st11
  br label %b3
b7:
  %v27 = add i64 0, 56
  call void @"rt.panic"(i64 %v27)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v28.p = getelementptr i64, ptr %v0, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = inttoptr i64 %v28 to ptr
  %v30 = add i64 0, 1
  %v31 = mul i64 %v23, %v30
  %v32 = getelementptr i64, ptr %v29, i64 %v31
  %st12 = getelementptr i64, ptr %v32, i64 0
  store i64 %v24, ptr %st12
  br label %b6
b9:
  %v39 = add i64 0, 57
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v40.p = getelementptr i64, ptr %v0, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v2, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %st13 = getelementptr i64, ptr %v44, i64 0
  store i64 %v36, ptr %st13
  %v85 = getelementptr i64, ptr @"rt.meta", i64 0
  %v45.p = getelementptr i64, ptr %v85, i64 0
  %v45 = load i64, ptr %v45.p
  %v46 = add i64 0, 0
  %v47 = add i64 0, 255
  %v48 = getelementptr i64, ptr %s1, i64 0
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v86, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = getelementptr i64, ptr %s0, i64 0
  %st14 = getelementptr i64, ptr %v50, i64 0
  store i64 %v46, ptr %st14
  %v87 = getelementptr i64, ptr @"rt.meta", i64 0
  %v51.p = getelementptr i64, ptr %v87, i64 0
  %v51 = load i64, ptr %v51.p
  br label %b13
b11:
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v88, i64 0
  store i64 %v45, ptr %st15
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v89, i64 0
  store i64 %v4, ptr %st16
  ret void
b12:
  br label %b11
b13:
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v90, i64 0
  store i64 %v51, ptr %st17
  %v52.p = getelementptr i64, ptr %v50, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp slt i64 %v52, %v47
  %v53 = zext i1 %v53.c to i64
  %c.b13 = icmp ne i64 %v53, 0
  br i1 %c.b13, label %b13.t19, label %b13.e20
b13.t19:
  br label %b14
b13.e20:
  br label %b15
b14:
  call void @"rt.region_enter"()
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %v54.p = getelementptr i64, ptr %v91, i64 0
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v50, i64 0
  %v55 = load i64, ptr %v55.p
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %v56.p = getelementptr i64, ptr %v92, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 254
  %v58 = sub i64 %v57, %v55
  %v59 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v59, i64 2572
  store i64 %v10, ptr %st20
  call void @"std/crypto/x25519.fmul"(ptr %v0, i64 %v1, i64 %v2, i64 %v2, i64 %v2)
  %v60 = add i64 0, 5
  %v61.c = icmp sge i64 %v58, %v60
  %v61 = zext i1 %v61.c to i64
  %c.b14 = icmp ne i64 %v61, 0
  br i1 %c.b14, label %b14.t22, label %b14.e23
b14.t22:
  br label %b18
b14.e23:
  br label %b17
b15:
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v93, i64 0
  store i64 %v51, ptr %st23
  br label %b12
b16:
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v94, i64 0
  store i64 %v56, ptr %st24
  %v72 = add i64 0, 1
  %v73.p = getelementptr i64, ptr %v50, i64 0
  %v73 = load i64, ptr %v73.p
  %v74 = add i64 %v73, %v72
  %st25 = getelementptr i64, ptr %v50, i64 0
  store i64 %v74, ptr %st25
  br label %b13
b17:
  %v63 = add i64 0, 3
  %v64.c = icmp eq i64 %v58, %v63
  %v64 = zext i1 %v64.c to i64
  br label %b18
b18:
  %v62 = phi i64 [ %v61, %b14.t22 ], [ %v64, %b17 ]
  %c.b18 = icmp ne i64 %v62, 0
  br i1 %c.b18, label %b18.t27, label %b18.e28
b18.t27:
  br label %b20
b18.e28:
  br label %b19
b19:
  %v66 = add i64 0, 1
  %v67.c = icmp eq i64 %v58, %v66
  %v67 = zext i1 %v67.c to i64
  br label %b20
b20:
  %v65 = phi i64 [ %v62, %b18.t27 ], [ %v67, %b19 ]
  %c.b20 = icmp ne i64 %v65, 0
  br i1 %c.b20, label %b20.t29, label %b20.e30
b20.t29:
  br label %b22
b20.e30:
  br label %b21
b21:
  %v69 = add i64 0, 0
  %v70.c = icmp eq i64 %v58, %v69
  %v70 = zext i1 %v70.c to i64
  br label %b22
b22:
  %v68 = phi i64 [ %v65, %b20.t29 ], [ %v70, %b21 ]
  %c.b22 = icmp ne i64 %v68, 0
  br i1 %c.b22, label %b22.t31, label %b22.e32
b22.t31:
  br label %b23
b22.e32:
  br label %b24
b23:
  %v71 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v71, i64 2572
  store i64 %v10, ptr %st32
  call void @"std/crypto/x25519.fmul"(ptr %v0, i64 %v1, i64 %v2, i64 %v2, i64 %v3)
  br label %b25
b24:
  br label %b25
b25:
  br label %b16
}

define internal void @"std/crypto/x25519.unpack"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v2, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v3, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v4, ptr %st2
  %v109 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v109, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v7, i64 2572
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp eq i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %v11 = mul i64 %v10, %v6
  %v12 = add i64 %v8, %v11
  %v110 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v110, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15 = add i64 0, 5
  %v16 = getelementptr i64, ptr %s1, i64 0
  %v111 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v111, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = getelementptr i64, ptr %s2, i64 0
  %st3 = getelementptr i64, ptr %v18, i64 0
  store i64 %v14, ptr %st3
  %v112 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v112, i64 0
  %v19 = load i64, ptr %v19.p
  br label %b3
b1:
  %v113 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v113, i64 0
  store i64 %v13, ptr %st4
  %v114 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v114, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = add i64 0, 0
  %v40 = add i64 0, 255
  %v41 = getelementptr i64, ptr %s2, i64 0
  %v115 = getelementptr i64, ptr @"rt.meta", i64 0
  %v42.p = getelementptr i64, ptr %v115, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = getelementptr i64, ptr %s1, i64 0
  %st5 = getelementptr i64, ptr %v43, i64 0
  store i64 %v39, ptr %st5
  %v116 = getelementptr i64, ptr @"rt.meta", i64 0
  %v44.p = getelementptr i64, ptr %v116, i64 0
  %v44 = load i64, ptr %v44.p
  br label %b11
b2:
  br label %b1
b3:
  %v117 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v117, i64 0
  store i64 %v19, ptr %st6
  %v20.p = getelementptr i64, ptr %v18, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.c = icmp slt i64 %v20, %v15
  %v21 = zext i1 %v21.c to i64
  %c.b3 = icmp ne i64 %v21, 0
  br i1 %c.b3, label %b3.t8, label %b3.e9
b3.t8:
  br label %b4
b3.e9:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v118 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v118, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v18, i64 0
  %v23 = load i64, ptr %v23.p
  %v119 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v119, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 %v1, %v23
  %v26 = add i64 0, 0
  %v27.p = getelementptr i64, ptr %v0, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v25, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b4 = icmp ne i64 %v28, 0
  br i1 %c.b4, label %b4.t10, label %b4.e11
b4.t10:
  br label %b7
b4.e11:
  br label %b8
b5:
  %v120 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v120, i64 0
  store i64 %v19, ptr %st11
  br label %b2
b6:
  %v121 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v121, i64 0
  store i64 %v24, ptr %st12
  %v35 = add i64 0, 1
  %v36.p = getelementptr i64, ptr %v18, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 %v36, %v35
  %st13 = getelementptr i64, ptr %v18, i64 0
  store i64 %v37, ptr %st13
  br label %b3
b7:
  %v29 = add i64 0, 58
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v30.p = getelementptr i64, ptr %v0, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = add i64 0, 1
  %v33 = mul i64 %v25, %v32
  %v34 = getelementptr i64, ptr %v31, i64 %v33
  %st14 = getelementptr i64, ptr %v34, i64 0
  store i64 %v26, ptr %st14
  br label %b6
b9:
  %v122 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v122, i64 0
  store i64 %v38, ptr %st15
  %v123 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v123, i64 0
  store i64 %v6, ptr %st16
  ret void
b10:
  br label %b9
b11:
  %v124 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v124, i64 0
  store i64 %v44, ptr %st17
  %v45.p = getelementptr i64, ptr %v43, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.c = icmp slt i64 %v45, %v40
  %v46 = zext i1 %v46.c to i64
  %c.b11 = icmp ne i64 %v46, 0
  br i1 %c.b11, label %b11.t19, label %b11.e20
b11.t19:
  br label %b12
b11.e20:
  br label %b13
b12:
  call void @"rt.region_enter"()
  %v125 = getelementptr i64, ptr @"rt.meta", i64 0
  %v47.p = getelementptr i64, ptr %v125, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v43, i64 0
  %v48 = load i64, ptr %v48.p
  %v126 = getelementptr i64, ptr @"rt.meta", i64 0
  %v49.p = getelementptr i64, ptr %v126, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 8
  %v51 = sdiv i64 %v48, %v50
  %v52.p = getelementptr i64, ptr %v5, i64 1
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp uge i64 %v51, %v52
  %v53 = zext i1 %v53.c to i64
  %c.b12 = icmp ne i64 %v53, 0
  br i1 %c.b12, label %b12.t21, label %b12.e22
b12.t21:
  br label %b15
b12.e22:
  br label %b16
b13:
  %v127 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v127, i64 0
  store i64 %v44, ptr %st22
  br label %b10
b14:
  %v128 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v128, i64 0
  store i64 %v49, ptr %st23
  %v106 = add i64 0, 1
  %v107.p = getelementptr i64, ptr %v43, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 %v107, %v106
  %st24 = getelementptr i64, ptr %v43, i64 0
  store i64 %v108, ptr %st24
  br label %b11
b15:
  %v54 = add i64 0, 59
  call void @"rt.panic"(i64 %v54)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v55.p = getelementptr i64, ptr %v5, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = inttoptr i64 %v55 to ptr
  %v57 = getelementptr i8, ptr %v56, i64 %v51
  %v58.p = getelementptr i8, ptr %v57, i64 0
  %v58.b = load i8, ptr %v58.p
  %v58 = zext i8 %v58.b to i64
  %v59 = add i64 0, 8
  %v60 = srem i64 %v48, %v59
  %v62 = add i64 0, 64
  %v63.c = icmp uge i64 %v60, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b16 = icmp ne i64 %v63, 0
  br i1 %c.b16, label %b16.t26, label %b16.e27
b16.t26:
  br label %b17
b16.e27:
  br label %b18
b17:
  %v64 = add i64 0, 0
  %v65.c = icmp slt i64 %v60, %v64
  %v65 = zext i1 %v65.c to i64
  %c.b17 = icmp ne i64 %v65, 0
  br i1 %c.b17, label %b17.t28, label %b17.e29
b17.t28:
  br label %b20
b17.e29:
  br label %b21
b18:
  %v69.n = and i64 %v60, 63
  %v69 = ashr i64 %v58, %v69.n
  br label %b19
b19:
  %v61 = phi i64 [ %v69, %b18 ], [ %v68, %b21 ]
  %v70 = add i64 0, 1
  %v71 = and i64 %v61, %v70
  %v72 = add i64 0, 51
  %v73 = sdiv i64 %v48, %v72
  %v74 = add i64 %v1, %v73
  %v75 = add i64 0, 51
  %v76 = sdiv i64 %v48, %v75
  %v77 = add i64 %v1, %v76
  %v78.p = getelementptr i64, ptr %v0, i64 1
  %v78 = load i64, ptr %v78.p
  %v79.c = icmp uge i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b19 = icmp ne i64 %v79, 0
  br i1 %c.b19, label %b19.t30, label %b19.e31
b19.t30:
  br label %b22
b19.e31:
  br label %b23
b20:
  %v66 = add i64 0, 60
  call void @"rt.panic"(i64 %v66)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v67 = add i64 0, 63
  %v68.n = and i64 %v67, 63
  %v68 = ashr i64 %v58, %v68.n
  br label %b19
b22:
  %v80 = add i64 0, 61
  call void @"rt.panic"(i64 %v80)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v81.p = getelementptr i64, ptr %v0, i64 0
  %v81 = load i64, ptr %v81.p
  %v82 = inttoptr i64 %v81 to ptr
  %v83 = add i64 0, 1
  %v84 = mul i64 %v77, %v83
  %v85 = getelementptr i64, ptr %v82, i64 %v84
  %v86.p = getelementptr i64, ptr %v85, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 0, 51
  %v88 = srem i64 %v48, %v87
  %v90 = add i64 0, 64
  %v91.c = icmp uge i64 %v88, %v90
  %v91 = zext i1 %v91.c to i64
  %c.b23 = icmp ne i64 %v91, 0
  br i1 %c.b23, label %b23.t32, label %b23.e33
b23.t32:
  br label %b24
b23.e33:
  br label %b25
b24:
  %v92 = add i64 0, 0
  %v93.c = icmp slt i64 %v88, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b24 = icmp ne i64 %v93, 0
  br i1 %c.b24, label %b24.t34, label %b24.e35
b24.t34:
  br label %b27
b24.e35:
  br label %b28
b25:
  %v96.n = and i64 %v88, 63
  %v96 = shl i64 %v71, %v96.n
  br label %b26
b26:
  %v89 = phi i64 [ %v96, %b25 ], [ %v95, %b28 ]
  %v97 = or i64 %v86, %v89
  %v98.p = getelementptr i64, ptr %v0, i64 1
  %v98 = load i64, ptr %v98.p
  %v99.c = icmp uge i64 %v74, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b26 = icmp ne i64 %v99, 0
  br i1 %c.b26, label %b26.t36, label %b26.e37
b26.t36:
  br label %b29
b26.e37:
  br label %b30
b27:
  %v94 = add i64 0, 62
  call void @"rt.panic"(i64 %v94)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b28:
  %v95 = add i64 0, 0
  br label %b26
b29:
  %v100 = add i64 0, 63
  call void @"rt.panic"(i64 %v100)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v101.p = getelementptr i64, ptr %v0, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = inttoptr i64 %v101 to ptr
  %v103 = add i64 0, 1
  %v104 = mul i64 %v74, %v103
  %v105 = getelementptr i64, ptr %v102, i64 %v104
  %st37 = getelementptr i64, ptr %v105, i64 0
  store i64 %v97, ptr %st37
  br label %b14
}

define internal void @"std/crypto/x25519.pack"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s8 = alloca [3 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v374 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v374, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v7, i64 2571
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v7, i64 2571
  store i64 %v9, ptr %st3
  %v10 = add i64 0, 1
  %v11.c = icmp sge i64 %v8, %v10
  %v11 = zext i1 %v11.c to i64
  %v12.c = icmp sle i64 %v8, %v6
  %v12 = zext i1 %v12.c to i64
  %v13 = and i64 %v11, %v12
  %v14 = sub i64 %v8, %v6
  %v15 = mul i64 %v13, %v14
  %v16 = add i64 %v6, %v15
  call void @"rt.region_enter"()
  %v17.p = getelementptr i64, ptr %v5, i64 1
  %v17 = load i64, ptr %v17.p
  %v18.c = icmp uge i64 %v4, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v19 = add i64 0, 64
  call void @"rt.panic"(i64 %v19)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v20.p = getelementptr i64, ptr %v5, i64 0
  %v20 = load i64, ptr %v20.p
  %v21 = inttoptr i64 %v20 to ptr
  %v22 = add i64 0, 1
  %v23 = mul i64 %v4, %v22
  %v24 = getelementptr i64, ptr %v21, i64 %v23
  %v25.p = getelementptr i64, ptr %v24, i64 0
  %v25 = load i64, ptr %v25.p
  %v26 = add i64 0, 19
  %v27 = add i64 %v25, %v26
  %v28 = add i64 0, 51
  %v29.n = and i64 %v28, 63
  %v29 = ashr i64 %v27, %v29.n
  %v30 = getelementptr i64, ptr %s1, i64 0
  %st6 = getelementptr i64, ptr %v30, i64 0
  store i64 %v29, ptr %st6
  %v31 = add i64 0, 1
  %v32 = add i64 %v4, %v31
  %v33.p = getelementptr i64, ptr %v5, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.c = icmp uge i64 %v32, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b2 = icmp ne i64 %v34, 0
  br i1 %c.b2, label %b2.t8, label %b2.e9
b2.t8:
  br label %b3
b2.e9:
  br label %b4
b3:
  %v35 = add i64 0, 65
  call void @"rt.panic"(i64 %v35)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v36.p = getelementptr i64, ptr %v5, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = inttoptr i64 %v36 to ptr
  %v38 = add i64 0, 1
  %v39 = mul i64 %v32, %v38
  %v40 = getelementptr i64, ptr %v37, i64 %v39
  %v41.p = getelementptr i64, ptr %v40, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v30, i64 0
  %v42 = load i64, ptr %v42.p
  %v43 = add i64 %v41, %v42
  %v44 = add i64 0, 51
  %v45.n = and i64 %v44, 63
  %v45 = ashr i64 %v43, %v45.n
  %st9 = getelementptr i64, ptr %v30, i64 0
  store i64 %v45, ptr %st9
  %v46 = add i64 0, 2
  %v47 = add i64 %v4, %v46
  %v48.p = getelementptr i64, ptr %v5, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp uge i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b4 = icmp ne i64 %v49, 0
  br i1 %c.b4, label %b4.t11, label %b4.e12
b4.t11:
  br label %b5
b4.e12:
  br label %b6
b5:
  %v50 = add i64 0, 66
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v51.p = getelementptr i64, ptr %v5, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = add i64 0, 1
  %v54 = mul i64 %v47, %v53
  %v55 = getelementptr i64, ptr %v52, i64 %v54
  %v56.p = getelementptr i64, ptr %v55, i64 0
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v30, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 %v56, %v57
  %v59 = add i64 0, 51
  %v60.n = and i64 %v59, 63
  %v60 = ashr i64 %v58, %v60.n
  %st12 = getelementptr i64, ptr %v30, i64 0
  store i64 %v60, ptr %st12
  %v61 = add i64 0, 3
  %v62 = add i64 %v4, %v61
  %v63.p = getelementptr i64, ptr %v5, i64 1
  %v63 = load i64, ptr %v63.p
  %v64.c = icmp uge i64 %v62, %v63
  %v64 = zext i1 %v64.c to i64
  %c.b6 = icmp ne i64 %v64, 0
  br i1 %c.b6, label %b6.t14, label %b6.e15
b6.t14:
  br label %b7
b6.e15:
  br label %b8
b7:
  %v65 = add i64 0, 67
  call void @"rt.panic"(i64 %v65)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v66.p = getelementptr i64, ptr %v5, i64 0
  %v66 = load i64, ptr %v66.p
  %v67 = inttoptr i64 %v66 to ptr
  %v68 = add i64 0, 1
  %v69 = mul i64 %v62, %v68
  %v70 = getelementptr i64, ptr %v67, i64 %v69
  %v71.p = getelementptr i64, ptr %v70, i64 0
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v30, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 %v71, %v72
  %v74 = add i64 0, 51
  %v75.n = and i64 %v74, 63
  %v75 = ashr i64 %v73, %v75.n
  %st15 = getelementptr i64, ptr %v30, i64 0
  store i64 %v75, ptr %st15
  %v76 = add i64 0, 4
  %v77 = add i64 %v4, %v76
  %v78.p = getelementptr i64, ptr %v5, i64 1
  %v78 = load i64, ptr %v78.p
  %v79.c = icmp uge i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b8 = icmp ne i64 %v79, 0
  br i1 %c.b8, label %b8.t17, label %b8.e18
b8.t17:
  br label %b9
b8.e18:
  br label %b10
b9:
  %v80 = add i64 0, 68
  call void @"rt.panic"(i64 %v80)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v81.p = getelementptr i64, ptr %v5, i64 0
  %v81 = load i64, ptr %v81.p
  %v82 = inttoptr i64 %v81 to ptr
  %v83 = add i64 0, 1
  %v84 = mul i64 %v77, %v83
  %v85 = getelementptr i64, ptr %v82, i64 %v84
  %v86.p = getelementptr i64, ptr %v85, i64 0
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v30, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 %v86, %v87
  %v89 = add i64 0, 51
  %v90.n = and i64 %v89, 63
  %v90 = ashr i64 %v88, %v90.n
  %st18 = getelementptr i64, ptr %v30, i64 0
  store i64 %v90, ptr %st18
  %v91.p = getelementptr i64, ptr %v5, i64 1
  %v91 = load i64, ptr %v91.p
  %v92.c = icmp uge i64 %v4, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b10 = icmp ne i64 %v92, 0
  br i1 %c.b10, label %b10.t20, label %b10.e21
b10.t20:
  br label %b11
b10.e21:
  br label %b12
b11:
  %v93 = add i64 0, 69
  call void @"rt.panic"(i64 %v93)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v94.p = getelementptr i64, ptr %v5, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = inttoptr i64 %v94 to ptr
  %v96 = add i64 0, 1
  %v97 = mul i64 %v4, %v96
  %v98 = getelementptr i64, ptr %v95, i64 %v97
  %v99.p = getelementptr i64, ptr %v98, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = add i64 0, 19
  %v101.p = getelementptr i64, ptr %v30, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = mul i64 %v100, %v101
  %v103 = add i64 %v99, %v102
  %v104 = add i64 0, 1
  %v105 = add i64 %v4, %v104
  %v106.p = getelementptr i64, ptr %v5, i64 1
  %v106 = load i64, ptr %v106.p
  %v107.c = icmp uge i64 %v105, %v106
  %v107 = zext i1 %v107.c to i64
  %c.b12 = icmp ne i64 %v107, 0
  br i1 %c.b12, label %b12.t22, label %b12.e23
b12.t22:
  br label %b13
b12.e23:
  br label %b14
b13:
  %v108 = add i64 0, 70
  call void @"rt.panic"(i64 %v108)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v109.p = getelementptr i64, ptr %v5, i64 0
  %v109 = load i64, ptr %v109.p
  %v110 = inttoptr i64 %v109 to ptr
  %v111 = add i64 0, 1
  %v112 = mul i64 %v105, %v111
  %v113 = getelementptr i64, ptr %v110, i64 %v112
  %v114.p = getelementptr i64, ptr %v113, i64 0
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 51
  %v116.n = and i64 %v115, 63
  %v116 = ashr i64 %v103, %v116.n
  %v117 = add i64 %v114, %v116
  %v118 = add i64 0, 2
  %v119 = add i64 %v4, %v118
  %v120.p = getelementptr i64, ptr %v5, i64 1
  %v120 = load i64, ptr %v120.p
  %v121.c = icmp uge i64 %v119, %v120
  %v121 = zext i1 %v121.c to i64
  %c.b14 = icmp ne i64 %v121, 0
  br i1 %c.b14, label %b14.t24, label %b14.e25
b14.t24:
  br label %b15
b14.e25:
  br label %b16
b15:
  %v122 = add i64 0, 71
  call void @"rt.panic"(i64 %v122)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v123.p = getelementptr i64, ptr %v5, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = inttoptr i64 %v123 to ptr
  %v125 = add i64 0, 1
  %v126 = mul i64 %v119, %v125
  %v127 = getelementptr i64, ptr %v124, i64 %v126
  %v128.p = getelementptr i64, ptr %v127, i64 0
  %v128 = load i64, ptr %v128.p
  %v129 = add i64 0, 51
  %v130.n = and i64 %v129, 63
  %v130 = ashr i64 %v117, %v130.n
  %v131 = add i64 %v128, %v130
  %v132 = add i64 0, 3
  %v133 = add i64 %v4, %v132
  %v134.p = getelementptr i64, ptr %v5, i64 1
  %v134 = load i64, ptr %v134.p
  %v135.c = icmp uge i64 %v133, %v134
  %v135 = zext i1 %v135.c to i64
  %c.b16 = icmp ne i64 %v135, 0
  br i1 %c.b16, label %b16.t26, label %b16.e27
b16.t26:
  br label %b17
b16.e27:
  br label %b18
b17:
  %v136 = add i64 0, 72
  call void @"rt.panic"(i64 %v136)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v137.p = getelementptr i64, ptr %v5, i64 0
  %v137 = load i64, ptr %v137.p
  %v138 = inttoptr i64 %v137 to ptr
  %v139 = add i64 0, 1
  %v140 = mul i64 %v133, %v139
  %v141 = getelementptr i64, ptr %v138, i64 %v140
  %v142.p = getelementptr i64, ptr %v141, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = add i64 0, 51
  %v144.n = and i64 %v143, 63
  %v144 = ashr i64 %v131, %v144.n
  %v145 = add i64 %v142, %v144
  %v146 = add i64 0, 4
  %v147 = add i64 %v4, %v146
  %v148.p = getelementptr i64, ptr %v5, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.c = icmp uge i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b18 = icmp ne i64 %v149, 0
  br i1 %c.b18, label %b18.t28, label %b18.e29
b18.t28:
  br label %b19
b18.e29:
  br label %b20
b19:
  %v150 = add i64 0, 73
  call void @"rt.panic"(i64 %v150)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v151.p = getelementptr i64, ptr %v5, i64 0
  %v151 = load i64, ptr %v151.p
  %v152 = inttoptr i64 %v151 to ptr
  %v153 = add i64 0, 1
  %v154 = mul i64 %v147, %v153
  %v155 = getelementptr i64, ptr %v152, i64 %v154
  %v156.p = getelementptr i64, ptr %v155, i64 0
  %v156 = load i64, ptr %v156.p
  %v157 = add i64 0, 51
  %v158.n = and i64 %v157, 63
  %v158 = ashr i64 %v145, %v158.n
  %v159 = add i64 %v156, %v158
  %v160 = add i64 0, 2251799813685247
  %v161 = and i64 %v103, %v160
  %v162 = add i64 0, 2251799813685247
  %v163 = and i64 %v117, %v162
  %v164 = add i64 0, 2251799813685247
  %v165 = and i64 %v131, %v164
  %v166 = add i64 0, 2251799813685247
  %v167 = and i64 %v145, %v166
  %v168 = add i64 0, 2251799813685247
  %v169 = and i64 %v159, %v168
  %v170 = add i64 0, 5
  %v171 = call ptr @"rt.region_alloc"(i64 %v16, i64 %v170)
  %st29 = getelementptr i64, ptr %v171, i64 0
  store i64 %v161, ptr %st29
  %st30 = getelementptr i64, ptr %v171, i64 1
  store i64 %v163, ptr %st30
  %st31 = getelementptr i64, ptr %v171, i64 2
  store i64 %v165, ptr %st31
  %st32 = getelementptr i64, ptr %v171, i64 3
  store i64 %v167, ptr %st32
  %st33 = getelementptr i64, ptr %v171, i64 4
  store i64 %v169, ptr %st33
  %v172 = add i64 0, 5
  %v173 = getelementptr i64, ptr %s2, i64 0
  %v174 = ptrtoint ptr %v171 to i64
  %st34 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st34
  %st35 = getelementptr i64, ptr %v173, i64 1
  store i64 %v172, ptr %st35
  %st36 = getelementptr i64, ptr %v173, i64 2
  store i64 %v16, ptr %st36
  %v175 = getelementptr i64, ptr %s3, i64 0
  %v176.p = getelementptr i64, ptr %v173, i64 0
  %v176 = load i64, ptr %v176.p
  %st37 = getelementptr i64, ptr %v175, i64 0
  store i64 %v176, ptr %st37
  %v177.p = getelementptr i64, ptr %v173, i64 1
  %v177 = load i64, ptr %v177.p
  %st38 = getelementptr i64, ptr %v175, i64 1
  store i64 %v177, ptr %st38
  %v178.p = getelementptr i64, ptr %v173, i64 2
  %v178 = load i64, ptr %v178.p
  %st39 = getelementptr i64, ptr %v175, i64 2
  store i64 %v178, ptr %st39
  %v179 = add i64 0, 0
  %v180 = call ptr @"rt.region_alloc"(i64 %v16, i64 %v179)
  %v181 = add i64 0, 0
  %v182 = getelementptr i64, ptr %s2, i64 0
  %v183 = ptrtoint ptr %v180 to i64
  %st40 = getelementptr i64, ptr %v182, i64 0
  store i64 %v183, ptr %st40
  %st41 = getelementptr i64, ptr %v182, i64 1
  store i64 %v181, ptr %st41
  %st42 = getelementptr i64, ptr %v182, i64 2
  store i64 %v16, ptr %st42
  %v184 = getelementptr i64, ptr %s4, i64 0
  %v185.p = getelementptr i64, ptr %v182, i64 0
  %v185 = load i64, ptr %v185.p
  %st43 = getelementptr i64, ptr %v184, i64 0
  store i64 %v185, ptr %st43
  %v186.p = getelementptr i64, ptr %v182, i64 1
  %v186 = load i64, ptr %v186.p
  %st44 = getelementptr i64, ptr %v184, i64 1
  store i64 %v186, ptr %st44
  %v187.p = getelementptr i64, ptr %v182, i64 2
  %v187 = load i64, ptr %v187.p
  %st45 = getelementptr i64, ptr %v184, i64 2
  store i64 %v187, ptr %st45
  %v188 = add i64 0, 0
  %v189 = add i64 0, 0
  %v190 = add i64 0, 32
  %v191 = add i64 0, 0
  %v192 = sub i64 %v190, %v189
  %v193.c = icmp sle i64 %v192, %v188
  %v193 = zext i1 %v193.c to i64
  %c.b20 = icmp ne i64 %v193, 0
  br i1 %c.b20, label %b20.t47, label %b20.e48
b20.t47:
  br label %b21
b20.e48:
  br label %b22
b21:
  %v375 = getelementptr i64, ptr @"rt.meta", i64 0
  %v236.p = getelementptr i64, ptr %v375, i64 0
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 0, 0
  %v238 = add i64 0, 255
  %v239 = getelementptr i64, ptr %s6, i64 0
  %v376 = getelementptr i64, ptr @"rt.meta", i64 0
  %v240.p = getelementptr i64, ptr %v376, i64 0
  %v240 = load i64, ptr %v240.p
  %v241 = getelementptr i64, ptr %s7, i64 0
  %st48 = getelementptr i64, ptr %v241, i64 0
  store i64 %v237, ptr %st48
  %v377 = getelementptr i64, ptr @"rt.meta", i64 0
  %v242.p = getelementptr i64, ptr %v377, i64 0
  %v242 = load i64, ptr %v242.p
  br label %b31
b22:
  %v194 = getelementptr i64, ptr %s2, i64 0
  %v195.p = getelementptr i64, ptr %v184, i64 0
  %v195 = load i64, ptr %v195.p
  %st49 = getelementptr i64, ptr %v194, i64 0
  store i64 %v195, ptr %st49
  %v196.p = getelementptr i64, ptr %v184, i64 1
  %v196 = load i64, ptr %v196.p
  %st50 = getelementptr i64, ptr %v194, i64 1
  store i64 %v196, ptr %st50
  %v197.p = getelementptr i64, ptr %v184, i64 2
  %v197 = load i64, ptr %v197.p
  %st51 = getelementptr i64, ptr %v194, i64 2
  store i64 %v197, ptr %st51
  %v198.p = getelementptr i64, ptr %v194, i64 2
  %v198 = load i64, ptr %v198.p
  %v199.p = getelementptr i64, ptr %v194, i64 0
  %v199 = load i64, ptr %v199.p
  %v200.p = getelementptr i64, ptr %v194, i64 1
  %v200 = load i64, ptr %v200.p
  %v203 = add i64 0, 8
  %v204 = mul i64 %v200, %v203
  %v205 = add i64 %v199, %v204
  %v378 = getelementptr i64, ptr @"rt.meta", i64 0
  %v379 = getelementptr i64, ptr %v378, i64 %v198
  %v206.p = getelementptr i64, ptr %v379, i64 1
  %v206 = load ptr, ptr %v206.p
  %v207 = ptrtoint ptr %v206 to i64
  %v208.c = icmp eq i64 %v207, %v205
  %v208 = zext i1 %v208.c to i64
  %c.b22 = icmp ne i64 %v208, 0
  br i1 %c.b22, label %b22.t53, label %b22.e54
b22.t53:
  br label %b25
b22.e54:
  br label %b24
b23:
  %v201 = phi ptr [ %v218, %b24 ], [ %v212, %b25 ]
  %v202 = phi ptr [ %v220, %b24 ], [ %v211, %b25 ]
  %v222 = add i64 0, 0
  br label %b26
b24:
  %v213 = add i64 0, 1
  %v214 = mul i64 %v200, %v213
  %v215 = add i64 0, 1
  %v216 = mul i64 %v192, %v215
  %v217 = add i64 %v214, %v216
  %v218 = call ptr @"rt.region_alloc"(i64 %v198, i64 %v217)
  %v219 = inttoptr i64 %v199 to ptr
  call void @"rt.copy"(ptr %v218, ptr %v219, i64 %v214)
  %v220 = getelementptr i64, ptr %v218, i64 %v214
  br label %b23
b25:
  %v209 = add i64 0, 1
  %v210 = mul i64 %v192, %v209
  %v211 = call ptr @"rt.region_alloc"(i64 %v198, i64 %v210)
  %v212 = inttoptr i64 %v199 to ptr
  br label %b23
b26:
  %v221 = phi i64 [ %v222, %b23 ], [ %v228, %b27 ]
  %v223.c = icmp slt i64 %v221, %v192
  %v223 = zext i1 %v223.c to i64
  %c.b26 = icmp ne i64 %v223, 0
  br i1 %c.b26, label %b26.t55, label %b26.e56
b26.t55:
  br label %b27
b26.e56:
  br label %b28
b27:
  %v224 = add i64 0, 1
  %v225 = mul i64 %v221, %v224
  %v226 = getelementptr i64, ptr %v202, i64 %v225
  %st56 = getelementptr i64, ptr %v226, i64 0
  store i64 %v191, ptr %st56
  %v227 = add i64 0, 1
  %v228 = add i64 %v221, %v227
  br label %b26
b28:
  %v229.p = getelementptr i64, ptr %v194, i64 1
  %v229 = load i64, ptr %v229.p
  %v230 = add i64 %v229, %v192
  %v231 = getelementptr i64, ptr %s5, i64 0
  %v232 = ptrtoint ptr %v201 to i64
  %st57 = getelementptr i64, ptr %v231, i64 0
  store i64 %v232, ptr %st57
  %st58 = getelementptr i64, ptr %v231, i64 1
  store i64 %v230, ptr %st58
  %st59 = getelementptr i64, ptr %v231, i64 2
  store i64 %v198, ptr %st59
  %v233.p = getelementptr i64, ptr %v231, i64 0
  %v233 = load i64, ptr %v233.p
  %st60 = getelementptr i64, ptr %v184, i64 0
  store i64 %v233, ptr %st60
  %v234.p = getelementptr i64, ptr %v231, i64 1
  %v234 = load i64, ptr %v234.p
  %st61 = getelementptr i64, ptr %v184, i64 1
  store i64 %v234, ptr %st61
  %v235.p = getelementptr i64, ptr %v231, i64 2
  %v235 = load i64, ptr %v235.p
  %st62 = getelementptr i64, ptr %v184, i64 2
  store i64 %v235, ptr %st62
  br label %b21
b29:
  %v380 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v380, i64 0
  store i64 %v236, ptr %st63
  %v307 = add i64 0, 0
  %v308 = call ptr @"rt.region_alloc8"(i64 %v16, i64 %v307)
  %v309 = add i64 0, 0
  %v310 = getelementptr i64, ptr %s5, i64 0
  %v311 = ptrtoint ptr %v308 to i64
  %st64 = getelementptr i64, ptr %v310, i64 0
  store i64 %v311, ptr %st64
  %st65 = getelementptr i64, ptr %v310, i64 1
  store i64 %v309, ptr %st65
  %st66 = getelementptr i64, ptr %v310, i64 2
  store i64 %v16, ptr %st66
  %v312 = getelementptr i64, ptr %s2, i64 0
  %v313.p = getelementptr i64, ptr %v310, i64 0
  %v313 = load i64, ptr %v313.p
  %st67 = getelementptr i64, ptr %v312, i64 0
  store i64 %v313, ptr %st67
  %v314.p = getelementptr i64, ptr %v310, i64 1
  %v314 = load i64, ptr %v314.p
  %st68 = getelementptr i64, ptr %v312, i64 1
  store i64 %v314, ptr %st68
  %v315.p = getelementptr i64, ptr %v310, i64 2
  %v315 = load i64, ptr %v315.p
  %st69 = getelementptr i64, ptr %v312, i64 2
  store i64 %v315, ptr %st69
  %v381 = getelementptr i64, ptr @"rt.meta", i64 0
  %v316.p = getelementptr i64, ptr %v381, i64 0
  %v316 = load i64, ptr %v316.p
  %v317 = add i64 0, 0
  %v318 = add i64 0, 32
  %v319 = getelementptr i64, ptr %s7, i64 0
  %v382 = getelementptr i64, ptr @"rt.meta", i64 0
  %v320.p = getelementptr i64, ptr %v382, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = getelementptr i64, ptr %s6, i64 0
  %st70 = getelementptr i64, ptr %v321, i64 0
  store i64 %v317, ptr %st70
  %v383 = getelementptr i64, ptr @"rt.meta", i64 0
  %v322.p = getelementptr i64, ptr %v383, i64 0
  %v322 = load i64, ptr %v322.p
  br label %b53
b30:
  br label %b29
b31:
  %v384 = getelementptr i64, ptr @"rt.meta", i64 0
  %st71 = getelementptr i64, ptr %v384, i64 0
  store i64 %v242, ptr %st71
  %v243.p = getelementptr i64, ptr %v241, i64 0
  %v243 = load i64, ptr %v243.p
  %v244.c = icmp slt i64 %v243, %v238
  %v244 = zext i1 %v244.c to i64
  %c.b31 = icmp ne i64 %v244, 0
  br i1 %c.b31, label %b31.t73, label %b31.e74
b31.t73:
  br label %b32
b31.e74:
  br label %b33
b32:
  call void @"rt.region_enter"()
  %v385 = getelementptr i64, ptr @"rt.meta", i64 0
  %v245.p = getelementptr i64, ptr %v385, i64 0
  %v245 = load i64, ptr %v245.p
  %v246.p = getelementptr i64, ptr %v241, i64 0
  %v246 = load i64, ptr %v246.p
  %v386 = getelementptr i64, ptr @"rt.meta", i64 0
  %v247.p = getelementptr i64, ptr %v386, i64 0
  %v247 = load i64, ptr %v247.p
  %v248 = add i64 0, 8
  %v249 = sdiv i64 %v246, %v248
  %v250 = add i64 0, 8
  %v251 = sdiv i64 %v246, %v250
  %v252.p = getelementptr i64, ptr %v184, i64 1
  %v252 = load i64, ptr %v252.p
  %v253.c = icmp uge i64 %v251, %v252
  %v253 = zext i1 %v253.c to i64
  %c.b32 = icmp ne i64 %v253, 0
  br i1 %c.b32, label %b32.t75, label %b32.e76
b32.t75:
  br label %b35
b32.e76:
  br label %b36
b33:
  %v387 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v387, i64 0
  store i64 %v242, ptr %st76
  br label %b30
b34:
  %v388 = getelementptr i64, ptr @"rt.meta", i64 0
  %st77 = getelementptr i64, ptr %v388, i64 0
  store i64 %v247, ptr %st77
  %v304 = add i64 0, 1
  %v305.p = getelementptr i64, ptr %v241, i64 0
  %v305 = load i64, ptr %v305.p
  %v306 = add i64 %v305, %v304
  %st78 = getelementptr i64, ptr %v241, i64 0
  store i64 %v306, ptr %st78
  br label %b31
b35:
  %v254 = add i64 0, 74
  call void @"rt.panic"(i64 %v254)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b36:
  %v255.p = getelementptr i64, ptr %v184, i64 0
  %v255 = load i64, ptr %v255.p
  %v256 = inttoptr i64 %v255 to ptr
  %v257 = add i64 0, 1
  %v258 = mul i64 %v251, %v257
  %v259 = getelementptr i64, ptr %v256, i64 %v258
  %v260.p = getelementptr i64, ptr %v259, i64 0
  %v260 = load i64, ptr %v260.p
  %v261 = add i64 0, 51
  %v262 = sdiv i64 %v246, %v261
  %v263.p = getelementptr i64, ptr %v175, i64 1
  %v263 = load i64, ptr %v263.p
  %v264.c = icmp uge i64 %v262, %v263
  %v264 = zext i1 %v264.c to i64
  %c.b36 = icmp ne i64 %v264, 0
  br i1 %c.b36, label %b36.t80, label %b36.e81
b36.t80:
  br label %b37
b36.e81:
  br label %b38
b37:
  %v265 = add i64 0, 75
  call void @"rt.panic"(i64 %v265)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b38:
  %v266.p = getelementptr i64, ptr %v175, i64 0
  %v266 = load i64, ptr %v266.p
  %v267 = inttoptr i64 %v266 to ptr
  %v268 = add i64 0, 1
  %v269 = mul i64 %v262, %v268
  %v270 = getelementptr i64, ptr %v267, i64 %v269
  %v271.p = getelementptr i64, ptr %v270, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 0, 51
  %v273 = srem i64 %v246, %v272
  %v275 = add i64 0, 64
  %v276.c = icmp uge i64 %v273, %v275
  %v276 = zext i1 %v276.c to i64
  %c.b38 = icmp ne i64 %v276, 0
  br i1 %c.b38, label %b38.t82, label %b38.e83
b38.t82:
  br label %b39
b38.e83:
  br label %b40
b39:
  %v277 = add i64 0, 0
  %v278.c = icmp slt i64 %v273, %v277
  %v278 = zext i1 %v278.c to i64
  %c.b39 = icmp ne i64 %v278, 0
  br i1 %c.b39, label %b39.t84, label %b39.e85
b39.t84:
  br label %b42
b39.e85:
  br label %b43
b40:
  %v282.n = and i64 %v273, 63
  %v282 = ashr i64 %v271, %v282.n
  br label %b41
b41:
  %v274 = phi i64 [ %v282, %b40 ], [ %v281, %b43 ]
  %v283 = add i64 0, 1
  %v284 = and i64 %v274, %v283
  %v285 = add i64 0, 8
  %v286 = srem i64 %v246, %v285
  %v288 = add i64 0, 64
  %v289.c = icmp uge i64 %v286, %v288
  %v289 = zext i1 %v289.c to i64
  %c.b41 = icmp ne i64 %v289, 0
  br i1 %c.b41, label %b41.t86, label %b41.e87
b41.t86:
  br label %b44
b41.e87:
  br label %b45
b42:
  %v279 = add i64 0, 76
  call void @"rt.panic"(i64 %v279)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b43:
  %v280 = add i64 0, 63
  %v281.n = and i64 %v280, 63
  %v281 = ashr i64 %v271, %v281.n
  br label %b41
b44:
  %v290 = add i64 0, 0
  %v291.c = icmp slt i64 %v286, %v290
  %v291 = zext i1 %v291.c to i64
  %c.b44 = icmp ne i64 %v291, 0
  br i1 %c.b44, label %b44.t88, label %b44.e89
b44.t88:
  br label %b47
b44.e89:
  br label %b48
b45:
  %v294.n = and i64 %v286, 63
  %v294 = shl i64 %v284, %v294.n
  br label %b46
b46:
  %v287 = phi i64 [ %v294, %b45 ], [ %v293, %b48 ]
  %v295 = or i64 %v260, %v287
  %v296.p = getelementptr i64, ptr %v184, i64 1
  %v296 = load i64, ptr %v296.p
  %v297.c = icmp uge i64 %v249, %v296
  %v297 = zext i1 %v297.c to i64
  %c.b46 = icmp ne i64 %v297, 0
  br i1 %c.b46, label %b46.t90, label %b46.e91
b46.t90:
  br label %b49
b46.e91:
  br label %b50
b47:
  %v292 = add i64 0, 77
  call void @"rt.panic"(i64 %v292)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b48:
  %v293 = add i64 0, 0
  br label %b46
b49:
  %v298 = add i64 0, 78
  call void @"rt.panic"(i64 %v298)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b50:
  %v299.p = getelementptr i64, ptr %v184, i64 0
  %v299 = load i64, ptr %v299.p
  %v300 = inttoptr i64 %v299 to ptr
  %v301 = add i64 0, 1
  %v302 = mul i64 %v249, %v301
  %v303 = getelementptr i64, ptr %v300, i64 %v302
  %st91 = getelementptr i64, ptr %v303, i64 0
  store i64 %v295, ptr %st91
  br label %b34
b51:
  %v389 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v389, i64 0
  store i64 %v316, ptr %st92
  %v371.p = getelementptr i64, ptr %v312, i64 0
  %v371 = load i64, ptr %v371.p
  %st93 = getelementptr i64, ptr %v0, i64 0
  store i64 %v371, ptr %st93
  %v372.p = getelementptr i64, ptr %v312, i64 1
  %v372 = load i64, ptr %v372.p
  %st94 = getelementptr i64, ptr %v0, i64 1
  store i64 %v372, ptr %st94
  %v373.p = getelementptr i64, ptr %v312, i64 2
  %v373 = load i64, ptr %v373.p
  %st95 = getelementptr i64, ptr %v0, i64 2
  store i64 %v373, ptr %st95
  call void @"rt.region_relocate8"(ptr %v0, i64 %v6)
  %v390 = getelementptr i64, ptr @"rt.meta", i64 0
  %st96 = getelementptr i64, ptr %v390, i64 0
  store i64 %v6, ptr %st96
  ret void
b52:
  br label %b51
b53:
  %v391 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v391, i64 0
  store i64 %v322, ptr %st97
  %v323.p = getelementptr i64, ptr %v321, i64 0
  %v323 = load i64, ptr %v323.p
  %v324.c = icmp slt i64 %v323, %v318
  %v324 = zext i1 %v324.c to i64
  %c.b53 = icmp ne i64 %v324, 0
  br i1 %c.b53, label %b53.t99, label %b53.e100
b53.t99:
  br label %b54
b53.e100:
  br label %b55
b54:
  call void @"rt.region_enter"()
  %v392 = getelementptr i64, ptr @"rt.meta", i64 0
  %v325.p = getelementptr i64, ptr %v392, i64 0
  %v325 = load i64, ptr %v325.p
  %v326.p = getelementptr i64, ptr %v321, i64 0
  %v326 = load i64, ptr %v326.p
  %v393 = getelementptr i64, ptr @"rt.meta", i64 0
  %v327.p = getelementptr i64, ptr %v393, i64 0
  %v327 = load i64, ptr %v327.p
  %v328 = add i64 0, 1
  %v329 = add i64 %v6, %v328
  %v330 = getelementptr i64, ptr %s5, i64 0
  %v331.p = getelementptr i64, ptr %v312, i64 0
  %v331 = load i64, ptr %v331.p
  %st100 = getelementptr i64, ptr %v330, i64 0
  store i64 %v331, ptr %st100
  %v332.p = getelementptr i64, ptr %v312, i64 1
  %v332 = load i64, ptr %v332.p
  %st101 = getelementptr i64, ptr %v330, i64 1
  store i64 %v332, ptr %st101
  %v333.p = getelementptr i64, ptr %v312, i64 2
  %v333 = load i64, ptr %v333.p
  %st102 = getelementptr i64, ptr %v330, i64 2
  store i64 %v333, ptr %st102
  %v334.p = getelementptr i64, ptr %v184, i64 1
  %v334 = load i64, ptr %v334.p
  %v335.c = icmp uge i64 %v326, %v334
  %v335 = zext i1 %v335.c to i64
  %c.b54 = icmp ne i64 %v335, 0
  br i1 %c.b54, label %b54.t104, label %b54.e105
b54.t104:
  br label %b57
b54.e105:
  br label %b58
b55:
  %v394 = getelementptr i64, ptr @"rt.meta", i64 0
  %st105 = getelementptr i64, ptr %v394, i64 0
  store i64 %v322, ptr %st105
  br label %b52
b56:
  %v395 = getelementptr i64, ptr @"rt.meta", i64 0
  %st106 = getelementptr i64, ptr %v395, i64 0
  store i64 %v327, ptr %st106
  %v368 = add i64 0, 1
  %v369.p = getelementptr i64, ptr %v321, i64 0
  %v369 = load i64, ptr %v369.p
  %v370 = add i64 %v369, %v368
  %st107 = getelementptr i64, ptr %v321, i64 0
  store i64 %v370, ptr %st107
  br label %b53
b57:
  %v336 = add i64 0, 79
  call void @"rt.panic"(i64 %v336)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b58:
  %v337.p = getelementptr i64, ptr %v184, i64 0
  %v337 = load i64, ptr %v337.p
  %v338 = inttoptr i64 %v337 to ptr
  %v339 = add i64 0, 1
  %v340 = mul i64 %v326, %v339
  %v341 = getelementptr i64, ptr %v338, i64 %v340
  %v342.p = getelementptr i64, ptr %v341, i64 0
  %v342 = load i64, ptr %v342.p
  %v343 = add i64 0, 256
  %v344.c = icmp uge i64 %v342, %v343
  %v344 = zext i1 %v344.c to i64
  %c.b58 = icmp ne i64 %v344, 0
  br i1 %c.b58, label %b58.t109, label %b58.e110
b58.t109:
  br label %b59
b58.e110:
  br label %b60
b59:
  %v345 = add i64 0, 80
  call void @"rt.panic"(i64 %v345)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b60:
  %v346.p = getelementptr i64, ptr %v330, i64 2
  %v346 = load i64, ptr %v346.p
  %v347.p = getelementptr i64, ptr %v330, i64 0
  %v347 = load i64, ptr %v347.p
  %v348.p = getelementptr i64, ptr %v330, i64 1
  %v348 = load i64, ptr %v348.p
  %v351 = add i64 %v347, %v348
  %v352 = call i64 @"rt.tip8"(i64 %v346, i64 %v351)
  %v353 = add i64 0, 0
  %v354.c = icmp ne i64 %v352, %v353
  %v354 = zext i1 %v354.c to i64
  %c.b60 = icmp ne i64 %v354, 0
  br i1 %c.b60, label %b60.t111, label %b60.e112
b60.t111:
  br label %b63
b60.e112:
  br label %b62
b61:
  %v349 = phi ptr [ %v358, %b62 ], [ %v355, %b63 ]
  %v350 = phi ptr [ %v359, %b62 ], [ %v356, %b63 ]
  %st112 = getelementptr i8, ptr %v350, i64 0
  %st112.b = trunc i64 %v342 to i8
  store i8 %st112.b, ptr %st112
  %v360.p = getelementptr i64, ptr %v330, i64 1
  %v360 = load i64, ptr %v360.p
  %v361 = add i64 0, 1
  %v362 = add i64 %v360, %v361
  %v363 = getelementptr i64, ptr %s8, i64 0
  %v364 = ptrtoint ptr %v349 to i64
  %st113 = getelementptr i64, ptr %v363, i64 0
  store i64 %v364, ptr %st113
  %st114 = getelementptr i64, ptr %v363, i64 1
  store i64 %v362, ptr %st114
  %st115 = getelementptr i64, ptr %v363, i64 2
  store i64 %v346, ptr %st115
  %v365.p = getelementptr i64, ptr %v363, i64 0
  %v365 = load i64, ptr %v365.p
  %st116 = getelementptr i64, ptr %v312, i64 0
  store i64 %v365, ptr %st116
  %v366.p = getelementptr i64, ptr %v363, i64 1
  %v366 = load i64, ptr %v366.p
  %st117 = getelementptr i64, ptr %v312, i64 1
  store i64 %v366, ptr %st117
  %v367.p = getelementptr i64, ptr %v363, i64 2
  %v367 = load i64, ptr %v367.p
  %st118 = getelementptr i64, ptr %v312, i64 2
  store i64 %v367, ptr %st118
  br label %b56
b62:
  %v357 = add i64 0, 1
  %v358 = call ptr @"rt.slice_grow8"(i64 %v347, i64 %v348, i64 %v346, i64 %v357)
  %v359 = getelementptr i8, ptr %v358, i64 %v348
  br label %b61
b63:
  %v355 = inttoptr i64 %v347 to ptr
  %v356 = getelementptr i8, ptr %v355, i64 %v348
  br label %b61
}

define internal void @"std/hex.Format"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s6 = alloca [3 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v133 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v133, i64 0
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
  %v16 = getelementptr i64, ptr @"str.17", i64 0
  %v17 = add i64 0, 16
  %v18 = add i64 0, 0
  %v19 = getelementptr i64, ptr %s1, i64 0
  %v20 = ptrtoint ptr %v16 to i64
  %st4 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st4
  %st5 = getelementptr i64, ptr %v19, i64 1
  store i64 %v17, ptr %st5
  %st6 = getelementptr i64, ptr %v19, i64 2
  store i64 %v18, ptr %st6
  %v21 = getelementptr i64, ptr %s2, i64 0
  %v22.p = getelementptr i64, ptr %v19, i64 0
  %v22 = load i64, ptr %v22.p
  %st7 = getelementptr i64, ptr %v21, i64 0
  store i64 %v22, ptr %st7
  %v23.p = getelementptr i64, ptr %v19, i64 1
  %v23 = load i64, ptr %v23.p
  %st8 = getelementptr i64, ptr %v21, i64 1
  store i64 %v23, ptr %st8
  %v24.p = getelementptr i64, ptr %v19, i64 2
  %v24 = load i64, ptr %v24.p
  %st9 = getelementptr i64, ptr %v21, i64 2
  store i64 %v24, ptr %st9
  %v25 = add i64 0, 0
  %v26 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v25)
  %v27 = add i64 0, 0
  %v28 = getelementptr i64, ptr %s1, i64 0
  %v29 = ptrtoint ptr %v26 to i64
  %st10 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st10
  %st11 = getelementptr i64, ptr %v28, i64 1
  store i64 %v27, ptr %st11
  %st12 = getelementptr i64, ptr %v28, i64 2
  store i64 %v15, ptr %st12
  %v30 = getelementptr i64, ptr %s3, i64 0
  %v31.p = getelementptr i64, ptr %v28, i64 0
  %v31 = load i64, ptr %v31.p
  %st13 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st13
  %v32.p = getelementptr i64, ptr %v28, i64 1
  %v32 = load i64, ptr %v32.p
  %st14 = getelementptr i64, ptr %v30, i64 1
  store i64 %v32, ptr %st14
  %v33.p = getelementptr i64, ptr %v28, i64 2
  %v33 = load i64, ptr %v33.p
  %st15 = getelementptr i64, ptr %v30, i64 2
  store i64 %v33, ptr %st15
  %v134 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v134, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 0
  %v36.p = getelementptr i64, ptr %v4, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = getelementptr i64, ptr %s4, i64 0
  %v135 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v135, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = getelementptr i64, ptr %s5, i64 0
  %st16 = getelementptr i64, ptr %v39, i64 0
  store i64 %v35, ptr %st16
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v136, i64 0
  %v40 = load i64, ptr %v40.p
  br label %b3
b1:
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v137, i64 0
  store i64 %v34, ptr %st17
  %v130.p = getelementptr i64, ptr %v30, i64 0
  %v130 = load i64, ptr %v130.p
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v130, ptr %st18
  %v131.p = getelementptr i64, ptr %v30, i64 1
  %v131 = load i64, ptr %v131.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v131, ptr %st19
  %v132.p = getelementptr i64, ptr %v30, i64 2
  %v132 = load i64, ptr %v132.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v132, ptr %st20
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v138, i64 0
  store i64 %v5, ptr %st21
  ret void
b2:
  br label %b1
b3:
  %v139 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v139, i64 0
  store i64 %v40, ptr %st22
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.c = icmp slt i64 %v41, %v36
  %v42 = zext i1 %v42.c to i64
  %c.b3 = icmp ne i64 %v42, 0
  br i1 %c.b3, label %b3.t24, label %b3.e25
b3.t24:
  br label %b4
b3.e25:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v140 = getelementptr i64, ptr @"rt.meta", i64 0
  %v43.p = getelementptr i64, ptr %v140, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v39, i64 0
  %v44 = load i64, ptr %v44.p
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v45.p = getelementptr i64, ptr %v141, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v4, i64 1
  %v46 = load i64, ptr %v46.p
  %v47.c = icmp uge i64 %v44, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b4 = icmp ne i64 %v47, 0
  br i1 %c.b4, label %b4.t26, label %b4.e27
b4.t26:
  br label %b7
b4.e27:
  br label %b8
b5:
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v142, i64 0
  store i64 %v40, ptr %st27
  br label %b2
b6:
  %v143 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v143, i64 0
  store i64 %v45, ptr %st28
  %v127 = add i64 0, 1
  %v128.p = getelementptr i64, ptr %v39, i64 0
  %v128 = load i64, ptr %v128.p
  %v129 = add i64 %v128, %v127
  %st29 = getelementptr i64, ptr %v39, i64 0
  store i64 %v129, ptr %st29
  br label %b3
b7:
  %v48 = add i64 0, 81
  call void @"rt.panic"(i64 %v48)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v49.p = getelementptr i64, ptr %v4, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = inttoptr i64 %v49 to ptr
  %v51 = getelementptr i8, ptr %v50, i64 %v44
  %v52.p = getelementptr i8, ptr %v51, i64 0
  %v52.b = load i8, ptr %v52.p
  %v52 = zext i8 %v52.b to i64
  %v53 = add i64 0, 1
  %v54 = add i64 %v5, %v53
  %v55 = getelementptr i64, ptr %s1, i64 0
  %v56.p = getelementptr i64, ptr %v30, i64 0
  %v56 = load i64, ptr %v56.p
  %st30 = getelementptr i64, ptr %v55, i64 0
  store i64 %v56, ptr %st30
  %v57.p = getelementptr i64, ptr %v30, i64 1
  %v57 = load i64, ptr %v57.p
  %st31 = getelementptr i64, ptr %v55, i64 1
  store i64 %v57, ptr %st31
  %v58.p = getelementptr i64, ptr %v30, i64 2
  %v58 = load i64, ptr %v58.p
  %st32 = getelementptr i64, ptr %v55, i64 2
  store i64 %v58, ptr %st32
  %v59 = add i64 0, 4
  %v60.n = and i64 %v59, 63
  %v60 = ashr i64 %v52, %v60.n
  %v61.p = getelementptr i64, ptr %v21, i64 1
  %v61 = load i64, ptr %v61.p
  %v62.c = icmp uge i64 %v60, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b8 = icmp ne i64 %v62, 0
  br i1 %c.b8, label %b8.t34, label %b8.e35
b8.t34:
  br label %b9
b8.e35:
  br label %b10
b9:
  %v63 = add i64 0, 82
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v64.p = getelementptr i64, ptr %v21, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = inttoptr i64 %v64 to ptr
  %v66 = getelementptr i8, ptr %v65, i64 %v60
  %v67.p = getelementptr i8, ptr %v66, i64 0
  %v67.b = load i8, ptr %v67.p
  %v67 = zext i8 %v67.b to i64
  %v68.p = getelementptr i64, ptr %v55, i64 2
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v55, i64 0
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v55, i64 1
  %v70 = load i64, ptr %v70.p
  %v73 = add i64 %v69, %v70
  %v74 = call i64 @"rt.tip8"(i64 %v68, i64 %v73)
  %v75 = add i64 0, 0
  %v76.c = icmp ne i64 %v74, %v75
  %v76 = zext i1 %v76.c to i64
  %c.b10 = icmp ne i64 %v76, 0
  br i1 %c.b10, label %b10.t36, label %b10.e37
b10.t36:
  br label %b13
b10.e37:
  br label %b12
b11:
  %v71 = phi ptr [ %v80, %b12 ], [ %v77, %b13 ]
  %v72 = phi ptr [ %v81, %b12 ], [ %v78, %b13 ]
  %st37 = getelementptr i8, ptr %v72, i64 0
  %st37.b = trunc i64 %v67 to i8
  store i8 %st37.b, ptr %st37
  %v82.p = getelementptr i64, ptr %v55, i64 1
  %v82 = load i64, ptr %v82.p
  %v83 = add i64 0, 1
  %v84 = add i64 %v82, %v83
  %v85 = getelementptr i64, ptr %s6, i64 0
  %v86 = ptrtoint ptr %v71 to i64
  %st38 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st38
  %st39 = getelementptr i64, ptr %v85, i64 1
  store i64 %v84, ptr %st39
  %st40 = getelementptr i64, ptr %v85, i64 2
  store i64 %v68, ptr %st40
  %v87.p = getelementptr i64, ptr %v85, i64 0
  %v87 = load i64, ptr %v87.p
  %st41 = getelementptr i64, ptr %v30, i64 0
  store i64 %v87, ptr %st41
  %v88.p = getelementptr i64, ptr %v85, i64 1
  %v88 = load i64, ptr %v88.p
  %st42 = getelementptr i64, ptr %v30, i64 1
  store i64 %v88, ptr %st42
  %v89.p = getelementptr i64, ptr %v85, i64 2
  %v89 = load i64, ptr %v89.p
  %st43 = getelementptr i64, ptr %v30, i64 2
  store i64 %v89, ptr %st43
  %v90 = add i64 0, 1
  %v91 = add i64 %v5, %v90
  %v92 = getelementptr i64, ptr %s6, i64 0
  %v93.p = getelementptr i64, ptr %v30, i64 0
  %v93 = load i64, ptr %v93.p
  %st44 = getelementptr i64, ptr %v92, i64 0
  store i64 %v93, ptr %st44
  %v94.p = getelementptr i64, ptr %v30, i64 1
  %v94 = load i64, ptr %v94.p
  %st45 = getelementptr i64, ptr %v92, i64 1
  store i64 %v94, ptr %st45
  %v95.p = getelementptr i64, ptr %v30, i64 2
  %v95 = load i64, ptr %v95.p
  %st46 = getelementptr i64, ptr %v92, i64 2
  store i64 %v95, ptr %st46
  %v96 = add i64 0, 15
  %v97 = and i64 %v52, %v96
  %v98.p = getelementptr i64, ptr %v21, i64 1
  %v98 = load i64, ptr %v98.p
  %v99.c = icmp uge i64 %v97, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b11 = icmp ne i64 %v99, 0
  br i1 %c.b11, label %b11.t48, label %b11.e49
b11.t48:
  br label %b14
b11.e49:
  br label %b15
b12:
  %v79 = add i64 0, 1
  %v80 = call ptr @"rt.slice_grow8"(i64 %v69, i64 %v70, i64 %v68, i64 %v79)
  %v81 = getelementptr i8, ptr %v80, i64 %v70
  br label %b11
b13:
  %v77 = inttoptr i64 %v69 to ptr
  %v78 = getelementptr i8, ptr %v77, i64 %v70
  br label %b11
b14:
  %v100 = add i64 0, 83
  call void @"rt.panic"(i64 %v100)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v101.p = getelementptr i64, ptr %v21, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = inttoptr i64 %v101 to ptr
  %v103 = getelementptr i8, ptr %v102, i64 %v97
  %v104.p = getelementptr i8, ptr %v103, i64 0
  %v104.b = load i8, ptr %v104.p
  %v104 = zext i8 %v104.b to i64
  %v105.p = getelementptr i64, ptr %v92, i64 2
  %v105 = load i64, ptr %v105.p
  %v106.p = getelementptr i64, ptr %v92, i64 0
  %v106 = load i64, ptr %v106.p
  %v107.p = getelementptr i64, ptr %v92, i64 1
  %v107 = load i64, ptr %v107.p
  %v110 = add i64 %v106, %v107
  %v111 = call i64 @"rt.tip8"(i64 %v105, i64 %v110)
  %v112 = add i64 0, 0
  %v113.c = icmp ne i64 %v111, %v112
  %v113 = zext i1 %v113.c to i64
  %c.b15 = icmp ne i64 %v113, 0
  br i1 %c.b15, label %b15.t50, label %b15.e51
b15.t50:
  br label %b18
b15.e51:
  br label %b17
b16:
  %v108 = phi ptr [ %v117, %b17 ], [ %v114, %b18 ]
  %v109 = phi ptr [ %v118, %b17 ], [ %v115, %b18 ]
  %st51 = getelementptr i8, ptr %v109, i64 0
  %st51.b = trunc i64 %v104 to i8
  store i8 %st51.b, ptr %st51
  %v119.p = getelementptr i64, ptr %v92, i64 1
  %v119 = load i64, ptr %v119.p
  %v120 = add i64 0, 1
  %v121 = add i64 %v119, %v120
  %v122 = getelementptr i64, ptr %s1, i64 0
  %v123 = ptrtoint ptr %v108 to i64
  %st52 = getelementptr i64, ptr %v122, i64 0
  store i64 %v123, ptr %st52
  %st53 = getelementptr i64, ptr %v122, i64 1
  store i64 %v121, ptr %st53
  %st54 = getelementptr i64, ptr %v122, i64 2
  store i64 %v105, ptr %st54
  %v124.p = getelementptr i64, ptr %v122, i64 0
  %v124 = load i64, ptr %v124.p
  %st55 = getelementptr i64, ptr %v30, i64 0
  store i64 %v124, ptr %st55
  %v125.p = getelementptr i64, ptr %v122, i64 1
  %v125 = load i64, ptr %v125.p
  %st56 = getelementptr i64, ptr %v30, i64 1
  store i64 %v125, ptr %st56
  %v126.p = getelementptr i64, ptr %v122, i64 2
  %v126 = load i64, ptr %v126.p
  %st57 = getelementptr i64, ptr %v30, i64 2
  store i64 %v126, ptr %st57
  br label %b6
b17:
  %v116 = add i64 0, 1
  %v117 = call ptr @"rt.slice_grow8"(i64 %v106, i64 %v107, i64 %v105, i64 %v116)
  %v118 = getelementptr i8, ptr %v117, i64 %v107
  br label %b16
b18:
  %v114 = inttoptr i64 %v106 to ptr
  %v115 = getelementptr i8, ptr %v114, i64 %v107
  br label %b16
}

define internal void @"std/hex.Parse"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s3 = alloca [4 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s3.z1 = getelementptr i64, ptr %s3, i64 1
  store i64 0, ptr %s3.z1
  %s3.z2 = getelementptr i64, ptr %s3, i64 2
  store i64 0, ptr %s3.z2
  %s3.z3 = getelementptr i64, ptr %s3, i64 3
  store i64 0, ptr %s3.z3
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
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v188 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v188, i64 0
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
  %v20.p = getelementptr i64, ptr %v16, i64 1
  %v20 = load i64, ptr %v20.p
  %v21 = add i64 0, 2
  %v22 = srem i64 %v20, %v21
  %v23 = add i64 0, 0
  %v24.c = icmp ne i64 %v22, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b0 = icmp ne i64 %v24, 0
  br i1 %c.b0, label %b0.t8, label %b0.e9
b0.t8:
  br label %b1
b0.e9:
  br label %b2
b1:
  %v25 = add i64 0, 0
  %v26 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v25)
  %v27 = add i64 0, 0
  %v28 = getelementptr i64, ptr %s2, i64 0
  %v29 = ptrtoint ptr %v26 to i64
  %st9 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st9
  %st10 = getelementptr i64, ptr %v28, i64 1
  store i64 %v27, ptr %st10
  %st11 = getelementptr i64, ptr %v28, i64 2
  store i64 %v15, ptr %st11
  %v30 = add i64 0, 0
  %v31 = add i64 0, 0
  %v32 = add i64 0, 0
  %v33 = add i64 0, 0
  %v34 = add i64 0, 0
  %v35 = getelementptr i64, ptr %s3, i64 0
  %st12 = getelementptr i64, ptr %v35, i64 0
  store i64 %v34, ptr %st12
  %st13 = getelementptr i64, ptr %v35, i64 1
  store i64 %v31, ptr %st13
  %st14 = getelementptr i64, ptr %v35, i64 2
  store i64 %v32, ptr %st14
  %st15 = getelementptr i64, ptr %v35, i64 3
  store i64 %v33, ptr %st15
  %v36 = getelementptr i64, ptr %s4, i64 0
  %v37 = add i64 0, 1
  %st16 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st16
  %v38.p = getelementptr i64, ptr %v35, i64 0
  %v38 = load i64, ptr %v38.p
  %st17 = getelementptr i64, ptr %v36, i64 1
  store i64 %v38, ptr %st17
  %v39.p = getelementptr i64, ptr %v35, i64 1
  %v39 = load i64, ptr %v39.p
  %st18 = getelementptr i64, ptr %v36, i64 2
  store i64 %v39, ptr %st18
  %v40.p = getelementptr i64, ptr %v35, i64 2
  %v40 = load i64, ptr %v40.p
  %st19 = getelementptr i64, ptr %v36, i64 3
  store i64 %v40, ptr %st19
  %v41.p = getelementptr i64, ptr %v35, i64 3
  %v41 = load i64, ptr %v41.p
  %st20 = getelementptr i64, ptr %v36, i64 4
  store i64 %v41, ptr %st20
  %v42.p = getelementptr i64, ptr %v28, i64 0
  %v42 = load i64, ptr %v42.p
  %st21 = getelementptr i64, ptr %v0, i64 0
  store i64 %v42, ptr %st21
  %v43.p = getelementptr i64, ptr %v28, i64 1
  %v43 = load i64, ptr %v43.p
  %st22 = getelementptr i64, ptr %v0, i64 1
  store i64 %v43, ptr %st22
  %v44.p = getelementptr i64, ptr %v28, i64 2
  %v44 = load i64, ptr %v44.p
  %st23 = getelementptr i64, ptr %v0, i64 2
  store i64 %v44, ptr %st23
  %v45.p = getelementptr i64, ptr %v36, i64 0
  %v45 = load i64, ptr %v45.p
  %st24 = getelementptr i64, ptr %v0, i64 3
  store i64 %v45, ptr %st24
  %v46.p = getelementptr i64, ptr %v36, i64 1
  %v46 = load i64, ptr %v46.p
  %st25 = getelementptr i64, ptr %v0, i64 4
  store i64 %v46, ptr %st25
  %v47.p = getelementptr i64, ptr %v36, i64 2
  %v47 = load i64, ptr %v47.p
  %st26 = getelementptr i64, ptr %v0, i64 5
  store i64 %v47, ptr %st26
  %v48.p = getelementptr i64, ptr %v36, i64 3
  %v48 = load i64, ptr %v48.p
  %st27 = getelementptr i64, ptr %v0, i64 6
  store i64 %v48, ptr %st27
  %v49.p = getelementptr i64, ptr %v36, i64 4
  %v49 = load i64, ptr %v49.p
  %st28 = getelementptr i64, ptr %v0, i64 7
  store i64 %v49, ptr %st28
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v50.p = getelementptr i64, ptr %v0, i64 3
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 0
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b1 = icmp ne i64 %v52, 0
  br i1 %c.b1, label %b1.t30, label %b1.e31
b1.t30:
  br label %b3
b1.e31:
  br label %b4
b2:
  br label %b5
b3:
  %v53 = add i64 0, 4
  %v54 = getelementptr i64, ptr %v0, i64 %v53
  call void @"rt.err_relocate"(ptr %v54, i64 %v5)
  br label %b4
b4:
  %v189 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v189, i64 0
  store i64 %v5, ptr %st31
  ret void
b5:
  %v55 = add i64 0, 0
  %v56 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v55)
  %v57 = add i64 0, 0
  %v58 = getelementptr i64, ptr %s2, i64 0
  %v59 = ptrtoint ptr %v56 to i64
  %st32 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st32
  %st33 = getelementptr i64, ptr %v58, i64 1
  store i64 %v57, ptr %st33
  %st34 = getelementptr i64, ptr %v58, i64 2
  store i64 %v15, ptr %st34
  %v60 = getelementptr i64, ptr %s5, i64 0
  %v61.p = getelementptr i64, ptr %v58, i64 0
  %v61 = load i64, ptr %v61.p
  %st35 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st35
  %v62.p = getelementptr i64, ptr %v58, i64 1
  %v62 = load i64, ptr %v62.p
  %st36 = getelementptr i64, ptr %v60, i64 1
  store i64 %v62, ptr %st36
  %v63.p = getelementptr i64, ptr %v58, i64 2
  %v63 = load i64, ptr %v63.p
  %st37 = getelementptr i64, ptr %v60, i64 2
  store i64 %v63, ptr %st37
  %v190 = getelementptr i64, ptr @"rt.meta", i64 0
  %v64.p = getelementptr i64, ptr %v190, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 0
  %v66.p = getelementptr i64, ptr %v16, i64 1
  %v66 = load i64, ptr %v66.p
  %v67 = add i64 0, 2
  %v68 = sdiv i64 %v66, %v67
  %v69 = getelementptr i64, ptr %s6, i64 0
  %v191 = getelementptr i64, ptr @"rt.meta", i64 0
  %v70.p = getelementptr i64, ptr %v191, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = getelementptr i64, ptr %s7, i64 0
  %st38 = getelementptr i64, ptr %v71, i64 0
  store i64 %v65, ptr %st38
  %v192 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v192, i64 0
  %v72 = load i64, ptr %v72.p
  br label %b8
b6:
  %v193 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v193, i64 0
  store i64 %v64, ptr %st39
  %v173 = getelementptr i64, ptr %s4, i64 0
  %v174 = add i64 0, 0
  %st40 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st40
  %v175.p = getelementptr i64, ptr %v60, i64 0
  %v175 = load i64, ptr %v175.p
  %st41 = getelementptr i64, ptr %v0, i64 0
  store i64 %v175, ptr %st41
  %v176.p = getelementptr i64, ptr %v60, i64 1
  %v176 = load i64, ptr %v176.p
  %st42 = getelementptr i64, ptr %v0, i64 1
  store i64 %v176, ptr %st42
  %v177.p = getelementptr i64, ptr %v60, i64 2
  %v177 = load i64, ptr %v177.p
  %st43 = getelementptr i64, ptr %v0, i64 2
  store i64 %v177, ptr %st43
  %v178.p = getelementptr i64, ptr %v173, i64 0
  %v178 = load i64, ptr %v178.p
  %st44 = getelementptr i64, ptr %v0, i64 3
  store i64 %v178, ptr %st44
  %v179.p = getelementptr i64, ptr %v173, i64 1
  %v179 = load i64, ptr %v179.p
  %st45 = getelementptr i64, ptr %v0, i64 4
  store i64 %v179, ptr %st45
  %v180.p = getelementptr i64, ptr %v173, i64 2
  %v180 = load i64, ptr %v180.p
  %st46 = getelementptr i64, ptr %v0, i64 5
  store i64 %v180, ptr %st46
  %v181.p = getelementptr i64, ptr %v173, i64 3
  %v181 = load i64, ptr %v181.p
  %st47 = getelementptr i64, ptr %v0, i64 6
  store i64 %v181, ptr %st47
  %v182.p = getelementptr i64, ptr %v173, i64 4
  %v182 = load i64, ptr %v182.p
  %st48 = getelementptr i64, ptr %v0, i64 7
  store i64 %v182, ptr %st48
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v183.p = getelementptr i64, ptr %v0, i64 3
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 0
  %v185.c = icmp ne i64 %v183, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b6 = icmp ne i64 %v185, 0
  br i1 %c.b6, label %b6.t50, label %b6.e51
b6.t50:
  br label %b28
b6.e51:
  br label %b29
b7:
  br label %b6
b8:
  %v194 = getelementptr i64, ptr @"rt.meta", i64 0
  %st51 = getelementptr i64, ptr %v194, i64 0
  store i64 %v72, ptr %st51
  %v73.p = getelementptr i64, ptr %v71, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.c = icmp slt i64 %v73, %v68
  %v74 = zext i1 %v74.c to i64
  %c.b8 = icmp ne i64 %v74, 0
  br i1 %c.b8, label %b8.t53, label %b8.e54
b8.t53:
  br label %b9
b8.e54:
  br label %b10
b9:
  call void @"rt.region_enter"()
  %v195 = getelementptr i64, ptr @"rt.meta", i64 0
  %v75.p = getelementptr i64, ptr %v195, i64 0
  %v75 = load i64, ptr %v75.p
  %v76.p = getelementptr i64, ptr %v71, i64 0
  %v76 = load i64, ptr %v76.p
  %v196 = getelementptr i64, ptr @"rt.meta", i64 0
  %v77.p = getelementptr i64, ptr %v196, i64 0
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 2
  %v79 = mul i64 %v78, %v76
  %v80.p = getelementptr i64, ptr %v16, i64 1
  %v80 = load i64, ptr %v80.p
  %v81.c = icmp uge i64 %v79, %v80
  %v81 = zext i1 %v81.c to i64
  %c.b9 = icmp ne i64 %v81, 0
  br i1 %c.b9, label %b9.t55, label %b9.e56
b9.t55:
  br label %b12
b9.e56:
  br label %b13
b10:
  %v197 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v197, i64 0
  store i64 %v72, ptr %st56
  br label %b7
b11:
  %v198 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v198, i64 0
  store i64 %v77, ptr %st57
  %v170 = add i64 0, 1
  %v171.p = getelementptr i64, ptr %v71, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = add i64 %v171, %v170
  %st58 = getelementptr i64, ptr %v71, i64 0
  store i64 %v172, ptr %st58
  br label %b8
b12:
  %v82 = add i64 0, 84
  call void @"rt.panic"(i64 %v82)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v83.p = getelementptr i64, ptr %v16, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = inttoptr i64 %v83 to ptr
  %v85 = getelementptr i8, ptr %v84, i64 %v79
  %v86.p = getelementptr i8, ptr %v85, i64 0
  %v86.b = load i8, ptr %v86.p
  %v86 = zext i8 %v86.b to i64
  %v87 = call i64 @"std/hex.nib"(i64 %v86)
  %v88 = add i64 0, 2
  %v89 = mul i64 %v88, %v76
  %v90 = add i64 0, 1
  %v91 = add i64 %v89, %v90
  %v92.p = getelementptr i64, ptr %v16, i64 1
  %v92 = load i64, ptr %v92.p
  %v93.c = icmp uge i64 %v91, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b13 = icmp ne i64 %v93, 0
  br i1 %c.b13, label %b13.t60, label %b13.e61
b13.t60:
  br label %b14
b13.e61:
  br label %b15
b14:
  %v94 = add i64 0, 85
  call void @"rt.panic"(i64 %v94)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v95.p = getelementptr i64, ptr %v16, i64 0
  %v95 = load i64, ptr %v95.p
  %v96 = inttoptr i64 %v95 to ptr
  %v97 = getelementptr i8, ptr %v96, i64 %v91
  %v98.p = getelementptr i8, ptr %v97, i64 0
  %v98.b = load i8, ptr %v98.p
  %v98 = zext i8 %v98.b to i64
  %v99 = call i64 @"std/hex.nib"(i64 %v98)
  %v100 = add i64 0, 0
  %v101.c = icmp slt i64 %v87, %v100
  %v101 = zext i1 %v101.c to i64
  %c.b15 = icmp ne i64 %v101, 0
  br i1 %c.b15, label %b15.t62, label %b15.e63
b15.t62:
  br label %b17
b15.e63:
  br label %b16
b16:
  %v103 = add i64 0, 0
  %v104.c = icmp slt i64 %v99, %v103
  %v104 = zext i1 %v104.c to i64
  br label %b17
b17:
  %v102 = phi i64 [ %v101, %b15.t62 ], [ %v104, %b16 ]
  %c.b17 = icmp ne i64 %v102, 0
  br i1 %c.b17, label %b17.t64, label %b17.e65
b17.t64:
  br label %b18
b17.e65:
  br label %b19
b18:
  %v199 = getelementptr i64, ptr @"rt.meta", i64 0
  %v105.p = getelementptr i64, ptr %v199, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = add i64 0, 0
  %v107 = call ptr @"rt.region_alloc8"(i64 %v105, i64 %v106)
  %v108 = add i64 0, 0
  %v109 = getelementptr i64, ptr %s2, i64 0
  %v110 = ptrtoint ptr %v107 to i64
  %st65 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st65
  %st66 = getelementptr i64, ptr %v109, i64 1
  store i64 %v108, ptr %st66
  %st67 = getelementptr i64, ptr %v109, i64 2
  store i64 %v105, ptr %st67
  %v111 = add i64 0, 0
  %v112 = add i64 0, 0
  %v113 = add i64 0, 0
  %v114 = add i64 0, 0
  %v115 = add i64 0, 0
  %v116 = getelementptr i64, ptr %s3, i64 0
  %st68 = getelementptr i64, ptr %v116, i64 0
  store i64 %v115, ptr %st68
  %st69 = getelementptr i64, ptr %v116, i64 1
  store i64 %v112, ptr %st69
  %st70 = getelementptr i64, ptr %v116, i64 2
  store i64 %v113, ptr %st70
  %st71 = getelementptr i64, ptr %v116, i64 3
  store i64 %v114, ptr %st71
  %v117 = getelementptr i64, ptr %s4, i64 0
  %v118 = add i64 0, 1
  %st72 = getelementptr i64, ptr %v117, i64 0
  store i64 %v118, ptr %st72
  %v119.p = getelementptr i64, ptr %v116, i64 0
  %v119 = load i64, ptr %v119.p
  %st73 = getelementptr i64, ptr %v117, i64 1
  store i64 %v119, ptr %st73
  %v120.p = getelementptr i64, ptr %v116, i64 1
  %v120 = load i64, ptr %v120.p
  %st74 = getelementptr i64, ptr %v117, i64 2
  store i64 %v120, ptr %st74
  %v121.p = getelementptr i64, ptr %v116, i64 2
  %v121 = load i64, ptr %v121.p
  %st75 = getelementptr i64, ptr %v117, i64 3
  store i64 %v121, ptr %st75
  %v122.p = getelementptr i64, ptr %v116, i64 3
  %v122 = load i64, ptr %v122.p
  %st76 = getelementptr i64, ptr %v117, i64 4
  store i64 %v122, ptr %st76
  %v123.p = getelementptr i64, ptr %v109, i64 0
  %v123 = load i64, ptr %v123.p
  %st77 = getelementptr i64, ptr %v0, i64 0
  store i64 %v123, ptr %st77
  %v124.p = getelementptr i64, ptr %v109, i64 1
  %v124 = load i64, ptr %v124.p
  %st78 = getelementptr i64, ptr %v0, i64 1
  store i64 %v124, ptr %st78
  %v125.p = getelementptr i64, ptr %v109, i64 2
  %v125 = load i64, ptr %v125.p
  %st79 = getelementptr i64, ptr %v0, i64 2
  store i64 %v125, ptr %st79
  %v126.p = getelementptr i64, ptr %v117, i64 0
  %v126 = load i64, ptr %v126.p
  %st80 = getelementptr i64, ptr %v0, i64 3
  store i64 %v126, ptr %st80
  %v127.p = getelementptr i64, ptr %v117, i64 1
  %v127 = load i64, ptr %v127.p
  %st81 = getelementptr i64, ptr %v0, i64 4
  store i64 %v127, ptr %st81
  %v128.p = getelementptr i64, ptr %v117, i64 2
  %v128 = load i64, ptr %v128.p
  %st82 = getelementptr i64, ptr %v0, i64 5
  store i64 %v128, ptr %st82
  %v129.p = getelementptr i64, ptr %v117, i64 3
  %v129 = load i64, ptr %v129.p
  %st83 = getelementptr i64, ptr %v0, i64 6
  store i64 %v129, ptr %st83
  %v130.p = getelementptr i64, ptr %v117, i64 4
  %v130 = load i64, ptr %v130.p
  %st84 = getelementptr i64, ptr %v0, i64 7
  store i64 %v130, ptr %st84
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v131.p = getelementptr i64, ptr %v0, i64 3
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 0, 0
  %v133.c = icmp ne i64 %v131, %v132
  %v133 = zext i1 %v133.c to i64
  %c.b18 = icmp ne i64 %v133, 0
  br i1 %c.b18, label %b18.t86, label %b18.e87
b18.t86:
  br label %b20
b18.e87:
  br label %b21
b19:
  br label %b22
b20:
  %v134 = add i64 0, 4
  %v135 = getelementptr i64, ptr %v0, i64 %v134
  call void @"rt.err_relocate"(ptr %v135, i64 %v5)
  br label %b21
b21:
  %v200 = getelementptr i64, ptr @"rt.meta", i64 0
  %st87 = getelementptr i64, ptr %v200, i64 0
  store i64 %v5, ptr %st87
  ret void
b22:
  %v136 = add i64 0, 1
  %v137 = add i64 %v5, %v136
  %v138 = getelementptr i64, ptr %s2, i64 0
  %v139.p = getelementptr i64, ptr %v60, i64 0
  %v139 = load i64, ptr %v139.p
  %st88 = getelementptr i64, ptr %v138, i64 0
  store i64 %v139, ptr %st88
  %v140.p = getelementptr i64, ptr %v60, i64 1
  %v140 = load i64, ptr %v140.p
  %st89 = getelementptr i64, ptr %v138, i64 1
  store i64 %v140, ptr %st89
  %v141.p = getelementptr i64, ptr %v60, i64 2
  %v141 = load i64, ptr %v141.p
  %st90 = getelementptr i64, ptr %v138, i64 2
  store i64 %v141, ptr %st90
  %v142 = add i64 0, 16
  %v143 = mul i64 %v87, %v142
  %v144 = add i64 %v143, %v99
  %v145 = add i64 0, 256
  %v146.c = icmp uge i64 %v144, %v145
  %v146 = zext i1 %v146.c to i64
  %c.b22 = icmp ne i64 %v146, 0
  br i1 %c.b22, label %b22.t92, label %b22.e93
b22.t92:
  br label %b23
b22.e93:
  br label %b24
b23:
  %v147 = add i64 0, 86
  call void @"rt.panic"(i64 %v147)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b24:
  %v148.p = getelementptr i64, ptr %v138, i64 2
  %v148 = load i64, ptr %v148.p
  %v149.p = getelementptr i64, ptr %v138, i64 0
  %v149 = load i64, ptr %v149.p
  %v150.p = getelementptr i64, ptr %v138, i64 1
  %v150 = load i64, ptr %v150.p
  %v153 = add i64 %v149, %v150
  %v154 = call i64 @"rt.tip8"(i64 %v148, i64 %v153)
  %v155 = add i64 0, 0
  %v156.c = icmp ne i64 %v154, %v155
  %v156 = zext i1 %v156.c to i64
  %c.b24 = icmp ne i64 %v156, 0
  br i1 %c.b24, label %b24.t94, label %b24.e95
b24.t94:
  br label %b27
b24.e95:
  br label %b26
b25:
  %v151 = phi ptr [ %v160, %b26 ], [ %v157, %b27 ]
  %v152 = phi ptr [ %v161, %b26 ], [ %v158, %b27 ]
  %st95 = getelementptr i8, ptr %v152, i64 0
  %st95.b = trunc i64 %v144 to i8
  store i8 %st95.b, ptr %st95
  %v162.p = getelementptr i64, ptr %v138, i64 1
  %v162 = load i64, ptr %v162.p
  %v163 = add i64 0, 1
  %v164 = add i64 %v162, %v163
  %v165 = getelementptr i64, ptr %s8, i64 0
  %v166 = ptrtoint ptr %v151 to i64
  %st96 = getelementptr i64, ptr %v165, i64 0
  store i64 %v166, ptr %st96
  %st97 = getelementptr i64, ptr %v165, i64 1
  store i64 %v164, ptr %st97
  %st98 = getelementptr i64, ptr %v165, i64 2
  store i64 %v148, ptr %st98
  %v167.p = getelementptr i64, ptr %v165, i64 0
  %v167 = load i64, ptr %v167.p
  %st99 = getelementptr i64, ptr %v60, i64 0
  store i64 %v167, ptr %st99
  %v168.p = getelementptr i64, ptr %v165, i64 1
  %v168 = load i64, ptr %v168.p
  %st100 = getelementptr i64, ptr %v60, i64 1
  store i64 %v168, ptr %st100
  %v169.p = getelementptr i64, ptr %v165, i64 2
  %v169 = load i64, ptr %v169.p
  %st101 = getelementptr i64, ptr %v60, i64 2
  store i64 %v169, ptr %st101
  br label %b11
b26:
  %v159 = add i64 0, 1
  %v160 = call ptr @"rt.slice_grow8"(i64 %v149, i64 %v150, i64 %v148, i64 %v159)
  %v161 = getelementptr i8, ptr %v160, i64 %v150
  br label %b25
b27:
  %v157 = inttoptr i64 %v149 to ptr
  %v158 = getelementptr i8, ptr %v157, i64 %v150
  br label %b25
b28:
  %v186 = add i64 0, 4
  %v187 = getelementptr i64, ptr %v0, i64 %v186
  call void @"rt.err_relocate"(ptr %v187, i64 %v5)
  br label %b29
b29:
  %v201 = getelementptr i64, ptr @"rt.meta", i64 0
  %st102 = getelementptr i64, ptr %v201, i64 0
  store i64 %v5, ptr %st102
  ret void
}

define internal i64 @"std/hex.nib"(i64 %v0) #0 {
b0:
  %v29 = getelementptr i64, ptr @"rt.meta", i64 0
  %v1.p = getelementptr i64, ptr %v29, i64 0
  %v1 = load i64, ptr %v1.p
  call void @"rt.region_enter"()
  %v2 = add i64 0, 48
  %v3.c = icmp sge i64 %v0, %v2
  %v3 = zext i1 %v3.c to i64
  %c.b0 = icmp ne i64 %v3, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v5 = add i64 0, 57
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
  %v7 = add i64 0, 48
  %v8 = sub i64 %v0, %v7
  br label %b15
b4:
  %v9 = add i64 0, 97
  %v10.c = icmp sge i64 %v0, %v9
  %v10 = zext i1 %v10.c to i64
  %c.b4 = icmp ne i64 %v10, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v12 = add i64 0, 102
  %v13.c = icmp sle i64 %v0, %v12
  %v13 = zext i1 %v13.c to i64
  br label %b6
b6:
  %v11 = phi i64 [ %v10, %b4.e6 ], [ %v13, %b5 ]
  %c.b6 = icmp ne i64 %v11, 0
  br i1 %c.b6, label %b6.t7, label %b6.e8
b6.t7:
  br label %b7
b6.e8:
  br label %b8
b7:
  %v14 = add i64 0, 87
  %v15 = sub i64 %v0, %v14
  br label %b14
b8:
  %v16 = add i64 0, 65
  %v17.c = icmp sge i64 %v0, %v16
  %v17 = zext i1 %v17.c to i64
  %c.b8 = icmp ne i64 %v17, 0
  br i1 %c.b8, label %b8.t9, label %b8.e10
b8.t9:
  br label %b9
b8.e10:
  br label %b10
b9:
  %v19 = add i64 0, 70
  %v20.c = icmp sle i64 %v0, %v19
  %v20 = zext i1 %v20.c to i64
  br label %b10
b10:
  %v18 = phi i64 [ %v17, %b8.e10 ], [ %v20, %b9 ]
  %c.b10 = icmp ne i64 %v18, 0
  br i1 %c.b10, label %b10.t11, label %b10.e12
b10.t11:
  br label %b11
b10.e12:
  br label %b12
b11:
  %v21 = add i64 0, 55
  %v22 = sub i64 %v0, %v21
  br label %b13
b12:
  %v23 = add i64 0, 1
  %v24 = add i64 0, 0
  %v25 = sub i64 %v24, %v23
  br label %b13
b13:
  %v26 = phi i64 [ %v22, %b11 ], [ %v25, %b12 ]
  br label %b14
b14:
  %v27 = phi i64 [ %v15, %b7 ], [ %v26, %b13 ]
  br label %b15
b15:
  %v28 = phi i64 [ %v8, %b3 ], [ %v27, %b14 ]
  %v30 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v30, i64 0
  store i64 %v1, ptr %st12
  ret i64 %v28
}

define internal void @"rt.err_relocate"(ptr %v0, i64 %v1) #0 {
b0:
  %v2 = add i64 0, 1
  %v3 = getelementptr i64, ptr %v0, i64 %v2
  %v4 = add i64 0, 1
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
  %v20 = getelementptr i64, ptr @"str.40", i64 0
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
  %v74 = getelementptr i64, ptr @"str.48", i64 0
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
  %v27 = getelementptr i64, ptr @"str.41", i64 0
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
  %v34 = getelementptr i64, ptr @"str.42", i64 0
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
  %v41 = getelementptr i64, ptr @"str.43", i64 0
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
  %v48 = getelementptr i64, ptr @"str.44", i64 0
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
  %v55 = getelementptr i64, ptr @"str.45", i64 0
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
  %v62 = getelementptr i64, ptr @"str.46", i64 0
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
  %v69 = getelementptr i64, ptr @"str.47", i64 0
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
  %v81 = getelementptr i64, ptr @"str.49", i64 0
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
  %v88 = getelementptr i64, ptr @"str.50", i64 0
  %v89 = add i64 0, 19
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
  %v95 = getelementptr i64, ptr @"str.51", i64 0
  %v96 = add i64 0, 30
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
  %v102 = getelementptr i64, ptr @"str.52", i64 0
  %v103 = add i64 0, 17
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
  %v140.p = getelementptr i64, ptr %v0, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = add i64 0, 2
  %v142 = add i64 %v140, %v141
  %v143 = getelementptr i64, ptr %v0, i64 %v142
  br label %b33
b33:
  %v144 = phi ptr [ %v143, %b32 ], [ %v207, %b36 ]
  %v146.p = getelementptr i64, ptr %v144, i64 0
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 0, 0
  %v148.c = icmp eq i64 %v146, %v147
  %v148 = zext i1 %v148.c to i64
  %v149 = add i64 0, 1
  %c.b33 = icmp ne i64 %v148, 0
  br i1 %c.b33, label %b33.t49, label %b33.e50
b33.t49:
  br label %b34
b33.e50:
  br label %b37
b34:
  %v145 = phi i64 [ %v149, %b33.t49 ], [ %v214, %b50.e78 ], [ %v214, %b51.e80 ], [ %v214, %b52.e82 ], [ %v214, %b53.t83 ], [ %v208, %b54 ]
  %v232 = add i64 0, 0
  %v233.c = icmp ne i64 %v145, %v232
  %v233 = zext i1 %v233.c to i64
  %c.b34 = icmp ne i64 %v233, 0
  br i1 %c.b34, label %b34.t51, label %b34.e52
b34.t51:
  br label %b56
b34.e52:
  br label %b57
b35:
  %v210 = add i64 0, 0
  %v211 = add i64 0, 11
  br label %b49
b36:
  %v206 = add i64 0, 1
  %v207 = getelementptr i64, ptr %v144, i64 %v206
  br label %b33
b37:
  %v150 = inttoptr i64 %v146 to ptr
  %v151 = add i64 0, 0
  %v152 = getelementptr i8, ptr %v150, i64 %v151
  %v153.p = getelementptr i8, ptr %v152, i64 0
  %v153.b = load i8, ptr %v153.p
  %v153 = zext i8 %v153.b to i64
  %v154 = add i64 0, 83
  %v155.c = icmp eq i64 %v153, %v154
  %v155 = zext i1 %v155.c to i64
  %c.b37 = icmp ne i64 %v155, 0
  br i1 %c.b37, label %b37.t53, label %b37.e54
b37.t53:
  br label %b38
b37.e54:
  br label %b36
b38:
  %v156 = add i64 0, 1
  %v157 = getelementptr i8, ptr %v150, i64 %v156
  %v158.p = getelementptr i8, ptr %v157, i64 0
  %v158.b = load i8, ptr %v158.p
  %v158 = zext i8 %v158.b to i64
  %v159 = add i64 0, 79
  %v160.c = icmp eq i64 %v158, %v159
  %v160 = zext i1 %v160.c to i64
  %c.b38 = icmp ne i64 %v160, 0
  br i1 %c.b38, label %b38.t55, label %b38.e56
b38.t55:
  br label %b39
b38.e56:
  br label %b36
b39:
  %v161 = add i64 0, 2
  %v162 = getelementptr i8, ptr %v150, i64 %v161
  %v163.p = getelementptr i8, ptr %v162, i64 0
  %v163.b = load i8, ptr %v163.p
  %v163 = zext i8 %v163.b to i64
  %v164 = add i64 0, 66
  %v165.c = icmp eq i64 %v163, %v164
  %v165 = zext i1 %v165.c to i64
  %c.b39 = icmp ne i64 %v165, 0
  br i1 %c.b39, label %b39.t57, label %b39.e58
b39.t57:
  br label %b40
b39.e58:
  br label %b36
b40:
  %v166 = add i64 0, 3
  %v167 = getelementptr i8, ptr %v150, i64 %v166
  %v168.p = getelementptr i8, ptr %v167, i64 0
  %v168.b = load i8, ptr %v168.p
  %v168 = zext i8 %v168.b to i64
  %v169 = add i64 0, 69
  %v170.c = icmp eq i64 %v168, %v169
  %v170 = zext i1 %v170.c to i64
  %c.b40 = icmp ne i64 %v170, 0
  br i1 %c.b40, label %b40.t59, label %b40.e60
b40.t59:
  br label %b41
b40.e60:
  br label %b36
b41:
  %v171 = add i64 0, 4
  %v172 = getelementptr i8, ptr %v150, i64 %v171
  %v173.p = getelementptr i8, ptr %v172, i64 0
  %v173.b = load i8, ptr %v173.p
  %v173 = zext i8 %v173.b to i64
  %v174 = add i64 0, 82
  %v175.c = icmp eq i64 %v173, %v174
  %v175 = zext i1 %v175.c to i64
  %c.b41 = icmp ne i64 %v175, 0
  br i1 %c.b41, label %b41.t61, label %b41.e62
b41.t61:
  br label %b42
b41.e62:
  br label %b36
b42:
  %v176 = add i64 0, 5
  %v177 = getelementptr i8, ptr %v150, i64 %v176
  %v178.p = getelementptr i8, ptr %v177, i64 0
  %v178.b = load i8, ptr %v178.p
  %v178 = zext i8 %v178.b to i64
  %v179 = add i64 0, 95
  %v180.c = icmp eq i64 %v178, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b42 = icmp ne i64 %v180, 0
  br i1 %c.b42, label %b42.t63, label %b42.e64
b42.t63:
  br label %b43
b42.e64:
  br label %b36
b43:
  %v181 = add i64 0, 6
  %v182 = getelementptr i8, ptr %v150, i64 %v181
  %v183.p = getelementptr i8, ptr %v182, i64 0
  %v183.b = load i8, ptr %v183.p
  %v183 = zext i8 %v183.b to i64
  %v184 = add i64 0, 77
  %v185.c = icmp eq i64 %v183, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b43 = icmp ne i64 %v185, 0
  br i1 %c.b43, label %b43.t65, label %b43.e66
b43.t65:
  br label %b44
b43.e66:
  br label %b36
b44:
  %v186 = add i64 0, 7
  %v187 = getelementptr i8, ptr %v150, i64 %v186
  %v188.p = getelementptr i8, ptr %v187, i64 0
  %v188.b = load i8, ptr %v188.p
  %v188 = zext i8 %v188.b to i64
  %v189 = add i64 0, 68
  %v190.c = icmp eq i64 %v188, %v189
  %v190 = zext i1 %v190.c to i64
  %c.b44 = icmp ne i64 %v190, 0
  br i1 %c.b44, label %b44.t67, label %b44.e68
b44.t67:
  br label %b45
b44.e68:
  br label %b36
b45:
  %v191 = add i64 0, 8
  %v192 = getelementptr i8, ptr %v150, i64 %v191
  %v193.p = getelementptr i8, ptr %v192, i64 0
  %v193.b = load i8, ptr %v193.p
  %v193 = zext i8 %v193.b to i64
  %v194 = add i64 0, 87
  %v195.c = icmp eq i64 %v193, %v194
  %v195 = zext i1 %v195.c to i64
  %c.b45 = icmp ne i64 %v195, 0
  br i1 %c.b45, label %b45.t69, label %b45.e70
b45.t69:
  br label %b46
b45.e70:
  br label %b36
b46:
  %v196 = add i64 0, 9
  %v197 = getelementptr i8, ptr %v150, i64 %v196
  %v198.p = getelementptr i8, ptr %v197, i64 0
  %v198.b = load i8, ptr %v198.p
  %v198 = zext i8 %v198.b to i64
  %v199 = add i64 0, 69
  %v200.c = icmp eq i64 %v198, %v199
  %v200 = zext i1 %v200.c to i64
  %c.b46 = icmp ne i64 %v200, 0
  br i1 %c.b46, label %b46.t71, label %b46.e72
b46.t71:
  br label %b47
b46.e72:
  br label %b36
b47:
  %v201 = add i64 0, 10
  %v202 = getelementptr i8, ptr %v150, i64 %v201
  %v203.p = getelementptr i8, ptr %v202, i64 0
  %v203.b = load i8, ptr %v203.p
  %v203 = zext i8 %v203.b to i64
  %v204 = add i64 0, 61
  %v205.c = icmp eq i64 %v203, %v204
  %v205 = zext i1 %v205.c to i64
  %c.b47 = icmp ne i64 %v205, 0
  br i1 %c.b47, label %b47.t73, label %b47.e74
b47.t73:
  br label %b48
b47.e74:
  br label %b36
b48:
  br label %b35
b49:
  %v208 = phi i64 [ %v210, %b35 ], [ %v227, %b55 ]
  %v209 = phi i64 [ %v211, %b35 ], [ %v231, %b55 ]
  %v212 = getelementptr i8, ptr %v150, i64 %v209
  %v213.p = getelementptr i8, ptr %v212, i64 0
  %v213.b = load i8, ptr %v213.p
  %v213 = zext i8 %v213.b to i64
  %v214 = add i64 0, 1
  %v215 = add i64 0, 0
  %v216.c = icmp eq i64 %v213, %v215
  %v216 = zext i1 %v216.c to i64
  %c.b49 = icmp ne i64 %v216, 0
  br i1 %c.b49, label %b49.t75, label %b49.e76
b49.t75:
  br label %b50
b49.e76:
  br label %b51
b50:
  %v217 = add i64 0, 11
  %v218.c = icmp sgt i64 %v209, %v217
  %v218 = zext i1 %v218.c to i64
  %c.b50 = icmp ne i64 %v218, 0
  br i1 %c.b50, label %b50.t77, label %b50.e78
b50.t77:
  br label %b54
b50.e78:
  br label %b34
b51:
  %v219 = add i64 0, 48
  %v220.c = icmp sge i64 %v213, %v219
  %v220 = zext i1 %v220.c to i64
  %c.b51 = icmp ne i64 %v220, 0
  br i1 %c.b51, label %b51.t79, label %b51.e80
b51.t79:
  br label %b52
b51.e80:
  br label %b34
b52:
  %v221 = add i64 0, 57
  %v222.c = icmp sle i64 %v213, %v221
  %v222 = zext i1 %v222.c to i64
  %c.b52 = icmp ne i64 %v222, 0
  br i1 %c.b52, label %b52.t81, label %b52.e82
b52.t81:
  br label %b53
b52.e82:
  br label %b34
b53:
  %v223 = add i64 0, 10
  %v224 = mul i64 %v208, %v223
  %v225 = add i64 0, 48
  %v226 = sub i64 %v213, %v225
  %v227 = add i64 %v224, %v226
  %v228 = add i64 0, 65536
  %v229.c = icmp sgt i64 %v227, %v228
  %v229 = zext i1 %v229.c to i64
  %c.b53 = icmp ne i64 %v229, 0
  br i1 %c.b53, label %b53.t83, label %b53.e84
b53.t83:
  br label %b34
b53.e84:
  br label %b55
b54:
  br label %b34
b55:
  %v230 = add i64 0, 1
  %v231 = add i64 %v209, %v230
  br label %b49
b56:
  %v234 = add i64 0, 157
  %v235 = add i64 0, 65
  %v236 = add i64 0, 3
  %v237 = add i64 0, 0
  %v238 = add i64 0, 0
  %v239 = add i64 0, 0
  %v240 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},~{rcx},~{r11},~{memory}"(i64 %v234, i64 %v235, i64 %v236, i64 %v237, i64 %v238, i64 %v239)
  br label %b57
b57:
  %v241 = add i64 0, 39
  %v242 = call i64 asm sideeffect "syscall", "={rax},{rax},~{rcx},~{r11},~{memory}"(i64 %v241)
  %v243 = add i64 0, 1
  %v244.c = icmp eq i64 %v242, %v243
  %v244 = zext i1 %v244.c to i64
  %c.b57 = icmp ne i64 %v244, 0
  br i1 %c.b57, label %b57.t85, label %b57.e86
b57.t85:
  br label %b58
b57.e86:
  br label %b59
b58:
  %v245 = getelementptr i64, ptr @"rt.sigact", i64 0
  %v246 = ptrtoint ptr @"rt.sigterm" to i64
  %st86 = getelementptr i64, ptr %v245, i64 0
  store i64 %v246, ptr %st86
  %v247 = add i64 0, 67108864
  %st87 = getelementptr i64, ptr %v245, i64 1
  store i64 %v247, ptr %st87
  %st88 = getelementptr i64, ptr %v245, i64 2
  store i64 %v246, ptr %st88
  %v248 = add i64 0, 0
  %st89 = getelementptr i64, ptr %v245, i64 3
  store i64 %v248, ptr %st89
  %v249 = add i64 0, 13
  %v250 = add i64 0, 15
  %v251 = ptrtoint ptr %v245 to i64
  %v252 = add i64 0, 0
  %v253 = add i64 0, 8
  %v254 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v249, i64 %v250, i64 %v251, i64 %v252, i64 %v253)
  %v255 = ptrtoint ptr @"rt.sigint" to i64
  %st90 = getelementptr i64, ptr %v245, i64 0
  store i64 %v255, ptr %st90
  %st91 = getelementptr i64, ptr %v245, i64 2
  store i64 %v255, ptr %st91
  %v256 = add i64 0, 13
  %v257 = add i64 0, 2
  %v258 = ptrtoint ptr %v245 to i64
  %v259 = add i64 0, 0
  %v260 = add i64 0, 8
  %v261 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %v256, i64 %v257, i64 %v258, i64 %v259, i64 %v260)
  br label %b59
b59:
  %st92 = getelementptr i64, ptr %v1, i64 1029
  store i64 %v130, ptr %st92
  %st93 = getelementptr i64, ptr %v1, i64 1030
  store i64 %v121, ptr %st93
  %v262 = add i64 0, 0
  %st94 = getelementptr i64, ptr %v1, i64 0
  store i64 %v262, ptr %st94
  %v263 = add i64 0, 1
  %st95 = getelementptr i64, ptr %v1, i64 1026
  store i64 %v263, ptr %st95
  %v264 = ptrtoint ptr %v0 to i64
  %st96 = getelementptr i64, ptr %v1, i64 2568
  store i64 %v264, ptr %st96
  %v265.p = getelementptr i64, ptr %v0, i64 0
  %v265 = load i64, ptr %v265.p
  %v266 = add i64 0, 2
  %v267 = add i64 %v265, %v266
  %v268 = getelementptr i64, ptr %v0, i64 %v267
  br label %b60
b60:
  %v269 = phi ptr [ %v268, %b59 ], [ %v347, %b63 ]
  %v271.p = getelementptr i64, ptr %v269, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 0, 0
  %v273.c = icmp eq i64 %v271, %v272
  %v273 = zext i1 %v273.c to i64
  %v274 = add i64 0, 1
  %c.b60 = icmp ne i64 %v273, 0
  br i1 %c.b60, label %b60.t98, label %b60.e99
b60.t98:
  br label %b61
b60.e99:
  br label %b64
b61:
  %v270 = phi i64 [ %v274, %b60.t98 ], [ %v354, %b80.e133 ], [ %v354, %b81.e135 ], [ %v354, %b82.e137 ], [ %v354, %b83.t138 ], [ %v348, %b84 ]
  %v372 = add i64 0, 20
  %v373.n = and i64 %v372, 63
  %v373 = shl i64 %v270, %v373.n
  %st99 = getelementptr i64, ptr %v1, i64 2569
  store i64 %v373, ptr %st99
  %v374 = add i64 0, 0
  %st100 = getelementptr i64, ptr %v1, i64 2570
  store i64 %v374, ptr %st100
  %v375.p = getelementptr i64, ptr %v0, i64 0
  %v375 = load i64, ptr %v375.p
  %v376 = add i64 0, 2
  %v377 = add i64 %v375, %v376
  %v378 = getelementptr i64, ptr %v0, i64 %v377
  br label %b86
b62:
  %v350 = add i64 0, 0
  %v351 = add i64 0, 14
  br label %b79
b63:
  %v346 = add i64 0, 1
  %v347 = getelementptr i64, ptr %v269, i64 %v346
  br label %b60
b64:
  %v275 = inttoptr i64 %v271 to ptr
  %v276 = add i64 0, 0
  %v277 = getelementptr i8, ptr %v275, i64 %v276
  %v278.p = getelementptr i8, ptr %v277, i64 0
  %v278.b = load i8, ptr %v278.p
  %v278 = zext i8 %v278.b to i64
  %v279 = add i64 0, 83
  %v280.c = icmp eq i64 %v278, %v279
  %v280 = zext i1 %v280.c to i64
  %c.b64 = icmp ne i64 %v280, 0
  br i1 %c.b64, label %b64.t102, label %b64.e103
b64.t102:
  br label %b65
b64.e103:
  br label %b63
b65:
  %v281 = add i64 0, 1
  %v282 = getelementptr i8, ptr %v275, i64 %v281
  %v283.p = getelementptr i8, ptr %v282, i64 0
  %v283.b = load i8, ptr %v283.p
  %v283 = zext i8 %v283.b to i64
  %v284 = add i64 0, 79
  %v285.c = icmp eq i64 %v283, %v284
  %v285 = zext i1 %v285.c to i64
  %c.b65 = icmp ne i64 %v285, 0
  br i1 %c.b65, label %b65.t104, label %b65.e105
b65.t104:
  br label %b66
b65.e105:
  br label %b63
b66:
  %v286 = add i64 0, 2
  %v287 = getelementptr i8, ptr %v275, i64 %v286
  %v288.p = getelementptr i8, ptr %v287, i64 0
  %v288.b = load i8, ptr %v288.p
  %v288 = zext i8 %v288.b to i64
  %v289 = add i64 0, 66
  %v290.c = icmp eq i64 %v288, %v289
  %v290 = zext i1 %v290.c to i64
  %c.b66 = icmp ne i64 %v290, 0
  br i1 %c.b66, label %b66.t106, label %b66.e107
b66.t106:
  br label %b67
b66.e107:
  br label %b63
b67:
  %v291 = add i64 0, 3
  %v292 = getelementptr i8, ptr %v275, i64 %v291
  %v293.p = getelementptr i8, ptr %v292, i64 0
  %v293.b = load i8, ptr %v293.p
  %v293 = zext i8 %v293.b to i64
  %v294 = add i64 0, 69
  %v295.c = icmp eq i64 %v293, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b67 = icmp ne i64 %v295, 0
  br i1 %c.b67, label %b67.t108, label %b67.e109
b67.t108:
  br label %b68
b67.e109:
  br label %b63
b68:
  %v296 = add i64 0, 4
  %v297 = getelementptr i8, ptr %v275, i64 %v296
  %v298.p = getelementptr i8, ptr %v297, i64 0
  %v298.b = load i8, ptr %v298.p
  %v298 = zext i8 %v298.b to i64
  %v299 = add i64 0, 82
  %v300.c = icmp eq i64 %v298, %v299
  %v300 = zext i1 %v300.c to i64
  %c.b68 = icmp ne i64 %v300, 0
  br i1 %c.b68, label %b68.t110, label %b68.e111
b68.t110:
  br label %b69
b68.e111:
  br label %b63
b69:
  %v301 = add i64 0, 5
  %v302 = getelementptr i8, ptr %v275, i64 %v301
  %v303.p = getelementptr i8, ptr %v302, i64 0
  %v303.b = load i8, ptr %v303.p
  %v303 = zext i8 %v303.b to i64
  %v304 = add i64 0, 95
  %v305.c = icmp eq i64 %v303, %v304
  %v305 = zext i1 %v305.c to i64
  %c.b69 = icmp ne i64 %v305, 0
  br i1 %c.b69, label %b69.t112, label %b69.e113
b69.t112:
  br label %b70
b69.e113:
  br label %b63
b70:
  %v306 = add i64 0, 6
  %v307 = getelementptr i8, ptr %v275, i64 %v306
  %v308.p = getelementptr i8, ptr %v307, i64 0
  %v308.b = load i8, ptr %v308.p
  %v308 = zext i8 %v308.b to i64
  %v309 = add i64 0, 77
  %v310.c = icmp eq i64 %v308, %v309
  %v310 = zext i1 %v310.c to i64
  %c.b70 = icmp ne i64 %v310, 0
  br i1 %c.b70, label %b70.t114, label %b70.e115
b70.t114:
  br label %b71
b70.e115:
  br label %b63
b71:
  %v311 = add i64 0, 7
  %v312 = getelementptr i8, ptr %v275, i64 %v311
  %v313.p = getelementptr i8, ptr %v312, i64 0
  %v313.b = load i8, ptr %v313.p
  %v313 = zext i8 %v313.b to i64
  %v314 = add i64 0, 65
  %v315.c = icmp eq i64 %v313, %v314
  %v315 = zext i1 %v315.c to i64
  %c.b71 = icmp ne i64 %v315, 0
  br i1 %c.b71, label %b71.t116, label %b71.e117
b71.t116:
  br label %b72
b71.e117:
  br label %b63
b72:
  %v316 = add i64 0, 8
  %v317 = getelementptr i8, ptr %v275, i64 %v316
  %v318.p = getelementptr i8, ptr %v317, i64 0
  %v318.b = load i8, ptr %v318.p
  %v318 = zext i8 %v318.b to i64
  %v319 = add i64 0, 68
  %v320.c = icmp eq i64 %v318, %v319
  %v320 = zext i1 %v320.c to i64
  %c.b72 = icmp ne i64 %v320, 0
  br i1 %c.b72, label %b72.t118, label %b72.e119
b72.t118:
  br label %b73
b72.e119:
  br label %b63
b73:
  %v321 = add i64 0, 9
  %v322 = getelementptr i8, ptr %v275, i64 %v321
  %v323.p = getelementptr i8, ptr %v322, i64 0
  %v323.b = load i8, ptr %v323.p
  %v323 = zext i8 %v323.b to i64
  %v324 = add i64 0, 86
  %v325.c = icmp eq i64 %v323, %v324
  %v325 = zext i1 %v325.c to i64
  %c.b73 = icmp ne i64 %v325, 0
  br i1 %c.b73, label %b73.t120, label %b73.e121
b73.t120:
  br label %b74
b73.e121:
  br label %b63
b74:
  %v326 = add i64 0, 10
  %v327 = getelementptr i8, ptr %v275, i64 %v326
  %v328.p = getelementptr i8, ptr %v327, i64 0
  %v328.b = load i8, ptr %v328.p
  %v328 = zext i8 %v328.b to i64
  %v329 = add i64 0, 95
  %v330.c = icmp eq i64 %v328, %v329
  %v330 = zext i1 %v330.c to i64
  %c.b74 = icmp ne i64 %v330, 0
  br i1 %c.b74, label %b74.t122, label %b74.e123
b74.t122:
  br label %b75
b74.e123:
  br label %b63
b75:
  %v331 = add i64 0, 11
  %v332 = getelementptr i8, ptr %v275, i64 %v331
  %v333.p = getelementptr i8, ptr %v332, i64 0
  %v333.b = load i8, ptr %v333.p
  %v333 = zext i8 %v333.b to i64
  %v334 = add i64 0, 77
  %v335.c = icmp eq i64 %v333, %v334
  %v335 = zext i1 %v335.c to i64
  %c.b75 = icmp ne i64 %v335, 0
  br i1 %c.b75, label %b75.t124, label %b75.e125
b75.t124:
  br label %b76
b75.e125:
  br label %b63
b76:
  %v336 = add i64 0, 12
  %v337 = getelementptr i8, ptr %v275, i64 %v336
  %v338.p = getelementptr i8, ptr %v337, i64 0
  %v338.b = load i8, ptr %v338.p
  %v338 = zext i8 %v338.b to i64
  %v339 = add i64 0, 66
  %v340.c = icmp eq i64 %v338, %v339
  %v340 = zext i1 %v340.c to i64
  %c.b76 = icmp ne i64 %v340, 0
  br i1 %c.b76, label %b76.t126, label %b76.e127
b76.t126:
  br label %b77
b76.e127:
  br label %b63
b77:
  %v341 = add i64 0, 13
  %v342 = getelementptr i8, ptr %v275, i64 %v341
  %v343.p = getelementptr i8, ptr %v342, i64 0
  %v343.b = load i8, ptr %v343.p
  %v343 = zext i8 %v343.b to i64
  %v344 = add i64 0, 61
  %v345.c = icmp eq i64 %v343, %v344
  %v345 = zext i1 %v345.c to i64
  %c.b77 = icmp ne i64 %v345, 0
  br i1 %c.b77, label %b77.t128, label %b77.e129
b77.t128:
  br label %b78
b77.e129:
  br label %b63
b78:
  br label %b62
b79:
  %v348 = phi i64 [ %v350, %b62 ], [ %v367, %b85 ]
  %v349 = phi i64 [ %v351, %b62 ], [ %v371, %b85 ]
  %v352 = getelementptr i8, ptr %v275, i64 %v349
  %v353.p = getelementptr i8, ptr %v352, i64 0
  %v353.b = load i8, ptr %v353.p
  %v353 = zext i8 %v353.b to i64
  %v354 = add i64 0, 1
  %v355 = add i64 0, 0
  %v356.c = icmp eq i64 %v353, %v355
  %v356 = zext i1 %v356.c to i64
  %c.b79 = icmp ne i64 %v356, 0
  br i1 %c.b79, label %b79.t130, label %b79.e131
b79.t130:
  br label %b80
b79.e131:
  br label %b81
b80:
  %v357 = add i64 0, 14
  %v358.c = icmp sgt i64 %v349, %v357
  %v358 = zext i1 %v358.c to i64
  %c.b80 = icmp ne i64 %v358, 0
  br i1 %c.b80, label %b80.t132, label %b80.e133
b80.t132:
  br label %b84
b80.e133:
  br label %b61
b81:
  %v359 = add i64 0, 48
  %v360.c = icmp sge i64 %v353, %v359
  %v360 = zext i1 %v360.c to i64
  %c.b81 = icmp ne i64 %v360, 0
  br i1 %c.b81, label %b81.t134, label %b81.e135
b81.t134:
  br label %b82
b81.e135:
  br label %b61
b82:
  %v361 = add i64 0, 57
  %v362.c = icmp sle i64 %v353, %v361
  %v362 = zext i1 %v362.c to i64
  %c.b82 = icmp ne i64 %v362, 0
  br i1 %c.b82, label %b82.t136, label %b82.e137
b82.t136:
  br label %b83
b82.e137:
  br label %b61
b83:
  %v363 = add i64 0, 10
  %v364 = mul i64 %v348, %v363
  %v365 = add i64 0, 48
  %v366 = sub i64 %v353, %v365
  %v367 = add i64 %v364, %v366
  %v368 = add i64 0, 65536
  %v369.c = icmp sgt i64 %v367, %v368
  %v369 = zext i1 %v369.c to i64
  %c.b83 = icmp ne i64 %v369, 0
  br i1 %c.b83, label %b83.t138, label %b83.e139
b83.t138:
  br label %b61
b83.e139:
  br label %b85
b84:
  br label %b61
b85:
  %v370 = add i64 0, 1
  %v371 = add i64 %v349, %v370
  br label %b79
b86:
  %v379 = phi ptr [ %v378, %b61 ], [ %v482, %b89 ]
  %v381.p = getelementptr i64, ptr %v379, i64 0
  %v381 = load i64, ptr %v381.p
  %v382 = add i64 0, 0
  %v383.c = icmp eq i64 %v381, %v382
  %v383 = zext i1 %v383.c to i64
  %v384 = add i64 0, 0
  %c.b86 = icmp ne i64 %v383, 0
  br i1 %c.b86, label %b86.t140, label %b86.e141
b86.t140:
  br label %b87
b86.e141:
  br label %b90
b87:
  %v380 = phi i64 [ %v384, %b86.t140 ], [ %v489, %b111.e183 ], [ %v489, %b112.e185 ], [ %v489, %b113.e187 ], [ %v489, %b114.t188 ], [ %v483, %b115 ]
  %v507.p = getelementptr i64, ptr %v0, i64 0
  %v507 = load i64, ptr %v507.p
  %v508 = add i64 0, 2
  %v509 = add i64 %v507, %v508
  %v510 = getelementptr i64, ptr %v0, i64 %v509
  br label %b117
b88:
  %v485 = add i64 0, 0
  %v486 = add i64 0, 19
  br label %b110
b89:
  %v481 = add i64 0, 1
  %v482 = getelementptr i64, ptr %v379, i64 %v481
  br label %b86
b90:
  %v385 = inttoptr i64 %v381 to ptr
  %v386 = add i64 0, 0
  %v387 = getelementptr i8, ptr %v385, i64 %v386
  %v388.p = getelementptr i8, ptr %v387, i64 0
  %v388.b = load i8, ptr %v388.p
  %v388 = zext i8 %v388.b to i64
  %v389 = add i64 0, 83
  %v390.c = icmp eq i64 %v388, %v389
  %v390 = zext i1 %v390.c to i64
  %c.b90 = icmp ne i64 %v390, 0
  br i1 %c.b90, label %b90.t142, label %b90.e143
b90.t142:
  br label %b91
b90.e143:
  br label %b89
b91:
  %v391 = add i64 0, 1
  %v392 = getelementptr i8, ptr %v385, i64 %v391
  %v393.p = getelementptr i8, ptr %v392, i64 0
  %v393.b = load i8, ptr %v393.p
  %v393 = zext i8 %v393.b to i64
  %v394 = add i64 0, 79
  %v395.c = icmp eq i64 %v393, %v394
  %v395 = zext i1 %v395.c to i64
  %c.b91 = icmp ne i64 %v395, 0
  br i1 %c.b91, label %b91.t144, label %b91.e145
b91.t144:
  br label %b92
b91.e145:
  br label %b89
b92:
  %v396 = add i64 0, 2
  %v397 = getelementptr i8, ptr %v385, i64 %v396
  %v398.p = getelementptr i8, ptr %v397, i64 0
  %v398.b = load i8, ptr %v398.p
  %v398 = zext i8 %v398.b to i64
  %v399 = add i64 0, 66
  %v400.c = icmp eq i64 %v398, %v399
  %v400 = zext i1 %v400.c to i64
  %c.b92 = icmp ne i64 %v400, 0
  br i1 %c.b92, label %b92.t146, label %b92.e147
b92.t146:
  br label %b93
b92.e147:
  br label %b89
b93:
  %v401 = add i64 0, 3
  %v402 = getelementptr i8, ptr %v385, i64 %v401
  %v403.p = getelementptr i8, ptr %v402, i64 0
  %v403.b = load i8, ptr %v403.p
  %v403 = zext i8 %v403.b to i64
  %v404 = add i64 0, 69
  %v405.c = icmp eq i64 %v403, %v404
  %v405 = zext i1 %v405.c to i64
  %c.b93 = icmp ne i64 %v405, 0
  br i1 %c.b93, label %b93.t148, label %b93.e149
b93.t148:
  br label %b94
b93.e149:
  br label %b89
b94:
  %v406 = add i64 0, 4
  %v407 = getelementptr i8, ptr %v385, i64 %v406
  %v408.p = getelementptr i8, ptr %v407, i64 0
  %v408.b = load i8, ptr %v408.p
  %v408 = zext i8 %v408.b to i64
  %v409 = add i64 0, 82
  %v410.c = icmp eq i64 %v408, %v409
  %v410 = zext i1 %v410.c to i64
  %c.b94 = icmp ne i64 %v410, 0
  br i1 %c.b94, label %b94.t150, label %b94.e151
b94.t150:
  br label %b95
b94.e151:
  br label %b89
b95:
  %v411 = add i64 0, 5
  %v412 = getelementptr i8, ptr %v385, i64 %v411
  %v413.p = getelementptr i8, ptr %v412, i64 0
  %v413.b = load i8, ptr %v413.p
  %v413 = zext i8 %v413.b to i64
  %v414 = add i64 0, 95
  %v415.c = icmp eq i64 %v413, %v414
  %v415 = zext i1 %v415.c to i64
  %c.b95 = icmp ne i64 %v415, 0
  br i1 %c.b95, label %b95.t152, label %b95.e153
b95.t152:
  br label %b96
b95.e153:
  br label %b89
b96:
  %v416 = add i64 0, 6
  %v417 = getelementptr i8, ptr %v385, i64 %v416
  %v418.p = getelementptr i8, ptr %v417, i64 0
  %v418.b = load i8, ptr %v418.p
  %v418 = zext i8 %v418.b to i64
  %v419 = add i64 0, 68
  %v420.c = icmp eq i64 %v418, %v419
  %v420 = zext i1 %v420.c to i64
  %c.b96 = icmp ne i64 %v420, 0
  br i1 %c.b96, label %b96.t154, label %b96.e155
b96.t154:
  br label %b97
b96.e155:
  br label %b89
b97:
  %v421 = add i64 0, 7
  %v422 = getelementptr i8, ptr %v385, i64 %v421
  %v423.p = getelementptr i8, ptr %v422, i64 0
  %v423.b = load i8, ptr %v423.p
  %v423 = zext i8 %v423.b to i64
  %v424 = add i64 0, 69
  %v425.c = icmp eq i64 %v423, %v424
  %v425 = zext i1 %v425.c to i64
  %c.b97 = icmp ne i64 %v425, 0
  br i1 %c.b97, label %b97.t156, label %b97.e157
b97.t156:
  br label %b98
b97.e157:
  br label %b89
b98:
  %v426 = add i64 0, 8
  %v427 = getelementptr i8, ptr %v385, i64 %v426
  %v428.p = getelementptr i8, ptr %v427, i64 0
  %v428.b = load i8, ptr %v428.p
  %v428 = zext i8 %v428.b to i64
  %v429 = add i64 0, 80
  %v430.c = icmp eq i64 %v428, %v429
  %v430 = zext i1 %v430.c to i64
  %c.b98 = icmp ne i64 %v430, 0
  br i1 %c.b98, label %b98.t158, label %b98.e159
b98.t158:
  br label %b99
b98.e159:
  br label %b89
b99:
  %v431 = add i64 0, 9
  %v432 = getelementptr i8, ptr %v385, i64 %v431
  %v433.p = getelementptr i8, ptr %v432, i64 0
  %v433.b = load i8, ptr %v433.p
  %v433 = zext i8 %v433.b to i64
  %v434 = add i64 0, 84
  %v435.c = icmp eq i64 %v433, %v434
  %v435 = zext i1 %v435.c to i64
  %c.b99 = icmp ne i64 %v435, 0
  br i1 %c.b99, label %b99.t160, label %b99.e161
b99.t160:
  br label %b100
b99.e161:
  br label %b89
b100:
  %v436 = add i64 0, 10
  %v437 = getelementptr i8, ptr %v385, i64 %v436
  %v438.p = getelementptr i8, ptr %v437, i64 0
  %v438.b = load i8, ptr %v438.p
  %v438 = zext i8 %v438.b to i64
  %v439 = add i64 0, 72
  %v440.c = icmp eq i64 %v438, %v439
  %v440 = zext i1 %v440.c to i64
  %c.b100 = icmp ne i64 %v440, 0
  br i1 %c.b100, label %b100.t162, label %b100.e163
b100.t162:
  br label %b101
b100.e163:
  br label %b89
b101:
  %v441 = add i64 0, 11
  %v442 = getelementptr i8, ptr %v385, i64 %v441
  %v443.p = getelementptr i8, ptr %v442, i64 0
  %v443.b = load i8, ptr %v443.p
  %v443 = zext i8 %v443.b to i64
  %v444 = add i64 0, 95
  %v445.c = icmp eq i64 %v443, %v444
  %v445 = zext i1 %v445.c to i64
  %c.b101 = icmp ne i64 %v445, 0
  br i1 %c.b101, label %b101.t164, label %b101.e165
b101.t164:
  br label %b102
b101.e165:
  br label %b89
b102:
  %v446 = add i64 0, 12
  %v447 = getelementptr i8, ptr %v385, i64 %v446
  %v448.p = getelementptr i8, ptr %v447, i64 0
  %v448.b = load i8, ptr %v448.p
  %v448 = zext i8 %v448.b to i64
  %v449 = add i64 0, 82
  %v450.c = icmp eq i64 %v448, %v449
  %v450 = zext i1 %v450.c to i64
  %c.b102 = icmp ne i64 %v450, 0
  br i1 %c.b102, label %b102.t166, label %b102.e167
b102.t166:
  br label %b103
b102.e167:
  br label %b89
b103:
  %v451 = add i64 0, 13
  %v452 = getelementptr i8, ptr %v385, i64 %v451
  %v453.p = getelementptr i8, ptr %v452, i64 0
  %v453.b = load i8, ptr %v453.p
  %v453 = zext i8 %v453.b to i64
  %v454 = add i64 0, 69
  %v455.c = icmp eq i64 %v453, %v454
  %v455 = zext i1 %v455.c to i64
  %c.b103 = icmp ne i64 %v455, 0
  br i1 %c.b103, label %b103.t168, label %b103.e169
b103.t168:
  br label %b104
b103.e169:
  br label %b89
b104:
  %v456 = add i64 0, 14
  %v457 = getelementptr i8, ptr %v385, i64 %v456
  %v458.p = getelementptr i8, ptr %v457, i64 0
  %v458.b = load i8, ptr %v458.p
  %v458 = zext i8 %v458.b to i64
  %v459 = add i64 0, 80
  %v460.c = icmp eq i64 %v458, %v459
  %v460 = zext i1 %v460.c to i64
  %c.b104 = icmp ne i64 %v460, 0
  br i1 %c.b104, label %b104.t170, label %b104.e171
b104.t170:
  br label %b105
b104.e171:
  br label %b89
b105:
  %v461 = add i64 0, 15
  %v462 = getelementptr i8, ptr %v385, i64 %v461
  %v463.p = getelementptr i8, ptr %v462, i64 0
  %v463.b = load i8, ptr %v463.p
  %v463 = zext i8 %v463.b to i64
  %v464 = add i64 0, 79
  %v465.c = icmp eq i64 %v463, %v464
  %v465 = zext i1 %v465.c to i64
  %c.b105 = icmp ne i64 %v465, 0
  br i1 %c.b105, label %b105.t172, label %b105.e173
b105.t172:
  br label %b106
b105.e173:
  br label %b89
b106:
  %v466 = add i64 0, 16
  %v467 = getelementptr i8, ptr %v385, i64 %v466
  %v468.p = getelementptr i8, ptr %v467, i64 0
  %v468.b = load i8, ptr %v468.p
  %v468 = zext i8 %v468.b to i64
  %v469 = add i64 0, 82
  %v470.c = icmp eq i64 %v468, %v469
  %v470 = zext i1 %v470.c to i64
  %c.b106 = icmp ne i64 %v470, 0
  br i1 %c.b106, label %b106.t174, label %b106.e175
b106.t174:
  br label %b107
b106.e175:
  br label %b89
b107:
  %v471 = add i64 0, 17
  %v472 = getelementptr i8, ptr %v385, i64 %v471
  %v473.p = getelementptr i8, ptr %v472, i64 0
  %v473.b = load i8, ptr %v473.p
  %v473 = zext i8 %v473.b to i64
  %v474 = add i64 0, 84
  %v475.c = icmp eq i64 %v473, %v474
  %v475 = zext i1 %v475.c to i64
  %c.b107 = icmp ne i64 %v475, 0
  br i1 %c.b107, label %b107.t176, label %b107.e177
b107.t176:
  br label %b108
b107.e177:
  br label %b89
b108:
  %v476 = add i64 0, 18
  %v477 = getelementptr i8, ptr %v385, i64 %v476
  %v478.p = getelementptr i8, ptr %v477, i64 0
  %v478.b = load i8, ptr %v478.p
  %v478 = zext i8 %v478.b to i64
  %v479 = add i64 0, 61
  %v480.c = icmp eq i64 %v478, %v479
  %v480 = zext i1 %v480.c to i64
  %c.b108 = icmp ne i64 %v480, 0
  br i1 %c.b108, label %b108.t178, label %b108.e179
b108.t178:
  br label %b109
b108.e179:
  br label %b89
b109:
  br label %b88
b110:
  %v483 = phi i64 [ %v485, %b88 ], [ %v502, %b116 ]
  %v484 = phi i64 [ %v486, %b88 ], [ %v506, %b116 ]
  %v487 = getelementptr i8, ptr %v385, i64 %v484
  %v488.p = getelementptr i8, ptr %v487, i64 0
  %v488.b = load i8, ptr %v488.p
  %v488 = zext i8 %v488.b to i64
  %v489 = add i64 0, 0
  %v490 = add i64 0, 0
  %v491.c = icmp eq i64 %v488, %v490
  %v491 = zext i1 %v491.c to i64
  %c.b110 = icmp ne i64 %v491, 0
  br i1 %c.b110, label %b110.t180, label %b110.e181
b110.t180:
  br label %b111
b110.e181:
  br label %b112
b111:
  %v492 = add i64 0, 19
  %v493.c = icmp sgt i64 %v484, %v492
  %v493 = zext i1 %v493.c to i64
  %c.b111 = icmp ne i64 %v493, 0
  br i1 %c.b111, label %b111.t182, label %b111.e183
b111.t182:
  br label %b115
b111.e183:
  br label %b87
b112:
  %v494 = add i64 0, 48
  %v495.c = icmp sge i64 %v488, %v494
  %v495 = zext i1 %v495.c to i64
  %c.b112 = icmp ne i64 %v495, 0
  br i1 %c.b112, label %b112.t184, label %b112.e185
b112.t184:
  br label %b113
b112.e185:
  br label %b87
b113:
  %v496 = add i64 0, 57
  %v497.c = icmp sle i64 %v488, %v496
  %v497 = zext i1 %v497.c to i64
  %c.b113 = icmp ne i64 %v497, 0
  br i1 %c.b113, label %b113.t186, label %b113.e187
b113.t186:
  br label %b114
b113.e187:
  br label %b87
b114:
  %v498 = add i64 0, 10
  %v499 = mul i64 %v483, %v498
  %v500 = add i64 0, 48
  %v501 = sub i64 %v488, %v500
  %v502 = add i64 %v499, %v501
  %v503 = add i64 0, 65536
  %v504.c = icmp sgt i64 %v502, %v503
  %v504 = zext i1 %v504.c to i64
  %c.b114 = icmp ne i64 %v504, 0
  br i1 %c.b114, label %b114.t188, label %b114.e189
b114.t188:
  br label %b87
b114.e189:
  br label %b116
b115:
  br label %b87
b116:
  %v505 = add i64 0, 1
  %v506 = add i64 %v484, %v505
  br label %b110
b117:
  %v511 = phi ptr [ %v510, %b87 ], [ %v609, %b120 ]
  %v513.p = getelementptr i64, ptr %v511, i64 0
  %v513 = load i64, ptr %v513.p
  %v514 = add i64 0, 0
  %v515.c = icmp eq i64 %v513, %v514
  %v515 = zext i1 %v515.c to i64
  %v516 = add i64 0, 0
  %c.b117 = icmp ne i64 %v515, 0
  br i1 %c.b117, label %b117.t190, label %b117.e191
b117.t190:
  br label %b118
b117.e191:
  br label %b121
b118:
  %v512 = phi i64 [ %v516, %b117.t190 ], [ %v616, %b141.e232 ], [ %v616, %b142.e234 ], [ %v616, %b143.e236 ], [ %v616, %b144.t237 ], [ %v610, %b145 ]
  %v634 = add i64 0, 0
  %v635.c = icmp ne i64 %v512, %v634
  %v635 = zext i1 %v635.c to i64
  %v636 = add i64 0, 1099511627776
  %v637 = mul i64 %v635, %v636
  %v638 = add i64 0, 1099511627775
  %v639 = and i64 %v380, %v638
  %v640 = or i64 %v639, %v637
  %st191 = getelementptr i64, ptr %v1, i64 2573
  store i64 %v640, ptr %st191
  call void @"main.main"()
  call void @"rt.depth_report"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 0)
  unreachable
b119:
  %v612 = add i64 0, 0
  %v613 = add i64 0, 18
  br label %b140
b120:
  %v608 = add i64 0, 1
  %v609 = getelementptr i64, ptr %v511, i64 %v608
  br label %b117
b121:
  %v517 = inttoptr i64 %v513 to ptr
  %v518 = add i64 0, 0
  %v519 = getelementptr i8, ptr %v517, i64 %v518
  %v520.p = getelementptr i8, ptr %v519, i64 0
  %v520.b = load i8, ptr %v520.p
  %v520 = zext i8 %v520.b to i64
  %v521 = add i64 0, 83
  %v522.c = icmp eq i64 %v520, %v521
  %v522 = zext i1 %v522.c to i64
  %c.b121 = icmp ne i64 %v522, 0
  br i1 %c.b121, label %b121.t193, label %b121.e194
b121.t193:
  br label %b122
b121.e194:
  br label %b120
b122:
  %v523 = add i64 0, 1
  %v524 = getelementptr i8, ptr %v517, i64 %v523
  %v525.p = getelementptr i8, ptr %v524, i64 0
  %v525.b = load i8, ptr %v525.p
  %v525 = zext i8 %v525.b to i64
  %v526 = add i64 0, 79
  %v527.c = icmp eq i64 %v525, %v526
  %v527 = zext i1 %v527.c to i64
  %c.b122 = icmp ne i64 %v527, 0
  br i1 %c.b122, label %b122.t195, label %b122.e196
b122.t195:
  br label %b123
b122.e196:
  br label %b120
b123:
  %v528 = add i64 0, 2
  %v529 = getelementptr i8, ptr %v517, i64 %v528
  %v530.p = getelementptr i8, ptr %v529, i64 0
  %v530.b = load i8, ptr %v530.p
  %v530 = zext i8 %v530.b to i64
  %v531 = add i64 0, 66
  %v532.c = icmp eq i64 %v530, %v531
  %v532 = zext i1 %v532.c to i64
  %c.b123 = icmp ne i64 %v532, 0
  br i1 %c.b123, label %b123.t197, label %b123.e198
b123.t197:
  br label %b124
b123.e198:
  br label %b120
b124:
  %v533 = add i64 0, 3
  %v534 = getelementptr i8, ptr %v517, i64 %v533
  %v535.p = getelementptr i8, ptr %v534, i64 0
  %v535.b = load i8, ptr %v535.p
  %v535 = zext i8 %v535.b to i64
  %v536 = add i64 0, 69
  %v537.c = icmp eq i64 %v535, %v536
  %v537 = zext i1 %v537.c to i64
  %c.b124 = icmp ne i64 %v537, 0
  br i1 %c.b124, label %b124.t199, label %b124.e200
b124.t199:
  br label %b125
b124.e200:
  br label %b120
b125:
  %v538 = add i64 0, 4
  %v539 = getelementptr i8, ptr %v517, i64 %v538
  %v540.p = getelementptr i8, ptr %v539, i64 0
  %v540.b = load i8, ptr %v540.p
  %v540 = zext i8 %v540.b to i64
  %v541 = add i64 0, 82
  %v542.c = icmp eq i64 %v540, %v541
  %v542 = zext i1 %v542.c to i64
  %c.b125 = icmp ne i64 %v542, 0
  br i1 %c.b125, label %b125.t201, label %b125.e202
b125.t201:
  br label %b126
b125.e202:
  br label %b120
b126:
  %v543 = add i64 0, 5
  %v544 = getelementptr i8, ptr %v517, i64 %v543
  %v545.p = getelementptr i8, ptr %v544, i64 0
  %v545.b = load i8, ptr %v545.p
  %v545 = zext i8 %v545.b to i64
  %v546 = add i64 0, 95
  %v547.c = icmp eq i64 %v545, %v546
  %v547 = zext i1 %v547.c to i64
  %c.b126 = icmp ne i64 %v547, 0
  br i1 %c.b126, label %b126.t203, label %b126.e204
b126.t203:
  br label %b127
b126.e204:
  br label %b120
b127:
  %v548 = add i64 0, 6
  %v549 = getelementptr i8, ptr %v517, i64 %v548
  %v550.p = getelementptr i8, ptr %v549, i64 0
  %v550.b = load i8, ptr %v550.p
  %v550 = zext i8 %v550.b to i64
  %v551 = add i64 0, 77
  %v552.c = icmp eq i64 %v550, %v551
  %v552 = zext i1 %v552.c to i64
  %c.b127 = icmp ne i64 %v552, 0
  br i1 %c.b127, label %b127.t205, label %b127.e206
b127.t205:
  br label %b128
b127.e206:
  br label %b120
b128:
  %v553 = add i64 0, 7
  %v554 = getelementptr i8, ptr %v517, i64 %v553
  %v555.p = getelementptr i8, ptr %v554, i64 0
  %v555.b = load i8, ptr %v555.p
  %v555 = zext i8 %v555.b to i64
  %v556 = add i64 0, 68
  %v557.c = icmp eq i64 %v555, %v556
  %v557 = zext i1 %v557.c to i64
  %c.b128 = icmp ne i64 %v557, 0
  br i1 %c.b128, label %b128.t207, label %b128.e208
b128.t207:
  br label %b129
b128.e208:
  br label %b120
b129:
  %v558 = add i64 0, 8
  %v559 = getelementptr i8, ptr %v517, i64 %v558
  %v560.p = getelementptr i8, ptr %v559, i64 0
  %v560.b = load i8, ptr %v560.p
  %v560 = zext i8 %v560.b to i64
  %v561 = add i64 0, 87
  %v562.c = icmp eq i64 %v560, %v561
  %v562 = zext i1 %v562.c to i64
  %c.b129 = icmp ne i64 %v562, 0
  br i1 %c.b129, label %b129.t209, label %b129.e210
b129.t209:
  br label %b130
b129.e210:
  br label %b120
b130:
  %v563 = add i64 0, 9
  %v564 = getelementptr i8, ptr %v517, i64 %v563
  %v565.p = getelementptr i8, ptr %v564, i64 0
  %v565.b = load i8, ptr %v565.p
  %v565 = zext i8 %v565.b to i64
  %v566 = add i64 0, 69
  %v567.c = icmp eq i64 %v565, %v566
  %v567 = zext i1 %v567.c to i64
  %c.b130 = icmp ne i64 %v567, 0
  br i1 %c.b130, label %b130.t211, label %b130.e212
b130.t211:
  br label %b131
b130.e212:
  br label %b120
b131:
  %v568 = add i64 0, 10
  %v569 = getelementptr i8, ptr %v517, i64 %v568
  %v570.p = getelementptr i8, ptr %v569, i64 0
  %v570.b = load i8, ptr %v570.p
  %v570 = zext i8 %v570.b to i64
  %v571 = add i64 0, 95
  %v572.c = icmp eq i64 %v570, %v571
  %v572 = zext i1 %v572.c to i64
  %c.b131 = icmp ne i64 %v572, 0
  br i1 %c.b131, label %b131.t213, label %b131.e214
b131.t213:
  br label %b132
b131.e214:
  br label %b120
b132:
  %v573 = add i64 0, 11
  %v574 = getelementptr i8, ptr %v517, i64 %v573
  %v575.p = getelementptr i8, ptr %v574, i64 0
  %v575.b = load i8, ptr %v575.p
  %v575 = zext i8 %v575.b to i64
  %v576 = add i64 0, 82
  %v577.c = icmp eq i64 %v575, %v576
  %v577 = zext i1 %v577.c to i64
  %c.b132 = icmp ne i64 %v577, 0
  br i1 %c.b132, label %b132.t215, label %b132.e216
b132.t215:
  br label %b133
b132.e216:
  br label %b120
b133:
  %v578 = add i64 0, 12
  %v579 = getelementptr i8, ptr %v517, i64 %v578
  %v580.p = getelementptr i8, ptr %v579, i64 0
  %v580.b = load i8, ptr %v580.p
  %v580 = zext i8 %v580.b to i64
  %v581 = add i64 0, 69
  %v582.c = icmp eq i64 %v580, %v581
  %v582 = zext i1 %v582.c to i64
  %c.b133 = icmp ne i64 %v582, 0
  br i1 %c.b133, label %b133.t217, label %b133.e218
b133.t217:
  br label %b134
b133.e218:
  br label %b120
b134:
  %v583 = add i64 0, 13
  %v584 = getelementptr i8, ptr %v517, i64 %v583
  %v585.p = getelementptr i8, ptr %v584, i64 0
  %v585.b = load i8, ptr %v585.p
  %v585 = zext i8 %v585.b to i64
  %v586 = add i64 0, 80
  %v587.c = icmp eq i64 %v585, %v586
  %v587 = zext i1 %v587.c to i64
  %c.b134 = icmp ne i64 %v587, 0
  br i1 %c.b134, label %b134.t219, label %b134.e220
b134.t219:
  br label %b135
b134.e220:
  br label %b120
b135:
  %v588 = add i64 0, 14
  %v589 = getelementptr i8, ptr %v517, i64 %v588
  %v590.p = getelementptr i8, ptr %v589, i64 0
  %v590.b = load i8, ptr %v590.p
  %v590 = zext i8 %v590.b to i64
  %v591 = add i64 0, 79
  %v592.c = icmp eq i64 %v590, %v591
  %v592 = zext i1 %v592.c to i64
  %c.b135 = icmp ne i64 %v592, 0
  br i1 %c.b135, label %b135.t221, label %b135.e222
b135.t221:
  br label %b136
b135.e222:
  br label %b120
b136:
  %v593 = add i64 0, 15
  %v594 = getelementptr i8, ptr %v517, i64 %v593
  %v595.p = getelementptr i8, ptr %v594, i64 0
  %v595.b = load i8, ptr %v595.p
  %v595 = zext i8 %v595.b to i64
  %v596 = add i64 0, 82
  %v597.c = icmp eq i64 %v595, %v596
  %v597 = zext i1 %v597.c to i64
  %c.b136 = icmp ne i64 %v597, 0
  br i1 %c.b136, label %b136.t223, label %b136.e224
b136.t223:
  br label %b137
b136.e224:
  br label %b120
b137:
  %v598 = add i64 0, 16
  %v599 = getelementptr i8, ptr %v517, i64 %v598
  %v600.p = getelementptr i8, ptr %v599, i64 0
  %v600.b = load i8, ptr %v600.p
  %v600 = zext i8 %v600.b to i64
  %v601 = add i64 0, 84
  %v602.c = icmp eq i64 %v600, %v601
  %v602 = zext i1 %v602.c to i64
  %c.b137 = icmp ne i64 %v602, 0
  br i1 %c.b137, label %b137.t225, label %b137.e226
b137.t225:
  br label %b138
b137.e226:
  br label %b120
b138:
  %v603 = add i64 0, 17
  %v604 = getelementptr i8, ptr %v517, i64 %v603
  %v605.p = getelementptr i8, ptr %v604, i64 0
  %v605.b = load i8, ptr %v605.p
  %v605 = zext i8 %v605.b to i64
  %v606 = add i64 0, 61
  %v607.c = icmp eq i64 %v605, %v606
  %v607 = zext i1 %v607.c to i64
  %c.b138 = icmp ne i64 %v607, 0
  br i1 %c.b138, label %b138.t227, label %b138.e228
b138.t227:
  br label %b139
b138.e228:
  br label %b120
b139:
  br label %b119
b140:
  %v610 = phi i64 [ %v612, %b119 ], [ %v629, %b146 ]
  %v611 = phi i64 [ %v613, %b119 ], [ %v633, %b146 ]
  %v614 = getelementptr i8, ptr %v517, i64 %v611
  %v615.p = getelementptr i8, ptr %v614, i64 0
  %v615.b = load i8, ptr %v615.p
  %v615 = zext i8 %v615.b to i64
  %v616 = add i64 0, 0
  %v617 = add i64 0, 0
  %v618.c = icmp eq i64 %v615, %v617
  %v618 = zext i1 %v618.c to i64
  %c.b140 = icmp ne i64 %v618, 0
  br i1 %c.b140, label %b140.t229, label %b140.e230
b140.t229:
  br label %b141
b140.e230:
  br label %b142
b141:
  %v619 = add i64 0, 18
  %v620.c = icmp sgt i64 %v611, %v619
  %v620 = zext i1 %v620.c to i64
  %c.b141 = icmp ne i64 %v620, 0
  br i1 %c.b141, label %b141.t231, label %b141.e232
b141.t231:
  br label %b145
b141.e232:
  br label %b118
b142:
  %v621 = add i64 0, 48
  %v622.c = icmp sge i64 %v615, %v621
  %v622 = zext i1 %v622.c to i64
  %c.b142 = icmp ne i64 %v622, 0
  br i1 %c.b142, label %b142.t233, label %b142.e234
b142.t233:
  br label %b143
b142.e234:
  br label %b118
b143:
  %v623 = add i64 0, 57
  %v624.c = icmp sle i64 %v615, %v623
  %v624 = zext i1 %v624.c to i64
  %c.b143 = icmp ne i64 %v624, 0
  br i1 %c.b143, label %b143.t235, label %b143.e236
b143.t235:
  br label %b144
b143.e236:
  br label %b118
b144:
  %v625 = add i64 0, 10
  %v626 = mul i64 %v610, %v625
  %v627 = add i64 0, 48
  %v628 = sub i64 %v615, %v627
  %v629 = add i64 %v626, %v628
  %v630 = add i64 0, 65536
  %v631.c = icmp sgt i64 %v629, %v630
  %v631 = zext i1 %v631.c to i64
  %c.b144 = icmp ne i64 %v631, 0
  br i1 %c.b144, label %b144.t237, label %b144.e238
b144.t237:
  br label %b118
b144.e238:
  br label %b146
b145:
  br label %b118
b146:
  %v632 = add i64 0, 1
  %v633 = add i64 %v611, %v632
  br label %b140
}
