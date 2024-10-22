{
 	File:		Devices.p
 
 	Contains:	Device Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1985-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Devices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DEVICES__}
{$SETC __DEVICES__ := 1}

{$I+}
{$SETC DevicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __DRIVERFAMILYMATCHING__}
{$I DriverFamilyMatching.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Values of the 'message' parameter to a Chooser device package }

CONST
	chooserInitMsg				= 11;							{  the user selected this device package  }
	newSelMsg					= 12;							{  the user made new device selections  }
	fillListMsg					= 13;							{  fill the device list with choices  }
	getSelMsg					= 14;							{  mark one or more choices as selected  }
	selectMsg					= 15;							{  the user made a selection  }
	deselectMsg					= 16;							{  the user canceled a selection  }
	terminateMsg				= 17;							{  allows device package to clean up  }
	buttonMsg					= 19;							{  the user selected a button  }


{ Values of the 'caller' parameter to a Chooser device package }
	chooserID					= 1;


{ Values of the 'message' parameter to a Monitor 'mntr' }
	initMsg						= 1;							{ initialization }
	okMsg						= 2;							{ user clicked OK button }
	cancelMsg					= 3;							{ user clicked Cancel button }
	hitMsg						= 4;							{ user clicked control in Options dialog }
	nulMsg						= 5;							{ periodic event }
	updateMsg					= 6;							{ update event }
	activateMsg					= 7;							{ not used }
	deactivateMsg				= 8;							{ not used }
	keyEvtMsg					= 9;							{ keyboard event }
	superMsg					= 10;							{ show superuser controls }
	normalMsg					= 11;							{ show only normal controls }
	startupMsg					= 12;							{ code has been loaded }


{ control codes for DeskAccessories }
	goodbye						= -1;							{  heap being reinitialized  }
	killCode					= 1;							{  KillIO requested  }
	accEvent					= 64;							{  handle an event  }
	accRun						= 65;							{  time for periodic action  }
	accCursor					= 66;							{  change cursor shape  }
	accMenu						= 67;							{  handle menu item  }
	accUndo						= 68;							{  handle undo command  }
	accCut						= 70;							{  handle cut command  }
	accCopy						= 71;							{  handle copy command  }
	accPaste					= 72;							{  handle paste command  }
	accClear					= 73;							{  handle clear command  }

{ Control/Status Call Codes }
	drvStsCode					= 8;							{  status call code for drive status  }
	ejectCode					= 7;							{  control call eject code  }
	tgBuffCode					= 8;							{  set tag buffer code  }

{ miscellaneous Device Manager constants }
	ioInProgress				= 1;							{  predefined value of ioResult while I/O is pending  }
	aRdCmd						= 2;							{  low byte of ioTrap for Read calls  }
	aWrCmd						= 3;							{  low byte of ioTrap for Write calls  }
	asyncTrpBit					= 10;							{  trap word modifier  }
	noQueueBit					= 9;							{  trap word modifier  }

{ flags used in the driver header and device control entry }
	dReadEnable					= 0;							{  set if driver responds to read requests  }
	dWritEnable					= 1;							{  set if driver responds to write requests  }
	dCtlEnable					= 2;							{  set if driver responds to control requests  }
	dStatEnable					= 3;							{  set if driver responds to status requests  }
	dNeedGoodBye				= 4;							{  set if driver needs time for performing periodic tasks  }
	dNeedTime					= 5;							{  set if driver needs time for performing periodic tasks  }
	dNeedLock					= 6;							{  set if driver must be locked in memory as soon as it is opened  }

	dNeedLockMask				= $4000;						{  set if driver must be locked in memory as soon as it is opened  }
	dNeedTimeMask				= $2000;						{  set if driver needs time for performing periodic tasks  }
	dNeedGoodByeMask			= $1000;						{  set if driver needs to be called before the application heap is initialized  }
	dStatEnableMask				= $0800;						{  set if driver responds to status requests  }
	dCtlEnableMask				= $0400;						{  set if driver responds to control requests  }
	dWritEnableMask				= $0200;						{  set if driver responds to write requests  }
	dReadEnableMask				= $0100;						{  set if driver responds to read requests  }


{ run-time flags used in the device control entry }
	dOpened						= 5;							{  driver is open  }
	dRAMBased					= 6;							{  dCtlDriver is a handle (1) or pointer (0)  }
	drvrActive					= 7;							{  driver is currently processing a request  }

	drvrActiveMask				= $0080;						{  driver is currently processing a request  }
	dRAMBasedMask				= $0040;						{  dCtlDriver is a handle (1) or pointer (0)  }
	dOpenedMask					= $0020;						{  driver is open  }



