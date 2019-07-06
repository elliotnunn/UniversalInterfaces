{
     File:       MacHelp.p
 
     Contains:   Macintosh Help Package Interfaces.
 
     Version:    Technology: CarbonLib 1.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1998-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacHelp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACHELP__}
{$SETC __MACHELP__ := 1}

{$I+}
{$SETC MacHelpIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————}
{ Help Manager constants, etc.                                                     }
{——————————————————————————————————————————————————————————————————————————————————}
{$IFC UNDEFINED __BALLOONS__ }

CONST
	kMacHelpVersion				= $0003;
	hmBalloonHelpVersion		= $0003;						{  Backwards compatibility  }

{$ENDC}


TYPE
	HMContentRequest 			= SInt16;
CONST
	kHMSupplyContent			= 0;
	kHMDisposeContent			= 1;


TYPE
	HMContentType 				= UInt32;
CONST
	kHMNoContent				= 'none';
	kHMPascalStrContent			= 'pstr';
	kHMPictResContent			= 'pict';
	kHMStringResContent			= 'str#';
	kHMTEHandleContent			= 'txth';
	kHMPictHandleContent		= 'pcth';
	kHMTextResContent			= 'text';
	kHMStrResContent			= 'str ';
	kHMMovieContent				= 'moov';


TYPE
	HMTagDisplaySide 			= SInt16;
CONST
	kHMDefaultSide				= 0;
	kHMTopSide					= 1;
	kHMLeftSide					= 2;
	kHMBottomSide				= 3;
	kHMRightSide				= 4;
	kHMTopLeftCorner			= 5;
	kHMTopRightCorner			= 6;
	kHMLeftTopCorner			= 7;
	kHMLeftBottomCorner			= 8;
	kHMBottomLeftCorner			= 9;
	kHMBottomRightCorner		= 10;
	kHMRightTopCorner			= 11;
	kHMRightBottomCorner		= 12;


TYPE
	HMContentProvidedType 		= SInt16;
CONST
	kHMContentProvided			= 0;
	kHMContentNotProvided		= 1;
	kHMContentNotProvidedDontPropagate = 2;

	kHMMinimumContentIndex		= 0;							{  first entry in HMHelpContentRec.content is the minimum content  }
	kHMMaximumContentIndex		= 1;							{  second entry in HMHelpContentRec.content is the maximum content  }

	errHMIllegalContentForMinimumState = -10980;				{  unrecognized content type for minimum content  }
	errHMIllegalContentForMaximumState = -10981;				{  unrecognized content type for maximum content  }

{  obsolete names; will be removed }
	kHMIllegalContentForMinimumState = -10980;


{$IFC UNDEFINED __BALLOONS__ }

TYPE
	HMStringResTypePtr = ^HMStringResType;
	HMStringResType = RECORD
		hmmResID:				INTEGER;
		hmmIndex:				INTEGER;
	END;

{$ENDC}


