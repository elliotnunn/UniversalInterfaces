{
     File:       ATA.p
 
     Contains:   ATA (PC/AT Attachment) Interfaces
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ATA;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ATA__}
{$SETC __ATA__ := 1}

{$I+}
{$SETC ATAIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{ This is the structure used for the AT Interface core routines below }

CONST
	kATATrap					= $AAF1;						{  Manager trap number <This should be defined in Traps.h> }
	kATAPBVers1					= $01;							{  parameter block version number 1 }
	kATAPBVers2					= $02;							{  parameter block version number for structures }
	kATAPBVers3					= $03;							{  parameter block version for ATA times }
	kATADefaultBlockSize		= 512;							{  default block size }

	{  Used to determine the presence of traps }
	kFSMTrap					= $AC;
	mDQEChanged					= 1;							{  DQE has changed  }

	{  Task file definition ••• Error Register ••• }
	bATABadBlock				= 7;							{  bit number of bad block error bit }
	bATAUncorrectable			= 6;							{  bit number of uncorrectable error bit }
	bATAMediaChanged			= 5;							{  bit number of media changed indicator }
	bATAIDNotFound				= 4;							{  bit number of ID not found error bit }
	bATAMediaChangeReq			= 3;							{  bit number of media changed request }
	bATACommandAborted			= 2;							{  bit number of command abort bit }
	bATATrack0NotFound			= 1;							{  bit number of track not found }
	bATAAddressNotFound			= 0;							{  bit number of address mark not found }
	mATABadBlock				= $80;							{  Bad Block Detected }
	mATAUncorrectable			= $40;							{  Uncorrectable Data Error }
	mATAMediaChanged			= $20;							{  Media Changed Indicator (for removable) }
	mATAIDNotFound				= $10;							{  ID Not Found }
	mATAMediaChangeReq			= $08;							{  Media Change Requested (NOT IMPLEMENTED) }
	mATACommandAborted			= $04;							{  Aborted Command }
	mATATrack0NotFound			= $02;							{  Track 0 Not Found }
	mATAAddressNotFound			= $01;							{  Address Mark Not Found }

	{  Task file definition ••• Features register ••• }
	bATAPIuseDMA				= 0;							{  bit number of useDMA bit (ATAPI) }
	mATAPIuseDMA				= $01;

	{  Task file definition ••• ataTFSDH Register ••• }
	mATAHeadNumber				= $0F;							{  Head Number (bits 0-3)  }
	mATASectorSize				= $A0;							{  bit 7=1; bit 5 = 01 (512 sector size) <DP4> }
	mATADriveSelect				= $10;							{  Drive (0 = master, 1 = slave)  }
	mATALBASelect				= $40;							{  LBA mode bit (0 = chs, 1 = LBA) }

	{  Task file definition ••• Status Register ••• }
	bATABusy					= 7;							{  bit number of BSY bit }
	bATADriveReady				= 6;							{  bit number of drive ready bit }
	bATAWriteFault				= 5;							{  bit number of write fault bit }
	bATASeekComplete			= 4;							{  bit number of seek complete bit }
	bATADataRequest				= 3;							{  bit number of data request bit }
	bATADataCorrected			= 2;							{  bit number of data corrected bit }
	bATAIndex					= 1;							{  bit number of index mark }
	bATAError					= 0;							{  bit number of error bit }
	mATABusy					= $80;							{  Unit is busy }
	mATADriveReady				= $40;							{  Unit is ready }
	mATAWriteFault				= $20;							{  Unit has a write fault condition }
	mATASeekComplete			= $10;							{  Unit seek complete }
	mATADataRequest				= $08;							{  Unit data request }
	mATADataCorrected			= $04;							{  Data corrected }
	mATAIndex					= $02;							{  Index mark - NOT USED }
	mATAError					= $01;							{  Error condition - see error register }

	{  Task file definition ••• Device Control Register ••• }
	bATADCROne					= 3;							{  bit number of always one bit }
	bATADCRReset				= 2;							{  bit number of reset bit }
	bATADCRnIntEnable			= 1;							{  bit number of interrupt disable }
	mATADCROne					= $08;							{  always one bit }
	mATADCRReset				= $04;							{  Reset (1 = reset) }
	mATADCRnIntEnable			= $02;							{  Interrupt Disable(0 = enabled) }

	{  ATA Command Opcode definition }
	kATAcmdWORetry				= $01;							{  Without I/O retry option }
	kATAcmdNOP					= $0000;						{  NOP operation - media detect }
	kATAcmdRecal				= $0010;						{  Recalibrate command  }
	kATAcmdRead					= $0020;						{  Read command  }
	kATAcmdReadLong				= $0022;						{  Read Long command }
	kATAcmdWrite				= $0030;						{  Write command  }
	kATAcmdWriteLong			= $0032;						{  Write Long }
	kATAcmdWriteVerify			= $003C;						{  Write verify }
	kATAcmdReadVerify			= $0040;						{  Read Verify command  }
	kATAcmdFormatTrack			= $0050;						{  Format Track command  }
	kATAcmdSeek					= $0070;						{  Seek command  }
	kATAcmdDiagnostic			= $0090;						{  Drive Diagnostic command  }
	kATAcmdInitDrive			= $0091;						{  Init drive parameters command  }
	kATAcmdReadMultiple			= $00C4;						{  Read multiple }
	kATAcmdWriteMultiple		= $00C5;						{  Write multiple }
	kATAcmdSetRWMultiple		= $00C6;						{  Set Multiple for Read/Write Multiple }
	kATAcmdReadDMA				= $00C8;						{  Read DMA (with retries) }
	kATAcmdWriteDMA				= $00CA;						{  Write DMA (with retries) }
	kATAcmdMCAcknowledge		= $00DB;						{  Acknowledge media change - removable }
	kATAcmdDoorLock				= $00DE;						{  Door lock }
	kATAcmdDoorUnlock			= $00DF;						{  Door unlock }
	kATAcmdStandbyImmed			= $00E0;						{  Standby Immediate }
	kATAcmdIdleImmed			= $00E1;						{  Idle Immediate }
	kATAcmdStandby				= $00E2;						{  Standby }
	kATAcmdIdle					= $00E3;						{  Idle }
	kATAcmdReadBuffer			= $00E4;						{  Read sector buffer command  }
	kATAcmdCheckPowerMode		= $00E5;						{  Check power mode command   <04/04/94> }
	kATAcmdSleep				= $00E6;						{  Sleep }
	kATAcmdWriteBuffer			= $00E8;						{  Write sector buffer command  }
	kATAcmdWriteSame			= $00E9;						{  Write same data to multiple sectors }
	kATAcmdDriveIdentify		= $00EC;						{  Identify Drive command  }
	kATAcmdMediaEject			= $00ED;						{  Media Eject }
	kATAcmdSetFeatures			= $00EF;						{  Set Features }

	{  Set feature command opcodes }
	kATAEnableWriteCache		= $02;							{        Enable write cache }
	kATASetTransferMode			= $03;							{        Set transfer mode }
	kATASetPIOMode				= $08;							{        PIO Flow Control Tx Mode bit }
	kATAEnableECC				= $88;							{        ECC enable }
	kATAEnableRetry				= $99;							{        Retry enable }
	kATAEnableReadAhead			= $AA;							{        Read look-ahead enable }

	{
	  --------------------------------------------------------------------------------
	   enums for dealing with device IDs
	}

	kATABusIDMask				= $000000FF;
	kATADeviceIDMask			= $0000FF00;
	kATADeviceIDClippingMask	= $0000FFFF;
	kMinBusID					= $00000000;
	kMaxBusID					= $000000FE;

	kATAStartIterateDeviceID	= $FFFF;
	kATAEndIterateDeviceID		= $FF;

	{ -------------------------------------------------------------------------------- }
	{	 Device Register Images  (8 bytes) 	}

TYPE
	ataTaskFilePtr = ^ataTaskFile;
	ataTaskFile = RECORD
		ataTFFeatures:			SInt8;									{  <-> Error(R) or ataTFFeatures(W) register image  }
		ataTFCount:				SInt8;									{  <-> Sector count/remaining  }
		ataTFSector:			SInt8;									{  <-> Sector start/finish  }
		ataTFReserved:			SInt8;									{  reserved              }
		ataTFCylinder:			UInt16;									{  <-> ataTFCylinder (Big endian)  }
		ataTFSDH:				SInt8;									{  <-> ataTFSDH register image }
		ataTFCommand:			SInt8;									{  <-> Status(R) or Command(W) register image  }
	END;

	{  ATA Manager Function Code Definition }

CONST
	kATAMgrNOP					= $00;							{  No Operation }
	kATAMgrExecIO				= $01;							{  Execute ATA I/O }
	kATAMgrBusInquiry			= $03;							{  Bus Inquiry }
	kATAMgrQRelease				= $04;							{  I/O Queue Release }
	kATAMgrAbort				= $10;							{  Abort command }
	kATAMgrBusReset				= $11;							{  Reset ATA bus }
	kATAMgrRegAccess			= $12;							{  Register Access }
	kATAMgrDriveIdentify		= $13;							{  Drive Identify        <DP03/10/94> }
	kATAMgrDriverLoad			= $82;							{  Load driver from either Media, ROM, etc. }
	kATAMgrDriveRegister		= $85;							{  Register a driver   <4/18/94> }
	kATAMgrFindDriverRefnum		= $86;							{  lookup a driver refnum <4/18/94> }
	kATAMgrRemoveDriverRefnum	= $87;							{  De-register a driver   <4/18/94> }
	kATAMgrModifyEventMask		= $88;							{  Modify driver event mask }
	kATAMgrDriveEject			= $89;							{  Eject the drive       <8/1/94> }
	kATAMgrGetDrvConfiguration	= $8A;							{  Get device configuration   <8/6/94> }
	kATAMgrSetDrvConfiguration	= $8B;							{  Set device configuration <8/6/94> }
	kATAMgrGetLocationIcon		= $8C;							{  Get card location icon <SM4> }
	kATAMgrManagerInquiry		= $90;							{  Manager Inquiry }
	kATAMgrManagerInit			= $91;							{  Manager initialization }
	kATAMgrManagerShutdown		= $92;							{  Manager ShutDown }
	kATAMgrAddATABus			= $93;							{  Add an AIM to ATA Manager  <3/1/2000> }
	kATAMgrRemoveATABus			= $94;							{  Remove an AIM from ATA Manager <3/1/2000> }
																{  note: functions 0x95 to 0x97 are reserved }
	kATAMgrFindSpecialDriverRefnum = $98;						{  lookup a driver refnum; driverloader,notify-all or ROM driver. }
	kATAMgrNextAvailable		= $99;

	{  used in the ataDrvrFlags field for kATAMgrDriveRegister,kATAMgrRemoveDriverRefnum & kATAMgrFindSpecialDriverRefnum }
	kATANotifyAllDriver			= 0;							{  Notify-All driver }
	kATADriverLoader			= 1;							{  Driver loader driver      }
	kATAROMDriver				= 2;							{  ROM driver }

	{  'ATAFlags' field of the PB header definition }
	bATAFlagUseConfigSpeed		= 15;							{  bit number of use default speed flag }
	bATAFlagByteSwap			= 14;							{  bit number of byte swap flag }
	bATAFlagIORead				= 13;							{  bit number of I/O read flag }
	bATAFlagIOWrite				= 12;							{  bit number of I/O write flag }
	bATAFlagImmediate			= 11;							{  bit number of immediate flag }
	bATAFlagQLock				= 10;							{  bit number of que lock on error }
	bATAFlagReserved1			= 9;							{  reserved }
	bATAFlagUseScatterGather	= 8;							{  bit numbers of scatter gather }
	bATAFlagUseDMA				= 7;							{  bit number of use DMA flag }
	bATAFlagProtocolATAPI		= 5;							{  bit number of ATAPI protocol }
	bATAFlagReserved2			= 4;							{  reserved }
	bATAFlagTFRead				= 3;							{  bit number of register update }
	bATAFlagLEDEnable			= 0;							{  bit number of LED enable }
	mATAFlagUseConfigSpeed		= $8000;
	mATAFlagByteSwap			= $4000;						{  Swap data bytes (read - after; write - before) }
	mATAFlagIORead				= $2000;						{  Read (in) operation }
	mATAFlagIOWrite				= $1000;						{  Write (out) operation }
	mATAFlagImmediate			= $0800;						{  Head of Que; Immediate operation }
	mATAFlagQLock				= $0400;						{  Manager queue lock on error (freeze the queue) }
	mATAFlagUseScatterGather	= $0100;						{  Scatter gather enable }
	mATAFlagUseDMA				= $80;
	mATAFlagProtocolATAPI		= $20;							{  ATAPI protocol indicator }
	mATAFlagTFRead				= $08;							{  update reg block request upon detection of an error }
	mATAFlagLEDEnable			= $01;							{  socket LED enable }

	{	 These are legacy ATAFlags definitions, which will go away in the future 	}
	bATAFlagScatterGather1		= 9;							{  9 }
	bATAFlagScatterGather0		= 8;							{  8 }
	bATAFlagProtocol1			= 5;							{  5 }
	bATAFlagProtocol0			= 4;							{  4 }
	mATAFlagScatterGather1		= $0200;
	mATAFlagScatterGather0		= $0100;
	mATAFlagScatterGathers		= $0300;
	mATAFlagProtocol1			= $20;
	mATAFlagProtocol0			= $10;
	mATAFlagProtocols			= $30;

	{	 The Function codes passed by ATA Manager to the AIM plug-in 	}
	kATAFnNOP					= $00;							{  No Operation  }
	kATAFnExecIO				= $01;							{  Execute ATA I/O  }
	kATAFnBusInquiry			= $02;							{  Bus Inquiry  }
	kATAFnQRelease				= $03;							{  I/O Queue Release  }
	kATAFnCmd					= $04;							{  ATA Command  }
	kATAFnAbort					= $05;							{  Abort command  }
	kATAFnBusReset				= $06;							{  Reset ATA bus  }
	kATAFnRegAccess				= $07;							{  Register Access  }
	kATAFnDriveIdentify			= $08;							{  Drive Identify  }
	kATAPIFnExecIO				= $09;							{  ATAPI I/O  }
	kATAPIFnCmd					= $0A;							{  ATAPI Command  }
	kATAFnGetDriveConfig		= $0B;							{  Get Drive specific bus configuration  }
	kATAFnSetDriveConfig		= $0C;							{  Set Drive specific bus configuration  }
	kATAFnKillIO				= $0D;							{  Kill any current interaction with bus  }

	{	 The state to put the device light in used in DeviceLight AIM plugin export 	}
	kATADeviceLightOff			= $00;							{  Turn light off  }
	kATADeviceLightOn			= $01;							{  Turn light on  }

	{	 The state to put the device lock in used in DeviceLock AIM plugin export 	}
	kATADeviceUnlock			= $00;							{  unlock  }
	kATADeviceLock				= $01;							{  lock  }


	{	 add bus flags 	}
	{	 •• Applies to the ataAddBus structure •• 	}
	mATANoDMAOnBus				= $80;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATACallbackProcPtr = PROCEDURE(ataPB: UNIV Ptr);
{$ELSEC}
	ATACallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ATACallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATACallbackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppATACallbackProcInfo = $000000C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewATACallbackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewATACallbackUPP(userRoutine: ATACallbackProcPtr): ATACallbackUPP; { old name was NewATACallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeATACallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeATACallbackUPP(userUPP: ATACallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeATACallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeATACallbackUPP(ataPB: UNIV Ptr; userRoutine: ATACallbackUPP); { old name was CallATACallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
   
   structure which defines the ATA bus/device ID, part of the Device 0/1 Software Guide
   see <http://developer.apple.com/techpubs/hardware/Developer_Notes/System_Software/ATA_Device_Zero_One.pdf>
   p 19 :   Although ataPBDeviceID remains defined as a 32-bit number, drivers and applications
            can typecast it to the ataDeviceID structure to determine the bus number and device number
            for a specific ATA or ATAPI device
}

TYPE
	ataDeviceIDPtr = ^ataDeviceID;
	ataDeviceID = RECORD
		Reserved:				UInt16;									{  The upperword is reserved (0) }
		devNum:					SInt8;									{  device number (0 or 1) }
		busNum:					SInt8;									{  bus number }
	END;

	{
	   The kATADevIDProperty property will be inserted by the AIM when creating name registry entries for each 
	   drive found on the bus. The 4-byte data shall be the ataDeviceID structure used by ATA Manager. <3/14/2000>
	}

CONST
	kATADevIDPropertyNameLength	= 10;							{  Number of characters in kATADevIDProperty including the terminating null. }
	kATADevIDPropertySize		= 4;							{  Size of the data }


TYPE
	ATADataObjectPtr = ^ATADataObject;
	ATADataObject = RECORD
		ioBuf:					Ptr;									{  if SG flag enabled then this points to the head of the list else it is the buffer  }
		Count:					UInt32;									{  if SG flag enabled then count of SG Lists else the size  }
	END;

	ATAResultPtr = ^ATAResult;
	ATAResult = RECORD
		ataResult:				OSStatus;								{  the final result see Error Codes  }
		ataStatusRegister:		SInt8;									{  the status register  }
		ataErrorRegister:		SInt8;									{  the error register  }
		actualXferCount:		UInt32;									{  in case of I/O the actual size of Xfer  }
		TaskFile:				ataTaskFilePtr;							{  if "mATAFlagTFRead" enabled  }
	END;

	{
	   For ATAPI devices the ExtendedPB field is a pointer to the Command Packet
	   record which exists of an array of words structured as follows…  <06/15/94>
	}
	ATAPICmdPacketPtr = ^ATAPICmdPacket;
	ATAPICmdPacket = RECORD
		atapiPacketSize:		SInt16;									{  Size of command packet in bytes    <06/15/94> }
		atapiCommandByte:		ARRAY [0..7] OF SInt16;					{  The command packet itself  <06/15/94> }
	END;

	ATADevInfoPtr = ^ATADevInfo;
	ATADevInfo = RECORD
		devType:				SInt8;
		devID:					SInt8;
	END;

	{	 ATA Device ID codes to be used with devID field of the ATADevInfo structure 	}

CONST
	kATAInvalidDeviceID			= -1;
	kATADevice0DeviceID			= 0;							{  aka, Master. Device 0 is the correct terminology  }
	kATADevice1DeviceID			= 1;							{  aka, Slave. Device 1 is the correct terminology  }

	{	 AIM initialization 	}

TYPE
	ATAInitInfoPtr = ^ATAInitInfo;
	ATAInitInfo = RECORD
		busID:					UInt32;									{  --> busID assigned by the Manager  }
		FirstDevice:			ATADevInfo;								{  <-- Type and ID of first device  }
		SecondDevice:			ATADevInfo;								{  <-- Type and ID of second device  }
		aimRegEntry:			RegEntryIDPtr;							{  --> Name Registry entry for this controller  }
		refCon:					UInt32;									{  <-- refCon to be associated with this instantiation of the AIM  }
	END;

	{	 AIM Diag result 	}
	ATADiagResultPtr = ^ATADiagResult;
	ATADiagResult = RECORD
		ataRegMask:				UInt16;									{  the registers to access  }
		ataResult:				OSStatus;								{  the final result see Error Codes  }
		ataDataReg:				UInt16;									{  16 bit access only  }
		ataTFFeatures:			SInt8;									{  Error(R)  or Feature(W) register  }
		ataTFCount:				SInt8;									{  Sector Count register  }
		ataTFSector:			SInt8;									{  Sector number register  }
		ataTFCylinderLo:		SInt8;									{  Cylinder low bytes   }
		ataTFCylinderHi:		SInt8;									{  Cylinder High bytes   }
		ataTFSDH:				SInt8;									{  SDH register  }
		ataTFCommand:			SInt8;									{  status(R) or command(W) register  }
		ataAltStatDevCnt:		SInt8;									{  AltStatus(R) or Dev Cntrl(W) register  }
	END;

	{	 AIM Bus Info 	}
	ATABusInfoPtr = ^ATABusInfo;
	ATABusInfo = RECORD
		ataPIOModes:			SInt8;									{  PIO modes supported (bit-significant)  }
		ataSingleDMAModes:		SInt8;									{  <--: Single Word DMA modes supported (b-sig)     }
		ataMultiDMAModes:		SInt8;									{  <--: Multiword DMA modes supported (b-sig)  }
		ataUltraDMAModes:		SInt8;									{  <--: Ultra DMA modes supported (b-sig)  }
		ataIOPBsize0:			UInt32;									{  the current size of the Transfer for device 0  }
		ataIOPBsize1:			UInt32;									{  the current size of the Transfer for device 1  }
		ataContrlType:			ARRAY [0..15] OF SInt8;					{  the controller signature  }
		ataHBAversion:			NumVersion;								{  version number of the AIM  }
		reserved3:				UInt32;
	END;

	{  reserved words at the end of the devConfig structure }

CONST
	kATAConfigReserved			= 5;							{  number of reserved words at the end }


	{	 Bus timing config info passed between ATA Mgr and the AIM 	}

TYPE
	ATADevConfigPtr = ^ATADevConfig;
	ATADevConfig = RECORD
		ataConfigSetting:		SInt32;									{  <->: Configuration setting   }
																		{       Bits 3 - 0: Reserved  }
																		{       Bit 4: Reserved   }
																		{       Bit 5: Reserved   }
																		{       Bit 6: ATAPIpacketDRQ  }
																		{        1 = Check for Interrupt DRQ on ATAPI command packet DRQ  }
																		{        0 = Default: Check only for the assertion of command packet DRQ  }
																		{       Bits 31 - 7: Reserved  }
		ataPIOSpeedMode:		SInt8;									{  <->: Device access speed in PIO Mode  }
		reserved:				SInt8;									{  • do not modify, use or rely on reserved fields  }
		atapcValid:				UInt16;									{  reserved  }
		ataRWMultipleCount:		UInt16;									{  AIM's must return 0   }
		ataSectorsPerCylinder:	UInt16;									{  AIM's must return 0   }
		ataHeads:				UInt16;									{  AIM's must return 0   }
		ataSectorsPerTrack:		UInt16;									{  AIM's must return 0  }
		ataSocketNumber:		UInt16;									{  Reserved  }
		ataSocketType:			SInt8;									{  <--: Specifies the socket type (get config only)  }
																		{        00 = Unknown socket  }
																		{       01 = Internal ATA bus  }
																		{        02 = Media Bay  }
																		{        03 = PCMCIA  }
		ataDeviceType:			SInt8;									{  <--: Specifies the device type (get config only)  }
																		{        00 = Unknown device  }
																		{        01 = standard ATA device (HD)  }
																		{        02 = ATAPI device  }
																		{        03 = PCMCIA ATA device  }
		atapcAccessMode:		SInt8;									{  Reserved  }
		atapcVcc:				SInt8;									{  Reserved  }
		atapcVpp1:				SInt8;									{  Reserved  }
		atapcVpp2:				SInt8;									{  Reserved  }
		atapcStatus:			SInt8;									{  Reserved  }
		atapcPin:				SInt8;									{  Reserved  }
		atapcCopy:				SInt8;									{  Reserved  }
		atapcConfigIndex:		SInt8;									{  Reserved  }
		ataSingleDMASpeed:		SInt8;									{  <->: Single Word DMA Timing Class  }
		ataMultiDMASpeed:		SInt8;									{  <->: Multiple Word DMA Timing Class  }
		ataPIOCycleTime:		UInt16;									{  <->:Cycle time in ms for PIO mode  }
		ataMultiCycleTime:		UInt16;									{  <->:Cycle time in ms for Multiword DMA mode  }
		ataUltraDMASpeed:		SInt8;									{  <-> Ultra DMA timing class bit-significant  }
		reserved2:				SInt8;									{  reserved  }
		ataUltraCycleTime:		UInt16;									{  <-> Cycle time in ms for Ultra DMA mode  }
		Reserved1:				ARRAY [0..4] OF UInt16;					{  Reserved for future  }
	END;

	{	 The Request block passed by the manager to the AIM 	}
	ATAReqBlockPtr = ^ATAReqBlock;
	ATAReqBlock = RECORD
																		{  Filled in by ATA Mgr v4.0 }
		connectionID:			UInt32;									{  the connection ID of the req block  }
		MsgID:					UInt32;									{  the ioTag value of this request  }
		result:					ATAResultPtr;							{  result of this operation  }
		DiagResult:				ATADiagResultPtr;						{  for diagnostics i.e. R(W) registers  }
		busInfo:				ATABusInfoPtr;							{  for bus info requests  }
		devConfig:				ATADevConfigPtr;						{  for device config requests  }
		ioObject:				ATADataObject;							{  The actual transfer data  }
		ataPBTaskFile:			ataTaskFile;							{  the task file  }
		packetCBD:				ATAPICmdPacket;							{  For the ATAPI cmd packets  }
		Timeout:				Duration;								{  timeout for this request  }
		BusID:					UInt32;									{  family assigned bus ID  }
		DevID:					SInt8;									{  device ID, -1(bus), 0(master), 1(slave)  }
		ataFunctionCode:		SInt8;
		AbortID:				UInt32;
		ataPBLogicalBlockSize:	UInt32;
		ataPBFlags:				UInt32;
		reserved:				UInt32;
																		{  Used internally by the AIM }
		nextREQ:				ATAReqBlockPtr;							{  the next req on this list  }
		ataPBResult:			OSStatus;
		ataPBErrorRegister:		SInt8;
		ataPBStatusRegister:	SInt8;
		ataPBactualXferCount:	UInt32;
		ataPBState:				UInt32;
		ataPBSemaphores:		UInt32;
		XferType:				SInt8;
		ataModeType:			SInt8;									{  tracks old ataPBVers, to do absolute or bitmap modes        }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		reserved2:				SInt8;
		reserved3:				UInt16;
	END;

	{  enum for modeType in ATAReqBlock, aligned with ataPBVers }

CONST
	kATAModeAbsolute			= 2;
	kATAModeBitmap				= 3;							{  actually three or above }

	kATAPluginVersion			= $00000001;
	kATAPluginCurrentVersion	= $00000001;

	kServiceCategoryATA			= 'ata-';						{  ata }


TYPE
	ataPBHeaderPtr = ^ataPBHeader;
	ataPBHeader = RECORD
																		{  Start of cloned common header ataPBHdr  }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
	END;

	{  data request entry structure (16 bytes) }
	IOBlockPtr = ^IOBlock;
	IOBlock = RECORD
		ataPBBuffer:			Ptr;									{  -->: Data buffer pointer }
		ataPBByteCount:			UInt32;									{  -->: Data transfer length in bytes }
	END;

	{  Manager parameter block structure (96 bytes) }
	ataIOPBPtr = ^ataIOPB;
	ataIOPB = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataPBStatusRegister:	SInt8;									{  <--: Last ATA status image }
		ataPBErrorRegister:		SInt8;									{  <--: Last ATA error image-valid if lsb of Status set }
		ataPBReserved5:			SInt16;									{  Reserved }
		ataPBLogicalBlockSize:	UInt32;									{  -->: Blind transfer size per interrupt (Logical block size) }
		ataPBBuffer:			Ptr;									{  -->: Data buffer pointer }
		ataPBByteCount:			UInt32;									{  -->: Data transfer length in bytes }
		ataPBActualTxCount:		UInt32;									{  <--: Actual transfer count }
		ataPBReserved6:			UInt32;									{  Reserved }
		ataPBTaskFile:			ataTaskFile;							{  <->:   Device register images }
		ataPBPacketPtr:			ATAPICmdPacketPtr;						{  -->: ATAPI packet command block pointer (valid with ATAPI bit set) }
		ataPBReserved7:			ARRAY [0..5] OF SInt16;					{  Reserved for future expansion }
	END;

	{  Parameter block structure for bus and Manager inquiry command }
	{  Manager parameter block structure }
	ataBusInquiryPtr = ^ataBusInquiry;
	ataBusInquiry = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataEngineCount:			UInt16;									{  <--: TBD; zero for now }
		ataReserved1:			UInt16;									{  Reserved }
		ataDataTypes:			UInt32;									{  <--: TBD; zero for now }
		ataIOpbSize:			UInt16;									{  <--: Size of ATA IO PB }
		ataMaxIOpbSize:			UInt16;									{  <--: TBD; zero for now }
		ataFeatureFlags:		UInt32;									{  <--: TBD }
		ataVersionNum:			SInt8;									{  <--: Version number for the HBA }
		ataHBAInquiry:			SInt8;									{  <--: TBD; zero for now }
		ataReserved2:			UInt16;									{  Reserved }
		ataHBAPrivPtr:			UInt32;									{  <--: Ptr to HBA private data area }
		ataHBAPrivSize:			UInt32;									{  <--: Size of HBA private data area }
		ataAsyncFlags:			UInt32;									{  <--: Event capability for callback }
		ataPIOModes:			SInt8;									{  <--: PIO modes supported (bit-significant) }
		ataUltraDMAModes:		SInt8;									{  <--: Ultra DMA modes supported (b-sig) }
		ataSingleDMAModes:		SInt8;									{  <--: Single Word DMA modes supported (b-sig)    }
		ataMultiDMAModes:		SInt8;									{  <--: Multiword DMA modes supported (b-sig) }
		ataReserved4:			ARRAY [0..3] OF UInt32;					{  Reserved }
		ataReserved5:			ARRAY [0..15] OF SInt8;					{  TBD }
		ataHBAVendor:			ARRAY [0..15] OF SInt8;					{  <--: Vendor ID of the HBA }
		ataContrlFamily:		ARRAY [0..15] OF SInt8;					{  <--: Family of ATA Controller }
		ataContrlType:			ARRAY [0..15] OF SInt8;					{  <--: Model number of controller }
		ataXPTversion:			ARRAY [0..3] OF SInt8;					{  <--: version number of XPT }
		ataReserved6:			ARRAY [0..3] OF SInt8;					{  Reserved }
		ataHBAversion:			NumVersion;								{  <--: version number of HBA }
		ataHBAslotType:			SInt8;									{  <--: type of slot }
		ataHBAslotNum:			SInt8;									{  <--: slot number of the HBA }
		ataReserved7:			UInt16;									{  Reserved }
		ataReserved8:			UInt32;									{  Reserved }
	END;

	{  Manager parameter block structure }
	ataMgrInquiryPtr = ^ataMgrInquiry;
	ataMgrInquiry = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataMgrVersion:			NumVersion;								{  Manager Version information }
		ataMgrPBVers:			SInt8;									{  <--: Manager PB version number supported }
		Reserved1:				SInt8;									{  Reserved }
		ataBusCnt:				UInt16;									{  <--: Number of ATA buses in the system }
		ataDevCnt:				UInt16;									{  <--: Total number of ATA devices detected }
		ataPioModes:			SInt8;									{  <--: Maximum Programmed I/O speed mode supported }
		Reserved2:				SInt8;									{  Reserved }
		ataIOClkResolution:		UInt16;									{  <--: IO Clock resolution in nsec (Not supported) }
		ataSingleDMAModes:		SInt8;									{  <--: Single Word DMA modes supported    }
		ataMultiDMAModes:		SInt8;									{  <--: Multiword DMA modes supported }
		Reserved:				ARRAY [0..15] OF SInt16;				{  Reserved for future expansion }
	END;

	{  Parameter block structure for Abort command }
	{  Manager parameter block structure }
	ataAbortPtr = ^ataAbort;
	ataAbort = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataAbortPB:				ataIOPBPtr;								{  -->: Parameter block to be aborted }
		Reserved:				ARRAY [0..21] OF SInt16;				{  Reserved for future expansion }
	END;

	{  Manager parameter block structure }
	ATAEventRecPtr = ^ATAEventRec;
	ATAEventRec = RECORD
		ataEventCode:			UInt16;									{  --> ATA event code }
		ataPhysicalID:			UInt16;									{  --> Physical drive reference }
		ataDrvrContext:			SInt32;									{  Context pointer saved by driver }
		ataMarker:				UInt32;									{  Always 'LOAD' }
		ataEventRecVersion:		UInt32;									{  Version number of this data structure }
		ataDeviceType:			UInt32;									{  Device type on bus (valid for load driver only) }
		ataRefNum:				UInt16;									{  RefNum of driver (valid for remove driver only) }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ATAClientProcPtr = FUNCTION(ataERPtr: ATAEventRecPtr): SInt16;
{$ELSEC}
	ATAClientProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ATAClientUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATAClientUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppATAClientProcInfo = $000000E0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewATAClientUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewATAClientUPP(userRoutine: ATAClientProcPtr): ATAClientUPP; { old name was NewATAClientProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeATAClientUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeATAClientUPP(userUPP: ATAClientUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeATAClientUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeATAClientUPP(ataERPtr: ATAEventRecPtr; userRoutine: ATAClientUPP): SInt16; { old name was CallATAClientProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{  Parameter block structure for Driver Register command }
{  Manager parameter block structure }

TYPE
	ataDrvrRegisterPtr = ^ataDrvrRegister;
	ataDrvrRegister = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataDrvrRefNum:			SInt16;									{  <->: Driver reference number }
		ataDrvrFlags:			UInt16;									{  -->: 1 = loader driver if ataPBDeviceID = -1 (PB2) }
		ataDeviceNextID:		UInt16;									{  <--: used to specified the next drive ID }
		ataDrvrLoadPriv:		SInt16;									{  Driver loader private storage }
		ataEventHandler:		ATAClientUPP;							{  <->: Pointer to ATA event callback routine (PB2) }
		ataDrvrContext:			SInt32;									{  <->: Context data saved by driver (PB2) }
		ataEventMask:			SInt32;									{  <->: Set to 1 for notification of event (PB2) }
		Reserved:				ARRAY [0..13] OF SInt16;				{  Reserved for future expansion - from [21] (PB2) }
	END;

	{  Parameter block structure for Modify driver event mask command }
	ataModifyEventMaskPtr = ^ataModifyEventMask;
	ataModifyEventMask = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataModifiedEventMask:	SInt32;									{  -->: new event mask value }
		Reserved:				ARRAY [0..21] OF SInt16;				{  Reserved for future expansion }
	END;

	{  'ataRegMask' field of the ataRegAccess definition }

CONST
	bATAAltSDevCValid			= 14;							{  bit number of alternate status/device cntrl valid bit }
	bATAStatusCmdValid			= 7;							{  bit number of status/command valid bit }
	bATASDHValid				= 6;							{  bit number of ataTFSDH valid bit }
	bATACylinderHiValid			= 5;							{  bit number of cylinder high valid bit }
	bATACylinderLoValid			= 4;							{  bit number of cylinder low valid bit }
	bATASectorNumValid			= 3;							{  bit number of sector number valid bit }
	bATASectorCntValid			= 2;							{  bit number of sector count valid bit }
	bATAErrFeaturesValid		= 1;							{  bit number of error/features valid bit }
	bATADataValid				= 0;							{  bit number of data valid bit }
	mATAAltSDevCValid			= $4000;						{  alternate status/device control valid }
	mATAStatusCmdValid			= $80;							{  status/command valid }
	mATASDHValid				= $40;							{  ataTFSDH valid }
	mATACylinderHiValid			= $20;							{  cylinder high valid }
	mATACylinderLoValid			= $10;							{  cylinder low valid }
	mATASectorNumValid			= $08;							{  sector number valid }
	mATASectorCntValid			= $04;							{  sector count valid }
	mATAErrFeaturesValid		= $02;							{  error/features valid }
	mATADataValid				= $01;							{  data valid }

	{  Parameter block structure for device register access command }

TYPE
	ataRegValueUnionPtr = ^ataRegValueUnion;
	ataRegValueUnion = RECORD
		CASE INTEGER OF
		0: (
			ataByteRegValue:	SInt8;									{  <->: Byte register value read or to be written }
			);
		1: (
			ataWordRegValue:	UInt16;									{  <->: Word register value read or to be written }
			);
	END;

	{  Manager parameter block structure }
	ataRegAccessPtr = ^ataRegAccess;
	ataRegAccess = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataRegSelect:			UInt16;									{  -->: Device Register Selector }
																		{          DataReg       0   }
																		{          ErrorReg(R) or FeaturesReg(W)    1 }
																		{          SecCntReg       2 }
																		{          SecNumReg       3 }
																		{          CylLoReg     4 }
																		{          CylHiReg     5 }
																		{          SDHReg      6 }
																		{          StatusReg(R) or CmdReg(W)       7 }
																		{          AltStatus(R) or DevCntr(W)   0E }
		ataRegValue:			ataRegValueUnion;
																		{  Following fields are valid only if ataRegSelect = 0xFFFF }
		ataRegMask:				UInt16;									{  -->: mask for register(s) to update }
																		{        bit 0 : data register valid }
																		{        bit 1 : error/feaures register valid }
																		{        bit 2 : sector count register valid }
																		{        bit 3 : sector number register valid }
																		{        bit 4 : cylinder low register valid }
																		{        bit 5 : cylinder high register valid }
																		{        bit 6 : ataTFSDH register valid }
																		{        bit 7 : status/command register valid }
																		{        bits 8 - 13 : reserved (set to 0) }
																		{        bit 14: alternate status / device control reg valid }
																		{       bit 15: reserved (set to 0) }
		ataRegisterImage:		ataTaskFile;							{  <->: register images }
		ataAltSDevCReg:			SInt8;									{  <->: Alternate status(R) or Device Control(W) register image }
		Reserved3:				SInt8;									{  Reserved }
		Reserved:				ARRAY [0..15] OF SInt16;				{  Reserved for future expansion }
	END;

	{  Manager parameter block structure    <DP03/10/94> }
	ataIdentifyPtr = ^ataIdentify;
	ataIdentify = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		Reserved1:				ARRAY [0..3] OF UInt16;					{  Reserved.  These are used internally by the Manager }
		ataPBBuffer:			Ptr;									{  Buffer for the identify data (512 bytes) }
		Reserved2:				ARRAY [0..11] OF UInt16;				{  Used internally by the ATA Manager }
		Reserved3:				ARRAY [0..5] OF SInt16;					{  Reserved for future expansion }
	END;

	{  'ataConfigSetting' field of the Get/Set Device Configuration definition <8/6/94> }

CONST
	ATAPIpacketDRQ_bit			= 6;							{  bit number of ATAPI command packet DRQ option }
	ATAPIpacketDRQ				= $40;							{  ATAPI command packet DRQ option }

	{  atapcValid field definition }
	bATApcAccessMode			= 0;
	bATApcVcc					= 1;
	bATApcVpp1					= 2;
	bATApcVpp2					= 3;
	bATApcStatus				= 4;
	bATApcPin					= 5;
	bATApcCopy					= 6;
	bATApcConfigIndex			= 7;
	bATApcLockUnlock			= 15;
	mATApcAccessMode			= $01;
	mATApcVcc					= $02;
	mATApcVpp1					= $04;
	mATApcVpp2					= $08;
	mATApcStatus				= $10;
	mATApcPin					= $20;
	mATApcCopy					= $40;
	mATApcConfigIndex			= $80;
	mATApcLockUnlock			= $8000;

	{  Device physical type & socket type indicator definition }
	kATADeviceUnknown			= $00;							{  no device or type undetermined }
	kATADeviceATA				= $01;							{  traditional ATA protocol device <7/29/94> }
	kATADeviceATAPI				= $02;							{  ATAPI protocol device  <7/29/94> }
	kATADeviceReserved			= $03;							{  reserved by Apple (was PCMCIA) }

	kATASocketInternal			= $01;							{  Internal ATA socket }
	kATASocketMB				= $02;							{  Media Bay socket }
	kATASocketPCMCIA			= $03;							{  PCMCIA socket }


	{
	   Get/Set Device Configuration parameter block structure <8/6/94>
	   Manager parameter block structure
	}

TYPE
	ataDevConfigurationPtr = ^ataDevConfiguration;
	ataDevConfiguration = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataConfigSetting:		SInt32;									{  <->: Configuration setting }
																		{       Bits 3 - 0: Reserved }
																		{       Bit 4: Reserved (allowLBAAccess) }
																		{       Bit 5: Reserved (allowRWMultiple) }
																		{       Bit 6: ATAPIpacketDRQ }
																		{        1 = Check for Interrupt DRQ on ATAPI command packet DRQ }
																		{        0 = Default: Check only for the assertion of command packet DRQ }
																		{       Bits 31 - 7: Reserved }
		ataPIOSpeedMode:		SInt8;									{  <->: Device access speed in PIO Mode }
		Reserved3:				SInt8;									{  Reserved to force word alignment }
		atapcValid:				UInt16;									{  <->: Set when pcXXX fields are valid (atapcAccessMode - atapcConfigIndex) }
																		{        bit 0 - atapcAccessMode field valid, when set }
																		{        bit 1 - atapcVcc field valid, when set }
																		{        bit 2 - atapcVpp1 field valid, when set }
																		{        bit 3 - atapcVpp2 field valid, when set }
																		{        bit 4 - atapcStatus field valid, when set }
																		{        bit 5 - atapcPin field valid, when set }
																		{        bit 6 - atapcCopy field valid, when set }
																		{        bit 7 - atapcConfigIndex field valid, when set }
																		{        bits 14-8 - Reserved }
																		{        bit 15 - device lock/unlock request (write only) }
		ataRWMultipleCount:		UInt16;									{  Reserved for future (not supported yet) }
		ataSectorsPerCylinder:	UInt16;									{  Reserved for future (not supported yet) }
		ataHeads:				UInt16;									{  Reserved for future (not supported yet) }
		ataSectorsPerTrack:		UInt16;									{  Reserved for future (not supported yet) }
		ataSocketNumber:		UInt16;									{  <--: Socket number used by the CardServices }
																		{        0xFF = socket number invalid (Not a CardServices device) }
																		{        other = socket number of the device }
		ataSocketType:			SInt8;									{  <--: Specifies the socket type (get config only) }
																		{        00 = Unknown socket }
																		{       01 = Internal ATA bus }
																		{        02 = Media Bay }
																		{        03 = PCMCIA }
		ataDeviceType:			SInt8;									{  <--: Specifies the device type (get config only) }
																		{        00 = Unknown device }
																		{        01 = standard ATA device (HD) }
																		{        02 = ATAPI device }
																		{        03 = PCMCIA ATA device }
		atapcAccessMode:		SInt8;									{  <->: Access mode: Memory vs. I/O (PCMCIA only) }
		atapcVcc:				SInt8;									{  <->: Voltage in tenths of a volt (PCMCIA only) }
		atapcVpp1:				SInt8;									{  <->: Voltage in tenths of a volt (PCMCIA only) }
		atapcVpp2:				SInt8;									{  <->: Voltage in tenths of a volt (PCMCIA only) }
		atapcStatus:			SInt8;									{  <->: Card Status register setting (PCMCIA only) }
		atapcPin:				SInt8;									{  <->: Card Pin register setting (PCMCIA only) }
		atapcCopy:				SInt8;									{  <->: Card Socket/Copy register setting (PCMCIA only) }
		atapcConfigIndex:		SInt8;									{  <->: Card Option register setting (PCMCIA only) }
		ataSingleDMASpeed:		SInt8;									{  <->: Single Word DMA Timing Class }
		ataMultiDMASpeed:		SInt8;									{  <->: Multiple Word DMA Timing Class }
		ataPIOCycleTime:		UInt16;									{  <->:Cycle time for PIO mode }
		ataMultiCycleTime:		UInt16;									{  <->:Cycle time for Multiword DMA mode }
		ataUltraDMASpeed:		SInt8;									{  <-> Ultra DMA timing class }
		reserved2:				SInt8;									{  reserved }
		ataUltraCycleTime:		UInt16;									{  <-> Cycle time for Ultra DMA mode }
		Reserved1:				ARRAY [0..4] OF UInt16;					{  Reserved for future }
	END;

	{  Get Card Location Icon/Text  <SM4> }

CONST
	kATALargeIconHFS			= $0001;						{  Large B&W icon with mask (HFS) }
	kATALargeIconProDOS			= $0081;						{  Large B&W icon with mask (ProDOS) }

	{  Manager parameter block structure }

TYPE
	ataLocationDataPtr = ^ataLocationData;
	ataLocationData = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataIconType:			SInt16;									{  -->: icon type specifier }
																		{       1 = Large B&W icon with mask (256 bytes) }
																		{        0x81 = Same as 1, but ProDOS icon }
		ataIconReserved:		SInt16;									{  Reserved to be longword aligned }
		ataLocationIconPtr:		Ptr;									{  -->: Icon Data buffer pointer }
		ataLocationStringPtr:	Ptr;									{  -->: Icon String buffer pointer }
		Reserved1:				ARRAY [0..17] OF UInt16;				{  Reserved for future }
	END;

	{  ataOSType available }

CONST
	kATAddTypeMacOS				= $0001;						{  Blue Mac O/S ddType value }

	{  Parameter block structure for adding an ATA bus; ATA Manager 4 and above. }

TYPE
	ataAddATABusPtr = ^ataAddATABus;
	ataAddATABus = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ProcPtr;								{  -->: Completion Routine Pointer     }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier         }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		ataNameRegEntry:		RegEntryIDPtr;							{  -->: Pointer to name registry data }
		connID:					CFragConnectionID;						{  -->: Reserved. Must be set to zero. }
		busID:					UInt32;									{  <--: bus ID }
		flags:					SInt8;									{  -->: add bus flags }
		socketType:				SInt8;									{  -->:   Socket type as defined in the enum }
		iconData:				Ptr;									{  -->: Ptr to 256 bytes of icon data (nil is OK) }
		stringData:				Ptr;									{  -->: C String defining location of device. (nil is OK) }
	END;

	{  Parameter block structure for adding an ATA bus; ATA Manager 4 and above. }
	ataRemoveATABusPtr = ^ataRemoveATABus;
	ataRemoveATABus = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ProcPtr;								{  -->: Completion Routine Pointer     }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier         }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		busID:					UInt32;									{  -->: Reserved. Must set to 0.              }
		ataNameRegEntry:		RegEntryIDPtr;							{  -->: Pointer to name registry data  }
	END;

	{  The parameter block definition for all other ATA Manager functions. }

	ataGenericPtr = ^ataGeneric;
	ataGeneric = RECORD
																		{  Start of cloned common header ataPBHdr }
		ataPBLink:				ataPBHeaderPtr;							{  a pointer to the next entry in the queue    }
		ataPBQType:				UInt16;									{  type byte for safety check }
		ataPBVers:				SInt8;									{  -->: parameter block version number; Must be 0x01 }
		ataPBReserved:			SInt8;									{  Reserved                          }
		ataPBReserved2:			Ptr;									{  Reserved                          }
		ataPBCallbackPtr:		ATACallbackUPP;							{  -->: Completion Routine Pointer }
		ataPBResult:			OSErr;									{  <--: Returned result           }
		ataPBFunctionCode:		SInt8;									{  -->: Manager Function Code  }
		ataPBIOSpeed:			SInt8;									{  -->: I/O Timing Class        }
		ataPBFlags:				UInt16;									{  -->: Various control options    }
		ataPBReserved3:			SInt16;									{  Reserved                          }
		ataPBDeviceID:			UInt32;									{  -->: Device identifier (see ataDeviceID)       }
		ataPBTimeOut:			UInt32;									{  -->: Transaction timeout value in msec  }
		ataPBClientPtr1:		Ptr;									{  Client's storage Ptr 1      }
		ataPBClientPtr2:		Ptr;									{  Client's storage Ptr 2      }
		ataPBState:				UInt16;									{  Reserved for Manager; Initialize to 0  }
		ataPBSemaphores:		UInt16;									{  Used internally by the manager }
		ataPBReserved4:			SInt32;									{  Reserved                          }
																		{  End of cloned common header ataPBHdr }
		Reserved:				ARRAY [0..23] OF UInt16;				{  Reserved for future }
	END;

	ataPBPtr = ^ataPB;
	ataPB = RECORD
		CASE INTEGER OF
		0: (
			ataIOParamBlock:	ataIOPB;								{  parameter block for I/O }
			);
		1: (
			ataBIParamBlock:	ataBusInquiry;							{  parameter block for bus inquiry }
			);
		2: (
			ataMIParamBlock:	ataMgrInquiry;							{  parameter block for Manager inquiry }
			);
		3: (
			ataAbortParamBlock:	ataAbort;								{  parameter block for abort }
			);
		4: (
			ataDRParamBlock:	ataDrvrRegister;						{  parameter block for driver register }
			);
		5: (
			ataMEParamBlock:	ataModifyEventMask;						{  parameter block for event mask modify }
			);
		6: (
			ataRAParamBlock:	ataRegAccess;							{  parameter block for register access }
			);
		7: (
			ataDIParamBlock:	ataIdentify;							{  parameter block for drive identify }
			);
		8: (
			ataDCParamBlock:	ataDevConfiguration;					{  parameter block for device configuration }
			);
		9: (
			ataLDParamBlock:	ataLocationData;						{  parameter block for location icon data }
			);
																		{ ataManagerInit  ataInitParamBlock;     // parameter block for Manager initialization }
																		{ ataManagerShutDn    ataSDParamBlock;     // parameter block for Manager shutdown }
																		{ ataDrvrLoad     ataDLParamBlock;     // parameter block for Driver loading }
		10: (
			ataGenericParamBlock: ataGeneric;							{  parameter block for all other functions }
			);
	END;

	{  The ATA Event codes… }

CONST
	kATANullEvent				= $00;							{  Just kidding -- nothing happened }
	kATAOnlineEvent				= $01;							{  An ATA device has come online }
	kATAOfflineEvent			= $02;							{  An ATA device has gone offline }
	kATARemovedEvent			= $03;							{  An ATA device has been removed from the bus }
	kATAResetEvent				= $04;							{  Someone gave a hard reset to the drive }
	kATAOfflineRequest			= $05;							{  Someone requesting to offline the drive }
	kATAEjectRequest			= $06;							{  Someone requesting to eject the drive }
	kATAUpdateEvent				= $07;							{  Potential configuration change reported by CardServices <SM4> }
	kATATaskTimeRequest			= $08;							{  The manager is requesting to be called at Task Time }
	kATALoadDriverNow			= $09;							{  Load the driver for the given bus immediately }
	kATAPIResetEvent			= $0A;							{  Someone gave a ATAPI reset to the drive }
																{  The following describes bit definitions in the eventMask field of ataDrvrRegister }
	bATANullEvent				= $01;							{  null event bit }
	bATAOnlineEvent				= $02;							{  online event bit }
	bATAOfflineEvent			= $04;							{  offline event bit }
	bATARemovedEvent			= $08;							{  removed event bit }
	bATAResetEvent				= $10;							{  ATA reset event bit }
	bATAOfflineRequest			= $20;							{  offline request event bit }
	bATAEjectRequest			= $40;							{  eject request event bit }
	bATAUpdateEvent				= $80;							{  configuration update event bit }
	bATAPIResetEvent			= $0400;						{  ATAPI reset event bit }

	kATAEventMarker				= 'LOAD';						{  Marker for the event data structure }
	kATAEventVersion1			= $00000001;					{  Version 1 of the event structure }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATADispatchProcPtr = FUNCTION(VAR pb: ataPB): OSErr;
{$ELSEC}
	ATADispatchProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ATADispatchUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATADispatchUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppATADispatchProcInfo = $000000E0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewATADispatchUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewATADispatchUPP(userRoutine: ATADispatchProcPtr): ATADispatchUPP; { old name was NewATADispatchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeATADispatchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeATADispatchUPP(userUPP: ATADispatchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeATADispatchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeATADispatchUPP(VAR pb: ataPB; userRoutine: ATADispatchUPP): OSErr; { old name was CallATADispatchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  ataManager()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ataManager(VAR pb: ataPB): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AAF1;
	{$ENDC}

{  Typedefs for the AIM entry point pointers }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginInit = FUNCTION(VAR pb: ATAInitInfo): OSStatus; C;
{$ELSEC}
	ATAPluginInit = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginClose = FUNCTION(refCon: UInt32; aimRegEntry: RegEntryIDPtr): OSStatus; C;
{$ELSEC}
	ATAPluginClose = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginAction = PROCEDURE(refCon: UInt32; VAR pb: ATAReqBlock); C;
{$ELSEC}
	ATAPluginAction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginHandleBusEvent = PROCEDURE(refCon: UInt32; aimData: UInt32); C;
{$ELSEC}
	ATAPluginHandleBusEvent = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginPoll = FUNCTION(refCon: UInt32; interruptLevel: UInt32; VAR aimData: UInt32): BOOLEAN; C;
{$ELSEC}
	ATAPluginPoll = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginEjectDevice = PROCEDURE(refCon: UInt32); C;
{$ELSEC}
	ATAPluginEjectDevice = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginDeviceLight = PROCEDURE(refCon: UInt32; whichDevice: UInt32; lightState: UInt32); C;
{$ELSEC}
	ATAPluginDeviceLight = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginDeviceLock = PROCEDURE(refCon: UInt32; whichDevice: UInt32; lockState: UInt32); C;
{$ELSEC}
	ATAPluginDeviceLock = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginSuspend = PROCEDURE(refCon: UInt32); C;
{$ELSEC}
	ATAPluginSuspend = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATAPluginResume = PROCEDURE(refCon: UInt32); C;
{$ELSEC}
	ATAPluginResume = ProcPtr;
{$ENDC}

	{	 AIM Plugin header 	}
	ATAPluginHeaderPtr = ^ATAPluginHeader;
	ATAPluginHeader = RECORD
		headerVersion:			NumVersion;
		dispatchVersion:		NumVersion;
		reservedA:				UInt32;
		reservedB:				UInt32;
	END;

	ATAPluginDispatchTablePtr = ^ATAPluginDispatchTable;
	ATAPluginDispatchTable = RECORD
		header:					ATAPluginHeader;
		init:					ATAPluginInit;
		close:					ATAPluginClose;
		action:					ATAPluginAction;
		busEvent:				ATAPluginHandleBusEvent;
		poll:					ATAPluginPoll;
		eject:					ATAPluginEjectDevice;
		light:					ATAPluginDeviceLight;
		lock:					ATAPluginDeviceLock;
		suspend:				ATAPluginSuspend;
		resume:					ATAPluginResume;
	END;


	{  Callbacks into the System 7 ATA Manager }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  ATAFamIODone()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ATAManager 4 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE ATAFamIODone(VAR theReq: ATAReqBlock; result: OSStatus); C;

{
 *  ATAFamBusEventForAIM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATAManager 4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ATAFamBusEventForAIM(busID: UInt32; busEvent: UInt32); C;

{
 *  NativeATAMgr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATAManager 4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NativeATAMgr(VAR request: ataPB): SInt16;



{ Device Error codes: 0xDB42 - 0xDB5F  }

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	ATABaseErrCode				= -9406;						{  Base error code - 0xDB42    }
	ioPending					= 1;							{  Asynch I/O in progress status }
	AT_NRdyErr					= -9405;						{  0xDB43: Drive not Ready  }
	AT_IDNFErr					= -9404;						{  0xDB44: ID not found  }
	AT_DMarkErr					= -9403;						{  0xDB45: Data mark not found  }
	AT_BadBlkErr				= -9402;						{  0xDB46: Bad Block  }
	AT_CorDataErr				= -9401;						{  0xDB47: Data was corrected  }
	AT_UncDataErr				= -9400;						{  0xDB48: Data was not corrected  }
	AT_SeekErr					= -9399;						{  0xDB49: Seek error  }
	AT_WrFltErr					= -9398;						{  0xDB4A: Write fault  }
	AT_RecalErr					= -9397;						{  0xDB4B: Recalibrate failed  }
	AT_AbortErr					= -9396;						{  0xDB4C: Command aborted by drive  }
	AT_MCErr					= -9394;						{  0xDB4E: Media Changed error }
	ATAPICheckErr				= -9393;						{  0xDB4F: ATAPI Check condition <06/15/94> }
	AT_UltraDMAiCRCErr			= -9392;						{  0xDB50: CRC error during Ultra DMA xfer  }
																{  System error codes...Custom Driver Error Codes 0xDB60 - 0xDB6F }
	DRVRCantAllocate			= -9376;						{  0xDB60: Allocation error during initialization }
	NoATAMgr					= -9375;						{  0xDB61: MgrInquiry failed => No ATA Manager }
	ATAInitFail					= -9374;						{  0xDB62: Mgr Initialization failed }
	ATABufFail					= -9373;						{  0xDB63: Device buffer test failure }
	ATADevUnsupported			= -9372;						{  0xDB64: Device type not supported }
	ATAEjectDrvErr				= -9371;						{  0xDB65: Could not eject the drive }
																{  Manager Error Codes 0xDB70 - 0xDB8F }
	ATAMgrNotInitialized		= -9360;						{  0xDB70: Mgr has not been initialized }
	ATAPBInvalid				= -9359;						{  0xDB71: The bus base address couldn't be found }
	ATAFuncNotSupported			= -9358;						{  0xDB72: An unknown function code specified }
	ATABusy						= -9357;						{  0xDB73: Selected device is busy }
	ATATransTimeOut				= -9356;						{  0xDB74: Transaction timeout detected }
	ATAReqInProg				= -9355;						{  0xDB75: Channel busy; channel is processing another cmd }
	ATAUnknownState				= -9354;						{  0xDB76: Device status register reflects an unknown state }
	ATAQLocked					= -9353;						{  0xDB77: I/O Queue is locked due to previous I/O error. }
	ATAReqAborted				= -9352;						{  0xDB78: The I/O queue entry was aborted due to an abort req. }
																{          or due to Manager shutdown. }
	ATAUnableToAbort			= -9351;						{  0xDB79: The I/O queue entry could not be aborted. }
	ATAAbortedDueToRst			= -9350;						{  0xDB7A: Request aborted due to a device reset command. }
	ATAPIPhaseErr				= -9349;						{  0xDB7B: Unexpected phase - •••IS THIS VALID ERROR??? <06/15/94> }
	ATAPITxCntErr				= -9348;						{  0xDB7C: Overrun/Underrun condition detected }
	ATANoClientErr				= -9347;						{  0xDB7D: No client present to handle the event }
	ATAInternalErr				= -9346;						{  0xDB7E: MagnumOpus returned an error }
	ATABusErr					= -9345;						{  0xDB7F: Bus error detected on I/O   }
	AT_NoAddrErr				= -9344;						{  0xDB80: Invalid AT base adress  }
	DriverLocked				= -9343;						{  0xDB81: Current driver must be removed before adding another }
	CantHandleEvent				= -9342;						{  0xDB82: Particular event couldn't be handled (call others) }
	ATAMgrMemoryErr				= -9341;						{  0xDB83: Manager memory allocation error     }
	ATASDFailErr				= -9340;						{  0xDB84: Shutdown failure           }
	ATAXferParamErr				= -9339;						{  0xDB85: I/O xfer parameters inconsistent  }
	ATAXferModeErr				= -9338;						{  0xDB86: I/O xfer mode not supported  }
	ATAMgrConsistencyErr		= -9337;						{  0XDB87: Manager detected internal inconsistency.  }
	ATADmaXferErr				= -9336;						{  0XDB88: fatal error in DMA side of transfer  }
																{  Driver loader error Codes 0xDB90 - 0xDBA5 }
	ATAInvalidDrvNum			= -9328;						{  0xDB90: Invalid drive number from event }
	ATAMemoryErr				= -9327;						{  0xDB91: Memory allocation error }
	ATANoDDMErr					= -9326;						{  0xDB92: No DDM found on media   }
	ATANoDriverErr				= -9325;						{  0xDB93: No driver found on the media    }

	{	 ------------------------ Version 1 definition -------------------------------    	}
	v1ATABaseErrCode			= $0700;						{  This needs a home somewhere }
	v1AT_NRdyErr				= $FFFFF901;					{  0xF901: -0x1DBE  }
	v1AT_IDNFErr				= $FFFFF904;					{  0xF904: -0x1DC0  }
	v1AT_DMarkErr				= $FFFFF905;					{  0xF905: -0x1DC0  }
	v1AT_BadBlkErr				= $FFFFF906;					{  0xF906: -0x1DC0  }
	v1AT_CorDataErr				= $FFFFF907;					{  0xF907: -0x1DC0  }
	v1AT_UncDataErr				= $FFFFF908;					{  0xF908: -0x1DC0  }
	v1AT_SeekErr				= $FFFFF909;					{  0xF909: -0x1DC0  }
	v1AT_WrFltErr				= $FFFFF90A;					{  0xF90A: -0x1DC0  }
	v1AT_RecalErr				= $FFFFF90B;					{  0xF90B: -0x1DC0  }
	v1AT_AbortErr				= $FFFFF90C;					{  0xF90C: -0x1DC0  }
	v1AT_NoAddrErr				= $FFFFF90D;					{  0xF90D: -0x1D8D  }
	v1AT_MCErr					= $FFFFF90E;					{  0xF90E: -0x1DC0 }
																{  System error codes...Custom Driver Error Codes }
	v1DRVRCantAllocate			= -1793;						{  0xF8FF: -0x1D9F }
	v1NoATAMgr					= -1794;						{  0xF8FE: -0x1D9D }
	v1ATAInitFail				= -1795;						{  0xF8FD: -0x1D9B }
	v1ATABufFail				= -1796;						{  0xF8FC: -0x1D99 }
	v1ATADevUnsupported			= -1797;						{  0xF8FB: -0x1c97 }
																{  Manager Error Codes }
	v1ATAMgrNotInitialized		= -1802;						{  0xF8F6: -0x1D86 }
	v1ATAPBInvalid				= -1803;						{  0xF8F5: -0x1D84 }
	v1ATAFuncNotSupported		= -1804;						{  0xF8F4: -0x1D82 }
	v1ATABusy					= -1805;						{  0xF8F3: -0x1D80 }
	v1ATATransTimeOut			= -1806;						{  0xF8F2: -0x1D7E }
	v1ATAReqInProg				= -1807;						{  0xF8F1: -0x1D7C }
	v1ATAUnknownState			= -1808;						{  0xF8F0: -0x1D7A }
	v1ATAQLocked				= -1809;						{  0xF8EF: -0x1D78 }
	v1ATAReqAborted				= -1810;						{  0xF8EE: -0x1D76 }
	v1ATAUnableToAbort			= -1811;						{  0xF8ED: -0x1D74 }
	v1ATAAbortedDueToRst		= -1812;						{  0xF8EC: -0x1D72 }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATAIncludes}

{$ENDC} {__ATA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}