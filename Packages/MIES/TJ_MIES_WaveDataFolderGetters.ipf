#pragma rtGlobals=3

/// @brief Return a wave reference to the channel <-> amplifier relation wave (numeric part)
///
/// Rows:
/// - 0-3: V-Clamp: DA channel number of amp (0 or 1), DA gain, AD channel, AD gain
/// - 4-7: I-Clamp: DA channel number of amp (0 or 1), DA gain, AD channel, AD gain
/// - 8: Amplifier Serial number as returned by `AxonTelegraphFindServers`. This differs
///      compared to the ones returned by `MCC_FindServers`, as the latter are strings with leading zeros.
///      E.g.: "00000123" vs 123
///      E.g.: "Demo"     vs 0
/// - 9: Amplifier Channel ID
/// - 10: Index into popup_Settings_Amplifier in the DA_Ephys panel
/// - 11: Unused
///
/// Columns:
/// - Head stage number
///
Function/Wave GetChanAmpAssign(panelTitle)
	string panelTitle

	DFREF dfr = GetDevicePath(panelTitle)

	Wave/Z/SDFR=dfr wv = ChanAmpAssign

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(12, NUM_HEADSTAGES) dfr:ChanAmpAssign/Wave=wv
	wv = NaN

	return wv
End

/// @brief Return a wave reference to the channel <-> amplifier relation wave (textual part)
///
/// Rows:
/// - 0: DA unit (V-Clamp mode)
/// - 1: AD unit (V-Clamp mode)
/// - 3: DA unit (I-Clamp mode)
/// - 4: AD unit (I-Clamp mode)
///
/// Columns:
/// - Head stage number
///
Function/Wave GetChanAmpAssignUnit(panelTitle)
	string panelTitle

	DFREF dfr = GetDevicePath(panelTitle)

	Wave/T/Z/SDFR=dfr wv = ChanAmpAssignUnit

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(4, NUM_HEADSTAGES) dfr:ChanAmpAssignUnit/Wave=wv
	wv = ""

	return wv
End

/// @name Wave versioning support
///
/// The wave getter functions always return an existing wave.
/// This can result in problems if the layout of the wave changes.
///
/// Layout in this context means:
/// - Sizes of all dimensions
/// - Labels of all dimensions
/// - Wave data type
///
/// In order to enable smooth upgrades between old and new wave layouts the following
/// code pattern can be used:
/// @code
/// Function/Wave GetMyWave(panelTitle)
/// 	string panelTitle
///
/// 	DFREF dfr = GetMyPath(panelTitle)
/// 	variable versionOfNewWave = 1
///
/// 	Wave/Z/SDFR=dfr wv = myWave
///
/// 	if(ExistsWithCorrectLayoutVersion(wv, versionOfNewWave))
/// 		return wv
/// 	endif
///
/// 	Make/O/N=(1,2) dfr:myWave/Wave=wv
/// 	SetWaveVersion(wv, versionOfNewWave)
///
/// 	return wv
/// End
/// @endcode
///
/// Now everytime the layout of `myWave` changes, you just raise `versionOfNewWave` by 1.
/// When `GetMyWave` is called the first time, the wave is recreated, and on successive calls
/// the newly recreated wave is just returned.
///
/// Some Hints:
/// - Wave layout versioning is *mandatory* if you change the layout of the wave
/// - Wave layout versions start with 1 and are integers
/// - Rule of thumb: Raise the version if you change anything in or below the `Make` line above
/// - Wave versioning needs a special wave note style, see @ref GetNumberFromWaveNote
/// @{
static StrConstant WAVE_NOTE_LAYOUT_KEY = "WAVE_LAYOUT_VERSION"

/// @brief Check if wv exists and has the correct version
static Function ExistsWithCorrectLayoutVersion(wv, versionOfNewWave)
	Wave/Z wv
	variable versionOfNewWave

	// The equality check ensures that you can also downgrade, e.g. from version 5 to 4, although this is *strongly* discouraged.
	return WaveExists(wv) && GetNumberFromWaveNote(wv, WAVE_NOTE_LAYOUT_KEY) == versionOfNewWave
End

/// @brief Set the wave layout version of wave
static Function SetWaveVersion(wv, val)
	Wave wv
	variable val

	ASSERT(val > 0 && IsInteger(val), "val must be a positive and non-zero integer")
	SetNumberInWaveNote(wv, WAVE_NOTE_LAYOUT_KEY, val)
End
/// @}

/// @brief Return a wave reference to the channel clamp mode wave
///
/// Rows:
/// - Channel numbers
///
/// Columns:
/// - 0: DAC channels
/// - 1: ADC channels
///
/// Contents:
/// - Clamp mode: One of V_CLAMP_MODE, I_CLAMP_MODE and I_EQUAL_ZERO_MODE
Function/Wave GetChannelClampMode(panelTitle)
	string panelTitle

	DFREF dfr = GetDevicePath(panelTitle)

	Wave/Z/SDFR=dfr wv = ChannelClampMode

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(16,2) dfr:ChannelClampMode/Wave=wv

	SetDimLabel COLS, 0, DAC, wv
	SetDimLabel COLS, 1, ADC, wv

	return wv
End

/// @brief Returns a wave reference to the SweepData
///
/// SweepData is used to store GUI configuration info which can then be transferred into the documenting functions
///
/// Rows:
/// - Only one
///
/// Columns:
/// - 0: DAC
/// - 1: ADC
/// - 2: DA Gain
/// - 3: AD Gain
/// - 4: DA Scale
/// - 5: Set sweep count 
///
/// Layers:
/// - Headstage
Function/Wave DC_SweepDataWvRef(panelTitle)
	string panelTitle
	
	DFREF dfr = GetDevicePath(panelTitle)

	Wave/Z/SDFR=dfr wv = SweepData

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(1, 6, NUM_HEADSTAGES) dfr:SweepData/Wave=wv
	wv = NaN

	return wv
End

/// @brief Returns a wave reference to the SweepTxtData
///
/// SweepTxtData is used to store the set name used on a particular headstage
/// Rows:
/// - Only one
///
/// Columns:
/// - 0: SetName
///
/// Layers:
/// - Headstage
Function/Wave DC_SweepDataTxtWvRef(panelTitle)
	string panelTitle
	
	DFREF dfr = GetDevicePath(panelTitle)

	Wave/Z/T/SDFR=dfr wv = SweepTxtData

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(1, 1, NUM_HEADSTAGES) dfr:SweepTxtData/Wave=wv
	wv = ""

	return wv
End

/// @name Experiment Documentation
/// @{

/// @brief Return the datafolder reference to the lab notebook
Function/DF GetLabNotebookFolder(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetLabNotebookFolderAsString(panelTitle))
End

/// @brief Return the full path to the lab notebook, e.g. root:MIES:LabNoteBook
Function/S GetLabNotebookFolderAsString(panelTitle)
	string panelTitle

	return GetMiesPathAsString() + ":LabNoteBook"
End

/// @brief Return the data folder reference to the device specific lab notebook
Function/DF GetDevSpecLabNBFolder(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDevSpecLabNBFolderAsString(panelTitle))
End

