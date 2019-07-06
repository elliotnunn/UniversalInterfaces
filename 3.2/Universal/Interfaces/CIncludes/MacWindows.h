/*
 	File:		MacWindows.h
 
 	Contains:	Window Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1997-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __MACWINDOWS__
#define __MACWINDOWS__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __ALIASES__
#include <Aliases.h>
#endif
#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
#ifndef __COLLECTIONS__
#include <Collections.h>
#endif
#ifndef __DRAG__
#include <Drag.h>
#endif
#ifndef __EVENTS__
#include <Events.h>
#endif
#ifndef __MENUS__
#include <Menus.h>
#endif
#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif
#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __TEXTCOMMON__
#include <TextCommon.h>
#endif
#ifndef __ICONS__
#include <Icons.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Property Types (Mac OS 8.5 and later)												*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef OSType 							PropertyCreator;
typedef OSType 							PropertyTag;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Classes (Mac OS 8.5 and later)												*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt32 							WindowClass;

enum {
	kAlertWindowClass			= 1L,							/* “I need your attention now.”*/
	kMovableAlertWindowClass	= 2L,							/* “I need your attention now, but I’m kind enough to let you switch out of this app to do other things.”*/
	kModalWindowClass			= 3L,							/* system modal, not draggable*/
	kMovableModalWindowClass	= 4L,							/* application modal, draggable*/
	kFloatingWindowClass		= 5L,							/* floats above all other application windows*/
	kDocumentWindowClass		= 6L							/* everything else*/
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Attributes (Mac OS 8.5 and later)											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

typedef UInt32 							WindowAttributes;

enum {
	kWindowNoAttributes			= 0L,							/* no attributes*/
	kWindowCloseBoxAttribute	= (1L << 0),					/* window has a close box*/
	kWindowHorizontalZoomAttribute = (1L << 1),					/* window has horizontal zoom box*/
	kWindowVerticalZoomAttribute = (1L << 2),					/* window has vertical zoom box*/
	kWindowFullZoomAttribute	= (kWindowVerticalZoomAttribute | kWindowHorizontalZoomAttribute),
	kWindowCollapseBoxAttribute	= (1L << 3),					/* window has a collapse box*/
	kWindowResizableAttribute	= (1L << 4),					/* window is resizable*/
	kWindowSideTitlebarAttribute = (1L << 5),					/* window wants a titlebar on the side	(floating window class only)*/
	kWindowNoUpdatesAttribute	= (1L << 16),					/* this window receives no update events*/
	kWindowNoActivatesAttribute	= (1L << 17),					/* this window receives no activate events*/
	kWindowStandardDocumentAttributes = (kWindowCloseBoxAttribute | kWindowFullZoomAttribute | kWindowCollapseBoxAttribute | kWindowResizableAttribute),
	kWindowStandardFloatingAttributes = (kWindowCloseBoxAttribute | kWindowCollapseBoxAttribute)
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Errors & Gestalt (Mac OS 8.5 and later)											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	gestaltWindowMgrAttr		= FOUR_CHAR_CODE('wind'),		/* If this Gestalt exists, the Mac OS 8.5 Window Manager is installed*/
	gestaltWindowMgrPresent		= (1L << 0)
};



enum {
	errInvalidWindowPtr			= -5600,						/* tried to pass a bad WindowPtr argument*/
	errUnsupportedWindowAttributesForClass = -5601,				/* tried to create a window with WindowAttributes not supported by the WindowClass*/
	errWindowDoesNotHaveProxy	= -5602,						/* tried to do something requiring a proxy to a window which doesn’t have a proxy*/
	errInvalidWindowProperty	= -5603,						/* tried to access a property tag with private creator*/
	errWindowPropertyNotFound	= -5604,						/* tried to get a nonexistent property*/
	errUnrecognizedWindowClass	= -5605,						/* tried to create a window with a bad WindowClass*/
	errCorruptWindowDescription	= -5606,						/* tried to load a corrupt window description (size or version fields incorrect)*/
	errUserWantsToDragWindow	= -5607,						/* if returned from TrackWindowProxyDrag, you should call DragWindow on the window*/
	errWindowsAlreadyInitialized = -5608,						/* tried to call InitFloatingWindows twice, or called InitWindows and then floating windows*/
	errFloatingWindowsNotInitialized = -5609					/* called HideFloatingWindows or ShowFloatingWindows without calling InitFloatingWindows*/
};



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Type																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kWindowDefProcType			= FOUR_CHAR_CODE('WDEF')
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Mac OS 7.5 Window Definition Resource IDs											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kStandardWindowDefinition	= 0,							/* for document windows and dialogs*/
	kRoundWindowDefinition		= 1,							/* old da-style window*/
	kFloatingWindowDefinition	= 124							/* for floating windows*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Variant Codes																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* for use with kStandardWindowDefinition */
	kDocumentWindowVariantCode	= 0,
	kModalDialogVariantCode		= 1,
	kPlainDialogVariantCode		= 2,
	kShadowDialogVariantCode	= 3,
	kMovableModalDialogVariantCode = 5,
	kAlertVariantCode			= 7,
	kMovableAlertVariantCode	= 9,							/* for use with kFloatingWindowDefinition */
	kSideFloaterVariantCode		= 8
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • DefProc IDs																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* classic ids */
	documentProc				= 0,
	dBoxProc					= 1,
	plainDBox					= 2,
	altDBoxProc					= 3,
	noGrowDocProc				= 4,
	movableDBoxProc				= 5,
	zoomDocProc					= 8,
	zoomNoGrow					= 12,
	rDocProc					= 16,							/* floating window defproc ids */
	floatProc					= 1985,
	floatGrowProc				= 1987,
	floatZoomProc				= 1989,
	floatZoomGrowProc			= 1991,
	floatSideProc				= 1993,
	floatSideGrowProc			= 1995,
	floatSideZoomProc			= 1997,
	floatSideZoomGrowProc		= 1999
};


enum {
																/* Resource IDs for theme-savvy window defprocs */
	kWindowDocumentDefProcResID	= 64,
	kWindowDialogDefProcResID	= 65,
	kWindowUtilityDefProcResID	= 66,
	kWindowUtilitySideTitleDefProcResID = 67
};


