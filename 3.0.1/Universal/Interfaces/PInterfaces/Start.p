{
 	File:		Start.p
 
 	Contains:	Start Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1987-1993, 1996-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Start;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __START__}
{$SETC __START__ := 1}

{$I+}
{$SETC StartIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



TYPE
	DefStartRecPtr = ^DefStartRec;
	DefStartRec = RECORD
		CASE INTEGER OF
		0: (
			sdExtDevID:			SignedByte;
			sdPartition:		SignedByte;
			sdSlotNum:			SignedByte;
			sdSRsrcID:			SignedByte;
		   );
		1: (
			sdReserved1:		SignedByte;
			sdReserved2:		SignedByte;
			sdRefNum:			INTEGER;
		   );
	END;

	DefStartPtr							= ^DefStartRec;
	DefStartPtrPtr 						= ^DefStartPtr;
	DefVideoRecPtr = ^DefVideoRec;
	DefVideoRec = RECORD
		sdSlot:					SignedByte;
		sdsResource:			SignedByte;
	END;

	DefVideoPtr							= ^DefVideoRec;
	DefOSRecPtr = ^DefOSRec;
	DefOSRec = RECORD
		sdReserved:				SignedByte;
		sdOSType:				SignedByte;
	END;

	DefOSPtr							= ^DefOSRec;
PROCEDURE GetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A07D;
	{$ENDC}
PROCEDURE SetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A07E;
	{$ENDC}
PROCEDURE GetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A080;
	{$ENDC}
PROCEDURE SetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A081;
	{$ENDC}
PROCEDURE GetOSDefault(paramBlock: DefOSPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A084;
	{$ENDC}
PROCEDURE SetOSDefault(paramBlock: DefOSPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A083;
	{$ENDC}
PROCEDURE SetTimeout(count: INTEGER);
PROCEDURE GetTimeout(VAR count: INTEGER);
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StartIncludes}

{$ENDC} {__START__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