/// @brief Return the full path to the device specific lab notebook, e.g. root:MIES:LabNoteBook:ITC18USB:Device0
Function/S GetDevSpecLabNBFolderAsString(panelTitle)
	string panelTitle

	string deviceType, deviceNumber
	variable ret

	ret = ParseDeviceString(panelTitle, deviceType, deviceNumber)
	ASSERT(ret, "Could not parse the panelTitle")

	return GetLabNotebookFolderAsString(panelTitle) + ":" + deviceType + ":Device" + deviceNumber
End

/// @brief Return the datafolder reference to the device specific settings key
Function/DF GetDevSpecLabNBSettKeyFolder(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDevSpecLabNBSettKeyFolderAS(panelTitle))
End

/// @brief Return the full path to the device specific settings key, e.g. root:mies:LabNoteBook:ITC18USB:Device0:KeyWave
Function/S GetDevSpecLabNBSettKeyFolderAS(panelTitle)
	string panelTitle

	return GetDevSpecLabNBFolderAsString(panelTitle) + ":KeyWave"
End

/// @brief Return the datafolder reference to the device specific settings history
Function/DF GetDevSpecLabNBSettHistFolder(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDevSpecLabNBSettHistFolderAS(panelTitle))
End

/// @brief Return the full path to the device specific settings history, e.g. root:mies:LabNoteBook:ITC18USB:Device0:settingsHistory
Function/S GetDevSpecLabNBSettHistFolderAS(panelTitle)
	string panelTitle

	return GetDevSpecLabNBFolderAsString(panelTitle) + ":settingsHistory"
End

/// @brief Return the datafolder reference to the device specific text doc key
Function/DF GetDevSpecLabNBTxtDocKeyFolder(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDevSpecLabNBTextDocKeyFoldAS(panelTitle))
End

/// @brief Return the full path to the device specific text doc key, e.g. root:mies:LabNoteBook:ITC18USB:Device0:textDocKeyWave
Function/S GetDevSpecLabNBTextDocKeyFoldAS(panelTitle)
	string panelTitle

	return GetDevSpecLabNBFolderAsString(panelTitle) + ":TextDocKeyWave"
End

/// @brief Return the datafolder reference to the device specific text documentation
Function/DF GetDevSpecLabNBTextDocFolder(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDevSpecLabNBTextDocFolderAS(panelTitle))
End

/// @brief Return the full path to the device specific text documentation, e.g. root:mies:LabNoteBook:ITC18USB:Device0:textDocumentation
Function/S GetDevSpecLabNBTextDocFolderAS(panelTitle)
	string panelTitle

	return GetDevSpecLabNBFolderAsString(panelTitle) + ":textDocumentation"
End

/// @brief Returns a wave reference to the textDocWave
///
/// textDocWave is used to save settings for each data sweep and
/// create waveNotes for tagging data sweeps
///
/// Rows:
/// - Only one
///
/// Columns:
/// - 0: Sweep Number
/// - 1: Time Stamp
///
/// Layers:
/// - Headstage
Function/Wave GetTextDocWave(panelTitle)
	string panelTitle

	DFREF dfr = GetDevSpecLabNBTextDocFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = txtDocWave

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(1,2,0) dfr:txtDocWave/Wave=wv
	wv = ""

	return wv
End

/// @brief Returns a wave reference to the textDocKeyWave
///
/// textDocKeyWave is used to index save settings for each data sweep
/// and create waveNotes for tagging data sweeps
///
/// Rows:
/// - 0: Parameter Name
///
/// Columns:
/// - 0: Sweep Number
/// - 1: Time Stamp
///
/// Layers:
/// - Headstage
Function/Wave GetTextDocKeyWave(panelTitle)
	string panelTitle

	DFREF dfr = GetDevSpecLabNBTxtDocKeyFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = txtDocKeyWave

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(1,2,0) dfr:txtDocKeyWave/Wave=wv
	wv = ""

	SetDimLabel 0, 0, Parameter, wv

	return wv
End

/// @brief Returns a wave reference to the sweepSettingsWave
///
/// sweepSettingsWave is used to save stimulus settings for each
/// data sweep and create waveNotes for tagging data sweeps
///
/// Rows:
///  - One row
///
/// Columns:
/// - 0: Stim Wave Name
/// - 1: Stim Scale Factor
///
/// Layers:
/// - Headstage
Function/Wave GetSweepSettingsWave(panelTitle, noHeadStages)
	string panelTitle
	variable noHeadStages

	DFREF dfr = GetDevSpecLabNBSettHistFolder(panelTitle)

	Wave/Z/SDFR=dfr wv = sweepSettingsWave

	if(WaveExists(wv))
		// we have to resize the wave here as the user relies
		// on the requested size
		if(DimSize(wv, LAYERS) != noHeadStages)
			Redimension/N=(-1, -1, noHeadStages) wv
		endif
		return wv
	endif

	Make/N=(1,6,noHeadStages) dfr:sweepSettingsWave/Wave=wv
	wv = Nan

	return wv
End

/// @brief Returns a wave reference to the sweepSettingsKeyWave
///
/// sweepSettingsKeyWave is used to index save stimulus settings for
/// each data sweep and create waveNotes for tagging data sweeps
///
/// Rows:
/// - 0: Parameter
/// - 1: Units
/// - 2: Tolerance Factor
///
/// Columns:
/// - 0: Stim Scale Factor
/// - 1: DAC
/// - 2: ADC
/// - 3: DA Gain
/// - 4: AD Gain
/// - 5: Set sweep count
///
/// Layers:
/// - Headstage
Function/Wave GetSweepSettingsKeyWave(panelTitle)
	string panelTitle

	DFREF dfr = GetDevSpecLabNBSettKeyFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = sweepSettingsKeyWave

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(3,6) dfr:sweepSettingsKeyWave/Wave=wv
	wv = ""

	SetDimLabel 0, 0, Parameter, wv
	SetDimLabel 0, 1, Units, wv
	SetDimLabel 0, 2, Tolerance, wv

	wv[%Parameter][0] = "Stim Scale Factor"
	wv[%Units][0]     = "%"
	wv[%Tolerance][0] = ".0001"

	wv[%Parameter][1] = "DAC"
	wv[%Units][1]     = ""
	wv[%Tolerance][1] = ".0001"

	wv[%Parameter][2] = "ADC"
	wv[%Units][2]     = ""
	wv[%Tolerance][2] = ".0001"

	wv[%Parameter][3] = "DA Gain"
	wv[%Units][3]     = "mV/V"
	wv[%Tolerance][3] = ".000001"

	wv[%Parameter][4] = "AD Gain"
	wv[%Units][4]     = "V/pA"
	wv[%Tolerance][4] = ".000001"

	wv[%Parameter][5] = "Set Sweep Count"
	wv[%Units][5]     = ""
	wv[%Tolerance][5] = ".0001"

	return wv
End

