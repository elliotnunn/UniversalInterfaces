{
     File:       SFNTLayoutTypes.p
 
     Contains:   SFNT file layout structures and constants.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SFNTLayoutTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SFNTLAYOUTTYPES__}
{$SETC __SFNTLAYOUTTYPES__ := 1}

{$I+}
{$SETC SFNTLayoutTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ----------------------------------------------------------------------------------------- }
{ CONSTANTS }
{
    The following values can be used to set run feature values. Note that unless the
    feature is defaulted differently in different fonts, the zero value for the
    selectors represents the default value.  Check the following URL site for further info:
    "http://fonts.apple.com/Registry"
}


{
 *  Summary:
 *    Feature types
 }

CONST
	kAllTypographicFeaturesType	= 0;
	kLigaturesType				= 1;
	kCursiveConnectionType		= 2;
	kLetterCaseType				= 3;
	kVerticalSubstitutionType	= 4;
	kLinguisticRearrangementType = 5;
	kNumberSpacingType			= 6;
	kSmartSwashType				= 8;
	kDiacriticsType				= 9;
	kVerticalPositionType		= 10;
	kFractionsType				= 11;
	kOverlappingCharactersType	= 13;
	kTypographicExtrasType		= 14;
	kMathematicalExtrasType		= 15;
	kOrnamentSetsType			= 16;
	kCharacterAlternativesType	= 17;
	kDesignComplexityType		= 18;
	kStyleOptionsType			= 19;
	kCharacterShapeType			= 20;
	kNumberCaseType				= 21;
	kTextSpacingType			= 22;
	kTransliterationType		= 23;
	kAnnotationType				= 24;
	kKanaSpacingType			= 25;
	kIdeographicSpacingType		= 26;
	kUnicodeDecompositionType	= 27;
	kRubyKanaType				= 28;
	kCJKSymbolAlternativesType	= 29;
	kIdeographicAlternativesType = 30;
	kCJKVerticalRomanPlacementType = 31;
	kItalicCJKRomanType			= 32;
	kCJKRomanSpacingType		= 103;
	kLastFeatureType			= -1;


	{
	 *  Summary:
	 *    Selectors for feature type kAllTypographicFeaturesType
	 	}
	kAllTypeFeaturesOnSelector	= 0;
	kAllTypeFeaturesOffSelector	= 1;



	{
	 *  Summary:
	 *    Selectors for feature type kLigaturesType
	 	}
	kRequiredLigaturesOnSelector = 0;
	kRequiredLigaturesOffSelector = 1;
	kCommonLigaturesOnSelector	= 2;
	kCommonLigaturesOffSelector	= 3;
	kRareLigaturesOnSelector	= 4;
	kRareLigaturesOffSelector	= 5;
	kLogosOnSelector			= 6;
	kLogosOffSelector			= 7;
	kRebusPicturesOnSelector	= 8;
	kRebusPicturesOffSelector	= 9;
	kDiphthongLigaturesOnSelector = 10;
	kDiphthongLigaturesOffSelector = 11;
	kSquaredLigaturesOnSelector	= 12;
	kSquaredLigaturesOffSelector = 13;
	kAbbrevSquaredLigaturesOnSelector = 14;
	kAbbrevSquaredLigaturesOffSelector = 15;
	kSymbolLigaturesOnSelector	= 16;
	kSymbolLigaturesOffSelector	= 17;


	{
	 *  Summary:
	 *    Selectors for feature type kCursiveConnectionType
	 	}
	kUnconnectedSelector		= 0;
	kPartiallyConnectedSelector	= 1;
	kCursiveSelector			= 2;


	{
	 *  Summary:
	 *    Selectors for feature type kLetterCaseType
	 	}
	kUpperAndLowerCaseSelector	= 0;
	kAllCapsSelector			= 1;
	kAllLowerCaseSelector		= 2;
	kSmallCapsSelector			= 3;
	kInitialCapsSelector		= 4;
	kInitialCapsAndSmallCapsSelector = 5;


	{
	 *  Summary:
	 *    Selectors for feature type kVerticalSubstitutionType
	 	}
	kSubstituteVerticalFormsOnSelector = 0;
	kSubstituteVerticalFormsOffSelector = 1;


	{
	 *  Summary:
	 *    Selectors for feature type kLinguisticRearrangementType
	 	}
	kLinguisticRearrangementOnSelector = 0;
	kLinguisticRearrangementOffSelector = 1;


	{
	 *  Summary:
	 *    Selectors for feature type kNumberSpacingType
	 	}
	kMonospacedNumbersSelector	= 0;
	kProportionalNumbersSelector = 1;
	kThirdWidthNumbersSelector	= 2;
	kQuarterWidthNumbersSelector = 3;


	{
	 *  Summary:
	 *    Selectors for feature type kSmartSwashType
	 	}
	kWordInitialSwashesOnSelector = 0;
	kWordInitialSwashesOffSelector = 1;
	kWordFinalSwashesOnSelector	= 2;
	kWordFinalSwashesOffSelector = 3;
	kLineInitialSwashesOnSelector = 4;
	kLineInitialSwashesOffSelector = 5;
	kLineFinalSwashesOnSelector	= 6;
	kLineFinalSwashesOffSelector = 7;
	kNonFinalSwashesOnSelector	= 8;
	kNonFinalSwashesOffSelector	= 9;


	{
	 *  Summary:
	 *    Selectors for feature type kDiacriticsType
	 	}
	kShowDiacriticsSelector		= 0;
	kHideDiacriticsSelector		= 1;
	kDecomposeDiacriticsSelector = 2;


	{
	 *  Summary:
	 *    Selectors for feature type kVerticalPositionType
	 	}
	kNormalPositionSelector		= 0;
	kSuperiorsSelector			= 1;
	kInferiorsSelector			= 2;
	kOrdinalsSelector			= 3;


	{
	 *  Summary:
	 *    Selectors for feature type kFractionsType
	 	}
	kNoFractionsSelector		= 0;
	kVerticalFractionsSelector	= 1;
	kDiagonalFractionsSelector	= 2;


	{
	 *  Summary:
	 *    Selectors for feature type kOverlappingCharactersType
	 	}
	kPreventOverlapOnSelector	= 0;
	kPreventOverlapOffSelector	= 1;


	{
	 *  Summary:
	 *    Selectors for feature type kTypographicExtrasType
	 	}
	kHyphensToEmDashOnSelector	= 0;
	kHyphensToEmDashOffSelector	= 1;
	kHyphenToEnDashOnSelector	= 2;
	kHyphenToEnDashOffSelector	= 3;
	kSlashedZeroOnSelector		= 4;
	kSlashedZeroOffSelector		= 5;
	kFormInterrobangOnSelector	= 6;
	kFormInterrobangOffSelector	= 7;
	kSmartQuotesOnSelector		= 8;
	kSmartQuotesOffSelector		= 9;
	kPeriodsToEllipsisOnSelector = 10;
	kPeriodsToEllipsisOffSelector = 11;


	{
	 *  Summary:
	 *    Selectors for feature type kMathematicalExtrasType
	 	}
	kHyphenToMinusOnSelector	= 0;
	kHyphenToMinusOffSelector	= 1;
	kAsteriskToMultiplyOnSelector = 2;
	kAsteriskToMultiplyOffSelector = 3;
	kSlashToDivideOnSelector	= 4;
	kSlashToDivideOffSelector	= 5;
	kInequalityLigaturesOnSelector = 6;
	kInequalityLigaturesOffSelector = 7;
	kExponentsOnSelector		= 8;
	kExponentsOffSelector		= 9;


	{
	 *  Summary:
	 *    Selectors for feature type kOrnamentSetsType
	 	}
	kNoOrnamentsSelector		= 0;
	kDingbatsSelector			= 1;
	kPiCharactersSelector		= 2;
	kFleuronsSelector			= 3;
	kDecorativeBordersSelector	= 4;
	kInternationalSymbolsSelector = 5;
	kMathSymbolsSelector		= 6;


	{
	 *  Summary:
	 *    Selectors for feature type kCharacterAlternativesType
	 	}
	kNoAlternatesSelector		= 0;


	{
	 *  Summary:
	 *    Selectors for feature type kDesignComplexityType
	 	}
	kDesignLevel1Selector		= 0;
	kDesignLevel2Selector		= 1;
	kDesignLevel3Selector		= 2;
	kDesignLevel4Selector		= 3;
	kDesignLevel5Selector		= 4;


	{
	 *  Summary:
	 *    Selectors for feature type kStyleOptionsType
	 	}
	kNoStyleOptionsSelector		= 0;
	kDisplayTextSelector		= 1;
	kEngravedTextSelector		= 2;
	kIlluminatedCapsSelector	= 3;
	kTitlingCapsSelector		= 4;
	kTallCapsSelector			= 5;


	{
	 *  Summary:
	 *    Selectors for feature type kCharacterShapeType
	 	}
	kTraditionalCharactersSelector = 0;
	kSimplifiedCharactersSelector = 1;
	kJIS1978CharactersSelector	= 2;
	kJIS1983CharactersSelector	= 3;
	kJIS1990CharactersSelector	= 4;
	kTraditionalAltOneSelector	= 5;
	kTraditionalAltTwoSelector	= 6;
	kTraditionalAltThreeSelector = 7;
	kTraditionalAltFourSelector	= 8;
	kTraditionalAltFiveSelector	= 9;
	kExpertCharactersSelector	= 10;


	{
	 *  Summary:
	 *    Selectors for feature type kNumberCaseType
	 	}
	kLowerCaseNumbersSelector	= 0;
	kUpperCaseNumbersSelector	= 1;


	{
	 *  Summary:
	 *    Selectors for feature type kTextSpacingType
	 	}
	kProportionalTextSelector	= 0;
	kMonospacedTextSelector		= 1;
	kHalfWidthTextSelector		= 2;


	{
	 *  Summary:
	 *    Selectors for feature type kTransliterationType
	 	}
	kNoTransliterationSelector	= 0;
	kHanjaToHangulSelector		= 1;
	kHiraganaToKatakanaSelector	= 2;
	kKatakanaToHiraganaSelector	= 3;
	kKanaToRomanizationSelector	= 4;
	kRomanizationToHiraganaSelector = 5;
	kRomanizationToKatakanaSelector = 6;
	kHanjaToHangulAltOneSelector = 7;
	kHanjaToHangulAltTwoSelector = 8;
	kHanjaToHangulAltThreeSelector = 9;


	{
	 *  Summary:
	 *    Selectors for feature type kAnnotationType
	 	}
	kNoAnnotationSelector		= 0;
	kBoxAnnotationSelector		= 1;
	kRoundedBoxAnnotationSelector = 2;
	kCircleAnnotationSelector	= 3;
	kInvertedCircleAnnotationSelector = 4;
	kParenthesisAnnotationSelector = 5;
	kPeriodAnnotationSelector	= 6;
	kRomanNumeralAnnotationSelector = 7;
	kDiamondAnnotationSelector	= 8;
	kInvertedBoxAnnotationSelector = 9;
	kInvertedRoundedBoxAnnotationSelector = 10;


	{
	 *  Summary:
	 *    Selectors for feature type kKanaSpacingType
	 	}
	kFullWidthKanaSelector		= 0;
	kProportionalKanaSelector	= 1;


	{
	 *  Summary:
	 *    Selectors for feature type kIdeographicSpacingType
	 	}
	kFullWidthIdeographsSelector = 0;
	kProportionalIdeographsSelector = 1;
	kHalfWidthIdeographsSelector = 2;


	{
	 *  Summary:
	 *    Selectors for feature type kUnicodeDecompositionType
	 	}
	kCanonicalCompositionOnSelector = 0;
	kCanonicalCompositionOffSelector = 1;
	kCompatibilityCompositionOnSelector = 2;
	kCompatibilityCompositionOffSelector = 3;
	kTranscodingCompositionOnSelector = 4;
	kTranscodingCompositionOffSelector = 5;


	{
	 *  Summary:
	 *    Selectors for feature type kRubyKanaType
	 	}
	kNoRubyKanaSelector			= 0;
	kRubyKanaSelector			= 1;


	{
	 *  Summary:
	 *    Selectors for feature type kCJKSymbolAlternativesType
	 	}
	kNoCJKSymbolAlternativesSelector = 0;
	kCJKSymbolAltOneSelector	= 1;
	kCJKSymbolAltTwoSelector	= 2;
	kCJKSymbolAltThreeSelector	= 3;
	kCJKSymbolAltFourSelector	= 4;
	kCJKSymbolAltFiveSelector	= 5;


	{
	 *  Summary:
	 *    Selectors for feature type kIdeographicAlternativesType
	 	}
	kNoIdeographicAlternativesSelector = 0;
	kIdeographicAltOneSelector	= 1;
	kIdeographicAltTwoSelector	= 2;
	kIdeographicAltThreeSelector = 3;
	kIdeographicAltFourSelector	= 4;
	kIdeographicAltFiveSelector	= 5;


	{
	 *  Summary:
	 *    Selectors for feature type kCJKVerticalRomanPlacementType
	 	}
	kCJKVerticalRomanCenteredSelector = 0;
	kCJKVerticalRomanHBaselineSelector = 1;


	{
	 *  Summary:
	 *    Selectors for feature type kItalicCJKRomanType
	 	}
	kNoCJKItalicRomanSelector	= 0;
	kCJKItalicRomanSelector		= 1;


	{
	 *  Summary:
	 *    Selectors for feature type kCJKRomanSpacingType
	 	}
	kHalfWidthCJKRomanSelector	= 0;
	kProportionalCJKRomanSelector = 1;
	kDefaultCJKRomanSelector	= 2;
	kFullWidthCJKRomanSelector	= 3;

	{	 --------------------------------------------------------------------------- 	}
	{	 ---------------- Table Specific Typedefs and Constants -------------------- 	}
	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: lookup tables - used within various other tables 	}
	kSFNTLookupSimpleArray		= 0;							{  a simple array indexed by glyph code  }
	kSFNTLookupSegmentSingle	= 2;							{  segment mapping to single value  }
	kSFNTLookupSegmentArray		= 4;							{  segment mapping to lookup array  }
	kSFNTLookupSingleTable		= 6;							{  sorted list of glyph, value pairs  }
	kSFNTLookupTrimmedArray		= 8;							{  a simple trimmed array indexed by glyph code  }


