{
 	File:		CodeFragments.p
 
 	Contains:	Public Code Fragment Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8.1
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1992-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{
   •
   ===========================================================================================
   The Code Fragment Manager API
   =============================
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CodeFragments;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CODEFRAGMENTS__}
{$SETC __CODEFRAGMENTS__ := 1}

{$I+}
{$SETC CodeFragmentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   §
   ===========================================================================================
   General Types and Constants
   ===========================
}



CONST
	kCFragResourceType			= 'cfrg';
	kCFragResourceID			= 0;
	kCFragLibraryFileType		= 'shlb';
	kCFragAllFileTypes			= $FFFFFFFF;



TYPE
	CFragArchitecture					= OSType;

CONST
	kPowerPCCFragArch			= 'pwpc';
	kMotorola68KCFragArch		= 'm68k';
	kAnyCFragArch				= $3F3F3F3F;

{$IFC TARGET_CPU_PPC }
	kCompiledCFragArch			= 'pwpc';

{$ENDC}  {TARGET_CPU_PPC}

{$IFC TARGET_CPU_68K }
	kCompiledCFragArch			= 'm68k';

{$ENDC}  {TARGET_CPU_68K}


TYPE
	CFragVersionNumber					= UInt32;

CONST
	kNullCFragVersion			= 0;
	kWildcardCFragVersion		= $FFFFFFFF;



TYPE
	CFragUsage							= UInt8;

CONST
	kImportLibraryCFrag			= 0;							{  Standard CFM import library. }
	kApplicationCFrag			= 1;							{  MacOS application. }
	kDropInAdditionCFrag		= 2;							{  Application or library private extension/plug-in }
	kStubLibraryCFrag			= 3;							{  Import library used for linking only }
	kWeakStubLibraryCFrag		= 4;							{  Import library used for linking only and will be automatically weak linked }


	kIsCompleteCFrag			= 0;							{  A "base" fragment, not an update. }
	kFirstCFragUpdate			= 1;							{  The first update, others are numbered 2, 3, ... }


	kCFragGoesToEOF				= 0;





TYPE
	CFragLocatorKind					= UInt8;

CONST
	kMemoryCFragLocator			= 0;							{  Container is already addressable. }
	kDataForkCFragLocator		= 1;							{  Container is in a file's data fork. }
	kResourceCFragLocator		= 2;							{  Container is in a file's resource fork. }
	kByteStreamCFragLocator		= 3;							{  ! Reserved for possible future use! }
	kNamedFragmentCFragLocator	= 4;							{  ! Reserved for possible future use! }


{
   --------------------------------------------------------------------------------------
   A 'cfrg' resource consists of a header followed by a sequence of variable length
   members.  The constant kDefaultCFragNameLen only provides for a legal ANSI declaration
   and for a reasonable display in a debugger.  The actual name field is cut to fit.
   There may be "extensions" after the name, the memberSize field includes them.  The
   general form of an extension is a 16 bit type code followed by a 16 bit size in bytes.
   Only one standard extension type is defined at present, it is used by SOM's searching
   mechanism.
}



TYPE
	CFragUsage1UnionPtr = ^CFragUsage1Union;
	CFragUsage1Union = RECORD
		CASE INTEGER OF
																		{  ! Meaning differs depending on value of "usage". }
		0: (
			appStackSize:		UInt32;									{  If the fragment is an application. (Not used by CFM!) }
			);
	END;

	CFragUsage2UnionPtr = ^CFragUsage2Union;
	CFragUsage2Union = RECORD
		CASE INTEGER OF
																		{  ! Meaning differs depending on value of "usage". }
		0: (
			appSubdirID:		SInt16;									{  If the fragment is an application. }
			);
		1: (
			libFlags:			UInt16;									{  If the fragment is an import library. }
			);
	END;


CONST
																{  Bit masks for the CFragUsage2Union libFlags variant. }
	kCFragLibUsageMapPrivatelyMask = $0001;						{  Put container in app heap if necessary. }


TYPE
	CFragWhere1UnionPtr = ^CFragWhere1Union;
	CFragWhere1Union = RECORD
		CASE INTEGER OF
																		{  ! Meaning differs depending on value of "where". }
		0: (
			spaceID:			UInt32;									{  If the fragment is in memory.  (Actually an AddressSpaceID.) }
			);
		1: (
			forkKind:			OSType;									{  If the fragment is in an arbitrary byte stream fork. }
			);
	END;

	CFragWhere2UnionPtr = ^CFragWhere2Union;
	CFragWhere2Union = RECORD
		CASE INTEGER OF
																		{  ! Meaning differs depending on value of "where". }
		0: (
			forkInstance:		UInt16;									{  If the fragment is in an arbitrary byte stream fork. }
			);
	END;


CONST
	kDefaultCFragNameLen		= 16;



TYPE
	CFragResourceMemberPtr = ^CFragResourceMember;
	CFragResourceMember = RECORD
		architecture:			CFragArchitecture;
		reservedA:				UInt16;									{  ! Must be zero! }
		reservedB:				SInt8;									{  ! Must be zero! }
		updateLevel:			SInt8;
		currentVersion:			CFragVersionNumber;
		oldDefVersion:			CFragVersionNumber;
		uUsage1:				CFragUsage1Union;
		uUsage2:				CFragUsage2Union;
		usage:					SInt8;
		where:					SInt8;
		offset:					UInt32;
		length:					UInt32;
		uWhere1:				CFragWhere1Union;
		uWhere2:				CFragWhere2Union;
		extensionCount:			UInt16;									{  The number of extensions beyond the name. }
		memberSize:				UInt16;									{  Size in bytes, includes all extensions. }
		name:					PACKED ARRAY [0..15] OF UInt8;			{  ! Actually a sized PString. }
	END;

	CFragResourceExtensionHeaderPtr = ^CFragResourceExtensionHeader;
	CFragResourceExtensionHeader = RECORD
		extensionKind:			UInt16;
		extensionSize:			UInt16;
	END;

	CFragResourceSearchExtensionPtr = ^CFragResourceSearchExtension;
	CFragResourceSearchExtension = RECORD
		header:					CFragResourceExtensionHeader;
		libKind:				OSType;
		qualifiers:				SInt8;									{  ! Actually four PStrings. }
	END;


CONST
	kCFragResourceSearchExtensionKind = $30EE;



TYPE
	CFragResourcePtr = ^CFragResource;
	CFragResource = RECORD
		reservedA:				UInt32;									{  ! Must be zero! }
		reservedB:				UInt32;									{  ! Must be zero! }
		reservedC:				UInt16;									{  ! Must be zero! }
		version:				UInt16;
		reservedD:				UInt32;									{  ! Must be zero! }
		reservedE:				UInt32;									{  ! Must be zero! }
		reservedF:				UInt32;									{  ! Must be zero! }
		reservedG:				UInt32;									{  ! Must be zero! }
		reservedH:				UInt16;									{  ! Must be zero! }
		memberCount:			UInt16;
		firstMember:			CFragResourceMember;
	END;

	CFragResourceHandle					= ^CFragResourcePtr;

CONST
	kCurrCFragResourceVersion	= 1;




TYPE
	CFragConnectionID = ^LONGINT; { an opaque 32-bit type }
	CFragClosureID = ^LONGINT; { an opaque 32-bit type }
	CFragContainerID = ^LONGINT; { an opaque 32-bit type }
	CFragContextID = ^LONGINT; { an opaque 32-bit type }
	CFragLoadOptions					= UInt32;

CONST
	kReferenceCFrag				= $0001;						{  Try to use existing copy, increment reference counts. }
	kFindCFrag					= $0002;						{  Try find an existing copy, do not increment reference counts. }
	kPrivateCFragCopy			= $0005;						{  Prepare a new private copy.  (kReferenceCFrag | 0x0004) }


	kUnresolvedCFragSymbolAddress = 0;



TYPE
	CFragSymbolClass					= UInt8;

CONST
	kCodeCFragSymbol			= 0;
	kDataCFragSymbol			= 1;
	kTVectorCFragSymbol			= 2;
	kTOCCFragSymbol				= 3;
	kGlueCFragSymbol			= 4;


{
   §
   ===========================================================================================
   Macros and Functions
   ====================
}


FUNCTION GetSharedLibrary(libName: Str63; archType: CFragArchitecture; loadFlags: CFragLoadOptions; VAR connID: CFragConnectionID; VAR mainAddr: Ptr; errMessage: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $AA5A;
	{$ENDC}
FUNCTION GetDiskFragment({CONST}VAR fileSpec: FSSpec; offset: UInt32; length: UInt32; fragName: ConstStringPtr; loadFlags: CFragLoadOptions; VAR connID: CFragConnectionID; VAR mainAddr: Ptr; errMessage: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $AA5A;
	{$ENDC}
FUNCTION GetMemFragment(memAddr: UNIV Ptr; length: UInt32; fragName: ConstStringPtr; loadFlags: CFragLoadOptions; VAR connID: CFragConnectionID; VAR mainAddr: Ptr; errMessage: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $AA5A;
	{$ENDC}
FUNCTION CloseConnection(VAR connID: CFragConnectionID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $AA5A;
	{$ENDC}
FUNCTION FindSymbol(connID: CFragConnectionID; symName: Str255; VAR symAddr: Ptr; VAR symClass: CFragSymbolClass): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $AA5A;
	{$ENDC}
FUNCTION CountSymbols(connID: CFragConnectionID; VAR symCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $AA5A;
	{$ENDC}
FUNCTION GetIndSymbol(connID: CFragConnectionID; symIndex: LONGINT; symName: StringPtr; VAR symAddr: Ptr; VAR symClass: CFragSymbolClass): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $AA5A;
	{$ENDC}

{
   §
   ===========================================================================================
   Initialization & Termination Routines
   =====================================
}


{
   -----------------------------------------------------------------------------------------
   A fragment's initialization and termination routines are called when a new incarnation of
   the fragment is created or destroyed, respectively.  Exactly when this occurs depends on
   what kinds of section sharing the fragment has and how the fragment is prepared.  Import
   libraries have at most one incarnation per process.  Fragments prepared with option
   kPrivateCFragCopy may have many incarnations per process.
   The initialization function is passed a pointer to an initialization information structure
   and returns an OSErr.  If an initialization function returns a non-zero value the entire
   closure of which it is a part fails.  The C prototype for an initialization function is:
  		OSErr	CFragInitFunction	( const CFragInitBlock *	initBlock );
   The termination procedure takes no parameters and returns nothing.  The C prototype for a
   termination procedure is:
  		void	CFragTermProcedure	( void );
   Note that since the initialization and termination routines are themselves "CFM"-style
   routines whether or not they have the "pascal" keyword is irrelevant.
}


{
   -----------------------------------------------------------------------------------------
   ! Note:
   ! The "System7" portion of these type names was introduced during the evolution towards
   ! the now defunct Copland version of Mac OS.  Copland was to be called System 8 and there
   ! were slightly different types for System 7 and System 8.  The "generic" type names were
   ! conditionally defined for the desired target system.
   ! Always use the generic types, e.g. CFragInitBlock!  The "System7" names have been kept
   ! only to avoid perturbing code that (improperly) used the target specific type.
}



TYPE
	CFragSystem7MemoryLocatorPtr = ^CFragSystem7MemoryLocator;
	CFragSystem7MemoryLocator = RECORD
		address:				LogicalAddress;
		length:					UInt32;
		inPlace:				BOOLEAN;
		reservedA:				SInt8;									{  ! Must be zero! }
		reservedB:				UInt16;									{  ! Must be zero! }
	END;

	CFragSystem7DiskFlatLocatorPtr = ^CFragSystem7DiskFlatLocator;
	CFragSystem7DiskFlatLocator = RECORD
		fileSpec:				FSSpecPtr;
		offset:					UInt32;
		length:					UInt32;
	END;

{  ! This must have a file specification at the same offset as a disk flat locator! }
	CFragSystem7SegmentedLocatorPtr = ^CFragSystem7SegmentedLocator;
	CFragSystem7SegmentedLocator = RECORD
		fileSpec:				FSSpecPtr;
		rsrcType:				OSType;
		rsrcID:					SInt16;
		reservedA:				UInt16;									{  ! Must be zero! }
	END;

	CFragSystem7LocatorPtr = ^CFragSystem7Locator;
	CFragSystem7Locator = RECORD
		where:					SInt32;
		CASE INTEGER OF
		0: (
			onDisk:				CFragSystem7DiskFlatLocator;
			);
		1: (
			inMem:				CFragSystem7MemoryLocator;
			);
		2: (
			inSegs:				CFragSystem7SegmentedLocator;
			);
	END;

	CFragSystem7InitBlockPtr = ^CFragSystem7InitBlock;
	CFragSystem7InitBlock = RECORD
		contextID:				CFragContextID;
		closureID:				CFragClosureID;
		connectionID:			CFragConnectionID;
		fragLocator:			CFragSystem7Locator;
		libName:				StringPtr;
		reservedA:				UInt32;									{  ! Must be zero! }
	END;

	CFragInitBlock						= CFragSystem7InitBlock;
	CFragInitBlockPtr 					= ^CFragInitBlock;
{  These init/term routine types are only of value to CFM itself. }
{$IFC TYPED_FUNCTION_POINTERS}
	CFragInitFunction = FUNCTION({CONST}VAR initBlock: CFragInitBlock): OSErr; C;
{$ELSEC}
	CFragInitFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFragTermProcedure = PROCEDURE; C;
{$ELSEC}
	CFragTermProcedure = ProcPtr;
{$ENDC}

{
   §
   ===========================================================================================
   Old Name Spellings
   ==================
}


{
   -------------------------------------------------------------------------------------------
   We've tried to reduce the risk of name collisions in the future by introducing the phrase
   "CFrag" into constant and type names.  The old names are defined below in terms of the new.
}



CONST
	kLoadCFrag					= $0001;


{$IFC OLDROUTINENAMES }

TYPE
	ConnectionID						= CFragConnectionID;
	LoadFlags							= CFragLoadOptions;
	SymClass							= CFragSymbolClass;
	InitBlock							= CFragInitBlock;
	InitBlockPtr 						= ^InitBlock;
	MemFragment							= CFragSystem7MemoryLocator;
	MemFragmentPtr 						= ^MemFragment;
	DiskFragment						= CFragSystem7DiskFlatLocator;
	DiskFragmentPtr 					= ^DiskFragment;
	SegmentedFragment					= CFragSystem7SegmentedLocator;
	SegmentedFragmentPtr 				= ^SegmentedFragment;
	FragmentLocator						= CFragSystem7Locator;
	FragmentLocatorPtr 					= ^FragmentLocator;
	CFragHFSMemoryLocator				= CFragSystem7MemoryLocator;
	CFragHFSMemoryLocatorPtr 			= ^CFragHFSMemoryLocator;
	CFragHFSDiskFlatLocator				= CFragSystem7DiskFlatLocator;
	CFragHFSDiskFlatLocatorPtr 			= ^CFragHFSDiskFlatLocator;
	CFragHFSSegmentedLocator			= CFragSystem7SegmentedLocator;
	CFragHFSSegmentedLocatorPtr 		= ^CFragHFSSegmentedLocator;
	CFragHFSLocator						= CFragSystem7Locator;
	CFragHFSLocatorPtr 					= ^CFragHFSLocator;

CONST
	kPowerPCArch				= 'pwpc';
	kMotorola68KArch			= 'm68k';
	kAnyArchType				= $3F3F3F3F;
	kNoLibName					= 0;
	kNoConnectionID				= 0;
	kLoadLib					= $0001;
	kFindLib					= $0002;
	kNewCFragCopy				= $0005;
	kLoadNewCopy				= $0005;
	kUseInPlace					= $80;
	kCodeSym					= 0;
	kDataSym					= 1;
	kTVectSym					= 2;
	kTOCSym						= 3;
	kGlueSym					= 4;
	kInMem						= 0;
	kOnDiskFlat					= 1;
	kOnDiskSegmented			= 2;
	kIsLib						= 0;
	kIsApp						= 1;
	kIsDropIn					= 2;
	kFullLib					= 0;
	kUpdateLib					= 1;
	kWholeFork					= 0;
	kCFMRsrcType				= 'cfrg';
	kCFMRsrcID					= 0;
	kSHLBFileType				= 'shlb';
	kUnresolvedSymbolAddress	= 0;

	kPowerPC					= 'pwpc';
	kMotorola68K				= 'm68k';

{$ENDC}  {OLDROUTINENAMES}





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CodeFragmentsIncludes}

{$ENDC} {__CODEFRAGMENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
