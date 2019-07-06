/*
 	File:		TextCommon.r
 
 	Contains:	TextEncoding-related types and constants, and prototypes for related functions 
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __TEXTCOMMON_R__
#define __TEXTCOMMON_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

															/*  Mac OS encodings */
#define kTextEncodingMacRoman 			0
#define kTextEncodingMacJapanese 		1
#define kTextEncodingMacChineseTrad 	2
#define kTextEncodingMacKorean 			3
#define kTextEncodingMacArabic 			4
#define kTextEncodingMacHebrew 			5
#define kTextEncodingMacGreek 			6
#define kTextEncodingMacCyrillic 		7
#define kTextEncodingMacDevanagari 		9
#define kTextEncodingMacGurmukhi 		10
#define kTextEncodingMacGujarati 		11
#define kTextEncodingMacOriya 			12
#define kTextEncodingMacBengali 		13
#define kTextEncodingMacTamil 			14
#define kTextEncodingMacTelugu 			15
#define kTextEncodingMacKannada 		16
#define kTextEncodingMacMalayalam 		17
#define kTextEncodingMacSinhalese 		18
#define kTextEncodingMacBurmese 		19
#define kTextEncodingMacKhmer 			20
#define kTextEncodingMacThai 			21
#define kTextEncodingMacLaotian 		22
#define kTextEncodingMacGeorgian 		23
#define kTextEncodingMacArmenian 		24
#define kTextEncodingMacChineseSimp 	25
#define kTextEncodingMacTibetan 		26
#define kTextEncodingMacMongolian 		27
#define kTextEncodingMacEthiopic 		28
#define kTextEncodingMacCentralEurRoman  29
#define kTextEncodingMacVietnamese 		30
#define kTextEncodingMacExtArabic 		31					/*  The following use script code 0, smRoman */
#define kTextEncodingMacSymbol 			33
#define kTextEncodingMacDingbats 		34
#define kTextEncodingMacTurkish 		35
#define kTextEncodingMacCroatian 		36
#define kTextEncodingMacIcelandic 		37
#define kTextEncodingMacRomanian 		38
#define kTextEncodingMacCeltic 			39
#define kTextEncodingMacGaelic 			40					/*  Beginning in Mac OS 8.5, the following meta-value is used to indicate Unicode in some parts */
															/*  of the Mac OS which previously only expected a Mac OS script code. In some of these places, */
															/*  only 7 bits are available to indicate encoding (script code), so kTextEncodingUnicodeDefault */
															/*  cannot be used. For example, kTextEncodingMacUnicode can be used to indicate Unicode in the */
															/*  7-bit script code field of a Unicode input method's ComponentDescription.componentFlags field; */
															/*  it can also be used to indicate Unicode in the 16-bit script code field of an AppleEvent's */
															/*  typeIntlWritingCode text tag. */
#define kTextEncodingMacUnicode 		0x7E				/*  Meta-value, Unicode as a Mac encoding */
															/*  The following use script code 4, smArabic */
#define kTextEncodingMacFarsi 			0x8C				/*  Like MacArabic but uses Farsi digits */
															/*  The following use script code 7, smCyrillic */
#define kTextEncodingMacUkrainian 		0x98				/*  The following use script code 28, smEthiopic */
#define kTextEncodingMacInuit 			0xEC				/*  The following use script code 32, smUnimplemented */
#define kTextEncodingMacVT100 			0xFC				/*  VT100/102 font from Comm Toolbox: Latin-1 repertoire + box drawing etc */
															/*  Special Mac OS encodings */
#define kTextEncodingMacHFS 			0xFF				/*  Meta-value, should never appear in a table. */
															/*  Unicode & ISO UCS encodings begin at 0x100 */
#define kTextEncodingUnicodeDefault 	0x0100				/*  Meta-value, should never appear in a table. */
#define kTextEncodingUnicodeV1_1 		0x0101
#define kTextEncodingISO10646_1993 		0x0101				/*  Code points identical to Unicode 1.1 */
#define kTextEncodingUnicodeV2_0 		0x0103				/*  New location for Korean Hangul */
#define kTextEncodingUnicodeV2_1 		0x0103				/*  We treat both Unicode 2.0 and Unicode 2.1 as 2.1 */
															/*  ISO 8-bit and 7-bit encodings begin at 0x200 */
