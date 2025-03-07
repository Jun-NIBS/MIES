#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3 // Use modern global access method and strict wave access.
#pragma rtFunctionErrors=1

#ifdef AUTOMATED_TESTING
#pragma ModuleName=MIES_DC
#endif

/// @file MIES_DataConfiguratorITC.ipf
/// @brief __DC__ Handle preparations before data acquisition or
/// test pulse related to the ITC waves

/// @brief Update global variables used by the Testpulse or DAQ
///
/// @param panelTitle device
static Function DC_UpdateGlobals(panelTitle)
	string panelTitle

	// we need to update the list of analysis functions here as the stimset
	// can change due to indexing, etc.
	// @todo investigate if this is really required here
	AFM_UpdateAnalysisFunctionWave(panelTitle)

	TP_ReadTPSettingFromGUI(panelTitle)

	SVAR panelTitleG = $GetPanelTitleGlobal()
	panelTitleG = panelTitle
End

/// @brief Prepare test pulse/data acquisition
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param multiDevice [optional: defaults to false] Fine tune data handling for single device (false) or multi device (true)
///
/// @exception Abort configuration failure
Function DC_ConfigureDataForITC(panelTitle, dataAcqOrTP, [multiDevice])
	string panelTitle
	variable dataAcqOrTP, multiDevice

	variable numActiveChannels
	variable gotTPChannels
	ASSERT(dataAcqOrTP == DATA_ACQUISITION_MODE || dataAcqOrTP == TEST_PULSE_MODE, "invalid mode")

	if(ParamIsDefault(multiDevice))
		multiDevice = 0
	else
		multiDevice = !!multiDevice
	endif

	if(GetFreeMemory() < FREE_MEMORY_LOWER_LIMIT)
		printf "The amount of free memory is below %gGB, therefore a new experiment is started.\r", FREE_MEMORY_LOWER_LIMIT
		printf "Please be patient while we are performing all the necessary steps.\r"
		ControlWindowToFront()

		SaveExperimentSpecial(SAVE_AND_SPLIT)
	endif

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		if(AFM_CallAnalysisFunctions(panelTitle, PRE_SET_EVENT))
			Abort
		endif
	endif

	KillOrMoveToTrash(wv=GetSweepSettingsWave(panelTitle))
	KillOrMoveToTrash(wv=GetSweepSettingsTextWave(panelTitle))
	KillOrMoveToTrash(wv=GetSweepSettingsKeyWave(panelTitle))
	KillOrMoveToTrash(wv=GetSweepSettingsTextKeyWave(panelTitle))

	DC_UpdateGlobals(panelTitle)

	numActiveChannels = DC_ChanCalcForITCChanConfigWave(panelTitle, dataAcqOrTP)
	DC_MakeITCConfigAllConfigWave(panelTitle, numActiveChannels)

	DC_PlaceDataInITCChanConfigWave(panelTitle, dataAcqOrTP)

	gotTPChannels = GotTPChannelsOnADCs(paneltitle)

	if(dataAcqOrTP == TEST_PULSE_MODE || gotTPChannels)
		TP_CreateTestPulseWave(panelTitle)
	endif

	DC_PlaceDataInHardwareDataWave(panelTitle, numActiveChannels, dataAcqOrTP, multiDevice)

	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)
	WAVE ADCs = GetADCListFromConfig(ITCChanConfigWave)
	DC_UpdateHSProperties(panelTitle, ADCs)

	NVAR ADChannelToMonitor = $GetADChannelToMonitor(panelTitle)
	ADChannelToMonitor = DimSize(GetDACListFromConfig(ITCChanConfigWave), ROWS)

	if(dataAcqOrTP == TEST_PULSE_MODE || gotTPChannels)
		TP_CreateTPAvgBuffer(panelTitle)
	endif

	SCOPE_CreateGraph(panelTitle, dataAcqOrTP)

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		AFM_CallAnalysisFunctions(panelTitle, PRE_SWEEP_EVENT)
	endif

	WAVE HardwareDataWave = GetHardwareDataWave(panelTitle)
	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)

	ASSERT(IsValidSweepAndConfig(HardwareDataWave, ITCChanConfigWave), "Invalid sweep and config combination")
End

static Function DC_UpdateHSProperties(panelTitle, ADCs)
	string panelTitle
	WAVE ADCs

	variable i, numChannels, headStage

	WAVE GUIState = GetDA_EphysGuiStateNum(panelTitle)
	WAVE hsProp = GetHSProperties(panelTitle)

	hsProp = NaN
	hsProp[][%Enabled] = 0

	numChannels = DimSize(ADCs, ROWS)
	for(i = 0; i < numChannels; i += 1)
		headstage = AFH_GetHeadstageFromADC(panelTitle, ADCs[i])

		if(!IsFinite(headstage))
			continue
		endif

		hsProp[headStage][%Enabled]   = 1
		hsProp[headStage][%ADC]       = ADCs[i]
		hsProp[headStage][%DAC]       = AFH_GetDACFromHeadstage(panelTitle, headstage)
		hsProp[headStage][%ClampMode] = GUIState[headStage][%HSMode]

	endfor
End

/// @brief Return the number of selected checkboxes for the given type
static Function DC_NoOfChannelsSelected(panelTitle, type)
	string panelTitle
	variable type

	return sum(DAG_GetChannelState(panelTitle, type))
End

/// @brief Returns the total number of combined channel types (DA, AD, and front TTLs) selected in the DA_Ephys Gui
///
/// @param panelTitle  panel title
/// @param dataAcqOrTP acquisition mode, one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_ChanCalcForITCChanConfigWave(panelTitle, dataAcqOrTP)
	string panelTitle
	variable dataAcqOrTP

	variable numDACs, numADCs, numTTLsRackZero, numTTLsRackOne, numActiveHeadstages
	variable numTTLs

	variable hardwareType = GetHardwareType(panelTitle)
	switch(hardwareType)
		case HARDWARE_ITC_DAC:
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
			break
		case HARDWARE_NI_DAC:
			if(dataAcqOrTP == DATA_ACQUISITION_MODE)
				numDACs = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_DAC)
				numADCs = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_ADC)
				numTTLs = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_TTL)
			elseif(dataAcqOrTP == TEST_PULSE_MODE)
				numActiveHeadstages = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_HEADSTAGE)
				numDACs = numActiveHeadstages
				numADCs = numActiveHeadstages
				numTTLs = 0
			else
				ASSERT(0, "Unknown value of dataAcqOrTP")
			endif
			return numDACs + numADCs + numTTLs
			break
	endswitch

	return NaN
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
	WAVE statusTTL = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_TTL)

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

/// @brief Returns the number of points in the longest stimset
///
/// @param panelTitle  device
/// @param dataAcqOrTP acquisition mode, one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param channelType channel type, one of @ref ChannelTypeAndControlConstants
static Function DC_LongestOutputWave(panelTitle, dataAcqOrTP, channelType)
	string panelTitle
	variable dataAcqOrTP, channelType

	variable maxNumRows, i, numEntries, numPulses, singlePulseLength

	WAVE statusChannel = DAG_GetChannelState(panelTitle, channelType)
	WAVE statusHS      = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_HEADSTAGE)
	WAVE/T stimsets    = DAG_GetChannelTextual(panelTitle, channelType, CHANNEL_CONTROL_WAVE)

	numEntries = DimSize(statusChannel, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, channelType, i, statusChannel, statusHS))
			continue
		endif

		if(dataAcqOrTP == DATA_ACQUISITION_MODE)
			WAVE/Z wv = WB_CreateAndGetStimSet(stimsets[i])
		elseif(dataAcqOrTP == TEST_PULSE_MODE)
			WAVE/Z wv = GetTestPulse()
		else
			ASSERT(0, "unhandled case")
		endif

		if(!WaveExists(wv))
			continue
		endif

		if(dataAcqOrTP == TEST_PULSE_MODE                             \
		   && GetHardwareType(panelTitle) == HARDWARE_ITC_DAC         \
		   && DAG_GetNumericalValue(panelTitle, "check_Settings_MD"))
			// ITC hardware requires us to use a pulse train for TP MD,
			// so we need to determine the number of TP pulses here (numPulses)
			// In DC_PlaceDataInHardwareDataWave we write as many pulses into the
			// HardwareDataWave which fit in
			singlePulseLength = DimSize(wv, ROWS)
			numPulses = max(10, ceil((2^(MINIMUM_ITCDATAWAVE_EXPONENT + 1) * 0.90) / singlePulseLength))
			maxNumRows = max(maxNumRows, numPulses * singlePulseLength)
		else
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

	variable hardwareType = GetHardwareType(panelTitle)
	NVAR stopCollectionPoint = $GetStopCollectionPoint(panelTitle)

	switch(hardwareType)
		case HARDWARE_ITC_DAC:
			variable exponent = FindNextPower(stopCollectionPoint, 2)

			if(dataAcqOrTP == DATA_ACQUISITION_MODE)
				exponent += 1
			endif

			exponent = max(MINIMUM_ITCDATAWAVE_EXPONENT, exponent)

			return 2^exponent
			break
		case HARDWARE_NI_DAC:
			return stopCollectionPoint
			break
	endswitch
	return NaN
end


/// @brief Creates the ITCConfigALLConfigWave used to configure channels the ITC device
///
/// @param panelTitle  panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
static Function DC_MakeITCConfigAllConfigWave(panelTitle, numActiveChannels)
	string panelTitle
	variable numActiveChannels

	WAVE config = GetITCChanConfigWave(panelTitle)

	Redimension/N=(numActiveChannels, -1) config
	FastOp config = 0
End

