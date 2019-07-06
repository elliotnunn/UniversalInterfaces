{
 	File:		AppleEvents.p
 
 	Contains:	AppleEvent Package Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1989-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleEvents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEEVENTS__}
{$SETC __APPLEEVENTS__ := 1}

{$I+}
{$SETC AppleEventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __NOTIFICATION__}
{$I Notification.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{
	Note:	The functions and types for the building and parsing AppleEvent  
			messages has moved to AEDataModel.h
}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Keywords for Apple event parameters  }
	keyDirectObject				= '----';
	keyErrorNumber				= 'errn';
	keyErrorString				= 'errs';
	keyProcessSerialNumber		= 'psn ';						{  Keywords for special handlers  }
	keyPreDispatch				= 'phac';						{  preHandler accessor call  }
	keySelectProc				= 'selh';						{  more selector call  }
																{  Keyword for recording  }
	keyAERecorderCount			= 'recr';						{  available only in vers 1.0.1 and greater  }
																{  Keyword for version information  }
	keyAEVersion				= 'vers';						{  available only in vers 1.0.1 and greater  }

{ Event Class }
	kCoreEventClass				= 'aevt';

{ Event ID’s }
	kAEOpenApplication			= 'oapp';
	kAEOpenDocuments			= 'odoc';
	kAEPrintDocuments			= 'pdoc';
	kAEQuitApplication			= 'quit';
	kAEAnswer					= 'ansr';
	kAEApplicationDied			= 'obit';

{ Constants for recording }
	kAEStartRecording			= 'reca';						{  available only in vers 1.0.1 and greater  }
	kAEStopRecording			= 'recc';						{  available only in vers 1.0.1 and greater  }
	kAENotifyStartRecording		= 'rec1';						{  available only in vers 1.0.1 and greater  }
	kAENotifyStopRecording		= 'rec0';						{  available only in vers 1.0.1 and greater  }
	kAENotifyRecording			= 'recr';						{  available only in vers 1.0.1 and greater  }


{ parameter to AESend }

TYPE
	AESendOptions						= OptionBits;

