{
     File:       ATSUnicode.p
 
     Contains:   Public interfaces for Apple Type Services for Unicode Imaging
 
     Version:    Technology: Mac OS 9 / Carbon
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ATSUnicode;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ATSUNICODE__}
{$SETC __ATSUNICODE__ := 1}

{$I+}
{$SETC ATSUnicodeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$IFC UNDEFINED __ATSLAYOUTTYPES__}
{$I ATSLayoutTypes.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTLAYOUTTYPES__}
{$I SFNTLayoutTypes.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __ATSTYPES__}
{$I ATSTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{******************************}
{  Types and related constants }
{******************************}
{
   UniCharArrayHandle and UniCharArrayOffset are defined in the
   TextCommon interface file.
}

{
    ATSUTextMeasurement is specific to ATSUI in that measurement
    quantities are in fractional Fixed format instead of shorts
    used in QuickDraw Text.  This provides exact outline metrics and
    line specifications such as line width, ascent, descent, and so on.  
}

TYPE
	ATSUTextMeasurement					= Fixed;
	{
	    ATSUFontID indicates a particular font family and face.  
	    ATSUFontID's are not guaranteed to remain constant across 
	    reboots.  Clients should use the font's unique name to 
	    get a font token to store in documents which is 
	    guaranteed to remain constant across reboots. 
	}
	ATSUFontID							= FMFont;
	{
	    ATSUFontFeatureType and ATSUFontFeatureSelector are used 
	    to identify font features.  
	}
	ATSUFontFeatureType					= UInt16;
	ATSUFontFeatureSelector				= UInt16;
	{
	    ATSUFontVariationAxis and ATSUFontVariationValue are used 
	    in connection with font variations.  
	}
	ATSUFontVariationAxis				= FourCharCode;
	ATSUFontVariationValue				= Fixed;
	{  Ptr types }
	ATSUFontFeatureTypePtr				= ^ATSUFontFeatureType;
	ATSUFontFeatureSelectorPtr			= ^ATSUFontFeatureSelector;
	ATSUFontVariationAxisPtr			= ^ATSUFontVariationAxis;
	ATSUFontVariationValuePtr			= ^ATSUFontVariationValue;
	{
	    ATSUTextLayout is used to store the attribute information 
	    associated with a contiguous block of UniChar's (UInt16's) 
	    in memory.  It's typed to be an opaque structure.  
	}
	ATSUTextLayout    = ^LONGINT; { an opaque 32-bit type }
	ATSUTextLayoutPtr = ^ATSUTextLayout;  { when a VAR xx:ATSUTextLayout parameter can be nil, it is changed to xx: ATSUTextLayoutPtr }
	{
	    ATSUStyle is used to store a set of individual attributes, 
	    font features, and font variations.  It's typed to be 
	    an opaque structure.  
	}
	ATSUStyle    = ^LONGINT; { an opaque 32-bit type }
	ATSUStylePtr = ^ATSUStyle;  { when a VAR xx:ATSUStyle parameter can be nil, it is changed to xx: ATSUStylePtr }
	{
	    ATSUFontFallbacks is used to store the desired font fallback 
	    list and associated fallback cache information.  It's typed
	    to be an opaque structure.  
	}
	ATSUFontFallbacks    = ^LONGINT; { an opaque 32-bit type }
	ATSUFontFallbacksPtr = ^ATSUFontFallbacks;  { when a VAR xx:ATSUFontFallbacks parameter can be nil, it is changed to xx: ATSUFontFallbacksPtr }
	{
	    ATSUAttributeTag is used to indicate the particular type 
	    of attribute under consideration:  font, size, color, 
	    and so on.  
	    Each style run may have at most one attribute with a 
	    given ATSUAttributeTag (i.e., a style run can't have 
	    more than one font or size) but may have none.  
	    Note: Apple reserves values 0 to 65,535 (0 to 0x0000FFFF).
	    ATSUI clients may create their own tags with any other value.
	}
	ATSUAttributeTag 			= UInt32;
