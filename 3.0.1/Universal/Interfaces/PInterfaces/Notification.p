{
 	File:		Notification.p
 
 	Contains:	Notification Manager interfaces
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1989-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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
	NMRecPtr = ^NMRec;
	NMProcPtr = ProcPtr;  { PROCEDURE NM(nmReqPtr: NMRecPtr); }

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

PROCEDURE CallNMProc(nmReqPtr: NMRecPtr; userRoutine: NMUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewNMProc(userRoutine: NMProcPtr): NMUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
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