#define kTextEncodingISOLatin1 			0x0201				/*  ISO 8859-1 */
#define kTextEncodingISOLatin2 			0x0202				/*  ISO 8859-2 */
#define kTextEncodingISOLatin3 			0x0203				/*  ISO 8859-3 */
#define kTextEncodingISOLatin4 			0x0204				/*  ISO 8859-4 */
#define kTextEncodingISOLatinCyrillic 	0x0205				/*  ISO 8859-5 */
#define kTextEncodingISOLatinArabic 	0x0206				/*  ISO 8859-6, = ASMO 708, =DOS CP 708 */
#define kTextEncodingISOLatinGreek 		0x0207				/*  ISO 8859-7 */
#define kTextEncodingISOLatinHebrew 	0x0208				/*  ISO 8859-8 */
#define kTextEncodingISOLatin5 			0x0209				/*  ISO 8859-9 */
															/*  MS-DOS & Windows encodings begin at 0x400 */
#define kTextEncodingDOSLatinUS 		0x0400				/*  code page 437 */
#define kTextEncodingDOSGreek 			0x0405				/*  code page 737 (formerly code page 437G) */
#define kTextEncodingDOSBalticRim 		0x0406				/*  code page 775 */
#define kTextEncodingDOSLatin1 			0x0410				/*  code page 850, "Multilingual" */
#define kTextEncodingDOSGreek1 			0x0411				/*  code page 851 */
#define kTextEncodingDOSLatin2 			0x0412				/*  code page 852, Slavic */
#define kTextEncodingDOSCyrillic 		0x0413				/*  code page 855, IBM Cyrillic */
#define kTextEncodingDOSTurkish 		0x0414				/*  code page 857, IBM Turkish */
#define kTextEncodingDOSPortuguese 		0x0415				/*  code page 860 */
#define kTextEncodingDOSIcelandic 		0x0416				/*  code page 861 */
#define kTextEncodingDOSHebrew 			0x0417				/*  code page 862 */
#define kTextEncodingDOSCanadianFrench 	0x0418				/*  code page 863 */
#define kTextEncodingDOSArabic 			0x0419				/*  code page 864 */
#define kTextEncodingDOSNordic 			0x041A				/*  code page 865 */
#define kTextEncodingDOSRussian 		0x041B				/*  code page 866 */
#define kTextEncodingDOSGreek2 			0x041C				/*  code page 869, IBM Modern Greek */
#define kTextEncodingDOSThai 			0x041D				/*  code page 874, also for Windows */
#define kTextEncodingDOSJapanese 		0x0420				/*  code page 932, also for Windows; Shift-JIS with additions */
#define kTextEncodingDOSChineseSimplif 	0x0421				/*  code page 936, also for Windows; was EUC-CN, now GBK (EUC-CN extended) */
#define kTextEncodingDOSKorean 			0x0422				/*  code page 949, also for Windows; Unified Hangul Code (EUC-KR extended) */
#define kTextEncodingDOSChineseTrad 	0x0423				/*  code page 950, also for Windows; Big-5 */
#define kTextEncodingWindowsLatin1 		0x0500				/*  code page 1252 */
#define kTextEncodingWindowsANSI 		0x0500				/*  code page 1252 (alternate name) */
#define kTextEncodingWindowsLatin2 		0x0501				/*  code page 1250, Central Europe */
#define kTextEncodingWindowsCyrillic 	0x0502				/*  code page 1251, Slavic Cyrillic */
#define kTextEncodingWindowsGreek 		0x0503				/*  code page 1253 */
#define kTextEncodingWindowsLatin5 		0x0504				/*  code page 1254, Turkish */
#define kTextEncodingWindowsHebrew 		0x0505				/*  code page 1255 */
#define kTextEncodingWindowsArabic 		0x0506				/*  code page 1256 */
#define kTextEncodingWindowsBalticRim 	0x0507				/*  code page 1257 */
#define kTextEncodingWindowsVietnamese 	0x0508				/*  code page 1258 */
#define kTextEncodingWindowsKoreanJohab  0x0510				/*  code page 1361, for Windows NT */
															/*  Various national standards begin at 0x600 */
