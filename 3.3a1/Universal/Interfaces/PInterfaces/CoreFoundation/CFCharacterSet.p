{
 	File:		CFCharacterSet.p
 
 	Contains:	CoreFoundation character sets
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFCharacterSet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFCHARACTERSET__}
{$SETC __CFCHARACTERSET__ := 1}

{$I+}
{$SETC CFCharacterSetIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFCharacterSetRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableCharacterSetRef = CFCharacterSetRef;
{ Used by CFCharacterSetCreateWithPredefinedSet }
	CFCharacterSetPredefinedSet  = SInt32;
CONST
	kCFCharacterSetControl		= 1;
	kCFCharacterSetWhitespace	= 2;
	kCFCharacterSetWhitespaceAndNewline = 3;
	kCFCharacterSetDecimalDigit	= 4;
	kCFCharacterSetLetter		= 5;
	kCFCharacterSetLowercaseLetter = 6;
	kCFCharacterSetUppercaseLetter = 7;
	kCFCharacterSetNonBase		= 8;
	kCFCharacterSetDecomposable	= 9;
	kCFCharacterSetAlphaNumeric	= 10;
	kCFCharacterSetPunctuation	= 11;
	kCFCharacterSetIllegal		= 12;

{ CFCharacterSet type ID }
FUNCTION CFCharacterSetGetTypeID: CFTypeID; C;
{** CharacterSet creation **}
{ Functions to create basic immutable characterset. }
FUNCTION CFCharacterSetGetPredefined(theSetIdentifier: CFCharacterSetPredefinedSet): CFCharacterSetRef; C;
FUNCTION CFCharacterSetCreateWithCharactersInRange(alloc: CFAllocatorRef; theRange: CFRange): CFCharacterSetRef; C;
FUNCTION CFCharacterSetCreateWithCharactersInString(alloc: CFAllocatorRef; theString: CFStringRef): CFCharacterSetRef; C;
FUNCTION CFCharacterSetCreateWithBitmapRepresentation(alloc: CFAllocatorRef; theData: CFDataRef): CFCharacterSetRef; C;
{ Functions to create mutable characterset. }
FUNCTION CFCharacterSetCreateMutable(alloc: CFAllocatorRef): CFMutableCharacterSetRef; C;
FUNCTION CFCharacterSetCreateMutableCopy(alloc: CFAllocatorRef; theSet: CFCharacterSetRef): CFMutableCharacterSetRef; C;
{** Basic accessors **}
FUNCTION CFCharacterSetIsCharacterMember(theSet: CFCharacterSetRef; theChar: UniChar): BOOLEAN; C;
FUNCTION CFCharacterSetCreateBitmapRepresentation(alloc: CFAllocatorRef; theSet: CFCharacterSetRef): CFDataRef; C;
{** MutableCharacterSet functions **}
PROCEDURE CFCharacterSetAddCharactersInRange(theSet: CFMutableCharacterSetRef; theRange: CFRange); C;
PROCEDURE CFCharacterSetRemoveCharactersInRange(theSet: CFMutableCharacterSetRef; theRange: CFRange); C;
PROCEDURE CFCharacterSetAddCharactersInString(theSet: CFMutableCharacterSetRef; theString: CFStringRef); C;
PROCEDURE CFCharacterSetRemoveCharactersInString(theSet: CFMutableCharacterSetRef; theString: CFStringRef); C;
PROCEDURE CFCharacterSetUnion(theSet: CFMutableCharacterSetRef; theOtherSet: CFCharacterSetRef); C;
PROCEDURE CFCharacterSetIntersect(theSet: CFMutableCharacterSetRef; theOtherSet: CFCharacterSetRef); C;
PROCEDURE CFCharacterSetInvert(theSet: CFMutableCharacterSetRef); C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFCharacterSetIncludes}

{$ENDC} {__CFCHARACTERSET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
