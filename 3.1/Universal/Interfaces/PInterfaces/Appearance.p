{
 	File:		Appearance.p
 
 	Contains:	Appearance Manager Interfaces.
 
 	Version:	Technology:	Appearance 1.0.2
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Appearance;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPEARANCE__}
{$SETC __APPEARANCE__ := 1}

{$I+}
{$SETC AppearanceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————}
{ Appearance Manager constants, etc.												}
{——————————————————————————————————————————————————————————————————————————————————}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Appearance Trap Number  }
	_AppearanceDispatch			= $AA74;

{ Gestalt selector and values for the Appearance Manager }
	gestaltAppearanceAttr		= 'appr';
	gestaltAppearanceExists		= 0;
	gestaltAppearanceCompatMode	= 1;

{ Gestalt selector for determining Appearance Manager version 	}
{ If this selector does not exist, but gestaltAppearanceAttr	}
{ does, it indicates that the 1.0 version is installed. This	}
{ gestalt returns a BCD number representing the version of the	}
{ Appearance Manager that is currently running, e.g. 0x0101 for}
{ version 1.0.1.												}
	gestaltAppearanceVersion	= 'apvr';

{ Appearance Manager Apple Events (1.0.1 and later) }
	kAppearanceEventClass		= 'appr';						{  Event Class  }
	kAEThemeSwitch				= 'thme';						{  Event ID's: Theme Switched  }

{ Appearance Manager Error Codes }
	appearanceBadBrushIndexErr	= -30560;						{  pattern index invalid  }
	appearanceProcessRegisteredErr = -30561;
	appearanceProcessNotRegisteredErr = -30562;
	appearanceBadTextColorIndexErr = -30563;
	appearanceThemeHasNoAccents	= -30564;
	appearanceBadCursorIndexErr	= -30565;

	kThemeActiveDialogBackgroundBrush = 1;						{  Dialogs  }
	kThemeInactiveDialogBackgroundBrush = 2;					{  Dialogs  }
	kThemeActiveAlertBackgroundBrush = 3;
	kThemeInactiveAlertBackgroundBrush = 4;
	kThemeActiveModelessDialogBackgroundBrush = 5;
	kThemeInactiveModelessDialogBackgroundBrush = 6;
	kThemeActiveUtilityWindowBackgroundBrush = 7;				{  Miscellaneous  }
	kThemeInactiveUtilityWindowBackgroundBrush = 8;				{  Miscellaneous  }
	kThemeListViewSortColumnBackgroundBrush = 9;				{  Finder  }
	kThemeListViewBackgroundBrush = 10;
	kThemeIconLabelBackgroundBrush = 11;
	kThemeListViewSeparatorBrush = 12;
	kThemeChasingArrowsBrush	= 13;
	kThemeDragHiliteBrush		= 14;
	kThemeDocumentWindowBackgroundBrush = 15;
	kThemeFinderWindowBackgroundBrush = 16;


TYPE
	ThemeBrush							= SInt16;

CONST
	kThemeActiveDialogTextColor	= 1;							{  Dialogs  }
	kThemeInactiveDialogTextColor = 2;
	kThemeActiveAlertTextColor	= 3;
	kThemeInactiveAlertTextColor = 4;
	kThemeActiveModelessDialogTextColor = 5;
	kThemeInactiveModelessDialogTextColor = 6;
	kThemeActiveWindowHeaderTextColor = 7;						{  Primitives  }
	kThemeInactiveWindowHeaderTextColor = 8;
	kThemeActivePlacardTextColor = 9;							{  Primitives  }
	kThemeInactivePlacardTextColor = 10;
	kThemePressedPlacardTextColor = 11;
	kThemeActivePushButtonTextColor = 12;						{  Primitives  }
	kThemeInactivePushButtonTextColor = 13;
	kThemePressedPushButtonTextColor = 14;
	kThemeActiveBevelButtonTextColor = 15;						{  Primitives  }
	kThemeInactiveBevelButtonTextColor = 16;
	kThemePressedBevelButtonTextColor = 17;
	kThemeActivePopupButtonTextColor = 18;						{  Primitives  }
	kThemeInactivePopupButtonTextColor = 19;
	kThemePressedPopupButtonTextColor = 20;
	kThemeIconLabelTextColor	= 21;							{  Finder  }
	kThemeListViewTextColor		= 22;

{ Text Colors available in Appearance 1.0.1 or later }
	kThemeActiveDocumentWindowTitleTextColor = 23;
	kThemeInactiveDocumentWindowTitleTextColor = 24;
	kThemeActiveMovableModalWindowTitleTextColor = 25;
	kThemeInactiveMovableModalWindowTitleTextColor = 26;
	kThemeActiveUtilityWindowTitleTextColor = 27;
	kThemeInactiveUtilityWindowTitleTextColor = 28;
	kThemeActivePopupWindowTitleColor = 29;
	kThemeInactivePopupWindowTitleColor = 30;
	kThemeActiveRootMenuTextColor = 31;
	kThemeSelectedRootMenuTextColor = 32;
	kThemeDisabledRootMenuTextColor = 33;
	kThemeActiveMenuItemTextColor = 34;
	kThemeSelectedMenuItemTextColor = 35;
	kThemeDisabledMenuItemTextColor = 36;
	kThemeActivePopupLabelTextColor = 37;
	kThemeInactivePopupLabelTextColor = 38;


TYPE
	ThemeTextColor						= SInt16;
{ States to draw primitives: disabled, active, and pressed (hilited) }

CONST
	kThemeStateDisabled			= 0;
	kThemeStateActive			= 1;
	kThemeStatePressed			= 2;


TYPE
	ThemeDrawState						= UInt32;
{——————————————————————————————————————————————————————————————————————————————————}
{ Theme menu bar drawing states													}
{——————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeMenuBarNormal			= 0;
	kThemeMenuBarSelected		= 1;


TYPE
	ThemeMenuBarState					= SInt16;
{ attributes }

CONST
	kThemeMenuSquareMenuBar		= $01;

{——————————————————————————————————————————————————————————————————————————————————}
{ Theme menu drawing states													    }
{——————————————————————————————————————————————————————————————————————————————————}
	kThemeMenuActive			= 0;
	kThemeMenuSelected			= 1;
	kThemeMenuDisabled			= 3;


TYPE
	ThemeMenuState						= SInt16;

CONST
	kThemeMenuTypePullDown		= 0;
	kThemeMenuTypePopUp			= 1;
	kThemeMenuTypeHierarchical	= 2;


TYPE
	ThemeMenuType						= SInt16;

CONST
	kThemeMenuItemPlain			= 0;
	kThemeMenuItemHierarchical	= 1;
	kThemeMenuItemScrollUpArrow	= 2;
	kThemeMenuItemScrollDownArrow = 3;


TYPE
	ThemeMenuItemType					= SInt16;
{——————————————————————————————————————————————————————————————————————————————————}
{ Menu Drawing callbacks														    }
{——————————————————————————————————————————————————————————————————————————————————}
{$IFC TYPED_FUNCTION_POINTERS}
	MenuTitleDrawingProcPtr = PROCEDURE({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32);
{$ELSEC}
	MenuTitleDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MenuItemDrawingProcPtr = PROCEDURE({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32);
{$ELSEC}
	MenuItemDrawingProcPtr = ProcPtr;
{$ENDC}

	MenuTitleDrawingUPP = UniversalProcPtr;
	MenuItemDrawingUPP = UniversalProcPtr;

CONST
	uppMenuTitleDrawingProcInfo = $000036C0;
	uppMenuItemDrawingProcInfo = $000036C0;

FUNCTION NewMenuTitleDrawingProc(userRoutine: MenuTitleDrawingProcPtr): MenuTitleDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuItemDrawingProc(userRoutine: MenuItemDrawingProcPtr): MenuItemDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMenuTitleDrawingProc({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32; userRoutine: MenuTitleDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMenuItemDrawingProc({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32; userRoutine: MenuItemDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————}
{	Appearance Manager APIs															}
{——————————————————————————————————————————————————————————————————————————————————}
{ Registering Appearance-Savvy Applications }
FUNCTION RegisterAppearanceClient: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0015, $AA74;
	{$ENDC}
FUNCTION UnregisterAppearanceClient: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0016, $AA74;
	{$ENDC}
{****************************************************************************
	NOTES ON THEME BRUSHES
	Theme brushes can be either colors or patterns, depending on the theme.
	Because of this, you should be prepared to handle the case where a brush
	is a pattern and save and restore the pnPixPat and bkPixPat fields of
	your GrafPorts when saving the fore and back colors. Also, since patterns
	in bkPixPat override the background color of the window, you should use
	BackPat to set your background pattern to a normal white pattern. This
	will ensure that you can use RGBBackColor to set your back color to white,
	call EraseRect and get the expected results.
****************************************************************************}

FUNCTION SetThemePen(inBrush: ThemeBrush; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA74;
	{$ENDC}
FUNCTION SetThemeBackground(inBrush: ThemeBrush; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA74;
	{$ENDC}
FUNCTION SetThemeTextColor(inColor: ThemeTextColor; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA74;
	{$ENDC}
FUNCTION SetThemeWindowBackground(inWindow: WindowPtr; inBrush: ThemeBrush; inUpdate: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA74;
	{$ENDC}
{ Window Placards, Headers and Frames }
FUNCTION DrawThemeWindowHeader({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA74;
	{$ENDC}
FUNCTION DrawThemeWindowListViewHeader({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA74;
	{$ENDC}
FUNCTION DrawThemePlacard({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA74;
	{$ENDC}
FUNCTION DrawThemeEditTextFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA74;
	{$ENDC}
FUNCTION DrawThemeListBoxFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA74;
	{$ENDC}
{ Keyboard Focus Drawing }
FUNCTION DrawThemeFocusRect({CONST}VAR inRect: Rect; inHasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA74;
	{$ENDC}
{ Dialog Group Boxes and Separators }
FUNCTION DrawThemePrimaryGroup({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA74;
	{$ENDC}
FUNCTION DrawThemeSecondaryGroup({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA74;
	{$ENDC}
FUNCTION DrawThemeSeparator({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA74;
	{$ENDC}
{ -------------------- BEGIN APPEARANCE 1.0.1 -------------------------------------}
{ The following Appearance Manager APIs are only available }
{ in Appearance 1.0.1 or later 							}
FUNCTION DrawThemeModelessDialogFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA74;
	{$ENDC}
FUNCTION DrawThemeGenericWell({CONST}VAR inRect: Rect; inState: ThemeDrawState; inFillCenter: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0022, $AA74;
	{$ENDC}
FUNCTION DrawThemeFocusRegion(inRegion: RgnHandle; inHasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0023, $AA74;
	{$ENDC}
FUNCTION IsThemeInColor(inDepth: SInt16; inIsColorDevice: BOOLEAN): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0024, $AA74;
	{$ENDC}
{ IMPORTANT: GetThemeAccentColors will only work in the platinum theme. Any other theme will }
{ most likely return an error }
FUNCTION GetThemeAccentColors(VAR outColors: CTabHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0025, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuBarBackground({CONST}VAR inBounds: Rect; inState: ThemeMenuBarState; inAttributes: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuTitle({CONST}VAR inMenuBarRect: Rect; {CONST}VAR inTitleRect: Rect; inState: ThemeMenuState; inAttributes: UInt32; inTitleProc: MenuTitleDrawingUPP; inTitleData: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuBarHeight(VAR outHeight: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001A, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuBackground({CONST}VAR inMenuRect: Rect; inMenuType: ThemeMenuType): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001B, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuBackgroundRegion({CONST}VAR inMenuRect: Rect; menuType: ThemeMenuType; region: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001C, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuItem({CONST}VAR inMenuRect: Rect; {CONST}VAR inItemRect: Rect; inVirtualMenuTop: SInt16; inVirtualMenuBottom: SInt16; inState: ThemeMenuState; inItemType: ThemeMenuItemType; inDrawProc: MenuItemDrawingUPP; inUserData: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001D, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuSeparator({CONST}VAR inItemRect: Rect): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001E, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuSeparatorHeight(VAR outHeight: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001F, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuItemExtra(inItemType: ThemeMenuItemType; VAR outHeight: SInt16; VAR outWidth: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0020, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuTitleExtra(VAR outWidth: SInt16; inIsSquished: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0021, $AA74;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppearanceIncludes}

{$ENDC} {__APPEARANCE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