/// @brief Returns a wave reference to the SweepSettingsTxtWave
///
/// SweepSettingsTxtData is used to store the set name used on a particular
/// headstage and then create waveNotes for the sweep data
///
/// Rows:
/// - Only one
///
/// Columns:
/// - 0: SetName
///
/// Layers:
/// - Headstage
Function/Wave GetSweepSettingsTextWave(panelTitle, noHeadStages)
	string panelTitle
	variable noHeadStages

	DFREF dfr = GetDevSpecLabNBTextDocFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = SweepSettingsTxtData

	if(WaveExists(wv))
		// we have to resize the wave here as the user relies
		// on the requested size
		if(DimSize(wv, LAYERS) != noHeadStages)
			Redimension/N=(-1, -1, noHeadStages) wv
		endif
		return wv
	endif

	Make/T/N=(1,1,noHeadStages) dfr:SweepSettingsTxtData/Wave=wv
	wv = ""

	return wv
End

/// @brief Returns a wave reference to the SweepSettingsKeyTxtData
///
/// SweepSettingsKeyTxtData is used to index Txt Key Wave
///
/// Rows:
/// - Only one
///
/// Columns:
/// - 0: SetName
///
/// Layers:
/// - Headstage
Function/Wave GetSweepSettingsTextKeyWave(panelTitle, noHeadStages)
	string panelTitle
	variable noHeadStages

	DFREF dfr = GetDevSpecLabNBTxtDocKeyFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = SweepSettingsKeyTxtData

	if(WaveExists(wv))
		// we have to resize the wave here as the user relies
		// on the requested size
		if(DimSize(wv, LAYERS) != noHeadStages)
			Redimension/N=(-1, -1, noHeadStages) wv
		endif
		return wv
	endif

	Make/T/N=(1,1,noHeadStages) dfr:SweepSettingsKeyTxtData/Wave=wv
	wv = ""

	return wv
End
/// @}

/// @name Constants for the note of the wave returned by GetTPStorage
/// @{
StrConstant TP_CYLCE_COUNT_KEY           = "TPCycleCount"
StrConstant AUTOBIAS_LAST_INVOCATION_KEY = "AutoBiasLastInvocation"
/// @}

/// @brief Return a wave reference for TPStorage
///
/// The wave stores TP resistance and Vm data as
/// function of time while the TP is running.
Function/Wave GetTPStorage(panelTitle)
	string 	panelTitle

	dfref dfr = GetDeviceTestPulse(panelTitle)
	Wave/Z/SDFR=dfr wv = TPStorage

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(128, NUM_HEADSTAGES, 8) dfr:TPStorage/Wave=wv
	wv = NaN

	SetDimLabel COLS,  -1, HeadStage            , wv

	SetDimLabel LAYERS, 0, Vm                   , wv
	SetDimLabel LAYERS, 1, PeakResistance       , wv
	SetDimLabel LAYERS, 2, SteadyStateResistance, wv
	SetDimLabel LAYERS, 3, TimeInSeconds        , wv
	SetDimLabel LAYERS, 4, DeltaTimeInSeconds   , wv
	SetDimLabel LAYERS, 5, Vm_Slope             , wv
	SetDimLabel LAYERS, 6, Rpeak_Slope          , wv
	SetDimLabel LAYERS, 7, Rss_Slope            , wv

	Note wv, TP_CYLCE_COUNT_KEY + ":0;"
	Note/NOCR wv, AUTOBIAS_LAST_INVOCATION_KEY + ":0;"

	return wv
End

/// @brief Return a datafolder reference to the test pulse folder
Function/DF GetDeviceTestPulse(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDeviceTestPulseAsString(panelTitle))
End

/// @brief Return the path to the test pulse folder, e.g. root:mies::ITCDevices:ITC1600:Device0:TestPulse
Function/S GetDeviceTestPulseAsString(panelTitle)
	string panelTitle

	return HSU_DataFullFolderPathString(panelTitle) + ":TestPulse"
End

/// @brief Return a datafolder reference to the device type folder
Function/DF GetDeviceTypePath(deviceType)
	string deviceType

	return createDFWithAllParents(GetDeviceTypePathAsString(deviceType))
End

/// @brief Return the path to the device type folder, e.g. root:mies::ITCDevices:ITC1600
Function/S GetDeviceTypePathAsString(deviceType)
	string deviceType

	return Path_ITCDevicesFolder("") + ":" + deviceType
End

/// @brief Return a datafolder reference to the device folder
Function/DF GetDevicePath(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDevicePathAsString(panelTitle))
End

/// @brief Return the path to the device folder, e.g. root:mies::ITCDevices:ITC1600:Device0
Function/S GetDevicePathAsString(panelTitle)
	string panelTitle

	string deviceType, deviceNumber

	if(!ParseDeviceString(panelTitle, deviceType, deviceNumber) || !CmpStr(deviceType, StringFromList(0, BASE_WINDOW_TITLE, "_")))
		DEBUGPRINT("Invalid/Non-locked paneltitle, falling back to querying the GUI.")

		deviceType   = HSU_GetDeviceType(panelTitle)
		deviceNumber = HSU_GetDeviceNumber(panelTitle)
	endif

	return GetDeviceTypePathAsString(deviceType) + ":Device" + deviceNumber
End

/// @brief Return a datafolder reference to the device data folder
Function/DF GetDeviceDataPath(panelTitle)
	string panelTitle

	return createDFWithAllParents(GetDeviceDataPathAsString(panelTitle))
End

/// @brief Return the path to the device folder, e.g. root:mies::ITCDevices:ITC1600:Device0:Data
Function/S GetDeviceDataPathAsString(panelTitle)
	string panelTitle

	return GetDevicePathAsString(panelTitle) + ":Data"
End

/// @brief Return the datafolder reference to the amplifier
Function/DF GetAmplifierFolder()
	return createDFWithAllParents(GetAmplifierFolderAsString())
End

/// @brief Return the path to the amplifierm e.g. root:mies:Amplifiers"
Function/S GetAmplifierFolderAsString()
	return GetMiesPathAsString() + ":Amplifiers"
End

/// @brief Return the datafolder reference to the amplifier settings
Function/DF GetAmpSettingsFolder()
	return createDFWithAllParents(GetAmpSettingsFolderAsString())
End

/// @brief Return the path to the amplifier settings, e.g. root:MIES:Amplifiers:Settings
Function/S GetAmpSettingsFolderAsString()
	return GetAmplifierFolderAsString() + ":Settings"
End

