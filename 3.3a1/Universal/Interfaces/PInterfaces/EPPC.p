{
 	File:		EPPC.p
 
 	Contains:	High Level Event Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1988-1999, 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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
		HighLevelEventMsgHeaderLength: UInt16;
		version:				UInt16;
		reserved1:				UInt32;
		theMsgEvent:			EventRecord;
		userRefcon:				UInt32;
		postingOptions:			UInt32;
		msgLength:				UInt32;
	END;

	HighLevelEventMsgHandle				= ^HighLevelEventMsgPtr;
	HighLevelEventMsgHdl				= HighLevelEventMsgHandle;
{$IFC TYPED_FUNCTION_POINTERS}
	GetSpecificFilterProcPtr = FUNCTION(contextPtr: UNIV Ptr; msgBuff: HighLevelEventMsgPtr; {CONST}VAR sender: TargetID): BOOLEAN;
{$ELSEC}
	GetSpecificFilterProcPtr = ProcPtr;
{$ENDC}

	GetSpecificFilterUPP = UniversalProcPtr;

CONST
	uppGetSpecificFilterProcInfo = $00000FD0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewGetSpecificFilterUPP(userRoutine: GetSpecificFilterProcPtr): GetSpecificFilterUPP; { old name was NewGetSpecificFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeGetSpecificFilterUPP(userUPP: GetSpecificFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeGetSpecificFilterUPP(contextPtr: UNIV Ptr; msgBuff: HighLevelEventMsgPtr; {CONST}VAR sender: TargetID; userRoutine: GetSpecificFilterUPP): BOOLEAN; { old name was CallGetSpecificFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION PostHighLevelEvent({CONST}VAR theEvent: EventRecord; receiverID: UNIV Ptr; msgRefcon: UInt32; msgBuff: UNIV Ptr; msgLen: UInt32; postingOptions: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0034, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION AcceptHighLevelEvent(VAR sender: TargetID; VAR msgRefcon: UInt32; msgBuff: UNIV Ptr; VAR msgLen: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0033, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetProcessSerialNumberFromPortName({CONST}VAR portName: PPCPortRec; VAR pPSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0035, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetPortNameFromProcessSerialNumber(VAR portName: PPCPortRec; {CONST}VAR pPSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0046, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetSpecificHighLevelEvent(aFilter: GetSpecificFilterUPP; contextPtr: UNIV Ptr; VAR err: OSErr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0045, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EPPCIncludes}

{$ENDC} {__EPPC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
