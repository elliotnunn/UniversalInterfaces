{
 	File:		MacWindows.p
 
 	Contains:	Window Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
  _________________________________________________________________________________________________________
      
   • WINDOW DEFINITION TYPE
  _________________________________________________________________________________________________________
}

CONST
	kWindowDefProcType			= 'WDEF';

{
  _________________________________________________________________________________________________________
      
   • WINDOW DEFINITION ID'S
  _________________________________________________________________________________________________________
}

	kStandardWindowDefinition	= 0;							{  for document windows and dialogs }
	kRoundWindowDefinition		= 1;							{  old da-style window }
	kFloatingWindowDefinition	= 124;							{  for floating windows }

{
  _________________________________________________________________________________________________________
      
   • VARIANT CODES
  _________________________________________________________________________________________________________
}

																{  for use with kStandardWindowDefinition  }
	kDocumentWindowVariantCode	= 0;
	kModalDialogVariantCode		= 1;
	kPlainDialogVariantCode		= 2;
	kShadowDialogVariantCode	= 3;
	kMovableModalDialogVariantCode = 5;
	kAlertVariantCode			= 7;
	kMovableAlertVariantCode	= 9;							{  for use with kFloatingWindowDefinition  }
	kSideFloaterVariantCode		= 8;

{
  _________________________________________________________________________________________________________
      
   • PROC-ID'S
  _________________________________________________________________________________________________________
}

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

{
  _________________________________________________________________________________________________________
      
   • STANDARD WINDOW KINDS
  _________________________________________________________________________________________________________
}

	dialogKind					= 2;
	userKind					= 8;
	kDialogWindowKind			= 2;
	kApplicationWindowKind		= 8;


{
  _________________________________________________________________________________________________________
      
   • FIND WINDOW RESULT CODES
  _________________________________________________________________________________________________________
}

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

	wDraw						= 0;
	wHit						= 1;
	wCalcRgns					= 2;
	wNew						= 3;
	wDispose					= 4;
	wGrow						= 5;
	wDrawGIcon					= 6;

	deskPatID					= 16;

{
  _________________________________________________________________________________________________________
      
   • WINDOW DEFINITION HIT TEST RESULT CODES ("WINDOW PART")
  _________________________________________________________________________________________________________
}

	wNoHit						= 0;
	wInContent					= 1;
	wInDrag						= 2;
	wInGrow						= 3;
	wInGoAway					= 4;
	wInZoomIn					= 5;
	wInZoomOut					= 6;

{
  _________________________________________________________________________________________________________
      
   • WINDOW COLOR PART CODES
  _________________________________________________________________________________________________________
}

	wContentColor				= 0;
	wFrameColor					= 1;
	wTextColor					= 2;
	wHiliteColor				= 3;
	wTitleBarColor				= 4;

{
  _________________________________________________________________________________________________________
   • WINDOW COLOR TABLE STRUCTURE
  _________________________________________________________________________________________________________
}


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
{
  _________________________________________________________________________________________________________
   • WINDOWRECORD
  _________________________________________________________________________________________________________
}
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
		controlList:			ControlHandle;
		nextWindow:				WindowPeek;
		windowPic:				PicHandle;
		refCon:					LONGINT;
	END;

{
  _________________________________________________________________________________________________________
   • CWINDOWRECORD
  _________________________________________________________________________________________________________
}
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
		controlList:			ControlHandle;
		nextWindow:				CWindowPeek;
		windowPic:				PicHandle;
		refCon:					LONGINT;
	END;

{
  _________________________________________________________________________________________________________
   • AUXWINDHANDLE
  _________________________________________________________________________________________________________
}
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

{
  _________________________________________________________________________________________________________
   • WSTATEHANDLE
  _________________________________________________________________________________________________________
}
	WStateDataPtr = ^WStateData;
	WStateData = RECORD
		userState:				Rect;									{ user state }
		stdState:				Rect;									{ standard state }
	END;

	WStateDataHandle					= ^WStateDataPtr;
{
  _________________________________________________________________________________________________________
      
   • API
  _________________________________________________________________________________________________________
}
PROCEDURE InitWindows;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A912;
	{$ENDC}
FUNCTION NewWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A913;
	{$ENDC}
FUNCTION GetNewWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowPtr): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BD;
	{$ENDC}
FUNCTION NewCWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; procID: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA45;
	{$ENDC}
