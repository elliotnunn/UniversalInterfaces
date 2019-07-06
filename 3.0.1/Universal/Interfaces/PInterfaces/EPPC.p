{
 	File:		EPPC.p
 
 	Contains:	High Level Event Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1988-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT EPPC;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EPPC__}
{$SETC __EPPC__ := 1}

{$I+}
{$SETC EPPCIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __PPCTOOLBOX__}
{$I PPCToolbox.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  postOptions currently supported  }
	receiverIDMask				= $0000F000;
	receiverIDisPSN				= $00008000;
	receiverIDisSignature		= $00007000;
	receiverIDisSessionID		= $00006000;
	receiverIDisTargetID		= $00005000;
	systemOptionsMask			= $00000F00;
	nReturnReceipt				= $00000200;
	priorityMask				= $000000FF;
	nAttnMsg					= $00000001;

																{  constant for return receipts  }
	HighLevelEventMsgClass		= 'jaym';
	rtrnReceiptMsgID			= 'rtrn';

	msgWasPartiallyAccepted		= 2;
	msgWasFullyAccepted			= 1;
	msgWasNotAccepted			= 0;


TYPE
	TargetIDPtr = ^TargetID;
	TargetID = RECORD
		sessionID:				LONGINT;
		name:					PPCPortRec;
		location:				LocationNameRec;
		recvrName:				PPCPortRec;
	END;

	TargetIDHandle						= ^TargetIDPtr;
	TargetIDHdl							= TargetIDHandle;
	SenderID							= TargetID;
	SenderIDPtr 						= ^SenderID;
	HighLevelEventMsgPtr = ^HighLevelEventMsg;
	HighLevelEventMsg = RECORD
		HighLevelEventMsgHeaderLength: INTEGER;
		version:				INTEGER;
		reserved1:				LONGINT;
		theMsgEvent:			EventRecord;
		userRefcon:				LONGINT;
		postingOptions:			LONGINT;
		msgLength:				LONGINT;
	END;

	HighLevelEventMsgHandle				= ^HighLevelEventMsgPtr;
	HighLevelEventMsgHdl				= HighLevelEventMsgHandle;
	GetSpecificFilterProcPtr = ProcPtr;  { FUNCTION GetSpecificFilter(contextPtr: UNIV Ptr; msgBuff: HighLevelEventMsgPtr; (CONST)VAR sender: TargetID): BOOLEAN; }

	GetSpecificFilterUPP = UniversalProcPtr;

CONST
	uppGetSpecificFilterProcInfo = $00000FD0;

FUNCTION NewGetSpecificFilterProc(userRoutine: GetSpecificFilterProcPtr): GetSpecificFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGetSpecificFilterProc(contextPtr: UNIV Ptr; msgBuff: HighLevelEventMsgPtr; {CONST}VAR sender: TargetID; userRoutine: GetSpecificFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION PostHighLevelEvent({CONST}VAR theEvent: EventRecord; receiverID: UNIV Ptr; msgRefcon: LONGINT; msgBuff: UNIV Ptr; msgLen: LONGINT; postingOptions: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0034, $A88F;
	{$ENDC}
FUNCTION AcceptHighLevelEvent(VAR sender: TargetID; VAR msgRefcon: LONGINT; msgBuff: UNIV Ptr; VAR msgLen: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0033, $A88F;
	{$ENDC}
FUNCTION GetProcessSerialNumberFromPortName({CONST}VAR portName: PPCPortRec; VAR pPSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0035, $A88F;
	{$ENDC}
FUNCTION GetPortNameFromProcessSerialNumber(VAR portName: PPCPortRec; {CONST}VAR pPSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0046, $A88F;
	{$ENDC}
FUNCTION GetSpecificHighLevelEvent(aFilter: GetSpecificFilterUPP; contextPtr: UNIV Ptr; VAR err: OSErr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0045, $A88F;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EPPCIncludes}

{$ENDC} {__EPPC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
