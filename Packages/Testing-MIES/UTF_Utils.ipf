#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3 // Use modern global access method and strict wave access.

/// RemoveAllEmptyDataFolders
/// @{
Function RemoveAllEmpty_init_IGNORE()

	NewDataFolder/O root:removeMe
	NewDataFolder/O root:removeMe:X1
	NewDataFolder/O root:removeMe:X2
	NewDataFolder/O root:removeMe:X3
	NewDataFolder/O root:removeMe:X4
	NewDataFolder/O root:removeMe:X4:data
	NewDataFolder/O root:removeMe:X5
	variable/G      root:removeMe:X5:data
	NewDataFolder/O root:removeMe:X6
	string/G        root:removeMe:X6:data
	NewDataFolder/O root:removeMe:X7
	Make/O          root:removeMe:X7:data
	NewDataFolder/O root:removeMe:X8
	NewDataFolder/O root:removeMe:x8
End

Function RemoveAllEmpty_Works1()

	RemoveAllEmptyDataFolders($"")
	PASS()
End

Function RemoveAllEmpty_Works2()

	DFREF dfr = NewFreeDataFolder()
	RemoveAllEmptyDataFolders(dfr)
	PASS()
End

Function RemoveAllEmpty_Works3()

	NewDataFolder ttest
	string folder = GetDataFolder(1) + "ttest"
	RemoveAllEmptyDataFolders($folder)
	CHECK(DataFolderExists(folder))
End

Function RemoveAllEmpty_Works4()

	RemoveAllEmpty_init_IGNORE()

	DFREF dfr = root:removeMe
	RemoveAllEmptyDataFolders(dfr)
	CHECK_EQUAL_VAR(CountObjectsDFR(dfr, 4), 4)
End
/// @}

/// ReplaceWordInString
/// @{
Function AbortsEmptyFirstArg()

	try
		ReplaceWordInString("", "abcd", "abcde")
		FAIL()
	catch
		PASS()
	endtry
End

Function ReturnsUnchangedString()

	string expected = "123"
	string actual   = ReplaceWordInString("ABCD", "123", "abcd")
	CHECK_EQUAL_STR(actual, expected)
End

Function SearchesForARealWord()

	string expected = "abcd"
	string actual   = ReplaceWordInString("abc", "abcd", "123")
	CHECK_EQUAL_STR(actual, expected)
End

Function WorksWithSameWordAndRepl()

	string expected = "abcd"
	string actual   = ReplaceWordInString("abc", "abcd", "abc")
	CHECK_EQUAL_STR(actual, expected)
End

Function ReplacesOneOccurrence()

	string expected = "1 2 3"
	string actual   = ReplaceWordInString("a", "1 a 3", "2")
	CHECK_EQUAL_STR(actual, expected)
End

Function ReplacesAllOccurences()

	string expected = "1 2 3 2 5"
	string actual   = ReplaceWordInString("a", "1 a 3 a 5", "2")
	CHECK_EQUAL_STR(actual, expected)
End

Function DoesNotIgnoreCase()

	string expected = "1 2 3 A 5"
	string actual   = ReplaceWordInString("a", "1 a 3 A 5", "2")
	CHECK_EQUAL_STR(actual, expected)
End

Function ReplacesWithEmptyString()

	string expected = "b"
	string actual   = ReplaceWordInString("a ", "a b", "")
	CHECK_EQUAL_STR(actual, expected)
End
/// @}

/// ParseISO8601TimeStamp
/// @{
Function ReturnsNaNOnInvalid1()

	variable expected = NaN
	variable actual   = ParseISO8601TimeStamp("")
	CHECK_EQUAL_VAR(actual, expected)
End

Function ReturnsNaNOnInvalid2()

	variable expected = NaN
	variable actual   = ParseISO8601TimeStamp("asdklajsd")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid1()

	variable expected = 3578412052
	variable actual   = ParseISO8601TimeStamp("2017-05-23 19:20:52Z")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid2()

	variable expected = 3578412052
	variable actual   = ParseISO8601TimeStamp("2017-05-23 19:20:52")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid3()

	variable expected = 3578412052
	variable actual   = ParseISO8601TimeStamp("2017-05-23T19:20:52")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid4()

	variable expected = 3578412052
	variable actual   = ParseISO8601TimeStamp("2017-05-23T19:20:52Z")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid5()

	variable expected = 3578412052.12345678910
	variable actual   = ParseISO8601TimeStamp("2017-05-23 19:20:52.12345678910")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid6()

	variable expected = 3578412052.12345678910
	variable actual   = ParseISO8601TimeStamp("2017-05-23T19:20:52.12345678910")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid7()

	variable expected = 3578412052.12345678910
	variable actual   = ParseISO8601TimeStamp("2017-05-23T19:20:52.12345678910Z")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid8()

	variable expected = 3578412052.12345678910
	// ISO 8601 does not define decimal separator, so comma is also okay
	variable actual   = ParseISO8601TimeStamp("2017-05-23T19:20:52,12345678910")
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid9()

	variable now      = DateTimeInUTC()
	variable expected = trunc(now)
	variable actual   = ParseISO8601TimeStamp(GetIso8601TimeStamp(secondsSinceIgorEpoch = now))
	CHECK_EQUAL_VAR(actual, expected)
End

Function AcceptsValid10()

	variable now      = DateTimeInUTC()
	variable expected = now
	// DateTime currently returns three digits of precision
	variable actual   = ParseISO8601TimeStamp(GetIso8601TimeStamp(secondsSinceIgorEpoch = now, numFracSecondsDigits = 3))
	CHECK_EQUAL_VAR(actual, expected)
End

Function FailsWithLocalTimeZone()

	variable actual = ParseISO8601TimeStamp(GetIso8601TimeStamp(localtimeZone = 1))
	CHECK_EQUAL_VAR(actual, NaN)
End

/// @}

/// GetSetIntersection
/// @{
Function ExpectsSameWaveType()

	Make/Free/D data1
	Make/Free/R data2

	try
		WAVE/Z matches = GetSetIntersection(data1, data2)
		FAIL()
	catch
		PASS()
	endtry
End

Function Works1()

	Make/Free data1 = {1, 2, 3, 4}
	Make/Free data2 = {4, 5, 6}

	WAVE/Z matches = GetSetIntersection(data1, data2)
	CHECK_EQUAL_WAVES(matches, {4})
End

Function ReturnsCorrectType()

	Make/Free/D data1
	Make/Free/D data2

	WAVE matches = GetSetIntersection(data1, data2)
	CHECK_EQUAL_WAVES(data1, matches)
End

Function ReturnsInvalidWaveRefWOMatches1()

	Make/Free/D/N=0 data1
	Make/Free/D data2

	WAVE/Z matches = GetSetIntersection(data1, data2)
	CHECK_WAVE(matches, NULL_WAVE)
End

Function ReturnsInvalidWaveRefWOMatches2()

	Make/Free/D data1
	Make/Free/D/N=0 data2

	WAVE matches = GetSetIntersection(data1, data2)
	CHECK_WAVE(matches, NULL_WAVE)
End

Function ReturnsInvalidWaveRefWOMatches3()

	Make/Free/D data1 = p
	Make/Free/D data2 = -1

	WAVE matches = GetSetIntersection(data1, data2)
	CHECK_WAVE(matches, NULL_WAVE)
End
/// @}

/// DAP_GetRAAcquisitionCycleID
/// @{

static StrConstant device = "ITC18USB_DEV_0"