enum {
																/* Proc IDs for theme-savvy windows */
	kWindowDocumentProc			= 1024,
	kWindowGrowDocumentProc		= 1025,
	kWindowVertZoomDocumentProc	= 1026,
	kWindowVertZoomGrowDocumentProc = 1027,
	kWindowHorizZoomDocumentProc = 1028,
	kWindowHorizZoomGrowDocumentProc = 1029,
	kWindowFullZoomDocumentProc	= 1030,
	kWindowFullZoomGrowDocumentProc = 1031
};


enum {
																/* Proc IDs for theme-savvy dialogs */
	kWindowPlainDialogProc		= 1040,
	kWindowShadowDialogProc		= 1041,
	kWindowModalDialogProc		= 1042,
	kWindowMovableModalDialogProc = 1043,
	kWindowAlertProc			= 1044,
	kWindowMovableAlertProc		= 1045
};


enum {
																/* procIDs available in Mac OS 8.1 (Appearance 1.0.1) or later */
	kWindowMovableModalGrowProc	= 1046
};


enum {
																/* Proc IDs for top title bar theme-savvy floating windows */
	kWindowFloatProc			= 1057,
	kWindowFloatGrowProc		= 1059,
	kWindowFloatVertZoomProc	= 1061,
	kWindowFloatVertZoomGrowProc = 1063,
	kWindowFloatHorizZoomProc	= 1065,
	kWindowFloatHorizZoomGrowProc = 1067,
	kWindowFloatFullZoomProc	= 1069,
	kWindowFloatFullZoomGrowProc = 1071
};



enum {
																/* Proc IDs for side title bar theme-savvy floating windows */
	kWindowFloatSideProc		= 1073,
	kWindowFloatSideGrowProc	= 1075,
	kWindowFloatSideVertZoomProc = 1077,
	kWindowFloatSideVertZoomGrowProc = 1079,
	kWindowFloatSideHorizZoomProc = 1081,
	kWindowFloatSideHorizZoomGrowProc = 1083,
	kWindowFloatSideFullZoomProc = 1085,
	kWindowFloatSideFullZoomGrowProc = 1087
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • System 7 Window Positioning Constants												*/
/*																						*/
/* Passed into StandardAlert and used in ‘WIND’, ‘DLOG’, and ‘ALRT’ templates			*/
/* StandardAlert uses zero to specify the default position. Other calls use zero to		*/
/* specify “no position”.  Do not pass these constants to RepositionWindow.  Do not		*/
/* store these constants in the BasicWindowDescription of a ‘wind’ resource.			*/
/*——————————————————————————————————————————————————————————————————————————————————————*/


enum {
	kWindowNoPosition			= 0x0000,
	kWindowDefaultPosition		= 0x0000,						/* used by StandardAlert*/
	kWindowCenterMainScreen		= 0x280A,
	kWindowAlertPositionMainScreen = 0x300A,
	kWindowStaggerMainScreen	= 0x380A,
	kWindowCenterParentWindow	= 0xA80A,
	kWindowAlertPositionParentWindow = 0xB00A,
	kWindowStaggerParentWindow	= 0xB80A,
	kWindowCenterParentWindowScreen = 0x680A,
	kWindowAlertPositionParentWindowScreen = 0x700A,
	kWindowStaggerParentWindowScreen = 0x780A
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Positioning Methods	(Mac OS 8.5 and later)									*/
/*																						*/
/* Positioning methods passed to RepositionWindow.										*/
/* Do not use them in WIND, ALRT, DLOG templates.  										*/
/* Do not confuse these constants with the constants above								*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt32 							WindowPositionMethod;

enum {
	kWindowCenterOnMainScreen	= 0x00000001,
	kWindowCenterOnParentWindow	= 0x00000002,
	kWindowCenterOnParentWindowScreen = 0x00000003,
	kWindowCascadeOnMainScreen	= 0x00000004,
	kWindowCascadeOnParentWindow = 0x00000005,
	kWIndowCascadeOnParentWindowScreen = 0x00000006,
	kWindowAlertPositionOnMainScreen = 0x00000007,
	kWindowAlertPositionOnParentWindow = 0x00000008,
	kWindowAlertPositionOnParentWindowScreen = 0x00000009
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • GetWindowRegion Types																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/


enum {
																/* Region values to pass into GetWindowRegion */
	kWindowTitleBarRgn			= 0,
	kWindowTitleTextRgn			= 1,
	kWindowCloseBoxRgn			= 2,
	kWindowZoomBoxRgn			= 3,
	kWindowDragRgn				= 5,
	kWindowGrowRgn				= 6,
	kWindowCollapseBoxRgn		= 7,
	kWindowTitleProxyIconRgn	= 8,							/* Mac OS 8.5 and later*/
	kWindowStructureRgn			= 32,
	kWindowContentRgn			= 33
};


typedef UInt16 							WindowRegionCode;
/* GetWindowRegionRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion*/

struct GetWindowRegionRec {
	RgnHandle 						winRgn;
	WindowRegionCode 				regionCode;
};
typedef struct GetWindowRegionRec		GetWindowRegionRec;

typedef GetWindowRegionRec *			GetWindowRegionPtr;
typedef GetWindowRegionRec *			GetWindowRegionRecPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • WDEF Message Types (Mac OS 8.5 and later)											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   SetupWindowProxyDragImageRec - setup the proxy icon drag image
   Both regions are allocated and disposed by the Window Manager.
   The GWorld is disposed of by the Window Manager, but the WDEF must allocate
   it.  See Technote on Drag Manager 1.1 additions for more information and sample code for
   setting up drag images.
*/


struct SetupWindowProxyDragImageRec {
	GWorldPtr 						imageGWorld;				/* locked GWorld containing the drag image - output - can be NULL*/
	RgnHandle 						imageRgn;					/* image clip region, contains the portion of the image which gets blitted to screen - preallocated output - if imageGWorld is NULL, this is ignored*/
	RgnHandle 						outlineRgn;					/* the outline region used on shallow monitors - preallocated output - must always be non-empty*/
};
typedef struct SetupWindowProxyDragImageRec SetupWindowProxyDragImageRec;
/* MeasureWindowTitleRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion*/

struct MeasureWindowTitleRec {
																/* output parameters*/
	SInt16 							fullTitleWidth;				/* text + proxy icon width*/
	SInt16 							titleTextWidth;				/* text width*/

