{
 	File:		Dialogs.p
 
 	Contains:	Dialog Manager interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Dialogs;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DIALOGS__}
{$SETC __DIALOGS__ := 1}

{$I+}
{$SETC DialogsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{	MixedMode.p													}

{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{	Quickdraw.p													}
{		QuickdrawText.p											}

{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Events.p													}
{		OSUtils.p												}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	ctrlItem					= 4;
	btnCtrl						= 0;
	chkCtrl						= 1;
	radCtrl						= 2;
	resCtrl						= 3;
	statText					= 8;
	editText					= 16;
	iconItem					= 32;
	picItem						= 64;
	userItem					= 0;
	itemDisable					= 128;
	ok							= 1;
	cancel						= 2;
	stopIcon					= 0;
	noteIcon					= 1;
	cautionIcon					= 2;

{ new, more standard names for dialog item constants }
	kControlDialogItem			= ctrlItem;
	kButtonDialogItem			= ctrlItem + btnCtrl;
	kCheckBoxDialogItem			= ctrlItem + chkCtrl;
	kRadioButtonDialogItem		= ctrlItem + radCtrl;
	kResourceControlDialogItem	= ctrlItem + resCtrl;
	kStaticTextDialogItem		= statText;
	kEditTextDialogItem			= editText;
	kIconDialogItem				= iconItem;
	kPictureDialogItem			= picItem;
	kUserDialogItem				= userItem;
	kItemDisableBit				= itemDisable;
	kStdOkItemIndex				= ok;
	kStdCancelItemIndex			= cancel;
	kStopIcon					= stopIcon;
	kNoteIcon					= noteIcon;
	kCautionIcon				= cautionIcon;

{$IFC OLDROUTINENAMES }
	kOkItemIndex				= kStdOkItemIndex;
	kCancelItemIndex			= kStdCancelItemIndex;

{$ENDC}
	
TYPE
	DITLMethod = SInt16;


CONST
	overlayDITL					= 0;
	appendDITLRight				= 1;
	appendDITLBottom			= 2;

	
TYPE
	StageList = INTEGER;

	DialogPropertyTag = OSType;

	DialogPtr = WindowPtr;

	DialogRef = DialogPtr;


	SoundProcPtr = ProcPtr;  { PROCEDURE Sound(soundNumber: INTEGER); }
	ModalFilterProcPtr = ProcPtr;  { FUNCTION ModalFilter(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER): BOOLEAN; }
	UserItemProcPtr = ProcPtr;  { PROCEDURE UserItem(theWindow: WindowPtr; itemNo: INTEGER); }
	SoundUPP = UniversalProcPtr;
	ModalFilterUPP = UniversalProcPtr;
	UserItemUPP = UniversalProcPtr;

CONST
	uppSoundProcInfo = $00000080; { PROCEDURE (2 byte param); }
	uppModalFilterProcInfo = $00000FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppUserItemProcInfo = $000002C0; { PROCEDURE (4 byte param, 2 byte param); }

FUNCTION NewSoundProc(userRoutine: SoundProcPtr): SoundUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewModalFilterProc(userRoutine: ModalFilterProcPtr): ModalFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserItemProc(userRoutine: UserItemProcPtr): UserItemUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSoundProc(soundNumber: INTEGER; userRoutine: SoundUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallModalFilterProc(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; userRoutine: ModalFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallUserItemProc(theWindow: WindowPtr; itemNo: INTEGER; userRoutine: UserItemUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	DialogRecord = RECORD
		window:					WindowRecord;
		items:					Handle;
		textH:					TEHandle;
		editField:				INTEGER;
		editOpen:				INTEGER;
		aDefItem:				INTEGER;
	END;

	DialogPeek = ^DialogRecord;

	DialogTemplate = RECORD
		boundsRect:				Rect;
		procID:					INTEGER;
		visible:				BOOLEAN;
		filler1:				BOOLEAN;
		goAwayFlag:				BOOLEAN;
		filler2:				BOOLEAN;
		refCon:					LONGINT;
		itemsID:				INTEGER;
		title:					Str255;
	END;

	DialogTPtr = ^DialogTemplate;
	DialogTHndl = ^DialogTPtr;

	AlertTemplate = RECORD
		boundsRect:				Rect;
		itemsID:				INTEGER;
		stages:					StageList;
	END;

	AlertTPtr = ^AlertTemplate;
	AlertTHndl = ^AlertTPtr;


PROCEDURE InitDialogs(ignored: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A97B;
	{$ENDC}
PROCEDURE ErrorSound(soundProc: SoundUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98C;
	{$ENDC}
FUNCTION NewDialog(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; procID: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT; itmLstHndl: Handle): DialogRef;
	{$IFC NOT GENERATINGCFM}
	INLINE $A97D;
	{$ENDC}
FUNCTION GetNewDialog(dialogID: INTEGER; dStorage: UNIV Ptr; behind: WindowRef): DialogRef;
	{$IFC NOT GENERATINGCFM}
	INLINE $A97C;
	{$ENDC}
PROCEDURE CloseDialog(theDialog: DialogRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $A982;
	{$ENDC}
PROCEDURE DisposeDialog(theDialog: DialogRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $A983;
	{$ENDC}
PROCEDURE ParamText(param0: ConstStr255Param; param1: ConstStr255Param; param2: ConstStr255Param; param3: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98B;
	{$ENDC}
PROCEDURE ModalDialog(modalFilter: ModalFilterUPP; VAR itemHit: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A991;
	{$ENDC}
FUNCTION IsDialogEvent({CONST}VAR theEvent: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A97F;
	{$ENDC}
FUNCTION DialogSelect({CONST}VAR theEvent: EventRecord; VAR theDialog: DialogRef; VAR itemHit: INTEGER): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A980;
	{$ENDC}
PROCEDURE DrawDialog(theDialog: DialogRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $A981;
	{$ENDC}
PROCEDURE UpdateDialog(theDialog: DialogRef; updateRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A978;
	{$ENDC}
FUNCTION Alert(alertID: INTEGER; modalFilter: ModalFilterUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A985;
	{$ENDC}
FUNCTION StopAlert(alertID: INTEGER; modalFilter: ModalFilterUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A986;
	{$ENDC}
FUNCTION NoteAlert(alertID: INTEGER; modalFilter: ModalFilterUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A987;
	{$ENDC}
FUNCTION CautionAlert(alertID: INTEGER; modalFilter: ModalFilterUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A988;
	{$ENDC}
PROCEDURE GetDialogItem(theDialog: DialogRef; itemNo: INTEGER; VAR itemType: INTEGER; VAR item: Handle; VAR box: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98D;
	{$ENDC}
PROCEDURE SetDialogItem(theDialog: DialogRef; itemNo: INTEGER; itemType: INTEGER; item: Handle; {CONST}VAR box: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98E;
	{$ENDC}
PROCEDURE HideDialogItem(theDialog: DialogRef; itemNo: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A827;
	{$ENDC}
PROCEDURE ShowDialogItem(theDialog: DialogRef; itemNo: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A828;
	{$ENDC}
PROCEDURE SelectDialogItemText(theDialog: DialogRef; itemNo: INTEGER; strtSel: INTEGER; endSel: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A97E;
	{$ENDC}
PROCEDURE GetDialogItemText(item: Handle; VAR text: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A990;
	{$ENDC}
PROCEDURE SetDialogItemText(item: Handle; text: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98F;
	{$ENDC}
FUNCTION FindDialogItem(theDialog: DialogRef; thePt: Point): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A984;
	{$ENDC}
FUNCTION NewColorDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; procID: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT; items: Handle): DialogRef;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4B;
	{$ENDC}
FUNCTION GetAlertStage : INTEGER;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $3EB8, $0A9A;			{ MOVE.w $0A9A,(SP) }
	{$ENDC}

PROCEDURE ResetAlertStage;
	{$IFC NOT GENERATINGCFM}
	INLINE $4278, $0A9A;
	{$ENDC}
PROCEDURE DialogCut(theDialog: DialogRef);
PROCEDURE DialogPaste(theDialog: DialogRef);
PROCEDURE DialogCopy(theDialog: DialogRef);
PROCEDURE DialogDelete(theDialog: DialogRef);
PROCEDURE SetDialogFont( value: INTEGER );
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $31DF, $0AFA;			{ MOVE.w (SP)+,$0AFA }
	{$ENDC}

PROCEDURE AppendDITL(theDialog: DialogRef; theHandle: Handle; method: DITLMethod);
FUNCTION CountDITL(theDialog: DialogRef): INTEGER;
PROCEDURE ShortenDITL(theDialog: DialogRef; numberItems: INTEGER);
FUNCTION StdFilterProc(theDialog: DialogRef; VAR event: EventRecord; VAR itemHit: INTEGER): BOOLEAN;
FUNCTION GetStdFilterProc(VAR theProc: ModalFilterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0203, $AA68;
	{$ENDC}
FUNCTION SetDialogDefaultItem(theDialog: DialogRef; newItem: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0304, $AA68;
	{$ENDC}
FUNCTION SetDialogCancelItem(theDialog: DialogRef; newItem: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0305, $AA68;
	{$ENDC}
FUNCTION SetDialogTracksCursor(theDialog: DialogRef; tracks: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0306, $AA68;
	{$ENDC}
{$IFC OLDROUTINENAMES }
{$IFC NOT GENERATINGCFM }
PROCEDURE CouldDialog(dialogID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A979;
	{$ENDC}
PROCEDURE FreeDialog(dialogID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A97A;
	{$ENDC}
PROCEDURE CouldAlert(alertID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A989;
	{$ENDC}
PROCEDURE FreeAlert(alertID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98A;
	{$ENDC}
{$ENDC}
PROCEDURE DisposDialog(theDialog: DialogRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $A983;
	{$ENDC}
PROCEDURE UpdtDialog(theDialog: DialogRef; updateRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A978;
	{$ENDC}
PROCEDURE GetDItem(theDialog: DialogRef; itemNo: INTEGER; VAR itemType: INTEGER; VAR item: Handle; VAR box: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98D;
	{$ENDC}
PROCEDURE SetDItem(theDialog: DialogRef; itemNo: INTEGER; itemType: INTEGER; item: Handle; {CONST}VAR box: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98E;
	{$ENDC}
PROCEDURE HideDItem(theDialog: DialogRef; itemNo: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A827;
	{$ENDC}
PROCEDURE ShowDItem(theDialog: DialogRef; itemNo: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A828;
	{$ENDC}
PROCEDURE SelIText(theDialog: DialogRef; itemNo: INTEGER; strtSel: INTEGER; endSel: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A97E;
	{$ENDC}
PROCEDURE GetIText(item: Handle; VAR text: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A990;
	{$ENDC}
PROCEDURE SetIText(item: Handle; text: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A98F;
	{$ENDC}
FUNCTION FindDItem(theDialog: DialogRef; thePt: Point): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A984;
	{$ENDC}
FUNCTION NewCDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; procID: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT; items: Handle): DialogRef;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4B;
	{$ENDC}
PROCEDURE DlgCut(theDialog: DialogRef);
PROCEDURE DlgPaste(theDialog: DialogRef);
PROCEDURE DlgCopy(theDialog: DialogRef);
PROCEDURE DlgDelete(theDialog: DialogRef);
PROCEDURE SetDAFont(fontNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $31DF, $0AFA;
	{$ENDC}
{$ELSEC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DialogsIncludes}

{$ENDC} {__DIALOGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
