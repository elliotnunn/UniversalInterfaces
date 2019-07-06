{
 	File:		CFBundle.p
 
 	Contains:	CoreFoundation bundle
 
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
 UNIT CFBundle;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFBUNDLE__}
{$SETC __CFBUNDLE__ := 1}

{$I+}
{$SETC CFBundleIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFBundleRef = ^LONGINT; { an opaque 32-bit type }
	CFPlugInRef = CFBundleRef;

{ ===================== Finding Bundles ===================== }
FUNCTION CFBundleGetMainBundle: CFBundleRef; C;
FUNCTION CFBundleGetBundleWithIdentifier(bundleID: CFStringRef): CFBundleRef; C;
{ A bundle can name itself by providing a key in the info dictionary. }
{ This facility is meant to allow bundle-writers to get hold of their }
{ bundle from their code without having to know where it was on the disk. }
{ This is meant to be a replacement mechanism for +bundleForClass: users. }
{ ===================== Creating Bundles ===================== }
FUNCTION CFBundleGetTypeID: UInt32; C;
FUNCTION CFBundleCreate(allocator: CFAllocatorRef; bundleURL: CFURLRef): CFBundleRef; C;
{ Might return an existing instance with the ref-count bumped. }
FUNCTION CFBundleCreateBundlesFromDirectory(allocator: CFAllocatorRef; directoryURL: CFURLRef; bundleType: CFStringRef): CFArrayRef; C;
{ Create instances for all bundles in the given directory matching the given }
{ type (or all of them if bundleType is NULL) }
{ ==================== Basic Bundle Info ==================== }
FUNCTION CFBundleCopyBundleURL(bundle: CFBundleRef): CFURLRef; C;
FUNCTION CFBundleGetInfoDictionary(bundle: CFBundleRef): CFDictionaryRef; C;
FUNCTION CFBundleGetIdentifier(bundle: CFBundleRef): CFStringRef; C;
FUNCTION CFBundleGetDevelopmentRegion(bundle: CFBundleRef): CFStringRef; C;
FUNCTION CFBundleCopySupportFilesDirectoryURL(bundle: CFBundleRef): CFURLRef; C;
FUNCTION CFBundleCopyResourcesDirectoryURL(bundle: CFBundleRef): CFURLRef; C;
{ ------------- Basic Bundle Info without a CFBundle instance ------------- }
{ This API is provided to enable developers to use access a bundle Info }
{ dictionary without having to create an instance of CFBundle. }
FUNCTION CFBundleCopyInfoDictionaryInDirectory(bundleURL: CFURLRef): CFDictionaryRef; C;
{ ==================== Resource Handling API ==================== }
FUNCTION CFBundleCopyResourceURL(bundle: CFBundleRef; resourceName: CFStringRef; resourceType: CFStringRef; subDirName: CFStringRef): CFURLRef; C;
FUNCTION CFBundleCopyResourceURLsOfType(bundle: CFBundleRef; resourceType: CFStringRef; subDirName: CFStringRef): CFArrayRef; C;
FUNCTION CFBundleCopyLocalizedString(bundle: CFBundleRef; key: CFStringRef; value: CFStringRef; tableName: CFStringRef): CFStringRef; C;
{ ------------- Resource Handling without a CFBundle instance ------------- }
{ This API is provided to enable developers to use the CFBundle resource }
{ searching policy without having to create an instance of CFBundle. }
{ Because of caching behavior when a CFBundle instance exists, it will be faster }
{ to actually create a CFBundle if you need to access several resources. }
FUNCTION CFBundleCopyResourceURLInDirectory(bundleURL: CFURLRef; resourceName: CFStringRef; resourceType: CFStringRef; subDirName: CFStringRef): CFURLRef; C;
FUNCTION CFBundleCopyResourceURLsOfTypeInDirectory(bundleURL: CFURLRef; resourceType: CFStringRef; subDirName: CFStringRef): CFArrayRef; C;
{ ==================== Primitive Code Loading API ==================== }
{ This API abstracts the variosu different executable formats supported on various platforms. }
{ It can load DYLD, CFM, or DLL shared libraries (on their appropriate platforms) and gives a }
{ uniform API for looking up functions. }
FUNCTION CFBundleCopyExecutableURL(bundle: CFBundleRef): CFURLRef; C;
FUNCTION CFBundleIsExecutableLoaded(bundle: CFBundleRef): BOOLEAN; C;
FUNCTION CFBundleLoadExecutable(bundle: CFBundleRef): BOOLEAN; C;
PROCEDURE CFBundleUnloadExecutable(bundle: CFBundleRef); C;
FUNCTION CFBundleGetFunctionPointerForName(bundle: CFBundleRef; functionName: CFStringRef): Ptr; C;
PROCEDURE CFBundleGetFunctionPointersForNames(bundle: CFBundleRef; functionNames: CFArrayRef; VAR ftbl: UNIV Ptr); C;
{ ==================== Getting a bundles plugIn ==================== }
FUNCTION CFBundleGetPlugIn(bundle: CFBundleRef): CFPlugInRef; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFBundleIncludes}

{$ENDC} {__CFBUNDLE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
