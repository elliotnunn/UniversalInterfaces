/*
 	File:		CFTimeZone.h
 
 	Contains:	CoreFoundation time zone
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFTIMEZONE__
#define __COREFOUNDATION_CFTIMEZONE__

#ifndef __COREFOUNDATION_CFBASE__
#ifdef __MWERKS__
	#include <CFBase.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBase.h>
#else
	#include <CoreFoundation/CFBase.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFARRAY__
#ifdef __MWERKS__
	#include <CFArray.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFArray.h>
#else
	#include <CoreFoundation/CFArray.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFDATA__
#ifdef __MWERKS__
	#include <CFData.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFData.h>
#else
	#include <CoreFoundation/CFData.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFDATE__
#ifdef __MWERKS__
	#include <CFDate.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFDate.h>
#else
	#include <CoreFoundation/CFDate.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFDICTIONARY__
#ifdef __MWERKS__
	#include <CFDictionary.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFDictionary.h>
#else
	#include <CoreFoundation/CFDictionary.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFSTRING__
#ifdef __MWERKS__
	#include <CFString.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFString.h>
#else
	#include <CoreFoundation/CFString.h>
#endif
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

/*
	CFTimeZoneRef is defined in CFDate.h
*/

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

#endif /* __COREFOUNDATION_CFTIMEZONE__ */

