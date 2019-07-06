{
 	File:		Dialogs.p
 
 	Contains:	Dialog Manager interfaces.
 
 	Version:	Technology:	Mac OS 8.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

																{  standard icon resource id's 	 }
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

{	Dialog Item List Manipulation Constants	}

TYPE
	DITLMethod							= SInt16;

CONST
	overlayDITL					= 0;
	appendDITLRight				= 1;
	appendDITLBottom			= 2;


TYPE
	StageList							= SInt16;
{  DialogRef is obsolete. Use DialogPtr instead. }
	DialogRef							= DialogPtr;
	DialogRecordPtr = ^DialogRecord;
	DialogRecord = RECORD
		window:					WindowRecord;
		items:					Handle;
		textH:					TEHandle;
		editField:				SInt16;
		editOpen:				SInt16;
		aDefItem:				SInt16;
	END;

	DialogPeek							= ^DialogRecord;
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
	ModalFilterProcPtr = FUNCTION(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: DialogItemIndex): BOOLEAN;
{$ELSEC}
	ModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	UserItemProcPtr = PROCEDURE(theWindow: WindowPtr; itemNo: DialogItemIndex);
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

FUNCTION NewSoundProc(userRoutine: SoundProcPtr): SoundUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewModalFilterProc(userRoutine: ModalFilterProcPtr): ModalFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserItemProc(userRoutine: UserItemProcPtr): UserItemUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSoundProc(soundNumber: SInt16; userRoutine: SoundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallModalFilterProc(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: DialogItemIndex; userRoutine: ModalFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallUserItemProc(theWindow: WindowPtr; itemNo: DialogItemIndex; userRoutine: UserItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	QTModelessCallbackProcPtr = PROCEDURE(VAR theEvent: EventRecord; theDialog: DialogPtr; itemHit: DialogItemIndex); C;
{$ELSEC}
	QTModelessCallbackProcPtr = ProcPtr;
{$ENDC}

PROCEDURE SetModelessDialogCallbackProc(theDialog: DialogPtr; callbackProc: QTModelessCallbackProcPtr);
FUNCTION GetDialogControlNotificationProc(theProc: UNIV Ptr): OSErr;
PROCEDURE SetDialogMovableModal(theDialog: DialogPtr);
FUNCTION GetDialogParent(theDialog: DialogPtr): Ptr;
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


TYPE
	AlertStdAlertParamRecPtr = ^AlertStdAlertParamRec;
	AlertStdAlertParamRec = RECORD
		movable:				BOOLEAN;								{  Make alert movable modal  }
		helpButton:				BOOLEAN;								{  Is there a help button?  }
		filterProc:				ModalFilterUPP;							{  Event filter  }
		defaultText:			StringPtr;								{  Text for button in OK position  }
		cancelText:				StringPtr;								{  Text for button in cancel position  }
		otherText:				StringPtr;								{  Text for button in left position  }
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
PROCEDURE InitDialogs(ignored: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97B;
	{$ENDC}
PROCEDURE ErrorSound(soundProc: SoundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98C;
	{$ENDC}
FUNCTION NewDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97D;
	{$ENDC}
FUNCTION GetNewDialog(dialogID: SInt16; dStorage: UNIV Ptr; behind: WindowPtr): DialogPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97C;
	{$ENDC}
FUNCTION NewColorDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4B;
	{$ENDC}
PROCEDURE CloseDialog(theDialog: DialogPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A982;
	{$ENDC}
PROCEDURE DisposeDialog(theDialog: DialogPtr);
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
FUNCTION DialogSelect({CONST}VAR theEvent: EventRecord; VAR theDialog: DialogPtr; VAR itemHit: DialogItemIndex): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A980;
	{$ENDC}
PROCEDURE DrawDialog(theDialog: DialogPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A981;
	{$ENDC}
PROCEDURE UpdateDialog(theDialog: DialogPtr; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A978;
	{$ENDC}
PROCEDURE HideDialogItem(theDialog: DialogPtr; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A827;
	{$ENDC}
PROCEDURE ShowDialogItem(theDialog: DialogPtr; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A828;
	{$ENDC}
FUNCTION FindDialogItem(theDialog: DialogPtr; thePt: Point): DialogItemIndexZeroBased;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A984;
	{$ENDC}
PROCEDURE DialogCut(theDialog: DialogPtr);
PROCEDURE DialogPaste(theDialog: DialogPtr);
PROCEDURE DialogCopy(theDialog: DialogPtr);
PROCEDURE DialogDelete(theDialog: DialogPtr);
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
PROCEDURE GetDialogItem(theDialog: DialogPtr; itemNo: DialogItemIndex; VAR itemType: DialogItemType; VAR item: Handle; VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98D;
	{$ENDC}
PROCEDURE SetDialogItem(theDialog: DialogPtr; itemNo: DialogItemIndex; itemType: DialogItemType; item: Handle; {CONST}VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98E;
	{$ENDC}
PROCEDURE ParamText(param0: Str255; param1: Str255; param2: Str255; param3: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98B;
	{$ENDC}
PROCEDURE SelectDialogItemText(theDialog: DialogPtr; itemNo: DialogItemIndex; strtSel: SInt16; endSel: SInt16);
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
PROCEDURE SetDialogFont(value: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0AFA;
	{$ENDC}
PROCEDURE ResetAlertStage;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $4278, $0A9A;
	{$ENDC}

PROCEDURE AppendDITL(theDialog: DialogPtr; theHandle: Handle; method: DITLMethod);
FUNCTION CountDITL(theDialog: DialogPtr): DialogItemIndex;
PROCEDURE ShortenDITL(theDialog: DialogPtr; numberItems: DialogItemIndex);
FUNCTION StdFilterProc(theDialog: DialogPtr; VAR event: EventRecord; VAR itemHit: DialogItemIndex): BOOLEAN;
FUNCTION GetStdFilterProc(VAR theProc: ModalFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0203, $AA68;
	{$ENDC}
FUNCTION SetDialogDefaultItem(theDialog: DialogPtr; newItem: DialogItemIndex): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0304, $AA68;
	{$ENDC}
FUNCTION SetDialogCancelItem(theDialog: DialogPtr; newItem: DialogItemIndex): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0305, $AA68;
	{$ENDC}
FUNCTION SetDialogTracksCursor(theDialog: DialogPtr; tracks: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0306, $AA68;
	{$ENDC}


{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
  	• Appearance Dialog Routines (available only with Appearance 1.0 and later)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

FUNCTION NewFeaturesDialog(inStorage: UNIV Ptr; {CONST}VAR inBoundsRect: Rect; inTitle: Str255; inIsVisible: BOOLEAN; inProcID: SInt16; inBehind: WindowPtr; inGoAwayFlag: BOOLEAN; inRefCon: SInt32; inItemListHandle: Handle; inFlags: UInt32): DialogPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $110C, $AA68;
	{$ENDC}
FUNCTION AutoSizeDialog(inDialog: DialogPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AA68;
	{$ENDC}
FUNCTION StandardAlert(inAlertType: AlertType; inError: StringPtr; inExplanation: StringPtr; inAlertParam: AlertStdAlertParamPtr; VAR outItemHit: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $090E, $AA68;
	{$ENDC}
FUNCTION GetDialogItemAsControl(inDialog: DialogPtr; inItemNo: SInt16; VAR outControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050F, $AA68;
	{$ENDC}
FUNCTION MoveDialogItem(inDialog: DialogPtr; inItemNo: SInt16; inHoriz: SInt16; inVert: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $AA68;
	{$ENDC}
FUNCTION SizeDialogItem(inDialog: DialogPtr; inItemNo: SInt16; inWidth: SInt16; inHeight: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $AA68;
	{$ENDC}
{$IFC OLDROUTINENAMES }
PROCEDURE DisposDialog(theDialog: DialogPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A983;
	{$ENDC}
PROCEDURE UpdtDialog(theDialog: DialogPtr; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A978;
	{$ENDC}
PROCEDURE GetDItem(theDialog: DialogPtr; itemNo: DialogItemIndex; VAR itemType: DialogItemType; VAR item: Handle; VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98D;
	{$ENDC}
PROCEDURE SetDItem(theDialog: DialogPtr; itemNo: DialogItemIndex; itemType: DialogItemType; item: Handle; {CONST}VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98E;
	{$ENDC}
PROCEDURE HideDItem(theDialog: DialogPtr; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A827;
	{$ENDC}
PROCEDURE ShowDItem(theDialog: DialogPtr; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A828;
	{$ENDC}
PROCEDURE SelIText(theDialog: DialogPtr; itemNo: DialogItemIndex; strtSel: SInt16; endSel: SInt16);
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
FUNCTION FindDItem(theDialog: DialogPtr; thePt: Point): DialogItemIndexZeroBased;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A984;
	{$ENDC}
FUNCTION NewCDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4B;
	{$ENDC}
PROCEDURE DlgCut(theDialog: DialogPtr);
PROCEDURE DlgPaste(theDialog: DialogPtr);
PROCEDURE DlgCopy(theDialog: DialogPtr);
PROCEDURE DlgDelete(theDialog: DialogPtr);
PROCEDURE SetDAFont(fontNum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0AFA;
	{$ENDC}



{$ENDC}  {OLDROUTINENAMES}

{
	*****************************************************************************
	*                                                                           *
	* The conditional STRICT_DIALOGS has been removed from this interface file. *
	* The accessor macros to a DialogRecord are no longer necessary.            *
	*                                                                           *
	* All ≈Ref Types have reverted to their original Handle and Ptr Types.      *
	*                                                                           *
	*****************************************************************************

	Details:
	The original purpose of the STRICT_ conditionals and accessor macros was to
	help ease the transition to Copland.  Shared data structures are difficult
	to coordinate in a preemptive multitasking OS.  By hiding the fields in a
	WindowRecord and other data structures, we would begin the migration to the
	discipline wherein system data structures are completely hidden from
	applications.
	
	After many design reviews, we finally concluded that with this sort of
	migration, the system could never tell when an application was no longer
	peeking at a WindowRecord, and thus the data structure might never become
	system owned.  Additionally, there were many other limitations in the
	classic toolbox that were begging to be addressed.  The final decision was
	to leave the traditional toolbox as a compatibility mode.
	
	We also decided to use the Handle and Ptr based types in the function
	declarations.  For example, NewWindow now returns a WindowPtr rather than a
	WindowRef.  The Ref types are still defined in the header files, so all
	existing code will still compile exactly as it did before.  There are
	several reasons why we chose to do this:
	
	- The importance of backwards compatibility makes it unfeasible for us to
	enforce real opaque references in the implementation anytime in the
	foreseeable future.  Therefore, any opaque data types (e.g. WindowRef,
	ControlRef, etc.) in the documentation and header files would always be a
	fake veneer of opacity.
	
	- There exists a significant base of books and sample code that neophyte
	Macintosh developers use to learn how to program the Macintosh.  These
	books and sample code all use direct data access.  Introducing opaque data
	types at this point would confuse neophyte programmers more than it would
	help them.
	
	- Direct data structure access is used by nearly all Macintosh developers. 
	Changing the interfaces to reflect a false opacity would not provide any
	benefit to these developers.
	
	- Accessor functions are useful in and of themselves as convenience
	functions, without being tied to opaque data types.  We will complete and
	document the Windows and Dialogs accessor functions in an upcoming release
	of the interfaces.
}



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




{$IFC NOT TARGET_OS_MAC }
{$ENDC}





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DialogsIncludes}

{$ENDC} {__DIALOGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
