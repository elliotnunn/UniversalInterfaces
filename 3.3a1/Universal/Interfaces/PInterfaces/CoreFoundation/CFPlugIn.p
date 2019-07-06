{
 	File:		CFPlugIn.p
 
 	Contains:	CoreFoundation plugins
 
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
 UNIT CFPlugIn;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFPLUGIN__}
{$SETC __CFPLUGIN__ := 1}

{$I+}
{$SETC CFPlugInIncludes := UsingIncludes}
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
{$IFC UNDEFINED __CFBUNDLE__}
{$I CFBundle.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFPlugInInstanceRef = ^LONGINT; { an opaque 32-bit type }

{ ================= Function prototypes for various callbacks ================= }
{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInDynamicRegisterFunction = PROCEDURE(plugIn: CFPlugInRef); C;
{$ELSEC}
	CFPlugInDynamicRegisterFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInUnloadFunction = PROCEDURE(plugIn: CFPlugInRef); C;
{$ELSEC}
	CFPlugInUnloadFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInFactoryFunction = FUNCTION(allocator: CFAllocatorRef; typeName: CFStringRef): CFPlugInInstanceRef; C;
{$ELSEC}
	CFPlugInFactoryFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInInstanceGetInterfaceFunction = FUNCTION(instance: CFPlugInInstanceRef; interfaceName: CFStringRef; VAR ftbl: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFPlugInInstanceGetInterfaceFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInInstanceDeallocateInstanceDataFunction = PROCEDURE(instanceData: UNIV Ptr); C;
{$ELSEC}
	CFPlugInInstanceDeallocateInstanceDataFunction = ProcPtr;
{$ENDC}

{ ================= Creating PlugIns ================= }
FUNCTION CFPlugInGetTypeID: UInt32; C;
FUNCTION CFPlugInCreate(allocator: CFAllocatorRef; plugInURL: CFURLRef): CFPlugInRef; C;
{ Might return an existing instance with the ref-count bumped. }
FUNCTION CFPlugInGetBundle(plugIn: CFPlugInRef): CFBundleRef; C;
{ ================= Controlling load on demand ================= }
{ For plugIns. }
{ A dynamic registration function can call CFPlugInSetLoadOnDemand. }
PROCEDURE CFPlugInSetLoadOnDemand(plugIn: CFPlugInRef; flag: BOOLEAN); C;
FUNCTION CFPlugInIsLoadOnDemand(plugIn: CFPlugInRef): BOOLEAN; C;
{ ================= Finding factories and creating instances ================= }
{ For plugIn hosts. }
{ Functions for finding factories to create specific types and actually creating instances of a type. }
FUNCTION CFPlugInFindFactoriesForPlugInType(typeName: CFStringRef): CFArrayRef; C;
FUNCTION CFPlugInInstanceCreate(allocator: CFAllocatorRef; factoryName: CFStringRef; typeName: CFStringRef): CFPlugInInstanceRef; C;
{ ================= Using instances ================= }
{ For plugIn hosts and/or plugIns. }
{ Functions for dealing with instances. }
FUNCTION CFPlugInInstanceGetInterfaceFunctionTable(instance: CFPlugInInstanceRef; interfaceName: CFStringRef; VAR ftbl: UNIV Ptr): BOOLEAN; C;
FUNCTION CFPlugInInstanceGetFactoryName(instance: CFPlugInInstanceRef): CFStringRef; C;
FUNCTION CFPlugInInstanceGetInstanceData(instance: CFPlugInInstanceRef): Ptr; C;
{ ================= Registering factories and types ================= }
{ For plugIn writers who must dynamically register things. }
{ Functions to register factory functions and to associate factories with types. }
FUNCTION CFPlugInRegisterFactoryFunction(factoryName: CFStringRef; func: CFPlugInFactoryFunction): BOOLEAN; C;
FUNCTION CFPlugInRegisterFactoryFunctionByName(factoryName: CFStringRef; plugIn: CFPlugInRef; functionName: CFStringRef): BOOLEAN; C;
FUNCTION CFPlugInUnregisterFactory(factoryName: CFStringRef): BOOLEAN; C;
FUNCTION CFPlugInRegisterPlugInType(factoryName: CFStringRef; typeName: CFStringRef): BOOLEAN; C;
FUNCTION CFPlugInUnregisterPlugInType(factoryName: CFStringRef; typeName: CFStringRef): BOOLEAN; C;
{ ================= Primitive instance creation ================= }
{ For plugIns. }
{ Factory function implementations should use this to actually create an instance. }
FUNCTION CFPlugInInstanceGetTypeID: UInt32; C;
FUNCTION CFPlugInInstanceCreateWithInstanceDataSize(allocator: CFAllocatorRef; instanceDataSize: CFIndex; deallocateInstanceFunction: CFPlugInInstanceDeallocateInstanceDataFunction; factoryName: CFStringRef; getInterfaceFunction: CFPlugInInstanceGetInterfaceFunction): CFPlugInInstanceRef; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFPlugInIncludes}

{$ENDC} {__CFPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
