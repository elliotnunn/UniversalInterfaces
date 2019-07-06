{
 	File:		Icons.p
 
 	Contains:	Icon Utilities Interfaces.
 
 	Version:	Technology:	System 8
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc. All rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Icons;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ICONS__}
{$SETC __ICONS__ := 1}

{$I+}
{$SETC IconsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  The following are icons for which there are both icon suites and SICNs.  }
	kGenericDocumentIconResource = -4000;
	kGenericStationeryIconResource = -3985;
	kGenericEditionFileIconResource = -3989;
	kGenericApplicationIconResource = -3996;
	kGenericDeskAccessoryIconResource = -3991;
	kGenericFolderIconResource	= -3999;
	kPrivateFolderIconResource	= -3994;
	kFloppyIconResource			= -3998;
	kTrashIconResource			= -3993;
	kGenericRAMDiskIconResource	= -3988;
	kGenericCDROMIconResource	= -3987;						{  The following are icons for which there are SICNs only.  }
	kDesktopIconResource		= -3992;
	kOpenFolderIconResource		= -3997;
	kGenericHardDiskIconResource = -3995;
	kGenericFileServerIconResource = -3972;
	kGenericSuitcaseIconResource = -3970;
	kGenericMoverObjectIconResource = -3969;					{  The following are icons for which there are icon suites only.  }
	kGenericPreferencesIconResource = -3971;
	kGenericQueryDocumentIconResource = -16506;
	kGenericExtensionIconResource = -16415;
	kSystemFolderIconResource	= -3983;
	kAppleMenuFolderIconResource = -3982;

																{  Obsolete. Use named constants defined above.  }
	genericDocumentIconResource	= -4000;
	genericStationeryIconResource = -3985;
	genericEditionFileIconResource = -3989;
	genericApplicationIconResource = -3996;
	genericDeskAccessoryIconResource = -3991;
	genericFolderIconResource	= -3999;
	privateFolderIconResource	= -3994;
	floppyIconResource			= -3998;
	trashIconResource			= -3994;
	genericRAMDiskIconResource	= -3988;
	genericCDROMIconResource	= -3987;
	desktopIconResource			= -3992;
	openFolderIconResource		= -3997;
	genericHardDiskIconResource	= -3995;
	genericFileServerIconResource = -3972;
	genericSuitcaseIconResource	= -3970;
	genericMoverObjectIconResource = -3969;
	genericPreferencesIconResource = -3971;
	genericQueryDocumentIconResource = -16506;
	genericExtensionIconResource = -16415;
	systemFolderIconResource	= -3983;
	appleMenuFolderIconResource	= -3982;

	kStartupFolderIconResource	= -3981;
	kOwnedFolderIconResource	= -3980;
	kDropFolderIconResource		= -3979;
	kSharedFolderIconResource	= -3978;
	kMountedFolderIconResource	= -3977;
	kControlPanelFolderIconResource = -3976;
	kPrintMonitorFolderIconResource = -3975;
	kPreferencesFolderIconResource = -3974;
	kExtensionsFolderIconResource = -3973;
	kFontsFolderIconResource	= -3968;
	kFullTrashIconResource		= -3984;

																{  Obsolete. Use named constants defined above.  }
	startupFolderIconResource	= -3981;
	ownedFolderIconResource		= -3980;
	dropFolderIconResource		= -3979;
	sharedFolderIconResource	= -3978;
	mountedFolderIconResource	= -3977;
	controlPanelFolderIconResource = -3976;
	printMonitorFolderIconResource = -3975;
	preferencesFolderIconResource = -3974;
	extensionsFolderIconResource = -3973;
	fontsFolderIconResource		= -3968;
	fullTrashIconResource		= -3984;

	kLarge1BitMask				= 'ICN#';
	kLarge4BitData				= 'icl4';
	kLarge8BitData				= 'icl8';
	kSmall1BitMask				= 'ics#';
	kSmall4BitData				= 'ics4';
	kSmall8BitData				= 'ics8';
	kMini1BitMask				= 'icm#';
	kMini4BitData				= 'icm4';
	kMini8BitData				= 'icm8';

																{  Obsolete. Use names defined above.  }
	large1BitMask				= 'ICN#';
	large4BitData				= 'icl4';
	large8BitData				= 'icl8';
	small1BitMask				= 'ics#';
	small4BitData				= 'ics4';
	small8BitData				= 'ics8';
	mini1BitMask				= 'icm#';
	mini4BitData				= 'icm4';
	mini8BitData				= 'icm8';

