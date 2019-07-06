{
     File:       ImageCodec.p
 
     Contains:   QuickTime Interfaces.
 
     Version:    Technology: QuickTime 4.1
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1990-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ImageCodec;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IMAGECODEC__}
{$SETC __IMAGECODEC__ := 1}

{$I+}
{$SETC ImageCodecIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{  codec capabilities flags    }

CONST
	codecCanScale				= $00000001;
	codecCanMask				= $00000002;
	codecCanMatte				= $00000004;
	codecCanTransform			= $00000008;
	codecCanTransferMode		= $00000010;
	codecCanCopyPrev			= $00000020;
	codecCanSpool				= $00000040;
	codecCanClipVertical		= $00000080;
	codecCanClipRectangular		= $00000100;
	codecCanRemapColor			= $00000200;
	codecCanFastDither			= $00000400;
	codecCanSrcExtract			= $00000800;
	codecCanCopyPrevComp		= $00001000;
	codecCanAsync				= $00002000;
	codecCanMakeMask			= $00004000;
	codecCanShift				= $00008000;
	codecCanAsyncWhen			= $00010000;
	codecCanShieldCursor		= $00020000;
	codecCanManagePrevBuffer	= $00040000;
	codecHasVolatileBuffer		= $00080000;					{  codec requires redraw after window movement  }
	codecWantsRegionMask		= $00100000;
	codecImageBufferIsOnScreen	= $00200000;					{  old def of codec using overlay surface, = ( codecIsDirectToScreenOnly | codecUsesOverlaySurface | codecImageBufferIsOverlaySurface | codecSrcMustBeImageBuffer )  }
	codecWantsDestinationPixels	= $00400000;
	codecWantsSpecialScaling	= $00800000;
	codecHandlesInputs			= $01000000;
	codecCanDoIndirectSurface	= $02000000;					{  codec can handle indirect surface (GDI)  }
	codecIsSequenceSensitive	= $04000000;
	codecRequiresOffscreen		= $08000000;
	codecRequiresMaskBits		= $10000000;
	codecCanRemapResolution		= $20000000;
	codecIsDirectToScreenOnly	= $40000000;					{  codec can only decompress data to the screen  }
	codecCanLockSurface			= $80000000;					{  codec can lock destination surface, icm doesn't lock for you  }

{  codec capabilities flags2   }
	codecUsesOverlaySurface		= $00000001;					{  codec uses overlay surface  }
	codecImageBufferIsOverlaySurface = $00000002;				{  codec image buffer is overlay surface, the bits in the buffer are on the screen  }
	codecSrcMustBeImageBuffer	= $00000004;					{  codec can only source data from an image buffer  }


TYPE
	CodecCapabilitiesPtr = ^CodecCapabilities;
	CodecCapabilities = RECORD
		flags:					LONGINT;
		wantedPixelSize:		INTEGER;
		extendWidth:			INTEGER;
		extendHeight:			INTEGER;
		bandMin:				INTEGER;
		bandInc:				INTEGER;
		pad:					INTEGER;
		time:					UInt32;
		flags2:					LONGINT;								{  field new in QuickTime 4.0  }
	END;

{  codec condition flags   }

CONST
	codecConditionFirstBand		= $00000001;
	codecConditionLastBand		= $00000002;
	codecConditionFirstFrame	= $00000004;
	codecConditionNewDepth		= $00000008;
	codecConditionNewTransform	= $00000010;
	codecConditionNewSrcRect	= $00000020;
	codecConditionNewMask		= $00000040;
	codecConditionNewMatte		= $00000080;
	codecConditionNewTransferMode = $00000100;
	codecConditionNewClut		= $00000200;
	codecConditionNewAccuracy	= $00000400;
	codecConditionNewDestination = $00000800;
	codecConditionFirstScreen	= $00001000;
	codecConditionDoCursor		= $00002000;
	codecConditionCatchUpDiff	= $00004000;
	codecConditionMaskMayBeChanged = $00008000;
	codecConditionToBuffer		= $00010000;
	codecConditionCodecChangedMask = $80000000;


	codecInfoResourceType		= 'cdci';						{  codec info resource type  }
	codecInterfaceVersion		= 2;							{  high word returned in component GetVersion  }


TYPE
	CDSequenceDataSourceQueueEntryPtr = ^CDSequenceDataSourceQueueEntry;
	CDSequenceDataSourceQueueEntry = RECORD
		nextBusy:				Ptr;
		descSeed:				LONGINT;
		dataDesc:				Handle;
		data:					Ptr;
		dataSize:				LONGINT;
		useCount:				LONGINT;
		frameTime:				TimeValue;
		frameDuration:			TimeValue;
		timeScale:				TimeValue;
	END;

	CDSequenceDataSourcePtr = ^CDSequenceDataSource;
	CDSequenceDataSource = RECORD
		recordSize:				LONGINT;
		next:					Ptr;
		seqID:					ImageSequence;
		sourceID:				ImageSequenceDataSource;
		sourceType:				OSType;
		sourceInputNumber:		LONGINT;
		dataPtr:				Ptr;
		dataDescription:		Handle;
		changeSeed:				LONGINT;
		transferProc:			ICMConvertDataFormatUPP;
		transferRefcon:			Ptr;
		dataSize:				LONGINT;
																		{  fields available in QT 3 and later  }
		dataQueue:				QHdrPtr;								{  queue of CDSequenceDataSourceQueueEntry structures }
		originalDataPtr:		Ptr;
		originalDataSize:		LONGINT;
		originalDataDescription: Handle;
		originalDataDescriptionSeed: LONGINT;
	END;

	ICMFrameTimeInfoPtr = ^ICMFrameTimeInfo;
	ICMFrameTimeInfo = RECORD
		startTime:				wide;
		scale:					LONGINT;
		duration:				LONGINT;
	END;

	CodecCompressParamsPtr = ^CodecCompressParams;
	CodecCompressParams = RECORD
		sequenceID:				ImageSequence;							{  precompress,bandcompress  }
		imageDescription:		ImageDescriptionHandle;					{  precompress,bandcompress  }
		data:					Ptr;
		bufferSize:				LONGINT;
		frameNumber:			LONGINT;
		startLine:				LONGINT;
		stopLine:				LONGINT;
		conditionFlags:			LONGINT;
		callerFlags:			CodecFlags;
		capabilities:			CodecCapabilitiesPtr;					{  precompress,bandcompress  }
		progressProcRecord:		ICMProgressProcRecord;
		completionProcRecord:	ICMCompletionProcRecord;
		flushProcRecord:		ICMFlushProcRecord;
		srcPixMap:				PixMap;									{  precompress,bandcompress  }
		prevPixMap:				PixMap;
		spatialQuality:			CodecQ;
		temporalQuality:		CodecQ;
		similarity:				Fixed;
		dataRateParams:			DataRateParamsPtr;
		reserved:				LONGINT;
																		{  The following fields only exist for QuickTime 2.1 and greater  }
		majorSourceChangeSeed:	UInt16;
		minorSourceChangeSeed:	UInt16;
		sourceData:				CDSequenceDataSourcePtr;
																		{  The following fields only exit for QuickTime 2.5 and greater  }
		preferredPacketSizeInBytes: LONGINT;
																		{  The following fields only exit for QuickTime 3.0 and greater  }
		requestedBufferWidth:	LONGINT;								{  must set codecWantsSpecialScaling to indicate this field is valid }
		requestedBufferHeight:	LONGINT;								{  must set codecWantsSpecialScaling to indicate this field is valid }
																		{  The following fields only exit for QuickTime 4.0 and greater  }
		wantedSourcePixelType:	OSType;
	END;

	CodecDecompressParamsPtr = ^CodecDecompressParams;
	CodecDecompressParams = RECORD
		sequenceID:				ImageSequence;							{  predecompress,banddecompress  }
		imageDescription:		ImageDescriptionHandle;					{  predecompress,banddecompress  }
		data:					Ptr;
		bufferSize:				LONGINT;
		frameNumber:			LONGINT;
		startLine:				LONGINT;
		stopLine:				LONGINT;
		conditionFlags:			LONGINT;
		callerFlags:			CodecFlags;
		capabilities:			CodecCapabilitiesPtr;					{  predecompress,banddecompress  }
		progressProcRecord:		ICMProgressProcRecord;
		completionProcRecord:	ICMCompletionProcRecord;
		dataProcRecord:			ICMDataProcRecord;
		port:					CGrafPtr;								{  predecompress,banddecompress  }
		dstPixMap:				PixMap;									{  predecompress,banddecompress  }
		maskBits:				BitMapPtr;
		mattePixMap:			PixMapPtr;
		srcRect:				Rect;									{  predecompress,banddecompress  }
		matrix:					MatrixRecordPtr;						{  predecompress,banddecompress  }
		accuracy:				CodecQ;									{  predecompress,banddecompress  }
		transferMode:			INTEGER;								{  predecompress,banddecompress  }
		frameTime:				ICMFrameTimePtr;						{  banddecompress  }
		reserved:				ARRAY [0..0] OF LONGINT;
																		{  The following fields only exist for QuickTime 2.0 and greater  }
		matrixFlags:			SInt8;									{  high bit set if 2x resize  }
		matrixType:				SInt8;
		dstRect:				Rect;									{  only valid for simple transforms  }
																		{  The following fields only exist for QuickTime 2.1 and greater  }
		majorSourceChangeSeed:	UInt16;
		minorSourceChangeSeed:	UInt16;
		sourceData:				CDSequenceDataSourcePtr;
		maskRegion:				RgnHandle;
																		{  The following fields only exist for QuickTime 2.5 and greater  }
		wantedDestinationPixelTypes: ^OSTypePtr;						{  Handle to 0-terminated list of OSTypes  }
		screenFloodMethod:		LONGINT;
		screenFloodValue:		LONGINT;
		preferredOffscreenPixelSize: INTEGER;
																		{  The following fields only exist for QuickTime 3.0 and greater  }
		syncFrameTime:			ICMFrameTimeInfoPtr;					{  banddecompress  }
		needUpdateOnTimeChange:	BOOLEAN;								{  banddecompress  }
		enableBlackLining:		BOOLEAN;
		needUpdateOnSourceChange: BOOLEAN;								{  band decompress  }
		pad:					BOOLEAN;
		unused:					LONGINT;
		finalDestinationPort:	CGrafPtr;
		requestedBufferWidth:	LONGINT;								{  must set codecWantsSpecialScaling to indicate this field is valid }
		requestedBufferHeight:	LONGINT;								{  must set codecWantsSpecialScaling to indicate this field is valid }
																		{  The following fields only exist for QuickTime 4.0 and greater  }
		displayableAreaOfRequestedBuffer: Rect;							{  set in predecompress }
		requestedSingleField:	BOOLEAN;
		needUpdateOnNextIdle:	BOOLEAN;
		pad2:					ARRAY [0..1] OF BOOLEAN;
		reserved2:				LONGINT;
	END;


CONST
	matrixFlagScale2x			= $00000080;
	matrixFlagScale1x			= $00000040;
	matrixFlagScaleHalf			= $00000020;

	kScreenFloodMethodNone		= 0;
	kScreenFloodMethodKeyColor	= 1;
	kScreenFloodMethodAlpha		= 2;

	kFlushLastQueuedFrame		= 0;
	kFlushFirstQueuedFrame		= 1;

	kNewImageGWorldErase		= $00000001;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ImageCodecTimeTriggerProcPtr = PROCEDURE(refcon: UNIV Ptr);
{$ELSEC}
	ImageCodecTimeTriggerProcPtr = ProcPtr;
{$ENDC}

	ImageCodecTimeTriggerUPP = UniversalProcPtr;

CONST
	uppImageCodecTimeTriggerProcInfo = $000000C0;

FUNCTION NewImageCodecTimeTriggerUPP(userRoutine: ImageCodecTimeTriggerProcPtr): ImageCodecTimeTriggerUPP; { old name was NewImageCodecTimeTriggerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeImageCodecTimeTriggerUPP(userUPP: ImageCodecTimeTriggerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeImageCodecTimeTriggerUPP(refcon: UNIV Ptr; userRoutine: ImageCodecTimeTriggerUPP); { old name was CallImageCodecTimeTriggerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	ImageSubCodecDecompressCapabilitiesPtr = ^ImageSubCodecDecompressCapabilities;
	ImageSubCodecDecompressCapabilities = RECORD
		recordSize:				LONGINT;								{  sizeof(ImageSubCodecDecompressCapabilities) }
		decompressRecordSize:	LONGINT;								{  size of your codec's decompress record }
		canAsync:				BOOLEAN;								{  default true }
		pad0:					SInt8;
																		{  The following field only exist for QuickTime 4.1 and greater  }
		suggestedQueueSize:		UInt16;
																		{  The following fields only exist for QuickTime 4.0 and greater  }
		canProvideTrigger:		BOOLEAN;
		pad1:					PACKED ARRAY [0..2] OF UInt8;
	END;


CONST
	kCodecFrameTypeUnknown		= 0;
	kCodecFrameTypeKey			= 1;
	kCodecFrameTypeDifference	= 2;
	kCodecFrameTypeDroppableDifference = 3;


TYPE
	ImageSubCodecDecompressRecordPtr = ^ImageSubCodecDecompressRecord;
	ImageSubCodecDecompressRecord = RECORD
		baseAddr:				Ptr;
		rowBytes:				LONGINT;
		codecData:				Ptr;
		progressProcRecord:		ICMProgressProcRecord;
		dataProcRecord:			ICMDataProcRecord;
		userDecompressRecord:	Ptr;									{  pointer to codec-specific per-band data }
		frameType:				SInt8;
		pad:					PACKED ARRAY [0..2] OF UInt8;
		priv:					ARRAY [0..1] OF LONGINT;
	END;

{
  These data structures are used by code that wants to pass planar pixmap 
   information around.
  The structure below gives the basic idea of what is being done.
  Normal instances of code will use a fixed number of planes (eg YUV420 uses 
   three planes, Y, U and V). Each such code instance will define its own
   version of the PlanarPixMapInfo struct counting the number of planes it 
   needs along with defining constants that specify the meanings of each
   plane.
}
	PlanarComponentInfoPtr = ^PlanarComponentInfo;
	PlanarComponentInfo = RECORD
		offset:					SInt32;
		rowBytes:				UInt32;
	END;

	PlanarPixMapInfoPtr = ^PlanarPixMapInfo;
	PlanarPixMapInfo = RECORD
		componentInfo:			ARRAY [0..0] OF PlanarComponentInfo;
	END;

	PlanarPixmapInfoSorensonYUV9Ptr = ^PlanarPixmapInfoSorensonYUV9;
	PlanarPixmapInfoSorensonYUV9 = RECORD
		componentInfoY:			PlanarComponentInfo;
		componentInfoU:			PlanarComponentInfo;
		componentInfoV:			PlanarComponentInfo;
	END;

	PlanarPixmapInfoYUV420Ptr = ^PlanarPixmapInfoYUV420;
	PlanarPixmapInfoYUV420 = RECORD
		componentInfoY:			PlanarComponentInfo;
		componentInfoCb:		PlanarComponentInfo;
		componentInfoCr:		PlanarComponentInfo;
	END;

{  name of parameters or effect -- placed in root container, required  }

CONST
	kParameterTitleName			= 'name';
	kParameterTitleID			= 1;

{  codec sub-type of parameters or effect -- placed in root container, required  }
	kParameterWhatName			= 'what';
	kParameterWhatID			= 1;

{  effect version -- placed in root container, optional, but recommended  }
	kParameterVersionName		= 'vers';
	kParameterVersionID			= 1;

{  is effect repeatable -- placed in root container, optional, default is TRUE }
	kParameterRepeatableName	= 'pete';
	kParameterRepeatableID		= 1;

	kParameterRepeatableTrue	= 1;
	kParameterRepeatableFalse	= 0;

{  substitution codec in case effect is missing -- placed in root container, recommended  }
	kParameterAlternateCodecName = 'subs';
	kParameterAlternateCodecID	= 1;

{  maximum number of sources -- placed in root container, required  }
	kParameterSourceCountName	= 'srcs';
	kParameterSourceCountID		= 1;


	kParameterDependencyName	= 'deep';
	kParameterDependencyID		= 1;

	kParameterListDependsUponColorProfiles = 'prof';
	kParameterListDependsUponFonts = 'font';


TYPE
	ParameterDependancyRecordPtr = ^ParameterDependancyRecord;
	ParameterDependancyRecord = RECORD
		dependCount:			LONGINT;
		depends:				ARRAY [0..0] OF OSType;
	END;

{
   enumeration list in container -- placed in root container, optional unless used by a
   parameter in the list
}

CONST
	kParameterEnumList			= 'enum';


TYPE
	EnumValuePairPtr = ^EnumValuePair;
	EnumValuePair = RECORD
		value:					LONGINT;
		name:					Str255;
	END;

	EnumListRecordPtr = ^EnumListRecord;
	EnumListRecord = RECORD
		enumCount:				LONGINT;								{  number of enumeration items to follow }
		values:					ARRAY [0..0] OF EnumValuePair;			{  values and names for them, packed  }
	END;

{  atom type of parameter }

CONST
	kParameterAtomTypeAndID		= 'type';

	kNoAtom						= 'none';						{  atom type for no data got/set }
	kAtomNoFlags				= $00000000;
	kAtomNotInterpolated		= $00000001;					{  atom can never be interpolated }
	kAtomInterpolateIsOptional	= $00000002;					{  atom can be interpolated, but it is an advanced user operation }
	kAtomMayBeIndexed			= $00000004;					{  more than one value of atom can exist with accending IDs (ie, lists of colors) }


TYPE
	ParameterAtomTypeAndIDPtr = ^ParameterAtomTypeAndID;
	ParameterAtomTypeAndID = RECORD
		atomType:				QTAtomType;								{  type of atom this data comes from/goes into }
		atomID:					QTAtomID;								{  ID of atom this data comes from/goes into }
		atomFlags:				LONGINT;								{  options for this atom }
		atomName:				Str255;									{  name of this value type }
	END;

{  data type of a parameter }

CONST
	kParameterDataType			= 'data';

	kParameterTypeDataLong		= 2;							{  integer value }
	kParameterTypeDataFixed		= 3;							{  fixed point value }
	kParameterTypeDataRGBValue	= 8;							{  RGBColor data }
	kParameterTypeDataDouble	= 11;							{  IEEE 64 bit floating point value }
	kParameterTypeDataText		= 'text';						{  editable text item }
	kParameterTypeDataEnum		= 'enum';						{  enumerated lookup value }
	kParameterTypeDataBitField	= 'bool';						{  bit field value (something that holds boolean(s)) }
	kParameterTypeDataImage		= 'imag';						{  reference to an image via Picture data }


TYPE
	ParameterDataTypePtr = ^ParameterDataType;
	ParameterDataType = RECORD
		dataType:				OSType;									{  type of data this item is stored as }
	END;

{
   alternate (optional) data type -- main data type always required.  
   Must be modified or deleted when modifying main data type.
   Main data type must be modified when alternate is modified.
}

CONST
	kParameterAlternateDataType	= 'alt1';
	kParameterTypeDataColorValue = 'cmlr';						{  CMColor data (supported on machines with ColorSync) }
	kParameterTypeDataCubic		= 'cubi';						{  cubic bezier(s) (no built-in support) }
	kParameterTypeDataNURB		= 'nurb';						{  nurb(s) (no built-in support) }


TYPE
	ParameterAlternateDataEntryPtr = ^ParameterAlternateDataEntry;
	ParameterAlternateDataEntry = RECORD
		dataType:				OSType;									{  type of data this item is stored as }
		alternateAtom:			QTAtomType;								{  where to store }
	END;

	ParameterAlternateDataTypePtr = ^ParameterAlternateDataType;
	ParameterAlternateDataType = RECORD
		numEntries:				LONGINT;
		entries:				ARRAY [0..0] OF ParameterAlternateDataEntry;
	END;

{  legal values for the parameter }

CONST
	kParameterDataRange			= 'rang';

	kNoMinimumLongFixed			= $7FFFFFFF;					{  ignore minimum/maxiumum values }
	kNoMaximumLongFixed			= $80000000;
	kNoScaleLongFixed			= 0;							{  don't perform any scaling of value }
	kNoPrecision				= -1;							{  allow as many digits as format }

{  'text' }

TYPE
	StringRangeRecordPtr = ^StringRangeRecord;
	StringRangeRecord = RECORD
		maxChars:				LONGINT;								{  maximum length of string }
		maxLines:				LONGINT;								{  number of editing lines to use (1 typical, 0 to default) }
	END;

{  'long' }
	LongRangeRecordPtr = ^LongRangeRecord;
	LongRangeRecord = RECORD
		minValue:				LONGINT;								{  no less than this }
		maxValue:				LONGINT;								{  no more than this }
		scaleValue:				LONGINT;								{  muliply content by this going in, divide going out }
		precisionDigits:		LONGINT;								{  # digits of precision when editing via typing }
	END;

{  'enum' }
	EnumRangeRecordPtr = ^EnumRangeRecord;
	EnumRangeRecord = RECORD
		enumID:					LONGINT;								{  'enum' list in root container to search within }
	END;

{  'fixd' }
	FixedRangeRecordPtr = ^FixedRangeRecord;
	FixedRangeRecord = RECORD
		minValue:				Fixed;									{  no less than this }
		maxValue:				Fixed;									{  no more than this }
		scaleValue:				Fixed;									{  muliply content by this going in, divide going out }
		precisionDigits:		LONGINT;								{  # digits of precision when editing via typing }
	END;

{  'doub' }
{  'bool'    }
	BooleanRangeRecordPtr = ^BooleanRangeRecord;
	BooleanRangeRecord = RECORD
		maskValue:				LONGINT;								{  value to mask on/off to set/clear the boolean }
	END;

{  'rgb ' }
	RGBRangeRecordPtr = ^RGBRangeRecord;
	RGBRangeRecord = RECORD
		minColor:				RGBColor;
		maxColor:				RGBColor;
	END;

{  'imag' }

CONST
	kParameterImageNoFlags		= 0;
	kParameterImageIsPreset		= 1;

	kStandardPresetGroup		= 'pset';


TYPE
	ImageRangeRecordPtr = ^ImageRangeRecord;
	ImageRangeRecord = RECORD
		imageFlags:				LONGINT;
		fileType:				OSType;									{  file type to contain the preset group (normally kStandardPresetGroup) }
		replacedAtoms:			LONGINT;								{  # atoms at this level replaced by this preset group }
	END;

{  union of all of the above }
{  UI behavior of a parameter }

CONST
	kParameterDataBehavior		= 'ditl';

																{  items edited via typing }
	kParameterItemEditText		= 'edit';						{  edit text box }
	kParameterItemEditLong		= 'long';						{  long number editing box }
	kParameterItemEditFixed		= 'fixd';						{  fixed point number editing box }
	kParameterItemEditDouble	= 'doub';						{  double number editing box }
																{  items edited via control(s) }
	kParameterItemPopUp			= 'popu';						{  pop up value for enum types }
	kParameterItemRadioCluster	= 'radi';						{  radio cluster for enum types }
	kParameterItemCheckBox		= 'chex';						{  check box for booleans }
	kParameterItemControl		= 'cntl';						{  item controlled via a standard control of some type }
																{  special user items }
	kParameterItemLine			= 'line';						{  line }
	kParameterItemColorPicker	= 'pick';						{  color swatch & picker }
	kParameterItemGroupDivider	= 'divi';						{  start of a new group of items }
	kParameterItemStaticText	= 'stat';						{  display "parameter name" as static text }
	kParameterItemDragImage		= 'imag';						{  allow image display, along with drag and drop }
																{  flags valid for lines and groups }
	kGraphicsNoFlags			= $00000000;					{  no options for graphics }
	kGraphicsFlagsGray			= $00000001;					{  draw lines with gray }
																{  flags valid for groups }
	kGroupNoFlags				= $00000000;					{  no options for group -- may be combined with graphics options              }
	kGroupAlignText				= $00010000;					{  edit text items in group have the same size }
	kGroupSurroundBox			= $00020000;					{  group should be surrounded with a box }
	kGroupMatrix				= $00040000;					{  side-by-side arrangement of group is okay }
	kGroupNoName				= $00080000;					{  name of group should not be displayed above box }
																{  flags valid for popup/radiocluster/checkbox/control }
	kDisableControl				= $00000001;
	kDisableWhenNotEqual		= $00000001;
	kDisableWhenEqual			= $00000011;
	kDisableWhenLessThan		= $00000021;
	kDisableWhenGreaterThan		= $00000031;					{  flags valid for popups }
	kPopupStoreAsString			= $00010000;


TYPE
	ControlBehaviorsPtr = ^ControlBehaviors;
	ControlBehaviors = RECORD
		groupID:				QTAtomID;								{  group under control of this item }
		controlValue:			LONGINT;								{  control value for comparison purposes }
	END;

	ParameterDataBehaviorPtr = ^ParameterDataBehavior;
	ParameterDataBehavior = RECORD
		behaviorType:			OSType;
		behaviorFlags:			LONGINT;
		CASE INTEGER OF
		0: (
			controls:			ControlBehaviors;
			);
	END;

{  higher level purpose of a parameter or set of parameters }

CONST
	kParameterDataUsage			= 'use ';

	kParameterUsagePixels		= 'pixl';
	kParameterUsageRectangle	= 'rect';
	kParameterUsagePoint		= 'xy  ';
	kParameterUsage3DPoint		= 'xyz ';
	kParameterUsageDegrees		= 'degr';
	kParameterUsageRadians		= 'rads';
	kParameterUsagePercent		= 'pcnt';
	kParameterUsageSeconds		= 'secs';
	kParameterUsageMilliseconds	= 'msec';
	kParameterUsageMicroseconds	= 'µsec';
	kParameterUsage3by3Matrix	= '3by3';
	kParameterUsageCircularDegrees = 'degc';
	kParameterUsageCircularRadians = 'radc';


TYPE
	ParameterDataUsagePtr = ^ParameterDataUsage;
	ParameterDataUsage = RECORD
		usageType:				OSType;									{  higher level purpose of the data or group }
	END;

{  default value(s) for a parameter }

CONST
	kParameterDataDefaultItem	= 'dflt';

{ atoms that help to fill in data within the info window }
	kParameterInfoLongName		= '©nam';
	kParameterInfoCopyright		= '©cpy';
	kParameterInfoDescription	= '©inf';
	kParameterInfoWindowTitle	= '©wnt';
	kParameterInfoPicture		= '©pix';
	kParameterInfoManufacturer	= '©man';
	kParameterInfoIDs			= 1;

{ flags for ImageCodecValidateParameters }
	kParameterValidationNoFlags	= $00000000;
	kParameterValidationFinalValidation = $00000001;


TYPE
	QTParameterValidationOptions		= LONGINT;
{  QTAtomTypes for atoms in image compressor settings containers }

CONST
	kImageCodecSettingsFieldCount = 'fiel';						{  Number of fields (UInt8)  }
	kImageCodecSettingsFieldOrdering = 'fdom';					{  Ordering of fields (UInt8) }
	kImageCodecSettingsFieldOrderingF1F2 = 1;
	kImageCodecSettingsFieldOrderingF2F1 = 2;


{  Additional Image Description Extensions }
	kColorInfoImageDescriptionExtension = 'colr';				{  image description extension describing the color properties     }
	kPixelAspectRatioImageDescriptionExtension = 'pasp';		{  image description extension describing the pixel aspect ratio }
	kCleanApertureImageDescriptionExtension = 'clap';			{  image description extension describing the pixel aspect ratio }


{  Color Info Image Description Extension types }
	kVideoColorInfoImageDescriptionExtensionType = 'nclc';		{  For video color descriptions (defined below)     }
	kICCProfileColorInfoImageDescriptionExtensionType = 'prof';	{  For ICC Profile color descriptions (not defined here) }


{  Video Color Info Image Description Extensions }

TYPE
	NCLCColorInfoImageDescriptionExtensionPtr = ^NCLCColorInfoImageDescriptionExtension;
	NCLCColorInfoImageDescriptionExtension = RECORD
		colorParamType:			OSType;									{  Type of color parameter 'nclc'                }
		primaries:				UInt16;									{  CIE 1931 xy chromaticity coordinates           }
		transferFunction:		UInt16;									{  Nonlinear transfer function from RGB to ErEgEb  }
		matrix:					UInt16;									{  Matrix from ErEgEb to EyEcbEcr            }
	END;

{  Primaries }

CONST
	kQTPrimaries_ITU_R709_2		= 1;							{  ITU-R BT.709-2, SMPTE 274M-1995, and SMPTE 296M-1997  }
	kQTPrimaries_Unknown		= 2;							{  Unknown  }
	kQTPrimaries_EBU_3213		= 5;							{  EBU Tech. 3213 (1981)  }
	kQTPrimaries_SMPTE_C		= 6;							{  SMPTE C Primaries from SMPTE RP 145-1993  }

{  Transfer Function }
	kQTTransferFunction_ITU_R709_2 = 1;							{  Recommendation ITU-R BT.709-2, SMPTE 274M-1995, SMPTE 296M-1997, SMPTE 293M-1996 and SMPTE 170M-1994  }
	kQTTransferFunction_Unknown	= 2;							{  Unknown  }
	kQTTransferFunction_SMPTE_240M_1995 = 7;					{  SMPTE 240M-1995 and interim color implementation of SMPTE 274M-1995  }

{  Matrix }
	kQTMatrix_ITU_R_709_2		= 1;							{  Recommendation ITU-R BT.709-2 (1125/60/2:1 only), SMPTE 274M-1995 and SMPTE 296M-1997  }
	kQTMatrix_Unknown			= 2;							{  Unknown  }
	kQTMatrix_ITU_R_601_4		= 6;							{  Recommendation ITU-R BT.601-4, Recommendation ITU-R BT.470-4 System B and G, SMPTE 170M-1994 and SMPTE 293M-1996  }
	kQTMatrix_SMPTE_240M_1995	= 7;							{  SMPTE 240M-1995 and interim color implementation of SMPTE 274M-1995  }


{  Field/Frame Info Image Description (this remaps to FieldInfoImageDescriptionExtension) }

TYPE
	FieldInfoImageDescriptionExtension2Ptr = ^FieldInfoImageDescriptionExtension2;
	FieldInfoImageDescriptionExtension2 = PACKED RECORD
		fields:					UInt8;
		detail:					UInt8;
	END;


CONST
	kQTFieldsProgressiveScan	= 1;
	kQTFieldsInterlaced			= 2;

	kQTFieldDetailUnknown		= 0;
	kQTFieldDetailTemporalTopFirst = 1;
	kQTFieldDetailTemporalBottomFirst = 6;
	kQTFieldDetailSpatialFirstLineEarly = 9;
	kQTFieldDetailSpatialFirstLineLate = 14;


{  Pixel Aspect Ratio Image Description Extensions }

TYPE
	PixelAspectRatioImageDescriptionExtensionPtr = ^PixelAspectRatioImageDescriptionExtension;
	PixelAspectRatioImageDescriptionExtension = RECORD
		hSpacing:				UInt32;									{  Horizontal Spacing  }
		vSpacing:				UInt32;									{  Vertical Spacing  }
	END;

{  Clean Aperture Image Description Extensions }
	CleanApertureImageDescriptionExtensionPtr = ^CleanApertureImageDescriptionExtension;
	CleanApertureImageDescriptionExtension = RECORD
		cleanApertureWidthN:	UInt32;									{  width of clean aperture, numerator, denominator  }
		cleanApertureWidthD:	UInt32;
		cleanApertureHeightN:	UInt32;									{  height of clean aperture, numerator, denominator }
		cleanApertureHeightD:	UInt32;
		horizOffN:				UInt32;									{  horizontal offset of clean aperture center minus (width-1)/2, numerator, denominator  }
		horizOffD:				UInt32;
		vertOffN:				UInt32;									{  vertical offset of clean aperture center minus (height-1)/2, numerator, denominator  }
		vertOffD:				UInt32;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ImageCodecMPDrawBandProcPtr = FUNCTION(refcon: UNIV Ptr; VAR drp: ImageSubCodecDecompressRecord): ComponentResult;
{$ELSEC}
	ImageCodecMPDrawBandProcPtr = ProcPtr;
{$ENDC}

	ImageCodecMPDrawBandUPP = UniversalProcPtr;

CONST
	uppImageCodecMPDrawBandProcInfo = $000003F0;

FUNCTION NewImageCodecMPDrawBandUPP(userRoutine: ImageCodecMPDrawBandProcPtr): ImageCodecMPDrawBandUPP; { old name was NewImageCodecMPDrawBandProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeImageCodecMPDrawBandUPP(userUPP: ImageCodecMPDrawBandUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeImageCodecMPDrawBandUPP(refcon: UNIV Ptr; VAR drp: ImageSubCodecDecompressRecord; userRoutine: ImageCodecMPDrawBandUPP): ComponentResult; { old name was CallImageCodecMPDrawBandProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{  codec selectors 0-127 are reserved by Apple }
{  codec selectors 128-191 are subtype specific }
{  codec selectors 192-255 are vendor specific }
{  codec selectors 256-32767 are available for general use }
{  negative selectors are reserved by the Component Manager }
FUNCTION ImageCodecGetCodecInfo(ci: ComponentInstance; VAR info: CodecInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetCompressionTime(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; depth: INTEGER; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR time: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetMaxCompressionSize(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; depth: INTEGER; quality: CodecQ; VAR size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecPreCompress(ci: ComponentInstance; VAR params: CodecCompressParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBandCompress(ci: ComponentInstance; VAR params: CodecCompressParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecPreDecompress(ci: ComponentInstance; VAR params: CodecDecompressParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBandDecompress(ci: ComponentInstance; VAR params: CodecDecompressParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBusy(ci: ComponentInstance; seq: ImageSequence): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetCompressedImageSize(ci: ComponentInstance; desc: ImageDescriptionHandle; data: Ptr; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; VAR dataSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetSimilarity(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; desc: ImageDescriptionHandle; data: Ptr; VAR similarity: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecTrimImage(ci: ComponentInstance; Desc: ImageDescriptionHandle; inData: Ptr; inBufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; outData: Ptr; outBufferSize: LONGINT; flushProc: ICMFlushProcRecordPtr; VAR trimRect: Rect; progressProc: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecRequestSettings(ci: ComponentInstance; settings: Handle; VAR rp: Rect; filterProc: ModalFilterUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetSettings(ci: ComponentInstance; settings: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecSetSettings(ci: ComponentInstance; settings: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecFlush(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecSetTimeCode(ci: ComponentInstance; timeCodeFormat: UNIV Ptr; timeCodeTime: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecIsImageDescriptionEquivalent(ci: ComponentInstance; newDesc: ImageDescriptionHandle; VAR equivalent: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecNewMemory(ci: ComponentInstance; VAR data: Ptr; dataSize: Size; dataUse: LONGINT; memoryGoneProc: ICMMemoryDisposedUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecDisposeMemory(ci: ComponentInstance; data: Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecHitTestData(ci: ComponentInstance; desc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: Size; where: Point; VAR hit: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecNewImageBufferMemory(ci: ComponentInstance; VAR params: CodecDecompressParams; flags: LONGINT; memoryGoneProc: ICMMemoryDisposedUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecExtractAndCombineFields(ci: ComponentInstance; fieldFlags: LONGINT; data1: UNIV Ptr; dataSize1: LONGINT; desc1: ImageDescriptionHandle; data2: UNIV Ptr; dataSize2: LONGINT; desc2: ImageDescriptionHandle; outputData: UNIV Ptr; VAR outDataSize: LONGINT; descOut: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0028, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetMaxCompressionSizeWithSources(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; depth: INTEGER; quality: CodecQ; sourceData: CDSequenceDataSourcePtr; VAR size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecSetTimeBase(ci: ComponentInstance; base: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecSourceChanged(ci: ComponentInstance; majorSourceChangeSeed: UInt32; minorSourceChangeSeed: UInt32; sourceData: CDSequenceDataSourcePtr; VAR flagsOut: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecFlushFrame(ci: ComponentInstance; flags: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION ImageCodecGetSettingsAsText(ci: ComponentInstance; VAR text: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION ImageCodecGetParameterListHandle(ci: ComponentInstance; VAR parameterDescriptionHandle: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetParameterList(ci: ComponentInstance; VAR parameterDescription: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecCreateStandardParameterDialog(ci: ComponentInstance; parameterDescription: QTAtomContainer; parameters: QTAtomContainer; dialogOptions: QTParameterDialogOptions; existingDialog: DialogPtr; existingUserItem: INTEGER; VAR createdDialog: QTParameterDialog): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecIsStandardParameterDialogEvent(ci: ComponentInstance; VAR pEvent: EventRecord; createdDialog: QTParameterDialog): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecDismissStandardParameterDialog(ci: ComponentInstance; createdDialog: QTParameterDialog): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecStandardParameterDialogDoAction(ci: ComponentInstance; createdDialog: QTParameterDialog; action: LONGINT; params: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecNewImageGWorld(ci: ComponentInstance; VAR params: CodecDecompressParams; VAR newGW: GWorldPtr; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecDisposeImageGWorld(ci: ComponentInstance; theGW: GWorldPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0022, $7000, $A82A;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION ImageCodecHitTestDataWithFlags(ci: ComponentInstance; desc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: Size; where: Point; VAR hit: LONGINT; hitFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0023, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION ImageCodecValidateParameters(ci: ComponentInstance; parameters: QTAtomContainer; validationFlags: QTParameterValidationOptions; errorString: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetBaseMPWorkFunction(ci: ComponentInstance; VAR workFunction: ComponentMPWorkFunctionUPP; VAR refCon: UNIV Ptr; drawProc: ImageCodecMPDrawBandUPP; drawProcRefCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecPreflight(ci: ComponentInstance; VAR params: CodecDecompressParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0200, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecInitialize(ci: ComponentInstance; VAR cap: ImageSubCodecDecompressCapabilities): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0201, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBeginBand(ci: ComponentInstance; VAR params: CodecDecompressParams; VAR drp: ImageSubCodecDecompressRecord; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0202, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecDrawBand(ci: ComponentInstance; VAR drp: ImageSubCodecDecompressRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0203, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEndBand(ci: ComponentInstance; VAR drp: ImageSubCodecDecompressRecord; result: OSErr; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0204, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecQueueStarting(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0205, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecQueueStopping(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0206, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecDroppingFrame(ci: ComponentInstance; {CONST}VAR drp: ImageSubCodecDecompressRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0207, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecScheduleFrame(ci: ComponentInstance; {CONST}VAR drp: ImageSubCodecDecompressRecord; triggerProc: ImageCodecTimeTriggerUPP; triggerProcRefCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0208, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecCancelTrigger(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0209, $7000, $A82A;
	{$ENDC}











CONST
	kMotionJPEGTag				= 'mjpg';
	kJPEGQuantizationTablesImageDescriptionExtension = 'mjqt';
	kJPEGHuffmanTablesImageDescriptionExtension = 'mjht';
	kFieldInfoImageDescriptionExtension = 'fiel';				{  image description extension describing the field count and field orderings }

	kFieldOrderUnknown			= 0;
	kFieldsStoredF1F2DisplayedF1F2 = 1;
	kFieldsStoredF1F2DisplayedF2F1 = 2;
	kFieldsStoredF2F1DisplayedF1F2 = 5;
	kFieldsStoredF2F1DisplayedF2F1 = 6;


TYPE
	MotionJPEGApp1MarkerPtr = ^MotionJPEGApp1Marker;
	MotionJPEGApp1Marker = RECORD
		unused:					LONGINT;
		tag:					LONGINT;
		fieldSize:				LONGINT;
		paddedFieldSize:		LONGINT;
		offsetToNextField:		LONGINT;
		qTableOffset:			LONGINT;
		huffmanTableOffset:		LONGINT;
		sofOffset:				LONGINT;
		sosOffset:				LONGINT;
		soiOffset:				LONGINT;
	END;

	FieldInfoImageDescriptionExtensionPtr = ^FieldInfoImageDescriptionExtension;
	FieldInfoImageDescriptionExtension = PACKED RECORD
		fieldCount:				UInt8;
		fieldOrderings:			UInt8;
	END;


FUNCTION QTPhotoSetSampling(codec: ComponentInstance; yH: INTEGER; yV: INTEGER; cbH: INTEGER; cbV: INTEGER; crH: INTEGER; crV: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION QTPhotoSetRestartInterval(codec: ComponentInstance; restartInterval: UInt16): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION QTPhotoDefineHuffmanTable(codec: ComponentInstance; componentNumber: INTEGER; isDC: BOOLEAN; VAR lengthCounts: UInt8; VAR values: UInt8): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION QTPhotoDefineQuantizationTable(codec: ComponentInstance; componentNumber: INTEGER; VAR table: UInt8): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0103, $7000, $A82A;
	{$ENDC}




{ source identifier -- placed in root container of description, one or more required }

CONST
	kEffectSourceName			= 'src ';


{ source type -- placed in the input map to identify the source kind }
	kEffectDataSourceType		= 'dtst';

{  default effect types }
	kEffectRawSource			= 0;							{  the source is raw image data }
	kEffectGenericType			= 'geff';						{  generic effect for combining others }


TYPE
	EffectSourcePtr = ^EffectSource;
	SourceDataPtr = ^SourceData;
	SourceData = RECORD
		CASE INTEGER OF
		0: (
			image:				CDSequenceDataSourcePtr;
			);
		1: (
			effect:				EffectSourcePtr;
			);
	END;


	EffectSource = RECORD
		effectType:				LONGINT;								{  type of effect or kEffectRawSource if raw ICM data }
		data:					Ptr;									{  track data for this effect }
		source:					SourceData;								{  source/effect pointers }
		next:					EffectSourcePtr;						{  the next source for the parent effect }
																		{  fields added for QuickTime 4.0 }
		lastTranslatedFrameTime: TimeValue;								{  start frame time of last converted frame, may be -1 }
		lastFrameDuration:		TimeValue;								{  duration of the last converted frame, may be zero }
		lastFrameTimeScale:		TimeValue;								{  time scale of this source frame, only has meaning if above fields are valid }
	END;

	EffectsFrameParamsPtr = ^EffectsFrameParams;
	EffectsFrameParams = RECORD
		frameTime:				ICMFrameTimeRecord;						{  timing data }
		effectDuration:			LONGINT;								{  the duration of a single effect frame }
		doAsync:				BOOLEAN;								{  set to true if the effect can go async }
		pad:					PACKED ARRAY [0..2] OF UInt8;
		source:					EffectSourcePtr;						{  ptr to the source input tree }
		refCon:					Ptr;									{  storage for the effect }
	END;



FUNCTION ImageCodecEffectSetup(effect: ComponentInstance; VAR p: CodecDecompressParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0300, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectBegin(effect: ComponentInstance; VAR p: CodecDecompressParams; ePtr: EffectsFrameParamsPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0301, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectRenderFrame(effect: ComponentInstance; p: EffectsFrameParamsPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0302, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectConvertEffectSourceToFormat(effect: ComponentInstance; sourceToConvert: EffectSourcePtr; requestedDesc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0303, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectCancel(effect: ComponentInstance; p: EffectsFrameParamsPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0304, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectGetSpeed(effect: ComponentInstance; parameters: QTAtomContainer; VAR pFPS: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0305, $7000, $A82A;
	{$ENDC}


CONST
	kSMPTENoFlag				= 0;
	kSMPTESmoothEdgeFlag		= $01;							{  smooth edges of the stroke }
	kSMPTEStrokeEdgeFlag		= $02;							{  stroke edge with color }


TYPE
	SMPTEFlags							= LONGINT;
	SMPTEFrameReference					= LONGINT;

CONST
	kSlideVerticalWipe			= 1;
	kSlideHorizontalWipe		= 2;
	kTopLeftWipe				= 3;
	kTopRightWipe				= 4;
	kBottomRightWipe			= 5;
	kBottomLeftWipe				= 6;
	kFourCornerWipe				= 7;
	kFourBoxWipe				= 8;
	kBarnVerticalWipe			= 21;
	kBarnHorizontalWipe			= 22;
	kTopCenterWipe				= 23;
	kRightCenterWipe			= 24;
	kBottomCenterWipe			= 25;
	kLeftCenterWipe				= 26;
	kDiagonalLeftDownWipe		= 41;
	kDiagonalRightDownWipe		= 42;
	kTopBottomBowTieWipe		= 43;
	kLeftRightBowTieWipe		= 44;
	kDiagonalLeftOutWipe		= 45;
	kDiagonalRightOutWipe		= 46;
	kDiagonalCrossWipe			= 47;
	kDiagonalBoxWipe			= 48;
	kFilledVWipe				= 61;
	kFilledVRightWipe			= 62;
	kFilledVBottomWipe			= 63;
	kFilledVLeftWipe			= 64;
	kHollowVWipe				= 65;
	kHollowVRightWipe			= 66;
	kHollowVBottomWipe			= 67;
	kHollowVLeftWipe			= 68;
	kVerticalZigZagWipe			= 71;
	kHorizontalZigZagWipe		= 72;
	kVerticalBarnZigZagWipe		= 73;
	kHorizontalBarnZigZagWipe	= 74;

	kRectangleWipe				= 101;
	kDiamondWipe				= 102;
	kTriangleWipe				= 103;
	kTriangleRightWipe			= 104;
	kTriangleUpsideDownWipe		= 105;
	kTriangleLeftWipe			= 106;
	kSpaceShipWipe				= 107;
	kSpaceShipRightWipe			= 108;
	kSpaceShipUpsideDownWipe	= 109;
	kSpaceShipLeftWipe			= 110;
	kPentagonWipe				= 111;
	kPentagonUpsideDownWipe		= 112;
	kHexagonWipe				= 113;
	kHexagonSideWipe			= 114;
	kCircleWipe					= 119;
	kOvalWipe					= 120;
	kOvalSideWipe				= 121;
	kCatEyeWipe					= 122;
	kCatEyeSideWipe				= 123;
	kRoundRectWipe				= 124;
	kRoundRectSideWipe			= 125;
	kFourPointStarWipe			= 127;
	kFivePointStarWipe			= 128;
	kStarOfDavidWipe			= 129;
	kHeartWipe					= 130;
	kKeyholeWipe				= 131;

	kRotatingTopWipe			= 201;
	kRotatingRightWipe			= 202;
	kRotatingBottomWipe			= 203;
	kRotatingLeftWipe			= 204;
	kRotatingTopBottomWipe		= 205;
	kRotatingLeftRightWipe		= 206;
	kRotatingQuadrantWipe		= 207;
	kTopToBottom180Wipe			= 211;
	kRightToLeft180Wipe			= 212;
	kTopToBottom90Wipe			= 213;
	kRightToLeft90Wipe			= 214;
	kTop180Wipe					= 221;
	kRight180Wipe				= 222;
	kBottom180Wipe				= 223;
	kLeft180Wipe				= 224;
	kCounterRotatingTopBottomWipe = 225;
	kCounterRotatingLeftRightWipe = 226;
	kDoubleRotatingTopBottomWipe = 227;
	kDoubleRotatingLeftRightWipe = 228;
	kVOpenTopWipe				= 231;
	kVOpenRightWipe				= 232;
	kVOpenBottomWipe			= 233;
	kVOpenLeftWipe				= 234;
	kVOpenTopBottomWipe			= 235;
	kVOpenLeftRightWipe			= 236;
	kRotatingTopLeftWipe		= 241;
	kRotatingBottomLeftWipe		= 242;
	kRotatingBottomRightWipe	= 243;
	kRotatingTopRightWipe		= 244;
	kRotatingTopLeftBottomRightWipe = 245;
	kRotatingBottomLeftTopRightWipe = 246;
	kRotatingTopLeftRightWipe	= 251;
	kRotatingLeftTopBottomWipe	= 252;
	kRotatingBottomLeftRightWipe = 253;
	kRotatingRightTopBottomWipe	= 254;
	kRotatingDoubleCenterRightWipe = 261;
	kRotatingDoubleCenterTopWipe = 262;
	kRotatingDoubleCenterTopBottomWipe = 263;
	kRotatingDoubleCenterLeftRightWipe = 264;

	kHorizontalMatrixWipe		= 301;
	kVerticalMatrixWipe			= 302;
	kTopLeftDiagonalMatrixWipe	= 303;
	kTopRightDiagonalMatrixWipe	= 304;
	kBottomRightDiagonalMatrixWipe = 305;
	kBottomLeftDiagonalMatrixWipe = 306;
	kClockwiseTopLeftMatrixWipe	= 310;
	kClockwiseTopRightMatrixWipe = 311;
	kClockwiseBottomRightMatrixWipe = 312;
	kClockwiseBottomLeftMatrixWipe = 313;
	kCounterClockwiseTopLeftMatrixWipe = 314;
	kCounterClockwiseTopRightMatrixWipe = 315;
	kCounterClockwiseBottomRightMatrixWipe = 316;
	kCounterClockwiseBottomLeftMatrixWipe = 317;
	kVerticalStartTopMatrixWipe	= 320;
	kVerticalStartBottomMatrixWipe = 321;
	kVerticalStartTopOppositeMatrixWipe = 322;
	kVerticalStartBottomOppositeMatrixWipe = 323;
	kHorizontalStartLeftMatrixWipe = 324;
	kHorizontalStartRightMatrixWipe = 325;
	kHorizontalStartLeftOppositeMatrixWipe = 326;
	kHorizontalStartRightOppositeMatrixWipe = 327;
	kDoubleDiagonalTopRightMatrixWipe = 328;
	kDoubleDiagonalBottomRightMatrixWipe = 329;
	kDoubleSpiralTopMatixWipe	= 340;
	kDoubleSpiralBottomMatixWipe = 341;
	kDoubleSpiralLeftMatixWipe	= 342;
	kDoubleSpiralRightMatixWipe	= 343;
	kQuadSpiralVerticalMatixWipe = 344;
	kQuadSpiralHorizontalMatixWipe = 345;
	kVerticalWaterfallLeftMatrixWipe = 350;
	kVerticalWaterfallRightMatrixWipe = 351;
	kHorizontalWaterfallLeftMatrixWipe = 352;
	kHorizontalWaterfallRightMatrixWipe = 353;
	kRandomWipe					= 409;							{  non-SMPTE standard numbers }
	kRandomWipeGroupWipe		= 501;
	kRandomIrisGroupWipe		= 502;
	kRandomRadialGroupWipe		= 503;
	kRandomMatrixGroupWipe		= 504;


TYPE
	SMPTEWipeType						= UInt32;
FUNCTION ImageCodecEffectPrepareSMPTEFrame(effect: ComponentInstance; destPixMap: PixMapPtr; VAR returnValue: SMPTEFrameReference): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectDisposeSMPTEFrame(effect: ComponentInstance; frameRef: SMPTEFrameReference): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecEffectRenderSMPTEFrame(effect: ComponentInstance; destPixMap: PixMapPtr; frameRef: SMPTEFrameReference; effectPercentageEven: Fixed; effectPercentageOdd: Fixed; VAR pSourceRect: Rect; VAR pMatrix: MatrixRecord; effectNumber: SMPTEWipeType; xRepeat: LONGINT; yRepeat: LONGINT; flags: SMPTEFlags; penWidth: Fixed; strokeValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0030, $0102, $7000, $A82A;
	{$ENDC}


{ curve atom types and data structures }

CONST
	kCurvePathAtom				= 'path';
	kCurveEndAtom				= 'zero';
	kCurveAntialiasControlAtom	= 'anti';
	kCurveAntialiasOff			= 0;
	kCurveAntialiasOn			= $FFFFFFFF;
	kCurveFillTypeAtom			= 'fill';
	kCurvePenThicknessAtom		= 'pent';
	kCurveMiterLimitAtom		= 'mitr';
	kCurveJoinAttributesAtom	= 'join';
	kCurveMinimumDepthAtom		= 'mind';
	kCurveDepthAlwaysOffscreenMask = $80000000;
	kCurveTransferModeAtom		= 'xfer';
	kCurveGradientAngleAtom		= 'angl';
	kCurveGradientRadiusAtom	= 'radi';
	kCurveGradientOffsetAtom	= 'cent';

	kCurveARGBColorAtom			= 'argb';


TYPE
	ARGBColorPtr = ^ARGBColor;
	ARGBColor = RECORD
		alpha:					UInt16;
		red:					UInt16;
		green:					UInt16;
		blue:					UInt16;
	END;


CONST
	kCurveGradientRecordAtom	= 'grad';


TYPE
	GradientColorRecordPtr = ^GradientColorRecord;
	GradientColorRecord = RECORD
		thisColor:				ARGBColor;
		endingPercentage:		Fixed;
	END;

	GradientColorPtr					= ^GradientColorRecord;

CONST
	kCurveGradientTypeAtom		= 'grdt';

{ currently supported gradient types }
	kLinearGradient				= 0;
	kCircularGradient			= 1;


TYPE
	GradientType						= LONGINT;
FUNCTION CurveGetLength(effect: ComponentInstance; VAR target: gxPaths; index: LONGINT; VAR wideLength: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION CurveLengthToPoint(effect: ComponentInstance; VAR target: gxPaths; index: LONGINT; length: Fixed; VAR location: FixedPoint; VAR tangent: FixedPoint): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION CurveNewPath(effect: ComponentInstance; VAR pPath: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION CurveCountPointsInPath(effect: ComponentInstance; VAR aPath: gxPaths; contourIndex: UInt32; VAR pCount: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION CurveGetPathPoint(effect: ComponentInstance; VAR aPath: gxPaths; contourIndex: UInt32; pointIndex: UInt32; VAR thePoint: gxPoint; VAR ptIsOnPath: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION CurveInsertPointIntoPath(effect: ComponentInstance; VAR aPoint: gxPoint; thePath: Handle; contourIndex: UInt32; pointIndex: UInt32; ptIsOnPath: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION CurveSetPathPoint(effect: ComponentInstance; VAR aPath: gxPaths; contourIndex: UInt32; pointIndex: UInt32; VAR thePoint: gxPoint; ptIsOnPath: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION CurveGetNearestPathPoint(effect: ComponentInstance; VAR aPath: gxPaths; VAR thePoint: FixedPoint; VAR contourIndex: UInt32; VAR pointIndex: UInt32; VAR theDelta: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION CurvePathPointToLength(ci: ComponentInstance; VAR aPath: gxPaths; startDist: Fixed; endDist: Fixed; VAR thePoint: FixedPoint; VAR pLength: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION CurveCreateVectorStream(effect: ComponentInstance; VAR pStream: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION CurveAddAtomToVectorStream(effect: ComponentInstance; atomType: OSType; atomSize: Size; pAtomData: UNIV Ptr; vectorStream: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010A, $7000, $A82A;
	{$ENDC}
FUNCTION CurveAddPathAtomToVectorStream(effect: ComponentInstance; pathData: Handle; vectorStream: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $010B, $7000, $A82A;
	{$ENDC}
FUNCTION CurveAddZeroAtomToVectorStream(effect: ComponentInstance; vectorStream: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010C, $7000, $A82A;
	{$ENDC}
FUNCTION CurveGetAtomDataFromVectorStream(effect: ComponentInstance; vectorStream: Handle; atomType: LONGINT; VAR dataSize: LONGINT; VAR dataPtr: Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010D, $7000, $A82A;
	{$ENDC}

{ UPP call backs }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ImageCodecIncludes}

{$ENDC} {__IMAGECODEC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
