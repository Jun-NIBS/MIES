#pragma rtGlobals=3		// Use modern global access method and strict wave access.

Window DA_Ephys() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /W=(2351,57,2822,761)
	ShowTools/A
	GroupBox group_DataAcq_WholeCell,pos={60,192},size={143,59},title="       Whole Cell"
	GroupBox group_DataAcq_WholeCell,userdata(tabnum)=  "0"
	GroupBox group_DataAcq_WholeCell,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	TitleBox Title_settings_SetManagement,pos={948,-100},size={392,213},disable=1,title="Set Management Decision Tree"
	TitleBox Title_settings_SetManagement,userdata(tabnum)=  "5"
	TitleBox Title_settings_SetManagement,userdata(tabcontrol)=  "ADC"
	TitleBox Title_settings_SetManagement,userdata(ResizeControlsInfo)= A"!!,K)!!'p6J,hsT!!#Adz!!,c)Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_settings_SetManagement,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_settings_SetManagement,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_settings_SetManagement,font="Trebuchet MS",frame=4,fStyle=0
	TitleBox Title_settings_SetManagement,fixedSize=1
	TabControl ADC,pos={3,0},size={479,19},proc=ACL_DisplayTab
	TabControl ADC,userdata(currenttab)=  "0"
	TabControl ADC,userdata(initialhook)=  "DAP_TabTJHook1"
	TabControl ADC,userdata(ResizeControlsInfo)= A"!!,>Mz!!#CTJ,hm&z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TabControl ADC,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TabControl ADC,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TabControl ADC,userdata(tabcontrol)=  "ADC",tabLabel(0)="Data Acquisition"
	TabControl ADC,tabLabel(1)="DA",tabLabel(2)="AD",tabLabel(3)="TTL"
	TabControl ADC,tabLabel(4)="Asynchronous",tabLabel(5)="Settings"
	TabControl ADC,tabLabel(6)="Hardware",value= 0
	CheckBox Check_AD_00,pos={20,75},size={24,14},disable=1,proc=DAP_CheckProc_UnpdateMinSampInt,title="0"
	CheckBox Check_AD_00,help={"hello!"},userdata(tabnum)=  "2"
	CheckBox Check_AD_00,userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_00,userdata(ResizeControlsInfo)= A"!!,B)!!#>F!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_00,value= 1,side= 1
	CheckBox Check_AD_01,pos={20,121},size={24,14},disable=1,title="1"
	CheckBox Check_AD_01,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_01,userdata(ResizeControlsInfo)= A"!!,B)!!#?q!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_01,value= 1,side= 1
	CheckBox Check_AD_02,pos={20,167},size={24,14},disable=1,title="2"
	CheckBox Check_AD_02,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_02,userdata(ResizeControlsInfo)= A"!!,B)!!#@o!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_02,value= 1,side= 1
	CheckBox Check_AD_03,pos={20,214},size={24,14},disable=1,title="3"
	CheckBox Check_AD_03,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_03,userdata(ResizeControlsInfo)= A"!!,B)!!#AI!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_03,value= 0,side= 1
	CheckBox Check_AD_04,pos={20,260},size={24,14},disable=1,title="4"
	CheckBox Check_AD_04,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_04,userdata(ResizeControlsInfo)= A"!!,B)!!#B#!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_04,value= 1,side= 1
	CheckBox Check_AD_05,pos={20,307},size={24,14},disable=1,title="5"
	CheckBox Check_AD_05,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_05,userdata(ResizeControlsInfo)= A"!!,B)!!#BF!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_05,value= 1,side= 1
	CheckBox Check_AD_06,pos={20,353},size={24,14},disable=1,title="6"
	CheckBox Check_AD_06,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_06,userdata(ResizeControlsInfo)= A"!!,B)!!#B]J,hna!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_06,value= 0,side= 1
	CheckBox Check_AD_07,pos={20,400},size={24,14},disable=1,title="7"
	CheckBox Check_AD_07,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_07,userdata(ResizeControlsInfo)= A"!!,B)!!#Bu!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_07,value= 0,side= 1
	CheckBox Check_AD_08,pos={190,75},size={24,14},disable=1,title="8"
	CheckBox Check_AD_08,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_08,userdata(ResizeControlsInfo)= A"!!,G9!!#>F!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_08,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_08,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_08,value= 0,side= 1
	CheckBox Check_AD_09,pos={190,121},size={24,14},disable=1,title="9"
	CheckBox Check_AD_09,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_09,userdata(ResizeControlsInfo)= A"!!,G9!!#?s!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_09,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_09,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_09,value= 0,side= 1
	CheckBox Check_AD_10,pos={184,167},size={30,14},disable=1,title="10"
	CheckBox Check_AD_10,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_10,userdata(ResizeControlsInfo)= A"!!,G9!!#@p!!#>N!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_10,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_10,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_10,value= 0,side= 1
	CheckBox Check_AD_12,pos={184,260},size={30,14},disable=1,title="12"
	CheckBox Check_AD_12,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_12,userdata(ResizeControlsInfo)= A"!!,G9!!#B$!!#>N!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_12,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_12,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_12,value= 0,side= 1
	CheckBox Check_AD_11,pos={184,214},size={30,14},disable=1,title="11"
	CheckBox Check_AD_11,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_11,userdata(ResizeControlsInfo)= A"!!,G9!!#AJ!!#>N!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_11,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_11,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_11,value= 0,side= 1
	SetVariable Gain_AD_00,pos={49,74},size={50,16},disable=1,help={"hello"}
	SetVariable Gain_AD_00,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_00,userdata(ResizeControlsInfo)= A"!!,EF!!#>>!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_00,limits={0,inf,1},value= _NUM:0.00999999977648258
	SetVariable Gain_AD_01,pos={49,120},size={50,16},disable=1
	SetVariable Gain_AD_01,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_01,userdata(ResizeControlsInfo)= A"!!,EF!!#?o!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_01,limits={0,inf,1},value= _NUM:0.000500000023748726
	SetVariable Gain_AD_02,pos={49,166},size={50,16},disable=1
	SetVariable Gain_AD_02,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_02,userdata(ResizeControlsInfo)= A"!!,EF!!#@n!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_02,limits={0,inf,1},value= _NUM:0.00999999977648258
	SetVariable Gain_AD_03,pos={49,212},size={50,16},disable=1
	SetVariable Gain_AD_03,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_03,userdata(ResizeControlsInfo)= A"!!,EF!!#AH!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_03,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_04,pos={49,259},size={50,16},disable=1
	SetVariable Gain_AD_04,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_04,userdata(ResizeControlsInfo)= A"!!,EF!!#B\"!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_04,limits={0,inf,1},value= _NUM:0.00999999977648258
	SetVariable Gain_AD_05,pos={49,305},size={50,16},disable=1
	SetVariable Gain_AD_05,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_05,userdata(ResizeControlsInfo)= A"!!,EF!!#BEJ,hp%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_05,limits={0,inf,1},value= _NUM:0.000500000023748726
	SetVariable Gain_AD_06,pos={49,351},size={50,16},disable=1
	SetVariable Gain_AD_06,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_06,userdata(ResizeControlsInfo)= A"!!,EF!!#B]!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_06,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_07,pos={49,398},size={50,16},disable=1
	SetVariable Gain_AD_07,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_07,userdata(ResizeControlsInfo)= A"!!,EF!!#BtJ,hp%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_07,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_08,pos={218,74},size={50,16},disable=1
	SetVariable Gain_AD_08,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_08,userdata(ResizeControlsInfo)= A"!!,Gp!!#>B!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_08,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_08,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_08,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_09,pos={218,120},size={50,16},disable=1
	SetVariable Gain_AD_09,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_09,userdata(ResizeControlsInfo)= A"!!,Gp!!#?q!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_09,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_09,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_09,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_10,pos={218,166},size={50,16},disable=1
	SetVariable Gain_AD_10,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_10,userdata(ResizeControlsInfo)= A"!!,Gp!!#@o!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_10,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_10,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_10,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_11,pos={218,212},size={50,16},disable=1
	SetVariable Gain_AD_11,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_11,userdata(ResizeControlsInfo)= A"!!,Gp!!#AI!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_11,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_11,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_11,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_12,pos={218,259},size={50,16},disable=1
	SetVariable Gain_AD_12,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_12,userdata(ResizeControlsInfo)= A"!!,Gp!!#B#!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_12,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_12,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_12,limits={0,inf,1},value= _NUM:0
	CheckBox Check_AD_13,pos={184,307},size={30,14},disable=1,title="13"
	CheckBox Check_AD_13,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_13,userdata(ResizeControlsInfo)= A"!!,G9!!#BFJ,ho$!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_13,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_13,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_13,value= 0,side= 1
	CheckBox Check_AD_14,pos={184,353},size={30,14},disable=1,title="14"
	CheckBox Check_AD_14,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_14,userdata(ResizeControlsInfo)= A"!!,G9!!#B^!!#>N!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_14,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_14,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_14,value= 0,side= 1
	CheckBox Check_AD_15,pos={184,400},size={30,14},disable=1,title="15"
	CheckBox Check_AD_15,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AD_15,userdata(ResizeControlsInfo)= A"!!,G9!!#BuJ,ho$!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AD_15,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AD_15,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AD_15,value= 0,side= 1
	SetVariable Gain_AD_13,pos={218,305},size={50,16},disable=1
	SetVariable Gain_AD_13,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_13,userdata(ResizeControlsInfo)= A"!!,Gp!!#BF!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_13,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_13,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_13,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_14,pos={218,351},size={50,16},disable=1
	SetVariable Gain_AD_14,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_14,userdata(ResizeControlsInfo)= A"!!,Gp!!#B]J,hp%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_14,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_14,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_14,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_AD_15,pos={218,398},size={50,16},disable=1
	SetVariable Gain_AD_15,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_AD_15,userdata(ResizeControlsInfo)= A"!!,Gp!!#Bu!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_AD_15,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_AD_15,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_AD_15,limits={0,inf,1},value= _NUM:0.000500000023748726
	CheckBox Check_DA_00,pos={20,75},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="0"
	CheckBox Check_DA_00,help={"hello!"},userdata(tabnum)=  "1"
	CheckBox Check_DA_00,userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_00,userdata(ResizeControlsInfo)= A"!!,B)!!#?M!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_00,value= 1,side= 1
	CheckBox Check_DA_01,pos={20,120},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="1"
	CheckBox Check_DA_01,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_01,userdata(ResizeControlsInfo)= A"!!,B)!!#@T!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_01,value= 1,side= 1
	CheckBox Check_DA_02,pos={20,167},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="2"
	CheckBox Check_DA_02,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_02,userdata(ResizeControlsInfo)= A"!!,B)!!#A6!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_02,value= 1,side= 1
	CheckBox Check_DA_03,pos={20,213},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="3"
	CheckBox Check_DA_03,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_03,userdata(ResizeControlsInfo)= A"!!,B)!!#Ae!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_03,value= 0,side= 1
	CheckBox Check_DA_04,pos={20,258},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="4"
	CheckBox Check_DA_04,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_04,userdata(ResizeControlsInfo)= A"!!,B)!!#B<!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_04,value= 0,side= 1
	CheckBox Check_DA_05,pos={20,305},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="5"
	CheckBox Check_DA_05,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_05,userdata(ResizeControlsInfo)= A"!!,B)!!#BSJ,hna!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_05,value= 0,side= 1
	CheckBox Check_DA_06,pos={20,352},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="6"
	CheckBox Check_DA_06,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_06,userdata(ResizeControlsInfo)= A"!!,B)!!#Bk!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_06,value= 0,side= 1
	CheckBox Check_DA_07,pos={20,399},size={24,14},disable=1,proc=DAP_DAorTTLCheckProc,title="7"
	CheckBox Check_DA_07,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DA_07,userdata(ResizeControlsInfo)= A"!!,B)!!#C-J,hna!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DA_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DA_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DA_07,value= 0,side= 1
	SetVariable Gain_DA_00,pos={47,75},size={40,16},disable=1,help={"hello"}
	SetVariable Gain_DA_00,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_00,userdata(ResizeControlsInfo)= A"!!,EF!!#?M!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_00,limits={0,inf,1},value= _NUM:400
	SetVariable Gain_DA_01,pos={47,120},size={40,16},disable=1
	SetVariable Gain_DA_01,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_01,userdata(ResizeControlsInfo)= A"!!,EF!!#@T!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_01,limits={0,inf,1},value= _NUM:20
	SetVariable Gain_DA_02,pos={47,167},size={40,16},disable=1
	SetVariable Gain_DA_02,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_02,userdata(ResizeControlsInfo)= A"!!,EF!!#A6!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_02,limits={0,inf,1},value= _NUM:400
	SetVariable Gain_DA_03,pos={47,213},size={40,16},disable=1
	SetVariable Gain_DA_03,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_03,userdata(ResizeControlsInfo)= A"!!,EF!!#Ae!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_03,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_DA_04,pos={47,258},size={40,16},disable=1
	SetVariable Gain_DA_04,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_04,userdata(ResizeControlsInfo)= A"!!,EF!!#B<!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_04,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_DA_05,pos={47,305},size={40,16},disable=1
	SetVariable Gain_DA_05,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_05,userdata(ResizeControlsInfo)= A"!!,EF!!#BSJ,hnY!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_05,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_DA_06,pos={47,352},size={40,16},disable=1
	SetVariable Gain_DA_06,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_06,userdata(ResizeControlsInfo)= A"!!,EF!!#Bk!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_06,limits={0,inf,1},value= _NUM:0
	SetVariable Gain_DA_07,pos={47,399},size={40,16},disable=1
	SetVariable Gain_DA_07,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Gain_DA_07,userdata(ResizeControlsInfo)= A"!!,EF!!#C-J,hnY!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Gain_DA_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Gain_DA_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Gain_DA_07,limits={0,inf,1},value= _NUM:20
	PopupMenu Wave_DA_00,pos={123,73},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_00,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_00,userdata(ResizeControlsInfo)= A"!!,FI!!#?I!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_00,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj*AScHs<&8T;?UR1e0KX>iDJ*cs:j$SqAR@hk?SFQ?Bl79G6!l<-+o"
	PopupMenu Wave_DA_00,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_00,fSize=7
	PopupMenu Wave_DA_00,mode=3,popvalue="DeltaT3st_DA_0",value= #"\"- none -;TestPulse;\"+\"DeltaT3st_DA_0;singlePulse_DA_0;Sin_DA_0;\""
	PopupMenu Wave_DA_01,pos={123,118},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_01,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_01,userdata(ResizeControlsInfo)= A"!!,FI!!#@P!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_01,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj*AScHs<&8T;?UR1e0KUH"
	PopupMenu Wave_DA_01,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_01,fSize=7
	PopupMenu Wave_DA_01,mode=3,popvalue="DeltaT3st_DA_0",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Wave_DA_02,pos={123,165},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_02,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_02,userdata(ResizeControlsInfo)= A"!!,FI!!#A4!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_02,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj9:bu$lAT2!E6!l<-+o"
	PopupMenu Wave_DA_02,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_02,fSize=7
	PopupMenu Wave_DA_02,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Wave_DA_03,pos={123,211},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_03,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_03,userdata(ResizeControlsInfo)= A"!!,FI!!#Ac!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_03,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj9:bu$lAT2!E6!l<-7VR$W;flSi?UR1e0KUH"
	PopupMenu Wave_DA_03,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_03,fSize=7
	PopupMenu Wave_DA_03,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Wave_DA_04,pos={123,256},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_04,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_04,userdata(ResizeControlsInfo)= A"!!,FI!!#B;!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_04,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Wave_DA_04,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_04,fSize=7
	PopupMenu Wave_DA_04,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Wave_DA_05,pos={123,303},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_05,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_05,userdata(ResizeControlsInfo)= A"!!,FI!!#BRJ,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_05,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj9:bu$lAT2!E6!l<-7VR$W;flSi?UR1e0KUH"
	PopupMenu Wave_DA_05,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_05,fSize=7
	PopupMenu Wave_DA_05,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Wave_DA_06,pos={123,350},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_06,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_06,userdata(ResizeControlsInfo)= A"!!,FI!!#Bj!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_06,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj9:bu$lAT2!E6!l<-7VR$W;flSi?UR1e0KUH"
	PopupMenu Wave_DA_06,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_06,fSize=7
	PopupMenu Wave_DA_06,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Wave_DA_07,pos={123,397},size={143,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList,title="/V "
	PopupMenu Wave_DA_07,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_DA_07,userdata(ResizeControlsInfo)= A"!!,FI!!#C,J,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_DA_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_DA_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_DA_07,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Wave_DA_07,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Wave_DA_07,fSize=7
	PopupMenu Wave_DA_07,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	SetVariable Scale_DA_00,pos={272,75},size={40,16},disable=1
	SetVariable Scale_DA_00,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_00,userdata(ResizeControlsInfo)= A"!!,H0!!#?M!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_00,value= _NUM:1
	SetVariable Scale_DA_01,pos={272,120},size={40,16},disable=1
	SetVariable Scale_DA_01,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_01,userdata(ResizeControlsInfo)= A"!!,H0!!#@T!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_01,value= _NUM:1
	SetVariable Scale_DA_02,pos={272,167},size={40,16},disable=1
	SetVariable Scale_DA_02,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_02,userdata(ResizeControlsInfo)= A"!!,H0!!#A6!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_02,value= _NUM:1
	SetVariable Scale_DA_03,pos={272,213},size={40,16},disable=1
	SetVariable Scale_DA_03,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_03,userdata(ResizeControlsInfo)= A"!!,H0!!#Ae!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_03,value= _NUM:0
	SetVariable Scale_DA_04,pos={272,258},size={40,16},disable=1
	SetVariable Scale_DA_04,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_04,userdata(ResizeControlsInfo)= A"!!,H0!!#B<!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_04,value= _NUM:1
	SetVariable Scale_DA_05,pos={272,305},size={40,16},disable=1
	SetVariable Scale_DA_05,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_05,userdata(ResizeControlsInfo)= A"!!,H0!!#BSJ,hnY!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_05,value= _NUM:1
	SetVariable Scale_DA_06,pos={272,352},size={40,16},disable=1
	SetVariable Scale_DA_06,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_06,userdata(ResizeControlsInfo)= A"!!,H0!!#Bk!!#>.!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_06,value= _NUM:1
	SetVariable Scale_DA_07,pos={272,399},size={40,16},disable=1
	SetVariable Scale_DA_07,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Scale_DA_07,userdata(ResizeControlsInfo)= A"!!,H0!!#C-J,hnY!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Scale_DA_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Scale_DA_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Scale_DA_07,value= _NUM:1
	SetVariable SetVar_DataAcq_Comment,pos={48,596},size={384,16},title="Comment"
	SetVariable SetVar_DataAcq_Comment,help={"Appends a comment to wave note of next sweep"}
	SetVariable SetVar_DataAcq_Comment,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_Comment,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_Comment,userdata(ResizeControlsInfo)= A"!!,Cp!!#C-J,hsP!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_DataAcq_Comment,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_DataAcq_Comment,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_DataAcq_Comment,fSize=8,value= _STR:""
	Button DataAcquireButton,pos={44,616},size={389,40},proc=DAP_ButtonProc_AcquireData,title="\\Z14\\f01Acquire\rData"
	Button DataAcquireButton,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	Button DataAcquireButton,userdata(ResizeControlsInfo)= A"!!,Ch!!#C6J,hsRJ,ho(z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button DataAcquireButton,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button DataAcquireButton,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	Button DataAcquireButton,labelBack=(60928,60928,60928)
	CheckBox Check_DataAcq1_RepeatAcq,pos={38,507},size={119,14},title="Repeated Acquisition"
	CheckBox Check_DataAcq1_RepeatAcq,help={"Determines number of times a set is repeated, or if indexing is on, the number of times a group of sets in repeated"}
	CheckBox Check_DataAcq1_RepeatAcq,userdata(tabnum)=  "0"
	CheckBox Check_DataAcq1_RepeatAcq,userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq1_RepeatAcq,userdata(ResizeControlsInfo)= A"!!,D'!!#Bb!!#@R!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq1_RepeatAcq,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq1_RepeatAcq,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq1_RepeatAcq,value= 0
	SetVariable SetVar_DataAcq_ITI,pos={87,563},size={77,16},bodyWidth=35,title="\\JCITl (sec)"
	SetVariable SetVar_DataAcq_ITI,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_ITI,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_ITI,userdata(ResizeControlsInfo)= A"!!,GT!!#B\\!!#@6!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_DataAcq_ITI,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_DataAcq_ITI,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_DataAcq_ITI,limits={0,inf,1},value= _NUM:1
	Button StartTestPulseButton,pos={49,309},size={384,40},proc=TP_ButtonProc_DataAcq_TestPulse,title="\\Z14\\f01Start Test \rPulse"
	Button StartTestPulseButton,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	Button StartTestPulseButton,userdata(ResizeControlsInfo)= A"!!,Cp!!#B3!!#C%!!#>Nz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button StartTestPulseButton,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button StartTestPulseButton,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_00,pos={145,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="0"
	CheckBox Check_DataAcq_HS_00,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_00,userdata(ResizeControlsInfo)= A"!!,G$!!#?e!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_00,labelBack=(65280,0,0),value= 1
	SetVariable SetVar_DataAcq_TPDuration,pos={66,288},size={110,16},title="Duration (ms)"
	SetVariable SetVar_DataAcq_TPDuration,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_TPDuration,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_TPDuration,userdata(ResizeControlsInfo)= A"!!,F)!!#Aq!!#@@!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_DataAcq_TPDuration,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_DataAcq_TPDuration,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_DataAcq_TPDuration,limits={1,inf,5},value= _NUM:10
	SetVariable SetVar_DataAcq_TPAmplitude,pos={194,288},size={100,16},title="Amplitude VC"
	SetVariable SetVar_DataAcq_TPAmplitude,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_TPAmplitude,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_TPAmplitude,userdata(ResizeControlsInfo)= A"!!,Ge!!#Aq!!#@@!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_DataAcq_TPAmplitude,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_DataAcq_TPAmplitude,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_DataAcq_TPAmplitude,value= _NUM:5
	CheckBox Check_TTL_00,pos={24,72},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 0"
	CheckBox Check_TTL_00,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_00,userdata(ResizeControlsInfo)= A"!!,C$!!#?I!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_00,value= 0
	CheckBox Check_TTL_01,pos={24,118},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 1"
	CheckBox Check_TTL_01,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_01,userdata(ResizeControlsInfo)= A"!!,C$!!#@P!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_01,value= 0
	CheckBox Check_TTL_02,pos={24,164},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 2"
	CheckBox Check_TTL_02,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_02,userdata(ResizeControlsInfo)= A"!!,C$!!#A3!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_02,value= 0
	CheckBox Check_TTL_03,pos={24,210},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 3"
	CheckBox Check_TTL_03,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_03,userdata(ResizeControlsInfo)= A"!!,C$!!#Aa!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_03,value= 0
	CheckBox Check_TTL_04,pos={24,256},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 4"
	CheckBox Check_TTL_04,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_04,userdata(ResizeControlsInfo)= A"!!,C$!!#B:!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_04,value= 0
	CheckBox Check_TTL_05,pos={24,302},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 5"
	CheckBox Check_TTL_05,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_05,userdata(ResizeControlsInfo)= A"!!,C$!!#BQ!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_05,value= 0
	CheckBox Check_TTL_06,pos={24,348},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 6"
	CheckBox Check_TTL_06,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_06,userdata(ResizeControlsInfo)= A"!!,C$!!#Bh!!#>J!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_06,value= 0
	CheckBox Check_TTL_07,pos={24,395},size={47,14},disable=1,proc=DAP_DAorTTLCheckProc,title="TTL 7"
	CheckBox Check_TTL_07,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	CheckBox Check_TTL_07,userdata(ResizeControlsInfo)= A"!!,C$!!#C*J,hnu!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_TTL_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_TTL_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_TTL_07,value= 0
	PopupMenu Wave_TTL_00,pos={103,69},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_00,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_00,userdata(ResizeControlsInfo)= A"!!,F3!!#?C!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_00,userdata(MenExp)= A"+tXpTDf0,//NY.,,#:s@<)cOu0KUH"
	PopupMenu Wave_TTL_00,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_00,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_01,pos={103,115},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_01,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_01,userdata(ResizeControlsInfo)= A"!!,F3!!#@J!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_01,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_01,userdata(MenExp)= A"+tXpTDf0,//NY.,,#:s@<)cOu0KUH"
	PopupMenu Wave_TTL_01,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_02,pos={103,161},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_02,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_02,userdata(ResizeControlsInfo)= A"!!,F3!!#A0!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_02,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_02,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Wave_TTL_02,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_03,pos={103,207},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_03,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_03,userdata(ResizeControlsInfo)= A"!!,F3!!#A^!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_03,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_03,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Wave_TTL_03,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_04,pos={103,253},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_04,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_04,userdata(ResizeControlsInfo)= A"!!,F3!!#B7!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_04,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_04,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Wave_TTL_04,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_05,pos={103,299},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_05,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_05,userdata(ResizeControlsInfo)= A"!!,F3!!#BOJ,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_05,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_05,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Wave_TTL_05,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_06,pos={103,345},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_06,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_06,userdata(ResizeControlsInfo)= A"!!,F3!!#BfJ,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_06,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_06,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Wave_TTL_06,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Wave_TTL_07,pos={103,392},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Wave_TTL_07,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	PopupMenu Wave_TTL_07,userdata(ResizeControlsInfo)= A"!!,F3!!#C)!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Wave_TTL_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Wave_TTL_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Wave_TTL_07,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Wave_TTL_07,userdata(MenExp)= A"+tXpTDf0,//NY.,,#:s@<)cOu0KUH"
	PopupMenu Wave_TTL_07,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	CheckBox Check_Settings_TrigOut,pos={34,212},size={56,14},disable=1,title="\\JCTrig Out"
	CheckBox Check_Settings_TrigOut,help={"Turns on TTL pulse at onset of sweep"}
	CheckBox Check_Settings_TrigOut,userdata(tabnum)=  "5"
	CheckBox Check_Settings_TrigOut,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_TrigOut,userdata(ResizeControlsInfo)= A"!!,H&!!#>n!!#>n!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_TrigOut,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_TrigOut,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_TrigOut,fColor=(65280,43520,0),value= 0
	CheckBox Check_Settings_TrigIn,pos={34,232},size={48,14},disable=1,title="\\JCTrig In"
	CheckBox Check_Settings_TrigIn,help={"Starts Data Aquisition with TTL signal to trig in port on rack"}
	CheckBox Check_Settings_TrigIn,userdata(tabnum)=  "5"
	CheckBox Check_Settings_TrigIn,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_TrigIn,userdata(ResizeControlsInfo)= A"!!,H&!!#?K!!#>N!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_TrigIn,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_TrigIn,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_TrigIn,fColor=(65280,43520,0),value= 0
	SetVariable SetVar_DataAcq_SetRepeats,pos={60,543},size={104,16},bodyWidth=35,proc=DAP_SetVarProc_TotSweepCount,title="Repeat Set(s)"
	SetVariable SetVar_DataAcq_SetRepeats,help={"This number is set automatically at based on the number of 1d waves contained in the largest set on active DA/TTL channels"}
	SetVariable SetVar_DataAcq_SetRepeats,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_SetRepeats,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_SetRepeats,userdata(ResizeControlsInfo)= A"!!,GX!!#BlJ,hpW!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_DataAcq_SetRepeats,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_DataAcq_SetRepeats,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_DataAcq_SetRepeats,limits={1,inf,1},value= _NUM:1
	ValDisplay ValDisp_DataAcq_SamplingInt,pos={218,442},size={30,17},bodyWidth=30
	ValDisplay ValDisp_DataAcq_SamplingInt,userdata(tabnum)=  "0"
	ValDisplay ValDisp_DataAcq_SamplingInt,userdata(tabcontrol)=  "ADC"
	ValDisplay ValDisp_DataAcq_SamplingInt,userdata(ResizeControlsInfo)= A"!!,H>J,hqh!!#@,!!#=3z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	ValDisplay ValDisp_DataAcq_SamplingInt,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	ValDisplay ValDisp_DataAcq_SamplingInt,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	ValDisplay ValDisp_DataAcq_SamplingInt,fSize=14,fStyle=0
	ValDisplay ValDisp_DataAcq_SamplingInt,valueColor=(65535,65535,65535)
	ValDisplay ValDisp_DataAcq_SamplingInt,valueBackColor=(0,0,0)
	ValDisplay ValDisp_DataAcq_SamplingInt,limits={0,0,0},barmisc={0,1000}
	ValDisplay ValDisp_DataAcq_SamplingInt,value= _NUM:15
	CheckBox Check_Settings_DownSamp,pos={34,190},size={84,14},disable=1,proc=CheckProc,title="Down Sample"
	CheckBox Check_Settings_DownSamp,userdata(tabnum)=  "5"
	CheckBox Check_Settings_DownSamp,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_DownSamp,userdata(ResizeControlsInfo)= A"!!,Ch!!#>n!!#>b!!#=3z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_DownSamp,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_DownSamp,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_DownSamp,fColor=(65280,43520,0),value= 0
	SetVariable SetVar_DownSamp,pos={129,189},size={182,16},disable=1,proc=DAP_SetVarProc_DownSampLimit,title="Desired Sample Interval (�S)"
	SetVariable SetVar_DownSamp,userdata(tabnum)=  "5",userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DownSamp,userdata(ResizeControlsInfo)= A"!!,F'!!#>n!!#@T!!#=Sz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_DownSamp,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_DownSamp,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_DownSamp,fColor=(65280,43520,0)
	SetVariable SetVar_DownSamp,limits={0,inf,1},value= _NUM:5
	SetVariable SetVar_Sweep,pos={200,400},size={75,32},bodyWidth=75,proc=DAP_SetVarProc_NextSweepLimit
	SetVariable SetVar_Sweep,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Sweep,userdata(ResizeControlsInfo)= A"!!,DW!!#A<!!#AO!!#=Cz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Sweep,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Sweep,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Sweep,fSize=24,fStyle=1,valueColor=(65535,65535,65535)
	SetVariable SetVar_Sweep,valueBackColor=(0,0,0),limits={0,40,1},value= _NUM:0
	CheckBox Check_Settings_SaveData,pos={34,167},size={106,14},disable=1,proc=DAP_CheckProc_SaveData,title="Do Not Save Data"
	CheckBox Check_Settings_SaveData,help={"Use cautiously - intended primarily for software development"}
	CheckBox Check_Settings_SaveData,userdata(tabnum)=  "5"
	CheckBox Check_Settings_SaveData,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_SaveData,userdata(ResizeControlsInfo)= A"!!,HT!!#?-!!#?C!!#=3z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_SaveData,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_SaveData,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_SaveData,value= 0
	CheckBox Check_AsyncAD_00,pos={172,46},size={42,14},disable=1,title="AD 0"
	CheckBox Check_AsyncAD_00,help={"hello!"},userdata(tabnum)=  "4"
	CheckBox Check_AsyncAD_00,userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_00,userdata(ResizeControlsInfo)= A"!!,G<!!#>F!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_00,value= 0
	CheckBox Check_AsyncAD_01,pos={171,97},size={42,14},disable=1,title="AD 1"
	CheckBox Check_AsyncAD_01,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_01,userdata(ResizeControlsInfo)= A"!!,G;!!#@&!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_01,value= 0
	CheckBox Check_AsyncAD_02,pos={171,148},size={42,14},disable=1,title="AD 2"
	CheckBox Check_AsyncAD_02,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_02,userdata(ResizeControlsInfo)= A"!!,G;!!#A#!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_02,value= 0
	CheckBox Check_AsyncAD_03,pos={171,199},size={42,14},disable=1,title="AD 3"
	CheckBox Check_AsyncAD_03,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_03,userdata(ResizeControlsInfo)= A"!!,G;!!#AV!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_03,value= 0
	CheckBox Check_AsyncAD_04,pos={171,250},size={42,14},disable=1,title="AD 4"
	CheckBox Check_AsyncAD_04,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_04,userdata(ResizeControlsInfo)= A"!!,G;!!#B4!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_04,value= 0
	CheckBox Check_AsyncAD_05,pos={171,301},size={42,14},disable=1,title="AD 5"
	CheckBox Check_AsyncAD_05,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_05,userdata(ResizeControlsInfo)= A"!!,G;!!#BPJ,hna!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_05,value= 0
	CheckBox Check_AsyncAD_06,pos={171,352},size={42,14},disable=1,title="AD 6"
	CheckBox Check_AsyncAD_06,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_06,userdata(ResizeControlsInfo)= A"!!,G;!!#Bj!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_06,value= 0
	CheckBox Check_AsyncAD_07,pos={171,404},size={42,14},disable=1,title="AD 7"
	CheckBox Check_AsyncAD_07,userdata(tabnum)=  "4",userdata(tabcontrol)=  "ADC"
	CheckBox Check_AsyncAD_07,userdata(ResizeControlsInfo)= A"!!,G;!!#C/!!#>6!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_AsyncAD_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_AsyncAD_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_AsyncAD_07,value= 0
	SetVariable SetVar_AsyncAD_Gain_00,pos={226,44},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_00,help={"hello"},userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_00,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_00,userdata(ResizeControlsInfo)= A"!!,Gr!!#>>!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_00,limits={0,inf,1},value= _NUM:1
	SetVariable SetVar_AsyncAD_Gain_01,pos={226,95},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_01,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_01,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_01,userdata(ResizeControlsInfo)= A"!!,Gr!!#@\"!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_01,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_AsyncAD_Gain_02,pos={226,146},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_02,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_02,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_02,userdata(ResizeControlsInfo)= A"!!,Gr!!#A!!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_02,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_AsyncAD_Gain_03,pos={226,197},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_03,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_03,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_03,userdata(ResizeControlsInfo)= A"!!,Gr!!#AT!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_03,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_AsyncAD_Gain_04,pos={226,248},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_04,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_04,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_04,userdata(ResizeControlsInfo)= A"!!,Gr!!#B2!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_04,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_AsyncAD_Gain_05,pos={226,299},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_05,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_05,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_05,userdata(ResizeControlsInfo)= A"!!,Gr!!#BOJ,hp%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_05,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_AsyncAD_Gain_06,pos={226,350},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_06,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_06,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_06,userdata(ResizeControlsInfo)= A"!!,Gr!!#Bi!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_06,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_AsyncAD_Gain_07,pos={226,402},size={75,16},disable=1,title="gain"
	SetVariable SetVar_AsyncAD_Gain_07,userdata(tabnum)=  "4"
	SetVariable SetVar_AsyncAD_Gain_07,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_AsyncAD_Gain_07,userdata(ResizeControlsInfo)= A"!!,Gr!!#C.!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_AsyncAD_Gain_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_AsyncAD_Gain_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_AsyncAD_Gain_07,limits={0,inf,1},value= _NUM:0
	SetVariable SetVar_Async_Title_00,pos={14,44},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_00,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_00,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_00,userdata(ResizeControlsInfo)= A"!!,An!!#>>!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_00,value= _STR:""
	SetVariable SetVar_Async_Title_01,pos={14,95},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_01,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_01,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_01,userdata(ResizeControlsInfo)= A"!!,An!!#@\"!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_01,value= _STR:""
	SetVariable SetVar_Async_Title_02,pos={14,146},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_02,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_02,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_02,userdata(ResizeControlsInfo)= A"!!,An!!#A!!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_02,value= _STR:""
	SetVariable SetVar_Async_Title_03,pos={14,197},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_03,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_03,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_03,userdata(ResizeControlsInfo)= A"!!,An!!#AT!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_03,value= _STR:""
	SetVariable SetVar_Async_Title_04,pos={14,248},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_04,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_04,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_04,userdata(ResizeControlsInfo)= A"!!,An!!#B2!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_04,value= _STR:""
	SetVariable SetVar_Async_Title_05,pos={14,299},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_05,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_05,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_05,userdata(ResizeControlsInfo)= A"!!,An!!#BOJ,hqP!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_05,value= _STR:""
	SetVariable SetVar_Async_Title_06,pos={14,350},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_06,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_06,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_06,userdata(ResizeControlsInfo)= A"!!,An!!#Bi!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_06,value= _STR:""
	SetVariable SetVar_Async_Title_07,pos={14,402},size={150,16},disable=1,title="Title"
	SetVariable SetVar_Async_Title_07,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Title_07,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Title_07,userdata(ResizeControlsInfo)= A"!!,An!!#C.!!#A%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Title_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Title_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Title_07,value= _STR:""
	SetVariable SetVar_Async_Unit_00,pos={315,44},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_00,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_00,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_00,userdata(ResizeControlsInfo)= A"!!,HXJ,hni!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_00,value= _STR:""
	SetVariable SetVar_Async_Unit_01,pos={315,95},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_01,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_01,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_01,userdata(ResizeControlsInfo)= A"!!,HXJ,hpM!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_01,value= _STR:""
	SetVariable SetVar_Async_Unit_02,pos={315,146},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_02,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_02,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_02,userdata(ResizeControlsInfo)= A"!!,HXJ,hqL!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_02,value= _STR:""
	SetVariable SetVar_Async_Unit_03,pos={315,197},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_03,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_03,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_03,userdata(ResizeControlsInfo)= A"!!,HXJ,hr*!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_03,value= _STR:""
	SetVariable SetVar_Async_Unit_04,pos={315,248},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_04,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_04,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_04,userdata(ResizeControlsInfo)= A"!!,HXJ,hr]!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_04,value= _STR:""
	SetVariable SetVar_Async_Unit_05,pos={315,299},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_05,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_05,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_05,userdata(ResizeControlsInfo)= A"!!,HXJ,hs%J,hp%!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_05,value= _STR:""
	SetVariable SetVar_Async_Unit_06,pos={315,350},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_06,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_06,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_06,userdata(ResizeControlsInfo)= A"!!,HXJ,hs?!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_06,value= _STR:""
	SetVariable SetVar_Async_Unit_07,pos={315,402},size={75,16},disable=1,title="Unit"
	SetVariable SetVar_Async_Unit_07,userdata(tabnum)=  "4"
	SetVariable SetVar_Async_Unit_07,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Async_Unit_07,userdata(ResizeControlsInfo)= A"!!,HXJ,hsY!!#?O!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable SetVar_Async_Unit_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable SetVar_Async_Unit_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable SetVar_Async_Unit_07,value= _STR:""
	CheckBox Check_Settings_Append,pos={34,372},size={222,14},disable=1,title="\\JCAppend Asynchronus reading to wave note"
	CheckBox Check_Settings_Append,help={"Turns on TTL pulse at onset of sweep"}
	CheckBox Check_Settings_Append,userdata(tabnum)=  "5"
	CheckBox Check_Settings_Append,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_Append,userdata(ResizeControlsInfo)= A"!!,Ch!!#A-!!#Am!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_Append,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_Append,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_Append,value= 0
	CheckBox Check_Settings_BkgTP,pos={34,48},size={129,14},disable=1,title="Background Test Pulse"
	CheckBox Check_Settings_BkgTP,help={"Use cautiously - intended primarily for software development"}
	CheckBox Check_Settings_BkgTP,userdata(tabnum)=  "5"
	CheckBox Check_Settings_BkgTP,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_BkgTP,userdata(ResizeControlsInfo)= A"!!,Gn!!#?o!!#@e!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_BkgTP,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_BkgTP,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_BkgTP,value= 1
	CheckBox Check_Settings_BackgrndDataAcq,pos={34,123},size={156,14},disable=1,title="Background Data Acquisition"
	CheckBox Check_Settings_BackgrndDataAcq,help={"You may notice that onscreen update isn't as smooth with background data acquisition. This is normal and unavoidable."}
	CheckBox Check_Settings_BackgrndDataAcq,userdata(tabnum)=  "5"
	CheckBox Check_Settings_BackgrndDataAcq,userdata(tabcontrol)=  "ADC"
	CheckBox Check_Settings_BackgrndDataAcq,userdata(ResizeControlsInfo)= A"!!,Ch!!#?k!!#A+!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_Settings_BackgrndDataAcq,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_Settings_BackgrndDataAcq,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_Settings_BackgrndDataAcq,value= 0
	CheckBox Radio_ClampMode_0,pos={145,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_0,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_0,userdata(ResizeControlsInfo)= A"!!,G$!!#?1!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_0,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_0,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_0,value= 0,mode=1
	TitleBox Title_DataAcq_VC,pos={62,65},size={68,13},title="Voltage Clamp"
	TitleBox Title_DataAcq_VC,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	TitleBox Title_DataAcq_VC,userdata(ResizeControlsInfo)= A"!!,Ds!!#?;!!#?A!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DataAcq_VC,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DataAcq_VC,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DataAcq_VC,frame=0
	TitleBox Title_DataAcq_IC,pos={62,109},size={66,13},title="Current Clamp"
	TitleBox Title_DataAcq_IC,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	TitleBox Title_DataAcq_IC,userdata(ResizeControlsInfo)= A"!!,Ds!!#@>!!#?=!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DataAcq_IC,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DataAcq_IC,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DataAcq_IC,frame=0
	TitleBox Title_DataAcq_CellSelection,pos={77,87},size={52,13},title="Headstage"
	TitleBox Title_DataAcq_CellSelection,userdata(tabnum)=  "0"
	TitleBox Title_DataAcq_CellSelection,userdata(tabcontrol)=  "ADC"
	TitleBox Title_DataAcq_CellSelection,userdata(ResizeControlsInfo)= A"!!,EJ!!#?g!!#>^!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DataAcq_CellSelection,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DataAcq_CellSelection,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DataAcq_CellSelection,frame=0
	CheckBox Check_DataAcq_HS_01,pos={178,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="1"
	CheckBox Check_DataAcq_HS_01,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_01,userdata(ResizeControlsInfo)= A"!!,GE!!#?e!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_01,value= 1
	CheckBox Check_DataAcq_HS_02,pos={212,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="2"
	CheckBox Check_DataAcq_HS_02,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_02,userdata(ResizeControlsInfo)= A"!!,Gg!!#?e!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_02,value= 1
	CheckBox Check_DataAcq_HS_03,pos={246,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="3"
	CheckBox Check_DataAcq_HS_03,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_03,userdata(ResizeControlsInfo)= A"!!,H4!!#?e!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_03,value= 0
	CheckBox Check_DataAcq_HS_04,pos={280,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="4"
	CheckBox Check_DataAcq_HS_04,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_04,userdata(ResizeControlsInfo)= A"!!,HHJ,hp;!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_04,value= 0
	CheckBox Check_DataAcq_HS_05,pos={314,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="5"
	CheckBox Check_DataAcq_HS_05,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_05,userdata(ResizeControlsInfo)= A"!!,HYJ,hp;!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_05,value= 0
	CheckBox Check_DataAcq_HS_06,pos={348,86},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="6"
	CheckBox Check_DataAcq_HS_06,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_06,userdata(ResizeControlsInfo)= A"!!,HjJ,hp;!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_06,value= 0
	CheckBox Check_DataAcq_HS_07,pos={382,85},size={24,14},proc=DAP_CheckProc_HedstgeChck,title="7"
	CheckBox Check_DataAcq_HS_07,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_HS_07,userdata(ResizeControlsInfo)= A"!!,I&J,hp9!!#=#!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_HS_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_HS_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_HS_07,value= 0
	CheckBox Radio_ClampMode_1,pos={145,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_1,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_1,userdata(ResizeControlsInfo)= A"!!,G$!!#@B!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_1,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_1,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_1,value= 1,mode=1
	CheckBox Radio_ClampMode_2,pos={178,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_2,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_2,userdata(ResizeControlsInfo)= A"!!,GE!!#?1!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_2,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_2,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_2,value= 1,mode=1
	CheckBox Radio_ClampMode_3,pos={178,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_3,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_3,userdata(ResizeControlsInfo)= A"!!,GE!!#@B!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_3,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_3,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_3,value= 0,mode=1
	CheckBox Radio_ClampMode_4,pos={212,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_4,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_4,userdata(ResizeControlsInfo)= A"!!,Gg!!#?1!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_4,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_4,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_4,value= 0,mode=1
	CheckBox Radio_ClampMode_5,pos={212,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_5,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_5,userdata(ResizeControlsInfo)= A"!!,Gg!!#@B!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_5,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_5,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_5,value= 1,mode=1
	CheckBox Radio_ClampMode_6,pos={246,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_6,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_6,userdata(ResizeControlsInfo)= A"!!,H4!!#?1!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_6,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_6,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_6,value= 1,mode=1
	CheckBox Radio_ClampMode_7,pos={246,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_7,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_7,userdata(ResizeControlsInfo)= A"!!,H4!!#@B!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_7,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_7,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_7,value= 0,mode=1
	CheckBox Radio_ClampMode_8,pos={280,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_8,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_8,userdata(ResizeControlsInfo)= A"!!,HHJ,ho\\!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_8,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_8,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_8,value= 1,mode=1
	CheckBox Radio_ClampMode_9,pos={280,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_9,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_9,userdata(ResizeControlsInfo)= A"!!,HHJ,hpm!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_9,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_9,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_9,value= 0,mode=1
	CheckBox Radio_ClampMode_10,pos={314,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_10,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_10,userdata(ResizeControlsInfo)= A"!!,HYJ,ho\\!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_10,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_10,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_10,value= 1,mode=1
	CheckBox Radio_ClampMode_11,pos={314,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_11,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_11,userdata(ResizeControlsInfo)= A"!!,HYJ,hpm!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_11,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_11,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_11,value= 0,mode=1
	CheckBox Radio_ClampMode_12,pos={348,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_12,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_12,userdata(ResizeControlsInfo)= A"!!,HjJ,ho\\!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_12,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_12,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_12,value= 1,mode=1
	CheckBox Radio_ClampMode_13,pos={348,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_13,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_13,userdata(ResizeControlsInfo)= A"!!,HjJ,hpm!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_13,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_13,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_13,value= 0,mode=1
	CheckBox Radio_ClampMode_14,pos={382,62},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_14,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_14,userdata(ResizeControlsInfo)= A"!!,I&J,ho\\!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_14,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_14,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_14,value= 1,mode=1
	CheckBox Radio_ClampMode_15,pos={382,111},size={16,14},proc=DAP_CheckProc_ClampMode,title=""
	CheckBox Radio_ClampMode_15,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	CheckBox Radio_ClampMode_15,userdata(ResizeControlsInfo)= A"!!,I&J,hpm!!#<8!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Radio_ClampMode_15,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Radio_ClampMode_15,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Radio_ClampMode_15,value= 0,mode=1
	PopupMenu Popup_Settings_VC_DA,pos={32,423},size={53,21},disable=1,proc=DAP_PopMenuProc_CAA,title="DA"
	PopupMenu Popup_Settings_VC_DA,userdata(tabnum)=  "6"
	PopupMenu Popup_Settings_VC_DA,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_Settings_VC_DA,userdata(ResizeControlsInfo)= A"!!,Cp!!#BB!!#>b!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_Settings_VC_DA,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_Settings_VC_DA,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_Settings_VC_DA,mode=8,popvalue="7",value= #"\"0;1;2;3;4;5;6;7\""
	PopupMenu Popup_Settings_VC_AD,pos={32,448},size={59,21},disable=1,proc=DAP_PopMenuProc_CAA,title="AD"
	PopupMenu Popup_Settings_VC_AD,userdata(tabnum)=  "6"
	PopupMenu Popup_Settings_VC_AD,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_Settings_VC_AD,userdata(ResizeControlsInfo)= A"!!,Cp!!#BMJ,ho8!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_Settings_VC_AD,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_Settings_VC_AD,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_Settings_VC_AD,mode=16,popvalue="15",value= #"\"0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15\""
	PopupMenu Popup_Settings_IC_AD,pos={212,448},size={53,21},disable=1,proc=DAP_PopMenuProc_CAA,title="AD"
	PopupMenu Popup_Settings_IC_AD,userdata(tabnum)=  "6"
	PopupMenu Popup_Settings_IC_AD,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_Settings_IC_AD,userdata(ResizeControlsInfo)= A"!!,G%!!#BMJ,ho8!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_Settings_IC_AD,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_Settings_IC_AD,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_Settings_IC_AD,mode=5,popvalue="4",value= #"\"0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15\""
	SetVariable setvar_Settings_VC_DAgain,pos={93,425},size={50,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable setvar_Settings_VC_DAgain,userdata(tabnum)=  "6"
	SetVariable setvar_Settings_VC_DAgain,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Settings_VC_DAgain,userdata(ResizeControlsInfo)= A"!!,F!!!#BCJ,ho,!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Settings_VC_DAgain,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Settings_VC_DAgain,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Settings_VC_DAgain,value= _NUM:20
	SetVariable setvar_Settings_VC_ADgain,pos={93,450},size={50,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable setvar_Settings_VC_ADgain,userdata(tabnum)=  "6"
	SetVariable setvar_Settings_VC_ADgain,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Settings_VC_ADgain,userdata(ResizeControlsInfo)= A"!!,F!!!#BO!!#>V!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Settings_VC_ADgain,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Settings_VC_ADgain,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Settings_VC_ADgain,value= _NUM:0.000500000023748726
	SetVariable setvar_Settings_IC_ADgain,pos={273,450},size={50,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable setvar_Settings_IC_ADgain,userdata(tabnum)=  "6"
	SetVariable setvar_Settings_IC_ADgain,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Settings_IC_ADgain,userdata(ResizeControlsInfo)= A"!!,G`!!#BO!!#>V!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Settings_IC_ADgain,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Settings_IC_ADgain,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Settings_IC_ADgain,value= _NUM:0.00999999977648258
	PopupMenu Popup_Settings_HeadStage,pos={32,341},size={95,21},disable=1,proc=DAP_PopMenuProc_Headstage,title="Head Stage"
	PopupMenu Popup_Settings_HeadStage,userdata(tabnum)=  "6"
	PopupMenu Popup_Settings_HeadStage,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_Settings_HeadStage,userdata(ResizeControlsInfo)= A"!!,Cp!!#As!!#@\"!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_Settings_HeadStage,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_Settings_HeadStage,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_Settings_HeadStage,mode=3,popvalue="2",value= #"\"0;1;2;3;4;5;6;7\""
	PopupMenu popup_Settings_Amplifier,pos={32,370},size={224,21},bodyWidth=150,disable=1,proc=DAP_PopMenuProc_CAA,title="Amplfier (700B)"
	PopupMenu popup_Settings_Amplifier,userdata(tabnum)=  "6"
	PopupMenu popup_Settings_Amplifier,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_Settings_Amplifier,userdata(ResizeControlsInfo)= A"!!,G8!!#As!!#Ao!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu popup_Settings_Amplifier,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu popup_Settings_Amplifier,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu popup_Settings_Amplifier,mode=2,popvalue="AmpNo 834000 Chan 1",value= #"\" - none - ;AmpNo 834000 Chan 1;AmpNo 834000 Chan 2;\""
	PopupMenu Popup_Settings_IC_DA,pos={212,423},size={53,21},disable=1,proc=DAP_PopMenuProc_CAA,title="DA"
	PopupMenu Popup_Settings_IC_DA,userdata(tabnum)=  "6"
	PopupMenu Popup_Settings_IC_DA,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_Settings_IC_DA,userdata(ResizeControlsInfo)= A"!!,G%!!#BB!!#>b!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_Settings_IC_DA,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_Settings_IC_DA,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_Settings_IC_DA,mode=3,popvalue="2",value= #"\"0;1;2;3;4;5;6;7\""
	SetVariable setvar_Settings_IC_DAgain,pos={274,425},size={50,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable setvar_Settings_IC_DAgain,userdata(tabnum)=  "6"
	SetVariable setvar_Settings_IC_DAgain,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Settings_IC_DAgain,userdata(ResizeControlsInfo)= A"!!,G`!!#BCJ,ho,!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Settings_IC_DAgain,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Settings_IC_DAgain,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Settings_IC_DAgain,value= _NUM:400
	TitleBox Title_settings_Hardware_VC,pos={43,407},size={39,13},disable=1,title="V-Clamp"
	TitleBox Title_settings_Hardware_VC,userdata(tabnum)=  "6"
	TitleBox Title_settings_Hardware_VC,userdata(tabcontrol)=  "ADC"
	TitleBox Title_settings_Hardware_VC,userdata(ResizeControlsInfo)= A"!!,EP!!#B7!!#>*!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_settings_Hardware_VC,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_settings_Hardware_VC,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_settings_Hardware_VC,frame=0
	TitleBox Title_settings_ChanlAssign_IC,pos={225,407},size={35,13},disable=1,title="I-Clamp"
	TitleBox Title_settings_ChanlAssign_IC,userdata(tabnum)=  "6"
	TitleBox Title_settings_ChanlAssign_IC,userdata(tabcontrol)=  "ADC"
	TitleBox Title_settings_ChanlAssign_IC,userdata(ResizeControlsInfo)= A"!!,GF!!#B7!!#=o!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_settings_ChanlAssign_IC,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_settings_ChanlAssign_IC,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_settings_ChanlAssign_IC,frame=0
	Button button_Settings_UpdateAmpStatus,pos={262,370},size={150,20},disable=1,proc=DAP_FindConnectedAmps,title="Query connected Amp(s)"
	Button button_Settings_UpdateAmpStatus,userdata(tabnum)=  "6"
	Button button_Settings_UpdateAmpStatus,userdata(tabcontrol)=  "ADC"
	Button button_Settings_UpdateAmpStatus,userdata(ResizeControlsInfo)= A"!!,HL!!#B8!!#@,!!#=Sz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_Settings_UpdateAmpStatus,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button button_Settings_UpdateAmpStatus,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_00,pos={141,98},size={124,16},disable=3,title="Search string"
	SetVariable Search_DA_00,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_00,userdata(ResizeControlsInfo)= A"!!,FI!!#@&!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_00,value= _STR:"test"
	SetVariable Search_DA_01,pos={141,145},size={124,16},disable=3,title="Search string"
	SetVariable Search_DA_01,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_01,userdata(ResizeControlsInfo)= A"!!,FI!!#@t!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_01,value= _STR:""
	SetVariable Search_DA_02,pos={141,191},size={124,16},disable=3,proc=DAP_SetVarProc_DASearch,title="Search string"
	SetVariable Search_DA_02,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_02,userdata(ResizeControlsInfo)= A"!!,FI!!#AN!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_02,value= _STR:""
	SetVariable Search_DA_03,pos={141,237},size={124,16},disable=3,proc=DAP_SetVarProc_DASearch,title="Search string"
	SetVariable Search_DA_03,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_03,userdata(ResizeControlsInfo)= A"!!,FI!!#B(!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_03,value= _STR:""
	SetVariable Search_DA_04,pos={141,282},size={124,16},disable=3,proc=DAP_SetVarProc_DASearch,title="Search string"
	SetVariable Search_DA_04,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_04,userdata(ResizeControlsInfo)= A"!!,FI!!#BH!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_04,value= _STR:""
	SetVariable Search_DA_05,pos={141,329},size={124,16},disable=3,proc=DAP_SetVarProc_DASearch,title="Search string"
	SetVariable Search_DA_05,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_05,userdata(ResizeControlsInfo)= A"!!,FI!!#B_J,hq2!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_05,value= _STR:""
	SetVariable Search_DA_06,pos={141,376},size={124,16},disable=3,proc=DAP_SetVarProc_DASearch,title="Search string"
	SetVariable Search_DA_06,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_06,userdata(ResizeControlsInfo)= A"!!,FI!!#C\"!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_06,value= _STR:""
	SetVariable Search_DA_07,pos={141,424},size={124,16},disable=3,proc=DAP_SetVarProc_DASearch,title="Search string"
	SetVariable Search_DA_07,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Search_DA_07,userdata(ResizeControlsInfo)= A"!!,FI!!#C:!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_DA_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_DA_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_DA_07,value= _STR:""
	CheckBox SearchUniversal_DA_00,pos={273,99},size={69,14},disable=3,proc=DAP_CheckProc_UnivrslSrchStr,title="Apply to all"
	CheckBox SearchUniversal_DA_00,userdata(tabnum)=  "1"
	CheckBox SearchUniversal_DA_00,userdata(tabcontrol)=  "ADC"
	CheckBox SearchUniversal_DA_00,userdata(ResizeControlsInfo)= A"!!,H1!!#@(!!#?C!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox SearchUniversal_DA_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox SearchUniversal_DA_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox SearchUniversal_DA_00,value= 0
	SetVariable Search_TTL_00,pos={102,94},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_00,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_00,userdata(ResizeControlsInfo)= A"!!,F1!!#?u!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_00,value= _STR:""
	SetVariable Search_TTL_01,pos={102,140},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_01,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_01,userdata(ResizeControlsInfo)= A"!!,F1!!#@p!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_01,value= _STR:""
	SetVariable Search_TTL_02,pos={102,187},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_02,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_02,userdata(ResizeControlsInfo)= A"!!,F1!!#AJ!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_02,value= _STR:""
	SetVariable Search_TTL_03,pos={99,234},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_03,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_03,userdata(ResizeControlsInfo)= A"!!,F1!!#B#!!#@\\!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_03,value= _STR:""
	SetVariable Search_TTL_04,pos={102,279},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_04,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_04,userdata(ResizeControlsInfo)= A"!!,F1!!#BEJ,hq2!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_04,value= _STR:""
	SetVariable Search_TTL_05,pos={102,325},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_05,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_05,userdata(ResizeControlsInfo)= A"!!,F1!!#B\\J,hq2!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_05,value= _STR:""
	SetVariable Search_TTL_06,pos={102,371},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_06,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_06,userdata(ResizeControlsInfo)= A"!!,F1!!#BsJ,hq2!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_06,value= _STR:""
	SetVariable Search_TTL_07,pos={102,419},size={124,16},disable=3,proc=DAP_SetVarProc_TTLSearch,title="Search string"
	SetVariable Search_TTL_07,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	SetVariable Search_TTL_07,userdata(ResizeControlsInfo)= A"!!,F1!!#C6J,hq2!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable Search_TTL_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable Search_TTL_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable Search_TTL_07,value= _STR:""
	CheckBox SearchUniversal_TTL_00,pos={235,96},size={69,14},disable=3,proc=DAP_CheckProc_UnivrslSrchTTL,title="Apply to all"
	CheckBox SearchUniversal_TTL_00,userdata(tabnum)=  "3"
	CheckBox SearchUniversal_TTL_00,userdata(tabcontrol)=  "ADC"
	CheckBox SearchUniversal_TTL_00,userdata(ResizeControlsInfo)= A"!!,H&!!#@\"!!#?C!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox SearchUniversal_TTL_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox SearchUniversal_TTL_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox SearchUniversal_TTL_00,value= 0
	CheckBox Check_DataAcq_Indexing,pos={178,523},size={58,14},proc=DAP_CheckProc_IndexingState,title="Indexing"
	CheckBox Check_DataAcq_Indexing,help={"Data acquisition proceeds to next wave in DAC or TTL popup menu list"}
	CheckBox Check_DataAcq_Indexing,userdata(tabnum)=  "0"
	CheckBox Check_DataAcq_Indexing,userdata(tabcontrol)=  "ADC"
	CheckBox Check_DataAcq_Indexing,userdata(ResizeControlsInfo)= A"!!,F-!!#BjJ,hoL!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox Check_DataAcq_Indexing,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox Check_DataAcq_Indexing,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox Check_DataAcq_Indexing,value= 0
	TitleBox Title_DA_IndexStartEnd,pos={319,50},size={111,13},disable=1,title="\\JCIndexing End Wave"
	TitleBox Title_DA_IndexStartEnd,userdata(tabnum)=  "1"
	TitleBox Title_DA_IndexStartEnd,userdata(tabcontrol)=  "ADC"
	TitleBox Title_DA_IndexStartEnd,userdata(ResizeControlsInfo)= A"!!,HM!!#>b!!#@B!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DA_IndexStartEnd,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DA_IndexStartEnd,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DA_IndexStartEnd,frame=0,fStyle=1,anchor= LC
	TitleBox Title_DA_Gain,pos={51,50},size={26,13},disable=1,title="Gain"
	TitleBox Title_DA_Gain,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	TitleBox Title_DA_Gain,userdata(ResizeControlsInfo)= A"!!,EN!!#>^!!#=3!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DA_Gain,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DA_Gain,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DA_Gain,frame=0,fStyle=1
	TitleBox Title_DA_DAWaveSelect,pos={157,50},size={94,13},disable=1,title="DA Wave Select"
	TitleBox Title_DA_DAWaveSelect,help={"Use the popup menus to select the stimulus set that will be output from the associated channel"}
	TitleBox Title_DA_DAWaveSelect,userdata(tabnum)=  "1"
	TitleBox Title_DA_DAWaveSelect,userdata(tabcontrol)=  "ADC"
	TitleBox Title_DA_DAWaveSelect,userdata(ResizeControlsInfo)= A"!!,FI!!#>^!!#@b!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DA_DAWaveSelect,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DA_DAWaveSelect,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DA_DAWaveSelect,frame=0,fStyle=1
	TitleBox Title_DA_Scale,pos={274,50},size={32,13},disable=1,title="Scale"
	TitleBox Title_DA_Scale,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	TitleBox Title_DA_Scale,userdata(ResizeControlsInfo)= A"!!,H0!!#>b!!#=c!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DA_Scale,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DA_Scale,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DA_Scale,frame=0,fStyle=1
	TitleBox Title_DA_Channel,pos={24,50},size={17,13},disable=1,title="DA"
	TitleBox Title_DA_Channel,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	TitleBox Title_DA_Channel,userdata(ResizeControlsInfo)= A"!!,BY!!#>^!!#=K!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_DA_Channel,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_DA_Channel,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_DA_Channel,frame=0,fStyle=1
	PopupMenu Popup_DA_IndexEnd_00,pos={316,73},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_00,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_00,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_00,userdata(ResizeControlsInfo)= A"!!,HKJ,hot!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_00,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj9:bu$lAT2!E6!l<-7VR$W;flSi?UR1e0KUH"
	PopupMenu Popup_DA_IndexEnd_00,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_00,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_01,pos={316,118},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_01,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_01,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_01,userdata(ResizeControlsInfo)= A"!!,HKJ,hq&!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_01,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Popup_DA_IndexEnd_01,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_01,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_02,pos={316,165},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_02,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_02,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_02,userdata(ResizeControlsInfo)= A"!!,HKJ,hq_!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_02,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Popup_DA_IndexEnd_02,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_02,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_03,pos={316,211},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_03,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_03,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_03,userdata(ResizeControlsInfo)= A"!!,HKJ,hr9!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_03,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Popup_DA_IndexEnd_03,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_03,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_04,pos={316,256},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_04,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_04,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_04,userdata(ResizeControlsInfo)= A"!!,HKJ,hrf!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_04,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Popup_DA_IndexEnd_04,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_04,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_05,pos={316,303},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_05,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_05,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_05,userdata(ResizeControlsInfo)= A"!!,HKJ,hs(J,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_05,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFj9:bu$lAT2!E6!l<-7VR$W;flSi?UR1e0KUH"
	PopupMenu Popup_DA_IndexEnd_05,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_05,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_06,pos={316,350},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_06,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_06,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_06,userdata(ResizeControlsInfo)= A"!!,HKJ,hs@!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_06,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Popup_DA_IndexEnd_06,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_06,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_DA_IndexEnd_07,pos={316,397},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_DA_IndexEnd_07,userdata(tabnum)=  "1"
	PopupMenu Popup_DA_IndexEnd_07,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_DA_IndexEnd_07,userdata(ResizeControlsInfo)= A"!!,HKJ,hsWJ,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_DA_IndexEnd_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_DA_IndexEnd_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_DA_IndexEnd_07,userdata(MenExp)= A"+tXpTDf0,//NZpCF*(6$Cia/L+tFi]"
	PopupMenu Popup_DA_IndexEnd_07,userdata(MenuExp)= A"6tL1V@8o%(FC.F%?SFQ_Bl7R\"APdMcF(J]H6!l<-;e^,V6pY063r"
	PopupMenu Popup_DA_IndexEnd_07,mode=1,popvalue="- none -",value= #"\"- none -;TestPulse;\"+ WBP_ITCPanelPopUps(0,\"DA\") "
	PopupMenu Popup_TTL_IndexEnd_00,pos={242,69},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_00,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_00,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_00,userdata(ResizeControlsInfo)= A"!!,H-!!#?C!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_00,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_00,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_00,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_01,pos={242,115},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_01,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_01,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_01,userdata(ResizeControlsInfo)= A"!!,H-!!#@J!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_01,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_01,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_01,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_02,pos={242,161},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_02,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_02,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_02,userdata(ResizeControlsInfo)= A"!!,H-!!#A0!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_02,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_02,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_02,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_03,pos={242,207},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_03,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_03,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_03,userdata(ResizeControlsInfo)= A"!!,H-!!#A^!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_03,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_03,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_03,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_04,pos={242,253},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_04,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_04,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_04,userdata(ResizeControlsInfo)= A"!!,H-!!#B7!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_04,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_04,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_04,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_05,pos={242,299},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_05,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_05,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_05,userdata(ResizeControlsInfo)= A"!!,H-!!#BOJ,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_05,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_05,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_05,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_06,pos={242,345},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_06,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_06,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_06,userdata(ResizeControlsInfo)= A"!!,H-!!#BfJ,hq4!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_06,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_06,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_06,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	PopupMenu Popup_TTL_IndexEnd_07,pos={242,392},size={125,21},bodyWidth=125,disable=1,proc=DAP_PopMenuChkProc_StimSetList
	PopupMenu Popup_TTL_IndexEnd_07,userdata(tabnum)=  "3"
	PopupMenu Popup_TTL_IndexEnd_07,userdata(tabcontrol)=  "ADC"
	PopupMenu Popup_TTL_IndexEnd_07,userdata(ResizeControlsInfo)= A"!!,H-!!#C)!!#@^!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu Popup_TTL_IndexEnd_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu Popup_TTL_IndexEnd_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu Popup_TTL_IndexEnd_07,userdata(MenuExp)=  "DeltaT4st_TTL_0;"
	PopupMenu Popup_TTL_IndexEnd_07,userdata(MenExp)=  "\"- none -;\"+\"\""
	PopupMenu Popup_TTL_IndexEnd_07,mode=1,popvalue="- none -",value= #"\"- none -;\"+ WBP_ITCPanelPopUps(1,\"TTL\") "
	CheckBox check_Settings_ShowScopeWindow,pos={34,415},size={121,14},disable=1,proc=DAP_CheckProc_ShowScopeWin,title="Show Scope Window"
	CheckBox check_Settings_ShowScopeWindow,help={"Enable the scope window to view ongoing acquistion"}
	CheckBox check_Settings_ShowScopeWindow,userdata(tabnum)=  "5"
	CheckBox check_Settings_ShowScopeWindow,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_ShowScopeWindow,userdata(ResizeControlsInfo)= A"!!,C<!!#CBJ,hq,!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_ShowScopeWindow,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Settings_ShowScopeWindow,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_ShowScopeWindow,value= 0
	Button Button_TTL_TurnOffAllTTLs,pos={21,422},size={67,40},disable=1,proc=DAP_ButtonProc_TTLOff,title="Turn off\rall TTLs"
	Button Button_TTL_TurnOffAllTTLs,userdata(tabnum)=  "3"
	Button Button_TTL_TurnOffAllTTLs,userdata(tabcontrol)=  "ADC"
	Button Button_TTL_TurnOffAllTTLs,userdata(ResizeControlsInfo)= A"!!,Ba!!#C8!!#??!!#>.z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button Button_TTL_TurnOffAllTTLs,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button Button_TTL_TurnOffAllTTLs,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	Button Button_DAC_TurnOFFDACs,pos={19,420},size={115,20},disable=1,proc=DAP_ButtonProc_DAOff,title="Turn Off alll DAs"
	Button Button_DAC_TurnOFFDACs,userdata(tabnum)=  "1"
	Button Button_DAC_TurnOFFDACs,userdata(tabcontrol)=  "ADC"
	Button Button_DAC_TurnOFFDACs,userdata(ResizeControlsInfo)= A"!!,B9!!#C:!!#?K!!#>\"z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button Button_DAC_TurnOFFDACs,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button Button_DAC_TurnOFFDACs,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	Button Button_ADC_TurnOffAllADCs,pos={20,420},size={115,20},disable=1,proc=DAP_ButtonProc_ADOff,title="Turn off alll ADs"
	Button Button_ADC_TurnOffAllADCs,userdata(tabnum)=  "2"
	Button Button_ADC_TurnOffAllADCs,userdata(tabcontrol)=  "ADC"
	Button Button_ADC_TurnOffAllADCs,userdata(ResizeControlsInfo)= A"!!,AN!!#C.J,hoP!!#>2z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button Button_ADC_TurnOffAllADCs,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button Button_ADC_TurnOffAllADCs,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	Button button_DataAcq_TurnOffAllChan,pos={412,73},size={30,40},proc=DAP_ButtonProc_AllChanOff,title="OFF"
	Button button_DataAcq_TurnOffAllChan,userdata(tabnum)=  "0"
	Button button_DataAcq_TurnOffAllChan,userdata(tabcontrol)=  "ADC"
	Button button_DataAcq_TurnOffAllChan,userdata(ResizeControlsInfo)= A"!!,Ht!!#CEJ,hpo!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_DataAcq_TurnOffAllChan,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	Button button_DataAcq_TurnOffAllChan,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_ITITP,pos={34,70},size={157,14},disable=1,title="Activate Test pulse during ITI"
	CheckBox check_Settings_ITITP,userdata(tabnum)=  "5"
	CheckBox check_Settings_ITITP,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_ITITP,userdata(ResizeControlsInfo)= A"!!,Ch!!#@F!!#A,!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_ITITP,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Settings_ITITP,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_ITITP,value= 0
	ValDisplay valdisp_DataAcq_ITICountdown,pos={60,434},size={129,17},bodyWidth=30,title="ITI remaining (s)"
	ValDisplay valdisp_DataAcq_ITICountdown,userdata(tabnum)=  "0"
	ValDisplay valdisp_DataAcq_ITICountdown,userdata(tabcontrol)=  "ADC"
	ValDisplay valdisp_DataAcq_ITICountdown,userdata(ResizeControlsInfo)= A"!!,HVJ,hs5!!#@,!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	ValDisplay valdisp_DataAcq_ITICountdown,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	ValDisplay valdisp_DataAcq_ITICountdown,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	ValDisplay valdisp_DataAcq_ITICountdown,fSize=14,format="%1g",fStyle=0
	ValDisplay valdisp_DataAcq_ITICountdown,valueColor=(65535,65535,65535)
	ValDisplay valdisp_DataAcq_ITICountdown,valueBackColor=(0,0,0)
	ValDisplay valdisp_DataAcq_ITICountdown,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdisp_DataAcq_ITICountdown,value= _NUM:0
	ValDisplay valdisp_DataAcq_TrialsCountdown,pos={45,407},size={145,17},bodyWidth=30,title="Sweeps remaining"
	ValDisplay valdisp_DataAcq_TrialsCountdown,userdata(tabnum)=  "0"
	ValDisplay valdisp_DataAcq_TrialsCountdown,userdata(tabcontrol)=  "ADC"
	ValDisplay valdisp_DataAcq_TrialsCountdown,userdata(ResizeControlsInfo)= A"!!,HVJ,hsAJ,hpk!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	ValDisplay valdisp_DataAcq_TrialsCountdown,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	ValDisplay valdisp_DataAcq_TrialsCountdown,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	ValDisplay valdisp_DataAcq_TrialsCountdown,fSize=14,fStyle=0
	ValDisplay valdisp_DataAcq_TrialsCountdown,valueColor=(65535,65535,65535)
	ValDisplay valdisp_DataAcq_TrialsCountdown,valueBackColor=(0,0,0)
	ValDisplay valdisp_DataAcq_TrialsCountdown,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdisp_DataAcq_TrialsCountdown,value= _NUM:1
	CheckBox check_Settings_Overwrite,pos={34,145},size={294,14},disable=1,title="Overwrite history and data waves on Next Sweep roll back"
	CheckBox check_Settings_Overwrite,help={"Overwrite occurs on next data acquisition cycle"}
	CheckBox check_Settings_Overwrite,userdata(tabnum)=  "5"
	CheckBox check_Settings_Overwrite,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_Overwrite,userdata(ResizeControlsInfo)= A"!!,Ch!!#@l!!#BM!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_Overwrite,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Settings_Overwrite,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_Overwrite,value= 0
	SetVariable setvar_Async_min_00,pos={113,66},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_00,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_00,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_00,userdata(ResizeControlsInfo)= A"!!,FG!!#?=!!#?G!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_00,value= _NUM:0
	SetVariable setvar_Async_max_00,pos={197,66},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_00,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_00,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_00,userdata(ResizeControlsInfo)= A"!!,GU!!#?=!!#?Q!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_00,value= _NUM:0
	CheckBox check_Async_Alarm_00,pos={61,68},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_00,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_00,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_00,userdata(ResizeControlsInfo)= A"!!,E.!!#?A!!#>>!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_00,value= 0
	SetVariable setvar_Async_min_01,pos={113,117},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_01,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_01,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_01,userdata(ResizeControlsInfo)= A"!!,FG!!#@N!!#?G!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_01,value= _NUM:0
	SetVariable setvar_Async_max_01,pos={197,117},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_01,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_01,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_01,userdata(ResizeControlsInfo)= A"!!,GU!!#@N!!#?Q!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_01,value= _NUM:0
	CheckBox check_Async_Alarm_01,pos={61,119},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_01,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_01,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_01,userdata(ResizeControlsInfo)= A"!!,E.!!#@R!!#>>!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_01,value= 0
	SetVariable setvar_Async_min_02,pos={113,169},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_02,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_02,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_02,userdata(ResizeControlsInfo)= A"!!,FG!!#A8!!#?G!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_02,value= _NUM:0
	SetVariable setvar_Async_max_02,pos={197,169},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_02,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_02,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_02,userdata(ResizeControlsInfo)= A"!!,GU!!#A8!!#?Q!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_02,value= _NUM:0
	CheckBox check_Async_Alarm_02,pos={61,171},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_02,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_02,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_02,userdata(ResizeControlsInfo)= A"!!,E.!!#A:!!#>>!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_02,value= 0
	SetVariable setvar_Async_min_03,pos={113,220},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_03,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_03,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_03,userdata(ResizeControlsInfo)= A"!!,FG!!#Ak!!#?G!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_03,value= _NUM:0
	SetVariable setvar_Async_max_03,pos={197,220},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_03,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_03,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_03,userdata(ResizeControlsInfo)= A"!!,GU!!#Ak!!#?Q!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_03,value= _NUM:0
	CheckBox check_Async_Alarm_03,pos={61,222},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_03,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_03,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_03,userdata(ResizeControlsInfo)= A"!!,E.!!#Am!!#>>!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_03,value= 0
	SetVariable setvar_Async_min_04,pos={113,272},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_04,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_04,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_04,userdata(ResizeControlsInfo)= A"!!,FG!!#BB!!#?G!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_04,value= _NUM:0
	SetVariable setvar_Async_max_04,pos={197,272},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_04,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_04,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_04,userdata(ResizeControlsInfo)= A"!!,GU!!#BB!!#?Q!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_04,value= _NUM:0
	CheckBox check_Async_Alarm_04,pos={61,274},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_04,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_04,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_04,userdata(ResizeControlsInfo)= A"!!,E.!!#BC!!#>>!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_04,value= 0
	SetVariable setvar_Async_min_05,pos={113,323},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_05,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_05,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_05,userdata(ResizeControlsInfo)= A"!!,FG!!#B[J,hor!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_05,value= _NUM:0
	SetVariable setvar_Async_max_05,pos={197,323},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_05,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_05,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_05,userdata(ResizeControlsInfo)= A"!!,GU!!#B[J,hp'!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_05,value= _NUM:0
	CheckBox check_Async_Alarm_05,pos={61,325},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_05,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_05,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_05,userdata(ResizeControlsInfo)= A"!!,E.!!#B\\J,hni!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_05,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_05,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_05,value= 0
	SetVariable setvar_Async_min_06,pos={113,375},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_06,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_06,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_06,userdata(ResizeControlsInfo)= A"!!,FG!!#BuJ,hor!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_06,value= _NUM:0
	SetVariable setvar_Async_max_06,pos={197,375},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_06,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_06,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_06,userdata(ResizeControlsInfo)= A"!!,GU!!#BuJ,hp'!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_06,value= _NUM:0
	CheckBox check_Async_Alarm_06,pos={61,378},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_06,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_06,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_06,userdata(ResizeControlsInfo)= A"!!,E.!!#C\"!!#>>!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_06,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_06,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_06,value= 0
	SetVariable setvar_Async_min_07,pos={113,427},size={71,16},disable=1,title="min"
	SetVariable setvar_Async_min_07,userdata(tabnum)=  "4"
	SetVariable setvar_Async_min_07,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_min_07,userdata(ResizeControlsInfo)= A"!!,FG!!#C:J,hor!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_min_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_min_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_min_07,value= _NUM:0
	SetVariable setvar_Async_max_07,pos={197,427},size={76,16},disable=1,title="max"
	SetVariable setvar_Async_max_07,userdata(tabnum)=  "4"
	SetVariable setvar_Async_max_07,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Async_max_07,userdata(ResizeControlsInfo)= A"!!,GU!!#C:J,hp'!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_Async_max_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_Async_max_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_Async_max_07,value= _NUM:0
	CheckBox check_Async_Alarm_07,pos={61,429},size={44,14},disable=1,title="Alarm"
	CheckBox check_Async_Alarm_07,userdata(tabnum)=  "4"
	CheckBox check_Async_Alarm_07,userdata(tabcontrol)=  "ADC"
	CheckBox check_Async_Alarm_07,userdata(ResizeControlsInfo)= A"!!,E.!!#C;J,hni!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Async_Alarm_07,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Async_Alarm_07,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Async_Alarm_07,value= 0
	TitleBox Title_TTL_IndexStartEnd,pos={254,53},size={111,13},disable=1,title="\\JCIndexing End Wave"
	TitleBox Title_TTL_IndexStartEnd,userdata(tabnum)=  "3"
	TitleBox Title_TTL_IndexStartEnd,userdata(tabcontrol)=  "ADC"
	TitleBox Title_TTL_IndexStartEnd,userdata(ResizeControlsInfo)= A"!!,H9!!#>b!!#@B!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_TTL_IndexStartEnd,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_TTL_IndexStartEnd,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_TTL_IndexStartEnd,frame=0,fStyle=1,anchor= LC
	TitleBox Title_TTL_TTLWaveSelect,pos={101,52},size={133,13},disable=1,title="(first) TTL Wave Select"
	TitleBox Title_TTL_TTLWaveSelect,userdata(tabnum)=  "3"
	TitleBox Title_TTL_TTLWaveSelect,userdata(tabcontrol)=  "ADC"
	TitleBox Title_TTL_TTLWaveSelect,userdata(ResizeControlsInfo)= A"!!,F/!!#>^!!#@i!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_TTL_TTLWaveSelect,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_TTL_TTLWaveSelect,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_TTL_TTLWaveSelect,frame=0,fStyle=1
	TitleBox Title_TTL_Channel,pos={28,52},size={29,13},disable=1,title="Chan"
	TitleBox Title_TTL_Channel,userdata(tabnum)=  "3",userdata(tabcontrol)=  "ADC"
	TitleBox Title_TTL_Channel,userdata(ResizeControlsInfo)= A"!!,CD!!#>^!!#=K!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox Title_TTL_Channel,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox Title_TTL_Channel,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox Title_TTL_Channel,frame=0,fStyle=1
	CheckBox check_DataAcq_RepAcqRandom,pos={72,523},size={58,14},title="Random"
	CheckBox check_DataAcq_RepAcqRandom,help={"Randomly selects wave from set selected for DAC channel on each trial. Doesn't repeat waves."}
	CheckBox check_DataAcq_RepAcqRandom,userdata(tabnum)=  "0"
	CheckBox check_DataAcq_RepAcqRandom,userdata(tabcontrol)=  "ADC"
	CheckBox check_DataAcq_RepAcqRandom,userdata(ResizeControlsInfo)= A"!!,D'!!#Bj!!#?!!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_DataAcq_RepAcqRandom,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_DataAcq_RepAcqRandom,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_DataAcq_RepAcqRandom,value= 0
	TitleBox title_Settings_SetCondition,pos={35,267},size={64,13},disable=1,title="Set A > Set B"
	TitleBox title_Settings_SetCondition,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition,userdata(ResizeControlsInfo)= A"!!,C$!!#B,!!#?u!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox title_Settings_SetCondition,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition,frame=0
	CheckBox check_Settings_Option_3,pos={262,286},size={120,26},disable=1,title="Repeat set B\runtil set A is complete"
	CheckBox check_Settings_Option_3,help={"This mode is useful when Set B contains a single wave."}
	CheckBox check_Settings_Option_3,userdata(tabnum)=  "5"
	CheckBox check_Settings_Option_3,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_Option_3,userdata(ResizeControlsInfo)= A"!!,HC!!#B<!!#@T!!#=3z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_Option_3,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Settings_Option_3,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_Option_3,fColor=(65280,43520,0),value= 0
	CheckBox check_Settings_ScalingZero,pos={262,229},size={132,14},disable=1,title="Set channel scaling to 0"
	CheckBox check_Settings_ScalingZero,help={"Applies to DA channel outputting Set B"}
	CheckBox check_Settings_ScalingZero,userdata(tabnum)=  "5"
	CheckBox check_Settings_ScalingZero,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_ScalingZero,userdata(ResizeControlsInfo)= A"!!,HC!!#AZ!!#?K!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_ScalingZero,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Settings_ScalingZero,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_ScalingZero,value= 0
	CheckBox check_Settings_SetOption_04,pos={262,259},size={108,14},disable=3,title="Turn off headstage"
	CheckBox check_Settings_SetOption_04,help={"Turns off AD associated with DA via Channel and Amplifier Assignments"}
	CheckBox check_Settings_SetOption_04,userdata(tabnum)=  "5"
	CheckBox check_Settings_SetOption_04,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_SetOption_04,userdata(ResizeControlsInfo)= A"!!,HC!!#B#!!#@<!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_SetOption_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	CheckBox check_Settings_SetOption_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_SetOption_04,fColor=(65280,43520,0),value= 0
	TitleBox title_Settings_SetCondition_00,pos={106,254},size={6,13},disable=1,title="\\f01/"
	TitleBox title_Settings_SetCondition_00,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_00,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_00,userdata(ResizeControlsInfo)= A"!!,FM!!#As!!#:\"!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_00,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_00,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_00,frame=0
	TitleBox title_Settings_SetCondition_01,pos={106,291},size={6,13},disable=1,title="\\f01\\"
	TitleBox title_Settings_SetCondition_01,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_01,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_01,userdata(ResizeControlsInfo)= A"!!,FM!!#B>J,hjM!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_01,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_01,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_01,frame=0
	TitleBox title_Settings_SetCondition_04,pos={254,254},size={6,13},disable=1,title="\\f01\\"
	TitleBox title_Settings_SetCondition_04,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_04,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_04,userdata(ResizeControlsInfo)= A"!!,H?!!#As!!#:\"!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_04,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_04,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_04,frame=0
	TitleBox title_Settings_SetCondition_02,pos={254,233},size={6,13},disable=1,title="\\f01/"
	TitleBox title_Settings_SetCondition_02,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_02,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_02,userdata(ResizeControlsInfo)= A"!!,H?!!#A^!!#:\"!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_02,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_02,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_02,frame=0
	TitleBox title_Settings_SetCondition_03,pos={222,243},size={28,13},disable=1,title="\\f01-------"
	TitleBox title_Settings_SetCondition_03,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_03,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_03,userdata(ResizeControlsInfo)= A"!!,H#!!#Ah!!#=C!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_03,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_03,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_03,frame=0
	PopupMenu popup_MoreSettings_DeviceType,pos={33,73},size={160,21},bodyWidth=100,disable=1,proc=DAP_PopMenuProc_DevTypeChk,title="Device type"
	PopupMenu popup_MoreSettings_DeviceType,help={"Step 1. Select device type. Open device button will be enabled if device type is attached."}
	PopupMenu popup_MoreSettings_DeviceType,userdata(tabnum)=  "6"
	PopupMenu popup_MoreSettings_DeviceType,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_MoreSettings_DeviceType,userdata(ResizeControlsInfo)= A"!!,E.!!#?k!!#A/!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu popup_MoreSettings_DeviceType,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu popup_MoreSettings_DeviceType,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu popup_MoreSettings_DeviceType,mode=6,popvalue="ITC18USB",value= #"\"ITC16;ITC18;ITC1600;ITC00;ITC16USB;ITC18USB;\""
	PopupMenu popup_moreSettings_DeviceNo,pos={60,100},size={133,21},bodyWidth=58,disable=1,title="Device number"
	PopupMenu popup_moreSettings_DeviceNo,help={"Step 2. Guess a device number. 0 is a good initial guess. Device number is determined in hardware. Unfortunately, it cannot be predetermined. "}
	PopupMenu popup_moreSettings_DeviceNo,userdata(tabnum)=  "6"
	PopupMenu popup_moreSettings_DeviceNo,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_moreSettings_DeviceNo,userdata(ResizeControlsInfo)= A"!!,Ej!!#@L!!#@i!!#<`z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	PopupMenu popup_moreSettings_DeviceNo,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	PopupMenu popup_moreSettings_DeviceNo,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	PopupMenu popup_moreSettings_DeviceNo,mode=1,popvalue="0",value= #"\"0;1;2;3;4;5;6;7;8;9;10\""
	SetVariable setvar_DataAcq_OnsetDelay,pos={315,509},size={117,16},bodyWidth=35,title="Onset delay (ms)"
	SetVariable setvar_DataAcq_OnsetDelay,help={"A global parameter that delays the onset time of a set after the initiation of data acquistion. Data acquisition start time is NOT delayed. Useful when set(s) have insufficient baseline epoch."}
	SetVariable setvar_DataAcq_OnsetDelay,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_OnsetDelay,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_DataAcq_OnsetDelay,userdata(ResizeControlsInfo)= A"!!,D/!!#C#!!#A>!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_DataAcq_OnsetDelay,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_DataAcq_OnsetDelay,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_DataAcq_OnsetDelay,value= _NUM:0
	SetVariable setvar_DataAcq_TerminationDelay,pos={288,530},size={144,16},bodyWidth=35,title="Termination delay (ms)"
	SetVariable setvar_DataAcq_TerminationDelay,help={"Global set(s) termination delay. Continues recording after set sweep is complete. Useful when recorded phenomena continues after termination of final set epoch."}
	SetVariable setvar_DataAcq_TerminationDelay,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_TerminationDelay,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_DataAcq_TerminationDelay,userdata(ResizeControlsInfo)= A"!!,Go!!#C#!!#A>!!#<8z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	SetVariable setvar_DataAcq_TerminationDelay,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Du]k<zzzzzzzzzzz"
	SetVariable setvar_DataAcq_TerminationDelay,userdata(ResizeControlsInfo) += A"zzz!!#u:Du]k<zzzzzzzzzzzzzz!!!"
	SetVariable setvar_DataAcq_TerminationDelay,value= _NUM:0
	GroupBox group_Hardware_FolderPath,pos={23,49},size={396,105},disable=1,title="Lock a device to generate device folder structure"
	GroupBox group_Hardware_FolderPath,userdata(tabnum)=  "6"
	GroupBox group_Hardware_FolderPath,userdata(tabcontrol)=  "ADC"
	GroupBox group_Hardware_FolderPath,userdata(ResizeControlsInfo)= A"!!,Bq!!#?;!!#B`J,hq.z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	GroupBox group_Hardware_FolderPath,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	GroupBox group_Hardware_FolderPath,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	GroupBox group_Hardware_FolderPath,fSize=12
	Button button_SettingsPlus_PingDevice,pos={43,126},size={150,20},disable=1,proc=HSU_ButtonProc_Settings_OpenDev,title="Open device"
	Button button_SettingsPlus_PingDevice,help={"Step 3. Use to determine device number for connected device. Look for device with Ready light ON. Device numbers are determined in hardware and do not change over time. "}
	Button button_SettingsPlus_PingDevice,userdata(tabnum)=  "6"
	Button button_SettingsPlus_PingDevice,userdata(tabcontrol)=  "ADC"
	Button button_SettingsPlus_PingDevice,userdata(ResizeControlsInfo)= A"!!,Fe!!#@r!!#?s!!#=Cz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_SettingsPlus_PingDevice,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	Button button_SettingsPlus_PingDevice,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	Button button_SettingsPlus_OpenWB,pos={362,449},size={76,45},disable=1,title="Open Wave\r Builder"
	Button button_SettingsPlus_OpenWB,userdata(tabnum)=  "5"
	Button button_SettingsPlus_OpenWB,userdata(tabcontrol)=  "ADC"
	Button button_SettingsPlus_OpenWB,userdata(ResizeControlsInfo)= A"!!,GD!!#CDJ,hp'!!#>Bz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_SettingsPlus_OpenWB,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	Button button_SettingsPlus_OpenWB,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	Button button_SettingsPlus_OpenDB,pos={23,449},size={76,45},disable=1,title="Open Data\r Browser"
	Button button_SettingsPlus_OpenDB,userdata(tabnum)=  "5"
	Button button_SettingsPlus_OpenDB,userdata(tabcontrol)=  "ADC"
	Button button_SettingsPlus_OpenDB,userdata(ResizeControlsInfo)= A"!!,HH!!#CAJ,hp'!!#>Bz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_SettingsPlus_OpenDB,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	Button button_SettingsPlus_OpenDB,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	Button button_SettingsPlus_LockDevice,pos={203,73},size={85,46},disable=1,proc=HSU_ButtonProc_LockDev,title="Lock device\r selection"
	Button button_SettingsPlus_LockDevice,help={"Device must be locked to acquire data. Locking can take a few seconds (calls to amp hardware are slow)."}
	Button button_SettingsPlus_LockDevice,userdata(tabnum)=  "6"
	Button button_SettingsPlus_LockDevice,userdata(tabcontrol)=  "ADC"
	Button button_SettingsPlus_LockDevice,userdata(ResizeControlsInfo)= A"!!,H$!!#?g!!#?c!!#>Fz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_SettingsPlus_LockDevice,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	Button button_SettingsPlus_LockDevice,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	Button button_SettingsPlus_unLockDevic,pos={295,73},size={85,46},disable=3,proc=HSU_ButProc_Hrdwr_UnlckDev,title="Unlock device\r selection"
	Button button_SettingsPlus_unLockDevic,userdata(tabnum)=  "6"
	Button button_SettingsPlus_unLockDevic,userdata(tabcontrol)=  "ADC"
	Button button_SettingsPlus_unLockDevic,userdata(ResizeControlsInfo)= A"!!,H$!!#@j!!#?c!!#>Fz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	Button button_SettingsPlus_unLockDevic,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	Button button_SettingsPlus_unLockDevic,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_1,pos={222,306},size={28,13},disable=1,title="\\f01-------"
	TitleBox title_Settings_SetCondition_1,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_1,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_1,userdata(ResizeControlsInfo)= A"!!,H#!!#BF!!#=C!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_1,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_1,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_1,frame=0
	TitleBox title_Settings_SetCondition_2,pos={254,317},size={6,13},disable=1,title="\\f01\\"
	TitleBox title_Settings_SetCondition_2,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_2,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_2,userdata(ResizeControlsInfo)= A"!!,H?!!#BKJ,hjM!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_2,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_2,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_2,frame=0
	TitleBox title_Settings_SetCondition_3,pos={254,296},size={6,13},disable=1,title="\\f01/"
	TitleBox title_Settings_SetCondition_3,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition_3,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition_3,userdata(ResizeControlsInfo)= A"!!,H?!!#BA!!#:\"!!#;]z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition_3,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	TitleBox title_Settings_SetCondition_3,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition_3,frame=0
	CheckBox check_Settings_SetOption_5,pos={262,316},size={97,26},disable=1,title="Index to next set\ron DA with set B"
	CheckBox check_Settings_SetOption_5,help={"This mode is useful when Set B contains a single wave."}
	CheckBox check_Settings_SetOption_5,userdata(tabnum)=  "5"
	CheckBox check_Settings_SetOption_5,userdata(tabcontrol)=  "ADC"
	CheckBox check_Settings_SetOption_5,userdata(ResizeControlsInfo)= A"!!,HC!!#BN!!#@&!!#=3z!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	CheckBox check_Settings_SetOption_5,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	CheckBox check_Settings_SetOption_5,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	CheckBox check_Settings_SetOption_5,fColor=(65280,43520,0),value= 0
	TitleBox title_Settings_SetCondition1,pos={116,294},size={95,26},disable=1,title="Continue acquisition\ron DA with set B"
	TitleBox title_Settings_SetCondition1,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition1,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition1,userdata(ResizeControlsInfo)= A"!!,Fa!!#B@!!#@2!!#=kz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition1,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	TitleBox title_Settings_SetCondition1,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition1,frame=0
	TitleBox title_Settings_SetCondition2,pos={118,234},size={91,26},disable=1,title="\\Z08Stop Acquisition on\rDA with Set B"
	TitleBox title_Settings_SetCondition2,userdata(tabnum)=  "5"
	TitleBox title_Settings_SetCondition2,userdata(tabcontrol)=  "ADC"
	TitleBox title_Settings_SetCondition2,userdata(ResizeControlsInfo)= A"!!,Fe!!#A_!!#@*!!#=kz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	TitleBox title_Settings_SetCondition2,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	TitleBox title_Settings_SetCondition2,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	TitleBox title_Settings_SetCondition2,frame=0
	ValDisplay valdisp_DataAcq_SweepsInSet,pos={287,407},size={30,17},bodyWidth=30
	ValDisplay valdisp_DataAcq_SweepsInSet,userdata(tabnum)=  "0"
	ValDisplay valdisp_DataAcq_SweepsInSet,userdata(tabcontrol)=  "ADC"
	ValDisplay valdisp_DataAcq_SweepsInSet,userdata(ResizeControlsInfo)= A"!!,GL!!#BdJ,hpk!!#;mz!!#](Aon\"Qzzzzzzzzzzzzzz!!#](Aon\"Qzz"
	ValDisplay valdisp_DataAcq_SweepsInSet,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzz!!#u:Duafnzzzzzzzzzzz"
	ValDisplay valdisp_DataAcq_SweepsInSet,userdata(ResizeControlsInfo) += A"zzz!!#u:Duafnzzzzzzzzzzzzzz!!!"
	ValDisplay valdisp_DataAcq_SweepsInSet,fSize=14,fStyle=0
	ValDisplay valdisp_DataAcq_SweepsInSet,valueColor=(65535,65535,65535)
	ValDisplay valdisp_DataAcq_SweepsInSet,valueBackColor=(0,0,0)
	ValDisplay valdisp_DataAcq_SweepsInSet,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdisp_DataAcq_SweepsInSet,value= _NUM:3
	CheckBox Check_DataAcq1_IndexingLocked,pos={204,557},size={54,14},proc=DAP_CheckProc_IndexingState,title="Locked"
	CheckBox Check_DataAcq1_IndexingLocked,help={"Data acquisition proceeds to next wave in DAC or TTL popup menu list"}
	CheckBox Check_DataAcq1_IndexingLocked,userdata(tabnum)=  "0"
	CheckBox Check_DataAcq1_IndexingLocked,userdata(tabcontrol)=  "ADC",value= 0
	SetVariable SetVar_DataAcq_ListRepeats,pos={178,573},size={104,16},bodyWidth=35,proc=DAP_SetVarProc_TotSweepCount,title="Repeat List(s)"
	SetVariable SetVar_DataAcq_ListRepeats,help={"This number is set automatically at based on the number of 1d waves contained in the largest set on active DA/TTL channels"}
	SetVariable SetVar_DataAcq_ListRepeats,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_ListRepeats,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_ListRepeats,fColor=(65280,43520,0)
	SetVariable SetVar_DataAcq_ListRepeats,limits={1,inf,1},value= _NUM:1
	CheckBox check_DataAcq_IndexRandom,pos={204,540},size={58,14},title="Random"
	CheckBox check_DataAcq_IndexRandom,help={"Randomly selects wave from set selected for DAC channel on each trial. Doesn't repeat waves."}
	CheckBox check_DataAcq_IndexRandom,userdata(tabnum)=  "0"
	CheckBox check_DataAcq_IndexRandom,userdata(tabcontrol)=  "ADC"
	CheckBox check_DataAcq_IndexRandom,fColor=(65280,43520,0),value= 0
	SetVariable setvar_DataAcq_FirstStepOveride,pos={349,551},size={83,16},bodyWidth=35,title="First Step"
	SetVariable setvar_DataAcq_FirstStepOveride,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_FirstStepOveride,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_DataAcq_FirstStepOveride,fColor=(65280,43520,0),value= _NUM:0
	SetVariable setvar_DataAcq_TotalStepOveride,pos={339,573},size={93,16},bodyWidth=35,title="Total Steps"
	SetVariable setvar_DataAcq_TotalStepOveride,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_TotalStepOveride,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_DataAcq_TotalStepOveride,fColor=(65280,43520,0),value= _NUM:0
	ValDisplay valdisp_DataAcq_SweepsActiveSet,pos={287,434},size={30,17},bodyWidth=30
	ValDisplay valdisp_DataAcq_SweepsActiveSet,help={"Displays the number of steps in the set with the most steps on active DA and TTL channels"}
	ValDisplay valdisp_DataAcq_SweepsActiveSet,userdata(tabnum)=  "0"
	ValDisplay valdisp_DataAcq_SweepsActiveSet,userdata(tabcontrol)=  "ADC",fSize=14
	ValDisplay valdisp_DataAcq_SweepsActiveSet,fStyle=0
	ValDisplay valdisp_DataAcq_SweepsActiveSet,valueColor=(65535,65535,65535)
	ValDisplay valdisp_DataAcq_SweepsActiveSet,valueBackColor=(0,0,0)
	ValDisplay valdisp_DataAcq_SweepsActiveSet,limits={0,0,0},barmisc={0,1000}
	ValDisplay valdisp_DataAcq_SweepsActiveSet,value= _NUM:3
	SetVariable SetVar_DataAcq_TPAmplitudeIC,pos={316,288},size={105,16},title="Amplitude IC"
	SetVariable SetVar_DataAcq_TPAmplitudeIC,userdata(tabnum)=  "0"
	SetVariable SetVar_DataAcq_TPAmplitudeIC,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_DataAcq_TPAmplitudeIC,value= _NUM:50
	SetVariable SetVar_Hardware_VC_DA_Unit,pos={151,425},size={30,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable SetVar_Hardware_VC_DA_Unit,userdata(tabnum)=  "6"
	SetVariable SetVar_Hardware_VC_DA_Unit,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Hardware_VC_DA_Unit,value= _STR:"mV"
	SetVariable SetVar_Hardware_IC_DA_Unit,pos={330,426},size={30,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable SetVar_Hardware_IC_DA_Unit,userdata(tabnum)=  "6"
	SetVariable SetVar_Hardware_IC_DA_Unit,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Hardware_IC_DA_Unit,value= _STR:"pA"
	SetVariable SetVar_Hardware_VC_AD_Unit,pos={172,450},size={30,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable SetVar_Hardware_VC_AD_Unit,userdata(tabnum)=  "6"
	SetVariable SetVar_Hardware_VC_AD_Unit,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Hardware_VC_AD_Unit,value= _STR:"pA"
	SetVariable SetVar_Hardware_IC_AD_Unit,pos={353,450},size={30,16},disable=1,proc=DAP_SetVarProc_CAA
	SetVariable SetVar_Hardware_IC_AD_Unit,userdata(tabnum)=  "6"
	SetVariable SetVar_Hardware_IC_AD_Unit,userdata(tabcontrol)=  "ADC"
	SetVariable SetVar_Hardware_IC_AD_Unit,value= _STR:"mV"
	TitleBox Title_Hardware_VC_gain,pos={93,407},size={20,13},disable=1,title="gain"
	TitleBox Title_Hardware_VC_gain,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_VC_gain,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_Hardware_VC_unit,pos={169,407},size={17,13},disable=1,title="unit"
	TitleBox Title_Hardware_VC_unit,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_VC_unit,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_Hardware_IC_gain,pos={275,407},size={20,13},disable=1,title="gain"
	TitleBox Title_Hardware_IC_gain,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_IC_gain,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_Hardware_IC_unit,pos={331,407},size={17,13},disable=1,title="unit"
	TitleBox Title_Hardware_IC_unit,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_IC_unit,userdata(tabcontrol)=  "ADC",frame=0
	SetVariable Unit_DA_00,pos={92,75},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_00,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_00,limits={0,inf,1},value= _STR:"pA"
	TitleBox Title_DA_Unit,pos={95,50},size={23,13},disable=1,title="Unit"
	TitleBox Title_DA_Unit,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	TitleBox Title_DA_Unit,frame=0,fStyle=1
	SetVariable Unit_DA_01,pos={91,120},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_01,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_01,limits={0,inf,1},value= _STR:"mV"
	SetVariable Unit_DA_02,pos={91,167},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_02,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_02,limits={0,inf,1},value= _STR:"mV"
	SetVariable Unit_DA_03,pos={91,214},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_03,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_03,limits={0,inf,1},value= _STR:""
	SetVariable Unit_DA_04,pos={91,258},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_04,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_04,limits={0,inf,1},value= _STR:""
	SetVariable Unit_DA_05,pos={91,305},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_05,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_05,limits={0,inf,1},value= _STR:""
	SetVariable Unit_DA_06,pos={91,352},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_06,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_06,limits={0,inf,1},value= _STR:""
	SetVariable Unit_DA_07,pos={91,399},size={30,16},disable=1,help={"hello"}
	SetVariable Unit_DA_07,userdata(tabnum)=  "1",userdata(tabcontrol)=  "ADC"
	SetVariable Unit_DA_07,limits={0,inf,1},value= _STR:"pA"
	SetVariable Unit_AD_00,pos={106,74},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_00,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_00,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_00,limits={0,inf,1},value= _STR:"mV"
	SetVariable Unit_AD_01,pos={106,120},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_01,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_01,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_01,limits={0,inf,1},value= _STR:"pA"
	SetVariable Unit_AD_02,pos={106,166},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_02,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_02,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_02,limits={0,inf,1},value= _STR:"mV"
	SetVariable Unit_AD_03,pos={106,212},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_03,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_03,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_03,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_04,pos={106,259},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_04,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_04,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_04,limits={0,inf,1},value= _STR:"mV"
	SetVariable Unit_AD_05,pos={106,305},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_05,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_05,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_05,limits={0,inf,1},value= _STR:"pA"
	SetVariable Unit_AD_06,pos={106,351},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_06,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_06,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_06,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_07,pos={106,398},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_07,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_07,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_07,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_08,pos={278,74},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_08,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_08,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_08,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_09,pos={278,120},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_09,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_09,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_09,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_10,pos={278,166},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_10,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_10,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_10,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_11,pos={278,212},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_11,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_11,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_11,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_12,pos={278,259},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_12,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_12,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_12,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_13,pos={278,305},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_13,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_13,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_13,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_14,pos={278,351},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_14,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_14,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_14,limits={0,inf,1},value= _STR:""
	SetVariable Unit_AD_15,pos={278,398},size={40,16},disable=1,title="V/"
	SetVariable Unit_AD_15,help={"hello"},userdata(tabnum)=  "2"
	SetVariable Unit_AD_15,userdata(tabcontrol)=  "ADC"
	SetVariable Unit_AD_15,limits={0,inf,1},value= _STR:"pA"
	TitleBox Title_AD_Unit,pos={122,50},size={23,13},disable=1,title="Unit"
	TitleBox Title_AD_Unit,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	TitleBox Title_AD_Unit,frame=0,fStyle=1
	TitleBox Title_AD_Gain,pos={61,50},size={26,13},disable=1,title="Gain"
	TitleBox Title_AD_Gain,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	TitleBox Title_AD_Gain,frame=0,fStyle=1
	TitleBox Title_AD_Channel,pos={23,50},size={17,13},disable=1,title="AD"
	TitleBox Title_AD_Channel,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	TitleBox Title_AD_Channel,frame=0,fStyle=1
	TitleBox Title_AD_Channel1,pos={195,50},size={17,13},disable=1,title="AD"
	TitleBox Title_AD_Channel1,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	TitleBox Title_AD_Channel1,frame=0,fStyle=1
	TitleBox Title_AD_Gain1,pos={233,50},size={26,13},disable=1,title="Gain"
	TitleBox Title_AD_Gain1,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	TitleBox Title_AD_Gain1,frame=0,fStyle=1
	TitleBox Title_AD_Unit1,pos={294,50},size={23,13},disable=1,title="Unit"
	TitleBox Title_AD_Unit1,userdata(tabnum)=  "2",userdata(tabcontrol)=  "ADC"
	TitleBox Title_AD_Unit1,frame=0,fStyle=1
	TitleBox Title_Hardware_VC_DA_Div,pos={185,427},size={15,13},disable=1,title="/ V"
	TitleBox Title_Hardware_VC_DA_Div,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_VC_DA_Div,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_Hardware_IC_DA_Div,pos={362,427},size={15,13},disable=1,title="/ V"
	TitleBox Title_Hardware_IC_DA_Div,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_IC_DA_Div,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_Hardware_IC_AD_Div,pos={335,452},size={15,13},disable=1,title="V /"
	TitleBox Title_Hardware_IC_AD_Div,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_IC_AD_Div,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_Hardware_IC_AD_Div1,pos={153,452},size={15,13},disable=1,title="V /"
	TitleBox Title_Hardware_IC_AD_Div1,userdata(tabnum)=  "6"
	TitleBox Title_Hardware_IC_AD_Div1,userdata(tabcontrol)=  "ADC",frame=0
	GroupBox GroupBox_Hardware_Associations,pos={23,305},size={397,191},disable=1,title="DAC Channel and Device Associations"
	GroupBox GroupBox_Hardware_Associations,userdata(tabnum)=  "6"
	GroupBox GroupBox_Hardware_Associations,userdata(tabcontrol)=  "ADC"
	GroupBox group_Settings_DatAcq,pos={21,99},size={421,250},disable=1,title="Data Acquisition"
	GroupBox group_Settings_DatAcq,userdata(tabnum)=  "5"
	GroupBox group_Settings_DatAcq,userdata(tabcontrol)=  "ADC"
	GroupBox group_Settings_Asynch,pos={21,352},size={421,40},disable=1,title="Asynchronous"
	GroupBox group_Settings_Asynch,userdata(tabnum)=  "5"
	GroupBox group_Settings_Asynch,userdata(tabcontrol)=  "ADC"
	GroupBox group_Settings_TP,pos={21,30},size={421,60},disable=1,title="Test Pulse"
	GroupBox group_Settings_TP,userdata(tabnum)=  "5",userdata(tabcontrol)=  "ADC"
	GroupBox group_Settings_Asynch1,pos={21,396},size={421,40},disable=1,title="Oscilloscope"
	GroupBox group_Settings_Asynch1,userdata(tabnum)=  "5"
	GroupBox group_Settings_Asynch1,userdata(tabcontrol)=  "ADC"
	GroupBox group_DataAcq_ClampMode,pos={30,39},size={422,225},title="Clamp Mode"
	GroupBox group_DataAcq_ClampMode,userdata(tabnum)=  "0"
	GroupBox group_DataAcq_ClampMode,userdata(tabcontrol)=  "ADC"
	GroupBox group_DataAcq_ClampMode1,pos={30,270},size={422,90},title="Test Pulse"
	GroupBox group_DataAcq_ClampMode1,userdata(tabnum)=  "0"
	GroupBox group_DataAcq_ClampMode1,userdata(tabcontrol)=  "ADC"
	GroupBox group_DataAcq_ClampMode2,pos={30,366},size={422,115},title="Status Information"
	GroupBox group_DataAcq_ClampMode2,userdata(tabnum)=  "0"
	GroupBox group_DataAcq_ClampMode2,userdata(tabcontrol)=  "ADC"
	TitleBox title_DataAcq_NextSweep,pos={200,381},size={72,16},title="Next Sweep"
	TitleBox title_DataAcq_NextSweep,userdata(tabnum)=  "0"
	TitleBox title_DataAcq_NextSweep,userdata(tabcontrol)=  "ADC",fSize=14,frame=0
	TitleBox title_DataAcq_NextSweep,fStyle=0
	TitleBox title_DataAcq_NextSweep1,pos={324,408},size={83,16},title="Total Sweeps"
	TitleBox title_DataAcq_NextSweep1,userdata(tabnum)=  "0"
	TitleBox title_DataAcq_NextSweep1,userdata(tabcontrol)=  "ADC",fSize=14,frame=0
	TitleBox title_DataAcq_NextSweep1,fStyle=0
	TitleBox title_DataAcq_NextSweep2,pos={324,435},size={100,16},title="Set Max Sweeps"
	TitleBox title_DataAcq_NextSweep2,userdata(tabnum)=  "0"
	TitleBox title_DataAcq_NextSweep2,userdata(tabcontrol)=  "ADC",fSize=14,frame=0
	TitleBox title_DataAcq_NextSweep2,fStyle=0
	TitleBox title_DataAcq_NextSweep3,pos={171,460},size={128,16},title="Sampling Interval (�s)"
	TitleBox title_DataAcq_NextSweep3,userdata(tabnum)=  "0"
	TitleBox title_DataAcq_NextSweep3,userdata(tabcontrol)=  "ADC",fSize=14,frame=0
	TitleBox title_DataAcq_NextSweep3,fStyle=0
	GroupBox group_DataAcq_DataAcq,pos={30,489},size={422,175},title="Data Acquisition"
	GroupBox group_DataAcq_DataAcq,userdata(tabnum)=  "0"
	GroupBox group_DataAcq_DataAcq,userdata(tabcontrol)=  "ADC"
	GroupBox group_Hardware_Yoke,pos={23,156},size={396,145},disable=1,title="Yoke"
	GroupBox group_Hardware_Yoke,help={"Yoking is only available for >1 ITC1600, however, It is not a requirement for the use of multiple ITC1600s asyncronously."}
	GroupBox group_Hardware_Yoke,userdata(tabnum)=  "6",userdata(tabcontrol)=  "ADC"
	GroupBox group_Hardware_Yoke,fSize=12
	Button button_Hardware_Lead1600,pos={29,195},size={80,21},disable=3,proc=DAP_ButtonProc_Lead,title="Lead"
	Button button_Hardware_Lead1600,help={"For ITC1600 devices only. Sets locked ITC device as the lead. User must now assign follower devices."}
	Button button_Hardware_Lead1600,userdata(tabnum)=  "6"
	Button button_Hardware_Lead1600,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_Hardware_AvailITC1600s,pos={29,240},size={110,21},bodyWidth=110,disable=3,title="Locked ITC1600s"
	PopupMenu popup_Hardware_AvailITC1600s,userdata(tabnum)=  "6"
	PopupMenu popup_Hardware_AvailITC1600s,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_Hardware_AvailITC1600s,mode=0,value= #"DAP_ListOfITCDevices()"
	Button button_Hardware_AddFollower,pos={141,240},size={80,21},disable=3,proc=DAP_ButtonProc_Follow,title="Follow"
	Button button_Hardware_AddFollower,help={"For ITC1600 devices only. Sets locked ITC device as a follower. Select leader from other locked ITC1600s panel. This will disable data aquistion directly from this panel."}
	Button button_Hardware_AddFollower,userdata(tabnum)=  "6"
	Button button_Hardware_AddFollower,userdata(tabcontrol)=  "ADC"
	TitleBox title_hardware_1600inst,pos={29,176},size={282,13},disable=3,title="Designate the status of the ITC1600 assigned to this device"
	TitleBox title_hardware_1600inst,help={"If the device is designated to follow, the test pulse and data aquisition will be triggered from the lead panel."}
	TitleBox title_hardware_1600inst,userdata(tabnum)=  "6"
	TitleBox title_hardware_1600inst,userdata(tabcontrol)=  "ADC",frame=0
	Button button_Hardware_Independent,pos={111,195},size={80,21},disable=3,proc=DAP_ButtonProc_Independent,title="Independent"
	Button button_Hardware_Independent,help={"For ITC1600 devices only. Sets locked ITC device as the lead. User must now assign follower devices."}
	Button button_Hardware_Independent,userdata(tabnum)=  "6"
	Button button_Hardware_Independent,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Hardware_Status,pos={144,678},size={196,16},bodyWidth=99,title="ITC DAC Status:"
	SetVariable setvar_Hardware_Status,frame=0,fStyle=1,fColor=(65280,0,0)
	SetVariable setvar_Hardware_Status,valueBackColor=(60928,60928,60928)
	SetVariable setvar_Hardware_Status,value= _STR:"Lead",noedit= 1
	TitleBox title_hardware_Follow,pos={29,222},size={163,13},disable=3,title="Assign ITC1600 DACs as followers"
	TitleBox title_hardware_Follow,help={"If the device is designated to follow, the test pulse and data aquisition will be triggered from the lead panel."}
	TitleBox title_hardware_Follow,userdata(tabnum)=  "6"
	TitleBox title_hardware_Follow,userdata(tabcontrol)=  "ADC",frame=0
	SetVariable setvar_Hardware_YokeList,pos={29,272},size={300,16},disable=3,title="Yoked DACs:"
	SetVariable setvar_Hardware_YokeList,userdata(tabnum)=  "6"
	SetVariable setvar_Hardware_YokeList,userdata(tabcontrol)=  "ADC"
	SetVariable setvar_Hardware_YokeList,labelBack=(60928,60928,60928),frame=0
	SetVariable setvar_Hardware_YokeList,value= _STR:"ITC1600_Dev_0;ITC1600_Dev_1;",noedit= 1
	Button button_Hardware_RemoveYoke,pos={335,240},size={80,21},disable=3,proc=DAP_ButtonProc_YokeRelease,title="Release"
	Button button_Hardware_RemoveYoke,userdata(tabnum)=  "6"
	Button button_Hardware_RemoveYoke,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_Hardware_YokedDACs,pos={223,240},size={110,21},bodyWidth=110,disable=3,title="Yoked ITC1600s"
	PopupMenu popup_Hardware_YokedDACs,userdata(tabnum)=  "6"
	PopupMenu popup_Hardware_YokedDACs,userdata(tabcontrol)=  "ADC"
	PopupMenu popup_Hardware_YokedDACs,mode=0,value= #"Path_ListOfYokedDACs(DAP_ReturnPanelName())"
	TitleBox title_hardware_Release,pos={225,222},size={152,13},disable=3,title="Release follower ITC1600 DACs"
	TitleBox title_hardware_Release,help={"If the device is designated to follow, the test pulse and data aquisition will be triggered from the lead panel."}
	TitleBox title_hardware_Release,userdata(tabnum)=  "6"
	TitleBox title_hardware_Release,userdata(tabcontrol)=  "ADC",frame=0
	TitleBox Title_DataAcq_Hold_IC,pos={70,174},size={58,13},disable=1,title="Holding (pA)"
	TitleBox Title_DataAcq_Hold_IC,userdata(tabnum)=  "1"
	TitleBox Title_DataAcq_Hold_IC,userdata(tabcontrol)=  "tab_DataAcq_Amp",frame=0
	TitleBox Title_DataAcq_Bridge,pos={55,193},size={72,13},disable=1,title="Bridge Balance"
	TitleBox Title_DataAcq_Bridge,userdata(tabnum)=  "1"
	TitleBox Title_DataAcq_Bridge,userdata(tabcontrol)=  "tab_DataAcq_Amp",frame=0
	SetVariable setvar_DataAcq_Hold_IC,pos={135,173},size={36,16},disable=1
	SetVariable setvar_DataAcq_Hold_IC,userdata(tabnum)=  "1"
	SetVariable setvar_DataAcq_Hold_IC,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_Hold_IC,value= _NUM:0
	SetVariable setvar_DataAcq_BB,pos={135,192},size={36,16},disable=1
	SetVariable setvar_DataAcq_BB,userdata(tabnum)=  "1"
	SetVariable setvar_DataAcq_BB,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_BB,value= _NUM:0
	SetVariable setvar_DataAcq_CN,pos={135,211},size={36,16},disable=1
	SetVariable setvar_DataAcq_CN,userdata(tabnum)=  "1"
	SetVariable setvar_DataAcq_CN,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_CN,value= _NUM:0
	CheckBox check_DatAcq_HoldEnable,pos={178,174},size={51,14},disable=1,title="Enable"
	CheckBox check_DatAcq_HoldEnable,userdata(tabnum)=  "1"
	CheckBox check_DatAcq_HoldEnable,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DatAcq_HoldEnable,value= 0
	CheckBox check_DatAcq_BBEnable,pos={178,193},size={51,14},disable=1,title="Enable"
	CheckBox check_DatAcq_BBEnable,userdata(tabnum)=  "1"
	CheckBox check_DatAcq_BBEnable,userdata(tabcontrol)=  "tab_DataAcq_Amp",value= 0
	CheckBox check_DatAcq_CNEnable,pos={178,212},size={51,14},disable=1,title="Enable"
	CheckBox check_DatAcq_CNEnable,userdata(tabnum)=  "1"
	CheckBox check_DatAcq_CNEnable,userdata(tabcontrol)=  "tab_DataAcq_Amp",value= 0
	Button button_DataAcq_AutoBB,pos={235,191},size={38,18},disable=1,title="AUTO"
	Button button_DataAcq_AutoBB,userdata(tabnum)=  "1"
	Button button_DataAcq_AutoBB,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	TitleBox Title_DataAcq_CN,pos={41,211},size={86,13},disable=1,title="Cap Neutralization"
	TitleBox Title_DataAcq_CN,userdata(tabnum)=  "1"
	TitleBox Title_DataAcq_CN,userdata(tabcontrol)=  "tab_DataAcq_Amp",frame=0
	Slider slider_DataAcq_ActiveHeadstage,pos={144,129},size={255,19}
	Slider slider_DataAcq_ActiveHeadstage,userdata(tabnum)=  "0"
	Slider slider_DataAcq_ActiveHeadstage,userdata(tabcontrol)=  "ADC"
	Slider slider_DataAcq_ActiveHeadstage,labelBack=(60928,60928,60928)
	Slider slider_DataAcq_ActiveHeadstage,limits={0,7,1},value= 2,side= 2,vert= 0,ticks= 0
	TabControl tab_DataAcq_Amp,pos={38,148},size={408,110},proc=ACL_DisplayTab
	TabControl tab_DataAcq_Amp,help={"Entries into these tabs update the MCC only when in the active mode. On mode switching, the parameters will be passed to the MCC."}
	TabControl tab_DataAcq_Amp,userdata(tabnum)=  "0",userdata(tabcontrol)=  "ADC"
	TabControl tab_DataAcq_Amp,userdata(currenttab)=  "0"
	TabControl tab_DataAcq_Amp,labelBack=(60928,60928,60928),fSize=10
	TabControl tab_DataAcq_Amp,tabLabel(0)="V-Clamp",tabLabel(1)="I-Clamp"
	TabControl tab_DataAcq_Amp,tabLabel(2)="I = 0",value= 0
	SetVariable setvar_DataAcq_AutoBiasV,pos={309,188},size={80,16},disable=1,title="Vm (mV)"
	SetVariable setvar_DataAcq_AutoBiasV,userdata(tabnum)=  "1"
	SetVariable setvar_DataAcq_AutoBiasV,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_AutoBiasV,value= _NUM:0
	CheckBox check_DataAcq_AutoBias,pos={304,171},size={63,14},disable=1,title="Auto Bias"
	CheckBox check_DataAcq_AutoBias,help={"Just prior to a sweep the Vm is checked and the bias current is adjusted to maintain desired Vm."}
	CheckBox check_DataAcq_AutoBias,userdata(tabnum)=  "1"
	CheckBox check_DataAcq_AutoBias,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DataAcq_AutoBias,value= 0,side= 1
	SetVariable setvar_DataAcq_Ri,pos={310,208},size={79,18},disable=1,title="Ri (M\\F'Symbol'W\\F'MS Sans Serif')"
	SetVariable setvar_DataAcq_Ri,userdata(tabnum)=  "1"
	SetVariable setvar_DataAcq_Ri,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_Ri,value= _NUM:0
	SetVariable setvar_DataAcq_AutoBiasVrange,pos={391,188},size={41,16},disable=1,title="�"
	SetVariable setvar_DataAcq_AutoBiasVrange,userdata(tabnum)=  "1"
	SetVariable setvar_DataAcq_AutoBiasVrange,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_AutoBiasVrange,value= _NUM:0
	TitleBox Title_DataAcq_Hold_VC,pos={70,172},size={60,13},title="Holding (mV)"
	TitleBox Title_DataAcq_Hold_VC,userdata(tabnum)=  "0"
	TitleBox Title_DataAcq_Hold_VC,userdata(tabcontrol)=  "tab_DataAcq_Amp",frame=0
	SetVariable setvar_DataAcq_Hold_VC,pos={135,171},size={36,16}
	SetVariable setvar_DataAcq_Hold_VC,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_Hold_VC,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_Hold_VC,value= _NUM:0
	CheckBox check_DatAcq_HoldEnableVC,pos={178,172},size={51,14},title="Enable"
	CheckBox check_DatAcq_HoldEnableVC,userdata(tabnum)=  "0"
	CheckBox check_DatAcq_HoldEnableVC,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DatAcq_HoldEnableVC,value= 0
	SetVariable setvar_DataAcq_WCR,pos={136,211},size={60,18},title="M\\F'Symbol'W"
	SetVariable setvar_DataAcq_WCR,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_WCR,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_WCR,value= _NUM:0
	CheckBox check_DatAcq_WholeCellEnable,pos={82,191},size={16,14},title=""
	CheckBox check_DatAcq_WholeCellEnable,userdata(tabnum)=  "0"
	CheckBox check_DatAcq_WholeCellEnable,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DatAcq_WholeCellEnable,value= 0
	SetVariable setvar_DataAcq_WCC,pos={73,212},size={60,16},title="pF"
	SetVariable setvar_DataAcq_WCC,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_WCC,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_WCC,value= _NUM:0
	Button button_DataAcq_WCAuto,pos={116,231},size={40,15},title="Auto"
	Button button_DataAcq_WCAuto,userdata(tabnum)=  "0"
	Button button_DataAcq_WCAuto,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	GroupBox group_DataAcq_RsCompensation,pos={210,192},size={143,59},title="       Rs Compensation"
	GroupBox group_DataAcq_RsCompensation,userdata(tabnum)=  "0"
	GroupBox group_DataAcq_RsCompensation,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DatAcq_RsCompEnable,pos={232,191},size={16,14},title=""
	CheckBox check_DatAcq_RsCompEnable,userdata(tabnum)=  "0"
	CheckBox check_DatAcq_RsCompEnable,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DatAcq_RsCompEnable,value= 0
	SetVariable setvar_DataAcq_RsCorr,pos={221,212},size={97,16},title="Corretion (%)"
	SetVariable setvar_DataAcq_RsCorr,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_RsCorr,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_RsCorr,value= _NUM:0
	SetVariable setvar_DataAcq_RsPred,pos={216,232},size={103,16},title="Prediction (%)"
	SetVariable setvar_DataAcq_RsPred,userdata(tabnum)=  "0"
	SetVariable setvar_DataAcq_RsPred,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	SetVariable setvar_DataAcq_RsPred,value= _NUM:0
	Button button_DataAcq_ForwardHold,pos={366,204},size={49,35},title="Auto fill\rbias"
	Button button_DataAcq_ForwardHold,help={"Sets the I-clamp holding current based on the V-clamp holding potential"}
	Button button_DataAcq_ForwardHold,userdata(tabnum)=  "0"
	Button button_DataAcq_ForwardHold,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	Button button_Hardware_AutoGainAndUnit,pos={385,421},size={31,47},disable=1,proc=DAP_ButtonProc_AutoFillGain,title="Auto\rFill"
	Button button_Hardware_AutoGainAndUnit,help={"A amplifier channel needs to be selected from the popup menu prior to auto filling gain and units."}
	Button button_Hardware_AutoGainAndUnit,userdata(tabnum)=  "6"
	Button button_Hardware_AutoGainAndUnit,userdata(tabcontrol)=  "ADC"
	CheckBox check_DataAcq_IzeroEnable,pos={52,185},size={51,14},disable=1,title="Enable"
	CheckBox check_DataAcq_IzeroEnable,userdata(tabnum)=  "2"
	CheckBox check_DataAcq_IzeroEnable,userdata(tabcontrol)=  "tab_DataAcq_Amp"
	CheckBox check_DataAcq_IzeroEnable,value= 0
	DefineGuide UGV0={FR,-25},UGH0={FB,-27},UGV1={FL,481}
	SetWindow kwTopWin,userdata(ResizeControlsInfo)= A"!!*'\"z!!#Du5QF1NJ,fQL!!*'\"zzzzzzzzzzzzzzzzzzz"
	SetWindow kwTopWin,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzzzzzzzzzzzzzzz"
	SetWindow kwTopWin,userdata(ResizeControlsInfo) += A"zzzzzzzzzzzzzzzzzzz!!!"
	SetWindow kwTopWin,userdata(ResizeControlsGuides)=  "UGV0;UGH0;"
	SetWindow kwTopWin,userdata(ResizeControlsInfoUGV0)= A":-hTC3`S[N0KW?-:-(sG6SUJQ0OI4ZG$cpb<*<$d3`U64E]Zff;Ft%f:/jMQ3\\WWl:K'ha8P`)B3&r`U7o`,K756hm;EIBK8OQ!&3]g5.9MeM`8Q88W:-'s^2*1"
	SetWindow kwTopWin,userdata(ResizeControlsInfoUGH0)= A":-hTC3`S[@0KW?-:-(sG6SUJQ0OI4ZG$cpb<*<$d3`U64E]Zff;Ft%f:/jMQ3\\`]m:K'ha8P`)B1cR6P7o`,K756hm69@\\;8OQ!&3]g5.9MeM`8Q88W:-'s^2`h"
	String fldrSav0= GetDataFolder(1)
	SetDataFolder root:MIES:ITCDevices:ITC18USB:Device0:TestPulse:
	Display/W=(471,34,481,539)/FG=(UGV1,,UGV0,UGH0)/HOST=# /HIDE=1 /L=AD0 TestPulseITC[*][1]
	AppendToGraph/R=SSResistance0 SSResistance[*][0],InstResistance[*][0]
	SetDataFolder fldrSav0
	ModifyGraph width=25,wbRGB=(61440,61440,61440),gbRGB=(61440,61440,61440)
	ModifyGraph mode(SSResistance)=2
	ModifyGraph lSize(SSResistance)=0
	ModifyGraph live=1
	ModifyGraph noLabel(SSResistance0)=2
	ModifyGraph axThick(SSResistance0)=0
	ModifyGraph lblPosMode(AD0)=1,lblPosMode(bottom)=1
	ModifyGraph freePos(AD0)={0,kwFraction}
	ModifyGraph freePos(SSResistance0)={1,kwFraction}
	ModifyGraph axisEnab(AD0)={0.025,1}
	ModifyGraph axisEnab(SSResistance0)={0.025,1}
	Label AD0 "AD0 (pA)"
	Label bottom "Time (\\U)"
	SetAxis/A=2/N=2 AD0
	SetAxis bottom 0,20
	SetAxis/A=2/N=2/E=2 SSResistance0 -20000000,20000000
	Tag/C/N=SSR0/I=1/F=0/B=1/X=-5.00/Y=-40.00/L=0 SSResistance, 0, "R\\Bss\\M\\OY \\Z10(M\\F'Symbol'W\\M)"
	Tag/C/N=InstR0/F=0/B=1/A=LT/X=-15.00/Y=-40.00/L=0 InstResistance, 0, "R\\Bpeak\\M \\OY \\Z10(M\\F'Symbol'W\\M)"
	RenameWindow #,Oscilloscope
	SetActiveSubwindow ##
EndMacro


//=========================================================================================
// DAP = Data Acquisition Panel
//=========================================================================================


Function CheckProc(cba) : CheckBoxControl
	STRUCT WMCheckboxAction &cba

	switch( cba.eventCode )
		case 2: // mouse up
			Variable checked = cba.checked
			break
		case -1: // control being killed
			checked = 0
			break
	endswitch

	return 0
End
//=========================================================================================

Function DAP_SetVarProc_DownSampLimit(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string cmd
	variable minsampint
	string panelTitle = DAP_ReturnPanelName()
	MinSampInt = DC_ITCMinSamplingInterval(panelTitle)
	SetVariable SetVar_DownSamp limits = {MinSampInt,inf,1}, win = $panelTitle
End
//=========================================================================================

Function DAP_CheckProc_UnivrslSrchStr(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	String SearchString
	string panelTitle = DAP_ReturnPanelName()
	DFREF saveDFR = GetDataFolderDFR()// creates a data folder reference that is later used to access the folder
	
	SetDataFolder root:MIES:WaveBuilder:SavedStimulusSets:DA:
	
	controlinfo /w = $panelTitle Search_DA_00
	if(strlen(s_value) == 0)
		SearchString = "*da*"
	else
		SearchString = s_value
	endif
	
	String DAPopUpMenuName// = "Wave_DA_"
	string IndexEndPopUpMenuName
	String FirstTwoMenuItems = "\"- none -; TestPulse;"
	variable i = 0
	string popupValue = FirstTwoMenuItems + wavelist(searchstring,";","") + "\""
	string ListOfWaves = 	wavelist(searchstring,";","")
	do
		DAPopUpMenuName = "Wave_DA_0" + num2str(i)
		PopupMenu $DAPopUpMenuName win = $panelTitle, value = #popupValue, userData(menuExp) = ListOfWaves
	
		IndexEndPopUpMenuName = "Popup_DA_IndexEnd_0" + num2str(i)
		PopupMenu $IndexEndPopUpMenuName win = $panelTitle, value = #popupValue
		i += 1
	while(i < 8)
	setdatafolder saveDFR
End
//=========================================================================================


Function DAP_SetVarProc_TTLSearch(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	String TTL_No = ctrlName[11,inf]
	String TTLPopUpMenuName = "Wave_TTL_" + TTL_No
	String TTLIndexEndPopMenuName="Popup_TTL_IndexEnd_" + TTL_No
	String FirstTwoMenuItems = "\"- none -;"
	String SearchString
	String value, ListOfWaves
	variable i = 0
	string panelTitle = DAP_ReturnPanelName()
	
	DFREF saveDFR = GetDataFolderDFR()// creates a data folder reference that is later used to access the folder
	SetDataFolder root:MIES:WaveBuilder:SavedStimulusSets:TTL:
	
	controlinfo /w = $panelTitle SearchUniversal_TTL_00
	if(v_value == 1)
		controlinfo /w = $panelTitle Search_TTL_00
		If(strlen(s_value) == 0)
			SearchString = "*TTL*"
		else
			SearchString = s_value
		endif
		
		value = FirstTwoMenuItems + wavelist(SearchString,";","") + "\""
		listOfWaves = wavelist(searchstring,";","")

		do
			TTLPopUpMenuName = "Wave_TTL_0" + num2str(i)
			popupmenu $TTLPopUpMenuName win = $panelTitle, value = #value, userdata(MenuExp) = ListOfWaves
			TTLIndexEndPopMenuName = "Popup_TTL_IndexEnd_0" + num2str(i)
			popupmenu $TTLIndexEndPopMenuName win = $panelTitle, value = #value
			i += 1
		while(i < 8)
	
	else
		If(strlen(varstr) == 0)
			SearchString = "*TTL*"
			value = FirstTwoMenuItems+wavelist(SearchString,";","") + "\""
			listOfWaves = wavelist(searchstring,";","")
			TTLPopUpMenuName = "Wave_TTL_0" + num2str(i)
			popupmenu $TTLPopUpMenuName win = $panelTitle, value = #value, userdata(MenuExp) = ListOfWaves
			TTLIndexEndPopMenuName = "Popup_TTL_IndexEnd_0" + num2str(i)
			popupmenu $TTLIndexEndPopMenuName win = $panelTitle, value = #value
		else
			SearchString = varstr
			value = FirstTwoMenuItems + wavelist(SearchString,";","") + "\""
			listOfWaves = wavelist(searchstring,";","")
			TTLPopUpMenuName = "Wave_TTL_0" + num2str(i)
			popupmenu $TTLPopUpMenuName win = $panelTitle, value = #value, userdata(MenuExp) = ListOfWaves
			TTLIndexEndPopMenuName = "Popup_TTL_IndexEnd_0" + num2str(i)
			popupmenu $TTLIndexEndPopMenuName win = $panelTitle, value = #value
		endif
	endif
	setdatafolder saveDFR
End
//=========================================================================================


Function DAP_CheckProc_UnivrslSrchTTL(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	String SearchString
	string panelTitle=DAP_ReturnPanelName()
	
	DFREF saveDFR = GetDataFolderDFR()// creates a data folder reference that is later used to access the folder
	SetDataFolder root:MIES:WaveBuilder:SavedStimulusSets:TTL:
	
	controlinfo /w = $panelTitle Search_TTL_00
	if(strlen(s_value) == 0)
		SearchString = "*TTL*"
	else
		SearchString = s_value
	endif
	
	String TTLPopUpMenuName // = "Wave_DA_"
	String IndexEndPopUpMenuName
	String FirstTwoMenuItems = "\"- none -;"
	variable i = 0
	
	string popupValue = FirstTwoMenuItems+wavelist(searchstring,";","") + "\""
	string listOfWaves = wavelist(searchstring,";","")
	do
		TTLPopUpMenuName = "Wave_TTL_0" + num2str(i)
		popupmenu $TTLPopUpMenuName win = $panelTitle, value = #popupValue, userdata(MenuExp) = ListOfWaves
		IndexEndPopUpMenuName = "Popup_TTL_IndexEnd_0" + num2str(i)
		popupmenu $IndexEndPopUpMenuName win = $panelTitle, value = #popupValue
		i += 1
	while(i < 8)

	setdatafolder saveDFR
End
//=========================================================================================


Function DAP_TabTJHook1(tca)//This is a function that gets run by ACLight's tab control function every time a tab is selected
	STRUCT WMTabControlAction &tca
	variable tabnum , i = 0, MinSampInt
	SVAR /z ITCPanelTitleList = root:MIES:ITCDevices:ITCPanelTitleList
	string panelTitle
	tabnum = tca.tab
	
	// Is the panel that is being interacted with locked?
	if(stringmatch(WinList("DA_Ephys", ";", "WIN:" ),"DA_Ephys;") == 0)// checks to see if panel has been assigned to a ITC device by checking if the panel name is the default name
		// Does the global string that contains the list of locked panels exist?
		if(exists("root:MIES:ITCDevices:ITCPanelTitleList") == 2)
			if(tabnum == 0)
				do
					panelTitle = stringfromlist(i, ITCPanelTitleList,";")
					MinSampInt = DC_ITCMinSamplingInterval(PanelTitle)
					ValDisplay ValDisp_DataAcq_SamplingInt win = $PanelTitle, value=_NUM:MinSampInt
					controlUpdate /w = $PanelTitle ValDisp_DataAcq_SamplingInt
					i += 1
				while(i < itemsinlist(ITCPanelTitleList,";"))
			endif
		else
			print "Please lock the panel to a ITC device in the Hardware tab"
		endif
	else
		print "Please lock the panel to a ITC device in the Hardware tab"
	endif
//	if(tabnum==1)// this does not work because hook function runs prior to adams tab functions (i assume)
//	controlinfo/w=datapro_itc1600 Check_DataAcq_Indexing
//		if(v_value==0)
//		TitleBox Title_DAC_IndexStartEnd disable=1, win=datapro_itc1600
//		DAP_ChangePopUpState("Popup_DA_IndexEnd_0",1)
//		endif
//	endif
	return 0
End
//=========================================================================================

Function DAP_SetVarProc_DASearch(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	String DA_No = ctrlName[10,inf]
	String DAPopUpMenuName = "Wave_DA_" + DA_No
	String IndexEndPopUpMenuName = "Popup_DA_IndexEnd_" + DA_No
	String FirstTwoMenuItems = "\"- none -; TestPulse;"
	String SearchString
	string popupValue, ListOfWaves
	variable i = 0
	
	string panelTitle = DAP_ReturnPanelName()
	
	DFREF saveDFR = GetDataFolderDFR()
	setdatafolder root:MIES:WaveBuilder:savedStimulusSets:DA
	controlinfo /w = $panelTitle SearchUniversal_DA_00	
	
	
	if(v_value == 1)
		controlinfo /w = $panelTitle Search_DA_00
		If(strlen(s_value) == 0)
			SearchString = "*DA*"
		else
			SearchString = s_value
		endif
		
		do
			DAPopUpMenuName = "Wave_DA_0" + num2str(i)
			popupValue = FirstTwoMenuItems+wavelist(searchstring,";","") + "\""
			listOfWaves = wavelist(searchstring,";","")
			popupmenu $DAPopUpMenuName win = $panelTitle, value = #popupValue, userdata(MenuExp) = ListOfWaves
			IndexEndPopUpMenuName = "Popup_DA_IndexEnd_0" + num2str(i)
			popupmenu $IndexEndPopUpMenuName win = $panelTitle, value = #popupValue
			i += 1
		while(i < 8)
	
	else
		If(strlen(varstr) == 0)
			SearchString = "*DA*"
			DAPopUpMenuName = "Wave_DA_0" + num2str(i)
			popupValue = FirstTwoMenuItems + wavelist(searchstring,";","") + "\""
			listOfWaves = wavelist(searchstring,";","")
			popupmenu $DAPopUpMenuName win = $panelTitle, value = #popupValue, userdata(MenuExp) = ListOfWaves
			IndexEndPopUpMenuName = "Popup_DA_IndexEnd_0" + num2str(i)
			popupmenu $IndexEndPopUpMenuName win = $panelTitle, value = #popupValue
		else
			DAPopUpMenuName = "Wave_DA_0" + num2str(i)
			popupValue = FirstTwoMenuItems + wavelist(varstr,";","") + "\""
			popupmenu $DAPopUpMenuName win = $panelTitle, value = #popupValue, userdata(MenuExp) = popupValue
			IndexEndPopUpMenuName = "Popup_DA_IndexEnd_0" + num2str(i)
			popupmenu $IndexEndPopUpMenuName win = $panelTitle, value = #popupValue
		endif
	endif
	setdatafolder saveDFR
End
//=========================================================================================

Function DAP_DAorTTLCheckProc(ctrlName,checked) : CheckBoxControl//This procedure checks to see that a DAC or TTL wave is selected before turning on the corresponding channel
	String ctrlName
	Variable checked
	String DACWave = ctrlName
	DACwave[0,4] = "wave"

	string panelTitle = DAP_ReturnPanelName()
	
	controlinfo /w = $panelTitle $DACWave
	if(stringmatch(s_value,"- none -") == 1)
	checkbox $ctrlName win = $panelTitle, value = 0
	print "Select " + DACwave[5,7] + " Wave"
	endif

	variable MinSampInt = DC_ITCMinSamplingInterval(PanelTitle)
	ValDisplay ValDisp_DataAcq_SamplingInt win = $PanelTitle, value= _NUM:MinSampInt
	
	controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
	valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxNoOfSweeps(PanelTitle,0) * v_value)
	valdisplay valdisp_DataAcq_SweepsActiveSet win = $panelTitle, value = _NUM:IDX_MaxNoOfSweeps(PanelTitle,1)
End
//=========================================================================================

Function DAP_ButtonProc_AcquireData(ctrlName) : ButtonControl
	String ctrlName
	setdatafolder root:
	string PanelTitle = DAP_ReturnPanelName()

	AbortOnValue HSU_DeviceLockCheck(panelTitle),1  // prevents initiation of data acquisition if panel is not locked to a device
	
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	string DataAcqStatePath = WavePath + ":DataAcqState"
	//print DataAcqStatePath
	if(exists(DataAcqStatePath) == 0) // creates the global variable that it used to determine the state of data aquistion for the particular device
		variable /G $DataAcqStatePath = 0
	endif
	
	NVAR /z DataAcqState = $DataAcqStatePath 

		
	if(DataAcqState == 0) // data aquistion is stopped
		
	
		if(TP_IsBackgrounOpRunning(panelTitle, "testpulse") == 1) // stops test pulse if it is running
			ITC_STOPTestPulse(panelTitle)
		endif
		
		wave /z ITCDataWave = $WavePath + ":ITCDataWave"
		
		string CountPath = WavePath + ":count"
		if(exists(CountPath) == 2)
			killvariables $CountPath
		endif
		
		controlinfo /w = $panelTitle popup_MoreSettings_DeviceType
		variable DeviceType = v_value - 1
		controlinfo /w = $panelTitle popup_moreSettings_DeviceNo
		variable DeviceNum = v_value - 1
		
		//History management
		controlinfo check_Settings_Overwrite
		if(v_value == 1)//if overwrite old waves is checked in datapro panel, the following code will delete the old waves and generate a new settings history wave 
			
			if(DM_IsLastSwpGreatrThnNxtSwp(panelTitle) == 1)//Checks for manual roll back of Next Sweep
				controlinfo SetVar_Sweep
				variable NextSweep = v_value
				DM_DeleteSettingsHistoryWaves(NextSweep, panelTitle)
				DM_DeleteDataWaves(panelTitle, NextSweep)
				ED_MakeSettingsHistoryWave(panelTitle)// generates new settings history wave
			endif
		
		endif
		
		//Data collection
		//Function that assess how many 1d waves in set??
		//Function that passes column to configdataForITCfunction?
		//If a set with multiple 1d waves is chosen, repeated aquisition should be activated automatically. globals should be used to keep track of columns
		//
		DC_ConfigureDataForITC(PanelTitle)
		SCOPE_UpdateGraph(ITCDataWave, panelTitle)
		ControlInfo /w = $panelTitle Check_Settings_BackgrndDataAcq// determines if end user wants back for fore groud acquisition
		If(v_value == 0)
		ITC_DataAcq(DeviceType,DeviceNum, panelTitle) // start fore ground data acq
			controlinfo /w = $panelTitle Check_DataAcq1_RepeatAcq// checks for repeated acquisition
			if(v_value == 1)//repeated aquisition is selected
				DataAcqState = 1 // because the TP during repeated acq is, at this time, always run in the background. there is the opportunity to hit the data acq button during RA. this stops data acq
				DAP_AcqDataButtonToStopButton(panelTitle)	// when RA code is modified to have foreground TP during RA, this will not be needed
				RA_Start(PanelTitle)
			endif
		else // background data acq
			DataAcqState = 1
			DAP_AcqDataButtonToStopButton(panelTitle)
			ITC_BkrdDataAcq(DeviceType,DeviceNum, panelTitle) // initiates background aquisition
		endif
	else // data aquistion is ongoing
		DataAcqState = 0
		DAP_StopOngoingDataAcquisition(PanelTitle)
		DAP_StopButtonToAcqDataButton(panelTitle)
	endif		
		
		//print "device type = ", devicetype, " Device Number = ", devicenum		
End
//=========================================================================================

Function DAP_CheckProc_SaveData(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string panelTitle = DAP_ReturnPanelName()

	If(Checked == 1)
		Button DataAcquireButton fColor = (52224,0,0), win = $panelTitle
		string ButtonText = "\\Z12\\f01Acquire Data\r * DATA WILL NOT BE SAVED *"
		ButtonText += "\r\\Z08\\f00 (autosave state is in settings tab)"
		Button DataAcquireButton title=ButtonText
	else
		Button DataAcquireButton fColor = (0,0,0), win = $panelTitle
		Button DataAcquireButton title = "\\Z14\\f01Acquire\rData"
	endif
End
//=========================================================================================

Function DAP_CheckProc_IndexingState(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	string panelTitle = DAP_ReturnPanelName()
	// updates sweeps in cycle value - when indexing is off, only the start set is counted, whend indexing is on all sets between start and end set are counted
	controlinfo /w = $panelTitle Check_DataAcq1_IndexingLocked
	if(v_value == 0)
		controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
		valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxNoOfSweeps(PanelTitle,0) * v_value)
		valDisplay valdisp_DataAcq_SweepsActiveSet win=$panelTitle, value = _NUM:IDX_MaxNoOfSweeps(PanelTitle,1)
	else
		controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
		valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxSweepsLockedIndexing(panelTitle) * v_value)
		valDisplay valdisp_DataAcq_SweepsActiveSet win = $panelTitle, value = _NUM:IDX_MaxNoOfSweeps(PanelTitle,1)	
	endif
End
//=========================================================================================

Function DAP_ChangePopUpState(BaseName, state, panelTitle)
	string BaseName, panelTitle// Popup_DA_IndexEnd_0
	variable state
	variable i = 0
	string CompleteName
	
	do
		CompleteName = Basename + num2str(i)
		PopupMenu $CompleteName disable = state, win = $panelTitle
		i += 1
	while(i < 8)
End
//=========================================================================================

Function DAP_SmoothResizePanel(RightShift, panelTitle)
	variable RightShift
	string panelTitle
	variable i
	variable resizeLimit = abs(RightShift)
	getwindow $panelTitle wsize
	
	do
		if(rightshift>=0)
			movewindow /w = $panelTitle v_left, v_top, v_right+i, v_bottom
		else
			movewindow /w = $panelTitle v_left, v_top, v_right-i, v_bottom
		endif
		
		i += 3
	while(i < resizeLimit)
End
//=========================================================================================

Function DAP_CheckProc_ShowScopeWin(ctrlName,checked) : CheckBoxControl // need to modify this function so the panel always returns to it's original size
	String ctrlName
	Variable checked
	string panelTitle = DAP_ReturnPanelName()
	
	if(checked == 1)
		DAP_SmoothResizePanel(340, panelTitle)
		setwindow $panelTitle + "#oscilloscope", hide =0
	else
		DAP_SmoothResizePanel(-340, panelTitle)
		setwindow $panelTitle + "#oscilloscope", hide =1
	endif
End
//=========================================================================================

Function DAP_TurnOffAllTTLs(panelTitle)
	string panelTitle
	variable i, NoOfTTLs
	string TTLCheckBoxName
	
	NoOfTTLs=DC_TotNoOfControlType("check", "TTL", panelTitle)
	
	for(i = 0; i < NoOfTTLs; i += 1)
		TTLCheckBoxName = "Check_TTL_0"+num2str(i)
		CheckBox $TTLCheckBoxName win = $panelTitle, value = 0
	endfor
End
//=========================================================================================

Function DAP_StoreTTLState(panelTitle)
	string panelTitle
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	string /g $WavePath + ":StoredTTLState" = DC_ControlStatusListString("TTL", "Check", panelTitle)
End
//=========================================================================================

Function DAP_RestoreTTLState(panelTitle)
	string panelTitle
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	SVAR StoredTTLState = $WavePath + ":StoredTTLState"
	variable i, NoOfTTLs, CheckBoxState
	string TTLCheckBoxName
	
	NoOfTTLs = DC_TotNoOfControlType("check", "TTL", panelTitle)
	
	for(i = 0; i < NoOfTTLs; i += 1)
		TTLCheckBoxName = "Check_TTL_0" + num2str(i)
		CheckBoxState = str2num(stringfromlist(i , StoredTTLState,";"))
		CheckBox $TTLCheckBoxName win = $panelTitle, value = CheckBoxState
	endfor

	killstrings StoredTTLState
End
//=========================================================================================

Function DAP_ButtonProc_TTLOff(ctrlName) : ButtonControl
	String ctrlName
	string panelTitle = DAP_ReturnPanelName()
	
	DAP_TurnOffAllTTLs(panelTitle)
End
//=========================================================================================

Function DAP_TurnOffAllDACs(panelTitle)
	string panelTitle
	variable i, NoOfDACs
	string DACCheckBoxName
	
	NoOfDACs = DC_TotNoOfControlType("check", "DA", panelTitle)
	
	for(i = 0; i < NoOfDACs; i += 1)
		DACCheckBoxName = "Check_DA_0" + num2str(i)
		CheckBox $DACCheckBoxName win = $panelTitle, value = 0
	endfor
End
//=========================================================================================

Function DAP_ButtonProc_DAOff(ctrlName) : ButtonControl
	String ctrlName
	string panelTitle = DAP_ReturnPanelName()
	DAP_TurnOffAllDACs(panelTitle)
End
//=========================================================================================

Function DAP_TurnOffAllADCs(panelTitle)
	string panelTitle
	variable i, NoOfADCs
	string ADCCheckBoxName
	
	NoOfADCs = DC_TotNoOfControlType("check", "AD", panelTitle)
	
	for(i = 0; i < NoOfADCs;i += 1)
		if(i < 10)
			ADCCheckBoxName = "Check_AD_0" + num2str(i)
			CheckBox $ADCCheckBoxName win = $panelTitle, value = 0
		else
			ADCCheckBoxName = "Check_AD_" + num2str(i)
			CheckBox $ADCCheckBoxName win=$panelTitle, value=0
		endif
	endfor
End
//=========================================================================================

Function DAP_ButtonProc_ADOff(ctrlName) : ButtonControl
	String ctrlName
	string panelTitle = DAP_ReturnPanelName()
	DAP_TurnOffAllADCs(panelTitle)
End
//=========================================================================================

Function DAP_TurnOffAllHeadstages(panelTitle)
	string panelTitle
//Check_DataAcq_Cell0
	variable i, NoOfHeadstages
	string DACCheckBoxName
	
	NoOfHeadstages = DC_TotNoOfControlType("check", "DataAcq_HS", panelTitle)
	
	for(i = 0; i < NoOfHeadstages; i += 1)
		DACCheckBoxName = "Check_DataAcq_HS_0"+num2str(i)
		CheckBox $DACCheckBoxName win = $panelTitle, value = 0
	endfor
End
//=========================================================================================

Function DAP_ButtonProc_AllChanOff(ctrlName) : ButtonControl
	String ctrlName
	string panelTitle = DAP_ReturnPanelName()
	DAP_TurnOffAllHeadstages(panelTitle)
	DAP_TurnOffAllDACs(panelTitle)
	DAP_TurnOffAllADCs(panelTitle)
	DAP_TurnOffAllTTLs(panelTitle)
End
//=========================================================================================

Function DAP_PopMenuChkProc_StimSetList(ctrlName,popNum,popStr) : PopupMenuControl//Procedure for DA popupmenu's that show DA waveslist from wavebuilder
	String ctrlName
	Variable popNum
	String popStr
	string CheckBoxName = ctrlName
	string ListOfWavesInFolder
	string folderPath
	string folder
	string panelTitle = DAP_ReturnPanelName()
	DFREF saveDFR = GetDataFolderDFR()
	
	if(stringmatch(ctrlName,"*indexEnd*") != 1)//makes sure it is the index start wave
		if(popnum == 1)//if the user selects "none" the channel is automatically turned off
		CheckBoxName[0,3] = "check"
		Checkbox $Checkboxname win = $panelTitle, value = 0
		endif
	endif
	
	if(stringmatch(ctrlname,"*_DA_*") == 1)
		if(popnum == 2)
			popupmenu $ctrlname win = $panelTitle, mode = 3// prevents the user from selecting the testpulse
		endif
	endif
	if(stringmatch(ctrlName, "*_DA_*") == 1)// determines wether to a DA or TTL popup menu needs to be populated
		FolderPath = "root:MIES:waveBuilder:savedStimulusSets:DA"
		folder = "*DA*"
		setdatafolder FolderPath// sets the wavelist for the DA popup menu to show all waves in DAC folder
		ListOfWavesInFolder = "\"- none -;TestPulse;\"" + "+" + "\"" + Wavelist(Folder,";","") + "\""// DA popups have testpulse listed as option
	else
		FolderPath = "root:MIES:waveBuilder:savedStimulusSets:TTL"
		folder = "*TTL*"
		setdatafolder FolderPath// sets the wavelist for the DA popup menu to show all waves in DAC folder
		ListOfWavesInFolder = "\"- none -;\"" + "+" + "\"" + Wavelist(Folder,";","") + "\""
	endif
	
	PopupMenu  $ctrlName win = $panelTitle, value = #ListOfWavesInFolder, userdata(MenExp) = ListOfWavesInFolder
	setdatafolder saveDFR// makes sure data acq starts in the correct folder!!
	
	controlinfo /w = $panelTitle Check_DataAcq1_IndexingLocked
	if(v_value == 0)
		controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
		valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxNoOfSweeps(PanelTitle,0) * v_value)
		valDisplay valdisp_DataAcq_SweepsActiveSet win=$panelTitle, value=_NUM:IDX_MaxNoOfSweeps(PanelTitle,1)
	else
		controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
		valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxSweepsLockedIndexing(panelTitle) * v_value)
		valDisplay valdisp_DataAcq_SweepsActiveSet win = $panelTitle, value = _NUM:IDX_MaxNoOfSweeps(PanelTitle,1)	
	endif
End
//=========================================================================================

Function DAP_SetVarProc_NextSweepLimit(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string PanelTitle = DAP_ReturnPanelName()
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	DFREF saveDFR = GetDataFolderDFR()
	setDataFolder $WavePath + ":data"
	string ListOfDataWaves = wavelist("Sweep_*",";","MINCOLS:2")
	setDataFolder saveDFR
	SetVariable SetVar_Sweep win = $panelTitle, limits = {0,itemsinlist(ListOfDataWaves),1}
End
//=========================================================================================

Function DAP_UpdateITCMinSampIntDisplay()
	getwindow kwTopWin wtitle
	string panelTitle = DAP_ReturnPanelName()
	variable MinSampInt = DC_ITCMinSamplingInterval(PanelTitle)
	ValDisplay ValDisp_DataAcq_SamplingInt win = $PanelTitle, value = _NUM:MinSampInt
End
//=========================================================================================

Function DAP_CheckProc_UnpdateMinSampInt(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	DAP_UpdateITCMinSampIntDisplay()
End
//=========================================================================================

Function DAP_SetVarProc_TotSweepCount(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string panelTitle = DAP_ReturnPanelName()	

	controlinfo /w = $panelTitle Check_DataAcq1_IndexingLocked
	if(v_value == 0)
		controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
		valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxNoOfSweeps(PanelTitle,0) * v_value)
		valDisplay valdisp_DataAcq_SweepsActiveSet win = $panelTitle, value = _NUM:IDX_MaxNoOfSweeps(PanelTitle,1)
	else
		controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats
		valDisplay valdisp_DataAcq_SweepsInSet win = $panelTitle, value = _NUM:(IDX_MaxSweepsLockedIndexing(panelTitle) * v_value)
		valDisplay valdisp_DataAcq_SweepsActiveSet win = $panelTitle, value = _NUM:IDX_MaxNoOfSweeps(PanelTitle,1)	
	endif
End
//=========================================================================================

Function /T DAP_ReturnPanelName()	
	string panelTitle
	getwindow kwTopWin activesw
	PanelTitle = s_value
	if(stringmatch(panelTitle, "ITC*") == 1) // makes sure DataAcq panel is the selected panel type
		variable SearchResult = strsearch(panelTitle, "Oscilloscope", 2)
		if(SearchResult != -1)
			PanelTitle = PanelTitle[0, SearchResult - 2]//SearchResult+1]
		endif
		return PanelTitle
	elseif (stringmatch(panelTitle, "ITC*")== 0) // this else if does not return anything useful - all functions that call this function would return an error if this elseif was run
		return ""	
	endif
End
//=========================================================================================

Function DAP_PopMenuProc_DevTypeChk(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	getwindow kwTopWin wtitle
	HSU_IsDeviceTypeConnected(s_value)
End
//=========================================================================================

Function DAP_FindConnectedAmps(ctrlName) : ButtonControl
	String ctrlName
	make /o /n = 0 root:MIES:Amplifiers:W_TelegraphServers
	DFREF saveDFR = GetDataFolderDFR()
	SetDataFolder root:MIES:Amplifiers
	AxonTelegraphFindServers
	SetDataFolder saveDFR
	getwindow kwTopWin wtitle
	string PopUpList = "\" - none - ;" 
	PopUpList += AI_ReturnListOf700BChannels(s_value)+"\""
	popupmenu  popup_Settings_Amplifier win = $s_value, value = #PopUpList
End
//=========================================================================================

Function DAP_PopMenuProc_Headstage(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	getwindow kwTopWin wtitle
	HSU_UpdateChanAmpAssignPanel(s_value)
End
//=========================================================================================

Function DAP_PopMenuProc_CAA(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	getwindow kwTopWin wtitle
	HSU_UpdateChanAmpAssignStorWv(s_value)
End
//=========================================================================================

Function DAP_SetVarProc_CAA(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	getwindow kwTopWin wtitle
	HSU_UpdateChanAmpAssignStorWv(s_value)
End
//=========================================================================================

Function DAP_ApplyClmpModeSavdSettngs(HeadStageNo, ClampMode, panelTitle)
	variable HeadStageNo, ClampMode// 0 = VC, 1 = IC
	string panelTitle
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	wave ChanAmpAssign = $WavePath + ":ChanAmpAssign"
	string DACheck, DAGain, DAUnit, ADCheck, ADGain, ADUnit
	wave ChannelClampMode = $WavePath + ":ChannelClampMode"
	wave /T ChanAmpAssignUnit = $WavePath + ":ChanAmpAssignUnit"
	
	If(ClampMode == 0)
		DACheck = "Check_DA_0" + num2str(ChanAmpAssign[0][HeadStageNo])
		CheckBox $DACheck win = $panelTitle, value = 1
		
		DAGain = "Gain_DA_0" + num2str(ChanAmpAssign[0][HeadStageNo])
		SetVariable $DAGain win = $panelTitle, value = _num:ChanAmpAssign[1][HeadStageNo]
		
		DAUnit = "Unit_DA_0" + num2str(ChanAmpAssign[0][HeadStageNo])
		SetVariable $DAUnit win = $panelTitle, value = _str:ChanAmpAssignUnit[0][HeadStageNo]
		
		// ChanAmpAssign[0][HeadStageNo] is the channel number of the amp associated with the MIES headstage - it is either 0 or 1
		ChannelClampMode[ChanAmpAssign[0][HeadStageNo]][0] = ClampMode // this line of code updates the wave that stores the clamp mode status of a channel
		
		If(ChanAmpAssign[2][HeadStageNo] < 10)
		ADCheck = "Check_AD_0" + num2str(ChanAmpAssign[2][HeadStageNo])
		CheckBox $ADCheck win = $panelTitle, value = 1

		ADGain = "Gain_AD_0"+num2str(ChanAmpAssign[2][HeadStageNo])
		SetVariable $ADGain win = $panelTitle, value = _num:ChanAmpAssign[3][HeadStageNo]

		ADUnit = "Unit_AD_0"+num2str(ChanAmpAssign[2][HeadStageNo])
		SetVariable $ADUnit win = $panelTitle, value = _str:ChanAmpAssignUnit[1][HeadStageNo]
			
		ChannelClampMode[ChanAmpAssign[2][HeadStageNo]][1] = ClampMode

		else
		ADCheck = "Check_AD_" + num2str(ChanAmpAssign[2][HeadStageNo])
		CheckBox $ADCheck win = $panelTitle, value = 1
			
		ADGain = "Gain_AD_" + num2str(ChanAmpAssign[2][HeadStageNo])
		SetVariable $ADGain win = $panelTitle, value = _num:ChanAmpAssign[3][HeadStageNo]	

		ADUnit = "Unit_AD_" + num2str(ChanAmpAssign[2][HeadStageNo])
		SetVariable $ADUnit win = $panelTitle, value = _str:ChanAmpAssignUnit[1][HeadStageNo]	
				
		ChannelClampMode[ChanAmpAssign[2][HeadStageNo]][1] = ClampMode

		endif
	endIf
	
	If(ClampMode == 1)
		DACheck = "Check_DA_0" + num2str(ChanAmpAssign[4][HeadStageNo])
		CheckBox $DACheck win = $panelTitle, value = 1
		
		DAGain = "Gain_DA_0" + num2str(ChanAmpAssign[4][HeadStageNo])
		SetVariable $DAGain win = $panelTitle, value = _num:ChanAmpAssign[5][HeadStageNo]

		DAUnit = "Unit_DA_0" + num2str(ChanAmpAssign[0][HeadStageNo])
		SetVariable $DAUnit win = $panelTitle, value = _str:ChanAmpAssignUnit[2][HeadStageNo]
		
		ChannelClampMode[ChanAmpAssign[4][HeadStageNo]][0] = ClampMode

		If(ChanAmpAssign[6][HeadStageNo] < 10)
		ADCheck = "Check_AD_0" + num2str(ChanAmpAssign[6][HeadStageNo])
		CheckBox $ADCheck win = $panelTitle, value = 1
				
		ADGain = "Gain_AD_0"+num2str(ChanAmpAssign[6][HeadStageNo])
		SetVariable $ADGain win = $panelTitle, value = _num:ChanAmpAssign[7][HeadStageNo]

		ADUnit = "Unit_AD_0" + num2str(ChanAmpAssign[2][HeadStageNo])
		SetVariable $ADUnit win = $panelTitle, value = _str:ChanAmpAssignUnit[3][HeadStageNo]	
		
		ChannelClampMode[ChanAmpAssign[6][HeadStageNo]][1] = ClampMode

		else
		ADCheck = "Check_AD_" + num2str(ChanAmpAssign[6][HeadStageNo])
		CheckBox $ADCheck win = $panelTitle, value = 1
				
		ADGain = "Gain_AD_"+num2str(ChanAmpAssign[6][HeadStageNo])
		SetVariable $ADGain win = $panelTitle, value = _num:ChanAmpAssign[7][HeadStageNo]	

		ADUnit = "Unit_AD_0" + num2str(ChanAmpAssign[2][HeadStageNo])
		SetVariable $ADUnit win = $panelTitle, value = _str:ChanAmpAssignUnit[3][HeadStageNo]	
		
		ChannelClampMode[ChanAmpAssign[6][HeadStageNo]][1] = ClampMode

		endif
	endIf
End
//=========================================================================================

Function DAP_RemoveClampModeSettings(HeadStageNo, ClampMode, panelTitle)
	variable HeadStageNo, ClampMode// 0 = VC, 1 = IC
	string panelTitle
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	wave ChanAmpAssign = $WavePath + ":ChanAmpAssign"
	string DACheck, DAGain, ADCheck, ADGain
	wave ChannelClampMode = $WavePath + ":ChannelClampMode"
	
	If(ClampMode == 0)
		DACheck = "Check_DA_0"+num2str(ChanAmpAssign[0][HeadStageNo])
		CheckBox $DACheck value = 0
		
		ChannelClampMode[ChanAmpAssign[0][HeadStageNo]][0] = nan
		
		If(ChanAmpAssign[2][HeadStageNo] < 10)
		ADCheck = "Check_AD_0" + num2str(ChanAmpAssign[2][HeadStageNo])
		CheckBox $ADCheck value = 0
		
		ChannelClampMode[ChanAmpAssign[2][HeadStageNo]][1] = nan
		else
		ADCheck = "Check_AD_" + num2str(ChanAmpAssign[2][HeadStageNo])
		CheckBox $ADCheck value = 0
		
		ChannelClampMode[ChanAmpAssign[2][HeadStageNo]][1] = nan
		endif
	endIf

	If(ClampMode == 1)
		DACheck = "Check_DA_0" + num2str(ChanAmpAssign[4][HeadStageNo])
		CheckBox $DACheck value = 0
		
		ChannelClampMode[ChanAmpAssign[4][HeadStageNo]][0] = nan
		
		If(ChanAmpAssign[6][HeadStageNo] < 10)
		ADCheck = "Check_AD_0" + num2str(ChanAmpAssign[6][HeadStageNo])
		CheckBox $ADCheck value = 0
		
		ChannelClampMode[ChanAmpAssign[6][HeadStageNo]][1] = nan
		else
		ADCheck = "Check_AD_" + num2str(ChanAmpAssign[6][HeadStageNo])
		CheckBox $ADCheck value = 0
		
		ChannelClampMode[ChanAmpAssign[6][HeadStageNo]][1] = nan
		endif
	endIf
End
 //=========================================================================================

Function DAP_CheckProc_ClampMode(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	String PairedRadioButton = "Radio_ClampMode_"
	Variable RadioButtonNo = str2num(ctrlName[16,inf])
	string HeadStageCheckBox = "Check_DataAcq_HS_0"
	
	getwindow kwTopWin wtitle
	string panelTitle = s_value

	if(mod(RadioButtonNo,2) == 0)//even numbers = VC
		PairedRadioButton += (num2str(RadioButtonNo + 1))
		checkbox $PairedRadioButton value=0
		
		HeadStageCheckBox += num2str((RadioButtonNo / 2))
		//print headstagecheckbox
		controlinfo/w = $panelTitle $HeadStageCheckBox
		
		if(v_value == 1)//checks to see if headstage is "ON"
		DAP_RemoveClampModeSettings((RadioButtonNo / 2), 1,panelTitle)
		DAP_ApplyClmpModeSavdSettngs((RadioButtonNo / 2), 0,panelTitle)//Applies VC settings for headstage
		AI_SwitchClampMode(panelTitle, (RadioButtonNo / 2), 0)
		endif
		
	else // ODD = IC
		HeadStageCheckBox = "Check_DataAcq_HS_0"
		PairedRadioButton += (num2str(RadioButtonNo - 1))
		checkbox $PairedRadioButton value = 0
		HeadStageCheckBox += num2str(((RadioButtonNo - 1) / 2))
		controlinfo /w = $panelTitle $HeadStageCheckBox
		
		if(v_value == 1)//checks to see if headstage is "ON"
		DAP_RemoveClampModeSettings(((RadioButtonNo - 1) / 2), 0, panelTitle)
		DAP_ApplyClmpModeSavdSettngs(((RadioButtonNo - 1) / 2), 1,panelTitle)//Applies IC settings for headstage
		AI_SwitchClampMode(panelTitle, ((RadioButtonNo - 1) / 2), 1)
		endif

	endif
	
	variable MinSampInt = DC_ITCMinSamplingInterval(PanelTitle)
	ValDisplay ValDisp_DataAcq_SamplingInt win = $PanelTitle, value = _NUM:MinSampInt
End
//=========================================================================================

Function DAP_CheckProc_HedstgeChck(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	
	string RadioButtonName = "Radio_ClampMode_"
	Variable HeadStageNo = str2num(ctrlname[18])
	Variable ClampMode //
	getwindow kwTopWin wtitle
	string panelTitle = s_value
	RadioButtonName += num2str((HeadStageNo * 2) + 1)
	ControlInfo/w = $panelTitle $RadioButtonName
	ClampMode = v_value
	
	If(Checked == 0)
		DAP_RemoveClampModeSettings(HeadStageNo, ClampMode, panelTitle)
	else
		DAP_ApplyClmpModeSavdSettngs(HeadStageNo, ClampMode,panelTitle)
	endif
 
	variable MinSampInt = DC_ITCMinSamplingInterval(PanelTitle)
	ValDisplay ValDisp_DataAcq_SamplingInt win = $PanelTitle, value = _NUM:MinSampInt
End
//=========================================================================================

Function DAP_StopOngoingDataAcquisition(PanelTitle)
	string panelTitle
	string cmd 
	string WavePath = HSU_DataFullFolderPathString(PanelTitle)
	SVAR/z panelTitleG = $WavePath + ":panelTitleG"
	
	if(TP_IsBackgrounOpRunning(panelTitle, "testpulse") == 1) // stops the testpulse
		ITC_STOPTestPulse(panelTitle)
	endif
	
	
	if(TP_IsBackgrounOpRunning(panelTitle, "ITC_Timer") == 1) // stops the background timer
		CtrlNamedBackground ITC_Timer, stop 
	endif
	
	if(TP_IsBackgrounOpRunning(panelTitle, "ITC_FIFOMonitor") == 1) // stops ongoing bacground data aquistion
		 //ITC_StopDataAcq() - has calls to repeated aquistion so this cannot be used
		ITC_STOPFifoMonitor()
		
		sprintf cmd, "ITCStopAcq /z = 0"
		Execute cmd
	
		//sprintf cmd, "ITCCloseAll" 
		//execute cmd
	
		ControlInfo /w = $panelTitle Check_Settings_SaveData
		If(v_value == 0)
			DM_SaveITCData(panelTitle)// saving always comes before scaling - there are two independent scaling steps
		endif
		
		DM_ScaleITCDataWave(panelTitle)
	
	endif
	print "Data acquisition was manually terminated"
End 
//=========================================================================================

Function DAP_AcqDataButtonToStopButton(panelTitle)
	string panelTitle
	controlinfo /w = $PanelTitle Check_Settings_SaveData
	if(v_value == 0) // Save data
		Button DataAcquireButton fColor = (0,0,0), win = $panelTitle
		Button DataAcquireButton title = "\\Z14\\f01Stop\rAcquistion", win = $panelTitle
	else // Don't save data
		Button DataAcquireButton fColor = (52224,0,0), win = $panelTitle
		string ButtonText = "\\Z12\\f01Stop Acquisition\r * DATA WILL NOT BE SAVED *"
		ButtonText += "\r\\Z08\\f00 (autosave state is in settings tab)"
		Button DataAcquireButton title=ButtonText, win = $panelTitle
	endif	
End
//=========================================================================================

Function DAP_StopButtonToAcqDataButton(panelTitle)
	string panelTitle
	controlinfo /w = $PanelTitle Check_Settings_SaveData
	if(v_value == 0) // Save data
		Button DataAcquireButton fColor = (0,0,0), win = $panelTitle
		Button DataAcquireButton title = "\\Z14\\f01Acquire\rData", win = $panelTitle
	else // Don't save data
		Button DataAcquireButton fColor = (52224,0,0), win = $panelTitle
		string ButtonText = "\\Z12\\f01Acquire Data\r * DATA WILL NOT BE SAVED *"
		ButtonText += "\r\\Z08\\f00 (autosave state is in settings tab)"
		Button DataAcquireButton title=ButtonText, win = $panelTitle
	endif
End
//=========================================================================================

Function /C DAP_TwoOrMoreITC1600s(panelTitle) // returns a complex variable. If the real is = 1 then two or more locked ITC1600s are present. The imaginary component returns the number of locked ITC1600s
	string panelTitle
	variable /C YesNo
	SVAR PanelTitleList = root:MIES:ITCDevices:ITCPanelTitleList
	string ListOf1600s = ListMatch(PanelTitleList, "ITC1600*",";")
	variable NoOf1600s = itemsinlist(ListOf1600s, ";")
	
	if(NoOf1600s > 1)
		YesNo = cmplx(1,NoOf1600s)
	elseif(NoOf1600s < 1)
		YesNo = cmplx(0,NoOf1600s)
	endif
	
	return YesNo
End

ListMatch(root:MIES:ITCDevices:ITCPanelTitleList, "ITC1600*",";")
//=========================================================================================
// THE FUNCTION BELOW CONTROL THE ASSOCIATIONS BETWEEN THE BUTTONS IN THE YOKE SECTION OF THE 
// HARDWARE TAB ON THE DA_EPHYS() PANEL
//=========================================================================================

Function DAP_EnableYoking(panelTitle) // enables or disables the yoking controls on the DA_Ephys panel depending on the number of locked ITC1600s
	string panelTitle
	SVAR PanelTitleList = root:MIES:ITCDevices:ITCPanelTitleList // List of locked ITC devices
	string ListOf1600s = ListMatch(PanelTitleList, "ITC1600*",";")
	
	variable /C TwoOrMore1600s = DAP_TwoOrMoreITC1600s(panelTitle)
	variable i = 0
	if(real(TwoOrMore1600s) == 0)
		do
			panelTitle = stringfromlist(i, PanelTitleList, ";") // disables the yoking controls on the last remaining locked ITC1600 - also does all other panel types
			button button_Hardware_Lead1600 Win = $panelTitle, Disable = 2
			button button_Hardware_Independent Win = $panelTitle, Disable = 2
			titlebox title_hardware_1600inst Win = $panelTitle, Disable = 2
			titlebox title_hardware_Follow Win = $panelTitle, Disable = 2
			button button_Hardware_AddFollower Win = $panelTitle, Disable = 2
			popupmenu popup_Hardware_AvailITC1600s Win = $panelTitle, Disable = 2
			setvariable setvar_Hardware_YokeList Win = $panelTitle, Disable = 2
			i += 1
		while(i < itemsinlist(PanelTitleList, ";")) 
			// lines below disables the yoking controls on the panel that was just unlocked
			getwindow kwTopWin wtitle
			//print s_value
			button button_Hardware_Lead1600 Win = $s_value, Disable = 2
			button button_Hardware_Independent Win = $s_value, Disable = 2
			titlebox title_hardware_1600inst Win = $s_value, Disable = 2
			titlebox title_hardware_Follow Win = $s_value, Disable = 2
			button button_Hardware_AddFollower Win = $s_value, Disable = 2
			popupmenu popup_Hardware_AvailITC1600s Win = $s_value, Disable = 2
			setvariable setvar_Hardware_YokeList Win = $s_value, Disable = 2
	elseif(real(TwoOrMore1600s) == 1)
		do
			panelTitle = stringfromlist(i, ListOf1600s, ";") // enables the yoking controls on all the locked ITC1600s
			if(stringmatch(panelTitle,"ITC1600_Dev_0") == 1) // ensures yoking controls are only enabled on the ITC1600_Dev_0 - a requirement of the ITC XOP
				button button_Hardware_Lead1600 Win = $"ITC1600_Dev_0", Disable = 0
				button button_Hardware_Independent Win = $"ITC1600_Dev_0", Disable = 2
				titlebox title_hardware_1600inst Win = $"ITC1600_Dev_0", Disable = 0
				titlebox title_hardware_Follow Win = $"ITC1600_Dev_0", Disable = 2
				button button_Hardware_AddFollower Win = $"ITC1600_Dev_0", Disable = 2
				popupmenu popup_Hardware_AvailITC1600s Win = $"ITC1600_Dev_0", Disable = 2
				doupdate /W = $"ITC1600_Dev_0"
			else
				button button_Hardware_Lead1600 Win = $panelTitle, Disable = 2
				button button_Hardware_Independent Win = $panelTitle, Disable = 2
				titlebox title_hardware_1600inst Win = $panelTitle, Disable = 2
				titlebox title_hardware_Follow Win = $panelTitle, Disable = 2
				button button_Hardware_AddFollower Win = $panelTitle, Disable = 2
				popupmenu popup_Hardware_AvailITC1600s Win = $panelTitle, Disable = 2
			endif
			
			i += 1
		while(i < imag(TwoOrMore1600s))

	endif
End
//=========================================================================================

Function /t DAP_ListOfITCDevices() // used by popup_Hardware_AvailITC1600s  in hardware tab in yoke section
	SVAR ITCPanelTitleList = root:MIES:ITCDevices:ITCPanelTitleList
	string ListOfAllITC1600s = ListMatch(ITCPanelTitleList, "ITC1600*",";")
	getwindow kwTopWin wtitle
	string ListOfPotentialFollowerDevices = removefromlist(s_value,ListOfAllITC1600s)
	ListOfPotentialFollowerDevices = sortlist(ListOfPotentialFollowerDevices, ";", 16)
	return ListOfPotentialFollowerDevices
End
//=========================================================================================

Function DAP_ButtonProc_Lead(ctrlName) : ButtonControl // The Lead button in the yoking controls sets the attached ITC1600 as the device that will trigger all the other devices yoked to it.
	String ctrlName
	String PanelTitle = DAP_ReturnPanelName()
	if(stringmatch(panelTitle, "ITC1600_Dev_0") == 1) // ensures that only the first ITC1600 can be the lead device (trying to make other devices lead, returns a XOP error)
		button button_Hardware_Independent Win = $panelTitle, Disable = 0
		button button_Hardware_Lead1600 Win = $panelTitle, Disable = 2
		button button_Hardware_AddFollower Win = $panelTitle, Disable = 0
		popupmenu popup_Hardware_YokedDACs Win = $panelTitle, Disable = 2
		button button_Hardware_RemoveYoke Win = $panelTitle, Disable = 2
		titlebox title_hardware_Follow Win = $panelTitle, Disable = 0
		titlebox title_hardware_Release Win = $panelTitle, Disable = 2
		popupmenu popup_Hardware_AvailITC1600s Win = $panelTitle, Disable = 0
		SetVariable setvar_Hardware_Status Win = $panelTitle, value= _STR:"Lead"
	endif
End
//=========================================================================================

Function DAP_ButtonProc_Independent(ctrlName) : ButtonControl
	String ctrlName
	String PanelTitle = DAP_ReturnPanelName()
	button button_Hardware_Independent Win = $panelTitle, Disable = 2
	button button_Hardware_Lead1600 Win = $panelTitle, Disable = 0
	button button_Hardware_AddFollower Win = $panelTitle, Disable = 2
	popupmenu popup_Hardware_YokedDACs Win = $panelTitle, Disable = 2
	button button_Hardware_RemoveYoke Win = $panelTitle, Disable = 2
	titlebox title_hardware_Follow Win = $panelTitle, Disable = 2
	titlebox title_hardware_Release Win = $panelTitle, Disable = 2

	popupmenu popup_Hardware_AvailITC1600s Win = $panelTitle, Disable = 2
	SetVariable setvar_Hardware_Status Win = $panelTitle, value= _STR:"Independent"
	DAP_RemoveAllYokedDACs(panelTitle) // sets the initialization state appropriate for independent devices on all ITC1600s
	DAP_LastYokedDevRemovedSetCtrls(panelTitle) // sets the buttons on all ITC1600s back to the independent state.
End
//=========================================================================================

Function DAP_ButtonProc_Follow(ctrlName) : ButtonControl
	String ctrlName
	String PanelTitle = DAP_ReturnPanelName()
	controlinfo /w = $panelTitle popup_Hardware_AvailITC1600s
	string DeviceToBeAssignedAsFollower = s_value
	print "panel title =",paneltitle, "follower =", s_value
	
	HSU_SetITCDACasFollower(panelTitle, DeviceToBeAssignedAsFollower)
	DAP_SetFollowerButtons(panelTitle)

	popupmenu popup_Hardware_AvailITC1600s Win = $panelTitle, Disable = 0
	popupmenu popup_Hardware_YokedDACs Win = $panelTitle, Disable = 0
	button button_Hardware_RemoveYoke Win = $panelTitle, Disable = 0
	titlebox title_hardware_Release Win = $panelTitle, Disable = 0

End
//=========================================================================================
Function DAP_ButtonProc_YokeRelease(ctrlName) : ButtonControl
	String ctrlName
	String PanelTitle = DAP_ReturnPanelName()
	DAP_RemoveYokedDAC(panelTitle)
End
//=========================================================================================
Function DAP_RemoveYokedDAC(panelTitle)
	string panelTitle
	controlinfo /w = $panelTitle popup_Hardware_YokedDACs
	string panelToDeYoke =  s_value
	string UpdatedListOfFollowerDev = removefromlist(panelToDeYoke, Path_ListOfYokedDACs(panelTitle), ";")
	setvariable setvar_Hardware_YokeList Win = $panelTitle, value = _STR:UpdatedListOfFollowerDev // updated in panel display of yoked dacs
	
	SVAR ListOfFollowerITC1600s = $(HSU_DataFullFolderPathString(PanelTitle) + ":ListOfFollowerITC1600s")
	ListOfFollowerITC1600s = UpdatedListOfFollowerDev // updates global list of yoked dacs of the lead device
	titlebox title_hardware_1600inst win = $panelToDeYoke, disable = 0
	button button_Hardware_Lead1600 win = $panelToDeYoke, disable = 0
	
	string cmd
	string FollowerDeviceFolderPath = HSU_DataFullFolderPathString(panelToDeYoke)
	NVAR /z FollowerITCDeviceIDGlobal = $(FollowerDeviceFolderPath + ":ITCDeviceIDGlobal")
	sprintf cmd, "ITCSelectDevice %d" FollowerITCDeviceIDGlobal
	execute cmd
	Execute "ITCInitialize /M = 0" 
	
	if(itemsinlist(UpdatedListOfFollowerDev, ";") < 2) // no more yoked devices - resets yoke buttons to default state (no yoked devices, only ITC1600 device 0 can be made into a lead deicve
		 DAP_LastYokedDevRemovedSetCtrls(panelTitle)
	endif
End
//=========================================================================================
Function DAP_RemoveAllYokedDACs(panelTitle) // resets the lists of follower devices on the lead device
	string PanelTitle
	string FolderPath = HSU_DataFullFolderPathString(PanelTitle)
	SVAR ListOfFollowerITC1600s = $(FolderPath + ":ListOfFollowerITC1600s")
	string cmd
	string DeviceToDeYoke
	
	if(exists(FolderPath + ":ListOfFollowerITC1600s") == 2)
		setvariable setvar_Hardware_YokeList Win = $panelTitle, value = _STR:"No Yoked ITC1600s"
		variable i
		do
			DeviceToDeYoke = stringfromlist(i, ListOfFollowerITC1600s, ";")
			string FollowerDeviceFolderPath = HSU_DataFullFolderPathString(DeviceToDeYoke)
			NVAR /z FollowerITCDeviceIDGlobal = $(FollowerDeviceFolderPath + ":ITCDeviceIDGlobal")
			sprintf cmd, "ITCSelectDevice %d" FollowerITCDeviceIDGlobal
			execute cmd
			Execute "ITCInitialize /M = 0" 
		
			i += 1
		while(i < itemsinlist(ListOfFollowerITC1600s))
		DAP_LastYokedDevRemovedSetCtrls(panelTitle)
		killstrings ListOfFollowerITC1600s
	endif
End
//=========================================================================================
Function DAP_SetFollowerButtons(panelTitle) // Sets the lists and buttons on the follower device actively being yoked
	string panelTitle

	string FolderPath = HSU_DataFullFolderPathString(PanelTitle)
	string FollowerPanelTitle
	variable itemInList = 0
	string LeadDevice

	SVAR /z ListOfFollowerITC1600s = $(FolderPath + ":ListOfFollowerITC1600s")

	if(exists(FolderPath + ":ListOfFollowerITC1600s") == 2)
		do

			if(itemsinlist(ListOfFollowerITC1600s) > 0)
				FollowerPanelTitle = stringfromlist(itemInlist, ListOfFollowerITC1600s, ";")
			elseif(itemsinlist(ListOfFollowerITC1600s) == 0)
				FollowerPanelTitle = ListOfFollowerITC1600s
			endif

			setvariable setvar_Hardware_Status win = $FollowerPanelTitle, value = _STR:"Follower"
			button button_Hardware_Independent Win = $FollowerPanelTitle, Disable = 2
			button button_Hardware_Lead1600 Win = $FollowerPanelTitle, Disable = 2
			button button_Hardware_AddFollower Win = $FollowerPanelTitle, Disable = 2
			LeadDevice = "Lead device = " + panelTitle
			setvariable setvar_Hardware_YokeList  Win = $FollowerPanelTitle, Disable = 0, value =_STR:LeadDevice
			button button_Hardware_RemoveYoke Win = $FollowerPanelTitle, Disable = 2
			titlebox title_hardware_Follow Win = $FollowerPanelTitle, Disable = 2
			titlebox title_hardware_Release Win = $FollowerPanelTitle, Disable = 2
			popupmenu popup_Hardware_AvailITC1600s Win = $FollowerPanelTitle, Disable = 2
			popupmenu popup_Hardware_YokedDACs Win = $FollowerPanelTitle, Disable = 2
			titlebox title_hardware_1600inst Win = $FollowerPanelTitle, Disable = 2
			

			
			itemInlist += 1
		while(itemInlist< itemsinlist(ListOfFollowerITC1600s))
	endif	
End
//=========================================================================================
Function DAP_LastYokedDevRemovedSetCtrls(panelTitle) // sets the Yoke control and popup buttons on all the ITC1600 device panels to the independent state
	string panelTitle
	SVAR ListOfAllDACpanels = $(Path_ITCDevicesFolder(panelTitle) + ":ITCPanelTitleList")
	string ITC1600DeviceList = listMatch(ListOfAllDACpanels, "ITC1600*", ";")
	variable i = 0
	do
		panelTitle = stringfromlist(i, ITC1600DeviceList, ";")
		button button_Hardware_Independent Win = $panelTitle, Disable = 2
		button button_Hardware_Lead1600 Win = $panelTitle, Disable = 0
		button button_Hardware_AddFollower Win = $panelTitle, Disable = 2
		popupmenu popup_Hardware_YokedDACs Win = $panelTitle, Disable = 2
		button button_Hardware_RemoveYoke Win = $panelTitle, Disable = 2
		titlebox title_hardware_Follow Win = $panelTitle, Disable = 2
		titlebox title_hardware_Release Win = $panelTitle, Disable = 2
		popupmenu popup_Hardware_AvailITC1600s Win = $panelTitle, Disable = 2
		SetVariable setvar_Hardware_Status Win = $panelTitle, value= _STR:"Independent"
		setvariable setvar_Hardware_YokeList  Win = $panelTitle, Disable = 0, value =_STR:"None"
		if(stringmatch(PanelTitle, "ITC1600_Dev_0") == 0) // makes sure yoking can only be set from ITC1600 Dev 0
			button button_Hardware_Lead1600 Win = $panelTitle, Disable = 2
			titlebox title_hardware_1600inst Win = $panelTitle, title = "To yoke devices go to panel: ITC1600_Dev_0", Disable = 0
			setvariable setvar_Hardware_YokeList  Win = $panelTitle, Disable = 2
		elseif(stringmatch(PanelTitle, "ITC1600_Dev_0") == 1)
			titlebox title_hardware_1600inst Win = $panelTitle, title = "Designate the status of the ITC1600 devices:", Disable = 0
		endif	
		i += 1
	while(i < itemsinlist(ITC1600DeviceList, ";")) 
End
//=========================================================================================
Function DAP_Set1600YokeButtons(panelTitle) // yoking controls are made available only on ITC1600_Dev_0
	string panelTitle
	SVAR ListOfAllDACpanels = $(Path_ITCDevicesFolder(panelTitle) + ":ITCPanelTitleList")
	string ITC1600DeviceList = listMatch(ListOfAllDACpanels, "ITC1600*", ";")
	if(itemsinlist(ITC1600DeviceList, ";") > 1)
		DAP_LastYokedDevRemovedSetCtrls(panelTitle)
	endif
	
End

titlebox title_hardware_1600inst Win = $panelTitle, title = "To yoke devices go to panel: ITC1600_Dev_0"

//=========================================================================================
// FUNCTION BELOW IS FOR IMPORTING GAIN SETTINGS
//=========================================================================================

Function DAP_ButtonProc_AutoFillGain(ctrlName) : ButtonControl
	String ctrlName
	string PanelTitle = DAP_ReturnPanelName()
	string wavePath = HSU_DataFullFolderPathString(PanelTitle)
	wave ChanAmpAssign = $wavePath + ":ChanAmpAssign"
	string W_TelegraphServersPath 
	sprintf W_TelegraphServersPath, "%s:W_TelegraphServers" Path_AmpFolder(panelTitle)
	wave W_TelegraphServers = $W_TelegraphServersPath
// Is an amp associated with the headstage?
	controlInfo /w = $PanelTitle Popup_Settings_HeadStage
	variable HeadStageNo = v_value - 1

	if(numtype(ChanAmpAssign[8][HeadStageNo]) != 2)
		// Is the amp still connected?
		findValue /I = (ChanAmpAssign[8][HeadStageNo]) /T = 0 $W_TelegraphServersPath
		if(V_value != -1)
			HSU_AutoFillGain(panelTitle)
			HSU_UpdateChanAmpAssignStorWv(panelTitle)
		endif
	elseif(numtype(ChanAmpAssign[8][HeadStageNo]) == 2)
		print "An amp channel has not been assigned to this headstage therefore gains cannot be imported"
	endif
End

//=========================================================================================
// FUNCTION BELOW CONTROL THE GUI INTERACTIONS OF THE AMPLIFIER CONTROLS ON THE DATA ACQUISITION TAB OF THE DA_EPHYS PANEL
//=========================================================================================