PROCEDURE DisposeWindow(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A914;
	{$ENDC}
PROCEDURE CloseWindow(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92D;
	{$ENDC}
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
FUNCTION CheckUpdate(VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A911;
	{$ENDC}
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
PROCEDURE SetWinColor(theWindow: WindowPtr; newColorTable: WCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA41;
	{$ENDC}
PROCEDURE SetDeskCPat(deskPixPat: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA47;
	{$ENDC}
FUNCTION GetNewCWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowPtr): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA46;
	{$ENDC}
PROCEDURE SetWTitle(theWindow: WindowPtr; title: ConstStr255Param);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91A;
	{$ENDC}
PROCEDURE GetWTitle(theWindow: WindowPtr; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A919;
	{$ENDC}
PROCEDURE GetWMgrPort(VAR wPort: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A910;
	{$ENDC}
PROCEDURE GetCWMgrPort(VAR wMgrCPort: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA48;
	{$ENDC}
PROCEDURE SetWRefCon(theWindow: WindowPtr; data: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A918;
	{$ENDC}
FUNCTION GetWRefCon(theWindow: WindowPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A917;
	{$ENDC}
PROCEDURE SelectWindow(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91F;
	{$ENDC}
PROCEDURE HideWindow(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A916;
	{$ENDC}
PROCEDURE ShowWindow(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A915;
	{$ENDC}
PROCEDURE ShowHide(theWindow: WindowPtr; showFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A908;
	{$ENDC}
PROCEDURE HiliteWindow(theWindow: WindowPtr; fHilite: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91C;
	{$ENDC}
PROCEDURE BringToFront(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A920;
	{$ENDC}
PROCEDURE SendBehind(theWindow: WindowPtr; behindWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A921;
	{$ENDC}
FUNCTION FrontWindow: WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A924;
	{$ENDC}
PROCEDURE DrawGrowIcon(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A904;
	{$ENDC}
PROCEDURE MoveWindow(theWindow: WindowPtr; hGlobal: INTEGER; vGlobal: INTEGER; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91B;
	{$ENDC}
PROCEDURE SizeWindow(theWindow: WindowPtr; w: INTEGER; h: INTEGER; fUpdate: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91D;
	{$ENDC}
PROCEDURE ZoomWindow(theWindow: WindowPtr; partCode: INTEGER; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83A;
	{$ENDC}
PROCEDURE BeginUpdate(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A922;
	{$ENDC}
PROCEDURE EndUpdate(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A923;
	{$ENDC}
PROCEDURE SetWindowPic(theWindow: WindowPtr; pic: PicHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92E;
	{$ENDC}
FUNCTION GetWindowPic(theWindow: WindowPtr): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92F;
	{$ENDC}
FUNCTION GrowWindow(theWindow: WindowPtr; startPt: Point; {CONST}VAR bBox: Rect): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92B;
	{$ENDC}
FUNCTION FindWindow(thePoint: Point; VAR theWindow: WindowPtr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92C;
	{$ENDC}
FUNCTION PinRect({CONST}VAR theRect: Rect; thePt: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94E;
	{$ENDC}
FUNCTION DragGrayRgn(theRgn: RgnHandle; startPt: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: INTEGER; actionProc: DragGrayRgnUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A905;
	{$ENDC}
FUNCTION DragTheRgn(theRgn: RgnHandle; startPt: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: INTEGER; actionProc: DragGrayRgnUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A926;
	{$ENDC}
FUNCTION TrackBox(theWindow: WindowPtr; thePt: Point; partCode: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83B;
	{$ENDC}
FUNCTION TrackGoAway(theWindow: WindowPtr; thePt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91E;
	{$ENDC}
PROCEDURE DragWindow(theWindow: WindowPtr; startPt: Point; {CONST}VAR boundsRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A925;
	{$ENDC}
FUNCTION GetWVariant(theWindow: WindowPtr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80A;
	{$ENDC}
FUNCTION GetAuxWin(theWindow: WindowPtr; VAR awHndl: AuxWinHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA42;
	{$ENDC}
FUNCTION GetGrayRgn: RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $09EE;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • PROCS
  _________________________________________________________________________________________________________
}


TYPE
	WindowDefProcPtr = ProcPtr;  { FUNCTION WindowDef(varCode: INTEGER; theWindow: WindowPtr; message: INTEGER; param: LONGINT): LONGINT; }

	DeskHookProcPtr = Register68kProcPtr;  { PROCEDURE DeskHook(mouseClick: BOOLEAN; VAR theEvent: EventRecord); }

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

FUNCTION CallWindowDefProc(varCode: INTEGER; theWindow: WindowPtr; message: INTEGER; param: LONGINT; userRoutine: WindowDefUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDeskHookProc(mouseClick: BOOLEAN; VAR theEvent: EventRecord; userRoutine: DeskHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • C GLUE
  _________________________________________________________________________________________________________
}
{
  _________________________________________________________________________________________________________
      
   • WindowRecord accessor macros
  _________________________________________________________________________________________________________
}
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
	functions, without being tied to opaque data types.  We will complete and
	document the Windows and Dialogs accessor functions in an upcoming release
	of the interfaces.
}







{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacWindowsIncludes}

{$ENDC} {__MACWINDOWS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
