#pragma rtGlobals=3		// Use modern global access method and strict wave access.

///@name Constants for DC_ConfigureDataForITC
///@{
CONSTANT DATA_ACQUISITION_MODE = 0
CONSTANT TEST_PULSE_MODE       = 1
///@}

/// @brief Prepare test pulse/data acquisition
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP one of DATA_ACQUISITION_MODE or TEST_PULSE_MODE
Function DC_ConfigureDataForITC(panelTitle, dataAcqOrTP)
	string panelTitle
	variable DataAcqOrTP

	ASSERT(dataAcqOrTP == DATA_ACQUISITION_MODE || dataAcqOrTP == TEST_PULSE_MODE, "invalid mode")

	DC_MakeITCConfigAllConfigWave(panelTitle)  
	DC_MakeITCConfigAllDataWave(panelTitle, DataAcqOrTP)  
	DC_MakeITCFIFOPosAllConfigWave(panelTitle)
	DC_MakeFIFOAvailAllConfigWave(panelTitle)

	DC_PlaceDataInITCChanConfigWave(panelTitle)
	DC_PlaceDataInITCDataWave(panelTitle)
	DC_PDInITCFIFOPositionAllCW(panelTitle)// PD = Place Data
	DC_PDInITCFIFOAvailAllCW(panelTitle)
End

//==========================================================================================

/// @brief The minimum sampling interval is determined by the rack with the most channels selected
///
/// Minimum sampling intervals are 5, 10, 15, 20 or 25 microseconds
Function DC_ITCMinSamplingInterval(panelTitle)
	string panelTitle

	variable Rack0DAMinInt, Rack0ADMinInt, Rack1DAMinInt, Rack1ADMinInt
	
	Rack0DAMinInt = DC_DAMinSampInt(0, panelTitle)
	Rack1DAMinInt = DC_DAMinSampInt(1, panelTitle)
	
	Rack0ADMinInt = DC_ADMinSampInt(0, panelTitle)
	Rack1ADMinInt = DC_ADMinSampInt(1, panelTitle)
	
	return max(max(Rack0DAMinInt,Rack1DAMinInt), max(Rack0ADMinInt,Rack1ADMinInt))
End


//==========================================================================================
Function DC_NoOfChannelsSelected(ChannelType, ControlType, panelTitle)//ChannelType = DA, AD, or TTL; Control Type = check or wave
	string ChannelType, ControlType,panelTitle
	variable TotalPossibleChannels = DC_TotNoOfControlType(ControlType, ChannelType,panelTitle)
	variable i = 0
	variable DC_NoOfChannelsSelected = 0
	string CheckBoxName
	string controlname
		do
			//CheckBoxName = "Check_"+ ChannelType +"_"
			sprintf ControlName, "%s_%s_%.2d", ControlType, ChannelType, i
//			if(i < 10)
//				CheckBoxName += "0"+num2str(i)
				ControlInfo /w = $panelTitle $ControlName
				DC_NoOfChannelsSelected += v_value
//			endif
//	
//			if(i >= 10)
//				CheckBoxName += num2str(i)
//				ControlInfo /w = $panelTitle $CheckBoxName
//				DC_NoOfChannelsSelected += v_value
//			endif
		
		i += 1
		while(i <= (TotalPossibleChannels - 1))
	return DC_NoOfChannelsSelected
End

//==========================================================================================

/// @brief Returns a list of the status of the checkboxes specified by ChannelType and ControlType
///
/// @deprecated use @ref DC_ControlStatusWave() instead
///
/// @param ChannelType  one of DA, AD, or TTL
/// @param ControlType  currently restricted to "Check"
/// @param panelTitle   panel title
Function/S DC_ControlStatusListString(ChannelType, ControlType, panelTitle)
	String ChannelType, panelTitle
	string ControlType

	variable TotalPossibleChannels = DC_TotNoOfControlType(ControlType, ChannelType,panelTitle)
	
	String ControlStatusList = ""
	String ControlName
	variable i
	
	i=0
	do
		sprintf ControlName, "%s_%s_%.2d", ControlType, ChannelType, i
		ControlInfo /w = $panelTitle $ControlName
		ControlStatusList = AddlistItem(num2str(v_value), ControlStatusList, ";",i)
		i+=1
	while(i <= (TotalPossibleChannels - 1))
	
	return ControlStatusList
End

/// @brief Returns a free wave of the status of the checkboxes specified by channelType
///
/// @param type        one of DA, AD, TTL or DataAcq_HS
/// @param panelTitle  panel title
Function/Wave DC_ControlStatusWave(panelTitle, type)
	string type
	string panelTitle

	string controlType = "CHECK"
	string ctrl
	variable numChannels = DC_TotNoOfControlType(controlType, type, panelTitle)
	variable i

	Make/FREE/U/B/N=(numChannels) wv = 0

	for(i = 0; i < numChannels; i += 1)
		sprintf ctrl, "%s_%s_%.2d", controlType, type, i
		wv[i] = GetCheckboxState(panelTitle, ctrl)
	endfor

	return wv
