{
 	File:		ASDebugging.p
 
 	Contains:	AppleScript Debugging Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1992-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ASDebugging;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ASDEBUGGING__}
{$SETC __ASDEBUGGING__ := 1}

{$I+}
{$SETC ASDebuggingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __APPLESCRIPT__}
{$I AppleScript.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*************************************************************************
	Mode Flags
*************************************************************************}
{ 	This mode flag can be passed to OSASetProperty or OSASetHandler
	and will prevent properties or handlers from being defined in a context
	that doesn't already have bindings for them. An error is returned if
	a current binding doesn't already exist. 
}

CONST
	kOSAModeDontDefine			= $0001;

{*************************************************************************
	Component Selectors
*************************************************************************}
	kASSelectSetPropertyObsolete = $1101;
	kASSelectGetPropertyObsolete = $1101;
	kASSelectSetHandlerObsolete	= $1103;
	kASSelectGetHandlerObsolete	= $1104;
	kASSelectGetAppTerminologyObsolete = $1105;
	kASSelectSetProperty		= $1106;
	kASSelectGetProperty		= $1107;
	kASSelectSetHandler			= $1108;
	kASSelectGetHandler			= $1109;
	kASSelectGetAppTerminology	= $110A;
	kASSelectGetSysTerminology	= $110B;
	kASSelectGetPropertyNames	= $110C;
	kASSelectGetHandlerNames	= $110D;

{*************************************************************************
	Context Accessors
*************************************************************************}
FUNCTION OSASetProperty(scriptingComponent: ComponentInstance; modeFlags: LONGINT; contextID: OSAID; {CONST}VAR variableName: AEDesc; scriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $1106, $7000, $A82A;
	{$ENDC}
FUNCTION OSAGetProperty(scriptingComponent: ComponentInstance; modeFlags: LONGINT; contextID: OSAID; {CONST}VAR variableName: AEDesc; VAR resultingScriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $1107, $7000, $A82A;
	{$ENDC}
FUNCTION OSAGetPropertyNames(scriptingComponent: ComponentInstance; modeFlags: LONGINT; contextID: OSAID; VAR resultingPropertyNames: AEDescList): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $110C, $7000, $A82A;
	{$ENDC}
FUNCTION OSASetHandler(scriptingComponent: ComponentInstance; modeFlags: LONGINT; contextID: OSAID; {CONST}VAR handlerName: AEDesc; compiledScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $1108, $7000, $A82A;
	{$ENDC}
FUNCTION OSAGetHandler(scriptingComponent: ComponentInstance; modeFlags: LONGINT; contextID: OSAID; {CONST}VAR handlerName: AEDesc; VAR resultingCompiledScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $1109, $7000, $A82A;
	{$ENDC}
FUNCTION OSAGetHandlerNames(scriptingComponent: ComponentInstance; modeFlags: LONGINT; contextID: OSAID; VAR resultingHandlerNames: AEDescList): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $110D, $7000, $A82A;
	{$ENDC}
FUNCTION OSAGetAppTerminology(scriptingComponent: ComponentInstance; modeFlags: LONGINT; VAR fileSpec: FSSpec; terminologyID: INTEGER; VAR didLaunch: BOOLEAN; VAR terminologyList: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $110A, $7000, $A82A;
	{$ENDC}
{ Errors:
	   errOSASystemError		operation failed
	}
FUNCTION OSAGetSysTerminology(scriptingComponent: ComponentInstance; modeFlags: LONGINT; terminologyID: INTEGER; VAR terminologyList: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $110B, $7000, $A82A;
	{$ENDC}
{ Errors:
	   errOSASystemError		operation failed
	}
{ Notes on terminology ID

	A terminology ID is derived from script code and language code
	as follows;

		terminologyID = ((scriptCode & 0x7F) << 8) | (langCode & 0xFF)
}

{*************************************************************************
	Obsolete versions provided for backward compatibility:
}
FUNCTION ASSetProperty(scriptingComponent: ComponentInstance; contextID: OSAID; {CONST}VAR variableName: AEDesc; scriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $1101, $7000, $A82A;
	{$ENDC}
FUNCTION ASGetProperty(scriptingComponent: ComponentInstance; contextID: OSAID; {CONST}VAR variableName: AEDesc; VAR resultingScriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $1102, $7000, $A82A;
	{$ENDC}
FUNCTION ASSetHandler(scriptingComponent: ComponentInstance; contextID: OSAID; {CONST}VAR handlerName: AEDesc; compiledScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $1103, $7000, $A82A;
	{$ENDC}
FUNCTION ASGetHandler(scriptingComponent: ComponentInstance; contextID: OSAID; {CONST}VAR handlerName: AEDesc; VAR resultingCompiledScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $1104, $7000, $A82A;
	{$ENDC}
FUNCTION ASGetAppTerminology(scriptingComponent: ComponentInstance; VAR fileSpec: FSSpec; terminologID: INTEGER; VAR didLaunch: BOOLEAN; VAR terminologyList: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $1105, $7000, $A82A;
	{$ENDC}
{ Errors:
		errOSASystemError		operation failed
	}
{************************************************************************}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ASDebuggingIncludes}

{$ENDC} {__ASDEBUGGING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}