/// @brief Creates HardwareDataWave; The wave that the device takes DA and TTL data from and passes AD data to for all channels.
///
/// Config all refers to configuring all the channels at once
///
/// @param panelTitle          panel title
/// @param numActiveChannels   number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
/// @param samplingInterval    sampling interval as returned by DAP_GetSampInt()
/// @param dataAcqOrTP         one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_MakeHardwareDataWave(panelTitle, numActiveChannels, samplingInterval, dataAcqOrTP)
	string panelTitle
	variable numActiveChannels, samplingInterval, dataAcqOrTP

	variable numRows, i

	// prevent crash in ITC XOP as it must not run if we resize the ITCDataWave
	NVAR ITCDeviceIDGlobal = $GetITCDeviceIDGlobal(panelTitle)
	variable hardwareType = GetHardwareType(panelTitle)
	ASSERT(!HW_IsRunning(hardwareType, ITCDeviceIDGlobal), "Hardware is still running and it shouldn't. Please report that as a bug.")

	DFREF dfr = GetDevicePath(panelTitle)
	numRows   = DC_CalculateITCDataWaveLength(panelTitle, dataAcqOrTP)
	switch(hardwareType)
		case HARDWARE_ITC_DAC:

			Make/W/O/N=(numRows, numActiveChannels) dfr:HardwareDataWave/Wave=HardwareDataWave

			FastOp HardwareDataWave = 0
			SetScale/P x 0, samplingInterval / 1000, "ms", HardwareDataWave
			break
		case HARDWARE_NI_DAC:
			WAVE/WAVE NIDataWave = GetHardwareDataWave(panelTitle)
			for(i = numActiveChannels; i < numpnts(NIDataWave); i += 1)
				WAVE/Z NIChannel = NIDataWave[i]
				KillWaves/Z NIChannel
			endfor
			Redimension/N=(numActiveChannels) NIDataWave

			SetScale/P x 0, samplingInterval / 1000, "ms", NIDataWave

			make/FREE/N=(numActiveChannels) type = SWS_GetRawDataFPType(panelTitle)
			WAVE config = GetITCChanConfigWave(panelTitle)
			type = config[p][%ChannelType] == ITC_XOP_CHANNEL_TYPE_TTL ? IGOR_TYPE_UNSIGNED | IGOR_TYPE_8BIT_INT : type[p]
			NIDataWave = DC_MakeNIChannelWave(dfr, numRows, samplingInterval, p, type[p])
			break
	endswitch
End

/// @brief Creates a single NIChannel wave
///
/// Config all refers to configuring all the channels at once
///
/// @param dfr              Data Folder reference where the wave is created
/// @param numRows          size of the 1D channel wave
/// @param samplingInterval minimum sample intervall in microseconds
/// @param index            number of NI channel
/// @param type             number type of NI channel
///
/// @return                 Wave Reference to NI Channel wave
static Function/WAVE DC_MakeNIChannelWave(dfr, numRows, samplingInterval, index, type)
	DFREF dfr
	variable numRows, samplingInterval, index, type

	Make/O/N=(numRows)/Y=(type) dfr:$("NI_Channel" + num2str(index))/WAVE=w
	FastOp w = 0
	SetScale/P x 0, samplingInterval / 1000, "ms", w
	return w
End

/// @brief Initializes the wave used for displaying DAQ/TP results in the
/// oscilloscope window
///
/// @param panelTitle  panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
/// @param dataAcqOrTP one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_MakeOscilloscopeWave(panelTitle, numActiveChannels, dataAcqOrTP)
	string panelTitle
	variable numActiveChannels, dataAcqOrTP

	variable numRows, sampleIntervall, col
	WAVE config = GetITCChanConfigWave(panelTitle)
	WAVE OscilloscopeData = GetOscilloscopeWave(panelTitle)
	variable hardwareType = GetHardwareType(panelTitle)
	switch(hardwareType)
		case HARDWARE_ITC_DAC:
			WAVE ITCDataWave      = GetHardwareDataWave(panelTitle)
			if(dataAcqOrTP == TEST_PULSE_MODE)
				numRows = TP_GetTestPulseLengthInPoints(panelTitle, TEST_PULSE_MODE)
			elseif(dataAcqOrTP == DATA_ACQUISITION_MODE)
				numRows = DimSize(ITCDataWave, ROWS)
			else
				ASSERT(0, "Invalid dataAcqOrTP value")
			endif
			sampleIntervall = DimDelta(ITCDataWave, ROWS)
			break
		case HARDWARE_NI_DAC:
			WAVE/WAVE NIDataWave      = GetHardwareDataWave(panelTitle)
			if(dataAcqOrTP == TEST_PULSE_MODE)
				numRows = TP_GetTestPulseLengthInPoints(panelTitle, TEST_PULSE_MODE)
			elseif(dataAcqOrTP == DATA_ACQUISITION_MODE)
				if(numpnts(NIDataWave))
					numRows = numpnts(NIDataWave[0])
				else
					ASSERT(0, "No channels in NIDataWave")
				endif
			else
				ASSERT(0, "Invalid dataAcqOrTP value")
			endif
			sampleIntervall = DimDelta(NIDataWave[0], ROWS)
			break
	endswitch

	Redimension/N=(numRows, numActiveChannels) OscilloscopeData
	SetScale/P x, 0, sampleIntervall, "ms", OscilloscopeData
	// 0/0 equals NaN, this is not accepted directly
	WaveTransform/O/V=(0/0) setConstant OscilloscopeData
	// set DAC channels to 0, this is required for PowerSpectrum as FFT source wave must not contain NaNs
	for(col = 0; col < numActiveChannels; col += 1)
		if(config[col][%ChannelType] == ITC_XOP_CHANNEL_TYPE_DAC)
			MultiThread OscilloscopeData[][col] = 0
		else
			break
		endif
	endfor
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
	variable col, adc, dac, headstage
	string ctrl, deviceType, deviceNumber
	string unitList = ""

	WAVE ITCChanConfigWave = GetITCChanConfigWave(panelTitle)
	WAVE statusHS = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	// query DA properties
	WAVE channelStatus = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_DAC)
	WAVE/T allSetNames    = DAG_GetChannelTextual(panelTitle, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_WAVE)
	ctrl = GetSpecialControlLabel(CHANNEL_TYPE_DAC, CHANNEL_CONTROL_UNIT)

	numEntries = DimSize(channelStatus, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_DAC, i, channelStatus, statusHS))
			continue
		endif

		ITCChanConfigWave[j][%ChannelType]   = ITC_XOP_CHANNEL_TYPE_DAC
		ITCChanConfigWave[j][%ChannelNumber] = i
		unitList = AddListItem(DAG_GetTextualValue(panelTitle, ctrl, index = i), unitList, ",", Inf)
		ITCChanConfigWave[j][%DAQChannelType] = !CmpStr(allSetNames[i], STIMSET_TP_WHILE_DAQ, 1) || dataAcqOrTP == TEST_PULSE_MODE ? DAQ_CHANNEL_TYPE_TP : DAQ_CHANNEL_TYPE_DAQ
		j += 1
	endfor

	// query AD properties
	WAVE channelStatus = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_ADC)

	ctrl = GetSpecialControlLabel(CHANNEL_TYPE_ADC, CHANNEL_CONTROL_UNIT)

	numEntries = DimSize(channelStatus, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_ADC, i, channelStatus, statusHS))
			continue
		endif

		ITCChanConfigWave[j][%ChannelType]   = ITC_XOP_CHANNEL_TYPE_ADC
		ITCChanConfigWave[j][%ChannelNumber] = i
		unitList = AddListItem(DAG_GetTextualValue(panelTitle, ctrl, index = i), unitList, ",", Inf)

		headstage = AFH_GetHeadstageFromADC(panelTitle, i)

		if(IsFinite(headstage))
			// use the same channel type as the DAC
			ITCChanConfigWave[j][%DAQChannelType] = DC_GetChannelTypefromHS(panelTitle, headstage)
		else
			// unassociated ADCs are always of DAQ type
			ITCChanConfigWave[j][%DAQChannelType] = DAQ_CHANNEL_TYPE_DAQ
		endif

		j += 1
	endfor

	AddEntryIntoWaveNoteAsList(ITCChanConfigWave, CHANNEL_UNIT_KEY, str = unitList, replaceEntry = 1)

	ITCChanConfigWave[][%SamplingInterval] = DAP_GetSampInt(panelTitle, dataAcqOrTP)
	ITCChanConfigWave[][%DecimationMode]   = 0
	ITCChanConfigWave[][%Offset]           = 0

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		variable hardwareType = GetHardwareType(panelTitle)
		switch(hardwareType)
			case HARDWARE_ITC_DAC:
				WAVE sweepDataLNB = GetSweepSettingsWave(panelTitle)

				if(DC_AreTTLsInRackChecked(RACK_ZERO, panelTitle))
					ITCChanConfigWave[j][%ChannelType] = ITC_XOP_CHANNEL_TYPE_TTL

					channel = HW_ITC_GetITCXOPChannelForRack(panelTitle, RACK_ZERO)
					ITCChanConfigWave[j][%ChannelNumber] = channel
					sweepDataLNB[0][10][INDEP_HEADSTAGE] = channel
					ITCChanConfigWave[j][%DAQChannelType] = DAQ_CHANNEL_TYPE_DAQ

					j += 1
				endif

				if(DC_AreTTLsInRackChecked(RACK_ONE, panelTitle))
					ITCChanConfigWave[j][%ChannelType] = ITC_XOP_CHANNEL_TYPE_TTL

					channel = HW_ITC_GetITCXOPChannelForRack(panelTitle, RACK_ONE)
					ITCChanConfigWave[j][%ChannelNumber] = channel
					sweepDataLNB[0][11][INDEP_HEADSTAGE] = channel
					ITCChanConfigWave[j][%DAQChannelType] = DAQ_CHANNEL_TYPE_DAQ
				endif
				break
			case HARDWARE_NI_DAC:
				WAVE statusTTL = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_TTL)
				for(i = 0; i < numpnts(statusTTL); i += 1)
					if(statusTTL[i])
						ITCChanConfigWave[j][%ChannelType] = ITC_XOP_CHANNEL_TYPE_TTL
						ITCChanConfigWave[j][%ChannelNumber] = i
						ITCChanConfigWave[j][%DAQChannelType] = DAQ_CHANNEL_TYPE_DAQ
						j += 1
					endif
				endfor
				break
		endswitch
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

	return DAP_GetSampInt(panelTitle, dataAcqOrTP) / (WAVEBUILDER_MIN_SAMPINT * 1000)
