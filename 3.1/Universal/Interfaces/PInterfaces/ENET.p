{
 	File:		ENET.p
 
 	Contains:	Ethernet Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1990-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ENET;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ENET__}
{$SETC __ENET__ := 1}

{$I+}
{$SETC ENETIncludes := UsingIncludes}
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


CONST
	ENetSetGeneral				= 253;							{ Set "general" mode }
	ENetGetInfo					= 252;							{ Get info }
	ENetRdCancel				= 251;							{ Cancel read }
	ENetRead					= 250;							{ Read }
	ENetWrite					= 249;							{ Write }
	ENetDetachPH				= 248;							{ Detach protocol handler }
	ENetAttachPH				= 247;							{ Attach protocol handler }
	ENetAddMulti				= 246;							{ Add a multicast address }
	ENetDelMulti				= 245;							{ Delete a multicast address }

	EAddrRType					= 'eadr';						{ Alternate address resource type }


TYPE
	EParamBlockPtr = ^EParamBlock;
	EParamBlkPtr						= ^EParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	ENETCompletionProcPtr = PROCEDURE(thePBPtr: EParamBlkPtr);
{$ELSEC}
	ENETCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	ENETCompletionUPP = UniversalProcPtr;
	EParamBlock = PACKED RECORD
		qLink:					QElemPtr;								{ General EParams }
		qType:					INTEGER;								{ queue type }
		ioTrap:					INTEGER;								{ routine trap }
		ioCmdAddr:				Ptr;									{ routine address }
		ioCompletion:			ENETCompletionUPP;						{ completion routine }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ->filename }
		ioVRefNum:				INTEGER;								{ volume reference or drive number }
		ioRefNum:				INTEGER;								{ driver reference number }
		csCode:					INTEGER;								{ Call command code }
		CASE INTEGER OF
		0: (
			eProtType:			INTEGER;								{ Ethernet protocol type }
			ePointer:			Ptr;									{ No support for PowerPC code }
			eBuffSize:			INTEGER;								{ buffer size }
			eDataSize:			INTEGER;								{ number of bytes read }
		   );
		1: (
			eMultiAddr:			PACKED ARRAY [0..5] OF Byte;			{ Multicast Address }
		   );
	END;


CONST
	uppENETCompletionProcInfo = $00009802;

PROCEDURE CallENETCompletionProc(thePBPtr: EParamBlkPtr; userRoutine: ENETCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION NewENETCompletionProc(userRoutine: ENETCompletionProcPtr): ENETCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
FUNCTION EWrite(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EAttachPH(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EDetachPH(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ERead(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ERdCancel(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EGetInfo(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ESetGeneral(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EAddMulti(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EDelMulti(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ENETIncludes}

{$ENDC} {__ENET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