Function AssertOnInvalidSeed()
	NVAR rngSeed = $GetRNGSeed(device)
	rngSeed = NaN

	try
		MIES_DAP#DAP_GetRAAcquisitionCycleID(device)
		FAIL()
	catch
		PASS()
	endtry
End

Function CreatesReproducibleResults()
	NVAR rngSeed = $GetRNGSeed(device)

	rngSeed = 1
	Make/FREE/N=1024/L dataInt = MIES_DAP#DAP_GetRAAcquisitionCycleID(device)
	CHECK_EQUAL_VAR(998651135, WaveCRC(0, dataInt))

	rngSeed = 1
	Make/FREE/N=1024/D dataDouble = MIES_DAP#DAP_GetRAAcquisitionCycleID(device)

	// EqualWaves is currently (7.0.5.1) broken for different data types
	Make/FREE/B/N=1024 equal = dataInt[p] - dataDouble[p]
	CHECK_EQUAL_VAR(WaveMax(equal), 0)
	CHECK_EQUAL_VAR(WaveMin(equal), 0)
End
/// @}

/// EnsureLargeEnoughWave
/// @{
Function ELE_AbortsWOWave()

	try
		EnsureLargeEnoughWave($"")
		FAIL()
	catch
		PASS()
	endtry
End

Function ELE_AbortsInvalidDim()

	try
		Make/FREE wv
		EnsureLargeEnoughWave(wv, dimension = -1)
		FAIL()
	catch
		PASS()
	endtry
End

Function ELE_HasMinimumSize()

	Make/FREE/N=0 wv
	EnsureLargeEnoughWave(wv)
	CHECK(DimSize(wv, ROWS) > 0)
	CHECK(DimSize(wv, COLS) == 0)
End

Function ELE_InitsToZero()

	Make/FREE/N=0 wv
	EnsureLargeEnoughWave(wv)
	CHECK_EQUAL_VAR(WaveMax(wv), 0)
	CHECK_EQUAL_VAR(WaveMin(wv), 0)
End

Function ELE_KeepsExistingData()

	Make/FREE/N=(1, 2) wv
	wv[0][0] = 4711
	EnsureLargeEnoughWave(wv)
	CHECK_EQUAL_VAR(wv[0], 4711)
	CHECK_EQUAL_VAR(Sum(wv), 4711) // others default to zero
End

Function ELE_HandlesCustomInitVal()

	Make/FREE/N=0 wv
	EnsureLargeEnoughWave(wv, initialValue = NaN)
	WaveStats/M=2/Q wv
	CHECK_EQUAL_VAR(V_npnts, 0)
End

Function ELE_HandlesCustomInitValCol()

	Make/FREE/N=(1, 2, 3) wv = NaN
	EnsureLargeEnoughWave(wv, dimension = COLS, initialValue = NaN)
	WaveStats/M=2/Q wv
	CHECK_EQUAL_VAR(V_npnts, 0)
End

Function ELE_WorksForColsAsWell()

	Make/FREE/N=1 wv
	EnsureLargeEnoughWave(wv, dimension = COLS)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 1)
	CHECK(DimSize(wv, COLS) > 0)
End

Function ELE_MinimumSize1()

	Make/FREE/N=100 wv
	EnsureLargeEnoughWave(wv, minimumSize = 1)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 100)
End

Function ELE_MinimumSize2()

	Make/FREE/N=100 wv
	EnsureLargeEnoughWave(wv, minimumSize = 100)
	CHECK(DimSize(wv, ROWS) > 100)
End

Function ELE_KeepsMinimumWaveSize1()

	Make/FREE/N=(MINIMUM_WAVE_SIZE) wv
	Duplicate/FREE wv, refWave
	EnsureLargeEnoughWave(wv)
	CHECK_EQUAL_WAVES(wv, refWave)
End

Function ELE_KeepsMinimumWaveSize2()

	Make/FREE/N=(MINIMUM_WAVE_SIZE) wv
	Duplicate/FREE wv, refWave
	EnsureLargeEnoughWave(wv, minimumSize = 1)
	CHECK_EQUAL_WAVES(wv, refWave)
End

Function ELE_KeepsMinimumWaveSize3()
	// need to check that the index MINIMUM_WAVE_SIZE is now accessible
	Make/FREE/N=(MINIMUM_WAVE_SIZE) wv
	EnsureLargeEnoughWave(wv, minimumSize = MINIMUM_WAVE_SIZE)
	CHECK(DimSize(wv, ROWS) > MINIMUM_WAVE_SIZE)
End

Function ELE_Returns1WithCheckMem()
	Make/FREE/N=(MINIMUM_WAVE_SIZE) wv
	CHECK_EQUAL_VAR(EnsureLargeEnoughWave(wv, minimumSize = 2^50, checkFreeMemory = 1), 1)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), MINIMUM_WAVE_SIZE)
End

Function ELE_AbortsWithTooLargeValue()
	Make/FREE/N=(MINIMUM_WAVE_SIZE) wv

	variable err

	try
		EnsureLargeEnoughWave(wv, minimumSize = 2^50); AbortOnRTE
		FAIL()
	catch
		err = GetRTError(1)
		PASS()
	endtry
End

/// @}

/// DoAbortNow
/// @{

Function DON_WorksWithDefault()

	NVAR interactiveMode = $GetInteractiveMode()
	CHECK_EQUAL_VAR(interactiveMode, 1)

	try
		DoAbortNow("")
		FAIL()
	catch
		PASS()
	endtry
End

Function DON_WorksWithNoMsgAndInterMode()

	NVAR interactiveMode = $GetInteractiveMode()
	interactiveMode = 1

	try
		DoAbortNow("")
		FAIL()
	catch
		PASS()
	endtry
End

Function DON_WorksWithNoMsgAndNInterMode()

	NVAR interactiveMode = $GetInteractiveMode()
	interactiveMode = 0

	try
		DoAbortNow("")
		FAIL()
	catch
		PASS()
	endtry
End

Function DON_WorksWithMsgAndNInterMode()

	NVAR interactiveMode = $GetInteractiveMode()
	interactiveMode = 0

	try
		DoAbortNow("MyMessage")
		FAIL()
	catch
		PASS()
	endtry
End

// we can't test with message and interactive abort as that
// will trigger a dialog ...

/// @}

/// FloatWithMinSigDigits
/// @{
Function FMS_Aborts()

	try
		FloatWithMinSigDigits(1, numMinSignDigits = -1)
		FAIL()
	catch
		PASS()
	endtry
End

Function FMS_Works1()

	string result
	string expected

	result   = FloatWithMinSigDigits(1.23456, numMinSignDigits = 2)
	expected = "1.2"

	CHECK_EQUAL_STR(result, expected)
End

Function FMS_Works2()

	string result
	string expected

	result   = FloatWithMinSigDigits(12.3456, numMinSignDigits = 2)
	expected = "12"

	CHECK_EQUAL_STR(result, expected)
End

Function FMS_Works3()

	string result
	string expected

	result   = FloatWithMinSigDigits(12.3456, numMinSignDigits = 1)
	expected = "12"

	CHECK_EQUAL_STR(result, expected)
End
/// @}

/// NormalizeToEOL
/// @{

Function NTE_AbortsWithUnknownEOL()

	try
		NormalizeToEOL("", "a")
		FAIL()
	catch
		PASS()
	endtry
End

Function NTE_Works1()

	string eol      = "\r"
	string input    = "hi there!\r"

	string output   = NormalizeToEOL(input, eol)
	string expected = input
	CHECK_EQUAL_STR(output, expected)
End

