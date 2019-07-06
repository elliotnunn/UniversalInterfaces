{
 	File:		StandardFile.p
 
 	Contains:	Standard File package Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1990-1995, 1997-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT StandardFile;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __STANDARDFILE__}
{$SETC __STANDARDFILE__ := 1}

{$I+}
{$SETC StandardFileIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  resource IDs of pre-7.0 get and put dialogs  }
	putDlgID					= -3999;
	getDlgID					= -4000;

																{  item offsets of pre-7.0 get and put dialogs  }
	putSave						= 1;
	putCancel					= 2;
	putEject					= 5;
	putDrive					= 6;
	putName						= 7;
	getOpen						= 1;
	getCancel					= 3;
	getEject					= 5;
	getDrive					= 6;
	getNmList					= 7;
	getScroll					= 8;

																{  resource IDs of 7.0 get and put dialogs  }
	sfPutDialogID				= -6043;
	sfGetDialogID				= -6042;

																{  item offsets of 7.0 get and put dialogs  }
	sfItemOpenButton			= 1;
	sfItemCancelButton			= 2;
	sfItemBalloonHelp			= 3;
	sfItemVolumeUser			= 4;
	sfItemEjectButton			= 5;
	sfItemDesktopButton			= 6;
	sfItemFileListUser			= 7;
	sfItemPopUpMenuUser			= 8;
	sfItemDividerLinePict		= 9;
	sfItemFileNameTextEdit		= 10;
	sfItemPromptStaticText		= 11;
	sfItemNewFolderUser			= 12;

																{  pseudo-item hits for use in DlgHook  }
	sfHookFirstCall				= -1;
	sfHookCharOffset			= $1000;
	sfHookNullEvent				= 100;
	sfHookRebuildList			= 101;
	sfHookFolderPopUp			= 102;
	sfHookOpenFolder			= 103;							{  the following are only in system 7.0+  }
	sfHookLastCall				= -2;
	sfHookOpenAlias				= 104;
	sfHookGoToDesktop			= 105;
	sfHookGoToAliasTarget		= 106;
	sfHookGoToParent			= 107;
	sfHookGoToNextDrive			= 108;
	sfHookGoToPrevDrive			= 109;
	sfHookChangeSelection		= 110;
	sfHookSetActiveOffset		= 200;


{ the refcon field of the dialog record during a
 modalfilter or dialoghook contains one of the following }
	sfMainDialogRefCon			= 'stdf';
	sfNewFolderDialogRefCon		= 'nfdr';
	sfReplaceDialogRefCon		= 'rplc';
	sfStatWarnDialogRefCon		= 'stat';
	sfLockWarnDialogRefCon		= 'lock';
	sfErrorDialogRefCon			= 'err ';



TYPE
	SFReplyPtr = ^SFReply;
	SFReply = RECORD
		good:					BOOLEAN;
		copy:					BOOLEAN;
		fType:					OSType;
		vRefNum:				INTEGER;
		version:				INTEGER;
		fName:					StrFileName;							{  a Str63 on MacOS  }
	END;

	StandardFileReplyPtr = ^StandardFileReply;
	StandardFileReply = RECORD
		sfGood:					BOOLEAN;
		sfReplacing:			BOOLEAN;
		sfType:					OSType;
		sfFile:					FSSpec;
		sfScript:				ScriptCode;
		sfFlags:				INTEGER;
		sfIsFolder:				BOOLEAN;
		sfIsVolume:				BOOLEAN;
		sfReserved1:			LONGINT;
		sfReserved2:			INTEGER;
	END;

{ for CustomXXXFile, ActivationOrderListPtr parameter is a pointer to an array of item numbers }
	ActivationOrderListPtr				= ^INTEGER;
{$IFC TYPED_FUNCTION_POINTERS}
	DlgHookProcPtr = FUNCTION(item: INTEGER; theDialog: DialogPtr): INTEGER;
{$ELSEC}
	DlgHookProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileFilterProcPtr = FUNCTION(pb: CInfoPBPtr): BOOLEAN;
{$ELSEC}
	FileFilterProcPtr = ProcPtr;
{$ENDC}

