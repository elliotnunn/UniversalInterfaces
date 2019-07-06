{
     File:       UnicodeConverter.p
 
     Contains:   Types, constants, and prototypes for Unicode Converter
 
     Version:    Technology: Mac OS 9.0
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
 UNIT UnicodeConverter;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __UNICODECONVERTER__}
{$SETC __UNICODECONVERTER__ := 1}

{$I+}
{$SETC UnicodeConverterIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Unicode conversion contexts: }

TYPE
	TextToUnicodeInfo = ^LONGINT; { an opaque 32-bit type }
	UnicodeToTextInfo = ^LONGINT; { an opaque 32-bit type }
	UnicodeToTextRunInfo = ^LONGINT; { an opaque 32-bit type }
	ConstTextToUnicodeInfo				= TextToUnicodeInfo;
	ConstUnicodeToTextInfo				= UnicodeToTextInfo;
{ UnicodeMapVersion type & values }
	UnicodeMapVersion					= SInt32;

CONST
	kUnicodeUseLatestMapping	= -1;
	kUnicodeUseHFSPlusMapping	= 4;

{ Types used in conversion }

TYPE
	UnicodeMappingPtr = ^UnicodeMapping;
	UnicodeMapping = RECORD
		unicodeEncoding:		TextEncoding;
		otherEncoding:			TextEncoding;
		mappingVersion:			UnicodeMapVersion;
	END;

	ConstUnicodeMappingPtr				= ^UnicodeMapping;
{ Control flags for ConvertFromUnicodeToText and ConvertFromTextToUnicode }

CONST
	kUnicodeUseFallbacksBit		= 0;
	kUnicodeKeepInfoBit			= 1;
	kUnicodeDirectionalityBits	= 2;
	kUnicodeVerticalFormBit		= 4;
	kUnicodeLooseMappingsBit	= 5;
	kUnicodeStringUnterminatedBit = 6;
	kUnicodeTextRunBit			= 7;
	kUnicodeKeepSameEncodingBit	= 8;
	kUnicodeForceASCIIRangeBit	= 9;
	kUnicodeNoHalfwidthCharsBit	= 10;
	kUnicodeTextRunHeuristicsBit = 11;

	kUnicodeUseFallbacksMask	= $00000001;
	kUnicodeKeepInfoMask		= $00000002;
	kUnicodeDirectionalityMask	= $0000000C;
	kUnicodeVerticalFormMask	= $00000010;
	kUnicodeLooseMappingsMask	= $00000020;
	kUnicodeStringUnterminatedMask = $00000040;
	kUnicodeTextRunMask			= $00000080;
	kUnicodeKeepSameEncodingMask = $00000100;
	kUnicodeForceASCIIRangeMask	= $00000200;
	kUnicodeNoHalfwidthCharsMask = $00000400;
	kUnicodeTextRunHeuristicsMask = $00000800;

{ Values for kUnicodeDirectionality field }
	kUnicodeDefaultDirection	= 0;
	kUnicodeLeftToRight			= 1;
	kUnicodeRightToLeft			= 2;

{ Directionality masks for control flags }
	kUnicodeDefaultDirectionMask = $00;
	kUnicodeLeftToRightMask		= $04;
	kUnicodeRightToLeftMask		= $08;


{ Control flags for TruncateForUnicodeToText: }
{
   Now TruncateForUnicodeToText uses control flags from the same set as used by
   ConvertFromTextToUnicode, ConvertFromUnicodeToText, etc., but only
   kUnicodeStringUnterminatedMask is meaningful for TruncateForUnicodeToText.
   
   Previously two special control flags were defined for TruncateForUnicodeToText:
        kUnicodeTextElementSafeBit = 0
        kUnicodeRestartSafeBit = 1
   However, neither of these was implemented.
   Instead of implementing kUnicodeTextElementSafeBit, we now use
   kUnicodeStringUnterminatedMask since it accomplishes the same thing and avoids
   having special flags just for TruncateForUnicodeToText
   Also, kUnicodeRestartSafeBit is unnecessary, since restart-safeness is handled by
   setting kUnicodeKeepInfoBit with ConvertFromUnicodeToText.
   If TruncateForUnicodeToText is called with one or both of the old special control
   flags set (bits 0 or 1), it will not generate a paramErr, but the old bits have no
   effect on its operation.
}

