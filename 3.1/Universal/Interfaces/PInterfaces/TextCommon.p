{
 	File:		TextCommon.p
 
 	Contains:	Common text types and constants and prototypes for related functions 
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TextCommon;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTCOMMON__}
{$SETC __TEXTCOMMON__ := 1}

{$I+}
{$SETC TextCommonIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ TextEncodingBase type & values }
{ (values 0-32 correspond to the Script Codes defined in Inside Macintosh: Text pages 6-52 and 6-53 }

TYPE
	TextEncodingBase					= UInt32;

CONST
																{  Mac OS encodings }
	kTextEncodingMacRoman		= 0;
	kTextEncodingMacJapanese	= 1;
	kTextEncodingMacChineseTrad	= 2;
	kTextEncodingMacKorean		= 3;
	kTextEncodingMacArabic		= 4;
	kTextEncodingMacHebrew		= 5;
	kTextEncodingMacGreek		= 6;
	kTextEncodingMacCyrillic	= 7;
	kTextEncodingMacDevanagari	= 9;
	kTextEncodingMacGurmukhi	= 10;
	kTextEncodingMacGujarati	= 11;
	kTextEncodingMacOriya		= 12;
	kTextEncodingMacBengali		= 13;
	kTextEncodingMacTamil		= 14;
	kTextEncodingMacTelugu		= 15;
	kTextEncodingMacKannada		= 16;
	kTextEncodingMacMalayalam	= 17;
	kTextEncodingMacSinhalese	= 18;
	kTextEncodingMacBurmese		= 19;
	kTextEncodingMacKhmer		= 20;
	kTextEncodingMacThai		= 21;
	kTextEncodingMacLaotian		= 22;
	kTextEncodingMacGeorgian	= 23;
	kTextEncodingMacArmenian	= 24;
	kTextEncodingMacChineseSimp	= 25;
	kTextEncodingMacTibetan		= 26;
	kTextEncodingMacMongolian	= 27;
	kTextEncodingMacEthiopic	= 28;
	kTextEncodingMacCentralEurRoman = 29;
	kTextEncodingMacVietnamese	= 30;
	kTextEncodingMacExtArabic	= 31;							{  The following use script code 0, smRoman }
	kTextEncodingMacSymbol		= 33;
	kTextEncodingMacDingbats	= 34;
	kTextEncodingMacTurkish		= 35;
	kTextEncodingMacCroatian	= 36;
	kTextEncodingMacIcelandic	= 37;
	kTextEncodingMacRomanian	= 38;							{  The following use script code 4, smArabic }
	kTextEncodingMacFarsi		= $8C;							{  Like MacArabic but uses Farsi digits }
																{  The following use script code 7, smCyrillic }
	kTextEncodingMacUkrainian	= $98;							{  The following use script code 32, smUnimplemented }
	kTextEncodingMacVT100		= $FC;							{  VT100/102 font from Comm Toolbox: Latin-1 repertoire + box drawing etc }
																{  Special Mac OS encodings }
	kTextEncodingMacHFS			= $FF;							{  Meta-value, should never appear in a table. }
																{  Unicode & ISO UCS encodings begin at 0x100 }
	kTextEncodingUnicodeDefault	= $0100;						{  Meta-value, should never appear in a table. }
	kTextEncodingUnicodeV1_1	= $0101;
	kTextEncodingISO10646_1993	= $0101;						{  Code points identical to Unicode 1.1 }
	kTextEncodingUnicodeV2_0	= $0103;						{  New location for Korean Hangul }
																{  ISO 8-bit and 7-bit encodings begin at 0x200 }
	kTextEncodingISOLatin1		= $0201;						{  ISO 8859-1 }
	kTextEncodingISOLatin2		= $0202;						{  ISO 8859-2 }
	kTextEncodingISOLatinCyrillic = $0205;						{  ISO 8859-5 }
	kTextEncodingISOLatinArabic	= $0206;						{  ISO 8859-6, = ASMO 708, =DOS CP 708 }
	kTextEncodingISOLatinGreek	= $0207;						{  ISO 8859-7 }
	kTextEncodingISOLatinHebrew	= $0208;						{  ISO 8859-8 }
	kTextEncodingISOLatin5		= $0209;						{  ISO 8859-9 }
																{  MS-DOS & Windows encodings begin at 0x400 }
	kTextEncodingDOSLatinUS		= $0400;						{  code page 437 }
	kTextEncodingDOSGreek		= $0405;						{  code page 737 (formerly code page 437G) }
	kTextEncodingDOSBalticRim	= $0406;						{  code page 775 }
	kTextEncodingDOSLatin1		= $0410;						{  code page 850, "Multilingual" }
	kTextEncodingDOSGreek1		= $0411;						{  code page 851 }
	kTextEncodingDOSLatin2		= $0412;						{  code page 852, Slavic }
	kTextEncodingDOSCyrillic	= $0413;						{  code page 855, IBM Cyrillic }
	kTextEncodingDOSTurkish		= $0414;						{  code page 857, IBM Turkish }
	kTextEncodingDOSPortuguese	= $0415;						{  code page 860 }
	kTextEncodingDOSIcelandic	= $0416;						{  code page 861 }
	kTextEncodingDOSHebrew		= $0417;						{  code page 862 }
	kTextEncodingDOSCanadianFrench = $0418;						{  code page 863 }
	kTextEncodingDOSArabic		= $0419;						{  code page 864 }
	kTextEncodingDOSNordic		= $041A;						{  code page 865 }
	kTextEncodingDOSRussian		= $041B;						{  code page 866 }
	kTextEncodingDOSGreek2		= $041C;						{  code page 869, IBM Modern Greek }
	kTextEncodingDOSThai		= $041D;						{  code page 874, also for Windows }
	kTextEncodingDOSJapanese	= $0420;						{  code page 932, also for Windows }
	kTextEncodingDOSChineseSimplif = $0421;						{  code page 936, also for Windows }
	kTextEncodingDOSKorean		= $0422;						{  code page 949, also for Windows; Unified Hangul Code }
	kTextEncodingDOSChineseTrad	= $0423;						{  code page 950, also for Windows }
	kTextEncodingWindowsLatin1	= $0500;						{  code page 1252 }
	kTextEncodingWindowsANSI	= $0500;						{  code page 1252 (alternate name) }
	kTextEncodingWindowsLatin2	= $0501;						{  code page 1250, Central Europe }
	kTextEncodingWindowsCyrillic = $0502;						{  code page 1251, Slavic Cyrillic }
	kTextEncodingWindowsGreek	= $0503;						{  code page 1253 }
	kTextEncodingWindowsLatin5	= $0504;						{  code page 1254, Turkish }
	kTextEncodingWindowsHebrew	= $0505;						{  code page 1255 }
	kTextEncodingWindowsArabic	= $0506;						{  code page 1256 }
	kTextEncodingWindowsBalticRim = $0507;						{  code page 1257 }
	kTextEncodingWindowsKoreanJohab = $0510;					{  code page 1361, for Windows NT }
																{  Various national standards begin at 0x600 }
	kTextEncodingUS_ASCII		= $0600;
	kTextEncodingJIS_X0201_76	= $0620;
	kTextEncodingJIS_X0208_83	= $0621;
	kTextEncodingJIS_X0208_90	= $0622;
	kTextEncodingJIS_X0212_90	= $0623;
	kTextEncodingJIS_C6226_78	= $0624;
	kTextEncodingGB_2312_80		= $0630;
	kTextEncodingGBK_95			= $0631;						{  annex to GB 13000-93; for Windows 95 }
	kTextEncodingKSC_5601_87	= $0640;						{  same as KSC 5601-92 without Johab annex }
	kTextEncodingKSC_5601_92_Johab = $0641;						{  KSC 5601-92 Johab annex }
	kTextEncodingCNS_11643_92_P1 = $0651;						{  CNS 11643-1992 plane 1 }
	kTextEncodingCNS_11643_92_P2 = $0652;						{  CNS 11643-1992 plane 2 }
	kTextEncodingCNS_11643_92_P3 = $0653;						{  CNS 11643-1992 plane 3 (was plane 14 in 1986 version) }
																{  ISO 2022 collections begin at 0x800 }
	kTextEncodingISO_2022_JP	= $0820;
	kTextEncodingISO_2022_JP_2	= $0821;
	kTextEncodingISO_2022_CN	= $0830;
	kTextEncodingISO_2022_CN_EXT = $0831;
	kTextEncodingISO_2022_KR	= $0840;						{  EUC collections begin at 0x900 }
	kTextEncodingEUC_JP			= $0920;						{  ISO 646, 1-byte katakana, JIS 208, JIS 212 }
	kTextEncodingEUC_CN			= $0930;						{  ISO 646, GB 2312-80 }
	kTextEncodingEUC_TW			= $0931;						{  ISO 646, CNS 11643-1992 Planes 1-16 }
	kTextEncodingEUC_KR			= $0940;						{  ISO 646, KS C 5601-1987 }
																{  Misc standards begin at 0xA00 }
	kTextEncodingShiftJIS		= $0A01;						{  plain Shift-JIS }
	kTextEncodingKOI8_R			= $0A02;						{  Russian internet standard }
	kTextEncodingBig5			= $0A03;						{  Big-5 (has variants) }
	kTextEncodingMacRomanLatin1	= $0A04;						{  Mac OS Roman permuted to align with ISO Latin-1 }
	kTextEncodingHZ_GB_2312		= $0A05;						{  HZ (RFC 1842, for Chinese mail & news) }
																{  Other platform encodings }
	kTextEncodingNextStepLatin	= $0B01;						{  NextStep encoding }
																{  EBCDIC & IBM host encodings begin at 0xC00 }
	kTextEncodingEBCDIC_US		= $0C01;						{  basic EBCDIC-US }
	kTextEncodingEBCDIC_CP037	= $0C02;						{  code page 037, extended EBCDIC (Latin-1 set) for US,Canada... }
																{  Special value }
	kTextEncodingMultiRun		= $0FFF;						{  Multi-encoding text with external run info }
																{  The following are older names for backward compatibility }
	kTextEncodingMacTradChinese	= 2;
	kTextEncodingMacRSymbol		= 8;
	kTextEncodingMacSimpChinese	= 25;
	kTextEncodingMacGeez		= 28;
	kTextEncodingMacEastEurRoman = 29;
	kTextEncodingMacUninterp	= 32;

{ TextEncodingVariant type & values }

TYPE
	TextEncodingVariant					= UInt32;

CONST
																{  Default TextEncodingVariant, for any TextEncodingBase }
	kTextEncodingDefaultVariant	= 0;							{  Variants of kTextEncodingMacIcelandic													 }
	kMacIcelandicStandardVariant = 0;							{  0xBB & 0xBC are fem./masc. ordinal indicators }
	kMacIcelandicTrueTypeVariant = 1;							{  0xBB & 0xBC are fi/fl ligatures }
																{  Variants of kTextEncodingMacJapanese }
	kMacJapaneseStandardVariant	= 0;
	kMacJapaneseStdNoVerticalsVariant = 1;
	kMacJapaneseBasicVariant	= 2;
	kMacJapanesePostScriptScrnVariant = 3;
	kMacJapanesePostScriptPrintVariant = 4;
	kMacJapaneseVertAtKuPlusTenVariant = 5;						{  Variant options for most Japanese encodings (MacJapanese, ShiftJIS, EUC-JP, ISO 2022-JP)	 }
																{  These can be OR-ed into the variant value in any combination }
	kJapaneseNoOneByteKanaOption = $20;
	kJapaneseUseAsciiBackslashOption = $40;						{  Variants of kTextEncodingMacArabic }
	kMacArabicStandardVariant	= 0;							{  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Cairo) }
	kMacArabicTrueTypeVariant	= 1;							{  0xC0 is asterisk, 0x2A & 0xAA are multiply signs (e.g. Baghdad) }
	kMacArabicThuluthVariant	= 2;							{  0xC0 is Arabic five-point star, 0x2A & 0xAA are multiply signs }
	kMacArabicAlBayanVariant	= 3;							{  8-spoke asterisk, multiply sign, Koranic ligatures & parens }
																{  Variants of kTextEncodingMacFarsi }
	kMacFarsiStandardVariant	= 0;							{  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Tehran) }
	kMacFarsiTrueTypeVariant	= 1;							{  asterisk, multiply signs, Koranic ligatures, geometric shapes }
																{  Variants of kTextEncodingMacHebrew }
	kMacHebrewStandardVariant	= 0;
	kMacHebrewFigureSpaceVariant = 1;							{  Variants of Unicode & ISO 10646 encodings }
	kUnicodeNoSubset			= 0;
	kUnicodeCanonicalDecompVariant = 2;							{  canonical decomposition; excludes composed characters }
																{  Variants of Big-5 encoding }
	kBig5_BasicVariant			= 0;
	kBig5_StandardVariant		= 1;							{  0xC6A1-0xC7FC: kana, Cyrillic, enclosed numerics }
	kBig5_ETenVariant			= 2;							{  adds kana, Cyrillic, radicals, etc with hi bytes C6-C8,F9 }
																{  Unicode variants not yet supported (and not fully defined) }
	kUnicodeNoCompatibilityVariant = 1;
	kUnicodeNoComposedVariant	= 3;
	kUnicodeNoCorporateVariant	= 4;							{  The following are older names for backward compatibility }
	kJapaneseStandardVariant	= 0;
	kJapaneseStdNoVerticalsVariant = 1;
	kJapaneseBasicVariant		= 2;
	kJapanesePostScriptScrnVariant = 3;
	kJapanesePostScriptPrintVariant = 4;
	kJapaneseVertAtKuPlusTenVariant = 5;						{  kJapaneseStdNoOneByteKanaVariant = 6,	// replaced by kJapaneseNoOneByteKanaOption }
																{  kJapaneseBasicNoOneByteKanaVariant = 7,	// replaced by kJapaneseNoOneByteKanaOption	 }
	kHebrewStandardVariant		= 0;
	kHebrewFigureSpaceVariant	= 1;
	kUnicodeMaxDecomposedVariant = 2;							{  replaced by kUnicodeCanonicalDecompVariant }

{ TextEncodingFormat type & values }

TYPE
	TextEncodingFormat					= UInt32;

CONST
																{  Default TextEncodingFormat for any TextEncodingBase }
	kTextEncodingDefaultFormat	= 0;							{  Formats for Unicode & ISO 10646 }
	kUnicode16BitFormat			= 0;
	kUnicodeUTF7Format			= 1;
	kUnicodeUTF8Format			= 2;
	kUnicode32BitFormat			= 3;

{ TextEncoding type }

TYPE
	TextEncoding						= UInt32;
{  name part selector for GetTextEncodingName }
	TextEncodingNameSelector			= UInt32;

CONST
	kTextEncodingFullName		= 0;
	kTextEncodingBaseName		= 1;
	kTextEncodingVariantName	= 2;
	kTextEncodingFormatName		= 3;

{ Types used in conversion }

TYPE
	TextEncodingRunPtr = ^TextEncodingRun;
	TextEncodingRun = RECORD
		offset:					ByteOffset;
		textEncoding:			TextEncoding;
	END;

	ConstTextEncodingRunPtr				= ^TextEncodingRun;
	ScriptCodeRunPtr = ^ScriptCodeRun;
	ScriptCodeRun = RECORD
		offset:					ByteOffset;
		script:					ScriptCode;
	END;

	ConstScriptCodeRunPtr				= ^ScriptCodeRun;
	TextPtr								= ^UInt8;
	ConstTextPtr						= ^UInt8;
{ Basic types for Unicode characters and strings: }
	UniCharArrayPtr						= ^UniChar;
	ConstUniCharArrayPtr				= ^UniChar;
{  enums for TextEncoding Conversion routines }

CONST
	kTextScriptDontCare			= -128;
	kTextLanguageDontCare		= -128;
	kTextRegionDontCare			= -128;

{  struct for TECGetInfo }


TYPE
	TECInfoPtr = ^TECInfo;
	TECInfo = RECORD
		format:					UInt16;									{  format code for this struct }
		tecVersion:				UInt16;									{  TEC version in BCD, e.g. 0x0121 for 1.2.1 }
		tecTextConverterFeatures: UInt32;								{  bitmask indicating TEC features/fixes }
		tecUnicodeConverterFeatures: UInt32;							{  bitmask indicating UnicodeConverter features/fixes }
		tecTextCommonFeatures:	UInt32;									{  bitmask indicating TextCommon features/fixes }
		tecTextEncodingsFolderName: Str31;								{  localized name of Text Encodings folder (pascal string) }
		tecExtensionFileName:	Str31;									{  localized name of TEC extension (pascal string) }
	END;

	TECInfoHandle						= ^TECInfoPtr;
{  Value for TECInfo format code }

CONST
	kTECInfoCurrentFormat		= 1;							{  any future formats will just add fields at the end }

{
   Defined feature/fix bits for tecUnicodeConverterFeatures field
   Bit:								Meaning if set:
   ----								---------------
   kTECKeepInfoFixBit				Unicode Converter no longer ignores other control flags if
  									kUnicodeKeepInfoBit is set. Bug fix in TEC Manager 1.2.1.
   kTECFallbackTextLengthFixBit		Unicode Converter honors the *srcConvLen and *destConvLen
  									returned by caller-supplied fallback handler for any status it
  									returns except for kTECUnmappableElementErr (previously it only
  									honored these values if noErr was returned). Bug fix in TEC
  									Manager 1.2.1.
   kTECTextRunBitClearFixBit		ConvertFromUnicodeToTextRun & ConvertFromUnicodeToScriptCodeRun
  									function correctly if the kUnicodeTextRunBit is set (previously
  									their determination of best target encoding was incorrect). Bug
  									fix in TEC Manager 1.3.
   kTECTextToUnicodeScanFixBit		ConvertFromTextToUnicode uses an improved scanner and maintains
  									some resulting state information, which it uses for mapping.
  									This has several effects:
  									- Improved mapping of 0x30-0x39 digits in Mac OS Arabic, fewer
  									  direction overrides when mapping Mac OS Arabic & Hebrew, and
  									  improved mapping of certain characters in Indic encodings.
  									- Malformed input produces kTextMalformedInputErr.
  									- ConvertFromTextToUnicode accepts and uses the control flags
  									  kUnicodeKeepInfoMask and kUnicodeStringUnterminatedMask.
  									Bug fix and enhancement in TEC Manager 1.3.
}

	kTECKeepInfoFixBit			= 0;
	kTECFallbackTextLengthFixBit = 1;
	kTECTextRunBitClearFixBit	= 2;
	kTECTextToUnicodeScanFixBit	= 3;

	kTECKeepInfoFixMask			= $00000001;
	kTECFallbackTextLengthFixMask = $00000002;
	kTECTextRunBitClearFixMask	= $00000004;
	kTECTextToUnicodeScanFixMask = $00000008;

{  Prototypes for TextEncoding functions }

FUNCTION CreateTextEncoding(encodingBase: TextEncodingBase; encodingVariant: TextEncodingVariant; encodingFormat: TextEncodingFormat): TextEncoding;
FUNCTION GetTextEncodingBase(encoding: TextEncoding): TextEncodingBase;
FUNCTION GetTextEncodingVariant(encoding: TextEncoding): TextEncodingVariant;
FUNCTION GetTextEncodingFormat(encoding: TextEncoding): TextEncodingFormat;
FUNCTION ResolveDefaultTextEncoding(encoding: TextEncoding): TextEncoding;
FUNCTION GetTextEncodingName(iEncoding: TextEncoding; iNamePartSelector: TextEncodingNameSelector; iPreferredRegion: RegionCode; iPreferredEncoding: TextEncoding; iOutputBufLen: ByteCount; VAR oNameLength: ByteCount; VAR oActualRegion: RegionCode; VAR oActualEncoding: TextEncoding; oEncodingName: TextPtr): OSStatus; C;
FUNCTION TECGetInfo(VAR tecInfo: TECInfoHandle): OSStatus;

FUNCTION UpgradeScriptInfoToTextEncoding(iTextScriptID: ScriptCode; iTextLanguageID: LangCode; iRegionID: RegionCode; iTextFontname: Str255; VAR oEncoding: TextEncoding): OSStatus;
FUNCTION RevertTextEncodingToScriptInfo(iEncoding: TextEncoding; VAR oTextScriptID: ScriptCode; VAR oTextLanguageID: LangCode; VAR oTextFontname: Str255): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextCommonIncludes}

{$ENDC} {__TEXTCOMMON__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
