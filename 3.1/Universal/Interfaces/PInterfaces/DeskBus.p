{
 	File:		DeskBus.p
 
 	Contains:	Apple Desktop Bus (ADB) Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1987-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DeskBus;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DESKBUS__}
{$SETC __DESKBUS__ := 1}

{$I+}
{$SETC DeskBusIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_OS_MAC }

TYPE
	ADBAddress							= SInt8;
{$IFC TYPED_FUNCTION_POINTERS}
	ADBCompletionProcPtr = PROCEDURE(buffer: Ptr; refCon: Ptr; command: LONGINT);
{$ELSEC}
	ADBCompletionProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ADBDeviceDriverProcPtr = PROCEDURE(devAddress: SInt8; devType: SInt8);
{$ELSEC}
	ADBDeviceDriverProcPtr = Register68kProcPtr;
{$ENDC}

{
	TempADBServiceRoutineUPP is needed because of circular definition of
	ADBServiceRoutineProcPtr and ADBServiceRoutineUpp depending on each other.
}
	TempADBServiceRoutineUPP			= ProcPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ADBServiceRoutineProcPtr = PROCEDURE(buffer: Ptr; completionProc: TempADBServiceRoutineUPP; refCon: Ptr; command: LONGINT);
{$ELSEC}
	ADBServiceRoutineProcPtr = Register68kProcPtr;
{$ENDC}

	ADBCompletionUPP = UniversalProcPtr;
	ADBDeviceDriverUPP = UniversalProcPtr;
	ADBServiceRoutineUPP = UniversalProcPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ADBInitProcPtr = PROCEDURE(callOrder: SInt8);
{$ELSEC}
	ADBInitProcPtr = Register68kProcPtr;
{$ENDC}

	ADBInitUPP = UniversalProcPtr;
	ADBDataBlockPtr = ^ADBDataBlock;
	ADBDataBlock = PACKED RECORD
		devType:				SInt8;									{  original handler ID  }
		origADBAddr:			SInt8;									{  original ADB Address  }
		dbServiceRtPtr:			ADBServiceRoutineUPP;					{  service routine pointer  }
		dbDataAreaAddr:			Ptr;									{  this field is passed as the refCon parameter to the service routine  }
	END;

	ADBDBlkPtr							= ^ADBDataBlock;
	ADBSetInfoBlockPtr = ^ADBSetInfoBlock;
	ADBSetInfoBlock = RECORD
		siService:				ADBServiceRoutineUPP;					{  service routine pointer  }
		siDataAreaAddr:			Ptr;									{  this field is passed as the refCon parameter to the service routine  }
	END;

	ADBSInfoPtr							= ^ADBSetInfoBlock;
{ ADBOpBlock is only used when calling ADBOp from 68k assembly code }
	ADBOpBlockPtr = ^ADBOpBlock;
	ADBOpBlock = RECORD
		dataBuffPtr:			Ptr;									{  buffer: pointer to variable length data buffer  }
		opServiceRtPtr:			ADBServiceRoutineUPP;					{  completionProc: completion routine pointer  }
		opDataAreaPtr:			Ptr;									{  refCon: this field is passed as the refCon parameter to the completion routine  }
	END;

	ADBOpBPtr							= ^ADBOpBlock;
PROCEDURE ADBReInit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A07B;
	{$ENDC}
{
	ADBOp has a different interface for 68k assembly than for everything else
	for 68k assembly the interface is 
	#pragma parameter __D0 ADBOp(__A0,__D0)
	OSErr ADBOp( ADBOpBlock * pb, short commandNum );
}
{
	IMPORTANT NOTE:
	"Inside Macintosh: Devices" documents the completion routine for ADBOp will be called with
	four parameters using 68k register based calling conventions, specifically the completion routine
	passed in should be of type ADBServiceRoutineProcPtr. However, when upp types were first added
	to this interface file, the type ADBCompletionUPP was mistakenly used for the second parameter
	to ADBOp. Since applications have shipped using completion routines of type ADBCompletionUPP,
	the mistake cannot be corrected.
	The only difference between ADBServiceRoutineUPP and ADBCompletionUPP is the former takes an extra
	argument which is a pointer to itself, fortunately not needed for PowerPC code.
	For compatibility with existing 68k code, when an ADBOp completion routine is called,
	68k register A1 will point to the completion routine, as documented in Inside Mac.
}
FUNCTION ADBOp(refCon: Ptr; compRout: ADBCompletionUPP; buffer: Ptr; commandNum: INTEGER): OSErr;
FUNCTION CountADBs: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A077, $3E80;
	{$ENDC}
FUNCTION GetIndADB(VAR info: ADBDataBlock; devTableIndex: INTEGER): ADBAddress;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A078, $1E80;
	{$ENDC}
FUNCTION GetADBInfo(VAR info: ADBDataBlock; adbAddr: ADBAddress): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $205F, $A079, $3E80;
	{$ENDC}
FUNCTION SetADBInfo({CONST}VAR info: ADBSetInfoBlock; adbAddr: ADBAddress): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $205F, $A07A, $3E80;
	{$ENDC}

CONST
	uppADBCompletionProcInfo = $007B9802;
	uppADBDeviceDriverProcInfo = $00050802;
	uppADBServiceRoutineProcInfo = $0F779802;
	uppADBInitProcInfo = $00000802;

FUNCTION NewADBCompletionProc(userRoutine: ADBCompletionProcPtr): ADBCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewADBDeviceDriverProc(userRoutine: ADBDeviceDriverProcPtr): ADBDeviceDriverUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewADBServiceRoutineProc(userRoutine: ADBServiceRoutineProcPtr): ADBServiceRoutineUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewADBInitProc(userRoutine: ADBInitProcPtr): ADBInitUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallADBCompletionProc(buffer: Ptr; refCon: Ptr; command: LONGINT; userRoutine: ADBCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallADBDeviceDriverProc(devAddress: SInt8; devType: SInt8; userRoutine: ADBDeviceDriverUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallADBServiceRoutineProc(buffer: Ptr; completionProc: TempADBServiceRoutineUPP; refCon: Ptr; command: LONGINT; userRoutine: ADBServiceRoutineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallADBInitProc(callOrder: SInt8; userRoutine: ADBInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{$ENDC}  {TARGET_OS_MAC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DeskBusIncludes}

{$ENDC} {__DESKBUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
