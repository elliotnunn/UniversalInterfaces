{
 	File:		MacWindows.p
 
 	Contains:	Window Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1997-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacWindows;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACWINDOWS__}
{$SETC __MACWINDOWS__ := 1}

{$I+}
{$SETC MacWindowsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Property Types (Mac OS 8.5 and later)												}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	PropertyCreator						= OSType;
	PropertyTag							= OSType;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Classes (Mac OS 8.5 and later)												}
{——————————————————————————————————————————————————————————————————————————————————————}
	WindowClass							= UInt32;

CONST
	kAlertWindowClass			= 1;							{  “I need your attention now.” }
	kMovableAlertWindowClass	= 2;							{  “I need your attention now, but I’m kind enough to let you switch out of this app to do other things.” }
	kModalWindowClass			= 3;							{  system modal, not draggable }
	kMovableModalWindowClass	= 4;							{  application modal, draggable }
	kFloatingWindowClass		= 5;							{  floats above all other application windows }
	kDocumentWindowClass		= 6;							{  everything else }


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Attributes (Mac OS 8.5 and later)											}
{——————————————————————————————————————————————————————————————————————————————————————}


TYPE
	WindowAttributes					= UInt32;

CONST
	kWindowNoAttributes			= 0;							{  no attributes }
	kWindowCloseBoxAttribute	= $00000001;					{  window has a close box }
	kWindowHorizontalZoomAttribute = $00000002;					{  window has horizontal zoom box }
	kWindowVerticalZoomAttribute = $00000004;					{  window has vertical zoom box }
	kWindowFullZoomAttribute	= $00000006;
	kWindowCollapseBoxAttribute	= $00000008;					{  window has a collapse box }
	kWindowResizableAttribute	= $00000010;					{  window is resizable }
	kWindowSideTitlebarAttribute = $00000020;					{  window wants a titlebar on the side	(floating window class only) }
	kWindowNoUpdatesAttribute	= $00010000;					{  this window receives no update events }
	kWindowNoActivatesAttribute	= $00020000;					{  this window receives no activate events }
	kWindowStandardDocumentAttributes = $0000001F;
	kWindowStandardFloatingAttributes = $00000009;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Errors & Gestalt (Mac OS 8.5 and later)											}
{——————————————————————————————————————————————————————————————————————————————————————}
	gestaltWindowMgrAttr		= 'wind';						{  If this Gestalt exists, the Mac OS 8.5 Window Manager is installed }
	gestaltWindowMgrPresent		= $00000001;


	errInvalidWindowPtr			= -5600;						{  tried to pass a bad WindowPtr argument }
	errUnsupportedWindowAttributesForClass = -5601;				{  tried to create a window with WindowAttributes not supported by the WindowClass }
	errWindowDoesNotHaveProxy	= -5602;						{  tried to do something requiring a proxy to a window which doesn’t have a proxy }
	errInvalidWindowProperty	= -5603;						{  tried to access a property tag with private creator }
	errWindowPropertyNotFound	= -5604;						{  tried to get a nonexistent property }
	errUnrecognizedWindowClass	= -5605;						{  tried to create a window with a bad WindowClass }
	errCorruptWindowDescription	= -5606;						{  tried to load a corrupt window description (size or version fields incorrect) }
	errUserWantsToDragWindow	= -5607;						{  if returned from TrackWindowProxyDrag, you should call DragWindow on the window }
	errWindowsAlreadyInitialized = -5608;						{  tried to call InitFloatingWindows twice, or called InitWindows and then floating windows }
	errFloatingWindowsNotInitialized = -5609;					{  called HideFloatingWindows or ShowFloatingWindows without calling InitFloatingWindows }



