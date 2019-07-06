{
     File:       OSUtils.p
 
     Contains:   OS Utilities Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OSUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSUTILS__}
{$SETC __OSUTILS__ := 1}

{$I+}
{$SETC OSUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{  HandToHand and other memory utilties were moved to MacMemory.h }
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{  GetTrapAddress and other trap table utilties were moved to Patches.h }
{$IFC UNDEFINED __PATCHES__}
{$I Patches.p}
{$ENDC}
{  Date and Time utilties were moved to DateTimeUtils.h }
{$IFC UNDEFINED __DATETIMEUTILS__}
{$I DateTimeUtils.p}
{$ENDC}
{$IFC NOT TARGET_OS_MAC }
{$IFC UNDEFINED __ENDIAN__}
{$I Endian.p}
{$ENDC}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	useFree						= 0;
	useATalk					= 1;
	useAsync					= 2;
	useExtClk					= 3;							{ Externally clocked }
	useMIDI						= 4;

	false32b					= 0;							{ 24 bit addressing error }
	true32b						= 1;							{ 32 bit addressing error }

																{  result types for RelString Call  }
	sortsBefore					= -1;							{ first string < second string }
	sortsEqual					= 0;							{ first string = second string }
	sortsAfter					= 1;							{ first string > second string }

	dummyType					= 0;
	vType						= 1;
	ioQType						= 2;
	drvQType					= 3;
	evType						= 4;
	fsQType						= 5;
	sIQType						= 6;
	dtQType						= 7;
	nmType						= 8;


TYPE
	QTypes								= SignedByte;
	SysParmTypePtr = ^SysParmType;
	SysParmType = PACKED RECORD
		valid:					UInt8;
		aTalkA:					UInt8;
		aTalkB:					UInt8;
		config:					UInt8;
		portA:					INTEGER;
		portB:					INTEGER;
		alarm:					LONGINT;
		font:					INTEGER;
		kbdPrint:				INTEGER;
		volClik:				INTEGER;
		misc:					INTEGER;
	END;

	SysPPtr								= ^SysParmType;
	QElemPtr = ^QElem;
	QElem = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		qData:					ARRAY [0..0] OF INTEGER;
	END;

{$IFC TARGET_OS_MAC }
	QHdrPtr = ^QHdr;
	QHdr = RECORD
		qFlags:					INTEGER;
		qHead:					QElemPtr;
		qTail:					QElemPtr;
	END;

{$ELSEC}
{
   QuickTime 3.0
   this version of QHdr contains the Mutex necessary for
   non-mac non-interrupt code
}
	QHdrPtr = ^QHdr;
	QHdr = RECORD
		qFlags:					INTEGER;
		pad:					INTEGER;
		MutexID:				LONGINT;
		qHead:					QElemPtr;
		qTail:					QElemPtr;
	END;

{$ENDC}  {TARGET_OS_MAC}

{$IFC TYPED_FUNCTION_POINTERS}
	DeferredTaskProcPtr = PROCEDURE(dtParam: LONGINT);
{$ELSEC}
	DeferredTaskProcPtr = Register68kProcPtr;
{$ENDC}

	DeferredTaskUPP = UniversalProcPtr;

CONST
	uppDeferredTaskProcInfo = $0000B802;

FUNCTION NewDeferredTaskUPP(userRoutine: DeferredTaskProcPtr): DeferredTaskUPP; { old name was NewDeferredTaskProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDeferredTaskUPP(userUPP: DeferredTaskUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeDeferredTaskUPP(dtParam: LONGINT; userRoutine: DeferredTaskUPP); { old name was CallDeferredTaskProc }

TYPE
	DeferredTaskPtr = ^DeferredTask;
	DeferredTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		dtFlags:				INTEGER;
		dtAddr:					DeferredTaskUPP;
		dtParam:				LONGINT;
		dtReserved:				LONGINT;
	END;

{$IFC TARGET_OS_MAC }
	MachineLocationPtr = ^MachineLocation;
	MachineLocation = RECORD
		latitude:				Fract;
		longitude:				Fract;
		CASE INTEGER OF
		0: (
			dlsDelta:			SInt8;									{  signed byte; daylight savings delta  }
			);
		1: (
			gmtDelta:			LONGINT;								{  use low 24-bits only  }
			);
	END;

{$ELSEC}
{
    QuickTime 3.0:
    Alignment of MachineLocation is weird. The union above used for delta
    tends not to work on non-Mac compilers.
}
	MachineLocation = RECORD
		latitude:				Fract;
		longitude:				Fract;
		delta:					BigEndianLong;							{  high byte is daylight savings delta, low 24-bits is GMT delta  }
	END;

{$ENDC}  {TARGET_OS_MAC}

FUNCTION IsMetric: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9ED;
	{$ENDC}
FUNCTION GetSysPPtr: SysPPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $01F8;
	{$ENDC}

{
    NOTE: SysBeep() has been moved to Sound.h.  
          We could not automatically #include Sound.h in this file
          because Sound.h indirectly #include's OSUtils.h which
          would make a circular include.
}
FUNCTION DTInstall(dtTaskPtr: DeferredTaskPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A082, $3E80;
	{$ENDC}


{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetMMUMode: SInt8;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $0CB2;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SwapMMUMode(VAR mode: SInt8);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $1010, $A05D, $1080;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE Delay(numTicks: UInt32; VAR finalTicks: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $A03B, $2280;
	{$ENDC}
FUNCTION WriteParam: OSErr;
PROCEDURE Enqueue(qElement: QElemPtr; qHeader: QHdrPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $A96F;
	{$ENDC}
FUNCTION Dequeue(qElement: QElemPtr; qHeader: QHdrPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $A96E, $3E80;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION SetCurrentA5: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E8D, $2A78, $0904;
	{$ENDC}
FUNCTION SetA5(newA5: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F4D, $0004, $2A5F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION InitUtil: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A03F, $3E80;
	{$ENDC}

{$IFC TARGET_CPU_PPC }
PROCEDURE MakeDataExecutable(baseAddress: UNIV Ptr; length: UInt32);
{$ENDC}  {TARGET_CPU_PPC}


{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SwapInstructionCache(cacheEnable: BOOLEAN): BOOLEAN;
FUNCTION SwapDataCache(cacheEnable: BOOLEAN): BOOLEAN;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE FlushInstructionCache;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A098;
	{$ENDC}
PROCEDURE FlushDataCache;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A098;
	{$ENDC}
PROCEDURE FlushCodeCache;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A0BD;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION FlushCodeCacheRange(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7009, $A098, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE ReadLocation(VAR loc: MachineLocation);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $203C, $000C, $00E4, $A051;
	{$ENDC}

PROCEDURE WriteLocation({CONST}VAR loc: MachineLocation);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $203C, $000C, $00E4, $A052;
	{$ENDC}


{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION IUMetric: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9ED;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{
    NOTE: SysEnvirons is obsolete.  You should be using Gestalt.
}
{ Environs Equates }

CONST
	curSysEnvVers				= 2;							{ Updated to equal latest SysEnvirons version }


TYPE
	SysEnvRecPtr = ^SysEnvRec;
	SysEnvRec = RECORD
		environsVersion:		INTEGER;
		machineType:			INTEGER;
		systemVersion:			INTEGER;
		processor:				INTEGER;
		hasFPU:					BOOLEAN;
		hasColorQD:				BOOLEAN;
		keyBoardType:			INTEGER;
		atDrvrVersNum:			INTEGER;
		sysVRefNum:				INTEGER;
	END;


CONST
																{  Machine Types  }
	envMac						= -1;
	envXL						= -2;
	envMachUnknown				= 0;
	env512KE					= 1;
	envMacPlus					= 2;
	envSE						= 3;
	envMacII					= 4;
	envMacIIx					= 5;
	envMacIIcx					= 6;
	envSE30						= 7;
	envPortable					= 8;
	envMacIIci					= 9;
	envMacIIfx					= 11;

																{  CPU types  }
	envCPUUnknown				= 0;
	env68000					= 1;
	env68010					= 2;
	env68020					= 3;
	env68030					= 4;
	env68040					= 5;

																{  Keyboard types  }
	envUnknownKbd				= 0;
	envMacKbd					= 1;
	envMacAndPad				= 2;
	envMacPlusKbd				= 3;
	envAExtendKbd				= 4;
	envStandADBKbd				= 5;
	envPrtblADBKbd				= 6;
	envPrtblISOKbd				= 7;
	envStdISOADBKbd				= 8;
	envExtISOADBKbd				= 9;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION SysEnvirons(versionRequested: INTEGER; VAR theWorld: SysEnvRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $A090, $3E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSUtilsIncludes}

{$ENDC} {__OSUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
