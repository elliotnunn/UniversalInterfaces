/*
     File:       TextCommon.r
 
     Contains:   TextEncoding-related types and constants, and prototypes for related functions
 
     Version:    Technology: Mac OS 9 / Carbon
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
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
#define kTextEncodingMacGaelic 			40
#define kTextEncodingMacKeyboardGlyphs 	41

#define kTextEncodingMacTradChinese 	2
#define kTextEncodingMacRSymbol 		8
#define kTextEncodingMacSimpChinese 	25
#define kTextEncodingMacGeez 			28
#define kTextEncodingMacEastEurRoman 	29
#define kTextEncodingMacUninterp 		32

#define kTextEncodingMacUnicode 		0x7E				/*  Meta-value, Unicode as a Mac encoding */
															/*  The following use script code 4, smArabic */
#define kTextEncodingMacFarsi 			0x8C				/*  Like MacArabic but uses Farsi digits */
															/*  The following use script code 7, smCyrillic */
#define kTextEncodingMacUkrainian 		0x98				/*  Meta-value in TEC 1.5 & later; maps to kTextEncodingMacCyrillic variant     */
															/*  The following use script code 28, smEthiopic */
#define kTextEncodingMacInuit 			0xEC				/*  The following use script code 32, smUnimplemented */
#define kTextEncodingMacVT100 			0xFC				/*  VT100/102 font from Comm Toolbox: Latin-1 repertoire + box drawing etc */

#define kTextEncodingMacHFS 			0xFF				/*  Meta-value, should never appear in a table. */
#define kTextEncodingUnicodeDefault 	0x0100				/*  Meta-value, should never appear in a table. */
#define kTextEncodingUnicodeV1_1 		0x0101
#define kTextEncodingISO10646_1993 		0x0101				/*  Code points identical to Unicode 1.1 */
#define kTextEncodingUnicodeV2_0 		0x0103				/*  New location for Korean Hangul */
#define kTextEncodingUnicodeV2_1 		0x0103				/*  We treat both Unicode 2.0 and Unicode 2.1 as 2.1 */
#define kTextEncodingUnicodeV3_0 		0x0104
#define kTextEncodingUnicodeV3_1 		0x0105				/*  Adds characters requiring surrogate pairs in UTF-16 */
#define kTextEncodingUnicodeV3_2 		0x0106

#define kTextEncodingISOLatin1 			0x0201				/*  ISO 8859-1 */
#define kTextEncodingISOLatin2 			0x0202				/*  ISO 8859-2 */
#define kTextEncodingISOLatin3 			0x0203				/*  ISO 8859-3 */
#define kTextEncodingISOLatin4 			0x0204				/*  ISO 8859-4 */
#define kTextEncodingISOLatinCyrillic 	0x0205				/*  ISO 8859-5 */
#define kTextEncodingISOLatinArabic 	0x0206				/*  ISO 8859-6, = ASMO 708, =DOS CP 708 */
#define kTextEncodingISOLatinGreek 		0x0207				/*  ISO 8859-7 */
#define kTextEncodingISOLatinHebrew 	0x0208				/*  ISO 8859-8 */
#define kTextEncodingISOLatin5 			0x0209				/*  ISO 8859-9 */
#define kTextEncodingISOLatin6 			0x020A				/*  ISO 8859-10                            */
#define kTextEncodingISOLatin7 			0x020D				/*  ISO 8859-13, Baltic Rim                    */
#define kTextEncodingISOLatin8 			0x020E				/*  ISO 8859-14, Celtic                     */
#define kTextEncodingISOLatin9 			0x020F				/*  ISO 8859-15, 8859-1 changed for EURO & CP1252 letters   */

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

#define kTextEncodingISO_2022_JP 		0x0820				/*  RFC 1468 */
#define kTextEncodingISO_2022_JP_2 		0x0821				/*  RFC 1554 */
#define kTextEncodingISO_2022_JP_1 		0x0822				/*  RFC 2237 */
#define kTextEncodingISO_2022_CN 		0x0830
#define kTextEncodingISO_2022_CN_EXT 	0x0831
#define kTextEncodingISO_2022_KR 		0x0840

#define kTextEncodingEUC_JP 			0x0920				/*  ISO 646, 1-byte katakana, JIS 208, JIS 212 */
#define kTextEncodingEUC_CN 			0x0930				/*  ISO 646, GB 2312-80 */
#define kTextEncodingEUC_TW 			0x0931				/*  ISO 646, CNS 11643-1992 Planes 1-16 */
#define kTextEncodingEUC_KR 			0x0940				/*  ISO 646, KS C 5601-1987 */