End

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

	return DC_CalculateGeneratedDataSize(panelTitle, dataAcqOrTP, DC_LongestOutputWave(panelTitle, dataAcqOrTP, channelType))
End

/// @brief Get the stimset length for the real sampling interval
///
/// @param stimSet          stimset wave
/// @param panelTitle 		 device
/// @param dataAcqOrTP      one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
static Function DC_CalculateStimsetLength(stimSet, panelTitle, dataAcqOrTP)
	WAVE stimSet
	string panelTitle
	variable dataAcqOrTP

	return DC_CalculateGeneratedDataSize(panelTitle, dataAcqOrTP, DimSize(stimSet, ROWS))
End

/// @brief Get the length for the real sampling interval from a generated wave with length
///
/// @param panelTitle 		 device
/// @param dataAcqOrTP      one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param genLength        length of a generated data wave
static Function DC_CalculateGeneratedDataSize(panelTitle, dataAcqOrTP, genLength)
	string panelTitle
	variable dataAcqOrTP, genLength

	// note: the decimationFactor is the factor between the hardware sample rate and the sample rate of the generated waveform in singleStimSet
	// The ratio of the source to target wave sizes is however limited by the integer size of both waves
	// While ideally srcLength == tgtLength the floor(...) limits the real data wave length such that
	// when decimationFactor * index of real data wave is applied as index of the generated data wave it never exceeds its size
	// Also if decimationFactor >= 2 the last point of the generated data wave is never transferred
	// e.g. generated data with 10 points and decimationFactor == 2 copies index 0, 2, 4, 6, 8 to the real data wave of size 5
	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		return floor(genLength / DC_GetDecimationFactor(panelTitle, dataAcqOrTP))
	elseif(dataAcqOrTP == TEST_PULSE_MODE)
		return genLength
	else
		ASSERT(0, "unhandled case")
	endif
End

/// @brief Places data from appropriate DA and TTL stimulus set(s) into HardwareDataWave.
/// Also records certain DA_Ephys GUI settings into sweepDataLNB and sweepDataTxTLNB
/// @param panelTitle        panel title
/// @param numActiveChannels number of active channels as returned by DC_ChanCalcForITCChanConfigWave()
/// @param dataAcqOrTP       one of #DATA_ACQUISITION_MODE or #TEST_PULSE_MODE
/// @param multiDevice       Fine tune data handling for single device (false) or multi device (true)
///
/// @exception Abort configuration failure
static Function DC_PlaceDataInHardwareDataWave(panelTitle, numActiveChannels, dataAcqOrTP, multiDevice)
	string panelTitle
	variable numActiveChannels, dataAcqOrTP, multiDevice

	variable i, j
	variable activeColumn, numEntries, setChecksum, stimsetCycleID, fingerprint, hardwareType, maxITI
	string ctrl, str, list, func
	variable setCycleCount, val, singleSetLength, singleInsertStart, samplingInterval
	variable channelMode, TPAmpVClamp, TPAmpIClamp, testPulseLength, maxStimSetLength
	variable GlobalTPInsert, scalingZero, indexingLocked, indexing, distributedDAQ, pulseToPulseLength
	variable distributedDAQDelay, onSetDelay, onsetDelayAuto, onsetDelayUser, decimationFactor, cutoff
	variable multiplier, powerSpectrum, distributedDAQOptOv, distributedDAQOptPre, distributedDAQOptPost, headstage
	variable lastValidRow, isoodDAQMember
	variable/C ret
	variable TPLength

	globalTPInsert        = DAG_GetNumericalValue(panelTitle, "Check_Settings_InsertTP")
	scalingZero           = DAG_GetNumericalValue(panelTitle,  "check_Settings_ScalingZero")
	indexingLocked        = DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_IndexingLocked")
	indexing              = DAG_GetNumericalValue(panelTitle, "Check_DataAcq_Indexing")
	distributedDAQ        = DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_DistribDaq")
	distributedDAQOptOv   = DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_dDAQOptOv")
	distributedDAQOptPre  = DAG_GetNumericalValue(panelTitle, "Setvar_DataAcq_dDAQOptOvPre")
	distributedDAQOptPost = DAG_GetNumericalValue(panelTitle, "Setvar_DataAcq_dDAQOptOvPost")
	TPAmpVClamp           = DAG_GetNumericalValue(panelTitle, "SetVar_DataAcq_TPAmplitude")
	TPAmpIClamp           = DAG_GetNumericalValue(panelTitle, "SetVar_DataAcq_TPAmplitudeIC")
	powerSpectrum         = DAG_GetNumericalValue(panelTitle, "check_settings_show_power")
