{
     File:       CFData.p
 
     Contains:   CoreFoundation block of bytes
 
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
 UNIT CFData;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFDATA__}
{$SETC __CFDATA__ := 1}

{$I+}
{$SETC CFDataIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFDataRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableDataRef = CFDataRef;
FUNCTION CFDataGetTypeID: CFTypeID; C;

FUNCTION CFDataCreate(allocator: CFAllocatorRef; {CONST}VAR bytes: UInt8; length: CFIndex): CFDataRef; C;
FUNCTION CFDataCreateWithBytesNoCopy(allocator: CFAllocatorRef; {CONST}VAR bytes: UInt8; length: CFIndex; bytesDeallocator: CFAllocatorRef): CFDataRef; C;
{ Pass kCFAllocatorNull as bytesDeallocator to assure the bytes aren't freed }
FUNCTION CFDataCreateCopy(allocator: CFAllocatorRef; data: CFDataRef): CFDataRef; C;
FUNCTION CFDataCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex): CFMutableDataRef; C;
FUNCTION CFDataCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; data: CFDataRef): CFMutableDataRef; C;

FUNCTION CFDataGetLength(data: CFDataRef): CFIndex; C;
FUNCTION CFDataGetBytePtr(data: CFDataRef): Ptr; C;
FUNCTION CFDataGetMutableBytePtr(data: CFMutableDataRef): Ptr; C;
PROCEDURE CFDataGetBytes(data: CFDataRef; range: CFRange; VAR buffer: UInt8); C;

PROCEDURE CFDataSetLength(data: CFMutableDataRef; length: CFIndex); C;
PROCEDURE CFDataIncreaseLength(data: CFMutableDataRef; extraLength: CFIndex); C;
PROCEDURE CFDataAppendBytes(data: CFMutableDataRef; {CONST}VAR bytes: UInt8; length: CFIndex); C;
PROCEDURE CFDataReplaceBytes(data: CFMutableDataRef; range: CFRange; {CONST}VAR newBytes: UInt8; newLength: CFIndex); C;
PROCEDURE CFDataDeleteBytes(data: CFMutableDataRef; range: CFRange); C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFDataIncludes}

{$ENDC} {__CFDATA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