{ the following also include an extra parameter of "your data pointer" }
{$IFC TYPED_FUNCTION_POINTERS}
	DlgHookYDProcPtr = FUNCTION(item: INTEGER; theDialog: DialogPtr; yourDataPtr: UNIV Ptr): INTEGER;
{$ELSEC}
	DlgHookYDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ModalFilterYDProcPtr = FUNCTION(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr): BOOLEAN;
{$ELSEC}
	ModalFilterYDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileFilterYDProcPtr = FUNCTION(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr): BOOLEAN;
{$ELSEC}
	FileFilterYDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ActivateYDProcPtr = PROCEDURE(theDialog: DialogPtr; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr);
{$ELSEC}
	ActivateYDProcPtr = ProcPtr;
{$ENDC}

	DlgHookUPP = UniversalProcPtr;
	FileFilterUPP = UniversalProcPtr;
	DlgHookYDUPP = UniversalProcPtr;
	ModalFilterYDUPP = UniversalProcPtr;
	FileFilterYDUPP = UniversalProcPtr;
	ActivateYDUPP = UniversalProcPtr;

CONST
	uppDlgHookProcInfo = $000003A0;
	uppFileFilterProcInfo = $000000D0;
	uppDlgHookYDProcInfo = $00000FA0;
	uppModalFilterYDProcInfo = $00003FD0;
	uppFileFilterYDProcInfo = $000003D0;
	uppActivateYDProcInfo = $000036C0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewDlgHookUPP(userRoutine: DlgHookProcPtr): DlgHookUPP; { old name was NewDlgHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileFilterUPP(userRoutine: FileFilterProcPtr): FileFilterUPP; { old name was NewFileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDlgHookYDUPP(userRoutine: DlgHookYDProcPtr): DlgHookYDUPP; { old name was NewDlgHookYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewModalFilterYDUPP(userRoutine: ModalFilterYDProcPtr): ModalFilterYDUPP; { old name was NewModalFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileFilterYDUPP(userRoutine: FileFilterYDProcPtr): FileFilterYDUPP; { old name was NewFileFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewActivateYDUPP(userRoutine: ActivateYDProcPtr): ActivateYDUPP; { old name was NewActivateYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDlgHookUPP(userUPP: DlgHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeFileFilterUPP(userUPP: FileFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDlgHookYDUPP(userUPP: DlgHookYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeModalFilterYDUPP(userUPP: ModalFilterYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeFileFilterYDUPP(userUPP: FileFilterYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeActivateYDUPP(userUPP: ActivateYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeDlgHookUPP(item: INTEGER; theDialog: DialogPtr; userRoutine: DlgHookUPP): INTEGER; { old name was CallDlgHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeFileFilterUPP(pb: CInfoPBPtr; userRoutine: FileFilterUPP): BOOLEAN; { old name was CallFileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDlgHookYDUPP(item: INTEGER; theDialog: DialogPtr; yourDataPtr: UNIV Ptr; userRoutine: DlgHookYDUPP): INTEGER; { old name was CallDlgHookYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeModalFilterYDUPP(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr; userRoutine: ModalFilterYDUPP): BOOLEAN; { old name was CallModalFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeFileFilterYDUPP(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr; userRoutine: FileFilterYDUPP): BOOLEAN; { old name was CallFileFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeActivateYDUPP(theDialog: DialogPtr; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr; userRoutine: ActivateYDUPP); { old name was CallActivateYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	SFTypeList							= ARRAY [0..3] OF OSType;
{
	The GetFile "typeList" parameter type has changed from "SFTypeList" to "ConstSFTypeListPtr".
	For C, this will add "const" and make it an in-only parameter.
	For Pascal, this will require client code to use the @ operator, but make it easier to specify long lists.

	ConstSFTypeListPtr is a pointer to an array of OSTypes.
}
	ConstSFTypeListPtr					= ^OSType;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SFPutFile(where: Point; prompt: Str255; origName: Str255; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A9EA;
	{$ENDC}
PROCEDURE SFGetFile(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A9EA;
	{$ENDC}
PROCEDURE SFPPutFile(where: Point; prompt: Str255; origName: Str255; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A9EA;
	{$ENDC}
PROCEDURE SFPGetFile(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9EA;
	{$ENDC}
PROCEDURE StandardPutFile(prompt: Str255; defaultName: Str255; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A9EA;
	{$ENDC}
PROCEDURE StandardGetFile(fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A9EA;
	{$ENDC}
PROCEDURE CustomPutFile(prompt: Str255; defaultName: Str255; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activate: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A9EA;
	{$ENDC}
PROCEDURE CustomGetFile(fileFilter: FileFilterYDUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activate: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A9EA;
	{$ENDC}
FUNCTION StandardOpenDialog(VAR reply: StandardFileReply): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StandardFileIncludes}

{$ENDC} {__STANDARDFILE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