End

//==========================================================================================

Function DC_ChanCalcForITCChanConfigWave(panelTitle)
	string panelTitle
	Variable NoOfDAChannelsSelected = DC_NoOfChannelsSelected("DA", "Check",panelTitle)
	Variable NoOfADChannelsSelected = DC_NoOfChannelsSelected("AD", "Check",panelTitle)
	Variable AreRack0FrontTTLsUsed = DC_AreTTLsInRackChecked(0,panelTitle)
	Variable AreRack1FrontTTLsUsed = DC_AreTTLsInRackChecked(1,panelTitle)
	Variable ChannelCount
	
	ChannelCount = NoOfDAChannelsSelected + NoOfADChannelsSelected + AreRack0FrontTTLsUsed + AreRack1FrontTTLsUsed
	
	return ChannelCount

END
//==========================================================================================
Function DC_AreTTLsInRackChecked(RackNo, panelTitle)
	variable RackNo
	string panelTitle
	variable a
	variable b
	string TTLsInUse = DC_ControlStatusListString("TTL", "Check",panelTitle)
	variable RackTTLStatus
	
	if(RackNo == 0)
		 a = 0
		 b = 3
	endif
	
	if(RackNo == 1)
		 a = 4
		 b = 7
	endif
	
	do
		If(str2num(stringfromlist(a,TTLsInUse,";")) == 1)
			RackTTLStatus = 1
			return RackTTLStatus
		endif
		a += 1
	while(a <= b)
	
	RackTTLStatus = 0
	return RackTTLStatus
End

//=========================================================================================

Function DC_TotNoOfControlType(ControlType, ChannelType, panelTitle) // Ex. ChannelType = "DA", ControlType = "Check"
	string  ControlType, ChannelType, panelTitle
	string SearchString = ControlType + "_" + ChannelType + "_*"
	string ListString
	variable CatTot //Category Total
	
	ListString = ControlNameList(panelTitle,";",SearchString)
	return ItemsInlist(ListString,";")
End


//=========================================================================================
// 1. TTL 1;0;0;0
// 2. TTL 0;1;0;0
// 3. TTL 1;1;0;0
// 4. TTL 0;0;1;0
// 5. TTL 1;0;1;0
// 6. TTL 0;1;1;0
// 7. TTL 1;1;1;0
// 8. TTL 0;0;0;1
// 9. TTL 1;0;0;1
// 10. TTL 0;1;0;1
// 11. TTL 1;1;0;1
// 12. TTL 0;0;1;1
// 13. TTL1;0;1;1
// 14. TTL 0;1;1;1
// 15. TTL 1;1;1;1


Function DC_TTLCodeCalculation1(RackNo, panelTitle)// ####### FUNCTION DOES NOT APPEAR TO BE IN USE
	variable RackNo
	string panelTitle
	variable a, i, TTLChannelStatus,Code
	string TTLStatusString = DC_ControlStatusListString("TTL", "Check",panelTitle)
	
	if(RackNo == 0)
		a = 0
	endif
	
	if(RackNo == 1)
		a = 4
	endif
	
	code = 0
	i = 0
	
	do 
		TTLChannelStatus = str2num(stringfromlist(a,TTLStatusString,";"))
		Code += (((2 ^ i)) * TTLChannelStatus)
		a += 1
		i += 1
	while(i < 4)
	
	return Code

End


//=========================================================================================

Function/s DC_PopMenuStringList(ChannelType, ControlType, panelTitle)// returns the list of selected waves in pop up menus
	string ChannelType, ControlType, panelTitle
	variable TotalPossibleChannels = DC_TotNoOfControlType(ControlType, ChannelType, panelTitle)
	String ControlWaveList = ""
	String ControlName
	variable i = 0
	
		do
			//ControlName = ControlType + "_" + ChannelType + "_"		
			sprintf ControlName, "%s_%s_%.2d", ControlType, ChannelType, i

			//if(i < 10)
			//	ControlName += "0" + num2str(i)
				ControlInfo /w = $panelTitle $ControlName
				//ControlWaveList += s_value + ";"
				ControlWaveList = AddlistItem(s_value, ControlWaveList, ";",i)

			//endif
	
//			if(i >= 10)
//				ControlName += num2str(i)
//				ControlInfo /w = $panelTitle $ControlName
//				ControlWaveList += s_value + ";"
//			endif
			
		i += 1
		while(i <= (TotalPossibleChannels - 1))
	
	return ControlWaveList

End

