{
 	File:		MacTextEditor.p
 
 	Contains:	xxx put contents here xxx
 
 	Version:	Technology:	xxx put the technology version here xxx
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1996-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
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
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __AIFF__}
{$I AIFF.p}
{$ENDC}
{$IFC UNDEFINED __ATSUNICODE__}
{$I ATSUnicode.p}
{$ENDC}





{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



TYPE
	TXNObject = ^LONGINT; { an opaque 32-bit type }
	TXNFontMenuObject = ^LONGINT; { an opaque 32-bit type }
	TXNFrameID							= UInt32;
	TXNVersionValue						= UInt32;
	TXNFeatureBits						= OptionBits;

CONST
	kTXNWillDefaultToATSUIBit	= 0;


	kTXNWillDefaultToATSUIMask	= $00000001;



TYPE
	TXNInitOptions						= OptionBits;

CONST
	kTXNWantMoviesBit			= 0;
	kTXNWantSoundBit			= 1;
	kTXNWantGraphicsBit			= 2;
	kTXNAlwaysUseQuickDrawTextBit = 3;
	kTXNUseTemporaryMemoryBit	= 4;


	kTXNWantMoviesMask			= $00000001;
	kTXNWantSoundMask			= $00000002;
	kTXNWantGraphicsMask		= $00000004;
	kTXNAlwaysUseQuickDrawTextMask = $00000008;
	kTXNUseTemporaryMemoryMask	= $00000010;


TYPE
	TXNFrameOptions						= OptionBits;

CONST
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



TYPE
	TXNContinuousFlags					= OptionBits;

CONST
	kTXNFontContinuousBit		= 0;
	kTXNSizeContinuousBit		= 1;
	kTXNStyleContinuousBit		= 2;
	kTXNColorContinuousBit		= 3;

	kTXNFontContinuousMask		= $00000001;
	kTXNSizeContinuousMask		= $00000002;
	kTXNStyleContinuousMask		= $00000004;
	kTXNColorContinuousMask		= $00000008;


TYPE
	TXNMatchOptions						= OptionBits;

CONST
	kTXNIgnoreCaseBit			= 0;
	kTXNEntireWordBit			= 1;
	kTXNUseEncodingWordRulesBit	= 31;

	kTXNIgnoreCaseMask			= $00000001;
	kTXNEntireWordMask			= $00000002;
	kTXNUseEncodingWordRulesMask = $80000000;



TYPE
	TXNFileType							= OSType;

CONST
	kTXNTextensionFile			= 'txtn';
	kTXNTextFile				= 'TEXT';
	kTXNPictureFile				= 'PICT';
	kTXNMovieFile				= 'MooV';
	kTXNSoundFile				= 'sfil';
	kTXNAIFFFile				= 'AIFF';


TYPE
	TXNFrameType						= UInt32;

CONST
	kTXNTextEditStyleFrameType	= 1;
	kTXNPageFrameType			= 2;
	kTXNMultipleFrameType		= 3;



TYPE
	TXNDataType							= OSType;

CONST
	kTXNTextData				= 'TEXT';
	kTXNPictureData				= 'PICT';
	kTXNMovieData				= 'moov';
	kTXNSoundData				= 'snd ';
	kTXNUnicodeTextData			= 'utxt';



TYPE
	TXNControlTag						= FourCharCode;

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
	kTXNNoUserIOTag				= 'nuio';


TYPE
	TXNActionKey						= UInt32;

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



TYPE
	TXNTabType							= SInt8;

CONST
	kTXNRightTab				= -1;
	kTXNLeftTab					= 0;
	kTXNCenterTab				= 1;


TYPE
	TXNTabPtr = ^TXNTab;
	TXNTab = RECORD
		value:					SInt16;
		tabType:				TXNTabType;
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

	TXNScrollBarState					= BOOLEAN;

CONST
	kScrollBarsAlwaysActive		= true;
	kScrollBarsSyncWithFocus	= false;


	kTXNDontCareTypeSize		= $FFFFFFFF;
	kTXNDontCareTypeStyle		= $FF;
	kTXNIncrementTypeSize		= $00000001;
	kTXNDecrementTypeSize		= $80000000;


TYPE
	TXNOffset							= UInt32;

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

{  The full range of error codes assigned is -22000 through -22039 }

TYPE
	TXNErrors							= OSStatus;

CONST
	kTXNEndIterationErr			= -22000;
	kTXNCannotAddFrameErr		= -22001;
	kTXNInvalidFrameIDErr		= -22002;
	kTXNIllegalToCrossDataBoundariesErr = -22003;
	kTXNUserCanceledOperationErr = -22004;
	kTXNBadDefaultFileTypeWarning = -22005;
	kTXNCannotSetAutoIndentErr	= -22006;
	kTXNRunIndexOutofBoundsErr	= -22007;
	kTXNNoMatchErr				= -22008;
	kTXNAttributeTagInvalidForRunErr = -22009;					{ dataValue is set to this per invalid tag }
	kTXNSomeOrAllTagsInvalidForRunErr = -22010;
	kTXNInvalidRunIndex			= -22011;
	kTXNAlreadyInitializedErr	= -22012;
	kTXNCannotTurnTSMOffWhenUsingUnicodeErr = -22013;
	kTXNCopyNotAllowedInEchoModeErr = -22014;
	kTXNDataTypeNotAllowedErr	= -22015;


{ default constants for TXTNInit.   }
	kTXNDefaultFontName			= 0;
	kTXNDefaultFontSize			= $000C0000;
	kTXNDefaultFontStyle		= 0;


TYPE
	TXNTypeRunAttributes				= FourCharCode;

CONST
	kTXNQDFontNameAttribute		= 'fntn';
	kTXNQDFontFamilyIDAttribute	= 'font';
	kTXNQDFontSizeAttribute		= 'size';
	kTXNQDFontStyleAttribute	= 'face';
	kTXNQDFontColorAttribute	= 'klor';
	kTXNTextEncodingAttribute	= 'encd';
	kTXNATSUIFontFeaturesAttribute = 'atfe';
	kTXNATSUIFontVariationsAttribute = 'atva';


TYPE
	TXNTypeRunAttributeSizes			= ByteCount;

CONST
	kTXNQDFontNameAttributeSize	= 256;
	kTXNQDFontFamilyIDAttributeSize = 2;
	kTXNQDFontSizeAttributeSize	= 2;
	kTXNQDFontStyleAttributeSize = 1;
	kTXNQDFontColorAttributeSize = 6;
	kTXNTextEncodingAttributeSize = 4;


TYPE
	TXNPermanentTextEncodingType		= UInt32;

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
	TXNBackgroundType					= UInt32;

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

{$IFC TYPED_FUNCTION_POINTERS}
	TXNFindProcPtr = FUNCTION({CONST}VAR matchData: TXNMatchTextRecord; iDataType: TXNDataType; iMatchOptions: TXNMatchOptions; iSearchTextPtr: UNIV Ptr; encoding: TextEncoding; absStartOffset: TXNOffset; searchTextLength: ByteCount; VAR oStartMatch: TXNOffset; VAR oEndMatch: TXNOffset; VAR ofound: BOOLEAN; refCon: UInt32): OSStatus;
{$ELSEC}
	TXNFindProcPtr = ProcPtr;
{$ENDC}

	TXNFindUPP = UniversalProcPtr;

CONST
	uppTXNFindProcInfo = $0FFFFFF0;

FUNCTION NewTXNFindUPP(userRoutine: TXNFindProcPtr): TXNFindUPP; { old name was NewTXNFindProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeTXNFindUPP(userUPP: TXNFindUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeTXNFindUPP({CONST}VAR matchData: TXNMatchTextRecord; iDataType: TXNDataType; iMatchOptions: TXNMatchOptions; iSearchTextPtr: UNIV Ptr; encoding: TextEncoding; absStartOffset: TXNOffset; searchTextLength: ByteCount; VAR oStartMatch: TXNOffset; VAR oEndMatch: TXNOffset; VAR ofound: BOOLEAN; refCon: UInt32; userRoutine: TXNFindUPP): OSStatus; { old name was CallTXNFindProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{
  *****************************************************************************************************
   Allocates a new frame (i.e. new is called to allocate a TXNObject) and returns a pointer to the object 
   in the newDoc parameter.
   Input:
  		
  	fileSpec:	If not NULL the file is read to obtain the document contents  after the object is 
  				successfully allocated.  If NULL you start with an empty document.
  				
  	window:		Required.  The window in which the document is going to be  displayed.
  				
  	frame:		If text-area does not fill the entire window.  This specifies the area to fill.  Can be NULL.  
  				In  which case, the window’s portRect is used as the frame.
  								
  	frameOptions:	Specify the options to be supported by this frame.  The available options are support 
  					for cutting and pasting  movies and sound, handle scrollbars and handle grow box in  the 
  					frame.
  	fileType:	Specify the primary file type.  If you  use  kTextensionTextFile files will be saved 
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
  	creator:	Specify the creator to use  when saving files.
   
   Output:
  	
  	OSStatus:	function  result.  If anything goes wrong the error is returned.  Success must be complete.  
  				That is if everything  works, but there is a failure reading a specified file the  object 
  				is freed.
  	newDoc:		Pointer to the opaque datastructure allocated by the function.  Most of the subsequent 
  				functions require that such a pointer be passed in.
  				
  	FrameID:	Unique ID for the frame.
  **************************************************************************************************************
}

FUNCTION TXNNewObject(iFileSpec: {Const}FSSpecPtr; iWindow: WindowPtr; iFrame: RectPtr; iFrameOptions: TXNFrameOptions; iFrameType: TXNFrameType; iFileType: TXNFileType; iPermanentEncoding: TXNPermanentTextEncodingType; VAR oTXNObject: TXNObject; VAR oTXNFrameID: TXNFrameID; iRefCon: TXNObjectRefcon): OSStatus; C;

{
  *************************************************************************************************
   Delete a previously allocated TXNObject and all associated data structures.  If the frameType is 
   multiple frames all frames are released.
  		
   Input:
   	doc:	opaque structure to free.
  **************************************************************************************************
}
PROCEDURE TXNDeleteObject(iTXNObject: TXNObject); C;

{
  *************************************************************************************************							
   Changes the frame's size to match the new width and height.
   Input:
  	
  	doc:		opaque Textension structure.
  	
  	width:		New width in pixels.
  	
  	height:		New height in pixels.
  	
  	id:		FrameID that specifies the frame to move.
  *************************************************************************************************
}
PROCEDURE TXNResizeFrame(iTXNObject: TXNObject; iWidth: UInt32; iHeight: UInt32; iTXNFrameID: TXNFrameID); C;


{
  *************************************************************************************************							
   Changes the frame's bounds to match the Rect. 
   Input:
    	doc :								opaque Textension structure.
    	
    	(iTop, iLeft, iBottom, iRight):		Rect of the view
    	 
  	
  	id:		FrameID that specifies the frame to move.
  *************************************************************************************************
}
PROCEDURE TXNSetFrameBounds(iTXNObject: TXNObject; iTop: SInt32; iLeft: SInt32; iBottom: SInt32; iRight: SInt32; iTXNFrameID: TXNFrameID); C;

{
  ****************************************************************************************************
   	Initialize the Textension library.  Should be called as soon as possible after the Macintosh toolbox
  	is initialized.
   Input:
  	TXTMacOSPreferredFontDescription:		A table of font information including fontFamily ID, point size,
  											style, and script code. The table can be NULL or can have
  											an entry for any script for which you would like to to
  											designate a default font.  Only a valid script number is
  											required.  You can designate that Textension should use
  											the default for a give script by setting the field to -1.
  											
  											For example, if you wanted to specify New York as the default
  											font to use for Roman scripts, but were happy with the 
  											default style and size you would call the function like this:
  	
  	TXNMacOSPreferredFontDescription	defaults;
  	GetFNum( "\pNew York", &defaults.fontFamilyID );
  	defaults.pointSize = -1;
  	defaults.fontStyle = -1;
  	defaults.script = smRoman;
  	status = TXNInitTextension( &defaults, 1, 0 );
  	
  					
  							
  	usageFlags:		Specify whether sound and movies should be supported.
   Output:
  	OSStatus:		Function result.  NoErr if everything initialized correctly.  Variety of
  					possible MacOS errors if something goes wrong.
  *********************************************************************************************/
}
FUNCTION TXNInitTextension(iDefaultFonts: TXNMacOSPreferredFontDescriptionPtr; iCountDefaultFonts: ItemCount; iUsageFlags: TXNInitOptions): OSStatus; C;



{
  *************************************************************************************
   Close the Textension library.  It is necessary to call this function so that Textension 
   can correctly close down any TSM connections and do other clean up.
  **************************************************************************************
}
PROCEDURE TXNTerminateTextension; C;
{
  **************************************************************************************
  	Process a keydown event. Note that if CJK script is installed and current font is 
  	CJK inline input will take place. This is always the case unless the application has 
  	requested the bottomline window or has turned off TSM (see initialization options above).
  		
   Input:
  		doc:		opaque struct to apply keydown to.
  			
  		event:		the keydown event.	
  ***************************************************************************************
}
PROCEDURE TXNKeyDown(iTXNObject: TXNObject; {CONST}VAR iEvent: EventRecord); C;
{
  ***************************************************************************************
  	Handle switching the cursor.  If over text area set to i-beam.  Over graphics, sound,
  	movie, scrollbar or outside of window set to arrow.
  	
  	Input:
  		doc:			Opaque struct obtained from TXNNewObject.
  		cursorRgn:		Region to be passed to WaitNextEvent.  Resized  accordingly by 
  						TXNAdjustCursor.
  ***************************************************************************************
}

PROCEDURE TXNAdjustCursor(iTXNObject: TXNObject; ioCursorRgn: RgnHandle); C;
{
  ****************************************************************************************						
  	Process click in content region.  Takes care of scrolling, selecting text,  playing 
  	sound and movies, drag & drop, and double-clicks.
  	Input:
  		doc:		Opaque struct obtained from TXNNewObject.
  		event:		the mousedown event
  *****************************************************************************************
}
PROCEDURE TXNClick(iTXNObject: TXNObject; {CONST}VAR iEvent: EventRecord); C;

{
  ********************************************************************************************
  	Call this when WaitNextEvent returns false or there is no active TSNObject . 
  	The TXNObject parameter can be NULL which allows a client to call this function at any 
  	time.  This is necessary to insure input methods enough time to be reasonably responsive.
  	Input:
  		doc:			The currently active TXNObject or NULL.
  	Output:
  		Boolean:		True if TSM handled this event.  False if TSM did not handle this event.
  **********************************************************************************************
}
FUNCTION TXNTSMCheck(iTXNObject: TXNObject; VAR iEvent: EventRecord): BOOLEAN; C;


{
  ***********************************************************************************************						
  	Selects everything in a frame.
  	Input:
  		doc:	opaque TXNObject 
  ***********************************************************************************************	
}
PROCEDURE TXNSelectAll(iTXNObject: TXNObject); C;


{
  ***********************************************************************************************						
  	Focues the TXNObject.  Scrollbars and insertion point are made active  if iBecomingFocused
  	is true, and inactive if false.
  	
  	Input:
  		doc:			opaque TXNObject
  		
  		becomingActive:	true if becoming active.  false otherwise.
  ************************************************************************************************	
}
PROCEDURE TXNFocus(iTXNObject: TXNObject; iBecomingFocused: BOOLEAN); C;
{
  ************************************************************************************************						
  	Handle update event (i.e. draw everything in a frame.) This function calls the Toolbox
  	BeginUpdate - EndUpdate functions for the window that was passed to TXNNewObject.  This
  	makes it inappropriate for windows that contain something else besides the TXNObject.
  	Input:
  		doc:	opaque TXNObject 
  ************************************************************************************************
}
PROCEDURE TXNUpdate(iTXNObject: TXNObject); C;
{
  *************************************************************************************************
   	Redraw the TXNObject including any scrollbars associated with the text frame.  Call this function
  	in response to an update event for a window that contains multiple TXNObjects or some other graphic
  	element.  The caller is responsible for calling BeginUpdate/EndUpdate in response to the update
  	event.
  	Input:
  		doc:		opaque TXNObject to draw
  		iDrawPort:	Can be NULL. If NULL the port is drawn to the port currently attached to the 
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
PROCEDURE TXNDraw(iTXNObject: TXNObject; iDrawPort: GWorldPtr); C;
{
  *************************************************************************************************
  	Force a frame to be updated.  Very much like toolbox call InvalRect.
  	
  	Input:
  		doc:	opaque TXNObject 
  **************************************************************************************************						
}
PROCEDURE TXNForceUpdate(iTXNObject: TXNObject); C;

{
  **************************************************************************************************
  	Depending on state of window get the appropriate sleep time to be passed to WaitNextEvent.
  	Input:
  		doc:	opaque TXNObject obtained from TXNNewObject
  		
  	Output:
  	
  		UInt32:	function result appropriate sleep time.
  ***************************************************************************************************
}
FUNCTION TXNGetSleepTicks(iTXNObject: TXNObject): UInt32; C;
{
  ***************************************************************************************************
  	Do necessary Idle time processing. Typically flash the cursor. If a TextService is active
  	pass a NULL event to the Text Service so it gets  time.
  	Input:
  		doc:	opaque TXNObject obtained from TXNNewObject
  ****************************************************************************************************
}
PROCEDURE TXNIdle(iTXNObject: TXNObject); C;

{
  *********************************************************************************************************
  	Handle mouse-down in grow region. 
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  		event:		The mousedown event
  *********************************************************************************************************
}
PROCEDURE TXNGrowWindow(iTXNObject: TXNObject; {CONST}VAR iEvent: EventRecord); C;

{
  ********************************************************************************************************
  	Handle mousedown in zoom.
  	Input:
  		doc:		opaque TXNObject obtained from  TXNNewObject
  		part:		Value returned by FindWindow
  *********************************************************************************************************
}
PROCEDURE TXNZoomWindow(iTXNObject: TXNObject; iPart: INTEGER); C;

{
  *******************************************************************************************************
  	Use this to determine if the Undo item in Edit menu should be highlighted or not.  Tells you if last
  	command was undoable.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  	Output:
  		Boolean		function result.  If True the last command is undoable and the undo item in the menu 
  					should be active.  If false last command cannot be undone and undo should be grayed 
  					in the menu.
  		oTXNActionKey The key code that the caller can use to pick a string to describe the undoable
  					  action in the undo item.
  *********************************************************************************************************
}
FUNCTION TXNCanUndo(iTXNObject: TXNObject; VAR oTXNActionKey: TXNActionKey): BOOLEAN; C;
{
  ********************************************************************************************************
  	Undo the last command.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  *********************************************************************************************************
}
PROCEDURE TXNUndo(iTXNObject: TXNObject); C;
{
  *********************************************************************************************************
  	Use this to determine if the current item on the undo stack is redoable.  If it returns true.
  	than the redo item in the edit menu should be active.
  	
  	Input:
  		iTXNObject:		opaque TXNObject obtained from TXNNewObject.
  		oTXNActionKey The key code that the caller can use to pick a string to describe the redoable
  					  action in the redo item.
}

{ ********************************************************************************************************* }
FUNCTION TXNCanRedo(iTXNObject: TXNObject; VAR oTXNActionKey: TXNActionKey): BOOLEAN; C;
{
  ********************************************************************************************************
  	Redo the last command.
  	Input:
  		iTXNObject:		opaque TXNObject obtained from TXNNewObject
  *********************************************************************************************************
}
PROCEDURE TXNRedo(iTXNObject: TXNObject); C;


{
  *********************************************************************************************************
  	Cut the current selection to the clipboard.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  	Output:
  		OSStatus:	function result.  Variety of memory or scrap MacOS errors.
  **********************************************************************************************************
}
FUNCTION TXNCut(iTXNObject: TXNObject): OSStatus; C;



{
  *********************************************************************************************************
  	TXNCopy
  		Copy current selection
   
  	Input:
  		doc:			current document
  					
  **********************************************************************************************************						
}
FUNCTION TXNCopy(iTXNObject: TXNObject): OSStatus; C;


{
  ***********************************************************************************************************
  	TXNPaste
  		Paste the clipboard
   
  	Input:
  		doc:			current document
  					
  **********************************************************************************************************
}
FUNCTION TXNPaste(iTXNObject: TXNObject): OSStatus; C;


{
  **********************************************************************************************************
  	TXNClear
  		clear the current selection
   
  	Input:
  		doc:			current document
  					
  **********************************************************************************************************						
}
FUNCTION TXNClear(iTXNObject: TXNObject): OSStatus; C;

{
  *********************************************************************************************************
  	TXNGetSelectionRange
  		Get the absolute offsets of the current selection.  
  		Embedded graphics, sound, etc. each count as one character.
   
  	Input:
  		doc:			current document
  	
  	Output:
  		startOffset:	absolute beginning of the current selection.
  		endOffset:		end of current selection.
  *********************************************************************************************************						
}
PROCEDURE TXNGetSelection(iTXNObject: TXNObject; VAR oStartOffset: TXNOffset; VAR oEndOffset: TXNOffset); C;


{
  *****************************************************************************************************
  	Scroll the current selection into view.
  	Input:
  	 	doc: 		opaque TXNObject obtained from TXNNewObject
  	 	showEnd: 	If true the end of the selection is scrolled into view. If false the
  					beginning of selection is scrolled into view.
  ****************************************************************************************************						
}
PROCEDURE TXNShowSelection(iTXNObject: TXNObject; iShowEnd: BOOLEAN); C;


{
  *****************************************************************************************************
  	Call to find out if the current selection is empty. Use this to determine if Paste, Cut, Copy, 
  	Clear should be highlighted in Edit menu.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  	Output:
  		Boolean:	function result.  True if current selection is empty (i.e. start offset == end offset).  
  					False if selection is not empty.
  ********************************************************************************************************
}
FUNCTION TXNIsSelectionEmpty(iTXNObject: TXNObject): BOOLEAN; C;

{
  ********************************************************************************************************
  	Set the current selection. 
   
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  		startOffset:	new beginning
  		endOffset:		new end
  ********************************************************************************************************
}
FUNCTION TXNSetSelection(iTXNObject: TXNObject; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;

{
  *******************************************************************************************************
  	TXNGetContinuousTypeAttributes
  		Test the current selection to see if anything is continuous. 
  		That is is the current selection made up of
  		one font, one font size, one Style, and/or one color.  If
  		caller doesn't want to know exactly what is continuous
  		pass 0 for the ioCount parameter and NULL for the ioTypeAttributes.  The flags tell you
  		simply that something is continuous.
  	Input:
  		doc:				current document
  		continuousFlags:	Bits which can be examined to see which if any
  							of the font attributes are continuous
  							The return boolean indicates if anything is
  							continuous.  These bits are examined to see
  							what specifically is.
  							e.g 
  							if (  TXNAreFontAttributesContinuous( d, n, &sz, &st, &c, &f ) )
  							(
  									if ( f & kFontContinuousMask )
  										....check a font name
  		ioCount:			Count of TXNTypeAttributes records in the ioTypeAttributes array.
  		ioTypeAttributes:	Array of TXNTypeAttributes that indicates the type attributes the
  							caller is interested in.  For example, if you wanted to know if
  							the current selection was continuous in terms of being all
  							one QuickDraw font size you could do something like this.
  							
  							TXNTypeAttributes		attr[1] = ( TXNQDFontSizeAttribute, sizeof(SInt16),( 0 ) )
  							
  							on return  from the function if size is continuous then the third field (i.e.
  							attr.data.dataValue will contain the size of the font as a Fixed point value.
    
  								
  ***********************************************************************************************************
}
FUNCTION TXNGetContinuousTypeAttributes(iTxnObject: TXNObject; VAR oContinuousFlags: TXNContinuousFlags; ioCount: ItemCount; ioTypeAttributes: TXNTypeAttributesPtr): OSStatus; C;




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
  		doc:			current document
  		attrCount:		Count of type attributes in the TXNTypeAttributes array.
  		attributes:		Attributes that caller would like to set.
  	
  	Output:
  		OSStatus:			various MacOS  errs.  Notably memory manager and paramErrs.							
  *************************************************************************************************							
}
FUNCTION TXNSetTypeAttributes(iTXNObject: TXNObject; iAttrCount: ItemCount; VAR iAttributes: TXNTypeAttributes; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;


{
  **************************************************************************************************
  	Set  control information for a given TXNObject.
  	Input:
  	 	iTXNObject:  	opaque TXNObject obtained from TXNNewObject
  		iClearAll:		reset all controls to the default
  							justification = LMTESysJust
  							line direction = GetSysDirection()
  							etc.
  		iControlCount:	The number of TXNControlInfo records in the array.
  		iControlTags:	An array[iControlCount] of TXNObject control tags.
  	 	iControlInfo:  	An array of TXNControlData structures which specify the
  						type of information being set.
  	InputOutput:
  	 	OSStatus: 	paramErr or noErr.
  **************************************************************************************************								
}
FUNCTION TXNSetTXNObjectControls(iTXNObject: TXNObject; iClearAll: BOOLEAN; iControlCount: ItemCount; VAR iControlTags: TXNControlTag; VAR iControlData: TXNControlData): OSStatus; C;

{
  **************************************************************************************************
  	Get  control information for a given TXNObject.
  	Input:
  	 	iTXNObject:  	opaque TXNObject obtained from TXNNewObject
  		iControlCount:	The number of TXNControlInfo records in the array.
  		iControlTags:	An array[iControlCount] of TXNObject control tags.
  	Input/Output:
  	 	OSStatus: 		paramErr or noErr.
  	 	oControlData:  	An array of TXNControlData structures which are filled out. With
  						the information that was requested via the iControlTags array. The 
  						caller must allocate the array. 
  **************************************************************************************************								
}
FUNCTION TXNGetTXNObjectControls(iTXNObject: TXNObject; iControlCount: ItemCount; VAR iControlTags: TXNControlTag; VAR oControlData: TXNControlData): OSStatus; C;



{
  ******************************************************************************************************
  	TXNCountRunsInRange
  		Given a range specified by the starting and ending offset return a count of the runs in that
  		range.  Run in this case means changes in TextSyles or a graphic or sound.
  		Result:
  			OSStatus:		paramerr mostly
  		Input:
  			iTXNObject			The TXNObject you are interested in.
  			iStartOffset		start of range
  			iEndOffset			end of range
  		
  		Output:
  			oRunCount			count of runs in the range
  *******************************************************************************************************
}
FUNCTION TXNCountRunsInRange(iTXNObject: TXNObject; iStartOffset: UInt32; iEndOffset: UInt32; VAR oRunCount: ItemCount): OSStatus; C;
{
  *******************************************************************************************************
  	TXNGetIndexedRunInfoFromRange
  		Get information about the Nth run in a range.  Should call TXNCountRunsInRange to get the count
  		Result:
  			OSStatus		paramErr or kRunIndexOutofBoundsErr.
  		Input:
  			iTXNObject		Current TXNObject
  			iIndex			the index is 0 based.
  			iStartOffset	start of range
  			iEndOffset		end of range
  		Output:
  			oRunStartOffset		start of run.  This is relative to the beginning of the text not the range
  			oRunEndOffset		end of run.
  			oCollection			Collection containing tagged data describing this run.  Text information
  								will include TXNTypeRunAttributes on a QD system and ATSUI attributes see ATSUnicode.h
  								on a system with unicode imaging capabilities. It is the callers responsibility to
  								dispose of the collection.  It is legal to pass NULL for a collection or for the
  								run offsets.
  *******************************************************************************************************
}
FUNCTION TXNGetIndexedRunInfoFromRange(iTXNObject: TXNObject; iIndex: ItemCount; iStartOffset: UInt32; iEndOffset: UInt32; VAR oRunStartOffset: UInt32; VAR oRunEndOffset: UInt32; VAR oRunDataType: TXNDataType; iTypeAttributeCount: ItemCount; VAR oTypeAttributes: TXNTypeAttributes): OSStatus; C;





{
  **********************************************************************************************************
  	TXNDataSize
  	Return the size in bytes of the characters in a given TXNObject.
  	Result:
  		ByteCount:			The bytes required to hold the characters
  	Input:
  		iTXNObject:			The TXNObject
  	
  **********************************************************************************************************
}

FUNCTION TXNDataSize(iTXNObject: TXNObject): ByteCount; C;

{
  ***********************************************************************************************************
  	Copy the data in the range specified by startOffset and endOffset. This function should be used
  	in conjunction with TXNNextDataRun.  The client would call TXNNextDataRun to determine data runs 
  	and there size.  For each data run of interest (i.e. one whose data the caller wanted to look at) 
  	the client would call TXNGetData. The handle passed to TXNGetData should not be allocated.  
  	TXNGetData takes care of allocating the dataHandle as necessary.  However, the caller is  responsible 
  	for disposing the handle.  
  	No effort is made to insure that data copies align on a word boundary.  Data is simply copied as
  	specified in the offsets.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject.
  		startOffset:	absolute offset from which data copy should begin.
  		endOffset:	absolute offset at which data copy should end.
  						
  	Output:
  		OSStatus	Memory errors or  TXN_IllegalToCrossDataBoundaries if offsets specify a range that 
  				crosses a data type boundary.
  		Handle:		If noErr a new handle containing the requested data.
  **********************************************************************************************************							
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
  		doc:		opaque TXNObject obtained from TXNNewObject.
  		startOffset:	absolute offset from which data copy should begin.
  		endOffset:	absolute offset at which data copy should end.
  		encoding : should be kTXNTextData or kTXNUnicodeTextData				
  	Output:
  		OSStatus	Memory errors or  TXN_IllegalToCrossDataBoundaries if offsets specify a range that 
  				crosses a data type boundary.
  		Handle:		If noErr a new handle containing the requested data.
  **********************************************************************************************************							
}

FUNCTION TXNGetDataEncoded(iTXNObject: TXNObject; iStartOffset: TXNOffset; iEndOffset: TXNOffset; VAR oDataHandle: Handle; encoding: TXNDataType): OSStatus; C;

{
  *********************************************************************************************************
  	Replace the specified range with the contents of the specified file.  The data fork of the file 
  	must be opened by the caller.
  	Input:
  	 	doc:  	opaque TXNObject obtained from  TXNNewObject
  	 	fileSpec:  	HFS file reference obtained when file is opened.
  	 	fileType:  	files type.
  		iFileLength: The length of data in the file that should be considered data.  This
  					 parameter is available to enable callers to embed text inside their
  					 own private data structures.  Note that if the data is in the Textension(txtn)
  					 format this parameter is ignored since length, etc. information is
  					 part of the format. Further note that if you you just want Textension
  					 to read a file and you are not interested in embedding you can just pass
  					 kTXNEndOffset(0x7FFFFFFF), and Textension will use the file manager to
  					 determine the files length.
  	 	startOffset: 	start position at which to insert the file into the document.
  	 	endOffset:  	end position of range being replaced by the file.
  	Output:
  	 	OSStatus:  	File manager error or noErr.
  ***********************************************************************************************************
}
FUNCTION TXNSetDataFromFile(iTXNObject: TXNObject; iFileRefNum: SInt16; iFileType: OSType; iFileLength: ByteCount; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;

{
  ***********************************************************************************************************
  	Replace the specified range with the data pointed to by dataPtr and described by dataSize and dataType.
  	Input:
  	 	doc:  		opaque TXNObject obtained from TXNNewObject.    
  	 	dataType: 	 type of data must be one of TXNDataTypes. 
  	 	dataPtr:  	pointer to the new  data.
  	 	dataSize:  	Size of new data
  	 	startOffset: 	offset to beginning of range to replace
  	 	endOffset: 	offset to end of range to replace.
  	Output:
  	 	OSStatus: 		function result. parameter errors and Mac OS memory errors.	
  ************************************************************************************************************						
}
FUNCTION TXNSetData(iTXNObject: TXNObject; iDataType: TXNDataType; iDataPtr: UNIV Ptr; iDataSize: ByteCount; iStartOffset: TXNOffset; iEndOffset: TXNOffset): OSStatus; C;
{
  ************************************************************************************************************							
  	Retrieve number of times document has been changed.  That is for every committed command 
  	(keydown, cut, copy) the value returned is count of those. This is useful for deciding if  the Save 
  	item in the File menu should be active.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject
  							
  	Output:
  		ItemCount:	count of changes.  This is total changes since document  was created or last saved.  
  		Not count since this routine was last called or anything like that.
  ***********************************************************************************************************
}
FUNCTION TXNGetChangeCount(iTXNObject: TXNObject): ItemCount; C;

{
  *********************************************************************************************************
  	Save the contents of the document as the default type.  Handles displaying standard files dialog .
  	Input:
  		iTXNObject:		opaque TXNObject obtained from TXNNewObject.
  		iPermanentEncoding:	The encoding in which the document should be saved.
  		iFileSpecification:	 The file specification to which the document should be saved. The
  							 file must have been opened by the caller.  The file specification is remembered by the TXNObject
  							 and is used for any subsequent calls to TXNRevert.
  		iDataReference:		The data fork ref num.  This is used to write data to the data fork of the
  							file. The data is written beginning at the current mark.  
  		iResourceReference:	The resource fork ref num.  If the caller has specified that style information be
  							saved as a resource (MPW or SimpleText) than this should be a valid reference to
  							an open resource fork.  If the txtn format is being used than this input value
  							is ignored.
  	Output:
  		OSStatus		The result of writing the file.
  **********************************************************************************************************	
}
FUNCTION TXNSave(iTXNObject: TXNObject; iType: OSType; iResType: OSType; iPermanentEncoding: TXNPermanentTextEncodingType; VAR iFileSpecification: FSSpec; iDataReference: SInt16; iResourceReference: SInt16): OSStatus; C;

{
  ***********************************************************************************************************
  	Revert  to the last saved version of this document.  If the file was not previously saved the document
  	is reverted to an empty document.
  	Input:
  	 	doc: 	opaque TXNObject obtained from TXNNewObject
  	Output:
  	 	OSStatus:  	File manager errors, paramErr, or noErr.
  **********************************************************************************************************					
}
FUNCTION TXNRevert(iTXNObject: TXNObject): OSStatus; C;


{
  *********************************************************************************************************					
  	Display the Page Setup dialog of the current default printer and react to any changes 
  	(i.e. Reformat the text if the page layout changes.)
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject.
  	
  	Output:
  		OSStatus:	Print Manager errors, paramErr, noErr.
  **********************************************************************************************************
}
FUNCTION TXNPageSetup(iTXNObject: TXNObject): OSStatus; C;

{
  **********************************************************************************************************
  	Print the document.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject.
  	Output:
  		OSStatus:	Print Manager errors, paramErr, noErr.
  **********************************************************************************************************
}
FUNCTION TXNPrint(iTXNObject: TXNObject): OSStatus; C;




{
  ***********************************************************************************************************							
  	Test to see if the current scrap contains data that is supported by Textension.  Used to determine
  	if Paste item in Edit menu should be active or inactive. The types of data supported depends on what 
  	data types were specified in the TXNInitTextension options.
  	Output:
  		Boolean:		function result.  True if data type in Clipboard is supported.  False if 
  						not a supported data type.  If result is True the Paste item in the menu can 
  						be highlighted.
  **********************************************************************************************************
}
FUNCTION TXNIsScrapPastable: BOOLEAN; C;


{
  ***********************************************************************************************************
  	Convert the Textension private scrap to the public clipboard.  This should be called on suspend 
  	events and before the application displays a dialog that might support cut and paste.  Or more 
  	generally, whenever someone other than the Textension Shared Library needs access to the scrap data.
  	Output:
  		 OSStatus: 	Function result.  Memory Manager errors, Scrap Manager errors, noErr.
  ************************************************************************************************************							
}
FUNCTION TXNConvertToPublicScrap: OSStatus; C;

{
  ***********************************************************************************************************
  	Convert the  public clipboard to our private scrap .  This should be called on resume 
  	events and after an application has modified the scrap. Before doing work we check the validity of the public 
  	scrap (date modification and type)
  	Output:
  		 OSStatus: 	Function result.  Memory Manager errors, Scrap Manager errors, noErr.
  ************************************************************************************************************	
}
FUNCTION TXNConvertFromPublicScrap: OSStatus; C;

{
  ************************************************************************************************************
  	Get the  rectangle describing the current view into the document. The coordinates of this rectangle will be 
  	local to the the window.
  	Input:
  		doc:		opaque TXNObject obtained from TXNNewObject.
  	Output:
  		viewRect:		the requested view rectangle.
  *************************************************************************************************************
}
PROCEDURE TXNGetViewRect(iTXNObject: TXNObject; VAR oViewRect: Rect); C;

{
  ***********************************************************************************************************
  	Find a piece of text or a graphics object.
   	Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iMatchTextDataPtr	ptr to a MatchTextRecord which contains the text to match, the length of that text
  							and the TextEncoding the text is encoded in.  This must be there if you are looking
  							for Text, but can be NULL if you are looking for a graphics object.
  		iDataType			The type of data to find.  This can be any of the types defined in TXNDataType enum
  							(TEXT, PICT, moov, snd ).  However, if PICT, moov, or snd is passed then the default
  							behavior is to match on any non-Text object.  If you really want to find a specific
  							type you can provide a custom find callback or ignore matches which aren't the precise
  							type you are interested in.
  		iStartSearchOffset	The offset at which a search should begin. The constant kTXNStartOffset specifies the start
  							of the objects data.
  		iEndSearchOffset	The offset at which the search should end. The constant kTXNEndOffset specifies the end
  							of the objects data.
  		iFindProc			A custom callback.  If will be called to match things rather than the default matching
  							behavior.
  		iRefCon				This can be use for whatever the caller likes.  It is passed to the FindProc (if a FindProc
  							is provided.
  	Output:
  		oStartMatchOffset	absolute offset to start of match.  set to 0xFFFFFFFF if not match.
  		oEndMatchOffset		absolute offset to end of match.  Set to 0xFFFFFFFF is no match.
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
FUNCTION TXNFind(iTXNObject: TXNObject; iMatchTextDataPtr: {Const}TXNMatchTextRecordPtr; iDataType: TXNDataType; iMatchOptions: TXNMatchOptions; iStartSearchOffset: TXNOffset; iEndSearchOffset: TXNOffset; iFindProc: TXNFindUPP; iRefCon: SInt32; VAR oStartMatchOffset: TXNOffset; VAR oEndMatchOffset: TXNOffset): OSStatus; C;
{
  ***************************************************************************************************************
   TXNSetFontDefaults
  	
   For a given TXNObject specify the font defaults for each script.
   Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iCount:				count of FontDescriptions.
  		iFontDefaults:		array of FontDescriptins.
   Output:
  		OSStatus:			function result ( memory error, paramErr )
  ****************************************************************************************************************
}
FUNCTION TXNSetFontDefaults(iTXNObject: TXNObject; iCount: ItemCount; VAR iFontDefaults: TXNMacOSPreferredFontDescription): OSStatus; C;


{
  ***************************************************************************************************************
   TXNGetFontDefaults
  	
   For a given TXNObject make a copy of the font defaults.
   Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iCount:				count of FontDescriptions in the array.
  		iFontDefaults:		array of FontDescriptins to be filled out.
   Output:
  		OSStatus:			function result ( memory error, paramErr )
  	To determine how many font descriptions need to be in the array you should call this function with
  	a NULL for the array.  iCount will return with the number of font defaults currently stored.
  ****************************************************************************************************************
}

FUNCTION TXNGetFontDefaults(iTXNObject: TXNObject; VAR ioCount: ItemCount; iFontDefaults: TXNMacOSPreferredFontDescriptionPtr): OSStatus; C;


{
  ****************************************************************************************************************
  	TXNAttachObjectToWindow
  	If a TXNObject was initialized with a NULL window pointer use this function
  	to attach a window to that object.  In version 1.0 of Textension attaching
  	a TXNObject to more than one window is not supported.
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iWindow:			GWorldPtr that the object should be attached to
  		iShow:				If true the window will be shown after the
  							Text is formatted.
  	Output:
  		OSStatus:			function result (kObjectAlreadyAttachedToWindowErr, paramErr )
  ****************************************************************************************************************
}
FUNCTION TXNAttachObjectToWindow(iTXNObject: TXNObject; iWindow: GWorldPtr; iIsActualWindow: BOOLEAN): OSStatus; C;
{
  ****************************************************************************************************************
  	TXNIsObjectAttachedToWindow
  	A utility function that allows a caller to check a TXNObject to see if it is attached
  	to a window.
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  	Output:
  		Boolean:			function result.  True is object is attached.
  							False if TXNObject is not attached.
  ****************************************************************************************************************
}
FUNCTION TXNIsObjectAttachedToWindow(iTXNObject: TXNObject): BOOLEAN; C;

{
  ****************************************************************************************************************
  	TXNDragTracker
  	If you ask that Drag handling procs not be installed.  Call this when your drag tracker is called
    and you want Textension to take over
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iTXNFrameID			TXNFrameID obtained from TXNNewObject
  		iMessage			drag message obtained from Drag Manager
  		iWindow				windowPtr obtained from Drag Manager
  		iDragReference		dragReference obtained from Drag Manager
  	Output:
  		OSErr:				function result.  OSErr is used over
  							OSStatus so that it matches the Drag Manager definition of Tracking callback
  ****************************************************************************************************************
}
FUNCTION TXNDragTracker(iTXNObject: TXNObject; iTXNFrameID: TXNFrameID; iMessage: DragTrackingMessage; iWindow: WindowPtr; iDragReference: DragReference; iDifferentObjectSameWindow: BOOLEAN): OSErr; C;

{
  ****************************************************************************************************************
  	TXNDragReceiver
  	If you ask that Drag handling procs not be installed.  Call this when your drag receiver is called
    and you want Textension to take over
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iTXNFrameID			TXNFrameID obtained from TXNNewObject
  		iWindow				windowPtr obtained from Drag Manager
  		iDragReference		dragReference obtained from Drag Manager
  	Output:
  		OSErr:				function result.  OSErr is used over
  							OSStatus so that it matches the Drag Manager definition of Tracking callback
  ****************************************************************************************************************
}
FUNCTION TXNDragReceiver(iTXNObject: TXNObject; iTXNFrameID: TXNFrameID; iWindow: WindowPtr; iDragReference: DragReference; iDifferentObjectSameWindow: BOOLEAN): OSErr; C;

{
  ****************************************************************************************************************
  	TXNActivate
  	Make the TXNObject object in the sense that it can be scrolled if it has scrollbars.  If the TXNScrollBarState parameter
    is true than the scrollbars will be active even when the TXNObject is not focused (i.e. insertion point not active)
  	
  	This function should be used if you have multiple TXNObjects in a window, and you want them all to be scrollable
    even though only one at a time can have the keyboard focus.
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from TXNNewObject.
  		iTXNFrameID			TXNFrameID obtained from TXNNewObject
  		iActiveState		Boolean if true Scrollbars active even though TXNObject does not have the keyboard focus.  
  							if false scrollbars are synced with active state (i.e. a focused object has an
  							active insertion point or selection and active scrollbars. An unfocused object has inactive
  							selection (grayed or framed selection) and inactive scrollbars.  The latter state is the 
  							default and usually the one you use if you have one TXNObject in a window.
  	Output:
  		OSStatus:			function result.  ParamErr if bad iTXNObject or frame ID.
  ****************************************************************************************************************
}
FUNCTION TXNActivate(iTXNObject: TXNObject; iTXNFrameID: TXNFrameID; iActiveState: ByteParameter): OSStatus; C;


{
  *****************************************************************************************************************
  	TXNSetBackgound
  	Set the type of background the TXNObject's text, etc. is drawn onto.  At this point the background
  	can be a color or a picture.  
  	
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from IncomingDataFilter callback.
  		iBackgroundInfo:	struct containing information that describes the background
  	Output:
  		OSStatus:			function result.  paramErrs.
  ********************************************************************************************************************
}
FUNCTION TXNSetBackground(iTXNObject: TXNObject; VAR iBackgroundInfo: TXNBackground): OSStatus; C;

{
  *****************************************************************************************************************
  	TXNEchoMode
  	Put the TXNObject into echo mode.  What that means is that all characters in the TXNObject have the character
  	'echoCharacter' substituted for the actual glyph when drawing occurs. Note that the echoCharacter is typed
  	has a UniChar, but this is done merely to facilitate passing any 2 byte character.  The encoding parameter
  	actually determines the encoding used to locate a font and display a character.  Thus if you wanted to
  	display the diamond found in the Shift-JIS encoding for MacOS you would pass in 0x86A6 for the character
  	but an encoding that was built to represent the MacOS Japanese encoding.
  	
  	Input:
  		iTXNObject:	 		opaque TXNObject obtained from IncomingDataFilter callback.
  		echoCharacter:		character to use in substitution
  		encoding:			encoding from which character is drawn.
  		on:					TRUE if turning EchoMode on.  False if turning it off.
  	Output:
  		OSStatus:			function result.  paramErrs.
  ********************************************************************************************************************
}
FUNCTION TXNEchoMode(iTXNObject: TXNObject; echoCharacter: UniChar; encoding: TextEncoding; on: BOOLEAN): OSStatus; C;

{
  ********************************************************************************************************************
  	TXNNewFontMenuObject
  	Get a FontMenuObject.  Caller can extract a fontmenu from this object and pass this object to the active
  	TXNObject to handle events in the font menu.
  	Input:
  		iFontMenuHandle:	An empty menu handle (well the title is there) that the caller created via
  							NewMenu or GetNewMenu. This menu handle should not be disposed before
  							the returned TXNFontMenuObject has been disposed via TXNDisposeFontMenuObject.
  		iMenuID:			The MenuID for iFontMenuHandle.
  		iStartHierMenuID:	The first MenuID to use if any hierarchical menus need to be created.
  		
  	Output:
  		OSStatus:			function result.  memory, parameter errors.
  		TXNFontMenuObject:	A font menu object
  *********************************************************************************************************************
}
FUNCTION TXNNewFontMenuObject(iFontMenuHandle: MenuHandle; iMenuID: SInt16; iStartHierMenuID: SInt16; VAR oTXNFontMenuObject: TXNFontMenuObject): OSStatus; C;

{
  *********************************************************************************************************************
  	TXNGetFontMenuHandle
  	Get the menuHandle from the TXNFontMenuObject.
  	Input:
  		iTXNFontMenuObject:		A Font Menu Object obtained from TXNGetFontMenuObject.
  	Output:
  		OSStatus:	function result. parameter errors.
  		fontMenuHandle:	The font menu. Can be NULL.
  		fontMenuID:		The menu ID. Can be NULL.
  *********************************************************************************************************************
}
FUNCTION TXNGetFontMenuHandle(iTXNFontMenuObject: TXNFontMenuObject; VAR fontMenuHandle: MenuHandle): OSStatus; C;

{
  *********************************************************************************************************************
  	TXNDisposeFontMenuObject
  	Dispose a TXNFontMenuObject and its font menu handle
  	Input:
  		iTXNFontMenuObject:		A Font Menu Object obtained from TXNGetFontMenuObject.
  	Output:
  		OSStatus:	function result. parameter errors.
  *********************************************************************************************************************
}
FUNCTION TXNDisposeFontMenuObject(iTXNFontMenuObject: TXNFontMenuObject): OSStatus; C;

{
  *********************************************************************************************************************
  	TXNDoFontMenuSelection
  		Given the menuID and menu item returned by MenuSelect determine the selected font
  		and change the current selection to be that Font.  If the input TXNObject is
  		not active a parameter error is returned.
  	Input:
  		iTXNObject:	An opaque TXNObject obtained from TXNNewObject.
  		iTXNFontMenuObject:		A Font Menu Object obtained from TXNGetFontMenuObject.
  		MenuID:	SInt16 the ID of the selected menu.
  		MenuItem: The item that was selected.
  	Output:
  		OSStatus:	If menu processed and new font set noErr.  If the menuID is not the
  					font menu or one of its sub menus (ATSUI) kMenuSelectionNotProcessed
  					is returned.  Otherwise paramErr is possible.
  **********************************************************************************************************************
}
FUNCTION TXNDoFontMenuSelection(iTXNObject: TXNObject; iTXNFontMenuObject: TXNFontMenuObject; menuID: SInt16; menuItem: SInt16): OSStatus; C;

{
  **********************************************************************************************************************
  	TXNPrepareFontMenu
  		Prepare the font menu to be pulled down.  If the current selection is all the same font (continuous font).
  		The item for that font is checked.  If the input TXNObject is NULL, the font menu is deactivated.
  	Input:
  		iTXNObject:  The currently active TXNObject.  Can be NULL.  If that is the case the menu is deactivated.
  		TXNDoFontMenuSelection: The 
  		
  	Output:
  		OSStatus:	function result.  ParamError.
  **********************************************************************************************************************
}
FUNCTION TXNPrepareFontMenu(iTXNObject: TXNObject; iTXNFontMenuObject: TXNFontMenuObject): OSStatus; C;

{
  **********************************************************************************************************************
  	TXNVersionValue
  		Get the version number and a set of feature bits.  The initial version number is 0x00010000
  		And the only bit used in the oFeatureFlags is the lsb.  0x00
  	Input:
  		NONE
  		
  	Output:
  		TXNVersionValue:	Current version.
  		TXNFeatureBits*:		Pointer to a bit mask.  See TXNFeatureMask enum above. If kTXNWillDefaultToATSUIBit
  										is set it means that by default MLTE will use ATSUI to image and measure text and will
  										default to using Unicode to store characters.
  **********************************************************************************************************************
}

FUNCTION TXNVersionInformation(VAR oFeatureFlags: TXNFeatureBits): TXNVersionValue; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacTextEditorIncludes}

{$ENDC} {__MACTEXTEDITOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
