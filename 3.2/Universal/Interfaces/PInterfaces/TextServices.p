{
 	File:		TextServices.p
 
 	Contains:	Text Services Manager Interfaces.
 
 	Version:	Technology:	System 8.2
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1991-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TextServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTSERVICES__}
{$SETC __TEXTSERVICES__ := 1}

{$I+}
{$SETC TextServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}
{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kTextService				= 'tsvc';						{  component type for the component description  }
	kInputMethodService			= 'inpm';						{  component subtype for the component description  }
	kTSMVersion					= $0150;						{  Version of the Text Services Manager is 1.5  }

	kUnicodeDocument			= 'udoc';						{  TSM Document type for Unicode-savvy application  }
	kUnicodeTextService			= 'utsv';						{  Component type for Unicode Text Service  }

{  Language and Script constants }
	kUnknownLanguage			= $FFFF;
	kUnknownScript				= $FFFF;
	kNeutralScript				= $FFFF;


																{  Component Flags in ComponentDescription  }
	bTakeActiveEvent			= 15;							{  bit set if the component takes active event  }
	bHandleAERecording			= 16;							{  bit set if the component takes care of recording Apple Events <new in vers2.0>  }
	bScriptMask					= $00007F00;					{  bit 8 - 14  }
	bLanguageMask				= $000000FF;					{  bit 0 - 7   }
	bScriptLanguageMask			= $00007FFF;					{  bit 0 - 14   }

																{  Typing method property constants for Input Methods  }
	kIMJaTypingMethodProperty	= 'jtyp';						{  Typing method property for Japanese input methods }
	kIMJaTypingMethodRoman		= 'roma';						{  Roman typing }
	kIMJaTypingMethodKana		= 'kana';						{  Kana typing }

																{  Low level routines which are dispatched directly to the Component Manager  }
	kCMGetScriptLangSupport		= $0001;						{  Component Manager call selector 1  }
	kCMInitiateTextService		= $0002;						{  Component Manager call selector 2  }
	kCMTerminateTextService		= $0003;						{  Component Manager call selector 3  }
	kCMActivateTextService		= $0004;						{  Component Manager call selector 4  }
	kCMDeactivateTextService	= $0005;						{  Component Manager call selector 5  }
	kCMTextServiceEvent			= $0006;						{  Component Manager call selector 6  }
	kCMGetTextServiceMenu		= $0007;						{  Component Manager call selector 7  }
	kCMTextServiceMenuSelect	= $0008;						{  Component Manager call selector 8  }
	kCMFixTextService			= $0009;						{  Component Manager call selector 9  }
	kCMSetTextServiceCursor		= $000A;						{  Component Manager call selector 10  }
	kCMHidePaletteWindows		= $000B;						{  Component Manager call selector 11  }
	kCMGetTextServiceProperty	= $000C;						{  Component Manager call selector 12  }
	kCMSetTextServiceProperty	= $000D;						{  Component Manager call selector 13  }

																{  New low level routines which are dispatched directly to the Component Manager  }
	kCMUCTextServiceEvent		= $000E;						{  Component Manager call selector 14  }



{ New opaque definitions for types }

TYPE
	TSMDocumentID = ^LONGINT;
	InterfaceTypeList					= ARRAY [0..0] OF OSType;

{ Text Service Info List }
	TextServiceInfoPtr = ^TextServiceInfo;
	TextServiceInfo = RECORD
		fComponent:				Component;
		fItemName:				Str255;
	END;

	TextServiceListPtr = ^TextServiceList;
	TextServiceList = RECORD
		fTextServiceCount:		INTEGER;								{  number of entries in the 'fServices' array  }
		fServices:				ARRAY [0..0] OF TextServiceInfo;		{  Note: array of 'TextServiceInfo' records follows  }
	END;

	TextServiceListHandle				= ^TextServiceListPtr;
	ScriptLanguageRecordPtr = ^ScriptLanguageRecord;
	ScriptLanguageRecord = RECORD
		fScript:				ScriptCode;
		fLanguage:				LangCode;
	END;

	ScriptLanguageSupportPtr = ^ScriptLanguageSupport;
	ScriptLanguageSupport = RECORD
		fScriptLanguageCount:	INTEGER;								{  number of entries in the 'fScriptLanguageArray' array  }
		fScriptLanguageArray:	ARRAY [0..0] OF ScriptLanguageRecord;	{  Note: array of 'ScriptLanguageRecord' records follows  }
	END;

	ScriptLanguageSupportHandle			= ^ScriptLanguageSupportPtr;
{ High level TSM Doucment routines }
FUNCTION NewTSMDocument(numOfInterface: INTEGER; VAR supportedInterfaceTypes: InterfaceTypeList; VAR idocID: TSMDocumentID; refcon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA54;
	{$ENDC}
FUNCTION DeleteTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA54;
	{$ENDC}
FUNCTION ActivateTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA54;
	{$ENDC}
FUNCTION DeactivateTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA54;
	{$ENDC}
FUNCTION SetTSMCursor(mousePos: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AA54;
	{$ENDC}
FUNCTION FixTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AA54;
	{$ENDC}
{ Utilities }
FUNCTION UseInputWindow(idocID: TSMDocumentID; useWindow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AA54;
	{$ENDC}
FUNCTION TSMEvent(VAR event: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA54;
	{$ENDC}
FUNCTION TSMMenuSelect(menuResult: LONGINT): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AA54;
	{$ENDC}
FUNCTION InitTSMAwareApplication: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AA54;
	{$ENDC}
FUNCTION CloseTSMAwareApplication: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AA54;
	{$ENDC}
{ Redundant Utilities }
FUNCTION SendAEFromTSMComponent({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AA54;
	{$ENDC}
FUNCTION NewServiceWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; ts: ComponentInstance; VAR window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AA54;
	{$ENDC}
FUNCTION NewCServiceWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; ts: ComponentInstance; VAR window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $AA54;
	{$ENDC}
FUNCTION CloseServiceWindow(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AA54;
	{$ENDC}
FUNCTION GetFrontServiceWindow(VAR window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $AA54;
	{$ENDC}
FUNCTION FindServiceWindow(thePoint: Point; VAR theWindow: WindowPtr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $AA54;
	{$ENDC}
FUNCTION SetDefaultInputMethod(ts: Component; VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AA54;
	{$ENDC}
FUNCTION GetDefaultInputMethod(VAR ts: Component; VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AA54;
	{$ENDC}
FUNCTION SetTextServiceLanguage(VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AA54;
	{$ENDC}
FUNCTION GetTextServiceLanguage(VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AA54;
	{$ENDC}
{ Component Manager Interfaces to Input Methods }
FUNCTION GetScriptLanguageSupport(ts: ComponentInstance; VAR scriptHdl: ScriptLanguageSupportHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION InitiateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION TerminateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ActivateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION DeactivateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION TextServiceEvent(ts: ComponentInstance; numOfEvents: INTEGER; VAR event: EventRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION UCTextServiceEvent(ts: ComponentInstance; numOfEvents: INTEGER; VAR event: EventRecord; VAR unicodeString: UniChar; unicodeStrLength: UniCharCount): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION GetTextServiceMenu(ts: ComponentInstance; VAR serviceMenu: MenuHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION TextServiceMenuSelect(ts: ComponentInstance; serviceMenu: MenuHandle; item: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION FixTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION SetTextServiceCursor(ts: ComponentInstance; mousePos: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION HidePaletteWindows(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION GetServiceList(numOfInterface: INTEGER; VAR supportedInterfaceTypes: OSType; VAR serviceInfo: TextServiceListHandle; VAR seedValue: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA54;
	{$ENDC}
FUNCTION OpenTextService(idocID: TSMDocumentID; aComponent: Component; VAR aComponentInstance: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA54;
	{$ENDC}
FUNCTION CloseTextService(idocID: TSMDocumentID; aComponentInstance: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AA54;
	{$ENDC}
FUNCTION GetTextServiceProperty(ts: ComponentInstance; propertySelector: OSType; VAR result: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION SetTextServiceProperty(ts: ComponentInstance; propertySelector: OSType; value: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000D, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextServicesIncludes}

{$ENDC} {__TEXTSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