TYPE
	DRVRHeaderPtr = ^DRVRHeader;
	DRVRHeader = RECORD
		drvrFlags:				INTEGER;
		drvrDelay:				INTEGER;
		drvrEMask:				INTEGER;
		drvrMenu:				INTEGER;
		drvrOpen:				INTEGER;
		drvrPrime:				INTEGER;
		drvrCtl:				INTEGER;
		drvrStatus:				INTEGER;
		drvrClose:				INTEGER;
		drvrName:				SInt8;
	END;

	DRVRHeaderHandle					= ^DRVRHeaderPtr;
	DCtlEntryPtr = ^DCtlEntry;
	DCtlEntry = RECORD
		dCtlDriver:				Ptr;
		dCtlFlags:				INTEGER;
		dCtlQHdr:				QHdr;
		dCtlPosition:			LONGINT;
		dCtlStorage:			Handle;
		dCtlRefNum:				INTEGER;
		dCtlCurTicks:			LONGINT;
		dCtlWindow:				GrafPtr;
		dCtlDelay:				INTEGER;
		dCtlEMask:				INTEGER;
		dCtlMenu:				INTEGER;
	END;

	DCtlPtr								= ^DCtlEntry;
	DCtlHandle							= ^DCtlPtr;
	AuxDCEPtr = ^AuxDCE;
	AuxDCE = PACKED RECORD
		dCtlDriver:				Ptr;
		dCtlFlags:				INTEGER;
		dCtlQHdr:				QHdr;
		dCtlPosition:			LONGINT;
		dCtlStorage:			Handle;
		dCtlRefNum:				INTEGER;
		dCtlCurTicks:			LONGINT;
		dCtlWindow:				GrafPtr;
		dCtlDelay:				INTEGER;
		dCtlEMask:				INTEGER;
		dCtlMenu:				INTEGER;
		dCtlSlot:				SInt8;
		dCtlSlotId:				SInt8;
		dCtlDevBase:			LONGINT;
		dCtlOwner:				Ptr;
		dCtlExtDev:				SInt8;
		fillByte:				SInt8;
		dCtlNodeID:				UInt32;
	END;

	AuxDCEHandle						= ^AuxDCEPtr;
{	The NDRV Driver IO Entry Point and Commands }
	UnitNumber							= UInt16;
	DriverOpenCount						= UInt32;
	DriverRefNum						= SInt16;
	DriverFlags							= SInt16;
	IOCommandCode						= UInt32;

CONST
	kOpenCommand				= 0;
	kCloseCommand				= 1;
	kReadCommand				= 2;
	kWriteCommand				= 3;
	kControlCommand				= 4;
	kStatusCommand				= 5;
	kKillIOCommand				= 6;
	kInitializeCommand			= 7;							{  init driver and device }
	kFinalizeCommand			= 8;							{  shutdown driver and device }
	kReplaceCommand				= 9;							{  replace an old driver }
	kSupersededCommand			= 10;							{  prepare to be replaced by a new driver }
	kSuspendCommand				= 11;							{  prepare driver to go to sleep }
	kResumeCommand				= 12;							{  wake up sleeping driver }


TYPE
	AddressSpaceID = ^LONGINT; { an opaque 32-bit type }
	IOCommandID = ^LONGINT; { an opaque 32-bit type }
	IOCommandKind						= UInt32;

CONST
	kSynchronousIOCommandKind	= $00000001;
	kAsynchronousIOCommandKind	= $00000002;
	kImmediateIOCommandKind		= $00000004;


TYPE
	DriverInitInfoPtr = ^DriverInitInfo;
	DriverInitInfo = RECORD
		refNum:					DriverRefNum;
		deviceEntry:			RegEntryID;
	END;

	DriverReplaceInfo					= DriverInitInfo;
	DriverReplaceInfoPtr 				= ^DriverReplaceInfo;
	DriverFinalInfoPtr = ^DriverFinalInfo;
	DriverFinalInfo = RECORD
		refNum:					DriverRefNum;
		deviceEntry:			RegEntryID;
	END;

	DriverSupersededInfo				= DriverFinalInfo;
	DriverSupersededInfoPtr 			= ^DriverSupersededInfo;

