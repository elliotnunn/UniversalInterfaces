{
 	File:		ColorPickerComponents.p
 
 	Contains:	Color Picker Component Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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

{ These structs were moved here from the ColorPicker header.}
	kPickerDidNothing			= 0;							{  was kDidNothing  }
	kPickerColorChanged			= 1;							{  was kColorChanged  }
	kPickerOkHit				= 2;							{  was kOkHit  }
	kPickerCancelHit			= 3;							{  was kCancelHit  }
	kPickerNewPickerChosen		= 4;							{  was kNewPickerChosen  }
	kPickerApplItemHit			= 5;							{  was kApplItemHit  }


TYPE
	PickerAction						= INTEGER;

CONST
	kOriginalColor				= 0;
	kNewColor					= 1;


TYPE
	PickerColorType						= INTEGER;

CONST
	kPickerCut					= 0;							{  was kCut  }
	kPickerCopy					= 1;							{  was kCopy  }
	kPickerPaste				= 2;							{  was kPaste  }
	kPickerClear				= 3;							{  was kClear  }
	kPickerUndo					= 4;							{  was kUndo  }


TYPE
	PickerEditOperation					= INTEGER;

CONST
	kPickerMouseDown			= 0;							{  was kMouseDown  }
	kPickerKeyDown				= 1;							{  was kKeyDown  }
	kPickerFieldEntered			= 2;							{  was kFieldEntered  }
	kPickerFieldLeft			= 3;							{  was kFieldLeft  }
	kPickerCutOp				= 4;							{  was kCutOp  }
	kPickerCopyOp				= 5;							{  was kCopyOp  }
	kPickerPasteOp				= 6;							{  was kPasteOp  }
	kPickerClearOp				= 7;							{  was kClearOp  }
	kPickerUndoOp				= 8;							{  was kUndoOp  }


TYPE
	PickerItemModifier					= INTEGER;
{ These are for the flags field in the picker's 'thng' resource. }

CONST
	kPickerCanDoColor			= 1;							{  was CanDoColor  }
	kPickerCanDoBlackWhite		= 2;							{  was CanDoBlackWhite  }
	kPickerAlwaysModifiesPalette = 4;							{  was AlwaysModifiesPalette  }
	kPickerMayModifyPalette		= 8;							{  was MayModifyPalette  }
	kPickerIsColorSyncAware		= 16;							{  was PickerIsColorSyncAware  }
	kPickerCanDoSystemDialog	= 32;							{  was CanDoSystemDialog  }
	kPickerCanDoApplDialog		= 64;							{  was CanDoApplDialog  }
	kPickerHasOwnDialog			= 128;							{  was HasOwnDialog  }
	kPickerCanDetach			= 256;							{  was CanDetach  }
	kPickerIsColorSync2Aware	= 512;							{  was PickerIsColorSync2Aware  }

	kPickerNoForcast			= 0;							{  was kNoForcast  }
	kPickerMenuChoice			= 1;							{  was kMenuChoice  }
	kPickerDialogAccept			= 2;							{  was kDialogAccept  }
	kPickerDialogCancel			= 3;							{  was kDialogCancel  }
	kPickerLeaveFocus			= 4;							{  was kLeaveFocus  }
	kPickerSwitch				= 5;
	kPickerNormalKeyDown		= 6;							{  was kNormalKeyDown  }
	kPickerNormalMouseDown		= 7;							{  was kNormalMouseDown  }


TYPE
	PickerEventForcaster				= INTEGER;
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

	PickerEventDataPtr = ^PickerEventData;
	PickerEventData = RECORD
		event:					EventRecordPtr;
		action:					PickerAction;
		itemHit:				INTEGER;
		handled:				BOOLEAN;
		filler:					SInt8;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		forcast:				PickerEventForcaster;
	END;

	PickerEditDataPtr = ^PickerEditData;
	PickerEditData = RECORD
		theEdit:				PickerEditOperation;
		action:					PickerAction;
		handled:				BOOLEAN;
		filler:					SInt8;
	END;

	PickerItemHitDataPtr = ^PickerItemHitData;
	PickerItemHitData = RECORD
		itemHit:				INTEGER;
		iMod:					PickerItemModifier;
		action:					PickerAction;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		where:					Point;
	END;

	PickerHelpItemInfoPtr = ^PickerHelpItemInfo;
	PickerHelpItemInfo = RECORD
		options:				LONGINT;
		tip:					Point;
		altRect:				Rect;
		theProc:				INTEGER;
		helpVariant:			INTEGER;
		helpMessage:			HMMessageRecord;
	END;

{$IFC OLDROUTINENAMES }

CONST
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

	kDidNothing					= 0;
	kColorChanged				= 1;
	kOkHit						= 2;
	kCancelHit					= 3;
	kNewPickerChosen			= 4;
	kApplItemHit				= 5;

	kCut						= 0;
	kCopy						= 1;
	kPaste						= 2;
	kClear						= 3;
	kUndo						= 4;

	kMouseDown					= 0;
	kKeyDown					= 1;
	kFieldEntered				= 2;
	kFieldLeft					= 3;
	kCutOp						= 4;
	kCopyOp						= 5;
	kPasteOp					= 6;
	kClearOp					= 7;
	kUndoOp						= 8;

	kNoForcast					= 0;
	kMenuChoice					= 1;
	kDialogAccept				= 2;
	kDialogCancel				= 3;
	kLeaveFocus					= 4;
	kNormalKeyDown				= 6;
	kNormalMouseDown			= 7;


TYPE
	ColorType							= INTEGER;
	EditOperation						= INTEGER;
	ItemModifier						= INTEGER;
	EventForcaster						= INTEGER;
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

{$ENDC}  {OLDROUTINENAMES}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerOpenProcPtr = FUNCTION(storage: LONGINT; self: ComponentInstance): ComponentResult;
{$ELSEC}
	PickerOpenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerCloseProcPtr = FUNCTION(storage: LONGINT; self: ComponentInstance): ComponentResult;
{$ELSEC}
	PickerCloseProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerCanDoProcPtr = FUNCTION(storage: LONGINT; selector: INTEGER): ComponentResult;
{$ELSEC}
	PickerCanDoProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerVersionProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerVersionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerRegisterProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerRegisterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetTargetProcPtr = FUNCTION(storage: LONGINT; topOfCallChain: ComponentInstance): ComponentResult;
{$ELSEC}
	PickerSetTargetProcPtr = ProcPtr;
{$ENDC}

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
{$IFC TYPED_FUNCTION_POINTERS}
	PickerInitProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
{$ELSEC}
	PickerInitProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerTestGraphicsWorld(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerTestGraphicsWorldProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
{$ELSEC}
	PickerTestGraphicsWorldProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetDialog(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetDialogProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerGetDialogProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetItemList(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetItemListProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerGetItemListProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetColor(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0004, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
{$ELSEC}
	PickerGetColorProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerSetColor(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0005, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
{$ELSEC}
	PickerSetColorProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerEvent(storage: LONGINT; VAR data: PickerEventData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerEventProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerEventData): ComponentResult;
{$ELSEC}
	PickerEventProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerEdit(storage: LONGINT; VAR data: PickerEditData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerEditProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerEditData): ComponentResult;
{$ELSEC}
	PickerEditProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerSetVisibility(storage: LONGINT; visible: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0008, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetVisibilityProcPtr = FUNCTION(storage: LONGINT; visible: BOOLEAN): ComponentResult;
{$ELSEC}
	PickerSetVisibilityProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerDisplay(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerDisplayProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerDisplayProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerItemHit(storage: LONGINT; VAR data: PickerItemHitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerItemHitProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerItemHitData): ComponentResult;
{$ELSEC}
	PickerItemHitProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerSetBaseItem(storage: LONGINT; baseItem: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000B, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetBaseItemProcPtr = FUNCTION(storage: LONGINT; baseItem: INTEGER): ComponentResult;
{$ELSEC}
	PickerSetBaseItemProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetProfile(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000C, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetProfileProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerGetProfileProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerSetProfile(storage: LONGINT; profile: CMProfileHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetProfileProcPtr = FUNCTION(storage: LONGINT; profile: CMProfileHandle): ComponentResult;
{$ELSEC}
	PickerSetProfileProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetPrompt(storage: LONGINT; VAR prompt: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetPromptProcPtr = FUNCTION(storage: LONGINT; VAR prompt: Str255): ComponentResult;
{$ELSEC}
	PickerGetPromptProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerSetPrompt(storage: LONGINT; prompt: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetPromptProcPtr = FUNCTION(storage: LONGINT; prompt: Str255): ComponentResult;
{$ELSEC}
	PickerSetPromptProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetIconData(storage: LONGINT; VAR data: PickerIconData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetIconDataProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerIconData): ComponentResult;
{$ELSEC}
	PickerGetIconDataProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerGetEditMenuState(storage: LONGINT; VAR mState: PickerMenuState): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetEditMenuStateProcPtr = FUNCTION(storage: LONGINT; VAR mState: PickerMenuState): ComponentResult;
{$ELSEC}
	PickerGetEditMenuStateProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerSetOrigin(storage: LONGINT; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetOriginProcPtr = FUNCTION(storage: LONGINT; where: Point): ComponentResult;
{$ELSEC}
	PickerSetOriginProcPtr = ProcPtr;
{$ENDC}

{ 	Below are the ColorPicker 2.1 routines. }


FUNCTION PickerSetColorChangedProc(storage: LONGINT; colorProc: ColorChangedUPP; colorProcData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0014, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetColorChangedProcProcPtr = FUNCTION(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
{$ELSEC}
	PickerSetColorChangedProcProcPtr = ProcPtr;
{$ENDC}

{ New Color Picker 2.1 messages.  If you don't wish to support these you should already be... }
{ returning a badComponentSelector in your main entry routine.  They have new selectors}
FUNCTION NPickerGetColor(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0015, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerGetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
{$ELSEC}
	NPickerGetColorProcPtr = ProcPtr;
{$ENDC}

FUNCTION NPickerSetColor(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0016, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerSetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
{$ELSEC}
	NPickerSetColorProcPtr = ProcPtr;
{$ENDC}

FUNCTION NPickerGetProfile(storage: LONGINT; VAR profile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerGetProfileProcPtr = FUNCTION(storage: LONGINT; VAR profile: CMProfileRef): ComponentResult;
{$ELSEC}
	NPickerGetProfileProcPtr = ProcPtr;
{$ENDC}

FUNCTION NPickerSetProfile(storage: LONGINT; profile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerSetProfileProcPtr = FUNCTION(storage: LONGINT; profile: CMProfileRef): ComponentResult;
{$ELSEC}
	NPickerSetProfileProcPtr = ProcPtr;
{$ENDC}

FUNCTION NPickerSetColorChangedProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0019, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerSetColorChangedProcProcPtr = FUNCTION(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
{$ELSEC}
	NPickerSetColorChangedProcProcPtr = ProcPtr;
{$ENDC}

FUNCTION PickerExtractHelpItem(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: PickerHelpItemInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerExtractHelpItemProcPtr = FUNCTION(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: PickerHelpItemInfo): ComponentResult;
{$ELSEC}
	PickerExtractHelpItemProcPtr = ProcPtr;
{$ENDC}

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

FUNCTION CallPickerGetColorProc(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr; userRoutine: PickerGetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerSetColorProc(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr; userRoutine: PickerSetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerEventProc(storage: LONGINT; VAR data: PickerEventData; userRoutine: PickerEventUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPickerEditProc(storage: LONGINT; VAR data: PickerEditData; userRoutine: PickerEditUPP): ComponentResult;
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

FUNCTION CallPickerItemHitProc(storage: LONGINT; VAR data: PickerItemHitData; userRoutine: PickerItemHitUPP): ComponentResult;
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

FUNCTION CallPickerSetPromptProc(storage: LONGINT; prompt: Str255; userRoutine: PickerSetPromptUPP): ComponentResult;
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

FUNCTION CallNPickerGetColorProc(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor; userRoutine: NPickerGetColorUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNPickerSetColorProc(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor; userRoutine: NPickerSetColorUPP): ComponentResult;
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

FUNCTION CallPickerExtractHelpItemProc(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: PickerHelpItemInfo; userRoutine: PickerExtractHelpItemUPP): ComponentResult;
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
