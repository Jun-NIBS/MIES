#pragma rtGlobals=3		// Use modern global access method and strict wave access.

/// @file MIES_DataConfiguratorITC.ipf
/// @brief __DC__ Handle preparations before data acquisition or
/// test pulse related to the ITC waves

/// @brief Prepare test pulse/data acquisition
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param multiDevice [optional: defaults to false] Fine tune data handling for single device (false) or multi device (true)
Function DC_ConfigureDataForITC(panelTitle, dataAcqOrTP, [multiDevice])
	string panelTitle
	variable dataAcqOrTP, multiDevice

	variable numADCs, numActiveChannels
	ASSERT(dataAcqOrTP == DATA_ACQUISITION_MODE || dataAcqOrTP == TEST_PULSE_MODE, "invalid mode")

	if(ParamIsDefault(multiDevice))
		multiDevice = 0
	else
		multiDevice = !!multiDevice
	endif

	KillOrMoveToTrash(wv=GetSweepSettingsWave(panelTitle))
	KillOrMoveToTrash(wv=GetSweepSettingsTextWave(panelTitle))
	KillOrMoveToTrash(wv=GetSweepSettingsKeyWave(panelTitle))
	KillOrMoveToTrash(wv=GetSweepSettingsTextKeyWave(panelTitle))

	NVAR stopCollectionPoint = $GetStopCollectionPoint(panelTitle)
	stopCollectionPoint = DC_GetStopCollectionPoint(panelTitle, dataAcqOrTP)

	SVAR panelTitleG = $GetPanelTitleGlobal()
	panelTitleG = panelTitle

	numActiveChannels = DC_ChanCalcForITCChanConfigWave(panelTitle, dataAcqOrTP)
	DC_MakeITCConfigAllConfigWave(panelTitle, numActiveChannels)
	DC_MakeITCDataWave(panelTitle, numActiveChannels, dataAcqOrTP)
	DC_MakeITCFIFOPosAllConfigWave(panelTitle, numActiveChannels)
	DC_MakeFIFOAvailAllConfigWave(panelTitle, numActiveChannels)

	DC_PlaceDataInITCChanConfigWave(panelTitle, dataAcqOrTP)
	DC_PlaceDataInITCDataWave(panelTitle, dataAcqOrTP, multiDevice)
	DC_PDInITCFIFOPositionAllCW(panelTitle) // PD = Place Data
	DC_PDInITCFIFOAvailAllCW(panelTitle)

	DC_UpdateClampModeString(panelTitle)

	NVAR ADChannelToMonitor = $GetADChannelToMonitor(panelTitle)
	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)
	ADChannelToMonitor = DimSize(GetDACListFromConfig(ITCChanConfigWave), ROWS)

	if(dataAcqOrTP == TEST_PULSE_MODE)
		WAVE/SDFR=GetDevicePath(panelTitle) ITCChanConfigWave
		numADCs = DimSize(GetADCListFromConfig(ITCChanConfigWave), ROWS)

		NVAR tpBufferSize = $GetTPBufferSizeGlobal(panelTitle)
		DFREF dfr = GetDeviceTestPulse(panelTitle)
		Make/O/N=(tpBufferSize, numADCs) dfr:TPBaselineBuffer = NaN
		Make/O/N=(tpBufferSize, numADCs) dfr:TPInstBuffer     = NaN
		Make/O/N=(tpBufferSize, numADCs) dfr:TPSSBuffer       = NaN

		WAVE TestPulseITC = GetTestPulseITCWave(panelTitle)
		SCOPE_CreateGraph(TestPulseITC, panelTitle)
	else
		WAVE ITCDataWave = GetITCDataWave(panelTitle)
		SCOPE_CreateGraph(ITCDataWave, panelTitle)

		NVAR count = $GetCount(panelTitle)
		// only call before the very first acquisition and
		// not each time during repeated acquisition
		if(!IsFinite(count))
			DM_CallAnalysisFunctions(panelTitle, PRE_DAQ_EVENT)
		endif
	endif
End

/// @brief Updates the global string of clamp modes based on the AD channel associated with the headstage
///
/// In the order of the ADchannels in ITCDataWave - i.e. numerical order
static Function DC_UpdateClampModeString(panelTitle)
	string panelTitle

	variable i, numChannels, headstage

	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)
	WAVE ADCs = GetADCListFromConfig(ITCChanConfigWave)

	SVAR clampModeString = $GetClampModeString(panelTitle)
	clampModeString = ""

	numChannels = DimSize(ADCs, ROWS)
	for(i = 0; i < numChannels; i += 1)
		headstage = AFH_GetHeadstageFromADC(panelTitle, ADCs[i])
		if(IsFinite(headstage))
			clampModeString = AddListItem(num2str(AI_MIESHeadstageMode(panelTitle, headstage)), clampModeString, ";", inf)
		endif
	endfor
End

/// @brief Return the number of selected checkboxes for the given type
Function DC_NoOfChannelsSelected(panelTitle, type)
	string panelTitle
	variable type

	return sum(DC_ControlStatusWave(panelTitle, type))
End

/// @brief Returns a free wave of the status of the checkboxes specified by channelType
///
/// @param type        one of the type constants from @ref ChannelTypeAndControlConstants
/// @param panelTitle  panel title
Function/Wave DC_ControlStatusWave(panelTitle, type)
	string panelTitle
	variable type

	string ctrl
	variable i, numEntries

	numEntries = GetNumberFromType(var=type)

	Make/FREE/U/B/N=(numEntries) wv

	for(i = 0; i < numEntries; i += 1)
		ctrl = GetPanelControl(panelTitle, i, type, CHANNEL_CONTROL_CHECK)
		wv[i] = GetCheckboxState(panelTitle, ctrl)
	endfor

	return wv
