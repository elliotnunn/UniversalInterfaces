{
 	File:		Movies.p
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 3.0
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1990-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Movies;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MOVIES__}
{$SETC __MOVIES__ := 1}

{$I+}
{$SETC MoviesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{  "kFix1" is defined in FixMath as "fixed1"  }
{ error codes are in Errors.[haa] }
{ gestalt codes are in Gestalt.[hpa] }

CONST
	MovieFileType				= 'MooV';
	MovieScrapType				= 'moov';

	MovieResourceType			= 'moov';
	MovieForwardPointerResourceType = 'fore';
	MovieBackwardPointerResourceType = 'back';

	MovieResourceAtomType		= 'moov';
	MovieDataAtomType			= 'mdat';
	FreeAtomType				= 'free';
	SkipAtomType				= 'skip';

	MediaHandlerType			= 'mhlr';
	DataHandlerType				= 'dhlr';

	VideoMediaType				= 'vide';
	SoundMediaType				= 'soun';
	TextMediaType				= 'text';
	BaseMediaType				= 'gnrc';
	MPEGMediaType				= 'MPEG';
	MusicMediaType				= 'musi';
	TimeCodeMediaType			= 'tmcd';
	SpriteMediaType				= 'sprt';
	TweenMediaType				= 'twen';
	ThreeDeeMediaType			= 'qd3d';
	HandleDataHandlerSubType	= 'hndl';
	ResourceDataHandlerSubType	= 'rsrc';
	URLDataHandlerSubType		= 'url ';

	VisualMediaCharacteristic	= 'eyes';
	AudioMediaCharacteristic	= 'ears';
	kCharacteristicCanSendVideo	= 'vsnd';
	kCharacteristicProvidesActions = 'actn';

	kUserDataMovieControllerType = 'ctyp';
	kUserDataName				= 'name';
	kUserDataTextFullName		= '©nam';
	kUserDataTextCopyright		= '©cpy';
	kUserDataTextInformation	= '©inf';

	DoTheRightThing				= 0;



TYPE
	MovieRecordPtr = ^MovieRecord;
	MovieRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Movie								= ^MovieRecord;
	TrackRecordPtr = ^TrackRecord;
	TrackRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Track								= ^TrackRecord;
	MediaRecordPtr = ^MediaRecord;
	MediaRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Media								= ^MediaRecord;
	UserDataRecordPtr = ^UserDataRecord;
	UserDataRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	UserData							= ^UserDataRecord;
	TrackEditStateRecordPtr = ^TrackEditStateRecord;
	TrackEditStateRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	TrackEditState						= ^TrackEditStateRecord;
	MovieEditStateRecordPtr = ^MovieEditStateRecord;
	MovieEditStateRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	MovieEditState						= ^MovieEditStateRecord;
	SpriteWorldRecordPtr = ^SpriteWorldRecord;
	SpriteWorldRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SpriteWorld							= ^SpriteWorldRecord;
	SpriteRecordPtr = ^SpriteRecord;
	SpriteRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Sprite								= ^SpriteRecord;
	QTTweenerRecordPtr = ^QTTweenerRecord;
	QTTweenerRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTTweener							= ^QTTweenerRecord;
	SampleDescriptionPtr = ^SampleDescription;
	SampleDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
	END;

	SampleDescriptionHandle				= ^SampleDescriptionPtr;
	QTAtomContainer						= Handle;
	QTAtom								= LONGINT;
	QTAtomType							= LONGINT;
	QTAtomID							= LONGINT;
{  QTFloatDouble is the 64-bit IEEE-754 standard }
	QTFloatDouble						= Float64;
	QTFloatDoublePtr 					= ^QTFloatDouble;
{  QTFloatSingle is the 32-bit IEEE-754 standard }
	QTFloatSingle						= Float32;
	QTFloatSinglePtr 					= ^QTFloatSingle;


	SoundDescriptionPtr = ^SoundDescription;
	SoundDescription = RECORD
		descSize:				LONGINT;								{  total size of SoundDescription including extra data  }
		dataFormat:				LONGINT;								{  sound format  }
		resvd1:					LONGINT;								{  reserved for apple use. set to zero  }
		resvd2:					INTEGER;								{  reserved for apple use. set to zero  }
		dataRefIndex:			INTEGER;
		version:				INTEGER;								{  which version is this data  }
		revlevel:				INTEGER;								{  what version of that codec did this  }
		vendor:					LONGINT;								{  whose  codec compressed this data  }
		numChannels:			INTEGER;								{  number of channels of sound  }
		sampleSize:				INTEGER;								{  number of bits per sample  }
		compressionID:			INTEGER;								{  unused. set to zero.  }
		packetSize:				INTEGER;								{  unused. set to zero.  }
		sampleRate:				UnsignedFixed;							{  sample rate sound is captured at  }
	END;

	SoundDescriptionHandle				= ^SoundDescriptionPtr;
{  version 1 of the SoundDescription record }
	SoundDescriptionV1Ptr = ^SoundDescriptionV1;
	SoundDescriptionV1 = RECORD
																		{  original fields }
		desc:					SoundDescription;
																		{  fixed compression ratio information }
		samplesPerPacket:		UInt32;
		bytesPerPacket:			UInt32;
		bytesPerFrame:			UInt32;
		bytesPerSample:			UInt32;
																		{  additional atom based fields ([long size, long type, some data], repeat) }
	END;

	SoundDescriptionV1Handle			= ^SoundDescriptionV1Ptr;
	TextDescriptionPtr = ^TextDescription;
	TextDescription = RECORD
		descSize:				LONGINT;								{  Total size of TextDescription }
		dataFormat:				LONGINT;								{  'text' }
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		displayFlags:			LONGINT;								{  see enum below for flag values }
		textJustification:		LONGINT;								{  Can be: teCenter,teFlush -Default,-Right,-Left }
		bgColor:				RGBColor;								{  Background color }
		defaultTextBox:			Rect;									{  Location to place the text within the track bounds }
		defaultStyle:			ScrpSTElement;							{  Default style (struct defined in TextEdit.h) }
		defaultFontName:		SInt8;									{  Font Name (pascal string - struct extended to fit)  }
	END;

	TextDescriptionHandle				= ^TextDescriptionPtr;
	SpriteDescriptionPtr = ^SpriteDescription;
	SpriteDescription = RECORD
		descSize:				LONGINT;								{  total size of SpriteDescription including extra data  }
		dataFormat:				LONGINT;								{    }
		resvd1:					LONGINT;								{  reserved for apple use  }
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				LONGINT;								{  which version is this data  }
		decompressorType:		OSType;									{  which decompressor to use, 0 for no decompression  }
		sampleFlags:			LONGINT;								{  how to interpret samples  }
	END;

	SpriteDescriptionHandle				= ^SpriteDescriptionPtr;
	ThreeDeeDescriptionPtr = ^ThreeDeeDescription;
	ThreeDeeDescription = RECORD
		descSize:				LONGINT;								{  total size of ThreeDeeDescription including extra data  }
		dataFormat:				LONGINT;								{    }
		resvd1:					LONGINT;								{  reserved for apple use  }
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				LONGINT;								{  which version is this data  }
		rendererType:			LONGINT;								{  which renderer to use, 0 for default  }
		decompressorType:		LONGINT;								{  which decompressor to use, 0 for default  }
	END;

	ThreeDeeDescriptionHandle			= ^ThreeDeeDescriptionPtr;
	DataReferenceRecordPtr = ^DataReferenceRecord;
	DataReferenceRecord = RECORD
		dataRefType:			OSType;
		dataRef:				Handle;
	END;

	DataReferencePtr					= ^DataReferenceRecord;
{--------------------------
  Music Sample Description
--------------------------}
	MusicDescriptionPtr = ^MusicDescription;
	MusicDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;								{  'musi'  }
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		musicFlags:				LONGINT;
		headerData:				ARRAY [0..0] OF UInt32;					{  variable size!  }
	END;

	MusicDescriptionHandle				= ^MusicDescriptionPtr;

CONST
	kMusicFlagDontPlay2Soft		= $00000001;
	kMusicFlagDontSlaveToMovie	= $00000002;


	dfDontDisplay				= $01;							{  Don't display the text }
	dfDontAutoScale				= $02;							{  Don't scale text as track bounds grows or shrinks }
	dfClipToTextBox				= $04;							{  Clip update to the textbox }
	dfUseMovieBGColor			= $08;							{  Set text background to movie's background color }
	dfShrinkTextBoxToFit		= $10;							{  Compute minimum box to fit the sample }
	dfScrollIn					= $20;							{  Scroll text in until last of text is in view  }
	dfScrollOut					= $40;							{  Scroll text out until last of text is gone (if both set, scroll in then out) }
	dfHorizScroll				= $80;							{  Scroll text horizontally (otherwise it's vertical) }
	dfReverseScroll				= $0100;						{  vert: scroll down rather than up; horiz: scroll backwards (justfication dependent) }
	dfContinuousScroll			= $0200;						{  new samples cause previous samples to scroll out  }
	dfFlowHoriz					= $0400;						{  horiz scroll text flows in textbox rather than extend to right  }
	dfContinuousKaraoke			= $0800;						{  ignore begin offset, hilite everything up to the end offset(karaoke) }
	dfDropShadow				= $1000;						{  display text with a drop shadow  }
	dfAntiAlias					= $2000;						{  attempt to display text anti aliased }
	dfKeyedText					= $4000;						{  key the text over background }
	dfInverseHilite				= $8000;						{  Use inverse hiliting rather than using hilite color }
	dfTextColorHilite			= $00010000;					{  changes text color in place of hiliting.  }

	searchTextDontGoToFoundTime	= $00010000;
	searchTextDontHiliteFoundText = $00020000;
	searchTextOneTrackOnly		= $00040000;
	searchTextEnabledTracksOnly	= $00080000;

	k3DMediaRendererEntry		= 'rend';
	k3DMediaRendererName		= 'name';
	k3DMediaRendererCode		= 'rcod';

{ progress messages }
	movieProgressOpen			= 0;
	movieProgressUpdatePercent	= 1;
	movieProgressClose			= 2;

{ progress operations }
	progressOpFlatten			= 1;
	progressOpInsertTrackSegment = 2;
	progressOpInsertMovieSegment = 3;
	progressOpPaste				= 4;
	progressOpAddMovieSelection	= 5;
	progressOpCopy				= 6;
	progressOpCut				= 7;
	progressOpLoadMovieIntoRam	= 8;
	progressOpLoadTrackIntoRam	= 9;
	progressOpLoadMediaIntoRam	= 10;
	progressOpImportMovie		= 11;
	progressOpExportMovie		= 12;

	mediaQualityDraft			= $0000;
	mediaQualityNormal			= $0040;
	mediaQualityBetter			= $0080;
	mediaQualityBest			= $00C0;

{****
	Interactive Sprites Support
****}

TYPE
	QTEventRecordPtr = ^QTEventRecord;
	QTEventRecord = RECORD
		version:				LONGINT;
		eventType:				OSType;
		where:					Point;
		flags:					LONGINT;
	END;

	QTAtomSpecPtr = ^QTAtomSpec;
	QTAtomSpec = RECORD
		container:				QTAtomContainer;
		atom:					QTAtom;
	END;

	ResolvedQTEventSpecPtr = ^ResolvedQTEventSpec;
	ResolvedQTEventSpec = RECORD
		actionAtom:				QTAtomSpec;
		targetTrack:			Track;
		targetRefCon:			LONGINT;
	END;

	QTActionVarSpecPtr = ^QTActionVarSpec;
	QTActionVarSpec = RECORD
		actionVarID:			QTAtomID;
		variableValue:			Ptr;
	END;


{  action constants  }

CONST
	kActionMovieSetVolume		= 1024;							{  (short movieVolume)  }
	kActionMovieSetRate			= 1025;							{  (Fixed rate)  }
	kActionMovieSetLoopingFlags	= 1026;							{  (long loopingFlags)  }
	kActionMovieGoToTime		= 1027;							{  (TimeValue time)  }
	kActionMovieGoToTimeByName	= 1028;							{  (Str255 timeName)  }
	kActionMovieGoToBeginning	= 1029;							{  no params  }
	kActionMovieGoToEnd			= 1030;							{  no params  }
	kActionMovieStepForward		= 1031;							{  no params  }
	kActionMovieStepBackward	= 1032;							{  no params  }
	kActionMovieSetSelection	= 1033;							{  (TimeValue startTime, TimeValue endTime)  }
	kActionMovieSetSelectionByName = 1034;						{  (Str255 startTimeName, Str255 endTimeName)  }
	kActionMoviePlaySelection	= 1035;							{  (Boolean selectionOnly)  }
	kActionMovieSetLanguage		= 1036;							{  (long language)  }
	kActionMovieChanged			= 1037;							{  no params  }
	kActionTrackSetVolume		= 2048;							{  (short volume)  }
	kActionTrackSetBalance		= 2049;							{  (short balance)  }
	kActionTrackSetEnabled		= 2050;							{  (Boolean enabled)  }
	kActionTrackSetMatrix		= 2051;							{  (MatrixRecord matrix)  }
	kActionTrackSetLayer		= 2052;							{  (short layer)  }
	kActionTrackSetClip			= 2053;							{  (RgnHandle clip)  }
	kActionSpriteSetMatrix		= 3072;							{  (MatrixRecord matrix)  }
	kActionSpriteSetImageIndex	= 3073;							{  (short imageIndex)  }
	kActionSpriteSetVisible		= 3074;							{  (short visible)  }
	kActionSpriteSetLayer		= 3075;							{  (short layer)  }
	kActionSpriteSetGraphicsMode = 3076;						{  (ModifierTrackGraphicsModeRecord graphicsMode)  }
	kActionSpritePassMouseToCodec = 3078;						{  no params  }
	kActionSpriteClickOnCodec	= 3079;							{  Point localLoc  }
	kActionSpriteTranslate		= 3080;							{  (Fixed x, Fixed y, Boolean isRelative)  }
	kActionSpriteScale			= 3081;							{  (Fixed xScale, Fixed yScale, Fixed aboutX, Fixed aboutY, Boolean isRelative)  }
	kActionSpriteRotate			= 3082;							{  (Fixed degrees, Fixed aboutX, Fixed aboutY, Boolean isRelative)  }
	kActionSpriteStretch		= 3083;							{  (Fixed p1x, Fixed p1y, Fixed p2x, Fixed p2y, Fixed p3x, Fixed p3y, Fixed p4x, Fixed p4y, Boolean isRelative)  }
	kActionQTVRSetPanAngle		= 4096;							{  (float panAngle)  }
	kActionQTVRSetTiltAngle		= 4097;							{  (float tiltAngle)  }
	kActionQTVRSetFieldOfView	= 4098;							{  (float fieldOfView)  }
	kActionQTVRShowDefaultView	= 4099;							{  no params  }
	kActionQTVRGoToNodeID		= 4100;							{  (UInt32 nodeID)  }
	kActionMusicPlayNote		= 5120;							{  (long sampleDescIndex, long partNumber, long delay, long pitch, long velocity, long duration)  }
	kActionMusicSetController	= 5121;							{  (long sampleDescIndex, long partNumber, long delay, long controller, long value)  }
	kActionMusicPlayTune		= 5122;							{  (long sampleDescIndex, Handle tuneData )  }
	kActionCase					= 6144;							{  [(CaseStatementActionAtoms)]  }
	kActionWhile				= 6145;							{  [(WhileStatementActionAtoms)]  }
	kActionGoToURL				= 6146;							{  (C string urlLink)  }
	kActionSendQTEventToSprite	= 6147;							{  ([(SpriteTargetAtoms)], QTEventRecord theEvent)  }
	kActionDebugStr				= 6148;							{  (Str255 theString)  }
	kActionPushCurrentTime		= 6149;							{  no params  }
	kActionPushCurrentTimeWithLabel = 6150;						{  (Str255 theLabel)  }
	kActionPopAndGotoTopTime	= 6151;							{  no params  }
	kActionPopAndGotoLabeledTime = 6152;						{  (Str255 theLabel)  }
	kActionSpriteTrackSetVariable = 7168;						{  (QTAtomID variableID, float value)  }
	kActionApplicationNumberAndString = 8192;					{  (long aNumber, Str255 aString )  }

	kOperandExpression			= 1;
	kOperandConstant			= 2;
	kOperandMovieVolume			= 1024;
	kOperandMovieRate			= 1025;
	kOperandMovieIsLooping		= 1026;
	kOperandMovieLoopIsPalindrome = 1027;
	kOperandMovieTime			= 1028;
	kOperandTrackVolume			= 2048;
	kOperandTrackBalance		= 2049;
	kOperandTrackEnabled		= 2050;
	kOperandTrackLayer			= 2051;
	kOperandTrackWidth			= 2052;
	kOperandTrackHeight			= 2053;
	kOperandSpriteBoundsLeft	= 3072;
	kOperandSpriteBoundsTop		= 3073;
	kOperandSpriteBoundsRight	= 3074;
	kOperandSpriteBoundsBottom	= 3075;
	kOperandSpriteImageIndex	= 3076;
	kOperandSpriteVisible		= 3077;
	kOperandSpriteLayer			= 3078;
	kOperandSpriteTrackVariable	= 3079;							{  [QTAtomID variableID]  }
	kOperandSpriteTrackNumSprites = 3080;
	kOperandSpriteTrackNumImages = 3081;
	kOperandSpriteID			= 3082;
	kOperandSpriteIndex			= 3083;
	kOperandSpriteFirstCornerX	= 3084;
	kOperandSpriteFirstCornerY	= 3085;
	kOperandSpriteSecondCornerX	= 3086;
	kOperandSpriteSecondCornerY	= 3087;
	kOperandSpriteThirdCornerX	= 3088;
	kOperandSpriteThirdCornerY	= 3089;
	kOperandSpriteFourthCornerX	= 3090;
	kOperandSpriteFourthCornerY	= 3091;
	kOperandSpriteImageRegistrationPointX = 3092;
	kOperandSpriteImageRegistrationPointY = 3093;
	kOperandQTVRPanAngle		= 4096;
	kOperandQTVRTiltAngle		= 4097;
	kOperandQTVRFieldOfView		= 4098;
	kOperandQTVRNodeID			= 4099;
	kOperandMouseLocalHLoc		= 5120;							{  [TargetAtoms aTrack]  }
	kOperandMouseLocalVLoc		= 5121;							{  [TargetAtoms aTrack]  }
	kOperandKeyIsDown			= 5122;							{  [short modKeys, char asciiValue]  }
	kOperandRandom				= 5123;							{  [short min, short max]  }

	kFirstMovieAction			= 1024;
	kLastMovieAction			= 1037;
	kFirstTrackAction			= 2048;
	kLastTrackAction			= 2053;
	kFirstSpriteAction			= 3072;
	kLastSpriteAction			= 3083;
	kFirstQTVRAction			= 4096;
	kLastQTVRAction				= 4100;
	kFirstMusicAction			= 5120;
	kLastMusicAction			= 5122;
	kFirstSystemAction			= 6144;
	kLastSystemAction			= 6152;
	kFirstSpriteTrackAction		= 7168;
	kLastSpriteTrackAction		= 7168;
	kFirstApplicationAction		= 8192;
	kLastApplicationAction		= 8192;
	kFirstAction				= 1024;
	kLastAction					= 8192;


{  target atom types }
	kTargetMovie				= 'moov';						{  no data  }
	kTargetTrackName			= 'trna';						{  (PString trackName)  }
	kTargetTrackID				= 'trid';						{  (long trackID)  }
	kTargetTrackType			= 'trty';						{  (OSType trackType)  }
	kTargetTrackIndex			= 'trin';						{  (long trackIndex)  }
	kTargetSpriteName			= 'spna';						{  (PString spriteName)  }
	kTargetSpriteID				= 'spid';						{  (QTAtomID spriteID)  }
	kTargetSpriteIndex			= 'spin';						{  (short spriteIndex)  }

{  action container atom types }
	kQTEventType				= 'evnt';
	kAction						= 'actn';
	kWhichAction				= 'whic';
	kActionParameter			= 'parm';
	kActionTarget				= 'targ';
	kActionFlags				= 'flag';
	kActionParameterMinValue	= 'minv';
	kActionParameterMaxValue	= 'maxv';
	kActionListAtomType			= 'list';
	kExpressionContainerAtomType = 'expr';
	kConditionalAtomType		= 'test';
	kOperatorAtomType			= 'oper';
	kOperandAtomType			= 'oprn';
	kCommentAtomType			= 'why ';

{  QTEvent types  }
	kQTEventMouseClick			= 'clik';
	kQTEventMouseClickEnd		= 'cend';
	kQTEventMouseClickEndTriggerButton = 'trig';
	kQTEventMouseEnter			= 'entr';
	kQTEventMouseExit			= 'exit';
	kQTEventFrameLoaded			= 'fram';
	kQTEventIdle				= 'idle';
	kQTEventRequestToModifyMovie = 'reqm';

{  flags for the kActionFlags atom  }
	kActionFlagActionIsDelta	= $00000002;
	kActionFlagParameterWrapsAround = $00000004;
	kActionFlagActionIsToggle	= $00000008;

{  constants for kOperatorAtomType IDs (operator types) }
	kOperatorAdd				= 'add ';
	kOperatorSubtract			= 'sub ';
	kOperatorMultiply			= 'mult';
	kOperatorDivide				= 'div ';
	kOperatorOr					= 'or  ';
	kOperatorAnd				= 'and ';
	kOperatorNot				= 'not ';
	kOperatorLessThan			= '<   ';
	kOperatorLessThanEqualTo	= '<=  ';
	kOperatorEqualTo			= '=   ';
	kOperatorNotEqualTo			= '!=  ';
	kOperatorGreaterThan		= '>   ';
	kOperatorGreaterThanEqualTo	= '>=  ';
	kOperatorModulo				= 'mod ';
	kOperatorIntegerDivide		= 'idiv';
	kOperatorAbsoluteValue		= 'abs ';
	kOperatorNegate				= 'neg ';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MovieRgnCoverProcPtr = FUNCTION(theMovie: Movie; changedRgn: RgnHandle; refcon: LONGINT): OSErr;
{$ELSEC}
	MovieRgnCoverProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieProgressProcPtr = FUNCTION(theMovie: Movie; message: INTEGER; whatOperation: INTEGER; percentDone: Fixed; refcon: LONGINT): OSErr;
{$ELSEC}
	MovieProgressProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieDrawingCompleteProcPtr = FUNCTION(theMovie: Movie; refCon: LONGINT): OSErr;
{$ELSEC}
	MovieDrawingCompleteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TrackTransferProcPtr = FUNCTION(t: Track; refCon: LONGINT): OSErr;
{$ELSEC}
	TrackTransferProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	GetMovieProcPtr = FUNCTION(offset: LONGINT; size: LONGINT; dataPtr: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	GetMovieProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MoviePreviewCallOutProcPtr = FUNCTION(refcon: LONGINT): BOOLEAN;
{$ELSEC}
	MoviePreviewCallOutProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TextMediaProcPtr = FUNCTION(theText: Handle; theMovie: Movie; VAR displayFlag: INTEGER; refcon: LONGINT): OSErr;
{$ELSEC}
	TextMediaProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ActionsProcPtr = FUNCTION(refcon: UNIV Ptr; targetTrack: Track; targetRefCon: LONGINT; theEvent: QTEventRecordPtr): OSErr;
{$ELSEC}
	ActionsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MoviesErrorProcPtr = PROCEDURE(theErr: OSErr; refcon: LONGINT);
{$ELSEC}
	MoviesErrorProcPtr = ProcPtr;
{$ENDC}

	MoviesErrorUPP = UniversalProcPtr;

CONST
	uppMoviesErrorProcInfo = $00000380;

FUNCTION NewMoviesErrorProc(userRoutine: MoviesErrorProcPtr): MoviesErrorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMoviesErrorProc(theErr: OSErr; refcon: LONGINT; userRoutine: MoviesErrorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	MovieRgnCoverUPP = UniversalProcPtr;
	MovieProgressUPP = UniversalProcPtr;
	MovieDrawingCompleteUPP = UniversalProcPtr;
	TrackTransferUPP = UniversalProcPtr;
	GetMovieUPP = UniversalProcPtr;
	MoviePreviewCallOutUPP = UniversalProcPtr;
	TextMediaUPP = UniversalProcPtr;
	ActionsUPP = UniversalProcPtr;
	MediaHandler						= ComponentInstance;
	DataHandler							= ComponentInstance;
	MediaHandlerComponent				= Component;
	DataHandlerComponent				= Component;
	HandlerError						= ComponentResult;
{ TimeBase equates }
	TimeValue							= LONGINT;
	TimeScale							= LONGINT;
	CompTimeValue						= wide;
	CompTimeValuePtr 					= ^CompTimeValue;

CONST
	loopTimeBase				= 1;
	palindromeLoopTimeBase		= 2;
	maintainTimeBaseZero		= 4;


TYPE
	TimeBaseFlags						= UInt32;
	TimeBaseRecordPtr = ^TimeBaseRecord;
	TimeBaseRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	TimeBase							= ^TimeBaseRecord;
	CallBackRecordPtr = ^CallBackRecord;
	CallBackRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTCallBack							= ^CallBackRecord;
	TimeRecordPtr = ^TimeRecord;
	TimeRecord = RECORD
		value:					CompTimeValue;							{  units  }
		scale:					TimeScale;								{  units per second  }
		base:					TimeBase;
	END;

{ CallBack equates }

CONST
	triggerTimeFwd				= $0001;						{  when curTime exceeds triggerTime going forward  }
	triggerTimeBwd				= $0002;						{  when curTime exceeds triggerTime going backwards  }
	triggerTimeEither			= $0003;						{  when curTime exceeds triggerTime going either direction  }
	triggerRateLT				= $0004;						{  when rate changes to less than trigger value  }
	triggerRateGT				= $0008;						{  when rate changes to greater than trigger value  }
	triggerRateEqual			= $0010;						{  when rate changes to equal trigger value  }
	triggerRateLTE				= $0014;
	triggerRateGTE				= $0018;
	triggerRateNotEqual			= $001C;
	triggerRateChange			= 0;
	triggerAtStart				= $0001;
	triggerAtStop				= $0002;


TYPE
	QTCallBackFlags						= UInt16;

CONST
	timeBaseBeforeStartTime		= 1;
	timeBaseAfterStopTime		= 2;


TYPE
	TimeBaseStatus						= UInt32;

CONST
	callBackAtTime				= 1;
	callBackAtRate				= 2;
	callBackAtTimeJump			= 3;
	callBackAtExtremes			= 4;
	callBackAtInterrupt			= $8000;
	callBackAtDeferredTask		= $4000;


TYPE
	QTCallBackType						= UInt16;
{$IFC TYPED_FUNCTION_POINTERS}
	QTCallBackProcPtr = PROCEDURE(cb: QTCallBack; refCon: LONGINT);
{$ELSEC}
	QTCallBackProcPtr = ProcPtr;
{$ENDC}

	QTCallBackUPP = UniversalProcPtr;

CONST
	qtcbNeedsRateChanges		= 1;							{  wants to know about rate changes  }
	qtcbNeedsTimeChanges		= 2;							{  wants to know about time changes  }
	qtcbNeedsStartStopChanges	= 4;							{  wants to know when TimeBase start/stop is changed }


TYPE
	QTCallBackHeaderPtr = ^QTCallBackHeader;
	QTCallBackHeader = RECORD
		callBackFlags:			LONGINT;
		reserved1:				LONGINT;
		qtPrivate:				ARRAY [0..39] OF SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	QTSyncTaskProcPtr = PROCEDURE(task: UNIV Ptr);
{$ELSEC}
	QTSyncTaskProcPtr = ProcPtr;
{$ENDC}

	QTSyncTaskUPP = UniversalProcPtr;
	QTSyncTaskRecordPtr = ^QTSyncTaskRecord;
	QTSyncTaskRecord = RECORD
		qLink:					Ptr;
		proc:					QTSyncTaskUPP;
	END;

	QTSyncTaskPtr						= ^QTSyncTaskRecord;

CONST
	keepInRam					= $01;							{  load and make non-purgable }
	unkeepInRam					= $02;							{  mark as purgable }
	flushFromRam				= $04;							{  empty those handles }
	loadForwardTrackEdits		= $08;							{ 	load track edits into ram for playing forward }
	loadBackwardTrackEdits		= $10;							{ 	load track edits into ram for playing in reverse }

	newMovieActive				= $01;
	newMovieDontResolveDataRefs	= $02;
	newMovieDontAskUnresolvedDataRefs = $04;
	newMovieDontAutoAlternates	= $08;
	newMovieDontUpdateForeBackPointers = $10;

{ track usage bits }
	trackUsageInMovie			= $02;
	trackUsageInPreview			= $04;
	trackUsageInPoster			= $08;

{ Add/GetMediaSample flags }
	mediaSampleNotSync			= $01;							{  sample is not a sync sample (eg. is frame differenced  }
	mediaSampleShadowSync		= $02;							{  sample is a shadow sync  }

	pasteInParallel				= $01;
	showUserSettingsDialog		= $02;
	movieToFileOnlyExport		= $04;
	movieFileSpecValid			= $08;

	nextTimeMediaSample			= $01;
	nextTimeMediaEdit			= $02;
	nextTimeTrackEdit			= $04;
	nextTimeSyncSample			= $08;
	nextTimeStep				= $10;
	nextTimeEdgeOK				= $4000;
	nextTimeIgnoreActiveSegment	= $8000;


TYPE
	nextTimeFlagsEnum					= UInt16;

CONST
	createMovieFileDeleteCurFile = $80000000;
	createMovieFileDontCreateMovie = $40000000;
	createMovieFileDontOpenFile	= $20000000;
	createMovieFileDontCreateResFile = $10000000;


TYPE
	createMovieFileFlagsEnum			= UInt32;

CONST
	flattenAddMovieToDataFork	= $00000001;
	flattenActiveTracksOnly		= $00000004;
	flattenDontInterleaveFlatten = $00000008;
	flattenFSSpecPtrIsDataRefRecordPtr = $00000010;
	flattenCompressMovieResource = $00000020;
	flattenForceMovieResourceBeforeMovieData = $00000040;


TYPE
	movieFlattenFlagsEnum				= UInt32;

CONST
	movieInDataForkResID		= -1;							{  magic res ID  }

	mcTopLeftMovie				= $01;							{  usually centered  }
	mcScaleMovieToFit			= $02;							{  usually only scales down  }
	mcWithBadge					= $04;							{  give me a badge  }
	mcNotVisible				= $08;							{  don't show controller  }
	mcWithFrame					= $10;							{  gimme a frame  }

	movieScrapDontZeroScrap		= $01;
	movieScrapOnlyPutMovie		= $02;

	dataRefSelfReference		= $01;
	dataRefWasNotResolved		= $02;


TYPE
	dataRefAttributesFlags				= UInt32;

CONST
	hintsScrubMode				= $01;							{  mask == && (if flags == scrub on, flags != scrub off)  }
	hintsLoop					= $02;
	hintsDontPurge				= $04;
	hintsUseScreenBuffer		= $20;
	hintsAllowInterlace			= $40;
	hintsUseSoundInterp			= $80;
	hintsHighQuality			= $0100;						{  slooooow  }
	hintsPalindrome				= $0200;
	hintsInactive				= $0800;
	hintsOffscreen				= $1000;
	hintsDontDraw				= $2000;
	hintsAllowBlacklining		= $4000;


TYPE
	playHintsEnum						= UInt32;

CONST
	mediaHandlerFlagBaseClient	= 1;


TYPE
	mediaHandlerFlagsEnum				= UInt32;

CONST
	movieTrackMediaType			= $01;
	movieTrackCharacteristic	= $02;
	movieTrackEnabledOnly		= $04;


TYPE
	SampleReferenceRecordPtr = ^SampleReferenceRecord;
	SampleReferenceRecord = RECORD
		dataOffset:				LONGINT;
		dataSize:				LONGINT;
		durationPerSample:		TimeValue;
		numberOfSamples:		LONGINT;
		sampleFlags:			INTEGER;
	END;

	SampleReferencePtr					= ^SampleReferenceRecord;

{************************
* Initialization Routines 
*************************}
FUNCTION EnterMovies: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AAAA;
	{$ENDC}
PROCEDURE ExitMovies;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AAAA;
	{$ENDC}
{************************
* Error Routines 
*************************}

FUNCTION GetMoviesError: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AAAA;
	{$ENDC}
PROCEDURE ClearMoviesStickyError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00DE, $AAAA;
	{$ENDC}
FUNCTION GetMoviesStickyError: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AAAA;
	{$ENDC}
PROCEDURE SetMoviesErrorProc(errProc: MoviesErrorUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EF, $AAAA;
	{$ENDC}
{************************
* Idle Routines 
*************************}
PROCEDURE MoviesTask(theMovie: Movie; maxMilliSecToUse: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AAAA;
	{$ENDC}
FUNCTION PrerollMovie(theMovie: Movie; time: TimeValue; Rate: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AAAA;
	{$ENDC}
FUNCTION LoadMovieIntoRam(theMovie: Movie; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AAAA;
	{$ENDC}
FUNCTION LoadTrackIntoRam(theTrack: Track; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016E, $AAAA;
	{$ENDC}
FUNCTION LoadMediaIntoRam(theMedia: Media; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AAAA;
	{$ENDC}
PROCEDURE SetMovieActive(theMovie: Movie; active: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AAAA;
	{$ENDC}
FUNCTION GetMovieActive(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AAAA;
	{$ENDC}
{************************
* calls for playing movies, previews, posters
*************************}
PROCEDURE StartMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AAAA;
	{$ENDC}
PROCEDURE StopMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AAAA;
	{$ENDC}
PROCEDURE GoToBeginningOfMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AAAA;
	{$ENDC}
PROCEDURE GoToEndOfMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AAAA;
	{$ENDC}
FUNCTION IsMovieDone(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00DD, $AAAA;
	{$ENDC}
FUNCTION GetMoviePreviewMode(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreviewMode(theMovie: Movie; usePreview: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AAAA;
	{$ENDC}
PROCEDURE ShowMoviePoster(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AAAA;
	{$ENDC}
PROCEDURE PlayMoviePreview(theMovie: Movie; callOutProc: MoviePreviewCallOutUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F2, $AAAA;
	{$ENDC}
{************************
* calls for controlling movies & tracks which are playing
*************************}
FUNCTION GetMovieTimeBase(theMovie: Movie): TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AAAA;
	{$ENDC}
PROCEDURE SetMovieMasterTimeBase(theMovie: Movie; tb: TimeBase; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0167, $AAAA;
	{$ENDC}
PROCEDURE SetMovieMasterClock(theMovie: Movie; clockMeister: Component; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0168, $AAAA;
	{$ENDC}
PROCEDURE GetMovieGWorld(theMovie: Movie; VAR port: CGrafPtr; VAR gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AAAA;
	{$ENDC}
PROCEDURE SetMovieGWorld(theMovie: Movie; port: CGrafPtr; gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $AAAA;
	{$ENDC}

CONST
	movieDrawingCallWhenChanged	= 0;
	movieDrawingCallAlways		= 1;

PROCEDURE SetMovieDrawingCompleteProc(theMovie: Movie; flags: LONGINT; proc: MovieDrawingCompleteUPP; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01DE, $AAAA;
	{$ENDC}

PROCEDURE GetMovieNaturalBoundsRect(theMovie: Movie; VAR naturalBounds: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $AAAA;
	{$ENDC}
FUNCTION GetNextTrackForCompositing(theMovie: Movie; theTrack: Track): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01FA, $AAAA;
	{$ENDC}
FUNCTION GetPrevTrackForCompositing(theMovie: Movie; theTrack: Track): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01FB, $AAAA;
	{$ENDC}
PROCEDURE SetTrackGWorld(theTrack: Track; port: CGrafPtr; gdh: GDHandle; proc: TrackTransferUPP; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009D, $AAAA;
	{$ENDC}
FUNCTION GetMoviePict(theMovie: Movie; time: TimeValue): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $AAAA;
	{$ENDC}
FUNCTION GetTrackPict(theTrack: Track; time: TimeValue): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $AAAA;
	{$ENDC}
FUNCTION GetMoviePosterPict(theMovie: Movie): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F7, $AAAA;
	{$ENDC}
{ called between Begin & EndUpdate }
FUNCTION UpdateMovie(theMovie: Movie): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $AAAA;
	{$ENDC}
FUNCTION InvalidateMovieRegion(theMovie: Movie; invalidRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022A, $AAAA;
	{$ENDC}
{*** spatial movie routines ***}
PROCEDURE GetMovieBox(theMovie: Movie; VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F9, $AAAA;
	{$ENDC}
PROCEDURE SetMovieBox(theMovie: Movie; {CONST}VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FA, $AAAA;
	{$ENDC}
{* movie display clip }
FUNCTION GetMovieDisplayClipRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FC, $AAAA;
	{$ENDC}
PROCEDURE SetMovieDisplayClipRgn(theMovie: Movie; theClip: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FD, $AAAA;
	{$ENDC}
{* movie src clip }
FUNCTION GetMovieClipRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0100, $AAAA;
	{$ENDC}
PROCEDURE SetMovieClipRgn(theMovie: Movie; theClip: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0101, $AAAA;
	{$ENDC}
{* track src clip }
FUNCTION GetTrackClipRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0102, $AAAA;
	{$ENDC}
PROCEDURE SetTrackClipRgn(theTrack: Track; theClip: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0103, $AAAA;
	{$ENDC}
{* bounds in display space (not clipped by display clip) }
FUNCTION GetMovieDisplayBoundsRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FB, $AAAA;
	{$ENDC}
FUNCTION GetTrackDisplayBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0112, $AAAA;
	{$ENDC}
{* bounds in movie space }
FUNCTION GetMovieBoundsRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FE, $AAAA;
	{$ENDC}
FUNCTION GetTrackMovieBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FF, $AAAA;
	{$ENDC}
{* bounds in track space }
FUNCTION GetTrackBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0111, $AAAA;
	{$ENDC}
{* mattes - always in track space }
FUNCTION GetTrackMatte(theTrack: Track): PixMapHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0115, $AAAA;
	{$ENDC}
PROCEDURE SetTrackMatte(theTrack: Track; theMatte: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0116, $AAAA;
	{$ENDC}
PROCEDURE DisposeMatte(theMatte: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014A, $AAAA;
	{$ENDC}
{************************
* calls for getting/saving movies
*************************}
FUNCTION NewMovie(flags: LONGINT): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0187, $AAAA;
	{$ENDC}
FUNCTION PutMovieIntoHandle(theMovie: Movie; publicMovie: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $AAAA;
	{$ENDC}
FUNCTION PutMovieIntoDataFork(theMovie: Movie; fRefNum: INTEGER; offset: LONGINT; maxSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01B4, $AAAA;
	{$ENDC}
PROCEDURE DisposeMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $AAAA;
	{$ENDC}
{************************
* Movie State Routines
*************************}
FUNCTION GetMovieCreationTime(theMovie: Movie): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $AAAA;
	{$ENDC}
FUNCTION GetMovieModificationTime(theMovie: Movie): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $AAAA;
	{$ENDC}
FUNCTION GetMovieTimeScale(theMovie: Movie): TimeScale;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $AAAA;
	{$ENDC}
PROCEDURE SetMovieTimeScale(theMovie: Movie; timeScale: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702A, $AAAA;
	{$ENDC}
FUNCTION GetMovieDuration(theMovie: Movie): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $AAAA;
	{$ENDC}
FUNCTION GetMovieRate(theMovie: Movie): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702C, $AAAA;
	{$ENDC}
PROCEDURE SetMovieRate(theMovie: Movie; rate: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702D, $AAAA;
	{$ENDC}
FUNCTION GetMoviePreferredRate(theMovie: Movie): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F3, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreferredRate(theMovie: Movie; rate: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F4, $AAAA;
	{$ENDC}
FUNCTION GetMoviePreferredVolume(theMovie: Movie): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F5, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreferredVolume(theMovie: Movie; volume: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F6, $AAAA;
	{$ENDC}
FUNCTION GetMovieVolume(theMovie: Movie): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702E, $AAAA;
	{$ENDC}
PROCEDURE SetMovieVolume(theMovie: Movie; volume: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702F, $AAAA;
	{$ENDC}
PROCEDURE GetMovieMatrix(theMovie: Movie; VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7031, $AAAA;
	{$ENDC}
PROCEDURE SetMovieMatrix(theMovie: Movie; {CONST}VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7032, $AAAA;
	{$ENDC}
PROCEDURE GetMoviePreviewTime(theMovie: Movie; VAR previewTime: TimeValue; VAR previewDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7033, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreviewTime(theMovie: Movie; previewTime: TimeValue; previewDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7034, $AAAA;
	{$ENDC}
FUNCTION GetMoviePosterTime(theMovie: Movie): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePosterTime(theMovie: Movie; posterTime: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $AAAA;
	{$ENDC}
PROCEDURE GetMovieSelection(theMovie: Movie; VAR selectionTime: TimeValue; VAR selectionDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7037, $AAAA;
	{$ENDC}
PROCEDURE SetMovieSelection(theMovie: Movie; selectionTime: TimeValue; selectionDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7038, $AAAA;
	{$ENDC}
PROCEDURE SetMovieActiveSegment(theMovie: Movie; startTime: TimeValue; duration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015C, $AAAA;
	{$ENDC}
PROCEDURE GetMovieActiveSegment(theMovie: Movie; VAR startTime: TimeValue; VAR duration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015D, $AAAA;
	{$ENDC}
FUNCTION GetMovieTime(theMovie: Movie; VAR currentTime: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7039, $AAAA;
	{$ENDC}
PROCEDURE SetMovieTime(theMovie: Movie; {CONST}VAR newtime: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703C, $AAAA;
	{$ENDC}
PROCEDURE SetMovieTimeValue(theMovie: Movie; newtime: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703D, $AAAA;
	{$ENDC}

FUNCTION GetMovieUserData(theMovie: Movie): UserData;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703E, $AAAA;
	{$ENDC}

{************************
* Track/Media finding routines
*************************}
FUNCTION GetMovieTrackCount(theMovie: Movie): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703F, $AAAA;
	{$ENDC}
FUNCTION GetMovieTrack(theMovie: Movie; trackID: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7040, $AAAA;
	{$ENDC}
FUNCTION GetMovieIndTrack(theMovie: Movie; index: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0117, $AAAA;
	{$ENDC}
FUNCTION GetMovieIndTrackType(theMovie: Movie; index: LONGINT; trackType: OSType; flags: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0208, $AAAA;
	{$ENDC}
FUNCTION GetTrackID(theTrack: Track): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0127, $AAAA;
	{$ENDC}
FUNCTION GetTrackMovie(theTrack: Track): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D0, $AAAA;
	{$ENDC}
{************************
* Track creation routines
*************************}
FUNCTION NewMovieTrack(theMovie: Movie; width: Fixed; height: Fixed; trackVolume: INTEGER): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0188, $AAAA;
	{$ENDC}
PROCEDURE DisposeMovieTrack(theTrack: Track);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7042, $AAAA;
	{$ENDC}
{************************
* Track State routines
*************************}
FUNCTION GetTrackCreationTime(theTrack: Track): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7043, $AAAA;
	{$ENDC}
FUNCTION GetTrackModificationTime(theTrack: Track): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7044, $AAAA;
	{$ENDC}

FUNCTION GetTrackEnabled(theTrack: Track): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7045, $AAAA;
	{$ENDC}
PROCEDURE SetTrackEnabled(theTrack: Track; isEnabled: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7046, $AAAA;
	{$ENDC}
FUNCTION GetTrackUsage(theTrack: Track): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7047, $AAAA;
	{$ENDC}
PROCEDURE SetTrackUsage(theTrack: Track; usage: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7048, $AAAA;
	{$ENDC}
FUNCTION GetTrackDuration(theTrack: Track): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $704B, $AAAA;
	{$ENDC}
FUNCTION GetTrackOffset(theTrack: Track): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $704C, $AAAA;
	{$ENDC}
PROCEDURE SetTrackOffset(theTrack: Track; movieOffsetTime: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $704D, $AAAA;
	{$ENDC}
FUNCTION GetTrackLayer(theTrack: Track): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7050, $AAAA;
	{$ENDC}
PROCEDURE SetTrackLayer(theTrack: Track; layer: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7051, $AAAA;
	{$ENDC}
FUNCTION GetTrackAlternate(theTrack: Track): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7052, $AAAA;
	{$ENDC}
PROCEDURE SetTrackAlternate(theTrack: Track; alternateT: Track);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7053, $AAAA;
	{$ENDC}
PROCEDURE SetAutoTrackAlternatesEnabled(theMovie: Movie; enable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015E, $AAAA;
	{$ENDC}
PROCEDURE SelectMovieAlternates(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015F, $AAAA;
	{$ENDC}
FUNCTION GetTrackVolume(theTrack: Track): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7054, $AAAA;
	{$ENDC}
PROCEDURE SetTrackVolume(theTrack: Track; volume: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7055, $AAAA;
	{$ENDC}
PROCEDURE GetTrackMatrix(theTrack: Track; VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7056, $AAAA;
	{$ENDC}
PROCEDURE SetTrackMatrix(theTrack: Track; {CONST}VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7057, $AAAA;
	{$ENDC}
PROCEDURE GetTrackDimensions(theTrack: Track; VAR width: Fixed; VAR height: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $705D, $AAAA;
	{$ENDC}
PROCEDURE SetTrackDimensions(theTrack: Track; width: Fixed; height: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $705E, $AAAA;
	{$ENDC}
FUNCTION GetTrackUserData(theTrack: Track): UserData;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $705F, $AAAA;
	{$ENDC}
FUNCTION GetTrackDisplayMatrix(theTrack: Track; VAR matrix: MatrixRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0263, $AAAA;
	{$ENDC}
FUNCTION GetTrackSoundLocalizationSettings(theTrack: Track; VAR settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0282, $AAAA;
	{$ENDC}
FUNCTION SetTrackSoundLocalizationSettings(theTrack: Track; settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0283, $AAAA;
	{$ENDC}
{************************
* get Media routines
*************************}
FUNCTION NewTrackMedia(theTrack: Track; mediaType: OSType; timeScale: TimeScale; dataRef: Handle; dataRefType: OSType): Media;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018E, $AAAA;
	{$ENDC}
PROCEDURE DisposeTrackMedia(theMedia: Media);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7061, $AAAA;
	{$ENDC}
FUNCTION GetTrackMedia(theTrack: Track): Media;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7062, $AAAA;
	{$ENDC}
FUNCTION GetMediaTrack(theMedia: Media): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00C5, $AAAA;
	{$ENDC}


{************************
* Media State routines
*************************}
FUNCTION GetMediaCreationTime(theMedia: Media): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7066, $AAAA;
	{$ENDC}
FUNCTION GetMediaModificationTime(theMedia: Media): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7067, $AAAA;
	{$ENDC}
FUNCTION GetMediaTimeScale(theMedia: Media): TimeScale;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7068, $AAAA;
	{$ENDC}
PROCEDURE SetMediaTimeScale(theMedia: Media; timeScale: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7069, $AAAA;
	{$ENDC}
FUNCTION GetMediaDuration(theMedia: Media): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706A, $AAAA;
	{$ENDC}
FUNCTION GetMediaLanguage(theMedia: Media): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706B, $AAAA;
	{$ENDC}
PROCEDURE SetMediaLanguage(theMedia: Media; language: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706C, $AAAA;
	{$ENDC}
FUNCTION GetMediaQuality(theMedia: Media): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706D, $AAAA;
	{$ENDC}
PROCEDURE SetMediaQuality(theMedia: Media; quality: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706E, $AAAA;
	{$ENDC}
PROCEDURE GetMediaHandlerDescription(theMedia: Media; VAR mediaType: OSType; VAR creatorName: Str255; VAR creatorManufacturer: OSType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706F, $AAAA;
	{$ENDC}
FUNCTION GetMediaUserData(theMedia: Media): UserData;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7070, $AAAA;
	{$ENDC}
FUNCTION GetMediaInputMap(theMedia: Media; VAR inputMap: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0249, $AAAA;
	{$ENDC}
FUNCTION SetMediaInputMap(theMedia: Media; inputMap: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $024A, $AAAA;
	{$ENDC}
{************************
* Media Handler routines
*************************}
FUNCTION GetMediaHandler(theMedia: Media): MediaHandler;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7071, $AAAA;
	{$ENDC}
FUNCTION SetMediaHandler(theMedia: Media; mH: MediaHandlerComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0190, $AAAA;
	{$ENDC}

{************************
* Media's Data routines
*************************}
FUNCTION BeginMediaEdits(theMedia: Media): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7072, $AAAA;
	{$ENDC}
FUNCTION EndMediaEdits(theMedia: Media): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7073, $AAAA;
	{$ENDC}
FUNCTION SetMediaDefaultDataRefIndex(theMedia: Media; index: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01E0, $AAAA;
	{$ENDC}
PROCEDURE GetMediaDataHandlerDescription(theMedia: Media; index: INTEGER; VAR dhType: OSType; VAR creatorName: Str255; VAR creatorManufacturer: OSType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019E, $AAAA;
	{$ENDC}
FUNCTION GetMediaDataHandler(theMedia: Media; index: INTEGER): DataHandler;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019F, $AAAA;
	{$ENDC}
FUNCTION SetMediaDataHandler(theMedia: Media; index: INTEGER; dataHandler: DataHandlerComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A0, $AAAA;
	{$ENDC}
FUNCTION GetDataHandler(dataRef: Handle; dataHandlerSubType: OSType; flags: LONGINT): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01ED, $AAAA;
	{$ENDC}

{************************
* Media Sample Table Routines
*************************}
FUNCTION GetMediaSampleDescriptionCount(theMedia: Media): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7077, $AAAA;
	{$ENDC}
PROCEDURE GetMediaSampleDescription(theMedia: Media; index: LONGINT; descH: SampleDescriptionHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7078, $AAAA;
	{$ENDC}
FUNCTION SetMediaSampleDescription(theMedia: Media; index: LONGINT; descH: SampleDescriptionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01D0, $AAAA;
	{$ENDC}
FUNCTION GetMediaSampleCount(theMedia: Media): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7079, $AAAA;
	{$ENDC}
FUNCTION GetMediaSyncSampleCount(theMedia: Media): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B2, $AAAA;
	{$ENDC}
PROCEDURE SampleNumToMediaTime(theMedia: Media; logicalSampleNum: LONGINT; VAR sampleTime: TimeValue; VAR sampleDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707A, $AAAA;
	{$ENDC}
PROCEDURE MediaTimeToSampleNum(theMedia: Media; time: TimeValue; VAR sampleNum: LONGINT; VAR sampleTime: TimeValue; VAR sampleDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707B, $AAAA;
	{$ENDC}

FUNCTION AddMediaSample(theMedia: Media; dataIn: Handle; inOffset: LONGINT; size: UInt32; durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleFlags: INTEGER; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707C, $AAAA;
	{$ENDC}
FUNCTION AddMediaSampleReference(theMedia: Media; dataOffset: LONGINT; size: UInt32; durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleFlags: INTEGER; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707D, $AAAA;
	{$ENDC}
FUNCTION AddMediaSampleReferences(theMedia: Media; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleRefs: SampleReferencePtr; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F7, $AAAA;
	{$ENDC}
FUNCTION GetMediaSample(theMedia: Media; dataOut: Handle; maxSizeToGrow: LONGINT; VAR size: LONGINT; time: TimeValue; VAR sampleTime: TimeValue; VAR durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfSamples: LONGINT; VAR numberOfSamples: LONGINT; VAR sampleFlags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707E, $AAAA;
	{$ENDC}
FUNCTION GetMediaSampleReference(theMedia: Media; VAR dataOffset: LONGINT; VAR size: LONGINT; time: TimeValue; VAR sampleTime: TimeValue; VAR durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfSamples: LONGINT; VAR numberOfSamples: LONGINT; VAR sampleFlags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707F, $AAAA;
	{$ENDC}
FUNCTION GetMediaSampleReferences(theMedia: Media; time: TimeValue; VAR sampleTime: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfEntries: LONGINT; VAR actualNumberofEntries: LONGINT; sampleRefs: SampleReferencePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0235, $AAAA;
	{$ENDC}
FUNCTION SetMediaPreferredChunkSize(theMedia: Media; maxChunkSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F8, $AAAA;
	{$ENDC}
FUNCTION GetMediaPreferredChunkSize(theMedia: Media; VAR maxChunkSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F9, $AAAA;
	{$ENDC}
FUNCTION SetMediaShadowSync(theMedia: Media; frameDiffSampleNum: LONGINT; syncSampleNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0121, $AAAA;
	{$ENDC}
FUNCTION GetMediaShadowSync(theMedia: Media; frameDiffSampleNum: LONGINT; VAR syncSampleNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0122, $AAAA;
	{$ENDC}
{************************
* Editing Routines
*************************}
FUNCTION InsertMediaIntoTrack(theTrack: Track; trackStart: TimeValue; mediaTime: TimeValue; mediaDuration: TimeValue; mediaRate: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0183, $AAAA;
	{$ENDC}
FUNCTION InsertTrackSegment(srcTrack: Track; dstTrack: Track; srcIn: TimeValue; srcDuration: TimeValue; dstIn: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0085, $AAAA;
	{$ENDC}
FUNCTION InsertMovieSegment(srcMovie: Movie; dstMovie: Movie; srcIn: TimeValue; srcDuration: TimeValue; dstIn: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0086, $AAAA;
	{$ENDC}
FUNCTION InsertEmptyTrackSegment(dstTrack: Track; dstIn: TimeValue; dstDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0087, $AAAA;
	{$ENDC}
FUNCTION InsertEmptyMovieSegment(dstMovie: Movie; dstIn: TimeValue; dstDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0088, $AAAA;
	{$ENDC}
FUNCTION DeleteTrackSegment(theTrack: Track; startTime: TimeValue; duration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0089, $AAAA;
	{$ENDC}
FUNCTION DeleteMovieSegment(theMovie: Movie; startTime: TimeValue; duration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008A, $AAAA;
	{$ENDC}
FUNCTION ScaleTrackSegment(theTrack: Track; startTime: TimeValue; oldDuration: TimeValue; newDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008B, $AAAA;
	{$ENDC}
FUNCTION ScaleMovieSegment(theMovie: Movie; startTime: TimeValue; oldDuration: TimeValue; newDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008C, $AAAA;
	{$ENDC}

{************************
* Hi-level Editing Routines
*************************}
FUNCTION CutMovieSelection(theMovie: Movie): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008D, $AAAA;
	{$ENDC}
FUNCTION CopyMovieSelection(theMovie: Movie): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008E, $AAAA;
	{$ENDC}
PROCEDURE PasteMovieSelection(theMovie: Movie; src: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008F, $AAAA;
	{$ENDC}
PROCEDURE AddMovieSelection(theMovie: Movie; src: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0152, $AAAA;
	{$ENDC}
PROCEDURE ClearMovieSelection(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00E1, $AAAA;
	{$ENDC}
FUNCTION PasteHandleIntoMovie(h: Handle; handleType: OSType; theMovie: Movie; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00CB, $AAAA;
	{$ENDC}
FUNCTION PutMovieIntoTypedHandle(theMovie: Movie; targetTrack: Track; handleType: OSType; publicMovie: Handle; start: TimeValue; dur: TimeValue; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CD, $AAAA;
	{$ENDC}
FUNCTION IsScrapMovie(targetTrack: Track): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00CC, $AAAA;
	{$ENDC}
{************************
* Middle-level Editing Routines
*************************}
FUNCTION CopyTrackSettings(srcTrack: Track; dstTrack: Track): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0153, $AAAA;
	{$ENDC}
FUNCTION CopyMovieSettings(srcMovie: Movie; dstMovie: Movie): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0154, $AAAA;
	{$ENDC}
FUNCTION AddEmptyTrackToMovie(srcTrack: Track; dstMovie: Movie; dataRef: Handle; dataRefType: OSType; VAR dstTrack: Track): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7074, $AAAA;
	{$ENDC}
{************************
* movie & track edit state routines
*************************}
FUNCTION NewMovieEditState(theMovie: Movie): MovieEditState;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0104, $AAAA;
	{$ENDC}
FUNCTION UseMovieEditState(theMovie: Movie; toState: MovieEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0105, $AAAA;
	{$ENDC}
FUNCTION DisposeMovieEditState(state: MovieEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0106, $AAAA;
	{$ENDC}
FUNCTION NewTrackEditState(theTrack: Track): TrackEditState;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0107, $AAAA;
	{$ENDC}
FUNCTION UseTrackEditState(theTrack: Track; state: TrackEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0108, $AAAA;
	{$ENDC}
FUNCTION DisposeTrackEditState(state: TrackEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0109, $AAAA;
	{$ENDC}
{************************
* track reference routines
*************************}
FUNCTION AddTrackReference(theTrack: Track; refTrack: Track; refType: OSType; VAR addedIndex: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F0, $AAAA;
	{$ENDC}
FUNCTION DeleteTrackReference(theTrack: Track; refType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F1, $AAAA;
	{$ENDC}
FUNCTION SetTrackReference(theTrack: Track; refTrack: Track; refType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F2, $AAAA;
	{$ENDC}
FUNCTION GetTrackReference(theTrack: Track; refType: OSType; index: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F3, $AAAA;
	{$ENDC}
FUNCTION GetNextTrackReferenceType(theTrack: Track; refType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F4, $AAAA;
	{$ENDC}
FUNCTION GetTrackReferenceCount(theTrack: Track; refType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F5, $AAAA;
	{$ENDC}

{************************
* high level file conversion routines
*************************}
FUNCTION ConvertFileToMovieFile({CONST}VAR inputFile: FSSpec; {CONST}VAR outputFile: FSSpec; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance; proc: MovieProgressUPP; refCon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CB, $AAAA;
	{$ENDC}
FUNCTION ConvertMovieToFile(theMovie: Movie; onlyTrack: Track; VAR outputFile: FSSpec; fileType: OSType; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CC, $AAAA;
	{$ENDC}

CONST
	kGetMovieImporterValidateToFind = $00000001;
	kGetMovieImporterAllowNewFile = $00000002;
	kGetMovieImporterDontConsiderGraphicsImporters = $00000004;

FUNCTION GetMovieImporterForDataRef(dataRefType: OSType; dataRef: Handle; flags: LONGINT; VAR importer: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C7, $AAAA;
	{$ENDC}
{************************
* Movie Timebase Conversion Routines
*************************}
FUNCTION TrackTimeToMediaTime(value: TimeValue; theTrack: Track): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0096, $AAAA;
	{$ENDC}
FUNCTION GetTrackEditRate(theTrack: Track; atTime: TimeValue): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0123, $AAAA;
	{$ENDC}

{************************
* Miscellaneous Routines
*************************}

FUNCTION GetMovieDataSize(theMovie: Movie; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0098, $AAAA;
	{$ENDC}
FUNCTION GetTrackDataSize(theTrack: Track; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0149, $AAAA;
	{$ENDC}
FUNCTION GetMediaDataSize(theMedia: Media; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0099, $AAAA;
	{$ENDC}
FUNCTION PtInMovie(theMovie: Movie; pt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009A, $AAAA;
	{$ENDC}
FUNCTION PtInTrack(theTrack: Track; pt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009B, $AAAA;
	{$ENDC}

{************************
* Group Selection Routines
*************************}

PROCEDURE SetMovieLanguage(theMovie: Movie; language: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009C, $AAAA;
	{$ENDC}

{************************
* User Data
*************************}

FUNCTION GetUserData(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009E, $AAAA;
	{$ENDC}
FUNCTION AddUserData(theUserData: UserData; data: Handle; udType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009F, $AAAA;
	{$ENDC}
FUNCTION RemoveUserData(theUserData: UserData; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A0, $AAAA;
	{$ENDC}
FUNCTION CountUserDataType(theUserData: UserData; udType: OSType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014B, $AAAA;
	{$ENDC}
FUNCTION GetNextUserDataType(theUserData: UserData; udType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A5, $AAAA;
	{$ENDC}
FUNCTION GetUserDataItem(theUserData: UserData; data: UNIV Ptr; size: LONGINT; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0126, $AAAA;
	{$ENDC}
FUNCTION SetUserDataItem(theUserData: UserData; data: UNIV Ptr; size: LONGINT; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012E, $AAAA;
	{$ENDC}
FUNCTION AddUserDataText(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014C, $AAAA;
	{$ENDC}
FUNCTION GetUserDataText(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014D, $AAAA;
	{$ENDC}
FUNCTION RemoveUserDataText(theUserData: UserData; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014E, $AAAA;
	{$ENDC}
FUNCTION NewUserData(VAR theUserData: UserData): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012F, $AAAA;
	{$ENDC}
FUNCTION DisposeUserData(theUserData: UserData): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0130, $AAAA;
	{$ENDC}
FUNCTION NewUserDataFromHandle(h: Handle; VAR theUserData: UserData): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0131, $AAAA;
	{$ENDC}
FUNCTION PutUserDataIntoHandle(theUserData: UserData; h: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0132, $AAAA;
	{$ENDC}
PROCEDURE GetMediaNextInterestingTime(theMedia: Media; interestingTimeFlags: INTEGER; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016D, $AAAA;
	{$ENDC}
PROCEDURE GetTrackNextInterestingTime(theTrack: Track; interestingTimeFlags: INTEGER; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00E2, $AAAA;
	{$ENDC}
PROCEDURE GetMovieNextInterestingTime(theMovie: Movie; interestingTimeFlags: INTEGER; numMediaTypes: INTEGER; {CONST}VAR whichMediaTypes: OSType; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010E, $AAAA;
	{$ENDC}

FUNCTION CreateMovieFile({CONST}VAR fileSpec: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; VAR resRefNum: INTEGER; VAR newmovie: Movie): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0191, $AAAA;
	{$ENDC}
FUNCTION OpenMovieFile({CONST}VAR fileSpec: FSSpec; VAR resRefNum: INTEGER; permission: SInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0192, $AAAA;
	{$ENDC}
FUNCTION CloseMovieFile(resRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D5, $AAAA;
	{$ENDC}
FUNCTION DeleteMovieFile({CONST}VAR fileSpec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0175, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromFile(VAR theMovie: Movie; resRefNum: INTEGER; VAR resId: INTEGER; resName: StringPtr; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F0, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromHandle(VAR theMovie: Movie; h: Handle; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F1, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromDataFork(VAR theMovie: Movie; fRefNum: INTEGER; fileOffset: LONGINT; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01B3, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromUserProc(VAR m: Movie; flags: INTEGER; VAR dataRefWasChanged: BOOLEAN; getProc: GetMovieUPP; refCon: UNIV Ptr; defaultDataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01EC, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromDataRef(VAR m: Movie; flags: INTEGER; VAR id: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0220, $AAAA;
	{$ENDC}
FUNCTION AddMovieResource(theMovie: Movie; resRefNum: INTEGER; VAR resId: INTEGER; resName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D7, $AAAA;
	{$ENDC}
FUNCTION UpdateMovieResource(theMovie: Movie; resRefNum: INTEGER; resId: INTEGER; resName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D8, $AAAA;
	{$ENDC}
FUNCTION RemoveMovieResource(resRefNum: INTEGER; resId: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0176, $AAAA;
	{$ENDC}
FUNCTION HasMovieChanged(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D9, $AAAA;
	{$ENDC}
PROCEDURE ClearMovieChanged(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0113, $AAAA;
	{$ENDC}
FUNCTION SetMovieDefaultDataRef(theMovie: Movie; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01C1, $AAAA;
	{$ENDC}
FUNCTION GetMovieDefaultDataRef(theMovie: Movie; VAR dataRef: Handle; VAR dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01D2, $AAAA;
	{$ENDC}
FUNCTION SetMovieColorTable(theMovie: Movie; ctab: CTabHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0205, $AAAA;
	{$ENDC}
FUNCTION GetMovieColorTable(theMovie: Movie; VAR ctab: CTabHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $AAAA;
	{$ENDC}
PROCEDURE FlattenMovie(theMovie: Movie; movieFlattenFlags: LONGINT; {CONST}VAR theFile: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; VAR resId: INTEGER; resName: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019B, $AAAA;
	{$ENDC}
FUNCTION FlattenMovieData(theMovie: Movie; movieFlattenFlags: LONGINT; {CONST}VAR theFile: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019C, $AAAA;
	{$ENDC}
PROCEDURE SetMovieProgressProc(theMovie: Movie; p: MovieProgressUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019A, $AAAA;
	{$ENDC}
FUNCTION MovieSearchText(theMovie: Movie; text: Ptr; size: LONGINT; searchFlags: LONGINT; VAR searchTrack: Track; VAR searchTime: TimeValue; VAR searchOffset: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0207, $AAAA;
	{$ENDC}
PROCEDURE GetPosterBox(theMovie: Movie; VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016F, $AAAA;
	{$ENDC}
PROCEDURE SetPosterBox(theMovie: Movie; {CONST}VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0170, $AAAA;
	{$ENDC}
FUNCTION GetMovieSegmentDisplayBoundsRgn(theMovie: Movie; time: TimeValue; duration: TimeValue): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016C, $AAAA;
	{$ENDC}
FUNCTION GetTrackSegmentDisplayBoundsRgn(theTrack: Track; time: TimeValue; duration: TimeValue): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016B, $AAAA;
	{$ENDC}
PROCEDURE SetMovieCoverProcs(theMovie: Movie; uncoverProc: MovieRgnCoverUPP; coverProc: MovieRgnCoverUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0179, $AAAA;
	{$ENDC}
FUNCTION GetMovieCoverProcs(theMovie: Movie; VAR uncoverProc: MovieRgnCoverUPP; VAR coverProc: MovieRgnCoverUPP; VAR refcon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01DD, $AAAA;
	{$ENDC}
FUNCTION GetTrackStatus(theTrack: Track): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0172, $AAAA;
	{$ENDC}
FUNCTION GetMovieStatus(theMovie: Movie; VAR firstProblemTrack: Track): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0173, $AAAA;
	{$ENDC}
{***
	Movie Controller support routines
***}
FUNCTION NewMovieController(theMovie: Movie; {CONST}VAR movieRect: Rect; someFlags: LONGINT): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018A, $AAAA;
	{$ENDC}
PROCEDURE DisposeMovieController(mc: ComponentInstance);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018B, $AAAA;
	{$ENDC}
PROCEDURE ShowMovieInformation(theMovie: Movie; filterProc: ModalFilterUPP; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0209, $AAAA;
	{$ENDC}

{****
	Scrap routines
****}
FUNCTION PutMovieOnScrap(theMovie: Movie; movieScrapFlags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018C, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromScrap(newMovieFlags: LONGINT): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018D, $AAAA;
	{$ENDC}

{****
	DataRef routines
****}

FUNCTION GetMediaDataRef(theMedia: Media; index: INTEGER; VAR dataRef: Handle; VAR dataRefType: OSType; VAR dataRefAttributes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0197, $AAAA;
	{$ENDC}
FUNCTION SetMediaDataRef(theMedia: Media; index: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01C9, $AAAA;
	{$ENDC}
FUNCTION SetMediaDataRefAttributes(theMedia: Media; index: INTEGER; dataRefAttributes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CA, $AAAA;
	{$ENDC}
FUNCTION AddMediaDataRef(theMedia: Media; VAR index: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0198, $AAAA;
	{$ENDC}
FUNCTION GetMediaDataRefCount(theMedia: Media; VAR count: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0199, $AAAA;
	{$ENDC}
FUNCTION QTNewAlias({CONST}VAR fss: FSSpec; VAR alias: AliasHandle; minimal: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0201, $AAAA;
	{$ENDC}
{****
	Playback hint routines
****}
PROCEDURE SetMoviePlayHints(theMovie: Movie; flags: LONGINT; flagsMask: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A1, $AAAA;
	{$ENDC}
PROCEDURE SetMediaPlayHints(theMedia: Media; flags: LONGINT; flagsMask: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A2, $AAAA;
	{$ENDC}
PROCEDURE GetMediaPlayHints(theMedia: Media; VAR flags: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CE, $AAAA;
	{$ENDC}
{****
	Load time track hints
****}

CONST
	preloadAlways				= $00000001;
	preloadOnlyIfEnabled		= $00000002;

PROCEDURE SetTrackLoadSettings(theTrack: Track; preloadTime: TimeValue; preloadDuration: TimeValue; preloadFlags: LONGINT; defaultHints: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01E3, $AAAA;
	{$ENDC}
PROCEDURE GetTrackLoadSettings(theTrack: Track; VAR preloadTime: TimeValue; VAR preloadDuration: TimeValue; VAR preloadFlags: LONGINT; VAR defaultHints: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01E4, $AAAA;
	{$ENDC}
{****
	Big screen TV
****}

CONST
	fullScreenHideCursor		= $00000001;
	fullScreenAllowEvents		= $00000002;
	fullScreenDontChangeMenuBar	= $00000004;
	fullScreenPreflightSize		= $00000008;

FUNCTION BeginFullScreen(VAR restoreState: Ptr; whichGD: GDHandle; VAR desiredWidth: INTEGER; VAR desiredHeight: INTEGER; VAR newWindow: WindowPtr; VAR eraseColor: RGBColor; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0233, $AAAA;
	{$ENDC}
FUNCTION EndFullScreen(fullState: Ptr; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0234, $AAAA;
	{$ENDC}
{****
	Sprite Toolbox
****}

CONST
	kBackgroundSpriteLayerNum	= 32767;

{   Sprite Properties }
	kSpritePropertyMatrix		= 1;
	kSpritePropertyImageDescription = 2;
	kSpritePropertyImageDataPtr	= 3;
	kSpritePropertyVisible		= 4;
	kSpritePropertyLayer		= 5;
	kSpritePropertyGraphicsMode	= 6;
	kSpritePropertyImageDataSize = 7;
	kSpritePropertyImageIndex	= 100;
	kSpriteTrackPropertyBackgroundColor = 101;
	kSpriteTrackPropertyOffscreenBitDepth = 102;
	kSpriteTrackPropertySampleFormat = 103;
	kSpriteTrackPropertyScaleSpritesToScaleWorld = 104;
	kSpriteTrackPropertyHasActions = 105;
	kSpriteTrackPropertyVisible	= 106;
	kSpriteTrackPropertyQTIdleEventsFrequency = 107;
	kSpriteImagePropertyRegistrationPoint = 1000;
	kSpriteImagePropertyGroupID	= 1001;

{  special value for kSpriteTrackPropertyQTIdleEventsFrequency (the default) }
	kNoQTIdleEvents				= -1;

{  flagsIn for SpriteWorldIdle }
	kOnlyDrawToSpriteWorld		= $00000001;
	kSpriteWorldPreflight		= $00000002;

{  flagsOut for SpriteWorldIdle }
	kSpriteWorldDidDraw			= $00000001;
	kSpriteWorldNeedsToDraw		= $00000002;

{  flags for sprite track sample format }
	kKeyFrameAndSingleOverride	= $00000002;
	kKeyFrameAndAllOverrides	= $00000004;

{  sprite world flags }
	kScaleSpritesToScaleWorld	= $00000002;
	kSpriteWorldHighQuality		= $00000004;
	kSpriteWorldDontAutoInvalidate = $00000008;
	kSpriteWorldInvisible		= $00000010;

FUNCTION NewSpriteWorld(VAR newSpriteWorld: SpriteWorld; destination: GWorldPtr; spriteLayer: GWorldPtr; VAR backgroundColor: RGBColor; background: GWorldPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0239, $AAAA;
	{$ENDC}
PROCEDURE DisposeSpriteWorld(theSpriteWorld: SpriteWorld);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023A, $AAAA;
	{$ENDC}
FUNCTION SetSpriteWorldClip(theSpriteWorld: SpriteWorld; clipRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023B, $AAAA;
	{$ENDC}
FUNCTION SetSpriteWorldMatrix(theSpriteWorld: SpriteWorld; {CONST}VAR matrix: MatrixRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023C, $AAAA;
	{$ENDC}
FUNCTION SetSpriteWorldGraphicsMode(theSpriteWorld: SpriteWorld; mode: LONGINT; {CONST}VAR opColor: RGBColor): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D9, $AAAA;
	{$ENDC}
FUNCTION SpriteWorldIdle(theSpriteWorld: SpriteWorld; flagsIn: LONGINT; VAR flagsOut: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023D, $AAAA;
	{$ENDC}
FUNCTION InvalidateSpriteWorld(theSpriteWorld: SpriteWorld; VAR invalidArea: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023E, $AAAA;
	{$ENDC}
FUNCTION SpriteWorldHitTest(theSpriteWorld: SpriteWorld; flags: LONGINT; loc: Point; VAR spriteHit: Sprite): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0246, $AAAA;
	{$ENDC}
FUNCTION SpriteHitTest(theSprite: Sprite; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0247, $AAAA;
	{$ENDC}
PROCEDURE DisposeAllSprites(theSpriteWorld: SpriteWorld);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023F, $AAAA;
	{$ENDC}
FUNCTION SetSpriteWorldFlags(spriteWorld: SpriteWorld; flags: LONGINT; flagsMask: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C2, $AAAA;
	{$ENDC}
FUNCTION NewSprite(VAR newSprite: Sprite; itsSpriteWorld: SpriteWorld; idh: ImageDescriptionHandle; imageDataPtr: Ptr; VAR matrix: MatrixRecord; visible: BOOLEAN; layer: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0240, $AAAA;
	{$ENDC}
PROCEDURE DisposeSprite(theSprite: Sprite);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0241, $AAAA;
	{$ENDC}
PROCEDURE InvalidateSprite(theSprite: Sprite);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0242, $AAAA;
	{$ENDC}
FUNCTION SetSpriteProperty(theSprite: Sprite; propertyType: LONGINT; propertyValue: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0243, $AAAA;
	{$ENDC}
FUNCTION GetSpriteProperty(theSprite: Sprite; propertyType: LONGINT; propertyValue: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0244, $AAAA;
	{$ENDC}
{****
	QT Atom Data Support
****}

CONST
	kParentAtomIsContainer		= 0;

{  create and dispose QTAtomContainer objects }

FUNCTION QTNewAtomContainer(VAR atomData: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $AAAA;
	{$ENDC}
FUNCTION QTDisposeAtomContainer(atomData: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AAAA;
	{$ENDC}
{  locating nested atoms within QTAtomContainer container }
FUNCTION QTGetNextChildType(container: QTAtomContainer; parentAtom: QTAtom; currentChildType: QTAtomType): QTAtomType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020E, $AAAA;
	{$ENDC}
FUNCTION QTCountChildrenOfType(container: QTAtomContainer; parentAtom: QTAtom; childType: QTAtomType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020F, $AAAA;
	{$ENDC}
FUNCTION QTFindChildByIndex(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; index: INTEGER; VAR id: QTAtomID): QTAtom;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $AAAA;
	{$ENDC}
FUNCTION QTFindChildByID(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; id: QTAtomID; VAR index: INTEGER): QTAtom;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021D, $AAAA;
	{$ENDC}
FUNCTION QTNextChildAnyType(container: QTAtomContainer; parentAtom: QTAtom; currentChild: QTAtom; VAR nextChild: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0200, $AAAA;
	{$ENDC}
{  set a leaf atom's data }
FUNCTION QTSetAtomData(container: QTAtomContainer; atom: QTAtom; dataSize: LONGINT; atomData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0211, $AAAA;
	{$ENDC}
{  extracting data }
FUNCTION QTCopyAtomDataToHandle(container: QTAtomContainer; atom: QTAtom; targetHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0212, $AAAA;
	{$ENDC}
FUNCTION QTCopyAtomDataToPtr(container: QTAtomContainer; atom: QTAtom; sizeOrLessOK: BOOLEAN; size: LONGINT; targetPtr: UNIV Ptr; VAR actualSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0213, $AAAA;
	{$ENDC}
FUNCTION QTGetAtomTypeAndID(container: QTAtomContainer; atom: QTAtom; VAR atomType: QTAtomType; VAR id: QTAtomID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0232, $AAAA;
	{$ENDC}
{  extract a copy of an atom and all of it's children, caller disposes }
FUNCTION QTCopyAtom(container: QTAtomContainer; atom: QTAtom; VAR targetContainer: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0214, $AAAA;
	{$ENDC}
{  obtaining direct reference to atom data }
FUNCTION QTLockContainer(container: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0215, $AAAA;
	{$ENDC}
FUNCTION QTGetAtomDataPtr(container: QTAtomContainer; atom: QTAtom; VAR dataSize: LONGINT; VAR atomData: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0216, $AAAA;
	{$ENDC}
FUNCTION QTUnlockContainer(container: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0217, $AAAA;
	{$ENDC}
{
   building QTAtomContainer trees
   creates and inserts new atom at specified index, existing atoms at or after index are moved toward end of list
   used for Top-Down tree creation
}
FUNCTION QTInsertChild(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; id: QTAtomID; index: INTEGER; dataSize: LONGINT; data: UNIV Ptr; VAR newAtom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0218, $AAAA;
	{$ENDC}
{  inserts children from childrenContainer as children of parentAtom }
FUNCTION QTInsertChildren(container: QTAtomContainer; parentAtom: QTAtom; childrenContainer: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0219, $AAAA;
	{$ENDC}
{  destruction }
FUNCTION QTRemoveAtom(container: QTAtomContainer; atom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021A, $AAAA;
	{$ENDC}
FUNCTION QTRemoveChildren(container: QTAtomContainer; atom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021B, $AAAA;
	{$ENDC}
{  replacement must be same type as target }
FUNCTION QTReplaceAtom(targetContainer: QTAtomContainer; targetAtom: QTAtom; replacementContainer: QTAtomContainer; replacementAtom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021C, $AAAA;
	{$ENDC}
FUNCTION QTSwapAtoms(container: QTAtomContainer; atom1: QTAtom; atom2: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01FF, $AAAA;
	{$ENDC}
FUNCTION QTSetAtomID(container: QTAtomContainer; atom: QTAtom; newID: QTAtomID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0231, $AAAA;
	{$ENDC}
FUNCTION SetMediaPropertyAtom(theMedia: Media; propertyAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022E, $AAAA;
	{$ENDC}
FUNCTION GetMediaPropertyAtom(theMedia: Media; VAR propertyAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022F, $AAAA;
	{$ENDC}
{****
	Tween Support
****}
FUNCTION QTNewTween(VAR tween: QTTweener; container: QTAtomContainer; tweenAtom: QTAtom; maxTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $029D, $AAAA;
	{$ENDC}
FUNCTION QTDisposeTween(tween: QTTweener): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $029F, $AAAA;
	{$ENDC}
FUNCTION QTDoTween(tween: QTTweener; atTime: TimeValue; result: Handle; VAR resultSize: LONGINT; tweenDataProc: UNIV Ptr; tweenDataRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $029E, $AAAA;
	{$ENDC}
{****
	Sound Description Manipulations
****}
FUNCTION AddSoundDescriptionExtension(desc: SoundDescriptionHandle; extension: Handle; idType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CF, $AAAA;
	{$ENDC}
FUNCTION GetSoundDescriptionExtension(desc: SoundDescriptionHandle; VAR extension: Handle; idType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D0, $AAAA;
	{$ENDC}
FUNCTION RemoveSoundDescriptionExtension(desc: SoundDescriptionHandle; idType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D1, $AAAA;
	{$ENDC}
{****
	Preferences
****}
FUNCTION GetQuickTimePreference(preferenceType: OSType; VAR preferenceAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D4, $AAAA;
	{$ENDC}
FUNCTION SetQuickTimePreference(preferenceType: OSType; preferenceAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D5, $AAAA;
	{$ENDC}
{****
	Effects and dialog Support
****}
{  atom types for entries in the effects list }

CONST
	kEffectNameAtom				= 'name';						{  name of effect  }
	kEffectTypeAtom				= 'type';						{  codec sub-type for effect  }


TYPE
	QTParamPreviewRecordPtr = ^QTParamPreviewRecord;
	QTParamPreviewRecord = RECORD
		sourceID:				LONGINT;								{  1 based source identifier }
		sourcePicture:			PicHandle;								{  picture for preview, must not dispose until dialog is disposed }
	END;

	QTParamPreviewPtr					= ^QTParamPreviewRecord;

CONST
	pdActionConfirmDialog		= 1;							{  no param }
	pdActionSetAppleMenu		= 2;							{  param is MenuHandle }
	pdActionSetEditMenu			= 3;							{  param is MenuHandle }
	pdActionGetDialogValues		= 4;							{  param is QTAtomContainer }
	pdActionSetPreviewUserItem	= 5;							{  param is long }
	pdActionSetPreviewPicture	= 6;							{  param is QTParamPreviewPtr; }
	pdActionSetColorPickerEventProc = 7;						{  param is UserEventUPP }
	pdActionSetDialogTitle		= 8;							{  param is StringPtr  }
	pdActionGetSubPanelMenu		= 9;							{  param is MenuHandle*  }
	pdActionActivateSubPanel	= 10;							{  param is long  }
	pdActionConductStopAlert	= 11;							{  param is StringPtr  }


TYPE
	QTParameterDialog					= LONGINT;

CONST
	elOptionsIncludeNoneInList	= $00000001;					{  "None" effect is included in list  }


TYPE
	QTEffectListOptions					= LONGINT;

CONST
	pdOptionsCollectOneValue	= $00000001;					{  should collect a single value only }
	pdOptionsAllowOptionalInterpolations = $00000002;			{  non-novice interpolation options are shown  }
	pdOptionsModalDialogBox		= $00000004;					{  dialog box should be modal  }


TYPE
	QTParameterDialogOptions			= LONGINT;

CONST
	effectIsRealtime			= 0;							{  effect can be rendered in real time  }

FUNCTION QTGetEffectsList(VAR returnedList: QTAtomContainer; minSources: LONGINT; maxSources: LONGINT; getOptions: QTEffectListOptions): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C9, $AAAA;
	{$ENDC}
FUNCTION QTCreateStandardParameterDialog(effectList: QTAtomContainer; parameters: QTAtomContainer; dialogOptions: QTParameterDialogOptions; VAR createdDialog: QTParameterDialog): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CA, $AAAA;
	{$ENDC}
FUNCTION QTIsStandardParameterDialogEvent(VAR pEvent: EventRecord; createdDialog: QTParameterDialog): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CB, $AAAA;
	{$ENDC}
FUNCTION QTDismissStandardParameterDialog(createdDialog: QTParameterDialog): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CC, $AAAA;
	{$ENDC}
FUNCTION QTStandardParameterDialogDoAction(createdDialog: QTParameterDialog; action: LONGINT; params: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CD, $AAAA;
	{$ENDC}
FUNCTION QTGetEffectSpeed(parameters: QTAtomContainer; VAR pFPS: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D2, $AAAA;
	{$ENDC}
{****
	Access Keys
****}

CONST
	kAccessKeyAtomType			= 'acky';

	kAccessKeySystemFlag		= $00000001;

FUNCTION QTGetAccessKeys(VAR accessKeyType: Str255; flags: LONGINT; VAR keys: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B3, $AAAA;
	{$ENDC}
FUNCTION QTRegisterAccessKey(VAR accessKeyType: Str255; flags: LONGINT; accessKey: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B4, $AAAA;
	{$ENDC}
FUNCTION QTUnregisterAccessKey(VAR accessKeyType: Str255; flags: LONGINT; accessKey: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B5, $AAAA;
	{$ENDC}
{****
	Time table
****}
FUNCTION MakeTrackTimeTable(trackH: Track; VAR offsets: LONGINTPtr; startTime: TimeValue; endTime: TimeValue; timeIncrement: TimeValue; firstDataRefIndex: INTEGER; lastDataRefIndex: INTEGER; VAR retdataRefSkew: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02BE, $AAAA;
	{$ENDC}
FUNCTION MakeMediaTimeTable(theMedia: Media; VAR offsets: LONGINTPtr; startTime: TimeValue; endTime: TimeValue; timeIncrement: TimeValue; firstDataRefIndex: INTEGER; lastDataRefIndex: INTEGER; VAR retdataRefSkew: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02BF, $AAAA;
	{$ENDC}
FUNCTION GetMaxLoadedTimeInMovie(theMovie: Movie; VAR time: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C0, $AAAA;
	{$ENDC}
FUNCTION QTMovieNeedsTimeTable(theMovie: Movie; VAR needsTimeTable: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C3, $AAAA;
	{$ENDC}
FUNCTION QTGetDataRefMaxFileOffset(movieH: Movie; dataRefType: OSType; dataRef: Handle; VAR offset: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C6, $AAAA;
	{$ENDC}


{****
	QT International Text Atom Support
****}

CONST
	kITextRemoveEverythingBut	= $00;
	kITextRemoveLeaveSuggestedAlternate = $02;

	kITextAtomType				= 'itxt';
	kITextStringAtomType		= 'text';

FUNCTION ITextAddString(container: QTAtomContainer; parentAtom: QTAtom; theRegionCode: RegionCode; theString: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $027A, $AAAA;
	{$ENDC}
FUNCTION ITextRemoveString(container: QTAtomContainer; parentAtom: QTAtom; theRegionCode: RegionCode; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $027B, $AAAA;
	{$ENDC}
FUNCTION ITextGetString(container: QTAtomContainer; parentAtom: QTAtom; requestedRegion: RegionCode; VAR foundRegion: RegionCode; theString: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $027C, $AAAA;
	{$ENDC}
FUNCTION QTTextToNativeText(theText: Handle; encoding: LONGINT; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02DB, $AAAA;
	{$ENDC}
{************************
* track reference types
*************************}

CONST
	kTrackReferenceChapterList	= 'chap';
	kTrackReferenceTimeCode		= 'tmcd';
	kTrackReferenceModifier		= 'ssrc';

{************************
* modifier track types
*************************}
	kTrackModifierInput			= $696E;						{  is really 'in' }
	kTrackModifierType			= $7479;						{  is really 'ty' }
	kTrackModifierReference		= 'ssrc';
	kTrackModifierObjectID		= 'obid';
	kTrackModifierInputName		= 'name';

	kInputMapSubInputID			= 'subi';

	kTrackModifierTypeMatrix	= 1;
	kTrackModifierTypeClip		= 2;
	kTrackModifierTypeGraphicsMode = 5;
	kTrackModifierTypeVolume	= 3;
	kTrackModifierTypeBalance	= 4;
	kTrackModifierTypeImage		= 'vide';						{  was kTrackModifierTypeSpriteImage }
	kTrackModifierObjectMatrix	= 6;
	kTrackModifierObjectGraphicsMode = 7;
	kTrackModifierType3d4x4Matrix = 8;
	kTrackModifierCameraData	= 9;
	kTrackModifierSoundLocalizationData = 10;
	kTrackModifierObjectImageIndex = 11;
	kTrackModifierObjectLayer	= 12;
	kTrackModifierObjectVisible	= 13;
	kTrackModifierPanAngle		= 'pan ';
	kTrackModifierTiltAngle		= 'tilt';
	kTrackModifierVerticalFieldOfViewAngle = 'fov ';
	kTrackModifierObjectQTEventSend = 'evnt';


TYPE
	ModifierTrackGraphicsModeRecordPtr = ^ModifierTrackGraphicsModeRecord;
	ModifierTrackGraphicsModeRecord = RECORD
		graphicsMode:			LONGINT;
		opColor:				RGBColor;
	END;


{************************
* tween track types
*************************}

CONST
	kTweenTypeShort				= 1;
	kTweenTypeLong				= 2;
	kTweenTypeFixed				= 3;
	kTweenTypePoint				= 4;
	kTweenTypeQDRect			= 5;
	kTweenTypeQDRegion			= 6;
	kTweenTypeMatrix			= 7;
	kTweenTypeRGBColor			= 8;
	kTweenTypeGraphicsModeWithRGBColor = 9;
	kTweenTypeQTFloatSingle		= 10;
	kTweenTypeQTFloatDouble		= 11;
	kTweenTypeFixedPoint		= 12;
	kTweenType3dScale			= '3sca';
	kTweenType3dTranslate		= '3tra';
	kTweenType3dRotate			= '3rot';
	kTweenType3dRotateAboutPoint = '3rap';
	kTweenType3dRotateAboutAxis	= '3rax';
	kTweenType3dRotateAboutVector = '3rvc';
	kTweenType3dQuaternion		= '3qua';
	kTweenType3dMatrix			= '3mat';
	kTweenType3dCameraData		= '3cam';
	kTweenType3dSoundLocalizationData = '3slc';
	kTweenTypePathToMatrixTranslation = 'gxmt';
	kTweenTypePathToMatrixRotation = 'gxpr';
	kTweenTypePathToMatrixTranslationAndRotation = 'gxmr';
	kTweenTypePathToFixedPoint	= 'gxfp';
	kTweenTypePathXtoY			= 'gxxy';
	kTweenTypePathYtoX			= 'gxyx';
	kTweenTypeAtomList			= 'atom';
	kTweenTypePolygon			= 'poly';
	kTweenTypeMultiMatrix		= 'mulm';
	kTweenTypeSpin				= 'spin';
	kTweenType3dMatrixNonLinear	= '3nlr';
	kTweenType3dVRObject		= '3vro';

	kTweenEntry					= 'twen';
	kTweenData					= 'data';
	kTweenType					= 'twnt';
	kTweenStartOffset			= 'twst';
	kTweenDuration				= 'twdu';
	kTweenFlags					= 'flag';
	kTweenOutputMin				= 'omin';
	kTweenOutputMax				= 'omax';
	kTweenSequenceElement		= 'seqe';
	kTween3dInitialCondition	= 'icnd';
	kTweenInterpolationID		= 'intr';
	kTweenRegionData			= 'qdrg';
	kTweenPictureData			= 'PICT';
	kListElementType			= 'type';
	kListElementDataType		= 'daty';
	kNameAtom					= 'name';
	kInitialRotationAtom		= 'inro';
	kNonLinearTweenHeader		= 'nlth';

{  kTweenFlags }
	kTweenReturnDelta			= $00000001;


TYPE
	TweenSequenceEntryRecordPtr = ^TweenSequenceEntryRecord;
	TweenSequenceEntryRecord = RECORD
		endPercent:				Fixed;
		tweenAtomID:			QTAtomID;
		dataAtomID:				QTAtomID;
	END;






{  they are for non-MacOS file manager }

CONST
	pathTooLongErr				= -2110;
	emptyPathErr				= -2111;
	noPathMappingErr			= -2112;
	pathNotVerifiedErr			= -2113;
	unknownFormatErr			= -2114;
	wackBadFileErr				= -2115;
	wackForkNotFoundErr			= -2116;
	wackBadMetaDataErr			= -2117;
	qfcbNotFoundErr				= -2118;
	qfcbNotCreatedErr			= -2119;
	AAPNotCreatedErr			= -2120;
	AAPNotFoundErr				= -2121;
	ASDBadHeaderErr				= -2122;
	ASDBadForkErr				= -2123;
	ASDEntryNotFoundErr			= -2124;





{************************
* Video Media routines
*************************}


	videoFlagDontLeanAhead		= $00000001;




{  use these three routines at your own peril }
FUNCTION VideoMediaResetStatistics(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION VideoMediaGetStatistics(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0106, $7000, $A82A;
	{$ENDC}

FUNCTION VideoMediaGetStallCount(mh: MediaHandler; VAR stalls: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010E, $7000, $A82A;
	{$ENDC}


{************************
* Text Media routines
*************************}



{ Return displayFlags for TextProc }

CONST
	txtProcDefaultDisplay		= 0;							{ 	Use the media's default }
	txtProcDontDisplay			= 1;							{ 	Don't display the text }
	txtProcDoDisplay			= 2;							{ 	Do display the text }

FUNCTION TextMediaSetTextProc(mh: MediaHandler; TextProc: TextMediaUPP; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaAddTextSample(mh: MediaHandler; text: Ptr; size: UInt32; fontNumber: INTEGER; fontSize: INTEGER; textFace: ByteParameter; VAR textColor: RGBColor; VAR backColor: RGBColor; textJustification: INTEGER; VAR textBox: Rect; displayFlags: LONGINT; scrollDelay: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0034, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaAddTESample(mh: MediaHandler; hTE: TEHandle; VAR backColor: RGBColor; textJustification: INTEGER; VAR textBox: Rect; displayFlags: LONGINT; scrollDelay: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0026, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaAddHiliteSample(mh: MediaHandler; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0104, $7000, $A82A;
	{$ENDC}

CONST
	findTextEdgeOK				= $01;							{  Okay to find text at specified sample time }
	findTextCaseSensitive		= $02;							{  Case sensitive search }
	findTextReverseSearch		= $04;							{  Search from sampleTime backwards }
	findTextWrapAround			= $08;							{  Wrap search when beginning or end of movie is hit }
	findTextUseOffset			= $10;							{  Begin search at the given character offset into sample rather than edge }

FUNCTION TextMediaFindNextText(mh: MediaHandler; text: Ptr; size: LONGINT; findFlags: INTEGER; startTime: TimeValue; VAR foundTime: TimeValue; VAR foundDuration: TimeValue; VAR offset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001A, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaHiliteTextSample(mh: MediaHandler; sampleTime: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0106, $7000, $A82A;
	{$ENDC}

CONST
	dropShadowOffsetType		= 'drpo';
	dropShadowTranslucencyType	= 'drpt';

FUNCTION TextMediaSetTextSampleData(mh: MediaHandler; data: UNIV Ptr; dataType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}




{************************
* Sprite Media routines
*************************}
{ flags for sprite hit test routines }

CONST
	spriteHitTestBounds			= $00000001;					{ 	point must only be within sprite's bounding box }
	spriteHitTestImage			= $00000002;					{   point must be within the shape of the sprite's image }
	spriteHitTestInvisibleSprites = $00000004;					{   invisible sprites may be hit tested }
	spriteHitTestIsClick		= $00000008;					{   for codecs that want mouse events }
	spriteHitTestLocInDisplayCoordinates = $00000010;			{ 	set if you want to pass a display coordiate point to SpriteHitTest }

{ atom types for sprite media }
	kSpriteAtomType				= 'sprt';
	kSpriteImagesContainerAtomType = 'imct';
	kSpriteImageAtomType		= 'imag';
	kSpriteImageDataAtomType	= 'imda';
	kSpriteImageGroupIDAtomType	= 'imgr';
	kSpriteImageRegistrationAtomType = 'imrg';
	kSpriteSharedDataAtomType	= 'dflt';
	kSpriteNameAtomType			= 'name';
	kSpriteImageNameAtomType	= 'name';
	kSpriteUsesImageIDsAtomType	= 'uses';						{  leaf data is an array of QTAtomID's, one per image used }

FUNCTION SpriteMediaSetProperty(mh: MediaHandler; spriteIndex: INTEGER; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetProperty(mh: MediaHandler; spriteIndex: INTEGER; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaHitTestSprites(mh: MediaHandler; flags: LONGINT; loc: Point; VAR spriteHitIndex: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaCountSprites(mh: MediaHandler; VAR numSprites: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaCountImages(mh: MediaHandler; VAR numImages: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetIndImageDescription(mh: MediaHandler; imageIndex: INTEGER; imageDescription: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetDisplayedSampleNumber(mh: MediaHandler; VAR sampleNum: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetSpriteName(mh: MediaHandler; spriteID: QTAtomID; VAR spriteName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetImageName(mh: MediaHandler; imageIndex: INTEGER; VAR imageName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaSetSpriteProperty(mh: MediaHandler; spriteID: QTAtomID; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010A, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetSpriteProperty(mh: MediaHandler; spriteID: QTAtomID; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010B, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaHitTestAllSprites(mh: MediaHandler; flags: LONGINT; loc: Point; VAR spriteHitID: QTAtomID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010C, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaHitTestOneSprite(mh: MediaHandler; spriteID: QTAtomID; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010D, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaSpriteIndexToID(mh: MediaHandler; spriteIndex: INTEGER; VAR spriteID: QTAtomID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $010E, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaSpriteIDToIndex(mh: MediaHandler; spriteID: QTAtomID; VAR spriteIndex: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $010F, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetSpriteActionsForQTEvent(mh: MediaHandler; event: QTEventRecordPtr; spriteID: QTAtomID; VAR container: QTAtomContainer; VAR atom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0110, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaSetActionVariable(mh: MediaHandler; variableID: QTAtomID; {CONST}VAR value: Single): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0111, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetActionVariable(mh: MediaHandler; variableID: QTAtomID; VAR value: Single): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0112, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetIndImageProperty(mh: MediaHandler; imageIndex: INTEGER; imagePropertyType: LONGINT; imagePropertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0113, $7000, $A82A;
	{$ENDC}

{************************
* 3D Media routines
*************************}
FUNCTION Media3DGetNamedObjectList(mh: MediaHandler; VAR objectList: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION Media3DGetRendererList(mh: MediaHandler; VAR rendererList: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}


{***************************************
*										*
*  	M O V I E   C O N T R O L L E R		*
*										*
***************************************}

CONST
	MovieControllerComponentType = 'play';


	kMovieControllerQTVRFlag	= $01;
	kMovieControllerDontDisplayToUser = $02;


TYPE
	MovieController						= ComponentInstance;

CONST
	mcActionIdle				= 1;							{  no param }
	mcActionDraw				= 2;							{  param is WindowPtr }
	mcActionActivate			= 3;							{  no param }
	mcActionDeactivate			= 4;							{  no param }
	mcActionMouseDown			= 5;							{  param is pointer to EventRecord }
	mcActionKey					= 6;							{  param is pointer to EventRecord }
	mcActionPlay				= 8;							{  param is Fixed, play rate }
	mcActionGoToTime			= 12;							{  param is TimeRecord }
	mcActionSetVolume			= 14;							{  param is a short }
	mcActionGetVolume			= 15;							{  param is pointer to a short }
	mcActionStep				= 18;							{  param is number of steps (short) }
	mcActionSetLooping			= 21;							{  param is Boolean }
	mcActionGetLooping			= 22;							{  param is pointer to a Boolean }
	mcActionSetLoopIsPalindrome	= 23;							{  param is Boolean }
	mcActionGetLoopIsPalindrome	= 24;							{  param is pointer to a Boolean }
	mcActionSetGrowBoxBounds	= 25;							{  param is a Rect }
	mcActionControllerSizeChanged = 26;							{  no param }
	mcActionSetSelectionBegin	= 29;							{  param is TimeRecord }
	mcActionSetSelectionDuration = 30;							{  param is TimeRecord, action only taken on set-duration }
	mcActionSetKeysEnabled		= 32;							{  param is Boolean }
	mcActionGetKeysEnabled		= 33;							{  param is pointer to Boolean }
	mcActionSetPlaySelection	= 34;							{  param is Boolean }
	mcActionGetPlaySelection	= 35;							{  param is pointer to Boolean }
	mcActionSetUseBadge			= 36;							{  param is Boolean }
	mcActionGetUseBadge			= 37;							{  param is pointer to Boolean }
	mcActionSetFlags			= 38;							{  param is long of flags }
	mcActionGetFlags			= 39;							{  param is pointer to a long of flags }
	mcActionSetPlayEveryFrame	= 40;							{  param is Boolean }
	mcActionGetPlayEveryFrame	= 41;							{  param is pointer to Boolean }
	mcActionGetPlayRate			= 42;							{  param is pointer to Fixed }
	mcActionShowBalloon			= 43;							{  param is a pointer to a boolean. set to false to stop balloon }
	mcActionBadgeClick			= 44;							{  param is pointer to Boolean. set to false to ignore click }
	mcActionMovieClick			= 45;							{  param is pointer to event record. change "what" to nullEvt to kill click }
	mcActionSuspend				= 46;							{  no param }
	mcActionResume				= 47;							{  no param }
	mcActionSetControllerKeysEnabled = 48;						{  param is Boolean }
	mcActionGetTimeSliderRect	= 49;							{  param is pointer to rect }
	mcActionMovieEdited			= 50;							{  no param }
	mcActionGetDragEnabled		= 51;							{  param is pointer to Boolean }
	mcActionSetDragEnabled		= 52;							{  param is Boolean }
	mcActionGetSelectionBegin	= 53;							{  param is TimeRecord }
	mcActionGetSelectionDuration = 54;							{  param is TimeRecord }
	mcActionPrerollAndPlay		= 55;							{  param is Fixed, play rate }
	mcActionGetCursorSettingEnabled = 56;						{  param is pointer to Boolean }
	mcActionSetCursorSettingEnabled = 57;						{  param is Boolean }
	mcActionSetColorTable		= 58;							{  param is CTabHandle }
	mcActionLinkToURL			= 59;							{  param is Handle to URL }
	mcActionCustomButtonClick	= 60;							{  param is pointer to EventRecord }
	mcActionForceTimeTableUpdate = 61;							{  no param }
	mcActionSetControllerTimeLimits = 62;						{  param is pointer to 2 time values min/max. do no send this message to controller. used internally only. }
	mcActionExecuteAllActionsForQTEvent = 63;					{  param is ResolvedQTEventSpecPtr }
	mcActionExecuteOneActionForQTEvent = 64;					{  param is ResolvedQTEventSpecPtr }
	mcActionAdjustCursor		= 65;							{  param is pointer to EventRecord (WindowPtr is in message parameter) }
	mcActionUseTrackForTimeTable = 66;							{  param is pointer to (long trackID; Boolean useIt). do not send this message to controller.  }
	mcActionClickAndHoldPoint	= 67;							{  param is point (local coordinates). return true if point has click & hold action (e.g., VR object movie autorotate spot) }


TYPE
	mcAction							= INTEGER;

CONST
	mcFlagSuppressMovieFrame	= $01;
	mcFlagSuppressStepButtons	= $02;
	mcFlagSuppressSpeakerButton	= $04;
	mcFlagsUseWindowPalette		= $08;
	mcFlagsDontInvalidate		= $10;
	mcFlagsUseCustomButton		= $20;


	mcPositionDontInvalidate	= $20;


TYPE
	mcFlags								= UInt32;

CONST
	kMCIEEnabledButtonPicture	= 1;
	kMCIEDisabledButtonPicture	= 2;
	kMCIEDepressedButtonPicture	= 3;
	kMCIEEnabledSizeBoxPicture	= 4;
	kMCIEDisabledSizeBoxPicture	= 5;
	kMCIEEnabledUnavailableButtonPicture = 6;
	kMCIEDisabledUnavailableButtonPicture = 7;
	kMCIESoundSlider			= 128;
	kMCIESoundThumb				= 129;
	kMCIEColorTable				= 256;
	kMCIEIsFlatAppearance		= 257;
	kMCIEDoButtonIconsDropOnDepress = 258;


TYPE
	MCInterfaceElement					= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	MCActionFilterProcPtr = FUNCTION(mc: MovieController; VAR action: INTEGER; params: UNIV Ptr): BOOLEAN;
{$ELSEC}
	MCActionFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MCActionFilterWithRefConProcPtr = FUNCTION(mc: MovieController; action: INTEGER; params: UNIV Ptr; refCon: LONGINT): BOOLEAN;
{$ELSEC}
	MCActionFilterWithRefConProcPtr = ProcPtr;
{$ENDC}

	MCActionFilterUPP = UniversalProcPtr;
	MCActionFilterWithRefConUPP = UniversalProcPtr;
{
	menu related stuff
}

CONST
	mcInfoUndoAvailable			= $01;
	mcInfoCutAvailable			= $02;
	mcInfoCopyAvailable			= $04;
	mcInfoPasteAvailable		= $08;
	mcInfoClearAvailable		= $10;
	mcInfoHasSound				= $20;
	mcInfoIsPlaying				= $40;
	mcInfoIsLooping				= $80;
	mcInfoIsInPalindrome		= $0100;
	mcInfoEditingEnabled		= $0200;
	mcInfoMovieIsInteractive	= $0400;

{  menu item codes }
	mcMenuUndo					= 1;
	mcMenuCut					= 3;
	mcMenuCopy					= 4;
	mcMenuPaste					= 5;
	mcMenuClear					= 6;




{ target management }
FUNCTION MCSetMovie(mc: MovieController; theMovie: Movie; movieWindow: WindowPtr; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetIndMovie(mc: MovieController; index: INTEGER): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0005, $7000, $A82A;
	{$ENDC}

FUNCTION MCRemoveAllMovies(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION MCRemoveAMovie(mc: MovieController; m: Movie): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION MCRemoveMovie(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}
{ event handling etc. }
FUNCTION MCIsPlayerEvent(mc: MovieController; {CONST}VAR e: EventRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
{ obsolete. use MCSetActionFilterWithRefCon instead. }
FUNCTION MCSetActionFilter(mc: MovieController; blob: MCActionFilterUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}
{
	proc is of the form:
		Boolean userPlayerFilter(MovieController mc, short *action, void *params) =
	proc returns TRUE if it handles the action, FALSE if not
	action is passed as a VAR so that it could be changed by filter
	this is consistent with the current dialog manager stuff
	params is any potential parameters that go with the action
		such as set playback rate to xxx.
}
FUNCTION MCDoAction(mc: MovieController; action: INTEGER; params: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0009, $7000, $A82A;
	{$ENDC}
{ state type things }
FUNCTION MCSetControllerAttached(mc: MovieController; attach: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION MCIsControllerAttached(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetControllerPort(mc: MovieController; gp: CGrafPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerPort(mc: MovieController): CGrafPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetVisible(mc: MovieController; visible: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetVisible(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerBoundsRect(mc: MovieController; VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetControllerBoundsRect(mc: MovieController; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerBoundsRgn(mc: MovieController): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetWindowRgn(mc: MovieController; w: WindowPtr): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}

{ other stuff }
FUNCTION MCMovieChanged(mc: MovieController; m: Movie): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}

{
	called when the app has changed thing about the movie (like bounding rect) or rate. So that we
		can update our graphical (and internal) state accordingly.
}
FUNCTION MCSetDuration(mc: MovieController; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
{
	duration to use for time slider -- will be reset next time MCMovieChanged is called
		or MCSetMovie is called
}
FUNCTION MCGetCurrentTime(mc: MovieController; VAR scale: TimeScale): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0016, $7000, $A82A;
	{$ENDC}
{
	returns the time value and the time scale it is on. if there are no movies, the
		time scale is passed back as 0. scale is an optional parameter

}
FUNCTION MCNewAttachedController(mc: MovieController; theMovie: Movie; w: WindowPtr; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}
{
	makes theMovie the only movie attached to the controller. makes the controller visible.
	the window and where parameters are passed a long to MCSetMovie and behave as
	described there
}
FUNCTION MCDraw(mc: MovieController; w: WindowPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION MCActivate(mc: MovieController; w: WindowPtr; activate: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION MCIdle(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION MCKey(mc: MovieController; key: SInt8; modifiers: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION MCClick(mc: MovieController; w: WindowPtr; where: Point; when: LONGINT; modifiers: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $001C, $7000, $A82A;
	{$ENDC}

{
	calls for editing
}
FUNCTION MCEnableEditing(mc: MovieController; enabled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION MCIsEditingEnabled(mc: MovieController): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION MCCopy(mc: MovieController): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION MCCut(mc: MovieController): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION MCPaste(mc: MovieController; srcMovie: Movie): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION MCClear(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION MCUndo(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0023, $7000, $A82A;
	{$ENDC}

{
 *	somewhat special stuff
 }
FUNCTION MCPositionController(mc: MovieController; {CONST}VAR movieRect: Rect; {CONST}VAR controllerRect: Rect; someFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0024, $7000, $A82A;
	{$ENDC}

FUNCTION MCGetControllerInfo(mc: MovieController; VAR someFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}


FUNCTION MCSetClip(mc: MovieController; theClip: RgnHandle; movieClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetClip(mc: MovieController; VAR theClip: RgnHandle; VAR movieClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0029, $7000, $A82A;
	{$ENDC}

FUNCTION MCDrawBadge(mc: MovieController; movieRgn: RgnHandle; VAR badgeRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetUpEditMenu(mc: MovieController; modifiers: LONGINT; mh: MenuHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetMenuString(mc: MovieController; modifiers: LONGINT; item: INTEGER; VAR aString: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetActionFilterWithRefCon(mc: MovieController; blob: MCActionFilterWithRefConUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION MCPtInController(mc: MovieController; thePt: Point; VAR inController: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION MCInvalidate(mc: MovieController; w: WindowPtr; invalidRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION MCAdjustCursor(mc: MovieController; w: WindowPtr; where: Point; modifiers: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0030, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetInterfaceElement(mc: MovieController; whichElement: MCInterfaceElement; element: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0031, $7000, $A82A;
	{$ENDC}




{***************************************
*										*
*  		T  I  M  E  B  A  S  E			*
*										*
***************************************}
FUNCTION NewTimeBase: TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A5, $AAAA;
	{$ENDC}
PROCEDURE DisposeTimeBase(tb: TimeBase);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B6, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A6, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A7, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseValue(tb: TimeBase; t: TimeValue; s: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A8, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseRate(tb: TimeBase): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A9, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseRate(tb: TimeBase; r: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AA, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseStartTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AB, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseStartTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AC, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseStopTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AD, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseStopTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AE, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseFlags(tb: TimeBase): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B1, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseFlags(tb: TimeBase; timeBaseFlags: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B2, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseMasterTimeBase(slave: TimeBase; master: TimeBase; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B4, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseMasterTimeBase(tb: TimeBase): TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AF, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseMasterClock(slave: TimeBase; clockMeister: Component; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B3, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseMasterClock(tb: TimeBase): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B0, $AAAA;
	{$ENDC}
PROCEDURE ConvertTime(VAR inout: TimeRecord; newBase: TimeBase);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B5, $AAAA;
	{$ENDC}
PROCEDURE ConvertTimeScale(VAR inout: TimeRecord; newScale: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B7, $AAAA;
	{$ENDC}
PROCEDURE AddTime(VAR dst: TimeRecord; {CONST}VAR src: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010C, $AAAA;
	{$ENDC}
PROCEDURE SubtractTime(VAR dst: TimeRecord; {CONST}VAR src: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010D, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseStatus(tb: TimeBase; VAR unpinnedTime: TimeRecord): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010B, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseZero(tb: TimeBase; VAR zero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0128, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseEffectiveRate(tb: TimeBase): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0124, $AAAA;
	{$ENDC}

{***************************************
*										*
*  		C  A  L  L  B  A  C  K 			*
*										*
***************************************}
FUNCTION NewCallBack(tb: TimeBase; cbType: INTEGER): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EB, $AAAA;
	{$ENDC}
PROCEDURE DisposeCallBack(cb: QTCallBack);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EC, $AAAA;
	{$ENDC}
FUNCTION GetCallBackType(cb: QTCallBack): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00ED, $AAAA;
	{$ENDC}
FUNCTION GetCallBackTimeBase(cb: QTCallBack): TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EE, $AAAA;
	{$ENDC}
FUNCTION CallMeWhen(cb: QTCallBack; callBackProc: QTCallBackUPP; refCon: LONGINT; param1: LONGINT; param2: LONGINT; param3: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B8, $AAAA;
	{$ENDC}
PROCEDURE CancelCallBack(cb: QTCallBack);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B9, $AAAA;
	{$ENDC}

{***************************************
*										*
*  		C L O C K   C A L L B A C K  	*
*  		      S U P P O R T  			*
*										*
***************************************}
FUNCTION AddCallBackToTimeBase(cb: QTCallBack): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0129, $AAAA;
	{$ENDC}
FUNCTION RemoveCallBackFromTimeBase(cb: QTCallBack): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012A, $AAAA;
	{$ENDC}
FUNCTION GetFirstCallBack(tb: TimeBase): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012B, $AAAA;
	{$ENDC}
FUNCTION GetNextCallBack(cb: QTCallBack): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012C, $AAAA;
	{$ENDC}
PROCEDURE ExecuteCallBack(cb: QTCallBack);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012D, $AAAA;
	{$ENDC}




FUNCTION MusicMediaGetIndexedTunePlayer(ti: ComponentInstance; sampleDescIndex: LONGINT; VAR tp: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}


{ UPP call backs }

CONST
	uppMovieRgnCoverProcInfo = $00000FE0;
	uppMovieProgressProcInfo = $0000FAE0;
	uppMovieDrawingCompleteProcInfo = $000003E0;
	uppTrackTransferProcInfo = $000003E0;
	uppGetMovieProcInfo = $00003FE0;
	uppMoviePreviewCallOutProcInfo = $000000D0;
	uppTextMediaProcInfo = $00003FE0;
	uppActionsProcInfo = $00003FE0;
	uppQTCallBackProcInfo = $000003C0;
	uppQTSyncTaskProcInfo = $000000C0;
	uppMCActionFilterProcInfo = $00000FD0;
	uppMCActionFilterWithRefConProcInfo = $00003ED0;

FUNCTION NewMovieRgnCoverProc(userRoutine: MovieRgnCoverProcPtr): MovieRgnCoverUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMovieProgressProc(userRoutine: MovieProgressProcPtr): MovieProgressUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMovieDrawingCompleteProc(userRoutine: MovieDrawingCompleteProcPtr): MovieDrawingCompleteUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTrackTransferProc(userRoutine: TrackTransferProcPtr): TrackTransferUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewGetMovieProc(userRoutine: GetMovieProcPtr): GetMovieUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMoviePreviewCallOutProc(userRoutine: MoviePreviewCallOutProcPtr): MoviePreviewCallOutUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTextMediaProc(userRoutine: TextMediaProcPtr): TextMediaUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewActionsProc(userRoutine: ActionsProcPtr): ActionsUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTCallBackProc(userRoutine: QTCallBackProcPtr): QTCallBackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTSyncTaskProc(userRoutine: QTSyncTaskProcPtr): QTSyncTaskUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMCActionFilterProc(userRoutine: MCActionFilterProcPtr): MCActionFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMCActionFilterWithRefConProc(userRoutine: MCActionFilterWithRefConProcPtr): MCActionFilterWithRefConUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallMovieRgnCoverProc(theMovie: Movie; changedRgn: RgnHandle; refcon: LONGINT; userRoutine: MovieRgnCoverUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMovieProgressProc(theMovie: Movie; message: INTEGER; whatOperation: INTEGER; percentDone: Fixed; refcon: LONGINT; userRoutine: MovieProgressUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMovieDrawingCompleteProc(theMovie: Movie; refCon: LONGINT; userRoutine: MovieDrawingCompleteUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTrackTransferProc(t: Track; refCon: LONGINT; userRoutine: TrackTransferUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallGetMovieProc(offset: LONGINT; size: LONGINT; dataPtr: UNIV Ptr; refCon: UNIV Ptr; userRoutine: GetMovieUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMoviePreviewCallOutProc(refcon: LONGINT; userRoutine: MoviePreviewCallOutUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTextMediaProc(theText: Handle; theMovie: Movie; VAR displayFlag: INTEGER; refcon: LONGINT; userRoutine: TextMediaUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallActionsProc(refcon: UNIV Ptr; targetTrack: Track; targetRefCon: LONGINT; theEvent: QTEventRecordPtr; userRoutine: ActionsUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQTCallBackProc(cb: QTCallBack; refCon: LONGINT; userRoutine: QTCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQTSyncTaskProc(task: UNIV Ptr; userRoutine: QTSyncTaskUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMCActionFilterProc(mc: MovieController; VAR action: INTEGER; params: UNIV Ptr; userRoutine: MCActionFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMCActionFilterWithRefConProc(mc: MovieController; action: INTEGER; params: UNIV Ptr; refCon: LONGINT; userRoutine: MCActionFilterWithRefConUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MoviesIncludes}

{$ENDC} {__MOVIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
