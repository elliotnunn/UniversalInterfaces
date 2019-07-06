/*
 	File:		CryptoMessageSyntax.h
 
 	Contains:	CMS Interfaces.
 
 	Version:	Technology:	1.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __CRYPTOMESSAGESYNTAX__
#define __CRYPTOMESSAGESYNTAX__

#ifndef __MACTYPES__
#include <MacTypes.h>
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

#ifndef __COREFOUNDATION_CFBAG__
#ifdef __MWERKS__
	#include <CFBag.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBag.h>
#else
	#include <CoreFoundation/CFBag.h>
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

#ifndef __COREFOUNDATION_CFSET__
#ifdef __MWERKS__
	#include <CFSet.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFSet.h>
#else
	#include <CoreFoundation/CFSet.h>
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

#ifndef __KEYCHAIN__
#include <Keychain.h>
#endif


/*
	Data structures and types
*/


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

typedef struct OpaqueSecTypeRef* 		SecTypeRef;
typedef struct OpaqueSecSignerRef* 		SecSignerRef;
/* Signer object manipulation */
EXTERN_API( OSStatus )
SecSignerGetStatus				(SecSignerRef 			signer);

EXTERN_API( SecTypeRef )
SecRetain						(SecTypeRef 			sec);

EXTERN_API( void )
SecRelease						(SecTypeRef 			sec);

EXTERN_API( UInt32 )
SecRetainCount					(SecTypeRef 			sec);

/* Errors Codes  */
enum {
	errSecUnsupported			= -13843,
	errSecInvalidData			= -13844,
	errSecTooMuchData			= -13845,
	errSecMissingData			= -13846,
	errSecNoSigners				= -13847,
	errSecSignerFailed			= -13848,
	errSecInvalidPolicy			= -13849,
	errSecUnknownPolicy			= -13850,
	errSecInvalidStopOn			= -13851,
	errSecMissingCert			= -13852,
	errSecInvalidCert			= -13853,
	errSecNotSigner				= -13854,
	errSecNotTrusted			= -13855,
	errSecMissingAttribute		= -13856,
	errSecMissingDigest			= -13857,
	errSecDigestMismatch		= -13858,
	errSecInvalidSignature		= -13859,
	errSecAlgMismatch			= -13860,
	errSecUnsupportedAlgorithm	= -13864,
	errSecContentTypeMismatch	= -13865,
	errSecDebugRoot				= -13866
};


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

#endif /* __CRYPTOMESSAGESYNTAX__ */

