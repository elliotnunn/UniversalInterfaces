{
 	File:		CFBase.p
 
 	Contains:	CoreFoundation base types
 
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
 UNIT CFBase;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFBASE__}
{$SETC __CFBASE__ := 1}

{$I+}
{$SETC CFBaseIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFTypeID							= UInt32;
	CFOptionFlags						= UInt32;
	CFHashCode							= UInt32;
	CFIndex								= SInt32;
	CFStringRef = ^LONGINT; { an opaque 32-bit type }
	CFMutableStringRef = CFStringRef;
{ Values returned from comparison functions }
	CFComparisonResult 			= SInt32;
CONST
	kCFCompareLessThan			= -1;
	kCFCompareEqualTo			= 0;
	kCFCompareGreaterThan		= 1;

{ A standard comparison function }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFComparatorFunction = FUNCTION(val1: UNIV Ptr; val2: UNIV Ptr; context: UNIV Ptr): CFComparisonResult; C;
{$ELSEC}
	CFComparatorFunction = ProcPtr;
{$ENDC}

{ Constant used by some functions to indicate failed searches. }
{ This is of type CFIndex. }
	CFNotFound 					= SInt32;
CONST
	kCFNotFound					= -1;

{ Range type }

TYPE
	CFRangePtr = ^CFRange;
	CFRange = RECORD
		location:				CFIndex;
		length:					CFIndex;
	END;


{ Allocator API

   Most of the time when specifying an allocator to Create functions, the NULL 
   argument indicates "use the default"; this is the same as using kCFAllocatorDefault 
   or the return value from CFAllocatorGetDefault().  This assures that you will use 
   the allocator in effect at that time.
   
   You should rarely use kCFAllocatorSystemDefault, the default default allocator.
}
	CFAllocatorRef = ^LONGINT; { an opaque 32-bit type }
{ Default system allocator. }
{ Null allocator which does nothing and allocates no memory. }
{ Special allocator argument to CFAllocatorCreate() which means
   "use the functions given in the context to allocate the allocator itself as well". 
}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorRetainCallBack = FUNCTION(info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFAllocatorRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorReleaseCallBack = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CFAllocatorReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorCopyDescriptionCallBack = FUNCTION(info: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFAllocatorCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorAllocateCallBack = FUNCTION(allocSize: CFIndex; hint: CFOptionFlags; info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFAllocatorAllocateCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorReallocateCallBack = FUNCTION(ptr: UNIV Ptr; newsize: CFIndex; hint: CFOptionFlags; info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFAllocatorReallocateCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorDeallocateCallBack = PROCEDURE(ptr: UNIV Ptr; info: UNIV Ptr); C;
{$ELSEC}
	CFAllocatorDeallocateCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFAllocatorPreferredSizeCallBack = FUNCTION(size: CFIndex; hint: CFOptionFlags; info: UNIV Ptr): CFIndex; C;
{$ELSEC}
	CFAllocatorPreferredSizeCallBack = ProcPtr;
{$ENDC}

	CFAllocatorContextPtr = ^CFAllocatorContext;
	CFAllocatorContext = RECORD
		version:				CFIndex;
		info:					Ptr;
		retain:					CFAllocatorRetainCallBack;
		release:				CFAllocatorReleaseCallBack;
		copyDescription:		CFAllocatorCopyDescriptionCallBack;
		allocate:				CFAllocatorAllocateCallBack;
		reallocate:				CFAllocatorReallocateCallBack;
		deallocate:				CFAllocatorDeallocateCallBack;
		preferredSize:			CFAllocatorPreferredSizeCallBack;
	END;

FUNCTION CFAllocatorGetTypeID: CFTypeID; C;

{ CFAllocatorSetDefault() sets the allocator that is used in the current thread
   whenever NULL is specified as an allocator argument. This means that most, if
   not all allocations will go through this allocator. It also means that any
   allocator set as the default needs to be ready to deal with arbitrary memory
   allocation requests; in addition, the size and number of requests will change
   between releases.

   If you wish to use a custom allocator in a context, it's best to provide it as
   the argument to the various creation functions rather than setting it as the
   default. Setting the default allocator is not encouraged.

   If you do set an allocator as the default, either do it for all time in your
   app, or do it in a nested fashion (by restoring the previous allocator when
   you exit your context). The latter might be appropriate for plug-ins or
   libraries that wish to set the default allocator.
}
PROCEDURE CFAllocatorSetDefault(allocator: CFAllocatorRef); C;
FUNCTION CFAllocatorGetDefault: CFAllocatorRef; C;

FUNCTION CFAllocatorCreate(allocator: CFAllocatorRef; VAR context: CFAllocatorContext): CFAllocatorRef; C;

FUNCTION CFAllocatorAllocate(allocator: CFAllocatorRef; size: CFIndex; hint: CFOptionFlags): Ptr; C;
FUNCTION CFAllocatorReallocate(allocator: CFAllocatorRef; ptr: UNIV Ptr; newsize: CFIndex; hint: CFOptionFlags): Ptr; C;
PROCEDURE CFAllocatorDeallocate(allocator: CFAllocatorRef; ptr: UNIV Ptr); C;
FUNCTION CFAllocatorGetPreferredSizeForSize(allocator: CFAllocatorRef; size: CFIndex; hint: CFOptionFlags): CFIndex; C;
PROCEDURE CFAllocatorGetContext(allocator: CFAllocatorRef; VAR context: CFAllocatorContext); C;
{ Base "type" of all "CF objects", and polymorphic functions on them }

TYPE
	CFTypeRef							= Ptr;
FUNCTION CFGetTypeID(cf: CFTypeRef): CFTypeID; C;
FUNCTION CFCopyTypeIDDescription(theType: CFTypeID): CFStringRef; C;

FUNCTION CFRetain(cf: CFTypeRef): CFTypeRef; C;
PROCEDURE CFRelease(cf: CFTypeRef); C;
FUNCTION CFGetRetainCount(cf: CFTypeRef): CFIndex; C;
FUNCTION CFEqual(cf1: CFTypeRef; cf2: CFTypeRef): BOOLEAN; C;
FUNCTION CFHash(cf: CFTypeRef): CFHashCode; C;
FUNCTION CFCopyDescription(cf: CFTypeRef): CFStringRef; C;
FUNCTION CFGetAllocator(cf: CFTypeRef): CFAllocatorRef; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFBaseIncludes}

{$ENDC} {__CFBASE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