Function NTE_Works2()

	string eol      = "\r"
	string input    = "hi there!\n\n\r"

	string output   = NormalizeToEOL(input, eol)
	string expected = "hi there!\r\r\r"
	CHECK_EQUAL_STR(output, expected)
End

Function NTE_Works3()

	string eol      = "\r"
	string input    = "hi there!\r\n\r" // CR+LF -> CR

	string output   = NormalizeToEOL(input, eol)
	string expected = "hi there!\r\r"
	CHECK_EQUAL_STR(output, expected)
End

Function NTE_Works4()

	string eol      = "\n"
	string input    = "hi there!\r\n\r" // CR+LF -> CR

	string output   = NormalizeToEOL(input, eol)
	string expected = "hi there!\n\n"
	CHECK_EQUAL_STR(output, expected)
End

/// @}

/// SearchForDuplicates
/// @{

Function SFD_AbortsWithNull()

	try
		SearchForDuplicates($"")
		FAIL()
	catch
		PASS()
	endtry
End

Function SFD_WorksWithEmptyWave()

	Make/FREE/N=0 data
	CHECK(!SearchForDuplicates(data))
End

Function SFD_WorksWithSingleEntryWave()

	Make/FREE/N=1 data = 0
	CHECK(!SearchForDuplicates(data))
End

Function SFD_Works()

	Make/FREE data = {0, 1, 2, 4, 5, 0}
	CHECK(SearchForDuplicates(data))
End

/// @}

/// ITCConfig Wave querying
/// @{

Function ITCC_WorksLegacy()

	variable type, i
	string actual, expected

	WAVE/SDFR=root:ITCWaves config = ITCChanConfigWave_legacy
	CHECK(IsValidConfigWave(config, version=0))

	WAVE/T/Z units = AFH_GetChannelUnits(config)
	CHECK_WAVE(units, TEXT_WAVE)
	// we have one TTL channel which does not have a unit
	CHECK_EQUAL_VAR(DimSize(units, ROWS) + 1, DimSize(config, ROWS))
	CHECK_EQUAL_TEXTWAVES(units, {"DA0", "DA1", "DA2", "AD0", "AD1", "AD2"})

	for(i = 0; i < 3; i += 1)
		type = ITC_XOP_CHANNEL_TYPE_DAC
		expected = StringFromList(type, ITC_CHANNEL_NAMES) + num2str(i)
		actual   = AFH_GetChannelUnit(config, i, type)
		CHECK_EQUAL_STR(expected, actual)

		type = ITC_XOP_CHANNEL_TYPE_ADC
		expected = StringFromList(type, ITC_CHANNEL_NAMES) + num2str(i)
		actual   = AFH_GetChannelUnit(config, i, type)
		CHECK_EQUAL_STR(expected, actual)
	endfor

	WAVE/Z DACs = GetDACListFromConfig(config)
	CHECK_WAVE(DACs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(DACs, {0, 1, 2}, mode = WAVE_DATA)

	WAVE/Z ADCs = GetADCListFromConfig(config)
	CHECK_WAVE(ADCs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(ADCs, {0, 1, 2}, mode = WAVE_DATA)

	WAVE/Z TTLs = GetTTLListFromConfig(config)
	CHECK_WAVE(TTLs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(TTLS, {1}, mode = WAVE_DATA)
End

Function ITCC_WorksVersion1()

	variable type, i
	string actual, expected

	WAVE/SDFR=root:ITCWaves config = ITCChanConfigWave_Version1
	CHECK(IsValidConfigWave(config, version=1))

	WAVE/T/Z units = AFH_GetChannelUnits(config)
	CHECK_WAVE(units, TEXT_WAVE)
	// we have one TTL channel which does not have a unit
	CHECK_EQUAL_VAR(DimSize(units, ROWS) + 1, DimSize(config, ROWS))
	CHECK_EQUAL_TEXTWAVES(units, {"DA0", "DA1", "DA2", "AD0", "AD1", "AD2"})

	for(i = 0; i < 3; i += 1)
		type = ITC_XOP_CHANNEL_TYPE_DAC
		expected = StringFromList(type, ITC_CHANNEL_NAMES) + num2str(i)
		actual   = AFH_GetChannelUnit(config, i, type)
		CHECK_EQUAL_STR(expected, actual)

		type = ITC_XOP_CHANNEL_TYPE_ADC
		expected = StringFromList(type, ITC_CHANNEL_NAMES) + num2str(i)
		actual   = AFH_GetChannelUnit(config, i, type)
		CHECK_EQUAL_STR(expected, actual)
	endfor

	WAVE/Z DACs = GetDACListFromConfig(config)
	CHECK_WAVE(DACs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(DACs, {0, 1, 2}, mode = WAVE_DATA)

	WAVE/Z ADCs = GetADCListFromConfig(config)
	CHECK_WAVE(ADCs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(ADCs, {0, 1, 2}, mode = WAVE_DATA)

	WAVE/Z TTLs = GetTTLListFromConfig(config)
	CHECK_WAVE(TTLs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(TTLS, {1}, mode = WAVE_DATA)
End

Function ITCC_WorksVersion2()

	variable type, i
	string actual, expected

	WAVE/SDFR=root:ITCWaves config = ITCChanConfigWave_Version2
	CHECK(IsValidConfigWave(config, version=2))

	WAVE/T/Z units = AFH_GetChannelUnits(config)
	CHECK(WaveExists(units))
	// we have one TTL channel which does not have a unit
	CHECK_EQUAL_VAR(DimSize(units, ROWS) + 1, DimSize(config, ROWS))
	CHECK_EQUAL_TEXTWAVES(units, {"DA0", "DA1", "DA2", "AD0", "AD1", "AD2"})

	for(i = 0; i < 3; i += 1)
		type = ITC_XOP_CHANNEL_TYPE_DAC
		expected = StringFromList(type, ITC_CHANNEL_NAMES) + num2str(i)
		actual   = AFH_GetChannelUnit(config, i, type)
		CHECK_EQUAL_STR(expected, actual)

		type = ITC_XOP_CHANNEL_TYPE_ADC
		expected = StringFromList(type, ITC_CHANNEL_NAMES) + num2str(i)
		actual   = AFH_GetChannelUnit(config, i, type)
		CHECK_EQUAL_STR(expected, actual)
	endfor

	WAVE/Z DACs = GetDACListFromConfig(config)
	CHECK_WAVE(DACs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(DACs, {0, 1, 2}, mode = WAVE_DATA)

	WAVE/Z ADCs = GetADCListFromConfig(config)
	CHECK_WAVE(ADCs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(ADCs, {0, 1, 2}, mode = WAVE_DATA)

	WAVE/Z TTLs = GetTTLListFromConfig(config)
	CHECK_WAVE(TTLs, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(TTLS, {1}, mode = WAVE_DATA)

	WAVE/Z DACmode = GetDACTypesFromConfig(config)
	CHECK_WAVE(DACmode, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(DACmode, {1, 2, 2}, mode = WAVE_DATA)

	WAVE/Z ADCmode = GetADCTypesFromConfig(config)
	CHECK_WAVE(ADCmode, NUMERIC_WAVE)
	CHECK_EQUAL_WAVES(ADCmode, {2, 1, 2}, mode = WAVE_DATA)
End

/// @}

/// FindIndizes
/// @{

Function FI_NumSearchWithCol1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 1)
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndLayer1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 1, startLayer = 0, endLayer = 1)
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2, 3, 4}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndLayer2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 1, startLayer = 1, endLayer = 1)
	CHECK_EQUAL_WAVES(indizes, {3, 4}, mode = WAVE_DATA)
End

Function FI_NumSearchWithCol2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 1, str = "2")
	CHECK_EQUAL_WAVES(indizes, {1, 2}, mode = WAVE_DATA)
End

Function FI_NumSearchWithCol3()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 2, var = 4711)
	CHECK_WAVE(indizes, NULL_WAVE)
End

Function FI_NumSearchWithColLabel()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, colLabel = "abcd", var = 1)
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndStr()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, colLabel = "abcd", str = "1")
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndProp1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, colLabel = "abcd", prop = PROP_NON_EMPTY)
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndProp2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, colLabel = "abcd", prop = PROP_EMPTY)
	CHECK_EQUAL_WAVES(indizes, {3, 4}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndProp3()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 1, var = 2, prop = PROP_MATCHES_VAR_BIT_MASK)
	CHECK_EQUAL_WAVES(indizes, {1, 2, 3, 4}, mode = WAVE_DATA)
