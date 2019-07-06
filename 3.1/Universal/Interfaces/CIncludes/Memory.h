/*
 	File:		Memory.h
 
 	Contains:	Memory Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
/*
	NOTE
	
	The file "Memory.h" has been renamed to "MacMemory.h" to prevent a collision
	with the "Memory.h" available on other platforms.  MacOS only developers may 
	continue to use #include <Memory.h>.  Developers doing cross-platform work where 
	Memory.h also exists should change their sources to use #include <MacMemory.h>
*/

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#if TARGET_OS_MAC
#ifndef __MACMEMORY__
#include <MacMemory.h>
#endif
#else
/*
	If you get here, your development environment is messed up.
	This file is for MacOS development only.
*/
#error This file (Memory.h) is for developing MacOS software only!
#endif  /* TARGET_OS_MAC */