#define kTextEncodingShiftJIS 			0x0A01				/*  plain Shift-JIS */
#define kTextEncodingKOI8_R 			0x0A02				/*  Russian internet standard */
#define kTextEncodingBig5 				0x0A03				/*  Big-5 (has variants) */
#define kTextEncodingMacRomanLatin1 	0x0A04				/*  Mac OS Roman permuted to align with ISO Latin-1 */
#define kTextEncodingHZ_GB_2312 		0x0A05				/*  HZ (RFC 1842, for Chinese mail & news) */

#define kTextEncodingNextStepLatin 		0x0B01				/*  NextStep encoding */
#define kTextEncodingEBCDIC_US 			0x0C01				/*  basic EBCDIC-US */
#define kTextEncodingEBCDIC_CP037 		0x0C02				/*  code page 037, extended EBCDIC (Latin-1 set) for US,Canada... */

#define kTextEncodingMultiRun 			0x0FFF				/*  Multi-encoding text with external run info */
#define kTextEncodingUnknown 			0xFFFF				/*  Unknown or unspecified                   */

#define kTextEncodingDefaultVariant 	0
#define kMacRomanDefaultVariant 		0					/*  meta value, maps to 1 or 2 depending on System  */
#define kMacRomanCurrencySignVariant 	1					/*  Mac OS version < 8.5, 0xDB is CURRENCY SIGN */
#define kMacRomanEuroSignVariant 		2					/*  Mac OS version >= 8.5, 0xDB is EURO SIGN       */

#define kMacCyrillicDefaultVariant 		0					/*  meta value, maps to 1, 2, or 3 depending on System */
#define kMacCyrillicCurrSignStdVariant 	1					/*  Mac OS < 9.0 (RU,BG), 0xFF = CURRENCY SIGN, 0xA2/0xB6 = CENT / PARTIAL DIFF. */
#define kMacCyrillicCurrSignUkrVariant 	2					/*  Mac OS < 9.0 (UA,LangKit), 0xFF = CURRENCY SIGN, 0xA2/0xB6 = GHE WITH UPTURN */
#define kMacCyrillicEuroSignVariant 	3					/*  Mac OS >= 9.0, 0xFF is EURO SIGN, 0xA2/0xB6 = GHE WITH UPTURN */

#define kMacIcelandicStdDefaultVariant 	0					/*  meta value, maps to 2 or 4 depending on System  */
#define kMacIcelandicTTDefaultVariant 	1					/*  meta value, maps to 3 or 5 depending on System  */
															/*  The following are for Mac OS version < 8.5, 0xDB is CURRENCY SIGN              */
#define kMacIcelandicStdCurrSignVariant  2					/*  0xBB/0xBC are fem./masc. ordinal indicators */
#define kMacIcelandicTTCurrSignVariant 	3					/*  0xBB/0xBC are fi/fl ligatures */
															/*  The following are for Mac OS version >= 8.5, 0xDB is EURO SIGN                   */
#define kMacIcelandicStdEuroSignVariant  4					/*  0xBB/0xBC are fem./masc. ordinal indicators */
#define kMacIcelandicTTEuroSignVariant 	5					/*  0xBB/0xBC are fi/fl ligatures */

#define kMacCroatianDefaultVariant 		0					/*  meta value, maps to 1 or 2 depending on System  */
#define kMacCroatianCurrencySignVariant  1					/*  Mac OS version < 8.5, 0xDB is CURRENCY SIGN        */
#define kMacCroatianEuroSignVariant 	2					/*  Mac OS version >= 8.5, 0xDB is EURO SIGN       */

#define kMacRomanianDefaultVariant 		0					/*  meta value, maps to 1 or 2 depending on System  */
#define kMacRomanianCurrencySignVariant  1					/*  Mac OS version < 8.5, 0xDB is CURRENCY SIGN        */
#define kMacRomanianEuroSignVariant 	2					/*  Mac OS version >= 8.5, 0xDB is EURO SIGN       */

#define kMacJapaneseStandardVariant 	0
#define kMacJapaneseStdNoVerticalsVariant  1
#define kMacJapaneseBasicVariant 		2
#define kMacJapanesePostScriptScrnVariant  3
#define kMacJapanesePostScriptPrintVariant  4
#define kMacJapaneseVertAtKuPlusTenVariant  5

#define kMacArabicStandardVariant 		0					/*  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Cairo) */
#define kMacArabicTrueTypeVariant 		1					/*  0xC0 is asterisk, 0x2A & 0xAA are multiply signs (e.g. Baghdad) */
#define kMacArabicThuluthVariant 		2					/*  0xC0 is Arabic five-point star, 0x2A & 0xAA are multiply signs */
#define kMacArabicAlBayanVariant 		3					/*  8-spoke asterisk, multiply sign, Koranic ligatures & parens */

#define kMacFarsiStandardVariant 		0					/*  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Tehran) */
#define kMacFarsiTrueTypeVariant 		1					/*  asterisk, multiply signs, Koranic ligatures, geometric shapes */

