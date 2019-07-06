{
 	File:		TextUtils.p
 
 	Contains:	Text Utilities Interfaces.
 
 	Version:	Technology:	System 7.5+
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
 UNIT TextUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTUTILS__}
{$SETC __TEXTUTILS__ := 1}

{$I+}
{$SETC TextUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NUMBERFORMATTING__}
{$I NumberFormatting.p}
{$ENDC}
{$IFC UNDEFINED __STRINGCOMPARE__}
{$I StringCompare.p}
{$ENDC}
{$IFC UNDEFINED __DATETIMEUTILS__}
{$I DateTimeUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{

	Here are the current System 7 routine names and the translations to the older forms.
	Please use the newer forms in all new code and migrate the older names out of existing
	code as maintainance permits.
	
	NEW NAME					OLD NAMEs					OBSOLETE FORM (no script code)

	FindScriptRun
	FindWordBreaks											NFindWord, FindWord
	GetIndString			
	GetString
	Munger
	NewString				
	SetString				
	StyledLineBreak
	TruncString
	TruncText

	UpperString ($A054)			UprString, UprText
	UppercaseText				SCUpperText (a only)		UpperText ($A456)
	LowercaseText											LwrString, LowerText, LwrText ($A056)
	StripDiacritics											StripText ($A256)
	UppercaseStripDiacritics								StripUpperText ($A656)


}

{ Type for truncWhere parameter in TruncString, TruncText }

TYPE
	TruncCode							= INTEGER;

CONST
																{  Constants for truncWhere argument in TruncString and TruncText  }
	truncEnd					= 0;							{  Truncate at end  }
	truncMiddle					= $4000;						{  Truncate in middle  }
	smTruncEnd					= 0;							{  Truncate at end - obsolete  }
	smTruncMiddle				= $4000;						{  Truncate in middle - obsolete  }

																{  Constants for TruncString and TruncText results  }
	notTruncated				= 0;							{  No truncation was necessary  }
	truncated					= 1;							{  Truncation performed  }
	truncErr					= -1;							{  General error  }
	smNotTruncated				= 0;							{  No truncation was necessary - obsolete  }
	smTruncated					= 1;							{  Truncation performed	- obsolete  }
	smTruncErr					= -1;							{  General error - obsolete  }


TYPE
	StyledLineBreakCode					= SInt8;

CONST
	smBreakWord					= 0;
	smBreakChar					= 1;
	smBreakOverflow				= 2;


TYPE
	ScriptRunStatusPtr = ^ScriptRunStatus;
	ScriptRunStatus = RECORD
		script:					SInt8;
		runVariant:				SInt8;
	END;

	BreakTablePtr = ^BreakTable;
	BreakTable = RECORD
		charTypes:				PACKED ARRAY [0..255] OF CHAR;
		tripleLength:			INTEGER;
		triples:				ARRAY [0..0] OF INTEGER;
	END;

	NBreakTablePtr = ^NBreakTable;
	NBreakTable = RECORD
		flags1:					SInt8;
		flags2:					SInt8;
		version:				INTEGER;
		classTableOff:			INTEGER;
		auxCTableOff:			INTEGER;
		backwdTableOff:			INTEGER;
		forwdTableOff:			INTEGER;
		doBackup:				INTEGER;
		length:					INTEGER;								{  length of NBreakTable  }
		charTypes:				PACKED ARRAY [0..255] OF CHAR;
		tables:					ARRAY [0..0] OF INTEGER;
	END;

{  The following functions are new names that work on 68k and PowerPC }
FUNCTION Munger(h: Handle; offset: LONGINT; ptr1: UNIV Ptr; len1: LONGINT; ptr2: UNIV Ptr; len2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9E0;
	{$ENDC}
FUNCTION NewString(theString: Str255): StringHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A906;
	{$ENDC}
PROCEDURE SetString(theString: StringHandle; strNew: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A907;
	{$ENDC}
FUNCTION GetString(stringID: INTEGER): StringHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BA;
	{$ENDC}
PROCEDURE GetIndString(VAR theString: Str255; strListID: INTEGER; index: INTEGER);
FUNCTION StyledLineBreak(textPtr: Ptr; textLen: LONGINT; textStart: LONGINT; textEnd: LONGINT; flags: LONGINT; VAR textWidth: Fixed; VAR textOffset: LONGINT): StyledLineBreakCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $821C, $FFFE, $A8B5;
	{$ENDC}
FUNCTION TruncString(width: INTEGER; VAR theString: Str255; truncWhere: TruncCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8208, $FFE0, $A8B5;
	{$ENDC}
FUNCTION TruncText(width: INTEGER; textPtr: Ptr; VAR length: INTEGER; truncWhere: TruncCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $FFDE, $A8B5;
	{$ENDC}
PROCEDURE FindWordBreaks(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; breaks: BreakTablePtr; VAR offsets: OffsetTable; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $C012, $001A, $A8B5;
	{$ENDC}
PROCEDURE LowercaseText(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0000, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
PROCEDURE UppercaseText(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0400, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
PROCEDURE StripDiacritics(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0200, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
PROCEDURE UppercaseStripDiacritics(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0600, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
FUNCTION FindScriptRun(textPtr: Ptr; textLen: LONGINT; VAR lenUsed: LONGINT): ScriptRunStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $0026, $A8B5;
	{$ENDC}
{
  	The following functions are old names, but are required for PowerPC builds
  	because InterfaceLib exports these names, instead of the new ones.
}

PROCEDURE FindWord(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; breaks: BreakTablePtr; VAR offsets: OffsetTable);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8012, $001A, $A8B5;
	{$ENDC}
PROCEDURE NFindWord(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; nbreaks: NBreakTablePtr; VAR offsets: OffsetTable);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8012, $FFE2, $A8B5;
	{$ENDC}
{
   On 68K machines, LwrText, LowerText, StripText, UpperText and StripUpperText
   return an error code in register D0, but System 7 PowerMacs do not emulate
   this properly, so checking D0 is unreliable.
}

PROCEDURE LwrText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A056;
	{$ENDC}
PROCEDURE LowerText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A056;
	{$ENDC}
PROCEDURE StripText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A256;
	{$ENDC}
PROCEDURE UpperText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A456;
	{$ENDC}
PROCEDURE StripUpperText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A656;
	{$ENDC}

{  The following are new names which are exported by InterfaceLib }

PROCEDURE UpperString(VAR theString: Str255; diacSensitive: BOOLEAN);
{  Old routine name but no new names are mapped to it: }
PROCEDURE UprText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A054;
	{$ENDC}
{

	Functions for converting between C and Pascal Strings
	(Previously in Strings.h)
	
}
PROCEDURE C2PStrProc(aStr: UNIV Ptr);
FUNCTION C2PStr(cString: UNIV Ptr): StringPtr;
PROCEDURE P2CStrProc(aStr: StringPtr);
FUNCTION P2CStr(pString: StringPtr): Ptr;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextUtilsIncludes}

{$ENDC} {__TEXTUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
