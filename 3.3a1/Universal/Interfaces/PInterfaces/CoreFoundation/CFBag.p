{
 	File:		CFBag.p
 
 	Contains:	CoreFoundation bag collection
 
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
 UNIT CFBag;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFBAG__}
{$SETC __CFBAG__ := 1}

{$I+}
{$SETC CFBagIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFBagRetainCallBack = FUNCTION(allocator: CFAllocatorRef; ptr: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFBagRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; ptr: UNIV Ptr); C;
{$ELSEC}
	CFBagReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagCopyDescriptionCallBack = FUNCTION(ptr: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFBagCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagEqualCallBack = FUNCTION(ptr1: UNIV Ptr; ptr2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFBagEqualCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagHashCallBack = FUNCTION(ptr: UNIV Ptr): CFHashCode; C;
{$ELSEC}
	CFBagHashCallBack = ProcPtr;
{$ENDC}

	CFBagCallBacksPtr = ^CFBagCallBacks;
	CFBagCallBacks = RECORD
		version:				CFIndex;
		retain:					CFBagRetainCallBack;
		release:				CFBagReleaseCallBack;
		copyDescription:		CFBagCopyDescriptionCallBack;
		equal:					CFBagEqualCallBack;
		hash:					CFBagHashCallBack;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagApplierFunction = PROCEDURE(val: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFBagApplierFunction = ProcPtr;
{$ENDC}

	CFBagRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableBagRef = CFBagRef;
FUNCTION CFBagGetTypeID: CFTypeID; C;

FUNCTION CFBagCreate(allocator: CFAllocatorRef; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR callBacks: CFBagCallBacks): CFBagRef; C;
FUNCTION CFBagCreateCopy(allocator: CFAllocatorRef; bag: CFBagRef): CFBagRef; C;
FUNCTION CFBagCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR callBacks: CFBagCallBacks): CFMutableBagRef; C;
FUNCTION CFBagCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; bag: CFBagRef): CFMutableBagRef; C;

FUNCTION CFBagGetCount(bag: CFBagRef): CFIndex; C;
FUNCTION CFBagGetCountOfValue(bag: CFBagRef; value: UNIV Ptr): CFIndex; C;
FUNCTION CFBagContainsValue(bag: CFBagRef; value: UNIV Ptr): BOOLEAN; C;
FUNCTION CFBagGetValue(bag: CFBagRef; candidate: UNIV Ptr): Ptr; C;
FUNCTION CFBagGetValueIfPresent(bag: CFBagRef; candidate: UNIV Ptr; VAR value: UNIV Ptr): BOOLEAN; C;
PROCEDURE CFBagGetValues(bag: CFBagRef; VAR values: UNIV Ptr); C;
PROCEDURE CFBagApplyFunction(bag: CFBagRef; applier: CFBagApplierFunction; context: UNIV Ptr); C;

PROCEDURE CFBagAddValue(bag: CFMutableBagRef; value: UNIV Ptr); C;
PROCEDURE CFBagReplaceValue(bag: CFMutableBagRef; value: UNIV Ptr); C;
PROCEDURE CFBagSetValue(bag: CFMutableBagRef; value: UNIV Ptr); C;
PROCEDURE CFBagRemoveValue(bag: CFMutableBagRef; value: UNIV Ptr); C;
PROCEDURE CFBagRemoveAllValues(bag: CFMutableBagRef); C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFBagIncludes}

{$ENDC} {__CFBAG__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
