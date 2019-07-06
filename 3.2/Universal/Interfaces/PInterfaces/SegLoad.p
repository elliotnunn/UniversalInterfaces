{
 	File:		SegLoad.p
 
 	Contains:	Segment Loader Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1985-1993, 1995-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SegLoad;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SEGLOAD__}
{$SETC __SEGLOAD__ := 1}

{$I+}
{$SETC SegLoadIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM }
{
   CountAppFiles, GetAppFiles, ClrAppFiles, GetAppParms, getappparms, 
   and the AppFile data structure and enums are obsolete. 
   They are still supported for writing old style 68K apps, 
   but they are not supported for CFM-based apps.
   Use AppleEvents to determine which files are to be 
   opened or printed from the Finder.
}

CONST
	appOpen						= 0;							{ Open the Document (s) }
	appPrint					= 1;							{ Print the Document (s) }


TYPE
	AppFilePtr = ^AppFile;
	AppFile = RECORD
		vRefNum:				INTEGER;
		fType:					OSType;
		versNum:				INTEGER;								{ versNum in high byte }
		fName:					Str255;
	END;

PROCEDURE CountAppFiles(VAR message: INTEGER; VAR count: INTEGER);
PROCEDURE GetAppFiles(index: INTEGER; VAR theFile: AppFile);
PROCEDURE ClrAppFiles(index: INTEGER);
PROCEDURE GetAppParms(VAR apName: Str255; VAR apRefNum: INTEGER; VAR apParam: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F5;
	{$ENDC}
{$ENDC}

{
   Because PowerPC applications don’t have segments.
   But, in order to allow applications to not have conditionalized
   source code, UnloadSeg is macro'ed away for PowerPC.
}
{$IFC TARGET_CPU_68K }
PROCEDURE UnloadSeg(routineAddr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F1;
	{$ENDC}
{$ENDC}  {TARGET_CPU_68K}




{$IFC OLDROUTINELOCATIONS }
PROCEDURE ExitToShell;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F4;
	{$ENDC}
{$ENDC}  {OLDROUTINELOCATIONS}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SegLoadIncludes}

{$ENDC} {__SEGLOAD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