End

Function FI_NumSearchWithColAndProp4()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 1, var = 2, prop = PROP_NOT_MATCHES_VAR_BIT_MASK)
	CHECK_EQUAL_WAVES(indizes, {0}, mode = WAVE_DATA)
End

Function FI_NumSearchWithRestRows()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	WAVE/Z indizes = FindIndizes(numeric, col = 1, var = 2, startRow = 2, endRow = 3)
	CHECK_EQUAL_WAVES(indizes, {2}, mode = WAVE_DATA)
End

Function FI_TextSearchWithCol1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 0, str = "text123")
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndLayer1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 0, str = "text123", startLayer = 0, endLayer = 1)
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2, 3, 4}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndLayer2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 0, str = "text123", startLayer = 1, endLayer = 1)
	CHECK_EQUAL_WAVES(indizes, {3, 4}, mode = WAVE_DATA)
End

Function FI_TextSearchWithCol2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 1, str = "2")
	CHECK_EQUAL_WAVES(indizes, {1, 2}, mode = WAVE_DATA)
End

Function FI_TextSearchWithCol3()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 2, str = "4711")
	CHECK_WAVE(indizes, NULL_WAVE)
End

Function FI_TextSearchWithColLabel()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, colLabel = "efgh", str = "text123")
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndVar()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 1, var = 2)
	CHECK_EQUAL_WAVES(indizes, {1, 2}, mode = WAVE_DATA)
End

Function FI_TextSearchIgnoresCase()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, colLabel = "efgh", str = "TEXT123")
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndProp1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, colLabel = "efgh", prop = PROP_NON_EMPTY)
	CHECK_EQUAL_WAVES(indizes, {0, 1, 2}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndProp2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, colLabel = "efgh", prop = PROP_EMPTY)
	CHECK_EQUAL_WAVES(indizes, {3, 4}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndProp3()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 1, str = "2", prop = PROP_MATCHES_VAR_BIT_MASK)
	CHECK_EQUAL_WAVES(indizes, {1, 2, 3, 4}, mode = WAVE_DATA)
End

Function FI_TextSearchWithColAndProp4()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 1, str = "2", prop = PROP_NOT_MATCHES_VAR_BIT_MASK)
	CHECK_EQUAL_WAVES(indizes, {0}, mode = WAVE_DATA)
End

Function FI_TextSearchWithRestRows()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr text

	WAVE/Z indizes = FindIndizes(text, col = 1, str = "2", startRow = 2, endRow = 3)
	CHECK_EQUAL_WAVES(indizes, {2}, mode = WAVE_DATA)
End

Function FI_AbortsWithInvalidParams1()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams2()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 1, str = "123")
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams3()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, prop = 4711)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams4()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, colLabel = "dup")
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams5()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 0, startRow = 100)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams6()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 0, endRow = 100)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams7()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 0, startRow = 3, endRow = 2)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams8()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = NaN)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams9()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, str = "NaN")
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams10()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 1, startLayer = 1)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams11()
	DFREF dfr = root:FindIndizes
	WAVE/SDFR=dfr numeric

	try
		WAVE/Z indizes = FindIndizes(numeric, col = 0, var = 1, startLayer = 100, endLayer = 100)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidParams12()

	Make/FREE/N=(1, 2, 3, 4) data
	try
		WAVE/Z indizes = FindIndizes(data, col = 0, var = 0)
		FAIL()
	catch
		PASS()
	endtry
End

Function FI_AbortsWithInvalidWave()

	try
		FindIndizes($"", col = 0, var = 0)
		FAIL()
	catch
		PASS()
	endtry
End

/// @}

/// @{
/// GetMachineEpsilon

Function EPS_WorksWithDouble()

	variable eps, type

	type = IGOR_TYPE_64BIT_FLOAT
	eps  = GetMachineEpsilon(type)
	Make/FREE/Y=(type)/N=1 ref = 1
	Make/FREE/Y=(type)/N=1 val

	val = ref[0] + eps
	CHECK_NEQ_VAR(ref[0], val[0])

	val = ref[0] + eps/2.0
	CHECK_EQUAL_VAR(ref[0], val[0])
End

Function EPS_WorksWithFloat()

	variable eps, type

	type = IGOR_TYPE_32BIT_FLOAT
	eps  = GetMachineEpsilon(type)
	Make/FREE/Y=(type)/N=1 ref = 1
	Make/FREE/Y=(type)/N=1 val

	val = ref[0] + eps
	CHECK_NEQ_VAR(ref[0], val[0])

	val = ref[0] + eps/2.0
	CHECK_EQUAL_VAR(ref[0], val[0])
End
/// @}

/// @{
/// oodDAQ regression tests

static Function oodDAQStore_IGNORE(stimset, offsets, regions, index)
	WAVE/WAVE stimset
	WAVE offsets, regions
	variable index

	DFREF dfr = root:oodDAQ

	WAVE singleStimset = stimset[0]
	Duplicate/O singleStimset, dfr:$("stimset_oodDAQ_" + num2str(index) + "_0")

	WAVE singleStimset = stimset[1]
	Duplicate/O singleStimset, dfr:$("stimset_oodDAQ_" + num2str(index) + "_1")

	Duplicate/O offsets, dfr:$("offsets_" + num2str(index))
	Duplicate/O regions, dfr:$("regions_" + num2str(index))
End

static Function/WAVE GetoodDAQ_RefWaves_IGNORE(index)
	variable index

	Make/FREE/WAVE/N=4 wv
	DFREF dfr = root:oodDAQ

	WAVE/Z/SDFR=dfr ref_stimset_0 = $("stimset_oodDAQ_" + num2str(index) + "_0")
	WAVE/Z/SDFR=dfr ref_stimset_1 = $("stimset_oodDAQ_" + num2str(index) + "_1")
	WAVE/Z/SDFR=dfr ref_offsets   = $("offsets_" + num2str(index))
	WAVE/Z/SDFR=dfr ref_regions   = $("regions_" + num2str(index))

	wv[0] = ref_stimset_0
	wv[1] = ref_stimset_1
	wv[2] = ref_offsets
	wv[3] = ref_regions

	return wv
End

Function oodDAQRegTests_0()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 0
	InitOOdDAQParams(params, stimSet, {0, 0}, 0, 0)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

Function oodDAQRegTests_1()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 1
	InitOOdDAQParams(params, stimSet, {1, 0}, 0, 0)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

Function oodDAQRegTests_2()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 2
	InitOOdDAQParams(params, stimSet, {0, 1}, 0, 0)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

Function oodDAQRegTests_3()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 3
	InitOOdDAQParams(params, stimSet, {0, 0}, 20, 0)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

