{
 	File:		DriverSupport.p
 
 	Contains:	Driver Support Interfaces.
 
 	Version:	Technology:	Sustem 8
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DriverSupport;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERSUPPORT__}
{$SETC __DRIVERSUPPORT__ := 1}

{$I+}
{$SETC DriverSupportIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DRIVERSERVICES__}
{$I DriverServices.p}
{$ENDC}

{
	The contents of DriverSupport.h has been merged into DriverServices.h
}
{$SETC UsingIncludes := DriverSupportIncludes}

{$ENDC} {__DRIVERSUPPORT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
