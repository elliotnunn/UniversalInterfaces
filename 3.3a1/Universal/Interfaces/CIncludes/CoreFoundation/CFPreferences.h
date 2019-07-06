/*
 	File:		CFPreferences.h
 
 	Contains:	CoreFoundation preferences
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFPREFERENCES__
#define __COREFOUNDATION_CFPREFERENCES__

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

extern const CFStringRef kCFPreferencesAnyApplication;
extern const CFStringRef kCFPreferencesAnyHost;
extern const CFStringRef kCFPreferencesCurrentHost;
extern const CFStringRef kCFPreferencesAnyUser;
extern const CFStringRef kCFPreferencesCurrentUser;

/* Searches the various sources of application defaults to find the value for the given key.  
   key must not be NULL.  If a value is found, it returns it; otherwise returns NULL.  Caller 
   must release the returned value */
EXTERN_API_C( CFTypeRef )
CFPreferencesCopyAppValue		(CFStringRef 			key,
								 CFStringRef 			appName);

/* Sets the given value for the given key in the "normal" place for application preferences.  
   key must not be NULL.  If value is NULL, key is removed instead. */
EXTERN_API_C( void )
CFPreferencesSetAppValue		(CFStringRef 			key,
								 CFTypeRef 				value,
								 CFStringRef 			appName);

/* Writes all changes in all sources of application defaults.  Returns success or failure. */
EXTERN_API_C( Boolean )
CFPreferencesAppSynchronize		(CFStringRef 			appName);


/* The primitive get mechanism; all arguments must be non-NULL (use the constants above for common values).  
   Only the exact location specified by app-user-host is searched.  The returned CFType must be released by 
   the caller when it is finished with it. */
EXTERN_API_C( CFTypeRef )
CFPreferencesCopyValue			(CFStringRef 			key,
								 CFStringRef 			appName,
								 CFStringRef 			user,
								 CFStringRef 			host);

/* The primitive set function; all arguments except value must be non-NULL.  If value is NULL, the given key is removed */
EXTERN_API_C( void )
CFPreferencesSetValue			(CFStringRef 			key,
								 CFTypeRef 				value,
								 CFStringRef 			appName,
								 CFStringRef 			user,
								 CFStringRef 			host);

EXTERN_API_C( Boolean )
CFPreferencesSynchronize		(CFStringRef 			appName,
								 CFStringRef 			user,
								 CFStringRef 			host);

/* Constructs and returns the list of the name of all applications which have preferences in the scope of the given user and host.
    The returned value must be released by the caller; neither argument may be NULL. */
EXTERN_API_C( CFArrayRef )
CFPreferencesCopyApplicationList (CFStringRef 			userName,
								 CFStringRef 			hostName);

/* Constructs and returns the list of all keys set in the given location.  
   The returned value must be released by the caller; all arguments must be non-NULL */
EXTERN_API_C( CFArrayRef )
CFPreferencesCopyKeyList		(CFStringRef 			appName,
								 CFStringRef 			userName,
								 CFStringRef 			hostName);


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

#endif /* __COREFOUNDATION_CFPREFERENCES__ */

