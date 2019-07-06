{
     File:       MacWindows.p
 
     Contains:   Window Manager Interfaces
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1997-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
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
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{                                                                                                      }
{ Current documentation for the Mac OS Window Manager is available on the web:                         }
{  <http://developer.apple.com/techpubs/macos8/HumanInterfaceToolbox/WindowManager/windowmanager.html> }
{                                                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Property Types                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	PropertyCreator						= OSType;
	PropertyTag							= OSType;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Classes                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
	WindowClass 				= UInt32;
CONST
	kAlertWindowClass			= 1;							{  “I need your attention now.” }
	kMovableAlertWindowClass	= 2;							{  “I need your attention now, but I’m kind enough to let you switch out of this app to do other things.” }
	kModalWindowClass			= 3;							{  system modal, not draggable }
	kMovableModalWindowClass	= 4;							{  application modal, draggable }
	kFloatingWindowClass		= 5;							{  floats above all other application windows }
	kDocumentWindowClass		= 6;							{  document windows }
	kDesktopWindowClass			= 7;							{  desktop window (usually only one of these exists) - OS X only }
	kAllWindowClasses			= $FFFFFFFF;					{  for use with GetFrontWindowOfClass, FindWindowOfClass, GetNextWindowOfClass }


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Attributes                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}


TYPE
	WindowAttributes					= UInt32;

CONST
	kWindowNoAttributes			= 0;							{  no attributes  }
	kWindowCloseBoxAttribute	= $00000001;					{  window has a close box  }
	kWindowHorizontalZoomAttribute = $00000002;					{  window has horizontal zoom box  }
	kWindowVerticalZoomAttribute = $00000004;					{  window has vertical zoom box  }
	kWindowFullZoomAttribute	= $00000006;
	kWindowCollapseBoxAttribute	= $00000008;					{  window has a collapse box  }
	kWindowResizableAttribute	= $00000010;					{  window is resizable  }
	kWindowSideTitlebarAttribute = $00000020;					{  window wants a titlebar on the side    (floating window class only)  }
	kWindowNoUpdatesAttribute	= $00010000;					{  this window receives no update events  }
	kWindowNoActivatesAttribute	= $00020000;					{  this window receives no activate events  }
	kWindowNoBufferingAttribute	= $00100000;					{  this window is not buffered (Mac OS X only)  }
	kWindowHideOnSuspendAttribute = $01000000;					{  this window is automatically hidden on suspend and shown on resume (Carbon only)  }
																{  floating windows get kWindowHideOnSuspendAttribute automatically }
	kWindowStandardHandlerAttribute = $02000000;				{  this window should have the standard toolbox window event handler installed (Carbon only)  }
	kWindowStandardDocumentAttributes = $0000001F;
	kWindowStandardFloatingAttributes = $00000009;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Type                                                             }
{——————————————————————————————————————————————————————————————————————————————————————}
	kWindowDefProcType			= 'WDEF';

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Mac OS 7.5 Window Definition Resource IDs                                          }
{——————————————————————————————————————————————————————————————————————————————————————}
	kStandardWindowDefinition	= 0;							{  for document windows and dialogs }
	kRoundWindowDefinition		= 1;							{  old da-style window }
	kFloatingWindowDefinition	= 124;							{  for floating windows }

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Variant Codes                                                                      }
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
{ • DefProc IDs                                                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
																{  classic ids  }
	documentProc				= 0;
	dBoxProc					= 1;
	plainDBox					= 2;
	altDBoxProc					= 3;
	noGrowDocProc				= 4;
	movableDBoxProc				= 5;
	zoomDocProc					= 8;
	zoomNoGrow					= 12;							{  floating window defproc ids  }
	floatProc					= 1985;
	floatGrowProc				= 1987;
	floatZoomProc				= 1989;
	floatZoomGrowProc			= 1991;
	floatSideProc				= 1993;
	floatSideGrowProc			= 1995;
	floatSideZoomProc			= 1997;
	floatSideZoomGrowProc		= 1999;

{  The rDocProc (rounded WDEF, ala calculator) is not supported in Carbon. }
	rDocProc					= 16;

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


																{  procIDs available from Mac OS 8.1 (Appearance 1.0.1) forward  }
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
{ • System 7 Window Positioning Constants                                              }
{                                                                                      }
{ Passed into StandardAlert and used in ‘WIND’, ‘DLOG’, and ‘ALRT’ templates           }
{ StandardAlert uses zero to specify the default position. Other calls use zero to     }
{ specify “no position”.  Do not pass these constants to RepositionWindow.  Do not     }
{ store these constants in the BasicWindowDescription of a ‘wind’ resource.            }
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
{ • Window Positioning Methods                                                         }
{                                                                                      }
{ Positioning methods passed to RepositionWindow.                                      }
{ Do not use them in WIND, ALRT, DLOG templates.                                       }
{ Do not confuse these constants with the constants above                              }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowPositionMethod 		= UInt32;
CONST
	kWindowCenterOnMainScreen	= $00000001;
	kWindowCenterOnParentWindow	= $00000002;
	kWindowCenterOnParentWindowScreen = $00000003;
	kWindowCascadeOnMainScreen	= $00000004;
	kWindowCascadeOnParentWindow = $00000005;
	kWindowCascadeOnParentWindowScreen = $00000006;
	kWindowAlertPositionOnMainScreen = $00000007;
	kWindowAlertPositionOnParentWindow = $00000008;
	kWindowAlertPositionOnParentWindowScreen = $00000009;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • GetWindowRegion Types                                                              }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowRegionCode					= UInt16;

