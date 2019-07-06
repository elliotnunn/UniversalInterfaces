{
 	File:		CMMComponent.p
 
 	Contains:	ColorSync CMM Component API
 
 	Version:	Technology:	ColorSync 2.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMMComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMMCOMPONENT__}
{$SETC __CMMCOMPONENT__ := 1}

{$I+}
{$SETC CMMComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	CMMInterfaceVersion			= 1;

{ Component function selectors }
{ Required }
	kCMMInit					= 0;
	kNCMMInit					= 6;
	kCMMMatchColors				= 1;
	kCMMCheckColors				= 2;

{ Optional }
	kCMMValidateProfile			= 8;
	kCMMFlattenProfile			= 14;
	kCMMUnflattenProfile		= 15;
	kCMMMatchBitmap				= 9;
	kCMMCheckBitmap				= 10;
	kCMMMatchPixMap				= 3;
	kCMMCheckPixMap				= 4;
	kCMMConcatenateProfiles		= 5;
	kCMMConcatInit				= 7;
	kCMMNewLinkProfile			= 16;
	kCMMGetPS2ColorSpace		= 11;
	kCMMGetPS2ColorRenderingIntent = 12;
	kCMMGetPS2ColorRendering	= 13;
	kCMMGetPS2ColorRenderingVMSize = 17;
	kCMMGetNamedColorInfo		= 70;
	kCMMGetNamedColorValue		= 71;
	kCMMGetIndNamedColorValue	= 72;
	kCMMGetNamedColorIndex		= 73;
	kCMMGetNamedColorName		= 74;


FUNCTION NCMInit(CMSession: ComponentInstance; srcProfile: CMProfileRef; dstProfile: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION CMInit(CMSession: ComponentInstance; srcProfile: CMProfileHandle; dstProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION CMMatchColors(CMSession: ComponentInstance; VAR myColors: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION CMCheckColors(CMSession: ComponentInstance; VAR myColors: CMColor; count: UInt32; VAR result: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}

{ Optional functions }
FUNCTION CMMValidateProfile(CMSession: ComponentInstance; prof: CMProfileRef; VAR valid: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION CMMFlattenProfile(CMSession: ComponentInstance; prof: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION CMMUnflattenProfile(CMSession: ComponentInstance; VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION CMMatchBitmap(CMSession: ComponentInstance; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION CMCheckBitmap(CMSession: ComponentInstance; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION CMMatchPixMap(CMSession: ComponentInstance; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION CMCheckPixMap(CMSession: ComponentInstance; {CONST}VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; VAR myBitMap: BitMap; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION CMConcatInit(CMSession: ComponentInstance; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION CMNewLinkProfile(CMSession: ComponentInstance; VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorSpace(CMSession: ComponentInstance; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRenderingIntent(CMSession: ComponentInstance; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRendering(CMSession: ComponentInstance; srcProf: CMProfileRef; dstProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRenderingVMSize(CMSession: ComponentInstance; srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION CMConcatenateProfiles(CMSession: ComponentInstance; thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0005, $7000, $A82A;
	{$ENDC}
{ Named Color functions }
FUNCTION CMMGetNamedColorInfo(CMSession: ComponentInstance; srcProf: CMProfileRef; VAR deviceChannels: UInt32; VAR deviceColorSpace: OSType; VAR PCSColorSpace: OSType; VAR count: UInt32; prefix: StringPtr; suffix: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0046, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorValue(CMSession: ComponentInstance; prof: CMProfileRef; name: StringPtr; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0047, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetIndNamedColorValue(CMSession: ComponentInstance; prof: CMProfileRef; index: UInt32; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0048, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorIndex(CMSession: ComponentInstance; prof: CMProfileRef; name: StringPtr; VAR index: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0049, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorName(CMSession: ComponentInstance; prof: CMProfileRef; index: UInt32; name: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $004A, $7000, $A82A;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMMComponentIncludes}

{$ENDC} {__CMMCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