{ Filter bits for filter field in QueryUnicodeMappings and CountUnicodeMappings: }
	kUnicodeMatchUnicodeBaseBit	= 0;
	kUnicodeMatchUnicodeVariantBit = 1;
	kUnicodeMatchUnicodeFormatBit = 2;
	kUnicodeMatchOtherBaseBit	= 3;
	kUnicodeMatchOtherVariantBit = 4;
	kUnicodeMatchOtherFormatBit	= 5;

	kUnicodeMatchUnicodeBaseMask = $00000001;
	kUnicodeMatchUnicodeVariantMask = $00000002;
	kUnicodeMatchUnicodeFormatMask = $00000004;
	kUnicodeMatchOtherBaseMask	= $00000008;
	kUnicodeMatchOtherVariantMask = $00000010;
	kUnicodeMatchOtherFormatMask = $00000020;

{ Control flags for SetFallbackUnicodeToText }
	kUnicodeFallbackSequencingBits = 0;

	kUnicodeFallbackSequencingMask = $00000003;
	kUnicodeFallbackInterruptSafeMask = $00000004;				{  To indicate that caller fallback routine doesn’t move memory }

{ values for kUnicodeFallbackSequencing field }
	kUnicodeFallbackDefaultOnly	= 0;
	kUnicodeFallbackCustomOnly	= 1;
	kUnicodeFallbackDefaultFirst = 2;
	kUnicodeFallbackCustomFirst	= 3;


{ Caller-supplied entry point to a fallback handler }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	UnicodeToTextFallbackProcPtr = FUNCTION(VAR iSrcUniStr: UniChar; iSrcUniStrLen: ByteCount; VAR oSrcConvLen: ByteCount; oDestStr: TextPtr; iDestStrLen: ByteCount; VAR oDestConvLen: ByteCount; iInfoPtr: LogicalAddress; iUnicodeMappingPtr: ConstUnicodeMappingPtr): OSStatus;
{$ELSEC}
	UnicodeToTextFallbackProcPtr = ProcPtr;
{$ENDC}

	UnicodeToTextFallbackUPP = UniversalProcPtr;

CONST
	uppUnicodeToTextFallbackProcInfo = $003FFFF0;

