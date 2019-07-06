{
 	File:		CTBUtilities.p
 
 	Contains:	Communications Toolbox Utilities interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1988-1993, 1995-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CTBUtilities;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CTBUTILITIES__}
{$SETC __CTBUTILITIES__ := 1}

{$I+}
{$SETC CTBUtilitiesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	curCTBUVersion				= 2;							{  version of Comm Toolbox Utilities }

																{     Error codes/types     }
	ctbuGenericError			= -1;
	ctbuNoErr					= 0;


TYPE
	CTBUErr								= OSErr;

CONST
	chooseDisaster				= -2;
	chooseFailed				= -1;
	chooseAborted				= 0;
	chooseOKMinor				= 1;
	chooseOKMajor				= 2;
	chooseCancel				= 3;


TYPE
	ChooseReturnCode					= INTEGER;

CONST
	nlOk						= 0;
	nlCancel					= 1;
	nlEject						= 2;


TYPE
	NuLookupReturnCode					= INTEGER;

CONST
	nameInclude					= 1;
	nameDisable					= 2;
	nameReject					= 3;


TYPE
	NameFilterReturnCode				= INTEGER;

CONST
	zoneInclude					= 1;
	zoneDisable					= 2;
	zoneReject					= 3;


TYPE
	ZoneFilterReturnCode				= INTEGER;

CONST
																{ 	Values for hookProc items		 }
	hookOK						= 1;
	hookCancel					= 2;
	hookOutline					= 3;
	hookTitle					= 4;
	hookItemList				= 5;
	hookZoneTitle				= 6;
	hookZoneList				= 7;
	hookLine					= 8;
	hookVersion					= 9;
	hookReserved1				= 10;
	hookReserved2				= 11;
	hookReserved3				= 12;
	hookReserved4				= 13;							{ 	"virtual" hookProc items	 }
	hookNull					= 100;
	hookItemRefresh				= 101;
	hookZoneRefresh				= 102;
	hookEject					= 103;
	hookPreflight				= 104;
	hookPostflight				= 105;
	hookKeyBase					= 1000;


{	NuLookup structures/constants	}

TYPE
	NLTypeEntryPtr = ^NLTypeEntry;
	NLTypeEntry = RECORD
		hIcon:					Handle;
		typeStr:				Str32;
	END;

	NLType								= ARRAY [0..3] OF NLTypeEntry;
	NBPReplyPtr = ^NBPReply;
	NBPReply = RECORD
		theEntity:				EntityName;
		theAddr:				AddrBlock;
	END;

	DialogHookProcPtr = ProcPtr;  { FUNCTION DialogHook(item: INTEGER; theDialog: DialogPtr): INTEGER; }

	NameFilterProcPtr = ProcPtr;  { FUNCTION NameFilter((CONST)VAR theEntity: EntityName): INTEGER; }

	ZoneFilterProcPtr = ProcPtr;  { FUNCTION ZoneFilter(theZone: ConstStr32Param): INTEGER; }

	DialogHookUPP = UniversalProcPtr;
	NameFilterUPP = UniversalProcPtr;
	ZoneFilterUPP = UniversalProcPtr;

CONST
	uppDialogHookProcInfo = $000003A0;
	uppNameFilterProcInfo = $000000E0;
	uppZoneFilterProcInfo = $000000E0;

FUNCTION NewDialogHookProc(userRoutine: DialogHookProcPtr): DialogHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNameFilterProc(userRoutine: NameFilterProcPtr): NameFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewZoneFilterProc(userRoutine: ZoneFilterProcPtr): ZoneFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDialogHookProc(item: INTEGER; theDialog: DialogPtr; userRoutine: DialogHookUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNameFilterProc({CONST}VAR theEntity: EntityName; userRoutine: NameFilterUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallZoneFilterProc(theZone: ConstStr32Param; userRoutine: ZoneFilterUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION InitCTBUtilities: CTBUErr;
FUNCTION CTBGetCTBVersion: INTEGER;
FUNCTION StandardNBP(where: Point; prompt: ConstStr255Param; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; VAR theReply: NBPReply): INTEGER;
FUNCTION CustomNBP(where: Point; prompt: ConstStr255Param; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; userData: LONGINT; dialogID: INTEGER; filter: ModalFilterUPP; VAR theReply: NBPReply): INTEGER;
{$IFC OLDROUTINENAMES }
FUNCTION NuLookup(where: Point; prompt: Str255; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; VAR theReply: NBPReply): INTEGER;
FUNCTION NuPLookup(where: Point; prompt: Str255; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; userData: LONGINT; dialogID: INTEGER; filter: ModalFilterUPP; VAR theReply: NBPReply): INTEGER;
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CTBUtilitiesIncludes}

{$ENDC} {__CTBUTILITIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
