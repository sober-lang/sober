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
@"str.0" = internal constant [1 x i64] [i64 27503]
@"str.1" = internal constant [1 x i64] [i64 1684104545]
@"str.2" = internal constant [1 x i64] [i64 1852141679]
@"str.3" = internal constant [1 x i64] [i64 461229747298]
@"str.4" = internal constant [1 x i64] [i64 110442657834354]
@"str.5" = internal constant [1 x i64] [i64 122545825211763]
@"str.6" = internal constant [1 x i64] [i64 125780003479924]
@"str.7" = internal constant [1 x i64] [i64 127961812791407]
@"str.8" = internal constant [1 x i64] [i64 32774764210906468]
@"str.9" = internal constant [1 x i64] [i64 32774764210908773]
@"str.10" = internal constant [3 x i64] [i64 3472328296227680304, i64 7004276303992991792, i64 3472328296227680304]
@"str.11" = internal constant [3 x i64] [i64 3472328296227682096, i64 3689629194468470836, i64 59597858812980]
@"str.12" = internal constant [3 x i64] [i64 3472328296227682096, i64 3689629194468470836, i64 3977863968733803572]
@"str.13" = internal constant [1 x i64] [i64 3472331594812897073]
@"str.14" = internal constant [2 x i64] [i64 3472331594812897073, i64 12857]
@"str.15" = internal constant [4 x i64] [i64 3558798293078128737, i64 3919035694239264819, i64 7377285658914730595, i64 4134646621615973168]
@"str.16" = internal constant [3 x i64] [i64 3689910673740214325, i64 3702858720240414819, i64 3991093494505747555]
@"str.17" = internal constant [3 x i64] [i64 3689910673740214325, i64 3702858720240414819, i64 4063151088543675491]
@"str.18" = internal constant [33 x i64] [i64 3761460307096056676, i64 7089844723572552758, i64 7161398925180035639, i64 3630857013206266677, i64 3545850668262700129, i64 7306589225962846514, i64 3990529440695531873, i64 3919312784929928755, i64 7292792764513805363, i64 3616732681785664312, i64 4122590700764541496, i64 7077462027059945828, i64 7003208901557969201, i64 4121464568204518713, i64 3918753317406389552, i64 3905573274727441719, i64 7365466089341596217, i64 7149572402034730034, i64 3703477736727132217, i64 4050251403442010162, i64 3775481252835123558, i64 3763097474896781670, i64 7077459832381912373, i64 7161347260934207540, i64 3487586442495288883, i64 7221910367963997496, i64 3834307538740262245, i64 7076340715036554808, i64 3559357944496730422, i64 4120906033528136240, i64 3474919876021596773, i64 3474017370268460338, i64 825833008]
@"str.19" = internal constant [16 x i64] [i64 3775484770380034097, i64 3832907659312574820, i64 7363777248101412917, i64 3774915025768166241, i64 3991091308300351331, i64 3688509900207633203, i64 7005737765433390128, i64 7292562781078041443, i64 3905804184212484708, i64 4120900729998751536, i64 3832624186373911601, i64 3630237958025001316, i64 3559078702835905890, i64 4134978682801448292, i64 4063710555194810979, i64 7292562768122950241]
@"str.20" = internal constant [1 x i64] [i64 3832619570475855728]
@"str.21" = internal constant [2 x i64] [i64 3978425819141910832, i64 7378413942531504440]
@"str.22" = internal constant [8 x i64] [i64 4050817862336787768, i64 3689402703730259765, i64 7306582649545713207, i64 4062587919546987060, i64 7005402238309904688, i64 7234525249586356838, i64 7377237478041870644, i64 7075495202738417972]
@"str.23" = internal constant [3 x i64] [i64 4120846642569031728, i64 7004276303992991792, i64 3472328296227680304]
@"str.24" = internal constant [1 x i64] [i64 5207098233617336653]
@"str.25" = internal constant [15 x i64] [i64 6998720700330828108, i64 7814992634658710638, i64 2334675641919958373, i64 8314045560103725172, i64 4123369953945395315, i64 7142789412513456186, i64 7378707224407602543, i64 8007529259098731109, i64 2334393405426723950, i64 2338053640980294004, i64 8463518681226635380, i64 8317714699121354098, i64 8031924118958207587, i64 7575166045361826933, i64 11892]
@"str.26" = internal constant [29 x i64] [i64 7005689190208922934, i64 3474590223708861746, i64 4049359695891280180, i64 3546647612326175844, i64 7162237672951855461, i64 3630798733936190513, i64 7161680400173130032, i64 7075266483600319590, i64 3846977014396434790, i64 7089003583520387637, i64 7089057459623781944, i64 3978142342693938275, i64 3761128442892072497, i64 7089002492498097765, i64 3833516766491141688, i64 4063426872735721017, i64 7377569298541393712, i64 3546128642837852213, i64 4048847357060658741, i64 7292794966973243704, i64 7220450207952155189, i64 3904682889335486001, i64 7003442003156939064, i64 3905525995003131746, i64 7377567098847256885, i64 3919647031330681911, i64 7234299669280470114, i64 3617627679936164454, i64 1681143608]
@"str.27" = internal constant [2 x i64] [i64 7070761857629513074, i64 111576429585505]
@"str.28" = internal constant [2 x i64] [i64 7164786575973572962, i64 101]
@"str.29" = internal constant [2 x i64] [i64 7309462460549850209, i64 114]
@"str.30" = internal constant [2 x i64] [i64 7598263496026189682, i64 112]
@"str.31" = internal constant [5 x i64] [i64 8243680188818879043, i64 8018131797922050145, i64 7310298023558215026, i64 8030559290070889057, i64 28789]
@"str.32" = internal constant [1 x i64] [i64 8246765057600480627]
@"str.33" = internal constant [2 x i64] [i64 8367798550312215922, i64 7104865]
@"str.34" = internal constant [2 x i64] [i64 8367816069467172975, i64 491328138593]
@"str.35" = internal constant [4 x i64] [i64 5917794109009846640, i64 7167555147578042213, i64 7017588315501389157, i64 138418680693]
@"str.36" = internal constant [2 x i64] [i64 7596551573701944676, i64 7629165]
@"str.37" = internal constant [2 x i64] [i64 8097862866615364723, i64 521644106593]
@"str.38" = internal constant [2 x i64] [i64 8458156441484616054, i64 1684370547]
@"str.39" = internal constant [2 x i64] [i64 4208741877863948332, i64 32]
@"str.40" = internal constant [1 x i64] [i64 2685]
@"str.41" = internal constant [2 x i64] [i64 7957694959391481888, i64 2322283407174100091]
@"str.42" = internal constant [2 x i64] [i64 8601708606660288556, i64 35435399443553]
@"str.43" = internal constant [1 x i64] [i64 35899498962976]
@"str.44" = internal constant [5 x i64] [i64 7309940765259427104, i64 7599578576357124455, i64 6874858533597243508, i64 2323330133470241143, i64 2608]
@"str.45" = internal constant [3 x i64] [i64 7232620951369114994, i64 8674334734093152357, i64 8250]
@"rt.psites" = internal constant [135 x i64] [i64 8725724663906307, i64 15199649732231169, i64 12103424988413955, i64 22236524149997569, i64 6755400967782401, i64 12947850639966209, i64 11259000779702275, i64 18577350174179329, i64 16044076222644226, i64 16044076222644226, i64 16044076222644226, i64 23925375570542594, i64 23925375570542594, i64 23925375570542594, i64 6473924984439041, i64 9851624704966913, i64 7036874803642881, i64 6473925353538049, i64 13229324811371009, i64 19421774299005444, i64 10977524997685763, i64 12103425357513217, i64 2814751126061569, i64 5066551157850625, i64 14636700366012929, i64 2814751344165377, i64 3940651351671297, i64 5910976188645889, i64 1688851537986049, i64 5066551275291137, i64 7036876112265729, i64 1688851554763265, i64 3940651385225729, i64 5910976222200321, i64 1688851571540481, i64 5066551308845569, i64 7036876145820161, i64 1688851588317697, i64 3940651418780161, i64 5910976255754753, i64 1688851605094913, i64 5066551342400001, i64 7036876179374593, i64 1688851621872129, i64 3940651452334593, i64 5910976289309185, i64 1688851638649345, i64 5066551375954433, i64 7036876212929025, i64 1688851655426561, i64 4503601506419204, i64 7599826250236420, i64 4785076567015937, i64 8444251264254465, i64 10977526054650372, i64 14918175728599553, i64 17451450518995460, i64 21673575169655297, i64 24206849960051204, i64 7599826418008579, i64 8725726341628420, i64 7599826434785795, i64 8725726358405636, i64 7599826451563011, i64 8725726375182852, i64 7599826468340227, i64 8725725905421057, i64 8162776035885825, i64 8444251180368641, i64 8725726475846401, i64 7881301646377729, i64 22236525676724994, i64 22236525676724994, i64 22236525676724994, i64 7881302049030913, i64 8444249838191620, i64 6755400011482116, i64 7599825310712836, i64 7599825327490052, i64 7599825344267268, i64 7881300337755140, i64 10696050557846532, i64 10133100637979652, i64 10133100654756868, i64 10133100671534084, i64 10414575665021956, i64 6473926108513284, i64 6473926142067716, i64 6473926175622148, i64 6473926209176580, i64 6473926242731012, i64 6473926259508228, i64 10414576185115649, i64 4785076869006340, i64 3377702035784708, i64 3377702086116356, i64 3377702136448004, i64 3377702186779652, i64 3377702270665732, i64 3377702320997380, i64 3377702371329028, i64 3377702421660676, i64 6473927199032324, i64 4503602378834948, i64 5910977379828740, i64 4503602513052676, i64 7881302233580548, i64 4503602529829892, i64 8162777227068420, i64 4503602546607108, i64 8162777243845636, i64 9288677217797124, i64 9288677251351556, i64 9288677284905988, i64 4785077774976001, i64 8444252472214529, i64 10977527262610436, i64 14918176936559617, i64 17451451726955524, i64 21673576377615361, i64 24206851168011268, i64 7599827625968643, i64 8725727549588484, i64 7599827642745859, i64 8725727566365700, i64 7599827659523075, i64 8725727583142916, i64 7599827676300291, i64 5348024825939201, i64 10133099446797572, i64 9288674516665601, i64 9288674533442817, i64 6755400045036801, i64 6755400061814017, i64 8725724965897475]
@"str.46" = internal constant [1 x i64] [i64 9071397899755888]
@"str.47" = internal constant [3 x i64] [i64 8462017926321696361, i64 7953763900396085364, i64 25959]
@"str.48" = internal constant [4 x i64] [i64 8026013105759284339, i64 8391735665840385653, i64 7453001576142499616, i64 101]
@"str.49" = internal constant [4 x i64] [i64 8462017844986274166, i64 7953763900396085364, i64 7070777237752014183, i64 6648953]
@"str.50" = internal constant [3 x i64] [i64 7311146993653867886, i64 6998721804137689888, i64 500069396333]
@"str.51" = internal constant [3 x i64] [i64 2338042651316874857, i64 7070762896912181604, i64 122537119457401]
@"str.52" = internal constant [2 x i64] [i64 8388345085396285541, i64 2965729659098066976]
@"str.53" = internal constant [3 x i64] [i64 7018969289221893749, i64 7306086967037750370, i64 7234303152485659168]
@"str.54" = internal constant [1 x i64] [i64 544497952]
@"str.55" = internal constant [4 x i64] [i64 7160564478436274787, i64 8084016725074600296, i64 3329620495941856367, i64 491327221619]
@"str.56" = internal constant [3 x i64] [i64 8104634774752359539, i64 8030813637946863476, i64 7497058]
@"str.57" = internal constant [5 x i64] [i64 8104634774752359539, i64 7521962903607406452, i64 7161119657698538081, i64 7093014580346118504, i64 29285]
@"str.58" = internal constant [7 x i64] [i64 8104634774752359539, i64 7521962903607406452, i64 3564999805919834721, i64 7161119657698865203, i64 8749490703709659496, i64 7093014580429861681, i64 29285]
@"str.59" = internal constant [5 x i64] [i64 8104634774752359539, i64 3564999805919784820, i64 8749490703693066291, i64 7093014580429861681, i64 29285]
@"str.60" = internal constant [3 x i64] [i64 3420595415134008435, i64 7305524086039930216, i64 114]

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
  %v3 = getelementptr i64, ptr @"str.35", i64 0
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
  %v29 = getelementptr i64, ptr @"str.39", i64 0
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
  %v35 = getelementptr i64, ptr @"str.40", i64 0
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
  %v10 = getelementptr i64, ptr @"str.36", i64 0
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
  %v17 = getelementptr i64, ptr @"str.37", i64 0
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
  %v24 = getelementptr i64, ptr @"str.38", i64 0
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
  %v60 = getelementptr i64, ptr @"str.41", i64 0
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
  %v65 = getelementptr i64, ptr @"str.42", i64 0
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
  %v70 = getelementptr i64, ptr @"str.40", i64 0
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
  %v81 = getelementptr i64, ptr @"str.43", i64 0
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
  %v88 = getelementptr i64, ptr @"str.44", i64 0
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
  %v17 = getelementptr i64, ptr @"str.45", i64 0
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
  %v22 = getelementptr i64, ptr @"str.40", i64 0
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

define internal void @"main.seq"(ptr %v0, i64 %v1, i64 %v2) #0 {
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
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %v3.p = getelementptr i64, ptr %v72, i64 0
  %v3 = load i64, ptr %v3.p
  %v4 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v4, i64 2571
  %v5 = load i64, ptr %v5.p
  %v6 = add i64 0, 0
  %st0 = getelementptr i64, ptr %v4, i64 2571
  store i64 %v6, ptr %st0
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
  %v15 = call ptr @"rt.region_alloc8"(i64 %v13, i64 %v14)
  %v16 = add i64 0, 0
  %v17 = getelementptr i64, ptr %s0, i64 0
  %v18 = ptrtoint ptr %v15 to i64
  %st1 = getelementptr i64, ptr %v17, i64 0
  store i64 %v18, ptr %st1
  %st2 = getelementptr i64, ptr %v17, i64 1
  store i64 %v16, ptr %st2
  %st3 = getelementptr i64, ptr %v17, i64 2
  store i64 %v13, ptr %st3
  %v19 = getelementptr i64, ptr %s1, i64 0
  %v20.p = getelementptr i64, ptr %v17, i64 0
  %v20 = load i64, ptr %v20.p
  %st4 = getelementptr i64, ptr %v19, i64 0
  store i64 %v20, ptr %st4
  %v21.p = getelementptr i64, ptr %v17, i64 1
  %v21 = load i64, ptr %v21.p
  %st5 = getelementptr i64, ptr %v19, i64 1
  store i64 %v21, ptr %st5
  %v22.p = getelementptr i64, ptr %v17, i64 2
  %v22 = load i64, ptr %v22.p
  %st6 = getelementptr i64, ptr %v19, i64 2
  store i64 %v22, ptr %st6
  %v73 = getelementptr i64, ptr @"rt.meta", i64 0
  %v23.p = getelementptr i64, ptr %v73, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 1
  %v25 = add i64 %v2, %v24
  %v26 = getelementptr i64, ptr %s2, i64 0
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v74, i64 0
  %v27 = load i64, ptr %v27.p
  %v28 = getelementptr i64, ptr %s3, i64 0
  %st7 = getelementptr i64, ptr %v28, i64 0
  store i64 %v1, ptr %st7
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v75, i64 0
  %v29 = load i64, ptr %v29.p
  br label %b3
b1:
  %v76 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v76, i64 0
  store i64 %v23, ptr %st8
  %v69.p = getelementptr i64, ptr %v19, i64 0
  %v69 = load i64, ptr %v69.p
  %st9 = getelementptr i64, ptr %v0, i64 0
  store i64 %v69, ptr %st9
  %v70.p = getelementptr i64, ptr %v19, i64 1
  %v70 = load i64, ptr %v70.p
  %st10 = getelementptr i64, ptr %v0, i64 1
  store i64 %v70, ptr %st10
  %v71.p = getelementptr i64, ptr %v19, i64 2
  %v71 = load i64, ptr %v71.p
  %st11 = getelementptr i64, ptr %v0, i64 2
  store i64 %v71, ptr %st11
  call void @"rt.region_relocate8"(ptr %v0, i64 %v3)
  %v77 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v77, i64 0
  store i64 %v3, ptr %st12
  ret void
b2:
  br label %b1
b3:
  %v78 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v78, i64 0
  store i64 %v29, ptr %st13
  %v30.p = getelementptr i64, ptr %v28, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.c = icmp slt i64 %v30, %v25
  %v31 = zext i1 %v31.c to i64
  %c.b3 = icmp ne i64 %v31, 0
  br i1 %c.b3, label %b3.t15, label %b3.e16
b3.t15:
  br label %b4
b3.e16:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v79, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v28, i64 0
  %v33 = load i64, ptr %v33.p
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v80, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 1
  %v36 = add i64 %v3, %v35
  %v37 = getelementptr i64, ptr %s0, i64 0
  %v38.p = getelementptr i64, ptr %v19, i64 0
  %v38 = load i64, ptr %v38.p
  %st16 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st16
  %v39.p = getelementptr i64, ptr %v19, i64 1
  %v39 = load i64, ptr %v39.p
  %st17 = getelementptr i64, ptr %v37, i64 1
  store i64 %v39, ptr %st17
  %v40.p = getelementptr i64, ptr %v19, i64 2
  %v40 = load i64, ptr %v40.p
  %st18 = getelementptr i64, ptr %v37, i64 2
  store i64 %v40, ptr %st18
  %v41 = add i64 0, 256
  %v42.c = icmp uge i64 %v33, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b4 = icmp ne i64 %v42, 0
  br i1 %c.b4, label %b4.t20, label %b4.e21
b4.t20:
  br label %b7
b4.e21:
  br label %b8
b5:
  %v81 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v81, i64 0
  store i64 %v29, ptr %st21
  br label %b2
b6:
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v82, i64 0
  store i64 %v34, ptr %st22
  %v66 = add i64 0, 1
  %v67.p = getelementptr i64, ptr %v28, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 %v67, %v66
  %st23 = getelementptr i64, ptr %v28, i64 0
  store i64 %v68, ptr %st23
  br label %b3
b7:
  %v43 = add i64 0, 0
  call void @"rt.panic"(i64 %v43)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v44.p = getelementptr i64, ptr %v37, i64 2
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v37, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v37, i64 1
  %v46 = load i64, ptr %v46.p
  %v49 = add i64 %v45, %v46
  %v50 = call i64 @"rt.tip8"(i64 %v44, i64 %v49)
  %v51 = add i64 0, 0
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b8 = icmp ne i64 %v52, 0
  br i1 %c.b8, label %b8.t25, label %b8.e26
b8.t25:
  br label %b11
b8.e26:
  br label %b10
b9:
  %v47 = phi ptr [ %v56, %b10 ], [ %v53, %b11 ]
  %v48 = phi ptr [ %v57, %b10 ], [ %v54, %b11 ]
  %st26 = getelementptr i8, ptr %v48, i64 0
  %st26.b = trunc i64 %v33 to i8
  store i8 %st26.b, ptr %st26
  %v58.p = getelementptr i64, ptr %v37, i64 1
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 1
  %v60 = add i64 %v58, %v59
  %v61 = getelementptr i64, ptr %s4, i64 0
  %v62 = ptrtoint ptr %v47 to i64
  %st27 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st27
  %st28 = getelementptr i64, ptr %v61, i64 1
  store i64 %v60, ptr %st28
  %st29 = getelementptr i64, ptr %v61, i64 2
  store i64 %v44, ptr %st29
  %v63.p = getelementptr i64, ptr %v61, i64 0
  %v63 = load i64, ptr %v63.p
  %st30 = getelementptr i64, ptr %v19, i64 0
  store i64 %v63, ptr %st30
  %v64.p = getelementptr i64, ptr %v61, i64 1
  %v64 = load i64, ptr %v64.p
  %st31 = getelementptr i64, ptr %v19, i64 1
  store i64 %v64, ptr %st31
  %v65.p = getelementptr i64, ptr %v61, i64 2
  %v65 = load i64, ptr %v65.p
  %st32 = getelementptr i64, ptr %v19, i64 2
  store i64 %v65, ptr %st32
  br label %b6
b10:
  %v55 = add i64 0, 1
  %v56 = call ptr @"rt.slice_grow8"(i64 %v45, i64 %v46, i64 %v44, i64 %v55)
  %v57 = getelementptr i8, ptr %v56, i64 %v46
  br label %b9
b11:
  %v53 = inttoptr i64 %v45 to ptr
  %v54 = getelementptr i8, ptr %v53, i64 %v46
  br label %b9
}

define internal void @"main.check"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8) #0 {
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
  %v9 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v9, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v9, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v9, i64 2
  store i64 %v2, ptr %st2
  %v10 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v10, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v10, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v10, i64 2
  store i64 %v5, ptr %st5
  %v11 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v11, i64 0
  store i64 %v6, ptr %st6
  %st7 = getelementptr i64, ptr %v11, i64 1
  store i64 %v7, ptr %st7
  %st8 = getelementptr i64, ptr %v11, i64 2
  store i64 %v8, ptr %st8
  %v44 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v44, i64 0
  %v12 = load i64, ptr %v12.p
  call void @"rt.region_enter"()
  %v13.p = getelementptr i64, ptr %v10, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v10, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v10, i64 2
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v11, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v11, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v11, i64 2
  %v19 = load i64, ptr %v19.p
  call void @"main.unhex"(ptr %v16, i64 %v17, i64 %v18, i64 %v19)
  %v20.p = getelementptr i64, ptr %v16, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v16, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v16, i64 2
  %v22 = load i64, ptr %v22.p
  %v23 = call i64 @"std/crypto.Equal"(i64 %v13, i64 %v14, i64 %v15, i64 %v20, i64 %v21, i64 %v22)
  %c.b0 = icmp ne i64 %v23, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b1
b0.e11:
  br label %b2
b1:
  br label %b3
b2:
  %v24 = getelementptr i64, ptr @"str.24", i64 0
  %v25 = add i64 0, 8
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s4, i64 0
  %v28 = ptrtoint ptr %v24 to i64
  %st11 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st11
  %st12 = getelementptr i64, ptr %v27, i64 1
  store i64 %v25, ptr %st12
  %st13 = getelementptr i64, ptr %v27, i64 2
  store i64 %v26, ptr %st13
  br label %b3
b3:
  %v29 = phi ptr [ %v11, %b1 ], [ %v27, %b2 ]
  %c.b3 = icmp ne i64 %v23, 0
  br i1 %c.b3, label %b3.t15, label %b3.e16
b3.t15:
  br label %b4
b3.e16:
  br label %b5
b4:
  %v30 = getelementptr i64, ptr @"str.0", i64 0
  %v31 = add i64 0, 2
  %v32 = add i64 0, 0
  %v33 = getelementptr i64, ptr %s5, i64 0
  %v34 = ptrtoint ptr %v30 to i64
  %st16 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st16
  %st17 = getelementptr i64, ptr %v33, i64 1
  store i64 %v31, ptr %st17
  %st18 = getelementptr i64, ptr %v33, i64 2
  store i64 %v32, ptr %st18
  br label %b6
b5:
  %v35 = getelementptr i64, ptr @"str.24", i64 0
  %v36 = add i64 0, 8
  %v37 = add i64 0, 0
  %v38 = getelementptr i64, ptr %s6, i64 0
  %v39 = ptrtoint ptr %v35 to i64
  %st19 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st19
  %st20 = getelementptr i64, ptr %v38, i64 1
  store i64 %v36, ptr %st20
  %st21 = getelementptr i64, ptr %v38, i64 2
  store i64 %v37, ptr %st21
  br label %b6
b6:
  %v40 = phi ptr [ %v33, %b4 ], [ %v38, %b5 ]
  call void @"rt.print_str"(ptr %v9)
  %v41 = add i64 0, 32
  call void @"rt.print_char"(i64 %v41)
  call void @"rt.print_str"(ptr %v29)
  %v42 = add i64 0, 32
  call void @"rt.print_char"(i64 %v42)
  call void @"rt.print_str"(ptr %v40)
  %v43 = add i64 0, 10
  call void @"rt.print_char"(i64 %v43)
  %v45 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v45, i64 0
  store i64 %v12, ptr %st22
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
  %s19 = alloca [8 x i64], align 8
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
  %s20 = alloca [5 x i64], align 8
  %s20.z0 = getelementptr i64, ptr %s20, i64 0
  store i64 0, ptr %s20.z0
  %s20.z1 = getelementptr i64, ptr %s20, i64 1
  store i64 0, ptr %s20.z1
  %s20.z2 = getelementptr i64, ptr %s20, i64 2
  store i64 0, ptr %s20.z2
  %s20.z3 = getelementptr i64, ptr %s20, i64 3
  store i64 0, ptr %s20.z3
  %s20.z4 = getelementptr i64, ptr %s20, i64 4
  store i64 0, ptr %s20.z4
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
  %s23 = alloca [8 x i64], align 8
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
  %s23.z5 = getelementptr i64, ptr %s23, i64 5
  store i64 0, ptr %s23.z5
  %s23.z6 = getelementptr i64, ptr %s23, i64 6
  store i64 0, ptr %s23.z6
  %s23.z7 = getelementptr i64, ptr %s23, i64 7
  store i64 0, ptr %s23.z7
  %s24 = alloca [5 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s24.z1 = getelementptr i64, ptr %s24, i64 1
  store i64 0, ptr %s24.z1
  %s24.z2 = getelementptr i64, ptr %s24, i64 2
  store i64 0, ptr %s24.z2
  %s24.z3 = getelementptr i64, ptr %s24, i64 3
  store i64 0, ptr %s24.z3
  %s24.z4 = getelementptr i64, ptr %s24, i64 4
  store i64 0, ptr %s24.z4
  %s25 = alloca [1 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
  %s26 = alloca [1 x i64], align 8
  %s26.z0 = getelementptr i64, ptr %s26, i64 0
  store i64 0, ptr %s26.z0
  %s27 = alloca [1 x i64], align 8
  %s27.z0 = getelementptr i64, ptr %s27, i64 0
  store i64 0, ptr %s27.z0
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
  %s32 = alloca [8 x i64], align 8
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
  %s32.z6 = getelementptr i64, ptr %s32, i64 6
  store i64 0, ptr %s32.z6
  %s32.z7 = getelementptr i64, ptr %s32, i64 7
  store i64 0, ptr %s32.z7
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
  %s34 = alloca [4 x i64], align 8
  %s34.z0 = getelementptr i64, ptr %s34, i64 0
  store i64 0, ptr %s34.z0
  %s34.z1 = getelementptr i64, ptr %s34, i64 1
  store i64 0, ptr %s34.z1
  %s34.z2 = getelementptr i64, ptr %s34, i64 2
  store i64 0, ptr %s34.z2
  %s34.z3 = getelementptr i64, ptr %s34, i64 3
  store i64 0, ptr %s34.z3
  %s35 = alloca [8 x i64], align 8
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
  %s36 = alloca [3 x i64], align 8
  %s36.z0 = getelementptr i64, ptr %s36, i64 0
  store i64 0, ptr %s36.z0
  %s36.z1 = getelementptr i64, ptr %s36, i64 1
  store i64 0, ptr %s36.z1
  %s36.z2 = getelementptr i64, ptr %s36, i64 2
  store i64 0, ptr %s36.z2
  %s37 = alloca [8 x i64], align 8
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
  %s37.z5 = getelementptr i64, ptr %s37, i64 5
  store i64 0, ptr %s37.z5
  %s37.z6 = getelementptr i64, ptr %s37, i64 6
  store i64 0, ptr %s37.z6
  %s37.z7 = getelementptr i64, ptr %s37, i64 7
  store i64 0, ptr %s37.z7
  %s38 = alloca [3 x i64], align 8
  %s38.z0 = getelementptr i64, ptr %s38, i64 0
  store i64 0, ptr %s38.z0
  %s38.z1 = getelementptr i64, ptr %s38, i64 1
  store i64 0, ptr %s38.z1
  %s38.z2 = getelementptr i64, ptr %s38, i64 2
  store i64 0, ptr %s38.z2
  %s39 = alloca [5 x i64], align 8
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
  %s40 = alloca [3 x i64], align 8
  %s40.z0 = getelementptr i64, ptr %s40, i64 0
  store i64 0, ptr %s40.z0
  %s40.z1 = getelementptr i64, ptr %s40, i64 1
  store i64 0, ptr %s40.z1
  %s40.z2 = getelementptr i64, ptr %s40, i64 2
  store i64 0, ptr %s40.z2
  %s41 = alloca [8 x i64], align 8
  %s41.z0 = getelementptr i64, ptr %s41, i64 0
  store i64 0, ptr %s41.z0
  %s41.z1 = getelementptr i64, ptr %s41, i64 1
  store i64 0, ptr %s41.z1
  %s41.z2 = getelementptr i64, ptr %s41, i64 2
  store i64 0, ptr %s41.z2
  %s41.z3 = getelementptr i64, ptr %s41, i64 3
  store i64 0, ptr %s41.z3
  %s41.z4 = getelementptr i64, ptr %s41, i64 4
  store i64 0, ptr %s41.z4
  %s41.z5 = getelementptr i64, ptr %s41, i64 5
  store i64 0, ptr %s41.z5
  %s41.z6 = getelementptr i64, ptr %s41, i64 6
  store i64 0, ptr %s41.z6
  %s41.z7 = getelementptr i64, ptr %s41, i64 7
  store i64 0, ptr %s41.z7
  %s42 = alloca [8 x i64], align 8
  %s42.z0 = getelementptr i64, ptr %s42, i64 0
  store i64 0, ptr %s42.z0
  %s42.z1 = getelementptr i64, ptr %s42, i64 1
  store i64 0, ptr %s42.z1
  %s42.z2 = getelementptr i64, ptr %s42, i64 2
  store i64 0, ptr %s42.z2
  %s42.z3 = getelementptr i64, ptr %s42, i64 3
  store i64 0, ptr %s42.z3
  %s42.z4 = getelementptr i64, ptr %s42, i64 4
  store i64 0, ptr %s42.z4
  %s42.z5 = getelementptr i64, ptr %s42, i64 5
  store i64 0, ptr %s42.z5
  %s42.z6 = getelementptr i64, ptr %s42, i64 6
  store i64 0, ptr %s42.z6
  %s42.z7 = getelementptr i64, ptr %s42, i64 7
  store i64 0, ptr %s42.z7
  %v669 = getelementptr i64, ptr @"rt.meta", i64 0
  %v0.p = getelementptr i64, ptr %v669, i64 0
  %v0 = load i64, ptr %v0.p
  call void @"rt.region_enter"()
  %v1 = getelementptr i64, ptr %s0, i64 0
  %v2 = add i64 0, 0
  %v3 = add i64 0, 31
  call void @"main.seq"(ptr %v1, i64 %v2, i64 %v3)
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
  %v8 = getelementptr i64, ptr @"str.3", i64 0
  %v9 = add i64 0, 5
  %v10 = add i64 0, 0
  %v11 = getelementptr i64, ptr %s2, i64 0
  %v12 = ptrtoint ptr %v8 to i64
  %st3 = getelementptr i64, ptr %v11, i64 0
  store i64 %v12, ptr %st3
  %st4 = getelementptr i64, ptr %v11, i64 1
  store i64 %v9, ptr %st4
  %st5 = getelementptr i64, ptr %v11, i64 2
  store i64 %v10, ptr %st5
  %v13.p = getelementptr i64, ptr %v11, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v11, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v11, i64 2
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr %s3, i64 0
  %v17.p = getelementptr i64, ptr %v4, i64 0
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v4, i64 1
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v4, i64 2
  %v19 = load i64, ptr %v19.p
  %v20 = getelementptr i64, ptr %s4, i64 0
  %v21 = getelementptr i64, ptr @"str.23", i64 0
  %v22 = add i64 0, 24
  %v23 = add i64 0, 0
  %v24 = getelementptr i64, ptr %s5, i64 0
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
  %v32 = add i64 0, 1
  call void @"std/crypto/chacha20.Block"(ptr %v16, i64 %v17, i64 %v18, i64 %v19, i64 %v29, i64 %v30, i64 %v31, i64 %v32)
  %v33.p = getelementptr i64, ptr %v16, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v16, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v16, i64 2
  %v35 = load i64, ptr %v35.p
  %v36 = getelementptr i64, ptr @"str.19", i64 0
  %v37 = add i64 0, 128
  %v38 = add i64 0, 0
  %v39 = getelementptr i64, ptr %s6, i64 0
  %v40 = ptrtoint ptr %v36 to i64
  %st9 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st9
  %st10 = getelementptr i64, ptr %v39, i64 1
  store i64 %v37, ptr %st10
  %st11 = getelementptr i64, ptr %v39, i64 2
  store i64 %v38, ptr %st11
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v39, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.p = getelementptr i64, ptr %v39, i64 2
  %v43 = load i64, ptr %v43.p
  call void @"main.check"(i64 %v13, i64 %v14, i64 %v15, i64 %v33, i64 %v34, i64 %v35, i64 %v41, i64 %v42, i64 %v43)
  %v44 = getelementptr i64, ptr @"str.25", i64 0
  %v45 = add i64 0, 114
  %v46 = add i64 0, 0
  %v47 = getelementptr i64, ptr %s6, i64 0
  %v48 = ptrtoint ptr %v44 to i64
  %st12 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st12
  %st13 = getelementptr i64, ptr %v47, i64 1
  store i64 %v45, ptr %st13
  %st14 = getelementptr i64, ptr %v47, i64 2
  store i64 %v46, ptr %st14
  %v49 = getelementptr i64, ptr %s5, i64 0
  %v50.p = getelementptr i64, ptr %v47, i64 0
  %v50 = load i64, ptr %v50.p
  %st15 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st15
  %v51.p = getelementptr i64, ptr %v47, i64 1
  %v51 = load i64, ptr %v51.p
  %st16 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st16
  %v52.p = getelementptr i64, ptr %v47, i64 2
  %v52 = load i64, ptr %v52.p
  %st17 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st17
  %v53 = getelementptr i64, ptr %s7, i64 0
  %v54.p = getelementptr i64, ptr %v4, i64 0
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v4, i64 1
  %v55 = load i64, ptr %v55.p
  %v56.p = getelementptr i64, ptr %v4, i64 2
  %v56 = load i64, ptr %v56.p
  %v57 = getelementptr i64, ptr %s8, i64 0
  %v58 = getelementptr i64, ptr @"str.10", i64 0
  %v59 = add i64 0, 24
  %v60 = add i64 0, 0
  %v61 = getelementptr i64, ptr %s6, i64 0
  %v62 = ptrtoint ptr %v58 to i64
  %st18 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st18
  %st19 = getelementptr i64, ptr %v61, i64 1
  store i64 %v59, ptr %st19
  %st20 = getelementptr i64, ptr %v61, i64 2
  store i64 %v60, ptr %st20
  %v63.p = getelementptr i64, ptr %v61, i64 0
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v61, i64 1
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v61, i64 2
  %v65 = load i64, ptr %v65.p
  call void @"main.unhex"(ptr %v57, i64 %v63, i64 %v64, i64 %v65)
  %v66.p = getelementptr i64, ptr %v57, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v57, i64 1
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v57, i64 2
  %v68 = load i64, ptr %v68.p
  %v69 = add i64 0, 1
  %v70.p = getelementptr i64, ptr %v49, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v49, i64 1
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v49, i64 2
  %v72 = load i64, ptr %v72.p
  call void @"std/crypto/chacha20.XorKeyStream"(ptr %v53, i64 %v54, i64 %v55, i64 %v56, i64 %v66, i64 %v67, i64 %v68, i64 %v69, i64 %v70, i64 %v71, i64 %v72)
  %v73 = getelementptr i64, ptr %s2, i64 0
  %v74.p = getelementptr i64, ptr %v53, i64 0
  %v74 = load i64, ptr %v74.p
  %st21 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st21
  %v75.p = getelementptr i64, ptr %v53, i64 1
  %v75 = load i64, ptr %v75.p
  %st22 = getelementptr i64, ptr %v73, i64 1
  store i64 %v75, ptr %st22
  %v76.p = getelementptr i64, ptr %v53, i64 2
  %v76 = load i64, ptr %v76.p
  %st23 = getelementptr i64, ptr %v73, i64 2
  store i64 %v76, ptr %st23
  %v77 = getelementptr i64, ptr @"str.9", i64 0
  %v78 = add i64 0, 7
  %v79 = add i64 0, 0
  %v80 = getelementptr i64, ptr %s6, i64 0
  %v81 = ptrtoint ptr %v77 to i64
  %st24 = getelementptr i64, ptr %v80, i64 0
  store i64 %v81, ptr %st24
  %st25 = getelementptr i64, ptr %v80, i64 1
  store i64 %v78, ptr %st25
  %st26 = getelementptr i64, ptr %v80, i64 2
  store i64 %v79, ptr %st26
  %v82.p = getelementptr i64, ptr %v80, i64 0
  %v82 = load i64, ptr %v82.p
  %v83.p = getelementptr i64, ptr %v80, i64 1
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v80, i64 2
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v73, i64 0
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v73, i64 1
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v73, i64 2
  %v87 = load i64, ptr %v87.p
  %v88 = getelementptr i64, ptr @"str.26", i64 0
  %v89 = add i64 0, 228
  %v90 = add i64 0, 0
  %v91 = getelementptr i64, ptr %s9, i64 0
  %v92 = ptrtoint ptr %v88 to i64
  %st27 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st27
  %st28 = getelementptr i64, ptr %v91, i64 1
  store i64 %v89, ptr %st28
  %st29 = getelementptr i64, ptr %v91, i64 2
  store i64 %v90, ptr %st29
  %v93.p = getelementptr i64, ptr %v91, i64 0
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v91, i64 1
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v91, i64 2
  %v95 = load i64, ptr %v95.p
  call void @"main.check"(i64 %v82, i64 %v83, i64 %v84, i64 %v85, i64 %v86, i64 %v87, i64 %v93, i64 %v94, i64 %v95)
  %v96 = getelementptr i64, ptr @"str.8", i64 0
  %v97 = add i64 0, 7
  %v98 = add i64 0, 0
  %v99 = getelementptr i64, ptr %s9, i64 0
  %v100 = ptrtoint ptr %v96 to i64
  %st30 = getelementptr i64, ptr %v99, i64 0
  store i64 %v100, ptr %st30
  %st31 = getelementptr i64, ptr %v99, i64 1
  store i64 %v97, ptr %st31
  %st32 = getelementptr i64, ptr %v99, i64 2
  store i64 %v98, ptr %st32
  %v101 = getelementptr i64, ptr %s10, i64 0
  %v102.p = getelementptr i64, ptr %v4, i64 0
  %v102 = load i64, ptr %v102.p
  %v103.p = getelementptr i64, ptr %v4, i64 1
  %v103 = load i64, ptr %v103.p
  %v104.p = getelementptr i64, ptr %v4, i64 2
  %v104 = load i64, ptr %v104.p
  %v105 = getelementptr i64, ptr %s11, i64 0
  %v106 = getelementptr i64, ptr @"str.10", i64 0
  %v107 = add i64 0, 24
  %v108 = add i64 0, 0
  %v109 = getelementptr i64, ptr %s6, i64 0
  %v110 = ptrtoint ptr %v106 to i64
  %st33 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st33
  %st34 = getelementptr i64, ptr %v109, i64 1
  store i64 %v107, ptr %st34
  %st35 = getelementptr i64, ptr %v109, i64 2
  store i64 %v108, ptr %st35
  %v111.p = getelementptr i64, ptr %v109, i64 0
  %v111 = load i64, ptr %v111.p
  %v112.p = getelementptr i64, ptr %v109, i64 1
  %v112 = load i64, ptr %v112.p
  %v113.p = getelementptr i64, ptr %v109, i64 2
  %v113 = load i64, ptr %v113.p
  call void @"main.unhex"(ptr %v105, i64 %v111, i64 %v112, i64 %v113)
  %v114.p = getelementptr i64, ptr %v105, i64 0
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v105, i64 1
  %v115 = load i64, ptr %v115.p
  %v116.p = getelementptr i64, ptr %v105, i64 2
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 1
  %v118.p = getelementptr i64, ptr %v73, i64 0
  %v118 = load i64, ptr %v118.p
  %v119.p = getelementptr i64, ptr %v73, i64 1
  %v119 = load i64, ptr %v119.p
  %v120.p = getelementptr i64, ptr %v73, i64 2
  %v120 = load i64, ptr %v120.p
  call void @"std/crypto/chacha20.XorKeyStream"(ptr %v101, i64 %v102, i64 %v103, i64 %v104, i64 %v114, i64 %v115, i64 %v116, i64 %v117, i64 %v118, i64 %v119, i64 %v120)
  %v121.p = getelementptr i64, ptr %v101, i64 0
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v101, i64 1
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v101, i64 2
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v49, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v49, i64 1
  %v125 = load i64, ptr %v125.p
  %v126.p = getelementptr i64, ptr %v49, i64 2
  %v126 = load i64, ptr %v126.p
  %v127 = call i64 @"std/crypto.Equal"(i64 %v121, i64 %v122, i64 %v123, i64 %v124, i64 %v125, i64 %v126)
  call void @"rt.print_str"(ptr %v99)
  %v128 = add i64 0, 32
  call void @"rt.print_char"(i64 %v128)
  %c.b0 = icmp ne i64 %v127, 0
  br i1 %c.b0, label %b0.t37, label %b0.e38
b0.t37:
  br label %b1
b0.e38:
  br label %b2
b1:
  %v129 = add i64 0, 116
  call void @"rt.print_char"(i64 %v129)
  %v130 = add i64 0, 114
  call void @"rt.print_char"(i64 %v130)
  %v131 = add i64 0, 117
  call void @"rt.print_char"(i64 %v131)
  %v132 = add i64 0, 101
  call void @"rt.print_char"(i64 %v132)
  br label %b3
b2:
  %v133 = add i64 0, 102
  call void @"rt.print_char"(i64 %v133)
  %v134 = add i64 0, 97
  call void @"rt.print_char"(i64 %v134)
  %v135 = add i64 0, 108
  call void @"rt.print_char"(i64 %v135)
  %v136 = add i64 0, 115
  call void @"rt.print_char"(i64 %v136)
  %v137 = add i64 0, 101
  call void @"rt.print_char"(i64 %v137)
  br label %b3
b3:
  %v138 = add i64 0, 10
  call void @"rt.print_char"(i64 %v138)
  %v139 = getelementptr i64, ptr @"str.20", i64 0
  %v140 = add i64 0, 8
  %v141 = add i64 0, 0
  %v142 = getelementptr i64, ptr %s6, i64 0
  %v143 = ptrtoint ptr %v139 to i64
  %st38 = getelementptr i64, ptr %v142, i64 0
  store i64 %v143, ptr %st38
  %st39 = getelementptr i64, ptr %v142, i64 1
  store i64 %v140, ptr %st39
  %st40 = getelementptr i64, ptr %v142, i64 2
  store i64 %v141, ptr %st40
  %v144.p = getelementptr i64, ptr %v142, i64 0
  %v144 = load i64, ptr %v144.p
  %v145.p = getelementptr i64, ptr %v142, i64 1
  %v145 = load i64, ptr %v145.p
  %v146.p = getelementptr i64, ptr %v142, i64 2
  %v146 = load i64, ptr %v146.p
  %v147 = getelementptr i64, ptr %s12, i64 0
  %v148 = getelementptr i64, ptr %s13, i64 0
  %v149 = getelementptr i64, ptr @"str.22", i64 0
  %v150 = add i64 0, 64
  %v151 = add i64 0, 0
  %v152 = getelementptr i64, ptr %s9, i64 0
  %v153 = ptrtoint ptr %v149 to i64
  %st41 = getelementptr i64, ptr %v152, i64 0
  store i64 %v153, ptr %st41
  %st42 = getelementptr i64, ptr %v152, i64 1
  store i64 %v150, ptr %st42
  %st43 = getelementptr i64, ptr %v152, i64 2
  store i64 %v151, ptr %st43
  %v154.p = getelementptr i64, ptr %v152, i64 0
  %v154 = load i64, ptr %v154.p
  %v155.p = getelementptr i64, ptr %v152, i64 1
  %v155 = load i64, ptr %v155.p
  %v156.p = getelementptr i64, ptr %v152, i64 2
  %v156 = load i64, ptr %v156.p
  call void @"main.unhex"(ptr %v148, i64 %v154, i64 %v155, i64 %v156)
  %v157.p = getelementptr i64, ptr %v148, i64 0
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v148, i64 1
  %v158 = load i64, ptr %v158.p
  %v159.p = getelementptr i64, ptr %v148, i64 2
  %v159 = load i64, ptr %v159.p
  %v160 = getelementptr i64, ptr @"str.31", i64 0
  %v161 = add i64 0, 34
  %v162 = add i64 0, 0
  %v163 = getelementptr i64, ptr %s14, i64 0
  %v164 = ptrtoint ptr %v160 to i64
  %st44 = getelementptr i64, ptr %v163, i64 0
  store i64 %v164, ptr %st44
  %st45 = getelementptr i64, ptr %v163, i64 1
  store i64 %v161, ptr %st45
  %st46 = getelementptr i64, ptr %v163, i64 2
  store i64 %v162, ptr %st46
  %v165.p = getelementptr i64, ptr %v163, i64 0
  %v165 = load i64, ptr %v165.p
  %v166.p = getelementptr i64, ptr %v163, i64 1
  %v166 = load i64, ptr %v166.p
  %v167.p = getelementptr i64, ptr %v163, i64 2
  %v167 = load i64, ptr %v167.p
  call void @"std/crypto/poly1305.Sum"(ptr %v147, i64 %v157, i64 %v158, i64 %v159, i64 %v165, i64 %v166, i64 %v167)
  %v168.p = getelementptr i64, ptr %v147, i64 0
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v147, i64 1
  %v169 = load i64, ptr %v169.p
  %v170.p = getelementptr i64, ptr %v147, i64 2
  %v170 = load i64, ptr %v170.p
  %v171 = getelementptr i64, ptr @"str.15", i64 0
  %v172 = add i64 0, 32
  %v173 = add i64 0, 0
  %v174 = getelementptr i64, ptr %s15, i64 0
  %v175 = ptrtoint ptr %v171 to i64
  %st47 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st47
  %st48 = getelementptr i64, ptr %v174, i64 1
  store i64 %v172, ptr %st48
  %st49 = getelementptr i64, ptr %v174, i64 2
  store i64 %v173, ptr %st49
  %v176.p = getelementptr i64, ptr %v174, i64 0
  %v176 = load i64, ptr %v176.p
  %v177.p = getelementptr i64, ptr %v174, i64 1
  %v177 = load i64, ptr %v177.p
  %v178.p = getelementptr i64, ptr %v174, i64 2
  %v178 = load i64, ptr %v178.p
  call void @"main.check"(i64 %v144, i64 %v145, i64 %v146, i64 %v168, i64 %v169, i64 %v170, i64 %v176, i64 %v177, i64 %v178)
  %v179 = getelementptr i64, ptr %s16, i64 0
  %v180 = add i64 0, 128
  %v181 = add i64 0, 159
  call void @"main.seq"(ptr %v179, i64 %v180, i64 %v181)
  %v182 = getelementptr i64, ptr %s15, i64 0
  %v183.p = getelementptr i64, ptr %v179, i64 0
  %v183 = load i64, ptr %v183.p
  %st50 = getelementptr i64, ptr %v182, i64 0
  store i64 %v183, ptr %st50
  %v184.p = getelementptr i64, ptr %v179, i64 1
  %v184 = load i64, ptr %v184.p
  %st51 = getelementptr i64, ptr %v182, i64 1
  store i64 %v184, ptr %st51
  %v185.p = getelementptr i64, ptr %v179, i64 2
  %v185 = load i64, ptr %v185.p
  %st52 = getelementptr i64, ptr %v182, i64 2
  store i64 %v185, ptr %st52
  %v186 = getelementptr i64, ptr %s17, i64 0
  %v187 = getelementptr i64, ptr @"str.12", i64 0
  %v188 = add i64 0, 24
  %v189 = add i64 0, 0
  %v190 = getelementptr i64, ptr %s14, i64 0
  %v191 = ptrtoint ptr %v187 to i64
  %st53 = getelementptr i64, ptr %v190, i64 0
  store i64 %v191, ptr %st53
  %st54 = getelementptr i64, ptr %v190, i64 1
  store i64 %v188, ptr %st54
  %st55 = getelementptr i64, ptr %v190, i64 2
  store i64 %v189, ptr %st55
  %v192.p = getelementptr i64, ptr %v190, i64 0
  %v192 = load i64, ptr %v192.p
  %v193.p = getelementptr i64, ptr %v190, i64 1
  %v193 = load i64, ptr %v193.p
  %v194.p = getelementptr i64, ptr %v190, i64 2
  %v194 = load i64, ptr %v194.p
  call void @"main.unhex"(ptr %v186, i64 %v192, i64 %v193, i64 %v194)
  %v195 = getelementptr i64, ptr %s9, i64 0
  %v196.p = getelementptr i64, ptr %v186, i64 0
  %v196 = load i64, ptr %v196.p
  %st56 = getelementptr i64, ptr %v195, i64 0
  store i64 %v196, ptr %st56
  %v197.p = getelementptr i64, ptr %v186, i64 1
  %v197 = load i64, ptr %v197.p
  %st57 = getelementptr i64, ptr %v195, i64 1
  store i64 %v197, ptr %st57
  %v198.p = getelementptr i64, ptr %v186, i64 2
  %v198 = load i64, ptr %v198.p
  %st58 = getelementptr i64, ptr %v195, i64 2
  store i64 %v198, ptr %st58
  %v199 = getelementptr i64, ptr %s18, i64 0
  %v200 = getelementptr i64, ptr @"str.16", i64 0
  %v201 = add i64 0, 24
  %v202 = add i64 0, 0
  %v203 = getelementptr i64, ptr %s14, i64 0
  %v204 = ptrtoint ptr %v200 to i64
  %st59 = getelementptr i64, ptr %v203, i64 0
  store i64 %v204, ptr %st59
  %st60 = getelementptr i64, ptr %v203, i64 1
  store i64 %v201, ptr %st60
  %st61 = getelementptr i64, ptr %v203, i64 2
  store i64 %v202, ptr %st61
  %v205.p = getelementptr i64, ptr %v203, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v203, i64 1
  %v206 = load i64, ptr %v206.p
  %v207.p = getelementptr i64, ptr %v203, i64 2
  %v207 = load i64, ptr %v207.p
  call void @"main.unhex"(ptr %v199, i64 %v205, i64 %v206, i64 %v207)
  %v208 = getelementptr i64, ptr %s6, i64 0
  %v209.p = getelementptr i64, ptr %v199, i64 0
  %v209 = load i64, ptr %v209.p
  %st62 = getelementptr i64, ptr %v208, i64 0
  store i64 %v209, ptr %st62
  %v210.p = getelementptr i64, ptr %v199, i64 1
  %v210 = load i64, ptr %v210.p
  %st63 = getelementptr i64, ptr %v208, i64 1
  store i64 %v210, ptr %st63
  %v211.p = getelementptr i64, ptr %v199, i64 2
  %v211 = load i64, ptr %v211.p
  %st64 = getelementptr i64, ptr %v208, i64 2
  store i64 %v211, ptr %st64
  %v212 = getelementptr i64, ptr %s19, i64 0
  %v213.p = getelementptr i64, ptr %v182, i64 0
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v182, i64 1
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v182, i64 2
  %v215 = load i64, ptr %v215.p
  %v216.p = getelementptr i64, ptr %v195, i64 0
  %v216 = load i64, ptr %v216.p
  %v217.p = getelementptr i64, ptr %v195, i64 1
  %v217 = load i64, ptr %v217.p
  %v218.p = getelementptr i64, ptr %v195, i64 2
  %v218 = load i64, ptr %v218.p
  %v219.p = getelementptr i64, ptr %v208, i64 0
  %v219 = load i64, ptr %v219.p
  %v220.p = getelementptr i64, ptr %v208, i64 1
  %v220 = load i64, ptr %v220.p
  %v221.p = getelementptr i64, ptr %v208, i64 2
  %v221 = load i64, ptr %v221.p
  %v222.p = getelementptr i64, ptr %v49, i64 0
  %v222 = load i64, ptr %v222.p
  %v223.p = getelementptr i64, ptr %v49, i64 1
  %v223 = load i64, ptr %v223.p
  %v224.p = getelementptr i64, ptr %v49, i64 2
  %v224 = load i64, ptr %v224.p
  call void @"std/crypto/chacha20poly1305.Seal"(ptr %v212, i64 %v213, i64 %v214, i64 %v215, i64 %v216, i64 %v217, i64 %v218, i64 %v219, i64 %v220, i64 %v221, i64 %v222, i64 %v223, i64 %v224)
  %v225 = add i64 0, 3
  %v226 = getelementptr i64, ptr %v212, i64 %v225
  %v227 = getelementptr i64, ptr %s14, i64 0
  %v228.p = getelementptr i64, ptr %v212, i64 0
  %v228 = load i64, ptr %v228.p
  %st65 = getelementptr i64, ptr %v227, i64 0
  store i64 %v228, ptr %st65
  %v229.p = getelementptr i64, ptr %v212, i64 1
  %v229 = load i64, ptr %v229.p
  %st66 = getelementptr i64, ptr %v227, i64 1
  store i64 %v229, ptr %st66
  %v230.p = getelementptr i64, ptr %v212, i64 2
  %v230 = load i64, ptr %v230.p
  %st67 = getelementptr i64, ptr %v227, i64 2
  store i64 %v230, ptr %st67
  %v231 = getelementptr i64, ptr %s20, i64 0
  %v232.p = getelementptr i64, ptr %v226, i64 0
  %v232 = load i64, ptr %v232.p
  %st68 = getelementptr i64, ptr %v231, i64 0
  store i64 %v232, ptr %st68
  %v233.p = getelementptr i64, ptr %v226, i64 1
  %v233 = load i64, ptr %v233.p
  %st69 = getelementptr i64, ptr %v231, i64 1
  store i64 %v233, ptr %st69
  %v234.p = getelementptr i64, ptr %v226, i64 2
  %v234 = load i64, ptr %v234.p
  %st70 = getelementptr i64, ptr %v231, i64 2
  store i64 %v234, ptr %st70
  %v235.p = getelementptr i64, ptr %v226, i64 3
  %v235 = load i64, ptr %v235.p
  %st71 = getelementptr i64, ptr %v231, i64 3
  store i64 %v235, ptr %st71
  %v236.p = getelementptr i64, ptr %v226, i64 4
  %v236 = load i64, ptr %v236.p
  %st72 = getelementptr i64, ptr %v231, i64 4
  store i64 %v236, ptr %st72
  %v237 = getelementptr i64, ptr @"str.32", i64 0
  %v238 = add i64 0, 8
  %v239 = add i64 0, 0
  %v240 = getelementptr i64, ptr %s21, i64 0
  %v241 = ptrtoint ptr %v237 to i64
  %st73 = getelementptr i64, ptr %v240, i64 0
  store i64 %v241, ptr %st73
  %st74 = getelementptr i64, ptr %v240, i64 1
  store i64 %v238, ptr %st74
  %st75 = getelementptr i64, ptr %v240, i64 2
  store i64 %v239, ptr %st75
  %v242.p = getelementptr i64, ptr %v231, i64 0
  %v242 = load i64, ptr %v242.p
  %v243 = add i64 0, 0
  %v244.c = icmp eq i64 %v242, %v243
  %v244 = zext i1 %v244.c to i64
  call void @"rt.print_str"(ptr %v240)
  %v245 = add i64 0, 32
  call void @"rt.print_char"(i64 %v245)
  %c.b3 = icmp ne i64 %v244, 0
  br i1 %c.b3, label %b3.t77, label %b3.e78
b3.t77:
  br label %b4
b3.e78:
  br label %b5
b4:
  %v246 = add i64 0, 116
  call void @"rt.print_char"(i64 %v246)
  %v247 = add i64 0, 114
  call void @"rt.print_char"(i64 %v247)
  %v248 = add i64 0, 117
  call void @"rt.print_char"(i64 %v248)
  %v249 = add i64 0, 101
  call void @"rt.print_char"(i64 %v249)
  br label %b6
b5:
  %v250 = add i64 0, 102
  call void @"rt.print_char"(i64 %v250)
  %v251 = add i64 0, 97
  call void @"rt.print_char"(i64 %v251)
  %v252 = add i64 0, 108
  call void @"rt.print_char"(i64 %v252)
  %v253 = add i64 0, 115
  call void @"rt.print_char"(i64 %v253)
  %v254 = add i64 0, 101
  call void @"rt.print_char"(i64 %v254)
  br label %b6
b6:
  %v255 = add i64 0, 10
  call void @"rt.print_char"(i64 %v255)
  %v256 = getelementptr i64, ptr @"str.1", i64 0
  %v257 = add i64 0, 4
  %v258 = add i64 0, 0
  %v259 = getelementptr i64, ptr %s21, i64 0
  %v260 = ptrtoint ptr %v256 to i64
  %st78 = getelementptr i64, ptr %v259, i64 0
  store i64 %v260, ptr %st78
  %st79 = getelementptr i64, ptr %v259, i64 1
  store i64 %v257, ptr %st79
  %st80 = getelementptr i64, ptr %v259, i64 2
  store i64 %v258, ptr %st80
  %v261.p = getelementptr i64, ptr %v259, i64 0
  %v261 = load i64, ptr %v261.p
  %v262.p = getelementptr i64, ptr %v259, i64 1
  %v262 = load i64, ptr %v262.p
  %v263.p = getelementptr i64, ptr %v259, i64 2
  %v263 = load i64, ptr %v263.p
  %v264.p = getelementptr i64, ptr %v227, i64 0
  %v264 = load i64, ptr %v264.p
  %v265.p = getelementptr i64, ptr %v227, i64 1
  %v265 = load i64, ptr %v265.p
  %v266.p = getelementptr i64, ptr %v227, i64 2
  %v266 = load i64, ptr %v266.p
  %v267 = getelementptr i64, ptr @"str.18", i64 0
  %v268 = add i64 0, 260
  %v269 = add i64 0, 0
  %v270 = getelementptr i64, ptr %s22, i64 0
  %v271 = ptrtoint ptr %v267 to i64
  %st81 = getelementptr i64, ptr %v270, i64 0
  store i64 %v271, ptr %st81
  %st82 = getelementptr i64, ptr %v270, i64 1
  store i64 %v268, ptr %st82
  %st83 = getelementptr i64, ptr %v270, i64 2
  store i64 %v269, ptr %st83
  %v272.p = getelementptr i64, ptr %v270, i64 0
  %v272 = load i64, ptr %v272.p
  %v273.p = getelementptr i64, ptr %v270, i64 1
  %v273 = load i64, ptr %v273.p
  %v274.p = getelementptr i64, ptr %v270, i64 2
  %v274 = load i64, ptr %v274.p
  call void @"main.check"(i64 %v261, i64 %v262, i64 %v263, i64 %v264, i64 %v265, i64 %v266, i64 %v272, i64 %v273, i64 %v274)
  %v275 = getelementptr i64, ptr %s23, i64 0
  %v276.p = getelementptr i64, ptr %v182, i64 0
  %v276 = load i64, ptr %v276.p
  %v277.p = getelementptr i64, ptr %v182, i64 1
  %v277 = load i64, ptr %v277.p
  %v278.p = getelementptr i64, ptr %v182, i64 2
  %v278 = load i64, ptr %v278.p
  %v279.p = getelementptr i64, ptr %v195, i64 0
  %v279 = load i64, ptr %v279.p
  %v280.p = getelementptr i64, ptr %v195, i64 1
  %v280 = load i64, ptr %v280.p
  %v281.p = getelementptr i64, ptr %v195, i64 2
  %v281 = load i64, ptr %v281.p
  %v282.p = getelementptr i64, ptr %v208, i64 0
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v208, i64 1
  %v283 = load i64, ptr %v283.p
  %v284.p = getelementptr i64, ptr %v208, i64 2
  %v284 = load i64, ptr %v284.p
  %v285.p = getelementptr i64, ptr %v227, i64 0
  %v285 = load i64, ptr %v285.p
  %v286.p = getelementptr i64, ptr %v227, i64 1
  %v286 = load i64, ptr %v286.p
  %v287.p = getelementptr i64, ptr %v227, i64 2
  %v287 = load i64, ptr %v287.p
  call void @"std/crypto/chacha20poly1305.Open"(ptr %v275, i64 %v276, i64 %v277, i64 %v278, i64 %v279, i64 %v280, i64 %v281, i64 %v282, i64 %v283, i64 %v284, i64 %v285, i64 %v286, i64 %v287)
  %v288 = add i64 0, 3
  %v289 = getelementptr i64, ptr %v275, i64 %v288
  %v290 = getelementptr i64, ptr %s22, i64 0
  %v291.p = getelementptr i64, ptr %v275, i64 0
  %v291 = load i64, ptr %v291.p
  %st84 = getelementptr i64, ptr %v290, i64 0
  store i64 %v291, ptr %st84
  %v292.p = getelementptr i64, ptr %v275, i64 1
  %v292 = load i64, ptr %v292.p
  %st85 = getelementptr i64, ptr %v290, i64 1
  store i64 %v292, ptr %st85
  %v293.p = getelementptr i64, ptr %v275, i64 2
  %v293 = load i64, ptr %v293.p
  %st86 = getelementptr i64, ptr %v290, i64 2
  store i64 %v293, ptr %st86
  %v294 = getelementptr i64, ptr %s24, i64 0
  %v295.p = getelementptr i64, ptr %v289, i64 0
  %v295 = load i64, ptr %v295.p
  %st87 = getelementptr i64, ptr %v294, i64 0
  store i64 %v295, ptr %st87
  %v296.p = getelementptr i64, ptr %v289, i64 1
  %v296 = load i64, ptr %v296.p
  %st88 = getelementptr i64, ptr %v294, i64 1
  store i64 %v296, ptr %st88
  %v297.p = getelementptr i64, ptr %v289, i64 2
  %v297 = load i64, ptr %v297.p
  %st89 = getelementptr i64, ptr %v294, i64 2
  store i64 %v297, ptr %st89
  %v298.p = getelementptr i64, ptr %v289, i64 3
  %v298 = load i64, ptr %v298.p
  %st90 = getelementptr i64, ptr %v294, i64 3
  store i64 %v298, ptr %st90
  %v299.p = getelementptr i64, ptr %v289, i64 4
  %v299 = load i64, ptr %v299.p
  %st91 = getelementptr i64, ptr %v294, i64 4
  store i64 %v299, ptr %st91
  %v300 = getelementptr i64, ptr @"str.2", i64 0
  %v301 = add i64 0, 4
  %v302 = add i64 0, 0
  %v303 = getelementptr i64, ptr %s21, i64 0
  %v304 = ptrtoint ptr %v300 to i64
  %st92 = getelementptr i64, ptr %v303, i64 0
  store i64 %v304, ptr %st92
  %st93 = getelementptr i64, ptr %v303, i64 1
  store i64 %v301, ptr %st93
  %st94 = getelementptr i64, ptr %v303, i64 2
  store i64 %v302, ptr %st94
  %v305.p = getelementptr i64, ptr %v294, i64 0
  %v305 = load i64, ptr %v305.p
  %v306 = add i64 0, 0
  %v307.c = icmp eq i64 %v305, %v306
  %v307 = zext i1 %v307.c to i64
  %v308.p = getelementptr i64, ptr %v290, i64 0
  %v308 = load i64, ptr %v308.p
  %v309.p = getelementptr i64, ptr %v290, i64 1
  %v309 = load i64, ptr %v309.p
  %v310.p = getelementptr i64, ptr %v290, i64 2
  %v310 = load i64, ptr %v310.p
  %v311.p = getelementptr i64, ptr %v49, i64 0
  %v311 = load i64, ptr %v311.p
  %v312.p = getelementptr i64, ptr %v49, i64 1
  %v312 = load i64, ptr %v312.p
  %v313.p = getelementptr i64, ptr %v49, i64 2
  %v313 = load i64, ptr %v313.p
  %v314 = call i64 @"std/crypto.Equal"(i64 %v308, i64 %v309, i64 %v310, i64 %v311, i64 %v312, i64 %v313)
  call void @"rt.print_str"(ptr %v303)
  %v315 = add i64 0, 32
  call void @"rt.print_char"(i64 %v315)
  %c.b6 = icmp ne i64 %v307, 0
  br i1 %c.b6, label %b6.t96, label %b6.e97
b6.t96:
  br label %b7
b6.e97:
  br label %b8
b7:
  %v316 = add i64 0, 116
  call void @"rt.print_char"(i64 %v316)
  %v317 = add i64 0, 114
  call void @"rt.print_char"(i64 %v317)
  %v318 = add i64 0, 117
  call void @"rt.print_char"(i64 %v318)
  %v319 = add i64 0, 101
  call void @"rt.print_char"(i64 %v319)
  br label %b9
b8:
  %v320 = add i64 0, 102
  call void @"rt.print_char"(i64 %v320)
  %v321 = add i64 0, 97
  call void @"rt.print_char"(i64 %v321)
  %v322 = add i64 0, 108
  call void @"rt.print_char"(i64 %v322)
  %v323 = add i64 0, 115
  call void @"rt.print_char"(i64 %v323)
  %v324 = add i64 0, 101
  call void @"rt.print_char"(i64 %v324)
  br label %b9
b9:
  %v325 = add i64 0, 32
  call void @"rt.print_char"(i64 %v325)
  %c.b9 = icmp ne i64 %v314, 0
  br i1 %c.b9, label %b9.t98, label %b9.e99
b9.t98:
  br label %b10
b9.e99:
  br label %b11
b10:
  %v326 = add i64 0, 116
  call void @"rt.print_char"(i64 %v326)
  %v327 = add i64 0, 114
  call void @"rt.print_char"(i64 %v327)
  %v328 = add i64 0, 117
  call void @"rt.print_char"(i64 %v328)
  %v329 = add i64 0, 101
  call void @"rt.print_char"(i64 %v329)
  br label %b12
b11:
  %v330 = add i64 0, 102
  call void @"rt.print_char"(i64 %v330)
  %v331 = add i64 0, 97
  call void @"rt.print_char"(i64 %v331)
  %v332 = add i64 0, 108
  call void @"rt.print_char"(i64 %v332)
  %v333 = add i64 0, 115
  call void @"rt.print_char"(i64 %v333)
  %v334 = add i64 0, 101
  call void @"rt.print_char"(i64 %v334)
  br label %b12
b12:
  %v335 = add i64 0, 10
  call void @"rt.print_char"(i64 %v335)
  %v336 = add i64 0, 0
  %v337 = getelementptr i64, ptr %s25, i64 0
  %st99 = getelementptr i64, ptr %v337, i64 0
  store i64 %v336, ptr %st99
  %v670 = getelementptr i64, ptr @"rt.meta", i64 0
  %v338.p = getelementptr i64, ptr %v670, i64 0
  %v338 = load i64, ptr %v338.p
  %v339 = add i64 0, 0
  %v340.p = getelementptr i64, ptr %v227, i64 1
  %v340 = load i64, ptr %v340.p
  %v341 = getelementptr i64, ptr %s26, i64 0
  %v671 = getelementptr i64, ptr @"rt.meta", i64 0
  %v342.p = getelementptr i64, ptr %v671, i64 0
  %v342 = load i64, ptr %v342.p
  %v343 = getelementptr i64, ptr %s27, i64 0
  %st100 = getelementptr i64, ptr %v343, i64 0
  store i64 %v339, ptr %st100
  %v672 = getelementptr i64, ptr @"rt.meta", i64 0
  %v344.p = getelementptr i64, ptr %v672, i64 0
  %v344 = load i64, ptr %v344.p
  br label %b15
b13:
  %v673 = getelementptr i64, ptr @"rt.meta", i64 0
  %st101 = getelementptr i64, ptr %v673, i64 0
  store i64 %v338, ptr %st101
  %v461 = getelementptr i64, ptr @"str.6", i64 0
  %v462 = add i64 0, 6
  %v463 = add i64 0, 0
  %v464 = getelementptr i64, ptr %s28, i64 0
  %v465 = ptrtoint ptr %v461 to i64
  %st102 = getelementptr i64, ptr %v464, i64 0
  store i64 %v465, ptr %st102
  %st103 = getelementptr i64, ptr %v464, i64 1
  store i64 %v462, ptr %st103
  %st104 = getelementptr i64, ptr %v464, i64 2
  store i64 %v463, ptr %st104
  %v466.p = getelementptr i64, ptr %v227, i64 1
  %v466 = load i64, ptr %v466.p
  %v467.p = getelementptr i64, ptr %v337, i64 0
  %v467 = load i64, ptr %v467.p
  call void @"rt.print_str"(ptr %v464)
  %v468 = add i64 0, 32
  call void @"rt.print_char"(i64 %v468)
  call void @"rt.print_int"(i64 %v466)
  %v469 = add i64 0, 32
  call void @"rt.print_char"(i64 %v469)
  call void @"rt.print_int"(i64 %v467)
  %v470 = add i64 0, 10
  call void @"rt.print_char"(i64 %v470)
  %v471 = getelementptr i64, ptr %s35, i64 0
  %v472.p = getelementptr i64, ptr %v182, i64 0
  %v472 = load i64, ptr %v472.p
  %v473.p = getelementptr i64, ptr %v182, i64 1
  %v473 = load i64, ptr %v473.p
  %v474.p = getelementptr i64, ptr %v182, i64 2
  %v474 = load i64, ptr %v474.p
  %v475.p = getelementptr i64, ptr %v195, i64 0
  %v475 = load i64, ptr %v475.p
  %v476.p = getelementptr i64, ptr %v195, i64 1
  %v476 = load i64, ptr %v476.p
  %v477.p = getelementptr i64, ptr %v195, i64 2
  %v477 = load i64, ptr %v477.p
  %v478 = getelementptr i64, ptr %s36, i64 0
  %v479 = getelementptr i64, ptr @"str.17", i64 0
  %v480 = add i64 0, 24
  %v481 = add i64 0, 0
  %v482 = getelementptr i64, ptr %s28, i64 0
  %v483 = ptrtoint ptr %v479 to i64
  %st105 = getelementptr i64, ptr %v482, i64 0
  store i64 %v483, ptr %st105
  %st106 = getelementptr i64, ptr %v482, i64 1
  store i64 %v480, ptr %st106
  %st107 = getelementptr i64, ptr %v482, i64 2
  store i64 %v481, ptr %st107
  %v484.p = getelementptr i64, ptr %v482, i64 0
  %v484 = load i64, ptr %v484.p
  %v485.p = getelementptr i64, ptr %v482, i64 1
  %v485 = load i64, ptr %v485.p
  %v486.p = getelementptr i64, ptr %v482, i64 2
  %v486 = load i64, ptr %v486.p
  call void @"main.unhex"(ptr %v478, i64 %v484, i64 %v485, i64 %v486)
  %v487.p = getelementptr i64, ptr %v478, i64 0
  %v487 = load i64, ptr %v487.p
  %v488.p = getelementptr i64, ptr %v478, i64 1
  %v488 = load i64, ptr %v488.p
  %v489.p = getelementptr i64, ptr %v478, i64 2
  %v489 = load i64, ptr %v489.p
  %v490.p = getelementptr i64, ptr %v227, i64 0
  %v490 = load i64, ptr %v490.p
  %v491.p = getelementptr i64, ptr %v227, i64 1
  %v491 = load i64, ptr %v491.p
  %v492.p = getelementptr i64, ptr %v227, i64 2
  %v492 = load i64, ptr %v492.p
  call void @"std/crypto/chacha20poly1305.Open"(ptr %v471, i64 %v472, i64 %v473, i64 %v474, i64 %v475, i64 %v476, i64 %v477, i64 %v487, i64 %v488, i64 %v489, i64 %v490, i64 %v491, i64 %v492)
  %v493 = add i64 0, 3
  %v494 = getelementptr i64, ptr %v471, i64 %v493
  %v495 = getelementptr i64, ptr %s33, i64 0
  %v496.p = getelementptr i64, ptr %v494, i64 0
  %v496 = load i64, ptr %v496.p
  %st108 = getelementptr i64, ptr %v495, i64 0
  store i64 %v496, ptr %st108
  %v497.p = getelementptr i64, ptr %v494, i64 1
  %v497 = load i64, ptr %v497.p
  %st109 = getelementptr i64, ptr %v495, i64 1
  store i64 %v497, ptr %st109
  %v498.p = getelementptr i64, ptr %v494, i64 2
  %v498 = load i64, ptr %v498.p
  %st110 = getelementptr i64, ptr %v495, i64 2
  store i64 %v498, ptr %st110
  %v499.p = getelementptr i64, ptr %v494, i64 3
  %v499 = load i64, ptr %v499.p
  %st111 = getelementptr i64, ptr %v495, i64 3
  store i64 %v499, ptr %st111
  %v500.p = getelementptr i64, ptr %v494, i64 4
  %v500 = load i64, ptr %v500.p
  %st112 = getelementptr i64, ptr %v495, i64 4
  store i64 %v500, ptr %st112
  %v501 = getelementptr i64, ptr @"str.29", i64 0
  %v502 = add i64 0, 9
  %v503 = add i64 0, 0
  %v504 = getelementptr i64, ptr %s28, i64 0
  %v505 = ptrtoint ptr %v501 to i64
  %st113 = getelementptr i64, ptr %v504, i64 0
  store i64 %v505, ptr %st113
  %st114 = getelementptr i64, ptr %v504, i64 1
  store i64 %v502, ptr %st114
  %st115 = getelementptr i64, ptr %v504, i64 2
  store i64 %v503, ptr %st115
  %v506.p = getelementptr i64, ptr %v495, i64 0
  %v506 = load i64, ptr %v506.p
  %v507 = add i64 0, 0
  %v508.c = icmp ne i64 %v506, %v507
  %v508 = zext i1 %v508.c to i64
  call void @"rt.print_str"(ptr %v504)
  %v509 = add i64 0, 32
  call void @"rt.print_char"(i64 %v509)
  %c.b13 = icmp ne i64 %v508, 0
  br i1 %c.b13, label %b13.t117, label %b13.e118
b13.t117:
  br label %b40
b13.e118:
  br label %b41
b14:
  br label %b13
b15:
  %v674 = getelementptr i64, ptr @"rt.meta", i64 0
  %st118 = getelementptr i64, ptr %v674, i64 0
  store i64 %v344, ptr %st118
  %v345.p = getelementptr i64, ptr %v343, i64 0
  %v345 = load i64, ptr %v345.p
  %v346.c = icmp slt i64 %v345, %v340
  %v346 = zext i1 %v346.c to i64
  %c.b15 = icmp ne i64 %v346, 0
  br i1 %c.b15, label %b15.t120, label %b15.e121
b15.t120:
  br label %b16
b15.e121:
  br label %b17
b16:
  call void @"rt.region_enter"()
  %v675 = getelementptr i64, ptr @"rt.meta", i64 0
  %v347.p = getelementptr i64, ptr %v675, i64 0
  %v347 = load i64, ptr %v347.p
  %v348.p = getelementptr i64, ptr %v343, i64 0
  %v348 = load i64, ptr %v348.p
  %v676 = getelementptr i64, ptr @"rt.meta", i64 0
  %v349.p = getelementptr i64, ptr %v676, i64 0
  %v349 = load i64, ptr %v349.p
  %v677 = getelementptr i64, ptr @"rt.meta", i64 0
  %v350.p = getelementptr i64, ptr %v677, i64 0
  %v350 = load i64, ptr %v350.p
  %v351 = add i64 0, 0
  %v352 = call ptr @"rt.region_alloc8"(i64 %v350, i64 %v351)
  %v353 = add i64 0, 0
  %v354 = getelementptr i64, ptr %s21, i64 0
  %v355 = ptrtoint ptr %v352 to i64
  %st121 = getelementptr i64, ptr %v354, i64 0
  store i64 %v355, ptr %st121
  %st122 = getelementptr i64, ptr %v354, i64 1
  store i64 %v353, ptr %st122
  %st123 = getelementptr i64, ptr %v354, i64 2
  store i64 %v350, ptr %st123
  %v356 = getelementptr i64, ptr %s28, i64 0
  %v357.p = getelementptr i64, ptr %v354, i64 0
  %v357 = load i64, ptr %v357.p
  %st124 = getelementptr i64, ptr %v356, i64 0
  store i64 %v357, ptr %st124
  %v358.p = getelementptr i64, ptr %v354, i64 1
  %v358 = load i64, ptr %v358.p
  %st125 = getelementptr i64, ptr %v356, i64 1
  store i64 %v358, ptr %st125
  %v359.p = getelementptr i64, ptr %v354, i64 2
  %v359 = load i64, ptr %v359.p
  %st126 = getelementptr i64, ptr %v356, i64 2
  store i64 %v359, ptr %st126
  %v678 = getelementptr i64, ptr @"rt.meta", i64 0
  %v360.p = getelementptr i64, ptr %v678, i64 0
  %v360 = load i64, ptr %v360.p
  %v361 = add i64 0, 0
  %v362.p = getelementptr i64, ptr %v227, i64 1
  %v362 = load i64, ptr %v362.p
  %v363 = getelementptr i64, ptr %s29, i64 0
  %v679 = getelementptr i64, ptr @"rt.meta", i64 0
  %v364.p = getelementptr i64, ptr %v679, i64 0
  %v364 = load i64, ptr %v364.p
  %v365 = getelementptr i64, ptr %s30, i64 0
  %st127 = getelementptr i64, ptr %v365, i64 0
  store i64 %v361, ptr %st127
  %v680 = getelementptr i64, ptr @"rt.meta", i64 0
  %v366.p = getelementptr i64, ptr %v680, i64 0
  %v366 = load i64, ptr %v366.p
  br label %b21
b17:
  %v681 = getelementptr i64, ptr @"rt.meta", i64 0
  %st128 = getelementptr i64, ptr %v681, i64 0
  store i64 %v344, ptr %st128
  br label %b14
b18:
  %v682 = getelementptr i64, ptr @"rt.meta", i64 0
  %st129 = getelementptr i64, ptr %v682, i64 0
  store i64 %v349, ptr %st129
  %v458 = add i64 0, 1
  %v459.p = getelementptr i64, ptr %v343, i64 0
  %v459 = load i64, ptr %v459.p
  %v460 = add i64 %v459, %v458
  %st130 = getelementptr i64, ptr %v343, i64 0
  store i64 %v460, ptr %st130
  br label %b15
b19:
  %v683 = getelementptr i64, ptr @"rt.meta", i64 0
  %st131 = getelementptr i64, ptr %v683, i64 0
  store i64 %v360, ptr %st131
  %v422 = getelementptr i64, ptr %s32, i64 0
  %v423.p = getelementptr i64, ptr %v182, i64 0
  %v423 = load i64, ptr %v423.p
  %v424.p = getelementptr i64, ptr %v182, i64 1
  %v424 = load i64, ptr %v424.p
  %v425.p = getelementptr i64, ptr %v182, i64 2
  %v425 = load i64, ptr %v425.p
  %v426.p = getelementptr i64, ptr %v195, i64 0
  %v426 = load i64, ptr %v426.p
  %v427.p = getelementptr i64, ptr %v195, i64 1
  %v427 = load i64, ptr %v427.p
  %v428.p = getelementptr i64, ptr %v195, i64 2
  %v428 = load i64, ptr %v428.p
  %v429.p = getelementptr i64, ptr %v208, i64 0
  %v429 = load i64, ptr %v429.p
  %v430.p = getelementptr i64, ptr %v208, i64 1
  %v430 = load i64, ptr %v430.p
  %v431.p = getelementptr i64, ptr %v208, i64 2
  %v431 = load i64, ptr %v431.p
  %v432.p = getelementptr i64, ptr %v356, i64 0
  %v432 = load i64, ptr %v432.p
  %v433.p = getelementptr i64, ptr %v356, i64 1
  %v433 = load i64, ptr %v433.p
  %v434.p = getelementptr i64, ptr %v356, i64 2
  %v434 = load i64, ptr %v434.p
  call void @"std/crypto/chacha20poly1305.Open"(ptr %v422, i64 %v423, i64 %v424, i64 %v425, i64 %v426, i64 %v427, i64 %v428, i64 %v429, i64 %v430, i64 %v431, i64 %v432, i64 %v433, i64 %v434)
  %v435 = add i64 0, 3
  %v436 = getelementptr i64, ptr %v422, i64 %v435
  %v437 = getelementptr i64, ptr %s33, i64 0
  %v438.p = getelementptr i64, ptr %v436, i64 0
  %v438 = load i64, ptr %v438.p
  %st132 = getelementptr i64, ptr %v437, i64 0
  store i64 %v438, ptr %st132
  %v439.p = getelementptr i64, ptr %v436, i64 1
  %v439 = load i64, ptr %v439.p
  %st133 = getelementptr i64, ptr %v437, i64 1
  store i64 %v439, ptr %st133
  %v440.p = getelementptr i64, ptr %v436, i64 2
  %v440 = load i64, ptr %v440.p
  %st134 = getelementptr i64, ptr %v437, i64 2
  store i64 %v440, ptr %st134
  %v441.p = getelementptr i64, ptr %v436, i64 3
  %v441 = load i64, ptr %v441.p
  %st135 = getelementptr i64, ptr %v437, i64 3
  store i64 %v441, ptr %st135
  %v442.p = getelementptr i64, ptr %v436, i64 4
  %v442 = load i64, ptr %v442.p
  %st136 = getelementptr i64, ptr %v437, i64 4
  store i64 %v442, ptr %st136
  %v443.p = getelementptr i64, ptr %v437, i64 0
  %v443 = load i64, ptr %v443.p
  %v444 = add i64 0, 0
  %v445.c = icmp ne i64 %v443, %v444
  %v445 = zext i1 %v445.c to i64
  %c.b19 = icmp ne i64 %v445, 0
  br i1 %c.b19, label %b19.t138, label %b19.e139
b19.t138:
  br label %b37
b19.e139:
  br label %b38
b20:
  br label %b19
b21:
  %v684 = getelementptr i64, ptr @"rt.meta", i64 0
  %st139 = getelementptr i64, ptr %v684, i64 0
  store i64 %v366, ptr %st139
  %v367.p = getelementptr i64, ptr %v365, i64 0
  %v367 = load i64, ptr %v367.p
  %v368.c = icmp slt i64 %v367, %v362
  %v368 = zext i1 %v368.c to i64
  %c.b21 = icmp ne i64 %v368, 0
  br i1 %c.b21, label %b21.t141, label %b21.e142
b21.t141:
  br label %b22
b21.e142:
  br label %b23
b22:
  call void @"rt.region_enter"()
  %v685 = getelementptr i64, ptr @"rt.meta", i64 0
  %v369.p = getelementptr i64, ptr %v685, i64 0
  %v369 = load i64, ptr %v369.p
  %v370.p = getelementptr i64, ptr %v365, i64 0
  %v370 = load i64, ptr %v370.p
  %v686 = getelementptr i64, ptr @"rt.meta", i64 0
  %v371.p = getelementptr i64, ptr %v686, i64 0
  %v371 = load i64, ptr %v371.p
  %v372 = getelementptr i64, ptr %s21, i64 0
  %v373.p = getelementptr i64, ptr %v356, i64 0
  %v373 = load i64, ptr %v373.p
  %st142 = getelementptr i64, ptr %v372, i64 0
  store i64 %v373, ptr %st142
  %v374.p = getelementptr i64, ptr %v356, i64 1
  %v374 = load i64, ptr %v374.p
  %st143 = getelementptr i64, ptr %v372, i64 1
  store i64 %v374, ptr %st143
  %v375.p = getelementptr i64, ptr %v356, i64 2
  %v375 = load i64, ptr %v375.p
  %st144 = getelementptr i64, ptr %v372, i64 2
  store i64 %v375, ptr %st144
  %v376.c = icmp eq i64 %v370, %v348
  %v376 = zext i1 %v376.c to i64
  %c.b22 = icmp ne i64 %v376, 0
  br i1 %c.b22, label %b22.t146, label %b22.e147
b22.t146:
  br label %b25
b22.e147:
  br label %b26
b23:
  %v687 = getelementptr i64, ptr @"rt.meta", i64 0
  %st147 = getelementptr i64, ptr %v687, i64 0
  store i64 %v366, ptr %st147
  br label %b20
b24:
  %v688 = getelementptr i64, ptr @"rt.meta", i64 0
  %st148 = getelementptr i64, ptr %v688, i64 0
  store i64 %v371, ptr %st148
  %v419 = add i64 0, 1
  %v420.p = getelementptr i64, ptr %v365, i64 0
  %v420 = load i64, ptr %v420.p
  %v421 = add i64 %v420, %v419
  %st149 = getelementptr i64, ptr %v365, i64 0
  store i64 %v421, ptr %st149
  br label %b21
b25:
  %v377.p = getelementptr i64, ptr %v227, i64 1
  %v377 = load i64, ptr %v377.p
  %v378.c = icmp uge i64 %v370, %v377
  %v378 = zext i1 %v378.c to i64
  %c.b25 = icmp ne i64 %v378, 0
  br i1 %c.b25, label %b25.t151, label %b25.e152
b25.t151:
  br label %b27
b25.e152:
  br label %b28
b26:
  %v389.p = getelementptr i64, ptr %v227, i64 1
  %v389 = load i64, ptr %v389.p
  %v390.c = icmp uge i64 %v370, %v389
  %v390 = zext i1 %v390.c to i64
  %c.b26 = icmp ne i64 %v390, 0
  br i1 %c.b26, label %b26.t153, label %b26.e154
b26.t153:
  br label %b31
b26.e154:
  br label %b32
b27:
  %v379 = add i64 0, 1
  call void @"rt.panic"(i64 %v379)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b28:
  %v380.p = getelementptr i64, ptr %v227, i64 0
  %v380 = load i64, ptr %v380.p
  %v381 = inttoptr i64 %v380 to ptr
  %v382 = getelementptr i8, ptr %v381, i64 %v370
  %v383.p = getelementptr i8, ptr %v382, i64 0
  %v383.b = load i8, ptr %v383.p
  %v383 = zext i8 %v383.b to i64
  %v384 = add i64 0, 1
  %v385 = xor i64 %v383, %v384
  %v386 = add i64 0, 256
  %v387.c = icmp uge i64 %v385, %v386
  %v387 = zext i1 %v387.c to i64
  %c.b28 = icmp ne i64 %v387, 0
  br i1 %c.b28, label %b28.t155, label %b28.e156
b28.t155:
  br label %b29
b28.e156:
  br label %b30
b29:
  %v388 = add i64 0, 2
  call void @"rt.panic"(i64 %v388)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  br label %b33
b31:
  %v391 = add i64 0, 3
  call void @"rt.panic"(i64 %v391)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v392.p = getelementptr i64, ptr %v227, i64 0
  %v392 = load i64, ptr %v392.p
  %v393 = inttoptr i64 %v392 to ptr
  %v394 = getelementptr i8, ptr %v393, i64 %v370
  %v395.p = getelementptr i8, ptr %v394, i64 0
  %v395.b = load i8, ptr %v395.p
  %v395 = zext i8 %v395.b to i64
  br label %b33
b33:
  %v396 = phi i64 [ %v385, %b30 ], [ %v395, %b32 ]
  %v397.p = getelementptr i64, ptr %v372, i64 2
  %v397 = load i64, ptr %v397.p
  %v398.p = getelementptr i64, ptr %v372, i64 0
  %v398 = load i64, ptr %v398.p
  %v399.p = getelementptr i64, ptr %v372, i64 1
  %v399 = load i64, ptr %v399.p
  %v402 = add i64 %v398, %v399
  %v403 = call i64 @"rt.tip8"(i64 %v397, i64 %v402)
  %v404 = add i64 0, 0
  %v405.c = icmp ne i64 %v403, %v404
  %v405 = zext i1 %v405.c to i64
  %c.b33 = icmp ne i64 %v405, 0
  br i1 %c.b33, label %b33.t157, label %b33.e158
b33.t157:
  br label %b36
b33.e158:
  br label %b35
b34:
  %v400 = phi ptr [ %v409, %b35 ], [ %v406, %b36 ]
  %v401 = phi ptr [ %v410, %b35 ], [ %v407, %b36 ]
  %st158 = getelementptr i8, ptr %v401, i64 0
  %st158.b = trunc i64 %v396 to i8
  store i8 %st158.b, ptr %st158
  %v411.p = getelementptr i64, ptr %v372, i64 1
  %v411 = load i64, ptr %v411.p
  %v412 = add i64 0, 1
  %v413 = add i64 %v411, %v412
  %v414 = getelementptr i64, ptr %s31, i64 0
  %v415 = ptrtoint ptr %v400 to i64
  %st159 = getelementptr i64, ptr %v414, i64 0
  store i64 %v415, ptr %st159
  %st160 = getelementptr i64, ptr %v414, i64 1
  store i64 %v413, ptr %st160
  %st161 = getelementptr i64, ptr %v414, i64 2
  store i64 %v397, ptr %st161
  %v416.p = getelementptr i64, ptr %v414, i64 0
  %v416 = load i64, ptr %v416.p
  %st162 = getelementptr i64, ptr %v356, i64 0
  store i64 %v416, ptr %st162
  %v417.p = getelementptr i64, ptr %v414, i64 1
  %v417 = load i64, ptr %v417.p
  %st163 = getelementptr i64, ptr %v356, i64 1
  store i64 %v417, ptr %st163
  %v418.p = getelementptr i64, ptr %v414, i64 2
  %v418 = load i64, ptr %v418.p
  %st164 = getelementptr i64, ptr %v356, i64 2
  store i64 %v418, ptr %st164
  br label %b24
b35:
  %v408 = add i64 0, 1
  %v409 = call ptr @"rt.slice_grow8"(i64 %v398, i64 %v399, i64 %v397, i64 %v408)
  %v410 = getelementptr i8, ptr %v409, i64 %v399
  br label %b34
b36:
  %v406 = inttoptr i64 %v398 to ptr
  %v407 = getelementptr i8, ptr %v406, i64 %v399
  br label %b34
b37:
  %v446 = add i64 0, 1
  %v447 = getelementptr i64, ptr %v437, i64 %v446
  %v448 = getelementptr i64, ptr %s34, i64 0
  %v449.p = getelementptr i64, ptr %v447, i64 0
  %v449 = load i64, ptr %v449.p
  %st165 = getelementptr i64, ptr %v448, i64 0
  store i64 %v449, ptr %st165
  %v450.p = getelementptr i64, ptr %v447, i64 1
  %v450 = load i64, ptr %v450.p
  %st166 = getelementptr i64, ptr %v448, i64 1
  store i64 %v450, ptr %st166
  %v451.p = getelementptr i64, ptr %v447, i64 2
  %v451 = load i64, ptr %v451.p
  %st167 = getelementptr i64, ptr %v448, i64 2
  store i64 %v451, ptr %st167
  %v452.p = getelementptr i64, ptr %v447, i64 3
  %v452 = load i64, ptr %v452.p
  %st168 = getelementptr i64, ptr %v448, i64 3
  store i64 %v452, ptr %st168
  %v453 = add i64 0, 1
  %v454 = add i64 %v0, %v453
  %v455.p = getelementptr i64, ptr %v337, i64 0
  %v455 = load i64, ptr %v455.p
  %v456 = add i64 0, 1
  %v457 = add i64 %v455, %v456
  %st169 = getelementptr i64, ptr %v337, i64 0
  store i64 %v457, ptr %st169
  br label %b39
b38:
  br label %b39
b39:
  br label %b18
b40:
  %v510 = add i64 0, 116
  call void @"rt.print_char"(i64 %v510)
  %v511 = add i64 0, 114
  call void @"rt.print_char"(i64 %v511)
  %v512 = add i64 0, 117
  call void @"rt.print_char"(i64 %v512)
  %v513 = add i64 0, 101
  call void @"rt.print_char"(i64 %v513)
  br label %b42
b41:
  %v514 = add i64 0, 102
  call void @"rt.print_char"(i64 %v514)
  %v515 = add i64 0, 97
  call void @"rt.print_char"(i64 %v515)
  %v516 = add i64 0, 108
  call void @"rt.print_char"(i64 %v516)
  %v517 = add i64 0, 115
  call void @"rt.print_char"(i64 %v517)
  %v518 = add i64 0, 101
  call void @"rt.print_char"(i64 %v518)
  br label %b42
b42:
  %v519 = add i64 0, 10
  call void @"rt.print_char"(i64 %v519)
  %v520 = getelementptr i64, ptr %s37, i64 0
  %v521.p = getelementptr i64, ptr %v182, i64 0
  %v521 = load i64, ptr %v521.p
  %v522.p = getelementptr i64, ptr %v182, i64 1
  %v522 = load i64, ptr %v522.p
  %v523.p = getelementptr i64, ptr %v182, i64 2
  %v523 = load i64, ptr %v523.p
  %v524 = getelementptr i64, ptr %s38, i64 0
  %v525 = getelementptr i64, ptr @"str.11", i64 0
  %v526 = add i64 0, 22
  %v527 = add i64 0, 0
  %v528 = getelementptr i64, ptr %s28, i64 0
  %v529 = ptrtoint ptr %v525 to i64
  %st170 = getelementptr i64, ptr %v528, i64 0
  store i64 %v529, ptr %st170
  %st171 = getelementptr i64, ptr %v528, i64 1
  store i64 %v526, ptr %st171
  %st172 = getelementptr i64, ptr %v528, i64 2
  store i64 %v527, ptr %st172
  %v530.p = getelementptr i64, ptr %v528, i64 0
  %v530 = load i64, ptr %v530.p
  %v531.p = getelementptr i64, ptr %v528, i64 1
  %v531 = load i64, ptr %v531.p
  %v532.p = getelementptr i64, ptr %v528, i64 2
  %v532 = load i64, ptr %v532.p
  call void @"main.unhex"(ptr %v524, i64 %v530, i64 %v531, i64 %v532)
  %v533.p = getelementptr i64, ptr %v524, i64 0
  %v533 = load i64, ptr %v533.p
  %v534.p = getelementptr i64, ptr %v524, i64 1
  %v534 = load i64, ptr %v534.p
  %v535.p = getelementptr i64, ptr %v524, i64 2
  %v535 = load i64, ptr %v535.p
  %v536.p = getelementptr i64, ptr %v208, i64 0
  %v536 = load i64, ptr %v536.p
  %v537.p = getelementptr i64, ptr %v208, i64 1
  %v537 = load i64, ptr %v537.p
  %v538.p = getelementptr i64, ptr %v208, i64 2
  %v538 = load i64, ptr %v538.p
  %v539.p = getelementptr i64, ptr %v49, i64 0
  %v539 = load i64, ptr %v539.p
  %v540.p = getelementptr i64, ptr %v49, i64 1
  %v540 = load i64, ptr %v540.p
  %v541.p = getelementptr i64, ptr %v49, i64 2
  %v541 = load i64, ptr %v541.p
  call void @"std/crypto/chacha20poly1305.Seal"(ptr %v520, i64 %v521, i64 %v522, i64 %v523, i64 %v533, i64 %v534, i64 %v535, i64 %v536, i64 %v537, i64 %v538, i64 %v539, i64 %v540, i64 %v541)
  %v542 = add i64 0, 3
  %v543 = getelementptr i64, ptr %v520, i64 %v542
  %v544 = getelementptr i64, ptr %s39, i64 0
  %v545.p = getelementptr i64, ptr %v543, i64 0
  %v545 = load i64, ptr %v545.p
  %st173 = getelementptr i64, ptr %v544, i64 0
  store i64 %v545, ptr %st173
  %v546.p = getelementptr i64, ptr %v543, i64 1
  %v546 = load i64, ptr %v546.p
  %st174 = getelementptr i64, ptr %v544, i64 1
  store i64 %v546, ptr %st174
  %v547.p = getelementptr i64, ptr %v543, i64 2
  %v547 = load i64, ptr %v547.p
  %st175 = getelementptr i64, ptr %v544, i64 2
  store i64 %v547, ptr %st175
  %v548.p = getelementptr i64, ptr %v543, i64 3
  %v548 = load i64, ptr %v548.p
  %st176 = getelementptr i64, ptr %v544, i64 3
  store i64 %v548, ptr %st176
  %v549.p = getelementptr i64, ptr %v543, i64 4
  %v549 = load i64, ptr %v549.p
  %st177 = getelementptr i64, ptr %v544, i64 4
  store i64 %v549, ptr %st177
  %v550 = getelementptr i64, ptr @"str.28", i64 0
  %v551 = add i64 0, 9
  %v552 = add i64 0, 0
  %v553 = getelementptr i64, ptr %s28, i64 0
  %v554 = ptrtoint ptr %v550 to i64
  %st178 = getelementptr i64, ptr %v553, i64 0
  store i64 %v554, ptr %st178
  %st179 = getelementptr i64, ptr %v553, i64 1
  store i64 %v551, ptr %st179
  %st180 = getelementptr i64, ptr %v553, i64 2
  store i64 %v552, ptr %st180
  %v555.p = getelementptr i64, ptr %v544, i64 0
  %v555 = load i64, ptr %v555.p
  %v556 = add i64 0, 0
  %v557.c = icmp ne i64 %v555, %v556
  %v557 = zext i1 %v557.c to i64
  call void @"rt.print_str"(ptr %v553)
  %v558 = add i64 0, 32
  call void @"rt.print_char"(i64 %v558)
  %c.b42 = icmp ne i64 %v557, 0
  br i1 %c.b42, label %b42.t182, label %b42.e183
b42.t182:
  br label %b43
b42.e183:
  br label %b44
b43:
  %v559 = add i64 0, 116
  call void @"rt.print_char"(i64 %v559)
  %v560 = add i64 0, 114
  call void @"rt.print_char"(i64 %v560)
  %v561 = add i64 0, 117
  call void @"rt.print_char"(i64 %v561)
  %v562 = add i64 0, 101
  call void @"rt.print_char"(i64 %v562)
  br label %b45
b44:
  %v563 = add i64 0, 102
  call void @"rt.print_char"(i64 %v563)
  %v564 = add i64 0, 97
  call void @"rt.print_char"(i64 %v564)
  %v565 = add i64 0, 108
  call void @"rt.print_char"(i64 %v565)
  %v566 = add i64 0, 115
  call void @"rt.print_char"(i64 %v566)
  %v567 = add i64 0, 101
  call void @"rt.print_char"(i64 %v567)
  br label %b45
b45:
  %v568 = add i64 0, 10
  call void @"rt.print_char"(i64 %v568)
  %v569 = add i64 0, 0
  %v570 = getelementptr i64, ptr %s27, i64 0
  %st183 = getelementptr i64, ptr %v570, i64 0
  store i64 %v569, ptr %st183
  %v689 = getelementptr i64, ptr @"rt.meta", i64 0
  %v571.p = getelementptr i64, ptr %v689, i64 0
  %v571 = load i64, ptr %v571.p
  %v572 = add i64 0, 0
  %v573 = add i64 0, 131
  %v574 = getelementptr i64, ptr %s26, i64 0
  %v690 = getelementptr i64, ptr @"rt.meta", i64 0
  %v575.p = getelementptr i64, ptr %v690, i64 0
  %v575 = load i64, ptr %v575.p
  %v576 = getelementptr i64, ptr %s30, i64 0
  %st184 = getelementptr i64, ptr %v576, i64 0
  store i64 %v572, ptr %st184
  %v691 = getelementptr i64, ptr @"rt.meta", i64 0
  %v577.p = getelementptr i64, ptr %v691, i64 0
  %v577 = load i64, ptr %v577.p
  br label %b48
b46:
  %v692 = getelementptr i64, ptr @"rt.meta", i64 0
  %st185 = getelementptr i64, ptr %v692, i64 0
  store i64 %v571, ptr %st185
  %v649 = getelementptr i64, ptr @"str.30", i64 0
  %v650 = add i64 0, 9
  %v651 = add i64 0, 0
  %v652 = getelementptr i64, ptr %s21, i64 0
  %v653 = ptrtoint ptr %v649 to i64
  %st186 = getelementptr i64, ptr %v652, i64 0
  store i64 %v653, ptr %st186
  %st187 = getelementptr i64, ptr %v652, i64 1
  store i64 %v650, ptr %st187
  %st188 = getelementptr i64, ptr %v652, i64 2
  store i64 %v651, ptr %st188
  %v654.p = getelementptr i64, ptr %v570, i64 0
  %v654 = load i64, ptr %v654.p
  call void @"rt.print_str"(ptr %v652)
  %v655 = add i64 0, 32
  call void @"rt.print_char"(i64 %v655)
  call void @"rt.print_int"(i64 %v654)
  %v656 = add i64 0, 10
  call void @"rt.print_char"(i64 %v656)
  %v657.p = getelementptr i64, ptr %v182, i64 0
  %v657 = load i64, ptr %v657.p
  %v658.p = getelementptr i64, ptr %v182, i64 1
  %v658 = load i64, ptr %v658.p
  %v659.p = getelementptr i64, ptr %v182, i64 2
  %v659 = load i64, ptr %v659.p
  %v660.p = getelementptr i64, ptr %v195, i64 0
  %v660 = load i64, ptr %v660.p
  %v661.p = getelementptr i64, ptr %v195, i64 1
  %v661 = load i64, ptr %v661.p
  %v662.p = getelementptr i64, ptr %v195, i64 2
  %v662 = load i64, ptr %v662.p
  %v663.p = getelementptr i64, ptr %v208, i64 0
  %v663 = load i64, ptr %v663.p
  %v664.p = getelementptr i64, ptr %v208, i64 1
  %v664 = load i64, ptr %v664.p
  %v665.p = getelementptr i64, ptr %v208, i64 2
  %v665 = load i64, ptr %v665.p
  %v666.p = getelementptr i64, ptr %v49, i64 0
  %v666 = load i64, ptr %v666.p
  %v667.p = getelementptr i64, ptr %v49, i64 1
  %v667 = load i64, ptr %v667.p
  %v668.p = getelementptr i64, ptr %v49, i64 2
  %v668 = load i64, ptr %v668.p
  call void @"main.record"(i64 %v657, i64 %v658, i64 %v659, i64 %v660, i64 %v661, i64 %v662, i64 %v663, i64 %v664, i64 %v665, i64 %v666, i64 %v667, i64 %v668)
  %v693 = getelementptr i64, ptr @"rt.meta", i64 0
  %st189 = getelementptr i64, ptr %v693, i64 0
  store i64 %v0, ptr %st189
  ret void
b47:
  br label %b46
b48:
  %v694 = getelementptr i64, ptr @"rt.meta", i64 0
  %st190 = getelementptr i64, ptr %v694, i64 0
  store i64 %v577, ptr %st190
  %v578.p = getelementptr i64, ptr %v576, i64 0
  %v578 = load i64, ptr %v578.p
  %v579.c = icmp slt i64 %v578, %v573
  %v579 = zext i1 %v579.c to i64
  %c.b48 = icmp ne i64 %v579, 0
  br i1 %c.b48, label %b48.t192, label %b48.e193
b48.t192:
  br label %b49
b48.e193:
  br label %b50
b49:
  call void @"rt.region_enter"()
  %v695 = getelementptr i64, ptr @"rt.meta", i64 0
  %v580.p = getelementptr i64, ptr %v695, i64 0
  %v580 = load i64, ptr %v580.p
  %v581.p = getelementptr i64, ptr %v576, i64 0
  %v581 = load i64, ptr %v581.p
  %v696 = getelementptr i64, ptr @"rt.meta", i64 0
  %v582.p = getelementptr i64, ptr %v696, i64 0
  %v582 = load i64, ptr %v582.p
  %v583 = getelementptr i64, ptr %s40, i64 0
  %v584 = add i64 0, 0
  %v585 = add i64 0, 1
  %v586 = sub i64 %v581, %v585
  call void @"main.seq"(ptr %v583, i64 %v584, i64 %v586)
  %v587 = getelementptr i64, ptr %s28, i64 0
  %v588.p = getelementptr i64, ptr %v583, i64 0
  %v588 = load i64, ptr %v588.p
  %st193 = getelementptr i64, ptr %v587, i64 0
  store i64 %v588, ptr %st193
  %v589.p = getelementptr i64, ptr %v583, i64 1
  %v589 = load i64, ptr %v589.p
  %st194 = getelementptr i64, ptr %v587, i64 1
  store i64 %v589, ptr %st194
  %v590.p = getelementptr i64, ptr %v583, i64 2
  %v590 = load i64, ptr %v590.p
  %st195 = getelementptr i64, ptr %v587, i64 2
  store i64 %v590, ptr %st195
  %v591 = getelementptr i64, ptr %s41, i64 0
  %v592.p = getelementptr i64, ptr %v182, i64 0
  %v592 = load i64, ptr %v592.p
  %v593.p = getelementptr i64, ptr %v182, i64 1
  %v593 = load i64, ptr %v593.p
  %v594.p = getelementptr i64, ptr %v182, i64 2
  %v594 = load i64, ptr %v594.p
  %v595.p = getelementptr i64, ptr %v195, i64 0
  %v595 = load i64, ptr %v595.p
  %v596.p = getelementptr i64, ptr %v195, i64 1
  %v596 = load i64, ptr %v596.p
  %v597.p = getelementptr i64, ptr %v195, i64 2
  %v597 = load i64, ptr %v597.p
  %v598.p = getelementptr i64, ptr %v208, i64 0
  %v598 = load i64, ptr %v598.p
  %v599.p = getelementptr i64, ptr %v208, i64 1
  %v599 = load i64, ptr %v599.p
  %v600.p = getelementptr i64, ptr %v208, i64 2
  %v600 = load i64, ptr %v600.p
  %v601.p = getelementptr i64, ptr %v587, i64 0
  %v601 = load i64, ptr %v601.p
  %v602.p = getelementptr i64, ptr %v587, i64 1
  %v602 = load i64, ptr %v602.p
  %v603.p = getelementptr i64, ptr %v587, i64 2
  %v603 = load i64, ptr %v603.p
  call void @"std/crypto/chacha20poly1305.Seal"(ptr %v591, i64 %v592, i64 %v593, i64 %v594, i64 %v595, i64 %v596, i64 %v597, i64 %v598, i64 %v599, i64 %v600, i64 %v601, i64 %v602, i64 %v603)
  %v604 = add i64 0, 3
  %v605 = getelementptr i64, ptr %v591, i64 %v604
  %v606 = getelementptr i64, ptr %s31, i64 0
  %v607.p = getelementptr i64, ptr %v591, i64 0
  %v607 = load i64, ptr %v607.p
  %st196 = getelementptr i64, ptr %v606, i64 0
  store i64 %v607, ptr %st196
  %v608.p = getelementptr i64, ptr %v591, i64 1
  %v608 = load i64, ptr %v608.p
  %st197 = getelementptr i64, ptr %v606, i64 1
  store i64 %v608, ptr %st197
  %v609.p = getelementptr i64, ptr %v591, i64 2
  %v609 = load i64, ptr %v609.p
  %st198 = getelementptr i64, ptr %v606, i64 2
  store i64 %v609, ptr %st198
  %v610 = getelementptr i64, ptr %s42, i64 0
  %v611.p = getelementptr i64, ptr %v182, i64 0
  %v611 = load i64, ptr %v611.p
  %v612.p = getelementptr i64, ptr %v182, i64 1
  %v612 = load i64, ptr %v612.p
  %v613.p = getelementptr i64, ptr %v182, i64 2
  %v613 = load i64, ptr %v613.p
  %v614.p = getelementptr i64, ptr %v195, i64 0
  %v614 = load i64, ptr %v614.p
  %v615.p = getelementptr i64, ptr %v195, i64 1
  %v615 = load i64, ptr %v615.p
  %v616.p = getelementptr i64, ptr %v195, i64 2
  %v616 = load i64, ptr %v616.p
  %v617.p = getelementptr i64, ptr %v208, i64 0
  %v617 = load i64, ptr %v617.p
  %v618.p = getelementptr i64, ptr %v208, i64 1
  %v618 = load i64, ptr %v618.p
  %v619.p = getelementptr i64, ptr %v208, i64 2
  %v619 = load i64, ptr %v619.p
  %v620.p = getelementptr i64, ptr %v606, i64 0
  %v620 = load i64, ptr %v620.p
  %v621.p = getelementptr i64, ptr %v606, i64 1
  %v621 = load i64, ptr %v621.p
  %v622.p = getelementptr i64, ptr %v606, i64 2
  %v622 = load i64, ptr %v622.p
  call void @"std/crypto/chacha20poly1305.Open"(ptr %v610, i64 %v611, i64 %v612, i64 %v613, i64 %v614, i64 %v615, i64 %v616, i64 %v617, i64 %v618, i64 %v619, i64 %v620, i64 %v621, i64 %v622)
  %v623 = add i64 0, 3
  %v624 = getelementptr i64, ptr %v610, i64 %v623
  %v625 = getelementptr i64, ptr %s21, i64 0
  %v626.p = getelementptr i64, ptr %v610, i64 0
  %v626 = load i64, ptr %v626.p
  %st199 = getelementptr i64, ptr %v625, i64 0
  store i64 %v626, ptr %st199
  %v627.p = getelementptr i64, ptr %v610, i64 1
  %v627 = load i64, ptr %v627.p
  %st200 = getelementptr i64, ptr %v625, i64 1
  store i64 %v627, ptr %st200
  %v628.p = getelementptr i64, ptr %v610, i64 2
  %v628 = load i64, ptr %v628.p
  %st201 = getelementptr i64, ptr %v625, i64 2
  store i64 %v628, ptr %st201
  %v629.p = getelementptr i64, ptr %v606, i64 1
  %v629 = load i64, ptr %v629.p
  %v630 = add i64 0, 16
  %v631 = add i64 %v581, %v630
  %v632.c = icmp eq i64 %v629, %v631
  %v632 = zext i1 %v632.c to i64
  %c.b49 = icmp ne i64 %v632, 0
  br i1 %c.b49, label %b49.t203, label %b49.e204
b49.t203:
  br label %b52
b49.e204:
  br label %b53
b50:
  %v697 = getelementptr i64, ptr @"rt.meta", i64 0
  %st204 = getelementptr i64, ptr %v697, i64 0
  store i64 %v577, ptr %st204
  br label %b47
b51:
  %v698 = getelementptr i64, ptr @"rt.meta", i64 0
  %st205 = getelementptr i64, ptr %v698, i64 0
  store i64 %v582, ptr %st205
  %v646 = add i64 0, 1
  %v647.p = getelementptr i64, ptr %v576, i64 0
  %v647 = load i64, ptr %v647.p
  %v648 = add i64 %v647, %v646
  %st206 = getelementptr i64, ptr %v576, i64 0
  store i64 %v648, ptr %st206
  br label %b48
b52:
  %v634.p = getelementptr i64, ptr %v625, i64 0
  %v634 = load i64, ptr %v634.p
  %v635.p = getelementptr i64, ptr %v625, i64 1
  %v635 = load i64, ptr %v635.p
  %v636.p = getelementptr i64, ptr %v625, i64 2
  %v636 = load i64, ptr %v636.p
  %v637.p = getelementptr i64, ptr %v587, i64 0
  %v637 = load i64, ptr %v637.p
  %v638.p = getelementptr i64, ptr %v587, i64 1
  %v638 = load i64, ptr %v638.p
  %v639.p = getelementptr i64, ptr %v587, i64 2
  %v639 = load i64, ptr %v639.p
  %v640 = call i64 @"std/crypto.Equal"(i64 %v634, i64 %v635, i64 %v636, i64 %v637, i64 %v638, i64 %v639)
  br label %b53
b53:
  %v633 = phi i64 [ %v632, %b49.e204 ], [ %v640, %b52 ]
  %c.b53 = icmp ne i64 %v633, 0
  br i1 %c.b53, label %b53.t208, label %b53.e209
b53.t208:
  br label %b54
b53.e209:
  br label %b55
b54:
  %v641 = add i64 0, 1
  %v642 = add i64 %v0, %v641
  %v643.p = getelementptr i64, ptr %v570, i64 0
  %v643 = load i64, ptr %v643.p
  %v644 = add i64 0, 1
  %v645 = add i64 %v643, %v644
  %st209 = getelementptr i64, ptr %v570, i64 0
  store i64 %v645, ptr %st209
  br label %b56
b55:
  br label %b56
b56:
  br label %b51
}

define internal void @"main.wrap"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %s7 = alloca [3 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s7.z1 = getelementptr i64, ptr %s7, i64 1
  store i64 0, ptr %s7.z1
  %s7.z2 = getelementptr i64, ptr %s7, i64 2
  store i64 0, ptr %s7.z2
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v232 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v232, i64 0
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
  %v17 = add i64 0, 0
  %v18 = call ptr @"rt.region_alloc8"(i64 %v16, i64 %v17)
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr %s1, i64 0
  %v21 = ptrtoint ptr %v18 to i64
  %st4 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st4
  %st5 = getelementptr i64, ptr %v20, i64 1
  store i64 %v19, ptr %st5
  %st6 = getelementptr i64, ptr %v20, i64 2
  store i64 %v16, ptr %st6
  %v22 = getelementptr i64, ptr %s2, i64 0
  %v23.p = getelementptr i64, ptr %v20, i64 0
  %v23 = load i64, ptr %v23.p
  %st7 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st7
  %v24.p = getelementptr i64, ptr %v20, i64 1
  %v24 = load i64, ptr %v24.p
  %st8 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st8
  %v25.p = getelementptr i64, ptr %v20, i64 2
  %v25 = load i64, ptr %v25.p
  %st9 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st9
  %v233 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v233, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28 = getelementptr i64, ptr %s3, i64 0
  %v234 = getelementptr i64, ptr @"rt.meta", i64 0
  %v29.p = getelementptr i64, ptr %v234, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = getelementptr i64, ptr %s4, i64 0
  %st10 = getelementptr i64, ptr %v30, i64 0
  store i64 %v27, ptr %st10
  %v235 = getelementptr i64, ptr @"rt.meta", i64 0
  %v31.p = getelementptr i64, ptr %v235, i64 0
  %v31 = load i64, ptr %v31.p
  br label %b3
b1:
  %v236 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v236, i64 0
  store i64 %v26, ptr %st11
  %v69 = add i64 0, 0
  %v70 = add i64 0, 0
  %v71.p = getelementptr i64, ptr %v5, i64 1
  %v71 = load i64, ptr %v71.p
  %v72 = sub i64 %v71, %v70
  %v73.c = icmp sle i64 %v72, %v69
  %v73 = zext i1 %v73.c to i64
  %c.b1 = icmp ne i64 %v73, 0
  br i1 %c.b1, label %b1.t13, label %b1.e14
b1.t13:
  br label %b10
b1.e14:
  br label %b11
b2:
  br label %b1
b3:
  %v237 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v237, i64 0
  store i64 %v31, ptr %st14
  %v32.p = getelementptr i64, ptr %v30, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.c = icmp slt i64 %v32, %v4
  %v33 = zext i1 %v33.c to i64
  %c.b3 = icmp ne i64 %v33, 0
  br i1 %c.b3, label %b3.t16, label %b3.e17
b3.t16:
  br label %b4
b3.e17:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v238 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v238, i64 0
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v30, i64 0
  %v35 = load i64, ptr %v35.p
  %v239 = getelementptr i64, ptr @"rt.meta", i64 0
  %v36.p = getelementptr i64, ptr %v239, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 0, 1
  %v38 = add i64 %v6, %v37
  %v39 = getelementptr i64, ptr %s1, i64 0
  %v40.p = getelementptr i64, ptr %v22, i64 0
  %v40 = load i64, ptr %v40.p
  %st17 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st17
  %v41.p = getelementptr i64, ptr %v22, i64 1
  %v41 = load i64, ptr %v41.p
  %st18 = getelementptr i64, ptr %v39, i64 1
  store i64 %v41, ptr %st18
  %v42.p = getelementptr i64, ptr %v22, i64 2
  %v42 = load i64, ptr %v42.p
  %st19 = getelementptr i64, ptr %v39, i64 2
  store i64 %v42, ptr %st19
  %v43 = add i64 0, 165
  %v44.p = getelementptr i64, ptr %v39, i64 2
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v39, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v39, i64 1
  %v46 = load i64, ptr %v46.p
  %v49 = add i64 %v45, %v46
  %v50 = call i64 @"rt.tip8"(i64 %v44, i64 %v49)
  %v51 = add i64 0, 0
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b4 = icmp ne i64 %v52, 0
  br i1 %c.b4, label %b4.t21, label %b4.e22
b4.t21:
  br label %b9
b4.e22:
  br label %b8
b5:
  %v240 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v240, i64 0
  store i64 %v31, ptr %st22
  br label %b2
b6:
  %v241 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v241, i64 0
  store i64 %v36, ptr %st23
  %v66 = add i64 0, 1
  %v67.p = getelementptr i64, ptr %v30, i64 0
  %v67 = load i64, ptr %v67.p
  %v68 = add i64 %v67, %v66
  %st24 = getelementptr i64, ptr %v30, i64 0
  store i64 %v68, ptr %st24
  br label %b3
b7:
  %v47 = phi ptr [ %v56, %b8 ], [ %v53, %b9 ]
  %v48 = phi ptr [ %v57, %b8 ], [ %v54, %b9 ]
  %st25 = getelementptr i8, ptr %v48, i64 0
  %st25.b = trunc i64 %v43 to i8
  store i8 %st25.b, ptr %st25
  %v58.p = getelementptr i64, ptr %v39, i64 1
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 0, 1
  %v60 = add i64 %v58, %v59
  %v61 = getelementptr i64, ptr %s5, i64 0
  %v62 = ptrtoint ptr %v47 to i64
  %st26 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st26
  %st27 = getelementptr i64, ptr %v61, i64 1
  store i64 %v60, ptr %st27
  %st28 = getelementptr i64, ptr %v61, i64 2
  store i64 %v44, ptr %st28
  %v63.p = getelementptr i64, ptr %v61, i64 0
  %v63 = load i64, ptr %v63.p
  %st29 = getelementptr i64, ptr %v22, i64 0
  store i64 %v63, ptr %st29
  %v64.p = getelementptr i64, ptr %v61, i64 1
  %v64 = load i64, ptr %v64.p
  %st30 = getelementptr i64, ptr %v22, i64 1
  store i64 %v64, ptr %st30
  %v65.p = getelementptr i64, ptr %v61, i64 2
  %v65 = load i64, ptr %v65.p
  %st31 = getelementptr i64, ptr %v22, i64 2
  store i64 %v65, ptr %st31
  br label %b6
b8:
  %v55 = add i64 0, 1
  %v56 = call ptr @"rt.slice_grow8"(i64 %v45, i64 %v46, i64 %v44, i64 %v55)
  %v57 = getelementptr i8, ptr %v56, i64 %v46
  br label %b7
b9:
  %v53 = inttoptr i64 %v45 to ptr
  %v54 = getelementptr i8, ptr %v53, i64 %v46
  br label %b7
b10:
  %v242 = getelementptr i64, ptr @"rt.meta", i64 0
  %v185.p = getelementptr i64, ptr %v242, i64 0
  %v185 = load i64, ptr %v185.p
  %v186 = add i64 0, 0
  %v187 = add i64 0, 3
  %v188 = getelementptr i64, ptr %s3, i64 0
  %v243 = getelementptr i64, ptr @"rt.meta", i64 0
  %v189.p = getelementptr i64, ptr %v243, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = getelementptr i64, ptr %s4, i64 0
  %st32 = getelementptr i64, ptr %v190, i64 0
  store i64 %v186, ptr %st32
  %v244 = getelementptr i64, ptr @"rt.meta", i64 0
  %v191.p = getelementptr i64, ptr %v244, i64 0
  %v191 = load i64, ptr %v191.p
  br label %b36
b11:
  %v74.c = icmp sge i64 %v70, %v69
  %v74 = zext i1 %v74.c to i64
  %v75.p = getelementptr i64, ptr %v5, i64 1
  %v75 = load i64, ptr %v75.p
  %v76.c = icmp sle i64 %v71, %v75
  %v76 = zext i1 %v76.c to i64
  %v77 = and i64 %v74, %v76
  %v78.c = icmp ne i64 %v77, %v69
  %v78 = zext i1 %v78.c to i64
  %c.b11 = icmp ne i64 %v78, 0
  br i1 %c.b11, label %b11.t34, label %b11.e35
b11.t34:
  br label %b13
b11.e35:
  br label %b12
b12:
  %v245 = getelementptr i64, ptr @"rt.meta", i64 0
  %v135.p = getelementptr i64, ptr %v245, i64 0
  %v135 = load i64, ptr %v135.p
  %v136 = add i64 0, 0
  %v137.p = getelementptr i64, ptr %v5, i64 1
  %v137 = load i64, ptr %v137.p
  %v138 = getelementptr i64, ptr %s4, i64 0
  %v246 = getelementptr i64, ptr @"rt.meta", i64 0
  %v139.p = getelementptr i64, ptr %v246, i64 0
  %v139 = load i64, ptr %v139.p
  %v140 = getelementptr i64, ptr %s3, i64 0
  %st35 = getelementptr i64, ptr %v140, i64 0
  store i64 %v136, ptr %st35
  %v247 = getelementptr i64, ptr @"rt.meta", i64 0
  %v141.p = getelementptr i64, ptr %v247, i64 0
  %v141 = load i64, ptr %v141.p
  br label %b25
b13:
  %v79 = getelementptr i64, ptr %s5, i64 0
  %v80.p = getelementptr i64, ptr %v22, i64 0
  %v80 = load i64, ptr %v80.p
  %st36 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st36
  %v81.p = getelementptr i64, ptr %v22, i64 1
  %v81 = load i64, ptr %v81.p
  %st37 = getelementptr i64, ptr %v79, i64 1
  store i64 %v81, ptr %st37
  %v82.p = getelementptr i64, ptr %v22, i64 2
  %v82 = load i64, ptr %v82.p
  %st38 = getelementptr i64, ptr %v79, i64 2
  store i64 %v82, ptr %st38
  %v83.p = getelementptr i64, ptr %v79, i64 2
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v79, i64 0
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v79, i64 1
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 %v84, %v85
  %v89 = getelementptr i64, ptr @"rt.btip", i64 0
  %v90 = getelementptr i64, ptr %v89, i64 %v83
  %v91.p = getelementptr i64, ptr %v90, i64 0
  %v91 = load i64, ptr %v91.p
  %v92.c = icmp eq i64 %v91, %v86
  %v92 = zext i1 %v92.c to i64
  %c.b13 = icmp ne i64 %v92, 0
  br i1 %c.b13, label %b13.t40, label %b13.e41
b13.t40:
  br label %b17
b13.e41:
  br label %b15
b14:
  %v87 = phi ptr [ %v122, %b15 ], [ %v119, %b16 ]
  %v88 = phi ptr [ %v124, %b15 ], [ %v120, %b16 ]
  %v125.p = getelementptr i64, ptr %v5, i64 0
  %v125 = load i64, ptr %v125.p
  %v126 = inttoptr i64 %v125 to ptr
  %v127 = getelementptr i8, ptr %v126, i64 %v70
  call void @"rt.copy8"(ptr %v88, ptr %v127, i64 %v72)
  %v128.p = getelementptr i64, ptr %v79, i64 1
  %v128 = load i64, ptr %v128.p
  %v129 = add i64 %v128, %v72
  %v130 = getelementptr i64, ptr %s1, i64 0
  %v131 = ptrtoint ptr %v87 to i64
  %st41 = getelementptr i64, ptr %v130, i64 0
  store i64 %v131, ptr %st41
  %st42 = getelementptr i64, ptr %v130, i64 1
  store i64 %v129, ptr %st42
  %st43 = getelementptr i64, ptr %v130, i64 2
  store i64 %v83, ptr %st43
  %v132.p = getelementptr i64, ptr %v130, i64 0
  %v132 = load i64, ptr %v132.p
  %st44 = getelementptr i64, ptr %v22, i64 0
  store i64 %v132, ptr %st44
  %v133.p = getelementptr i64, ptr %v130, i64 1
  %v133 = load i64, ptr %v133.p
  %st45 = getelementptr i64, ptr %v22, i64 1
  store i64 %v133, ptr %st45
  %v134.p = getelementptr i64, ptr %v130, i64 2
  %v134 = load i64, ptr %v134.p
  %st46 = getelementptr i64, ptr %v22, i64 2
  store i64 %v134, ptr %st46
  br label %b10
b15:
  %v121 = add i64 %v85, %v72
  %v122 = call ptr @"rt.region_alloc8"(i64 %v83, i64 %v121)
  %v123 = inttoptr i64 %v84 to ptr
  call void @"rt.copy8"(ptr %v122, ptr %v123, i64 %v85)
  %v124 = getelementptr i8, ptr %v122, i64 %v85
  br label %b14
b16:
  %v119 = inttoptr i64 %v84 to ptr
  %v120 = getelementptr i8, ptr %v119, i64 %v85
  br label %b14
b17:
  %v93 = add i64 0, 7
  %v94 = add i64 %v86, %v93
  %v95 = add i64 0, -8
  %v96 = and i64 %v94, %v95
  %v97 = add i64 %v86, %v72
  %v98 = add i64 0, 7
  %v99 = add i64 %v97, %v98
  %v100 = add i64 0, -8
  %v101 = and i64 %v99, %v100
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %v103 = getelementptr i64, ptr %v102, i64 %v83
  %v104.p = getelementptr i64, ptr %v103, i64 1
  %v104 = load i64, ptr %v104.p
  %v105.c = icmp sle i64 %v97, %v96
  %v105 = zext i1 %v105.c to i64
  %v106.c = icmp eq i64 %v104, %v96
  %v106 = zext i1 %v106.c to i64
  %v107 = or i64 %v105, %v106
  %v108 = add i64 0, 0
  %v109.c = icmp ne i64 %v107, %v108
  %v109 = zext i1 %v109.c to i64
  %c.b17 = icmp ne i64 %v109, 0
  br i1 %c.b17, label %b17.t48, label %b17.e49
b17.t48:
  br label %b18
b17.e49:
  br label %b15
b18:
  %v110.c = icmp sgt i64 %v101, %v104
  %v110 = zext i1 %v110.c to i64
  %c.b18 = icmp ne i64 %v110, 0
  br i1 %c.b18, label %b18.t50, label %b18.e51
b18.t50:
  br label %b19
b18.e51:
  br label %b20
b19:
  %v111.p = getelementptr i64, ptr %v102, i64 1029
  %v111 = load i64, ptr %v111.p
  %v112 = add i64 0, 1
  %v113 = add i64 %v83, %v112
  %v114.p = getelementptr i64, ptr %v102, i64 1030
  %v114 = load i64, ptr %v114.p
  %v115 = mul i64 %v113, %v114
  %v116 = add i64 %v111, %v115
  %v117.c = icmp sgt i64 %v101, %v116
  %v117 = zext i1 %v117.c to i64
  %c.b19 = icmp ne i64 %v117, 0
  br i1 %c.b19, label %b19.t52, label %b19.e53
b19.t52:
  br label %b21
b19.e53:
  br label %b22
b20:
  %st53 = getelementptr i64, ptr %v90, i64 0
  store i64 %v97, ptr %st53
  br label %b16
b21:
  %v118 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v118)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b22:
  %st54 = getelementptr i64, ptr %v103, i64 1
  store i64 %v101, ptr %st54
  br label %b20
b23:
  %v248 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v248, i64 0
  store i64 %v135, ptr %st55
  br label %b10
b24:
  br label %b23
b25:
  %v249 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v249, i64 0
  store i64 %v141, ptr %st56
  %v142.p = getelementptr i64, ptr %v140, i64 0
  %v142 = load i64, ptr %v142.p
  %v143.c = icmp slt i64 %v142, %v137
  %v143 = zext i1 %v143.c to i64
  %c.b25 = icmp ne i64 %v143, 0
  br i1 %c.b25, label %b25.t58, label %b25.e59
b25.t58:
  br label %b26
b25.e59:
  br label %b27
b26:
  call void @"rt.region_enter"()
  %v250 = getelementptr i64, ptr @"rt.meta", i64 0
  %v144.p = getelementptr i64, ptr %v250, i64 0
  %v144 = load i64, ptr %v144.p
  %v145.p = getelementptr i64, ptr %v140, i64 0
  %v145 = load i64, ptr %v145.p
  %v251 = getelementptr i64, ptr @"rt.meta", i64 0
  %v146.p = getelementptr i64, ptr %v251, i64 0
  %v146 = load i64, ptr %v146.p
  %v147 = add i64 0, 1
  %v148 = add i64 %v6, %v147
  %v149 = getelementptr i64, ptr %s6, i64 0
  %v150.p = getelementptr i64, ptr %v22, i64 0
  %v150 = load i64, ptr %v150.p
  %st59 = getelementptr i64, ptr %v149, i64 0
  store i64 %v150, ptr %st59
  %v151.p = getelementptr i64, ptr %v22, i64 1
  %v151 = load i64, ptr %v151.p
  %st60 = getelementptr i64, ptr %v149, i64 1
  store i64 %v151, ptr %st60
  %v152.p = getelementptr i64, ptr %v22, i64 2
  %v152 = load i64, ptr %v152.p
  %st61 = getelementptr i64, ptr %v149, i64 2
  store i64 %v152, ptr %st61
  %v153.p = getelementptr i64, ptr %v5, i64 1
  %v153 = load i64, ptr %v153.p
  %v154.c = icmp uge i64 %v145, %v153
  %v154 = zext i1 %v154.c to i64
  %c.b26 = icmp ne i64 %v154, 0
  br i1 %c.b26, label %b26.t63, label %b26.e64
b26.t63:
  br label %b29
b26.e64:
  br label %b30
b27:
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %st64 = getelementptr i64, ptr %v252, i64 0
  store i64 %v141, ptr %st64
  br label %b24
b28:
  %v253 = getelementptr i64, ptr @"rt.meta", i64 0
  %st65 = getelementptr i64, ptr %v253, i64 0
  store i64 %v146, ptr %st65
  %v182 = add i64 0, 1
  %v183.p = getelementptr i64, ptr %v140, i64 0
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 %v183, %v182
  %st66 = getelementptr i64, ptr %v140, i64 0
  store i64 %v184, ptr %st66
  br label %b25
b29:
  %v155 = add i64 0, 4
  call void @"rt.panic"(i64 %v155)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v156.p = getelementptr i64, ptr %v5, i64 0
  %v156 = load i64, ptr %v156.p
  %v157 = inttoptr i64 %v156 to ptr
  %v158 = getelementptr i8, ptr %v157, i64 %v145
  %v159.p = getelementptr i8, ptr %v158, i64 0
  %v159.b = load i8, ptr %v159.p
  %v159 = zext i8 %v159.b to i64
  %v160.p = getelementptr i64, ptr %v149, i64 2
  %v160 = load i64, ptr %v160.p
  %v161.p = getelementptr i64, ptr %v149, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v149, i64 1
  %v162 = load i64, ptr %v162.p
  %v165 = add i64 %v161, %v162
  %v166 = call i64 @"rt.tip8"(i64 %v160, i64 %v165)
  %v167 = add i64 0, 0
  %v168.c = icmp ne i64 %v166, %v167
  %v168 = zext i1 %v168.c to i64
  %c.b30 = icmp ne i64 %v168, 0
  br i1 %c.b30, label %b30.t68, label %b30.e69
b30.t68:
  br label %b33
b30.e69:
  br label %b32
b31:
  %v163 = phi ptr [ %v172, %b32 ], [ %v169, %b33 ]
  %v164 = phi ptr [ %v173, %b32 ], [ %v170, %b33 ]
  %st69 = getelementptr i8, ptr %v164, i64 0
  %st69.b = trunc i64 %v159 to i8
  store i8 %st69.b, ptr %st69
  %v174.p = getelementptr i64, ptr %v149, i64 1
  %v174 = load i64, ptr %v174.p
  %v175 = add i64 0, 1
  %v176 = add i64 %v174, %v175
  %v177 = getelementptr i64, ptr %s7, i64 0
  %v178 = ptrtoint ptr %v163 to i64
  %st70 = getelementptr i64, ptr %v177, i64 0
  store i64 %v178, ptr %st70
  %st71 = getelementptr i64, ptr %v177, i64 1
  store i64 %v176, ptr %st71
  %st72 = getelementptr i64, ptr %v177, i64 2
  store i64 %v160, ptr %st72
  %v179.p = getelementptr i64, ptr %v177, i64 0
  %v179 = load i64, ptr %v179.p
  %st73 = getelementptr i64, ptr %v22, i64 0
  store i64 %v179, ptr %st73
  %v180.p = getelementptr i64, ptr %v177, i64 1
  %v180 = load i64, ptr %v180.p
  %st74 = getelementptr i64, ptr %v22, i64 1
  store i64 %v180, ptr %st74
  %v181.p = getelementptr i64, ptr %v177, i64 2
  %v181 = load i64, ptr %v181.p
  %st75 = getelementptr i64, ptr %v22, i64 2
  store i64 %v181, ptr %st75
  br label %b28
b32:
  %v171 = add i64 0, 1
  %v172 = call ptr @"rt.slice_grow8"(i64 %v161, i64 %v162, i64 %v160, i64 %v171)
  %v173 = getelementptr i8, ptr %v172, i64 %v162
  br label %b31
b33:
  %v169 = inttoptr i64 %v161 to ptr
  %v170 = getelementptr i8, ptr %v169, i64 %v162
  br label %b31
b34:
  %v254 = getelementptr i64, ptr @"rt.meta", i64 0
  %st76 = getelementptr i64, ptr %v254, i64 0
  store i64 %v185, ptr %st76
  %v229.p = getelementptr i64, ptr %v22, i64 0
  %v229 = load i64, ptr %v229.p
  %st77 = getelementptr i64, ptr %v0, i64 0
  store i64 %v229, ptr %st77
  %v230.p = getelementptr i64, ptr %v22, i64 1
  %v230 = load i64, ptr %v230.p
  %st78 = getelementptr i64, ptr %v0, i64 1
  store i64 %v230, ptr %st78
  %v231.p = getelementptr i64, ptr %v22, i64 2
  %v231 = load i64, ptr %v231.p
  %st79 = getelementptr i64, ptr %v0, i64 2
  store i64 %v231, ptr %st79
  call void @"rt.region_relocate8"(ptr %v0, i64 %v6)
  %v255 = getelementptr i64, ptr @"rt.meta", i64 0
  %st80 = getelementptr i64, ptr %v255, i64 0
  store i64 %v6, ptr %st80
  ret void
b35:
  br label %b34
b36:
  %v256 = getelementptr i64, ptr @"rt.meta", i64 0
  %st81 = getelementptr i64, ptr %v256, i64 0
  store i64 %v191, ptr %st81
  %v192.p = getelementptr i64, ptr %v190, i64 0
  %v192 = load i64, ptr %v192.p
  %v193.c = icmp slt i64 %v192, %v187
  %v193 = zext i1 %v193.c to i64
  %c.b36 = icmp ne i64 %v193, 0
  br i1 %c.b36, label %b36.t83, label %b36.e84
b36.t83:
  br label %b37
b36.e84:
  br label %b38
b37:
  call void @"rt.region_enter"()
  %v257 = getelementptr i64, ptr @"rt.meta", i64 0
  %v194.p = getelementptr i64, ptr %v257, i64 0
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v190, i64 0
  %v195 = load i64, ptr %v195.p
  %v258 = getelementptr i64, ptr @"rt.meta", i64 0
  %v196.p = getelementptr i64, ptr %v258, i64 0
  %v196 = load i64, ptr %v196.p
  %v197 = add i64 0, 1
  %v198 = add i64 %v6, %v197
  %v199 = getelementptr i64, ptr %s1, i64 0
  %v200.p = getelementptr i64, ptr %v22, i64 0
  %v200 = load i64, ptr %v200.p
  %st84 = getelementptr i64, ptr %v199, i64 0
  store i64 %v200, ptr %st84
  %v201.p = getelementptr i64, ptr %v22, i64 1
  %v201 = load i64, ptr %v201.p
  %st85 = getelementptr i64, ptr %v199, i64 1
  store i64 %v201, ptr %st85
  %v202.p = getelementptr i64, ptr %v22, i64 2
  %v202 = load i64, ptr %v202.p
  %st86 = getelementptr i64, ptr %v199, i64 2
  store i64 %v202, ptr %st86
  %v203 = add i64 0, 90
  %v204.p = getelementptr i64, ptr %v199, i64 2
  %v204 = load i64, ptr %v204.p
  %v205.p = getelementptr i64, ptr %v199, i64 0
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v199, i64 1
  %v206 = load i64, ptr %v206.p
  %v209 = add i64 %v205, %v206
  %v210 = call i64 @"rt.tip8"(i64 %v204, i64 %v209)
  %v211 = add i64 0, 0
  %v212.c = icmp ne i64 %v210, %v211
  %v212 = zext i1 %v212.c to i64
  %c.b37 = icmp ne i64 %v212, 0
  br i1 %c.b37, label %b37.t88, label %b37.e89
b37.t88:
  br label %b42
b37.e89:
  br label %b41
b38:
  %v259 = getelementptr i64, ptr @"rt.meta", i64 0
  %st89 = getelementptr i64, ptr %v259, i64 0
  store i64 %v191, ptr %st89
  br label %b35
b39:
  %v260 = getelementptr i64, ptr @"rt.meta", i64 0
  %st90 = getelementptr i64, ptr %v260, i64 0
  store i64 %v196, ptr %st90
  %v226 = add i64 0, 1
  %v227.p = getelementptr i64, ptr %v190, i64 0
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 %v227, %v226
  %st91 = getelementptr i64, ptr %v190, i64 0
  store i64 %v228, ptr %st91
  br label %b36
b40:
  %v207 = phi ptr [ %v216, %b41 ], [ %v213, %b42 ]
  %v208 = phi ptr [ %v217, %b41 ], [ %v214, %b42 ]
  %st92 = getelementptr i8, ptr %v208, i64 0
  %st92.b = trunc i64 %v203 to i8
  store i8 %st92.b, ptr %st92
  %v218.p = getelementptr i64, ptr %v199, i64 1
  %v218 = load i64, ptr %v218.p
  %v219 = add i64 0, 1
  %v220 = add i64 %v218, %v219
  %v221 = getelementptr i64, ptr %s5, i64 0
  %v222 = ptrtoint ptr %v207 to i64
  %st93 = getelementptr i64, ptr %v221, i64 0
  store i64 %v222, ptr %st93
  %st94 = getelementptr i64, ptr %v221, i64 1
  store i64 %v220, ptr %st94
  %st95 = getelementptr i64, ptr %v221, i64 2
  store i64 %v204, ptr %st95
  %v223.p = getelementptr i64, ptr %v221, i64 0
  %v223 = load i64, ptr %v223.p
  %st96 = getelementptr i64, ptr %v22, i64 0
  store i64 %v223, ptr %st96
  %v224.p = getelementptr i64, ptr %v221, i64 1
  %v224 = load i64, ptr %v224.p
  %st97 = getelementptr i64, ptr %v22, i64 1
  store i64 %v224, ptr %st97
  %v225.p = getelementptr i64, ptr %v221, i64 2
  %v225 = load i64, ptr %v225.p
  %st98 = getelementptr i64, ptr %v22, i64 2
  store i64 %v225, ptr %st98
  br label %b39
b41:
  %v215 = add i64 0, 1
  %v216 = call ptr @"rt.slice_grow8"(i64 %v205, i64 %v206, i64 %v204, i64 %v215)
  %v217 = getelementptr i8, ptr %v216, i64 %v206
  br label %b40
b42:
  %v213 = inttoptr i64 %v205 to ptr
  %v214 = getelementptr i8, ptr %v213, i64 %v206
  br label %b40
}

define internal void @"main.flip"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  %v5 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v5, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v93, i64 0
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
  %v17 = add i64 0, 0
  %v18 = call ptr @"rt.region_alloc8"(i64 %v16, i64 %v17)
  %v19 = add i64 0, 0
  %v20 = getelementptr i64, ptr %s1, i64 0
  %v21 = ptrtoint ptr %v18 to i64
  %st4 = getelementptr i64, ptr %v20, i64 0
  store i64 %v21, ptr %st4
  %st5 = getelementptr i64, ptr %v20, i64 1
  store i64 %v19, ptr %st5
  %st6 = getelementptr i64, ptr %v20, i64 2
  store i64 %v16, ptr %st6
  %v22 = getelementptr i64, ptr %s2, i64 0
  %v23.p = getelementptr i64, ptr %v20, i64 0
  %v23 = load i64, ptr %v23.p
  %st7 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st7
  %v24.p = getelementptr i64, ptr %v20, i64 1
  %v24 = load i64, ptr %v24.p
  %st8 = getelementptr i64, ptr %v22, i64 1
  store i64 %v24, ptr %st8
  %v25.p = getelementptr i64, ptr %v20, i64 2
  %v25 = load i64, ptr %v25.p
  %st9 = getelementptr i64, ptr %v22, i64 2
  store i64 %v25, ptr %st9
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %v26.p = getelementptr i64, ptr %v94, i64 0
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28.p = getelementptr i64, ptr %v5, i64 1
  %v28 = load i64, ptr %v28.p
  %v29 = getelementptr i64, ptr %s3, i64 0
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %v30.p = getelementptr i64, ptr %v95, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = getelementptr i64, ptr %s4, i64 0
  %st10 = getelementptr i64, ptr %v31, i64 0
  store i64 %v27, ptr %st10
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v96, i64 0
  %v32 = load i64, ptr %v32.p
  br label %b3
b1:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v97, i64 0
  store i64 %v26, ptr %st11
  %v90.p = getelementptr i64, ptr %v22, i64 0
  %v90 = load i64, ptr %v90.p
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v90, ptr %st12
  %v91.p = getelementptr i64, ptr %v22, i64 1
  %v91 = load i64, ptr %v91.p
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v91, ptr %st13
  %v92.p = getelementptr i64, ptr %v22, i64 2
  %v92 = load i64, ptr %v92.p
  %st14 = getelementptr i64, ptr %v0, i64 2
  store i64 %v92, ptr %st14
  call void @"rt.region_relocate8"(ptr %v0, i64 %v6)
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v98, i64 0
  store i64 %v6, ptr %st15
  ret void
b2:
  br label %b1
b3:
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v99, i64 0
  store i64 %v32, ptr %st16
  %v33.p = getelementptr i64, ptr %v31, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.c = icmp slt i64 %v33, %v28
  %v34 = zext i1 %v34.c to i64
  %c.b3 = icmp ne i64 %v34, 0
  br i1 %c.b3, label %b3.t18, label %b3.e19
b3.t18:
  br label %b4
b3.e19:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %v35.p = getelementptr i64, ptr %v100, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.p = getelementptr i64, ptr %v31, i64 0
  %v36 = load i64, ptr %v36.p
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v101, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 1
  %v39 = add i64 %v6, %v38
  %v40 = getelementptr i64, ptr %s1, i64 0
  %v41.p = getelementptr i64, ptr %v22, i64 0
  %v41 = load i64, ptr %v41.p
  %st19 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st19
  %v42.p = getelementptr i64, ptr %v22, i64 1
  %v42 = load i64, ptr %v42.p
  %st20 = getelementptr i64, ptr %v40, i64 1
  store i64 %v42, ptr %st20
  %v43.p = getelementptr i64, ptr %v22, i64 2
  %v43 = load i64, ptr %v43.p
  %st21 = getelementptr i64, ptr %v40, i64 2
  store i64 %v43, ptr %st21
  %v44.c = icmp eq i64 %v36, %v4
  %v44 = zext i1 %v44.c to i64
  %c.b4 = icmp ne i64 %v44, 0
  br i1 %c.b4, label %b4.t23, label %b4.e24
b4.t23:
  br label %b7
b4.e24:
  br label %b8
b5:
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v102, i64 0
  store i64 %v32, ptr %st24
  br label %b2
b6:
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v103, i64 0
  store i64 %v37, ptr %st25
  %v87 = add i64 0, 1
  %v88.p = getelementptr i64, ptr %v31, i64 0
  %v88 = load i64, ptr %v88.p
  %v89 = add i64 %v88, %v87
  %st26 = getelementptr i64, ptr %v31, i64 0
  store i64 %v89, ptr %st26
  br label %b3
b7:
  %v45.p = getelementptr i64, ptr %v5, i64 1
  %v45 = load i64, ptr %v45.p
  %v46.c = icmp uge i64 %v36, %v45
  %v46 = zext i1 %v46.c to i64
  %c.b7 = icmp ne i64 %v46, 0
  br i1 %c.b7, label %b7.t28, label %b7.e29
b7.t28:
  br label %b9
b7.e29:
  br label %b10
b8:
  %v57.p = getelementptr i64, ptr %v5, i64 1
  %v57 = load i64, ptr %v57.p
  %v58.c = icmp uge i64 %v36, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b8 = icmp ne i64 %v58, 0
  br i1 %c.b8, label %b8.t30, label %b8.e31
b8.t30:
  br label %b13
b8.e31:
  br label %b14
b9:
  %v47 = add i64 0, 5
  call void @"rt.panic"(i64 %v47)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v48.p = getelementptr i64, ptr %v5, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = inttoptr i64 %v48 to ptr
  %v50 = getelementptr i8, ptr %v49, i64 %v36
  %v51.p = getelementptr i8, ptr %v50, i64 0
  %v51.b = load i8, ptr %v51.p
  %v51 = zext i8 %v51.b to i64
  %v52 = add i64 0, 1
  %v53 = xor i64 %v51, %v52
  %v54 = add i64 0, 256
  %v55.c = icmp uge i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b10 = icmp ne i64 %v55, 0
  br i1 %c.b10, label %b10.t32, label %b10.e33
b10.t32:
  br label %b11
b10.e33:
  br label %b12
b11:
  %v56 = add i64 0, 6
  call void @"rt.panic"(i64 %v56)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  br label %b15
b13:
  %v59 = add i64 0, 7
  call void @"rt.panic"(i64 %v59)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v60.p = getelementptr i64, ptr %v5, i64 0
  %v60 = load i64, ptr %v60.p
  %v61 = inttoptr i64 %v60 to ptr
  %v62 = getelementptr i8, ptr %v61, i64 %v36
  %v63.p = getelementptr i8, ptr %v62, i64 0
  %v63.b = load i8, ptr %v63.p
  %v63 = zext i8 %v63.b to i64
  br label %b15
b15:
  %v64 = phi i64 [ %v53, %b12 ], [ %v63, %b14 ]
  %v65.p = getelementptr i64, ptr %v40, i64 2
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v40, i64 0
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v40, i64 1
  %v67 = load i64, ptr %v67.p
  %v70 = add i64 %v66, %v67
  %v71 = call i64 @"rt.tip8"(i64 %v65, i64 %v70)
  %v72 = add i64 0, 0
  %v73.c = icmp ne i64 %v71, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b15 = icmp ne i64 %v73, 0
  br i1 %c.b15, label %b15.t34, label %b15.e35
b15.t34:
  br label %b18
b15.e35:
  br label %b17
b16:
  %v68 = phi ptr [ %v77, %b17 ], [ %v74, %b18 ]
  %v69 = phi ptr [ %v78, %b17 ], [ %v75, %b18 ]
  %st35 = getelementptr i8, ptr %v69, i64 0
  %st35.b = trunc i64 %v64 to i8
  store i8 %st35.b, ptr %st35
  %v79.p = getelementptr i64, ptr %v40, i64 1
  %v79 = load i64, ptr %v79.p
  %v80 = add i64 0, 1
  %v81 = add i64 %v79, %v80
  %v82 = getelementptr i64, ptr %s5, i64 0
  %v83 = ptrtoint ptr %v68 to i64
  %st36 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st36
  %st37 = getelementptr i64, ptr %v82, i64 1
  store i64 %v81, ptr %st37
  %st38 = getelementptr i64, ptr %v82, i64 2
  store i64 %v65, ptr %st38
  %v84.p = getelementptr i64, ptr %v82, i64 0
  %v84 = load i64, ptr %v84.p
  %st39 = getelementptr i64, ptr %v22, i64 0
  store i64 %v84, ptr %st39
  %v85.p = getelementptr i64, ptr %v82, i64 1
  %v85 = load i64, ptr %v85.p
  %st40 = getelementptr i64, ptr %v22, i64 1
  store i64 %v85, ptr %st40
  %v86.p = getelementptr i64, ptr %v82, i64 2
  %v86 = load i64, ptr %v86.p
  %st41 = getelementptr i64, ptr %v22, i64 2
  store i64 %v86, ptr %st41
  br label %b6
b17:
  %v76 = add i64 0, 1
  %v77 = call ptr @"rt.slice_grow8"(i64 %v66, i64 %v67, i64 %v65, i64 %v76)
  %v78 = getelementptr i8, ptr %v77, i64 %v67
  br label %b16
b18:
  %v74 = inttoptr i64 %v66 to ptr
  %v75 = getelementptr i8, ptr %v74, i64 %v67
  br label %b16
}

define internal void @"main.record"(i64 %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11) #0 {
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
  %s4 = alloca [8 x i64], align 8
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
  %s4.z6 = getelementptr i64, ptr %s4, i64 6
  store i64 0, ptr %s4.z6
  %s4.z7 = getelementptr i64, ptr %s4, i64 7
  store i64 0, ptr %s4.z7
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
  %s9 = alloca [8 x i64], align 8
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
  %s9.z6 = getelementptr i64, ptr %s9, i64 6
  store i64 0, ptr %s9.z6
  %s9.z7 = getelementptr i64, ptr %s9, i64 7
  store i64 0, ptr %s9.z7
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
  %s16 = alloca [8 x i64], align 8
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
  %s16.z7 = getelementptr i64, ptr %s16, i64 7
  store i64 0, ptr %s16.z7
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
  %s22 = alloca [8 x i64], align 8
  %s22.z0 = getelementptr i64, ptr %s22, i64 0
  store i64 0, ptr %s22.z0
  %s22.z1 = getelementptr i64, ptr %s22, i64 1
  store i64 0, ptr %s22.z1
  %s22.z2 = getelementptr i64, ptr %s22, i64 2
  store i64 0, ptr %s22.z2
  %s22.z3 = getelementptr i64, ptr %s22, i64 3
  store i64 0, ptr %s22.z3
  %s22.z4 = getelementptr i64, ptr %s22, i64 4
  store i64 0, ptr %s22.z4
  %s22.z5 = getelementptr i64, ptr %s22, i64 5
  store i64 0, ptr %s22.z5
  %s22.z6 = getelementptr i64, ptr %s22, i64 6
  store i64 0, ptr %s22.z6
  %s22.z7 = getelementptr i64, ptr %s22, i64 7
  store i64 0, ptr %s22.z7
  %s23 = alloca [3 x i64], align 8
  %s23.z0 = getelementptr i64, ptr %s23, i64 0
  store i64 0, ptr %s23.z0
  %s23.z1 = getelementptr i64, ptr %s23, i64 1
  store i64 0, ptr %s23.z1
  %s23.z2 = getelementptr i64, ptr %s23, i64 2
  store i64 0, ptr %s23.z2
  %s24 = alloca [5 x i64], align 8
  %s24.z0 = getelementptr i64, ptr %s24, i64 0
  store i64 0, ptr %s24.z0
  %s24.z1 = getelementptr i64, ptr %s24, i64 1
  store i64 0, ptr %s24.z1
  %s24.z2 = getelementptr i64, ptr %s24, i64 2
  store i64 0, ptr %s24.z2
  %s24.z3 = getelementptr i64, ptr %s24, i64 3
  store i64 0, ptr %s24.z3
  %s24.z4 = getelementptr i64, ptr %s24, i64 4
  store i64 0, ptr %s24.z4
  %s25 = alloca [4 x i64], align 8
  %s25.z0 = getelementptr i64, ptr %s25, i64 0
  store i64 0, ptr %s25.z0
  %s25.z1 = getelementptr i64, ptr %s25, i64 1
  store i64 0, ptr %s25.z1
  %s25.z2 = getelementptr i64, ptr %s25, i64 2
  store i64 0, ptr %s25.z2
  %s25.z3 = getelementptr i64, ptr %s25, i64 3
  store i64 0, ptr %s25.z3
  %s26 = alloca [8 x i64], align 8
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
  %s26.z6 = getelementptr i64, ptr %s26, i64 6
  store i64 0, ptr %s26.z6
  %s26.z7 = getelementptr i64, ptr %s26, i64 7
  store i64 0, ptr %s26.z7
  %s27 = alloca [3 x i64], align 8
  %s27.z0 = getelementptr i64, ptr %s27, i64 0
  store i64 0, ptr %s27.z0
  %s27.z1 = getelementptr i64, ptr %s27, i64 1
  store i64 0, ptr %s27.z1
  %s27.z2 = getelementptr i64, ptr %s27, i64 2
  store i64 0, ptr %s27.z2
  %s28 = alloca [8 x i64], align 8
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
  %s28.z5 = getelementptr i64, ptr %s28, i64 5
  store i64 0, ptr %s28.z5
  %s28.z6 = getelementptr i64, ptr %s28, i64 6
  store i64 0, ptr %s28.z6
  %s28.z7 = getelementptr i64, ptr %s28, i64 7
  store i64 0, ptr %s28.z7
  %s29 = alloca [3 x i64], align 8
  %s29.z0 = getelementptr i64, ptr %s29, i64 0
  store i64 0, ptr %s29.z0
  %s29.z1 = getelementptr i64, ptr %s29, i64 1
  store i64 0, ptr %s29.z1
  %s29.z2 = getelementptr i64, ptr %s29, i64 2
  store i64 0, ptr %s29.z2
  %s30 = alloca [5 x i64], align 8
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
  %s31 = alloca [1 x i64], align 8
  %s31.z0 = getelementptr i64, ptr %s31, i64 0
  store i64 0, ptr %s31.z0
  %s32 = alloca [1 x i64], align 8
  %s32.z0 = getelementptr i64, ptr %s32, i64 0
  store i64 0, ptr %s32.z0
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
  %s36 = alloca [8 x i64], align 8
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
  %s36.z5 = getelementptr i64, ptr %s36, i64 5
  store i64 0, ptr %s36.z5
  %s36.z6 = getelementptr i64, ptr %s36, i64 6
  store i64 0, ptr %s36.z6
  %s36.z7 = getelementptr i64, ptr %s36, i64 7
  store i64 0, ptr %s36.z7
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
  %s39 = alloca [8 x i64], align 8
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
  %s44 = alloca [8 x i64], align 8
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
  %s44.z6 = getelementptr i64, ptr %s44, i64 6
  store i64 0, ptr %s44.z6
  %s44.z7 = getelementptr i64, ptr %s44, i64 7
  store i64 0, ptr %s44.z7
  %s45 = alloca [3 x i64], align 8
  %s45.z0 = getelementptr i64, ptr %s45, i64 0
  store i64 0, ptr %s45.z0
  %s45.z1 = getelementptr i64, ptr %s45, i64 1
  store i64 0, ptr %s45.z1
  %s45.z2 = getelementptr i64, ptr %s45, i64 2
  store i64 0, ptr %s45.z2
  %s46 = alloca [5 x i64], align 8
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
  %s47 = alloca [1 x i64], align 8
  %s47.z0 = getelementptr i64, ptr %s47, i64 0
  store i64 0, ptr %s47.z0
  %s48 = alloca [1 x i64], align 8
  %s48.z0 = getelementptr i64, ptr %s48, i64 0
  store i64 0, ptr %s48.z0
  %s49 = alloca [3 x i64], align 8
  %s49.z0 = getelementptr i64, ptr %s49, i64 0
  store i64 0, ptr %s49.z0
  %s49.z1 = getelementptr i64, ptr %s49, i64 1
  store i64 0, ptr %s49.z1
  %s49.z2 = getelementptr i64, ptr %s49, i64 2
  store i64 0, ptr %s49.z2
  %s50 = alloca [8 x i64], align 8
  %s50.z0 = getelementptr i64, ptr %s50, i64 0
  store i64 0, ptr %s50.z0
  %s50.z1 = getelementptr i64, ptr %s50, i64 1
  store i64 0, ptr %s50.z1
  %s50.z2 = getelementptr i64, ptr %s50, i64 2
  store i64 0, ptr %s50.z2
  %s50.z3 = getelementptr i64, ptr %s50, i64 3
  store i64 0, ptr %s50.z3
  %s50.z4 = getelementptr i64, ptr %s50, i64 4
  store i64 0, ptr %s50.z4
  %s50.z5 = getelementptr i64, ptr %s50, i64 5
  store i64 0, ptr %s50.z5
  %s50.z6 = getelementptr i64, ptr %s50, i64 6
  store i64 0, ptr %s50.z6
  %s50.z7 = getelementptr i64, ptr %s50, i64 7
  store i64 0, ptr %s50.z7
  %s51 = alloca [3 x i64], align 8
  %s51.z0 = getelementptr i64, ptr %s51, i64 0
  store i64 0, ptr %s51.z0
  %s51.z1 = getelementptr i64, ptr %s51, i64 1
  store i64 0, ptr %s51.z1
  %s51.z2 = getelementptr i64, ptr %s51, i64 2
  store i64 0, ptr %s51.z2
  %s52 = alloca [1 x i64], align 8
  %s52.z0 = getelementptr i64, ptr %s52, i64 0
  store i64 0, ptr %s52.z0
  %s53 = alloca [1 x i64], align 8
  %s53.z0 = getelementptr i64, ptr %s53, i64 0
  store i64 0, ptr %s53.z0
  %s54 = alloca [8 x i64], align 8
  %s54.z0 = getelementptr i64, ptr %s54, i64 0
  store i64 0, ptr %s54.z0
  %s54.z1 = getelementptr i64, ptr %s54, i64 1
  store i64 0, ptr %s54.z1
  %s54.z2 = getelementptr i64, ptr %s54, i64 2
  store i64 0, ptr %s54.z2
  %s54.z3 = getelementptr i64, ptr %s54, i64 3
  store i64 0, ptr %s54.z3
  %s54.z4 = getelementptr i64, ptr %s54, i64 4
  store i64 0, ptr %s54.z4
  %s54.z5 = getelementptr i64, ptr %s54, i64 5
  store i64 0, ptr %s54.z5
  %s54.z6 = getelementptr i64, ptr %s54, i64 6
  store i64 0, ptr %s54.z6
  %s54.z7 = getelementptr i64, ptr %s54, i64 7
  store i64 0, ptr %s54.z7
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
  %s59 = alloca [8 x i64], align 8
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
  %s60 = alloca [8 x i64], align 8
  %s60.z0 = getelementptr i64, ptr %s60, i64 0
  store i64 0, ptr %s60.z0
  %s60.z1 = getelementptr i64, ptr %s60, i64 1
  store i64 0, ptr %s60.z1
  %s60.z2 = getelementptr i64, ptr %s60, i64 2
  store i64 0, ptr %s60.z2
  %s60.z3 = getelementptr i64, ptr %s60, i64 3
  store i64 0, ptr %s60.z3
  %s60.z4 = getelementptr i64, ptr %s60, i64 4
  store i64 0, ptr %s60.z4
  %s60.z5 = getelementptr i64, ptr %s60, i64 5
  store i64 0, ptr %s60.z5
  %s60.z6 = getelementptr i64, ptr %s60, i64 6
  store i64 0, ptr %s60.z6
  %s60.z7 = getelementptr i64, ptr %s60, i64 7
  store i64 0, ptr %s60.z7
  %s61 = alloca [5 x i64], align 8
  %s61.z0 = getelementptr i64, ptr %s61, i64 0
  store i64 0, ptr %s61.z0
  %s61.z1 = getelementptr i64, ptr %s61, i64 1
  store i64 0, ptr %s61.z1
  %s61.z2 = getelementptr i64, ptr %s61, i64 2
  store i64 0, ptr %s61.z2
  %s61.z3 = getelementptr i64, ptr %s61, i64 3
  store i64 0, ptr %s61.z3
  %s61.z4 = getelementptr i64, ptr %s61, i64 4
  store i64 0, ptr %s61.z4
  %s62 = alloca [8 x i64], align 8
  %s62.z0 = getelementptr i64, ptr %s62, i64 0
  store i64 0, ptr %s62.z0
  %s62.z1 = getelementptr i64, ptr %s62, i64 1
  store i64 0, ptr %s62.z1
  %s62.z2 = getelementptr i64, ptr %s62, i64 2
  store i64 0, ptr %s62.z2
  %s62.z3 = getelementptr i64, ptr %s62, i64 3
  store i64 0, ptr %s62.z3
  %s62.z4 = getelementptr i64, ptr %s62, i64 4
  store i64 0, ptr %s62.z4
  %s62.z5 = getelementptr i64, ptr %s62, i64 5
  store i64 0, ptr %s62.z5
  %s62.z6 = getelementptr i64, ptr %s62, i64 6
  store i64 0, ptr %s62.z6
  %s62.z7 = getelementptr i64, ptr %s62, i64 7
  store i64 0, ptr %s62.z7
  %s63 = alloca [5 x i64], align 8
  %s63.z0 = getelementptr i64, ptr %s63, i64 0
  store i64 0, ptr %s63.z0
  %s63.z1 = getelementptr i64, ptr %s63, i64 1
  store i64 0, ptr %s63.z1
  %s63.z2 = getelementptr i64, ptr %s63, i64 2
  store i64 0, ptr %s63.z2
  %s63.z3 = getelementptr i64, ptr %s63, i64 3
  store i64 0, ptr %s63.z3
  %s63.z4 = getelementptr i64, ptr %s63, i64 4
  store i64 0, ptr %s63.z4
  %s64 = alloca [8 x i64], align 8
  %s64.z0 = getelementptr i64, ptr %s64, i64 0
  store i64 0, ptr %s64.z0
  %s64.z1 = getelementptr i64, ptr %s64, i64 1
  store i64 0, ptr %s64.z1
  %s64.z2 = getelementptr i64, ptr %s64, i64 2
  store i64 0, ptr %s64.z2
  %s64.z3 = getelementptr i64, ptr %s64, i64 3
  store i64 0, ptr %s64.z3
  %s64.z4 = getelementptr i64, ptr %s64, i64 4
  store i64 0, ptr %s64.z4
  %s64.z5 = getelementptr i64, ptr %s64, i64 5
  store i64 0, ptr %s64.z5
  %s64.z6 = getelementptr i64, ptr %s64, i64 6
  store i64 0, ptr %s64.z6
  %s64.z7 = getelementptr i64, ptr %s64, i64 7
  store i64 0, ptr %s64.z7
  %s65 = alloca [3 x i64], align 8
  %s65.z0 = getelementptr i64, ptr %s65, i64 0
  store i64 0, ptr %s65.z0
  %s65.z1 = getelementptr i64, ptr %s65, i64 1
  store i64 0, ptr %s65.z1
  %s65.z2 = getelementptr i64, ptr %s65, i64 2
  store i64 0, ptr %s65.z2
  %s66 = alloca [5 x i64], align 8
  %s66.z0 = getelementptr i64, ptr %s66, i64 0
  store i64 0, ptr %s66.z0
  %s66.z1 = getelementptr i64, ptr %s66, i64 1
  store i64 0, ptr %s66.z1
  %s66.z2 = getelementptr i64, ptr %s66, i64 2
  store i64 0, ptr %s66.z2
  %s66.z3 = getelementptr i64, ptr %s66, i64 3
  store i64 0, ptr %s66.z3
  %s66.z4 = getelementptr i64, ptr %s66, i64 4
  store i64 0, ptr %s66.z4
  %s67 = alloca [8 x i64], align 8
  %s67.z0 = getelementptr i64, ptr %s67, i64 0
  store i64 0, ptr %s67.z0
  %s67.z1 = getelementptr i64, ptr %s67, i64 1
  store i64 0, ptr %s67.z1
  %s67.z2 = getelementptr i64, ptr %s67, i64 2
  store i64 0, ptr %s67.z2
  %s67.z3 = getelementptr i64, ptr %s67, i64 3
  store i64 0, ptr %s67.z3
  %s67.z4 = getelementptr i64, ptr %s67, i64 4
  store i64 0, ptr %s67.z4
  %s67.z5 = getelementptr i64, ptr %s67, i64 5
  store i64 0, ptr %s67.z5
  %s67.z6 = getelementptr i64, ptr %s67, i64 6
  store i64 0, ptr %s67.z6
  %s67.z7 = getelementptr i64, ptr %s67, i64 7
  store i64 0, ptr %s67.z7
  %s68 = alloca [3 x i64], align 8
  %s68.z0 = getelementptr i64, ptr %s68, i64 0
  store i64 0, ptr %s68.z0
  %s68.z1 = getelementptr i64, ptr %s68, i64 1
  store i64 0, ptr %s68.z1
  %s68.z2 = getelementptr i64, ptr %s68, i64 2
  store i64 0, ptr %s68.z2
  %s69 = alloca [5 x i64], align 8
  %s69.z0 = getelementptr i64, ptr %s69, i64 0
  store i64 0, ptr %s69.z0
  %s69.z1 = getelementptr i64, ptr %s69, i64 1
  store i64 0, ptr %s69.z1
  %s69.z2 = getelementptr i64, ptr %s69, i64 2
  store i64 0, ptr %s69.z2
  %s69.z3 = getelementptr i64, ptr %s69, i64 3
  store i64 0, ptr %s69.z3
  %s69.z4 = getelementptr i64, ptr %s69, i64 4
  store i64 0, ptr %s69.z4
  %v12 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v12, i64 0
  store i64 %v0, ptr %st0
  %st1 = getelementptr i64, ptr %v12, i64 1
  store i64 %v1, ptr %st1
  %st2 = getelementptr i64, ptr %v12, i64 2
  store i64 %v2, ptr %st2
  %v13 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v13, i64 0
  store i64 %v3, ptr %st3
  %st4 = getelementptr i64, ptr %v13, i64 1
  store i64 %v4, ptr %st4
  %st5 = getelementptr i64, ptr %v13, i64 2
  store i64 %v5, ptr %st5
  %v14 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v6, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 1
  store i64 %v7, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 2
  store i64 %v8, ptr %st8
  %v15 = getelementptr i64, ptr %s3, i64 0
  %st9 = getelementptr i64, ptr %v15, i64 0
  store i64 %v9, ptr %st9
  %st10 = getelementptr i64, ptr %v15, i64 1
  store i64 %v10, ptr %st10
  %st11 = getelementptr i64, ptr %v15, i64 2
  store i64 %v11, ptr %st11
  %v929 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v929, i64 0
  %v16 = load i64, ptr %v16.p
  call void @"rt.region_enter"()
  %v17 = getelementptr i64, ptr %s4, i64 0
  %v18.p = getelementptr i64, ptr %v12, i64 0
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v12, i64 1
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v12, i64 2
  %v20 = load i64, ptr %v20.p
  call void @"std/crypto/chacha20poly1305.Prepare"(ptr %v17, i64 %v18, i64 %v19, i64 %v20)
  %v21 = add i64 0, 3
  %v22 = getelementptr i64, ptr %v17, i64 %v21
  %v23 = getelementptr i64, ptr %s5, i64 0
  %v24.p = getelementptr i64, ptr %v17, i64 0
  %v24 = load i64, ptr %v24.p
  %st12 = getelementptr i64, ptr %v23, i64 0
  store i64 %v24, ptr %st12
  %v25.p = getelementptr i64, ptr %v17, i64 1
  %v25 = load i64, ptr %v25.p
  %st13 = getelementptr i64, ptr %v23, i64 1
  store i64 %v25, ptr %st13
  %v26.p = getelementptr i64, ptr %v17, i64 2
  %v26 = load i64, ptr %v26.p
  %st14 = getelementptr i64, ptr %v23, i64 2
  store i64 %v26, ptr %st14
  %v27 = getelementptr i64, ptr %s6, i64 0
  %v28 = getelementptr i64, ptr @"str.14", i64 0
  %v29 = add i64 0, 10
  %v30 = add i64 0, 0
  %v31 = getelementptr i64, ptr %s7, i64 0
  %v32 = ptrtoint ptr %v28 to i64
  %st15 = getelementptr i64, ptr %v31, i64 0
  store i64 %v32, ptr %st15
  %st16 = getelementptr i64, ptr %v31, i64 1
  store i64 %v29, ptr %st16
  %st17 = getelementptr i64, ptr %v31, i64 2
  store i64 %v30, ptr %st17
  %v33.p = getelementptr i64, ptr %v31, i64 0
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v31, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.p = getelementptr i64, ptr %v31, i64 2
  %v35 = load i64, ptr %v35.p
  call void @"main.unhex"(ptr %v27, i64 %v33, i64 %v34, i64 %v35)
  %v36 = getelementptr i64, ptr %s8, i64 0
  %v37.p = getelementptr i64, ptr %v27, i64 0
  %v37 = load i64, ptr %v37.p
  %st18 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st18
  %v38.p = getelementptr i64, ptr %v27, i64 1
  %v38 = load i64, ptr %v38.p
  %st19 = getelementptr i64, ptr %v36, i64 1
  store i64 %v38, ptr %st19
  %v39.p = getelementptr i64, ptr %v27, i64 2
  %v39 = load i64, ptr %v39.p
  %st20 = getelementptr i64, ptr %v36, i64 2
  store i64 %v39, ptr %st20
  %v40 = getelementptr i64, ptr %s9, i64 0
  %v41.p = getelementptr i64, ptr %v23, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v23, i64 1
  %v42 = load i64, ptr %v42.p
  %v43.p = getelementptr i64, ptr %v23, i64 2
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v13, i64 0
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v13, i64 1
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v13, i64 2
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v14, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v14, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v14, i64 2
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v15, i64 0
  %v50 = load i64, ptr %v50.p
  %v51.p = getelementptr i64, ptr %v15, i64 1
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v15, i64 2
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v36, i64 0
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v36, i64 1
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v36, i64 2
  %v55 = load i64, ptr %v55.p
  %v930 = getelementptr i64, ptr @"rt.meta", i64 0
  %v56.p = getelementptr i64, ptr %v930, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = add i64 0, 0
  %v58 = call ptr @"rt.region_alloc8"(i64 %v56, i64 %v57)
  %v59 = add i64 0, 0
  %v60 = getelementptr i64, ptr %s7, i64 0
  %v61 = ptrtoint ptr %v58 to i64
  %st21 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st21
  %st22 = getelementptr i64, ptr %v60, i64 1
  store i64 %v59, ptr %st22
  %st23 = getelementptr i64, ptr %v60, i64 2
  store i64 %v56, ptr %st23
  %v62.p = getelementptr i64, ptr %v60, i64 0
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v60, i64 1
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v60, i64 2
  %v64 = load i64, ptr %v64.p
  call void @"std/crypto/chacha20poly1305.SealTo"(ptr %v40, i64 %v41, i64 %v42, i64 %v43, i64 %v44, i64 %v45, i64 %v46, i64 %v47, i64 %v48, i64 %v49, i64 %v50, i64 %v51, i64 %v52, i64 %v53, i64 %v54, i64 %v55, i64 %v62, i64 %v63, i64 %v64)
  %v65 = add i64 0, 3
  %v66 = getelementptr i64, ptr %v40, i64 %v65
  %v67 = getelementptr i64, ptr %s10, i64 0
  %v68.p = getelementptr i64, ptr %v40, i64 0
  %v68 = load i64, ptr %v68.p
  %st24 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st24
  %v69.p = getelementptr i64, ptr %v40, i64 1
  %v69 = load i64, ptr %v69.p
  %st25 = getelementptr i64, ptr %v67, i64 1
  store i64 %v69, ptr %st25
  %v70.p = getelementptr i64, ptr %v40, i64 2
  %v70 = load i64, ptr %v70.p
  %st26 = getelementptr i64, ptr %v67, i64 2
  store i64 %v70, ptr %st26
  %v71 = getelementptr i64, ptr @"str.18", i64 0
  %v72 = add i64 0, 260
  %v73 = add i64 0, 0
  %v74 = getelementptr i64, ptr %s7, i64 0
  %v75 = ptrtoint ptr %v71 to i64
  %st27 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st27
  %st28 = getelementptr i64, ptr %v74, i64 1
  store i64 %v72, ptr %st28
  %st29 = getelementptr i64, ptr %v74, i64 2
  store i64 %v73, ptr %st29
  %v76 = getelementptr i64, ptr %s11, i64 0
  %v77.p = getelementptr i64, ptr %v74, i64 0
  %v77 = load i64, ptr %v77.p
  %st30 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st30
  %v78.p = getelementptr i64, ptr %v74, i64 1
  %v78 = load i64, ptr %v78.p
  %st31 = getelementptr i64, ptr %v76, i64 1
  store i64 %v78, ptr %st31
  %v79.p = getelementptr i64, ptr %v74, i64 2
  %v79 = load i64, ptr %v79.p
  %st32 = getelementptr i64, ptr %v76, i64 2
  store i64 %v79, ptr %st32
  %v80 = getelementptr i64, ptr @"str.5", i64 0
  %v81 = add i64 0, 6
  %v82 = add i64 0, 0
  %v83 = getelementptr i64, ptr %s7, i64 0
  %v84 = ptrtoint ptr %v80 to i64
  %st33 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st33
  %st34 = getelementptr i64, ptr %v83, i64 1
  store i64 %v81, ptr %st34
  %st35 = getelementptr i64, ptr %v83, i64 2
  store i64 %v82, ptr %st35
  %v85.p = getelementptr i64, ptr %v83, i64 0
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v83, i64 1
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v83, i64 2
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v67, i64 0
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v67, i64 1
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v67, i64 2
  %v90 = load i64, ptr %v90.p
  %v91 = getelementptr i64, ptr @"str.14", i64 0
  %v92 = add i64 0, 10
  %v93 = add i64 0, 0
  %v94 = getelementptr i64, ptr %s12, i64 0
  %v95 = ptrtoint ptr %v91 to i64
  %st36 = getelementptr i64, ptr %v94, i64 0
  store i64 %v95, ptr %st36
  %st37 = getelementptr i64, ptr %v94, i64 1
  store i64 %v92, ptr %st37
  %st38 = getelementptr i64, ptr %v94, i64 2
  store i64 %v93, ptr %st38
  %v96.p = getelementptr i64, ptr %v94, i64 1
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v76, i64 1
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 %v96, %v97
  %v931 = getelementptr i64, ptr @"rt.meta", i64 0
  %v99.p = getelementptr i64, ptr %v931, i64 0
  %v99 = load i64, ptr %v99.p
  %v100.p = getelementptr i64, ptr %v94, i64 0
  %v100 = load i64, ptr %v100.p
  %v101.p = getelementptr i64, ptr %v94, i64 1
  %v101 = load i64, ptr %v101.p
  %v102.p = getelementptr i64, ptr %v94, i64 2
  %v102 = load i64, ptr %v102.p
  %v103 = call ptr @"rt.cat8"(i64 %v100, i64 %v101, i64 %v102, i64 %v99, i64 %v97)
  %v104 = getelementptr i8, ptr %v103, i64 %v96
  %v105.p = getelementptr i64, ptr %v76, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = inttoptr i64 %v105 to ptr
  call void @"rt.copy8"(ptr %v104, ptr %v106, i64 %v97)
  %v107 = getelementptr i64, ptr %s13, i64 0
  %v108 = ptrtoint ptr %v103 to i64
  %st39 = getelementptr i64, ptr %v107, i64 0
  store i64 %v108, ptr %st39
  %st40 = getelementptr i64, ptr %v107, i64 1
  store i64 %v98, ptr %st40
  %st41 = getelementptr i64, ptr %v107, i64 2
  store i64 %v99, ptr %st41
  %v109.p = getelementptr i64, ptr %v107, i64 0
  %v109 = load i64, ptr %v109.p
  %v110.p = getelementptr i64, ptr %v107, i64 1
  %v110 = load i64, ptr %v110.p
  %v111.p = getelementptr i64, ptr %v107, i64 2
  %v111 = load i64, ptr %v111.p
  call void @"main.check"(i64 %v85, i64 %v86, i64 %v87, i64 %v88, i64 %v89, i64 %v90, i64 %v109, i64 %v110, i64 %v111)
  %v112 = getelementptr i64, ptr %s14, i64 0
  %v113.p = getelementptr i64, ptr %v76, i64 0
  %v113 = load i64, ptr %v113.p
  %v114.p = getelementptr i64, ptr %v76, i64 1
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v76, i64 2
  %v115 = load i64, ptr %v115.p
  call void @"main.unhex"(ptr %v112, i64 %v113, i64 %v114, i64 %v115)
  %v116 = getelementptr i64, ptr %s13, i64 0
  %v117.p = getelementptr i64, ptr %v112, i64 0
  %v117 = load i64, ptr %v117.p
  %st42 = getelementptr i64, ptr %v116, i64 0
  store i64 %v117, ptr %st42
  %v118.p = getelementptr i64, ptr %v112, i64 1
  %v118 = load i64, ptr %v118.p
  %st43 = getelementptr i64, ptr %v116, i64 1
  store i64 %v118, ptr %st43
  %v119.p = getelementptr i64, ptr %v112, i64 2
  %v119 = load i64, ptr %v119.p
  %st44 = getelementptr i64, ptr %v116, i64 2
  store i64 %v119, ptr %st44
  %v120 = getelementptr i64, ptr %s15, i64 0
  %v121.p = getelementptr i64, ptr %v116, i64 0
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v116, i64 1
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v116, i64 2
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 0, 4
  call void @"main.wrap"(ptr %v120, i64 %v121, i64 %v122, i64 %v123, i64 %v124)
  %v125 = getelementptr i64, ptr %s12, i64 0
  %v126.p = getelementptr i64, ptr %v120, i64 0
  %v126 = load i64, ptr %v126.p
  %st45 = getelementptr i64, ptr %v125, i64 0
  store i64 %v126, ptr %st45
  %v127.p = getelementptr i64, ptr %v120, i64 1
  %v127 = load i64, ptr %v127.p
  %st46 = getelementptr i64, ptr %v125, i64 1
  store i64 %v127, ptr %st46
  %v128.p = getelementptr i64, ptr %v120, i64 2
  %v128 = load i64, ptr %v128.p
  %st47 = getelementptr i64, ptr %v125, i64 2
  store i64 %v128, ptr %st47
  %v129 = getelementptr i64, ptr %s16, i64 0
  %v130.p = getelementptr i64, ptr %v23, i64 0
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v23, i64 1
  %v131 = load i64, ptr %v131.p
  %v132.p = getelementptr i64, ptr %v23, i64 2
  %v132 = load i64, ptr %v132.p
  %v133.p = getelementptr i64, ptr %v13, i64 0
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v13, i64 1
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v13, i64 2
  %v135 = load i64, ptr %v135.p
  %v136.p = getelementptr i64, ptr %v14, i64 0
  %v136 = load i64, ptr %v136.p
  %v137.p = getelementptr i64, ptr %v14, i64 1
  %v137 = load i64, ptr %v137.p
  %v138.p = getelementptr i64, ptr %v14, i64 2
  %v138 = load i64, ptr %v138.p
  %v139.p = getelementptr i64, ptr %v125, i64 0
  %v139 = load i64, ptr %v139.p
  %v140.p = getelementptr i64, ptr %v125, i64 1
  %v140 = load i64, ptr %v140.p
  %v141.p = getelementptr i64, ptr %v125, i64 2
  %v141 = load i64, ptr %v141.p
  %v142 = add i64 0, 4
  %v143.p = getelementptr i64, ptr %v116, i64 1
  %v143 = load i64, ptr %v143.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v129, i64 %v130, i64 %v131, i64 %v132, i64 %v133, i64 %v134, i64 %v135, i64 %v136, i64 %v137, i64 %v138, i64 %v139, i64 %v140, i64 %v141, i64 %v142, i64 %v143)
  %v144 = add i64 0, 3
  %v145 = getelementptr i64, ptr %v129, i64 %v144
  %v146 = getelementptr i64, ptr %s7, i64 0
  %v147.p = getelementptr i64, ptr %v129, i64 0
  %v147 = load i64, ptr %v147.p
  %st48 = getelementptr i64, ptr %v146, i64 0
  store i64 %v147, ptr %st48
  %v148.p = getelementptr i64, ptr %v129, i64 1
  %v148 = load i64, ptr %v148.p
  %st49 = getelementptr i64, ptr %v146, i64 1
  store i64 %v148, ptr %st49
  %v149.p = getelementptr i64, ptr %v129, i64 2
  %v149 = load i64, ptr %v149.p
  %st50 = getelementptr i64, ptr %v146, i64 2
  store i64 %v149, ptr %st50
  %v150 = getelementptr i64, ptr %s17, i64 0
  %v151.p = getelementptr i64, ptr %v145, i64 0
  %v151 = load i64, ptr %v151.p
  %st51 = getelementptr i64, ptr %v150, i64 0
  store i64 %v151, ptr %st51
  %v152.p = getelementptr i64, ptr %v145, i64 1
  %v152 = load i64, ptr %v152.p
  %st52 = getelementptr i64, ptr %v150, i64 1
  store i64 %v152, ptr %st52
  %v153.p = getelementptr i64, ptr %v145, i64 2
  %v153 = load i64, ptr %v153.p
  %st53 = getelementptr i64, ptr %v150, i64 2
  store i64 %v153, ptr %st53
  %v154.p = getelementptr i64, ptr %v145, i64 3
  %v154 = load i64, ptr %v154.p
  %st54 = getelementptr i64, ptr %v150, i64 3
  store i64 %v154, ptr %st54
  %v155.p = getelementptr i64, ptr %v145, i64 4
  %v155 = load i64, ptr %v155.p
  %st55 = getelementptr i64, ptr %v150, i64 4
  store i64 %v155, ptr %st55
  %v156 = getelementptr i64, ptr @"str.7", i64 0
  %v157 = add i64 0, 6
  %v158 = add i64 0, 0
  %v159 = getelementptr i64, ptr %s18, i64 0
  %v160 = ptrtoint ptr %v156 to i64
  %st56 = getelementptr i64, ptr %v159, i64 0
  store i64 %v160, ptr %st56
  %st57 = getelementptr i64, ptr %v159, i64 1
  store i64 %v157, ptr %st57
  %st58 = getelementptr i64, ptr %v159, i64 2
  store i64 %v158, ptr %st58
  %v161.p = getelementptr i64, ptr %v150, i64 0
  %v161 = load i64, ptr %v161.p
  %v162 = add i64 0, 0
  %v163.c = icmp eq i64 %v161, %v162
  %v163 = zext i1 %v163.c to i64
  %v164.p = getelementptr i64, ptr %v146, i64 0
  %v164 = load i64, ptr %v164.p
  %v165.p = getelementptr i64, ptr %v146, i64 1
  %v165 = load i64, ptr %v165.p
  %v166.p = getelementptr i64, ptr %v146, i64 2
  %v166 = load i64, ptr %v166.p
  %v167.p = getelementptr i64, ptr %v15, i64 0
  %v167 = load i64, ptr %v167.p
  %v168.p = getelementptr i64, ptr %v15, i64 1
  %v168 = load i64, ptr %v168.p
  %v169.p = getelementptr i64, ptr %v15, i64 2
  %v169 = load i64, ptr %v169.p
  %v170 = call i64 @"std/crypto.Equal"(i64 %v164, i64 %v165, i64 %v166, i64 %v167, i64 %v168, i64 %v169)
  call void @"rt.print_str"(ptr %v159)
  %v171 = add i64 0, 32
  call void @"rt.print_char"(i64 %v171)
  %c.b0 = icmp ne i64 %v163, 0
  br i1 %c.b0, label %b0.t60, label %b0.e61
b0.t60:
  br label %b1
b0.e61:
  br label %b2
b1:
  %v172 = add i64 0, 116
  call void @"rt.print_char"(i64 %v172)
  %v173 = add i64 0, 114
  call void @"rt.print_char"(i64 %v173)
  %v174 = add i64 0, 117
  call void @"rt.print_char"(i64 %v174)
  %v175 = add i64 0, 101
  call void @"rt.print_char"(i64 %v175)
  br label %b3
b2:
  %v176 = add i64 0, 102
  call void @"rt.print_char"(i64 %v176)
  %v177 = add i64 0, 97
  call void @"rt.print_char"(i64 %v177)
  %v178 = add i64 0, 108
  call void @"rt.print_char"(i64 %v178)
  %v179 = add i64 0, 115
  call void @"rt.print_char"(i64 %v179)
  %v180 = add i64 0, 101
  call void @"rt.print_char"(i64 %v180)
  br label %b3
b3:
  %v181 = add i64 0, 32
  call void @"rt.print_char"(i64 %v181)
  %c.b3 = icmp ne i64 %v170, 0
  br i1 %c.b3, label %b3.t62, label %b3.e63
b3.t62:
  br label %b4
b3.e63:
  br label %b5
b4:
  %v182 = add i64 0, 116
  call void @"rt.print_char"(i64 %v182)
  %v183 = add i64 0, 114
  call void @"rt.print_char"(i64 %v183)
  %v184 = add i64 0, 117
  call void @"rt.print_char"(i64 %v184)
  %v185 = add i64 0, 101
  call void @"rt.print_char"(i64 %v185)
  br label %b6
b5:
  %v186 = add i64 0, 102
  call void @"rt.print_char"(i64 %v186)
  %v187 = add i64 0, 97
  call void @"rt.print_char"(i64 %v187)
  %v188 = add i64 0, 108
  call void @"rt.print_char"(i64 %v188)
  %v189 = add i64 0, 115
  call void @"rt.print_char"(i64 %v189)
  %v190 = add i64 0, 101
  call void @"rt.print_char"(i64 %v190)
  br label %b6
b6:
  %v191 = add i64 0, 10
  call void @"rt.print_char"(i64 %v191)
  %v192 = add i64 0, 0
  %v193 = getelementptr i64, ptr %s19, i64 0
  %st63 = getelementptr i64, ptr %v193, i64 0
  store i64 %v192, ptr %st63
  %v932 = getelementptr i64, ptr @"rt.meta", i64 0
  %v194.p = getelementptr i64, ptr %v932, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = add i64 0, 0
  %v196.p = getelementptr i64, ptr %v116, i64 1
  %v196 = load i64, ptr %v196.p
  %v197 = getelementptr i64, ptr %s20, i64 0
  %v933 = getelementptr i64, ptr @"rt.meta", i64 0
  %v198.p = getelementptr i64, ptr %v933, i64 0
  %v198 = load i64, ptr %v198.p
  %v199 = getelementptr i64, ptr %s21, i64 0
  %st64 = getelementptr i64, ptr %v199, i64 0
  store i64 %v195, ptr %st64
  %v934 = getelementptr i64, ptr @"rt.meta", i64 0
  %v200.p = getelementptr i64, ptr %v934, i64 0
  %v200 = load i64, ptr %v200.p
  br label %b9
b7:
  %v935 = getelementptr i64, ptr @"rt.meta", i64 0
  %st65 = getelementptr i64, ptr %v935, i64 0
  store i64 %v194, ptr %st65
  %v253 = getelementptr i64, ptr %s26, i64 0
  %v254.p = getelementptr i64, ptr %v23, i64 0
  %v254 = load i64, ptr %v254.p
  %v255.p = getelementptr i64, ptr %v23, i64 1
  %v255 = load i64, ptr %v255.p
  %v256.p = getelementptr i64, ptr %v23, i64 2
  %v256 = load i64, ptr %v256.p
  %v257.p = getelementptr i64, ptr %v13, i64 0
  %v257 = load i64, ptr %v257.p
  %v258.p = getelementptr i64, ptr %v13, i64 1
  %v258 = load i64, ptr %v258.p
  %v259.p = getelementptr i64, ptr %v13, i64 2
  %v259 = load i64, ptr %v259.p
  %v260.p = getelementptr i64, ptr %v14, i64 0
  %v260 = load i64, ptr %v260.p
  %v261.p = getelementptr i64, ptr %v14, i64 1
  %v261 = load i64, ptr %v261.p
  %v262.p = getelementptr i64, ptr %v14, i64 2
  %v262 = load i64, ptr %v262.p
  %v263 = getelementptr i64, ptr %s27, i64 0
  %v264.p = getelementptr i64, ptr %v125, i64 0
  %v264 = load i64, ptr %v264.p
  %v265.p = getelementptr i64, ptr %v125, i64 1
  %v265 = load i64, ptr %v265.p
  %v266.p = getelementptr i64, ptr %v125, i64 2
  %v266 = load i64, ptr %v266.p
  %v267 = add i64 0, 0
  call void @"main.flip"(ptr %v263, i64 %v264, i64 %v265, i64 %v266, i64 %v267)
  %v268.p = getelementptr i64, ptr %v263, i64 0
  %v268 = load i64, ptr %v268.p
  %v269.p = getelementptr i64, ptr %v263, i64 1
  %v269 = load i64, ptr %v269.p
  %v270.p = getelementptr i64, ptr %v263, i64 2
  %v270 = load i64, ptr %v270.p
  %v271 = add i64 0, 4
  %v272.p = getelementptr i64, ptr %v116, i64 1
  %v272 = load i64, ptr %v272.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v253, i64 %v254, i64 %v255, i64 %v256, i64 %v257, i64 %v258, i64 %v259, i64 %v260, i64 %v261, i64 %v262, i64 %v268, i64 %v269, i64 %v270, i64 %v271, i64 %v272)
  %v273 = add i64 0, 3
  %v274 = getelementptr i64, ptr %v253, i64 %v273
  %v275 = getelementptr i64, ptr %s24, i64 0
  %v276.p = getelementptr i64, ptr %v274, i64 0
  %v276 = load i64, ptr %v276.p
  %st66 = getelementptr i64, ptr %v275, i64 0
  store i64 %v276, ptr %st66
  %v277.p = getelementptr i64, ptr %v274, i64 1
  %v277 = load i64, ptr %v277.p
  %st67 = getelementptr i64, ptr %v275, i64 1
  store i64 %v277, ptr %st67
  %v278.p = getelementptr i64, ptr %v274, i64 2
  %v278 = load i64, ptr %v278.p
  %st68 = getelementptr i64, ptr %v275, i64 2
  store i64 %v278, ptr %st68
  %v279.p = getelementptr i64, ptr %v274, i64 3
  %v279 = load i64, ptr %v279.p
  %st69 = getelementptr i64, ptr %v275, i64 3
  store i64 %v279, ptr %st69
  %v280.p = getelementptr i64, ptr %v274, i64 4
  %v280 = load i64, ptr %v280.p
  %st70 = getelementptr i64, ptr %v275, i64 4
  store i64 %v280, ptr %st70
  %v281 = getelementptr i64, ptr %s28, i64 0
  %v282.p = getelementptr i64, ptr %v23, i64 0
  %v282 = load i64, ptr %v282.p
  %v283.p = getelementptr i64, ptr %v23, i64 1
  %v283 = load i64, ptr %v283.p
  %v284.p = getelementptr i64, ptr %v23, i64 2
  %v284 = load i64, ptr %v284.p
  %v285.p = getelementptr i64, ptr %v13, i64 0
  %v285 = load i64, ptr %v285.p
  %v286.p = getelementptr i64, ptr %v13, i64 1
  %v286 = load i64, ptr %v286.p
  %v287.p = getelementptr i64, ptr %v13, i64 2
  %v287 = load i64, ptr %v287.p
  %v288.p = getelementptr i64, ptr %v14, i64 0
  %v288 = load i64, ptr %v288.p
  %v289.p = getelementptr i64, ptr %v14, i64 1
  %v289 = load i64, ptr %v289.p
  %v290.p = getelementptr i64, ptr %v14, i64 2
  %v290 = load i64, ptr %v290.p
  %v291 = getelementptr i64, ptr %s29, i64 0
  %v292.p = getelementptr i64, ptr %v125, i64 0
  %v292 = load i64, ptr %v292.p
  %v293.p = getelementptr i64, ptr %v125, i64 1
  %v293 = load i64, ptr %v293.p
  %v294.p = getelementptr i64, ptr %v125, i64 2
  %v294 = load i64, ptr %v294.p
  %v295.p = getelementptr i64, ptr %v125, i64 1
  %v295 = load i64, ptr %v295.p
  %v296 = add i64 0, 1
  %v297 = sub i64 %v295, %v296
  call void @"main.flip"(ptr %v291, i64 %v292, i64 %v293, i64 %v294, i64 %v297)
  %v298.p = getelementptr i64, ptr %v291, i64 0
  %v298 = load i64, ptr %v298.p
  %v299.p = getelementptr i64, ptr %v291, i64 1
  %v299 = load i64, ptr %v299.p
  %v300.p = getelementptr i64, ptr %v291, i64 2
  %v300 = load i64, ptr %v300.p
  %v301 = add i64 0, 4
  %v302.p = getelementptr i64, ptr %v116, i64 1
  %v302 = load i64, ptr %v302.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v281, i64 %v282, i64 %v283, i64 %v284, i64 %v285, i64 %v286, i64 %v287, i64 %v288, i64 %v289, i64 %v290, i64 %v298, i64 %v299, i64 %v300, i64 %v301, i64 %v302)
  %v303 = add i64 0, 3
  %v304 = getelementptr i64, ptr %v281, i64 %v303
  %v305 = getelementptr i64, ptr %s30, i64 0
  %v306.p = getelementptr i64, ptr %v304, i64 0
  %v306 = load i64, ptr %v306.p
  %st71 = getelementptr i64, ptr %v305, i64 0
  store i64 %v306, ptr %st71
  %v307.p = getelementptr i64, ptr %v304, i64 1
  %v307 = load i64, ptr %v307.p
  %st72 = getelementptr i64, ptr %v305, i64 1
  store i64 %v307, ptr %st72
  %v308.p = getelementptr i64, ptr %v304, i64 2
  %v308 = load i64, ptr %v308.p
  %st73 = getelementptr i64, ptr %v305, i64 2
  store i64 %v308, ptr %st73
  %v309.p = getelementptr i64, ptr %v304, i64 3
  %v309 = load i64, ptr %v309.p
  %st74 = getelementptr i64, ptr %v305, i64 3
  store i64 %v309, ptr %st74
  %v310.p = getelementptr i64, ptr %v304, i64 4
  %v310 = load i64, ptr %v310.p
  %st75 = getelementptr i64, ptr %v305, i64 4
  store i64 %v310, ptr %st75
  %v311 = getelementptr i64, ptr @"str.34", i64 0
  %v312 = add i64 0, 13
  %v313 = add i64 0, 0
  %v314 = getelementptr i64, ptr %s18, i64 0
  %v315 = ptrtoint ptr %v311 to i64
  %st76 = getelementptr i64, ptr %v314, i64 0
  store i64 %v315, ptr %st76
  %st77 = getelementptr i64, ptr %v314, i64 1
  store i64 %v312, ptr %st77
  %st78 = getelementptr i64, ptr %v314, i64 2
  store i64 %v313, ptr %st78
  %v316.p = getelementptr i64, ptr %v116, i64 1
  %v316 = load i64, ptr %v316.p
  %v317.p = getelementptr i64, ptr %v193, i64 0
  %v317 = load i64, ptr %v317.p
  %v318.p = getelementptr i64, ptr %v275, i64 0
  %v318 = load i64, ptr %v318.p
  %v319 = add i64 0, 0
  %v320.c = icmp eq i64 %v318, %v319
  %v320 = zext i1 %v320.c to i64
  %v321.p = getelementptr i64, ptr %v305, i64 0
  %v321 = load i64, ptr %v321.p
  %v322 = add i64 0, 0
  %v323.c = icmp eq i64 %v321, %v322
  %v323 = zext i1 %v323.c to i64
  call void @"rt.print_str"(ptr %v314)
  %v324 = add i64 0, 32
  call void @"rt.print_char"(i64 %v324)
  call void @"rt.print_int"(i64 %v316)
  %v325 = add i64 0, 32
  call void @"rt.print_char"(i64 %v325)
  call void @"rt.print_int"(i64 %v317)
  %v326 = add i64 0, 32
  call void @"rt.print_char"(i64 %v326)
  %c.b7 = icmp ne i64 %v320, 0
  br i1 %c.b7, label %b7.t80, label %b7.e81
b7.t80:
  br label %b16
b7.e81:
  br label %b17
b8:
  br label %b7
b9:
  %v936 = getelementptr i64, ptr @"rt.meta", i64 0
  %st81 = getelementptr i64, ptr %v936, i64 0
  store i64 %v200, ptr %st81
  %v201.p = getelementptr i64, ptr %v199, i64 0
  %v201 = load i64, ptr %v201.p
  %v202.c = icmp slt i64 %v201, %v196
  %v202 = zext i1 %v202.c to i64
  %c.b9 = icmp ne i64 %v202, 0
  br i1 %c.b9, label %b9.t83, label %b9.e84
b9.t83:
  br label %b10
b9.e84:
  br label %b11
b10:
  call void @"rt.region_enter"()
  %v937 = getelementptr i64, ptr @"rt.meta", i64 0
  %v203.p = getelementptr i64, ptr %v937, i64 0
  %v203 = load i64, ptr %v203.p
  %v204.p = getelementptr i64, ptr %v199, i64 0
  %v204 = load i64, ptr %v204.p
  %v938 = getelementptr i64, ptr @"rt.meta", i64 0
  %v205.p = getelementptr i64, ptr %v938, i64 0
  %v205 = load i64, ptr %v205.p
  %v206 = getelementptr i64, ptr %s22, i64 0
  %v207.p = getelementptr i64, ptr %v23, i64 0
  %v207 = load i64, ptr %v207.p
  %v208.p = getelementptr i64, ptr %v23, i64 1
  %v208 = load i64, ptr %v208.p
  %v209.p = getelementptr i64, ptr %v23, i64 2
  %v209 = load i64, ptr %v209.p
  %v210.p = getelementptr i64, ptr %v13, i64 0
  %v210 = load i64, ptr %v210.p
  %v211.p = getelementptr i64, ptr %v13, i64 1
  %v211 = load i64, ptr %v211.p
  %v212.p = getelementptr i64, ptr %v13, i64 2
  %v212 = load i64, ptr %v212.p
  %v213.p = getelementptr i64, ptr %v14, i64 0
  %v213 = load i64, ptr %v213.p
  %v214.p = getelementptr i64, ptr %v14, i64 1
  %v214 = load i64, ptr %v214.p
  %v215.p = getelementptr i64, ptr %v14, i64 2
  %v215 = load i64, ptr %v215.p
  %v216 = getelementptr i64, ptr %s23, i64 0
  %v217.p = getelementptr i64, ptr %v125, i64 0
  %v217 = load i64, ptr %v217.p
  %v218.p = getelementptr i64, ptr %v125, i64 1
  %v218 = load i64, ptr %v218.p
  %v219.p = getelementptr i64, ptr %v125, i64 2
  %v219 = load i64, ptr %v219.p
  %v220 = add i64 0, 4
  %v221 = add i64 %v220, %v204
  call void @"main.flip"(ptr %v216, i64 %v217, i64 %v218, i64 %v219, i64 %v221)
  %v222.p = getelementptr i64, ptr %v216, i64 0
  %v222 = load i64, ptr %v222.p
  %v223.p = getelementptr i64, ptr %v216, i64 1
  %v223 = load i64, ptr %v223.p
  %v224.p = getelementptr i64, ptr %v216, i64 2
  %v224 = load i64, ptr %v224.p
  %v225 = add i64 0, 4
  %v226.p = getelementptr i64, ptr %v116, i64 1
  %v226 = load i64, ptr %v226.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v206, i64 %v207, i64 %v208, i64 %v209, i64 %v210, i64 %v211, i64 %v212, i64 %v213, i64 %v214, i64 %v215, i64 %v222, i64 %v223, i64 %v224, i64 %v225, i64 %v226)
  %v227 = add i64 0, 3
  %v228 = getelementptr i64, ptr %v206, i64 %v227
  %v229 = getelementptr i64, ptr %s24, i64 0
  %v230.p = getelementptr i64, ptr %v228, i64 0
  %v230 = load i64, ptr %v230.p
  %st84 = getelementptr i64, ptr %v229, i64 0
  store i64 %v230, ptr %st84
  %v231.p = getelementptr i64, ptr %v228, i64 1
  %v231 = load i64, ptr %v231.p
  %st85 = getelementptr i64, ptr %v229, i64 1
  store i64 %v231, ptr %st85
  %v232.p = getelementptr i64, ptr %v228, i64 2
  %v232 = load i64, ptr %v232.p
  %st86 = getelementptr i64, ptr %v229, i64 2
  store i64 %v232, ptr %st86
  %v233.p = getelementptr i64, ptr %v228, i64 3
  %v233 = load i64, ptr %v233.p
  %st87 = getelementptr i64, ptr %v229, i64 3
  store i64 %v233, ptr %st87
  %v234.p = getelementptr i64, ptr %v228, i64 4
  %v234 = load i64, ptr %v234.p
  %st88 = getelementptr i64, ptr %v229, i64 4
  store i64 %v234, ptr %st88
  %v235.p = getelementptr i64, ptr %v229, i64 0
  %v235 = load i64, ptr %v235.p
  %v236 = add i64 0, 0
  %v237.c = icmp ne i64 %v235, %v236
  %v237 = zext i1 %v237.c to i64
  %c.b10 = icmp ne i64 %v237, 0
  br i1 %c.b10, label %b10.t90, label %b10.e91
b10.t90:
  br label %b13
b10.e91:
  br label %b14
b11:
  %v939 = getelementptr i64, ptr @"rt.meta", i64 0
  %st91 = getelementptr i64, ptr %v939, i64 0
  store i64 %v200, ptr %st91
  br label %b8
b12:
  %v940 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v940, i64 0
  store i64 %v205, ptr %st92
  %v250 = add i64 0, 1
  %v251.p = getelementptr i64, ptr %v199, i64 0
  %v251 = load i64, ptr %v251.p
  %v252 = add i64 %v251, %v250
  %st93 = getelementptr i64, ptr %v199, i64 0
  store i64 %v252, ptr %st93
  br label %b9
b13:
  %v238 = add i64 0, 1
  %v239 = getelementptr i64, ptr %v229, i64 %v238
  %v240 = getelementptr i64, ptr %s25, i64 0
  %v241.p = getelementptr i64, ptr %v239, i64 0
  %v241 = load i64, ptr %v241.p
  %st94 = getelementptr i64, ptr %v240, i64 0
  store i64 %v241, ptr %st94
  %v242.p = getelementptr i64, ptr %v239, i64 1
  %v242 = load i64, ptr %v242.p
  %st95 = getelementptr i64, ptr %v240, i64 1
  store i64 %v242, ptr %st95
  %v243.p = getelementptr i64, ptr %v239, i64 2
  %v243 = load i64, ptr %v243.p
  %st96 = getelementptr i64, ptr %v240, i64 2
  store i64 %v243, ptr %st96
  %v244.p = getelementptr i64, ptr %v239, i64 3
  %v244 = load i64, ptr %v244.p
  %st97 = getelementptr i64, ptr %v240, i64 3
  store i64 %v244, ptr %st97
  %v245 = add i64 0, 1
  %v246 = add i64 %v16, %v245
  %v247.p = getelementptr i64, ptr %v193, i64 0
  %v247 = load i64, ptr %v247.p
  %v248 = add i64 0, 1
  %v249 = add i64 %v247, %v248
  %st98 = getelementptr i64, ptr %v193, i64 0
  store i64 %v249, ptr %st98
  br label %b15
b14:
  br label %b15
b15:
  br label %b12
b16:
  %v327 = add i64 0, 116
  call void @"rt.print_char"(i64 %v327)
  %v328 = add i64 0, 114
  call void @"rt.print_char"(i64 %v328)
  %v329 = add i64 0, 117
  call void @"rt.print_char"(i64 %v329)
  %v330 = add i64 0, 101
  call void @"rt.print_char"(i64 %v330)
  br label %b18
b17:
  %v331 = add i64 0, 102
  call void @"rt.print_char"(i64 %v331)
  %v332 = add i64 0, 97
  call void @"rt.print_char"(i64 %v332)
  %v333 = add i64 0, 108
  call void @"rt.print_char"(i64 %v333)
  %v334 = add i64 0, 115
  call void @"rt.print_char"(i64 %v334)
  %v335 = add i64 0, 101
  call void @"rt.print_char"(i64 %v335)
  br label %b18
b18:
  %v336 = add i64 0, 32
  call void @"rt.print_char"(i64 %v336)
  %c.b18 = icmp ne i64 %v323, 0
  br i1 %c.b18, label %b18.t100, label %b18.e101
b18.t100:
  br label %b19
b18.e101:
  br label %b20
b19:
  %v337 = add i64 0, 116
  call void @"rt.print_char"(i64 %v337)
  %v338 = add i64 0, 114
  call void @"rt.print_char"(i64 %v338)
  %v339 = add i64 0, 117
  call void @"rt.print_char"(i64 %v339)
  %v340 = add i64 0, 101
  call void @"rt.print_char"(i64 %v340)
  br label %b21
b20:
  %v341 = add i64 0, 102
  call void @"rt.print_char"(i64 %v341)
  %v342 = add i64 0, 97
  call void @"rt.print_char"(i64 %v342)
  %v343 = add i64 0, 108
  call void @"rt.print_char"(i64 %v343)
  %v344 = add i64 0, 115
  call void @"rt.print_char"(i64 %v344)
  %v345 = add i64 0, 101
  call void @"rt.print_char"(i64 %v345)
  br label %b21
b21:
  %v346 = add i64 0, 10
  call void @"rt.print_char"(i64 %v346)
  %v347 = add i64 0, 0
  %v348 = getelementptr i64, ptr %s21, i64 0
  %st101 = getelementptr i64, ptr %v348, i64 0
  store i64 %v347, ptr %st101
  %v349 = add i64 0, 0
  %v350 = getelementptr i64, ptr %s20, i64 0
  %st102 = getelementptr i64, ptr %v350, i64 0
  store i64 %v349, ptr %st102
  %v941 = getelementptr i64, ptr @"rt.meta", i64 0
  %v351.p = getelementptr i64, ptr %v941, i64 0
  %v351 = load i64, ptr %v351.p
  %v352 = add i64 0, 0
  %v353 = add i64 0, 131
  %v354 = getelementptr i64, ptr %s31, i64 0
  %v942 = getelementptr i64, ptr @"rt.meta", i64 0
  %v355.p = getelementptr i64, ptr %v942, i64 0
  %v355 = load i64, ptr %v355.p
  %v356 = getelementptr i64, ptr %s32, i64 0
  %st103 = getelementptr i64, ptr %v356, i64 0
  store i64 %v352, ptr %st103
  %v943 = getelementptr i64, ptr @"rt.meta", i64 0
  %v357.p = getelementptr i64, ptr %v943, i64 0
  %v357 = load i64, ptr %v357.p
  br label %b24
b22:
  %v944 = getelementptr i64, ptr @"rt.meta", i64 0
  %st104 = getelementptr i64, ptr %v944, i64 0
  store i64 %v351, ptr %st104
  %v522 = getelementptr i64, ptr @"str.4", i64 0
  %v523 = add i64 0, 6
  %v524 = add i64 0, 0
  %v525 = getelementptr i64, ptr %s43, i64 0
  %v526 = ptrtoint ptr %v522 to i64
  %st105 = getelementptr i64, ptr %v525, i64 0
  store i64 %v526, ptr %st105
  %st106 = getelementptr i64, ptr %v525, i64 1
  store i64 %v523, ptr %st106
  %st107 = getelementptr i64, ptr %v525, i64 2
  store i64 %v524, ptr %st107
  %v527.p = getelementptr i64, ptr %v348, i64 0
  %v527 = load i64, ptr %v527.p
  %v528.p = getelementptr i64, ptr %v350, i64 0
  %v528 = load i64, ptr %v528.p
  call void @"rt.print_str"(ptr %v525)
  %v529 = add i64 0, 32
  call void @"rt.print_char"(i64 %v529)
  call void @"rt.print_int"(i64 %v527)
  %v530 = add i64 0, 32
  call void @"rt.print_char"(i64 %v530)
  call void @"rt.print_int"(i64 %v528)
  %v531 = add i64 0, 10
  call void @"rt.print_char"(i64 %v531)
  %v532 = add i64 0, 0
  %v533 = getelementptr i64, ptr %s32, i64 0
  %st108 = getelementptr i64, ptr %v533, i64 0
  store i64 %v532, ptr %st108
  %v534 = add i64 0, 0
  %v535 = getelementptr i64, ptr %s31, i64 0
  %st109 = getelementptr i64, ptr %v535, i64 0
  store i64 %v534, ptr %st109
  %v945 = getelementptr i64, ptr @"rt.meta", i64 0
  %v536.p = getelementptr i64, ptr %v945, i64 0
  %v536 = load i64, ptr %v536.p
  %v537 = add i64 0, 0
  %v538 = add i64 0, 140
  %v539 = getelementptr i64, ptr %s47, i64 0
  %v946 = getelementptr i64, ptr @"rt.meta", i64 0
  %v540.p = getelementptr i64, ptr %v946, i64 0
  %v540 = load i64, ptr %v540.p
  %v541 = getelementptr i64, ptr %s48, i64 0
  %st110 = getelementptr i64, ptr %v541, i64 0
  store i64 %v537, ptr %st110
  %v947 = getelementptr i64, ptr @"rt.meta", i64 0
  %v542.p = getelementptr i64, ptr %v947, i64 0
  %v542 = load i64, ptr %v542.p
  br label %b40
b23:
  br label %b22
b24:
  %v948 = getelementptr i64, ptr @"rt.meta", i64 0
  %st111 = getelementptr i64, ptr %v948, i64 0
  store i64 %v357, ptr %st111
  %v358.p = getelementptr i64, ptr %v356, i64 0
  %v358 = load i64, ptr %v358.p
  %v359.c = icmp slt i64 %v358, %v353
  %v359 = zext i1 %v359.c to i64
  %c.b24 = icmp ne i64 %v359, 0
  br i1 %c.b24, label %b24.t113, label %b24.e114
b24.t113:
  br label %b25
b24.e114:
  br label %b26
b25:
  call void @"rt.region_enter"()
  %v949 = getelementptr i64, ptr @"rt.meta", i64 0
  %v360.p = getelementptr i64, ptr %v949, i64 0
  %v360 = load i64, ptr %v360.p
  %v361.p = getelementptr i64, ptr %v356, i64 0
  %v361 = load i64, ptr %v361.p
  %v950 = getelementptr i64, ptr @"rt.meta", i64 0
  %v362.p = getelementptr i64, ptr %v950, i64 0
  %v362 = load i64, ptr %v362.p
  %v363 = getelementptr i64, ptr %s33, i64 0
  %v364 = add i64 0, 0
  %v365 = add i64 0, 1
  %v366 = sub i64 %v361, %v365
  call void @"main.seq"(ptr %v363, i64 %v364, i64 %v366)
  %v367 = getelementptr i64, ptr %s18, i64 0
  %v368.p = getelementptr i64, ptr %v363, i64 0
  %v368 = load i64, ptr %v368.p
  %st114 = getelementptr i64, ptr %v367, i64 0
  store i64 %v368, ptr %st114
  %v369.p = getelementptr i64, ptr %v363, i64 1
  %v369 = load i64, ptr %v369.p
  %st115 = getelementptr i64, ptr %v367, i64 1
  store i64 %v369, ptr %st115
  %v370.p = getelementptr i64, ptr %v363, i64 2
  %v370 = load i64, ptr %v370.p
  %st116 = getelementptr i64, ptr %v367, i64 2
  store i64 %v370, ptr %st116
  %v371 = getelementptr i64, ptr %s34, i64 0
  %v372 = add i64 0, 200
  %v373 = add i64 0, 200
  %v374 = add i64 0, 5
  %v375 = srem i64 %v361, %v374
  %v376 = add i64 %v373, %v375
  %v377 = add i64 0, 1
  %v378 = sub i64 %v376, %v377
  call void @"main.seq"(ptr %v371, i64 %v372, i64 %v378)
  %v379 = getelementptr i64, ptr %s35, i64 0
  %v380.p = getelementptr i64, ptr %v371, i64 0
  %v380 = load i64, ptr %v380.p
  %st117 = getelementptr i64, ptr %v379, i64 0
  store i64 %v380, ptr %st117
  %v381.p = getelementptr i64, ptr %v371, i64 1
  %v381 = load i64, ptr %v381.p
  %st118 = getelementptr i64, ptr %v379, i64 1
  store i64 %v381, ptr %st118
  %v382.p = getelementptr i64, ptr %v371, i64 2
  %v382 = load i64, ptr %v382.p
  %st119 = getelementptr i64, ptr %v379, i64 2
  store i64 %v382, ptr %st119
  %v383 = getelementptr i64, ptr %s36, i64 0
  %v384.p = getelementptr i64, ptr %v23, i64 0
  %v384 = load i64, ptr %v384.p
  %v385.p = getelementptr i64, ptr %v23, i64 1
  %v385 = load i64, ptr %v385.p
  %v386.p = getelementptr i64, ptr %v23, i64 2
  %v386 = load i64, ptr %v386.p
  %v387.p = getelementptr i64, ptr %v13, i64 0
  %v387 = load i64, ptr %v387.p
  %v388.p = getelementptr i64, ptr %v13, i64 1
  %v388 = load i64, ptr %v388.p
  %v389.p = getelementptr i64, ptr %v13, i64 2
  %v389 = load i64, ptr %v389.p
  %v390.p = getelementptr i64, ptr %v14, i64 0
  %v390 = load i64, ptr %v390.p
  %v391.p = getelementptr i64, ptr %v14, i64 1
  %v391 = load i64, ptr %v391.p
  %v392.p = getelementptr i64, ptr %v14, i64 2
  %v392 = load i64, ptr %v392.p
  %v393.p = getelementptr i64, ptr %v367, i64 0
  %v393 = load i64, ptr %v393.p
  %v394.p = getelementptr i64, ptr %v367, i64 1
  %v394 = load i64, ptr %v394.p
  %v395.p = getelementptr i64, ptr %v367, i64 2
  %v395 = load i64, ptr %v395.p
  %v396.p = getelementptr i64, ptr %v379, i64 0
  %v396 = load i64, ptr %v396.p
  %v397.p = getelementptr i64, ptr %v379, i64 1
  %v397 = load i64, ptr %v397.p
  %v398.p = getelementptr i64, ptr %v379, i64 2
  %v398 = load i64, ptr %v398.p
  %v951 = getelementptr i64, ptr @"rt.meta", i64 0
  %v399.p = getelementptr i64, ptr %v951, i64 0
  %v399 = load i64, ptr %v399.p
  %v400 = add i64 0, 0
  %v401 = call ptr @"rt.region_alloc8"(i64 %v399, i64 %v400)
  %v402 = add i64 0, 0
  %v403 = getelementptr i64, ptr %s37, i64 0
  %v404 = ptrtoint ptr %v401 to i64
  %st120 = getelementptr i64, ptr %v403, i64 0
  store i64 %v404, ptr %st120
  %st121 = getelementptr i64, ptr %v403, i64 1
  store i64 %v402, ptr %st121
  %st122 = getelementptr i64, ptr %v403, i64 2
  store i64 %v399, ptr %st122
  %v405.p = getelementptr i64, ptr %v403, i64 0
  %v405 = load i64, ptr %v405.p
  %v406.p = getelementptr i64, ptr %v403, i64 1
  %v406 = load i64, ptr %v406.p
  %v407.p = getelementptr i64, ptr %v403, i64 2
  %v407 = load i64, ptr %v407.p
  call void @"std/crypto/chacha20poly1305.SealTo"(ptr %v383, i64 %v384, i64 %v385, i64 %v386, i64 %v387, i64 %v388, i64 %v389, i64 %v390, i64 %v391, i64 %v392, i64 %v393, i64 %v394, i64 %v395, i64 %v396, i64 %v397, i64 %v398, i64 %v405, i64 %v406, i64 %v407)
  %v408 = add i64 0, 3
  %v409 = getelementptr i64, ptr %v383, i64 %v408
  %v410 = getelementptr i64, ptr %s38, i64 0
  %v411.p = getelementptr i64, ptr %v383, i64 0
  %v411 = load i64, ptr %v411.p
  %st123 = getelementptr i64, ptr %v410, i64 0
  store i64 %v411, ptr %st123
  %v412.p = getelementptr i64, ptr %v383, i64 1
  %v412 = load i64, ptr %v412.p
  %st124 = getelementptr i64, ptr %v410, i64 1
  store i64 %v412, ptr %st124
  %v413.p = getelementptr i64, ptr %v383, i64 2
  %v413 = load i64, ptr %v413.p
  %st125 = getelementptr i64, ptr %v410, i64 2
  store i64 %v413, ptr %st125
  %v414 = getelementptr i64, ptr %s39, i64 0
  %v415.p = getelementptr i64, ptr %v12, i64 0
  %v415 = load i64, ptr %v415.p
  %v416.p = getelementptr i64, ptr %v12, i64 1
  %v416 = load i64, ptr %v416.p
  %v417.p = getelementptr i64, ptr %v12, i64 2
  %v417 = load i64, ptr %v417.p
  %v418.p = getelementptr i64, ptr %v13, i64 0
  %v418 = load i64, ptr %v418.p
  %v419.p = getelementptr i64, ptr %v13, i64 1
  %v419 = load i64, ptr %v419.p
  %v420.p = getelementptr i64, ptr %v13, i64 2
  %v420 = load i64, ptr %v420.p
  %v421.p = getelementptr i64, ptr %v14, i64 0
  %v421 = load i64, ptr %v421.p
  %v422.p = getelementptr i64, ptr %v14, i64 1
  %v422 = load i64, ptr %v422.p
  %v423.p = getelementptr i64, ptr %v14, i64 2
  %v423 = load i64, ptr %v423.p
  %v424.p = getelementptr i64, ptr %v367, i64 0
  %v424 = load i64, ptr %v424.p
  %v425.p = getelementptr i64, ptr %v367, i64 1
  %v425 = load i64, ptr %v425.p
  %v426.p = getelementptr i64, ptr %v367, i64 2
  %v426 = load i64, ptr %v426.p
  call void @"std/crypto/chacha20poly1305.Seal"(ptr %v414, i64 %v415, i64 %v416, i64 %v417, i64 %v418, i64 %v419, i64 %v420, i64 %v421, i64 %v422, i64 %v423, i64 %v424, i64 %v425, i64 %v426)
  %v427 = add i64 0, 3
  %v428 = getelementptr i64, ptr %v414, i64 %v427
  %v429 = getelementptr i64, ptr %s37, i64 0
  %v430.p = getelementptr i64, ptr %v414, i64 0
  %v430 = load i64, ptr %v430.p
  %st126 = getelementptr i64, ptr %v429, i64 0
  store i64 %v430, ptr %st126
  %v431.p = getelementptr i64, ptr %v414, i64 1
  %v431 = load i64, ptr %v431.p
  %st127 = getelementptr i64, ptr %v429, i64 1
  store i64 %v431, ptr %st127
  %v432.p = getelementptr i64, ptr %v414, i64 2
  %v432 = load i64, ptr %v432.p
  %st128 = getelementptr i64, ptr %v429, i64 2
  store i64 %v432, ptr %st128
  %v433 = getelementptr i64, ptr %s40, i64 0
  %v434.p = getelementptr i64, ptr %v410, i64 0
  %v434 = load i64, ptr %v434.p
  %v435.p = getelementptr i64, ptr %v410, i64 1
  %v435 = load i64, ptr %v435.p
  %v436.p = getelementptr i64, ptr %v410, i64 2
  %v436 = load i64, ptr %v436.p
  call void @"std/hex.Format"(ptr %v433, i64 %v434, i64 %v435, i64 %v436)
  %v437 = getelementptr i64, ptr %s41, i64 0
  %v438.p = getelementptr i64, ptr %v379, i64 0
  %v438 = load i64, ptr %v438.p
  %v439.p = getelementptr i64, ptr %v379, i64 1
  %v439 = load i64, ptr %v439.p
  %v440.p = getelementptr i64, ptr %v379, i64 2
  %v440 = load i64, ptr %v440.p
  call void @"std/hex.Format"(ptr %v437, i64 %v438, i64 %v439, i64 %v440)
  %v441 = getelementptr i64, ptr %s42, i64 0
  %v442.p = getelementptr i64, ptr %v429, i64 0
  %v442 = load i64, ptr %v442.p
  %v443.p = getelementptr i64, ptr %v429, i64 1
  %v443 = load i64, ptr %v443.p
  %v444.p = getelementptr i64, ptr %v429, i64 2
  %v444 = load i64, ptr %v444.p
  call void @"std/hex.Format"(ptr %v441, i64 %v442, i64 %v443, i64 %v444)
  %v445.p = getelementptr i64, ptr %v437, i64 1
  %v445 = load i64, ptr %v445.p
  %v446.p = getelementptr i64, ptr %v441, i64 1
  %v446 = load i64, ptr %v446.p
  %v447 = add i64 %v445, %v446
  %v952 = getelementptr i64, ptr @"rt.meta", i64 0
  %v448.p = getelementptr i64, ptr %v952, i64 0
  %v448 = load i64, ptr %v448.p
  %v449.p = getelementptr i64, ptr %v437, i64 0
  %v449 = load i64, ptr %v449.p
  %v450.p = getelementptr i64, ptr %v437, i64 1
  %v450 = load i64, ptr %v450.p
  %v451.p = getelementptr i64, ptr %v437, i64 2
  %v451 = load i64, ptr %v451.p
  %v452 = call ptr @"rt.cat8"(i64 %v449, i64 %v450, i64 %v451, i64 %v448, i64 %v446)
  %v453 = getelementptr i8, ptr %v452, i64 %v445
  %v454.p = getelementptr i64, ptr %v441, i64 0
  %v454 = load i64, ptr %v454.p
  %v455 = inttoptr i64 %v454 to ptr
  call void @"rt.copy8"(ptr %v453, ptr %v455, i64 %v446)
  %v456 = getelementptr i64, ptr %s43, i64 0
  %v457 = ptrtoint ptr %v452 to i64
  %st129 = getelementptr i64, ptr %v456, i64 0
  store i64 %v457, ptr %st129
  %st130 = getelementptr i64, ptr %v456, i64 1
  store i64 %v447, ptr %st130
  %st131 = getelementptr i64, ptr %v456, i64 2
  store i64 %v448, ptr %st131
  %v459.p = getelementptr i64, ptr %v433, i64 1
  %v459 = load i64, ptr %v459.p
  %v460.p = getelementptr i64, ptr %v456, i64 1
  %v460 = load i64, ptr %v460.p
  %v461.c = icmp ne i64 %v459, %v460
  %v461 = zext i1 %v461.c to i64
  %v462 = add i64 0, 0
  %c.b25 = icmp ne i64 %v461, 0
  br i1 %c.b25, label %b25.t133, label %b25.e134
b25.t133:
  br label %b28
b25.e134:
  br label %b29
b26:
  %v953 = getelementptr i64, ptr @"rt.meta", i64 0
  %st134 = getelementptr i64, ptr %v953, i64 0
  store i64 %v357, ptr %st134
  br label %b23
b27:
  %v954 = getelementptr i64, ptr @"rt.meta", i64 0
  %st135 = getelementptr i64, ptr %v954, i64 0
  store i64 %v362, ptr %st135
  %v519 = add i64 0, 1
  %v520.p = getelementptr i64, ptr %v356, i64 0
  %v520 = load i64, ptr %v520.p
  %v521 = add i64 %v520, %v519
  %st136 = getelementptr i64, ptr %v356, i64 0
  store i64 %v521, ptr %st136
  br label %b24
b28:
  %v458 = phi i64 [ %v462, %b25.t133 ], [ %v463, %b29 ]
  %c.b28 = icmp ne i64 %v458, 0
  br i1 %c.b28, label %b28.t138, label %b28.e139
b28.t138:
  br label %b30
b28.e139:
  br label %b31
b29:
  %v463 = call i64 @"rt.str_eq"(ptr %v433, ptr %v456)
  br label %b28
b30:
  %v464 = add i64 0, 1
  %v465 = add i64 %v16, %v464
  %v466.p = getelementptr i64, ptr %v348, i64 0
  %v466 = load i64, ptr %v466.p
  %v467 = add i64 0, 1
  %v468 = add i64 %v466, %v467
  %st139 = getelementptr i64, ptr %v348, i64 0
  store i64 %v468, ptr %st139
  br label %b32
b31:
  br label %b32
b32:
  %v469 = getelementptr i64, ptr %s44, i64 0
  %v470.p = getelementptr i64, ptr %v23, i64 0
  %v470 = load i64, ptr %v470.p
  %v471.p = getelementptr i64, ptr %v23, i64 1
  %v471 = load i64, ptr %v471.p
  %v472.p = getelementptr i64, ptr %v23, i64 2
  %v472 = load i64, ptr %v472.p
  %v473.p = getelementptr i64, ptr %v13, i64 0
  %v473 = load i64, ptr %v473.p
  %v474.p = getelementptr i64, ptr %v13, i64 1
  %v474 = load i64, ptr %v474.p
  %v475.p = getelementptr i64, ptr %v13, i64 2
  %v475 = load i64, ptr %v475.p
  %v476.p = getelementptr i64, ptr %v14, i64 0
  %v476 = load i64, ptr %v476.p
  %v477.p = getelementptr i64, ptr %v14, i64 1
  %v477 = load i64, ptr %v477.p
  %v478.p = getelementptr i64, ptr %v14, i64 2
  %v478 = load i64, ptr %v478.p
  %v479 = getelementptr i64, ptr %s45, i64 0
  %v480.p = getelementptr i64, ptr %v429, i64 0
  %v480 = load i64, ptr %v480.p
  %v481.p = getelementptr i64, ptr %v429, i64 1
  %v481 = load i64, ptr %v481.p
  %v482.p = getelementptr i64, ptr %v429, i64 2
  %v482 = load i64, ptr %v482.p
  %v483 = add i64 0, 3
  %v484 = srem i64 %v361, %v483
  call void @"main.wrap"(ptr %v479, i64 %v480, i64 %v481, i64 %v482, i64 %v484)
  %v485.p = getelementptr i64, ptr %v479, i64 0
  %v485 = load i64, ptr %v485.p
  %v486.p = getelementptr i64, ptr %v479, i64 1
  %v486 = load i64, ptr %v486.p
  %v487.p = getelementptr i64, ptr %v479, i64 2
  %v487 = load i64, ptr %v487.p
  %v488 = add i64 0, 3
  %v489 = srem i64 %v361, %v488
  %v490.p = getelementptr i64, ptr %v429, i64 1
  %v490 = load i64, ptr %v490.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v469, i64 %v470, i64 %v471, i64 %v472, i64 %v473, i64 %v474, i64 %v475, i64 %v476, i64 %v477, i64 %v478, i64 %v485, i64 %v486, i64 %v487, i64 %v489, i64 %v490)
  %v491 = add i64 0, 3
  %v492 = getelementptr i64, ptr %v469, i64 %v491
  %v493 = getelementptr i64, ptr %s43, i64 0
  %v494.p = getelementptr i64, ptr %v469, i64 0
  %v494 = load i64, ptr %v494.p
  %st140 = getelementptr i64, ptr %v493, i64 0
  store i64 %v494, ptr %st140
  %v495.p = getelementptr i64, ptr %v469, i64 1
  %v495 = load i64, ptr %v495.p
  %st141 = getelementptr i64, ptr %v493, i64 1
  store i64 %v495, ptr %st141
  %v496.p = getelementptr i64, ptr %v469, i64 2
  %v496 = load i64, ptr %v496.p
  %st142 = getelementptr i64, ptr %v493, i64 2
  store i64 %v496, ptr %st142
  %v497 = getelementptr i64, ptr %s46, i64 0
  %v498.p = getelementptr i64, ptr %v492, i64 0
  %v498 = load i64, ptr %v498.p
  %st143 = getelementptr i64, ptr %v497, i64 0
  store i64 %v498, ptr %st143
  %v499.p = getelementptr i64, ptr %v492, i64 1
  %v499 = load i64, ptr %v499.p
  %st144 = getelementptr i64, ptr %v497, i64 1
  store i64 %v499, ptr %st144
  %v500.p = getelementptr i64, ptr %v492, i64 2
  %v500 = load i64, ptr %v500.p
  %st145 = getelementptr i64, ptr %v497, i64 2
  store i64 %v500, ptr %st145
  %v501.p = getelementptr i64, ptr %v492, i64 3
  %v501 = load i64, ptr %v501.p
  %st146 = getelementptr i64, ptr %v497, i64 3
  store i64 %v501, ptr %st146
  %v502.p = getelementptr i64, ptr %v492, i64 4
  %v502 = load i64, ptr %v502.p
  %st147 = getelementptr i64, ptr %v497, i64 4
  store i64 %v502, ptr %st147
  %v503.p = getelementptr i64, ptr %v497, i64 0
  %v503 = load i64, ptr %v503.p
  %v504 = add i64 0, 0
  %v505.c = icmp eq i64 %v503, %v504
  %v505 = zext i1 %v505.c to i64
  %c.b32 = icmp ne i64 %v505, 0
  br i1 %c.b32, label %b32.t149, label %b32.e150
b32.t149:
  br label %b33
b32.e150:
  br label %b34
b33:
  %v507.p = getelementptr i64, ptr %v493, i64 0
  %v507 = load i64, ptr %v507.p
  %v508.p = getelementptr i64, ptr %v493, i64 1
  %v508 = load i64, ptr %v508.p
  %v509.p = getelementptr i64, ptr %v493, i64 2
  %v509 = load i64, ptr %v509.p
  %v510.p = getelementptr i64, ptr %v367, i64 0
  %v510 = load i64, ptr %v510.p
  %v511.p = getelementptr i64, ptr %v367, i64 1
  %v511 = load i64, ptr %v511.p
  %v512.p = getelementptr i64, ptr %v367, i64 2
  %v512 = load i64, ptr %v512.p
  %v513 = call i64 @"std/crypto.Equal"(i64 %v507, i64 %v508, i64 %v509, i64 %v510, i64 %v511, i64 %v512)
  br label %b34
b34:
  %v506 = phi i64 [ %v505, %b32.e150 ], [ %v513, %b33 ]
  %c.b34 = icmp ne i64 %v506, 0
  br i1 %c.b34, label %b34.t151, label %b34.e152
b34.t151:
  br label %b35
b34.e152:
  br label %b36
b35:
  %v514 = add i64 0, 1
  %v515 = add i64 %v16, %v514
  %v516.p = getelementptr i64, ptr %v350, i64 0
  %v516 = load i64, ptr %v516.p
  %v517 = add i64 0, 1
  %v518 = add i64 %v516, %v517
  %st152 = getelementptr i64, ptr %v350, i64 0
  store i64 %v518, ptr %st152
  br label %b37
b36:
  br label %b37
b37:
  br label %b27
b38:
  %v955 = getelementptr i64, ptr @"rt.meta", i64 0
  %st153 = getelementptr i64, ptr %v955, i64 0
  store i64 %v536, ptr %st153
  %v720 = getelementptr i64, ptr @"str.33", i64 0
  %v721 = add i64 0, 11
  %v722 = add i64 0, 0
  %v723 = getelementptr i64, ptr %s35, i64 0
  %v724 = ptrtoint ptr %v720 to i64
  %st154 = getelementptr i64, ptr %v723, i64 0
  store i64 %v724, ptr %st154
  %st155 = getelementptr i64, ptr %v723, i64 1
  store i64 %v721, ptr %st155
  %st156 = getelementptr i64, ptr %v723, i64 2
  store i64 %v722, ptr %st156
  %v725.p = getelementptr i64, ptr %v535, i64 0
  %v725 = load i64, ptr %v725.p
  %v726.p = getelementptr i64, ptr %v533, i64 0
  %v726 = load i64, ptr %v726.p
  call void @"rt.print_str"(ptr %v723)
  %v727 = add i64 0, 32
  call void @"rt.print_char"(i64 %v727)
  call void @"rt.print_int"(i64 %v725)
  %v728 = add i64 0, 32
  call void @"rt.print_char"(i64 %v728)
  call void @"rt.print_int"(i64 %v726)
  %v729 = add i64 0, 10
  call void @"rt.print_char"(i64 %v729)
  %v730 = getelementptr i64, ptr %s59, i64 0
  %v731.p = getelementptr i64, ptr %v23, i64 0
  %v731 = load i64, ptr %v731.p
  %v732.p = getelementptr i64, ptr %v23, i64 1
  %v732 = load i64, ptr %v732.p
  %v733.p = getelementptr i64, ptr %v23, i64 2
  %v733 = load i64, ptr %v733.p
  %v734.p = getelementptr i64, ptr %v13, i64 0
  %v734 = load i64, ptr %v734.p
  %v735.p = getelementptr i64, ptr %v13, i64 1
  %v735 = load i64, ptr %v735.p
  %v736.p = getelementptr i64, ptr %v13, i64 2
  %v736 = load i64, ptr %v736.p
  %v737.p = getelementptr i64, ptr %v14, i64 0
  %v737 = load i64, ptr %v737.p
  %v738.p = getelementptr i64, ptr %v14, i64 1
  %v738 = load i64, ptr %v738.p
  %v739.p = getelementptr i64, ptr %v14, i64 2
  %v739 = load i64, ptr %v739.p
  %v740.p = getelementptr i64, ptr %v125, i64 0
  %v740 = load i64, ptr %v740.p
  %v741.p = getelementptr i64, ptr %v125, i64 1
  %v741 = load i64, ptr %v741.p
  %v742.p = getelementptr i64, ptr %v125, i64 2
  %v742 = load i64, ptr %v742.p
  %v743 = add i64 0, 8
  %v744.p = getelementptr i64, ptr %v116, i64 1
  %v744 = load i64, ptr %v744.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v730, i64 %v731, i64 %v732, i64 %v733, i64 %v734, i64 %v735, i64 %v736, i64 %v737, i64 %v738, i64 %v739, i64 %v740, i64 %v741, i64 %v742, i64 %v743, i64 %v744)
  %v745 = add i64 0, 3
  %v746 = getelementptr i64, ptr %v730, i64 %v745
  %v747 = getelementptr i64, ptr %s46, i64 0
  %v748.p = getelementptr i64, ptr %v746, i64 0
  %v748 = load i64, ptr %v748.p
  %st157 = getelementptr i64, ptr %v747, i64 0
  store i64 %v748, ptr %st157
  %v749.p = getelementptr i64, ptr %v746, i64 1
  %v749 = load i64, ptr %v749.p
  %st158 = getelementptr i64, ptr %v747, i64 1
  store i64 %v749, ptr %st158
  %v750.p = getelementptr i64, ptr %v746, i64 2
  %v750 = load i64, ptr %v750.p
  %st159 = getelementptr i64, ptr %v747, i64 2
  store i64 %v750, ptr %st159
  %v751.p = getelementptr i64, ptr %v746, i64 3
  %v751 = load i64, ptr %v751.p
  %st160 = getelementptr i64, ptr %v747, i64 3
  store i64 %v751, ptr %st160
  %v752.p = getelementptr i64, ptr %v746, i64 4
  %v752 = load i64, ptr %v752.p
  %st161 = getelementptr i64, ptr %v747, i64 4
  store i64 %v752, ptr %st161
  %v753 = getelementptr i64, ptr %s60, i64 0
  %v754.p = getelementptr i64, ptr %v23, i64 0
  %v754 = load i64, ptr %v754.p
  %v755.p = getelementptr i64, ptr %v23, i64 1
  %v755 = load i64, ptr %v755.p
  %v756.p = getelementptr i64, ptr %v23, i64 2
  %v756 = load i64, ptr %v756.p
  %v757.p = getelementptr i64, ptr %v13, i64 0
  %v757 = load i64, ptr %v757.p
  %v758.p = getelementptr i64, ptr %v13, i64 1
  %v758 = load i64, ptr %v758.p
  %v759.p = getelementptr i64, ptr %v13, i64 2
  %v759 = load i64, ptr %v759.p
  %v760.p = getelementptr i64, ptr %v14, i64 0
  %v760 = load i64, ptr %v760.p
  %v761.p = getelementptr i64, ptr %v14, i64 1
  %v761 = load i64, ptr %v761.p
  %v762.p = getelementptr i64, ptr %v14, i64 2
  %v762 = load i64, ptr %v762.p
  %v763.p = getelementptr i64, ptr %v125, i64 0
  %v763 = load i64, ptr %v763.p
  %v764.p = getelementptr i64, ptr %v125, i64 1
  %v764 = load i64, ptr %v764.p
  %v765.p = getelementptr i64, ptr %v125, i64 2
  %v765 = load i64, ptr %v765.p
  %v766 = add i64 0, 4
  %v767 = add i64 0, 15
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v753, i64 %v754, i64 %v755, i64 %v756, i64 %v757, i64 %v758, i64 %v759, i64 %v760, i64 %v761, i64 %v762, i64 %v763, i64 %v764, i64 %v765, i64 %v766, i64 %v767)
  %v768 = add i64 0, 3
  %v769 = getelementptr i64, ptr %v753, i64 %v768
  %v770 = getelementptr i64, ptr %s61, i64 0
  %v771.p = getelementptr i64, ptr %v769, i64 0
  %v771 = load i64, ptr %v771.p
  %st162 = getelementptr i64, ptr %v770, i64 0
  store i64 %v771, ptr %st162
  %v772.p = getelementptr i64, ptr %v769, i64 1
  %v772 = load i64, ptr %v772.p
  %st163 = getelementptr i64, ptr %v770, i64 1
  store i64 %v772, ptr %st163
  %v773.p = getelementptr i64, ptr %v769, i64 2
  %v773 = load i64, ptr %v773.p
  %st164 = getelementptr i64, ptr %v770, i64 2
  store i64 %v773, ptr %st164
  %v774.p = getelementptr i64, ptr %v769, i64 3
  %v774 = load i64, ptr %v774.p
  %st165 = getelementptr i64, ptr %v770, i64 3
  store i64 %v774, ptr %st165
  %v775.p = getelementptr i64, ptr %v769, i64 4
  %v775 = load i64, ptr %v775.p
  %st166 = getelementptr i64, ptr %v770, i64 4
  store i64 %v775, ptr %st166
  %v776 = getelementptr i64, ptr %s62, i64 0
  %v777.p = getelementptr i64, ptr %v23, i64 0
  %v777 = load i64, ptr %v777.p
  %v778.p = getelementptr i64, ptr %v23, i64 1
  %v778 = load i64, ptr %v778.p
  %v779.p = getelementptr i64, ptr %v23, i64 2
  %v779 = load i64, ptr %v779.p
  %v780.p = getelementptr i64, ptr %v13, i64 0
  %v780 = load i64, ptr %v780.p
  %v781.p = getelementptr i64, ptr %v13, i64 1
  %v781 = load i64, ptr %v781.p
  %v782.p = getelementptr i64, ptr %v13, i64 2
  %v782 = load i64, ptr %v782.p
  %v783.p = getelementptr i64, ptr %v14, i64 0
  %v783 = load i64, ptr %v783.p
  %v784.p = getelementptr i64, ptr %v14, i64 1
  %v784 = load i64, ptr %v784.p
  %v785.p = getelementptr i64, ptr %v14, i64 2
  %v785 = load i64, ptr %v785.p
  %v786.p = getelementptr i64, ptr %v125, i64 0
  %v786 = load i64, ptr %v786.p
  %v787.p = getelementptr i64, ptr %v125, i64 1
  %v787 = load i64, ptr %v787.p
  %v788.p = getelementptr i64, ptr %v125, i64 2
  %v788 = load i64, ptr %v788.p
  %v789 = add i64 0, 1
  %v790 = add i64 0, 0
  %v791 = sub i64 %v790, %v789
  %v792.p = getelementptr i64, ptr %v116, i64 1
  %v792 = load i64, ptr %v792.p
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v776, i64 %v777, i64 %v778, i64 %v779, i64 %v780, i64 %v781, i64 %v782, i64 %v783, i64 %v784, i64 %v785, i64 %v786, i64 %v787, i64 %v788, i64 %v791, i64 %v792)
  %v793 = add i64 0, 3
  %v794 = getelementptr i64, ptr %v776, i64 %v793
  %v795 = getelementptr i64, ptr %s63, i64 0
  %v796.p = getelementptr i64, ptr %v794, i64 0
  %v796 = load i64, ptr %v796.p
  %st167 = getelementptr i64, ptr %v795, i64 0
  store i64 %v796, ptr %st167
  %v797.p = getelementptr i64, ptr %v794, i64 1
  %v797 = load i64, ptr %v797.p
  %st168 = getelementptr i64, ptr %v795, i64 1
  store i64 %v797, ptr %st168
  %v798.p = getelementptr i64, ptr %v794, i64 2
  %v798 = load i64, ptr %v798.p
  %st169 = getelementptr i64, ptr %v795, i64 2
  store i64 %v798, ptr %st169
  %v799.p = getelementptr i64, ptr %v794, i64 3
  %v799 = load i64, ptr %v799.p
  %st170 = getelementptr i64, ptr %v795, i64 3
  store i64 %v799, ptr %st170
  %v800.p = getelementptr i64, ptr %v794, i64 4
  %v800 = load i64, ptr %v800.p
  %st171 = getelementptr i64, ptr %v795, i64 4
  store i64 %v800, ptr %st171
  %v801 = getelementptr i64, ptr %s64, i64 0
  %v802.p = getelementptr i64, ptr %v23, i64 0
  %v802 = load i64, ptr %v802.p
  %v803.p = getelementptr i64, ptr %v23, i64 1
  %v803 = load i64, ptr %v803.p
  %v804.p = getelementptr i64, ptr %v23, i64 2
  %v804 = load i64, ptr %v804.p
  %v805 = getelementptr i64, ptr %s65, i64 0
  %v806 = getelementptr i64, ptr @"str.11", i64 0
  %v807 = add i64 0, 22
  %v808 = add i64 0, 0
  %v809 = getelementptr i64, ptr %s35, i64 0
  %v810 = ptrtoint ptr %v806 to i64
  %st172 = getelementptr i64, ptr %v809, i64 0
  store i64 %v810, ptr %st172
  %st173 = getelementptr i64, ptr %v809, i64 1
  store i64 %v807, ptr %st173
  %st174 = getelementptr i64, ptr %v809, i64 2
  store i64 %v808, ptr %st174
  %v811.p = getelementptr i64, ptr %v809, i64 0
  %v811 = load i64, ptr %v811.p
  %v812.p = getelementptr i64, ptr %v809, i64 1
  %v812 = load i64, ptr %v812.p
  %v813.p = getelementptr i64, ptr %v809, i64 2
  %v813 = load i64, ptr %v813.p
  call void @"main.unhex"(ptr %v805, i64 %v811, i64 %v812, i64 %v813)
  %v814.p = getelementptr i64, ptr %v805, i64 0
  %v814 = load i64, ptr %v814.p
  %v815.p = getelementptr i64, ptr %v805, i64 1
  %v815 = load i64, ptr %v815.p
  %v816.p = getelementptr i64, ptr %v805, i64 2
  %v816 = load i64, ptr %v816.p
  %v817.p = getelementptr i64, ptr %v14, i64 0
  %v817 = load i64, ptr %v817.p
  %v818.p = getelementptr i64, ptr %v14, i64 1
  %v818 = load i64, ptr %v818.p
  %v819.p = getelementptr i64, ptr %v14, i64 2
  %v819 = load i64, ptr %v819.p
  %v820.p = getelementptr i64, ptr %v15, i64 0
  %v820 = load i64, ptr %v820.p
  %v821.p = getelementptr i64, ptr %v15, i64 1
  %v821 = load i64, ptr %v821.p
  %v822.p = getelementptr i64, ptr %v15, i64 2
  %v822 = load i64, ptr %v822.p
  %v823.p = getelementptr i64, ptr %v36, i64 0
  %v823 = load i64, ptr %v823.p
  %v824.p = getelementptr i64, ptr %v36, i64 1
  %v824 = load i64, ptr %v824.p
  %v825.p = getelementptr i64, ptr %v36, i64 2
  %v825 = load i64, ptr %v825.p
  %v956 = getelementptr i64, ptr @"rt.meta", i64 0
  %v826.p = getelementptr i64, ptr %v956, i64 0
  %v826 = load i64, ptr %v826.p
  %v827 = add i64 0, 0
  %v828 = call ptr @"rt.region_alloc8"(i64 %v826, i64 %v827)
  %v829 = add i64 0, 0
  %v830 = getelementptr i64, ptr %s43, i64 0
  %v831 = ptrtoint ptr %v828 to i64
  %st175 = getelementptr i64, ptr %v830, i64 0
  store i64 %v831, ptr %st175
  %st176 = getelementptr i64, ptr %v830, i64 1
  store i64 %v829, ptr %st176
  %st177 = getelementptr i64, ptr %v830, i64 2
  store i64 %v826, ptr %st177
  %v832.p = getelementptr i64, ptr %v830, i64 0
  %v832 = load i64, ptr %v832.p
  %v833.p = getelementptr i64, ptr %v830, i64 1
  %v833 = load i64, ptr %v833.p
  %v834.p = getelementptr i64, ptr %v830, i64 2
  %v834 = load i64, ptr %v834.p
  call void @"std/crypto/chacha20poly1305.SealTo"(ptr %v801, i64 %v802, i64 %v803, i64 %v804, i64 %v814, i64 %v815, i64 %v816, i64 %v817, i64 %v818, i64 %v819, i64 %v820, i64 %v821, i64 %v822, i64 %v823, i64 %v824, i64 %v825, i64 %v832, i64 %v833, i64 %v834)
  %v835 = add i64 0, 3
  %v836 = getelementptr i64, ptr %v801, i64 %v835
  %v837 = getelementptr i64, ptr %s66, i64 0
  %v838.p = getelementptr i64, ptr %v836, i64 0
  %v838 = load i64, ptr %v838.p
  %st178 = getelementptr i64, ptr %v837, i64 0
  store i64 %v838, ptr %st178
  %v839.p = getelementptr i64, ptr %v836, i64 1
  %v839 = load i64, ptr %v839.p
  %st179 = getelementptr i64, ptr %v837, i64 1
  store i64 %v839, ptr %st179
  %v840.p = getelementptr i64, ptr %v836, i64 2
  %v840 = load i64, ptr %v840.p
  %st180 = getelementptr i64, ptr %v837, i64 2
  store i64 %v840, ptr %st180
  %v841.p = getelementptr i64, ptr %v836, i64 3
  %v841 = load i64, ptr %v841.p
  %st181 = getelementptr i64, ptr %v837, i64 3
  store i64 %v841, ptr %st181
  %v842.p = getelementptr i64, ptr %v836, i64 4
  %v842 = load i64, ptr %v842.p
  %st182 = getelementptr i64, ptr %v837, i64 4
  store i64 %v842, ptr %st182
  %v843 = getelementptr i64, ptr %s67, i64 0
  %v844 = getelementptr i64, ptr %s68, i64 0
  %v845 = add i64 0, 0
  %v846 = add i64 0, 30
  call void @"main.seq"(ptr %v844, i64 %v845, i64 %v846)
  %v847.p = getelementptr i64, ptr %v844, i64 0
  %v847 = load i64, ptr %v847.p
  %v848.p = getelementptr i64, ptr %v844, i64 1
  %v848 = load i64, ptr %v848.p
  %v849.p = getelementptr i64, ptr %v844, i64 2
  %v849 = load i64, ptr %v849.p
  call void @"std/crypto/chacha20poly1305.Prepare"(ptr %v843, i64 %v847, i64 %v848, i64 %v849)
  %v850 = add i64 0, 3
  %v851 = getelementptr i64, ptr %v843, i64 %v850
  %v852 = getelementptr i64, ptr %s69, i64 0
  %v853.p = getelementptr i64, ptr %v851, i64 0
  %v853 = load i64, ptr %v853.p
  %st183 = getelementptr i64, ptr %v852, i64 0
  store i64 %v853, ptr %st183
  %v854.p = getelementptr i64, ptr %v851, i64 1
  %v854 = load i64, ptr %v854.p
  %st184 = getelementptr i64, ptr %v852, i64 1
  store i64 %v854, ptr %st184
  %v855.p = getelementptr i64, ptr %v851, i64 2
  %v855 = load i64, ptr %v855.p
  %st185 = getelementptr i64, ptr %v852, i64 2
  store i64 %v855, ptr %st185
  %v856.p = getelementptr i64, ptr %v851, i64 3
  %v856 = load i64, ptr %v856.p
  %st186 = getelementptr i64, ptr %v852, i64 3
  store i64 %v856, ptr %st186
  %v857.p = getelementptr i64, ptr %v851, i64 4
  %v857 = load i64, ptr %v857.p
  %st187 = getelementptr i64, ptr %v852, i64 4
  store i64 %v857, ptr %st187
  %v858 = getelementptr i64, ptr @"str.27", i64 0
  %v859 = add i64 0, 14
  %v860 = add i64 0, 0
  %v861 = getelementptr i64, ptr %s43, i64 0
  %v862 = ptrtoint ptr %v858 to i64
  %st188 = getelementptr i64, ptr %v861, i64 0
  store i64 %v862, ptr %st188
  %st189 = getelementptr i64, ptr %v861, i64 1
  store i64 %v859, ptr %st189
  %st190 = getelementptr i64, ptr %v861, i64 2
  store i64 %v860, ptr %st190
  %v863.p = getelementptr i64, ptr %v747, i64 0
  %v863 = load i64, ptr %v863.p
  %v864 = add i64 0, 0
  %v865.c = icmp ne i64 %v863, %v864
  %v865 = zext i1 %v865.c to i64
  %v866.p = getelementptr i64, ptr %v770, i64 0
  %v866 = load i64, ptr %v866.p
  %v867 = add i64 0, 0
  %v868.c = icmp ne i64 %v866, %v867
  %v868 = zext i1 %v868.c to i64
  %v869.p = getelementptr i64, ptr %v795, i64 0
  %v869 = load i64, ptr %v869.p
  %v870 = add i64 0, 0
  %v871.c = icmp ne i64 %v869, %v870
  %v871 = zext i1 %v871.c to i64
  %v872.p = getelementptr i64, ptr %v837, i64 0
  %v872 = load i64, ptr %v872.p
  %v873 = add i64 0, 0
  %v874.c = icmp ne i64 %v872, %v873
  %v874 = zext i1 %v874.c to i64
  %v875.p = getelementptr i64, ptr %v852, i64 0
  %v875 = load i64, ptr %v875.p
  %v876 = add i64 0, 0
  %v877.c = icmp ne i64 %v875, %v876
  %v877 = zext i1 %v877.c to i64
  call void @"rt.print_str"(ptr %v861)
  %v878 = add i64 0, 32
  call void @"rt.print_char"(i64 %v878)
  %c.b38 = icmp ne i64 %v865, 0
  br i1 %c.b38, label %b38.t192, label %b38.e193
b38.t192:
  br label %b79
b38.e193:
  br label %b80
b39:
  br label %b38
b40:
  %v957 = getelementptr i64, ptr @"rt.meta", i64 0
  %st193 = getelementptr i64, ptr %v957, i64 0
  store i64 %v542, ptr %st193
  %v543.p = getelementptr i64, ptr %v541, i64 0
  %v543 = load i64, ptr %v543.p
  %v544.c = icmp slt i64 %v543, %v538
  %v544 = zext i1 %v544.c to i64
  %c.b40 = icmp ne i64 %v544, 0
  br i1 %c.b40, label %b40.t195, label %b40.e196
b40.t195:
  br label %b41
b40.e196:
  br label %b42
b41:
  call void @"rt.region_enter"()
  %v958 = getelementptr i64, ptr @"rt.meta", i64 0
  %v545.p = getelementptr i64, ptr %v958, i64 0
  %v545 = load i64, ptr %v545.p
  %v546.p = getelementptr i64, ptr %v541, i64 0
  %v546 = load i64, ptr %v546.p
  %v959 = getelementptr i64, ptr @"rt.meta", i64 0
  %v547.p = getelementptr i64, ptr %v959, i64 0
  %v547 = load i64, ptr %v547.p
  %v548 = getelementptr i64, ptr %s49, i64 0
  %v549 = add i64 0, 0
  %v550 = add i64 0, 1
  %v551 = sub i64 %v546, %v550
  call void @"main.seq"(ptr %v548, i64 %v549, i64 %v551)
  %v552 = getelementptr i64, ptr %s43, i64 0
  %v553.p = getelementptr i64, ptr %v548, i64 0
  %v553 = load i64, ptr %v553.p
  %st196 = getelementptr i64, ptr %v552, i64 0
  store i64 %v553, ptr %st196
  %v554.p = getelementptr i64, ptr %v548, i64 1
  %v554 = load i64, ptr %v554.p
  %st197 = getelementptr i64, ptr %v552, i64 1
  store i64 %v554, ptr %st197
  %v555.p = getelementptr i64, ptr %v548, i64 2
  %v555 = load i64, ptr %v555.p
  %st198 = getelementptr i64, ptr %v552, i64 2
  store i64 %v555, ptr %st198
  %v556 = getelementptr i64, ptr %s50, i64 0
  %v557.p = getelementptr i64, ptr %v23, i64 0
  %v557 = load i64, ptr %v557.p
  %v558.p = getelementptr i64, ptr %v23, i64 1
  %v558 = load i64, ptr %v558.p
  %v559.p = getelementptr i64, ptr %v23, i64 2
  %v559 = load i64, ptr %v559.p
  %v560.p = getelementptr i64, ptr %v13, i64 0
  %v560 = load i64, ptr %v560.p
  %v561.p = getelementptr i64, ptr %v13, i64 1
  %v561 = load i64, ptr %v561.p
  %v562.p = getelementptr i64, ptr %v13, i64 2
  %v562 = load i64, ptr %v562.p
  %v563.p = getelementptr i64, ptr %v14, i64 0
  %v563 = load i64, ptr %v563.p
  %v564.p = getelementptr i64, ptr %v14, i64 1
  %v564 = load i64, ptr %v564.p
  %v565.p = getelementptr i64, ptr %v14, i64 2
  %v565 = load i64, ptr %v565.p
  %v566.p = getelementptr i64, ptr %v552, i64 0
  %v566 = load i64, ptr %v566.p
  %v567.p = getelementptr i64, ptr %v552, i64 1
  %v567 = load i64, ptr %v567.p
  %v568.p = getelementptr i64, ptr %v552, i64 2
  %v568 = load i64, ptr %v568.p
  %v569 = getelementptr i64, ptr %s51, i64 0
  %v570 = getelementptr i64, ptr @"str.13", i64 0
  %v571 = add i64 0, 8
  %v572 = add i64 0, 0
  %v573 = getelementptr i64, ptr %s37, i64 0
  %v574 = ptrtoint ptr %v570 to i64
  %st199 = getelementptr i64, ptr %v573, i64 0
  store i64 %v574, ptr %st199
  %st200 = getelementptr i64, ptr %v573, i64 1
  store i64 %v571, ptr %st200
  %st201 = getelementptr i64, ptr %v573, i64 2
  store i64 %v572, ptr %st201
  %v575.p = getelementptr i64, ptr %v573, i64 0
  %v575 = load i64, ptr %v575.p
  %v576.p = getelementptr i64, ptr %v573, i64 1
  %v576 = load i64, ptr %v576.p
  %v577.p = getelementptr i64, ptr %v573, i64 2
  %v577 = load i64, ptr %v577.p
  call void @"main.unhex"(ptr %v569, i64 %v575, i64 %v576, i64 %v577)
  %v578.p = getelementptr i64, ptr %v569, i64 0
  %v578 = load i64, ptr %v578.p
  %v579.p = getelementptr i64, ptr %v569, i64 1
  %v579 = load i64, ptr %v579.p
  %v580.p = getelementptr i64, ptr %v569, i64 2
  %v580 = load i64, ptr %v580.p
  %v960 = getelementptr i64, ptr @"rt.meta", i64 0
  %v581.p = getelementptr i64, ptr %v960, i64 0
  %v581 = load i64, ptr %v581.p
  %v582 = add i64 0, 0
  %v583 = call ptr @"rt.region_alloc8"(i64 %v581, i64 %v582)
  %v584 = add i64 0, 0
  %v585 = getelementptr i64, ptr %s38, i64 0
  %v586 = ptrtoint ptr %v583 to i64
  %st202 = getelementptr i64, ptr %v585, i64 0
  store i64 %v586, ptr %st202
  %st203 = getelementptr i64, ptr %v585, i64 1
  store i64 %v584, ptr %st203
  %st204 = getelementptr i64, ptr %v585, i64 2
  store i64 %v581, ptr %st204
  %v587.p = getelementptr i64, ptr %v585, i64 0
  %v587 = load i64, ptr %v587.p
  %v588.p = getelementptr i64, ptr %v585, i64 1
  %v588 = load i64, ptr %v588.p
  %v589.p = getelementptr i64, ptr %v585, i64 2
  %v589 = load i64, ptr %v589.p
  call void @"std/crypto/chacha20poly1305.SealTo"(ptr %v556, i64 %v557, i64 %v558, i64 %v559, i64 %v560, i64 %v561, i64 %v562, i64 %v563, i64 %v564, i64 %v565, i64 %v566, i64 %v567, i64 %v568, i64 %v578, i64 %v579, i64 %v580, i64 %v587, i64 %v588, i64 %v589)
  %v590 = add i64 0, 3
  %v591 = getelementptr i64, ptr %v556, i64 %v590
  %v592 = getelementptr i64, ptr %s35, i64 0
  %v593.p = getelementptr i64, ptr %v556, i64 0
  %v593 = load i64, ptr %v593.p
  %st205 = getelementptr i64, ptr %v592, i64 0
  store i64 %v593, ptr %st205
  %v594.p = getelementptr i64, ptr %v556, i64 1
  %v594 = load i64, ptr %v594.p
  %st206 = getelementptr i64, ptr %v592, i64 1
  store i64 %v594, ptr %st206
  %v595.p = getelementptr i64, ptr %v556, i64 2
  %v595 = load i64, ptr %v595.p
  %st207 = getelementptr i64, ptr %v592, i64 2
  store i64 %v595, ptr %st207
  %v961 = getelementptr i64, ptr @"rt.meta", i64 0
  %v596.p = getelementptr i64, ptr %v961, i64 0
  %v596 = load i64, ptr %v596.p
  %v597 = add i64 0, 0
  %v598 = add i64 0, 4
  %v599 = getelementptr i64, ptr %s52, i64 0
  %v962 = getelementptr i64, ptr @"rt.meta", i64 0
  %v600.p = getelementptr i64, ptr %v962, i64 0
  %v600 = load i64, ptr %v600.p
  %v601 = getelementptr i64, ptr %s53, i64 0
  %st208 = getelementptr i64, ptr %v601, i64 0
  store i64 %v597, ptr %st208
  %v963 = getelementptr i64, ptr @"rt.meta", i64 0
  %v602.p = getelementptr i64, ptr %v963, i64 0
  %v602 = load i64, ptr %v602.p
  br label %b46
b42:
  %v964 = getelementptr i64, ptr @"rt.meta", i64 0
  %st209 = getelementptr i64, ptr %v964, i64 0
  store i64 %v542, ptr %st209
  br label %b39
b43:
  %v965 = getelementptr i64, ptr @"rt.meta", i64 0
  %st210 = getelementptr i64, ptr %v965, i64 0
  store i64 %v547, ptr %st210
  %v717 = add i64 0, 1
  %v718.p = getelementptr i64, ptr %v541, i64 0
  %v718 = load i64, ptr %v718.p
  %v719 = add i64 %v718, %v717
  %st211 = getelementptr i64, ptr %v541, i64 0
  store i64 %v719, ptr %st211
  br label %b40
b44:
  %v966 = getelementptr i64, ptr @"rt.meta", i64 0
  %st212 = getelementptr i64, ptr %v966, i64 0
  store i64 %v596, ptr %st212
  br label %b43
b45:
  br label %b44
b46:
  %v967 = getelementptr i64, ptr @"rt.meta", i64 0
  %st213 = getelementptr i64, ptr %v967, i64 0
  store i64 %v602, ptr %st213
  %v603.p = getelementptr i64, ptr %v601, i64 0
  %v603 = load i64, ptr %v603.p
  %v604.c = icmp slt i64 %v603, %v598
  %v604 = zext i1 %v604.c to i64
  %c.b46 = icmp ne i64 %v604, 0
  br i1 %c.b46, label %b46.t215, label %b46.e216
b46.t215:
  br label %b47
b46.e216:
  br label %b48
b47:
  call void @"rt.region_enter"()
  %v968 = getelementptr i64, ptr @"rt.meta", i64 0
  %v605.p = getelementptr i64, ptr %v968, i64 0
  %v605 = load i64, ptr %v605.p
  %v606.p = getelementptr i64, ptr %v601, i64 0
  %v606 = load i64, ptr %v606.p
  %v969 = getelementptr i64, ptr @"rt.meta", i64 0
  %v607.p = getelementptr i64, ptr %v969, i64 0
  %v607 = load i64, ptr %v607.p
  %v608 = add i64 0, 0
  %v609.c = icmp eq i64 %v606, %v608
  %v609 = zext i1 %v609.c to i64
  %c.b47 = icmp ne i64 %v609, 0
  br i1 %c.b47, label %b47.t217, label %b47.e218
b47.t217:
  br label %b50
b47.e218:
  br label %b51
b48:
  %v970 = getelementptr i64, ptr @"rt.meta", i64 0
  %st218 = getelementptr i64, ptr %v970, i64 0
  store i64 %v602, ptr %st218
  br label %b45
b49:
  %v971 = getelementptr i64, ptr @"rt.meta", i64 0
  %st219 = getelementptr i64, ptr %v971, i64 0
  store i64 %v607, ptr %st219
  %v714 = add i64 0, 1
  %v715.p = getelementptr i64, ptr %v601, i64 0
  %v715 = load i64, ptr %v715.p
  %v716 = add i64 %v715, %v714
  %st220 = getelementptr i64, ptr %v601, i64 0
  store i64 %v716, ptr %st220
  br label %b46
b50:
  %v610 = add i64 0, 0
  br label %b61
b51:
  %v611 = add i64 0, 1
  %v612.c = icmp eq i64 %v606, %v611
  %v612 = zext i1 %v612.c to i64
  %c.b51 = icmp ne i64 %v612, 0
  br i1 %c.b51, label %b51.t222, label %b51.e223
b51.t222:
  br label %b52
b51.e223:
  br label %b53
b52:
  br label %b60
b53:
  %v613 = add i64 0, 2
  %v614.c = icmp eq i64 %v606, %v613
  %v614 = zext i1 %v614.c to i64
  %c.b53 = icmp ne i64 %v614, 0
  br i1 %c.b53, label %b53.t224, label %b53.e225
b53.t224:
  br label %b54
b53.e225:
  br label %b55
b54:
  %v615 = add i64 0, 2
  %v616 = sdiv i64 %v546, %v615
  br label %b59
b55:
  %v617 = add i64 0, 3
  %v618.c = icmp sgt i64 %v546, %v617
  %v618 = zext i1 %v618.c to i64
  %c.b55 = icmp ne i64 %v618, 0
  br i1 %c.b55, label %b55.t226, label %b55.e227
b55.t226:
  br label %b56
b55.e227:
  br label %b57
b56:
  %v619 = add i64 0, 3
  %v620 = sub i64 %v546, %v619
  br label %b58
b57:
  br label %b58
b58:
  %v621 = phi i64 [ %v620, %b56 ], [ %v546, %b57 ]
  br label %b59
b59:
  %v622 = phi i64 [ %v616, %b54 ], [ %v621, %b58 ]
  br label %b60
b60:
  %v623 = phi i64 [ %v546, %b52 ], [ %v622, %b59 ]
  br label %b61
b61:
  %v624 = phi i64 [ %v610, %b50 ], [ %v623, %b60 ]
  %v625 = getelementptr i64, ptr %s54, i64 0
  %v626.p = getelementptr i64, ptr %v23, i64 0
  %v626 = load i64, ptr %v626.p
  %v627.p = getelementptr i64, ptr %v23, i64 1
  %v627 = load i64, ptr %v627.p
  %v628.p = getelementptr i64, ptr %v23, i64 2
  %v628 = load i64, ptr %v628.p
  %v629.p = getelementptr i64, ptr %v13, i64 0
  %v629 = load i64, ptr %v629.p
  %v630.p = getelementptr i64, ptr %v13, i64 1
  %v630 = load i64, ptr %v630.p
  %v631.p = getelementptr i64, ptr %v13, i64 2
  %v631 = load i64, ptr %v631.p
  %v632.p = getelementptr i64, ptr %v14, i64 0
  %v632 = load i64, ptr %v632.p
  %v633.p = getelementptr i64, ptr %v14, i64 1
  %v633 = load i64, ptr %v633.p
  %v634.p = getelementptr i64, ptr %v14, i64 2
  %v634 = load i64, ptr %v634.p
  %v635 = add i64 0, 0
  %v636 = add i64 0, 0
  %v637.c = icmp slt i64 %v635, %v636
  %v637 = zext i1 %v637.c to i64
  %c.b61 = icmp ne i64 %v637, 0
  br i1 %c.b61, label %b61.t228, label %b61.e229
b61.t228:
  br label %b62
b61.e229:
  br label %b63
b62:
  %v638 = add i64 0, 8
  call void @"rt.panic"(i64 %v638)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b63:
  %v639.c = icmp slt i64 %v624, %v635
  %v639 = zext i1 %v639.c to i64
  %c.b63 = icmp ne i64 %v639, 0
  br i1 %c.b63, label %b63.t230, label %b63.e231
b63.t230:
  br label %b64
b63.e231:
  br label %b65
b64:
  %v640 = add i64 0, 9
  call void @"rt.panic"(i64 %v640)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b65:
  %v641.p = getelementptr i64, ptr %v552, i64 1
  %v641 = load i64, ptr %v641.p
  %v642.c = icmp sgt i64 %v624, %v641
  %v642 = zext i1 %v642.c to i64
  %c.b65 = icmp ne i64 %v642, 0
  br i1 %c.b65, label %b65.t232, label %b65.e233
b65.t232:
  br label %b66
b65.e233:
  br label %b67
b66:
  %v643 = add i64 0, 10
  call void @"rt.panic"(i64 %v643)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b67:
  %v644.p = getelementptr i64, ptr %v552, i64 0
  %v644 = load i64, ptr %v644.p
  %v645 = inttoptr i64 %v644 to ptr
  %v646 = getelementptr i8, ptr %v645, i64 %v635
  %v647 = sub i64 %v624, %v635
  %v648.p = getelementptr i64, ptr %v552, i64 2
  %v648 = load i64, ptr %v648.p
  %v649 = getelementptr i64, ptr %s38, i64 0
  %v650 = ptrtoint ptr %v646 to i64
  %st233 = getelementptr i64, ptr %v649, i64 0
  store i64 %v650, ptr %st233
  %st234 = getelementptr i64, ptr %v649, i64 1
  store i64 %v647, ptr %st234
  %st235 = getelementptr i64, ptr %v649, i64 2
  store i64 %v648, ptr %st235
  %v651.p = getelementptr i64, ptr %v649, i64 0
  %v651 = load i64, ptr %v651.p
  %v652.p = getelementptr i64, ptr %v649, i64 1
  %v652 = load i64, ptr %v652.p
  %v653.p = getelementptr i64, ptr %v649, i64 2
  %v653 = load i64, ptr %v653.p
  %v654 = getelementptr i64, ptr %s55, i64 0
  %v655 = getelementptr i64, ptr @"str.13", i64 0
  %v656 = add i64 0, 8
  %v657 = add i64 0, 0
  %v658 = getelementptr i64, ptr %s37, i64 0
  %v659 = ptrtoint ptr %v655 to i64
  %st236 = getelementptr i64, ptr %v658, i64 0
  store i64 %v659, ptr %st236
  %st237 = getelementptr i64, ptr %v658, i64 1
  store i64 %v656, ptr %st237
  %st238 = getelementptr i64, ptr %v658, i64 2
  store i64 %v657, ptr %st238
  %v660.p = getelementptr i64, ptr %v658, i64 0
  %v660 = load i64, ptr %v660.p
  %v661.p = getelementptr i64, ptr %v658, i64 1
  %v661 = load i64, ptr %v661.p
  %v662.p = getelementptr i64, ptr %v658, i64 2
  %v662 = load i64, ptr %v662.p
  call void @"main.unhex"(ptr %v654, i64 %v660, i64 %v661, i64 %v662)
  %v663.p = getelementptr i64, ptr %v654, i64 0
  %v663 = load i64, ptr %v663.p
  %v664.p = getelementptr i64, ptr %v654, i64 1
  %v664 = load i64, ptr %v664.p
  %v665.p = getelementptr i64, ptr %v654, i64 2
  %v665 = load i64, ptr %v665.p
  %v666 = add i64 0, 0
  %v667.c = icmp slt i64 %v624, %v666
  %v667 = zext i1 %v667.c to i64
  %c.b67 = icmp ne i64 %v667, 0
  br i1 %c.b67, label %b67.t240, label %b67.e241
b67.t240:
  br label %b68
b67.e241:
  br label %b69
b68:
  %v668 = add i64 0, 11
  call void @"rt.panic"(i64 %v668)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b69:
  %v669.c = icmp slt i64 %v546, %v624
  %v669 = zext i1 %v669.c to i64
  %c.b69 = icmp ne i64 %v669, 0
  br i1 %c.b69, label %b69.t242, label %b69.e243
b69.t242:
  br label %b70
b69.e243:
  br label %b71
b70:
  %v670 = add i64 0, 12
  call void @"rt.panic"(i64 %v670)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b71:
  %v671.p = getelementptr i64, ptr %v552, i64 1
  %v671 = load i64, ptr %v671.p
  %v672.c = icmp sgt i64 %v546, %v671
  %v672 = zext i1 %v672.c to i64
  %c.b71 = icmp ne i64 %v672, 0
  br i1 %c.b71, label %b71.t244, label %b71.e245
b71.t244:
  br label %b72
b71.e245:
  br label %b73
b72:
  %v673 = add i64 0, 13
  call void @"rt.panic"(i64 %v673)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b73:
  %v674.p = getelementptr i64, ptr %v552, i64 0
  %v674 = load i64, ptr %v674.p
  %v675 = inttoptr i64 %v674 to ptr
  %v676 = getelementptr i8, ptr %v675, i64 %v624
  %v677 = sub i64 %v546, %v624
  %v678.p = getelementptr i64, ptr %v552, i64 2
  %v678 = load i64, ptr %v678.p
  %v679 = getelementptr i64, ptr %s18, i64 0
  %v680 = ptrtoint ptr %v676 to i64
  %st245 = getelementptr i64, ptr %v679, i64 0
  store i64 %v680, ptr %st245
  %st246 = getelementptr i64, ptr %v679, i64 1
  store i64 %v677, ptr %st246
  %st247 = getelementptr i64, ptr %v679, i64 2
  store i64 %v678, ptr %st247
  %v681.p = getelementptr i64, ptr %v679, i64 0
  %v681 = load i64, ptr %v681.p
  %v682.p = getelementptr i64, ptr %v679, i64 1
  %v682 = load i64, ptr %v682.p
  %v683.p = getelementptr i64, ptr %v679, i64 2
  %v683 = load i64, ptr %v683.p
  call void @"std/crypto/chacha20poly1305.SealTo"(ptr %v625, i64 %v626, i64 %v627, i64 %v628, i64 %v629, i64 %v630, i64 %v631, i64 %v632, i64 %v633, i64 %v634, i64 %v651, i64 %v652, i64 %v653, i64 %v663, i64 %v664, i64 %v665, i64 %v681, i64 %v682, i64 %v683)
  %v684 = add i64 0, 3
  %v685 = getelementptr i64, ptr %v625, i64 %v684
  %v686 = getelementptr i64, ptr %s56, i64 0
  %v687.p = getelementptr i64, ptr %v625, i64 0
  %v687 = load i64, ptr %v687.p
  %st248 = getelementptr i64, ptr %v686, i64 0
  store i64 %v687, ptr %st248
  %v688.p = getelementptr i64, ptr %v625, i64 1
  %v688 = load i64, ptr %v688.p
  %st249 = getelementptr i64, ptr %v686, i64 1
  store i64 %v688, ptr %st249
  %v689.p = getelementptr i64, ptr %v625, i64 2
  %v689 = load i64, ptr %v689.p
  %st250 = getelementptr i64, ptr %v686, i64 2
  store i64 %v689, ptr %st250
  %v690 = add i64 0, 1
  %v691 = add i64 %v16, %v690
  %v692.p = getelementptr i64, ptr %v535, i64 0
  %v692 = load i64, ptr %v692.p
  %v693 = add i64 0, 1
  %v694 = add i64 %v692, %v693
  %st251 = getelementptr i64, ptr %v535, i64 0
  store i64 %v694, ptr %st251
  %v695 = getelementptr i64, ptr %s57, i64 0
  %v696.p = getelementptr i64, ptr %v686, i64 0
  %v696 = load i64, ptr %v696.p
  %v697.p = getelementptr i64, ptr %v686, i64 1
  %v697 = load i64, ptr %v697.p
  %v698.p = getelementptr i64, ptr %v686, i64 2
  %v698 = load i64, ptr %v698.p
  call void @"std/hex.Format"(ptr %v695, i64 %v696, i64 %v697, i64 %v698)
  %v699 = getelementptr i64, ptr %s58, i64 0
  %v700.p = getelementptr i64, ptr %v592, i64 0
  %v700 = load i64, ptr %v700.p
  %v701.p = getelementptr i64, ptr %v592, i64 1
  %v701 = load i64, ptr %v701.p
  %v702.p = getelementptr i64, ptr %v592, i64 2
  %v702 = load i64, ptr %v702.p
  call void @"std/hex.Format"(ptr %v699, i64 %v700, i64 %v701, i64 %v702)
  %v704.p = getelementptr i64, ptr %v695, i64 1
  %v704 = load i64, ptr %v704.p
  %v705.p = getelementptr i64, ptr %v699, i64 1
  %v705 = load i64, ptr %v705.p
  %v706.c = icmp ne i64 %v704, %v705
  %v706 = zext i1 %v706.c to i64
  %v707 = add i64 0, 0
  %c.b73 = icmp ne i64 %v706, 0
  br i1 %c.b73, label %b73.t253, label %b73.e254
b73.t253:
  br label %b74
b73.e254:
  br label %b75
b74:
  %v703 = phi i64 [ %v707, %b73.t253 ], [ %v708, %b75 ]
  %c.b74 = icmp ne i64 %v703, 0
  br i1 %c.b74, label %b74.t255, label %b74.e256
b74.t255:
  br label %b76
b74.e256:
  br label %b77
b75:
  %v708 = call i64 @"rt.str_eq"(ptr %v695, ptr %v699)
  br label %b74
b76:
  %v709 = add i64 0, 1
  %v710 = add i64 %v16, %v709
  %v711.p = getelementptr i64, ptr %v533, i64 0
  %v711 = load i64, ptr %v711.p
  %v712 = add i64 0, 1
  %v713 = add i64 %v711, %v712
  %st256 = getelementptr i64, ptr %v533, i64 0
  store i64 %v713, ptr %st256
  br label %b78
b77:
  br label %b78
b78:
  br label %b49
b79:
  %v879 = add i64 0, 116
  call void @"rt.print_char"(i64 %v879)
  %v880 = add i64 0, 114
  call void @"rt.print_char"(i64 %v880)
  %v881 = add i64 0, 117
  call void @"rt.print_char"(i64 %v881)
  %v882 = add i64 0, 101
  call void @"rt.print_char"(i64 %v882)
  br label %b81
b80:
  %v883 = add i64 0, 102
  call void @"rt.print_char"(i64 %v883)
  %v884 = add i64 0, 97
  call void @"rt.print_char"(i64 %v884)
  %v885 = add i64 0, 108
  call void @"rt.print_char"(i64 %v885)
  %v886 = add i64 0, 115
  call void @"rt.print_char"(i64 %v886)
  %v887 = add i64 0, 101
  call void @"rt.print_char"(i64 %v887)
  br label %b81
b81:
  %v888 = add i64 0, 32
  call void @"rt.print_char"(i64 %v888)
  %c.b81 = icmp ne i64 %v868, 0
  br i1 %c.b81, label %b81.t258, label %b81.e259
b81.t258:
  br label %b82
b81.e259:
  br label %b83
b82:
  %v889 = add i64 0, 116
  call void @"rt.print_char"(i64 %v889)
  %v890 = add i64 0, 114
  call void @"rt.print_char"(i64 %v890)
  %v891 = add i64 0, 117
  call void @"rt.print_char"(i64 %v891)
  %v892 = add i64 0, 101
  call void @"rt.print_char"(i64 %v892)
  br label %b84
b83:
  %v893 = add i64 0, 102
  call void @"rt.print_char"(i64 %v893)
  %v894 = add i64 0, 97
  call void @"rt.print_char"(i64 %v894)
  %v895 = add i64 0, 108
  call void @"rt.print_char"(i64 %v895)
  %v896 = add i64 0, 115
  call void @"rt.print_char"(i64 %v896)
  %v897 = add i64 0, 101
  call void @"rt.print_char"(i64 %v897)
  br label %b84
b84:
  %v898 = add i64 0, 32
  call void @"rt.print_char"(i64 %v898)
  %c.b84 = icmp ne i64 %v871, 0
  br i1 %c.b84, label %b84.t260, label %b84.e261
b84.t260:
  br label %b85
b84.e261:
  br label %b86
b85:
  %v899 = add i64 0, 116
  call void @"rt.print_char"(i64 %v899)
  %v900 = add i64 0, 114
  call void @"rt.print_char"(i64 %v900)
  %v901 = add i64 0, 117
  call void @"rt.print_char"(i64 %v901)
  %v902 = add i64 0, 101
  call void @"rt.print_char"(i64 %v902)
  br label %b87
b86:
  %v903 = add i64 0, 102
  call void @"rt.print_char"(i64 %v903)
  %v904 = add i64 0, 97
  call void @"rt.print_char"(i64 %v904)
  %v905 = add i64 0, 108
  call void @"rt.print_char"(i64 %v905)
  %v906 = add i64 0, 115
  call void @"rt.print_char"(i64 %v906)
  %v907 = add i64 0, 101
  call void @"rt.print_char"(i64 %v907)
  br label %b87
b87:
  %v908 = add i64 0, 32
  call void @"rt.print_char"(i64 %v908)
  %c.b87 = icmp ne i64 %v874, 0
  br i1 %c.b87, label %b87.t262, label %b87.e263
b87.t262:
  br label %b88
b87.e263:
  br label %b89
b88:
  %v909 = add i64 0, 116
  call void @"rt.print_char"(i64 %v909)
  %v910 = add i64 0, 114
  call void @"rt.print_char"(i64 %v910)
  %v911 = add i64 0, 117
  call void @"rt.print_char"(i64 %v911)
  %v912 = add i64 0, 101
  call void @"rt.print_char"(i64 %v912)
  br label %b90
b89:
  %v913 = add i64 0, 102
  call void @"rt.print_char"(i64 %v913)
  %v914 = add i64 0, 97
  call void @"rt.print_char"(i64 %v914)
  %v915 = add i64 0, 108
  call void @"rt.print_char"(i64 %v915)
  %v916 = add i64 0, 115
  call void @"rt.print_char"(i64 %v916)
  %v917 = add i64 0, 101
  call void @"rt.print_char"(i64 %v917)
  br label %b90
b90:
  %v918 = add i64 0, 32
  call void @"rt.print_char"(i64 %v918)
  %c.b90 = icmp ne i64 %v877, 0
  br i1 %c.b90, label %b90.t264, label %b90.e265
b90.t264:
  br label %b91
b90.e265:
  br label %b92
b91:
  %v919 = add i64 0, 116
  call void @"rt.print_char"(i64 %v919)
  %v920 = add i64 0, 114
  call void @"rt.print_char"(i64 %v920)
  %v921 = add i64 0, 117
  call void @"rt.print_char"(i64 %v921)
  %v922 = add i64 0, 101
  call void @"rt.print_char"(i64 %v922)
  br label %b93
b92:
  %v923 = add i64 0, 102
  call void @"rt.print_char"(i64 %v923)
  %v924 = add i64 0, 97
  call void @"rt.print_char"(i64 %v924)
  %v925 = add i64 0, 108
  call void @"rt.print_char"(i64 %v925)
  %v926 = add i64 0, 115
  call void @"rt.print_char"(i64 %v926)
  %v927 = add i64 0, 101
  call void @"rt.print_char"(i64 %v927)
  br label %b93
b93:
  %v928 = add i64 0, 10
  call void @"rt.print_char"(i64 %v928)
  %v972 = getelementptr i64, ptr @"rt.meta", i64 0
  %st265 = getelementptr i64, ptr %v972, i64 0
  store i64 %v16, ptr %st265
  ret void
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
  %v32 = add i64 0, 14
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
  %v39 = add i64 0, 15
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

define internal void @"std/crypto/chacha20.Block"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7) #0 {
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
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %v8 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v8, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v8, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v8, i64 2
  store i64 %v3, ptr %st2
  %v9 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v9, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v9, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v9, i64 2
  store i64 %v6, ptr %st5
  %v145 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v145, i64 0
  %v10 = load i64, ptr %v10.p
  %v11 = getelementptr i64, ptr @"rt.meta", i64 0
  %v12.p = getelementptr i64, ptr %v11, i64 2571
  %v12 = load i64, ptr %v12.p
  %v13 = add i64 0, 0
  %st6 = getelementptr i64, ptr %v11, i64 2571
  store i64 %v13, ptr %st6
  %v14 = add i64 0, 1
  %v15.c = icmp sge i64 %v12, %v14
  %v15 = zext i1 %v15.c to i64
  %v16.c = icmp sle i64 %v12, %v10
  %v16 = zext i1 %v16.c to i64
  %v17 = and i64 %v15, %v16
  %v18 = sub i64 %v12, %v10
  %v19 = mul i64 %v17, %v18
  %v20 = add i64 %v10, %v19
  call void @"rt.region_enter"()
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v146, i64 0
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 0, 0
  %v23 = call ptr @"rt.region_alloc"(i64 %v21, i64 %v22)
  %v24 = add i64 0, 0
  %v25 = getelementptr i64, ptr %s2, i64 0
  %v26 = ptrtoint ptr %v23 to i64
  %st7 = getelementptr i64, ptr %v25, i64 0
  store i64 %v26, ptr %st7
  %st8 = getelementptr i64, ptr %v25, i64 1
  store i64 %v24, ptr %st8
  %st9 = getelementptr i64, ptr %v25, i64 2
  store i64 %v21, ptr %st9
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v28.p = getelementptr i64, ptr %v25, i64 0
  %v28 = load i64, ptr %v28.p
  %st10 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st10
  %v29.p = getelementptr i64, ptr %v25, i64 1
  %v29 = load i64, ptr %v29.p
  %st11 = getelementptr i64, ptr %v27, i64 1
  store i64 %v29, ptr %st11
  %v30.p = getelementptr i64, ptr %v25, i64 2
  %v30 = load i64, ptr %v30.p
  %st12 = getelementptr i64, ptr %v27, i64 2
  store i64 %v30, ptr %st12
  %v31 = add i64 0, 0
  %v32 = add i64 0, 0
  %v33 = add i64 0, 16
  %v34 = add i64 0, 0
  %v35 = sub i64 %v33, %v32
  %v36.c = icmp sle i64 %v35, %v31
  %v36 = zext i1 %v36.c to i64
  %c.b0 = icmp ne i64 %v36, 0
  br i1 %c.b0, label %b0.t14, label %b0.e15
b0.t14:
  br label %b1
b0.e15:
  br label %b2
b1:
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %v79.p = getelementptr i64, ptr %v147, i64 0
  %v79 = load i64, ptr %v79.p
  %v80 = add i64 0, 0
  %v81 = call ptr @"rt.region_alloc"(i64 %v79, i64 %v80)
  %v82 = add i64 0, 0
  %v83 = getelementptr i64, ptr %s4, i64 0
  %v84 = ptrtoint ptr %v81 to i64
  %st15 = getelementptr i64, ptr %v83, i64 0
  store i64 %v84, ptr %st15
  %st16 = getelementptr i64, ptr %v83, i64 1
  store i64 %v82, ptr %st16
  %st17 = getelementptr i64, ptr %v83, i64 2
  store i64 %v79, ptr %st17
  %v85 = getelementptr i64, ptr %s2, i64 0
  %v86.p = getelementptr i64, ptr %v83, i64 0
  %v86 = load i64, ptr %v86.p
  %st18 = getelementptr i64, ptr %v85, i64 0
  store i64 %v86, ptr %st18
  %v87.p = getelementptr i64, ptr %v83, i64 1
  %v87 = load i64, ptr %v87.p
  %st19 = getelementptr i64, ptr %v85, i64 1
  store i64 %v87, ptr %st19
  %v88.p = getelementptr i64, ptr %v83, i64 2
  %v88 = load i64, ptr %v88.p
  %st20 = getelementptr i64, ptr %v85, i64 2
  store i64 %v88, ptr %st20
  %v89 = add i64 0, 1
  %v90 = add i64 %v10, %v89
  %v91.p = getelementptr i64, ptr %v8, i64 0
  %v91 = load i64, ptr %v91.p
  %v92.p = getelementptr i64, ptr %v8, i64 1
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v8, i64 2
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v9, i64 0
  %v94 = load i64, ptr %v94.p
  %v95.p = getelementptr i64, ptr %v9, i64 1
  %v95 = load i64, ptr %v95.p
  %v96.p = getelementptr i64, ptr %v9, i64 2
  %v96 = load i64, ptr %v96.p
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v97, i64 2572
  store i64 %v90, ptr %st21
  call void @"std/crypto/chacha20.initState"(ptr %v85, i64 %v91, i64 %v92, i64 %v93, i64 %v94, i64 %v95, i64 %v96)
  %v98 = add i64 0, 1
  %v99 = add i64 %v10, %v98
  %v100.p = getelementptr i64, ptr %v85, i64 0
  %v100 = load i64, ptr %v100.p
  %v101.p = getelementptr i64, ptr %v85, i64 1
  %v101 = load i64, ptr %v101.p
  %v102.p = getelementptr i64, ptr %v85, i64 2
  %v102 = load i64, ptr %v102.p
  %v103 = add i64 0, 4294967295
  %v104 = and i64 %v7, %v103
  %v105 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v105, i64 2572
  store i64 %v99, ptr %st22
  call void @"std/crypto/chacha20.rounds"(ptr %v27, i64 %v100, i64 %v101, i64 %v102, i64 %v104)
  %v106 = add i64 0, 0
  %v107 = call ptr @"rt.region_alloc8"(i64 %v20, i64 %v106)
  %v108 = add i64 0, 0
  %v109 = getelementptr i64, ptr %s4, i64 0
  %v110 = ptrtoint ptr %v107 to i64
  %st23 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st23
  %st24 = getelementptr i64, ptr %v109, i64 1
  store i64 %v108, ptr %st24
  %st25 = getelementptr i64, ptr %v109, i64 2
  store i64 %v20, ptr %st25
  %v111 = getelementptr i64, ptr %s5, i64 0
  %v112.p = getelementptr i64, ptr %v109, i64 0
  %v112 = load i64, ptr %v112.p
  %st26 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st26
  %v113.p = getelementptr i64, ptr %v109, i64 1
  %v113 = load i64, ptr %v113.p
  %st27 = getelementptr i64, ptr %v111, i64 1
  store i64 %v113, ptr %st27
  %v114.p = getelementptr i64, ptr %v109, i64 2
  %v114 = load i64, ptr %v114.p
  %st28 = getelementptr i64, ptr %v111, i64 2
  store i64 %v114, ptr %st28
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %v115.p = getelementptr i64, ptr %v148, i64 0
  %v115 = load i64, ptr %v115.p
  %v116 = add i64 0, 0
  %v117 = add i64 0, 16
  %v118 = getelementptr i64, ptr %s6, i64 0
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v119.p = getelementptr i64, ptr %v149, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = getelementptr i64, ptr %s7, i64 0
  %st29 = getelementptr i64, ptr %v120, i64 0
  store i64 %v116, ptr %st29
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %v121.p = getelementptr i64, ptr %v150, i64 0
  %v121 = load i64, ptr %v121.p
  br label %b11
b2:
  %v37 = getelementptr i64, ptr %s2, i64 0
  %v38.p = getelementptr i64, ptr %v27, i64 0
  %v38 = load i64, ptr %v38.p
  %st30 = getelementptr i64, ptr %v37, i64 0
  store i64 %v38, ptr %st30
  %v39.p = getelementptr i64, ptr %v27, i64 1
  %v39 = load i64, ptr %v39.p
  %st31 = getelementptr i64, ptr %v37, i64 1
  store i64 %v39, ptr %st31
  %v40.p = getelementptr i64, ptr %v27, i64 2
  %v40 = load i64, ptr %v40.p
  %st32 = getelementptr i64, ptr %v37, i64 2
  store i64 %v40, ptr %st32
  %v41.p = getelementptr i64, ptr %v37, i64 2
  %v41 = load i64, ptr %v41.p
  %v42.p = getelementptr i64, ptr %v37, i64 0
  %v42 = load i64, ptr %v42.p
  %v43.p = getelementptr i64, ptr %v37, i64 1
  %v43 = load i64, ptr %v43.p
  %v46 = add i64 0, 8
  %v47 = mul i64 %v43, %v46
  %v48 = add i64 %v42, %v47
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %v152 = getelementptr i64, ptr %v151, i64 %v41
  %v49.p = getelementptr i64, ptr %v152, i64 1
  %v49 = load ptr, ptr %v49.p
  %v50 = ptrtoint ptr %v49 to i64
  %v51.c = icmp eq i64 %v50, %v48
  %v51 = zext i1 %v51.c to i64
  %c.b2 = icmp ne i64 %v51, 0
  br i1 %c.b2, label %b2.t34, label %b2.e35
b2.t34:
  br label %b5
b2.e35:
  br label %b4
b3:
  %v44 = phi ptr [ %v61, %b4 ], [ %v55, %b5 ]
  %v45 = phi ptr [ %v63, %b4 ], [ %v54, %b5 ]
  %v65 = add i64 0, 0
  br label %b6
b4:
  %v56 = add i64 0, 1
  %v57 = mul i64 %v43, %v56
  %v58 = add i64 0, 1
  %v59 = mul i64 %v35, %v58
  %v60 = add i64 %v57, %v59
  %v61 = call ptr @"rt.region_alloc"(i64 %v41, i64 %v60)
  %v62 = inttoptr i64 %v42 to ptr
  call void @"rt.copy"(ptr %v61, ptr %v62, i64 %v57)
  %v63 = getelementptr i64, ptr %v61, i64 %v57
  br label %b3
b5:
  %v52 = add i64 0, 1
  %v53 = mul i64 %v35, %v52
  %v54 = call ptr @"rt.region_alloc"(i64 %v41, i64 %v53)
  %v55 = inttoptr i64 %v42 to ptr
  br label %b3
b6:
  %v64 = phi i64 [ %v65, %b3 ], [ %v71, %b7 ]
  %v66.c = icmp slt i64 %v64, %v35
  %v66 = zext i1 %v66.c to i64
  %c.b6 = icmp ne i64 %v66, 0
  br i1 %c.b6, label %b6.t36, label %b6.e37
b6.t36:
  br label %b7
b6.e37:
  br label %b8
b7:
  %v67 = add i64 0, 1
  %v68 = mul i64 %v64, %v67
  %v69 = getelementptr i64, ptr %v45, i64 %v68
  %st37 = getelementptr i64, ptr %v69, i64 0
  store i64 %v34, ptr %st37
  %v70 = add i64 0, 1
  %v71 = add i64 %v64, %v70
  br label %b6
b8:
  %v72.p = getelementptr i64, ptr %v37, i64 1
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 %v72, %v35
  %v74 = getelementptr i64, ptr %s4, i64 0
  %v75 = ptrtoint ptr %v44 to i64
  %st38 = getelementptr i64, ptr %v74, i64 0
  store i64 %v75, ptr %st38
  %st39 = getelementptr i64, ptr %v74, i64 1
  store i64 %v73, ptr %st39
  %st40 = getelementptr i64, ptr %v74, i64 2
  store i64 %v41, ptr %st40
  %v76.p = getelementptr i64, ptr %v74, i64 0
  %v76 = load i64, ptr %v76.p
  %st41 = getelementptr i64, ptr %v27, i64 0
  store i64 %v76, ptr %st41
  %v77.p = getelementptr i64, ptr %v74, i64 1
  %v77 = load i64, ptr %v77.p
  %st42 = getelementptr i64, ptr %v27, i64 1
  store i64 %v77, ptr %st42
  %v78.p = getelementptr i64, ptr %v74, i64 2
  %v78 = load i64, ptr %v78.p
  %st43 = getelementptr i64, ptr %v27, i64 2
  store i64 %v78, ptr %st43
  br label %b1
b9:
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v153, i64 0
  store i64 %v115, ptr %st44
  %v142.p = getelementptr i64, ptr %v111, i64 0
  %v142 = load i64, ptr %v142.p
  %st45 = getelementptr i64, ptr %v0, i64 0
  store i64 %v142, ptr %st45
  %v143.p = getelementptr i64, ptr %v111, i64 1
  %v143 = load i64, ptr %v143.p
  %st46 = getelementptr i64, ptr %v0, i64 1
  store i64 %v143, ptr %st46
  %v144.p = getelementptr i64, ptr %v111, i64 2
  %v144 = load i64, ptr %v144.p
  %st47 = getelementptr i64, ptr %v0, i64 2
  store i64 %v144, ptr %st47
  call void @"rt.region_relocate8"(ptr %v0, i64 %v10)
  %v154 = getelementptr i64, ptr @"rt.meta", i64 0
  %st48 = getelementptr i64, ptr %v154, i64 0
  store i64 %v10, ptr %st48
  ret void
b10:
  br label %b9
b11:
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v155, i64 0
  store i64 %v121, ptr %st49
  %v122.p = getelementptr i64, ptr %v120, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.c = icmp slt i64 %v122, %v117
  %v123 = zext i1 %v123.c to i64
  %c.b11 = icmp ne i64 %v123, 0
  br i1 %c.b11, label %b11.t51, label %b11.e52
b11.t51:
  br label %b12
b11.e52:
  br label %b13
b12:
  call void @"rt.region_enter"()
  %v156 = getelementptr i64, ptr @"rt.meta", i64 0
  %v124.p = getelementptr i64, ptr %v156, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v120, i64 0
  %v125 = load i64, ptr %v125.p
  %v157 = getelementptr i64, ptr @"rt.meta", i64 0
  %v126.p = getelementptr i64, ptr %v157, i64 0
  %v126 = load i64, ptr %v126.p
  %v127 = add i64 0, 1
  %v128 = add i64 %v10, %v127
  %v129.p = getelementptr i64, ptr %v27, i64 1
  %v129 = load i64, ptr %v129.p
  %v130.c = icmp uge i64 %v125, %v129
  %v130 = zext i1 %v130.c to i64
  %c.b12 = icmp ne i64 %v130, 0
  br i1 %c.b12, label %b12.t53, label %b12.e54
b12.t53:
  br label %b15
b12.e54:
  br label %b16
b13:
  %v158 = getelementptr i64, ptr @"rt.meta", i64 0
  %st54 = getelementptr i64, ptr %v158, i64 0
  store i64 %v121, ptr %st54
  br label %b10
b14:
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v159, i64 0
  store i64 %v126, ptr %st55
  %v139 = add i64 0, 1
  %v140.p = getelementptr i64, ptr %v120, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = add i64 %v140, %v139
  %st56 = getelementptr i64, ptr %v120, i64 0
  store i64 %v141, ptr %st56
  br label %b11
b15:
  %v131 = add i64 0, 16
  call void @"rt.panic"(i64 %v131)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v132.p = getelementptr i64, ptr %v27, i64 0
  %v132 = load i64, ptr %v132.p
  %v133 = inttoptr i64 %v132 to ptr
  %v134 = add i64 0, 1
  %v135 = mul i64 %v125, %v134
  %v136 = getelementptr i64, ptr %v133, i64 %v135
  %v137.p = getelementptr i64, ptr %v136, i64 0
  %v137 = load i64, ptr %v137.p
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %st57 = getelementptr i64, ptr %v138, i64 2572
  store i64 %v128, ptr %st57
  call void @"std/crypto/chacha20.put32"(ptr %v111, i64 %v137)
  br label %b14
}

define internal void @"std/crypto/chacha20.XorKeyStream"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10) #0 {
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
  store i64 %v8, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 1
  store i64 %v9, ptr %st7
  %st8 = getelementptr i64, ptr %v13, i64 2
  store i64 %v10, ptr %st8
  %v41 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v41, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v15, i64 2571
  %v16 = load i64, ptr %v16.p
  %v17 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v15, i64 2571
  store i64 %v17, ptr %st9
  %v18 = add i64 0, 1
  %v19.c = icmp sge i64 %v16, %v18
  %v19 = zext i1 %v19.c to i64
  %v20.c = icmp sle i64 %v16, %v14
  %v20 = zext i1 %v20.c to i64
  %v21 = and i64 %v19, %v20
  %v22 = sub i64 %v16, %v14
  %v23 = mul i64 %v21, %v22
  %v24 = add i64 %v14, %v23
  call void @"rt.region_enter"()
  %v25 = getelementptr i64, ptr %s3, i64 0
  %v26.p = getelementptr i64, ptr %v11, i64 0
  %v26 = load i64, ptr %v26.p
  %v27.p = getelementptr i64, ptr %v11, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v11, i64 2
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v12, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v12, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v12, i64 2
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v13, i64 0
  %v32 = load i64, ptr %v32.p
  %v33.p = getelementptr i64, ptr %v13, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.p = getelementptr i64, ptr %v13, i64 2
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 0
  %v36.p = getelementptr i64, ptr %v13, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = getelementptr i64, ptr @"rt.meta", i64 0
  %st10 = getelementptr i64, ptr %v37, i64 2571
  store i64 %v24, ptr %st10
  call void @"std/crypto/chacha20.XorKeyStreamAt"(ptr %v25, i64 %v26, i64 %v27, i64 %v28, i64 %v29, i64 %v30, i64 %v31, i64 %v7, i64 %v32, i64 %v33, i64 %v34, i64 %v35, i64 %v36)
  %v38.p = getelementptr i64, ptr %v25, i64 0
  %v38 = load i64, ptr %v38.p
  %st11 = getelementptr i64, ptr %v0, i64 0
  store i64 %v38, ptr %st11
  %v39.p = getelementptr i64, ptr %v25, i64 1
  %v39 = load i64, ptr %v39.p
  %st12 = getelementptr i64, ptr %v0, i64 1
  store i64 %v39, ptr %st12
  %v40.p = getelementptr i64, ptr %v25, i64 2
  %v40 = load i64, ptr %v40.p
  %st13 = getelementptr i64, ptr %v0, i64 2
  store i64 %v40, ptr %st13
  call void @"rt.region_relocate8"(ptr %v0, i64 %v14)
  %v42 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v42, i64 0
  store i64 %v14, ptr %st14
  ret void
}

define internal void @"std/crypto/chacha20.XorKeyStreamAt"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12) #0 {
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
  %v13 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v13, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v13, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v13, i64 2
  store i64 %v3, ptr %st2
  %v14 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v6, ptr %st5
  %v15 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v15, i64 0
  store i64 %v8, ptr %st6
  %st7 = getelementptr i64, ptr %v15, i64 1
  store i64 %v9, ptr %st7
  %st8 = getelementptr i64, ptr %v15, i64 2
  store i64 %v10, ptr %st8
  %v233 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v233, i64 0
  %v16 = load i64, ptr %v16.p
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %v18.p = getelementptr i64, ptr %v17, i64 2571
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v17, i64 2571
  store i64 %v19, ptr %st9
  %v20 = add i64 0, 1
  %v21.c = icmp sge i64 %v18, %v20
  %v21 = zext i1 %v21.c to i64
  %v22.c = icmp sle i64 %v18, %v16
  %v22 = zext i1 %v22.c to i64
  %v23 = and i64 %v21, %v22
  %v24 = sub i64 %v18, %v16
  %v25 = mul i64 %v23, %v24
  %v26 = add i64 %v16, %v25
  call void @"rt.region_enter"()
  %v27 = add i64 0, 0
  %v28 = call ptr @"rt.region_alloc"(i64 %v26, i64 %v27)
  %v29 = add i64 0, 0
  %v30 = getelementptr i64, ptr %s3, i64 0
  %v31 = ptrtoint ptr %v28 to i64
  %st10 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st10
  %st11 = getelementptr i64, ptr %v30, i64 1
  store i64 %v29, ptr %st11
  %st12 = getelementptr i64, ptr %v30, i64 2
  store i64 %v26, ptr %st12
  %v32 = getelementptr i64, ptr %s4, i64 0
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
  %v36 = add i64 0, 0
  %v37 = add i64 0, 0
  %v38 = add i64 0, 16
  %v39 = add i64 0, 0
  %v40 = sub i64 %v38, %v37
  %v41.c = icmp sle i64 %v40, %v36
  %v41 = zext i1 %v41.c to i64
  %c.b0 = icmp ne i64 %v41, 0
  br i1 %c.b0, label %b0.t17, label %b0.e18
b0.t17:
  br label %b1
b0.e18:
  br label %b2
b1:
  %v234 = getelementptr i64, ptr @"rt.meta", i64 0
  %v84.p = getelementptr i64, ptr %v234, i64 0
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 0
  %v86 = call ptr @"rt.region_alloc"(i64 %v84, i64 %v85)
  %v87 = add i64 0, 0
  %v88 = getelementptr i64, ptr %s5, i64 0
  %v89 = ptrtoint ptr %v86 to i64
  %st18 = getelementptr i64, ptr %v88, i64 0
  store i64 %v89, ptr %st18
  %st19 = getelementptr i64, ptr %v88, i64 1
  store i64 %v87, ptr %st19
  %st20 = getelementptr i64, ptr %v88, i64 2
  store i64 %v84, ptr %st20
  %v90 = getelementptr i64, ptr %s3, i64 0
  %v91.p = getelementptr i64, ptr %v88, i64 0
  %v91 = load i64, ptr %v91.p
  %st21 = getelementptr i64, ptr %v90, i64 0
  store i64 %v91, ptr %st21
  %v92.p = getelementptr i64, ptr %v88, i64 1
  %v92 = load i64, ptr %v92.p
  %st22 = getelementptr i64, ptr %v90, i64 1
  store i64 %v92, ptr %st22
  %v93.p = getelementptr i64, ptr %v88, i64 2
  %v93 = load i64, ptr %v93.p
  %st23 = getelementptr i64, ptr %v90, i64 2
  store i64 %v93, ptr %st23
  %v94 = add i64 0, 1
  %v95 = add i64 %v16, %v94
  %v96.p = getelementptr i64, ptr %v13, i64 0
  %v96 = load i64, ptr %v96.p
  %v97.p = getelementptr i64, ptr %v13, i64 1
  %v97 = load i64, ptr %v97.p
  %v98.p = getelementptr i64, ptr %v13, i64 2
  %v98 = load i64, ptr %v98.p
  %v99.p = getelementptr i64, ptr %v14, i64 0
  %v99 = load i64, ptr %v99.p
  %v100.p = getelementptr i64, ptr %v14, i64 1
  %v100 = load i64, ptr %v100.p
  %v101.p = getelementptr i64, ptr %v14, i64 2
  %v101 = load i64, ptr %v101.p
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v102, i64 2572
  store i64 %v95, ptr %st24
  call void @"std/crypto/chacha20.initState"(ptr %v90, i64 %v96, i64 %v97, i64 %v98, i64 %v99, i64 %v100, i64 %v101)
  %v103 = getelementptr i64, ptr %s5, i64 0
  %v104.p = getelementptr i64, ptr %v90, i64 0
  %v104 = load i64, ptr %v104.p
  %st25 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st25
  %v105.p = getelementptr i64, ptr %v90, i64 1
  %v105 = load i64, ptr %v105.p
  %st26 = getelementptr i64, ptr %v103, i64 1
  store i64 %v105, ptr %st26
  %v106.p = getelementptr i64, ptr %v90, i64 2
  %v106 = load i64, ptr %v106.p
  %st27 = getelementptr i64, ptr %v103, i64 2
  store i64 %v106, ptr %st27
  %v107 = add i64 0, 4294967295
  %v108 = and i64 %v7, %v107
  %v109 = getelementptr i64, ptr %s6, i64 0
  %st28 = getelementptr i64, ptr %v109, i64 0
  store i64 %v108, ptr %st28
  %v110 = add i64 0, 0
  %v111 = call ptr @"rt.region_alloc8"(i64 %v26, i64 %v110)
  %v112 = add i64 0, 0
  %v113 = getelementptr i64, ptr %s7, i64 0
  %v114 = ptrtoint ptr %v111 to i64
  %st29 = getelementptr i64, ptr %v113, i64 0
  store i64 %v114, ptr %st29
  %st30 = getelementptr i64, ptr %v113, i64 1
  store i64 %v112, ptr %st30
  %st31 = getelementptr i64, ptr %v113, i64 2
  store i64 %v26, ptr %st31
  %v115 = getelementptr i64, ptr %s8, i64 0
  %v116.p = getelementptr i64, ptr %v113, i64 0
  %v116 = load i64, ptr %v116.p
  %st32 = getelementptr i64, ptr %v115, i64 0
  store i64 %v116, ptr %st32
  %v117.p = getelementptr i64, ptr %v113, i64 1
  %v117 = load i64, ptr %v117.p
  %st33 = getelementptr i64, ptr %v115, i64 1
  store i64 %v117, ptr %st33
  %v118.p = getelementptr i64, ptr %v113, i64 2
  %v118 = load i64, ptr %v118.p
  %st34 = getelementptr i64, ptr %v115, i64 2
  store i64 %v118, ptr %st34
  %v119 = add i64 0, 0
  %v120 = getelementptr i64, ptr %s9, i64 0
  %st35 = getelementptr i64, ptr %v120, i64 0
  store i64 %v119, ptr %st35
  %v235 = getelementptr i64, ptr @"rt.meta", i64 0
  %v121.p = getelementptr i64, ptr %v235, i64 0
  %v121 = load i64, ptr %v121.p
  br label %b9
b2:
  %v42 = getelementptr i64, ptr %s3, i64 0
  %v43.p = getelementptr i64, ptr %v32, i64 0
  %v43 = load i64, ptr %v43.p
  %st36 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st36
  %v44.p = getelementptr i64, ptr %v32, i64 1
  %v44 = load i64, ptr %v44.p
  %st37 = getelementptr i64, ptr %v42, i64 1
  store i64 %v44, ptr %st37
  %v45.p = getelementptr i64, ptr %v32, i64 2
  %v45 = load i64, ptr %v45.p
  %st38 = getelementptr i64, ptr %v42, i64 2
  store i64 %v45, ptr %st38
  %v46.p = getelementptr i64, ptr %v42, i64 2
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v42, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v42, i64 1
  %v48 = load i64, ptr %v48.p
  %v51 = add i64 0, 8
  %v52 = mul i64 %v48, %v51
  %v53 = add i64 %v47, %v52
  %v236 = getelementptr i64, ptr @"rt.meta", i64 0
  %v237 = getelementptr i64, ptr %v236, i64 %v46
  %v54.p = getelementptr i64, ptr %v237, i64 1
  %v54 = load ptr, ptr %v54.p
  %v55 = ptrtoint ptr %v54 to i64
  %v56.c = icmp eq i64 %v55, %v53
  %v56 = zext i1 %v56.c to i64
  %c.b2 = icmp ne i64 %v56, 0
  br i1 %c.b2, label %b2.t40, label %b2.e41
b2.t40:
  br label %b5
b2.e41:
  br label %b4
b3:
  %v49 = phi ptr [ %v66, %b4 ], [ %v60, %b5 ]
  %v50 = phi ptr [ %v68, %b4 ], [ %v59, %b5 ]
  %v70 = add i64 0, 0
  br label %b6
b4:
  %v61 = add i64 0, 1
  %v62 = mul i64 %v48, %v61
  %v63 = add i64 0, 1
  %v64 = mul i64 %v40, %v63
  %v65 = add i64 %v62, %v64
  %v66 = call ptr @"rt.region_alloc"(i64 %v46, i64 %v65)
  %v67 = inttoptr i64 %v47 to ptr
  call void @"rt.copy"(ptr %v66, ptr %v67, i64 %v62)
  %v68 = getelementptr i64, ptr %v66, i64 %v62
  br label %b3
b5:
  %v57 = add i64 0, 1
  %v58 = mul i64 %v40, %v57
  %v59 = call ptr @"rt.region_alloc"(i64 %v46, i64 %v58)
  %v60 = inttoptr i64 %v47 to ptr
  br label %b3
b6:
  %v69 = phi i64 [ %v70, %b3 ], [ %v76, %b7 ]
  %v71.c = icmp slt i64 %v69, %v40
  %v71 = zext i1 %v71.c to i64
  %c.b6 = icmp ne i64 %v71, 0
  br i1 %c.b6, label %b6.t42, label %b6.e43
b6.t42:
  br label %b7
b6.e43:
  br label %b8
b7:
  %v72 = add i64 0, 1
  %v73 = mul i64 %v69, %v72
  %v74 = getelementptr i64, ptr %v50, i64 %v73
  %st43 = getelementptr i64, ptr %v74, i64 0
  store i64 %v39, ptr %st43
  %v75 = add i64 0, 1
  %v76 = add i64 %v69, %v75
  br label %b6
b8:
  %v77.p = getelementptr i64, ptr %v42, i64 1
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 %v77, %v40
  %v79 = getelementptr i64, ptr %s5, i64 0
  %v80 = ptrtoint ptr %v49 to i64
  %st44 = getelementptr i64, ptr %v79, i64 0
  store i64 %v80, ptr %st44
  %st45 = getelementptr i64, ptr %v79, i64 1
  store i64 %v78, ptr %st45
  %st46 = getelementptr i64, ptr %v79, i64 2
  store i64 %v46, ptr %st46
  %v81.p = getelementptr i64, ptr %v79, i64 0
  %v81 = load i64, ptr %v81.p
  %st47 = getelementptr i64, ptr %v32, i64 0
  store i64 %v81, ptr %st47
  %v82.p = getelementptr i64, ptr %v79, i64 1
  %v82 = load i64, ptr %v82.p
  %st48 = getelementptr i64, ptr %v32, i64 1
  store i64 %v82, ptr %st48
  %v83.p = getelementptr i64, ptr %v79, i64 2
  %v83 = load i64, ptr %v83.p
  %st49 = getelementptr i64, ptr %v32, i64 2
  store i64 %v83, ptr %st49
  br label %b1
b9:
  %v238 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v238, i64 0
  store i64 %v121, ptr %st50
  %v122.p = getelementptr i64, ptr %v120, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.c = icmp slt i64 %v122, %v12
  %v123 = zext i1 %v123.c to i64
  %c.b9 = icmp ne i64 %v123, 0
  br i1 %c.b9, label %b9.t52, label %b9.e53
b9.t52:
  br label %b10
b9.e53:
  br label %b11
b10:
  call void @"rt.region_enter"()
  %v239 = getelementptr i64, ptr @"rt.meta", i64 0
  %v124.p = getelementptr i64, ptr %v239, i64 0
  %v124 = load i64, ptr %v124.p
  %v125 = add i64 0, 1
  %v126 = add i64 %v16, %v125
  %v127.p = getelementptr i64, ptr %v103, i64 0
  %v127 = load i64, ptr %v127.p
  %v128.p = getelementptr i64, ptr %v103, i64 1
  %v128 = load i64, ptr %v128.p
  %v129.p = getelementptr i64, ptr %v103, i64 2
  %v129 = load i64, ptr %v129.p
  %v130.p = getelementptr i64, ptr %v109, i64 0
  %v130 = load i64, ptr %v130.p
  %v131 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v131, i64 2572
  store i64 %v126, ptr %st53
  call void @"std/crypto/chacha20.rounds"(ptr %v32, i64 %v127, i64 %v128, i64 %v129, i64 %v130)
  %v240 = getelementptr i64, ptr @"rt.meta", i64 0
  %v132.p = getelementptr i64, ptr %v240, i64 0
  %v132 = load i64, ptr %v132.p
  %v133 = add i64 0, 0
  %v134 = add i64 0, 64
  %v135 = getelementptr i64, ptr %s10, i64 0
  %v241 = getelementptr i64, ptr @"rt.meta", i64 0
  %v136.p = getelementptr i64, ptr %v241, i64 0
  %v136 = load i64, ptr %v136.p
  %v137 = getelementptr i64, ptr %s11, i64 0
  %st54 = getelementptr i64, ptr %v137, i64 0
  store i64 %v133, ptr %st54
  %v242 = getelementptr i64, ptr @"rt.meta", i64 0
  %v138.p = getelementptr i64, ptr %v242, i64 0
  %v138 = load i64, ptr %v138.p
  br label %b14
b11:
  %v243 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v243, i64 0
  store i64 %v121, ptr %st55
  %v230.p = getelementptr i64, ptr %v115, i64 0
  %v230 = load i64, ptr %v230.p
  %st56 = getelementptr i64, ptr %v0, i64 0
  store i64 %v230, ptr %st56
  %v231.p = getelementptr i64, ptr %v115, i64 1
  %v231 = load i64, ptr %v231.p
  %st57 = getelementptr i64, ptr %v0, i64 1
  store i64 %v231, ptr %st57
  %v232.p = getelementptr i64, ptr %v115, i64 2
  %v232 = load i64, ptr %v232.p
  %st58 = getelementptr i64, ptr %v0, i64 2
  store i64 %v232, ptr %st58
  call void @"rt.region_relocate8"(ptr %v0, i64 %v16)
  %v244 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v244, i64 0
  store i64 %v16, ptr %st59
  ret void
b12:
  %v245 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v245, i64 0
  store i64 %v132, ptr %st60
  %v218 = add i64 0, 1
  %v219 = add i64 %v16, %v218
  %v220.p = getelementptr i64, ptr %v109, i64 0
  %v220 = load i64, ptr %v220.p
  %v221 = add i64 0, 1
  %v222 = add i64 %v220, %v221
  %v223 = add i64 0, 4294967295
  %v224 = and i64 %v222, %v223
  %st61 = getelementptr i64, ptr %v109, i64 0
  store i64 %v224, ptr %st61
  %v225 = add i64 0, 1
  %v226 = add i64 %v16, %v225
  %v227.p = getelementptr i64, ptr %v120, i64 0
  %v227 = load i64, ptr %v227.p
  %v228 = add i64 0, 64
  %v229 = add i64 %v227, %v228
  %st62 = getelementptr i64, ptr %v120, i64 0
  store i64 %v229, ptr %st62
  br label %b9
b13:
  br label %b12
b14:
  %v246 = getelementptr i64, ptr @"rt.meta", i64 0
  %st63 = getelementptr i64, ptr %v246, i64 0
  store i64 %v138, ptr %st63
  %v139.p = getelementptr i64, ptr %v137, i64 0
  %v139 = load i64, ptr %v139.p
  %v140.c = icmp slt i64 %v139, %v134
  %v140 = zext i1 %v140.c to i64
  %c.b14 = icmp ne i64 %v140, 0
  br i1 %c.b14, label %b14.t65, label %b14.e66
b14.t65:
  br label %b15
b14.e66:
  br label %b16
b15:
  call void @"rt.region_enter"()
  %v247 = getelementptr i64, ptr @"rt.meta", i64 0
  %v141.p = getelementptr i64, ptr %v247, i64 0
  %v141 = load i64, ptr %v141.p
  %v142.p = getelementptr i64, ptr %v137, i64 0
  %v142 = load i64, ptr %v142.p
  %v248 = getelementptr i64, ptr @"rt.meta", i64 0
  %v143.p = getelementptr i64, ptr %v248, i64 0
  %v143 = load i64, ptr %v143.p
  %v144.p = getelementptr i64, ptr %v120, i64 0
  %v144 = load i64, ptr %v144.p
  %v145 = add i64 %v144, %v142
  %v146.c = icmp slt i64 %v145, %v12
  %v146 = zext i1 %v146.c to i64
  %c.b15 = icmp ne i64 %v146, 0
  br i1 %c.b15, label %b15.t67, label %b15.e68
b15.t67:
  br label %b18
b15.e68:
  br label %b19
b16:
  %v249 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v249, i64 0
  store i64 %v138, ptr %st68
  br label %b13
b17:
  %v250 = getelementptr i64, ptr @"rt.meta", i64 0
  %st69 = getelementptr i64, ptr %v250, i64 0
  store i64 %v143, ptr %st69
  %v215 = add i64 0, 1
  %v216.p = getelementptr i64, ptr %v137, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = add i64 %v216, %v215
  %st70 = getelementptr i64, ptr %v137, i64 0
  store i64 %v217, ptr %st70
  br label %b14
b18:
  %v147 = add i64 0, 4
  %v148 = sdiv i64 %v142, %v147
  %v149.p = getelementptr i64, ptr %v32, i64 1
  %v149 = load i64, ptr %v149.p
  %v150.c = icmp uge i64 %v148, %v149
  %v150 = zext i1 %v150.c to i64
  %c.b18 = icmp ne i64 %v150, 0
  br i1 %c.b18, label %b18.t72, label %b18.e73
b18.t72:
  br label %b20
b18.e73:
  br label %b21
b19:
  br label %b34
b20:
  %v151 = add i64 0, 17
  call void @"rt.panic"(i64 %v151)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v152.p = getelementptr i64, ptr %v32, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = inttoptr i64 %v152 to ptr
  %v154 = add i64 0, 1
  %v155 = mul i64 %v148, %v154
  %v156 = getelementptr i64, ptr %v153, i64 %v155
  %v157.p = getelementptr i64, ptr %v156, i64 0
  %v157 = load i64, ptr %v157.p
  %v158 = add i64 0, 1
  %v159 = add i64 %v16, %v158
  %v160 = getelementptr i64, ptr %s7, i64 0
  %v161.p = getelementptr i64, ptr %v115, i64 0
  %v161 = load i64, ptr %v161.p
  %st73 = getelementptr i64, ptr %v160, i64 0
  store i64 %v161, ptr %st73
  %v162.p = getelementptr i64, ptr %v115, i64 1
  %v162 = load i64, ptr %v162.p
  %st74 = getelementptr i64, ptr %v160, i64 1
  store i64 %v162, ptr %st74
  %v163.p = getelementptr i64, ptr %v115, i64 2
  %v163 = load i64, ptr %v163.p
  %st75 = getelementptr i64, ptr %v160, i64 2
  store i64 %v163, ptr %st75
  %v164.p = getelementptr i64, ptr %v120, i64 0
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 %v11, %v164
  %v166 = add i64 %v165, %v142
  %v167.p = getelementptr i64, ptr %v15, i64 1
  %v167 = load i64, ptr %v167.p
  %v168.c = icmp uge i64 %v166, %v167
  %v168 = zext i1 %v168.c to i64
  %c.b21 = icmp ne i64 %v168, 0
  br i1 %c.b21, label %b21.t77, label %b21.e78
b21.t77:
  br label %b22
b21.e78:
  br label %b23
b22:
  %v169 = add i64 0, 18
  call void @"rt.panic"(i64 %v169)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v170.p = getelementptr i64, ptr %v15, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = inttoptr i64 %v170 to ptr
  %v172 = getelementptr i8, ptr %v171, i64 %v166
  %v173.p = getelementptr i8, ptr %v172, i64 0
  %v173.b = load i8, ptr %v173.p
  %v173 = zext i8 %v173.b to i64
  %v174 = add i64 0, 8
  %v175 = add i64 0, 4
  %v176 = srem i64 %v142, %v175
  %v177 = mul i64 %v174, %v176
  %v179 = add i64 0, 0
  %v180.c = icmp slt i64 %v177, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b23 = icmp ne i64 %v180, 0
  br i1 %c.b23, label %b23.t79, label %b23.e80
b23.t79:
  br label %b24
b23.e80:
  br label %b25
b24:
  %v181 = add i64 0, 19
  call void @"rt.panic"(i64 %v181)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b25:
  %v182 = add i64 0, 63
  %v183.c = icmp sgt i64 %v177, %v182
  %v183 = zext i1 %v183.c to i64
  %c.b25 = icmp ne i64 %v183, 0
  br i1 %c.b25, label %b25.t81, label %b25.e82
b25.t81:
  br label %b27
b25.e82:
  br label %b28
b26:
  %v178 = phi i64 [ %v185, %b27 ], [ %v186, %b28 ]
  %v187 = add i64 0, 255
  %v188 = and i64 %v178, %v187
  %v189 = xor i64 %v173, %v188
  %v190 = add i64 0, 256
  %v191.c = icmp uge i64 %v189, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b26 = icmp ne i64 %v191, 0
  br i1 %c.b26, label %b26.t83, label %b26.e84
b26.t83:
  br label %b29
b26.e84:
  br label %b30
b27:
  %v184 = add i64 0, 63
  %v185.n = and i64 %v184, 63
  %v185 = ashr i64 %v157, %v185.n
  br label %b26
b28:
  %v186.n = and i64 %v177, 63
  %v186 = ashr i64 %v157, %v186.n
  br label %b26
b29:
  %v192 = add i64 0, 20
  call void @"rt.panic"(i64 %v192)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v193.p = getelementptr i64, ptr %v160, i64 2
  %v193 = load i64, ptr %v193.p
  %v194.p = getelementptr i64, ptr %v160, i64 0
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v160, i64 1
  %v195 = load i64, ptr %v195.p
  %v198 = add i64 %v194, %v195
  %v199 = call i64 @"rt.tip8"(i64 %v193, i64 %v198)
  %v200 = add i64 0, 0
  %v201.c = icmp ne i64 %v199, %v200
  %v201 = zext i1 %v201.c to i64
  %c.b30 = icmp ne i64 %v201, 0
  br i1 %c.b30, label %b30.t85, label %b30.e86
b30.t85:
  br label %b33
b30.e86:
  br label %b32
b31:
  %v196 = phi ptr [ %v205, %b32 ], [ %v202, %b33 ]
  %v197 = phi ptr [ %v206, %b32 ], [ %v203, %b33 ]
  %st86 = getelementptr i8, ptr %v197, i64 0
  %st86.b = trunc i64 %v189 to i8
  store i8 %st86.b, ptr %st86
  %v207.p = getelementptr i64, ptr %v160, i64 1
  %v207 = load i64, ptr %v207.p
  %v208 = add i64 0, 1
  %v209 = add i64 %v207, %v208
  %v210 = getelementptr i64, ptr %s12, i64 0
  %v211 = ptrtoint ptr %v196 to i64
  %st87 = getelementptr i64, ptr %v210, i64 0
  store i64 %v211, ptr %st87
  %st88 = getelementptr i64, ptr %v210, i64 1
  store i64 %v209, ptr %st88
  %st89 = getelementptr i64, ptr %v210, i64 2
  store i64 %v193, ptr %st89
  %v212.p = getelementptr i64, ptr %v210, i64 0
  %v212 = load i64, ptr %v212.p
  %st90 = getelementptr i64, ptr %v115, i64 0
  store i64 %v212, ptr %st90
  %v213.p = getelementptr i64, ptr %v210, i64 1
  %v213 = load i64, ptr %v213.p
  %st91 = getelementptr i64, ptr %v115, i64 1
  store i64 %v213, ptr %st91
  %v214.p = getelementptr i64, ptr %v210, i64 2
  %v214 = load i64, ptr %v214.p
  %st92 = getelementptr i64, ptr %v115, i64 2
  store i64 %v214, ptr %st92
  br label %b34
b32:
  %v204 = add i64 0, 1
  %v205 = call ptr @"rt.slice_grow8"(i64 %v194, i64 %v195, i64 %v193, i64 %v204)
  %v206 = getelementptr i8, ptr %v205, i64 %v195
  br label %b31
b33:
  %v202 = inttoptr i64 %v194 to ptr
  %v203 = getelementptr i8, ptr %v202, i64 %v195
  br label %b31
b34:
  br label %b17
}

define internal void @"std/crypto/chacha20.initState"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v287 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v287, i64 0
  %v9 = load i64, ptr %v9.p
  %v10 = getelementptr i64, ptr @"rt.meta", i64 0
  %v11.p = getelementptr i64, ptr %v10, i64 2572
  %v11 = load i64, ptr %v11.p
  %v12 = add i64 0, 0
  %v13.c = icmp eq i64 %v11, %v12
  %v13 = zext i1 %v13.c to i64
  %v14 = mul i64 %v13, %v9
  %v15 = add i64 %v11, %v14
  %v16 = getelementptr i64, ptr %s2, i64 0
  %v17.p = getelementptr i64, ptr %v0, i64 0
  %v17 = load i64, ptr %v17.p
  %st6 = getelementptr i64, ptr %v16, i64 0
  store i64 %v17, ptr %st6
  %v18.p = getelementptr i64, ptr %v0, i64 1
  %v18 = load i64, ptr %v18.p
  %st7 = getelementptr i64, ptr %v16, i64 1
  store i64 %v18, ptr %st7
  %v19.p = getelementptr i64, ptr %v0, i64 2
  %v19 = load i64, ptr %v19.p
  %st8 = getelementptr i64, ptr %v16, i64 2
  store i64 %v19, ptr %st8
  %v20 = add i64 0, 1634760805
  %v21.p = getelementptr i64, ptr %v16, i64 2
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v16, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v16, i64 1
  %v23 = load i64, ptr %v23.p
  %v26 = add i64 0, 8
  %v27 = mul i64 %v23, %v26
  %v28 = add i64 %v22, %v27
  %v288 = getelementptr i64, ptr @"rt.meta", i64 0
  %v289 = getelementptr i64, ptr %v288, i64 %v21
  %v29.p = getelementptr i64, ptr %v289, i64 1
  %v29 = load ptr, ptr %v29.p
  %v30 = ptrtoint ptr %v29 to i64
  %v31.c = icmp eq i64 %v30, %v28
  %v31 = zext i1 %v31.c to i64
  %c.b0 = icmp ne i64 %v31, 0
  br i1 %c.b0, label %b0.t10, label %b0.e11
b0.t10:
  br label %b3
b0.e11:
  br label %b2
b1:
  %v24 = phi ptr [ %v39, %b2 ], [ %v34, %b3 ]
  %v25 = phi ptr [ %v40, %b2 ], [ %v33, %b3 ]
  %st11 = getelementptr i64, ptr %v25, i64 0
  store i64 %v20, ptr %st11
  %v41.p = getelementptr i64, ptr %v16, i64 1
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 1
  %v43 = add i64 %v41, %v42
  %v44 = getelementptr i64, ptr %s3, i64 0
  %v45 = ptrtoint ptr %v24 to i64
  %st12 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st12
  %st13 = getelementptr i64, ptr %v44, i64 1
  store i64 %v43, ptr %st13
  %st14 = getelementptr i64, ptr %v44, i64 2
  store i64 %v21, ptr %st14
  %v46.p = getelementptr i64, ptr %v44, i64 0
  %v46 = load i64, ptr %v46.p
  %st15 = getelementptr i64, ptr %v0, i64 0
  store i64 %v46, ptr %st15
  %v47.p = getelementptr i64, ptr %v44, i64 1
  %v47 = load i64, ptr %v47.p
  %st16 = getelementptr i64, ptr %v0, i64 1
  store i64 %v47, ptr %st16
  %v48.p = getelementptr i64, ptr %v44, i64 2
  %v48 = load i64, ptr %v48.p
  %st17 = getelementptr i64, ptr %v0, i64 2
  store i64 %v48, ptr %st17
  %v49 = getelementptr i64, ptr %s3, i64 0
  %v50.p = getelementptr i64, ptr %v0, i64 0
  %v50 = load i64, ptr %v50.p
  %st18 = getelementptr i64, ptr %v49, i64 0
  store i64 %v50, ptr %st18
  %v51.p = getelementptr i64, ptr %v0, i64 1
  %v51 = load i64, ptr %v51.p
  %st19 = getelementptr i64, ptr %v49, i64 1
  store i64 %v51, ptr %st19
  %v52.p = getelementptr i64, ptr %v0, i64 2
  %v52 = load i64, ptr %v52.p
  %st20 = getelementptr i64, ptr %v49, i64 2
  store i64 %v52, ptr %st20
  %v53 = add i64 0, 857760878
  %v54.p = getelementptr i64, ptr %v49, i64 2
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v49, i64 0
  %v55 = load i64, ptr %v55.p
  %v56.p = getelementptr i64, ptr %v49, i64 1
  %v56 = load i64, ptr %v56.p
  %v59 = add i64 0, 8
  %v60 = mul i64 %v56, %v59
  %v61 = add i64 %v55, %v60
  %v290 = getelementptr i64, ptr @"rt.meta", i64 0
  %v291 = getelementptr i64, ptr %v290, i64 %v54
  %v62.p = getelementptr i64, ptr %v291, i64 1
  %v62 = load ptr, ptr %v62.p
  %v63 = ptrtoint ptr %v62 to i64
  %v64.c = icmp eq i64 %v63, %v61
  %v64 = zext i1 %v64.c to i64
  %c.b1 = icmp ne i64 %v64, 0
  br i1 %c.b1, label %b1.t22, label %b1.e23
b1.t22:
  br label %b6
b1.e23:
  br label %b5
b2:
  %v35 = add i64 0, 1
  %v36 = mul i64 %v23, %v35
  %v37 = add i64 0, 1
  %v38 = add i64 0, 1
  %v39 = call ptr @"rt.slice_grow"(i64 %v22, i64 %v23, i64 %v37, i64 %v21, i64 %v38)
  %v40 = getelementptr i64, ptr %v39, i64 %v36
  br label %b1
b3:
  %v32 = add i64 0, 1
  %v33 = call ptr @"rt.region_alloc"(i64 %v21, i64 %v32)
  %v34 = inttoptr i64 %v22 to ptr
  br label %b1
b4:
  %v57 = phi ptr [ %v72, %b5 ], [ %v67, %b6 ]
  %v58 = phi ptr [ %v73, %b5 ], [ %v66, %b6 ]
  %st23 = getelementptr i64, ptr %v58, i64 0
  store i64 %v53, ptr %st23
  %v74.p = getelementptr i64, ptr %v49, i64 1
  %v74 = load i64, ptr %v74.p
  %v75 = add i64 0, 1
  %v76 = add i64 %v74, %v75
  %v77 = getelementptr i64, ptr %s2, i64 0
  %v78 = ptrtoint ptr %v57 to i64
  %st24 = getelementptr i64, ptr %v77, i64 0
  store i64 %v78, ptr %st24
  %st25 = getelementptr i64, ptr %v77, i64 1
  store i64 %v76, ptr %st25
  %st26 = getelementptr i64, ptr %v77, i64 2
  store i64 %v54, ptr %st26
  %v79.p = getelementptr i64, ptr %v77, i64 0
  %v79 = load i64, ptr %v79.p
  %st27 = getelementptr i64, ptr %v0, i64 0
  store i64 %v79, ptr %st27
  %v80.p = getelementptr i64, ptr %v77, i64 1
  %v80 = load i64, ptr %v80.p
  %st28 = getelementptr i64, ptr %v0, i64 1
  store i64 %v80, ptr %st28
  %v81.p = getelementptr i64, ptr %v77, i64 2
  %v81 = load i64, ptr %v81.p
  %st29 = getelementptr i64, ptr %v0, i64 2
  store i64 %v81, ptr %st29
  %v82 = getelementptr i64, ptr %s2, i64 0
  %v83.p = getelementptr i64, ptr %v0, i64 0
  %v83 = load i64, ptr %v83.p
  %st30 = getelementptr i64, ptr %v82, i64 0
  store i64 %v83, ptr %st30
  %v84.p = getelementptr i64, ptr %v0, i64 1
  %v84 = load i64, ptr %v84.p
  %st31 = getelementptr i64, ptr %v82, i64 1
  store i64 %v84, ptr %st31
  %v85.p = getelementptr i64, ptr %v0, i64 2
  %v85 = load i64, ptr %v85.p
  %st32 = getelementptr i64, ptr %v82, i64 2
  store i64 %v85, ptr %st32
  %v86 = add i64 0, 2036477234
  %v87.p = getelementptr i64, ptr %v82, i64 2
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v82, i64 0
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v82, i64 1
  %v89 = load i64, ptr %v89.p
  %v92 = add i64 0, 8
  %v93 = mul i64 %v89, %v92
  %v94 = add i64 %v88, %v93
  %v292 = getelementptr i64, ptr @"rt.meta", i64 0
  %v293 = getelementptr i64, ptr %v292, i64 %v87
  %v95.p = getelementptr i64, ptr %v293, i64 1
  %v95 = load ptr, ptr %v95.p
  %v96 = ptrtoint ptr %v95 to i64
  %v97.c = icmp eq i64 %v96, %v94
  %v97 = zext i1 %v97.c to i64
  %c.b4 = icmp ne i64 %v97, 0
  br i1 %c.b4, label %b4.t34, label %b4.e35
b4.t34:
  br label %b9
b4.e35:
  br label %b8
b5:
  %v68 = add i64 0, 1
  %v69 = mul i64 %v56, %v68
  %v70 = add i64 0, 1
  %v71 = add i64 0, 1
  %v72 = call ptr @"rt.slice_grow"(i64 %v55, i64 %v56, i64 %v70, i64 %v54, i64 %v71)
  %v73 = getelementptr i64, ptr %v72, i64 %v69
  br label %b4
b6:
  %v65 = add i64 0, 1
  %v66 = call ptr @"rt.region_alloc"(i64 %v54, i64 %v65)
  %v67 = inttoptr i64 %v55 to ptr
  br label %b4
b7:
  %v90 = phi ptr [ %v105, %b8 ], [ %v100, %b9 ]
  %v91 = phi ptr [ %v106, %b8 ], [ %v99, %b9 ]
  %st35 = getelementptr i64, ptr %v91, i64 0
  store i64 %v86, ptr %st35
  %v107.p = getelementptr i64, ptr %v82, i64 1
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 0, 1
  %v109 = add i64 %v107, %v108
  %v110 = getelementptr i64, ptr %s3, i64 0
  %v111 = ptrtoint ptr %v90 to i64
  %st36 = getelementptr i64, ptr %v110, i64 0
  store i64 %v111, ptr %st36
  %st37 = getelementptr i64, ptr %v110, i64 1
  store i64 %v109, ptr %st37
  %st38 = getelementptr i64, ptr %v110, i64 2
  store i64 %v87, ptr %st38
  %v112.p = getelementptr i64, ptr %v110, i64 0
  %v112 = load i64, ptr %v112.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v112, ptr %st39
  %v113.p = getelementptr i64, ptr %v110, i64 1
  %v113 = load i64, ptr %v113.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v113, ptr %st40
  %v114.p = getelementptr i64, ptr %v110, i64 2
  %v114 = load i64, ptr %v114.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v114, ptr %st41
  %v115 = getelementptr i64, ptr %s3, i64 0
  %v116.p = getelementptr i64, ptr %v0, i64 0
  %v116 = load i64, ptr %v116.p
  %st42 = getelementptr i64, ptr %v115, i64 0
  store i64 %v116, ptr %st42
  %v117.p = getelementptr i64, ptr %v0, i64 1
  %v117 = load i64, ptr %v117.p
  %st43 = getelementptr i64, ptr %v115, i64 1
  store i64 %v117, ptr %st43
  %v118.p = getelementptr i64, ptr %v0, i64 2
  %v118 = load i64, ptr %v118.p
  %st44 = getelementptr i64, ptr %v115, i64 2
  store i64 %v118, ptr %st44
  %v119 = add i64 0, 1797285236
  %v120.p = getelementptr i64, ptr %v115, i64 2
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v115, i64 0
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v115, i64 1
  %v122 = load i64, ptr %v122.p
  %v125 = add i64 0, 8
  %v126 = mul i64 %v122, %v125
  %v127 = add i64 %v121, %v126
  %v294 = getelementptr i64, ptr @"rt.meta", i64 0
  %v295 = getelementptr i64, ptr %v294, i64 %v120
  %v128.p = getelementptr i64, ptr %v295, i64 1
  %v128 = load ptr, ptr %v128.p
  %v129 = ptrtoint ptr %v128 to i64
  %v130.c = icmp eq i64 %v129, %v127
  %v130 = zext i1 %v130.c to i64
  %c.b7 = icmp ne i64 %v130, 0
  br i1 %c.b7, label %b7.t46, label %b7.e47
b7.t46:
  br label %b12
b7.e47:
  br label %b11
b8:
  %v101 = add i64 0, 1
  %v102 = mul i64 %v89, %v101
  %v103 = add i64 0, 1
  %v104 = add i64 0, 1
  %v105 = call ptr @"rt.slice_grow"(i64 %v88, i64 %v89, i64 %v103, i64 %v87, i64 %v104)
  %v106 = getelementptr i64, ptr %v105, i64 %v102
  br label %b7
b9:
  %v98 = add i64 0, 1
  %v99 = call ptr @"rt.region_alloc"(i64 %v87, i64 %v98)
  %v100 = inttoptr i64 %v88 to ptr
  br label %b7
b10:
  %v123 = phi ptr [ %v138, %b11 ], [ %v133, %b12 ]
  %v124 = phi ptr [ %v139, %b11 ], [ %v132, %b12 ]
  %st47 = getelementptr i64, ptr %v124, i64 0
  store i64 %v119, ptr %st47
  %v140.p = getelementptr i64, ptr %v115, i64 1
  %v140 = load i64, ptr %v140.p
  %v141 = add i64 0, 1
  %v142 = add i64 %v140, %v141
  %v143 = getelementptr i64, ptr %s2, i64 0
  %v144 = ptrtoint ptr %v123 to i64
  %st48 = getelementptr i64, ptr %v143, i64 0
  store i64 %v144, ptr %st48
  %st49 = getelementptr i64, ptr %v143, i64 1
  store i64 %v142, ptr %st49
  %st50 = getelementptr i64, ptr %v143, i64 2
  store i64 %v120, ptr %st50
  %v145.p = getelementptr i64, ptr %v143, i64 0
  %v145 = load i64, ptr %v145.p
  %st51 = getelementptr i64, ptr %v0, i64 0
  store i64 %v145, ptr %st51
  %v146.p = getelementptr i64, ptr %v143, i64 1
  %v146 = load i64, ptr %v146.p
  %st52 = getelementptr i64, ptr %v0, i64 1
  store i64 %v146, ptr %st52
  %v147.p = getelementptr i64, ptr %v143, i64 2
  %v147 = load i64, ptr %v147.p
  %st53 = getelementptr i64, ptr %v0, i64 2
  store i64 %v147, ptr %st53
  %v296 = getelementptr i64, ptr @"rt.meta", i64 0
  %v148.p = getelementptr i64, ptr %v296, i64 0
  %v148 = load i64, ptr %v148.p
  %v149 = add i64 0, 0
  %v150 = add i64 0, 8
  %v151 = getelementptr i64, ptr %s4, i64 0
  %v297 = getelementptr i64, ptr @"rt.meta", i64 0
  %v152.p = getelementptr i64, ptr %v297, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = getelementptr i64, ptr %s5, i64 0
  %st54 = getelementptr i64, ptr %v153, i64 0
  store i64 %v149, ptr %st54
  %v298 = getelementptr i64, ptr @"rt.meta", i64 0
  %v154.p = getelementptr i64, ptr %v298, i64 0
  %v154 = load i64, ptr %v154.p
  br label %b15
b11:
  %v134 = add i64 0, 1
  %v135 = mul i64 %v122, %v134
  %v136 = add i64 0, 1
  %v137 = add i64 0, 1
  %v138 = call ptr @"rt.slice_grow"(i64 %v121, i64 %v122, i64 %v136, i64 %v120, i64 %v137)
  %v139 = getelementptr i64, ptr %v138, i64 %v135
  br label %b10
b12:
  %v131 = add i64 0, 1
  %v132 = call ptr @"rt.region_alloc"(i64 %v120, i64 %v131)
  %v133 = inttoptr i64 %v121 to ptr
  br label %b10
b13:
  %v299 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v299, i64 0
  store i64 %v148, ptr %st55
  %v201 = getelementptr i64, ptr %s3, i64 0
  %v202.p = getelementptr i64, ptr %v0, i64 0
  %v202 = load i64, ptr %v202.p
  %st56 = getelementptr i64, ptr %v201, i64 0
  store i64 %v202, ptr %st56
  %v203.p = getelementptr i64, ptr %v0, i64 1
  %v203 = load i64, ptr %v203.p
  %st57 = getelementptr i64, ptr %v201, i64 1
  store i64 %v203, ptr %st57
  %v204.p = getelementptr i64, ptr %v0, i64 2
  %v204 = load i64, ptr %v204.p
  %st58 = getelementptr i64, ptr %v201, i64 2
  store i64 %v204, ptr %st58
  %v205 = add i64 0, 0
  %v206.p = getelementptr i64, ptr %v201, i64 2
  %v206 = load i64, ptr %v206.p
  %v207.p = getelementptr i64, ptr %v201, i64 0
  %v207 = load i64, ptr %v207.p
  %v208.p = getelementptr i64, ptr %v201, i64 1
  %v208 = load i64, ptr %v208.p
  %v211 = add i64 0, 8
  %v212 = mul i64 %v208, %v211
  %v213 = add i64 %v207, %v212
  %v300 = getelementptr i64, ptr @"rt.meta", i64 0
  %v301 = getelementptr i64, ptr %v300, i64 %v206
  %v214.p = getelementptr i64, ptr %v301, i64 1
  %v214 = load ptr, ptr %v214.p
  %v215 = ptrtoint ptr %v214 to i64
  %v216.c = icmp eq i64 %v215, %v213
  %v216 = zext i1 %v216.c to i64
  %c.b13 = icmp ne i64 %v216, 0
  br i1 %c.b13, label %b13.t60, label %b13.e61
b13.t60:
  br label %b24
b13.e61:
  br label %b23
b14:
  br label %b13
b15:
  %v302 = getelementptr i64, ptr @"rt.meta", i64 0
  %st61 = getelementptr i64, ptr %v302, i64 0
  store i64 %v154, ptr %st61
  %v155.p = getelementptr i64, ptr %v153, i64 0
  %v155 = load i64, ptr %v155.p
  %v156.c = icmp slt i64 %v155, %v150
  %v156 = zext i1 %v156.c to i64
  %c.b15 = icmp ne i64 %v156, 0
  br i1 %c.b15, label %b15.t63, label %b15.e64
b15.t63:
  br label %b16
b15.e64:
  br label %b17
b16:
  call void @"rt.region_enter"()
  %v303 = getelementptr i64, ptr @"rt.meta", i64 0
  %v157.p = getelementptr i64, ptr %v303, i64 0
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v153, i64 0
  %v158 = load i64, ptr %v158.p
  %v304 = getelementptr i64, ptr @"rt.meta", i64 0
  %v159.p = getelementptr i64, ptr %v304, i64 0
  %v159 = load i64, ptr %v159.p
  %v160 = getelementptr i64, ptr %s2, i64 0
  %v161.p = getelementptr i64, ptr %v0, i64 0
  %v161 = load i64, ptr %v161.p
  %st64 = getelementptr i64, ptr %v160, i64 0
  store i64 %v161, ptr %st64
  %v162.p = getelementptr i64, ptr %v0, i64 1
  %v162 = load i64, ptr %v162.p
  %st65 = getelementptr i64, ptr %v160, i64 1
  store i64 %v162, ptr %st65
  %v163.p = getelementptr i64, ptr %v0, i64 2
  %v163 = load i64, ptr %v163.p
  %st66 = getelementptr i64, ptr %v160, i64 2
  store i64 %v163, ptr %st66
  %v164.p = getelementptr i64, ptr %v7, i64 0
  %v164 = load i64, ptr %v164.p
  %v165.p = getelementptr i64, ptr %v7, i64 1
  %v165 = load i64, ptr %v165.p
  %v166.p = getelementptr i64, ptr %v7, i64 2
  %v166 = load i64, ptr %v166.p
  %v167 = add i64 0, 4
  %v168 = mul i64 %v167, %v158
  %v169 = call i64 @"std/crypto/chacha20.le32"(i64 %v164, i64 %v165, i64 %v166, i64 %v168)
  %v170.p = getelementptr i64, ptr %v160, i64 2
  %v170 = load i64, ptr %v170.p
  %v171.p = getelementptr i64, ptr %v160, i64 0
  %v171 = load i64, ptr %v171.p
  %v172.p = getelementptr i64, ptr %v160, i64 1
  %v172 = load i64, ptr %v172.p
  %v175 = add i64 0, 8
  %v176 = mul i64 %v172, %v175
  %v177 = add i64 %v171, %v176
  %v305 = getelementptr i64, ptr @"rt.meta", i64 0
  %v306 = getelementptr i64, ptr %v305, i64 %v170
  %v178.p = getelementptr i64, ptr %v306, i64 1
  %v178 = load ptr, ptr %v178.p
  %v179 = ptrtoint ptr %v178 to i64
  %v180.c = icmp eq i64 %v179, %v177
  %v180 = zext i1 %v180.c to i64
  %c.b16 = icmp ne i64 %v180, 0
  br i1 %c.b16, label %b16.t68, label %b16.e69
b16.t68:
  br label %b21
b16.e69:
  br label %b20
b17:
  %v307 = getelementptr i64, ptr @"rt.meta", i64 0
  %st69 = getelementptr i64, ptr %v307, i64 0
  store i64 %v154, ptr %st69
  br label %b14
b18:
  %v308 = getelementptr i64, ptr @"rt.meta", i64 0
  %st70 = getelementptr i64, ptr %v308, i64 0
  store i64 %v159, ptr %st70
  %v198 = add i64 0, 1
  %v199.p = getelementptr i64, ptr %v153, i64 0
  %v199 = load i64, ptr %v199.p
  %v200 = add i64 %v199, %v198
  %st71 = getelementptr i64, ptr %v153, i64 0
  store i64 %v200, ptr %st71
  br label %b15
b19:
  %v173 = phi ptr [ %v188, %b20 ], [ %v183, %b21 ]
  %v174 = phi ptr [ %v189, %b20 ], [ %v182, %b21 ]
  %st72 = getelementptr i64, ptr %v174, i64 0
  store i64 %v169, ptr %st72
  %v190.p = getelementptr i64, ptr %v160, i64 1
  %v190 = load i64, ptr %v190.p
  %v191 = add i64 0, 1
  %v192 = add i64 %v190, %v191
  %v193 = getelementptr i64, ptr %s3, i64 0
  %v194 = ptrtoint ptr %v173 to i64
  %st73 = getelementptr i64, ptr %v193, i64 0
  store i64 %v194, ptr %st73
  %st74 = getelementptr i64, ptr %v193, i64 1
  store i64 %v192, ptr %st74
  %st75 = getelementptr i64, ptr %v193, i64 2
  store i64 %v170, ptr %st75
  %v195.p = getelementptr i64, ptr %v193, i64 0
  %v195 = load i64, ptr %v195.p
  %st76 = getelementptr i64, ptr %v0, i64 0
  store i64 %v195, ptr %st76
  %v196.p = getelementptr i64, ptr %v193, i64 1
  %v196 = load i64, ptr %v196.p
  %st77 = getelementptr i64, ptr %v0, i64 1
  store i64 %v196, ptr %st77
  %v197.p = getelementptr i64, ptr %v193, i64 2
  %v197 = load i64, ptr %v197.p
  %st78 = getelementptr i64, ptr %v0, i64 2
  store i64 %v197, ptr %st78
  br label %b18
b20:
  %v184 = add i64 0, 1
  %v185 = mul i64 %v172, %v184
  %v186 = add i64 0, 1
  %v187 = add i64 0, 1
  %v188 = call ptr @"rt.slice_grow"(i64 %v171, i64 %v172, i64 %v186, i64 %v170, i64 %v187)
  %v189 = getelementptr i64, ptr %v188, i64 %v185
  br label %b19
b21:
  %v181 = add i64 0, 1
  %v182 = call ptr @"rt.region_alloc"(i64 %v170, i64 %v181)
  %v183 = inttoptr i64 %v171 to ptr
  br label %b19
b22:
  %v209 = phi ptr [ %v224, %b23 ], [ %v219, %b24 ]
  %v210 = phi ptr [ %v225, %b23 ], [ %v218, %b24 ]
  %st79 = getelementptr i64, ptr %v210, i64 0
  store i64 %v205, ptr %st79
  %v226.p = getelementptr i64, ptr %v201, i64 1
  %v226 = load i64, ptr %v226.p
  %v227 = add i64 0, 1
  %v228 = add i64 %v226, %v227
  %v229 = getelementptr i64, ptr %s2, i64 0
  %v230 = ptrtoint ptr %v209 to i64
  %st80 = getelementptr i64, ptr %v229, i64 0
  store i64 %v230, ptr %st80
  %st81 = getelementptr i64, ptr %v229, i64 1
  store i64 %v228, ptr %st81
  %st82 = getelementptr i64, ptr %v229, i64 2
  store i64 %v206, ptr %st82
  %v231.p = getelementptr i64, ptr %v229, i64 0
  %v231 = load i64, ptr %v231.p
  %st83 = getelementptr i64, ptr %v0, i64 0
  store i64 %v231, ptr %st83
  %v232.p = getelementptr i64, ptr %v229, i64 1
  %v232 = load i64, ptr %v232.p
  %st84 = getelementptr i64, ptr %v0, i64 1
  store i64 %v232, ptr %st84
  %v233.p = getelementptr i64, ptr %v229, i64 2
  %v233 = load i64, ptr %v233.p
  %st85 = getelementptr i64, ptr %v0, i64 2
  store i64 %v233, ptr %st85
  %v309 = getelementptr i64, ptr @"rt.meta", i64 0
  %v234.p = getelementptr i64, ptr %v309, i64 0
  %v234 = load i64, ptr %v234.p
  %v235 = add i64 0, 0
  %v236 = add i64 0, 3
  %v237 = getelementptr i64, ptr %s5, i64 0
  %v310 = getelementptr i64, ptr @"rt.meta", i64 0
  %v238.p = getelementptr i64, ptr %v310, i64 0
  %v238 = load i64, ptr %v238.p
  %v239 = getelementptr i64, ptr %s4, i64 0
  %st86 = getelementptr i64, ptr %v239, i64 0
  store i64 %v235, ptr %st86
  %v311 = getelementptr i64, ptr @"rt.meta", i64 0
  %v240.p = getelementptr i64, ptr %v311, i64 0
  %v240 = load i64, ptr %v240.p
  br label %b27
b23:
  %v220 = add i64 0, 1
  %v221 = mul i64 %v208, %v220
  %v222 = add i64 0, 1
  %v223 = add i64 0, 1
  %v224 = call ptr @"rt.slice_grow"(i64 %v207, i64 %v208, i64 %v222, i64 %v206, i64 %v223)
  %v225 = getelementptr i64, ptr %v224, i64 %v221
  br label %b22
b24:
  %v217 = add i64 0, 1
  %v218 = call ptr @"rt.region_alloc"(i64 %v206, i64 %v217)
  %v219 = inttoptr i64 %v207 to ptr
  br label %b22
b25:
  %v312 = getelementptr i64, ptr @"rt.meta", i64 0
  %st87 = getelementptr i64, ptr %v312, i64 0
  store i64 %v234, ptr %st87
  %v313 = getelementptr i64, ptr @"rt.meta", i64 0
  %st88 = getelementptr i64, ptr %v313, i64 0
  store i64 %v9, ptr %st88
  ret void
b26:
  br label %b25
b27:
  %v314 = getelementptr i64, ptr @"rt.meta", i64 0
  %st89 = getelementptr i64, ptr %v314, i64 0
  store i64 %v240, ptr %st89
  %v241.p = getelementptr i64, ptr %v239, i64 0
  %v241 = load i64, ptr %v241.p
  %v242.c = icmp slt i64 %v241, %v236
  %v242 = zext i1 %v242.c to i64
  %c.b27 = icmp ne i64 %v242, 0
  br i1 %c.b27, label %b27.t91, label %b27.e92
b27.t91:
  br label %b28
b27.e92:
  br label %b29
b28:
  call void @"rt.region_enter"()
  %v315 = getelementptr i64, ptr @"rt.meta", i64 0
  %v243.p = getelementptr i64, ptr %v315, i64 0
  %v243 = load i64, ptr %v243.p
  %v244.p = getelementptr i64, ptr %v239, i64 0
  %v244 = load i64, ptr %v244.p
  %v316 = getelementptr i64, ptr @"rt.meta", i64 0
  %v245.p = getelementptr i64, ptr %v316, i64 0
  %v245 = load i64, ptr %v245.p
  %v246 = getelementptr i64, ptr %s2, i64 0
  %v247.p = getelementptr i64, ptr %v0, i64 0
  %v247 = load i64, ptr %v247.p
  %st92 = getelementptr i64, ptr %v246, i64 0
  store i64 %v247, ptr %st92
  %v248.p = getelementptr i64, ptr %v0, i64 1
  %v248 = load i64, ptr %v248.p
  %st93 = getelementptr i64, ptr %v246, i64 1
  store i64 %v248, ptr %st93
  %v249.p = getelementptr i64, ptr %v0, i64 2
  %v249 = load i64, ptr %v249.p
  %st94 = getelementptr i64, ptr %v246, i64 2
  store i64 %v249, ptr %st94
  %v250.p = getelementptr i64, ptr %v8, i64 0
  %v250 = load i64, ptr %v250.p
  %v251.p = getelementptr i64, ptr %v8, i64 1
  %v251 = load i64, ptr %v251.p
  %v252.p = getelementptr i64, ptr %v8, i64 2
  %v252 = load i64, ptr %v252.p
  %v253 = add i64 0, 4
  %v254 = mul i64 %v253, %v244
  %v255 = call i64 @"std/crypto/chacha20.le32"(i64 %v250, i64 %v251, i64 %v252, i64 %v254)
  %v256.p = getelementptr i64, ptr %v246, i64 2
  %v256 = load i64, ptr %v256.p
  %v257.p = getelementptr i64, ptr %v246, i64 0
  %v257 = load i64, ptr %v257.p
  %v258.p = getelementptr i64, ptr %v246, i64 1
  %v258 = load i64, ptr %v258.p
  %v261 = add i64 0, 8
  %v262 = mul i64 %v258, %v261
  %v263 = add i64 %v257, %v262
  %v317 = getelementptr i64, ptr @"rt.meta", i64 0
  %v318 = getelementptr i64, ptr %v317, i64 %v256
  %v264.p = getelementptr i64, ptr %v318, i64 1
  %v264 = load ptr, ptr %v264.p
  %v265 = ptrtoint ptr %v264 to i64
  %v266.c = icmp eq i64 %v265, %v263
  %v266 = zext i1 %v266.c to i64
  %c.b28 = icmp ne i64 %v266, 0
  br i1 %c.b28, label %b28.t96, label %b28.e97
b28.t96:
  br label %b33
b28.e97:
  br label %b32
b29:
  %v319 = getelementptr i64, ptr @"rt.meta", i64 0
  %st97 = getelementptr i64, ptr %v319, i64 0
  store i64 %v240, ptr %st97
  br label %b26
b30:
  %v320 = getelementptr i64, ptr @"rt.meta", i64 0
  %st98 = getelementptr i64, ptr %v320, i64 0
  store i64 %v245, ptr %st98
  %v284 = add i64 0, 1
  %v285.p = getelementptr i64, ptr %v239, i64 0
  %v285 = load i64, ptr %v285.p
  %v286 = add i64 %v285, %v284
  %st99 = getelementptr i64, ptr %v239, i64 0
  store i64 %v286, ptr %st99
  br label %b27
b31:
  %v259 = phi ptr [ %v274, %b32 ], [ %v269, %b33 ]
  %v260 = phi ptr [ %v275, %b32 ], [ %v268, %b33 ]
  %st100 = getelementptr i64, ptr %v260, i64 0
  store i64 %v255, ptr %st100
  %v276.p = getelementptr i64, ptr %v246, i64 1
  %v276 = load i64, ptr %v276.p
  %v277 = add i64 0, 1
  %v278 = add i64 %v276, %v277
  %v279 = getelementptr i64, ptr %s3, i64 0
  %v280 = ptrtoint ptr %v259 to i64
  %st101 = getelementptr i64, ptr %v279, i64 0
  store i64 %v280, ptr %st101
  %st102 = getelementptr i64, ptr %v279, i64 1
  store i64 %v278, ptr %st102
  %st103 = getelementptr i64, ptr %v279, i64 2
  store i64 %v256, ptr %st103
  %v281.p = getelementptr i64, ptr %v279, i64 0
  %v281 = load i64, ptr %v281.p
  %st104 = getelementptr i64, ptr %v0, i64 0
  store i64 %v281, ptr %st104
  %v282.p = getelementptr i64, ptr %v279, i64 1
  %v282 = load i64, ptr %v282.p
  %st105 = getelementptr i64, ptr %v0, i64 1
  store i64 %v282, ptr %st105
  %v283.p = getelementptr i64, ptr %v279, i64 2
  %v283 = load i64, ptr %v283.p
  %st106 = getelementptr i64, ptr %v0, i64 2
  store i64 %v283, ptr %st106
  br label %b30
b32:
  %v270 = add i64 0, 1
  %v271 = mul i64 %v258, %v270
  %v272 = add i64 0, 1
  %v273 = add i64 0, 1
  %v274 = call ptr @"rt.slice_grow"(i64 %v257, i64 %v258, i64 %v272, i64 %v256, i64 %v273)
  %v275 = getelementptr i64, ptr %v274, i64 %v271
  br label %b31
b33:
  %v267 = add i64 0, 1
  %v268 = call ptr @"rt.region_alloc"(i64 %v256, i64 %v267)
  %v269 = inttoptr i64 %v257 to ptr
  br label %b31
}

define internal void @"std/crypto/chacha20.rounds"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
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
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v5, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v5, i64 2
  store i64 %v3, ptr %st2
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %v6.p = getelementptr i64, ptr %v150, i64 0
  %v6 = load i64, ptr %v6.p
  %v7 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v7, i64 2572
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10.c = icmp eq i64 %v8, %v9
  %v10 = zext i1 %v10.c to i64
  %v11 = mul i64 %v10, %v6
  %v12 = add i64 %v8, %v11
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %v13.p = getelementptr i64, ptr %v151, i64 0
  %v13 = load i64, ptr %v13.p
  %v14 = add i64 0, 0
  %v15 = add i64 0, 16
  %v16 = getelementptr i64, ptr %s1, i64 0
  %v152 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v152, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = getelementptr i64, ptr %s2, i64 0
  %st3 = getelementptr i64, ptr %v18, i64 0
  store i64 %v14, ptr %st3
  %v153 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v153, i64 0
  %v19 = load i64, ptr %v19.p
  br label %b3
b1:
  %v154 = getelementptr i64, ptr @"rt.meta", i64 0
  %st4 = getelementptr i64, ptr %v154, i64 0
  store i64 %v13, ptr %st4
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %v48.p = getelementptr i64, ptr %v155, i64 0
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 0
  %v50 = add i64 0, 10
  %v51 = getelementptr i64, ptr %s2, i64 0
  %v156 = getelementptr i64, ptr @"rt.meta", i64 0
  %v52.p = getelementptr i64, ptr %v156, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = getelementptr i64, ptr %s1, i64 0
  %st5 = getelementptr i64, ptr %v53, i64 0
  store i64 %v49, ptr %st5
  %v157 = getelementptr i64, ptr @"rt.meta", i64 0
  %v54.p = getelementptr i64, ptr %v157, i64 0
  %v54 = load i64, ptr %v54.p
  br label %b16
b2:
  br label %b1
b3:
  %v158 = getelementptr i64, ptr @"rt.meta", i64 0
  %st6 = getelementptr i64, ptr %v158, i64 0
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
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %v22.p = getelementptr i64, ptr %v159, i64 0
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v18, i64 0
  %v23 = load i64, ptr %v23.p
  %v160 = getelementptr i64, ptr @"rt.meta", i64 0
  %v24.p = getelementptr i64, ptr %v160, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = add i64 0, 12
  %v26.c = icmp eq i64 %v23, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b4 = icmp ne i64 %v26, 0
  br i1 %c.b4, label %b4.t10, label %b4.e11
b4.t10:
  br label %b7
b4.e11:
  br label %b8
b5:
  %v161 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v161, i64 0
  store i64 %v19, ptr %st11
  br label %b2
b6:
  %v162 = getelementptr i64, ptr @"rt.meta", i64 0
  %st12 = getelementptr i64, ptr %v162, i64 0
  store i64 %v24, ptr %st12
  %v45 = add i64 0, 1
  %v46.p = getelementptr i64, ptr %v18, i64 0
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 %v46, %v45
  %st13 = getelementptr i64, ptr %v18, i64 0
  store i64 %v47, ptr %st13
  br label %b3
b7:
  br label %b11
b8:
  %v27.p = getelementptr i64, ptr %v5, i64 1
  %v27 = load i64, ptr %v27.p
  %v28.c = icmp uge i64 %v23, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b8 = icmp ne i64 %v28, 0
  br i1 %c.b8, label %b8.t15, label %b8.e16
b8.t15:
  br label %b9
b8.e16:
  br label %b10
b9:
  %v29 = add i64 0, 21
  call void @"rt.panic"(i64 %v29)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v30.p = getelementptr i64, ptr %v5, i64 0
  %v30 = load i64, ptr %v30.p
  %v31 = inttoptr i64 %v30 to ptr
  %v32 = add i64 0, 1
  %v33 = mul i64 %v23, %v32
  %v34 = getelementptr i64, ptr %v31, i64 %v33
  %v35.p = getelementptr i64, ptr %v34, i64 0
  %v35 = load i64, ptr %v35.p
  br label %b11
b11:
  %v36 = phi i64 [ %v4, %b7 ], [ %v35, %b10 ]
  %v37.p = getelementptr i64, ptr %v0, i64 1
  %v37 = load i64, ptr %v37.p
  %v38.c = icmp uge i64 %v23, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b11 = icmp ne i64 %v38, 0
  br i1 %c.b11, label %b11.t17, label %b11.e18
b11.t17:
  br label %b12
b11.e18:
  br label %b13
b12:
  %v39 = add i64 0, 22
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v40.p = getelementptr i64, ptr %v0, i64 0
  %v40 = load i64, ptr %v40.p
  %v41 = inttoptr i64 %v40 to ptr
  %v42 = add i64 0, 1
  %v43 = mul i64 %v23, %v42
  %v44 = getelementptr i64, ptr %v41, i64 %v43
  %st18 = getelementptr i64, ptr %v44, i64 0
  store i64 %v36, ptr %st18
  br label %b6
b14:
  %v163 = getelementptr i64, ptr @"rt.meta", i64 0
  %st19 = getelementptr i64, ptr %v163, i64 0
  store i64 %v48, ptr %st19
  %v164 = getelementptr i64, ptr @"rt.meta", i64 0
  %v103.p = getelementptr i64, ptr %v164, i64 0
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 0, 0
  %v105 = add i64 0, 16
  %v106 = getelementptr i64, ptr %s1, i64 0
  %v165 = getelementptr i64, ptr @"rt.meta", i64 0
  %v107.p = getelementptr i64, ptr %v165, i64 0
  %v107 = load i64, ptr %v107.p
  %v108 = getelementptr i64, ptr %s2, i64 0
  %st20 = getelementptr i64, ptr %v108, i64 0
  store i64 %v104, ptr %st20
  %v166 = getelementptr i64, ptr @"rt.meta", i64 0
  %v109.p = getelementptr i64, ptr %v166, i64 0
  %v109 = load i64, ptr %v109.p
  br label %b22
b15:
  br label %b14
b16:
  %v167 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v167, i64 0
  store i64 %v54, ptr %st21
  %v55.p = getelementptr i64, ptr %v53, i64 0
  %v55 = load i64, ptr %v55.p
  %v56.c = icmp slt i64 %v55, %v50
  %v56 = zext i1 %v56.c to i64
  %c.b16 = icmp ne i64 %v56, 0
  br i1 %c.b16, label %b16.t23, label %b16.e24
b16.t23:
  br label %b17
b16.e24:
  br label %b18
b17:
  call void @"rt.region_enter"()
  %v168 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v168, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v53, i64 0
  %v58 = load i64, ptr %v58.p
  %v169 = getelementptr i64, ptr @"rt.meta", i64 0
  %v59.p = getelementptr i64, ptr %v169, i64 0
  %v59 = load i64, ptr %v59.p
  %v60 = add i64 0, 0
  %v61 = add i64 0, 4
  %v62 = add i64 0, 8
  %v63 = add i64 0, 12
  %v64 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v64, i64 2572
  store i64 %v12, ptr %st24
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v60, i64 %v61, i64 %v62, i64 %v63)
  %v65 = add i64 0, 1
  %v66 = add i64 0, 5
  %v67 = add i64 0, 9
  %v68 = add i64 0, 13
  %v69 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v69, i64 2572
  store i64 %v12, ptr %st25
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v65, i64 %v66, i64 %v67, i64 %v68)
  %v70 = add i64 0, 2
  %v71 = add i64 0, 6
  %v72 = add i64 0, 10
  %v73 = add i64 0, 14
  %v74 = getelementptr i64, ptr @"rt.meta", i64 0
  %st26 = getelementptr i64, ptr %v74, i64 2572
  store i64 %v12, ptr %st26
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v70, i64 %v71, i64 %v72, i64 %v73)
  %v75 = add i64 0, 3
  %v76 = add i64 0, 7
  %v77 = add i64 0, 11
  %v78 = add i64 0, 15
  %v79 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v79, i64 2572
  store i64 %v12, ptr %st27
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v75, i64 %v76, i64 %v77, i64 %v78)
  %v80 = add i64 0, 0
  %v81 = add i64 0, 5
  %v82 = add i64 0, 10
  %v83 = add i64 0, 15
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v84, i64 2572
  store i64 %v12, ptr %st28
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v80, i64 %v81, i64 %v82, i64 %v83)
  %v85 = add i64 0, 1
  %v86 = add i64 0, 6
  %v87 = add i64 0, 11
  %v88 = add i64 0, 12
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %st29 = getelementptr i64, ptr %v89, i64 2572
  store i64 %v12, ptr %st29
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v85, i64 %v86, i64 %v87, i64 %v88)
  %v90 = add i64 0, 2
  %v91 = add i64 0, 7
  %v92 = add i64 0, 8
  %v93 = add i64 0, 13
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %st30 = getelementptr i64, ptr %v94, i64 2572
  store i64 %v12, ptr %st30
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v90, i64 %v91, i64 %v92, i64 %v93)
  %v95 = add i64 0, 3
  %v96 = add i64 0, 4
  %v97 = add i64 0, 9
  %v98 = add i64 0, 14
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st31 = getelementptr i64, ptr %v99, i64 2572
  store i64 %v12, ptr %st31
  call void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v95, i64 %v96, i64 %v97, i64 %v98)
  br label %b19
b18:
  %v170 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v170, i64 0
  store i64 %v54, ptr %st32
  br label %b15
b19:
  %v171 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v171, i64 0
  store i64 %v59, ptr %st33
  %v100 = add i64 0, 1
  %v101.p = getelementptr i64, ptr %v53, i64 0
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 %v101, %v100
  %st34 = getelementptr i64, ptr %v53, i64 0
  store i64 %v102, ptr %st34
  br label %b16
b20:
  %v172 = getelementptr i64, ptr @"rt.meta", i64 0
  %st35 = getelementptr i64, ptr %v172, i64 0
  store i64 %v103, ptr %st35
  %v173 = getelementptr i64, ptr @"rt.meta", i64 0
  %st36 = getelementptr i64, ptr %v173, i64 0
  store i64 %v6, ptr %st36
  ret void
b21:
  br label %b20
b22:
  %v174 = getelementptr i64, ptr @"rt.meta", i64 0
  %st37 = getelementptr i64, ptr %v174, i64 0
  store i64 %v109, ptr %st37
  %v110.p = getelementptr i64, ptr %v108, i64 0
  %v110 = load i64, ptr %v110.p
  %v111.c = icmp slt i64 %v110, %v105
  %v111 = zext i1 %v111.c to i64
  %c.b22 = icmp ne i64 %v111, 0
  br i1 %c.b22, label %b22.t39, label %b22.e40
b22.t39:
  br label %b23
b22.e40:
  br label %b24
b23:
  call void @"rt.region_enter"()
  %v175 = getelementptr i64, ptr @"rt.meta", i64 0
  %v112.p = getelementptr i64, ptr %v175, i64 0
  %v112 = load i64, ptr %v112.p
  %v113.p = getelementptr i64, ptr %v108, i64 0
  %v113 = load i64, ptr %v113.p
  %v176 = getelementptr i64, ptr @"rt.meta", i64 0
  %v114.p = getelementptr i64, ptr %v176, i64 0
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v0, i64 1
  %v115 = load i64, ptr %v115.p
  %v116.c = icmp uge i64 %v113, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b23 = icmp ne i64 %v116, 0
  br i1 %c.b23, label %b23.t41, label %b23.e42
b23.t41:
  br label %b26
b23.e42:
  br label %b27
b24:
  %v177 = getelementptr i64, ptr @"rt.meta", i64 0
  %st42 = getelementptr i64, ptr %v177, i64 0
  store i64 %v109, ptr %st42
  br label %b21
b25:
  %v178 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v178, i64 0
  store i64 %v114, ptr %st43
  %v147 = add i64 0, 1
  %v148.p = getelementptr i64, ptr %v108, i64 0
  %v148 = load i64, ptr %v148.p
  %v149 = add i64 %v148, %v147
  %st44 = getelementptr i64, ptr %v108, i64 0
  store i64 %v149, ptr %st44
  br label %b22
b26:
  %v117 = add i64 0, 23
  call void @"rt.panic"(i64 %v117)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v118.p = getelementptr i64, ptr %v0, i64 0
  %v118 = load i64, ptr %v118.p
  %v119 = inttoptr i64 %v118 to ptr
  %v120 = add i64 0, 1
  %v121 = mul i64 %v113, %v120
  %v122 = getelementptr i64, ptr %v119, i64 %v121
  %v123.p = getelementptr i64, ptr %v122, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 0, 12
  %v125.c = icmp eq i64 %v113, %v124
  %v125 = zext i1 %v125.c to i64
  %c.b27 = icmp ne i64 %v125, 0
  br i1 %c.b27, label %b27.t46, label %b27.e47
b27.t46:
  br label %b28
b27.e47:
  br label %b29
b28:
  br label %b32
b29:
  %v126.p = getelementptr i64, ptr %v5, i64 1
  %v126 = load i64, ptr %v126.p
  %v127.c = icmp uge i64 %v113, %v126
  %v127 = zext i1 %v127.c to i64
  %c.b29 = icmp ne i64 %v127, 0
  br i1 %c.b29, label %b29.t48, label %b29.e49
b29.t48:
  br label %b30
b29.e49:
  br label %b31
b30:
  %v128 = add i64 0, 24
  call void @"rt.panic"(i64 %v128)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b31:
  %v129.p = getelementptr i64, ptr %v5, i64 0
  %v129 = load i64, ptr %v129.p
  %v130 = inttoptr i64 %v129 to ptr
  %v131 = add i64 0, 1
  %v132 = mul i64 %v113, %v131
  %v133 = getelementptr i64, ptr %v130, i64 %v132
  %v134.p = getelementptr i64, ptr %v133, i64 0
  %v134 = load i64, ptr %v134.p
  br label %b32
b32:
  %v135 = phi i64 [ %v4, %b28 ], [ %v134, %b31 ]
  %v136 = add i64 %v123, %v135
  %v137 = add i64 0, 4294967295
  %v138 = and i64 %v136, %v137
  %v139.p = getelementptr i64, ptr %v0, i64 1
  %v139 = load i64, ptr %v139.p
  %v140.c = icmp uge i64 %v113, %v139
  %v140 = zext i1 %v140.c to i64
  %c.b32 = icmp ne i64 %v140, 0
  br i1 %c.b32, label %b32.t50, label %b32.e51
b32.t50:
  br label %b33
b32.e51:
  br label %b34
b33:
  %v141 = add i64 0, 25
  call void @"rt.panic"(i64 %v141)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b34:
  %v142.p = getelementptr i64, ptr %v0, i64 0
  %v142 = load i64, ptr %v142.p
  %v143 = inttoptr i64 %v142 to ptr
  %v144 = add i64 0, 1
  %v145 = mul i64 %v113, %v144
  %v146 = getelementptr i64, ptr %v143, i64 %v145
  %st51 = getelementptr i64, ptr %v146, i64 0
  store i64 %v138, ptr %st51
  br label %b25
}

define internal void @"std/crypto/chacha20.qr"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4) #0 {
b0:
  %v244 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v244, i64 0
  %v5 = load i64, ptr %v5.p
  %v6 = getelementptr i64, ptr @"rt.meta", i64 0
  %v7.p = getelementptr i64, ptr %v6, i64 2572
  %v7 = load i64, ptr %v7.p
  %v8 = add i64 0, 0
  %v9.c = icmp eq i64 %v7, %v8
  %v9 = zext i1 %v9.c to i64
  %v10 = mul i64 %v9, %v5
  %v11 = add i64 %v7, %v10
  %v12.p = getelementptr i64, ptr %v0, i64 1
  %v12 = load i64, ptr %v12.p
  %v13.c = icmp uge i64 %v1, %v12
  %v13 = zext i1 %v13.c to i64
  %c.b0 = icmp ne i64 %v13, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v14 = add i64 0, 26
  call void @"rt.panic"(i64 %v14)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v15.p = getelementptr i64, ptr %v0, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = inttoptr i64 %v15 to ptr
  %v17 = add i64 0, 1
  %v18 = mul i64 %v1, %v17
  %v19 = getelementptr i64, ptr %v16, i64 %v18
  %v20.p = getelementptr i64, ptr %v19, i64 0
  %v20 = load i64, ptr %v20.p
  %v21.p = getelementptr i64, ptr %v0, i64 1
  %v21 = load i64, ptr %v21.p
  %v22.c = icmp uge i64 %v2, %v21
  %v22 = zext i1 %v22.c to i64
  %c.b2 = icmp ne i64 %v22, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b3
b2.e4:
  br label %b4
b3:
  %v23 = add i64 0, 27
  call void @"rt.panic"(i64 %v23)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b4:
  %v24.p = getelementptr i64, ptr %v0, i64 0
  %v24 = load i64, ptr %v24.p
  %v25 = inttoptr i64 %v24 to ptr
  %v26 = add i64 0, 1
  %v27 = mul i64 %v2, %v26
  %v28 = getelementptr i64, ptr %v25, i64 %v27
  %v29.p = getelementptr i64, ptr %v28, i64 0
  %v29 = load i64, ptr %v29.p
  %v30 = add i64 %v20, %v29
  %v31 = add i64 0, 4294967295
  %v32 = and i64 %v30, %v31
  %v33.p = getelementptr i64, ptr %v0, i64 1
  %v33 = load i64, ptr %v33.p
  %v34.c = icmp uge i64 %v1, %v33
  %v34 = zext i1 %v34.c to i64
  %c.b4 = icmp ne i64 %v34, 0
  br i1 %c.b4, label %b4.t5, label %b4.e6
b4.t5:
  br label %b5
b4.e6:
  br label %b6
b5:
  %v35 = add i64 0, 28
  call void @"rt.panic"(i64 %v35)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v36.p = getelementptr i64, ptr %v0, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = inttoptr i64 %v36 to ptr
  %v38 = add i64 0, 1
  %v39 = mul i64 %v1, %v38
  %v40 = getelementptr i64, ptr %v37, i64 %v39
  %st6 = getelementptr i64, ptr %v40, i64 0
  store i64 %v32, ptr %st6
  %v41.p = getelementptr i64, ptr %v0, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.c = icmp uge i64 %v4, %v41
  %v42 = zext i1 %v42.c to i64
  %c.b6 = icmp ne i64 %v42, 0
  br i1 %c.b6, label %b6.t8, label %b6.e9
b6.t8:
  br label %b7
b6.e9:
  br label %b8
b7:
  %v43 = add i64 0, 29
  call void @"rt.panic"(i64 %v43)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b8:
  %v44.p = getelementptr i64, ptr %v0, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = inttoptr i64 %v44 to ptr
  %v46 = add i64 0, 1
  %v47 = mul i64 %v4, %v46
  %v48 = getelementptr i64, ptr %v45, i64 %v47
  %v49.p = getelementptr i64, ptr %v48, i64 0
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v0, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.c = icmp uge i64 %v1, %v50
  %v51 = zext i1 %v51.c to i64
  %c.b8 = icmp ne i64 %v51, 0
  br i1 %c.b8, label %b8.t10, label %b8.e11
b8.t10:
  br label %b9
b8.e11:
  br label %b10
b9:
  %v52 = add i64 0, 30
  call void @"rt.panic"(i64 %v52)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v53.p = getelementptr i64, ptr %v0, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = inttoptr i64 %v53 to ptr
  %v55 = add i64 0, 1
  %v56 = mul i64 %v1, %v55
  %v57 = getelementptr i64, ptr %v54, i64 %v56
  %v58.p = getelementptr i64, ptr %v57, i64 0
  %v58 = load i64, ptr %v58.p
  %v59 = xor i64 %v49, %v58
  %v60 = add i64 0, 16
  %v61 = call i64 @"std/crypto/chacha20.rotl"(i64 %v59, i64 %v60)
  %v62.p = getelementptr i64, ptr %v0, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.c = icmp uge i64 %v4, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b10 = icmp ne i64 %v63, 0
  br i1 %c.b10, label %b10.t12, label %b10.e13
b10.t12:
  br label %b11
b10.e13:
  br label %b12
b11:
  %v64 = add i64 0, 31
  call void @"rt.panic"(i64 %v64)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v65.p = getelementptr i64, ptr %v0, i64 0
  %v65 = load i64, ptr %v65.p
  %v66 = inttoptr i64 %v65 to ptr
  %v67 = add i64 0, 1
  %v68 = mul i64 %v4, %v67
  %v69 = getelementptr i64, ptr %v66, i64 %v68
  %st13 = getelementptr i64, ptr %v69, i64 0
  store i64 %v61, ptr %st13
  %v70.p = getelementptr i64, ptr %v0, i64 1
  %v70 = load i64, ptr %v70.p
  %v71.c = icmp uge i64 %v3, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b12 = icmp ne i64 %v71, 0
  br i1 %c.b12, label %b12.t15, label %b12.e16
b12.t15:
  br label %b13
b12.e16:
  br label %b14
b13:
  %v72 = add i64 0, 32
  call void @"rt.panic"(i64 %v72)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b14:
  %v73.p = getelementptr i64, ptr %v0, i64 0
  %v73 = load i64, ptr %v73.p
  %v74 = inttoptr i64 %v73 to ptr
  %v75 = add i64 0, 1
  %v76 = mul i64 %v3, %v75
  %v77 = getelementptr i64, ptr %v74, i64 %v76
  %v78.p = getelementptr i64, ptr %v77, i64 0
  %v78 = load i64, ptr %v78.p
  %v79.p = getelementptr i64, ptr %v0, i64 1
  %v79 = load i64, ptr %v79.p
  %v80.c = icmp uge i64 %v4, %v79
  %v80 = zext i1 %v80.c to i64
  %c.b14 = icmp ne i64 %v80, 0
  br i1 %c.b14, label %b14.t17, label %b14.e18
b14.t17:
  br label %b15
b14.e18:
  br label %b16
b15:
  %v81 = add i64 0, 33
  call void @"rt.panic"(i64 %v81)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b16:
  %v82.p = getelementptr i64, ptr %v0, i64 0
  %v82 = load i64, ptr %v82.p
  %v83 = inttoptr i64 %v82 to ptr
  %v84 = add i64 0, 1
  %v85 = mul i64 %v4, %v84
  %v86 = getelementptr i64, ptr %v83, i64 %v85
  %v87.p = getelementptr i64, ptr %v86, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 %v78, %v87
  %v89 = add i64 0, 4294967295
  %v90 = and i64 %v88, %v89
  %v91.p = getelementptr i64, ptr %v0, i64 1
  %v91 = load i64, ptr %v91.p
  %v92.c = icmp uge i64 %v3, %v91
  %v92 = zext i1 %v92.c to i64
  %c.b16 = icmp ne i64 %v92, 0
  br i1 %c.b16, label %b16.t19, label %b16.e20
b16.t19:
  br label %b17
b16.e20:
  br label %b18
b17:
  %v93 = add i64 0, 34
  call void @"rt.panic"(i64 %v93)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v94.p = getelementptr i64, ptr %v0, i64 0
  %v94 = load i64, ptr %v94.p
  %v95 = inttoptr i64 %v94 to ptr
  %v96 = add i64 0, 1
  %v97 = mul i64 %v3, %v96
  %v98 = getelementptr i64, ptr %v95, i64 %v97
  %st20 = getelementptr i64, ptr %v98, i64 0
  store i64 %v90, ptr %st20
  %v99.p = getelementptr i64, ptr %v0, i64 1
  %v99 = load i64, ptr %v99.p
  %v100.c = icmp uge i64 %v2, %v99
  %v100 = zext i1 %v100.c to i64
  %c.b18 = icmp ne i64 %v100, 0
  br i1 %c.b18, label %b18.t22, label %b18.e23
b18.t22:
  br label %b19
b18.e23:
  br label %b20
b19:
  %v101 = add i64 0, 35
  call void @"rt.panic"(i64 %v101)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v102.p = getelementptr i64, ptr %v0, i64 0
  %v102 = load i64, ptr %v102.p
  %v103 = inttoptr i64 %v102 to ptr
  %v104 = add i64 0, 1
  %v105 = mul i64 %v2, %v104
  %v106 = getelementptr i64, ptr %v103, i64 %v105
  %v107.p = getelementptr i64, ptr %v106, i64 0
  %v107 = load i64, ptr %v107.p
  %v108.p = getelementptr i64, ptr %v0, i64 1
  %v108 = load i64, ptr %v108.p
  %v109.c = icmp uge i64 %v3, %v108
  %v109 = zext i1 %v109.c to i64
  %c.b20 = icmp ne i64 %v109, 0
  br i1 %c.b20, label %b20.t24, label %b20.e25
b20.t24:
  br label %b21
b20.e25:
  br label %b22
b21:
  %v110 = add i64 0, 36
  call void @"rt.panic"(i64 %v110)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b22:
  %v111.p = getelementptr i64, ptr %v0, i64 0
  %v111 = load i64, ptr %v111.p
  %v112 = inttoptr i64 %v111 to ptr
  %v113 = add i64 0, 1
  %v114 = mul i64 %v3, %v113
  %v115 = getelementptr i64, ptr %v112, i64 %v114
  %v116.p = getelementptr i64, ptr %v115, i64 0
  %v116 = load i64, ptr %v116.p
  %v117 = xor i64 %v107, %v116
  %v118 = add i64 0, 12
  %v119 = call i64 @"std/crypto/chacha20.rotl"(i64 %v117, i64 %v118)
  %v120.p = getelementptr i64, ptr %v0, i64 1
  %v120 = load i64, ptr %v120.p
  %v121.c = icmp uge i64 %v2, %v120
  %v121 = zext i1 %v121.c to i64
  %c.b22 = icmp ne i64 %v121, 0
  br i1 %c.b22, label %b22.t26, label %b22.e27
b22.t26:
  br label %b23
b22.e27:
  br label %b24
b23:
  %v122 = add i64 0, 37
  call void @"rt.panic"(i64 %v122)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b24:
  %v123.p = getelementptr i64, ptr %v0, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = inttoptr i64 %v123 to ptr
  %v125 = add i64 0, 1
  %v126 = mul i64 %v2, %v125
  %v127 = getelementptr i64, ptr %v124, i64 %v126
  %st27 = getelementptr i64, ptr %v127, i64 0
  store i64 %v119, ptr %st27
  %v128.p = getelementptr i64, ptr %v0, i64 1
  %v128 = load i64, ptr %v128.p
  %v129.c = icmp uge i64 %v1, %v128
  %v129 = zext i1 %v129.c to i64
  %c.b24 = icmp ne i64 %v129, 0
  br i1 %c.b24, label %b24.t29, label %b24.e30
b24.t29:
  br label %b25
b24.e30:
  br label %b26
b25:
  %v130 = add i64 0, 38
  call void @"rt.panic"(i64 %v130)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b26:
  %v131.p = getelementptr i64, ptr %v0, i64 0
  %v131 = load i64, ptr %v131.p
  %v132 = inttoptr i64 %v131 to ptr
  %v133 = add i64 0, 1
  %v134 = mul i64 %v1, %v133
  %v135 = getelementptr i64, ptr %v132, i64 %v134
  %v136.p = getelementptr i64, ptr %v135, i64 0
  %v136 = load i64, ptr %v136.p
  %v137.p = getelementptr i64, ptr %v0, i64 1
  %v137 = load i64, ptr %v137.p
  %v138.c = icmp uge i64 %v2, %v137
  %v138 = zext i1 %v138.c to i64
  %c.b26 = icmp ne i64 %v138, 0
  br i1 %c.b26, label %b26.t31, label %b26.e32
b26.t31:
  br label %b27
b26.e32:
  br label %b28
b27:
  %v139 = add i64 0, 39
  call void @"rt.panic"(i64 %v139)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b28:
  %v140.p = getelementptr i64, ptr %v0, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = inttoptr i64 %v140 to ptr
  %v142 = add i64 0, 1
  %v143 = mul i64 %v2, %v142
  %v144 = getelementptr i64, ptr %v141, i64 %v143
  %v145.p = getelementptr i64, ptr %v144, i64 0
  %v145 = load i64, ptr %v145.p
  %v146 = add i64 %v136, %v145
  %v147 = add i64 0, 4294967295
  %v148 = and i64 %v146, %v147
  %v149.p = getelementptr i64, ptr %v0, i64 1
  %v149 = load i64, ptr %v149.p
  %v150.c = icmp uge i64 %v1, %v149
  %v150 = zext i1 %v150.c to i64
  %c.b28 = icmp ne i64 %v150, 0
  br i1 %c.b28, label %b28.t33, label %b28.e34
b28.t33:
  br label %b29
b28.e34:
  br label %b30
b29:
  %v151 = add i64 0, 40
  call void @"rt.panic"(i64 %v151)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b30:
  %v152.p = getelementptr i64, ptr %v0, i64 0
  %v152 = load i64, ptr %v152.p
  %v153 = inttoptr i64 %v152 to ptr
  %v154 = add i64 0, 1
  %v155 = mul i64 %v1, %v154
  %v156 = getelementptr i64, ptr %v153, i64 %v155
  %st34 = getelementptr i64, ptr %v156, i64 0
  store i64 %v148, ptr %st34
  %v157.p = getelementptr i64, ptr %v0, i64 1
  %v157 = load i64, ptr %v157.p
  %v158.c = icmp uge i64 %v4, %v157
  %v158 = zext i1 %v158.c to i64
  %c.b30 = icmp ne i64 %v158, 0
  br i1 %c.b30, label %b30.t36, label %b30.e37
b30.t36:
  br label %b31
b30.e37:
  br label %b32
b31:
  %v159 = add i64 0, 41
  call void @"rt.panic"(i64 %v159)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v160.p = getelementptr i64, ptr %v0, i64 0
  %v160 = load i64, ptr %v160.p
  %v161 = inttoptr i64 %v160 to ptr
  %v162 = add i64 0, 1
  %v163 = mul i64 %v4, %v162
  %v164 = getelementptr i64, ptr %v161, i64 %v163
  %v165.p = getelementptr i64, ptr %v164, i64 0
  %v165 = load i64, ptr %v165.p
  %v166.p = getelementptr i64, ptr %v0, i64 1
  %v166 = load i64, ptr %v166.p
  %v167.c = icmp uge i64 %v1, %v166
  %v167 = zext i1 %v167.c to i64
  %c.b32 = icmp ne i64 %v167, 0
  br i1 %c.b32, label %b32.t38, label %b32.e39
b32.t38:
  br label %b33
b32.e39:
  br label %b34
b33:
  %v168 = add i64 0, 42
  call void @"rt.panic"(i64 %v168)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b34:
  %v169.p = getelementptr i64, ptr %v0, i64 0
  %v169 = load i64, ptr %v169.p
  %v170 = inttoptr i64 %v169 to ptr
  %v171 = add i64 0, 1
  %v172 = mul i64 %v1, %v171
  %v173 = getelementptr i64, ptr %v170, i64 %v172
  %v174.p = getelementptr i64, ptr %v173, i64 0
  %v174 = load i64, ptr %v174.p
  %v175 = xor i64 %v165, %v174
  %v176 = add i64 0, 8
  %v177 = call i64 @"std/crypto/chacha20.rotl"(i64 %v175, i64 %v176)
  %v178.p = getelementptr i64, ptr %v0, i64 1
  %v178 = load i64, ptr %v178.p
  %v179.c = icmp uge i64 %v4, %v178
  %v179 = zext i1 %v179.c to i64
  %c.b34 = icmp ne i64 %v179, 0
  br i1 %c.b34, label %b34.t40, label %b34.e41
b34.t40:
  br label %b35
b34.e41:
  br label %b36
b35:
  %v180 = add i64 0, 43
  call void @"rt.panic"(i64 %v180)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b36:
  %v181.p = getelementptr i64, ptr %v0, i64 0
  %v181 = load i64, ptr %v181.p
  %v182 = inttoptr i64 %v181 to ptr
  %v183 = add i64 0, 1
  %v184 = mul i64 %v4, %v183
  %v185 = getelementptr i64, ptr %v182, i64 %v184
  %st41 = getelementptr i64, ptr %v185, i64 0
  store i64 %v177, ptr %st41
  %v186.p = getelementptr i64, ptr %v0, i64 1
  %v186 = load i64, ptr %v186.p
  %v187.c = icmp uge i64 %v3, %v186
  %v187 = zext i1 %v187.c to i64
  %c.b36 = icmp ne i64 %v187, 0
  br i1 %c.b36, label %b36.t43, label %b36.e44
b36.t43:
  br label %b37
b36.e44:
  br label %b38
b37:
  %v188 = add i64 0, 44
  call void @"rt.panic"(i64 %v188)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b38:
  %v189.p = getelementptr i64, ptr %v0, i64 0
  %v189 = load i64, ptr %v189.p
  %v190 = inttoptr i64 %v189 to ptr
  %v191 = add i64 0, 1
  %v192 = mul i64 %v3, %v191
  %v193 = getelementptr i64, ptr %v190, i64 %v192
  %v194.p = getelementptr i64, ptr %v193, i64 0
  %v194 = load i64, ptr %v194.p
  %v195.p = getelementptr i64, ptr %v0, i64 1
  %v195 = load i64, ptr %v195.p
  %v196.c = icmp uge i64 %v4, %v195
  %v196 = zext i1 %v196.c to i64
  %c.b38 = icmp ne i64 %v196, 0
  br i1 %c.b38, label %b38.t45, label %b38.e46
b38.t45:
  br label %b39
b38.e46:
  br label %b40
b39:
  %v197 = add i64 0, 45
  call void @"rt.panic"(i64 %v197)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b40:
  %v198.p = getelementptr i64, ptr %v0, i64 0
  %v198 = load i64, ptr %v198.p
  %v199 = inttoptr i64 %v198 to ptr
  %v200 = add i64 0, 1
  %v201 = mul i64 %v4, %v200
  %v202 = getelementptr i64, ptr %v199, i64 %v201
  %v203.p = getelementptr i64, ptr %v202, i64 0
  %v203 = load i64, ptr %v203.p
  %v204 = add i64 %v194, %v203
  %v205 = add i64 0, 4294967295
  %v206 = and i64 %v204, %v205
  %v207.p = getelementptr i64, ptr %v0, i64 1
  %v207 = load i64, ptr %v207.p
  %v208.c = icmp uge i64 %v3, %v207
  %v208 = zext i1 %v208.c to i64
  %c.b40 = icmp ne i64 %v208, 0
  br i1 %c.b40, label %b40.t47, label %b40.e48
b40.t47:
  br label %b41
b40.e48:
  br label %b42
b41:
  %v209 = add i64 0, 46
  call void @"rt.panic"(i64 %v209)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b42:
  %v210.p = getelementptr i64, ptr %v0, i64 0
  %v210 = load i64, ptr %v210.p
  %v211 = inttoptr i64 %v210 to ptr
  %v212 = add i64 0, 1
  %v213 = mul i64 %v3, %v212
  %v214 = getelementptr i64, ptr %v211, i64 %v213
  %st48 = getelementptr i64, ptr %v214, i64 0
  store i64 %v206, ptr %st48
  %v215.p = getelementptr i64, ptr %v0, i64 1
  %v215 = load i64, ptr %v215.p
  %v216.c = icmp uge i64 %v2, %v215
  %v216 = zext i1 %v216.c to i64
  %c.b42 = icmp ne i64 %v216, 0
  br i1 %c.b42, label %b42.t50, label %b42.e51
b42.t50:
  br label %b43
b42.e51:
  br label %b44
b43:
  %v217 = add i64 0, 47
  call void @"rt.panic"(i64 %v217)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b44:
  %v218.p = getelementptr i64, ptr %v0, i64 0
  %v218 = load i64, ptr %v218.p
  %v219 = inttoptr i64 %v218 to ptr
  %v220 = add i64 0, 1
  %v221 = mul i64 %v2, %v220
  %v222 = getelementptr i64, ptr %v219, i64 %v221
  %v223.p = getelementptr i64, ptr %v222, i64 0
  %v223 = load i64, ptr %v223.p
  %v224.p = getelementptr i64, ptr %v0, i64 1
  %v224 = load i64, ptr %v224.p
  %v225.c = icmp uge i64 %v3, %v224
  %v225 = zext i1 %v225.c to i64
  %c.b44 = icmp ne i64 %v225, 0
  br i1 %c.b44, label %b44.t52, label %b44.e53
b44.t52:
  br label %b45
b44.e53:
  br label %b46
b45:
  %v226 = add i64 0, 48
  call void @"rt.panic"(i64 %v226)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b46:
  %v227.p = getelementptr i64, ptr %v0, i64 0
  %v227 = load i64, ptr %v227.p
  %v228 = inttoptr i64 %v227 to ptr
  %v229 = add i64 0, 1
  %v230 = mul i64 %v3, %v229
  %v231 = getelementptr i64, ptr %v228, i64 %v230
  %v232.p = getelementptr i64, ptr %v231, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = xor i64 %v223, %v232
  %v234 = add i64 0, 7
  %v235 = call i64 @"std/crypto/chacha20.rotl"(i64 %v233, i64 %v234)
  %v236.p = getelementptr i64, ptr %v0, i64 1
  %v236 = load i64, ptr %v236.p
  %v237.c = icmp uge i64 %v2, %v236
  %v237 = zext i1 %v237.c to i64
  %c.b46 = icmp ne i64 %v237, 0
  br i1 %c.b46, label %b46.t54, label %b46.e55
b46.t54:
  br label %b47
b46.e55:
  br label %b48
b47:
  %v238 = add i64 0, 49
  call void @"rt.panic"(i64 %v238)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b48:
  %v239.p = getelementptr i64, ptr %v0, i64 0
  %v239 = load i64, ptr %v239.p
  %v240 = inttoptr i64 %v239 to ptr
  %v241 = add i64 0, 1
  %v242 = mul i64 %v2, %v241
  %v243 = getelementptr i64, ptr %v240, i64 %v242
  %st55 = getelementptr i64, ptr %v243, i64 0
  store i64 %v235, ptr %st55
  %v245 = getelementptr i64, ptr @"rt.meta", i64 0
  %st56 = getelementptr i64, ptr %v245, i64 0
  store i64 %v5, ptr %st56
  ret void
}

define internal i64 @"std/crypto/chacha20.rotl"(i64 %v0, i64 %v1) #0 {
b0:
  %v25 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v25, i64 0
  %v2 = load i64, ptr %v2.p
  call void @"rt.region_enter"()
  %v4 = add i64 0, 0
  %v5.c = icmp slt i64 %v1, %v4
  %v5 = zext i1 %v5.c to i64
  %c.b0 = icmp ne i64 %v5, 0
  br i1 %c.b0, label %b0.t1, label %b0.e2
b0.t1:
  br label %b1
b0.e2:
  br label %b2
b1:
  %v6 = add i64 0, 50
  call void @"rt.panic"(i64 %v6)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v7 = add i64 0, 63
  %v8.c = icmp sgt i64 %v1, %v7
  %v8 = zext i1 %v8.c to i64
  %c.b2 = icmp ne i64 %v8, 0
  br i1 %c.b2, label %b2.t3, label %b2.e4
b2.t3:
  br label %b4
b2.e4:
  br label %b5
b3:
  %v3 = phi i64 [ %v9, %b4 ], [ %v10, %b5 ]
  %v11 = add i64 0, 32
  %v12 = sub i64 %v11, %v1
  %v14 = add i64 0, 0
  %v15.c = icmp slt i64 %v12, %v14
  %v15 = zext i1 %v15.c to i64
  %c.b3 = icmp ne i64 %v15, 0
  br i1 %c.b3, label %b3.t5, label %b3.e6
b3.t5:
  br label %b6
b3.e6:
  br label %b7
b4:
  %v9 = add i64 0, 0
  br label %b3
b5:
  %v10.n = and i64 %v1, 63
  %v10 = shl i64 %v0, %v10.n
  br label %b3
b6:
  %v16 = add i64 0, 51
  call void @"rt.panic"(i64 %v16)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v17 = add i64 0, 63
  %v18.c = icmp sgt i64 %v12, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b7 = icmp ne i64 %v18, 0
  br i1 %c.b7, label %b7.t7, label %b7.e8
b7.t7:
  br label %b9
b7.e8:
  br label %b10
b8:
  %v13 = phi i64 [ %v20, %b9 ], [ %v21, %b10 ]
  %v22 = or i64 %v3, %v13
  %v23 = add i64 0, 4294967295
  %v24 = and i64 %v22, %v23
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %st8 = getelementptr i64, ptr %v26, i64 0
  store i64 %v2, ptr %st8
  ret i64 %v24
b9:
  %v19 = add i64 0, 63
  %v20.n = and i64 %v19, 63
  %v20 = ashr i64 %v0, %v20.n
  br label %b8
b10:
  %v21.n = and i64 %v12, 63
  %v21 = ashr i64 %v0, %v21.n
  br label %b8
}

define internal i64 @"std/crypto/chacha20.le32"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v70, i64 0
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
  %v8 = add i64 0, 52
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
  %v13 = add i64 0, 1
  %v14 = add i64 %v3, %v13
  %v15.p = getelementptr i64, ptr %v4, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b2 = icmp ne i64 %v16, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b3
b2.e7:
  br label %b4
b3:
  %v17 = add i64 0, 53
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
  %v22 = add i64 0, 8
  %v24 = add i64 0, 0
  %v25.c = icmp slt i64 %v22, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b4 = icmp ne i64 %v25, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b5
b4.e9:
  br label %b6
b5:
  %v26 = add i64 0, 54
  call void @"rt.panic"(i64 %v26)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v27 = add i64 0, 63
  %v28.c = icmp sgt i64 %v22, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b6 = icmp ne i64 %v28, 0
  br i1 %c.b6, label %b6.t10, label %b6.e11
b6.t10:
  br label %b8
b6.e11:
  br label %b9
b7:
  %v23 = phi i64 [ %v29, %b8 ], [ %v30, %b9 ]
  %v31 = or i64 %v12, %v23
  %v32 = add i64 0, 2
  %v33 = add i64 %v3, %v32
  %v34.p = getelementptr i64, ptr %v4, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp uge i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b7 = icmp ne i64 %v35, 0
  br i1 %c.b7, label %b7.t12, label %b7.e13
b7.t12:
  br label %b10
b7.e13:
  br label %b11
b8:
  %v29 = add i64 0, 0
  br label %b7
b9:
  %v30.n = and i64 %v22, 63
  %v30 = shl i64 %v21, %v30.n
  br label %b7
b10:
  %v36 = add i64 0, 55
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v37.p = getelementptr i64, ptr %v4, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = inttoptr i64 %v37 to ptr
  %v39 = getelementptr i8, ptr %v38, i64 %v33
  %v40.p = getelementptr i8, ptr %v39, i64 0
  %v40.b = load i8, ptr %v40.p
  %v40 = zext i8 %v40.b to i64
  %v41 = add i64 0, 16
  %v43 = add i64 0, 0
  %v44.c = icmp slt i64 %v41, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b11 = icmp ne i64 %v44, 0
  br i1 %c.b11, label %b11.t14, label %b11.e15
b11.t14:
  br label %b12
b11.e15:
  br label %b13
b12:
  %v45 = add i64 0, 56
  call void @"rt.panic"(i64 %v45)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v46 = add i64 0, 63
  %v47.c = icmp sgt i64 %v41, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b13 = icmp ne i64 %v47, 0
  br i1 %c.b13, label %b13.t16, label %b13.e17
b13.t16:
  br label %b15
b13.e17:
  br label %b16
b14:
  %v42 = phi i64 [ %v48, %b15 ], [ %v49, %b16 ]
  %v50 = or i64 %v31, %v42
  %v51 = add i64 0, 3
  %v52 = add i64 %v3, %v51
  %v53.p = getelementptr i64, ptr %v4, i64 1
  %v53 = load i64, ptr %v53.p
  %v54.c = icmp uge i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b14 = icmp ne i64 %v54, 0
  br i1 %c.b14, label %b14.t18, label %b14.e19
b14.t18:
  br label %b17
b14.e19:
  br label %b18
b15:
  %v48 = add i64 0, 0
  br label %b14
b16:
  %v49.n = and i64 %v41, 63
  %v49 = shl i64 %v40, %v49.n
  br label %b14
b17:
  %v55 = add i64 0, 57
  call void @"rt.panic"(i64 %v55)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v56.p = getelementptr i64, ptr %v4, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = inttoptr i64 %v56 to ptr
  %v58 = getelementptr i8, ptr %v57, i64 %v52
  %v59.p = getelementptr i8, ptr %v58, i64 0
  %v59.b = load i8, ptr %v59.p
  %v59 = zext i8 %v59.b to i64
  %v60 = add i64 0, 24
  %v62 = add i64 0, 0
  %v63.c = icmp slt i64 %v60, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b18 = icmp ne i64 %v63, 0
  br i1 %c.b18, label %b18.t20, label %b18.e21
b18.t20:
  br label %b19
b18.e21:
  br label %b20
b19:
  %v64 = add i64 0, 58
  call void @"rt.panic"(i64 %v64)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v65 = add i64 0, 63
  %v66.c = icmp sgt i64 %v60, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b20 = icmp ne i64 %v66, 0
  br i1 %c.b20, label %b20.t22, label %b20.e23
b20.t22:
  br label %b22
b20.e23:
  br label %b23
b21:
  %v61 = phi i64 [ %v67, %b22 ], [ %v68, %b23 ]
  %v69 = or i64 %v50, %v61
  %v71 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v71, i64 0
  store i64 %v5, ptr %st23
  ret i64 %v69
b22:
  %v67 = add i64 0, 0
  br label %b21
b23:
  %v68.n = and i64 %v60, 63
  %v68 = shl i64 %v59, %v68.n
  br label %b21
}

define internal void @"std/crypto/chacha20.put32"(ptr %v0, i64 %v1) #0 {
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
  %v163 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v163, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = getelementptr i64, ptr %s0, i64 0
  %v10.p = getelementptr i64, ptr %v0, i64 0
  %v10 = load i64, ptr %v10.p
  %st0 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st0
  %v11.p = getelementptr i64, ptr %v0, i64 1
  %v11 = load i64, ptr %v11.p
  %st1 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st1
  %v12.p = getelementptr i64, ptr %v0, i64 2
  %v12 = load i64, ptr %v12.p
  %st2 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st2
  %v13 = add i64 0, 255
  %v14 = and i64 %v1, %v13
  %v15 = add i64 0, 256
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v17 = add i64 0, 59
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v18.p = getelementptr i64, ptr %v9, i64 2
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v9, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v9, i64 1
  %v20 = load i64, ptr %v20.p
  %v23 = add i64 %v19, %v20
  %v24 = call i64 @"rt.tip8"(i64 %v18, i64 %v23)
  %v25 = add i64 0, 0
  %v26.c = icmp ne i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b2 = icmp ne i64 %v26, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b5
b2.e7:
  br label %b4
b3:
  %v21 = phi ptr [ %v30, %b4 ], [ %v27, %b5 ]
  %v22 = phi ptr [ %v31, %b4 ], [ %v28, %b5 ]
  %st7 = getelementptr i8, ptr %v22, i64 0
  %st7.b = trunc i64 %v14 to i8
  store i8 %st7.b, ptr %st7
  %v32.p = getelementptr i64, ptr %v9, i64 1
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 1
  %v34 = add i64 %v32, %v33
  %v35 = getelementptr i64, ptr %s1, i64 0
  %v36 = ptrtoint ptr %v21 to i64
  %st8 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st8
  %st9 = getelementptr i64, ptr %v35, i64 1
  store i64 %v34, ptr %st9
  %st10 = getelementptr i64, ptr %v35, i64 2
  store i64 %v18, ptr %st10
  %v37.p = getelementptr i64, ptr %v35, i64 0
  %v37 = load i64, ptr %v37.p
  %st11 = getelementptr i64, ptr %v0, i64 0
  store i64 %v37, ptr %st11
  %v38.p = getelementptr i64, ptr %v35, i64 1
  %v38 = load i64, ptr %v38.p
  %st12 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st12
  %v39.p = getelementptr i64, ptr %v35, i64 2
  %v39 = load i64, ptr %v39.p
  %st13 = getelementptr i64, ptr %v0, i64 2
  store i64 %v39, ptr %st13
  %v40 = getelementptr i64, ptr %s1, i64 0
  %v41.p = getelementptr i64, ptr %v0, i64 0
  %v41 = load i64, ptr %v41.p
  %st14 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st14
  %v42.p = getelementptr i64, ptr %v0, i64 1
  %v42 = load i64, ptr %v42.p
  %st15 = getelementptr i64, ptr %v40, i64 1
  store i64 %v42, ptr %st15
  %v43.p = getelementptr i64, ptr %v0, i64 2
  %v43 = load i64, ptr %v43.p
  %st16 = getelementptr i64, ptr %v40, i64 2
  store i64 %v43, ptr %st16
  %v44 = add i64 0, 8
  %v46 = add i64 0, 0
  %v47.c = icmp slt i64 %v44, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b3 = icmp ne i64 %v47, 0
  br i1 %c.b3, label %b3.t18, label %b3.e19
b3.t18:
  br label %b6
b3.e19:
  br label %b7
b4:
  %v29 = add i64 0, 1
  %v30 = call ptr @"rt.slice_grow8"(i64 %v19, i64 %v20, i64 %v18, i64 %v29)
  %v31 = getelementptr i8, ptr %v30, i64 %v20
  br label %b3
b5:
  %v27 = inttoptr i64 %v19 to ptr
  %v28 = getelementptr i8, ptr %v27, i64 %v20
  br label %b3
b6:
  %v48 = add i64 0, 60
  call void @"rt.panic"(i64 %v48)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v49 = add i64 0, 63
  %v50.c = icmp sgt i64 %v44, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b7 = icmp ne i64 %v50, 0
  br i1 %c.b7, label %b7.t20, label %b7.e21
b7.t20:
  br label %b9
b7.e21:
  br label %b10
b8:
  %v45 = phi i64 [ %v52, %b9 ], [ %v53, %b10 ]
  %v54 = add i64 0, 255
  %v55 = and i64 %v45, %v54
  %v56 = add i64 0, 256
  %v57.c = icmp uge i64 %v55, %v56
  %v57 = zext i1 %v57.c to i64
  %c.b8 = icmp ne i64 %v57, 0
  br i1 %c.b8, label %b8.t22, label %b8.e23
b8.t22:
  br label %b11
b8.e23:
  br label %b12
b9:
  %v51 = add i64 0, 63
  %v52.n = and i64 %v51, 63
  %v52 = ashr i64 %v1, %v52.n
  br label %b8
b10:
  %v53.n = and i64 %v44, 63
  %v53 = ashr i64 %v1, %v53.n
  br label %b8
b11:
  %v58 = add i64 0, 61
  call void @"rt.panic"(i64 %v58)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v59.p = getelementptr i64, ptr %v40, i64 2
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v40, i64 0
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v40, i64 1
  %v61 = load i64, ptr %v61.p
  %v64 = add i64 %v60, %v61
  %v65 = call i64 @"rt.tip8"(i64 %v59, i64 %v64)
  %v66 = add i64 0, 0
  %v67.c = icmp ne i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b12 = icmp ne i64 %v67, 0
  br i1 %c.b12, label %b12.t24, label %b12.e25
b12.t24:
  br label %b15
b12.e25:
  br label %b14
b13:
  %v62 = phi ptr [ %v71, %b14 ], [ %v68, %b15 ]
  %v63 = phi ptr [ %v72, %b14 ], [ %v69, %b15 ]
  %st25 = getelementptr i8, ptr %v63, i64 0
  %st25.b = trunc i64 %v55 to i8
  store i8 %st25.b, ptr %st25
  %v73.p = getelementptr i64, ptr %v40, i64 1
  %v73 = load i64, ptr %v73.p
  %v74 = add i64 0, 1
  %v75 = add i64 %v73, %v74
  %v76 = getelementptr i64, ptr %s0, i64 0
  %v77 = ptrtoint ptr %v62 to i64
  %st26 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st26
  %st27 = getelementptr i64, ptr %v76, i64 1
  store i64 %v75, ptr %st27
  %st28 = getelementptr i64, ptr %v76, i64 2
  store i64 %v59, ptr %st28
  %v78.p = getelementptr i64, ptr %v76, i64 0
  %v78 = load i64, ptr %v78.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v78, ptr %st29
  %v79.p = getelementptr i64, ptr %v76, i64 1
  %v79 = load i64, ptr %v79.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v79, ptr %st30
  %v80.p = getelementptr i64, ptr %v76, i64 2
  %v80 = load i64, ptr %v80.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v80, ptr %st31
  %v81 = getelementptr i64, ptr %s0, i64 0
  %v82.p = getelementptr i64, ptr %v0, i64 0
  %v82 = load i64, ptr %v82.p
  %st32 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st32
  %v83.p = getelementptr i64, ptr %v0, i64 1
  %v83 = load i64, ptr %v83.p
  %st33 = getelementptr i64, ptr %v81, i64 1
  store i64 %v83, ptr %st33
  %v84.p = getelementptr i64, ptr %v0, i64 2
  %v84 = load i64, ptr %v84.p
  %st34 = getelementptr i64, ptr %v81, i64 2
  store i64 %v84, ptr %st34
  %v85 = add i64 0, 16
  %v87 = add i64 0, 0
  %v88.c = icmp slt i64 %v85, %v87
  %v88 = zext i1 %v88.c to i64
  %c.b13 = icmp ne i64 %v88, 0
  br i1 %c.b13, label %b13.t36, label %b13.e37
b13.t36:
  br label %b16
b13.e37:
  br label %b17
b14:
  %v70 = add i64 0, 1
  %v71 = call ptr @"rt.slice_grow8"(i64 %v60, i64 %v61, i64 %v59, i64 %v70)
  %v72 = getelementptr i8, ptr %v71, i64 %v61
  br label %b13
b15:
  %v68 = inttoptr i64 %v60 to ptr
  %v69 = getelementptr i8, ptr %v68, i64 %v61
  br label %b13
b16:
  %v89 = add i64 0, 62
  call void @"rt.panic"(i64 %v89)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v90 = add i64 0, 63
  %v91.c = icmp sgt i64 %v85, %v90
  %v91 = zext i1 %v91.c to i64
  %c.b17 = icmp ne i64 %v91, 0
  br i1 %c.b17, label %b17.t38, label %b17.e39
b17.t38:
  br label %b19
b17.e39:
  br label %b20
b18:
  %v86 = phi i64 [ %v93, %b19 ], [ %v94, %b20 ]
  %v95 = add i64 0, 255
  %v96 = and i64 %v86, %v95
  %v97 = add i64 0, 256
  %v98.c = icmp uge i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b18 = icmp ne i64 %v98, 0
  br i1 %c.b18, label %b18.t40, label %b18.e41
b18.t40:
  br label %b21
b18.e41:
  br label %b22
b19:
  %v92 = add i64 0, 63
  %v93.n = and i64 %v92, 63
  %v93 = ashr i64 %v1, %v93.n
  br label %b18
b20:
  %v94.n = and i64 %v85, 63
  %v94 = ashr i64 %v1, %v94.n
  br label %b18
b21:
  %v99 = add i64 0, 63
  call void @"rt.panic"(i64 %v99)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b22:
  %v100.p = getelementptr i64, ptr %v81, i64 2
  %v100 = load i64, ptr %v100.p
  %v101.p = getelementptr i64, ptr %v81, i64 0
  %v101 = load i64, ptr %v101.p
  %v102.p = getelementptr i64, ptr %v81, i64 1
  %v102 = load i64, ptr %v102.p
  %v105 = add i64 %v101, %v102
  %v106 = call i64 @"rt.tip8"(i64 %v100, i64 %v105)
  %v107 = add i64 0, 0
  %v108.c = icmp ne i64 %v106, %v107
  %v108 = zext i1 %v108.c to i64
  %c.b22 = icmp ne i64 %v108, 0
  br i1 %c.b22, label %b22.t42, label %b22.e43
b22.t42:
  br label %b25
b22.e43:
  br label %b24
b23:
  %v103 = phi ptr [ %v112, %b24 ], [ %v109, %b25 ]
  %v104 = phi ptr [ %v113, %b24 ], [ %v110, %b25 ]
  %st43 = getelementptr i8, ptr %v104, i64 0
  %st43.b = trunc i64 %v96 to i8
  store i8 %st43.b, ptr %st43
  %v114.p = getelementptr i64, ptr %v81, i64 1
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 1
  %v116 = add i64 %v114, %v115
  %v117 = getelementptr i64, ptr %s1, i64 0
  %v118 = ptrtoint ptr %v103 to i64
  %st44 = getelementptr i64, ptr %v117, i64 0
  store i64 %v118, ptr %st44
  %st45 = getelementptr i64, ptr %v117, i64 1
  store i64 %v116, ptr %st45
  %st46 = getelementptr i64, ptr %v117, i64 2
  store i64 %v100, ptr %st46
  %v119.p = getelementptr i64, ptr %v117, i64 0
  %v119 = load i64, ptr %v119.p
  %st47 = getelementptr i64, ptr %v0, i64 0
  store i64 %v119, ptr %st47
  %v120.p = getelementptr i64, ptr %v117, i64 1
  %v120 = load i64, ptr %v120.p
  %st48 = getelementptr i64, ptr %v0, i64 1
  store i64 %v120, ptr %st48
  %v121.p = getelementptr i64, ptr %v117, i64 2
  %v121 = load i64, ptr %v121.p
  %st49 = getelementptr i64, ptr %v0, i64 2
  store i64 %v121, ptr %st49
  %v122 = getelementptr i64, ptr %s1, i64 0
  %v123.p = getelementptr i64, ptr %v0, i64 0
  %v123 = load i64, ptr %v123.p
  %st50 = getelementptr i64, ptr %v122, i64 0
  store i64 %v123, ptr %st50
  %v124.p = getelementptr i64, ptr %v0, i64 1
  %v124 = load i64, ptr %v124.p
  %st51 = getelementptr i64, ptr %v122, i64 1
  store i64 %v124, ptr %st51
  %v125.p = getelementptr i64, ptr %v0, i64 2
  %v125 = load i64, ptr %v125.p
  %st52 = getelementptr i64, ptr %v122, i64 2
  store i64 %v125, ptr %st52
  %v126 = add i64 0, 24
  %v128 = add i64 0, 0
  %v129.c = icmp slt i64 %v126, %v128
  %v129 = zext i1 %v129.c to i64
  %c.b23 = icmp ne i64 %v129, 0
  br i1 %c.b23, label %b23.t54, label %b23.e55
b23.t54:
  br label %b26
b23.e55:
  br label %b27
b24:
  %v111 = add i64 0, 1
  %v112 = call ptr @"rt.slice_grow8"(i64 %v101, i64 %v102, i64 %v100, i64 %v111)
  %v113 = getelementptr i8, ptr %v112, i64 %v102
  br label %b23
b25:
  %v109 = inttoptr i64 %v101 to ptr
  %v110 = getelementptr i8, ptr %v109, i64 %v102
  br label %b23
b26:
  %v130 = add i64 0, 64
  call void @"rt.panic"(i64 %v130)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v131 = add i64 0, 63
  %v132.c = icmp sgt i64 %v126, %v131
  %v132 = zext i1 %v132.c to i64
  %c.b27 = icmp ne i64 %v132, 0
  br i1 %c.b27, label %b27.t56, label %b27.e57
b27.t56:
  br label %b29
b27.e57:
  br label %b30
b28:
  %v127 = phi i64 [ %v134, %b29 ], [ %v135, %b30 ]
  %v136 = add i64 0, 255
  %v137 = and i64 %v127, %v136
  %v138 = add i64 0, 256
  %v139.c = icmp uge i64 %v137, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b28 = icmp ne i64 %v139, 0
  br i1 %c.b28, label %b28.t58, label %b28.e59
b28.t58:
  br label %b31
b28.e59:
  br label %b32
b29:
  %v133 = add i64 0, 63
  %v134.n = and i64 %v133, 63
  %v134 = ashr i64 %v1, %v134.n
  br label %b28
b30:
  %v135.n = and i64 %v126, 63
  %v135 = ashr i64 %v1, %v135.n
  br label %b28
b31:
  %v140 = add i64 0, 65
  call void @"rt.panic"(i64 %v140)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v141.p = getelementptr i64, ptr %v122, i64 2
  %v141 = load i64, ptr %v141.p
  %v142.p = getelementptr i64, ptr %v122, i64 0
  %v142 = load i64, ptr %v142.p
  %v143.p = getelementptr i64, ptr %v122, i64 1
  %v143 = load i64, ptr %v143.p
  %v146 = add i64 %v142, %v143
  %v147 = call i64 @"rt.tip8"(i64 %v141, i64 %v146)
  %v148 = add i64 0, 0
  %v149.c = icmp ne i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b32 = icmp ne i64 %v149, 0
  br i1 %c.b32, label %b32.t60, label %b32.e61
b32.t60:
  br label %b35
b32.e61:
  br label %b34
b33:
  %v144 = phi ptr [ %v153, %b34 ], [ %v150, %b35 ]
  %v145 = phi ptr [ %v154, %b34 ], [ %v151, %b35 ]
  %st61 = getelementptr i8, ptr %v145, i64 0
  %st61.b = trunc i64 %v137 to i8
  store i8 %st61.b, ptr %st61
  %v155.p = getelementptr i64, ptr %v122, i64 1
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 0, 1
  %v157 = add i64 %v155, %v156
  %v158 = getelementptr i64, ptr %s0, i64 0
  %v159 = ptrtoint ptr %v144 to i64
  %st62 = getelementptr i64, ptr %v158, i64 0
  store i64 %v159, ptr %st62
  %st63 = getelementptr i64, ptr %v158, i64 1
  store i64 %v157, ptr %st63
  %st64 = getelementptr i64, ptr %v158, i64 2
  store i64 %v141, ptr %st64
  %v160.p = getelementptr i64, ptr %v158, i64 0
  %v160 = load i64, ptr %v160.p
  %st65 = getelementptr i64, ptr %v0, i64 0
  store i64 %v160, ptr %st65
  %v161.p = getelementptr i64, ptr %v158, i64 1
  %v161 = load i64, ptr %v161.p
  %st66 = getelementptr i64, ptr %v0, i64 1
  store i64 %v161, ptr %st66
  %v162.p = getelementptr i64, ptr %v158, i64 2
  %v162 = load i64, ptr %v162.p
  %st67 = getelementptr i64, ptr %v0, i64 2
  store i64 %v162, ptr %st67
  %v164 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v164, i64 0
  store i64 %v2, ptr %st68
  ret void
b34:
  %v152 = add i64 0, 1
  %v153 = call ptr @"rt.slice_grow8"(i64 %v142, i64 %v143, i64 %v141, i64 %v152)
  %v154 = getelementptr i8, ptr %v153, i64 %v143
  br label %b33
b35:
  %v150 = inttoptr i64 %v142 to ptr
  %v151 = getelementptr i8, ptr %v150, i64 %v143
  br label %b33
}

define internal void @"std/crypto/chacha20poly1305.Prepare"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %s5 = alloca [4 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s5.z3 = getelementptr i64, ptr %s5, i64 3
  store i64 0, ptr %s5.z3
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
  %v82 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v82, i64 0
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
  %v16.p = getelementptr i64, ptr %v4, i64 1
  %v16 = load i64, ptr %v16.p
  %v17 = add i64 0, 32
  %v18.c = icmp ne i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %c.b0 = icmp ne i64 %v18, 0
  br i1 %c.b0, label %b0.t5, label %b0.e6
b0.t5:
  br label %b1
b0.e6:
  br label %b2
b1:
  %v19 = add i64 0, 0
  %v20 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v19)
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s1, i64 0
  %v23 = ptrtoint ptr %v20 to i64
  %st6 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st6
  %st7 = getelementptr i64, ptr %v22, i64 1
  store i64 %v21, ptr %st7
  %st8 = getelementptr i64, ptr %v22, i64 2
  store i64 %v15, ptr %st8
  %v24 = getelementptr i64, ptr %s2, i64 0
  %v25.p = getelementptr i64, ptr %v22, i64 0
  %v25 = load i64, ptr %v25.p
  %st9 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st9
  %v26.p = getelementptr i64, ptr %v22, i64 1
  %v26 = load i64, ptr %v26.p
  %st10 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st10
  %v27.p = getelementptr i64, ptr %v22, i64 2
  %v27 = load i64, ptr %v27.p
  %st11 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st11
  %v28 = getelementptr i64, ptr %s3, i64 0
  %v29 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v28, i64 0
  store i64 %v29, ptr %st12
  %st13 = getelementptr i64, ptr %v28, i64 1
  store i64 %v29, ptr %st13
  %st14 = getelementptr i64, ptr %v28, i64 2
  store i64 %v29, ptr %st14
  %v30.p = getelementptr i64, ptr %v24, i64 0
  %v30 = load i64, ptr %v30.p
  %st15 = getelementptr i64, ptr %v28, i64 0
  store i64 %v30, ptr %st15
  %v31.p = getelementptr i64, ptr %v24, i64 1
  %v31 = load i64, ptr %v31.p
  %st16 = getelementptr i64, ptr %v28, i64 1
  store i64 %v31, ptr %st16
  %v32.p = getelementptr i64, ptr %v24, i64 2
  %v32 = load i64, ptr %v32.p
  %st17 = getelementptr i64, ptr %v28, i64 2
  store i64 %v32, ptr %st17
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34 = add i64 0, 0
  %st18 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st18
  %v35 = add i64 0, 0
  %st19 = getelementptr i64, ptr %v33, i64 0
  store i64 %v35, ptr %st19
  %v36 = getelementptr i64, ptr %s5, i64 0
  %v37.p = getelementptr i64, ptr %v33, i64 0
  %v37 = load i64, ptr %v37.p
  %st20 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st20
  %v38 = add i64 0, 0
  %st21 = getelementptr i64, ptr %v36, i64 1
  store i64 %v38, ptr %st21
  %st22 = getelementptr i64, ptr %v36, i64 2
  store i64 %v38, ptr %st22
  %st23 = getelementptr i64, ptr %v36, i64 3
  store i64 %v38, ptr %st23
  %v39 = getelementptr i64, ptr %s6, i64 0
  %v40 = add i64 0, 1
  %st24 = getelementptr i64, ptr %v39, i64 0
  store i64 %v40, ptr %st24
  %v41.p = getelementptr i64, ptr %v36, i64 0
  %v41 = load i64, ptr %v41.p
  %st25 = getelementptr i64, ptr %v39, i64 1
  store i64 %v41, ptr %st25
  %v42.p = getelementptr i64, ptr %v36, i64 1
  %v42 = load i64, ptr %v42.p
  %st26 = getelementptr i64, ptr %v39, i64 2
  store i64 %v42, ptr %st26
  %v43.p = getelementptr i64, ptr %v36, i64 2
  %v43 = load i64, ptr %v43.p
  %st27 = getelementptr i64, ptr %v39, i64 3
  store i64 %v43, ptr %st27
  %v44.p = getelementptr i64, ptr %v36, i64 3
  %v44 = load i64, ptr %v44.p
  %st28 = getelementptr i64, ptr %v39, i64 4
  store i64 %v44, ptr %st28
  %v45.p = getelementptr i64, ptr %v28, i64 0
  %v45 = load i64, ptr %v45.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v45, ptr %st29
  %v46.p = getelementptr i64, ptr %v28, i64 1
  %v46 = load i64, ptr %v46.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v46, ptr %st30
  %v47.p = getelementptr i64, ptr %v28, i64 2
  %v47 = load i64, ptr %v47.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v47, ptr %st31
  %v48.p = getelementptr i64, ptr %v39, i64 0
  %v48 = load i64, ptr %v48.p
  %st32 = getelementptr i64, ptr %v0, i64 3
  store i64 %v48, ptr %st32
  %v49.p = getelementptr i64, ptr %v39, i64 1
  %v49 = load i64, ptr %v49.p
  %st33 = getelementptr i64, ptr %v0, i64 4
  store i64 %v49, ptr %st33
  %v50.p = getelementptr i64, ptr %v39, i64 2
  %v50 = load i64, ptr %v50.p
  %st34 = getelementptr i64, ptr %v0, i64 5
  store i64 %v50, ptr %st34
  %v51.p = getelementptr i64, ptr %v39, i64 3
  %v51 = load i64, ptr %v51.p
  %st35 = getelementptr i64, ptr %v0, i64 6
  store i64 %v51, ptr %st35
  %v52.p = getelementptr i64, ptr %v39, i64 4
  %v52 = load i64, ptr %v52.p
  %st36 = getelementptr i64, ptr %v0, i64 7
  store i64 %v52, ptr %st36
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v53.p = getelementptr i64, ptr %v0, i64 3
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 0, 0
  %v55.c = icmp ne i64 %v53, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b1 = icmp ne i64 %v55, 0
  br i1 %c.b1, label %b1.t38, label %b1.e39
b1.t38:
  br label %b3
b1.e39:
  br label %b4
b2:
  br label %b5
b3:
  %v56 = add i64 0, 4
  %v57 = getelementptr i64, ptr %v0, i64 %v56
  call void @"rt.err_relocate"(ptr %v57, i64 %v5)
  br label %b4
b4:
  %v83 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v83, i64 0
  store i64 %v5, ptr %st39
  ret void
b5:
  %v58 = getelementptr i64, ptr %s3, i64 0
  %v59.p = getelementptr i64, ptr %v4, i64 0
  %v59 = load i64, ptr %v59.p
  %st40 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st40
  %v60.p = getelementptr i64, ptr %v4, i64 1
  %v60 = load i64, ptr %v60.p
  %st41 = getelementptr i64, ptr %v58, i64 1
  store i64 %v60, ptr %st41
  %v61.p = getelementptr i64, ptr %v4, i64 2
  %v61 = load i64, ptr %v61.p
  %st42 = getelementptr i64, ptr %v58, i64 2
  store i64 %v61, ptr %st42
  %v62 = getelementptr i64, ptr %s2, i64 0
  %v63 = add i64 0, 0
  %st43 = getelementptr i64, ptr %v62, i64 0
  store i64 %v63, ptr %st43
  %st44 = getelementptr i64, ptr %v62, i64 1
  store i64 %v63, ptr %st44
  %st45 = getelementptr i64, ptr %v62, i64 2
  store i64 %v63, ptr %st45
  %v64.p = getelementptr i64, ptr %v58, i64 0
  %v64 = load i64, ptr %v64.p
  %st46 = getelementptr i64, ptr %v62, i64 0
  store i64 %v64, ptr %st46
  %v65.p = getelementptr i64, ptr %v58, i64 1
  %v65 = load i64, ptr %v65.p
  %st47 = getelementptr i64, ptr %v62, i64 1
  store i64 %v65, ptr %st47
  %v66.p = getelementptr i64, ptr %v58, i64 2
  %v66 = load i64, ptr %v66.p
  %st48 = getelementptr i64, ptr %v62, i64 2
  store i64 %v66, ptr %st48
  %v67 = getelementptr i64, ptr %s6, i64 0
  %v68 = add i64 0, 0
  %st49 = getelementptr i64, ptr %v67, i64 0
  store i64 %v68, ptr %st49
  %v69.p = getelementptr i64, ptr %v62, i64 0
  %v69 = load i64, ptr %v69.p
  %st50 = getelementptr i64, ptr %v0, i64 0
  store i64 %v69, ptr %st50
  %v70.p = getelementptr i64, ptr %v62, i64 1
  %v70 = load i64, ptr %v70.p
  %st51 = getelementptr i64, ptr %v0, i64 1
  store i64 %v70, ptr %st51
  %v71.p = getelementptr i64, ptr %v62, i64 2
  %v71 = load i64, ptr %v71.p
  %st52 = getelementptr i64, ptr %v0, i64 2
  store i64 %v71, ptr %st52
  %v72.p = getelementptr i64, ptr %v67, i64 0
  %v72 = load i64, ptr %v72.p
  %st53 = getelementptr i64, ptr %v0, i64 3
  store i64 %v72, ptr %st53
  %v73.p = getelementptr i64, ptr %v67, i64 1
  %v73 = load i64, ptr %v73.p
  %st54 = getelementptr i64, ptr %v0, i64 4
  store i64 %v73, ptr %st54
  %v74.p = getelementptr i64, ptr %v67, i64 2
  %v74 = load i64, ptr %v74.p
  %st55 = getelementptr i64, ptr %v0, i64 5
  store i64 %v74, ptr %st55
  %v75.p = getelementptr i64, ptr %v67, i64 3
  %v75 = load i64, ptr %v75.p
  %st56 = getelementptr i64, ptr %v0, i64 6
  store i64 %v75, ptr %st56
  %v76.p = getelementptr i64, ptr %v67, i64 4
  %v76 = load i64, ptr %v76.p
  %st57 = getelementptr i64, ptr %v0, i64 7
  store i64 %v76, ptr %st57
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v77.p = getelementptr i64, ptr %v0, i64 3
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79.c = icmp ne i64 %v77, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b5 = icmp ne i64 %v79, 0
  br i1 %c.b5, label %b5.t59, label %b5.e60
b5.t59:
  br label %b6
b5.e60:
  br label %b7
b6:
  %v80 = add i64 0, 4
  %v81 = getelementptr i64, ptr %v0, i64 %v80
  call void @"rt.err_relocate"(ptr %v81, i64 %v5)
  br label %b7
b7:
  %v84 = getelementptr i64, ptr @"rt.meta", i64 0
  %st60 = getelementptr i64, ptr %v84, i64 0
  store i64 %v5, ptr %st60
  ret void
}

define internal void @"std/crypto/chacha20poly1305.Seal"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12) #0 {
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
  %s4 = alloca [8 x i64], align 8
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
  %s4.z6 = getelementptr i64, ptr %s4, i64 6
  store i64 0, ptr %s4.z6
  %s4.z7 = getelementptr i64, ptr %s4, i64 7
  store i64 0, ptr %s4.z7
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [8 x i64], align 8
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
  %v13 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v13, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v13, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v13, i64 2
  store i64 %v3, ptr %st2
  %v14 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v6, ptr %st5
  %v15 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v15, i64 0
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v15, i64 1
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v15, i64 2
  store i64 %v9, ptr %st8
  %v16 = getelementptr i64, ptr %s3, i64 0
  %st9 = getelementptr i64, ptr %v16, i64 0
  store i64 %v10, ptr %st9
  %st10 = getelementptr i64, ptr %v16, i64 1
  store i64 %v11, ptr %st10
  %st11 = getelementptr i64, ptr %v16, i64 2
  store i64 %v12, ptr %st11
  %v102 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v102, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v18, i64 2571
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v18, i64 2571
  store i64 %v20, ptr %st12
  %v21 = add i64 0, 1
  %v22.c = icmp sge i64 %v19, %v21
  %v22 = zext i1 %v22.c to i64
  %v23.c = icmp sle i64 %v19, %v17
  %v23 = zext i1 %v23.c to i64
  %v24 = and i64 %v22, %v23
  %v25 = sub i64 %v19, %v17
  %v26 = mul i64 %v24, %v25
  %v27 = add i64 %v17, %v26
  call void @"rt.region_enter"()
  %v28 = getelementptr i64, ptr %s4, i64 0
  %v29.p = getelementptr i64, ptr %v13, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v13, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v13, i64 2
  %v31 = load i64, ptr %v31.p
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v32, i64 2571
  store i64 %v27, ptr %st13
  call void @"std/crypto/chacha20poly1305.Prepare"(ptr %v28, i64 %v29, i64 %v30, i64 %v31)
  %v33 = add i64 0, 3
  %v34 = getelementptr i64, ptr %v28, i64 %v33
  %v35.p = getelementptr i64, ptr %v34, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 0
  %v37.c = icmp ne i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b0 = icmp ne i64 %v37, 0
  br i1 %c.b0, label %b0.t15, label %b0.e16
b0.t15:
  br label %b1
b0.e16:
  br label %b2
b1:
  %v38 = add i64 0, 0
  %st16 = getelementptr i64, ptr %v0, i64 0
  store i64 %v38, ptr %st16
  %st17 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st17
  %st18 = getelementptr i64, ptr %v0, i64 2
  store i64 %v38, ptr %st18
  %v103 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v103, i64 0
  %v39 = load i64, ptr %v39.p
  %v104 = getelementptr i64, ptr @"rt.meta", i64 0
  %v105 = getelementptr i64, ptr %v104, i64 %v39
  %v40.p = getelementptr i64, ptr %v105, i64 1
  %v40 = load ptr, ptr %v40.p
  %v41 = ptrtoint ptr %v40 to i64
  %st19 = getelementptr i64, ptr %v0, i64 0
  store i64 %v41, ptr %st19
  %v42 = add i64 0, 0
  %st20 = getelementptr i64, ptr %v0, i64 1
  store i64 %v42, ptr %st20
  %st21 = getelementptr i64, ptr %v0, i64 2
  store i64 %v39, ptr %st21
  %v43.p = getelementptr i64, ptr %v34, i64 0
  %v43 = load i64, ptr %v43.p
  %st22 = getelementptr i64, ptr %v0, i64 3
  store i64 %v43, ptr %st22
  %v44.p = getelementptr i64, ptr %v34, i64 1
  %v44 = load i64, ptr %v44.p
  %st23 = getelementptr i64, ptr %v0, i64 4
  store i64 %v44, ptr %st23
  %v45.p = getelementptr i64, ptr %v34, i64 2
  %v45 = load i64, ptr %v45.p
  %st24 = getelementptr i64, ptr %v0, i64 5
  store i64 %v45, ptr %st24
  %v46.p = getelementptr i64, ptr %v34, i64 3
  %v46 = load i64, ptr %v46.p
  %st25 = getelementptr i64, ptr %v0, i64 6
  store i64 %v46, ptr %st25
  %v47.p = getelementptr i64, ptr %v34, i64 4
  %v47 = load i64, ptr %v47.p
  %st26 = getelementptr i64, ptr %v0, i64 7
  store i64 %v47, ptr %st26
  call void @"rt.region_relocate8"(ptr %v0, i64 %v17)
  %v48.p = getelementptr i64, ptr %v0, i64 3
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 0
  %v50.c = icmp ne i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b1 = icmp ne i64 %v50, 0
  br i1 %c.b1, label %b1.t28, label %b1.e29
b1.t28:
  br label %b3
b1.e29:
  br label %b4
b2:
  %v53 = getelementptr i64, ptr %s5, i64 0
  %v54.p = getelementptr i64, ptr %v28, i64 0
  %v54 = load i64, ptr %v54.p
  %st29 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st29
  %v55.p = getelementptr i64, ptr %v28, i64 1
  %v55 = load i64, ptr %v55.p
  %st30 = getelementptr i64, ptr %v53, i64 1
  store i64 %v55, ptr %st30
  %v56.p = getelementptr i64, ptr %v28, i64 2
  %v56 = load i64, ptr %v56.p
  %st31 = getelementptr i64, ptr %v53, i64 2
  store i64 %v56, ptr %st31
  %v57 = getelementptr i64, ptr %s6, i64 0
  %v58.p = getelementptr i64, ptr %v53, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v53, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v53, i64 2
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v14, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v14, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v14, i64 2
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v15, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v15, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v15, i64 2
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v16, i64 0
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v16, i64 1
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v16, i64 2
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 0
  %v71 = call ptr @"rt.region_alloc8"(i64 %v27, i64 %v70)
  %v72 = add i64 0, 0
  %v73 = getelementptr i64, ptr %s7, i64 0
  %v74 = ptrtoint ptr %v71 to i64
  %st32 = getelementptr i64, ptr %v73, i64 0
  store i64 %v74, ptr %st32
  %st33 = getelementptr i64, ptr %v73, i64 1
  store i64 %v72, ptr %st33
  %st34 = getelementptr i64, ptr %v73, i64 2
  store i64 %v27, ptr %st34
  %v75.p = getelementptr i64, ptr %v73, i64 0
  %v75 = load i64, ptr %v75.p
  %v76.p = getelementptr i64, ptr %v73, i64 1
  %v76 = load i64, ptr %v76.p
  %v77.p = getelementptr i64, ptr %v73, i64 2
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 0
  %v79 = call ptr @"rt.region_alloc8"(i64 %v27, i64 %v78)
  %v80 = add i64 0, 0
  %v81 = getelementptr i64, ptr %s8, i64 0
  %v82 = ptrtoint ptr %v79 to i64
  %st35 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st35
  %st36 = getelementptr i64, ptr %v81, i64 1
  store i64 %v80, ptr %st36
  %st37 = getelementptr i64, ptr %v81, i64 2
  store i64 %v27, ptr %st37
  %v83.p = getelementptr i64, ptr %v81, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v81, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v81, i64 2
  %v85 = load i64, ptr %v85.p
  %v86 = getelementptr i64, ptr @"rt.meta", i64 0
  %st38 = getelementptr i64, ptr %v86, i64 2571
  store i64 %v27, ptr %st38
  call void @"std/crypto/chacha20poly1305.SealTo"(ptr %v57, i64 %v58, i64 %v59, i64 %v60, i64 %v61, i64 %v62, i64 %v63, i64 %v64, i64 %v65, i64 %v66, i64 %v67, i64 %v68, i64 %v69, i64 %v75, i64 %v76, i64 %v77, i64 %v83, i64 %v84, i64 %v85)
  %v87 = add i64 0, 3
  %v88 = getelementptr i64, ptr %v57, i64 %v87
  %v89.p = getelementptr i64, ptr %v57, i64 0
  %v89 = load i64, ptr %v89.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v89, ptr %st39
  %v90.p = getelementptr i64, ptr %v57, i64 1
  %v90 = load i64, ptr %v90.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v90, ptr %st40
  %v91.p = getelementptr i64, ptr %v57, i64 2
  %v91 = load i64, ptr %v91.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v91, ptr %st41
  %v92.p = getelementptr i64, ptr %v88, i64 0
  %v92 = load i64, ptr %v92.p
  %st42 = getelementptr i64, ptr %v0, i64 3
  store i64 %v92, ptr %st42
  %v93.p = getelementptr i64, ptr %v88, i64 1
  %v93 = load i64, ptr %v93.p
  %st43 = getelementptr i64, ptr %v0, i64 4
  store i64 %v93, ptr %st43
  %v94.p = getelementptr i64, ptr %v88, i64 2
  %v94 = load i64, ptr %v94.p
  %st44 = getelementptr i64, ptr %v0, i64 5
  store i64 %v94, ptr %st44
  %v95.p = getelementptr i64, ptr %v88, i64 3
  %v95 = load i64, ptr %v95.p
  %st45 = getelementptr i64, ptr %v0, i64 6
  store i64 %v95, ptr %st45
  %v96.p = getelementptr i64, ptr %v88, i64 4
  %v96 = load i64, ptr %v96.p
  %st46 = getelementptr i64, ptr %v0, i64 7
  store i64 %v96, ptr %st46
  call void @"rt.region_relocate8"(ptr %v0, i64 %v17)
  %v97.p = getelementptr i64, ptr %v0, i64 3
  %v97 = load i64, ptr %v97.p
  %v98 = add i64 0, 0
  %v99.c = icmp ne i64 %v97, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b2 = icmp ne i64 %v99, 0
  br i1 %c.b2, label %b2.t48, label %b2.e49
b2.t48:
  br label %b5
b2.e49:
  br label %b6
b3:
  %v51 = add i64 0, 4
  %v52 = getelementptr i64, ptr %v0, i64 %v51
  call void @"rt.err_relocate"(ptr %v52, i64 %v17)
  br label %b4
b4:
  %v106 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v106, i64 0
  store i64 %v17, ptr %st49
  ret void
b5:
  %v100 = add i64 0, 4
  %v101 = getelementptr i64, ptr %v0, i64 %v100
  call void @"rt.err_relocate"(ptr %v101, i64 %v17)
  br label %b6
b6:
  %v107 = getelementptr i64, ptr @"rt.meta", i64 0
  %st50 = getelementptr i64, ptr %v107, i64 0
  store i64 %v17, ptr %st50
  ret void
}

define internal void @"std/crypto/chacha20poly1305.Open"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12) #0 {
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
  %s4 = alloca [8 x i64], align 8
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
  %s4.z6 = getelementptr i64, ptr %s4, i64 6
  store i64 0, ptr %s4.z6
  %s4.z7 = getelementptr i64, ptr %s4, i64 7
  store i64 0, ptr %s4.z7
  %s5 = alloca [3 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
  %s5.z1 = getelementptr i64, ptr %s5, i64 1
  store i64 0, ptr %s5.z1
  %s5.z2 = getelementptr i64, ptr %s5, i64 2
  store i64 0, ptr %s5.z2
  %s6 = alloca [8 x i64], align 8
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
  %v13 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v13, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v13, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v13, i64 2
  store i64 %v3, ptr %st2
  %v14 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v14, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v14, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v14, i64 2
  store i64 %v6, ptr %st5
  %v15 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v15, i64 0
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v15, i64 1
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v15, i64 2
  store i64 %v9, ptr %st8
  %v16 = getelementptr i64, ptr %s3, i64 0
  %st9 = getelementptr i64, ptr %v16, i64 0
  store i64 %v10, ptr %st9
  %st10 = getelementptr i64, ptr %v16, i64 1
  store i64 %v11, ptr %st10
  %st11 = getelementptr i64, ptr %v16, i64 2
  store i64 %v12, ptr %st11
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v88, i64 0
  %v17 = load i64, ptr %v17.p
  %v18 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v18, i64 2571
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v18, i64 2571
  store i64 %v20, ptr %st12
  %v21 = add i64 0, 1
  %v22.c = icmp sge i64 %v19, %v21
  %v22 = zext i1 %v22.c to i64
  %v23.c = icmp sle i64 %v19, %v17
  %v23 = zext i1 %v23.c to i64
  %v24 = and i64 %v22, %v23
  %v25 = sub i64 %v19, %v17
  %v26 = mul i64 %v24, %v25
  %v27 = add i64 %v17, %v26
  call void @"rt.region_enter"()
  %v28 = getelementptr i64, ptr %s4, i64 0
  %v29.p = getelementptr i64, ptr %v13, i64 0
  %v29 = load i64, ptr %v29.p
  %v30.p = getelementptr i64, ptr %v13, i64 1
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v13, i64 2
  %v31 = load i64, ptr %v31.p
  %v32 = getelementptr i64, ptr @"rt.meta", i64 0
  %st13 = getelementptr i64, ptr %v32, i64 2571
  store i64 %v27, ptr %st13
  call void @"std/crypto/chacha20poly1305.Prepare"(ptr %v28, i64 %v29, i64 %v30, i64 %v31)
  %v33 = add i64 0, 3
  %v34 = getelementptr i64, ptr %v28, i64 %v33
  %v35.p = getelementptr i64, ptr %v34, i64 0
  %v35 = load i64, ptr %v35.p
  %v36 = add i64 0, 0
  %v37.c = icmp ne i64 %v35, %v36
  %v37 = zext i1 %v37.c to i64
  %c.b0 = icmp ne i64 %v37, 0
  br i1 %c.b0, label %b0.t15, label %b0.e16
b0.t15:
  br label %b1
b0.e16:
  br label %b2
b1:
  %v38 = add i64 0, 0
  %st16 = getelementptr i64, ptr %v0, i64 0
  store i64 %v38, ptr %st16
  %st17 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st17
  %st18 = getelementptr i64, ptr %v0, i64 2
  store i64 %v38, ptr %st18
  %v89 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v89, i64 0
  %v39 = load i64, ptr %v39.p
  %v90 = getelementptr i64, ptr @"rt.meta", i64 0
  %v91 = getelementptr i64, ptr %v90, i64 %v39
  %v40.p = getelementptr i64, ptr %v91, i64 1
  %v40 = load ptr, ptr %v40.p
  %v41 = ptrtoint ptr %v40 to i64
  %st19 = getelementptr i64, ptr %v0, i64 0
  store i64 %v41, ptr %st19
  %v42 = add i64 0, 0
  %st20 = getelementptr i64, ptr %v0, i64 1
  store i64 %v42, ptr %st20
  %st21 = getelementptr i64, ptr %v0, i64 2
  store i64 %v39, ptr %st21
  %v43.p = getelementptr i64, ptr %v34, i64 0
  %v43 = load i64, ptr %v43.p
  %st22 = getelementptr i64, ptr %v0, i64 3
  store i64 %v43, ptr %st22
  %v44.p = getelementptr i64, ptr %v34, i64 1
  %v44 = load i64, ptr %v44.p
  %st23 = getelementptr i64, ptr %v0, i64 4
  store i64 %v44, ptr %st23
  %v45.p = getelementptr i64, ptr %v34, i64 2
  %v45 = load i64, ptr %v45.p
  %st24 = getelementptr i64, ptr %v0, i64 5
  store i64 %v45, ptr %st24
  %v46.p = getelementptr i64, ptr %v34, i64 3
  %v46 = load i64, ptr %v46.p
  %st25 = getelementptr i64, ptr %v0, i64 6
  store i64 %v46, ptr %st25
  %v47.p = getelementptr i64, ptr %v34, i64 4
  %v47 = load i64, ptr %v47.p
  %st26 = getelementptr i64, ptr %v0, i64 7
  store i64 %v47, ptr %st26
  call void @"rt.region_relocate8"(ptr %v0, i64 %v17)
  %v48.p = getelementptr i64, ptr %v0, i64 3
  %v48 = load i64, ptr %v48.p
  %v49 = add i64 0, 0
  %v50.c = icmp ne i64 %v48, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b1 = icmp ne i64 %v50, 0
  br i1 %c.b1, label %b1.t28, label %b1.e29
b1.t28:
  br label %b3
b1.e29:
  br label %b4
b2:
  %v53 = getelementptr i64, ptr %s5, i64 0
  %v54.p = getelementptr i64, ptr %v28, i64 0
  %v54 = load i64, ptr %v54.p
  %st29 = getelementptr i64, ptr %v53, i64 0
  store i64 %v54, ptr %st29
  %v55.p = getelementptr i64, ptr %v28, i64 1
  %v55 = load i64, ptr %v55.p
  %st30 = getelementptr i64, ptr %v53, i64 1
  store i64 %v55, ptr %st30
  %v56.p = getelementptr i64, ptr %v28, i64 2
  %v56 = load i64, ptr %v56.p
  %st31 = getelementptr i64, ptr %v53, i64 2
  store i64 %v56, ptr %st31
  %v57 = getelementptr i64, ptr %s6, i64 0
  %v58.p = getelementptr i64, ptr %v53, i64 0
  %v58 = load i64, ptr %v58.p
  %v59.p = getelementptr i64, ptr %v53, i64 1
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v53, i64 2
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v14, i64 0
  %v61 = load i64, ptr %v61.p
  %v62.p = getelementptr i64, ptr %v14, i64 1
  %v62 = load i64, ptr %v62.p
  %v63.p = getelementptr i64, ptr %v14, i64 2
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v15, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v15, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v15, i64 2
  %v66 = load i64, ptr %v66.p
  %v67.p = getelementptr i64, ptr %v16, i64 0
  %v67 = load i64, ptr %v67.p
  %v68.p = getelementptr i64, ptr %v16, i64 1
  %v68 = load i64, ptr %v68.p
  %v69.p = getelementptr i64, ptr %v16, i64 2
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 0
  %v71.p = getelementptr i64, ptr %v16, i64 1
  %v71 = load i64, ptr %v71.p
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %st32 = getelementptr i64, ptr %v72, i64 2571
  store i64 %v27, ptr %st32
  call void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v57, i64 %v58, i64 %v59, i64 %v60, i64 %v61, i64 %v62, i64 %v63, i64 %v64, i64 %v65, i64 %v66, i64 %v67, i64 %v68, i64 %v69, i64 %v70, i64 %v71)
  %v73 = add i64 0, 3
  %v74 = getelementptr i64, ptr %v57, i64 %v73
  %v75.p = getelementptr i64, ptr %v57, i64 0
  %v75 = load i64, ptr %v75.p
  %st33 = getelementptr i64, ptr %v0, i64 0
  store i64 %v75, ptr %st33
  %v76.p = getelementptr i64, ptr %v57, i64 1
  %v76 = load i64, ptr %v76.p
  %st34 = getelementptr i64, ptr %v0, i64 1
  store i64 %v76, ptr %st34
  %v77.p = getelementptr i64, ptr %v57, i64 2
  %v77 = load i64, ptr %v77.p
  %st35 = getelementptr i64, ptr %v0, i64 2
  store i64 %v77, ptr %st35
  %v78.p = getelementptr i64, ptr %v74, i64 0
  %v78 = load i64, ptr %v78.p
  %st36 = getelementptr i64, ptr %v0, i64 3
  store i64 %v78, ptr %st36
  %v79.p = getelementptr i64, ptr %v74, i64 1
  %v79 = load i64, ptr %v79.p
  %st37 = getelementptr i64, ptr %v0, i64 4
  store i64 %v79, ptr %st37
  %v80.p = getelementptr i64, ptr %v74, i64 2
  %v80 = load i64, ptr %v80.p
  %st38 = getelementptr i64, ptr %v0, i64 5
  store i64 %v80, ptr %st38
  %v81.p = getelementptr i64, ptr %v74, i64 3
  %v81 = load i64, ptr %v81.p
  %st39 = getelementptr i64, ptr %v0, i64 6
  store i64 %v81, ptr %st39
  %v82.p = getelementptr i64, ptr %v74, i64 4
  %v82 = load i64, ptr %v82.p
  %st40 = getelementptr i64, ptr %v0, i64 7
  store i64 %v82, ptr %st40
  call void @"rt.region_relocate8"(ptr %v0, i64 %v17)
  %v83.p = getelementptr i64, ptr %v0, i64 3
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 0
  %v85.c = icmp ne i64 %v83, %v84
  %v85 = zext i1 %v85.c to i64
  %c.b2 = icmp ne i64 %v85, 0
  br i1 %c.b2, label %b2.t42, label %b2.e43
b2.t42:
  br label %b5
b2.e43:
  br label %b6
b3:
  %v51 = add i64 0, 4
  %v52 = getelementptr i64, ptr %v0, i64 %v51
  call void @"rt.err_relocate"(ptr %v52, i64 %v17)
  br label %b4
b4:
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %st43 = getelementptr i64, ptr %v92, i64 0
  store i64 %v17, ptr %st43
  ret void
b5:
  %v86 = add i64 0, 4
  %v87 = getelementptr i64, ptr %v0, i64 %v86
  call void @"rt.err_relocate"(ptr %v87, i64 %v17)
  br label %b6
b6:
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st44 = getelementptr i64, ptr %v93, i64 0
  store i64 %v17, ptr %st44
  ret void
}

define internal void @"std/crypto/chacha20poly1305.SealTo"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14, i64 %v15, i64 %v16, i64 %v17, i64 %v18) #0 {
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
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s8 = alloca [4 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s8.z1 = getelementptr i64, ptr %s8, i64 1
  store i64 0, ptr %s8.z1
  %s8.z2 = getelementptr i64, ptr %s8, i64 2
  store i64 0, ptr %s8.z2
  %s8.z3 = getelementptr i64, ptr %s8, i64 3
  store i64 0, ptr %s8.z3
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
  %v19 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v19, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v19, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v19, i64 2
  store i64 %v3, ptr %st2
  %v20 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v20, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v20, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v20, i64 2
  store i64 %v6, ptr %st5
  %v21 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v21, i64 0
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v21, i64 1
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v21, i64 2
  store i64 %v9, ptr %st8
  %v22 = getelementptr i64, ptr %s3, i64 0
  %st9 = getelementptr i64, ptr %v22, i64 0
  store i64 %v10, ptr %st9
  %st10 = getelementptr i64, ptr %v22, i64 1
  store i64 %v11, ptr %st10
  %st11 = getelementptr i64, ptr %v22, i64 2
  store i64 %v12, ptr %st11
  %v23 = getelementptr i64, ptr %s4, i64 0
  %st12 = getelementptr i64, ptr %v23, i64 0
  store i64 %v13, ptr %st12
  %st13 = getelementptr i64, ptr %v23, i64 1
  store i64 %v14, ptr %st13
  %st14 = getelementptr i64, ptr %v23, i64 2
  store i64 %v15, ptr %st14
  %v24 = getelementptr i64, ptr %s5, i64 0
  %st15 = getelementptr i64, ptr %v24, i64 0
  store i64 %v16, ptr %st15
  %st16 = getelementptr i64, ptr %v24, i64 1
  store i64 %v17, ptr %st16
  %st17 = getelementptr i64, ptr %v24, i64 2
  store i64 %v18, ptr %st17
  %v503 = getelementptr i64, ptr @"rt.meta", i64 0
  %v25.p = getelementptr i64, ptr %v503, i64 0
  %v25 = load i64, ptr %v25.p
  %v26 = getelementptr i64, ptr @"rt.meta", i64 0
  %v27.p = getelementptr i64, ptr %v26, i64 2571
  %v27 = load i64, ptr %v27.p
  %v28 = add i64 0, 0
  %st18 = getelementptr i64, ptr %v26, i64 2571
  store i64 %v28, ptr %st18
  %v29 = add i64 0, 1
  %v30.c = icmp sge i64 %v27, %v29
  %v30 = zext i1 %v30.c to i64
  %v31.c = icmp sle i64 %v27, %v25
  %v31 = zext i1 %v31.c to i64
  %v32 = and i64 %v30, %v31
  %v33 = sub i64 %v27, %v25
  %v34 = mul i64 %v32, %v33
  %v35 = add i64 %v25, %v34
  call void @"rt.region_enter"()
  %v36.p = getelementptr i64, ptr %v20, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = add i64 0, 12
  %v38.c = icmp ne i64 %v36, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b0 = icmp ne i64 %v38, 0
  br i1 %c.b0, label %b0.t20, label %b0.e21
b0.t20:
  br label %b1
b0.e21:
  br label %b2
b1:
  %v39 = add i64 0, 0
  %v40 = call ptr @"rt.region_alloc8"(i64 %v35, i64 %v39)
  %v41 = add i64 0, 0
  %v42 = getelementptr i64, ptr %s6, i64 0
  %v43 = ptrtoint ptr %v40 to i64
  %st21 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st21
  %st22 = getelementptr i64, ptr %v42, i64 1
  store i64 %v41, ptr %st22
  %st23 = getelementptr i64, ptr %v42, i64 2
  store i64 %v35, ptr %st23
  %v44 = getelementptr i64, ptr %s7, i64 0
  %v45 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v44, i64 0
  store i64 %v45, ptr %st24
  %v46 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v44, i64 0
  store i64 %v46, ptr %st25
  %v47 = getelementptr i64, ptr %s8, i64 0
  %v48.p = getelementptr i64, ptr %v44, i64 0
  %v48 = load i64, ptr %v48.p
  %st26 = getelementptr i64, ptr %v47, i64 0
  store i64 %v48, ptr %st26
  %v49 = add i64 0, 0
  %st27 = getelementptr i64, ptr %v47, i64 1
  store i64 %v49, ptr %st27
  %st28 = getelementptr i64, ptr %v47, i64 2
  store i64 %v49, ptr %st28
  %st29 = getelementptr i64, ptr %v47, i64 3
  store i64 %v49, ptr %st29
  %v50 = getelementptr i64, ptr %s9, i64 0
  %v51 = add i64 0, 1
  %st30 = getelementptr i64, ptr %v50, i64 0
  store i64 %v51, ptr %st30
  %v52.p = getelementptr i64, ptr %v47, i64 0
  %v52 = load i64, ptr %v52.p
  %st31 = getelementptr i64, ptr %v50, i64 1
  store i64 %v52, ptr %st31
  %v53.p = getelementptr i64, ptr %v47, i64 1
  %v53 = load i64, ptr %v53.p
  %st32 = getelementptr i64, ptr %v50, i64 2
  store i64 %v53, ptr %st32
  %v54.p = getelementptr i64, ptr %v47, i64 2
  %v54 = load i64, ptr %v54.p
  %st33 = getelementptr i64, ptr %v50, i64 3
  store i64 %v54, ptr %st33
  %v55.p = getelementptr i64, ptr %v47, i64 3
  %v55 = load i64, ptr %v55.p
  %st34 = getelementptr i64, ptr %v50, i64 4
  store i64 %v55, ptr %st34
  %v56.p = getelementptr i64, ptr %v42, i64 0
  %v56 = load i64, ptr %v56.p
  %st35 = getelementptr i64, ptr %v0, i64 0
  store i64 %v56, ptr %st35
  %v57.p = getelementptr i64, ptr %v42, i64 1
  %v57 = load i64, ptr %v57.p
  %st36 = getelementptr i64, ptr %v0, i64 1
  store i64 %v57, ptr %st36
  %v58.p = getelementptr i64, ptr %v42, i64 2
  %v58 = load i64, ptr %v58.p
  %st37 = getelementptr i64, ptr %v0, i64 2
  store i64 %v58, ptr %st37
  %v59.p = getelementptr i64, ptr %v50, i64 0
  %v59 = load i64, ptr %v59.p
  %st38 = getelementptr i64, ptr %v0, i64 3
  store i64 %v59, ptr %st38
  %v60.p = getelementptr i64, ptr %v50, i64 1
  %v60 = load i64, ptr %v60.p
  %st39 = getelementptr i64, ptr %v0, i64 4
  store i64 %v60, ptr %st39
  %v61.p = getelementptr i64, ptr %v50, i64 2
  %v61 = load i64, ptr %v61.p
  %st40 = getelementptr i64, ptr %v0, i64 5
  store i64 %v61, ptr %st40
  %v62.p = getelementptr i64, ptr %v50, i64 3
  %v62 = load i64, ptr %v62.p
  %st41 = getelementptr i64, ptr %v0, i64 6
  store i64 %v62, ptr %st41
  %v63.p = getelementptr i64, ptr %v50, i64 4
  %v63 = load i64, ptr %v63.p
  %st42 = getelementptr i64, ptr %v0, i64 7
  store i64 %v63, ptr %st42
  call void @"rt.region_relocate8"(ptr %v0, i64 %v25)
  %v64.p = getelementptr i64, ptr %v0, i64 3
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 0
  %v66.c = icmp ne i64 %v64, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b1 = icmp ne i64 %v66, 0
  br i1 %c.b1, label %b1.t44, label %b1.e45
b1.t44:
  br label %b3
b1.e45:
  br label %b4
b2:
  br label %b5
b3:
  %v67 = add i64 0, 4
  %v68 = getelementptr i64, ptr %v0, i64 %v67
  call void @"rt.err_relocate"(ptr %v68, i64 %v25)
  br label %b4
b4:
  %v504 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v504, i64 0
  store i64 %v25, ptr %st45
  ret void
b5:
  %v69 = getelementptr i64, ptr %s10, i64 0
  %v70.p = getelementptr i64, ptr %v19, i64 0
  %v70 = load i64, ptr %v70.p
  %v71.p = getelementptr i64, ptr %v19, i64 1
  %v71 = load i64, ptr %v71.p
  %v72.p = getelementptr i64, ptr %v19, i64 2
  %v72 = load i64, ptr %v72.p
  %v73.p = getelementptr i64, ptr %v20, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.p = getelementptr i64, ptr %v20, i64 1
  %v74 = load i64, ptr %v74.p
  %v75.p = getelementptr i64, ptr %v20, i64 2
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 1
  %v77.p = getelementptr i64, ptr %v22, i64 0
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v22, i64 1
  %v78 = load i64, ptr %v78.p
  %v79.p = getelementptr i64, ptr %v22, i64 2
  %v79 = load i64, ptr %v79.p
  %v80 = getelementptr i64, ptr @"rt.meta", i64 0
  %st46 = getelementptr i64, ptr %v80, i64 2571
  store i64 %v35, ptr %st46
  call void @"std/crypto/chacha20.XorKeyStream"(ptr %v69, i64 %v70, i64 %v71, i64 %v72, i64 %v73, i64 %v74, i64 %v75, i64 %v76, i64 %v77, i64 %v78, i64 %v79)
  %v81 = getelementptr i64, ptr %s6, i64 0
  %v82.p = getelementptr i64, ptr %v69, i64 0
  %v82 = load i64, ptr %v82.p
  %st47 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st47
  %v83.p = getelementptr i64, ptr %v69, i64 1
  %v83 = load i64, ptr %v83.p
  %st48 = getelementptr i64, ptr %v81, i64 1
  store i64 %v83, ptr %st48
  %v84.p = getelementptr i64, ptr %v69, i64 2
  %v84 = load i64, ptr %v84.p
  %st49 = getelementptr i64, ptr %v81, i64 2
  store i64 %v84, ptr %st49
  %v85.p = getelementptr i64, ptr %v23, i64 1
  %v85 = load i64, ptr %v85.p
  %v86 = add i64 0, 0
  %v87 = call ptr @"rt.region_alloc8"(i64 %v35, i64 %v86)
  %v88 = add i64 0, 0
  %v89 = getelementptr i64, ptr %s11, i64 0
  %v90 = ptrtoint ptr %v87 to i64
  %st50 = getelementptr i64, ptr %v89, i64 0
  store i64 %v90, ptr %st50
  %st51 = getelementptr i64, ptr %v89, i64 1
  store i64 %v88, ptr %st51
  %st52 = getelementptr i64, ptr %v89, i64 2
  store i64 %v35, ptr %st52
  %v91 = getelementptr i64, ptr %s12, i64 0
  %v92.p = getelementptr i64, ptr %v89, i64 0
  %v92 = load i64, ptr %v92.p
  %st53 = getelementptr i64, ptr %v91, i64 0
  store i64 %v92, ptr %st53
  %v93.p = getelementptr i64, ptr %v89, i64 1
  %v93 = load i64, ptr %v93.p
  %st54 = getelementptr i64, ptr %v91, i64 1
  store i64 %v93, ptr %st54
  %v94.p = getelementptr i64, ptr %v89, i64 2
  %v94 = load i64, ptr %v94.p
  %st55 = getelementptr i64, ptr %v91, i64 2
  store i64 %v94, ptr %st55
  %v95 = add i64 0, 0
  %v96 = getelementptr i64, ptr %s7, i64 0
  %st56 = getelementptr i64, ptr %v96, i64 0
  store i64 %v95, ptr %st56
  %v97 = add i64 0, 0
  %v98 = add i64 0, 0
  %v99.p = getelementptr i64, ptr %v96, i64 0
  %v99 = load i64, ptr %v99.p
  %v100 = sub i64 %v85, %v99
  %v101 = add i64 0, 0
  %v102.c = icmp sle i64 %v100, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b5 = icmp ne i64 %v102, 0
  br i1 %c.b5, label %b5.t58, label %b5.e59
b5.t58:
  br label %b8
b5.e59:
  br label %b9
b6:
  %v112 = getelementptr i64, ptr %s11, i64 0
  %v113.p = getelementptr i64, ptr %v91, i64 0
  %v113 = load i64, ptr %v113.p
  %st59 = getelementptr i64, ptr %v112, i64 0
  store i64 %v113, ptr %st59
  %v114.p = getelementptr i64, ptr %v91, i64 1
  %v114 = load i64, ptr %v114.p
  %st60 = getelementptr i64, ptr %v112, i64 1
  store i64 %v114, ptr %st60
  %v115.p = getelementptr i64, ptr %v91, i64 2
  %v115 = load i64, ptr %v115.p
  %st61 = getelementptr i64, ptr %v112, i64 2
  store i64 %v115, ptr %st61
  %v116.p = getelementptr i64, ptr %v112, i64 2
  %v116 = load i64, ptr %v116.p
  %v117.p = getelementptr i64, ptr %v112, i64 0
  %v117 = load i64, ptr %v117.p
  %v118.p = getelementptr i64, ptr %v112, i64 1
  %v118 = load i64, ptr %v118.p
  %v119 = add i64 %v117, %v118
  %v122 = getelementptr i64, ptr @"rt.btip", i64 0
  %v123 = getelementptr i64, ptr %v122, i64 %v116
  %v124.p = getelementptr i64, ptr %v123, i64 0
  %v124 = load i64, ptr %v124.p
  %v125.c = icmp eq i64 %v124, %v119
  %v125 = zext i1 %v125.c to i64
  %c.b6 = icmp ne i64 %v125, 0
  br i1 %c.b6, label %b6.t63, label %b6.e64
b6.t63:
  br label %b13
b6.e64:
  br label %b11
b7:
  %v505 = getelementptr i64, ptr @"rt.meta", i64 0
  %v168.p = getelementptr i64, ptr %v505, i64 0
  %v168 = load i64, ptr %v168.p
  br label %b19
b8:
  %v211 = add i64 0, 0
  %v212 = getelementptr i64, ptr %s16, i64 0
  %st64 = getelementptr i64, ptr %v212, i64 0
  store i64 %v211, ptr %st64
  %v213.p = getelementptr i64, ptr %v81, i64 1
  %v213 = load i64, ptr %v213.p
  %v214 = add i64 0, 0
  %v215 = add i64 0, 0
  %v216.p = getelementptr i64, ptr %v212, i64 0
  %v216 = load i64, ptr %v216.p
  %v217 = sub i64 %v213, %v216
  %v218 = add i64 0, 0
  %v219.c = icmp sle i64 %v217, %v218
  %v219 = zext i1 %v219.c to i64
  %c.b8 = icmp ne i64 %v219, 0
  br i1 %c.b8, label %b8.t66, label %b8.e67
b8.t66:
  br label %b29
b8.e67:
  br label %b30
b9:
  %v103.p = getelementptr i64, ptr %v23, i64 1
  %v103 = load i64, ptr %v103.p
  %v104 = add i64 %v98, %v99
  %v105.c = icmp sge i64 %v104, %v101
  %v105 = zext i1 %v105.c to i64
  %v106 = add i64 %v98, %v85
  %v107.c = icmp sle i64 %v106, %v103
  %v107 = zext i1 %v107.c to i64
  %v108 = and i64 %v105, %v107
  %v109.c = icmp sge i64 %v99, %v101
  %v109 = zext i1 %v109.c to i64
  %v110 = and i64 %v108, %v109
  %v111.c = icmp ne i64 %v110, %v101
  %v111 = zext i1 %v111.c to i64
  %c.b9 = icmp ne i64 %v111, 0
  br i1 %c.b9, label %b9.t68, label %b9.e69
b9.t68:
  br label %b6
b9.e69:
  br label %b7
b10:
  %v120 = phi ptr [ %v155, %b11 ], [ %v152, %b12 ]
  %v121 = phi ptr [ %v157, %b11 ], [ %v153, %b12 ]
  %v158.p = getelementptr i64, ptr %v23, i64 0
  %v158 = load i64, ptr %v158.p
  %v159 = inttoptr i64 %v158 to ptr
  %v160 = getelementptr i8, ptr %v159, i64 %v104
  call void @"rt.copy8"(ptr %v121, ptr %v160, i64 %v100)
  %v161.p = getelementptr i64, ptr %v112, i64 1
  %v161 = load i64, ptr %v161.p
  %v162 = add i64 %v161, %v100
  %v163 = getelementptr i64, ptr %s13, i64 0
  %v164 = ptrtoint ptr %v120 to i64
  %st69 = getelementptr i64, ptr %v163, i64 0
  store i64 %v164, ptr %st69
  %st70 = getelementptr i64, ptr %v163, i64 1
  store i64 %v162, ptr %st70
  %st71 = getelementptr i64, ptr %v163, i64 2
  store i64 %v116, ptr %st71
  %v165.p = getelementptr i64, ptr %v163, i64 0
  %v165 = load i64, ptr %v165.p
  %st72 = getelementptr i64, ptr %v91, i64 0
  store i64 %v165, ptr %st72
  %v166.p = getelementptr i64, ptr %v163, i64 1
  %v166 = load i64, ptr %v166.p
  %st73 = getelementptr i64, ptr %v91, i64 1
  store i64 %v166, ptr %st73
  %v167.p = getelementptr i64, ptr %v163, i64 2
  %v167 = load i64, ptr %v167.p
  %st74 = getelementptr i64, ptr %v91, i64 2
  store i64 %v167, ptr %st74
  %st75 = getelementptr i64, ptr %v96, i64 0
  store i64 %v85, ptr %st75
  br label %b8
b11:
  %v154 = add i64 %v118, %v100
  %v155 = call ptr @"rt.region_alloc8"(i64 %v116, i64 %v154)
  %v156 = inttoptr i64 %v117 to ptr
  call void @"rt.copy8"(ptr %v155, ptr %v156, i64 %v118)
  %v157 = getelementptr i8, ptr %v155, i64 %v118
  br label %b10
b12:
  %v152 = inttoptr i64 %v117 to ptr
  %v153 = getelementptr i8, ptr %v152, i64 %v118
  br label %b10
b13:
  %v126 = add i64 0, 7
  %v127 = add i64 %v119, %v126
  %v128 = add i64 0, -8
  %v129 = and i64 %v127, %v128
  %v130 = add i64 %v119, %v100
  %v131 = add i64 0, 7
  %v132 = add i64 %v130, %v131
  %v133 = add i64 0, -8
  %v134 = and i64 %v132, %v133
  %v135 = getelementptr i64, ptr @"rt.meta", i64 0
  %v136 = getelementptr i64, ptr %v135, i64 %v116
  %v137.p = getelementptr i64, ptr %v136, i64 1
  %v137 = load i64, ptr %v137.p
  %v138.c = icmp sle i64 %v130, %v129
  %v138 = zext i1 %v138.c to i64
  %v139.c = icmp eq i64 %v137, %v129
  %v139 = zext i1 %v139.c to i64
  %v140 = or i64 %v138, %v139
  %v141 = add i64 0, 0
  %v142.c = icmp ne i64 %v140, %v141
  %v142 = zext i1 %v142.c to i64
  %c.b13 = icmp ne i64 %v142, 0
  br i1 %c.b13, label %b13.t77, label %b13.e78
b13.t77:
  br label %b14
b13.e78:
  br label %b11
b14:
  %v143.c = icmp sgt i64 %v134, %v137
  %v143 = zext i1 %v143.c to i64
  %c.b14 = icmp ne i64 %v143, 0
  br i1 %c.b14, label %b14.t79, label %b14.e80
b14.t79:
  br label %b15
b14.e80:
  br label %b16
b15:
  %v144.p = getelementptr i64, ptr %v135, i64 1029
  %v144 = load i64, ptr %v144.p
  %v145 = add i64 0, 1
  %v146 = add i64 %v116, %v145
  %v147.p = getelementptr i64, ptr %v135, i64 1030
  %v147 = load i64, ptr %v147.p
  %v148 = mul i64 %v146, %v147
  %v149 = add i64 %v144, %v148
  %v150.c = icmp sgt i64 %v134, %v149
  %v150 = zext i1 %v150.c to i64
  %c.b15 = icmp ne i64 %v150, 0
  br i1 %c.b15, label %b15.t81, label %b15.e82
b15.t81:
  br label %b17
b15.e82:
  br label %b18
b16:
  %st82 = getelementptr i64, ptr %v123, i64 0
  store i64 %v130, ptr %st82
  br label %b12
b17:
  %v151 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v151)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b18:
  %st83 = getelementptr i64, ptr %v136, i64 1
  store i64 %v134, ptr %st83
  br label %b16
b19:
  %v506 = getelementptr i64, ptr @"rt.meta", i64 0
  %st84 = getelementptr i64, ptr %v506, i64 0
  store i64 %v168, ptr %st84
  %v169.p = getelementptr i64, ptr %v96, i64 0
  %v169 = load i64, ptr %v169.p
  %v170.c = icmp slt i64 %v169, %v85
  %v170 = zext i1 %v170.c to i64
  %c.b19 = icmp ne i64 %v170, 0
  br i1 %c.b19, label %b19.t86, label %b19.e87
b19.t86:
  br label %b20
b19.e87:
  br label %b21
b20:
  call void @"rt.region_enter"()
  %v507 = getelementptr i64, ptr @"rt.meta", i64 0
  %v171.p = getelementptr i64, ptr %v507, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = add i64 0, 1
  %v173 = add i64 %v25, %v172
  %v174 = getelementptr i64, ptr %s14, i64 0
  %v175.p = getelementptr i64, ptr %v91, i64 0
  %v175 = load i64, ptr %v175.p
  %st87 = getelementptr i64, ptr %v174, i64 0
  store i64 %v175, ptr %st87
  %v176.p = getelementptr i64, ptr %v91, i64 1
  %v176 = load i64, ptr %v176.p
  %st88 = getelementptr i64, ptr %v174, i64 1
  store i64 %v176, ptr %st88
  %v177.p = getelementptr i64, ptr %v91, i64 2
  %v177 = load i64, ptr %v177.p
  %st89 = getelementptr i64, ptr %v174, i64 2
  store i64 %v177, ptr %st89
  %v178.p = getelementptr i64, ptr %v96, i64 0
  %v178 = load i64, ptr %v178.p
  %v179.p = getelementptr i64, ptr %v23, i64 1
  %v179 = load i64, ptr %v179.p
  %v180.c = icmp uge i64 %v178, %v179
  %v180 = zext i1 %v180.c to i64
  %c.b20 = icmp ne i64 %v180, 0
  br i1 %c.b20, label %b20.t91, label %b20.e92
b20.t91:
  br label %b22
b20.e92:
  br label %b23
b21:
  %v508 = getelementptr i64, ptr @"rt.meta", i64 0
  %st92 = getelementptr i64, ptr %v508, i64 0
  store i64 %v168, ptr %st92
  br label %b8
b22:
  %v181 = add i64 0, 66
  call void @"rt.panic"(i64 %v181)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b23:
  %v182.p = getelementptr i64, ptr %v23, i64 0
  %v182 = load i64, ptr %v182.p
  %v183 = inttoptr i64 %v182 to ptr
  %v184 = getelementptr i8, ptr %v183, i64 %v178
  %v185.p = getelementptr i8, ptr %v184, i64 0
  %v185.b = load i8, ptr %v185.p
  %v185 = zext i8 %v185.b to i64
  %v186.p = getelementptr i64, ptr %v174, i64 2
  %v186 = load i64, ptr %v186.p
  %v187.p = getelementptr i64, ptr %v174, i64 0
  %v187 = load i64, ptr %v187.p
  %v188.p = getelementptr i64, ptr %v174, i64 1
  %v188 = load i64, ptr %v188.p
  %v191 = add i64 %v187, %v188
  %v192 = call i64 @"rt.tip8"(i64 %v186, i64 %v191)
  %v193 = add i64 0, 0
  %v194.c = icmp ne i64 %v192, %v193
  %v194 = zext i1 %v194.c to i64
  %c.b23 = icmp ne i64 %v194, 0
  br i1 %c.b23, label %b23.t94, label %b23.e95
b23.t94:
  br label %b26
b23.e95:
  br label %b25
b24:
  %v189 = phi ptr [ %v198, %b25 ], [ %v195, %b26 ]
  %v190 = phi ptr [ %v199, %b25 ], [ %v196, %b26 ]
  %st95 = getelementptr i8, ptr %v190, i64 0
  %st95.b = trunc i64 %v185 to i8
  store i8 %st95.b, ptr %st95
  %v200.p = getelementptr i64, ptr %v174, i64 1
  %v200 = load i64, ptr %v200.p
  %v201 = add i64 0, 1
  %v202 = add i64 %v200, %v201
  %v203 = getelementptr i64, ptr %s15, i64 0
  %v204 = ptrtoint ptr %v189 to i64
  %st96 = getelementptr i64, ptr %v203, i64 0
  store i64 %v204, ptr %st96
  %st97 = getelementptr i64, ptr %v203, i64 1
  store i64 %v202, ptr %st97
  %st98 = getelementptr i64, ptr %v203, i64 2
  store i64 %v186, ptr %st98
  %v205.p = getelementptr i64, ptr %v203, i64 0
  %v205 = load i64, ptr %v205.p
  %st99 = getelementptr i64, ptr %v91, i64 0
  store i64 %v205, ptr %st99
  %v206.p = getelementptr i64, ptr %v203, i64 1
  %v206 = load i64, ptr %v206.p
  %st100 = getelementptr i64, ptr %v91, i64 1
  store i64 %v206, ptr %st100
  %v207.p = getelementptr i64, ptr %v203, i64 2
  %v207 = load i64, ptr %v207.p
  %st101 = getelementptr i64, ptr %v91, i64 2
  store i64 %v207, ptr %st101
  %v208 = add i64 0, 1
  %v209.p = getelementptr i64, ptr %v96, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = add i64 %v209, %v208
  %st102 = getelementptr i64, ptr %v96, i64 0
  store i64 %v210, ptr %st102
  br label %b19
b25:
  %v197 = add i64 0, 1
  %v198 = call ptr @"rt.slice_grow8"(i64 %v187, i64 %v188, i64 %v186, i64 %v197)
  %v199 = getelementptr i8, ptr %v198, i64 %v188
  br label %b24
b26:
  %v195 = inttoptr i64 %v187 to ptr
  %v196 = getelementptr i8, ptr %v195, i64 %v188
  br label %b24
b27:
  %v229 = getelementptr i64, ptr %s13, i64 0
  %v230.p = getelementptr i64, ptr %v91, i64 0
  %v230 = load i64, ptr %v230.p
  %st103 = getelementptr i64, ptr %v229, i64 0
  store i64 %v230, ptr %st103
  %v231.p = getelementptr i64, ptr %v91, i64 1
  %v231 = load i64, ptr %v231.p
  %st104 = getelementptr i64, ptr %v229, i64 1
  store i64 %v231, ptr %st104
  %v232.p = getelementptr i64, ptr %v91, i64 2
  %v232 = load i64, ptr %v232.p
  %st105 = getelementptr i64, ptr %v229, i64 2
  store i64 %v232, ptr %st105
  %v233.p = getelementptr i64, ptr %v229, i64 2
  %v233 = load i64, ptr %v233.p
  %v234.p = getelementptr i64, ptr %v229, i64 0
  %v234 = load i64, ptr %v234.p
  %v235.p = getelementptr i64, ptr %v229, i64 1
  %v235 = load i64, ptr %v235.p
  %v236 = add i64 %v234, %v235
  %v239 = getelementptr i64, ptr @"rt.btip", i64 0
  %v240 = getelementptr i64, ptr %v239, i64 %v233
  %v241.p = getelementptr i64, ptr %v240, i64 0
  %v241 = load i64, ptr %v241.p
  %v242.c = icmp eq i64 %v241, %v236
  %v242 = zext i1 %v242.c to i64
  %c.b27 = icmp ne i64 %v242, 0
  br i1 %c.b27, label %b27.t107, label %b27.e108
b27.t107:
  br label %b34
b27.e108:
  br label %b32
b28:
  %v509 = getelementptr i64, ptr @"rt.meta", i64 0
  %v285.p = getelementptr i64, ptr %v509, i64 0
  %v285 = load i64, ptr %v285.p
  br label %b40
b29:
  %v329.p = getelementptr i64, ptr %v24, i64 1
  %v329 = load i64, ptr %v329.p
  %v330 = add i64 0, 0
  %v331.c = icmp sgt i64 %v329, %v330
  %v331 = zext i1 %v331.c to i64
  %c.b29 = icmp ne i64 %v331, 0
  br i1 %c.b29, label %b29.t109, label %b29.e110
b29.t109:
  br label %b48
b29.e110:
  br label %b49
b30:
  %v220.p = getelementptr i64, ptr %v81, i64 1
  %v220 = load i64, ptr %v220.p
  %v221 = add i64 %v215, %v216
  %v222.c = icmp sge i64 %v221, %v218
  %v222 = zext i1 %v222.c to i64
  %v223 = add i64 %v215, %v213
  %v224.c = icmp sle i64 %v223, %v220
  %v224 = zext i1 %v224.c to i64
  %v225 = and i64 %v222, %v224
  %v226.c = icmp sge i64 %v216, %v218
  %v226 = zext i1 %v226.c to i64
  %v227 = and i64 %v225, %v226
  %v228.c = icmp ne i64 %v227, %v218
  %v228 = zext i1 %v228.c to i64
  %c.b30 = icmp ne i64 %v228, 0
  br i1 %c.b30, label %b30.t111, label %b30.e112
b30.t111:
  br label %b27
b30.e112:
  br label %b28
b31:
  %v237 = phi ptr [ %v272, %b32 ], [ %v269, %b33 ]
  %v238 = phi ptr [ %v274, %b32 ], [ %v270, %b33 ]
  %v275.p = getelementptr i64, ptr %v81, i64 0
  %v275 = load i64, ptr %v275.p
  %v276 = inttoptr i64 %v275 to ptr
  %v277 = getelementptr i8, ptr %v276, i64 %v221
  call void @"rt.copy8"(ptr %v238, ptr %v277, i64 %v217)
  %v278.p = getelementptr i64, ptr %v229, i64 1
  %v278 = load i64, ptr %v278.p
  %v279 = add i64 %v278, %v217
  %v280 = getelementptr i64, ptr %s11, i64 0
  %v281 = ptrtoint ptr %v237 to i64
  %st112 = getelementptr i64, ptr %v280, i64 0
  store i64 %v281, ptr %st112
  %st113 = getelementptr i64, ptr %v280, i64 1
  store i64 %v279, ptr %st113
  %st114 = getelementptr i64, ptr %v280, i64 2
  store i64 %v233, ptr %st114
  %v282.p = getelementptr i64, ptr %v280, i64 0
  %v282 = load i64, ptr %v282.p
  %st115 = getelementptr i64, ptr %v91, i64 0
  store i64 %v282, ptr %st115
  %v283.p = getelementptr i64, ptr %v280, i64 1
  %v283 = load i64, ptr %v283.p
  %st116 = getelementptr i64, ptr %v91, i64 1
  store i64 %v283, ptr %st116
  %v284.p = getelementptr i64, ptr %v280, i64 2
  %v284 = load i64, ptr %v284.p
  %st117 = getelementptr i64, ptr %v91, i64 2
  store i64 %v284, ptr %st117
  %st118 = getelementptr i64, ptr %v212, i64 0
  store i64 %v213, ptr %st118
  br label %b29
b32:
  %v271 = add i64 %v235, %v217
  %v272 = call ptr @"rt.region_alloc8"(i64 %v233, i64 %v271)
  %v273 = inttoptr i64 %v234 to ptr
  call void @"rt.copy8"(ptr %v272, ptr %v273, i64 %v235)
  %v274 = getelementptr i8, ptr %v272, i64 %v235
  br label %b31
b33:
  %v269 = inttoptr i64 %v234 to ptr
  %v270 = getelementptr i8, ptr %v269, i64 %v235
  br label %b31
b34:
  %v243 = add i64 0, 7
  %v244 = add i64 %v236, %v243
  %v245 = add i64 0, -8
  %v246 = and i64 %v244, %v245
  %v247 = add i64 %v236, %v217
  %v248 = add i64 0, 7
  %v249 = add i64 %v247, %v248
  %v250 = add i64 0, -8
  %v251 = and i64 %v249, %v250
  %v252 = getelementptr i64, ptr @"rt.meta", i64 0
  %v253 = getelementptr i64, ptr %v252, i64 %v233
  %v254.p = getelementptr i64, ptr %v253, i64 1
  %v254 = load i64, ptr %v254.p
  %v255.c = icmp sle i64 %v247, %v246
  %v255 = zext i1 %v255.c to i64
  %v256.c = icmp eq i64 %v254, %v246
  %v256 = zext i1 %v256.c to i64
  %v257 = or i64 %v255, %v256
  %v258 = add i64 0, 0
  %v259.c = icmp ne i64 %v257, %v258
  %v259 = zext i1 %v259.c to i64
  %c.b34 = icmp ne i64 %v259, 0
  br i1 %c.b34, label %b34.t120, label %b34.e121
b34.t120:
  br label %b35
b34.e121:
  br label %b32
b35:
  %v260.c = icmp sgt i64 %v251, %v254
  %v260 = zext i1 %v260.c to i64
  %c.b35 = icmp ne i64 %v260, 0
  br i1 %c.b35, label %b35.t122, label %b35.e123
b35.t122:
  br label %b36
b35.e123:
  br label %b37
b36:
  %v261.p = getelementptr i64, ptr %v252, i64 1029
  %v261 = load i64, ptr %v261.p
  %v262 = add i64 0, 1
  %v263 = add i64 %v233, %v262
  %v264.p = getelementptr i64, ptr %v252, i64 1030
  %v264 = load i64, ptr %v264.p
  %v265 = mul i64 %v263, %v264
  %v266 = add i64 %v261, %v265
  %v267.c = icmp sgt i64 %v251, %v266
  %v267 = zext i1 %v267.c to i64
  %c.b36 = icmp ne i64 %v267, 0
  br i1 %c.b36, label %b36.t124, label %b36.e125
b36.t124:
  br label %b38
b36.e125:
  br label %b39
b37:
  %st125 = getelementptr i64, ptr %v240, i64 0
  store i64 %v247, ptr %st125
  br label %b33
b38:
  %v268 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v268)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b39:
  %st126 = getelementptr i64, ptr %v253, i64 1
  store i64 %v251, ptr %st126
  br label %b37
b40:
  %v510 = getelementptr i64, ptr @"rt.meta", i64 0
  %st127 = getelementptr i64, ptr %v510, i64 0
  store i64 %v285, ptr %st127
  %v286.p = getelementptr i64, ptr %v212, i64 0
  %v286 = load i64, ptr %v286.p
  %v287.p = getelementptr i64, ptr %v81, i64 1
  %v287 = load i64, ptr %v287.p
  %v288.c = icmp slt i64 %v286, %v287
  %v288 = zext i1 %v288.c to i64
  %c.b40 = icmp ne i64 %v288, 0
  br i1 %c.b40, label %b40.t129, label %b40.e130
b40.t129:
  br label %b41
b40.e130:
  br label %b42
b41:
  call void @"rt.region_enter"()
  %v511 = getelementptr i64, ptr @"rt.meta", i64 0
  %v289.p = getelementptr i64, ptr %v511, i64 0
  %v289 = load i64, ptr %v289.p
  %v290 = add i64 0, 1
  %v291 = add i64 %v25, %v290
  %v292 = getelementptr i64, ptr %s15, i64 0
  %v293.p = getelementptr i64, ptr %v91, i64 0
  %v293 = load i64, ptr %v293.p
  %st130 = getelementptr i64, ptr %v292, i64 0
  store i64 %v293, ptr %st130
  %v294.p = getelementptr i64, ptr %v91, i64 1
  %v294 = load i64, ptr %v294.p
  %st131 = getelementptr i64, ptr %v292, i64 1
  store i64 %v294, ptr %st131
  %v295.p = getelementptr i64, ptr %v91, i64 2
  %v295 = load i64, ptr %v295.p
  %st132 = getelementptr i64, ptr %v292, i64 2
  store i64 %v295, ptr %st132
  %v296.p = getelementptr i64, ptr %v212, i64 0
  %v296 = load i64, ptr %v296.p
  %v297.p = getelementptr i64, ptr %v81, i64 1
  %v297 = load i64, ptr %v297.p
  %v298.c = icmp uge i64 %v296, %v297
  %v298 = zext i1 %v298.c to i64
  %c.b41 = icmp ne i64 %v298, 0
  br i1 %c.b41, label %b41.t134, label %b41.e135
b41.t134:
  br label %b43
b41.e135:
  br label %b44
b42:
  %v512 = getelementptr i64, ptr @"rt.meta", i64 0
  %st135 = getelementptr i64, ptr %v512, i64 0
  store i64 %v285, ptr %st135
  br label %b29
b43:
  %v299 = add i64 0, 67
  call void @"rt.panic"(i64 %v299)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b44:
  %v300.p = getelementptr i64, ptr %v81, i64 0
  %v300 = load i64, ptr %v300.p
  %v301 = inttoptr i64 %v300 to ptr
  %v302 = getelementptr i8, ptr %v301, i64 %v296
  %v303.p = getelementptr i8, ptr %v302, i64 0
  %v303.b = load i8, ptr %v303.p
  %v303 = zext i8 %v303.b to i64
  %v304.p = getelementptr i64, ptr %v292, i64 2
  %v304 = load i64, ptr %v304.p
  %v305.p = getelementptr i64, ptr %v292, i64 0
  %v305 = load i64, ptr %v305.p
  %v306.p = getelementptr i64, ptr %v292, i64 1
  %v306 = load i64, ptr %v306.p
  %v309 = add i64 %v305, %v306
  %v310 = call i64 @"rt.tip8"(i64 %v304, i64 %v309)
  %v311 = add i64 0, 0
  %v312.c = icmp ne i64 %v310, %v311
  %v312 = zext i1 %v312.c to i64
  %c.b44 = icmp ne i64 %v312, 0
  br i1 %c.b44, label %b44.t137, label %b44.e138
b44.t137:
  br label %b47
b44.e138:
  br label %b46
b45:
  %v307 = phi ptr [ %v316, %b46 ], [ %v313, %b47 ]
  %v308 = phi ptr [ %v317, %b46 ], [ %v314, %b47 ]
  %st138 = getelementptr i8, ptr %v308, i64 0
  %st138.b = trunc i64 %v303 to i8
  store i8 %st138.b, ptr %st138
  %v318.p = getelementptr i64, ptr %v292, i64 1
  %v318 = load i64, ptr %v318.p
  %v319 = add i64 0, 1
  %v320 = add i64 %v318, %v319
  %v321 = getelementptr i64, ptr %s14, i64 0
  %v322 = ptrtoint ptr %v307 to i64
  %st139 = getelementptr i64, ptr %v321, i64 0
  store i64 %v322, ptr %st139
  %st140 = getelementptr i64, ptr %v321, i64 1
  store i64 %v320, ptr %st140
  %st141 = getelementptr i64, ptr %v321, i64 2
  store i64 %v304, ptr %st141
  %v323.p = getelementptr i64, ptr %v321, i64 0
  %v323 = load i64, ptr %v323.p
  %st142 = getelementptr i64, ptr %v91, i64 0
  store i64 %v323, ptr %st142
  %v324.p = getelementptr i64, ptr %v321, i64 1
  %v324 = load i64, ptr %v324.p
  %st143 = getelementptr i64, ptr %v91, i64 1
  store i64 %v324, ptr %st143
  %v325.p = getelementptr i64, ptr %v321, i64 2
  %v325 = load i64, ptr %v325.p
  %st144 = getelementptr i64, ptr %v91, i64 2
  store i64 %v325, ptr %st144
  %v326 = add i64 0, 1
  %v327.p = getelementptr i64, ptr %v212, i64 0
  %v327 = load i64, ptr %v327.p
  %v328 = add i64 %v327, %v326
  %st145 = getelementptr i64, ptr %v212, i64 0
  store i64 %v328, ptr %st145
  br label %b40
b46:
  %v315 = add i64 0, 1
  %v316 = call ptr @"rt.slice_grow8"(i64 %v305, i64 %v306, i64 %v304, i64 %v315)
  %v317 = getelementptr i8, ptr %v316, i64 %v306
  br label %b45
b47:
  %v313 = inttoptr i64 %v305 to ptr
  %v314 = getelementptr i8, ptr %v313, i64 %v306
  br label %b45
b48:
  %v332 = add i64 0, 1
  %v333 = add i64 %v25, %v332
  %v334.p = getelementptr i64, ptr %v19, i64 0
  %v334 = load i64, ptr %v334.p
  %v335.p = getelementptr i64, ptr %v19, i64 1
  %v335 = load i64, ptr %v335.p
  %v336.p = getelementptr i64, ptr %v19, i64 2
  %v336 = load i64, ptr %v336.p
  %v337.p = getelementptr i64, ptr %v20, i64 0
  %v337 = load i64, ptr %v337.p
  %v338.p = getelementptr i64, ptr %v20, i64 1
  %v338 = load i64, ptr %v338.p
  %v339.p = getelementptr i64, ptr %v20, i64 2
  %v339 = load i64, ptr %v339.p
  %v340.p = getelementptr i64, ptr %v22, i64 1
  %v340 = load i64, ptr %v340.p
  %v341.p = getelementptr i64, ptr %v24, i64 0
  %v341 = load i64, ptr %v341.p
  %v342.p = getelementptr i64, ptr %v24, i64 1
  %v342 = load i64, ptr %v342.p
  %v343.p = getelementptr i64, ptr %v24, i64 2
  %v343 = load i64, ptr %v343.p
  %v344 = getelementptr i64, ptr @"rt.meta", i64 0
  %st146 = getelementptr i64, ptr %v344, i64 2572
  store i64 %v333, ptr %st146
  call void @"std/crypto/chacha20poly1305.ctTail"(ptr %v91, i64 %v334, i64 %v335, i64 %v336, i64 %v337, i64 %v338, i64 %v339, i64 %v340, i64 %v341, i64 %v342, i64 %v343)
  br label %b50
b49:
  br label %b50
b50:
  %v345.p = getelementptr i64, ptr %v91, i64 1
  %v345 = load i64, ptr %v345.p
  %v346 = sub i64 %v345, %v85
  %v347 = getelementptr i64, ptr %s17, i64 0
  %v348 = getelementptr i64, ptr %s18, i64 0
  %v349.p = getelementptr i64, ptr %v19, i64 0
  %v349 = load i64, ptr %v349.p
  %v350.p = getelementptr i64, ptr %v19, i64 1
  %v350 = load i64, ptr %v350.p
  %v351.p = getelementptr i64, ptr %v19, i64 2
  %v351 = load i64, ptr %v351.p
  %v352.p = getelementptr i64, ptr %v20, i64 0
  %v352 = load i64, ptr %v352.p
  %v353.p = getelementptr i64, ptr %v20, i64 1
  %v353 = load i64, ptr %v353.p
  %v354.p = getelementptr i64, ptr %v20, i64 2
  %v354 = load i64, ptr %v354.p
  %v355 = getelementptr i64, ptr @"rt.meta", i64 0
  %st147 = getelementptr i64, ptr %v355, i64 2571
  store i64 %v35, ptr %st147
  call void @"std/crypto/chacha20poly1305.polyKey"(ptr %v348, i64 %v349, i64 %v350, i64 %v351, i64 %v352, i64 %v353, i64 %v354)
  %v356.p = getelementptr i64, ptr %v348, i64 0
  %v356 = load i64, ptr %v356.p
  %v357.p = getelementptr i64, ptr %v348, i64 1
  %v357 = load i64, ptr %v357.p
  %v358.p = getelementptr i64, ptr %v348, i64 2
  %v358 = load i64, ptr %v358.p
  %v359.p = getelementptr i64, ptr %v21, i64 0
  %v359 = load i64, ptr %v359.p
  %v360.p = getelementptr i64, ptr %v21, i64 1
  %v360 = load i64, ptr %v360.p
  %v361.p = getelementptr i64, ptr %v21, i64 2
  %v361 = load i64, ptr %v361.p
  %v362.p = getelementptr i64, ptr %v91, i64 0
  %v362 = load i64, ptr %v362.p
  %v363.p = getelementptr i64, ptr %v91, i64 1
  %v363 = load i64, ptr %v363.p
  %v364.p = getelementptr i64, ptr %v91, i64 2
  %v364 = load i64, ptr %v364.p
  %v365 = getelementptr i64, ptr @"rt.meta", i64 0
  %st148 = getelementptr i64, ptr %v365, i64 2571
  store i64 %v35, ptr %st148
  call void @"std/crypto/poly1305.SumAead"(ptr %v347, i64 %v356, i64 %v357, i64 %v358, i64 %v359, i64 %v360, i64 %v361, i64 %v362, i64 %v363, i64 %v364, i64 %v85, i64 %v346)
  %v366 = getelementptr i64, ptr %s11, i64 0
  %v367.p = getelementptr i64, ptr %v347, i64 0
  %v367 = load i64, ptr %v367.p
  %st149 = getelementptr i64, ptr %v366, i64 0
  store i64 %v367, ptr %st149
  %v368.p = getelementptr i64, ptr %v347, i64 1
  %v368 = load i64, ptr %v368.p
  %st150 = getelementptr i64, ptr %v366, i64 1
  store i64 %v368, ptr %st150
  %v369.p = getelementptr i64, ptr %v347, i64 2
  %v369 = load i64, ptr %v369.p
  %st151 = getelementptr i64, ptr %v366, i64 2
  store i64 %v369, ptr %st151
  %v370 = add i64 0, 0
  %v371 = getelementptr i64, ptr %s19, i64 0
  %st152 = getelementptr i64, ptr %v371, i64 0
  store i64 %v370, ptr %st152
  %v372 = add i64 0, 16
  %v373 = add i64 0, 0
  %v374 = add i64 0, 0
  %v375.p = getelementptr i64, ptr %v371, i64 0
  %v375 = load i64, ptr %v375.p
  %v376 = sub i64 %v372, %v375
  %v377 = add i64 0, 0
  %v378.c = icmp sle i64 %v376, %v377
  %v378 = zext i1 %v378.c to i64
  %c.b50 = icmp ne i64 %v378, 0
  br i1 %c.b50, label %b50.t154, label %b50.e155
b50.t154:
  br label %b53
b50.e155:
  br label %b54
b51:
  %v388 = getelementptr i64, ptr %s13, i64 0
  %v389.p = getelementptr i64, ptr %v91, i64 0
  %v389 = load i64, ptr %v389.p
  %st155 = getelementptr i64, ptr %v388, i64 0
  store i64 %v389, ptr %st155
  %v390.p = getelementptr i64, ptr %v91, i64 1
  %v390 = load i64, ptr %v390.p
  %st156 = getelementptr i64, ptr %v388, i64 1
  store i64 %v390, ptr %st156
  %v391.p = getelementptr i64, ptr %v91, i64 2
  %v391 = load i64, ptr %v391.p
  %st157 = getelementptr i64, ptr %v388, i64 2
  store i64 %v391, ptr %st157
  %v392.p = getelementptr i64, ptr %v388, i64 2
  %v392 = load i64, ptr %v392.p
  %v393.p = getelementptr i64, ptr %v388, i64 0
  %v393 = load i64, ptr %v393.p
  %v394.p = getelementptr i64, ptr %v388, i64 1
  %v394 = load i64, ptr %v394.p
  %v395 = add i64 %v393, %v394
  %v398 = getelementptr i64, ptr @"rt.btip", i64 0
  %v399 = getelementptr i64, ptr %v398, i64 %v392
  %v400.p = getelementptr i64, ptr %v399, i64 0
  %v400 = load i64, ptr %v400.p
  %v401.c = icmp eq i64 %v400, %v395
  %v401 = zext i1 %v401.c to i64
  %c.b51 = icmp ne i64 %v401, 0
  br i1 %c.b51, label %b51.t159, label %b51.e160
b51.t159:
  br label %b58
b51.e160:
  br label %b56
b52:
  %v513 = getelementptr i64, ptr @"rt.meta", i64 0
  %v444.p = getelementptr i64, ptr %v513, i64 0
  %v444 = load i64, ptr %v444.p
  br label %b64
b53:
  %v488 = getelementptr i64, ptr %s9, i64 0
  %v489 = add i64 0, 0
  %st160 = getelementptr i64, ptr %v488, i64 0
  store i64 %v489, ptr %st160
  %v490.p = getelementptr i64, ptr %v91, i64 0
  %v490 = load i64, ptr %v490.p
  %st161 = getelementptr i64, ptr %v0, i64 0
  store i64 %v490, ptr %st161
  %v491.p = getelementptr i64, ptr %v91, i64 1
  %v491 = load i64, ptr %v491.p
  %st162 = getelementptr i64, ptr %v0, i64 1
  store i64 %v491, ptr %st162
  %v492.p = getelementptr i64, ptr %v91, i64 2
  %v492 = load i64, ptr %v492.p
  %st163 = getelementptr i64, ptr %v0, i64 2
  store i64 %v492, ptr %st163
  %v493.p = getelementptr i64, ptr %v488, i64 0
  %v493 = load i64, ptr %v493.p
  %st164 = getelementptr i64, ptr %v0, i64 3
  store i64 %v493, ptr %st164
  %v494.p = getelementptr i64, ptr %v488, i64 1
  %v494 = load i64, ptr %v494.p
  %st165 = getelementptr i64, ptr %v0, i64 4
  store i64 %v494, ptr %st165
  %v495.p = getelementptr i64, ptr %v488, i64 2
  %v495 = load i64, ptr %v495.p
  %st166 = getelementptr i64, ptr %v0, i64 5
  store i64 %v495, ptr %st166
  %v496.p = getelementptr i64, ptr %v488, i64 3
  %v496 = load i64, ptr %v496.p
  %st167 = getelementptr i64, ptr %v0, i64 6
  store i64 %v496, ptr %st167
  %v497.p = getelementptr i64, ptr %v488, i64 4
  %v497 = load i64, ptr %v497.p
  %st168 = getelementptr i64, ptr %v0, i64 7
  store i64 %v497, ptr %st168
  call void @"rt.region_relocate8"(ptr %v0, i64 %v25)
  %v498.p = getelementptr i64, ptr %v0, i64 3
  %v498 = load i64, ptr %v498.p
  %v499 = add i64 0, 0
  %v500.c = icmp ne i64 %v498, %v499
  %v500 = zext i1 %v500.c to i64
  %c.b53 = icmp ne i64 %v500, 0
  br i1 %c.b53, label %b53.t170, label %b53.e171
b53.t170:
  br label %b72
b53.e171:
  br label %b73
b54:
  %v379.p = getelementptr i64, ptr %v366, i64 1
  %v379 = load i64, ptr %v379.p
  %v380 = add i64 %v374, %v375
  %v381.c = icmp sge i64 %v380, %v377
  %v381 = zext i1 %v381.c to i64
  %v382 = add i64 %v374, %v372
  %v383.c = icmp sle i64 %v382, %v379
  %v383 = zext i1 %v383.c to i64
  %v384 = and i64 %v381, %v383
  %v385.c = icmp sge i64 %v375, %v377
  %v385 = zext i1 %v385.c to i64
  %v386 = and i64 %v384, %v385
  %v387.c = icmp ne i64 %v386, %v377
  %v387 = zext i1 %v387.c to i64
  %c.b54 = icmp ne i64 %v387, 0
  br i1 %c.b54, label %b54.t172, label %b54.e173
b54.t172:
  br label %b51
b54.e173:
  br label %b52
b55:
  %v396 = phi ptr [ %v431, %b56 ], [ %v428, %b57 ]
  %v397 = phi ptr [ %v433, %b56 ], [ %v429, %b57 ]
  %v434.p = getelementptr i64, ptr %v366, i64 0
  %v434 = load i64, ptr %v434.p
  %v435 = inttoptr i64 %v434 to ptr
  %v436 = getelementptr i8, ptr %v435, i64 %v380
  call void @"rt.copy8"(ptr %v397, ptr %v436, i64 %v376)
  %v437.p = getelementptr i64, ptr %v388, i64 1
  %v437 = load i64, ptr %v437.p
  %v438 = add i64 %v437, %v376
  %v439 = getelementptr i64, ptr %s14, i64 0
  %v440 = ptrtoint ptr %v396 to i64
  %st173 = getelementptr i64, ptr %v439, i64 0
  store i64 %v440, ptr %st173
  %st174 = getelementptr i64, ptr %v439, i64 1
  store i64 %v438, ptr %st174
  %st175 = getelementptr i64, ptr %v439, i64 2
  store i64 %v392, ptr %st175
  %v441.p = getelementptr i64, ptr %v439, i64 0
  %v441 = load i64, ptr %v441.p
  %st176 = getelementptr i64, ptr %v91, i64 0
  store i64 %v441, ptr %st176
  %v442.p = getelementptr i64, ptr %v439, i64 1
  %v442 = load i64, ptr %v442.p
  %st177 = getelementptr i64, ptr %v91, i64 1
  store i64 %v442, ptr %st177
  %v443.p = getelementptr i64, ptr %v439, i64 2
  %v443 = load i64, ptr %v443.p
  %st178 = getelementptr i64, ptr %v91, i64 2
  store i64 %v443, ptr %st178
  %st179 = getelementptr i64, ptr %v371, i64 0
  store i64 %v372, ptr %st179
  br label %b53
b56:
  %v430 = add i64 %v394, %v376
  %v431 = call ptr @"rt.region_alloc8"(i64 %v392, i64 %v430)
  %v432 = inttoptr i64 %v393 to ptr
  call void @"rt.copy8"(ptr %v431, ptr %v432, i64 %v394)
  %v433 = getelementptr i8, ptr %v431, i64 %v394
  br label %b55
b57:
  %v428 = inttoptr i64 %v393 to ptr
  %v429 = getelementptr i8, ptr %v428, i64 %v394
  br label %b55
b58:
  %v402 = add i64 0, 7
  %v403 = add i64 %v395, %v402
  %v404 = add i64 0, -8
  %v405 = and i64 %v403, %v404
  %v406 = add i64 %v395, %v376
  %v407 = add i64 0, 7
  %v408 = add i64 %v406, %v407
  %v409 = add i64 0, -8
  %v410 = and i64 %v408, %v409
  %v411 = getelementptr i64, ptr @"rt.meta", i64 0
  %v412 = getelementptr i64, ptr %v411, i64 %v392
  %v413.p = getelementptr i64, ptr %v412, i64 1
  %v413 = load i64, ptr %v413.p
  %v414.c = icmp sle i64 %v406, %v405
  %v414 = zext i1 %v414.c to i64
  %v415.c = icmp eq i64 %v413, %v405
  %v415 = zext i1 %v415.c to i64
  %v416 = or i64 %v414, %v415
  %v417 = add i64 0, 0
  %v418.c = icmp ne i64 %v416, %v417
  %v418 = zext i1 %v418.c to i64
  %c.b58 = icmp ne i64 %v418, 0
  br i1 %c.b58, label %b58.t181, label %b58.e182
b58.t181:
  br label %b59
b58.e182:
  br label %b56
b59:
  %v419.c = icmp sgt i64 %v410, %v413
  %v419 = zext i1 %v419.c to i64
  %c.b59 = icmp ne i64 %v419, 0
  br i1 %c.b59, label %b59.t183, label %b59.e184
b59.t183:
  br label %b60
b59.e184:
  br label %b61
b60:
  %v420.p = getelementptr i64, ptr %v411, i64 1029
  %v420 = load i64, ptr %v420.p
  %v421 = add i64 0, 1
  %v422 = add i64 %v392, %v421
  %v423.p = getelementptr i64, ptr %v411, i64 1030
  %v423 = load i64, ptr %v423.p
  %v424 = mul i64 %v422, %v423
  %v425 = add i64 %v420, %v424
  %v426.c = icmp sgt i64 %v410, %v425
  %v426 = zext i1 %v426.c to i64
  %c.b60 = icmp ne i64 %v426, 0
  br i1 %c.b60, label %b60.t185, label %b60.e186
b60.t185:
  br label %b62
b60.e186:
  br label %b63
b61:
  %st186 = getelementptr i64, ptr %v399, i64 0
  store i64 %v406, ptr %st186
  br label %b57
b62:
  %v427 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v427)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b63:
  %st187 = getelementptr i64, ptr %v412, i64 1
  store i64 %v410, ptr %st187
  br label %b61
b64:
  %v514 = getelementptr i64, ptr @"rt.meta", i64 0
  %st188 = getelementptr i64, ptr %v514, i64 0
  store i64 %v444, ptr %st188
  %v445.p = getelementptr i64, ptr %v371, i64 0
  %v445 = load i64, ptr %v445.p
  %v446 = add i64 0, 16
  %v447.c = icmp slt i64 %v445, %v446
  %v447 = zext i1 %v447.c to i64
  %c.b64 = icmp ne i64 %v447, 0
  br i1 %c.b64, label %b64.t190, label %b64.e191
b64.t190:
  br label %b65
b64.e191:
  br label %b66
b65:
  call void @"rt.region_enter"()
  %v515 = getelementptr i64, ptr @"rt.meta", i64 0
  %v448.p = getelementptr i64, ptr %v515, i64 0
  %v448 = load i64, ptr %v448.p
  %v449 = add i64 0, 1
  %v450 = add i64 %v25, %v449
  %v451 = getelementptr i64, ptr %s15, i64 0
  %v452.p = getelementptr i64, ptr %v91, i64 0
  %v452 = load i64, ptr %v452.p
  %st191 = getelementptr i64, ptr %v451, i64 0
  store i64 %v452, ptr %st191
  %v453.p = getelementptr i64, ptr %v91, i64 1
  %v453 = load i64, ptr %v453.p
  %st192 = getelementptr i64, ptr %v451, i64 1
  store i64 %v453, ptr %st192
  %v454.p = getelementptr i64, ptr %v91, i64 2
  %v454 = load i64, ptr %v454.p
  %st193 = getelementptr i64, ptr %v451, i64 2
  store i64 %v454, ptr %st193
  %v455.p = getelementptr i64, ptr %v371, i64 0
  %v455 = load i64, ptr %v455.p
  %v456.p = getelementptr i64, ptr %v366, i64 1
  %v456 = load i64, ptr %v456.p
  %v457.c = icmp uge i64 %v455, %v456
  %v457 = zext i1 %v457.c to i64
  %c.b65 = icmp ne i64 %v457, 0
  br i1 %c.b65, label %b65.t195, label %b65.e196
b65.t195:
  br label %b67
b65.e196:
  br label %b68
b66:
  %v516 = getelementptr i64, ptr @"rt.meta", i64 0
  %st196 = getelementptr i64, ptr %v516, i64 0
  store i64 %v444, ptr %st196
  br label %b53
b67:
  %v458 = add i64 0, 68
  call void @"rt.panic"(i64 %v458)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b68:
  %v459.p = getelementptr i64, ptr %v366, i64 0
  %v459 = load i64, ptr %v459.p
  %v460 = inttoptr i64 %v459 to ptr
  %v461 = getelementptr i8, ptr %v460, i64 %v455
  %v462.p = getelementptr i8, ptr %v461, i64 0
  %v462.b = load i8, ptr %v462.p
  %v462 = zext i8 %v462.b to i64
  %v463.p = getelementptr i64, ptr %v451, i64 2
  %v463 = load i64, ptr %v463.p
  %v464.p = getelementptr i64, ptr %v451, i64 0
  %v464 = load i64, ptr %v464.p
  %v465.p = getelementptr i64, ptr %v451, i64 1
  %v465 = load i64, ptr %v465.p
  %v468 = add i64 %v464, %v465
  %v469 = call i64 @"rt.tip8"(i64 %v463, i64 %v468)
  %v470 = add i64 0, 0
  %v471.c = icmp ne i64 %v469, %v470
  %v471 = zext i1 %v471.c to i64
  %c.b68 = icmp ne i64 %v471, 0
  br i1 %c.b68, label %b68.t198, label %b68.e199
b68.t198:
  br label %b71
b68.e199:
  br label %b70
b69:
  %v466 = phi ptr [ %v475, %b70 ], [ %v472, %b71 ]
  %v467 = phi ptr [ %v476, %b70 ], [ %v473, %b71 ]
  %st199 = getelementptr i8, ptr %v467, i64 0
  %st199.b = trunc i64 %v462 to i8
  store i8 %st199.b, ptr %st199
  %v477.p = getelementptr i64, ptr %v451, i64 1
  %v477 = load i64, ptr %v477.p
  %v478 = add i64 0, 1
  %v479 = add i64 %v477, %v478
  %v480 = getelementptr i64, ptr %s20, i64 0
  %v481 = ptrtoint ptr %v466 to i64
  %st200 = getelementptr i64, ptr %v480, i64 0
  store i64 %v481, ptr %st200
  %st201 = getelementptr i64, ptr %v480, i64 1
  store i64 %v479, ptr %st201
  %st202 = getelementptr i64, ptr %v480, i64 2
  store i64 %v463, ptr %st202
  %v482.p = getelementptr i64, ptr %v480, i64 0
  %v482 = load i64, ptr %v482.p
  %st203 = getelementptr i64, ptr %v91, i64 0
  store i64 %v482, ptr %st203
  %v483.p = getelementptr i64, ptr %v480, i64 1
  %v483 = load i64, ptr %v483.p
  %st204 = getelementptr i64, ptr %v91, i64 1
  store i64 %v483, ptr %st204
  %v484.p = getelementptr i64, ptr %v480, i64 2
  %v484 = load i64, ptr %v484.p
  %st205 = getelementptr i64, ptr %v91, i64 2
  store i64 %v484, ptr %st205
  %v485 = add i64 0, 1
  %v486.p = getelementptr i64, ptr %v371, i64 0
  %v486 = load i64, ptr %v486.p
  %v487 = add i64 %v486, %v485
  %st206 = getelementptr i64, ptr %v371, i64 0
  store i64 %v487, ptr %st206
  br label %b64
b70:
  %v474 = add i64 0, 1
  %v475 = call ptr @"rt.slice_grow8"(i64 %v464, i64 %v465, i64 %v463, i64 %v474)
  %v476 = getelementptr i8, ptr %v475, i64 %v465
  br label %b69
b71:
  %v472 = inttoptr i64 %v464 to ptr
  %v473 = getelementptr i8, ptr %v472, i64 %v465
  br label %b69
b72:
  %v501 = add i64 0, 4
  %v502 = getelementptr i64, ptr %v0, i64 %v501
  call void @"rt.err_relocate"(ptr %v502, i64 %v25)
  br label %b73
b73:
  %v517 = getelementptr i64, ptr @"rt.meta", i64 0
  %st207 = getelementptr i64, ptr %v517, i64 0
  store i64 %v25, ptr %st207
  ret void
}

define internal void @"std/crypto/chacha20poly1305.ctTail"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10) #0 {
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
  %s12 = alloca [3 x i64], align 8
  %s12.z0 = getelementptr i64, ptr %s12, i64 0
  store i64 0, ptr %s12.z0
  %s12.z1 = getelementptr i64, ptr %s12, i64 1
  store i64 0, ptr %s12.z1
  %s12.z2 = getelementptr i64, ptr %s12, i64 2
  store i64 0, ptr %s12.z2
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
  store i64 %v8, ptr %st6
  %st7 = getelementptr i64, ptr %v13, i64 1
  store i64 %v9, ptr %st7
  %st8 = getelementptr i64, ptr %v13, i64 2
  store i64 %v10, ptr %st8
  %v363 = getelementptr i64, ptr @"rt.meta", i64 0
  %v14.p = getelementptr i64, ptr %v363, i64 0
  %v14 = load i64, ptr %v14.p
  %v15 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v15, i64 2572
  %v16 = load i64, ptr %v16.p
  %v17 = add i64 0, 0
  %v18.c = icmp eq i64 %v16, %v17
  %v18 = zext i1 %v18.c to i64
  %v19 = mul i64 %v18, %v14
  %v20 = add i64 %v16, %v19
  %v21 = add i64 0, 64
  %v22 = srem i64 %v7, %v21
  %v364 = getelementptr i64, ptr @"rt.meta", i64 0
  %v23.p = getelementptr i64, ptr %v364, i64 0
  %v23 = load i64, ptr %v23.p
  %v24 = add i64 0, 0
  %v25 = call ptr @"rt.region_alloc8"(i64 %v23, i64 %v24)
  %v26 = add i64 0, 0
  %v27 = getelementptr i64, ptr %s3, i64 0
  %v28 = ptrtoint ptr %v25 to i64
  %st9 = getelementptr i64, ptr %v27, i64 0
  store i64 %v28, ptr %st9
  %st10 = getelementptr i64, ptr %v27, i64 1
  store i64 %v26, ptr %st10
  %st11 = getelementptr i64, ptr %v27, i64 2
  store i64 %v23, ptr %st11
  %v29 = getelementptr i64, ptr %s4, i64 0
  %v30.p = getelementptr i64, ptr %v27, i64 0
  %v30 = load i64, ptr %v30.p
  %st12 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st12
  %v31.p = getelementptr i64, ptr %v27, i64 1
  %v31 = load i64, ptr %v31.p
  %st13 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st13
  %v32.p = getelementptr i64, ptr %v27, i64 2
  %v32 = load i64, ptr %v32.p
  %st14 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st14
  %v33 = add i64 0, 0
  %v34 = getelementptr i64, ptr %s5, i64 0
  %st15 = getelementptr i64, ptr %v34, i64 0
  store i64 %v33, ptr %st15
  %v35 = add i64 0, 0
  %v36.p = getelementptr i64, ptr %v34, i64 0
  %v36 = load i64, ptr %v36.p
  %v37 = sub i64 %v22, %v36
  %v38 = add i64 0, 0
  %v39.c = icmp sle i64 %v37, %v38
  %v39 = zext i1 %v39.c to i64
  %c.b0 = icmp ne i64 %v39, 0
  br i1 %c.b0, label %b0.t17, label %b0.e18
b0.t17:
  br label %b1
b0.e18:
  br label %b2
b1:
  %v114 = add i64 0, 0
  %v115 = getelementptr i64, ptr %s7, i64 0
  %st18 = getelementptr i64, ptr %v115, i64 0
  store i64 %v114, ptr %st18
  %v116.p = getelementptr i64, ptr %v13, i64 1
  %v116 = load i64, ptr %v116.p
  %v117 = add i64 0, 0
  %v118 = add i64 0, 0
  %v119.p = getelementptr i64, ptr %v115, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = sub i64 %v116, %v119
  %v121 = add i64 0, 0
  %v122.c = icmp sle i64 %v120, %v121
  %v122 = zext i1 %v122.c to i64
  %c.b1 = icmp ne i64 %v122, 0
  br i1 %c.b1, label %b1.t20, label %b1.e21
b1.t20:
  br label %b20
b1.e21:
  br label %b21
b2:
  %v40 = getelementptr i64, ptr %s3, i64 0
  %v41.p = getelementptr i64, ptr %v29, i64 0
  %v41 = load i64, ptr %v41.p
  %st21 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st21
  %v42.p = getelementptr i64, ptr %v29, i64 1
  %v42 = load i64, ptr %v42.p
  %st22 = getelementptr i64, ptr %v40, i64 1
  store i64 %v42, ptr %st22
  %v43.p = getelementptr i64, ptr %v29, i64 2
  %v43 = load i64, ptr %v43.p
  %st23 = getelementptr i64, ptr %v40, i64 2
  store i64 %v43, ptr %st23
  %v44.p = getelementptr i64, ptr %v40, i64 2
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v40, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v40, i64 1
  %v46 = load i64, ptr %v46.p
  %v47 = add i64 %v45, %v46
  %v50 = getelementptr i64, ptr @"rt.btip", i64 0
  %v51 = getelementptr i64, ptr %v50, i64 %v44
  %v52.p = getelementptr i64, ptr %v51, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.c = icmp eq i64 %v52, %v47
  %v53 = zext i1 %v53.c to i64
  %c.b2 = icmp ne i64 %v53, 0
  br i1 %c.b2, label %b2.t25, label %b2.e26
b2.t25:
  br label %b6
b2.e26:
  br label %b4
b3:
  %v48 = phi ptr [ %v83, %b4 ], [ %v80, %b5 ]
  %v49 = phi ptr [ %v85, %b4 ], [ %v81, %b5 ]
  %v86 = add i64 0, 255
  %v87 = and i64 %v35, %v86
  %v88 = add i64 0, 72340172838076673
  %v89 = mul i64 %v87, %v88
  %v90 = add i64 0, 3
  %v91.n = and i64 %v90, 63
  %v91 = ashr i64 %v37, %v91.n
  %v93 = add i64 0, 0
  br label %b12
b4:
  %v82 = add i64 %v46, %v37
  %v83 = call ptr @"rt.region_alloc8"(i64 %v44, i64 %v82)
  %v84 = inttoptr i64 %v45 to ptr
  call void @"rt.copy8"(ptr %v83, ptr %v84, i64 %v46)
  %v85 = getelementptr i8, ptr %v83, i64 %v46
  br label %b3
b5:
  %v80 = inttoptr i64 %v45 to ptr
  %v81 = getelementptr i8, ptr %v80, i64 %v46
  br label %b3
b6:
  %v54 = add i64 0, 7
  %v55 = add i64 %v47, %v54
  %v56 = add i64 0, -8
  %v57 = and i64 %v55, %v56
  %v58 = add i64 %v47, %v37
  %v59 = add i64 0, 7
  %v60 = add i64 %v58, %v59
  %v61 = add i64 0, -8
  %v62 = and i64 %v60, %v61
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %v64 = getelementptr i64, ptr %v63, i64 %v44
  %v65.p = getelementptr i64, ptr %v64, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.c = icmp sle i64 %v58, %v57
  %v66 = zext i1 %v66.c to i64
  %v67.c = icmp eq i64 %v65, %v57
  %v67 = zext i1 %v67.c to i64
  %v68 = or i64 %v66, %v67
  %v69 = add i64 0, 0
  %v70.c = icmp ne i64 %v68, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b6 = icmp ne i64 %v70, 0
  br i1 %c.b6, label %b6.t27, label %b6.e28
b6.t27:
  br label %b7
b6.e28:
  br label %b4
b7:
  %v71.c = icmp sgt i64 %v62, %v65
  %v71 = zext i1 %v71.c to i64
  %c.b7 = icmp ne i64 %v71, 0
  br i1 %c.b7, label %b7.t29, label %b7.e30
b7.t29:
  br label %b8
b7.e30:
  br label %b9
b8:
  %v72.p = getelementptr i64, ptr %v63, i64 1029
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 1
  %v74 = add i64 %v44, %v73
  %v75.p = getelementptr i64, ptr %v63, i64 1030
  %v75 = load i64, ptr %v75.p
  %v76 = mul i64 %v74, %v75
  %v77 = add i64 %v72, %v76
  %v78.c = icmp sgt i64 %v62, %v77
  %v78 = zext i1 %v78.c to i64
  %c.b8 = icmp ne i64 %v78, 0
  br i1 %c.b8, label %b8.t31, label %b8.e32
b8.t31:
  br label %b10
b8.e32:
  br label %b11
b9:
  %st32 = getelementptr i64, ptr %v51, i64 0
  store i64 %v58, ptr %st32
  br label %b5
b10:
  %v79 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v79)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b11:
  %st33 = getelementptr i64, ptr %v64, i64 1
  store i64 %v62, ptr %st33
  br label %b9
b12:
  %v92 = phi i64 [ %v93, %b3 ], [ %v99, %b13 ]
  %v94.c = icmp slt i64 %v92, %v91
  %v94 = zext i1 %v94.c to i64
  %c.b12 = icmp ne i64 %v94, 0
  br i1 %c.b12, label %b12.t35, label %b12.e36
b12.t35:
  br label %b13
b12.e36:
  br label %b14
b13:
  %v95 = add i64 0, 3
  %v96.n = and i64 %v95, 63
  %v96 = shl i64 %v92, %v96.n
  %v97 = getelementptr i8, ptr %v49, i64 %v96
  %st36 = getelementptr i64, ptr %v97, i64 0
  store i64 %v89, ptr %st36, align 1
  %v98 = add i64 0, 1
  %v99 = add i64 %v92, %v98
  br label %b12
b14:
  %v101 = add i64 0, 3
  %v102.n = and i64 %v101, 63
  %v102 = shl i64 %v91, %v102.n
  br label %b15
b15:
  %v100 = phi i64 [ %v102, %b14 ], [ %v106, %b16 ]
  %v103.c = icmp slt i64 %v100, %v37
  %v103 = zext i1 %v103.c to i64
  %c.b15 = icmp ne i64 %v103, 0
  br i1 %c.b15, label %b15.t38, label %b15.e39
b15.t38:
  br label %b16
b15.e39:
  br label %b17
b16:
  %v104 = getelementptr i8, ptr %v49, i64 %v100
  %st39 = getelementptr i8, ptr %v104, i64 0
  %st39.b = trunc i64 %v35 to i8
  store i8 %st39.b, ptr %st39
  %v105 = add i64 0, 1
  %v106 = add i64 %v100, %v105
  br label %b15
b17:
  %v107.p = getelementptr i64, ptr %v40, i64 1
  %v107 = load i64, ptr %v107.p
  %v108 = add i64 %v107, %v37
  %v109 = getelementptr i64, ptr %s6, i64 0
  %v110 = ptrtoint ptr %v48 to i64
  %st40 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st40
  %st41 = getelementptr i64, ptr %v109, i64 1
  store i64 %v108, ptr %st41
  %st42 = getelementptr i64, ptr %v109, i64 2
  store i64 %v44, ptr %st42
  %v111.p = getelementptr i64, ptr %v109, i64 0
  %v111 = load i64, ptr %v111.p
  %st43 = getelementptr i64, ptr %v29, i64 0
  store i64 %v111, ptr %st43
  %v112.p = getelementptr i64, ptr %v109, i64 1
  %v112 = load i64, ptr %v112.p
  %st44 = getelementptr i64, ptr %v29, i64 1
  store i64 %v112, ptr %st44
  %v113.p = getelementptr i64, ptr %v109, i64 2
  %v113 = load i64, ptr %v113.p
  %st45 = getelementptr i64, ptr %v29, i64 2
  store i64 %v113, ptr %st45
  %st46 = getelementptr i64, ptr %v34, i64 0
  store i64 %v22, ptr %st46
  br label %b1
b18:
  %v132 = getelementptr i64, ptr %s6, i64 0
  %v133.p = getelementptr i64, ptr %v29, i64 0
  %v133 = load i64, ptr %v133.p
  %st47 = getelementptr i64, ptr %v132, i64 0
  store i64 %v133, ptr %st47
  %v134.p = getelementptr i64, ptr %v29, i64 1
  %v134 = load i64, ptr %v134.p
  %st48 = getelementptr i64, ptr %v132, i64 1
  store i64 %v134, ptr %st48
  %v135.p = getelementptr i64, ptr %v29, i64 2
  %v135 = load i64, ptr %v135.p
  %st49 = getelementptr i64, ptr %v132, i64 2
  store i64 %v135, ptr %st49
  %v136.p = getelementptr i64, ptr %v132, i64 2
  %v136 = load i64, ptr %v136.p
  %v137.p = getelementptr i64, ptr %v132, i64 0
  %v137 = load i64, ptr %v137.p
  %v138.p = getelementptr i64, ptr %v132, i64 1
  %v138 = load i64, ptr %v138.p
  %v139 = add i64 %v137, %v138
  %v142 = getelementptr i64, ptr @"rt.btip", i64 0
  %v143 = getelementptr i64, ptr %v142, i64 %v136
  %v144.p = getelementptr i64, ptr %v143, i64 0
  %v144 = load i64, ptr %v144.p
  %v145.c = icmp eq i64 %v144, %v139
  %v145 = zext i1 %v145.c to i64
  %c.b18 = icmp ne i64 %v145, 0
  br i1 %c.b18, label %b18.t51, label %b18.e52
b18.t51:
  br label %b25
b18.e52:
  br label %b23
b19:
  %v365 = getelementptr i64, ptr @"rt.meta", i64 0
  %v188.p = getelementptr i64, ptr %v365, i64 0
  %v188 = load i64, ptr %v188.p
  br label %b31
b20:
  %v230 = getelementptr i64, ptr %s10, i64 0
  %v231.p = getelementptr i64, ptr %v11, i64 0
  %v231 = load i64, ptr %v231.p
  %v232.p = getelementptr i64, ptr %v11, i64 1
  %v232 = load i64, ptr %v232.p
  %v233.p = getelementptr i64, ptr %v11, i64 2
  %v233 = load i64, ptr %v233.p
  %v234.p = getelementptr i64, ptr %v12, i64 0
  %v234 = load i64, ptr %v234.p
  %v235.p = getelementptr i64, ptr %v12, i64 1
  %v235 = load i64, ptr %v235.p
  %v236.p = getelementptr i64, ptr %v12, i64 2
  %v236 = load i64, ptr %v236.p
  %v237 = add i64 0, 1
  %v238 = add i64 0, 64
  %v239 = sdiv i64 %v7, %v238
  %v240 = add i64 %v237, %v239
  %v241.p = getelementptr i64, ptr %v29, i64 0
  %v241 = load i64, ptr %v241.p
  %v242.p = getelementptr i64, ptr %v29, i64 1
  %v242 = load i64, ptr %v242.p
  %v243.p = getelementptr i64, ptr %v29, i64 2
  %v243 = load i64, ptr %v243.p
  call void @"std/crypto/chacha20.XorKeyStream"(ptr %v230, i64 %v231, i64 %v232, i64 %v233, i64 %v234, i64 %v235, i64 %v236, i64 %v240, i64 %v241, i64 %v242, i64 %v243)
  %v244 = getelementptr i64, ptr %s3, i64 0
  %v245.p = getelementptr i64, ptr %v230, i64 0
  %v245 = load i64, ptr %v245.p
  %st52 = getelementptr i64, ptr %v244, i64 0
  store i64 %v245, ptr %st52
  %v246.p = getelementptr i64, ptr %v230, i64 1
  %v246 = load i64, ptr %v246.p
  %st53 = getelementptr i64, ptr %v244, i64 1
  store i64 %v246, ptr %st53
  %v247.p = getelementptr i64, ptr %v230, i64 2
  %v247 = load i64, ptr %v247.p
  %st54 = getelementptr i64, ptr %v244, i64 2
  store i64 %v247, ptr %st54
  %v248 = getelementptr i64, ptr %s11, i64 0
  %st55 = getelementptr i64, ptr %v248, i64 0
  store i64 %v22, ptr %st55
  %v249.p = getelementptr i64, ptr %v244, i64 1
  %v249 = load i64, ptr %v249.p
  %v250 = add i64 0, 0
  %v251 = add i64 0, 0
  %v252.p = getelementptr i64, ptr %v248, i64 0
  %v252 = load i64, ptr %v252.p
  %v253 = sub i64 %v249, %v252
  %v254 = add i64 0, 0
  %v255.c = icmp sle i64 %v253, %v254
  %v255 = zext i1 %v255.c to i64
  %c.b20 = icmp ne i64 %v255, 0
  br i1 %c.b20, label %b20.t57, label %b20.e58
b20.t57:
  br label %b41
b20.e58:
  br label %b42
b21:
  %v123.p = getelementptr i64, ptr %v13, i64 1
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 %v118, %v119
  %v125.c = icmp sge i64 %v124, %v121
  %v125 = zext i1 %v125.c to i64
  %v126 = add i64 %v118, %v116
  %v127.c = icmp sle i64 %v126, %v123
  %v127 = zext i1 %v127.c to i64
  %v128 = and i64 %v125, %v127
  %v129.c = icmp sge i64 %v119, %v121
  %v129 = zext i1 %v129.c to i64
  %v130 = and i64 %v128, %v129
  %v131.c = icmp ne i64 %v130, %v121
  %v131 = zext i1 %v131.c to i64
  %c.b21 = icmp ne i64 %v131, 0
  br i1 %c.b21, label %b21.t59, label %b21.e60
b21.t59:
  br label %b18
b21.e60:
  br label %b19
b22:
  %v140 = phi ptr [ %v175, %b23 ], [ %v172, %b24 ]
  %v141 = phi ptr [ %v177, %b23 ], [ %v173, %b24 ]
  %v178.p = getelementptr i64, ptr %v13, i64 0
  %v178 = load i64, ptr %v178.p
  %v179 = inttoptr i64 %v178 to ptr
  %v180 = getelementptr i8, ptr %v179, i64 %v124
  call void @"rt.copy8"(ptr %v141, ptr %v180, i64 %v120)
  %v181.p = getelementptr i64, ptr %v132, i64 1
  %v181 = load i64, ptr %v181.p
  %v182 = add i64 %v181, %v120
  %v183 = getelementptr i64, ptr %s3, i64 0
  %v184 = ptrtoint ptr %v140 to i64
  %st60 = getelementptr i64, ptr %v183, i64 0
  store i64 %v184, ptr %st60
  %st61 = getelementptr i64, ptr %v183, i64 1
  store i64 %v182, ptr %st61
  %st62 = getelementptr i64, ptr %v183, i64 2
  store i64 %v136, ptr %st62
  %v185.p = getelementptr i64, ptr %v183, i64 0
  %v185 = load i64, ptr %v185.p
  %st63 = getelementptr i64, ptr %v29, i64 0
  store i64 %v185, ptr %st63
  %v186.p = getelementptr i64, ptr %v183, i64 1
  %v186 = load i64, ptr %v186.p
  %st64 = getelementptr i64, ptr %v29, i64 1
  store i64 %v186, ptr %st64
  %v187.p = getelementptr i64, ptr %v183, i64 2
  %v187 = load i64, ptr %v187.p
  %st65 = getelementptr i64, ptr %v29, i64 2
  store i64 %v187, ptr %st65
  %st66 = getelementptr i64, ptr %v115, i64 0
  store i64 %v116, ptr %st66
  br label %b20
b23:
  %v174 = add i64 %v138, %v120
  %v175 = call ptr @"rt.region_alloc8"(i64 %v136, i64 %v174)
  %v176 = inttoptr i64 %v137 to ptr
  call void @"rt.copy8"(ptr %v175, ptr %v176, i64 %v138)
  %v177 = getelementptr i8, ptr %v175, i64 %v138
  br label %b22
b24:
  %v172 = inttoptr i64 %v137 to ptr
  %v173 = getelementptr i8, ptr %v172, i64 %v138
  br label %b22
b25:
  %v146 = add i64 0, 7
  %v147 = add i64 %v139, %v146
  %v148 = add i64 0, -8
  %v149 = and i64 %v147, %v148
  %v150 = add i64 %v139, %v120
  %v151 = add i64 0, 7
  %v152 = add i64 %v150, %v151
  %v153 = add i64 0, -8
  %v154 = and i64 %v152, %v153
  %v155 = getelementptr i64, ptr @"rt.meta", i64 0
  %v156 = getelementptr i64, ptr %v155, i64 %v136
  %v157.p = getelementptr i64, ptr %v156, i64 1
  %v157 = load i64, ptr %v157.p
  %v158.c = icmp sle i64 %v150, %v149
  %v158 = zext i1 %v158.c to i64
  %v159.c = icmp eq i64 %v157, %v149
  %v159 = zext i1 %v159.c to i64
  %v160 = or i64 %v158, %v159
  %v161 = add i64 0, 0
  %v162.c = icmp ne i64 %v160, %v161
  %v162 = zext i1 %v162.c to i64
  %c.b25 = icmp ne i64 %v162, 0
  br i1 %c.b25, label %b25.t68, label %b25.e69
b25.t68:
  br label %b26
b25.e69:
  br label %b23
b26:
  %v163.c = icmp sgt i64 %v154, %v157
  %v163 = zext i1 %v163.c to i64
  %c.b26 = icmp ne i64 %v163, 0
  br i1 %c.b26, label %b26.t70, label %b26.e71
b26.t70:
  br label %b27
b26.e71:
  br label %b28
b27:
  %v164.p = getelementptr i64, ptr %v155, i64 1029
  %v164 = load i64, ptr %v164.p
  %v165 = add i64 0, 1
  %v166 = add i64 %v136, %v165
  %v167.p = getelementptr i64, ptr %v155, i64 1030
  %v167 = load i64, ptr %v167.p
  %v168 = mul i64 %v166, %v167
  %v169 = add i64 %v164, %v168
  %v170.c = icmp sgt i64 %v154, %v169
  %v170 = zext i1 %v170.c to i64
  %c.b27 = icmp ne i64 %v170, 0
  br i1 %c.b27, label %b27.t72, label %b27.e73
b27.t72:
  br label %b29
b27.e73:
  br label %b30
b28:
  %st73 = getelementptr i64, ptr %v143, i64 0
  store i64 %v150, ptr %st73
  br label %b24
b29:
  %v171 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v171)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b30:
  %st74 = getelementptr i64, ptr %v156, i64 1
  store i64 %v154, ptr %st74
  br label %b28
b31:
  %v366 = getelementptr i64, ptr @"rt.meta", i64 0
  %st75 = getelementptr i64, ptr %v366, i64 0
  store i64 %v188, ptr %st75
  %v189.p = getelementptr i64, ptr %v115, i64 0
  %v189 = load i64, ptr %v189.p
  %v190.p = getelementptr i64, ptr %v13, i64 1
  %v190 = load i64, ptr %v190.p
  %v191.c = icmp slt i64 %v189, %v190
  %v191 = zext i1 %v191.c to i64
  %c.b31 = icmp ne i64 %v191, 0
  br i1 %c.b31, label %b31.t77, label %b31.e78
b31.t77:
  br label %b32
b31.e78:
  br label %b33
b32:
  call void @"rt.region_enter"()
  %v367 = getelementptr i64, ptr @"rt.meta", i64 0
  %v192.p = getelementptr i64, ptr %v367, i64 0
  %v192 = load i64, ptr %v192.p
  %v193 = getelementptr i64, ptr %s8, i64 0
  %v194.p = getelementptr i64, ptr %v29, i64 0
  %v194 = load i64, ptr %v194.p
  %st78 = getelementptr i64, ptr %v193, i64 0
  store i64 %v194, ptr %st78
  %v195.p = getelementptr i64, ptr %v29, i64 1
  %v195 = load i64, ptr %v195.p
  %st79 = getelementptr i64, ptr %v193, i64 1
  store i64 %v195, ptr %st79
  %v196.p = getelementptr i64, ptr %v29, i64 2
  %v196 = load i64, ptr %v196.p
  %st80 = getelementptr i64, ptr %v193, i64 2
  store i64 %v196, ptr %st80
  %v197.p = getelementptr i64, ptr %v115, i64 0
  %v197 = load i64, ptr %v197.p
  %v198.p = getelementptr i64, ptr %v13, i64 1
  %v198 = load i64, ptr %v198.p
  %v199.c = icmp uge i64 %v197, %v198
  %v199 = zext i1 %v199.c to i64
  %c.b32 = icmp ne i64 %v199, 0
  br i1 %c.b32, label %b32.t82, label %b32.e83
b32.t82:
  br label %b34
b32.e83:
  br label %b35
b33:
  %v368 = getelementptr i64, ptr @"rt.meta", i64 0
  %st83 = getelementptr i64, ptr %v368, i64 0
  store i64 %v188, ptr %st83
  br label %b20
b34:
  %v200 = add i64 0, 69
  call void @"rt.panic"(i64 %v200)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b35:
  %v201.p = getelementptr i64, ptr %v13, i64 0
  %v201 = load i64, ptr %v201.p
  %v202 = inttoptr i64 %v201 to ptr
  %v203 = getelementptr i8, ptr %v202, i64 %v197
  %v204.p = getelementptr i8, ptr %v203, i64 0
  %v204.b = load i8, ptr %v204.p
  %v204 = zext i8 %v204.b to i64
  %v205.p = getelementptr i64, ptr %v193, i64 2
  %v205 = load i64, ptr %v205.p
  %v206.p = getelementptr i64, ptr %v193, i64 0
  %v206 = load i64, ptr %v206.p
  %v207.p = getelementptr i64, ptr %v193, i64 1
  %v207 = load i64, ptr %v207.p
  %v210 = add i64 %v206, %v207
  %v211 = call i64 @"rt.tip8"(i64 %v205, i64 %v210)
  %v212 = add i64 0, 0
  %v213.c = icmp ne i64 %v211, %v212
  %v213 = zext i1 %v213.c to i64
  %c.b35 = icmp ne i64 %v213, 0
  br i1 %c.b35, label %b35.t85, label %b35.e86
b35.t85:
  br label %b38
b35.e86:
  br label %b37
b36:
  %v208 = phi ptr [ %v217, %b37 ], [ %v214, %b38 ]
  %v209 = phi ptr [ %v218, %b37 ], [ %v215, %b38 ]
  %st86 = getelementptr i8, ptr %v209, i64 0
  %st86.b = trunc i64 %v204 to i8
  store i8 %st86.b, ptr %st86
  %v219.p = getelementptr i64, ptr %v193, i64 1
  %v219 = load i64, ptr %v219.p
  %v220 = add i64 0, 1
  %v221 = add i64 %v219, %v220
  %v222 = getelementptr i64, ptr %s9, i64 0
  %v223 = ptrtoint ptr %v208 to i64
  %st87 = getelementptr i64, ptr %v222, i64 0
  store i64 %v223, ptr %st87
  %st88 = getelementptr i64, ptr %v222, i64 1
  store i64 %v221, ptr %st88
  %st89 = getelementptr i64, ptr %v222, i64 2
  store i64 %v205, ptr %st89
  %v224.p = getelementptr i64, ptr %v222, i64 0
  %v224 = load i64, ptr %v224.p
  %st90 = getelementptr i64, ptr %v29, i64 0
  store i64 %v224, ptr %st90
  %v225.p = getelementptr i64, ptr %v222, i64 1
  %v225 = load i64, ptr %v225.p
  %st91 = getelementptr i64, ptr %v29, i64 1
  store i64 %v225, ptr %st91
  %v226.p = getelementptr i64, ptr %v222, i64 2
  %v226 = load i64, ptr %v226.p
  %st92 = getelementptr i64, ptr %v29, i64 2
  store i64 %v226, ptr %st92
  %v227 = add i64 0, 1
  %v228.p = getelementptr i64, ptr %v115, i64 0
  %v228 = load i64, ptr %v228.p
  %v229 = add i64 %v228, %v227
  %st93 = getelementptr i64, ptr %v115, i64 0
  store i64 %v229, ptr %st93
  br label %b31
b37:
  %v216 = add i64 0, 1
  %v217 = call ptr @"rt.slice_grow8"(i64 %v206, i64 %v207, i64 %v205, i64 %v216)
  %v218 = getelementptr i8, ptr %v217, i64 %v207
  br label %b36
b38:
  %v214 = inttoptr i64 %v206 to ptr
  %v215 = getelementptr i8, ptr %v214, i64 %v207
  br label %b36
b39:
  %v265 = getelementptr i64, ptr %s6, i64 0
  %v266.p = getelementptr i64, ptr %v0, i64 0
  %v266 = load i64, ptr %v266.p
  %st94 = getelementptr i64, ptr %v265, i64 0
  store i64 %v266, ptr %st94
  %v267.p = getelementptr i64, ptr %v0, i64 1
  %v267 = load i64, ptr %v267.p
  %st95 = getelementptr i64, ptr %v265, i64 1
  store i64 %v267, ptr %st95
  %v268.p = getelementptr i64, ptr %v0, i64 2
  %v268 = load i64, ptr %v268.p
  %st96 = getelementptr i64, ptr %v265, i64 2
  store i64 %v268, ptr %st96
  %v269.p = getelementptr i64, ptr %v265, i64 2
  %v269 = load i64, ptr %v269.p
  %v270.p = getelementptr i64, ptr %v265, i64 0
  %v270 = load i64, ptr %v270.p
  %v271.p = getelementptr i64, ptr %v265, i64 1
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 %v270, %v271
  %v275 = getelementptr i64, ptr @"rt.btip", i64 0
  %v276 = getelementptr i64, ptr %v275, i64 %v269
  %v277.p = getelementptr i64, ptr %v276, i64 0
  %v277 = load i64, ptr %v277.p
  %v278.c = icmp eq i64 %v277, %v272
  %v278 = zext i1 %v278.c to i64
  %c.b39 = icmp ne i64 %v278, 0
  br i1 %c.b39, label %b39.t98, label %b39.e99
b39.t98:
  br label %b46
b39.e99:
  br label %b44
b40:
  %v369 = getelementptr i64, ptr @"rt.meta", i64 0
  %v321.p = getelementptr i64, ptr %v369, i64 0
  %v321 = load i64, ptr %v321.p
  br label %b52
b41:
  %v370 = getelementptr i64, ptr @"rt.meta", i64 0
  %st99 = getelementptr i64, ptr %v370, i64 0
  store i64 %v14, ptr %st99
  ret void
b42:
  %v256.p = getelementptr i64, ptr %v244, i64 1
  %v256 = load i64, ptr %v256.p
  %v257 = add i64 %v251, %v252
  %v258.c = icmp sge i64 %v257, %v254
  %v258 = zext i1 %v258.c to i64
  %v259 = add i64 %v251, %v249
  %v260.c = icmp sle i64 %v259, %v256
  %v260 = zext i1 %v260.c to i64
  %v261 = and i64 %v258, %v260
  %v262.c = icmp sge i64 %v252, %v254
  %v262 = zext i1 %v262.c to i64
  %v263 = and i64 %v261, %v262
  %v264.c = icmp ne i64 %v263, %v254
  %v264 = zext i1 %v264.c to i64
  %c.b42 = icmp ne i64 %v264, 0
  br i1 %c.b42, label %b42.t101, label %b42.e102
b42.t101:
  br label %b39
b42.e102:
  br label %b40
b43:
  %v273 = phi ptr [ %v308, %b44 ], [ %v305, %b45 ]
  %v274 = phi ptr [ %v310, %b44 ], [ %v306, %b45 ]
  %v311.p = getelementptr i64, ptr %v244, i64 0
  %v311 = load i64, ptr %v311.p
  %v312 = inttoptr i64 %v311 to ptr
  %v313 = getelementptr i8, ptr %v312, i64 %v257
  call void @"rt.copy8"(ptr %v274, ptr %v313, i64 %v253)
  %v314.p = getelementptr i64, ptr %v265, i64 1
  %v314 = load i64, ptr %v314.p
  %v315 = add i64 %v314, %v253
  %v316 = getelementptr i64, ptr %s9, i64 0
  %v317 = ptrtoint ptr %v273 to i64
  %st102 = getelementptr i64, ptr %v316, i64 0
  store i64 %v317, ptr %st102
  %st103 = getelementptr i64, ptr %v316, i64 1
  store i64 %v315, ptr %st103
  %st104 = getelementptr i64, ptr %v316, i64 2
  store i64 %v269, ptr %st104
  %v318.p = getelementptr i64, ptr %v316, i64 0
  %v318 = load i64, ptr %v318.p
  %st105 = getelementptr i64, ptr %v0, i64 0
  store i64 %v318, ptr %st105
  %v319.p = getelementptr i64, ptr %v316, i64 1
  %v319 = load i64, ptr %v319.p
  %st106 = getelementptr i64, ptr %v0, i64 1
  store i64 %v319, ptr %st106
  %v320.p = getelementptr i64, ptr %v316, i64 2
  %v320 = load i64, ptr %v320.p
  %st107 = getelementptr i64, ptr %v0, i64 2
  store i64 %v320, ptr %st107
  %st108 = getelementptr i64, ptr %v248, i64 0
  store i64 %v249, ptr %st108
  br label %b41
b44:
  %v307 = add i64 %v271, %v253
  %v308 = call ptr @"rt.region_alloc8"(i64 %v269, i64 %v307)
  %v309 = inttoptr i64 %v270 to ptr
  call void @"rt.copy8"(ptr %v308, ptr %v309, i64 %v271)
  %v310 = getelementptr i8, ptr %v308, i64 %v271
  br label %b43
b45:
  %v305 = inttoptr i64 %v270 to ptr
  %v306 = getelementptr i8, ptr %v305, i64 %v271
  br label %b43
b46:
  %v279 = add i64 0, 7
  %v280 = add i64 %v272, %v279
  %v281 = add i64 0, -8
  %v282 = and i64 %v280, %v281
  %v283 = add i64 %v272, %v253
  %v284 = add i64 0, 7
  %v285 = add i64 %v283, %v284
  %v286 = add i64 0, -8
  %v287 = and i64 %v285, %v286
  %v288 = getelementptr i64, ptr @"rt.meta", i64 0
  %v289 = getelementptr i64, ptr %v288, i64 %v269
  %v290.p = getelementptr i64, ptr %v289, i64 1
  %v290 = load i64, ptr %v290.p
  %v291.c = icmp sle i64 %v283, %v282
  %v291 = zext i1 %v291.c to i64
  %v292.c = icmp eq i64 %v290, %v282
  %v292 = zext i1 %v292.c to i64
  %v293 = or i64 %v291, %v292
  %v294 = add i64 0, 0
  %v295.c = icmp ne i64 %v293, %v294
  %v295 = zext i1 %v295.c to i64
  %c.b46 = icmp ne i64 %v295, 0
  br i1 %c.b46, label %b46.t110, label %b46.e111
b46.t110:
  br label %b47
b46.e111:
  br label %b44
b47:
  %v296.c = icmp sgt i64 %v287, %v290
  %v296 = zext i1 %v296.c to i64
  %c.b47 = icmp ne i64 %v296, 0
  br i1 %c.b47, label %b47.t112, label %b47.e113
b47.t112:
  br label %b48
b47.e113:
  br label %b49
b48:
  %v297.p = getelementptr i64, ptr %v288, i64 1029
  %v297 = load i64, ptr %v297.p
  %v298 = add i64 0, 1
  %v299 = add i64 %v269, %v298
  %v300.p = getelementptr i64, ptr %v288, i64 1030
  %v300 = load i64, ptr %v300.p
  %v301 = mul i64 %v299, %v300
  %v302 = add i64 %v297, %v301
  %v303.c = icmp sgt i64 %v287, %v302
  %v303 = zext i1 %v303.c to i64
  %c.b48 = icmp ne i64 %v303, 0
  br i1 %c.b48, label %b48.t114, label %b48.e115
b48.t114:
  br label %b50
b48.e115:
  br label %b51
b49:
  %st115 = getelementptr i64, ptr %v276, i64 0
  store i64 %v283, ptr %st115
  br label %b45
b50:
  %v304 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v304)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b51:
  %st116 = getelementptr i64, ptr %v289, i64 1
  store i64 %v287, ptr %st116
  br label %b49
b52:
  %v371 = getelementptr i64, ptr @"rt.meta", i64 0
  %st117 = getelementptr i64, ptr %v371, i64 0
  store i64 %v321, ptr %st117
  %v322.p = getelementptr i64, ptr %v248, i64 0
  %v322 = load i64, ptr %v322.p
  %v323.p = getelementptr i64, ptr %v244, i64 1
  %v323 = load i64, ptr %v323.p
  %v324.c = icmp slt i64 %v322, %v323
  %v324 = zext i1 %v324.c to i64
  %c.b52 = icmp ne i64 %v324, 0
  br i1 %c.b52, label %b52.t119, label %b52.e120
b52.t119:
  br label %b53
b52.e120:
  br label %b54
b53:
  call void @"rt.region_enter"()
  %v372 = getelementptr i64, ptr @"rt.meta", i64 0
  %v325.p = getelementptr i64, ptr %v372, i64 0
  %v325 = load i64, ptr %v325.p
  %v326 = getelementptr i64, ptr %s8, i64 0
  %v327.p = getelementptr i64, ptr %v0, i64 0
  %v327 = load i64, ptr %v327.p
  %st120 = getelementptr i64, ptr %v326, i64 0
  store i64 %v327, ptr %st120
  %v328.p = getelementptr i64, ptr %v0, i64 1
  %v328 = load i64, ptr %v328.p
  %st121 = getelementptr i64, ptr %v326, i64 1
  store i64 %v328, ptr %st121
  %v329.p = getelementptr i64, ptr %v0, i64 2
  %v329 = load i64, ptr %v329.p
  %st122 = getelementptr i64, ptr %v326, i64 2
  store i64 %v329, ptr %st122
  %v330.p = getelementptr i64, ptr %v248, i64 0
  %v330 = load i64, ptr %v330.p
  %v331.p = getelementptr i64, ptr %v244, i64 1
  %v331 = load i64, ptr %v331.p
  %v332.c = icmp uge i64 %v330, %v331
  %v332 = zext i1 %v332.c to i64
  %c.b53 = icmp ne i64 %v332, 0
  br i1 %c.b53, label %b53.t124, label %b53.e125
b53.t124:
  br label %b55
b53.e125:
  br label %b56
b54:
  %v373 = getelementptr i64, ptr @"rt.meta", i64 0
  %st125 = getelementptr i64, ptr %v373, i64 0
  store i64 %v321, ptr %st125
  br label %b41
b55:
  %v333 = add i64 0, 70
  call void @"rt.panic"(i64 %v333)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b56:
  %v334.p = getelementptr i64, ptr %v244, i64 0
  %v334 = load i64, ptr %v334.p
  %v335 = inttoptr i64 %v334 to ptr
  %v336 = getelementptr i8, ptr %v335, i64 %v330
  %v337.p = getelementptr i8, ptr %v336, i64 0
  %v337.b = load i8, ptr %v337.p
  %v337 = zext i8 %v337.b to i64
  %v338.p = getelementptr i64, ptr %v326, i64 2
  %v338 = load i64, ptr %v338.p
  %v339.p = getelementptr i64, ptr %v326, i64 0
  %v339 = load i64, ptr %v339.p
  %v340.p = getelementptr i64, ptr %v326, i64 1
  %v340 = load i64, ptr %v340.p
  %v343 = add i64 %v339, %v340
  %v344 = call i64 @"rt.tip8"(i64 %v338, i64 %v343)
  %v345 = add i64 0, 0
  %v346.c = icmp ne i64 %v344, %v345
  %v346 = zext i1 %v346.c to i64
  %c.b56 = icmp ne i64 %v346, 0
  br i1 %c.b56, label %b56.t127, label %b56.e128
b56.t127:
  br label %b59
b56.e128:
  br label %b58
b57:
  %v341 = phi ptr [ %v350, %b58 ], [ %v347, %b59 ]
  %v342 = phi ptr [ %v351, %b58 ], [ %v348, %b59 ]
  %st128 = getelementptr i8, ptr %v342, i64 0
  %st128.b = trunc i64 %v337 to i8
  store i8 %st128.b, ptr %st128
  %v352.p = getelementptr i64, ptr %v326, i64 1
  %v352 = load i64, ptr %v352.p
  %v353 = add i64 0, 1
  %v354 = add i64 %v352, %v353
  %v355 = getelementptr i64, ptr %s12, i64 0
  %v356 = ptrtoint ptr %v341 to i64
  %st129 = getelementptr i64, ptr %v355, i64 0
  store i64 %v356, ptr %st129
  %st130 = getelementptr i64, ptr %v355, i64 1
  store i64 %v354, ptr %st130
  %st131 = getelementptr i64, ptr %v355, i64 2
  store i64 %v338, ptr %st131
  %v357.p = getelementptr i64, ptr %v355, i64 0
  %v357 = load i64, ptr %v357.p
  %st132 = getelementptr i64, ptr %v0, i64 0
  store i64 %v357, ptr %st132
  %v358.p = getelementptr i64, ptr %v355, i64 1
  %v358 = load i64, ptr %v358.p
  %st133 = getelementptr i64, ptr %v0, i64 1
  store i64 %v358, ptr %st133
  %v359.p = getelementptr i64, ptr %v355, i64 2
  %v359 = load i64, ptr %v359.p
  %st134 = getelementptr i64, ptr %v0, i64 2
  store i64 %v359, ptr %st134
  %v360 = add i64 0, 1
  %v361.p = getelementptr i64, ptr %v248, i64 0
  %v361 = load i64, ptr %v361.p
  %v362 = add i64 %v361, %v360
  %st135 = getelementptr i64, ptr %v248, i64 0
  store i64 %v362, ptr %st135
  br label %b52
b58:
  %v349 = add i64 0, 1
  %v350 = call ptr @"rt.slice_grow8"(i64 %v339, i64 %v340, i64 %v338, i64 %v349)
  %v351 = getelementptr i8, ptr %v350, i64 %v340
  br label %b57
b59:
  %v347 = inttoptr i64 %v339 to ptr
  %v348 = getelementptr i8, ptr %v347, i64 %v340
  br label %b57
}

define internal void @"std/crypto/chacha20poly1305.OpenAt"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13, i64 %v14) #0 {
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
  %s6 = alloca [4 x i64], align 8
  %s6.z0 = getelementptr i64, ptr %s6, i64 0
  store i64 0, ptr %s6.z0
  %s6.z1 = getelementptr i64, ptr %s6, i64 1
  store i64 0, ptr %s6.z1
  %s6.z2 = getelementptr i64, ptr %s6, i64 2
  store i64 0, ptr %s6.z2
  %s6.z3 = getelementptr i64, ptr %s6, i64 3
  store i64 0, ptr %s6.z3
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
  %v15 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v15, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v15, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v15, i64 2
  store i64 %v3, ptr %st2
  %v16 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v16, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v16, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v16, i64 2
  store i64 %v6, ptr %st5
  %v17 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v17, i64 0
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v17, i64 1
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v17, i64 2
  store i64 %v9, ptr %st8
  %v18 = getelementptr i64, ptr %s3, i64 0
  %st9 = getelementptr i64, ptr %v18, i64 0
  store i64 %v10, ptr %st9
  %st10 = getelementptr i64, ptr %v18, i64 1
  store i64 %v11, ptr %st10
  %st11 = getelementptr i64, ptr %v18, i64 2
  store i64 %v12, ptr %st11
  %v175 = getelementptr i64, ptr @"rt.meta", i64 0
  %v19.p = getelementptr i64, ptr %v175, i64 0
  %v19 = load i64, ptr %v19.p
  %v20 = getelementptr i64, ptr @"rt.meta", i64 0
  %v21.p = getelementptr i64, ptr %v20, i64 2571
  %v21 = load i64, ptr %v21.p
  %v22 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v20, i64 2571
  store i64 %v22, ptr %st12
  %v23 = add i64 0, 1
  %v24.c = icmp sge i64 %v21, %v23
  %v24 = zext i1 %v24.c to i64
  %v25.c = icmp sle i64 %v21, %v19
  %v25 = zext i1 %v25.c to i64
  %v26 = and i64 %v24, %v25
  %v27 = sub i64 %v21, %v19
  %v28 = mul i64 %v26, %v27
  %v29 = add i64 %v19, %v28
  call void @"rt.region_enter"()
  %v30.p = getelementptr i64, ptr %v16, i64 1
  %v30 = load i64, ptr %v30.p
  %v31 = add i64 0, 12
  %v32.c = icmp ne i64 %v30, %v31
  %v32 = zext i1 %v32.c to i64
  %c.b0 = icmp ne i64 %v32, 0
  br i1 %c.b0, label %b0.t14, label %b0.e15
b0.t14:
  br label %b2
b0.e15:
  br label %b1
b1:
  %v34 = add i64 0, 16
  %v35.c = icmp slt i64 %v14, %v34
  %v35 = zext i1 %v35.c to i64
  br label %b2
b2:
  %v33 = phi i64 [ %v32, %b0.t14 ], [ %v35, %b1 ]
  %c.b2 = icmp ne i64 %v33, 0
  br i1 %c.b2, label %b2.t16, label %b2.e17
b2.t16:
  br label %b4
b2.e17:
  br label %b3
b3:
  %v37 = add i64 0, 0
  %v38.c = icmp slt i64 %v13, %v37
  %v38 = zext i1 %v38.c to i64
  br label %b4
b4:
  %v36 = phi i64 [ %v33, %b2.t16 ], [ %v38, %b3 ]
  %c.b4 = icmp ne i64 %v36, 0
  br i1 %c.b4, label %b4.t18, label %b4.e19
b4.t18:
  br label %b6
b4.e19:
  br label %b5
b5:
  %v40 = add i64 %v13, %v14
  %v41.p = getelementptr i64, ptr %v18, i64 1
  %v41 = load i64, ptr %v41.p
  %v42.c = icmp sgt i64 %v40, %v41
  %v42 = zext i1 %v42.c to i64
  br label %b6
b6:
  %v39 = phi i64 [ %v36, %b4.t18 ], [ %v42, %b5 ]
  %c.b6 = icmp ne i64 %v39, 0
  br i1 %c.b6, label %b6.t20, label %b6.e21
b6.t20:
  br label %b7
b6.e21:
  br label %b8
b7:
  %v43 = add i64 0, 0
  %v44 = call ptr @"rt.region_alloc8"(i64 %v29, i64 %v43)
  %v45 = add i64 0, 0
  %v46 = getelementptr i64, ptr %s4, i64 0
  %v47 = ptrtoint ptr %v44 to i64
  %st21 = getelementptr i64, ptr %v46, i64 0
  store i64 %v47, ptr %st21
  %st22 = getelementptr i64, ptr %v46, i64 1
  store i64 %v45, ptr %st22
  %st23 = getelementptr i64, ptr %v46, i64 2
  store i64 %v29, ptr %st23
  %v48 = getelementptr i64, ptr %s5, i64 0
  %v49 = add i64 0, 0
  %st24 = getelementptr i64, ptr %v48, i64 0
  store i64 %v49, ptr %st24
  %v50 = add i64 0, 0
  %st25 = getelementptr i64, ptr %v48, i64 0
  store i64 %v50, ptr %st25
  %v51 = getelementptr i64, ptr %s6, i64 0
  %v52.p = getelementptr i64, ptr %v48, i64 0
  %v52 = load i64, ptr %v52.p
  %st26 = getelementptr i64, ptr %v51, i64 0
  store i64 %v52, ptr %st26
  %v53 = add i64 0, 0
  %st27 = getelementptr i64, ptr %v51, i64 1
  store i64 %v53, ptr %st27
  %st28 = getelementptr i64, ptr %v51, i64 2
  store i64 %v53, ptr %st28
  %st29 = getelementptr i64, ptr %v51, i64 3
  store i64 %v53, ptr %st29
  %v54 = getelementptr i64, ptr %s7, i64 0
  %v55 = add i64 0, 1
  %st30 = getelementptr i64, ptr %v54, i64 0
  store i64 %v55, ptr %st30
  %v56.p = getelementptr i64, ptr %v51, i64 0
  %v56 = load i64, ptr %v56.p
  %st31 = getelementptr i64, ptr %v54, i64 1
  store i64 %v56, ptr %st31
  %v57.p = getelementptr i64, ptr %v51, i64 1
  %v57 = load i64, ptr %v57.p
  %st32 = getelementptr i64, ptr %v54, i64 2
  store i64 %v57, ptr %st32
  %v58.p = getelementptr i64, ptr %v51, i64 2
  %v58 = load i64, ptr %v58.p
  %st33 = getelementptr i64, ptr %v54, i64 3
  store i64 %v58, ptr %st33
  %v59.p = getelementptr i64, ptr %v51, i64 3
  %v59 = load i64, ptr %v59.p
  %st34 = getelementptr i64, ptr %v54, i64 4
  store i64 %v59, ptr %st34
  %v60.p = getelementptr i64, ptr %v46, i64 0
  %v60 = load i64, ptr %v60.p
  %st35 = getelementptr i64, ptr %v0, i64 0
  store i64 %v60, ptr %st35
  %v61.p = getelementptr i64, ptr %v46, i64 1
  %v61 = load i64, ptr %v61.p
  %st36 = getelementptr i64, ptr %v0, i64 1
  store i64 %v61, ptr %st36
  %v62.p = getelementptr i64, ptr %v46, i64 2
  %v62 = load i64, ptr %v62.p
  %st37 = getelementptr i64, ptr %v0, i64 2
  store i64 %v62, ptr %st37
  %v63.p = getelementptr i64, ptr %v54, i64 0
  %v63 = load i64, ptr %v63.p
  %st38 = getelementptr i64, ptr %v0, i64 3
  store i64 %v63, ptr %st38
  %v64.p = getelementptr i64, ptr %v54, i64 1
  %v64 = load i64, ptr %v64.p
  %st39 = getelementptr i64, ptr %v0, i64 4
  store i64 %v64, ptr %st39
  %v65.p = getelementptr i64, ptr %v54, i64 2
  %v65 = load i64, ptr %v65.p
  %st40 = getelementptr i64, ptr %v0, i64 5
  store i64 %v65, ptr %st40
  %v66.p = getelementptr i64, ptr %v54, i64 3
  %v66 = load i64, ptr %v66.p
  %st41 = getelementptr i64, ptr %v0, i64 6
  store i64 %v66, ptr %st41
  %v67.p = getelementptr i64, ptr %v54, i64 4
  %v67 = load i64, ptr %v67.p
  %st42 = getelementptr i64, ptr %v0, i64 7
  store i64 %v67, ptr %st42
  call void @"rt.region_relocate8"(ptr %v0, i64 %v19)
  %v68.p = getelementptr i64, ptr %v0, i64 3
  %v68 = load i64, ptr %v68.p
  %v69 = add i64 0, 0
  %v70.c = icmp ne i64 %v68, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b7 = icmp ne i64 %v70, 0
  br i1 %c.b7, label %b7.t44, label %b7.e45
b7.t44:
  br label %b9
b7.e45:
  br label %b10
b8:
  br label %b11
b9:
  %v71 = add i64 0, 4
  %v72 = getelementptr i64, ptr %v0, i64 %v71
  call void @"rt.err_relocate"(ptr %v72, i64 %v19)
  br label %b10
b10:
  %v176 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v176, i64 0
  store i64 %v19, ptr %st45
  ret void
b11:
  %v73 = add i64 0, 16
  %v74 = sub i64 %v14, %v73
  %v75 = getelementptr i64, ptr %s8, i64 0
  %v76 = getelementptr i64, ptr %s9, i64 0
  %v77.p = getelementptr i64, ptr %v15, i64 0
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v15, i64 1
  %v78 = load i64, ptr %v78.p
  %v79.p = getelementptr i64, ptr %v15, i64 2
  %v79 = load i64, ptr %v79.p
  %v80.p = getelementptr i64, ptr %v16, i64 0
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v16, i64 1
  %v81 = load i64, ptr %v81.p
  %v82.p = getelementptr i64, ptr %v16, i64 2
  %v82 = load i64, ptr %v82.p
  call void @"std/crypto/chacha20poly1305.polyKey"(ptr %v76, i64 %v77, i64 %v78, i64 %v79, i64 %v80, i64 %v81, i64 %v82)
  %v83.p = getelementptr i64, ptr %v76, i64 0
  %v83 = load i64, ptr %v83.p
  %v84.p = getelementptr i64, ptr %v76, i64 1
  %v84 = load i64, ptr %v84.p
  %v85.p = getelementptr i64, ptr %v76, i64 2
  %v85 = load i64, ptr %v85.p
  %v86.p = getelementptr i64, ptr %v17, i64 0
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v17, i64 1
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v17, i64 2
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v18, i64 0
  %v89 = load i64, ptr %v89.p
  %v90.p = getelementptr i64, ptr %v18, i64 1
  %v90 = load i64, ptr %v90.p
  %v91.p = getelementptr i64, ptr %v18, i64 2
  %v91 = load i64, ptr %v91.p
  call void @"std/crypto/poly1305.SumAead"(ptr %v75, i64 %v83, i64 %v84, i64 %v85, i64 %v86, i64 %v87, i64 %v88, i64 %v89, i64 %v90, i64 %v91, i64 %v13, i64 %v74)
  %v92.p = getelementptr i64, ptr %v75, i64 0
  %v92 = load i64, ptr %v92.p
  %v93.p = getelementptr i64, ptr %v75, i64 1
  %v93 = load i64, ptr %v93.p
  %v94.p = getelementptr i64, ptr %v75, i64 2
  %v94 = load i64, ptr %v94.p
  %v95 = add i64 %v13, %v74
  %v96 = add i64 %v13, %v14
  %v97 = add i64 0, 0
  %v98.c = icmp slt i64 %v95, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b11 = icmp ne i64 %v98, 0
  br i1 %c.b11, label %b11.t47, label %b11.e48
b11.t47:
  br label %b12
b11.e48:
  br label %b13
b12:
  %v99 = add i64 0, 71
  call void @"rt.panic"(i64 %v99)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v100.c = icmp slt i64 %v96, %v95
  %v100 = zext i1 %v100.c to i64
  %c.b13 = icmp ne i64 %v100, 0
  br i1 %c.b13, label %b13.t49, label %b13.e50
b13.t49:
  br label %b14
b13.e50:
  br label %b15
b14:
  %v101 = add i64 0, 72
  call void @"rt.panic"(i64 %v101)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v102.p = getelementptr i64, ptr %v18, i64 1
  %v102 = load i64, ptr %v102.p
  %v103.c = icmp sgt i64 %v96, %v102
  %v103 = zext i1 %v103.c to i64
  %c.b15 = icmp ne i64 %v103, 0
  br i1 %c.b15, label %b15.t51, label %b15.e52
b15.t51:
  br label %b16
b15.e52:
  br label %b17
b16:
  %v104 = add i64 0, 73
  call void @"rt.panic"(i64 %v104)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v105.p = getelementptr i64, ptr %v18, i64 0
  %v105 = load i64, ptr %v105.p
  %v106 = inttoptr i64 %v105 to ptr
  %v107 = getelementptr i8, ptr %v106, i64 %v95
  %v108 = sub i64 %v96, %v95
  %v109.p = getelementptr i64, ptr %v18, i64 2
  %v109 = load i64, ptr %v109.p
  %v110 = getelementptr i64, ptr %s4, i64 0
  %v111 = ptrtoint ptr %v107 to i64
  %st52 = getelementptr i64, ptr %v110, i64 0
  store i64 %v111, ptr %st52
  %st53 = getelementptr i64, ptr %v110, i64 1
  store i64 %v108, ptr %st53
  %st54 = getelementptr i64, ptr %v110, i64 2
  store i64 %v109, ptr %st54
  %v112.p = getelementptr i64, ptr %v110, i64 0
  %v112 = load i64, ptr %v112.p
  %v113.p = getelementptr i64, ptr %v110, i64 1
  %v113 = load i64, ptr %v113.p
  %v114.p = getelementptr i64, ptr %v110, i64 2
  %v114 = load i64, ptr %v114.p
  %v115 = call i64 @"std/crypto.Equal"(i64 %v92, i64 %v93, i64 %v94, i64 %v112, i64 %v113, i64 %v114)
  %v116 = add i64 0, 1
  %v117 = xor i64 %v115, %v116
  %c.b17 = icmp ne i64 %v117, 0
  br i1 %c.b17, label %b17.t56, label %b17.e57
b17.t56:
  br label %b18
b17.e57:
  br label %b19
b18:
  %v118 = add i64 0, 0
  %v119 = call ptr @"rt.region_alloc8"(i64 %v29, i64 %v118)
  %v120 = add i64 0, 0
  %v121 = getelementptr i64, ptr %s10, i64 0
  %v122 = ptrtoint ptr %v119 to i64
  %st57 = getelementptr i64, ptr %v121, i64 0
  store i64 %v122, ptr %st57
  %st58 = getelementptr i64, ptr %v121, i64 1
  store i64 %v120, ptr %st58
  %st59 = getelementptr i64, ptr %v121, i64 2
  store i64 %v29, ptr %st59
  %v123 = getelementptr i64, ptr %s5, i64 0
  %v124 = add i64 0, 0
  %st60 = getelementptr i64, ptr %v123, i64 0
  store i64 %v124, ptr %st60
  %v125 = add i64 0, 1
  %st61 = getelementptr i64, ptr %v123, i64 0
  store i64 %v125, ptr %st61
  %v126 = getelementptr i64, ptr %s6, i64 0
  %v127.p = getelementptr i64, ptr %v123, i64 0
  %v127 = load i64, ptr %v127.p
  %st62 = getelementptr i64, ptr %v126, i64 0
  store i64 %v127, ptr %st62
  %v128 = add i64 0, 0
  %st63 = getelementptr i64, ptr %v126, i64 1
  store i64 %v128, ptr %st63
  %st64 = getelementptr i64, ptr %v126, i64 2
  store i64 %v128, ptr %st64
  %st65 = getelementptr i64, ptr %v126, i64 3
  store i64 %v128, ptr %st65
  %v129 = getelementptr i64, ptr %s7, i64 0
  %v130 = add i64 0, 1
  %st66 = getelementptr i64, ptr %v129, i64 0
  store i64 %v130, ptr %st66
  %v131.p = getelementptr i64, ptr %v126, i64 0
  %v131 = load i64, ptr %v131.p
  %st67 = getelementptr i64, ptr %v129, i64 1
  store i64 %v131, ptr %st67
  %v132.p = getelementptr i64, ptr %v126, i64 1
  %v132 = load i64, ptr %v132.p
  %st68 = getelementptr i64, ptr %v129, i64 2
  store i64 %v132, ptr %st68
  %v133.p = getelementptr i64, ptr %v126, i64 2
  %v133 = load i64, ptr %v133.p
  %st69 = getelementptr i64, ptr %v129, i64 3
  store i64 %v133, ptr %st69
  %v134.p = getelementptr i64, ptr %v126, i64 3
  %v134 = load i64, ptr %v134.p
  %st70 = getelementptr i64, ptr %v129, i64 4
  store i64 %v134, ptr %st70
  %v135.p = getelementptr i64, ptr %v121, i64 0
  %v135 = load i64, ptr %v135.p
  %st71 = getelementptr i64, ptr %v0, i64 0
  store i64 %v135, ptr %st71
  %v136.p = getelementptr i64, ptr %v121, i64 1
  %v136 = load i64, ptr %v136.p
  %st72 = getelementptr i64, ptr %v0, i64 1
  store i64 %v136, ptr %st72
  %v137.p = getelementptr i64, ptr %v121, i64 2
  %v137 = load i64, ptr %v137.p
  %st73 = getelementptr i64, ptr %v0, i64 2
  store i64 %v137, ptr %st73
  %v138.p = getelementptr i64, ptr %v129, i64 0
  %v138 = load i64, ptr %v138.p
  %st74 = getelementptr i64, ptr %v0, i64 3
  store i64 %v138, ptr %st74
  %v139.p = getelementptr i64, ptr %v129, i64 1
  %v139 = load i64, ptr %v139.p
  %st75 = getelementptr i64, ptr %v0, i64 4
  store i64 %v139, ptr %st75
  %v140.p = getelementptr i64, ptr %v129, i64 2
  %v140 = load i64, ptr %v140.p
  %st76 = getelementptr i64, ptr %v0, i64 5
  store i64 %v140, ptr %st76
  %v141.p = getelementptr i64, ptr %v129, i64 3
  %v141 = load i64, ptr %v141.p
  %st77 = getelementptr i64, ptr %v0, i64 6
  store i64 %v141, ptr %st77
  %v142.p = getelementptr i64, ptr %v129, i64 4
  %v142 = load i64, ptr %v142.p
  %st78 = getelementptr i64, ptr %v0, i64 7
  store i64 %v142, ptr %st78
  call void @"rt.region_relocate8"(ptr %v0, i64 %v19)
  %v143.p = getelementptr i64, ptr %v0, i64 3
  %v143 = load i64, ptr %v143.p
  %v144 = add i64 0, 0
  %v145.c = icmp ne i64 %v143, %v144
  %v145 = zext i1 %v145.c to i64
  %c.b18 = icmp ne i64 %v145, 0
  br i1 %c.b18, label %b18.t80, label %b18.e81
b18.t80:
  br label %b20
b18.e81:
  br label %b21
b19:
  br label %b22
b20:
  %v146 = add i64 0, 4
  %v147 = getelementptr i64, ptr %v0, i64 %v146
  call void @"rt.err_relocate"(ptr %v147, i64 %v19)
  br label %b21
b21:
  %v177 = getelementptr i64, ptr @"rt.meta", i64 0
  %st81 = getelementptr i64, ptr %v177, i64 0
  store i64 %v19, ptr %st81
  ret void
b22:
  %v148 = getelementptr i64, ptr %s11, i64 0
  %v149.p = getelementptr i64, ptr %v15, i64 0
  %v149 = load i64, ptr %v149.p
  %v150.p = getelementptr i64, ptr %v15, i64 1
  %v150 = load i64, ptr %v150.p
  %v151.p = getelementptr i64, ptr %v15, i64 2
  %v151 = load i64, ptr %v151.p
  %v152.p = getelementptr i64, ptr %v16, i64 0
  %v152 = load i64, ptr %v152.p
  %v153.p = getelementptr i64, ptr %v16, i64 1
  %v153 = load i64, ptr %v153.p
  %v154.p = getelementptr i64, ptr %v16, i64 2
  %v154 = load i64, ptr %v154.p
  %v155 = add i64 0, 1
  %v156.p = getelementptr i64, ptr %v18, i64 0
  %v156 = load i64, ptr %v156.p
  %v157.p = getelementptr i64, ptr %v18, i64 1
  %v157 = load i64, ptr %v157.p
  %v158.p = getelementptr i64, ptr %v18, i64 2
  %v158 = load i64, ptr %v158.p
  %v159 = getelementptr i64, ptr @"rt.meta", i64 0
  %st82 = getelementptr i64, ptr %v159, i64 2571
  store i64 %v29, ptr %st82
  call void @"std/crypto/chacha20.XorKeyStreamAt"(ptr %v148, i64 %v149, i64 %v150, i64 %v151, i64 %v152, i64 %v153, i64 %v154, i64 %v155, i64 %v156, i64 %v157, i64 %v158, i64 %v13, i64 %v74)
  %v160 = getelementptr i64, ptr %s7, i64 0
  %v161 = add i64 0, 0
  %st83 = getelementptr i64, ptr %v160, i64 0
  store i64 %v161, ptr %st83
  %v162.p = getelementptr i64, ptr %v148, i64 0
  %v162 = load i64, ptr %v162.p
  %st84 = getelementptr i64, ptr %v0, i64 0
  store i64 %v162, ptr %st84
  %v163.p = getelementptr i64, ptr %v148, i64 1
  %v163 = load i64, ptr %v163.p
  %st85 = getelementptr i64, ptr %v0, i64 1
  store i64 %v163, ptr %st85
  %v164.p = getelementptr i64, ptr %v148, i64 2
  %v164 = load i64, ptr %v164.p
  %st86 = getelementptr i64, ptr %v0, i64 2
  store i64 %v164, ptr %st86
  %v165.p = getelementptr i64, ptr %v160, i64 0
  %v165 = load i64, ptr %v165.p
  %st87 = getelementptr i64, ptr %v0, i64 3
  store i64 %v165, ptr %st87
  %v166.p = getelementptr i64, ptr %v160, i64 1
  %v166 = load i64, ptr %v166.p
  %st88 = getelementptr i64, ptr %v0, i64 4
  store i64 %v166, ptr %st88
  %v167.p = getelementptr i64, ptr %v160, i64 2
  %v167 = load i64, ptr %v167.p
  %st89 = getelementptr i64, ptr %v0, i64 5
  store i64 %v167, ptr %st89
  %v168.p = getelementptr i64, ptr %v160, i64 3
  %v168 = load i64, ptr %v168.p
  %st90 = getelementptr i64, ptr %v0, i64 6
  store i64 %v168, ptr %st90
  %v169.p = getelementptr i64, ptr %v160, i64 4
  %v169 = load i64, ptr %v169.p
  %st91 = getelementptr i64, ptr %v0, i64 7
  store i64 %v169, ptr %st91
  call void @"rt.region_relocate8"(ptr %v0, i64 %v19)
  %v170.p = getelementptr i64, ptr %v0, i64 3
  %v170 = load i64, ptr %v170.p
  %v171 = add i64 0, 0
  %v172.c = icmp ne i64 %v170, %v171
  %v172 = zext i1 %v172.c to i64
  %c.b22 = icmp ne i64 %v172, 0
  br i1 %c.b22, label %b22.t93, label %b22.e94
b22.t93:
  br label %b23
b22.e94:
  br label %b24
b23:
  %v173 = add i64 0, 4
  %v174 = getelementptr i64, ptr %v0, i64 %v173
  call void @"rt.err_relocate"(ptr %v174, i64 %v19)
  br label %b24
b24:
  %v178 = getelementptr i64, ptr @"rt.meta", i64 0
  %st94 = getelementptr i64, ptr %v178, i64 0
  store i64 %v19, ptr %st94
  ret void
}

define internal void @"std/crypto/chacha20poly1305.polyKey"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
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
  %v8 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v8, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v8, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v8, i64 2
  store i64 %v6, ptr %st5
  %v161 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v161, i64 0
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
  %v20 = getelementptr i64, ptr %s2, i64 0
  %v21.p = getelementptr i64, ptr %v7, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v7, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v7, i64 2
  %v23 = load i64, ptr %v23.p
  %v24.p = getelementptr i64, ptr %v8, i64 0
  %v24 = load i64, ptr %v24.p
  %v25.p = getelementptr i64, ptr %v8, i64 1
  %v25 = load i64, ptr %v25.p
  %v26.p = getelementptr i64, ptr %v8, i64 2
  %v26 = load i64, ptr %v26.p
  %v27 = add i64 0, 0
  %v28 = getelementptr i64, ptr @"rt.meta", i64 0
  %st7 = getelementptr i64, ptr %v28, i64 2571
  store i64 %v19, ptr %st7
  call void @"std/crypto/chacha20.Block"(ptr %v20, i64 %v21, i64 %v22, i64 %v23, i64 %v24, i64 %v25, i64 %v26, i64 %v27)
  %v29 = getelementptr i64, ptr %s3, i64 0
  %v30.p = getelementptr i64, ptr %v20, i64 0
  %v30 = load i64, ptr %v30.p
  %st8 = getelementptr i64, ptr %v29, i64 0
  store i64 %v30, ptr %st8
  %v31.p = getelementptr i64, ptr %v20, i64 1
  %v31 = load i64, ptr %v31.p
  %st9 = getelementptr i64, ptr %v29, i64 1
  store i64 %v31, ptr %st9
  %v32.p = getelementptr i64, ptr %v20, i64 2
  %v32 = load i64, ptr %v32.p
  %st10 = getelementptr i64, ptr %v29, i64 2
  store i64 %v32, ptr %st10
  %v33 = add i64 0, 0
  %v34 = call ptr @"rt.region_alloc8"(i64 %v19, i64 %v33)
  %v35 = add i64 0, 0
  %v36 = getelementptr i64, ptr %s4, i64 0
  %v37 = ptrtoint ptr %v34 to i64
  %st11 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st11
  %st12 = getelementptr i64, ptr %v36, i64 1
  store i64 %v35, ptr %st12
  %st13 = getelementptr i64, ptr %v36, i64 2
  store i64 %v19, ptr %st13
  %v38 = getelementptr i64, ptr %s5, i64 0
  %v39.p = getelementptr i64, ptr %v36, i64 0
  %v39 = load i64, ptr %v39.p
  %st14 = getelementptr i64, ptr %v38, i64 0
  store i64 %v39, ptr %st14
  %v40.p = getelementptr i64, ptr %v36, i64 1
  %v40 = load i64, ptr %v40.p
  %st15 = getelementptr i64, ptr %v38, i64 1
  store i64 %v40, ptr %st15
  %v41.p = getelementptr i64, ptr %v36, i64 2
  %v41 = load i64, ptr %v41.p
  %st16 = getelementptr i64, ptr %v38, i64 2
  store i64 %v41, ptr %st16
  %v42 = add i64 0, 0
  %v43 = add i64 0, 0
  %v44 = add i64 0, 32
  %v45 = sub i64 %v44, %v43
  %v46.c = icmp sle i64 %v45, %v42
  %v46 = zext i1 %v46.c to i64
  %c.b0 = icmp ne i64 %v46, 0
  br i1 %c.b0, label %b0.t18, label %b0.e19
b0.t18:
  br label %b1
b0.e19:
  br label %b2
b1:
  %v158.p = getelementptr i64, ptr %v38, i64 0
  %v158 = load i64, ptr %v158.p
  %st19 = getelementptr i64, ptr %v0, i64 0
  store i64 %v158, ptr %st19
  %v159.p = getelementptr i64, ptr %v38, i64 1
  %v159 = load i64, ptr %v159.p
  %st20 = getelementptr i64, ptr %v0, i64 1
  store i64 %v159, ptr %st20
  %v160.p = getelementptr i64, ptr %v38, i64 2
  %v160 = load i64, ptr %v160.p
  %st21 = getelementptr i64, ptr %v0, i64 2
  store i64 %v160, ptr %st21
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v162 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v162, i64 0
  store i64 %v9, ptr %st22
  ret void
b2:
  %v47.c = icmp sge i64 %v43, %v42
  %v47 = zext i1 %v47.c to i64
  %v48.p = getelementptr i64, ptr %v29, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp sle i64 %v44, %v48
  %v49 = zext i1 %v49.c to i64
  %v50 = and i64 %v47, %v49
  %v51.c = icmp ne i64 %v50, %v42
  %v51 = zext i1 %v51.c to i64
  %c.b2 = icmp ne i64 %v51, 0
  br i1 %c.b2, label %b2.t24, label %b2.e25
b2.t24:
  br label %b4
b2.e25:
  br label %b3
b3:
  %v163 = getelementptr i64, ptr @"rt.meta", i64 0
  %v108.p = getelementptr i64, ptr %v163, i64 0
  %v108 = load i64, ptr %v108.p
  %v109 = add i64 0, 0
  %v110 = add i64 0, 32
  %v111 = getelementptr i64, ptr %s7, i64 0
  %v164 = getelementptr i64, ptr @"rt.meta", i64 0
  %v112.p = getelementptr i64, ptr %v164, i64 0
  %v112 = load i64, ptr %v112.p
  %v113 = getelementptr i64, ptr %s8, i64 0
  %st25 = getelementptr i64, ptr %v113, i64 0
  store i64 %v109, ptr %st25
  %v165 = getelementptr i64, ptr @"rt.meta", i64 0
  %v114.p = getelementptr i64, ptr %v165, i64 0
  %v114 = load i64, ptr %v114.p
  br label %b16
b4:
  %v52 = getelementptr i64, ptr %s4, i64 0
  %v53.p = getelementptr i64, ptr %v38, i64 0
  %v53 = load i64, ptr %v53.p
  %st26 = getelementptr i64, ptr %v52, i64 0
  store i64 %v53, ptr %st26
  %v54.p = getelementptr i64, ptr %v38, i64 1
  %v54 = load i64, ptr %v54.p
  %st27 = getelementptr i64, ptr %v52, i64 1
  store i64 %v54, ptr %st27
  %v55.p = getelementptr i64, ptr %v38, i64 2
  %v55 = load i64, ptr %v55.p
  %st28 = getelementptr i64, ptr %v52, i64 2
  store i64 %v55, ptr %st28
  %v56.p = getelementptr i64, ptr %v52, i64 2
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v52, i64 0
  %v57 = load i64, ptr %v57.p
  %v58.p = getelementptr i64, ptr %v52, i64 1
  %v58 = load i64, ptr %v58.p
  %v59 = add i64 %v57, %v58
  %v62 = getelementptr i64, ptr @"rt.btip", i64 0
  %v63 = getelementptr i64, ptr %v62, i64 %v56
  %v64.p = getelementptr i64, ptr %v63, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.c = icmp eq i64 %v64, %v59
  %v65 = zext i1 %v65.c to i64
  %c.b4 = icmp ne i64 %v65, 0
  br i1 %c.b4, label %b4.t30, label %b4.e31
b4.t30:
  br label %b8
b4.e31:
  br label %b6
b5:
  %v60 = phi ptr [ %v95, %b6 ], [ %v92, %b7 ]
  %v61 = phi ptr [ %v97, %b6 ], [ %v93, %b7 ]
  %v98.p = getelementptr i64, ptr %v29, i64 0
  %v98 = load i64, ptr %v98.p
  %v99 = inttoptr i64 %v98 to ptr
  %v100 = getelementptr i8, ptr %v99, i64 %v43
  call void @"rt.copy8"(ptr %v61, ptr %v100, i64 %v45)
  %v101.p = getelementptr i64, ptr %v52, i64 1
  %v101 = load i64, ptr %v101.p
  %v102 = add i64 %v101, %v45
  %v103 = getelementptr i64, ptr %s6, i64 0
  %v104 = ptrtoint ptr %v60 to i64
  %st31 = getelementptr i64, ptr %v103, i64 0
  store i64 %v104, ptr %st31
  %st32 = getelementptr i64, ptr %v103, i64 1
  store i64 %v102, ptr %st32
  %st33 = getelementptr i64, ptr %v103, i64 2
  store i64 %v56, ptr %st33
  %v105.p = getelementptr i64, ptr %v103, i64 0
  %v105 = load i64, ptr %v105.p
  %st34 = getelementptr i64, ptr %v38, i64 0
  store i64 %v105, ptr %st34
  %v106.p = getelementptr i64, ptr %v103, i64 1
  %v106 = load i64, ptr %v106.p
  %st35 = getelementptr i64, ptr %v38, i64 1
  store i64 %v106, ptr %st35
  %v107.p = getelementptr i64, ptr %v103, i64 2
  %v107 = load i64, ptr %v107.p
  %st36 = getelementptr i64, ptr %v38, i64 2
  store i64 %v107, ptr %st36
  br label %b1
b6:
  %v94 = add i64 %v58, %v45
  %v95 = call ptr @"rt.region_alloc8"(i64 %v56, i64 %v94)
  %v96 = inttoptr i64 %v57 to ptr
  call void @"rt.copy8"(ptr %v95, ptr %v96, i64 %v58)
  %v97 = getelementptr i8, ptr %v95, i64 %v58
  br label %b5
b7:
  %v92 = inttoptr i64 %v57 to ptr
  %v93 = getelementptr i8, ptr %v92, i64 %v58
  br label %b5
b8:
  %v66 = add i64 0, 7
  %v67 = add i64 %v59, %v66
  %v68 = add i64 0, -8
  %v69 = and i64 %v67, %v68
  %v70 = add i64 %v59, %v45
  %v71 = add i64 0, 7
  %v72 = add i64 %v70, %v71
  %v73 = add i64 0, -8
  %v74 = and i64 %v72, %v73
  %v75 = getelementptr i64, ptr @"rt.meta", i64 0
  %v76 = getelementptr i64, ptr %v75, i64 %v56
  %v77.p = getelementptr i64, ptr %v76, i64 1
  %v77 = load i64, ptr %v77.p
  %v78.c = icmp sle i64 %v70, %v69
  %v78 = zext i1 %v78.c to i64
  %v79.c = icmp eq i64 %v77, %v69
  %v79 = zext i1 %v79.c to i64
  %v80 = or i64 %v78, %v79
  %v81 = add i64 0, 0
  %v82.c = icmp ne i64 %v80, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b8 = icmp ne i64 %v82, 0
  br i1 %c.b8, label %b8.t38, label %b8.e39
b8.t38:
  br label %b9
b8.e39:
  br label %b6
b9:
  %v83.c = icmp sgt i64 %v74, %v77
  %v83 = zext i1 %v83.c to i64
  %c.b9 = icmp ne i64 %v83, 0
  br i1 %c.b9, label %b9.t40, label %b9.e41
b9.t40:
  br label %b10
b9.e41:
  br label %b11
b10:
  %v84.p = getelementptr i64, ptr %v75, i64 1029
  %v84 = load i64, ptr %v84.p
  %v85 = add i64 0, 1
  %v86 = add i64 %v56, %v85
  %v87.p = getelementptr i64, ptr %v75, i64 1030
  %v87 = load i64, ptr %v87.p
  %v88 = mul i64 %v86, %v87
  %v89 = add i64 %v84, %v88
  %v90.c = icmp sgt i64 %v74, %v89
  %v90 = zext i1 %v90.c to i64
  %c.b10 = icmp ne i64 %v90, 0
  br i1 %c.b10, label %b10.t42, label %b10.e43
b10.t42:
  br label %b12
b10.e43:
  br label %b13
b11:
  %st43 = getelementptr i64, ptr %v63, i64 0
  store i64 %v70, ptr %st43
  br label %b7
b12:
  %v91 = add i64 0, 2
  call void @"rt.panic_mem"(i64 %v91)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 102)
  unreachable
b13:
  %st44 = getelementptr i64, ptr %v76, i64 1
  store i64 %v74, ptr %st44
  br label %b11
b14:
  %v166 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v166, i64 0
  store i64 %v108, ptr %st45
  br label %b1
b15:
  br label %b14
b16:
  %v167 = getelementptr i64, ptr @"rt.meta", i64 0
  %st46 = getelementptr i64, ptr %v167, i64 0
  store i64 %v114, ptr %st46
  %v115.p = getelementptr i64, ptr %v113, i64 0
  %v115 = load i64, ptr %v115.p
  %v116.c = icmp slt i64 %v115, %v110
  %v116 = zext i1 %v116.c to i64
  %c.b16 = icmp ne i64 %v116, 0
  br i1 %c.b16, label %b16.t48, label %b16.e49
b16.t48:
  br label %b17
b16.e49:
  br label %b18
b17:
  call void @"rt.region_enter"()
  %v168 = getelementptr i64, ptr @"rt.meta", i64 0
  %v117.p = getelementptr i64, ptr %v168, i64 0
  %v117 = load i64, ptr %v117.p
  %v118.p = getelementptr i64, ptr %v113, i64 0
  %v118 = load i64, ptr %v118.p
  %v169 = getelementptr i64, ptr @"rt.meta", i64 0
  %v119.p = getelementptr i64, ptr %v169, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = add i64 0, 1
  %v121 = add i64 %v9, %v120
  %v122 = getelementptr i64, ptr %s9, i64 0
  %v123.p = getelementptr i64, ptr %v38, i64 0
  %v123 = load i64, ptr %v123.p
  %st49 = getelementptr i64, ptr %v122, i64 0
  store i64 %v123, ptr %st49
  %v124.p = getelementptr i64, ptr %v38, i64 1
  %v124 = load i64, ptr %v124.p
  %st50 = getelementptr i64, ptr %v122, i64 1
  store i64 %v124, ptr %st50
  %v125.p = getelementptr i64, ptr %v38, i64 2
  %v125 = load i64, ptr %v125.p
  %st51 = getelementptr i64, ptr %v122, i64 2
  store i64 %v125, ptr %st51
  %v126.p = getelementptr i64, ptr %v29, i64 1
  %v126 = load i64, ptr %v126.p
  %v127.c = icmp uge i64 %v118, %v126
  %v127 = zext i1 %v127.c to i64
  %c.b17 = icmp ne i64 %v127, 0
  br i1 %c.b17, label %b17.t53, label %b17.e54
b17.t53:
  br label %b20
b17.e54:
  br label %b21
b18:
  %v170 = getelementptr i64, ptr @"rt.meta", i64 0
  %st54 = getelementptr i64, ptr %v170, i64 0
  store i64 %v114, ptr %st54
  br label %b15
b19:
  %v171 = getelementptr i64, ptr @"rt.meta", i64 0
  %st55 = getelementptr i64, ptr %v171, i64 0
  store i64 %v119, ptr %st55
  %v155 = add i64 0, 1
  %v156.p = getelementptr i64, ptr %v113, i64 0
  %v156 = load i64, ptr %v156.p
  %v157 = add i64 %v156, %v155
  %st56 = getelementptr i64, ptr %v113, i64 0
  store i64 %v157, ptr %st56
  br label %b16
b20:
  %v128 = add i64 0, 74
  call void @"rt.panic"(i64 %v128)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v129.p = getelementptr i64, ptr %v29, i64 0
  %v129 = load i64, ptr %v129.p
  %v130 = inttoptr i64 %v129 to ptr
  %v131 = getelementptr i8, ptr %v130, i64 %v118
  %v132.p = getelementptr i8, ptr %v131, i64 0
  %v132.b = load i8, ptr %v132.p
  %v132 = zext i8 %v132.b to i64
  %v133.p = getelementptr i64, ptr %v122, i64 2
  %v133 = load i64, ptr %v133.p
  %v134.p = getelementptr i64, ptr %v122, i64 0
  %v134 = load i64, ptr %v134.p
  %v135.p = getelementptr i64, ptr %v122, i64 1
  %v135 = load i64, ptr %v135.p
  %v138 = add i64 %v134, %v135
  %v139 = call i64 @"rt.tip8"(i64 %v133, i64 %v138)
  %v140 = add i64 0, 0
  %v141.c = icmp ne i64 %v139, %v140
  %v141 = zext i1 %v141.c to i64
  %c.b21 = icmp ne i64 %v141, 0
  br i1 %c.b21, label %b21.t58, label %b21.e59
b21.t58:
  br label %b24
b21.e59:
  br label %b23
b22:
  %v136 = phi ptr [ %v145, %b23 ], [ %v142, %b24 ]
  %v137 = phi ptr [ %v146, %b23 ], [ %v143, %b24 ]
  %st59 = getelementptr i8, ptr %v137, i64 0
  %st59.b = trunc i64 %v132 to i8
  store i8 %st59.b, ptr %st59
  %v147.p = getelementptr i64, ptr %v122, i64 1
  %v147 = load i64, ptr %v147.p
  %v148 = add i64 0, 1
  %v149 = add i64 %v147, %v148
  %v150 = getelementptr i64, ptr %s10, i64 0
  %v151 = ptrtoint ptr %v136 to i64
  %st60 = getelementptr i64, ptr %v150, i64 0
  store i64 %v151, ptr %st60
  %st61 = getelementptr i64, ptr %v150, i64 1
  store i64 %v149, ptr %st61
  %st62 = getelementptr i64, ptr %v150, i64 2
  store i64 %v133, ptr %st62
  %v152.p = getelementptr i64, ptr %v150, i64 0
  %v152 = load i64, ptr %v152.p
  %st63 = getelementptr i64, ptr %v38, i64 0
  store i64 %v152, ptr %st63
  %v153.p = getelementptr i64, ptr %v150, i64 1
  %v153 = load i64, ptr %v153.p
  %st64 = getelementptr i64, ptr %v38, i64 1
  store i64 %v153, ptr %st64
  %v154.p = getelementptr i64, ptr %v150, i64 2
  %v154 = load i64, ptr %v154.p
  %st65 = getelementptr i64, ptr %v38, i64 2
  store i64 %v154, ptr %st65
  br label %b19
b23:
  %v144 = add i64 0, 1
  %v145 = call ptr @"rt.slice_grow8"(i64 %v134, i64 %v135, i64 %v133, i64 %v144)
  %v146 = getelementptr i8, ptr %v145, i64 %v135
  br label %b22
b24:
  %v142 = inttoptr i64 %v134 to ptr
  %v143 = getelementptr i8, ptr %v142, i64 %v135
  br label %b22
}

define internal void @"std/crypto/poly1305.Sum"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %s2 = alloca [10 x i64], align 8
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
  %s2.z7 = getelementptr i64, ptr %s2, i64 7
  store i64 0, ptr %s2.z7
  %s2.z8 = getelementptr i64, ptr %s2, i64 8
  store i64 0, ptr %s2.z8
  %s2.z9 = getelementptr i64, ptr %s2, i64 9
  store i64 0, ptr %s2.z9
  %s3 = alloca [10 x i64], align 8
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
  %s3.z9 = getelementptr i64, ptr %s3, i64 9
  store i64 0, ptr %s3.z9
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
  %v62 = getelementptr i64, ptr @"rt.meta", i64 0
  %v9.p = getelementptr i64, ptr %v62, i64 0
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
  %v20 = getelementptr i64, ptr %s2, i64 0
  %v21.p = getelementptr i64, ptr %v7, i64 0
  %v21 = load i64, ptr %v21.p
  %v22.p = getelementptr i64, ptr %v7, i64 1
  %v22 = load i64, ptr %v22.p
  %v23.p = getelementptr i64, ptr %v7, i64 2
  %v23 = load i64, ptr %v23.p
  call void @"std/crypto/poly1305.start"(ptr %v20, i64 %v21, i64 %v22, i64 %v23)
  %v24 = getelementptr i64, ptr %s3, i64 0
  %v25.p = getelementptr i64, ptr %v20, i64 0
  %v25 = load i64, ptr %v25.p
  %st7 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st7
  %v26.p = getelementptr i64, ptr %v20, i64 1
  %v26 = load i64, ptr %v26.p
  %st8 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st8
  %v27.p = getelementptr i64, ptr %v20, i64 2
  %v27 = load i64, ptr %v27.p
  %st9 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st9
  %v28.p = getelementptr i64, ptr %v20, i64 3
  %v28 = load i64, ptr %v28.p
  %st10 = getelementptr i64, ptr %v24, i64 3
  store i64 %v28, ptr %st10
  %v29.p = getelementptr i64, ptr %v20, i64 4
  %v29 = load i64, ptr %v29.p
  %st11 = getelementptr i64, ptr %v24, i64 4
  store i64 %v29, ptr %st11
  %v30.p = getelementptr i64, ptr %v20, i64 5
  %v30 = load i64, ptr %v30.p
  %st12 = getelementptr i64, ptr %v24, i64 5
  store i64 %v30, ptr %st12
  %v31.p = getelementptr i64, ptr %v20, i64 6
  %v31 = load i64, ptr %v31.p
  %st13 = getelementptr i64, ptr %v24, i64 6
  store i64 %v31, ptr %st13
  %v32.p = getelementptr i64, ptr %v20, i64 7
  %v32 = load i64, ptr %v32.p
  %st14 = getelementptr i64, ptr %v24, i64 7
  store i64 %v32, ptr %st14
  %v33.p = getelementptr i64, ptr %v20, i64 8
  %v33 = load i64, ptr %v33.p
  %st15 = getelementptr i64, ptr %v24, i64 8
  store i64 %v33, ptr %st15
  %v34.p = getelementptr i64, ptr %v20, i64 9
  %v34 = load i64, ptr %v34.p
  %st16 = getelementptr i64, ptr %v24, i64 9
  store i64 %v34, ptr %st16
  %v35 = add i64 0, 1
  %v36 = add i64 %v9, %v35
  %v37.p = getelementptr i64, ptr %v8, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v8, i64 1
  %v38 = load i64, ptr %v38.p
  %v39.p = getelementptr i64, ptr %v8, i64 2
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 0
  %v41.p = getelementptr i64, ptr %v8, i64 1
  %v41 = load i64, ptr %v41.p
  %v42 = add i64 0, 0
  %v43 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v43, i64 2572
  store i64 %v36, ptr %st17
  call void @"std/crypto/poly1305.absorb"(ptr %v24, i64 %v37, i64 %v38, i64 %v39, i64 %v40, i64 %v41, i64 %v42)
  %v44 = getelementptr i64, ptr %s4, i64 0
  %v45.p = getelementptr i64, ptr %v24, i64 0
  %v45 = load i64, ptr %v45.p
  %v46.p = getelementptr i64, ptr %v24, i64 1
  %v46 = load i64, ptr %v46.p
  %v47.p = getelementptr i64, ptr %v24, i64 2
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v24, i64 3
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v24, i64 4
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v24, i64 5
  %v50 = load i64, ptr %v50.p
  %v51.p = getelementptr i64, ptr %v24, i64 6
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v24, i64 7
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v24, i64 8
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v24, i64 9
  %v54 = load i64, ptr %v54.p
  %v55.p = getelementptr i64, ptr %v7, i64 0
  %v55 = load i64, ptr %v55.p
  %v56.p = getelementptr i64, ptr %v7, i64 1
  %v56 = load i64, ptr %v56.p
  %v57.p = getelementptr i64, ptr %v7, i64 2
  %v57 = load i64, ptr %v57.p
  %v58 = getelementptr i64, ptr @"rt.meta", i64 0
  %st18 = getelementptr i64, ptr %v58, i64 2571
  store i64 %v19, ptr %st18
  call void @"std/crypto/poly1305.finish"(ptr %v44, i64 %v45, i64 %v46, i64 %v47, i64 %v48, i64 %v49, i64 %v50, i64 %v51, i64 %v52, i64 %v53, i64 %v54, i64 %v55, i64 %v56, i64 %v57)
  %v59.p = getelementptr i64, ptr %v44, i64 0
  %v59 = load i64, ptr %v59.p
  %st19 = getelementptr i64, ptr %v0, i64 0
  store i64 %v59, ptr %st19
  %v60.p = getelementptr i64, ptr %v44, i64 1
  %v60 = load i64, ptr %v60.p
  %st20 = getelementptr i64, ptr %v0, i64 1
  store i64 %v60, ptr %st20
  %v61.p = getelementptr i64, ptr %v44, i64 2
  %v61 = load i64, ptr %v61.p
  %st21 = getelementptr i64, ptr %v0, i64 2
  store i64 %v61, ptr %st21
  call void @"rt.region_relocate8"(ptr %v0, i64 %v9)
  %v63 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v63, i64 0
  store i64 %v9, ptr %st22
  ret void
}

define internal void @"std/crypto/poly1305.SumAead"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11) #0 {
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
  %s3 = alloca [10 x i64], align 8
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
  %s3.z9 = getelementptr i64, ptr %s3, i64 9
  store i64 0, ptr %s3.z9
  %s4 = alloca [10 x i64], align 8
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
  %s4.z6 = getelementptr i64, ptr %s4, i64 6
  store i64 0, ptr %s4.z6
  %s4.z7 = getelementptr i64, ptr %s4, i64 7
  store i64 0, ptr %s4.z7
  %s4.z8 = getelementptr i64, ptr %s4, i64 8
  store i64 0, ptr %s4.z8
  %s4.z9 = getelementptr i64, ptr %s4, i64 9
  store i64 0, ptr %s4.z9
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
  %v12 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v12, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v12, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v12, i64 2
  store i64 %v3, ptr %st2
  %v13 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v13, i64 0
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v13, i64 1
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v13, i64 2
  store i64 %v6, ptr %st5
  %v14 = getelementptr i64, ptr %s2, i64 0
  %st6 = getelementptr i64, ptr %v14, i64 0
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 1
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 2
  store i64 %v9, ptr %st8
  %v136 = getelementptr i64, ptr @"rt.meta", i64 0
  %v15.p = getelementptr i64, ptr %v136, i64 0
  %v15 = load i64, ptr %v15.p
  %v16 = getelementptr i64, ptr @"rt.meta", i64 0
  %v17.p = getelementptr i64, ptr %v16, i64 2571
  %v17 = load i64, ptr %v17.p
  %v18 = add i64 0, 0
  %st9 = getelementptr i64, ptr %v16, i64 2571
  store i64 %v18, ptr %st9
  %v19 = add i64 0, 1
  %v20.c = icmp sge i64 %v17, %v19
  %v20 = zext i1 %v20.c to i64
  %v21.c = icmp sle i64 %v17, %v15
  %v21 = zext i1 %v21.c to i64
  %v22 = and i64 %v20, %v21
  %v23 = sub i64 %v17, %v15
  %v24 = mul i64 %v22, %v23
  %v25 = add i64 %v15, %v24
  call void @"rt.region_enter"()
  %v26 = getelementptr i64, ptr %s3, i64 0
  %v27.p = getelementptr i64, ptr %v12, i64 0
  %v27 = load i64, ptr %v27.p
  %v28.p = getelementptr i64, ptr %v12, i64 1
  %v28 = load i64, ptr %v28.p
  %v29.p = getelementptr i64, ptr %v12, i64 2
  %v29 = load i64, ptr %v29.p
  call void @"std/crypto/poly1305.start"(ptr %v26, i64 %v27, i64 %v28, i64 %v29)
  %v30 = getelementptr i64, ptr %s4, i64 0
  %v31.p = getelementptr i64, ptr %v26, i64 0
  %v31 = load i64, ptr %v31.p
  %st10 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st10
  %v32.p = getelementptr i64, ptr %v26, i64 1
  %v32 = load i64, ptr %v32.p
  %st11 = getelementptr i64, ptr %v30, i64 1
  store i64 %v32, ptr %st11
  %v33.p = getelementptr i64, ptr %v26, i64 2
  %v33 = load i64, ptr %v33.p
  %st12 = getelementptr i64, ptr %v30, i64 2
  store i64 %v33, ptr %st12
  %v34.p = getelementptr i64, ptr %v26, i64 3
  %v34 = load i64, ptr %v34.p
  %st13 = getelementptr i64, ptr %v30, i64 3
  store i64 %v34, ptr %st13
  %v35.p = getelementptr i64, ptr %v26, i64 4
  %v35 = load i64, ptr %v35.p
  %st14 = getelementptr i64, ptr %v30, i64 4
  store i64 %v35, ptr %st14
  %v36.p = getelementptr i64, ptr %v26, i64 5
  %v36 = load i64, ptr %v36.p
  %st15 = getelementptr i64, ptr %v30, i64 5
  store i64 %v36, ptr %st15
  %v37.p = getelementptr i64, ptr %v26, i64 6
  %v37 = load i64, ptr %v37.p
  %st16 = getelementptr i64, ptr %v30, i64 6
  store i64 %v37, ptr %st16
  %v38.p = getelementptr i64, ptr %v26, i64 7
  %v38 = load i64, ptr %v38.p
  %st17 = getelementptr i64, ptr %v30, i64 7
  store i64 %v38, ptr %st17
  %v39.p = getelementptr i64, ptr %v26, i64 8
  %v39 = load i64, ptr %v39.p
  %st18 = getelementptr i64, ptr %v30, i64 8
  store i64 %v39, ptr %st18
  %v40.p = getelementptr i64, ptr %v26, i64 9
  %v40 = load i64, ptr %v40.p
  %st19 = getelementptr i64, ptr %v30, i64 9
  store i64 %v40, ptr %st19
  %v41 = add i64 0, 1
  %v42 = add i64 %v15, %v41
  %v43.p = getelementptr i64, ptr %v13, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v13, i64 1
  %v44 = load i64, ptr %v44.p
  %v45.p = getelementptr i64, ptr %v13, i64 2
  %v45 = load i64, ptr %v45.p
  %v46 = add i64 0, 0
  %v47.p = getelementptr i64, ptr %v13, i64 1
  %v47 = load i64, ptr %v47.p
  %v48 = add i64 0, 1
  %v49 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v49, i64 2572
  store i64 %v42, ptr %st20
  call void @"std/crypto/poly1305.absorb"(ptr %v30, i64 %v43, i64 %v44, i64 %v45, i64 %v46, i64 %v47, i64 %v48)
  %v50 = add i64 0, 1
  %v51 = add i64 %v15, %v50
  %v52.p = getelementptr i64, ptr %v14, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v14, i64 1
  %v53 = load i64, ptr %v53.p
  %v54.p = getelementptr i64, ptr %v14, i64 2
  %v54 = load i64, ptr %v54.p
  %v55 = add i64 0, 1
  %v56 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v56, i64 2572
  store i64 %v51, ptr %st21
  call void @"std/crypto/poly1305.absorb"(ptr %v30, i64 %v52, i64 %v53, i64 %v54, i64 %v10, i64 %v11, i64 %v55)
  %v137 = getelementptr i64, ptr @"rt.meta", i64 0
  %v57.p = getelementptr i64, ptr %v137, i64 0
  %v57 = load i64, ptr %v57.p
  %v58 = add i64 0, 0
  %v59 = call ptr @"rt.region_alloc8"(i64 %v57, i64 %v58)
  %v60 = add i64 0, 0
  %v61 = getelementptr i64, ptr %s5, i64 0
  %v62 = ptrtoint ptr %v59 to i64
  %st22 = getelementptr i64, ptr %v61, i64 0
  store i64 %v62, ptr %st22
  %st23 = getelementptr i64, ptr %v61, i64 1
  store i64 %v60, ptr %st23
  %st24 = getelementptr i64, ptr %v61, i64 2
  store i64 %v57, ptr %st24
  %v63 = getelementptr i64, ptr %s6, i64 0
  %v64.p = getelementptr i64, ptr %v61, i64 0
  %v64 = load i64, ptr %v64.p
  %st25 = getelementptr i64, ptr %v63, i64 0
  store i64 %v64, ptr %st25
  %v65.p = getelementptr i64, ptr %v61, i64 1
  %v65 = load i64, ptr %v65.p
  %st26 = getelementptr i64, ptr %v63, i64 1
  store i64 %v65, ptr %st26
  %v66.p = getelementptr i64, ptr %v61, i64 2
  %v66 = load i64, ptr %v66.p
  %st27 = getelementptr i64, ptr %v63, i64 2
  store i64 %v66, ptr %st27
  %v67 = add i64 0, 1
  %v68 = add i64 %v15, %v67
  %v69.p = getelementptr i64, ptr %v13, i64 1
  %v69 = load i64, ptr %v69.p
  %v70 = add i64 0, 4294967295
  %v71 = and i64 %v69, %v70
  %v72 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v72, i64 2572
  store i64 %v68, ptr %st28
  call void @"std/crypto/poly1305.put32"(ptr %v63, i64 %v71)
  %v73 = add i64 0, 1
  %v74 = add i64 %v15, %v73
  %v75.p = getelementptr i64, ptr %v13, i64 1
  %v75 = load i64, ptr %v75.p
  %v76 = add i64 0, 32
  %v78 = add i64 0, 0
  %v79.c = icmp slt i64 %v76, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b0 = icmp ne i64 %v79, 0
  br i1 %c.b0, label %b0.t30, label %b0.e31
b0.t30:
  br label %b1
b0.e31:
  br label %b2
b1:
  %v80 = add i64 0, 75
  call void @"rt.panic"(i64 %v80)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v81 = add i64 0, 63
  %v82.c = icmp sgt i64 %v76, %v81
  %v82 = zext i1 %v82.c to i64
  %c.b2 = icmp ne i64 %v82, 0
  br i1 %c.b2, label %b2.t32, label %b2.e33
b2.t32:
  br label %b4
b2.e33:
  br label %b5
b3:
  %v77 = phi i64 [ %v84, %b4 ], [ %v85, %b5 ]
  %v86 = add i64 0, 4294967295
  %v87 = and i64 %v77, %v86
  %v88 = getelementptr i64, ptr @"rt.meta", i64 0
  %st33 = getelementptr i64, ptr %v88, i64 2572
  store i64 %v74, ptr %st33
  call void @"std/crypto/poly1305.put32"(ptr %v63, i64 %v87)
  %v89 = add i64 0, 1
  %v90 = add i64 %v15, %v89
  %v91 = add i64 0, 4294967295
  %v92 = and i64 %v11, %v91
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %st34 = getelementptr i64, ptr %v93, i64 2572
  store i64 %v90, ptr %st34
  call void @"std/crypto/poly1305.put32"(ptr %v63, i64 %v92)
  %v94 = add i64 0, 1
  %v95 = add i64 %v15, %v94
  %v96 = add i64 0, 32
  %v98 = add i64 0, 0
  %v99.c = icmp slt i64 %v96, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b3 = icmp ne i64 %v99, 0
  br i1 %c.b3, label %b3.t36, label %b3.e37
b3.t36:
  br label %b6
b3.e37:
  br label %b7
b4:
  %v83 = add i64 0, 63
  %v84.n = and i64 %v83, 63
  %v84 = ashr i64 %v75, %v84.n
  br label %b3
b5:
  %v85.n = and i64 %v76, 63
  %v85 = ashr i64 %v75, %v85.n
  br label %b3
b6:
  %v100 = add i64 0, 76
  call void @"rt.panic"(i64 %v100)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v101 = add i64 0, 63
  %v102.c = icmp sgt i64 %v96, %v101
  %v102 = zext i1 %v102.c to i64
  %c.b7 = icmp ne i64 %v102, 0
  br i1 %c.b7, label %b7.t38, label %b7.e39
b7.t38:
  br label %b9
b7.e39:
  br label %b10
b8:
  %v97 = phi i64 [ %v104, %b9 ], [ %v105, %b10 ]
  %v106 = add i64 0, 4294967295
  %v107 = and i64 %v97, %v106
  %v108 = getelementptr i64, ptr @"rt.meta", i64 0
  %st39 = getelementptr i64, ptr %v108, i64 2572
  store i64 %v95, ptr %st39
  call void @"std/crypto/poly1305.put32"(ptr %v63, i64 %v107)
  %v109 = add i64 0, 1
  %v110 = add i64 %v15, %v109
  %v111.p = getelementptr i64, ptr %v63, i64 0
  %v111 = load i64, ptr %v111.p
  %v112.p = getelementptr i64, ptr %v63, i64 1
  %v112 = load i64, ptr %v112.p
  %v113.p = getelementptr i64, ptr %v63, i64 2
  %v113 = load i64, ptr %v113.p
  %v114 = add i64 0, 0
  %v115 = add i64 0, 16
  %v116 = add i64 0, 1
  %v117 = getelementptr i64, ptr @"rt.meta", i64 0
  %st40 = getelementptr i64, ptr %v117, i64 2572
  store i64 %v110, ptr %st40
  call void @"std/crypto/poly1305.absorb"(ptr %v30, i64 %v111, i64 %v112, i64 %v113, i64 %v114, i64 %v115, i64 %v116)
  %v118 = getelementptr i64, ptr %s7, i64 0
  %v119.p = getelementptr i64, ptr %v30, i64 0
  %v119 = load i64, ptr %v119.p
  %v120.p = getelementptr i64, ptr %v30, i64 1
  %v120 = load i64, ptr %v120.p
  %v121.p = getelementptr i64, ptr %v30, i64 2
  %v121 = load i64, ptr %v121.p
  %v122.p = getelementptr i64, ptr %v30, i64 3
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v30, i64 4
  %v123 = load i64, ptr %v123.p
  %v124.p = getelementptr i64, ptr %v30, i64 5
  %v124 = load i64, ptr %v124.p
  %v125.p = getelementptr i64, ptr %v30, i64 6
  %v125 = load i64, ptr %v125.p
  %v126.p = getelementptr i64, ptr %v30, i64 7
  %v126 = load i64, ptr %v126.p
  %v127.p = getelementptr i64, ptr %v30, i64 8
  %v127 = load i64, ptr %v127.p
  %v128.p = getelementptr i64, ptr %v30, i64 9
  %v128 = load i64, ptr %v128.p
  %v129.p = getelementptr i64, ptr %v12, i64 0
  %v129 = load i64, ptr %v129.p
  %v130.p = getelementptr i64, ptr %v12, i64 1
  %v130 = load i64, ptr %v130.p
  %v131.p = getelementptr i64, ptr %v12, i64 2
  %v131 = load i64, ptr %v131.p
  %v132 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v132, i64 2571
  store i64 %v25, ptr %st41
  call void @"std/crypto/poly1305.finish"(ptr %v118, i64 %v119, i64 %v120, i64 %v121, i64 %v122, i64 %v123, i64 %v124, i64 %v125, i64 %v126, i64 %v127, i64 %v128, i64 %v129, i64 %v130, i64 %v131)
  %v133.p = getelementptr i64, ptr %v118, i64 0
  %v133 = load i64, ptr %v133.p
  %st42 = getelementptr i64, ptr %v0, i64 0
  store i64 %v133, ptr %st42
  %v134.p = getelementptr i64, ptr %v118, i64 1
  %v134 = load i64, ptr %v134.p
  %st43 = getelementptr i64, ptr %v0, i64 1
  store i64 %v134, ptr %st43
  %v135.p = getelementptr i64, ptr %v118, i64 2
  %v135 = load i64, ptr %v135.p
  %st44 = getelementptr i64, ptr %v0, i64 2
  store i64 %v135, ptr %st44
  call void @"rt.region_relocate8"(ptr %v0, i64 %v15)
  %v138 = getelementptr i64, ptr @"rt.meta", i64 0
  %st45 = getelementptr i64, ptr %v138, i64 0
  store i64 %v15, ptr %st45
  ret void
b9:
  %v103 = add i64 0, 63
  %v104.n = and i64 %v103, 63
  %v104 = ashr i64 %v11, %v104.n
  br label %b8
b10:
  %v105.n = and i64 %v96, 63
  %v105 = ashr i64 %v11, %v105.n
  br label %b8
}

define internal void @"std/crypto/poly1305.start"(ptr %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
b0:
  %s0 = alloca [3 x i64], align 8
  %s0.z0 = getelementptr i64, ptr %s0, i64 0
  store i64 0, ptr %s0.z0
  %s0.z1 = getelementptr i64, ptr %s0, i64 1
  store i64 0, ptr %s0.z1
  %s0.z2 = getelementptr i64, ptr %s0, i64 2
  store i64 0, ptr %s0.z2
  %s1 = alloca [10 x i64], align 8
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
  %s1.z9 = getelementptr i64, ptr %s1, i64 9
  store i64 0, ptr %s1.z9
  %v4 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v4, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v4, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v4, i64 2
  store i64 %v3, ptr %st2
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v98, i64 0
  %v5 = load i64, ptr %v5.p
  call void @"rt.region_enter"()
  %v6.p = getelementptr i64, ptr %v4, i64 0
  %v6 = load i64, ptr %v6.p
  %v7.p = getelementptr i64, ptr %v4, i64 1
  %v7 = load i64, ptr %v7.p
  %v8.p = getelementptr i64, ptr %v4, i64 2
  %v8 = load i64, ptr %v8.p
  %v9 = add i64 0, 0
  %v10 = call i64 @"std/crypto/poly1305.le32"(i64 %v6, i64 %v7, i64 %v8, i64 %v9)
  %v11 = add i64 0, 67108863
  %v12 = and i64 %v10, %v11
  %v13.p = getelementptr i64, ptr %v4, i64 0
  %v13 = load i64, ptr %v13.p
  %v14.p = getelementptr i64, ptr %v4, i64 1
  %v14 = load i64, ptr %v14.p
  %v15.p = getelementptr i64, ptr %v4, i64 2
  %v15 = load i64, ptr %v15.p
  %v16 = add i64 0, 3
  %v17 = call i64 @"std/crypto/poly1305.le32"(i64 %v13, i64 %v14, i64 %v15, i64 %v16)
  %v18 = add i64 0, 2
  %v20 = add i64 0, 0
  %v21.c = icmp slt i64 %v18, %v20
  %v21 = zext i1 %v21.c to i64
  %c.b0 = icmp ne i64 %v21, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v22 = add i64 0, 77
  call void @"rt.panic"(i64 %v22)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v23 = add i64 0, 63
  %v24.c = icmp sgt i64 %v18, %v23
  %v24 = zext i1 %v24.c to i64
  %c.b2 = icmp ne i64 %v24, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b4
b2.e7:
  br label %b5
b3:
  %v19 = phi i64 [ %v26, %b4 ], [ %v27, %b5 ]
  %v28 = add i64 0, 67108611
  %v29 = and i64 %v19, %v28
  %v30.p = getelementptr i64, ptr %v4, i64 0
  %v30 = load i64, ptr %v30.p
  %v31.p = getelementptr i64, ptr %v4, i64 1
  %v31 = load i64, ptr %v31.p
  %v32.p = getelementptr i64, ptr %v4, i64 2
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 6
  %v34 = call i64 @"std/crypto/poly1305.le32"(i64 %v30, i64 %v31, i64 %v32, i64 %v33)
  %v35 = add i64 0, 4
  %v37 = add i64 0, 0
  %v38.c = icmp slt i64 %v35, %v37
  %v38 = zext i1 %v38.c to i64
  %c.b3 = icmp ne i64 %v38, 0
  br i1 %c.b3, label %b3.t8, label %b3.e9
b3.t8:
  br label %b6
b3.e9:
  br label %b7
b4:
  %v25 = add i64 0, 63
  %v26.n = and i64 %v25, 63
  %v26 = ashr i64 %v17, %v26.n
  br label %b3
b5:
  %v27.n = and i64 %v18, 63
  %v27 = ashr i64 %v17, %v27.n
  br label %b3
b6:
  %v39 = add i64 0, 78
  call void @"rt.panic"(i64 %v39)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v40 = add i64 0, 63
  %v41.c = icmp sgt i64 %v35, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b7 = icmp ne i64 %v41, 0
  br i1 %c.b7, label %b7.t10, label %b7.e11
b7.t10:
  br label %b9
b7.e11:
  br label %b10
b8:
  %v36 = phi i64 [ %v43, %b9 ], [ %v44, %b10 ]
  %v45 = add i64 0, 67092735
  %v46 = and i64 %v36, %v45
  %v47.p = getelementptr i64, ptr %v4, i64 0
  %v47 = load i64, ptr %v47.p
  %v48.p = getelementptr i64, ptr %v4, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.p = getelementptr i64, ptr %v4, i64 2
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 9
  %v51 = call i64 @"std/crypto/poly1305.le32"(i64 %v47, i64 %v48, i64 %v49, i64 %v50)
  %v52 = add i64 0, 6
  %v54 = add i64 0, 0
  %v55.c = icmp slt i64 %v52, %v54
  %v55 = zext i1 %v55.c to i64
  %c.b8 = icmp ne i64 %v55, 0
  br i1 %c.b8, label %b8.t12, label %b8.e13
b8.t12:
  br label %b11
b8.e13:
  br label %b12
b9:
  %v42 = add i64 0, 63
  %v43.n = and i64 %v42, 63
  %v43 = ashr i64 %v34, %v43.n
  br label %b8
b10:
  %v44.n = and i64 %v35, 63
  %v44 = ashr i64 %v34, %v44.n
  br label %b8
b11:
  %v56 = add i64 0, 79
  call void @"rt.panic"(i64 %v56)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v57 = add i64 0, 63
  %v58.c = icmp sgt i64 %v52, %v57
  %v58 = zext i1 %v58.c to i64
  %c.b12 = icmp ne i64 %v58, 0
  br i1 %c.b12, label %b12.t14, label %b12.e15
b12.t14:
  br label %b14
b12.e15:
  br label %b15
b13:
  %v53 = phi i64 [ %v60, %b14 ], [ %v61, %b15 ]
  %v62 = add i64 0, 66076671
  %v63 = and i64 %v53, %v62
  %v64.p = getelementptr i64, ptr %v4, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v4, i64 1
  %v65 = load i64, ptr %v65.p
  %v66.p = getelementptr i64, ptr %v4, i64 2
  %v66 = load i64, ptr %v66.p
  %v67 = add i64 0, 12
  %v68 = call i64 @"std/crypto/poly1305.le32"(i64 %v64, i64 %v65, i64 %v66, i64 %v67)
  %v69 = add i64 0, 8
  %v71 = add i64 0, 0
  %v72.c = icmp slt i64 %v69, %v71
  %v72 = zext i1 %v72.c to i64
  %c.b13 = icmp ne i64 %v72, 0
  br i1 %c.b13, label %b13.t16, label %b13.e17
b13.t16:
  br label %b16
b13.e17:
  br label %b17
b14:
  %v59 = add i64 0, 63
  %v60.n = and i64 %v59, 63
  %v60 = ashr i64 %v51, %v60.n
  br label %b13
b15:
  %v61.n = and i64 %v52, 63
  %v61 = ashr i64 %v51, %v61.n
  br label %b13
b16:
  %v73 = add i64 0, 80
  call void @"rt.panic"(i64 %v73)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v74 = add i64 0, 63
  %v75.c = icmp sgt i64 %v69, %v74
  %v75 = zext i1 %v75.c to i64
  %c.b17 = icmp ne i64 %v75, 0
  br i1 %c.b17, label %b17.t18, label %b17.e19
b17.t18:
  br label %b19
b17.e19:
  br label %b20
b18:
  %v70 = phi i64 [ %v77, %b19 ], [ %v78, %b20 ]
  %v79 = add i64 0, 1048575
  %v80 = and i64 %v70, %v79
  %v81 = add i64 0, 0
  %v82 = add i64 0, 0
  %v83 = add i64 0, 0
  %v84 = add i64 0, 0
  %v85 = add i64 0, 0
  %v86 = getelementptr i64, ptr %s1, i64 0
  %v87 = add i64 0, 0
  %st19 = getelementptr i64, ptr %v86, i64 0
  store i64 %v87, ptr %st19
  %st20 = getelementptr i64, ptr %v86, i64 1
  store i64 %v87, ptr %st20
  %st21 = getelementptr i64, ptr %v86, i64 2
  store i64 %v87, ptr %st21
  %st22 = getelementptr i64, ptr %v86, i64 3
  store i64 %v87, ptr %st22
  %st23 = getelementptr i64, ptr %v86, i64 4
  store i64 %v87, ptr %st23
  %st24 = getelementptr i64, ptr %v86, i64 5
  store i64 %v87, ptr %st24
  %st25 = getelementptr i64, ptr %v86, i64 6
  store i64 %v87, ptr %st25
  %st26 = getelementptr i64, ptr %v86, i64 7
  store i64 %v87, ptr %st26
  %st27 = getelementptr i64, ptr %v86, i64 8
  store i64 %v87, ptr %st27
  %st28 = getelementptr i64, ptr %v86, i64 9
  store i64 %v87, ptr %st28
  %st29 = getelementptr i64, ptr %v86, i64 0
  store i64 %v12, ptr %st29
  %st30 = getelementptr i64, ptr %v86, i64 1
  store i64 %v29, ptr %st30
  %st31 = getelementptr i64, ptr %v86, i64 2
  store i64 %v46, ptr %st31
  %st32 = getelementptr i64, ptr %v86, i64 3
  store i64 %v63, ptr %st32
  %st33 = getelementptr i64, ptr %v86, i64 4
  store i64 %v80, ptr %st33
  %st34 = getelementptr i64, ptr %v86, i64 5
  store i64 %v81, ptr %st34
  %st35 = getelementptr i64, ptr %v86, i64 6
  store i64 %v82, ptr %st35
  %st36 = getelementptr i64, ptr %v86, i64 7
  store i64 %v83, ptr %st36
  %st37 = getelementptr i64, ptr %v86, i64 8
  store i64 %v84, ptr %st37
  %st38 = getelementptr i64, ptr %v86, i64 9
  store i64 %v85, ptr %st38
  %v88.p = getelementptr i64, ptr %v86, i64 0
  %v88 = load i64, ptr %v88.p
  %st39 = getelementptr i64, ptr %v0, i64 0
  store i64 %v88, ptr %st39
  %v89.p = getelementptr i64, ptr %v86, i64 1
  %v89 = load i64, ptr %v89.p
  %st40 = getelementptr i64, ptr %v0, i64 1
  store i64 %v89, ptr %st40
  %v90.p = getelementptr i64, ptr %v86, i64 2
  %v90 = load i64, ptr %v90.p
  %st41 = getelementptr i64, ptr %v0, i64 2
  store i64 %v90, ptr %st41
  %v91.p = getelementptr i64, ptr %v86, i64 3
  %v91 = load i64, ptr %v91.p
  %st42 = getelementptr i64, ptr %v0, i64 3
  store i64 %v91, ptr %st42
  %v92.p = getelementptr i64, ptr %v86, i64 4
  %v92 = load i64, ptr %v92.p
  %st43 = getelementptr i64, ptr %v0, i64 4
  store i64 %v92, ptr %st43
  %v93.p = getelementptr i64, ptr %v86, i64 5
  %v93 = load i64, ptr %v93.p
  %st44 = getelementptr i64, ptr %v0, i64 5
  store i64 %v93, ptr %st44
  %v94.p = getelementptr i64, ptr %v86, i64 6
  %v94 = load i64, ptr %v94.p
  %st45 = getelementptr i64, ptr %v0, i64 6
  store i64 %v94, ptr %st45
  %v95.p = getelementptr i64, ptr %v86, i64 7
  %v95 = load i64, ptr %v95.p
  %st46 = getelementptr i64, ptr %v0, i64 7
  store i64 %v95, ptr %st46
  %v96.p = getelementptr i64, ptr %v86, i64 8
  %v96 = load i64, ptr %v96.p
  %st47 = getelementptr i64, ptr %v0, i64 8
  store i64 %v96, ptr %st47
  %v97.p = getelementptr i64, ptr %v86, i64 9
  %v97 = load i64, ptr %v97.p
  %st48 = getelementptr i64, ptr %v0, i64 9
  store i64 %v97, ptr %st48
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %st49 = getelementptr i64, ptr %v99, i64 0
  store i64 %v5, ptr %st49
  ret void
b19:
  %v76 = add i64 0, 63
  %v77.n = and i64 %v76, 63
  %v77 = ashr i64 %v68, %v77.n
  br label %b18
b20:
  %v78.n = and i64 %v69, 63
  %v78 = ashr i64 %v68, %v78.n
  br label %b18
}

define internal void @"std/crypto/poly1305.absorb"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %v353 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v353, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v9, i64 2572
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %v12.c = icmp eq i64 %v10, %v11
  %v12 = zext i1 %v12.c to i64
  %v13 = mul i64 %v12, %v8
  %v14 = add i64 %v10, %v13
  %v15.p = getelementptr i64, ptr %v0, i64 0
  %v15 = load i64, ptr %v15.p
  %v16.p = getelementptr i64, ptr %v0, i64 1
  %v16 = load i64, ptr %v16.p
  %v17.p = getelementptr i64, ptr %v0, i64 2
  %v17 = load i64, ptr %v17.p
  %v18.p = getelementptr i64, ptr %v0, i64 3
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v0, i64 4
  %v19 = load i64, ptr %v19.p
  %v20 = add i64 0, 5
  %v21 = mul i64 %v16, %v20
  %v22 = add i64 0, 5
  %v23 = mul i64 %v17, %v22
  %v24 = add i64 0, 5
  %v25 = mul i64 %v18, %v24
  %v26 = add i64 0, 5
  %v27 = mul i64 %v19, %v26
  %v28.p = getelementptr i64, ptr %v0, i64 5
  %v28 = load i64, ptr %v28.p
  %v29 = getelementptr i64, ptr %s1, i64 0
  %st3 = getelementptr i64, ptr %v29, i64 0
  store i64 %v28, ptr %st3
  %v30.p = getelementptr i64, ptr %v0, i64 6
  %v30 = load i64, ptr %v30.p
  %v31 = getelementptr i64, ptr %s2, i64 0
  %st4 = getelementptr i64, ptr %v31, i64 0
  store i64 %v30, ptr %st4
  %v32.p = getelementptr i64, ptr %v0, i64 7
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s3, i64 0
  %st5 = getelementptr i64, ptr %v33, i64 0
  store i64 %v32, ptr %st5
  %v34.p = getelementptr i64, ptr %v0, i64 8
  %v34 = load i64, ptr %v34.p
  %v35 = getelementptr i64, ptr %s4, i64 0
  %st6 = getelementptr i64, ptr %v35, i64 0
  store i64 %v34, ptr %st6
  %v36.p = getelementptr i64, ptr %v0, i64 9
  %v36 = load i64, ptr %v36.p
  %v37 = getelementptr i64, ptr %s5, i64 0
  %st7 = getelementptr i64, ptr %v37, i64 0
  store i64 %v36, ptr %st7
  %v38 = add i64 0, 0
  %v39 = getelementptr i64, ptr %s6, i64 0
  %st8 = getelementptr i64, ptr %v39, i64 0
  store i64 %v38, ptr %st8
  %v354 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v354, i64 0
  %v40 = load i64, ptr %v40.p
  br label %b1
b1:
  %v355 = getelementptr i64, ptr @"rt.meta", i64 0
  %st9 = getelementptr i64, ptr %v355, i64 0
  store i64 %v40, ptr %st9
  %v41.p = getelementptr i64, ptr %v39, i64 0
  %v41 = load i64, ptr %v41.p
  %v42.c = icmp slt i64 %v41, %v5
  %v42 = zext i1 %v42.c to i64
  %c.b1 = icmp ne i64 %v42, 0
  br i1 %c.b1, label %b1.t11, label %b1.e12
b1.t11:
  br label %b2
b1.e12:
  br label %b3
b2:
  call void @"rt.region_enter"()
  %v356 = getelementptr i64, ptr @"rt.meta", i64 0
  %v43.p = getelementptr i64, ptr %v356, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v39, i64 0
  %v44 = load i64, ptr %v44.p
  %v45 = sub i64 %v5, %v44
  %v46 = add i64 0, 16
  %v47.c = icmp sge i64 %v45, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b2 = icmp ne i64 %v47, 0
  br i1 %c.b2, label %b2.t13, label %b2.e14
b2.t13:
  br label %b4
b2.e14:
  br label %b5
b3:
  %v357 = getelementptr i64, ptr @"rt.meta", i64 0
  %st14 = getelementptr i64, ptr %v357, i64 0
  store i64 %v40, ptr %st14
  %v338.p = getelementptr i64, ptr %v29, i64 0
  %v338 = load i64, ptr %v338.p
  %v339 = add i64 0, 5
  %v340 = getelementptr i64, ptr %v0, i64 %v339
  %st15 = getelementptr i64, ptr %v340, i64 0
  store i64 %v338, ptr %st15
  %v341.p = getelementptr i64, ptr %v31, i64 0
  %v341 = load i64, ptr %v341.p
  %v342 = add i64 0, 6
  %v343 = getelementptr i64, ptr %v0, i64 %v342
  %st16 = getelementptr i64, ptr %v343, i64 0
  store i64 %v341, ptr %st16
  %v344.p = getelementptr i64, ptr %v33, i64 0
  %v344 = load i64, ptr %v344.p
  %v345 = add i64 0, 7
  %v346 = getelementptr i64, ptr %v0, i64 %v345
  %st17 = getelementptr i64, ptr %v346, i64 0
  store i64 %v344, ptr %st17
  %v347.p = getelementptr i64, ptr %v35, i64 0
  %v347 = load i64, ptr %v347.p
  %v348 = add i64 0, 8
  %v349 = getelementptr i64, ptr %v0, i64 %v348
  %st18 = getelementptr i64, ptr %v349, i64 0
  store i64 %v347, ptr %st18
  %v350.p = getelementptr i64, ptr %v37, i64 0
  %v350 = load i64, ptr %v350.p
  %v351 = add i64 0, 9
  %v352 = getelementptr i64, ptr %v0, i64 %v351
  %st19 = getelementptr i64, ptr %v352, i64 0
  store i64 %v350, ptr %st19
  %v358 = getelementptr i64, ptr @"rt.meta", i64 0
  %st20 = getelementptr i64, ptr %v358, i64 0
  store i64 %v8, ptr %st20
  ret void
b4:
  br label %b6
b5:
  %v48 = getelementptr i64, ptr %s7, i64 0
  %v49.p = getelementptr i64, ptr %v7, i64 0
  %v49 = load i64, ptr %v49.p
  %v50.p = getelementptr i64, ptr %v7, i64 1
  %v50 = load i64, ptr %v50.p
  %v51.p = getelementptr i64, ptr %v7, i64 2
  %v51 = load i64, ptr %v51.p
  %v52.p = getelementptr i64, ptr %v39, i64 0
  %v52 = load i64, ptr %v52.p
  %v53 = add i64 %v4, %v52
  %v54.p = getelementptr i64, ptr %v39, i64 0
  %v54 = load i64, ptr %v54.p
  %v55 = sub i64 %v5, %v54
  call void @"std/crypto/poly1305.tail"(ptr %v48, i64 %v49, i64 %v50, i64 %v51, i64 %v53, i64 %v55, i64 %v6)
  br label %b6
b6:
  %v56 = phi ptr [ %v7, %b4 ], [ %v48, %b5 ]
  %v57 = getelementptr i64, ptr %s8, i64 0
  %v58.p = getelementptr i64, ptr %v56, i64 0
  %v58 = load i64, ptr %v58.p
  %st21 = getelementptr i64, ptr %v57, i64 0
  store i64 %v58, ptr %st21
  %v59.p = getelementptr i64, ptr %v56, i64 1
  %v59 = load i64, ptr %v59.p
  %st22 = getelementptr i64, ptr %v57, i64 1
  store i64 %v59, ptr %st22
  %v60.p = getelementptr i64, ptr %v56, i64 2
  %v60 = load i64, ptr %v60.p
  %st23 = getelementptr i64, ptr %v57, i64 2
  store i64 %v60, ptr %st23
  %c.b6 = icmp ne i64 %v47, 0
  br i1 %c.b6, label %b6.t25, label %b6.e26
b6.t25:
  br label %b7
b6.e26:
  br label %b8
b7:
  %v61.p = getelementptr i64, ptr %v39, i64 0
  %v61 = load i64, ptr %v61.p
  %v62 = add i64 %v4, %v61
  br label %b9
b8:
  %v63 = add i64 0, 0
  br label %b9
b9:
  %v64 = phi i64 [ %v62, %b7 ], [ %v63, %b8 ]
  %c.b9 = icmp ne i64 %v47, 0
  br i1 %c.b9, label %b9.t27, label %b9.e28
b9.t27:
  br label %b11
b9.e28:
  br label %b10
b10:
  br label %b11
b11:
  %v65 = phi i64 [ %v47, %b9.t27 ], [ %v6, %b10 ]
  %c.b11 = icmp ne i64 %v65, 0
  br i1 %c.b11, label %b11.t29, label %b11.e30
b11.t29:
  br label %b12
b11.e30:
  br label %b13
b12:
  %v66 = add i64 0, 1
  %v67 = add i64 0, 24
  %v69 = add i64 0, 0
  %v70.c = icmp slt i64 %v67, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b12 = icmp ne i64 %v70, 0
  br i1 %c.b12, label %b12.t31, label %b12.e32
b12.t31:
  br label %b14
b12.e32:
  br label %b15
b13:
  %v76 = add i64 0, 0
  br label %b19
b14:
  %v71 = add i64 0, 81
  call void @"rt.panic"(i64 %v71)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v72 = add i64 0, 63
  %v73.c = icmp sgt i64 %v67, %v72
  %v73 = zext i1 %v73.c to i64
  %c.b15 = icmp ne i64 %v73, 0
  br i1 %c.b15, label %b15.t33, label %b15.e34
b15.t33:
  br label %b17
b15.e34:
  br label %b18
b16:
  %v68 = phi i64 [ %v74, %b17 ], [ %v75, %b18 ]
  br label %b19
b17:
  %v74 = add i64 0, 0
  br label %b16
b18:
  %v75.n = and i64 %v67, 63
  %v75 = shl i64 %v66, %v75.n
  br label %b16
b19:
  %v77 = phi i64 [ %v76, %b13 ], [ %v68, %b16 ]
  %v78.p = getelementptr i64, ptr %v29, i64 0
  %v78 = load i64, ptr %v78.p
  %v79.p = getelementptr i64, ptr %v57, i64 0
  %v79 = load i64, ptr %v79.p
  %v80.p = getelementptr i64, ptr %v57, i64 1
  %v80 = load i64, ptr %v80.p
  %v81.p = getelementptr i64, ptr %v57, i64 2
  %v81 = load i64, ptr %v81.p
  %v82 = call i64 @"std/crypto/poly1305.le32"(i64 %v79, i64 %v80, i64 %v81, i64 %v64)
  %v83 = add i64 0, 67108863
  %v84 = and i64 %v82, %v83
  %v85 = add i64 %v78, %v84
  %st34 = getelementptr i64, ptr %v29, i64 0
  store i64 %v85, ptr %st34
  %v86.p = getelementptr i64, ptr %v31, i64 0
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v57, i64 0
  %v87 = load i64, ptr %v87.p
  %v88.p = getelementptr i64, ptr %v57, i64 1
  %v88 = load i64, ptr %v88.p
  %v89.p = getelementptr i64, ptr %v57, i64 2
  %v89 = load i64, ptr %v89.p
  %v90 = add i64 0, 3
  %v91 = add i64 %v64, %v90
  %v92 = call i64 @"std/crypto/poly1305.le32"(i64 %v87, i64 %v88, i64 %v89, i64 %v91)
  %v93 = add i64 0, 2
  %v95 = add i64 0, 0
  %v96.c = icmp slt i64 %v93, %v95
  %v96 = zext i1 %v96.c to i64
  %c.b19 = icmp ne i64 %v96, 0
  br i1 %c.b19, label %b19.t36, label %b19.e37
b19.t36:
  br label %b20
b19.e37:
  br label %b21
b20:
  %v97 = add i64 0, 82
  call void @"rt.panic"(i64 %v97)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b21:
  %v98 = add i64 0, 63
  %v99.c = icmp sgt i64 %v93, %v98
  %v99 = zext i1 %v99.c to i64
  %c.b21 = icmp ne i64 %v99, 0
  br i1 %c.b21, label %b21.t38, label %b21.e39
b21.t38:
  br label %b23
b21.e39:
  br label %b24
b22:
  %v94 = phi i64 [ %v101, %b23 ], [ %v102, %b24 ]
  %v103 = add i64 0, 67108863
  %v104 = and i64 %v94, %v103
  %v105 = add i64 %v86, %v104
  %st39 = getelementptr i64, ptr %v31, i64 0
  store i64 %v105, ptr %st39
  %v106.p = getelementptr i64, ptr %v33, i64 0
  %v106 = load i64, ptr %v106.p
  %v107.p = getelementptr i64, ptr %v57, i64 0
  %v107 = load i64, ptr %v107.p
  %v108.p = getelementptr i64, ptr %v57, i64 1
  %v108 = load i64, ptr %v108.p
  %v109.p = getelementptr i64, ptr %v57, i64 2
  %v109 = load i64, ptr %v109.p
  %v110 = add i64 0, 6
  %v111 = add i64 %v64, %v110
  %v112 = call i64 @"std/crypto/poly1305.le32"(i64 %v107, i64 %v108, i64 %v109, i64 %v111)
  %v113 = add i64 0, 4
  %v115 = add i64 0, 0
  %v116.c = icmp slt i64 %v113, %v115
  %v116 = zext i1 %v116.c to i64
  %c.b22 = icmp ne i64 %v116, 0
  br i1 %c.b22, label %b22.t41, label %b22.e42
b22.t41:
  br label %b25
b22.e42:
  br label %b26
b23:
  %v100 = add i64 0, 63
  %v101.n = and i64 %v100, 63
  %v101 = ashr i64 %v92, %v101.n
  br label %b22
b24:
  %v102.n = and i64 %v93, 63
  %v102 = ashr i64 %v92, %v102.n
  br label %b22
b25:
  %v117 = add i64 0, 83
  call void @"rt.panic"(i64 %v117)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b26:
  %v118 = add i64 0, 63
  %v119.c = icmp sgt i64 %v113, %v118
  %v119 = zext i1 %v119.c to i64
  %c.b26 = icmp ne i64 %v119, 0
  br i1 %c.b26, label %b26.t43, label %b26.e44
b26.t43:
  br label %b28
b26.e44:
  br label %b29
b27:
  %v114 = phi i64 [ %v121, %b28 ], [ %v122, %b29 ]
  %v123 = add i64 0, 67108863
  %v124 = and i64 %v114, %v123
  %v125 = add i64 %v106, %v124
  %st44 = getelementptr i64, ptr %v33, i64 0
  store i64 %v125, ptr %st44
  %v126.p = getelementptr i64, ptr %v35, i64 0
  %v126 = load i64, ptr %v126.p
  %v127.p = getelementptr i64, ptr %v57, i64 0
  %v127 = load i64, ptr %v127.p
  %v128.p = getelementptr i64, ptr %v57, i64 1
  %v128 = load i64, ptr %v128.p
  %v129.p = getelementptr i64, ptr %v57, i64 2
  %v129 = load i64, ptr %v129.p
  %v130 = add i64 0, 9
  %v131 = add i64 %v64, %v130
  %v132 = call i64 @"std/crypto/poly1305.le32"(i64 %v127, i64 %v128, i64 %v129, i64 %v131)
  %v133 = add i64 0, 6
  %v135 = add i64 0, 0
  %v136.c = icmp slt i64 %v133, %v135
  %v136 = zext i1 %v136.c to i64
  %c.b27 = icmp ne i64 %v136, 0
  br i1 %c.b27, label %b27.t46, label %b27.e47
b27.t46:
  br label %b30
b27.e47:
  br label %b31
b28:
  %v120 = add i64 0, 63
  %v121.n = and i64 %v120, 63
  %v121 = ashr i64 %v112, %v121.n
  br label %b27
b29:
  %v122.n = and i64 %v113, 63
  %v122 = ashr i64 %v112, %v122.n
  br label %b27
b30:
  %v137 = add i64 0, 84
  call void @"rt.panic"(i64 %v137)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b31:
  %v138 = add i64 0, 63
  %v139.c = icmp sgt i64 %v133, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b31 = icmp ne i64 %v139, 0
  br i1 %c.b31, label %b31.t48, label %b31.e49
b31.t48:
  br label %b33
b31.e49:
  br label %b34
b32:
  %v134 = phi i64 [ %v141, %b33 ], [ %v142, %b34 ]
  %v143 = add i64 0, 67108863
  %v144 = and i64 %v134, %v143
  %v145 = add i64 %v126, %v144
  %st49 = getelementptr i64, ptr %v35, i64 0
  store i64 %v145, ptr %st49
  %v146.p = getelementptr i64, ptr %v37, i64 0
  %v146 = load i64, ptr %v146.p
  %v147.p = getelementptr i64, ptr %v57, i64 0
  %v147 = load i64, ptr %v147.p
  %v148.p = getelementptr i64, ptr %v57, i64 1
  %v148 = load i64, ptr %v148.p
  %v149.p = getelementptr i64, ptr %v57, i64 2
  %v149 = load i64, ptr %v149.p
  %v150 = add i64 0, 12
  %v151 = add i64 %v64, %v150
  %v152 = call i64 @"std/crypto/poly1305.le32"(i64 %v147, i64 %v148, i64 %v149, i64 %v151)
  %v153 = add i64 0, 8
  %v155 = add i64 0, 0
  %v156.c = icmp slt i64 %v153, %v155
  %v156 = zext i1 %v156.c to i64
  %c.b32 = icmp ne i64 %v156, 0
  br i1 %c.b32, label %b32.t51, label %b32.e52
b32.t51:
  br label %b35
b32.e52:
  br label %b36
b33:
  %v140 = add i64 0, 63
  %v141.n = and i64 %v140, 63
  %v141 = ashr i64 %v132, %v141.n
  br label %b32
b34:
  %v142.n = and i64 %v133, 63
  %v142 = ashr i64 %v132, %v142.n
  br label %b32
b35:
  %v157 = add i64 0, 85
  call void @"rt.panic"(i64 %v157)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b36:
  %v158 = add i64 0, 63
  %v159.c = icmp sgt i64 %v153, %v158
  %v159 = zext i1 %v159.c to i64
  %c.b36 = icmp ne i64 %v159, 0
  br i1 %c.b36, label %b36.t53, label %b36.e54
b36.t53:
  br label %b38
b36.e54:
  br label %b39
b37:
  %v154 = phi i64 [ %v161, %b38 ], [ %v162, %b39 ]
  %v163 = or i64 %v154, %v77
  %v164 = add i64 %v146, %v163
  %st54 = getelementptr i64, ptr %v37, i64 0
  store i64 %v164, ptr %st54
  %v165.p = getelementptr i64, ptr %v29, i64 0
  %v165 = load i64, ptr %v165.p
  %v166 = mul i64 %v165, %v15
  %v167.p = getelementptr i64, ptr %v31, i64 0
  %v167 = load i64, ptr %v167.p
  %v168 = mul i64 %v167, %v27
  %v169 = add i64 %v166, %v168
  %v170.p = getelementptr i64, ptr %v33, i64 0
  %v170 = load i64, ptr %v170.p
  %v171 = mul i64 %v170, %v25
  %v172 = add i64 %v169, %v171
  %v173.p = getelementptr i64, ptr %v35, i64 0
  %v173 = load i64, ptr %v173.p
  %v174 = mul i64 %v173, %v23
  %v175 = add i64 %v172, %v174
  %v176.p = getelementptr i64, ptr %v37, i64 0
  %v176 = load i64, ptr %v176.p
  %v177 = mul i64 %v176, %v21
  %v178 = add i64 %v175, %v177
  %v179.p = getelementptr i64, ptr %v29, i64 0
  %v179 = load i64, ptr %v179.p
  %v180 = mul i64 %v179, %v16
  %v181.p = getelementptr i64, ptr %v31, i64 0
  %v181 = load i64, ptr %v181.p
  %v182 = mul i64 %v181, %v15
  %v183 = add i64 %v180, %v182
  %v184.p = getelementptr i64, ptr %v33, i64 0
  %v184 = load i64, ptr %v184.p
  %v185 = mul i64 %v184, %v27
  %v186 = add i64 %v183, %v185
  %v187.p = getelementptr i64, ptr %v35, i64 0
  %v187 = load i64, ptr %v187.p
  %v188 = mul i64 %v187, %v25
  %v189 = add i64 %v186, %v188
  %v190.p = getelementptr i64, ptr %v37, i64 0
  %v190 = load i64, ptr %v190.p
  %v191 = mul i64 %v190, %v23
  %v192 = add i64 %v189, %v191
  %v193 = getelementptr i64, ptr %s9, i64 0
  %st55 = getelementptr i64, ptr %v193, i64 0
  store i64 %v192, ptr %st55
  %v194.p = getelementptr i64, ptr %v29, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = mul i64 %v194, %v17
  %v196.p = getelementptr i64, ptr %v31, i64 0
  %v196 = load i64, ptr %v196.p
  %v197 = mul i64 %v196, %v16
  %v198 = add i64 %v195, %v197
  %v199.p = getelementptr i64, ptr %v33, i64 0
  %v199 = load i64, ptr %v199.p
  %v200 = mul i64 %v199, %v15
  %v201 = add i64 %v198, %v200
  %v202.p = getelementptr i64, ptr %v35, i64 0
  %v202 = load i64, ptr %v202.p
  %v203 = mul i64 %v202, %v27
  %v204 = add i64 %v201, %v203
  %v205.p = getelementptr i64, ptr %v37, i64 0
  %v205 = load i64, ptr %v205.p
  %v206 = mul i64 %v205, %v25
  %v207 = add i64 %v204, %v206
  %v208 = getelementptr i64, ptr %s10, i64 0
  %st56 = getelementptr i64, ptr %v208, i64 0
  store i64 %v207, ptr %st56
  %v209.p = getelementptr i64, ptr %v29, i64 0
  %v209 = load i64, ptr %v209.p
  %v210 = mul i64 %v209, %v18
  %v211.p = getelementptr i64, ptr %v31, i64 0
  %v211 = load i64, ptr %v211.p
  %v212 = mul i64 %v211, %v17
  %v213 = add i64 %v210, %v212
  %v214.p = getelementptr i64, ptr %v33, i64 0
  %v214 = load i64, ptr %v214.p
  %v215 = mul i64 %v214, %v16
  %v216 = add i64 %v213, %v215
  %v217.p = getelementptr i64, ptr %v35, i64 0
  %v217 = load i64, ptr %v217.p
  %v218 = mul i64 %v217, %v15
  %v219 = add i64 %v216, %v218
  %v220.p = getelementptr i64, ptr %v37, i64 0
  %v220 = load i64, ptr %v220.p
  %v221 = mul i64 %v220, %v27
  %v222 = add i64 %v219, %v221
  %v223 = getelementptr i64, ptr %s11, i64 0
  %st57 = getelementptr i64, ptr %v223, i64 0
  store i64 %v222, ptr %st57
  %v224.p = getelementptr i64, ptr %v29, i64 0
  %v224 = load i64, ptr %v224.p
  %v225 = mul i64 %v224, %v19
  %v226.p = getelementptr i64, ptr %v31, i64 0
  %v226 = load i64, ptr %v226.p
  %v227 = mul i64 %v226, %v18
  %v228 = add i64 %v225, %v227
  %v229.p = getelementptr i64, ptr %v33, i64 0
  %v229 = load i64, ptr %v229.p
  %v230 = mul i64 %v229, %v17
  %v231 = add i64 %v228, %v230
  %v232.p = getelementptr i64, ptr %v35, i64 0
  %v232 = load i64, ptr %v232.p
  %v233 = mul i64 %v232, %v16
  %v234 = add i64 %v231, %v233
  %v235.p = getelementptr i64, ptr %v37, i64 0
  %v235 = load i64, ptr %v235.p
  %v236 = mul i64 %v235, %v15
  %v237 = add i64 %v234, %v236
  %v238 = getelementptr i64, ptr %s12, i64 0
  %st58 = getelementptr i64, ptr %v238, i64 0
  store i64 %v237, ptr %st58
  %v239 = add i64 0, 67108863
  %v240 = and i64 %v178, %v239
  %st59 = getelementptr i64, ptr %v29, i64 0
  store i64 %v240, ptr %st59
  %v241.p = getelementptr i64, ptr %v193, i64 0
  %v241 = load i64, ptr %v241.p
  %v242 = add i64 0, 26
  %v244 = add i64 0, 0
  %v245.c = icmp slt i64 %v242, %v244
  %v245 = zext i1 %v245.c to i64
  %c.b37 = icmp ne i64 %v245, 0
  br i1 %c.b37, label %b37.t61, label %b37.e62
b37.t61:
  br label %b40
b37.e62:
  br label %b41
b38:
  %v160 = add i64 0, 63
  %v161.n = and i64 %v160, 63
  %v161 = ashr i64 %v152, %v161.n
  br label %b37
b39:
  %v162.n = and i64 %v153, 63
  %v162 = ashr i64 %v152, %v162.n
  br label %b37
b40:
  %v246 = add i64 0, 86
  call void @"rt.panic"(i64 %v246)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b41:
  %v247 = add i64 0, 63
  %v248.c = icmp sgt i64 %v242, %v247
  %v248 = zext i1 %v248.c to i64
  %c.b41 = icmp ne i64 %v248, 0
  br i1 %c.b41, label %b41.t63, label %b41.e64
b41.t63:
  br label %b43
b41.e64:
  br label %b44
b42:
  %v243 = phi i64 [ %v250, %b43 ], [ %v251, %b44 ]
  %v252 = add i64 %v241, %v243
  %st64 = getelementptr i64, ptr %v193, i64 0
  store i64 %v252, ptr %st64
  %v253.p = getelementptr i64, ptr %v193, i64 0
  %v253 = load i64, ptr %v253.p
  %v254 = add i64 0, 67108863
  %v255 = and i64 %v253, %v254
  %st65 = getelementptr i64, ptr %v31, i64 0
  store i64 %v255, ptr %st65
  %v256.p = getelementptr i64, ptr %v208, i64 0
  %v256 = load i64, ptr %v256.p
  %v257.p = getelementptr i64, ptr %v193, i64 0
  %v257 = load i64, ptr %v257.p
  %v258 = add i64 0, 26
  %v260 = add i64 0, 0
  %v261.c = icmp slt i64 %v258, %v260
  %v261 = zext i1 %v261.c to i64
  %c.b42 = icmp ne i64 %v261, 0
  br i1 %c.b42, label %b42.t67, label %b42.e68
b42.t67:
  br label %b45
b42.e68:
  br label %b46
b43:
  %v249 = add i64 0, 63
  %v250.n = and i64 %v249, 63
  %v250 = ashr i64 %v178, %v250.n
  br label %b42
b44:
  %v251.n = and i64 %v242, 63
  %v251 = ashr i64 %v178, %v251.n
  br label %b42
b45:
  %v262 = add i64 0, 87
  call void @"rt.panic"(i64 %v262)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b46:
  %v263 = add i64 0, 63
  %v264.c = icmp sgt i64 %v258, %v263
  %v264 = zext i1 %v264.c to i64
  %c.b46 = icmp ne i64 %v264, 0
  br i1 %c.b46, label %b46.t69, label %b46.e70
b46.t69:
  br label %b48
b46.e70:
  br label %b49
b47:
  %v259 = phi i64 [ %v266, %b48 ], [ %v267, %b49 ]
  %v268 = add i64 %v256, %v259
  %st70 = getelementptr i64, ptr %v208, i64 0
  store i64 %v268, ptr %st70
  %v269.p = getelementptr i64, ptr %v208, i64 0
  %v269 = load i64, ptr %v269.p
  %v270 = add i64 0, 67108863
  %v271 = and i64 %v269, %v270
  %st71 = getelementptr i64, ptr %v33, i64 0
  store i64 %v271, ptr %st71
  %v272.p = getelementptr i64, ptr %v223, i64 0
  %v272 = load i64, ptr %v272.p
  %v273.p = getelementptr i64, ptr %v208, i64 0
  %v273 = load i64, ptr %v273.p
  %v274 = add i64 0, 26
  %v276 = add i64 0, 0
  %v277.c = icmp slt i64 %v274, %v276
  %v277 = zext i1 %v277.c to i64
  %c.b47 = icmp ne i64 %v277, 0
  br i1 %c.b47, label %b47.t73, label %b47.e74
b47.t73:
  br label %b50
b47.e74:
  br label %b51
b48:
  %v265 = add i64 0, 63
  %v266.n = and i64 %v265, 63
  %v266 = ashr i64 %v257, %v266.n
  br label %b47
b49:
  %v267.n = and i64 %v258, 63
  %v267 = ashr i64 %v257, %v267.n
  br label %b47
b50:
  %v278 = add i64 0, 88
  call void @"rt.panic"(i64 %v278)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b51:
  %v279 = add i64 0, 63
  %v280.c = icmp sgt i64 %v274, %v279
  %v280 = zext i1 %v280.c to i64
  %c.b51 = icmp ne i64 %v280, 0
  br i1 %c.b51, label %b51.t75, label %b51.e76
b51.t75:
  br label %b53
b51.e76:
  br label %b54
b52:
  %v275 = phi i64 [ %v282, %b53 ], [ %v283, %b54 ]
  %v284 = add i64 %v272, %v275
  %st76 = getelementptr i64, ptr %v223, i64 0
  store i64 %v284, ptr %st76
  %v285.p = getelementptr i64, ptr %v223, i64 0
  %v285 = load i64, ptr %v285.p
  %v286 = add i64 0, 67108863
  %v287 = and i64 %v285, %v286
  %st77 = getelementptr i64, ptr %v35, i64 0
  store i64 %v287, ptr %st77
  %v288.p = getelementptr i64, ptr %v238, i64 0
  %v288 = load i64, ptr %v288.p
  %v289.p = getelementptr i64, ptr %v223, i64 0
  %v289 = load i64, ptr %v289.p
  %v290 = add i64 0, 26
  %v292 = add i64 0, 0
  %v293.c = icmp slt i64 %v290, %v292
  %v293 = zext i1 %v293.c to i64
  %c.b52 = icmp ne i64 %v293, 0
  br i1 %c.b52, label %b52.t79, label %b52.e80
b52.t79:
  br label %b55
b52.e80:
  br label %b56
b53:
  %v281 = add i64 0, 63
  %v282.n = and i64 %v281, 63
  %v282 = ashr i64 %v273, %v282.n
  br label %b52
b54:
  %v283.n = and i64 %v274, 63
  %v283 = ashr i64 %v273, %v283.n
  br label %b52
b55:
  %v294 = add i64 0, 89
  call void @"rt.panic"(i64 %v294)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b56:
  %v295 = add i64 0, 63
  %v296.c = icmp sgt i64 %v290, %v295
  %v296 = zext i1 %v296.c to i64
  %c.b56 = icmp ne i64 %v296, 0
  br i1 %c.b56, label %b56.t81, label %b56.e82
b56.t81:
  br label %b58
b56.e82:
  br label %b59
b57:
  %v291 = phi i64 [ %v298, %b58 ], [ %v299, %b59 ]
  %v300 = add i64 %v288, %v291
  %st82 = getelementptr i64, ptr %v238, i64 0
  store i64 %v300, ptr %st82
  %v301.p = getelementptr i64, ptr %v238, i64 0
  %v301 = load i64, ptr %v301.p
  %v302 = add i64 0, 67108863
  %v303 = and i64 %v301, %v302
  %st83 = getelementptr i64, ptr %v37, i64 0
  store i64 %v303, ptr %st83
  %v304.p = getelementptr i64, ptr %v29, i64 0
  %v304 = load i64, ptr %v304.p
  %v305.p = getelementptr i64, ptr %v238, i64 0
  %v305 = load i64, ptr %v305.p
  %v306 = add i64 0, 26
  %v308 = add i64 0, 0
  %v309.c = icmp slt i64 %v306, %v308
  %v309 = zext i1 %v309.c to i64
  %c.b57 = icmp ne i64 %v309, 0
  br i1 %c.b57, label %b57.t85, label %b57.e86
b57.t85:
  br label %b60
b57.e86:
  br label %b61
b58:
  %v297 = add i64 0, 63
  %v298.n = and i64 %v297, 63
  %v298 = ashr i64 %v289, %v298.n
  br label %b57
b59:
  %v299.n = and i64 %v290, 63
  %v299 = ashr i64 %v289, %v299.n
  br label %b57
b60:
  %v310 = add i64 0, 90
  call void @"rt.panic"(i64 %v310)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b61:
  %v311 = add i64 0, 63
  %v312.c = icmp sgt i64 %v306, %v311
  %v312 = zext i1 %v312.c to i64
  %c.b61 = icmp ne i64 %v312, 0
  br i1 %c.b61, label %b61.t87, label %b61.e88
b61.t87:
  br label %b63
b61.e88:
  br label %b64
b62:
  %v307 = phi i64 [ %v314, %b63 ], [ %v315, %b64 ]
  %v316 = add i64 0, 5
  %v317 = mul i64 %v307, %v316
  %v318 = add i64 %v304, %v317
  %st88 = getelementptr i64, ptr %v29, i64 0
  store i64 %v318, ptr %st88
  %v319.p = getelementptr i64, ptr %v31, i64 0
  %v319 = load i64, ptr %v319.p
  %v320.p = getelementptr i64, ptr %v29, i64 0
  %v320 = load i64, ptr %v320.p
  %v321 = add i64 0, 26
  %v323 = add i64 0, 0
  %v324.c = icmp slt i64 %v321, %v323
  %v324 = zext i1 %v324.c to i64
  %c.b62 = icmp ne i64 %v324, 0
  br i1 %c.b62, label %b62.t90, label %b62.e91
b62.t90:
  br label %b65
b62.e91:
  br label %b66
b63:
  %v313 = add i64 0, 63
  %v314.n = and i64 %v313, 63
  %v314 = ashr i64 %v305, %v314.n
  br label %b62
b64:
  %v315.n = and i64 %v306, 63
  %v315 = ashr i64 %v305, %v315.n
  br label %b62
b65:
  %v325 = add i64 0, 91
  call void @"rt.panic"(i64 %v325)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b66:
  %v326 = add i64 0, 63
  %v327.c = icmp sgt i64 %v321, %v326
  %v327 = zext i1 %v327.c to i64
  %c.b66 = icmp ne i64 %v327, 0
  br i1 %c.b66, label %b66.t92, label %b66.e93
b66.t92:
  br label %b68
b66.e93:
  br label %b69
b67:
  %v322 = phi i64 [ %v329, %b68 ], [ %v330, %b69 ]
  %v331 = add i64 %v319, %v322
  %st93 = getelementptr i64, ptr %v31, i64 0
  store i64 %v331, ptr %st93
  %v332.p = getelementptr i64, ptr %v29, i64 0
  %v332 = load i64, ptr %v332.p
  %v333 = add i64 0, 67108863
  %v334 = and i64 %v332, %v333
  %st94 = getelementptr i64, ptr %v29, i64 0
  store i64 %v334, ptr %st94
  %v335.p = getelementptr i64, ptr %v39, i64 0
  %v335 = load i64, ptr %v335.p
  %v336 = add i64 0, 16
  %v337 = add i64 %v335, %v336
  %st95 = getelementptr i64, ptr %v39, i64 0
  store i64 %v337, ptr %st95
  br label %b1
b68:
  %v328 = add i64 0, 63
  %v329.n = and i64 %v328, 63
  %v329 = ashr i64 %v320, %v329.n
  br label %b67
b69:
  %v330.n = and i64 %v321, 63
  %v330 = ashr i64 %v320, %v330.n
  br label %b67
}

define internal void @"std/crypto/poly1305.tail"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6) #0 {
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
  %v7 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v7, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v7, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v7, i64 2
  store i64 %v3, ptr %st2
  %v91 = getelementptr i64, ptr @"rt.meta", i64 0
  %v8.p = getelementptr i64, ptr %v91, i64 0
  %v8 = load i64, ptr %v8.p
  %v9 = getelementptr i64, ptr @"rt.meta", i64 0
  %v10.p = getelementptr i64, ptr %v9, i64 2571
  %v10 = load i64, ptr %v10.p
  %v11 = add i64 0, 0
  %st3 = getelementptr i64, ptr %v9, i64 2571
  store i64 %v11, ptr %st3
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
  %v19 = add i64 0, 0
  %v20 = call ptr @"rt.region_alloc8"(i64 %v18, i64 %v19)
  %v21 = add i64 0, 0
  %v22 = getelementptr i64, ptr %s1, i64 0
  %v23 = ptrtoint ptr %v20 to i64
  %st4 = getelementptr i64, ptr %v22, i64 0
  store i64 %v23, ptr %st4
  %st5 = getelementptr i64, ptr %v22, i64 1
  store i64 %v21, ptr %st5
  %st6 = getelementptr i64, ptr %v22, i64 2
  store i64 %v18, ptr %st6
  %v24 = getelementptr i64, ptr %s2, i64 0
  %v25.p = getelementptr i64, ptr %v22, i64 0
  %v25 = load i64, ptr %v25.p
  %st7 = getelementptr i64, ptr %v24, i64 0
  store i64 %v25, ptr %st7
  %v26.p = getelementptr i64, ptr %v22, i64 1
  %v26 = load i64, ptr %v26.p
  %st8 = getelementptr i64, ptr %v24, i64 1
  store i64 %v26, ptr %st8
  %v27.p = getelementptr i64, ptr %v22, i64 2
  %v27 = load i64, ptr %v27.p
  %st9 = getelementptr i64, ptr %v24, i64 2
  store i64 %v27, ptr %st9
  %v92 = getelementptr i64, ptr @"rt.meta", i64 0
  %v28.p = getelementptr i64, ptr %v92, i64 0
  %v28 = load i64, ptr %v28.p
  %v29 = add i64 0, 0
  %v30 = add i64 0, 16
  %v31 = getelementptr i64, ptr %s3, i64 0
  %v93 = getelementptr i64, ptr @"rt.meta", i64 0
  %v32.p = getelementptr i64, ptr %v93, i64 0
  %v32 = load i64, ptr %v32.p
  %v33 = getelementptr i64, ptr %s4, i64 0
  %st10 = getelementptr i64, ptr %v33, i64 0
  store i64 %v29, ptr %st10
  %v94 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v94, i64 0
  %v34 = load i64, ptr %v34.p
  br label %b3
b1:
  %v95 = getelementptr i64, ptr @"rt.meta", i64 0
  %st11 = getelementptr i64, ptr %v95, i64 0
  store i64 %v28, ptr %st11
  %v88.p = getelementptr i64, ptr %v24, i64 0
  %v88 = load i64, ptr %v88.p
  %st12 = getelementptr i64, ptr %v0, i64 0
  store i64 %v88, ptr %st12
  %v89.p = getelementptr i64, ptr %v24, i64 1
  %v89 = load i64, ptr %v89.p
  %st13 = getelementptr i64, ptr %v0, i64 1
  store i64 %v89, ptr %st13
  %v90.p = getelementptr i64, ptr %v24, i64 2
  %v90 = load i64, ptr %v90.p
  %st14 = getelementptr i64, ptr %v0, i64 2
  store i64 %v90, ptr %st14
  call void @"rt.region_relocate8"(ptr %v0, i64 %v8)
  %v96 = getelementptr i64, ptr @"rt.meta", i64 0
  %st15 = getelementptr i64, ptr %v96, i64 0
  store i64 %v8, ptr %st15
  ret void
b2:
  br label %b1
b3:
  %v97 = getelementptr i64, ptr @"rt.meta", i64 0
  %st16 = getelementptr i64, ptr %v97, i64 0
  store i64 %v34, ptr %st16
  %v35.p = getelementptr i64, ptr %v33, i64 0
  %v35 = load i64, ptr %v35.p
  %v36.c = icmp slt i64 %v35, %v30
  %v36 = zext i1 %v36.c to i64
  %c.b3 = icmp ne i64 %v36, 0
  br i1 %c.b3, label %b3.t18, label %b3.e19
b3.t18:
  br label %b4
b3.e19:
  br label %b5
b4:
  call void @"rt.region_enter"()
  %v98 = getelementptr i64, ptr @"rt.meta", i64 0
  %v37.p = getelementptr i64, ptr %v98, i64 0
  %v37 = load i64, ptr %v37.p
  %v38.p = getelementptr i64, ptr %v33, i64 0
  %v38 = load i64, ptr %v38.p
  %v99 = getelementptr i64, ptr @"rt.meta", i64 0
  %v39.p = getelementptr i64, ptr %v99, i64 0
  %v39 = load i64, ptr %v39.p
  %v40 = add i64 0, 1
  %v41 = add i64 %v8, %v40
  %v42 = getelementptr i64, ptr %s1, i64 0
  %v43.p = getelementptr i64, ptr %v24, i64 0
  %v43 = load i64, ptr %v43.p
  %st19 = getelementptr i64, ptr %v42, i64 0
  store i64 %v43, ptr %st19
  %v44.p = getelementptr i64, ptr %v24, i64 1
  %v44 = load i64, ptr %v44.p
  %st20 = getelementptr i64, ptr %v42, i64 1
  store i64 %v44, ptr %st20
  %v45.p = getelementptr i64, ptr %v24, i64 2
  %v45 = load i64, ptr %v45.p
  %st21 = getelementptr i64, ptr %v42, i64 2
  store i64 %v45, ptr %st21
  %v46.c = icmp slt i64 %v38, %v5
  %v46 = zext i1 %v46.c to i64
  %c.b4 = icmp ne i64 %v46, 0
  br i1 %c.b4, label %b4.t23, label %b4.e24
b4.t23:
  br label %b7
b4.e24:
  br label %b8
b5:
  %v100 = getelementptr i64, ptr @"rt.meta", i64 0
  %st24 = getelementptr i64, ptr %v100, i64 0
  store i64 %v34, ptr %st24
  br label %b2
b6:
  %v101 = getelementptr i64, ptr @"rt.meta", i64 0
  %st25 = getelementptr i64, ptr %v101, i64 0
  store i64 %v39, ptr %st25
  %v85 = add i64 0, 1
  %v86.p = getelementptr i64, ptr %v33, i64 0
  %v86 = load i64, ptr %v86.p
  %v87 = add i64 %v86, %v85
  %st26 = getelementptr i64, ptr %v33, i64 0
  store i64 %v87, ptr %st26
  br label %b3
b7:
  %v47 = add i64 %v4, %v38
  %v48.p = getelementptr i64, ptr %v7, i64 1
  %v48 = load i64, ptr %v48.p
  %v49.c = icmp uge i64 %v47, %v48
  %v49 = zext i1 %v49.c to i64
  %c.b7 = icmp ne i64 %v49, 0
  br i1 %c.b7, label %b7.t28, label %b7.e29
b7.t28:
  br label %b9
b7.e29:
  br label %b10
b8:
  %v55.c = icmp eq i64 %v38, %v5
  %v55 = zext i1 %v55.c to i64
  %c.b8 = icmp ne i64 %v55, 0
  br i1 %c.b8, label %b8.t30, label %b8.e31
b8.t30:
  br label %b11
b8.e31:
  br label %b12
b9:
  %v50 = add i64 0, 92
  call void @"rt.panic"(i64 %v50)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v51.p = getelementptr i64, ptr %v7, i64 0
  %v51 = load i64, ptr %v51.p
  %v52 = inttoptr i64 %v51 to ptr
  %v53 = getelementptr i8, ptr %v52, i64 %v47
  %v54.p = getelementptr i8, ptr %v53, i64 0
  %v54.b = load i8, ptr %v54.p
  %v54 = zext i8 %v54.b to i64
  br label %b16
b11:
  %v57 = add i64 0, 1
  %v58 = xor i64 %v6, %v57
  br label %b12
b12:
  %v56 = phi i64 [ %v55, %b8.e31 ], [ %v58, %b11 ]
  %c.b12 = icmp ne i64 %v56, 0
  br i1 %c.b12, label %b12.t32, label %b12.e33
b12.t32:
  br label %b13
b12.e33:
  br label %b14
b13:
  %v59 = add i64 0, 1
  br label %b15
b14:
  %v60 = add i64 0, 0
  br label %b15
b15:
  %v61 = phi i64 [ %v59, %b13 ], [ %v60, %b14 ]
  br label %b16
b16:
  %v62 = phi i64 [ %v54, %b10 ], [ %v61, %b15 ]
  %v63.p = getelementptr i64, ptr %v42, i64 2
  %v63 = load i64, ptr %v63.p
  %v64.p = getelementptr i64, ptr %v42, i64 0
  %v64 = load i64, ptr %v64.p
  %v65.p = getelementptr i64, ptr %v42, i64 1
  %v65 = load i64, ptr %v65.p
  %v68 = add i64 %v64, %v65
  %v69 = call i64 @"rt.tip8"(i64 %v63, i64 %v68)
  %v70 = add i64 0, 0
  %v71.c = icmp ne i64 %v69, %v70
  %v71 = zext i1 %v71.c to i64
  %c.b16 = icmp ne i64 %v71, 0
  br i1 %c.b16, label %b16.t34, label %b16.e35
b16.t34:
  br label %b19
b16.e35:
  br label %b18
b17:
  %v66 = phi ptr [ %v75, %b18 ], [ %v72, %b19 ]
  %v67 = phi ptr [ %v76, %b18 ], [ %v73, %b19 ]
  %st35 = getelementptr i8, ptr %v67, i64 0
  %st35.b = trunc i64 %v62 to i8
  store i8 %st35.b, ptr %st35
  %v77.p = getelementptr i64, ptr %v42, i64 1
  %v77 = load i64, ptr %v77.p
  %v78 = add i64 0, 1
  %v79 = add i64 %v77, %v78
  %v80 = getelementptr i64, ptr %s5, i64 0
  %v81 = ptrtoint ptr %v66 to i64
  %st36 = getelementptr i64, ptr %v80, i64 0
  store i64 %v81, ptr %st36
  %st37 = getelementptr i64, ptr %v80, i64 1
  store i64 %v79, ptr %st37
  %st38 = getelementptr i64, ptr %v80, i64 2
  store i64 %v63, ptr %st38
  %v82.p = getelementptr i64, ptr %v80, i64 0
  %v82 = load i64, ptr %v82.p
  %st39 = getelementptr i64, ptr %v24, i64 0
  store i64 %v82, ptr %st39
  %v83.p = getelementptr i64, ptr %v80, i64 1
  %v83 = load i64, ptr %v83.p
  %st40 = getelementptr i64, ptr %v24, i64 1
  store i64 %v83, ptr %st40
  %v84.p = getelementptr i64, ptr %v80, i64 2
  %v84 = load i64, ptr %v84.p
  %st41 = getelementptr i64, ptr %v24, i64 2
  store i64 %v84, ptr %st41
  br label %b6
b18:
  %v74 = add i64 0, 1
  %v75 = call ptr @"rt.slice_grow8"(i64 %v64, i64 %v65, i64 %v63, i64 %v74)
  %v76 = getelementptr i8, ptr %v75, i64 %v65
  br label %b17
b19:
  %v72 = inttoptr i64 %v64 to ptr
  %v73 = getelementptr i8, ptr %v72, i64 %v65
  br label %b17
}

define internal void @"std/crypto/poly1305.finish"(ptr %v0, i64 %v1, i64 %v2, i64 %v3, i64 %v4, i64 %v5, i64 %v6, i64 %v7, i64 %v8, i64 %v9, i64 %v10, i64 %v11, i64 %v12, i64 %v13) #0 {
b0:
  %s0 = alloca [10 x i64], align 8
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
  %s0.z9 = getelementptr i64, ptr %s0, i64 9
  store i64 0, ptr %s0.z9
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
  %s5 = alloca [1 x i64], align 8
  %s5.z0 = getelementptr i64, ptr %s5, i64 0
  store i64 0, ptr %s5.z0
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
  %v14 = getelementptr i64, ptr %s0, i64 0
  %st0 = getelementptr i64, ptr %v14, i64 0
  store i64 %v1, ptr %st0
  %st1 = getelementptr i64, ptr %v14, i64 1
  store i64 %v2, ptr %st1
  %st2 = getelementptr i64, ptr %v14, i64 2
  store i64 %v3, ptr %st2
  %st3 = getelementptr i64, ptr %v14, i64 3
  store i64 %v4, ptr %st3
  %st4 = getelementptr i64, ptr %v14, i64 4
  store i64 %v5, ptr %st4
  %st5 = getelementptr i64, ptr %v14, i64 5
  store i64 %v6, ptr %st5
  %st6 = getelementptr i64, ptr %v14, i64 6
  store i64 %v7, ptr %st6
  %st7 = getelementptr i64, ptr %v14, i64 7
  store i64 %v8, ptr %st7
  %st8 = getelementptr i64, ptr %v14, i64 8
  store i64 %v9, ptr %st8
  %st9 = getelementptr i64, ptr %v14, i64 9
  store i64 %v10, ptr %st9
  %v15 = getelementptr i64, ptr %s1, i64 0
  %st10 = getelementptr i64, ptr %v15, i64 0
  store i64 %v11, ptr %st10
  %st11 = getelementptr i64, ptr %v15, i64 1
  store i64 %v12, ptr %st11
  %st12 = getelementptr i64, ptr %v15, i64 2
  store i64 %v13, ptr %st12
  %v440 = getelementptr i64, ptr @"rt.meta", i64 0
  %v16.p = getelementptr i64, ptr %v440, i64 0
  %v16 = load i64, ptr %v16.p
  %v17 = getelementptr i64, ptr @"rt.meta", i64 0
  %v18.p = getelementptr i64, ptr %v17, i64 2571
  %v18 = load i64, ptr %v18.p
  %v19 = add i64 0, 0
  %st13 = getelementptr i64, ptr %v17, i64 2571
  store i64 %v19, ptr %st13
  %v20 = add i64 0, 1
  %v21.c = icmp sge i64 %v18, %v20
  %v21 = zext i1 %v21.c to i64
  %v22.c = icmp sle i64 %v18, %v16
  %v22 = zext i1 %v22.c to i64
  %v23 = and i64 %v21, %v22
  %v24 = sub i64 %v18, %v16
  %v25 = mul i64 %v23, %v24
  %v26 = add i64 %v16, %v25
  call void @"rt.region_enter"()
  %v27.p = getelementptr i64, ptr %v14, i64 5
  %v27 = load i64, ptr %v27.p
  %v28 = getelementptr i64, ptr %s2, i64 0
  %st14 = getelementptr i64, ptr %v28, i64 0
  store i64 %v27, ptr %st14
  %v29.p = getelementptr i64, ptr %v14, i64 6
  %v29 = load i64, ptr %v29.p
  %v30 = getelementptr i64, ptr %s3, i64 0
  %st15 = getelementptr i64, ptr %v30, i64 0
  store i64 %v29, ptr %st15
  %v31.p = getelementptr i64, ptr %v14, i64 7
  %v31 = load i64, ptr %v31.p
  %v32 = getelementptr i64, ptr %s4, i64 0
  %st16 = getelementptr i64, ptr %v32, i64 0
  store i64 %v31, ptr %st16
  %v33.p = getelementptr i64, ptr %v14, i64 8
  %v33 = load i64, ptr %v33.p
  %v34 = getelementptr i64, ptr %s5, i64 0
  %st17 = getelementptr i64, ptr %v34, i64 0
  store i64 %v33, ptr %st17
  %v35.p = getelementptr i64, ptr %v14, i64 9
  %v35 = load i64, ptr %v35.p
  %v36 = getelementptr i64, ptr %s6, i64 0
  %st18 = getelementptr i64, ptr %v36, i64 0
  store i64 %v35, ptr %st18
  %v37.p = getelementptr i64, ptr %v30, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = add i64 0, 26
  %v40 = add i64 0, 0
  %v41.c = icmp slt i64 %v38, %v40
  %v41 = zext i1 %v41.c to i64
  %c.b0 = icmp ne i64 %v41, 0
  br i1 %c.b0, label %b0.t20, label %b0.e21
b0.t20:
  br label %b1
b0.e21:
  br label %b2
b1:
  %v42 = add i64 0, 93
  call void @"rt.panic"(i64 %v42)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v43 = add i64 0, 63
  %v44.c = icmp sgt i64 %v38, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b2 = icmp ne i64 %v44, 0
  br i1 %c.b2, label %b2.t22, label %b2.e23
b2.t22:
  br label %b4
b2.e23:
  br label %b5
b3:
  %v39 = phi i64 [ %v46, %b4 ], [ %v47, %b5 ]
  %v48 = getelementptr i64, ptr %s7, i64 0
  %st23 = getelementptr i64, ptr %v48, i64 0
  store i64 %v39, ptr %st23
  %v49.p = getelementptr i64, ptr %v30, i64 0
  %v49 = load i64, ptr %v49.p
  %v50 = add i64 0, 67108863
  %v51 = and i64 %v49, %v50
  %st24 = getelementptr i64, ptr %v30, i64 0
  store i64 %v51, ptr %st24
  %v52.p = getelementptr i64, ptr %v32, i64 0
  %v52 = load i64, ptr %v52.p
  %v53.p = getelementptr i64, ptr %v48, i64 0
  %v53 = load i64, ptr %v53.p
  %v54 = add i64 %v52, %v53
  %st25 = getelementptr i64, ptr %v32, i64 0
  store i64 %v54, ptr %st25
  %v55.p = getelementptr i64, ptr %v32, i64 0
  %v55 = load i64, ptr %v55.p
  %v56 = add i64 0, 26
  %v58 = add i64 0, 0
  %v59.c = icmp slt i64 %v56, %v58
  %v59 = zext i1 %v59.c to i64
  %c.b3 = icmp ne i64 %v59, 0
  br i1 %c.b3, label %b3.t27, label %b3.e28
b3.t27:
  br label %b6
b3.e28:
  br label %b7
b4:
  %v45 = add i64 0, 63
  %v46.n = and i64 %v45, 63
  %v46 = ashr i64 %v37, %v46.n
  br label %b3
b5:
  %v47.n = and i64 %v38, 63
  %v47 = ashr i64 %v37, %v47.n
  br label %b3
b6:
  %v60 = add i64 0, 94
  call void @"rt.panic"(i64 %v60)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v61 = add i64 0, 63
  %v62.c = icmp sgt i64 %v56, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b7 = icmp ne i64 %v62, 0
  br i1 %c.b7, label %b7.t29, label %b7.e30
b7.t29:
  br label %b9
b7.e30:
  br label %b10
b8:
  %v57 = phi i64 [ %v64, %b9 ], [ %v65, %b10 ]
  %st30 = getelementptr i64, ptr %v48, i64 0
  store i64 %v57, ptr %st30
  %v66.p = getelementptr i64, ptr %v32, i64 0
  %v66 = load i64, ptr %v66.p
  %v67 = add i64 0, 67108863
  %v68 = and i64 %v66, %v67
  %st31 = getelementptr i64, ptr %v32, i64 0
  store i64 %v68, ptr %st31
  %v69.p = getelementptr i64, ptr %v34, i64 0
  %v69 = load i64, ptr %v69.p
  %v70.p = getelementptr i64, ptr %v48, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = add i64 %v69, %v70
  %st32 = getelementptr i64, ptr %v34, i64 0
  store i64 %v71, ptr %st32
  %v72.p = getelementptr i64, ptr %v34, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = add i64 0, 26
  %v75 = add i64 0, 0
  %v76.c = icmp slt i64 %v73, %v75
  %v76 = zext i1 %v76.c to i64
  %c.b8 = icmp ne i64 %v76, 0
  br i1 %c.b8, label %b8.t34, label %b8.e35
b8.t34:
  br label %b11
b8.e35:
  br label %b12
b9:
  %v63 = add i64 0, 63
  %v64.n = and i64 %v63, 63
  %v64 = ashr i64 %v55, %v64.n
  br label %b8
b10:
  %v65.n = and i64 %v56, 63
  %v65 = ashr i64 %v55, %v65.n
  br label %b8
b11:
  %v77 = add i64 0, 95
  call void @"rt.panic"(i64 %v77)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v78 = add i64 0, 63
  %v79.c = icmp sgt i64 %v73, %v78
  %v79 = zext i1 %v79.c to i64
  %c.b12 = icmp ne i64 %v79, 0
  br i1 %c.b12, label %b12.t36, label %b12.e37
b12.t36:
  br label %b14
b12.e37:
  br label %b15
b13:
  %v74 = phi i64 [ %v81, %b14 ], [ %v82, %b15 ]
  %st37 = getelementptr i64, ptr %v48, i64 0
  store i64 %v74, ptr %st37
  %v83.p = getelementptr i64, ptr %v34, i64 0
  %v83 = load i64, ptr %v83.p
  %v84 = add i64 0, 67108863
  %v85 = and i64 %v83, %v84
  %st38 = getelementptr i64, ptr %v34, i64 0
  store i64 %v85, ptr %st38
  %v86.p = getelementptr i64, ptr %v36, i64 0
  %v86 = load i64, ptr %v86.p
  %v87.p = getelementptr i64, ptr %v48, i64 0
  %v87 = load i64, ptr %v87.p
  %v88 = add i64 %v86, %v87
  %st39 = getelementptr i64, ptr %v36, i64 0
  store i64 %v88, ptr %st39
  %v89.p = getelementptr i64, ptr %v36, i64 0
  %v89 = load i64, ptr %v89.p
  %v90 = add i64 0, 26
  %v92 = add i64 0, 0
  %v93.c = icmp slt i64 %v90, %v92
  %v93 = zext i1 %v93.c to i64
  %c.b13 = icmp ne i64 %v93, 0
  br i1 %c.b13, label %b13.t41, label %b13.e42
b13.t41:
  br label %b16
b13.e42:
  br label %b17
b14:
  %v80 = add i64 0, 63
  %v81.n = and i64 %v80, 63
  %v81 = ashr i64 %v72, %v81.n
  br label %b13
b15:
  %v82.n = and i64 %v73, 63
  %v82 = ashr i64 %v72, %v82.n
  br label %b13
b16:
  %v94 = add i64 0, 96
  call void @"rt.panic"(i64 %v94)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v95 = add i64 0, 63
  %v96.c = icmp sgt i64 %v90, %v95
  %v96 = zext i1 %v96.c to i64
  %c.b17 = icmp ne i64 %v96, 0
  br i1 %c.b17, label %b17.t43, label %b17.e44
b17.t43:
  br label %b19
b17.e44:
  br label %b20
b18:
  %v91 = phi i64 [ %v98, %b19 ], [ %v99, %b20 ]
  %st44 = getelementptr i64, ptr %v48, i64 0
  store i64 %v91, ptr %st44
  %v100.p = getelementptr i64, ptr %v36, i64 0
  %v100 = load i64, ptr %v100.p
  %v101 = add i64 0, 67108863
  %v102 = and i64 %v100, %v101
  %st45 = getelementptr i64, ptr %v36, i64 0
  store i64 %v102, ptr %st45
  %v103.p = getelementptr i64, ptr %v28, i64 0
  %v103 = load i64, ptr %v103.p
  %v104.p = getelementptr i64, ptr %v48, i64 0
  %v104 = load i64, ptr %v104.p
  %v105 = add i64 0, 5
  %v106 = mul i64 %v104, %v105
  %v107 = add i64 %v103, %v106
  %st46 = getelementptr i64, ptr %v28, i64 0
  store i64 %v107, ptr %st46
  %v108.p = getelementptr i64, ptr %v28, i64 0
  %v108 = load i64, ptr %v108.p
  %v109 = add i64 0, 26
  %v111 = add i64 0, 0
  %v112.c = icmp slt i64 %v109, %v111
  %v112 = zext i1 %v112.c to i64
  %c.b18 = icmp ne i64 %v112, 0
  br i1 %c.b18, label %b18.t48, label %b18.e49
b18.t48:
  br label %b21
b18.e49:
  br label %b22
b19:
  %v97 = add i64 0, 63
  %v98.n = and i64 %v97, 63
  %v98 = ashr i64 %v89, %v98.n
  br label %b18
b20:
  %v99.n = and i64 %v90, 63
  %v99 = ashr i64 %v89, %v99.n
  br label %b18
b21:
  %v113 = add i64 0, 97
  call void @"rt.panic"(i64 %v113)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b22:
  %v114 = add i64 0, 63
  %v115.c = icmp sgt i64 %v109, %v114
  %v115 = zext i1 %v115.c to i64
  %c.b22 = icmp ne i64 %v115, 0
  br i1 %c.b22, label %b22.t50, label %b22.e51
b22.t50:
  br label %b24
b22.e51:
  br label %b25
b23:
  %v110 = phi i64 [ %v117, %b24 ], [ %v118, %b25 ]
  %st51 = getelementptr i64, ptr %v48, i64 0
  store i64 %v110, ptr %st51
  %v119.p = getelementptr i64, ptr %v28, i64 0
  %v119 = load i64, ptr %v119.p
  %v120 = add i64 0, 67108863
  %v121 = and i64 %v119, %v120
  %st52 = getelementptr i64, ptr %v28, i64 0
  store i64 %v121, ptr %st52
  %v122.p = getelementptr i64, ptr %v30, i64 0
  %v122 = load i64, ptr %v122.p
  %v123.p = getelementptr i64, ptr %v48, i64 0
  %v123 = load i64, ptr %v123.p
  %v124 = add i64 %v122, %v123
  %st53 = getelementptr i64, ptr %v30, i64 0
  store i64 %v124, ptr %st53
  %v125.p = getelementptr i64, ptr %v28, i64 0
  %v125 = load i64, ptr %v125.p
  %v126 = add i64 0, 5
  %v127 = add i64 %v125, %v126
  %v128 = getelementptr i64, ptr %s8, i64 0
  %st54 = getelementptr i64, ptr %v128, i64 0
  store i64 %v127, ptr %st54
  %v129.p = getelementptr i64, ptr %v128, i64 0
  %v129 = load i64, ptr %v129.p
  %v130 = add i64 0, 26
  %v132 = add i64 0, 0
  %v133.c = icmp slt i64 %v130, %v132
  %v133 = zext i1 %v133.c to i64
  %c.b23 = icmp ne i64 %v133, 0
  br i1 %c.b23, label %b23.t56, label %b23.e57
b23.t56:
  br label %b26
b23.e57:
  br label %b27
b24:
  %v116 = add i64 0, 63
  %v117.n = and i64 %v116, 63
  %v117 = ashr i64 %v108, %v117.n
  br label %b23
b25:
  %v118.n = and i64 %v109, 63
  %v118 = ashr i64 %v108, %v118.n
  br label %b23
b26:
  %v134 = add i64 0, 98
  call void @"rt.panic"(i64 %v134)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v135 = add i64 0, 63
  %v136.c = icmp sgt i64 %v130, %v135
  %v136 = zext i1 %v136.c to i64
  %c.b27 = icmp ne i64 %v136, 0
  br i1 %c.b27, label %b27.t58, label %b27.e59
b27.t58:
  br label %b29
b27.e59:
  br label %b30
b28:
  %v131 = phi i64 [ %v138, %b29 ], [ %v139, %b30 ]
  %st59 = getelementptr i64, ptr %v48, i64 0
  store i64 %v131, ptr %st59
  %v140.p = getelementptr i64, ptr %v128, i64 0
  %v140 = load i64, ptr %v140.p
  %v141 = add i64 0, 67108863
  %v142 = and i64 %v140, %v141
  %st60 = getelementptr i64, ptr %v128, i64 0
  store i64 %v142, ptr %st60
  %v143.p = getelementptr i64, ptr %v30, i64 0
  %v143 = load i64, ptr %v143.p
  %v144.p = getelementptr i64, ptr %v48, i64 0
  %v144 = load i64, ptr %v144.p
  %v145 = add i64 %v143, %v144
  %v146 = getelementptr i64, ptr %s9, i64 0
  %st61 = getelementptr i64, ptr %v146, i64 0
  store i64 %v145, ptr %st61
  %v147.p = getelementptr i64, ptr %v146, i64 0
  %v147 = load i64, ptr %v147.p
  %v148 = add i64 0, 26
  %v150 = add i64 0, 0
  %v151.c = icmp slt i64 %v148, %v150
  %v151 = zext i1 %v151.c to i64
  %c.b28 = icmp ne i64 %v151, 0
  br i1 %c.b28, label %b28.t63, label %b28.e64
b28.t63:
  br label %b31
b28.e64:
  br label %b32
b29:
  %v137 = add i64 0, 63
  %v138.n = and i64 %v137, 63
  %v138 = ashr i64 %v129, %v138.n
  br label %b28
b30:
  %v139.n = and i64 %v130, 63
  %v139 = ashr i64 %v129, %v139.n
  br label %b28
b31:
  %v152 = add i64 0, 99
  call void @"rt.panic"(i64 %v152)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v153 = add i64 0, 63
  %v154.c = icmp sgt i64 %v148, %v153
  %v154 = zext i1 %v154.c to i64
  %c.b32 = icmp ne i64 %v154, 0
  br i1 %c.b32, label %b32.t65, label %b32.e66
b32.t65:
  br label %b34
b32.e66:
  br label %b35
b33:
  %v149 = phi i64 [ %v156, %b34 ], [ %v157, %b35 ]
  %st66 = getelementptr i64, ptr %v48, i64 0
  store i64 %v149, ptr %st66
  %v158.p = getelementptr i64, ptr %v146, i64 0
  %v158 = load i64, ptr %v158.p
  %v159 = add i64 0, 67108863
  %v160 = and i64 %v158, %v159
  %st67 = getelementptr i64, ptr %v146, i64 0
  store i64 %v160, ptr %st67
  %v161.p = getelementptr i64, ptr %v32, i64 0
  %v161 = load i64, ptr %v161.p
  %v162.p = getelementptr i64, ptr %v48, i64 0
  %v162 = load i64, ptr %v162.p
  %v163 = add i64 %v161, %v162
  %v164 = getelementptr i64, ptr %s10, i64 0
  %st68 = getelementptr i64, ptr %v164, i64 0
  store i64 %v163, ptr %st68
  %v165.p = getelementptr i64, ptr %v164, i64 0
  %v165 = load i64, ptr %v165.p
  %v166 = add i64 0, 26
  %v168 = add i64 0, 0
  %v169.c = icmp slt i64 %v166, %v168
  %v169 = zext i1 %v169.c to i64
  %c.b33 = icmp ne i64 %v169, 0
  br i1 %c.b33, label %b33.t70, label %b33.e71
b33.t70:
  br label %b36
b33.e71:
  br label %b37
b34:
  %v155 = add i64 0, 63
  %v156.n = and i64 %v155, 63
  %v156 = ashr i64 %v147, %v156.n
  br label %b33
b35:
  %v157.n = and i64 %v148, 63
  %v157 = ashr i64 %v147, %v157.n
  br label %b33
b36:
  %v170 = add i64 0, 100
  call void @"rt.panic"(i64 %v170)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b37:
  %v171 = add i64 0, 63
  %v172.c = icmp sgt i64 %v166, %v171
  %v172 = zext i1 %v172.c to i64
  %c.b37 = icmp ne i64 %v172, 0
  br i1 %c.b37, label %b37.t72, label %b37.e73
b37.t72:
  br label %b39
b37.e73:
  br label %b40
b38:
  %v167 = phi i64 [ %v174, %b39 ], [ %v175, %b40 ]
  %st73 = getelementptr i64, ptr %v48, i64 0
  store i64 %v167, ptr %st73
  %v176.p = getelementptr i64, ptr %v164, i64 0
  %v176 = load i64, ptr %v176.p
  %v177 = add i64 0, 67108863
  %v178 = and i64 %v176, %v177
  %st74 = getelementptr i64, ptr %v164, i64 0
  store i64 %v178, ptr %st74
  %v179.p = getelementptr i64, ptr %v34, i64 0
  %v179 = load i64, ptr %v179.p
  %v180.p = getelementptr i64, ptr %v48, i64 0
  %v180 = load i64, ptr %v180.p
  %v181 = add i64 %v179, %v180
  %v182 = getelementptr i64, ptr %s11, i64 0
  %st75 = getelementptr i64, ptr %v182, i64 0
  store i64 %v181, ptr %st75
  %v183.p = getelementptr i64, ptr %v182, i64 0
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 26
  %v186 = add i64 0, 0
  %v187.c = icmp slt i64 %v184, %v186
  %v187 = zext i1 %v187.c to i64
  %c.b38 = icmp ne i64 %v187, 0
  br i1 %c.b38, label %b38.t77, label %b38.e78
b38.t77:
  br label %b41
b38.e78:
  br label %b42
b39:
  %v173 = add i64 0, 63
  %v174.n = and i64 %v173, 63
  %v174 = ashr i64 %v165, %v174.n
  br label %b38
b40:
  %v175.n = and i64 %v166, 63
  %v175 = ashr i64 %v165, %v175.n
  br label %b38
b41:
  %v188 = add i64 0, 101
  call void @"rt.panic"(i64 %v188)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b42:
  %v189 = add i64 0, 63
  %v190.c = icmp sgt i64 %v184, %v189
  %v190 = zext i1 %v190.c to i64
  %c.b42 = icmp ne i64 %v190, 0
  br i1 %c.b42, label %b42.t79, label %b42.e80
b42.t79:
  br label %b44
b42.e80:
  br label %b45
b43:
  %v185 = phi i64 [ %v192, %b44 ], [ %v193, %b45 ]
  %st80 = getelementptr i64, ptr %v48, i64 0
  store i64 %v185, ptr %st80
  %v194.p = getelementptr i64, ptr %v182, i64 0
  %v194 = load i64, ptr %v194.p
  %v195 = add i64 0, 67108863
  %v196 = and i64 %v194, %v195
  %st81 = getelementptr i64, ptr %v182, i64 0
  store i64 %v196, ptr %st81
  %v197.p = getelementptr i64, ptr %v36, i64 0
  %v197 = load i64, ptr %v197.p
  %v198.p = getelementptr i64, ptr %v48, i64 0
  %v198 = load i64, ptr %v198.p
  %v199 = add i64 %v197, %v198
  %v200 = add i64 0, 1
  %v201 = add i64 0, 26
  %v203 = add i64 0, 0
  %v204.c = icmp slt i64 %v201, %v203
  %v204 = zext i1 %v204.c to i64
  %c.b43 = icmp ne i64 %v204, 0
  br i1 %c.b43, label %b43.t83, label %b43.e84
b43.t83:
  br label %b46
b43.e84:
  br label %b47
b44:
  %v191 = add i64 0, 63
  %v192.n = and i64 %v191, 63
  %v192 = ashr i64 %v183, %v192.n
  br label %b43
b45:
  %v193.n = and i64 %v184, 63
  %v193 = ashr i64 %v183, %v193.n
  br label %b43
b46:
  %v205 = add i64 0, 102
  call void @"rt.panic"(i64 %v205)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b47:
  %v206 = add i64 0, 63
  %v207.c = icmp sgt i64 %v201, %v206
  %v207 = zext i1 %v207.c to i64
  %c.b47 = icmp ne i64 %v207, 0
  br i1 %c.b47, label %b47.t85, label %b47.e86
b47.t85:
  br label %b49
b47.e86:
  br label %b50
b48:
  %v202 = phi i64 [ %v208, %b49 ], [ %v209, %b50 ]
  %v210 = sub i64 %v199, %v202
  %v211 = add i64 0, 63
  %v213 = add i64 0, 0
  %v214.c = icmp slt i64 %v211, %v213
  %v214 = zext i1 %v214.c to i64
  %c.b48 = icmp ne i64 %v214, 0
  br i1 %c.b48, label %b48.t87, label %b48.e88
b48.t87:
  br label %b51
b48.e88:
  br label %b52
b49:
  %v208 = add i64 0, 0
  br label %b48
b50:
  %v209.n = and i64 %v201, 63
  %v209 = shl i64 %v200, %v209.n
  br label %b48
b51:
  %v215 = add i64 0, 103
  call void @"rt.panic"(i64 %v215)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b52:
  %v216 = add i64 0, 63
  %v217.c = icmp sgt i64 %v211, %v216
  %v217 = zext i1 %v217.c to i64
  %c.b52 = icmp ne i64 %v217, 0
  br i1 %c.b52, label %b52.t89, label %b52.e90
b52.t89:
  br label %b54
b52.e90:
  br label %b55
b53:
  %v212 = phi i64 [ %v219, %b54 ], [ %v220, %b55 ]
  %v221.p = getelementptr i64, ptr %v28, i64 0
  %v221 = load i64, ptr %v221.p
  %v222 = and i64 %v221, %v212
  %v223.p = getelementptr i64, ptr %v128, i64 0
  %v223 = load i64, ptr %v223.p
  %v224 = add i64 0, -1
  %v225 = xor i64 %v212, %v224
  %v226 = and i64 %v223, %v225
  %v227 = or i64 %v222, %v226
  %st90 = getelementptr i64, ptr %v28, i64 0
  store i64 %v227, ptr %st90
  %v228.p = getelementptr i64, ptr %v30, i64 0
  %v228 = load i64, ptr %v228.p
  %v229 = and i64 %v228, %v212
  %v230.p = getelementptr i64, ptr %v146, i64 0
  %v230 = load i64, ptr %v230.p
  %v231 = add i64 0, -1
  %v232 = xor i64 %v212, %v231
  %v233 = and i64 %v230, %v232
  %v234 = or i64 %v229, %v233
  %st91 = getelementptr i64, ptr %v30, i64 0
  store i64 %v234, ptr %st91
  %v235.p = getelementptr i64, ptr %v32, i64 0
  %v235 = load i64, ptr %v235.p
  %v236 = and i64 %v235, %v212
  %v237.p = getelementptr i64, ptr %v164, i64 0
  %v237 = load i64, ptr %v237.p
  %v238 = add i64 0, -1
  %v239 = xor i64 %v212, %v238
  %v240 = and i64 %v237, %v239
  %v241 = or i64 %v236, %v240
  %st92 = getelementptr i64, ptr %v32, i64 0
  store i64 %v241, ptr %st92
  %v242.p = getelementptr i64, ptr %v34, i64 0
  %v242 = load i64, ptr %v242.p
  %v243 = and i64 %v242, %v212
  %v244.p = getelementptr i64, ptr %v182, i64 0
  %v244 = load i64, ptr %v244.p
  %v245 = add i64 0, -1
  %v246 = xor i64 %v212, %v245
  %v247 = and i64 %v244, %v246
  %v248 = or i64 %v243, %v247
  %st93 = getelementptr i64, ptr %v34, i64 0
  store i64 %v248, ptr %st93
  %v249.p = getelementptr i64, ptr %v36, i64 0
  %v249 = load i64, ptr %v249.p
  %v250 = and i64 %v249, %v212
  %v251 = add i64 0, 67108863
  %v252 = and i64 %v210, %v251
  %v253 = add i64 0, -1
  %v254 = xor i64 %v212, %v253
  %v255 = and i64 %v252, %v254
  %v256 = or i64 %v250, %v255
  %st94 = getelementptr i64, ptr %v36, i64 0
  store i64 %v256, ptr %st94
  %v257.p = getelementptr i64, ptr %v28, i64 0
  %v257 = load i64, ptr %v257.p
  %v258.p = getelementptr i64, ptr %v30, i64 0
  %v258 = load i64, ptr %v258.p
  %v259 = add i64 0, 26
  %v261 = add i64 0, 0
  %v262.c = icmp slt i64 %v259, %v261
  %v262 = zext i1 %v262.c to i64
  %c.b53 = icmp ne i64 %v262, 0
  br i1 %c.b53, label %b53.t96, label %b53.e97
b53.t96:
  br label %b56
b53.e97:
  br label %b57
b54:
  %v218 = add i64 0, 63
  %v219.n = and i64 %v218, 63
  %v219 = ashr i64 %v210, %v219.n
  br label %b53
b55:
  %v220.n = and i64 %v211, 63
  %v220 = ashr i64 %v210, %v220.n
  br label %b53
b56:
  %v263 = add i64 0, 104
  call void @"rt.panic"(i64 %v263)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b57:
  %v264 = add i64 0, 63
  %v265.c = icmp sgt i64 %v259, %v264
  %v265 = zext i1 %v265.c to i64
  %c.b57 = icmp ne i64 %v265, 0
  br i1 %c.b57, label %b57.t98, label %b57.e99
b57.t98:
  br label %b59
b57.e99:
  br label %b60
b58:
  %v260 = phi i64 [ %v266, %b59 ], [ %v267, %b60 ]
  %v268 = or i64 %v257, %v260
  %v269 = add i64 0, 4294967295
  %v270 = and i64 %v268, %v269
  %v271.p = getelementptr i64, ptr %v30, i64 0
  %v271 = load i64, ptr %v271.p
  %v272 = add i64 0, 6
  %v274 = add i64 0, 0
  %v275.c = icmp slt i64 %v272, %v274
  %v275 = zext i1 %v275.c to i64
  %c.b58 = icmp ne i64 %v275, 0
  br i1 %c.b58, label %b58.t100, label %b58.e101
b58.t100:
  br label %b61
b58.e101:
  br label %b62
b59:
  %v266 = add i64 0, 0
  br label %b58
b60:
  %v267.n = and i64 %v259, 63
  %v267 = shl i64 %v258, %v267.n
  br label %b58
b61:
  %v276 = add i64 0, 105
  call void @"rt.panic"(i64 %v276)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b62:
  %v277 = add i64 0, 63
  %v278.c = icmp sgt i64 %v272, %v277
  %v278 = zext i1 %v278.c to i64
  %c.b62 = icmp ne i64 %v278, 0
  br i1 %c.b62, label %b62.t102, label %b62.e103
b62.t102:
  br label %b64
b62.e103:
  br label %b65
b63:
  %v273 = phi i64 [ %v280, %b64 ], [ %v281, %b65 ]
  %v282.p = getelementptr i64, ptr %v32, i64 0
  %v282 = load i64, ptr %v282.p
  %v283 = add i64 0, 20
  %v285 = add i64 0, 0
  %v286.c = icmp slt i64 %v283, %v285
  %v286 = zext i1 %v286.c to i64
  %c.b63 = icmp ne i64 %v286, 0
  br i1 %c.b63, label %b63.t104, label %b63.e105
b63.t104:
  br label %b66
b63.e105:
  br label %b67
b64:
  %v279 = add i64 0, 63
  %v280.n = and i64 %v279, 63
  %v280 = ashr i64 %v271, %v280.n
  br label %b63
b65:
  %v281.n = and i64 %v272, 63
  %v281 = ashr i64 %v271, %v281.n
  br label %b63
b66:
  %v287 = add i64 0, 106
  call void @"rt.panic"(i64 %v287)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b67:
  %v288 = add i64 0, 63
  %v289.c = icmp sgt i64 %v283, %v288
  %v289 = zext i1 %v289.c to i64
  %c.b67 = icmp ne i64 %v289, 0
  br i1 %c.b67, label %b67.t106, label %b67.e107
b67.t106:
  br label %b69
b67.e107:
  br label %b70
b68:
  %v284 = phi i64 [ %v290, %b69 ], [ %v291, %b70 ]
  %v292 = or i64 %v273, %v284
  %v293 = add i64 0, 4294967295
  %v294 = and i64 %v292, %v293
  %v295.p = getelementptr i64, ptr %v32, i64 0
  %v295 = load i64, ptr %v295.p
  %v296 = add i64 0, 12
  %v298 = add i64 0, 0
  %v299.c = icmp slt i64 %v296, %v298
  %v299 = zext i1 %v299.c to i64
  %c.b68 = icmp ne i64 %v299, 0
  br i1 %c.b68, label %b68.t108, label %b68.e109
b68.t108:
  br label %b71
b68.e109:
  br label %b72
b69:
  %v290 = add i64 0, 0
  br label %b68
b70:
  %v291.n = and i64 %v283, 63
  %v291 = shl i64 %v282, %v291.n
  br label %b68
b71:
  %v300 = add i64 0, 107
  call void @"rt.panic"(i64 %v300)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b72:
  %v301 = add i64 0, 63
  %v302.c = icmp sgt i64 %v296, %v301
  %v302 = zext i1 %v302.c to i64
  %c.b72 = icmp ne i64 %v302, 0
  br i1 %c.b72, label %b72.t110, label %b72.e111
b72.t110:
  br label %b74
b72.e111:
  br label %b75
b73:
  %v297 = phi i64 [ %v304, %b74 ], [ %v305, %b75 ]
  %v306.p = getelementptr i64, ptr %v34, i64 0
  %v306 = load i64, ptr %v306.p
  %v307 = add i64 0, 14
  %v309 = add i64 0, 0
  %v310.c = icmp slt i64 %v307, %v309
  %v310 = zext i1 %v310.c to i64
  %c.b73 = icmp ne i64 %v310, 0
  br i1 %c.b73, label %b73.t112, label %b73.e113
b73.t112:
  br label %b76
b73.e113:
  br label %b77
b74:
  %v303 = add i64 0, 63
  %v304.n = and i64 %v303, 63
  %v304 = ashr i64 %v295, %v304.n
  br label %b73
b75:
  %v305.n = and i64 %v296, 63
  %v305 = ashr i64 %v295, %v305.n
  br label %b73
b76:
  %v311 = add i64 0, 108
  call void @"rt.panic"(i64 %v311)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b77:
  %v312 = add i64 0, 63
  %v313.c = icmp sgt i64 %v307, %v312
  %v313 = zext i1 %v313.c to i64
  %c.b77 = icmp ne i64 %v313, 0
  br i1 %c.b77, label %b77.t114, label %b77.e115
b77.t114:
  br label %b79
b77.e115:
  br label %b80
b78:
  %v308 = phi i64 [ %v314, %b79 ], [ %v315, %b80 ]
  %v316 = or i64 %v297, %v308
  %v317 = add i64 0, 4294967295
  %v318 = and i64 %v316, %v317
  %v319.p = getelementptr i64, ptr %v34, i64 0
  %v319 = load i64, ptr %v319.p
  %v320 = add i64 0, 18
  %v322 = add i64 0, 0
  %v323.c = icmp slt i64 %v320, %v322
  %v323 = zext i1 %v323.c to i64
  %c.b78 = icmp ne i64 %v323, 0
  br i1 %c.b78, label %b78.t116, label %b78.e117
b78.t116:
  br label %b81
b78.e117:
  br label %b82
b79:
  %v314 = add i64 0, 0
  br label %b78
b80:
  %v315.n = and i64 %v307, 63
  %v315 = shl i64 %v306, %v315.n
  br label %b78
b81:
  %v324 = add i64 0, 109
  call void @"rt.panic"(i64 %v324)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b82:
  %v325 = add i64 0, 63
  %v326.c = icmp sgt i64 %v320, %v325
  %v326 = zext i1 %v326.c to i64
  %c.b82 = icmp ne i64 %v326, 0
  br i1 %c.b82, label %b82.t118, label %b82.e119
b82.t118:
  br label %b84
b82.e119:
  br label %b85
b83:
  %v321 = phi i64 [ %v328, %b84 ], [ %v329, %b85 ]
  %v330.p = getelementptr i64, ptr %v36, i64 0
  %v330 = load i64, ptr %v330.p
  %v331 = add i64 0, 8
  %v333 = add i64 0, 0
  %v334.c = icmp slt i64 %v331, %v333
  %v334 = zext i1 %v334.c to i64
  %c.b83 = icmp ne i64 %v334, 0
  br i1 %c.b83, label %b83.t120, label %b83.e121
b83.t120:
  br label %b86
b83.e121:
  br label %b87
b84:
  %v327 = add i64 0, 63
  %v328.n = and i64 %v327, 63
  %v328 = ashr i64 %v319, %v328.n
  br label %b83
b85:
  %v329.n = and i64 %v320, 63
  %v329 = ashr i64 %v319, %v329.n
  br label %b83
b86:
  %v335 = add i64 0, 110
  call void @"rt.panic"(i64 %v335)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b87:
  %v336 = add i64 0, 63
  %v337.c = icmp sgt i64 %v331, %v336
  %v337 = zext i1 %v337.c to i64
  %c.b87 = icmp ne i64 %v337, 0
  br i1 %c.b87, label %b87.t122, label %b87.e123
b87.t122:
  br label %b89
b87.e123:
  br label %b90
b88:
  %v332 = phi i64 [ %v338, %b89 ], [ %v339, %b90 ]
  %v340 = or i64 %v321, %v332
  %v341 = add i64 0, 4294967295
  %v342 = and i64 %v340, %v341
  %v343.p = getelementptr i64, ptr %v15, i64 0
  %v343 = load i64, ptr %v343.p
  %v344.p = getelementptr i64, ptr %v15, i64 1
  %v344 = load i64, ptr %v344.p
  %v345.p = getelementptr i64, ptr %v15, i64 2
  %v345 = load i64, ptr %v345.p
  %v346 = add i64 0, 16
  %v347 = call i64 @"std/crypto/poly1305.le32"(i64 %v343, i64 %v344, i64 %v345, i64 %v346)
  %v348 = add i64 %v270, %v347
  %v349 = getelementptr i64, ptr %s12, i64 0
  %st123 = getelementptr i64, ptr %v349, i64 0
  store i64 %v348, ptr %st123
  %v350 = add i64 0, 0
  %v351 = call ptr @"rt.region_alloc8"(i64 %v26, i64 %v350)
  %v352 = add i64 0, 0
  %v353 = getelementptr i64, ptr %s13, i64 0
  %v354 = ptrtoint ptr %v351 to i64
  %st124 = getelementptr i64, ptr %v353, i64 0
  store i64 %v354, ptr %st124
  %st125 = getelementptr i64, ptr %v353, i64 1
  store i64 %v352, ptr %st125
  %st126 = getelementptr i64, ptr %v353, i64 2
  store i64 %v26, ptr %st126
  %v355 = getelementptr i64, ptr %s14, i64 0
  %v356.p = getelementptr i64, ptr %v353, i64 0
  %v356 = load i64, ptr %v356.p
  %st127 = getelementptr i64, ptr %v355, i64 0
  store i64 %v356, ptr %st127
  %v357.p = getelementptr i64, ptr %v353, i64 1
  %v357 = load i64, ptr %v357.p
  %st128 = getelementptr i64, ptr %v355, i64 1
  store i64 %v357, ptr %st128
  %v358.p = getelementptr i64, ptr %v353, i64 2
  %v358 = load i64, ptr %v358.p
  %st129 = getelementptr i64, ptr %v355, i64 2
  store i64 %v358, ptr %st129
  %v359 = add i64 0, 1
  %v360 = add i64 %v16, %v359
  %v361.p = getelementptr i64, ptr %v349, i64 0
  %v361 = load i64, ptr %v361.p
  %v362 = add i64 0, 4294967295
  %v363 = and i64 %v361, %v362
  %v364 = getelementptr i64, ptr @"rt.meta", i64 0
  %st130 = getelementptr i64, ptr %v364, i64 2572
  store i64 %v360, ptr %st130
  call void @"std/crypto/poly1305.put32"(ptr %v355, i64 %v363)
  %v365.p = getelementptr i64, ptr %v15, i64 0
  %v365 = load i64, ptr %v365.p
  %v366.p = getelementptr i64, ptr %v15, i64 1
  %v366 = load i64, ptr %v366.p
  %v367.p = getelementptr i64, ptr %v15, i64 2
  %v367 = load i64, ptr %v367.p
  %v368 = add i64 0, 20
  %v369 = call i64 @"std/crypto/poly1305.le32"(i64 %v365, i64 %v366, i64 %v367, i64 %v368)
  %v370 = add i64 %v294, %v369
  %v371.p = getelementptr i64, ptr %v349, i64 0
  %v371 = load i64, ptr %v371.p
  %v372 = add i64 0, 32
  %v374 = add i64 0, 0
  %v375.c = icmp slt i64 %v372, %v374
  %v375 = zext i1 %v375.c to i64
  %c.b88 = icmp ne i64 %v375, 0
  br i1 %c.b88, label %b88.t132, label %b88.e133
b88.t132:
  br label %b91
b88.e133:
  br label %b92
b89:
  %v338 = add i64 0, 0
  br label %b88
b90:
  %v339.n = and i64 %v331, 63
  %v339 = shl i64 %v330, %v339.n
  br label %b88
b91:
  %v376 = add i64 0, 111
  call void @"rt.panic"(i64 %v376)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b92:
  %v377 = add i64 0, 63
  %v378.c = icmp sgt i64 %v372, %v377
  %v378 = zext i1 %v378.c to i64
  %c.b92 = icmp ne i64 %v378, 0
  br i1 %c.b92, label %b92.t134, label %b92.e135
b92.t134:
  br label %b94
b92.e135:
  br label %b95
b93:
  %v373 = phi i64 [ %v380, %b94 ], [ %v381, %b95 ]
  %v382 = add i64 %v370, %v373
  %st135 = getelementptr i64, ptr %v349, i64 0
  store i64 %v382, ptr %st135
  %v383 = add i64 0, 1
  %v384 = add i64 %v16, %v383
  %v385.p = getelementptr i64, ptr %v349, i64 0
  %v385 = load i64, ptr %v385.p
  %v386 = add i64 0, 4294967295
  %v387 = and i64 %v385, %v386
  %v388 = getelementptr i64, ptr @"rt.meta", i64 0
  %st136 = getelementptr i64, ptr %v388, i64 2572
  store i64 %v384, ptr %st136
  call void @"std/crypto/poly1305.put32"(ptr %v355, i64 %v387)
  %v389.p = getelementptr i64, ptr %v15, i64 0
  %v389 = load i64, ptr %v389.p
  %v390.p = getelementptr i64, ptr %v15, i64 1
  %v390 = load i64, ptr %v390.p
  %v391.p = getelementptr i64, ptr %v15, i64 2
  %v391 = load i64, ptr %v391.p
  %v392 = add i64 0, 24
  %v393 = call i64 @"std/crypto/poly1305.le32"(i64 %v389, i64 %v390, i64 %v391, i64 %v392)
  %v394 = add i64 %v318, %v393
  %v395.p = getelementptr i64, ptr %v349, i64 0
  %v395 = load i64, ptr %v395.p
  %v396 = add i64 0, 32
  %v398 = add i64 0, 0
  %v399.c = icmp slt i64 %v396, %v398
  %v399 = zext i1 %v399.c to i64
  %c.b93 = icmp ne i64 %v399, 0
  br i1 %c.b93, label %b93.t138, label %b93.e139
b93.t138:
  br label %b96
b93.e139:
  br label %b97
b94:
  %v379 = add i64 0, 63
  %v380.n = and i64 %v379, 63
  %v380 = ashr i64 %v371, %v380.n
  br label %b93
b95:
  %v381.n = and i64 %v372, 63
  %v381 = ashr i64 %v371, %v381.n
  br label %b93
b96:
  %v400 = add i64 0, 112
  call void @"rt.panic"(i64 %v400)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b97:
  %v401 = add i64 0, 63
  %v402.c = icmp sgt i64 %v396, %v401
  %v402 = zext i1 %v402.c to i64
  %c.b97 = icmp ne i64 %v402, 0
  br i1 %c.b97, label %b97.t140, label %b97.e141
b97.t140:
  br label %b99
b97.e141:
  br label %b100
b98:
  %v397 = phi i64 [ %v404, %b99 ], [ %v405, %b100 ]
  %v406 = add i64 %v394, %v397
  %st141 = getelementptr i64, ptr %v349, i64 0
  store i64 %v406, ptr %st141
  %v407 = add i64 0, 1
  %v408 = add i64 %v16, %v407
  %v409.p = getelementptr i64, ptr %v349, i64 0
  %v409 = load i64, ptr %v409.p
  %v410 = add i64 0, 4294967295
  %v411 = and i64 %v409, %v410
  %v412 = getelementptr i64, ptr @"rt.meta", i64 0
  %st142 = getelementptr i64, ptr %v412, i64 2572
  store i64 %v408, ptr %st142
  call void @"std/crypto/poly1305.put32"(ptr %v355, i64 %v411)
  %v413.p = getelementptr i64, ptr %v15, i64 0
  %v413 = load i64, ptr %v413.p
  %v414.p = getelementptr i64, ptr %v15, i64 1
  %v414 = load i64, ptr %v414.p
  %v415.p = getelementptr i64, ptr %v15, i64 2
  %v415 = load i64, ptr %v415.p
  %v416 = add i64 0, 28
  %v417 = call i64 @"std/crypto/poly1305.le32"(i64 %v413, i64 %v414, i64 %v415, i64 %v416)
  %v418 = add i64 %v342, %v417
  %v419.p = getelementptr i64, ptr %v349, i64 0
  %v419 = load i64, ptr %v419.p
  %v420 = add i64 0, 32
  %v422 = add i64 0, 0
  %v423.c = icmp slt i64 %v420, %v422
  %v423 = zext i1 %v423.c to i64
  %c.b98 = icmp ne i64 %v423, 0
  br i1 %c.b98, label %b98.t144, label %b98.e145
b98.t144:
  br label %b101
b98.e145:
  br label %b102
b99:
  %v403 = add i64 0, 63
  %v404.n = and i64 %v403, 63
  %v404 = ashr i64 %v395, %v404.n
  br label %b98
b100:
  %v405.n = and i64 %v396, 63
  %v405 = ashr i64 %v395, %v405.n
  br label %b98
b101:
  %v424 = add i64 0, 113
  call void @"rt.panic"(i64 %v424)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b102:
  %v425 = add i64 0, 63
  %v426.c = icmp sgt i64 %v420, %v425
  %v426 = zext i1 %v426.c to i64
  %c.b102 = icmp ne i64 %v426, 0
  br i1 %c.b102, label %b102.t146, label %b102.e147
b102.t146:
  br label %b104
b102.e147:
  br label %b105
b103:
  %v421 = phi i64 [ %v428, %b104 ], [ %v429, %b105 ]
  %v430 = add i64 %v418, %v421
  %st147 = getelementptr i64, ptr %v349, i64 0
  store i64 %v430, ptr %st147
  %v431 = add i64 0, 1
  %v432 = add i64 %v16, %v431
  %v433.p = getelementptr i64, ptr %v349, i64 0
  %v433 = load i64, ptr %v433.p
  %v434 = add i64 0, 4294967295
  %v435 = and i64 %v433, %v434
  %v436 = getelementptr i64, ptr @"rt.meta", i64 0
  %st148 = getelementptr i64, ptr %v436, i64 2572
  store i64 %v432, ptr %st148
  call void @"std/crypto/poly1305.put32"(ptr %v355, i64 %v435)
  %v437.p = getelementptr i64, ptr %v355, i64 0
  %v437 = load i64, ptr %v437.p
  %st149 = getelementptr i64, ptr %v0, i64 0
  store i64 %v437, ptr %st149
  %v438.p = getelementptr i64, ptr %v355, i64 1
  %v438 = load i64, ptr %v438.p
  %st150 = getelementptr i64, ptr %v0, i64 1
  store i64 %v438, ptr %st150
  %v439.p = getelementptr i64, ptr %v355, i64 2
  %v439 = load i64, ptr %v439.p
  %st151 = getelementptr i64, ptr %v0, i64 2
  store i64 %v439, ptr %st151
  call void @"rt.region_relocate8"(ptr %v0, i64 %v16)
  %v441 = getelementptr i64, ptr @"rt.meta", i64 0
  %st152 = getelementptr i64, ptr %v441, i64 0
  store i64 %v16, ptr %st152
  ret void
b104:
  %v427 = add i64 0, 63
  %v428.n = and i64 %v427, 63
  %v428 = ashr i64 %v419, %v428.n
  br label %b103
b105:
  %v429.n = and i64 %v420, 63
  %v429 = ashr i64 %v419, %v429.n
  br label %b103
}

define internal i64 @"std/crypto/poly1305.le32"(i64 %v0, i64 %v1, i64 %v2, i64 %v3) #0 {
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
  %v70 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v70, i64 0
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
  %v8 = add i64 0, 114
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
  %v13 = add i64 0, 1
  %v14 = add i64 %v3, %v13
  %v15.p = getelementptr i64, ptr %v4, i64 1
  %v15 = load i64, ptr %v15.p
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b2 = icmp ne i64 %v16, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b3
b2.e7:
  br label %b4
b3:
  %v17 = add i64 0, 115
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
  %v22 = add i64 0, 8
  %v24 = add i64 0, 0
  %v25.c = icmp slt i64 %v22, %v24
  %v25 = zext i1 %v25.c to i64
  %c.b4 = icmp ne i64 %v25, 0
  br i1 %c.b4, label %b4.t8, label %b4.e9
b4.t8:
  br label %b5
b4.e9:
  br label %b6
b5:
  %v26 = add i64 0, 116
  call void @"rt.panic"(i64 %v26)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b6:
  %v27 = add i64 0, 63
  %v28.c = icmp sgt i64 %v22, %v27
  %v28 = zext i1 %v28.c to i64
  %c.b6 = icmp ne i64 %v28, 0
  br i1 %c.b6, label %b6.t10, label %b6.e11
b6.t10:
  br label %b8
b6.e11:
  br label %b9
b7:
  %v23 = phi i64 [ %v29, %b8 ], [ %v30, %b9 ]
  %v31 = or i64 %v12, %v23
  %v32 = add i64 0, 2
  %v33 = add i64 %v3, %v32
  %v34.p = getelementptr i64, ptr %v4, i64 1
  %v34 = load i64, ptr %v34.p
  %v35.c = icmp uge i64 %v33, %v34
  %v35 = zext i1 %v35.c to i64
  %c.b7 = icmp ne i64 %v35, 0
  br i1 %c.b7, label %b7.t12, label %b7.e13
b7.t12:
  br label %b10
b7.e13:
  br label %b11
b8:
  %v29 = add i64 0, 0
  br label %b7
b9:
  %v30.n = and i64 %v22, 63
  %v30 = shl i64 %v21, %v30.n
  br label %b7
b10:
  %v36 = add i64 0, 117
  call void @"rt.panic"(i64 %v36)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b11:
  %v37.p = getelementptr i64, ptr %v4, i64 0
  %v37 = load i64, ptr %v37.p
  %v38 = inttoptr i64 %v37 to ptr
  %v39 = getelementptr i8, ptr %v38, i64 %v33
  %v40.p = getelementptr i8, ptr %v39, i64 0
  %v40.b = load i8, ptr %v40.p
  %v40 = zext i8 %v40.b to i64
  %v41 = add i64 0, 16
  %v43 = add i64 0, 0
  %v44.c = icmp slt i64 %v41, %v43
  %v44 = zext i1 %v44.c to i64
  %c.b11 = icmp ne i64 %v44, 0
  br i1 %c.b11, label %b11.t14, label %b11.e15
b11.t14:
  br label %b12
b11.e15:
  br label %b13
b12:
  %v45 = add i64 0, 118
  call void @"rt.panic"(i64 %v45)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b13:
  %v46 = add i64 0, 63
  %v47.c = icmp sgt i64 %v41, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b13 = icmp ne i64 %v47, 0
  br i1 %c.b13, label %b13.t16, label %b13.e17
b13.t16:
  br label %b15
b13.e17:
  br label %b16
b14:
  %v42 = phi i64 [ %v48, %b15 ], [ %v49, %b16 ]
  %v50 = or i64 %v31, %v42
  %v51 = add i64 0, 3
  %v52 = add i64 %v3, %v51
  %v53.p = getelementptr i64, ptr %v4, i64 1
  %v53 = load i64, ptr %v53.p
  %v54.c = icmp uge i64 %v52, %v53
  %v54 = zext i1 %v54.c to i64
  %c.b14 = icmp ne i64 %v54, 0
  br i1 %c.b14, label %b14.t18, label %b14.e19
b14.t18:
  br label %b17
b14.e19:
  br label %b18
b15:
  %v48 = add i64 0, 0
  br label %b14
b16:
  %v49.n = and i64 %v41, 63
  %v49 = shl i64 %v40, %v49.n
  br label %b14
b17:
  %v55 = add i64 0, 119
  call void @"rt.panic"(i64 %v55)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b18:
  %v56.p = getelementptr i64, ptr %v4, i64 0
  %v56 = load i64, ptr %v56.p
  %v57 = inttoptr i64 %v56 to ptr
  %v58 = getelementptr i8, ptr %v57, i64 %v52
  %v59.p = getelementptr i8, ptr %v58, i64 0
  %v59.b = load i8, ptr %v59.p
  %v59 = zext i8 %v59.b to i64
  %v60 = add i64 0, 24
  %v62 = add i64 0, 0
  %v63.c = icmp slt i64 %v60, %v62
  %v63 = zext i1 %v63.c to i64
  %c.b18 = icmp ne i64 %v63, 0
  br i1 %c.b18, label %b18.t20, label %b18.e21
b18.t20:
  br label %b19
b18.e21:
  br label %b20
b19:
  %v64 = add i64 0, 120
  call void @"rt.panic"(i64 %v64)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v65 = add i64 0, 63
  %v66.c = icmp sgt i64 %v60, %v65
  %v66 = zext i1 %v66.c to i64
  %c.b20 = icmp ne i64 %v66, 0
  br i1 %c.b20, label %b20.t22, label %b20.e23
b20.t22:
  br label %b22
b20.e23:
  br label %b23
b21:
  %v61 = phi i64 [ %v67, %b22 ], [ %v68, %b23 ]
  %v69 = or i64 %v50, %v61
  %v71 = getelementptr i64, ptr @"rt.meta", i64 0
  %st23 = getelementptr i64, ptr %v71, i64 0
  store i64 %v5, ptr %st23
  ret i64 %v69
b22:
  %v67 = add i64 0, 0
  br label %b21
b23:
  %v68.n = and i64 %v60, 63
  %v68 = shl i64 %v59, %v68.n
  br label %b21
}

define internal void @"std/crypto/poly1305.put32"(ptr %v0, i64 %v1) #0 {
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
  %v163 = getelementptr i64, ptr @"rt.meta", i64 0
  %v2.p = getelementptr i64, ptr %v163, i64 0
  %v2 = load i64, ptr %v2.p
  %v3 = getelementptr i64, ptr @"rt.meta", i64 0
  %v4.p = getelementptr i64, ptr %v3, i64 2572
  %v4 = load i64, ptr %v4.p
  %v5 = add i64 0, 0
  %v6.c = icmp eq i64 %v4, %v5
  %v6 = zext i1 %v6.c to i64
  %v7 = mul i64 %v6, %v2
  %v8 = add i64 %v4, %v7
  %v9 = getelementptr i64, ptr %s0, i64 0
  %v10.p = getelementptr i64, ptr %v0, i64 0
  %v10 = load i64, ptr %v10.p
  %st0 = getelementptr i64, ptr %v9, i64 0
  store i64 %v10, ptr %st0
  %v11.p = getelementptr i64, ptr %v0, i64 1
  %v11 = load i64, ptr %v11.p
  %st1 = getelementptr i64, ptr %v9, i64 1
  store i64 %v11, ptr %st1
  %v12.p = getelementptr i64, ptr %v0, i64 2
  %v12 = load i64, ptr %v12.p
  %st2 = getelementptr i64, ptr %v9, i64 2
  store i64 %v12, ptr %st2
  %v13 = add i64 0, 255
  %v14 = and i64 %v1, %v13
  %v15 = add i64 0, 256
  %v16.c = icmp uge i64 %v14, %v15
  %v16 = zext i1 %v16.c to i64
  %c.b0 = icmp ne i64 %v16, 0
  br i1 %c.b0, label %b0.t4, label %b0.e5
b0.t4:
  br label %b1
b0.e5:
  br label %b2
b1:
  %v17 = add i64 0, 121
  call void @"rt.panic"(i64 %v17)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b2:
  %v18.p = getelementptr i64, ptr %v9, i64 2
  %v18 = load i64, ptr %v18.p
  %v19.p = getelementptr i64, ptr %v9, i64 0
  %v19 = load i64, ptr %v19.p
  %v20.p = getelementptr i64, ptr %v9, i64 1
  %v20 = load i64, ptr %v20.p
  %v23 = add i64 %v19, %v20
  %v24 = call i64 @"rt.tip8"(i64 %v18, i64 %v23)
  %v25 = add i64 0, 0
  %v26.c = icmp ne i64 %v24, %v25
  %v26 = zext i1 %v26.c to i64
  %c.b2 = icmp ne i64 %v26, 0
  br i1 %c.b2, label %b2.t6, label %b2.e7
b2.t6:
  br label %b5
b2.e7:
  br label %b4
b3:
  %v21 = phi ptr [ %v30, %b4 ], [ %v27, %b5 ]
  %v22 = phi ptr [ %v31, %b4 ], [ %v28, %b5 ]
  %st7 = getelementptr i8, ptr %v22, i64 0
  %st7.b = trunc i64 %v14 to i8
  store i8 %st7.b, ptr %st7
  %v32.p = getelementptr i64, ptr %v9, i64 1
  %v32 = load i64, ptr %v32.p
  %v33 = add i64 0, 1
  %v34 = add i64 %v32, %v33
  %v35 = getelementptr i64, ptr %s1, i64 0
  %v36 = ptrtoint ptr %v21 to i64
  %st8 = getelementptr i64, ptr %v35, i64 0
  store i64 %v36, ptr %st8
  %st9 = getelementptr i64, ptr %v35, i64 1
  store i64 %v34, ptr %st9
  %st10 = getelementptr i64, ptr %v35, i64 2
  store i64 %v18, ptr %st10
  %v37.p = getelementptr i64, ptr %v35, i64 0
  %v37 = load i64, ptr %v37.p
  %st11 = getelementptr i64, ptr %v0, i64 0
  store i64 %v37, ptr %st11
  %v38.p = getelementptr i64, ptr %v35, i64 1
  %v38 = load i64, ptr %v38.p
  %st12 = getelementptr i64, ptr %v0, i64 1
  store i64 %v38, ptr %st12
  %v39.p = getelementptr i64, ptr %v35, i64 2
  %v39 = load i64, ptr %v39.p
  %st13 = getelementptr i64, ptr %v0, i64 2
  store i64 %v39, ptr %st13
  %v40 = getelementptr i64, ptr %s1, i64 0
  %v41.p = getelementptr i64, ptr %v0, i64 0
  %v41 = load i64, ptr %v41.p
  %st14 = getelementptr i64, ptr %v40, i64 0
  store i64 %v41, ptr %st14
  %v42.p = getelementptr i64, ptr %v0, i64 1
  %v42 = load i64, ptr %v42.p
  %st15 = getelementptr i64, ptr %v40, i64 1
  store i64 %v42, ptr %st15
  %v43.p = getelementptr i64, ptr %v0, i64 2
  %v43 = load i64, ptr %v43.p
  %st16 = getelementptr i64, ptr %v40, i64 2
  store i64 %v43, ptr %st16
  %v44 = add i64 0, 8
  %v46 = add i64 0, 0
  %v47.c = icmp slt i64 %v44, %v46
  %v47 = zext i1 %v47.c to i64
  %c.b3 = icmp ne i64 %v47, 0
  br i1 %c.b3, label %b3.t18, label %b3.e19
b3.t18:
  br label %b6
b3.e19:
  br label %b7
b4:
  %v29 = add i64 0, 1
  %v30 = call ptr @"rt.slice_grow8"(i64 %v19, i64 %v20, i64 %v18, i64 %v29)
  %v31 = getelementptr i8, ptr %v30, i64 %v20
  br label %b3
b5:
  %v27 = inttoptr i64 %v19 to ptr
  %v28 = getelementptr i8, ptr %v27, i64 %v20
  br label %b3
b6:
  %v48 = add i64 0, 122
  call void @"rt.panic"(i64 %v48)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b7:
  %v49 = add i64 0, 63
  %v50.c = icmp sgt i64 %v44, %v49
  %v50 = zext i1 %v50.c to i64
  %c.b7 = icmp ne i64 %v50, 0
  br i1 %c.b7, label %b7.t20, label %b7.e21
b7.t20:
  br label %b9
b7.e21:
  br label %b10
b8:
  %v45 = phi i64 [ %v52, %b9 ], [ %v53, %b10 ]
  %v54 = add i64 0, 255
  %v55 = and i64 %v45, %v54
  %v56 = add i64 0, 256
  %v57.c = icmp uge i64 %v55, %v56
  %v57 = zext i1 %v57.c to i64
  %c.b8 = icmp ne i64 %v57, 0
  br i1 %c.b8, label %b8.t22, label %b8.e23
b8.t22:
  br label %b11
b8.e23:
  br label %b12
b9:
  %v51 = add i64 0, 63
  %v52.n = and i64 %v51, 63
  %v52 = ashr i64 %v1, %v52.n
  br label %b8
b10:
  %v53.n = and i64 %v44, 63
  %v53 = ashr i64 %v1, %v53.n
  br label %b8
b11:
  %v58 = add i64 0, 123
  call void @"rt.panic"(i64 %v58)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b12:
  %v59.p = getelementptr i64, ptr %v40, i64 2
  %v59 = load i64, ptr %v59.p
  %v60.p = getelementptr i64, ptr %v40, i64 0
  %v60 = load i64, ptr %v60.p
  %v61.p = getelementptr i64, ptr %v40, i64 1
  %v61 = load i64, ptr %v61.p
  %v64 = add i64 %v60, %v61
  %v65 = call i64 @"rt.tip8"(i64 %v59, i64 %v64)
  %v66 = add i64 0, 0
  %v67.c = icmp ne i64 %v65, %v66
  %v67 = zext i1 %v67.c to i64
  %c.b12 = icmp ne i64 %v67, 0
  br i1 %c.b12, label %b12.t24, label %b12.e25
b12.t24:
  br label %b15
b12.e25:
  br label %b14
b13:
  %v62 = phi ptr [ %v71, %b14 ], [ %v68, %b15 ]
  %v63 = phi ptr [ %v72, %b14 ], [ %v69, %b15 ]
  %st25 = getelementptr i8, ptr %v63, i64 0
  %st25.b = trunc i64 %v55 to i8
  store i8 %st25.b, ptr %st25
  %v73.p = getelementptr i64, ptr %v40, i64 1
  %v73 = load i64, ptr %v73.p
  %v74 = add i64 0, 1
  %v75 = add i64 %v73, %v74
  %v76 = getelementptr i64, ptr %s0, i64 0
  %v77 = ptrtoint ptr %v62 to i64
  %st26 = getelementptr i64, ptr %v76, i64 0
  store i64 %v77, ptr %st26
  %st27 = getelementptr i64, ptr %v76, i64 1
  store i64 %v75, ptr %st27
  %st28 = getelementptr i64, ptr %v76, i64 2
  store i64 %v59, ptr %st28
  %v78.p = getelementptr i64, ptr %v76, i64 0
  %v78 = load i64, ptr %v78.p
  %st29 = getelementptr i64, ptr %v0, i64 0
  store i64 %v78, ptr %st29
  %v79.p = getelementptr i64, ptr %v76, i64 1
  %v79 = load i64, ptr %v79.p
  %st30 = getelementptr i64, ptr %v0, i64 1
  store i64 %v79, ptr %st30
  %v80.p = getelementptr i64, ptr %v76, i64 2
  %v80 = load i64, ptr %v80.p
  %st31 = getelementptr i64, ptr %v0, i64 2
  store i64 %v80, ptr %st31
  %v81 = getelementptr i64, ptr %s0, i64 0
  %v82.p = getelementptr i64, ptr %v0, i64 0
  %v82 = load i64, ptr %v82.p
  %st32 = getelementptr i64, ptr %v81, i64 0
  store i64 %v82, ptr %st32
  %v83.p = getelementptr i64, ptr %v0, i64 1
  %v83 = load i64, ptr %v83.p
  %st33 = getelementptr i64, ptr %v81, i64 1
  store i64 %v83, ptr %st33
  %v84.p = getelementptr i64, ptr %v0, i64 2
  %v84 = load i64, ptr %v84.p
  %st34 = getelementptr i64, ptr %v81, i64 2
  store i64 %v84, ptr %st34
  %v85 = add i64 0, 16
  %v87 = add i64 0, 0
  %v88.c = icmp slt i64 %v85, %v87
  %v88 = zext i1 %v88.c to i64
  %c.b13 = icmp ne i64 %v88, 0
  br i1 %c.b13, label %b13.t36, label %b13.e37
b13.t36:
  br label %b16
b13.e37:
  br label %b17
b14:
  %v70 = add i64 0, 1
  %v71 = call ptr @"rt.slice_grow8"(i64 %v60, i64 %v61, i64 %v59, i64 %v70)
  %v72 = getelementptr i8, ptr %v71, i64 %v61
  br label %b13
b15:
  %v68 = inttoptr i64 %v60 to ptr
  %v69 = getelementptr i8, ptr %v68, i64 %v61
  br label %b13
b16:
  %v89 = add i64 0, 124
  call void @"rt.panic"(i64 %v89)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v90 = add i64 0, 63
  %v91.c = icmp sgt i64 %v85, %v90
  %v91 = zext i1 %v91.c to i64
  %c.b17 = icmp ne i64 %v91, 0
  br i1 %c.b17, label %b17.t38, label %b17.e39
b17.t38:
  br label %b19
b17.e39:
  br label %b20
b18:
  %v86 = phi i64 [ %v93, %b19 ], [ %v94, %b20 ]
  %v95 = add i64 0, 255
  %v96 = and i64 %v86, %v95
  %v97 = add i64 0, 256
  %v98.c = icmp uge i64 %v96, %v97
  %v98 = zext i1 %v98.c to i64
  %c.b18 = icmp ne i64 %v98, 0
  br i1 %c.b18, label %b18.t40, label %b18.e41
b18.t40:
  br label %b21
b18.e41:
  br label %b22
b19:
  %v92 = add i64 0, 63
  %v93.n = and i64 %v92, 63
  %v93 = ashr i64 %v1, %v93.n
  br label %b18
b20:
  %v94.n = and i64 %v85, 63
  %v94 = ashr i64 %v1, %v94.n
  br label %b18
b21:
  %v99 = add i64 0, 125
  call void @"rt.panic"(i64 %v99)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b22:
  %v100.p = getelementptr i64, ptr %v81, i64 2
  %v100 = load i64, ptr %v100.p
  %v101.p = getelementptr i64, ptr %v81, i64 0
  %v101 = load i64, ptr %v101.p
  %v102.p = getelementptr i64, ptr %v81, i64 1
  %v102 = load i64, ptr %v102.p
  %v105 = add i64 %v101, %v102
  %v106 = call i64 @"rt.tip8"(i64 %v100, i64 %v105)
  %v107 = add i64 0, 0
  %v108.c = icmp ne i64 %v106, %v107
  %v108 = zext i1 %v108.c to i64
  %c.b22 = icmp ne i64 %v108, 0
  br i1 %c.b22, label %b22.t42, label %b22.e43
b22.t42:
  br label %b25
b22.e43:
  br label %b24
b23:
  %v103 = phi ptr [ %v112, %b24 ], [ %v109, %b25 ]
  %v104 = phi ptr [ %v113, %b24 ], [ %v110, %b25 ]
  %st43 = getelementptr i8, ptr %v104, i64 0
  %st43.b = trunc i64 %v96 to i8
  store i8 %st43.b, ptr %st43
  %v114.p = getelementptr i64, ptr %v81, i64 1
  %v114 = load i64, ptr %v114.p
  %v115 = add i64 0, 1
  %v116 = add i64 %v114, %v115
  %v117 = getelementptr i64, ptr %s1, i64 0
  %v118 = ptrtoint ptr %v103 to i64
  %st44 = getelementptr i64, ptr %v117, i64 0
  store i64 %v118, ptr %st44
  %st45 = getelementptr i64, ptr %v117, i64 1
  store i64 %v116, ptr %st45
  %st46 = getelementptr i64, ptr %v117, i64 2
  store i64 %v100, ptr %st46
  %v119.p = getelementptr i64, ptr %v117, i64 0
  %v119 = load i64, ptr %v119.p
  %st47 = getelementptr i64, ptr %v0, i64 0
  store i64 %v119, ptr %st47
  %v120.p = getelementptr i64, ptr %v117, i64 1
  %v120 = load i64, ptr %v120.p
  %st48 = getelementptr i64, ptr %v0, i64 1
  store i64 %v120, ptr %st48
  %v121.p = getelementptr i64, ptr %v117, i64 2
  %v121 = load i64, ptr %v121.p
  %st49 = getelementptr i64, ptr %v0, i64 2
  store i64 %v121, ptr %st49
  %v122 = getelementptr i64, ptr %s1, i64 0
  %v123.p = getelementptr i64, ptr %v0, i64 0
  %v123 = load i64, ptr %v123.p
  %st50 = getelementptr i64, ptr %v122, i64 0
  store i64 %v123, ptr %st50
  %v124.p = getelementptr i64, ptr %v0, i64 1
  %v124 = load i64, ptr %v124.p
  %st51 = getelementptr i64, ptr %v122, i64 1
  store i64 %v124, ptr %st51
  %v125.p = getelementptr i64, ptr %v0, i64 2
  %v125 = load i64, ptr %v125.p
  %st52 = getelementptr i64, ptr %v122, i64 2
  store i64 %v125, ptr %st52
  %v126 = add i64 0, 24
  %v128 = add i64 0, 0
  %v129.c = icmp slt i64 %v126, %v128
  %v129 = zext i1 %v129.c to i64
  %c.b23 = icmp ne i64 %v129, 0
  br i1 %c.b23, label %b23.t54, label %b23.e55
b23.t54:
  br label %b26
b23.e55:
  br label %b27
b24:
  %v111 = add i64 0, 1
  %v112 = call ptr @"rt.slice_grow8"(i64 %v101, i64 %v102, i64 %v100, i64 %v111)
  %v113 = getelementptr i8, ptr %v112, i64 %v102
  br label %b23
b25:
  %v109 = inttoptr i64 %v101 to ptr
  %v110 = getelementptr i8, ptr %v109, i64 %v102
  br label %b23
b26:
  %v130 = add i64 0, 126
  call void @"rt.panic"(i64 %v130)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b27:
  %v131 = add i64 0, 63
  %v132.c = icmp sgt i64 %v126, %v131
  %v132 = zext i1 %v132.c to i64
  %c.b27 = icmp ne i64 %v132, 0
  br i1 %c.b27, label %b27.t56, label %b27.e57
b27.t56:
  br label %b29
b27.e57:
  br label %b30
b28:
  %v127 = phi i64 [ %v134, %b29 ], [ %v135, %b30 ]
  %v136 = add i64 0, 255
  %v137 = and i64 %v127, %v136
  %v138 = add i64 0, 256
  %v139.c = icmp uge i64 %v137, %v138
  %v139 = zext i1 %v139.c to i64
  %c.b28 = icmp ne i64 %v139, 0
  br i1 %c.b28, label %b28.t58, label %b28.e59
b28.t58:
  br label %b31
b28.e59:
  br label %b32
b29:
  %v133 = add i64 0, 63
  %v134.n = and i64 %v133, 63
  %v134 = ashr i64 %v1, %v134.n
  br label %b28
b30:
  %v135.n = and i64 %v126, 63
  %v135 = ashr i64 %v1, %v135.n
  br label %b28
b31:
  %v140 = add i64 0, 127
  call void @"rt.panic"(i64 %v140)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b32:
  %v141.p = getelementptr i64, ptr %v122, i64 2
  %v141 = load i64, ptr %v141.p
  %v142.p = getelementptr i64, ptr %v122, i64 0
  %v142 = load i64, ptr %v142.p
  %v143.p = getelementptr i64, ptr %v122, i64 1
  %v143 = load i64, ptr %v143.p
  %v146 = add i64 %v142, %v143
  %v147 = call i64 @"rt.tip8"(i64 %v141, i64 %v146)
  %v148 = add i64 0, 0
  %v149.c = icmp ne i64 %v147, %v148
  %v149 = zext i1 %v149.c to i64
  %c.b32 = icmp ne i64 %v149, 0
  br i1 %c.b32, label %b32.t60, label %b32.e61
b32.t60:
  br label %b35
b32.e61:
  br label %b34
b33:
  %v144 = phi ptr [ %v153, %b34 ], [ %v150, %b35 ]
  %v145 = phi ptr [ %v154, %b34 ], [ %v151, %b35 ]
  %st61 = getelementptr i8, ptr %v145, i64 0
  %st61.b = trunc i64 %v137 to i8
  store i8 %st61.b, ptr %st61
  %v155.p = getelementptr i64, ptr %v122, i64 1
  %v155 = load i64, ptr %v155.p
  %v156 = add i64 0, 1
  %v157 = add i64 %v155, %v156
  %v158 = getelementptr i64, ptr %s0, i64 0
  %v159 = ptrtoint ptr %v144 to i64
  %st62 = getelementptr i64, ptr %v158, i64 0
  store i64 %v159, ptr %st62
  %st63 = getelementptr i64, ptr %v158, i64 1
  store i64 %v157, ptr %st63
  %st64 = getelementptr i64, ptr %v158, i64 2
  store i64 %v141, ptr %st64
  %v160.p = getelementptr i64, ptr %v158, i64 0
  %v160 = load i64, ptr %v160.p
  %st65 = getelementptr i64, ptr %v0, i64 0
  store i64 %v160, ptr %st65
  %v161.p = getelementptr i64, ptr %v158, i64 1
  %v161 = load i64, ptr %v161.p
  %st66 = getelementptr i64, ptr %v0, i64 1
  store i64 %v161, ptr %st66
  %v162.p = getelementptr i64, ptr %v158, i64 2
  %v162 = load i64, ptr %v162.p
  %st67 = getelementptr i64, ptr %v0, i64 2
  store i64 %v162, ptr %st67
  %v164 = getelementptr i64, ptr @"rt.meta", i64 0
  %st68 = getelementptr i64, ptr %v164, i64 0
  store i64 %v2, ptr %st68
  ret void
b34:
  %v152 = add i64 0, 1
  %v153 = call ptr @"rt.slice_grow8"(i64 %v142, i64 %v143, i64 %v141, i64 %v152)
  %v154 = getelementptr i8, ptr %v153, i64 %v143
  br label %b33
b35:
  %v150 = inttoptr i64 %v142 to ptr
  %v151 = getelementptr i8, ptr %v150, i64 %v143
  br label %b33
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
  %v141 = getelementptr i64, ptr @"rt.meta", i64 0
  %v5.p = getelementptr i64, ptr %v141, i64 0
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
  %v16 = getelementptr i64, ptr @"str.21", i64 0
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
  %v142 = getelementptr i64, ptr @"rt.meta", i64 0
  %v34.p = getelementptr i64, ptr %v142, i64 0
  %v34 = load i64, ptr %v34.p
  %v35 = add i64 0, 0
  %v36.p = getelementptr i64, ptr %v4, i64 1
  %v36 = load i64, ptr %v36.p
  %v37 = getelementptr i64, ptr %s4, i64 0
  %v143 = getelementptr i64, ptr @"rt.meta", i64 0
  %v38.p = getelementptr i64, ptr %v143, i64 0
  %v38 = load i64, ptr %v38.p
  %v39 = getelementptr i64, ptr %s5, i64 0
  %st16 = getelementptr i64, ptr %v39, i64 0
  store i64 %v35, ptr %st16
  %v144 = getelementptr i64, ptr @"rt.meta", i64 0
  %v40.p = getelementptr i64, ptr %v144, i64 0
  %v40 = load i64, ptr %v40.p
  br label %b3
b1:
  %v145 = getelementptr i64, ptr @"rt.meta", i64 0
  %st17 = getelementptr i64, ptr %v145, i64 0
  store i64 %v34, ptr %st17
  %v138.p = getelementptr i64, ptr %v30, i64 0
  %v138 = load i64, ptr %v138.p
  %st18 = getelementptr i64, ptr %v0, i64 0
  store i64 %v138, ptr %st18
  %v139.p = getelementptr i64, ptr %v30, i64 1
  %v139 = load i64, ptr %v139.p
  %st19 = getelementptr i64, ptr %v0, i64 1
  store i64 %v139, ptr %st19
  %v140.p = getelementptr i64, ptr %v30, i64 2
  %v140 = load i64, ptr %v140.p
  %st20 = getelementptr i64, ptr %v0, i64 2
  store i64 %v140, ptr %st20
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v146 = getelementptr i64, ptr @"rt.meta", i64 0
  %st21 = getelementptr i64, ptr %v146, i64 0
  store i64 %v5, ptr %st21
  ret void
b2:
  br label %b1
b3:
  %v147 = getelementptr i64, ptr @"rt.meta", i64 0
  %st22 = getelementptr i64, ptr %v147, i64 0
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
  %v148 = getelementptr i64, ptr @"rt.meta", i64 0
  %v43.p = getelementptr i64, ptr %v148, i64 0
  %v43 = load i64, ptr %v43.p
  %v44.p = getelementptr i64, ptr %v39, i64 0
  %v44 = load i64, ptr %v44.p
  %v149 = getelementptr i64, ptr @"rt.meta", i64 0
  %v45.p = getelementptr i64, ptr %v149, i64 0
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
  %v150 = getelementptr i64, ptr @"rt.meta", i64 0
  %st27 = getelementptr i64, ptr %v150, i64 0
  store i64 %v40, ptr %st27
  br label %b2
b6:
  %v151 = getelementptr i64, ptr @"rt.meta", i64 0
  %st28 = getelementptr i64, ptr %v151, i64 0
  store i64 %v45, ptr %st28
  %v135 = add i64 0, 1
  %v136.p = getelementptr i64, ptr %v39, i64 0
  %v136 = load i64, ptr %v136.p
  %v137 = add i64 %v136, %v135
  %st29 = getelementptr i64, ptr %v39, i64 0
  store i64 %v137, ptr %st29
  br label %b3
b7:
  %v48 = add i64 0, 128
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
  %v61 = add i64 0, 0
  %v62.c = icmp slt i64 %v59, %v61
  %v62 = zext i1 %v62.c to i64
  %c.b8 = icmp ne i64 %v62, 0
  br i1 %c.b8, label %b8.t34, label %b8.e35
b8.t34:
  br label %b9
b8.e35:
  br label %b10
b9:
  %v63 = add i64 0, 129
  call void @"rt.panic"(i64 %v63)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b10:
  %v64 = add i64 0, 63
  %v65.c = icmp sgt i64 %v59, %v64
  %v65 = zext i1 %v65.c to i64
  %c.b10 = icmp ne i64 %v65, 0
  br i1 %c.b10, label %b10.t36, label %b10.e37
b10.t36:
  br label %b12
b10.e37:
  br label %b13
b11:
  %v60 = phi i64 [ %v67, %b12 ], [ %v68, %b13 ]
  %v69.p = getelementptr i64, ptr %v21, i64 1
  %v69 = load i64, ptr %v69.p
  %v70.c = icmp uge i64 %v60, %v69
  %v70 = zext i1 %v70.c to i64
  %c.b11 = icmp ne i64 %v70, 0
  br i1 %c.b11, label %b11.t38, label %b11.e39
b11.t38:
  br label %b14
b11.e39:
  br label %b15
b12:
  %v66 = add i64 0, 63
  %v67.n = and i64 %v66, 63
  %v67 = ashr i64 %v52, %v67.n
  br label %b11
b13:
  %v68.n = and i64 %v59, 63
  %v68 = ashr i64 %v52, %v68.n
  br label %b11
b14:
  %v71 = add i64 0, 130
  call void @"rt.panic"(i64 %v71)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b15:
  %v72.p = getelementptr i64, ptr %v21, i64 0
  %v72 = load i64, ptr %v72.p
  %v73 = inttoptr i64 %v72 to ptr
  %v74 = getelementptr i8, ptr %v73, i64 %v60
  %v75.p = getelementptr i8, ptr %v74, i64 0
  %v75.b = load i8, ptr %v75.p
  %v75 = zext i8 %v75.b to i64
  %v76.p = getelementptr i64, ptr %v55, i64 2
  %v76 = load i64, ptr %v76.p
  %v77.p = getelementptr i64, ptr %v55, i64 0
  %v77 = load i64, ptr %v77.p
  %v78.p = getelementptr i64, ptr %v55, i64 1
  %v78 = load i64, ptr %v78.p
  %v81 = add i64 %v77, %v78
  %v82 = call i64 @"rt.tip8"(i64 %v76, i64 %v81)
  %v83 = add i64 0, 0
  %v84.c = icmp ne i64 %v82, %v83
  %v84 = zext i1 %v84.c to i64
  %c.b15 = icmp ne i64 %v84, 0
  br i1 %c.b15, label %b15.t40, label %b15.e41
b15.t40:
  br label %b18
b15.e41:
  br label %b17
b16:
  %v79 = phi ptr [ %v88, %b17 ], [ %v85, %b18 ]
  %v80 = phi ptr [ %v89, %b17 ], [ %v86, %b18 ]
  %st41 = getelementptr i8, ptr %v80, i64 0
  %st41.b = trunc i64 %v75 to i8
  store i8 %st41.b, ptr %st41
  %v90.p = getelementptr i64, ptr %v55, i64 1
  %v90 = load i64, ptr %v90.p
  %v91 = add i64 0, 1
  %v92 = add i64 %v90, %v91
  %v93 = getelementptr i64, ptr %s6, i64 0
  %v94 = ptrtoint ptr %v79 to i64
  %st42 = getelementptr i64, ptr %v93, i64 0
  store i64 %v94, ptr %st42
  %st43 = getelementptr i64, ptr %v93, i64 1
  store i64 %v92, ptr %st43
  %st44 = getelementptr i64, ptr %v93, i64 2
  store i64 %v76, ptr %st44
  %v95.p = getelementptr i64, ptr %v93, i64 0
  %v95 = load i64, ptr %v95.p
  %st45 = getelementptr i64, ptr %v30, i64 0
  store i64 %v95, ptr %st45
  %v96.p = getelementptr i64, ptr %v93, i64 1
  %v96 = load i64, ptr %v96.p
  %st46 = getelementptr i64, ptr %v30, i64 1
  store i64 %v96, ptr %st46
  %v97.p = getelementptr i64, ptr %v93, i64 2
  %v97 = load i64, ptr %v97.p
  %st47 = getelementptr i64, ptr %v30, i64 2
  store i64 %v97, ptr %st47
  %v98 = add i64 0, 1
  %v99 = add i64 %v5, %v98
  %v100 = getelementptr i64, ptr %s6, i64 0
  %v101.p = getelementptr i64, ptr %v30, i64 0
  %v101 = load i64, ptr %v101.p
  %st48 = getelementptr i64, ptr %v100, i64 0
  store i64 %v101, ptr %st48
  %v102.p = getelementptr i64, ptr %v30, i64 1
  %v102 = load i64, ptr %v102.p
  %st49 = getelementptr i64, ptr %v100, i64 1
  store i64 %v102, ptr %st49
  %v103.p = getelementptr i64, ptr %v30, i64 2
  %v103 = load i64, ptr %v103.p
  %st50 = getelementptr i64, ptr %v100, i64 2
  store i64 %v103, ptr %st50
  %v104 = add i64 0, 15
  %v105 = and i64 %v52, %v104
  %v106.p = getelementptr i64, ptr %v21, i64 1
  %v106 = load i64, ptr %v106.p
  %v107.c = icmp uge i64 %v105, %v106
  %v107 = zext i1 %v107.c to i64
  %c.b16 = icmp ne i64 %v107, 0
  br i1 %c.b16, label %b16.t52, label %b16.e53
b16.t52:
  br label %b19
b16.e53:
  br label %b20
b17:
  %v87 = add i64 0, 1
  %v88 = call ptr @"rt.slice_grow8"(i64 %v77, i64 %v78, i64 %v76, i64 %v87)
  %v89 = getelementptr i8, ptr %v88, i64 %v78
  br label %b16
b18:
  %v85 = inttoptr i64 %v77 to ptr
  %v86 = getelementptr i8, ptr %v85, i64 %v78
  br label %b16
b19:
  %v108 = add i64 0, 131
  call void @"rt.panic"(i64 %v108)
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b20:
  %v109.p = getelementptr i64, ptr %v21, i64 0
  %v109 = load i64, ptr %v109.p
  %v110 = inttoptr i64 %v109 to ptr
  %v111 = getelementptr i8, ptr %v110, i64 %v105
  %v112.p = getelementptr i8, ptr %v111, i64 0
  %v112.b = load i8, ptr %v112.p
  %v112 = zext i8 %v112.b to i64
  %v113.p = getelementptr i64, ptr %v100, i64 2
  %v113 = load i64, ptr %v113.p
  %v114.p = getelementptr i64, ptr %v100, i64 0
  %v114 = load i64, ptr %v114.p
  %v115.p = getelementptr i64, ptr %v100, i64 1
  %v115 = load i64, ptr %v115.p
  %v118 = add i64 %v114, %v115
  %v119 = call i64 @"rt.tip8"(i64 %v113, i64 %v118)
  %v120 = add i64 0, 0
  %v121.c = icmp ne i64 %v119, %v120
  %v121 = zext i1 %v121.c to i64
  %c.b20 = icmp ne i64 %v121, 0
  br i1 %c.b20, label %b20.t54, label %b20.e55
b20.t54:
  br label %b23
b20.e55:
  br label %b22
b21:
  %v116 = phi ptr [ %v125, %b22 ], [ %v122, %b23 ]
  %v117 = phi ptr [ %v126, %b22 ], [ %v123, %b23 ]
  %st55 = getelementptr i8, ptr %v117, i64 0
  %st55.b = trunc i64 %v112 to i8
  store i8 %st55.b, ptr %st55
  %v127.p = getelementptr i64, ptr %v100, i64 1
  %v127 = load i64, ptr %v127.p
  %v128 = add i64 0, 1
  %v129 = add i64 %v127, %v128
  %v130 = getelementptr i64, ptr %s1, i64 0
  %v131 = ptrtoint ptr %v116 to i64
  %st56 = getelementptr i64, ptr %v130, i64 0
  store i64 %v131, ptr %st56
  %st57 = getelementptr i64, ptr %v130, i64 1
  store i64 %v129, ptr %st57
  %st58 = getelementptr i64, ptr %v130, i64 2
  store i64 %v113, ptr %st58
  %v132.p = getelementptr i64, ptr %v130, i64 0
  %v132 = load i64, ptr %v132.p
  %st59 = getelementptr i64, ptr %v30, i64 0
  store i64 %v132, ptr %st59
  %v133.p = getelementptr i64, ptr %v130, i64 1
  %v133 = load i64, ptr %v133.p
  %st60 = getelementptr i64, ptr %v30, i64 1
  store i64 %v133, ptr %st60
  %v134.p = getelementptr i64, ptr %v130, i64 2
  %v134 = load i64, ptr %v134.p
  %st61 = getelementptr i64, ptr %v30, i64 2
  store i64 %v134, ptr %st61
  br label %b6
b22:
  %v124 = add i64 0, 1
  %v125 = call ptr @"rt.slice_grow8"(i64 %v114, i64 %v115, i64 %v113, i64 %v124)
  %v126 = getelementptr i8, ptr %v125, i64 %v115
  br label %b21
b23:
  %v122 = inttoptr i64 %v114 to ptr
  %v123 = getelementptr i8, ptr %v122, i64 %v115
  br label %b21
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
  %s3 = alloca [1 x i64], align 8
  %s3.z0 = getelementptr i64, ptr %s3, i64 0
  store i64 0, ptr %s3.z0
  %s4 = alloca [4 x i64], align 8
  %s4.z0 = getelementptr i64, ptr %s4, i64 0
  store i64 0, ptr %s4.z0
  %s4.z1 = getelementptr i64, ptr %s4, i64 1
  store i64 0, ptr %s4.z1
  %s4.z2 = getelementptr i64, ptr %s4, i64 2
  store i64 0, ptr %s4.z2
  %s4.z3 = getelementptr i64, ptr %s4, i64 3
  store i64 0, ptr %s4.z3
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
  %s7 = alloca [1 x i64], align 8
  %s7.z0 = getelementptr i64, ptr %s7, i64 0
  store i64 0, ptr %s7.z0
  %s8 = alloca [1 x i64], align 8
  %s8.z0 = getelementptr i64, ptr %s8, i64 0
  store i64 0, ptr %s8.z0
  %s9 = alloca [3 x i64], align 8
  %s9.z0 = getelementptr i64, ptr %s9, i64 0
  store i64 0, ptr %s9.z0
  %s9.z1 = getelementptr i64, ptr %s9, i64 1
  store i64 0, ptr %s9.z1
  %s9.z2 = getelementptr i64, ptr %s9, i64 2
  store i64 0, ptr %s9.z2
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
  %v30 = getelementptr i64, ptr %s3, i64 0
  %v31 = add i64 0, 0
  %st12 = getelementptr i64, ptr %v30, i64 0
  store i64 %v31, ptr %st12
  %v32 = add i64 0, 2
  %st13 = getelementptr i64, ptr %v30, i64 0
  store i64 %v32, ptr %st13
  %v33 = getelementptr i64, ptr %s4, i64 0
  %v34.p = getelementptr i64, ptr %v30, i64 0
  %v34 = load i64, ptr %v34.p
  %st14 = getelementptr i64, ptr %v33, i64 0
  store i64 %v34, ptr %st14
  %v35 = add i64 0, 0
  %st15 = getelementptr i64, ptr %v33, i64 1
  store i64 %v35, ptr %st15
  %st16 = getelementptr i64, ptr %v33, i64 2
  store i64 %v35, ptr %st16
  %st17 = getelementptr i64, ptr %v33, i64 3
  store i64 %v35, ptr %st17
  %v36 = getelementptr i64, ptr %s5, i64 0
  %v37 = add i64 0, 1
  %st18 = getelementptr i64, ptr %v36, i64 0
  store i64 %v37, ptr %st18
  %v38.p = getelementptr i64, ptr %v33, i64 0
  %v38 = load i64, ptr %v38.p
  %st19 = getelementptr i64, ptr %v36, i64 1
  store i64 %v38, ptr %st19
  %v39.p = getelementptr i64, ptr %v33, i64 1
  %v39 = load i64, ptr %v39.p
  %st20 = getelementptr i64, ptr %v36, i64 2
  store i64 %v39, ptr %st20
  %v40.p = getelementptr i64, ptr %v33, i64 2
  %v40 = load i64, ptr %v40.p
  %st21 = getelementptr i64, ptr %v36, i64 3
  store i64 %v40, ptr %st21
  %v41.p = getelementptr i64, ptr %v33, i64 3
  %v41 = load i64, ptr %v41.p
  %st22 = getelementptr i64, ptr %v36, i64 4
  store i64 %v41, ptr %st22
  %v42.p = getelementptr i64, ptr %v28, i64 0
  %v42 = load i64, ptr %v42.p
  %st23 = getelementptr i64, ptr %v0, i64 0
  store i64 %v42, ptr %st23
  %v43.p = getelementptr i64, ptr %v28, i64 1
  %v43 = load i64, ptr %v43.p
  %st24 = getelementptr i64, ptr %v0, i64 1
  store i64 %v43, ptr %st24
  %v44.p = getelementptr i64, ptr %v28, i64 2
  %v44 = load i64, ptr %v44.p
  %st25 = getelementptr i64, ptr %v0, i64 2
  store i64 %v44, ptr %st25
  %v45.p = getelementptr i64, ptr %v36, i64 0
  %v45 = load i64, ptr %v45.p
  %st26 = getelementptr i64, ptr %v0, i64 3
  store i64 %v45, ptr %st26
  %v46.p = getelementptr i64, ptr %v36, i64 1
  %v46 = load i64, ptr %v46.p
  %st27 = getelementptr i64, ptr %v0, i64 4
  store i64 %v46, ptr %st27
  %v47.p = getelementptr i64, ptr %v36, i64 2
  %v47 = load i64, ptr %v47.p
  %st28 = getelementptr i64, ptr %v0, i64 5
  store i64 %v47, ptr %st28
  %v48.p = getelementptr i64, ptr %v36, i64 3
  %v48 = load i64, ptr %v48.p
  %st29 = getelementptr i64, ptr %v0, i64 6
  store i64 %v48, ptr %st29
  %v49.p = getelementptr i64, ptr %v36, i64 4
  %v49 = load i64, ptr %v49.p
  %st30 = getelementptr i64, ptr %v0, i64 7
  store i64 %v49, ptr %st30
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v50.p = getelementptr i64, ptr %v0, i64 3
  %v50 = load i64, ptr %v50.p
  %v51 = add i64 0, 0
  %v52.c = icmp ne i64 %v50, %v51
  %v52 = zext i1 %v52.c to i64
  %c.b1 = icmp ne i64 %v52, 0
  br i1 %c.b1, label %b1.t32, label %b1.e33
b1.t32:
  br label %b3
b1.e33:
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
  %st33 = getelementptr i64, ptr %v189, i64 0
  store i64 %v5, ptr %st33
  ret void
b5:
  %v55 = add i64 0, 0
  %v56 = call ptr @"rt.region_alloc8"(i64 %v15, i64 %v55)
  %v57 = add i64 0, 0
  %v58 = getelementptr i64, ptr %s2, i64 0
  %v59 = ptrtoint ptr %v56 to i64
  %st34 = getelementptr i64, ptr %v58, i64 0
  store i64 %v59, ptr %st34
  %st35 = getelementptr i64, ptr %v58, i64 1
  store i64 %v57, ptr %st35
  %st36 = getelementptr i64, ptr %v58, i64 2
  store i64 %v15, ptr %st36
  %v60 = getelementptr i64, ptr %s6, i64 0
  %v61.p = getelementptr i64, ptr %v58, i64 0
  %v61 = load i64, ptr %v61.p
  %st37 = getelementptr i64, ptr %v60, i64 0
  store i64 %v61, ptr %st37
  %v62.p = getelementptr i64, ptr %v58, i64 1
  %v62 = load i64, ptr %v62.p
  %st38 = getelementptr i64, ptr %v60, i64 1
  store i64 %v62, ptr %st38
  %v63.p = getelementptr i64, ptr %v58, i64 2
  %v63 = load i64, ptr %v63.p
  %st39 = getelementptr i64, ptr %v60, i64 2
  store i64 %v63, ptr %st39
  %v190 = getelementptr i64, ptr @"rt.meta", i64 0
  %v64.p = getelementptr i64, ptr %v190, i64 0
  %v64 = load i64, ptr %v64.p
  %v65 = add i64 0, 0
  %v66.p = getelementptr i64, ptr %v16, i64 1
  %v66 = load i64, ptr %v66.p
  %v67 = add i64 0, 2
  %v68 = sdiv i64 %v66, %v67
  %v69 = getelementptr i64, ptr %s3, i64 0
  %v191 = getelementptr i64, ptr @"rt.meta", i64 0
  %v70.p = getelementptr i64, ptr %v191, i64 0
  %v70 = load i64, ptr %v70.p
  %v71 = getelementptr i64, ptr %s7, i64 0
  %st40 = getelementptr i64, ptr %v71, i64 0
  store i64 %v65, ptr %st40
  %v192 = getelementptr i64, ptr @"rt.meta", i64 0
  %v72.p = getelementptr i64, ptr %v192, i64 0
  %v72 = load i64, ptr %v72.p
  br label %b8
b6:
  %v193 = getelementptr i64, ptr @"rt.meta", i64 0
  %st41 = getelementptr i64, ptr %v193, i64 0
  store i64 %v64, ptr %st41
  %v173 = getelementptr i64, ptr %s5, i64 0
  %v174 = add i64 0, 0
  %st42 = getelementptr i64, ptr %v173, i64 0
  store i64 %v174, ptr %st42
  %v175.p = getelementptr i64, ptr %v60, i64 0
  %v175 = load i64, ptr %v175.p
  %st43 = getelementptr i64, ptr %v0, i64 0
  store i64 %v175, ptr %st43
  %v176.p = getelementptr i64, ptr %v60, i64 1
  %v176 = load i64, ptr %v176.p
  %st44 = getelementptr i64, ptr %v0, i64 1
  store i64 %v176, ptr %st44
  %v177.p = getelementptr i64, ptr %v60, i64 2
  %v177 = load i64, ptr %v177.p
  %st45 = getelementptr i64, ptr %v0, i64 2
  store i64 %v177, ptr %st45
  %v178.p = getelementptr i64, ptr %v173, i64 0
  %v178 = load i64, ptr %v178.p
  %st46 = getelementptr i64, ptr %v0, i64 3
  store i64 %v178, ptr %st46
  %v179.p = getelementptr i64, ptr %v173, i64 1
  %v179 = load i64, ptr %v179.p
  %st47 = getelementptr i64, ptr %v0, i64 4
  store i64 %v179, ptr %st47
  %v180.p = getelementptr i64, ptr %v173, i64 2
  %v180 = load i64, ptr %v180.p
  %st48 = getelementptr i64, ptr %v0, i64 5
  store i64 %v180, ptr %st48
  %v181.p = getelementptr i64, ptr %v173, i64 3
  %v181 = load i64, ptr %v181.p
  %st49 = getelementptr i64, ptr %v0, i64 6
  store i64 %v181, ptr %st49
  %v182.p = getelementptr i64, ptr %v173, i64 4
  %v182 = load i64, ptr %v182.p
  %st50 = getelementptr i64, ptr %v0, i64 7
  store i64 %v182, ptr %st50
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v183.p = getelementptr i64, ptr %v0, i64 3
  %v183 = load i64, ptr %v183.p
  %v184 = add i64 0, 0
  %v185.c = icmp ne i64 %v183, %v184
  %v185 = zext i1 %v185.c to i64
  %c.b6 = icmp ne i64 %v185, 0
  br i1 %c.b6, label %b6.t52, label %b6.e53
b6.t52:
  br label %b28
b6.e53:
  br label %b29
b7:
  br label %b6
b8:
  %v194 = getelementptr i64, ptr @"rt.meta", i64 0
  %st53 = getelementptr i64, ptr %v194, i64 0
  store i64 %v72, ptr %st53
  %v73.p = getelementptr i64, ptr %v71, i64 0
  %v73 = load i64, ptr %v73.p
  %v74.c = icmp slt i64 %v73, %v68
  %v74 = zext i1 %v74.c to i64
  %c.b8 = icmp ne i64 %v74, 0
  br i1 %c.b8, label %b8.t55, label %b8.e56
b8.t55:
  br label %b9
b8.e56:
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
  br i1 %c.b9, label %b9.t57, label %b9.e58
b9.t57:
  br label %b12
b9.e58:
  br label %b13
b10:
  %v197 = getelementptr i64, ptr @"rt.meta", i64 0
  %st58 = getelementptr i64, ptr %v197, i64 0
  store i64 %v72, ptr %st58
  br label %b7
b11:
  %v198 = getelementptr i64, ptr @"rt.meta", i64 0
  %st59 = getelementptr i64, ptr %v198, i64 0
  store i64 %v77, ptr %st59
  %v170 = add i64 0, 1
  %v171.p = getelementptr i64, ptr %v71, i64 0
  %v171 = load i64, ptr %v171.p
  %v172 = add i64 %v171, %v170
  %st60 = getelementptr i64, ptr %v71, i64 0
  store i64 %v172, ptr %st60
  br label %b8
b12:
  %v82 = add i64 0, 132
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
  br i1 %c.b13, label %b13.t62, label %b13.e63
b13.t62:
  br label %b14
b13.e63:
  br label %b15
b14:
  %v94 = add i64 0, 133
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
  br i1 %c.b15, label %b15.t64, label %b15.e65
b15.t64:
  br label %b17
b15.e65:
  br label %b16
b16:
  %v103 = add i64 0, 0
  %v104.c = icmp slt i64 %v99, %v103
  %v104 = zext i1 %v104.c to i64
  br label %b17
b17:
  %v102 = phi i64 [ %v101, %b15.t64 ], [ %v104, %b16 ]
  %c.b17 = icmp ne i64 %v102, 0
  br i1 %c.b17, label %b17.t66, label %b17.e67
b17.t66:
  br label %b18
b17.e67:
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
  %st67 = getelementptr i64, ptr %v109, i64 0
  store i64 %v110, ptr %st67
  %st68 = getelementptr i64, ptr %v109, i64 1
  store i64 %v108, ptr %st68
  %st69 = getelementptr i64, ptr %v109, i64 2
  store i64 %v105, ptr %st69
  %v111 = getelementptr i64, ptr %s8, i64 0
  %v112 = add i64 0, 0
  %st70 = getelementptr i64, ptr %v111, i64 0
  store i64 %v112, ptr %st70
  %v113 = add i64 0, 2
  %st71 = getelementptr i64, ptr %v111, i64 0
  store i64 %v113, ptr %st71
  %v114 = getelementptr i64, ptr %s4, i64 0
  %v115.p = getelementptr i64, ptr %v111, i64 0
  %v115 = load i64, ptr %v115.p
  %st72 = getelementptr i64, ptr %v114, i64 0
  store i64 %v115, ptr %st72
  %v116 = add i64 0, 0
  %st73 = getelementptr i64, ptr %v114, i64 1
  store i64 %v116, ptr %st73
  %st74 = getelementptr i64, ptr %v114, i64 2
  store i64 %v116, ptr %st74
  %st75 = getelementptr i64, ptr %v114, i64 3
  store i64 %v116, ptr %st75
  %v117 = getelementptr i64, ptr %s5, i64 0
  %v118 = add i64 0, 1
  %st76 = getelementptr i64, ptr %v117, i64 0
  store i64 %v118, ptr %st76
  %v119.p = getelementptr i64, ptr %v114, i64 0
  %v119 = load i64, ptr %v119.p
  %st77 = getelementptr i64, ptr %v117, i64 1
  store i64 %v119, ptr %st77
  %v120.p = getelementptr i64, ptr %v114, i64 1
  %v120 = load i64, ptr %v120.p
  %st78 = getelementptr i64, ptr %v117, i64 2
  store i64 %v120, ptr %st78
  %v121.p = getelementptr i64, ptr %v114, i64 2
  %v121 = load i64, ptr %v121.p
  %st79 = getelementptr i64, ptr %v117, i64 3
  store i64 %v121, ptr %st79
  %v122.p = getelementptr i64, ptr %v114, i64 3
  %v122 = load i64, ptr %v122.p
  %st80 = getelementptr i64, ptr %v117, i64 4
  store i64 %v122, ptr %st80
  %v123.p = getelementptr i64, ptr %v109, i64 0
  %v123 = load i64, ptr %v123.p
  %st81 = getelementptr i64, ptr %v0, i64 0
  store i64 %v123, ptr %st81
  %v124.p = getelementptr i64, ptr %v109, i64 1
  %v124 = load i64, ptr %v124.p
  %st82 = getelementptr i64, ptr %v0, i64 1
  store i64 %v124, ptr %st82
  %v125.p = getelementptr i64, ptr %v109, i64 2
  %v125 = load i64, ptr %v125.p
  %st83 = getelementptr i64, ptr %v0, i64 2
  store i64 %v125, ptr %st83
  %v126.p = getelementptr i64, ptr %v117, i64 0
  %v126 = load i64, ptr %v126.p
  %st84 = getelementptr i64, ptr %v0, i64 3
  store i64 %v126, ptr %st84
  %v127.p = getelementptr i64, ptr %v117, i64 1
  %v127 = load i64, ptr %v127.p
  %st85 = getelementptr i64, ptr %v0, i64 4
  store i64 %v127, ptr %st85
  %v128.p = getelementptr i64, ptr %v117, i64 2
  %v128 = load i64, ptr %v128.p
  %st86 = getelementptr i64, ptr %v0, i64 5
  store i64 %v128, ptr %st86
  %v129.p = getelementptr i64, ptr %v117, i64 3
  %v129 = load i64, ptr %v129.p
  %st87 = getelementptr i64, ptr %v0, i64 6
  store i64 %v129, ptr %st87
  %v130.p = getelementptr i64, ptr %v117, i64 4
  %v130 = load i64, ptr %v130.p
  %st88 = getelementptr i64, ptr %v0, i64 7
  store i64 %v130, ptr %st88
  call void @"rt.region_relocate8"(ptr %v0, i64 %v5)
  %v131.p = getelementptr i64, ptr %v0, i64 3
  %v131 = load i64, ptr %v131.p
  %v132 = add i64 0, 0
  %v133.c = icmp ne i64 %v131, %v132
  %v133 = zext i1 %v133.c to i64
  %c.b18 = icmp ne i64 %v133, 0
  br i1 %c.b18, label %b18.t90, label %b18.e91
b18.t90:
  br label %b20
b18.e91:
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
  %st91 = getelementptr i64, ptr %v200, i64 0
  store i64 %v5, ptr %st91
  ret void
b22:
  %v136 = add i64 0, 1
  %v137 = add i64 %v5, %v136
  %v138 = getelementptr i64, ptr %s2, i64 0
  %v139.p = getelementptr i64, ptr %v60, i64 0
  %v139 = load i64, ptr %v139.p
  %st92 = getelementptr i64, ptr %v138, i64 0
  store i64 %v139, ptr %st92
  %v140.p = getelementptr i64, ptr %v60, i64 1
  %v140 = load i64, ptr %v140.p
  %st93 = getelementptr i64, ptr %v138, i64 1
  store i64 %v140, ptr %st93
  %v141.p = getelementptr i64, ptr %v60, i64 2
  %v141 = load i64, ptr %v141.p
  %st94 = getelementptr i64, ptr %v138, i64 2
  store i64 %v141, ptr %st94
  %v142 = add i64 0, 16
  %v143 = mul i64 %v87, %v142
  %v144 = add i64 %v143, %v99
  %v145 = add i64 0, 256
  %v146.c = icmp uge i64 %v144, %v145
  %v146 = zext i1 %v146.c to i64
  %c.b22 = icmp ne i64 %v146, 0
  br i1 %c.b22, label %b22.t96, label %b22.e97
b22.t96:
  br label %b23
b22.e97:
  br label %b24
b23:
  %v147 = add i64 0, 134
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
  br i1 %c.b24, label %b24.t98, label %b24.e99
b24.t98:
  br label %b27
b24.e99:
  br label %b26
b25:
  %v151 = phi ptr [ %v160, %b26 ], [ %v157, %b27 ]
  %v152 = phi ptr [ %v161, %b26 ], [ %v158, %b27 ]
  %st99 = getelementptr i8, ptr %v152, i64 0
  %st99.b = trunc i64 %v144 to i8
  store i8 %st99.b, ptr %st99
  %v162.p = getelementptr i64, ptr %v138, i64 1
  %v162 = load i64, ptr %v162.p
  %v163 = add i64 0, 1
  %v164 = add i64 %v162, %v163
  %v165 = getelementptr i64, ptr %s9, i64 0
  %v166 = ptrtoint ptr %v151 to i64
  %st100 = getelementptr i64, ptr %v165, i64 0
  store i64 %v166, ptr %st100
  %st101 = getelementptr i64, ptr %v165, i64 1
  store i64 %v164, ptr %st101
  %st102 = getelementptr i64, ptr %v165, i64 2
  store i64 %v148, ptr %st102
  %v167.p = getelementptr i64, ptr %v165, i64 0
  %v167 = load i64, ptr %v167.p
  %st103 = getelementptr i64, ptr %v60, i64 0
  store i64 %v167, ptr %st103
  %v168.p = getelementptr i64, ptr %v165, i64 1
  %v168 = load i64, ptr %v168.p
  %st104 = getelementptr i64, ptr %v60, i64 1
  store i64 %v168, ptr %st104
  %v169.p = getelementptr i64, ptr %v165, i64 2
  %v169 = load i64, ptr %v169.p
  %st105 = getelementptr i64, ptr %v60, i64 2
  store i64 %v169, ptr %st105
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
  %st106 = getelementptr i64, ptr %v201, i64 0
  store i64 %v5, ptr %st106
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
  %v20 = getelementptr i64, ptr @"str.46", i64 0
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
  %v74 = getelementptr i64, ptr @"str.54", i64 0
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
  %v27 = getelementptr i64, ptr @"str.47", i64 0
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
  %v34 = getelementptr i64, ptr @"str.48", i64 0
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
  %v41 = getelementptr i64, ptr @"str.49", i64 0
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
  %v48 = getelementptr i64, ptr @"str.50", i64 0
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
  %v55 = getelementptr i64, ptr @"str.51", i64 0
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
  %v62 = getelementptr i64, ptr @"str.52", i64 0
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
  %v69 = getelementptr i64, ptr @"str.53", i64 0
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
  %v121 = add i64 0, 58
  call void @"rt.print_char"(i64 %v121)
  call void @"rt.print_int"(i64 %v14)
  %v122 = add i64 0, 58
  call void @"rt.print_char"(i64 %v122)
  call void @"rt.print_int"(i64 %v18)
  %v123 = add i64 0, 10
  call void @"rt.print_char"(i64 %v123)
  call void @"rt.flush"()
  call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 60, i64 101)
  unreachable
b17:
  %v81 = getelementptr i64, ptr @"str.55", i64 0
  %v82 = add i64 0, 29
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
  %v88 = getelementptr i64, ptr @"str.56", i64 0
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
  %v95 = getelementptr i64, ptr @"str.57", i64 0
  %v96 = add i64 0, 34
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
  %v102 = getelementptr i64, ptr @"str.58", i64 0
  %v103 = add i64 0, 50
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
  %v109 = getelementptr i64, ptr @"str.59", i64 0
  %v110 = add i64 0, 34
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
  %v114 = add i64 0, 5
  %v115.c = icmp eq i64 %v10, %v114
  %v115 = zext i1 %v115.c to i64
  %c.b26 = icmp ne i64 %v115, 0
  br i1 %c.b26, label %b26.t68, label %b26.e69
b26.t68:
  br label %b27
b26.e69:
  br label %b28
b27:
  %v116 = getelementptr i64, ptr @"str.60", i64 0
  %v117 = add i64 0, 17
  %v118 = add i64 0, 0
  %v119 = getelementptr i64, ptr %s14, i64 0
  %v120 = ptrtoint ptr %v116 to i64
  %st69 = getelementptr i64, ptr %v119, i64 0
  store i64 %v120, ptr %st69
  %st70 = getelementptr i64, ptr %v119, i64 1
  store i64 %v117, ptr %st70
  %st71 = getelementptr i64, ptr %v119, i64 2
  store i64 %v118, ptr %st71
  call void @"rt.print_str"(ptr %v119)
  br label %b16
b28:
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