Function oodDAQRegTests_4()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 4
	InitOOdDAQParams(params, stimSet, {0, 0}, 0, 20)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

Function oodDAQRegTests_5()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 5
	InitOOdDAQParams(params, stimSet, {0, 0}, 0, 0)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

Function oodDAQRegTests_6()

	variable index
	STRUCT OOdDAQParams params
	DFREF dfr = root:oodDAQ
	string panelTitle = "ITC18USB_Dev_0"
	WAVE singleStimset = root:oodDAQ:input:StimSetoodDAQ_DA_0
	Make/FREE/N=2/WAVE stimset = singleStimset

	// BEGIN CHANGE ME
	index = 6
	InitOOdDAQParams(params, stimSet, {0, 1}, 20, 30)
	// END CHANGE ME

	WAVE/WAVE stimSet = OOD_GetResultWaves(panelTitle,params)

//	oodDAQStore_IGNORE(stimSet, params.offsets, params.regions, index)
	WAVE/WAVE refWave = GetoodDAQ_RefWaves_IGNORE(index)
	CHECK_EQUAL_WAVES(refWave[0], stimset[0])
	CHECK_EQUAL_WAVES(refWave[1], stimset[1])
	CHECK_EQUAL_WAVES(refWave[2], params.offsets)
	CHECK_EQUAL_WAVES(refWave[3], params.regions)
End

/// @}

/// @name CheckActiveHeadstages
/// @{
Function HAH_ReturnsNaN()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 0
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	CHECK_EQUAL_VAR(DAP_GetHighestActiveHeadstage(panelTitle), NaN)
End

Function HAH_Works1()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 0
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	statusHS[0] = 1

	CHECK_EQUAL_VAR(DAP_GetHighestActiveHeadstage(panelTitle), 0)
End

Function HAH_Works2()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 0
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	statusHS[6] = 1

	CHECK_EQUAL_VAR(DAP_GetHighestActiveHeadstage(panelTitle), 6)
End

Function HAH_ChecksClampMode()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 1
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	try
		DAP_GetHighestActiveHeadstage(panelTitle, clampMode = NaN); AbortOnRTE
		FAIL()
	catch
		PASS()
	endtry
End

Function HAH_ReturnsNaNWithClampMode()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 0
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	CHECK_EQUAL_VAR(DAP_GetHighestActiveHeadstage(panelTitle, clampMode = I_CLAMP_MODE), NaN)
End

Function HAH_WorksWithClampMode1()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 0
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	statusHS[1, 2] = 1
	clampModes[1] = I_CLAMP_MODE
	CHECK_EQUAL_VAR(DAP_GetHighestActiveHeadstage(panelTitle, clampMode = I_CLAMP_MODE), 1)
End

Function HAH_WorksWithClampMode2()

	string panelTitle = "IGNORE"
	Make/O/N=(NUM_HEADSTAGES) statusHS = 0
	Make/O/N=(NUM_HEADSTAGES) clampModes = NaN

	statusHS[1, 6] = 1
	clampModes[] = I_CLAMP_MODE
	clampModes[6] = V_CLAMP_MODE

	CHECK_EQUAL_VAR(DAP_GetHighestActiveHeadstage(panelTitle, clampMode = V_CLAMP_MODE), 6)
End
/// @}

/// @{
/// HasOneValidEntry

Function HOV_AssertsInvalidType()

	Make/B wv
	try
		HasOneValidEntry(wv)
		FAIL()
	catch
		PASS()
	endtry
End

Function HOV_AssertsOnInvalidType()

	Make/B wv
	try
		HasOneValidEntry(wv)
		FAIL()
	catch
		PASS()
	endtry
End

Function HOV_AssertsOnEmptyWave()

	Make/D/N=0 wv
	try
		HasOneValidEntry(wv)
		FAIL()
	catch
		PASS()
	endtry
End

Function HOV_Works1()

	Make/D/N=10 wv = NaN
	CHECK(!HasOneValidEntry(wv))
End

Function HOV_Works2()

	Make/D/N=10 wv = NaN
	wv[9] = 1
	CHECK(HasOneValidEntry(wv))
End

Function HOV_Works3()

	Make/D/N=10 wv = NaN
	wv[9] = inf
	CHECK(HasOneValidEntry(wv))
End

Function HOV_Works4()

	Make/D/N=10 wv = NaN
	wv[9] = -inf
	CHECK(HasOneValidEntry(wv))
End

Function HOV_WorksWithReal()

	Make/R/N=10 wv = NaN
	wv[9] = -inf
	CHECK(HasOneValidEntry(wv))
End

Function HOV_WorksWith2D()

	Make/R/N=(10, 9) wv = NaN
	wv[2, 3] = 4711
	CHECK(HasOneValidEntry(wv))
End

/// @}

