{
 	File:		ATSUnicode.p
 
 	Contains:	Public interfaces for Apple Type Services for Unicode Imaging
 
 	Version:	Technology:	Allegro
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1997-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
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

{$IFC UNDEFINED __ATSLAYOUTTYPES__}
{$I ATSLayoutTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTLAYOUTTYPES__}
{$I SFNTLayoutTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{**********}
{	Types	}
{**********}
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

	ATSUTextLayout = ^LONGINT; { an opaque 32-bit type }
{
  	ATSUStyle is used to store a set of individual attributes, 
  	font features, and font variations.  It's typed to be 
  	an opaque structure.  
}
	ATSUStyle = ^LONGINT; { an opaque 32-bit type }
{
  	ATSUAttributeTag is used to indicate the particular type 
  	of attribute under consideration:  font, size, color, 
  	and so on.  
  	Each style run may have at most one attribute with a 
  	given ATSUAttributeTag (i.e., a style run can't have 
  	more than one font or size) but may have none.  
}
	ATSUAttributeTag					= UInt32;
{
  	ATSUAttributeValuePtr is used to provide generic access 
  	to storage of attribute values, which vary in size.
}
	ATSUAttributeValuePtr				= Ptr;
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
  	ATSUCursorMovementType currently can take three values 
  	(kATSUByCharacter, kATSUByCluster, and kATSUByWord) 
  	and is used to indicate how much to move the cursor.  
}
	ATSUCursorMovementType				= UInt16;
{
  	ATSUVerticalCharacterType currently can take two values 
  	(kATSUStronglyVertical, and kATSUStronglyHorizontal) and 
  	is used to indicate whether text is to be laid out as 
  	vertical glyphs or horizontal glyphs.  
}
	ATSUVerticalCharacterType			= UInt16;
{
  	ATSUStyleComparison is an enumeration with four values 
  	(kATUStyleUnequal, ATSUStyleContains, kATSUStyleEquals, 
  	and kATSUStyleContainedBy), and is used by ATSUCompareStyles() 
  	to indicate if the first style parameter contains as a 
  	proper subset, is equal to, or is contained by the second 
  	style parameter.
}
	ATSUStyleComparison					= UInt16;
{
  	ATSUFontFallbackMethod type defines the type of heap or memory callback
  	method ATSUI is to follow iin all its permanent memory allocations for
  	it clients.
}
	ATSUFontFallbackMethod				= UInt16;
{
  	ATSUMemoryCallbacks is a union struct that allows the ATSUI 
  	client to specify a specific heap for ATSUI use or allocation
  	callbacks of which ATSUI is to use each time ATSUI performs a
  	memory operation (alloc, grow, free).
}
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
  	ATSUHeapSpec provides allows the ATSUI client a means of
  	specifying the heap ATSUI should allocate it's dynamic memory
  	from or that ATSUI should use the memory callback provided by
  	the client.
}
	ATSUHeapSpec						= UInt16;
{
  	ATSUMemorySetting is used to store the results from a ATSUSetMemoryAlloc
  	or a ATSUGetCurrentMemorySetting call.  It can also be used to change the
  	current ATSUMemorySetting by passing it into the ATSUSetCurrentMemorySetting
  	call.
}
	ATSUMemorySetting = ^LONGINT; { an opaque 32-bit type }
{**************************************************}
{	Gestalt selectors								}
{		Move into Gestalt.i when they're stable!!!!	}
{**************************************************}

CONST
	gestaltATSUVersion			= 'uisv';
	gestaltATSUFeatures			= 'uisf';

	gestaltOriginalATSUVersion	= $00010000;					{  ATSUI version 1.0 }
	gestaltATSUUpdate1			= $00020000;					{  ATSUI version 1.1 }
	gestaltATSUUpdate2			= $00030000;					{  ATSUI version 1.2 }

	gestaltATSUTrackingFeature	= $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSUMemoryFeature	= $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSUFallbacksFeature	= $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSUGlyphBoundsFeature = $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSULineControlFeature = $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSULayoutCreateAndCopyFeature = $00000001;			{  feature introduced in ATSUI version 1.1 }
	gestaltATSULayoutCacheClearFeature = $00000001;				{  feature introduced in ATSUI version 1.1 }
	gestaltATSUTextLocatorUsageFeature = $00000002;				{  feature introduced in ATSUI version 1.2 }

{**************}
{	Error codes	}
{**************}
	kATSUInvalidTextLayoutErr	= -8790;						{ 	An attempt was made to use a ATSUTextLayout  }
																{ 	which hadn't been initialized or is otherwise  }
																{ 	in an invalid state.  }
	kATSUInvalidStyleErr		= -8791;						{ 	An attempt was made to use a ATSUStyle which   }
																{ 	hadn't been properly allocated or is otherwise   }
																{ 	in an invalid state.   }
	kATSUInvalidTextRangeErr	= -8792;						{ 	An attempt was made to extract information    }
																{ 	from or perform an operation on a ATSUTextLayout  }
																{ 	for a range of text not covered by the ATSUTextLayout.   }
	kATSUFontsMatched			= -8793;						{ 	This is not an error code but is returned by     }
																{ 	ATSUMatchFontsToText() when changes need to     }
																{ 	be made to the fonts associated with the text.   }
	kATSUFontsNotMatched		= -8794;						{ 	This value is returned by ATSUMatchFontsToText()     }
																{ 	when the text contains Unicode characters which     }
																{ 	cannot be represented by any installed font.   }
	kATSUNoCorrespondingFontErr	= -8795;						{ 	This value is retrned by font ID conversion  }
																{ 	routines ATSUFONDtoFontID() and ATSUFontIDtoFOND()  }
																{ 	to indicate that the input font ID is valid but  }
																{ 	there is no conversion possible.  For example,  }
																{ 	data-fork fonts can only be used with ATSUI not  }
																{ 	the FontManager, and so converting an ATSUIFontID  }
																{ 	for such a font will fail.    }
	kATSUInvalidFontErr			= -8796;						{ 	Used when an attempt was made to use an invalid font ID. }
	kATSUInvalidAttributeValueErr = -8797;						{ 	Used when an attempt was made to use an attribute with  }
																{ 	a bad or undefined value.   }
	kATSUInvalidAttributeSizeErr = -8798;						{ 	Used when an attempt was made to use an attribute with a  }
																{ 	bad size.   }
	kATSUInvalidAttributeTagErr	= -8799;						{ 	Used when an attempt was made to use a tag value that }
																{ 	was not appropriate for the function call it was used.   }
	kATSUInvalidCacheErr		= -8800;						{ 	Used when an attempt was made to read in style data  }
																{ 	from an invalid cache.  Either the format of the  }
																{ 	cached data doesn't match that used by Apple Type  }
																{ 	Services for Unicode™ Imaging, or the cached data  }
																{ 	is corrupt.   }
	kATSUNotSetErr				= -8801;						{ 	Used when the client attempts to retrieve an attribute,  }
																{ 	font feature, or font variation from a style when it  }
																{ 	hadn't been set.  In such a case, the default value will }
																{ 	be returned for the attribute's value. }
	kATSUNoStyleRunsAssignedErr	= -8802;						{ 	Used when an attempt was made to measure, highlight or draw }
																{ 	a ATSUTextLayout object that has no styleRuns associated with it. }
	kATSUQuickDrawTextErr		= -8803;						{ 	Used when QuickDraw Text encounters an error rendering or measuring }
																{ 	a line of ATSUI text. }
	kATSULowLevelErr			= -8804;						{ 	Used when an error was encountered within the low level ATS  }
																{ 	mechanism performing an operation requested by ATSUI. }
	kATSUNoFontCmapAvailableErr	= -8805;						{ 	Used when no CMAP table can be accessed or synthesized for the  }
																{ 	font passed into a SetAttributes Font call. }
	kATSUNoFontScalerAvailableErr = -8806;						{ 	Used when no font scaler is available for the font passed }
																{ 	into a SetAttributes Font call. }
	kATSUCoordinateOverflowErr	= -8807;						{ 	Used to indicate the coordinates provided to an ATSUI routine caused }
																{ 	a coordinate overflow (i.e. > 32K). }
	kATSULineBreakInWord		= -8808;						{ 	This is not an error code but is returned by ATSUBreakLine to  }
																{ 	indicate that the returned offset is within a word since there was }
																{ 	only less than one word that could fit the requested width. }
	kATSULastErr				= -8809;						{ 	The last ATSUI error code. }

{*****************************************************************************}
{	ATSUI Attribute tags:  Apple reserves values 0 to 65,535 (0 to 0x0000FFFF) }
{	ATSUI clients may create their own tags with any other value               }
{*****************************************************************************}
{	Line Control Attribute Tags }
	kATSULineWidthTag			= 1;							{ 	Type:			ATSUTextMeasurement }
																{ 	Default value:	0 }
	kATSULineRotationTag		= 2;							{ 	Type:			Fixed (fixed value in degrees in right-handed coordinate system) }
																{ 	Default value:	0 }
	kATSULineDirectionTag		= 3;							{ 	Type:			Boolean; values 0 or 1 (see below for value identities) }
																{ 	Default value:	GetSysDirection() ? kATSURightToLeftBaseDirection : kATSULeftToRightBaseDirection }
	kATSULineJustificationFactorTag = 4;						{ 	Type:			Fract between 0 and 1 }
																{ 	Default value:	kATSUNoJustification }
	kATSULineFlushFactorTag		= 5;							{ 	Type:			Fract between 0 and 1  }
																{ 	Default value:	kATSUStartAlignment }
	kATSULineBaselineValuesTag	= 6;							{ 	Type:			BslnBaselineRecord }
																{ 	Default value:	All zeros.  Calculated from other style attributes (e.g., font and point size) }
	kATSULineLayoutOptionsTag	= 7;							{ 	Type:			UInt32 }
																{ 	Default value:	kATSLineNoLayoutOptions - other options listed in ATSLayoutTypes.h }
	kATSULineAscentTag			= 8;							{ 	Type:			ATSUTextMeasurement }
																{ 	Default value:	kATSUseLineHeight }
	kATSULineDescentTag			= 9;							{ 	Type:			ATSUTextMeasurement }
																{ 	Default value:	kATSUseLineHeight }
	kATSULineLanguageTag		= 10;							{ 	Type:			RegionCode - region values listed in script.h interface file }
																{ 	Default value:	kTextRegionDontCare }
	kATSULineTextLocatorTag		= 11;							{ 	Type:			TextBreakLocatorRef }
																{ 	Default value:	NULL - set Region derived locator or the default Text Utilities locator }
	kATSUMaxLineTag				= 12;							{ 	This is just for convenience - the upper limit of the ATSUTextLayout attribute tags  }

{	Run Style Attribute Tags }
																{  QuickDraw compatibility tags  }
	kATSUQDBoldfaceTag			= 256;							{ 	Type:			Boolean	 }
																{ 	Default value:	false }
	kATSUQDItalicTag			= 257;							{ 	Type:			Boolean		 }
																{ 	Default value:	false }
	kATSUQDUnderlineTag			= 258;							{ 	Type:			Boolean	 }
																{ 	Default value:	false }
	kATSUQDCondensedTag			= 259;							{ 	Type:			Boolean	 }
																{ 	Default value:	false }
	kATSUQDExtendedTag			= 260;							{ 	Type:			Boolean	 }
																{ 	Default value:	false }
																{  Common run tags  }
	kATSUFontTag				= 261;							{ 	Type:			ATSUFontID	 }
																{ 	Default value:	GetScriptVariable( smSystemScript, smScriptAppFond ) }
	kATSUSizeTag				= 262;							{ 	Type:			Fixed	 }
																{ 	Default value:	GetScriptVariable( smSystemScript, smScriptAppFondSize )	 }
	kATSUColorTag				= 263;							{ 	Type:			RGBColor	 }
																{ 	Default value:	(0, 0, 0) }
																{ 	Less common run tags  }
	kATSULanguageTag			= 264;							{ 	Type:			RegionCode - region values listed in script.h interface file }
																{ 	Default value:	GetScriptManagerVariable( smRegionCode ) }
	kATSUVerticalCharacterTag	= 265;							{ 	Type:			ATSUVerticalCharacterType	 }
																{ 	Default value:	kATSUStronglyHorizontal }
	kATSUImposeWidthTag			= 266;							{ 	Type:			ATSUTextMeasurement }
																{ 	Default value:	all glyphs use their own font defined advance widths }
	kATSUBeforeWithStreamShiftTag = 267;						{ 	Type:			Fixed }
																{ 	Default value:	0 }
	kATSUAfterWithStreamShiftTag = 268;							{ 	Type:			Fixed }
																{ 	Default value:	0 }
	kATSUCrossStreamShiftTag	= 269;							{ 	Type:			Fixed }
																{ 	Default value:	0 }
	kATSUTrackingTag			= 270;							{ 	Type:			Fixed }
																{ 	Default value:	kATSNoTracking }
	kATSUHangingInhibitFactorTag = 271;							{ 	Type:			Fract between 0 and 1 }
																{ 	Default value:	0 }
	kATSUKerningInhibitFactorTag = 272;							{ 	Type:			Fract between 0 and 1 }
																{ 	Default value:	0 }
	kATSUDecompositionFactorTag	= 273;							{ 	Type:			Fixed (-1.0 -> 1.0) }
																{ 	Default value:	0 }
	kATSUBaselineClassTag		= 274;							{ 	Type:			BslnBaselineClass  (see SFNTLayoutTypes.h) }
																{ 	Default value:	kBSLNRomanBaseline - set to kBSLNNoBaselineOverride to use intrinsic baselines }
	kATSUPriorityJustOverrideTag = 275;							{ 	Type:			ATSJustPriorityWidthDeltaOverrides (see ATSLayoutTypes.h) }
																{ 	Default value:	all zeros }
	kATSUNoLigatureSplitTag		= 276;							{ 	Type:			Boolean }
																{ 	Default value:	false - ligatures and compound characters have divisable components. }
	kATSUNoCaretAngleTag		= 277;							{ 	Type:			Boolean }
																{ 	Default value:	false - use the character's angularity to determine its boundaries }
	kATSUSuppressCrossKerningTag = 278;							{ 	Type:			Boolean }
																{ 	Default value:	false - do not suppress automatic cross kerning (defined by font) }
	kATSUNoOpticalAlignmentTag	= 279;							{ 	Type:			Boolean }
																{ 	Default value:	false - do not suppress character's automatic optical positional alignment }
	kATSUForceHangingTag		= 280;							{ 	Type:			Boolean }
																{ 	Default value:	false - do not force the character's to hang beyond the line boundaries }
	kATSUNoSpecialJustificationTag = 281;						{ 	Type:			Boolean }
																{ 	Default value:	false - perform post-compensation justification if needed }
	kATSUStyleTextLocatorTag	= 282;							{ 	Type:			TextBreakLocatorRef }
																{ 	Default value:	NULL - region derived locator or the default Text Utilities locator }
	kATSUMaxStyleTag			= 283;							{ 	This is just for convenience - the upper limit of the ATSUStyle attribute tags  }
	kATSUMaxATSUITagValue		= 65535;						{ 	This is the maximum Apple ATSUI reserved tag value.  Client defined tags must be larger. }

{******************************}
{	Enumerations and constants	}
{******************************}
{ Cursor movement }
	kATSUByCharacter			= 0;
	kATSUByCluster				= 1;
	kATSUByWord					= 2;

{ Vertical text types }
	kATSUStronglyHorizontal		= 0;
	kATSUStronglyVertical		= 1;

{ Line direction types (used for kATSULineDirectionTag values) }
	kATSULeftToRightBaseDirection = 0;							{ 	Impose left-to-right or top-to-bottom dominant direction  }
	kATSURightToLeftBaseDirection = 1;							{ 	Impose right-to-left or bottom-to-top dominant direction  }

{ Style comparison types }
	kATSUStyleUnequal			= 0;
	kATSUStyleContains			= 1;
	kATSUStyleEquals			= 2;
	kATSUStyleContainedBy		= 3;

{ Font Fallback methods }
	kATSUDefaultFontFallbacks	= 0;
	kATSULastResortOnlyFallback	= 1;
	kATSUSequentialFallbacksPreferred = 2;
	kATSUSequentialFallbacksExclusive = 3;

{ ATSUI heap or memory allocation specifiers (of type ATSUHeapSpec) }
	kATSUUseCurrentHeap			= 0;
	kATSUUseAppHeap				= 1;
	kATSUUseSpecificHeap		= 2;
	kATSUUseCallbacks			= 3;

{ LineFlushFactor convenience defined values }
	kATSUStartAlignment			= $00000000;
	kATSUEndAlignment			= $40000000;
	kATSUCenterAlignment		= $20000000;

{ LineJustificationFactor convenience defined values }
	kATSUNoJustification		= $00000000;
	kATSUFullJustification		= $40000000;

{ Other constants	}
	kATSUInvalidFontID			= 0;


	kATSUUseLineControlWidth	= $7FFFFFFF;


	kATSUNoSelector				= $0000FFFF;


	kATSUUseGrafPortPenLoc		= $FFFFFFFF;
	kATSUClearAll				= $FFFFFFFF;


	kATSUFromTextBeginning		= $FFFFFFFF;
	kATSUToTextEnd				= $FFFFFFFF;


{**************}
{	Functions	}
{**************}

{	Clipboard support, flattened style version 0 (is is advised to not use these routines and perform your own flattening)	}
FUNCTION ATSUCopyToHandle(iStyle: ATSUStyle; oStyleHandle: Handle): OSStatus; C;
FUNCTION ATSUPasteFromHandle(iStyle: ATSUStyle; iStyleHandle: Handle): OSStatus; C;
{	Memory allocation specification functions	}
FUNCTION ATSUCreateMemorySetting(iHeapSpec: ATSUHeapSpec; VAR iMemoryCallbacks: ATSUMemoryCallbacks; VAR oMemorySetting: ATSUMemorySetting): OSStatus; C;
FUNCTION ATSUSetCurrentMemorySetting(iMemorySetting: ATSUMemorySetting): OSStatus; C;
FUNCTION ATSUGetCurrentMemorySetting: ATSUMemorySetting; C;
FUNCTION ATSUDisposeMemorySetting(iMemorySetting: ATSUMemorySetting): OSStatus; C;
{	Basic style functions	}
FUNCTION ATSUCreateStyle(VAR oStyle: ATSUStyle): OSStatus; C;
FUNCTION ATSUCreateAndCopyStyle(iStyle: ATSUStyle; VAR oStyle: ATSUStyle): OSStatus; C;
FUNCTION ATSUDisposeStyle(iStyle: ATSUStyle): OSStatus; C;
FUNCTION ATSUSetStyleRefCon(iStyle: ATSUStyle; iRefCon: UInt32): OSStatus; C;
FUNCTION ATSUGetStyleRefCon(iStyle: ATSUStyle; VAR oRefCon: UInt32): OSStatus; C;
{	Style comparison 		}
FUNCTION ATSUCompareStyles(iFirstStyle: ATSUStyle; iSecondStyle: ATSUStyle; VAR oComparison: ATSUStyleComparison): OSStatus; C;
{	Attribute manipulations	}
FUNCTION ATSUCopyAttributes(iSourceStyle: ATSUStyle; iDestinationStyle: ATSUStyle): OSStatus; C;
FUNCTION ATSUOverwriteAttributes(iSourceStyle: ATSUStyle; iDestinationStyle: ATSUStyle): OSStatus; C;
FUNCTION ATSUUnderwriteAttributes(iSourceStyle: ATSUStyle; iDestinationStyle: ATSUStyle): OSStatus; C;
{	Empty styles	}
FUNCTION ATSUClearStyle(iStyle: ATSUStyle): OSStatus; C;
FUNCTION ATSUStyleIsEmpty(iStyle: ATSUStyle; VAR oIsClear: BOOLEAN): OSStatus; C;
{	Get and set attributes }
FUNCTION ATSUCalculateBaselineDeltas(iStyle: ATSUStyle; iBaselineClass: BslnBaselineClass; VAR oBaselineDeltas: BslnBaselineRecord): OSStatus; C;
FUNCTION ATSUSetAttributes(iStyle: ATSUStyle; iAttributeCount: ItemCount; VAR iTag: ATSUAttributeTag; VAR iValueSize: ByteCount; VAR iValue: ATSUAttributeValuePtr): OSStatus; C;
FUNCTION ATSUGetAttribute(iStyle: ATSUStyle; iTag: ATSUAttributeTag; iExpectedValueSize: ByteCount; oValue: ATSUAttributeValuePtr; VAR oActualValueSize: ByteCount): OSStatus; C;
FUNCTION ATSUGetAllAttributes(iStyle: ATSUStyle; VAR oAttributeInfoArray: ATSUAttributeInfo; iTagValuePairArraySize: ItemCount; VAR oTagValuePairCount: ItemCount): OSStatus; C;
FUNCTION ATSUClearAttributes(iStyle: ATSUStyle; iTagCount: ItemCount; VAR iTag: ATSUAttributeTag): OSStatus; C;
{	Font features	}
FUNCTION ATSUSetFontFeatures(iStyle: ATSUStyle; iFeatureCount: ItemCount; VAR iType: ATSUFontFeatureType; VAR iSelector: ATSUFontFeatureSelector): OSStatus; C;
FUNCTION ATSUGetFontFeature(iStyle: ATSUStyle; iFeatureIndex: ItemCount; VAR oFeatureType: ATSUFontFeatureType; VAR oFeatureSelector: ATSUFontFeatureSelector): OSStatus; C;
FUNCTION ATSUGetAllFontFeatures(iStyle: ATSUStyle; iMaximumFeatureCount: ItemCount; VAR oFeatureType: ATSUFontFeatureType; VAR oFeatureSelector: ATSUFontFeatureSelector; VAR oActualFeatureCount: ItemCount): OSStatus; C;
FUNCTION ATSUClearFontFeatures(iStyle: ATSUStyle; iFeatureCount: ItemCount; VAR iType: ATSUFontFeatureType; VAR iSelector: ATSUFontFeatureSelector): OSStatus; C;
{	Font variations	}
FUNCTION ATSUSetVariations(iStyle: ATSUStyle; iVariationCount: ItemCount; VAR iAxes: ATSUFontVariationAxis; VAR iValue: ATSUFontVariationValue): OSStatus; C;
FUNCTION ATSUGetFontVariationValue(iStyle: ATSUStyle; iFontVariationAxis: ATSUFontVariationAxis; VAR oFontVariationValue: ATSUFontVariationValue): OSStatus; C;
FUNCTION ATSUGetAllFontVariations(iStyle: ATSUStyle; iVariationCount: ItemCount; VAR oVariationAxes: ATSUFontVariationAxis; VAR oFontVariationValues: ATSUFontVariationValue; VAR oActualVariationCount: ItemCount): OSStatus; C;
FUNCTION ATSUClearFontVariations(iStyle: ATSUStyle; iAxisCount: ItemCount; VAR iAxis: ATSUFontVariationAxis): OSStatus; C;
{	Basic text-layout functions	}
FUNCTION ATSUCreateTextLayout(VAR oTextLayout: ATSUTextLayout): OSStatus; C;
FUNCTION ATSUCreateAndCopyTextLayout(iTextLayout: ATSUTextLayout; VAR oTextLayout: ATSUTextLayout): OSStatus; C;
FUNCTION ATSUCreateTextLayoutWithTextPtr(iText: ConstUniCharArrayPtr; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount; iNumberOfRuns: ItemCount; VAR iRunLengths: UniCharCount; VAR iStyles: ATSUStyle; VAR oTextLayout: ATSUTextLayout): OSStatus; C;
FUNCTION ATSUCreateTextLayoutWithTextHandle(iText: UniCharArrayHandle; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount; iNumberOfRuns: ItemCount; VAR iRunLengths: UniCharCount; VAR iStyles: ATSUStyle; VAR oTextLayout: ATSUTextLayout): OSStatus; C;
FUNCTION ATSUClearLayoutCache(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSUDisposeTextLayout(iTextLayout: ATSUTextLayout): OSStatus; C;
FUNCTION ATSUSetTextLayoutRefCon(iTextLayout: ATSUTextLayout; iRefCon: UInt32): OSStatus; C;
FUNCTION ATSUGetTextLayoutRefCon(iTextLayout: ATSUTextLayout; VAR oRefCon: UInt32): OSStatus; C;
{	Glyph bounds retrieval	}
FUNCTION ATSUGetGlyphBounds(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iBoundsCharStart: UniCharArrayOffset; iBoundsCharLength: UniCharCount; iTypeOfBounds: UInt16; iMaxNumberOfBounds: ItemCount; VAR oGlyphBounds: ATSTrapezoid; VAR oActualNumberOfBounds: ItemCount): OSStatus; C;
{	Idle processing	}
FUNCTION ATSUIdle(iTextLayout: ATSUTextLayout): OSStatus; C;
{	Text location	}
FUNCTION ATSUSetTextPointerLocation(iTextLayout: ATSUTextLayout; iText: ConstUniCharArrayPtr; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount): OSStatus; C;
FUNCTION ATSUSetTextHandleLocation(iTextLayout: ATSUTextLayout; iText: UniCharArrayHandle; iTextOffset: UniCharArrayOffset; iTextLength: UniCharCount; iTextTotalLength: UniCharCount): OSStatus; C;
FUNCTION ATSUGetTextLocation(iTextLayout: ATSUTextLayout; VAR oText: UNIV Ptr; VAR oTextIsStoredInHandle: BOOLEAN; VAR oOffset: UniCharArrayOffset; VAR oTextLength: UniCharCount; VAR oTextTotalLength: UniCharCount): OSStatus; C;
{	Text manipulation	}
FUNCTION ATSUTextDeleted(iTextLayout: ATSUTextLayout; iDeletedRangeStart: UniCharArrayOffset; iDeletedRangeLength: UniCharCount): OSStatus; C;
FUNCTION ATSUTextInserted(iTextLayout: ATSUTextLayout; iInsertionLocation: UniCharArrayOffset; iInsertionLength: UniCharCount): OSStatus; C;
FUNCTION ATSUTextMoved(iTextLayout: ATSUTextLayout; iNewLocation: ConstUniCharArrayPtr): OSStatus; C;
{	Layout controls	}
FUNCTION ATSUCopyLayoutControls(iSourceTextLayout: ATSUTextLayout; iDestTextLayout: ATSUTextLayout): OSStatus; C;
FUNCTION ATSUSetLayoutControls(iTextLayout: ATSUTextLayout; iAttributeCount: ItemCount; VAR iTag: ATSUAttributeTag; VAR iValueSize: ByteCount; VAR iValue: ATSUAttributeValuePtr): OSStatus; C;
FUNCTION ATSUGetLayoutControl(iTextLayout: ATSUTextLayout; iTag: ATSUAttributeTag; iExpectedValueSize: ByteCount; oValue: ATSUAttributeValuePtr; VAR oActualValueSize: ByteCount): OSStatus; C;
FUNCTION ATSUGetAllLayoutControls(iTextLayout: ATSUTextLayout; VAR oAttributeInfoArray: ATSUAttributeInfo; iTagValuePairArraySize: ItemCount; VAR oTagValuePairCount: ItemCount): OSStatus; C;
FUNCTION ATSUClearLayoutControls(iTextLayout: ATSUTextLayout; iTagCount: ItemCount; VAR iTag: ATSUAttributeTag): OSStatus; C;
{	Single line layout controls	}
FUNCTION ATSUCopyLineControls(iSourceTextLayout: ATSUTextLayout; iSourceLineStart: UniCharArrayOffset; iDestTextLayout: ATSUTextLayout; iDestLineStart: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSUSetLineControls(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iAttributeCount: ItemCount; VAR iTag: ATSUAttributeTag; VAR iValueSize: ByteCount; VAR iValue: ATSUAttributeValuePtr): OSStatus; C;
FUNCTION ATSUGetLineControl(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iTag: ATSUAttributeTag; iExpectedValueSize: ByteCount; oValue: ATSUAttributeValuePtr; VAR oActualValueSize: ByteCount): OSStatus; C;
FUNCTION ATSUGetAllLineControls(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; VAR oAttributeInfoArray: ATSUAttributeInfo; iTagValuePairArraySize: ItemCount; VAR oTagValuePairCount: ItemCount): OSStatus; C;
FUNCTION ATSUClearLineControls(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iTagCount: ItemCount; VAR iTag: ATSUAttributeTag): OSStatus; C;
{	Style run processing	}
FUNCTION ATSUSetRunStyle(iTextLayout: ATSUTextLayout; iStyle: ATSUStyle; iRunStart: UniCharArrayOffset; iRunLength: UniCharCount): OSStatus; C;
FUNCTION ATSUGetRunStyle(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; VAR oStyle: ATSUStyle; VAR oRunStart: UniCharArrayOffset; VAR oRunLength: UniCharCount): OSStatus; C;
FUNCTION ATSUGetContinuousAttributes(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; iLength: UniCharCount; oStyle: ATSUStyle): OSStatus; C;
{	Drawing and measuring	}
FUNCTION ATSUDrawText(iTextLayout: ATSUTextLayout; iLineOffset: UniCharArrayOffset; iLineLength: UniCharCount; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement): OSStatus; C;
FUNCTION ATSUMeasureText(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iLineLength: UniCharCount; VAR oTextBefore: ATSUTextMeasurement; VAR oTextAfter: ATSUTextMeasurement; VAR oAscent: ATSUTextMeasurement; VAR oDescent: ATSUTextMeasurement): OSStatus; C;
FUNCTION ATSUMeasureTextImage(iTextLayout: ATSUTextLayout; iLineOffset: UniCharArrayOffset; iLineLength: UniCharCount; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement; VAR oTextImageRect: Rect): OSStatus; C;
{	Highlighting	}
FUNCTION ATSUHighlightText(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iHighlightStart: UniCharArrayOffset; iHighlightLength: UniCharCount): OSStatus; C;
FUNCTION ATSUUnhighlightText(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iHighlightStart: UniCharArrayOffset; iHighlightLength: UniCharCount): OSStatus; C;
FUNCTION ATSUGetTextHighlight(iTextLayout: ATSUTextLayout; iTextBasePointX: ATSUTextMeasurement; iTextBasePointY: ATSUTextMeasurement; iHighlightStart: UniCharArrayOffset; iHighlightLength: UniCharCount; oHighlightRegion: RgnHandle): OSStatus; C;
{	Hit-testing	}
FUNCTION ATSUPositionToOffset(iTextLayout: ATSUTextLayout; iLocationX: ATSUTextMeasurement; iLocationY: ATSUTextMeasurement; VAR ioPrimaryOffset: UniCharArrayOffset; VAR oIsLeading: BOOLEAN; VAR oSecondaryOffset: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSUOffsetToPosition(iTextLayout: ATSUTextLayout; iOffset: UniCharArrayOffset; iIsLeading: BOOLEAN; VAR oMainCaret: ATSUCaret; VAR oSecondCaret: ATSUCaret; VAR oCaretIsSplit: BOOLEAN): OSStatus; C;
{	Cursor movement	}
FUNCTION ATSUNextCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSUPreviousCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSURightwardCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSULeftwardCursorPosition(iTextLayout: ATSUTextLayout; iOldOffset: UniCharArrayOffset; iMovementType: ATSUCursorMovementType; VAR oNewOffset: UniCharArrayOffset): OSStatus; C;
{	Line breaking	}
FUNCTION ATSUBreakLine(iTextLayout: ATSUTextLayout; iLineStart: UniCharArrayOffset; iLineWidth: ATSUTextMeasurement; iUseAsSoftLineBreak: BOOLEAN; VAR oLineBreak: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSUSetSoftLineBreak(iTextLayout: ATSUTextLayout; iLineBreak: UniCharArrayOffset): OSStatus; C;
FUNCTION ATSUGetSoftLineBreaks(iTextLayout: ATSUTextLayout; iRangeStart: UniCharArrayOffset; iRangeLength: UniCharCount; iMaximumBreaks: ItemCount; VAR oBreaks: UniCharArrayOffset; VAR oBreakCount: ItemCount): OSStatus; C;
FUNCTION ATSUClearSoftLineBreaks(iTextLayout: ATSUTextLayout; iRangeStart: UniCharArrayOffset; iRangeLength: UniCharCount): OSStatus; C;
{	Font matching	}
FUNCTION ATSUSetFontFallbacks(iFontFallbacksCount: ItemCount; VAR iFontIDs: ATSUFontID; iFontFallbackMethod: ATSUFontFallbackMethod): OSStatus; C;
FUNCTION ATSUGetFontFallbacks(iMaxFontFallbacksCount: ItemCount; VAR oFontIDs: ATSUFontID; VAR oFontFallbackMethod: ATSUFontFallbackMethod; VAR oActualFallbacksCount: ItemCount): OSStatus; C;
FUNCTION ATSUMatchFontsToText(iTextLayout: ATSUTextLayout; iTextStart: UniCharArrayOffset; iTextLength: UniCharCount; VAR oFontID: ATSUFontID; VAR oChangedOffset: UniCharArrayOffset; VAR oChangedLength: UniCharCount): OSStatus; C;
FUNCTION ATSUSetTransientFontMatching(iTextLayout: ATSUTextLayout; iTransientFontMatching: BOOLEAN): OSStatus; C;
FUNCTION ATSUGetTransientFontMatching(iTextLayout: ATSUTextLayout; VAR oTransientFontMatching: BOOLEAN): OSStatus; C;
{	Font ID's	}
FUNCTION ATSUFontCount(VAR oFontCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetFontIDs(VAR oFontIDs: ATSUFontID; iArraySize: ItemCount; VAR oFontCount: ItemCount): OSStatus; C;
FUNCTION ATSUFONDtoFontID(iFONDNumber: INTEGER; iFONDStyle: ByteParameter; VAR oFontID: ATSUFontID): OSStatus; C;
FUNCTION ATSUFontIDtoFOND(iFontID: ATSUFontID; VAR oFONDNumber: INTEGER; VAR oFONDStyle: Style): OSStatus; C;
{	Font names	}
FUNCTION ATSUCountFontNames(iFontID: ATSUFontID; VAR oFontNameCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetIndFontName(iFontID: ATSUFontID; iFontNameIndex: ItemCount; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameCode: FontNameCode; VAR oFontNamePlatform: FontPlatformCode; VAR oFontNameScript: FontScriptCode; VAR oFontNameLanguage: FontLanguageCode): OSStatus; C;
FUNCTION ATSUFindFontName(iFontID: ATSUFontID; iFontNameCode: FontNameCode; iFontNamePlatform: FontPlatformCode; iFontNameScript: FontScriptCode; iFontNameLanguage: FontLanguageCode; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameIndex: ItemCount): OSStatus; C;
FUNCTION ATSUFindFontFromName(iName: Ptr; iNameLength: ByteCount; iFontNameCode: FontNameCode; iFontNamePlatform: FontPlatformCode; iFontNameScript: FontScriptCode; iFontNameLanguage: FontLanguageCode; VAR oFontID: ATSUFontID): OSStatus; C;
{	Font features	}
FUNCTION ATSUCountFontFeatureTypes(iFontID: ATSUFontID; VAR oTypeCount: ItemCount): OSStatus; C;
FUNCTION ATSUCountFontFeatureSelectors(iFontID: ATSUFontID; iType: ATSUFontFeatureType; VAR oSelectorCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetFontFeatureTypes(iFontID: ATSUFontID; iMaximumTypes: ItemCount; VAR oTypes: ATSUFontFeatureType; VAR oActualTypeCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetFontFeatureSelectors(iFontID: ATSUFontID; iType: ATSUFontFeatureType; iMaximumSelectors: ItemCount; VAR oSelectors: ATSUFontFeatureSelector; VAR oSelectorIsOnByDefault: BOOLEAN; VAR oActualSelectorCount: ItemCount; VAR oIsMutuallyExclusive: BOOLEAN): OSStatus; C;
FUNCTION ATSUGetFontFeatureNameCode(iFontID: ATSUFontID; iType: ATSUFontFeatureType; iSelector: ATSUFontFeatureSelector; VAR oNameCode: FontNameCode): OSStatus; C;
{	Font tracking value & names	}
FUNCTION ATSUCountFontTracking(iFontID: ATSUFontID; iCharacterOrientation: ATSUVerticalCharacterType; VAR oTrackingCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetIndFontTracking(iFontID: ATSUFontID; iCharacterOrientation: ATSUVerticalCharacterType; iTrackIndex: ItemCount; VAR oFontTrackingValue: Fixed; VAR oNameCode: FontNameCode): OSStatus; C;
{	Font variations	}
FUNCTION ATSUCountFontVariations(iFontID: ATSUFontID; VAR oVariationCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetIndFontVariation(iFontID: ATSUFontID; iVariationIndex: ItemCount; VAR oATSUFontVariationAxis: ATSUFontVariationAxis; VAR oMinimumValue: ATSUFontVariationValue; VAR oMaximumValue: ATSUFontVariationValue; VAR oDefaultValue: ATSUFontVariationValue): OSStatus; C;
FUNCTION ATSUGetFontVariationNameCode(iFontID: ATSUFontID; iAxis: ATSUFontVariationAxis; VAR oNameCode: FontNameCode): OSStatus; C;
{	Font Instances	}
FUNCTION ATSUCountFontInstances(iFontID: ATSUFontID; VAR oInstances: ItemCount): OSStatus; C;
FUNCTION ATSUGetFontInstance(iFontID: ATSUFontID; iFontInstanceIndex: ItemCount; iMaximumVariations: ItemCount; VAR oAxes: ATSUFontVariationAxis; VAR oValues: ATSUFontVariationValue; VAR oActualVariationCount: ItemCount): OSStatus; C;
FUNCTION ATSUGetFontInstanceNameCode(iFontID: ATSUFontID; iInstanceIndex: ItemCount; VAR oNameCode: FontNameCode): OSStatus; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATSUnicodeIncludes}

{$ENDC} {__ATSUNICODE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}