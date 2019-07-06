{
     File:       CFDictionary.p
 
     Contains:   CoreFoundation dictionary collection
 
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
 UNIT CFDictionary;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFDICTIONARY__}
{$SETC __CFDICTIONARY__ := 1}

{$I+}
{$SETC CFDictionaryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryRetainCallBack = FUNCTION(allocator: CFAllocatorRef; ptr: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFDictionaryRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; ptr: UNIV Ptr); C;
{$ELSEC}
	CFDictionaryReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryCopyDescriptionCallBack = FUNCTION(ptr: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFDictionaryCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryEqualCallBack = FUNCTION(ptr1: UNIV Ptr; ptr2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFDictionaryEqualCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryHashCallBack = FUNCTION(ptr: UNIV Ptr): CFHashCode; C;
{$ELSEC}
	CFDictionaryHashCallBack = ProcPtr;
{$ENDC}

	CFDictionaryKeyCallBacksPtr = ^CFDictionaryKeyCallBacks;
	CFDictionaryKeyCallBacks = RECORD
		version:				CFIndex;
		retain:					CFDictionaryRetainCallBack;
		release:				CFDictionaryReleaseCallBack;
		copyDescription:		CFDictionaryCopyDescriptionCallBack;
		equal:					CFDictionaryEqualCallBack;
		hash:					CFDictionaryHashCallBack;
	END;

	CFDictionaryValueCallBacksPtr = ^CFDictionaryValueCallBacks;
	CFDictionaryValueCallBacks = RECORD
		version:				CFIndex;
		retain:					CFDictionaryRetainCallBack;
		release:				CFDictionaryReleaseCallBack;
		copyDescription:		CFDictionaryCopyDescriptionCallBack;
		equal:					CFDictionaryEqualCallBack;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryApplierFunction = PROCEDURE(key: UNIV Ptr; val: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFDictionaryApplierFunction = ProcPtr;
{$ENDC}

	CFDictionaryRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableDictionaryRef = CFDictionaryRef;
FUNCTION CFDictionaryGetTypeID: CFTypeID; C;
FUNCTION CFDictionaryCreate(allocator: CFAllocatorRef; VAR keys: UNIV Ptr; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR keyCallBacks: CFDictionaryKeyCallBacks; {CONST}VAR valueCallBacks: CFDictionaryValueCallBacks): CFDictionaryRef; C;
FUNCTION CFDictionaryCreateCopy(allocator: CFAllocatorRef; dict: CFDictionaryRef): CFDictionaryRef; C;
FUNCTION CFDictionaryCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR keyCallBacks: CFDictionaryKeyCallBacks; {CONST}VAR valueCallBacks: CFDictionaryValueCallBacks): CFMutableDictionaryRef; C;
FUNCTION CFDictionaryCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; dict: CFDictionaryRef): CFMutableDictionaryRef; C;
FUNCTION CFDictionaryGetCount(dict: CFDictionaryRef): CFIndex; C;
FUNCTION CFDictionaryGetCountOfKey(dict: CFDictionaryRef; key: UNIV Ptr): CFIndex; C;
FUNCTION CFDictionaryGetCountOfValue(dict: CFDictionaryRef; value: UNIV Ptr): CFIndex; C;
FUNCTION CFDictionaryContainsKey(dict: CFDictionaryRef; key: UNIV Ptr): BOOLEAN; C;
FUNCTION CFDictionaryContainsValue(dict: CFDictionaryRef; value: UNIV Ptr): BOOLEAN; C;
FUNCTION CFDictionaryGetValue(dict: CFDictionaryRef; key: UNIV Ptr): Ptr; C;
FUNCTION CFDictionaryGetValueIfPresent(dict: CFDictionaryRef; key: UNIV Ptr; VAR value: UNIV Ptr): BOOLEAN; C;
PROCEDURE CFDictionaryGetKeysAndValues(dict: CFDictionaryRef; VAR keys: UNIV Ptr; VAR values: UNIV Ptr); C;
PROCEDURE CFDictionaryApplyFunction(dict: CFDictionaryRef; applier: CFDictionaryApplierFunction; context: UNIV Ptr); C;
PROCEDURE CFDictionaryAddValue(dict: CFMutableDictionaryRef; key: UNIV Ptr; value: UNIV Ptr); C;
PROCEDURE CFDictionarySetValue(dict: CFMutableDictionaryRef; key: UNIV Ptr; value: UNIV Ptr); C;
PROCEDURE CFDictionaryReplaceValue(dict: CFMutableDictionaryRef; key: UNIV Ptr; value: UNIV Ptr); C;
PROCEDURE CFDictionaryRemoveValue(dict: CFMutableDictionaryRef; key: UNIV Ptr); C;
PROCEDURE CFDictionaryRemoveAllValues(dict: CFMutableDictionaryRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFDictionaryIncludes}

{$ENDC} {__CFDICTIONARY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