TYPE
	SFNTLookupTableFormat				= UInt16;
	SFNTLookupValue						= UInt16;
	SFNTLookupOffset					= UInt16;
	SFNTLookupKind						= UInt32;
	{	
	    A BinarySearchHeader defines the five standard fields needed to perform quick
	    lookups in a lookup table (note that using UInt16s, and not ItemCounts or
	    similar types, is important here, since these tables are in fonts, and the
	    documented font formats specify 16-bit quantities).
		}
	SFNTLookupBinarySearchHeaderPtr = ^SFNTLookupBinarySearchHeader;
	SFNTLookupBinarySearchHeader = RECORD
		unitSize:				UInt16;									{  size of a unit in bytes  }
		nUnits:					UInt16;									{  number of units in table  }
		searchRange:			UInt16;									{  (largest power of two <= nUnits) * unitSize  }
		entrySelector:			UInt16;									{  log2 (largest power of two <= nUnits)  }
		rangeShift:				UInt16;									{  (nUnits - largest power of two <= nUnits) * unitSize  }
	END;

	{	 A format 0 lookup table maps all glyphs in the font to lookup values 	}
	SFNTLookupArrayHeaderPtr = ^SFNTLookupArrayHeader;
	SFNTLookupArrayHeader = RECORD
		lookupValues:			ARRAY [0..0] OF SFNTLookupValue;
	END;

	{	 A format 8 lookup table maps some range of glyphs in the font to lookup values 	}
	SFNTLookupTrimmedArrayHeaderPtr = ^SFNTLookupTrimmedArrayHeader;
	SFNTLookupTrimmedArrayHeader = RECORD
		firstGlyph:				UInt16;
		count:					UInt16;
		valueArray:				ARRAY [0..0] OF SFNTLookupValue;
	END;

	{	
	    Format 2 and format 4 lookup tables map ranges of glyphs to either single lookup
	    values (format 2), or per-glyph lookup values (format 4). Since both formats
	    use the same kind of data, only one unified set of segment-related structures
	    is defined.
		}
	SFNTLookupSegmentPtr = ^SFNTLookupSegment;
	SFNTLookupSegment = RECORD
		lastGlyph:				UInt16;
		firstGlyph:				UInt16;
		value:					ARRAY [0..0] OF UInt16;
	END;

	SFNTLookupSegmentHeaderPtr = ^SFNTLookupSegmentHeader;
	SFNTLookupSegmentHeader = RECORD
		binSearch:				SFNTLookupBinarySearchHeader;
		segments:				ARRAY [0..0] OF SFNTLookupSegment;
	END;

	{	 A format 6 lookup table maps single glyphs to lookup values. 	}
	SFNTLookupSinglePtr = ^SFNTLookupSingle;
	SFNTLookupSingle = RECORD
		glyph:					UInt16;
		value:					ARRAY [0..0] OF UInt16;
	END;

	SFNTLookupSingleHeaderPtr = ^SFNTLookupSingleHeader;
	SFNTLookupSingleHeader = RECORD
		binSearch:				SFNTLookupBinarySearchHeader;
		entries:				ARRAY [0..0] OF SFNTLookupSingle;
	END;

	{	 The format-specific part of the subtable header 	}
	SFNTLookupFormatSpecificHeaderPtr = ^SFNTLookupFormatSpecificHeader;
	SFNTLookupFormatSpecificHeader = RECORD
		CASE INTEGER OF
		0: (
			theArray:			SFNTLookupArrayHeader;
			);
		1: (
			segment:			SFNTLookupSegmentHeader;
			);
		2: (
			single:				SFNTLookupSingleHeader;
			);
		3: (
			trimmedArray:		SFNTLookupTrimmedArrayHeader;
			);
	END;

	{	 The overall subtable header 	}
	SFNTLookupTablePtr = ^SFNTLookupTable;
	SFNTLookupTable = RECORD
		format:					SFNTLookupTableFormat;					{  table format  }
		fsHeader:				SFNTLookupFormatSpecificHeader;			{  format specific header  }
	END;

	SFNTLookupTableHandle				= ^SFNTLookupTablePtr;
	{	 --------------------------------------------------------------------------- 	}
	{	 GENERAL FORMATS FOR STATE TABLES -- prefix "ST" 	}

