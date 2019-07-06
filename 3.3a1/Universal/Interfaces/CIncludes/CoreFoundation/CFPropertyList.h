/*
 	File:		CFPropertyList.h
 
 	Contains:	CoreFoundation PropertyList
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFPROPERTYLIST__
#define __COREFOUNDATION_CFPROPERTYLIST__

#ifndef __COREFOUNDATION_CFBASE__
#ifdef __MWERKS__
	#include <CFBase.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBase.h>
#else
	#include <CoreFoundation/CFBase.h>
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

#ifndef __COREFOUNDATION_CFSTRING__
#ifdef __MWERKS__
	#include <CFString.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFString.h>
#else
	#include <CoreFoundation/CFString.h>
#endif
#endif



/* Type to mean any instance of a property list type;
   currently, CFString, CFData, CFNumber, CFBoolean, CFDate,
   CFArray, and CFDictionary. 
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

#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=int
#elif PRAGMA_ENUM_PACK
	#if __option(pack_enums)
		#define PRAGMA_ENUM_PACK__COREFOUNDATION_CFPROPERTYLIST__
	#endif
	#pragma options(!pack_enums)
#endif

typedef CFTypeRef 						CFPropertyListRef;

enum CFPropertyListMutabilityOptions {
	kCFPropertyListImmutable	= 0,
	kCFPropertyListMutableContainers = 1,
	kCFPropertyListMutableContainersAndLeaves = 2
};
typedef enum CFPropertyListMutabilityOptions CFPropertyListMutabilityOptions;

/* 
Creates a property list object (CFString, CFDictionary, CFArray, or CFData) 
from its XML description; xmlData should be the raw bytes of that description, 
possibly the contents of an XML file.  Returns NULL if the data cannot be parsed; 
if the parse fails and errorString is non-NULL, a human-readable description of 
the failure is returned in errorString.  It is the caller's responsibility to 
release either the returned object or the error string, whichever is applicable. 
*/
EXTERN_API_C( CFPropertyListRef )
CFPropertyListCreateFromXMLData	(CFAllocatorRef 		allocator,
								 CFDataRef 				xmlData,
								 CFOptionFlags 			mutabilityOption,
								 CFStringRef *			errorString);

/* 
Returns the XML description of the given object; propertyList must be one of
the supported property list types, and (for composite types like CFArray and CFDictionary) 
must not contain any elements that are not themselves of a property list type.  
If a non-property list type is encountered, NULL is returned.  The returned data is
appropriate for writing out to an XML file.  Note that a data, not a string, is 
returned because the bytes contain in them a description of the string encoding used. 
*/
EXTERN_API_C( CFDataRef )
CFPropertyListCreateXMLData		(CFAllocatorRef 		allocator,
								 CFPropertyListRef 		propertyList);



#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint reset
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=reset
#elif defined(PRAGMA_ENUM_PACK__COREFOUNDATION_CFPROPERTYLIST__)
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

#endif /* __COREFOUNDATION_CFPROPERTYLIST__ */