//=========================================================================================
Function DC_LongestOutputWave(ChannelType, panelTitle)//ttl and da channel types need to be passed into this and compared to determine longest wave
	string ChannelType, panelTitle
	string ControlType = "Check"
	variable TotalPossibleChannels = DC_TotNoOfControlType(ControlType, ChannelType, panelTitle)
	variable wavelength = 0, i = 0
	string ControlTypeStatus = DC_ControlStatusListString(ChannelType, ControlType, panelTitle)
	string WaveNameString
	ControlType = "Wave"
	string ChannelTypeWaveList = DC_PopMenuStringList(ChannelType, ControlType, panelTitle)
	//if da or ttl channels is active, query the wavelength of the active channel
	i = 0
	wavelength = 0
	
	do
	
	if((str2num(stringfromlist(i,ControlTypeStatus,";"))) == 1)
		WaveNameString = stringfromlist(i,ChannelTypeWaveList,";")
		if(stringmatch(WaveNameString,"-none-") == 0)//prevents error where check box is checked but no wave is selected. Update: the panel code actually prevents this possibility but I am leaving the code because I don't think the redundancy is harmful
			WaveNameString = "root:MIES:WaveBuilder:savedStimulusSets:" + ChannelType + ":" + WaveNameString
//			if(cmpstr(WaveNameString, "root:WaveBuilder:savedStimulusSets:DA:TestPulse") == 0)// checks to see if test pulse is the wave being run, if yes, changes path
//			WaveNameString = HSU_DataFullFolderPathString(panelTitle) + ":TestPulse:TestPulse"
//			endif
			if(DimSize($WaveNameString, 0 ) > WaveLength)
				WaveLength = DimSize($WaveNameString, 0 )
			endif
		endif
	endif
	
	i += 1
	while(i <= (TotalPossibleChannels - 1))
	return WaveLength
End



//==========================================================================================
Function DC_CalculateITCDataWaveLength(panelTitle, DataAcqOrTP)// determines the longest output DA or DO wave. Divides it by the min sampling interval and quadruples its length (to prevent buffer overflow).
	string panelTitle
	variable DataAcqOrTP // 0 = DataAcq, 1 = TP
	Variable LongestSweep = DC_CalculateLongestSweep(panelTitle)
	// print "Longest sweep =", LongestSweep
	variable exponent = ceil(log(LongestSweep)/log(2))
	//exponent += 2
	if(DataAcqOrTP == 0)
	// print " data acq not TP exponent"
		exponent += 1 // round(5000 / LongestSweep) // buffer for sweep length
	endif
	
	if(exponent < 17)
		exponent = 17
	endif
	//print "exponent = ",exponent
	//print ceil(5000 / LongestSweep)
	//LongestWaveLength *= 5
	// print "DC_CalculateITCDataWaveLength =",(2^exponent), "exponent =", exponent
	return (2^exponent)
	//return round(LongestWaveLength)
end
//==========================================================================================

Function DC_CalculateLongestSweep(panelTitle) // returns the longest sweep in points
	string panelTitle
	variable LongestSweep
	
	if (DC_LongestOutputWave("DA", panelTitle) >= DC_LongestOutputWave("TTL", panelTitle))
		LongestSweep = DC_LongestOutputWave("DA", panelTitle)
	else
		LongestSweep = DC_LongestOutputWave("TTL", panelTitle)
	endif
	LongestSweep /= (DC_ITCMinSamplingInterval(panelTitle) / 5)
	
	return ceil(LongestSweep)
End
//==========================================================================================
Function DC_MakeITCConfigAllConfigWave(panelTitle)
	string panelTitle
	string ITCChanConfigPath = HSU_DataFullFolderPathString(panelTitle) + ":ITCChanConfigWave"
	Make /I /o /n = (DC_ChanCalcForITCChanConfigWave(panelTitle), 4) $ITCChanConfigPath
	wave /z ITCChanConfigWave = $ITCChanConfigPath
	ITCChanConfigWave = 0
End
//==========================================================================================
Function DC_MakeITCConfigAllDataWave(panelTitle, DataAcqOrTP)// config all refers to configuring all the channels at once
	string panelTitle
	variable DataAcqOrTP
	string ITCDataWavePath = HSU_DataFullFolderPathString(panelTitle) + ":ITCDataWave"
	make /w /o /n = (DC_CalculateITCDataWaveLength(panelTitle, DataAcqOrTP), DC_ChanCalcForITCChanConfigWave(panelTitle)) $ITCDataWavePath
	wave/z ITCDataWave = $ITCDataWavePath
	FastOp ITCDataWave = 0
	SetScale/P x 0,(DC_ITCMinSamplingInterval(panelTitle)) / 1000,"ms", ITCDataWave
End
//==========================================================================================
Function DC_MakeITCFIFOPosAllConfigWave(panelTitle)//MakeITCUpdateFIFOPosAllConfigWave
	string panelTitle
	string ITCFIFOPosAllConfigWavePath = HSU_DataFullFolderPathString(panelTitle) + ":ITCFIFOPositionAllConfigWave"
	Make /I /o /n = (DC_ChanCalcForITCChanConfigWave(panelTitle), 4) $ITCFIFOPosAllConfigWavePath
	wave /z ITCFIFOPositionAllConfigWave = $ITCFIFOPosAllConfigWavePath
	ITCFIFOPositionAllConfigWave = 0
