{
 	File:		Menus.p
 
 	Contains:	Menu Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Menu Types (for Appearance 1.0 and later)											}
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
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

{  —— end of Appearance 1.0 types }

	noMark						= 0;							{ mark symbol for MarkItem }

																{  menu defProc messages  }
	kMenuDrawMsg				= 0;
	kMenuChooseMsg				= 1;
	kMenuSizeMsg				= 2;
	kMenuDrawItemMsg			= 4;
	kMenuCalcItemMsg			= 5;
	kMenuThemeSavvyMsg			= 7;							{  is your MDEF theme-savvy?  If so, return hex 7473 in the whichItem parameter }
	mDrawMsg					= 0;
	mChooseMsg					= 1;
	mSizeMsg					= 2;
	mDrawItemMsg				= 4;
	mCalcItemMsg				= 5;

	kThemeSavvyMenuResponse		= $7473;

	textMenuProc				= 0;
	hMenuCmd					= 27;							{ itemCmd == 0x001B ==> hierarchical menu }
	hierMenu					= -1;							{ a hierarchical menu - for InsertMenu call }
	mPopUpMsg					= 3;							{ menu defProc messages - place yourself }
	mctAllItems					= -98;							{ search for all Items for the given ID }
	mctLastIDIndic				= -99;							{ last color table entry has this in ID field }



TYPE
	MenuInfoPtr = ^MenuInfo;
	MenuInfo = RECORD
		menuID:					INTEGER;
		menuWidth:				INTEGER;
		menuHeight:				INTEGER;
		menuProc:				Handle;
		enableFlags:			LONGINT;
		menuData:				Str255;
	END;

	MenuPtr								= ^MenuInfo;
	MenuHandle							= ^MenuPtr;
{  MenuRef is obsolete.  Use MenuHandle.  }
	MenuRef								= MenuHandle;
	MCEntryPtr = ^MCEntry;
	MCEntry = RECORD
		mctID:					INTEGER;								{ menu ID.  ID = 0 is the menu bar }
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
{$ENDC}  {TARGET_OS_WIN32}

{$IFC TYPED_FUNCTION_POINTERS}
	MenuDefProcPtr = PROCEDURE(message: INTEGER; theMenu: MenuHandle; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER);
{$ELSEC}
	MenuDefProcPtr = ProcPtr;
{$ENDC}

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

	MenuDefUPP = UniversalProcPtr;
	MenuBarDefUPP = UniversalProcPtr;
	MenuHookUPP = UniversalProcPtr;
	MBarHookUPP = UniversalProcPtr;

CONST
	uppMenuDefProcInfo = $0000FF80;
	uppMenuBarDefProcInfo = $00003AB0;
	uppMenuHookProcInfo = $00000000;
	uppMBarHookProcInfo = $000000CF;

