{
     File:       CFArray.p
 
     Contains:   CoreFoundation array collection
 
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
 UNIT CFArray;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFARRAY__}
{$SETC __CFARRAY__ := 1}

{$I+}
{$SETC CFArrayIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayRetainCallBack = FUNCTION(allocator: CFAllocatorRef; ptr: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFArrayRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; ptr: UNIV Ptr); C;
{$ELSEC}
	CFArrayReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayCopyDescriptionCallBack = FUNCTION(ptr: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFArrayCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayEqualCallBack = FUNCTION(ptr1: UNIV Ptr; ptr2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFArrayEqualCallBack = ProcPtr;
{$ENDC}

	CFArrayCallBacksPtr = ^CFArrayCallBacks;
	CFArrayCallBacks = RECORD
		version:				CFIndex;
		retain:					CFArrayRetainCallBack;
		release:				CFArrayReleaseCallBack;
		copyDescription:		CFArrayCopyDescriptionCallBack;
		equal:					CFArrayEqualCallBack;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayApplierFunction = PROCEDURE(val: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFArrayApplierFunction = ProcPtr;
{$ENDC}

	CFArrayRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableArrayRef = CFArrayRef;
FUNCTION CFArrayGetTypeID: CFTypeID; C;
FUNCTION CFArrayCreate(allocator: CFAllocatorRef; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR callBacks: CFArrayCallBacks): CFArrayRef; C;
FUNCTION CFArrayCreateCopy(allocator: CFAllocatorRef; srcArray: CFArrayRef): CFArrayRef; C;
FUNCTION CFArrayCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR callBacks: CFArrayCallBacks): CFMutableArrayRef; C;
FUNCTION CFArrayCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; srcArray: CFArrayRef): CFMutableArrayRef; C;
FUNCTION CFArrayGetCount(theArray: CFArrayRef): CFIndex; C;
FUNCTION CFArrayGetCountOfValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): CFIndex; C;
FUNCTION CFArrayContainsValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): BOOLEAN; C;
FUNCTION CFArrayGetValueAtIndex(theArray: CFArrayRef; idx: CFIndex): Ptr; C;
PROCEDURE CFArrayGetValues(theArray: CFArrayRef; range: CFRange; VAR values: UNIV Ptr); C;
PROCEDURE CFArrayApplyFunction(theArray: CFArrayRef; range: CFRange; applier: CFArrayApplierFunction; context: UNIV Ptr); C;
FUNCTION CFArrayGetFirstIndexOfValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): CFIndex; C;
FUNCTION CFArrayGetLastIndexOfValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): CFIndex; C;
FUNCTION CFArrayBSearchValues(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr; comparator: CFComparatorFunction; context: UNIV Ptr): CFIndex; C;
PROCEDURE CFArrayAppendValue(theArray: CFMutableArrayRef; value: UNIV Ptr); C;
PROCEDURE CFArrayInsertValueAtIndex(theArray: CFMutableArrayRef; idx: CFIndex; value: UNIV Ptr); C;
PROCEDURE CFArraySetValueAtIndex(theArray: CFMutableArrayRef; idx: CFIndex; value: UNIV Ptr); C;
PROCEDURE CFArrayRemoveValueAtIndex(theArray: CFMutableArrayRef; idx: CFIndex); C;
PROCEDURE CFArrayRemoveAllValues(theArray: CFMutableArrayRef); C;
PROCEDURE CFArrayReplaceValues(theArray: CFMutableArrayRef; range: CFRange; VAR newValues: UNIV Ptr; newCount: CFIndex); C;
PROCEDURE CFArrayExchangeValuesAtIndices(theArray: CFMutableArrayRef; idx1: CFIndex; idx2: CFIndex); C;
PROCEDURE CFArraySortValues(theArray: CFMutableArrayRef; range: CFRange; comparator: CFComparatorFunction; context: UNIV Ptr); C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFArrayIncludes}

{$ENDC} {__CFARRAY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
