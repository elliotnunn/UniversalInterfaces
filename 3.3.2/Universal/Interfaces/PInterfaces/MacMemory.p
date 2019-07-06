{
     File:       MacMemory.p
 
     Contains:   Memory Manager Interfaces.
 
     Version:    Technology: System 8.5
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
 UNIT MacMemory;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACMEMORY__}
{$SETC __MACMEMORY__ := 1}

{$I+}
{$SETC MacMemoryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	maxSize						= $7FFFFFF0;					{ the largest block possible }

	defaultPhysicalEntryCount	= 8;

																{  values returned from the GetPageState function  }
	kPageInMemory				= 0;
	kPageOnDisk					= 1;
	kNotPaged					= 2;

																{  masks for Zone->heapType field  }
	k32BitHeap					= 1;							{  valid in all Memory Managers  }
	kNewStyleHeap				= 2;							{  true if new Heap Manager is present  }
	kNewDebugHeap				= 4;							{  true if new Heap Manager is running in debug mode on this heap  }

{  Note: The type "Size" moved to Types.h  }



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GrowZoneProcPtr = FUNCTION(cbNeeded: Size): LONGINT;
{$ELSEC}
	GrowZoneProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PurgeProcPtr = PROCEDURE(blockToPurge: Handle);
{$ELSEC}
	PurgeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	UserFnProcPtr = PROCEDURE(parameter: UNIV Ptr);
{$ELSEC}
	UserFnProcPtr = Register68kProcPtr;
{$ENDC}

	GrowZoneUPP = UniversalProcPtr;
	PurgeUPP = UniversalProcPtr;
	UserFnUPP = UniversalProcPtr;
	ZonePtr = ^Zone;
	Zone = RECORD
		bkLim:					Ptr;
		purgePtr:				Ptr;
		hFstFree:				Ptr;
		zcbFree:				LONGINT;
		gzProc:					GrowZoneUPP;
		moreMast:				INTEGER;
		flags:					INTEGER;
		cntRel:					INTEGER;
		maxRel:					INTEGER;
		cntNRel:				INTEGER;
		heapType:				SInt8;									{  previously "maxNRel", now holds flags (e.g. k32BitHeap) }
		unused:					SInt8;
		cntEmpty:				INTEGER;
		cntHandles:				INTEGER;
		minCBFree:				LONGINT;
		purgeProc:				PurgeUPP;
		sparePtr:				Ptr;
		allocPtr:				Ptr;
		heapData:				INTEGER;
	END;

	THz									= ^Zone;
	MemoryBlockPtr = ^MemoryBlock;
	MemoryBlock = RECORD
		address:				Ptr;
		count:					UInt32;
	END;

	LogicalToPhysicalTablePtr = ^LogicalToPhysicalTable;
	LogicalToPhysicalTable = RECORD
		logical:				MemoryBlock;
		physical:				ARRAY [0..7] OF MemoryBlock;
	END;

	PageState							= INTEGER;
	StatusRegisterContents				= INTEGER;

CONST
	kVolumeVirtualMemoryInfoVersion1 = 1;						{  first version of VolumeVirtualMemoryInfo }


TYPE
	VolumeVirtualMemoryInfoPtr = ^VolumeVirtualMemoryInfo;
	VolumeVirtualMemoryInfo = RECORD
		version:				PBVersion;								{  Input: Version of the VolumeVirtualMemoryInfo structure }
		volumeRefNum:			SInt16;									{  Input: volume reference number }
		inUse:					BOOLEAN;								{  output: true if volume is currently used for file mapping }
		_fill:					SInt8;
		vmOptions:				UInt32;									{  output: tells what volume can support (same as DriverGestaltVMOptionsResponse vmOptions bits in DriverGestalt) }
																		{  end of kVolumeVirtualMemoryInfoVersion1 structure }
	END;


CONST
	uppGrowZoneProcInfo = $000000F0;
	uppPurgeProcInfo = $000000C0;
	uppUserFnProcInfo = $00009802;

FUNCTION NewGrowZoneUPP(userRoutine: GrowZoneProcPtr): GrowZoneUPP; { old name was NewGrowZoneProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPurgeUPP(userRoutine: PurgeProcPtr): PurgeUPP; { old name was NewPurgeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserFnUPP(userRoutine: UserFnProcPtr): UserFnUPP; { old name was NewUserFnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeGrowZoneUPP(userUPP: GrowZoneUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposePurgeUPP(userUPP: PurgeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeUserFnUPP(userUPP: UserFnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeGrowZoneUPP(cbNeeded: Size; userRoutine: GrowZoneUPP): LONGINT; { old name was CallGrowZoneProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokePurgeUPP(blockToPurge: Handle; userRoutine: PurgeUPP); { old name was CallPurgeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeUserFnUPP(parameter: UNIV Ptr; userRoutine: UserFnUPP); { old name was CallUserFnProc }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetApplLimit: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0130;
	{$ENDC}
FUNCTION SystemZone: THz;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02A6;
	{$ENDC}
FUNCTION ApplicationZone: THz;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02AA;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION GZSaveHnd: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0328;
	{$ENDC}
FUNCTION TopMem: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0108;
	{$ENDC}
FUNCTION MemError: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0220;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetZone: THz;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A11A, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewHandle(byteCount: Size): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A122, $2E88;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION NewHandleSys(byteCount: Size): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A522, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewHandleClear(byteCount: Size): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A322, $2E88;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION NewHandleSysClear(byteCount: Size): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A722, $2E88;
	{$ENDC}
FUNCTION HandleZone(h: Handle): THz;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A126, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION RecoverHandle(p: Ptr): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A128, $2E88;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION RecoverHandleSys(p: Ptr): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A528, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewPtr(byteCount: Size): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A11E, $2E88;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION NewPtrSys(byteCount: Size): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A51E, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewPtrClear(byteCount: Size): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A31E, $2E88;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION NewPtrSysClear(byteCount: Size): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A71E, $2E88;
	{$ENDC}
FUNCTION PtrZone(p: Ptr): THz;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A148, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION MaxBlock: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A061, $2E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION MaxBlockSys: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A461, $2E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION StackSpace: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A065, $2E80;
	{$ENDC}
FUNCTION NewEmptyHandle: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A166, $2E88;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION NewEmptyHandleSys: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A566, $2E88;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE HLock(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A029;
	{$ENDC}
PROCEDURE HUnlock(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A02A;
	{$ENDC}
PROCEDURE HPurge(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A049;
	{$ENDC}
PROCEDURE HNoPurge(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A04A;
	{$ENDC}
PROCEDURE HLockHi(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A064, $A029;
	{$ENDC}
FUNCTION TempNewHandle(logicalSize: Size; VAR resultCode: OSErr): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001D, $A88F;
	{$ENDC}
FUNCTION TempMaxMem(VAR grow: Size): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0015, $A88F;
	{$ENDC}
FUNCTION TempFreeMem: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0018, $A88F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE InitZone(pgrowZone: GrowZoneUPP; cmoreMasters: INTEGER; limitPtr: UNIV Ptr; startPtr: UNIV Ptr);
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetZone(hz: THz);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A01B;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION CompactMem(cbNeeded: Size): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A04C, $2E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CompactMemSys(cbNeeded: Size): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A44C, $2E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE PurgeMem(cbNeeded: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A04D;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE PurgeMemSys(cbNeeded: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A44D;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION FreeMem: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A01C, $2E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION FreeMemSys: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A41C, $2E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE ReserveMem(cbNeeded: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A040;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE ReserveMemSys(cbNeeded: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A440;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION MaxMem(VAR grow: Size): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $A11D, $2288, $2E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION MaxMemSys(VAR grow: Size): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $A51D, $2288, $2E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE SetGrowZone(growZone: GrowZoneUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A04B;
	{$ENDC}
PROCEDURE MoveHHi(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A064;
	{$ENDC}
PROCEDURE DisposePtr(p: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A01F;
	{$ENDC}
FUNCTION GetPtrSize(p: Ptr): Size;
PROCEDURE SetPtrSize(p: Ptr; newSize: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A020;
	{$ENDC}
PROCEDURE DisposeHandle(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A023;
	{$ENDC}
PROCEDURE SetHandleSize(h: Handle; newSize: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A024;
	{$ENDC}
{ 
    NOTE
    
    GetHandleSize and GetPtrSize are documented in Inside Mac as returning 0 
    in case of an error, but the traps actually return an error code in D0.
    The glue sets D0 to 0 if an error occurred.
}
FUNCTION GetHandleSize(h: Handle): Size;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InlineGetHandleSize(h: Handle): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A025, $2E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE ReallocateHandle(h: Handle; byteCount: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A027;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE ReallocateHandleSys(h: Handle; byteCount: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A427;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE EmptyHandle(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A02B;
	{$ENDC}
PROCEDURE HSetRBit(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A067;
	{$ENDC}
PROCEDURE HClrRBit(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A068;
	{$ENDC}
FUNCTION HGetState(h: Handle): SInt8;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A069, $1E80;
	{$ENDC}
PROCEDURE HSetState(h: Handle; flags: SInt8);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $205F, $A06A;
	{$ENDC}
PROCEDURE PurgeSpace(VAR total: LONGINT; VAR contig: LONGINT);
{
    PurgeSpaceTotal and PurgeSpaceContiguous are currently only implement
    on classic 68K.  The are the same as PurgeSpace() but return just
    one value (either total space purgable or contiguous space purgable).
    Begining in Mac OS 8.5 they are available in InterfaceLib.
}
FUNCTION PurgeSpaceTotal: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A062, $2E88;
	{$ENDC}
FUNCTION PurgeSpaceContiguous: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A062, $2E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PurgeSpaceSysTotal: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A562, $2E88;
	{$ENDC}
FUNCTION PurgeSpaceSysContiguous: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A562, $2E80;
	{$ENDC}

{****************************************************************************

    The routines: 

        BlockMoveUncached, BlockMoveDataUncached
        BlockZero, BlockZeroUncached
    
    were first created for developers writing drivers. Originally they only
    existed in DriverServicesLib.  Later they were added to InterfaceLib 
    in PCI based PowerMacs.  MacOS 8.5 provides these routines in InterfaceLib
    on all supported machines. 
    
****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE BlockMove(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $225F, $205F, $A02E;
	{$ENDC}
PROCEDURE BlockMoveData(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $225F, $205F, $A22E;
	{$ENDC}
PROCEDURE BlockMoveUncached(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size); C;
PROCEDURE BlockMoveDataUncached(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size); C;
PROCEDURE BlockZero(destPtr: UNIV Ptr; byteCount: Size); C;
PROCEDURE BlockZeroUncached(destPtr: UNIV Ptr; byteCount: Size); C;

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE MaxApplZone;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A063;
	{$ENDC}
PROCEDURE SetApplBase(startPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A057;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE MoreMasters;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A036;
	{$ENDC}
PROCEDURE MoreMasterPointers(inCount: UInt32); C;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetApplLimit(zoneLimit: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A02D;
	{$ENDC}
PROCEDURE InitApplZone;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A02C;
	{$ENDC}

{  Temporary Memory routines renamed, but obsolete, in System 7.0 and later.  }
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE TempHLock(h: Handle; VAR resultCode: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001E, $A88F;
	{$ENDC}
PROCEDURE TempHUnlock(h: Handle; VAR resultCode: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001F, $A88F;
	{$ENDC}
PROCEDURE TempDisposeHandle(h: Handle; VAR resultCode: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A88F;
	{$ENDC}
FUNCTION TempTopMem: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0016, $A88F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION HoldMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7000, $A05C, $3E80;
	{$ENDC}
FUNCTION UnholdMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7001, $A05C, $3E80;
	{$ENDC}
FUNCTION LockMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7002, $A05C, $3E80;
	{$ENDC}
FUNCTION LockMemoryForOutput(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $700A, $A05C, $3E80;
	{$ENDC}
FUNCTION LockMemoryContiguous(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7004, $A05C, $3E80;
	{$ENDC}
FUNCTION UnlockMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7003, $A05C, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION MakeMemoryResident(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $700B, $A05C, $3E80;
	{$ENDC}
FUNCTION ReleaseMemoryData(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $700C, $A05C, $3E80;
	{$ENDC}
FUNCTION MakeMemoryNonResident(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $700D, $A05C, $3E80;
	{$ENDC}
FUNCTION FlushMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $700E, $A05C, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetPhysical(VAR addresses: LogicalToPhysicalTable; VAR physicalEntryCount: UInt32): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetVolumeVirtualMemoryInfo(volVMInfo: VolumeVirtualMemoryInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700F, $A05C, $3E80;
	{$ENDC}
FUNCTION DeferUserFn(userFunction: UserFnUPP; argument: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A08F, $3E80;
	{$ENDC}
FUNCTION DebuggerGetMax: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A08D, $2E80;
	{$ENDC}
PROCEDURE DebuggerEnter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A08D;
	{$ENDC}
PROCEDURE DebuggerExit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A08D;
	{$ENDC}
PROCEDURE DebuggerPoll;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A08D;
	{$ENDC}
FUNCTION GetPageState(address: UNIV Ptr): PageState;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7004, $A08D, $3E80;
	{$ENDC}
FUNCTION PageFaultFatal: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A08D, $1E80;
	{$ENDC}
FUNCTION DebuggerLockMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7006, $A08D, $3E80;
	{$ENDC}
FUNCTION DebuggerUnlockMemory(address: UNIV Ptr; count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $7007, $A08D, $3E80;
	{$ENDC}
FUNCTION EnterSupervisorMode: StatusRegisterContents;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A08D, $3E80;
	{$ENDC}

{ 
    StripAddress is a trap on classic 68K and the
    identity function on PowerMacs and other OS's.
}
FUNCTION StripAddress(theAddress: UNIV Ptr): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A055, $2E80;
	{$ENDC}
{ 
    Translate24To32 is a trap on classic 68K and the
    identity function on PowerMacs and other OS's.
}
FUNCTION Translate24To32(addr24: UNIV Ptr): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A091, $2E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION HandToHand(VAR theHndl: Handle): OSErr;
FUNCTION PtrToXHand(srcPtr: UNIV Ptr; dstHndl: Handle; size: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $225F, $205F, $A9E2, $3E80;
	{$ENDC}
FUNCTION PtrToHand(srcPtr: UNIV Ptr; VAR dstHndl: Handle; size: LONGINT): OSErr;
FUNCTION HandAndHand(hand1: Handle; hand2: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $A9E4, $3E80;
	{$ENDC}
FUNCTION PtrAndHand(ptr1: UNIV Ptr; hand2: Handle; size: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $225F, $205F, $A9EF, $3E80;
	{$ENDC}
{ Carbon routines to aid in debugging. }
{ Checks all applicable heaps for validity }
FUNCTION CheckAllHeaps: BOOLEAN;
{ Checks the application heap for validity }
FUNCTION IsHeapValid: BOOLEAN;
{ It is invalid to pass a NULL or an empty Handle to IsHandleValid }
FUNCTION IsHandleValid(h: Handle): BOOLEAN;
{ It is invalid to pass a NULL Pointer to IsPointerValid }
FUNCTION IsPointerValid(p: Ptr): BOOLEAN;

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION ApplicZone: THz;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02AA;
	{$ENDC}
FUNCTION MFTempNewHandle(logicalSize: Size; VAR resultCode: OSErr): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001D, $A88F;
	{$ENDC}
FUNCTION MFMaxMem(VAR grow: Size): Size;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0015, $A88F;
	{$ENDC}
FUNCTION MFFreeMem: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0018, $A88F;
	{$ENDC}
PROCEDURE MFTempHLock(h: Handle; VAR resultCode: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001E, $A88F;
	{$ENDC}
PROCEDURE MFTempHUnlock(h: Handle; VAR resultCode: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001F, $A88F;
	{$ENDC}
PROCEDURE MFTempDisposHandle(h: Handle; VAR resultCode: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A88F;
	{$ENDC}
FUNCTION MFTopMem: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0016, $A88F;
	{$ENDC}
PROCEDURE ResrvMem(cbNeeded: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A040;
	{$ENDC}
PROCEDURE DisposPtr(p: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A01F;
	{$ENDC}
PROCEDURE DisposHandle(h: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A023;
	{$ENDC}
PROCEDURE ReallocHandle(h: Handle; byteCount: Size);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A027;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacMemoryIncludes}

{$ENDC} {__MACMEMORY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