{  alignment type values }
	kAlignNone					= $00;
	kAlignVerticalCenter		= $01;
	kAlignTop					= $02;
	kAlignBottom				= $03;
	kAlignHorizontalCenter		= $04;
	kAlignAbsoluteCenter		= $05;
	kAlignCenterTop				= $06;
	kAlignCenterBottom			= $07;
	kAlignLeft					= $08;
	kAlignCenterLeft			= $09;
	kAlignTopLeft				= $0A;
	kAlignBottomLeft			= $0B;
	kAlignRight					= $0C;
	kAlignCenterRight			= $0D;
	kAlignTopRight				= $0E;
	kAlignBottomRight			= $0F;

																{  Obsolete. Use names defined above.  }
	atNone						= $00;
	atVerticalCenter			= $01;
	atTop						= $02;
	atBottom					= $03;
	atHorizontalCenter			= $04;
	atAbsoluteCenter			= $05;
	atCenterTop					= $06;
	atCenterBottom				= $07;
	atLeft						= $08;
	atCenterLeft				= $09;
	atTopLeft					= $0A;
	atBottomLeft				= $0B;
	atRight						= $0C;
	atCenterRight				= $0D;
	atTopRight					= $0E;
	atBottomRight				= $0F;


TYPE
	IconAlignmentType					= SInt16;
{  transform type values  }

CONST
	kTransformNone				= $00;
	kTransformDisabled			= $01;
	kTransformOffline			= $02;
	kTransformOpen				= $03;
	kTransformLabel1			= $0100;
	kTransformLabel2			= $0200;
	kTransformLabel3			= $0300;
	kTransformLabel4			= $0400;
	kTransformLabel5			= $0500;
	kTransformLabel6			= $0600;
	kTransformLabel7			= $0700;
	kTransformSelected			= $4000;
	kTransformSelectedDisabled	= $4001;
	kTransformSelectedOffline	= $4002;
	kTransformSelectedOpen		= $4003;

																{  Obsolete. Use names defined above.  }
	ttNone						= $00;
	ttDisabled					= $01;
	ttOffline					= $02;
	ttOpen						= $03;
	ttLabel1					= $0100;
	ttLabel2					= $0200;
	ttLabel3					= $0300;
	ttLabel4					= $0400;
	ttLabel5					= $0500;
	ttLabel6					= $0600;
	ttLabel7					= $0700;
	ttSelected					= $4000;
	ttSelectedDisabled			= $4001;
	ttSelectedOffline			= $4002;
	ttSelectedOpen				= $4003;


TYPE
	IconTransformType					= SInt16;
{  Selector mask values  }

CONST
	kSelectorLarge1Bit			= $00000001;
	kSelectorLarge4Bit			= $00000002;
	kSelectorLarge8Bit			= $00000004;
	kSelectorSmall1Bit			= $00000100;
	kSelectorSmall4Bit			= $00000200;
	kSelectorSmall8Bit			= $00000400;
	kSelectorMini1Bit			= $00010000;
	kSelectorMini4Bit			= $00020000;
	kSelectorMini8Bit			= $00040000;
	kSelectorAllLargeData		= $000000FF;
	kSelectorAllSmallData		= $0000FF00;
	kSelectorAllMiniData		= $00FF0000;
	kSelectorAll1BitData		= $00010101;
	kSelectorAll4BitData		= $00020202;
	kSelectorAll8BitData		= $00040404;
	kSelectorAllAvailableData	= $FFFFFFFF;

																{  Obsolete. Use names defined above.  }
	svLarge1Bit					= $00000001;
	svLarge4Bit					= $00000002;
	svLarge8Bit					= $00000004;
	svSmall1Bit					= $00000100;
	svSmall4Bit					= $00000200;
	svSmall8Bit					= $00000400;
	svMini1Bit					= $00010000;
	svMini4Bit					= $00020000;
	svMini8Bit					= $00040000;
	svAllLargeData				= $000000FF;
	svAllSmallData				= $0000FF00;
	svAllMiniData				= $00FF0000;
	svAll1BitData				= $00010101;
	svAll4BitData				= $00020202;
	svAll8BitData				= $00040404;
	svAllAvailableData			= $FFFFFFFF;


TYPE
	IconSelectorValue					= UInt32;
	IconActionProcPtr = ProcPtr;  { FUNCTION IconAction(theType: ResType; VAR theIcon: Handle; yourDataPtr: UNIV Ptr): OSErr; }

	IconActionUPP = UniversalProcPtr;

CONST
	uppIconActionProcInfo = $00000FE0;