CONST
																{  Region values to pass into GetWindowRegion & GetWindowBounds  }
	kWindowTitleBarRgn			= 0;
	kWindowTitleTextRgn			= 1;
	kWindowCloseBoxRgn			= 2;
	kWindowZoomBoxRgn			= 3;
	kWindowDragRgn				= 5;
	kWindowGrowRgn				= 6;
	kWindowCollapseBoxRgn		= 7;
	kWindowTitleProxyIconRgn	= 8;							{  Mac OS 8.5 forward }
	kWindowStructureRgn			= 32;
	kWindowContentRgn			= 33;							{  Content area of the window; empty when the window is collapsed }
	kWindowUpdateRgn			= 34;							{  Carbon forward }
	kWindowGlobalPortRgn		= 40;							{  Carbon forward - bounds of the window’s port in global coordinates; not affected by CollapseWindow }

{  GetWindowRegionRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion }

TYPE
	GetWindowRegionRecPtr = ^GetWindowRegionRec;
	GetWindowRegionRec = RECORD
		winRgn:					RgnHandle;
		regionCode:				WindowRegionCode;
	END;

	GetWindowRegionPtr					= ^GetWindowRegionRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • WDEF Message Types                                                                 }
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

{  MeasureWindowTitleRec - a pointer to this is passed in WDEF param for kWindowMsgMeasureTitle }
	MeasureWindowTitleRecPtr = ^MeasureWindowTitleRec;
	MeasureWindowTitleRec = RECORD
																		{  output parameters (filled in by the WDEF) }
		fullTitleWidth:			SInt16;									{  text + proxy icon width }
		titleTextWidth:			SInt16;									{  text width }
	END;

{
   GetGrowImageRegionRec - generate a region to be xored during GrowWindow and ResizeWindow.
   This is passed along with a kWindowMsgGetGrowImageRegion message. On input, the growRect
   parameter is the window's new bounds in global coordinates. The growImageRegion parameter
   will be allocated and disposed automatically; the window definition should alter the 
   region appropriately.
}
	GetGrowImageRegionRecPtr = ^GetGrowImageRegionRec;
	GetGrowImageRegionRec = RECORD
		growRect:				Rect;
		growImageRegion:		RgnHandle;
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Standard Window Kinds                                                              }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	dialogKind					= 2;
	userKind					= 8;
	kDialogWindowKind			= 2;
	kApplicationWindowKind		= 8;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • FindWindow Result Codes                                                            }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowPartCode 				= SInt16;
CONST
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
	inCollapseBox				= 11;							{  Mac OS 8.0 forward }
	inProxyIcon					= 12;							{  Mac OS 8.5 forward }

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Hit Test Result Codes                                            }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowDefPartCode 			= SInt16;
CONST
	wNoHit						= 0;
	wInContent					= 1;
	wInDrag						= 2;
	wInGrow						= 3;
	wInGoAway					= 4;
	wInZoomIn					= 5;
	wInZoomOut					= 6;
	wInCollapseBox				= 9;							{  Mac OS 8.0 forward }
	wInProxyIcon				= 10;							{  Mac OS 8.5 forward }

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Messages                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}

	kWindowMsgDraw				= 0;
	kWindowMsgHitTest			= 1;
	kWindowMsgCalculateShape	= 2;
	kWindowMsgInitialize		= 3;
	kWindowMsgCleanUp			= 4;
	kWindowMsgDrawGrowOutline	= 5;
	kWindowMsgDrawGrowBox		= 6;

{  Messages available from Mac OS 8.0 forward }
	kWindowMsgGetFeatures		= 7;
	kWindowMsgGetRegion			= 8;

