{
 	File:		Navigation.p
 
 	Contains:	Navigation Services Interfaces
 
 	Version:	Technology:	1.1
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1996-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Navigation;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NAVIGATION__}
{$SETC __NAVIGATION__ := 1}

{$I+}
{$SETC NavigationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __TRANSLATION__}
{$I Translation.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kNavMissingKindStringErr	= -5699;
	kNavInvalidCustomControlMessageErr = -5698;
	kNavCustomControlMessageFailedErr = -5697;
	kNavInvalidSystemConfigErr	= -5696;


	kNavDialogOptionsVersion	= 0;
	kNavReplyRecordVersion		= 0;
	kNavCBRecVersion			= 0;
	kNavFileOrFolderVersion		= 0;
	kNavMenuItemSpecVersion		= 0;


TYPE
	NavDataVersion						= UInt16;

CONST
																{  input action codes for NavAskSaveChanges()  }
	kNavSaveChangesClosingDocument = 1;
	kNavSaveChangesQuittingApplication = 2;
	kNavSaveChangesOther		= 0;


TYPE
	NavAskSaveChangesAction				= UInt32;

CONST
																{  result codes for NavAskSaveChanges()  }
	kNavAskSaveChangesSave		= 1;
	kNavAskSaveChangesCancel	= 2;
	kNavAskSaveChangesDontSave	= 3;


TYPE
	NavAskSaveChangesResult				= UInt32;

CONST
																{  result codes for NavAskDiscardChanges()  }
	kNavAskDiscardChanges		= 1;
	kNavAskDiscardChangesCancel	= 2;


TYPE
	NavAskDiscardChangesResult			= UInt32;

CONST
																{  which elements are being filtered for objects:  }
	kNavFilteringBrowserList	= 0;
	kNavFilteringFavorites		= 1;
	kNavFilteringRecents		= 2;
	kNavFilteringShortCutVolumes = 3;
	kNavFilteringLocationPopup	= 4;							{  for v1.1 or greater  }


TYPE
	NavFilterModes						= INTEGER;
	NavFileOrFolderInfoPtr = ^NavFileOrFolderInfo;
	NavFileOrFolderInfo = RECORD
		version:				UInt16;
		isFolder:				BOOLEAN;
		visible:				BOOLEAN;
		creationDate:			UInt32;
		modificationDate:		UInt32;
		CASE INTEGER OF
		0: (
			locked:				BOOLEAN;								{  file is locked  }
			resourceOpen:		BOOLEAN;								{  resource fork is opened  }
			dataOpen:			BOOLEAN;								{  data fork is opened  }
			reserved1:			BOOLEAN;
			dataSize:			UInt32;									{  size of the data fork  }
			resourceSize:		UInt32;									{  size of the resource fork  }
			finderInfo:			FInfo;									{  more file info:  }
			finderXInfo:		FXInfo;
		   );
		1: (
			shareable:			BOOLEAN;
			sharePoint:			BOOLEAN;
			mounted:			BOOLEAN;
			readable:			BOOLEAN;
			writeable:			BOOLEAN;
			reserved2:			BOOLEAN;
			numberOfFiles:		UInt32;
			finderDInfo:		DInfo;
			finderDXInfo:		DXInfo;
			reserved3:			PACKED ARRAY [0..213] OF CHAR;
		   );
	END;

	NavEventDataInfoPtr = ^NavEventDataInfo;
	NavEventDataInfo = RECORD
		CASE INTEGER OF
		0: (
			event:				EventRecordPtr;							{  for event processing  }
			);
		1: (
			param:				Ptr;									{  points to event specific data  }
			);
	END;

	NavEventDataPtr = ^NavEventData;
	NavEventData = RECORD
		eventDataParms:			NavEventDataInfo;						{  the event data  }
		itemHit:				SInt16;									{  the dialog item number, for v1.1 or greater  }
	END;

	NavContext							= UInt32;
	NavCBRecPtr = ^NavCBRec;
	NavCBRec = RECORD
		version:				UInt16;
		context:				NavContext;								{  used by customization code to call Navigation Services  }
		window:					WindowPtr;								{  the dialog  }
		customRect:				Rect;									{  local coordinate rectangle of customization area  }
		previewRect:			Rect;									{  local coordinate rectangle of the preview area  }
		eventData:				NavEventData;
		reserved:				PACKED ARRAY [0..221] OF CHAR;
	END;


CONST
	kNavCBEvent					= 0;							{  an event has occurred (update, idle events, etc.)  }
	kNavCBCustomize				= 1;							{  protocol for negotiating customization space  }
	kNavCBStart					= 2;							{  the navigation dialog is starting up  }
	kNavCBTerminate				= 3;							{  the navigation dialog is closing down  }
	kNavCBAdjustRect			= 4;							{  the navigation dialog is being resized  }
	kNavCBNewLocation			= 5;							{  user has chosen a new location in the browser  }
	kNavCBShowDesktop			= 6;							{  user has navigated to the desktop  }
	kNavCBSelectEntry			= 7;							{  user has made a selection in the browser  }
	kNavCBPopupMenuSelect		= 8;							{  signifies that a popup menu selection was made  }
	kNavCBAccept				= 9;							{  user has accepted the navigation dialog  }
	kNavCBCancel				= 10;							{  user has cancelled the navigation dialog  }
	kNavCBAdjustPreview			= 11;							{  preview button was clicked or the preview was resized  }


TYPE
	NavEventCallbackMessage				= SInt32;
	NavCallBackUserData					= Ptr;
{ for events and customization: }
{$IFC TYPED_FUNCTION_POINTERS}
	NavEventProcPtr = PROCEDURE(callBackSelector: NavEventCallbackMessage; callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr);
{$ELSEC}
	NavEventProcPtr = ProcPtr;
{$ENDC}

{ for preview support: }
{$IFC TYPED_FUNCTION_POINTERS}
	NavPreviewProcPtr = FUNCTION(callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr): BOOLEAN;
{$ELSEC}
	NavPreviewProcPtr = ProcPtr;
{$ENDC}

{ filtering callback information: }
{$IFC TYPED_FUNCTION_POINTERS}
	NavObjectFilterProcPtr = FUNCTION(VAR theItem: AEDesc; info: UNIV Ptr; callBackUD: UNIV Ptr; filterMode: NavFilterModes): BOOLEAN;
{$ELSEC}
	NavObjectFilterProcPtr = ProcPtr;
{$ENDC}

	NavEventUPP = UniversalProcPtr;
	NavPreviewUPP = UniversalProcPtr;
	NavObjectFilterUPP = UniversalProcPtr;

CONST
	uppNavEventProcInfo = $00000FC0;
	uppNavPreviewProcInfo = $000003D0;
	uppNavObjectFilterProcInfo = $00002FD0;

FUNCTION NewNavEventProc(userRoutine: NavEventProcPtr): NavEventUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNavPreviewProc(userRoutine: NavPreviewProcPtr): NavPreviewUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNavObjectFilterProc(userRoutine: NavObjectFilterProcPtr): NavObjectFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallNavEventProc(callBackSelector: NavEventCallbackMessage; callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr; userRoutine: NavEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNavPreviewProc(callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr; userRoutine: NavPreviewUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNavObjectFilterProc(VAR theItem: AEDesc; info: UNIV Ptr; callBackUD: UNIV Ptr; filterMode: NavFilterModes; userRoutine: NavObjectFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

CONST
	kNavCtlShowDesktop			= 0;							{ 	show desktop, 				parms = nil  }
	kNavCtlSortBy				= 1;							{ 	sort key field, 			parms->NavSortKeyField  }
	kNavCtlSortOrder			= 2;							{ 	sort order,					parms->NavSortOrder  }
	kNavCtlScrollHome			= 3;							{ 	scroll list home,			parms = nil  }
	kNavCtlScrollEnd			= 4;							{ 	scroll list end,			parms = nil  }
	kNavCtlPageUp				= 5;							{ 	page list up,				parms = nil  }
	kNavCtlPageDown				= 6;							{ 	page list down,				parms = nil  }
	kNavCtlGetLocation			= 7;							{ 	get current location,		parms<-AEDesc  }
	kNavCtlSetLocation			= 8;							{ 	set current location,		parms->AEDesc  }
	kNavCtlGetSelection			= 9;							{ 	get current selection,		parms<-AEDescList  }
	kNavCtlSetSelection			= 10;							{ 	set current selection,		parms->AEDescList  }
	kNavCtlShowSelection		= 11;							{ 	make selection visible,		parms = nil  }
	kNavCtlOpenSelection		= 12;							{ 	open view of selection,		parms = nil  }
	kNavCtlEjectVolume			= 13;							{ 	eject volume,				parms->vRefNum  }
	kNavCtlNewFolder			= 14;							{ 	create a new folder,		parms->StringPtr  }
	kNavCtlCancel				= 15;							{ 	cancel dialog,				parms = nil  }
	kNavCtlAccept				= 16;							{ 	accept dialog default,		parms = nil  }
	kNavCtlIsPreviewShowing		= 17;							{ 	query preview status,		parms<-Boolean  }
	kNavCtlAddControl			= 18;							{   add one control to dialog,	parms->ControlHandle  }
	kNavCtlAddControlList		= 19;							{ 	add control list to dialog,	parms->Handle (DITL rsrc)  }
	kNavCtlGetFirstControlID	= 20;							{ 	get 1st control ID,			parms<-UInt16  }
	kNavCtlSelectCustomType		= 21;							{ 	select a custom menu item	parms->NavMenuItemSpec  }
	kNavCtlSelectAllType		= 22;							{   select an "All" menu item	parms->SInt16  }
	kNavCtlGetEditFileName		= 23;							{ 	get save dlog's file name	parms<-StringPtr  }
	kNavCtlSetEditFileName		= 24;							{ 	set save dlog's file name	parms->StringPtr  }
	kNavCtlSelectEditFileName	= 25;							{ 	select save dlog file name	parms->ControlEditTextSelectionRec, for v1.1 or greater  }


TYPE
	NavCustomControlMessage				= SInt32;

CONST
	kNavAllKnownFiles			= 0;
	kNavAllReadableFiles		= 1;
	kNavAllFiles				= 2;


TYPE
	NavPopupMenuItem					= UInt16;

CONST
	kNavSortNameField			= 0;
	kNavSortDateField			= 1;


TYPE
	NavSortKeyField						= UInt16;

CONST
	kNavSortAscending			= 0;
	kNavSortDescending			= 1;


TYPE
	NavSortOrder						= UInt16;

CONST
	kNavDefaultNavDlogOptions	= $000000E4;					{  use defaults for all the options  }
	kNavNoTypePopup				= $00000001;					{  don't show file type/extension popup on Open/Save  }
	kNavDontAutoTranslate		= $00000002;					{  don't automatically translate on Open  }
	kNavDontAddTranslateItems	= $00000004;					{  don't add translation choices on Open/Save  }
	kNavAllFilesInPopup			= $00000010;					{  "All Files" menu item in the type popup on Open  }
	kNavAllowStationery			= $00000020;					{  allow saving of stationery files  }
	kNavAllowPreviews			= $00000040;					{  allow to show previews  }
	kNavAllowMultipleFiles		= $00000080;					{  allow multiple items to be selected  }
	kNavAllowInvisibleFiles		= $00000100;					{  allow invisible items to be shown  }
	kNavDontResolveAliases		= $00000200;					{  don't resolve aliases  }
	kNavSelectDefaultLocation	= $00000400;					{  make the default location the browser selection  }
	kNavSelectAllReadableItem	= $00000800;					{  make the dialog select "All Readable Documents" on Open  }


TYPE
	NavDialogOptionFlags				= UInt32;

CONST
	kNavTranslateInPlace		= 0;							{ 	translate in place, replacing translation source file (default for Save)  }
	kNavTranslateCopy			= 1;							{ 	translate to a copy of the source file (default for Open)  }


TYPE
	NavTranslationOptions				= UInt32;
	NavMenuItemSpecPtr = ^NavMenuItemSpec;
	NavMenuItemSpec = RECORD
		version:				UInt16;
		menuCreator:			OSType;
		menuType:				OSType;
		menuItemName:			Str255;
		reserved:				PACKED ARRAY [0..244] OF CHAR;
	END;

	NavMenuItemSpecArray				= ARRAY [0..0] OF NavMenuItemSpec;
	NavMenuItemSpecArrayPtr				= ^NavMenuItemSpecArray;
	NavMenuItemSpecArrayHandle			= ^NavMenuItemSpecArrayPtr;
	NavMenuItemSpecHandle				= NavMenuItemSpecArrayHandle;
	NavTypeListPtr = ^NavTypeList;
	NavTypeList = RECORD
		componentSignature:		OSType;
		reserved:				INTEGER;
		osTypeCount:			INTEGER;
		osType:					ARRAY [0..0] OF OSType;
	END;

	NavTypeListHandle					= ^NavTypeListPtr;
	NavDialogOptionsPtr = ^NavDialogOptions;
	NavDialogOptions = RECORD
		version:				UInt16;
		dialogOptionFlags:		NavDialogOptionFlags;					{  option flags for affecting the dialog's behavior  }
		location:				Point;									{  top-left location of the dialog, or (-1,-1) for default position  }
		clientName:				Str255;
		windowTitle:			Str255;
		actionButtonLabel:		Str255;									{  label of the default button (or null string for default)  }
		cancelButtonLabel:		Str255;									{  label of the cancel button (or null string for default)  }
		savedFileName:			Str255;									{  default name for text box in NavPutFile (or null string for default)  }
		message:				Str255;									{  custom message prompt (or null string for default)  }
		preferenceKey:			UInt32;									{  a key for to managing preferences for using multiple utility dialogs  }
		popupExtension:			NavMenuItemSpecArrayHandle;				{  extended popup menu items, an array of NavMenuItemSpecs  }
		reserved:				PACKED ARRAY [0..493] OF CHAR;
	END;

{ data returned by the utility dialogs: }
	NavReplyRecordPtr = ^NavReplyRecord;
	NavReplyRecord = RECORD
		version:				UInt16;
		validRecord:			BOOLEAN;								{  open/save: true if the user confirmed a selection, false on cancel  }
		replacing:				BOOLEAN;								{  save: true if the user is overwriting an existing object for save  }
		isStationery:			BOOLEAN;								{  save: true if the user wants to save an object as stationery  }
		translationNeeded:		BOOLEAN;								{  save: translation is 'needed', open: translation 'has taken place'  }
		selection:				AEDescList;								{  open/save: list of AppleEvent descriptors of the chosen object(s)  }
		keyScript:				ScriptCode;								{  open/save: script in which the name of each item in 'selection' is to be displayed  }
		fileTranslation:		FileTranslationSpecArrayHandle;			{  open/save: list of file translation specs of the chosen object(s), if translation is needed  }
		reserved1:				UInt32;
		reserved:				PACKED ARRAY [0..230] OF CHAR;
	END;

FUNCTION NavLoad: OSErr;
FUNCTION NavUnload: OSErr;
FUNCTION NavLibraryVersion: UInt32;
FUNCTION NavGetDefaultDialogOptions(VAR dialogOptions: NavDialogOptions): OSErr;

FUNCTION NavGetFile(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; previewProc: NavPreviewUPP; filterProc: NavObjectFilterUPP; typeList: NavTypeListHandle; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavPutFile(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; fileType: OSType; fileCreator: OSType; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavAskSaveChanges(VAR dialogOptions: NavDialogOptions; action: NavAskSaveChangesAction; VAR reply: NavAskSaveChangesResult; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavCustomAskSaveChanges(VAR dialogOptions: NavDialogOptions; VAR reply: NavAskSaveChangesResult; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavAskDiscardChanges(VAR dialogOptions: NavDialogOptions; VAR reply: NavAskDiscardChangesResult; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavChooseFile(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; previewProc: NavPreviewUPP; filterProc: NavObjectFilterUPP; typeList: NavTypeListHandle; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavChooseFolder(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; filterProc: NavObjectFilterUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavChooseVolume(defaultSelection: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; filterProc: NavObjectFilterUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavChooseObject(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; filterProc: NavObjectFilterUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavNewFolder(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; VAR dialogOptions: NavDialogOptions; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;
FUNCTION NavTranslateFile(VAR reply: NavReplyRecord; howToTranslate: NavTranslationOptions): OSErr;
FUNCTION NavCompleteSave(VAR reply: NavReplyRecord; howToTranslate: NavTranslationOptions): OSErr;
FUNCTION NavCustomControl(context: NavContext; selector: NavCustomControlMessage; parms: UNIV Ptr): OSErr;
FUNCTION NavDisposeReply(VAR reply: NavReplyRecord): OSErr;
FUNCTION NavServicesCanRun: BOOLEAN;

FUNCTION NavServicesAvailable: BOOLEAN;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NavigationIncludes}

{$ENDC} {__NAVIGATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
