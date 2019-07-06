{
 	File:		QuickTimeVR.p
 
 	Contains:	QuickTime VR interfaces
 
 	Version:	Technology:	QuickTime VR 2.1
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1997-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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

{*****************************************************************************
 *                                                                           **
 * ABOUT QTVR_OLD_CALLS:                                                     **
 *                                                                           **
 * NOTE: Define QTVR_OLD_CALLS to 1 for your application makefile/project    **
 *       only if you are sure that you need to use the older calls for       **
 *       compatibility with VR 2.0 and 2.0.1 on the Macintosh                ** 
 *                                                                           **
 ****************************************************************************}
{$IFC UNDEFINED QTVR_OLD_CALLS }
{$SETC QTVR_OLD_CALLS := 0 }
{$ENDC}


TYPE
	QTVRInstance = ^LONGINT; { an opaque 32-bit type }


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
	kQTVRCantPanLeft			= $00000001;
	kQTVRCantPanRight			= $00000002;
	kQTVRCantPanUp				= $00000004;
	kQTVRCantPanDown			= $00000008;
	kQTVRCantZoomIn				= $00000010;
	kQTVRCantZoomOut			= $00000020;
	kQTVRCantTranslateLeft		= $00000040;
	kQTVRCantTranslateRight		= $00000080;
	kQTVRCantTranslateUp		= $00000100;
	kQTVRCantTranslateDown		= $00000200;

{  Object-only mouse mode values used to construct value returned by QTVRGetCurrentMouseMode }
	kQTVRPanning				= $00000001;					{  standard objects, "object only" controllers }
	kQTVRTranslating			= $00000002;					{  all objects }
	kQTVRZooming				= $00000004;					{  all objects }
	kQTVRScrolling				= $00000008;					{  standard object arrow scrollers and joystick object }
	kQTVRSelecting				= $00000010;					{  object absolute controller }

{  Properties for use with QTVRSetInteractionProperty/GetInteractionProperty }
	kQTVRInteractionMouseClickHysteresis = 1;					{  pixels within which the mouse is considered not to have moved (UInt16) }
	kQTVRInteractionMouseClickTimeout = 2;						{  ticks after which a mouse click times out and turns into panning (UInt32) }
	kQTVRInteractionPanTiltSpeed = 3;							{  control the relative pan/tilt speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5; }
	kQTVRInteractionZoomSpeed	= 4;							{  control the relative zooming speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5; }
	kQTVRInteractionTranslateOnMouseDown = 101;					{  Holding MouseDown with this setting translates zoomed object movies (Boolean) }
	kQTVRInteractionMouseMotionScale = 102;						{  The maximum angle of rotation caused by dragging across the display window. (* float) }
	kQTVRInteractionNudgeMode	= 103;							{  A QTVRNudgeMode: rotate, translate, or the same as the current mouse mode. Requires QTVR 2.1 }

{  OR the above with kQTVRInteractionDefaultValue to get/set the default value }
	kQTVRInteractionDefaultValue = $80000000;


{  Geometry constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo }
	kQTVRUseMovieGeometry		= 0;
	kQTVRVerticalCylinder		= 'vcyl';

{  Resolution constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo }
	kQTVRDefaultRes				= 0;
	kQTVRFullRes				= $00000001;
	kQTVRHalfRes				= $00000002;
	kQTVRQuarterRes				= $00000004;

{  QTVR-specific pixelFormat constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo }
	kQTVRUseMovieDepth			= 0;

{  Cache Size Pref constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings }
	kQTVRMinimumCache			= -1;
	kQTVRSuggestedCache			= 0;
	kQTVRFullCache				= 1;

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
																{  View Frame Animation Settings }
	kQTVRPalindromeViewFrames	= 1;
	kQTVRStartFirstViewFrame	= 2;
	kQTVRDontLoopViewFrames		= 3;
	kQTVRPlayEveryViewFrame		= 4;							{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
																{  View Animation Settings }
	kQTVRSyncViewToFrameRate	= 16;
	kQTVRPalindromeViews		= 17;
	kQTVRPlayStreamingViews		= 18;							{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }


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

CONST
	kQTVRNudgeRotate			= 0;
	kQTVRNudgeTranslate			= 1;
	kQTVRNudgeSameAsMouse		= 2;


TYPE
	QTVRNudgeMode						= UInt32;
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

{  Values for flags parameter in QTVRSetPrescreenImagingCompleteProc }
	kQTVRPreScreenEveryIdle		= $00000001;					{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }

{  Values for flags field of areasOfInterest in QTVRSetBackBufferImagingProc }
	kQTVRBackBufferEveryUpdate	= $00000001;
	kQTVRBackBufferEveryIdle	= $00000002;
	kQTVRBackBufferAlwaysRefresh = $00000004;

{  Values for flagsIn parameter in QTVRBackBufferImaging callback }
	kQTVRBackBufferRectVisible	= $00000001;
	kQTVRBackBufferWasRefreshed	= $00000002;

{  Values for flagsOut parameter in QTVRBackBufferImaging callback }
	kQTVRBackBufferFlagDidDraw	= $00000001;
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

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRLeavingNodeProcPtr = FUNCTION(qtvr: QTVRInstance; fromNodeID: UInt32; toNodeID: UInt32; VAR cancel: BOOLEAN; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRLeavingNodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVREnteringNodeProcPtr = FUNCTION(qtvr: QTVRInstance; nodeID: UInt32; refCon: SInt32): OSErr;
{$ELSEC}
	QTVREnteringNodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRMouseOverHotSpotProcPtr = FUNCTION(qtvr: QTVRInstance; hotSpotID: UInt32; flags: UInt32; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRMouseOverHotSpotProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRImagingCompleteProcPtr = FUNCTION(qtvr: QTVRInstance; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRImagingCompleteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRBackBufferImagingProcPtr = FUNCTION(qtvr: QTVRInstance; VAR drawRect: Rect; areaIndex: UInt16; flagsIn: UInt32; VAR flagsOut: UInt32; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRBackBufferImagingProcPtr = ProcPtr;
{$ENDC}

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
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewQTVRLeavingNodeUPP(userRoutine: QTVRLeavingNodeProcPtr): QTVRLeavingNodeUPP; { old name was NewQTVRLeavingNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVREnteringNodeUPP(userRoutine: QTVREnteringNodeProcPtr): QTVREnteringNodeUPP; { old name was NewQTVREnteringNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVRMouseOverHotSpotUPP(userRoutine: QTVRMouseOverHotSpotProcPtr): QTVRMouseOverHotSpotUPP; { old name was NewQTVRMouseOverHotSpotProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVRImagingCompleteUPP(userRoutine: QTVRImagingCompleteProcPtr): QTVRImagingCompleteUPP; { old name was NewQTVRImagingCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTVRBackBufferImagingUPP(userRoutine: QTVRBackBufferImagingProcPtr): QTVRBackBufferImagingUPP; { old name was NewQTVRBackBufferImagingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeQTVRLeavingNodeUPP(userUPP: QTVRLeavingNodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQTVREnteringNodeUPP(userUPP: QTVREnteringNodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQTVRMouseOverHotSpotUPP(userUPP: QTVRMouseOverHotSpotUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQTVRImagingCompleteUPP(userUPP: QTVRImagingCompleteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQTVRBackBufferImagingUPP(userUPP: QTVRBackBufferImagingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeQTVRLeavingNodeUPP(qtvr: QTVRInstance; fromNodeID: UInt32; toNodeID: UInt32; VAR cancel: BOOLEAN; refCon: SInt32; userRoutine: QTVRLeavingNodeUPP): OSErr; { old name was CallQTVRLeavingNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeQTVREnteringNodeUPP(qtvr: QTVRInstance; nodeID: UInt32; refCon: SInt32; userRoutine: QTVREnteringNodeUPP): OSErr; { old name was CallQTVREnteringNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeQTVRMouseOverHotSpotUPP(qtvr: QTVRInstance; hotSpotID: UInt32; flags: UInt32; refCon: SInt32; userRoutine: QTVRMouseOverHotSpotUPP): OSErr; { old name was CallQTVRMouseOverHotSpotProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeQTVRImagingCompleteUPP(qtvr: QTVRInstance; refCon: SInt32; userRoutine: QTVRImagingCompleteUPP): OSErr; { old name was CallQTVRImagingCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeQTVRBackBufferImagingUPP(qtvr: QTVRInstance; VAR drawRect: Rect; areaIndex: UInt16; flagsIn: UInt32; VAR flagsOut: UInt32; refCon: SInt32; userRoutine: QTVRBackBufferImagingUPP): OSErr; { old name was CallQTVRBackBufferImagingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

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
	kQTVRGetHotSpotTypeSelector	= $200B;						{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }


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
{$IFC TYPED_FUNCTION_POINTERS}
	QTVRInterceptProcPtr = PROCEDURE(qtvr: QTVRInstance; qtvrMsg: QTVRInterceptPtr; refCon: SInt32; VAR cancel: BOOLEAN);
{$ELSEC}
	QTVRInterceptProcPtr = ProcPtr;
{$ENDC}

	QTVRInterceptUPP = UniversalProcPtr;

CONST
	uppQTVRInterceptProcInfo = $00003FC0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewQTVRInterceptUPP(userRoutine: QTVRInterceptProcPtr): QTVRInterceptUPP; { old name was NewQTVRInterceptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeQTVRInterceptUPP(userUPP: QTVRInterceptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeQTVRInterceptUPP(qtvr: QTVRInstance; qtvrMsg: QTVRInterceptPtr; refCon: SInt32; VAR cancel: BOOLEAN; userRoutine: QTVRInterceptUPP); { old name was CallQTVRInterceptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
  =================================================================================================
    Initialization QTVR calls 
  -------------------------------------------------------------------------------------------------
   Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) and only work on Non-Macintosh platforms
}
{$IFC NOT TARGET_OS_MAC }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitializeQTVR: OSErr; C;
FUNCTION TerminateQTVR: OSErr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
  =================================================================================================
    General QTVR calls 
  -------------------------------------------------------------------------------------------------
}
{$IFC CALL_NOT_IN_CARBON }
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
{  QTVRInteractionNudge requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
FUNCTION QTVRInteractionNudge(qtvr: QTVRInstance; direction: QTVRNudgeControl): OSErr; C;
{
  =================================================================================================
    Scene and Node Location Information 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRGetVRWorld(qtvr: QTVRInstance; VAR VRWorld: QTAtomContainer): OSErr; C;
FUNCTION QTVRGetNodeInfo(qtvr: QTVRInstance; nodeID: UInt32; VAR nodeInfo: QTAtomContainer): OSErr; C;
FUNCTION QTVRGoToNodeID(qtvr: QTVRInstance; nodeID: UInt32): OSErr; C;
FUNCTION QTVRGetCurrentNodeID(qtvr: QTVRInstance): UInt32; C;
FUNCTION QTVRGetNodeType(qtvr: QTVRInstance; nodeID: UInt32): LONGINT; C;
{
  =================================================================================================
    Hot Spot related calls 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRPtToHotSpotID(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32): OSErr; C;
{  QTVRGetHotSpotType requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
FUNCTION QTVRGetHotSpotType(qtvr: QTVRInstance; hotSpotID: UInt32; VAR hotSpotType: OSType): OSErr; C;
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
{  These require QTVR 2.01 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion01) }
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
   QTVRGetCurrentMouseMode requires QTRVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
}
FUNCTION QTVRGetCurrentMouseMode(qtvr: QTVRInstance): UInt32; C;
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
    Back Buffer Memory Management 
  -------------------------------------------------------------------------------------------------
}

FUNCTION QTVRGetAvailableResolutions(qtvr: QTVRInstance; VAR resolutionsMask: UInt16): OSErr; C;
{  These require QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
FUNCTION QTVRGetBackBufferMemInfo(qtvr: QTVRInstance; geometry: UInt32; resolution: UInt16; cachePixelFormat: UInt32; VAR minCacheBytes: SInt32; VAR suggestedCacheBytes: SInt32; VAR fullCacheBytes: SInt32): OSErr; C;
FUNCTION QTVRGetBackBufferSettings(qtvr: QTVRInstance; VAR geometry: UInt32; VAR resolution: UInt16; VAR cachePixelFormat: UInt32; VAR cacheSize: SInt16): OSErr; C;
FUNCTION QTVRSetBackBufferPrefs(qtvr: QTVRInstance; geometry: UInt32; resolution: UInt16; cachePixelFormat: UInt32; cacheSize: SInt16): OSErr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC QTVR_OLD_CALLS }
{$IFC TARGET_OS_MAC }
{
   These ≈Cache≈ calls have been replaced with the ≈BackBuffer≈ versions above.
   However, the ≈BackBuffer≈ calls require QuickTime VR 2.1 to work;
    these calls will work with QuickTime VR 2.0 and 2.0.1, but only on a Macintosh.
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTVRGetCacheMemInfo(qtvr: QTVRInstance; resolution: UInt16; cacheDepth: SInt16; VAR minCacheBytes: SInt32; VAR suggestedCacheBytes: SInt32; VAR fullCacheBytes: SInt32): OSErr; C;
FUNCTION QTVRGetCacheSettings(qtvr: QTVRInstance; VAR resolution: UInt16; VAR cacheDepth: SInt16; VAR cacheSize: SInt16): OSErr; C;
FUNCTION QTVRSetCachePrefs(qtvr: QTVRInstance; resolution: UInt16; cacheDepth: SInt16; cacheSize: SInt16): OSErr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}
{$ENDC}  {QTVR_OLD_CALLS}

{
  =================================================================================================
    Buffer Access 
  -------------------------------------------------------------------------------------------------
}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTVRSetPrescreenImagingCompleteProc(qtvr: QTVRInstance; imagingCompleteProc: QTVRImagingCompleteUPP; refCon: SInt32; flags: UInt32): OSErr; C;
FUNCTION QTVRSetBackBufferImagingProc(qtvr: QTVRInstance; backBufferImagingProc: QTVRBackBufferImagingUPP; numAreas: UInt16; VAR areasOfInterest: QTVRAreaOfInterest; refCon: SInt32): OSErr; C;
FUNCTION QTVRRefreshBackBuffer(qtvr: QTVRInstance; flags: UInt32): OSErr; C;


{
  =================================================================================================
    Old Names
  -------------------------------------------------------------------------------------------------
}
{$ENDC}  {CALL_NOT_IN_CARBON}

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