{  Contents are command specific }

	IOCommandContentsPtr = ^IOCommandContents;
	IOCommandContents = RECORD
		CASE INTEGER OF
		0: (
			pb:					ParmBlkPtr;
			);
		1: (
			initialInfo:		DriverInitInfoPtr;
			);
		2: (
			finalInfo:			DriverFinalInfoPtr;
			);
		3: (
			replaceInfo:		DriverReplaceInfoPtr;
			);
		4: (
			supersededInfo:		DriverSupersededInfoPtr;
			);
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	DriverEntryPointPtr = FUNCTION(SpaceID: AddressSpaceID; CommandID: IOCommandID; Contents: IOCommandContents; Code: IOCommandCode; Kind: IOCommandKind): OSErr; C;
{$ELSEC}
	DriverEntryPointPtr = ProcPtr;
{$ENDC}

{ Record to describe a file-based driver candidate }
	FileBasedDriverRecordPtr = ^FileBasedDriverRecord;
	FileBasedDriverRecord = RECORD
		theSpec:				FSSpec;									{  file specification }
		theType:				MacDriverType;							{  nameInfoStr + version number }
		compatibleProp:			BOOLEAN;								{  true if matched using a compatible name }
		pad:					PACKED ARRAY [0..2] OF UInt8;			{  alignment }
	END;

{ Detailed Record to describe a file-based driver candidate. Includes fragment name }
	FileBasedDriverDetailedPtr = ^FileBasedDriverDetailed;
	FileBasedDriverDetailed = RECORD
		fileBasedDriver:		FileBasedDriverRecord;
		fragName:				Str63;
	END;

{ Driver Loader API }