{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Type																}
{——————————————————————————————————————————————————————————————————————————————————————}
	kWindowDefProcType			= 'WDEF';

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Mac OS 7.5 Window Definition Resource IDs											}
{——————————————————————————————————————————————————————————————————————————————————————}
	kStandardWindowDefinition	= 0;							{  for document windows and dialogs }
	kRoundWindowDefinition		= 1;							{  old da-style window }
	kFloatingWindowDefinition	= 124;							{  for floating windows }

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Variant Codes																		}
{——————————————————————————————————————————————————————————————————————————————————————}
																{  for use with kStandardWindowDefinition  }
	kDocumentWindowVariantCode	= 0;
	kModalDialogVariantCode		= 1;
	kPlainDialogVariantCode		= 2;
	kShadowDialogVariantCode	= 3;
	kMovableModalDialogVariantCode = 5;
	kAlertVariantCode			= 7;
	kMovableAlertVariantCode	= 9;							{  for use with kFloatingWindowDefinition  }
	kSideFloaterVariantCode		= 8;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • DefProc IDs																		}
{——————————————————————————————————————————————————————————————————————————————————————}
																{  classic ids  }
	documentProc				= 0;
	dBoxProc					= 1;
	plainDBox					= 2;
	altDBoxProc					= 3;
	noGrowDocProc				= 4;
	movableDBoxProc				= 5;
	zoomDocProc					= 8;
	zoomNoGrow					= 12;
	rDocProc					= 16;							{  floating window defproc ids  }
	floatProc					= 1985;
	floatGrowProc				= 1987;
	floatZoomProc				= 1989;
	floatZoomGrowProc			= 1991;
	floatSideProc				= 1993;
	floatSideGrowProc			= 1995;
	floatSideZoomProc			= 1997;
	floatSideZoomGrowProc		= 1999;

																{  Resource IDs for theme-savvy window defprocs  }
	kWindowDocumentDefProcResID	= 64;
	kWindowDialogDefProcResID	= 65;
	kWindowUtilityDefProcResID	= 66;
	kWindowUtilitySideTitleDefProcResID = 67;

																{  Proc IDs for theme-savvy windows  }
	kWindowDocumentProc			= 1024;
	kWindowGrowDocumentProc		= 1025;
	kWindowVertZoomDocumentProc	= 1026;
	kWindowVertZoomGrowDocumentProc = 1027;
	kWindowHorizZoomDocumentProc = 1028;
	kWindowHorizZoomGrowDocumentProc = 1029;
	kWindowFullZoomDocumentProc	= 1030;
	kWindowFullZoomGrowDocumentProc = 1031;

																{  Proc IDs for theme-savvy dialogs  }
	kWindowPlainDialogProc		= 1040;
	kWindowShadowDialogProc		= 1041;
	kWindowModalDialogProc		= 1042;
	kWindowMovableModalDialogProc = 1043;
	kWindowAlertProc			= 1044;
	kWindowMovableAlertProc		= 1045;

																{  procIDs available in Mac OS 8.1 (Appearance 1.0.1) or later  }
	kWindowMovableModalGrowProc	= 1046;

																{  Proc IDs for top title bar theme-savvy floating windows  }
	kWindowFloatProc			= 1057;
	kWindowFloatGrowProc		= 1059;
	kWindowFloatVertZoomProc	= 1061;
	kWindowFloatVertZoomGrowProc = 1063;
	kWindowFloatHorizZoomProc	= 1065;
	kWindowFloatHorizZoomGrowProc = 1067;
	kWindowFloatFullZoomProc	= 1069;
	kWindowFloatFullZoomGrowProc = 1071;


																{  Proc IDs for side title bar theme-savvy floating windows  }
	kWindowFloatSideProc		= 1073;
	kWindowFloatSideGrowProc	= 1075;
	kWindowFloatSideVertZoomProc = 1077;
	kWindowFloatSideVertZoomGrowProc = 1079;
	kWindowFloatSideHorizZoomProc = 1081;
	kWindowFloatSideHorizZoomGrowProc = 1083;
	kWindowFloatSideFullZoomProc = 1085;
	kWindowFloatSideFullZoomGrowProc = 1087;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • System 7 Window Positioning Constants												}
{																						}
{ Passed into StandardAlert and used in ‘WIND’, ‘DLOG’, and ‘ALRT’ templates			}
{ StandardAlert uses zero to specify the default position. Other calls use zero to		}
{ specify “no position”.  Do not pass these constants to RepositionWindow.  Do not		}
{ store these constants in the BasicWindowDescription of a ‘wind’ resource.			}
{——————————————————————————————————————————————————————————————————————————————————————}

	kWindowNoPosition			= $0000;
	kWindowDefaultPosition		= $0000;						{  used by StandardAlert }
	kWindowCenterMainScreen		= $280A;
	kWindowAlertPositionMainScreen = $300A;
	kWindowStaggerMainScreen	= $380A;
	kWindowCenterParentWindow	= $A80A;
	kWindowAlertPositionParentWindow = $B00A;
	kWindowStaggerParentWindow	= $B80A;
	kWindowCenterParentWindowScreen = $680A;
	kWindowAlertPositionParentWindowScreen = $700A;
	kWindowStaggerParentWindowScreen = $780A;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Positioning Methods	(Mac OS 8.5 and later)									}
{																						}
{ Positioning methods passed to RepositionWindow.										}
{ Do not use them in WIND, ALRT, DLOG templates.  										}
{ Do not confuse these constants with the constants above								}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowPositionMethod				= UInt32;

CONST
	kWindowCenterOnMainScreen	= $00000001;
	kWindowCenterOnParentWindow	= $00000002;
	kWindowCenterOnParentWindowScreen = $00000003;
	kWindowCascadeOnMainScreen	= $00000004;
	kWindowCascadeOnParentWindow = $00000005;
	kWIndowCascadeOnParentWindowScreen = $00000006;
	kWindowAlertPositionOnMainScreen = $00000007;
	kWindowAlertPositionOnParentWindow = $00000008;
	kWindowAlertPositionOnParentWindowScreen = $00000009;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • GetWindowRegion Types																}
{——————————————————————————————————————————————————————————————————————————————————————}

																{  Region values to pass into GetWindowRegion  }
	kWindowTitleBarRgn			= 0;
	kWindowTitleTextRgn			= 1;
	kWindowCloseBoxRgn			= 2;
	kWindowZoomBoxRgn			= 3;
	kWindowDragRgn				= 5;
	kWindowGrowRgn				= 6;
	kWindowCollapseBoxRgn		= 7;
	kWindowTitleProxyIconRgn	= 8;							{  Mac OS 8.5 and later }
	kWindowStructureRgn			= 32;
	kWindowContentRgn			= 33;



