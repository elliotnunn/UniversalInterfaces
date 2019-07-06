{
 	File:		OSAComp.p
 
 	Contains:	AppleScript Component Implementor's Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1992-1997, 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OSAComp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSACOMP__}
{$SETC __OSACOMP__ := 1}

{$I+}
{$SETC OSACompIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*************************************************************************
	Types and Constants
*************************************************************************}
{*************************************************************************
	Routines for Associating a Storage Type with a Script Data Handle 
*************************************************************************}
FUNCTION OSAGetStorageType(scriptData: Handle; VAR dscType: DescType): OSErr;
FUNCTION OSAAddStorageType(scriptData: Handle; dscType: DescType): OSErr;
FUNCTION OSARemoveStorageType(scriptData: Handle): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSACompIncludes}

{$ENDC} {__OSACOMP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
