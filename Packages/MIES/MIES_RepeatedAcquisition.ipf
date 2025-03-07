#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3 // Use modern global access method and strict wave access.
#pragma rtFunctionErrors=1

#ifdef AUTOMATED_TESTING
#pragma ModuleName=MIES_RA
#endif

/// comment in to enable repeated acquisition performance measurement code
// #define PERFING_RA

/// @file MIES_RepeatedAcquisition.ipf
/// @brief __RA__ Repated acquisition functionality

/// @brief Recalculate the Inter trial interval (ITI) for the given device.
static Function RA_RecalculateITI(panelTitle)
	string panelTitle

	variable ITI

	NVAR repurposedTime = $GetRepurposedSweepTime(panelTitle)
	ITI = DAG_GetNumericalValue(panelTitle, "SetVar_DataAcq_ITI") - DQ_StopITCDeviceTimer(panelTitle) + repurposedTime
	repurposedTime = 0

	return ITI
End

static Function RA_HandleITI_MD(panelTitle)
	string panelTitle

	variable ITI
	string funcList

	DAP_ApplyDelayedClampModeChange(panelTitle)

	ITI = RA_RecalculateITI(panelTitle)

	if(!DAG_GetNumericalValue(panelTitle, "check_Settings_ITITP") || ITI <= 0)

		funcList = "RA_CounterMD(\"" + panelTitle + "\")"

		if(ITI <= 0 && !IsBackgroundTaskRunning("ITC_TimerMD")) // we are the only device currently
			ExecuteListOfFunctions(funcList)
			return NaN
		endif

		DQM_StartBackgroundTimer(panelTitle, ITI, funcList)

		return NaN
	endif

	TPM_StartTPMultiDeviceLow(panelTitle, runModifier=TEST_PULSE_DURING_RA_MOD)

	funcList = "TPM_StopTestPulseMultiDevice(\"" + panelTitle + "\")" + ";" + "RA_CounterMD(\"" + panelTitle + "\")"
	DQM_StartBackgroundTimer(panelTitle, ITI, funcList)
End

static Function RA_WaitUntiIITIDone(panelTitle, elapsedTime)
	string panelTitle
	variable elapsedTime

	variable reftime, timeLeft
	string oscilloscopeSubwindow

	refTime = RelativeNowHighPrec()
	oscilloscopeSubwindow = SCOPE_GetGraph(panelTitle)

	do
		timeLeft = max((refTime + elapsedTime) - RelativeNowHighPrec(), 0)
		SetValDisplay(panelTitle, "valdisp_DataAcq_ITICountdown", var = timeLeft)

		DoUpdate/W=$oscilloscopeSubwindow

		if(timeLeft == 0)
			return 0
		endif
	while(!(GetKeyState(0) & ESCAPE_KEY))

	return 1
End

static Function RA_HandleITI(panelTitle)
	string panelTitle

	variable ITI, refTime, background, aborted
	string funcList

	DAP_ApplyDelayedClampModeChange(panelTitle)

	ITI = RA_RecalculateITI(panelTitle)
	background = DAG_GetNumericalValue(panelTitle, "Check_Settings_BackgrndDataAcq")
	funcList = "RA_Counter(\"" + panelTitle + "\")"

	if(!DAG_GetNumericalValue(panelTitle, "check_Settings_ITITP") || ITI <= 0)

		if(ITI <= 0)
			ExecuteListOfFunctions(funcList)
		elseif(background)
			DQS_StartBackgroundTimer(panelTitle, ITI, funcList)
		else
			aborted = RA_WaitUntiIITIDone(panelTitle, ITI)

			if(aborted)
				RA_FinishAcquisition(panelTitle)
			else
				ExecuteListOfFunctions(funcList)
			endif
		endif

		return NaN
	endif

	if(background)
		TP_Setup(panelTitle, TEST_PULSE_BG_SINGLE_DEVICE | TEST_PULSE_DURING_RA_MOD)
		TPS_StartBackgroundTestPulse(panelTitle)
		funcList = "TPS_StopTestPulseSingleDevice(\"" + panelTitle + "\")" + ";" + "RA_Counter(\"" + panelTitle + "\")"
		DQS_StartBackgroundTimer(panelTitle, ITI, funcList)
	else
		TP_Setup(panelTitle, TEST_PULSE_FG_SINGLE_DEVICE | TEST_PULSE_DURING_RA_MOD)
		aborted = TPS_StartTestPulseForeground(panelTitle, elapsedTime = ITI)
		TP_Teardown(panelTitle)

		if(aborted)
			RA_FinishAcquisition(panelTitle)
		else
			ExecuteListOfFunctions(funcList)
		endif
	endif
