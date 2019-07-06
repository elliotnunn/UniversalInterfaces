{
     File:       Notification.p
 
     Contains:   Notification Manager interfaces
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1989-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Notification;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NOTIFICATION__}
{$SETC __NOTIFICATION__ := 1}

{$I+}
{$SETC NotificationIncludes := UsingIncludes}
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
	NMRecPtr = ^NMRec;
{$IFC TYPED_FUNCTION_POINTERS}
	NMProcPtr = PROCEDURE(nmReqPtr: NMRecPtr);
{$ELSEC}
	NMProcPtr = ProcPtr;
{$ENDC}

	NMUPP = UniversalProcPtr;
	NMRec = RECORD
		qLink:					QElemPtr;								{  next queue entry }
		qType:					INTEGER;								{  queue type -- ORD(nmType) = 8 }
		nmFlags:				INTEGER;								{  reserved }
		nmPrivate:				LONGINT;								{  reserved }
		nmReserved:				INTEGER;								{  reserved }
		nmMark:					INTEGER;								{  item to mark in Apple menu }
		nmIcon:					Handle;									{  handle to small icon }
		nmSound:				Handle;									{  handle to sound record }
		nmStr:					StringPtr;								{  string to appear in alert }
		nmResp:					NMUPP;									{  pointer to response routine }
		nmRefCon:				LONGINT;								{  for application use }
	END;


CONST
	uppNMProcInfo = $000000C0;

FUNCTION NewNMUPP(userRoutine: NMProcPtr): NMUPP; { old name was NewNMProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeNMUPP(userUPP: NMUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeNMUPP(nmReqPtr: NMRecPtr; userRoutine: NMUPP); { old name was CallNMProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION NMInstall(nmReqPtr: NMRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A05E, $3E80;
	{$ENDC}
FUNCTION NMRemove(nmReqPtr: NMRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A05F, $3E80;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NotificationIncludes}

{$ENDC} {__NOTIFICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