TYPE
	HMHelpContentPtr = ^HMHelpContent;
	HMHelpContent = RECORD
		contentType:			HMContentType;
		CASE INTEGER OF
		0: (
			tagString:			Str255;									{  Pascal String }
			);
		1: (
			tagPictID:			SInt16;									{  ‘PICT' resource ID }
			);
		2: (
			tagStringRes:		HMStringResType;						{  STR# resource ID and index }
			);
		3: (
			tagTEHandle:		TEHandle;								{  TextEdit handle }
			);
		4: (
			tagPictHandle:		PicHandle;								{  Picture handle }
			);
		5: (
			tagTextRes:			SInt16;									{  TEXT/styl resource ID }
			);
		6: (
			tagStrRes:			SInt16;									{  STR resource ID }
			);
		7: (
			tagMovie:			Movie;									{  QuickTime movie }
			);
	END;

	HMHelpContentRecPtr = ^HMHelpContentRec;
	HMHelpContentRec = RECORD
		version:				SInt32;
		absHotRect:				Rect;
		tagSide:				HMTagDisplaySide;
		content:				ARRAY [0..1] OF HMHelpContent;
	END;

{——————————————————————————————————————————————————————————————————————————————————————————}
{ Callback procs                                       }
{—————————————————————————————————————————————————————————————————————————————————————————— }
{$IFC TYPED_FUNCTION_POINTERS}
	HMControlContentProcPtr = FUNCTION(inControl: ControlRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMControlContentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HMWindowContentProcPtr = FUNCTION(inWindow: WindowRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMWindowContentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HMMenuTitleContentProcPtr = FUNCTION(inMenu: MenuRef; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMMenuTitleContentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HMMenuItemContentProcPtr = FUNCTION({CONST}VAR inTrackingData: MenuTrackingData; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMMenuItemContentProcPtr = ProcPtr;
{$ENDC}

	HMControlContentUPP = UniversalProcPtr;
	HMWindowContentUPP = UniversalProcPtr;
	HMMenuTitleContentUPP = UniversalProcPtr;
	HMMenuItemContentUPP = UniversalProcPtr;

CONST
	uppHMControlContentProcInfo = $0000FBF0;
	uppHMWindowContentProcInfo = $0000FBF0;
	uppHMMenuTitleContentProcInfo = $00003EF0;
	uppHMMenuItemContentProcInfo = $00003EF0;

FUNCTION NewHMControlContentUPP(userRoutine: HMControlContentProcPtr): HMControlContentUPP; { old name was NewHMControlContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHMWindowContentUPP(userRoutine: HMWindowContentProcPtr): HMWindowContentUPP; { old name was NewHMWindowContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHMMenuTitleContentUPP(userRoutine: HMMenuTitleContentProcPtr): HMMenuTitleContentUPP; { old name was NewHMMenuTitleContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHMMenuItemContentUPP(userRoutine: HMMenuItemContentProcPtr): HMMenuItemContentUPP; { old name was NewHMMenuItemContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeHMControlContentUPP(userUPP: HMControlContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeHMWindowContentUPP(userUPP: HMWindowContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeHMMenuTitleContentUPP(userUPP: HMMenuTitleContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeHMMenuItemContentUPP(userUPP: HMMenuItemContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeHMControlContentUPP(inControl: ControlRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMControlContentUPP): OSStatus; { old name was CallHMControlContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeHMWindowContentUPP(inWindow: WindowRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMWindowContentUPP): OSStatus; { old name was CallHMWindowContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeHMMenuTitleContentUPP(inMenu: MenuRef; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMMenuTitleContentUPP): OSStatus; { old name was CallHMMenuTitleContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeHMMenuItemContentUPP({CONST}VAR inTrackingData: MenuTrackingData; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMMenuItemContentUPP): OSStatus; { old name was CallHMMenuItemContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————————}
{ API                                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Installing/Retrieving Content }
FUNCTION HMSetControlHelpContent(inControl: ControlRef; {CONST}VAR inContent: HMHelpContentRec): OSStatus;
FUNCTION HMGetControlHelpContent(inControl: ControlRef; VAR outContent: HMHelpContentRec): OSStatus;
FUNCTION HMSetWindowHelpContent(inWindow: WindowRef; {CONST}VAR inContent: HMHelpContentRec): OSStatus;
FUNCTION HMGetWindowHelpContent(inWindow: WindowRef; VAR outContent: HMHelpContentRec): OSStatus;
FUNCTION HMSetMenuItemHelpContent(inMenu: MenuRef; inItem: MenuItemIndex; {CONST}VAR inContent: HMHelpContentRec): OSStatus;
FUNCTION HMGetMenuItemHelpContent(inMenu: MenuRef; inItem: MenuItemIndex; VAR outContent: HMHelpContentRec): OSStatus;
{ Installing/Retrieving Content Callbacks }
FUNCTION HMInstallControlContentCallback(inControl: ControlRef; inContentUPP: HMControlContentUPP): OSStatus;
FUNCTION HMInstallWindowContentCallback(inWindow: WindowRef; inContentUPP: HMWindowContentUPP): OSStatus;
FUNCTION HMInstallMenuTitleContentCallback(inMenu: MenuRef; inContentUPP: HMMenuTitleContentUPP): OSStatus;
FUNCTION HMInstallMenuItemContentCallback(inMenu: MenuRef; inContentUPP: HMMenuItemContentUPP): OSStatus;

FUNCTION HMGetControlContentCallback(inControl: ControlRef; VAR outContentUPP: HMControlContentUPP): OSStatus;
FUNCTION HMGetWindowContentCallback(inWindow: WindowRef; VAR outContentUPP: HMWindowContentUPP): OSStatus;
FUNCTION HMGetMenuTitleContentCallback(inMenu: MenuRef; VAR outContentUPP: HMMenuTitleContentUPP): OSStatus;
FUNCTION HMGetMenuItemContentCallback(inMenu: MenuRef; VAR outContentUPP: HMMenuItemContentUPP): OSStatus;
{ Enabling and Disabling Help Tags }
FUNCTION HMAreHelpTagsDisplayed: BOOLEAN;
FUNCTION HMSetHelpTagsDisplayed(inDisplayTags: BOOLEAN): OSStatus;
FUNCTION HMSetTagDelay(inDelay: Duration): OSStatus;
FUNCTION HMGetTagDelay(VAR outDelay: Duration): OSStatus;
{ Compatibility }
FUNCTION HMSetMenuHelpFromBalloonRsrc(inMenu: MenuRef; inHmnuRsrcID: SInt16): OSStatus;
FUNCTION HMSetDialogHelpFromBalloonRsrc(inDialog: DialogRef; inHdlgRsrcID: SInt16; inItemStart: SInt16): OSStatus;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacHelpIncludes}

{$ENDC} {__MACHELP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
