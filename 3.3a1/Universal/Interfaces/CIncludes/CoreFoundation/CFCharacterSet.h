/*
 	File:		CFCharacterSet.h
 
 	Contains:	CoreFoundation character sets
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFCHARACTERSET__
#define __COREFOUNDATION_CFCHARACTERSET__

#ifndef __COREFOUNDATION_CFBASE__
#ifdef __MWERKS__
	#include <CFBase.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBase.h>
#else
	#include <CoreFoundation/CFBase.h>
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

#ifndef __COREFOUNDATION_CFDATA__
#ifdef __MWERKS__
	#include <CFData.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFData.h>
#else
	#include <CoreFoundation/CFData.h>
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

#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=int
#elif PRAGMA_ENUM_PACK
	#if __option(pack_enums)
		#define PRAGMA_ENUM_PACK__COREFOUNDATION_CFCHARACTERSET__
	#endif
	#pragma options(!pack_enums)
#endif

typedef const struct __CFCharacterSet* 	CFCharacterSetRef;
typedef struct __CFCharacterSet* 		CFMutableCharacterSetRef;
/* Used by CFCharacterSetCreateWithPredefinedSet */

enum CFCharacterSetPredefinedSet {
	kCFCharacterSetControl		= 1,
	kCFCharacterSetWhitespace	= 2,
	kCFCharacterSetWhitespaceAndNewline = 3,
	kCFCharacterSetDecimalDigit	= 4,
	kCFCharacterSetLetter		= 5,
	kCFCharacterSetLowercaseLetter = 6,
	kCFCharacterSetUppercaseLetter = 7,
	kCFCharacterSetNonBase		= 8,
	kCFCharacterSetDecomposable	= 9,
	kCFCharacterSetAlphaNumeric	= 10,
	kCFCharacterSetPunctuation	= 11,
	kCFCharacterSetIllegal		= 12
};
typedef enum CFCharacterSetPredefinedSet CFCharacterSetPredefinedSet;

/* CFCharacterSet type ID */
EXTERN_API_C( CFTypeID )
CFCharacterSetGetTypeID			(void);

/*** CharacterSet creation ***/
/* Functions to create basic immutable characterset. */
EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetGetPredefined		(CFCharacterSetPredefinedSet  theSetIdentifier);

EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetCreateWithCharactersInRange (CFAllocatorRef  alloc,
								 CFRange 				theRange);

EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetCreateWithCharactersInString (CFAllocatorRef  alloc,
								 CFStringRef 			theString);

EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetCreateWithBitmapRepresentation (CFAllocatorRef  alloc,
								 CFDataRef 				theData);

/* Functions to create mutable characterset. */
EXTERN_API_C( CFMutableCharacterSetRef )
CFCharacterSetCreateMutable		(CFAllocatorRef 		alloc);

EXTERN_API_C( CFMutableCharacterSetRef )
CFCharacterSetCreateMutableCopy	(CFAllocatorRef 		alloc,
								 CFCharacterSetRef 		theSet);

/*** Basic accessors ***/
EXTERN_API_C( Boolean )
CFCharacterSetIsCharacterMember	(CFCharacterSetRef 		theSet,
								 UniChar 				theChar);

EXTERN_API_C( CFDataRef )
CFCharacterSetCreateBitmapRepresentation (CFAllocatorRef  alloc,
								 CFCharacterSetRef 		theSet);

/*** MutableCharacterSet functions ***/
EXTERN_API_C( void )
CFCharacterSetAddCharactersInRange (CFMutableCharacterSetRef  theSet,
								 CFRange 				theRange);

EXTERN_API_C( void )
CFCharacterSetRemoveCharactersInRange (CFMutableCharacterSetRef  theSet,
								 CFRange 				theRange);

EXTERN_API_C( void )
CFCharacterSetAddCharactersInString (CFMutableCharacterSetRef  theSet,
								 CFStringRef 			theString);

EXTERN_API_C( void )
CFCharacterSetRemoveCharactersInString (CFMutableCharacterSetRef  theSet,
								 CFStringRef 			theString);

EXTERN_API_C( void )
CFCharacterSetUnion				(CFMutableCharacterSetRef  theSet,
								 CFCharacterSetRef 		theOtherSet);

EXTERN_API_C( void )
CFCharacterSetIntersect			(CFMutableCharacterSetRef  theSet,
								 CFCharacterSetRef 		theOtherSet);

EXTERN_API_C( void )
CFCharacterSetInvert			(CFMutableCharacterSetRef  theSet);


#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint reset
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=reset
#elif defined(PRAGMA_ENUM_PACK__COREFOUNDATION_CFCHARACTERSET__)
	#pragma options(pack_enums)
#endif

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

#endif /* __COREFOUNDATION_CFCHARACTERSET__ */

