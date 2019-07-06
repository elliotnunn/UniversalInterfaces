{
 	File:		OSAComp.p
 
 	Contains:	AppleScript Component Implementor's Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1992-1995, 1997-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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
FUNCTION OSAGetStorageType(scriptData: AEDataStorage; VAR dscType: DescType): OSErr;
FUNCTION OSAAddStorageType(scriptData: AEDataStorage; dscType: DescType): OSErr;
FUNCTION OSARemoveStorageType(scriptData: AEDataStorage): OSErr;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSACompIncludes}

{$ENDC} {__OSACOMP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
