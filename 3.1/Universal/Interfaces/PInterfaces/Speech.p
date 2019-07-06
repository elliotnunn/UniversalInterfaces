{
 	File:		Speech.p
 
 	Contains:	Speech Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1989-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Speech;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SPEECH__}
{$SETC __SPEECH__ := 1}

{$I+}
{$SETC SpeechIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{

	The interface file Speech.h has been renamed to SpeechSynthesis.h.

}
{$IFC UNDEFINED __SPEECHSYNTHESIS__}
{$I SpeechSynthesis.p}
{$ENDC}
{$SETC UsingIncludes := SpeechIncludes}

{$ENDC} {__SPEECH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
