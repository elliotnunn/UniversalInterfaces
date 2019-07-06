/*
 	File:		ATSUnicode.h
 
 	Contains:	Public interfaces for Apple Type Services for Unicode Imaging
 
 	Version:	Technology:	Allegro
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1997-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __ATSUNICODE__
#define __ATSUNICODE__

#ifndef __ATSLAYOUTTYPES__
#include <ATSLayoutTypes.h>
#endif
#ifndef __SFNTLAYOUTTYPES__
#include <SFNTLayoutTypes.h>
#endif

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __TEXTCOMMON__
#include <TextCommon.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

/************/
/*	Types	*/
/************/
typedef UniCharArrayPtr *				UniCharArrayHandle;
/*
  	UniCharArrayHandle is a handle type to correspond to 
  	UniCharArrayPtr, defined in Unicode.h.  It refers 
  	to a handle, interpreted as a pointer to an array 
  	of UniChar's (UInt16's).
*/
typedef UInt32 							UniCharArrayOffset;
/*
  	UniCharArrayOffset is used to indicate an offset 
  	into an array of UniChar's (UInt16's).  
*/
typedef Fixed 							ATSUTextMeasurement;
/*
  	ATSUTextMeasurement is exactly what its name implies:  
  	a measurement of the size in some direction of text:  
  	height, width, ascent, descent, and so on.  
*/
typedef UInt32 							ATSUFontID;
/*
  	ATSUFontID indicates a particular font family and face.  
  	ATSUFontID's are not guaranteed to remain constant across 
  	reboots.  Clients should use the font's unique name to 
  	get a font token to store in documents which is 
  	guaranteed to remain constant across reboots. 
*/
typedef UInt16 							ATSUFontFeatureType;
typedef UInt16 							ATSUFontFeatureSelector;
/*
  	ATSUFontFeatureType and ATSUFontFeatureSelector are used 
  	to identify font features.  
*/
typedef FourCharCode 					ATSUFontVariationAxis;
typedef Fixed 							ATSUFontVariationValue;
/*
  	ATSUFontVariationAxis and ATSUFontVariationValue are used 
  	in connection with font variations.  
*/
typedef struct OpaqueATSUTextLayout* 	ATSUTextLayout;
/*
  	ATSUTextLayout is used to store the attribute information 
  	associated with a contiguous block of UniChar's (UInt16's) 
  	in memory.  It's typed to be an opaque structure.  
*/
typedef struct OpaqueATSUStyle* 		ATSUStyle;
/*
  	ATSUStyle is used to store a set of individual attributes, 
  	font features, and font variations.  It's typed to be 
  	an opaque structure.  
*/
typedef UInt32 							ATSUAttributeTag;
/*
  	ATSUAttributeTag is used to indicate the particular type 
  	of attribute under consideration:  font, size, color, 
  	and so on.  
  	Each style run may have at most one attribute with a 
  	given ATSUAttributeTag (i.e., a style run can't have 
  	more than one font or size) but may have none.  
*/
typedef void *							ATSUAttributeValuePtr;
/*
  	ATSUAttributeValuePtr is used to provide generic access 
  	to storage of attribute values, which vary in size.
*/

struct ATSUAttributeInfo {
	ATSUAttributeTag 				fTag;
	ByteCount 						fValueSize;
};
typedef struct ATSUAttributeInfo		ATSUAttributeInfo;
/*
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
*/

struct ATSUCaret {
	Fixed 							fX;
	Fixed 							fY;
	Fixed 							fDeltaX;
	Fixed 							fDeltaY;
};
typedef struct ATSUCaret				ATSUCaret;
/*
  	ATSUCaret contains the complete information needed to render a
  	caret.  fX and fY is the position of one of the caret's ends
  	relative to the origin position of the line the caret belongs.
  	fDeltaX and fDeltaY is the position of the caret's other end.
  	Hence, to draw a caret, simply call MoveTo(fX, fY) followed by
  	LineTo(fDeltaX, fDeltaY) or equivalent.  The ATSUCaret will
  	contain the positions needed to draw carets on angled lines
  	and reflect angled carets and leading/trailing split caret
  	appearances.
*/

typedef int 							ATSUCursorMovementType;
/*
  	ATSUCursorMovementType currently can take three values 
  	(kATSUByCharacter, kATSUByCluster, and kATSUByWord) 
  	and is used to indicate how much to move the cursor.  
*/
typedef UInt16 							ATSUVerticalCharacterType;
/*
  	ATSUVerticalCharacterType currently can take two values 
  	(kATSUStronglyVertical, and kATSUStronglyHorizontal) and 
  	is used to indicate whether text is to be laid out as 
  	vertical glyphs or horizontal glyphs.  
*/
typedef UInt16 							ATSUStyleComparison;
/*
  	ATSUStyleComparison is an enumeration with four values 
  	(kATUStyleUnequal, ATSUStyleContains, kATSUStyleEquals, 
  	and kATSUStyleContainedBy), and is used by ATSUCompareStyles() 
  	to indicate if the first style parameter contains as a 
  	proper subset, is equal to, or is contained by the second 
  	style parameter.
*/
/****************************************************/
/*	Gestalt selectors								*/
/*		Move into Gestalt.i when they're stable!!!!	*/
/****************************************************/

