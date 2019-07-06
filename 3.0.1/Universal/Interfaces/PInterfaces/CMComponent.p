{
 	File:		CMComponent.p
 
 	Contains:	Stub for including new file names.
 
 	Version:	Technology:	ColorSync 2.0
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1993-1997, 1997 by Apple Computer, Inc. All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCOMPONENT__}
{$SETC __CMCOMPONENT__ := 1}

{$I+}
{$SETC CMComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{ 
	This file has been included to allow older source code 
	to #include <CMComponent.h>.  Please update your source
	code to directly #include <CMMComponent.h>
	  and			 #include <CMPRComponent.h>

}
{ #include the two ColorSync 2.0 files equivalent to the v. 1.0 file }
{$IFC UNDEFINED __CMMCOMPONENT__}
{$I CMMComponent.p}
{$ENDC}
{$IFC UNDEFINED __CMPRCOMPONENT__}
{$I CMPRComponent.p}
{$ENDC}

{$SETC UsingIncludes := CMComponentIncludes}

{$ENDC} {__CMCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