/// @brief Return a wave reference to the amplifier parameter storage wave
///
/// Rows:
/// - 0-31: Amplifier settings identified by dimension labels
///
/// Columns:
/// - Only one
///
/// Layers:
/// - 0-7: Headstage identifier
///
/// Contents:
/// - numerical amplifier settings
Function/Wave GetAmplifierParamStorageWave(panelTitle)
	string panelTitle

	DFREF dfr = GetAmpSettingsFolder()

	// wave's name is like ITC18USB_Dev_0
	Wave/Z/SDFR=dfr wv = $panelTitle

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(31, 1, NUM_HEADSTAGES) dfr:$panelTitle/Wave=wv

	SetDimLabel LAYERS, -1, Headstage             , wv
	SetDimLabel ROWS  , 0 , HoldingPotential      , wv
	SetDimLabel ROWS  , 1 , HoldingPotentialEnable, wv
	SetDimLabel ROWS  , 2 , WholeCellCap          , wv
	SetDimLabel ROWS  , 3 , WholeCellRes          , wv
	SetDimLabel ROWS  , 4 , WholeCellEnable       , wv
	SetDimLabel ROWS  , 5 , Correction            , wv
	SetDimLabel ROWS  , 6 , Prediction            , wv
	SetDimLabel ROWS  , 7 , RsCompEnable          , wv
	SetDimLabel ROWS  , 8 , PipetteOffset         , wv
	SetDimLabel ROWS  , 9 , VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 10, VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 11, VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 12, VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 13, VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 14, VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 15, VClampPlaceHolder     , wv
	SetDimLabel ROWS  , 16, BiasCurrent           , wv
	SetDimLabel ROWS  , 17, BiasCurrentEnable     , wv
	SetDimLabel ROWS  , 18, BridgeBalance         , wv
	SetDimLabel ROWS  , 19, BridgeBalanceEnable   , wv
	SetDimLabel ROWS  , 20, CapNeut               , wv
	SetDimLabel ROWS  , 21, CapNeutEnable         , wv
	SetDimLabel ROWS  , 22, AutoBiasVcom          , wv
	SetDimLabel ROWS  , 23, AutoBiasVcomVariance  , wv
	SetDimLabel ROWS  , 24, AutoBiasIbiasmax      , wv
	SetDimLabel ROWS  , 25, AutoBiasEnable        , wv
	SetDimLabel ROWS  , 26, IclampPlaceHolder     , wv
	SetDimLabel ROWS  , 27, IclampPlaceHolder     , wv
	SetDimLabel ROWS  , 28, IclampPlaceHolder     , wv
	SetDimLabel ROWS  , 29, IclampPlaceHolder     , wv
	SetDimLabel ROWS  , 30, IZeroEnable           , wv

	return wv
End

/// @brief Returns a data folder reference to the mies base folder
Function/DF GetMiesPath()
	return createDFWithAllParents(GetMiesPathAsString())
End

/// @brief Returns the base folder for all MIES functionality, e.g. root:MIES
Function/S GetMiesPathAsString()
	return "root:MIES"
End

/// @name Wavebuilder datafolders
/// @{

/// @brief Returns a data folder reference to the base
Function/DF GetWaveBuilderPath()
	return createDFWithAllParents(GetWaveBuilderPathAsString())
End

/// @brief Returns the full path to the base path, e.g. root:MIES:WaveBuilder
Function/S GetWaveBuilderPathAsString()
	return GetMiesPathAsString() + ":WaveBuilder"
End

/// @brief Returns a data folder reference to the data
Function/DF GetWaveBuilderDataPath()
	return createDFWithAllParents(GetWaveBuilderDataPathAsString())
End

///	@brief Returns the full path to the data folder, e.g root:MIES:WaveBuilder:Data
Function/S GetWaveBuilderDataPathAsString()
	return GetWaveBuilderPathAsString() + ":Data"
End

/// @brief Returns a data folder reference to the stimulus set parameter
Function/DF GetWBSvdStimSetParamPath()
	return createDFWithAllParents(GetWBSvdStimSetParamPathAS())
End

///	@brief Returns the full path to the stimulus set parameter folder, e.g. root:MIES:WaveBuilder:SavedStimulusSetParameters
Function/S GetWBSvdStimSetParamPathAS()
	return GetWaveBuilderPathAsString() + ":SavedStimulusSetParameters"
End

/// @brief Returns a data folder reference to the stimulus set
Function/DF GetWBSvdStimSetPath()
	return createDFWithAllParents(GetWBSvdStimSetPathAsString())
End

///	@brief Returns the full path to the stimulus set, e.g. root:MIES:WaveBuilder:SavedStimulusSets
Function/S GetWBSvdStimSetPathAsString()
	return GetWaveBuilderPathAsString() + ":SavedStimulusSets"
End

/// @brief Returns a data folder reference to the stimulus set parameters of `DA` type
Function/DF GetWBSvdStimSetParamDAPath()
	return createDFWithAllParents(GetWBSvdStimSetParamDAPathAS())
End

///	@brief Returns the full path to the stimulus set parameters of `DA` type, e.g. root:MIES:WaveBuilder:SavedStimulusSetParameters:DA
Function/S GetWBSvdStimSetParamDAPathAS()
	return GetWBSvdStimSetParamPathAS() + ":DA"
End

/// @brief Returns a data folder reference to the stimulus set parameters of `TTL` type
Function/DF GetWBSvdStimSetParamTTLPath()
	return createDFWithAllParents(GetWBSvdStimSetParamTTLAsString())
End

///	@brief Returns the full path to the stimulus set parameters of `TTL` type, e.g. root:MIES:WaveBuilder:SavedStimulusSetParameters:TTL
Function/S GetWBSvdStimSetParamTTLAsString()
	return GetWBSvdStimSetParamPathAS() + ":TTL"
End

/// @brief Returns a data folder reference to the stimulus set of `DA` type
Function/DF GetWBSvdStimSetDAPath()
	return createDFWithAllParents(GetWBSvdStimSetDAPathAsString())
End

///	@brief Returns the full path to the stimulus set of `DA` type, e.g. root:MIES:WaveBuilder:SavedStimulusSet:DA
Function/S GetWBSvdStimSetDAPathAsString()
	return GetWBSvdStimSetPathAsString() + ":DA"
End

/// @brief Returns a data folder reference to the stimulus set of `TTL` type
Function/DF GetWBSvdStimSetTTLPath()
	return createDFWithAllParents(GetWBSvdStimSetTTLPathAsString())
End

///	@brief Returns the full path to the stimulus set of `TTL` type, e.g. root:MIES:WaveBuilder:SavedStimulusSet:TTL
Function/S GetWBSvdStimSetTTLPathAsString()
	return GetWBSvdStimSetPathAsString() + ":TTL"
End
///@}

/// @brief Returns the segment parameter wave used by the wave builder panel
/// - Rows
///   - 0 - 98: epoch types using the tabcontrol indizes
///   - 99: set ITI (s)
///   - 100: total number of segments/epochs
///   - 101: total number of steps
Function/Wave GetSegmentWave()

	dfref dfr = GetWaveBuilderDataPath()
	Wave/Z/SDFR=dfr wv = SegWvType

	if(WaveExists(wv))
		return wv
	endif

	Make/N=102 dfr:SegWvType/Wave=wv

	return wv
End

/// @brief Returns a wave reference to the asyncMeasurementWave
///
/// asyncMeasurementWave is used to save the actual async measurement data
/// for each data sweep 
///
/// Rows:
/// - One row
///
/// - Columns:
/// - 0: Async Measurement 0
/// - 1: Async Measurement 1
/// - 2: Async Measurement 2
/// - 3: Async Measurement 3
/// - 4: Async Measurement 4
/// - 5: Async Measurement 5
/// - 6: Async Measurement 6
/// - 7: Async Measurement 7
///
/// Layers:
/// - Only one...all async measurements apply across all headstages, so no need to create multiple layers
Function/Wave GetAsyncMeasurementWave(panelTitle)
	string panelTitle
	variable noHeadStages

	DFREF dfr =GetDevSpecLabNBSettHistFolder(panelTitle)

	Wave/Z/SDFR=dfr wv = asyncMeasurementWave

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(1,8) dfr:asyncMeasurementWave/Wave=wv
	wv = Nan

	SetDimLabel 1, 0, MeasVal0, wv
	SetDimLabel 1, 1, MeasVal1, wv
	SetDimLabel 1, 2, MeasVal2, wv
	SetDimLabel 1, 3, MeasVal3, wv
	SetDimLabel 1, 4, MeasVal4, wv
	SetDimLabel 1, 5, MeasVal5, wv
	SetDimLabel 1, 6, MeasVal6, wv
	SetDimLabel 1, 7, MeasVal7, wv
	
	return wv