End

/// @brief Returns the total number of combined channel types (DA, AD, and front TTLs) selected in the DA_Ephys Gui
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP acquisition mode, one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_ChanCalcForITCChanConfigWave(panelTitle, dataAcqOrTP)
	string panelTitle
	variable dataAcqOrTP

	variable numDACs, numADCs, numTTLsRackZero, numTTLsRackOne, numActiveHeadstages

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		numDACs         = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_DAC)
		numADCs         = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_ADC)
		numTTLsRackZero = DC_AreTTLsInRackChecked(RACK_ZERO, panelTitle)
		numTTLsRackOne  = DC_AreTTLsInRackChecked(RACK_ONE, panelTitle)
	elseif(dataAcqOrTP == TEST_PULSE_MODE)
		numActiveHeadstages = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_HEADSTAGE)
		numDACs         = numActiveHeadstages
		numADCs         = numActiveHeadstages
		numTTLsRackZero = 0
		numTTLsRackOne  = 0
	else
		ASSERT(0, "Unknown value of dataAcqOrTP")
	endif

	return numDACs + numADCs + numTTLsRackZero + numTTLsRackOne
END

/// @brief Returns the ON/OFF status of the front TTLs on a specified rack.
///
/// @param RackNo Only the ITC1600 can have two racks. For all other ITC devices RackNo = 0
/// @param panelTitle  panel title
static Function DC_AreTTLsInRackChecked(RackNo, panelTitle)
	variable RackNo
	string panelTitle

	variable a
	variable b
	WAVE statusTTL = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_TTL)

	if(RackNo == 0)
		 a = 0
		 b = 3
	endif

	if(RackNo == 1)
		 a = 4
		 b = 7
	endif

	do
		if(statusTTL[a])
			return 1
		endif
		a += 1
	while(a <= b)

	return 0
End

/// @brief Returns the list of selected waves in pop up menus
///
/// @param channelType channel type, one of @ref ChannelTypeAndControlConstants
/// @param panelTitle  device
static Function/s DC_PopMenuStringList(panelTitle, channelType)
	string panelTitle
	variable channelType

	string ControlWaveList = ""
	string ctrl
	variable i, numEntries

	numEntries = GetNumberFromType(var=channelType)
	for(i = 0; i < numEntries; i += 1)
		ctrl = GetPanelControl(panelTitle, i, channelType, CHANNEL_CONTROL_WAVE)
		ControlInfo/W=$panelTitle $ctrl
		ControlWaveList = AddlistItem(s_value, ControlWaveList, ";", i)
	endfor

	return ControlWaveList
End

/// @brief Returns the number of points in the longest stimset
///
/// @param panelTitle  device
/// @param dataAcqOrTP acquisition mode, one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param channelType channel type, one of @ref ChannelTypeAndControlConstants
static Function DC_LongestOutputWave(panelTitle, dataAcqOrTP, channelType)
	string panelTitle
	variable dataAcqOrTP, channelType

	variable maxNumRows, i, numEntries
	string channelTypeWaveList = DC_PopMenuStringList(panelTitle, channelType)

	WAVE statusChannel = DC_ControlStatusWave(panelTitle, channelType)
	WAVE statusHS      = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	numEntries = DimSize(statusChannel, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, channelType, i, statusChannel, statusHS))
			continue
		endif

		WAVE/Z wv = WB_CreateAndGetStimSet(StringFromList(i, channelTypeWaveList))
		if(WaveExists(wv))
			maxNumRows = max(maxNumRows, DimSize(wv, ROWS))
		endif
	endfor

	return maxNumRows
End

//// @brief Calculate the required length of the ITCDataWave
///
/// The ITCdatawave length = 2^x where is the first integer large enough to contain the longest output wave plus one.
/// X also has a minimum value of 17 to ensure sufficient time for communication with the ITC device to prevent FIFO overflow or underrun.
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP acquisition mode, one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_CalculateITCDataWaveLength(panelTitle, dataAcqOrTP)
	string panelTitle
	variable dataAcqOrTP

	variable exponent

	NVAR stopCollectionPoint = $GetStopCollectionPoint(panelTitle)
	exponent = ceil(log(stopCollectionPoint)/log(2))

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		exponent += 1
	endif

	exponent = max(MINIMUM_ITCDATAWAVE_EXPONENT, exponent)

	return 2^exponent
end

/// @brief Returns the longest sweep in a stimulus set across the given channel type
///
/// @param panelTitle  device
/// @param dataAcqOrTP mode, either #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param channelType One of @ref ChannelTypeAndControlConstants
///
/// @return number of data points, *not* time
static Function DC_CalculateLongestSweep(panelTitle, dataAcqOrTP, channelType)
	string panelTitle
	variable dataAcqOrTP
	variable channelType

	return ceil(DC_LongestOutputWave(panelTitle, dataAcqOrTP, channelType) / DC_GetDecimationFactor(panelTitle, dataAcqOrTP))
End

/// @brief Creates the ITCConfigALLConfigWave used to configure channels the ITC device
///
/// @param panelTitle  panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
static Function DC_MakeITCConfigAllConfigWave(panelTitle, numActiveChannels)
	string panelTitle
	variable numActiveChannels

	DFREF dfr = GetDevicePath(panelTitle)
	Make/I/O/N=(numActiveChannels, 4) dfr:ITCChanConfigWave/Wave=wv
	wv = 0
