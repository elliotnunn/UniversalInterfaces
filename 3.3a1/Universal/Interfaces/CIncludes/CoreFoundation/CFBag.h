/*
 	File:		CFBag.h
 
 	Contains:	CoreFoundation bag collection
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFBAG__
#define __COREFOUNDATION_CFBAG__

#ifndef __COREFOUNDATION_CFBASE__
#ifdef __MWERKS__
	#include <CFBase.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBase.h>
#else
	#include <CoreFoundation/CFBase.h>
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

typedef CALLBACK_API_C( const void *, CFBagRetainCallBack )(CFAllocatorRef allocator, const void *ptr);
typedef CALLBACK_API_C( void , CFBagReleaseCallBack )(CFAllocatorRef allocator, const void *ptr);
typedef CALLBACK_API_C( CFStringRef , CFBagCopyDescriptionCallBack )(const void *ptr);
typedef CALLBACK_API_C( Boolean , CFBagEqualCallBack )(const void *ptr1, const void *ptr2);
typedef CALLBACK_API_C( CFHashCode , CFBagHashCallBack )(const void *ptr);

struct CFBagCallBacks {
	CFIndex 						version;
	CFBagRetainCallBack 			retain;
	CFBagReleaseCallBack 			release;
	CFBagCopyDescriptionCallBack 	copyDescription;
	CFBagEqualCallBack 				equal;
	CFBagHashCallBack 				hash;
};
typedef struct CFBagCallBacks			CFBagCallBacks;
extern const CFBagCallBacks kCFTypeBagCallBacks;
extern const CFBagCallBacks kCFCopyStringBagCallBacks;
typedef CALLBACK_API_C( void , CFBagApplierFunction )(const void *val, void *context);
typedef const struct __CFBag* 			CFBagRef;
typedef struct __CFBag* 				CFMutableBagRef;
EXTERN_API_C( CFTypeID )
CFBagGetTypeID					(void);


EXTERN_API_C( CFBagRef )
CFBagCreate						(CFAllocatorRef 		allocator,
								 const void **			values,
								 CFIndex 				numValues,
								 const CFBagCallBacks *	callBacks);

EXTERN_API_C( CFBagRef )
CFBagCreateCopy					(CFAllocatorRef 		allocator,
								 CFBagRef 				bag);

EXTERN_API_C( CFMutableBagRef )
CFBagCreateMutable				(CFAllocatorRef 		allocator,
								 CFIndex 				capacity,
								 const CFBagCallBacks *	callBacks);

EXTERN_API_C( CFMutableBagRef )
CFBagCreateMutableCopy			(CFAllocatorRef 		allocator,
								 CFIndex 				capacity,
								 CFBagRef 				bag);


EXTERN_API_C( CFIndex )
CFBagGetCount					(CFBagRef 				bag);

EXTERN_API_C( CFIndex )
CFBagGetCountOfValue			(CFBagRef 				bag,
								 const void *			value);

EXTERN_API_C( Boolean )
CFBagContainsValue				(CFBagRef 				bag,
								 const void *			value);

EXTERN_API_C( const void *)
CFBagGetValue					(CFBagRef 				bag,
								 const void *			candidate);

EXTERN_API_C( Boolean )
CFBagGetValueIfPresent			(CFBagRef 				bag,
								 const void *			candidate,
								 const void **			value);

EXTERN_API_C( void )
CFBagGetValues					(CFBagRef 				bag,
								 const void **			values);

EXTERN_API_C( void )
CFBagApplyFunction				(CFBagRef 				bag,
								 CFBagApplierFunction 	applier,
								 void *					context);


EXTERN_API_C( void )
CFBagAddValue					(CFMutableBagRef 		bag,
								 const void *			value);

EXTERN_API_C( void )
CFBagReplaceValue				(CFMutableBagRef 		bag,
								 const void *			value);

EXTERN_API_C( void )
CFBagSetValue					(CFMutableBagRef 		bag,
								 const void *			value);

EXTERN_API_C( void )
CFBagRemoveValue				(CFMutableBagRef 		bag,
								 const void *			value);

EXTERN_API_C( void )
CFBagRemoveAllValues			(CFMutableBagRef 		bag);


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

#endif /* __COREFOUNDATION_CFBAG__ */