enum {
	gestaltATSUVersion			= FOUR_CHAR_CODE('uisv'),
	gestaltATSUFeatures			= FOUR_CHAR_CODE('uisf')
};


enum {
	gestaltOriginalATSUVersion	= (1 << 16)
};

/****************/
/*	Error codes	*/
/****************/

enum {
	kATSUInvalidTextLayoutErr	= -8790,						/*	An attempt was made to use a ATSUTextLayout */
																/*	which hadn't been initialized or is otherwise */
																/*	in an invalid state. */
	kATSUInvalidStyleErr		= -8791,						/*	An attempt was made to use a ATSUStyle which  */
																/*	hadn't been properly allocated or is otherwise  */
																/*	in an invalid state.  */
	kATSUInvalidTextRangeErr	= -8792,						/*	An attempt was made to extract information   */
																/*	information from or perform an operation on a   */
																/*	ATSUTextLayout for a range of text not covered   */
																/*	by the ATSUTextLayout.  */
	kATSUFontsMatched			= -8793,						/*	This is not an error code but is returned by    */
																/*	ATSUMatchFontsToText() when changes need to    */
																/*	be made to the fonts associated with the text.  */
	kATSUFontsNotMatched		= -8794,						/*	This value is returned by ATSUMatchFontsToText()    */
																/*	when the text contains Unicode characters which    */
																/*	cannot be represented by any installed font.  */
	kATSUNoCorrespondingFontErr	= -8795,						/*	This value is retrned by font ID conversion */
																/*	routines ATSUFONDtoFontID() and ATSUFontIDtoFOND() */
																/*	to indicate that the input font ID is valid but */
																/*	there is no conversion possible.  For example, */
																/*	data-fork fonts can only be used with ATSUI not */
																/*	the FontManager, and so converting an ATSUIFontID */
																/*	for such a font will fail.   */
	kATSUInvalidFontErr			= -8796,						/*	Used when an attempt was made to use an invalid font ID.*/
	kATSUInvalidAttributeValueErr = -8797,						/*	Used when an attempt was made to use an attribute with */
																/*	a bad or undefined value.  */
	kATSUInvalidAttributeSizeErr = -8798,						/*	Used when an attempt was made to use an attribute with a */
																/*	bad size.  */
	kATSUInvalidAttributeTagErr	= -8799,						/*	Used when an attempt was made to use a tag value that*/
																/*	was not appropriate for the function call it was used.  */
	kATSUInvalidCacheErr		= -8800,						/*	Used when an attempt was made to read in style data */
																/*	from an invalid cache.  Either the format of the */
																/*	cached data doesn't match that used by Apple Type */
																/*	Services for Unicode™ Imaging, or the cached data */
																/*	is corrupt.  */
	kATSUNotSetErr				= -8801,						/*	Used when the client attempts to retrieve an attribute, */
																/*	font feature, or font variation from a style when it */
																/*	hadn't been set.  In such a case, the default value will*/
																/*	be returned for the attribute's value.*/
	kATSUNoStyleRunsAssignedErr	= -8802,						/*	Used when an attempt was made to measure, highlight or draw*/
																/*	a ATSUTextLayout object that has no styleRuns associated with it.*/
																/*	Used when QuickDraw Text encounters an error rendering or measuring*/
	kATSUQuickDrawTextErr		= -8803							/*	a line of ATSUI text.*/
};

/*******************************************************************************/
/*	ATSUI Attribute tags:  Apple reserves values 0 to 65,535 (0 to 0x0000FFFF) */
/*	ATSUI clients may create their own tags with any other value               */
/*******************************************************************************/
/*	Line Control Attribute Tags */