// MH: note with NI the decimationFactor can now be < 1, like 0.4 if a single NI ADC channel runs with 500 kHz
// whereas the source data generated waves for ITC min sample rate are at 200 kHz
	decimationFactor      = DC_GetDecimationFactor(panelTitle, dataAcqOrTP)
	samplingInterval      = DAP_GetSampInt(panelTitle, dataAcqOrTP)
	multiplier            = str2num(DAG_GetTextualValue(panelTitle, "Popup_Settings_SampIntMult"))
	testPulseLength       = TP_GetTestPulseLengthInPoints(panelTitle, DATA_ACQUISITION_MODE)
	WAVE/T allSetNames    = DAG_GetChannelTextual(panelTitle, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_WAVE)
	DC_ReturnTotalLengthIncrease(panelTitle, onsetdelayUser=onsetDelayUser, onsetDelayAuto=onsetDelayAuto, distributedDAQDelay=distributedDAQDelay)
	onsetDelay            = onsetDelayUser + onsetDelayAuto

	NVAR baselineFrac     = $GetTestpulseBaselineFraction(panelTitle)
	WAVE ChannelClampMode = GetChannelClampMode(panelTitle)
	WAVE statusDA         = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_DAC)
	WAVE statusHS         = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	WAVE sweepDataLNB         = GetSweepSettingsWave(panelTitle)
	WAVE/T sweepDataTxTLNB    = GetSweepSettingsTextWave(panelTitle)
	WAVE/T cellElectrodeNames = GetCellElectrodeNames(panelTitle)
	WAVE/T analysisFunctions  = GetAnalysisFunctionStorage(panelTitle)
	WAVE setEventFlag         = GetSetEventFlag(panelTitle)
	WAVE DAGain 				  = SWS_GetChannelGains(panelTitle)
	WAVE config               = GetITCChanConfigWave(panelTitle)

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		setEventFlag = 0
	endif

	numEntries = DimSize(statusDA, ROWS)
	Make/D/FREE/N=(numEntries) DAScale, insertStart, setLength, testPulseAmplitude, setColumn, headstageDAC, DAC
	Make/T/FREE/N=(numEntries) setName
	Make/WAVE/FREE/N=(numEntries) stimSet

	NVAR raCycleID = $GetRepeatedAcquisitionCycleID(panelTitle)
	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		ASSERT(IsFinite(raCycleID), "Uninitialized raCycleID detected")
	endif

	DC_DocumentChannelProperty(panelTitle, RA_ACQ_CYCLE_ID_KEY, INDEP_HEADSTAGE, NaN, var=raCycleID)

	// For all DAC channels, setup reduced waves with active channels: DAC, headstageDAC, setName, stimSet, setColumn etc.
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_DAC, i, statusDA, statusHS))
			continue
		endif

		DAC[activeColumn]          = i
		headstageDAC[activeColumn] = AFH_GetheadstageFromDAC(panelTitle, i)
		// Setup stimset name for logging and stimset, for tp mode and tp channels stimset references the tp wave
		if(dataAcqOrTP == DATA_ACQUISITION_MODE)

			setName[activeColumn] = allSetNames[i]
			if(config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ)
				stimSet[activeColumn] = WB_CreateAndGetStimSet(setName[activeColumn])
			elseif(config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_TP)
				stimSet[activeColumn] = GetTestPulse()
			else
				ASSERT(0, "Unknown DAQ Channel Type")
			endif

		elseif(dataAcqOrTP == TEST_PULSE_MODE)

			setName[activeColumn] = "testpulse"
			stimSet[activeColumn] = GetTestPulse()

		else
			ASSERT(0, "unknown mode")
		endif

		// restarting DAQ via the stimset popup menues does not call DAP_CheckSettings()
		// so the stimest must not exist here
		if(!WaveExists(stimSet[activeColumn]))
			Abort
		endif

		if(dataAcqOrTP == TEST_PULSE_MODE)
			setColumn[activeColumn] = 0
		elseif(config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_TP)
			// DATA_ACQUISITION_MODE cases
			setColumn[activeColumn] = 0
		elseif(config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ)
			// only call DC_CalculateChannelColumnNo for real data acquisition
			ret = DC_CalculateChannelColumnNo(panelTitle, setName[activeColumn], i, CHANNEL_TYPE_DAC)
			setCycleCount = imag(ret)
			setColumn[activeColumn] = real(ret)
		endif

		maxITI = max(maxITI, WB_GetITI(stimSet[activeColumn], setColumn[activeColumn]))

		if(IsFinite(headstageDAC[activeColumn]))
			channelMode = ChannelClampMode[i][%DAC][%ClampMode]
			if(channelMode == V_CLAMP_MODE)
				testPulseAmplitude[activeColumn] = TPAmpVClamp
			elseif(channelMode == I_CLAMP_MODE || channelMode == I_EQUAL_ZERO_MODE)
				testPulseAmplitude[activeColumn] = TPAmpIClamp
			else
				ASSERT(0, "Unknown clamp mode")
			endif
		else // unassoc channel
			channelMode = NaN
			testPulseAmplitude[activeColumn] = 0.0
		endif

		ctrl = GetSpecialControlLabel(CHANNEL_TYPE_DAC, CHANNEL_CONTROL_SCALE)
		DAScale[activeColumn] = DAG_GetNumericalValue(panelTitle, ctrl, index = i)

		// DAScale tuning for special cases
		if(dataAcqOrTP == DATA_ACQUISITION_MODE)
			if(config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ)
				// checks if user wants to set scaling to 0 on sets that have already cycled once
				if(scalingZero && (indexingLocked || !indexing) && setCycleCount > 0)
					DAScale[activeColumn] = 0
				endif

				if(channelMode == I_EQUAL_ZERO_MODE)
					DAScale[activeColumn]            = 0.0
					testPulseAmplitude[activeColumn] = 0.0
				endif
			elseif(config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_TP)
				if(powerSpectrum)
					testPulseAmplitude[activeColumn] = 0.0
				endif
				DAScale[activeColumn] = testPulseAmplitude[activeColumn]
			endif
		elseif(dataAcqOrTP == TEST_PULSE_MODE)
			if(powerSpectrum)
				testPulseAmplitude[activeColumn] = 0.0
			endif
			DAScale[activeColumn] = testPulseAmplitude[activeColumn]
		else
			ASSERT(0, "unknown mode")
		endif

		DC_DocumentChannelProperty(panelTitle, "DAC", headstageDAC[activeColumn], i, var=i)
		ctrl = GetSpecialControlLabel(CHANNEL_TYPE_DAC, CHANNEL_CONTROL_GAIN)
		DC_DocumentChannelProperty(panelTitle, "DA GAIN", headstageDAC[activeColumn], i, var=DAG_GetNumericalValue(panelTitle, ctrl, index = i))
		DC_DocumentChannelProperty(panelTitle, "DA ChannelType", headstageDAC[activeColumn], i, var = config[activeColumn][%DAQChannelType])

		DC_DocumentChannelProperty(panelTitle, STIM_WAVE_NAME_KEY, headstageDAC[activeColumn], i, str=setName[activeColumn])
		DC_DocumentChannelProperty(panelTitle, STIMSET_WAVE_NOTE_KEY, headstageDAC[activeColumn], i, str=NormalizeToEOL(RemoveEnding(note(stimSet[activeColumn]), "\r"), "\n"))

		for(j = 0; j < TOTAL_NUM_EVENTS; j += 1)
			if(IsFinite(headstageDAC[activeColumn])) // associated channel
				func = analysisFunctions[headstageDAC[activeColumn]][j]
			else
				func = ""
			endif

			DC_DocumentChannelProperty(panelTitle, StringFromList(j, EVENT_NAME_LIST_LBN), headstageDAC[activeColumn], i, str=func)
		endfor

		if(IsFinite(headstageDAC[activeColumn])) // associated channel
			str = analysisFunctions[headstageDAC[activeColumn]][ANALYSIS_FUNCTION_PARAMS]
		else
			str = ""
		endif

		DC_DocumentChannelProperty(panelTitle, ANALYSIS_FUNCTION_PARAMS_LBN, headstageDAC[activeColumn], i, str=str)

		ctrl = GetSpecialControlLabel(CHANNEL_TYPE_DAC, CHANNEL_CONTROL_UNIT)
		DC_DocumentChannelProperty(panelTitle, "DA Unit", headstageDAC[activeColumn], i, str=DAG_GetTextualValue(panelTitle, ctrl, index = i))

		DC_DocumentChannelProperty(panelTitle, STIMSET_SCALE_FACTOR_KEY, headstageDAC[activeColumn], i, var=DAScale[activeColumn])
		DC_DocumentChannelProperty(panelTitle, "Set Sweep Count", headstageDAC[activeColumn], i, var=setColumn[activeColumn])
		DC_DocumentChannelProperty(panelTitle, "Electrode", headstageDAC[activeColumn], i, str=cellElectrodeNames[headstageDAC[activeColumn]])
		DC_DocumentChannelProperty(panelTitle, "Set Cycle Count", headstageDAC[activeColumn], i, var=setCycleCount)

		setChecksum = WB_GetStimsetChecksum(stimSet[activeColumn], setName[activeColumn], dataAcqOrTP)
		DC_DocumentChannelProperty(panelTitle, "Stim Wave Checksum", headstageDAC[activeColumn], i, var=setChecksum)

		if(dataAcqOrTP == DATA_ACQUISITION_MODE && config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ)
			fingerprint = DC_GenerateStimsetFingerprint(raCycleID, setName[activeColumn], setCycleCount, setChecksum, dataAcqOrTP)
			stimsetCycleID = DC_GetStimsetAcqCycleID(panelTitle, fingerprint, i)

			setEventFlag[i][] = (setColumn[activeColumn] + 1 == IDX_NumberOfSweepsInSet(setName[activeColumn]))
			DC_DocumentChannelProperty(panelTitle, STIMSET_ACQ_CYCLE_ID_KEY, headstageDAC[activeColumn], i, var=stimsetCycleID)
		endif

		if(dataAcqOrTP == DATA_ACQUISITION_MODE)
			isoodDAQMember = (distributedDAQOptOv && config[activeColumn][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ && IsFinite(headstageDAC[i]))
			DC_DocumentChannelProperty(panelTitle, "oodDAQ member", headstageDAC[i], i, var=isoodDAQMember)
		endif

		activeColumn += 1
	endfor

	NVAR maxITIGlobal = $GetMaxIntertrialInterval(panelTitle)
	ASSERT(IsFinite(maxITI), "Invalid maxITI")
	maxITIGlobal = maxITI
	DC_DocumentChannelProperty(panelTitle, "Inter-trial interval", INDEP_HEADSTAGE, NaN, var=maxITIGlobal)
	// change numEntries to hold the number of active channels
	numEntries = activeColumn
	Redimension/N=(numEntries) DAGain, DAScale, insertStart, setLength, testPulseAmplitude, setColumn, stimSet, setName, headstageDAC

	// for distributedDAQOptOv create temporary reduced input waves holding DAQ types channels only, put results back to unreduced waves
	if(distributedDAQOptOv && dataAcqOrTP == DATA_ACQUISITION_MODE)
		Duplicate/FREE/WAVE stimSet, reducedStimSet
		Duplicate/FREE setColumn, reducedSetColumn, iTemp

		j = 0
		for(i = 0; i < numEntries; i += 1)
			if(config[i][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ)
				reducedStimSet[j] = stimSet[i]
				reducedSetColumn[j] = setColumn[i]
				iTemp[j] = i
				j += 1
			endif
		endfor
		Redimension/N=(j) reducedStimSet, reducedSetColumn

		STRUCT OOdDAQParams params
		InitOOdDAQParams(params, reducedStimSet, reducedSetColumn, distributedDAQOptPre, distributedDAQOptPost)
		WAVE/WAVE reducedStimSet = OOD_GetResultWaves(panelTitle, params)
		WAVE reducedOffsets = params.offsets
		WAVE/T reducedRegions = params.regions

		Make/FREE/N=(numEntries) offsets = 0
		Make/FREE/T/N=(numEntries) regions

		j = DimSize(reducedStimSet, ROWS)
		for(i = 0; i < j; i += 1)
			stimSet[iTemp[i]] = reducedStimSet[i]
			setColumn[iTemp[i]] = reducedSetColumn[i]
			offsets[iTemp[i]] = reducedOffsets[i]
			regions[iTemp[i]] = reducedRegions[i]
		endfor
	endif
	// when DC_CalculateStimsetLength is called with dataAcqOrTP = DATA_ACQUISITION_MODE decimationFactor is considered
	if(dataAcqOrTP == TEST_PULSE_MODE)
		setLength[] = DC_CalculateStimsetLength(stimSet[p], panelTitle, TEST_PULSE_MODE)
	elseif(dataAcqOrTP == DATA_ACQUISITION_MODE)
		Duplicate/FREE setLength, setMode
		setMode[] = config[p][%DAQChannelType] == DAQ_CHANNEL_TYPE_TP ? TEST_PULSE_MODE : DATA_ACQUISITION_MODE
		setLength[] = DC_CalculateStimsetLength(stimSet[p], panelTitle, setMode[p])
	endif

	if(dataAcqOrTP == TEST_PULSE_MODE)
		insertStart[] = 0
	elseif(dataAcqOrTP == DATA_ACQUISITION_MODE)
		if(distributedDAQ)
			insertStart[] = onsetDelay + (sum(statusHS, 0, headstageDAC[p]) - 1) * (distributedDAQDelay + setLength[p])
		else
			insertStart[] = onsetDelay
		endif
	endif

	NVAR stopCollectionPoint = $GetStopCollectionPoint(panelTitle)
	stopCollectionPoint = DC_GetStopCollectionPoint(panelTitle, dataAcqOrTP, setLength)

	DC_MakeHardwareDataWave(panelTitle, numActiveChannels, samplingInterval, dataAcqOrTP)
	DC_MakeOscilloscopeWave(panelTitle, numActiveChannels, dataAcqOrTP)

	NVAR fifoPosition = $GetFifoPosition(panelTitle)
	fifoPosition = 0

	hardwareType = GetHardwareType(panelTitle)
	switch(hardwareType)
		case HARDWARE_ITC_DAC:
			WAVE ITCDataWave = GetHardwareDataWave(panelTitle)
			break
		case HARDWARE_NI_DAC:
			WAVE/WAVE NIDataWave = GetHardwareDataWave(panelTitle)
			break
	endswitch

	ClearRTError()

	// varies per DAC:
	// DAGain, DAScale, insertStart (with dDAQ), setLength, testPulseAmplitude (can be non-constant due to different VC/IC)
	// setName, setColumn, headstageDAC
	//
	// constant:
	// decimationFactor, testPulseLength, baselineFrac
	//
	// we only have to fill in the DA channels
	if(dataAcqOrTP == TEST_PULSE_MODE)
		ASSERT(sum(insertStart) == 0, "Unexpected insert start value")
		ASSERT(sum(setColumn) == 0, "Unexpected setColumn value")
		WAVE testPulse = stimSet[0]
		TPLength = setLength[0]
		ASSERT(DimSize(testPulse, COLS) <= 1, "Expected a 1D testpulse wave")
		switch(hardwareType)
			case HARDWARE_ITC_DAC:
				if(multiDevice)
					Multithread ITCDataWave[][0, numEntries - 1] =          \
					limit(                                                  \
					(DAGain[q] * DAScale[q]) * testPulse[mod(p, TPLength)], \
					SIGNED_INT_16BIT_MIN,                                   \
					SIGNED_INT_16BIT_MAX); AbortOnRTE
					cutOff = mod(DimSize(ITCDataWave, ROWS), TPLength)
					if(cutOff > 0)
						ITCDataWave[DimSize(ITCDataWave, ROWS) - cutoff, *][0, numEntries - 1] = 0
					endif
				else
					Multithread ITCDataWave[0, TPLength - 1][0, numEntries - 1] = \
					limit(                                                        \
					DAGain[q] * DAScale[q] * testPulse[p],                        \
					SIGNED_INT_16BIT_MIN,                                         \
					SIGNED_INT_16BIT_MAX); AbortOnRTE
				endif
				break
			case HARDWARE_NI_DAC:
				for(i = 0;i < numEntries; i += 1)
					WAVE NIChannel = NIDataWave[i]
					Multithread NIChannel[0, TPLength - 1] = \
					limit(                                   \
					(DAGain[i] * DAScale[i]) * testPulse[p], \
					NI_DAC_MIN,                              \
					NI_DAC_MAX); AbortOnRTE
				endfor
				break
		endswitch
	elseif(dataAcqOrTP == DATA_ACQUISITION_MODE)
		for(i = 0; i < numEntries; i += 1)
			if(config[i][%DAQChannelType] == DAQ_CHANNEL_TYPE_TP)
				// TP wave does not need to be decimated, it has already correct size reg. sample rate
				WAVE testPulse = stimSet[i]
				TPLength = setLength[i]
				ASSERT(DimSize(testPulse, COLS) <= 1, "Expected a 1D testpulse wave")
				switch(hardwareType)
					case HARDWARE_ITC_DAC:
						Multithread ITCDataWave[][i] =   	                    \
						limit(                                                  \
						(DAGain[i] * DAScale[i]) * testPulse[mod(p, TPLength)], \
						SIGNED_INT_16BIT_MIN,                                   \
						SIGNED_INT_16BIT_MAX); AbortOnRTE
						cutOff = mod(DimSize(ITCDataWave, ROWS), TPLength)
						if(cutOff > 0)
							ITCDataWave[DimSize(ITCDataWave, ROWS) - cutOff, *][i] = 0
						endif
						break
					case HARDWARE_NI_DAC:
						WAVE NIChannel = NIDataWave[i]
						Multithread NIChannel[] = 				                \
						limit(                                        			\
						(DAGain[i] * DAScale[i]) * testPulse[mod(p, TPLength)], \
						NI_DAC_MIN,                                  	        \
						NI_DAC_MAX); AbortOnRTE
						cutOff = mod(DimSize(NIChannel, ROWS), TPLength)
						if(cutOff > 0)
							NIChannel[DimSize(NIChannel, ROWS) - cutOff, *] = 0
						endif
						break
				endswitch
			elseif(config[i][%DAQChannelType] == DAQ_CHANNEL_TYPE_DAQ)
				WAVE singleStimSet = stimSet[i]
				singleSetLength = setLength[i]
				switch(hardwareType)
					case HARDWARE_ITC_DAC:
						Multithread ITCDataWave[insertStart[i], insertStart[i] + singleSetLength - 1][i] =               \
						limit(                                                                                           \
						(DAGain[i] * DAScale[i]) * singleStimSet[decimationFactor * (p - insertStart[i])][setColumn[i]], \
						SIGNED_INT_16BIT_MIN,                                                                            \
						SIGNED_INT_16BIT_MAX); AbortOnRTE

						if(globalTPInsert)
							// space in ITCDataWave for the testpulse is allocated via an automatic increase
							// of the onset delay
							ITCDataWave[baselineFrac * testPulseLength, (1 - baselineFrac) * testPulseLength][i] = \
							limit(testPulseAmplitude[i] * DAGain[i], SIGNED_INT_16BIT_MIN, SIGNED_INT_16BIT_MAX); AbortOnRTE
						endif
						break
					case HARDWARE_NI_DAC:
						// for an index step of 1 in NIChannel, singleStimSet steps decimationFactor
						// for an index step of 1 in singleStimset, NIChannel steps 1 / decimationFactor
						// for decimationFactor < 1 and indexing NIChannel to DimSize(NIChannel, ROWS) - 1 (as implemented here),
						// singleStimset would be indexed to DimSize(singleStimSet, ROWS) - decimationFactor
						// this leads to an invalid index if decimationFactor is <= 0.5 (due to the way Igor handles nD wave indexing)
						// it is solved here by limiting the index of singleStimSet to the last valid integer index
						// for the case of decimationFactor >= 1 there is no issue since index DimSize(singleStimSet, ROWS) - decimationFactor is valid
						// for ITC decimationFactor is always >= 1 since the stimSets are generated for the ITC max. sample rate
						WAVE NIChannel = NIDataWave[i]
						lastValidRow = DimSize(singleStimSet, ROWS) - 1
						MultiThread NIChannel[insertStart[i], insertStart[i] + singleSetLength - 1] =                                          \
						limit(                                                                                                                 \
						DAGain[i] * DAScale[i] * singleStimSet[limit(decimationFactor * (p - insertStart[i]), 0, lastValidRow)][setColumn[i]], \
						NI_DAC_MIN,                                                                                                            \
						NI_DAC_MAX); AbortOnRTE

						if(globalTPInsert)
							// space in ITCDataWave for the testpulse is allocated via an automatic increase
							// of the onset delay
							NIChannel[baselineFrac * testPulseLength, (1 - baselineFrac) * testPulseLength] = \
							limit(testPulseAmplitude[i] * DAGain[i], NI_DAC_MIN, NI_DAC_MAX); AbortOnRTE
						endif
						break
				endswitch
			else
				ASSERT(0, "Unknown DAC channel type")
			endif
		endfor
	endif

	if(!WaveExists(offsets))
		Make/FREE/N=(numEntries) offsets = 0
	else
		offsets[] *= WAVEBUILDER_MIN_SAMPINT
	endif

	if(!WaveExists(regions))
		Make/FREE/T/N=(numEntries) regions
	endif

	for(i = 0; i < numEntries; i += 1)
		DC_DocumentChannelProperty(panelTitle, "Stim set length", headstageDAC[i], DAC[i], var=setLength[i])
		DC_DocumentChannelProperty(panelTitle, "Delay onset oodDAQ", headstageDAC[i], DAC[i], var=offsets[i])
		DC_DocumentChannelProperty(panelTitle, "oodDAQ regions", headstageDAC[i], DAC[i], str=regions[i])
	endfor

	DC_DocumentChannelProperty(panelTitle, "Sampling interval multiplier", INDEP_HEADSTAGE, NaN, var=str2num(DAG_GetTextualValue(panelTitle, "Popup_Settings_SampIntMult")))
	DC_DocumentChannelProperty(panelTitle, "Fixed frequency acquisition", INDEP_HEADSTAGE, NaN, var=str2numSafe(DAG_GetTextualValue(panelTitle, "Popup_Settings_FixedFreq")))
	DC_DocumentChannelProperty(panelTitle, "Sampling interval", INDEP_HEADSTAGE, NaN, var=samplingInterval * 1e-3)

	DC_DocumentChannelProperty(panelTitle, "Delay onset user", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "setvar_DataAcq_OnsetDelayUser"))
	DC_DocumentChannelProperty(panelTitle, "Delay onset auto", INDEP_HEADSTAGE, NaN, var=GetValDisplayAsNum(panelTitle, "valdisp_DataAcq_OnsetDelayAuto"))
	DC_DocumentChannelProperty(panelTitle, "Delay termination", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "setvar_DataAcq_TerminationDelay"))
	DC_DocumentChannelProperty(panelTitle, "Delay distributed DAQ", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "setvar_DataAcq_dDAQDelay"))
	DC_DocumentChannelProperty(panelTitle, "oodDAQ Pre Feature", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Setvar_DataAcq_dDAQOptOvPre"))
	DC_DocumentChannelProperty(panelTitle, "oodDAQ Post Feature", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Setvar_DataAcq_dDAQOptOvPost"))
	DC_DocumentChannelProperty(panelTitle, "oodDAQ Resolution", INDEP_HEADSTAGE, NaN, var=WAVEBUILDER_MIN_SAMPINT)

	DC_DocumentChannelProperty(panelTitle, "TP Insert Checkbox", INDEP_HEADSTAGE, NaN, var=GlobalTPInsert)
	DC_DocumentChannelProperty(panelTitle, "Distributed DAQ", INDEP_HEADSTAGE, NaN, var=distributedDAQ)
	DC_DocumentChannelProperty(panelTitle, "Optimized Overlap dDAQ", INDEP_HEADSTAGE, NaN, var=distributedDAQOptOv)
	DC_DocumentChannelProperty(panelTitle, "Repeat Sets", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "SetVar_DataAcq_SetRepeats"))
	DC_DocumentChannelProperty(panelTitle, "Scaling zero", INDEP_HEADSTAGE, NaN, var=scalingZero)
	DC_DocumentChannelProperty(panelTitle, "Indexing", INDEP_HEADSTAGE, NaN, var=indexing)
	DC_DocumentChannelProperty(panelTitle, "Locked indexing", INDEP_HEADSTAGE, NaN, var=indexingLocked)
	DC_DocumentChannelProperty(panelTitle, "Repeated Acquisition", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_RepeatAcq"))
	DC_DocumentChannelProperty(panelTitle, "Random Repeated Acquisition", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "check_DataAcq_RepAcqRandom"))
	DC_DocumentChannelProperty(panelTitle, "Multi Device mode", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "check_Settings_MD"))
	DC_DocumentChannelProperty(panelTitle, "Background Testpulse", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Check_Settings_BkgTP"))
	DC_DocumentChannelProperty(panelTitle, "Background DAQ", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Check_Settings_BackgrndDataAcq"))
	DC_DocumentChannelProperty(panelTitle, "TP buffer size", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "setvar_Settings_TPBuffer"))
	DC_DocumentChannelProperty(panelTitle, "TP during ITI", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "check_Settings_ITITP"))
	DC_DocumentChannelProperty(panelTitle, "Amplifier change via I=0", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "check_Settings_AmpIEQZstep"))
	DC_DocumentChannelProperty(panelTitle, "Skip analysis functions", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Check_Settings_SkipAnalysFuncs"))
	DC_DocumentChannelProperty(panelTitle, "Repeat sweep on async alarm", INDEP_HEADSTAGE, NaN, var=DAG_GetNumericalValue(panelTitle, "Check_Settings_AlarmAutoRepeat"))
	DC_DocumentHardwareProperties(panelTitle, hardwareType)

	if(DeviceCanLead(panelTitle))
		SVAR listOfFollowerDevices = $GetFollowerList(panelTitle)
		DC_DocumentChannelProperty(panelTitle, "Follower Device", INDEP_HEADSTAGE, NaN, str=listOfFollowerDevices)
	endif

	DC_DocumentChannelProperty(panelTitle, "MIES version", INDEP_HEADSTAGE, NaN, str=GetMIESVersionAsString())
	DC_DocumentChannelProperty(panelTitle, "Igor Pro version", INDEP_HEADSTAGE, NaN, str=GetIgorProVersion())
	DC_DocumentChannelProperty(panelTitle, "Igor Pro bitness", INDEP_HEADSTAGE, NaN, var=GetArchitectureBits())

	for(i = 0; i < NUM_HEADSTAGES; i += 1)

		DC_DocumentChannelProperty(panelTitle, "Headstage Active", i, NaN, var=statusHS[i])

		if(!statusHS[i])
			continue
		endif

		DC_DocumentChannelProperty(panelTitle, "Clamp Mode", i, NaN, var=DAG_GetHeadstageMode(panelTitle, i))
	endfor

	if(distributedDAQ)
		// dDAQ requires that all stimsets have the same length, so store the stim set length
		// also headstage independent
		ASSERT(!distributedDAQOptOv, "Unexpected oodDAQ mode")
		ASSERT(WaveMin(setLength) == WaveMax(setLength), "Unexpected varying stim set length")
		DC_DocumentChannelProperty(panelTitle, "Stim set length", INDEP_HEADSTAGE, NaN, var=setLength[0])
	endif

	WAVE statusAD = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_ADC)

	numEntries = DimSize(statusAD, ROWS)
	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, dataAcqOrTP, CHANNEL_TYPE_ADC, i, statusAD, statusHS))
			continue
		endif

		headstage = AFH_GetHeadstageFromADC(panelTitle, i)

		DC_DocumentChannelProperty(panelTitle, "ADC", headstage, i, var=i)

		ctrl = GetSpecialControlLabel(CHANNEL_TYPE_ADC, CHANNEL_CONTROL_GAIN)
		DC_DocumentChannelProperty(panelTitle, "AD Gain", headstage, i, var=DAG_GetNumericalValue(panelTitle, ctrl, index = i))

		ctrl = GetSpecialControlLabel(CHANNEL_TYPE_ADC, CHANNEL_CONTROL_UNIT)
		DC_DocumentChannelProperty(panelTitle, "AD Unit", headstage, i, str=DAG_GetTextualValue(panelTitle, ctrl, index = i))

		DC_DocumentChannelProperty(panelTitle, "AD ChannelType", headstage, i, var = config[activeColumn][%DAQChannelType])

		activeColumn += 1
	endfor

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)
		// reset to the default value without distributedDAQ
		singleInsertStart = onSetDelay
		switch(hardwareType)
			case HARDWARE_NI_DAC:
				WAVE/WAVE TTLWaveNI = GetTTLWave(panelTitle)
				DC_MakeNITTLWave(panelTitle)
				for(i = 0; i < DimSize(config, ROWS); i += 1)
					if(config[i][%ChannelType] == ITC_XOP_CHANNEL_TYPE_TTL)
						WAVE NIChannel = NIDataWave[activeColumn]
						WAVE TTLWaveSingle = TTLWaveNI[config[i][%ChannelNumber]]
						singleSetLength = DC_CalculateStimsetLength(TTLWaveSingle, panelTitle, DATA_ACQUISITION_MODE)
						MultiThread NIChannel[singleInsertStart, singleInsertStart + singleSetLength - 1] = \
						limit(TTLWaveSingle[trunc(decimationFactor * (p - singleInsertStart))], 0, 1); AbortOnRTE
						activeColumn += 1
					endif
				endfor
				break
			case HARDWARE_ITC_DAC:
				WAVE TTLWaveITC = GetTTLWave(panelTitle)
				// Place TTL waves into ITCDataWave
				if(DC_AreTTLsInRackChecked(RACK_ZERO, panelTitle))
					DC_MakeITCTTLWave(panelTitle, RACK_ZERO)
					singleSetLength = DC_CalculateStimsetLength(TTLWaveITC, panelTitle, DATA_ACQUISITION_MODE)
					MultiThread ITCDataWave[singleInsertStart, singleInsertStart + singleSetLength - 1][activeColumn] = \
					limit(TTLWaveITC[trunc(decimationFactor * (p - singleInsertStart))], SIGNED_INT_16BIT_MIN, SIGNED_INT_16BIT_MAX); AbortOnRTE
					activeColumn += 1
				endif

				if(DC_AreTTLsInRackChecked(RACK_ONE, panelTitle))
					DC_MakeITCTTLWave(panelTitle, RACK_ONE)
					singleSetLength = DC_CalculateStimsetLength(TTLWaveITC, panelTitle, DATA_ACQUISITION_MODE)
					MultiThread ITCDataWave[singleInsertStart, singleInsertStart + singleSetLength - 1][activeColumn] = \
					limit(TTLWaveITC[trunc(decimationFactor * (p - singleInsertStart))], SIGNED_INT_16BIT_MIN, SIGNED_INT_16BIT_MAX); AbortOnRTE
				endif
				break
		endswitch
	endif

	if(DC_CheckIfDataWaveHasBorderVals(panelTitle))
		printf "Error writing stimsets into DataWave: The values are out of range. Maybe the DA/AD Gain needs adjustment?\r"
		ControlWindowToFront()
		Abort
	endif
