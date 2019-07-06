{
     File:       CFDate.p
 
     Contains:   CoreFoundation date
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFDate;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFDATE__}
{$SETC __CFDATE__ := 1}

{$I+}
{$SETC CFDateIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFTimeInterval						= Double;
	CFAbsoluteTime						= CFTimeInterval;
{ absolute time is the time interval since the reference date }
{ the reference date (epoch) is 00:00:00 1 January 2001. }

FUNCTION CFAbsoluteTimeGetCurrent: CFAbsoluteTime; C;

TYPE
	CFDateRef = ^LONGINT; { an opaque 32-bit type }
FUNCTION CFDateGetTypeID: CFTypeID; C;

FUNCTION CFDateCreate(allocator: CFAllocatorRef; at: CFAbsoluteTime): CFDateRef; C;

FUNCTION CFDateGetAbsoluteTime(date: CFDateRef): CFAbsoluteTime; C;
FUNCTION CFDateGetTimeIntervalSinceDate(date: CFDateRef; otherDate: CFDateRef): CFTimeInterval; C;
FUNCTION CFDateCompare(date: CFDateRef; otherDate: CFDateRef; context: UNIV Ptr): CFComparisonResult; C;


TYPE
	CFTimeZoneRef = ^LONGINT; { an opaque 32-bit type }
	CFGregorianDatePtr = ^CFGregorianDate;
	CFGregorianDate = RECORD
		year:					SInt32;
		month:					SInt8;
		day:					SInt8;
		hour:					SInt8;
		minute:					SInt8;
		second:					Double;
	END;

	CFGregorianUnitsPtr = ^CFGregorianUnits;
	CFGregorianUnits = RECORD
		years:					SInt32;
		months:					SInt32;
		days:					SInt32;
		hours:					SInt32;
		minutes:				SInt32;
		seconds:				Double;
	END;

	CFGregorianUnitFlags 		= UInt32;
CONST
	kCFGregorianUnitsYears		= $01;
	kCFGregorianUnitsMonths		= $02;
	kCFGregorianUnitsDays		= $04;
	kCFGregorianUnitsHours		= $08;
	kCFGregorianUnitsMinutes	= $10;
	kCFGregorianUnitsSeconds	= $20;
	kCFGregorianAllUnits		= $00FFFFFF;


FUNCTION CFGregorianDateIsValid(gdate: CFGregorianDate; unitFlags: CFOptionFlags): BOOLEAN; C;
FUNCTION CFGregorianDateGetAbsoluteTime(gdate: CFGregorianDate; tz: CFTimeZoneRef): CFAbsoluteTime; C;
FUNCTION CFAbsoluteTimeGetGregorianDate(at: CFAbsoluteTime; tz: CFTimeZoneRef): CFGregorianDate; C;
FUNCTION CFAbsoluteTimeGetDayOfWeek(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; C;
FUNCTION CFAbsoluteTimeGetDayOfYear(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; C;
FUNCTION CFAbsoluteTimeGetWeekOfYear(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFDateIncludes}

{$ENDC} {__CFDATE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
