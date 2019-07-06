{
 	File:		Connections.p
 
 	Contains:	Communications Toolbox Connection Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1988-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Connections;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONNECTIONS__}
{$SETC __CONNECTIONS__ := 1}

{$I+}
{$SETC ConnectionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	curCMVersion				= 2;							{  current Connection Manager version }

	curConnEnvRecVers			= 0;							{ 	current Connection Manager Environment Record version }

																{  CMErr  }
	cmGenericError				= -1;
	cmNoErr						= 0;
	cmRejected					= 1;
	cmFailed					= 2;
	cmTimeOut					= 3;
	cmNotOpen					= 4;
	cmNotClosed					= 5;
	cmNoRequestPending			= 6;
	cmNotSupported				= 7;
	cmNoTools					= 8;
	cmUserCancel				= 9;
	cmUnknownError				= 11;


TYPE
	CMErr								= OSErr;


CONST
	cmData						= $00000001;
	cmCntl						= $00000002;
	cmAttn						= $00000004;
	cmDataNoTimeout				= $00000010;
	cmCntlNoTimeout				= $00000020;
	cmAttnNoTimeout				= $00000040;
	cmDataClean					= $00000100;
	cmCntlClean					= $00000200;
	cmAttnClean					= $00000400;					{ 		Only for CMRecFlags (not CMChannel) in the rest of this enum	 }
	cmNoMenus					= $00010000;
	cmQuiet						= $00020000;
	cmConfigChanged				= $00040000;

{ CMRecFlags and CMChannel		}
{		Low word of CMRecFlags is same as CMChannel	}

TYPE
	CMRecFlags							= LONGINT;
	CMChannel							= INTEGER;



CONST
	cmStatusOpening				= $00000001;
	cmStatusOpen				= $00000002;
	cmStatusClosing				= $00000004;
	cmStatusDataAvail			= $00000008;
	cmStatusCntlAvail			= $00000010;
	cmStatusAttnAvail			= $00000020;
	cmStatusDRPend				= $00000040;					{  data read pending	 }
	cmStatusDWPend				= $00000080;					{  data write pending	 }
	cmStatusCRPend				= $00000100;					{  cntl read pending	 }
	cmStatusCWPend				= $00000200;					{  cntl write pending	 }
	cmStatusARPend				= $00000400;					{  attn read pending	 }
	cmStatusAWPend				= $00000800;					{  attn write pending	 }
	cmStatusBreakPend			= $00001000;
	cmStatusListenPend			= $00002000;
	cmStatusIncomingCallPresent	= $00004000;
	cmStatusReserved0			= $00008000;


TYPE
	CMStatFlags							= UInt32;

CONST
	cmDataIn					= 0;
	cmDataOut					= 1;
	cmCntlIn					= 2;
	cmCntlOut					= 3;
	cmAttnIn					= 4;
	cmAttnOut					= 5;
	cmRsrvIn					= 6;
	cmRsrvOut					= 7;


TYPE
	CMBufFields							= UInt16;
	CMBuffers							= ARRAY [0..7] OF Ptr;
	CMBufferSizes						= ARRAY [0..7] OF LONGINT;

CONST
	cmSearchSevenBit			= $00000001;


TYPE
	CMSearchFlags						= UInt16;

CONST
	cmFlagsEOM					= $00000001;


TYPE
	CMFlags								= UInt16;
	ConnEnvironRecPtr = ^ConnEnvironRec;
	ConnEnvironRec = RECORD
		version:				INTEGER;
		baudRate:				LONGINT;
		dataBits:				INTEGER;
		channels:				CMChannel;
		swFlowControl:			BOOLEAN;
		hwFlowControl:			BOOLEAN;
		flags:					CMFlags;
	END;

	ConnRecordPtr = ^ConnRecord;
	ConnPtr								= ^ConnRecord;
	ConnHandle							= ^ConnPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionToolDefProcPtr = FUNCTION(hConn: ConnHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT;
{$ELSEC}
	ConnectionToolDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionSearchCallBackProcPtr = PROCEDURE(hConn: ConnHandle; matchPtr: Ptr; refNum: LONGINT);
{$ELSEC}
	ConnectionSearchCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionCompletionProcPtr = PROCEDURE(hConn: ConnHandle);
{$ELSEC}
	ConnectionCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionChooseIdleProcPtr = PROCEDURE;
{$ELSEC}
	ConnectionChooseIdleProcPtr = ProcPtr;
{$ENDC}

	ConnectionToolDefUPP = UniversalProcPtr;
	ConnectionSearchCallBackUPP = UniversalProcPtr;
	ConnectionCompletionUPP = UniversalProcPtr;
	ConnectionChooseIdleUPP = UniversalProcPtr;
	ConnRecord = RECORD
		procID:					INTEGER;
		flags:					CMRecFlags;
		errCode:				CMErr;
		refCon:					LONGINT;
		userData:				LONGINT;
		defProc:				ConnectionToolDefUPP;
		config:					Ptr;
		oldConfig:				Ptr;
		asyncEOM:				LONGINT;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		cmPrivate:				Ptr;
		bufferArray:			CMBuffers;
		bufSizes:				CMBufferSizes;
		mluField:				LONGINT;
		asyncCount:				CMBufferSizes;
	END;


CONST
																{  CMIOPB constants and structure  }
	cmIOPBQType					= 10;
	cmIOPBversion				= 0;


TYPE
	CMIOPBPtr = ^CMIOPB;
	CMIOPB = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;								{  cmIOPBQType  }
		hConn:					ConnHandle;
		theBuffer:				Ptr;
		count:					LONGINT;
		flags:					CMFlags;
		userCompletion:			ConnectionCompletionUPP;
		timeout:				LONGINT;
		errCode:				CMErr;
		channel:				CMChannel;
		asyncEOM:				LONGINT;
		reserved1:				LONGINT;
		reserved2:				INTEGER;
		version:				INTEGER;								{  cmIOPBversion  }
		refCon:					LONGINT;								{  for application  }
		toolData1:				LONGINT;								{  for tool  }
		toolData2:				LONGINT;								{  for tool  }
	END;


CONST
	uppConnectionToolDefProcInfo = $0000FEF0;
	uppConnectionSearchCallBackProcInfo = $00000FC0;
	uppConnectionCompletionProcInfo = $000000C0;
	uppConnectionChooseIdleProcInfo = $00000000;

FUNCTION CallConnectionToolDefProc(hConn: ConnHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: ConnectionToolDefUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallConnectionSearchCallBackProc(hConn: ConnHandle; matchPtr: Ptr; refNum: LONGINT; userRoutine: ConnectionSearchCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallConnectionCompletionProc(hConn: ConnHandle; userRoutine: ConnectionCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallConnectionChooseIdleProc(userRoutine: ConnectionChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewConnectionToolDefProc(userRoutine: ConnectionToolDefProcPtr): ConnectionToolDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewConnectionSearchCallBackProc(userRoutine: ConnectionSearchCallBackProcPtr): ConnectionSearchCallBackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewConnectionCompletionProc(userRoutine: ConnectionCompletionProcPtr): ConnectionCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewConnectionChooseIdleProc(userRoutine: ConnectionChooseIdleProcPtr): ConnectionChooseIdleUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}


FUNCTION InitCM: CMErr;
FUNCTION CMGetVersion(hConn: ConnHandle): Handle;
FUNCTION CMGetCMVersion: INTEGER;
FUNCTION CMNew(procID: INTEGER; flags: CMRecFlags; VAR desiredSizes: CMBufferSizes; refCon: LONGINT; userData: LONGINT): ConnHandle;
PROCEDURE CMDispose(hConn: ConnHandle);
FUNCTION CMListen(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT): CMErr;
FUNCTION CMAccept(hConn: ConnHandle; accept: BOOLEAN): CMErr;
FUNCTION CMOpen(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT): CMErr;
FUNCTION CMClose(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; now: BOOLEAN): CMErr;
FUNCTION CMAbort(hConn: ConnHandle): CMErr;
FUNCTION CMStatus(hConn: ConnHandle; VAR sizes: CMBufferSizes; VAR flags: CMStatFlags): CMErr;
PROCEDURE CMIdle(hConn: ConnHandle);
PROCEDURE CMReset(hConn: ConnHandle);
PROCEDURE CMBreak(hConn: ConnHandle; duration: LONGINT; async: BOOLEAN; completor: ConnectionCompletionUPP);
FUNCTION CMRead(hConn: ConnHandle; theBuffer: UNIV Ptr; VAR toRead: LONGINT; theChannel: CMChannel; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; VAR flags: CMFlags): CMErr;
FUNCTION CMWrite(hConn: ConnHandle; theBuffer: UNIV Ptr; VAR toWrite: LONGINT; theChannel: CMChannel; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; flags: CMFlags): CMErr;
FUNCTION CMIOKill(hConn: ConnHandle; which: INTEGER): CMErr;
PROCEDURE CMActivate(hConn: ConnHandle; activate: BOOLEAN);
PROCEDURE CMResume(hConn: ConnHandle; resume: BOOLEAN);
FUNCTION CMMenu(hConn: ConnHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;
FUNCTION CMValidate(hConn: ConnHandle): BOOLEAN;
PROCEDURE CMDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);
FUNCTION CMSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;
FUNCTION CMSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;
PROCEDURE CMSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR magicCookie: LONGINT);
PROCEDURE CMSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theItem: INTEGER; VAR magicCookie: LONGINT);
PROCEDURE CMSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; OKed: BOOLEAN; VAR magicCookie: LONGINT);
PROCEDURE CMSetupPostflight(procID: INTEGER);
FUNCTION CMGetConfig(hConn: ConnHandle): Ptr;
FUNCTION CMSetConfig(hConn: ConnHandle; thePtr: UNIV Ptr): INTEGER;
FUNCTION CMIntlToEnglish(hConn: ConnHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;
FUNCTION CMEnglishToIntl(hConn: ConnHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;
FUNCTION CMAddSearch(hConn: ConnHandle; theString: Str255; flags: CMSearchFlags; callBack: ConnectionSearchCallBackUPP): LONGINT;
PROCEDURE CMRemoveSearch(hConn: ConnHandle; refnum: LONGINT);
PROCEDURE CMClearSearch(hConn: ConnHandle);
FUNCTION CMGetConnEnvirons(hConn: ConnHandle; VAR theEnvirons: ConnEnvironRec): CMErr;
FUNCTION CMChoose(VAR hConn: ConnHandle; where: Point; idle: ConnectionChooseIdleUPP): INTEGER;
PROCEDURE CMEvent(hConn: ConnHandle; {CONST}VAR theEvent: EventRecord);
PROCEDURE CMGetToolName(procID: INTEGER; VAR name: Str255);
FUNCTION CMGetProcID(name: Str255): INTEGER;
PROCEDURE CMSetRefCon(hConn: ConnHandle; refCon: LONGINT);
FUNCTION CMGetRefCon(hConn: ConnHandle): LONGINT;
FUNCTION CMGetUserData(hConn: ConnHandle): LONGINT;
PROCEDURE CMSetUserData(hConn: ConnHandle; userData: LONGINT);
PROCEDURE CMGetErrorString(hConn: ConnHandle; id: INTEGER; VAR errMsg: Str255);
FUNCTION CMNewIOPB(hConn: ConnHandle; VAR theIOPB: CMIOPBPtr): CMErr;
FUNCTION CMDisposeIOPB(hConn: ConnHandle; theIOPB: CMIOPBPtr): CMErr;
FUNCTION CMPBRead(hConn: ConnHandle; theIOPB: CMIOPBPtr; async: BOOLEAN): CMErr;
FUNCTION CMPBWrite(hConn: ConnHandle; theIOPB: CMIOPBPtr; async: BOOLEAN): CMErr;
FUNCTION CMPBIOKill(hConn: ConnHandle; theIOPB: CMIOPBPtr): CMErr;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ConnectionsIncludes}

{$ENDC} {__CONNECTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
