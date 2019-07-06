{
 	File:		DriverSynchronization.p
 
 	Contains:	Driver Synchronization Interfaces.
 
 	Version:	Technology:	MacOS
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DriverSynchronization;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERSYNCHRONIZATION__}
{$SETC __DRIVERSYNCHRONIZATION__ := 1}

{$I+}
{$SETC DriverSynchronizationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

PROCEDURE SynchronizeIO; C;
FUNCTION CompareAndSwap(oldVvalue: UInt32; newValue: UInt32; VAR OldValueAdr: UInt32): BOOLEAN; C;
FUNCTION TestAndClear(bit: UInt32; VAR startAddress: UInt8): BOOLEAN; C;
FUNCTION TestAndSet(bit: UInt32; VAR startAddress: UInt8): BOOLEAN; C;
FUNCTION IncrementAtomic8(VAR value: SInt8): SInt8; C;
FUNCTION DecrementAtomic8(VAR value: SInt8): SInt8; C;
FUNCTION AddAtomic8(amount: SInt32; VAR value: SInt8): SInt8; C;
FUNCTION BitAndAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;
FUNCTION BitOrAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;
FUNCTION BitXorAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;
FUNCTION IncrementAtomic16(VAR value: SInt16): SInt16; C;
FUNCTION DecrementAtomic16(VAR value: SInt16): SInt16; C;
FUNCTION AddAtomic16(amount: SInt32; VAR value: SInt16): SInt16; C;
FUNCTION BitAndAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;
FUNCTION BitOrAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;
FUNCTION BitXorAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;
FUNCTION IncrementAtomic(VAR value: SInt32): SInt32; C;
FUNCTION DecrementAtomic(VAR value: SInt32): SInt32; C;
FUNCTION AddAtomic(amount: SInt32; VAR value: SInt32): SInt32; C;
FUNCTION BitAndAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;
FUNCTION BitOrAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;
FUNCTION BitXorAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverSynchronizationIncludes}

{$ENDC} {__DRIVERSYNCHRONIZATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