FUNCTION NewIconActionProc(userRoutine: IconActionProcPtr): IconActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallIconActionProc(theType: ResType; VAR theIcon: Handle; yourDataPtr: UNIV Ptr; userRoutine: IconActionUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	IconAction							= IconActionProcPtr;
	IconGetterProcPtr = ProcPtr;  { FUNCTION IconGetter(theType: ResType; yourDataPtr: UNIV Ptr): Handle; }

	IconGetterUPP = UniversalProcPtr;

CONST
	uppIconGetterProcInfo = $000003F0;

FUNCTION NewIconGetterProc(userRoutine: IconGetterProcPtr): IconGetterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallIconGetterProc(theType: ResType; yourDataPtr: UNIV Ptr; userRoutine: IconGetterUPP): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	IconGetter							= IconGetterProcPtr;
{$IFC NOT OLDROUTINELOCATIONS }
	CIconPtr = ^CIcon;
	CIcon = RECORD
		iconPMap:				PixMap;									{ the icon's pixMap }
		iconMask:				BitMap;									{ the icon's mask }
		iconBMap:				BitMap;									{ the icon's bitMap }
		iconData:				Handle;									{ the icon's data }
		iconMaskData:			ARRAY [0..0] OF SInt16;					{ icon's mask and BitMap data }
	END;

	CIconHandle							= ^CIconPtr;
FUNCTION GetCIcon(iconID: SInt16): CIconHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1E;
	{$ENDC}
PROCEDURE PlotCIcon({CONST}VAR theRect: Rect; theIcon: CIconHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1F;
	{$ENDC}
PROCEDURE DisposeCIcon(theIcon: CIconHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA25;
	{$ENDC}
{$ENDC}

FUNCTION GetIcon(iconID: SInt16): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BB;
	{$ENDC}
PROCEDURE PlotIcon({CONST}VAR theRect: Rect; theIcon: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94B;
	{$ENDC}


{
	Note:	IconSuiteRef and IconCacheRef should be an abstract types, 
			but too much source code already relies on them being of type Handle.
}

TYPE
	IconSuiteRef						= Handle;
	IconCacheRef						= Handle;

FUNCTION PlotIconID({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theResID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0500, $ABC9;
	{$ENDC}
FUNCTION NewIconSuite(VAR theIconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0207, $ABC9;
	{$ENDC}
FUNCTION AddIconToSuite(theIconData: Handle; theSuite: IconSuiteRef; theType: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0608, $ABC9;
	{$ENDC}
FUNCTION GetIconFromSuite(VAR theIconData: Handle; theSuite: IconSuiteRef; theType: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0609, $ABC9;
	{$ENDC}
FUNCTION ForEachIconDo(theSuite: IconSuiteRef; selector: IconSelectorValue; action: IconActionUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $080A, $ABC9;
	{$ENDC}
FUNCTION GetIconSuite(VAR theIconSuite: IconSuiteRef; theResID: SInt16; selector: IconSelectorValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $ABC9;
	{$ENDC}
FUNCTION DisposeIconSuite(theIconSuite: IconSuiteRef; disposeData: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0302, $ABC9;
	{$ENDC}
FUNCTION PlotIconSuite({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0603, $ABC9;
	{$ENDC}
FUNCTION MakeIconCache(VAR theCache: IconCacheRef; makeIcon: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0604, $ABC9;
	{$ENDC}
FUNCTION LoadIconCache({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconCache: IconCacheRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $ABC9;
	{$ENDC}
FUNCTION PlotIconMethod({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0805, $ABC9;
	{$ENDC}
FUNCTION GetLabel(labelNumber: SInt16; VAR labelColor: RGBColor; VAR labelString: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $ABC9;
	{$ENDC}
FUNCTION PtInIconID(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060D, $ABC9;
	{$ENDC}
FUNCTION PtInIconSuite(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: IconSuiteRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $070E, $ABC9;
	{$ENDC}
FUNCTION PtInIconMethod(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $090F, $ABC9;
	{$ENDC}
FUNCTION RectInIconID({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0610, $ABC9;
	{$ENDC}
FUNCTION RectInIconSuite({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: IconSuiteRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0711, $ABC9;
	{$ENDC}
FUNCTION RectInIconMethod({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0912, $ABC9;
	{$ENDC}
FUNCTION IconIDToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0613, $ABC9;
	{$ENDC}
FUNCTION IconSuiteToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0714, $ABC9;
	{$ENDC}
FUNCTION IconMethodToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0915, $ABC9;
	{$ENDC}
FUNCTION SetSuiteLabel(theSuite: IconSuiteRef; theLabel: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0316, $ABC9;
	{$ENDC}
FUNCTION GetSuiteLabel(theSuite: IconSuiteRef): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0217, $ABC9;
	{$ENDC}
FUNCTION GetIconCacheData(theCache: IconCacheRef; VAR theData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0419, $ABC9;
	{$ENDC}
FUNCTION SetIconCacheData(theCache: IconCacheRef; theData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041A, $ABC9;
	{$ENDC}
FUNCTION GetIconCacheProc(theCache: IconCacheRef; VAR theProc: IconGetterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041B, $ABC9;
	{$ENDC}
FUNCTION SetIconCacheProc(theCache: IconCacheRef; theProc: IconGetterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041C, $ABC9;
	{$ENDC}
FUNCTION PlotIconHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIcon: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061D, $ABC9;
	{$ENDC}
FUNCTION PlotSICNHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theSICN: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061E, $ABC9;
	{$ENDC}
FUNCTION PlotCIconHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theCIcon: CIconHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061F, $ABC9;
	{$ENDC}












{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IconsIncludes}

{$ENDC} {__ICONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