																/* input parameters*/
	Boolean 						isUnicodeTitle;
	Boolean 						unused;						/* future use*/
};
typedef struct MeasureWindowTitleRec	MeasureWindowTitleRec;
typedef MeasureWindowTitleRec *			MeasureWindowTitleRecPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Standard Window Kinds																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	dialogKind					= 2,
	userKind					= 8,
	kDialogWindowKind			= 2,
	kApplicationWindowKind		= 8
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • FindWindow Result Codes															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	inDesk						= 0,
	inNoWindow					= 0,
	inMenuBar					= 1,
	inSysWindow					= 2,
	inContent					= 3,
	inDrag						= 4,
	inGrow						= 5,
	inGoAway					= 6,
	inZoomIn					= 7,
	inZoomOut					= 8,
	inCollapseBox				= 11,							/* Mac OS 8.0 and later*/
	inProxyIcon					= 12							/* Mac OS 8.5 and later*/
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Hit Test Result Codes											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	wNoHit						= 0,
	wInContent					= 1,
	wInDrag						= 2,
	wInGrow						= 3,
	wInGoAway					= 4,
	wInZoomIn					= 5,
	wInZoomOut					= 6,
	wInCollapseBox				= 9,							/* Mac OS 8.0 and later*/
	wInProxyIcon				= 10							/* Mac OS 8.5 and later*/
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Messages															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/


enum {
	kWindowMsgDraw				= 0,
	kWindowMsgHitTest			= 1,
	kWindowMsgCalculateShape	= 2,
	kWindowMsgInitialize		= 3,
	kWindowMsgCleanUp			= 4,
	kWindowMsgDrawGrowOutline	= 5,
	kWindowMsgDrawGrowBox		= 6
};

/* Messages available in Mac OS 8.0 and later*/

enum {
	kWindowMsgGetFeatures		= 7,
	kWindowMsgGetRegion			= 8
};

/* Messages available in Mac OS 8.5 and later*/

enum {
	kWindowMsgDragHilite		= 9,							/* parameter boolean indicating on or off*/
	kWindowMsgModified			= 10,							/* parameter boolean indicating saved (false) or modified (true)*/
	kWindowMsgDrawInCurrentPort	= 11,							/* same as kWindowMsgDraw, but must draw in current port*/
	kWindowMsgSetupProxyDragImage = 12,							/* parameter pointer to SetupWindowProxyDragImageRec*/
	kWindowMsgStateChanged		= 13,							/* something about the window's state has changed*/
	kWindowMsgMeasureTitle		= 14							/* measure and return the ideal title width*/
};

/* old names*/

enum {
	wDraw						= 0,
	wHit						= 1,
	wCalcRgns					= 2,
	wNew						= 3,
	wDispose					= 4,
	wGrow						= 5,
	wDrawGIcon					= 6
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • State-changed Flags for kWindowMsgStateChanged (Mac OS 8.5 and later)				*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kWindowStateTitleChanged	= (1 << 0),
	kWindowStateSizeChanged		= (1 << 1),
	kWindowStatePositionChanged	= (1 << 2),
	kWindowStateZOrderChanged	= (1 << 3),
	kWindowStateVisibilityChanged = (1 << 4),
	kWindowStateHiliteChanged	= (1 << 5),
	kWindowStateCollapseChanged	= (1 << 6)
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Feature Bits																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kWindowCanGrow				= (1 << 0),
	kWindowCanZoom				= (1 << 1),
	kWindowCanCollapse			= (1 << 2),
	kWindowIsModal				= (1 << 3),
	kWindowCanGetWindowRegion	= (1 << 4),
	kWindowIsAlert				= (1 << 5),
	kWindowHasTitleBar			= (1 << 6)
};

/* Message bits available in Mac OS 8.5 and later*/

enum {
	kWindowSupportsDragHilite	= (1 << 7),						/* window definition supports kWindowMsgDragHilite*/
	kWindowSupportsModifiedBit	= (1 << 8),						/* window definition supports kWindowMsgModified*/
	kWindowCanDrawInCurrentPort	= (1 << 9),						/* window definition supports kWindowMsgDrawInCurrentPort*/
	kWindowCanSetupProxyDragImage = (1 << 10),					/* window definition supports kWindowMsgSetupProxyDragImage*/
	kWindowCanMeasureTitle		= (1 << 11),					/* window definition supports kWindowMsgMeasureTitle*/
	kWindowWantsDisposeAtProcessDeath = (1 << 12)				/* window definition wants a Dispose message for windows still extant during ExitToShell*/
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Desktop Pattern Resource ID														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	deskPatID					= 16
};



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Color Part Codes															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	wContentColor				= 0,
	wFrameColor					= 1,
	wTextColor					= 2,
	wHiliteColor				= 3,
	wTitleBarColor				= 4
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Region Dragging Constants															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/


enum {
	kMouseUpOutOfSlop			= (long)0x80008000
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Color Table																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct WinCTab {
	long 							wCSeed;						/* reserved */
	short 							wCReserved;					/* reserved */
	short 							ctSize;						/* usually 4 for windows */
	ColorSpec 						ctTable[5];
};
typedef struct WinCTab					WinCTab;

typedef WinCTab *						WCTabPtr;
typedef WCTabPtr *						WCTabHandle;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • WindowRecord																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef struct WindowRecord 			WindowRecord;
typedef WindowRecord *					WindowPeek;

struct WindowRecord {
	GrafPort 						port;
	short 							windowKind;
	Boolean 						visible;
	Boolean 						hilited;
	Boolean 						goAwayFlag;
	Boolean 						spareFlag;
	RgnHandle 						strucRgn;
	RgnHandle 						contRgn;
	RgnHandle 						updateRgn;
	Handle 							windowDefProc;
	Handle 							dataHandle;
	StringHandle 					titleHandle;
	short 							titleWidth;
	Handle 							controlList;
	WindowPeek 						nextWindow;
	PicHandle 						windowPic;
	long 							refCon;
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Color WindowRecord																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef struct CWindowRecord 			CWindowRecord;
typedef CWindowRecord *					CWindowPeek;

struct CWindowRecord {
	CGrafPort 						port;
	short 							windowKind;
	Boolean 						visible;
	Boolean 						hilited;
	Boolean 						goAwayFlag;
	Boolean 						spareFlag;
	RgnHandle 						strucRgn;
	RgnHandle 						contRgn;
	RgnHandle 						updateRgn;
	Handle 							windowDefProc;
	Handle 							dataHandle;
	StringHandle 					titleHandle;
	short 							titleWidth;
	Handle 							controlList;
	CWindowPeek 					nextWindow;
	PicHandle 						windowPic;
	long 							refCon;
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • AuxWinHandle																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef struct AuxWinRec 				AuxWinRec;
typedef AuxWinRec *						AuxWinPtr;
typedef AuxWinPtr *						AuxWinHandle;

struct AuxWinRec {
	AuxWinHandle 					awNext;						/*handle to next AuxWinRec*/
	WindowPtr 						awOwner;					/*ptr to window */
	CTabHandle 						awCTable;					/*color table for this window*/
	Handle 							reserved;
	long 							awFlags;					/*reserved for expansion*/
	CTabHandle 						awReserved;					/*reserved for expansion*/
	long 							awRefCon;					/*user Constant*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• BasicWindowDescription	(Mac OS 8.5 and later)									*/
/*																						*/
/*	Contains statically-sized basic attributes of the window, for storage in a			*/
/*	collection item.																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* constants for the version field*/

enum {
	kWindowDefinitionVersionOne	= 1,
	kWindowDefinitionVersionTwo	= 2
};

/* constants for the stateflags bit field */

enum {
	kWindowIsCollapsedState		= (1 << 0L)
};


struct BasicWindowDescription {
	UInt32 							descriptionSize;			/* sizeof(BasicWindowDescription)*/