FUNCTION NewMenuDefProc(userRoutine: MenuDefProcPtr): MenuDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuBarDefProc(userRoutine: MenuBarDefProcPtr): MenuBarDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuHookProc(userRoutine: MenuHookProcPtr): MenuHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMBarHookProc(userRoutine: MBarHookProcPtr): MBarHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMenuDefProc(message: INTEGER; theMenu: MenuHandle; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER; userRoutine: MenuDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMenuBarDefProc(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT; userRoutine: MenuBarDefUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMenuHookProc(userRoutine: MenuHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMBarHookProc(VAR menuRect: Rect; userRoutine: MBarHookUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION GetMBarHeight: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BAA;
	{$ENDC}
PROCEDURE InitMenus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A930;
	{$ENDC}
FUNCTION NewMenu(menuID: INTEGER; menuTitle: Str255): MenuHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A931;
	{$ENDC}
FUNCTION GetMenu(resourceID: INTEGER): MenuHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BF;
	{$ENDC}
PROCEDURE DisposeMenu(theMenu: MenuHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A932;
	{$ENDC}
PROCEDURE AppendMenu(menu: MenuHandle; data: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A933;
	{$ENDC}
PROCEDURE InsertResMenu(theMenu: MenuHandle; theType: ResType; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A951;
	{$ENDC}
PROCEDURE InsertMenu(theMenu: MenuHandle; beforeID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A935;
	{$ENDC}
PROCEDURE DeleteMenu(menuID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A936;
	{$ENDC}
PROCEDURE AppendResMenu(theMenu: MenuHandle; theType: ResType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94D;
	{$ENDC}
PROCEDURE InsertMenuItem(theMenu: MenuHandle; itemString: Str255; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A826;
	{$ENDC}
PROCEDURE DeleteMenuItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A952;
	{$ENDC}
FUNCTION MenuKey(ch: CharParameter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93E;
	{$ENDC}
PROCEDURE HiliteMenu(menuID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A938;
	{$ENDC}
PROCEDURE SetMenuItemText(theMenu: MenuHandle; item: INTEGER; itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A947;
	{$ENDC}
PROCEDURE GetMenuItemText(theMenu: MenuHandle; item: INTEGER; VAR itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A946;
	{$ENDC}
PROCEDURE SetItemMark(theMenu: MenuHandle; item: INTEGER; markChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A944;
	{$ENDC}
PROCEDURE GetItemMark(theMenu: MenuHandle; item: INTEGER; VAR markChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A943;
	{$ENDC}
PROCEDURE SetItemCmd(theMenu: MenuHandle; item: INTEGER; cmdChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84F;
	{$ENDC}
PROCEDURE GetItemCmd(theMenu: MenuHandle; item: INTEGER; VAR cmdChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84E;
	{$ENDC}
PROCEDURE SetItemIcon(theMenu: MenuHandle; item: INTEGER; iconIndex: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A940;
	{$ENDC}
PROCEDURE GetItemIcon(theMenu: MenuHandle; item: INTEGER; VAR iconIndex: Byte);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93F;
	{$ENDC}
PROCEDURE SetItemStyle(theMenu: MenuHandle; item: INTEGER; chStyle: StyleParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A942;
	{$ENDC}
PROCEDURE GetItemStyle(theMenu: MenuHandle; item: INTEGER; VAR chStyle: Style);
FUNCTION GetMenuHandle(menuID: INTEGER): MenuHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A949;
	{$ENDC}
PROCEDURE CalcMenuSize(theMenu: MenuHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A948;
	{$ENDC}
PROCEDURE DisableItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93A;
	{$ENDC}
PROCEDURE EnableItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A939;
	{$ENDC}
PROCEDURE FlashMenuBar(menuID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94C;
	{$ENDC}
FUNCTION PopUpMenuSelect(menu: MenuHandle; top: INTEGER; left: INTEGER; popUpItem: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80B;
	{$ENDC}
FUNCTION MenuChoice: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA66;
	{$ENDC}
PROCEDURE DeleteMCEntries(menuID: INTEGER; menuItem: INTEGER);
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
FUNCTION GetMCEntry(menuID: INTEGER; menuItem: INTEGER): MCEntryPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA64;
	{$ENDC}
PROCEDURE SetMCEntries(numEntries: INTEGER; menuCEntries: MCTablePtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA65;
	{$ENDC}
PROCEDURE DrawMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A937;
	{$ENDC}
PROCEDURE InvalMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81D;
	{$ENDC}
PROCEDURE InitProcMenu(resID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A808;
	{$ENDC}
FUNCTION GetMenuBar: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93B;
	{$ENDC}
PROCEDURE SetMenuBar(menuList: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93C;
	{$ENDC}
FUNCTION SystemEdit(editCmd: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C2;
	{$ENDC}
PROCEDURE SystemMenu(menuResult: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B5;
	{$ENDC}
FUNCTION GetNewMBar(menuBarID: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C0;
	{$ENDC}
PROCEDURE ClearMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A934;
	{$ENDC}
PROCEDURE CheckItem(theMenu: MenuHandle; item: INTEGER; checked: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A945;
	{$ENDC}
FUNCTION CountMItems(theMenu: MenuHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A950;
	{$ENDC}
PROCEDURE SetMenuFlash(count: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94A;
	{$ENDC}
FUNCTION MenuSelect(startPt: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93D;
	{$ENDC}
PROCEDURE InsertFontResMenu(theMenu: MenuHandle; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0400, $A825;
	{$ENDC}
PROCEDURE InsertIntlResMenu(theMenu: MenuHandle; theType: ResType; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0601, $A825;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Appearance 1.0 and later Menu Manager routines									}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION MenuEvent({CONST}VAR inEvent: EventRecord): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $A825;
	{$ENDC}
FUNCTION SetMenuItemCommandID(inMenu: MenuHandle; inItem: SInt16; inCommandID: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0502, $A825;
	{$ENDC}
FUNCTION GetMenuItemCommandID(inMenu: MenuHandle; inItem: SInt16; VAR outCommandID: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0503, $A825;
	{$ENDC}
FUNCTION SetMenuItemModifiers(inMenu: MenuHandle; inItem: SInt16; inModifiers: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $A825;
	{$ENDC}
FUNCTION GetMenuItemModifiers(inMenu: MenuHandle; inItem: SInt16; VAR outModifiers: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0505, $A825;
	{$ENDC}
FUNCTION SetMenuItemIconHandle(inMenu: MenuHandle; inItem: SInt16; inIconType: ByteParameter; inIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $A825;
	{$ENDC}
FUNCTION GetMenuItemIconHandle(inMenu: MenuHandle; inItem: SInt16; VAR outIconType: UInt8; VAR outIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0707, $A825;
	{$ENDC}
FUNCTION SetMenuItemTextEncoding(inMenu: MenuHandle; inItem: SInt16; inScriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $A825;
	{$ENDC}
FUNCTION GetMenuItemTextEncoding(inMenu: MenuHandle; inItem: SInt16; VAR outScriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0509, $A825;
	{$ENDC}
FUNCTION SetMenuItemHierarchicalID(inMenu: MenuHandle; inItem: SInt16; inHierID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $A825;
	{$ENDC}
FUNCTION GetMenuItemHierarchicalID(inMenu: MenuHandle; inItem: SInt16; VAR outHierID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050E, $A825;
	{$ENDC}
FUNCTION SetMenuItemFontID(inMenu: MenuHandle; inItem: SInt16; inFontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $A825;
	{$ENDC}
FUNCTION GetMenuItemFontID(inMenu: MenuHandle; inItem: SInt16; VAR outFontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $A825;
	{$ENDC}
FUNCTION SetMenuItemRefCon(inMenu: MenuHandle; inItem: SInt16; inRefCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050A, $A825;
	{$ENDC}
FUNCTION GetMenuItemRefCon(inMenu: MenuHandle; inItem: SInt16; VAR outRefCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $A825;
	{$ENDC}
FUNCTION SetMenuItemRefCon2(inMenu: MenuHandle; inItem: SInt16; inRefCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $A825;
	{$ENDC}
FUNCTION GetMenuItemRefCon2(inMenu: MenuHandle; inItem: SInt16; VAR outRefCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0512, $A825;
	{$ENDC}
FUNCTION SetMenuItemKeyGlyph(inMenu: MenuHandle; inItem: SInt16; inGlyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0513, $A825;
	{$ENDC}
FUNCTION GetMenuItemKeyGlyph(inMenu: MenuHandle; inItem: SInt16; VAR outGlyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0514, $A825;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Contextual Menu routines and constants											}
{	available with Conxtextual Menu extension 1.0 and later								}
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
FUNCTION ContextualMenuSelect(inMenu: MenuHandle; inGlobalLocation: Point; inReserved: BOOLEAN; inHelpType: UInt32; inHelpItemString: Str255; {CONST}VAR inSelection: AEDesc; VAR outUserSelectionType: UInt32; VAR outMenuID: SInt16; VAR outMenuItem: UInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA72;
	{$ENDC}
FUNCTION ProcessIsContextualMenuClient(VAR inPSN: ProcessSerialNumber): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA72;
	{$ENDC}



{$IFC OLDROUTINENAMES }
PROCEDURE AddResMenu(theMenu: MenuHandle; theType: ResType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94D;
	{$ENDC}
PROCEDURE InsMenuItem(theMenu: MenuHandle; itemString: Str255; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A826;
	{$ENDC}
PROCEDURE DelMenuItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A952;
	{$ENDC}
PROCEDURE SetItem(theMenu: MenuHandle; item: INTEGER; itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A947;
	{$ENDC}
PROCEDURE GetItem(theMenu: MenuHandle; item: INTEGER; VAR itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A946;
	{$ENDC}
FUNCTION GetMHandle(menuID: INTEGER): MenuHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A949;
	{$ENDC}
PROCEDURE DelMCEntries(menuID: INTEGER; menuItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA60;
	{$ENDC}
PROCEDURE DispMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA63;
	{$ENDC}
{$ENDC}  {OLDROUTINENAMES}



{$IFC TARGET_OS_WIN32 }
{$ENDC}  {TARGET_OS_WIN32}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MenusIncludes}

{$ENDC} {__MENUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