CONST
	kSTClassEndOfText			= 0;
	kSTClassOutOfBounds			= 1;
	kSTClassDeletedGlyph		= 2;
	kSTClassEndOfLine			= 3;
	kSTSetMark					= $8000;
	kSTNoAdvance				= $4000;
	kSTMarkEnd					= $2000;
	kSTLigActionMask			= $3FFF;
	kSTRearrVerbMask			= $000F;


TYPE
	STClass								= UInt8;
	STEntryIndex						= UInt8;
	STHeaderPtr = ^STHeader;
	STHeader = RECORD
		filler:					SInt8;
		nClasses:				SInt8;
		classTableOffset:		UInt16;
		stateArrayOffset:		UInt16;
		entryTableOffset:		UInt16;
	END;

	STClassTablePtr = ^STClassTable;
	STClassTable = RECORD
		firstGlyph:				UInt16;
		nGlyphs:				UInt16;
		classes:				SInt8;
	END;

	STEntryZeroPtr = ^STEntryZero;
	STEntryZero = RECORD
		newState:				UInt16;
		flags:					UInt16;
	END;

	STEntryOnePtr = ^STEntryOne;
	STEntryOne = RECORD
		newState:				UInt16;
		flags:					UInt16;
		offset1:				UInt16;
	END;

	STEntryTwoPtr = ^STEntryTwo;
	STEntryTwo = RECORD
		newState:				UInt16;
		flags:					UInt16;
		offset1:				UInt16;
		offset2:				UInt16;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 GENERAL FORMATS FOR STATE TABLES to be used with 'morx' tables -- prefix "STX" 	}

CONST
	kSTXHasLigAction			= $2000;