End

/// @brief Returns a wave reference to the asyncMeasurementKeyWave
///
/// asyncMeasurementKeyWave is used to index async measurements for
/// each data sweep and create waveNotes for tagging data sweeps
///
/// Rows:
/// - 0: Parameter
/// - 1: Units
/// - 2: Tolerance Factor
///
/// Columns:
/// - 0: Async Measurement 0
/// - 1: Async Measurement 1
/// - 2: Async Measurement 2
/// - 3: Async Measurement 3
/// - 4: Async Measurement 4
/// - 5: Async Measurement 5
/// - 6: Async Measurement 6
/// - 7: Async Measurement 7
///
/// Layers:
/// - Just one
Function/Wave GetAsyncMeasurementKeyWave(panelTitle)
	string panelTitle

	DFREF dfr = GetDevSpecLabNBSettKeyFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = asyncMeasurementKeyWave

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(3,8) dfr:asyncMeasurementKeyWave/Wave=wv
	wv = ""

	SetDimLabel 0, 0, Parameter, wv
	SetDimLabel 0, 1, Units, wv
	SetDimLabel 0, 2, Tolerance, wv
	
	wv[%Parameter][0] = "Async AD 0"
	wv[%Units][0]     = ""
	wv[%Tolerance][0] = ".0001"

	wv[%Parameter][1] = "Async AD 1"
	wv[%Units][1]     = ""
	wv[%Tolerance][1] = ".0001"
	
	wv[%Parameter][2] = "Async AD 2"
	wv[%Units][2]     = ""
	wv[%Tolerance][2] = ".0001"
	
	wv[%Parameter][3] = "Async AD 3"
	wv[%Units][3]     = ""
	wv[%Tolerance][3] = ".0001"
	
	wv[%Parameter][4] = "Async AD 4"
	wv[%Units][4]     = ""
	wv[%Tolerance][4] = ".0001"

	wv[%Parameter][5] = "Async AD 5"
	wv[%Units][5]     = ""
	wv[%Tolerance][5] = ".0001"
	
	wv[%Parameter][6] = "Async AD 6"
	wv[%Units][6]     = ""
	wv[%Tolerance][6] = ".0001"
	
	wv[%Parameter][7] = "Async AD 7"
	wv[%Units][7]     = ""
	wv[%Tolerance][7] = ".0001"
	
	return wv
End

/// @brief Returns a wave reference to the asyncSettingsWave
///
/// asyncSettingsWave is used to save async settings for each
/// data sweep and create waveNotes for tagging data sweeps
///
/// Rows:
///  - One row
///
/// Columns:
/// - 0: Async AD 0 OnOff
/// - 1: Async AD 1 OnOff
/// - 2: Async AD 2 OnOff
/// - 3: Async AD 3 OnOff
/// - 4: Async AD 4 OnOff
/// - 5: Async AD 5 OnOff
/// - 6: Async AD 6 OnOff
/// - 7: Async AD 7 OnOff
/// - 8: Async AD 0 Gain
/// - 9: Async AD 1 Gain
/// - 10: Async AD 2 Gain
/// - 11: Async AD 3 Gain
/// - 12: Async AD 4 Gain
/// - 13: Async AD 5 Gain
/// - 14: Async AD 6 Gain
/// - 15: Async AD 7 Gain
/// - 16: Async Alarm 0 OnOff
/// - 17: Async Alarm 1 OnOff
/// - 18: Async Alarm 2 OnOff
/// - 19: Async Alarm 3 OnOff
/// - 20: Async Alarm 4 OnOff
/// - 21: Async Alarm 5 OnOff
/// - 22: Async Alarm 6 OnOff
/// - 23: Async Alarm 7 OnOff
/// - 24: Async Alarm 0 Min
/// - 25: Async Alarm 1 Min
/// - 26: Async Alarm 2 Min
/// - 27: Async Alarm 3 Min
/// - 28: Async Alarm 4 Min
/// - 29: Async Alarm 5 Min
/// - 30: Async Alarm 6 Min
/// - 31: Async Alarm 7 Min
/// - 32: Async Alarm 0 Max
/// - 33: Async Alarm 1 Max
/// - 34: Async Alarm 2 Max
/// - 35: Async Alarm 3 Max
/// - 36: Async Alarm 4 Max
/// - 37: Async Alarm 5 Max
/// - 38: Async Alarm 6 Max
/// - 39: Async Alarm 7 Max
///
/// Layers:
/// - Just one layer...all async settings apply to every headstage, so no need to copy across multiple layers
Function/Wave GetAsyncSettingsWave(panelTitle)
	string panelTitle
	variable noHeadStages

	DFREF dfr =GetDevSpecLabNBSettHistFolder(panelTitle)

	Wave/Z/SDFR=dfr wv = asyncSettingsWave

	if(WaveExists(wv))
		return wv
	endif

	Make/N=(1,40) dfr:asyncSettingsWave/Wave=wv
	wv = Nan
	
	SetDimLabel 1, 0, ADOnOff0, wv
	SetDimLabel 1, 1, ADOnOff1, wv
	SetDimLabel 1, 2, ADOnOff2, wv
	SetDimLabel 1, 3, ADOnOff3, wv
	SetDimLabel 1, 4, ADOnOff4, wv
	SetDimLabel 1, 5, ADOnOff5, wv
	SetDimLabel 1, 6, ADOnOff6, wv
	SetDimLabel 1, 7, ADOnOff7, wv
	SetDimLabel 1, 8, ADGain0, wv
	SetDimLabel 1, 9, ADGain1, wv
	SetDimLabel 1, 10, ADGain2, wv
	SetDimLabel 1, 11, ADGain3, wv
	SetDimLabel 1, 12, ADGain4, wv
	SetDimLabel 1, 13, ADGain5, wv
	SetDimLabel 1, 14, ADGain6, wv
	SetDimLabel 1, 15, ADGain7, wv
	SetDimLabel 1, 16, AlarmOnOff0, wv
	SetDimLabel 1, 17, AlarmOnOff1, wv
	SetDimLabel 1, 18, AlarmOnOff2, wv
	SetDimLabel 1, 19, AlarmOnOff3, wv
	SetDimLabel 1, 20, AlarmOnOff4, wv
	SetDimLabel 1, 21, AlarmOnOff5, wv
	SetDimLabel 1, 22, AlarmOnOff6, wv
	SetDimLabel 1, 23, AlarmOnOff7, wv
	SetDimLabel 1, 24, AlarmMin0, wv
	SetDimLabel 1, 25, AlarmMin1, wv
	SetDimLabel 1, 26, AlarmMin2, wv
	SetDimLabel 1, 27, AlarmMin3, wv
	SetDimLabel 1, 28, AlarmMin4, wv
	SetDimLabel 1, 29, AlarmMin5, wv
	SetDimLabel 1, 30, AlarmMin6, wv
	SetDimLabel 1, 31, AlarmMin7, wv
	SetDimLabel 1, 32, AlarmMax0, wv
	SetDimLabel 1, 33, AlarmMax1, wv
	SetDimLabel 1, 34, AlarmMax2, wv
	SetDimLabel 1, 35, AlarmMax3, wv
	SetDimLabel 1, 36, AlarmMax4, wv
	SetDimLabel 1, 37, AlarmMax5, wv
	SetDimLabel 1, 38, AlarmMax6, wv
	SetDimLabel 1, 39, AlarmMax7, wv
	
	return wv
