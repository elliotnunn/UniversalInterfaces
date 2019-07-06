{
 	File:		DiskInit.p
 
 	Contains:	Disk Initialization Package ('PACK' 2) Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997, 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DiskInit;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DISKINIT__}
{$SETC __DISKINIT__ := 1}

{$I+}
{$SETC DiskInitIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	HFSDefaultsPtr = ^HFSDefaults;
	HFSDefaults = RECORD
		sigWord:				PACKED ARRAY [0..1] OF CHAR;			{  signature word  }
		abSize:					LONGINT;								{  allocation block size in bytes  }
		clpSize:				LONGINT;								{  clump size in bytes  }
		nxFreeFN:				LONGINT;								{  next free file number  }
		btClpSize:				LONGINT;								{  B-Tree clump size in bytes  }
		rsrv1:					INTEGER;								{  reserved  }
		rsrv2:					INTEGER;								{  reserved  }
		rsrv3:					INTEGER;								{  reserved  }
	END;

PROCEDURE DILoad;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $3F00, $A9E9;
	{$ENDC}
PROCEDURE DIUnload;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIBadMount(where: Point; evtMessage: LONGINT): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIFormat(drvNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIVerify(drvNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIZero(drvNum: INTEGER; volName: ConstStr255Param): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $3F00, $A9E9;
	{$ENDC}
{
	DIXFormat, DIXZero, and DIReformat are only available when FSM (File System Manager) is installed.
	FSM is part of Macintosh PC Exchange and System 7.5.
}
FUNCTION DIXFormat(drvNum: INTEGER; fmtFlag: BOOLEAN; fmtArg: LONGINT; VAR actSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIXZero(drvNum: INTEGER; volName: ConstStr255Param; fsid: INTEGER; mediaStatus: INTEGER; volTypeSelector: INTEGER; volSize: LONGINT; extendedInfoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIReformat(drvNum: INTEGER; fsid: INTEGER; volName: ConstStr255Param; msgText: ConstStr255Param): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $3F00, $A9E9;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DiskInitIncludes}

{$ENDC} {__DISKINIT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
