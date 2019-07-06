/*
 	File:		MacWindows.h
 
 	Contains:	Window Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __MACWINDOWS__
#define __MACWINDOWS__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __EVENTS__
#include <Events.h>
#endif
#ifndef __CONTROLS__
#include <Controls.h>
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

/*
  _________________________________________________________________________________________________________
      
   • WINDOW DEFINITION TYPE
  _________________________________________________________________________________________________________
*/

enum {
	kWindowDefProcType			= FOUR_CHAR_CODE('WDEF')
};

/*
  _________________________________________________________________________________________________________
      
   • WINDOW DEFINITION ID'S
  _________________________________________________________________________________________________________
*/


enum {
	kStandardWindowDefinition	= 0,							/* for document windows and dialogs*/
	kRoundWindowDefinition		= 1,							/* old da-style window*/
	kFloatingWindowDefinition	= 124							/* for floating windows*/
};

/*
  _________________________________________________________________________________________________________
      
   • VARIANT CODES
  _________________________________________________________________________________________________________
*/


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

/*
  _________________________________________________________________________________________________________
      
   • PROC-ID'S
  _________________________________________________________________________________________________________
*/


enum {
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

/*
  _________________________________________________________________________________________________________
      
   • STANDARD WINDOW KINDS
  _________________________________________________________________________________________________________
*/


enum {
	dialogKind					= 2,
	userKind					= 8,
	kDialogWindowKind			= 2,
	kApplicationWindowKind		= 8
};


/*
  _________________________________________________________________________________________________________
      
   • FIND WINDOW RESULT CODES
  _________________________________________________________________________________________________________
*/


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
	inZoomOut					= 8
};


enum {
	wDraw						= 0,
	wHit						= 1,
	wCalcRgns					= 2,
	wNew						= 3,
	wDispose					= 4,
	wGrow						= 5,
	wDrawGIcon					= 6
};


enum {
	deskPatID					= 16
};

/*
  _________________________________________________________________________________________________________
      
   • WINDOW DEFINITION HIT TEST RESULT CODES ("WINDOW PART")
  _________________________________________________________________________________________________________
*/


enum {
	wNoHit						= 0,
	wInContent					= 1,
	wInDrag						= 2,
	wInGrow						= 3,
	wInGoAway					= 4,
	wInZoomIn					= 5,
	wInZoomOut					= 6
};

/*
  _________________________________________________________________________________________________________
      
   • WINDOW COLOR PART CODES
  _________________________________________________________________________________________________________
*/


enum {
	wContentColor				= 0,
	wFrameColor					= 1,
	wTextColor					= 2,
	wHiliteColor				= 3,
	wTitleBarColor				= 4
};

/*
  _________________________________________________________________________________________________________
   • WINDOW COLOR TABLE STRUCTURE
  _________________________________________________________________________________________________________
*/

struct WinCTab {
	long 							wCSeed;						/* reserved */
	short 							wCReserved;					/* reserved */
	short 							ctSize;						/* usually 4 for windows */
	ColorSpec 						ctTable[5];
};
typedef struct WinCTab WinCTab;

typedef WinCTab *						WCTabPtr;
typedef WCTabPtr *						WCTabHandle;
/*
  _________________________________________________________________________________________________________
   • WINDOWRECORD
  _________________________________________________________________________________________________________
*/
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
	ControlHandle 					controlList;
	WindowPeek 						nextWindow;
	PicHandle 						windowPic;
	long 							refCon;
};

/*
  _________________________________________________________________________________________________________
   • CWINDOWRECORD
  _________________________________________________________________________________________________________
*/
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
	ControlHandle 					controlList;
	CWindowPeek 					nextWindow;
	PicHandle 						windowPic;
	long 							refCon;
};

/*
  _________________________________________________________________________________________________________
   • AUXWINDHANDLE
  _________________________________________________________________________________________________________
*/
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

/*
  _________________________________________________________________________________________________________
   • WSTATEHANDLE
  _________________________________________________________________________________________________________
*/
struct WStateData {
	Rect 							userState;					/*user state*/
	Rect 							stdState;					/*standard state*/
};
typedef struct WStateData WStateData;

typedef WStateData *					WStateDataPtr;
typedef WStateDataPtr *					WStateDataHandle;
/*
  _________________________________________________________________________________________________________
      
   • API
  _________________________________________________________________________________________________________
*/
EXTERN_API( void )
InitWindows						(void)														ONEWORDINLINE(0xA912);

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
DisposeWindow					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA914);

EXTERN_API( void )
CloseWindow						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA92D);

EXTERN_API( void )
InvalRect						(const Rect *			badRect)							ONEWORDINLINE(0xA928);

EXTERN_API( void )
InvalRgn						(RgnHandle 				badRgn)								ONEWORDINLINE(0xA927);

EXTERN_API( void )
ValidRect						(const Rect *			goodRect)							ONEWORDINLINE(0xA92A);