{  Messages available from Mac OS 8.5 forward }
	kWindowMsgDragHilite		= 9;							{  parameter boolean indicating on or off }
	kWindowMsgModified			= 10;							{  parameter boolean indicating saved (false) or modified (true) }
	kWindowMsgDrawInCurrentPort	= 11;							{  same as kWindowMsgDraw, but must draw in current port }
	kWindowMsgSetupProxyDragImage = 12;							{  parameter pointer to SetupWindowProxyDragImageRec }
	kWindowMsgStateChanged		= 13;							{  something about the window's state has changed }
	kWindowMsgMeasureTitle		= 14;							{  measure and return the ideal title width }

{  Messages only available in Carbon }
	kWindowMsgGetGrowImageRegion = 19;							{  get region to xor during grow/resize. parameter pointer to GetGrowImageRegionRec. }

{  old names }
	wDraw						= 0;
	wHit						= 1;
	wCalcRgns					= 2;
	wNew						= 3;
	wDispose					= 4;
	wGrow						= 5;
	wDrawGIcon					= 6;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • State-changed Flags for kWindowMsgStateChanged                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
	kWindowStateTitleChanged	= $01;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • WindowGrowSides to be used with kWindowMsgGetGrowSides                             }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowGrowSides						= UInt32;

CONST
	kWindowGrowSideTop			= $01;
	kWindowGrowSideLeft			= $02;
	kWindowGrowSideBottom		= $04;
	kWindowGrowSideRight		= $08;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Feature Bits                                                                }
{——————————————————————————————————————————————————————————————————————————————————————}
	kWindowCanGrow				= $01;
	kWindowCanZoom				= $02;
	kWindowCanCollapse			= $04;
	kWindowIsModal				= $08;
	kWindowCanGetWindowRegion	= $10;
	kWindowIsAlert				= $20;
	kWindowHasTitleBar			= $40;

{  Feature bits available from Mac OS 8.5 forward }
	kWindowSupportsDragHilite	= $80;							{  window definition supports kWindowMsgDragHilite }
	kWindowSupportsModifiedBit	= $0100;						{  window definition supports kWindowMsgModified }
	kWindowCanDrawInCurrentPort	= $0200;						{  window definition supports kWindowMsgDrawInCurrentPort }
	kWindowCanSetupProxyDragImage = $0400;						{  window definition supports kWindowMsgSetupProxyDragImage }
	kWindowCanMeasureTitle		= $0800;						{  window definition supports kWindowMsgMeasureTitle }
	kWindowWantsDisposeAtProcessDeath = $1000;					{  window definition wants a Dispose message for windows still extant during ExitToShell }
	kWindowSupportsSetGrowImageRegion = $2000;					{  window definition will calculate the grow image region manually. }
	kWindowDefSupportsColorGrafPort = $40000002;				{  window definition does not need the monochrome GrafPort hack during kWindowMsgCalculateShape }


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Desktop Pattern Resource ID                                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
	deskPatID					= 16;



{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Color Part Codes                                                            }
{——————————————————————————————————————————————————————————————————————————————————————}
	wContentColor				= 0;
	wFrameColor					= 1;
	wTextColor					= 2;
	wHiliteColor				= 3;
	wTitleBarColor				= 4;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Region Dragging Constants                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}

	kMouseUpOutOfSlop			= $80008000;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Color Table                                                                 }
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
{ • WindowRecord                                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	WindowRecordPtr = ^WindowRecord;
	WindowPeek							= ^WindowRecord;
	WindowRecord = RECORD
		port:					GrafPort;								{  in Carbon use GetWindowPort }
		windowKind:				INTEGER;								{  in Carbon use Get/SetWindowKind }
		visible:				BOOLEAN;								{  in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible }
		hilited:				BOOLEAN;								{  in Carbon use HiliteWindow, IsWindowHilited }
		goAwayFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes }
		spareFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes }
		strucRgn:				RgnHandle;								{  in Carbon use GetWindowRegion }
		contRgn:				RgnHandle;								{  in Carbon use GetWindowRegion }
		updateRgn:				RgnHandle;								{  in Carbon use GetWindowRegion }
		windowDefProc:			Handle;									{  not supported in Carbon  }
		dataHandle:				Handle;									{  not supported in Carbon  }
		titleHandle:			StringHandle;							{  in Carbon use Get/SetWTitle  }
		titleWidth:				INTEGER;								{  in Carbon use GetWindowRegion  }
		controlList:			Handle;									{  in Carbon use GetRootControl  }
		nextWindow:				WindowPeek;								{  in Carbon use GetNextWindow  }
		windowPic:				PicHandle;								{  in Carbon use Get/SetWindowPic  }
		refCon:					LONGINT;								{  in Carbon use Get/SetWRefCon }
	END;