End

/// @brief Calculate the total number of sweeps for repeated acquisition
///
/// Helper function for plain calculation without lead and follower logic
static Function RA_GetTotalNumberOfSweepsLowLev(panelTitle)
	string panelTitle

	if(DAG_GetNumericalValue(panelTitle, "Check_DataAcq_Indexing"))
		return GetValDisplayAsNum(panelTitle, "valdisp_DataAcq_SweepsInSet")
	else
		return IDX_CalculcateActiveSetCount(panelTitle)
	endif
End

/// @brief Calculate the total number of sweeps for repeated acquisition
static Function RA_GetTotalNumberOfSweeps(panelTitle)
	string panelTitle

	variable i, numFollower, numTotalSweeps
	string followerPanelTitle

	numTotalSweeps = RA_GetTotalNumberOfSweepsLowLev(panelTitle)

	if(DeviceHasFollower(panelTitle))
		SVAR listOfFollowerDevices = $GetFollowerList(panelTitle)
		numFollower = ItemsInList(listOfFollowerDevices)
		for(i = 0; i < numFollower; i += 1)
			followerPanelTitle = StringFromList(i, listOfFollowerDevices)

			numTotalSweeps = max(numTotalSweeps, RA_GetTotalNumberOfSweepsLowLev(followerPanelTitle))
		endfor
	endif

	return numTotalSweeps
End

/// @brief Update the "Sweeps remaining" control
Function RA_StepSweepsRemaining(panelTitle)
	string panelTitle

	if(DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_RepeatAcq"))
		variable numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)
		NVAR count = $GetCount(panelTitle)

		SetValDisplay(panelTitle, "valdisp_DataAcq_TrialsCountdown", var = numTotalSweeps - count - 1)
	else
		SetValDisplay(panelTitle, "valdisp_DataAcq_TrialsCountdown", var = 0)
	endif
End

/// @brief Function gets called after the first sweep is already
/// acquired and if repeated acquisition is on
static Function RA_Start(panelTitle)
	string panelTitle
	
	variable numTotalSweeps

#ifdef PERFING_RA
	RA_PerfInitialize(panelTitle)
#endif

	numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)

	if(numTotalSweeps == 1)
		return RA_FinishAcquisition(panelTitle)
	endif

	RA_StepSweepsRemaining(panelTitle)
	RA_HandleITI(panelTitle)
End

Function RA_Counter(panelTitle)
	string panelTitle

	variable numTotalSweeps, indexing, indexingLocked
	string str

	DAP_ApplyDelayedClampModeChange(panelTitle)

	NVAR count = $GetCount(panelTitle)
	NVAR activeSetCount = $GetActiveSetCount(panelTitle)

	count += 1
	activeSetCount -= 1

#ifdef PERFING_RA
	RA_PerfAddMark(panelTitle, count)
#endif

	numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)
	indexing       = DAG_GetNumericalValue(panelTitle, "Check_DataAcq_Indexing")
	indexingLocked = DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_IndexingLocked")


	sprintf str, "count=%d, activeSetCount=%d\r" count, activeSetCount
	DEBUGPRINT(str)

	RA_StepSweepsRemaining(panelTitle)

	if(indexing)
		if(indexingLocked && activeSetcount == 0)
			IDX_IndexingDoIt(panelTitle)
		elseif(!indexingLocked)
			IDX_ApplyUnLockedIndexing(panelTitle, count)
		endif
	endif

	if(Count < numTotalSweeps)
		try
			DC_ConfigureDataForITC(panelTitle, DATA_ACQUISITION_MODE)

			if(DAG_GetNumericalValue(panelTitle, "Check_Settings_BackgrndDataAcq"))
				DQS_BkrdDataAcq(panelTitle)
			else
				DQS_DataAcq(panelTitle)
			endif
		catch
			RA_FinishAcquisition(panelTitle)
		endtry
	else
		RA_FinishAcquisition(panelTitle)
	endif
End