/// @{
/// GetNumFromModifyStr
/// Example string
///
/// AXTYPE:left;AXFLAG:/L=row0_col0_AD_0;CWAVE:trace1;UNITS:pA;CWAVEDF:root:MIES:HardwareDevices:ITC18USB:Device0:Data:X_3:;ISCAT:0;CATWAVE:;CATWAVEDF:;ISTFREE:0;MASTERAXIS:;HOOK:;
/// SETAXISFLAGS:/A=2/E=0/N=0;SETAXISCMD:SetAxis/A=2 row0_col0_AD_0;FONT:Arial;FONTSIZE:10;FONTSTYLE:0;RECREATION:catGap(x)=0.1;barGap(x)=0.1;grid(x)=0;log(x)=0;tick(x)=0;zero(x)=0;mirror(x)=0;
/// nticks(x)=5;font(x)="default";minor(x)=0;sep(x)=5;noLabel(x)=0;fSize(x)=0;fStyle(x)=0;highTrip(x)=10000;lowTrip(x)=0.1;logLabel(x)=3;lblMargin(x)=0;standoff(x)=0;axOffset(x)=0;axThick(x)=1;
/// gridRGB(x)=(24576,24576,65535);notation(x)=0;logTicks(x)=0;logHTrip(x)=10000;logLTrip(x)=0.0001;axRGB(x)=(0,0,0);tlblRGB(x)=(0,0,0);alblRGB(x)=(0,0,0);gridStyle(x)=0;gridHair(x)=2;zeroThick(x)=0;
/// lblPosMode(x)=1;lblPos(x)=0;lblLatPos(x)=0;lblRot(x)=0;lblLineSpacing(x)=0;tkLblRot(x)=0;useTSep(x)=0;ZisZ(x)=0;zapTZ(x)=0;zapLZ(x)=0;loglinear(x)=0;btLen(x)=0;btThick(x)=0;stLen(x)=0;stThick(x)=0;
/// ttLen(x)=0;ttThick(x)=0;ftLen(x)=0;ftThick(x)=0;tlOffset(x)=0;tlLatOffset(x)=0;freePos(x)=0;tickEnab(x)={-inf,inf};tickZap(x)={};axisEnab(x)={0.4478,0.8656};manTick(x)=0;userticks(x)=0;
/// dateInfo(x)={0,0,0};prescaleExp(x)=0;tickExp(x)=0;tickUnit(x)=1;linTkLabel(x)=0;axisOnTop(x)=0;axisEnab(x)={0.447778,0.865556};gridEnab(x)={0,1};mirrorPos(x)=1;
Function GNMS_Works1()

	string str = "abcd(efgh)={123.456}"

	CHECK_EQUAL_VAR(MIES_UTILS#GetNumFromModifyStr(str, "abcd", "{", 0), 123.456)
End

Function GNMS_Works2()

	string str = "abcd(efgh)=(123.456, 789.10)"

	CHECK_EQUAL_VAR(MIES_UTILS#GetNumFromModifyStr(str, "abcd", "(", 1), 789.10)
End

/// @}

/// @{
/// SetNumberInWaveNote
Function SNWN_AbortsOnInvalidWave()

	Wave/Z wv = $""

	try
		SetNumberInWaveNote(wv, "key", 123)
		FAIL()
	catch
		PASS()
	endtry
End

Function SNWN_AbortsOnInvalidKey()

	Make/FREE wv

	try
		SetNumberInWaveNote(wv, "", 123)
		FAIL()
	catch
		PASS()
	endtry
End

Function SNWN_ComplainsOnEmptyFormat()

	Make/FREE wv

	try
		SetNumberInWaveNote(wv, "key", 123, format="")
		FAIL()
	catch
		PASS()
	endtry
End

Function SNWN_Works()

	string expected, actual

	Make/FREE wv
	SetNumberInWaveNote(wv, "key", 123)
	expected = "key:123;"
	actual   = note(wv)
	CHECK_EQUAL_STR(expected, actual)
End

Function SNWN_WorksWithNaN()

	string expected, actual

	Make/FREE wv
	SetNumberInWaveNote(wv, "key", NaN)
	expected = "key:nan;"
	actual   = note(wv)
	CHECK_EQUAL_STR(expected, actual)
End

Function SNWN_LeavesOldEntries()

	string expected, actual, oldEntry

	Make/FREE wv
	// existing entry
	SetNumberInWaveNote(wv, "otherkey", 456)
	oldEntry = note(wv)

	SetNumberInWaveNote(wv, "key", 123)
	expected = oldEntry + "key:123;"
	actual   = note(wv)
	CHECK_EQUAL_STR(expected, actual)
End

Function SNWN_IntegerFormat()

	string expected, actual

	Make/FREE wv
	SetNumberInWaveNote(wv, "key", 123.456, format="%d")
	expected = "key:123;"
	actual   = note(wv)
	CHECK_EQUAL_STR(expected, actual)
End

Function SNWN_FloatFormat()

	string expected, actual

	Make/FREE wv
	SetNumberInWaveNote(wv, "key", 123.456, format="%.1f")
	// %f rounds
	expected = "key:123.5;"
	actual   = note(wv)
	CHECK_EQUAL_STR(expected, actual)
End

Function SNWN_FloatFormatWithZeros()

	string expected, actual

	Make/FREE wv
	SetNumberInWaveNote(wv, "key", 123.1, format="%.06f")
	// %f rounds
	expected = "key:123.100000;"
	actual   = note(wv)
	CHECK_EQUAL_STR(expected, actual)
End

/// @}

/// GetUniqueEntries*
/// @{

Function GUE_WorksWithEmpty()

	Make/N=0 wv

	WAVE/Z result = GetUniqueEntries(wv)
	CHECK_WAVE(result, NUMERIC_WAVE, minorType=FLOAT_WAVE)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 0)
End

Function GUE_WorksWithOne()

	Make/N=1 wv

	WAVE/Z result = GetUniqueEntries(wv)
	CHECK_EQUAL_WAVES(result, wv)
End

Function GUE_RemovesSpecialValues()

	Make/N=3 wv

	wv[1] = Inf
	wv[2] = NaN

	WAVE/Z result = GetUniqueEntries(wv)
	CHECK_WAVE(result, NUMERIC_WAVE, minorType=FLOAT_WAVE)
	CHECK_EQUAL_WAVES(wv, {0})
End

Function GUE_BailsOutWith2D()

	Make/N=(1, 2) wv

	try
		WAVE/Z result = GetUniqueEntries(wv)
		FAIL()
	catch
		PASS()
	endtry
End

Function GUE_WorksWithTextEmpty()

	Make/T/N=0 wv

	WAVE/Z result = GetUniqueEntries(wv)
	CHECK_WAVE(result, TEXT_WAVE)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 0)
End

Function GUE_WorksWithTextOne()

	Make/T/N=1 wv

	WAVE/Z result = GetUniqueEntries(wv)
	CHECK_EQUAL_WAVES(result, wv)
End

Function GUE_IgnoresCase()

	Make/T wv = {"a", "A"}

	WAVE/Z result = GetUniqueEntries(wv, caseSensitive=0)
	CHECK_EQUAL_TEXTWAVES(result, {"a"})
End

Function GUE_HandlesCase()

	Make/T wv = {"a", "A"}

	WAVE/Z result = GetUniqueEntries(wv, caseSensitive=1)
	CHECK_EQUAL_TEXTWAVES(result, {"a", "A"})
End

Function GUE_BailsOutWithText2D()

	Make/T/N=(1, 2) wv

	try
		WAVE/Z result = GetUniqueEntries(wv)
		FAIL()
	catch
		PASS()
	endtry
End

Function GUE_ListWorks1()

	string input, expected, result

	input = "a;A;"
	expected = "a;"

	result = GetUniqueTextEntriesFromList(input, caseSensitive=0)
	CHECK_EQUAL_STR(result, expected)
End

Function GUE_ListWorks2()

	string input, expected, result

	input = "a;A;"
	expected = input

	result = GetUniqueTextEntriesFromList(input, caseSensitive=1)
	CHECK_EQUAL_STR(result, expected)
End

Function GUE_ListWorksWithSep()

	string input, expected, result

	input = "a-A-a"
	expected = "a-A-"

	result = GetUniqueTextEntriesFromList(input, caseSensitive=1, sep="-")
	CHECK_EQUAL_STR(result, expected)
End

/// @}

/// GetListOfObjects
/// @{

// This cuts away the temporary folder in which the tests runs
Function/S TrimVolatileFolderName_IGNORE(list)
	string list

	variable pos, i, numEntries
	string str
	string result = ""

	if(strlen(list) == 0)
		return list
	endif

	numEntries = ItemsInList(list)
	for(i = 0; i < numEntries; i += 1)
		str = StringFromList(i, list)

		pos = strsearch(str, ":test", 0)

		if(pos >= 0)
			str = str[pos,inf]
		endif

		result = AddListItem(str, result, ";", inf)
	endfor

	return result
End

Function GetListOfObjectsWorks1()

	string result, expected

	NewDataFolder/O test
	NewDataFolder/O :test:test2

	DFREF dfr = $"test"

	result = GetListOfObjects(dfr, ".*", recursive = 0, fullpath = 0)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = ""
	CHECK_EQUAL_STR(result, expected)

	result = GetListOfObjects(dfr, ".*", recursive = 1, fullpath = 0)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = ""
	CHECK_EQUAL_STR(result, expected)

	result = GetListOfObjects(dfr, ".*", recursive = 1, fullpath = 1)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = ""
	CHECK_EQUAL_STR(result, expected)

	result = GetListOfObjects(dfr, ".*", recursive = 0, fullpath = 1)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = ""
	CHECK_EQUAL_STR(result, expected)
End

