/*
 	File:		CFURLAccess.h
 
 	Contains:	CoreFoundation url access
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFURLACCESS__
#define __COREFOUNDATION_CFURLACCESS__

#ifndef __COREFOUNDATION_CFURL__
#ifdef __MWERKS__
	#include <CFURL.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFURL.h>
#else
	#include <CoreFoundation/CFURL.h>
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


/* Fills buffer with the file system's native representation of url's */
/* path. No more than bufLen bytes are written to buffer.  If resolveAgainstBase */
/* is true, the url's relative portion is resolved against its base before */
/* the path is computed.  usedBufLen is set to the number of bytes actually */
/* written; returns success or failure. */


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
		#define PRAGMA_ENUM_PACK__COREFOUNDATION_CFURLACCESS__
	#endif
	#pragma options(!pack_enums)
#endif

EXTERN_API_C( Boolean )
CFURLGetFileSystemRepresentation (CFURLRef 				url,
								 Boolean 				resolveAgainstBase,
								 char *					buffer,
								 CFIndex 				bufLen);

EXTERN_API_C( CFURLRef )
CFURLCreateFromFileSystemRepresentation (CFAllocatorRef  allocator,
								 const char *			buffer,
								 CFIndex 				bufLen,
								 Boolean 				isDirectory);

/* Attempts to read the data and properties for the given URL. */
/* If only interested in one of the resourceData and properties, pass */
/* NULL for the other.  If properties is non-NULL and desiredProperties */
/* is NULL, then all properties are fetched.  Returns success or failure; */
/* note that as much work as possible is done even if FALSE is returned. */
/* So for instance if one property is not available, the others are fetched */
/* anyway. errorCode is set to 0 on success, and some other value on failure. */
/* If non-NULL, it is the caller 's responsibility to release resourceData */
/* and properties. */
/* Apple reserves for its use all negative error code values; these values */
/* represent errors common to any scheme.  Scheme-specific error codes */
/* should be positive, non-zero, and should be used only if one of the */
/* predefined Apple error codes does not apply.  Error codes should be */
/* publicized and documented with the scheme-specific properties. */
EXTERN_API_C( Boolean )
CFURLCreateDataAndPropertiesFromResource (CFAllocatorRef  alloc,
								 CFURLRef 				url,
								 CFDataRef *			resourceData,
								 CFDictionaryRef *		properties,
								 CFArrayRef 			desiredProperties,
								 SInt32 *				errorCode);

/* Attempts to write the given data and properties to the given URL. */
/* If dataToWrite is NULL, only properties are written out (use */
/* CFURLDestroyResource() to delete a resource).  Properties not present */
/* in propertiesToWrite are left unchanged, hence if propertiesToWrite */
/* is NULL or empty, the URL's properties are not changed at all. */
/* Returns success or failure; errorCode is set as for */
/* CFURLCreateDataAndPropertiesFromResource(), above. */
EXTERN_API_C( Boolean )
CFURLWriteDataAndPropertiesToResource (CFURLRef 		url,
								 CFDataRef 				dataToWrite,
								 CFDictionaryRef 		propertiesToWrite,
								 SInt32 *				errorCode);

/* Destroys the resource indicated by url. */
/* Returns success or failure; errorCode set as above. */
EXTERN_API_C( Boolean )
CFURLDestroyResource			(CFURLRef 				url,
								 SInt32 *				errorCode);

/* Convenience method which calls through to CFURLCreateDataAndPropertiesFromResource(). */
/* Returns NULL on error and sets errorCode accordingly. */
EXTERN_API_C( CFTypeRef )
CFURLCreatePropertyFromResource	(CFAllocatorRef 		alloc,
								 CFURLRef 				url,
								 CFStringRef 			property,
								 SInt32 *				errorCode);

/* Common error codes; this list is expected to grow */

enum CFURLError {
	kCFURLUnknownError			= -10,
	kCFURLUnknownSchemeError	= -11,
	kCFURLResourceNotFoundError	= -12,
	kCFURLResourceAccessViolationError = -13,
	kCFURLRemoteHostUnavailableError = -14,
	kCFURLImproperArgumentsError = -15,
	kCFURLUnknownPropertyKeyError = -16,
	kCFURLPropertyKeyUnavailableError = -17,
	kCFURLTimeoutError			= -18
};
typedef enum CFURLError CFURLError;

/* Properties and error codes for the file: scheme.  These are ad hoc and expected to change */
extern const CFStringRef kCFFileURLExists;
extern const CFStringRef kCFFileURLPOSIXMode;
extern const CFStringRef kCFFileURLDirectoryContents;
extern const CFStringRef kCFFileURLSize;
extern const CFStringRef kCFFileURLLastModificationTime;
extern const CFStringRef kCFHTTPURLStatusCode;
extern const CFStringRef kCFHTTPURLStatusLine;

/* kCFFileURLExists is set to kCFFileURLExists if the file exists; any other value if not */
/* kCFFileURLPOSIXMode encompasses permissions and file type; use the POSIX masks in stat.h */
/* to get specifics.  Value is a CFData wrapped around a mode_t */
/* kCFFileURLDirectoryContents value is a CFArray with containing URLs for the directory's contents. */
/* Empty array means the directory exists, but is empty. */
/* NULL value (but no failure) means the URL exists but is not a directory. */
/* Not settable */
/* kCFHTTPURLStatusCode and kCFHTTPURLStatusLine are properties for the http: scheme. */
/* Except for the common error */
/* codes, above, errorCode will be set to the HTTP response status */
/* code upon failure.  The status code is a CFNumber, the status line is a CFString.  */

#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint reset
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=reset
#elif defined(PRAGMA_ENUM_PACK__COREFOUNDATION_CFURLACCESS__)
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

#endif /* __COREFOUNDATION_CFURLACCESS__ */