enum {
	kATSULineWidthTag			= 1L,							/*	Type:			ATSUTextMeasurement*/
																/*	Default value:	0*/
	kATSULineRotationTag		= 2L,							/*	Type:			Fixed (fixed value in degrees in right-handed coordinate system)*/
																/*	Default value:	0*/
	kATSULineDirectionTag		= 3L,							/*	Type:			Boolean; values 0 or 1 (see below for value identities)*/
																/*	Default value:	kATSULeftToRightBaseDirection*/
	kATSULineJustificationFactorTag = 4L,						/*	Type:			Fract between 0 and 1*/
																/*	Default value:	kATSUNoJustification*/
	kATSULineFlushFactorTag		= 5L,							/*	Type:			Fract between 0 and 1 */
																/*	Default value:	kATSUStartAlignment*/
	kATSULineBaselineValuesTag	= 6L,							/*	Type:			BslnBaselineRecord*/
																/*	Default value:	All zeros.  Calculated from other style attributes (e.g., font and point size)*/
																/*	Type:			UInt32*/
	kATSULineLayoutOptionsTag	= 7L							/*	Default value:	kATSUNoLayoutOptions - other options listed in ATSLayoutTypes.h*/
};

/*	Run Style Attribute Tags */

enum {
																/* QuickDraw compatibility tags */
	kATSUQDBoldfaceTag			= 256L,							/*	Type:			Boolean	*/
																/*	Default value:	false*/
	kATSUQDItalicTag			= 257L,							/*	Type:			Boolean		*/
																/*	Default value:	false*/
	kATSUQDUnderlineTag			= 258L,							/*	Type:			Boolean	*/
																/*	Default value:	false*/
	kATSUQDCondensedTag			= 259L,							/*	Type:			Boolean	*/
																/*	Default value:	false*/
	kATSUQDExtendedTag			= 260L,							/*	Type:			Boolean	*/
																/*	Default value:	false*/
																/* Common run tags */
	kATSUFontTag				= 261L,							/*	Type:			ATSUFontID	*/
																/*	Default value:	GetScriptVariable( smSystemScript, smScriptAppFond )*/
	kATSUSizeTag				= 262L,							/*	Type:			Fixed	*/
																/*	Default value:	GetScriptVariable( smSystemScript, smScriptAppFondSize )	*/
	kATSUColorTag				= 263L,							/*	Type:			RGBColor	*/
																/*	Default value:	(0, 0, 0)*/
	kATSULanguageTag			= 264L,							/*	Type:			RegionCode	*/
																/*	Default value:	GetScriptVariable( smSystemScript, smScriptLang )*/
																/*	Less common run tags */
	kATSUVerticalCharacterTag	= 265L,							/*	Type:			ATSUVerticalCharacterType	*/
																/*	Default value:	kATSUStronglyHorizontal*/
	kATSUImposeWidthTag			= 266L,							/*	Type:			ATSUTextMeasurement*/
																/*	Default value:	all glyphs use their own font defined advance widths*/
	kATSUBeforeWithStreamShiftTag = 267L,						/*	Type:			Fixed*/
																/*	Default value:	0*/
	kATSUAfterWithStreamShiftTag = 268L,						/*	Type:			Fixed*/
																/*	Default value:	0*/
	kATSUCrossStreamShiftTag	= 269L,							/*	Type:			Fixed*/
																/*	Default value:	0*/
	kATSUTrackingTag			= 270L,							/*	Type:			Fixed*/
																/*	Default value:	0*/
	kATSUHangingInhibitFactorTag = 271L,						/*	Type:			Fract between 0 and 1*/
																/*	Default value:	0*/
	kATSUKerningInhibitFactorTag = 272L,						/*	Type:			Fract between 0 and 1*/
																/*	Default value:	0*/
	kATSUDecompositionFactorTag	= 273L,							/*	Type:			Fixed (-1.0 -> 1.0)*/
																/*	Default value:	0*/
	kATSUBaselineClassTag		= 274L,							/*	Type:			BslnBaselineClass  (see SFNTLayoutTypes.h)*/
																/*	Default value:	kBSLNNoBaselineOverride*/
	kATSUPriorityJustOverrideTag = 275L,						/*	Type:			ATSJustPriorityWidthDeltaOverrides (see ATSLayoutTypes.h)*/
																/*	Default value:	all zeros*/
	kATSUNoLigatureSplitTag		= 276L,							/*	Type:			Boolean*/
																/*	Default value:	false - ligatures and compound characters have divisable components.*/
	kATSUNoCaretAngleTag		= 277L,							/*	Type:			Boolean*/
																/*	Default value:	false - use the character's angularity to determine its boundaries*/
	kATSUSuppressCrossKerningTag = 278L,						/*	Type:			Boolean*/
																/*	Default value:	false - do not suppress automatic cross kerning (defined by font)*/
	kATSUNoOpticalAlignmentTag	= 279L,							/*	Type:			Boolean*/
																/*	Default value:	false - do not suppress character's automatic optical positional alignment*/
	kATSUForceHangingTag		= 280L,							/*	Type:			Boolean*/
																/*	Default value:	false - do not force the character's to hang beyond the line boundaries*/
	kATSUNoSpecialJustificationTag = 281L,						/*	Type:			Boolean*/
																/*	Default value:	false - perform post-compensation justification if needed*/
	kATSUMaxATSUITagValue		= 65535L						/*	This is the maximum Apple ATSUI reserved tag value.  Client defined tags must be larger.*/
};