EXTERN_API( void )
ValidRgn						(RgnHandle 				goodRgn)							ONEWORDINLINE(0xA929);

EXTERN_API( Boolean )
CheckUpdate						(EventRecord *			theEvent)							ONEWORDINLINE(0xA911);

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

EXTERN_API( void )
SetWinColor						(WindowPtr 				theWindow,
								 WCTabHandle 			newColorTable)						ONEWORDINLINE(0xAA41);

EXTERN_API( void )
SetDeskCPat						(PixPatHandle 			deskPixPat)							ONEWORDINLINE(0xAA47);

EXTERN_API( WindowPtr )
GetNewCWindow					(short 					windowID,
								 void *					wStorage,
								 WindowPtr 				behind)								ONEWORDINLINE(0xAA46);

EXTERN_API( void )
SetWTitle						(WindowPtr 				theWindow,
								 ConstStr255Param 		title)								ONEWORDINLINE(0xA91A);

EXTERN_API( void )
GetWTitle						(WindowPtr 				theWindow,
								 Str255 				title)								ONEWORDINLINE(0xA919);

EXTERN_API( void )
GetWMgrPort						(GrafPtr *				wPort)								ONEWORDINLINE(0xA910);

EXTERN_API( void )
GetCWMgrPort					(CGrafPtr *				wMgrCPort)							ONEWORDINLINE(0xAA48);

EXTERN_API( void )
SetWRefCon						(WindowPtr 				theWindow,
								 long 					data)								ONEWORDINLINE(0xA918);

EXTERN_API( long )
GetWRefCon						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA917);

EXTERN_API( void )
SelectWindow					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA91F);

EXTERN_API( void )
HideWindow						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA916);

EXTERN_API( void )
ShowWindow						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA915);

EXTERN_API( void )
ShowHide						(WindowPtr 				theWindow,
								 Boolean 				showFlag)							ONEWORDINLINE(0xA908);

EXTERN_API( void )
HiliteWindow					(WindowPtr 				theWindow,
								 Boolean 				fHilite)							ONEWORDINLINE(0xA91C);

EXTERN_API( void )
BringToFront					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA920);

EXTERN_API( void )
SendBehind						(WindowPtr 				theWindow,
								 WindowPtr 				behindWindow)						ONEWORDINLINE(0xA921);

EXTERN_API( WindowPtr )
FrontWindow						(void)														ONEWORDINLINE(0xA924);

EXTERN_API( void )
DrawGrowIcon					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA904);

EXTERN_API( void )
MoveWindow						(WindowPtr 				theWindow,
								 short 					hGlobal,
								 short 					vGlobal,
								 Boolean 				front)								ONEWORDINLINE(0xA91B);

EXTERN_API( void )
SizeWindow						(WindowPtr 				theWindow,
								 short 					w,
								 short 					h,
								 Boolean 				fUpdate)							ONEWORDINLINE(0xA91D);

EXTERN_API( void )
ZoomWindow						(WindowPtr 				theWindow,
								 short 					partCode,
								 Boolean 				front)								ONEWORDINLINE(0xA83A);

EXTERN_API( void )
BeginUpdate						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA922);

EXTERN_API( void )
EndUpdate						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA923);

EXTERN_API( void )
SetWindowPic					(WindowPtr 				theWindow,
								 PicHandle 				pic)								ONEWORDINLINE(0xA92E);

EXTERN_API( PicHandle )
GetWindowPic					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA92F);

EXTERN_API( long )
GrowWindow						(WindowPtr 				theWindow,
								 Point 					startPt,
								 const Rect *			bBox)								ONEWORDINLINE(0xA92B);

EXTERN_API( short )
FindWindow						(Point 					thePoint,
								 WindowPtr *			theWindow)							ONEWORDINLINE(0xA92C);

EXTERN_API( long )
PinRect							(const Rect *			theRect,
								 Point 					thePt)								ONEWORDINLINE(0xA94E);

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

EXTERN_API( Boolean )
TrackBox						(WindowPtr 				theWindow,
								 Point 					thePt,
								 short 					partCode)							ONEWORDINLINE(0xA83B);

EXTERN_API( Boolean )
TrackGoAway						(WindowPtr 				theWindow,
								 Point 					thePt)								ONEWORDINLINE(0xA91E);

EXTERN_API( void )
DragWindow						(WindowPtr 				theWindow,
								 Point 					startPt,
								 const Rect *			boundsRect)							ONEWORDINLINE(0xA925);

EXTERN_API( short )
GetWVariant						(WindowPtr 				theWindow)							ONEWORDINLINE(0xA80A);

EXTERN_API( Boolean )
GetAuxWin						(WindowPtr 				theWindow,
								 AuxWinHandle *			awHndl)								ONEWORDINLINE(0xAA42);

EXTERN_API( RgnHandle )
GetGrayRgn						(void)														TWOWORDINLINE(0x2EB8, 0x09EE);

/*
  _________________________________________________________________________________________________________
      
   • PROCS
  _________________________________________________________________________________________________________
*/

