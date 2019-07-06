{
 	File:		Threads.p
 
 	Contains:	Thread Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1991-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Threads;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __THREADS__}
{$SETC __THREADS__ := 1}

{$I+}
{$SETC ThreadsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  Thread states }

TYPE
	ThreadState							= UInt16;

CONST
	kReadyThreadState			= 0;
	kStoppedThreadState			= 1;
	kRunningThreadState			= 2;

{  Error codes have been meoved to Errors.(pah) }

{  Thread environment characteristics }

TYPE
	ThreadTaskRef						= Ptr;
{  Thread characteristics }
	ThreadStyle							= UInt32;

CONST
	kCooperativeThread			= $00000001;
	kPreemptiveThread			= $00000002;

{  Thread identifiers }

TYPE
	ThreadID							= UInt32;

CONST
	kNoThreadID					= 0;
	kCurrentThreadID			= 1;
	kApplicationThreadID		= 2;

{  Options when creating a thread }

TYPE
	ThreadOptions						= UInt32;

CONST
	kNewSuspend					= $01;
	kUsePremadeThread			= $02;
	kCreateIfNeeded				= $04;
	kFPUNotNeeded				= $08;
	kExactMatchThread			= $10;

{  Information supplied to the custom scheduler }

TYPE
	SchedulerInfoRecPtr = ^SchedulerInfoRec;
	SchedulerInfoRec = RECORD
		InfoRecSize:			UInt32;
		CurrentThreadID:		ThreadID;
		SuggestedThreadID:		ThreadID;
		InterruptedCoopThreadID: ThreadID;
	END;