End
//==========================================================================================
Function DC_MakeFIFOAvailAllConfigWave(panelTitle)//MakeITCFIFOAvailAllConfigWave
	string panelTitle
	string ITCFIFOAvailAllConfigWavePath = HSU_DataFullFolderPathString(panelTitle) + ":ITCFIFOAvailAllConfigWave"
	Make /I /o /n = (DC_ChanCalcForITCChanConfigWave(panelTitle), 4) $ITCFIFOAvailAllConfigWavePath
	wave /z ITCFIFOAvailAllConfigWave = $ITCFIFOAvailAllConfigWavePath
	ITCFIFOAvailAllConfigWave = 0
End
//==========================================================================================


Function DC_PlaceDataInITCChanConfigWave(panelTitle)
	string panelTitle
	variable i = 0// 
	variable j = 0//used to keep track of row of ITCChanConfigWave which config data is loaded into
	variable ChannelType // = 0 for AD, = 1 for DA, = 3 for TTL
	string ChannelStatus
	string WavePath = HSU_DataFullFolderPathString(panelTitle) 
	wave ITCChanConfigWave = $WavePath + ":ITCChanConfigWave"
	Wave/T ChanAmpAssignUnit = GetChanAmpAssignUnit(panelTitle)
	string UnitString = ""
	
	string UnitSetVarName = "Unit_DA_0"
	ChannelType = 1
	ChannelStatus = DC_ControlStatusListString("DA", "Check", panelTitle)
	
	//Place DA config data
	do
		if(str2num(stringfromlist(i,ChannelStatus,";")) == 1)
			ITCChanConfigWave[j][0] = ChannelType
			ITCChanConfigWave[j][1] = i
			controlinfo /w = $panelTitle $UnitSetVarName + num2str(i)
			UnitString += s_value + ";"// a string with a unit for each column
			j += 1
		endif
		i += 1
	while(i < (itemsinlist(ChannelStatus,";")))
	
	//Place AD config data
	i = 0
	ChannelStatus = DC_ControlStatusListString("AD", "Check", panelTitle)
	ChannelType = 0
	UnitSetVarName = "Unit_AD_0"
	do
		if(str2num(stringfromlist(i,ChannelStatus,";")) == 1)
			ITCChanConfigWave[j][0] = ChannelType
			ITCChanConfigWave[j][1] = i
			controlinfo /w = $panelTitle $UnitSetVarName + num2str(i)
			UnitString += s_value + ";"
			j += 1
		endif
		i+=1
	while(i<(itemsinlist(ChannelStatus,";")))
	
	note ITCChanConfigWave, UnitString
	//Place TTL config data
	i = 0
	ChannelType = 3
	
	if(DC_AreTTLsInRackChecked(0, panelTitle) == 1)
		ITCChanConfigWave[j][0] = ChannelType
		ITCChanConfigWave[j][1] = 0
	j += 1
	endif
	
	if(DC_AreTTLsInRackChecked(1, panelTitle) == 1)
		ITCChanConfigWave[j][0] = ChannelType
		ITCChanConfigWave[j][1] = 3
	
	endif
	
	ITCChanConfigWave[][2] = DC_ITCMinSamplingInterval(panelTitle)//
	ITCChanConfigWave[][3] = 0

