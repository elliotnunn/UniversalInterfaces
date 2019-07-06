{
 	File:		TSMTE.p
 
 	Contains:	Text Services Managerfor TextEdit Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	©1991-1998 Apple Technology, Inc. All rights reserved.
 
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
{  #include <Gestalt.i> }



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
	TSMDialogRecordPtr = ^TSMDialogRecord;
	TSMDialogRecord = RECORD
		fDialog:				DialogRecord;
		fDocID:					TSMDocumentID;
		fTSMTERecH:				TSMTERecHandle;
		fTSMTERsvd:				ARRAY [0..2] OF LONGINT;				{  reserved }
	END;

	TSMDialogPtr						= ^TSMDialogRecord;
	TSMDialogPeek						= TSMDialogPtr;

CONST
	uppTSMTEPreUpdateProcInfo = $000003C0;
	uppTSMTEPostUpdateProcInfo = $000FFFC0;

FUNCTION NewTSMTEPreUpdateProc(userRoutine: TSMTEPreUpdateProcPtr): TSMTEPreUpdateUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTSMTEPostUpdateProc(userRoutine: TSMTEPostUpdateProcPtr): TSMTEPostUpdateUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallTSMTEPreUpdateProc(textH: TEHandle; refCon: LONGINT; userRoutine: TSMTEPreUpdateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTSMTEPostUpdateProc(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT; userRoutine: TSMTEPostUpdateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TSMTEIncludes}

{$ENDC} {__TSMTE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
