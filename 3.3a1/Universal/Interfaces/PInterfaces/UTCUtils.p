{
 	File:		UTCUtils.p
 
 	Contains:	Interface for UTC to Local Time conversion and 64 Bit Clock routines
 
 	Version:	Technology:	Sonata
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT UTCUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __UTCUTILS__}
{$SETC __UTCUTILS__ := 1}

{$I+}
{$SETC UTCUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Status Codes }

CONST
	kUTCUnderflowErr			= -8850;
	kUTCOverflowErr				= -8851;
	kIllegalClockValueErr		= -8852;

{ Options for Set & Get DateTime Routines }
	kUTCDefaultOptions			= 0;

{ 64 Bit Clock Typedefs }

TYPE
	UTCDateTimePtr = ^UTCDateTime;
	UTCDateTime = RECORD
		highSeconds:			UInt16;
		lowSeconds:				UInt32;
		fraction:				UInt16;
	END;

	UTCDateTimeHandle					= ^UTCDateTimePtr;
	LocalDateTimePtr = ^LocalDateTime;
	LocalDateTime = RECORD
		highSeconds:			UInt16;
		lowSeconds:				UInt32;
		fraction:				UInt16;
	END;

	LocalDateTimeHandle					= ^LocalDateTimePtr;
{ Classic 32 bit clock conversion routines }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION ConvertLocalTimeToUTC(localSeconds: UInt32; VAR utcSeconds: UInt32): OSStatus; C;
FUNCTION ConvertUTCToLocalTime(utcSeconds: UInt32; VAR localSeconds: UInt32): OSStatus; C;
{ 64 bit clock conversion routines }
FUNCTION ConvertUTCToLocalDateTime({CONST}VAR utcDateTime: UTCDateTime; VAR localDateTime: LocalDateTime): OSStatus; C;
FUNCTION ConvertLocalToUTCDateTime({CONST}VAR localDateTime: LocalDateTime; VAR utcDateTime: UTCDateTime): OSStatus; C;
{ Getter and Setter Clock routines using 64 Bit values }
FUNCTION GetUTCDateTime(VAR utcDateTime: UTCDateTime; options: OptionBits): OSStatus; C;
FUNCTION SetUTCDateTime({CONST}VAR utcDateTime: UTCDateTime; options: OptionBits): OSStatus; C;
FUNCTION GetLocalDateTime(VAR localDateTime: LocalDateTime; options: OptionBits): OSStatus; C;
FUNCTION SetLocalDateTime({CONST}VAR localDateTime: LocalDateTime; options: OptionBits): OSStatus; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := UTCUtilsIncludes}

{$ENDC} {__UTCUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
