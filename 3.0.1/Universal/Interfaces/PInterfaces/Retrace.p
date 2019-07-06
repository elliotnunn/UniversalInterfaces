{
 	File:		Retrace.p
 
 	Contains:	Vertical Retrace Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1993, 1995-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Retrace;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RETRACE__}
{$SETC __RETRACE__ := 1}

{$I+}
{$SETC RetraceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	VBLTaskPtr = ^VBLTask;
	VBLProcPtr = Register68kProcPtr;  { PROCEDURE VBL(vblTaskPtr: VBLTaskPtr); }

	VBLUPP = UniversalProcPtr;
	VBLTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		vblAddr:				VBLUPP;
		vblCount:				INTEGER;
		vblPhase:				INTEGER;
	END;


CONST
	uppVBLProcInfo = $00009802;

FUNCTION NewVBLProc(userRoutine: VBLProcPtr): VBLUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallVBLProc(vblTaskPtr: VBLTaskPtr; userRoutine: VBLUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
FUNCTION GetVBLQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0160;
	{$ENDC}
FUNCTION SlotVInstall(vblBlockPtr: QElemPtr; theSlot: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A06F, $3E80;
	{$ENDC}
FUNCTION SlotVRemove(vblBlockPtr: QElemPtr; theSlot: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A070, $3E80;
	{$ENDC}
FUNCTION AttachVBL(theSlot: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A071, $3E80;
	{$ENDC}
FUNCTION DoVBLTask(theSlot: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A072, $3E80;
	{$ENDC}
FUNCTION VInstall(vblTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A033, $3E80;
	{$ENDC}
FUNCTION VRemove(vblTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A034, $3E80;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := RetraceIncludes}

{$ENDC} {__RETRACE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