End
//==========================================================================================
/// @brief Places data from appropriate DA and TTL stimulus set(s) into ITCdatawave. 
/// Also records certain DA_Ephys GUI settings into SweepData and SweepTxtData
Function DC_PlaceDataInITCDataWave(panelTitle)
	string panelTitle
	variable i = 0// 
	variable j = 0//
	string ChannelStatus
	string WavePath // = HSU_DataFullFolderPathString(panelTitle)
	sprintf WavePath, "%s" HSU_DataFullFolderPathString(panelTitle)
	wave ITCDataWave = $(WavePath + ":ITCDataWave")
	string ITCDataWavePath = WavePath + ":ITCDataWave"
	//string testPulsePath = HSU_DataFullFolderPathString(panelTitle) + ":TestPulse:TestPulse"
	string ChanTypeWaveNameList, ChanTypeWaveName
	string ResampledWaveName = "ResampledWave"
	string cmd
	string SetvarDAGain, SetVarDAScale
	variable DAGain, DAScale,column, insertStart, insertEnd, EndRow
	string CountPath = HSU_DataFullFolderPathString(panelTitle)+":count" //%%
	Wave ChannelClampMode    = GetChannelClampMode(panelTitle)
	// waves below are used to document the settings for each sweep
	Wave SweepData = DC_SweepDataWvRef(panelTitle)
	Wave/T SweepTxtData = DC_SweepDataTxtWvRef(panelTitle)
	SweepData = nan // empty the waves on each new sweep
	SweepTxtData = ""
	Variable HeadStage
	if(exists(CountPath) == 2)
		NVAR count = $CountPath
		column = count-1
	else
		column = 0
	endif
	
	//Place DA waves into ITCDataWave
	variable DecimationFactor = (DC_ITCMinSamplingInterval(panelTitle) / 5)
	ChannelStatus = DC_ControlStatusListString("DA", "Check", panelTitle)
	ChanTypeWaveNameList = DC_PopMenuStringList("DA", "Wave", panelTitle)
	// print ChanTypeWaveNameList
	do
		if(str2num(stringfromlist(i,ChannelStatus,";")) == 1)//Checks if DA channel checkbox is checked (ON)
			HeadStage = TP_HeadstageUsingDAC(panelTitle, i) // Determine the headstage
			
			if(isFinite(HeadStage))
				SweepData[0][0][HeadStage] = i // document the DA channel
			endif
			sprintf SetVarDAGain, "Gain_DA_0%s"  num2str(i)
			sprintf SetVarDAScale, "Scale_DA_0%s" num2str(i)

			ControlInfo /w = $panelTitle $SetVarDAGain
			DAGain = (3200 / v_value) // 3200 = 1V, 3200/gain = bits per unit
			if(isFinite(HeadStage))
				SweepData[0][2][HeadStage] = v_value // document the DA gain
			endif
			
			ControlInfo /w = $panelTitle $SetVarDAScale
			DAScale = v_value
			
			if(isFinite(HeadStage))
				SweepData[0][4][HeadStage] = v_value // document the DA scale
			endif
			//get the wave name
			ChanTypeWaveName = GetWBSvdStimSetDAPathAsString() + ":" +stringfromlist(i,ChanTypeWaveNameList,";")
			// print "chan type wave name =", ChanTypeWaveName 
			if(isFinite(HeadStage))
				SweepTxtData[0][0][HeadStage] = stringfromlist(i,ChanTypeWaveNameList,";") // Document the Set name
			endif
			//check to see if it is a test pulse or user specified da wave
			if(stringmatch(ChanTypeWaveName,"root:MIES:WaveBuilder:SavedStimulusSets:DA:testpulse") == 1)
				// print "chan type wave name =", ChanTypeWaveName
				column = 0
				insertStart = 0
				insertEnd = 0
			else
				column = real(DC_CalculateChannelColumnNo(panelTitle, stringfromlist(i,ChanTypeWaveNameList,";"), i,0))// DC_CalculateChannelColumnNo also returns a 0 or 1 in the imaginary componet. 1 = set has cycled once already
				if(j == 0) // (i == 0)
					InsertStart = DC_GlobalChangesToITCDataWave(panelTitle) 
					// print "insert start =", InsertStart
					InsertEnd = InsertStart 
				endif
			endif
		// checks if user wants to set scaling to 0 on sets that have already cycled once
		ControlInfo /w = $panelTitle check_Settings_ScalingZero 
		if(v_value == 1)
			ControlInfo /w = $panelTitle Check_DataAcq_Indexing
			variable IndexingOnOrOff = v_value // indexing state
			ControlInfo /w = $panelTitle Check_DataAcq1_IndexingLocked
			if(v_value == 1 || IndexingOnOrOff == 0)// locked indexing or no indexing
				if(cmpstr(ChanTypeWaveName,"root:MIES:WaveBuilder:SavedStimulusSets:DA:testpulse") != 0)// makes sure test pulse wave scaling is maintained
					if(imag(DC_CalculateChannelColumnNo(panelTitle, stringfromlist(i,ChanTypeWaveNameList,";"),i,0)) == 1) // checks if set has completed one full cycle
						DAScale = 0
					endif
				endif
			endif
		endif
			//resample the wave to min samp interval and place in ITCDataWave
			EndRow = (((round(dimsize($ChanTypeWaveName, 0)) / DecimationFactor) - 1) + InsertEnd)
			//print cmd
			Wave/z StimSetSweep = $ChanTypeWaveName
			// print "Column =", column
			if(isFinite(HeadStage))
				SweepData[0][5][HeadStage] = Column // document the set column
			endif
			
			Multithread ITCDataWave[InsertStart, EndRow][j] = (DAGain * DAScale) * StimSetSweep[DecimationFactor * (p - InsertStart)][Column]
			//print "dascale =", dascale
			// check if TP is being configured
			if(stringmatch(ChanTypeWaveName,"root:MIES:WaveBuilder:SavedStimulusSets:DA:testpulse") == 0) // prevents insertion of TP into TP
				// check if global TP insertion is active
				controlinfo /w = $panelTitle Check_Settings_InsertTP
				variable Check_Settings_InsertTP = v_value
				if(Check_Settings_InsertTP == 1)
					variable TPAmp
					controlinfo /w =$panelTitle SetVar_DataAcq_TPDuration
					variable TPDuration = 2 * v_value
					// print tpduration
					variable TPStartPoint = x2pnt(ITCDataWave, TPDuration / 4)
					variable TPEndPoint = x2pnt(ITCDataWave, TPDuration / 2) + TPStartPoint
					string ChannelClampModePathString
					sprintf ChannelClampModePathString, "%s:ChannelClampMode" WavePath
					Wave ChannelClampMode = $ChannelClampModePathString
					variable ChannelMode = ChannelClampMode[i][0]
					if(ChannelMode == V_CLAMP_MODE)
						controlinfo /w = $panelTitle SetVar_DataAcq_TPAmplitude
						TPAmp = v_value
					elseif(ChannelMode == I_CLAMP_MODE)
						controlinfo /w = $panelTitle SetVar_DataAcq_TPAmplitudeIC
						TPAmp = v_value
					endif
					ITCDataWave[TPStartPoint, TPEndPoint][j] = TPAmp * DAGain
				endif

			endif
			// i is the DA channel number 
			j += 1// j determines what column of the ITCData wave the DAC wave is inserted into 
		endif
		i += 1
	while(i < (itemsinlist(ChannelStatus,";")))
		
	//Leave room for AD data 
		i = 0
		ChannelStatus = DC_ControlStatusListString("AD", "Check", panelTitle)
	
	do
		if(str2num(stringfromlist(i,ChannelStatus,";")) == 1)
			
			j += 1
		endif
		i += 1
	while(i < (itemsinlist(ChannelStatus,";")))
	
	//Place TTL waves into ITCDataWave
	i = 0
	wave /z TTLwave = $HSU_DataFullFolderPathString(panelTitle) + ":TTLwave"//= root:MIES:WaveBuilder:SavedStimulusSets:TTL:TTLWave
	if(DC_AreTTLsInRackChecked(0, panelTitle) == 1)
		DC_MakeITCTTLWave(0, panelTitle)
		ITCDataWave[InsertStart, round((dimsize(TTLWave,0) / DecimationFactor)) - 1 + InsertEnd][j] = TTLWave[(DecimationFactor) * (p - InsertStart)]		
		//ITCDataWave[0,round((dimsize(TTLWave,0) / DecimationFactor)) - 1][j] = TTLWave[(DecimationFactor) * p]
		j += 1
	endif
	
	if(DC_AreTTLsInRackChecked(1, panelTitle) == 1)
		DC_MakeITCTTLWave(1, panelTitle)
		ITCDataWave[InsertStart,round((dimsize(TTLWave,0) / DecimationFactor)) - 1 + InsertEnd][j]=TTLWave[(DecimationFactor) * (p - insertStart)]
		//ITCDataWave[0,round((dimsize(TTLWave,0) / DecimationFactor)) - 1][j]=TTLWave[(DecimationFactor) * p]
	endif