#define kMacHebrewStandardVariant 		0
#define kMacHebrewFigureSpaceVariant 	1

#define kMacVT100DefaultVariant 		0					/*  meta value, maps to 1 or 2 depending on System  */
#define kMacVT100CurrencySignVariant 	1					/*  Mac OS version < 8.5, 0xDB is CURRENCY SIGN        */
#define kMacVT100EuroSignVariant 		2					/*  Mac OS version >= 8.5, 0xDB is EURO SIGN       */

#define kUnicodeNoSubset 				0
#define kUnicodeCanonicalDecompVariant 	2					/*  canonical decomposition; excludes composed characters */

#define kBig5_BasicVariant 				0
#define kBig5_StandardVariant 			1					/*  0xC6A1-0xC7FC: kana, Cyrillic, enclosed numerics */
#define kBig5_ETenVariant 				2					/*  adds kana, Cyrillic, radicals, etc with hi bytes C6-C8,F9 */

#define kMacRomanLatin1DefaultVariant 	0					/*  meta value, maps to others depending on System */
#define kMacRomanLatin1StandardVariant 	2					/*  permuted MacRoman, EuroSignVariant */
#define kMacRomanLatin1TurkishVariant 	6					/*  permuted MacTurkish */
#define kMacRomanLatin1CroatianVariant 	8					/*  permuted MacCroatian, EuroSignVariant */
#define kMacRomanLatin1IcelandicVariant  11					/*  permuted MacIcelandic, StdEuroSignVariant */
#define kMacRomanLatin1RomanianVariant 	14					/*  permuted MacRomanian, EuroSignVariant */

#define kUnicodeNoCompatibilityVariant 	1
#define kUnicodeNoComposedVariant 		3
#define kUnicodeNoCorporateVariant 		4

#define kMacRomanStandardVariant 		0
#define kMacIcelandicStandardVariant 	0
#define kMacIcelandicTrueTypeVariant 	1
#define kJapaneseStandardVariant 		0
#define kJapaneseStdNoVerticalsVariant 	1
#define kJapaneseBasicVariant 			2
#define kJapanesePostScriptScrnVariant 	3
#define kJapanesePostScriptPrintVariant  4
#define kJapaneseVertAtKuPlusTenVariant  5					/*  kJapaneseStdNoOneByteKanaVariant = 6,  // replaced by kJapaneseNoOneByteKanaOption */
															/*  kJapaneseBasicNoOneByteKanaVariant = 7,    // replaced by kJapaneseNoOneByteKanaOption     */
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

#define kTextEncodingFullName 			0
#define kTextEncodingBaseName 			1
#define kTextEncodingVariantName 		2
#define kTextEncodingFormatName 		3

#define kTextScriptDontCare 			(-128)
#define kTextLanguageDontCare 			(-128)
#define kTextRegionDontCare 			(-128)

#define kTECInfoCurrentFormat 			2					/*  any future formats will just add fields at the end */
#define kTECKeepInfoFixBit 				0
#define kTECFallbackTextLengthFixBit 	1
#define kTECTextRunBitClearFixBit 		2
#define kTECTextToUnicodeScanFixBit 	3
#define kTECAddForceASCIIChangesBit 	4
#define kTECPreferredEncodingFixBit 	5
#define kTECAddTextRunHeuristicsBit 	6
#define kTECAddFallbackInterruptBit 	7

#define kTECKeepInfoFixMask 			0x00000001
#define kTECFallbackTextLengthFixMask 	0x00000002
#define kTECTextRunBitClearFixMask 		0x00000004
#define kTECTextToUnicodeScanFixMask 	0x00000008
#define kTECAddForceASCIIChangesMask 	0x00000010
#define kTECPreferredEncodingFixMask 	0x00000020
#define kTECAddTextRunHeuristicsMask 	0x00000040
#define kTECAddFallbackInterruptMask 	0x00000080

#define kUnicodeByteOrderMark 			0xFEFF
#define kUnicodeObjectReplacement 		0xFFFC				/*  placeholder for non-text object */
#define kUnicodeReplacementChar 		0xFFFD				/*  Unicode replacement for unconvertable input char */
#define kUnicodeSwappedByteOrderMark 	0xFFFE				/*  not a Unicode char; byte-swapped version of FEFF */
#define kUnicodeNotAChar 				0xFFFF				/*  not a Unicode char; may be used as a terminator */

#define kUCCharPropTypeGenlCategory 	1					/*  requests enumeration value */
#define kUCCharPropTypeCombiningClass 	2					/*  requests numeric value 0..255 */
#define kUCCharPropTypeBidiCategory 	3					/*  requests enumeration value */

															/*  Normative categories: */
