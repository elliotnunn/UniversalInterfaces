{
 	File:		PCCardEnablerPlugin.p
 
 	Contains:	???
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc. and SystemSoft Corporation.  All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCCardEnablerPlugin;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCCARDENABLERPLUGIN__}
{$SETC __PCCARDENABLERPLUGIN__ := 1}

{$I+}
{$SETC PCCardEnablerPluginIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __INTERRUPTS__}
{$I Interrupts.p}
{$ENDC}
{$IFC UNDEFINED __PCCARD__}
{$I PCCard.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC UNDEFINED __CARDSERVICES__ }
{
	NOTE: These prototypes conflict with CardServices.≈
		  You cannot use both PCCardEnablerPlugin.h and CardServices.h
		  
}

{	Copyright:	© 1996 SystemSoft Corporation, all rights reserved. }
{------------------------------------------------------------------------------------
	Card Services calls exported by the Family
------------------------------------------------------------------------------------}
{ 	Card Services for Card Enablers }

FUNCTION CSGetCardServicesInfo(VAR socketCount: UInt32; VAR complianceLevel: UInt32; VAR version: UInt32): OSStatus; C;

{  Function prototypes for tuples calls  }

FUNCTION CSGetFirstTuple(socket: PCCardSocket; device: UInt32; tupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; tupleData: UNIV Ptr; VAR tupleBufferSize: ByteCount; VAR foundTuple: Byte): OSStatus; C;
FUNCTION CSGetNextTuple(tupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; tupleData: UNIV Ptr; VAR tupleBufferSize: ByteCount; VAR foundTuple: Byte): OSStatus; C;

{  Function prototypes for window calls }

FUNCTION CSRequestWindow(vSocket: PCCardSocket; device: UInt32; windowAttributes: PCCardWindowAttributes; windowSpeed: PCCardAccessSpeed; VAR windowBase: LogicalAddress; VAR windowSize: PCCardWindowSize; VAR windowOffset: PCCardWindowOffset; VAR requestedWindow: PCCardWindowID): OSStatus; C;
FUNCTION CSReleaseWindow(windowToRelease: PCCardWindowID): OSStatus; C;
FUNCTION CSModifyWindow(windowToModify: PCCardWindowID; windowAttributes: PCCardWindowType; memorySpeed: PCCardAccessSpeed; VAR windowOffset: PCCardWindowOffset): OSStatus; C;
FUNCTION CSGetWindowBaseAddress(window: PCCardWindowID; VAR baseAddress: LogicalAddress): OSStatus; C;
FUNCTION CSInquireWindow(vSocket: PCCardSocket; device: UInt32; windowID: PCCardWindowID; VAR windowAttributes: PCCardWindowAttributes; VAR windowParam: PCCardAccessSpeed; VAR windowBase: UInt32; VAR windowSize: PCCardWindowSize; VAR windowOffset: PCCardWindowOffset): OSStatus; C;
{  Function prototypes for CIS calls }

FUNCTION CSValidateCIS(vSocket: PCCardSocket; device: UInt32; VAR cisChainCount: UInt32): OSStatus; C;
FUNCTION CSGetDeviceCount(vSocket: PCCardSocket; VAR deviceCount: UInt32): OSStatus; C;

{  Function prototypes for Status calls }

FUNCTION CSGetStatus(vSocket: PCCardSocket; VAR currentState: UInt32; VAR changedState: UInt32; VAR Vcc: PCCardVoltage; VAR Vpp: PCCardVoltage): OSStatus; C;

{  Function prototypes for configuration calls }

