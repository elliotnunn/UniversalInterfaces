{
 	File:		OpenTptConfig.p
 
 	Contains:	xxx put contents here xxx
 
 	Version:	Technology:	xxx put version here xxx
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1998-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptConfig;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTCONFIG__}
{$SETC __OPENTPTCONFIG__ := 1}

{$I+}
{$SETC OpenTptConfigIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}

{
	The contents of OpenTptConfig.h has been merged into OpenTransportProtocol.h
}
{$SETC UsingIncludes := OpenTptConfigIncludes}

{$ENDC} {__OPENTPTCONFIG__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