End

/// @brief Creates ITCDataWave; The wave that the ITC device takes DA and TTL data from and passes AD data to for all channels.
///
/// Config all refers to configuring all the channels at once
///
/// @param panelTitle        panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
/// @param dataAcqOrTP       one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_MakeITCDataWave(panelTitle, numActiveChannels, dataAcqOrTP)
	string panelTitle
	variable numActiveChannels, dataAcqOrTP

	variable numRows

	DFREF dfr = GetDevicePath(panelTitle)
	numRows   = DC_CalculateITCDataWaveLength(panelTitle, dataAcqOrTP)

	Make/W/O/N=(numRows, numActiveChannels) dfr:ITCDataWave/Wave=ITCDataWave

	FastOp ITCDataWave = 0
	SetScale/P x 0, DAP_GetITCSampInt(panelTitle, dataAcqOrTP) / 1000, "ms", ITCDataWave
End

/// @brief Creates ITCFIFOPosAllConfigWave, the wave used to configure the FIFO on all channels of the ITC device
///
/// @param panelTitle        panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
static Function DC_MakeITCFIFOPosAllConfigWave(panelTitle, numActiveChannels)
	string panelTitle
	variable numActiveChannels

	DFREF dfr = GetDevicePath(panelTitle)
	Make/I/O/N=(numActiveChannels, 4) dfr:ITCFIFOPositionAllConfigWave/Wave=wv
	wv = 0
End

/// @brief Creates the ITCFIFOAvailAllConfigWave used to recieve FIFO position data
///
/// @param panelTitle        panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
static Function DC_MakeFIFOAvailAllConfigWave(panelTitle, numActiveChannels)
	string panelTitle
	variable numActiveChannels

	DFREF dfr = GetDevicePath(panelTitle)
	Make/I/O/N=(numActiveChannels, 4) dfr:ITCFIFOAvailAllConfigWave/Wave=wv
	wv = 0
End

/// @brief Check if the given channel is active
///
/// For DAQ a channel is active if it is selected. For the testpulse it is active if it is connected with
/// an active headstage.
///
/// `statusChannel` and `statusHS` are passed in for performance reasons.
///
/// @param panelTitle        panel title
/// @param dataAcqOrTP       one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param channelType       one of the channel type constants from @ref ChannelTypeAndControlConstants
/// @param channelNumber     number of the channel
/// @param statusChannel     status wave of the given channelType
/// @param statusHS     	 status wave of the headstages
Function DC_ChannelIsActive(panelTitle, dataAcqOrTP, channelType, channelNumber, statusChannel, statusHS)
	string panelTitle
	variable dataAcqOrTP, channelType, channelNumber
	WAVE statusChannel, statusHS

	variable headstage

	if(!statusChannel[channelNumber])
		return 0
	endif

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		return 1
	endif

	switch(channelType)
		case CHANNEL_TYPE_TTL:
			// TTL channels are always considered inactive for the testpulse
			return 0
			break
		case CHANNEL_TYPE_ADC:
			headstage = AFH_GetHeadstageFromADC(panelTitle, channelNumber)
			break
		case CHANNEL_TYPE_DAC:
			headstage = AFH_GetHeadstageFromDAC(panelTitle, channelNumber)
			break
		default:
			ASSERT(0, "unhandled case")
			break
	endswitch

	return IsFinite(headstage) && statusHS[headstage]
End

/// @brief Places channel (DA, AD, and TTL) settings data into ITCChanConfigWave
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_PlaceDataInITCChanConfigWave(panelTitle, dataAcqOrTP)
	string panelTitle
	variable dataAcqOrTP

	variable i, j, numEntries, ret, channel
	string ctrl, deviceType, deviceNumber
	string unitList = ""

	WAVE/SDFR=GetDevicePath(panelTitle) ITCChanConfigWave

	WAVE statusHS = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	// query DA properties
	WAVE channelStatus = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_DAC)

	numEntries = DimSize(channelStatus, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_DAC, i, channelStatus, statusHS))
			continue
		endif

		ITCChanConfigWave[j][0] = ITC_XOP_CHANNEL_TYPE_DAC
		ITCChanConfigWave[j][1] = i
		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_UNIT)
		unitList = AddListItem(GetSetVariableString(panelTitle, ctrl), unitList, ";", Inf)
		j += 1
	endfor

	// query AD properties
	WAVE channelStatus = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_ADC)

	numEntries = DimSize(channelStatus, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_ADC, i, channelStatus, statusHS))
			continue
		endif

		ITCChanConfigWave[j][0] = ITC_XOP_CHANNEL_TYPE_ADC
		ITCChanConfigWave[j][1] = i
		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_ADC, CHANNEL_CONTROL_UNIT)
		unitList = AddListItem(GetSetVariableString(panelTitle, ctrl), unitList, ";", Inf)
		j += 1
	endfor

	Note ITCChanConfigWave, unitList

	ITCChanConfigWave[][2] = DAP_GetITCSampInt(panelTitle, dataAcqOrTP)
	ITCChanConfigWave[][3] = 0

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		WAVE sweepDataLNB      = GetSweepSettingsWave(panelTitle)
		WAVE/T sweepDataTxTLNB = GetSweepSettingsTextWave(panelTitle)

		if(DC_AreTTLsInRackChecked(RACK_ZERO, panelTitle))
			ITCChanConfigWave[j][0] = ITC_XOP_CHANNEL_TYPE_TTL

			ret = ParseDeviceString(panelTitle, deviceType, deviceNumber)
			ASSERT(ret, "Could not parse device string")

			if(!cmpstr(deviceType, "ITC18USB") || !cmpstr(deviceType, "ITC18"))
				channel = 1
			else
				channel = 0
			endif

			ITCChanConfigWave[j][1] = channel
			sweepDataLNB[0][10][]   = channel

			j += 1
		endif

		if(DC_AreTTLsInRackChecked(RACK_ONE, panelTitle))
			ITCChanConfigWave[j][0] = ITC_XOP_CHANNEL_TYPE_TTL

			channel = 3
			ITCChanConfigWave[j][1] = channel
			sweepDataLNB[0][11][]   = channel
		endif
	endif
