{
 	File:		PCCard.p
 
 	Contains:	PC Card Family Programming interface
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1996-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCCard;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCCARD__}
{$SETC __PCCARD__ := 1}

{$I+}
{$SETC PCCardIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


CONST
	kServiceCategoryPCCard		= 'pccd';



TYPE
	PCCardEvent							= UInt32;
	PCCardEventMask						= UInt32;
	PCCardClientID						= UInt32;
	PCCardTimerID						= UInt32;
	PCCardSocket						= UInt32;
	PCCardWindowID						= UInt32;
	PCCardWindowType					= UInt32;
	PCCardWindowSize					= UInt32;
	PCCardWindowOffset					= UInt32;
	PCCardWindowAlign					= UInt32;
	PCCardWindowState					= OptionBits;
	PCCardAccessSpeed					= UInt32;
	PCCardWindowParam					= UInt32;
	PCCardPage							= UInt32;
	PCCardVoltage						= UInt32;
{
	Several of the client notification bit flags have been REMOVED since the first
	release of this header.  These were unused codes that were either
	copied directly from PC Card 2.x, or from the PCMCIA standard.  In all cases,
	they were completely unimplemented and would never be sent under PCCard 3.0.
	
	The removed flags are:
		kPCCardClientInfoMessage, kPCCardSSUpdatedMessage,
		and kPCCardFunctionInterruptMessage.
	
	If your software used any of these flags, you should delete any references
	to them.  These event codes are being recycled for new features.
}
{ Client notification bit flags }

CONST
	kPCCardNullMessage			= $00000000;					{  no messages pending (not sent to clients) }
	kPCCardInsertionMessage		= $00000001;					{  card has been inserted into the socket }
	kPCCardRemovalMessage		= $00000002;					{  card has been removed from the socket- do not touch hardware! }
																{  Lock and Unlock may be used for a hardware locking card-cage.  }
	kPCCardLockMessage			= $00000004;					{  card is locked into the socket with a mechanical latch  }
	kPCCardUnlockMessage		= $00000008;					{  card is no longer locked into the socket  }
																{  Ready and Reset are holdovers from PC Card 2.x, but someone might be using them (!?)  }
	kPCCardReadyMessage			= $00000010;					{  card is ready to be accessed -- do not use! this event is never sent! (use kPCCardInsertion instead)  }
	kPCCardResetMessage			= $00000020;					{  physical reset has completed -- do not use! this event is never sent! (use kPCCardResetComplete instead)  }
																{  InsertionRequest and InsertionComplete may be used with certain cages (??)  }
	kPCCardInsertionRequestMessage = $00000040;					{  request to insert a card using insertion motor  }
	kPCCardInsertionCompleteMessage = $00000080;				{  insertion motor has finished inserting a card  }
	kPCCardEjectionRequestMessage = $00000100;					{  user or other client is requesting a card ejection }
	kPCCardEjectionCompleteMessage = $00000200;					{  card ejection succeeded- do not touch hardware!  }
	kPCCardEjectionFailedMessage = $00000400;					{  eject failure due to electrical/mechanical problems }
	kPCCardPMResumeMessage		= $00000800;					{  power management resume  }
	kPCCardPMSuspendMessage		= $00001000;					{  power management suspend  }
	kPCCardPMSuspendRequest		= $00002000;					{  power management sleep request  }
	kPCCardPMSuspendRevoke		= $00004000;					{  power management sleep revoke  }
	kPCCardResetPhysicalMessage	= $00008000;					{  physical reset is about to occur on this card -- this event is never sent!  }
	kPCCardResetRequestMessage	= $00010000;					{  physical reset has been requested by a client }
	kPCCardResetCompleteMessage	= $00020000;					{  ResetCard() background reset has completed }
	kPCCardBatteryDeadMessage	= $00040000;					{  battery is no longer useable, data will be lost }
	kPCCardBatteryLowMessage	= $00080000;					{  battery is weak and should be replaced }
	kPCCardWriteProtectMessage	= $00100000;					{  card is now write protected }
	kPCCardWriteEnabledMessage	= $00200000;					{  card is now write enabled }
	kPCCardUnexpectedRemovalMessage = $02000000;				{  card has unexpectedly been manually ejected -- careful, this event occurs at hardware interrupt time  }
																{  Unconfigured is a (currently unused) holdover from PC Card 2.x  }
	kPCCardUnconfiguredMessage	= $04000000;					{  a CARD_READY was delivered to all clients and no client  }
																{ 	requested a configuration for the socket -- this event is never sent under PCCard 3.0!  }
	kPCCardStatusChangedMessage	= $08000000;					{  status change for cards in I/O mode }
	kPCCardTimerExpiredMessage	= $10000000;					{  message sent when requested time has expired  }
	kPCCardRequestAttentionMessage = $20000000;
	kPCCardEraseCompleteMessage	= $40000000;
	kPCCardRegistrationCompleteMessage = $80000000;				{  notifications available only in PCCard 3.1 and later  }
	kPCCardPMEnabledMessage		= $00800000;					{  power management has been enabled by the user; if appropriate, clients should call PCCardSetPowerLevel(off)  }


TYPE
	PCCardWindowAttributes				= OptionBits;
{	window state (values of PCCardWindowAttributes) }

CONST
	kWSCommon					= $0001;						{  common memory window  }
	kWSAttribute				= $0002;						{  attribute memory window }
	kWSIO						= $0004;						{  I/O window }
	kWSCardBus					= $0800;						{  CardBus bridge window  }
	kWSTypeMask					= $0807;						{  window type mask }
	kWSEnabled					= $0008;						{  window enabled }
	kWS8bit						= $0010;						{  8-bit data width window }
	kWS16bit					= $0020;						{  16-bit data width window }
	kWS32bit					= $0040;						{  32-bit data width window }
	kWSAutoSize					= $0080;						{  auto-size data width window }
	kWSWidthMask				= $00F0;						{  window data width mask }
	kWSProtected				= $0100;						{  window write protected }
	kWSPrefetchable				= $0200;						{  bridge window prefetchable }
	kWSPageShared				= $0400;						{  page register is shared }
	kWSWindowSizeOffset			= $4000;
	kWSChangeAccessSpeed		= $8000;						{  Used by CSModifyWindow only  }

{ window speed (sample values of PCCardAccessSpeed) for use in PCCardRequestWindow  }
	kAccessSpeed600ns			= $006A;
	kAccessSpeed500ns			= $005A;
	kAccessSpeed400ns			= $004A;
	kAccessSpeed300ns			= $003A;
	kAccessSpeed250ns			= $0001;
	kAccessSpeed200ns			= $0002;
	kAccessSpeed150ns			= $0003;
	kAccessSpeed100ns			= $0004;


TYPE
	PCCardInterfaceType					= UInt32;
{ InterfaceType bit-mask (values of PCCardInterfaceType) }

CONST
	kIFTypeMask					= $03;							{  IO & memory type mask }
	kIFCardBus					= $00;							{  if bits 0 & 1 are zero then cardbus interface }
	kIFMemory					= $01;							{  if bit 0 set memory IF }
	kIFIO						= $02;							{  if bit 1 set IO IF }
	kIFReserved					= $03;							{  bits 0 and 1 set is reserved  }
	kIFDMA						= $08;							{  if bit 3 set DMA supported }
	kIFVSKey					= $10;							{  if bit 4 set supports low Voltage key }
	kIF33VCC					= $20;							{  if bit 5 set socket suports 3.3v }
	kIFXXVCC					= $40;							{  if bit 6 set socket supports X.X voltage }
	kIFYYVCC					= $80;							{  if bit 7 set socket supports Y.Y voltage }


TYPE
	PCCardCustomInterfaceID				= UInt32;
{ Custom Interface Identifiers (values of PCCardCustomInterfaceID) }

CONST
	kIFCustom_None				= $00;							{  no custom interface ID  }
	kIFCustom_ZOOM				= $41;							{  ZOOM Video Mode custom interface identifier  }


TYPE
	PCCardConfigOptions					= OptionBits;
{ Bit mask values for PCCardConfigOptions in the configuration calls }

CONST
	kEnableIRQSteering			= $0002;
	kIRQChangeValid				= $0004;
	kVppChangeValid				= $0010;
	kEnableDMAChannel			= $0040;
	kDMAChangeValid				= $0080;
	kVSOverride					= $0200;						{  Bits 10..31 reserved  }

{
   Configuration Registers Presence Mask for the FCR
   Used by PCCardConfigPresentMask
}
	kConfigOptionPresent		= $00000001;
	kConfigStatusPresent		= $00000002;
	kPinReplacePresent			= $00000004;
	kSocketCopyPresent			= $00000008;
	kExtendedStatusPresent		= $00000010;
	kIOBase0Present				= $00000020;
	kIOBase1Present				= $00000040;
	kIOBase2Present				= $00000080;
	kIOBase3Present				= $00000100;
	kIOLimitPresent				= $00000200;


TYPE
	PCCardConfigPresentMask				= UInt32;
	PCCardConfigRegisterIndex			= UInt32;
	PCCardConfigRegisterOffset			= UInt32;
	PCCardFunctionConfigRegPtr = ^PCCardFunctionConfigReg;
	PCCardFunctionConfigReg = RECORD
		configOptionReg:		SInt8;
		configStatusReg:		SInt8;
		pinReplaceReg:			SInt8;
		socketCopyReg:			SInt8;
		extendedStatusReg:		SInt8;
		ioBase0:				SInt8;
		ioBase1:				SInt8;
		ioBase2:				SInt8;
		ioBase3:				SInt8;
		ioLimit:				SInt8;
	END;

	PCCardSocketStatus					= OptionBits;
{	general socket status bits (values of PCCardSocketStatus) }

CONST
	kSTBatteryDead				= $0001;						{  battery dead }
	kSTBatteryLow				= $0002;						{  battery low }
	kSTBatteryGood				= $0004;						{  battery good }
	kSTPower					= $0008;						{  power is applied }
	kST16bit					= $0010;						{  16-bit PC Card present }
	kSTCardBus					= $0020;						{  CardBus PC Card present }
	kSTMemoryCard				= $0040;						{  memory card present }
	kSTIOCard					= $0080;						{  I/O card present }
	kSTNotACard					= $0100;						{  unrecognizable PC Card detected }
	kSTReady					= $0200;						{  ready }
	kSTWriteProtect				= $0400;						{  card is write-protected }
	kSTDataLost					= $0800;						{  data may have been lost due to card removal }
	kSTRingIndicate				= $1000;						{  ring indicator is active }
	kSTReserved					= $E000;

{ Bit mask for PCCardPowerOptions in the power management calls }

TYPE
	PCCardPowerOptions					= OptionBits;

CONST
	kPCCardPowerOn				= $00000001;
	kPCCardPowerOff				= $00000002;
	kPCCardLowPower				= $00000004;


TYPE
	PCCardAdapterCapabilities			= OptionBits;
	PCCardAdapterPowerState				= UInt32;
	PCCardSCEvents						= OptionBits;
	PCCardWindow						= UInt32;
	PCCardIRQ							= UInt32;
	PCCardDMA							= UInt32;
{ Selectors for PCCardGetGlobalOptions }
{	The type of the "value" parameter is provided for each selector. }
	PCCardOptionSelector				= UInt32;

CONST
	kPCCardPowerManagementAttrib = 1;							{  value = (Boolean*) enabled   }



{  Types and structures for accessing the PCCard Assigned-Address property. }

	kPCCardNonRelocatableSpace	= $80;
	kPCCardPrefetchableSpace	= $40;
	kPCCard16BitSpace			= $20;
	kPCCardAddressTypeCodeMask	= $07;
	kPCCardConfigSpace			= 0;
	kPCCardIOSpace				= 1;
	kPCCardMemorySpace			= 2;
	kPCCardAttributeMemorySpace	= 4;


TYPE
	PCCardAddressSpaceFlags				= UInt8;

CONST
	kPCCardSocketNumberMask		= $F8;
	kPCCardFunctionNumberMask	= $07;


TYPE
	PCCardSocketFunction				= UInt8;
	PCCardBusNumber						= UInt8;
	PCCardRegisterNumber				= UInt8;
{
   note: this structure is similar, but not the same as the PCIAssignedAddress structure
         16-bit cards use this structure, CardBus cards use PCIAssignedAddress
}
	PCCardAssignedAddressPtr = ^PCCardAssignedAddress;
	PCCardAssignedAddress = PACKED RECORD
		addressSpaceFlags:		PCCardAddressSpaceFlags;
		reserved:				UInt8;
		socketFunctionNumber:	PCCardSocketFunction;
		registerNumber:			PCCardRegisterNumber;
		address:				UInt32;
		size:					UInt32;
	END;

{----------------------------------------------------------------------
	Client Support
----------------------------------------------------------------------}
{ Prototype for client callback }
	PCCardEventHandler = ProcPtr;  { FUNCTION PCCardEventHandler(theEvent: PCCardEvent; vSocket: PCCardSocket; device: UInt32; info: UInt32; MTDRequest: UInt32; VAR Buffer: UInt32; misc: UInt32; status: UInt32; clientParam: UNIV Ptr): OSStatus; C; }

FUNCTION PCCardRegisterClient({CONST}VAR deviceRef: RegEntryID; eventMask: PCCardEventMask; clientCallBack: PCCardEventHandler; clientParam: UNIV Ptr; VAR newClientID: PCCardClientID): OSStatus; C;
FUNCTION PCCardDeRegisterClient(theClientID: PCCardClientID): OSStatus; C;
FUNCTION PCCardRegisterTimer(registeredClientID: PCCardClientID; VAR lpNewTimerID: PCCardTimerID; delay: LONGINT): OSStatus; C;
PROCEDURE PCCardDeRegisterTimer(timerID: PCCardTimerID); C;
FUNCTION PCCardSetEventMask(theClientID: PCCardClientID; newEventMask: PCCardEventMask): OSStatus; C;
FUNCTION PCCardGetEventMask(theClientID: PCCardClientID; VAR newEventMask: PCCardEventMask): OSStatus; C;
FUNCTION PCCardGetCardServicesInfo(VAR socketCount: ItemCount; VAR complianceLevel: UInt32; VAR version: UInt32): OSStatus; C;
FUNCTION PCCardGetSocketRef(vSocket: PCCardSocket; VAR socketRef: RegEntryID): OSStatus; C;
FUNCTION PCCardGetCardRef(vSocket: PCCardSocket; VAR cardRef: RegEntryID): OSStatus; C;
FUNCTION PCCardGetDeviceRef(vSocket: PCCardSocket; device: UInt32; VAR deviceRef: RegEntryID): OSStatus; C;
FUNCTION PCCardGetSocketAndDeviceFromDeviceRef({CONST}VAR deviceRef: RegEntryID; VAR vSocket: PCCardSocket; VAR device: UInt32): OSStatus; C;
FUNCTION PCCardGetCardRefFromDeviceRef({CONST}VAR deviceRef: RegEntryID; VAR cardRef: RegEntryID): OSStatus; C;

{----------------------------------------------------------------------
	Resource Management
----------------------------------------------------------------------}
FUNCTION PCCardRequestWindow({CONST}VAR deviceRef: RegEntryID; windowAttributes: PCCardWindowAttributes; VAR windowBase: LogicalAddress; VAR windowSize: ByteCount; VAR windowSpeed: PCCardAccessSpeed; VAR windowOffset: PCCardWindowOffset; VAR windowID: PCCardWindowID): OSStatus; C;
FUNCTION PCCardModifyWindow(windowID: PCCardWindowID; windowAttributes: PCCardWindowAttributes; windowSpeed: PCCardAccessSpeed; windowOffset: PCCardWindowOffset): OSStatus; C;
FUNCTION PCCardReleaseWindow(windowID: PCCardWindowID): OSStatus; C;
FUNCTION PCCardInquireWindow({CONST}VAR deviceRef: RegEntryID; windowID: PCCardWindowID; VAR windowAttributes: PCCardWindowAttributes; VAR windowBase: LogicalAddress; VAR windowSize: ByteCount; VAR windowSpeed: PCCardAccessSpeed; VAR windowOffset: PCCardWindowOffset): OSStatus; C;
FUNCTION PCCardGetStatus({CONST}VAR deviceRef: RegEntryID; VAR currentState: UInt32; VAR changedState: UInt32; VAR Vcc: PCCardVoltage; VAR Vpp: PCCardVoltage): OSStatus; C;
FUNCTION PCCardRequestConfiguration({CONST}VAR deviceRef: RegEntryID; configOptions: PCCardConfigOptions; ifType: PCCardInterfaceType; ifCustomType: PCCardCustomInterfaceID; vcc: PCCardVoltage; vpp: PCCardVoltage; configRegistersBase: LogicalAddress; configRegistersPresent: PCCardConfigPresentMask; VAR configRegisterValues: PCCardFunctionConfigReg): OSStatus; C;
FUNCTION PCCardReleaseConfiguration({CONST}VAR deviceRef: RegEntryID): OSStatus; C;
FUNCTION PCCardModifyConfiguration({CONST}VAR deviceRef: RegEntryID; configOptions: PCCardConfigOptions; vpp: PCCardVoltage): OSStatus; C;
FUNCTION PCCardReadConfigurationRegister({CONST}VAR deviceRef: RegEntryID; whichRegister: PCCardConfigRegisterIndex; offset: PCCardConfigRegisterOffset; VAR value: UInt8): OSStatus; C;
FUNCTION PCCardWriteConfigurationRegister({CONST}VAR deviceRef: RegEntryID; whichRegister: PCCardConfigRegisterIndex; offset: PCCardConfigRegisterOffset; value: ByteParameter): OSStatus; C;
FUNCTION PCCardResetFunction({CONST}VAR deviceRef: RegEntryID): OSStatus; C;
{----------------------------------------------------------------------
	Client Utilities
----------------------------------------------------------------------}

TYPE
	PCCardTupleKind						= UInt8;
	PCCardTupleIterator = ^LONGINT;
FUNCTION PCCardNewTupleIterator: PCCardTupleIterator; C;
FUNCTION PCCardDisposeTupleIterator(tupleIterator: PCCardTupleIterator): OSStatus; C;
FUNCTION PCCardGetFirstTuple({CONST}VAR deviceID: RegEntryID; desiredTuple: ByteParameter; tupleIterator: PCCardTupleIterator; dataBuffer: UNIV Ptr; VAR dataBufferSize: UInt32; VAR foundTuple: PCCardTupleKind; VAR foundTupleDataSize: UInt32): OSStatus; C;
FUNCTION PCCardGetNextTuple({CONST}VAR deviceRef: RegEntryID; desiredTuple: ByteParameter; tupleIterator: PCCardTupleIterator; dataBuffer: UNIV Ptr; VAR dataBufferSize: UInt32; VAR foundTuple: PCCardTupleKind; VAR foundTupleDataSize: UInt32): OSStatus; C;
{----------------------------------------------------------------------
	Miscellaneous
----------------------------------------------------------------------}
FUNCTION PCCardEject({CONST}VAR cardRef: RegEntryID): OSStatus; C;
FUNCTION PCCardEnableModemSound({CONST}VAR cardRef: RegEntryID; enableSound: BOOLEAN): OSStatus; C;
FUNCTION PCCardEnableZoomedVideoSound({CONST}VAR cardRef: RegEntryID; enableSound: BOOLEAN): OSStatus; C;
FUNCTION PCCardSetPowerLevel({CONST}VAR deviceRef: RegEntryID; powerLevel: PCCardPowerOptions): OSStatus; C;
FUNCTION PCCardSetRingIndicate({CONST}VAR deviceRef: RegEntryID; setRingIndicate: BOOLEAN): OSStatus; C;
FUNCTION PCCardGetGlobalOptions(selector: PCCardOptionSelector; value: UNIV Ptr): OSStatus; C;

TYPE
	PCCardDevType						= UInt32;
	PCCardSubType						= UInt32;
{  values for PCCardType and PCCardSubType }

CONST
	kPCCardUnknownType			= 0;
	kPCCardMultiFunctionType	= 1;
	kPCCardMemoryType			= 2;
	kPCCardNullSubType			= 0;							{  Memory sub types  }
	kPCCardRomSubType			= 1;
	kPCCardOTPromSubType		= 2;
	kPCCardEpromSubType			= 3;
	kPCCardEEpromSubType		= 4;
	kPCCardFlashSubType			= 5;
	kPCCardSramSubType			= 6;
	kPCCardDramSubType			= 7;
	kPCCardSerialPortType		= 3;
	kPCCardSerialOnlySubType	= 0;
	kPCCardDataModemSubType		= 1;
	kPCCardFaxModemSubType		= 2;
	kPCCardFaxAndDataModemMask	= 3;
	kPCCardVoiceEncodingSubType	= 4;
	kPCCardParallelPortType		= 4;
	kPCCardFixedDiskType		= 5;
	kPCCardUnknownFixedDiskType	= 0;
	kPCCardATAInterfaceDiskSubType = 1;
	kPCCardRotatingDeviceSubType = $00;
	kPCCardSiliconDevice		= $80;
	kPCCardVideoAdaptorType		= 6;
	kPCCardNetworkAdaptorType	= 7;
	kPCCardArcNetSubType		= 1;							{  network sub types  }
	kPCCardEthernetSubType		= 2;
	kPCCardTokenRingSubType		= 3;
	kPCCardLocalTalkSubType		= 4;
	kPCCardFDDI_CDDISubType		= 5;
	kPCCardATMSubType			= 6;
	kPCCardWirelessSubType		= 7;
	kPCCardAIMSType				= 8;
	kPCCardSCSIType				= 9;

FUNCTION PCCardGetCardInfo({CONST}VAR cardRef: RegEntryID; VAR cardType: PCCardDevType; VAR cardSubType: PCCardSubType; cardName: StringPtr; vendorName: StringPtr): OSStatus; C;

CONST
	kPCCard16HardwareType		= 'pc16';
	kCardBusHardwareType		= 'cdbs';


TYPE
	PCCardHardwareType					= UInt32;
FUNCTION PCCardGetCardType({CONST}VAR socketRef: RegEntryID; VAR cardType: PCCardHardwareType): OSStatus; C;
{ error codes }

CONST
	kBadAdapterErr				= -9050;						{  invalid adapter number }
	kBadAttributeErr			= -9051;						{  specified attributes field value is invalid }
	kBadBaseErr					= -9052;						{  specified base system memory address is invalid }
	kBadEDCErr					= -9053;						{  specified EDC generator specified is invalid }
	kBadIRQErr					= -9054;						{  specified IRQ level is invalid }
	kBadOffsetErr				= -9055;						{  specified PC card memory array offset is invalid }
	kBadPageErr					= -9056;						{  specified page is invalid }
	kBadSizeErr					= -9057;						{  specified size is invalid }
	kBadSocketErr				= -9058;						{  specified logical or physical socket number is invalid }
	kBadTypeErr					= -9059;						{  specified window or interface type is invalid }
	kBadVccErr					= -9060;						{  specified Vcc power level index is invalid }
	kBadVppErr					= -9061;						{  specified Vpp1 or Vpp2 power level index is invalid }
	kBadWindowErr				= -9062;						{  specified window is invalid }
	kBadArgLengthErr			= -9063;						{  ArgLength argument is invalid }
	kBadArgsErr					= -9064;						{  values in argument packet are invalid }
	kBadHandleErr				= -9065;						{  clientHandle is invalid }
	kBadCISErr					= -9066;						{  CIS on card is invalid }
	kBadSpeedErr				= -9067;						{  specified speed is unavailable }
	kReadFailureErr				= -9068;						{  unable to complete read request }
	kWriteFailureErr			= -9069;						{  unable to complete write request }
	kGeneralFailureErr			= -9070;						{  an undefined error has occurred }
	kNoCardErr					= -9071;						{  no PC card in the socket }
	kUnsupportedFunctionErr		= -9072;						{  function is not supported by this implementation }
	kUnsupportedModeErr			= -9073;						{  mode is not supported }
	kBusyErr					= -9074;						{  unable to process request at this time - try later }
	kWriteProtectedErr			= -9075;						{  media is write-protected }
	kConfigurationLockedErr		= -9076;						{  a configuration has already been locked }
	kInUseErr					= -9077;						{  requested resource is being used by a client }
	kNoMoreItemsErr				= -9078;						{  there are no more of the requested item }
	kOutOfResourceErr			= -9079;						{  Card Services has exhausted the resource }
	kNoCardSevicesSocketsErr	= -9080;
	kInvalidRegEntryErr			= -9081;
	kBadLinkErr					= -9082;
	kBadDeviceErr				= -9083;
	k16BitCardErr				= -9084;
	kCardBusCardErr				= -9085;
	kPassCallToChainErr			= -9086;
	kCantConfigureCardErr		= -9087;
	kPostCardEventErr			= -9088;						{  _PCCSLPostCardEvent failed and dropped an event  }
	kInvalidDeviceNumber		= -9089;
	kUnsupportedVsErr			= -9090;						{  Unsupported Voltage Sense  }
	kInvalidCSClientErr			= -9091;						{  Card Services ClientID is not registered  }
	kBadTupleDataErr			= -9092;						{  Data in tuple is invalid  }
	kBadCustomIFIDErr			= -9093;						{  Custom interface ID is invalid  }
	kNoIOWindowRequestedErr		= -9094;						{  Request I/O window before calling configuration  }
	kNoMoreTimerClientsErr		= -9095;						{  All timer callbacks are in use  }
	kNoMoreInterruptSlotsErr	= -9096;						{  All internal Interrupt slots are in use  }
	kNoClientTableErr			= -9097;						{  The client table has not be initialized yet  }
	kUnsupportedCardErr			= -9098;						{  Card not supported by generic enabler }
	kNoCardEnablersFoundErr		= -9099;						{  No Enablers were found }
	kNoEnablerForCardErr		= -9100;						{  No Enablers were found that can support the card }
	kNoCompatibleNameErr		= -9101;						{  There is no compatible driver name for this device }
	kClientRequestDenied		= -9102;						{  CS Clients should return this code inorder to  }
																{    deny a request-type CS Event                 }
	kNotReadyErr				= -9103;						{  PC Card failed to go ready  }
	kTooManyIOWindowsErr		= -9104;						{  device requested more than one I/O window  }
	kAlreadySavedStateErr		= -9105;						{  The state has been saved on previous call  }
	kAttemptDupCardEntryErr		= -9106;						{  The Enabler was asked to create a duplicate card entry  }
	kCardPowerOffErr			= -9107;						{  Power to the card has been turned off  }
	kNotZVCapableErr			= -9108;						{  This socket does not support Zoomed Video  }
	kNoCardBusCISErr			= -9109;						{  No valid CIS exists for this CardBus card  }

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCCardIncludes}

{$ENDC} {__PCCARD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