TYPE
	WindowRegionCode					= UInt16;
{  GetWindowRegionRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion }
	GetWindowRegionRecPtr = ^GetWindowRegionRec;
	GetWindowRegionRec = RECORD
		winRgn:					RgnHandle;
		regionCode:				WindowRegionCode;
	END;

	GetWindowRegionPtr					= ^GetWindowRegionRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • WDEF Message Types (Mac OS 8.5 and later)											}
{——————————————————————————————————————————————————————————————————————————————————————}
{
   SetupWindowProxyDragImageRec - setup the proxy icon drag image
   Both regions are allocated and disposed by the Window Manager.
   The GWorld is disposed of by the Window Manager, but the WDEF must allocate
   it.  See Technote on Drag Manager 1.1 additions for more information and sample code for
   setting up drag images.
}

	SetupWindowProxyDragImageRecPtr = ^SetupWindowProxyDragImageRec;
	SetupWindowProxyDragImageRec = RECORD
		imageGWorld:			GWorldPtr;								{  locked GWorld containing the drag image - output - can be NULL }
		imageRgn:				RgnHandle;								{  image clip region, contains the portion of the image which gets blitted to screen - preallocated output - if imageGWorld is NULL, this is ignored }
		outlineRgn:				RgnHandle;								{  the outline region used on shallow monitors - preallocated output - must always be non-empty }
	END;

{  MeasureWindowTitleRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion }
	MeasureWindowTitleRecPtr = ^MeasureWindowTitleRec;
	MeasureWindowTitleRec = RECORD
																		{  output parameters }
		fullTitleWidth:			SInt16;									{  text + proxy icon width }
		titleTextWidth:			SInt16;									{  text width }
																		{  input parameters }
		isUnicodeTitle:			BOOLEAN;
		unused:					BOOLEAN;								{  future use }
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Standard Window Kinds																}
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	dialogKind					= 2;
	userKind					= 8;
	kDialogWindowKind			= 2;
	kApplicationWindowKind		= 8;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • FindWindow Result Codes															}
{——————————————————————————————————————————————————————————————————————————————————————}
	inDesk						= 0;
	inNoWindow					= 0;
	inMenuBar					= 1;
	inSysWindow					= 2;
	inContent					= 3;
	inDrag						= 4;
	inGrow						= 5;
	inGoAway					= 6;
	inZoomIn					= 7;
	inZoomOut					= 8;
	inCollapseBox				= 11;							{  Mac OS 8.0 and later }
	inProxyIcon					= 12;							{  Mac OS 8.5 and later }


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Hit Test Result Codes											}
{——————————————————————————————————————————————————————————————————————————————————————}
	wNoHit						= 0;
	wInContent					= 1;
	wInDrag						= 2;
	wInGrow						= 3;
	wInGoAway					= 4;
	wInZoomIn					= 5;
	wInZoomOut					= 6;
	wInCollapseBox				= 9;							{  Mac OS 8.0 and later }
	wInProxyIcon				= 10;							{  Mac OS 8.5 and later }


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Messages															}
{——————————————————————————————————————————————————————————————————————————————————————}

	kWindowMsgDraw				= 0;
	kWindowMsgHitTest			= 1;
	kWindowMsgCalculateShape	= 2;
	kWindowMsgInitialize		= 3;
	kWindowMsgCleanUp			= 4;
	kWindowMsgDrawGrowOutline	= 5;
	kWindowMsgDrawGrowBox		= 6;

{  Messages available in Mac OS 8.0 and later }
	kWindowMsgGetFeatures		= 7;
	kWindowMsgGetRegion			= 8;

{  Messages available in Mac OS 8.5 and later }
	kWindowMsgDragHilite		= 9;							{  parameter boolean indicating on or off }
	kWindowMsgModified			= 10;							{  parameter boolean indicating saved (false) or modified (true) }
	kWindowMsgDrawInCurrentPort	= 11;							{  same as kWindowMsgDraw, but must draw in current port }
	kWindowMsgSetupProxyDragImage = 12;							{  parameter pointer to SetupWindowProxyDragImageRec }
	kWindowMsgStateChanged		= 13;							{  something about the window's state has changed }
	kWindowMsgMeasureTitle		= 14;							{  measure and return the ideal title width }

{  old names }
	wDraw						= 0;
	wHit						= 1;
	wCalcRgns					= 2;
	wNew						= 3;
	wDispose					= 4;
	wGrow						= 5;
	wDrawGIcon					= 6;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • State-changed Flags for kWindowMsgStateChanged (Mac OS 8.5 and later)				}
{——————————————————————————————————————————————————————————————————————————————————————}
	kWindowStateTitleChanged	= $01;
	kWindowStateSizeChanged		= $02;
	kWindowStatePositionChanged	= $04;
	kWindowStateZOrderChanged	= $08;
	kWindowStateVisibilityChanged = $10;
	kWindowStateHiliteChanged	= $20;
	kWindowStateCollapseChanged	= $40;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Feature Bits																}
{——————————————————————————————————————————————————————————————————————————————————————}
	kWindowCanGrow				= $01;
	kWindowCanZoom				= $02;
	kWindowCanCollapse			= $04;
	kWindowIsModal				= $08;
	kWindowCanGetWindowRegion	= $10;
	kWindowIsAlert				= $20;
	kWindowHasTitleBar			= $40;

