{
 	File:		DriverServices.p
 
 	Contains:	Driver Services Interfaces.
 
 	Version:	Technology:	PowerSurge 1.0.2
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
 UNIT DriverServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERSERVICES__}
{$SETC __DRIVERSERVICES__ := 1}

{$I+}
{$SETC DriverServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{$IFC UNDEFINED __MACHINEEXCEPTIONS__}
{$I MachineExceptions.p}
{$ENDC}
{$IFC UNDEFINED __DEVICES__}
{$I Devices.p}
{$ENDC}
{$IFC UNDEFINED __DRIVERSYNCHRONIZATION__}
{$I DriverSynchronization.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************
 *
 * 		Previously in Kernel.h
 *
 *****************************************************************}
{  Kernel basics }

TYPE
	IOPreparationID = ^LONGINT; { an opaque 32-bit type }
	SoftwareInterruptID = ^LONGINT; { an opaque 32-bit type }
	TaskID = ^LONGINT; { an opaque 32-bit type }
	TimerID = ^LONGINT; { an opaque 32-bit type }
{  Tasking }
	ExecutionLevel						= UInt32;

CONST
	kTaskLevel					= 0;
	kSoftwareInterruptLevel		= 1;
	kAcceptFunctionLevel		= 2;
	kKernelLevel				= 3;
	kSIHAcceptFunctionLevel		= 4;
	kSecondaryInterruptLevel	= 5;
	kHardwareInterruptLevel		= 6;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SoftwareInterruptHandler = PROCEDURE(p1: UNIV Ptr; p2: UNIV Ptr); C;
{$ELSEC}
	SoftwareInterruptHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SecondaryInterruptHandler2 = FUNCTION(p1: UNIV Ptr; p2: UNIV Ptr): OSStatus; C;
{$ELSEC}
	SecondaryInterruptHandler2 = ProcPtr;
{$ENDC}


CONST
	kCurrentAddressSpaceID		= -1;

{  Memory System basics }

TYPE
	LogicalAddressRangePtr = ^LogicalAddressRange;
	LogicalAddressRange = RECORD
		address:				LogicalAddress;
		count:					ByteCount;
	END;

	PhysicalAddressRangePtr = ^PhysicalAddressRange;
	PhysicalAddressRange = RECORD
		address:				PhysicalAddress;
		count:					ByteCount;
	END;

{  For PrepareMemoryForIO and CheckpointIO }
	IOPreparationOptions				= OptionBits;

CONST
	kIOMultipleRanges			= $00000001;
	kIOLogicalRanges			= $00000002;
	kIOMinimalLogicalMapping	= $00000004;
	kIOShareMappingTables		= $00000008;
	kIOIsInput					= $00000010;
	kIOIsOutput					= $00000020;
	kIOCoherentDataPath			= $00000040;
	kIOTransferIsLogical		= $00000080;
	kIOClientIsUserMode			= $00000080;


TYPE
	IOPreparationState					= OptionBits;

CONST
	kIOStateDone				= $00000001;

	kInvalidPageAddress			= -1;


TYPE
	AddressRangePtr = ^AddressRange;
	AddressRange = RECORD
		base:					Ptr;
		length:					ByteCount;
	END;

{  C's treatment of arrays and array pointers is atypical }
	LogicalMappingTable					= ARRAY [0..0] OF LogicalAddress;
	LogicalMappingTablePtr				= ^LogicalMappingTable;
	PhysicalMappingTable				= ARRAY [0..0] OF PhysicalAddress;
	PhysicalMappingTablePtr				= ^PhysicalMappingTable;
	AddressRangeTable					= ARRAY [0..0] OF AddressRange;
	AddressRangeTablePtr				= ^AddressRangeTable;
	MultipleAddressRangePtr = ^MultipleAddressRange;
	MultipleAddressRange = RECORD
		entryCount:				ItemCount;
		rangeTable:				AddressRangeTablePtr;
	END;

{
   Separate C definition so that union has a name.  A future version of the interfacer
   tool will allow a name (that gets thrown out in Pascal and Asm).
}
	IOPreparationTablePtr = ^IOPreparationTable;
	IOPreparationTable = RECORD
		options:				IOPreparationOptions;
		state:					IOPreparationState;
		preparationID:			IOPreparationID;
		addressSpace:			AddressSpaceID;
		granularity:			ByteCount;
		firstPrepared:			ByteCount;
		lengthPrepared:			ByteCount;
		mappingEntryCount:		ItemCount;
		logicalMapping:			LogicalMappingTablePtr;
		physicalMapping:		PhysicalMappingTablePtr;
		CASE INTEGER OF
		0: (
			range:				AddressRange;
			);
		1: (
			multipleRanges:		MultipleAddressRange;
			);
	END;

	IOCheckpointOptions					= OptionBits;

CONST
	kNextIOIsInput				= $00000001;
	kNextIOIsOutput				= $00000002;
	kMoreIOTransfers			= $00000004;

{  For SetProcessorCacheMode }


TYPE
	ProcessorCacheMode					= UInt32;

CONST
	kProcessorCacheModeDefault	= 0;
	kProcessorCacheModeInhibited = 1;
	kProcessorCacheModeWriteThrough = 2;
	kProcessorCacheModeCopyBack	= 3;

{
   For GetPageInformation
   (Note: if kPageInformationVersion fails, try 0 -- old versions of DSL defined  kPageInformationVersion as 0)
}

	kPageInformationVersion		= 1;


TYPE
	PageStateInformation				= UInt32;

CONST
	kPageIsProtected			= $00000001;
	kPageIsProtectedPrivileged	= $00000002;
	kPageIsModified				= $00000004;
	kPageIsReferenced			= $00000008;
	kPageIsLockedResident		= $00000010;					{  held and locked resident }
	kPageIsInMemory				= $00000020;
	kPageIsShared				= $00000040;
	kPageIsWriteThroughCached	= $00000080;
	kPageIsCopyBackCached		= $00000100;
	kPageIsHeldResident			= $00000200;					{  held resident - use kPageIsLockedResident to check for locked state }
	kPageIsLocked				= $00000010;					{  Deprecated }
	kPageIsResident				= $00000020;					{  Deprecated }


TYPE
	PageInformationPtr = ^PageInformation;
	PageInformation = RECORD
		area:					AreaID;
		count:					ItemCount;
		information:			ARRAY [0..0] OF PageStateInformation;
	END;


{  Tasks  }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CurrentExecutionLevel: ExecutionLevel; C;
FUNCTION CurrentTaskID: TaskID; C;
FUNCTION DelayFor(delayDuration: Duration): OSStatus; C;
FUNCTION InPrivilegedMode: BOOLEAN; C;

{  Software Interrupts  }
FUNCTION CreateSoftwareInterrupt(handler: SoftwareInterruptHandler; task: TaskID; p1: UNIV Ptr; persistent: BOOLEAN; VAR theSoftwareInterrupt: SoftwareInterruptID): OSStatus; C;

FUNCTION SendSoftwareInterrupt(theSoftwareInterrupt: SoftwareInterruptID; p2: UNIV Ptr): OSStatus; C;
FUNCTION DeleteSoftwareInterrupt(theSoftwareInterrupt: SoftwareInterruptID): OSStatus; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_OS_MAC }
{  Secondary Interrupts  }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CallSecondaryInterruptHandler2(theHandler: SecondaryInterruptHandler2; exceptionHandler: ExceptionHandler; p1: UNIV Ptr; p2: UNIV Ptr): OSStatus; C;
FUNCTION QueueSecondaryInterruptHandler(theHandler: SecondaryInterruptHandler2; exceptionHandler: ExceptionHandler; p1: UNIV Ptr; p2: UNIV Ptr): OSStatus; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}

