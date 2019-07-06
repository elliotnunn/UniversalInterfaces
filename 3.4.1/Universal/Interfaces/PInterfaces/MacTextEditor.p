{
     File:       MacTextEditor.p
 
     Contains:   Interfaces for Textension - TextEdit replacement
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacTextEditor;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACTEXTEDITOR__}
{$SETC __MACTEXTEDITOR__ := 1}

{$I+}
{$SETC MacTextEditorIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __ATSUNICODE__}
{$I ATSUnicode.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CARBONEVENTS__}
{$I CarbonEvents.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}




TYPE
	TXNObject    = ^LONGINT; { an opaque 32-bit type }
	TXNObjectPtr = ^TXNObject;  { when a VAR xx:TXNObject parameter can be nil, it is changed to xx: TXNObjectPtr }
	TXNFontMenuObject    = ^LONGINT; { an opaque 32-bit type }
	TXNFontMenuObjectPtr = ^TXNFontMenuObject;  { when a VAR xx:TXNFontMenuObject parameter can be nil, it is changed to xx: TXNFontMenuObjectPtr }
	TXNFrameID							= UInt32;
	TXNVersionValue						= UInt32;

CONST
	kTXNWillDefaultToATSUIBit	= 0;
	kTXNWillDefaultToCarbonEventBit = 1;



TYPE
	TXNFeatureBits 				= UInt32;
CONST
	kTXNWillDefaultToATSUIMask	= $00000001;
	kTXNWillDefaultToCarbonEventMask = $00000002;

	kTXNWantMoviesBit			= 0;
	kTXNWantSoundBit			= 1;
	kTXNWantGraphicsBit			= 2;
	kTXNAlwaysUseQuickDrawTextBit = 3;
	kTXNUseTemporaryMemoryBit	= 4;



TYPE
	TXNInitOptions 				= UInt32;
CONST
	kTXNWantMoviesMask			= $00000001;
	kTXNWantSoundMask			= $00000002;
	kTXNWantGraphicsMask		= $00000004;
	kTXNAlwaysUseQuickDrawTextMask = $00000008;
	kTXNUseTemporaryMemoryMask	= $00000010;

	kTXNDrawGrowIconBit			= 0;
	kTXNShowWindowBit			= 1;
	kTXNWantHScrollBarBit		= 2;
	kTXNWantVScrollBarBit		= 3;
	kTXNNoTSMEverBit			= 4;
	kTXNReadOnlyBit				= 5;
	kTXNNoKeyboardSyncBit		= 6;
	kTXNNoSelectionBit			= 7;
	kTXNSaveStylesAsSTYLResourceBit = 8;
	kOutputTextInUnicodeEncodingBit = 9;
	kTXNDoNotInstallDragProcsBit = 10;
	kTXNAlwaysWrapAtViewEdgeBit	= 11;
	kTXNDontDrawCaretWhenInactiveBit = 12;
	kTXNDontDrawSelectionWhenInactiveBit = 13;
	kTXNSingleLineOnlyBit		= 14;
	kTXNDisableDragAndDropBit	= 15;
	kTXNUseQDforImagingBit		= 16;



	{
	 *  TXNFrameOptions
	 *  
	 *  Summary:
	 *    Defines the initial behavior of an MLTE object created with
	 *    TXNNewObject.
	 *  
	 *  Discussion:
	 *    These masks can be combined and passed to TXNNewObject to define
	 *    the initial behavior of a new object.
	 	}

TYPE
	TXNFrameOptions 			= UInt32;
CONST
	kTXNDrawGrowIconMask		= $00000001;
	kTXNShowWindowMask			= $00000002;
	kTXNWantHScrollBarMask		= $00000004;
	kTXNWantVScrollBarMask		= $00000008;
	kTXNNoTSMEverMask			= $00000010;
	kTXNReadOnlyMask			= $00000020;
	kTXNNoKeyboardSyncMask		= $00000040;
	kTXNNoSelectionMask			= $00000080;
	kTXNSaveStylesAsSTYLResourceMask = $00000100;
	kOutputTextInUnicodeEncodingMask = $00000200;
	kTXNDoNotInstallDragProcsMask = $00000400;
	kTXNAlwaysWrapAtViewEdgeMask = $00000800;
	kTXNDontDrawCaretWhenInactiveMask = $00001000;
	kTXNDontDrawSelectionWhenInactiveMask = $00002000;
	kTXNSingleLineOnlyMask		= $00004000;
	kTXNDisableDragAndDropMask	= $00008000;
	kTXNUseQDforImagingMask		= $00010000;

	kTXNSetFlushnessBit			= 0;
	kTXNSetJustificationBit		= 1;
	kTXNUseFontFallBackBit		= 2;
	kTXNRotateTextBit			= 3;
	kTXNUseVerticalTextBit		= 4;
	kTXNDontUpdateBoxRectBit	= 5;
	kTXNDontDrawTextBit			= 6;
	kTXNUseCGContextRefBit		= 7;
	kTXNImageWithQDBit			= 8;
	kTXNDontWrapTextBit			= 9;


	{
	 *  TXNTextBoxOptions
	 *  
	 *  Summary:
	 *    Defines how text will be drawn by one of the TXNxxxDrawTextBox
	 *    API.
	 *  
	 *  Discussion:
	 *    These masks can be combined and added to a TXNTextBoxOptionsData
	 *    structure to be passed to a TXNxxxDrawTextBox API.
	 	}

TYPE
	TXNTextBoxOptions 			= UInt32;
CONST
	kTXNSetFlushnessMask		= $00000001;
	kTXNSetJustificationMask	= $00000002;
	kTXNUseFontFallBackMask		= $00000004;
	kTXNRotateTextMask			= $00000008;
	kTXNUseVerticalTextMask		= $00000010;
	kTXNDontUpdateBoxRectMask	= $00000020;
	kTXNDontDrawTextMask		= $00000040;
	kTXNUseCGContextRefMask		= $00000080;
	kTXNImageWithQDMask			= $00000100;
	kTXNDontWrapTextMask		= $00000200;


TYPE
	TXNTextBoxOptionsDataPtr = ^TXNTextBoxOptionsData;
	TXNTextBoxOptionsData = RECORD
		optionTags:				TXNTextBoxOptions;
		flushness:				Fract;
		justification:			Fract;
		rotation:				Fixed;
		options:				Ptr;									{  for future use }
	END;


CONST
	kTXNFontContinuousBit		= 0;
	kTXNSizeContinuousBit		= 1;
	kTXNStyleContinuousBit		= 2;
	kTXNColorContinuousBit		= 3;


TYPE
	TXNContinuousFlags 			= UInt32;
CONST
	kTXNFontContinuousMask		= $00000001;
	kTXNSizeContinuousMask		= $00000002;
	kTXNStyleContinuousMask		= $00000004;
	kTXNColorContinuousMask		= $00000008;

	kTXNIgnoreCaseBit			= 0;
	kTXNEntireWordBit			= 1;
	kTXNUseEncodingWordRulesBit	= 31;


TYPE
	TXNMatchOptions 			= UInt32;
CONST
	kTXNIgnoreCaseMask			= $00000001;
	kTXNEntireWordMask			= $00000002;
	kTXNUseEncodingWordRulesMask = $80000000;



TYPE
	TXNFileType 				= UInt32;
CONST
	kTXNTextensionFile			= 'txtn';
	kTXNTextFile				= 'TEXT';
	kTXNPictureFile				= 'PICT';
	kTXNMovieFile				= 'MooV';
	kTXNSoundFile				= 'sfil';
	kTXNAIFFFile				= 'AIFF';
	kTXNUnicodeTextFile			= 'utxt';

	{ In MLTE version 1.1 and earlier, only kTXNTextEditStyleFrameType is supported.  }

TYPE
	TXNFrameType 				= UInt32;
CONST
	kTXNTextEditStyleFrameType	= 1;
	kTXNPageFrameType			= 2;
	kTXNMultipleFrameType		= 3;



TYPE
	TXNDataType 				= UInt32;
CONST
	kTXNTextData				= 'TEXT';
	kTXNPictureData				= 'PICT';
	kTXNMovieData				= 'moov';
	kTXNSoundData				= 'snd ';
	kTXNUnicodeTextData			= 'utxt';



TYPE
	TXNControlTag 				= UInt32;
CONST
	kTXNLineDirectionTag		= 'lndr';
	kTXNJustificationTag		= 'just';
	kTXNIOPrivilegesTag			= 'iopv';
	kTXNSelectionStateTag		= 'slst';
	kTXNInlineStateTag			= 'inst';
	kTXNWordWrapStateTag		= 'wwrs';
	kTXNKeyboardSyncStateTag	= 'kbsy';
	kTXNAutoIndentStateTag		= 'auin';
	kTXNTabSettingsTag			= 'tabs';
	kTXNRefConTag				= 'rfcn';
	kTXNMarginsTag				= 'marg';
	kTXNFlattenMoviesTag		= 'flat';
	kTXNDoFontSubstitution		= 'fSub';						{ note : this could degrade performance greatly in the case of large documents. }
	kTXNNoUserIOTag				= 'nuio';
	kTXNUseCarbonEvents			= 'cbcb';
	kTXNDrawCaretWhenInactiveTag = 'dcrt';
	kTXNDrawSelectionWhenInactiveTag = 'dsln';
	kTXNDisableDragAndDropTag	= 'drag';


TYPE
	TXNActionKey 				= UInt32;