{  Message bits available in Mac OS 8.5 and later }
	kWindowSupportsDragHilite	= $80;							{  window definition supports kWindowMsgDragHilite }
	kWindowSupportsModifiedBit	= $0100;						{  window definition supports kWindowMsgModified }
	kWindowCanDrawInCurrentPort	= $0200;						{  window definition supports kWindowMsgDrawInCurrentPort }
	kWindowCanSetupProxyDragImage = $0400;						{  window definition supports kWindowMsgSetupProxyDragImage }
	kWindowCanMeasureTitle		= $0800;						{  window definition supports kWindowMsgMeasureTitle }
	kWindowWantsDisposeAtProcessDeath = $1000;					{  window definition wants a Dispose message for windows still extant during ExitToShell }


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Desktop Pattern Resource ID														}
{——————————————————————————————————————————————————————————————————————————————————————}
	deskPatID					= 16;



{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Color Part Codes															}
{——————————————————————————————————————————————————————————————————————————————————————}
	wContentColor				= 0;
	wFrameColor					= 1;
	wTextColor					= 2;
	wHiliteColor				= 3;
	wTitleBarColor				= 4;


{——————————————————————————————————————————————————————————————————————————————————————}
{	• Region Dragging Constants															}
{——————————————————————————————————————————————————————————————————————————————————————}

	kMouseUpOutOfSlop			= $80008000;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Color Table																	}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WinCTabPtr = ^WinCTab;
	WinCTab = RECORD
		wCSeed:					LONGINT;								{  reserved  }
		wCReserved:				INTEGER;								{  reserved  }
		ctSize:					INTEGER;								{  usually 4 for windows  }
		ctTable:				ARRAY [0..4] OF ColorSpec;
	END;

	WCTabPtr							= ^WinCTab;
	WCTabHandle							= ^WCTabPtr;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • WindowRecord																		}
{——————————————————————————————————————————————————————————————————————————————————————}
	WindowRecordPtr = ^WindowRecord;
	WindowPeek							= ^WindowRecord;
	WindowRecord = RECORD
		port:					GrafPort;
		windowKind:				INTEGER;
		visible:				BOOLEAN;
		hilited:				BOOLEAN;
		goAwayFlag:				BOOLEAN;
		spareFlag:				BOOLEAN;
		strucRgn:				RgnHandle;
		contRgn:				RgnHandle;
		updateRgn:				RgnHandle;
		windowDefProc:			Handle;
		dataHandle:				Handle;
		titleHandle:			StringHandle;
		titleWidth:				INTEGER;
		controlList:			Handle;
		nextWindow:				WindowPeek;
		windowPic:				PicHandle;
		refCon:					LONGINT;
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Color WindowRecord																	}
{——————————————————————————————————————————————————————————————————————————————————————}
	CWindowRecordPtr = ^CWindowRecord;
	CWindowPeek							= ^CWindowRecord;
	CWindowRecord = RECORD
		port:					CGrafPort;
		windowKind:				INTEGER;
		visible:				BOOLEAN;
		hilited:				BOOLEAN;
		goAwayFlag:				BOOLEAN;
		spareFlag:				BOOLEAN;
		strucRgn:				RgnHandle;
		contRgn:				RgnHandle;
		updateRgn:				RgnHandle;
		windowDefProc:			Handle;
		dataHandle:				Handle;
		titleHandle:			StringHandle;
		titleWidth:				INTEGER;
		controlList:			Handle;
		nextWindow:				CWindowPeek;
		windowPic:				PicHandle;
		refCon:					LONGINT;
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • AuxWinHandle																		}
{——————————————————————————————————————————————————————————————————————————————————————}
	AuxWinRecPtr = ^AuxWinRec;
	AuxWinPtr							= ^AuxWinRec;
	AuxWinHandle						= ^AuxWinPtr;
	AuxWinRec = RECORD
		awNext:					AuxWinHandle;							{ handle to next AuxWinRec }
		awOwner:				WindowPtr;								{ ptr to window  }
		awCTable:				CTabHandle;								{ color table for this window }
		reserved:				Handle;
		awFlags:				LONGINT;								{ reserved for expansion }
		awReserved:				CTabHandle;								{ reserved for expansion }
		awRefCon:				LONGINT;								{ user Constant }
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• BasicWindowDescription	(Mac OS 8.5 and later)									}
{																						}
{	Contains statically-sized basic attributes of the window, for storage in a			}
{	collection item.																	}
{——————————————————————————————————————————————————————————————————————————————————————}
{  constants for the version field }

