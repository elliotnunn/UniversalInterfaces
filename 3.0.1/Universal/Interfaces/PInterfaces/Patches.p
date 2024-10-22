{
 	File:		Patches.p
 
 	Contains:	Patch Manager Interfaces.
 
 	Version:	Technology:	System 8
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Patches;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PATCHES__}
{$SETC __PATCHES__ := 1}

{$I+}
{$SETC PatchesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_OS_MAC }

CONST
	kOSTrapType					= 0;
	kToolboxTrapType			= 1;


TYPE
	TrapType							= SignedByte;

CONST
	OSTrap						= 0;							{  old name  }
	ToolTrap					= 1;							{  old name  }

{
	GetTrapAddress and SetTrapAddress are obsolete and should not
	be used. Always use NGetTrapAddress and NSetTrapAddress instead.
	The old routines will not be supported for PowerPC apps.
}
{$IFC OLDROUTINENAMES AND NOT TARGET_RT_MAC_CFM }
FUNCTION GetTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A146, $2E88;
	{$ENDC}
PROCEDURE SetTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A047;
	{$ENDC}
{$ENDC}
FUNCTION NGetTrapAddress(trapNum: UInt16; tTyp: TrapType): UniversalProcPtr;
PROCEDURE NSetTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16; tTyp: TrapType);
FUNCTION GetOSTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A346, $2E88;
	{$ENDC}
PROCEDURE SetOSTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A247;
	{$ENDC}
FUNCTION GetToolTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A746, $2E88;
	{$ENDC}
PROCEDURE SetToolTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A647;
	{$ENDC}
FUNCTION GetToolboxTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A746, $2E88;
	{$ENDC}
PROCEDURE SetToolboxTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A647;
	{$ENDC}
{$IFC TARGET_CPU_PPC }
FUNCTION GetTrapVector(trapNumber: UInt16): UniversalProcHandle;
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PatchesIncludes}

{$ENDC} {__PATCHES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