TYPE
	STXClass							= UInt16;
	STXStateIndex						= UInt16;
	STXEntryIndex						= UInt16;
	STXHeaderPtr = ^STXHeader;
	STXHeader = RECORD
		nClasses:				UInt32;
		classTableOffset:		UInt32;
		stateArrayOffset:		UInt32;
		entryTableOffset:		UInt32;
	END;

	STXClassTable						= SFNTLookupTable;
	STXClassTablePtr 					= ^STXClassTable;
	STXEntryZeroPtr = ^STXEntryZero;
	STXEntryZero = RECORD
		newState:				STXStateIndex;
		flags:					UInt16;
	END;

	STXEntryOnePtr = ^STXEntryOne;
	STXEntryOne = RECORD
		newState:				STXStateIndex;
		flags:					UInt16;
		index1:					UInt16;
	END;

	STXEntryTwoPtr = ^STXEntryTwo;
	STXEntryTwo = RECORD
		newState:				STXStateIndex;
		flags:					UInt16;
		index1:					UInt16;
		index2:					UInt16;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'lcar' 	}
	{	 CONSTANTS 	}

CONST
	kLCARTag					= $6C636172;					{  'lcar'  }
	kLCARCurrentVersion			= $00010000;					{  current version number for 'lcar' table  }
	kLCARLinearFormat			= 0;
	kLCARCtlPointFormat			= 1;

	{	 TYPES 	}

TYPE
	LcarCaretClassEntryPtr = ^LcarCaretClassEntry;
	LcarCaretClassEntry = RECORD
		count:					UInt16;
		partials:				ARRAY [0..0] OF UInt16;					{  these are either FUnits or control-point numbers  }
	END;

	LcarCaretTablePtr = ^LcarCaretTable;
	LcarCaretTable = RECORD
		version:				Fixed;
		format:					UInt16;
		lookup:					SFNTLookupTable;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'just' 	}
	{	 CONSTANTS 	}

CONST
	kJUSTTag					= $6A757374;					{  'just'  }
	kJUSTCurrentVersion			= $00010000;
	kJUSTStandardFormat			= 0;
	kJUSTnoGlyphcode			= $FFFF;						{  used in a pcConditionalAddAction  }
	kJUSTpcDecompositionAction	= 0;
	kJUSTpcUnconditionalAddAction = 1;
	kJUSTpcConditionalAddAction	= 2;
	kJUSTpcGlyphStretchAction	= 3;
	kJUSTpcDuctilityAction		= 4;
	kJUSTpcGlyphRepeatAddAction	= 5;

	{	 Justification priority levels 	}
	kJUSTKashidaPriority		= 0;
	kJUSTSpacePriority			= 1;
	kJUSTLetterPriority			= 2;
	kJUSTNullPriority			= 3;
	kJUSTPriorityCount			= 4;

	{	 Justification flags 	}
	kJUSTOverridePriority		= $8000;
	kJUSTOverrideLimits			= $4000;
	kJUSTOverrideUnlimited		= $2000;
	kJUSTUnlimited				= $1000;
	kJUSTPriorityMask			= $0003;

	{	 TYPES 	}

TYPE
	JustPCActionType					= UInt16;
	JustificationFlags					= UInt16;
	{	 A JustPCDecompositionAction defines a ligature decomposition action. 	}
	JustPCDecompositionActionPtr = ^JustPCDecompositionAction;
	JustPCDecompositionAction = RECORD
		lowerLimit:				Fixed;
		upperLimit:				Fixed;
		order:					UInt16;
		count:					UInt16;
		glyphs:					ARRAY [0..0] OF UInt16;
	END;

	{	 A JUSTPCUnconditionalAddAction defines an unconditional glyph add action. 	}
	JustPCUnconditionalAddAction		= UInt16;
	{	
	    A JUSTPCConditionalAddAction defines a glyph substitution and add action. If the addGlyph
	    is equal to kJUSTnoGlyphcode, then no glyph will be added, and the justification for
	    the line will be redone.
		}
	JustPCConditionalAddActionPtr = ^JustPCConditionalAddAction;
	JustPCConditionalAddAction = RECORD
		substThreshhold:		Fixed;									{  threshhold of growth factor at which subst occurs  }
		addGlyph:				UInt16;
		substGlyph:				UInt16;
	END;

	{	 A PCDuctilityAction defines a ductile axis along which the glyph will be varied. 	}
	JustPCDuctilityActionPtr = ^JustPCDuctilityAction;
	JustPCDuctilityAction = RECORD
		ductilityAxis:			UInt32;
		minimumLimit:			Fixed;
		noStretchValue:			Fixed;
		maximumLimit:			Fixed;
	END;

	{	
	    A PCGlyphRepetitionAction defines a glyph which will not be stretched or otherwise
	    transformed, but rather which will be emplaced however many times are needed to fill
	    the needed gap.
		}
	JustPCGlyphRepeatAddActionPtr = ^JustPCGlyphRepeatAddAction;
	JustPCGlyphRepeatAddAction = RECORD
		flags:					UInt16;
		glyph:					UInt16;
	END;

	{	 PCActionSubrecords contain the actual postcompensation actions. 	}
	JustPCActionSubrecordPtr = ^JustPCActionSubrecord;
	JustPCActionSubrecord = RECORD
		theClass:				UInt16;									{  justification class value associated with this rec  }
		theType:				JustPCActionType;
		length:					UInt32;
		data:					UInt32;									{  not really a UInt32; cast as ptr to appropriate action  }
	END;

	{	 The set of postcompensation records is defined in a PCAction struct. 	}
	JustPCActionPtr = ^JustPCAction;
	JustPCAction = RECORD
		actionCount:			UInt32;									{  long for alignment purposes  }
		actions:				ARRAY [0..0] OF JustPCActionSubrecord;
	END;

	{	
	    JustWidthDeltaEntry is the justification table entry structure.  The justClass value (which is
	    actually limited to 7 bits by the state table structure) is defined as a long for PPC alignment reasons.
		}
	JustWidthDeltaEntryPtr = ^JustWidthDeltaEntry;
	JustWidthDeltaEntry = RECORD
		justClass:				UInt32;
		beforeGrowLimit:		Fixed;									{  ems AW can grow by at most on LT  }
		beforeShrinkLimit:		Fixed;									{  ems AW can shrink by at most on LT  }
		afterGrowLimit:			Fixed;									{  ems AW can grow by at most on RB  }
		afterShrinkLimit:		Fixed;									{  ems AW can shrink by at most on RB  }
		growFlags:				JustificationFlags;						{  flags controlling grow case  }
		shrinkFlags:			JustificationFlags;						{  flags controlling shrink case  }
	END;

	JustWidthDeltaGroupPtr = ^JustWidthDeltaGroup;
	JustWidthDeltaGroup = RECORD
		count:					UInt32;
		entries:				ARRAY [0..0] OF JustWidthDeltaEntry;
	END;

	{	 Overall structure of a postcompensation table is defined in PostcompTable. 	}
	JustPostcompTablePtr = ^JustPostcompTable;
	JustPostcompTable = RECORD
		lookupTable:			SFNTLookupTable;
																		{  action records here  }
	END;

	JustDirectionTablePtr = ^JustDirectionTable;
	JustDirectionTable = RECORD
		justClass:				UInt16;									{  offset to state table (0=none)  }
		widthDeltaClusters:		UInt16;									{  offset to clusters  }
		postcomp:				UInt16;									{  offset to postcomp table (0=none)  }
		lookup:					SFNTLookupTable;
	END;

	JustTablePtr = ^JustTable;
	JustTable = RECORD
		version:				Fixed;
		format:					UInt16;
		horizHeaderOffset:		UInt16;
		vertHeaderOffset:		UInt16;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'opbd' 	}
	{	 CONSTANTS 	}

