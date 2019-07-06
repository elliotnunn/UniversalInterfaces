/*
 	File:		Patches.h
 
 	Contains:	Patch Manager Interfaces.
 
 	Version:	Technology:	System 8
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __PATCHES__
#define __PATCHES__

#ifndef __TYPES__
#include <Types.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

#if TARGET_OS_MAC

enum {
	kOSTrapType					= 0,
	kToolboxTrapType			= 1
};

typedef SignedByte 						TrapType;

enum {
	OSTrap						= kOSTrapType,					/* old name */
	ToolTrap					= kToolboxTrapType				/* old name */
};

/*
	GetTrapAddress and SetTrapAddress are obsolete and should not
	be used. Always use NGetTrapAddress and NSetTrapAddress instead.
	The old routines will not be supported for PowerPC apps.
*/
#if OLDROUTINENAMES && !TARGET_RT_MAC_CFM
																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __A0 GetTrapAddress(__D0)
																							#endif
EXTERN_API( UniversalProcPtr )
GetTrapAddress					(UInt16 				trapNum)							ONEWORDINLINE(0xA146);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetTrapAddress(__A0, __D0)
																							#endif
EXTERN_API( void )
SetTrapAddress					(UniversalProcPtr 		trapAddr,
								 UInt16 				trapNum)							ONEWORDINLINE(0xA047);

#endif  /* OLDROUTINENAMES &&  !TARGET_RT_MAC_CFM */

EXTERN_API( UniversalProcPtr )
NGetTrapAddress					(UInt16 				trapNum,
								 TrapType 				tTyp);

EXTERN_API( void )
NSetTrapAddress					(UniversalProcPtr 		trapAddr,
								 UInt16 				trapNum,
								 TrapType 				tTyp);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __A0 GetOSTrapAddress(__D0)
																							#endif
EXTERN_API( UniversalProcPtr )
GetOSTrapAddress				(UInt16 				trapNum)							ONEWORDINLINE(0xA346);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetOSTrapAddress(__A0, __D0)
																							#endif
EXTERN_API( void )
SetOSTrapAddress				(UniversalProcPtr 		trapAddr,
								 UInt16 				trapNum)							ONEWORDINLINE(0xA247);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __A0 GetToolTrapAddress(__D0)
																							#endif
EXTERN_API( UniversalProcPtr )
GetToolTrapAddress				(UInt16 				trapNum)							ONEWORDINLINE(0xA746);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetToolTrapAddress(__A0, __D0)
																							#endif
EXTERN_API( void )
SetToolTrapAddress				(UniversalProcPtr 		trapAddr,
								 UInt16 				trapNum)							ONEWORDINLINE(0xA647);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __A0 GetToolboxTrapAddress(__D0)
																							#endif
EXTERN_API( UniversalProcPtr )
GetToolboxTrapAddress			(UInt16 				trapNum)							ONEWORDINLINE(0xA746);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetToolboxTrapAddress(__A0, __D0)
																							#endif
EXTERN_API( void )
SetToolboxTrapAddress			(UniversalProcPtr 		trapAddr,
								 UInt16 				trapNum)							ONEWORDINLINE(0xA647);

#if TARGET_CPU_PPC
EXTERN_API( UniversalProcHandle )
GetTrapVector					(UInt16 				trapNumber);

#endif  /* TARGET_CPU_PPC */

#endif  /* TARGET_OS_MAC */


#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PATCHES__ */

