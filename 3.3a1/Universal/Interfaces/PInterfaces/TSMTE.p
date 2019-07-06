{
 	File:		TSMTE.p
 
 	Contains:	Text Services Managerfor TextEdit Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	©1991-1999 Apple Technology, Inc. All rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TSMTE;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TSMTE__}
{$SETC __TSMTE__ := 1}

{$I+}
{$SETC TSMTEIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __TEXTSERVICES__}
{$I TextServices.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  signature, interface types }

CONST
	kTSMTESignature				= 'tmTE';
	kTSMTEInterfaceType			= 'tmTE';
	kTSMTEDialog				= 'tmDI';


{  update flag for TSMTERec }
	kTSMTEAutoScroll			= 1;


{  callback procedure definitions }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TSMTEPreUpdateProcPtr = PROCEDURE(textH: TEHandle; refCon: LONGINT);
{$ELSEC}
	TSMTEPreUpdateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TSMTEPostUpdateProcPtr = PROCEDURE(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT);
{$ELSEC}
	TSMTEPostUpdateProcPtr = ProcPtr;
{$ENDC}

	TSMTEPreUpdateUPP = UniversalProcPtr;
	TSMTEPostUpdateUPP = UniversalProcPtr;


{  data types }
	TSMTERecPtr = ^TSMTERec;
	TSMTERec = RECORD
		textH:					TEHandle;
		preUpdateProc:			TSMTEPreUpdateUPP;
		postUpdateProc:			TSMTEPostUpdateUPP;
		updateFlag:				LONGINT;
		refCon:					LONGINT;
	END;

	TSMTERecHandle						= ^TSMTERecPtr;
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	TSMDialogRecordPtr = ^TSMDialogRecord;
	TSMDialogRecord = RECORD
		fDialog:				DialogRecord;
		fDocID:					TSMDocumentID;
		fTSMTERecH:				TSMTERecHandle;
		fTSMTERsvd:				ARRAY [0..2] OF LONGINT;				{  reserved }
	END;

	TSMDialogPtr						= ^TSMDialogRecord;
	TSMDialogPeek						= TSMDialogPtr;
{$ENDC}


CONST
	uppTSMTEPreUpdateProcInfo = $000003C0;
	uppTSMTEPostUpdateProcInfo = $000FFFC0;

FUNCTION NewTSMTEPreUpdateUPP(userRoutine: TSMTEPreUpdateProcPtr): TSMTEPreUpdateUPP; { old name was NewTSMTEPreUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTSMTEPostUpdateUPP(userRoutine: TSMTEPostUpdateProcPtr): TSMTEPostUpdateUPP; { old name was NewTSMTEPostUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeTSMTEPreUpdateUPP(userUPP: TSMTEPreUpdateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeTSMTEPostUpdateUPP(userUPP: TSMTEPostUpdateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeTSMTEPreUpdateUPP(textH: TEHandle; refCon: LONGINT; userRoutine: TSMTEPreUpdateUPP); { old name was CallTSMTEPreUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeTSMTEPostUpdateUPP(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT; userRoutine: TSMTEPostUpdateUPP); { old name was CallTSMTEPostUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
FUNCTION IsTSMTEDialog(dialog: DialogPtr): BOOLEAN;
{ Getters }
FUNCTION GetTSMTEDialogDocumentID(dialog: DialogPtr): TSMDocumentID;
FUNCTION GetTSMTEDialogTSMTERecHandle(dialog: DialogPtr): TSMTERecHandle;
{ Setters }
PROCEDURE SetTSMTEDialogDocumentID(dialog: DialogPtr; documentID: TSMDocumentID);
PROCEDURE SetTSMTEDialogTSMTERecHandle(dialog: DialogPtr; tsmteRecHandle: TSMTERecHandle);
{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TSMTEIncludes}

{$ENDC} {__TSMTE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