CONST
	kWindowDefinitionVersionOne	= 1;
	kWindowDefinitionVersionTwo	= 2;

{  constants for the stateflags bit field  }
	kWindowIsCollapsedState		= $01;


TYPE
	BasicWindowDescriptionPtr = ^BasicWindowDescription;
	BasicWindowDescription = RECORD
		descriptionSize:		UInt32;									{  sizeof(BasicWindowDescription) }
		windowContentRect:		Rect;									{  location on screen }
		windowZoomRect:			Rect;									{  location on screen when zoomed out }
		windowRefCon:			UInt32;									{  the refcon - __avoid saving stale pointers here__	 }
		windowStateFlags:		UInt32;									{  flags indicating status of transient window state }
		windowPositionMethod:	WindowPositionMethod;					{  method last used by RepositionWindow to position the window (if any) }
		windowDefinitionVersion: UInt32;
		CASE INTEGER OF
		0: (
			windowDefProc:		SInt16;									{  defProc and variant }
			windowHasCloseBox:	BOOLEAN;
		   );
		1: (
			windowClass:		WindowClass;							{  the class }
			windowAttributes:	WindowAttributes;						{  the attributes }
		   );
	END;

{   the window manager stores the default collection items using these IDs }

CONST
	kStoredWindowSystemTag		= 'appl';						{  Only Apple collection items will be of this tag }
	kStoredBasicWindowDescriptionID = 'sbas';					{  BasicWindowDescription }
	kStoredWindowPascalTitleID	= 's255';						{  pascal title string }

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Class Ordering																}
{																						}
{	Special cases for the “behind” parameter in window creation calls.					}
{——————————————————————————————————————————————————————————————————————————————————————}
	kFirstWindowOfClass			= -1;
	kLastWindowOfClass			= 0;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Zoom Information Handle 															}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WStateDataPtr = ^WStateData;
	WStateData = RECORD
		userState:				Rect;									{ user zoom state }
		stdState:				Rect;									{ standard zoom state }
	END;

	WStateDataHandle					= ^WStateDataPtr;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Creation & Persistence														}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetNewCWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowPtr): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA46;
	{$ENDC}
FUNCTION NewWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A913;
	{$ENDC}
FUNCTION GetNewWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowPtr): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BD;
	{$ENDC}
FUNCTION NewCWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA45;
	{$ENDC}
