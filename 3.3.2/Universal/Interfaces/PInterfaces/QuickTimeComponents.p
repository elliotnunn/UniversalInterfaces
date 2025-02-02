{
     File:       QuickTimeComponents.p
 
     Contains:   QuickTime Interfaces.
 
     Version:    Technology: QuickTime 4.1
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1990-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMECOMPONENTS__}
{$SETC __QUICKTIMECOMPONENTS__ := 1}

{$I+}
{$SETC QuickTimeComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEMUSIC__}
{$I QuickTimeMusic.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	clockComponentType			= 'clok';
	systemTickClock				= 'tick';						{  subtype: 60ths since boot    }
	systemSecondClock			= 'seco';						{  subtype: seconds since 1904        }
	systemMillisecondClock		= 'mill';						{  subtype: 1000ths since boot        }
	systemMicrosecondClock		= 'micr';						{  subtype: 1000000ths since boot  }

	kClockRateIsLinear			= 1;
	kClockImplementsCallBacks	= 2;
	kClockCanHandleIntermittentSound = 4;						{  sound clocks only  }

{* These are Clock procedures *}
FUNCTION ClockGetTime(aClock: ComponentInstance; VAR out: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

FUNCTION ClockNewCallBack(aClock: ComponentInstance; tb: TimeBase; callBackType: INTEGER): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION ClockDisposeCallBack(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ClockCallMeWhen(aClock: ComponentInstance; cb: QTCallBack; param1: LONGINT; param2: LONGINT; param3: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION ClockCancelCallBack(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION ClockRateChanged(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION ClockTimeChanged(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION ClockSetTimeBase(aClock: ComponentInstance; tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION ClockStartStopChanged(aClock: ComponentInstance; cb: QTCallBack; startChanged: BOOLEAN; stopChanged: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION ClockGetRate(aClock: ComponentInstance; VAR rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}




CONST
	StandardCompressionType		= 'scdi';
	StandardCompressionSubType	= 'imag';
	StandardCompressionSubTypeSound = 'soun';



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SCModalFilterProcPtr = FUNCTION(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: INTEGER; refcon: LONGINT): BOOLEAN;
{$ELSEC}
	SCModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SCModalHookProcPtr = FUNCTION(theDialog: DialogRef; itemHit: INTEGER; params: UNIV Ptr; refcon: LONGINT): INTEGER;
{$ELSEC}
	SCModalHookProcPtr = ProcPtr;
{$ENDC}

	SCModalFilterUPP = UniversalProcPtr;
	SCModalHookUPP = UniversalProcPtr;
{   Preference flags. }

CONST
	scListEveryCodec			= $00000002;
	scAllowZeroFrameRate		= $00000004;
	scAllowZeroKeyFrameRate		= $00000008;
	scShowBestDepth				= $00000010;
	scUseMovableModal			= $00000020;
	scDisableFrameRateItem		= $00000040;


{   Possible test flags for setting test image. }
	scPreferCropping			= $01;
	scPreferScaling				= $02;
	scPreferScalingAndCropping	= $03;
	scDontDetermineSettingsFromTestImage = $04;


{   Dimensions of the image preview box. }
	scTestImageWidth			= 80;
	scTestImageHeight			= 80;

{   Possible items returned by hookProc. }
	scOKItem					= 1;
	scCancelItem				= 2;
	scCustomItem				= 3;

{   Result returned when user cancelled. }
	scUserCancelled				= 1;



{   Get/SetInfo structures. }


TYPE
	SCSpatialSettingsPtr = ^SCSpatialSettings;
	SCSpatialSettings = RECORD
		codecType:				CodecType;
		codec:					CodecComponent;
		depth:					INTEGER;
		spatialQuality:			CodecQ;
	END;

	SCTemporalSettingsPtr = ^SCTemporalSettings;
	SCTemporalSettings = RECORD
		temporalQuality:		CodecQ;
		frameRate:				Fixed;
		keyFrameRate:			LONGINT;
	END;

	SCDataRateSettingsPtr = ^SCDataRateSettings;
	SCDataRateSettings = RECORD
		dataRate:				LONGINT;
		frameDuration:			LONGINT;
		minSpatialQuality:		CodecQ;
		minTemporalQuality:		CodecQ;
	END;

	SCExtendedProcsPtr = ^SCExtendedProcs;
	SCExtendedProcs = RECORD
		filterProc:				SCModalFilterUPP;
		hookProc:				SCModalHookUPP;
		refcon:					LONGINT;
		customName:				Str31;
	END;

{   Get/SetInfo selectors }

CONST
	scSpatialSettingsType		= 'sptl';						{  pointer to SCSpatialSettings struct }
	scTemporalSettingsType		= 'tprl';						{  pointer to SCTemporalSettings struct }
	scDataRateSettingsType		= 'drat';						{  pointer to SCDataRateSettings struct }
	scColorTableType			= 'clut';						{  pointer to CTabHandle }
	scProgressProcType			= 'prog';						{  pointer to ProgressRecord struct }
	scExtendedProcsType			= 'xprc';						{  pointer to SCExtendedProcs struct }
	scPreferenceFlagsType		= 'pref';						{  pointer to long }
	scSettingsStateType			= 'ssta';						{  pointer to Handle }
	scSequenceIDType			= 'sequ';						{  pointer to ImageSequence }
	scWindowPositionType		= 'wndw';						{  pointer to Point }
	scCodecFlagsType			= 'cflg';						{  pointer to CodecFlags }
	scCodecSettingsType			= 'cdec';						{  pointer to Handle }
	scForceKeyValueType			= 'ksim';						{  pointer to long }
	scSoundSampleRateType		= 'ssrt';						{  pointer to UnsignedFixed }
	scSoundSampleSizeType		= 'ssss';						{  pointer to short }
	scSoundChannelCountType		= 'sscc';						{  pointer to short }
	scSoundCompressionType		= 'ssct';						{  pointer to OSType }
	scCompressionListType		= 'ctyl';						{  pointer to OSType Handle }

{   scTypeNotFoundErr returned by Get/SetInfo when type cannot be found. }



TYPE
	SCParamsPtr = ^SCParams;
	SCParams = RECORD
		flags:					LONGINT;
		theCodecType:			CodecType;
		theCodec:				CodecComponent;
		spatialQuality:			CodecQ;
		temporalQuality:		CodecQ;
		depth:					INTEGER;
		frameRate:				Fixed;
		keyFrameRate:			LONGINT;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
	END;


CONST
	scGetCompression			= 1;
	scShowMotionSettings		= $00000001;
	scSettingsChangedItem		= -1;

	scCompressFlagIgnoreIdenticalFrames = 1;

{  QTAtomTypes for atoms found in settings atom containers }
	kQTSettingsVideo			= 'vide';						{  Container for video/image compression related atoms (Get/SetInfo selectors) }
	kQTSettingsSound			= 'soun';						{  Container for sound compression related atoms (Get/SetInfo selectors) }
	kQTSettingsComponentVersion	= 'vers';						{  . Version of component that wrote settings (QTSettingsVersionAtomRecord) }

{  Format of 'vers' atom found in settings atom containers }

TYPE
	QTSettingsVersionAtomRecordPtr = ^QTSettingsVersionAtomRecord;
	QTSettingsVersionAtomRecord = RECORD
		componentVersion:		LONGINT;								{  standard compression component version }
		flags:					INTEGER;								{  low bit is 1 if little endian platform, 0 if big endian platform }
		reserved:				INTEGER;								{  should be 0 }
	END;

{* These are Progress procedures *}
FUNCTION SCGetCompressionExtended(ci: ComponentInstance; VAR params: SCParams; where: Point; filterProc: SCModalFilterUPP; hookProc: SCModalHookUPP; refcon: LONGINT; customName: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION SCPositionRect(ci: ComponentInstance; VAR rp: Rect; VAR where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION SCPositionDialog(ci: ComponentInstance; id: INTEGER; VAR where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION SCSetTestImagePictHandle(ci: ComponentInstance; testPict: PicHandle; VAR testRect: Rect; testFlags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION SCSetTestImagePictFile(ci: ComponentInstance; testFileRef: INTEGER; VAR testRect: Rect; testFlags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION SCSetTestImagePixMap(ci: ComponentInstance; testPixMap: PixMapHandle; VAR testRect: Rect; testFlags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION SCGetBestDeviceRect(ci: ComponentInstance; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

FUNCTION SCRequestImageSettings(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION SCCompressImage(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR desc: ImageDescriptionHandle; VAR data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION SCCompressPicture(ci: ComponentInstance; srcPicture: PicHandle; dstPicture: PicHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION SCCompressPictureFile(ci: ComponentInstance; srcRefNum: INTEGER; dstRefNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION SCRequestSequenceSettings(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION SCCompressSequenceBegin(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION SCCompressSequenceFrame(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR data: Handle; VAR dataSize: LONGINT; VAR notSyncFlag: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION SCCompressSequenceEnd(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION SCDefaultPictHandleSettings(ci: ComponentInstance; srcPicture: PicHandle; motion: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION SCDefaultPictFileSettings(ci: ComponentInstance; srcRef: INTEGER; motion: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION SCDefaultPixMapSettings(ci: ComponentInstance; src: PixMapHandle; motion: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION SCGetInfo(ci: ComponentInstance; infoType: OSType; info: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION SCSetInfo(ci: ComponentInstance; infoType: OSType; info: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION SCNewGWorld(ci: ComponentInstance; VAR gwp: GWorldPtr; VAR rp: Rect; flags: GWorldFlags): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION SCSetCompressFlags(ci: ComponentInstance; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION SCGetCompressFlags(ci: ComponentInstance; VAR flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION SCGetSettingsAsText(ci: ComponentInstance; VAR text: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION SCGetSettingsAsAtomContainer(ci: ComponentInstance; VAR settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION SCSetSettingsFromAtomContainer(ci: ComponentInstance; settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}




CONST
	TweenComponentType			= 'twen';


TYPE
	TweenerComponent					= ComponentInstance;
FUNCTION TweenerInitialize(tc: TweenerComponent; container: QTAtomContainer; tweenAtom: QTAtom; dataAtom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION TweenerDoTween(tc: TweenerComponent; VAR tr: TweenRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION TweenerReset(tc: TweenerComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}



CONST
	TCSourceRefNameType			= 'name';

	tcDropFrame					= $01;
	tc24HourMax					= $02;
	tcNegTimesOK				= $04;
	tcCounter					= $08;


TYPE
	TimeCodeDefPtr = ^TimeCodeDef;
	TimeCodeDef = RECORD
		flags:					LONGINT;								{  drop-frame, etc. }
		fTimeScale:				TimeScale;								{  time scale of frameDuration (eg. 2997) }
		frameDuration:			TimeValue;								{  duration of each frame (eg. 100) }
		numFrames:				SInt8;									{  frames/sec for timecode (eg. 30) OR frames/tick for counter mode }
		padding:				SInt8;									{  unused padding byte }
	END;


CONST
	tctNegFlag					= $80;							{  negative bit is in minutes }


TYPE
	TimeCodeTimePtr = ^TimeCodeTime;
	TimeCodeTime = RECORD
		hours:					SInt8;
		minutes:				SInt8;
		seconds:				SInt8;
		frames:					SInt8;
	END;

	TimeCodeCounterPtr = ^TimeCodeCounter;
	TimeCodeCounter = RECORD
		counter:				LONGINT;
	END;

	TimeCodeRecordPtr = ^TimeCodeRecord;
	TimeCodeRecord = RECORD
		CASE INTEGER OF
		0: (
			t:					TimeCodeTime;
			);
		1: (
			c:					TimeCodeCounter;
			);
	END;

	TimeCodeDescriptionPtr = ^TimeCodeDescription;
	TimeCodeDescription = RECORD
		descSize:				LONGINT;								{  standard sample description header }
		dataFormat:				LONGINT;
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		flags:					LONGINT;								{  timecode specific stuff }
		timeCodeDef:			TimeCodeDef;
		srcRef:					ARRAY [0..0] OF LONGINT;
	END;

	TimeCodeDescriptionHandle			= ^TimeCodeDescriptionPtr;

CONST
	tcdfShowTimeCode			= $01;



TYPE
	TCTextOptionsPtr = ^TCTextOptions;
	TCTextOptions = RECORD
		txFont:					INTEGER;
		txFace:					INTEGER;
		txSize:					INTEGER;
		pad:					INTEGER;								{  let's make it longword aligned - thanks..  }
		foreColor:				RGBColor;
		backColor:				RGBColor;
	END;

FUNCTION TCGetCurrentTimeCode(mh: MediaHandler; VAR frameNum: LONGINT; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord; VAR srcRefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION TCGetTimeCodeAtTime(mh: MediaHandler; mediaTime: TimeValue; VAR frameNum: LONGINT; VAR tcdef: TimeCodeDef; VAR tcdata: TimeCodeRecord; VAR srcRefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION TCTimeCodeToString(mh: MediaHandler; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord; tcStr: StringPtr): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION TCTimeCodeToFrameNumber(mh: MediaHandler; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord; VAR frameNumber: LONGINT): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION TCFrameNumberToTimeCode(mh: MediaHandler; frameNumber: LONGINT; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION TCGetSourceRef(mh: MediaHandler; tcdH: TimeCodeDescriptionHandle; VAR srefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION TCSetSourceRef(mh: MediaHandler; tcdH: TimeCodeDescriptionHandle; srefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION TCSetTimeCodeFlags(mh: MediaHandler; flags: LONGINT; flagsMask: LONGINT): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION TCGetTimeCodeFlags(mh: MediaHandler; VAR flags: LONGINT): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION TCSetDisplayOptions(mh: MediaHandler; textOptions: TCTextOptionsPtr): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}
FUNCTION TCGetDisplayOptions(mh: MediaHandler; textOptions: TCTextOptionsPtr): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010B, $7000, $A82A;
	{$ENDC}



TYPE
	MovieImportComponent				= ComponentInstance;
	MovieExportComponent				= ComponentInstance;

CONST
	MovieImportType				= 'eat ';
	MovieExportType				= 'spit';

	canMovieImportHandles		= $01;
	canMovieImportFiles			= $02;
	hasMovieImportUserInterface	= $04;
	canMovieExportHandles		= $08;
	canMovieExportFiles			= $10;
	hasMovieExportUserInterface	= $20;
	dontAutoFileMovieImport		= $40;
	canMovieExportAuxDataHandle	= $80;
	canMovieImportValidateHandles = $0100;
	canMovieImportValidateFile	= $0200;
	dontRegisterWithEasyOpen	= $0400;
	canMovieImportInPlace		= $0800;
	movieImportSubTypeIsFileExtension = $1000;
	canMovieImportPartial		= $2000;
	hasMovieImportMIMEList		= $4000;
	canMovieExportFromProcedures = $8000;
	canMovieExportValidateMovie	= $00010000;
	movieExportNeedsResourceFork = $00020000;
	canMovieImportDataReferences = $00040000;
	movieExportMustGetSourceMediaType = $00080000;
	canMovieImportWithIdle		= $00100000;
	canMovieImportValidateDataReferences = $00200000;
	reservedForUseByGraphicsImporters = $00800000;

	movieImportCreateTrack		= 1;
	movieImportInParallel		= 2;
	movieImportMustUseTrack		= 4;
	movieImportWithIdle			= 16;

	movieImportResultUsedMultipleTracks = 8;
	movieImportResultNeedIdles	= 32;
	movieImportResultComplete	= 64;

	kMovieExportTextOnly		= 0;
	kMovieExportAbsoluteTime	= 1;
	kMovieExportRelativeTime	= 2;

	kMIDIImportSilenceBefore	= $01;
	kMIDIImportSilenceAfter		= $02;
	kMIDIImport20Playable		= $04;
	kMIDIImportWantLyrics		= $08;

	kMimeInfoMimeTypeTag		= 'mime';
	kMimeInfoFileExtensionTag	= 'ext ';
	kMimeInfoDescriptionTag		= 'desc';
	kMimeInfoGroupTag			= 'grop';
	kMimeInfoDoNotOverrideExistingFileTypeAssociation = 'nofa';

	kQTFileTypeAIFF				= 'AIFF';
	kQTFileTypeAIFC				= 'AIFC';
	kQTFileTypeDVC				= 'dvc!';
	kQTFileTypeMIDI				= 'Midi';
	kQTFileTypePicture			= 'PICT';
	kQTFileTypeMovie			= 'MooV';
	kQTFileTypeText				= 'TEXT';
	kQTFileTypeWave				= 'WAVE';
	kQTFileTypeSystemSevenSound	= 'sfil';
	kQTFileTypeMuLaw			= 'ULAW';
	kQTFileTypeAVI				= 'VfW ';
	kQTFileTypeSoundDesignerII	= 'Sd2f';
	kQTFileTypeAudioCDTrack		= 'trak';
	kQTFileTypePICS				= 'PICS';
	kQTFileTypeGIF				= 'GIFf';
	kQTFileTypePNG				= 'PNGf';
	kQTFileTypeTIFF				= 'TIFF';
	kQTFileTypePhotoShop		= '8BPS';
	kQTFileTypeSGIImage			= '.SGI';
	kQTFileTypeBMP				= 'BMPf';
	kQTFileTypeJPEG				= 'JPEG';
	kQTFileTypeJFIF				= 'JPEG';
	kQTFileTypeMacPaint			= 'PNTG';
	kQTFileTypeTargaImage		= 'TPIC';
	kQTFileTypeQuickDrawGXPicture = 'qdgx';
	kQTFileTypeQuickTimeImage	= 'qtif';
	kQTFileType3DMF				= '3DMF';
	kQTFileTypeFLC				= 'FLC ';
	kQTFileTypeFlash			= 'SWFL';
	kQTFileTypeFlashPix			= 'FPix';

{  QTAtomTypes for atoms in import/export settings containers }
	kQTSettingsDVExportNTSC		= 'dvcv';						{  True is export as NTSC, false is export as PAL. (Boolean) }
	kQTSettingsDVExportLockedAudio = 'lock';					{  True if audio locked to video. (Boolean) }
	kQTSettingsEffect			= 'effe';						{  Parent atom whose contents are atoms of an effects description }
	kQTSettingsGraphicsFileImportSequence = 'sequ';				{  Parent atom of graphic file movie import component }
	kQTSettingsGraphicsFileImportSequenceEnabled = 'enab';		{  . If true, import numbered image sequence (Boolean) }
	kQTSettingsMovieExportEnableVideo = 'envi';					{  Enable exporting of video track (Boolean) }
	kQTSettingsMovieExportEnableSound = 'enso';					{  Enable exporting of sound track (Boolean) }
	kQTSettingsMovieExportSaveOptions = 'save';					{  Parent atom of save options }
	kQTSettingsMovieExportSaveForInternet = 'fast';				{  . Save for Internet }
	kQTSettingsMovieExportSaveCompressedMovie = 'cmpm';			{  . Save compressed movie resource }
	kQTSettingsMIDI				= 'MIDI';						{  MIDI import related container }
	kQTSettingsMIDISettingFlags	= 'sttg';						{  . MIDI import settings (UInt32) }
	kQTSettingsText				= 'text';						{  Text related container }
	kQTSettingsTextDescription	= 'desc';						{  . Text import settings (TextDescription record) }
	kQTSettingsTextSize			= 'size';						{  . Width/height to create during import (FixedPoint) }
	kQTSettingsTextSettingFlags	= 'sttg';						{  . Text export settings (UInt32) }
	kQTSettingsTextTimeFraction	= 'timf';						{  . Movie time fraction for export (UInt32) }
	kQTSettingsTime				= 'time';						{  Time related container }
	kQTSettingsTimeDuration		= 'dura';						{  . Time related container }
	kQTSettingsAudioCDTrack		= 'trak';						{  Audio CD track related container }
	kQTSettingsAudioCDTrackRateShift = 'rshf';					{  . Rate shift to be performed (SInt16) }





TYPE
	MovieExportGetDataParamsPtr = ^MovieExportGetDataParams;
	MovieExportGetDataParams = RECORD
		recordSize:				LONGINT;
		trackID:				LONGINT;
		sourceTimeScale:		TimeScale;
		requestedTime:			TimeValue;
		actualTime:				TimeValue;
		dataPtr:				Ptr;
		dataSize:				LONGINT;
		desc:					SampleDescriptionHandle;
		descType:				OSType;
		descSeed:				LONGINT;
		requestedSampleCount:	LONGINT;
		actualSampleCount:		LONGINT;
		durationPerSample:		TimeValue;
		sampleFlags:			LONGINT;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	MovieExportGetDataProcPtr = FUNCTION(refCon: UNIV Ptr; VAR params: MovieExportGetDataParams): OSErr;
{$ELSEC}
	MovieExportGetDataProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieExportGetPropertyProcPtr = FUNCTION(refcon: UNIV Ptr; trackID: LONGINT; propertyType: OSType; propertyValue: UNIV Ptr): OSErr;
{$ELSEC}
	MovieExportGetPropertyProcPtr = ProcPtr;
{$ENDC}


CONST
	kQTPresetsListResourceType	= 'stg#';
	kQTPresetsPlatformListResourceType = 'stgp';

	kQTPresetInfoIsDivider		= 1;


TYPE
	QTPresetInfoPtr = ^QTPresetInfo;
	QTPresetInfo = RECORD
		presetKey:				OSType;									{  unique key for this preset in presetsArray  }
		presetFlags:			UInt32;									{  flags about this preset  }
		settingsResourceType:	OSType;									{  resource type of settings resource  }
		settingsResourceID:		SInt16;									{  resource id of settings resource  }
		padding1:				SInt16;
		nameStringListID:		SInt16;									{  name string list resource id  }
		nameStringIndex:		SInt16;									{  name string index  }
		infoStringListID:		SInt16;									{  info string list resource id  }
		infoStringIndex:		SInt16;									{  info string index  }
	END;

	QTPresetListRecordPtr = ^QTPresetListRecord;
	QTPresetListRecord = RECORD
		flags:					UInt32;									{  flags for whole list  }
		count:					UInt32;									{  number of elements in presetsArray  }
		reserved:				UInt32;
		presetsArray:			ARRAY [0..0] OF QTPresetInfo;			{  info about each preset  }
	END;


CONST
	kQTMovieExportSourceInfoResourceType = 'src#';
	kQTMovieExportSourceInfoIsMediaType = $00000001;
	kQTMovieExportSourceInfoIsMediaCharacteristic = $00000002;
	kQTMovieExportSourceInfoIsSourceType = $00000004;


TYPE
	QTMovieExportSourceInfoPtr = ^QTMovieExportSourceInfo;
	QTMovieExportSourceInfo = RECORD
		mediaType:				OSType;									{  Media type of source  }
		minCount:				UInt16;									{  min number of sources of this kind required, zero if none required  }
		maxCount:				UInt16;									{  max number of sources of this kind allowed, -1 if unlimited allowed  }
		flags:					LONGINT;								{  reserved for flags  }
	END;

	QTMovieExportSourceRecordPtr = ^QTMovieExportSourceRecord;
	QTMovieExportSourceRecord = RECORD
		count:					LONGINT;
		reserved:				LONGINT;
		sourceArray:			ARRAY [0..0] OF QTMovieExportSourceInfo;
	END;

	MovieExportGetDataUPP = UniversalProcPtr;
	MovieExportGetPropertyUPP = UniversalProcPtr;

CONST
	uppSCModalFilterProcInfo = $00003FD0;
	uppSCModalHookProcInfo = $00003EE0;
	uppMovieExportGetDataProcInfo = $000003E0;
	uppMovieExportGetPropertyProcInfo = $00003FE0;

FUNCTION NewSCModalFilterUPP(userRoutine: SCModalFilterProcPtr): SCModalFilterUPP; { old name was NewSCModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSCModalHookUPP(userRoutine: SCModalHookProcPtr): SCModalHookUPP; { old name was NewSCModalHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMovieExportGetDataUPP(userRoutine: MovieExportGetDataProcPtr): MovieExportGetDataUPP; { old name was NewMovieExportGetDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMovieExportGetPropertyUPP(userRoutine: MovieExportGetPropertyProcPtr): MovieExportGetPropertyUPP; { old name was NewMovieExportGetPropertyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeSCModalFilterUPP(userUPP: SCModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSCModalHookUPP(userUPP: SCModalHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeMovieExportGetDataUPP(userUPP: MovieExportGetDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeMovieExportGetPropertyUPP(userUPP: MovieExportGetPropertyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeSCModalFilterUPP(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: INTEGER; refcon: LONGINT; userRoutine: SCModalFilterUPP): BOOLEAN; { old name was CallSCModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSCModalHookUPP(theDialog: DialogRef; itemHit: INTEGER; params: UNIV Ptr; refcon: LONGINT; userRoutine: SCModalHookUPP): INTEGER; { old name was CallSCModalHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeMovieExportGetDataUPP(refCon: UNIV Ptr; VAR params: MovieExportGetDataParams; userRoutine: MovieExportGetDataUPP): OSErr; { old name was CallMovieExportGetDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeMovieExportGetPropertyUPP(refcon: UNIV Ptr; trackID: LONGINT; propertyType: OSType; propertyValue: UNIV Ptr; userRoutine: MovieExportGetPropertyUPP): OSErr; { old name was CallMovieExportGetPropertyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION MovieImportHandle(ci: MovieImportComponent; dataH: Handle; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0020, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportFile(ci: MovieImportComponent; {CONST}VAR theFile: FSSpec; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0020, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetSampleDuration(ci: MovieImportComponent; duration: TimeValue; scale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetSampleDescription(ci: MovieImportComponent; desc: SampleDescriptionHandle; mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetMediaFile(ci: MovieImportComponent; alias: AliasHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetDimensions(ci: MovieImportComponent; width: Fixed; height: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetChunkSize(ci: MovieImportComponent; chunkSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetProgressProc(ci: MovieImportComponent; proc: MovieProgressUPP; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetAuxiliaryData(ci: MovieImportComponent; data: Handle; handleType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetFromScrap(ci: MovieImportComponent; fromScrap: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportDoUserDialog(ci: MovieImportComponent; {CONST}VAR theFile: FSSpec; theData: Handle; VAR canceled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetDuration(ci: MovieImportComponent; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportGetAuxiliaryDataType(ci: MovieImportComponent; VAR auxType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportValidate(ci: MovieImportComponent; {CONST}VAR theFile: FSSpec; theData: Handle; VAR valid: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportGetFileType(ci: MovieImportComponent; VAR fileType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportDataRef(ci: MovieImportComponent; dataRef: Handle; dataRefType: OSType; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportGetSampleDescription(ci: MovieImportComponent; VAR desc: SampleDescriptionHandle; VAR mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportGetMIMETypeList(ci: MovieImportComponent; VAR mimeInfo: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetOffsetAndLimit(ci: MovieImportComponent; offset: UInt32; limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportGetSettingsAsAtomContainer(ci: MovieImportComponent; VAR settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetSettingsFromAtomContainer(ci: MovieImportComponent; settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportSetOffsetAndLimit64(ci: MovieImportComponent; {CONST}VAR offset: wide; {CONST}VAR limit: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportIdle(ci: MovieImportComponent; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportValidateDataRef(ci: MovieImportComponent; dataRef: Handle; dataRefType: OSType; VAR valid: UInt8): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0018, $7000, $A82A;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION MovieImportGetLoadState(ci: MovieImportComponent; VAR importerLoadState: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION MovieImportGetMaxLoadedTime(ci: MovieImportComponent; VAR time: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION MovieExportToHandle(ci: MovieExportComponent; dataH: Handle; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0080, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportToFile(ci: MovieExportComponent; {CONST}VAR theFile: FSSpec; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0081, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportGetAuxiliaryData(ci: MovieExportComponent; dataH: Handle; VAR handleType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0083, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportSetProgressProc(ci: MovieExportComponent; proc: MovieProgressUPP; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0084, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportSetSampleDescription(ci: MovieExportComponent; desc: SampleDescriptionHandle; mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0085, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportDoUserDialog(ci: MovieExportComponent; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue; VAR canceled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0086, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportGetCreatorType(ci: MovieExportComponent; VAR creator: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0087, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportToDataRef(ci: MovieExportComponent; dataRef: Handle; dataRefType: OSType; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0088, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportFromProceduresToDataRef(ci: MovieExportComponent; dataRef: Handle; dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0089, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportAddDataSource(ci: MovieExportComponent; trackType: OSType; scale: TimeScale; VAR trackID: LONGINT; getPropertyProc: MovieExportGetPropertyUPP; getDataProc: MovieExportGetDataUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $008A, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportValidate(ci: MovieExportComponent; theMovie: Movie; onlyThisTrack: Track; VAR valid: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $008B, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportGetSettingsAsAtomContainer(ci: MovieExportComponent; VAR settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008C, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportSetSettingsFromAtomContainer(ci: MovieExportComponent; settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008D, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportGetFileNameExtension(ci: MovieExportComponent; VAR extension: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008E, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportGetShortFileTypeString(ci: MovieExportComponent; VAR typeString: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008F, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportGetSourceMediaType(ci: MovieExportComponent; VAR mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0090, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportSetGetMoviePropertyProc(ci: MovieExportComponent; getPropertyProc: MovieExportGetPropertyUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0091, $7000, $A82A;
	{$ENDC}
{  Text Export Display Info data structure }

TYPE
	TextDisplayDataPtr = ^TextDisplayData;
	TextDisplayData = RECORD
		displayFlags:			LONGINT;
		textJustification:		LONGINT;
		bgColor:				RGBColor;
		textBox:				Rect;
		beginHilite:			INTEGER;
		endHilite:				INTEGER;
		hiliteColor:			RGBColor;
		doHiliteColor:			BOOLEAN;
		filler:					SInt8;
		scrollDelayDur:			TimeValue;
		dropShadowOffset:		Point;
		dropShadowTransparency:	INTEGER;
	END;

	TextExportComponent					= ComponentInstance;
	GraphicImageMovieImportComponent	= ComponentInstance;
FUNCTION TextExportGetDisplayData(ci: TextExportComponent; VAR textDisplay: TextDisplayData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION TextExportGetTimeFraction(ci: TextExportComponent; VAR movieTimeFraction: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION TextExportSetTimeFraction(ci: TextExportComponent; movieTimeFraction: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION TextExportGetSettings(ci: TextExportComponent; VAR setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION TextExportSetSettings(ci: TextExportComponent; setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}

FUNCTION MIDIImportGetSettings(ci: TextExportComponent; VAR setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION MIDIImportSetSettings(ci: TextExportComponent; setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportNewGetDataAndPropertiesProcs(ci: MovieExportComponent; trackType: OSType; VAR scale: TimeScale; theMovie: Movie; theTrack: Track; startTime: TimeValue; duration: TimeValue; VAR getPropertyProc: MovieExportGetPropertyUPP; VAR getDataProc: MovieExportGetDataUPP; VAR refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION MovieExportDisposeGetDataAndPropertiesProcs(ci: MovieExportComponent; getPropertyProc: MovieExportGetPropertyUPP; getDataProc: MovieExportGetDataUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0101, $7000, $A82A;
	{$ENDC}

CONST
	movieExportUseConfiguredSettings = 'ucfg';					{  pointer to Boolean }
	movieExportWidth			= 'wdth';						{  pointer to Fixed }
	movieExportHeight			= 'hegt';						{  pointer to Fixed }
	movieExportDuration			= 'dura';						{  pointer to TimeRecord }
	movieExportVideoFilter		= 'iflt';						{  pointer to QTAtomContainer }
	movieExportTimeScale		= 'tmsc';						{  pointer to TimeScale }

FUNCTION GraphicsImageImportSetSequenceEnabled(ci: GraphicImageMovieImportComponent; enable: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImageImportGetSequenceEnabled(ci: GraphicImageMovieImportComponent; VAR enable: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}







{**************

    File Preview Components

**************}

TYPE
	pnotComponent						= ComponentInstance;

CONST
	pnotComponentWantsEvents	= 1;
	pnotComponentNeedsNoCache	= 2;

	ShowFilePreviewComponentType = 'pnot';
	CreateFilePreviewComponentType = 'pmak';

FUNCTION PreviewShowData(p: pnotComponent; dataType: OSType; data: Handle; {CONST}VAR inHere: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION PreviewMakePreview(p: pnotComponent; VAR previewType: OSType; VAR previewResult: Handle; {CONST}VAR sourceFile: FSSpec; progress: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION PreviewMakePreviewReference(p: pnotComponent; VAR previewType: OSType; VAR resID: INTEGER; {CONST}VAR sourceFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION PreviewEvent(p: pnotComponent; VAR e: EventRecord; VAR handledEvent: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}



TYPE
	DataCompressorComponent				= ComponentInstance;
	DataDecompressorComponent			= ComponentInstance;
	DataCodecComponent					= ComponentInstance;

CONST
	DataCompressorComponentType	= 'dcom';
	DataDecompressorComponentType = 'ddec';
	AppleDataCompressorSubType	= 'adec';
	zlibDataCompressorSubType	= 'zlib';


{* These are DataCodec procedures *}
FUNCTION DataCodecDecompress(dc: DataCodecComponent; srcData: UNIV Ptr; srcSize: UInt32; dstData: UNIV Ptr; dstBufferSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION DataCodecGetCompressBufferSize(dc: DataCodecComponent; srcSize: UInt32; VAR dstSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION DataCodecCompress(dc: DataCodecComponent; srcData: UNIV Ptr; srcSize: UInt32; dstData: UNIV Ptr; dstBufferSize: UInt32; VAR actualDstSize: UInt32; VAR decompressSlop: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION DataCodecBeginInterruptSafe(dc: DataCodecComponent; maxSrcSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION DataCodecEndInterruptSafe(dc: DataCodecComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION DataCodecDecompressPartial(dc: DataCodecComponent; VAR next_in: UNIV Ptr; VAR avail_in: UInt32; VAR total_in: UInt32; VAR next_out: UNIV Ptr; VAR avail_out: UInt32; VAR total_out: UInt32; VAR didFinish: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION DataCodecCompressPartial(dc: DataCodecComponent; VAR next_in: UNIV Ptr; VAR avail_in: UInt32; VAR total_in: UInt32; VAR next_out: UNIV Ptr; VAR avail_out: UInt32; VAR total_out: UInt32; tryToFinish: BOOLEAN; VAR didFinish: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001E, $0007, $7000, $A82A;
	{$ENDC}




TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DataHCompletionProcPtr = PROCEDURE(request: Ptr; refcon: LONGINT; err: OSErr);
{$ELSEC}
	DataHCompletionProcPtr = ProcPtr;
{$ENDC}

	DataHCompletionUPP = UniversalProcPtr;


CONST
	kDataHCanRead				= $00000001;
	kDataHSpecialRead			= $00000002;
	kDataHSpecialReadFile		= $00000004;
	kDataHCanWrite				= $00000008;
	kDataHSpecialWrite			= $10;
	kDataHSpecialWriteFile		= $20;
	kDataHCanStreamingWrite		= $40;
	kDataHMustCheckDataRef		= $80;

{  Data reference extensions }
	kDataRefExtensionChokeSpeed	= 'chok';
	kDataRefExtensionMIMEType	= 'mime';
	kDataRefExtensionMacOSFileType = 'ftyp';
	kDataRefExtensionInitializationData = 'data';


	kDataHChokeToMovieDataRate	= $01;							{  param is 0 }
	kDataHChokeToParam			= $02;							{  param is bytes per second }


TYPE
	DataHChokeAtomRecordPtr = ^DataHChokeAtomRecord;
	DataHChokeAtomRecord = RECORD
		flags:					LONGINT;								{  one of kDataHChokeTo constants }
		param:					LONGINT;
	END;


	DataHVolumeListRecordPtr = ^DataHVolumeListRecord;
	DataHVolumeListRecord = RECORD
		vRefNum:				INTEGER;
		flags:					LONGINT;
	END;

	DataHVolumeListPtr					= ^DataHVolumeListRecord;
	DataHVolumeList						= ^DataHVolumeListPtr;

CONST
	kDataHExtendedSchedule		= 'xtnd';


TYPE
	DataHScheduleRecordPtr = ^DataHScheduleRecord;
	DataHScheduleRecord = RECORD
		timeNeededBy:			TimeRecord;
		extendedID:				LONGINT;								{  always is kDataHExtendedSchedule }
		extendedVers:			LONGINT;								{  always set to 0 }
		priority:				Fixed;									{  100.0 or more means must have. lower numbers… }
	END;

	DataHSchedulePtr					= ^DataHScheduleRecord;
{  Flags for DataHGetInfoFlags }

CONST
	kDataHInfoFlagNeverStreams	= $01;							{  set if this data handler doesn't stream }
	kDataHInfoFlagCanUpdateDataRefs = $02;						{  set if this data handler might update data reference }
	kDataHInfoFlagNeedsNetworkBandwidth = $04;					{  set if this data handler may need to occupy the network }




FUNCTION DataHGetData(dh: DataHandler; h: Handle; hOffset: LONGINT; offset: LONGINT; size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION DataHPutData(dh: DataHandler; h: Handle; hOffset: LONGINT; VAR offset: LONGINT; size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION DataHFlushData(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION DataHOpenForWrite(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION DataHCloseForWrite(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}

FUNCTION DataHOpenForRead(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION DataHCloseForRead(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetDataRef(dh: DataHandler; dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetDataRef(dh: DataHandler; VAR dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION DataHCompareDataRef(dh: DataHandler; dataRef: Handle; VAR equal: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION DataHTask(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION DataHScheduleData(dh: DataHandler; PlaceToPutDataPtr: Ptr; FileOffset: LONGINT; DataSize: LONGINT; RefCon: LONGINT; scheduleRec: DataHSchedulePtr; CompletionRtn: DataHCompletionUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION DataHFinishData(dh: DataHandler; PlaceToPutDataPtr: Ptr; Cancel: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION DataHFlushCache(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION DataHResolveDataRef(dh: DataHandler; theDataRef: Handle; VAR wasChanged: BOOLEAN; userInterfaceAllowed: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetFileSize(dh: DataHandler; VAR fileSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION DataHCanUseDataRef(dh: DataHandler; dataRef: Handle; VAR useFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetVolumeList(dh: DataHandler; VAR volumeList: DataHVolumeList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION DataHWrite(dh: DataHandler; data: Ptr; offset: LONGINT; size: LONGINT; completion: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION DataHPreextend(dh: DataHandler; maxToAdd: UInt32; VAR spaceAdded: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetFileSize(dh: DataHandler; fileSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetFreeSpace(dh: DataHandler; VAR freeSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION DataHCreateFile(dh: DataHandler; creator: OSType; deleteExisting: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetPreferredBlockSize(dh: DataHandler; VAR blockSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetDeviceIndex(dh: DataHandler; VAR deviceIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION DataHIsStreamingDataHandler(dh: DataHandler; VAR yes: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetDataInBuffer(dh: DataHandler; startOffset: LONGINT; VAR size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetScheduleAheadTime(dh: DataHandler; VAR millisecs: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetCacheSizeLimit(dh: DataHandler; cacheSizeLimit: Size): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetCacheSizeLimit(dh: DataHandler; VAR cacheSizeLimit: Size): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetMovie(dh: DataHandler; VAR theMovie: Movie; VAR id: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION DataHAddMovie(dh: DataHandler; theMovie: Movie; VAR id: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION DataHUpdateMovie(dh: DataHandler; theMovie: Movie; id: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION DataHDoesBuffer(dh: DataHandler; VAR buffersReads: BOOLEAN; VAR buffersWrites: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetFileName(dh: DataHandler; VAR str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetAvailableFileSize(dh: DataHandler; VAR fileSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetMacOSFileType(dh: DataHandler; VAR fileType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetMIMEType(dh: DataHandler; VAR mimeType: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetDataRefWithAnchor(dh: DataHandler; anchorDataRef: Handle; dataRefType: OSType; dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetDataRefWithAnchor(dh: DataHandler; anchorDataRef: Handle; dataRefType: OSType; VAR dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetMacOSFileType(dh: DataHandler; fileType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetTimeBase(dh: DataHandler; tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetInfoFlags(dh: DataHandler; VAR flags: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION DataHScheduleData64(dh: DataHandler; PlaceToPutDataPtr: Ptr; {CONST}VAR FileOffset: wide; DataSize: LONGINT; RefCon: LONGINT; scheduleRec: DataHSchedulePtr; CompletionRtn: DataHCompletionUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION DataHWrite64(dh: DataHandler; data: Ptr; {CONST}VAR offset: wide; size: LONGINT; completion: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetFileSize64(dh: DataHandler; VAR fileSize: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0030, $7000, $A82A;
	{$ENDC}
FUNCTION DataHPreextend64(dh: DataHandler; {CONST}VAR maxToAdd: wide; VAR spaceAdded: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0031, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetFileSize64(dh: DataHandler; {CONST}VAR fileSize: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0032, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetFreeSpace64(dh: DataHandler; VAR freeSize: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0033, $7000, $A82A;
	{$ENDC}
FUNCTION DataHAppend64(dh: DataHandler; data: UNIV Ptr; VAR fileOffset: wide; size: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0034, $7000, $A82A;
	{$ENDC}
FUNCTION DataHReadAsync(dh: DataHandler; dataPtr: UNIV Ptr; dataSize: UInt32; {CONST}VAR dataOffset: wide; completion: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0035, $7000, $A82A;
	{$ENDC}
FUNCTION DataHPollRead(dh: DataHandler; dataPtr: UNIV Ptr; VAR dataSizeSoFar: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0036, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetDataAvailability(dh: DataHandler; offset: LONGINT; len: LONGINT; VAR missing_offset: LONGINT; VAR missing_len: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0037, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetFileSizeAsync(dh: DataHandler; VAR fileSize: wide; completionRtn: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $003A, $7000, $A82A;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION DataHGetDataRefAsType(dh: DataHandler; requestedType: OSType; VAR dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003B, $7000, $A82A;
	{$ENDC}
FUNCTION DataHSetDataRefExtension(dh: DataHandler; extension: Handle; idType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003C, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetDataRefExtension(dh: DataHandler; VAR extension: Handle; idType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003D, $7000, $A82A;
	{$ENDC}
FUNCTION DataHGetMovieWithFlags(dh: DataHandler; VAR theMovie: Movie; VAR id: INTEGER; flags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $003E, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION DataHPlaybackHints(dh: DataHandler; flags: LONGINT; minFileOffset: UInt32; maxFileOffset: UInt32; bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0103, $7000, $A82A;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION DataHPlaybackHints64(dh: DataHandler; flags: LONGINT; {CONST}VAR minFileOffset: wide; {CONST}VAR maxFileOffset: wide; bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010E, $7000, $A82A;
	{$ENDC}



{$ENDC}  {CALL_NOT_IN_CARBON}



{ Standard type for video digitizers }

CONST
	videoDigitizerComponentType	= 'vdig';
	vdigInterfaceRev			= 2;

{ Input Format Standards }
	ntscIn						= 0;							{  current input format  }
	currentIn					= 0;							{  ntsc input format  }
	palIn						= 1;							{  pal input format  }
	secamIn						= 2;							{  secam input format  }
	ntscReallyIn				= 3;							{  ntsc input format  }

{ Input Formats }
	compositeIn					= 0;							{  input is composite format  }
	sVideoIn					= 1;							{  input is sVideo format  }
	rgbComponentIn				= 2;							{  input is rgb component format  }
	rgbComponentSyncIn			= 3;							{  input is rgb component format (sync on green?) }
	yuvComponentIn				= 4;							{  input is yuv component format  }
	yuvComponentSyncIn			= 5;							{  input is yuv component format (sync on green?)  }
	tvTunerIn					= 6;
	sdiIn						= 7;


{ Video Digitizer PlayThru States }
	vdPlayThruOff				= 0;
	vdPlayThruOn				= 1;

{ Input Color Space Modes }
	vdDigitizerBW				= 0;							{  black and white  }
	vdDigitizerRGB				= 1;							{  rgb color  }

{ Phase Lock Loop Modes }
	vdBroadcastMode				= 0;							{  Broadcast / Laser Disk video mode  }
	vdVTRMode					= 1;							{  VCR / Magnetic media mode  }

{ Field Select Options }
	vdUseAnyField				= 0;							{  Digitizers choice on field use  }
	vdUseOddField				= 1;							{  Use odd field for half size vert and smaller  }
	vdUseEvenField				= 2;							{  Use even field for half size vert and smaller  }

{ vdig types }
	vdTypeBasic					= 0;							{  basic, no clipping  }
	vdTypeAlpha					= 1;							{  supports clipping with alpha channel  }
	vdTypeMask					= 2;							{  supports clipping with mask plane  }
	vdTypeKey					= 3;							{  supports clipping with key color(s)  }



{ Digitizer Input Capability/Current Flags }
	digiInDoesNTSC				= $00000001;					{  digitizer supports NTSC input format  }
	digiInDoesPAL				= $00000002;					{  digitizer supports PAL input format  }
	digiInDoesSECAM				= $00000004;					{  digitizer supports SECAM input format  }
	digiInDoesGenLock			= $00000080;					{  digitizer does genlock  }
	digiInDoesComposite			= $00000100;					{  digitizer supports composite input type  }
	digiInDoesSVideo			= $00000200;					{  digitizer supports S-Video input type  }
	digiInDoesComponent			= $00000400;					{  digitizer supports component = rgb, input type  }
	digiInVTR_Broadcast			= $00000800;					{  digitizer can differentiate between the two  }
	digiInDoesColor				= $00001000;					{  digitizer supports color  }
	digiInDoesBW				= $00002000;					{  digitizer supports black & white  }
																{  Digitizer Input Current Flags = these are valid only during active operating conditions,    }
	digiInSignalLock			= $80000000;					{  digitizer detects input signal is locked, this bit = horiz lock || vertical lock  }


{ Digitizer Output Capability/Current Flags }
	digiOutDoes1				= $00000001;					{  digitizer supports 1 bit pixels  }
	digiOutDoes2				= $00000002;					{  digitizer supports 2 bit pixels  }
	digiOutDoes4				= $00000004;					{  digitizer supports 4 bit pixels  }
	digiOutDoes8				= $00000008;					{  digitizer supports 8 bit pixels  }
	digiOutDoes16				= $00000010;					{  digitizer supports 16 bit pixels  }
	digiOutDoes32				= $00000020;					{  digitizer supports 32 bit pixels  }
	digiOutDoesDither			= $00000040;					{  digitizer dithers in indexed modes  }
	digiOutDoesStretch			= $00000080;					{  digitizer can arbitrarily stretch  }
	digiOutDoesShrink			= $00000100;					{  digitizer can arbitrarily shrink  }
	digiOutDoesMask				= $00000200;					{  digitizer can mask to clipping regions  }
	digiOutDoesDouble			= $00000800;					{  digitizer can stretch to exactly double size  }
	digiOutDoesQuad				= $00001000;					{  digitizer can stretch exactly quadruple size  }
	digiOutDoesQuarter			= $00002000;					{  digitizer can shrink to exactly quarter size  }
	digiOutDoesSixteenth		= $00004000;					{  digitizer can shrink to exactly sixteenth size  }
	digiOutDoesRotate			= $00008000;					{  digitizer supports rotate transformations  }
	digiOutDoesHorizFlip		= $00010000;					{  digitizer supports horizontal flips Sx < 0  }
	digiOutDoesVertFlip			= $00020000;					{  digitizer supports vertical flips Sy < 0  }
	digiOutDoesSkew				= $00040000;					{  digitizer supports skew = shear,twist,  }
	digiOutDoesBlend			= $00080000;
	digiOutDoesWarp				= $00100000;
	digiOutDoesHW_DMA			= $00200000;					{  digitizer not constrained to local device  }
	digiOutDoesHWPlayThru		= $00400000;					{  digitizer doesn't need time to play thru  }
	digiOutDoesILUT				= $00800000;					{  digitizer does inverse LUT for index modes  }
	digiOutDoesKeyColor			= $01000000;					{  digitizer does key color functions too  }
	digiOutDoesAsyncGrabs		= $02000000;					{  digitizer supports async grabs  }
	digiOutDoesUnreadableScreenBits = $04000000;				{  playthru doesn't generate readable bits on screen }
	digiOutDoesCompress			= $08000000;					{  supports alternate output data types  }
	digiOutDoesCompressOnly		= $10000000;					{  can't provide raw frames anywhere  }
	digiOutDoesPlayThruDuringCompress = $20000000;				{  digi can do playthru while providing compressed data  }
	digiOutDoesCompressPartiallyVisible = $40000000;			{  digi doesn't need all bits visible on screen to do hardware compress  }

{ Types }

TYPE
	VideoDigitizerComponent				= ComponentInstance;
	VideoDigitizerError					= ComponentResult;
	DigitizerInfoPtr = ^DigitizerInfo;
	DigitizerInfo = RECORD
		vdigType:				INTEGER;
		inputCapabilityFlags:	LONGINT;
		outputCapabilityFlags:	LONGINT;
		inputCurrentFlags:		LONGINT;
		outputCurrentFlags:		LONGINT;
		slot:					INTEGER;								{  temporary for connection purposes  }
		gdh:					GDHandle;								{  temporary for digitizers that have preferred screen  }
		maskgdh:				GDHandle;								{  temporary for digitizers that have mask planes  }
		minDestHeight:			INTEGER;								{  Smallest resizable height  }
		minDestWidth:			INTEGER;								{  Smallest resizable width  }
		maxDestHeight:			INTEGER;								{  Largest resizable height  }
		maxDestWidth:			INTEGER;								{  Largest resizable width  }
		blendLevels:			INTEGER;								{  Number of blend levels supported (2 if 1 bit mask)  }
		reserved:				LONGINT;								{  reserved  }
	END;

	VdigTypePtr = ^VdigType;
	VdigType = RECORD
		digType:				LONGINT;
		reserved:				LONGINT;
	END;

	VdigTypeListPtr = ^VdigTypeList;
	VdigTypeList = RECORD
		count:					INTEGER;
		list:					ARRAY [0..0] OF VdigType;
	END;

	VdigBufferRecPtr = ^VdigBufferRec;
	VdigBufferRec = RECORD
		dest:					PixMapHandle;
		location:				Point;
		reserved:				LONGINT;
	END;

	VdigBufferRecListPtr = ^VdigBufferRecList;
	VdigBufferRecList = RECORD
		count:					INTEGER;
		matrix:					MatrixRecordPtr;
		mask:					RgnHandle;
		list:					ARRAY [0..0] OF VdigBufferRec;
	END;

	VdigBufferRecListHandle				= ^VdigBufferRecListPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	VdigIntProcPtr = PROCEDURE(flags: LONGINT; refcon: LONGINT);
{$ELSEC}
	VdigIntProcPtr = ProcPtr;
{$ENDC}

	VdigIntUPP = UniversalProcPtr;
	VDCompressionListPtr = ^VDCompressionList;
	VDCompressionList = RECORD
		codec:					CodecComponent;
		cType:					CodecType;
		typeName:				Str63;
		name:					Str63;
		formatFlags:			LONGINT;
		compressFlags:			LONGINT;
		reserved:				LONGINT;
	END;

	VDCompressionListHandle				= ^VDCompressionListPtr;

CONST
	dmaDepth1					= 1;
	dmaDepth2					= 2;
	dmaDepth4					= 4;
	dmaDepth8					= 8;
	dmaDepth16					= 16;
	dmaDepth32					= 32;
	dmaDepth2Gray				= 64;
	dmaDepth4Gray				= 128;
	dmaDepth8Gray				= 256;

	kVDIGControlledFrameRate	= -1;


FUNCTION VDGetMaxSrcRect(ci: VideoDigitizerComponent; inputStd: INTEGER; VAR maxSrcRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetActiveSrcRect(ci: VideoDigitizerComponent; inputStd: INTEGER; VAR activeSrcRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetDigitizerRect(ci: VideoDigitizerComponent; VAR digitizerRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetDigitizerRect(ci: VideoDigitizerComponent; VAR digitizerRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetVBlankRect(ci: VideoDigitizerComponent; inputStd: INTEGER; VAR vBlankRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetMaskPixMap(ci: VideoDigitizerComponent; maskPixMap: PixMapHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetPlayThruDestination(ci: VideoDigitizerComponent; VAR dest: PixMapHandle; VAR destRect: Rect; VAR m: MatrixRecord; VAR mask: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION VDUseThisCLUT(ci: VideoDigitizerComponent; colorTableHandle: CTabHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetInputGammaValue(ci: VideoDigitizerComponent; channel1: Fixed; channel2: Fixed; channel3: Fixed): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetInputGammaValue(ci: VideoDigitizerComponent; VAR channel1: Fixed; VAR channel2: Fixed; VAR channel3: Fixed): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetBrightness(ci: VideoDigitizerComponent; VAR brightness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetBrightness(ci: VideoDigitizerComponent; VAR brightness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetContrast(ci: VideoDigitizerComponent; VAR contrast: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetHue(ci: VideoDigitizerComponent; VAR hue: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetSharpness(ci: VideoDigitizerComponent; VAR sharpness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetSaturation(ci: VideoDigitizerComponent; VAR saturation: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetContrast(ci: VideoDigitizerComponent; VAR contrast: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetHue(ci: VideoDigitizerComponent; VAR hue: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetSharpness(ci: VideoDigitizerComponent; VAR sharpness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetSaturation(ci: VideoDigitizerComponent; VAR saturation: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION VDGrabOneFrame(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetMaxAuxBuffer(ci: VideoDigitizerComponent; VAR pm: PixMapHandle; VAR r: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetDigitizerInfo(ci: VideoDigitizerComponent; VAR info: DigitizerInfo): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetCurrentFlags(ci: VideoDigitizerComponent; VAR inputCurrentFlag: LONGINT; VAR outputCurrentFlag: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetKeyColor(ci: VideoDigitizerComponent; index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetKeyColor(ci: VideoDigitizerComponent; VAR index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION VDAddKeyColor(ci: VideoDigitizerComponent; VAR index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetNextKeyColor(ci: VideoDigitizerComponent; index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetKeyColorRange(ci: VideoDigitizerComponent; VAR minRGB: RGBColor; VAR maxRGB: RGBColor): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetKeyColorRange(ci: VideoDigitizerComponent; VAR minRGB: RGBColor; VAR maxRGB: RGBColor): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetDigitizerUserInterrupt(ci: VideoDigitizerComponent; flags: LONGINT; userInterruptProc: VdigIntUPP; refcon: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetInputColorSpaceMode(ci: VideoDigitizerComponent; colorSpaceMode: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetInputColorSpaceMode(ci: VideoDigitizerComponent; VAR colorSpaceMode: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetClipState(ci: VideoDigitizerComponent; clipEnable: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetClipState(ci: VideoDigitizerComponent; VAR clipEnable: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetClipRgn(ci: VideoDigitizerComponent; clipRegion: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION VDClearClipRgn(ci: VideoDigitizerComponent; clipRegion: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetCLUTInUse(ci: VideoDigitizerComponent; VAR colorTableHandle: CTabHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetPLLFilterType(ci: VideoDigitizerComponent; pllType: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetPLLFilterType(ci: VideoDigitizerComponent; VAR pllType: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetMaskandValue(ci: VideoDigitizerComponent; blendLevel: UInt16; VAR mask: LONGINT; VAR value: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetMasterBlendLevel(ci: VideoDigitizerComponent; VAR blendLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetPlayThruDestination(ci: VideoDigitizerComponent; dest: PixMapHandle; destRect: RectPtr; m: MatrixRecordPtr; mask: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetPlayThruOnOff(ci: VideoDigitizerComponent; state: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetFieldPreference(ci: VideoDigitizerComponent; fieldFlag: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetFieldPreference(ci: VideoDigitizerComponent; VAR fieldFlag: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0030, $7000, $A82A;
	{$ENDC}
FUNCTION VDPreflightDestination(ci: VideoDigitizerComponent; VAR digitizerRect: Rect; VAR dest: PixMapPtr; destRect: RectPtr; m: MatrixRecordPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0032, $7000, $A82A;
	{$ENDC}
FUNCTION VDPreflightGlobalRect(ci: VideoDigitizerComponent; theWindow: GrafPtr; VAR globalRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0033, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetPlayThruGlobalRect(ci: VideoDigitizerComponent; theWindow: GrafPtr; VAR globalRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0034, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetInputGammaRecord(ci: VideoDigitizerComponent; inputGammaPtr: VDGamRecPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0035, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetInputGammaRecord(ci: VideoDigitizerComponent; VAR inputGammaPtr: VDGamRecPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0036, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetBlackLevelValue(ci: VideoDigitizerComponent; VAR blackLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0037, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetBlackLevelValue(ci: VideoDigitizerComponent; VAR blackLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0038, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetWhiteLevelValue(ci: VideoDigitizerComponent; VAR whiteLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0039, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetWhiteLevelValue(ci: VideoDigitizerComponent; VAR whiteLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003A, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetVideoDefaults(ci: VideoDigitizerComponent; VAR blackLevel: UInt16; VAR whiteLevel: UInt16; VAR brightness: UInt16; VAR hue: UInt16; VAR saturation: UInt16; VAR contrast: UInt16; VAR sharpness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $003B, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetNumberOfInputs(ci: VideoDigitizerComponent; VAR inputs: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003C, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetInputFormat(ci: VideoDigitizerComponent; input: INTEGER; VAR format: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $003D, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetInput(ci: VideoDigitizerComponent; input: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $003E, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetInput(ci: VideoDigitizerComponent; VAR input: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003F, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetInputStandard(ci: VideoDigitizerComponent; inputStandard: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0040, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetupBuffers(ci: VideoDigitizerComponent; bufferList: VdigBufferRecListHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0041, $7000, $A82A;
	{$ENDC}
FUNCTION VDGrabOneFrameAsync(ci: VideoDigitizerComponent; buffer: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0042, $7000, $A82A;
	{$ENDC}
FUNCTION VDDone(ci: VideoDigitizerComponent; buffer: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0043, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetCompression(ci: VideoDigitizerComponent; compressType: OSType; depth: INTEGER; VAR bounds: Rect; spatialQuality: CodecQ; temporalQuality: CodecQ; keyFrameRate: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0044, $7000, $A82A;
	{$ENDC}
FUNCTION VDCompressOneFrameAsync(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0045, $7000, $A82A;
	{$ENDC}
FUNCTION VDCompressDone(ci: VideoDigitizerComponent; VAR done: BOOLEAN; VAR theData: Ptr; VAR dataSize: LONGINT; VAR similarity: UInt8; VAR t: TimeRecord): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0046, $7000, $A82A;
	{$ENDC}
FUNCTION VDReleaseCompressBuffer(ci: VideoDigitizerComponent; bufferAddr: Ptr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0047, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetImageDescription(ci: VideoDigitizerComponent; desc: ImageDescriptionHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0048, $7000, $A82A;
	{$ENDC}
FUNCTION VDResetCompressSequence(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0049, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetCompressionOnOff(ci: VideoDigitizerComponent; state: BOOLEAN): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $004A, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetCompressionTypes(ci: VideoDigitizerComponent; h: VDCompressionListHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004B, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetTimeBase(ci: VideoDigitizerComponent; t: TimeBase): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004C, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetFrameRate(ci: VideoDigitizerComponent; framesPerSecond: Fixed): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004D, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetDataRate(ci: VideoDigitizerComponent; VAR milliSecPerFrame: LONGINT; VAR framesPerSecond: Fixed; VAR bytesPerSecond: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $004E, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetSoundInputDriver(ci: VideoDigitizerComponent; VAR soundDriverName: Str255): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004F, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetDMADepths(ci: VideoDigitizerComponent; VAR depthArray: LONGINT; VAR preferredDepth: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0050, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetPreferredTimeScale(ci: VideoDigitizerComponent; VAR preferred: TimeScale): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0051, $7000, $A82A;
	{$ENDC}
FUNCTION VDReleaseAsyncBuffers(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0052, $7000, $A82A;
	{$ENDC}
{ 83 is reserved for compatibility reasons }
FUNCTION VDSetDataRate(ci: VideoDigitizerComponent; bytesPerSecond: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0054, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetTimeCode(ci: VideoDigitizerComponent; VAR atTime: TimeRecord; timeCodeFormat: UNIV Ptr; timeCodeTime: UNIV Ptr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0055, $7000, $A82A;
	{$ENDC}
FUNCTION VDUseSafeBuffers(ci: VideoDigitizerComponent; useSafeBuffers: BOOLEAN): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0056, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetSoundInputSource(ci: VideoDigitizerComponent; videoInput: LONGINT; VAR soundInput: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0057, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetCompressionTime(ci: VideoDigitizerComponent; compressionType: OSType; depth: INTEGER; VAR srcRect: Rect; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR compressTime: UInt32): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0058, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetPreferredPacketSize(ci: VideoDigitizerComponent; preferredPacketSizeInBytes: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0059, $7000, $A82A;
	{$ENDC}
FUNCTION VDSetPreferredImageDimensions(ci: VideoDigitizerComponent; width: LONGINT; height: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $005A, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetPreferredImageDimensions(ci: VideoDigitizerComponent; VAR width: LONGINT; VAR height: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $005B, $7000, $A82A;
	{$ENDC}
FUNCTION VDGetInputName(ci: VideoDigitizerComponent; videoInput: LONGINT; VAR name: Str255): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $005C, $7000, $A82A;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION VDSetDestinationPort(ci: VideoDigitizerComponent; destPort: CGrafPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $005D, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}




{
    General Sequence Grab stuff
}

TYPE
	SeqGrabComponent					= ComponentInstance;
	SGChannel							= ComponentInstance;

CONST
	SeqGrabComponentType		= 'barg';
	SeqGrabChannelType			= 'sgch';
	SeqGrabPanelType			= 'sgpn';
	SeqGrabCompressionPanelType	= 'cmpr';
	SeqGrabSourcePanelType		= 'sour';

	seqGrabToDisk				= 1;
	seqGrabToMemory				= 2;
	seqGrabDontUseTempMemory	= 4;
	seqGrabAppendToFile			= 8;
	seqGrabDontAddMovieResource	= 16;
	seqGrabDontMakeMovie		= 32;
	seqGrabPreExtendFile		= 64;
	seqGrabDataProcIsInterruptSafe = 128;
	seqGrabDataProcDoesOverlappingReads = 256;


TYPE
	SeqGrabDataOutputEnum				= UInt32;

CONST
	seqGrabRecord				= 1;
	seqGrabPreview				= 2;
	seqGrabPlayDuringRecord		= 4;


TYPE
	SeqGrabUsageEnum					= UInt32;

CONST
	seqGrabHasBounds			= 1;
	seqGrabHasVolume			= 2;
	seqGrabHasDiscreteSamples	= 4;


TYPE
	SeqGrabChannelInfoEnum				= UInt32;
	SGOutputRecordPtr = ^SGOutputRecord;
	SGOutputRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SGOutput							= ^SGOutputRecord;
	SeqGrabFrameInfoPtr = ^SeqGrabFrameInfo;
	SeqGrabFrameInfo = RECORD
		frameOffset:			LONGINT;
		frameTime:				LONGINT;
		frameSize:				LONGINT;
		frameChannel:			SGChannel;
		frameRefCon:			LONGINT;
	END;

	SeqGrabExtendedFrameInfoPtr = ^SeqGrabExtendedFrameInfo;
	SeqGrabExtendedFrameInfo = RECORD
		frameOffset:			wide;
		frameTime:				LONGINT;
		frameSize:				LONGINT;
		frameChannel:			SGChannel;
		frameRefCon:			LONGINT;
		frameOutput:			SGOutput;
	END;


CONST
	grabPictOffScreen			= 1;
	grabPictIgnoreClip			= 2;
	grabPictCurrentImage		= 4;

	sgFlagControlledGrab		= $01;
	sgFlagAllowNonRGBPixMaps	= $02;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SGDataProcPtr = FUNCTION(c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER; refCon: LONGINT): OSErr;
{$ELSEC}
	SGDataProcPtr = ProcPtr;
{$ENDC}

	SGDataUPP = UniversalProcPtr;
	SGDeviceNamePtr = ^SGDeviceName;
	SGDeviceName = RECORD
		name:					Str63;
		icon:					Handle;
		flags:					LONGINT;
		refCon:					LONGINT;
		reserved:				LONGINT;								{  zero }
	END;


CONST
	sgDeviceNameFlagDeviceUnavailable = $01;


TYPE
	SGDeviceListRecordPtr = ^SGDeviceListRecord;
	SGDeviceListRecord = RECORD
		count:					INTEGER;
		selectedIndex:			INTEGER;
		reserved:				LONGINT;								{  zero }
		entry:					ARRAY [0..0] OF SGDeviceName;
	END;

	SGDeviceListPtr						= ^SGDeviceListRecord;
	SGDeviceList						= ^SGDeviceListPtr;

CONST
	sgDeviceListWithIcons		= $01;
	sgDeviceListDontCheckAvailability = $02;

	seqGrabWriteAppend			= 0;
	seqGrabWriteReserve			= 1;
	seqGrabWriteFill			= 2;

	seqGrabUnpause				= 0;
	seqGrabPause				= 1;
	seqGrabPauseForMenu			= 3;

	channelFlagDontOpenResFile	= 2;
	channelFlagHasDependency	= 4;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SGModalFilterProcPtr = FUNCTION(theDialog: DialogRef; {CONST}VAR theEvent: EventRecord; VAR itemHit: INTEGER; refCon: LONGINT): BOOLEAN;
{$ELSEC}
	SGModalFilterProcPtr = ProcPtr;
{$ENDC}

	SGModalFilterUPP = UniversalProcPtr;

CONST
	sgPanelFlagForPanel			= 1;

	seqGrabSettingsPreviewOnly	= 1;

	channelPlayNormal			= 0;
	channelPlayFast				= 1;
	channelPlayHighQuality		= 2;
	channelPlayAllData			= 4;


FUNCTION SGInitialize(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetDataOutput(s: SeqGrabComponent; {CONST}VAR movieFile: FSSpec; whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetDataOutput(s: SeqGrabComponent; VAR movieFile: FSSpec; VAR whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetGWorld(s: SeqGrabComponent; gp: CGrafPtr; gd: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetGWorld(s: SeqGrabComponent; VAR gp: CGrafPtr; VAR gd: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION SGNewChannel(s: SeqGrabComponent; channelType: OSType; VAR ref: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION SGDisposeChannel(s: SeqGrabComponent; c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION SGStartPreview(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION SGStartRecord(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION SGIdle(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION SGStop(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION SGPause(s: SeqGrabComponent; pause: ByteParameter): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION SGPrepare(s: SeqGrabComponent; prepareForPreview: BOOLEAN; prepareForRecord: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION SGRelease(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetMovie(s: SeqGrabComponent): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetMaximumRecordTime(s: SeqGrabComponent; ticks: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetMaximumRecordTime(s: SeqGrabComponent; VAR ticks: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetStorageSpaceRemaining(s: SeqGrabComponent; VAR bytes: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetTimeRemaining(s: SeqGrabComponent; VAR ticksLeft: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION SGGrabPict(s: SeqGrabComponent; VAR p: PicHandle; {CONST}VAR bounds: Rect; offscreenDepth: INTEGER; grabPictFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetLastMovieResID(s: SeqGrabComponent; VAR resID: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetFlags(s: SeqGrabComponent; sgFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetFlags(s: SeqGrabComponent; VAR sgFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetDataProc(s: SeqGrabComponent; proc: SGDataUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION SGNewChannelFromComponent(s: SeqGrabComponent; VAR newChannel: SGChannel; sgChannelComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION SGDisposeDeviceList(s: SeqGrabComponent; list: SGDeviceList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION SGAppendDeviceListToMenu(s: SeqGrabComponent; list: SGDeviceList; mh: MenuRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetSettings(s: SeqGrabComponent; ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetSettings(s: SeqGrabComponent; VAR ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetIndChannel(s: SeqGrabComponent; index: INTEGER; VAR ref: SGChannel; VAR chanType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION SGUpdate(s: SeqGrabComponent; updateRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetPause(s: SeqGrabComponent; VAR paused: Byte): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}

TYPE
	ConstComponentListPtr				= ^Component;
FUNCTION SGSettingsDialog(s: SeqGrabComponent; c: SGChannel; numPanels: INTEGER; panelList: ConstComponentListPtr; flags: LONGINT; proc: SGModalFilterUPP; procRefNum: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetAlignmentProc(s: SeqGrabComponent; alignmentProc: ICMAlignmentProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelSettings(s: SeqGrabComponent; c: SGChannel; ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelSettings(s: SeqGrabComponent; c: SGChannel; VAR ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetMode(s: SeqGrabComponent; VAR previewMode: BOOLEAN; VAR recordMode: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetDataRef(s: SeqGrabComponent; dataRef: Handle; dataRefType: OSType; whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetDataRef(s: SeqGrabComponent; VAR dataRef: Handle; VAR dataRefType: OSType; VAR whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION SGNewOutput(s: SeqGrabComponent; dataRef: Handle; dataRefType: OSType; whereFlags: LONGINT; VAR sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0030, $7000, $A82A;
	{$ENDC}
FUNCTION SGDisposeOutput(s: SeqGrabComponent; sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0031, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetOutputFlags(s: SeqGrabComponent; sgOut: SGOutput; whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0032, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelOutput(s: SeqGrabComponent; c: SGChannel; sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0033, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetDataOutputStorageSpaceRemaining(s: SeqGrabComponent; sgOut: SGOutput; VAR space: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0034, $7000, $A82A;
	{$ENDC}
FUNCTION SGHandleUpdateEvent(s: SeqGrabComponent; {CONST}VAR event: EventRecord; VAR handled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0035, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetOutputNextOutput(s: SeqGrabComponent; sgOut: SGOutput; nextOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0036, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetOutputNextOutput(s: SeqGrabComponent; sgOut: SGOutput; VAR nextOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0037, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetOutputMaximumOffset(s: SeqGrabComponent; sgOut: SGOutput; {CONST}VAR maxOffset: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0038, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetOutputMaximumOffset(s: SeqGrabComponent; sgOut: SGOutput; VAR maxOffset: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0039, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetOutputDataReference(s: SeqGrabComponent; sgOut: SGOutput; VAR dataRef: Handle; VAR dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $003A, $7000, $A82A;
	{$ENDC}
FUNCTION SGWriteExtendedMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: wide; VAR sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $003B, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetStorageSpaceRemaining64(s: SeqGrabComponent; VAR bytes: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003C, $7000, $A82A;
	{$ENDC}
{
    calls from Channel to seqGrab
}
FUNCTION SGWriteMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION SGAddFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabFrameInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetNextFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabFrameInfoPtr; VAR frameDuration: TimeValue; VAR frameNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetTimeBase(s: SeqGrabComponent; VAR tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SGSortDeviceList(s: SeqGrabComponent; list: SGDeviceList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION SGAddMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001A, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SGChangedSource(s: SeqGrabComponent; c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SGAddExtendedFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabExtendedFrameInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetNextExtendedFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabExtendedFrameInfoPtr; VAR frameDuration: TimeValue; VAR frameNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION SGAddExtendedMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: wide; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER; VAR whichOutput: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001E, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION SGAddOutputDataRefToMedia(s: SeqGrabComponent; sgOut: SGOutput; theMedia: Media; desc: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010A, $7000, $A82A;
	{$ENDC}


{** Sequence Grab CHANNEL Component Stuff **}

FUNCTION SGSetChannelUsage(c: SGChannel; usage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0080, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelUsage(c: SGChannel; VAR usage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0081, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelBounds(c: SGChannel; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0082, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelBounds(c: SGChannel; VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0083, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelVolume(c: SGChannel; volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0084, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelVolume(c: SGChannel; VAR volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0085, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelInfo(c: SGChannel; VAR channelInfo: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0086, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelPlayFlags(c: SGChannel; playFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0087, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelPlayFlags(c: SGChannel; VAR playFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0088, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelMaxFrames(c: SGChannel; frameCount: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0089, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelMaxFrames(c: SGChannel; VAR frameCount: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008A, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelRefCon(c: SGChannel; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008B, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelClip(c: SGChannel; theClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008C, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelClip(c: SGChannel; VAR theClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008D, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelSampleDescription(c: SGChannel; sampleDesc: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008E, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelDeviceList(c: SGChannel; selectionFlags: LONGINT; VAR list: SGDeviceList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $008F, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelDevice(c: SGChannel; name: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0090, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetChannelMatrix(c: SGChannel; {CONST}VAR m: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0091, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelMatrix(c: SGChannel; VAR m: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0092, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelTimeScale(c: SGChannel; VAR scale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0093, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelPutPicture(c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0094, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelSetRequestedDataRate(c: SGChannel; bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0095, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelGetRequestedDataRate(c: SGChannel; VAR bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0096, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelSetDataSourceName(c: SGChannel; name: Str255; scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0097, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelGetDataSourceName(c: SGChannel; VAR name: Str255; VAR scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0098, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelSetCodecSettings(c: SGChannel; settings: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0099, $7000, $A82A;
	{$ENDC}
FUNCTION SGChannelGetCodecSettings(c: SGChannel; VAR settings: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $009A, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetChannelTimeBase(c: SGChannel; VAR tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $009B, $7000, $A82A;
	{$ENDC}
{
    calls from seqGrab to Channel
}
FUNCTION SGInitChannel(c: SGChannel; owner: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0180, $7000, $A82A;
	{$ENDC}
FUNCTION SGWriteSamples(c: SGChannel; m: Movie; theFile: AliasHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0181, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetDataRate(c: SGChannel; VAR bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0182, $7000, $A82A;
	{$ENDC}
FUNCTION SGAlignChannelRect(c: SGChannel; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0183, $7000, $A82A;
	{$ENDC}
{
    Dorky dialog panel calls
}
FUNCTION SGPanelGetDitl(s: SeqGrabComponent; VAR ditl: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0200, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelGetTitle(s: SeqGrabComponent; VAR title: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0201, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelCanRun(s: SeqGrabComponent; c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0202, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelInstall(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0203, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelEvent(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER; {CONST}VAR theEvent: EventRecord; VAR itemHit: INTEGER; VAR handled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0204, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelItem(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER; itemNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0205, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelRemove(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0206, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelSetGrabber(s: SeqGrabComponent; sg: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0207, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelSetResFile(s: SeqGrabComponent; resRef: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0208, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelGetSettings(s: SeqGrabComponent; c: SGChannel; VAR ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0209, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelSetSettings(s: SeqGrabComponent; c: SGChannel; ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $020A, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelValidateInput(s: SeqGrabComponent; VAR ok: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $020B, $7000, $A82A;
	{$ENDC}
FUNCTION SGPanelSetEventFilter(s: SeqGrabComponent; proc: SGModalFilterUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $020C, $7000, $A82A;
	{$ENDC}

{** Sequence Grab VIDEO CHANNEL Component Stuff **}
{
    Video stuff
}

TYPE
	SGCompressInfoPtr = ^SGCompressInfo;
	SGCompressInfo = RECORD
		buffer:					Ptr;
		bufferSize:				UInt32;
		similarity:				SInt8;
		reserved:				SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	SGGrabBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGGrabBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGGrabCompleteBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGGrabCompleteBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGDisplayBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGDisplayBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGCompressBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGCompressBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGCompressCompleteBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; VAR ci: SGCompressInfo; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGCompressCompleteBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGAddFrameBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; atTime: TimeValue; scale: TimeScale; {CONST}VAR ci: SGCompressInfo; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGAddFrameBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGTransferFrameBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGTransferFrameBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGGrabCompressCompleteBottleProcPtr = FUNCTION(c: SGChannel; VAR done: BOOLEAN; VAR ci: SGCompressInfo; VAR t: TimeRecord; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGGrabCompressCompleteBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGDisplayCompressBottleProcPtr = FUNCTION(c: SGChannel; dataPtr: Ptr; desc: ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGDisplayCompressBottleProcPtr = ProcPtr;
{$ENDC}

	SGGrabBottleUPP = UniversalProcPtr;
	SGGrabCompleteBottleUPP = UniversalProcPtr;
	SGDisplayBottleUPP = UniversalProcPtr;
	SGCompressBottleUPP = UniversalProcPtr;
	SGCompressCompleteBottleUPP = UniversalProcPtr;
	SGAddFrameBottleUPP = UniversalProcPtr;
	SGTransferFrameBottleUPP = UniversalProcPtr;
	SGGrabCompressCompleteBottleUPP = UniversalProcPtr;
	SGDisplayCompressBottleUPP = UniversalProcPtr;
	VideoBottlesPtr = ^VideoBottles;
	VideoBottles = RECORD
		procCount:				INTEGER;
		grabProc:				SGGrabBottleUPP;
		grabCompleteProc:		SGGrabCompleteBottleUPP;
		displayProc:			SGDisplayBottleUPP;
		compressProc:			SGCompressBottleUPP;
		compressCompleteProc:	SGCompressCompleteBottleUPP;
		addFrameProc:			SGAddFrameBottleUPP;
		transferFrameProc:		SGTransferFrameBottleUPP;
		grabCompressCompleteProc: SGGrabCompressCompleteBottleUPP;
		displayCompressProc:	SGDisplayCompressBottleUPP;
	END;

FUNCTION SGGetSrcVideoBounds(c: SGChannel; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetVideoRect(c: SGChannel; {CONST}VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetVideoRect(c: SGChannel; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetVideoCompressorType(c: SGChannel; VAR compressorType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetVideoCompressorType(c: SGChannel; compressorType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetVideoCompressor(c: SGChannel; depth: INTEGER; compressor: CompressorComponent; spatialQuality: CodecQ; temporalQuality: CodecQ; keyFrameRate: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetVideoCompressor(c: SGChannel; VAR depth: INTEGER; VAR compressor: CompressorComponent; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR keyFrameRate: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetVideoDigitizerComponent(c: SGChannel): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetVideoDigitizerComponent(c: SGChannel; vdig: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION SGVideoDigitizerChanged(c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetVideoBottlenecks(c: SGChannel; VAR vb: VideoBottles): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetVideoBottlenecks(c: SGChannel; VAR vb: VideoBottles): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010B, $7000, $A82A;
	{$ENDC}
FUNCTION SGGrabFrame(c: SGChannel; bufferNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $010C, $7000, $A82A;
	{$ENDC}
FUNCTION SGGrabFrameComplete(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $010D, $7000, $A82A;
	{$ENDC}
FUNCTION SGDisplayFrame(c: SGChannel; bufferNum: INTEGER; {CONST}VAR mp: MatrixRecord; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $010E, $7000, $A82A;
	{$ENDC}
FUNCTION SGCompressFrame(c: SGChannel; bufferNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $010F, $7000, $A82A;
	{$ENDC}
FUNCTION SGCompressFrameComplete(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; VAR ci: SGCompressInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0110, $7000, $A82A;
	{$ENDC}
FUNCTION SGAddFrame(c: SGChannel; bufferNum: INTEGER; atTime: TimeValue; scale: TimeScale; {CONST}VAR ci: SGCompressInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $0111, $7000, $A82A;
	{$ENDC}
FUNCTION SGTransferFrameForCompress(c: SGChannel; bufferNum: INTEGER; {CONST}VAR mp: MatrixRecord; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0112, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetCompressBuffer(c: SGChannel; depth: INTEGER; {CONST}VAR compressSize: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0113, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetCompressBuffer(c: SGChannel; VAR depth: INTEGER; VAR compressSize: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0114, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetBufferInfo(c: SGChannel; bufferNum: INTEGER; VAR bufferPM: PixMapHandle; VAR bufferRect: Rect; VAR compressBuffer: GWorldPtr; VAR compressBufferRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0115, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetUseScreenBuffer(c: SGChannel; useScreenBuffer: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0116, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetUseScreenBuffer(c: SGChannel; VAR useScreenBuffer: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0117, $7000, $A82A;
	{$ENDC}
FUNCTION SGGrabCompressComplete(c: SGChannel; VAR done: BOOLEAN; VAR ci: SGCompressInfo; VAR tr: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0118, $7000, $A82A;
	{$ENDC}
FUNCTION SGDisplayCompress(c: SGChannel; dataPtr: Ptr; desc: ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0119, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetFrameRate(c: SGChannel; frameRate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $011A, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetFrameRate(c: SGChannel; VAR frameRate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $011B, $7000, $A82A;
	{$ENDC}

FUNCTION SGSetPreferredPacketSize(c: SGChannel; preferredPacketSizeInBytes: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0121, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetPreferredPacketSize(c: SGChannel; VAR preferredPacketSizeInBytes: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0122, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetUserVideoCompressorList(c: SGChannel; compressorTypes: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0123, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetUserVideoCompressorList(c: SGChannel; VAR compressorTypes: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0124, $7000, $A82A;
	{$ENDC}
{** Sequence Grab SOUND CHANNEL Component Stuff **}

{
    Sound stuff
}
FUNCTION SGSetSoundInputDriver(c: SGChannel; driverName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetSoundInputDriver(c: SGChannel): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SGSoundInputDriverChanged(c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetSoundRecordChunkSize(c: SGChannel; seconds: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetSoundRecordChunkSize(c: SGChannel): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetSoundInputRate(c: SGChannel; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetSoundInputRate(c: SGChannel): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetSoundInputParameters(c: SGChannel; sampleSize: INTEGER; numChannels: INTEGER; compressionType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetSoundInputParameters(c: SGChannel; VAR sampleSize: INTEGER; VAR numChannels: INTEGER; VAR compressionType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetAdditionalSoundRates(c: SGChannel; rates: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetAdditionalSoundRates(c: SGChannel; VAR rates: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}
{
    Text stuff
}
FUNCTION SGSetFontName(c: SGChannel; pstr: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetFontSize(c: SGChannel; fontSize: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetTextForeColor(c: SGChannel; VAR theColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetTextBackColor(c: SGChannel; VAR theColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetJustification(c: SGChannel; just: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION SGGetTextReturnToSpaceValue(c: SGChannel; VAR rettospace: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetTextReturnToSpaceValue(c: SGChannel; rettospace: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0106, $7000, $A82A;
	{$ENDC}
{
    Music stuff
}
FUNCTION SGGetInstrument(c: SGChannel; VAR td: ToneDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION SGSetInstrument(c: SGChannel; VAR td: ToneDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}


CONST
	sgChannelAtom				= 'chan';
	sgChannelSettingsAtom		= 'ctom';
	sgChannelDescription		= 'cdsc';
	sgChannelSettings			= 'cset';

	sgDeviceNameType			= 'name';
	sgUsageType					= 'use ';
	sgPlayFlagsType				= 'plyf';
	sgClipType					= 'clip';
	sgMatrixType				= 'mtrx';
	sgVolumeType				= 'volu';

	sgPanelSettingsAtom			= 'ptom';
	sgPanelDescription			= 'pdsc';
	sgPanelSettings				= 'pset';

	sgcSoundCompressionType		= 'scmp';
	sgcSoundSampleRateType		= 'srat';
	sgcSoundChannelCountType	= 'schn';
	sgcSoundSampleSizeType		= 'ssiz';
	sgcSoundInputType			= 'sinp';
	sgcSoundGainType			= 'gain';

	sgcVideoHueType				= 'hue ';
	sgcVideoSaturationType		= 'satr';
	sgcVideoContrastType		= 'trst';
	sgcVideoSharpnessType		= 'shrp';
	sgcVideoBrigtnessType		= 'brit';
	sgcVideoBlackLevelType		= 'blkl';
	sgcVideoWhiteLevelType		= 'whtl';
	sgcVideoInputType			= 'vinp';
	sgcVideoFormatType			= 'vstd';
	sgcVideoFilterType			= 'vflt';
	sgcVideoRectType			= 'vrct';
	sgcVideoDigitizerType		= 'vdig';





TYPE
	QTVideoOutputComponent				= ComponentInstance;
{  Component type and subtype enumerations }

CONST
	QTVideoOutputComponentType	= 'vout';
	QTVideoOutputComponentBaseSubType = 'base';


{  QTVideoOutput Component flags }

	kQTVideoOutputDontDisplayToUser = $00000001;

{  Display mode atom types }

	kQTVODisplayModeItem		= 'qdmi';
	kQTVODimensions				= 'dimn';						{  atom contains two longs - pixel count - width, height }
	kQTVOResolution				= 'resl';						{  atom contains two Fixed - hRes, vRes in dpi }
	kQTVORefreshRate			= 'refr';						{  atom contains one Fixed - refresh rate in Hz }
	kQTVOPixelType				= 'pixl';						{  atom contains one OSType - pixel format of mode }
	kQTVOName					= 'name';						{  atom contains string (no length byte) - name of mode for display to user }
	kQTVODecompressors			= 'deco';						{  atom contains other atoms indicating supported decompressors }
																{  kQTVODecompressors sub-atoms }
	kQTVODecompressorType		= 'dety';						{  atom contains one OSType - decompressor type code }
	kQTVODecompressorContinuous	= 'cont';						{  atom contains one Boolean - true if this type is displayed continuously }
	kQTVODecompressorComponent	= 'cmpt';						{  atom contains one Component - component id of decompressor }

{* These are QTVideoOutput procedures *}
FUNCTION QTVideoOutputGetDisplayModeList(vo: QTVideoOutputComponent; VAR outputs: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetCurrentClientName(vo: QTVideoOutputComponent; VAR str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputSetClientName(vo: QTVideoOutputComponent; str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetClientName(vo: QTVideoOutputComponent; VAR str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputBegin(vo: QTVideoOutputComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputEnd(vo: QTVideoOutputComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputSetDisplayMode(vo: QTVideoOutputComponent; displayModeID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetDisplayMode(vo: QTVideoOutputComponent; VAR displayModeID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputCustomConfigureDisplay(vo: QTVideoOutputComponent; filter: ModalFilterUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputSaveState(vo: QTVideoOutputComponent; VAR state: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputRestoreState(vo: QTVideoOutputComponent; state: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetGWorld(vo: QTVideoOutputComponent; VAR gw: GWorldPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetGWorldParameters(vo: QTVideoOutputComponent; VAR baseAddr: Ptr; VAR rowBytes: LONGINT; VAR colorTable: CTabHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetIndSoundOutput(vo: QTVideoOutputComponent; index: LONGINT; VAR outputComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputGetClock(vo: QTVideoOutputComponent; VAR clock: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION QTVideoOutputSetEchoPort(vo: QTVideoOutputComponent; echoPort: CGrafPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}
{ UPP call backs }

CONST
	uppDataHCompletionProcInfo = $00000BC0;
	uppVdigIntProcInfo = $000003C0;
	uppSGDataProcInfo = $003BFFE0;
	uppSGModalFilterProcInfo = $00003FD0;
	uppSGGrabBottleProcInfo = $00000EF0;
	uppSGGrabCompleteBottleProcInfo = $00003EF0;
	uppSGDisplayBottleProcInfo = $0000FEF0;
	uppSGCompressBottleProcInfo = $00000EF0;
	uppSGCompressCompleteBottleProcInfo = $0000FEF0;
	uppSGAddFrameBottleProcInfo = $0003FEF0;
	uppSGTransferFrameBottleProcInfo = $0000FEF0;
	uppSGGrabCompressCompleteBottleProcInfo = $0000FFF0;
	uppSGDisplayCompressBottleProcInfo = $0003FFF0;

FUNCTION NewDataHCompletionUPP(userRoutine: DataHCompletionProcPtr): DataHCompletionUPP; { old name was NewDataHCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewVdigIntUPP(userRoutine: VdigIntProcPtr): VdigIntUPP; { old name was NewVdigIntProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGDataUPP(userRoutine: SGDataProcPtr): SGDataUPP; { old name was NewSGDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGModalFilterUPP(userRoutine: SGModalFilterProcPtr): SGModalFilterUPP; { old name was NewSGModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGGrabBottleUPP(userRoutine: SGGrabBottleProcPtr): SGGrabBottleUPP; { old name was NewSGGrabBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGGrabCompleteBottleUPP(userRoutine: SGGrabCompleteBottleProcPtr): SGGrabCompleteBottleUPP; { old name was NewSGGrabCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGDisplayBottleUPP(userRoutine: SGDisplayBottleProcPtr): SGDisplayBottleUPP; { old name was NewSGDisplayBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGCompressBottleUPP(userRoutine: SGCompressBottleProcPtr): SGCompressBottleUPP; { old name was NewSGCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGCompressCompleteBottleUPP(userRoutine: SGCompressCompleteBottleProcPtr): SGCompressCompleteBottleUPP; { old name was NewSGCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGAddFrameBottleUPP(userRoutine: SGAddFrameBottleProcPtr): SGAddFrameBottleUPP; { old name was NewSGAddFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGTransferFrameBottleUPP(userRoutine: SGTransferFrameBottleProcPtr): SGTransferFrameBottleUPP; { old name was NewSGTransferFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGGrabCompressCompleteBottleUPP(userRoutine: SGGrabCompressCompleteBottleProcPtr): SGGrabCompressCompleteBottleUPP; { old name was NewSGGrabCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSGDisplayCompressBottleUPP(userRoutine: SGDisplayCompressBottleProcPtr): SGDisplayCompressBottleUPP; { old name was NewSGDisplayCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDataHCompletionUPP(userUPP: DataHCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeVdigIntUPP(userUPP: VdigIntUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGDataUPP(userUPP: SGDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGModalFilterUPP(userUPP: SGModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGGrabBottleUPP(userUPP: SGGrabBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGGrabCompleteBottleUPP(userUPP: SGGrabCompleteBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGDisplayBottleUPP(userUPP: SGDisplayBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGCompressBottleUPP(userUPP: SGCompressBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGCompressCompleteBottleUPP(userUPP: SGCompressCompleteBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGAddFrameBottleUPP(userUPP: SGAddFrameBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGTransferFrameBottleUPP(userUPP: SGTransferFrameBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGGrabCompressCompleteBottleUPP(userUPP: SGGrabCompressCompleteBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeSGDisplayCompressBottleUPP(userUPP: SGDisplayCompressBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeDataHCompletionUPP(request: Ptr; refcon: LONGINT; err: OSErr; userRoutine: DataHCompletionUPP); { old name was CallDataHCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeVdigIntUPP(flags: LONGINT; refcon: LONGINT; userRoutine: VdigIntUPP); { old name was CallVdigIntProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGDataUPP(c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER; refCon: LONGINT; userRoutine: SGDataUPP): OSErr; { old name was CallSGDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGModalFilterUPP(theDialog: DialogRef; {CONST}VAR theEvent: EventRecord; VAR itemHit: INTEGER; refCon: LONGINT; userRoutine: SGModalFilterUPP): BOOLEAN; { old name was CallSGModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGGrabBottleUPP(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT; userRoutine: SGGrabBottleUPP): ComponentResult; { old name was CallSGGrabBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGGrabCompleteBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; refCon: LONGINT; userRoutine: SGGrabCompleteBottleUPP): ComponentResult; { old name was CallSGGrabCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGDisplayBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT; userRoutine: SGDisplayBottleUPP): ComponentResult; { old name was CallSGDisplayBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGCompressBottleUPP(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT; userRoutine: SGCompressBottleUPP): ComponentResult; { old name was CallSGCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGCompressCompleteBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; VAR ci: SGCompressInfo; refCon: LONGINT; userRoutine: SGCompressCompleteBottleUPP): ComponentResult; { old name was CallSGCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGAddFrameBottleUPP(c: SGChannel; bufferNum: INTEGER; atTime: TimeValue; scale: TimeScale; {CONST}VAR ci: SGCompressInfo; refCon: LONGINT; userRoutine: SGAddFrameBottleUPP): ComponentResult; { old name was CallSGAddFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGTransferFrameBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT; userRoutine: SGTransferFrameBottleUPP): ComponentResult; { old name was CallSGTransferFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGGrabCompressCompleteBottleUPP(c: SGChannel; VAR done: BOOLEAN; VAR ci: SGCompressInfo; VAR t: TimeRecord; refCon: LONGINT; userRoutine: SGGrabCompressCompleteBottleUPP): ComponentResult; { old name was CallSGGrabCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeSGDisplayCompressBottleUPP(c: SGChannel; dataPtr: Ptr; desc: ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT; userRoutine: SGDisplayCompressBottleUPP): ComponentResult; { old name was CallSGDisplayCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeComponentsIncludes}

{$ENDC} {__QUICKTIMECOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
