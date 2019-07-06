{
 	File:		GXMessages.p
 
 	Contains:	This file contains all of the public data structures,
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1994-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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
{$IFC TYPED_FUNCTION_POINTERS}
	MessageHandlerOverrideProcPtr = FUNCTION(arg1: LONGINT; arg2: LONGINT; arg3: LONGINT; arg4: LONGINT; arg5: LONGINT; arg6: LONGINT): OSErr; C;
{$ELSEC}
	MessageHandlerOverrideProcPtr = ProcPtr;
{$ENDC}

	MessageHandlerOverrideUPP = UniversalProcPtr;

CONST
	uppMessageHandlerOverrideProcInfo = $0003FFE1;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewMessageHandlerOverrideUPP(userRoutine: MessageHandlerOverrideProcPtr): MessageHandlerOverrideUPP; { old name was NewMessageHandlerOverrideProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeMessageHandlerOverrideUPP(userUPP: MessageHandlerOverrideUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeMessageHandlerOverrideUPP(arg1: LONGINT; arg2: LONGINT; arg3: LONGINT; arg4: LONGINT; arg5: LONGINT; arg6: LONGINT; userRoutine: MessageHandlerOverrideUPP): OSErr; { old name was CallMessageHandlerOverrideProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MessageGlobalsInitProcPtr = PROCEDURE(messageGlobals: UNIV Ptr); C;
{$ELSEC}
	MessageGlobalsInitProcPtr = ProcPtr;
{$ENDC}

	MessageGlobalsInitUPP = UniversalProcPtr;

CONST
	uppMessageGlobalsInitProcInfo = $000000C1;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewMessageGlobalsInitUPP(userRoutine: MessageGlobalsInitProcPtr): MessageGlobalsInitUPP; { old name was NewMessageGlobalsInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeMessageGlobalsInitUPP(userUPP: MessageGlobalsInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeMessageGlobalsInitUPP(messageGlobals: UNIV Ptr; userRoutine: MessageGlobalsInitUPP); { old name was CallMessageGlobalsInitProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }

TYPE
	MessageHandlerOverrideProc			= MessageHandlerOverrideProcPtr;
	MessageGlobalsInitProc				= MessageGlobalsInitProcPtr;
{$ENDC}  {OLDROUTINENAMES}


TYPE
	MessageHandler = ^LONGINT; { an opaque 32-bit type }
	MessageObject = ^LONGINT; { an opaque 32-bit type }
{

	PUBLIC INTERFACES

	Message Handler API Routines
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CountMessageHandlerInstances: LONGINT; C;
FUNCTION GetMessageHandlerClassContext: Ptr; C;
FUNCTION SetMessageHandlerClassContext(anyValue: UNIV Ptr): Ptr; C;
FUNCTION GetMessageHandlerInstanceContext: Ptr; C;
FUNCTION SetMessageHandlerInstanceContext(anyValue: UNIV Ptr): Ptr; C;
FUNCTION NewMessageGlobals(messageGlobalsSize: LONGINT; initProc: MessageGlobalsInitUPP): OSErr; C;
PROCEDURE DisposeMessageGlobals; C;

{
	Message Sending API Routines
}
{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXMessagesIncludes}

{$ENDC} {__GXMESSAGES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
