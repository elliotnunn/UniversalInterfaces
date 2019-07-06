{
 	File:		MediaHandlers.p
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 3.0
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1990-1998 by Apple Computer, Inc., all rights reserved
 
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
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PrePrerollCompleteProcPtr = PROCEDURE(mh: MediaHandler; err: OSErr; refcon: UNIV Ptr);
{$ELSEC}
	PrePrerollCompleteProcPtr = ProcPtr;
{$ENDC}

	PrePrerollCompleteUPP = UniversalProcPtr;

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
	handlerCanHandleComplexMatrix = $0400;
	handlerWantsDestinationPixels = $0800;						{  DNC Code: New flag to indicate the handler sends image data to modifier tracks }
	handlerCanSendImageData		= $1000;

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

{ media hit test flags }
	mHitTestBounds				= $00000001;					{ 	point must only be within targetRefCon's bounding box  }
	mHitTestImage				= $00000002;					{   point must be within the shape of the targetRefCon's image  }
	mHitTestInvisible			= $00000004;					{   invisible targetRefCon's may be hit tested  }
	mHitTestIsClick				= $00000008;					{   for codecs that want mouse events  }

{ media is opaque flags }
	mOpaque						= $00000001;
	mInvisible					= $00000002;







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
FUNCTION MediaSetNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; data: UNIV Ptr; dataSize: LONGINT; asyncCompletionProc: ICMCompletionProcRecordPtr; transferProc: UniversalProcPtr; refCon: UNIV Ptr): ComponentResult;
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

FUNCTION MediaSetVideoParam(mh: MediaHandler; whichParam: LONGINT; VAR value: UInt16): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $052B, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetVideoParam(mh: MediaHandler; whichParam: LONGINT; VAR value: UInt16): ComponentResult;
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



FUNCTION MediaGetInvalidRegion(mh: MediaHandler; rgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $053C, $7000, $A82A;
	{$ENDC}

FUNCTION MediaSampleDescriptionB2N(mh: MediaHandler; sampleDescriptionH: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $053E, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSampleDescriptionN2B(mh: MediaHandler; sampleDescriptionH: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $053F, $7000, $A82A;
	{$ENDC}
FUNCTION MediaQueueNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; data: UNIV Ptr; dataSize: LONGINT; asyncCompletionProc: ICMCompletionProcRecordPtr; {CONST}VAR frameTime: ICMFrameTimeRecord; transferProc: UniversalProcPtr; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $0540, $7000, $A82A;
	{$ENDC}
FUNCTION MediaFlushNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0541, $7000, $A82A;
	{$ENDC}

FUNCTION MediaGetURLLink(mh: MediaHandler; displayWhere: Point; VAR urlLink: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0543, $7000, $A82A;
	{$ENDC}

FUNCTION MediaMakeMediaTimeTable(mh: MediaHandler; VAR offsets: LONGINTPtr; startTime: TimeValue; endTime: TimeValue; timeIncrement: TimeValue; firstDataRefIndex: INTEGER; lastDataRefIndex: INTEGER; VAR retDataRefSkew: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0545, $7000, $A82A;
	{$ENDC}
FUNCTION MediaHitTestForTargetRefCon(mh: MediaHandler; flags: LONGINT; loc: Point; VAR targetRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0546, $7000, $A82A;
	{$ENDC}
FUNCTION MediaHitTestTargetRefCon(mh: MediaHandler; targetRefCon: LONGINT; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0547, $7000, $A82A;
	{$ENDC}
FUNCTION MediaGetActionsForQTEvent(mh: MediaHandler; event: QTEventRecordPtr; targetRefCon: LONGINT; VAR container: QTAtomContainer; VAR atom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0548, $7000, $A82A;
	{$ENDC}
FUNCTION MediaDisposeTargetRefCon(mh: MediaHandler; targetRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0549, $7000, $A82A;
	{$ENDC}
FUNCTION MediaTargetRefConsEqual(mh: MediaHandler; firstRefCon: LONGINT; secondRefCon: LONGINT; VAR equal: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $054A, $7000, $A82A;
	{$ENDC}
FUNCTION MediaSetActionsCallback(mh: MediaHandler; actionsCallbackProc: ActionsUPP; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $054B, $7000, $A82A;
	{$ENDC}
FUNCTION MediaPrePrerollBegin(mh: MediaHandler; time: TimeValue; rate: Fixed; completeProc: PrePrerollCompleteUPP; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $054C, $7000, $A82A;
	{$ENDC}
FUNCTION MediaPrePrerollCancel(mh: MediaHandler; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $054D, $7000, $A82A;
	{$ENDC}
FUNCTION MediaExecuteOneAction(mh: MediaHandler; container: QTAtomContainer; actionAtom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $054E, $7000, $A82A;
	{$ENDC}
FUNCTION MediaEnterEmptyEdit(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $054F, $7000, $A82A;
	{$ENDC}
FUNCTION MediaCurrentMediaQueuedData(mh: MediaHandler; VAR milliSecs: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0550, $7000, $A82A;
	{$ENDC}



CONST
	uppPrePrerollCompleteProcInfo = $00000EC0;

FUNCTION NewPrePrerollCompleteProc(userRoutine: PrePrerollCompleteProcPtr): PrePrerollCompleteUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallPrePrerollCompleteProc(mh: MediaHandler; err: OSErr; refcon: UNIV Ptr; userRoutine: PrePrerollCompleteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MediaHandlersIncludes}

{$ENDC} {__MEDIAHANDLERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
