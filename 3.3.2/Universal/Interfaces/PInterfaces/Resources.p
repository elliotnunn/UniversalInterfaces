{
     File:       Resources.p
 
     Contains:   Resource Manager Interfaces.
 
     Version:    Technology: Mac OS 8.1
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Resources;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RESOURCES__}
{$SETC __RESOURCES__ := 1}

{$I+}
{$SETC ResourcesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



CONST
	resSysHeap					= 64;							{ System or application heap? }
	resPurgeable				= 32;							{ Purgeable resource? }
	resLocked					= 16;							{ Load it in locked? }
	resProtected				= 8;							{ Protected? }
	resPreload					= 4;							{ Load in on OpenResFile? }
	resChanged					= 2;							{ Resource changed? }
	mapReadOnly					= 128;							{ Resource file read-only }
	mapCompact					= 64;							{ Compact resource file }
	mapChanged					= 32;							{ Write map out at update }

	resSysRefBit				= 7;							{ reference to system/local reference }
	resSysHeapBit				= 6;							{ In system/in application heap }
	resPurgeableBit				= 5;							{ Purgeable/not purgeable }
	resLockedBit				= 4;							{ Locked/not locked }
	resProtectedBit				= 3;							{ Protected/not protected }
	resPreloadBit				= 2;							{ Read in at OpenResource? }
	resChangedBit				= 1;							{ Existing resource changed since last update }
	mapReadOnlyBit				= 7;							{ is this file read-only? }
	mapCompactBit				= 6;							{ Is a compact necessary? }
	mapChangedBit				= 5;							{ Is it necessary to write map? }

	kResFileNotOpened			= -1;							{ ref num return as error when opening a resource file }
	kSystemResFile				= 0;							{ this is the default ref num to the system file }



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ResErrProcPtr = PROCEDURE(thErr: OSErr);
{$ELSEC}
	ResErrProcPtr = Register68kProcPtr;
{$ENDC}

	ResErrUPP = UniversalProcPtr;

CONST
	uppResErrProcInfo = $00001002;

FUNCTION NewResErrUPP(userRoutine: ResErrProcPtr): ResErrUPP; { old name was NewResErrProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeResErrUPP(userUPP: ResErrUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeResErrUPP(thErr: OSErr; userRoutine: ResErrUPP); { old name was CallResErrProc }
{  QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ResourceEndianFilterPtr = FUNCTION(theResource: Handle; currentlyNativeEndian: BOOLEAN): OSErr;
{$ELSEC}
	ResourceEndianFilterPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitResources: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A995;
	{$ENDC}
PROCEDURE RsrcZoneInit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A996;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE CloseResFile(refNum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A99A;
	{$ENDC}
FUNCTION ResError: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9AF;
	{$ENDC}
FUNCTION CurResFile: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A994;
	{$ENDC}
FUNCTION HomeResFile(theResource: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A4;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE CreateResFile(fileName: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B1;
	{$ENDC}
FUNCTION OpenResFile(fileName: Str255): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A997;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE UseResFile(refNum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A998;
	{$ENDC}
FUNCTION CountTypes: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A99E;
	{$ENDC}
FUNCTION Count1Types: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81C;
	{$ENDC}
PROCEDURE GetIndType(VAR theType: ResType; index: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A99F;
	{$ENDC}
PROCEDURE Get1IndType(VAR theType: ResType; index: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80F;
	{$ENDC}
PROCEDURE SetResLoad(load: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A99B;
	{$ENDC}
FUNCTION CountResources(theType: ResType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A99C;
	{$ENDC}
FUNCTION Count1Resources(theType: ResType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80D;
	{$ENDC}
FUNCTION GetIndResource(theType: ResType; index: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A99D;
	{$ENDC}
FUNCTION Get1IndResource(theType: ResType; index: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80E;
	{$ENDC}
FUNCTION GetResource(theType: ResType; theID: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A0;
	{$ENDC}
FUNCTION Get1Resource(theType: ResType; theID: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81F;
	{$ENDC}
FUNCTION GetNamedResource(theType: ResType; name: Str255): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A1;
	{$ENDC}
FUNCTION Get1NamedResource(theType: ResType; name: Str255): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A820;
	{$ENDC}
PROCEDURE LoadResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A2;
	{$ENDC}
PROCEDURE ReleaseResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A3;
	{$ENDC}
PROCEDURE DetachResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A992;
	{$ENDC}
FUNCTION UniqueID(theType: ResType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C1;
	{$ENDC}
FUNCTION Unique1ID(theType: ResType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A810;
	{$ENDC}
FUNCTION GetResAttrs(theResource: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A6;
	{$ENDC}
PROCEDURE GetResInfo(theResource: Handle; VAR theID: INTEGER; VAR theType: ResType; VAR name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A8;
	{$ENDC}
PROCEDURE SetResInfo(theResource: Handle; theID: INTEGER; name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A9;
	{$ENDC}
PROCEDURE AddResource(theData: Handle; theType: ResType; theID: INTEGER; name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9AB;
	{$ENDC}
FUNCTION GetResourceSizeOnDisk(theResource: Handle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A5;
	{$ENDC}
FUNCTION GetMaxResourceSize(theResource: Handle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A821;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION RsrcMapEntry(theResource: Handle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C5;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

PROCEDURE SetResAttrs(theResource: Handle; attrs: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A7;
	{$ENDC}
PROCEDURE ChangedResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9AA;
	{$ENDC}
PROCEDURE RemoveResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9AD;
	{$ENDC}
PROCEDURE UpdateResFile(refNum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A999;
	{$ENDC}
PROCEDURE WriteResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B0;
	{$ENDC}
PROCEDURE SetResPurge(install: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A993;
	{$ENDC}
FUNCTION GetResFileAttrs(refNum: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F6;
	{$ENDC}
PROCEDURE SetResFileAttrs(refNum: INTEGER; attrs: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F7;
	{$ENDC}
FUNCTION OpenRFPerm(fileName: Str255; vRefNum: INTEGER; permission: SInt8): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C4;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION RGetResource(theType: ResType; theID: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80C;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION HOpenResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; permission: SInt8): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81A;
	{$ENDC}
PROCEDURE HCreateResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81B;
	{$ENDC}
FUNCTION FSpOpenResFile({CONST}VAR spec: FSSpec; permission: SignedByte): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AA52;
	{$ENDC}
PROCEDURE FSpCreateResFile({CONST}VAR spec: FSSpec; creator: OSType; fileType: OSType; scriptTag: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AA52;
	{$ENDC}
PROCEDURE ReadPartialResource(theResource: Handle; offset: LONGINT; buffer: UNIV Ptr; count: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A822;
	{$ENDC}
PROCEDURE WritePartialResource(theResource: Handle; offset: LONGINT; buffer: UNIV Ptr; count: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A822;
	{$ENDC}
PROCEDURE SetResourceSize(theResource: Handle; newSize: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A822;
	{$ENDC}
FUNCTION GetNextFOND(fondHandle: Handle): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $A822;
	{$ENDC}
{  QuickTime 3.0 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION RegisterResourceEndianFilter(theType: ResType; theFilterProc: ResourceEndianFilterPtr): OSErr; C;
{ Use TempInsertROMMap to force the ROM resource map to be
   inserted into the chain in front of the system. Note that
   this call is only temporary - the modified resource chain
   is only used for the next call to the resource manager.
   See IM IV 19 for more information. 
}
PROCEDURE TempInsertROMMap(tempResLoad: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $4A1F, $56C0, $31C0, $0B9E;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • RESOURCE CHAIN LOCATION - for use with the Resource Manager chain manipulation routines under Carbon.
  _________________________________________________________________________________________________________
}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	RsrcChainLocation					= SInt16;

CONST
	kRsrcChainBelowSystemMap	= 0;							{  Below the system's resource map }
	kRsrcChainBelowApplicationMap = 1;							{  Below the application's resource map }
	kRsrcChainAboveApplicationMap = 2;							{  Above the application's resource map }
	kRsrcChainAboveAllMaps		= 4;							{  Above all resource maps }

{
   If the file is already in the resource chain, it is removed and re-inserted at the specified location
   If the file has been detached, it is added to the resource chain at the specified location
   Returns resFNotFound if it's not currently open.
}
FUNCTION InsertResourceFile(refNum: SInt16; where: RsrcChainLocation): OSErr;
{
   If the file is not currently in the resource chain, this returns resNotFound
   Otherwise, the resource file is removed from the resource chain.
}
FUNCTION DetachResourceFile(refNum: SInt16): OSErr;
{
   Returns true if the resource file is already open and known by the Resource Manager (i.e., it is
   either in the current resource chain or it's a detached resource file.)  If it's in the resource 
   chain, the inChain Boolean is set to true on exit and true is returned.  If it's an open file, but
   the file is currently detached, inChain is set to false and true is returned.  If the file is open,
   the refNum to the file is returned.
}
FUNCTION FSpResourceFileAlreadyOpen({CONST}VAR resourceFile: FSSpec; VAR inChain: BOOLEAN; VAR refNum: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $A822;
	{$ENDC}
{
   FSpOpenOrphanResFile should be used to open a resource file that is persistent across all contexts,
   because using OpenResFile normally loads a map and all preloaded resources into the application
   context.  FSpOpenOrphanResFile loads everything into the system context and detaches the file 
   from the context in which it was opened.  If the file is already in the resource chain and a new
   instance is not opened, FSpOpenOrphanResFile will return a paramErr.
   Use with care, as can and will fail if the map is very large or a lot of preload
   resources exist.
}
FUNCTION FSpOpenOrphanResFile({CONST}VAR spec: FSSpec; permission: SignedByte; VAR refNum: SInt16): OSErr;
{
   GetTopResourceFile returns the refNum of the top most resource map in the current resource chain. If
   the resource chain is empty it returns resFNotFound.
}
FUNCTION GetTopResourceFile(VAR refNum: SInt16): OSErr;
{
   GetNextResourceFile can be used to iterate over resource files in the resource chain. By passing a
   valid refNum in curRefNum it will return in nextRefNum the refNum of the next file in 
   the chain. If curRefNum is not found in the resource chain, GetNextResourceFile returns resFNotFound.
   When the end of the chain is reached GetNextResourceFile will return noErr and nextRefNum will be NIL.
}
FUNCTION GetNextResourceFile(curRefNum: SInt16; VAR nextRefNum: SInt16): OSErr;

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SizeResource(theResource: Handle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9A5;
	{$ENDC}
FUNCTION MaxSizeRsrc(theResource: Handle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A821;
	{$ENDC}
PROCEDURE RmveResource(theResource: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9AD;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{
    These typedefs were originally created for the Copland Resource Mangager
}

TYPE
	ResFileRefNum						= INTEGER;
	ResID								= INTEGER;
	ResAttributes						= INTEGER;
	ResFileAttributes					= INTEGER;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ResourcesIncludes}

{$ENDC} {__RESOURCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
