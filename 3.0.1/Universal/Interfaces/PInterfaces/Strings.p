{
 	File:		Strings.p
 
 	Contains:	Pascal <-> C String Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1993, 1996-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{
	Note: All Pascal <-> C String routines have moved to TextUtils.h

}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Strings;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __STRINGS__}
{$SETC __STRINGS__ := 1}

{$I+}
{$SETC StringsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}

{$SETC UsingIncludes := StringsIncludes}

{$ENDC} {__STRINGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
