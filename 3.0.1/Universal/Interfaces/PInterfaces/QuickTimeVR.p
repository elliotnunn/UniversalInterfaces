{
 	File:		QuickTimeVR.p
 
 	Contains:	QuickTime VR interfaces
 
 	Version:	Technology:	QuickTime VR 2.0.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeVR;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMEVR__}
{$SETC __QUICKTIMEVR__ := 1}

{$I+}
{$SETC QuickTimeVRIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	QTVRInstance = ^LONGINT;


CONST
	kQTVRControllerSubType		= 'ctyp';
	kQTVRQTVRType				= 'qtvr';
	kQTVRPanoramaType			= 'pano';
	kQTVRObjectType				= 'obje';
	kQTVROldPanoType			= 'STpn';						{  Used in QTVR 1.0 release }
	kQTVROldObjectType			= 'stna';						{  Used in QTVR 1.0 release }

{$IFC TARGET_OS_MAC }
{$ELSEC}
{$ENDC}  {TARGET_OS_MAC}

{  QTVR hot spot types }
	kQTVRHotSpotLinkType		= 'link';
	kQTVRHotSpotURLType			= 'url ';
	kQTVRHotSpotUndefinedType	= 'undf';

{  Special Values for nodeID in QTVRGoToNodeID }
	kQTVRCurrentNode			= 0;
	kQTVRPreviousNode			= $80000000;
	kQTVRDefaultNode			= $80000001;

{  Panorama correction modes used for the kQTVRImagingCorrection imaging property }
	kQTVRNoCorrection			= 0;
	kQTVRPartialCorrection		= 1;
	kQTVRFullCorrection			= 2;

{  Imaging Modes used by QTVRSetImagingProperty, QTVRGetImagingProperty, QTVRUpdate, QTVRBeginUpdate }
	kQTVRStatic					= 1;
	kQTVRMotion					= 2;
	kQTVRCurrentMode			= 0;							{  Special Value for QTVRUpdate }
	kQTVRAllModes				= 100;							{  Special value for QTVRSetProperty }


TYPE
	QTVRImagingMode						= UInt32;
{  Imaging Properties used by QTVRSetImagingProperty, QTVRGetImagingProperty }

CONST
	kQTVRImagingCorrection		= 1;
	kQTVRImagingQuality			= 2;
	kQTVRImagingDirectDraw		= 3;
	kQTVRImagingCurrentMode		= 100;							{  Get Only }

{  OR the above with kImagingDefaultValue to get/set the default value }
	kImagingDefaultValue		= $80000000;

{  Transition Types used by QTVRSetTransitionProperty, QTVREnableTransition }
	kQTVRTransitionSwing		= 1;

{  Transition Properties QTVRSetTransitionProperty }
	kQTVRTransitionSpeed		= 1;
	kQTVRTransitionDirection	= 2;

{  Constraint values used to construct value returned by GetConstraintStatus }
	kQTVRUnconstrained			= 0;
	kQTVRCantPanLeft			= $01;
	kQTVRCantPanRight			= $02;
	kQTVRCantPanUp				= $04;
	kQTVRCantPanDown			= $08;
	kQTVRCantZoomIn				= $10;
	kQTVRCantZoomOut			= $20;
	kQTVRCantTranslateLeft		= $40;
	kQTVRCantTranslateRight		= $80;
	kQTVRCantTranslateUp		= $0100;
	kQTVRCantTranslateDown		= $0200;

{  Properties for use with QTVRSetInteractionProperty/GetInteractionProperty }
	kQTVRInteractionMouseClickHysteresis = 1;					{  pixels within which the mouse is considered not to have moved (UInt16) }
	kQTVRInteractionMouseClickTimeout = 2;						{  ticks after which a mouse click times out and turns into panning (UInt32) }
	kQTVRInteractionPanTiltSpeed = 3;							{  control the relative pan/tilt speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5; }
	kQTVRInteractionZoomSpeed	= 4;							{  control the relative zooming speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5; }
	kQTVRInteractionTranslateOnMouseDown = 101;					{  Holding MouseDown with this setting translates zoomed object movies (Boolean) }
	kQTVRInteractionMouseMotionScale = 102;						{  The maximum angle of rotation caused by dragging across the display window. (* float) }

{  OR the above with kQTVRInteractionDefaultValue to get/set the default value }
	kQTVRInteractionDefaultValue = $80000000;

{  Resolution constants used in QTVRSetCachePrefs, QTVRGetCacheSettings, QTVRGetCacheMemInfo }
	kQTVRDefaultRes				= 0;
	kQTVRFullRes				= $01;
	kQTVRHalfRes				= $02;
	kQTVRQuarterRes				= $04;

{  Cache Size Pref constants used in QTVRSetCachePrefs, QTVRGetCacheSettings }
	kQTVRMinimumCache			= -1;
	kQTVRSuggestedCache			= 0;
	kQTVRFullCache				= 1;

{  Pixel depth constants used in QTVRSetCachePrefs, QTVRGetCacheMemInfo }
	kQTVRUseMovieDepth			= 0;
	kQTVRDepth16				= 16;
	kQTVRDepth32				= 32;

{  Angular units used by QTVRSetAngularUnits }
	kQTVRDegrees				= 0;
	kQTVRRadians				= 1;


TYPE
	QTVRAngularUnits					= UInt32;
{  Values for enableFlag parameter in QTVREnableHotSpot }

CONST
	kQTVRHotSpotID				= 0;
	kQTVRHotSpotType			= 1;
	kQTVRAllHotSpots			= 2;

{  Values for kind parameter in QTVRGet/SetConstraints, QTVRGetViewingLimits }
	kQTVRPan					= 0;
	kQTVRTilt					= 1;
	kQTVRFieldOfView			= 2;
	kQTVRViewCenterH			= 4;							{  WrapAndConstrain only }
	kQTVRViewCenterV			= 5;							{  WrapAndConstrain only }

{  Values for setting parameter in QTVRSetAnimationSetting, QTVRGetAnimationSetting }
	kQTVRPalindromeViewFrames	= 1;							{  View Frame Animation Settings }
	kQTVRStartFirstViewFrame	= 2;
	kQTVRDontLoopViewFrames		= 3;
	kQTVRSyncViewToFrameRate	= 16;							{  View Animation Settings }
	kQTVRPalindromeViews		= 17;


TYPE
	QTVRObjectAnimationSetting			= UInt32;

CONST
	kQTVRWrapPan				= 1;
	kQTVRWrapTilt				= 2;
	kQTVRCanZoom				= 3;
	kQTVRReverseHControl		= 4;
	kQTVRReverseVControl		= 5;
	kQTVRSwapHVControl			= 6;
	kQTVRTranslation			= 7;


TYPE
	QTVRControlSetting					= UInt32;

CONST
	kQTVRDefault				= 0;
	kQTVRCurrent				= 2;
	kQTVRMouseDown				= 3;


TYPE
	QTVRViewStateType					= UInt32;

CONST
	kQTVRRight					= 0;
	kQTVRUpRight				= 45;
	kQTVRUp						= 90;
	kQTVRUpLeft					= 135;
	kQTVRLeft					= 180;
	kQTVRDownLeft				= 225;
	kQTVRDown					= 270;
	kQTVRDownRight				= 315;


TYPE
	QTVRNudgeControl					= UInt32;
{  Flags to control elements of the QTVR control bar (set via mcActionSetFlags)  }

CONST
	mcFlagQTVRSuppressBackBtn	= $00010000;
	mcFlagQTVRSuppressZoomBtns	= $00020000;
	mcFlagQTVRSuppressHotSpotBtn = $00040000;
	mcFlagQTVRSuppressTranslateBtn = $00080000;
	mcFlagQTVRSuppressHelpText	= $00100000;
	mcFlagQTVRSuppressHotSpotNames = $00200000;
	mcFlagQTVRExplicitFlagSet	= $80000000;					{  bits 0->30 should be interpreted as "explicit on" for the corresponding suppression bits }

{  Cursor types used in type field of QTVRCursorRecord }
	kQTVRUseDefaultCursor		= 0;
	kQTVRStdCursorType			= 1;
	kQTVRColorCursorType		= 2;

{  Values for flags parameter in QTVRMouseOverHotSpot callback }
	kQTVRHotSpotEnter			= 0;
	kQTVRHotSpotWithin			= 1;
	kQTVRHotSpotLeave			= 2;

{  Values for flags field of areasOfInterest in QTVRSetBackBufferImagingProc }
	kQTVRBackBufferEveryUpdate	= $01;
	kQTVRBackBufferEveryIdle	= $02;
	kQTVRBackBufferAlwaysRefresh = $04;
	kQTVRBackBufferHorizontal	= $08;							{  not supported in 2.0 }

{  Values for flagsIn parameter in QTVRBackBufferImaging callback }
	kQTVRBackBufferRectVisible	= $01;
	kQTVRBackBufferWasRefreshed	= $02;

{  Values for flagsOut parameter in QTVRBackBufferImaging callback }
	kQTVRBackBufferFlagDidDraw	= $01;
	kQTVRBackBufferFlagLastFlag	= $80000000;

{  QTVRCursorRecord used in QTVRReplaceCursor }

TYPE
	QTVRCursorRecordPtr = ^QTVRCursorRecord;
	QTVRCursorRecord = RECORD
		theType:				UInt16;									{  field was previously named "type" }
		rsrcID:					SInt16;
		handle:					Handle;
	END;

	QTVRFloatPointPtr = ^QTVRFloatPoint;
	QTVRFloatPoint = RECORD
		x:						Single;
		y:						Single;
	END;

{  Struct used for areasOfInterest parameter in QTVRSetBackBufferImagingProc }
	QTVRAreaOfInterestPtr = ^QTVRAreaOfInterest;
	QTVRAreaOfInterest = RECORD
		panAngle:				Single;
		tiltAngle:				Single;
		width:					Single;
		height:					Single;
		flags:					UInt32;
	END;

{
  =================================================================================================
   Callback routines 
  -------------------------------------------------------------------------------------------------
}

	QTVRLeavingNodeProcPtr = ProcPtr;  { FUNCTION QTVRLeavingNode(qtvr: QTVRInstance; fromNodeID: UInt32; toNodeID: UInt32; VAR cancel: BOOLEAN; refCon: SInt32): OSErr; }

	QTVREnteringNodeProcPtr = ProcPtr;  { FUNCTION QTVREnteringNode(qtvr: QTVRInstance; nodeID: UInt32; refCon: SInt32): OSErr; }

	QTVRMouseOverHotSpotProcPtr = ProcPtr;  { FUNCTION QTVRMouseOverHotSpot(qtvr: QTVRInstance; hotSpotID: UInt32; flags: UInt32; refCon: SInt32): OSErr; }

	QTVRImagingCompleteProcPtr = ProcPtr;  { FUNCTION QTVRImagingComplete(qtvr: QTVRInstance; refCon: SInt32): OSErr; }

	QTVRBackBufferImagingProcPtr = ProcPtr;  { FUNCTION QTVRBackBufferImaging(qtvr: QTVRInstance; VAR drawRect: Rect; areaIndex: UInt16; flagsIn: UInt32; VAR flagsOut: UInt32; refCon: SInt32): OSErr; }

	QTVRLeavingNodeUPP = UniversalProcPtr;
	QTVREnteringNodeUPP = UniversalProcPtr;
	QTVRMouseOverHotSpotUPP = UniversalProcPtr;
	QTVRImagingCompleteUPP = UniversalProcPtr;
	QTVRBackBufferImagingUPP = UniversalProcPtr;

CONST
	uppQTVRLeavingNodeProcInfo = $0000FFE0;
	uppQTVREnteringNodeProcInfo = $00000FE0;
	uppQTVRMouseOverHotSpotProcInfo = $00003FE0;
	uppQTVRImagingCompleteProcInfo = $000003E0;
	uppQTVRBackBufferImagingProcInfo = $0003FBE0;

FUNCTION NewQTVRLeavingNodeProc(userRoutine: QTVRLeavingNodeProcPtr): QTVRLeavingNodeUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVREnteringNodeProc(userRoutine: QTVREnteringNodeProcPtr): QTVREnteringNodeUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVRMouseOverHotSpotProc(userRoutine: QTVRMouseOverHotSpotProcPtr): QTVRMouseOverHotSpotUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVRImagingCompleteProc(userRoutine: QTVRImagingCompleteProcPtr): QTVRImagingCompleteUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVRBackBufferImagingProc(userRoutine: QTVRBackBufferImagingProcPtr): QTVRBackBufferImagingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallQTVRLeavingNodeProc(qtvr: QTVRInstance; fromNodeID: UInt32; toNodeID: UInt32; VAR cancel: BOOLEAN; refCon: SInt32; userRoutine: QTVRLeavingNodeUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallQTVREnteringNodeProc(qtvr: QTVRInstance; nodeID: UInt32; refCon: SInt32; userRoutine: QTVREnteringNodeUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallQTVRMouseOverHotSpotProc(qtvr: QTVRInstance; hotSpotID: UInt32; flags: UInt32; refCon: SInt32; userRoutine: QTVRMouseOverHotSpotUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallQTVRImagingCompleteProc(qtvr: QTVRInstance; refCon: SInt32; userRoutine: QTVRImagingCompleteUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallQTVRBackBufferImagingProc(qtvr: QTVRInstance; VAR drawRect: Rect; areaIndex: UInt16; flagsIn: UInt32; VAR flagsOut: UInt32; refCon: SInt32; userRoutine: QTVRBackBufferImagingUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  =================================================================================================
    QTVR Intercept Struct, Callback, Routine Descriptors 
  -------------------------------------------------------------------------------------------------
}


CONST
	kQTVRSetPanAngleSelector	= $2000;
	kQTVRSetTiltAngleSelector	= $2001;
	kQTVRSetFieldOfViewSelector	= $2002;
	kQTVRSetViewCenterSelector	= $2003;
	kQTVRMouseEnterSelector		= $2004;
	kQTVRMouseWithinSelector	= $2005;
	kQTVRMouseLeaveSelector		= $2006;
	kQTVRMouseDownSelector		= $2007;
	kQTVRMouseStillDownSelector	= $2008;
	kQTVRMouseUpSelector		= $2009;
	kQTVRTriggerHotSpotSelector	= $200A;


TYPE
	QTVRProcSelector					= UInt32;
	QTVRInterceptRecordPtr = ^QTVRInterceptRecord;
	QTVRInterceptRecord = RECORD
		reserved1:				SInt32;
		selector:				SInt32;
		reserved2:				SInt32;
		reserved3:				SInt32;
		paramCount:				SInt32;
		parameter:				ARRAY [0..5] OF Ptr;
	END;

	QTVRInterceptPtr					= ^QTVRInterceptRecord;
{  Prototype for Intercept Proc callback }
	QTVRInterceptProcPtr = ProcPtr;  { PROCEDURE QTVRIntercept(qtvr: QTVRInstance; qtvrMsg: QTVRInterceptPtr; refCon: SInt32; VAR cancel: BOOLEAN); }

	QTVRInterceptUPP = UniversalProcPtr;

CONST
	uppQTVRInterceptProcInfo = $00003FC0;

FUNCTION NewQTVRInterceptProc(userRoutine: QTVRInterceptProcPtr): QTVRInterceptUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallQTVRInterceptProc(qtvr: QTVRInstance; qtvrMsg: QTVRInterceptPtr; refCon: SInt32; VAR cancel: BOOLEAN; userRoutine: QTVRInterceptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  =================================================================================================
    General QTVR calls 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRGetQTVRTrack(theMovie: Movie; index: SInt32): Track; C;
FUNCTION QTVRGetQTVRInstance(VAR qtvr: QTVRInstance; qtvrTrack: Track; mc: MovieController): OSErr; C;
{
  =================================================================================================
    Viewing Angles and Zooming 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetPanAngle(qtvr: QTVRInstance; panAngle: Single): OSErr; C;
FUNCTION QTVRGetPanAngle(qtvr: QTVRInstance): Single; C;
FUNCTION QTVRSetTiltAngle(qtvr: QTVRInstance; tiltAngle: Single): OSErr; C;
FUNCTION QTVRGetTiltAngle(qtvr: QTVRInstance): Single; C;
FUNCTION QTVRSetFieldOfView(qtvr: QTVRInstance; fieldOfView: Single): OSErr; C;
FUNCTION QTVRGetFieldOfView(qtvr: QTVRInstance): Single; C;
FUNCTION QTVRShowDefaultView(qtvr: QTVRInstance): OSErr; C;
{  Object Specific }
FUNCTION QTVRSetViewCenter(qtvr: QTVRInstance; {CONST}VAR viewCenter: QTVRFloatPoint): OSErr; C;
FUNCTION QTVRGetViewCenter(qtvr: QTVRInstance; VAR viewCenter: QTVRFloatPoint): OSErr; C;
FUNCTION QTVRNudge(qtvr: QTVRInstance; direction: QTVRNudgeControl): OSErr; C;
{
  =================================================================================================
    Scene and Node Location Information 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRGetVRWorld(qtvr: QTVRInstance; VAR VRWorld: QTAtomContainer): OSErr; C;
FUNCTION QTVRGoToNodeID(qtvr: QTVRInstance; nodeID: UInt32): OSErr; C;
FUNCTION QTVRGetCurrentNodeID(qtvr: QTVRInstance): UInt32; C;
FUNCTION QTVRGetNodeType(qtvr: QTVRInstance; nodeID: UInt32): LONGINT; C;
{
  =================================================================================================
    Hot Spot related calls 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRPtToHotSpotID(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32): OSErr; C;
FUNCTION QTVRGetNodeInfo(qtvr: QTVRInstance; nodeID: UInt32; VAR nodeInfo: QTAtomContainer): OSErr; C;
FUNCTION QTVRTriggerHotSpot(qtvr: QTVRInstance; hotSpotID: UInt32; nodeInfo: QTAtomContainer; selectedAtom: QTAtom): OSErr; C;
FUNCTION QTVRSetMouseOverHotSpotProc(qtvr: QTVRInstance; mouseOverHotSpotProc: QTVRMouseOverHotSpotUPP; refCon: SInt32; flags: UInt32): OSErr; C;
FUNCTION QTVREnableHotSpot(qtvr: QTVRInstance; enableFlag: UInt32; hotSpotValue: UInt32; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetVisibleHotSpots(qtvr: QTVRInstance; hotSpots: Handle): UInt32; C;
FUNCTION QTVRGetHotSpotRegion(qtvr: QTVRInstance; hotSpotID: UInt32; hotSpotRegion: RgnHandle): OSErr; C;
{
  =================================================================================================
    Event & Cursor Handling Calls 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetMouseOverTracking(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetMouseOverTracking(qtvr: QTVRInstance): BOOLEAN; C;
FUNCTION QTVRSetMouseDownTracking(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetMouseDownTracking(qtvr: QTVRInstance): BOOLEAN; C;
FUNCTION QTVRMouseEnter(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowPtr): OSErr; C;
FUNCTION QTVRMouseWithin(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowPtr): OSErr; C;
FUNCTION QTVRMouseLeave(qtvr: QTVRInstance; pt: Point; w: WindowPtr): OSErr; C;
FUNCTION QTVRMouseDown(qtvr: QTVRInstance; pt: Point; when: UInt32; modifiers: UInt16; VAR hotSpotID: UInt32; w: WindowPtr): OSErr; C;
FUNCTION QTVRMouseStillDown(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowPtr): OSErr; C;
FUNCTION QTVRMouseUp(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowPtr): OSErr; C;
{  These require kQTVRAPIMajorVersion02 and kQTVRAPIMinorVersion01 }
FUNCTION QTVRMouseStillDownExtended(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowPtr; when: UInt32; modifiers: UInt16): OSErr; C;
FUNCTION QTVRMouseUpExtended(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowPtr; when: UInt32; modifiers: UInt16): OSErr; C;
{
  =================================================================================================
    Intercept Routines 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRInstallInterceptProc(qtvr: QTVRInstance; selector: QTVRProcSelector; interceptProc: QTVRInterceptUPP; refCon: SInt32; flags: UInt32): OSErr; C;
FUNCTION QTVRCallInterceptedProc(qtvr: QTVRInstance; VAR qtvrMsg: QTVRInterceptRecord): OSErr; C;
{
  =================================================================================================
    Object Movie Specific Calls 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetFrameRate(qtvr: QTVRInstance; rate: Single): OSErr; C;
FUNCTION QTVRGetFrameRate(qtvr: QTVRInstance): Single; C;
FUNCTION QTVRSetViewRate(qtvr: QTVRInstance; rate: Single): OSErr; C;
FUNCTION QTVRGetViewRate(qtvr: QTVRInstance): Single; C;
FUNCTION QTVRSetViewCurrentTime(qtvr: QTVRInstance; time: TimeValue): OSErr; C;
FUNCTION QTVRGetViewCurrentTime(qtvr: QTVRInstance): TimeValue; C;
FUNCTION QTVRGetCurrentViewDuration(qtvr: QTVRInstance): TimeValue; C;
{
  =================================================================================================
   View State Calls - QTVR Object Only
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetViewState(qtvr: QTVRInstance; viewStateType: QTVRViewStateType; state: UInt16): OSErr; C;
FUNCTION QTVRGetViewState(qtvr: QTVRInstance; viewStateType: QTVRViewStateType; VAR state: UInt16): OSErr; C;
FUNCTION QTVRGetViewStateCount(qtvr: QTVRInstance): UInt16; C;
FUNCTION QTVRSetAnimationSetting(qtvr: QTVRInstance; setting: QTVRObjectAnimationSetting; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetAnimationSetting(qtvr: QTVRInstance; setting: QTVRObjectAnimationSetting; VAR enable: BOOLEAN): OSErr; C;
FUNCTION QTVRSetControlSetting(qtvr: QTVRInstance; setting: QTVRControlSetting; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetControlSetting(qtvr: QTVRInstance; setting: QTVRControlSetting; VAR enable: BOOLEAN): OSErr; C;
FUNCTION QTVREnableFrameAnimation(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetFrameAnimation(qtvr: QTVRInstance): BOOLEAN; C;
FUNCTION QTVREnableViewAnimation(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;
FUNCTION QTVRGetViewAnimation(qtvr: QTVRInstance): BOOLEAN; C;

{
  =================================================================================================
    Imaging Characteristics 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetVisible(qtvr: QTVRInstance; visible: BOOLEAN): OSErr; C;
FUNCTION QTVRGetVisible(qtvr: QTVRInstance): BOOLEAN; C;
FUNCTION QTVRSetImagingProperty(qtvr: QTVRInstance; imagingMode: QTVRImagingMode; imagingProperty: UInt32; propertyValue: SInt32): OSErr; C;
FUNCTION QTVRGetImagingProperty(qtvr: QTVRInstance; imagingMode: QTVRImagingMode; imagingProperty: UInt32; VAR propertyValue: SInt32): OSErr; C;
FUNCTION QTVRUpdate(qtvr: QTVRInstance; imagingMode: QTVRImagingMode): OSErr; C;
FUNCTION QTVRBeginUpdateStream(qtvr: QTVRInstance; imagingMode: QTVRImagingMode): OSErr; C;
FUNCTION QTVREndUpdateStream(qtvr: QTVRInstance): OSErr; C;
FUNCTION QTVRSetTransitionProperty(qtvr: QTVRInstance; transitionType: UInt32; transitionProperty: UInt32; transitionValue: SInt32): OSErr; C;
FUNCTION QTVREnableTransition(qtvr: QTVRInstance; transitionType: UInt32; enable: BOOLEAN): OSErr; C;
{
  =================================================================================================
    Basic Conversion and Math Routines 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetAngularUnits(qtvr: QTVRInstance; units: QTVRAngularUnits): OSErr; C;
FUNCTION QTVRGetAngularUnits(qtvr: QTVRInstance): QTVRAngularUnits; C;
{  Pano specific routines }
FUNCTION QTVRPtToAngles(qtvr: QTVRInstance; pt: Point; VAR panAngle: Single; VAR tiltAngle: Single): OSErr; C;
FUNCTION QTVRCoordToAngles(qtvr: QTVRInstance; VAR coord: QTVRFloatPoint; VAR panAngle: Single; VAR tiltAngle: Single): OSErr; C;
FUNCTION QTVRAnglesToCoord(qtvr: QTVRInstance; panAngle: Single; tiltAngle: Single; VAR coord: QTVRFloatPoint): OSErr; C;
{  Object specific routines }
FUNCTION QTVRPanToColumn(qtvr: QTVRInstance; panAngle: Single): INTEGER; C;
{  zero based	 }
FUNCTION QTVRColumnToPan(qtvr: QTVRInstance; column: INTEGER): Single; C;
{  zero based	 }
FUNCTION QTVRTiltToRow(qtvr: QTVRInstance; tiltAngle: Single): INTEGER; C;
{  zero based	 }
FUNCTION QTVRRowToTilt(qtvr: QTVRInstance; row: INTEGER): Single; C;
{  zero based				 }
FUNCTION QTVRWrapAndConstrain(qtvr: QTVRInstance; kind: INTEGER; value: Single; VAR result: Single): OSErr; C;

{
  =================================================================================================
    Interaction Routines 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetEnteringNodeProc(qtvr: QTVRInstance; enteringNodeProc: QTVREnteringNodeUPP; refCon: SInt32; flags: UInt32): OSErr; C;
FUNCTION QTVRSetLeavingNodeProc(qtvr: QTVRInstance; leavingNodeProc: QTVRLeavingNodeUPP; refCon: SInt32; flags: UInt32): OSErr; C;
FUNCTION QTVRSetInteractionProperty(qtvr: QTVRInstance; property: UInt32; value: UNIV Ptr): OSErr; C;
FUNCTION QTVRGetInteractionProperty(qtvr: QTVRInstance; property: UInt32; value: UNIV Ptr): OSErr; C;
FUNCTION QTVRReplaceCursor(qtvr: QTVRInstance; VAR cursRecord: QTVRCursorRecord): OSErr; C;
{
  =================================================================================================
    Viewing Limits and Constraints 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRGetViewingLimits(qtvr: QTVRInstance; kind: UInt16; VAR minValue: Single; VAR maxValue: Single): OSErr; C;
FUNCTION QTVRGetConstraintStatus(qtvr: QTVRInstance): UInt32; C;
FUNCTION QTVRGetConstraints(qtvr: QTVRInstance; kind: UInt16; VAR minValue: Single; VAR maxValue: Single): OSErr; C;
FUNCTION QTVRSetConstraints(qtvr: QTVRInstance; kind: UInt16; minValue: Single; maxValue: Single): OSErr; C;

{
  =================================================================================================
    Memory Management 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRGetAvailableResolutions(qtvr: QTVRInstance; VAR resolutionsMask: UInt16): OSErr; C;
FUNCTION QTVRGetCacheMemInfo(qtvr: QTVRInstance; resolution: UInt16; cacheDepth: SInt16; VAR minCacheBytes: SInt32; VAR suggestedCacheBytes: SInt32; VAR fullCacheBytes: SInt32): OSErr; C;
FUNCTION QTVRGetCacheSettings(qtvr: QTVRInstance; VAR resolution: UInt16; VAR cacheDepth: SInt16; VAR cacheSize: SInt16): OSErr; C;
FUNCTION QTVRSetCachePrefs(qtvr: QTVRInstance; resolution: UInt16; cacheDepth: SInt16; cacheSize: SInt16): OSErr; C;
{
  =================================================================================================
    Buffer Access 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRSetPrescreenImagingCompleteProc(qtvr: QTVRInstance; imagingCompleteProc: QTVRImagingCompleteUPP; refCon: SInt32; flags: UInt32): OSErr; C;
FUNCTION QTVRSetBackBufferImagingProc(qtvr: QTVRInstance; backBufferImagingProc: QTVRBackBufferImagingUPP; numAreas: UInt16; VAR areasOfInterest: QTVRAreaOfInterest; refCon: SInt32): OSErr; C;
FUNCTION QTVRRefreshBackBuffer(qtvr: QTVRInstance; flags: UInt32): OSErr; C;


{
  =================================================================================================
    Old Names
  -------------------------------------------------------------------------------------------------
}
{$IFC OLDROUTINENAMES }

TYPE
	CursorRecord						= QTVRCursorRecord;
	CursorRecordPtr 					= ^CursorRecord;
	AreaOfInterest						= QTVRAreaOfInterest;
	AreaOfInterestPtr 					= ^AreaOfInterest;
	FloatPoint							= QTVRFloatPoint;
	FloatPointPtr 						= ^FloatPoint;
	LeavingNodeProcPtr					= QTVRLeavingNodeProcPtr;
	LeavingNodeUPP						= QTVRLeavingNodeUPP;
	EnteringNodeProcPtr					= QTVREnteringNodeProcPtr;
	EnteringNodeUPP						= QTVREnteringNodeUPP;
	MouseOverHotSpotProcPtr				= QTVRMouseOverHotSpotProcPtr;
	MouseOverHotSpotUPP					= QTVRMouseOverHotSpotUPP;
	ImagingCompleteProcPtr				= QTVRImagingCompleteProcPtr;
	ImagingCompleteUPP					= QTVRImagingCompleteUPP;
	BackBufferImagingProcPtr			= QTVRBackBufferImagingProcPtr;
	BackBufferImagingUPP				= QTVRBackBufferImagingUPP;
{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeVRIncludes}

{$ENDC} {__QUICKTIMEVR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