CONST
	kAENeverInteract			= $00000010;					{  server should not interact with user  }
	kAECanInteract				= $00000020;					{  server may try to interact with user  }
	kAEAlwaysInteract			= $00000030;					{  server should always interact with user where appropriate  }
	kAECanSwitchLayer			= $00000040;					{  interaction may switch layer  }
	kAEDontRecord				= $00001000;					{  don't record this event - available only in vers 1.0.1 and greater  }
	kAEDontExecute				= $00002000;					{  don't send the event for recording - available only in vers 1.0.1 and greater  }
	kAEProcessNonReplyEvents	= $00008000;					{  allow processing of non-reply events while awaiting synchronous AppleEvent reply  }


TYPE
	AESendMode							= SInt32;

CONST
	kAENoReply					= $00000001;					{  sender doesn't want a reply to event  }
	kAEQueueReply				= $00000002;					{  sender wants a reply but won't wait  }
	kAEWaitReply				= $00000003;					{  sender wants a reply and will wait  }
	kAEDontReconnect			= $00000080;					{  don't reconnect if there is a sessClosedErr from PPCToolbox  }
	kAEWantReceipt				= $00000200;					{  (nReturnReceipt) sender wants a receipt of message  }


{ Constants for timeout durations }
	kAEDefaultTimeout			= -1;							{  timeout value determined by AEM  }
	kNoTimeOut					= -2;							{  wait until reply comes back, however long it takes  }


{ priority param of AESend }

TYPE
	AESendPriority						= SInt16;

CONST
	kAENormalPriority			= $00000000;					{  post message at the end of the event queue  }
	kAEHighPriority				= $00000001;					{  post message at the front of the event queue (same as nAttnMsg)  }



TYPE
	AEEventSource						= SInt8;

CONST
	kAEUnknownSource			= 0;
	kAEDirectCall				= 1;
	kAESameProcess				= 2;
	kAELocalProcess				= 3;
	kAERemoteProcess			= 4;




TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	AEEventHandlerProcPtr = FUNCTION({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; handlerRefcon: UInt32): OSErr;
{$ELSEC}
	AEEventHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	AEIdleProcPtr = FUNCTION(VAR theEvent: EventRecord; VAR sleepTime: LONGINT; VAR mouseRgn: RgnHandle): BOOLEAN;
{$ELSEC}
	AEIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	AEFilterProcPtr = FUNCTION(VAR theEvent: EventRecord; returnID: LONGINT; transactionID: LONGINT; {CONST}VAR sender: AEAddressDesc): BOOLEAN;
{$ELSEC}
	AEFilterProcPtr = ProcPtr;
{$ENDC}

	AEEventHandlerUPP = UniversalProcPtr;
	AEIdleUPP = UniversalProcPtr;
	AEFilterUPP = UniversalProcPtr;

CONST
	uppAEEventHandlerProcInfo = $00000FE0;
	uppAEIdleProcInfo = $00000FD0;
	uppAEFilterProcInfo = $00003FD0;

FUNCTION NewAEEventHandlerUPP(userRoutine: AEEventHandlerProcPtr): AEEventHandlerUPP; { old name was NewAEEventHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAEIdleUPP(userRoutine: AEIdleProcPtr): AEIdleUPP; { old name was NewAEIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAEFilterUPP(userRoutine: AEFilterProcPtr): AEFilterUPP; { old name was NewAEFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeAEEventHandlerUPP(userUPP: AEEventHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeAEIdleUPP(userUPP: AEIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeAEFilterUPP(userUPP: AEFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeAEEventHandlerUPP({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; handlerRefcon: UInt32; userRoutine: AEEventHandlerUPP): OSErr; { old name was CallAEEventHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeAEIdleUPP(VAR theEvent: EventRecord; VAR sleepTime: LONGINT; VAR mouseRgn: RgnHandle; userRoutine: AEIdleUPP): BOOLEAN; { old name was CallAEIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeAEFilterUPP(VAR theEvent: EventRecord; returnID: LONGINT; transactionID: LONGINT; {CONST}VAR sender: AEAddressDesc; userRoutine: AEFilterUPP): BOOLEAN; { old name was CallAEFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{*************************************************************************
  The next couple of calls are basic routines used to create, send,
  and process AppleEvents. 
*************************************************************************}
FUNCTION AESend({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D17, $A816;
	{$ENDC}
FUNCTION AEProcessAppleEvent({CONST}VAR theEventRecord: EventRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021B, $A816;
	{$ENDC}

{ 
 Note: during event processing, an event handler may realize that it is likely
 to exceed the client's timeout limit. Passing the reply to this
 routine causes a wait event to be generated that asks the client
 for more time. 
}
FUNCTION AEResetTimer({CONST}VAR reply: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0219, $A816;
	{$ENDC}

{*************************************************************************
  The following three calls are used to allow applications to behave
  courteously when a user interaction such as a dialog box is needed. 
*************************************************************************}


TYPE
	AEInteractAllowed					= SInt8;

CONST
	kAEInteractWithSelf			= 0;
	kAEInteractWithLocal		= 1;
	kAEInteractWithAll			= 2;

FUNCTION AEGetInteractionAllowed(VAR level: AEInteractAllowed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021D, $A816;
	{$ENDC}
FUNCTION AESetInteractionAllowed(level: AEInteractAllowed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $011E, $A816;
	{$ENDC}
FUNCTION AEInteractWithUser(timeOutInTicks: LONGINT; nmReqPtr: NMRecPtr; idleProc: AEIdleUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061C, $A816;
	{$ENDC}

{*************************************************************************
  These calls are used to set up and modify the event dispatch table.
*************************************************************************}
FUNCTION AEInstallEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; handler: AEEventHandlerUPP; handlerRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $091F, $A816;
	{$ENDC}
FUNCTION AERemoveEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0720, $A816;
	{$ENDC}
FUNCTION AEGetEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; VAR handler: AEEventHandlerUPP; VAR handlerRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0921, $A816;
	{$ENDC}

{*************************************************************************
 The following four calls are available for applications which need more
 sophisticated control over when and how events are processed. Applications
 which implement multi-session servers or which implement their own
 internal event queueing will probably be the major clients of these
 routines. They can be called from within a handler to prevent the AEM from
 disposing of the AppleEvent when the handler returns. They can be used to
 asynchronously process the event (as MacApp does).
*************************************************************************}
FUNCTION AESuspendTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022B, $A816;
	{$ENDC}
{ 
 Note: The following routine tells the AppleEvent manager that processing
 is either about to resume or has been completed on a previously suspended
 event. The procPtr passed in as the dispatcher parameter will be called to
 attempt to redispatch the event. Several constants for the dispatcher
 parameter allow special behavior. They are:
  	- kAEUseStandardDispatch means redispatch as if the event was just
	  received, using the standard AppleEvent dispatch mechanism.
  	- kAENoDispatch means ignore the parameter.
   	  Use this in the case where the event has been handled and no
	  redispatch is needed.
  	- non nil means call the routine which the dispatcher points to.
}
{ Constants for Refcon in AEResumeTheCurrentEvent with kAEUseStandardDispatch }

CONST
	kAEDoNotIgnoreHandler		= $00000000;
	kAEIgnoreAppPhacHandler		= $00000001;					{  available only in vers 1.0.1 and greater  }
	kAEIgnoreAppEventHandler	= $00000002;					{  available only in vers 1.0.1 and greater  }
	kAEIgnoreSysPhacHandler		= $00000004;					{  available only in vers 1.0.1 and greater  }
	kAEIgnoreSysEventHandler	= $00000008;					{  available only in vers 1.0.1 and greater  }
	kAEIngoreBuiltInEventHandler = $00000010;					{  available only in vers 1.0.1 and greater  }
	kAEDontDisposeOnResume		= $80000000;					{  available only in vers 1.0.1 and greater  }

{ Constants for AEResumeTheCurrentEvent }
	kAENoDispatch				= 0;							{  dispatch parameter to AEResumeTheCurrentEvent takes a pointer to a dispatch  }
	kAEUseStandardDispatch		= $FFFFFFFF;					{  table, or one of these two constants  }

FUNCTION AEResumeTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent; {CONST}VAR reply: AppleEvent; dispatcher: AEEventHandlerUPP; handlerRefcon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0818, $A816;
	{$ENDC}
FUNCTION AEGetTheCurrentEvent(VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021A, $A816;
	{$ENDC}
FUNCTION AESetTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $A816;
	{$ENDC}

{*************************************************************************
  These calls are used to set up and modify special hooks into the
  AppleEvent manager.
*************************************************************************}
FUNCTION AEInstallSpecialHandler(functionClass: AEKeyword; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0500, $A816;
	{$ENDC}
FUNCTION AERemoveSpecialHandler(functionClass: AEKeyword; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $A816;
	{$ENDC}
FUNCTION AEGetSpecialHandler(functionClass: AEKeyword; VAR handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $052D, $A816;
	{$ENDC}

{*************************************************************************
  This call was added in version 1.0.1. If called with the keyword
  keyAERecorderCount ('recr'), the number of recorders that are
  currently active is returned in 'result'
  (available only in vers 1.0.1 and greater).
*************************************************************************}
FUNCTION AEManagerInfo(keyWord: AEKeyword; VAR result: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0441, $A816;
	{$ENDC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleEventsIncludes}

{$ENDC} {__APPLEEVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