End

/// @brief Returns a wave reference to the asyncSettingsKeyWave
///
/// asyncSettingsKeyWave is used to index async settings for
/// each data sweep and create waveNotes for tagging data sweeps
///
/// Rows:
/// - 0: Parameter
/// - 1: Units
/// - 2: Tolerance Factor
///
/// Columns:
/// - 0: Async AD 0 OnOff
/// - 1: Async AD 1 OnOff
/// - 2: Async AD 2 OnOff
/// - 3: Async AD 3 OnOff
/// - 4: Async AD 4 OnOff
/// - 5: Async AD 5 OnOff
/// - 6: Async AD 6 OnOff
/// - 7: Async AD 7 OnOff
/// - 8: Async AD 0 Gain
/// - 9: Async AD 1 Gain
/// - 10: Async AD 2 Gain
/// - 11: Async AD 3 Gain
/// - 12: Async AD 4 Gain
/// - 13: Async AD 5 Gain
/// - 14: Async AD 6 Gain
/// - 15: Async AD 7 Gain
/// - 16: Async Alarm 0 OnOff
/// - 17: Async Alarm 1 OnOff
/// - 18: Async Alarm 2 OnOff
/// - 19: Async Alarm 3 OnOff
/// - 20: Async Alarm 4 OnOff
/// - 21: Async Alarm 5 OnOff
/// - 22: Async Alarm 6 OnOff
/// - 23: Async Alarm 7 OnOff
/// - 24: Async Alarm 0 Min
/// - 25: Async Alarm 1 Min
/// - 26: Async Alarm 2 Min
/// - 27: Async Alarm 3 Min
/// - 28: Async Alarm 4 Min
/// - 29: Async Alarm 5 Min
/// - 30: Async Alarm 6 Min
/// - 31: Async Alarm 7 Min
/// - 32: Async Alarm 0 Max
/// - 33: Async Alarm 1 Max
/// - 34: Async Alarm 2 Max
/// - 35: Async Alarm 3 Max
/// - 36: Async Alarm 4 Max
/// - 37: Async Alarm 5 Max
/// - 38: Async Alarm 6 Max
/// - 39: Async Alarm 7 Max
///
/// Layers:
/// - Just one
Function/Wave GetAsyncSettingsKeyWave(panelTitle)
	string panelTitle

	DFREF dfr = GetDevSpecLabNBSettKeyFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = asyncSettingsKeyWave

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(3,40) dfr:asyncSettingsKeyWave/Wave=wv
	wv = ""

	SetDimLabel 0, 0, Parameter, wv
	SetDimLabel 0, 1, Units, wv
	SetDimLabel 0, 2, Tolerance, wv

	wv[%Parameter][0] = "Async 0 On/Off"
	wv[%Units][0]     = "On/Off"
	wv[%Tolerance][0] = "-"
	
	wv[%Parameter][1] = "Async 1 On/Off"
	wv[%Units][1]     = "On/Off"
	wv[%Tolerance][1] = "-"
	
	wv[%Parameter][2] = "Async 2 On/Off"
	wv[%Units][2]     = "On/Off"
	wv[%Tolerance][2] = "-"
	
	wv[%Parameter][3] = "Async 3 On/Off"
	wv[%Units][3]     = "On/Off"
	wv[%Tolerance][3] = "-"
	
	wv[%Parameter][4] = "Async 4 On/Off"
	wv[%Units][4]     = "On/Off"
	wv[%Tolerance][4] = "-"
	
	wv[%Parameter][5] = "Async 5 On/Off"
	wv[%Units][5]     = "On/Off"
	wv[%Tolerance][5] = "-"
	
	wv[%Parameter][6] = "Async 6 On/Off"
	wv[%Units][6]     = "On/Off"
	wv[%Tolerance][6] = "-"
	
	wv[%Parameter][7] = "Async 7 On/Off"
	wv[%Units][7]     = "On/Off"
	wv[%Tolerance][7] = "-"		

	wv[%Parameter][8] = "Async 0 Gain"
	wv[%Units][8]     = ""
	wv[%Tolerance][8] = ".001"

	wv[%Parameter][9] = "Async 1 Gain"
	wv[%Units][9]     = ""
	wv[%Tolerance][9] = ".001"
	
	wv[%Parameter][10] = "Async 2 Gain"
	wv[%Units][10]     = ""
	wv[%Tolerance][10] = ".001"

	wv[%Parameter][11] = "Async 3 Gain"
	wv[%Units][11]     = ""
	wv[%Tolerance][11] = ".001"
	
	wv[%Parameter][12] = "Async 4 Gain"
	wv[%Units][12]     = ""
	wv[%Tolerance][12] = ".001"

	wv[%Parameter][13] = "Async 5 Gain"
	wv[%Units][13]     = ""
	wv[%Tolerance][13] = ".001"
	
	wv[%Parameter][14] = "Async 6 Gain"
	wv[%Units][14]     = ""
	wv[%Tolerance][14] = ".001"

	wv[%Parameter][15] = "Async 7 Gain"
	wv[%Units][15]     = ""
	wv[%Tolerance][15] = ".001"

	wv[%Parameter][16] = "Async Alarm 0 On/Off"
	wv[%Units][16]     = "On/Off"
	wv[%Tolerance][16] = "-"
	
	wv[%Parameter][17] = "Async Alarm 1 On/Off"
	wv[%Units][17]     = "On/Off"
	wv[%Tolerance][17] = "-"
	
	wv[%Parameter][18] = "Async Alarm 2 On/Off"
	wv[%Units][18]     = "On/Off"
	wv[%Tolerance][18] = "-"
	
	wv[%Parameter][19] = "Async Alarm 3 On/Off"
	wv[%Units][19]     = "On/Off"
	wv[%Tolerance][19] = "-"
	
	wv[%Parameter][20] = "Async Alarm 4 On/Off"
	wv[%Units][20]     = "On/Off"
	wv[%Tolerance][20] = "-"
	
	wv[%Parameter][21] = "Async Alarm 5 On/Off"
	wv[%Units][21]     = "On/Off"
	wv[%Tolerance][21] = "-"
	
	wv[%Parameter][22] = "Async Alarm 6 On/Off"
	wv[%Units][22]     = "On/Off"
	wv[%Tolerance][22] = "-"
	
	wv[%Parameter][23] = "Async Alarm 7 On/Off"
	wv[%Units][23]     = "On/Off"
	wv[%Tolerance][23] = "-"

	wv[%Parameter][24] = "Async Alarm 0 Min"
	wv[%Units][24]     = ""
	wv[%Tolerance][24] = ".001"
	
	wv[%Parameter][25] = "Async Alarm 1 Min"
	wv[%Units][25]     = ""
	wv[%Tolerance][25] = ".001"
	
	wv[%Parameter][26] = "Async Alarm 2 Min"
	wv[%Units][26]     = ""
	wv[%Tolerance][26] = ".001"
	
	wv[%Parameter][27] = "Async Alarm 3 Min"
	wv[%Units][27]     = ""
	wv[%Tolerance][27] = ".001"
	
	wv[%Parameter][28] = "Async Alarm 4 Min"
	wv[%Units][28]     = ""
	wv[%Tolerance][28] = ".001"
	
	wv[%Parameter][29] = "Async Alarm 5 Min"
	wv[%Units][29]     = ""
	wv[%Tolerance][29] = ".001"
	
	wv[%Parameter][30] = "Async Alarm 6 Min"
	wv[%Units][30]     = ""
	wv[%Tolerance][30] = ".001"
	
	wv[%Parameter][31] = "Async Alarm 7 Min"
	wv[%Units][31]     = ""
	wv[%Tolerance][31] = ".001"

	wv[%Parameter][32] = "Async Alarm  0 Max"
	wv[%Units][32]     = ""
	wv[%Tolerance][32] = ".001"
	
	wv[%Parameter][33] = "Async Alarm  1 Max"
	wv[%Units][33]     = ""
	wv[%Tolerance][33] = ".001"
	
	wv[%Parameter][34] = "Async Alarm  2 Max"
	wv[%Units][34]     = ""
	wv[%Tolerance][34] = ".001"
	
	wv[%Parameter][35] = "Async Alarm  3 Max"
	wv[%Units][35]     = ""
	wv[%Tolerance][35] = ".001"
	
	wv[%Parameter][36] = "Async Alarm  4 Max"
	wv[%Units][36]     = ""
	wv[%Tolerance][36] = ".001"
	
	wv[%Parameter][37] = "Async Alarm  5 Max"
	wv[%Units][37]     = ""
	wv[%Tolerance][37] = ".001"
	
	wv[%Parameter][38] = "Async Alarm  6 Max"
	wv[%Units][38]     = ""
	wv[%Tolerance][38] = ".001"
	
	wv[%Parameter][39] = "Async Alarm  7 Max"
	wv[%Units][39]     = ""
	wv[%Tolerance][39] = ".001"
	
	return wv