End

/// @brief Document hardware type/name/serial number into the labnotebook
static Function DC_DocumentHardwareProperties(panelTitle, hardwareType)
	string panelTitle
	variable hardwareType

	string str

	DC_DocumentChannelProperty(panelTitle, "Digitizer Hardware Type", INDEP_HEADSTAGE, NaN, var=hardwareType)

	NVAR ITCDeviceIDGlobal = $GetITCDeviceIDGlobal(panelTitle)
	WAVE devInfo = HW_GetDeviceInfo(hardwareType, ITCDeviceIDGlobal)

	switch(hardwareType)
		case HARDWARE_ITC_DAC:
			DC_DocumentChannelProperty(panelTitle, "Digitizer Hardware Name", INDEP_HEADSTAGE, NaN, str=StringFromList(devInfo[%DeviceType], DEVICE_TYPES_ITC))
			sprintf str, "Master:%#0X,Secondary:%#0X,Host:%#0X", devInfo[%MasterSerialNumber], devInfo[%SecondarySerialNumber], devInfo[%HostSerialNumber]
			DC_DocumentChannelProperty(panelTitle, "Digitizer Serial Numbers", INDEP_HEADSTAGE, NaN, str=str)
			break
		case HARDWARE_NI_DAC:
			WAVE/T devInfoText = devInfo
			sprintf str, "%s %s (%#0X)", devInfoText[%DeviceCategoryStr], devInfoText[%ProductType], str2num(devInfoText[%ProductNumber])
			DC_DocumentChannelProperty(panelTitle, "Digitizer Hardware Name", INDEP_HEADSTAGE, NaN, str=str)
			sprintf str, "%#0X", str2num(devInfoText[%DeviceSerialNumber])
			DC_DocumentChannelProperty(panelTitle, "Digitizer Serial Numbers", INDEP_HEADSTAGE, NaN, str=str)
			break
		default:
			ASSERT(0, "Unknown hardware")
	endswitch
