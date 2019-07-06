{
     File:       CMMComponent.p
 
     Contains:   ColorSync CMM Component API
 
     Version:    Technology: ColorSync 2.6
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1994-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
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
																{  Required  }
	kNCMMInit					= 6;
	kCMMMatchColors				= 1;
	kCMMCheckColors				= 2;							{  }
																{  }
																{  Optional  }
	kCMMValidateProfile			= 8;
	kCMMMatchBitmap				= 9;
	kCMMCheckBitmap				= 10;
	kCMMMatchPixMap				= 3;
	kCMMCheckPixMap				= 4;
	kCMMConcatenateProfiles		= 5;
	kCMMConcatInit				= 7;
	kCMMNewLinkProfile			= 16;
	kNCMMConcatInit				= 18;
	kNCMMNewLinkProfile			= 19;
	kCMMGetPS2ColorSpace		= 11;
	kCMMGetPS2ColorRenderingIntent = 12;
	kCMMGetPS2ColorRendering	= 13;
	kCMMGetPS2ColorRenderingVMSize = 17;						{  }
																{  }
																{  obsolete with ColorSync 2.5  }
	kCMMFlattenProfile			= 14;
	kCMMUnflattenProfile		= 15;							{  }
																{  }
																{  obsolete with ColorSync 2.6  }
	kCMMInit					= 0;
	kCMMGetNamedColorInfo		= 70;
	kCMMGetNamedColorValue		= 71;
	kCMMGetIndNamedColorValue	= 72;
	kCMMGetNamedColorIndex		= 73;
	kCMMGetNamedColorName		= 74;

{$IFC TARGET_API_MAC_OS8 }

TYPE
	CMMComponentInst					= ComponentInstance;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION NCMMInit(cmm: CMMComponentInst; srcProfile: CMProfileRef; dstProfile: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION CMMInit(cmm: CMMComponentInst; srcProfile: CMProfileHandle; dstProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION CMMMatchColors(cmm: CMMComponentInst; VAR colors: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION CMMCheckColors(cmm: CMMComponentInst; VAR colors: CMColor; count: UInt32; VAR result: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION CMMValidateProfile(cmm: CMMComponentInst; prof: CMProfileRef; VAR valid: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION CMMFlattenProfile(cmm: CMMComponentInst; prof: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION CMMUnflattenProfile(cmm: CMMComponentInst; VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION CMMMatchBitmap(cmm: CMMComponentInst; VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION CMMCheckBitmap(cmm: CMMComponentInst; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION CMMMatchPixMap(cmm: CMMComponentInst; VAR pixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION CMMCheckPixMap(cmm: CMMComponentInst; {CONST}VAR pixMap: PixMap; progressProc: CMBitmapCallBackUPP; VAR bitMap: BitMap; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION CMMConcatInit(cmm: CMMComponentInst; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION NCMMConcatInit(cmm: CMMComponentInst; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION CMMNewLinkProfile(cmm: CMMComponentInst; VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION NCMMNewLinkProfile(cmm: CMMComponentInst; prof: CMProfileRef; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorSpace(cmm: CMMComponentInst; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRenderingIntent(cmm: CMMComponentInst; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRendering(cmm: CMMComponentInst; srcProf: CMProfileRef; dstProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRenderingVMSize(cmm: CMMComponentInst; srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION CMMConcatenateProfiles(cmm: CMMComponentInst; thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorInfo(cmm: CMMComponentInst; srcProf: CMProfileRef; VAR deviceChannels: UInt32; VAR deviceColorSpace: OSType; VAR PCSColorSpace: OSType; VAR count: UInt32; prefix: StringPtr; suffix: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0046, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorValue(cmm: CMMComponentInst; prof: CMProfileRef; name: StringPtr; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0047, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetIndNamedColorValue(cmm: CMMComponentInst; prof: CMProfileRef; index: UInt32; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0048, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorIndex(cmm: CMMComponentInst; prof: CMProfileRef; name: StringPtr; VAR index: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0049, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetNamedColorName(cmm: CMMComponentInst; prof: CMProfileRef; index: UInt32; name: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $004A, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OLDROUTINENAMES }
{$ENDC}  {OLDROUTINENAMES}
{$ELSEC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CMMOpen(VAR cmmStorage: UInt32; hInstance: UNIV Ptr): CMError;
FUNCTION CMMClose(VAR cmmStorage: UInt32): CMError;
FUNCTION CMMGetCMMInfo(VAR cmmStorage: UInt32; VAR info: CMMInfo): CMError;
FUNCTION NCMMInit(VAR cmmStorage: UInt32; srcProfile: CMProfileRef; dstProfile: CMProfileRef): CMError;
FUNCTION CMMMatchColors(VAR cmmStorage: UInt32; VAR colors: CMColor; count: UInt32): CMError;
FUNCTION CMMCheckColors(VAR cmmStorage: UInt32; VAR colors: CMColor; count: UInt32; VAR result: UInt32): CMError;
FUNCTION CMMValidateProfile(VAR cmmStorage: UInt32; prof: CMProfileRef; VAR valid: BOOLEAN): CMError;
FUNCTION CMMMatchBitmap(VAR cmmStorage: UInt32; VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
FUNCTION CMMCheckBitmap(VAR cmmStorage: UInt32; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
FUNCTION CMMMatchPixMap(VAR cmmStorage: UInt32; VAR pixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
FUNCTION CMMCheckPixMap(VAR cmmStorage: UInt32; {CONST}VAR pixMap: PixMap; progressProc: CMBitmapCallBackUPP; VAR bitMap: BitMap; refCon: UNIV Ptr): CMError;
FUNCTION CMMConcatInit(VAR cmmStorage: UInt32; VAR profileSet: CMConcatProfileSet): CMError;
FUNCTION NCMMConcatInit(VAR cmmStorage: UInt32; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
FUNCTION CMMNewLinkProfile(VAR cmmStorage: UInt32; VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
FUNCTION NCMMNewLinkProfile(VAR cmmStorage: UInt32; prof: CMProfileRef; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
FUNCTION CMMGetPS2ColorSpace(VAR cmmStorage: UInt32; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
FUNCTION CMMGetPS2ColorRenderingIntent(VAR cmmStorage: UInt32; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
FUNCTION CMMGetPS2ColorRendering(VAR cmmStorage: UInt32; srcProf: CMProfileRef; dstProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
FUNCTION CMMGetPS2ColorRenderingVMSize(VAR cmmStorage: UInt32; srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: UInt32): CMError;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_API_MAC_OS8}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMMComponentIncludes}

{$ENDC} {__CMMCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