{
	The following ProcPtrs cannot be interchanged with UniversalProcPtrs because
	of differences between 680x0 and PowerPC runtime architectures with regard to
	the implementation of the Thread Manager.
 }
	voidPtr								= Ptr;
{  Prototype for thread's entry (main) routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadEntryProcPtr = FUNCTION(threadParam: UNIV Ptr): voidPtr;
{$ELSEC}
	ThreadEntryProcPtr = ProcPtr;
{$ENDC}

{  Prototype for custom thread scheduler routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadSchedulerProcPtr = FUNCTION(schedulerInfo: SchedulerInfoRecPtr): ThreadID;
{$ELSEC}
	ThreadSchedulerProcPtr = ProcPtr;
{$ENDC}

{  Prototype for custom thread switcher routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadSwitchProcPtr = PROCEDURE(threadBeingSwitched: ThreadID; switchProcParam: UNIV Ptr);
{$ELSEC}
	ThreadSwitchProcPtr = ProcPtr;
{$ENDC}

{  Prototype for thread termination notification routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadTerminationProcPtr = PROCEDURE(threadTerminated: ThreadID; terminationProcParam: UNIV Ptr);
{$ELSEC}
	ThreadTerminationProcPtr = ProcPtr;
{$ENDC}

{  Prototype for debugger NewThread notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerNewThreadProcPtr = PROCEDURE(threadCreated: ThreadID);
{$ELSEC}
	DebuggerNewThreadProcPtr = ProcPtr;
{$ENDC}

{  Prototype for debugger DisposeThread notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerDisposeThreadProcPtr = PROCEDURE(threadDeleted: ThreadID);
{$ELSEC}
	DebuggerDisposeThreadProcPtr = ProcPtr;
{$ENDC}

{  Prototype for debugger schedule notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerThreadSchedulerProcPtr = FUNCTION(schedulerInfo: SchedulerInfoRecPtr): ThreadID;
{$ELSEC}
	DebuggerThreadSchedulerProcPtr = ProcPtr;
{$ENDC}

	ThreadEntryUPP = ^LONGINT;  { an opaque UPP }
	ThreadSchedulerUPP = ^LONGINT;  { an opaque UPP }
	ThreadSwitchUPP = ^LONGINT;  { an opaque UPP }
	ThreadTerminationUPP = ^LONGINT;  { an opaque UPP }
	DebuggerNewThreadUPP = ^LONGINT;  { an opaque UPP }
	DebuggerDisposeThreadUPP = ^LONGINT;  { an opaque UPP }
	DebuggerThreadSchedulerUPP = ^LONGINT;  { an opaque UPP }

CONST
	uppThreadEntryProcInfo = $000000F0;
	uppThreadSchedulerProcInfo = $000000F0;
	uppThreadSwitchProcInfo = $000003C0;
	uppThreadTerminationProcInfo = $000003C0;
	uppDebuggerNewThreadProcInfo = $000000C0;
	uppDebuggerDisposeThreadProcInfo = $000000C0;
	uppDebuggerThreadSchedulerProcInfo = $000000F0;

FUNCTION NewThreadEntryUPP(userRoutine: ThreadEntryProcPtr): ThreadEntryUPP; { old name was NewThreadEntryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewThreadSchedulerUPP(userRoutine: ThreadSchedulerProcPtr): ThreadSchedulerUPP; { old name was NewThreadSchedulerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewThreadSwitchUPP(userRoutine: ThreadSwitchProcPtr): ThreadSwitchUPP; { old name was NewThreadSwitchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewThreadTerminationUPP(userRoutine: ThreadTerminationProcPtr): ThreadTerminationUPP; { old name was NewThreadTerminationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDebuggerNewThreadUPP(userRoutine: DebuggerNewThreadProcPtr): DebuggerNewThreadUPP; { old name was NewDebuggerNewThreadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDebuggerDisposeThreadUPP(userRoutine: DebuggerDisposeThreadProcPtr): DebuggerDisposeThreadUPP; { old name was NewDebuggerDisposeThreadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDebuggerThreadSchedulerUPP(userRoutine: DebuggerThreadSchedulerProcPtr): DebuggerThreadSchedulerUPP; { old name was NewDebuggerThreadSchedulerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeThreadEntryUPP(userUPP: ThreadEntryUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeThreadSchedulerUPP(userUPP: ThreadSchedulerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeThreadSwitchUPP(userUPP: ThreadSwitchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeThreadTerminationUPP(userUPP: ThreadTerminationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDebuggerNewThreadUPP(userUPP: DebuggerNewThreadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDebuggerDisposeThreadUPP(userUPP: DebuggerDisposeThreadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDebuggerThreadSchedulerUPP(userUPP: DebuggerThreadSchedulerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeThreadEntryUPP(threadParam: UNIV Ptr; userRoutine: ThreadEntryUPP): voidPtr; { old name was CallThreadEntryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeThreadSchedulerUPP(schedulerInfo: SchedulerInfoRecPtr; userRoutine: ThreadSchedulerUPP): ThreadID; { old name was CallThreadSchedulerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeThreadSwitchUPP(threadBeingSwitched: ThreadID; switchProcParam: UNIV Ptr; userRoutine: ThreadSwitchUPP); { old name was CallThreadSwitchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeThreadTerminationUPP(threadTerminated: ThreadID; terminationProcParam: UNIV Ptr; userRoutine: ThreadTerminationUPP); { old name was CallThreadTerminationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeDebuggerNewThreadUPP(threadCreated: ThreadID; userRoutine: DebuggerNewThreadUPP); { old name was CallDebuggerNewThreadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeDebuggerDisposeThreadUPP(threadDeleted: ThreadID; userRoutine: DebuggerDisposeThreadUPP); { old name was CallDebuggerDisposeThreadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDebuggerThreadSchedulerUPP(schedulerInfo: SchedulerInfoRecPtr; userRoutine: DebuggerThreadSchedulerUPP): ThreadID; { old name was CallDebuggerThreadSchedulerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
   Thread Manager function pointers (TPP):
   on classic 68k use raw function pointers (same as UPP's)
   on classic PowerPC, use raw function pointers
   on CFM-68K, use UPP's
   on Carbon, use UPP's
}

{$IFC TARGET_OS_MAC AND TARGET_CPU_PPC AND NOT forCarbon AND NOT TARGET_CARBON }
{  use raw function pointers }

TYPE
	ThreadEntryTPP						= ThreadEntryProcPtr;
	ThreadSchedulerTPP					= ThreadSchedulerProcPtr;
	ThreadSwitchTPP						= ThreadSwitchProcPtr;
	ThreadTerminationTPP				= ThreadTerminationProcPtr;
	DebuggerNewThreadTPP				= DebuggerNewThreadProcPtr;
	DebuggerDisposeThreadTPP			= DebuggerDisposeThreadProcPtr;
	DebuggerThreadSchedulerTPP			= DebuggerThreadSchedulerProcPtr;
{$ELSEC}
{  use UPP's }

TYPE
	ThreadEntryTPP						= ThreadEntryUPP;
	ThreadSchedulerTPP					= ThreadSchedulerUPP;
	ThreadSwitchTPP						= ThreadSwitchUPP;
	ThreadTerminationTPP				= ThreadTerminationUPP;
	DebuggerNewThreadTPP				= DebuggerNewThreadUPP;
	DebuggerDisposeThreadTPP			= DebuggerDisposeThreadUPP;
	DebuggerThreadSchedulerTPP			= DebuggerThreadSchedulerUPP;
{$ENDC}

FUNCTION NewThread(threadStyle: ThreadStyle; threadEntry: ThreadEntryTPP; threadParam: UNIV Ptr; stackSize: Size; options: ThreadOptions; VAR threadResult: UNIV Ptr; VAR threadMade: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E03, $ABF2;
	{$ENDC}
FUNCTION SetThreadScheduler(threadScheduler: ThreadSchedulerTPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0209, $ABF2;
	{$ENDC}
FUNCTION SetThreadSwitcher(thread: ThreadID; threadSwitcher: ThreadSwitchTPP; switchProcParam: UNIV Ptr; inOrOut: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $070A, $ABF2;
	{$ENDC}
FUNCTION SetThreadTerminator(thread: ThreadID; threadTerminator: ThreadTerminationTPP; terminationProcParam: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0611, $ABF2;
	{$ENDC}
FUNCTION SetDebuggerNotificationProcs(notifyNewThread: DebuggerNewThreadTPP; notifyDisposeThread: DebuggerDisposeThreadTPP; notifyThreadScheduler: DebuggerThreadSchedulerTPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060D, $ABF2;
	{$ENDC}
FUNCTION CreateThreadPool(threadStyle: ThreadStyle; numToCreate: SInt16; stackSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $ABF2;
	{$ENDC}
FUNCTION GetFreeThreadCount(threadStyle: ThreadStyle; VAR freeCount: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0402, $ABF2;
	{$ENDC}
FUNCTION GetSpecificFreeThreadCount(threadStyle: ThreadStyle; stackSize: Size; VAR freeCount: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0615, $ABF2;
	{$ENDC}
FUNCTION GetDefaultThreadStackSize(threadStyle: ThreadStyle; VAR stackSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $ABF2;
	{$ENDC}
FUNCTION ThreadCurrentStackSpace(thread: ThreadID; VAR freeStack: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0414, $ABF2;
	{$ENDC}
FUNCTION DisposeThread(threadToDump: ThreadID; threadResult: UNIV Ptr; recycleThread: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0504, $ABF2;
	{$ENDC}
FUNCTION YieldToThread(suggestedThread: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0205, $ABF2;
	{$ENDC}
FUNCTION YieldToAnyThread: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $42A7, $303C, $0205, $ABF2;
	{$ENDC}
FUNCTION GetCurrentThread(VAR currentThreadID: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $ABF2;
	{$ENDC}
FUNCTION GetThreadState(threadToGet: ThreadID; VAR threadState: ThreadState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0407, $ABF2;
	{$ENDC}
FUNCTION SetThreadState(threadToSet: ThreadID; newState: ThreadState; suggestedThread: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0508, $ABF2;
	{$ENDC}
FUNCTION SetThreadStateEndCritical(threadToSet: ThreadID; newState: ThreadState; suggestedThread: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0512, $ABF2;
	{$ENDC}
FUNCTION ThreadBeginCritical: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $ABF2;
	{$ENDC}
FUNCTION ThreadEndCritical: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $ABF2;
	{$ENDC}
FUNCTION GetThreadCurrentTaskRef(VAR threadTRef: ThreadTaskRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020E, $ABF2;
	{$ENDC}
FUNCTION GetThreadStateGivenTaskRef(threadTRef: ThreadTaskRef; threadToGet: ThreadID; VAR threadState: ThreadState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060F, $ABF2;
	{$ENDC}
FUNCTION SetThreadReadyGivenTaskRef(threadTRef: ThreadTaskRef; threadToSet: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0410, $ABF2;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ThreadsIncludes}

{$ENDC} {__THREADS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