End

/// @brief Get the decimation factor for the current channel configuration
///
/// This is the factor between the minimum sampling interval and the real.
/// If the multiplier is taken into account depends on `dataAcqOrTP`.
///
/// @param panelTitle  device
/// @param dataAcqOrTP one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_GetDecimationFactor(panelTitle, dataAcqOrTP)
	string panelTitle
	variable dataAcqOrTP

	return DAP_GetITCSampInt(panelTitle, dataAcqOrTP) / (MINIMUM_SAMPLING_INTERVAL * 1000)
End

/// @brief Places data from appropriate DA and TTL stimulus set(s) into ITCdatawave.
/// Also records certain DA_Ephys GUI settings into sweepDataLNB and sweepDataTxTLNB
/// @param panelTitle  panel title
/// @param dataAcqOrTP one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param multiDevice [optional: defaults to false] Fine tune data handling for single device (false) or multi device (true)
static Function DC_PlaceDataInITCDataWave(panelTitle, dataAcqOrTP, multiDevice)
	string panelTitle
	variable dataAcqOrTP, multiDevice

	variable i, itcDataColumn, headstage, numEntries
	DFREF deviceDFR = GetDevicePath(panelTitle)
	WAVE/SDFR=deviceDFR ITCDataWave

	string setNameList, setName
	string ctrl, firstSetName, str, list, func, colLabel
	variable DAGain, DAScale, setColumn, insertStart, setLength, oneFullCycle, val
	variable channelMode, TPAmpVClamp, TPAmpIClamp, testPulseLength, testPulseAmplitude
	variable GlobalTPInsert, ITI, scalingZero, indexingLocked, indexing, distributedDAQ
	variable distributedDAQDelay, onSetDelay, indexActiveHeadStage, decimationFactor, cutoff
	variable multiplier, j
	variable/C ret

	globalTPInsert        = GetCheckboxState(panelTitle, "Check_Settings_InsertTP")
	ITI                   = GetSetVariable(panelTitle, "SetVar_DataAcq_ITI")
	scalingZero           = GetCheckboxState(panelTitle,  "check_Settings_ScalingZero")
	indexingLocked        = GetCheckboxState(panelTitle, "Check_DataAcq1_IndexingLocked")
	indexing              = GetCheckboxState(panelTitle, "Check_DataAcq_Indexing")
	distributedDAQ        = GetCheckboxState(panelTitle, "Check_DataAcq1_DistribDaq")
	TPAmpVClamp           = GetSetVariable(panelTitle, "SetVar_DataAcq_TPAmplitude")
	TPAmpIClamp           = GetSetVariable(panelTitle, "SetVar_DataAcq_TPAmplitudeIC")
	decimationFactor      = DC_GetDecimationFactor(panelTitle, dataAcqOrTP)
	multiplier            = str2num(GetPopupMenuString(panelTitle, "Popup_Settings_SampIntMult"))
	testPulseLength       = TP_GetTestPulseLengthInPoints(panelTitle) / multiplier
	setNameList           = DC_PopMenuStringList(panelTitle, CHANNEL_TYPE_DAC)
	DC_ReturnTotalLengthIncrease(panelTitle,onSetdelay=onSetDelay, distributedDAQDelay=distributedDAQDelay)

	NVAR baselineFrac     = $GetTestpulseBaselineFraction(panelTitle)
	WAVE ChannelClampMode = GetChannelClampMode(panelTitle)
	WAVE statusDA         = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_DAC)
	WAVE statusHS         = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	WAVE sweepDataLNB      = GetSweepSettingsWave(panelTitle)
	WAVE/T sweepDataTxTLNB = GetSweepSettingsTextWave(panelTitle)

	NVAR/Z/SDFR=GetDevicePath(panelTitle) count
	if(NVAR_exists(count))
		setColumn = count - 1
	else
		setColumn = 0
	endif

	numEntries = DimSize(statusDA, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_DAC, i, statusDA, statusHS))
			continue
		endif

		headstage = AFH_GetHeadstageFromDAC(panelTitle, i)

		setName = StringFromList(i, setNameList)
		ASSERT(dataAcqOrTP == IsTestPulseSet(setName), "Unexpected combination")
		WAVE stimSet = WB_CreateAndGetStimSet(setName)
		setLength = round(DimSize(stimSet, ROWS) / decimationFactor) - 1

		if(distributedDAQ)
			if(itcDataColumn == 0)
				firstSetName = setName
			else
				ASSERT(!cmpstr(firstSetName, setName), "Non-equal stim sets")
			endif
		endif

		if(dataAcqOrTP == TEST_PULSE_MODE)
			setColumn   = 0
			insertStart = 0
		else
			// only call DC_CalculateChannelColumnNo for real data acquisition
			ret = DC_CalculateChannelColumnNo(panelTitle, setName, i, CHANNEL_TYPE_DAC)
			oneFullCycle = imag(ret)
			setColumn    = real(ret)
			if(distributedDAQ)
				ASSERT(IsFinite(headstage), "Distributed DAQ is not possible with unassociated DACs")
				indexActiveHeadStage = sum(statusHS, 0, headstage)
				ASSERT(indexActiveHeadStage > 0, "Invalid index")
				insertStart = onsetDelay + (indexActiveHeadStage - 1) * (distributedDAQDelay + setLength)
			else
				insertStart = onsetDelay
			endif
		endif

		channelMode = ChannelClampMode[i][%DAC]
		if(channelMode == V_CLAMP_MODE)
			testPulseAmplitude = TPAmpVClamp
		elseif(channelMode == I_CLAMP_MODE)
			testPulseAmplitude = TPAmpIClamp
		else
			ASSERT(0, "Unknown clamp mode")
		endif

		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_SCALE)
		DAScale = GetSetVariable(panelTitle, ctrl)

		// checks if user wants to set scaling to 0 on sets that have already cycled once
		if(scalingZero && (indexingLocked || !indexing))
			// makes sure test pulse wave scaling is maintained
			if(dataAcqOrTP == DATA_ACQUISITION_MODE)
				if(oneFullCycle) // checks if set has completed one full cycle
					DAScale = 0
				endif
			endif
		endif

		DC_DocumentChannelProperty(panelTitle, "DAC", headstage, i, var=i)

		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_GAIN)
		val = GetSetVariable(panelTitle, ctrl)
		DAGain = 3200 / val // 3200 = 1V, 3200/gain = bits per unit

		DC_DocumentChannelProperty(panelTitle, "DA GAIN", headstage, i, var=val)

		DC_DocumentChannelProperty(panelTitle, STIM_WAVE_NAME_KEY, headstage, i, str=setName)

		for(j = 0; j < TOTAL_NUM_EVENTS; j += 1)
			func     = ExtractAnalysisFuncFromStimSet(stimSet, j)
			colLabel = GetDimLabel(sweepDataTxTLNB, COLS, 5 + j)
			DC_DocumentChannelProperty(panelTitle, colLabel, headstage, i, str=func)
		endfor

		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_UNIT)
		DC_DocumentChannelProperty(panelTitle, "DA Unit", headstage, i, str=GetSetVariableString(panelTitle, ctrl))

		DC_DocumentChannelProperty(panelTitle, "Stim Scale Factor", headstage, i, var=DAScale)
		DC_DocumentChannelProperty(panelTitle, "Set Sweep Count", headstage, i, var=setColumn)

		DC_DocumentChannelProperty(panelTitle, "TP Insert Checkbox", INDEP_HEADSTAGE, i, var=GlobalTPInsert)
		DC_DocumentChannelProperty(panelTitle, "Inter-trial interval", INDEP_HEADSTAGE, i, var=ITI)

		if(dataAcqOrTP == TEST_PULSE_MODE && multiDevice)
			Multithread ITCDataWave[insertStart, *][itcDataColumn] = (DAGain * DAScale) * stimSet[decimationFactor * mod(p - insertStart, setLength)][setColumn]
			cutOff = mod(DimSize(ITCDataWave, ROWS), testPulseLength)
			ITCDataWave[DimSize(ITCDataWave, ROWS) - cutoff, *][itcDataColumn] = 0
		else
			Multithread ITCDataWave[insertStart, insertStart + setLength][itcDataColumn] = (DAGain * DAScale) * stimSet[decimationFactor * (p - insertStart)][setColumn]
		endif

		// space in ITCDataWave for the testpulse is allocated via an automatic increase
		// of the onset delay
		if(dataAcqOrTP == DATA_ACQUISITION_MODE && globalTPInsert)
			ITCDataWave[baselineFrac * testPulseLength, (1 - baselineFrac) * testPulseLength][itcDataColumn] = testPulseAmplitude * DAGain
		endif

		itcDataColumn += 1
	endfor

	WAVE statusAD = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_ADC)

	numEntries = DimSize(statusAD, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_ADC, i, statusAD, statusHS))
			continue
		endif

		headstage = AFH_GetHeadstageFromADC(panelTitle, i)

		DC_DocumentChannelProperty(panelTitle, "ADC", headstage, i, var=i)

		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_ADC, CHANNEL_CONTROL_GAIN)
		DC_DocumentChannelProperty(panelTitle, "AD Gain", headstage, i, var=GetSetVariable(panelTitle, ctrl))

		ctrl = GetPanelControl(panelTitle, i, CHANNEL_TYPE_ADC, CHANNEL_CONTROL_UNIT)
		DC_DocumentChannelProperty(panelTitle, "AD Unit", headstage, i, str=GetSetVariableString(panelTitle, ctrl))

		itcDataColumn += 1
	endfor

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		// reset to the default value without distributedDAQ
		insertStart = onSetDelay

		// Place TTL waves into ITCDataWave
		if(DC_AreTTLsInRackChecked(RACK_ZERO, panelTitle))
			DC_MakeITCTTLWave(RACK_ZERO, panelTitle)
			WAVE/SDFR=deviceDFR TTLwave
			setLength = round(DimSize(TTLWave, ROWS) / decimationFactor) - 1
			ITCDataWave[insertStart, insertStart + setLength][itcDataColumn] = TTLWave[decimationFactor * (p - insertStart)]
			itcDataColumn += 1
		endif

		if(DC_AreTTLsInRackChecked(RACK_ONE, panelTitle))
			DC_MakeITCTTLWave(RACK_ONE, panelTitle)
			WAVE/SDFR=deviceDFR TTLwave
			setLength = round(DimSize(TTLWave, ROWS) / decimationFactor) - 1
			ITCDataWave[insertStart, insertStart + setLength][itcDataColumn] = TTLWave[decimationFactor * (p - insertStart)]
		endif
	endif