#define kTextEncodingUS_ASCII 			0x0600
#define kTextEncodingJIS_X0201_76 		0x0620				/*  JIS Roman and 1-byte katakana (halfwidth) */
#define kTextEncodingJIS_X0208_83 		0x0621
#define kTextEncodingJIS_X0208_90 		0x0622
#define kTextEncodingJIS_X0212_90 		0x0623
#define kTextEncodingJIS_C6226_78 		0x0624
#define kTextEncodingGB_2312_80 		0x0630
#define kTextEncodingGBK_95 			0x0631				/*  annex to GB 13000-93; for Windows 95; EUC-CN extended */
#define kTextEncodingKSC_5601_87 		0x0640				/*  same as KSC 5601-92 without Johab annex */
#define kTextEncodingKSC_5601_92_Johab 	0x0641				/*  KSC 5601-92 Johab annex */
#define kTextEncodingCNS_11643_92_P1 	0x0651				/*  CNS 11643-1992 plane 1 */
#define kTextEncodingCNS_11643_92_P2 	0x0652				/*  CNS 11643-1992 plane 2 */
#define kTextEncodingCNS_11643_92_P3 	0x0653				/*  CNS 11643-1992 plane 3 (was plane 14 in 1986 version) */
															/*  ISO 2022 collections begin at 0x800 */
#define kTextEncodingISO_2022_JP 		0x0820
#define kTextEncodingISO_2022_JP_2 		0x0821
#define kTextEncodingISO_2022_CN 		0x0830
#define kTextEncodingISO_2022_CN_EXT 	0x0831
#define kTextEncodingISO_2022_KR 		0x0840				/*  EUC collections begin at 0x900 */
#define kTextEncodingEUC_JP 			0x0920				/*  ISO 646, 1-byte katakana, JIS 208, JIS 212 */
#define kTextEncodingEUC_CN 			0x0930				/*  ISO 646, GB 2312-80 */
#define kTextEncodingEUC_TW 			0x0931				/*  ISO 646, CNS 11643-1992 Planes 1-16 */
#define kTextEncodingEUC_KR 			0x0940				/*  ISO 646, KS C 5601-1987 */
															/*  Misc standards begin at 0xA00 */
#define kTextEncodingShiftJIS 			0x0A01				/*  plain Shift-JIS */
#define kTextEncodingKOI8_R 			0x0A02				/*  Russian internet standard */
#define kTextEncodingBig5 				0x0A03				/*  Big-5 (has variants) */
#define kTextEncodingMacRomanLatin1 	0x0A04				/*  Mac OS Roman permuted to align with ISO Latin-1 */
#define kTextEncodingHZ_GB_2312 		0x0A05				/*  HZ (RFC 1842, for Chinese mail & news) */
															/*  Other platform encodings */
#define kTextEncodingNextStepLatin 		0x0B01				/*  NextStep encoding */
															/*  EBCDIC & IBM host encodings begin at 0xC00 */
#define kTextEncodingEBCDIC_US 			0x0C01				/*  basic EBCDIC-US */
#define kTextEncodingEBCDIC_CP037 		0x0C02				/*  code page 037, extended EBCDIC (Latin-1 set) for US,Canada... */
															/*  Special value */
#define kTextEncodingMultiRun 			0x0FFF				/*  Multi-encoding text with external run info */
															/*  The following are older names for backward compatibility */
#define kTextEncodingMacTradChinese 	2
#define kTextEncodingMacRSymbol 		8
#define kTextEncodingMacSimpChinese 	25
#define kTextEncodingMacGeez 			28
#define kTextEncodingMacEastEurRoman 	29
#define kTextEncodingMacUninterp 		32

															/*  Default TextEncodingVariant, for any TextEncodingBase */
#define kTextEncodingDefaultVariant 	0					/*  Variants of kTextEncodingMacRoman														 */
#define kMacRomanStandardVariant 		0					/*  standard for Mac OS 8.5, 0xDB is EURO SIGN */
#define kMacRomanCurrencySignVariant 	1					/*  earlier Mac OS versions, 0xDB is CURRENCY SIGN */
															/*  Variants of kTextEncodingMacIcelandic													 */