End

/// @brief Returns a wave reference to the AsyncSettingsTxtWave
///
/// AsyncSettingsTxtData is used to store the async text settings used on a particular
/// headstage and then create waveNotes for the sweep data
///
/// Rows:
/// - Only one
///
/// Columns:
/// - 0: Async 0 Title
/// - 1: Async 1 Title
/// - 2: Async 2 Title
/// - 3: Async 3 Title
/// - 4: Async 4 Title
/// - 5: Async 5 Title
/// - 6: Async 6 Title
/// - 7: Async 7 Title
/// - 8: Async 0 Units
/// - 9: Async 1 Units
/// - 10: Async 2 Units
/// - 11: Async 3 Units
/// - 12: Async 4 Units
/// - 13: Async 5 Units
/// - 14: Async 6 Units
/// - 15: Async 7 Units
///
/// Layers:
/// - only do one...all of the aysnc measurement values apply to all headstages, so not necessary to save in 8 layers
Function/Wave GetAsyncSettingsTextWave(panelTitle)
	string panelTitle
	variable noHeadStages

	DFREF dfr = GetDevSpecLabNBTextDocFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = asyncSettingsTxtData

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(1,16) dfr:asyncSettingsTxtData/Wave=wv
	wv = ""

	return wv
End

/// @brief Returns a wave reference to the AsyncSettingsKeyTxtData
///
/// AsyncSettingsKeyTxtData is used to index Txt Key Wave
///
/// Rows:
/// - Just one
///
/// Columns:
/// - 0: Async 0 Title
/// - 1: Async 1 Title
/// - 2: Async 2 Title
/// - 3: Async 3 Title
/// - 4: Async 4 Title
/// - 5: Async 5 Title
/// - 6: Async 6 Title
/// - 7: Async 7 Title
/// - 8: Async 0 Unit
/// - 9: Async 1 Unit
/// - 10: Async 2 Unit
/// - 11: Async 3 Unit
/// - 12: Async 4 Unit
/// - 13: Async 5 Unit
/// - 14: Async 6 Unit
/// - 15: Async 7 Unit
///
/// Layers:
/// - Just one
Function/Wave GetAsyncSettingsTextKeyWave(panelTitle)
	string panelTitle
	variable noHeadStages

	DFREF dfr = GetDevSpecLabNBTxtDocKeyFolder(panelTitle)

	Wave/Z/T/SDFR=dfr wv = asyncSettingsKeyTxtData

	if(WaveExists(wv))
		return wv
	endif

	Make/T/N=(1,16) dfr:asyncSettingsKeyTxtData/Wave=wv
	wv = ""
	
	wv[0][0] = "Async AD0 Title"
	wv[0][1] = "Async AD1 Title"
	wv[0][2] = "Async AD2 Title"
	wv[0][3] = "Async AD3 Title"
	wv[0][4] = "Async AD4 Title"
	wv[0][5] = "Async AD5 Title"
	wv[0][6] = "Async AD6 Title"
	wv[0][7] = "Async AD7 Title"
	wv[0][8] = "Async AD0 Unit"
	wv[0][9] = "Async AD1 Unit"
	wv[0][10] = "Async AD2 Unit"
	wv[0][11] = "Async AD3 Unit"
	wv[0][12] = "Async AD4 Unit"
	wv[0][13] = "Async AD5 Unit"
	wv[0][14] = "Async AD6 Unit"
	wv[0][15] = "Async AD7 Unit"
	
	return wv
End

