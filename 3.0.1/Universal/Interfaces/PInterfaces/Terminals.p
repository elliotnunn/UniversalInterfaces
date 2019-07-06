{
 	File:		Terminals.p
 
 	Contains:	Communications Toolbox Terminal tool Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1988-1993, 1995-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Terminals;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TERMINALS__}
{$SETC __TERMINALS__ := 1}

{$I+}
{$SETC TerminalsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
{$IFC UNDEFINED __CONNECTIONS__}
{$I Connections.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	curTMVersion				= 2;							{  current Terminal Manager version  }

	curTermEnvRecVers			= 0;							{  current Terminal Manager Environment Record version  }

																{  error codes     }
	tmGenericError				= -1;
	tmNoErr						= 0;
	tmNotSent					= 1;
	tmEnvironsChanged			= 2;
	tmNotSupported				= 7;
	tmNoTools					= 8;


TYPE
	TMErr								= OSErr;

CONST
	tmInvisible					= $01;
	tmSaveBeforeClear			= $02;
	tmNoMenus					= $04;
	tmAutoScroll				= $08;
	tmConfigChanged				= $10;


TYPE
	TMFlags								= LONGINT;

CONST
	selTextNormal				= $01;
	selTextBoxed				= $02;
	selGraphicsMarquee			= $04;
	selGraphicsLasso			= $08;
	tmSearchNoDiacrit			= $0100;
	tmSearchNoCase				= $0200;


TYPE
	TMSearchTypes						= INTEGER;
	TMSelTypes							= INTEGER;

CONST
	cursorText					= 1;
	cursorGraphics				= 2;


TYPE
	TMCursorTypes						= INTEGER;

CONST
	tmTextTerminal				= $01;
	tmGraphicsTerminal			= $02;


TYPE
	TMTermTypes							= INTEGER;
	TermDataBlockPtr = ^TermDataBlock;
	TermDataBlock = RECORD
		flags:					TMTermTypes;
		theData:				Handle;
		auxData:				Handle;
		reserved:				LONGINT;
	END;

	TermDataBlockH						= ^TermDataBlockPtr;
	TermDataBlockHandle					= ^TermDataBlockPtr;
	TermEnvironRecPtr = ^TermEnvironRec;
	TermEnvironRec = RECORD
		version:				INTEGER;
		termType:				TMTermTypes;
		textRows:				INTEGER;
		textCols:				INTEGER;
		cellSize:				Point;
		graphicSize:			Rect;
		slop:					Point;
		auxSpace:				Rect;
	END;

	TermEnvironPtr						= ^TermEnvironRec;
	TMSelectionPtr = ^TMSelection;
	TMSelection = RECORD
		CASE INTEGER OF
		0: (
			selRect:			Rect;
			);
		1: (
			selRgnHandle:		RgnHandle;
			);
	END;

	TermRecordPtr = ^TermRecord;
	TermPtr								= ^TermRecord;
	TermHandle							= ^TermPtr;
	TerminalSendProcPtr = ProcPtr;  { FUNCTION TerminalSend(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; flags: CMFlags): LONGINT; }

	TerminalBreakProcPtr = ProcPtr;  { PROCEDURE TerminalBreak(duration: LONGINT; refCon: LONGINT); }

	TerminalCacheProcPtr = ProcPtr;  { FUNCTION TerminalCache(refCon: LONGINT; theTermData: TermDataBlockPtr): LONGINT; }

	TerminalSearchCallBackProcPtr = ProcPtr;  { PROCEDURE TerminalSearchCallBack(hTerm: TermHandle; refNum: INTEGER; VAR foundRect: Rect); }

	TerminalClikLoopProcPtr = ProcPtr;  { FUNCTION TerminalClikLoop(refCon: LONGINT): BOOLEAN; }

	TerminalEnvironsProcPtr = ProcPtr;  { FUNCTION TerminalEnvirons(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec): CMErr; }

	TerminalChooseIdleProcPtr = ProcPtr;  { PROCEDURE TerminalChooseIdle; }

	TerminalToolDefProcPtr = ProcPtr;  { FUNCTION TerminalToolDef(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT; }

	TerminalSendUPP = UniversalProcPtr;
	TerminalBreakUPP = UniversalProcPtr;
	TerminalCacheUPP = UniversalProcPtr;
	TerminalSearchCallBackUPP = UniversalProcPtr;
	TerminalClikLoopUPP = UniversalProcPtr;
	TerminalEnvironsUPP = UniversalProcPtr;
	TerminalChooseIdleUPP = UniversalProcPtr;
	TerminalToolDefUPP = UniversalProcPtr;
{    TMTermTypes     }
	TermRecord = RECORD
		procID:					INTEGER;
		flags:					TMFlags;
		errCode:				TMErr;
		refCon:					LONGINT;
		userData:				LONGINT;
		defProc:				TerminalToolDefUPP;
		config:					Ptr;
		oldConfig:				Ptr;
		environsProc:			TerminalEnvironsUPP;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		tmPrivate:				Ptr;
		sendProc:				TerminalSendUPP;
		breakProc:				TerminalBreakUPP;
		cacheProc:				TerminalCacheUPP;
		clikLoop:				TerminalClikLoopUPP;
		owner:					WindowPtr;
		termRect:				Rect;
		viewRect:				Rect;
		visRect:				Rect;
		lastIdle:				LONGINT;
		selection:				TMSelection;
		selType:				TMSelTypes;
		mluField:				LONGINT;
	END;


CONST
	uppTerminalSendProcInfo = $00002FF0;
	uppTerminalBreakProcInfo = $000003C0;
	uppTerminalCacheProcInfo = $000003F0;
	uppTerminalSearchCallBackProcInfo = $00000EC0;
	uppTerminalClikLoopProcInfo = $000000D0;
	uppTerminalEnvironsProcInfo = $000003E0;
	uppTerminalChooseIdleProcInfo = $00000000;
	uppTerminalToolDefProcInfo = $0000FEF0;

FUNCTION NewTerminalSendProc(userRoutine: TerminalSendProcPtr): TerminalSendUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalBreakProc(userRoutine: TerminalBreakProcPtr): TerminalBreakUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalCacheProc(userRoutine: TerminalCacheProcPtr): TerminalCacheUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalSearchCallBackProc(userRoutine: TerminalSearchCallBackProcPtr): TerminalSearchCallBackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalClikLoopProc(userRoutine: TerminalClikLoopProcPtr): TerminalClikLoopUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalEnvironsProc(userRoutine: TerminalEnvironsProcPtr): TerminalEnvironsUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalChooseIdleProc(userRoutine: TerminalChooseIdleProcPtr): TerminalChooseIdleUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalToolDefProc(userRoutine: TerminalToolDefProcPtr): TerminalToolDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallTerminalSendProc(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; flags: CMFlags; userRoutine: TerminalSendUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTerminalBreakProc(duration: LONGINT; refCon: LONGINT; userRoutine: TerminalBreakUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTerminalCacheProc(refCon: LONGINT; theTermData: TermDataBlockPtr; userRoutine: TerminalCacheUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTerminalSearchCallBackProc(hTerm: TermHandle; refNum: INTEGER; VAR foundRect: Rect; userRoutine: TerminalSearchCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTerminalClikLoopProc(refCon: LONGINT; userRoutine: TerminalClikLoopUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTerminalEnvironsProc(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec; userRoutine: TerminalEnvironsUPP): CMErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTerminalChooseIdleProc(userRoutine: TerminalChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTerminalToolDefProc(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: TerminalToolDefUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InitTM: TMErr;
FUNCTION TMGetVersion(hTerm: TermHandle): Handle;
FUNCTION TMGetTMVersion: INTEGER;
FUNCTION TMNew({CONST}VAR termRect: Rect; {CONST}VAR viewRect: Rect; flags: TMFlags; procID: INTEGER; owner: WindowPtr; sendProc: TerminalSendUPP; cacheProc: TerminalCacheUPP; breakProc: TerminalBreakUPP; clikLoop: TerminalClikLoopUPP; environsProc: TerminalEnvironsUPP; refCon: LONGINT; userData: LONGINT): TermHandle;
PROCEDURE TMDispose(hTerm: TermHandle);
PROCEDURE TMKey(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);
PROCEDURE TMUpdate(hTerm: TermHandle; visRgn: RgnHandle);
PROCEDURE TMPaint(hTerm: TermHandle; {CONST}VAR theTermData: TermDataBlock; {CONST}VAR theRect: Rect);
PROCEDURE TMActivate(hTerm: TermHandle; activate: BOOLEAN);
PROCEDURE TMResume(hTerm: TermHandle; resume: BOOLEAN);
PROCEDURE TMClick(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);
PROCEDURE TMIdle(hTerm: TermHandle);
FUNCTION TMStream(hTerm: TermHandle; theBuffer: UNIV Ptr; theLength: LONGINT; flags: CMFlags): LONGINT;
FUNCTION TMMenu(hTerm: TermHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;
PROCEDURE TMReset(hTerm: TermHandle);
PROCEDURE TMClear(hTerm: TermHandle);
PROCEDURE TMResize(hTerm: TermHandle; {CONST}VAR newViewRect: Rect);
FUNCTION TMGetSelect(hTerm: TermHandle; theData: Handle; VAR theType: ResType): LONGINT;
PROCEDURE TMGetLine(hTerm: TermHandle; lineNo: INTEGER; VAR theTermData: TermDataBlock);
PROCEDURE TMSetSelection(hTerm: TermHandle; {CONST}VAR theSelection: TMSelection; selType: TMSelTypes);
PROCEDURE TMScroll(hTerm: TermHandle; dh: INTEGER; dv: INTEGER);
FUNCTION TMValidate(hTerm: TermHandle): BOOLEAN;
PROCEDURE TMDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);
FUNCTION TMSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;
PROCEDURE TMSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR magicCookie: LONGINT);
FUNCTION TMSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;
PROCEDURE TMSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theItem: INTEGER; VAR magicCookie: LONGINT);
PROCEDURE TMSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; OKed: BOOLEAN; VAR magicCookie: LONGINT);
PROCEDURE TMSetupPostflight(procID: INTEGER);
FUNCTION TMGetConfig(hTerm: TermHandle): Ptr;
FUNCTION TMSetConfig(hTerm: TermHandle; thePtr: UNIV Ptr): INTEGER;
FUNCTION TMIntlToEnglish(hTerm: TermHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;
FUNCTION TMEnglishToIntl(hTerm: TermHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;
PROCEDURE TMGetToolName(id: INTEGER; VAR name: Str255);
FUNCTION TMGetProcID(name: ConstStr255Param): INTEGER;
PROCEDURE TMSetRefCon(hTerm: TermHandle; refCon: LONGINT);
FUNCTION TMGetRefCon(hTerm: TermHandle): LONGINT;
PROCEDURE TMSetUserData(hTerm: TermHandle; userData: LONGINT);
FUNCTION TMGetUserData(hTerm: TermHandle): LONGINT;
FUNCTION TMAddSearch(hTerm: TermHandle; theString: ConstStr255Param; {CONST}VAR where: Rect; searchType: TMSearchTypes; callBack: TerminalSearchCallBackUPP): INTEGER;
PROCEDURE TMRemoveSearch(hTerm: TermHandle; refnum: INTEGER);
PROCEDURE TMClearSearch(hTerm: TermHandle);
FUNCTION TMGetCursor(hTerm: TermHandle; cursType: TMCursorTypes): Point;
FUNCTION TMGetTermEnvirons(hTerm: TermHandle; VAR theEnvirons: TermEnvironRec): TMErr;
FUNCTION TMChoose(VAR hTerm: TermHandle; where: Point; idleProc: TerminalChooseIdleUPP): INTEGER;
PROCEDURE TMEvent(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);
FUNCTION TMDoTermKey(hTerm: TermHandle; theKey: ConstStr255Param): BOOLEAN;
FUNCTION TMCountTermKeys(hTerm: TermHandle): INTEGER;
PROCEDURE TMGetIndTermKey(hTerm: TermHandle; id: INTEGER; VAR theKey: Str255);
PROCEDURE TMGetErrorString(hTerm: TermHandle; id: INTEGER; VAR errMsg: Str255);
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TerminalsIncludes}

{$ENDC} {__TERMINALS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