End

/// @brief Return the stimset acquisition cycle ID
///
/// @param panelTitle  device
/// @param fingerprint fingerprint as returned by DC_GenerateStimsetFingerprint()
/// @param DAC         DA channel
static Function DC_GetStimsetAcqCycleID(panelTitle, fingerprint, DAC)
	string panelTitle
	variable fingerprint, DAC

	WAVE stimsetAcqIDHelper = GetStimsetAcqIDHelperWave(panelTitle)

	if(!IsFinite(fingerprint))
		return NaN
	endif

	if(fingerprint == stimsetAcqIDHelper[DAC][%fingerprint])
		return stimsetAcqIDHelper[DAC][%id]
	endif

	stimsetAcqIDHelper[DAC][%fingerprint] = fingerprint
	stimsetAcqIDHelper[DAC][%id] = GetNextRandomNumberForDevice(panelTitle)

	return stimsetAcqIDHelper[DAC][%id]
End

/// @brief Generate the stimset fingerprint
///
/// This fingerprint is unique for the combination of the following properties:
/// - Repeated acquisition cycle ID
/// - stimset name
/// - stimset checksum
/// - set cycle count
///
/// Always then this fingerprint changes, a new stimset acquisition cycle ID has
/// to be generated.
///
/// Returns NaN for the testpulse.
static Function DC_GenerateStimsetFingerprint(raCycleID, setName, setCycleCount, setChecksum, dataAcqOrTP)
	variable raCycleID
	string setName
	variable setChecksum, setCycleCount, dataAcqOrTP

	variable crc

	if(dataAcqOrTP == TEST_PULSE_MODE)
		return NaN
	endif

	ASSERT(IsInteger(raCycleID) && raCycleID > 0, "Invalid raCycleID")
	ASSERT(IsInteger(setCycleCount), "Invalid setCycleCount")
	ASSERT(IsInteger(setChecksum) && setChecksum > 0, "Invalid stimset checksum")
	ASSERT(!IsEmpty(setName) && !cmpstr(setName, trimstring(setName)) , "Invalid setName")

	crc = StringCRC(crc, num2str(raCycleID))
	crc = StringCRC(crc, num2str(setCycleCount))
	crc = StringCRC(crc, num2str(setChecksum))
	crc = StringCRC(crc, setName)

	return crc
