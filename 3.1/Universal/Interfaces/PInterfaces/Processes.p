{
 	File:		Processes.p
 
 	Contains:	Process Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1989-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Processes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PROCESSES__}
{$SETC __PROCESSES__ := 1}

{$I+}
{$SETC ProcessesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ type for unique process identifier }

TYPE
	ProcessSerialNumberPtr = ^ProcessSerialNumber;
	ProcessSerialNumber = RECORD
		highLongOfPSN:			UInt32;
		lowLongOfPSN:			UInt32;
	END;


CONST
																{  Process identifier - Various reserved process serial numbers  }
	kNoProcess					= 0;
	kSystemProcess				= 1;
	kCurrentProcess				= 2;

{ Definition of the parameter block passed to _Launch }
{  Typedef and flags for launchControlFlags field }

TYPE
	LaunchFlags							= UInt16;

CONST
	launchContinue				= $4000;
	launchNoFileFlags			= $0800;
	launchUseMinimum			= $0400;
	launchDontSwitch			= $0200;
	launchAllow24Bit			= $0100;
	launchInhibitDaemon			= $0080;

{ Format for first AppleEvent to pass to new process.  The size of the overall
  buffer variable: the message body immediately follows the messageLength }

TYPE
	AppParametersPtr = ^AppParameters;
	AppParameters = RECORD
		theMsgEvent:			EventRecord;
		eventRefCon:			UInt32;
		messageLength:			UInt32;
	END;

{ Parameter block to _Launch }
	LaunchParamBlockRecPtr = ^LaunchParamBlockRec;
	LaunchParamBlockRec = RECORD
		reserved1:				UInt32;
		reserved2:				UInt16;
		launchBlockID:			UInt16;
		launchEPBLength:		UInt32;
		launchFileFlags:		UInt16;
		launchControlFlags:		LaunchFlags;
		launchAppSpec:			FSSpecPtr;
		launchProcessSN:		ProcessSerialNumber;
		launchPreferredSize:	UInt32;
		launchMinimumSize:		UInt32;
		launchAvailableSize:	UInt32;
		launchAppParameters:	AppParametersPtr;
	END;

	LaunchPBPtr							= ^LaunchParamBlockRec;
{ Set launchBlockID to extendedBlock to specify that extensions exist.
 Set launchEPBLength to extendedBlockLen for compatibility.}

CONST
	extendedBlock				= $4C43;						{  'LC'  }
	extendedBlockLen			= 32;

																{  Definition of the information block returned by GetProcessInformation  }
	modeLaunchDontSwitch		= $00040000;
	modeDeskAccessory			= $00020000;
	modeMultiLaunch				= $00010000;
	modeNeedSuspendResume		= $00004000;
	modeCanBackground			= $00001000;
	modeDoesActivateOnFGSwitch	= $00000800;
	modeOnlyBackground			= $00000400;
	modeGetFrontClicks			= $00000200;
	modeGetAppDiedMsg			= $00000100;
	mode32BitCompatible			= $00000080;
	modeHighLevelEventAware		= $00000040;
	modeLocalAndRemoteHLEvents	= $00000020;
	modeStationeryAware			= $00000010;
	modeUseTextEditServices		= $00000008;
	modeDisplayManagerAware		= $00000004;

{ Record returned by GetProcessInformation }

TYPE
	ProcessInfoRecPtr = ^ProcessInfoRec;
	ProcessInfoRec = RECORD
		processInfoLength:		UInt32;
		processName:			StringPtr;
		processNumber:			ProcessSerialNumber;
		processType:			UInt32;
		processSignature:		OSType;
		processMode:			UInt32;
		processLocation:		Ptr;
		processSize:			UInt32;
		processFreeMem:			UInt32;
		processLauncher:		ProcessSerialNumber;
		processLaunchDate:		UInt32;
		processActiveTime:		UInt32;
		processAppSpec:			FSSpecPtr;
	END;

FUNCTION LaunchApplication(LaunchParams: LaunchPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A9F2, $3E80;
	{$ENDC}
FUNCTION LaunchDeskAccessory({CONST}VAR pFileSpec: FSSpec; pDAName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0036, $A88F;
	{$ENDC}
FUNCTION GetCurrentProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0037, $A88F;
	{$ENDC}
FUNCTION GetFrontProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $2F00, $3F3C, $0039, $A88F;
	{$ENDC}
FUNCTION GetNextProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0038, $A88F;
	{$ENDC}
FUNCTION GetProcessInformation({CONST}VAR PSN: ProcessSerialNumber; VAR info: ProcessInfoRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003A, $A88F;
	{$ENDC}
FUNCTION SetFrontProcess({CONST}VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003B, $A88F;
	{$ENDC}
FUNCTION WakeUpProcess({CONST}VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003C, $A88F;
	{$ENDC}
FUNCTION SameProcess({CONST}VAR PSN1: ProcessSerialNumber; {CONST}VAR PSN2: ProcessSerialNumber; VAR result: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003D, $A88F;
	{$ENDC}
{$IFC NOT OLDROUTINELOCATIONS }
{
	ExitToShell was previously in SegLoad.h
}
PROCEDURE ExitToShell;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F4;
	{$ENDC}
{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ProcessesIncludes}

{$ENDC} {__PROCESSES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