	Rect 							windowContentRect;			/* location on screen*/
	Rect 							windowZoomRect;				/* location on screen when zoomed out*/
	UInt32 							windowRefCon;				/* the refcon - __avoid saving stale pointers here__	*/
	UInt32 							windowStateFlags;			/* flags indicating status of transient window state*/
	WindowPositionMethod 			windowPositionMethod;		/* method last used by RepositionWindow to position the window (if any)*/

	UInt32 							windowDefinitionVersion;
	union {
		struct {
			SInt16 							windowDefProc;		/* defProc and variant*/
			Boolean 						windowHasCloseBox;
		} 								versionOne;

		struct {
			WindowClass 					windowClass;		/* the class*/
			WindowAttributes 				windowAttributes;	/* the attributes*/
		} 								versionTwo;

	} 								windowDefinition;
};
typedef struct BasicWindowDescription	BasicWindowDescription;
/*  the window manager stores the default collection items using these IDs*/

enum {
	kStoredWindowSystemTag		= FOUR_CHAR_CODE('appl'),		/* Only Apple collection items will be of this tag*/
	kStoredBasicWindowDescriptionID = FOUR_CHAR_CODE('sbas'),	/* BasicWindowDescription*/
	kStoredWindowPascalTitleID	= FOUR_CHAR_CODE('s255')		/* pascal title string*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Class Ordering																*/
/*																						*/
/*	Special cases for the “behind” parameter in window creation calls.					*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
#define kFirstWindowOfClass ((WindowPtr)-1L)
#define kLastWindowOfClass ((WindowPtr)0L)
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Zoom Information Handle 															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct WStateData {
	Rect 							userState;					/*user zoom state*/
	Rect 							stdState;					/*standard zoom state*/
};
typedef struct WStateData				WStateData;
typedef WStateData *					WStateDataPtr;
typedef WStateDataPtr *					WStateDataHandle;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Creation & Persistence														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( WindowPtr )
GetNewCWindow					(short 					windowID,
								 void *					wStorage,
								 WindowPtr 				behind)								ONEWORDINLINE(0xAA46);

EXTERN_API( WindowPtr )
NewWindow						(void *					wStorage,
								 const Rect *			boundsRect,
								 ConstStr255Param 		title,
								 Boolean 				visible,
								 short 					theProc,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 long 					refCon)								ONEWORDINLINE(0xA913);

EXTERN_API( WindowPtr )
GetNewWindow					(short 					windowID,
								 void *					wStorage,
								 WindowPtr 				behind)								ONEWORDINLINE(0xA9BD);

EXTERN_API( WindowPtr )
NewCWindow						(void *					wStorage,
								 const Rect *			boundsRect,
								 ConstStr255Param 		title,
								 Boolean 				visible,
								 short 					procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 long 					refCon)								ONEWORDINLINE(0xAA45);

EXTERN_API( void )
DisposeWindow					(WindowPtr 				window)								ONEWORDINLINE(0xA914);

#if TARGET_OS_MAC
	#define MacCloseWindow CloseWindow
#endif
EXTERN_API( void )
MacCloseWindow					(WindowPtr 				window)								ONEWORDINLINE(0xA92D);


/* Routines available in Mac OS 8.5 and later*/

EXTERN_API( OSStatus )
CreateNewWindow					(WindowClass 			windowClass,
								 WindowAttributes 		attributes,
								 const Rect *			bounds,
								 WindowPtr *			outWindow);

/* Create a window from a ‘wind’ resource*/
EXTERN_API( OSStatus )
CreateWindowFromResource		(SInt16 				resID,
								 WindowPtr *			outWindow);

/* window persistence*/
EXTERN_API( OSStatus )
StoreWindowIntoCollection		(WindowPtr 				window,
								 Collection 			collection);

EXTERN_API( OSStatus )
CreateWindowFromCollection		(Collection 			collection,
								 WindowPtr *			outWindow);

/* window refcounting*/
EXTERN_API( OSStatus )
GetWindowOwnerCount				(WindowPtr 				window,
								 UInt32 *				outCount);

EXTERN_API( OSStatus )
CloneWindow						(WindowPtr 				window);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Class Accessors (Mac OS 8.5 and later)										*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
GetWindowClass					(WindowPtr 				window,
								 WindowClass *			outClass);

EXTERN_API( OSStatus )
GetWindowAttributes				(WindowPtr 				window,
								 WindowAttributes *		outAttributes);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Floating Windows (Mac OS 8.5 and later)											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
ShowFloatingWindows				(void);

EXTERN_API( OSStatus )
HideFloatingWindows				(void);

EXTERN_API( Boolean )
AreFloatingWindowsVisible		(void);

EXTERN_API( WindowPtr )
FrontNonFloatingWindow			(void);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Background Imaging																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
SetWinColor						(WindowPtr 				window,
								 WCTabHandle 			newColorTable)						ONEWORDINLINE(0xAA41);

EXTERN_API( void )
SetDeskCPat						(PixPatHandle 			deskPixPat)							ONEWORDINLINE(0xAA47);

/* Routines available in Mac OS 8.5 and later*/

EXTERN_API( OSStatus )
SetWindowContentColor			(WindowPtr 				window,
								 RGBColor *				color);

EXTERN_API( OSStatus )
GetWindowContentColor			(WindowPtr 				window,
								 RGBColor *				color);

EXTERN_API( OSStatus )
GetWindowContentPattern			(WindowPtr 				window,
								 PixPatHandle 			outPixPat);

EXTERN_API( OSStatus )
SetWindowContentPattern			(WindowPtr 				window,
								 PixPatHandle 			pixPat);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Low-Level Region & Painting Routines												*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
ClipAbove						(WindowPtr 				window)								ONEWORDINLINE(0xA90B);

EXTERN_API( void )
SaveOld							(WindowPtr 				window)								ONEWORDINLINE(0xA90E);

EXTERN_API( void )
DrawNew							(WindowPtr 				window,
								 Boolean 				update)								ONEWORDINLINE(0xA90F);

EXTERN_API( void )
PaintOne						(WindowPtr 				window,
								 RgnHandle 				clobberedRgn)						ONEWORDINLINE(0xA90C);

EXTERN_API( void )
PaintBehind						(WindowPtr 				startWindow,
								 RgnHandle 				clobberedRgn)						ONEWORDINLINE(0xA90D);

EXTERN_API( void )
CalcVis							(WindowPtr 				window)								ONEWORDINLINE(0xA909);

EXTERN_API( void )
CalcVisBehind					(WindowPtr 				startWindow,
								 RgnHandle 				clobberedRgn)						ONEWORDINLINE(0xA90A);

EXTERN_API( Boolean )
CheckUpdate						(EventRecord *			theEvent)							ONEWORDINLINE(0xA911);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window List																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if TARGET_OS_MAC
	#define MacFindWindow FindWindow
#endif
EXTERN_API( short )
MacFindWindow					(Point 					thePoint,
								 WindowPtr *			window)								ONEWORDINLINE(0xA92C);

EXTERN_API( WindowPtr )
FrontWindow						(void)														ONEWORDINLINE(0xA924);

EXTERN_API( void )
BringToFront					(WindowPtr 				window)								ONEWORDINLINE(0xA920);

EXTERN_API( void )
SendBehind						(WindowPtr 				window,
								 WindowPtr 				behindWindow)						ONEWORDINLINE(0xA921);

EXTERN_API( void )
SelectWindow					(WindowPtr 				window)								ONEWORDINLINE(0xA91F);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Misc Low-Level stuff																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
InitWindows						(void)														ONEWORDINLINE(0xA912);

EXTERN_API( void )
GetWMgrPort						(GrafPtr *				wPort)								ONEWORDINLINE(0xA910);

EXTERN_API( void )
GetCWMgrPort					(CGrafPtr *				wMgrCPort)							ONEWORDINLINE(0xAA48);

/* Routines available in Mac OS 8.5 and later*/

EXTERN_API( Boolean )
IsValidWindowPtr				(GrafPtr 				grafPort);

EXTERN_API( OSStatus )
InitFloatingWindows				(void);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Various & Sundry Window Accessors													*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
HiliteWindow					(WindowPtr 				window,
								 Boolean 				fHilite)							ONEWORDINLINE(0xA91C);

EXTERN_API( void )
SetWRefCon						(WindowPtr 				window,
								 long 					data)								ONEWORDINLINE(0xA918);

EXTERN_API( long )
GetWRefCon						(WindowPtr 				window)								ONEWORDINLINE(0xA917);

EXTERN_API( void )
SetWindowPic					(WindowPtr 				window,
								 PicHandle 				pic)								ONEWORDINLINE(0xA92E);

EXTERN_API( PicHandle )
GetWindowPic					(WindowPtr 				window)								ONEWORDINLINE(0xA92F);

EXTERN_API( short )
GetWVariant						(WindowPtr 				window)								ONEWORDINLINE(0xA80A);

/* Routines available in Mac OS 8.0 (Appearance 1.0) and later*/
EXTERN_API( OSStatus )
GetWindowFeatures				(WindowPtr 				window,
								 UInt32 *				outFeatures)						THREEWORDINLINE(0x303C, 0x0013, 0xAA74);

EXTERN_API( OSStatus )
GetWindowRegion					(WindowPtr 				window,
								 WindowRegionCode 		inRegionCode,
								 RgnHandle 				ioWinRgn)							THREEWORDINLINE(0x303C, 0x0014, 0xAA74);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Update Events																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

EXTERN_API( void )
InvalRect						(const Rect *			badRect)							ONEWORDINLINE(0xA928);

EXTERN_API( void )
InvalRgn						(RgnHandle 				badRgn)								ONEWORDINLINE(0xA927);

EXTERN_API( void )
ValidRect						(const Rect *			goodRect)							ONEWORDINLINE(0xA92A);

EXTERN_API( void )
ValidRgn						(RgnHandle 				goodRgn)							ONEWORDINLINE(0xA929);

EXTERN_API( void )
BeginUpdate						(WindowPtr 				window)								ONEWORDINLINE(0xA922);

EXTERN_API( void )
EndUpdate						(WindowPtr 				window)								ONEWORDINLINE(0xA923);

/* Routines available in Mac OS 8.5 and later*/
EXTERN_API( OSStatus )
InvalWindowRgn					(WindowPtr 				window,
								 RgnHandle 				region);

EXTERN_API( OSStatus )
InvalWindowRect					(WindowPtr 				window,
								 const Rect *			bounds);

EXTERN_API( OSStatus )
ValidWindowRgn					(WindowPtr 				window,
								 RgnHandle 				region);

EXTERN_API( OSStatus )
ValidWindowRect					(WindowPtr 				window,
								 const Rect *			bounds);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • DrawGrowIcon																		*/
/*																						*/
/*	DrawGrowIcon is deprecated in Mac OS 8.0 and later.  Theme-savvy window defprocs	*/
/*	include the grow box in the window frame automatically.								*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
DrawGrowIcon					(WindowPtr 				window)								ONEWORDINLINE(0xA904);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Titles																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
SetWTitle						(WindowPtr 				window,
								 ConstStr255Param 		title)								ONEWORDINLINE(0xA91A);

EXTERN_API( void )
GetWTitle						(WindowPtr 				window,
								 Str255 				title)								ONEWORDINLINE(0xA919);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Proxies (Mac OS 8.5 and later)												*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
SetWindowProxyFSSpec			(WindowPtr 				window,
								 const FSSpec *			inFile);

EXTERN_API( OSStatus )
GetWindowProxyFSSpec			(WindowPtr 				window,
								 FSSpec *				outFile);

EXTERN_API( OSStatus )
SetWindowProxyAlias				(WindowPtr 				window,
								 AliasHandle 			alias);

EXTERN_API( OSStatus )
GetWindowProxyAlias				(WindowPtr 				window,
								 AliasHandle *			alias);

EXTERN_API( OSStatus )
SetWindowProxyCreatorAndType	(WindowPtr 				window,
								 OSType 				fileCreator,
								 OSType 				fileType,
								 SInt16 				vRefNum);

EXTERN_API( OSStatus )
GetWindowProxyIcon				(WindowPtr 				window,
								 IconRef *				outIcon);

EXTERN_API( OSStatus )
SetWindowProxyIcon				(WindowPtr 				window,
								 IconRef 				icon);

EXTERN_API( OSStatus )
RemoveWindowProxy				(WindowPtr 				window);

EXTERN_API( OSStatus )
BeginWindowProxyDrag			(WindowPtr 				window,
								 DragReference *		outNewDrag,
								 RgnHandle 				outDragOutlineRgn);

EXTERN_API( OSStatus )
EndWindowProxyDrag				(WindowPtr 				window,
								 DragReference 			theDrag);

EXTERN_API( OSStatus )
TrackWindowProxyFromExistingDrag (WindowPtr 			window,
								 Point 					startPt,
								 DragReference 			drag,
								 RgnHandle 				inDragOutlineRgn);

EXTERN_API( OSStatus )
TrackWindowProxyDrag			(WindowPtr 				window,
								 Point 					startPt);

EXTERN_API( Boolean )
IsWindowModified				(WindowPtr 				window);

EXTERN_API( OSStatus )
SetWindowModified				(WindowPtr 				window,
								 Boolean 				modified);

EXTERN_API( Boolean )
IsWindowPathSelectClick			(WindowPtr 				window,
								 EventRecord *			event);

EXTERN_API( OSStatus )
WindowPathSelect				(WindowPtr 				window,
								 MenuHandle 			menu, /* can be NULL */
								 SInt32 *				outMenuResult);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• HiliteWindowFrameForDrag	(Mac OS 8.5 and later)									*/
/*																						*/
/*	If you call ShowDragHilite and HideDragHilite, you don’t need to use this routine.	*/
/*	If you implement custom drag hiliting, you should call HiliteWindowFrameForDrag		*/
/*	when the drag is tracking inside a window with drag-hilited content.				*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
HiliteWindowFrameForDrag		(WindowPtr 				window,
								 Boolean 				hilited)							TWOWORDINLINE(0x7019, 0xA829);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Transitions	(Mac OS 8.5 and later)											*/
/* 																						*/
/* 	TransitionWindow displays a window with accompanying animation and sound.			*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

typedef UInt32 							WindowTransitionEffect;

enum {
	kWindowZoomTransitionEffect	= 1								/* Finder-like zoom rectangles, use with Show or Open transition actions*/
};

typedef UInt32 							WindowTransitionAction;

enum {
	kWindowShowTransitionAction	= 1,							/* param is rect in global coordinates from which to start the animation*/
	kWindowHideTransitionAction	= 2								/* param is rect in global coordinates at which to end the animation*/
};

EXTERN_API( OSStatus )
TransitionWindow				(WindowPtr 				window,
								 WindowTransitionEffect  effect,
								 WindowTransitionAction  action,
								 const Rect *			rect) /* can be NULL */;


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Positioning																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

#if TARGET_OS_MAC
	#define MacMoveWindow MoveWindow
#endif
EXTERN_API( void )
MacMoveWindow					(WindowPtr 				window,
								 short 					hGlobal,
								 short 					vGlobal,
								 Boolean 				front)								ONEWORDINLINE(0xA91B);

EXTERN_API( void )
SizeWindow						(WindowPtr 				window,
								 short 					w,
								 short 					h,
								 Boolean 				fUpdate)							ONEWORDINLINE(0xA91D);

EXTERN_API( long )
GrowWindow						(WindowPtr 				window,
								 Point 					startPt,
								 const Rect *			bBox)								ONEWORDINLINE(0xA92B);

EXTERN_API( void )
DragWindow						(WindowPtr 				window,
								 Point 					startPt,
								 const Rect *			boundsRect)							ONEWORDINLINE(0xA925);

EXTERN_API( void )
ZoomWindow						(WindowPtr 				window,
								 short 					partCode,
								 Boolean 				front)								ONEWORDINLINE(0xA83A);

/* Routines available in Mac OS 8.0 (Appearance 1.0) and later*/

EXTERN_API( Boolean )
IsWindowCollapsable				(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x000F, 0xAA74);

EXTERN_API( Boolean )
IsWindowCollapsed				(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x0010, 0xAA74);

EXTERN_API( OSStatus )
CollapseWindow					(WindowPtr 				window,
								 Boolean 				collapse)							THREEWORDINLINE(0x303C, 0x0011, 0xAA74);

EXTERN_API( OSStatus )
CollapseAllWindows				(Boolean 				collapse)							THREEWORDINLINE(0x303C, 0x0012, 0xAA74);

/* Routines available in Mac OS 8.5 and later*/

EXTERN_API( OSStatus )
RepositionWindow				(WindowPtr 				window,
								 WindowPtr 				parentWindow,
								 WindowPositionMethod 	method);

EXTERN_API( OSStatus )
SetWindowBounds					(WindowPtr 				window,
								 WindowRegionCode 		regionCode,
								 const Rect *			globalBounds);

EXTERN_API( OSStatus )
GetWindowBounds					(WindowPtr 				window,
								 WindowRegionCode 		regionCode,
								 Rect *					globalBounds);

EXTERN_API( OSStatus )
MoveWindowStructure				(WindowPtr 				window,
								 short 					hGlobal,
								 short 					vGlobal);

EXTERN_API( Boolean )
ResizeWindow					(WindowPtr 				window,
								 Point 					startPoint,
								 const Rect *			sizeConstraints, /* can be NULL */
								 Rect *					newContentRect);

EXTERN_API( Boolean )
IsWindowInStandardState			(WindowPtr 				window,
								 Point *				idealSize,
								 Rect *					idealStandardState);

EXTERN_API( OSStatus )
ZoomWindowIdeal					(WindowPtr 				window,
								 SInt16 				partCode,
								 Point *				ioIdealSize);

EXTERN_API( OSStatus )
GetWindowIdealUserState			(WindowPtr 				window,
								 Rect *					userState);

EXTERN_API( OSStatus )
SetWindowIdealUserState			(WindowPtr 				window,
								 Rect *					userState);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Visibility																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

EXTERN_API( void )
HideWindow						(WindowPtr 				window)								ONEWORDINLINE(0xA916);

#if TARGET_OS_MAC
	#define MacShowWindow ShowWindow
#endif
EXTERN_API( void )
MacShowWindow					(WindowPtr 				window)								ONEWORDINLINE(0xA915);

EXTERN_API( void )
ShowHide						(WindowPtr 				window,
								 Boolean 				showFlag)							ONEWORDINLINE(0xA908);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Properties (Mac OS 8.5 and later)											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

EXTERN_API( OSStatus )
GetWindowProperty				(WindowPtr 				window,
								 PropertyCreator 		propertyCreator,
								 PropertyTag 			propertyTag,
								 UInt32 				bufferSize,
								 UInt32 *				actualSize, /* can be NULL */
								 void *					propertyBuffer);

EXTERN_API( OSStatus )
GetWindowPropertySize			(WindowPtr 				window,
								 PropertyCreator 		creator,
								 PropertyTag 			tag,
								 UInt32 *				size);

EXTERN_API( OSStatus )
SetWindowProperty				(WindowPtr 				window,
								 PropertyCreator 		propertyCreator,
								 PropertyTag 			propertyTag,
								 UInt32 				propertySize,
								 void *					propertyBuffer);

EXTERN_API( OSStatus )
RemoveWindowProperty			(WindowPtr 				window,
								 PropertyCreator 		propertyCreator,
								 PropertyTag 			propertyTag);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Utilities																			*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( long )
PinRect							(const Rect *			theRect,
								 Point 					thePt)								ONEWORDINLINE(0xA94E);


EXTERN_API( RgnHandle )
GetGrayRgn						(void)														TWOWORDINLINE(0x2EB8, 0x09EE);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Part Tracking																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( Boolean )
TrackBox						(WindowPtr 				window,
								 Point 					thePt,
								 short 					partCode)							ONEWORDINLINE(0xA83B);

EXTERN_API( Boolean )
TrackGoAway						(WindowPtr 				window,
								 Point 					thePt)								ONEWORDINLINE(0xA91E);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Region Dragging																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( long )
DragGrayRgn						(RgnHandle 				theRgn,
								 Point 					startPt,
								 const Rect *			limitRect,
								 const Rect *			slopRect,
								 short 					axis,
								 DragGrayRgnUPP 		actionProc)							ONEWORDINLINE(0xA905);

EXTERN_API( long )
DragTheRgn						(RgnHandle 				theRgn,
								 Point 					startPt,
								 const Rect *			limitRect,
								 const Rect *			slopRect,
								 short 					axis,
								 DragGrayRgnUPP 		actionProc)							ONEWORDINLINE(0xA926);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• GetAuxWin																			*/
/*																						*/
/*	Avoid using GetAuxWin if at all possible											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( Boolean )
GetAuxWin						(WindowPtr 				window,
								 AuxWinHandle *			awHndl)								ONEWORDINLINE(0xAA42);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • MixedMode & ProcPtrs																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( long , WindowDefProcPtr )(short varCode, WindowPtr window, short message, long param);
typedef CALLBACK_API( void , DeskHookProcPtr )(Boolean mouseClick, EventRecord *theEvent);
/*
	WARNING: DeskHookProcPtr uses register based parameters under classic 68k
			 and cannot be written in a high-level language without 
			 the help of mixed mode or assembly glue.
*/
typedef STACK_UPP_TYPE(WindowDefProcPtr) 						WindowDefUPP;
typedef REGISTER_UPP_TYPE(DeskHookProcPtr) 						DeskHookUPP;
enum { uppWindowDefProcInfo = 0x00003BB0 }; 					/* pascal 4_bytes Func(2_bytes, 4_bytes, 2_bytes, 4_bytes) */
enum { uppDeskHookProcInfo = 0x00130802 }; 						/* register no_return_value Func(1_byte:D0, 4_bytes:A0) */
#define NewWindowDefProc(userRoutine) 							(WindowDefUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowDefProcInfo, GetCurrentArchitecture())
#define NewDeskHookProc(userRoutine) 							(DeskHookUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDeskHookProcInfo, GetCurrentArchitecture())
#define CallWindowDefProc(userRoutine, varCode, window, message, param)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppWindowDefProcInfo, (varCode), (window), (message), (param))
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter CallDeskHookProc(__A1, __D0, __A0)
	void CallDeskHookProc(DeskHookUPP routine, Boolean mouseClick, EventRecord * theEvent) = 0x4E91;
#else
	#define CallDeskHookProc(userRoutine, mouseClick, theEvent)  CALL_TWO_PARAMETER_UPP((userRoutine), uppDeskHookProcInfo, (mouseClick), (theEvent))
#endif
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • C Glue																				*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if CGLUESUPPORTED
EXTERN_API_C( void )
setwtitle						(WindowPtr 				window,
								 const char *			title);

EXTERN_API_C( Boolean )
trackgoaway						(WindowPtr 				window,
								 Point *				thePt);

EXTERN_API_C( short )
findwindow						(Point *				thePoint,
								 WindowPtr *			window);

EXTERN_API_C( void )
getwtitle						(WindowPtr 				window,
								 char *					title);

EXTERN_API_C( long )
growwindow						(WindowPtr 				window,
								 Point *				startPt,
								 const Rect *			bBox);

EXTERN_API_C( WindowPtr )
newwindow						(void *					wStorage,
								 const Rect *			boundsRect,
								 const char *			title,
								 Boolean 				visible,
								 short 					theProc,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 long 					refCon);

EXTERN_API_C( WindowPtr )
newcwindow						(void *					wStorage,
								 const Rect *			boundsRect,
								 const char *			title,
								 Boolean 				visible,
								 short 					procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 long 					refCon);

EXTERN_API_C( long )
pinrect							(const Rect *			theRect,
								 Point *				thePt);

EXTERN_API_C( Boolean )
trackbox						(WindowPtr 				window,
								 Point *				thePt,
								 short 					partCode);

EXTERN_API_C( long )
draggrayrgn						(RgnHandle 				theRgn,
								 Point *				startPt,
								 const Rect *			boundsRect,
								 const Rect *			slopRect,
								 short 					axis,
								 DragGrayRgnUPP 		actionProc);

EXTERN_API_C( void )
dragwindow						(WindowPtr 				window,
								 Point *				startPt,
								 const Rect *			boundsRect);

#endif  /* CGLUESUPPORTED */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • WindowRecord accessor macros														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
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
*/
#ifdef __cplusplus
inline CGrafPtr		GetWindowPort(WindowPtr w) 					{ return (CGrafPtr) w; 													}
inline void			SetPortWindowPort(WindowPtr w)				{ MacSetPort( (GrafPtr) GetWindowPort(w)); }
inline SInt16		GetWindowKind(WindowPtr w) 					{ return ( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort))); 			}
inline void			SetWindowKind(WindowPtr	w, SInt16 wKind)	{ *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)) = wKind;  			}
#if TARGET_OS_MAC
inline Boolean		IsWindowVisible(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x2); 		}
#endif
inline Boolean		MacIsWindowVisible(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x2); 		}
inline Boolean		IsWindowHilited(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x3);		}
inline Boolean		GetWindowGoAwayFlag(WindowPtr w)			{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x4);		}
inline Boolean		GetWindowZoomFlag(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x5);		}
inline void			GetWindowStructureRgn(WindowPtr w, RgnHandle r)	{ MacCopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0x6), r );	}
inline void			GetWindowContentRgn(WindowPtr w, RgnHandle r)	{ MacCopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xA), r );	}
inline void			GetWindowUpdateRgn(WindowPtr w, RgnHandle r)	{ MacCopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xE), r );	}
inline SInt16		GetWindowTitleWidth(WindowPtr w)				{ return *(SInt16 *)(((UInt8 *) w) + sizeof(GrafPort) + 0x1E);			}
#if TARGET_OS_MAC
inline WindowPtr	GetNextWindow(WindowPtr w)						{ return *(WindowPtr *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x24);		}
#endif
inline WindowPtr	MacGetNextWindow(WindowPtr w)					{ return *(WindowPtr *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x24);		}

