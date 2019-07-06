{
 	File:		Threads.p
 
 	Contains:	Thread Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1991-1998 by Apple Computer, Inc., all rights reserved.
 
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

{ Thread states }

TYPE
	ThreadState							= UInt16;

CONST
	kReadyThreadState			= 0;
	kStoppedThreadState			= 1;
	kRunningThreadState			= 2;

{ Error codes have been meoved to Errors.(pah) }
{ Thread environment characteristics }

TYPE
	ThreadTaskRef						= Ptr;
{ Thread characteristics }
	ThreadStyle							= UInt32;

CONST
	kCooperativeThread			= $00000001;
	kPreemptiveThread			= $00000002;

{ Thread identifiers }

TYPE
	ThreadID							= UInt32;

CONST
	kNoThreadID					= 0;
	kCurrentThreadID			= 1;
	kApplicationThreadID		= 2;

{ Options when creating a thread }

TYPE
	ThreadOptions						= UInt32;

CONST
	kNewSuspend					= $01;
	kUsePremadeThread			= $02;
	kCreateIfNeeded				= $04;
	kFPUNotNeeded				= $08;
	kExactMatchThread			= $10;

{ Information supplied to the custom scheduler }

TYPE
	SchedulerInfoRecPtr = ^SchedulerInfoRec;
	SchedulerInfoRec = RECORD
		InfoRecSize:			UInt32;
		CurrentThreadID:		ThreadID;
		SuggestedThreadID:		ThreadID;
		InterruptedCoopThreadID: ThreadID;
	END;


{$IFC TARGET_CPU_68K AND TARGET_RT_MAC_CFM }
{
	The following UniversalProcPtrs are for CFM-68k compatiblity with
	the implementation of the Thread Manager.
}
	ThreadEntryProcPtr					= UniversalProcPtr;
	ThreadSchedulerProcPtr				= UniversalProcPtr;
	ThreadSwitchProcPtr					= UniversalProcPtr;
	ThreadTerminationProcPtr			= UniversalProcPtr;
	DebuggerNewThreadProcPtr			= UniversalProcPtr;
	DebuggerDisposeThreadProcPtr		= UniversalProcPtr;
	DebuggerThreadSchedulerProcPtr		= UniversalProcPtr;
{$ELSEC}
{
	The following ProcPtrs cannot be interchanged with UniversalProcPtrs because
	of differences between 680x0 and PowerPC runtime architectures with regard to
	the implementation of the Thread Manager.
 }
{ Prototype for thread's entry (main) routine }
	voidPtr								= Ptr;
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadEntryProcPtr = FUNCTION(threadParam: UNIV Ptr): voidPtr;
{$ELSEC}
	ThreadEntryProcPtr = ProcPtr;
{$ENDC}

{ Prototype for custom thread scheduler routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadSchedulerProcPtr = FUNCTION(schedulerInfo: SchedulerInfoRecPtr): ThreadID;
{$ELSEC}
	ThreadSchedulerProcPtr = ProcPtr;
{$ENDC}

{ Prototype for custom thread switcher routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadSwitchProcPtr = PROCEDURE(threadBeingSwitched: ThreadID; switchProcParam: UNIV Ptr);
{$ELSEC}
	ThreadSwitchProcPtr = ProcPtr;
{$ENDC}

{ Prototype for thread termination notification routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadTerminationProcPtr = PROCEDURE(threadTerminated: ThreadID; terminationProcParam: UNIV Ptr);
{$ELSEC}
	ThreadTerminationProcPtr = ProcPtr;
{$ENDC}

{ Prototype for debugger NewThread notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerNewThreadProcPtr = PROCEDURE(threadCreated: ThreadID);
{$ELSEC}
	DebuggerNewThreadProcPtr = ProcPtr;
{$ENDC}

{ Prototype for debugger DisposeThread notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerDisposeThreadProcPtr = PROCEDURE(threadDeleted: ThreadID);
{$ELSEC}
	DebuggerDisposeThreadProcPtr = ProcPtr;
{$ENDC}

{ Prototype for debugger schedule notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerThreadSchedulerProcPtr = FUNCTION(schedulerInfo: SchedulerInfoRecPtr): ThreadID;
{$ELSEC}
	DebuggerThreadSchedulerProcPtr = ProcPtr;
{$ENDC}

{$ENDC}


{ Thread Manager routines }
FUNCTION CreateThreadPool(threadStyle: ThreadStyle; numToCreate: INTEGER; stackSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $ABF2;
	{$ENDC}
FUNCTION GetFreeThreadCount(threadStyle: ThreadStyle; VAR freeCount: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0402, $ABF2;
	{$ENDC}
FUNCTION GetSpecificFreeThreadCount(threadStyle: ThreadStyle; stackSize: Size; VAR freeCount: INTEGER): OSErr;
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
FUNCTION NewThread(threadStyle: ThreadStyle; threadEntry: ThreadEntryProcPtr; threadParam: UNIV Ptr; stackSize: Size; options: ThreadOptions; VAR threadResult: UNIV Ptr; VAR threadMade: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E03, $ABF2;
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
FUNCTION SetThreadScheduler(threadScheduler: ThreadSchedulerProcPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0209, $ABF2;
	{$ENDC}
FUNCTION SetThreadSwitcher(thread: ThreadID; threadSwitcher: ThreadSwitchProcPtr; switchProcParam: UNIV Ptr; inOrOut: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $070A, $ABF2;
	{$ENDC}
FUNCTION SetThreadTerminator(thread: ThreadID; threadTerminator: ThreadTerminationProcPtr; terminationProcParam: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0611, $ABF2;
	{$ENDC}
FUNCTION ThreadBeginCritical: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $ABF2;
	{$ENDC}
FUNCTION ThreadEndCritical: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $ABF2;
	{$ENDC}
FUNCTION SetDebuggerNotificationProcs(notifyNewThread: DebuggerNewThreadProcPtr; notifyDisposeThread: DebuggerDisposeThreadProcPtr; notifyThreadScheduler: DebuggerThreadSchedulerProcPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060D, $ABF2;
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
