{
 	File:		ScalerTypes.p
 
 	Contains:	Apple public font scaler object and constant definitions
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ScalerTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCALERTYPES__}
{$SETC __SCALERTYPES__ := 1}

{$I+}
{$SETC ScalerTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __SCALERSTREAMTYPES__}
{$I ScalerStreamTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScalerTypesIncludes}

{$ENDC} {__SCALERTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
