{
     File:       Menus.p
 
     Contains:   Menu Manager Interfaces.
 
     Version:    Technology: Mac OS 9.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Menus;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MENUS__}
{$SETC __MENUS__ := 1}

{$I+}
{$SETC MenusIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Constants                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	noMark						= 0;							{  mark symbol for SetItemMark; other mark symbols are defined in Fonts.h  }

																{  menu defProc messages  }
	kMenuDrawMsg				= 0;
	kMenuSizeMsg				= 2;
	kMenuPopUpMsg				= 3;
	kMenuCalcItemMsg			= 5;
	kMenuThemeSavvyMsg			= 7;							{  is your MDEF theme-savvy?  If so, return hex 7473 in the whichItem parameter }
	mDrawMsg					= 0;
	mSizeMsg					= 2;
	mPopUpMsg					= 3;							{  position the popup menu rect appropriately  }
	mCalcItemMsg				= 5;

{
   Carbon MDEFs must replace mChooseMsg with the new messages kMenuFindItemMsg and kMenuHiliteItemMsg. 
   mDrawItemMsg was used by the popup menu control before 8.5, but is no longer used. 
}
	mChooseMsg					= 1;
	mDrawItemMsg				= 4;
	kMenuChooseMsg				= 1;
	kMenuDrawItemMsg			= 4;

	kThemeSavvyMenuResponse		= $7473;

{  these MDEF messages are only supported in Carbon }
	kMenuInitMsg				= 8;
	kMenuDisposeMsg				= 9;
	kMenuFindItemMsg			= 10;
	kMenuHiliteItemMsg			= 11;

	textMenuProc				= 0;
	hMenuCmd					= 27;							{ itemCmd == 0x001B ==> hierarchical menu }
	hierMenu					= -1;							{ a hierarchical menu - for InsertMenu call }
	kInsertHierarchicalMenu		= -1;							{ a better name for hierMenu  }
	mctAllItems					= -98;							{ search for all Items for the given ID }
	mctLastIDIndic				= -99;							{ last color table entry has this in ID field }

{  Constants for use with MacOS 8.0 (Appearance 1.0) and later }
	kMenuStdMenuProc			= 63;
	kMenuStdMenuBarProc			= 63;

	kMenuNoModifiers			= 0;							{  Mask for no modifiers }
	kMenuShiftModifier			= $01;							{  Mask for shift key modifier }
	kMenuOptionModifier			= $02;							{  Mask for option key modifier }
	kMenuControlModifier		= $04;							{  Mask for control key modifier }
	kMenuNoCommandModifier		= $08;							{  Mask for no command key modifier }

	kMenuNoIcon					= 0;							{  No icon }
	kMenuIconType				= 1;							{  Type for ICON }
	kMenuShrinkIconType			= 2;							{  Type for ICON plotted 16 x 16 }
	kMenuSmallIconType			= 3;							{  Type for SICN }
	kMenuColorIconType			= 4;							{  Type for cicn }
	kMenuIconSuiteType			= 5;							{  Type for Icon Suite }
	kMenuIconRefType			= 6;							{  Type for Icon Ref }

	kMenuAttrExcludesMarkColumn	= $01;							{  No space is allocated for the mark character  }
	kMenuAttrAutoDisable		= $04;							{  Menu title is automatically disabled when all items are disabled  }


TYPE
	MenuAttributes						= OptionBits;

CONST
	kMenuItemAttrSubmenuParentChoosable = $04;					{  Parent item of a submenu is still selectable by the user  }


TYPE
	MenuItemAttributes					= OptionBits;
	MenuTrackingMode 			= UInt32;
CONST
	kMenuTrackingModeMouse		= 1;							{  Menus are being tracked using the mouse }
	kMenuTrackingModeKeyboard	= 2;							{  Menus are being tracked using the keyboard }

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Types                                                                        }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	MenuID								= SInt16;
	MenuItemIndex						= UInt16;
	MenuCommand							= UInt32;
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	MenuInfoPtr = ^MenuInfo;
	MenuInfo = RECORD
		menuID:					MenuID;									{  in Carbon use Get/SetMenuID }
		menuWidth:				INTEGER;								{  in Carbon use Get/SetMenuWidth }
		menuHeight:				INTEGER;								{  in Carbon use Get/SetMenuHeight }
		menuProc:				Handle;									{  not supported in Carbon }
		enableFlags:			LONGINT;								{  in Carbon use Enable/DisableMenuItem, IsMenuItemEnable }
		menuData:				Str255;									{  in Carbon use Get/SetMenuTitle }
	END;

	MenuPtr								= ^MenuInfo;
	MenuHandle							= ^MenuPtr;
{$ELSEC}
	MenuHandle = ^LONGINT; { an opaque 32-bit type }
{$ENDC}

