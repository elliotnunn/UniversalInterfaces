{
 	File:		StandardFile.p
 
 	Contains:	Standard File package Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997, 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
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
		fName:					Str63;
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
	DlgHookProcPtr = ProcPtr;  { FUNCTION DlgHook(item: INTEGER; theDialog: DialogPtr): INTEGER; }

	FileFilterProcPtr = ProcPtr;  { FUNCTION FileFilter(pb: CInfoPBPtr): BOOLEAN; }

{ the following also include an extra parameter of "your data pointer" }
	DlgHookYDProcPtr = ProcPtr;  { FUNCTION DlgHookYD(item: INTEGER; theDialog: DialogPtr; yourDataPtr: UNIV Ptr): INTEGER; }

	ModalFilterYDProcPtr = ProcPtr;  { FUNCTION ModalFilterYD(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr): BOOLEAN; }

	FileFilterYDProcPtr = ProcPtr;  { FUNCTION FileFilterYD(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr): BOOLEAN; }

	ActivateYDProcPtr = ProcPtr;  { PROCEDURE ActivateYD(theDialog: DialogPtr; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr); }

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

FUNCTION NewDlgHookProc(userRoutine: DlgHookProcPtr): DlgHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileFilterProc(userRoutine: FileFilterProcPtr): FileFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDlgHookYDProc(userRoutine: DlgHookYDProcPtr): DlgHookYDUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewModalFilterYDProc(userRoutine: ModalFilterYDProcPtr): ModalFilterYDUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileFilterYDProc(userRoutine: FileFilterYDProcPtr): FileFilterYDUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewActivateYDProc(userRoutine: ActivateYDProcPtr): ActivateYDUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDlgHookProc(item: INTEGER; theDialog: DialogPtr; userRoutine: DlgHookUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileFilterProc(pb: CInfoPBPtr; userRoutine: FileFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDlgHookYDProc(item: INTEGER; theDialog: DialogPtr; yourDataPtr: UNIV Ptr; userRoutine: DlgHookYDUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallModalFilterYDProc(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr; userRoutine: ModalFilterYDUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileFilterYDProc(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr; userRoutine: FileFilterYDUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallActivateYDProc(theDialog: DialogPtr; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr; userRoutine: ActivateYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SFTypeList							= ARRAY [0..3] OF OSType;
{
	The GetFile "typeList" parameter type has changed from "SFTypeList" to "ConstSFTypeListPtr".
	For C, this will add "const" and make it an in-only parameter.
	For Pascal, this will require client code to use the @ operator, but make it easier to specify long lists.

	ConstSFTypeListPtr is a pointer to an array of OSTypes.
}
	ConstSFTypeListPtr					= ^OSType;

PROCEDURE SFPutFile(where: Point; prompt: ConstStr255Param; origName: ConstStr255Param; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A9EA;
	{$ENDC}
PROCEDURE SFGetFile(where: Point; prompt: ConstStr255Param; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A9EA;
	{$ENDC}
PROCEDURE SFPPutFile(where: Point; prompt: ConstStr255Param; origName: ConstStr255Param; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A9EA;
	{$ENDC}
PROCEDURE SFPGetFile(where: Point; prompt: ConstStr255Param; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9EA;
	{$ENDC}
PROCEDURE StandardPutFile(prompt: ConstStr255Param; defaultName: ConstStr255Param; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A9EA;
	{$ENDC}
PROCEDURE StandardGetFile(fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A9EA;
	{$ENDC}
PROCEDURE CustomPutFile(prompt: ConstStr255Param; defaultName: ConstStr255Param; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activate: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A9EA;
	{$ENDC}
PROCEDURE CustomGetFile(fileFilter: FileFilterYDUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activate: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A9EA;
	{$ENDC}
FUNCTION StandardOpenDialog(VAR reply: StandardFileReply): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StandardFileIncludes}

{$ENDC} {__STANDARDFILE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
