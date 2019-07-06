{
     File:       Dialogs.p
 
     Contains:   Dialog Manager interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  new, more standard names for dialog item types }
	kControlDialogItem			= 4;
	kButtonDialogItem			= 4;
	kCheckBoxDialogItem			= 5;
	kRadioButtonDialogItem		= 6;
	kResourceControlDialogItem	= 7;
	kStaticTextDialogItem		= 8;
	kEditTextDialogItem			= 16;
	kIconDialogItem				= 32;
	kPictureDialogItem			= 64;
	kUserDialogItem				= 0;
	kHelpDialogItem				= 1;
	kItemDisableBit				= 128;

																{  old names for dialog item types }
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

																{  standard dialog item numbers }
	kStdOkItemIndex				= 1;
	kStdCancelItemIndex			= 2;							{  old names }
	ok							= 1;
	cancel						= 2;

																{  standard icon resource id's     }
	kStopIcon					= 0;
	kNoteIcon					= 1;
	kCautionIcon				= 2;							{  old names }
	stopIcon					= 0;
	noteIcon					= 1;
	cautionIcon					= 2;




{$IFC OLDROUTINENAMES }
{
   These constants lived briefly on ETO 16.  They suggest
   that there is only one index you can use for the OK 
   item, which is not true.  You can put the ok item 
   anywhere you want in the DITL.
}
	kOkItemIndex				= 1;
	kCancelItemIndex			= 2;

{$ENDC}  {OLDROUTINENAMES}

{  Dialog Item List Manipulation Constants }

TYPE
	DITLMethod							= SInt16;

CONST
	overlayDITL					= 0;
	appendDITLRight				= 1;
	appendDITLBottom			= 2;


TYPE
	StageList							= SInt16;
{  DialogPtr is obsolete. Use DialogRef instead. }
	DialogRef							= DialogPtr;
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	DialogRecordPtr = ^DialogRecord;
	DialogRecord = RECORD
		window:					WindowRecord;							{  in Carbon use GetDialogWindow or GetDialogPort }
		items:					Handle;									{  in Carbon use Get/SetDialogItem }
		textH:					TEHandle;								{  in Carbon use GetDialogTextEditHandle }
		editField:				SInt16;									{  in Carbon use SelectDialogItemText }
		editOpen:				SInt16;									{  not available in Carbon  }
		aDefItem:				SInt16;									{  in Carbon use Get/SetDialogDefaultItem }
	END;

	DialogPeek							= ^DialogRecord;
{$ENDC}

	DialogTemplatePtr = ^DialogTemplate;
	DialogTemplate = RECORD
		boundsRect:				Rect;
		procID:					SInt16;
		visible:				BOOLEAN;
		filler1:				BOOLEAN;
		goAwayFlag:				BOOLEAN;
		filler2:				BOOLEAN;
		refCon:					SInt32;
		itemsID:				SInt16;
		title:					Str255;
	END;

	DialogTPtr							= ^DialogTemplate;
	DialogTHndl							= ^DialogTPtr;
	AlertTemplatePtr = ^AlertTemplate;
	AlertTemplate = RECORD
		boundsRect:				Rect;
		itemsID:				SInt16;
		stages:					StageList;
	END;

	AlertTPtr							= ^AlertTemplate;
	AlertTHndl							= ^AlertTPtr;
{ new type abstractions for the dialog manager }
	DialogItemIndexZeroBased			= SInt16;
	DialogItemIndex						= SInt16;
	DialogItemType						= SInt16;
{ dialog manager callbacks }
{$IFC TYPED_FUNCTION_POINTERS}
	SoundProcPtr = PROCEDURE(soundNumber: SInt16);
{$ELSEC}
	SoundProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ModalFilterProcPtr = FUNCTION(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: DialogItemIndex): BOOLEAN;
{$ELSEC}
	ModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	UserItemProcPtr = PROCEDURE(theDialog: DialogRef; itemNo: DialogItemIndex);
{$ELSEC}
	UserItemProcPtr = ProcPtr;
{$ENDC}

	SoundUPP = UniversalProcPtr;
	ModalFilterUPP = UniversalProcPtr;
	UserItemUPP = UniversalProcPtr;

CONST
	uppSoundProcInfo = $00000080;
	uppModalFilterProcInfo = $00000FD0;
	uppUserItemProcInfo = $000002C0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewSoundUPP(userRoutine: SoundProcPtr): SoundUPP; { old name was NewSoundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


FUNCTION NewModalFilterUPP(userRoutine: ModalFilterProcPtr): ModalFilterUPP; { old name was NewModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserItemUPP(userRoutine: UserItemProcPtr): UserItemUPP; { old name was NewUserItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

PROCEDURE DisposeSoundUPP(userUPP: SoundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


PROCEDURE DisposeModalFilterUPP(userUPP: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeUserItemUPP(userUPP: UserItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

PROCEDURE InvokeSoundUPP(soundNumber: SInt16; userRoutine: SoundUPP); { old name was CallSoundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


FUNCTION InvokeModalFilterUPP(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: DialogItemIndex; userRoutine: ModalFilterUPP): BOOLEAN; { old name was CallModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeUserItemUPP(theDialog: DialogRef; itemNo: DialogItemIndex; userRoutine: UserItemUPP); { old name was CallUserItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	QTModelessCallbackProcPtr = PROCEDURE(VAR theEvent: EventRecord; theDialog: DialogRef; itemHit: DialogItemIndex); C;
{$ELSEC}
	QTModelessCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetModelessDialogCallbackProc(theDialog: DialogRef; callbackProc: QTModelessCallbackProcPtr);
{$ENDC}  {CALL_NOT_IN_CARBON}

TYPE
	QTModelessCallbackUPP				= QTModelessCallbackProcPtr;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetDialogControlNotificationProc(theProc: UNIV Ptr): OSErr;
PROCEDURE SetDialogMovableModal(theDialog: DialogRef);
FUNCTION GetDialogParent(theDialog: DialogRef): Ptr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Following types are valid with Appearance 1.0 and later
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

CONST
																{  Alert types to pass into StandardAlert  }
	kAlertStopAlert				= 0;
	kAlertNoteAlert				= 1;
	kAlertCautionAlert			= 2;
	kAlertPlainAlert			= 3;


TYPE
	AlertType							= SInt16;

CONST
	kAlertDefaultOKText			= -1;							{  "OK" }
	kAlertDefaultCancelText		= -1;							{  "Cancel" }
	kAlertDefaultOtherText		= -1;							{  "Don't Save" }

{ StandardAlert alert button numbers }
	kAlertStdAlertOKButton		= 1;
	kAlertStdAlertCancelButton	= 2;
	kAlertStdAlertOtherButton	= 3;
	kAlertStdAlertHelpButton	= 4;

																{  Dialog Flags for use in NewFeaturesDialog or dlgx resource  }
	kDialogFlagsUseThemeBackground = $01;
	kDialogFlagsUseControlHierarchy = $02;
	kDialogFlagsHandleMovableModal = $04;
	kDialogFlagsUseThemeControls = $08;

																{  Alert Flags for use in alrx resource  }
	kAlertFlagsUseThemeBackground = $01;
	kAlertFlagsUseControlHierarchy = $02;
	kAlertFlagsAlertIsMovable	= $04;
	kAlertFlagsUseThemeControls	= $08;

{ For dftb resource }
	kDialogFontNoFontStyle		= 0;
	kDialogFontUseFontMask		= $0001;
	kDialogFontUseFaceMask		= $0002;
	kDialogFontUseSizeMask		= $0004;
	kDialogFontUseForeColorMask	= $0008;
	kDialogFontUseBackColorMask	= $0010;
	kDialogFontUseModeMask		= $0020;
	kDialogFontUseJustMask		= $0040;
	kDialogFontUseAllMask		= $00FF;
	kDialogFontAddFontSizeMask	= $0100;
	kDialogFontUseFontNameMask	= $0200;
	kDialogFontAddToMetaFontMask = $0400;


TYPE
	AlertStdAlertParamRecPtr = ^AlertStdAlertParamRec;
	AlertStdAlertParamRec = RECORD
		movable:				BOOLEAN;								{  Make alert movable modal  }
		helpButton:				BOOLEAN;								{  Is there a help button?  }
		filterProc:				ModalFilterUPP;							{  Event filter  }
		defaultText:			ConstStringPtr;							{  Text for button in OK position  }
		cancelText:				ConstStringPtr;							{  Text for button in cancel position  }
		otherText:				ConstStringPtr;							{  Text for button in left position  }
		defaultButton:			SInt16;									{  Which button behaves as the default  }
		cancelButton:			SInt16;									{  Which one behaves as cancel (can be 0)  }
		position:				UInt16;									{  Position (kWindowDefaultPosition in this case  }
																		{  equals kWindowAlertPositionParentWindowScreen)  }
	END;

	AlertStdAlertParamPtr				= ^AlertStdAlertParamRec;
{  ——— end Appearance 1.0 or later stuff }


{
    NOTE: Code running under MultiFinder or System 7.0 or newer
    should always pass NULL to InitDialogs.
}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE InitDialogs(ignored: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97B;
	{$ENDC}
PROCEDURE ErrorSound(soundProc: SoundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98C;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97D;
	{$ENDC}
FUNCTION GetNewDialog(dialogID: SInt16; dStorage: UNIV Ptr; behind: WindowRef): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97C;
	{$ENDC}
FUNCTION NewColorDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4B;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE CloseDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A982;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE DisposeDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A983;
	{$ENDC}
PROCEDURE ModalDialog(modalFilter: ModalFilterUPP; VAR itemHit: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A991;
	{$ENDC}
FUNCTION IsDialogEvent({CONST}VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97F;
	{$ENDC}
FUNCTION DialogSelect({CONST}VAR theEvent: EventRecord; VAR theDialog: DialogRef; VAR itemHit: DialogItemIndex): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A980;
	{$ENDC}
PROCEDURE DrawDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A981;
	{$ENDC}
PROCEDURE UpdateDialog(theDialog: DialogRef; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A978;
	{$ENDC}
PROCEDURE HideDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A827;
	{$ENDC}
PROCEDURE ShowDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A828;
	{$ENDC}
FUNCTION FindDialogItem(theDialog: DialogRef; thePt: Point): DialogItemIndexZeroBased;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A984;
	{$ENDC}
PROCEDURE DialogCut(theDialog: DialogRef);
PROCEDURE DialogPaste(theDialog: DialogRef);
PROCEDURE DialogCopy(theDialog: DialogRef);
PROCEDURE DialogDelete(theDialog: DialogRef);
FUNCTION Alert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A985;
	{$ENDC}
FUNCTION StopAlert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A986;
	{$ENDC}
FUNCTION NoteAlert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A987;
	{$ENDC}
FUNCTION CautionAlert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A988;
	{$ENDC}
PROCEDURE GetDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex; VAR itemType: DialogItemType; VAR item: Handle; VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98D;
	{$ENDC}
PROCEDURE SetDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex; itemType: DialogItemType; item: Handle; {CONST}VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98E;
	{$ENDC}
PROCEDURE ParamText(param0: Str255; param1: Str255; param2: Str255; param3: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98B;
	{$ENDC}
PROCEDURE SelectDialogItemText(theDialog: DialogRef; itemNo: DialogItemIndex; strtSel: SInt16; endSel: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97E;
	{$ENDC}
PROCEDURE GetDialogItemText(item: Handle; VAR text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A990;
	{$ENDC}
PROCEDURE SetDialogItemText(item: Handle; text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98F;
	{$ENDC}
FUNCTION GetAlertStage: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0A9A;
	{$ENDC}
PROCEDURE SetDialogFont(fontNum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0AFA;
	{$ENDC}
PROCEDURE ResetAlertStage;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $4278, $0A9A;
	{$ENDC}
{  APIs in Carbon }
PROCEDURE GetParamText(param0: StringPtr; param1: StringPtr; param2: StringPtr; param3: StringPtr);

PROCEDURE AppendDITL(theDialog: DialogRef; theHandle: Handle; method: DITLMethod);
FUNCTION CountDITL(theDialog: DialogRef): DialogItemIndex;
PROCEDURE ShortenDITL(theDialog: DialogRef; numberItems: DialogItemIndex);
FUNCTION InsertDialogItem(theDialog: DialogRef; afterItem: DialogItemIndex; itemType: DialogItemType; itemHandle: Handle; {CONST}VAR box: Rect): OSStatus;
FUNCTION RemoveDialogItems(theDialog: DialogRef; itemNo: DialogItemIndex; amountToRemove: DialogItemIndex; disposeItemData: BOOLEAN): OSStatus;
FUNCTION StdFilterProc(theDialog: DialogRef; VAR event: EventRecord; VAR itemHit: DialogItemIndex): BOOLEAN;
FUNCTION GetStdFilterProc(VAR theProc: ModalFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0203, $AA68;
	{$ENDC}
FUNCTION SetDialogDefaultItem(theDialog: DialogRef; newItem: DialogItemIndex): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0304, $AA68;
	{$ENDC}
FUNCTION SetDialogCancelItem(theDialog: DialogRef; newItem: DialogItemIndex): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0305, $AA68;
	{$ENDC}
FUNCTION SetDialogTracksCursor(theDialog: DialogRef; tracks: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0306, $AA68;
	{$ENDC}


{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Appearance Dialog Routines (available only with Appearance 1.0 and later)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

FUNCTION NewFeaturesDialog(inStorage: UNIV Ptr; {CONST}VAR inBoundsRect: Rect; inTitle: Str255; inIsVisible: BOOLEAN; inProcID: SInt16; inBehind: WindowRef; inGoAwayFlag: BOOLEAN; inRefCon: SInt32; inItemListHandle: Handle; inFlags: UInt32): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $110C, $AA68;
	{$ENDC}
FUNCTION AutoSizeDialog(inDialog: DialogRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AA68;
	{$ENDC}
{
    Regarding StandardAlert and constness:
    Even though the inAlertParam parameter is marked const here, there was
    a chance Dialog Manager would modify it on versions of Mac OS prior to 9.
}
FUNCTION StandardAlert(inAlertType: AlertType; inError: Str255; inExplanation: Str255; {CONST}VAR inAlertParam: AlertStdAlertParamRec; VAR outItemHit: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $090E, $AA68;
	{$ENDC}
FUNCTION GetDialogItemAsControl(inDialog: DialogRef; inItemNo: SInt16; VAR outControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050F, $AA68;
	{$ENDC}
FUNCTION MoveDialogItem(inDialog: DialogRef; inItemNo: SInt16; inHoriz: SInt16; inVert: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $AA68;
	{$ENDC}
FUNCTION SizeDialogItem(inDialog: DialogRef; inItemNo: SInt16; inWidth: SInt16; inHeight: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $AA68;
	{$ENDC}
FUNCTION AppendDialogItemList(dialog: DialogRef; ditlID: SInt16; method: DITLMethod): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $AA68;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Dialog Routines available only with Appearance 1.1 and later
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

FUNCTION SetDialogTimeout(inDialog: DialogRef; inButtonToPress: SInt16; inSecondsToWait: UInt32): OSStatus;
FUNCTION GetDialogTimeout(inDialog: DialogRef; VAR outButtonToPress: SInt16; VAR outSecondsToWait: UInt32; VAR outSecondsRemaining: UInt32): OSStatus;
FUNCTION SetModalDialogEventMask(inDialog: DialogRef; inMask: EventMask): OSStatus;
FUNCTION GetModalDialogEventMask(inDialog: DialogRef; VAR outMask: EventMask): OSStatus;
{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE DisposDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A983;
	{$ENDC}
PROCEDURE UpdtDialog(theDialog: DialogRef; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A978;
	{$ENDC}
PROCEDURE GetDItem(theDialog: DialogRef; itemNo: DialogItemIndex; VAR itemType: DialogItemType; VAR item: Handle; VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98D;
	{$ENDC}
PROCEDURE SetDItem(theDialog: DialogRef; itemNo: DialogItemIndex; itemType: DialogItemType; item: Handle; {CONST}VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98E;
	{$ENDC}
PROCEDURE HideDItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A827;
	{$ENDC}
PROCEDURE ShowDItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A828;
	{$ENDC}
PROCEDURE SelIText(theDialog: DialogRef; itemNo: DialogItemIndex; strtSel: SInt16; endSel: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97E;
	{$ENDC}
PROCEDURE GetIText(item: Handle; VAR text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A990;
	{$ENDC}
PROCEDURE SetIText(item: Handle; text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98F;
	{$ENDC}
FUNCTION FindDItem(theDialog: DialogRef; thePt: Point): DialogItemIndexZeroBased;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A984;
	{$ENDC}
FUNCTION NewCDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4B;
	{$ENDC}
PROCEDURE DlgCut(theDialog: DialogRef);
PROCEDURE DlgPaste(theDialog: DialogRef);
PROCEDURE DlgCopy(theDialog: DialogRef);
PROCEDURE DlgDelete(theDialog: DialogRef);
PROCEDURE SetDAFont(fontNum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0AFA;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ENDC}  {OLDROUTINENAMES}

{
    We are back to using *Ref's for Mac OS X transition. Note that for the time
    being these are equivalent to the old *Ptr's.
}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS AND NOT ACCESSOR_CALLS_ARE_FUNCTIONS }
{$ENDC}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ Getters }
FUNCTION GetDialogWindow(dialog: DialogRef): WindowRef;
FUNCTION GetDialogTextEditHandle(dialog: DialogRef): TEHandle;
FUNCTION GetDialogDefaultItem(dialog: DialogRef): SInt16;
FUNCTION GetDialogCancelItem(dialog: DialogRef): SInt16;
FUNCTION GetDialogKeyboardFocusItem(dialog: DialogRef): SInt16;
{ Setters }
{ Utilities }
PROCEDURE SetPortDialogPort(dialog: DialogRef);
FUNCTION GetDialogPort(dialog: DialogRef): CGrafPtr;
{ To prevent upward dependencies, GetDialogFromWindow() is defined here instead of MacWindows.i }
FUNCTION GetDialogFromWindow(window: WindowRef): DialogRef;
{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE CouldDialog(dialogID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A979;
	{$ENDC}
PROCEDURE FreeDialog(dialogID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97A;
	{$ENDC}
PROCEDURE CouldAlert(alertID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A989;
	{$ENDC}
PROCEDURE FreeAlert(alertID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}




{$IFC NOT TARGET_OS_MAC }
{$ENDC}





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DialogsIncludes}

{$ENDC} {__DIALOGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
