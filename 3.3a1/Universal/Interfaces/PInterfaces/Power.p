{
 	File:		Power.p
 
 	Contains:	Power Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1990-1999 by Apple Computer, Inc.  All rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Power;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __POWER__}
{$SETC __POWER__ := 1}

{$I+}
{$SETC PowerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MULTIPROCESSING__}
{$I Multiprocessing.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Bit positions for ModemByte  }
	modemOnBit					= 0;
	ringWakeUpBit				= 2;
	modemInstalledBit			= 3;
	ringDetectBit				= 4;
	modemOnHookBit				= 5;

																{  masks for ModemByte  }
	modemOnMask					= $01;
	ringWakeUpMask				= $04;
	modemInstalledMask			= $08;
	ringDetectMask				= $10;
	modemOnHookMask				= $20;

																{  bit positions for BatteryByte  }
	chargerConnBit				= 0;
	hiChargeBit					= 1;
	chargeOverFlowBit			= 2;
	batteryDeadBit				= 3;
	batteryLowBit				= 4;
	connChangedBit				= 5;

																{  masks for BatteryByte  }
	chargerConnMask				= $01;
	hiChargeMask				= $02;
	chargeOverFlowMask			= $04;
	batteryDeadMask				= $08;
	batteryLowMask				= $10;
	connChangedMask				= $20;

																{  bit positions for SoundMixerByte  }
	MediaBaySndEnBit			= 0;
	PCISndEnBit					= 1;
	ZVSndEnBit					= 2;
	PCCardSndEnBit				= 3;

																{  masks for SoundMixerByte  }
	MediaBaySndEnMask			= $01;
	PCISndEnMask				= $02;
	ZVSndEnMask					= $04;
	PCCardSndEnMask				= $08;

																{  commands to SleepQRec sleepQProc  }
	sleepRequest				= 1;
	sleepDemand					= 2;
	sleepWakeUp					= 3;
	sleepRevoke					= 4;
	sleepUnlock					= 4;
	sleepDeny					= 5;
	sleepNow					= 6;
	dozeDemand					= 7;
	dozeWakeUp					= 8;
	dozeRequest					= 9;

																{  SleepQRec.sleepQFlags  }
	noCalls						= 1;
	noRequest					= 2;
	slpQType					= 16;
	sleepQType					= 16;

{ bits in bitfield returned by PMFeatures }
	hasWakeupTimer				= 0;							{  1=wakeup timer is supported								 }
	hasSharedModemPort			= 1;							{  1=modem port shared by SCC and internal modem			 }
	hasProcessorCycling			= 2;							{  1=processor cycling is supported							 }
	mustProcessorCycle			= 3;							{  1=processor cycling should not be turned off				 }
	hasReducedSpeed				= 4;							{  1=processor can be started up at reduced speed			 }
	dynamicSpeedChange			= 5;							{  1=processor speed can be switched dynamically			 }
	hasSCSIDiskMode				= 6;							{  1=SCSI Disk Mode is supported							 }
	canGetBatteryTime			= 7;							{  1=battery time can be calculated							 }
	canWakeupOnRing				= 8;							{  1=can wakeup when the modem detects a ring				 }
	hasDimmingSupport			= 9;							{  1=has dimming support built in (DPMS standby by default)	 }
	hasStartupTimer				= 10;							{  1=startup timer is supported								 }
	hasChargeNotification		= 11;							{  1=client can determine of charge connect status change notifications available  }
	hasDimSuspendSupport		= 12;							{  1=supports dimming LCD and CRT to DPMS suspend state		 }

{ bits in bitfield returned by GetIntModemInfo and set by SetIntModemState }
	hasInternalModem			= 0;							{  1=internal modem installed						 }
	intModemRingDetect			= 1;							{  1=internal modem has detected a ring				 }
	intModemOffHook				= 2;							{  1=internal modem is off hook						 }
	intModemRingWakeEnb			= 3;							{  1=wakeup on ring is enabled						 }
	extModemSelected			= 4;							{  1=external modem selected						 }
	modemSetBit					= 15;							{  1=set bit, 0=clear bit (SetIntModemState)		 }

