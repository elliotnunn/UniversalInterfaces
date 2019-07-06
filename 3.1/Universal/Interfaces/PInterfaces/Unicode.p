{
 	File:		Unicode.p
 
 	Contains:	Types, constants, and prototypes for Unicode Converter
 
 	Version:	Technology:	Mac OS 8 (Tempo)
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Unicode;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __UNICODE__}
{$SETC __UNICODE__ := 1}

{$I+}
{$SETC UnicodeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __UNICODECONVERTER__}
{$I UnicodeConverter.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := UnicodeIncludes}

{$ENDC} {__UNICODE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
