{
 	File:		ColorPickerComponents.p
 
 	Contains:	Color Picker Component Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ColorPickerComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLORPICKERCOMPONENTS__}
{$SETC __COLORPICKERCOMPONENTS__ := 1}

{$I+}
{$SETC ColorPickerComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __COLORPICKER__}
{$I ColorPicker.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __BALLOONS__}
{$I Balloons.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kPickerComponentType		= 'cpkr';


	kPickerInit					= 0;
	kPickerTestGraphicsWorld	= 1;
	kPickerGetDialog			= 2;
	kPickerGetItemList			= 3;
	kPickerGetColor				= 4;
	kPickerSetColor				= 5;
	kPickerEvent				= 6;
	kPickerEdit					= 7;
	kPickerSetVisibility		= 8;
	kPickerDisplay				= 9;
	kPickerItemHit				= 10;
	kPickerSetBaseItem			= 11;
	kPickerGetProfile			= 12;
	kPickerSetProfile			= 13;
	kPickerGetPrompt			= 14;
	kPickerSetPrompt			= 15;
	kPickerGetIconData			= 16;
	kPickerGetEditMenuState		= 17;
	kPickerSetOrigin			= 18;
	kPickerExtractHelpItem		= 19;
	kPickerSetColorChangedProc	= 20;
	kNPickerGetColor			= 21;
	kNPickerSetColor			= 22;
	kNPickerGetProfile			= 23;
	kNPickerSetProfile			= 24;
	kNPickerSetColorChangedProc	= 25;

{$IFC OLDROUTINENAMES }
	kInitPicker					= 0;
	kTestGraphicsWorld			= 1;
	kGetDialog					= 2;
	kGetItemList				= 3;
	kGetColor					= 4;
	kSetColor					= 5;
	kEvent						= 6;
	kEdit						= 7;
	kSetVisibility				= 8;
	kDrawPicker					= 9;
	kItemHit					= 10;
	kSetBaseItem				= 11;
	kGetProfile					= 12;
	kSetProfile					= 13;
	kGetPrompt					= 14;
	kSetPrompt					= 15;
	kGetIconData				= 16;
	kGetEditMenuState			= 17;
	kSetOrigin					= 18;
	kExtractHelpItem			= 19;

{$ENDC}  {OLDROUTINENAMES}

{ These structs were moved here from the ColorPicker header.}

	kDidNothing					= 0;
	kColorChanged				= 1;
	kOkHit						= 2;
	kCancelHit					= 3;
	kNewPickerChosen			= 4;
	kApplItemHit				= 5;


TYPE
	PickerAction						= INTEGER;

CONST
	kOriginalColor				= 0;
	kNewColor					= 1;


TYPE
	ColorType							= INTEGER;

CONST
	kCut						= 0;
	kCopy						= 1;
	kPaste						= 2;
	kClear						= 3;
	kUndo						= 4;


TYPE
	EditOperation						= INTEGER;

CONST
	kMouseDown					= 0;
	kKeyDown					= 1;
	kFieldEntered				= 2;
	kFieldLeft					= 3;
	kCutOp						= 4;
	kCopyOp						= 5;
	kPasteOp					= 6;
	kClearOp					= 7;
	kUndoOp						= 8;


TYPE
	ItemModifier						= INTEGER;
{ These are for the flags field in the picker's 'thng' resource. }

CONST
	CanDoColor					= 1;
	CanDoBlackWhite				= 2;
	AlwaysModifiesPalette		= 4;
	MayModifyPalette			= 8;
	PickerIsColorSyncAware		= 16;
	CanDoSystemDialog			= 32;
	CanDoApplDialog				= 64;
	HasOwnDialog				= 128;
	CanDetach					= 256;
	PickerIsColorSync2Aware		= 512;


	kNoForcast					= 0;
	kMenuChoice					= 1;
	kDialogAccept				= 2;
	kDialogCancel				= 3;
	kLeaveFocus					= 4;
	kPickerSwitch				= 5;
	kNormalKeyDown				= 6;
	kNormalMouseDown			= 7;


TYPE
	EventForcaster						= INTEGER;
	PickerIconDataPtr = ^PickerIconData;
	PickerIconData = RECORD
		scriptCode:				INTEGER;
		iconSuiteID:			INTEGER;
		helpResType:			ResType;
		helpResID:				INTEGER;
	END;


	PickerInitDataPtr = ^PickerInitData;
	PickerInitData = RECORD
		pickerDialog:			DialogPtr;
		choicesDialog:			DialogPtr;
		flags:					LONGINT;
		yourself:				Picker;
	END;


	PickerMenuStatePtr = ^PickerMenuState;
	PickerMenuState = RECORD
		cutEnabled:				BOOLEAN;
		copyEnabled:			BOOLEAN;
		pasteEnabled:			BOOLEAN;
		clearEnabled:			BOOLEAN;
		undoEnabled:			BOOLEAN;
		filler:					SInt8;
		undoString:				Str255;
	END;

	SystemDialogInfoPtr = ^SystemDialogInfo;
	SystemDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		placeWhere:				DialogPlacementSpec;
		dialogOrigin:			Point;
		mInfo:					PickerMenuItemInfo;
	END;


	PickerDialogInfoPtr = ^PickerDialogInfo;
	PickerDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		dialogOrigin:			PointPtr;
		mInfo:					PickerMenuItemInfo;
	END;


	ApplicationDialogInfoPtr = ^ApplicationDialogInfo;
	ApplicationDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		theDialog:				DialogPtr;
		pickerOrigin:			Point;
		mInfo:					PickerMenuItemInfo;
	END;


	EventDataPtr = ^EventData;
	EventData = RECORD
		event:					EventRecordPtr;
		action:					PickerAction;
		itemHit:				INTEGER;
		handled:				BOOLEAN;
		filler:					SInt8;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		forcast:				EventForcaster;
	END;


	EditDataPtr = ^EditData;
	EditData = RECORD
		theEdit:				EditOperation;
		action:					PickerAction;
		handled:				BOOLEAN;
		filler:					SInt8;
	END;


	ItemHitDataPtr = ^ItemHitData;
	ItemHitData = RECORD
		itemHit:				INTEGER;
		iMod:					ItemModifier;
		action:					PickerAction;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		where:					Point;
	END;

	HelpItemInfoPtr = ^HelpItemInfo;
	HelpItemInfo = RECORD
		options:				LONGINT;
		tip:					Point;
		altRect:				Rect;
		theProc:				INTEGER;
		helpVariant:			INTEGER;
		helpMessage:			HMMessageRecord;
	END;


	PickerOpenProcPtr = ProcPtr;  { FUNCTION PickerOpen(storage: LONGINT; self: ComponentInstance): ComponentResult; }

	PickerCloseProcPtr = ProcPtr;  { FUNCTION PickerClose(storage: LONGINT; self: ComponentInstance): ComponentResult; }

	PickerCanDoProcPtr = ProcPtr;  { FUNCTION PickerCanDo(storage: LONGINT; selector: INTEGER): ComponentResult; }

	PickerVersionProcPtr = ProcPtr;  { FUNCTION PickerVersion(storage: LONGINT): ComponentResult; }

	PickerRegisterProcPtr = ProcPtr;  { FUNCTION PickerRegister(storage: LONGINT): ComponentResult; }

	PickerSetTargetProcPtr = ProcPtr;  { FUNCTION PickerSetTarget(storage: LONGINT; topOfCallChain: ComponentInstance): ComponentResult; }

	PickerOpenUPP = UniversalProcPtr;
	PickerCloseUPP = UniversalProcPtr;
	PickerCanDoUPP = UniversalProcPtr;
	PickerVersionUPP = UniversalProcPtr;
	PickerRegisterUPP = UniversalProcPtr;
	PickerSetTargetUPP = UniversalProcPtr;
FUNCTION PickerInit(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}

TYPE
	PickerInitProcPtr = ProcPtr;  { FUNCTION PickerInit(storage: LONGINT; VAR data: PickerInitData): ComponentResult; }

FUNCTION PickerTestGraphicsWorld(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

TYPE
	PickerTestGraphicsWorldProcPtr = ProcPtr;  { FUNCTION PickerTestGraphicsWorld(storage: LONGINT; VAR data: PickerInitData): ComponentResult; }

FUNCTION PickerGetDialog(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetDialogProcPtr = ProcPtr;  { FUNCTION PickerGetDialog(storage: LONGINT): ComponentResult; }

FUNCTION PickerGetItemList(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetItemListProcPtr = ProcPtr;  { FUNCTION PickerGetItemList(storage: LONGINT): ComponentResult; }

FUNCTION PickerGetColor(storage: LONGINT; whichColor: ColorType; color: PMColorPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0004, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetColorProcPtr = ProcPtr;  { FUNCTION PickerGetColor(storage: LONGINT; whichColor: ColorType; color: PMColorPtr): ComponentResult; }

FUNCTION PickerSetColor(storage: LONGINT; whichColor: ColorType; color: PMColorPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0005, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetColorProcPtr = ProcPtr;  { FUNCTION PickerSetColor(storage: LONGINT; whichColor: ColorType; color: PMColorPtr): ComponentResult; }

FUNCTION PickerEvent(storage: LONGINT; VAR data: EventData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

TYPE
	PickerEventProcPtr = ProcPtr;  { FUNCTION PickerEvent(storage: LONGINT; VAR data: EventData): ComponentResult; }

FUNCTION PickerEdit(storage: LONGINT; VAR data: EditData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

TYPE
	PickerEditProcPtr = ProcPtr;  { FUNCTION PickerEdit(storage: LONGINT; VAR data: EditData): ComponentResult; }

FUNCTION PickerSetVisibility(storage: LONGINT; visible: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0008, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetVisibilityProcPtr = ProcPtr;  { FUNCTION PickerSetVisibility(storage: LONGINT; visible: BOOLEAN): ComponentResult; }

FUNCTION PickerDisplay(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

TYPE
	PickerDisplayProcPtr = ProcPtr;  { FUNCTION PickerDisplay(storage: LONGINT): ComponentResult; }

FUNCTION PickerItemHit(storage: LONGINT; VAR data: ItemHitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

TYPE
	PickerItemHitProcPtr = ProcPtr;  { FUNCTION PickerItemHit(storage: LONGINT; VAR data: ItemHitData): ComponentResult; }

FUNCTION PickerSetBaseItem(storage: LONGINT; baseItem: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000B, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetBaseItemProcPtr = ProcPtr;  { FUNCTION PickerSetBaseItem(storage: LONGINT; baseItem: INTEGER): ComponentResult; }

FUNCTION PickerGetProfile(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000C, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetProfileProcPtr = ProcPtr;  { FUNCTION PickerGetProfile(storage: LONGINT): ComponentResult; }

FUNCTION PickerSetProfile(storage: LONGINT; profile: CMProfileHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetProfileProcPtr = ProcPtr;  { FUNCTION PickerSetProfile(storage: LONGINT; profile: CMProfileHandle): ComponentResult; }

FUNCTION PickerGetPrompt(storage: LONGINT; VAR prompt: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetPromptProcPtr = ProcPtr;  { FUNCTION PickerGetPrompt(storage: LONGINT; VAR prompt: Str255): ComponentResult; }

FUNCTION PickerSetPrompt(storage: LONGINT; prompt: ConstStr255Param): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetPromptProcPtr = ProcPtr;  { FUNCTION PickerSetPrompt(storage: LONGINT; prompt: ConstStr255Param): ComponentResult; }

FUNCTION PickerGetIconData(storage: LONGINT; VAR data: PickerIconData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetIconDataProcPtr = ProcPtr;  { FUNCTION PickerGetIconData(storage: LONGINT; VAR data: PickerIconData): ComponentResult; }

FUNCTION PickerGetEditMenuState(storage: LONGINT; VAR mState: PickerMenuState): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}

TYPE
	PickerGetEditMenuStateProcPtr = ProcPtr;  { FUNCTION PickerGetEditMenuState(storage: LONGINT; VAR mState: PickerMenuState): ComponentResult; }

FUNCTION PickerSetOrigin(storage: LONGINT; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetOriginProcPtr = ProcPtr;  { FUNCTION PickerSetOrigin(storage: LONGINT; where: Point): ComponentResult; }

{ 	Below are the ColorPicker 2.1 routines. }


FUNCTION PickerSetColorChangedProc(storage: LONGINT; colorProc: ColorChangedUPP; colorProcData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0014, $7000, $A82A;
	{$ENDC}

TYPE
	PickerSetColorChangedProcProcPtr = ProcPtr;  { FUNCTION PickerSetColorChangedProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult; }

{ New Color Picker 2.1 messages.  If you don't wish to support these you should already be... }
{ returning a paramErr in your main entry routine.  They have new selectors}
FUNCTION NPickerGetColor(storage: LONGINT; whichColor: ColorType; VAR color: NPMColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0015, $7000, $A82A;
	{$ENDC}

TYPE
	NPickerGetColorProcPtr = ProcPtr;  { FUNCTION NPickerGetColor(storage: LONGINT; whichColor: ColorType; VAR color: NPMColor): ComponentResult; }

FUNCTION NPickerSetColor(storage: LONGINT; whichColor: ColorType; VAR color: NPMColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0016, $7000, $A82A;
	{$ENDC}

TYPE
	NPickerSetColorProcPtr = ProcPtr;  { FUNCTION NPickerSetColor(storage: LONGINT; whichColor: ColorType; VAR color: NPMColor): ComponentResult; }

FUNCTION NPickerGetProfile(storage: LONGINT; VAR profile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}

TYPE
	NPickerGetProfileProcPtr = ProcPtr;  { FUNCTION NPickerGetProfile(storage: LONGINT; VAR profile: CMProfileRef): ComponentResult; }

FUNCTION NPickerSetProfile(storage: LONGINT; profile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

TYPE
	NPickerSetProfileProcPtr = ProcPtr;  { FUNCTION NPickerSetProfile(storage: LONGINT; profile: CMProfileRef): ComponentResult; }

FUNCTION NPickerSetColorChangedProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0019, $7000, $A82A;
	{$ENDC}

TYPE
	NPickerSetColorChangedProcProcPtr = ProcPtr;  { FUNCTION NPickerSetColorChangedProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult; }

FUNCTION PickerExtractHelpItem(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: HelpItemInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}

TYPE
	PickerExtractHelpItemProcPtr = ProcPtr;  { FUNCTION PickerExtractHelpItem(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: HelpItemInfo): ComponentResult; }

	PickerInitUPP = UniversalProcPtr;
	PickerTestGraphicsWorldUPP = UniversalProcPtr;
	PickerGetDialogUPP = UniversalProcPtr;
	PickerGetItemListUPP = UniversalProcPtr;
	PickerGetColorUPP = UniversalProcPtr;
	PickerSetColorUPP = UniversalProcPtr;
	PickerEventUPP = UniversalProcPtr;
	PickerEditUPP = UniversalProcPtr;
	PickerSetVisibilityUPP = UniversalProcPtr;
	PickerDisplayUPP = UniversalProcPtr;
	PickerItemHitUPP = UniversalProcPtr;
	PickerSetBaseItemUPP = UniversalProcPtr;
	PickerGetProfileUPP = UniversalProcPtr;
	PickerSetProfileUPP = UniversalProcPtr;
	PickerGetPromptUPP = UniversalProcPtr;
	PickerSetPromptUPP = UniversalProcPtr;
	PickerGetIconDataUPP = UniversalProcPtr;
	PickerGetEditMenuStateUPP = UniversalProcPtr;
	PickerSetOriginUPP = UniversalProcPtr;
	PickerSetColorChangedProcUPP = UniversalProcPtr;
	NPickerGetColorUPP = UniversalProcPtr;
	NPickerSetColorUPP = UniversalProcPtr;
	NPickerGetProfileUPP = UniversalProcPtr;
	NPickerSetProfileUPP = UniversalProcPtr;
	NPickerSetColorChangedProcUPP = UniversalProcPtr;
	PickerExtractHelpItemUPP = UniversalProcPtr;

CONST
	uppPickerOpenProcInfo = $000003F0;
	uppPickerCloseProcInfo = $000003F0;
	uppPickerCanDoProcInfo = $000002F0;
	uppPickerVersionProcInfo = $000000F0;
	uppPickerRegisterProcInfo = $000000F0;
	uppPickerSetTargetProcInfo = $000003F0;
	uppPickerInitProcInfo = $000003F0;
	uppPickerTestGraphicsWorldProcInfo = $000003F0;
	uppPickerGetDialogProcInfo = $000000F0;
	uppPickerGetItemListProcInfo = $000000F0;
	uppPickerGetColorProcInfo = $00000EF0;
	uppPickerSetColorProcInfo = $00000EF0;
	uppPickerEventProcInfo = $000003F0;
	uppPickerEditProcInfo = $000003F0;
	uppPickerSetVisibilityProcInfo = $000001F0;
	uppPickerDisplayProcInfo = $000000F0;
	uppPickerItemHitProcInfo = $000003F0;
	uppPickerSetBaseItemProcInfo = $000002F0;
	uppPickerGetProfileProcInfo = $000000F0;
	uppPickerSetProfileProcInfo = $000003F0;
	uppPickerGetPromptProcInfo = $000003F0;
	uppPickerSetPromptProcInfo = $000003F0;
	uppPickerGetIconDataProcInfo = $000003F0;
	uppPickerGetEditMenuStateProcInfo = $000003F0;
	uppPickerSetOriginProcInfo = $000003F0;
	uppPickerSetColorChangedProcProcInfo = $00000FF0;
	uppNPickerGetColorProcInfo = $00000EF0;
	uppNPickerSetColorProcInfo = $00000EF0;
	uppNPickerGetProfileProcInfo = $000003F0;
	uppNPickerSetProfileProcInfo = $000003F0;
	uppNPickerSetColorChangedProcProcInfo = $00000FF0;
	uppPickerExtractHelpItemProcInfo = $00003AF0;

FUNCTION NewPickerOpenProc(userRoutine: PickerOpenProcPtr): PickerOpenUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerCloseProc(userRoutine: PickerCloseProcPtr): PickerCloseUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerCanDoProc(userRoutine: PickerCanDoProcPtr): PickerCanDoUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerVersionProc(userRoutine: PickerVersionProcPtr): PickerVersionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerRegisterProc(userRoutine: PickerRegisterProcPtr): PickerRegisterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetTargetProc(userRoutine: PickerSetTargetProcPtr): PickerSetTargetUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerInitProc(userRoutine: PickerInitProcPtr): PickerInitUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerTestGraphicsWorldProc(userRoutine: PickerTestGraphicsWorldProcPtr): PickerTestGraphicsWorldUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetDialogProc(userRoutine: PickerGetDialogProcPtr): PickerGetDialogUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetItemListProc(userRoutine: PickerGetItemListProcPtr): PickerGetItemListUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetColorProc(userRoutine: PickerGetColorProcPtr): PickerGetColorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetColorProc(userRoutine: PickerSetColorProcPtr): PickerSetColorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerEventProc(userRoutine: PickerEventProcPtr): PickerEventUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerEditProc(userRoutine: PickerEditProcPtr): PickerEditUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetVisibilityProc(userRoutine: PickerSetVisibilityProcPtr): PickerSetVisibilityUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerDisplayProc(userRoutine: PickerDisplayProcPtr): PickerDisplayUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerItemHitProc(userRoutine: PickerItemHitProcPtr): PickerItemHitUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetBaseItemProc(userRoutine: PickerSetBaseItemProcPtr): PickerSetBaseItemUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetProfileProc(userRoutine: PickerGetProfileProcPtr): PickerGetProfileUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetProfileProc(userRoutine: PickerSetProfileProcPtr): PickerSetProfileUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetPromptProc(userRoutine: PickerGetPromptProcPtr): PickerGetPromptUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetPromptProc(userRoutine: PickerSetPromptProcPtr): PickerSetPromptUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetIconDataProc(userRoutine: PickerGetIconDataProcPtr): PickerGetIconDataUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerGetEditMenuStateProc(userRoutine: PickerGetEditMenuStateProcPtr): PickerGetEditMenuStateUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetOriginProc(userRoutine: PickerSetOriginProcPtr): PickerSetOriginUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerSetColorChangedProcProc(userRoutine: PickerSetColorChangedProcProcPtr): PickerSetColorChangedProcUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNPickerGetColorProc(userRoutine: NPickerGetColorProcPtr): NPickerGetColorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNPickerSetColorProc(userRoutine: NPickerSetColorProcPtr): NPickerSetColorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNPickerGetProfileProc(userRoutine: NPickerGetProfileProcPtr): NPickerGetProfileUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNPickerSetProfileProc(userRoutine: NPickerSetProfileProcPtr): NPickerSetProfileUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNPickerSetColorChangedProcProc(userRoutine: NPickerSetColorChangedProcProcPtr): NPickerSetColorChangedProcUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPickerExtractHelpItemProc(userRoutine: PickerExtractHelpItemProcPtr): PickerExtractHelpItemUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallPickerOpenProc(storage: LONGINT; self: ComponentInstance; userRoutine: PickerOpenUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerCloseProc(storage: LONGINT; self: ComponentInstance; userRoutine: PickerCloseUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerCanDoProc(storage: LONGINT; selector: INTEGER; userRoutine: PickerCanDoUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerVersionProc(storage: LONGINT; userRoutine: PickerVersionUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerRegisterProc(storage: LONGINT; userRoutine: PickerRegisterUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetTargetProc(storage: LONGINT; topOfCallChain: ComponentInstance; userRoutine: PickerSetTargetUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerInitProc(storage: LONGINT; VAR data: PickerInitData; userRoutine: PickerInitUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerTestGraphicsWorldProc(storage: LONGINT; VAR data: PickerInitData; userRoutine: PickerTestGraphicsWorldUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetDialogProc(storage: LONGINT; userRoutine: PickerGetDialogUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetItemListProc(storage: LONGINT; userRoutine: PickerGetItemListUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetColorProc(storage: LONGINT; whichColor: ColorType; color: PMColorPtr; userRoutine: PickerGetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetColorProc(storage: LONGINT; whichColor: ColorType; color: PMColorPtr; userRoutine: PickerSetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerEventProc(storage: LONGINT; VAR data: EventData; userRoutine: PickerEventUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerEditProc(storage: LONGINT; VAR data: EditData; userRoutine: PickerEditUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetVisibilityProc(storage: LONGINT; visible: BOOLEAN; userRoutine: PickerSetVisibilityUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerDisplayProc(storage: LONGINT; userRoutine: PickerDisplayUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerItemHitProc(storage: LONGINT; VAR data: ItemHitData; userRoutine: PickerItemHitUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetBaseItemProc(storage: LONGINT; baseItem: INTEGER; userRoutine: PickerSetBaseItemUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetProfileProc(storage: LONGINT; userRoutine: PickerGetProfileUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetProfileProc(storage: LONGINT; profile: CMProfileHandle; userRoutine: PickerSetProfileUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetPromptProc(storage: LONGINT; VAR prompt: Str255; userRoutine: PickerGetPromptUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetPromptProc(storage: LONGINT; prompt: ConstStr255Param; userRoutine: PickerSetPromptUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetIconDataProc(storage: LONGINT; VAR data: PickerIconData; userRoutine: PickerGetIconDataUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerGetEditMenuStateProc(storage: LONGINT; VAR mState: PickerMenuState; userRoutine: PickerGetEditMenuStateUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetOriginProc(storage: LONGINT; where: Point; userRoutine: PickerSetOriginUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetColorChangedProcProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT; userRoutine: PickerSetColorChangedProcUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNPickerGetColorProc(storage: LONGINT; whichColor: ColorType; VAR color: NPMColor; userRoutine: NPickerGetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNPickerSetColorProc(storage: LONGINT; whichColor: ColorType; VAR color: NPMColor; userRoutine: NPickerSetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNPickerGetProfileProc(storage: LONGINT; VAR profile: CMProfileRef; userRoutine: NPickerGetProfileUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNPickerSetProfileProc(storage: LONGINT; profile: CMProfileRef; userRoutine: NPickerSetProfileUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNPickerSetColorChangedProcProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT; userRoutine: NPickerSetColorChangedProcUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerExtractHelpItemProc(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: HelpItemInfo; userRoutine: PickerExtractHelpItemUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ColorPickerComponentsIncludes}

{$ENDC} {__COLORPICKERCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
