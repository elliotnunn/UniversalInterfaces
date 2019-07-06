{
     File:       CFString.p
 
     Contains:   CoreFoundation strings
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFString;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFSTRING__}
{$SETC __CFSTRING__ := 1}

{$I+}
{$SETC CFStringIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
Please note: CFStrings are conceptually an array of Unicode characters.
However, in general, how a CFString stores this array is an implementation
detail. For instance, CFString might choose to use an array of 8-bit characters;
to store its contents; or it might use multiple blocks of memory; or whatever.
Furthermore, the implementation might change depending on the default
system encoding, the user's language, the OS, or even a given release.

What this means is that you should use the following advanced functions with care:

  CFStringGetPascalStringPtr()
  CFStringGetCStringPtr()
  CFStringGetCharactersPtr()

These functions either return the desired pointer quickly, in constant time, or they
return NULL, which indicates you should use some of the other function, as shown 
in this example: 

    Str255 buffer;
    StringPtr ptr = CFStringGetPascalStringPtr(str, encoding);
    if (ptr == NULL) (
    if (CFStringGetPascalString(str, buffer, 256, encoding)) ptr = buffer;
    )

Note that CFStringGetPascalString call might still return NULL --- but that will happen 
in two circumstances only: The conversion from the UniChar contents of CFString
to the specified encoding fails, or the buffer is too small. 

If you need a copy of the buffer in the above example, you might consider simply
calling CFStringGetPascalString() in all cases --- CFStringGetPascalStringPtr()
is simply an optimization.

In addition, the following functions, which create immutable CFStrings from developer
supplied buffers without copying the buffers, might have to actually copy
under certain circumstances (If they do copy, the buffer will be dealt by the
"contentsDeallocator" argument.):

  CFStringCreateWithPascalStringNoCopy()
  CFStringCreateWithCStringNoCopy()
  CFStringCreateWithCharactersNoCopy()

You should of course never depend on the backing store of these CFStrings being
what you provided, and in other no circumstance should you change the contents
of that buffer (given that would break the invariant about the CFString being immutable).

Having said all this, there are actually ways to create a CFString where the backing store
is external, and can be manipulated by the developer or CFString itself:

  CFStringCreateMutableWithExternalCharactersNoCopy()
  CFStringSetExternalCharactersNoCopy()

A "contentsAllocator" is used to realloc or free the backing store by CFString.
kCFAllocatorNull can be provided to assure CFString will never realloc or free the buffer.
Developer can call CFStringSetExternalCharactersNoCopy() to update
CFString's idea of what's going on, if the buffer is changed externally. In these
strings, CFStringGetCharactersPtr() is guaranteed to return the external buffer.

These functions are here to allow wrapping a buffer of UniChar characters in a CFString,
allowing the buffer to passed into CFString functions and also manipulated via CFString
mutation functions. In general, developers should not use this technique for all strings,
as it prevents CFString from using certain optimizations.
}
{
    CFStringRef and CFMutableStringRef are defined in CFBase.h
}

{ Identifier for character encoding; the values are the same as Text Encoding Converter TextEncoding.
}

TYPE
	CFStringEncoding					= UInt32;
	CFStringEncodingPtr					= ^CFStringEncoding;
{ Platform-independent built-in encodings; always available on all platforms.
}
	CFStringBuiltInEncodings 	= UInt32;
CONST
	kCFStringEncodingInvalidId	= -1;
	kCFStringEncodingMacRoman	= 0;
	kCFStringEncodingWindowsLatin1 = $0500;						{  ANSI codepage 1252  }
	kCFStringEncodingISOLatin1	= $0201;						{  ISO 8850 1  }
	kCFStringEncodingNextStepLatin = $0B01;						{  NextStep encoding }
	kCFStringEncodingASCII		= $0600;						{  0..127  }
	kCFStringEncodingUnicode	= $0100;						{  kTextEncodingUnicodeDefault  + kTextEncodingDefaultFormat (aka kUnicode16BitFormat)  }
	kCFStringEncodingUTF8		= $08000100;					{  kTextEncodingUnicodeDefault + kUnicodeUTF8Format  }
	kCFStringEncodingNonLossyASCII = $0BFF;						{  7bit Unicode variants used by YellowBox & Java  }


