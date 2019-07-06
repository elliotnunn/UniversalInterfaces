/*
 	File:		CFDate.h
 
 	Contains:	CoreFoundation date
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __COREFOUNDATION_CFDATE__
#define __COREFOUNDATION_CFDATE__

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

typedef double 							CFTimeInterval;
typedef CFTimeInterval 					CFAbsoluteTime;
/* absolute time is the time interval since the reference date */
/* the reference date (epoch) is 00:00:00 1 January 2001. */

EXTERN_API_C( CFAbsoluteTime )
CFAbsoluteTimeGetCurrent		(void);

extern const CFAbsoluteTime kCFAbsoluteTimeIntervalSince1970;
extern const CFAbsoluteTime kCFAbsoluteTimeIntervalSince1904;
typedef const struct __CFDate* 			CFDateRef;
EXTERN_API_C( CFTypeID )
CFDateGetTypeID					(void);


EXTERN_API_C( CFDateRef )
CFDateCreate					(CFAllocatorRef 		allocator,
								 CFAbsoluteTime 		at);


EXTERN_API_C( CFAbsoluteTime )
CFDateGetAbsoluteTime			(CFDateRef 				date);

EXTERN_API_C( CFTimeInterval )
CFDateGetTimeIntervalSinceDate	(CFDateRef 				date,
								 CFDateRef 				otherDate);

EXTERN_API_C( CFComparisonResult )
CFDateCompare					(CFDateRef 				date,
								 CFDateRef 				otherDate,
								 void *					context);


typedef const struct __CFTimeZone* 		CFTimeZoneRef;

struct CFGregorianDate {
	SInt32 							year;
	SInt8 							month;
	SInt8 							day;
	SInt8 							hour;
	SInt8 							minute;
	double 							second;
};
typedef struct CFGregorianDate			CFGregorianDate;

struct CFGregorianUnits {
	SInt32 							years;
	SInt32 							months;
	SInt32 							days;
	SInt32 							hours;
	SInt32 							minutes;
	double 							seconds;
};
typedef struct CFGregorianUnits			CFGregorianUnits;

typedef UInt32 CFGregorianUnitFlags;
enum {
	kCFGregorianUnitsYears		= (1 << 0),
	kCFGregorianUnitsMonths		= (1 << 1),
	kCFGregorianUnitsDays		= (1 << 2),
	kCFGregorianUnitsHours		= (1 << 3),
	kCFGregorianUnitsMinutes	= (1 << 4),
	kCFGregorianUnitsSeconds	= (1 << 5),
	kCFGregorianAllUnits		= 0x00FFFFFF
};


EXTERN_API_C( Boolean )
CFGregorianDateIsValid			(CFGregorianDate 		gdate,
								 CFOptionFlags 			unitFlags);

EXTERN_API_C( CFAbsoluteTime )
CFGregorianDateGetAbsoluteTime	(CFGregorianDate 		gdate,
								 CFTimeZoneRef 			tz);

EXTERN_API_C( CFGregorianDate )
CFAbsoluteTimeGetGregorianDate	(CFAbsoluteTime 		at,
								 CFTimeZoneRef 			tz);

EXTERN_API_C( SInt32 )
CFAbsoluteTimeGetDayOfWeek		(CFAbsoluteTime 		at,
								 CFTimeZoneRef 			tz);

EXTERN_API_C( SInt32 )
CFAbsoluteTimeGetDayOfYear		(CFAbsoluteTime 		at,
								 CFTimeZoneRef 			tz);

EXTERN_API_C( SInt32 )
CFAbsoluteTimeGetWeekOfYear		(CFAbsoluteTime 		at,
								 CFTimeZoneRef 			tz);


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

#endif /* __COREFOUNDATION_CFDATE__ */

