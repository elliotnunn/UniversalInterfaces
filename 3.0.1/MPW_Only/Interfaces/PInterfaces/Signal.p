
{
Created: Friday, August 2, 1991 at 11:40 PM
 Signal.p
 Pascal Interface to the Macintosh Libraries

	Signal Handling interface.
	This must be compatible with C's <signal.h>

  Copyright Apple Computer, Inc. 1986, 1987, 1988, 1991, 1994
  All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Signal;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSignal AND UNDEFINED __SIGNAL__}
{$SETC UsingSignal := 1}
{$SETC __SIGNAL__ := 1}

{$I+}
{$SETC SignalIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$ALIGN MAC68K}


TYPE
	SignalMap = 	INTEGER;
	SignalHandler = ^LONGINT;	{ Pointer to function }

CONST
	SIG_ERR =	   -1;			{ Returned by IEsignal on error }
	SIG_IGN =		0;
	SIG_DFL =		1;
	SIG_HOLD =		3;
	SIG_RELEASE =	5;

	SIGABRT =		$0001;
	SIGINT =		$0002;		{ Currently only SIGINT implemented }
	SIGFPE = 		$0004;
	SIGILL =		$0008;
	SIGSEGV =		$0010;
	SIGTERM =		$0020;

{ Signal Handling Functions }

{$IFC NOT UNDEFINED __CFM68K__}
	{$IFC NOT UNDEFINED UsingSharedLibs}
		{$PUSH}
		{$LibExport+}
	{$ENDC}
{$ENDC}

FUNCTION
	IEsignal(sigNum: LONGINT; sigHdlr: UNIV SignalHandler):
	SignalHandler; C;

FUNCTION
	IEraise(sigNum: LONGINT):
	LONGINT; C;

{$IFC NOT UNDEFINED __CFM68K__}
	{$IFC NOT UNDEFINED UsingSharedLibs}
		{$POP}
	{$ENDC}
{$ENDC}

{$ALIGN RESET}

{$SETC UsingIncludes := SignalIncludes}

{$ENDC} { UsingSignal }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