CONST
	kTXNTypingAction			= 0;
	kTXNCutAction				= 1;
	kTXNPasteAction				= 2;
	kTXNClearAction				= 3;
	kTXNChangeFontAction		= 4;
	kTXNChangeFontColorAction	= 5;
	kTXNChangeFontSizeAction	= 6;
	kTXNChangeStyleAction		= 7;
	kTXNAlignLeftAction			= 8;
	kTXNAlignCenterAction		= 9;
	kTXNAlignRightAction		= 10;
	kTXNDropAction				= 11;
	kTXNMoveAction				= 12;
	kTXNFontFeatureAction		= 13;
	kTXNFontVariationAction		= 14;
	kTXNUndoLastAction			= 1024;							{ use if none of the above apply }

	kTXNClearThisControl		= $FFFFFFFF;
	kTXNClearTheseFontFeatures	= $80000000;

	{
	  convenience constants for TXNGet/SetTXNControls
	   kTXNIOPrivilegesTag
	}
	kTXNReadWrite				= false;
	kTXNReadOnly				= true;

	{  kTXNSelectionStateTag }
	kTXNSelectionOn				= true;
	kTXNSelectionOff			= false;

	{  kTXNInlineStateTag }
	kTXNUseInline				= false;
	kTXNUseBottomline			= true;


	{  kTXNWordWrapStateTag }
	kTXNAutoWrap				= false;
	kTXNNoAutoWrap				= true;

	{  kTXNKeyboardSyncStateTag }
	kTXNSyncKeyboard			= false;
	kTXNNoSyncKeyboard			= true;

	{  kTXNAutoIndentStateTag }
	kTXNAutoIndentOff			= false;
	kTXNAutoIndentOn			= true;

	{  kTXNDrawCaretWhenInactiveTag }
	kTXNDontDrawCaretWhenInactive = false;
	kTXNDrawCaretWhenInactive	= true;

	{  kTXNDrawSelectionWhenInactiveTag }
	kTXNDontDrawSelectionWhenInactive = false;
	kTXNDrawSelectionWhenInactive = true;

	{  kTXNDisableDragAndDropTag }
	kTXNEnableDragAndDrop		= false;
	kTXNDisableDragAndDrop		= true;


TYPE
	TXNTabType 					= SInt8;
CONST
	kTXNRightTab				= -1;
	kTXNLeftTab					= 0;
	kTXNCenterTab				= 1;


TYPE
	TXNTabPtr = ^TXNTab;
	TXNTab = RECORD
		value:					SInt16;
		tabType:				SInt8;
		filler:					SInt8;
	END;


CONST
	kTXNLeftToRight				= 0;
	kTXNRightToLeft				= 1;

	kTXNFlushDefault			= 0;							{ flush according to the line direction  }
	kTXNFlushLeft				= 1;
	kTXNFlushRight				= 2;
	kTXNCenter					= 4;
	kTXNFullJust				= 8;
	kTXNForceFullJust			= 16;							{ flush left for all scripts  }

	{
	  note in version 1 of Textension. The bottomMargin and
	  rightMargin fields are placeholders.  In version 1 you
	  can only change the top and left edge margins.  The other
	  values are placeholders for possible future enhancements
	}

TYPE
	TXNMarginsPtr = ^TXNMargins;
	TXNMargins = RECORD
		topMargin:				SInt16;
		leftMargin:				SInt16;
		bottomMargin:			SInt16;
		rightMargin:			SInt16;
	END;

	TXNControlDataPtr = ^TXNControlData;
	TXNControlData = RECORD
		CASE INTEGER OF
		0: (
			uValue:				UInt32;
			);
		1: (
			sValue:				SInt32;
			);
		2: (
			tabValue:			TXNTab;
			);
		3: (
			marginsPtr:			TXNMarginsPtr;
			);
	END;

	TXNScrollBarState 			= UInt8;
CONST
	kScrollBarsAlwaysActive		= true;
	kScrollBarsSyncWithFocus	= false;

	{
	  kTXNNoFontVariations is returned in the dataValue field when the caller as asked
	  to see if the variation is continuous and there was no variation in the continuous range
	}
	kTXNDontCareTypeSize		= $FFFFFFFF;
	kTXNDontCareTypeStyle		= $FF;
	kTXNIncrementTypeSize		= $00000001;
	kTXNDecrementTypeSize		= $80000000;
	kTXNUseScriptDefaultValue	= -1;
	kTXNNoFontVariations		= $7FFF;


TYPE
	TXNOffset 					= UInt32;
CONST
	kTXNUseCurrentSelection		= $FFFFFFFF;
	kTXNStartOffset				= 0;
	kTXNEndOffset				= $7FFFFFFF;



	kTXNSingleStylePerTextDocumentResType = 'MPSR';
	kTXNMultipleStylesPerTextDocumentResType = 'styl';


TYPE
	TXNObjectRefcon						= Ptr;
	{ constants for TXNShowSelection }

CONST
	kTXNShowStart				= false;
	kTXNShowEnd					= true;


TYPE
	TXNErrors							= OSStatus;
	{  default constants for TXNMacOSPreferredFontDescription  }

CONST
	kTXNDefaultFontName			= 0;							{  really a fontID not a name }

	kTXNDefaultFontSize			= $000C0000;

	kTXNDefaultFontStyle		= 0;





TYPE
	TXNTypeRunAttributes 		= UInt32;
CONST
	kTXNQDFontNameAttribute		= 'fntn';
	kTXNQDFontFamilyIDAttribute	= 'font';
	kTXNQDFontSizeAttribute		= 'size';
	kTXNQDFontStyleAttribute	= 'face';
	kTXNQDFontColorAttribute	= 'klor';
	kTXNTextEncodingAttribute	= 'encd';
	kTXNATSUIFontFeaturesAttribute = 'atfe';
	kTXNATSUIFontVariationsAttribute = 'atva';

	{
	  kTXNQDFontSizeAttributeSize is obsolete and incorrect
	  font sizes are always returned as a Fixed value, just as
	  they are passed to MLTE.  Use kTXNFontSizeAttributeSize.
	}

TYPE
	TXNTypeRunAttributeSizes 	= UInt32;
CONST
	kTXNQDFontNameAttributeSize	= 256;
	kTXNQDFontFamilyIDAttributeSize = 2;
	kTXNQDFontSizeAttributeSize	= 2;
	kTXNQDFontStyleAttributeSize = 1;
	kTXNQDFontColorAttributeSize = 6;
	kTXNTextEncodingAttributeSize = 4;
	kTXNFontSizeAttributeSize	= 4;


TYPE
	TXNPermanentTextEncodingType  = UInt32;
CONST
	kTXNSystemDefaultEncoding	= 0;
	kTXNMacOSEncoding			= 1;
	kTXNUnicodeEncoding			= 2;




TYPE
	TXTNTag								= FourCharCode;
	TXNATSUIFeaturesPtr = ^TXNATSUIFeatures;
	TXNATSUIFeatures = RECORD
		featureCount:			ItemCount;
		featureTypes:			ATSUFontFeatureTypePtr;
		featureSelectors:		ATSUFontFeatureSelectorPtr;
	END;

	TXNATSUIVariationsPtr = ^TXNATSUIVariations;
	TXNATSUIVariations = RECORD
		variationCount:			ItemCount;
		variationAxis:			ATSUFontVariationAxisPtr;
		variationValues:		ATSUFontVariationValuePtr;
	END;

	TXNAttributeDataPtr = ^TXNAttributeData;
	TXNAttributeData = RECORD
		CASE INTEGER OF
		0: (
			dataPtr:			Ptr;
			);
		1: (
			dataValue:			UInt32;
			);
		2: (
			atsuFeatures:		TXNATSUIFeaturesPtr;
			);
		3: (
			atsuVariations:		TXNATSUIVariationsPtr;
			);
	END;

	TXNTypeAttributesPtr = ^TXNTypeAttributes;
	TXNTypeAttributes = RECORD
		tag:					TXTNTag;
		size:					ByteCount;
		data:					TXNAttributeData;
	END;

	TXNMacOSPreferredFontDescriptionPtr = ^TXNMacOSPreferredFontDescription;
	TXNMacOSPreferredFontDescription = RECORD
		fontID:					UInt32;
		pointSize:				Fixed;
		encoding:				TextEncoding;
		fontStyle:				SInt8;
	END;

	TXNMatchTextRecordPtr = ^TXNMatchTextRecord;
	TXNMatchTextRecord = RECORD
		iTextPtr:				Ptr;
		iTextToMatchLength:		SInt32;
		iTextEncoding:			TextEncoding;
	END;

	{ constants & typedefs for setting the background }
	TXNBackgroundType 			= UInt32;
CONST
	kTXNBackgroundTypeRGB		= 1;

	{
	   The TXNBackgroundData is left as a union so that it can be expanded
	   in the future to support other background types
	}

TYPE
	TXNBackgroundDataPtr = ^TXNBackgroundData;
	TXNBackgroundData = RECORD
		CASE INTEGER OF
		0: (
			color:				RGBColor;
			);
	END;

	TXNBackgroundPtr = ^TXNBackground;
	TXNBackground = RECORD
		bgType:					TXNBackgroundType;
		bg:						TXNBackgroundData;
	END;

	TXNLongRectPtr = ^TXNLongRect;
	TXNLongRect = RECORD
		top:					SInt32;
		left:					SInt32;
		bottom:					SInt32;
		right:					SInt32;
	END;

	{
	  options for TXNGet/ClearActionChangeCount to decide what type(s) of action 
	  count to use 
	}

CONST
	kTXNTextInputCountBit		= 0;
	kTXNRunCountBit				= 1;


TYPE
	TXNCountOptions 			= UInt32;
CONST
	kTXNTextInputCountMask		= $00000001;
	kTXNRunCountMask			= $00000002;
	kTXNAllCountMask			= $00000003;





TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TXNFindProcPtr = FUNCTION({CONST}VAR matchData: TXNMatchTextRecord; iDataType: TXNDataType; iMatchOptions: TXNMatchOptions; iSearchTextPtr: UNIV Ptr; encoding: TextEncoding; absStartOffset: TXNOffset; searchTextLength: ByteCount; VAR oStartMatch: TXNOffset; VAR oEndMatch: TXNOffset; VAR ofound: BOOLEAN; refCon: UInt32): OSStatus;
{$ELSEC}
	TXNFindProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TXNActionKeyMapperProcPtr = FUNCTION(actionKey: TXNActionKey; commandID: UInt32): CFStringRef;
{$ELSEC}
	TXNActionKeyMapperProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TXNFindUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TXNFindUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TXNActionKeyMapperUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TXNActionKeyMapperUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppTXNFindProcInfo = $0FFFFFF0;
	uppTXNActionKeyMapperProcInfo = $000003F0;
	{
	 *  NewTXNFindUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION NewTXNFindUPP(userRoutine: TXNFindProcPtr): TXNFindUPP; { old name was NewTXNFindProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTXNActionKeyMapperUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewTXNActionKeyMapperUPP(userRoutine: TXNActionKeyMapperProcPtr): TXNActionKeyMapperUPP; { old name was NewTXNActionKeyMapperProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeTXNFindUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeTXNFindUPP(userUPP: TXNFindUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTXNActionKeyMapperUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeTXNActionKeyMapperUPP(userUPP: TXNActionKeyMapperUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeTXNFindUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeTXNFindUPP({CONST}VAR matchData: TXNMatchTextRecord; iDataType: TXNDataType; iMatchOptions: TXNMatchOptions; iSearchTextPtr: UNIV Ptr; encoding: TextEncoding; absStartOffset: TXNOffset; searchTextLength: ByteCount; VAR oStartMatch: TXNOffset; VAR oEndMatch: TXNOffset; VAR ofound: BOOLEAN; refCon: UInt32; userRoutine: TXNFindUPP): OSStatus; { old name was CallTXNFindProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTXNActionKeyMapperUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeTXNActionKeyMapperUPP(actionKey: TXNActionKey; commandID: UInt32; userRoutine: TXNActionKeyMapperUPP): CFStringRef; { old name was CallTXNActionKeyMapperProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}




{
  These are currently the only settings for the flags field of TXNCarbonEventInfo
  If you want the AppleEventHandlers removed use kTXNNoAppleEventHandlersMask.
  If you want to subsequently restart AppleEvent Handlers after removing
  your Texthandlers. Use kTXNRestartAppleEventHandlersMask.
}


CONST
	kTXNNoAppleEventHandlersBit	= 0;
	kTXNRestartAppleEventHandlersBit = 1;

	kTXNNoAppleEventHandlersMask = $01;
	kTXNRestartAppleEventHandlersMask = $02;

	{ dictionary keys currently supported in the TXNCarbonEventInfo dictionary }

	{  use this to pass an EventTargetRef to MLTE via the TXNSetTXNControl... call }

TYPE
	TXNCarbonEventInfoPtr = ^TXNCarbonEventInfo;
	TXNCarbonEventInfo = RECORD
		useCarbonEvents:		BOOLEAN;
		filler:					SInt8;
		flags:					UInt16;
		fDictionary:			CFDictionaryRef;
	END;


	{
	  *****************************************************************************************************
	   Allocates a new frame (i.e. new is called to allocate a TXNObject) and returns a pointer to the object 
	   in the newDoc parameter.
	   Input:
	        
	    iFileSpec:  If not NULL the file is read to obtain the document contents  after the object is 
	                successfully allocated.  If NULL you start with an empty document.
	                
	    iWindow:        Required.  The window in which the document is going to be  displayed.
	                
	    iFrame:     If text-area does not fill the entire window.  This specifies the area to fill.  Can be NULL.  
	                In  which case, the window’s portRect is used as the frame.
	                                
	    iFrameOptions:  Specify the options to be supported by this frame.  The available options are support 
	                    for cutting and pasting  movies and sound, handle scrollbars and handle grow box in  the 
	                    frame.
	    iFrameType:     Specify the type of frame to be used.  In MLTE version 1.1 and earlier, only 
	                    kTXNTextEditStyleFrameType is supported.
	   
	    iFileType:  Specify the primary file type.  If you  use  kTextensionTextFile files will be saved 
	                in a private format (see xxx).  If you  want saved files to be plain text files you should 
	                specify 'TEXT' here. If you specify 'TEXT' here you can use the frameOptions parameter to 
	                specify  whether the TEXT files should be saved  with 'MPSR' resources or 'styl' resources.  
	                These are resources which contain style information for a  file, and they  both have there 
	                own limitations.  If you use 'styl' resources to save style info your documents can have as 
	                many styles as you like however tabs will not be saved.  If you use 'MPSR' resources only the 
	                first style in the document  will be saved (you as client are expected to apply all style  
	                changes to the entire document).  If you  truly want  rich documents which can potentially 
	                contain graphics and sound you should specify kTextensionTextFileOutput.  If you want a plain 
	                text editor like SimpleText specify that style information by saved via ‘styl’ resources.  
	                If you want files similar to those output by CW IDE, BBEdit, and MPW specify that style 
	                information be saved in a ‘MPSR’ resource.
	   
	   Output:
	    
	    OSStatus:   function  result.  If anything goes wrong the error is returned.  Success must be complete.  
	                That is if everything  works, but there is a failure reading a specified file the  object 
	                is freed.
	    oTXNObject:     Pointer to the opaque datastructure allocated by the function.  Most of the subsequent 
	                    functions require that such a pointer be passed in.
	                
	    oTXNFrameID:    Unique ID for the frame. <Note in version 1.0 this value is always set to 0>
	    iRefCon:        Caller can set this to any value.  It is retained by the
	                    TXNNewObject which can later be asked to return it.
	  **************************************************************************************************************
	}
	{
	 *  TXNNewObject()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in Textension 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION TXNNewObject(iFileSpec: {Const}FSSpecPtr; iWindow: WindowRef; iFrame: {Const}RectPtr; iFrameOptions: TXNFrameOptions; iFrameType: TXNFrameType; iFileType: TXNFileType; iPermanentEncoding: TXNPermanentTextEncodingType; VAR oTXNObject: TXNObject; VAR oTXNFrameID: TXNFrameID; iRefCon: TXNObjectRefcon): OSStatus; C;


{
  *************************************************************************************************
   Delete a previously allocated TXNObject and all associated data structures.  If the frameType is 
   multiple frames all frames are released.
        
   Input:
    iTXNObject: opaque structure to free.
  **************************************************************************************************
}
{
 *  TXNDeleteObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNDeleteObject(iTXNObject: TXNObject); C;


{
  *************************************************************************************************                         
   Changes the frame's size to match the new width and height.
   Input:
    
    iTXNObject:     opaque Textension structure.
    
    iWidth:         New width in pixels.
    
    iHeight:        New height in pixels.
    
    iTXNFrameID:    FrameID that specifies the frame to move.
  *************************************************************************************************
}
{
 *  TXNResizeFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNResizeFrame(iTXNObject: TXNObject; iWidth: UInt32; iHeight: UInt32; iTXNFrameID: TXNFrameID); C;


{
  *************************************************************************************************                         
   Changes the frame's bounds to match the Rect. 
   Input:
        iTXNObject :                                opaque Textension structure.
        
        (iTop, iLeft, iBottom, iRight):     Rect of the view
         
    
    iTXNFrameID:        FrameID that specifies the frame to move.
  *************************************************************************************************
}
{
 *  TXNSetFrameBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNSetFrameBounds(iTXNObject: TXNObject; iTop: SInt32; iLeft: SInt32; iBottom: SInt32; iRight: SInt32; iTXNFrameID: TXNFrameID); C;


{
  ****************************************************************************************************
    Initialize the Textension library.  Should be called as soon as possible after the Macintosh toolbox
    is initialized.
   Input:
    iDefaultFonts:      A table of font information including fontFamily ID, point size,
                        style, and script code. The table can be NULL or can have
                        an entry for any script for which you would like to to
                        designate a default font.  Only a valid script number is
                        required.  You can designate that Textension should use
                        the default for a give script by setting the field to kTXNUseScriptDefaultValue (-1).
                                            
   For example, if you wanted to specify New York as the default
   font to use for Roman scripts, but were happy with the 
   default style and size you would call the function like this:
    
    TXNMacOSPreferredFontDescription    defaults;
    GetFNum( "\pNew York", &defaults.fontID );
    defaults.pointSize = kTXNDefaultFontSize;
    defaults.fontStyle = kTXNDefaultFontStyle;
    defaults.script = smRoman;
    status = TXNInitTextension( &defaults, 1, 0 );
    iCountDefaultFonts: Count of entries in the iDefaultFonts parameter.
    
                    
                            
    iUsageFlags:        Specify whether sound and movies should be supported.
   Output:
    OSStatus:       Function result.  NoErr if everything initialized correctly.  Variety of
                    possible MacOS errors if something goes wrong.
  *********************************************************************************************/
}
{
 *  TXNInitTextension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNInitTextension(iDefaultFonts: TXNMacOSPreferredFontDescriptionPtr; iCountDefaultFonts: ItemCount; iUsageFlags: TXNInitOptions): OSStatus; C;


{
  *************************************************************************************
   Close the Textension library.  It is necessary to call this function so that Textension 
   can correctly close down any TSM connections and do other clean up.
  **************************************************************************************
}
{
 *  TXNTerminateTextension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNTerminateTextension; C;

{
  **************************************************************************************
    Process a keydown event. Note that if CJK script is installed and current font is 
    CJK inline input will take place. This is always the case unless the application has 
    requested the bottomline window or has turned off TSM (see initialization options above).
        
   Input:
        iTXNObject:     opaque struct to apply keydown to.
            
        iEvent:     the keydown event.  
  ***************************************************************************************
}
{
 *  TXNKeyDown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNKeyDown(iTXNObject: TXNObject; {CONST}VAR iEvent: EventRecord); C;

{
  ***************************************************************************************
    Handle switching the cursor.  If over text area set to i-beam.  Over graphics, sound,
    movie, scrollbar or outside of window set to arrow.
    
    Input:
        iTXNObject:         Opaque struct obtained from TXNNewObject.
        ioCursorRgn:        Region to be passed to WaitNextEvent.  Resized  accordingly by 
                        TXNAdjustCursor.
  ***************************************************************************************
}
{
 *  TXNAdjustCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNAdjustCursor(iTXNObject: TXNObject; ioCursorRgn: RgnHandle); C;


{
  ****************************************************************************************                      
    Process click in content region.  Takes care of scrolling, selecting text,  playing 
    sound and movies, drag & drop, and double-clicks.
    Input:
        iTXNObject:     Opaque struct obtained from TXNNewObject.
        iEvent:     the mousedown event
  *****************************************************************************************
}
{
 *  TXNClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNClick(iTXNObject: TXNObject; {CONST}VAR iEvent: EventRecord); C;


{
  ********************************************************************************************
    
    Call this when WaitNextEvent returns false or there is no active TSNObject . 
    The TXNObject parameter can be NULL which allows a client to call this function at any 
    time.  This is necessary to insure input methods enough time to be reasonably responsive.
    NOTE : You do not need to call this when working on Carbon, TSM events are passed directly
           to the text object.
    Input:
        iTXNObject:         The currently active TXNObject or NULL.
        ioEvent:            The event record.  Usually a NULL event.  If the 
                            event is not an NULL event on entry, and an input
                            method consumes the event the event should return
                            as a NULL event.
    Output:
        Boolean:        True if TSM handled this event.  False if TSM did not handle this event.
  **********************************************************************************************
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  TXNTSMCheck()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TXNTSMCheck(iTXNObject: TXNObject; VAR ioEvent: EventRecord): BOOLEAN; C;


{
  ***********************************************************************************************                       
    Selects everything in a frame.
    Input:
        iTXNObject: opaque TXNObject 
  ***********************************************************************************************   
}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  TXNSelectAll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNSelectAll(iTXNObject: TXNObject); C;



{
  ***********************************************************************************************                       
    Focues the TXNObject.  Scrollbars and insertion point are made active  if iBecomingFocused
    is true, and inactive if false.
    
    Input:
        iTXNObject:         opaque TXNObject
        
        iBecomingFocused:   true if becoming active.  false otherwise.
  ************************************************************************************************  
}
{
 *  TXNFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNFocus(iTXNObject: TXNObject; iBecomingFocused: BOOLEAN); C;

{
  ************************************************************************************************                      
    Handle update event (i.e. draw everything in a frame.) This function calls the Toolbox
    BeginUpdate - EndUpdate functions for the window that was passed to TXNNewObject.  This
    makes it inappropriate for windows that contain something else besides the TXNObject.
    Input:
        iTXNObject: opaque TXNObject 
  ************************************************************************************************
}
{
 *  TXNUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNUpdate(iTXNObject: TXNObject); C;

{
  *************************************************************************************************
    Redraw the TXNObject including any scrollbars associated with the text frame.  Call this function
    in response to an update event for a window that contains multiple TXNObjects or some other graphic
    element.  The caller is responsible for calling BeginUpdate/EndUpdate in response to the update
    event.
    Input:
        iTXNObject:     opaque TXNObject to draw
        iDrawPort:  Can be NULL. If NULL the port is drawn to the port currently attached to the 
                    iTXNObject.  If not NULL drawing goes to the iDrawPort.  If drawing is done
                    to the iDrawPort selection is not updated.  This works this way so that it
                    is possible to Draw a TXNObject to a static port (i.e. print the thing without 
                    reflowing the text to match the paper size which is what TXNPrint does) 
                    and not have a line drawn where the selection would be.  If you pass an 
                    iDrawPort to an active TXNObject (i.e. editable) the selection will not be updated. In 
                    this case the selection will behave oddly until text is typed which will serve
                    to realign the selection.  Bottom-line don't pass a port in unless you want
                    static text (printed or non-editable)
  *************************************************************************************************
}
{
 *  TXNDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNDraw(iTXNObject: TXNObject; iDrawPort: GWorldPtr); C;

{
  *************************************************************************************************
    Force a frame to be updated.  Very much like toolbox call InvalRect.
    
    Input:
        iTXNObject: opaque TXNObject 
  **************************************************************************************************                        
}
{
 *  TXNForceUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNForceUpdate(iTXNObject: TXNObject); C;


{
  **************************************************************************************************
    Depending on state of window get the appropriate sleep time to be passed to WaitNextEvent.
    Input:
        iTXNObject: opaque TXNObject obtained from TXNNewObject
        
    Output:
    
        UInt32: function result appropriate sleep time.
  ***************************************************************************************************
}
{
 *  TXNGetSleepTicks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetSleepTicks(iTXNObject: TXNObject): UInt32; C;

{
  ***************************************************************************************************
    Do necessary Idle time processing. Typically flash the cursor. If a TextService is active
    pass a NULL event to the Text Service so it gets  time.
    Input:
        iTXNObject: opaque TXNObject obtained from TXNNewObject
  ****************************************************************************************************
}
{
 *  TXNIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNIdle(iTXNObject: TXNObject); C;


{
  *********************************************************************************************************
    Handle mouse-down in grow region. 
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
        iEvent:     The mousedown event
  *********************************************************************************************************
}
{
 *  TXNGrowWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNGrowWindow(iTXNObject: TXNObject; {CONST}VAR iEvent: EventRecord); C;


{
  ********************************************************************************************************
    Handle mousedown in zoom.
    Input:
        iTXNObject:     opaque TXNObject obtained from  TXNNewObject
        iPart:      Value returned by FindWindow
  *********************************************************************************************************
}
{
 *  TXNZoomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNZoomWindow(iTXNObject: TXNObject; iPart: SInt16); C;


{
  *******************************************************************************************************
    Use this to determine if the Undo item in Edit menu should be highlighted or not.  Tells you if last
    command was undoable.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
    Output:
        Boolean     function result.  If True the last command is undoable and the undo item in the menu 
                    should be active.  If false last command cannot be undone and undo should be grayed 
                    in the menu.
        oTXNActionKey The key code that the caller can use to pick a string to describe the undoable
                      action in the undo item.  Pass in NULL if the string isn't needed.
  *********************************************************************************************************
}
{
 *  TXNCanUndo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNCanUndo(iTXNObject: TXNObject; VAR oTXNActionKey: TXNActionKey): BOOLEAN; C;

{
  ********************************************************************************************************
    Undo the last command.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
  *********************************************************************************************************
}
{
 *  TXNUndo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNUndo(iTXNObject: TXNObject); C;

{
  *********************************************************************************************************
    Use this to determine if the current item on the undo stack is redoable.  If it returns true.
    than the redo item in the edit menu should be active.
    
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject.
        oTXNActionKey The key code that the caller can use to pick a string to describe the redoable
                      action in the redo item.  Pass in NULL if the string isn't needed.
}

{ ********************************************************************************************************* }
{
 *  TXNCanRedo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNCanRedo(iTXNObject: TXNObject; VAR oTXNActionKey: TXNActionKey): BOOLEAN; C;


{
  ********************************************************************************************************
    Redo the last command.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
  *********************************************************************************************************
}
{
 *  TXNRedo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNRedo(iTXNObject: TXNObject); C;



{
  *********************************************************************************************************
    Cut the current selection to the clipboard.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
    Output:
        OSStatus:   function result.  Variety of memory or scrap MacOS errors.
  **********************************************************************************************************
}
{
 *  TXNCut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNCut(iTXNObject: TXNObject): OSStatus; C;


{
  *********************************************************************************************************
    TXNCopy
        Copy current selection
   
    Input:
        iTXNObject:         current document
                    
  **********************************************************************************************************                        
}
{
 *  TXNCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNCopy(iTXNObject: TXNObject): OSStatus; C;


{
  ***********************************************************************************************************
    TXNPaste
        Paste the clipboard
   
    Input:
        iTXNObject:         current document
                    
  **********************************************************************************************************
}
{
 *  TXNPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNPaste(iTXNObject: TXNObject): OSStatus; C;


{
  **********************************************************************************************************
    TXNClear
        clear the current selection
   
    Input:
        iTXNObject:         current document
                    
  **********************************************************************************************************                        
}
{
 *  TXNClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNClear(iTXNObject: TXNObject): OSStatus; C;


{
  *********************************************************************************************************
    TXNGetSelection
        Get the absolute offsets of the current selection.  
        Embedded graphics, sound, etc. each count as one character.
   
    Input:
        iTXNObject:         current document
    
    Output:
        oStartOffset:   absolute beginning of the current selection.
        oEndOffset:     end of current selection.
  *********************************************************************************************************                     
}
{
 *  TXNGetSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNGetSelection(iTXNObject: TXNObject; VAR oStartOffset: TXNOffset; VAR oEndOffset: TXNOffset); C;


{
  *****************************************************************************************************
    Scroll the current selection into view.
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject
        iShowEnd:   If true the end of the selection is scrolled into view. If false the
                    beginning of selection is scrolled into view.
  ****************************************************************************************************                      
}
{
 *  TXNShowSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNShowSelection(iTXNObject: TXNObject; iShowEnd: BOOLEAN); C;


{
  *****************************************************************************************************
    Call to find out if the current selection is empty. Use this to determine if Paste, Cut, Copy, 
    Clear should be highlighted in Edit menu.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
    Output:
        Boolean:    function result.  True if current selection is empty (i.e. start offset == end offset).  
                    False if selection is not empty.
  ********************************************************************************************************
}
{
 *  TXNIsSelectionEmpty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNIsSelectionEmpty(iTXNObject: TXNObject): BOOLEAN; C;


{
  ********************************************************************************************************
    Set the current selection. 
   
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
        iStartOffset:   new beginning
        iEndOffset:     new end
  ********************************************************************************************************
}
{
 *  TXNSetSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetSelection(iTXNObject: TXNObject; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;


{
  *******************************************************************************************************
    TXNGetContinuousTypeAttributes
        Test the current selection to see if type size, style, color and/or font are continuous. 
        That is is the current selection made up of one font, one font size, one Style, and/or one color.  
        On return examine the flags to see if the attributes specified were continuous.  If an attribute
        is continuous then the dataValue field in the TXNTypeAttributes can be examined to get the continous
        value.  Remember that for color you pass a ptr to an RGBColor in attr[0].data.dataPtr.
    Input:
        iTXNObject:             current document
        oContinuousFlags:   Bits which can be examined to see if type size, style, color, and/or font are continuous
                            
                            e.g 
                            if (  TXNGetContinuousTypeAttributes( txnObject, &flags, 1, &attr ) == noErr )
                            (
                                    if ( flags & kTXNFontContinuousMask )
                                        ....check a font name
        ioCount:            Count of TXNTypeAttributes records in the ioTypeAttributes array.
        ioTypeAttributes:   Array of TXNTypeAttributes that indicate the type attributes the
                            caller is interested in.  For example, if you wanted to know if
                            the current selection was continuous in terms of being all
                            one same font size you could do something like this.
                            
                            TXNTypeAttributes       attr[1] = ( TXNFontSizeAttribute, sizeof(Fixed),( 0 ) )
                            
                            on return  from the function if size is continuous (i.e. if the bit 3 of flags is set)
                            then the third field (attr[0].data.dataValue) will contain the size of the font as a Fixed value.
    
                                
  ***********************************************************************************************************
}
{
 *  TXNGetContinuousTypeAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetContinuousTypeAttributes(iTxnObject: TXNObject; VAR oContinuousFlags: TXNContinuousFlags; iCount: ItemCount; ioTypeAttributes: TXNTypeAttributesPtr): OSStatus; C;





{
  *************************************************************************************************
    TXNSetTypeAttributes
        Set the current ranges font information.  Values are passed
        in the attributes array.  Values <= sizeof(UInt32) are passed
        by value. > sizeof(UInt32) are passed as a pointer.  That is
        the TXNTypeAttributes' 3rd field is a union that servers as
        either a 32-bit integer where values can be written or a 32-bit pointer 
        a value.
    Input:
        iTXNObject:         current document
        iAttrCount:     Count of type attributes in the TXNTypeAttributes array.
        iAttributes:    Attributes that caller would like to set.
        iStartOffset:   Start of the range where text attributes should be changed.
        iEndOffset:     End of the range.
    
    Output:
        OSStatus:           various MacOS  errs.  Notably memory manager and paramErrs.                         
  *************************************************************************************************                         
}
{
 *  TXNSetTypeAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetTypeAttributes(iTXNObject: TXNObject; iAttrCount: ItemCount; {CONST}VAR iAttributes: TXNTypeAttributes; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;



{
 *  TXNSetTXNObjectControls()
 *  
 *  Summary:
 *    Sets formatting and privileges attributes (such as justification,
 *    line direction, tab values, and read-only status) that apply to
 *    the entire text object.
 *  
 *  Discussion:
 *    On systems that use Apple Type Services for Unicode Imaging
 *    (ATSUI), the ATSUI line control attribute tags can be passed to
 *    this function in the iControlTag parameter. This is the case for
 *    all the ATSUI tags except kATSULineRotationTag. ATSUI tags are
 *    applied to the entire text object.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      The text object that identifies the document for which you want
 *      to set formatting and privileges attributes.
 *    
 *    iClearAll:
 *      A Boolean value. If you set this to true, all formatting and
 *      privileges attributes are reset to their default value. That
 *      is, true clears existing tags and resets each to its default
 *      value.
 *    
 *    iControlCount:
 *      The number of items in the iControlTags array.
 *    
 *    iControlTags:
 *      An array of values that specifies kind of data that is passed
 *      in the iControlData parameter. See “Formatting and Privileges
 *      Settings” for a description of possible values. On systems that
 *      use Apple Type Services for Unicode Imaging (ATSUI), you can
 *      also pass ATSUI attribute tag constants. See the ATSUI
 *      documentation for a description of the ATSUI constants. Can be
 *      NULL if iClearAll is true.
 *    
 *    iControlData:
 *      An array of TXNControlData unions that contain the information
 *      your application wants to set. The value you supply to the
 *      iControlTags parameter specifies how the union of type
 *      TXNControlData is treated. You must make sure that the value
 *      you assign to the iControlData parameter is the appropriate
 *      type implied by the value you passed in the iControlTags
 *      parameter. Can be NULL if iClearAll is true.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetTXNObjectControls(iTXNObject: TXNObject; iClearAll: BOOLEAN; iControlCount: ItemCount; iControlTags: LongIntPtr; iControlData: TXNControlDataPtr): OSStatus; C;


{
 *  TXNGetTXNObjectControls()
 *  
 *  Summary:
 *    Gets the current formatting and privileges attributes (such as
 *    justification, line direction, tab values, and read-only status)
 *    for a text object.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      The text object that identifies the document to be activated.
 *    
 *    iControlCount:
 *      The number of items in the iControlTags array.
 *    
 *    iControlTags:
 *      An array of values that specify the kind of formatting
 *      information you want returned in the oControlData array. See
 *      “Formatting and Privileges Settings” for a description of
 *      possible values.
 *    
 *    oControlData:
 *      An array of TXNControlData unions. On return, the array
 *      contains the information that was requested through the
 *      iControlTags array. Your application must allocate the
 *      oControlData array.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetTXNObjectControls(iTXNObject: TXNObject; iControlCount: ItemCount; {CONST}VAR iControlTags: TXNControlTag; VAR oControlData: TXNControlData): OSStatus; C;




{
  ******************************************************************************************************
    TXNCountRunsInRange
        Given a range specified by the starting and ending offset return a count of the runs in that
        range.  Run in this case means changes in TextSyles or a graphic or sound.
        Result:
            OSStatus:       paramerr mostly
        Input:
            iTXNObject          The TXNObject you are interested in.
            iStartOffset        start of range
            iEndOffset          end of range
        
        Output:
            oRunCount           count of runs in the range
  *******************************************************************************************************
}
{
 *  TXNCountRunsInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNCountRunsInRange(iTXNObject: TXNObject; iStartOffset: TXNOffset; iEndOffset: TXNOffset; VAR oRunCount: ItemCount): OSStatus; C;

{
 *  TXNGetIndexedRunInfoFromRange()
 *  
 *  Summary:
 *    Gets information about a run in a range of data.
 *  
 *  Discussion:
 *    You should first call the TXNCountRunsInRange function to get the
 *    count. The TXNTypeAttributes structure must specify the text
 *    attribute in which the application is interested. In other words,
 *    the tag field must be set.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      The text object for the current text area.
 *    
 *    iIndex:
 *      The value that corresponds to the run for which you want to get
 *      information. You call the TXNCountRunsInRange function to get
 *      the number of runs in a range. The iIndex parameter is
 *      zero-based, so its possible values are from 0 to the number of
 *      runs in a range minus 1.
 *    
 *    iStartOffset:
 *      The offset at which you want to start to obtain run information.
 *    
 *    iEndOffset:
 *      The offset at which you want run information to end.
 *    
 *    oRunStartOffset:
 *      On return, a pointer to a value that identifies the start of
 *      run relative to the beginning of the text, not the beginning of
 *      the range you specified in the iStartOffset parameter.
 *    
 *    oRunEndOffset:
 *      On return, a pointer to a value that identifies the end of the
 *      run relative to the beginning of the text, not the beginning of
 *      the range you specified in the iStartOffset parameter.
 *    
 *    oRunDataType:
 *      On return, a pointer to a value that identifies the type of
 *      data in the run. See “Supported Data Types” for a description
 *      of possible values.
 *    
 *    iTypeAttributeCount:
 *      The number of font attributes.
 *    
 *    ioTypeAttributes:
 *      A pointer to a structure of type TXNTypeAttributes. On input,
 *      you specify the attribute (such as color) in the tag field and
 *      the attribute size in the size field. You can pass NULL for the
 *      data field. On return, the data field contains the attribute
 *      data. The data field is a union that serves either as a 32-bit
 *      integer or a 32-bit pointer, depending on the size field.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetIndexedRunInfoFromRange(iTXNObject: TXNObject; iIndex: ItemCount; iStartOffset: TXNOffset; iEndOffset: TXNOffset; VAR oRunStartOffset: TXNOffset; VAR oRunEndOffset: TXNOffset; VAR oRunDataType: TXNDataType; iTypeAttributeCount: ItemCount; ioTypeAttributes: TXNTypeAttributesPtr): OSStatus; C;


{
  **********************************************************************************************************
    TXNDataSize
    Return the size in bytes of the characters in a given TXNObject.
    Result:
        ByteCount:          The bytes required to hold the characters
    Input:
        iTXNObject:         The TXNObject
    
  **********************************************************************************************************
}
{
 *  TXNDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDataSize(iTXNObject: TXNObject): ByteCount; C;


{
  ***********************************************************************************************************
    Copy the data in the range specified by startOffset and endOffset. This function should be used
    in conjunction with TXNNextDataRun.  The client would call TXNCountRunsInRange to the number of data
    runs in a given range.  The client can then walk the runs with the function TXNGetIndexedRunInfoFromRange.
    TXNGetIndexedRunInfoFromRange lets you examine each runs type and text attributes.  
    For each data run of interest (i.e. one whose data the caller wanted to look at) 
    the client would call TXNGetData. The handle passed to TXNGetData should not be allocated.  
    TXNGetData takes care of allocating the dataHandle as necessary.  However, the caller is  responsible 
    for disposing the handle.  
    No effort is made to insure that data copies align on a word boundary.  Data is simply copied as
    specified in the offsets.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject.
        iStartOffset:   absolute offset from which data copy should begin.
        iEndOffset: absolute offset at which data copy should end.
                        
    Output:
        OSStatus    Memory errors or  TXN_IllegalToCrossDataBoundaries if offsets specify a range that 
                    crosses a data type boundary.
        oDataHandle: If noErr a new handle containing the requested data. The caller is responsible
                     for disposing the handle.  Note that the handle is a copy so it can be safely
                     disposed at any time.
  **********************************************************************************************************                            
}
{
 *  TXNGetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetData(iTXNObject: TXNObject; iStartOffset: TXNOffset; iEndOffset: TXNOffset; VAR oDataHandle: Handle): OSStatus; C;


{
  ***********************************************************************************************************
    Copy the data in the range specified by startOffset and endOffset. 
    The handle passed to TXNGetDataEncoded should not be allocated.  
    TXNGetData takes care of allocating the dataHandle as necessary.  However, the caller is  responsible 
    for disposing the handle.  
    No effort is made to insure that data copies align on a word boundary.  Data is simply copied as
    specified in the offsets.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject.
        iStartOffset:   absolute offset from which data copy should begin.
        iEndOffset: absolute offset at which data copy should end.
        iEncoding : should be kTXNTextData or kTXNUnicodeTextData               
    Output:
        OSStatus    Memory errors or  TXN_IllegalToCrossDataBoundaries if offsets specify a range that 
                crosses a data type boundary.
        oDataHandle:        If noErr a new handle containing the requested data.
  **********************************************************************************************************                            
}
{
 *  TXNGetDataEncoded()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetDataEncoded(iTXNObject: TXNObject; iStartOffset: TXNOffset; iEndOffset: TXNOffset; VAR oDataHandle: Handle; iEncoding: TXNDataType): OSStatus; C;


{
  *********************************************************************************************************
    Replace the specified range with the contents of the specified file.  The data fork of the file 
    must be opened by the caller.
    Input:
        iTXNObject:     opaque TXNObject obtained from  TXNNewObject
        fileSpec:   HFS file reference obtained when file is opened.
        fileType:   files type.
        iFileLength: The length of data in the file that should be considered data.  This
                     parameter is available to enable callers to embed text inside their
                     own private data structures.  Note that if the data is in the Textension(txtn)
                     format this parameter is ignored since length, etc. information is
                     part of the format. Further note that if you you just want Textension
                     to read a file and you are not interested in embedding you can just pass
                     kTXNEndOffset(0x7FFFFFFF), and Textension will use the file manager to
                     determine the files length.
        iStartOffset:   start position at which to insert the file into the document.
        iEndOffset:     end position of range being replaced by the file.
    Output:
        OSStatus:   File manager error or noErr.
  ***********************************************************************************************************
}
{
 *  TXNSetDataFromFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetDataFromFile(iTXNObject: TXNObject; iFileRefNum: SInt16; iFileType: OSType; iFileLength: ByteCount; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;


{
 *  TXNSetData()
 *  
 *  Summary:
 *    Replaces a range of data (text, graphics, and so forth).
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      The text object that identifies the document in which you want
 *      to replace data.
 *    
 *    iDataType:
 *      The type of the replacement data. See “Supported Data Types”
 *      for a description of possible values.
 *    
 *    iDataPtr:
 *      A pointer to the data that will replace the data that is in the
 *      range specified by the iStartOffset and iEndOffset parameters. 
 *      Can be NULL if the start and end offsets are different.
 *    
 *    iDataSize:
 *      The size of the data to which iDataPtr points.
 *    
 *    iStartOffset:
 *      The beginning of the range of data to replace. You can use the
 *      TXNGetSelection function to get the absolute offsets of the
 *      current selection.
 *    
 *    iEndOffset:
 *      The end of the range to replace. You can use the
 *      TXNGetSelection function to get the absolute offsets of the
 *      current selection. If you want to insert text, the ending and
 *      starting offsets should be the same value.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetData(iTXNObject: TXNObject; iDataType: TXNDataType; iDataPtr: UNIV Ptr; iDataSize: ByteCount; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;

{
  ************************************************************************************************************                          
    Retrieve number of times document has been changed.  That is for every committed command 
    (keydown, cut, copy) the value returned is count of those. This is useful for deciding if  the Save 
    item in the File menu should be active.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
                            
    Output:
        ItemCount:  count of changes.  This is total changes since document  was created or last saved.  
                    Not count since this routine was last called or anything like that.
  ***********************************************************************************************************
}
{
 *  TXNGetChangeCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetChangeCount(iTXNObject: TXNObject): ItemCount; C;


{
  *********************************************************************************************************
    Save the contents of the document as the given type. 
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iType:              The type of file to create.
        iResType:           When saving file as plain TEXT the type of resource to
                            save style information.  Use kTXNMultipleStylesPerTextDocumentResType
                            if your document contains multiple styles and you want a SimpleText
                            like document.  Use kTXNSingleStylePerTextDocumentResType if the 
                            document has a single style and you would like a BBEdit, MPW, CW type
                            of document.
        iPermanentEncoding: The encoding in which the document should be saved (Unicode, Text or System
                            default).
        iFileSpecification:  The file specification to which the document should be saved. The
                             file must have been opened by the caller.  The file specification is remembered by the TXNObject
                             and is used for any subsequent calls to TXNRevert.
        iDataReference:     The data fork ref num.  This is used to write data to the data fork of the
                            file. The data is written beginning at the current mark.  
        iResourceReference: The resource fork ref num.  If the caller has specified that style information be
                            saved as a resource (MPW or SimpleText) than this should be a valid reference to
                            an open resource fork.  If the txtn format is being used than this input value
                            is ignored.
    Output:
        OSStatus        The result of writing the file.
  **********************************************************************************************************    
}
{
 *  TXNSave()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSave(iTXNObject: TXNObject; iType: TXNFileType; iResType: OSType; iPermanentEncoding: TXNPermanentTextEncodingType; {CONST}VAR iFileSpecification: FSSpec; iDataReference: SInt16; iResourceReference: SInt16): OSStatus; C;


{
  ***********************************************************************************************************
    Revert  to the last saved version of this document.  If the file was not previously saved the document
    is reverted to an empty document.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject
    Output:
        OSStatus:   File manager errors, paramErr, or noErr.
  **********************************************************************************************************                    
}
{
 *  TXNRevert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNRevert(iTXNObject: TXNObject): OSStatus; C;


{
  *********************************************************************************************************                 
    Display the Page Setup dialog of the current default printer and react to any changes 
    (i.e. Reformat the text if the page layout changes.)
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject.
    
    Output:
        OSStatus:   Print Manager errors, paramErr, noErr.
  **********************************************************************************************************
}
{
 *  TXNPageSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNPageSetup(iTXNObject: TXNObject): OSStatus; C;


{
  **********************************************************************************************************
    Print the document.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject.
    Output:
        OSStatus:   Print Manager errors, paramErr, noErr.
  **********************************************************************************************************
}
{
 *  TXNPrint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNPrint(iTXNObject: TXNObject): OSStatus; C;


{
  ***********************************************************************************************************                           
    Test to see if the current scrap contains data that is supported by Textension.  Used to determine
    if Paste item in Edit menu should be active or inactive. The types of data supported depends on what 
    data types were specified in the TXNInitTextension options.
    Output:
        Boolean:        function result.  True if data type in Clipboard is supported.  False if 
                        not a supported data type.  If result is True the Paste item in the menu can 
                        be highlighted.
  **********************************************************************************************************
}
{
 *  TXNIsScrapPastable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNIsScrapPastable: BOOLEAN; C;


{
  ***********************************************************************************************************
    Convert the Textension private scrap to the public clipboard.  This should be called on suspend 
    events and before the application displays a dialog that might support cut and paste.  Or more 
    generally, whenever someone other than the Textension Shared Library needs access to the scrap data.
    Output:
         OSStatus:  Function result.  Memory Manager errors, Scrap Manager errors, noErr.
  ************************************************************************************************************                          
}
{
 *  TXNConvertToPublicScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNConvertToPublicScrap: OSStatus; C;


{
  ***********************************************************************************************************
    Convert the  public clipboard to our private scrap .  This should be called on resume 
    events and after an application has modified the scrap. Before doing work we check the validity of the public 
    scrap (date modification and type)
    Output:
         OSStatus:  Function result.  Memory Manager errors, Scrap Manager errors, noErr.
  ************************************************************************************************************  
}
{
 *  TXNConvertFromPublicScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNConvertFromPublicScrap: OSStatus; C;


{
  ************************************************************************************************************
    Get the  rectangle describing the current view into the document. The coordinates of this rectangle will be 
    local to the the window.
    Input:
        iTXNObject:     opaque TXNObject obtained from TXNNewObject.
    Output:
        oViewRect:      the requested view rectangle.
  *************************************************************************************************************
}
{
 *  TXNGetViewRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNGetViewRect(iTXNObject: TXNObject; VAR oViewRect: Rect); C;


{
  *************************************************************************************************                         
   Set the rectangle describing the current view into the document. This
   will change how much text is viewable.  Not where a line of text wraps.
   That is controlled by TXNSetFrameBoundsSize.
   Input:
        iTXNObject :    opaque Textension structure.
        
        iViewRect:      Rect of the view
         
    
  *************************************************************************************************
}
{
 *  TXNSetViewRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.3 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE TXNSetViewRect(iTXNObject: TXNObject; {CONST}VAR iViewRect: Rect); C;


{
  ***********************************************************************************************************
    Find a piece of text or a graphics object.
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iMatchTextDataPtr   ptr to a MatchTextRecord which contains the text to match, the length of that text
                            and the TextEncoding the text is encoded in.  This must be there if you are looking
                            for Text, but can be NULL if you are looking for a graphics object.
        iDataType           The type of data to find.  This can be any of the types defined in TXNDataType enum
                            (TEXT, PICT, moov, snd ).  However, if PICT, moov, or snd is passed then the default
                            behavior is to match on any non-Text object.  If you really want to find a specific
                            type you can provide a custom find callback or ignore matches which aren't the precise
                            type you are interested in.
        iStartSearchOffset  The offset at which a search should begin. The constant kTXNStartOffset specifies the start
                            of the objects data.
        iEndSearchOffset    The offset at which the search should end. The constant kTXNEndOffset specifies the end
                            of the objects data.
        iFindProc           A custom callback.  If will be called to match things rather than the default matching
                            behavior.
        iRefCon             This can be use for whatever the caller likes.  It is passed to the FindProc (if a FindProc
                            is provided.
    Output:
        oStartMatchOffset   absolute offset to start of match.  set to 0xFFFFFFFF if not match.
        oEndMatchOffset     absolute offset to end of match.  Set to 0xFFFFFFFF is no match.
    The default matching behavior is pretty simple for Text a basic binary compare is done.  If the matchOptions say 
    to ignore case the characters to be searched are duplicated and case neutralized.  This naturally can fail due
    to lack of memory if there is a large amount of text.  It also slows things down.  If MatchOptions say
    find an entire word that once a match is found an effort is made to determine if the match is a word.  The default
    behavior is to test the character before and after the to see if it is White space.  If the kTXNUseEncodingWordRulesBit
    is set than the Script Manager's FindWord function is called to make this determination.
    If the caller is looking for a non-text type than each non-text type in the document is returned.
    If more elaborate ( a regular expression processor or whatever ) is what you want then that is what the FindProc is
    for.
  *******************************************************************************************************************
}
{
 *  TXNFind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNFind(iTXNObject: TXNObject; iMatchTextDataPtr: {Const}TXNMatchTextRecordPtr; iDataType: TXNDataType; iMatchOptions: TXNMatchOptions; iStartSearchOffset: TXNOffset; iEndSearchOffset: TXNOffset; iFindProc: TXNFindUPP; iRefCon: SInt32; VAR oStartMatchOffset: TXNOffset; VAR oEndMatchOffset: TXNOffset): OSStatus; C;


{
  ***************************************************************************************************************
   TXNSetFontDefaults
    
   For a given TXNObject specify the font defaults for each script.
   Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iCount:             count of FontDescriptions.
        iFontDefaults:      array of FontDescriptins.
   Output:
        OSStatus:           function result ( memory error, paramErr )
  ****************************************************************************************************************
}
{
 *  TXNSetFontDefaults()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetFontDefaults(iTXNObject: TXNObject; iCount: ItemCount; VAR iFontDefaults: TXNMacOSPreferredFontDescription): OSStatus; C;


{
  ***************************************************************************************************************
   TXNGetFontDefaults
    
   For a given TXNObject make a copy of the font defaults.
   Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iCount:             count of FontDescriptions in the array.
        iFontDefaults:      array of FontDescriptins to be filled out.
   Output:
        OSStatus:           function result ( memory error, paramErr )
    To determine how many font descriptions need to be in the array you should call this function with
    a NULL for the array.  iCount will return with the number of font defaults currently stored.
  ****************************************************************************************************************
}
{
 *  TXNGetFontDefaults()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetFontDefaults(iTXNObject: TXNObject; VAR ioCount: ItemCount; ioFontDefaults: TXNMacOSPreferredFontDescriptionPtr): OSStatus; C;


{
  ****************************************************************************************************************
    TXNAttachObjectToWindow
    If a TXNObject was initialized with a NULL window pointer use this function
    to attach a window to that object.  In version 1.0 of Textension attaching
    a TXNObject to more than one window is not supported.
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iWindow:            GWorldPtr that the object should be attached to
        iIsActualWindow:    Let the library know if the GWorldPtr is actually
                            a WindowRef or actually a GWorldPtr.  This is important
                            if the client is taking advantage of the editing packages
                            scrollbar support.
    Output:
        OSStatus:           function result (kObjectAlreadyAttachedToWindowErr, paramErr )
  ****************************************************************************************************************
}
{
 *  TXNAttachObjectToWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNAttachObjectToWindow(iTXNObject: TXNObject; iWindow: GWorldPtr; iIsActualWindow: BOOLEAN): OSStatus; C;


{
  ****************************************************************************************************************
    TXNIsObjectAttachedToWindow
    A utility function that allows a caller to check a TXNObject to see if it is attached
    to a window.
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
    Output:
        Boolean:            function result.  True is object is attached.
                            False if TXNObject is not attached.
  ****************************************************************************************************************
}
{
 *  TXNIsObjectAttachedToWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNIsObjectAttachedToWindow(iTXNObject: TXNObject): BOOLEAN; C;


{
  ****************************************************************************************************************
    TXNDragTracker
    If you ask that Drag handling procs not be installed.  Call this when your drag tracker is called
    and you want Textension to take over
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iTXNFrameID:            TXNFrameID obtained from TXNNewObject
        iMessage:           drag message obtained from Drag Manager
        iWindow :           WindowRef obtained from Drag Manager
        iDragReference:     dragReference obtained from Drag Manager
        iDifferentObjectSameWindow: Pass true if the drag is still in the same window
                                   that it started in. False if the drag has moved into
                                   a different window.
    Output:
        OSErr:              function result.  OSErr is used over
                            OSStatus so that it matches the Drag Manager definition of Tracking callback
  ****************************************************************************************************************
}
{
 *  TXNDragTracker()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDragTracker(iTXNObject: TXNObject; iTXNFrameID: TXNFrameID; iMessage: DragTrackingMessage; iWindow: WindowRef; iDragReference: DragReference; iDifferentObjectSameWindow: BOOLEAN): OSErr; C;


{
  ****************************************************************************************************************
    TXNDragReceiver
    If you ask that Drag handling procs not be installed.  Call this when your drag receiver is called
    and you want Textension to take over
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iTXNFrameID         TXNFrameID obtained from TXNNewObject
        iWindow             WindowRef obtained from Drag Manager
        iDragReference      dragReference obtained from Drag Manager
        iDifferentObjectSameWindow: Pass true if the drag is still in the same window
                                   that it started in. False if the drag has moved into
                                   a different window.
    Output:
        OSErr:              function result.  OSErr is used over
                            OSStatus so that it matches the Drag Manager definition of Tracking callback
  ****************************************************************************************************************
}
{
 *  TXNDragReceiver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDragReceiver(iTXNObject: TXNObject; iTXNFrameID: TXNFrameID; iWindow: WindowRef; iDragReference: DragReference; iDifferentObjectSameWindow: BOOLEAN): OSErr; C;


{
  ****************************************************************************************************************
    TXNActivate
    Make the TXNObject object active in the sense that it can be scrolled if it has scrollbars.  If the TXNScrollBarState parameter
    is true than the scrollbars will be active even when the TXNObject is not focused (i.e. insertion point not active)
    
    This function should be used if you have multiple TXNObjects in a window, and you want them all to be scrollable
    even though only one at a time can have the keyboard focus.
    Input:
        iTXNObject:         opaque TXNObject obtained from TXNNewObject.
        iTXNFrameID         TXNFrameID obtained from TXNNewObject
        iActiveState        Boolean if true Scrollbars active even though TXNObject does not have the keyboard focus.  
                            if false scrollbars are synced with active state (i.e. a focused object has an
                            active insertion point or selection and active scrollbars. An unfocused object has inactive
                            selection (grayed or framed selection) and inactive scrollbars.  The latter state is the 
                            default and usually the one you use if you have one TXNObject in a window.
    Output:
        OSStatus:           function result.  ParamErr if bad iTXNObject or frame ID.
  ****************************************************************************************************************
}
{
 *  TXNActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNActivate(iTXNObject: TXNObject; iTXNFrameID: TXNFrameID; iActiveState: ByteParameter): OSStatus; C;


{
  *****************************************************************************************************************
    TXNSetBackgound
    Set the type of background the TXNObject's text, etc. is drawn onto.  At this point the background
    can be a color or a picture.  
    
    Input:
        iTXNObject:         opaque TXNObject obtained from IncomingDataFilter callback.
        iBackgroundInfo:    struct containing information that describes the background
    Output:
        OSStatus:           function result.  paramErrs.
  ********************************************************************************************************************
}
{
 *  TXNSetBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNSetBackground(iTXNObject: TXNObject; {CONST}VAR iBackgroundInfo: TXNBackground): OSStatus; C;


{
  *****************************************************************************************************************
    TXNEchoMode
    Put the TXNObject into echo mode.  What that means is that all characters in the TXNObject have the character
    'echoCharacter' substituted for the actual glyph when drawing occurs. Note that the echoCharacter is typed
    as a UniChar, but this is done merely to facilitate passing any 2 byte character.  The encoding parameter
    actually determines the encoding used to locate a font and display a character.  Thus if you wanted to
    display the diamond found in the Shift-JIS encoding for MacOS you would pass in 0x86A6 for the character
    but an encoding that was built to represent the MacOS Japanese encoding.
    
    Input:
        iTXNObject:         opaque TXNObject obtained from IncomingDataFilter callback.
        iEchoCharacter:     character to use in substitution
        iEncoding:          encoding from which character is drawn.
        iOn:                true if turning EchoMode on.  False if turning it off.
    Output:
        OSStatus:           function result.  paramErrs.
  ********************************************************************************************************************
}
{
 *  TXNEchoMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNEchoMode(iTXNObject: TXNObject; iEchoCharacter: UniChar; iEncoding: TextEncoding; iOn: BOOLEAN): OSStatus; C;


{
  ********************************************************************************************************************
    TXNNewFontMenuObject
    Get a FontMenuObject.  Caller can extract a fontmenu from this object and pass this object to the active
    TXNObject to handle events in the font menu.
    Input:
        iFontMenuHandle:    An empty menu handle (well the title is there) that the caller created via
                            NewMenu or GetNewMenu. This menu handle should not be disposed before
                            the returned TXNFontMenuObject has been disposed via TXNDisposeFontMenuObject.
        iMenuID:            The MenuID for iFontMenuHandle.
        iStartHierMenuID:   The first MenuID to use if any hierarchical menus need to be created. TXNNewFontMenuObject
                            uses SetMenuItemHierarchicalID when creating hierarchial menus.  The iStartHierMenuID must
                            therefor follow the rules for this function.  On systems less than system 8.5 the submenuID
                            must be less than 255.  For systems above system 8.5 the range can be as large can be as large
                            32767.  However, it is important to remember that TXNNewFontMenuObject only uses iStartHierMenuID
                            as a starting id when adding hierarchical menus.  Therefore provide plenty of room to increment
                            this value. For example, on a system less than 8.5 it would be good to start at 175.  On systems greater
                            than 8.5 it is probably a good idea to not use a value higher than 32000. 
        
    Output:
        OSStatus:           function result.  memory, parameter errors.
        TXNFontMenuObject:  A font menu object
  *********************************************************************************************************************
}
{
 *  TXNNewFontMenuObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNNewFontMenuObject(iFontMenuHandle: MenuRef; iMenuID: SInt16; iStartHierMenuID: SInt16; VAR oTXNFontMenuObject: TXNFontMenuObject): OSStatus; C;


{
  *********************************************************************************************************************
    TXNGetFontMenuHandle
    Get the MenuRef from the TXNFontMenuObject.
    Input:
        iTXNFontMenuObject:     A Font Menu Object obtained from TXNNewFontMenuObject.
    Output:
        OSStatus:           function result. parameter errors.
        oFontMenuHandle:    The returned font menu. (returned value could be NULL)
  *********************************************************************************************************************
}
{
 *  TXNGetFontMenuHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetFontMenuHandle(iTXNFontMenuObject: TXNFontMenuObject; VAR oFontMenuHandle: MenuRef): OSStatus; C;


{
  *********************************************************************************************************************
    TXNDisposeFontMenuObject
    Dispose a TXNFontMenuObject and its font menu handle
    Input:
        iTXNFontMenuObject:     A Font Menu Object obtained from TXNNewFontMenuObject.
    Output:
        OSStatus:   function result. parameter errors.
  *********************************************************************************************************************
}
{
 *  TXNDisposeFontMenuObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDisposeFontMenuObject(iTXNFontMenuObject: TXNFontMenuObject): OSStatus; C;


{
  *********************************************************************************************************************
    TXNDoFontMenuSelection
        Given the menuID and menu item returned by MenuSelect determine the selected font
        and change the current selection to be that Font.  If the input TXNObject is
        not active a parameter error is returned.
    Input:
        iTXNObject: An opaque TXNObject obtained from TXNNewObject.
        iTXNFontMenuObject:     A Font Menu Object obtained from TXNNewFontMenuObject.
        iMenuID:    SInt16 the ID of the selected menu.
        iMenuItem:  The item that was selected.
    Output:
        OSStatus:   ParamErr and memory errors are possible.
  **********************************************************************************************************************
}
{
 *  TXNDoFontMenuSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDoFontMenuSelection(iTXNObject: TXNObject; iTXNFontMenuObject: TXNFontMenuObject; iMenuID: SInt16; iMenuItem: SInt16): OSStatus; C;


{
 *  TXNPrepareFontMenu()
 *  
 *  Summary:
 *    Prepares a Font menu for display.
 *  
 *  Discussion:
 *    You should call the TXNPrepareFontMenu function just before your
 *    application opens the Font menu for your user. If the text
 *    object’s current selection is a single font, MLTE places a
 *    checkmark next to the menu item for that font.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      The text object that identifies the document with the Font menu
 *      you want to prepare. Pass NULL to display an inactive menu
 *      (dimmed).
 *    
 *    iTXNFontMenuObject:
 *      A Font menu object.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNPrepareFontMenu(iTXNObject: TXNObject; iTXNFontMenuObject: TXNFontMenuObject): OSStatus; C;


{
  **********************************************************************************************************************
    TXNVersionInformation
        Get the version number and a set of feature bits.  TXNVersionValue uses a NumVersion structure.
        See MacTypes.h for the format of the version.  Currently there are two feature bits:  one for 
        ATSUI default, another one for CarbonEvent default.
    Input:
        NONE
        
    Output:
        TXNVersionValue:    Current version.
        TXNFeatureBits*:    Pointer to a bit mask.  See TXNFeatureMask enum above. If kTXNWillDefaultToATSUIBit
                            is set it means that by default MLTE will use ATSUI to image and measure text and will
                            default to using Unicode to store characters.  If kTXNWillDefaultToCarbonEventBit is set,
                            then MLTE will use carbon events by default and apple event will not be supported.
  **********************************************************************************************************************
}
{
 *  TXNVersionInformation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNVersionInformation(VAR oFeatureFlags: TXNFeatureBits): TXNVersionValue; C;

{
  ****************************************************************************************
    TXNPointToOffset
        
    
    Input:
        iTXNObject: An opaque TXNObject obtained from TXNNewObject.
        iPoint:     a point (in local coord.)
    Output:
        TXNOffset   :   Offset corresponding to the point
        OSStatus:   Memory, out of bounds errors.(if the point is out of the ViewRect)
  ****************************************************************************************
}
{
 *  TXNPointToOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNPointToOffset(iTXNObject: TXNObject; iPoint: Point; VAR oOffset: TXNOffset): OSStatus; C;


{
  ****************************************************************************************
    TXNOffsetToPoint
        
    
    Input:
        iTXNObject: An opaque TXNObject obtained from TXNNewObject.
        iOffset:    an offset
    Output:
        Point   :   Point corresponding to the offset iOffset.
        OSStatus:   Memory, out of bounds errors.
  ****************************************************************************************
}
{
 *  TXNOffsetToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNOffsetToPoint(iTXNObject: TXNObject; iOffset: TXNOffset; VAR oPoint: Point): OSStatus; C;


{
  ****************************************************************************************
    TXNDrawUnicodeTextBox
        Draws an unicode string in the specified rectangle. Client is supposed to do an
        eraseRect if needed. The drawing will be clipped to the rect unless the client specifies
        a rotation.
        Use kTXNUseVerticalTextMask to display text vertically (no need to use the kRotate flag in this case
    
    Input:
        iText       :   Ptr to an unicode string (UTF16 chars)
        iLen        :   number of UniChars. (this is not the size of Ptr)
        ioBox       :   Text box where the text will be displayed
        iStyle      :   Optional - Style to use to display the text 
                        (if NULL is passed, we'll use whatever is in the current grafport)
        iOptions    :   Optional - check the struct at the beginning of this file.
    Output:
        ioBox   :   iobox.bottom will be updated to reflect the total height of the text
                    (iobox.left will be updated if kTXNUseVerticalTextMask is used)
        OSStatus:   Memory errors.
  ****************************************************************************************
}
{
 *  TXNDrawUnicodeTextBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDrawUnicodeTextBox({CONST}VAR iText: UniChar; iLen: UniCharCount; VAR ioBox: Rect; iStyle: ATSUStyle; ioOptions: TXNTextBoxOptionsDataPtr): OSStatus; C;


{
  ****************************************************************************************
    TXNDrawCFStringTextBox
        Same as TXNDrawUnicodeTextBox above.  The obvious difference is that the text
        parameter is a CFStringRef.
    
    Input:
        iText       :   A CFStringRef. See CFBase.h and CFString.h
        ioBox       :   Text box where the text has to be displayed
        iStyle      :   Optional - Style to use to display the text 
                        (if NULL is passed, we'll use whatever is in the current grafport)
        iOptions    :   Optional - check the struct at the beginning of this file.
    Output:
        ioBox   :   iobox.bottom will be updated to reflect the total height of the text
                    (iobox.left will be updated if kTXNUseVerticalTextMask is used)
        OSStatus:   Memory errors.
  ****************************************************************************************
}
{
 *  TXNDrawCFStringTextBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNDrawCFStringTextBox(iText: CFStringRef; VAR ioBox: Rect; iStyle: ATSUStyle; ioOptions: TXNTextBoxOptionsDataPtr): OSStatus; C;


{
  ***************************************************************************************************************
    TXNGetLineCount
    Get the total number of lines in the TXNObject.
    Input:
        iTXNObject:         opaque TXNObject.
    Output:
        OSStatus:           error.  (ParamErr for invalid TXNObject)
        oLineTotal          total number of lines in the object (0 based)
  ***************************************************************************************************************
}
{
 *  TXNGetLineCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetLineCount(iTXNObject: TXNObject; VAR oLineTotal: ItemCount): OSStatus; C;

{
  ***************************************************************************************************************
    TXNGetLineMetrics
    Get the metrics for the specified line.
    Input:
        iTXNObject:         opaque TXNObject.
        iLineNumber:        the line we want the metrics from. (0 based)
    Output:
        OSStatus:           error.  (ParamErr for invalid TXNObject or invalid line)
        oLineWidth          Line Width (fixed)
        oLineHeight         Line Height (ascent+descent)
  ***************************************************************************************************************
}
{
 *  TXNGetLineMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNGetLineMetrics(iTXNObject: TXNObject; iLineNumber: UInt32; VAR oLineWidth: Fixed; VAR oLineHeight: Fixed): OSStatus; C;

{
 *  TXNGetActionChangeCount()
 *  
 *  Discussion:
 *    Retrieves the number of times the specified action(s) have
 *    occurred. Explicit call to TXNClearActionChangeCount is needed
 *    when the counter(s) have to be reset.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      Opaque TXNObject obtained from TXNNewObject.
 *    
 *    iOptions:
 *      Specify the the type of action changes to be include when
 *      retrieving the count.  Choose from the TXNOptions.
 *    
 *    oCount:
 *      The number of counts returned by the function.
 *  
 *  Result:
 *    errors
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.3 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION TXNGetActionChangeCount(iTXNObject: TXNObject; iOptions: TXNCountOptions; VAR oCount: ItemCount): OSStatus; C;


{
 *  TXNClearActionChangeCount()
 *  
 *  Discussion:
 *    Reset the specified action counter(s) to zero. Use kAllCountMask
 *    to reset everything.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      Opaque TXNObject obtained from TXNNewObject.
 *    
 *    iOptions:
 *      Specify the the type of action changes to be include when
 *      resetting the count.  Choose from the TXNOptions.
 *  
 *  Result:
 *    errors
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.3 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION TXNClearActionChangeCount(iTXNObject: TXNObject; iOptions: TXNCountOptions): OSStatus; C;


{
 *  TXNIsObjectAttachedToSpecificWindow()
 *  
 *  Discussion:
 *    A utility function that allows a caller to check a TXNObject to
 *    see if it is attached to a specific window.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      Opaque TXNObject obtained from TXNNewObject.
 *    
 *    iWindow:
 *      The window to check attachment against.
 *    
 *    oAttached:
 *      true if the object is attached to the given window, false
 *      otherwise.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Textension 1.2 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TXNIsObjectAttachedToSpecificWindow(iTXNObject: TXNObject; iWindow: WindowRef; VAR oAttached: BOOLEAN): OSStatus; C;

{
 *  TXNSetRectBounds()
 *  
 *  Discussion:
 *    Set the View rectangle and or the Destination rectangle.  The
 *    View rectangle controls the text you see.  The Destination
 *    rectangle controls how text is laid out.  The Scrollbar is drawn
 *    inside the View rectangle.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      Opaque TXNObject obtained from TXNNewObject.
 *    
 *    iViewRect:
 *      The new view rectangle.  If you do not want to change the view
 *      rectangle pass NULL.
 *    
 *    iDestinationRect:
 *      The new destination rectangle.  Pass NULL if you don't want to
 *      change the destination retangle.
 *    
 *    iUpdate:
 *      If you would like the the text and where the scrollbars are
 *      placed recalculated and redrawn pass true.  If you prefer to
 *      wait on this pass false.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
PROCEDURE TXNSetRectBounds(iTXNObject: TXNObject; iViewRect: {Const}RectPtr; iDestinationRect: {Const}TXNLongRectPtr; iUpdate: BOOLEAN); C;

{
 *  TXNGetRectBounds()
 *  
 *  Discussion:
 *    Get the values for the current View rectangle, destination
 *    rectangle and text rectangle.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      Opaque TXNObject obtained from TXNNewObject.
 *    
 *    oViewRect:
 *      The current view rectangle
 *    
 *    oDestinationRect:
 *      The current destination rectangle
 *    
 *    oTextRect:
 *      The smallest rectangle needed to contain the current text. 
 *      This rectangle is calculated by walking the lines of text and
 *      measuring each line.  So this can be expensive.  The width of
 *      this rectangle will be the width of the longest line in the
 *      text.
 *  
 *  Result:
 *    errors
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION TXNGetRectBounds(iTXNObject: TXNObject; oViewRect: RectPtr; oDestinationRect: TXNLongRectPtr; oTextRect: TXNLongRectPtr): OSStatus; C;


{
 *  TXNRecalcTextLayout()
 *  
 *  Discussion:
 *    Call this if you called TXNSetRectBounds with the iUpdate
 *    parameter set to false. This function will recalculate the text
 *    layout based on the view and destination rectangles you set.  It
 *    will also recalcuate where the scrollbars if any should be
 *    placed. Finally an update event will be generated so that the
 *    TXNObject is redrawn.
 *  
 *  Parameters:
 *    
 *    iTXNObject:
 *      Opaque TXNObject obtained from TXNNewObject.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.5 and later
 *    Mac OS X:         in version 10.1 and later
 }
PROCEDURE TXNRecalcTextLayout(iTXNObject: TXNObject); C;




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacTextEditorIncludes}

{$ENDC} {__MACTEXTEDITOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
