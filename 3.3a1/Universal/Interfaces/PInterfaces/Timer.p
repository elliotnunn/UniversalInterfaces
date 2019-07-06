{
 	File:		Timer.p
 
 	Contains:	Time Manager interfaces.
 
 	Version:	Technology:	Mac OS 8.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1985-1993, 1995-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Timer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TIMER__}
{$SETC __TIMER__ := 1}

{$I+}
{$SETC TimerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  high bit of qType is set if task is active  }
	kTMTaskActive				= $00008000;


TYPE
	TMTaskPtr = ^TMTask;
{$IFC TYPED_FUNCTION_POINTERS}
	TimerProcPtr = PROCEDURE(tmTaskPtr: TMTaskPtr);
{$ELSEC}
	TimerProcPtr = Register68kProcPtr;
{$ENDC}

	TimerUPP = UniversalProcPtr;
	TMTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		tmAddr:					TimerUPP;
		tmCount:				LONGINT;
		tmWakeUp:				LONGINT;
		tmReserved:				LONGINT;
	END;

PROCEDURE InsTime(tmTaskPtr: QElemPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A058;
	{$ENDC}
PROCEDURE InsXTime(tmTaskPtr: QElemPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A458;
	{$ENDC}
PROCEDURE PrimeTime(tmTaskPtr: QElemPtr; count: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A05A;
	{$ENDC}
PROCEDURE RmvTime(tmTaskPtr: QElemPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A059;
	{$ENDC}

{ InstallTimeTask, InstallXTimeTask, PrimeTimeTask and RemoveTimeTask work }
{ just like InsTime, InsXTime, PrimeTime, and RmvTime except that they }
{ return an OSErr result. }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InstallTimeTask(tmTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A058, $3E80;
	{$ENDC}
FUNCTION InstallXTimeTask(tmTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A458, $3E80;
	{$ENDC}
FUNCTION PrimeTimeTask(tmTaskPtr: QElemPtr; count: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A05A, $3E80;
	{$ENDC}
FUNCTION RemoveTimeTask(tmTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A059, $3E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE Microseconds(VAR microTickCount: UnsignedWide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A193, $225F, $22C8, $2280;
	{$ENDC}

CONST
	uppTimerProcInfo = $0000B802;

FUNCTION NewTimerUPP(userRoutine: TimerProcPtr): TimerUPP; { old name was NewTimerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeTimerUPP(userUPP: TimerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeTimerUPP(tmTaskPtr: TMTaskPtr; userRoutine: TimerUPP); { old name was CallTimerProc }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TimerIncludes}

{$ENDC} {__TIMER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
