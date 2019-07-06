{
 	File:		Memory.p
 
 	Contains:	Memory Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{
	NOTE
	
	The file "Memory.h" has been renamed to "MacMemory.h" to prevent a collision
	with the "Memory.h" available on other platforms.  MacOS only developers may 
	continue to use #include <Memory.h>.  Developers doing cross-platform work where 
	Memory.h also exists should change their sources to use #include <MacMemory.h>
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Memory;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MEMORY__}
{$SETC __MEMORY__ := 1}

{$I+}
{$SETC MemoryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$ELSEC}
{
	If you get here, your development environment is messed up.
	This file is for MacOS development only.
}
{$ENDC}  {TARGET_OS_MAC}

{$SETC UsingIncludes := MemoryIncludes}

{$ENDC} {__MEMORY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}