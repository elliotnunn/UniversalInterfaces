{
 	File:		QDOffscreen.p
 
 	Contains:	Quickdraw Offscreen GWorld Interfaces.
 
 	Version:	Technology:	Mac OS 8
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
 UNIT QDOffscreen;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QDOFFSCREEN__}
{$SETC __QDOFFSCREEN__ := 1}

{$I+}
{$SETC QDOffscreenIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
	NOTE: 	GWorldFlags is no longer defined as a SET.  Instead it is a LONGINT
			and the set elements are bit masks.  You will need to use Bit-OR's 
			to build a set and Bit-AND's to test sets.
}

CONST
	pixPurgeBit					= 0;
	noNewDeviceBit				= 1;
	useTempMemBit				= 2;
	keepLocalBit				= 3;
	pixelsPurgeableBit			= 6;
	pixelsLockedBit				= 7;
	mapPixBit					= 16;
	newDepthBit					= 17;
	alignPixBit					= 18;
	newRowBytesBit				= 19;
	reallocPixBit				= 20;
	clipPixBit					= 28;
	stretchPixBit				= 29;
	ditherPixBit				= 30;
	gwFlagErrBit				= 31;

	pixPurge					= $00000001;
	noNewDevice					= $00000002;
	useTempMem					= $00000004;
	keepLocal					= $00000008;
	pixelsPurgeable				= $00000040;
	pixelsLocked				= $00000080;
	kAllocDirectDrawSurface		= $00004000;
	mapPix						= $00010000;
	newDepth					= $00020000;
	alignPix					= $00040000;
	newRowBytes					= $00080000;
	reallocPix					= $00100000;
	clipPix						= $10000000;
	stretchPix					= $20000000;
	ditherPix					= $40000000;
	gwFlagErr					= $80000000;


TYPE
	GWorldFlags							= UInt32;
{ Type definition of a GWorldPtr }
	GWorldPtr							= CGrafPtr;
FUNCTION NewGWorld(VAR offscreenGWorld: GWorldPtr; PixelDepth: INTEGER; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): QDErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0016, $0000, $AB1D;
	{$ENDC}
{$IFC NOT TARGET_OS_MAC }
{ Quicktime 3.0 }
{$IFC TARGET_OS_WIN32 }
{  gdevice attribute bits }

CONST
	deviceIsIndirect			= $00000001;
	deviceNeedsLock				= $00000002;
	deviceIsStatic				= $00000004;
	deviceIsExternalBuffer		= $00000008;
	deviceIsDDSurface			= $00000010;
	deviceIsDCISurface			= $00000020;
	deviceIsGDISurface			= $00000040;
	deviceIsAScreen				= $00000080;
	deviceIsOverlaySurface		= $00000100;

FUNCTION GetGDeviceSurface(gdh: GDHandle): Ptr;
FUNCTION GetGDeviceAttributes(gdh: GDHandle): UInt32;
{ to allocate non-mac-rgb GWorlds use QTNewGWorld (ImageCompression.h) }
FUNCTION NewGWorldFromHBITMAP(VAR offscreenGWorld: GWorldPtr; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags; newHBITMAP: UNIV Ptr; newHDC: UNIV Ptr): QDErr;
{$ENDC}
FUNCTION NewGWorldFromPtr(VAR offscreenGWorld: GWorldPtr; PixelFormat: UInt32; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags; newBuffer: Ptr; rowBytes: LONGINT): QDErr;
{$ENDC}

FUNCTION LockPixels(pm: PixMapHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0001, $AB1D;
	{$ENDC}
PROCEDURE UnlockPixels(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0002, $AB1D;
	{$ENDC}
FUNCTION UpdateGWorld(VAR offscreenGWorld: GWorldPtr; pixelDepth: INTEGER; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): GWorldFlags;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0016, $0003, $AB1D;
	{$ENDC}
PROCEDURE DisposeGWorld(offscreenGWorld: GWorldPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0004, $AB1D;
	{$ENDC}
PROCEDURE GetGWorld(VAR port: CGrafPtr; VAR gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0005, $AB1D;
	{$ENDC}
PROCEDURE SetGWorld(port: CGrafPtr; gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0006, $AB1D;
	{$ENDC}
PROCEDURE CTabChanged(ctab: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0007, $AB1D;
	{$ENDC}
PROCEDURE PixPatChanged(ppat: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0008, $AB1D;
	{$ENDC}
PROCEDURE PortChanged(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0009, $AB1D;
	{$ENDC}
PROCEDURE GDeviceChanged(gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000A, $AB1D;
	{$ENDC}
PROCEDURE AllowPurgePixels(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000B, $AB1D;
	{$ENDC}
PROCEDURE NoPurgePixels(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000C, $AB1D;
	{$ENDC}
FUNCTION GetPixelsState(pm: PixMapHandle): GWorldFlags;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000D, $AB1D;
	{$ENDC}
PROCEDURE SetPixelsState(pm: PixMapHandle; state: GWorldFlags);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000E, $AB1D;
	{$ENDC}
FUNCTION GetPixBaseAddr(pm: PixMapHandle): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000F, $AB1D;
	{$ENDC}
FUNCTION NewScreenBuffer({CONST}VAR globalRect: Rect; purgeable: BOOLEAN; VAR gdh: GDHandle; VAR offscreenPixMap: PixMapHandle): QDErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000E, $0010, $AB1D;
	{$ENDC}
PROCEDURE DisposeScreenBuffer(offscreenPixMap: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0011, $AB1D;
	{$ENDC}
FUNCTION GetGWorldDevice(offscreenGWorld: GWorldPtr): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0012, $AB1D;
	{$ENDC}
FUNCTION QDDone(port: GrafPtr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0013, $AB1D;
	{$ENDC}
FUNCTION OffscreenVersion: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AB1D;
	{$ENDC}
FUNCTION NewTempScreenBuffer({CONST}VAR globalRect: Rect; purgeable: BOOLEAN; VAR gdh: GDHandle; VAR offscreenPixMap: PixMapHandle): QDErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000E, $0015, $AB1D;
	{$ENDC}
FUNCTION PixMap32Bit(pmHandle: PixMapHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0016, $AB1D;
	{$ENDC}
FUNCTION GetGWorldPixMap(offscreenGWorld: GWorldPtr): PixMapHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0017, $AB1D;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QDOffscreenIncludes}

{$ENDC} {__QDOFFSCREEN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