{ CFString type ID
}
FUNCTION CFStringGetTypeID: CFTypeID; C;
{ Macro to allow creation of compile-time constant strings; the argument should be a constant string. This will work for now but we need something better.
}
{** Immutable string creation functions **}
{ Functions to create basic immutable strings. The provided allocator is used for all memory activity in these functions.
}
{ These functions copy the provided buffer into CFString's internal storage.
}
FUNCTION CFStringCreateWithPascalString(alloc: CFAllocatorRef; pStr: ConstStringPtr; encoding: CFStringEncoding): CFStringRef; C;
FUNCTION CFStringCreateWithCString(alloc: CFAllocatorRef; cStr: ConstCStringPtr; encoding: CFStringEncoding): CFStringRef; C;
FUNCTION CFStringCreateWithCharacters(alloc: CFAllocatorRef; {CONST}VAR chars: UniChar; numChars: CFIndex): CFStringRef; C;
{ These functions try not to copy the provided buffer. The buffer will be 
deallocated with the provided contentsDeallocator when it's no longer needed;
to not free the buffer, specify kCFAllocatorNull here. As usual, NULL means
default allocator.
NOTE: Do not count on these buffers as being used by the string; 
in some cases the CFString might free the buffer and use something else
(for instance if it decides to always use Unicode encoding internally). 
In addition, some encodings are not used internally; in
those cases CFString might also dump the provided buffer and use its own.
}

FUNCTION CFStringCreateWithPascalStringNoCopy(alloc: CFAllocatorRef; pStr: ConstStringPtr; encoding: CFStringEncoding; contentsDeallocator: CFAllocatorRef): CFStringRef; C;
FUNCTION CFStringCreateWithCStringNoCopy(alloc: CFAllocatorRef; cStr: ConstCStringPtr; encoding: CFStringEncoding; contentsDeallocator: CFAllocatorRef): CFStringRef; C;
FUNCTION CFStringCreateWithCharactersNoCopy(alloc: CFAllocatorRef; {CONST}VAR chars: UniChar; numChars: CFIndex; contentsDeallocator: CFAllocatorRef): CFStringRef; C;
{ Create copies of part or all of the string.
}
FUNCTION CFStringCreateWithSubstring(alloc: CFAllocatorRef; str: CFStringRef; range: CFRange): CFStringRef; C;
FUNCTION CFStringCreateCopy(alloc: CFAllocatorRef; theString: CFStringRef): CFStringRef; C;
{ Functions to create mutable strings. "maxLength", if not 0, is a hard bound on the length of the string. If 0, there is no limit on the length.
}
FUNCTION CFStringCreateMutable(alloc: CFAllocatorRef; maxLength: CFIndex): CFMutableStringRef; C;
FUNCTION CFStringCreateMutableCopy(alloc: CFAllocatorRef; maxLength: CFIndex; theString: CFStringRef): CFMutableStringRef; C;
{ This function creates a mutable string that has a developer supplied and directly editable backing store.
The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
externalCharactersAllocator will be consulted for more memory. When the CFString is deallocated, the
buffer will be freed with the externalCharactersAllocator. Provide kCFAllocatorNull here to prevent the buffer
from ever being reallocated or deallocated by CFString. See comments at top of this file for more info.
}
FUNCTION CFStringCreateMutableWithExternalCharactersNoCopy(alloc: CFAllocatorRef; VAR chars: UniChar; numChars: CFIndex; capacity: CFIndex; externalCharactersAllocator: CFAllocatorRef): CFMutableStringRef; C;

