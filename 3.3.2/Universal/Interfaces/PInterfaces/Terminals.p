{
     File:       Terminals.p
 
     Contains:   Communications Toolbox Terminal tool Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1988-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
	TMFlags								= UInt32;

CONST
	selTextNormal				= $01;
	selTextBoxed				= $02;
	selGraphicsMarquee			= $04;
	selGraphicsLasso			= $08;
	tmSearchNoDiacrit			= $0100;
	tmSearchNoCase				= $0200;


TYPE
	TMSearchTypes						= UInt16;
	TMSelTypes							= INTEGER;

CONST
	cursorText					= 1;
	cursorGraphics				= 2;


TYPE
	TMCursorTypes						= UInt16;

CONST
	tmTextTerminal				= $01;
	tmGraphicsTerminal			= $02;


TYPE
	TMTermTypes							= UInt16;
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
{$IFC TYPED_FUNCTION_POINTERS}
	TerminalSendProcPtr = FUNCTION(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; flags: CMFlags): LONGINT;
{$ELSEC}
	TerminalSendProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalBreakProcPtr = PROCEDURE(duration: LONGINT; refCon: LONGINT);
{$ELSEC}
	TerminalBreakProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalCacheProcPtr = FUNCTION(refCon: LONGINT; theTermData: TermDataBlockPtr): LONGINT;
{$ELSEC}
	TerminalCacheProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalSearchCallBackProcPtr = PROCEDURE(hTerm: TermHandle; refNum: INTEGER; VAR foundRect: Rect);
{$ELSEC}
	TerminalSearchCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalClikLoopProcPtr = FUNCTION(refCon: LONGINT): BOOLEAN;
{$ELSEC}
	TerminalClikLoopProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalEnvironsProcPtr = FUNCTION(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec): CMErr;
{$ELSEC}
	TerminalEnvironsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalChooseIdleProcPtr = PROCEDURE;
{$ELSEC}
	TerminalChooseIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalToolDefProcPtr = FUNCTION(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT;
{$ELSEC}
	TerminalToolDefProcPtr = ProcPtr;
{$ENDC}

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
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewTerminalSendUPP(userRoutine: TerminalSendProcPtr): TerminalSendUPP; { old name was NewTerminalSendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalBreakUPP(userRoutine: TerminalBreakProcPtr): TerminalBreakUPP; { old name was NewTerminalBreakProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalCacheUPP(userRoutine: TerminalCacheProcPtr): TerminalCacheUPP; { old name was NewTerminalCacheProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalSearchCallBackUPP(userRoutine: TerminalSearchCallBackProcPtr): TerminalSearchCallBackUPP; { old name was NewTerminalSearchCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalClikLoopUPP(userRoutine: TerminalClikLoopProcPtr): TerminalClikLoopUPP; { old name was NewTerminalClikLoopProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalEnvironsUPP(userRoutine: TerminalEnvironsProcPtr): TerminalEnvironsUPP; { old name was NewTerminalEnvironsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalChooseIdleUPP(userRoutine: TerminalChooseIdleProcPtr): TerminalChooseIdleUPP; { old name was NewTerminalChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTerminalToolDefUPP(userRoutine: TerminalToolDefProcPtr): TerminalToolDefUPP; { old name was NewTerminalToolDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeTerminalSendUPP(userUPP: TerminalSendUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalBreakUPP(userUPP: TerminalBreakUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalCacheUPP(userUPP: TerminalCacheUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalSearchCallBackUPP(userUPP: TerminalSearchCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalClikLoopUPP(userUPP: TerminalClikLoopUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalEnvironsUPP(userUPP: TerminalEnvironsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalChooseIdleUPP(userUPP: TerminalChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTerminalToolDefUPP(userUPP: TerminalToolDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeTerminalSendUPP(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; flags: CMFlags; userRoutine: TerminalSendUPP): LONGINT; { old name was CallTerminalSendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeTerminalBreakUPP(duration: LONGINT; refCon: LONGINT; userRoutine: TerminalBreakUPP); { old name was CallTerminalBreakProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeTerminalCacheUPP(refCon: LONGINT; theTermData: TermDataBlockPtr; userRoutine: TerminalCacheUPP): LONGINT; { old name was CallTerminalCacheProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeTerminalSearchCallBackUPP(hTerm: TermHandle; refNum: INTEGER; VAR foundRect: Rect; userRoutine: TerminalSearchCallBackUPP); { old name was CallTerminalSearchCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeTerminalClikLoopUPP(refCon: LONGINT; userRoutine: TerminalClikLoopUPP): BOOLEAN; { old name was CallTerminalClikLoopProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeTerminalEnvironsUPP(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec; userRoutine: TerminalEnvironsUPP): CMErr; { old name was CallTerminalEnvironsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeTerminalChooseIdleUPP(userRoutine: TerminalChooseIdleUPP); { old name was CallTerminalChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeTerminalToolDefUPP(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: TerminalToolDefUPP): LONGINT; { old name was CallTerminalToolDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


{$IFC CALL_NOT_IN_CARBON }
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
FUNCTION TMGetProcID(name: Str255): INTEGER;
PROCEDURE TMSetRefCon(hTerm: TermHandle; refCon: LONGINT);
FUNCTION TMGetRefCon(hTerm: TermHandle): LONGINT;
PROCEDURE TMSetUserData(hTerm: TermHandle; userData: LONGINT);
FUNCTION TMGetUserData(hTerm: TermHandle): LONGINT;
FUNCTION TMAddSearch(hTerm: TermHandle; theString: Str255; {CONST}VAR where: Rect; searchType: TMSearchTypes; callBack: TerminalSearchCallBackUPP): INTEGER;
PROCEDURE TMRemoveSearch(hTerm: TermHandle; refnum: INTEGER);
PROCEDURE TMClearSearch(hTerm: TermHandle);
FUNCTION TMGetCursor(hTerm: TermHandle; cursType: TMCursorTypes): Point;
FUNCTION TMGetTermEnvirons(hTerm: TermHandle; VAR theEnvirons: TermEnvironRec): TMErr;
FUNCTION TMChoose(VAR hTerm: TermHandle; where: Point; idleProc: TerminalChooseIdleUPP): INTEGER;
PROCEDURE TMEvent(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);
FUNCTION TMDoTermKey(hTerm: TermHandle; theKey: Str255): BOOLEAN;
FUNCTION TMCountTermKeys(hTerm: TermHandle): INTEGER;
PROCEDURE TMGetIndTermKey(hTerm: TermHandle; id: INTEGER; VAR theKey: Str255);
PROCEDURE TMGetErrorString(hTerm: TermHandle; id: INTEGER; VAR errMsg: Str255);
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TerminalsIncludes}

{$ENDC} {__TERMINALS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