/********************************/
/*	Enumerations and constants	*/
/********************************/
/* Cursor movement */

enum {
	kATSUByCharacter			= 0,
	kATSUByCluster				= 1,
	kATSUByWord					= 2
};

/* Vertical text types */

enum {
	kATSUStronglyHorizontal		= 0,
	kATSUStronglyVertical		= 1
};

/* Line direction types (used for kATSULineDirectionTag values) */

enum {
	kATSULeftToRightBaseDirection = 0,							/*	Impose left-to-right or top-to-bottom dominant direction */
	kATSURightToLeftBaseDirection = 1							/*	Impose right-to-left or bottom-to-top dominant direction */
};

/* Style comparison types */

enum {
	kATSUStyleUnequal			= 0,
	kATSUStyleContains			= 1,
	kATSUStyleEquals			= 2,
	kATSUStyleContainedBy		= 3
};

/* LineFlushFactor convenience defined values */
#define kATSUStartAlignment			((Fract) 0x00000000L)
#define kATSUEndAlignment			((Fract) 0x40000000L)
#define kATSUCenterAlignment		((Fract) 0x20000000L)
/* LineJustificationFactor convenience defined values */
#define kATSUNoJustification		((Fract) 0x00000000L)
#define kATSUFullJustification		((Fract) 0x40000000L)
/* Other constants	*/

enum {
	kATSUInvalidFontID			= 0
};



enum {
	kATSUUseLineControlWidth	= 0x7FFFFFFF
};



enum {
	kATSUUseGrafPortPenLoc		= (long)0xFFFFFFFF,
	kATSUClearAll				= (long)0xFFFFFFFF
};



enum {
	kATSUFromTextBeginning		= (long)0xFFFFFFFF,
	kATSUToTextEnd				= (long)0xFFFFFFFF
};


/****************/
/*	Functions	*/
/****************/

/*	Basic style functions	*/
EXTERN_API_C( OSStatus )
ATSUCreateStyle					(ATSUStyle *			oStyle);

EXTERN_API_C( OSStatus )
ATSUCreateAndCopyStyle			(ATSUStyle 				iStyle,
								 ATSUStyle *			oStyle);

EXTERN_API_C( OSStatus )
ATSUDisposeStyle				(ATSUStyle 				iStyle);

EXTERN_API_C( OSStatus )
ATSUSetStyleRefCon				(ATSUStyle 				iStyle,
								 UInt32 				iRefCon);

EXTERN_API_C( OSStatus )
ATSUGetStyleRefCon				(ATSUStyle 				iStyle,
								 UInt32 *				oRefCon);


/*	Style comparison 		*/
EXTERN_API_C( OSStatus )
ATSUCompareStyles				(ATSUStyle 				iFirstStyle,
								 ATSUStyle 				iSecondStyle,
								 ATSUStyleComparison *	oComparison);

/*	Attribute manipulations	*/
EXTERN_API_C( OSStatus )
ATSUCopyAttributes				(ATSUStyle 				iSourceStyle,
								 ATSUStyle 				iDestinationStyle);

EXTERN_API_C( OSStatus )
ATSUOverwriteAttributes			(ATSUStyle 				iSourceStyle,
								 ATSUStyle 				iDestinationStyle);

EXTERN_API_C( OSStatus )
ATSUUnderwriteAttributes		(ATSUStyle 				iSourceStyle,
								 ATSUStyle 				iDestinationStyle);

/*	Empty styles	*/
EXTERN_API_C( OSStatus )
ATSUClearStyle					(ATSUStyle 				iStyle);

EXTERN_API_C( OSStatus )
ATSUStyleIsEmpty				(ATSUStyle 				iStyle,
								 Boolean *				isClear);

/*	Clipboard support	*/
EXTERN_API_C( OSStatus )
ATSUCopyToHandle				(ATSUStyle 				iStyle,
								 Handle 				oStyleHandle);

EXTERN_API_C( OSStatus )
ATSUPasteFromHandle				(ATSUStyle 				iStyle,
								 Handle 				iStyleHandle);

/*	Get and set attributes */
EXTERN_API_C( OSStatus )
ATSUCalculateBaselineDeltas		(ATSUStyle 				iStyle,
								 BslnBaselineClass 		iBaselineClass,
								 BslnBaselineRecord 	oBaselineDeltas);

EXTERN_API_C( OSStatus )
ATSUSetAttributes				(ATSUStyle 				iStyle,
								 ItemCount 				iAttributeCount,
								 ATSUAttributeTag 		iTag[],
								 ByteCount 				iValueSize[],
								 ATSUAttributeValuePtr 	iValue[]);