CONST
	kOPBDTag					= $6F706264;					{  'opbd'  }
	kOPBDCurrentVersion			= $00010000;
	kOPBDDistanceFormat			= 0;
	kOPBDControlPointFormat		= 1;

	{	 TYPES 	}

TYPE
	OpbdTableFormat						= UInt16;
	{	
	    The OpbdSideValues struct is the lookup result from the FindSingle call for the
	    optical tables. It contains the 4 FUnit values that are relevant to the specified
	    glyph, or the 4 control gxPoint values.
		}
	OpbdSideValuesPtr = ^OpbdSideValues;
	OpbdSideValues = RECORD
		leftSideShift:			SInt16;
		topSideShift:			SInt16;
		rightSideShift:			SInt16;
		bottomSideShift:		SInt16;
	END;

	OpbdTablePtr = ^OpbdTable;
	OpbdTable = RECORD
		version:				Fixed;
		format:					OpbdTableFormat;
		lookupTable:			SFNTLookupTable;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'mort' 	}
	{	 CONSTANTS 	}

CONST
	kMORTTag					= $6D6F7274;					{  'mort'  }
	kMORTCurrentVersion			= $00010000;					{  current version number for 'mort' table  }
																{  Coverage masks  }
	kMORTCoverVertical			= $8000;
	kMORTCoverDescending		= $4000;
	kMORTCoverIgnoreVertical	= $2000;
	kMORTCoverTypeMask			= $000F;						{  Subtable types  }
	kMORTRearrangementType		= 0;
	kMORTContextualType			= 1;
	kMORTLigatureType			= 2;
	kMORTSwashType				= 4;
	kMORTInsertionType			= 5;							{  Ligature subtable constants  }
	kMORTLigLastAction			= $80000000;
	kMORTLigStoreLigature		= $40000000;
	kMORTLigFormOffsetMask		= $3FFFFFFF;
	kMORTLigFormOffsetShift		= 2;							{  Rearrangement subtable actions  }
	kMORTraNoAction				= 0;							{     no action    }
	kMORTraxA					= 1;							{       Ax => xA     }
	kMORTraDx					= 2;							{       xD => Dx     }
	kMORTraDxA					= 3;							{      AxD => DxA    }
	kMORTraxAB					= 4;							{    ABx => xAB    }
	kMORTraxBA					= 5;							{    ABx => xBA    }
	kMORTraCDx					= 6;							{    xCD => CDx    }
	kMORTraDCx					= 7;							{    xCD => DCx    }
	kMORTraCDxA					= 8;							{   AxCD => CDxA   }
	kMORTraDCxA					= 9;							{   AxCD => DCxA   }
	kMORTraDxAB					= 10;							{   ABxD => DxAB   }
	kMORTraDxBA					= 11;							{   ABxD => DxBA   }
	kMORTraCDxAB				= 12;							{  ABxCD => CDxAB  }
	kMORTraCDxBA				= 13;							{  ABxCD => CDxBA  }
	kMORTraDCxAB				= 14;							{  ABxCD => DCxAB  }
	kMORTraDCxBA				= 15;							{  ABxCD => DCxBA  }
																{  Insertion subtable constants  }
	kMORTDoInsertionsBefore		= $80;
	kMORTIsSplitVowelPiece		= $40;
	kMORTInsertionsCountMask	= $3F;
	kMORTCurrInsertKashidaLike	= $2000;
	kMORTMarkInsertKashidaLike	= $1000;
	kMORTCurrInsertBefore		= $0800;
	kMORTMarkInsertBefore		= $0400;
	kMORTMarkJustTableCountMask	= $3F80;
	kMORTMarkJustTableCountShift = 7;							{  JustTableIndex for marked character  }
	kMORTCurrJustTableCountMask	= $007F;
	kMORTCurrJustTableCountShift = 0;							{  JustTableIndex for current character  }
	kMORTCurrInsertCountMask	= $03E0;
	kMORTCurrInsertCountShift	= 5;							{  count to insert after current glyphRec  }
	kMORTMarkInsertCountMask	= $001F;
	kMORTMarkInsertCountShift	= 0;							{  count to insert after marked glyphRec  }

	{	 TYPES 	}

TYPE
	MortSubtableMaskFlags				= UInt32;
	MortLigatureActionEntry				= UInt32;
	MortRearrangementSubtablePtr = ^MortRearrangementSubtable;
	MortRearrangementSubtable = RECORD
		header:					STHeader;
	END;

	MortContextualSubtablePtr = ^MortContextualSubtable;
	MortContextualSubtable = RECORD
		header:					STHeader;
		substitutionTableOffset: UInt16;
	END;

	MortLigatureSubtablePtr = ^MortLigatureSubtable;
	MortLigatureSubtable = RECORD
		header:					STHeader;
		ligatureActionTableOffset: UInt16;
		componentTableOffset:	UInt16;
		ligatureTableOffset:	UInt16;
	END;

	MortSwashSubtablePtr = ^MortSwashSubtable;
	MortSwashSubtable = RECORD
		lookup:					SFNTLookupTable;
	END;

	MortInsertionSubtablePtr = ^MortInsertionSubtable;
	MortInsertionSubtable = RECORD
		header:					STHeader;
	END;

	MortSpecificSubtablePtr = ^MortSpecificSubtable;
	MortSpecificSubtable = RECORD
		CASE INTEGER OF
		0: (
			rearrangement:		MortRearrangementSubtable;
			);
		1: (
			contextual:			MortContextualSubtable;
			);
		2: (
			ligature:			MortLigatureSubtable;
			);
		3: (
			swash:				MortSwashSubtable;
			);
		4: (
			insertion:			MortInsertionSubtable;
			);
	END;

	MortSubtablePtr = ^MortSubtable;
	MortSubtable = RECORD
		length:					UInt16;
		coverage:				UInt16;
		flags:					MortSubtableMaskFlags;
		u:						MortSpecificSubtable;
	END;

	MortFeatureEntryPtr = ^MortFeatureEntry;
	MortFeatureEntry = RECORD
		featureType:			UInt16;
		featureSelector:		UInt16;
		enableFlags:			MortSubtableMaskFlags;
		disableFlags:			MortSubtableMaskFlags;
	END;

	MortChainPtr = ^MortChain;
	MortChain = RECORD
		defaultFlags:			MortSubtableMaskFlags;					{  default flags for this chain  }
		length:					UInt32;									{  byte length of this chain  }
		nFeatures:				UInt16;									{  number of feature entries  }
		nSubtables:				UInt16;									{  number of subtables  }
		featureEntries:			ARRAY [0..0] OF MortFeatureEntry;
																		{  the subtables follow  }
	END;

	MortTablePtr = ^MortTable;
	MortTable = RECORD
		version:				Fixed;
		nChains:				UInt32;
		chains:					ARRAY [0..0] OF MortChain;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'morx' (version 2 and beyond metamorphosis tables) 	}
	{	 CONSTANTS 	}

