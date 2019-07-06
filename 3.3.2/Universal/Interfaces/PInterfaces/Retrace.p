{
     File:       Retrace.p
 
     Contains:   Vertical Retrace Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	VBLTaskPtr = ^VBLTask;
{$IFC TYPED_FUNCTION_POINTERS}
	VBLProcPtr = PROCEDURE(vblTaskPtr: VBLTaskPtr);
{$ELSEC}
	VBLProcPtr = Register68kProcPtr;
{$ENDC}

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
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewVBLUPP(userRoutine: VBLProcPtr): VBLUPP; { old name was NewVBLProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeVBLUPP(userUPP: VBLUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeVBLUPP(vblTaskPtr: VBLTaskPtr; userRoutine: VBLUPP); { old name was CallVBLProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := RetraceIncludes}

{$ENDC} {__RETRACE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