EXTERN_API_C( OSStatus )
ATSUGetAttribute				(ATSUStyle 				iStyle,
								 ATSUAttributeTag 		iTag,
								 ByteCount 				iExpectedValueSize,
								 ATSUAttributeValuePtr 	oValue,
								 ByteCount *			oActualValueSize);

EXTERN_API_C( OSStatus )
ATSUGetAllAttributes			(ATSUStyle 				iStyle,
								 ATSUAttributeInfo 		oAttributeInfoArray[],
								 ItemCount 				iTagValuePairArraySize,
								 ItemCount *			oTagValuePairCount);

EXTERN_API_C( OSStatus )
ATSUClearAttributes				(ATSUStyle 				iStyle,
								 ItemCount 				iTagCount,
								 ATSUAttributeTag 		iTag[]);

/*	Font features	*/
EXTERN_API_C( OSStatus )
ATSUSetFontFeatures				(ATSUStyle 				iStyle,
								 ItemCount 				iFeatureCount,
								 ATSUFontFeatureType 	iType[],
								 ATSUFontFeatureSelector  iSelector[]);

EXTERN_API_C( OSStatus )
ATSUGetFontFeature				(ATSUStyle 				iStyle,
								 ItemCount 				iFeatureIndex,
								 ATSUFontFeatureType *	oFeatureType,
								 ATSUFontFeatureSelector * oFeatureSelector);

EXTERN_API_C( OSStatus )
ATSUGetAllFontFeatures			(ATSUStyle 				iStyle,
								 ItemCount 				iMaximumFeatureCount,
								 ATSUFontFeatureType *	oFeatureType,
								 ATSUFontFeatureSelector * oFeatureSelector,
								 ItemCount *			oActualFeatureCount);

EXTERN_API_C( OSStatus )
ATSUClearFontFeatures			(ATSUStyle 				iStyle,
								 ItemCount 				iFeatureCount,
								 ATSUFontFeatureType 	iType[],
								 ATSUFontFeatureSelector  iSelector[]);

/*	Font variations	*/
EXTERN_API_C( OSStatus )
ATSUSetVariations				(ATSUStyle 				iStyle,
								 ItemCount 				iVariationCount,
								 ATSUFontVariationAxis 	iAxis[],
								 ATSUFontVariationValue  iValue[]);

EXTERN_API_C( OSStatus )
ATSUGetFontVariationValue		(ATSUStyle 				iStyle,
								 ATSUFontVariationAxis 	iATSUFontVariationAxis,
								 ATSUFontVariationValue * oATSUFontVariationValue);

EXTERN_API_C( OSStatus )
ATSUGetAllFontVariations		(ATSUStyle 				iStyle,
								 ItemCount 				iVariationCount,
								 ATSUFontVariationAxis 	oVariationAxes[],
								 ATSUFontVariationValue  oATSUFontVariationValues[],
								 ItemCount *			oActualVariationCount);

EXTERN_API_C( OSStatus )
ATSUClearFontVariations			(ATSUStyle 				iStyle,
								 ItemCount 				iAxisCount,
								 ATSUFontVariationAxis 	iAxis[]);

/*	Basic text-layout functions	*/
EXTERN_API_C( OSStatus )
ATSUCreateTextLayout			(ATSUTextLayout *		oTextLayout);

EXTERN_API_C( OSStatus )
ATSUCreateTextLayoutWithTextPtr	(ConstUniCharArrayPtr 	iText,
								 UniCharArrayOffset 	iTextOffset,
								 UniCharCount 			iTextLength,
								 UniCharCount 			iTextTotalLength,
								 ItemCount 				iNumberOfRuns,
								 UniCharCount 			iRunLengths[],
								 ATSUStyle 				iStyles[],
								 ATSUTextLayout *		oTextLayout);

EXTERN_API_C( OSStatus )
ATSUCreateTextLayoutWithTextHandle (UniCharArrayHandle 	iText,
								 UniCharArrayOffset 	iTextOffset,
								 UniCharCount 			iTextLength,
								 UniCharCount 			iTextTotalLength,
								 ItemCount 				iNumberOfRuns,
								 UniCharCount 			iRunLengths[],
								 ATSUStyle 				iStyles[],
								 ATSUTextLayout *		oTextLayout);

EXTERN_API_C( OSStatus )
ATSUDisposeTextLayout			(ATSUTextLayout 		iTextLayout);

EXTERN_API_C( OSStatus )
ATSUSetTextLayoutRefCon			(ATSUTextLayout 		iTextLayout,
								 UInt32 				iRefCon);

EXTERN_API_C( OSStatus )
ATSUGetTextLayoutRefCon			(ATSUTextLayout 		iTextLayout,
								 UInt32 *				oRefCon);