{  MenuRef and MenuHandle are equivalent. Use either. We don't care. }
	MenuRef								= MenuHandle;
	MenuBarHandle						= Handle;
	MCEntryPtr = ^MCEntry;
	MCEntry = RECORD
		mctID:					MenuID;									{ menu ID.  ID = 0 is the menu bar }
		mctItem:				INTEGER;								{ menu Item. Item = 0 is a title }
		mctRGB1:				RGBColor;								{ usage depends on ID and Item }
		mctRGB2:				RGBColor;								{ usage depends on ID and Item }
		mctRGB3:				RGBColor;								{ usage depends on ID and Item }
		mctRGB4:				RGBColor;								{ usage depends on ID and Item }
		mctReserved:			INTEGER;								{ reserved for internal use }
	END;

	MCTable								= ARRAY [0..0] OF MCEntry;
	MCTablePtr							= ^MCTable;
	MCTableHandle						= ^MCTablePtr;
	MenuCRsrcPtr = ^MenuCRsrc;
	MenuCRsrc = RECORD
		numEntries:				INTEGER;								{ number of entries }
		mcEntryRecs:			MCTable;								{ ARRAY [1..numEntries] of MCEntry }
	END;

	MenuCRsrcHandle						= ^MenuCRsrcPtr;
{$IFC TARGET_OS_WIN32 }
{ QuickTime 3.0 }
	MenuAccessKeyRecPtr = ^MenuAccessKeyRec;
	MenuAccessKeyRec = RECORD
		count:					INTEGER;
		flags:					LONGINT;
		keys:					SInt8;
	END;

	MenuAccessKeyPtr					= ^MenuAccessKeyRec;
	MenuAccessKeyHandle					= ^MenuAccessKeyPtr;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetMenuItemHotKey(menu: MenuRef; itemID: INTEGER; hotKey: ByteParameter; flags: LONGINT); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}


TYPE
	MenuTrackingDataPtr = ^MenuTrackingData;
	MenuTrackingData = RECORD
		menu:					MenuRef;
		itemSelected:			MenuItemIndex;
		itemUnderMouse:			MenuItemIndex;
		itemRect:				Rect;
		virtualMenuTop:			SInt32;
		virtualMenuBottom:		SInt32;
	END;

	HiliteMenuItemDataPtr = ^HiliteMenuItemData;
	HiliteMenuItemData = RECORD
		previousItem:			MenuItemIndex;
		newItem:				MenuItemIndex;
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu ProcPtrs                                                                     }
{                                                                                      }
{  All of these procs are considered deprecated.  Developers interested in portability }
{  to Carbon should avoid them entirely, if at all possible.                           }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC TYPED_FUNCTION_POINTERS}
	MenuDefProcPtr = PROCEDURE(message: INTEGER; theMenu: MenuRef; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER);
{$ELSEC}
	MenuDefProcPtr = ProcPtr;
{$ENDC}

	MenuDefUPP = UniversalProcPtr;

CONST
	uppMenuDefProcInfo = $0000FF80;