Function GetListOfObjectsWorks2()

	string result, expected

	NewDataFolder/O test
	NewDataFolder/O :test:test2

	DFREF dfr = $":test"
	CHECK(DataFolderExistsDFR(dfr))

	Make dfr:wv1
	Make dfr:wv2

	DFREF dfrDeep = $":test:test2"
	CHECK(DataFolderExistsDFR(dfrDeep))

	Make dfrDeep:wv3
	Make dfrDeep:wv4

	result = GetListOfObjects(dfr, ".*", recursive = 0, fullpath = 0)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = "wv1;wv2;"
	CHECK_EQUAL_STR(result, expected)

	result = GetListOfObjects(dfr, ".*", recursive = 1, fullpath = 0)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = "wv1;wv2;wv3;wv4"
	// sort order is implementation defined
	result = SortList(result)
	expected = SortList(expected)
	CHECK_EQUAL_STR(result, expected)

	result = GetListOfObjects(dfr, ".*", recursive = 1, fullpath = 1)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = ":test:wv1;:test:wv2;:test:test2:wv3;:test:test2:wv4;"
	// sort order is implementation defined
	result = SortList(result)
	expected = SortList(expected)
	CHECK_EQUAL_STR(result, expected)

	result = GetListOfObjects(dfr, ".*", recursive = 0, fullpath = 1)
	result = TrimVolatileFolderName_IGNORE(result)
	expected = ":test:wv1;:test:wv2;"
	CHECK_EQUAL_STR(result, expected)
End

// Not checked: typeFlag, matchList and waveProperty
/// @}

/// @{
/// DeleteWavePoint
Function DWP_InvalidWave()

	WAVE/Z wv = $""
	try
		DeleteWavePoint(wv, ROWS, 0)
		FAIL()
	catch
		PASS()
	endtry
End

Function DWP_InvalidDim()

	variable i

	Make/FREE/N=1 wv
	Make/FREE/N=4 fDims = {-1, 1, 2, 3, 5, NaN, Inf}

	for(i = 0; i < numpnts(fDims); i += 1)
		try
			DeleteWavePoint(wv, fDims[i], 0)
			FAIL()
		catch
			PASS()
		endtry
	endfor
End

Function DWP_InvalidIndex()

	variable i

	Make/FREE/N=1 wv
	Make/FREE/N=4 fInd = {-1, 2, NaN, Inf}

	for(i = 0; i < numpnts(fInd); i += 1)
		try
			DeleteWavePoint(wv, ROWS, fInd[i])
			FAIL()
		catch
			PASS()
		endtry
	endfor
End

Function DWP_DeleteFromEmpty()

	variable i

	Make/FREE/N=0 wv

	try
		DeleteWavePoint(wv, ROWS, 0)
		FAIL()
	catch
		PASS()
	endtry
End

Function DWP_Check1D()

	Make/FREE/N=3 wv = {0, 1, 2}
	DeleteWavePoint(wv, ROWS, 1)
	CHECK_EQUAL_WAVES(wv, {0, 2})
	DeleteWavePoint(wv, ROWS, 1)
	CHECK_EQUAL_WAVES(wv, {0})
	DeleteWavePoint(wv, ROWS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 0)
End

Function DWP_Check2D()

	Make/FREE/N=(3, 3) wv
	wv = p + DimSize(wv, COLS) * q
	DeleteWavePoint(wv, ROWS, 1)
	CHECK_EQUAL_WAVES(wv, {{0, 2}, {3, 5}, {6, 8}})
	DeleteWavePoint(wv, ROWS, 1)
	CHECK_EQUAL_WAVES(wv, {{0}, {3}, {6}})
	DeleteWavePoint(wv, ROWS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 0)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 3)

	Make/O/FREE/N=(3, 3) wv
	wv = p + DimSize(wv, COLS) * q
	DeleteWavePoint(wv, COLS, 1)
	CHECK_EQUAL_WAVES(wv, {{0, 1, 2}, {6, 7, 8}})
	DeleteWavePoint(wv, COLS, 1)
	CHECK_EQUAL_WAVES(wv, {{0, 1, 2}})
	DeleteWavePoint(wv, COLS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 0)
End

