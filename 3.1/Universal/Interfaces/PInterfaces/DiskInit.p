{
 	File:		DiskInit.p
 
 	Contains:	Disk Initialization Package ('PACK' 2) Interfaces.
 
 	Version:	Technology:	System 8.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1995, 1997-1998 by Apple Computer, Inc., all rights reserved
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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


CONST
	kHFSPlusDefaultsVersion		= 1;


TYPE
	HFSPlusDefaultsPtr = ^HFSPlusDefaults;
	HFSPlusDefaults = RECORD
		version:				UInt16;									{  version of this structure  }
		flags:					UInt16;									{  currently undefined; pass zero  }
		blockSize:				UInt32;									{  allocation block size in bytes  }
		rsrcClumpSize:			UInt32;									{  clump size for resource forks  }
		dataClumpSize:			UInt32;									{  clump size for data forks  }
		nextFreeFileID:			UInt32;									{  next free file number  }
		catalogClumpSize:		UInt32;									{  clump size for catalog B-tree  }
		catalogNodeSize:		UInt32;									{  node size for catalog B-tree  }
		extentsClumpSize:		UInt32;									{  clump size for extents B-tree  }
		extentsNodeSize:		UInt32;									{  node size for extents B-tree  }
		attributesClumpSize:	UInt32;									{  clump size for attributes B-tree  }
		attributesNodeSize:		UInt32;									{  node size for attributes B-tree  }
		allocationClumpSize:	UInt32;									{  clump size for allocation bitmap file  }
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
FUNCTION DIZero(drvNum: INTEGER; volName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $3F00, $A9E9;
	{$ENDC}
{
	DIXFormat, DIXZero, and DIReformat are only available when FSM (File System Manager) is installed.
	FSM is part of Macintosh PC Exchange and System 7.5.
}
FUNCTION DIXFormat(drvNum: INTEGER; fmtFlag: BOOLEAN; fmtArg: UInt32; VAR actSize: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIXZero(drvNum: INTEGER; volName: Str255; fsid: INTEGER; mediaStatus: INTEGER; volTypeSelector: INTEGER; volSize: UInt32; extendedInfoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIReformat(drvNum: INTEGER; fsid: INTEGER; volName: Str255; msgText: Str255): OSErr;
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