End

static Function DC_CheckIfDataWaveHasBorderVals(panelTitle)
	string panelTitle

	variable hardwareType = GetHardwareType(panelTitle)
	switch(hardwareType)
		case HARDWARE_ITC_DAC:
			WAVE/Z ITCDataWave = GetHardwareDataWave(panelTitle)
			ASSERT(WaveExists(ITCDataWave), "Missing HardwareDataWave")
			ASSERT(WaveType(ITCDataWave) == IGOR_TYPE_16BIT_INT, "Unexpected wave type: " + num2str(WaveType(ITCDataWave)))

#if (IgorVersion() >= 8.00)
			FindValue/UOFV/I=(SIGNED_INT_16BIT_MIN) ITCDataWave

			if(V_Value != -1)
				return 1
			endif

			FindValue/UOFV/I=(SIGNED_INT_16BIT_MAX) ITCDataWave

			if(V_Value != -1)
				return 1
			endif

			return 0
#else
			matrixop/FREE result = equal(minval(ITCDataWave), SIGNED_INT_16BIT_MIN) || equal(maxval(ITCDataWave), SIGNED_INT_16BIT_MAX)

			return result[0] > 0
#endif
			break
		case HARDWARE_NI_DAC:
			WAVE/WAVE NIDataWave = GetHardwareDataWave(panelTitle)
			ASSERT(IsWaveRefWave(NIDataWave), "Unexpected wave type")
			variable channels = numpnts(NIDataWave)
			variable i
			for(i = 0; i < channels; i += 1)
				WAVE NIChannel = NIDataWave[i]
#if (IgorVersion() >= 8.00)
			FindValue/UOFV/V=(NI_DAC_MIN)/T=1E-6 NIChannel

			if(V_Value != -1)
				return 1
			endif

			FindValue/UOFV/V=(NI_DAC_MAX)/T=1E-6 NIChannel

			if(V_Value != -1)
				return 1
			endif

			return 0
#else
			// note: equal should work in the 10 V range ?!?
			matrixop/FREE result = equal(minval(NIChannel), NI_DAC_MIN) || equal(maxval(NIChannel), NI_DAC_MAX)

			return result[0] > 0
#endif
	endfor
			break
	endswitch
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
	ua_entry = CreateLBNUnassocKey(entry, channelNumber)

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
			sweepDataLNB[][numCols][] = NaN
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

/// @brief Combines the TTL stimulus sweeps across different TTL channels into a single wave
///
/// @param panelTitle  panel title
/// @param rackNo      Front TTL rack aka number of ITC devices. Only the ITC1600
///                    has two racks, see @ref RackConstants. Rack number for all other devices is
///                    #RACK_ZERO.
static Function DC_MakeITCTTLWave(panelTitle, rackNo)
	string panelTitle
	variable rackNo

	variable first, last, i, col, maxRows, lastIdx, bit, bits
	string set
	string listOfSets = ""
	string setSweepCounts = ""

	WAVE statusTTL = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_TTL)
	WAVE statusHS = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_HEADSTAGE)

	WAVE/T allSetNames = DAG_GetChannelTextual(panelTitle, CHANNEL_TYPE_TTL, CHANNEL_CONTROL_WAVE)

	WAVE sweepDataLNB      = GetSweepSettingsWave(panelTitle)
	WAVE/T sweepDataTxTLNB = GetSweepSettingsTextWave(panelTitle)

	HW_ITC_GetRackRange(rackNo, first, last)

	for(i = first; i <= last; i += 1)

		if(!DC_ChannelIsActive(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL, i, statusTTL, statusHS))
			listOfSets = AddListItem("", listOfSets, ";", inf)
			continue
		endif

		set = allSetNames[i]
		WAVE wv = WB_CreateAndGetStimSet(set)
		maxRows = max(maxRows, DimSize(wv, ROWS))
		bits += 2^(i - first)
		listOfSets = AddListItem(set, listOfSets, ";", inf)
	endfor

	ASSERT(maxRows > 0, "Expected stim set of non-zero size")
	WAVE TTLWave = GetTTLWave(panelTitle)
	Redimension/N=(maxRows) TTLWave
	FastOp TTLWave = 0

	for(i = first; i <= last; i += 1)

		if(!DC_ChannelIsActive(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL, i, statusTTL, statusHS))
			setSweepCounts = AddListItem("", setSweepCounts, ";", inf)
			continue
		endif

		set = allSetNames[i]
		WAVE TTLStimSet = WB_CreateAndGetStimSet(set)
		col = DC_CalculateChannelColumnNo(panelTitle, set, i, CHANNEL_TYPE_TTL)
		lastIdx = DimSize(TTLStimSet, ROWS) - 1
		bit = 2^(i - first)
		MultiThread TTLWave[0, lastIdx] += bit * TTLStimSet[p][col]
		setSweepCounts = AddListItem(num2str(col), setSweepCounts, ";", inf)
	endfor

	if(rackNo == RACK_ZERO)
		sweepDataLNB[0][%$"TTL rack zero bits"][INDEP_HEADSTAGE]                = bits
		sweepDataTxTLNB[0][%$"TTL rack zero stim sets"][INDEP_HEADSTAGE]        = listOfSets
		sweepDataTxTLNB[0][%$"TTL rack zero set sweep counts"][INDEP_HEADSTAGE] = setSweepCounts
	else
		sweepDataLNB[0][%$"TTL rack one bits"][INDEP_HEADSTAGE]                = bits
		sweepDataTxTLNB[0][%$"TTL rack one stim sets"][INDEP_HEADSTAGE]        = listOfSets
		sweepDataTxTLNB[0][%$"TTL rack one set sweep counts"][INDEP_HEADSTAGE] = setSweepCounts
	endif
End

static Function DC_MakeNITTLWave(panelTitle)
	string panelTitle

	variable col, i
	string set
	string listOfSets = ""
	string setSweepCounts = ""
	string channels = ""

	WAVE statusTTL = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_TTL)
	WAVE statusHS = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_HEADSTAGE)
	WAVE/T allSetNames = DAG_GetChannelTextual(panelTitle, CHANNEL_TYPE_TTL, CHANNEL_CONTROL_WAVE)
	WAVE/WAVE TTLWave = GetTTLWave(panelTitle)

	WAVE/T sweepDataTxTLNB = GetSweepSettingsTextWave(panelTitle)

	for(i = 0; i < NUM_DA_TTL_CHANNELS; i += 1)

		if(!DC_ChannelIsActive(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL, i, statusTTL, statusHS))
			listOfSets = AddListItem("", listOfSets, ";", inf)
			setSweepCounts = AddListItem("", setSweepCounts, ";", inf)
			channels = AddListItem("", channels, ";", inf)
			continue
		endif

		set = allSetNames[i]
		WAVE TTLStimSet = WB_CreateAndGetStimSet(set)
		col = DC_CalculateChannelColumnNo(panelTitle, set, i, CHANNEL_TYPE_TTL)

		listOfSets = AddListItem(set, listOfSets, ";", inf)
		setSweepCounts = AddListItem(num2str(col), setSweepCounts, ";", inf)
		channels = AddListItem(num2str(i), channels, ";", inf)

		Make/FREE/B/U/N=(DimSize(TTLStimSet, ROWS)) TTLWaveSingle
		MultiThread TTLWaveSingle[] = TTLStimSet[p][col]
		TTLWave[i] = TTLWaveSingle
	endfor

	sweepDataTxTLNB[0][%$"TTL channels"][INDEP_HEADSTAGE]         = channels
	sweepDataTxTLNB[0][%$"TTL stim sets"][INDEP_HEADSTAGE]        = listOfSets
	sweepDataTxTLNB[0][%$"TTL set sweep counts"][INDEP_HEADSTAGE] = setSweepCounts