{ bits in BatteryInfo.flags 									}
{ ("chargerConnected" doesn't mean the charger is plugged in)	}
	batteryInstalled			= 7;							{  1=battery is currently connected					 }
	batteryCharging				= 6;							{  1=battery is being charged						 }
	chargerConnected			= 5;							{  1=charger is connected to the PowerBook			 }

	HDPwrQType					= $4844;						{  'HD' hard disk spindown queue element type		 }
	PMgrStateQType				= $504D;						{  'PM' Power Manager state queue element type		 }

{ client notification bits in PMgrQueueElement.pmNotifyBits }
	pmSleepTimeoutChanged		= 0;
	pmSleepEnableChanged		= 1;
	pmHardDiskTimeoutChanged	= 2;
	pmHardDiskSpindownChanged	= 3;
	pmDimmingTimeoutChanged		= 4;
	pmDimmingEnableChanged		= 5;
	pmDiskModeAddressChanged	= 6;
	pmProcessorCyclingChanged	= 7;
	pmProcessorSpeedChanged		= 8;
	pmWakeupTimerChanged		= 9;
	pmStartupTimerChanged		= 10;
	pmHardDiskPowerRemovedbyUser = 11;
	pmChargeStatusChanged		= 12;
	pmPowerLevelChanged			= 13;
	pmWakeOnNetActivityChanged	= 14;

	pmSleepTimeoutChangedMask	= $01;
	pmSleepEnableChangedMask	= $02;
	pmHardDiskTimeoutChangedMask = $04;
	pmHardDiskSpindownChangedMask = $08;
	pmDimmingTimeoutChangedMask	= $10;
	pmDimmingEnableChangedMask	= $20;
	pmDiskModeAddressChangedMask = $40;
	pmProcessorCyclingChangedMask = $80;
	pmProcessorSpeedChangedMask	= $0100;
	pmWakeupTimerChangedMask	= $0200;
	pmStartupTimerChangedMask	= $0400;
	pmHardDiskPowerRemovedbyUserMask = $0800;
	pmChargeStatusChangedMask	= $1000;
	pmPowerLevelChangedMask		= $2000;
	pmWakeOnNetActivityChangedMask = $4000;

{ System Activity Selectors }
	OverallAct					= 0;							{  general type of activity							 }
	UsrActivity					= 1;							{  user specific type of activity					 }
	NetActivity					= 2;							{  network specific activity						 }
	HDActivity					= 3;							{  Hard Drive activity								 }

{ Storage Media sleep mode defines }
	kMediaModeOn				= 0;							{  Media active (Drive spinning and at full power)	 }
	kMediaModeStandBy			= 1;							{  Media standby (not implemented)	 }
	kMediaModeSuspend			= 2;							{  Media Idle (not implemented)	 }
	kMediaModeOff				= 3;							{  Media Sleep (Drive not spinning and at min power, max recovery time)	 }

	kMediaPowerCSCode			= 70;


{ definitions for HDQueueElement.hdFlags	}
	kHDQueuePostBit				= 0;							{  1 = call this routine on the second pass		 }
	kHDQueuePostMask			= $01;


TYPE
	ActivityInfoPtr = ^ActivityInfo;
	ActivityInfo = RECORD
		ActivityType:			INTEGER;								{  Type of activity to be fetched.  Same as UpdateSystemActivity Selectors  }
		ActivityTime:			UInt32;									{  Time of last activity (in ticks) of specified type.  }
	END;

{ information returned by GetScaledBatteryInfo }
	BatteryInfoPtr = ^BatteryInfo;
	BatteryInfo = PACKED RECORD
		flags:					UInt8;									{  misc flags (see below)							 }
		warningLevel:			UInt8;									{  scaled warning level (0-255)						 }
		reserved:				UInt8;									{  reserved for internal use						 }
		batteryLevel:			UInt8;									{  scaled battery level (0-255)						 }
	END;

	ModemByte							= SInt8;
	BatteryByte							= SInt8;
	SoundMixerByte						= SInt8;
	PMResultCode						= LONGINT;
	SleepQRecPtr = ^SleepQRec;
	HDQueueElementPtr = ^HDQueueElement;
	PMgrQueueElementPtr = ^PMgrQueueElement;
{$IFC TYPED_FUNCTION_POINTERS}
	SleepQProcPtr = FUNCTION(message: LONGINT; qRecPtr: SleepQRecPtr): LONGINT;
{$ELSEC}
	SleepQProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HDSpindownProcPtr = PROCEDURE(theElement: HDQueueElementPtr);
{$ELSEC}
	HDSpindownProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMgrStateChangeProcPtr = PROCEDURE(theElement: PMgrQueueElementPtr; stateBits: LONGINT);
{$ELSEC}
	PMgrStateChangeProcPtr = ProcPtr;
{$ENDC}

	SleepQUPP = UniversalProcPtr;
	HDSpindownUPP = UniversalProcPtr;
	PMgrStateChangeUPP = UniversalProcPtr;
	SleepQRec = RECORD
		sleepQLink:				SleepQRecPtr;							{  pointer to next queue element				 }
		sleepQType:				INTEGER;								{  queue element type (must be SleepQType)		 }
		sleepQProc:				SleepQUPP;								{  pointer to sleep universal proc ptr			 }
		sleepQFlags:			INTEGER;								{  flags										 }
	END;

	HDQueueElement = RECORD
		hdQLink:				HDQueueElementPtr;						{  pointer to next queue element				 }
		hdQType:				INTEGER;								{  queue element type (must be HDPwrQType)		 }
		hdFlags:				INTEGER;								{  miscellaneous flags							 }
		hdProc:					HDSpindownUPP;							{  pointer to routine to call					 }
		hdUser:					LONGINT;								{  user-defined (variable storage, etc.)		 }
	END;

	PMgrQueueElement = RECORD
		pmQLink:				PMgrQueueElementPtr;					{  pointer to next queue element				 }
		pmQType:				INTEGER;								{  queue element type (must be PMgrStateQType)	 }
		pmFlags:				INTEGER;								{  miscellaneous flags							 }
		pmNotifyBits:			LONGINT;								{  bitmap of which changes to be notified for	 }
		pmProc:					PMgrStateChangeUPP;						{  pointer to routine to call					 }
		pmUser:					LONGINT;								{  user-defined (variable storage, etc.)		 }
	END;


	BatteryTimeRecPtr = ^BatteryTimeRec;
	BatteryTimeRec = RECORD
		expectedBatteryTime:	UInt32;									{  estimated battery time remaining (seconds)	 }
		minimumBatteryTime:		UInt32;									{  minimum battery time remaining (seconds)		 }
		maximumBatteryTime:		UInt32;									{  maximum battery time remaining (seconds)		 }
		timeUntilCharged:		UInt32;									{  time until battery is fully charged (seconds) }
	END;


	WakeupTimePtr = ^WakeupTime;
	WakeupTime = RECORD
		wakeTime:				UInt32;									{  wakeup time (same format as current time)		 }
		wakeEnabled:			BOOLEAN;								{  1=enable wakeup timer, 0=disable wakeup timer	 }
		filler:					SInt8;
	END;


	StartupTimePtr = ^StartupTime;
	StartupTime = RECORD
		startTime:				UInt32;									{  startup time (same format as current time)		 }
		startEnabled:			BOOLEAN;								{  1=enable startup timer, 0=disable startup timer	 }
		filler:					SInt8;
	END;

FUNCTION DisableWUTime: OSErr;
FUNCTION SetWUTime(wuTime: LONGINT): OSErr;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetWUTime(VAR wuTime: LONGINT; VAR wuFlag: SignedByte): OSErr;
FUNCTION BatteryStatus(VAR status: SignedByte; VAR power: SignedByte): OSErr;
FUNCTION ModemStatus(VAR status: SignedByte): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION IdleUpdate: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A285, $2E80;
	{$ENDC}
FUNCTION GetCPUSpeed: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $A485, $2E80;
	{$ENDC}
PROCEDURE EnableIdle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A485;
	{$ENDC}
PROCEDURE DisableIdle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A485;
	{$ENDC}
PROCEDURE SleepQInstall(qRecPtr: SleepQRecPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A28A;
	{$ENDC}
PROCEDURE SleepQRemove(qRecPtr: SleepQRecPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A48A;
	{$ENDC}
PROCEDURE AOn;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $A685;
	{$ENDC}
PROCEDURE AOnIgnoreModem;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A685;
	{$ENDC}
PROCEDURE BOn;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A685;
	{$ENDC}
PROCEDURE AOff;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7084, $A685;
	{$ENDC}
PROCEDURE BOff;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7080, $A685;
	{$ENDC}

{ Public Power Management API  }
FUNCTION PMSelectorCount: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A09E, $3E80;
	{$ENDC}
FUNCTION PMFeatures: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A09E, $2E80;
	{$ENDC}
FUNCTION GetSleepTimeout: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetSleepTimeout(timeout: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0003, $A09E;
	{$ENDC}
FUNCTION GetHardDiskTimeout: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetHardDiskTimeout(timeout: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0005, $A09E;
	{$ENDC}
FUNCTION HardDiskPowered: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $A09E, $1E80;
	{$ENDC}
PROCEDURE SpinDownHardDisk;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $A09E;
	{$ENDC}
FUNCTION IsSpindownDisabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetSpindownDisable(setDisable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0009, $A09E;
	{$ENDC}
FUNCTION HardDiskQInstall(VAR theElement: HDQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A09E, $3E80;
	{$ENDC}
FUNCTION HardDiskQRemove(VAR theElement: HDQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700B, $A09E, $3E80;
	{$ENDC}
PROCEDURE GetScaledBatteryInfo(whichBattery: INTEGER; VAR theInfo: BatteryInfo);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $4840, $303C, $000C, $A09E, $2080;
	{$ENDC}
PROCEDURE AutoSleepControl(enableSleep: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $000D, $A09E;
	{$ENDC}
FUNCTION GetIntModemInfo: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $A09E, $2E80;
	{$ENDC}
PROCEDURE SetIntModemState(theState: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $000F, $A09E;
	{$ENDC}
FUNCTION MaximumProcessorSpeed: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $A09E, $3E80;
	{$ENDC}
FUNCTION CurrentProcessorSpeed: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $A09E, $3E80;
	{$ENDC}
FUNCTION FullProcessorSpeed: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $A09E, $1E80;
	{$ENDC}
FUNCTION SetProcessorSpeed(fullSpeed: BOOLEAN): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0013, $A09E, $1E80;
	{$ENDC}
FUNCTION GetSCSIDiskModeAddress: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $A09E, $3E80;
	{$ENDC}
PROCEDURE SetSCSIDiskModeAddress(scsiAddress: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $0015, $A09E;
	{$ENDC}
PROCEDURE GetWakeupTimer(VAR theTime: WakeupTime);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7016, $A09E;
	{$ENDC}
PROCEDURE SetWakeupTimer(VAR theTime: WakeupTime);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7017, $A09E;
	{$ENDC}
FUNCTION IsProcessorCyclingEnabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $A09E, $1E80;
	{$ENDC}
PROCEDURE EnableProcessorCycling(enable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0019, $A09E;
	{$ENDC}
FUNCTION BatteryCount: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $A09E, $3E80;
	{$ENDC}
FUNCTION GetBatteryVoltage(whichBattery: INTEGER): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $001B, $A09E, $2E80;
	{$ENDC}
PROCEDURE GetBatteryTimes(whichBattery: INTEGER; VAR theTimes: BatteryTimeRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $4840, $303C, $001C, $A09E;
	{$ENDC}
FUNCTION GetDimmingTimeout: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetDimmingTimeout(timeout: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $001E, $A09E;
	{$ENDC}
PROCEDURE DimmingControl(enableSleep: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $001F, $A09E;
	{$ENDC}
FUNCTION IsDimmingControlDisabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $A09E, $1E80;
	{$ENDC}
FUNCTION IsAutoSlpControlDisabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $A09E, $1E80;
	{$ENDC}
FUNCTION PMgrStateQInstall(VAR theElement: PMgrQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7022, $A09E, $3E80;
	{$ENDC}
FUNCTION PMgrStateQRemove(VAR theElement: PMgrQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7023, $A09E, $3E80;
	{$ENDC}
FUNCTION UpdateSystemActivity(activity: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0024, $A09E, $3E80;
	{$ENDC}
FUNCTION DelaySystemIdle: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $A09E, $3E80;
	{$ENDC}
FUNCTION GetStartupTimer(VAR theTime: StartupTime): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7026, $A09E, $3E80;
	{$ENDC}
FUNCTION SetStartupTimer(VAR theTime: StartupTime): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7027, $A09E, $3E80;
	{$ENDC}
FUNCTION GetLastActivity(VAR theActivity: ActivityInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7028, $A09E, $3E80;
	{$ENDC}
FUNCTION GetSoundMixerState(VAR theSoundMixerByte: SoundMixerByte): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7029, $A09E, $3E80;
	{$ENDC}
FUNCTION SetSoundMixerState(VAR theSoundMixerByte: SoundMixerByte): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702A, $A09E, $3E80;
	{$ENDC}
FUNCTION GetDimSuspendState: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetDimSuspendState(dimSuspendState: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $002C, $A09E;
	{$ENDC}

CONST
	uppSleepQProcInfo = $00131832;
	uppHDSpindownProcInfo = $000000C0;
	uppPMgrStateChangeProcInfo = $000003C0;

FUNCTION NewSleepQUPP(userRoutine: SleepQProcPtr): SleepQUPP; { old name was NewSleepQProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHDSpindownUPP(userRoutine: HDSpindownProcPtr): HDSpindownUPP; { old name was NewHDSpindownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPMgrStateChangeUPP(userRoutine: PMgrStateChangeProcPtr): PMgrStateChangeUPP; { old name was NewPMgrStateChangeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeSleepQUPP(userUPP: SleepQUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeHDSpindownUPP(userUPP: HDSpindownUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposePMgrStateChangeUPP(userUPP: PMgrStateChangeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeSleepQUPP(message: LONGINT; qRecPtr: SleepQRecPtr; userRoutine: SleepQUPP): LONGINT; { old name was CallSleepQProc }

PROCEDURE InvokeHDSpindownUPP(theElement: HDQueueElementPtr; userRoutine: HDSpindownUPP); { old name was CallHDSpindownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokePMgrStateChangeUPP(theElement: PMgrQueueElementPtr; stateBits: LONGINT; userRoutine: PMgrStateChangeUPP); { old name was CallPMgrStateChangeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PowerIncludes}

{$ENDC} {__POWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