{  Timers  }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SetInterruptTimer({CONST}VAR expirationTime: AbsoluteTime; handler: SecondaryInterruptHandler2; p1: UNIV Ptr; VAR theTimer: TimerID): OSStatus; C;
FUNCTION SetPersistentTimer(frequency: Duration; theHandler: SecondaryInterruptHandler2; p1: UNIV Ptr; VAR theTimer: TimerID): OSStatus; C;
FUNCTION CancelTimer(theTimer: TimerID; VAR timeRemaining: AbsoluteTime): OSStatus; C;

{  I/O related Operations  }
FUNCTION PrepareMemoryForIO(VAR theIOPreparationTable: IOPreparationTable): OSStatus; C;
FUNCTION CheckpointIO(theIOPreparation: IOPreparationID; options: IOCheckpointOptions): OSStatus; C;

{  Memory Operations  }
FUNCTION GetPageInformation(addressSpace: AddressSpaceID; base: ConstLogicalAddress; length: ByteCount; version: PBVersion; VAR thePageInfo: PageInformation): OSStatus; C;
{  Processor Cache Related  }
FUNCTION SetProcessorCacheMode(addressSpace: AddressSpaceID; base: ConstLogicalAddress; length: ByteCount; cacheMode: ProcessorCacheMode): OSStatus; C;
{*****************************************************************
 *
 * 		Was in DriverSupport.h or DriverServices.h
 *
 *****************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	DeviceLogicalAddressPtr				= ^LogicalAddress;

CONST
	durationMicrosecond			= -1;							{  Microseconds are negative }
	durationMillisecond			= 1;							{  Milliseconds are positive }
	durationSecond				= 1000;							{  1000 * durationMillisecond }
	durationMinute				= 60000;						{  60 * durationSecond, }
	durationHour				= 3600000;						{  60 * durationMinute, }
	durationDay					= 86400000;						{  24 * durationHour, }
	durationNoWait				= 0;							{  don't block }
	durationForever				= $7FFFFFFF;					{  no time limit }

	k8BitAccess					= 0;							{  access as 8 bit }
	k16BitAccess				= 1;							{  access as 16 bit }
	k32BitAccess				= 2;							{  access as 32 bit }


TYPE
	Nanoseconds							= UnsignedWide;
	NanosecondsPtr 						= ^Nanoseconds;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION IOCommandIsComplete(theID: IOCommandID; theResult: OSErr): OSErr; C;
FUNCTION GetIOCommandInfo(theID: IOCommandID; VAR theContents: IOCommandContents; VAR theCommand: IOCommandCode; VAR theKind: IOCommandKind): OSErr; C;
PROCEDURE UpdateDeviceActivity(VAR deviceEntry: RegEntryID); C;
PROCEDURE BlockCopy(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size); C;
FUNCTION PoolAllocateResident(byteSize: ByteCount; clear: BOOLEAN): LogicalAddress; C;
FUNCTION PoolDeallocate(address: LogicalAddress): OSStatus; C;
FUNCTION GetLogicalPageSize: ByteCount; C;
FUNCTION GetDataCacheLineSize: ByteCount; C;
FUNCTION FlushProcessorCache(spaceID: AddressSpaceID; base: LogicalAddress; length: ByteCount): OSStatus; C;
FUNCTION MemAllocatePhysicallyContiguous(byteSize: ByteCount; clear: BOOLEAN): LogicalAddress; C;
FUNCTION MemDeallocatePhysicallyContiguous(address: LogicalAddress): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION UpTime: AbsoluteTime; C;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE GetTimeBaseInfo(VAR minAbsoluteTimeDelta: UInt32; VAR theAbsoluteTimeToNanosecondNumerator: UInt32; VAR theAbsoluteTimeToNanosecondDenominator: UInt32; VAR theProcessorToAbsoluteTimeNumerator: UInt32; VAR theProcessorToAbsoluteTimeDenominator: UInt32); C;

{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION AbsoluteToNanoseconds(absoluteTime: AbsoluteTime): Nanoseconds; C;
FUNCTION AbsoluteToDuration(absoluteTime: AbsoluteTime): Duration; C;
FUNCTION NanosecondsToAbsolute(nanoseconds: Nanoseconds): AbsoluteTime; C;
FUNCTION DurationToAbsolute(duration: Duration): AbsoluteTime; C;
FUNCTION AddAbsoluteToAbsolute(absoluteTime1: AbsoluteTime; absoluteTime2: AbsoluteTime): AbsoluteTime; C;
FUNCTION SubAbsoluteFromAbsolute(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION AddNanosecondsToAbsolute(nanoseconds: Nanoseconds; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION AddDurationToAbsolute(duration: Duration; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION SubNanosecondsFromAbsolute(nanoseconds: Nanoseconds; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION SubDurationFromAbsolute(duration: Duration; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION AbsoluteDeltaToNanoseconds(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): Nanoseconds; C;
FUNCTION AbsoluteDeltaToDuration(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): Duration; C;
FUNCTION DurationToNanoseconds(theDuration: Duration): Nanoseconds; C;
FUNCTION NanosecondsToDuration(theNanoseconds: Nanoseconds): Duration; C;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBQueueInit(qHeader: QHdrPtr): OSErr; C;
FUNCTION PBQueueCreate(VAR qHeader: QHdrPtr): OSErr; C;
FUNCTION PBQueueDelete(qHeader: QHdrPtr): OSErr; C;
PROCEDURE PBEnqueue(qElement: QElemPtr; qHeader: QHdrPtr); C;
FUNCTION PBEnqueueLast(qElement: QElemPtr; qHeader: QHdrPtr): OSErr; C;
FUNCTION PBDequeue(qElement: QElemPtr; qHeader: QHdrPtr): OSErr; C;
FUNCTION PBDequeueFirst(qHeader: QHdrPtr; VAR theFirstqElem: QElemPtr): OSErr; C;
FUNCTION PBDequeueLast(qHeader: QHdrPtr; VAR theLastqElem: QElemPtr): OSErr; C;
FUNCTION CStrCopy(dst: CStringPtr; src: ConstCStringPtr): CStringPtr; C;
FUNCTION PStrCopy(dst: StringPtr; src: Str255): StringPtr; C;
FUNCTION CStrNCopy(dst: CStringPtr; src: ConstCStringPtr; max: UInt32): CStringPtr; C;
FUNCTION PStrNCopy(dst: StringPtr; src: Str255; max: UInt32): StringPtr; C;
FUNCTION CStrCat(dst: CStringPtr; src: ConstCStringPtr): CStringPtr; C;
FUNCTION PStrCat(dst: StringPtr; src: Str255): StringPtr; C;
FUNCTION CStrNCat(dst: CStringPtr; src: ConstCStringPtr; max: UInt32): CStringPtr; C;
FUNCTION PStrNCat(dst: StringPtr; src: Str255; max: UInt32): StringPtr; C;
PROCEDURE PStrToCStr(dst: CStringPtr; src: Str255); C;
PROCEDURE CStrToPStr(VAR dst: Str255; src: ConstCStringPtr); C;
FUNCTION CStrCmp(s1: ConstCStringPtr; s2: ConstCStringPtr): SInt16; C;
FUNCTION PStrCmp(str1: Str255; str2: Str255): SInt16; C;
FUNCTION CStrNCmp(s1: ConstCStringPtr; s2: ConstCStringPtr; max: UInt32): SInt16; C;
FUNCTION PStrNCmp(str1: Str255; str2: Str255; max: UInt32): SInt16; C;
FUNCTION CStrLen(src: ConstCStringPtr): UInt32; C;
FUNCTION PStrLen(src: Str255): UInt32; C;
FUNCTION DeviceProbe(theSrc: UNIV Ptr; theDest: UNIV Ptr; AccessType: UInt32): OSStatus; C;
FUNCTION DelayForHardware(absoluteTime: AbsoluteTime): OSStatus; C;


{*****************************************************************
 *
 * 		Was in Interrupts.h 
 *
 *****************************************************************}
{  Interrupt types  }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	InterruptSetID = ^LONGINT; { an opaque 32-bit type }
	InterruptMemberNumber				= LONGINT;
	InterruptSetMemberPtr = ^InterruptSetMember;
	InterruptSetMember = RECORD
		setID:					InterruptSetID;
		member:					InterruptMemberNumber;
	END;


CONST
	kISTChipInterruptSource		= 0;
	kISTOutputDMAInterruptSource = 1;
	kISTInputDMAInterruptSource	= 2;
	kISTPropertyMemberCount		= 3;


TYPE
	ISTProperty							= ARRAY [0..2] OF InterruptSetMember;
	InterruptReturnValue				= LONGINT;

CONST
	kFirstMemberNumber			= 1;
	kIsrIsComplete				= 0;
	kIsrIsNotComplete			= -1;
	kMemberNumberParent			= -2;


TYPE
	InterruptSourceState				= BOOLEAN;

CONST
	kSourceWasEnabled			= true;
	kSourceWasDisabled			= false;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	InterruptHandler = FUNCTION(ISTmember: InterruptSetMember; refCon: UNIV Ptr; theIntCount: UInt32): InterruptMemberNumber; C;
{$ELSEC}
	InterruptHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	InterruptEnabler = PROCEDURE(ISTmember: InterruptSetMember; refCon: UNIV Ptr); C;
{$ELSEC}
	InterruptEnabler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	InterruptDisabler = FUNCTION(ISTmember: InterruptSetMember; refCon: UNIV Ptr): ByteParameter; C;
{$ELSEC}
	InterruptDisabler = ProcPtr;
{$ENDC}


CONST
	kReturnToParentWhenComplete	= $00000001;
	kReturnToParentWhenNotComplete = $00000002;


TYPE
	InterruptSetOptions					= OptionBits;
{  Interrupt Services  }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CreateInterruptSet(parentSet: InterruptSetID; parentMember: InterruptMemberNumber; setSize: InterruptMemberNumber; VAR setID: InterruptSetID; options: InterruptSetOptions): OSStatus; C;

FUNCTION InstallInterruptFunctions(setID: InterruptSetID; member: InterruptMemberNumber; refCon: UNIV Ptr; handlerFunction: InterruptHandler; enableFunction: InterruptEnabler; disableFunction: InterruptDisabler): OSStatus; C;

FUNCTION GetInterruptFunctions(setID: InterruptSetID; member: InterruptMemberNumber; VAR refCon: UNIV Ptr; VAR handlerFunction: InterruptHandler; VAR enableFunction: InterruptEnabler; VAR disableFunction: InterruptDisabler): OSStatus; C;
FUNCTION ChangeInterruptSetOptions(setID: InterruptSetID; options: InterruptSetOptions): OSStatus; C;
FUNCTION GetInterruptSetOptions(setID: InterruptSetID; VAR options: InterruptSetOptions): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverServicesIncludes}

{$ENDC} {__DRIVERSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}