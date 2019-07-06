{
 	File:		Resources.p
 
 	Contains:	Resource Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

FUNCTION NewResErrProc(userRoutine: ResErrProcPtr): ResErrUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallResErrProc(thErr: OSErr; userRoutine: ResErrUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{$IFC NOT TARGET_OS_MAC }
{  QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ResourceEndianFilterPtr = FUNCTION(theResource: Handle; currentlyNativeEndian: BOOLEAN): OSErr;
{$ELSEC}
	ResourceEndianFilterPtr = ProcPtr;
{$ENDC}

{$ENDC}

FUNCTION InitResources: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A995;
	{$ENDC}
PROCEDURE RsrcZoneInit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A996;
	{$ENDC}
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
PROCEDURE CreateResFile(fileName: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B1;
	{$ENDC}
FUNCTION OpenResFile(fileName: Str255): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A997;
	{$ENDC}
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
FUNCTION RsrcMapEntry(theResource: Handle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C5;
	{$ENDC}
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
FUNCTION RGetResource(theType: ResType; theID: INTEGER): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80C;
	{$ENDC}
{
	Note: 	The HOpenResFile trap was not implemented until System 7.  If you want to call HOpenResFile
			while running on System 6 machines, then define USE_HOPENRESFILE_GLUE and link with
			Interface.o which contains glue to implement HOpenResFile on pre-System 7 machines.
}
{$IFC NOT UNDEFINED USE_HOPENRESFILE_GLUE }
FUNCTION HOpenResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; permission: SInt8): INTEGER;
{$ELSEC}
FUNCTION HOpenResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; permission: SInt8): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81A;
	{$ENDC}
{$ENDC}

{
	Note: 	The HCreateResFile trap was not implemented until System 7.  If you want to call HCreateResFile
			while running on System 6 machines, then define USE_HCREATERESFILE_GLUE and link with
			Interface.o which contains glue to implement HCreateResFile on pre-System 7 machines.
}
{$IFC NOT UNDEFINED USE_HCREATERESFILE_GLUE }
PROCEDURE HCreateResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255);
{$ELSEC}
PROCEDURE HCreateResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81B;
	{$ENDC}
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

{$IFC NOT TARGET_OS_MAC }
{  QuickTime 3.0 }
FUNCTION RegisterResourceEndianFilter(theType: ResType; theFilterProc: ResourceEndianFilterPtr): OSErr; C;
{$ENDC}

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

{$IFC OLDROUTINENAMES }
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
