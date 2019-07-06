{
 	File:		CFSet.p
 
 	Contains:	CoreFoundation set collection
 
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
 UNIT CFSet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFSET__}
{$SETC __CFSET__ := 1}

{$I+}
{$SETC CFSetIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFSetRetainCallBack = FUNCTION(allocator: CFAllocatorRef; ptr: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFSetRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; ptr: UNIV Ptr); C;
{$ELSEC}
	CFSetReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetCopyDescriptionCallBack = FUNCTION(ptr: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFSetCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetEqualCallBack = FUNCTION(ptr1: UNIV Ptr; ptr2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFSetEqualCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetHashCallBack = FUNCTION(ptr: UNIV Ptr): CFHashCode; C;
{$ELSEC}
	CFSetHashCallBack = ProcPtr;
{$ENDC}

	CFSetCallBacksPtr = ^CFSetCallBacks;
	CFSetCallBacks = RECORD
		version:				CFIndex;
		retain:					CFSetRetainCallBack;
		release:				CFSetReleaseCallBack;
		copyDescription:		CFSetCopyDescriptionCallBack;
		equal:					CFSetEqualCallBack;
		hash:					CFSetHashCallBack;
	END;


{$IFC TYPED_FUNCTION_POINTERS}
	CFSetApplierFunction = PROCEDURE(val: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFSetApplierFunction = ProcPtr;
{$ENDC}

	CFSetRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableSetRef = CFSetRef;
FUNCTION CFSetGetTypeID: CFTypeID; C;

FUNCTION CFSetCreate(allocator: CFAllocatorRef; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR callBacks: CFSetCallBacks): CFSetRef; C;
FUNCTION CFSetCreateCopy(allocator: CFAllocatorRef; theSet: CFSetRef): CFSetRef; C;
FUNCTION CFSetCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR callBacks: CFSetCallBacks): CFMutableSetRef; C;
FUNCTION CFSetCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; theSet: CFSetRef): CFMutableSetRef; C;

FUNCTION CFSetGetCount(theSet: CFSetRef): CFIndex; C;
FUNCTION CFSetGetCountOfValue(theSet: CFSetRef; value: UNIV Ptr): CFIndex; C;
FUNCTION CFSetContainsValue(theSet: CFSetRef; value: UNIV Ptr): BOOLEAN; C;
FUNCTION CFSetGetValue(theSet: CFSetRef; candidate: UNIV Ptr): Ptr; C;
FUNCTION CFSetGetValueIfPresent(theSet: CFSetRef; candidate: UNIV Ptr; VAR value: UNIV Ptr): BOOLEAN; C;
PROCEDURE CFSetGetValues(theSet: CFSetRef; VAR values: UNIV Ptr); C;
PROCEDURE CFSetApplyFunction(theSet: CFSetRef; applier: CFSetApplierFunction; context: UNIV Ptr); C;

PROCEDURE CFSetAddValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;
PROCEDURE CFSetReplaceValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;
PROCEDURE CFSetSetValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;
PROCEDURE CFSetRemoveValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;
PROCEDURE CFSetRemoveAllValues(theSet: CFMutableSetRef); C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFSetIncludes}

{$ENDC} {__CFSET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