CONST
	kMORXTag					= $6D6F7278;					{  'morx'  }
	kMORXCurrentVersion			= $00020000;					{  version number for current 'morx' table  }
																{  Coverage masks  }
	kMORXCoverVertical			= $80000000;
	kMORXCoverDescending		= $40000000;
	kMORXCoverIgnoreVertical	= $20000000;
	kMORXCoverTypeMask			= $000000FF;

	{	 TYPES 	}

TYPE
	MorxRearrangementSubtablePtr = ^MorxRearrangementSubtable;
	MorxRearrangementSubtable = RECORD
		header:					STXHeader;
	END;

	MorxContextualSubtablePtr = ^MorxContextualSubtable;
	MorxContextualSubtable = RECORD
		header:					STXHeader;
		substitutionTableOffset: UInt32;
	END;

	MorxLigatureSubtablePtr = ^MorxLigatureSubtable;
	MorxLigatureSubtable = RECORD
		header:					STXHeader;
		ligatureActionTableOffset: UInt32;
		componentTableOffset:	UInt32;
		ligatureTableOffset:	UInt32;
	END;

	MorxInsertionSubtablePtr = ^MorxInsertionSubtable;
	MorxInsertionSubtable = RECORD
		header:					STXHeader;
		insertionGlyphTableOffset: UInt32;
	END;

	MorxSpecificSubtablePtr = ^MorxSpecificSubtable;
	MorxSpecificSubtable = RECORD
		CASE INTEGER OF
		0: (
			rearrangement:		MorxRearrangementSubtable;
			);
		1: (
			contextual:			MorxContextualSubtable;
			);
		2: (
			ligature:			MorxLigatureSubtable;
			);
		3: (
			swash:				MortSwashSubtable;
			);
		4: (
			insertion:			MorxInsertionSubtable;
			);
	END;

	MorxSubtablePtr = ^MorxSubtable;
	MorxSubtable = RECORD
		length:					UInt32;
		coverage:				UInt32;
		flags:					MortSubtableMaskFlags;
		u:						MorxSpecificSubtable;
	END;

	MorxChainPtr = ^MorxChain;
	MorxChain = RECORD
		defaultFlags:			MortSubtableMaskFlags;					{  default flags for this chain  }
		length:					UInt32;									{  byte length of this chain  }
		nFeatures:				UInt32;									{  number of feature entries  }
		nSubtables:				UInt32;									{  number of subtables  }
		featureEntries:			ARRAY [0..0] OF MortFeatureEntry;
																		{  the subtables follow  }
	END;

	MorxTablePtr = ^MorxTable;
	MorxTable = RECORD
		version:				Fixed;
		nChains:				UInt32;
		chains:					ARRAY [0..0] OF MorxChain;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'prop' 	}
	{	 CONSTANTS 	}

CONST
	kPROPTag					= $70726F70;					{  'prop'  }
	kPROPCurrentVersion			= $00020000;					{  current version number for 'prop' table  }
	kPROPPairOffsetShift		= 8;
	kPROPPairOffsetSign			= 7;
	kPROPIsFloaterMask			= $8000;						{  glyph is floater  }
	kPROPCanHangLTMask			= $4000;						{  glyph can hang left/top  }
	kPROPCanHangRBMask			= $2000;						{  glyph can hang right/bottom  }
	kPROPUseRLPairMask			= $1000;						{  if glyph lands in RL streak, use paired glyph  }
	kPROPPairOffsetMask			= $0F00;						{  4-bit signed offset to other pair member  }
	kPROPRightConnectMask		= $0080;						{  glyph connects to glyph on right  }
	kPROPZeroReserved			= $0060;						{  must be zero  }
	kPROPDirectionMask			= $001F;						{  direction bits  }

	{	 These are the Unicode direction classes (plus the Special European Number class). 	}
	kPROPLDirectionClass		= 0;							{  Left-to-Right  }
	kPROPRDirectionClass		= 1;							{  Right-to-Left  }
	kPROPALDirectionClass		= 2;							{  Right-to-Left Arabic Letter  }
	kPROPENDirectionClass		= 3;							{  European Number  }
	kPROPESDirectionClass		= 4;							{  European Number Seperator  }
	kPROPETDirectionClass		= 5;							{  European Number Terminator  }
	kPROPANDirectionClass		= 6;							{  Arabic Number  }
	kPROPCSDirectionClass		= 7;							{  Common Number Seperator  }
	kPROPPSDirectionClass		= 8;							{  Paragraph Seperator (also referred to as Block Separator)  }
	kPROPSDirectionClass		= 9;							{  Segment Seperator  }
	kPROPWSDirectionClass		= 10;							{  Whitespace  }
	kPROPONDirectionClass		= 11;							{  Other Neutral  }
	kPROPSENDirectionClass		= 12;							{  Special European Number (not a Unicode class)  }
	kPROPLREDirectionClass		= 13;							{  Left-to-Right Embeding  }
	kPROPLRODirectionClass		= 14;							{  Left-to-Right Override  }
	kPROPRLEDirectionClass		= 15;							{  Right-to-Left Embeding  }
	kPROPRLODirectionClass		= 16;							{  Right-to-Left Override  }
	kPROPPDFDirectionClass		= 17;							{  Pop Directional Format  }
	kPROPNSMDirectionClass		= 18;							{  Non-Spacing Mark  }
	kPROPBNDirectionClass		= 19;							{  Boundary Neutral  }
	kPROPNumDirectionClasses	= 20;							{  Number of Unicode directional types + Special European Number  }

	{	 TYPES 	}

TYPE
	PropCharProperties					= UInt16;
	PropTablePtr = ^PropTable;
	PropTable = RECORD
		version:				Fixed;
		format:					UInt16;
		defaultProps:			PropCharProperties;
		lookup:					SFNTLookupTable;
	END;

	PropLookupSegmentPtr = ^PropLookupSegment;
	PropLookupSegment = RECORD
		lastGlyph:				UInt16;
		firstGlyph:				UInt16;
		value:					UInt16;
	END;

	PropLookupSinglePtr = ^PropLookupSingle;
	PropLookupSingle = RECORD
		glyph:					UInt16;
		props:					PropCharProperties;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'trak' 	}
	{	 CONSTANTS 	}