{** Basic accessors for the contents **}
{ Number of 16-bit Unicode characters in the string.
}
FUNCTION CFStringGetLength(theString: CFStringRef): CFIndex; C;
{ Extracting the contents of the string. For obtaining multiple characters, calling
CFStringGetCharacters() is more efficient than multiple calls to CFStringGetCharacterAtIndex().
If the length of the string is not known (so you can't use a fixed size buffer for CFStringGetCharacters()),
another method is to use is CFStringGetCharacterFromInlineBuffer() (see further below).
}
FUNCTION CFStringGetCharacterAtIndex(theString: CFStringRef; idx: CFIndex): UniChar; C;
PROCEDURE CFStringGetCharacters(theString: CFStringRef; range: CFRange; VAR buffer: UniChar); C;

{** Conversion to other encodings **}

{ These two convert into the provided buffer; they return FALSE if conversion isn't possible
(due to conversion error, or not enough space in the provided buffer). 
These functions do zero-terminate or put the length byte; the provided bufferSize should include
space for this (so pass 256 for Str255). More sophisticated usages can go through CFStringGetBytes().
}
FUNCTION CFStringGetPascalString(theString: CFStringRef; buffer: StringPtr; bufferSize: CFIndex; encoding: CFStringEncoding): BOOLEAN; C;
FUNCTION CFStringGetCString(theString: CFStringRef; buffer: CStringPtr; bufferSize: CFIndex; encoding: CFStringEncoding): BOOLEAN; C;
{ These functions attempt to return in O(1) time the desired format for the string.
Note that although this means a pointer to the internal structure is being returned,
this can't always be counted on. Please see note at the top of the file for more
details.
}
FUNCTION CFStringGetPascalStringPtr(theString: CFStringRef; encoding: CFStringEncoding): ConstStringPtr; C;
{ Be prepared for NULL }
FUNCTION CFStringGetCStringPtr(theString: CFStringRef; encoding: CFStringEncoding): ConstCStringPtr; C;
{ Be prepared for NULL }
FUNCTION CFStringGetCharactersPtr(theString: CFStringRef): UniCharPtr; C;
{ Be prepared for NULL }
{ The primitive conversion routine; allows you to convert a string piece at a time
   into a fixed size buffer. Returns number of characters converted. 
   Characters that cannot be converted to the specified encoding are represented
   with the byte specified by lossByte; if lossByte is 0, then lossy conversion
   is not allowed and conversion stops, returning partial results.
   Pass buffer==NULL if you don't care about the converted string (but just the convertability,
   or number of bytes required, indicated by usedBufLen). 
   maxBufLength indicates the maximum number of bytes to generate; it is consulted even
   if buffer is NULL, so pass in INT_MAX if you want to find out the maximum number of bytes.
   Does not zero-terminate. If you want to create Pascal or C string, allow one extra byte at start or end. 
   Setting isExternalRepresentation causes any extra bytes that would allow 
   the data to be made persistent to be included; for instance, the Unicode BOM.
}
FUNCTION CFStringGetBytes(theString: CFStringRef; range: CFRange; encoding: CFStringEncoding; lossByte: ByteParameter; isExternalRepresentation: BOOLEAN; VAR buffer: UInt8; maxBufLen: CFIndex; VAR usedBufLen: CFIndex): CFIndex; C;
{ This one goes the other way by creating a CFString from a bag of bytes. 
This is much like CFStringCreateWithPascalString or CFStringCreateWithCString, 
except the length is supplied explicitly. In addition, you can specify whether 
the data is an external format --- that is, whether to pay attention to the 
BOM character (if any) and do byte swapping if necessary
}
FUNCTION CFStringCreateWithBytes(alloc: CFAllocatorRef; {CONST}VAR bytes: UInt8; numBytes: CFIndex; encoding: CFStringEncoding; isExternalRepresentation: BOOLEAN): CFStringRef; C;
{ Convenience functions String <-> Data. These generate "external" formats, that is, formats that
   can be written out to disk. For instance, if the encoding is Unicode, CFStringCreateFromExternalRepresentation()
   pays attention to the BOM character (if any) and does byte swapping if necessary.
   Similarly CFStringCreateExternalRepresentation() will always include a BOM character if the encoding is
   Unicode. See above for description of lossByte.
}
FUNCTION CFStringCreateFromExternalRepresentation(alloc: CFAllocatorRef; data: CFDataRef; encoding: CFStringEncoding): CFStringRef; C;
{ May return NULL on conversion error }
FUNCTION CFStringCreateExternalRepresentation(alloc: CFAllocatorRef; theString: CFStringRef; encoding: CFStringEncoding; lossByte: ByteParameter): CFDataRef; C;
{ May return NULL on conversion error }
{ Hints about the contents of a string
}
FUNCTION CFStringGetSmallestEncoding(theString: CFStringRef): CFStringEncoding; C;
{ Result in O(n) time max }
FUNCTION CFStringGetFastestEncoding(theString: CFStringRef): CFStringEncoding; C;
{ Result in O(1) time max }
{ General encoding info
}
FUNCTION CFStringGetSystemEncoding: CFStringEncoding; C;
{ The default encoding for the system; untagged 8-bit characters are usually in this encoding }
FUNCTION CFStringGetMaximumSizeForEncoding(length: CFIndex; encoding: CFStringEncoding): CFIndex; C;
{ Max bytes a string of specified length (in UniChars) will take up if encoded }

{** Comparison functions. **}

TYPE
	CFStringCompareFlags 		= UInt32;
