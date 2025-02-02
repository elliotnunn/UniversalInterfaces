{
 	File:		PCI.p
 
 	Contains:	PCI Bus Interfaces.
 
 	Version:	Technology:	PowerSurge 1.0.2
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1993-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCI__}
{$SETC __PCI__ := 1}

{$I+}
{$SETC PCIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  Types and structures for accessing the PCI Assigned-Address property. }


CONST
	kPCIRelocatableSpace		= $80;
	kPCIPrefetchableSpace		= $40;
	kPCIAliasedSpace			= $20;
	kPCIAddressTypeCodeMask		= $03;
	kPCIConfigSpace				= 0;
	kPCIIOSpace					= 1;
	kPCI32BitMemorySpace		= 2;
	kPCI64BitMemorySpace		= 3;


TYPE
	PCIAddressSpaceFlags				= UInt8;

CONST
	kPCIDeviceNumberMask		= $1F;
	kPCIFunctionNumberMask		= $07;


TYPE
	PCIDeviceFunction					= UInt8;
	PCIBusNumber						= UInt8;
	PCIRegisterNumber					= UInt8;
	PCIAssignedAddressPtr = ^PCIAssignedAddress;
	PCIAssignedAddress = PACKED RECORD
		addressSpaceFlags:		PCIAddressSpaceFlags;
		busNumber:				PCIBusNumber;
		deviceFunctionNumber:	PCIDeviceFunction;
		registerNumber:			PCIRegisterNumber;
		address:				UnsignedWide;
		size:					UnsignedWide;
	END;


FUNCTION EndianSwap16Bit(data16: UInt16): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $E158, $3E80;
	{$ENDC}
FUNCTION EndianSwap32Bit(data32: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $E158, $4840, $E158, $2E80;
	{$ENDC}
FUNCTION ExpMgrConfigReadByte(node: RegEntryIDPtr; configAddr: LogicalAddress; VAR valuePtr: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0620, $AAF3;
	{$ENDC}
FUNCTION ExpMgrConfigReadWord(node: RegEntryIDPtr; configAddr: LogicalAddress; VAR valuePtr: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0621, $AAF3;
	{$ENDC}
FUNCTION ExpMgrConfigReadLong(node: RegEntryIDPtr; configAddr: LogicalAddress; VAR valuePtr: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0622, $AAF3;
	{$ENDC}
FUNCTION ExpMgrConfigWriteByte(node: RegEntryIDPtr; configAddr: LogicalAddress; value: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0523, $AAF3;
	{$ENDC}
FUNCTION ExpMgrConfigWriteWord(node: RegEntryIDPtr; configAddr: LogicalAddress; value: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0524, $AAF3;
	{$ENDC}
FUNCTION ExpMgrConfigWriteLong(node: RegEntryIDPtr; configAddr: LogicalAddress; value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0625, $AAF3;
	{$ENDC}
FUNCTION ExpMgrIOReadByte(node: RegEntryIDPtr; ioAddr: LogicalAddress; VAR valuePtr: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0626, $AAF3;
	{$ENDC}
FUNCTION ExpMgrIOReadWord(node: RegEntryIDPtr; ioAddr: LogicalAddress; VAR valuePtr: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0627, $AAF3;
	{$ENDC}
FUNCTION ExpMgrIOReadLong(node: RegEntryIDPtr; ioAddr: LogicalAddress; VAR valuePtr: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0628, $AAF3;
	{$ENDC}
FUNCTION ExpMgrIOWriteByte(node: RegEntryIDPtr; ioAddr: LogicalAddress; value: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0529, $AAF3;
	{$ENDC}
FUNCTION ExpMgrIOWriteWord(node: RegEntryIDPtr; ioAddr: LogicalAddress; value: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $052A, $AAF3;
	{$ENDC}
FUNCTION ExpMgrIOWriteLong(node: RegEntryIDPtr; ioAddr: LogicalAddress; value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $062B, $AAF3;
	{$ENDC}
FUNCTION ExpMgrInterruptAcknowledgeReadByte(entry: RegEntryIDPtr; VAR valuePtr: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0411, $AAF3;
	{$ENDC}
FUNCTION ExpMgrInterruptAcknowledgeReadWord(entry: RegEntryIDPtr; VAR valuePtr: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $AAF3;
	{$ENDC}
FUNCTION ExpMgrInterruptAcknowledgeReadLong(entry: RegEntryIDPtr; VAR valuePtr: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $AAF3;
	{$ENDC}
FUNCTION ExpMgrSpecialCycleWriteLong(entry: RegEntryIDPtr; value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0419, $AAF3;
	{$ENDC}
FUNCTION ExpMgrSpecialCycleBroadcastLong(value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021A, $AAF3;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCIIncludes}

{$ENDC} {__PCI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