CONST
	kTRAKTag					= $7472616B;					{  'trak'  }
	kTRAKCurrentVersion			= $00010000;					{  current version number for 'trak' table  }
	kTRAKUniformFormat			= 0;							{     kTRAKPerGlyphFormat         = 2 }

	{	 TYPES 	}

TYPE
	TrakValue							= SInt16;
	TrakTableEntryPtr = ^TrakTableEntry;
	TrakTableEntry = RECORD
		track:					Fixed;
		nameTableIndex:			UInt16;
		sizesOffset:			UInt16;									{  offset to array of TrackingValues  }
	END;

	TrakTableDataPtr = ^TrakTableData;
	TrakTableData = RECORD
		nTracks:				UInt16;
		nSizes:					UInt16;
		sizeTableOffset:		UInt32;
		trakTable:				ARRAY [0..0] OF TrakTableEntry;
	END;

	TrakTablePtr = ^TrakTable;
	TrakTable = RECORD
		version:				Fixed;
		format:					UInt16;
		horizOffset:			UInt16;
		vertOffset:				UInt16;
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'kern' 	}
	{	 CONSTANTS 	}

CONST
	kKERNTag					= $6B65726E;					{  'kern'  }
	kKERNCurrentVersion			= $00010000;
	kKERNVertical				= $8000;						{  set if this table has vertical kerning information  }
	kKERNResetCrossStream		= $8000;						{  this value in a cross-stream table means reset to zero  }
	kKERNCrossStream			= $4000;						{  set if this table contains cross-stream kerning values  }
	kKERNVariation				= $2000;						{  set if this table contains variation kerning values  }
	kKERNUnusedBits				= $1F00;						{  UNUSED, MUST BE ZERO  }
	kKERNFormatMask				= $00FF;						{  format of this subtable  }

	kKERNOrderedList			= 0;							{  ordered list of kerning pairs  }
	kKERNStateTable				= 1;							{  state table for n-way contextual kerning  }
	kKERNSimpleArray			= 2;							{  simple n X m array of kerning values  }
	kKERNIndexArray				= 3;							{  modifed version of SimpleArray  }

	{	 Message Type Flags 	}
	kKERNLineStart				= $00000001;					{  Array of glyphs starts a line  }
	kKERNLineEndKerning			= $00000002;					{  Array of glyphs ends a line  }
	kKERNNoCrossKerning			= $00000004;					{  Prohibit cross kerning  }
	kKERNNotesRequested			= $00000008;					{  Caller wants kerning notes  }
	kKERNNoStakeNote			= 1;							{  Indicates a glyph was involved in a kerning pair/group  }
	kKERNCrossStreamResetNote	= 2;							{  Indicates a return-to-baseline in cross-stream kerning  }
	kKERNNotApplied				= $00000001;					{  All kerning values were zero, kerning call had no effect  }

	{	 TYPES 	}

TYPE
	KernTableFormat						= UInt8;
	KernSubtableInfo					= UInt16;
	KernKerningValue					= SInt16;
	KernArrayOffset						= UInt16;
	{	 header for version 0 kerning table 	}
	KernVersion0HeaderPtr = ^KernVersion0Header;
	KernVersion0Header = RECORD
		version:				UInt16;									{  font version number (will be 0!)  }
		nTables:				UInt16;									{  number of subtables present  }
		firstSubtable:			ARRAY [0..0] OF UInt16;					{  first subtable starts here  }
	END;

	{	 Header for a kerning table 	}
	KernTableHeaderPtr = ^KernTableHeader;
	KernTableHeader = RECORD
		version:				Fixed;									{  font version number (currently 1.0)  }
		nTables:				SInt32;									{  number of subtables present  }
		firstSubtable:			ARRAY [0..0] OF UInt16;					{  first subtable starts here  }
	END;

	KernTableHeaderHandle				= ^KernTableHeaderPtr;
	{	
	    F O R M A T   S P E C I F I C   D E F I N I T I O N S
	
	    kernOrderedList:
	    
	    The table is a sorted list of [left glyph, right glyph, value] triples.
	    There's enough information in the header so that the list can be
	    efficiently binary searched. 
		}
	{	 defines a single kerning pair of Glyphcodes  	}
	KernKerningPairPtr = ^KernKerningPair;
	KernKerningPair = RECORD
		left:					UInt16;
		right:					UInt16;
	END;

	{	 a single list entry 	}
	KernOrderedListEntryPtr = ^KernOrderedListEntry;
	KernOrderedListEntry = RECORD
		pair:					KernKerningPair;						{  the kerning pair  }
		value:					KernKerningValue;						{  the kerning value for the above pair  }
	END;

	{	 the header information for binary searching the list 	}
	KernOrderedListHeaderPtr = ^KernOrderedListHeader;
	KernOrderedListHeader = RECORD
		nPairs:					UInt16;									{  number of kerning pairs in table  }
		searchRange:			UInt16;									{  (largest power of two <= nPairs) * entry size  }
		entrySelector:			UInt16;									{  log2 (largest power of two <= nPairs)  }
		rangeShift:				UInt16;									{  (nPairs - largest power of two <= nPairs) * entry size  }
		table:					ARRAY [0..0] OF UInt16;					{  entries are first glyph, second glyph, and value  }
	END;

	{	 KernStateTable: like the the generic state tables 	}
	KernStateHeaderPtr = ^KernStateHeader;
	KernStateHeader = RECORD
		header:					STHeader;								{  state table header  }
		valueTable:				UInt16;									{  offset to kerning value table  }
		firstTable:				SInt8;									{  first table starts here  }
	END;

	KernStateEntryPtr = ^KernStateEntry;
	KernStateEntry = RECORD
		newState:				UInt16;
		flags:					UInt16;									{  flags per above enum  }
	END;

	{	
	    Kern offset table header.
	    The offset table is a trimmed array from firstGlyph to limitGlyph.
	    Glyphs outside of this range should get zero for right-hand glyphs
	    and the offset of the beginning of the kerning array for left-hand glyphs.
		}
	KernOffsetTablePtr = ^KernOffsetTable;
	KernOffsetTable = RECORD
		firstGlyph:				UInt16;									{  first glyph in class range  }
		nGlyphs:				UInt16;									{  number of glyphs in class range  }
		offsetTable:			ARRAY [0..0] OF KernArrayOffset;		{  offset table starts here  }
	END;

	{	 Header information for accessing offset tables and kerning array 	}
	{	
	    KernSimpleArray:
	    
	    The array is an nXm array of kenring values. Each row in the array
	    represents one left-hand glyph, and each column one right-hand glyph.
	    The zeroth row and column always represent glyphs that are out of bounds
	    and will always contain zero.
	    
	    A pair is looked up by indexing the left-hand glyph through the left
	    offset table, the right-hand glyph through the right offset table,
	    adding both offsets to the starting address of the kerning array,
	    and fetching the kerning value pointed to.
		}
	{	 Kern offset table header. 	}
	{	 The offset table is a trimmed array from firstGlyph to limitGlyph. 	}
	{	 Glyphs outside of this range should get zero for right-hand glyphs 	}
	{	 and the offset of the beginning of the kerning array for left- 	}
	{	 hand glyphs. 	}
	KernSimpleArrayHeaderPtr = ^KernSimpleArrayHeader;
	KernSimpleArrayHeader = RECORD
		rowWidth:				UInt16;									{  width, in bytes, of a row in the table  }
		leftOffsetTable:		UInt16;									{  offset to left-hand offset table  }
		rightOffsetTable:		UInt16;									{  offset to right-hand offset table  }
		theArray:				KernArrayOffset;						{  offset to start of kerning array  }
		firstTable:				ARRAY [0..0] OF UInt16;					{  first offset table starts here...  }
	END;

	{	 Index Array 	}
	KernIndexArrayHeaderPtr = ^KernIndexArrayHeader;
	KernIndexArrayHeader = RECORD
		glyphCount:				UInt16;
		kernValueCount:			SInt8;
		leftClassCount:			SInt8;
		rightClassCount:		SInt8;
		flags:					SInt8;									{  set to 0 for now  }
		kernValue:				ARRAY [0..0] OF SInt16;					{  actual kerning values reference by index in kernIndex  }
		leftClass:				SInt8;									{  maps left glyph to offset into kern index  }
		rightClass:				SInt8;									{  maps right glyph to offset into kern index  }
		kernIndex:				SInt8;									{  contains indicies into kernValue  }
	END;

	{	 format specific part of subtable header 	}
	KernFormatSpecificHeaderPtr = ^KernFormatSpecificHeader;
	KernFormatSpecificHeader = RECORD
		CASE INTEGER OF
		0: (
			orderedList:		KernOrderedListHeader;
			);
		1: (
			stateTable:			KernStateHeader;
			);
		2: (
			simpleArray:		KernSimpleArrayHeader;
			);
		3: (
			indexArray:			KernIndexArrayHeader;
			);
	END;

	{	 version 0 subtable header 	}
	KernVersion0SubtableHeaderPtr = ^KernVersion0SubtableHeader;
	KernVersion0SubtableHeader = RECORD
		version:				UInt16;									{  kerning table version number  }
		length:					UInt16;									{  length in bytes (including this header)  }
		stInfo:					KernSubtableInfo;						{  sub-table info  }
		fsHeader:				KernFormatSpecificHeader;				{  format specific sub-header  }
	END;

	{	 Overall Subtable header format 	}
	KernSubtableHeaderPtr = ^KernSubtableHeader;
	KernSubtableHeader = RECORD
		length:					SInt32;									{  length in bytes (including this header)  }
		stInfo:					KernSubtableInfo;						{  subtable info  }
		tupleIndex:				SInt16;									{  tuple index for variation subtables  }
		fsHeader:				KernFormatSpecificHeader;				{  format specific sub-header  }
	END;

	{	 --------------------------------------------------------------------------- 	}
	{	 FORMATS FOR TABLE: 'bsln' 	}
	{	 CONSTANTS 	}