#define kMacIcelandicStandardVariant 	0					/*  0xBB & 0xBC are fem./masc. ordinal indicators */
#define kMacIcelandicTrueTypeVariant 	1					/*  0xBB & 0xBC are fi/fl ligatures */
															/*  Variants of kTextEncodingMacJapanese */
#define kMacJapaneseStandardVariant 	0
#define kMacJapaneseStdNoVerticalsVariant  1
#define kMacJapaneseBasicVariant 		2
#define kMacJapanesePostScriptScrnVariant  3
#define kMacJapanesePostScriptPrintVariant  4
#define kMacJapaneseVertAtKuPlusTenVariant  5				/*  Variants of kTextEncodingMacArabic */
#define kMacArabicStandardVariant 		0					/*  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Cairo) */
#define kMacArabicTrueTypeVariant 		1					/*  0xC0 is asterisk, 0x2A & 0xAA are multiply signs (e.g. Baghdad) */
#define kMacArabicThuluthVariant 		2					/*  0xC0 is Arabic five-point star, 0x2A & 0xAA are multiply signs */
#define kMacArabicAlBayanVariant 		3					/*  8-spoke asterisk, multiply sign, Koranic ligatures & parens */
															/*  Variants of kTextEncodingMacFarsi */
#define kMacFarsiStandardVariant 		0					/*  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Tehran) */
#define kMacFarsiTrueTypeVariant 		1					/*  asterisk, multiply signs, Koranic ligatures, geometric shapes */
															/*  Variants of kTextEncodingMacHebrew */
#define kMacHebrewStandardVariant 		0
#define kMacHebrewFigureSpaceVariant 	1					/*  Variants of Unicode & ISO 10646 encodings */
#define kUnicodeNoSubset 				0
#define kUnicodeCanonicalDecompVariant 	2					/*  canonical decomposition; excludes composed characters */
															/*  Variants of Big-5 encoding */
#define kBig5_BasicVariant 				0
#define kBig5_StandardVariant 			1					/*  0xC6A1-0xC7FC: kana, Cyrillic, enclosed numerics */
#define kBig5_ETenVariant 				2					/*  adds kana, Cyrillic, radicals, etc with hi bytes C6-C8,F9 */
															/*  Unicode variants not yet supported (and not fully defined) */
#define kUnicodeNoCompatibilityVariant 	1
#define kUnicodeNoComposedVariant 		3
#define kUnicodeNoCorporateVariant 		4					/*  The following are older names for backward compatibility */
#define kJapaneseStandardVariant 		0
#define kJapaneseStdNoVerticalsVariant 	1
#define kJapaneseBasicVariant 			2
#define kJapanesePostScriptScrnVariant 	3
#define kJapanesePostScriptPrintVariant  4
#define kJapaneseVertAtKuPlusTenVariant  5					/*  kJapaneseStdNoOneByteKanaVariant = 6,	// replaced by kJapaneseNoOneByteKanaOption */
															/*  kJapaneseBasicNoOneByteKanaVariant = 7,	// replaced by kJapaneseNoOneByteKanaOption	 */
#define kHebrewStandardVariant 			0
#define kHebrewFigureSpaceVariant 		1
#define kUnicodeMaxDecomposedVariant 	2					/*  replaced by kUnicodeCanonicalDecompVariant */
															/*  The following Japanese variant options were never supported and are now deprecated. */
															/*  In TEC 1.4 and later their functionality is replaced by the Unicode Converter options listed. */
#define kJapaneseNoOneByteKanaOption 	0x20				/*  replaced by UnicodeConverter option kUnicodeNoHalfwidthCharsBit */
#define kJapaneseUseAsciiBackslashOption  0x40				/*  replaced by UnicodeConverter option kUnicodeForceASCIIRangeBit */

															/*  Default TextEncodingFormat for any TextEncodingBase */
#define kTextEncodingDefaultFormat 		0					/*  Formats for Unicode & ISO 10646 */
#define kUnicode16BitFormat 			0
#define kUnicodeUTF7Format 				1
#define kUnicodeUTF8Format 				2
#define kUnicode32BitFormat 			3


#endif /* __TEXTCOMMON_R__ */