PROCEDURE DisposeWindow(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A914;
	{$ENDC}
PROCEDURE CloseWindow(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92D;
	{$ENDC}

{  Routines available in Mac OS 8.5 and later }

FUNCTION CreateNewWindow(windowClass: WindowClass; attributes: WindowAttributes; {CONST}VAR bounds: Rect; VAR outWindow: WindowPtr): OSStatus;
{  Create a window from a ‘wind’ resource }
FUNCTION CreateWindowFromResource(resID: SInt16; VAR outWindow: WindowPtr): OSStatus;
{  window persistence }
FUNCTION StoreWindowIntoCollection(window: WindowPtr; collection: Collection): OSStatus;
FUNCTION CreateWindowFromCollection(collection: Collection; VAR outWindow: WindowPtr): OSStatus;
{  window refcounting }
FUNCTION GetWindowOwnerCount(window: WindowPtr; VAR outCount: UInt32): OSStatus;
FUNCTION CloneWindow(window: WindowPtr): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Class Accessors (Mac OS 8.5 and later)										}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetWindowClass(window: WindowPtr; VAR outClass: WindowClass): OSStatus;
FUNCTION GetWindowAttributes(window: WindowPtr; VAR outAttributes: WindowAttributes): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Floating Windows (Mac OS 8.5 and later)											}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION ShowFloatingWindows: OSStatus;
FUNCTION HideFloatingWindows: OSStatus;
FUNCTION AreFloatingWindowsVisible: BOOLEAN;
FUNCTION FrontNonFloatingWindow: WindowPtr;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Background Imaging																	}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE SetWinColor(window: WindowPtr; newColorTable: WCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA41;
	{$ENDC}
PROCEDURE SetDeskCPat(deskPixPat: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA47;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later }

FUNCTION SetWindowContentColor(window: WindowPtr; VAR color: RGBColor): OSStatus;
FUNCTION GetWindowContentColor(window: WindowPtr; VAR color: RGBColor): OSStatus;
FUNCTION GetWindowContentPattern(window: WindowPtr; outPixPat: PixPatHandle): OSStatus;
FUNCTION SetWindowContentPattern(window: WindowPtr; pixPat: PixPatHandle): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Low-Level Region & Painting Routines												}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE ClipAbove(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90B;
	{$ENDC}
PROCEDURE SaveOld(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90E;
	{$ENDC}
PROCEDURE DrawNew(window: WindowPtr; update: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90F;
	{$ENDC}
PROCEDURE PaintOne(window: WindowPtr; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90C;
	{$ENDC}
PROCEDURE PaintBehind(startWindow: WindowPtr; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90D;
	{$ENDC}
PROCEDURE CalcVis(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A909;
	{$ENDC}
PROCEDURE CalcVisBehind(startWindow: WindowPtr; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90A;
	{$ENDC}
FUNCTION CheckUpdate(VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A911;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window List																		}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION FindWindow(thePoint: Point; VAR window: WindowPtr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92C;
	{$ENDC}
FUNCTION FrontWindow: WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A924;
	{$ENDC}
PROCEDURE BringToFront(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A920;
	{$ENDC}
PROCEDURE SendBehind(window: WindowPtr; behindWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A921;
	{$ENDC}
PROCEDURE SelectWindow(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91F;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Misc Low-Level stuff																}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE InitWindows;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A912;
	{$ENDC}
PROCEDURE GetWMgrPort(VAR wPort: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A910;
	{$ENDC}
PROCEDURE GetCWMgrPort(VAR wMgrCPort: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA48;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later }

FUNCTION IsValidWindowPtr(grafPort: GrafPtr): BOOLEAN;
FUNCTION InitFloatingWindows: OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Various & Sundry Window Accessors													}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE HiliteWindow(window: WindowPtr; fHilite: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91C;
	{$ENDC}
PROCEDURE SetWRefCon(window: WindowPtr; data: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A918;
	{$ENDC}
FUNCTION GetWRefCon(window: WindowPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A917;
	{$ENDC}
PROCEDURE SetWindowPic(window: WindowPtr; pic: PicHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92E;
	{$ENDC}
FUNCTION GetWindowPic(window: WindowPtr): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92F;
	{$ENDC}
FUNCTION GetWVariant(window: WindowPtr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80A;
	{$ENDC}
{  Routines available in Mac OS 8.0 (Appearance 1.0) and later }
FUNCTION GetWindowFeatures(window: WindowPtr; VAR outFeatures: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA74;
	{$ENDC}
FUNCTION GetWindowRegion(window: WindowPtr; inRegionCode: WindowRegionCode; ioWinRgn: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA74;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Update Events																		}
{——————————————————————————————————————————————————————————————————————————————————————}

PROCEDURE InvalRect({CONST}VAR badRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A928;
	{$ENDC}
PROCEDURE InvalRgn(badRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A927;
	{$ENDC}
PROCEDURE ValidRect({CONST}VAR goodRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92A;
	{$ENDC}
PROCEDURE ValidRgn(goodRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A929;
	{$ENDC}
PROCEDURE BeginUpdate(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A922;
	{$ENDC}
PROCEDURE EndUpdate(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A923;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later }
FUNCTION InvalWindowRgn(window: WindowPtr; region: RgnHandle): OSStatus;
FUNCTION InvalWindowRect(window: WindowPtr; {CONST}VAR bounds: Rect): OSStatus;
FUNCTION ValidWindowRgn(window: WindowPtr; region: RgnHandle): OSStatus;
FUNCTION ValidWindowRect(window: WindowPtr; {CONST}VAR bounds: Rect): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • DrawGrowIcon																		}
{																						}
{	DrawGrowIcon is deprecated in Mac OS 8.0 and later.  Theme-savvy window defprocs	}
{	include the grow box in the window frame automatically.								}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE DrawGrowIcon(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A904;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Titles																		}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE SetWTitle(window: WindowPtr; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91A;
	{$ENDC}
PROCEDURE GetWTitle(window: WindowPtr; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A919;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Proxies (Mac OS 8.5 and later)												}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION SetWindowProxyFSSpec(window: WindowPtr; {CONST}VAR inFile: FSSpec): OSStatus;
FUNCTION GetWindowProxyFSSpec(window: WindowPtr; VAR outFile: FSSpec): OSStatus;
FUNCTION SetWindowProxyAlias(window: WindowPtr; alias: AliasHandle): OSStatus;
FUNCTION GetWindowProxyAlias(window: WindowPtr; VAR alias: AliasHandle): OSStatus;
FUNCTION SetWindowProxyCreatorAndType(window: WindowPtr; fileCreator: OSType; fileType: OSType; vRefNum: SInt16): OSStatus;
FUNCTION GetWindowProxyIcon(window: WindowPtr; VAR outIcon: IconRef): OSStatus;
FUNCTION SetWindowProxyIcon(window: WindowPtr; icon: IconRef): OSStatus;
FUNCTION RemoveWindowProxy(window: WindowPtr): OSStatus;
FUNCTION BeginWindowProxyDrag(window: WindowPtr; VAR outNewDrag: DragReference; outDragOutlineRgn: RgnHandle): OSStatus;
FUNCTION EndWindowProxyDrag(window: WindowPtr; theDrag: DragReference): OSStatus;
FUNCTION TrackWindowProxyFromExistingDrag(window: WindowPtr; startPt: Point; drag: DragReference; inDragOutlineRgn: RgnHandle): OSStatus;
FUNCTION TrackWindowProxyDrag(window: WindowPtr; startPt: Point): OSStatus;
FUNCTION IsWindowModified(window: WindowPtr): BOOLEAN;
FUNCTION SetWindowModified(window: WindowPtr; modified: BOOLEAN): OSStatus;
FUNCTION IsWindowPathSelectClick(window: WindowPtr; VAR event: EventRecord): BOOLEAN;
FUNCTION WindowPathSelect(window: WindowPtr; menu: MenuHandle; VAR outMenuResult: SInt32): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• HiliteWindowFrameForDrag	(Mac OS 8.5 and later)									}
{																						}
{	If you call ShowDragHilite and HideDragHilite, you don’t need to use this routine.	}
{	If you implement custom drag hiliting, you should call HiliteWindowFrameForDrag		}
{	when the drag is tracking inside a window with drag-hilited content.				}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION HiliteWindowFrameForDrag(window: WindowPtr; hilited: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $A829;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Transitions	(Mac OS 8.5 and later)											}
{ 																						}
{ 	TransitionWindow displays a window with accompanying animation and sound.			}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowTransitionEffect				= UInt32;

CONST
	kWindowZoomTransitionEffect	= 1;							{  Finder-like zoom rectangles, use with Show or Open transition actions }


TYPE
	WindowTransitionAction				= UInt32;

CONST
	kWindowShowTransitionAction	= 1;							{  param is rect in global coordinates from which to start the animation }
	kWindowHideTransitionAction	= 2;							{  param is rect in global coordinates at which to end the animation }

FUNCTION TransitionWindow(window: WindowPtr; effect: WindowTransitionEffect; action: WindowTransitionAction; rect: {Const}RectPtr): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Positioning																	}
{——————————————————————————————————————————————————————————————————————————————————————}

PROCEDURE MoveWindow(window: WindowPtr; hGlobal: INTEGER; vGlobal: INTEGER; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91B;
	{$ENDC}
PROCEDURE SizeWindow(window: WindowPtr; w: INTEGER; h: INTEGER; fUpdate: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91D;
	{$ENDC}
FUNCTION GrowWindow(window: WindowPtr; startPt: Point; {CONST}VAR bBox: Rect): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92B;
	{$ENDC}
PROCEDURE DragWindow(window: WindowPtr; startPt: Point; {CONST}VAR boundsRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A925;
	{$ENDC}
PROCEDURE ZoomWindow(window: WindowPtr; partCode: INTEGER; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83A;
	{$ENDC}
{  Routines available in Mac OS 8.0 (Appearance 1.0) and later }

FUNCTION IsWindowCollapsable(window: WindowPtr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA74;
	{$ENDC}
FUNCTION IsWindowCollapsed(window: WindowPtr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA74;
	{$ENDC}
FUNCTION CollapseWindow(window: WindowPtr; collapse: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA74;
	{$ENDC}
FUNCTION CollapseAllWindows(collapse: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA74;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later }

FUNCTION RepositionWindow(window: WindowPtr; parentWindow: WindowPtr; method: WindowPositionMethod): OSStatus;
FUNCTION SetWindowBounds(window: WindowPtr; regionCode: WindowRegionCode; {CONST}VAR globalBounds: Rect): OSStatus;
FUNCTION GetWindowBounds(window: WindowPtr; regionCode: WindowRegionCode; VAR globalBounds: Rect): OSStatus;
FUNCTION MoveWindowStructure(window: WindowPtr; hGlobal: INTEGER; vGlobal: INTEGER): OSStatus;
FUNCTION ResizeWindow(window: WindowPtr; startPoint: Point; sizeConstraints: {Const}RectPtr; VAR newContentRect: Rect): BOOLEAN;
FUNCTION IsWindowInStandardState(window: WindowPtr; VAR idealSize: Point; VAR idealStandardState: Rect): BOOLEAN;
FUNCTION ZoomWindowIdeal(window: WindowPtr; partCode: SInt16; VAR ioIdealSize: Point): OSStatus;
FUNCTION GetWindowIdealUserState(window: WindowPtr; VAR userState: Rect): OSStatus;
FUNCTION SetWindowIdealUserState(window: WindowPtr; VAR userState: Rect): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Visibility																	}
{——————————————————————————————————————————————————————————————————————————————————————}

PROCEDURE HideWindow(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A916;
	{$ENDC}
PROCEDURE ShowWindow(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A915;
	{$ENDC}
PROCEDURE ShowHide(window: WindowPtr; showFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A908;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Properties (Mac OS 8.5 and later)											}
{——————————————————————————————————————————————————————————————————————————————————————}

FUNCTION GetWindowProperty(window: WindowPtr; propertyCreator: PropertyCreator; propertyTag: PropertyTag; bufferSize: UInt32; VAR actualSize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;
FUNCTION GetWindowPropertySize(window: WindowPtr; creator: PropertyCreator; tag: PropertyTag; VAR size: UInt32): OSStatus;
FUNCTION SetWindowProperty(window: WindowPtr; propertyCreator: PropertyCreator; propertyTag: PropertyTag; propertySize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;
FUNCTION RemoveWindowProperty(window: WindowPtr; propertyCreator: PropertyCreator; propertyTag: PropertyTag): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Utilities																			}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION PinRect({CONST}VAR theRect: Rect; thePt: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94E;
	{$ENDC}

FUNCTION GetGrayRgn: RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $09EE;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Part Tracking																}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION TrackBox(window: WindowPtr; thePt: Point; partCode: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83B;
	{$ENDC}
FUNCTION TrackGoAway(window: WindowPtr; thePt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91E;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Region Dragging																	}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION DragGrayRgn(theRgn: RgnHandle; startPt: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: INTEGER; actionProc: DragGrayRgnUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A905;
	{$ENDC}
FUNCTION DragTheRgn(theRgn: RgnHandle; startPt: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: INTEGER; actionProc: DragGrayRgnUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A926;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{	• GetAuxWin																			}
{																						}
{	Avoid using GetAuxWin if at all possible											}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetAuxWin(window: WindowPtr; VAR awHndl: AuxWinHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA42;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • MixedMode & ProcPtrs																}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	WindowDefProcPtr = FUNCTION(varCode: INTEGER; window: WindowPtr; message: INTEGER; param: LONGINT): LONGINT;
{$ELSEC}
	WindowDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DeskHookProcPtr = PROCEDURE(mouseClick: BOOLEAN; VAR theEvent: EventRecord);
{$ELSEC}
	DeskHookProcPtr = Register68kProcPtr;
{$ENDC}

	WindowDefUPP = UniversalProcPtr;
	DeskHookUPP = UniversalProcPtr;

CONST
	uppWindowDefProcInfo = $00003BB0;
	uppDeskHookProcInfo = $00130802;

FUNCTION NewWindowDefProc(userRoutine: WindowDefProcPtr): WindowDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDeskHookProc(userRoutine: DeskHookProcPtr): DeskHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallWindowDefProc(varCode: INTEGER; window: WindowPtr; message: INTEGER; param: LONGINT; userRoutine: WindowDefUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDeskHookProc(mouseClick: BOOLEAN; VAR theEvent: EventRecord; userRoutine: DeskHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • C Glue																				}
{——————————————————————————————————————————————————————————————————————————————————————}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • WindowRecord accessor macros														}
{——————————————————————————————————————————————————————————————————————————————————————}
{
	*****************************************************************************
	*                                                                           *
	* The conditional STRICT_WINDOWS has been removed from this interface file. *
	* The accessor macros to a WindowRecord are no longer necessary.            *
	*                                                                           *
	* All ≈Ref Types have reverted to their original Handle and Ptr Types.      *
	*                                                                           *
	*****************************************************************************

	Details:
	The original purpose of the STRICT_ conditionals and accessor macros was to
	help ease the transition to Copland.  Shared data structures are difficult
	to coordinate in a preemptive multitasking OS.  By hiding the fields in a
	WindowRecord and other data structures, we would begin the migration to the
	discipline wherein system data structures are completely hidden from
	applications.
	
	After many design reviews, we finally concluded that with this sort of
	migration, the system could never tell when an application was no longer
	peeking at a WindowRecord, and thus the data structure might never become
	system owned.  Additionally, there were many other limitations in the
	classic toolbox that were begging to be addressed.  The final decision was
	to leave the traditional toolbox as a compatibility mode.
	
	We also decided to use the Handle and Ptr based types in the function
	declarations.  For example, NewWindow now returns a WindowPtr rather than a
	WindowRef.  The Ref types are still defined in the header files, so all
	existing code will still compile exactly as it did before.  There are
	several reasons why we chose to do this:
	
	- The importance of backwards compatibility makes it unfeasible for us to
	enforce real opaque references in the implementation anytime in the
	foreseeable future.  Therefore, any opaque data types (e.g. WindowRef,
	ControlRef, etc.) in the documentation and header files would always be a
	fake veneer of opacity.
	
	- There exists a significant base of books and sample code that neophyte
	Macintosh developers use to learn how to program the Macintosh.  These
	books and sample code all use direct data access.  Introducing opaque data
	types at this point would confuse neophyte programmers more than it would
	help them.
	
	- Direct data structure access is used by nearly all Macintosh developers. 
	Changing the interfaces to reflect a false opacity would not provide any
	benefit to these developers.
	
	- Accessor functions are useful in and of themselves as convenience
	functions.
	
	- Note: some accessor names conflict with API's in Win32 and have been renamed
	to have a Mac prefix (QuickTime 3.0).
}









{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacWindowsIncludes}

{$ENDC} {__MACWINDOWS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