FUNCTION NewMenuDefUPP(userRoutine: MenuDefProcPtr): MenuDefUPP; { old name was NewMenuDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeMenuDefUPP(userUPP: MenuDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeMenuDefUPP(message: INTEGER; theMenu: MenuRef; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER; userRoutine: MenuDefUPP); { old name was CallMenuDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MenuBarDefProcPtr = FUNCTION(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT): LONGINT;
{$ELSEC}
	MenuBarDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MenuHookProcPtr = PROCEDURE;
{$ELSEC}
	MenuHookProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MBarHookProcPtr = FUNCTION(VAR menuRect: Rect): INTEGER;
{$ELSEC}
	MBarHookProcPtr = Register68kProcPtr;
{$ENDC}

	MenuBarDefUPP = UniversalProcPtr;
	MenuHookUPP = UniversalProcPtr;
	MBarHookUPP = UniversalProcPtr;

CONST
	uppMenuBarDefProcInfo = $00003AB0;
	uppMenuHookProcInfo = $00000000;
	uppMBarHookProcInfo = $000000CF;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewMenuBarDefUPP(userRoutine: MenuBarDefProcPtr): MenuBarDefUPP; { old name was NewMenuBarDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuHookUPP(userRoutine: MenuHookProcPtr): MenuHookUPP; { old name was NewMenuHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMBarHookUPP(userRoutine: MBarHookProcPtr): MBarHookUPP; { old name was NewMBarHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeMenuBarDefUPP(userUPP: MenuBarDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeMenuHookUPP(userUPP: MenuHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeMBarHookUPP(userUPP: MBarHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeMenuBarDefUPP(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT; userRoutine: MenuBarDefUPP): LONGINT; { old name was CallMenuBarDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeMenuHookUPP(userRoutine: MenuHookUPP); { old name was CallMenuHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeMBarHookUPP(VAR menuRect: Rect; userRoutine: MBarHookUPP): INTEGER; { old name was CallMBarHookProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kMenuDefProcPtr				= 0;							{  raw proc-ptr access based on old MDEF  }


TYPE
	MenuDefType							= UInt32;
	MenuDefSpecPtr = ^MenuDefSpec;
	MenuDefSpec = RECORD
		defType:				MenuDefType;
		CASE INTEGER OF
		0: (
			defProc:			MenuDefUPP;
			);
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Manager Initialization                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE InitProcMenu(resID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A808;
	{$ENDC}
PROCEDURE InitMenus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A930;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Manipulation                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewMenu(menuID: MenuID; menuTitle: Str255): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A931;
	{$ENDC}
FUNCTION GetMenu(resourceID: INTEGER): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BF;
	{$ENDC}
PROCEDURE DisposeMenu(theMenu: MenuRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A932;
	{$ENDC}
PROCEDURE CalcMenuSize(theMenu: MenuRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A948;
	{$ENDC}
FUNCTION CountMenuItems(theMenu: MenuRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A950;
	{$ENDC}
{ CountMItems() has been renamed to CountMenuItems() in Carbon }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CountMItems(theMenu: MenuRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A950;
	{$ENDC}

{  Routines available in Mac OS 8.5 and later, and on Mac OS 8.1 and later using CarbonLib 1.1 and later }

{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION GetMenuFont(menu: MenuRef; VAR outFontID: SInt16; VAR outFontSize: UInt16): OSStatus;
FUNCTION SetMenuFont(menu: MenuRef; inFontID: SInt16; inFontSize: UInt16): OSStatus;
FUNCTION GetMenuExcludesMarkColumn(menu: MenuRef): BOOLEAN;
FUNCTION SetMenuExcludesMarkColumn(menu: MenuRef; excludesMark: BOOLEAN): OSStatus;
{  Routines available in Carbon only }

FUNCTION RegisterMenuDefinition(inResID: SInt16; inDefSpec: MenuDefSpecPtr): OSStatus;
FUNCTION CreateNewMenu(menuID: MenuID; menuAttributes: MenuAttributes; VAR outMenuRef: MenuRef): OSStatus;
FUNCTION CreateCustomMenu({CONST}VAR defSpec: MenuDefSpec; menuID: MenuID; menuAttributes: MenuAttributes; VAR outMenuRef: MenuRef): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Item Insertion                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE AppendMenu(menu: MenuRef; data: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A933;
	{$ENDC}
PROCEDURE InsertResMenu(theMenu: MenuRef; theType: ResType; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A951;
	{$ENDC}
PROCEDURE AppendResMenu(theMenu: MenuRef; theType: ResType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94D;
	{$ENDC}
PROCEDURE InsertMenuItem(theMenu: MenuRef; itemString: Str255; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A826;
	{$ENDC}
PROCEDURE DeleteMenuItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A952;
	{$ENDC}
PROCEDURE InsertFontResMenu(theMenu: MenuRef; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0400, $A825;
	{$ENDC}
PROCEDURE InsertIntlResMenu(theMenu: MenuRef; theType: ResType; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0601, $A825;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later }

FUNCTION AppendMenuItemText(menu: MenuRef; inString: Str255): OSStatus;
FUNCTION InsertMenuItemText(menu: MenuRef; inString: Str255; afterItem: MenuItemIndex): OSStatus;
{  Routines available in Carbon and later }

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Events                                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION MenuKey(ch: CharParameter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93E;
	{$ENDC}
FUNCTION MenuSelect(startPt: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93D;
	{$ENDC}
FUNCTION PopUpMenuSelect(menu: MenuRef; top: INTEGER; left: INTEGER; popUpItem: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80B;
	{$ENDC}
FUNCTION MenuChoice: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA66;
	{$ENDC}
{  Routines available in Mac OS 8.0 (Appearance 1.0) and later }
FUNCTION MenuEvent({CONST}VAR inEvent: EventRecord): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $A825;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Bar                                                                          }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetMBarHeight: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BAA;
	{$ENDC}
PROCEDURE DrawMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A937;
	{$ENDC}
PROCEDURE InvalMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81D;
	{$ENDC}
PROCEDURE HiliteMenu(menuID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A938;
	{$ENDC}
FUNCTION GetNewMBar(menuBarID: INTEGER): MenuBarHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C0;
	{$ENDC}
FUNCTION GetMenuBar: MenuBarHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93B;
	{$ENDC}
PROCEDURE SetMenuBar(mbar: MenuBarHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93C;
	{$ENDC}
{  DuplicateMenuBar and DisposeMenuBar are available in Carbon only }
FUNCTION DuplicateMenuBar(mbar: MenuBarHandle; VAR outBar: MenuBarHandle): OSStatus;
FUNCTION DisposeMenuBar(mbar: MenuBarHandle): OSStatus;
FUNCTION GetMenuHandle(menuID: MenuID): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A949;
	{$ENDC}
PROCEDURE InsertMenu(theMenu: MenuRef; beforeID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A935;
	{$ENDC}
PROCEDURE DeleteMenu(menuID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A936;
	{$ENDC}
PROCEDURE ClearMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A934;
	{$ENDC}
PROCEDURE SetMenuFlashCount(count: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94A;
	{$ENDC}
{ SetMenuFlash() has been renamed to SetMenuFlashCount() in Carbon }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetMenuFlash(count: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE FlashMenuBar(menuID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94C;
	{$ENDC}
{  These are obsolete because Carbon does not support desk accessories. }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SystemEdit(editCmd: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C2;
	{$ENDC}
PROCEDURE SystemMenu(menuResult: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B5;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later }
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION IsMenuBarVisible: BOOLEAN;
PROCEDURE ShowMenuBar;
PROCEDURE HideMenuBar;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Item Accessors                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE CheckMenuItem(theMenu: MenuRef; item: INTEGER; checked: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A945;
	{$ENDC}
{ CheckItem() has been renamed to CheckMenuItem() in Carbon }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE CheckItem(theMenu: MenuRef; item: INTEGER; checked: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A945;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE SetMenuItemText(theMenu: MenuRef; item: INTEGER; itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A947;
	{$ENDC}
PROCEDURE GetMenuItemText(theMenu: MenuRef; item: INTEGER; VAR itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A946;
	{$ENDC}
PROCEDURE SetItemMark(theMenu: MenuRef; item: INTEGER; markChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A944;
	{$ENDC}
PROCEDURE GetItemMark(theMenu: MenuRef; item: INTEGER; VAR markChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A943;
	{$ENDC}
PROCEDURE SetItemCmd(theMenu: MenuRef; item: INTEGER; cmdChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84F;
	{$ENDC}
PROCEDURE GetItemCmd(theMenu: MenuRef; item: INTEGER; VAR cmdChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84E;
	{$ENDC}
PROCEDURE SetItemIcon(theMenu: MenuRef; item: INTEGER; iconIndex: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A940;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE GetItemIcon(theMenu: MenuRef; item: INTEGER; VAR iconIndex: Byte);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE SetItemStyle(theMenu: MenuRef; item: INTEGER; chStyle: StyleParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A942;
	{$ENDC}
PROCEDURE GetItemStyle(theMenu: MenuRef; item: INTEGER; VAR chStyle: Style);
{ These APIs are not supported in Carbon. Please use EnableMenuItem and }
{ DisableMenuItem (available back through Mac OS 8.5) instead.          }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE DisableItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93A;
	{$ENDC}
PROCEDURE EnableItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A939;
	{$ENDC}
{  Routines available in Mac OS 8.0 (Appearance 1.0) and later }

{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION SetMenuItemCommandID(inMenu: MenuRef; inItem: SInt16; inCommandID: MenuCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0502, $A825;
	{$ENDC}
FUNCTION GetMenuItemCommandID(inMenu: MenuRef; inItem: SInt16; VAR outCommandID: MenuCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0503, $A825;
	{$ENDC}
FUNCTION SetMenuItemModifiers(inMenu: MenuRef; inItem: SInt16; inModifiers: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $A825;
	{$ENDC}
FUNCTION GetMenuItemModifiers(inMenu: MenuRef; inItem: SInt16; VAR outModifiers: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0505, $A825;
	{$ENDC}
FUNCTION SetMenuItemIconHandle(inMenu: MenuRef; inItem: SInt16; inIconType: ByteParameter; inIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $A825;
	{$ENDC}
FUNCTION GetMenuItemIconHandle(inMenu: MenuRef; inItem: SInt16; VAR outIconType: UInt8; VAR outIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0707, $A825;
	{$ENDC}
FUNCTION SetMenuItemTextEncoding(inMenu: MenuRef; inItem: SInt16; inScriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $A825;
	{$ENDC}
FUNCTION GetMenuItemTextEncoding(inMenu: MenuRef; inItem: SInt16; VAR outScriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0509, $A825;
	{$ENDC}
FUNCTION SetMenuItemHierarchicalID(inMenu: MenuRef; inItem: SInt16; inHierID: MenuID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $A825;
	{$ENDC}
FUNCTION GetMenuItemHierarchicalID(inMenu: MenuRef; inItem: SInt16; VAR outHierID: MenuID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050E, $A825;
	{$ENDC}
FUNCTION SetMenuItemFontID(inMenu: MenuRef; inItem: SInt16; inFontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $A825;
	{$ENDC}
FUNCTION GetMenuItemFontID(inMenu: MenuRef; inItem: SInt16; VAR outFontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $A825;
	{$ENDC}
FUNCTION SetMenuItemRefCon(inMenu: MenuRef; inItem: SInt16; inRefCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050A, $A825;
	{$ENDC}
FUNCTION GetMenuItemRefCon(inMenu: MenuRef; inItem: SInt16; VAR outRefCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $A825;
	{$ENDC}
{  Please use the menu item property APIs in Carbon. }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SetMenuItemRefCon2(inMenu: MenuRef; inItem: SInt16; inRefCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $A825;
	{$ENDC}
FUNCTION GetMenuItemRefCon2(inMenu: MenuRef; inItem: SInt16; VAR outRefCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0512, $A825;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION SetMenuItemKeyGlyph(inMenu: MenuRef; inItem: SInt16; inGlyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0513, $A825;
	{$ENDC}
FUNCTION GetMenuItemKeyGlyph(inMenu: MenuRef; inItem: SInt16; VAR outGlyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0514, $A825;
	{$ENDC}
{  Routines available in Mac OS 8.5 and later (supporting enabling/disabling of > 31 items) }

PROCEDURE EnableMenuItem(theMenu: MenuRef; item: MenuItemIndex);
PROCEDURE DisableMenuItem(theMenu: MenuRef; item: MenuItemIndex);
FUNCTION IsMenuItemEnabled(menu: MenuRef; item: MenuItemIndex): BOOLEAN;
PROCEDURE EnableMenuItemIcon(theMenu: MenuRef; item: MenuItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $A825;
	{$ENDC}
PROCEDURE DisableMenuItemIcon(theMenu: MenuRef; item: MenuItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0020, $A825;
	{$ENDC}
FUNCTION IsMenuItemIconEnabled(menu: MenuRef; item: MenuItemIndex): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $A825;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Item Color Tables                                                            }
{                                                                                      }
{  Menu color manipulation is considered deprecated with the advent of the Appearance  }
{  Manager.  Avoid using these routines if possible                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE DeleteMCEntries(menuID: MenuID; menuItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA60;
	{$ENDC}
FUNCTION GetMCInfo: MCTableHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA61;
	{$ENDC}
PROCEDURE SetMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA62;
	{$ENDC}
PROCEDURE DisposeMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA63;
	{$ENDC}
FUNCTION GetMCEntry(menuID: MenuID; menuItem: INTEGER): MCEntryPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA64;
	{$ENDC}
PROCEDURE SetMCEntries(numEntries: INTEGER; menuCEntries: MCTablePtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA65;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Properties  (Mac OS 8.5 and later)                                                 }
{                                                                                      }
{ With the following property APIs, you can attach any piece of data you'd like to a   }
{ menu or menu item. Passing zero for the item number parameter indicates you'd like   }
{ to attach the data to the menu itself, and not to any specific menu item.            }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kMenuPropertyPersistent		= $00000001;					{  whether this property gets saved when flattening the menu }

FUNCTION GetMenuItemProperty(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; bufferSize: UInt32; VAR actualSize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;
FUNCTION GetMenuItemPropertySize(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; VAR size: UInt32): OSStatus;
FUNCTION SetMenuItemProperty(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; propertySize: UInt32; propertyData: UNIV Ptr): OSStatus;
FUNCTION RemoveMenuItemProperty(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType): OSStatus;
FUNCTION GetMenuItemPropertyAttributes(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; VAR attributes: UInt32): OSStatus;
FUNCTION ChangeMenuItemPropertyAttributes(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; attributesToSet: UInt32; attributesToClear: UInt32): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Attributes (Carbon and later)                                                     }
{                                                                                      }
{  Each menu and menu item has attribute flags.                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetMenuAttributes(menu: MenuRef; VAR outAttributes: MenuAttributes): OSStatus;
FUNCTION ChangeMenuAttributes(menu: MenuRef; setTheseAttributes: MenuAttributes; clearTheseAttributes: MenuAttributes): OSStatus;
FUNCTION GetMenuItemAttributes(menu: MenuRef; item: MenuItemIndex; VAR outAttributes: MenuItemAttributes): OSStatus;
FUNCTION ChangeMenuItemAttributes(menu: MenuRef; item: MenuItemIndex; setTheseAttributes: MenuItemAttributes; clearTheseAttributes: MenuItemAttributes): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Mass menu item enabling and disabling (Carbon and later)                          }
{                                                                                      }
{  Useful when rewriting code that whacks the enableFlags field directly.              }
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE DisableAllMenuItems(theMenu: MenuRef);
PROCEDURE EnableAllMenuItems(theMenu: MenuRef);
FUNCTION MenuHasEnabledItems(theMenu: MenuRef): BOOLEAN;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu tracking status (Carbon and later)                                           }
{                                                                                      }
{  Get info about the selected menu item during menu tracking. Replaces direct access  }
{  to low-mem globals that used to hold this info.                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetMenuTrackingData(theMenu: MenuRef; VAR outData: MenuTrackingData): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Universal command ID access (Carbon and later)                                    }
{                                                                                      }
{  These APIs allow you to operate on menu items strictly by command ID, with no       }
{  knowledge of a menu item's index.                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION CountMenuItemsWithCommandID(menu: MenuRef; commandID: MenuCommand): ItemCount;
FUNCTION GetIndMenuItemWithCommandID(menu: MenuRef; commandID: MenuCommand; itemIndex: UInt32; VAR outMenu: MenuRef; VAR outIndex: MenuItemIndex): OSStatus;
PROCEDURE EnableMenuCommand(theMenu: MenuRef; commandID: MenuCommand);
PROCEDURE DisableMenuCommand(theMenu: MenuRef; commandID: MenuCommand);
FUNCTION IsMenuCommandEnabled(menu: MenuRef; commandID: MenuCommand): BOOLEAN;
FUNCTION GetMenuCommandProperty(menu: MenuRef; commandID: MenuCommand; propertyCreator: OSType; propertyTag: OSType; bufferSize: ByteCount; VAR actualSize: ByteCount; propertyBuffer: UNIV Ptr): OSStatus;
FUNCTION GetMenuCommandPropertySize(menu: MenuRef; commandID: MenuCommand; propertyCreator: OSType; propertyTag: OSType; VAR size: ByteCount): OSStatus;
FUNCTION SetMenuCommandProperty(menu: MenuRef; commandID: MenuCommand; propertyCreator: OSType; propertyTag: OSType; propertySize: ByteCount; propertyData: UNIV Ptr): OSStatus;
FUNCTION RemoveMenuCommandProperty(menu: MenuRef; commandID: MenuCommand; propertyCreator: OSType; propertyTag: OSType): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Standard font menu (Carbon and later)                                             }
{                                                                                      }
{  These APIs allow you to create and use the standard font menu.                      }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kHierarchicalFontMenuOption	= $00000001;

FUNCTION CreateStandardFontMenu(menu: MenuRef; afterItem: MenuItemIndex; firstHierMenuID: MenuID; options: OptionBits; VAR outHierMenuCount: ItemCount): OSStatus;
FUNCTION UpdateStandardFontMenu(menu: MenuRef; VAR outHierMenuCount: ItemCount): OSStatus;
FUNCTION GetFontFamilyFromMenuSelection(menu: MenuRef; item: MenuItemIndex; VAR outFontFamily: FMFontFamily; VAR outStyle: FMFontStyle): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Contextual Menu routines and constants                                            }
{  available with Conxtextual Menu extension 1.0 and later                             }
{——————————————————————————————————————————————————————————————————————————————————————}
{ Gestalt Selector for classic 68K apps only. }
{ CFM apps should weak link and check the symbols. }

CONST
	gestaltContextualMenuAttr	= 'cmnu';
	gestaltContextualMenuUnusedBit = 0;
	gestaltContextualMenuTrapAvailable = 1;

{ Values indicating what kind of help the application supports }
	kCMHelpItemNoHelp			= 0;
	kCMHelpItemAppleGuide		= 1;
	kCMHelpItemOtherHelp		= 2;

{ Values indicating what was chosen from the menu }
	kCMNothingSelected			= 0;
	kCMMenuItemSelected			= 1;
	kCMShowHelpSelected			= 3;

FUNCTION InitContextualMenus: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA72;
	{$ENDC}
FUNCTION IsShowContextualMenuClick({CONST}VAR inEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA72;
	{$ENDC}
FUNCTION ContextualMenuSelect(inMenu: MenuRef; inGlobalLocation: Point; inReserved: BOOLEAN; inHelpType: UInt32; inHelpItemString: Str255; {CONST}VAR inSelection: AEDesc; VAR outUserSelectionType: UInt32; VAR outMenuID: SInt16; VAR outMenuItem: MenuItemIndex): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA72;
	{$ENDC}
FUNCTION ProcessIsContextualMenuClient(VAR inPSN: ProcessSerialNumber): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA72;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Contextual Menu Plugin Notes                                                      }
{                                                                                      }
{  For Mac OS X, we will support a new type of Contextual Menu Plugin: the CFM-based   }
{  plugin. Each plugin must be a separate file in the Contextual Menu Items subfolder  }
{  of the system folder. It must export two functions and has the option of exporting  }
{  a third; these three functions are virtually identical to the methods that must be  }
{  supported by a SOM-based plugin.                                                        }
{                                                                                      }
{  The required symbols must be named "ExamineContext" and "HandleSelection".          }
{  The optional symbol must be named "PostMenuCleanup".                                }
{                                                                                      }
{  The ExamineContext routine must have the following prototype:                       }
{      pascal OSStatus ExamineContext( const AEDesc* inContext,                        }
{                                      AEDescList* outCommandPairs );                  }
{                                                                                      }
{  The HandleSelection routine must have the following prototype:                      }
{      pascal OSStatus HandleSelection(    const AEDesc* inContext,                    }
{                                          SInt32 inCommandID );                       }
{                                                                                      }
{  The PostMenuCleanup routine must have the following prototype:                      }
{      pascal void PostMenuCleanup(     void );                                            }
{——————————————————————————————————————————————————————————————————————————————————————}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE AddResMenu(theMenu: MenuRef; theType: ResType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94D;
	{$ENDC}
PROCEDURE InsMenuItem(theMenu: MenuRef; itemString: Str255; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A826;
	{$ENDC}
PROCEDURE DelMenuItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A952;
	{$ENDC}
PROCEDURE SetItem(theMenu: MenuRef; item: INTEGER; itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A947;
	{$ENDC}
PROCEDURE GetItem(theMenu: MenuRef; item: INTEGER; VAR itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A946;
	{$ENDC}
FUNCTION GetMHandle(menuID: MenuID): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A949;
	{$ENDC}
PROCEDURE DelMCEntries(menuID: MenuID; menuItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA60;
	{$ENDC}
PROCEDURE DispMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA63;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ Getters }
FUNCTION GetMenuID(menu: MenuRef): MenuID;
FUNCTION GetMenuWidth(menu: MenuRef): SInt16;
FUNCTION GetMenuHeight(menu: MenuRef): SInt16;
FUNCTION GetMenuTitle(menu: MenuRef; VAR title: Str255): StringPtr;
FUNCTION GetMenuDefinition(menu: MenuRef; outDefSpec: MenuDefSpecPtr): OSStatus;
{ Setters }
PROCEDURE SetMenuID(menu: MenuRef; menuID: MenuID);
PROCEDURE SetMenuWidth(menu: MenuRef; width: SInt16);
PROCEDURE SetMenuHeight(menu: MenuRef; height: SInt16);
FUNCTION SetMenuTitle(menu: MenuRef; title: Str255): OSStatus;
FUNCTION SetMenuDefinition(menu: MenuRef; {CONST}VAR defSpec: MenuDefSpec): OSStatus;
{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}



{$IFC TARGET_OS_WIN32 }
{$ENDC}  {TARGET_OS_WIN32}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MenusIncludes}

{$ENDC} {__MENUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
