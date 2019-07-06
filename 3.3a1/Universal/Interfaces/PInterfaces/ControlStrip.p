{
 	File:		ControlStrip.p
 
 	Contains:	Control Strip (for Powerbooks and Duos) Interfaces.
 
 	Version:	Technology:	ControlStrip 1.4
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1992-1999 by Apple Computer, Inc. All rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ControlStrip;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLSTRIP__}
{$SETC __CONTROLSTRIP__ := 1}

{$I+}
{$SETC ControlStripIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{********************************************************************************************

	messages passed to the modules

********************************************************************************************}

CONST
	sdevInitModule				= 0;							{  initialize the module }
	sdevCloseModule				= 1;							{  clean up before being closed }
	sdevFeatures				= 2;							{  return feature bits }
	sdevGetDisplayWidth			= 3;							{  returns the width of the module's display }
	sdevPeriodicTickle			= 4;							{  periodic tickle when nothing else is happening }
	sdevDrawStatus				= 5;							{  update the interface in the Control Strip }
	sdevMouseClick				= 6;							{  user clicked on the module's display area in the Control Strip }
	sdevSaveSettings			= 7;							{  saved any changed settings in module's preferences file }
	sdevShowBalloonHelp			= 8;							{  puts up a help balloon, if the module has one to display }

{********************************************************************************************

	Features supported by the module.  If a bit is set, it means that feature is supported.
	All undefined bits are reserved for future use by Apple, and should be set to zero.

********************************************************************************************}
	sdevWantMouseClicks			= 0;							{  notify the module of mouseDown events }
	sdevDontAutoTrack			= 1;							{  call the module to do mouse tracking }
	sdevHasCustomHelp			= 2;							{  module provides its own help messages }
	sdevKeepModuleLocked		= 3;							{  module needs to be locked in the heap }

{********************************************************************************************

	Result values returned by the sdevPeriodicTickle and sdevIconMouseClick selectors.
	If a bit is set, the module can request that a specific function is performed by
	the Control Strip.  A result of zero will do nothing.  All undefined bits are reserved
	for future use by Apple, and should be set to zero.

********************************************************************************************}
	sdevResizeDisplay			= 0;							{  resize the module's display }
	sdevNeedToSave				= 1;							{  need to save changed settings, when convenient }
	sdevHelpStateChange			= 2;							{  need to update the help message because of a state change }
	sdevCloseNow				= 3;							{  close a module because it doesn't want to stay around }


{********************************************************************************************

	miscellaneous

********************************************************************************************}
	sdevFileType				= 'sdev';						{  module's file type }

	sdevMenuItemMark			= $A5;							{  ‘•’: ‘checkmark’ to use in popup menus }


{ 	direction values for SBDrawBarGraph }

	BarGraphSlopeLeft			= -1;							{  max end of sloping bar graph is on the left }
	BarGraphFlatRight			= 0;							{  max end of flat bar graph is on the right }
	BarGraphSlopeRight			= 1;							{  max end of sloping bar graph is on the right }

{********************************************************************************************

	utility routines to provide standard interface elements and support for common functions

********************************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SBIsControlStripVisible: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AAF2;
	{$ENDC}
PROCEDURE SBShowHideControlStrip(showIt: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0101, $AAF2;
	{$ENDC}
FUNCTION SBSafeToAccessStartupDisk: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AAF2;
	{$ENDC}
FUNCTION SBOpenModuleResourceFile(fileCreator: OSType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0203, $AAF2;
	{$ENDC}
FUNCTION SBLoadPreferences(prefsResourceName: Str255; VAR preferences: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $AAF2;
	{$ENDC}
FUNCTION SBSavePreferences(prefsResourceName: Str255; preferences: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0405, $AAF2;
	{$ENDC}
PROCEDURE SBGetDetachedIndString(theString: StringPtr; stringList: Handle; whichString: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0506, $AAF2;
	{$ENDC}
FUNCTION SBGetDetachIconSuite(VAR theIconSuite: Handle; theResID: INTEGER; selector: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0507, $AAF2;
	{$ENDC}
FUNCTION SBTrackPopupMenu({CONST}VAR moduleRect: Rect; theMenu: MenuHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $AAF2;
	{$ENDC}
FUNCTION SBTrackSlider({CONST}VAR moduleRect: Rect; ticksOnSlider: INTEGER; initialValue: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0409, $AAF2;
	{$ENDC}
FUNCTION SBShowHelpString({CONST}VAR moduleRect: Rect; helpString: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040A, $AAF2;
	{$ENDC}
FUNCTION SBGetBarGraphWidth(barCount: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010B, $AAF2;
	{$ENDC}
PROCEDURE SBDrawBarGraph(level: INTEGER; barCount: INTEGER; direction: INTEGER; barGraphTopLeft: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050C, $AAF2;
	{$ENDC}
PROCEDURE SBModalDialogInContext(filterProc: ModalFilterUPP; VAR itemHit: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $AAF2;
	{$ENDC}
{ The following routines are available in Control Strip 1.2 and later. }
FUNCTION SBGetControlStripFontID(VAR fontID: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020E, $AAF2;
	{$ENDC}
FUNCTION SBSetControlStripFontID(fontID: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010F, $AAF2;
	{$ENDC}
FUNCTION SBGetControlStripFontSize(VAR fontSize: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $AAF2;
	{$ENDC}
FUNCTION SBSetControlStripFontSize(fontSize: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0111, $AAF2;
	{$ENDC}
FUNCTION SBGetShowHideHotKey(VAR modifiers: INTEGER; VAR keyCode: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $AAF2;
	{$ENDC}
FUNCTION SBSetShowHideHotKey(modifiers: INTEGER; keyCode: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0213, $AAF2;
	{$ENDC}
FUNCTION SBIsShowHideHotKeyEnabled(VAR enabled: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0214, $AAF2;
	{$ENDC}
FUNCTION SBEnableShowHideHotKey(enabled: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0115, $AAF2;
	{$ENDC}
{ The following routines are available in Control Strip 1.4 and later. }
FUNCTION SBHitTrackSlider({CONST}VAR moduleRect: Rect; ticksOnSlider: INTEGER; initialValue: INTEGER; VAR hit: BOOLEAN): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0616, $AAF2;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlStripIncludes}

{$ENDC} {__CONTROLSTRIP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