End

//=========================================================================================
Function DC_PDInITCFIFOPositionAllCW(panelTitle)//PlaceDataInITCFIFOPositionAllConfigWave()
	string panelTitle
	string WavePath = HSU_DataFullFolderPathString(panelTitle)
	wave ITCFIFOPositionAllConfigWave = $WavePath+":ITCFIFOPositionAllConfigWave" , ITCChanConfigWave = $WavePath+":ITCChanConfigWave"
	ITCFIFOPositionAllConfigWave[][0,1] = ITCChanConfigWave
	ITCFIFOPositionAllConfigWave[][2]=-1
	ITCFIFOPositionAllConfigWave[][3]=0
End
//=========================================================================================
Function DC_PDInITCFIFOAvailAllCW(panelTitle)//PlaceDataInITCFIFOAvailAllConfigWave()
	string panelTitle
	string WavePath = HSU_DataFullFolderPathString(panelTitle)
	wave ITCFIFOAvailAllConfigWave = $WavePath+":ITCFIFOAvailAllConfigWave", ITCChanConfigWave = $WavePath+":ITCChanConfigWave"
	ITCFIFOAvailAllConfigWave[][0,1] = ITCChanConfigWave
	ITCFIFOAvailAllConfigWave[][2] = 0
	ITCFIFOAvailAllConfigWave[][3] = 0
End
//=========================================================================================
Function DC_MakeITCTTLWave(RackNo, panelTitle)//makes single ttl wave for each rack. each ttl wave is added to the next after being multiplied by its bit number
	variable RackNo
	string panelTitle
	variable a, i, TTLChannelStatus,Code
	string TTLStatusString = DC_ControlStatusListString("TTL", "Check", panelTitle)
	string TTLWaveList = DC_PopMenuStringList("TTL", "Wave", panelTitle)
	string TTLWaveName
	string cmd
	string WavePath = HSU_DataFullFolderPathString(panelTitle)+":"//"root:MIES:WaveBuilder:savedStimulusSets:TTL:"// the ttl wave should really be located in the device folder not the wavebuilder folder
	string TTLWavePath = "root:MIES:WaveBuilder:savedStimulusSets:TTL:"
	if(RackNo == 0)
		a = 0
	endif
	
	if(RackNo == 1)
		a = 4
	endif
	
	code = 0
	i = 0
	
	do 
		TTLChannelStatus = str2num(stringfromlist(a,TTLStatusString,";"))
		Code = (((2 ^ i)) * TTLChannelStatus)
		TTLWaveName = stringfromlist(a,TTLWaveList,";")
		if(i == 0)
			TTLWaveName = TTLWavePath + TTLWaveName// 
			make /o /n = (dimsize($TTLWaveName,0)) $WavePath+"TTLWave" = 0// 
		endif
		
		if(TTLChannelStatus == 1)
			sprintf cmd, "%sTTLWave+=(%d)*(%s%s%d%s)" wavepath, code, TTLWaveName,"[p][",DC_CalculateChannelColumnNo(panelTitle, stringfromlist(a,TTLWaveList,";"),i,1),"]"