FUNCTION CSRequestConfiguration(vSocket: PCCardSocket; device: UInt32; configOptions: PCCardConfigOptions; socketInterface: PCCardInterfaceType; customInterface: PCCardCustomInterfaceID; vcc: PCCardVoltage; vpp: PCCardVoltage; IRQ: PCCardIRQ; DMA: PCCardDMA; configRegBaseAddress: UInt32; configRegPresentMask: PCCardConfigPresentMask; VAR configReg: PCCardFunctionConfigReg): OSStatus; C;
FUNCTION CSModifyConfiguration(vSocket: PCCardSocket; device: UInt32; modifyAttributes: PCCardConfigOptions; IRQ: PCCardIRQ; DMA: PCCardDMA; Vpp: PCCardVoltage): OSStatus; C;
FUNCTION CSReleaseConfiguration(vSocket: PCCardSocket; device: UInt32): OSStatus; C;
FUNCTION CSSetRingIndicate(vSocket: PCCardSocket; setRingIndicate: BOOLEAN): OSStatus; C;
FUNCTION CSResetFunction(vSocket: PCCardSocket; device: UInt32): OSStatus; C;
FUNCTION CSReadConfigurationRegister(vSocket: PCCardSocket; device: UInt32; whichRegister: PCCardConfigPresentMask; configRegBaseAddress: UInt32; VAR registerValue: UInt8): OSStatus; C;
FUNCTION CSWriteConfigurationRegister(vSocket: PCCardSocket; device: UInt32; whichRegister: PCCardConfigPresentMask; configRegBaseAddress: UInt32; registerValue: ByteParameter): OSStatus; C;
{ Function prototypes for Client Support calls}
FUNCTION CSRegisterClient(vSocket: PCCardSocket; eventMask: PCCardEventMask; clientCallBack: PCCardEventHandler; clientParam: UNIV Ptr; VAR newClientID: PCCardClientID): OSStatus; C;
FUNCTION CSDeRegisterClient(theClientID: PCCardClientID): OSStatus; C;
FUNCTION CSSetEventMask(theClientID: PCCardClientID; newEventMask: PCCardEventMask): OSStatus; C;
FUNCTION CSGetEventMask(theClientID: PCCardClientID; VAR newEventMask: PCCardEventMask): OSStatus; C;
FUNCTION CSRegisterTimer(registeredClientID: PCCardClientID; VAR lpNewTimerID: PCCardTimerID; delay: LONGINT): OSStatus; C;
FUNCTION CSDeRegisterTimer(timerID: PCCardTimerID): OSStatus; C;
{ Function prototypes for CardBus Config Space access}
FUNCTION CSReadCardBusConfigSpace(vSocket: PCCardSocket; device: UInt32; configOffset: UInt32; VAR data: Byte; dataSize: UInt32): OSStatus; C;
FUNCTION CSWriteCardBusConfigSpace(vSocket: PCCardSocket; device: UInt32; configOffset: UInt32; VAR data: Byte; dataSize: UInt32): OSStatus; C;
{------------------------------------------------------------------------------------
	Card Enabler Types
------------------------------------------------------------------------------------}

CONST
	kUnknownDeviceType			= 'unkn';
	kDisplayDeviceType			= 'dspl';
	kBlockDeviceType			= 'blok';
	kByteDeviceType				= 'byte';
	kNetworkDeviceType			= 'netw';
	kSerialDeviceType			= 'ser ';
	kParallelDeviceType			= 'parl';
	kMemoryDeviceType			= 'mem ';
	kAIMSDeviceType				= 'aims';
	kSCSIDeviceType				= 'scsi';


TYPE
	PCDeviceType						= OSType;

CONST
	kAttributeType				= 0;
	kMemoryType					= 1;
	kIOType						= 2;


TYPE
	PCCardMemoryType					= UInt32;

CONST
	kUnknown					= 'unkn';
	kPCCard16					= 'pc16';
	kCardBus					= 'cdbs';


TYPE
	PCCardArchitectureType				= OSType;

{------------------------------------------------------------------------------------
  Plugin Dispatch Table
------------------------------------------------------------------------------------}

CONST
	kServiceTypePCCardEnabler	= 'card';
	kPCCardEnablerPluginVersion	= $00000001;
	kPCCardEnablerPluginCurrentVersion = $00000001;

{	Card Enabler Entrypoints}