CONST
																{  Flags used in all find and compare operations  }
	kCFCompareCaseInsensitive	= 1;
	kCFCompareBackwards			= 4;							{  Starting from the end of the string  }
	kCFCompareAnchored			= 8;							{  Only at the specified starting point  }
	kCFCompareNonliteral		= 16;							{  If specified, loose equivalence is performed (o-umlaut == o, umlaut)  }
	kCFCompareLocalized			= 32;							{  User's default locale is used for the comparisons  }
	kCFCompareNumerically		= 64;							{  Numeric comparison is used; that is, Foo2.txt < Foo7.txt < Foo25.txt  }

{ The main comparison routine; compares specified range of the string to another.
   locale == NULL indicates canonical locale
}
FUNCTION CFStringCompareWithOptions(string1: CFStringRef; string2: CFStringRef; rangeToCompare: CFRange; compareOptions: CFOptionFlags): CFComparisonResult; C;
{ Comparison convenience suitable for passing as sorting functions.
}
FUNCTION CFStringCompare(string1: CFStringRef; string2: CFStringRef; compareOptions: CFOptionFlags): CFComparisonResult; C;
{ Find routines; CFStringFindWithOptions() returns the found range in the CFRange * argument;  You can pass NULL for simple discovery check.
   CFStringCreateArrayWithFindResults() returns an array of CFRange pointers, or NULL if there are no matches.
}
FUNCTION CFStringFindWithOptions(theString: CFStringRef; stringToFind: CFStringRef; rangeToSearch: CFRange; searchOptions: CFOptionFlags; VAR result: CFRange): BOOLEAN; C;
FUNCTION CFStringCreateArrayWithFindResults(alloc: CFAllocatorRef; theString: CFStringRef; stringToFind: CFStringRef; rangeToSearch: CFRange; compareOptions: CFOptionFlags): CFArrayRef; C;
{ Find conveniences
}
FUNCTION CFStringFind(theString: CFStringRef; stringToFind: CFStringRef; compareOptions: CFOptionFlags): CFRange; C;
FUNCTION CFStringHasPrefix(theString: CFStringRef; prefix: CFStringRef): BOOLEAN; C;
FUNCTION CFStringHasSuffix(theString: CFStringRef; suffix: CFStringRef): BOOLEAN; C;
{ Find range of bounds of the line(s) that span the indicated range (startIndex, numChars),
   taking into account various possible line separator sequences (CR, CRLF, LF, and Unicode LS, PS).
   All return values are "optional" (provide NULL if you don't want them)
     lineStartIndex: index of first character in line
     lineEndIndex: index of first character of the next line (including terminating line separator characters)
     contentsEndIndex: index of the first line separator character
   Thus, lineEndIndex - lineStartIndex is the number of chars in the line, including the line separators
         contentsEndIndex - lineStartIndex is the number of chars in the line w/out the line separators
}
PROCEDURE CFStringGetLineBounds(theString: CFStringRef; range: CFRange; VAR lineBeginIndex: CFIndex; VAR lineEndIndex: CFIndex; VAR contentsEndIndex: CFIndex); C;
{** Exploding and joining strings with a separator string **}

FUNCTION CFStringCreateByCombiningStrings(alloc: CFAllocatorRef; theArray: CFArrayRef; separatorString: CFStringRef): CFStringRef; C;
{ Empty array returns empty string; one element array returns the element }
FUNCTION CFStringCreateArrayBySeparatingStrings(alloc: CFAllocatorRef; theString: CFStringRef; separatorString: CFStringRef): CFArrayRef; C;
{ No separators in the string returns array with that string; string == sep returns two empty strings }
{** Parsing non-localized numbers from strings **}

FUNCTION CFStringGetIntValue(str: CFStringRef): SInt32; C;
{ Skips whitespace; returns 0 on error, MAX or -MAX on overflow }
FUNCTION CFStringGetDoubleValue(str: CFStringRef): Double; C;
{ Skips whitespace; returns 0.0 on error }
{** MutableString functions **}
{ CFStringAppend("abcdef", "xxxxx") -> "abcdefxxxxx"
   CFStringDelete("abcdef", 2, 3) -> "abf"
   CFStringReplace("abcdef", 2, 3, "xxxxx") -> "abxxxxxf"
   CFStringReplaceAll("abcdef", "xxxxx") -> "xxxxx"
}
PROCEDURE CFStringAppend(theString: CFMutableStringRef; appendedString: CFStringRef); C;
PROCEDURE CFStringAppendCharacters(theString: CFMutableStringRef; {CONST}VAR chars: UniChar; numChars: CFIndex); C;
PROCEDURE CFStringAppendPascalString(theString: CFMutableStringRef; pStr: ConstStringPtr; encoding: CFStringEncoding); C;
PROCEDURE CFStringAppendCString(theString: CFMutableStringRef; cStr: ConstCStringPtr; encoding: CFStringEncoding); C;
PROCEDURE CFStringAppendFormat(theString: CFMutableStringRef; formatOptions: CFDictionaryRef; format: CFStringRef; ...); C;
PROCEDURE CFStringInsert(str: CFMutableStringRef; idx: CFIndex; insertedStr: CFStringRef); C;
PROCEDURE CFStringDelete(theString: CFMutableStringRef; range: CFRange); C;
PROCEDURE CFStringReplace(theString: CFMutableStringRef; range: CFRange; replacement: CFStringRef); C;
PROCEDURE CFStringReplaceAll(theString: CFMutableStringRef; replacement: CFStringRef); C;
{ Replaces whole string }
{ This function will make the contents of a mutable CFString point directly at the specified UniChar array.
it works only with CFStrings created with CFStringCreateMutableWithExternalCharactersNoCopy().
This function does not free the previous buffer.
The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
externalCharactersAllocator will be consulted for more memory.
See comments at the top of this file for more info.
}
PROCEDURE CFStringSetExternalCharactersNoCopy(theString: CFMutableStringRef; VAR chars: UniChar; length: CFIndex; capacity: CFIndex); C;
{ Works only on specially created mutable strings! }

{ CFStringPad() will pad or cut down a string to the specified size.
   The pad string is used as the fill string; indexIntoPad specifies which character to start with.
     CFStringPad("abc", " ", 9, 0) ->  "abc      "
     CFStringPad("abc", ". ", 9, 1) -> "abc . . ."
     CFStringPad("abcdef", ?, 3, ?) -> "abc"

     CFStringTrim() will trim the specified string from both ends of the string.
     CFStringTrimWhitespace() will do the same with white space characters (tab, newline, etc)
     CFStringTrim("  abc ", " ") -> "abc"
     CFStringTrim("* * * *abc * ", "* ") -> "*abc "
}
PROCEDURE CFStringPad(theString: CFMutableStringRef; padString: CFStringRef; length: CFIndex; indexIntoPad: CFIndex); C;
PROCEDURE CFStringTrim(theString: CFMutableStringRef; trimString: CFStringRef); C;
PROCEDURE CFStringTrimWhitespace(theString: CFMutableStringRef); C;

PROCEDURE CFStringLowercase(theString: CFMutableStringRef; localeTBD: UNIV Ptr); C;
PROCEDURE CFStringUppercase(theString: CFMutableStringRef; localeTBD: UNIV Ptr); C;
PROCEDURE CFStringCapitalize(theString: CFMutableStringRef; localeTBD: UNIV Ptr); C;

{ This returns availability of the encoding on the system
}
FUNCTION CFStringIsEncodingAvailable(encoding: CFStringEncoding): BOOLEAN; C;
{ This function returns list of available encodings.  The returned list is terminated with kCFStringEncodingInvalidId and owned by the system.
}
FUNCTION CFStringGetListOfAvailableEncodings: CFStringEncodingPtr; C;
{ Returns name of the encoding
}
FUNCTION CFStringGetNameOfEncoding(encoding: CFStringEncoding): CFStringRef; C;
{ ID mapping functions from/to YellowBox NSStringEncoding.  Returns kCFStringEncodingInvalidId if no mapping exists.
}
FUNCTION CFStringConvertEncodingToNSStringEncoding(encoding: CFStringEncoding): UInt32; C;
FUNCTION CFStringConvertNSStringEncodingToEncoding(encoding: UInt32): CFStringEncoding; C;
{ ID mapping functions from/to Microsoft Windows codepage (covers both OEM & ANSI).  Returns kCFStringEncodingInvalidId if no mapping exists.
}
FUNCTION CFStringConvertEncodingToWindowsCodepage(encoding: CFStringEncoding): UInt32; C;
FUNCTION CFStringConvertWindowsCodepageToEncoding(codepage: UInt32): CFStringEncoding; C;
{ ID mapping functions from/to IANA registery charset names.  Returns kCFStringEncodingInvalidId if no mapping exists.
}
FUNCTION CFStringConvertIANACharSetNameToEncoding(theString: CFStringRef): CFStringEncoding; C;
FUNCTION CFStringConvertEncodingToIANACharSetName(encoding: CFStringEncoding): CFStringRef; C;

{ Rest of the stuff in this file is private and should not be used directly
}
{ For debugging only
   Use CFShow() to printf the description of any CFType;
   Use CFShowStr() to printf detailed info about a CFString
}
PROCEDURE CFShow(obj: CFTypeRef); C;
PROCEDURE CFShowStr(str: CFStringRef); C;
{ This function is private and should not be used directly
}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFStringIncludes}

{$ENDC} {__CFSTRING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