static Function RA_FinishAcquisition(panelTitle)
	string panelTitle

	string list
	variable numEntries, i

	DQ_StopITCDeviceTimer(panelTitle)

#ifdef PERFING_RA
	RA_PerfFinish(panelTitle)
#endif

	list = GetListofLeaderAndPossFollower(panelTitle)

	numEntries = ItemsInList(list)
	for(i = 0; i < numEntries; i += 1)
		DAP_OneTimeCallAfterDAQ(StringFromList(i, list))
	endfor
End

static Function RA_BckgTPwithCallToRACounter(panelTitle)
	string panelTitle

	variable numTotalSweeps
	NVAR count = $GetCount(panelTitle)

	numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)

	if(Count < (numTotalSweeps - 1))
		RA_HandleITI(panelTitle)
	else
		RA_FinishAcquisition(panelTitle)
	endif
End

static Function RA_StartMD(panelTitle)
	string panelTitle

	variable i, numFollower, numTotalSweeps
	string followerPanelTitle

#ifdef PERFING_RA
	RA_PerfInitialize(panelTitle)
#endif

	RA_StepSweepsRemaining(panelTitle)

	numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)

	if(numTotalSweeps == 1)
		return RA_FinishAcquisition(panelTitle)
	endif

	if(DeviceHasFollower(panelTitle))
		SVAR listOfFollowerDevices = $GetFollowerList(panelTitle)
		numFollower = ItemsInList(listOfFollowerDevices)
		for(i = 0; i < numFollower; i += 1)
			followerPanelTitle = StringFromList(i, listOfFollowerDevices)

			NVAR followerCount = $GetCount(followerPanelTitle)
			followerCount = 0

			RA_StepSweepsRemaining(followerPanelTitle)
		endfor
	endif

	RA_HandleITI_MD(panelTitle)
End

Function RA_CounterMD(panelTitle)
	string panelTitle

	variable numTotalSweeps, activeSetCountMax
	NVAR count = $GetCount(panelTitle)
	NVAR activeSetCount = $GetActiveSetCount(panelTitle)
	variable i, indexing, indexingLocked, numFollower, followerActiveSetCount
	string str, followerPanelTitle

	DAP_ApplyDelayedClampModeChange(panelTitle)

	Count += 1
	ActiveSetCount -= 1

#ifdef PERFING_RA
	RA_PerfAddMark(panelTitle, count)
#endif

	numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)
	indexing       = DAG_GetNumericalValue(panelTitle, "Check_DataAcq_Indexing")
	indexingLocked = DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_IndexingLocked")

	sprintf str, "count=%d, activeSetCount=%d\r" count, activeSetCount
	DEBUGPRINT(str)

	RA_StepSweepsRemaining(panelTitle)

	if(indexing)
		if(indexingLocked && activeSetCount == 0)
			IDX_IndexingDoIt(panelTitle)
		elseif(!indexingLocked)
			// indexing is not locked = channel indexes when set has completed all its steps
			IDX_ApplyUnLockedIndexing(panelTitle, count)
		endif
	endif

	if(DeviceHasFollower(panelTitle))

		activeSetCountMax = activeSetCount

		SVAR listOfFollowerDevices = $GetFollowerList(panelTitle)
		numFollower = ItemsInList(listOfFollowerDevices)
		for(i = 0; i < numFollower; i += 1)
			followerPanelTitle = StringFromList(i, listOfFollowerDevices)
			NVAR followerCount = $GetCount(followerPanelTitle)
			followerCount += 1

			RA_StepSweepsRemaining(followerPanelTitle)

			if(indexing)
				if(indexingLocked && activeSetCount == 0)
					IDX_IndexingDoIt(followerPanelTitle)
					followerActiveSetCount = IDX_CalculcateActiveSetCount(followerPanelTitle)
					activeSetCountMax = max(activeSetCountMax, followerActiveSetCount)
				elseif(!indexingLocked)
					// channel indexes when set has completed all its steps
					IDX_ApplyUnLockedIndexing(followerPanelTitle, count)
					followerActiveSetCount = IDX_CalculcateActiveSetCount(followerPanelTitle)
					activeSetCountMax = max(activeSetCountMax, followerActiveSetCount)
				endif
			endif
		endfor

		if(indexing)
			// set maximum on leader and all followers
			NVAR activeSetCount = $GetActiveSetCount(panelTitle)
			activeSetCount = activeSetCountMax

			for(i = 0; i < numFollower; i += 1)
				followerPanelTitle = StringFromList(i, listOfFollowerDevices)

				NVAR activeSetCount = $GetActiveSetCount(followerPanelTitle)
				activeSetCount = activeSetCountMax
			endfor
		endif
	endif

	if(count < numTotalSweeps)
		DQM_StartDAQMultiDevice(panelTitle, initialSetupReq=0)
	else
		RA_FinishAcquisition(panelTitle)
	endif