TYPE
	CEValidateHardwareProc = ProcPtr;  { FUNCTION CEValidateHardwareProc((CONST)VAR cardRef: RegEntryID): OSStatus; C; }

	CEInitializeProc = ProcPtr;  { FUNCTION CEInitializeProc((CONST)VAR cardRef: RegEntryID; replacingOld: BOOLEAN): OSStatus; C; }

	CECleanupProc = ProcPtr;  { FUNCTION CECleanupProc((CONST)VAR cardRef: RegEntryID; beingReplaced: BOOLEAN): OSStatus; C; }

	CEPowerManagementProc = ProcPtr;  { FUNCTION CEPowerManagementProc((CONST)VAR lpCardEntry: RegEntryID; powerLevel: PCCardPowerOptions): OSStatus; C; }

	CEHandleEventProc = ProcPtr;  { FUNCTION CEHandleEventProc((CONST)VAR cardRef: RegEntryID; theEvent: PCCardEvent): OSStatus; C; }

	CEGetCardInfoProc = ProcPtr;  { FUNCTION CEGetCardInfoProc((CONST)VAR cardRef: RegEntryID; VAR cardType: PCCardDevType; VAR cardSubType: PCCardSubType; cardName: StringPtr; vendorName: StringPtr): OSStatus; C; }

	CEAddCardPropertiesProc = ProcPtr;  { FUNCTION CEAddCardPropertiesProc((CONST)VAR cardRef: RegEntryID): OSStatus; C; }

	CEGetDeviceCountProc = ProcPtr;  { FUNCTION CEGetDeviceCountProc((CONST)VAR cardRef: RegEntryID; VAR numberOfDevices: ItemCount): OSStatus; C; }

	CEGetDeviceNameProc = ProcPtr;  { FUNCTION CEGetDeviceNameProc(socketNumber: UInt32; deviceNumber: UInt32; deviceName: CStringPtr): OSStatus; C; }

	CEGetDeviceCompatibleProc = ProcPtr;  { FUNCTION CEGetDeviceCompatibleProc((CONST)VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C; }

	CEGetDeviceTypeProc = ProcPtr;  { FUNCTION CEGetDeviceTypeProc((CONST)VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; VAR lpDeviceType: PCDeviceType): OSStatus; C; }

	CEGetDeviceTypeNameProc = ProcPtr;  { FUNCTION CEGetDeviceTypeNameProc((CONST)VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C; }

	CEAddDevicePropertiesProc = ProcPtr;  { FUNCTION CEAddDevicePropertiesProc((CONST)VAR deviceRef: RegEntryID; device: UInt32): OSStatus; C; }

	CEConfigureDeviceProc = ProcPtr;  { FUNCTION CEConfigureDeviceProc((CONST)VAR deviceRef: RegEntryID; deviceNumber: UInt32): OSStatus; C; }

	CEFinalizeDeviceProc = ProcPtr;  { FUNCTION CEFinalizeDeviceProc(socket: UInt32; device: UInt32; (CONST)VAR deviceRef: RegEntryID): OSStatus; C; }

	CEValidateCISProc = ProcPtr;  { FUNCTION CEValidateCISProc(socket: UInt32; device: UInt32; VAR lpCISChainCount: UInt32): OSStatus; C; }

	CEGetFirstTupleProc = ProcPtr;  { FUNCTION CEGetFirstTupleProc(socket: UInt32; device: UInt32; lpTupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; lptupleData: UNIV Ptr; VAR lpTupleBufferSize: UInt32; VAR lpFoundTuple: Byte): OSStatus; C; }

	CEGetNextTupleProc = ProcPtr;  { FUNCTION CEGetNextTupleProc(lpTupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; lptupleData: UNIV Ptr; VAR lpTupleBufferSize: UInt32; VAR lpFoundTuple: Byte): OSStatus; C; }

	PCCardEnablerPluginHeaderPtr = ^PCCardEnablerPluginHeader;
	PCCardEnablerPluginHeader = RECORD
		pluginDispatchTableVersion: UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

	PCCardEnablerPluginDispatchTablePtr = ^PCCardEnablerPluginDispatchTable;
	PCCardEnablerPluginDispatchTable = RECORD
		header:					PCCardEnablerPluginHeader;
																		{  General functions }
		validateHardwareProc:	CEValidateHardwareProc;
		initializeProc:			CEInitializeProc;
		cleanUpProc:			CECleanupProc;
		setPCCardPowerLevel:	CEPowerManagementProc;
																		{  Card functions }
		handleEventProc:		CEHandleEventProc;
		getCardInfoProc:		CEGetCardInfoProc;
		addCardProperties:		CEAddCardPropertiesProc;
		getDeviceCount:			CEGetDeviceCountProc;
																		{  Device functions }
		getDeviceName:			CEGetDeviceNameProc;
		getDeviceCompatibleNames: CEGetDeviceCompatibleProc;
		getDeviceType:			CEGetDeviceTypeProc;
		getDeviceTypeName:		CEGetDeviceTypeNameProc;
		addDeviceProperties:	CEAddDevicePropertiesProc;
		configureDevice:		CEConfigureDeviceProc;
		finalizeDevice:			CEFinalizeDeviceProc;
																		{  Card Services Overrides... }
		validateCIS:			CEValidateCISProc;
		getFirstTuple:			CEGetFirstTupleProc;
		getNextTuple:			CEGetNextTupleProc;
																		{  InterruptHandlers... }
		cardInterruptHandlerFunction: InterruptHandler;
		cardInterruptEnableFunction: InterruptEnabler;
		cardInterruptDisableFunction: InterruptDisabler;
	END;

{------------------------------------------------------------------------------------
	PC Card Enabler Utility calls exported by the Family
------------------------------------------------------------------------------------}
{	Generic Enabler Entrypoints}
FUNCTION CEInitializeCard({CONST}VAR cardRef: RegEntryID; replacingOld: BOOLEAN): OSStatus; C;
FUNCTION CEFinalizeCard({CONST}VAR cardRef: RegEntryID; beingReplaced: BOOLEAN): OSStatus; C;
FUNCTION CEPowerManagement({CONST}VAR lpParentID: RegEntryID; powerLevel: PCCardPowerOptions): OSStatus; C;
FUNCTION CEHandleCardEvent({CONST}VAR cardRef: RegEntryID; lTheCardEvent: PCCardEvent): OSStatus; C;
FUNCTION CEGetCardInfo({CONST}VAR cardRef: RegEntryID; VAR cardType: PCCardDevType; VAR cardSubType: PCCardSubType; cardName: StringPtr; vendorName: StringPtr): OSStatus; C;
FUNCTION CEAddCardProperties({CONST}VAR cardRef: RegEntryID): OSStatus; C;
FUNCTION CEGetDeviceCount({CONST}VAR cardRef: RegEntryID; VAR numberOfDevices: ItemCount): OSStatus; C;
{  device functions }
FUNCTION CEGetDeviceName(socketNumber: UInt32; deviceNumber: UInt32; deviceName: CStringPtr): OSStatus; C;
FUNCTION CEGetDeviceCompatibleNames({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C;
FUNCTION CEGetDeviceType({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; VAR lpDeviceType: PCDeviceType): OSStatus; C;
FUNCTION CEGetDeviceTypeName({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C;
FUNCTION CEAddDeviceProperties({CONST}VAR deviceRef: RegEntryID; deviceNumber: UInt32): OSStatus; C;
FUNCTION CEConfigureDevice({CONST}VAR deviceRef: RegEntryID; deviceNumber: UInt32): OSStatus; C;
FUNCTION CEFinalizeDevice(socket: UInt32; device: UInt32; {CONST}VAR deviceRef: RegEntryID): OSStatus; C;

{	RegEntryID <-> socket number mapping functions}
FUNCTION CEGetSocketAndDeviceFromRegEntry({CONST}VAR lpNode: RegEntryID; VAR lpSocket: UInt32; VAR lpDevice: UInt32): OSStatus; C;
FUNCTION CEGetPhysicalSocketNumber({CONST}VAR socketRef: RegEntryID; {CONST}VAR lpDeviceEntry: RegEntryID; VAR lpPhysicalSocketNumber: UInt32): OSStatus; C;
{	Hardware Validation Utilities}
FUNCTION CECompareCISTPL_VERS_1({CONST}VAR cardRef: RegEntryID; majorVersion: ByteParameter; minorVersion: ByteParameter; manufacturer: ConstCStringPtr; productName: ConstCStringPtr; info1: ConstCStringPtr; info2: ConstCStringPtr; VAR identical: BOOLEAN): OSStatus; C;
FUNCTION CECompareCISTPL_MANFID({CONST}VAR cardRef: RegEntryID; manufacturerCode: UInt16; manufacturerInfo: UInt16; VAR identical: BOOLEAN): OSStatus; C;
FUNCTION CECompareMemory({CONST}VAR cardRef: RegEntryID; memType: PCCardMemoryType; offset: ByteCount; length: ByteCount; VAR dataToCompare: Byte; VAR identical: BOOLEAN): OSStatus; C;
FUNCTION CEValidateCIS(socket: UInt32; device: UInt32; VAR lpCISChainCount: UInt32): OSStatus; C;
FUNCTION CEDefaultInterruptHandler(ISTmember: InterruptSetMember; refCon: UNIV Ptr; theIntCount: UInt32): InterruptMemberNumber; C;

{------------------------------------------------------------------------------------
	PC Card Customization Resources
------------------------------------------------------------------------------------}

CONST
	kPCCardCustomInfoResType	= 'pccd';
	kPCCardCustomInfoVersion	= 0;


TYPE
	PCCardCustomResourcePtr = ^PCCardCustomResource;
	PCCardCustomResource = RECORD
		version:				LONGINT;
		customIconID:			INTEGER;								{ 	ICN#, etc. resource ID }
		customStringsID:		INTEGER;								{ 	STR# resource ID }
		customTypeStringIndex:	INTEGER;
		customHelpStringIndex:	INTEGER;
		customAction:			OSType;
		customActionParam1:		LONGINT;
		customActionParam2:		LONGINT;
	END;

{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCCardEnablerPluginIncludes}

{$ENDC} {__PCCARDENABLERPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