/*	Text location	*/
EXTERN_API_C( OSStatus )
ATSUSetTextPointerLocation		(ATSUTextLayout 		iTextLayout,
								 ConstUniCharArrayPtr 	iText,
								 UniCharArrayOffset 	iTextOffset,
								 UniCharCount 			iTextLength,
								 UniCharCount 			iTextTotalLength);

EXTERN_API_C( OSStatus )
ATSUSetTextHandleLocation		(ATSUTextLayout 		iTextLayout,
								 UniCharArrayHandle 	iText,
								 UniCharArrayOffset 	iTextOffset,
								 UniCharCount 			iTextLength,
								 UniCharCount 			iTextTotalLength);

EXTERN_API_C( OSStatus )
ATSUGetTextLocation				(ATSUTextLayout 		iTextLayout,
								 void **				oText,
								 Boolean *				oTextIsStoredInHandle,
								 UniCharArrayOffset *	oOffset,
								 UniCharCount *			oTextLength,
								 UniCharCount *			oTextTotalLength);

/*	Text manipulation	*/
EXTERN_API_C( OSStatus )
ATSUTextDeleted					(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iDeletedRangeStart,
								 UniCharCount 			iDeletedRangeLength);

EXTERN_API_C( OSStatus )
ATSUTextInserted				(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iInsertionLocation,
								 UniCharCount 			iInsertionLength);

EXTERN_API_C( OSStatus )
ATSUTextMoved					(ATSUTextLayout 		iTextLayout,
								 ConstUniCharArrayPtr 	iNewLocation);

/*	Layout controls	*/
EXTERN_API_C( OSStatus )
ATSUCopyLayoutControls			(ATSUTextLayout 		iSource,
								 ATSUTextLayout 		iDest);

EXTERN_API_C( OSStatus )
ATSUSetLayoutControls			(ATSUTextLayout 		iLayout,
								 ItemCount 				iAttributeCount,
								 ATSUAttributeTag 		iTag[],
								 ByteCount 				iValueSize[],
								 ATSUAttributeValuePtr 	iValue[]);

EXTERN_API_C( OSStatus )
ATSUGetLayoutControl			(ATSUTextLayout 		iLayout,
								 ATSUAttributeTag 		iTag,
								 ByteCount 				iExpectedValueSize,
								 ATSUAttributeValuePtr 	oValue,
								 ByteCount *			oActualValueSize);

EXTERN_API_C( OSStatus )
ATSUGetAllLayoutControls		(ATSUTextLayout 		iLayout,
								 ATSUAttributeInfo 		oAttributeInfoArray[],
								 ItemCount 				iTagValuePairArraySize,
								 ItemCount *			oTagValuePairCount);

EXTERN_API_C( OSStatus )
ATSUClearLayoutControls			(ATSUTextLayout 		iLayout,
								 ItemCount 				iTagCount,
								 ATSUAttributeTag 		iTag[]);



/*	Style run processing	*/
EXTERN_API_C( OSStatus )
ATSUSetRunStyle					(ATSUTextLayout 		iTextLayout,
								 ATSUStyle 				iStyle,
								 UniCharArrayOffset 	iRunStart,
								 UniCharCount 			iRunLength);

EXTERN_API_C( OSStatus )
ATSUGetRunStyle					(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOffset,
								 ATSUStyle *			oStyle,
								 UniCharArrayOffset *	oRunStart,
								 UniCharCount *			oRunLength);

EXTERN_API_C( OSStatus )
ATSUGetContinuousAttributes		(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOffset,
								 UniCharCount 			iLength,
								 ATSUStyle 				oStyle);

/*	Drawing and measuring	*/
EXTERN_API_C( OSStatus )
ATSUDrawText					(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iLineOffset,
								 UniCharCount 			iLineLength,
								 ATSUTextMeasurement 	iLocationX,
								 ATSUTextMeasurement 	iLocationY);

EXTERN_API_C( OSStatus )
ATSUMeasureText					(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iLineStart,
								 UniCharCount 			iLineLength,
								 ATSUTextMeasurement *	oTextBefore,
								 ATSUTextMeasurement *	oTextAfter,
								 ATSUTextMeasurement *	oAscent,
								 ATSUTextMeasurement *	oDescent);

EXTERN_API_C( OSStatus )
ATSUMeasureTextImage			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iLineOffset,
								 UniCharCount 			iLineLength,
								 ATSUTextMeasurement 	iLocationX,
								 ATSUTextMeasurement 	iLocationY,
								 Rect *					oTextImageRect);

/*	Highlighting	*/
EXTERN_API_C( OSStatus )
ATSUHighlightText				(ATSUTextLayout 		iTextLayout,
								 ATSUTextMeasurement 	iTextBasePointX,
								 ATSUTextMeasurement 	iTextBasePointY,
								 UniCharArrayOffset 	iHighlightStart,
								 UniCharCount 			iHighlightLength);