End

/// @brief Document channel properties of DA and AD channels
///
/// Knows about unassociated channels and creates the key `$entry UNASSOC_$channelNumber` for them
///
/// @param panelTitle device
/// @param entry      name of the property
/// @param headstage  number of headstage, must be `NaN` for unassociated channels
/// @param channelNumber number of the channel
/// @param var [optional] numeric value
/// @param str [optional] string value
static Function DC_DocumentChannelProperty(panelTitle, entry, headstage, channelNumber, [var, str])
	string panelTitle, entry
	variable headstage, channelNumber
	variable var
	string str

	variable colData, colKey, numCols
	string ua_entry

	ASSERT(ParamIsDefault(var) + ParamIsDefault(str) == 1, "Exactly one of var or str has to be supplied")

	WAVE sweepDataLNB         = GetSweepSettingsWave(panelTitle)
	WAVE/T sweepDataTxTLNB    = GetSweepSettingsTextWave(panelTitle)
	WAVE/T sweepDataLNBKey    = GetSweepSettingsKeyWave(panelTitle)
	WAVE/T sweepDataTxTLNBKey = GetSweepSettingsTextKeyWave(panelTitle)

	if(!ParamIsDefault(var))
		colData = FindDimLabel(sweepDataLNB, COLS, entry)
		colKey  = FindDimLabel(sweepDataLNBKey, COLS, entry)
	elseif(!ParamIsDefault(str))
		colData = FindDimLabel(sweepDataTxTLNB, COLS, entry)
		colKey  = FindDimLabel(sweepDataTxTLNBKey, COLS, entry)
	endif

	ASSERT(colData >= 0, "Could not find entry in the labnotebook input waves")
	ASSERT(colKey >= 0, "Could not find entry in the labnotebook input key waves")

	if(IsFinite(headstage))
		if(!ParamIsDefault(var))
			sweepDataLNB[0][%$entry][headstage] = var
		elseif(!ParamIsDefault(str))
			sweepDataTxTLNB[0][%$entry][headstage] = str
		endif
		return NaN
	endif

	// headstage is not finite, so the channel is unassociated
	sprintf ua_entry, "%s UNASSOC_%d", entry, channelNumber

	if(!ParamIsDefault(var))
		colData = FindDimLabel(sweepDataLNB, COLS, ua_entry)
		colKey  = FindDimLabel(sweepDataLNBKey, COLS, ua_entry)
	elseif(!ParamIsDefault(str))
		colData = FindDimLabel(sweepDataTxTLNB, COLS, ua_entry)
		colKey  = FindDimLabel(sweepDataTxTLNBKey, COLS, ua_entry)
	endif

	ASSERT((colData >= 0 && colKey >= 0) || (colData < 0 && colKey < 0), "input and key wave got out of sync")

	if(colData < 0)
		if(!ParamIsDefault(var))
			numCols = DimSize(sweepDataLNB, COLS)
			Redimension/N=(-1, numCols + 1, -1) sweepDataLNB, sweepDataLNBKey
			SetDimLabel COLS, numCols, $ua_entry, sweepDataLNB, sweepDataLNBKey
			sweepDataLNBKey[0][%$ua_entry]   = ua_entry
			sweepDataLNBKey[1,2][%$ua_entry] = sweepDataLNBKey[p][%$entry]
		elseif(!ParamIsDefault(str))
			numCols = DimSize(sweepDataTxTLNB, COLS)
			Redimension/N=(-1, numCols + 1, -1) sweepDataTxTLNB, sweepDataTxTLNBKey
			SetDimLabel COLS, numCols, $ua_entry, sweepDataTxTLNB, sweepDataTxTLNBKey
			sweepDataTxtLNBKey[0][%$ua_entry] = ua_entry
		endif
	endif

	if(!ParamIsDefault(var))
		sweepDataLNB[0][%$ua_entry][INDEP_HEADSTAGE] = var
	elseif(!ParamIsDefault(str))
		sweepDataTxTLNB[0][%$ua_entry][INDEP_HEADSTAGE] = str
	endif