typedef CALLBACK_API( long , WindowDefProcPtr )(short varCode, WindowPtr theWindow, short message, long param);
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
#define CallWindowDefProc(userRoutine, varCode, theWindow, message, param)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppWindowDefProcInfo, (varCode), (theWindow), (message), (param))
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter CallDeskHookProc(__A1, __D0, __A0)
	void CallDeskHookProc(DeskHookUPP routine, Boolean mouseClick, EventRecord * theEvent) = 0x4E91;
#else
	#define CallDeskHookProc(userRoutine, mouseClick, theEvent)  CALL_TWO_PARAMETER_UPP((userRoutine), uppDeskHookProcInfo, (mouseClick), (theEvent))
#endif
/*
  _________________________________________________________________________________________________________
      
   • C GLUE
  _________________________________________________________________________________________________________
*/
#if CGLUESUPPORTED
EXTERN_API_C( void )
setwtitle						(WindowPtr 				theWindow,
								 const char *			title);

EXTERN_API_C( Boolean )
trackgoaway						(WindowPtr 				theWindow,
								 Point *				thePt);

EXTERN_API_C( short )
findwindow						(Point *				thePoint,
								 WindowPtr *			theWindow);

EXTERN_API_C( void )
getwtitle						(WindowPtr 				theWindow,
								 char *					title);

EXTERN_API_C( long )
growwindow						(WindowPtr 				theWindow,
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
trackbox						(WindowPtr 				theWindow,
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
dragwindow						(WindowPtr 				theWindow,
								 Point *				startPt,
								 const Rect *			boundsRect);

#endif  /* CGLUESUPPORTED */

/*
  _________________________________________________________________________________________________________
      
   • WindowRecord accessor macros
  _________________________________________________________________________________________________________
*/
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
	functions, without being tied to opaque data types.  We will complete and
	document the Windows and Dialogs accessor functions in an upcoming release
	of the interfaces.
*/
#ifdef __cplusplus
inline CGrafPtr	GetWindowPort(WindowPtr w) 					{ return (CGrafPtr) w; 													}
inline void		SetPortWindowPort(WindowPtr w)				{	SetPort( (GrafPtr) GetWindowPort(w)); }
inline SInt16		GetWindowKind(WindowPtr w) 					{ return ( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort))); 			}
inline void		SetWindowKind(WindowPtr	w, SInt16 wKind)	{  *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)) = wKind;  			}
inline	Boolean		IsWindowVisible(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x2); 		}
inline Boolean		IsWindowHilited(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x3);		}
inline Boolean		GetWindowGoAwayFlag(WindowPtr w)			{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x4);		}
inline Boolean		GetWindowZoomFlag(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x5);		}
inline void		GetWindowStructureRgn(WindowPtr w, RgnHandle r)	{	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0x6), r );	}
inline void		GetWindowContentRgn(WindowPtr w, RgnHandle r)	{	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xA), r );	}
inline void		GetWindowUpdateRgn(WindowPtr w, RgnHandle r)	{	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xE), r );	}
inline SInt16		GetWindowTitleWidth(WindowPtr w)				{ return *(SInt16 *)(((UInt8 *) w) + sizeof(GrafPort) + 0x1E);			}
inline WindowPtr	GetNextWindow(WindowPtr w)						{ return *(WindowPtr *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x24);		}

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
#else
#define ShowHideWindow(w)						ShowHide(w)
#define SetPortWindowPort(w)					SetPort( (GrafPtr) GetWindowPort(w) )
#define GetWindowPort(w)						( (CGrafPtr) w)
#define GetWindowKind(w)						( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)))
#define SetWindowKind(w, wKind)				( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)) = wKind )
#define IsWindowVisible(w)						( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x2))
#define IsWindowHilited(w)						( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x3))
#define GetWindowGoAwayFlag(w)					( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x4))
#define GetWindowZoomFlag(w)					( *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x5))
#define GetWindowStructureRgn(w, aRgnHandle)	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0x6), aRgnHandle )
#define GetWindowContentRgn(w, aRgnHandle)		CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xA), aRgnHandle )

#define GetWindowUpdateRgn(w, aRgnHandle)		CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xE), aRgnHandle )

#define GetWindowTitleWidth(w)					( *(SInt16 *)		(((UInt8 *) w) + sizeof(GrafPort) + 0x1E))
#define GetNextWindow(w)						( *(WindowPtr *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x24))

#define GetWindowStandardState(w, aRectPtr)	do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	*aRectPtr = stateRects[1]; } while (false)
#define SetWindowStandardState(w, aRectPtr)	do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	stateRects[1] = *aRectPtr; } while (false)
#define GetWindowUserState(w, aRectPtr)		do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	*aRectPtr = stateRects[0]; } while (false)
#define SetWindowUserState(w, aRectPtr)		do { Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	\
																if (stateRects != NULL)	stateRects[0] = *aRectPtr; } while (false)
#endif  /*  defined(__cplusplus)  */









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

