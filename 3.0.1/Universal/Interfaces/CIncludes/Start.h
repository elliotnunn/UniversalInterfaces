/*
 	File:		Start.h
 
 	Contains:	Start Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1987-1993, 1996-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __START__
#define __START__

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


union DefStartRec {
	struct {
		SignedByte 						sdExtDevID;
		SignedByte 						sdPartition;
		SignedByte 						sdSlotNum;
		SignedByte 						sdSRsrcID;
	} 								slotDev;
	struct {
		SignedByte 						sdReserved1;
		SignedByte 						sdReserved2;
		short 							sdRefNum;
	} 								scsiDev;
};
typedef union DefStartRec DefStartRec;

typedef DefStartRec *					DefStartPtr;
struct DefVideoRec {
	SignedByte 						sdSlot;
	SignedByte 						sdsResource;
};
typedef struct DefVideoRec DefVideoRec;

typedef DefVideoRec *					DefVideoPtr;
struct DefOSRec {
	SignedByte 						sdReserved;
	SignedByte 						sdOSType;
};
typedef struct DefOSRec DefOSRec;

typedef DefOSRec *						DefOSPtr;
																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter GetDefaultStartup(__A0)
																							#endif
EXTERN_API( void )
GetDefaultStartup				(DefStartPtr 			paramBlock)							ONEWORDINLINE(0xA07D);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetDefaultStartup(__A0)
																							#endif
EXTERN_API( void )
SetDefaultStartup				(DefStartPtr 			paramBlock)							ONEWORDINLINE(0xA07E);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter GetVideoDefault(__A0)
																							#endif
EXTERN_API( void )
GetVideoDefault					(DefVideoPtr 			paramBlock)							ONEWORDINLINE(0xA080);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetVideoDefault(__A0)
																							#endif
EXTERN_API( void )
SetVideoDefault					(DefVideoPtr 			paramBlock)							ONEWORDINLINE(0xA081);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter GetOSDefault(__A0)
																							#endif
EXTERN_API( void )
GetOSDefault					(DefOSPtr 				paramBlock)							ONEWORDINLINE(0xA084);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter SetOSDefault(__A0)
																							#endif
EXTERN_API( void )
SetOSDefault					(DefOSPtr 				paramBlock)							ONEWORDINLINE(0xA083);

EXTERN_API( void )
SetTimeout						(short 					count);

EXTERN_API( void )
GetTimeout						(short *				count);


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

#endif /* __START__ */