End

/// @brief Returns column number/step of the stimulus set, independent of the times the set is being cycled through
///        (as defined by SetVar_DataAcq_SetRepeats)
///
/// @param panelTitle    panel title
/// @param SetName       name of the stimulus set
/// @param channelNo     channel number
/// @param channelType   channel type, one of @ref CHANNEL_TYPE_DAC or @ref CHANNEL_TYPE_TTL
///
/// @return complex number with real part equals the stimset column and the
///         imaginary part the set cycle count
static Function/C DC_CalculateChannelColumnNo(panelTitle, SetName, channelNo, channelType)
	string panelTitle, SetName
	variable ChannelNo, channelType

	variable ColumnsInSet = IDX_NumberOfSweepsInSet(SetName)
	variable column
	variable setCycleCount
	variable localCount, repAcqRandom
	string sequenceWaveName
	variable skipAhead = DAP_GetskipAhead(panelTitle)

	repAcqRandom = DAG_GetNumericalValue(panelTitle, "check_DataAcq_RepAcqRandom")

	DFREF devicePath = GetDevicePath(panelTitle)

	// wave exists only if random set sequence is selected
	sequenceWaveName = SetName + num2str(channelType) + num2str(channelNo) + "_S"
	WAVE/Z/SDFR=devicePath WorkingSequenceWave = $sequenceWaveName
	NVAR count = $GetCount(panelTitle)
	// Below code calculates the variable local count which is then used to determine what column to select from a particular set
	if(!RA_IsFirstSweep(panelTitle))
		//thus the vairable "count" is used to determine if acquisition is on the first cycle
		if(!DAG_GetNumericalValue(panelTitle, "Check_DataAcq_Indexing"))
			localCount = count
		else // The local count is now set length dependent
			// check locked status. locked = popup menus on channels idex in lock - step
			if(DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_IndexingLocked"))
				/// @todo this code here is different compared to what RA_BckgTPwithCallToRACounterMD and RA_CounterMD do
				NVAR activeSetCount = $GetActiveSetCount(panelTitle)
				ASSERT(IsFinite(activeSetCount), "activeSetCount has to be finite")
				localCount = IDX_CalculcateActiveSetCount(panelTitle) - activeSetCount
			else
				// calculate where in list global count is
				localCount = IDX_UnlockedIndexingStepNo(panelTitle, channelNo, channelType, count)
			endif
		endif

		setCycleCount = trunc(localCount / ColumnsInSet)

		//Below code uses local count to determine  what step to use from the set based on the sweeps in cycle and sweeps in active set
		if(setCycleCount == 0)
			if(!repAcqRandom)
				column = localCount
			else
				if(localCount == 0)
					InPlaceRandomShuffle(WorkingSequenceWave)
				endif
				column = WorkingSequenceWave[localcount]
			endif
		else
			if(!repAcqRandom)
				column = mod((localCount), columnsInSet) // set has been cyled through once or more, uses remainder to determine correct column
			else
				if(mod((localCount), columnsInSet) == 0)
					InPlaceRandomShuffle(WorkingSequenceWave) // added to handle 1 channel, unlocked indexing
				endif
				column = WorkingSequenceWave[mod((localCount), columnsInSet)]
			endif
		endif
	else // first sweep
		if(!repAcqRandom)
			count += skipAhead
			column = count
			DAP_ResetSkipAhead(panelTitle)
			RA_StepSweepsRemaining(panelTitle)
		else
			Make/O/N=(ColumnsInSet) devicePath:$SequenceWaveName/Wave=WorkingSequenceWave = x
			InPlaceRandomShuffle(WorkingSequenceWave)
			column = WorkingSequenceWave[0]
		endif
	endif

	ASSERT(IsFinite(column), "column has to be finite")

	return cmplx(column, setCycleCount)
End

/// @brief Returns the length increase of the ITCDataWave following onset/termination delay insertion and
/// distributed data aquisition. Does not incorporate adaptations for oodDAQ.
///
/// All returned values are in number of points, *not* in time.
///
/// @param[in] panelTitle                      panel title
/// @param[out] onsetDelayUser [optional]      onset delay set by the user
/// @param[out] onsetDelayAuto [optional]      onset delay required by other settings
/// @param[out] terminationDelay [optional]    termination delay
/// @param[out] distributedDAQDelay [optional] distributed DAQ delay
static Function DC_ReturnTotalLengthIncrease(panelTitle, [onsetDelayUser, onsetDelayAuto, terminationDelay, distributedDAQDelay])
	string panelTitle
	variable &onsetDelayUser, &onsetDelayAuto, &terminationDelay, &distributedDAQDelay

	variable samplingInterval, onsetDelayUserVal, onsetDelayAutoVal, terminationDelayVal, distributedDAQDelayVal, numActiveDACs
	variable distributedDAQ

	numActiveDACs          = DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_DAC)
	samplingInterval       = DAP_GetSampInt(panelTitle, DATA_ACQUISITION_MODE)
	distributedDAQ         = DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_DistribDaq")
	onsetDelayUserVal      = round(DAG_GetNumericalValue(panelTitle, "setvar_DataAcq_OnsetDelayUser") / (samplingInterval / 1000))
	onsetDelayAutoVal      = round(GetValDisplayAsNum(panelTitle, "valdisp_DataAcq_OnsetDelayAuto") / (samplingInterval / 1000))
	terminationDelayVal    = round(DAG_GetNumericalValue(panelTitle, "setvar_DataAcq_TerminationDelay") / (samplingInterval / 1000))
	distributedDAQDelayVal = round(DAG_GetNumericalValue(panelTitle, "setvar_DataAcq_dDAQDelay") / (samplingInterval / 1000))

	if(!ParamIsDefault(onsetDelayUser))
		onsetDelayUser = onsetDelayUserVal
	endif

	if(!ParamIsDefault(onsetDelayAuto))
		onsetDelayAuto = onsetDelayAutoVal
	endif

	if(!ParamIsDefault(terminationDelay))
		terminationDelay = terminationDelayVal
	endif

	if(!ParamIsDefault(distributedDAQDelay))
		distributedDAQDelay = distributedDAQDelayVal
	endif

	if(distributedDAQ)
		ASSERT(numActiveDACs > 0, "Number of DACs must be at least one")
		return onsetDelayUserVal + onsetDelayAutoVal + terminationDelayVal + distributedDAQDelayVal * (numActiveDACs - 1)
	else
		return onsetDelayUserVal + onsetDelayAutoVal + terminationDelayVal
	endif
End

/// @brief Calculate the stop collection point, includes all required global adjustments
static Function DC_GetStopCollectionPoint(panelTitle, dataAcqOrTP, setLengths)
	string panelTitle
	variable dataAcqOrTP
	WAVE setLengths

	variable DAClength, TTLlength, totalIncrease
	DAClength = DC_CalculateLongestSweep(panelTitle, dataAcqOrTP, CHANNEL_TYPE_DAC)

	if(dataAcqOrTP == DATA_ACQUISITION_MODE)

		// find out if we have only TP channels
		WAVE config = GetITCChanConfigWave(panelTitle)
		WAVE DACmode = GetDACTypesFromConfig(config)

		FindValue/I=(DAQ_CHANNEL_TYPE_DAQ) DACmode

		if(V_Value == -1)
			return TIME_TP_ONLY_ON_DAQ * 1E6 / DAP_GetSampInt(panelTitle, dataAcqOrTP)
		else
			totalIncrease = DC_ReturnTotalLengthIncrease(panelTitle)
			TTLlength     = DC_CalculateLongestSweep(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_TTL)

			if(DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_dDAQOptOv"))
				DAClength = WaveMax(setLengths)
			elseif(DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_DistribDaq"))
				DAClength *= DC_NoOfChannelsSelected(panelTitle, CHANNEL_TYPE_DAC)
			endif

			return max(DAClength, TTLlength) + totalIncrease
		endif
	elseif(dataAcqOrTP == TEST_PULSE_MODE)
		return DAClength
	endif

	ASSERT(0, "unknown mode")
End

/// @brief Returns 1 if a channel is set to TP, the check is through the
/// stimset name from the GUI
Function DC_GotTPChannelWhileDAQ(panelTitle)
	string panelTitle

	variable i, numEntries
	WAVE statusHS = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_HEADSTAGE)
	WAVE statusDA = DAG_GetChannelState(panelTitle, CHANNEL_TYPE_DAC)
	WAVE/T allSetNames = DAG_GetChannelTextual(panelTitle, CHANNEL_TYPE_DAC, CHANNEL_CONTROL_WAVE)
	numEntries = DimSize(statusDA, ROWS)

	for(i = 0; i < numEntries; i += 1)

		if(!DC_ChannelIsActive(panelTitle, DATA_ACQUISITION_MODE, CHANNEL_TYPE_DAC, i, statusDA, statusHS))
			continue
		endif

		if(!CmpStr(allSetNames[i], STIMSET_TP_WHILE_DAQ))
			return 1
		endif

	endfor

	return 0
End

/// @brief Get the channel type of given headstage
///
/// @param panelTitle panel title
/// @param headstage head stage
///
/// @return One of @ref DaqChannelTypeConstants
Function DC_GetChannelTypefromHS(panelTitle, headstage)
	string panelTitle
	variable headstage

	variable dac, row
	WAVE config = GetITCChanConfigWave(panelTitle)

	dac = AFH_GetDACFromHeadstage(panelTitle, headstage)
	row = AFH_GetITCDataColumn(config, dac, ITC_XOP_CHANNEL_TYPE_DAC)
	ASSERT(IsFinite(row), "Invalid column")
	return config[row][%DAQChannelType]
End