End

/// @brief Populates the ITCFIFOPositionAllConfigWave
///
/// @param panelTitle  panel title
static Function DC_PDInITCFIFOPositionAllCW(panelTitle)
	string panelTitle

	WAVE ITCFIFOPositionAllConfigWave = GetITCFIFOPositionAllConfigWave(panelTitle)
	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)

	ITCFIFOPositionAllConfigWave[][0,1] = ITCChanConfigWave
	ITCFIFOPositionAllConfigWave[][2]   = -1
	ITCFIFOPositionAllConfigWave[][3]   = 0
End

/// @brief Populates the ITCFIFOAvailAllConfigWave
///
/// @param panelTitle  panel title
static Function DC_PDInITCFIFOAvailAllCW(panelTitle)
	string panelTitle

	WAVE ITCFIFOAvailAllConfigWave = GetITCFIFOAvailAllConfigWave(panelTitle)
	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)

	ITCFIFOAvailAllConfigWave[][0,1] = ITCChanConfigWave
	ITCFIFOAvailAllConfigWave[][2]   = 0
	ITCFIFOAvailAllConfigWave[][3]   = 0
End

/// @brief Combines the TTL stimulus sweeps across different TTL channels into a single wave
///
/// @param rackNo Front TTL rack aka number of ITC devices. Only the ITC1600 has two racks, see @ref RackConstants. Rack number for all other devices is #RACK_ZERO.
/// @param panelTitle  panel title
static Function DC_MakeITCTTLWave(rackNo, panelTitle)
	variable rackNo
	string panelTitle

	variable first, last, i, col, maxRows, lastIdx, bit, bits
	string set
	string listOfSets = ""

	WAVE statusTTL = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_TTL)
	WAVE statusHS = DC_ControlStatusWave(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	string TTLWaveList = DC_PopMenuStringList(panelTitle, CHANNEL_TYPE_TTL)
	DFREF deviceDFR = GetDevicePath(panelTitle)

	WAVE sweepDataLNB      = GetSweepSettingsWave(panelTitle)
	WAVE/T sweepDataTxTLNB = GetSweepSettingsTextWave(panelTitle)

	DC_GetRackRange(rackNo, first, last)

	for(i = first; i <= last; i += 1)

		if(!DC_ChannelIsActive(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL, i, statusTTL, statusHS))
			listOfSets = AddListItem(";", listOfSets, ";", inf)
			continue
		endif

		set = StringFromList(i, TTLWaveList)
		WAVE wv = WB_CreateAndGetStimSet(set)
		maxRows = max(maxRows, DimSize(wv, ROWS))
		bits += 2^(i)
		listOfSets = AddListItem(set, listOfSets, ";", inf)
	endfor

	if(rackNo == RACK_ZERO)
		sweepDataLNB[0][8][INDEP_HEADSTAGE]    = bits
		sweepDataTxTLNB[0][3][INDEP_HEADSTAGE] = listOfSets
	else
		sweepDataLNB[0][9][INDEP_HEADSTAGE]    = bits
		sweepDataTxTLNB[0][4][INDEP_HEADSTAGE] = listOfSets
	endif

	ASSERT(maxRows > 0, "Expected stim set of non-zero size")
	Make/W/O/N=(maxRows) deviceDFR:TTLWave/Wave=TTLWave = 0

	for(i = first; i <= last; i += 1)

		if(!DC_ChannelIsActive(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL, i, statusTTL, statusHS))
			continue
		endif

		set = StringFromList(i, TTLWaveList)
		WAVE TTLStimSet = WB_CreateAndGetStimSet(set)
		col = DC_CalculateChannelColumnNo(panelTitle, set, i, CHANNEL_TYPE_TTL)
		lastIdx = DimSize(TTLStimSet, ROWS) - 1
		bit = 2^(i - first)
		TTLWave[0, lastIdx] += bit * TTLStimSet[p][col]
	endfor
End

/// @brief Returns column number/step of the stimulus set, independent of the times the set is being cycled through
///        (as defined by SetVar_DataAcq_SetRepeats)
///
/// @param panelTitle    panel title
/// @param SetName       name of the stimulus set
/// @param channelNo     channel number
/// @param channelType   channel type, one of @ref CHANNEL_TYPE_DAC or @ref CHANNEL_TYPE_TTL
static Function/C DC_CalculateChannelColumnNo(panelTitle, SetName, channelNo, channelType)
	string panelTitle, SetName
	variable ChannelNo, channelType

	variable ColumnsInSet = IDX_NumberOfTrialsInSet(panelTitle, SetName)
	variable column
	variable CycleCount // when cycleCount = 1 the set has already cycled once.
	variable localCount
	string sequenceWaveName

	DFREF devicePath = GetDevicePath(panelTitle)
	NVAR/Z/SDFR=devicePath count

	// wave exists only if random set sequence is selected
	sequenceWaveName = SetName + num2str(channelType) + num2str(channelNo) + "_S"
	WAVE/Z/SDFR=devicePath WorkingSequenceWave = $sequenceWaveName

	// Below code calculates the variable local count which is then used to determine what column to select from a particular set
	if(NVAR_exists(count))// the global variable count is created at the initiation of the repeated aquisition functions and killed at their completion,
		//thus the vairable "count" is used to determine if acquisition is on the first cycle
		ControlInfo/W=$panelTitle Check_DataAcq_Indexing // check indexing status
		if(v_value == 0)// if indexing is off...
			localCount = count
			cycleCount = 0
		else // else is used when indexing is on. The local count is now set length dependent
			ControlInfo/W=$panelTitle Check_DataAcq1_IndexingLocked // check locked status. locked = popup menus on channels idex in lock - step
			if(v_value == 1)// indexing is locked
				NVAR/SDFR=GetDevicePath(panelTitle) ActiveSetCount
				ControlInfo/W=$panelTitle valdisp_DataAcq_SweepsActiveSet // how many columns in the largest currently selected set on all active channels
				localCount = v_value
				ControlInfo/W=$panelTitle SetVar_DataAcq_SetRepeats // how many times does the user want the sets to repeat
				localCount *= v_value
				localCount -= ActiveSetCount // active set count keeps track of how many steps of the largest currently selected set on all active channels has been taken
			else //indexing is unlocked
				// calculate where in list global count is
				localCount = IDX_UnlockedIndexingStepNo(panelTitle, channelNo, channelType, count)
			endif
		endif

		//Below code uses local count to determine  what step to use from the set based on the sweeps in cycle and sweeps in active set
		if(((localCount) / ColumnsInSet) < 1 || (localCount) == 0) // if remainder is less than 1, count is on 1st cycle
			ControlInfo/W=$panelTitle check_DataAcq_RepAcqRandom
			if(v_value == 0) // set step sequence is not random
				column = localCount
				cycleCount = 0
			else // set step sequence is random
				if(localCount == 0)
					InPlaceRandomShuffle(WorkingSequenceWave)
				endif
				column = WorkingSequenceWave[localcount]
				cycleCount = 0
			endif
		else
			ControlInfo/W=$panelTitle check_DataAcq_RepAcqRandom
			if(v_value == 0) // set step sequence is not random
				column = mod((localCount), columnsInSet) // set has been cyled through once or more, uses remainder to determine correct column
				cycleCount = 1
			else
				if(mod((localCount), columnsInSet) == 0)
					InPlaceRandomShuffle(WorkingSequenceWave) // added to handle 1 channel, unlocked indexing
				endif
				column = WorkingSequenceWave[mod((localCount), columnsInSet)]
				cycleCount = 1
			endif
		endif
	else
		ControlInfo/W=$panelTitle check_DataAcq_RepAcqRandom
		if(v_value == 0) // set step sequence is not random
			column = 0
		else
			Make/O/N=(ColumnsInSet) devicePath:$SequenceWaveName/Wave=WorkingSequenceWave = x
			InPlaceRandomShuffle(WorkingSequenceWave)
			column = WorkingSequenceWave[0]
		endif
	endif

	return cmplx(column, cycleCount)
End

/// @brief Returns the length increase of the ITCDataWave following onset/termination delay insertion and
/// distributed data aquisition.
///
/// All returned values are in number of points, *not* in time.
///
/// @param[in] panelTitle                      panel title
/// @param[out] onsetDelay [optional]          onset delay
/// @param[out] terminationDelay [optional]    termination delay
/// @param[out] distributedDAQDelay [optional] distributed DAQ delay
static Function DC_ReturnTotalLengthIncrease(panelTitle, [onsetDelay, terminationDelay, distributedDAQDelay])
	string panelTitle
	variable &onsetDelay, &terminationDelay, &distributedDAQDelay

	variable minSamplingInterval, onsetDelayVal, terminationDelayVal, distributedDAQDelayVal, numActiveDACs
	variable distributedDAQ

	numActiveDACs          = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_DAC)
	minSamplingInterval    = DAP_GetITCSampInt(panelTitle, DATA_ACQUISITION_MODE)
	distributedDAQ         = GetCheckboxState(panelTitle, "Check_DataAcq1_DistribDaq")
	onsetDelayVal          = round(GetSetVariable(panelTitle, "setvar_DataAcq_OnsetDelay") / (minSamplingInterval / 1000))
	terminationDelayVal    = round(GetSetVariable(panelTitle, "setvar_DataAcq_TerminationDelay") / (minSamplingInterval / 1000))
	distributedDAQDelayVal = round(GetSetVariable(panelTitle, "setvar_DataAcq_dDAQDelay") / (minSamplingInterval / 1000))

	if(!ParamIsDefault(onsetDelay))
		onsetDelay = onsetDelayVal
	endif

	if(!ParamIsDefault(terminationDelay))
		terminationDelay = terminationDelayVal
	endif

	if(!ParamIsDefault(distributedDAQDelay))
		distributedDAQDelay = distributedDAQDelayVal
	endif

	if(distributedDAQ)
		ASSERT(numActiveDACs > 0, "Number of DACs must be at least one")
		return onsetDelayVal + terminationDelayVal + distributedDAQDelayVal * (numActiveDACs - 1)
	else
		return onsetDelayVal + terminationDelayVal
	endif
