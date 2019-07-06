/*
 	File:		Types.h
 
 	Contains:	Basic Macintosh data types.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
/*
	NOTE
	
	The file "Types.h" has been renamed to "MacTypes.h" to prevent a collision
	with the "Types.h" available on other platforms.  MacOS only developers may 
	continue to use #include <Types.h>.  Developers doing cross-platform work where 
	Types.h also exists should change their sources to use #include <MacTypes.h>
*/

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#if TARGET_OS_MAC
#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#else
/*
	If you get here, your development environment is messed up.
	This file is for MacOS development only.
*/
#error This file (Types.h) is for developing MacOS software only!
#endif  /* TARGET_OS_MAC */