//		controlinfo/w=$panelTitle check_DataAcq_RepAcqRandom//checks to see if radom intra set sequencing is selected
//			if(v_value==0)
//				sprintf cmd, "%sTTLWave+=(%d)*(%s%s%d%s)" wavepath, code, TTLWaveName,"[p][",CalculateTTLColumnNo(panelTitle, stringfromlist(a,TTLWaveList,";")),"]"
//			else
//				sprintf cmd, "%sTTLWave+=(%d)*(%s%s%d%s)" wavepath, code, TTLWaveName,"[p][",CalculateShuffledTTLColumnNo(panelTitle, stringfromlist(a,TTLWaveList,";")),"]"
//			endif
		execute cmd
		endif
		a += 1
		i += 1
	while( i <4)
End
//=========================================================================================
Function DC_DAMinSampInt(RackNo, panelTitle)
	variable RackNo
	string panelTitle

	variable a, i, DAChannelStatus,SampInt
	string DAStatusString = DC_ControlStatusListString("DA", "Check", panelTitle)
	
	a = RackNo*4
	
	SampInt = 0
	i = 0
	
	do 
		DAChannelStatus = str2num(stringfromlist(a,DAStatusString,";"))
		SampInt += 5*DAChannelStatus
		a += 1
		i += 1
	while(i < 4)
	
	return SampInt
End
//=========================================================================================
Function DC_ADMinSampInt(RackNo, panelTitle)
	variable RackNo
	string panelTitle

	variable a, i, ADChannelStatus, Bank1SampInt, Bank2SampInt
	string ADStatusString = DC_ControlStatusListString("AD", "Check",panelTitle)
	
	a = RackNo*8
	
	Bank1SampInt = 0
	Bank2SampInt = 0
	i = 0
	
	do 
		ADChannelStatus = str2num(stringfromlist(a,ADStatusString,";"))
		Bank1SampInt += 5 * ADChannelStatus
		a += 1
		i += 1
	while(i < 4)
	
	i = 0
	do 
		ADChannelStatus = str2num(stringfromlist(a,ADStatusString,";"))
		Bank2SampInt += 5 * ADChannelStatus
		a += 1
		i += 1
	while(i < 4)
	
	return max(Bank1SampInt,Bank2SampInt)
End
//=========================================================================================