EXTERN_API_C( OSStatus )
ATSUUnhighlightText				(ATSUTextLayout 		iTextLayout,
								 ATSUTextMeasurement 	iTextBasePointX,
								 ATSUTextMeasurement 	iTextBasePointY,
								 UniCharArrayOffset 	iHighlightStart,
								 UniCharCount 			iHighlightLength);

EXTERN_API_C( OSStatus )
ATSUGetTextHighlight			(ATSUTextLayout 		iTextLayout,
								 ATSUTextMeasurement 	iTextBasePointX,
								 ATSUTextMeasurement 	iTextBasePointY,
								 UniCharArrayOffset 	iHighlightStart,
								 UniCharCount 			iHighlightLength,
								 RgnHandle 				oHighlightRegion);

/*	Hit-testing	*/
EXTERN_API_C( OSStatus )
ATSUPositionToOffset			(ATSUTextLayout 		iTextLayout,
								 ATSUTextMeasurement 	iLocationX,
								 ATSUTextMeasurement 	iLocationY,
								 UniCharArrayOffset *	ioPrimaryOffset,
								 Boolean *				oIsLeading,
								 UniCharArrayOffset *	oSecondaryOffset);

EXTERN_API_C( OSStatus )
ATSUOffsetToPosition			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOffset,
								 Boolean 				iIsLeading,
								 ATSUCaret *			oMainCaret,
								 ATSUCaret *			oSecondCaret,
								 Boolean *				oCaretIsSplit);

/*	Cursor movement	*/
EXTERN_API_C( OSStatus )
ATSUNextCursorPosition			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOldOffset,
								 ATSUCursorMovementType  iMovementType,
								 UniCharArrayOffset *	oNewOffset);

EXTERN_API_C( OSStatus )
ATSUPreviousCursorPosition		(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOldOffset,
								 ATSUCursorMovementType  iMovementType,
								 UniCharArrayOffset *	oNewOffset);

EXTERN_API_C( OSStatus )
ATSURightwardCursorPosition		(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOldOffset,
								 ATSUCursorMovementType  iMovementType,
								 UniCharArrayOffset *	oNewOffset);

EXTERN_API_C( OSStatus )
ATSULeftwardCursorPosition		(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iOldOffset,
								 ATSUCursorMovementType  iMovementType,
								 UniCharArrayOffset *	oNewOffset);

/*	Line breaking	*/
EXTERN_API_C( OSStatus )
ATSUBreakLine					(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iLineStart,
								 ATSUTextMeasurement 	iLineWidth,
								 Boolean 				iUseAsSoftLineBreak,
								 UniCharArrayOffset *	oLineBreak);

EXTERN_API_C( OSStatus )
ATSUSetSoftLineBreak			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iLineBreak);

EXTERN_API_C( OSStatus )
ATSUGetSoftLineBreaks			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iRangeStart,
								 UniCharCount 			iRangeLength,
								 ItemCount 				iMaximumBreaks,
								 UniCharArrayOffset 	oBreaks[],
								 ItemCount *			oBreakCount);

EXTERN_API_C( OSStatus )
ATSUClearSoftLineBreaks			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iRangeStart,
								 UniCharCount 			iRangeLength);

/*	Idle processing	*/
EXTERN_API_C( OSStatus )
ATSUIdle						(ATSUTextLayout 		iTextLayout);

/*	Font matching	*/
EXTERN_API_C( OSStatus )
ATSUMatchFontsToText			(ATSUTextLayout 		iTextLayout,
								 UniCharArrayOffset 	iTextStart,
								 UniCharCount 			iTextLength,
								 ATSUFontID *			oFont,
								 UniCharArrayOffset *	oChangedOffset,
								 UniCharCount *			oChangedLength);

EXTERN_API_C( OSStatus )
ATSUSetTransientFontMatching	(ATSUTextLayout 		iTextLayout,
								 Boolean 				iTransientFontMatching);

EXTERN_API_C( OSStatus )
ATSUGetTransientFontMatching	(ATSUTextLayout 		iTextLayout,
								 Boolean *				oTransientFontMatching);

/*	Font ID's	*/
EXTERN_API_C( OSStatus )
ATSUFontCount					(ItemCount *			oFontCount);

EXTERN_API_C( OSStatus )
ATSUGetFontIDs					(ATSUFontID 			oFontIDs[],
								 ItemCount 				iArraySize,
								 ItemCount *			oFontCount);

EXTERN_API_C( OSStatus )
ATSUFONDtoFontID				(short 					iFONDNumber,
								 Style 					iFONDStyle,
								 ATSUFontID *			oFontID);

