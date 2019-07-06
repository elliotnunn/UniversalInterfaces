{
 	File:		Multiprocessing.p
 
 	Contains:	Multiprocessing interfaces
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1996-1997 by Apple Computer, Inc. and © 1995-1997 DayStar Digital, Inc.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Multiprocessing;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MULTIPROCESSING__}
{$SETC __MULTIPROCESSING__ := 1}

{$I+}
{$SETC MultiprocessingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC TARGET_CPU_PPC }

CONST
	MPLibrary_MajorVersion		= 1;
	MPLibrary_MinorVersion		= 4;
	MPLibrary_Release			= 1;
	MPLibrary_DevelopmentRevision = 2;


TYPE
	MPTaskID = ^LONGINT;
	MPQueueID = ^LONGINT;
	MPSemaphoreID = ^LONGINT;
	MPCriticalRegionID = ^LONGINT;
	MPSemaphoreCount					= UInt32;
	MPTaskOptions						= UInt32;
	TaskProc = ProcPtr;  { FUNCTION TaskProc(parameter: UNIV Ptr): OSStatus; C; }

	MPRemoteProcedure = ProcPtr;  { FUNCTION MPRemoteProcedure(parameter: UNIV Ptr): Ptr; C; }

	MPPrintfHandler = ProcPtr;  { PROCEDURE MPPrintfHandler(taskID: MPTaskID; format: ConstCStringPtr; args: va_list); C; }


CONST
	kDurationImmediate			= 0;
	kDurationForever			= $7FFFFFFF;

	kMPNoID						= 0;


FUNCTION MPProcessors: UInt32; C;
FUNCTION MPCreateTask(entryPoint: TaskProc; parameter: UNIV Ptr; stackSize: ByteCount; notifyQueue: MPQueueID; terminationParameter1: UNIV Ptr; terminationParameter2: UNIV Ptr; options: MPTaskOptions; VAR task: MPTaskID): OSStatus; C;

FUNCTION MPTerminateTask(task: MPTaskID; terminationStatus: OSStatus): OSStatus; C;

PROCEDURE MPExit(status: OSStatus); C;

FUNCTION MPCurrentTaskID: MPTaskID; C;

PROCEDURE MPYield; C;

FUNCTION MPCreateQueue(VAR queue: MPQueueID): OSStatus; C;

FUNCTION MPDeleteQueue(queue: MPQueueID): OSStatus; C;

FUNCTION MPNotifyQueue(queue: MPQueueID; param1: UNIV Ptr; param2: UNIV Ptr; param3: UNIV Ptr): OSStatus; C;

FUNCTION MPWaitOnQueue(queue: MPQueueID; VAR param1: UNIV Ptr; VAR param2: UNIV Ptr; VAR param3: UNIV Ptr; timeout: Duration): OSStatus; C;

FUNCTION MPCreateSemaphore(maximumValue: MPSemaphoreCount; initialValue: MPSemaphoreCount; VAR semaphore: MPSemaphoreID): OSStatus; C;


FUNCTION MPWaitOnSemaphore(semaphore: MPSemaphoreID; timeout: Duration): OSStatus; C;

FUNCTION MPSignalSemaphore(semaphore: MPSemaphoreID): OSStatus; C;

FUNCTION MPDeleteSemaphore(semaphore: MPSemaphoreID): OSStatus; C;

FUNCTION MPCreateCriticalRegion(VAR criticalRegion: MPCriticalRegionID): OSStatus; C;

FUNCTION MPEnterCriticalRegion(criticalRegion: MPCriticalRegionID; timeout: Duration): OSStatus; C;

FUNCTION MPExitCriticalRegion(criticalRegion: MPCriticalRegionID): OSStatus; C;

FUNCTION MPDeleteCriticalRegion(criticalRegion: MPCriticalRegionID): OSStatus; C;

FUNCTION MPAllocate(size: ByteCount): LogicalAddress; C;
PROCEDURE MPFree(object: LogicalAddress); C;

PROCEDURE MPBlockCopy(sourcePtr: LogicalAddress; destPtr: LogicalAddress; blockSize: ByteCount); C;

{*************************************************************************
 *
 *	MPTaskIsToolboxSafe() and MPRPC() were functions added by DayStar. 
 *	The 1.4 MPLibrary exports the names with an underscore prefix. 
 *	To work around this, #defines have been added to automatically
 *	add the underscore.
 *
 }
{ 
	MPTaskIsToolboxSafe() allows routines which are otherwise unaware that 
	they are being called from an MP task to check to see if it is permissible
	to make a call to the Macintosh toolbox.  (It is okay to make toolbox 
	calls only if the routine is not being called from an MP task).
}
FUNCTION MPTaskIsToolboxSafe(task: MPTaskID): BOOLEAN; C;
{
	MPRPC() calls its MPRemoteProcedure parameter in the application's main 
	thread when the app next calls WaitNextEvent, EventAvail, SystemTask, 
	MPYield, MPWaitOnQueue, MPWaitOnSemaphore, or MPEnterCriticalRegion. The  
	return value of the MPRemoteProcedure is returned as the result of MPRPC.  
	The MPRemoteProcedure function can call any toolbox function except  
	SystemTask (or anything that calls it).
}
FUNCTION MPRPC(theProc: MPRemoteProcedure; parameter: UNIV Ptr): Ptr; C;


{*************************************************************************
 *
 *	The following routines were added by DayStar for debugging purposes.
 *	You should not use these in shipping products.  You can tell which
 *	functions are for debugging only because they begin with an underscore
 *
 }
FUNCTION _MPIsFullyInitialized: BOOLEAN; C;

{
	MPAllocateSys() does the same thing as MPAllocate() except the memory
	is allocated from the system heap.
}
FUNCTION _MPAllocateSys(size: ByteCount): LogicalAddress; C;

FUNCTION _MPLibraryIsCompatible(versionCString: ConstCStringPtr; major: UInt32; minor: UInt32; release: UInt32; revision: UInt32): BOOLEAN; C;
PROCEDURE _MPInitializePrintf(pfn: MPPrintfHandler); C;
PROCEDURE _MPPrintf(format: ConstCStringPtr; ...); C;

{
 	MPDebugStr() works just like DebugStr() except that it is safe
	to call it from an MP task.
}
PROCEDURE _MPDebugStr(msg: ConstStr255Param); C;
{

	MPStatusPString() and MPStatusCString() provide a way to translate an OSStatus
	value returned from one of the MP API calls into either a Pascal string or a
	C string.  Thus, if an MPLibrary function returns an error then the application
	(not a task) could use the following:

    status = MPxxx( function_params );
    DebugStr( MPStatusPString( status ) );
	
}
FUNCTION _MPStatusPString(status: OSStatus): StringPtr; C;
FUNCTION _MPStatusCString(status: OSStatus): ConstCStringPtr; C;

{$ENDC}  {TARGET_CPU_PPC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MultiprocessingIncludes}

{$ENDC} {__MULTIPROCESSING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