CONST
																{     Layout and Line Control Attribute Tags }
	kATSULineWidthTag			= 1;							{     Type:       ATSUTextMeasurement }
																{     Default value: 0 }
	kATSULineRotationTag		= 2;							{     Type:       Fixed (fixed value in degrees in right-handed coordinate system) }
																{     Default value: 0 }
	kATSULineDirectionTag		= 3;							{     Type:       Boolean; values 0 or 1 (see below for value identities) }
																{     Default value: GetSysDirection() ? kATSURightToLeftBaseDirection : kATSULeftToRightBaseDirection }
	kATSULineJustificationFactorTag = 4;						{     Type:       Fract between 0 and 1 }
																{     Default value: kATSUNoJustification }
	kATSULineFlushFactorTag		= 5;							{     Type:       Fract between 0 and 1  }
																{     Default value: kATSUStartAlignment }
	kATSULineBaselineValuesTag	= 6;							{     Type:       BslnBaselineRecord }
																{     Default value: All zeros.  Calculated from other style attributes (e.g., font and point size) }
	kATSULineLayoutOptionsTag	= 7;							{     Type:       ATSLineLayoutOptions (see ATSLayoutTypes.h) }
																{     Default value: kATSLineNoLayoutOptions - other options listed in ATSLayoutTypes.h }
	kATSULineAscentTag			= 8;							{     Type:       ATSUTextMeasurement }
																{     Default value: kATSUseLineHeight }
	kATSULineDescentTag			= 9;							{     Type:       ATSUTextMeasurement }
																{     Default value: kATSUseLineHeight }
	kATSULineLangRegionTag		= 10;							{     Type:       RegionCode - region values listed in script.h interface file }
																{     Default value: kTextRegionDontCare }
	kATSULineTextLocatorTag		= 11;							{     Type:       TextBreakLocatorRef }
																{     Default value: NULL - set Region derived locator or the default Text Utilities locator }
	kATSULineTruncationTag		= 12;							{     Type:       ATSULineTruncation }
																{     Default value: kATSUTruncateNone                                                        }
	kATSULineFontFallbacksTag	= 13;							{     Type:       ATSUFontFallbacks }
																{     Default value: globally set font fallbacks using the ATSUSetFontFallbacks                                                      }
	kATSUMaxLineTag				= 14;							{     This is just for convenience - the upper limit of the ATSUTextLayout attribute tags }
																{  obsolete layout tags  }
	kATSULineLanguageTag		= 10;							{     Use kATSULineLangRegionTag            }
																{     Run Style Attribute Tags }
																{  QuickDraw compatibility tags  }
	kATSUQDBoldfaceTag			= 256;							{     Type:       Boolean     }
																{     Default value: false }
	kATSUQDItalicTag			= 257;							{     Type:       Boolean        }
																{     Default value: false }
	kATSUQDUnderlineTag			= 258;							{     Type:       Boolean     }
																{     Default value: false }
	kATSUQDCondensedTag			= 259;							{     Type:       Boolean     }
																{     Default value: false }
	kATSUQDExtendedTag			= 260;							{     Type:       Boolean     }
																{     Default value: false }
																{  Common run tags  }
	kATSUFontTag				= 261;							{     Type:       ATSUFontID  }
																{     Default value: GetScriptVariable( smSystemScript, smScriptAppFond ) }
	kATSUSizeTag				= 262;							{     Type:       Fixed   }
																{     Default value: GetScriptVariable( smSystemScript, smScriptAppFondSize )     }
	kATSUColorTag				= 263;							{     Type:       RGBColor    }
																{     Default value: (0, 0, 0) }
																{     Less common run tags  }
	kATSULangRegionTag			= 264;							{     Type:       RegionCode - region values listed in script.h interface file }
																{     Default value: GetScriptManagerVariable( smRegionCode ) }
	kATSUVerticalCharacterTag	= 265;							{     Type:       ATSUVerticalCharacterType   }
																{     Default value: kATSUStronglyHorizontal }
	kATSUImposeWidthTag			= 266;							{     Type:       ATSUTextMeasurement }
																{     Default value: 0 - all glyphs use their own font defined advance widths }
	kATSUBeforeWithStreamShiftTag = 267;						{     Type:       Fixed }
																{     Default value: 0 }
	kATSUAfterWithStreamShiftTag = 268;							{     Type:       Fixed }
																{     Default value: 0 }
	kATSUCrossStreamShiftTag	= 269;							{     Type:       Fixed }
																{     Default value: 0 }
	kATSUTrackingTag			= 270;							{     Type:       Fixed }
																{     Default value: kATSNoTracking }
	kATSUHangingInhibitFactorTag = 271;							{     Type:       Fract between 0 and 1 }
																{     Default value: 0 }
	kATSUKerningInhibitFactorTag = 272;							{     Type:       Fract between 0 and 1 }
																{     Default value: 0 }
	kATSUDecompositionFactorTag	= 273;							{     Type:       Fixed (-1.0 -> 1.0) }
																{     Default value: 0 }
	kATSUBaselineClassTag		= 274;							{     Type:       BslnBaselineClass  (see SFNTLayoutTypes.h) }
																{     Default value: kBSLNRomanBaseline - set to kBSLNNoBaselineOverride to use intrinsic baselines }
	kATSUPriorityJustOverrideTag = 275;							{     Type:       ATSJustPriorityWidthDeltaOverrides (see ATSLayoutTypes.h) }
																{     Default value: all zeros }
	kATSUNoLigatureSplitTag		= 276;							{     Type:       Boolean }
																{     Default value: false - ligatures and compound characters have divisable components. }
	kATSUNoCaretAngleTag		= 277;							{     Type:       Boolean }
																{     Default value: false - use the character's angularity to determine its boundaries }
	kATSUSuppressCrossKerningTag = 278;							{     Type:       Boolean }
																{     Default value: false - do not suppress automatic cross kerning (defined by font) }
	kATSUNoOpticalAlignmentTag	= 279;							{     Type:       Boolean }
																{     Default value: false - do not suppress character's automatic optical positional alignment }
	kATSUForceHangingTag		= 280;							{     Type:       Boolean }
																{     Default value: false - do not force the character's to hang beyond the line boundaries }
	kATSUNoSpecialJustificationTag = 281;						{     Type:       Boolean }
																{     Default value: false - perform post-compensation justification if needed }
	kATSUStyleTextLocatorTag	= 282;							{     Type:       TextBreakLocatorRef }
																{     Default value: NULL - region derived locator or the default Text Utilities locator }
	kATSUStyleRenderingOptionsTag = 283;						{     Type:       ATSStyleRenderingOptions (see ATSLayoutTypes.h) }
																{     Default value: kATSStyleApplyHints - ATS glyph rendering uses hinting }
	kATSUMaxStyleTag			= 284;							{     This is just for convenience - the upper limit of the ATSUStyle attribute tags  }
																{  obsolete style tags  }
	kATSULanguageTag			= 264;							{     use kATSULangRegionTag                }
																{  special layout tag for Mac OS X  }
	kATSUCGContextTag			= 32767;						{   Type:          CGContext, Default value:    NULL    }
																{  max  }
	kATSUMaxATSUITagValue		= 65535;						{     This is the maximum Apple ATSUI reserved tag value.  Client defined tags must be larger. }

	{
	    ATSUAttributeValuePtr is used to provide generic access to
	    storage of attribute values, which vary in size.
	    ConstATSUAttributeValuePtr is a pointer to a const attribute value.
	}

TYPE
	ATSUAttributeValuePtr				= Ptr;
	ConstATSUAttributeValuePtr			= Ptr;
	{
	    ATSUAttributeInfo is used to provide a tag/size pairing.  
	    This makes it possible to provide the client information   
	    about all the attributes for a given range of text.  This   
	    structure is only used to return to the client information   
	    about a complete set of attributes.  An array of   
	    ATSUAttributeInfos is passed as a parameter so that the   
	    client can find out what attributes are set and what their   
	    individual sizes are; with that information, they can then   
	    query about the values of the attributes they're interested   
	    in.  Because arrays of ATSUAttributeInfos are used as parameters   
	    to functions, they have to be of a fixed size, hence the   
	    value is not included in the structure.  
	}
	ATSUAttributeInfoPtr = ^ATSUAttributeInfo;
	ATSUAttributeInfo = RECORD
		fTag:					ATSUAttributeTag;
		fValueSize:				ByteCount;
	END;

	{
	    ATSUCaret contains the complete information needed to render a
	    caret.  fX and fY is the position of one of the caret's ends
	    relative to the origin position of the line the caret belongs.
	    fDeltaX and fDeltaY is the position of the caret's other end.
	    Hence, to draw a caret, simply call MoveTo(fX, fY) followed by
	    LineTo(fDeltaX, fDeltaY) or equivalent.  The ATSUCaret will
	    contain the positions needed to draw carets on angled lines
	    and reflect angled carets and leading/trailing split caret
	    appearances.
	}
	ATSUCaretPtr = ^ATSUCaret;
	ATSUCaret = RECORD
		fX:						Fixed;
		fY:						Fixed;
		fDeltaX:				Fixed;
		fDeltaY:				Fixed;
	END;

	{
	    ATSUCursorMovementType is used to indicate how much to move
	    the cursor when using the ATSUI cusor movement routines. 
	    Note that kATSUByCharacterCluster is only available in Mac OS X
	    and in CarbonLib versions 1.3 and later.
	}
	ATSUCursorMovementType 		= UInt16;
CONST
	kATSUByCharacter			= 0;
	kATSUByTypographicCluster	= 1;							{  clusters based on characters or ligatures }
	kATSUByWord					= 2;
	kATSUByCharacterCluster		= 3;							{  clusters based on characters only }
	kATSUByCluster				= 1;							{  obsolete name for kATSUByTypographicCluster }

	{
	    ATSULineTruncation is for identifying where truncation will occur when
	    using a ATSUTextLayout with the ATSULineTruncation layout attribute.
	}

TYPE
	ATSULineTruncation 			= UInt32;
CONST
	kATSUTruncateNone			= 0;							{  truncation specification - add to any desired truncFeat bit options listed below }
	kATSUTruncateStart			= 1;							{  for instance, kATSUTruncateEnd with kATSUTruncFeatNoSquishing is value 0x0000000A }
	kATSUTruncateEnd			= 2;
	kATSUTruncateMiddle			= 3;
	kATSUTruncateSpecificationMask = $00000007;					{  these bits are reserved for the truncation specification (0 - 7) }
																{  the following bit-field options can be added to the chosen truncation specification }
	kATSUTruncFeatNoSquishing	= $00000008;					{  if specified, do not perform any negative justification in lieu of truncation }

	{
	    ATSUVerticalCharacterType currently can take two values 
	    and is used to indicate whether text is to be laid out 
	    as vertical glyphs or horizontal glyphs.  
	}

TYPE
	ATSUVerticalCharacterType 	= UInt16;
CONST
	kATSUStronglyHorizontal		= 0;
	kATSUStronglyVertical		= 1;


	{
	    ATSUStyleComparison is an enumeration with four values, 
	    and is used by ATSUCompareStyles() to indicate if the
	    first style parameter contains as a proper subset, is
	    equal to, or is contained by the second style parameter.
	}

TYPE
	ATSUStyleComparison 		= UInt16;
CONST
	kATSUStyleUnequal			= 0;
	kATSUStyleContains			= 1;
	kATSUStyleEquals			= 2;
	kATSUStyleContainedBy		= 3;


	{
	    ATSUFontFallbackMethod type defines the method by which ATSUI will try to
	    find an appropriate font for a character if the assigned font does not
	    contain the needed glyph(s) to represent it.  This affects ATSUMatchFontsToText
	    and font selection during layout and drawing when ATSUSetTransientFontMatching
	    is set ON.
	}

TYPE
	ATSUFontFallbackMethod 		= UInt16;
CONST
	kATSUDefaultFontFallbacks	= 0;
	kATSULastResortOnlyFallback	= 1;
	kATSUSequentialFallbacksPreferred = 2;
	kATSUSequentialFallbacksExclusive = 3;


{$IFC CALL_NOT_IN_CARBON }
	{
	    ATSUMemoryCallbacks is a union struct that allows the ATSUI 
	    client to specify a specific heap for ATSUI use or allocation
	    callbacks of which ATSUI is to use each time ATSUI performs a
	    memory operation (alloc, grow, free).
	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATSUCustomAllocFunc = FUNCTION(refCon: UNIV Ptr; howMuch: ByteCount): Ptr; C;
{$ELSEC}
	ATSUCustomAllocFunc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSUCustomFreeFunc = PROCEDURE(refCon: UNIV Ptr; doomedBlock: UNIV Ptr); C;
{$ELSEC}
	ATSUCustomFreeFunc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSUCustomGrowFunc = FUNCTION(refCon: UNIV Ptr; oldBlock: UNIV Ptr; oldSize: ByteCount; newSize: ByteCount): Ptr; C;
{$ELSEC}
	ATSUCustomGrowFunc = ProcPtr;
{$ENDC}

	ATSUMemoryCallbacksPtr = ^ATSUMemoryCallbacks;
	ATSUMemoryCallbacks = RECORD
		CASE INTEGER OF
		0: (
			Alloc:				ATSUCustomAllocFunc;
			Free:				ATSUCustomFreeFunc;
			Grow:				ATSUCustomGrowFunc;
			memoryRefCon:		Ptr;
		   );
		1: (
			heapToUse:			THz;
			);
	END;

	{
	    ATSUHeapSpec provides the ATSUI client a means of specifying the heap
	    from which ATSUI should allocate its dynamic memory or specifying
	    that ATSUI should use the memory callback provided by the client.
	}
	ATSUHeapSpec 				= UInt16;
CONST
	kATSUUseCurrentHeap			= 0;
	kATSUUseAppHeap				= 1;
	kATSUUseSpecificHeap		= 2;
	kATSUUseCallbacks			= 3;


	{
	    ATSUMemorySetting is used to store the results from a ATSUSetMemoryAlloc
	    or a ATSUGetCurrentMemorySetting call.  It can also be used to change the
	    current ATSUMemorySetting by passing it into the ATSUSetCurrentMemorySetting
	    call.
	}

TYPE
	ATSUMemorySetting    = ^LONGINT; { an opaque 32-bit type }
	ATSUMemorySettingPtr = ^ATSUMemorySetting;  { when a VAR xx:ATSUMemorySetting parameter can be nil, it is changed to xx: ATSUMemorySettingPtr }
{$ENDC}  {CALL_NOT_IN_CARBON}

{ Types for ATSUI Low Level API }

TYPE
	ATSUGlyphInfoPtr = ^ATSUGlyphInfo;
	ATSUGlyphInfo = RECORD
		glyphID:				GlyphID;
		reserved:				UInt16;
		layoutFlags:			UInt32;
		charIndex:				UniCharArrayOffset;
		style:					ATSUStyle;
		deltaY:					Float32;
		idealX:					Float32;
		screenX:				SInt16;
		caretX:					SInt16;
	END;

	ATSUGlyphInfoArrayPtr = ^ATSUGlyphInfoArray;
	ATSUGlyphInfoArray = RECORD
		layout:					ATSUTextLayout;
		numGlyphs:				ItemCount;
		glyphs:					ARRAY [0..0] OF ATSUGlyphInfo;
	END;


	{	*******************************************************************************	}
	{	  ATSUI Highlighting method constants and typedefs             	}
	{	*******************************************************************************	}
	ATSUHighlightMethod 		= UInt32;
CONST
	kInvertHighlighting			= 0;
	kRedrawHighlighting			= 1;


TYPE
	ATSUBackgroundDataType 		= UInt32;
CONST
	kATSUBackgroundColor		= 0;
	kATSUBackgroundCallback		= 1;


TYPE
	ATSUBackgroundColorPtr = ^ATSUBackgroundColor;
	ATSUBackgroundColor = RECORD
		red:					Single;
		green:					Single;
		blue:					Single;
		alpha:					Single;
	END;


	{
	 *  RedrawBackgroundProcPtr
	 *  
	 *  Discussion:
	 *    RedrawBackgroundProcPtr is a pointer to a client-supplied
	 *    callback function (e.g. MyRedrawBackgroundProc) for redrawing
	 *    complex backgrounds (and optionally the text as well) that can be
	 *    called by ATSUI for highlighting if the client has called
	 *    ATSUSetHighlightingMethod with iMethod=kRedrawHighlighting. In
	 *    order for ATSUI to call the client function, the client must (1)
	 *    pass a pointer to the client function to NewRedrawBackgroundUPP()
	 *    in order to obtain a RedrawBackgroundUPP, and (2) pass the
	 *    RedrawBackgroundUPP in the unhighlightData.backgroundUPP field of
	 *    the iUnhighlightData parameter for the  ATSUSetHighlightingMethod
	 *    call. When finished, the client should call
	 *    DisposeRedrawBackgroundUPP with the RedrawBackgroundUPP.
	 *  
	 *  Parameters:
	 *    
	 *    iLayout:
	 *      The layout to which the highlighting is being applied. The
	 *      client function can use this to redraw the text.
	 *    
	 *    iTextOffset:
	 *      The offset of the text that is being highlighted; can be used
	 *      by the client function to redraaw the text.
	 *    
	 *    iTextLength:
	 *      The length of the text that is being highlighted; can be used
	 *      by the client function to redraaw the text.
	 *    
	 *    iUnhighlightArea:
	 *      An array of ATSTrapezoids that describes the highlight area.
	 *      The ATSTrapezoid array is ALWAYS in QD coordinates.
	 *    
	 *    iTrapezoidCount:
	 *      The count of ATSTrapezoids in iUnhighlightArea.
	 *  
	 *  Result:
	 *    A Boolean result indicating whether ATSUI should redraw the text.
	 *    If the client function redraws the text, it should return false,
	 *    otherwise it should return true to have ATSUI redraw any text
	 *    that needs to be redrawn.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	RedrawBackgroundProcPtr = FUNCTION(iLayout: ATSUTextLayout; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; VAR iUnhighlightArea: ATSTrapezoid; iTrapezoidCount: ItemCount): BOOLEAN;
{$ELSEC}
	RedrawBackgroundProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	RedrawBackgroundUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	RedrawBackgroundUPP = RedrawBackgroundProcPtr;
{$ENDC}	

CONST
	uppRedrawBackgroundProcInfo = $0000FFD0;
	{
	 *  NewRedrawBackgroundUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib on Mac OS X
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION NewRedrawBackgroundUPP(userRoutine: RedrawBackgroundProcPtr): RedrawBackgroundUPP;
{
 *  DisposeRedrawBackgroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeRedrawBackgroundUPP(userUPP: RedrawBackgroundUPP);
{
 *  InvokeRedrawBackgroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeRedrawBackgroundUPP(iLayout: ATSUTextLayout; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; VAR iUnhighlightArea: ATSTrapezoid; iTrapezoidCount: ItemCount; userRoutine: RedrawBackgroundUPP): BOOLEAN;

TYPE
	ATSUBackgroundDataPtr = ^ATSUBackgroundData;
	ATSUBackgroundData = RECORD
		CASE INTEGER OF
		0: (
			backgroundColor:	ATSUBackgroundColor;
			);
		1: (
			backgroundUPP:		RedrawBackgroundUPP;
			);
	END;

	ATSUUnhighlightDataPtr = ^ATSUUnhighlightData;
	ATSUUnhighlightData = RECORD
		dataType:				ATSUBackgroundDataType;
		unhighlightData:		ATSUBackgroundData;
	END;


	{	******************	}
	{	  Other constants 	}
	{	******************	}
	{	 Line direction types (used for kATSULineDirectionTag values) 	}

CONST
	kATSULeftToRightBaseDirection = 0;							{     Impose left-to-right or top-to-bottom dominant direction  }
	kATSURightToLeftBaseDirection = 1;							{     Impose right-to-left or bottom-to-top dominant direction  }

	{	 LineFlushFactor convenience defined values 	}
	kATSUStartAlignment			= $00000000;
	kATSUEndAlignment			= $40000000;
	kATSUCenterAlignment		= $20000000;

	{	 LineJustificationFactor convenience defined values 	}
	kATSUNoJustification		= $00000000;
	kATSUFullJustification		= $40000000;

	{	 Other constants  	}
	kATSUInvalidFontID			= 0;


	kATSUUseLineControlWidth	= $7FFFFFFF;


	kATSUNoSelector				= $0000FFFF;


	kATSUUseGrafPortPenLoc		= $FFFFFFFF;
	kATSUClearAll				= $FFFFFFFF;


	kATSUFromTextBeginning		= $FFFFFFFF;
	kATSUToTextEnd				= $FFFFFFFF;


	{	**************	}
	{	  Functions   	}
	{	**************	}

	{	  Clipboard support, flattened style version 0 (it is advised to not use these routines and perform your own flattening)  	}
	{
	 *  ATSUCopyToHandle()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION ATSUCopyToHandle(iStyle: ATSUStyle; oStyleHandle: Handle): OSStatus; C;

{
 *  ATSUPasteFromHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUPasteFromHandle(iStyle: ATSUStyle; iStyleHandle: Handle): OSStatus; C;

{  Memory allocation specification functions (not in Carbon)   }
{$IFC CALL_NOT_IN_CARBON }
{
 *  ATSUCreateMemorySetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATSUCreateMemorySetting(iHeapSpec: ATSUHeapSpec; VAR iMemoryCallbacks: ATSUMemoryCallbacks; VAR oMemorySetting: ATSUMemorySetting): OSStatus; C;

{
 *  ATSUSetCurrentMemorySetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATSUSetCurrentMemorySetting(iMemorySetting: ATSUMemorySetting): OSStatus; C;

{
 *  ATSUGetCurrentMemorySetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATSUGetCurrentMemorySetting: ATSUMemorySetting; C;

{
 *  ATSUDisposeMemorySetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATSUDisposeMemorySetting(iMemorySetting: ATSUMemorySetting): OSStatus; C;

{  Font fallback object functions  }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  ATSUCreateFontFallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.2.2 and later
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION ATSUCreateFontFallbacks(VAR oFontFallback: ATSUFontFallbacks): OSStatus; C;

{
 *  ATSUDisposeFontFallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.2.2 and later
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION ATSUDisposeFontFallbacks(iFontFallbacks: ATSUFontFallbacks): OSStatus; C;

{
 *  ATSUSetObjFontFallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.2.2 and later
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION ATSUSetObjFontFallbacks(iFontFallbacks: ATSUFontFallbacks; iFontFallbacksCount: ItemCount; {CONST}VAR iFonts: ATSUFontID; iFontFallbackMethod: ATSUFontFallbackMethod): OSStatus; C;

{
 *  ATSUGetObjFontFallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.2.2 and later
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION ATSUGetObjFontFallbacks(iFontFallbacks: ATSUFontFallbacks; iMaxFontFallbacksCount: ItemCount; VAR oFonts: ATSUFontID; VAR oFontFallbackMethod: ATSUFontFallbackMethod; VAR oActualFallbacksCount: ItemCount): OSStatus; C;

{  Basic style functions   }
{
 *  ATSUCreateStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCreateStyle(VAR oStyle: ATSUStyle): OSStatus; C;

{
 *  ATSUCreateAndCopyStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCreateAndCopyStyle(iStyle: ATSUStyle; VAR oStyle: ATSUStyle): OSStatus; C;

{
 *  ATSUDisposeStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUDisposeStyle(iStyle: ATSUStyle): OSStatus; C;

{
 *  ATSUSetStyleRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetStyleRefCon(iStyle: ATSUStyle; iRefCon: UInt32): OSStatus; C;

{
 *  ATSUGetStyleRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetStyleRefCon(iStyle: ATSUStyle; VAR oRefCon: UInt32): OSStatus; C;

{  Style comparison        }
{
 *  ATSUCompareStyles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCompareStyles(iFirstStyle: ATSUStyle; iSecondStyle: ATSUStyle; VAR oComparison: ATSUStyleComparison): OSStatus; C;

{  Attribute manipulations }
{
 *  ATSUCopyAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCopyAttributes(iSourceStyle: ATSUStyle; iDestinationStyle: ATSUStyle): OSStatus; C;

{
 *  ATSUOverwriteAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUOverwriteAttributes(iSourceStyle: ATSUStyle; iDestinationStyle: ATSUStyle): OSStatus; C;

{
 *  ATSUUnderwriteAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUUnderwriteAttributes(iSourceStyle: ATSUStyle; iDestinationStyle: ATSUStyle): OSStatus; C;

{  Empty styles    }
{
 *  ATSUClearStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearStyle(iStyle: ATSUStyle): OSStatus; C;

{
 *  ATSUStyleIsEmpty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUStyleIsEmpty(iStyle: ATSUStyle; VAR oIsClear: BOOLEAN): OSStatus; C;

{  Get and set attributes }
{
 *  ATSUCalculateBaselineDeltas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCalculateBaselineDeltas(iStyle: ATSUStyle; iBaselineClass: BslnBaselineClass; VAR oBaselineDeltas: BslnBaselineRecord): OSStatus; C;

{
 *  ATSUSetAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetAttributes(iStyle: ATSUStyle; iAttributeCount: ItemCount; {CONST}VAR iTag: ATSUAttributeTag; {CONST}VAR iValueSize: ByteCount; {CONST}VAR iValue: ATSUAttributeValuePtr): OSStatus; C;

{
 *  ATSUGetAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetAttribute(iStyle: ATSUStyle; iTag: ATSUAttributeTag; iExpectedValueSize: ByteCount; oValue: ATSUAttributeValuePtr; VAR oActualValueSize: ByteCount): OSStatus; C;

{
 *  ATSUGetAllAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetAllAttributes(iStyle: ATSUStyle; VAR oAttributeInfoArray: ATSUAttributeInfo; iTagValuePairArraySize: ItemCount; VAR oTagValuePairCount: ItemCount): OSStatus; C;

{
 *  ATSUClearAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearAttributes(iStyle: ATSUStyle; iTagCount: ItemCount; {CONST}VAR iTag: ATSUAttributeTag): OSStatus; C;

{  Font features   }
{
 *  ATSUSetFontFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetFontFeatures(iStyle: ATSUStyle; iFeatureCount: ItemCount; {CONST}VAR iType: ATSUFontFeatureType; {CONST}VAR iSelector: ATSUFontFeatureSelector): OSStatus; C;

{
 *  ATSUGetFontFeature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontFeature(iStyle: ATSUStyle; iFeatureIndex: ItemCount; VAR oFeatureType: ATSUFontFeatureType; VAR oFeatureSelector: ATSUFontFeatureSelector): OSStatus; C;

{
 *  ATSUGetAllFontFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetAllFontFeatures(iStyle: ATSUStyle; iMaximumFeatureCount: ItemCount; VAR oFeatureType: ATSUFontFeatureType; VAR oFeatureSelector: ATSUFontFeatureSelector; VAR oActualFeatureCount: ItemCount): OSStatus; C;

{
 *  ATSUClearFontFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearFontFeatures(iStyle: ATSUStyle; iFeatureCount: ItemCount; {CONST}VAR iType: ATSUFontFeatureType; {CONST}VAR iSelector: ATSUFontFeatureSelector): OSStatus; C;

{  Font variations }
{
 *  ATSUSetVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetVariations(iStyle: ATSUStyle; iVariationCount: ItemCount; {CONST}VAR iAxes: ATSUFontVariationAxis; {CONST}VAR iValue: ATSUFontVariationValue): OSStatus; C;

{
 *  ATSUGetFontVariationValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontVariationValue(iStyle: ATSUStyle; iFontVariationAxis: ATSUFontVariationAxis; VAR oFontVariationValue: ATSUFontVariationValue): OSStatus; C;

{
 *  ATSUGetAllFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetAllFontVariations(iStyle: ATSUStyle; iVariationCount: ItemCount; VAR oVariationAxes: ATSUFontVariationAxis; VAR oFontVariationValues: ATSUFontVariationValue; VAR oActualVariationCount: ItemCount): OSStatus; C;

{
 *  ATSUClearFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearFontVariations(iStyle: ATSUStyle; iAxisCount: ItemCount; {CONST}VAR iAxis: ATSUFontVariationAxis): OSStatus; C;

{  Basic text-layout functions }
{
 *  ATSUCreateTextLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCreateTextLayout(VAR oTextLayout: ATSUTextLayout): OSStatus; C;

{
 *  ATSUCreateAndCopyTextLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCreateAndCopyTextLayout(iTextLayout: ATSUTextLayout; VAR oTextLayout: ATSUTextLayout): OSStatus; C;

{
 *  ATSUCreateTextLayoutWithTextPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCreateTextLayoutWithTextPtr(iText: ConstUniCharArrayPtr; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount; iNumberOfRuns: ItemCount; {CONST}VAR iRunLengths: UniCharCount; VAR iStyles: ATSUStyle; VAR oTextLayout: ATSUTextLayout): OSStatus; C;

{
 *  ATSUCreateTextLayoutWithTextHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCreateTextLayoutWithTextHandle(iText: UniCharArrayHandle; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount; iNumberOfRuns: ItemCount; {CONST}VAR iRunLengths: UniCharCount; VAR iStyles: ATSUStyle; VAR oTextLayout: ATSUTextLayout): OSStatus; C;

{
 *  ATSUClearLayoutCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearLayoutCache(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUDisposeTextLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUDisposeTextLayout(iTextLayout: ATSUTextLayout): OSStatus; C;

{
 *  ATSUSetTextLayoutRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetTextLayoutRefCon(iTextLayout: ATSUTextLayout; iRefCon: UInt32): OSStatus; C;

{
 *  ATSUGetTextLayoutRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetTextLayoutRefCon(iTextLayout: ATSUTextLayout; VAR oRefCon: UInt32): OSStatus; C;

{  Glyph bounds retrieval  }
{
 *  ATSUGetGlyphBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetGlyphBounds(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iBoundsCharStart: UniCharArrayOffset; iBoundsCharLength: UniCharCount; iTypeOfBounds: UInt16; iMaxNumberOfBounds: ItemCount; VAR oGlyphBounds: ATSTrapezoid; VAR oActualNumberOfBounds: ItemCount): OSStatus; C;

{  Idle processing }
{
 *  ATSUIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUIdle(iTextLayout: ATSUTextLayout): OSStatus; C;

{  Text location   }
{
 *  ATSUSetTextPointerLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetTextPointerLocation(iTextLayout: ATSUTextLayout; iText: ConstUniCharArrayPtr; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount): OSStatus; C;

{
 *  ATSUSetTextHandleLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetTextHandleLocation(iTextLayout: ATSUTextLayout; iText: UniCharArrayHandle; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount): OSStatus; C;

{
 *  ATSUGetTextLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetTextLocation(iTextLayout: ATSUTextLayout; VAR oText: UNIV Ptr; VAR oTextIsStoredInHandle: BOOLEAN; VAR oOffset: UniCharArrayOffset; VAR oTextLength: UniCharCount; VAR oTextTotalLength: UniCharCount): OSStatus; C;

{  Text manipulation   }
{
 *  ATSUTextDeleted()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUTextDeleted(iTextLayout: ATSUTextLayout; iDeletedRangeStart: UniCharArrayOffset; iDeletedRangeLength: UniCharCount): OSStatus; C;

{
 *  ATSUTextInserted()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUTextInserted(iTextLayout: ATSUTextLayout; iInsertionLocation: UniCharArrayOffset; iInsertionLength: UniCharCount): OSStatus; C;

{
 *  ATSUTextMoved()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUTextMoved(iTextLayout: ATSUTextLayout; iNewLocation: ConstUniCharArrayPtr): OSStatus; C;

{  Layout controls }
{
 *  ATSUCopyLayoutControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCopyLayoutControls(iSourceTextLayout: ATSUTextLayout; iDestTextLayout: ATSUTextLayout): OSStatus; C;

{
 *  ATSUSetLayoutControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetLayoutControls(iTextLayout: ATSUTextLayout; iAttributeCount: ItemCount; {CONST}VAR iTag: ATSUAttributeTag; {CONST}VAR iValueSize: ByteCount; {CONST}VAR iValue: ATSUAttributeValuePtr): OSStatus; C;

{
 *  ATSUGetLayoutControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetLayoutControl(iTextLayout: ATSUTextLayout; iTag: ATSUAttributeTag; iExpectedValueSize: ByteCount; oValue: ATSUAttributeValuePtr; VAR oActualValueSize: ByteCount): OSStatus; C;

{
 *  ATSUGetAllLayoutControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetAllLayoutControls(iTextLayout: ATSUTextLayout; VAR oAttributeInfoArray: ATSUAttributeInfo; iTagValuePairArraySize: ItemCount; VAR oTagValuePairCount: ItemCount): OSStatus; C;

{
 *  ATSUClearLayoutControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearLayoutControls(iTextLayout: ATSUTextLayout; iTagCount: ItemCount; {CONST}VAR iTag: ATSUAttributeTag): OSStatus; C;

{  Single line layout controls }
{
 *  ATSUCopyLineControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCopyLineControls(iSourceTextLayout: ATSUTextLayout; iSourceLineStart: UniCharArrayOffset; iDestTextLayout: ATSUTextLayout; iDestLineStart: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUSetLineControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetLineControls(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iAttributeCount: ItemCount; {CONST}VAR iTag: ATSUAttributeTag; {CONST}VAR iValueSize: ByteCount; {CONST}VAR iValue: ATSUAttributeValuePtr): OSStatus; C;

{
 *  ATSUGetLineControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetLineControl(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iTag: ATSUAttributeTag; iExpectedValueSize: ByteCount; oValue: ATSUAttributeValuePtr; VAR oActualValueSize: ByteCount): OSStatus; C;

{
 *  ATSUGetAllLineControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetAllLineControls(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; VAR oAttributeInfoArray: ATSUAttributeInfo; iTagValuePairArraySize: ItemCount; VAR oTagValuePairCount: ItemCount): OSStatus; C;

{
 *  ATSUClearLineControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearLineControls(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iTagCount: ItemCount; {CONST}VAR iTag: ATSUAttributeTag): OSStatus; C;

{  Style run processing    }
{
 *  ATSUSetRunStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetRunStyle(iTextLayout: ATSUTextLayout; iStyle: ATSUStyle; iRunStart: UniCharArrayOffset; iRunLength: UniCharCount): OSStatus; C;

{
 *  ATSUGetRunStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetRunStyle(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; VAR oStyle: ATSUStyle; VAR oRunStart: UniCharArrayOffset; VAR oRunLength: UniCharCount): OSStatus; C;

{
 *  ATSUGetContinuousAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetContinuousAttributes(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; iLength: UniCharCount; oStyle: ATSUStyle): OSStatus; C;

{  Drawing and measuring   }
{
 *  ATSUDrawText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUDrawText(iTextLayout: ATSUTextLayout; iLineOffset: UniCharArrayOffset; iLineLength: UniCharCount; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement): OSStatus; C;

{
 *  ATSUMeasureText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUMeasureText(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iLineLength: UniCharCount; VAR oTextBefore: ATSUTextMeasurement; VAR oTextAfter: ATSUTextMeasurement; VAR oAscent: ATSUTextMeasurement; VAR oDescent: ATSUTextMeasurement): OSStatus; C;

{
 *  ATSUMeasureTextImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUMeasureTextImage(iTextLayout: ATSUTextLayout; iLineOffset: UniCharArrayOffset; iLineLength: UniCharCount; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement; VAR oTextImageRect: Rect): OSStatus; C;

{  Highlighting    }
{
 *  ATSUHighlightText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUHighlightText(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iHighlightStart: UniCharArrayOffset; iHighlightLength: UniCharCount): OSStatus; C;

{
 *  ATSUUnhighlightText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUUnhighlightText(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iHighlightStart: UniCharArrayOffset; iHighlightLength: UniCharCount): OSStatus; C;

{
 *  ATSUGetTextHighlight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetTextHighlight(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iHighlightStart: UniCharArrayOffset; iHighlightLength: UniCharCount; oHighlightRegion: RgnHandle): OSStatus; C;

{  Hit-testing }
{
 *  ATSUPositionToOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUPositionToOffset(iTextLayout: ATSUTextLayout; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement; VAR ioPrimaryOffset: UniCharArrayOffset; VAR oIsLeading: BOOLEAN; VAR oSecondaryOffset: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUOffsetToPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUOffsetToPosition(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; iIsLeading: BOOLEAN; VAR oMainCaret: ATSUCaret; VAR oSecondCaret: ATSUCaret; VAR oCaretIsSplit: BOOLEAN): OSStatus; C;

{
 *  ATSUPositionToCursorOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.2.2 and later
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION ATSUPositionToCursorOffset(iTextLayout: ATSUTextLayout; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement; iMovementType: ATSUCursorMovementType; VAR ioPrimaryOffset: UniCharArrayOffset; VAR oIsLeading: BOOLEAN; VAR oSecondaryOffset: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUOffsetToCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.2.2 and later
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION ATSUOffsetToCursorPosition(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; iIsLeading: BOOLEAN; iMovementType: ATSUCursorMovementType; VAR oMainCaret: ATSUCaret; VAR oSecondCaret: ATSUCaret; VAR oCaretIsSplit: BOOLEAN): OSStatus; C;

{  Cursor movement }
{
 *  ATSUNextCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUNextCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUPreviousCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUPreviousCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;

{
 *  ATSURightwardCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSURightwardCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;

{
 *  ATSULeftwardCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSULeftwardCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;

{  Line breaking   }
{
 *  ATSUBreakLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUBreakLine(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iLineWidth: ATSUTextMeasurement; iUseAsSoftLineBreak: BOOLEAN; VAR oLineBreak: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUSetSoftLineBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetSoftLineBreak(iTextLayout: ATSUTextLayout; iLineBreak: UniCharArrayOffset): OSStatus; C;

{
 *  ATSUGetSoftLineBreaks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetSoftLineBreaks(iTextLayout: ATSUTextLayout; iRangeStart: UniCharArrayOffset; iRangeLength: UniCharCount; iMaximumBreaks: ItemCount; VAR oBreaks: UniCharArrayOffset; VAR oBreakCount: ItemCount): OSStatus; C;

{
 *  ATSUClearSoftLineBreaks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUClearSoftLineBreaks(iTextLayout: ATSUTextLayout; iRangeStart: UniCharArrayOffset; iRangeLength: UniCharCount): OSStatus; C;

{  Font matching   }
{
 *  ATSUSetFontFallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetFontFallbacks(iFontFallbacksCount: ItemCount; {CONST}VAR iFontIDs: ATSUFontID; iFontFallbackMethod: ATSUFontFallbackMethod): OSStatus; C;

{
 *  ATSUGetFontFallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontFallbacks(iMaxFontFallbacksCount: ItemCount; VAR oFontIDs: ATSUFontID; VAR oFontFallbackMethod: ATSUFontFallbackMethod; VAR oActualFallbacksCount: ItemCount): OSStatus; C;

{
 *  ATSUMatchFontsToText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUMatchFontsToText(iTextLayout: ATSUTextLayout; iTextStart: UniCharArrayOffset; iTextLength: UniCharCount; VAR oFontID: ATSUFontID; VAR oChangedOffset: UniCharArrayOffset; VAR oChangedLength: UniCharCount): OSStatus; C;

{
 *  ATSUSetTransientFontMatching()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetTransientFontMatching(iTextLayout: ATSUTextLayout; iTransientFontMatching: BOOLEAN): OSStatus; C;

{
 *  ATSUGetTransientFontMatching()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetTransientFontMatching(iTextLayout: ATSUTextLayout; VAR oTransientFontMatching: BOOLEAN): OSStatus; C;

{  Font ID's   }
{
 *  ATSUFontCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUFontCount(VAR oFontCount: ItemCount): OSStatus; C;

{
 *  ATSUGetFontIDs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontIDs(VAR oFontIDs: ATSUFontID; iArraySize: ItemCount; VAR oFontCount: ItemCount): OSStatus; C;

{
 *  ATSUFONDtoFontID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUFONDtoFontID(iFONDNumber: INTEGER; iFONDStyle: ByteParameter; VAR oFontID: ATSUFontID): OSStatus; C;

{
 *  ATSUFontIDtoFOND()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUFontIDtoFOND(iFontID: ATSUFontID; VAR oFONDNumber: INTEGER; VAR oFONDStyle: Style): OSStatus; C;

{  Font names  }
{
 *  ATSUCountFontNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCountFontNames(iFontID: ATSUFontID; VAR oFontNameCount: ItemCount): OSStatus; C;

{
 *  ATSUGetIndFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetIndFontName(iFontID: ATSUFontID; iFontNameIndex: ItemCount; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameCode: FontNameCode; VAR oFontNamePlatform: FontPlatformCode; VAR oFontNameScript: FontScriptCode; VAR oFontNameLanguage: FontLanguageCode): OSStatus; C;

{
 *  ATSUFindFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUFindFontName(iFontID: ATSUFontID; iFontNameCode: FontNameCode; iFontNamePlatform: FontPlatformCode; iFontNameScript: FontScriptCode; iFontNameLanguage: FontLanguageCode; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameIndex: ItemCount): OSStatus; C;

{
 *  ATSUFindFontFromName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUFindFontFromName(iName: Ptr; iNameLength: ByteCount; iFontNameCode: FontNameCode; iFontNamePlatform: FontPlatformCode; iFontNameScript: FontScriptCode; iFontNameLanguage: FontLanguageCode; VAR oFontID: ATSUFontID): OSStatus; C;

{  Font features   }
{
 *  ATSUCountFontFeatureTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCountFontFeatureTypes(iFontID: ATSUFontID; VAR oTypeCount: ItemCount): OSStatus; C;

{
 *  ATSUCountFontFeatureSelectors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCountFontFeatureSelectors(iFontID: ATSUFontID; iType: ATSUFontFeatureType; VAR oSelectorCount: ItemCount): OSStatus; C;

{
 *  ATSUGetFontFeatureTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontFeatureTypes(iFontID: ATSUFontID; iMaximumTypes: ItemCount; VAR oTypes: ATSUFontFeatureType; VAR oActualTypeCount: ItemCount): OSStatus; C;

{
 *  ATSUGetFontFeatureSelectors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontFeatureSelectors(iFontID: ATSUFontID; iType: ATSUFontFeatureType; iMaximumSelectors: ItemCount; VAR oSelectors: ATSUFontFeatureSelector; VAR oSelectorIsOnByDefault: BOOLEAN; VAR oActualSelectorCount: ItemCount; VAR oIsMutuallyExclusive: BOOLEAN): OSStatus; C;

{
 *  ATSUGetFontFeatureNameCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontFeatureNameCode(iFontID: ATSUFontID; iType: ATSUFontFeatureType; iSelector: ATSUFontFeatureSelector; VAR oNameCode: FontNameCode): OSStatus; C;

{  Font tracking value & names }
{
 *  ATSUCountFontTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCountFontTracking(iFontID: ATSUFontID; iCharacterOrientation: ATSUVerticalCharacterType; VAR oTrackingCount: ItemCount): OSStatus; C;

{
 *  ATSUGetIndFontTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetIndFontTracking(iFontID: ATSUFontID; iCharacterOrientation: ATSUVerticalCharacterType; iTrackIndex: ItemCount; VAR oFontTrackingValue: Fixed; VAR oNameCode: FontNameCode): OSStatus; C;

{  Font variations }
{
 *  ATSUCountFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCountFontVariations(iFontID: ATSUFontID; VAR oVariationCount: ItemCount): OSStatus; C;

{
 *  ATSUGetIndFontVariation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetIndFontVariation(iFontID: ATSUFontID; iVariationIndex: ItemCount; VAR oATSUFontVariationAxis: ATSUFontVariationAxis; VAR oMinimumValue: ATSUFontVariationValue; VAR oMaximumValue: ATSUFontVariationValue; VAR oDefaultValue: ATSUFontVariationValue): OSStatus; C;

{
 *  ATSUGetFontVariationNameCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontVariationNameCode(iFontID: ATSUFontID; iAxis: ATSUFontVariationAxis; VAR oNameCode: FontNameCode): OSStatus; C;

{  Font Instances  }
{
 *  ATSUCountFontInstances()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUCountFontInstances(iFontID: ATSUFontID; VAR oInstances: ItemCount): OSStatus; C;

{
 *  ATSUGetFontInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontInstance(iFontID: ATSUFontID; iFontInstanceIndex: ItemCount; iMaximumVariations: ItemCount; VAR oAxes: ATSUFontVariationAxis; VAR oValues: ATSUFontVariationValue; VAR oActualVariationCount: ItemCount): OSStatus; C;

{
 *  ATSUGetFontInstanceNameCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetFontInstanceNameCode(iFontID: ATSUFontID; iInstanceIndex: ItemCount; VAR oNameCode: FontNameCode): OSStatus; C;


{*****************************************************************************}
{ ATSUI Low-Level API                                                         }
{*****************************************************************************}
{ GlyphInfo access }
{
 *  ATSUGetGlyphInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetGlyphInfo(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iLineLength: UniCharCount; VAR ioBufferSize: ByteCount; VAR oGlyphInfoPtr: ATSUGlyphInfoArray): OSStatus; C;

{
 *  ATSUDrawGlyphInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUDrawGlyphInfo(VAR iGlyphInfoArray: ATSUGlyphInfoArray; iLocation: Float32Point): OSStatus; C;

{ Font Data Access }
{
 *  ATSUGlyphGetIdealMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGlyphGetIdealMetrics(iATSUStyle: ATSUStyle; iNumOfGlyphs: ItemCount; VAR iGlyphIDs: GlyphID; iInputOffset: ByteOffset; VAR oIdealMetrics: ATSGlyphIdealMetrics): OSStatus; C;

{
 *  ATSUGetNativeCurveType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGetNativeCurveType(iATSUStyle: ATSUStyle; VAR oCurveType: ATSCurveType): OSStatus; C;

{ Device specific routines }
{
 *  ATSUGlyphGetScreenMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGlyphGetScreenMetrics(iATSUStyle: ATSUStyle; iNumOfGlyphs: ItemCount; VAR iGlyphIDs: GlyphID; iInputOffset: ByteOffset; iForcingAntiAlias: BOOLEAN; iAntiAliasSwitch: BOOLEAN; VAR oScreenMetrics: ATSGlyphScreenMetrics): OSStatus; C;

{ ATSUGlyphGetQuadraticPaths callbacks }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATSQuadraticLineProcPtr = FUNCTION({CONST}VAR pt1: Float32Point; {CONST}VAR pt2: Float32Point; callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSQuadraticLineProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSQuadraticCurveProcPtr = FUNCTION({CONST}VAR pt1: Float32Point; {CONST}VAR controlPt: Float32Point; {CONST}VAR pt2: Float32Point; callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSQuadraticCurveProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSQuadraticNewPathProcPtr = FUNCTION(callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSQuadraticNewPathProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSQuadraticClosePathProcPtr = FUNCTION(callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSQuadraticClosePathProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ATSQuadraticLineUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSQuadraticLineUPP = ATSQuadraticLineProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATSQuadraticCurveUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSQuadraticCurveUPP = ATSQuadraticCurveProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATSQuadraticNewPathUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSQuadraticNewPathUPP = ATSQuadraticNewPathProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATSQuadraticClosePathUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSQuadraticClosePathUPP = ATSQuadraticClosePathProcPtr;
{$ENDC}	

CONST
	uppATSQuadraticLineProcInfo = $00000FF0;
	uppATSQuadraticCurveProcInfo = $00003FF0;
	uppATSQuadraticNewPathProcInfo = $000000F0;
	uppATSQuadraticClosePathProcInfo = $000000F0;
	{
	 *  NewATSQuadraticLineUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION NewATSQuadraticLineUPP(userRoutine: ATSQuadraticLineProcPtr): ATSQuadraticLineUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATSQuadraticCurveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewATSQuadraticCurveUPP(userRoutine: ATSQuadraticCurveProcPtr): ATSQuadraticCurveUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATSQuadraticNewPathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewATSQuadraticNewPathUPP(userRoutine: ATSQuadraticNewPathProcPtr): ATSQuadraticNewPathUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATSQuadraticClosePathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewATSQuadraticClosePathUPP(userRoutine: ATSQuadraticClosePathProcPtr): ATSQuadraticClosePathUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeATSQuadraticLineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSQuadraticLineUPP(userUPP: ATSQuadraticLineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATSQuadraticCurveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSQuadraticCurveUPP(userUPP: ATSQuadraticCurveUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATSQuadraticNewPathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSQuadraticNewPathUPP(userUPP: ATSQuadraticNewPathUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATSQuadraticClosePathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSQuadraticClosePathUPP(userUPP: ATSQuadraticClosePathUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeATSQuadraticLineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSQuadraticLineUPP({CONST}VAR pt1: Float32Point; {CONST}VAR pt2: Float32Point; callBackDataPtr: UNIV Ptr; userRoutine: ATSQuadraticLineUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeATSQuadraticCurveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSQuadraticCurveUPP({CONST}VAR pt1: Float32Point; {CONST}VAR controlPt: Float32Point; {CONST}VAR pt2: Float32Point; callBackDataPtr: UNIV Ptr; userRoutine: ATSQuadraticCurveUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeATSQuadraticNewPathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSQuadraticNewPathUPP(callBackDataPtr: UNIV Ptr; userRoutine: ATSQuadraticNewPathUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeATSQuadraticClosePathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSQuadraticClosePathUPP(callBackDataPtr: UNIV Ptr; userRoutine: ATSQuadraticClosePathUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  ATSUGlyphGetQuadraticPaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGlyphGetQuadraticPaths(iATSUStyle: ATSUStyle; iGlyphID: GlyphID; iNewPathProc: ATSQuadraticNewPathUPP; iLineProc: ATSQuadraticLineUPP; iCurveProc: ATSQuadraticCurveUPP; iClosePathProc: ATSQuadraticClosePathUPP; iCallbackDataPtr: UNIV Ptr; VAR oCallbackResult: OSStatus): OSStatus; C;

{ ATSUGlyphGetCubicPaths callbacks }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATSCubicMoveToProcPtr = FUNCTION({CONST}VAR pt: Float32Point; callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSCubicMoveToProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSCubicLineToProcPtr = FUNCTION({CONST}VAR pt: Float32Point; callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSCubicLineToProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSCubicCurveToProcPtr = FUNCTION({CONST}VAR pt1: Float32Point; {CONST}VAR pt2: Float32Point; {CONST}VAR pt3: Float32Point; callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSCubicCurveToProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSCubicClosePathProcPtr = FUNCTION(callBackDataPtr: UNIV Ptr): OSStatus;
{$ELSEC}
	ATSCubicClosePathProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ATSCubicMoveToUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSCubicMoveToUPP = ATSCubicMoveToProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATSCubicLineToUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSCubicLineToUPP = ATSCubicLineToProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATSCubicCurveToUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSCubicCurveToUPP = ATSCubicCurveToProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATSCubicClosePathUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATSCubicClosePathUPP = ATSCubicClosePathProcPtr;
{$ENDC}	

CONST
	uppATSCubicMoveToProcInfo = $000003F0;
	uppATSCubicLineToProcInfo = $000003F0;
	uppATSCubicCurveToProcInfo = $00003FF0;
	uppATSCubicClosePathProcInfo = $000000F0;
	{
	 *  NewATSCubicMoveToUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION NewATSCubicMoveToUPP(userRoutine: ATSCubicMoveToProcPtr): ATSCubicMoveToUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATSCubicLineToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewATSCubicLineToUPP(userRoutine: ATSCubicLineToProcPtr): ATSCubicLineToUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATSCubicCurveToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewATSCubicCurveToUPP(userRoutine: ATSCubicCurveToProcPtr): ATSCubicCurveToUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATSCubicClosePathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewATSCubicClosePathUPP(userRoutine: ATSCubicClosePathProcPtr): ATSCubicClosePathUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeATSCubicMoveToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSCubicMoveToUPP(userUPP: ATSCubicMoveToUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATSCubicLineToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSCubicLineToUPP(userUPP: ATSCubicLineToUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATSCubicCurveToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSCubicCurveToUPP(userUPP: ATSCubicCurveToUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATSCubicClosePathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeATSCubicClosePathUPP(userUPP: ATSCubicClosePathUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeATSCubicMoveToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSCubicMoveToUPP({CONST}VAR pt: Float32Point; callBackDataPtr: UNIV Ptr; userRoutine: ATSCubicMoveToUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeATSCubicLineToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSCubicLineToUPP({CONST}VAR pt: Float32Point; callBackDataPtr: UNIV Ptr; userRoutine: ATSCubicLineToUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeATSCubicCurveToUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSCubicCurveToUPP({CONST}VAR pt1: Float32Point; {CONST}VAR pt2: Float32Point; {CONST}VAR pt3: Float32Point; callBackDataPtr: UNIV Ptr; userRoutine: ATSCubicCurveToUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeATSCubicClosePathUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeATSCubicClosePathUPP(callBackDataPtr: UNIV Ptr; userRoutine: ATSCubicClosePathUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  ATSUGlyphGetCubicPaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGlyphGetCubicPaths(iATSUStyle: ATSUStyle; iGlyphID: GlyphID; iMoveToProc: ATSCubicMoveToUPP; iLineToProc: ATSCubicLineToUPP; iCurveToProc: ATSCubicCurveToUPP; iClosePathProc: ATSCubicClosePathUPP; iCallbackDataPtr: UNIV Ptr; VAR oCallbackResult: OSStatus): OSStatus; C;

{
 *  ATSUGlyphGetCurvePaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ATSUnicodeLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUGlyphGetCurvePaths(iATSUStyle: ATSUStyle; iGlyphID: GlyphID; VAR ioBufferSize: ByteCount; VAR oPaths: ATSUCurvePaths): OSStatus; C;



{***********************************************************************}
{
 *  ATSUSetHighlightingMethod()
 *  
 *  Discussion:
 *    By default ATSUI will highlight text by simply inverting the
 *    text. When a user is using gray-scale text this does not always
 *    provide the best appearance. On MacOS 9 gray-scale is available,
 *    but can be turned off by a user.  MacOS X always uses gray-scale.
 *     A better way to highlight gray-scale text is to first paint the
 *    highlight color and then redraw the text.  Begining with version
 *    2.0 (?) of ATSUI this method is available.  However,
 *    unhighlighting text when this technique is used is more
 *    complicated.  The details of exactly what the background looks
 *    like must be known to whoever unhighlights the text. When using
 *    the redraw method of highlighting ATSUI will redraw the
 *    background if it is a single color(e.g. white).  If this is the
 *    case set iMethod to kRedrawToHighlight, set
 *    iUnhighlightData.dataType to kATSUBackgroundColor and specify the
 *    background color in
 *    iUnhighlightData.unhighlightData.backgroundColor.  When these
 *    settings are supplied then ATSUI will calculate the highlight
 *    area paint it with the specified backgroundColor and then redraw
 *    the text. For more complex backgrounds (multiple colors,
 *    patterns, pictures, etc.) you need to supply a callback that
 *    ATSUI will call when the background needs to be repainted (See
 *    above RedrawBackgroundProcPtr ).  When your callback is called
 *    you should redraw the background.  If you choose to also redraw
 *    the text then you should return false as a function result. If
 *    you return true ATSUI will redraw any text that needs to be
 *    redrawn.
 *  
 *  Parameters:
 *    
 *    iTextLayout:
 *      The layout to which this highlight method should be applied.
 *    
 *    iMethod:
 *      The type of highlighting to use (inversion or redrawing) The
 *      default is inversion.  If you are happy with that technique
 *      there is no reason to call this function.
 *    
 *    iUnhighlightData:
 *      Data needed to redraw the background or NULL if inversion is
 *      being chosen.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ATSUSetHighlightingMethod(iTextLayout: ATSUTextLayout; iMethod: ATSUHighlightMethod; {CONST}VAR iUnhighlightData: ATSUUnhighlightData): OSStatus; C;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATSUnicodeIncludes}

{$ENDC} {__ATSUNICODE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