End

/// @brief Calculate the stop collection point, includes all required global adjustments
Function DC_GetStopCollectionPoint(panelTitle, dataAcqOrTP)
	string panelTitle
	variable dataAcqOrTP

	variable DAClength, TTLlength, totalIncrease, multiplier
	DAClength = DC_CalculateLongestSweep(panelTitle, dataAcqOrTP, CHANNEL_TYPE_DAC)

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		totalIncrease = DC_ReturnTotalLengthIncrease(panelTitle)
		TTLlength     = DC_CalculateLongestSweep(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL)

		if(GetCheckBoxState(panelTitle, "Check_DataAcq1_DistribDaq"))
			multiplier = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_DAC)
		else
			multiplier = 1
		endif

		return max(DAClength * multiplier, TTLlength) + totalIncrease
	elseif(dataAcqOrTP == TEST_PULSE_MODE)
		return DAClength
	endif

	ASSERT(0, "unknown mode")
End

/// @brief Return the `first` and `last` TTL bits for the given `rack`
Function DC_GetRackRange(rack, first, last)
	variable rack
	variable &first, &last

	if(rack == RACK_ZERO)
		first = 0
		last = NUM_TTL_BITS_PER_RACK - 1
	elseif(rack == RACK_ONE)
		first = NUM_TTL_BITS_PER_RACK
		last = 2 * NUM_TTL_BITS_PER_RACK - 1
	else
		ASSERT(0, "Invalid rack parameter")
	endif
End