End

static Function RA_BckgTPwithCallToRACounterMD(panelTitle)
	string panelTitle

	variable numTotalSweeps
	NVAR count = $GetCount(panelTitle)

	numTotalSweeps = RA_GetTotalNumberOfSweeps(panelTitle)

	if(count < (numTotalSweeps - 1))
		RA_HandleITI_MD(panelTitle)
	else
		RA_FinishAcquisition(panelTitle)
	endif
End

static Function RA_AreLeaderAndFollowerFinished()

	variable numCandidates, i
	string listOfCandidates, candidate

	WAVE activeIDs = DQM_GetActiveDeviceIDs()

	if(DimSize(activeIDs, ROWS) == 0)
		return 1
	endif

	listOfCandidates = GetListofLeaderAndPossFollower(ITC1600_FIRST_DEVICE)
	numCandidates = ItemsInList(listOfCandidates)

	for(i = 0; i < numCandidates; i += 1)
		candidate = StringFromList(i, listOfCandidates)
		NVAR ITCDeviceIDGlobal = $GetITCDeviceIDGlobal(candidate)

		FindValue/V=(ITCDeviceIDGlobal) activeIDs
		if(V_Value != -1) // device still active
			return 0
		endif
	endfor

	return 1
End

static Function RA_YokedRAStartMD(panelTitle)
	string panelTitle

	// catches independent devices and leader with no follower
	if(!DeviceCanFollow(panelTitle) || !DeviceHasFollower(ITC1600_FIRST_DEVICE))
		RA_StartMD(panelTitle)
		return NaN
	endif

	if(RA_AreLeaderAndFollowerFinished())
		RA_StartMD(ITC1600_FIRST_DEVICE)
	endif
End

static Function RA_YokedRABckgTPCallRACounter(panelTitle)
	string panelTitle

	// catches independent devices and leader with no follower
	if(!DeviceCanFollow(panelTitle) || !DeviceHasFollower(ITC1600_FIRST_DEVICE))
		RA_BckgTPwithCallToRACounterMD(panelTitle)
		return NaN
	endif

	if(RA_AreLeaderAndFollowerFinished())
		RA_BckgTPwithCallToRACounterMD(ITC1600_FIRST_DEVICE)
	endif
End

/// @brief Return one if we are acquiring currently the very first sweep of a
///        possible repeated acquisition cycle. Zero means that we acquire a later
///        sweep than the first one in a repeated acquisition cycle.
Function RA_IsFirstSweep(panelTitle)
	string panelTitle

	NVAR count = $GetCount(panelTitle)
	return !count
End

/// @brief Allows skipping forward or backwards the sweep count during data acquistion
///
/// @param panelTitle       device
/// @param skipCount        The number of sweeps to skip (forward or backwards)
///                         during repeated acquisition
/// @param limitToSetBorder [optional, defaults to false] Limits skipCount so
///                         that we don't skip further than after the last sweep of the
///                         stimset with the most number of sweeps.
Function RA_SkipSweeps(panelTitle, skipCount, [limitToSetBorder])
	string panelTitle
	variable skipCount, limitToSetBorder

	variable numFollower, i, sweepsInSet
	string followerPanelTitle, msg

	NVAR count = $GetCount(panelTitle)
	NVAR dataAcqRunMode = $GetDataAcqRunMode(panelTitle)
	NVAR activeSetCount = $GetActiveSetCount(panelTitle)

	//Skip sweeps if, and only if, data acquisition is ongoing.
	if(dataAcqRunMode == DAQ_NOT_RUNNING)
		return NaN
	endif

	if(ParamIsDefault(limitToSetBorder))
		limitToSetBorder = 0
	else
		limitToSetBorder = !!limitToSetBorder
	endif

	sprintf msg, "skipCount (as passed) %d, limitToSetBorder %d, count %d, activeSetCount %d", skipCount, limitToSetBorder, count, activeSetCount
	DEBUGPRINT(msg)

	if(limitToSetBorder)
		skipCount = sign(skipCount) * limit(abs(skipCount), 0, activeSetCount - 1)
		activeSetCount = 1
		sprintf msg, "skipCount (clipped) %d, activeSetCount (resetted) %d", skipCount, activeSetCount
		DEBUGPRINT(msg)
	endif

	count = RA_SkipSweepCalc(panelTitle, skipCount)
	RA_StepSweepsRemaining(panelTitle)

	if(DeviceHasFollower(panelTitle))
		SVAR listOfFollowerDevices = $GetFollowerList(panelTitle)
		numFollower = ItemsInList(listOfFollowerDevices)
		for(i = 0; i < numFollower; i += 1)
			followerPanelTitle = StringFromList(i, listOfFollowerDevices)
			NVAR followerCount = $GetCount(followerPanelTitle)
			followerCount = RA_SkipSweepCalc(followerPanelTitle, skipCount)
			RA_StepSweepsRemaining(followerPanelTitle)
		endfor
	endif
