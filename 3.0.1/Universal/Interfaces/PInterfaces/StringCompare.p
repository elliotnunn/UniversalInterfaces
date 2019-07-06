{
 	File:		StringCompare.p
 
 	Contains:	Public interfaces for String Comparison and related operations
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT StringCompare;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __STRINGCOMPARE__}
{$SETC __STRINGCOMPARE__ := 1}

{$I+}
{$SETC StringCompareIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __SCRIPT__}
{$I Script.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{

	Here are the current System 7 routine names and the translations to the older forms.
	Please use the newer forms in all new code and migrate the older names out of existing
	code as maintenance permits.
	
	NEW NAME					OLD NAME					OBSOLETE FORM (no handle)
	
	CompareString (Str255)		IUCompPString (hp only)		IUCompString (hp only)
	CompareText (ptr/len)		IUMagPString				IUMagString
	IdenticalString (Str255)	IUEqualPString (hp only)	IUEqualString  (hp only)
	IdenticalText (ptr/len)		IUMagIDPString				IUMagIDString
	LanguageOrder				IULangOrder
	ScriptOrder					IUScriptOrder
	StringOrder (Str255)		IUStringOrder (hp only)
	TextOrder (ptr/len)			IUTextOrder

	RelString
	CmpString (a only)					
	EqualString (hp only)
	
	ReplaceText

}


CONST
																{  Special language code values for Language Order }
	systemCurLang				= -2;							{  current (itlbLang) lang for system script }
	systemDefLang				= -3;							{  default (table) lang for system script }
	currentCurLang				= -4;							{  current (itlbLang) lang for current script }
	currentDefLang				= -5;							{  default lang for current script }
	scriptCurLang				= -6;							{  current (itlbLang) lang for specified script }
	scriptDefLang				= -7;							{  default language for a specified script }

{  obsolete names }
	iuSystemCurLang				= -2;
	iuSystemDefLang				= -3;
	iuCurrentCurLang			= -4;
	iuCurrentDefLang			= -5;
	iuScriptCurLang				= -6;
	iuScriptDefLang				= -7;


{
   The following functions are old names, but are required for System 7 PowerPC builds
   because InterfaceLib exports these names, instead of the new ones.
}

FUNCTION IUMagPString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001A, $A9ED;
	{$ENDC}
FUNCTION IUMagIDPString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001C, $A9ED;
	{$ENDC}
FUNCTION IUTextOrder(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0022, $A9ED;
	{$ENDC}
FUNCTION IULangOrder(language1: LangCode; language2: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A9ED;
	{$ENDC}
FUNCTION IUScriptOrder(script1: ScriptCode; script2: ScriptCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001E, $A9ED;
	{$ENDC}
FUNCTION IUCompPString(aStr: ConstStr255Param; bStr: ConstStr255Param; itl2Handle: Handle): INTEGER;
FUNCTION IUEqualPString(aStr: ConstStr255Param; bStr: ConstStr255Param; itl2Handle: Handle): INTEGER;
FUNCTION IUStringOrder(aStr: ConstStr255Param; bStr: ConstStr255Param; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
{  The following are new names which are not exported by System 7 InterfaceLib for PowerPC. }
FUNCTION CompareText(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001A, $A9ED;
	{$ENDC}
FUNCTION IdenticalText(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001C, $A9ED;
	{$ENDC}
FUNCTION TextOrder(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0022, $A9ED;
	{$ENDC}
FUNCTION LanguageOrder(language1: LangCode; language2: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A9ED;
	{$ENDC}
FUNCTION CompareString(aStr: Str255; bStr: Str255; itl2Handle: Handle): INTEGER;
FUNCTION IdenticalString(aStr: Str255; bStr: Str255; itl2Handle: Handle): INTEGER;
FUNCTION StringOrder(aStr: Str255; bStr: Str255; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
{
   The following new function name IS exported by InterfaceLib and works on both 68k and
   System 7 PowerPC.
}
FUNCTION ScriptOrder(script1: ScriptCode; script2: ScriptCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001E, $A9ED;
	{$ENDC}
{
   The following new function name IS exported by InterfaceLib and works on both 68k and
   System 7 PowerPC.
}
FUNCTION ReplaceText(baseText: Handle; substitutionText: Handle; VAR key: Str15): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $FFDC, $A8B5;
	{$ENDC}
FUNCTION IUMagString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000A, $A9ED;
	{$ENDC}
FUNCTION IUMagIDString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000C, $A9ED;
	{$ENDC}
FUNCTION IUCompString(aStr: ConstStr255Param; bStr: ConstStr255Param): INTEGER;
FUNCTION IUEqualString(aStr: ConstStr255Param; bStr: ConstStr255Param): INTEGER;
FUNCTION RelString(str1: ConstStr255Param; str2: ConstStr255Param; caseSensitive: BOOLEAN; diacSensitive: BOOLEAN): INTEGER;
FUNCTION EqualString(str1: ConstStr255Param; str2: ConstStr255Param; caseSensitive: BOOLEAN; diacSensitive: BOOLEAN): BOOLEAN;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StringCompareIncludes}

{$ENDC} {__STRINGCOMPARE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