FUNCTION NewUnicodeToTextFallbackUPP(userRoutine: UnicodeToTextFallbackProcPtr): UnicodeToTextFallbackUPP; { old name was NewUnicodeToTextFallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeUnicodeToTextFallbackUPP(userUPP: UnicodeToTextFallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeUnicodeToTextFallbackUPP(VAR iSrcUniStr: UniChar; iSrcUniStrLen: ByteCount; VAR oSrcConvLen: ByteCount; oDestStr: TextPtr; iDestStrLen: ByteCount; VAR oDestConvLen: ByteCount; iInfoPtr: LogicalAddress; iUnicodeMappingPtr: ConstUnicodeMappingPtr; userRoutine: UnicodeToTextFallbackUPP): OSStatus; { old name was CallUnicodeToTextFallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{ Function prototypes }
{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM }
{
    Routine to Initialize the Unicode Converter and cleanup once done with it. 
    These routines must be called from Static Library clients.
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitializeUnicodeConverter(TECFileName: StringPtr): OSStatus;
PROCEDURE TerminateUnicodeConverter;
{  Note: the old names (InitializeUnicode, TerminateUnicode) for the above are still exported. }
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

FUNCTION CreateTextToUnicodeInfo(iUnicodeMapping: ConstUnicodeMappingPtr; VAR oTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;
FUNCTION CreateTextToUnicodeInfoByEncoding(iEncoding: TextEncoding; VAR oTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;
FUNCTION CreateUnicodeToTextInfo(iUnicodeMapping: ConstUnicodeMappingPtr; VAR oUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;
FUNCTION CreateUnicodeToTextInfoByEncoding(iEncoding: TextEncoding; VAR oUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;
FUNCTION CreateUnicodeToTextRunInfo(iNumberOfMappings: ItemCount; {CONST}VAR iUnicodeMappings: UnicodeMapping; VAR oUnicodeToTextInfo: UnicodeToTextRunInfo): OSStatus;
FUNCTION CreateUnicodeToTextRunInfoByEncoding(iNumberOfEncodings: ItemCount; {CONST}VAR iEncodings: TextEncoding; VAR oUnicodeToTextInfo: UnicodeToTextRunInfo): OSStatus;
FUNCTION CreateUnicodeToTextRunInfoByScriptCode(iNumberOfScriptCodes: ItemCount; {CONST}VAR iScripts: ScriptCode; VAR oUnicodeToTextInfo: UnicodeToTextRunInfo): OSStatus;
{ Change the TextToUnicodeInfo to another mapping. }
FUNCTION ChangeTextToUnicodeInfo(ioTextToUnicodeInfo: TextToUnicodeInfo; iUnicodeMapping: ConstUnicodeMappingPtr): OSStatus;
{ Change the UnicodeToTextInfo to another mapping. }
FUNCTION ChangeUnicodeToTextInfo(ioUnicodeToTextInfo: UnicodeToTextInfo; iUnicodeMapping: ConstUnicodeMappingPtr): OSStatus;

FUNCTION DisposeTextToUnicodeInfo(VAR ioTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;
FUNCTION DisposeUnicodeToTextInfo(VAR ioUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;
FUNCTION DisposeUnicodeToTextRunInfo(VAR ioUnicodeToTextRunInfo: UnicodeToTextRunInfo): OSStatus;
FUNCTION ConvertFromTextToUnicode(iTextToUnicodeInfo: TextToUnicodeInfo; iSourceLen: ByteCount; iSourceStr: ConstLogicalAddress; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oSourceRead: ByteCount; VAR oUnicodeLen: ByteCount; oUnicodeStr: UniCharArrayPtr): OSStatus;
FUNCTION ConvertFromUnicodeToText(iUnicodeToTextInfo: UnicodeToTextInfo; iUnicodeLen: ByteCount; iUnicodeStr: ConstUniCharArrayPtr; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oInputRead: ByteCount; VAR oOutputLen: ByteCount; oOutputStr: LogicalAddress): OSStatus;
FUNCTION ConvertFromUnicodeToTextRun(iUnicodeToTextInfo: UnicodeToTextRunInfo; iUnicodeLen: ByteCount; iUnicodeStr: ConstUniCharArrayPtr; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oInputRead: ByteCount; VAR oOutputLen: ByteCount; oOutputStr: LogicalAddress; iEncodingRunBufLen: ItemCount; VAR oEncodingRunOutLen: ItemCount; VAR oEncodingRuns: TextEncodingRun): OSStatus;
FUNCTION ConvertFromUnicodeToScriptCodeRun(iUnicodeToTextInfo: UnicodeToTextRunInfo; iUnicodeLen: ByteCount; iUnicodeStr: ConstUniCharArrayPtr; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oInputRead: ByteCount; VAR oOutputLen: ByteCount; oOutputStr: LogicalAddress; iScriptRunBufLen: ItemCount; VAR oScriptRunOutLen: ItemCount; VAR oScriptCodeRuns: ScriptCodeRun): OSStatus;
{ Truncate a multibyte string at a safe place. }
FUNCTION TruncateForTextToUnicode(iTextToUnicodeInfo: ConstTextToUnicodeInfo; iSourceLen: ByteCount; iSourceStr: ConstLogicalAddress; iMaxLen: ByteCount; VAR oTruncatedLen: ByteCount): OSStatus;
{ Truncate a Unicode string at a safe place. }
FUNCTION TruncateForUnicodeToText(iUnicodeToTextInfo: ConstUnicodeToTextInfo; iSourceLen: ByteCount; iSourceStr: ConstUniCharArrayPtr; iControlFlags: OptionBits; iMaxLen: ByteCount; VAR oTruncatedLen: ByteCount): OSStatus;
{ Convert a Pascal string to Unicode string. }
FUNCTION ConvertFromPStringToUnicode(iTextToUnicodeInfo: TextToUnicodeInfo; iPascalStr: Str255; iOutputBufLen: ByteCount; VAR oUnicodeLen: ByteCount; oUnicodeStr: UniCharArrayPtr): OSStatus;
{ Convert a Unicode string to Pascal string. }
FUNCTION ConvertFromUnicodeToPString(iUnicodeToTextInfo: UnicodeToTextInfo; iUnicodeLen: ByteCount; iUnicodeStr: ConstUniCharArrayPtr; VAR oPascalStr: Str255): OSStatus;
{ Count the available conversion mappings. }
FUNCTION CountUnicodeMappings(iFilter: OptionBits; iFindMapping: ConstUnicodeMappingPtr; VAR oActualCount: ItemCount): OSStatus;
{ Get a list of the available conversion mappings. }
FUNCTION QueryUnicodeMappings(iFilter: OptionBits; iFindMapping: ConstUnicodeMappingPtr; iMaxCount: ItemCount; VAR oActualCount: ItemCount; VAR oReturnedMappings: UnicodeMapping): OSStatus;
{ Setup the fallback handler for converting Unicode To Text. }
FUNCTION SetFallbackUnicodeToText(iUnicodeToTextInfo: UnicodeToTextInfo; iFallback: UnicodeToTextFallbackUPP; iControlFlags: OptionBits; iInfoPtr: LogicalAddress): OSStatus;
{ Setup the fallback handler for converting Unicode To TextRuns. }
FUNCTION SetFallbackUnicodeToTextRun(iUnicodeToTextRunInfo: UnicodeToTextRunInfo; iFallback: UnicodeToTextFallbackUPP; iControlFlags: OptionBits; iInfoPtr: LogicalAddress): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := UnicodeConverterIncludes}

{$ENDC} {__UNICODECONVERTER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
