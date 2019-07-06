{
 	File:		PLStringFuncs.p
 
 	Contains:	xxx put contents here xxx
 
 	Version:	Technology:	xxx put version here xxx
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PLStringFuncs;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PLSTRINGFUNCS__}
{$SETC __PLSTRINGFUNCS__ := 1}

{$I+}
{$SETC PLStringFuncsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

FUNCTION PLstrcmp(str1: Str255; str2: Str255): INTEGER;
FUNCTION PLstrncmp(str1: Str255; str2: Str255; num: INTEGER): INTEGER;
FUNCTION PLstrcpy(str1: StringPtr; str2: Str255): StringPtr;
FUNCTION PLstrncpy(str1: StringPtr; str2: Str255; num: INTEGER): StringPtr;
FUNCTION PLstrcat(str1: StringPtr; str2: Str255): StringPtr;
FUNCTION PLstrncat(str1: StringPtr; str2: Str255; num: INTEGER): StringPtr;
FUNCTION PLstrchr(str1: Str255; ch1: INTEGER): Ptr;
FUNCTION PLstrrchr(str1: Str255; ch1: INTEGER): Ptr;
FUNCTION PLstrpbrk(str1: Str255; str2: Str255): Ptr;
FUNCTION PLstrspn(str1: Str255; str2: Str255): INTEGER;
FUNCTION PLstrstr(str1: Str255; str2: Str255): Ptr;
FUNCTION PLstrlen(str: Str255): INTEGER;
FUNCTION PLpos(str1: Str255; str2: Str255): INTEGER;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PLStringFuncsIncludes}

{$ENDC} {__PLSTRINGFUNCS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
