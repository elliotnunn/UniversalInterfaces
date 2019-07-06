{
 	File:		Palettes.p
 
 	Contains:	Palette Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1987-1993, 1995-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Palettes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PALETTES__}
{$SETC __PALETTES__ := 1}

{$I+}
{$SETC PalettesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	pmCourteous					= 0;							{ Record use of color on each device touched. }
	pmTolerant					= $0002;						{ render ciRGB if ciTolerance is exceeded by best match. }
	pmAnimated					= $0004;						{ reserve an index on each device touched and render ciRGB. }
	pmExplicit					= $0008;						{ no reserve, no render, no record; stuff index into port. }
	pmWhite						= $0010;
	pmBlack						= $0020;
	pmInhibitG2					= $0100;
	pmInhibitC2					= $0200;
	pmInhibitG4					= $0400;
	pmInhibitC4					= $0800;
	pmInhibitG8					= $1000;
	pmInhibitC8					= $2000;						{  NSetPalette Update Constants  }
	pmNoUpdates					= $8000;						{ no updates }
	pmBkUpdates					= $A000;						{ background updates only }
	pmFgUpdates					= $C000;						{ foreground updates only }
	pmAllUpdates				= $E000;						{ all updates }


TYPE
	ColorInfoPtr = ^ColorInfo;
	ColorInfo = RECORD
		ciRGB:					RGBColor;								{ true RGB values }
		ciUsage:				INTEGER;								{ color usage }
		ciTolerance:			INTEGER;								{ tolerance value }
		ciDataFields:			ARRAY [0..2] OF INTEGER;				{ private fields }
	END;

	ColorInfoHandle						= ^ColorInfoPtr;
	PalettePtr = ^Palette;
	Palette = RECORD
		pmEntries:				INTEGER;								{ entries in pmTable }
		pmDataFields:			ARRAY [0..6] OF INTEGER;				{ private fields }
		pmInfo:					ARRAY [0..0] OF ColorInfo;
	END;

	PaletteHandle						= ^PalettePtr;
PROCEDURE InitPalettes;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA90;
	{$ENDC}
FUNCTION NewPalette(entries: INTEGER; srcColors: CTabHandle; srcUsage: INTEGER; srcTolerance: INTEGER): PaletteHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA91;
	{$ENDC}
FUNCTION GetNewPalette(PaletteID: INTEGER): PaletteHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA92;
	{$ENDC}
PROCEDURE DisposePalette(srcPalette: PaletteHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA93;
	{$ENDC}
PROCEDURE ActivatePalette(srcWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA94;
	{$ENDC}
PROCEDURE SetPalette(dstWindow: WindowPtr; srcPalette: PaletteHandle; cUpdates: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA95;
	{$ENDC}
PROCEDURE NSetPalette(dstWindow: WindowPtr; srcPalette: PaletteHandle; nCUpdates: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA95;
	{$ENDC}
FUNCTION GetPalette(srcWindow: WindowPtr): PaletteHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA96;
	{$ENDC}
PROCEDURE CopyPalette(srcPalette: PaletteHandle; dstPalette: PaletteHandle; srcEntry: INTEGER; dstEntry: INTEGER; dstLength: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AAA1;
	{$ENDC}
PROCEDURE PmForeColor(dstEntry: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA97;
	{$ENDC}
PROCEDURE PmBackColor(dstEntry: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA98;
	{$ENDC}
PROCEDURE AnimateEntry(dstWindow: WindowPtr; dstEntry: INTEGER; {CONST}VAR srcRGB: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA99;
	{$ENDC}
PROCEDURE AnimatePalette(dstWindow: WindowPtr; srcCTab: CTabHandle; srcIndex: INTEGER; dstEntry: INTEGER; dstLength: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9A;
	{$ENDC}
PROCEDURE GetEntryColor(srcPalette: PaletteHandle; srcEntry: INTEGER; VAR dstRGB: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9B;
	{$ENDC}
PROCEDURE SetEntryColor(dstPalette: PaletteHandle; dstEntry: INTEGER; {CONST}VAR srcRGB: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9C;
	{$ENDC}
PROCEDURE GetEntryUsage(srcPalette: PaletteHandle; srcEntry: INTEGER; VAR dstUsage: INTEGER; VAR dstTolerance: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9D;
	{$ENDC}
PROCEDURE SetEntryUsage(dstPalette: PaletteHandle; dstEntry: INTEGER; srcUsage: INTEGER; srcTolerance: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9E;
	{$ENDC}
PROCEDURE CTab2Palette(srcCTab: CTabHandle; dstPalette: PaletteHandle; srcUsage: INTEGER; srcTolerance: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9F;
	{$ENDC}
PROCEDURE Palette2CTab(srcPalette: PaletteHandle; dstCTab: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AAA0;
	{$ENDC}
FUNCTION Entry2Index(entry: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AAA2;
	{$ENDC}
PROCEDURE RestoreDeviceClut(gd: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AAA2;
	{$ENDC}
PROCEDURE ResizePalette(p: PaletteHandle; size: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AAA2;
	{$ENDC}
PROCEDURE SaveFore(VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $AAA2;
	{$ENDC}
PROCEDURE SaveBack(VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040E, $AAA2;
	{$ENDC}
PROCEDURE RestoreFore({CONST}VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $AAA2;
	{$ENDC}
PROCEDURE RestoreBack({CONST}VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0410, $AAA2;
	{$ENDC}
FUNCTION SetDepth(gd: GDHandle; depth: INTEGER; whichFlags: INTEGER; flags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A13, $AAA2;
	{$ENDC}
FUNCTION HasDepth(gd: GDHandle; depth: INTEGER; whichFlags: INTEGER; flags: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A14, $AAA2;
	{$ENDC}
FUNCTION PMgrVersion: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AAA2;
	{$ENDC}
PROCEDURE SetPaletteUpdates(p: PaletteHandle; updates: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0616, $AAA2;
	{$ENDC}
FUNCTION GetPaletteUpdates(p: PaletteHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0417, $AAA2;
	{$ENDC}
FUNCTION GetGray(device: GDHandle; {CONST}VAR backGround: RGBColor; VAR foreGround: RGBColor): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C19, $AAA2;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PalettesIncludes}

{$ENDC} {__PALETTES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