{$IFC CALL_NOT_IN_CARBON }
FUNCTION HigherDriverVersion({CONST}VAR driverVersion1: NumVersion; {CONST}VAR driverVersion2: NumVersion): SInt16; C;
FUNCTION VerifyFragmentAsDriver(fragmentConnID: CFragConnectionID; VAR fragmentMain: DriverEntryPointPtr; VAR driverDesc: DriverDescriptionPtr): OSErr; C;
FUNCTION GetDriverMemoryFragment(memAddr: Ptr; length: LONGINT; fragName: Str63; VAR fragmentConnID: CFragConnectionID; VAR fragmentMain: DriverEntryPointPtr; VAR driverDesc: DriverDescriptionPtr): OSErr; C;
FUNCTION GetDriverDiskFragment(fragmentSpec: FSSpecPtr; VAR fragmentConnID: CFragConnectionID; VAR fragmentMain: DriverEntryPointPtr; VAR driverDesc: DriverDescriptionPtr): OSErr; C;
FUNCTION GetNamedDriverDiskFragment(fragmentSpec: FSSpecPtr; fragName: Str63; VAR fragmentConnID: CFragConnectionID; VAR fragmentMain: DriverEntryPointPtr; VAR driverDesc: DriverDescriptionPtr): OSErr; C;
FUNCTION InstallDriverFromFragment(fragmentConnID: CFragConnectionID; VAR device: RegEntryID; beginningUnit: UnitNumber; endingUnit: UnitNumber; VAR refNum: DriverRefNum): OSErr; C;
FUNCTION InstallDriverFromFile(fragmentSpec: FSSpecPtr; VAR device: RegEntryID; beginningUnit: UnitNumber; endingUnit: UnitNumber; VAR refNum: DriverRefNum): OSErr; C;
FUNCTION InstallDriverFromMemory(memory: Ptr; length: LONGINT; fragName: Str63; VAR device: RegEntryID; beginningUnit: UnitNumber; endingUnit: UnitNumber; VAR refNum: DriverRefNum): OSErr; C;
FUNCTION InstallDriverFromResource(theRsrcID: SInt16; theRsrcName: Str255; theDevice: RegEntryIDPtr; theBeginningUnit: UnitNumber; theEndingUnit: UnitNumber; VAR theRefNum: DriverRefNum): OSErr; C;
FUNCTION InstallDriverFromDisk(theDriverName: Ptr; VAR theDevice: RegEntryID; theBeginningUnit: UnitNumber; theEndingUnit: UnitNumber; VAR theRefNum: DriverRefNum): OSErr; C;
FUNCTION FindDriversForDevice(VAR device: RegEntryID; VAR fragmentSpec: FSSpec; VAR fileDriverDesc: DriverDescription; VAR memAddr: Ptr; VAR length: LONGINT; fragName: StringPtr; VAR memDriverDesc: DriverDescription): OSErr; C;
FUNCTION FindDriverForDeviceFromFile(VAR device: RegEntryID; VAR fragmentSpec: FSSpec; VAR driverDesc: DriverDescription; fragName: StringPtr): OSErr; C;
FUNCTION FindDriverCandidates(VAR deviceID: RegEntryID; VAR propBasedDriver: Ptr; VAR propBasedDriverSize: RegPropertyValueSize; deviceName: StringPtr; VAR propBasedDriverType: MacDriverType; VAR gotPropBasedDriver: BOOLEAN; fileBasedDrivers: FileBasedDriverRecordPtr; VAR nFileBasedDrivers: ItemCount): OSErr; C;
FUNCTION FindDriverCandidatesDetailed(deviceID: RegEntryIDPtr; VAR propBasedDriver: Ptr; VAR propBasedDriverSize: RegPropertyValueSize; deviceName: StringPtr; VAR propBasedDriverType: MacDriverType; VAR gotPropBasedDriver: BOOLEAN; fileBasedDrivers: FileBasedDriverDetailedPtr; VAR nFileBasedDrivers: ItemCount): OSErr; C;
FUNCTION ScanDriverCandidates(VAR deviceID: RegEntryID; fileBasedDrivers: FileBasedDriverRecordPtr; nFileBasedDrivers: ItemCount; matchingDrivers: FileBasedDriverRecordPtr; VAR nMatchingDrivers: ItemCount): OSErr; C;
FUNCTION ScanDriverCandidatesDetailed(VAR deviceID: RegEntryID; fileBasedDrivers: FileBasedDriverDetailedPtr; nFileBasedDrivers: ItemCount; matchingDrivers: FileBasedDriverDetailedPtr; VAR nMatchingDrivers: ItemCount): OSErr; C;
FUNCTION CompareFileCandToPropCand(VAR device: RegEntryID; deviceName: StringPtr; propBasedCandidate: DriverTypePtr; fileBasedCandidate: FileBasedDriverRecordPtr): SInt16; C;
PROCEDURE GetCompatibleProperty(VAR device: RegEntryID; VAR compatibleNames: StringPtr; VAR nCompatibleNames: ItemCount); C;
FUNCTION CompatibleDriverNames(nameInfoStr: StringPtr; compatibleNames: StringPtr; nCompatibleNames: ItemCount; VAR nameCount: LONGINT): BOOLEAN; C;
FUNCTION GetDriverForDevice(VAR device: RegEntryID; VAR fragmentConnID: CFragConnectionID; VAR fragmentMain: DriverEntryPointPtr; VAR driverDesc: DriverDescriptionPtr): OSErr; C;
FUNCTION InstallDriverForDevice(VAR device: RegEntryID; beginningUnit: UnitNumber; endingUnit: UnitNumber; VAR refNum: DriverRefNum): OSErr; C;
FUNCTION GetDriverInformation(refNum: DriverRefNum; VAR unitNum: UnitNumber; VAR flags: DriverFlags; VAR count: DriverOpenCount; name: StringPtr; VAR device: RegEntryID; VAR driverLoadLocation: CFragSystem7Locator; VAR fragmentConnID: CFragConnectionID; VAR fragmentMain: DriverEntryPointPtr; VAR driverDesc: DriverDescription): OSErr; C;
FUNCTION GetDriverDescription(fragmentPtr: LogicalAddress; VAR theDriverDesc: DriverDescriptionPtr): OSErr; C;
FUNCTION GetNamedDriverDescFromFSSpec(fragmentSpec: FSSpecPtr; fragName: StringPtr; VAR driverDesc: DriverDescriptionPtr): OSStatus; C;
FUNCTION SetDriverClosureMemory(fragmentConnID: CFragConnectionID; holdDriverMemory: BOOLEAN): OSErr; C;
FUNCTION ReplaceDriverWithFragment(theRefNum: DriverRefNum; fragmentConnID: CFragConnectionID): OSErr; C;
FUNCTION OpenInstalledDriver(refNum: DriverRefNum; ioPermission: SInt8): OSErr; C;
FUNCTION RenameDriver(refNum: DriverRefNum; newDriverName: StringPtr): OSErr; C;
FUNCTION RemoveDriver(refNum: DriverRefNum; immediate: BOOLEAN): OSErr; C;
FUNCTION LookupDrivers(beginningUnit: UnitNumber; endingUnit: UnitNumber; emptyUnits: BOOLEAN; VAR returnedRefNums: ItemCount; VAR refNums: DriverRefNum): OSErr; C;
FUNCTION HighestUnitNumber: UnitNumber; C;
FUNCTION DriverGestaltOn(refNum: DriverRefNum): OSErr; C;
FUNCTION DriverGestaltOff(refNum: DriverRefNum): OSErr; C;
FUNCTION DriverGestaltIsOn(flags: DriverFlags): BOOLEAN; C;

