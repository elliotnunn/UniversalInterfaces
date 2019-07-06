{
 	File:		QuickTimeStreaming.p
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1990-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeStreaming;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMESTREAMING__}
{$SETC __QUICKTIMESTREAMING__ := 1}

{$I+}
{$SETC QuickTimeStreamingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMECOMPONENTS__}
{$I QuickTimeComponents.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	gestaltQuickTimeStreamingVersion = 'qtst';

	gestaltQuickTimeStreamingFeatures = 'qtsf';

	kQTSInfiniteDuration		= $7FFFFFFF;
	kQTSUnknownDuration			= $00000000;
	kQTSNormalForwardRate		= $00010000;
	kQTSStoppedRate				= $00000000;


TYPE
	QTSPresentationRecordPtr = ^QTSPresentationRecord;
	QTSPresentationRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTSPresentation						= ^QTSPresentationRecord;
	QTSStreamRecordPtr = ^QTSStreamRecord;
	QTSStreamRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTSStream							= ^QTSStreamRecord;
	QTSEditEntryPtr = ^QTSEditEntry;
	QTSEditEntry = RECORD
		presentationDuration:	TimeValue64;
		streamStartTime:		TimeValue64;
		streamRate:				Fixed;
	END;

	QTSEditListPtr = ^QTSEditList;
	QTSEditList = RECORD
		numEdits:				SInt32;
		edits:					ARRAY [0..0] OF QTSEditEntry;
	END;

	QTSEditListHandle					= ^QTSEditListPtr;
{-----------------------------------------
	Errors
-----------------------------------------}

CONST
	qtsBadSelectorErr			= -5400;
	qtsBadStateErr				= -5401;
	qtsBadDataErr				= -5402;						{  something is wrong with the data  }
	qtsUnsupportedDataTypeErr	= -5403;
	qtsUnsupportedRateErr		= -5404;
	qtsUnsupportedFeatureErr	= -5405;
	qtsTooMuchDataErr			= -5406;
	qtsUnknownValueErr			= -5407;
	qtsTimeoutErr				= -5408;
	qtsConnectionFailedErr		= -5420;
	qtsAddressBusyErr			= -5421;

{-----------------------------------------
	Get / Set Info
-----------------------------------------}
	kQTSGetURLLink				= 'gull';						{  QTSGetURLLinkRecord*  }

{ get and set }
	kQTSTargetBufferDurationInfo = 'bufr';						{  Fixed* in seconds; expected, not actual  }
	kQTSDurationInfo			= 'dura';						{  QTSDurationAtom*  }
	kQTSSourceTrackIDInfo		= 'otid';						{  UInt32*  }
	kQTSSourceLayerInfo			= 'olyr';						{  UInt16*  }
	kQTSSourceLanguageInfo		= 'olng';						{  UInt16*  }
	kQTSSourceTrackFlagsInfo	= 'otfl';						{  SInt32*  }
	kQTSSourceDimensionsInfo	= 'odim';						{  QTSDimensionParams*  }
	kQTSSourceVolumesInfo		= 'ovol';						{  QTSVolumesParams*  }
	kQTSSourceMatrixInfo		= 'omat';						{  MatrixRecord*  }
	kQTSSourceClipRectInfo		= 'oclp';						{  Rect*  }
	kQTSSourceGraphicsModeInfo	= 'ogrm';						{  QTSGraphicsModeParams*  }
	kQTSSourceScaleInfo			= 'oscl';						{  Point*  }
	kQTSSourceBoundingRectInfo	= 'orct';						{  Rect*  }
	kQTSSourceUserDataInfo		= 'oudt';						{  UserData  }
	kQTSSourceInputMapInfo		= 'oimp';						{  QTAtomContainer  }

{ get only }
	kQTSStatisticsInfo			= 'stat';						{  QTSStatisticsParams*  }
	kQTSMinStatusDimensionsInfo	= 'mstd';						{  QTSDimensionParams*  }
	kQTSNormalStatusDimensionsInfo = 'nstd';					{  QTSDimensionParams*  }
	kQTSTotalDataRateInfo		= 'drtt';						{  UInt32*, add to what's there  }
	kQTSTotalDataRateInInfo		= 'drti';						{  UInt32*, add to what's there  }
	kQTSTotalDataRateOutInfo	= 'drto';						{  UInt32*, add to what's there  }
	kQTSDataRateHistoryInfo		= 'drth';						{  QTSDataRateHistoryParams*  }
	kQTSLostPercentInfo			= 'lpct';						{  QTSLostPercentParams*, add to what's there  }
	kQTSMediaTypeInfo			= 'mtyp';						{  OSType*  }
	kQTSNameInfo				= 'name';						{  QTSNameParams*  }
	kQTSSampleDescriptionInfo	= 'sdsc';						{  SampleDescriptionHandle  }
	kQTSCanHandleSendDataType	= 'chsd';						{  QTSCanHandleSendDataTypeParams*  }
	kQTSAnnotationsInfo			= 'meta';						{  QTAtomContainer  }

	kQTSTargetBufferDurationTimeScale = 1000;



TYPE
	QTSDataRateHistoryParamsPtr = ^QTSDataRateHistoryParams;
	QTSDataRateHistoryParams = RECORD
		changeSeed:				UInt32;
		millisecondsBetweenElements: UInt32;
		numberOfIntervals:		UInt32;
		elements:				LongIntPtr;								{  in bits/sec; callee allocates; caller must dispose  }
	END;

	QTSCanHandleSendDataTypeParamsPtr = ^QTSCanHandleSendDataTypeParams;
	QTSCanHandleSendDataTypeParams = RECORD
		modifierTypeOrInputID:	SInt32;
		isModifierType:			BOOLEAN;
		returnedCanHandleSendDataType: BOOLEAN;							{  callee sets to true if it can handle it }
	END;

	QTSNameParamsPtr = ^QTSNameParams;
	QTSNameParams = RECORD
		maxNameLength:			SInt32;
		requestedLanguage:		SInt32;
		returnedActualLanguage:	SInt32;
		returnedName:			Ptr;									{  pascal string; caller supplies }
	END;

	QTSLostPercentParamsPtr = ^QTSLostPercentParams;
	QTSLostPercentParams = RECORD
		receivedPkts:			UInt32;
		lostPkts:				UInt32;
		percent:				Fixed;
	END;

	QTSDimensionParamsPtr = ^QTSDimensionParams;
	QTSDimensionParams = RECORD
		width:					Fixed;
		height:					Fixed;
	END;

	QTSVolumesParamsPtr = ^QTSVolumesParams;
	QTSVolumesParams = RECORD
		leftVolume:				SInt16;
		rightVolume:			SInt16;
	END;

	QTSGraphicsModeParamsPtr = ^QTSGraphicsModeParams;
	QTSGraphicsModeParams = RECORD
		graphicsMode:			SInt16;
		opColor:				RGBColor;
	END;

	QTSGetURLLinkRecordPtr = ^QTSGetURLLinkRecord;
	QTSGetURLLinkRecord = RECORD
		displayWhere:			Point;
		returnedURLLink:		Handle;
	END;

{-----------------------------------------
	Characteristics
-----------------------------------------}
{ characteristics in Movies.h work here too }

CONST
	kQTSSupportsPerStreamControlCharacteristic = 'psct';


TYPE
	QTSVideoParamsPtr = ^QTSVideoParams;
	QTSVideoParams = RECORD
		width:					Fixed;
		height:					Fixed;
		matrix:					MatrixRecord;
		gWorld:					CGrafPtr;
		gdHandle:				GDHandle;
		clip:					RgnHandle;
		graphicsMode:			INTEGER;
		opColor:				RGBColor;
	END;

	QTSAudioParamsPtr = ^QTSAudioParams;
	QTSAudioParams = RECORD
		leftVolume:				SInt16;
		rightVolume:			SInt16;
		bassLevel:				SInt16;
		trebleLevel:			SInt16;
		frequencyBandsCount:	INTEGER;
		frequencyBands:			Ptr;
		levelMeteringEnabled:	BOOLEAN;
	END;

	QTSMediaParamsPtr = ^QTSMediaParams;
	QTSMediaParams = RECORD
		v:						QTSVideoParams;
		a:						QTSAudioParams;
	END;


CONST
	kQTSMustDraw				= $08;
	kQTSAtEnd					= $10;
	kQTSPreflightDraw			= $20;
	kQTSSyncDrawing				= $40;

{ media task result flags }
	kQTSDidDraw					= $01;
	kQTSNeedsToDraw				= $04;
	kQTSDrawAgain				= $08;
	kQTSPartialDraw				= $10;

{============================================================================
		Notifications
============================================================================}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	QTSNotificationProcPtr = FUNCTION(inErr: ComponentResult; inNotificationType: OSType; inNotificationParams: UNIV Ptr; inRefCon: UNIV Ptr): ComponentResult;
{$ELSEC}
	QTSNotificationProcPtr = ProcPtr;
{$ENDC}

	QTSNotificationUPP = UniversalProcPtr;
{ ------ notification types ------ }

CONST
	kQTSNullNotification		= 'null';						{  NULL  }
	kQTSErrorNotification		= 'err ';						{  QTSErrorParams*, optional  }
	kQTSNewPresDetectedNotification = 'newp';					{  QTSNewPresDetectedParams*  }
	kQTSPresBeginChangingNotification = 'prcb';					{  NULL  }
	kQTSPresDoneChangingNotification = 'prcd';					{  NULL  }
	kQTSPresentationChangedNotification = 'prch';				{  NULL  }
	kQTSNewStreamNotification	= 'stnw';						{  QTSNewStreamParams*  }
	kQTSStreamBeginChangingNotification = 'stcb';				{  QTSStream  }
	kQTSStreamDoneChangingNotification = 'stcd';				{  QTSStream  }
	kQTSStreamChangedNotification = 'stch';						{  QTSStreamChangedParams*  }
	kQTSStreamGoneNotification	= 'stgn';						{  QTSStreamGoneParams*  }
	kQTSPreviewAckNotification	= 'pvak';						{  QTSStream  }
	kQTSPrerollAckNotification	= 'pack';						{  QTSStream  }
	kQTSStartAckNotification	= 'sack';						{  QTSStream  }
	kQTSStopAckNotification		= 'xack';						{  QTSStream  }
	kQTSStatusNotification		= 'stat';						{  QTSStatusParams*  }
	kQTSURLNotification			= 'url ';						{  QTSURLParams*  }
	kQTSDurationNotification	= 'dura';						{  QTSDurationAtom*  }
	kQTSNewPresentationNotification = 'nprs';					{  QTSPresentation  }
	kQTSPresentationGoneNotification = 'xprs';					{  QTSPresentation  }
	kQTSServerNameNotification	= 'snam';						{  const char *  }
	kQTSPresentationDoneNotification = 'pdon';					{  NULL  }
	kQTSBandwidthAlertNotification = 'bwal';					{  QTSBandwidthAlertParams*  }
	kQTSAnnotationsChangedNotification = 'meta';				{  NULL  }


{ flags for QTSErrorParams }
	kQTSFatalErrorFlag			= $00000001;


TYPE
	QTSErrorParamsPtr = ^QTSErrorParams;
	QTSErrorParams = RECORD
		errorString:			ConstCStringPtr;
		flags:					SInt32;
	END;

	QTSNewPresDetectedParamsPtr = ^QTSNewPresDetectedParams;
	QTSNewPresDetectedParams = RECORD
		data:					Ptr;
	END;

	QTSNewStreamParamsPtr = ^QTSNewStreamParams;
	QTSNewStreamParams = RECORD
		stream:					QTSStream;
	END;

	QTSStreamChangedParamsPtr = ^QTSStreamChangedParams;
	QTSStreamChangedParams = RECORD
		stream:					QTSStream;
		mediaComponent:			ComponentInstance;						{  could be NULL  }
	END;

	QTSStreamGoneParamsPtr = ^QTSStreamGoneParams;
	QTSStreamGoneParams = RECORD
		stream:					QTSStream;
	END;

	QTSStatusParamsPtr = ^QTSStatusParams;
	QTSStatusParams = RECORD
		status:					UInt32;
		statusString:			ConstCStringPtr;
		detailedStatus:			UInt32;
		detailedStatusString:	ConstCStringPtr;
	END;

	QTSInfoParamsPtr = ^QTSInfoParams;
	QTSInfoParams = RECORD
		infoType:				OSType;
		infoParams:				Ptr;
	END;

	QTSURLParamsPtr = ^QTSURLParams;
	QTSURLParams = RECORD
		urlLength:				UInt32;
		url:					ConstCStringPtr;
	END;


CONST
	kQTSBandwidthAlertNeedToStop = $01;


TYPE
	QTSBandwidthAlertParamsPtr = ^QTSBandwidthAlertParams;
	QTSBandwidthAlertParams = RECORD
		flags:					LONGINT;
		reserved:				Ptr;
	END;

{============================================================================
		Presentation
============================================================================}
{-----------------------------------------
	 Flags
-----------------------------------------}
{ flags for NewPresentationFromData }

CONST
	kQTSAutoModeFlag			= $00000001;
	kQTSDontShowStatusFlag		= $00000008;
	kQTSSendMediaFlag			= $00010000;
	kQTSReceiveMediaFlag		= $00020000;


TYPE
	QTSNewPresentationParamsPtr = ^QTSNewPresentationParams;
	QTSNewPresentationParams = RECORD
		dataType:				OSType;
		data:					Ptr;
		dataLength:				UInt32;
		editList:				QTSEditListHandle;
		flags:					SInt32;
		timeScale:				TimeScale;								{  set to 0 for default timescale  }
		mediaParams:			QTSMediaParamsPtr;
		notificationProc:		QTSNotificationUPP;
		notificationRefCon:		Ptr;
	END;

	QTSPresIdleParamsPtr = ^QTSPresIdleParams;
	QTSPresIdleParams = RECORD
		stream:					QTSStream;
		movieTimeToDisplay:		SInt64;
		flagsIn:				SInt32;
		flagsOut:				SInt32;
	END;

{-----------------------------------------
	Toolbox Init/Close
-----------------------------------------}
{ all "apps" must call this }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitializeQTS: OSErr; C;
FUNCTION TerminateQTS: OSErr; C;
{-----------------------------------------
	Presentation Functions
-----------------------------------------}
FUNCTION QTSNewPresentation({CONST}VAR inParams: QTSNewPresentationParams; VAR outPresentation: QTSPresentation): OSErr; C;
FUNCTION QTSDisposePresentation(inPresentation: QTSPresentation; inFlags: SInt32): OSErr; C;
PROCEDURE QTSPresIdle(inPresentation: QTSPresentation; VAR ioParams: QTSPresIdleParams); C;
FUNCTION QTSPresInvalidateRegion(inPresentation: QTSPresentation; inRegion: RgnHandle): OSErr; C;
{-----------------------------------------
	Presentation Configuration
-----------------------------------------}
FUNCTION QTSPresSetFlags(inPresentation: QTSPresentation; inFlags: SInt32; inFlagsMask: SInt32): OSErr; C;
FUNCTION QTSPresGetFlags(inPresentation: QTSPresentation; VAR outFlags: SInt32): OSErr; C;
FUNCTION QTSPresGetTimeBase(inPresentation: QTSPresentation; VAR outTimeBase: TimeBase): OSErr; C;
FUNCTION QTSPresGetTimeScale(inPresentation: QTSPresentation; VAR outTimeScale: TimeScale): OSErr; C;
FUNCTION QTSPresSetInfo(inPresentation: QTSPresentation; inStream: QTSStream; inSelector: OSType; ioParam: UNIV Ptr): OSErr; C;
FUNCTION QTSPresGetInfo(inPresentation: QTSPresentation; inStream: QTSStream; inSelector: OSType; ioParam: UNIV Ptr): OSErr; C;
FUNCTION QTSPresHasCharacteristic(inPresentation: QTSPresentation; inStream: QTSStream; inCharacteristic: OSType; VAR outHasIt: BOOLEAN): OSErr; C;
FUNCTION QTSPresSetNotificationProc(inPresentation: QTSPresentation; inNotificationProc: QTSNotificationUPP; inRefCon: UNIV Ptr): OSErr; C;
FUNCTION QTSPresGetNotificationProc(inPresentation: QTSPresentation; VAR outNotificationProc: QTSNotificationUPP; VAR outRefCon: UNIV Ptr): OSErr; C;
{-----------------------------------------
	Presentation Control
-----------------------------------------}
FUNCTION QTSPresPreroll(inPresentation: QTSPresentation; inStream: QTSStream; inTimeValue: UInt32; inRate: Fixed; inFlags: SInt32): OSErr; C;
FUNCTION QTSPresStart(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32): OSErr; C;
FUNCTION QTSPresSkipTo(inPresentation: QTSPresentation; inTimeValue: UInt32): OSErr; C;
FUNCTION QTSPresStop(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32): OSErr; C;
{============================================================================
		Streams
============================================================================}
{-----------------------------------------
	Stream Functions
-----------------------------------------}
FUNCTION QTSPresNewStream(inPresentation: QTSPresentation; inDataType: OSType; inData: UNIV Ptr; inDataLength: UInt32; inFlags: SInt32; VAR outStream: QTSStream): OSErr; C;
FUNCTION QTSDisposeStream(inStream: QTSStream; inFlags: SInt32): OSErr; C;
FUNCTION QTSPresGetNumStreams(inPresentation: QTSPresentation): UInt32; C;
FUNCTION QTSPresGetIndStream(inPresentation: QTSPresentation; inIndex: UInt32): QTSStream; C;
FUNCTION QTSGetStreamPresentation(inStream: QTSStream): QTSPresentation; C;
FUNCTION QTSPresSetPreferredRate(inPresentation: QTSPresentation; inRate: Fixed; inFlags: SInt32): OSErr; C;
FUNCTION QTSPresGetPreferredRate(inPresentation: QTSPresentation; VAR outRate: Fixed): OSErr; C;
FUNCTION QTSPresSetEnable(inPresentation: QTSPresentation; inStream: QTSStream; inEnableMode: BOOLEAN): OSErr; C;
FUNCTION QTSPresGetEnable(inPresentation: QTSPresentation; inStream: QTSStream; VAR outEnableMode: BOOLEAN): OSErr; C;
FUNCTION QTSPresSetPresenting(inPresentation: QTSPresentation; inStream: QTSStream; inPresentingMode: BOOLEAN): OSErr; C;
FUNCTION QTSPresGetPresenting(inPresentation: QTSPresentation; inStream: QTSStream; VAR outPresentingMode: BOOLEAN): OSErr; C;
FUNCTION QTSPresSetPlayHints(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32; inFlagsMask: SInt32): OSErr; C;
FUNCTION QTSPresGetPlayHints(inPresentation: QTSPresentation; inStream: QTSStream; VAR outFlags: SInt32): OSErr; C;
{-----------------------------------------
	Stream Spatial Functions
-----------------------------------------}
FUNCTION QTSPresSetGWorld(inPresentation: QTSPresentation; inStream: QTSStream; inGWorld: CGrafPtr; inGDHandle: GDHandle): OSErr; C;
FUNCTION QTSPresGetGWorld(inPresentation: QTSPresentation; inStream: QTSStream; VAR outGWorld: CGrafPtr; VAR outGDHandle: GDHandle): OSErr; C;
FUNCTION QTSPresSetClip(inPresentation: QTSPresentation; inStream: QTSStream; inClip: RgnHandle): OSErr; C;
FUNCTION QTSPresGetClip(inPresentation: QTSPresentation; inStream: QTSStream; VAR outClip: RgnHandle): OSErr; C;
FUNCTION QTSPresSetMatrix(inPresentation: QTSPresentation; inStream: QTSStream; {CONST}VAR inMatrix: MatrixRecord): OSErr; C;
FUNCTION QTSPresGetMatrix(inPresentation: QTSPresentation; inStream: QTSStream; VAR outMatrix: MatrixRecord): OSErr; C;
FUNCTION QTSPresSetDimensions(inPresentation: QTSPresentation; inStream: QTSStream; inWidth: Fixed; inHeight: Fixed): OSErr; C;
FUNCTION QTSPresGetDimensions(inPresentation: QTSPresentation; inStream: QTSStream; VAR outWidth: Fixed; VAR outHeight: Fixed): OSErr; C;
FUNCTION QTSPresSetGraphicsMode(inPresentation: QTSPresentation; inStream: QTSStream; inMode: INTEGER; {CONST}VAR inOpColor: RGBColor): OSErr; C;
FUNCTION QTSPresGetGraphicsMode(inPresentation: QTSPresentation; inStream: QTSStream; VAR outMode: INTEGER; VAR outOpColor: RGBColor): OSErr; C;
FUNCTION QTSPresGetPicture(inPresentation: QTSPresentation; inStream: QTSStream; VAR outPicture: PicHandle): OSErr; C;
{-----------------------------------------
	Stream Sound Functions
-----------------------------------------}
FUNCTION QTSPresSetVolumes(inPresentation: QTSPresentation; inStream: QTSStream; inLeftVolume: INTEGER; inRightVolume: INTEGER): OSErr; C;
FUNCTION QTSPresGetVolumes(inPresentation: QTSPresentation; inStream: QTSStream; VAR outLeftVolume: INTEGER; VAR outRightVolume: INTEGER): OSErr; C;

{============================================================================
		Misc
============================================================================}
{-----------------------------------------
	Statistics Utilities
-----------------------------------------}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	QTSStatHelperRecordPtr = ^QTSStatHelperRecord;
	QTSStatHelperRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTSStatHelper						= ^QTSStatHelperRecord;

CONST
	kQTSInvalidStatHelper		= 0;

{ flags for QTSStatHelperNextParams }
	kQTSStatHelperReturnPascalStringsFlag = $00000001;


TYPE
	QTSStatHelperNextParamsPtr = ^QTSStatHelperNextParams;
	QTSStatHelperNextParams = RECORD
		flags:					SInt32;
		returnedStatisticsType:	OSType;
		returnedStream:			QTSStream;
		maxStatNameLength:		UInt32;
		returnedStatName:		CStringPtr;								{  NULL if you don't want it }
		maxStatStringLength:	UInt32;
		returnedStatString:		CStringPtr;								{  NULL if you don't want it }
		maxStatUnitLength:		UInt32;
		returnedStatUnit:		CStringPtr;								{  NULL if you don't want it }
	END;

	QTSStatisticsParamsPtr = ^QTSStatisticsParams;
	QTSStatisticsParams = RECORD
		statisticsType:			OSType;
		container:				QTAtomContainer;
		parentAtom:				QTAtom;
		flags:					SInt32;
	END;

{ general statistics types }

CONST
	kQTSAllStatisticsType		= 'all ';
	kQTSShortStatisticsType		= 'shrt';
	kQTSSummaryStatisticsType	= 'summ';

{ statistics flags }
	kQTSGetNameStatisticsFlag	= $00000001;
	kQTSDontGetDataStatisticsFlag = $00000002;
	kQTSUpdateAtomsStatisticsFlag = $00000004;
	kQTSGetUnitsStatisticsFlag	= $00000008;

{ statistics atom types }
	kQTSStatisticsStreamAtomType = 'strm';
	kQTSStatisticsNameAtomType	= 'name';						{  chars only, no length or terminator  }
	kQTSStatisticsDataFormatAtomType = 'frmt';					{  OSType  }
	kQTSStatisticsDataAtomType	= 'data';
	kQTSStatisticsUnitsAtomType	= 'unit';						{  OSType  }
	kQTSStatisticsUnitsNameAtomType = 'unin';					{  chars only, no length or terminator  }

{ statistics data formats }
	kQTSStatisticsSInt32DataFormat = 'si32';
	kQTSStatisticsUInt32DataFormat = 'ui32';
	kQTSStatisticsSInt16DataFormat = 'si16';
	kQTSStatisticsUInt16DataFormat = 'ui16';
	kQTSStatisticsFixedDataFormat = 'fixd';
	kQTSStatisticsStringDataFormat = 'strg';
	kQTSStatisticsOSTypeDataFormat = 'ostp';

{ statistics units types }
	kQTSStatisticsNoUnitsType	= 0;
	kQTSStatisticsPercentUnitsType = 'pcnt';
	kQTSStatisticsBitsPerSecUnitsType = 'bps ';
	kQTSStatisticsFramesPerSecUnitsType = 'fps ';

{ specific statistics types }
	kQTSTotalDataRateStat		= 'drtt';
	kQTSTotalDataRateInStat		= 'drti';
	kQTSTotalDataRateOutStat	= 'drto';

{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTSNewStatHelper(inPresentation: QTSPresentation; inStream: QTSStream; inStatType: OSType; inFlags: SInt32; VAR outStatHelper: QTSStatHelper): OSErr; C;
FUNCTION QTSDisposeStatHelper(inStatHelper: QTSStatHelper): OSErr; C;
FUNCTION QTSStatHelperGetStats(inStatHelper: QTSStatHelper): OSErr; C;
FUNCTION QTSStatHelperResetIter(inStatHelper: QTSStatHelper): OSErr; C;
FUNCTION QTSStatHelperNext(inStatHelper: QTSStatHelper; VAR ioParams: QTSStatHelperNextParams): BOOLEAN; C;
FUNCTION QTSStatHelperGetNumStats(inStatHelper: QTSStatHelper): UInt32; C;
{ used by components to put statistics into the atom container }
FUNCTION QTSGetOrMakeStatAtomForStream(inContainer: QTAtomContainer; inStream: QTSStream; VAR outParentAtom: QTAtom): OSErr; C;
FUNCTION QTSInsertStatistic(inContainer: QTAtomContainer; inParentAtom: QTAtom; inStatType: OSType; inStatData: UNIV Ptr; inStatDataLength: UInt32; inStatDataFormat: OSType; inFlags: SInt32): OSErr; C;
FUNCTION QTSInsertStatisticName(inContainer: QTAtomContainer; inParentAtom: QTAtom; inStatType: OSType; inStatName: ConstCStringPtr; inStatNameLength: UInt32): OSErr; C;
FUNCTION QTSInsertStatisticUnits(inContainer: QTAtomContainer; inParentAtom: QTAtom; inStatType: OSType; inUnitsType: OSType; inUnitsName: ConstCStringPtr; inUnitsNameLength: UInt32): OSErr; C;
{============================================================================
		Data Formats
============================================================================}
{-----------------------------------------
	Data Types
-----------------------------------------}
{ universal data types }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kQTSNullDataType			= 'NULL';
	kQTSUnknownDataType			= 'huh?';
	kQTSAtomContainerDataType	= 'qtac';						{  QTAtomContainer  }
	kQTSAtomDataType			= 'qtat';						{  QTSAtomContainerDataStruct*  }
	kQTSAliasDataType			= 'alis';
	kQTSFileDataType			= 'fspc';

{ these data types are specific to presentations }
	kQTSRTSPDataType			= 'rtsp';
	kQTSSDPDataType				= 'sdp ';

{-----------------------------------------
	Atom IDs
-----------------------------------------}
	kQTSPresentationAID			= 'pres';
	kQTSPresentationHeaderAID	= 'phdr';						{  QTSPresentationHeaderAtom  }
	kQTSMediaStreamAID			= 'mstr';
	kQTSMediaStreamHeaderAID	= 'mshd';						{  QTSMediaStreamHeaderAtom  }
	kQTSMediaDescriptionTextAID	= 'mdes';						{  text, no length  }
	kQTSClipRectAID				= 'clip';						{  QTSClipRectAtom  }
	kQTSDurationAID				= 'dura';						{  QTSDurationAtom  }
	kQTSBufferTimeAID			= 'bufr';						{  QTSBufferTimeAtom  }


TYPE
	QTSAtomContainerDataStructPtr = ^QTSAtomContainerDataStruct;
	QTSAtomContainerDataStruct = RECORD
		container:				QTAtomContainer;
		parentAtom:				QTAtom;
	END;

{ flags for QTSPresentationHeaderAtom }

CONST
	kQTSPresHeaderTypeIsData	= $00000100;
	kQTSPresHeaderDataIsHandle	= $00000200;


TYPE
	QTSPresentationHeaderAtomPtr = ^QTSPresentationHeaderAtom;
	QTSPresentationHeaderAtom = RECORD
		versionAndFlags:		SInt32;
		conductorOrDataType:	OSType;
		dataAtomType:			OSType;									{  where the data really is }
	END;

	QTSMediaStreamHeaderAtomPtr = ^QTSMediaStreamHeaderAtom;
	QTSMediaStreamHeaderAtom = RECORD
		versionAndFlags:		SInt32;
		mediaTransportType:		OSType;
		mediaTransportDataAID:	OSType;									{  where the data really is }
	END;

	QTSBufferTimeAtomPtr = ^QTSBufferTimeAtom;
	QTSBufferTimeAtom = RECORD
		versionAndFlags:		SInt32;
		bufferTime:				Fixed;
	END;

	QTSDurationAtomPtr = ^QTSDurationAtom;
	QTSDurationAtom = RECORD
		versionAndFlags:		SInt32;
		timeScale:				TimeScale;
		duration:				TimeValue64;
	END;

	QTSClipRectAtomPtr = ^QTSClipRectAtom;
	QTSClipRectAtom = RECORD
		versionAndFlags:		SInt32;
		clipRect:				Rect;
	END;


CONST
	kQTSEmptyEditStreamStartTime = -1;



TYPE
	QTSStatus							= UInt32;

CONST
	kQTSNullStatus				= 0;
	kQTSUninitializedStatus		= 1;
	kQTSConnectingStatus		= 2;
	kQTSOpeningConnectionDetailedStatus = 3;
	kQTSMadeConnectionDetailedStatus = 4;
	kQTSNegotiatingStatus		= 5;
	kQTSGettingDescriptionDetailedStatus = 6;
	kQTSGotDescriptionDetailedStatus = 7;
	kQTSSentSetupCmdDetailedStatus = 8;
	kQTSReceivedSetupResponseDetailedStatus = 9;
	kQTSSentPlayCmdDetailedStatus = 10;
	kQTSReceivedPlayResponseDetailedStatus = 11;
	kQTSBufferingStatus			= 12;
	kQTSPlayingStatus			= 13;
	kQTSPausedStatus			= 14;
	kQTSWaitingDisconnectStatus	= 100;

{-----------------------------------------
	QuickTime Preferences Types
-----------------------------------------}
	kQTSConnectionPrefsType		= 'stcm';						{  root atom that all other atoms are contained in }
	kQTSNotUsedForProxyPrefsType = 'nopr';						{  		comma-delimited list of URLs that are never used for proxies }
	kQTSConnectionMethodPrefsType = 'mthd';						{  		connection method (OSType that matches one of the following three) }
	kQTSDirectConnectPrefsType	= 'drct';						{ 		used if direct connect (QTSDirectConnectPrefsRecord) }
	kQTSRTSPProxyPrefsType		= 'rtsp';						{ 		used if RTSP Proxy (QTSProxyPrefsRecord) }
	kQTSSOCKSPrefsType			= 'sock';						{ 		used if SOCKS Proxy (QTSProxyPrefsRecord) }


TYPE
	QTSDirectConnectPrefsRecordPtr = ^QTSDirectConnectPrefsRecord;
	QTSDirectConnectPrefsRecord = RECORD
		tcpPortID:				UInt32;
	END;

	QTSProxyPrefsRecordPtr = ^QTSProxyPrefsRecord;
	QTSProxyPrefsRecord = RECORD
		serverNameStr:			Str255;
		portID:					UInt32;
	END;



{============================================================================
		Memory Management Services
============================================================================}
{
   These routines allocate normal pointers and handles,
   but do the correct checking, etc.
   Dispose using the normal DisposePtr and DisposeHandle
   Call these routines for one time memory allocations.
   You do not need to set any hints to use these calls.
}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTSNewPtr(inByteCount: UInt32; inFlags: SInt32; VAR outFlags: SInt32): Ptr; C;
FUNCTION QTSNewHandle(inByteCount: UInt32; inFlags: SInt32; VAR outFlags: SInt32): Handle; C;
{  flags in }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kQTSMemAllocClearMem		= $00000001;
	kQTSMemAllocDontUseTempMem	= $00000002;
	kQTSMemAllocTryTempMemFirst	= $00000004;
	kQTSMemAllocDontUseSystemMem = $00000008;
	kQTSMemAllocTrySystemMemFirst = $00000010;
	kQTSMemAllocHoldMemory		= $00001000;
	kQTSMemAllocIsInterruptTime	= $01010000;					{  currently not supported for alloc }

{  flags out }
	kQTSMemAllocAllocatedInTempMem = $00000001;
	kQTSMemAllocAllocatedInSystemMem = $00000002;


TYPE
	QTSMemPtr = ^LONGINT; { an opaque 32-bit type }
{
   These routines are for buffers that will be recirculated
   you must use QTReleaseMemPtr instead of DisposePtr
   QTSReleaseMemPtr can be used at interrupt time
   but QTSAllocMemPtr currently cannot 
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTSAllocMemPtr(inByteCount: UInt32; inFlags: SInt32): QTSMemPtr; C;
PROCEDURE QTSReleaseMemPtr(inMemPtr: QTSMemPtr; inFlags: SInt32); C;

{============================================================================
		Buffer Management Services
============================================================================}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	QTSStreamBufferPtr = ^QTSStreamBuffer;
	QTSStreamBuffer = RECORD
		reserved1:				QTSStreamBufferPtr;
		reserved2:				QTSStreamBufferPtr;
		next:					QTSStreamBufferPtr;						{  next message block in a message  }
		rptr:					Ptr;									{  first byte with real data in the DataBuffer  }
		wptr:					Ptr;									{  last+1 byte with real data in the DataBuffer  }
		reserved3:				LONGINT;
		metadata:				ARRAY [0..3] OF UInt32;					{  usage defined by message sender  }
		flags:					SInt32;									{  reserved  }
	END;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTSAllocBuffer(size: SInt32): QTSStreamBufferPtr; C;
PROCEDURE QTSFreeMessage(VAR inStreamBuffer: QTSStreamBuffer); C;
FUNCTION QTSDupMessage(VAR inStreamBuffer: QTSStreamBuffer): QTSStreamBufferPtr; C;
FUNCTION QTSCopyMessage(VAR inStreamBuffer: QTSStreamBuffer): QTSStreamBufferPtr; C;
FUNCTION QTSFlattenMessage(VAR inStreamBuffer: QTSStreamBuffer): QTSStreamBufferPtr; C;
FUNCTION QTSMessageLength(VAR inStreamBuffer: QTSStreamBuffer): SInt32; C;

{============================================================================
		Misc
============================================================================}
FUNCTION QTSGetErrorString(inErrorCode: SInt32; inMaxErrorStringLength: UInt32; outErrorString: CStringPtr; inFlags: SInt32): BOOLEAN; C;

{ UPP call backs }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	uppQTSNotificationProcInfo = $00003FF0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewQTSNotificationUPP(userRoutine: QTSNotificationProcPtr): QTSNotificationUPP; { old name was NewQTSNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeQTSNotificationUPP(userUPP: QTSNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeQTSNotificationUPP(inErr: ComponentResult; inNotificationType: OSType; inNotificationParams: UNIV Ptr; inRefCon: UNIV Ptr; userRoutine: QTSNotificationUPP): ComponentResult; { old name was CallQTSNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeStreamingIncludes}

{$ENDC} {__QUICKTIMESTREAMING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
