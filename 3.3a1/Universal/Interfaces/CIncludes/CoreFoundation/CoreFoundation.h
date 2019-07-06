/*
 	File:		CoreFoundation.h
 
 	Contains:	CoreFoundation master header
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_COREFOUNDATION__
#define __COREFOUNDATION_COREFOUNDATION__

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

#ifndef __COREFOUNDATION_CFBAG__
#ifdef __MWERKS__
	#include <CFBag.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBag.h>
#else
	#include <CoreFoundation/CFBag.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFBUNDLE__
#ifdef __MWERKS__
	#include <CFBundle.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFBundle.h>
#else
	#include <CoreFoundation/CFBundle.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFCHARACTERSET__
#ifdef __MWERKS__
	#include <CFCharacterSet.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFCharacterSet.h>
#else
	#include <CoreFoundation/CFCharacterSet.h>
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

#ifndef __COREFOUNDATION_CFNUMBER__
#ifdef __MWERKS__
	#include <CFNumber.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFNumber.h>
#else
	#include <CoreFoundation/CFNumber.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFPLUGIN__
#ifdef __MWERKS__
	#include <CFPlugIn.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFPlugIn.h>
#else
	#include <CoreFoundation/CFPlugIn.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFPREFERENCES__
#ifdef __MWERKS__
	#include <CFPreferences.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFPreferences.h>
#else
	#include <CoreFoundation/CFPreferences.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFPROPERTYLIST__
#ifdef __MWERKS__
	#include <CFPropertyList.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFPropertyList.h>
#else
	#include <CoreFoundation/CFPropertyList.h>
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

#ifndef __COREFOUNDATION_CFSTRINGENCODINGEXT__
#ifdef __MWERKS__
	#include <CFStringEncodingExt.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFStringEncodingExt.h>
#else
	#include <CoreFoundation/CFStringEncodingExt.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFTIMEZONE__
#ifdef __MWERKS__
	#include <CFTimeZone.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFTimeZone.h>
#else
	#include <CoreFoundation/CFTimeZone.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFURL__
#ifdef __MWERKS__
	#include <CFURL.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFURL.h>
#else
	#include <CoreFoundation/CFURL.h>
#endif
#endif

#ifndef __COREFOUNDATION_CFURLACCESS__
#ifdef __MWERKS__
	#include <CFURLAccess.h>
#elif TARGET_OS_MAC && SLASH_INCLUDES_UNSUPPORTED
	#include <:CoreFoundation:CFURLAccess.h>
#else
	#include <CoreFoundation/CFURLAccess.h>
#endif
#endif


#endif /* __COREFOUNDATION_COREFOUNDATION__ */