/// @brief Returns a wave reference to a DA data wave used for pressure pulses
///
/// Rows:
/// - data points (@ 5 microsecond intervals)
///
/// Columns:
/// - 0: DA data
Function/WAVE P_ITCDataDA(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr ITCDataDA

	if(WaveExists(ITCDataDA))
		return ITCDataDA
	endif

	make /w /o /n =(2^17) dfr:ITCDataDA/WAVE = Wv
	
	Wv = 0
	return Wv
End

/// @brief Returns a wave reference to a AD data wave used for pressure pulses
///
/// Rows:
/// - data points (@ 5 microsecond intervals)
///
/// Columns:
/// - 0: AD data
Function/WAVE P_ITCDataAD(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr ITCDataAD

	if(WaveExists(ITCDataAD))
		return ITCDataAD
	endif

	make /w /o /n =(2^17) dfr:ITCDataAD/WAVE = Wv
	
	Wv = 0
	return Wv
End

/// @brief Returns a wave reference to a TTL data wave used for pressure pulses on rack 0
///
/// Rows:
/// - data points (@ 5 microsecond intervals)
///
/// Columns:
/// - 0: TTL data
Function/WAVE P_ITCDataTTLRz(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr ITCDataTTLRz

	if(WaveExists(ITCDataTTLRz))
		return ITCDataTTLRz
	endif

	make /w /o /n =(2^17) dfr:ITCDataTTLRz/WAVE = Wv
	
	Wv = 0
	return Wv
End

/// @brief Returns a wave reference to a TTL data wave used for pressure pulses on rack 1
///
/// Rows:
/// - data points (@ 5 microsecond intervals)
///
/// Columns:
/// - 0: TTL data
Function/WAVE P_ITCDataTTLRo(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr ITCDataTTLRo

	if(WaveExists(ITCDataTTLRo))
		return ITCDataTTLRo
	endif

	make /w /o /n =(2^17) dfr:ITCDataTTLRo/WAVE = Wv
	
	Wv = 0
	return Wv
End

/// @brief Returns a wave reference to the data wave for the ITC TTL state
///
/// Rows:
/// - one row
///
/// Columns:
/// - one column
Function/WAVE P_DIO(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr DIO

	if(WaveExists(DIO))
		return DIO
	endif

	Make/N=1/W/O dfr:DIO/WAVE = Wv
	
	return Wv
End

/// @brief Returns a wave reference to the wave used to store the ITC device state
///
/// Rows:
/// - 1: State
/// - 2: Overflow / Underrun
/// - 3: Clipping conditions
/// - 4: Error code
///
/// Columns:
/// - 1: State
Function/WAVE P_ITCState(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr ITCState

	if(WaveExists(ITCState))
		return ITCState
	endif

	Make /I/O/N=4 dfr:ITCState/WAVE = Wv
	
	return Wv
End
/// @brief Returns a wave reference to a DA data wave used for pressure pulses
///
/// Rows:
/// - data points (@ 5 microsecond intervals)
///
/// Columns:
/// - 0: DA data
//Function/WAVE P_ITCDataAD(panelTitle)
//	string panelTitle
//	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)
//
//	Wave/Z/T/SDFR=dfr P_ITCDAData
//
//	if(WaveExists(P_ITCDAData))
//		return P_ITCDAData
//	endif
//
//	make /w /o /n =(2^15) dfr:P_ITCDAData/WAVE = Wv
//	
//	Wv = 0
//	return Wv
//End

/// @brief Returns a wave reference to the ITCDataWave used for pressure pulses
///
/// Rows:
/// - data points (@ 50 microsecond intervals)
///
/// Columns:
/// - 0: DA data
/// - 1: AD data
/// - 2: TTL data rack 0
/// - 3: TTL data rack 1
Function/WAVE P_GetITCData(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr P_ITCData
	
	if(WaveExists(P_ITCData))

		return P_ITCData
	endif
	
	make /w /o /n = (2^17, 4) dfr:P_ITCData/WAVE = Wv
	
	SetDimLabel COLS, 0, DA, 		Wv
	SetDimLabel COLS, 1, AD, 		Wv
	SetDimLabel COLS, 2, TTL_R0, 	Wv
	SetDimLabel COLS, 3, TTL_R1, 	Wv
	Wv = 0
	
	return Wv
End

/// @brief Returns a wave reference to the ITCChanConfig wave used for pressure pulses
///
/// Rows:
/// - 0: DA channel specifications
/// - 1: AD channel specifications
/// - 2: TTL rack 0 specifications
/// - 3: TTL rack 1 specifications
///
/// Columns:
/// - 0: Channel Type
/// - 1: Channel number (for DA or AD) or Rack (for TTL)
/// - 2: Sampling interval
/// - 3: Decimation
Function/WAVE P_GetITCChanConfig(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr P_ChanConfig

	if(WaveExists(P_ChanConfig))
		return P_ChanConfig
	endif
	
	Make /I /o /n = (4, 4) dfr:P_ChanConfig/WAVE = Wv
	
	Wv = 0
	Wv[0][0] = 1 // DA
	Wv[1][0] = 0 // AD
	Wv[2][0] = 3 // TTL
	Wv[3][0] = 3 // TTL
	
	Wv[2][1] = 0 // TTL rack 0
	Wv[3][1] = 3 // TTL rack 1
	
	Wv[][2] = SAMPLE_INT_MICRO // 5 micro second sampling interval
	
	SetDimLabel ROWS, 0, DA, 		Wv
	SetDimLabel ROWS, 1, AD, 		Wv
	SetDimLabel ROWS, 2, TTL_R0, 	Wv
	SetDimLabel ROWS, 3, TTL_R1, 	Wv
	
	SetDimLabel COLS, 0, Chan_Type, Wv
	SetDimLabel COLS, 1, Chan_num, 	Wv
	SetDimLabel COLS, 2, Samp_int, 	Wv

	return Wv

End

/// @brief Returns a wave reference to the ITCFIFOAvailConfig wave used for pressure pulses

Function/WAVE P_GetITCFIFOConfig(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr P_ITCFIFOConfig

	if(WaveExists(P_ITCFIFOConfig))
		return P_ITCFIFOConfig
	endif
	
	Make /I /o /n = (4, 4) dfr:P_ITCFIFOConfig/WAVE = Wv
	
	Wv = 0
	Wv[0][0] = 1 // DA
	Wv[1][0] = 0 // AD
	Wv[2][0] = 3 // TTL
	Wv[3][0] = 3 // TTL
	
	Wv[2][1] = 0 // TTL rack 0
	Wv[3][1] = 3 // TTL rack 1
	
	Wv[][2]	= -1 // reset the FIFO
	
	
	
	SetDimLabel ROWS, 0, DA, 			Wv
	SetDimLabel ROWS, 1, AD, 			Wv
	SetDimLabel ROWS, 2, TTL_R0, 		Wv
	SetDimLabel ROWS, 3, TTL_R1, 		Wv
	
	SetDimLabel COLS, 0, Chan_Type,	 	Wv
	SetDimLabel COLS, 1, Chan_num, 		Wv
	SetDimLabel COLS, 2, FIFO_advance, 	Wv
	return Wv
End

Function/WAVE P_GetITCFIFOAvail(panelTitle)
	string panelTitle
	dfref dfr = P_DeviceSpecificPressureDFRef(panelTitle)

	Wave/Z/T/SDFR=dfr P_ITCFIFOAvail

	if(WaveExists(P_ITCFIFOAvail))
		return P_ITCFIFOAvail
	endif
	
	Make /I /o /n = (4, 4) dfr:P_ITCFIFOAvail/WAVE = Wv
	
	SetDimLabel ROWS, 0, DA, 			Wv
	SetDimLabel ROWS, 1, AD, 			Wv
	SetDimLabel ROWS, 2, TTL_R0, 		Wv
	SetDimLabel ROWS, 3, TTL_R1, 		Wv
	
	SetDimLabel COLS, 0, Chan_Type,	 	Wv
	SetDimLabel COLS, 1, Chan_num, 		Wv
	SetDimLabel COLS, 2, FIFO_advance, 	Wv
	
	Wv = 0
	Wv[0][0] = 1 // DA
	Wv[1][0] = 0 // AD
	Wv[2][0] = 3 // TTL
	Wv[3][0] = 3 // TTL
	
	Wv[2][1] = 0 // TTL rack 0
	Wv[3][1] = 3 // TTL rack 1	
	
	return Wv
End