{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Color WindowRecord                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	CWindowRecordPtr = ^CWindowRecord;
	CWindowPeek							= ^CWindowRecord;
	CWindowRecord = RECORD
		port:					CGrafPort;								{  in Carbon use GetWindowPort }
		windowKind:				INTEGER;								{  in Carbon use Get/SetWindowKind     }
		visible:				BOOLEAN;								{  in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible      }
		hilited:				BOOLEAN;								{  in Carbon use HiliteWindow, IsWindowHilited }
		goAwayFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes    }
		spareFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes    }
		strucRgn:				RgnHandle;								{  in Carbon use GetWindowRegion   }
		contRgn:				RgnHandle;								{  in Carbon use GetWindowRegion   }
		updateRgn:				RgnHandle;								{  in Carbon use GetWindowRegion   }
		windowDefProc:			Handle;									{  not supported in Carbon  }
		dataHandle:				Handle;									{  not supported in Carbon  }
		titleHandle:			StringHandle;							{  in Carbon use Get/SetWTitle  }
		titleWidth:				INTEGER;								{  in Carbon use GetWindowRegion  }
		controlList:			Handle;									{  in Carbon use GetRootControl  }
		nextWindow:				CWindowPeek;							{  in Carbon use GetNextWindow  }
		windowPic:				PicHandle;								{  in Carbon use Get/SetWindowPic      }
		refCon:					LONGINT;								{  in Carbon use Get/SetWRefCon       }
	END;