EXTERN_API_C( OSStatus )
ATSUFontIDtoFOND				(ATSUFontID 			iFontID,
								 short *				oFONDNumber,
								 Style *				oFONDStyle);

/*	Font names	*/
EXTERN_API_C( OSStatus )
ATSUCountFontNames				(ATSUFontID 			iFontID,
								 ItemCount *			oFontNameCount);

EXTERN_API_C( OSStatus )
ATSUGetIndFontName				(ATSUFontID 			iFontID,
								 ItemCount 				iFontNameIndex,
								 ByteCount 				iMaximumNameLength,
								 Ptr 					oName,
								 ByteCount *			oActualNameLength,
								 FontNameCode *			oFontNameCode,
								 FontPlatformCode *		oFontNamePlatform,
								 FontScriptCode *		oFontNameScript,
								 FontLanguageCode *		oFontNameLenguage);

EXTERN_API_C( OSStatus )
ATSUFindFontName				(ATSUFontID 			iFontID,
								 FontNameCode 			iFontNameCode,
								 FontPlatformCode 		iFontNamePlatform,
								 FontScriptCode 		iFontNameScript,
								 FontLanguageCode 		iFontNameLanguage,
								 ByteCount 				iMaximumNameLength,
								 Ptr 					oName,
								 ByteCount *			oActualNameLength,
								 ItemCount *			oFontNameIndex);

EXTERN_API_C( OSStatus )
ATSUFindFontFromName			(Ptr 					iName,
								 ByteCount 				iNameLength,
								 FontNameCode 			iFontNameCode,
								 FontPlatformCode 		iFontNamePlatform,
								 FontScriptCode 		iFontNameScript,
								 FontLanguageCode 		iFontNameLanguage,
								 ATSUFontID *			oFontID);

/*	Font features	*/
EXTERN_API_C( OSStatus )
ATSUCountFontFeatureTypes		(ATSUFontID 			iFont,
								 ItemCount *			oTypeCount);

EXTERN_API_C( OSStatus )
ATSUCountFontFeatureSelectors	(ATSUFontID 			iFont,
								 ATSUFontFeatureType 	iType,
								 ItemCount *			oSelectorCount);

EXTERN_API_C( OSStatus )
ATSUGetFontFeatureTypes			(ATSUFontID 			iFont,
								 ItemCount 				iMaximumTypes,
								 ATSUFontFeatureType 	oTypes[],
								 ItemCount *			oActualTypeCount);

EXTERN_API_C( OSStatus )
ATSUGetFontFeatureSelectors		(ATSUFontID 			iFont,
								 ATSUFontFeatureType 	iType,
								 ItemCount 				iMaximumSelectors,
								 ATSUFontFeatureSelector  oSelectors[],
								 Boolean 				oSelectorIsOnByDefault[],
								 ItemCount *			oActualSelectorCount,
								 Boolean *				oIsMutuallyExclusive);

EXTERN_API_C( OSStatus )
ATSUGetFontFeatureNameCode		(ATSUFontID 			iFont,
								 ATSUFontFeatureType 	iType,
								 ATSUFontFeatureSelector  iSelector,
								 FontNameCode *			oNameCode);

/*	Font variations	*/
EXTERN_API_C( OSStatus )
ATSUCountFontVariations			(ATSUFontID 			iFont,
								 ItemCount *			oVariationCount);

EXTERN_API_C( OSStatus )
ATSUGetIndFontVariation			(ATSUFontID 			iFont,
								 ItemCount 				iVariationIndex,
								 ATSUFontVariationAxis * oATSUFontVariationAxis,
								 ATSUFontVariationValue * oMinimumValue,
								 ATSUFontVariationValue * oMaximumValue,
								 ATSUFontVariationValue * oDefaultValue);

EXTERN_API_C( OSStatus )
ATSUGetFontVariationNameCode	(ATSUFontID 			iFont,
								 ATSUFontVariationAxis 	iAxis,
								 FontNameCode *			oNameCode);


/*	Font Instances	*/
EXTERN_API_C( OSStatus )
ATSUCountFontInstances			(ATSUFontID 			iFont,
								 ItemCount *			oInstances);

EXTERN_API_C( OSStatus )
ATSUGetFontInstance				(ATSUFontID 			iFont,
								 ItemCount 				iFontInstanceIndex,
								 ItemCount 				iMaximumVariations,
								 ATSUFontVariationAxis 	oAxes[],
								 ATSUFontVariationValue  oValues[],
								 ItemCount *			oActualVariationCount);

EXTERN_API_C( OSStatus )
ATSUGetFontInstanceNameCode		(ATSUFontID 			iFont,
								 ItemCount 				iInstanceIndex,
								 FontNameCode *			oNameCode);


#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __ATSUNICODE__ */

