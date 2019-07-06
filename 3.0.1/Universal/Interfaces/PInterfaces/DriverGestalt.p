{
 	File:		DriverGestalt.p
 
 	Contains:	Driver Gestalt interfaces
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DriverGestalt;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERGESTALT__}
{$SETC __DRIVERGESTALT__ := 1}

{$I+}
{$SETC DriverGestaltIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __SCSI__}
{$I SCSI.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{__________________________________________________________________________________}
{ The Driver Gestalt bit in the dCtlFlags }

CONST
	kbDriverGestaltEnable		= 2;
	kmDriverGestaltEnableMask	= $04;

{__________________________________________________________________________________}
{ Driver Gestalt related csCodes }
	kDriverGestaltCode			= 43;							{  various uses  }
	kDriverConfigureCode		= 43;							{  various uses  }
	kdgLowPowerMode				= 70;							{  Sets/Returns the current energy consumption level  }
	kdgReturnDeviceID			= 120;							{  returns SCSI DevID in csParam[0]  }
	kdgGetCDDeviceInfo			= 121;							{  returns CDDeviceCharacteristics in csParam[0]  }

{__________________________________________________________________________________}
{ Driver Gestalt selectors }
	kdgVersion					= 'vers';						{  Version number of the driver in standard Apple format  }
	kdgDeviceType				= 'devt';						{  The type of device the driver is driving.  }
	kdgInterface				= 'intf';						{  The underlying interface that the driver is using (if any)  }
	kdgSync						= 'sync';						{  True if driver only behaves synchronously.  }
	kdgBoot						= 'boot';						{  value to place in PRAM for this drive (long)  }
	kdgWide						= 'wide';						{  True if driver supports ioWPosOffset  }
	kdgPurge					= 'purg';						{  Driver purge permission (True = purge; False = no purge)  }
	kdgSupportsSwitching		= 'lpwr';						{  True if driver supports power switching  }
	kdgMin3VPower				= 'pmn3';						{  Minimum 3.3V power consumption in microWatts  }
	kdgMin5VPower				= 'pmn5';						{  Minimum 5V power consumption in microWatts  }
	kdgMax3VPower				= 'pmx3';						{  Maximum 3.3V power consumption in microWatts  }
	kdgMax5VPower				= 'pmx5';						{  Maximum 5V power consumption in microWatts  }
	kdgInHighPower				= 'psta';						{  True if device is currently in high power mode  }
	kdgSupportsPowerCtl			= 'psup';						{  True if driver supports following five calls  }
	kdgAPI						= 'dAPI';						{  API support for PC Exchange  }
	kdgEject					= 'ejec';						{  Eject options for shutdown/restart (Shutdown Mgr)  }
	kdgFlush					= 'flus';						{  Determine if disk driver supports flush and if it needs a flush  }
	kdgVMOptions				= 'vmop';						{  Disk drive's Virtual Memory options  }
	kdgPhysDriveIconSuite		= 'dics';						{  [call sync only] icon suite for Disk Driver physical drive (formerly in csCode 22)  }
	kdgMediaIconSuite			= 'mics';						{  [call sync only] icon suite for Disk Driver media (formerly in csCode 21)  }
	kdgMediaName				= 'mnam';						{  pascal string describing the Disk Driver (formerly in csCode 21)  }

{__________________________________________________________________________________}
{ Driver Configure selectors }
	kdcFlush					= 'flus';						{  Tell a disk driver to flush its cache and any hardware caches  }

{__________________________________________________________________________________}
{ control parameter block for Driver Configure calls }

TYPE
	DriverConfigParamPtr = ^DriverConfigParam;
	DriverConfigParam = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ProcPtr;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;								{  refNum for I/O operation  }
		csCode:					INTEGER;								{  == kDriverConfigureCode  }
		driverConfigureSelector: OSType;
		driverConfigureParameter: UInt32;
	END;

{__________________________________________________________________________________}
{ status parameter block for Driver Gestalt calls }
	DriverGestaltParamPtr = ^DriverGestaltParam;
	DriverGestaltParam = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ProcPtr;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;								{  refNum for I/O operation  }
		csCode:					INTEGER;								{ 	== kDriverGestaltCode  }
		driverGestaltSelector:	OSType;									{  'sync', 'vers', etc.  }
		driverGestaltResponse:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltResponse1:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltResponse2:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltResponse3:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltfiller:	UInt16;									{  To pad out to the size of a controlPB  }
	END;

{ Note that the various response definitions are overlays of the response fields above.
   For instance the deviceType response would be returned in driverGestaltResponse.
   The DriverGestaltPurgeResponse would be in driverGestaltResponse and driverGestaltResponse1
}
{__________________________________________________________________________________}
{ Device Types response }
	DriverGestaltDevTResponsePtr = ^DriverGestaltDevTResponse;
	DriverGestaltDevTResponse = RECORD
		deviceType:				OSType;
	END;


CONST
	kdgDiskType					= 'disk';						{  standard r/w disk drive  }
	kdgTapeType					= 'tape';						{  tape drive  }
	kdgPrinterType				= 'prnt';						{  printer  }
	kdgProcessorType			= 'proc';						{  processor  }
	kdgWormType					= 'worm';						{  write-once  }
	kdgCDType					= 'cdrm';						{  cd-rom drive  }
	kdgFloppyType				= 'flop';						{  floppy disk drive  }
	kdgScannerType				= 'scan';						{  scanner  }
	kdgFileType					= 'file';						{  Logical Partition type based on a file (Drive Container)  }
	kdgRemovableType			= 'rdsk';						{  A removable media hard disk drive ie. Syquest, Bernioulli  }

{__________________________________________________________________________________}
{ Device Interfaces response }

TYPE
	DriverGestaltIntfResponsePtr = ^DriverGestaltIntfResponse;
	DriverGestaltIntfResponse = RECORD
		interfaceType:			OSType;
	END;


CONST
	kdgScsiIntf					= 'scsi';
	kdgPcmciaIntf				= 'pcmc';
	kdgATAIntf					= 'ata ';
	kdgFireWireIntf				= 'fire';
	kdgExtBus					= 'card';

{__________________________________________________________________________________}
{ Power Saving }

TYPE
	DriverGestaltPowerResponsePtr = ^DriverGestaltPowerResponse;
	DriverGestaltPowerResponse = RECORD
		powerValue:				LONGINT;								{  Power consumed in µWatts  }
	END;

{__________________________________________________________________________________}
{ Disk Specific }
	DriverGestaltSyncResponsePtr = ^DriverGestaltSyncResponse;
	DriverGestaltSyncResponse = RECORD
		behavesSynchronously:	BOOLEAN;
		pad:					PACKED ARRAY [0..2] OF UInt8;
	END;

	DriverGestaltBootResponsePtr = ^DriverGestaltBootResponse;
	DriverGestaltBootResponse = RECORD
		extDev:					SInt8;									{   Packed target (upper 5 bits) LUN (lower 3 bits)  }
		partition:				SInt8;									{   Unused  }
		SIMSlot:				SInt8;									{   Slot  }
		SIMsRSRC:				SInt8;									{   sRsrcID  }
	END;

	DriverGestaltAPIResponsePtr = ^DriverGestaltAPIResponse;
	DriverGestaltAPIResponse = RECORD
		partitionCmds:			INTEGER;								{  if bit 0 is nonzero, supports partition control and status calls  }
																		{ 	 	prohibitMounting (control, kProhibitMounting)  }
																		{  		partitionToVRef (status, kGetPartitionStatus)  }
																		{  		getPartitionInfo (status, kGetPartInfo)  }
		unused1:				INTEGER;								{  all the unused fields should be zero  }
		unused2:				INTEGER;
		unused3:				INTEGER;
		unused4:				INTEGER;
		unused5:				INTEGER;
		unused6:				INTEGER;
		unused7:				INTEGER;
		unused8:				INTEGER;
		unused9:				INTEGER;
		unused10:				INTEGER;
	END;

	DriverGestaltFlushResponsePtr = ^DriverGestaltFlushResponse;
	DriverGestaltFlushResponse = RECORD
		canFlush:				BOOLEAN;								{  Return true if driver supports the  }
																		{  kdcFlush Driver Configure _Control call  }
		needsFlush:				BOOLEAN;								{  Return true if driver/device has data cached  }
																		{  and needs to be flushed when the disk volume  }
																		{  is flushed by the File Manager  }
		pad:					PACKED ARRAY [0..1] OF UInt8;
	END;

{ Flags for purge permissions }

CONST
	kbCloseOk					= 0;							{  Ok to call Close  }
	kbRemoveOk					= 1;							{  Ok to call RemoveDrvr  }
	kbPurgeOk					= 2;							{  Ok to call DisposePtr  }
	kmNoCloseNoPurge			= 0;
	kmOkCloseNoPurge			= $03;
	kmOkCloseOkPurge			= $07;

{ Driver purge permission structure }

TYPE
	DriverGestaltPurgeResponsePtr = ^DriverGestaltPurgeResponse;
	DriverGestaltPurgeResponse = RECORD
		purgePermission:		UInt16;									{  0 = Do not change the state of the driver  }
																		{  3 = Do Close() and DrvrRemove() this driver  }
																		{  but don't deallocate driver code  }
																		{  7 = Do Close(), DrvrRemove(), and DisposePtr()  }
		purgeReserved:			UInt16;
		purgeDriverPointer:		Ptr;									{  pointer to the start of the driver block (valid  }
																		{  only of DisposePtr permission is given  }
	END;

	DriverGestaltEjectResponsePtr = ^DriverGestaltEjectResponse;
	DriverGestaltEjectResponse = RECORD
		ejectFeatures:			UInt32;									{    }
	END;

{ Flags for Ejection Features field }

CONST
	kRestartDontEject			= 0;							{  Dont Want eject during Restart  }
	kShutDownDontEject			= 1;							{  Dont Want eject during Shutdown  }
	kRestartDontEject_Mask		= $01;
	kShutDownDontEject_Mask		= $02;

{
	The DriverGestaltVMOptionsResponse is returned by a disk driver in response to a
	kdgVMOptions Driver Gestalt request. This allows a disk driver to tell VM a few
	things about a disk drive. For example:
	
	• A drive that should never be in the page fault path should return kAllowVMNoneMask.
	  Examples of this are drives that have manual eject buttons that are not disabled by
	  software, drives with very slow throughput, or drives that depend on
	  a network connection.
	• A drive that should never be written to but is safe for read-only file mapping
	  should return kAllowVMReadOnlyMask. Examples of this are WORM drives where each write
	  eats write-once space on the disk and CD-ROM drives which are read-only media.
	• A drive that should allow VM to create its main backing store file should return
	  kAllowVMReadWriteMask. Examples of this are fast read/write drives that don't allow
	  manual eject and don't use a network connection.
	
	A disk driver must look at the ioVRefNum field of the DriverGestaltParam to determine
	what disk drive this call is for. This is a per-drive call, not a per-driver call.
	
	The only three valid responses to kdgVMOptions at this time are kAllowVMNoneMask,
	kAllowVMReadOnlyMask, and kAllowVMReadWriteMask (i.e., setting only kAllowVMWriteBit
	is not valid).
	
	Important: All bits not defined here are reserved and should be set to zero until
	they are defined for a specific purpose.	
}

TYPE
	DriverGestaltVMOptionsResponsePtr = ^DriverGestaltVMOptionsResponse;
	DriverGestaltVMOptionsResponse = RECORD
		vmOptions:				UInt32;
	END;

{ Bits and masks for DriverGestaltVMOptionsResponse.vmOptions field }

CONST
	kAllowVMReadBit				= 0;							{  Allow VM to use this drive for read access  }
	kAllowVMWriteBit			= 1;							{  Allow VM to use this drive for write access  }
	kAllowVMNoneMask			= 0;
	kAllowVMReadOnlyMask		= $01;
	kAllowVMReadWriteMask		= $03;


{__________________________________________________________________________________}
{ CD-ROM Specific }
{ The CDDeviceCharacteristics result is returned in csParam[0] and csParam[1] of a 
   standard CntrlParam parameter block called with csCode kdgGetCDDeviceInfo.
}

TYPE
	CDDeviceCharacteristicsPtr = ^CDDeviceCharacteristics;
	CDDeviceCharacteristics = RECORD
		speedMajor:				SInt8;									{  High byte of fixed point number containing drive speed  }
		speedMinor:				SInt8;									{  Low byte of "" CD 300 == 2.2, CD_SC == 1.0 etc.  }
		cdFeatures:				UInt16;									{  Flags field for features and transport type of this CD-ROM  }
	END;


CONST
	cdFeatureFlagsMask			= $FFFC;						{  The Flags are in the first 14 bits of the cdFeatures field  }
	cdTransportMask				= $0003;						{  The transport type is in the last 2 bits of the cdFeatures field  }


{ Flags for CD Features field }
	cdMute						= 0;							{  The following flags have the same bit number  }
	cdLeftToChannel				= 1;							{  as the Audio Mode they represent.  Don't change  }
	cdRightToChannel			= 2;							{  them without changing dControl.c  }
	cdLeftPlusRight				= 3;							{  Reserve some space for new audio mixing features (4-7)  }
	cdSCSI_2					= 8;							{  Supports SCSI2 CD Command Set  }
	cdStereoVolume				= 9;							{  Can support two different volumes (1 on each channel)  }
	cdDisconnect				= 10;							{  Drive supports disconnect/reconnect  }
	cdWriteOnce					= 11;							{  Drive is a write/once (CD-R?) type drive  }
	cdMute_Mask					= $01;
	cdLeftToChannel_Mask		= $02;
	cdRightToChannel_Mask		= $04;
	cdLeftPlusRight_Mask		= $08;
	cdSCSI_2_Mask				= $0100;
	cdStereoVolume_Mask			= $0200;
	cdDisconnect_Mask			= $0400;
	cdWriteOnce_Mask			= $0800;

{ Transport types }
	cdCaddy						= 0;							{  CD_SC,CD_SC_PLUS,CD-300 etc.  }
	cdTray						= 1;							{  CD_300_PLUS etc.  }
	cdLid						= 2;							{  Power CD - eg no eject mechanism  }

{  the following are used by PC Exchange (and houdini) }

{  Control Codes }
	kRegisterPartition			= 50;							{  PCX needs a new Drive (for a non-macintosh partition found on the disk) }
	OLD_REGISTER_PARTITION		= 301;							{  left in for compatibility with shipping Houdini }
	THE_DRIVE					= 0;							{  DrvQElPtr for the partition to register }
	THE_PHYS_START				= 1;							{  The start of the partition in logical blocks }
	THE_PHYS_SIZE				= 2;							{  The size of the partition in logical blocks }
	kGetADrive					= 51;							{  control call to ask the driver to create a drive }
	OLD_GET_A_DRIVE				= 302;							{  left in for compatibility with shipping Houdini }
	THE_VAR_QUEL				= 0;							{  a VAR parameter for the returned DrvQElPtr }
	kProhibitMounting			= 52;							{  Dont allow mounting of the following drives }
	kOldProhibitMounting		= 2100;							{  left in for compatibility with shipping Houdini }
	kProhibitDevice				= 0;							{  CS Param 0 and 1 (partInfoRecPtr) }
	kIsContainerMounted			= 53;
	kOldIsContainerMounted		= 2201;							{  left in for compatibility with shipping Houdini			 }
	kContainerVRef				= 0;							{  CS Param 0 and 1 (VRefNum) }
	kContainerParID				= 1;							{  CS Param 2 and 3 (Parent ID) }
	kContainerName				= 2;							{  CS Param 4 and 5 (File Name) }
	kContainerResponse			= 3;							{  CS Param 6 and 7 (VAR pointer to short result) }
	kMountVolumeImg				= 54;
	OLD_MOUNT_VOLUME_IMG		= 2000;
	MV_HOST_VREFNUM				= 0;
	MV_HOST_PAR_ID				= 1;
	MV_HOST_NAME				= 2;
	MV_REQ_PERM					= 3;

{  Status Codes }

	kGetPartitionStatus			= 50;							{  what is the status of this partition? }
	kOldGetPartitionStatus		= 2200;							{  left in for compatibility with shipping Houdini }
	kDeviceToQuery				= 0;							{  CS Param 0 and 1 (partInfoRecPtr) }
	kDeviceResponse				= 1;							{  CS Param 2 and 3 (VAR pointer to short result) }
	kGetPartInfo				= 51;							{  Get a partition info record based on the provided vrefnum }
	kOldGetPartInfo				= 2300;							{  left in for compatibility with shipping Houdini }
	kPartInfoResponse			= 0;							{  var parameter (pointer to partInfoRec) CSParam [0-1] }
	kGetContainerAlias			= 52;							{  Get the alias that describes the file this drive was mounted from. }
	kOldGetContainerAlias		= 2400;							{  left in for compatibility with shipping Houdini }
	kGetAliasResponse			= 0;							{ 	var parameter (pointer to a Handle) CSParam [0-1] }

{  the result codes to come from the driver interface  }

	DRIVER_NOT_INSTALLED		= -1;
	DRIVER_BUSY					= -2;
	CANT_MOUNT_WITHIN_THIS_FS	= -3;							{  can only mount container within residing on HFS volume }
	VOLUME_ALREADY_MOUNTED		= -4;							{  Already Mounted }

{  requisite structures for PCX control and status calls }

	kMaxProhibted				= 2;							{  the max number of volumes the PC can possibly have mounted }

{  GestaltSelector for Finding Driver information }

	kGetDriverInfo				= 'vdrc';

	VerifyCmd					= 5;
	FormatCmd					= 6;
	EjectCmd					= 7;

{  Partition information passed back and forth between PCX and the driver }

TYPE
	partInfoRecPtr = ^partInfoRec;
	partInfoRec = RECORD
		SCSIID:					DeviceIdent;							{  DeviceIdent for the device }
		physPartitionLoc:		UInt32;									{  physical block number of beginning of partition }
		partitionNumber:		UInt32;									{  the partition number of this partition }
	END;

	vPartInfoRecPtr = ^vPartInfoRec;
	vPartInfoRec = RECORD
		VPRTVers:				SInt8;									{  Virtual partition version number }
		VPRTType:				SInt8;									{  virtual partition type (DOS, HFS, etc) }
		drvrRefNum:				SInt16;									{  Driver Reference number of partition driver }
	END;

{  Information related to DOS partitions }

CONST
	kDOSSigLow					= $01FE;						{  offset into boot block for DOS signature }
	kDOSSigHi					= $01FF;						{  offset into boot block for DOS signature }
	kDOSSigValLo				= $55;							{  DOS signature value in low byte }
	kDOSSigValHi				= $AA;							{  DOS signature value in high byte }



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverGestaltIncludes}

{$ENDC} {__DRIVERGESTALT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