{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • AuxWinHandle                                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	AuxWinRecPtr = ^AuxWinRec;
	AuxWinPtr							= ^AuxWinRec;
	AuxWinHandle						= ^AuxWinPtr;
	AuxWinRec = RECORD
		awNext:					AuxWinHandle;							{  handle to next AuxWinRec, not supported in Carbon }
		awOwner:				WindowRef;								{  not supported in Carbon }
		awCTable:				CTabHandle;								{  color table for this window, use  Get/SetWindowContentColor in Carbon }
		reserved:				Handle;									{  not supported in Carbon }
		awFlags:				LONGINT;								{  reserved for expansion, not supported in Carbon }
		awReserved:				CTabHandle;								{  reserved for expansion, not supported in Carbon }
		awRefCon:				LONGINT;								{  user constant, in Carbon use Get/SetWindowProperty if you need more refCons }
	END;

{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • BasicWindowDescription                                                            }
{                                                                                      }
{  Contains statically-sized basic attributes of the window, for storage in a          }
{  collection item.                                                                    }
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
		windowRefCon:			UInt32;									{  the refcon - __avoid saving stale pointers here__   }
		windowStateFlags:		UInt32;									{  window state bit flags }
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
{ • Window Class Ordering                                                              }
{                                                                                      }
{  Special cases for the “behind” parameter in window creation calls.                  }
{——————————————————————————————————————————————————————————————————————————————————————}
	kFirstWindowOfClass			= -1;
	kLastWindowOfClass			= 0;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Zoom Information Handle                                                            }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WStateDataPtr = ^WStateData;
	WStateData = RECORD
		userState:				Rect;									{ user zoom state }
		stdState:				Rect;									{ standard zoom state }
	END;

	WStateDataHandle					= ^WStateDataPtr;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • MixedMode & ProcPtrs                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC TYPED_FUNCTION_POINTERS}
	WindowDefProcPtr = FUNCTION(varCode: INTEGER; window: WindowRef; message: INTEGER; param: LONGINT): LONGINT;
{$ELSEC}
	WindowDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DeskHookProcPtr = PROCEDURE(mouseClick: BOOLEAN; VAR theEvent: EventRecord);
{$ELSEC}
	DeskHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WindowPaintProcPtr = FUNCTION(device: GDHandle; qdContext: GrafPtr; window: WindowRef; inClientPaintRgn: RgnHandle; outSystemPaintRgn: RgnHandle; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	WindowPaintProcPtr = ProcPtr;
{$ENDC}

	WindowDefUPP = UniversalProcPtr;
	DeskHookUPP = UniversalProcPtr;
	WindowPaintUPP = UniversalProcPtr;

CONST
	uppWindowDefProcInfo = $00003BB0;
	uppDeskHookProcInfo = $00130802;
	uppWindowPaintProcInfo = $0003FFF0;

FUNCTION NewWindowDefUPP(userRoutine: WindowDefProcPtr): WindowDefUPP; { old name was NewWindowDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewDeskHookUPP(userRoutine: DeskHookProcPtr): DeskHookUPP; { old name was NewDeskHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


FUNCTION NewWindowPaintUPP(userRoutine: WindowPaintProcPtr): WindowPaintUPP; { old name was NewWindowPaintProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeWindowDefUPP(userUPP: WindowDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

PROCEDURE DisposeDeskHookUPP(userUPP: DeskHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


PROCEDURE DisposeWindowPaintUPP(userUPP: WindowPaintUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeWindowDefUPP(varCode: INTEGER; window: WindowRef; message: INTEGER; param: LONGINT; userRoutine: WindowDefUPP): LONGINT; { old name was CallWindowDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

PROCEDURE InvokeDeskHookUPP(mouseClick: BOOLEAN; VAR theEvent: EventRecord; userRoutine: DeskHookUPP); { old name was CallDeskHookProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


FUNCTION InvokeWindowPaintUPP(device: GDHandle; qdContext: GrafPtr; window: WindowRef; inClientPaintRgn: RgnHandle; outSystemPaintRgn: RgnHandle; refCon: UNIV Ptr; userRoutine: WindowPaintUPP): OSStatus; { old name was CallWindowPaintProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Spec.  Used in Carbon to specify the code that defines a window. }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kWindowDefProcPtr			= 0;							{  raw proc-ptr based access }
	kWindowDefObjectClass		= 1;							{  event-based definition (Carbon 1.1 or later) }


TYPE
	WindowDefType						= UInt32;
	WindowDefSpecPtr = ^WindowDefSpec;
	WindowDefSpec = RECORD
		defType:				WindowDefType;
		CASE INTEGER OF
		0: (
			defProc:			WindowDefUPP;
			);
		1: (
			classRef:			Ptr;
			);
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Creation & Persistence                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetNewCWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowRef): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA46;
	{$ENDC}
FUNCTION NewWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A913;
	{$ENDC}
FUNCTION GetNewWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowRef): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BD;
	{$ENDC}
FUNCTION NewCWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA45;
	{$ENDC}
PROCEDURE DisposeWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A914;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE CloseWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92D;
	{$ENDC}

{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION CreateNewWindow(windowClass: WindowClass; attributes: WindowAttributes; {CONST}VAR contentBounds: Rect; VAR outWindow: WindowRef): OSStatus;
{  Routines available from Mac OS 8.5 forward }

{  Create a window from a ‘wind’ resource }
FUNCTION CreateWindowFromResource(resID: SInt16; VAR outWindow: WindowRef): OSStatus;
{  window persistence }
FUNCTION StoreWindowIntoCollection(window: WindowRef; collection: Collection): OSStatus;
FUNCTION CreateWindowFromCollection(collection: Collection; VAR outWindow: WindowRef): OSStatus;
{  window refcounting }
FUNCTION GetWindowOwnerCount(window: WindowRef; VAR outCount: UInt32): OSStatus;
FUNCTION CloneWindow(window: WindowRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Custom Windows                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }

FUNCTION CreateCustomWindow({CONST}VAR def: WindowDefSpec; windowClass: WindowClass; attributes: WindowAttributes; {CONST}VAR contentBounds: Rect; VAR outWindow: WindowRef): OSStatus;
FUNCTION ReshapeCustomWindow(window: WindowRef): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Metainformation Accessors                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}

{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
FUNCTION GetWindowClass(window: WindowRef; VAR outClass: WindowClass): OSStatus;
FUNCTION GetWindowAttributes(window: WindowRef; VAR outAttributes: WindowAttributes): OSStatus;
{
   Routines available from Mac OS 9.0 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
FUNCTION ChangeWindowAttributes(window: WindowRef; setTheseAttributes: WindowAttributes; clearTheseAttributes: WindowAttributes): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Floating Windows                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   Routines available from Mac OS 8.6 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

FUNCTION ShowFloatingWindows: OSStatus;
FUNCTION HideFloatingWindows: OSStatus;
FUNCTION AreFloatingWindowsVisible: BOOLEAN;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Background Image                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{  SetWinColor is not available in Carbon. }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetWinColor(window: WindowRef; newColorTable: WCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA41;
	{$ENDC}
{  SetDeskCPat is not available in Carbon. }
PROCEDURE SetDeskCPat(deskPixPat: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA47;
	{$ENDC}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION SetWindowContentColor(window: WindowRef; {CONST}VAR color: RGBColor): OSStatus;
FUNCTION GetWindowContentColor(window: WindowRef; VAR color: RGBColor): OSStatus;
{  Routines available from Mac OS 8.5 forward }
FUNCTION GetWindowContentPattern(window: WindowRef; outPixPat: PixPatHandle): OSStatus;
FUNCTION SetWindowContentPattern(window: WindowRef; pixPat: PixPatHandle): OSStatus;
{  Routines available from Mac OS 9.0 forward }

TYPE
	WindowPaintProcOptions				= OptionBits;

CONST
	kWindowPaintProcOptionsNone	= 0;

FUNCTION InstallWindowContentPaintProc(window: WindowRef; paintProc: WindowPaintUPP; options: WindowPaintProcOptions; refCon: UNIV Ptr): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Scrolling Routines                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ScrollWindowOptions 		= UInt32;
CONST
	kScrollWindowNoOptions		= 0;
	kScrollWindowInvalidate		= $00000001;					{  add the exposed area to the window’s update region }
	kScrollWindowEraseToPortBackground = $00000002;				{  erase the exposed area using the background color/pattern of the window’s grafport }


{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }

FUNCTION ScrollWindowRect(inWindow: WindowRef; {CONST}VAR inScrollRect: Rect; inHPixels: SInt16; inVPixels: SInt16; inOptions: ScrollWindowOptions; outExposedRgn: RgnHandle): OSStatus;
FUNCTION ScrollWindowRegion(inWindow: WindowRef; inScrollRgn: RgnHandle; inHPixels: SInt16; inVPixels: SInt16; inOptions: ScrollWindowOptions; outExposedRgn: RgnHandle): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Low-Level Region & Painting Routines                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE ClipAbove(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90B;
	{$ENDC}
{  SaveOld/DrawNew are not available in Carbon.  Use ReshapeCustomWindow instead. }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SaveOld(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90E;
	{$ENDC}
PROCEDURE DrawNew(window: WindowRef; update: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE PaintOne(window: WindowRef; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90C;
	{$ENDC}
PROCEDURE PaintBehind(startWindow: WindowRef; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90D;
	{$ENDC}
PROCEDURE CalcVis(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A909;
	{$ENDC}
PROCEDURE CalcVisBehind(startWindow: WindowRef; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90A;
	{$ENDC}
FUNCTION CheckUpdate(VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A911;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window List                                                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION FindWindow(thePoint: Point; VAR window: WindowRef): WindowPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92C;
	{$ENDC}
FUNCTION FrontWindow: WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A924;
	{$ENDC}
PROCEDURE BringToFront(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A920;
	{$ENDC}
PROCEDURE SendBehind(window: WindowRef; behindWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A921;
	{$ENDC}
PROCEDURE SelectWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91F;
	{$ENDC}
{
   Routines available from Mac OS 8.6 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

FUNCTION FrontNonFloatingWindow: WindowRef;
{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }

FUNCTION GetNextWindowOfClass(inWindow: WindowRef; inWindowClass: WindowClass; mustBeVisible: BOOLEAN): WindowRef;
FUNCTION GetFrontWindowOfClass(inWindowClass: WindowClass; mustBeVisible: BOOLEAN): WindowRef;
FUNCTION FindWindowOfClass({CONST}VAR where: Point; inWindowClass: WindowClass; VAR outWindow: WindowRef; VAR outWindowPart: WindowPartCode): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Misc Low-Level stuff                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE InitWindows;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A912;
	{$ENDC}
{  The window manager port does not exist in Carbon.   }
{  We are investigating replacement technologies.      }
PROCEDURE GetWMgrPort(VAR wPort: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A910;
	{$ENDC}
PROCEDURE GetCWMgrPort(VAR wMgrCPort: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA48;
	{$ENDC}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION IsValidWindowPtr(possibleWindow: WindowRef): BOOLEAN;
{
   Routines available from Mac OS 8.6 forward
   InitFloatingWindows is not available in Carbon;
   window ordering is always active for Carbon clients
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitFloatingWindows: OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Various & Sundry Window Accessors                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE HiliteWindow(window: WindowRef; fHilite: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91C;
	{$ENDC}
PROCEDURE SetWRefCon(window: WindowRef; data: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A918;
	{$ENDC}
FUNCTION GetWRefCon(window: WindowRef): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A917;
	{$ENDC}
PROCEDURE SetWindowPic(window: WindowRef; pic: PicHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92E;
	{$ENDC}
FUNCTION GetWindowPic(window: WindowRef): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92F;
	{$ENDC}
FUNCTION GetWVariant(window: WindowRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80A;
	{$ENDC}
{  Routines available from Mac OS 8.0 (Appearance 1.0) forward }
FUNCTION GetWindowFeatures(window: WindowRef; VAR outFeatures: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA74;
	{$ENDC}
FUNCTION GetWindowRegion(window: WindowRef; inRegionCode: WindowRegionCode; ioWinRgn: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA74;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Update Events                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   These aren't present in Carbon. Please use the InvalWindowRect, etc. routines
   below instead.
}
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE BeginUpdate(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A922;
	{$ENDC}
PROCEDURE EndUpdate(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A923;
	{$ENDC}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

FUNCTION InvalWindowRgn(window: WindowRef; region: RgnHandle): OSStatus;
FUNCTION InvalWindowRect(window: WindowRef; {CONST}VAR bounds: Rect): OSStatus;
FUNCTION ValidWindowRgn(window: WindowRef; region: RgnHandle): OSStatus;
FUNCTION ValidWindowRect(window: WindowRef; {CONST}VAR bounds: Rect): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • DrawGrowIcon                                                                       }
{                                                                                      }
{  DrawGrowIcon is deprecated from Mac OS 8.0 forward.  Theme-savvy window defprocs    }
{  include the grow box in the window frame.                                           }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE DrawGrowIcon(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A904;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Titles                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE SetWTitle(window: WindowRef; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91A;
	{$ENDC}
PROCEDURE GetWTitle(window: WindowRef; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A919;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Proxies                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.5 forward }

FUNCTION SetWindowProxyFSSpec(window: WindowRef; {CONST}VAR inFile: FSSpec): OSStatus;
FUNCTION GetWindowProxyFSSpec(window: WindowRef; VAR outFile: FSSpec): OSStatus;
FUNCTION SetWindowProxyAlias(window: WindowRef; alias: AliasHandle): OSStatus;
FUNCTION GetWindowProxyAlias(window: WindowRef; VAR alias: AliasHandle): OSStatus;
FUNCTION SetWindowProxyCreatorAndType(window: WindowRef; fileCreator: OSType; fileType: OSType; vRefNum: SInt16): OSStatus;
FUNCTION GetWindowProxyIcon(window: WindowRef; VAR outIcon: IconRef): OSStatus;
FUNCTION SetWindowProxyIcon(window: WindowRef; icon: IconRef): OSStatus;
FUNCTION RemoveWindowProxy(window: WindowRef): OSStatus;
FUNCTION BeginWindowProxyDrag(window: WindowRef; VAR outNewDrag: DragReference; outDragOutlineRgn: RgnHandle): OSStatus;
FUNCTION EndWindowProxyDrag(window: WindowRef; theDrag: DragReference): OSStatus;
FUNCTION TrackWindowProxyFromExistingDrag(window: WindowRef; startPt: Point; drag: DragReference; inDragOutlineRgn: RgnHandle): OSStatus;
FUNCTION TrackWindowProxyDrag(window: WindowRef; startPt: Point): OSStatus;
FUNCTION IsWindowModified(window: WindowRef): BOOLEAN;
FUNCTION SetWindowModified(window: WindowRef; modified: BOOLEAN): OSStatus;
FUNCTION IsWindowPathSelectClick(window: WindowRef; {CONST}VAR event: EventRecord): BOOLEAN;
FUNCTION WindowPathSelect(window: WindowRef; menu: MenuRef; VAR outMenuResult: SInt32): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • HiliteWindowFrameForDrag                                                          }
{                                                                                      }
{  If you call ShowDragHilite and HideDragHilite, you don’t need to use this routine.  }
{  If you implement custom drag hiliting, you should call HiliteWindowFrameForDrag     }
{  when the drag is tracking inside a window with drag-hilited content.                }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.5 forward }

FUNCTION HiliteWindowFrameForDrag(window: WindowRef; hilited: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $A829;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Transitions                                                                 }
{                                                                                      }
{  TransitionWindow displays a window with accompanying animation and sound.           }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.5 forward }


TYPE
	WindowTransitionEffect 		= UInt32;
CONST
	kWindowZoomTransitionEffect	= 1;							{  Finder-like zoom rectangles, use with Show or Open transition actions }


TYPE
	WindowTransitionAction 		= UInt32;
CONST
	kWindowShowTransitionAction	= 1;							{  param is rect in global coordinates from which to start the animation }
	kWindowHideTransitionAction	= 2;							{  param is rect in global coordinates at which to end the animation }

FUNCTION TransitionWindow(window: WindowRef; effect: WindowTransitionEffect; action: WindowTransitionAction; rect: {Const}RectPtr): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Positioning                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}

PROCEDURE MoveWindow(window: WindowRef; hGlobal: INTEGER; vGlobal: INTEGER; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91B;
	{$ENDC}
PROCEDURE SizeWindow(window: WindowRef; w: INTEGER; h: INTEGER; fUpdate: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91D;
	{$ENDC}

{ Note: bBox can only be NULL when linking to CarbonLib 1.0 forward }
FUNCTION GrowWindow(window: WindowRef; startPt: Point; bBox: {Const}RectPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92B;
	{$ENDC}
{ Note: boundsRect can only be NULL when linking to CarbonLib 1.0 forward }
PROCEDURE DragWindow(window: WindowRef; startPt: Point; boundsRect: {Const}RectPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A925;
	{$ENDC}
PROCEDURE ZoomWindow(window: WindowRef; partCode: WindowPartCode; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83A;
	{$ENDC}
{  Routines available from Mac OS 8.0 (Appearance 1.0) forward }

FUNCTION IsWindowCollapsable(window: WindowRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA74;
	{$ENDC}
FUNCTION IsWindowCollapsed(window: WindowRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA74;
	{$ENDC}
FUNCTION CollapseWindow(window: WindowRef; collapse: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA74;
	{$ENDC}
FUNCTION CollapseAllWindows(collapse: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA74;
	{$ENDC}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

FUNCTION GetWindowBounds(window: WindowRef; regionCode: WindowRegionCode; VAR globalBounds: Rect): OSStatus;
{ Note: newContentRect can only be NULL when linking to CarbonLib 1.0 forward }
FUNCTION ResizeWindow(window: WindowRef; startPoint: Point; sizeConstraints: {Const}RectPtr; newContentRect: RectPtr): BOOLEAN;

{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0.2 forward
}

FUNCTION SetWindowBounds(window: WindowRef; regionCode: WindowRegionCode; {CONST}VAR globalBounds: Rect): OSStatus;
{  Routines available from Mac OS 8.5 forward }

FUNCTION RepositionWindow(window: WindowRef; parentWindow: WindowRef; method: WindowPositionMethod): OSStatus;

FUNCTION MoveWindowStructure(window: WindowRef; hGlobal: INTEGER; vGlobal: INTEGER): OSStatus;
FUNCTION IsWindowInStandardState(window: WindowRef; VAR idealSize: Point; VAR idealStandardState: Rect): BOOLEAN;
FUNCTION ZoomWindowIdeal(window: WindowRef; partCode: WindowPartCode; VAR ioIdealSize: Point): OSStatus;
FUNCTION GetWindowIdealUserState(window: WindowRef; VAR userState: Rect): OSStatus;
FUNCTION SetWindowIdealUserState(window: WindowRef; VAR userState: Rect): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Visibility                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}

PROCEDURE HideWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A916;
	{$ENDC}
PROCEDURE ShowWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A915;
	{$ENDC}
PROCEDURE ShowHide(window: WindowRef; showFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A908;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Properties                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

FUNCTION GetWindowProperty(window: WindowRef; propertyCreator: PropertyCreator; propertyTag: PropertyTag; bufferSize: UInt32; VAR actualSize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;
FUNCTION GetWindowPropertySize(window: WindowRef; creator: PropertyCreator; tag: PropertyTag; VAR size: UInt32): OSStatus;
FUNCTION SetWindowProperty(window: WindowRef; propertyCreator: PropertyCreator; propertyTag: PropertyTag; propertySize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;
FUNCTION RemoveWindowProperty(window: WindowRef; propertyCreator: PropertyCreator; propertyTag: PropertyTag): OSStatus;

{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }


CONST
	kWindowPropertyPersistent	= $00000001;					{  whether this property gets saved when flattening the window  }

FUNCTION GetWindowPropertyAttributes(window: WindowRef; propertyCreator: OSType; propertyTag: OSType; VAR attributes: UInt32): OSStatus;
FUNCTION ChangeWindowPropertyAttributes(window: WindowRef; propertyCreator: OSType; propertyTag: OSType; attributesToSet: UInt32; attributesToClear: UInt32): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Utilities                                                                          }
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
{ • Window Part Tracking                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION TrackBox(window: WindowRef; thePt: Point; partCode: WindowPartCode): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83B;
	{$ENDC}
FUNCTION TrackGoAway(window: WindowRef; thePt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91E;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Region Dragging                                                                    }
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
{  • GetAuxWin                                                                         }
{                                                                                      }
{  GetAuxWin is not available in Carbon                                                }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetAuxWin(window: WindowRef; VAR awHndl: AuxWinHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA42;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{                                                                                          }
{  Direct modification of the close box and zoom box “flags” is not supported in Carbon.   }
{                                                                                          }
{  GetWindowGoAwayFlag                                                                     }
{  GetWindowSpareFlag                                                                      }
{  SetWindowGoAwayFlag                                                                     }
{  SetWindowSpareFlag                                                                      }
{                                                                                          }
{  Use GetWindowAttributes and ChangeWindowAttributes if you must dynamically              }
{  access the zoom box and close box attributes.                                           }
{                                                                                          }
{ Still available as transitional API in PreCarbon.o, since GetWindowAttributes is not implemented there. }
FUNCTION GetWindowGoAwayFlag(window: WindowRef): BOOLEAN;
FUNCTION GetWindowSpareFlag(window: WindowRef): BOOLEAN;
{ Getters }
FUNCTION GetWindowList: WindowRef;
FUNCTION GetWindowPort(window: WindowRef): CGrafPtr;
FUNCTION GetWindowKind(window: WindowRef): INTEGER;
FUNCTION IsWindowVisible(window: WindowRef): BOOLEAN;
FUNCTION IsWindowHilited(window: WindowRef): BOOLEAN;
FUNCTION IsWindowUpdatePending(window: WindowRef): BOOLEAN;
FUNCTION GetNextWindow(window: WindowRef): WindowRef;
FUNCTION GetWindowStandardState(window: WindowRef; VAR rect: Rect): RectPtr;
FUNCTION GetWindowUserState(window: WindowRef; VAR rect: Rect): RectPtr;
{ Setters }
PROCEDURE SetWindowKind(window: WindowRef; kind: INTEGER);
PROCEDURE SetWindowStandardState(window: WindowRef; {CONST}VAR rect: Rect);
PROCEDURE SetWindowUserState(window: WindowRef; {CONST}VAR rect: Rect);
{ Utilities }
{ set the current QuickDraw port to the port associated with the window }
PROCEDURE SetPortWindowPort(window: WindowRef);
FUNCTION GetWindowPortBounds(window: WindowRef; VAR bounds: Rect): RectPtr;
{ GetWindowFromPort is needed to ‘cast up’ to a WindowRef from a GrafPort }
FUNCTION GetWindowFromPort(port: CGrafPtr): WindowRef;
{ To prevent upward dependencies, GetDialogFromWindow() is defined in the Dialogs interface: }
{      pascal DialogRef        GetDialogFromWindow(WindowRef window); }
{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}








{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacWindowsIncludes}

{$ENDC} {__MACWINDOWS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
