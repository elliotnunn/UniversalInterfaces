{
 	File:		MediaHandlers.p
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 2.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MediaHandlers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MEDIAHANDLERS__}
{$SETC __MEDIAHANDLERS__ := 1}

{$I+}
{$SETC MediaHandlersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	handlerHasSpatial			= $01;
	handlerCanClip				= $02;
	handlerCanMatte				= $04;
	handlerCanTransferMode		= $08;
	handlerNeedsBuffer			= $10;
	handlerNoIdle				= $20;
	handlerNoScheduler			= $40;
	handlerWantsTime			= $80;
	handlerCGrafPortOnly		= $0100;
	handlerCanSend				= $0200;

{ media task flags }
	mMustDraw					= $08;
	mAtEnd						= $10;
	mPreflightDraw				= $20;
	mSyncDrawing				= $40;

{ media task result flags }
	mDidDraw					= $01;
	mNeedsToDraw				= $04;
	mDrawAgain					= $08;
	mPartialDraw				= $10;

	forceUpdateRedraw			= $01;
	forceUpdateNewBuffer		= $02;


TYPE
	GetMovieCompleteParamsPtr = ^GetMovieCompleteParams;
	GetMovieCompleteParams = RECORD
		version:				INTEGER;
		theMovie:				Movie;
		theTrack:				Track;
		theMedia:				Media;
		movieScale:				TimeScale;
		mediaScale:				TimeScale;
		movieDuration:			TimeValue;
		trackDuration:			TimeValue;
		mediaDuration:			TimeValue;
		effectiveRate:			Fixed;
		timeBase:				TimeBase;
		volume:					INTEGER;
		width:					Fixed;
		height:					Fixed;
		trackMovieMatrix:		MatrixRecord;
		moviePort:				CGrafPtr;
		movieGD:				GDHandle;
		trackMatte:				PixMapHandle;
		inputMap:				QTAtomContainer;
	END;


CONST
	kMediaVideoParamBrightness	= 1;
	kMediaVideoParamContrast	= 2;
	kMediaVideoParamHue			= 3;
	kMediaVideoParamSharpness	= 4;
	kMediaVideoParamSaturation	= 5;
	kMediaVideoParamBlackLevel	= 6;
	kMediaVideoParamWhiteLevel	= 7;


TYPE
	dataHandlePtr						= ^Handle;
	dataHandleHandle					= ^dataHandlePtr;



{ MediaCallRange2 }
{ These are unique to each type of media handler }
{ They are also included in the public interfaces }


{**** These are the calls for dealing with the Generic media handler ****}
FUNCTION MediaInitialize(mh: MediaHandler; VAR gmc: GetMovieCompleteParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0501, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetHandlerCapabilities(mh: MediaHandler; flags: LONGINT; flagsMask: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0502, $7000, $A82A;
	{$ENDC}
FUNCTION MediaIdle(mh: MediaHandler; atMediaTime: TimeValue; flagsIn: LONGINT; VAR flagsOut: LONGINT; {CONST}VAR movieTime: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0503, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetMediaInfo(mh: MediaHandler; h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0504, $7000, $A82A;
	{$ENDC}
FUNCTION MediaPutMediaInfo(mh: MediaHandler; h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0505, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetActive(mh: MediaHandler; enableMedia: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0506, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetRate(mh: MediaHandler; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0507, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGGetStatus(mh: MediaHandler; VAR statusErr: ComponentResult): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0508, $7000, $A82A;
	{$ENDC}
FUNCTION MediaTrackEdited(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0509, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetMediaTimeScale(mh: MediaHandler; newTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050A, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetMovieTimeScale(mh: MediaHandler; newTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050B, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetGWorld(mh: MediaHandler; aPort: CGrafPtr; aGD: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050C, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetDimensions(mh: MediaHandler; width: Fixed; height: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050D, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetClip(mh: MediaHandler; theClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050E, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetMatrix(mh: MediaHandler; VAR trackMovieMatrix: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050F, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetTrackOpaque(mh: MediaHandler; VAR trackIsOpaque: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0510, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetGraphicsMode(mh: MediaHandler; mode: LONGINT; {CONST}VAR opColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0511, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetGraphicsMode(mh: MediaHandler; VAR mode: LONGINT; VAR opColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0512, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGSetVolume(mh: MediaHandler; volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0513, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetSoundBalance(mh: MediaHandler; balance: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0514, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetSoundBalance(mh: MediaHandler; VAR balance: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0515, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetNextBoundsChange(mh: MediaHandler; VAR when: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0516, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetSrcRgn(mh: MediaHandler; rgn: RgnHandle; atMediaTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0517, $7000, $A82A;
	{$ENDC}
FUNCTION MediaPreroll(mh: MediaHandler; time: TimeValue; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0518, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSampleDescriptionChanged(mh: MediaHandler; index: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0519, $7000, $A82A;
	{$ENDC}
FUNCTION MediaHasCharacteristic(mh: MediaHandler; characteristic: OSType; VAR hasIt: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $051A, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetOffscreenBufferSize(mh: MediaHandler; VAR bounds: Rect; depth: INTEGER; ctab: CTabHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $051B, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetHints(mh: MediaHandler; hints: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $051C, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetName(mh: MediaHandler; VAR name: Str255; requestedLanguage: LONGINT; VAR actualLanguage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $051D, $7000, $A82A;
	{$ENDC}
FUNCTION MediaForceUpdate(mh: MediaHandler; forceUpdateFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $051E, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetDrawingRgn(mh: MediaHandler; VAR partialRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $051F, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGSetActiveSegment(mh: MediaHandler; activeStart: TimeValue; activeDuration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0520, $7000, $A82A;
	{$ENDC}
FUNCTION MediaInvalidateRegion(mh: MediaHandler; invalRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0521, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetNextStepTime(mh: MediaHandler; flags: INTEGER; mediaTimeIn: TimeValue; VAR mediaTimeOut: TimeValue; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $0522, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; data: UNIV Ptr; dataSize: LONGINT; asyncCompletionProc: ICMCompletionProcRecordPtr; transferProc: ProcPtr; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0020, $0523, $7000, $A82A;
	{$ENDC}
FUNCTION MediaChangedNonPrimarySource(mh: MediaHandler; inputIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0524, $7000, $A82A;
	{$ENDC}
FUNCTION MediaTrackReferencesChanged(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0525, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetSampleDataPointer(mh: MediaHandler; sampleNum: LONGINT; VAR dataPtr: Ptr; VAR dataSize: LONGINT; VAR sampleDescIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0526, $7000, $A82A;
	{$ENDC}
FUNCTION MediaReleaseSampleDataPointer(mh: MediaHandler; sampleNum: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0527, $7000, $A82A;
	{$ENDC}
FUNCTION MediaTrackPropertyAtomChanged(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0528, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetTrackInputMapReference(mh: MediaHandler; inputMap: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0529, $7000, $A82A;
	{$ENDC}

FUNCTION MediaSetVideoParam(mh: MediaHandler; whichParam: LONGINT; VAR value: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $052B, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetVideoParam(mh: MediaHandler; whichParam: LONGINT; VAR value: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $052C, $7000, $A82A;
	{$ENDC}
FUNCTION MediaCompare(mh: MediaHandler; VAR isOK: BOOLEAN; srcMedia: Media; srcMediaComponent: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $052D, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetClock(mh: MediaHandler; VAR clock: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $052E, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetSoundOutputComponent(mh: MediaHandler; outputComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $052F, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetSoundOutputComponent(mh: MediaHandler; VAR outputComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0530, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetSoundLocalizationData(mh: MediaHandler; data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0531, $7000, $A82A;
	{$ENDC}
FUNCTION MediaFixSampleDescription(mh: MediaHandler; index: LONGINT; desc: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0532, $7000, $A82A;
	{$ENDC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MediaHandlersIncludes}

{$ENDC} {__MEDIAHANDLERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