End

///@brief Returns valid count after adding skipCount
///
///@param panelTitle device
///@param skipCount The number of sweeps to skip (forward or backwards) during repeated acquisition.
static Function RA_SkipSweepCalc(panelTitle, skipCount)
	string panelTitle
	variable skipCount

	string msg
	variable totSweeps

	totSweeps = RA_GetTotalNumberOfSweeps(panelTitle)
	NVAR count = $GetCount(panelTitle)

	sprintf msg, "skipCount %d, totSweeps %d, count %d", skipCount, totSweeps, count
	DEBUGPRINT(msg)

	if(DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_RepeatAcq"))
		// RA_counter and RA_counterMD increment count at initialization, -1 accounts for this and allows a skipping back to sweep 0
		return DEBUGPRINTv(min(totSweeps - 1, max(count + skipCount, -1)))
	else 
		return DEBUGPRINTv(0)
	endif
End

static Function RA_PerfInitialize(panelTitle)
	string panelTitle

	KillOrMoveToTrash(wv = GetRAPerfWave(panelTitle))
	WAVE perfWave = GetRAPerfWave(panelTitle)

	perfWave[0] = RelativeNowHighPrec()
End

static Function RA_PerfAddMark(panelTitle, idx)
	string panelTitle
	variable idx

	WAVE perfWave = GetRAPerfWave(panelTitle)

	EnsureLargeEnoughWave(perfWave, minimumSize = idx, initialValue = NaN)
	perfWave[idx] = RelativeNowHighPrec()
End

static Function RA_PerfFinish(panelTitle)
	string panelTitle

	WAVE perfWave = GetRAPerfWave(panelTitle)

	NVAR count = $GetCount(panelTitle)

	Redimension/N=(count + 1) perfWave

	if(count <= 1)
		// nothing to do
		return NaN
	endif

	perfWave[1, Dimsize(perfWave, ROWS) - 1] = perfWave[p] - perfWave[0]
	perfWave[0] = 0
	perfWave[1] = NaN

	DFREF dfr = GetWavesDataFolderDFR(perfWave)

	Duplicate perfWave, dfr:$UniqueWaveName(dfr, NameOfWave(perfWave) + "_finished")
End

/// @brief Continue DAQ if requested or stop it
///
/// @param panelTitle  device
/// @param multiDevice [optional, defaults to false] DAQ mode
Function RA_ContinueOrStop(panelTitle, [multiDevice])
	string panelTitle
	variable multiDevice

	if(ParamIsDefault(multiDevice))
		multiDevice = 0
	else
		multiDevice = !!multiDevice
	endif

	if(RA_IsFirstSweep(panelTitle))
		if(DAG_GetNumericalValue(panelTitle, "Check_DataAcq1_RepeatAcq"))
			if(multiDevice)
				RA_YokedRAStartMD(panelTitle)
			else
				RA_Start(panelTitle)
			endif
		else
			DAP_OneTimeCallAfterDAQ(panelTitle)
		endif
	else
		if(multiDevice)
			RA_YokedRABckgTPCallRACounter(panelTitle)
		else
			RA_BckgTPwithCallToRACounter(panelTitle)
		endif
	endif
End