Function DWP_Check3D()

	Make/FREE/N=(3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r
	DeleteWavePoint(wv, ROWS, 1)
	CHECK_EQUAL_WAVES(wv, {{{0, 2}, {3, 5}, {6, 8}}, {{9, 11}, {12, 14}, {15, 17}}, {{18, 20}, {21, 23}, {24, 26}}})
	DeleteWavePoint(wv, ROWS, 1)
	CHECK_EQUAL_WAVES(wv, {{{0}, {3}, {6}}, {{9}, {12}, {15}}, {{18}, {21}, {24}}})
	DeleteWavePoint(wv, ROWS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 0)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 3)

	Make/O/FREE/N=(3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r
	DeleteWavePoint(wv, COLS, 1)
	CHECK_EQUAL_WAVES(wv, {{{0, 1, 2}, {6, 7, 8}}, {{9, 10, 11}, {15, 16, 17}}, {{18, 19, 20}, {24, 25, 26}}})
	DeleteWavePoint(wv, COLS, 1)
	CHECK_EQUAL_WAVES(wv, {{{0, 1, 2}}, {{9, 10, 11}}, {{18, 19, 20}}})
	DeleteWavePoint(wv, COLS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 0)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 3)

	Make/O/FREE/N=(3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r
	DeleteWavePoint(wv, LAYERS, 1)
	CHECK_EQUAL_WAVES(wv, {{{0, 1, 2}, {3, 4, 5}, {6, 7, 8}}, {{18, 19, 20}, {21, 22, 23}, {24, 25, 26}}})
	DeleteWavePoint(wv, LAYERS, 1)
	CHECK_EQUAL_WAVES(wv, {{{0, 1, 2}, {3, 4, 5}, {6, 7, 8}}})
	DeleteWavePoint(wv, LAYERS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 0)
End

Function DWP_Check4D()

	Make/FREE/N=(3, 3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r +  + DimSize(wv, COLS) * DimSize(wv, LAYERS) * DimSize(wv, CHUNKS) * s

	DeleteWavePoint(wv, ROWS, 1)
	Make/FREE/N=(2, 3, 3, 3) comp
	comp[][][][0] = {{{0, 2}, {3, 5}, {6, 8}}, {{9, 11}, {12, 14}, {15, 17}}, {{18, 20}, {21, 23}, {24, 26}}}
	comp[][][][1] = {{{27, 29}, {30, 32}, {33, 35}}, {{36, 38}, {39, 41}, {42, 44}}, {{45, 47}, {48, 50}, {51, 53}}}
	comp[][][][2] = {{{54, 56}, {57, 59}, {60, 62}}, {{63, 65}, {66, 68}, {69, 71}}, {{72, 74}, {75, 77}, {78, 80}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, ROWS, 1)
	Make/O/FREE/N=(1, 3, 3, 3) comp
	comp[][][][0] = {{{0}, {3}, {6}}, {{9}, {12}, {15}}, {{18}, {21}, {24}}}
	comp[][][][1] = {{{27}, {30}, {33}}, {{36}, {39}, {42}}, {{45}, {48}, {51}}}
	comp[][][][2] = {{{54}, {57}, {60}}, {{63}, {66}, {69}}, {{72}, {75}, {78}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, ROWS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 0)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, CHUNKS), 3)

	Make/O/FREE/N=(3, 3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r +  + DimSize(wv, COLS) * DimSize(wv, LAYERS) * DimSize(wv, CHUNKS) * s

	DeleteWavePoint(wv, COLS, 1)
	Make/O/FREE/N=(3, 2, 3, 3) comp
	comp[][][][0] = {{{0, 1, 2}, {6, 7, 8}}, {{9, 10, 11}, {15, 16, 17}}, {{18, 19, 20}, {24, 25, 26}}}
	comp[][][][1] = {{{27, 28, 29}, {33, 34, 35}}, {{36, 37, 38}, {42, 43, 44}}, {{45, 46, 47}, {51, 52, 53}}}
	comp[][][][2] = {{{54, 55, 56}, {60, 61, 62}}, {{63, 64, 65}, {69, 70, 71}}, {{72, 73, 74}, {78, 79, 80}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, COLS, 1)
	Make/O/FREE/N=(3, 1, 3, 3) comp
	comp[][][][0] = {{{0 , 1, 2}}, {{9, 10, 11}}, {{18, 19, 20}}}
	comp[][][][1] = {{{27, 28, 29}}, {{36, 37, 38}}, {{45, 46, 47}}}
	comp[][][][2] = {{{54, 55, 56}}, {{63, 64, 65}}, {{72, 73, 74}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, COLS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 0)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, CHUNKS), 3)

	Make/O/FREE/N=(3, 3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r +  + DimSize(wv, COLS) * DimSize(wv, LAYERS) * DimSize(wv, CHUNKS) * s

	DeleteWavePoint(wv, LAYERS, 1)
	Make/O/FREE/N=(3, 3, 2, 3) comp
	comp[][][][0] = {{{0, 1, 2}, {3, 4, 5}, {6, 7, 8}}, {{18, 19, 20}, {21, 22, 23}, {24, 25, 26}}}
	comp[][][][1] = {{{27, 28, 29}, {30, 31, 32}, {33, 34, 35}}, {{45, 46, 47}, {48, 49, 50}, {51, 52, 53}}}
	comp[][][][2] = {{{54, 55, 56}, {57, 58, 59}, {60, 61, 62}}, {{72, 73, 74}, {75, 76, 77}, {78, 79, 80}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, LAYERS, 1)
	Make/O/FREE/N=(3, 3, 1, 3) comp
	comp[][][][0] = {{{0, 1, 2}, {3, 4, 5}, {6, 7, 8}}}
	comp[][][][1] = {{{27, 28, 29}, {30, 31, 32}, {33, 34, 35}}}
	comp[][][][2] = {{{54, 55, 56}, {57, 58, 59}, {60, 61, 62}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, LAYERS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 0)
	CHECK_EQUAL_VAR(DimSize(wv, CHUNKS), 3)

	Make/O/FREE/N=(3, 3, 3, 3) wv
	wv = p + DimSize(wv, COLS) * q + DimSize(wv, COLS) * DimSize(wv, LAYERS) * r +  + DimSize(wv, COLS) * DimSize(wv, LAYERS) * DimSize(wv, CHUNKS) * s

	DeleteWavePoint(wv, CHUNKS, 1)
	Make/O/FREE/N=(3, 3, 3, 2) comp
	comp[][][][0] = {{{0, 1, 2}, {3, 4, 5}, {6, 7, 8}}, {{9, 10, 11}, {12, 13, 14}, {15, 16, 17}}, {{18, 19, 20}, {21, 22, 23}, {24, 25, 26}}}
	comp[][][][1] = {{{54, 55, 56}, {57, 58, 59}, {60, 61, 62}}, {{63, 64, 65}, {66, 67, 68}, {69, 70, 71}}, {{72, 73, 74}, {75, 76, 77}, {78, 79, 80}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, CHUNKS, 1)
	Make/O/FREE/N=(3, 3, 3, 1) comp
	comp[][][][0] = {{{0, 1, 2}, {3, 4, 5}, {6, 7, 8}}, {{9, 10, 11}, {12, 13, 14}, {15, 16, 17}}, {{18, 19, 20}, {21, 22, 23}, {24, 25, 26}}}
	CHECK_EQUAL_WAVES(wv, comp)

	DeleteWavePoint(wv, CHUNKS, 0)
	CHECK_EQUAL_VAR(DimSize(wv, ROWS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, COLS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, LAYERS), 3)
	CHECK_EQUAL_VAR(DimSize(wv, CHUNKS), 0)
End
/// @}

/// TextWaveToList
/// @{

/// @brief Fail due to null wave
Function TextWaveToListFail0()

	WAVE/T w=$""
	string list

	try
		list = TextWaveToList(w, ";")
		FAIL()
	catch
		PASS()
	endtry
End

/// @brief Fail due to numeric wave
Function TextWaveToListFail1()

	Make/FREE/N=1 w
	string list

	try
		list = TextWaveToList(w, ";")
		FAIL()
	catch
		PASS()
	endtry
End

/// @brief Fail due to 3D+ wave
Function TextWaveToListFail2()

	Make/FREE/T/N=(1,1,1) w
	string list

	try
		list = TextWaveToList(w, ";")
		FAIL()
	catch
		PASS()
	endtry
End

/// @brief Fail due to empty row separator
Function TextWaveToListFail3()

	Make/FREE/T/N=1 w
	string list

	try
		list = TextWaveToList(w, "")
		FAIL()
	catch
		PASS()
	endtry
End

/// @brief Fail due to empty column separator
Function TextWaveToListFail4()

	Make/FREE/T/N=1 w
	string list

	try
		list = TextWaveToList(w, ";", colSep = "")
		FAIL()
	catch
		PASS()
	endtry
End

/// @brief 1D wave zero elements
Function TextWaveToListWorks0()

	Make/FREE/T/N=0 w
	string list
	string refList = ""

	list = TextWaveToList(w, ";")
	CHECK_EQUAL_STR(list, refList)
End

/// @brief 1D wave 3 elements
Function TextWaveToListWorks1()

	Make/FREE/T/N=3 w = {"1", "2", "3"}

	string list
	string refList

	refList = "1;2;3;"
	list = TextWaveToList(w, ";")
	CHECK_EQUAL_STR(list, refList)
End

/// @brief 1D wave 3 elements, stopOnEmpty
Function TextWaveToListWorks2()

	Make/FREE/T/N=3 w = {"1", "", "3"}

	string list
	string refList

	refList = "1;"
	list = TextWaveToList(w, ";", stopOnEmpty = 1)
	CHECK_EQUAL_STR(list, refList)
End

/// @brief 2D wave 3x3 elements
Function TextWaveToListWorks3()

	Make/FREE/T/N=(3,3) w = {{"1", "2", "3"} , {"4", "5", "6"}, {"7", "8", "9"}}

	string list
	string refList

	refList = "1,4,7,;2,5,8,;3,6,9,;"
	list = TextWaveToList(w, ";")
	CHECK_EQUAL_STR(list, refList)
End

/// @brief 2D wave 3x3 elements, own column separator
Function TextWaveToListWorks4()

	Make/FREE/T/N=(3,3) w = {{"1", "2", "3"} , {"4", "5", "6"}, {"7", "8", "9"}}

	string list
	string refList

	refList = "1:4:7:;2:5:8:;3:6:9:;"
	list = TextWaveToList(w, ";", colSep = ":")
	CHECK_EQUAL_STR(list, refList)
End

/// @brief 2D wave 3x3 elements, stopOnEmpty
Function TextWaveToListWorks5()

	Make/FREE/T/N=(3,3) w = {{"", "2", "3"} , {"4", "5", "6"}, {"7", "8", "9"}}

	string list
	string refList

	// stop at first element
	refList = ""
	list = TextWaveToList(w, ";", stopOnEmpty = 1)
	CHECK_EQUAL_STR(list, refList)
	// stop at last element with partial filling
	w = {{"1", "2", "3"} , {"4", "5", "6"}, {"7", "8", ""}}
	refList = "1,4,7,;2,5,8,;3,6,;"
	list = TextWaveToList(w, ";", stopOnEmpty = 1)
	CHECK_EQUAL_STR(list, refList)
   // stop at new row
	w = {{"1", "", "3"} , {"4", "5", "6"}, {"7", "8", "9"}}
	refList = "1,4,7,;"
	list = TextWaveToList(w, ";", stopOnEmpty = 1)
	CHECK_EQUAL_STR(list, refList)
End
/// @}
