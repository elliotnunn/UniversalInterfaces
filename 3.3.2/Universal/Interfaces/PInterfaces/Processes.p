{
     File:       Processes.p
 
     Contains:   Process Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1989-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
	modeReserved				= $01000000;
	modeControlPanel			= $00080000;
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

{ Record corresponding to the SIZE resource definition }
	SizeResourceRecPtr = ^SizeResourceRec;
	SizeResourceRec = RECORD
		flags:					UInt16;
		preferredHeapSize:		UInt32;
		minimumHeapSize:		UInt32;
	END;

	SizeResourceRecHandle				= ^SizeResourceRecPtr;
FUNCTION LaunchApplication(LaunchParams: LaunchPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A9F2, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION LaunchDeskAccessory({CONST}VAR pFileSpec: FSSpec; pDAName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0036, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{   ExitToShell was previously in SegLoad.h }
PROCEDURE ExitToShell;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F4;
	{$ENDC}
{
   LaunchControlPanel is similar to LaunchDeskAccessory, but for Control Panel files instead.
   It launches a control panel in an application shell maintained by the Process Manager.
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION LaunchControlPanel({CONST}VAR pFileSpec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $007B, $A88F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{ Values of the 'message' parameter to a Control Panel 'cdev' }

CONST
	initDev						= 0;							{ Time for cdev to initialize itself }
	hitDev						= 1;							{ Hit on one of my items }
	closeDev					= 2;							{ Close yourself }
	nulDev						= 3;							{ Null event }
	updateDev					= 4;							{ Update event }
	activDev					= 5;							{ Activate event }
	deactivDev					= 6;							{ Deactivate event }
	keyEvtDev					= 7;							{ Key down/auto key }
	macDev						= 8;							{ Decide whether or not to show up }
	undoDev						= 9;
	cutDev						= 10;
	copyDev						= 11;
	pasteDev					= 12;
	clearDev					= 13;
	cursorDev					= 14;

{ Special values a Control Panel 'cdev' can return }
	cdevGenErr					= -1;							{ General error; gray cdev w/o alert }
	cdevMemErr					= 0;							{ Memory shortfall; alert user please }
	cdevResErr					= 1;							{ Couldn't get a needed resource; alert }
	cdevUnset					= 3;							{  cdevValue is initialized to this }

{ Control Panel Default Proc }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlPanelDefProcPtr = FUNCTION(message: INTEGER; item: INTEGER; numItems: INTEGER; cPanelID: INTEGER; VAR theEvent: EventRecord; cdevValue: LONGINT; cpDialog: DialogPtr): LONGINT;
{$ELSEC}
	ControlPanelDefProcPtr = ProcPtr;
{$ENDC}

	ControlPanelDefUPP = UniversalProcPtr;

CONST
	uppControlPanelDefProcInfo = $000FEAB0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewControlPanelDefUPP(userRoutine: ControlPanelDefProcPtr): ControlPanelDefUPP; { old name was NewControlPanelDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeControlPanelDefUPP(userUPP: ControlPanelDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeControlPanelDefUPP(message: INTEGER; item: INTEGER; numItems: INTEGER; cPanelID: INTEGER; VAR theEvent: EventRecord; cdevValue: LONGINT; cpDialog: DialogPtr; userRoutine: ControlPanelDefUPP): LONGINT; { old name was CallControlPanelDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ProcessesIncludes}

{$ENDC} {__PROCESSES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