// returns column number, independent of the times the set is being cycled through (as defined by SetVar_DataAcq_SetRepeats)
Function/c DC_CalculateChannelColumnNo(panelTitle, SetName, channelNo, DAorTTL)// setname is a string that contains the full wave path
	string panelTitle, SetName
	variable ChannelNo, DAorTTL
	variable ColumnsInSet = IDX_NumberOfTrialsInSet(panelTitle, SetName, DAorTTL)
	variable column
	variable CycleCount // when cycleCount = 1 the set has already cycled once.
	variable /c column_CycleCount
	variable localCount
	string WavePath = HSU_DataFullFolderPathString(panelTitle)
	string CountPath = WavePath +":Count"
	string AcitveSetCountPath = WavePath +":ActiveSetCount"
	//following string and wave apply when random set sequence is selected
	string SequenceWaveName = WavePath + ":" + SetName + num2str(daorttl) + num2str(channelNo) + "_S"//s is for sequence
	if(waveexists($SequenceWaveName) == 0)
		make /o /n = (ColumnsInSet) $SequenceWaveName = 0
		DC_shuffle( $SequenceWaveName)
	endif
	wave /z WorkingSequenceWave = $SequenceWaveName	
	// Below code calculates the variable local count which is then used to determine what column to select from a particular set
		if(exists(CountPath) == 2)// the global variable count is created at the initiation of the repeated aquisition functions and killed at their completion, 
							//thus the vairable "count" is used to determine if acquisition is on the first cycle
			NVAR count = $CountPath
			controlinfo /w = $panelTitle Check_DataAcq_Indexing// check indexing status
			if(v_value == 0)// if indexing is off...
				localCount = count
				cycleCount = 0
			else // else is used when indexing is on. The local count is now set length dependent
				controlinfo /w = $panelTitle Check_DataAcq1_IndexingLocked// check locked status. locked = popup menus on channels idex in lock - step
				if(v_value == 1)// indexing is locked
					NVAR ActiveSetCount = $AcitveSetCountPath
					controlinfo /w = $panelTitle valdisp_DataAcq_SweepsActiveSet// how many columns in the largest currently selected set on all active channels
					localCount = v_value
					controlinfo /w = $panelTitle SetVar_DataAcq_SetRepeats// how many times does the user want the sets to repeat
					localCount *= v_value
					localCount -= ActiveSetCount// active set count keeps track of how many steps of the largest currently selected set on all active channels has been taken
				else //indexing is unlocked
					// calculate where in list global count is
					localCount = IDX_UnlockedIndexingStepNo(panelTitle, channelNo, DAorTTL, count)
				endif
			endif

	//Below code uses local count to determine  what step to use from the set based on the sweeps in cycle and sweeps in active set
			wave/z WorkingSequenceWave = $SequenceWaveName
			if(((localCount) / ColumnsInSet) < 1 || (localCount) == 0)// if remainder is less than 1, count is on 1st cycle
				controlinfo /w = $panelTitle check_DataAcq_RepAcqRandom
				if(v_value == 0) // set step sequence is not random
					column = localCount
					cycleCount = 0
				else // set step sequence is random
					if(localCount == 0)
						DC_shuffle(WorkingSequenceWave)
					endif
					column = WorkingSequenceWave[localcount]
					cycleCount = 0
				endif	
			else
				controlinfo /w = $panelTitle check_DataAcq_RepAcqRandom
				if(v_value == 0) // set step sequence is not random
					column = mod((localCount), columnsInSet)// set has been cyled through once or more, uses remainder to determine correct column
					cycleCount = 1
				else
					if(mod((localCount), columnsInSet) == 0)
						DC_shuffle(WorkingSequenceWave) // added to handle 1 channel, unlocked indexing
					endif
					column = WorkingSequenceWave[mod((localCount), columnsInSet)]
					cycleCount = 1
				endif
			endif
		else
			controlinfo /w = $panelTitle check_DataAcq_RepAcqRandom
			if(v_value == 0) // set step sequence is not random
				column = 0
			else
				make /o /n = (ColumnsInSet) $SequenceWaveName
				wave WorkingSequenceWave = $SequenceWaveName
				WorkingSequenceWave = x
				DC_shuffle(WorkingSequenceWave)
				column = WorkingSequenceWave[0]
			endif
		endif
	
	if(channelNo == 1)
		if(DAorTTL == 0)
		//print "DA channel 1 column = " + num2str(column)
		else
		//print "TTL channel 1 column = " + num2str(column)
		endif
		//print setname
	endif
	if(channelNo == 0)
		if(DAorTTL == 0)
		//print "DA channel 0 column = " + num2str(column)
		else
		//print "TTL channel 0 column = " + num2str(column)
		endif
		//print setname
	endif
	
	column_CycleCount = cmplx(column, cycleCount)
	return column_CycleCount
end

//below function was taken from: http://www.igorexchange.com/node/1614
//author s.r.chinn
Function DC_shuffle(inwave)	//	in-place random permutation of input wave elements
	wave inwave
	variable N	=	numpnts(inwave)
	variable i, j, emax, temp
	for(i = N; i>1; i-=1)
		emax = i / 2
		j =  floor(emax + enoise(emax))		//	random index
// 		emax + enoise(emax) ranges in random value from 0 to 2*emax = i
		temp		= inwave[j]
		inwave[j]		= inwave[i-1]
		inwave[i-1]	= temp
	endfor
end

Function DC_GlobalChangesToITCDataWave(panelTitle) // adjust the length of the ITCdataWave according to the global changes on the data acquisition tab - should only get called for non TP data acquisition cycles
	string panelTitle
	controlinfo /w = $panelTitle setvar_DataAcq_OnsetDelay
	variable OnsetDelay = round(v_value / (DC_ITCMinSamplingInterval(panelTitle) / 1000))
	controlinfo /w = $panelTitle setvar_DataAcq_TerminationDelay
	variable TerminationDelay = v_value / (DC_ITCMinSamplingInterval(panelTitle) / 1000)
	variable NewRows = round((OnsetDelay + TerminationDelay) * 5)
	string WavePath = HSU_DataFullFolderPathString(panelTitle) + ":"
	wave ITCDataWave = $WavePath + "ITCDataWave"
	variable ITCDataWaveRows = dimsize(ITCDataWave, 0)
	redimension /N = (ITCDataWaveRows + NewRows, -1, -1, -1) ITCDataWave
	return OnsetDelay
End

Function DC_ReturnTotalLengthIncrease(panelTitle)
	string panelTitle
	controlinfo /w = $panelTitle setvar_DataAcq_OnsetDelay
	variable OnsetDelay = v_value / (DC_ITCMinSamplingInterval(panelTitle) / 1000)
	controlinfo /w = $panelTitle setvar_DataAcq_TerminationDelay
	variable TerminationDelay = v_value / (DC_ITCMinSamplingInterval(panelTitle) / 1000)
	variable NewRows = round((OnsetDelay + TerminationDelay) * 5)
	return OnsetDelay + TerminationDelay
end