#define kUCGenlCatOtherNotAssigned 		0					/*  Cn Other, Not Assigned */
#define kUCGenlCatOtherControl 			1					/*  Cc Other, Control */
#define kUCGenlCatOtherFormat 			2					/*  Cf Other, Format */
#define kUCGenlCatOtherSurrogate 		3					/*  Cs Other, Surrogate */
#define kUCGenlCatOtherPrivateUse 		4					/*  Co Other, Private Use */
#define kUCGenlCatMarkNonSpacing 		5					/*  Mn Mark, Non-Spacing */
#define kUCGenlCatMarkSpacingCombining 	6					/*  Mc Mark, Spacing Combining */
#define kUCGenlCatMarkEnclosing 		7					/*  Me Mark, Enclosing */
#define kUCGenlCatNumberDecimalDigit 	8					/*  Nd Number, Decimal Digit */
#define kUCGenlCatNumberLetter 			9					/*  Nl Number, Letter */
#define kUCGenlCatNumberOther 			10					/*  No Number, Other */
#define kUCGenlCatSeparatorSpace 		11					/*  Zs Separator, Space */
#define kUCGenlCatSeparatorLine 		12					/*  Zl Separator, Line */
#define kUCGenlCatSeparatorParagraph 	13					/*  Zp Separator, Paragraph */
#define kUCGenlCatLetterUppercase 		14					/*  Lu Letter, Uppercase */
#define kUCGenlCatLetterLowercase 		15					/*  Ll Letter, Lowercase */
#define kUCGenlCatLetterTitlecase 		16					/*  Lt Letter, Titlecase */
															/*  Informative categories: */
#define kUCGenlCatLetterModifier 		17					/*  Lm Letter, Modifier */
#define kUCGenlCatLetterOther 			18					/*  Lo Letter, Other */
#define kUCGenlCatPunctConnector 		20					/*  Pc Punctuation, Connector */
#define kUCGenlCatPunctDash 			21					/*  Pd Punctuation, Dash */
#define kUCGenlCatPunctOpen 			22					/*  Ps Punctuation, Open */
#define kUCGenlCatPunctClose 			23					/*  Pe Punctuation, Close */
#define kUCGenlCatPunctInitialQuote 	24					/*  Pi Punctuation, Initial quote */
#define kUCGenlCatPunctFinalQuote 		25					/*  Pf Punctuation, Final quote */
#define kUCGenlCatPunctOther 			26					/*  Po Punctuation, Other */
#define kUCGenlCatSymbolMath 			28					/*  Sm Symbol, Math */
#define kUCGenlCatSymbolCurrency 		29					/*  Sc Symbol, Currency */
#define kUCGenlCatSymbolModifier 		30					/*  Sk Symbol, Modifier */
#define kUCGenlCatSymbolOther 			31					/*  So Symbol, Other */

#define kUCBidiCatNotApplicable 		0					/*  for now use this for unassigned */
															/*  Strong types: */
#define kUCBidiCatLeftRight 			1					/*  L  Left-to-Right */
#define kUCBidiCatRightLeft 			2					/*  R  Right-to-Left */
															/*  Weak types: */
#define kUCBidiCatEuroNumber 			3					/*  EN European Number */
#define kUCBidiCatEuroNumberSeparator 	4					/*  ES European Number Separator */
#define kUCBidiCatEuroNumberTerminator 	5					/*  ET European Number Terminator */
#define kUCBidiCatArabicNumber 			6					/*  AN Arabic Number */
#define kUCBidiCatCommonNumberSeparator  7					/*  CS Common Number Separator */
															/*  Separators: */
#define kUCBidiCatBlockSeparator 		8					/*  B  Paragraph Separator (was Block Separator) */
#define kUCBidiCatSegmentSeparator 		9					/*  S  Segment Separator */
															/*  Neutrals: */
#define kUCBidiCatWhitespace 			10					/*  WS Whitespace */
#define kUCBidiCatOtherNeutral 			11					/*  ON Other Neutrals (unassigned codes could use this) */
															/*  New categories for Unicode 3.0 */
#define kUCBidiCatRightLeftArabic 		12					/*  AL Right-to-Left Arabic (was Arabic Letter) */
#define kUCBidiCatLeftRightEmbedding 	13					/*  LRE    Left-to-Right Embedding */
#define kUCBidiCatRightLeftEmbedding 	14					/*  RLE    Right-to-Left Embedding */
#define kUCBidiCatLeftRightOverride 	15					/*  LRO    Left-to-Right Override */
#define kUCBidiCatRightLeftOverride 	16					/*  RLO    Right-to-Left Override */
#define kUCBidiCatPopDirectionalFormat 	17					/*  PDF    Pop Directional Format */
#define kUCBidiCatNonSpacingMark 		18					/*  NSM    Non-Spacing Mark */
#define kUCBidiCatBoundaryNeutral 		19					/*  BN Boundary Neutral */


#endif /* __TEXTCOMMON_R__ */