FUNCTION PBOpenSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A000, $3E80;
	{$ENDC}
FUNCTION PBOpenAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A400, $3E80;
	{$ENDC}
FUNCTION PBOpenImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A200, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBCloseSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A001, $3E80;
	{$ENDC}
FUNCTION PBCloseAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A401, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBCloseImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A201, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBReadSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A002, $3E80;
	{$ENDC}
FUNCTION PBReadAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A402, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBReadImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A202, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBWriteSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A003, $3E80;
	{$ENDC}
FUNCTION PBWriteAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A403, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBWriteImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A203, $3E80;
	{$ENDC}
{
	PBWaitIOComplete is a friendly way for applications to monitor
	a pending asynchronous I/O operation in power-managed and
	preemptive multitasking systems.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBWaitIOComplete(paramBlock: ParmBlkPtr; timeout: Duration): OSErr;

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE AddDrive(drvrRefNum: INTEGER; drvNum: INTEGER; qEl: DrvQElPtr);
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetDrvQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0308;
	{$ENDC}

FUNCTION GetDCtlEntry(refNum: INTEGER): DCtlHandle;
{$ENDC}  {CALL_NOT_IN_CARBON}

{
	SetChooserAlert used to simply set a bit in a low-mem global
	to tell the Chooser not to display its warning message when
	the printer is changed. However, under MultiFinder and System 7,
	this low-mem is swapped out when a layer change occurs, and the
	Chooser never sees the change. It is obsolete, and completely
	unsupported on the PowerPC. 68K apps can still call it if they
	wish.
	
	pascal Boolean SetChooserAlert(Boolean f);

}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION DriverInstall(drvrPtr: DRVRHeaderPtr; refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A03D, $3E80;
	{$ENDC}
FUNCTION DriverInstallReserveMem(drvrPtr: DRVRHeaderPtr; refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A43D, $3E80;
	{$ENDC}
{
  Note: DrvrInstall() is no longer supported, becuase it never really worked anyways.
  		There will soon be a DriverInstall() which does the right thing.

		DrvrRemove has been renamed to DriverRemove.  But, InterfaceLib for PowerPC
		still exports DrvrRemove, so a macro is used to map the new name to old.

}
FUNCTION DrvrRemove(refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A03E, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION DriverRemove(refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A03E, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}


{$IFC CALL_NOT_IN_CARBON }
FUNCTION OpenDriver(name: Str255; VAR drvrRefNum: INTEGER): OSErr;
FUNCTION CloseDriver(refNum: INTEGER): OSErr;
FUNCTION Control(refNum: INTEGER; csCode: INTEGER; csParamPtr: UNIV Ptr): OSErr;
FUNCTION Status(refNum: INTEGER; csCode: INTEGER; csParamPtr: UNIV Ptr): OSErr;
FUNCTION KillIO(refNum: INTEGER): OSErr;
FUNCTION Fetch(dce: DCtlPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $2078, $08F4, $4E90, $2E80;
	{$ENDC}
FUNCTION Stash(dce: DCtlPtr; data: ByteParameter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $225F, $2078, $08F8, $4E90, $2E80;
	{$ENDC}
PROCEDURE IODone(dce: DCtlPtr; ioResult: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $225F, $2078, $08FC, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBControlSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A004, $3E80;
	{$ENDC}
FUNCTION PBControlAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A404, $3E80;
	{$ENDC}
FUNCTION PBControlImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A204, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBStatusSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A005, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBStatusAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A405, $3E80;
	{$ENDC}
FUNCTION PBStatusImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A205, $3E80;
	{$ENDC}
FUNCTION PBKillIOSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A006, $3E80;
	{$ENDC}
FUNCTION PBKillIOAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A406, $3E80;
	{$ENDC}
FUNCTION PBKillIOImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A206, $3E80;
	{$ENDC}
FUNCTION OpenDeskAcc(deskAccName: Str255): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B6;
	{$ENDC}
PROCEDURE CloseDeskAcc(refNum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B7;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
	The PBxxx() routines are obsolete.  
	
	Use the PBxxxSync(), PBxxxAsync(), or PBxxxImmed version instead.
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBControl(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBStatus(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBKillIO(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}


{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBOpen(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBClose(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBRead(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBWrite(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}






{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DevicesIncludes}

{$ENDC} {__DEVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
