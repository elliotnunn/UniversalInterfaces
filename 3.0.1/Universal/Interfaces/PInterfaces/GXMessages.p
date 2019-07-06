{
 	File:		GXMessages.p
 
 	Contains:	This file contains all of the public data structures,
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXMessages;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXMESSAGES__}
{$SETC __GXMESSAGES__ := 1}

{$I+}
{$SETC GXMessagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{

	>>>>>> CONSTANTS <<<<<<

}
{ Message Manager Trap }

CONST
	messageManagerTrap			= $ABFB;


{ Message Manager Error Result Codes }
	messageStopLoopingErr		= -5775;
	cantDeleteRunningHandlerErr	= -5776;
	noMessageTableErr			= -5777;
	dupSignatureErr				= -5778;
	messageNotReceivedErr		= -5799;


{
	DATA TYPES
}

TYPE
	MessageHandlerOverrideProcPtr = ProcPtr;  { FUNCTION MessageHandlerOverride(arg1: LONGINT; arg2: LONGINT; arg3: LONGINT; arg4: LONGINT; arg5: LONGINT; arg6: LONGINT): OSErr; C; }

	MessageHandlerOverrideUPP = UniversalProcPtr;

CONST
	uppMessageHandlerOverrideProcInfo = $0003FFE1;

FUNCTION NewMessageHandlerOverrideProc(userRoutine: MessageHandlerOverrideProcPtr): MessageHandlerOverrideUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallMessageHandlerOverrideProc(arg1: LONGINT; arg2: LONGINT; arg3: LONGINT; arg4: LONGINT; arg5: LONGINT; arg6: LONGINT; userRoutine: MessageHandlerOverrideUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

TYPE
	MessageGlobalsInitProcPtr = ProcPtr;  { PROCEDURE MessageGlobalsInit(messageGlobals: UNIV Ptr); C; }

	MessageGlobalsInitUPP = UniversalProcPtr;

CONST
	uppMessageGlobalsInitProcInfo = $000000C1;

FUNCTION NewMessageGlobalsInitProc(userRoutine: MessageGlobalsInitProcPtr): MessageGlobalsInitUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMessageGlobalsInitProc(messageGlobals: UNIV Ptr; userRoutine: MessageGlobalsInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{$IFC OLDROUTINENAMES }

TYPE
	MessageHandlerOverrideProc			= MessageHandlerOverrideProcPtr;
	MessageGlobalsInitProc				= MessageGlobalsInitProcPtr;
{$ENDC}  {OLDROUTINENAMES}


TYPE
	MessageHandler = ^LONGINT;
	MessageObject = ^LONGINT;
{

	PUBLIC INTERFACES

	Message Handler API Routines
}
FUNCTION CountMessageHandlerInstances: LONGINT; C;
FUNCTION GetMessageHandlerClassContext: Ptr; C;
FUNCTION SetMessageHandlerClassContext(anyValue: UNIV Ptr): Ptr; C;
FUNCTION GetMessageHandlerInstanceContext: Ptr; C;
FUNCTION SetMessageHandlerInstanceContext(anyValue: UNIV Ptr): Ptr; C;
FUNCTION NewMessageGlobals(messageGlobalsSize: LONGINT; initProc: MessageGlobalsInitUPP): OSErr; C;
PROCEDURE DisposeMessageGlobals; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXMessagesIncludes}

{$ENDC} {__GXMESSAGES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