CONST
	kBSLNTag					= $62736C6E;					{  'bsln'  }
	kBSLNCurrentVersion			= $00010000;					{  current version number for 'bsln' table  }
	kBSLNDistanceFormatNoMap	= 0;
	kBSLNDistanceFormatWithMap	= 1;
	kBSLNControlPointFormatNoMap = 2;
	kBSLNControlPointFormatWithMap = 3;

	{	 Baseline classes and constants 	}
	kBSLNRomanBaseline			= 0;
	kBSLNIdeographicCenterBaseline = 1;
	kBSLNIdeographicLowBaseline	= 2;
	kBSLNHangingBaseline		= 3;
	kBSLNMathBaseline			= 4;
	kBSLNLastBaseline			= 31;
	kBSLNNumBaselineClasses		= 32;
	kBSLNNoBaselineOverride		= 255;

	{	 TYPES 	}

TYPE
	BslnBaselineClass					= UInt32;
	{	 The BslnBaselineRecord array defines the baseline deltas for the line. 	}
	BslnBaselineRecord					= ARRAY [0..31] OF Fixed;
	{	
	    BslnFormat0Part is the format-specific data for a distance table with no mapping (i.e.
	    all the glyphs belong to the defaultBaseline).
		}
	BslnFormat0PartPtr = ^BslnFormat0Part;
	BslnFormat0Part = RECORD
		deltas:					ARRAY [0..31] OF SInt16;
	END;

	{	 BslnFormat1Part is the format-specific data for a distance table with a gxMapping. 	}
	BslnFormat1PartPtr = ^BslnFormat1Part;
	BslnFormat1Part = RECORD
		deltas:					ARRAY [0..31] OF SInt16;
		mappingData:			SFNTLookupTable;
	END;

	{	
	    BslnFormat2Part is the format-specific data for a control-point table with no
	    mapping (i.e. all the glyphs belong to the defaultBaseline). It specifies a single
	    glyph to use and the set of control points in that glyph that designate each of
	    the baselines.
		}
	BslnFormat2PartPtr = ^BslnFormat2Part;
	BslnFormat2Part = RECORD
		stdGlyph:				UInt16;
		ctlPoints:				ARRAY [0..31] OF SInt16;
	END;

	{	
	    BslnFormat3Part is the format-specific data for a distance table with a mapping. Like
	    format 2, it contains a single glyph and its set of control-point values for each
	    of the baselines.
		}
	BslnFormat3PartPtr = ^BslnFormat3Part;
	BslnFormat3Part = RECORD
		stdGlyph:				UInt16;
		ctlPoints:				ARRAY [0..31] OF SInt16;
		mappingData:			SFNTLookupTable;
	END;

	{	 The BslnFormatUnion is a union containing the format-specific parts of the baseline table. 	}
	BslnFormatUnionPtr = ^BslnFormatUnion;
	BslnFormatUnion = RECORD
		CASE INTEGER OF
		0: (
			fmt0Part:			BslnFormat0Part;
			);
		1: (
			fmt1Part:			BslnFormat1Part;
			);
		2: (
			fmt2Part:			BslnFormat2Part;
			);
		3: (
			fmt3Part:			BslnFormat3Part;
			);
	END;

	{	 The table format used in BaselineTable 	}
	BslnTableFormat						= UInt16;
	{	 BaselineTable defines the top-level format of the baseline table in the font. 	}
	BslnTablePtr = ^BslnTable;
	BslnTable = RECORD
		version:				Fixed;
		format:					BslnTableFormat;
		defaultBaseline:		UInt16;
		parts:					BslnFormatUnion;
	END;

	{	 --------------------------------------------------------------------------- 	}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SFNTLayoutTypesIncludes}

{$ENDC} {__SFNTLAYOUTTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