inline void	GetWindowStandardState(WindowPtr w, Rect *r)
{	Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));
if (stateRects != NULL)	*r = stateRects[1];		}
inline void	SetWindowStandardState(WindowPtr w, const Rect *r)
{ 	Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));
	if (stateRects != NULL)	stateRects[1] = *r; 	}
inline void	GetWindowUserState(WindowPtr w, Rect *r)
{ 	Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));
	if (stateRects != NULL)	*r = stateRects[0]; }
inline void	SetWindowUserState(WindowPtr w, const Rect *r)
{ Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));
	if (stateRects != NULL)	stateRects[0] = *r; }
inline Handle		GetWindowDataHandle(WindowPtr w)				{	return	(((WindowPeek) (w))->dataHandle);				}
inline void			SetWindowDataHandle(WindowPtr w, Handle data)	{	(((WindowPeek) (w))->dataHandle) = ((Handle) (data));	}
#else
#if TARGET_OS_MAC
#define IsWindowVisible MacIsWindowVisible
#define GetNextWindow MacGetNextWindow
#endif
#define ShowHideWindow(w)						ShowHide(w)
#define SetPortWindowPort(w)					MacSetPort( (GrafPtr) GetWindowPort(w) )
#define GetWindowPort(w)						( (CGrafPtr) w)
#define GetWindowKind(w)						( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)))
#define SetWindowKind(w, wKind)					( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)) = wKind )
#define MacIsWindowVisible(w)					( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x2))
#define IsWindowHilited(w)						( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x3))
#define GetWindowGoAwayFlag(w)					( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x4))
#define GetWindowZoomFlag(w)					( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x5))
#define GetWindowStructureRgn(w, aRgnHandle)	MacCopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0x6), aRgnHandle )
#define GetWindowContentRgn(w, aRgnHandle)		MacCopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xA), aRgnHandle )

#define GetWindowUpdateRgn(w, aRgnHandle)		MacCopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xE), aRgnHandle )

#define GetWindowTitleWidth(w)					( *(SInt16 *)		(((UInt8 *) w) + sizeof(GrafPort) + 0x1E))
#define MacGetNextWindow(w)						( *(WindowPtr *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x24))

#define GetWindowStandardState(w, aRectPtr)	do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	*aRectPtr = stateRects[1]; } while (false)
#define SetWindowStandardState(w, aRectPtr)	do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	stateRects[1] = *aRectPtr; } while (false)
#define GetWindowUserState(w, aRectPtr)		do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	*aRectPtr = stateRects[0]; } while (false)
#define SetWindowUserState(w, aRectPtr)		do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	stateRects[0] = *aRectPtr; } while (false)
#define GetWindowDataHandle(windowRef)				(((WindowPeek) (windowRef))->dataHandle)
#define SetWindowDataHandle(windowRef, data)		(((WindowPeek) (windowRef))->dataHandle) = ((Handle) (data))

#endif  /* defined(__cplusplus) */











#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MACWINDOWS__ */

