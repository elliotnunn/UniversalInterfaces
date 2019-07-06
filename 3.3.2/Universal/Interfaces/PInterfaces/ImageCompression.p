{
     File:       ImageCompression.p
 
     Contains:   QuickTime Image Compression Interfaces.
 
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
 UNIT ImageCompression;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$SETC __IMAGECOMPRESSION__ := 1}

{$I+}
{$SETC ImageCompressionIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	MatrixRecordPtr = ^MatrixRecord;
	MatrixRecord = RECORD
		matrix:					ARRAY [0..2,0..2] OF Fixed;
	END;


CONST
	kRawCodecType				= 'raw ';
	kCinepakCodecType			= 'cvid';
	kGraphicsCodecType			= 'smc ';
	kAnimationCodecType			= 'rle ';
	kVideoCodecType				= 'rpza';
	kComponentVideoCodecType	= 'yuv2';
	kJPEGCodecType				= 'jpeg';
	kMotionJPEGACodecType		= 'mjpa';
	kMotionJPEGBCodecType		= 'mjpb';
	kSGICodecType				= '.SGI';
	kPlanarRGBCodecType			= '8BPS';
	kMacPaintCodecType			= 'PNTG';
	kGIFCodecType				= 'gif ';
	kPhotoCDCodecType			= 'kpcd';
	kQuickDrawGXCodecType		= 'qdgx';
	kAVRJPEGCodecType			= 'avr ';
	kOpenDMLJPEGCodecType		= 'dmb1';
	kBMPCodecType				= 'WRLE';
	kWindowsRawCodecType		= 'WRAW';
	kVectorCodecType			= 'path';
	kQuickDrawCodecType			= 'qdrw';
	kWaterRippleCodecType		= 'ripl';
	kFireCodecType				= 'fire';
	kCloudCodecType				= 'clou';
	kH261CodecType				= 'h261';
	kH263CodecType				= 'h263';
	kDVCNTSCCodecType			= 'dvc ';
	kDVCPALCodecType			= 'dvcp';
	kDVCProNTSCCodecType		= 'dvpn';
	kDVCProPALCodecType			= 'dvpp';
	kBaseCodecType				= 'base';
	kFLCCodecType				= 'flic';
	kTargaCodecType				= 'tga ';
	kPNGCodecType				= 'png ';
	kTIFFCodecType				= 'tiff';						{     NOTE: despite what might seem obvious from the two constants }
																{     below and their names, they really are correct. 'yuvu' really  }
																{     does mean signed, and 'yuvs' really does mean unsigned. Really.  }
	kComponentVideoSigned		= 'yuvu';
	kComponentVideoUnsigned		= 'yuvs';
	kCMYKCodecType				= 'cmyk';
	kMicrosoftVideo1CodecType	= 'msvc';
	kSorensonCodecType			= 'SVQ1';
	kIndeo4CodecType			= 'IV41';
	k64ARGBCodecType			= 'b64a';
	k48RGBCodecType				= 'b48r';
	k32AlphaGrayCodecType		= 'b32a';
	k16GrayCodecType			= 'b16g';
	kMpegYUV420CodecType		= 'myuv';
	kYUV420CodecType			= 'y420';
	kSorensonYUV9CodecType		= 'syv9';
	k422YpCbCr8CodecType		= '2vuy';						{  Component Y'CbCr 8-bit 4:2:2   }
	k444YpCbCr8CodecType		= 'v308';						{  Component Y'CbCr 8-bit 4:4:4   }
	k4444YpCbCrA8CodecType		= 'v408';						{  Component Y'CbCrA 8-bit 4:4:4:4  }
	k422YpCbCr16CodecType		= 'v216';						{  Component Y'CbCr 10,12,14,16-bit 4:2:2 }
	k422YpCbCr10CodecType		= 'v210';						{  Component Y'CbCr 10-bit 4:2:2  }
	k444YpCbCr10CodecType		= 'v410';						{  Component Y'CbCr 10-bit 4:4:4  }
	k4444YpCbCrA8RCodecType		= 'r408';						{  Component Y'CbCrA 8-bit 4:4:4:4, rendering format. full range alpha, zero biased yuv }


{ one source effects }
	kBlurImageFilterType		= 'blur';
	kSharpenImageFilterType		= 'shrp';
	kEdgeDetectImageFilterType	= 'edge';
	kEmbossImageFilterType		= 'embs';
	kConvolveImageFilterType	= 'genk';
	kAlphaGainImageFilterType	= 'gain';
	kRGBColorBalanceImageFilterType = 'rgbb';
	kHSLColorBalanceImageFilterType = 'hslb';
	kColorSyncImageFilterType	= 'sync';
	kFilmNoiseImageFilterType	= 'fmns';
	kSolarizeImageFilterType	= 'solr';
	kColorTintImageFilterType	= 'tint';
	kLensFlareImageFilterType	= 'lens';
	kBrightnessContrastImageFilterType = 'brco';

{ two source effects }
	kAlphaCompositorTransitionType = 'blnd';
	kCrossFadeTransitionType	= 'dslv';
	kChromaKeyTransitionType	= 'ckey';
	kImplodeTransitionType		= 'mplo';
	kExplodeTransitionType		= 'xplo';
	kGradientTransitionType		= 'matt';
	kPushTransitionType			= 'push';
	kSlideTransitionType		= 'slid';
	kWipeTransitionType			= 'smpt';
	kIrisTransitionType			= 'smp2';
	kRadialTransitionType		= 'smp3';
	kMatrixTransitionType		= 'smp4';
	kZoomTransitionType			= 'zoom';

{ These are the bits that are set in the Component flags, and also in the codecInfo struct. }
	codecInfoDoes1				= $00000001;					{  codec can work with 1-bit pixels  }
	codecInfoDoes2				= $00000002;					{  codec can work with 2-bit pixels  }
	codecInfoDoes4				= $00000004;					{  codec can work with 4-bit pixels  }
	codecInfoDoes8				= $00000008;					{  codec can work with 8-bit pixels  }
	codecInfoDoes16				= $00000010;					{  codec can work with 16-bit pixels  }
	codecInfoDoes32				= $00000020;					{  codec can work with 32-bit pixels  }
	codecInfoDoesDither			= $00000040;					{  codec can do ditherMode  }
	codecInfoDoesStretch		= $00000080;					{  codec can stretch to arbitrary sizes  }
	codecInfoDoesShrink			= $00000100;					{  codec can shrink to arbitrary sizes  }
	codecInfoDoesMask			= $00000200;					{  codec can mask to clipping regions  }
	codecInfoDoesTemporal		= $00000400;					{  codec can handle temporal redundancy  }
	codecInfoDoesDouble			= $00000800;					{  codec can stretch to double size exactly  }
	codecInfoDoesQuad			= $00001000;					{  codec can stretch to quadruple size exactly  }
	codecInfoDoesHalf			= $00002000;					{  codec can shrink to half size  }
	codecInfoDoesQuarter		= $00004000;					{  codec can shrink to quarter size  }
	codecInfoDoesRotate			= $00008000;					{  codec can rotate on decompress  }
	codecInfoDoesHorizFlip		= $00010000;					{  codec can flip horizontally on decompress  }
	codecInfoDoesVertFlip		= $00020000;					{  codec can flip vertically on decompress  }
	codecInfoHasEffectParameterList = $00040000;				{  codec implements get effects parameter list call, once was codecInfoDoesSkew  }
	codecInfoDoesBlend			= $00080000;					{  codec can blend on decompress  }
	codecInfoDoesWarp			= $00100000;					{  codec can warp arbitrarily on decompress  }
	codecInfoDoesRecompress		= $00200000;					{  codec can recompress image without accumulating errors  }
	codecInfoDoesSpool			= $00400000;					{  codec can spool image data  }
	codecInfoDoesRateConstrain	= $00800000;					{  codec can data rate constrain  }


	codecInfoDepth1				= $00000001;					{  compressed data at 1 bpp depth available  }
	codecInfoDepth2				= $00000002;					{  compressed data at 2 bpp depth available  }
	codecInfoDepth4				= $00000004;					{  compressed data at 4 bpp depth available  }
	codecInfoDepth8				= $00000008;					{  compressed data at 8 bpp depth available  }
	codecInfoDepth16			= $00000010;					{  compressed data at 16 bpp depth available  }
	codecInfoDepth32			= $00000020;					{  compressed data at 32 bpp depth available  }
	codecInfoDepth24			= $00000040;					{  compressed data at 24 bpp depth available  }
	codecInfoDepth33			= $00000080;					{  compressed data at 1 bpp monochrome depth  available  }
	codecInfoDepth34			= $00000100;					{  compressed data at 2 bpp grayscale depth available  }
	codecInfoDepth36			= $00000200;					{  compressed data at 4 bpp grayscale depth available  }
	codecInfoDepth40			= $00000400;					{  compressed data at 8 bpp grayscale depth available  }
	codecInfoStoresClut			= $00000800;					{  compressed data can have custom cluts  }
	codecInfoDoesLossless		= $00001000;					{  compressed data can be stored in lossless format  }
	codecInfoSequenceSensitive	= $00002000;					{  compressed data is sensitive to out of sequence decoding  }


{  input sequence flags }
	codecFlagUseImageBuffer		= $00000001;					{  decompress }
	codecFlagUseScreenBuffer	= $00000002;					{  decompress }
	codecFlagUpdatePrevious		= $00000004;					{  compress }
	codecFlagNoScreenUpdate		= $00000008;					{  decompress }
	codecFlagWasCompressed		= $00000010;					{  compress }
	codecFlagDontOffscreen		= $00000020;					{  decompress }
	codecFlagUpdatePreviousComp	= $00000040;					{  compress }
	codecFlagForceKeyFrame		= $00000080;					{  compress }
	codecFlagOnlyScreenUpdate	= $00000100;					{  decompress }
	codecFlagLiveGrab			= $00000200;					{  compress }
	codecFlagDiffFrame			= $00000200;					{  decompress }
	codecFlagDontUseNewImageBuffer = $00000400;					{  decompress }
	codecFlagInterlaceUpdate	= $00000800;					{  decompress }
	codecFlagCatchUpDiff		= $00001000;					{  decompress }
	codecFlagSupportDisable		= $00002000;					{  decompress }
	codecFlagReenable			= $00004000;					{  decompress }

{  output sequence flags }
	codecFlagOutUpdateOnNextIdle = $00000200;
	codecFlagOutUpdateOnDataSourceChange = $00000400;
	codecFlagSequenceSensitive	= $00000800;
	codecFlagOutUpdateOnTimeChange = $00001000;
	codecFlagImageBufferNotSourceImage = $00002000;
	codecFlagUsedNewImageBuffer	= $00004000;
	codecFlagUsedImageBuffer	= $00008000;




																{  The minimum data size for spooling in or out data  }
	codecMinimumDataSize		= 32768;



	compressorComponentType		= 'imco';						{  the type for "Components" which compress images  }
	decompressorComponentType	= 'imdc';						{  the type for "Components" which decompress images  }


TYPE
	CompressorComponent					= Component;
	DecompressorComponent				= Component;
	CodecComponent						= Component;

CONST
	anyCodec					= 0;							{  take first working codec of given type  }
	bestSpeedCodec				= -1;							{  take fastest codec of given type  }
	bestFidelityCodec			= -2;							{  take codec which is most accurate  }
	bestCompressionCodec		= -3;							{  take codec of given type that is most accurate  }


TYPE
	CodecType							= OSType;
	CodecFlags							= UInt16;
	CodecQ								= UInt32;

CONST
	codecLosslessQuality		= $00000400;
	codecMaxQuality				= $000003FF;
	codecMinQuality				= $00000000;
	codecLowQuality				= $00000100;
	codecNormalQuality			= $00000200;
	codecHighQuality			= $00000300;

	codecLockBitsShieldCursor	= $01;							{  shield cursor  }

	codecCompletionSource		= $01;							{  asynchronous codec is done with source data  }
	codecCompletionDest			= $02;							{  asynchronous codec is done with destination data  }
	codecCompletionDontUnshield	= $04;							{  on dest complete don't unshield cursor  }
	codecCompletionWentOffscreen = $08;							{  codec used offscreen buffer  }
	codecCompletionUnlockBits	= $10;							{  on dest complete, call ICMSequenceUnlockBits  }
	codecCompletionForceChainFlush = $20;						{  ICM needs to flush the whole chain  }
	codecCompletionDropped		= $40;							{  codec decided to drop this frame  }

	codecProgressOpen			= 0;
	codecProgressUpdatePercent	= 1;
	codecProgressClose			= 2;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ICMDataProcPtr = FUNCTION(VAR dataP: Ptr; bytesNeeded: LONGINT; refcon: LONGINT): OSErr;
{$ELSEC}
	ICMDataProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ICMFlushProcPtr = FUNCTION(data: Ptr; bytesAdded: LONGINT; refcon: LONGINT): OSErr;
{$ELSEC}
	ICMFlushProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ICMCompletionProcPtr = PROCEDURE(result: OSErr; flags: INTEGER; refcon: LONGINT);
{$ELSEC}
	ICMCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ICMProgressProcPtr = FUNCTION(message: INTEGER; completeness: Fixed; refcon: LONGINT): OSErr;
{$ELSEC}
	ICMProgressProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	StdPixProcPtr = PROCEDURE(VAR src: PixMap; VAR srcRect: Rect; VAR matrix: MatrixRecord; mode: INTEGER; mask: RgnHandle; VAR matte: PixMap; VAR matteRect: Rect; flags: INTEGER);
{$ELSEC}
	StdPixProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPixProcPtr = PROCEDURE(VAR src: PixMap; VAR srcRect: Rect; VAR matrix: MatrixRecord; mode: INTEGER; mask: RgnHandle; VAR matte: PixMap; VAR matteRect: Rect; flags: INTEGER);
{$ELSEC}
	QDPixProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ICMAlignmentProcPtr = PROCEDURE(VAR rp: Rect; refcon: LONGINT);
{$ELSEC}
	ICMAlignmentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ICMCursorShieldedProcPtr = PROCEDURE({CONST}VAR r: Rect; refcon: UNIV Ptr; flags: LONGINT);
{$ELSEC}
	ICMCursorShieldedProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ICMMemoryDisposedProcPtr = PROCEDURE(memoryBlock: Ptr; refcon: UNIV Ptr);
{$ELSEC}
	ICMMemoryDisposedProcPtr = ProcPtr;
{$ENDC}

	ICMCursorNotify						= Ptr;
{$IFC TYPED_FUNCTION_POINTERS}
	ICMConvertDataFormatProcPtr = FUNCTION(refCon: UNIV Ptr; flags: LONGINT; desiredFormat: Handle; sourceDataFormat: Handle; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT): OSErr;
{$ELSEC}
	ICMConvertDataFormatProcPtr = ProcPtr;
{$ENDC}

	ICMDataUPP = UniversalProcPtr;
	ICMFlushUPP = UniversalProcPtr;
	ICMCompletionUPP = UniversalProcPtr;
	ICMProgressUPP = UniversalProcPtr;
	StdPixUPP = UniversalProcPtr;
	QDPixUPP = UniversalProcPtr;
	ICMAlignmentUPP = UniversalProcPtr;
	ICMCursorShieldedUPP = UniversalProcPtr;
	ICMMemoryDisposedUPP = UniversalProcPtr;
	ICMConvertDataFormatUPP = UniversalProcPtr;
	ImageSequence						= LONGINT;
	ImageSequenceDataSource				= LONGINT;
	ImageTranscodeSequence				= LONGINT;
	ImageFieldSequence					= LONGINT;
	ICMProgressProcRecordPtr = ^ICMProgressProcRecord;
	ICMProgressProcRecord = RECORD
		progressProc:			ICMProgressUPP;
		progressRefCon:			LONGINT;
	END;

	ICMCompletionProcRecordPtr = ^ICMCompletionProcRecord;
	ICMCompletionProcRecord = RECORD
		completionProc:			ICMCompletionUPP;
		completionRefCon:		LONGINT;
	END;

	ICMDataProcRecordPtr = ^ICMDataProcRecord;
	ICMDataProcRecord = RECORD
		dataProc:				ICMDataUPP;
		dataRefCon:				LONGINT;
	END;

	ICMFlushProcRecordPtr = ^ICMFlushProcRecord;
	ICMFlushProcRecord = RECORD
		flushProc:				ICMFlushUPP;
		flushRefCon:			LONGINT;
	END;

	ICMAlignmentProcRecordPtr = ^ICMAlignmentProcRecord;
	ICMAlignmentProcRecord = RECORD
		alignmentProc:			ICMAlignmentUPP;
		alignmentRefCon:		LONGINT;
	END;

	DataRateParamsPtr = ^DataRateParams;
	DataRateParams = RECORD
		dataRate:				LONGINT;
		dataOverrun:			LONGINT;
		frameDuration:			LONGINT;
		keyFrameRate:			LONGINT;
		minSpatialQuality:		CodecQ;
		minTemporalQuality:		CodecQ;
	END;

	ImageDescriptionPtr = ^ImageDescription;
	ImageDescription = PACKED RECORD
		idSize:					LONGINT;								{  total size of ImageDescription including extra data ( CLUTs and other per sequence data )  }
		cType:					CodecType;								{  what kind of codec compressed this data  }
		resvd1:					LONGINT;								{  reserved for Apple use  }
		resvd2:					INTEGER;								{  reserved for Apple use  }
		dataRefIndex:			INTEGER;								{  set to zero   }
		version:				INTEGER;								{  which version is this data  }
		revisionLevel:			INTEGER;								{  what version of that codec did this  }
		vendor:					LONGINT;								{  whose  codec compressed this data  }
		temporalQuality:		CodecQ;									{  what was the temporal quality factor   }
		spatialQuality:			CodecQ;									{  what was the spatial quality factor  }
		width:					INTEGER;								{  how many pixels wide is this data  }
		height:					INTEGER;								{  how many pixels high is this data  }
		hRes:					Fixed;									{  horizontal resolution  }
		vRes:					Fixed;									{  vertical resolution  }
		dataSize:				LONGINT;								{  if known, the size of data for this image descriptor  }
		frameCount:				INTEGER;								{  number of frames this description applies to  }
		name:					Str31;									{  name of codec ( in case not installed )   }
		depth:					INTEGER;								{  what depth is this data (1-32) or ( 33-40 grayscale )  }
		clutID:					INTEGER;								{  clut id or if 0 clut follows  or -1 if no clut  }
	END;

	ImageDescriptionHandle				= ^ImageDescriptionPtr;
	CodecInfoPtr = ^CodecInfo;
	CodecInfo = PACKED RECORD
		typeName:				Str31;									{  name of the codec type i.e.: 'Apple Image Compression'  }
		version:				INTEGER;								{  version of the codec data that this codec knows about  }
		revisionLevel:			INTEGER;								{  revision level of this codec i.e: 0x00010001 (1.0.1)  }
		vendor:					LONGINT;								{  Maker of this codec i.e: 'appl'  }
		decompressFlags:		LONGINT;								{  codecInfo flags for decompression capabilities  }
		compressFlags:			LONGINT;								{  codecInfo flags for compression capabilities  }
		formatFlags:			LONGINT;								{  codecInfo flags for compression format details  }
		compressionAccuracy:	UInt8;									{  measure (1-255) of accuracy of this codec for compress (0 if unknown)  }
		decompressionAccuracy:	UInt8;									{  measure (1-255) of accuracy of this codec for decompress (0 if unknown)  }
		compressionSpeed:		UInt16;									{  ( millisecs for compressing 320x240 on base mac II) (0 if unknown)   }
		decompressionSpeed:		UInt16;									{  ( millisecs for decompressing 320x240 on mac II)(0 if unknown)   }
		compressionLevel:		UInt8;									{  measure (1-255) of compression level of this codec (0 if unknown)   }
		resvd:					UInt8;									{  pad  }
		minimumHeight:			INTEGER;								{  minimum height of image (block size)  }
		minimumWidth:			INTEGER;								{  minimum width of image (block size)  }
		decompressPipelineLatency: INTEGER;								{  in milliseconds ( for asynchronous codecs )  }
		compressPipelineLatency: INTEGER;								{  in milliseconds ( for asynchronous codecs )  }
		privateData:			LONGINT;
	END;

	CodecNameSpecPtr = ^CodecNameSpec;
	CodecNameSpec = RECORD
		codec:					CodecComponent;
		cType:					CodecType;
		typeName:				Str31;
		name:					Handle;
	END;

	CodecNameSpecListPtr = ^CodecNameSpecList;
	CodecNameSpecList = RECORD
		count:					INTEGER;
		list:					ARRAY [0..0] OF CodecNameSpec;
	END;


CONST
	defaultDither				= 0;
	forceDither					= 1;
	suppressDither				= 2;
	useColorMatching			= 4;

	callStdBits					= 1;
	callOldBits					= 2;
	noDefaultOpcodes			= 4;

	graphicsModeStraightAlpha	= 256;
	graphicsModePreWhiteAlpha	= 257;
	graphicsModePreBlackAlpha	= 258;
	graphicsModeComposition		= 259;
	graphicsModeStraightAlphaBlend = 260;
	graphicsModePreMulColorAlpha = 261;

	evenField1ToEvenFieldOut	= $01;
	evenField1ToOddFieldOut		= $02;
	oddField1ToEvenFieldOut		= $04;
	oddField1ToOddFieldOut		= $08;
	evenField2ToEvenFieldOut	= $10;
	evenField2ToOddFieldOut		= $20;
	oddField2ToEvenFieldOut		= $40;
	oddField2ToOddFieldOut		= $80;

	icmFrameTimeHasVirtualStartTimeAndDuration = $01;


TYPE
	ICMFrameTimeRecordPtr = ^ICMFrameTimeRecord;
	ICMFrameTimeRecord = RECORD
		value:					wide;									{  frame time }
		scale:					LONGINT;								{  timescale of value/duration fields }
		base:					Ptr;									{  timebase }
		duration:				LONGINT;								{  duration frame is to be displayed (0 if unknown) }
		rate:					Fixed;									{  rate of timebase relative to wall-time }
		recordSize:				LONGINT;								{  total number of bytes in ICMFrameTimeRecord }
		frameNumber:			LONGINT;								{  number of frame, zero if not known }
		flags:					LONGINT;
		virtualStartTime:		wide;									{  conceptual start time }
		virtualDuration:		LONGINT;								{  conceptual duration }
	END;

	ICMFrameTimePtr						= ^ICMFrameTimeRecord;

CONST
	uppICMDataProcInfo = $00000FE0;
	uppICMFlushProcInfo = $00000FE0;
	uppICMCompletionProcInfo = $00000E80;
	uppICMProgressProcInfo = $00000FA0;
	uppStdPixProcInfo = $002FEFC0;
	uppQDPixProcInfo = $002FEFC0;
	uppICMAlignmentProcInfo = $000003C0;
	uppICMCursorShieldedProcInfo = $00000FC0;
	uppICMMemoryDisposedProcInfo = $000003C0;
	uppICMConvertDataFormatProcInfo = $003FFFE0;

FUNCTION NewICMDataUPP(userRoutine: ICMDataProcPtr): ICMDataUPP; { old name was NewICMDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMFlushUPP(userRoutine: ICMFlushProcPtr): ICMFlushUPP; { old name was NewICMFlushProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMCompletionUPP(userRoutine: ICMCompletionProcPtr): ICMCompletionUPP; { old name was NewICMCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMProgressUPP(userRoutine: ICMProgressProcPtr): ICMProgressUPP; { old name was NewICMProgressProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewStdPixUPP(userRoutine: StdPixProcPtr): StdPixUPP; { old name was NewStdPixProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDPixUPP(userRoutine: QDPixProcPtr): QDPixUPP; { old name was NewQDPixProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMAlignmentUPP(userRoutine: ICMAlignmentProcPtr): ICMAlignmentUPP; { old name was NewICMAlignmentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMCursorShieldedUPP(userRoutine: ICMCursorShieldedProcPtr): ICMCursorShieldedUPP; { old name was NewICMCursorShieldedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMMemoryDisposedUPP(userRoutine: ICMMemoryDisposedProcPtr): ICMMemoryDisposedUPP; { old name was NewICMMemoryDisposedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMConvertDataFormatUPP(userRoutine: ICMConvertDataFormatProcPtr): ICMConvertDataFormatUPP; { old name was NewICMConvertDataFormatProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeICMDataUPP(userUPP: ICMDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMFlushUPP(userUPP: ICMFlushUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMCompletionUPP(userUPP: ICMCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMProgressUPP(userUPP: ICMProgressUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeStdPixUPP(userUPP: StdPixUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDPixUPP(userUPP: QDPixUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMAlignmentUPP(userUPP: ICMAlignmentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMCursorShieldedUPP(userUPP: ICMCursorShieldedUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMMemoryDisposedUPP(userUPP: ICMMemoryDisposedUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeICMConvertDataFormatUPP(userUPP: ICMConvertDataFormatUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeICMDataUPP(VAR dataP: Ptr; bytesNeeded: LONGINT; refcon: LONGINT; userRoutine: ICMDataUPP): OSErr; { old name was CallICMDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeICMFlushUPP(data: Ptr; bytesAdded: LONGINT; refcon: LONGINT; userRoutine: ICMFlushUPP): OSErr; { old name was CallICMFlushProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeICMCompletionUPP(result: OSErr; flags: INTEGER; refcon: LONGINT; userRoutine: ICMCompletionUPP); { old name was CallICMCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeICMProgressUPP(message: INTEGER; completeness: Fixed; refcon: LONGINT; userRoutine: ICMProgressUPP): OSErr; { old name was CallICMProgressProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeStdPixUPP(VAR src: PixMap; VAR srcRect: Rect; VAR matrix: MatrixRecord; mode: INTEGER; mask: RgnHandle; VAR matte: PixMap; VAR matteRect: Rect; flags: INTEGER; userRoutine: StdPixUPP); { old name was CallStdPixProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDPixUPP(VAR src: PixMap; VAR srcRect: Rect; VAR matrix: MatrixRecord; mode: INTEGER; mask: RgnHandle; VAR matte: PixMap; VAR matteRect: Rect; flags: INTEGER; userRoutine: QDPixUPP); { old name was CallQDPixProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeICMAlignmentUPP(VAR rp: Rect; refcon: LONGINT; userRoutine: ICMAlignmentUPP); { old name was CallICMAlignmentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeICMCursorShieldedUPP({CONST}VAR r: Rect; refcon: UNIV Ptr; flags: LONGINT; userRoutine: ICMCursorShieldedUPP); { old name was CallICMCursorShieldedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeICMMemoryDisposedUPP(memoryBlock: Ptr; refcon: UNIV Ptr; userRoutine: ICMMemoryDisposedUPP); { old name was CallICMMemoryDisposedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeICMConvertDataFormatUPP(refCon: UNIV Ptr; flags: LONGINT; desiredFormat: Handle; sourceDataFormat: Handle; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT; userRoutine: ICMConvertDataFormatUPP): OSErr; { old name was CallICMConvertDataFormatProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION CodecManagerVersion(VAR version: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AAA3;
	{$ENDC}
FUNCTION GetCodecNameList(VAR list: CodecNameSpecListPtr; showAll: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AAA3;
	{$ENDC}
FUNCTION DisposeCodecNameList(list: CodecNameSpecListPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AAA3;
	{$ENDC}
FUNCTION GetCodecInfo(VAR info: CodecInfo; cType: CodecType; codec: CodecComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AAA3;
	{$ENDC}
FUNCTION GetMaxCompressionSize(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; quality: CodecQ; cType: CodecType; codec: CompressorComponent; VAR size: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceMaxCompressionSize(seqID: ImageSequence; src: PixMapHandle; VAR size: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0074, $AAA3;
	{$ENDC}
FUNCTION GetCompressionTime(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; cType: CodecType; codec: CompressorComponent; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR compressTime: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AAA3;
	{$ENDC}
FUNCTION CompressImage(src: PixMapHandle; {CONST}VAR srcRect: Rect; quality: CodecQ; cType: CodecType; desc: ImageDescriptionHandle; data: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AAA3;
	{$ENDC}
FUNCTION FCompressImage(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; quality: CodecQ; cType: CodecType; codec: CompressorComponent; ctable: CTabHandle; flags: CodecFlags; bufferSize: LONGINT; flushProc: ICMFlushProcRecordPtr; progressProc: ICMProgressProcRecordPtr; desc: ImageDescriptionHandle; data: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AAA3;
	{$ENDC}
FUNCTION DecompressImage(data: Ptr; desc: ImageDescriptionHandle; dst: PixMapHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; mask: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AAA3;
	{$ENDC}
FUNCTION FDecompressImage(data: Ptr; desc: ImageDescriptionHandle; dst: PixMapHandle; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; matte: PixMapHandle; {CONST}VAR matteRect: Rect; accuracy: CodecQ; codec: DecompressorComponent; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AAA3;
	{$ENDC}
FUNCTION CompressSequenceBegin(VAR seqID: ImageSequence; src: PixMapHandle; prev: PixMapHandle; {CONST}VAR srcRect: Rect; {CONST}VAR prevRect: Rect; colorDepth: INTEGER; cType: CodecType; codec: CompressorComponent; spatialQuality: CodecQ; temporalQuality: CodecQ; keyFrameRate: LONGINT; ctable: CTabHandle; flags: CodecFlags; desc: ImageDescriptionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AAA3;
	{$ENDC}
FUNCTION CompressSequenceFrame(seqID: ImageSequence; src: PixMapHandle; {CONST}VAR srcRect: Rect; flags: CodecFlags; data: Ptr; VAR dataSize: LONGINT; VAR similarity: UInt8; asyncCompletionProc: ICMCompletionProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceBegin(VAR seqID: ImageSequence; desc: ImageDescriptionHandle; port: CGrafPtr; gdh: GDHandle; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; flags: CodecFlags; accuracy: CodecQ; codec: DecompressorComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceBeginS(VAR seqID: ImageSequence; desc: ImageDescriptionHandle; data: Ptr; dataSize: LONGINT; port: CGrafPtr; gdh: GDHandle; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; flags: CodecFlags; accuracy: CodecQ; codec: DecompressorComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0030, $005D, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceFrame(seqID: ImageSequence; data: Ptr; inFlags: CodecFlags; VAR outFlags: CodecFlags; asyncCompletionProc: ICMCompletionProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceFrameS(seqID: ImageSequence; data: Ptr; dataSize: LONGINT; inFlags: CodecFlags; VAR outFlags: CodecFlags; asyncCompletionProc: ICMCompletionProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0016, $0047, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceFrameWhen(seqID: ImageSequence; data: Ptr; dataSize: LONGINT; inFlags: CodecFlags; VAR outFlags: CodecFlags; asyncCompletionProc: ICMCompletionProcRecordPtr; {CONST}VAR frameTime: ICMFrameTimeRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001A, $005E, $AAA3;
	{$ENDC}
FUNCTION CDSequenceFlush(seqID: ImageSequence): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $005F, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceMatrix(seqID: ImageSequence; matrix: MatrixRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AAA3;
	{$ENDC}
FUNCTION GetDSequenceMatrix(seqID: ImageSequence; matrix: MatrixRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0091, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceMatte(seqID: ImageSequence; matte: PixMapHandle; {CONST}VAR matteRect: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceMask(seqID: ImageSequence; mask: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceTransferMode(seqID: ImageSequence; mode: INTEGER; {CONST}VAR opColor: RGBColor): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceDataProc(seqID: ImageSequence; dataProc: ICMDataProcRecordPtr; bufferSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceAccuracy(seqID: ImageSequence; accuracy: CodecQ): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7034, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceSrcRect(seqID: ImageSequence; {CONST}VAR srcRect: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceFlags(seqID: ImageSequence; flags: LONGINT; flagsMask: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0057, $AAA3;
	{$ENDC}

CONST
	codecDSequenceSingleField	= $00000040;


FUNCTION GetDSequenceImageBuffer(seqID: ImageSequence; VAR gworld: GWorldPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AAA3;
	{$ENDC}
FUNCTION GetDSequenceScreenBuffer(seqID: ImageSequence; VAR gworld: GWorldPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceQuality(seqID: ImageSequence; spatialQuality: CodecQ; temporalQuality: CodecQ): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $AAA3;
	{$ENDC}
FUNCTION SetCSequencePrev(seqID: ImageSequence; prev: PixMapHandle; {CONST}VAR prevRect: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceFlushProc(seqID: ImageSequence; flushProc: ICMFlushProcRecordPtr; bufferSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7033, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceKeyFrameRate(seqID: ImageSequence; keyFrameRate: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceKeyFrameRate(seqID: ImageSequence; VAR keyFrameRate: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $004B, $AAA3;
	{$ENDC}
FUNCTION GetCSequencePrevBuffer(seqID: ImageSequence; VAR gworld: GWorldPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $AAA3;
	{$ENDC}
FUNCTION CDSequenceBusy(seqID: ImageSequence): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $AAA3;
	{$ENDC}
FUNCTION CDSequenceEnd(seqID: ImageSequence): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $AAA3;
	{$ENDC}
FUNCTION CDSequenceEquivalentImageDescription(seqID: ImageSequence; newDesc: ImageDescriptionHandle; VAR equivalent: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0065, $AAA3;
	{$ENDC}
FUNCTION GetCompressedImageSize(desc: ImageDescriptionHandle; data: Ptr; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; VAR dataSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $AAA3;
	{$ENDC}
FUNCTION GetSimilarity(src: PixMapHandle; {CONST}VAR srcRect: Rect; desc: ImageDescriptionHandle; data: Ptr; VAR similarity: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $AAA3;
	{$ENDC}

CONST
	kImageDescriptionSampleFormat = 'idfm';						{  image description extension describing sample format }
	kImageDescriptionClassicAtomFormat = 'atom';				{  sample contains classic atom structure (ie, GX codec and Curve codec) }
	kImageDescriptionQTAtomFormat = 'qtat';						{  sample contains QT atom structure }
	kImageDescriptionEffectDataFormat = 'fxat';					{  sample describes an effect (as QTAtoms) }
	kImageDescriptionPrivateDataFormat = 'priv';				{  sample is in a private codec specific format }
	kImageDescriptionAlternateCodec = 'subs';					{  image description extension containing the OSType of a substitute codec should the main codec not be available }
	kImageDescriptionColorSpace	= 'cspc';						{  image description extension containing an OSType naming the native pixel format of an image (only used for pixel formats not supported by classic Color QuickDraw) }

FUNCTION GetImageDescriptionCTable(desc: ImageDescriptionHandle; VAR ctable: CTabHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $AAA3;
	{$ENDC}
FUNCTION SetImageDescriptionCTable(desc: ImageDescriptionHandle; ctable: CTabHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $AAA3;
	{$ENDC}
FUNCTION GetImageDescriptionExtension(desc: ImageDescriptionHandle; VAR extension: Handle; idType: LONGINT; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $AAA3;
	{$ENDC}
FUNCTION AddImageDescriptionExtension(desc: ImageDescriptionHandle; extension: Handle; idType: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $AAA3;
	{$ENDC}
FUNCTION RemoveImageDescriptionExtension(desc: ImageDescriptionHandle; idType: LONGINT; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $003A, $AAA3;
	{$ENDC}
FUNCTION CountImageDescriptionExtensionType(desc: ImageDescriptionHandle; idType: LONGINT; VAR count: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $003B, $AAA3;
	{$ENDC}
FUNCTION GetNextImageDescriptionExtensionType(desc: ImageDescriptionHandle; VAR idType: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003C, $AAA3;
	{$ENDC}
FUNCTION FindCodec(cType: CodecType; specCodec: CodecComponent; VAR compressor: CompressorComponent; VAR decompressor: DecompressorComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $AAA3;
	{$ENDC}
FUNCTION CompressPicture(srcPicture: PicHandle; dstPicture: PicHandle; quality: CodecQ; cType: CodecType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $AAA3;
	{$ENDC}
FUNCTION FCompressPicture(srcPicture: PicHandle; dstPicture: PicHandle; colorDepth: INTEGER; ctable: CTabHandle; quality: CodecQ; doDither: INTEGER; compressAgain: INTEGER; progressProc: ICMProgressProcRecordPtr; cType: CodecType; codec: CompressorComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $AAA3;
	{$ENDC}
FUNCTION CompressPictureFile(srcRefNum: INTEGER; dstRefNum: INTEGER; quality: CodecQ; cType: CodecType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $AAA3;
	{$ENDC}
FUNCTION FCompressPictureFile(srcRefNum: INTEGER; dstRefNum: INTEGER; colorDepth: INTEGER; ctable: CTabHandle; quality: CodecQ; doDither: INTEGER; compressAgain: INTEGER; progressProc: ICMProgressProcRecordPtr; cType: CodecType; codec: CompressorComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $AAA3;
	{$ENDC}
FUNCTION GetPictureFileHeader(refNum: INTEGER; VAR frame: Rect; VAR header: OpenCPicParams): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7028, $AAA3;
	{$ENDC}
FUNCTION DrawPictureFile(refNum: INTEGER; {CONST}VAR frame: Rect; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $AAA3;
	{$ENDC}
FUNCTION DrawTrimmedPicture(srcPicture: PicHandle; {CONST}VAR frame: Rect; trimMask: RgnHandle; doDither: INTEGER; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702E, $AAA3;
	{$ENDC}
FUNCTION DrawTrimmedPictureFile(srcRefnum: INTEGER; {CONST}VAR frame: Rect; trimMask: RgnHandle; doDither: INTEGER; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702F, $AAA3;
	{$ENDC}
FUNCTION MakeThumbnailFromPicture(picture: PicHandle; colorDepth: INTEGER; thumbnail: PicHandle; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702A, $AAA3;
	{$ENDC}
FUNCTION MakeThumbnailFromPictureFile(refNum: INTEGER; colorDepth: INTEGER; thumbnail: PicHandle; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $AAA3;
	{$ENDC}
FUNCTION MakeThumbnailFromPixMap(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; thumbnail: PicHandle; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702C, $AAA3;
	{$ENDC}
FUNCTION TrimImage(desc: ImageDescriptionHandle; inData: Ptr; inBufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; outData: Ptr; outBufferSize: LONGINT; flushProc: ICMFlushProcRecordPtr; VAR trimRect: Rect; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702D, $AAA3;
	{$ENDC}
FUNCTION ConvertImage(srcDD: ImageDescriptionHandle; srcData: Ptr; colorDepth: INTEGER; ctable: CTabHandle; accuracy: CodecQ; quality: CodecQ; cType: CodecType; codec: CodecComponent; dstDD: ImageDescriptionHandle; dstData: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7030, $AAA3;
	{$ENDC}
FUNCTION GetCompressedPixMapInfo(pix: PixMapPtr; VAR desc: ImageDescriptionHandle; VAR data: Ptr; VAR bufferSize: LONGINT; VAR dataProc: ICMDataProcRecord; VAR progressProc: ICMProgressProcRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7037, $AAA3;
	{$ENDC}
FUNCTION SetCompressedPixMapInfo(pix: PixMapPtr; desc: ImageDescriptionHandle; data: Ptr; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7038, $AAA3;
	{$ENDC}
PROCEDURE StdPix(src: PixMapPtr; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; matte: PixMapPtr; {CONST}VAR matteRect: Rect; flags: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AAA3;
	{$ENDC}
FUNCTION TransformRgn(matrix: MatrixRecordPtr; rgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7039, $AAA3;
	{$ENDC}

{**********
    preview stuff
**********}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SFGetFilePreview(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7041, $AAA3;
	{$ENDC}
PROCEDURE SFPGetFilePreview(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7042, $AAA3;
	{$ENDC}
PROCEDURE StandardGetFilePreview(fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7043, $AAA3;
	{$ENDC}
PROCEDURE CustomGetFilePreview(fileFilter: FileFilterYDUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activateProc: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7044, $AAA3;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION MakeFilePreview(resRefNum: INTEGER; progress: ICMProgressProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7045, $AAA3;
	{$ENDC}
FUNCTION AddFilePreview(resRefNum: INTEGER; previewType: OSType; previewData: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7046, $AAA3;
	{$ENDC}

CONST
	sfpItemPreviewAreaUser		= 11;
	sfpItemPreviewStaticText	= 12;
	sfpItemPreviewDividerUser	= 13;
	sfpItemCreatePreviewButton	= 14;
	sfpItemShowPreviewButton	= 15;


TYPE
	PreviewResourceRecordPtr = ^PreviewResourceRecord;
	PreviewResourceRecord = RECORD
		modDate:				UInt32;
		version:				INTEGER;
		resType:				OSType;
		resID:					INTEGER;
	END;

	PreviewResourcePtr					= ^PreviewResourceRecord;
	PreviewResource						= ^PreviewResourcePtr;
PROCEDURE AlignScreenRect(VAR rp: Rect; alignmentProc: ICMAlignmentProcRecordPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $004C, $AAA3;
	{$ENDC}
PROCEDURE AlignWindow(wp: WindowRef; front: BOOLEAN; {CONST}VAR alignmentRect: Rect; alignmentProc: ICMAlignmentProcRecordPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000E, $004D, $AAA3;
	{$ENDC}
PROCEDURE DragAlignedWindow(wp: WindowRef; startPt: Point; VAR boundsRect: Rect; VAR alignmentRect: Rect; alignmentProc: ICMAlignmentProcRecordPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $004E, $AAA3;
	{$ENDC}
FUNCTION DragAlignedGrayRgn(theRgn: RgnHandle; startPt: Point; VAR boundsRect: Rect; VAR slopRect: Rect; axis: INTEGER; actionProc: UniversalProcPtr; VAR alignmentRect: Rect; alignmentProc: ICMAlignmentProcRecordPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001E, $004F, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceDataRateParams(seqID: ImageSequence; params: DataRateParamsPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0050, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceFrameNumber(seqID: ImageSequence; frameNumber: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0051, $AAA3;
	{$ENDC}
FUNCTION SetCSequencePreferredPacketSize(seqID: ImageSequence; preferredPacketSizeInBytes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0078, $AAA3;
	{$ENDC}
FUNCTION NewImageGWorld(VAR gworld: GWorldPtr; idh: ImageDescriptionHandle; flags: GWorldFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0052, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceDataRateParams(seqID: ImageSequence; params: DataRateParamsPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0053, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceFrameNumber(seqID: ImageSequence; VAR frameNumber: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0054, $AAA3;
	{$ENDC}
FUNCTION GetBestDeviceRect(VAR gdh: GDHandle; VAR rp: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0055, $AAA3;
	{$ENDC}
FUNCTION SetSequenceProgressProc(seqID: ImageSequence; VAR progressProc: ICMProgressProcRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0056, $AAA3;
	{$ENDC}
FUNCTION GDHasScale(gdh: GDHandle; depth: INTEGER; VAR scale: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000A, $005A, $AAA3;
	{$ENDC}
FUNCTION GDGetScale(gdh: GDHandle; VAR scale: Fixed; VAR flags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $005B, $AAA3;
	{$ENDC}
FUNCTION GDSetScale(gdh: GDHandle; scale: Fixed; flags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000A, $005C, $AAA3;
	{$ENDC}
FUNCTION ICMShieldSequenceCursor(seqID: ImageSequence): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0062, $AAA3;
	{$ENDC}
PROCEDURE ICMDecompressComplete(seqID: ImageSequence; err: OSErr; flag: INTEGER; completionRtn: ICMCompletionProcRecordPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0063, $AAA3;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION ICMDecompressCompleteS(seqID: ImageSequence; err: OSErr; flag: INTEGER; completionRtn: ICMCompletionProcRecordPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0082, $AAA3;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION ICMSequenceLockBits(seqID: ImageSequence; dst: PixMapPtr; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $007C, $AAA3;
	{$ENDC}
FUNCTION ICMSequenceUnlockBits(seqID: ImageSequence; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $007D, $AAA3;
	{$ENDC}

CONST
	kICMPixelFormatIsPlanarMask	= $0F;
	kICMPixelFormatIsIndexed	= $00000010;
	kICMPixelFormatIsSupportedByQD = $00000020;


TYPE
	ICMPixelFormatInfoPtr = ^ICMPixelFormatInfo;
	ICMPixelFormatInfo = RECORD
		size:					LONGINT;
		formatFlags:			UInt32;
		bitsPerPixel:			ARRAY [0..13] OF INTEGER;
																		{  new field is new for QuickTime 4.1 }
		reservedSetToZero:		LONGINT;
	END;

FUNCTION ICMGetPixelFormatInfo(PixelFormat: OSType; theInfo: ICMPixelFormatInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0083, $AAA3;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION ICMSetPixelFormatInfo(PixelFormat: OSType; theInfo: ICMPixelFormatInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $008A, $AAA3;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kICMGetChainUltimateParent	= 0;
	kICMGetChainParent			= 1;
	kICMGetChainChild			= 2;
	kICMGetChainUltimateChild	= 3;

FUNCTION ICMSequenceGetChainMember(seqID: ImageSequence; VAR retSeqID: ImageSequence; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $007E, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceTimeCode(seqID: ImageSequence; timeCodeFormat: UNIV Ptr; timeCodeTime: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0064, $AAA3;
	{$ENDC}
FUNCTION CDSequenceNewMemory(seqID: ImageSequence; VAR data: Ptr; dataSize: Size; dataUse: LONGINT; memoryGoneProc: ICMMemoryDisposedUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $0066, $AAA3;
	{$ENDC}
FUNCTION CDSequenceDisposeMemory(seqID: ImageSequence; data: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0067, $AAA3;
	{$ENDC}
FUNCTION CDSequenceNewDataSource(seqID: ImageSequence; VAR sourceID: ImageSequenceDataSource; sourceType: OSType; sourceInputNumber: LONGINT; dataDescription: Handle; transferProc: UNIV Ptr; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001C, $0068, $AAA3;
	{$ENDC}
FUNCTION CDSequenceDisposeDataSource(sourceID: ImageSequenceDataSource): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0069, $AAA3;
	{$ENDC}
FUNCTION CDSequenceSetSourceData(sourceID: ImageSequenceDataSource; data: UNIV Ptr; dataSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $006A, $AAA3;
	{$ENDC}
FUNCTION CDSequenceChangedSourceData(sourceID: ImageSequenceDataSource): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $006B, $AAA3;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CDSequenceSetSourceDataQueue(sourceID: ImageSequenceDataSource; dataQueue: QHdrPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $007B, $AAA3;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION CDSequenceGetDataSource(seqID: ImageSequence; VAR sourceID: ImageSequenceDataSource; sourceType: OSType; sourceInputNumber: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $007F, $AAA3;
	{$ENDC}
FUNCTION PtInDSequenceData(seqID: ImageSequence; data: UNIV Ptr; dataSize: Size; where: Point; VAR hit: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $006C, $AAA3;
	{$ENDC}
FUNCTION HitTestDSequenceData(seqID: ImageSequence; data: UNIV Ptr; dataSize: Size; where: Point; VAR hit: LONGINT; hitFlags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0006, $0087, $AAA3;
	{$ENDC}
FUNCTION GetGraphicsImporterForFile({CONST}VAR theFile: FSSpec; VAR gi: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $006E, $AAA3;
	{$ENDC}
FUNCTION GetGraphicsImporterForDataRef(dataRef: Handle; dataRefType: OSType; VAR gi: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0077, $AAA3;
	{$ENDC}

CONST
	kDontUseValidateToFindGraphicsImporter = $00000001;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetGraphicsImporterForFileWithFlags({CONST}VAR theFile: FSSpec; VAR gi: ComponentInstance; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0084, $AAA3;
	{$ENDC}
FUNCTION GetGraphicsImporterForDataRefWithFlags(dataRef: Handle; dataRefType: OSType; VAR gi: ComponentInstance; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0085, $AAA3;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION QTGetFileNameExtension(fileName: StrFileName; fileType: OSType; VAR extension: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0061, $AAA3;
	{$ENDC}

FUNCTION ImageTranscodeSequenceBegin(VAR its: ImageTranscodeSequence; srcDesc: ImageDescriptionHandle; destType: OSType; VAR dstDesc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $006F, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeSequenceEnd(its: ImageTranscodeSequence): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0070, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeFrame(its: ImageTranscodeSequence; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0071, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeDisposeFrameData(its: ImageTranscodeSequence; dstData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0072, $AAA3;
	{$ENDC}
FUNCTION CDSequenceInvalidate(seqID: ImageSequence; invalRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0073, $AAA3;
	{$ENDC}
FUNCTION CDSequenceSetTimeBase(seqID: ImageSequence; base: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0079, $AAA3;
	{$ENDC}
FUNCTION ImageFieldSequenceBegin(VAR ifs: ImageFieldSequence; desc1: ImageDescriptionHandle; desc2: ImageDescriptionHandle; descOut: ImageDescriptionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $006D, $AAA3;
	{$ENDC}
FUNCTION ImageFieldSequenceExtractCombine(ifs: ImageFieldSequence; fieldFlags: LONGINT; data1: UNIV Ptr; dataSize1: LONGINT; data2: UNIV Ptr; dataSize2: LONGINT; outputData: UNIV Ptr; VAR outDataSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0020, $0075, $AAA3;
	{$ENDC}
FUNCTION ImageFieldSequenceEnd(ifs: ImageFieldSequence): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0076, $AAA3;
	{$ENDC}

CONST
	kICMTempThenAppMemory		= $00001000;
	kICMAppThenTempMemory		= $00002000;

FUNCTION QTNewGWorld(VAR offscreenGWorld: GWorldPtr; PixelFormat: OSType; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $0080, $AAA3;
	{$ENDC}
FUNCTION QTNewGWorldFromPtr(VAR gw: GWorldPtr; pixelFormat: OSType; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags; baseAddr: UNIV Ptr; rowBytes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0020, $008B, $AAA3;
	{$ENDC}
FUNCTION QTUpdateGWorld(VAR offscreenGWorld: GWorldPtr; PixelFormat: OSType; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): GWorldFlags;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $0081, $AAA3;
	{$ENDC}
FUNCTION MakeImageDescriptionForPixMap(pixmap: PixMapHandle; VAR idh: ImageDescriptionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $007A, $AAA3;
	{$ENDC}
FUNCTION MakeImageDescriptionForEffect(effectType: OSType; VAR idh: ImageDescriptionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0092, $AAA3;
	{$ENDC}
FUNCTION QTGetPixelSize(PixelFormat: OSType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0086, $AAA3;
	{$ENDC}
FUNCTION QTGetPixMapPtrRowBytes(pm: PixMapPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $008D, $AAA3;
	{$ENDC}
FUNCTION QTGetPixMapHandleRowBytes(pm: PixMapHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $008E, $AAA3;
	{$ENDC}
FUNCTION QTSetPixMapPtrRowBytes(pm: PixMapPtr; rowBytes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0090, $AAA3;
	{$ENDC}
FUNCTION QTSetPixMapHandleRowBytes(pm: PixMapHandle; rowBytes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $008F, $AAA3;
	{$ENDC}
FUNCTION QuadToQuadMatrix({CONST}VAR source: Fixed; {CONST}VAR dest: Fixed; VAR map: MatrixRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0095, $AAA3;
	{$ENDC}



CONST
	identityMatrixType			= $00;							{  result if matrix is identity  }
	translateMatrixType			= $01;							{  result if matrix translates  }
	scaleMatrixType				= $02;							{  result if matrix scales  }
	scaleTranslateMatrixType	= $03;							{  result if matrix scales and translates  }
	linearMatrixType			= $04;							{  result if matrix is general 2 x 2  }
	linearTranslateMatrixType	= $05;							{  result if matrix is general 2 x 2 and translates  }
	perspectiveMatrixType		= $06;							{  result if matrix is general 3 x 3  }


TYPE
	MatrixFlags							= UInt16;
FUNCTION GetMatrixType({CONST}VAR m: MatrixRecord): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $ABC2;
	{$ENDC}
PROCEDURE CopyMatrix({CONST}VAR m1: MatrixRecord; VAR m2: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $ABC2;
	{$ENDC}
FUNCTION EqualMatrix({CONST}VAR m1: MatrixRecord; {CONST}VAR m2: MatrixRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $ABC2;
	{$ENDC}
PROCEDURE SetIdentityMatrix(VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $ABC2;
	{$ENDC}
PROCEDURE TranslateMatrix(VAR m: MatrixRecord; deltaH: Fixed; deltaV: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $ABC2;
	{$ENDC}
PROCEDURE RotateMatrix(VAR m: MatrixRecord; degrees: Fixed; aboutX: Fixed; aboutY: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $ABC2;
	{$ENDC}
PROCEDURE ScaleMatrix(VAR m: MatrixRecord; scaleX: Fixed; scaleY: Fixed; aboutX: Fixed; aboutY: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $ABC2;
	{$ENDC}
PROCEDURE SkewMatrix(VAR m: MatrixRecord; skewX: Fixed; skewY: Fixed; aboutX: Fixed; aboutY: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $ABC2;
	{$ENDC}
FUNCTION TransformFixedPoints({CONST}VAR m: MatrixRecord; VAR fpt: FixedPoint; count: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $ABC2;
	{$ENDC}
FUNCTION TransformPoints({CONST}VAR mp: MatrixRecord; VAR pt1: Point; count: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $ABC2;
	{$ENDC}
FUNCTION TransformFixedRect({CONST}VAR m: MatrixRecord; VAR fr: FixedRect; VAR fpp: FixedPoint): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $ABC2;
	{$ENDC}
FUNCTION TransformRect({CONST}VAR m: MatrixRecord; VAR r: Rect; VAR fpp: FixedPoint): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $ABC2;
	{$ENDC}
FUNCTION InverseMatrix({CONST}VAR m: MatrixRecord; VAR im: MatrixRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $ABC2;
	{$ENDC}
PROCEDURE ConcatMatrix({CONST}VAR a: MatrixRecord; VAR b: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $ABC2;
	{$ENDC}
PROCEDURE RectMatrix(VAR matrix: MatrixRecord; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $ABC2;
	{$ENDC}
PROCEDURE MapMatrix(VAR matrix: MatrixRecord; {CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $ABC2;
	{$ENDC}






PROCEDURE CompAdd(VAR src: wide; VAR dst: wide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABC2;
	{$ENDC}
PROCEDURE CompSub(VAR src: wide; VAR dst: wide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABC2;
	{$ENDC}
PROCEDURE CompNeg(VAR dst: wide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $ABC2;
	{$ENDC}
PROCEDURE CompShift(VAR src: wide; shift: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $ABC2;
	{$ENDC}
PROCEDURE CompMul(src1: LONGINT; src2: LONGINT; VAR dst: wide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $ABC2;
	{$ENDC}
FUNCTION CompDiv(VAR numerator: wide; denominator: LONGINT; VAR remainder: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $ABC2;
	{$ENDC}
PROCEDURE CompFixMul(VAR compSrc: wide; fixSrc: Fixed; VAR compDst: wide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $ABC2;
	{$ENDC}
PROCEDURE CompMulDiv(VAR co: wide; mul: LONGINT; divisor: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $ABC2;
	{$ENDC}
PROCEDURE CompMulDivTrunc(VAR co: wide; mul: LONGINT; divisor: LONGINT; VAR remainder: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $ABC2;
	{$ENDC}
FUNCTION CompCompare({CONST}VAR a: wide; {CONST}VAR minusb: wide): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $ABC2;
	{$ENDC}
FUNCTION CompSquareRoot({CONST}VAR src: wide): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $ABC2;
	{$ENDC}
FUNCTION FixMulDiv(src: Fixed; mul: Fixed; divisor: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $ABC2;
	{$ENDC}
FUNCTION UnsignedFixMulDiv(src: Fixed; mul: Fixed; divisor: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $ABC2;
	{$ENDC}
FUNCTION FracSinCos(degree: Fixed; VAR cosOut: Fract): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $ABC2;
	{$ENDC}
FUNCTION FixExp2(src: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $ABC2;
	{$ENDC}
FUNCTION FixLog2(src: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $ABC2;
	{$ENDC}
FUNCTION FixPow(base: Fixed; exp: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $ABC2;
	{$ENDC}




TYPE
	GraphicsImportComponent				= ComponentInstance;

CONST
	GraphicsImporterComponentType = 'grip';

	graphicsImporterUsesImageDecompressor = $00800000;

	quickTimeImageFileImageDescriptionAtom = 'idsc';
	quickTimeImageFileImageDataAtom = 'idat';
	quickTimeImageFileMetaDataAtom = 'meta';
	quickTimeImageFileColorSyncProfileAtom = 'iicc';

	graphicsImporterDrawsAllPixels = 0;
	graphicsImporterDoesntDrawAllPixels = 1;
	graphicsImporterDontKnowIfDrawAllPixels = 2;

{ Flags for GraphicsImportSetFlags }
	kGraphicsImporterDontDoGammaCorrection = 1;

	kGraphicsExportGroup		= 'expo';
	kGraphicsExportFileType		= 'ftyp';
	kGraphicsExportMIMEType		= 'mime';
	kGraphicsExportExtension	= 'ext ';
	kGraphicsExportDescription	= 'desc';


{* These are GraphicsImport procedures *}
FUNCTION GraphicsImportSetDataReference(ci: GraphicsImportComponent; dataRef: Handle; dataReType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataReference(ci: GraphicsImportComponent; VAR dataRef: Handle; VAR dataReType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataFile(ci: GraphicsImportComponent; {CONST}VAR theFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataFile(ci: GraphicsImportComponent; VAR theFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataHandle(ci: GraphicsImportComponent; h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataHandle(ci: GraphicsImportComponent; VAR h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetImageDescription(ci: GraphicsImportComponent; VAR desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataOffsetAndSize(ci: GraphicsImportComponent; VAR offset: UInt32; VAR size: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportReadData(ci: GraphicsImportComponent; dataPtr: UNIV Ptr; dataOffset: UInt32; dataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetClip(ci: GraphicsImportComponent; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetClip(ci: GraphicsImportComponent; VAR clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetSourceRect(ci: GraphicsImportComponent; {CONST}VAR sourceRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetSourceRect(ci: GraphicsImportComponent; VAR sourceRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetNaturalBounds(ci: GraphicsImportComponent; VAR naturalBounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportDraw(ci: GraphicsImportComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetGWorld(ci: GraphicsImportComponent; port: CGrafPtr; gd: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetGWorld(ci: GraphicsImportComponent; VAR port: CGrafPtr; VAR gd: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetMatrix(ci: GraphicsImportComponent; {CONST}VAR matrix: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetMatrix(ci: GraphicsImportComponent; VAR matrix: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetBoundsRect(ci: GraphicsImportComponent; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetBoundsRect(ci: GraphicsImportComponent; VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSaveAsPicture(ci: GraphicsImportComponent; {CONST}VAR fss: FSSpec; scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetGraphicsMode(ci: GraphicsImportComponent; graphicsMode: LONGINT; {CONST}VAR opColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetGraphicsMode(ci: GraphicsImportComponent; VAR graphicsMode: LONGINT; VAR opColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetQuality(ci: GraphicsImportComponent; quality: CodecQ): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetQuality(ci: GraphicsImportComponent; VAR quality: CodecQ): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSaveAsQuickTimeImageFile(ci: GraphicsImportComponent; {CONST}VAR fss: FSSpec; scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataReferenceOffsetAndLimit(ci: GraphicsImportComponent; offset: UInt32; limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataReferenceOffsetAndLimit(ci: GraphicsImportComponent; VAR offset: UInt32; VAR limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetAliasedDataReference(ci: GraphicsImportComponent; VAR dataRef: Handle; VAR dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportValidate(ci: GraphicsImportComponent; VAR valid: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetMetaData(ci: GraphicsImportComponent; userData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetMIMETypeList(ci: GraphicsImportComponent; qtAtomContainerPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportDoesDrawAllPixels(ci: GraphicsImportComponent; VAR drawsAllPixels: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetAsPicture(ci: GraphicsImportComponent; VAR picture: PicHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportExportImageFile(ci: GraphicsImportComponent; fileType: OSType; fileCreator: OSType; {CONST}VAR fss: FSSpec; scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetExportImageTypeList(ci: GraphicsImportComponent; qtAtomContainerPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportDoExportImageFileDialog(ci: GraphicsImportComponent; {CONST}VAR inDefaultSpec: FSSpec; prompt: StringPtr; filterProc: ModalFilterYDUPP; VAR outExportedType: OSType; VAR outExportedSpec: FSSpec; VAR outScriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetExportSettingsAsAtomContainer(ci: GraphicsImportComponent; qtAtomContainerPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetExportSettingsFromAtomContainer(ci: GraphicsImportComponent; qtAtomContainer: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetProgressProc(ci: GraphicsImportComponent; progressProc: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetProgressProc(ci: GraphicsImportComponent; progressProc: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetImageCount(ci: GraphicsImportComponent; VAR imageCount: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetImageIndex(ci: GraphicsImportComponent; imageIndex: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetImageIndex(ci: GraphicsImportComponent; VAR imageIndex: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataOffsetAndSize64(ci: GraphicsImportComponent; VAR offset: wide; VAR size: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportReadData64(ci: GraphicsImportComponent; dataPtr: UNIV Ptr; {CONST}VAR dataOffset: wide; dataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataReferenceOffsetAndLimit64(ci: GraphicsImportComponent; {CONST}VAR offset: wide; {CONST}VAR limit: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0030, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataReferenceOffsetAndLimit64(ci: GraphicsImportComponent; VAR offset: wide; VAR limit: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0031, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDefaultMatrix(ci: GraphicsImportComponent; VAR defaultMatrix: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0032, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDefaultClip(ci: GraphicsImportComponent; VAR defaultRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0033, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDefaultGraphicsMode(ci: GraphicsImportComponent; VAR defaultGraphicsMode: LONGINT; VAR defaultOpColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0034, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDefaultSourceRect(ci: GraphicsImportComponent; VAR defaultSourceRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0035, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetColorSyncProfile(ci: GraphicsImportComponent; VAR profile: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0036, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDestRect(ci: GraphicsImportComponent; {CONST}VAR destRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0037, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDestRect(ci: GraphicsImportComponent; VAR destRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0038, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetFlags(ci: GraphicsImportComponent; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0039, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetFlags(ci: GraphicsImportComponent; VAR flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003A, $7000, $A82A;
	{$ENDC}



TYPE
	GraphicsExportComponent				= ComponentInstance;

CONST
	GraphicsExporterComponentType = 'grex';
	kBaseGraphicsExporterSubType = 'base';

	graphicsExporterIsBaseExporter = $00000001;
	graphicsExporterCanTranscode = $00000002;
	graphicsExporterUsesImageCompressor = $00000004;


TYPE
	QTResolutionSettingsPtr = ^QTResolutionSettings;
	QTResolutionSettings = RECORD
		horizontalResolution:	Fixed;
		verticalResolution:		Fixed;
	END;

	QTTargetDataSizePtr = ^QTTargetDataSize;
	QTTargetDataSize = RECORD
		targetDataSize:			UInt32;
	END;


CONST
	kQTResolutionSettings		= 'reso';
	kQTTargetDataSize			= 'dasz';
	kQTDontRecompress			= 'dntr';
	kQTInterlaceStyle			= 'ilac';
	kQTColorSyncProfile			= 'iccp';

	kQTTIFFCompressionMethod	= 'tifc';						{  UInt32 }
	kQTTIFFCompression_None		= 1;
	kQTTIFFCompression_PackBits	= 32773;
	kQTTIFFLittleEndian			= 'tife';						{  UInt8 (boolean) }

	kQTPNGFilterPreference		= 'pngf';						{  UInt32 }
	kQTPNGFilterBestForColorType = 'bflt';
	kQTPNGFilterNone			= 0;
	kQTPNGFilterSub				= 1;
	kQTPNGFilterUp				= 2;
	kQTPNGFilterAverage			= 3;
	kQTPNGFilterPaeth			= 4;
	kQTPNGFilterAdaptivePerRow	= 'aflt';
	kQTPNGInterlaceStyle		= 'ilac';						{  UInt32 }
	kQTPNGInterlaceNone			= 0;
	kQTPNGInterlaceAdam7		= 1;


{* These are GraphicsExport procedures *}
{ To use: set the input and output (and other settings as desired) and call GEDoExport. }
FUNCTION GraphicsExportDoExport(ci: GraphicsExportComponent; VAR actualSizeWritten: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
{ Used for internal communication between the base and format-specific graphics exporter: }
FUNCTION GraphicsExportCanTranscode(ci: GraphicsExportComponent; VAR canTranscode: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportDoTranscode(ci: GraphicsExportComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportCanUseCompressor(ci: GraphicsExportComponent; VAR canUseCompressor: BOOLEAN; codecSettingsAtomContainerPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportDoUseCompressor(ci: GraphicsExportComponent; codecSettingsAtomContainer: UNIV Ptr; VAR outDesc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportDoStandaloneExport(ci: GraphicsExportComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}
{ Queries applications can make of a format-specific graphics exporter: }
FUNCTION GraphicsExportGetDefaultFileTypeAndCreator(ci: GraphicsExportComponent; VAR fileType: OSType; VAR fileCreator: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetDefaultFileNameExtension(ci: GraphicsExportComponent; VAR fileNameExtension: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetMIMETypeList(ci: GraphicsExportComponent; qtAtomContainerPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}
{ GraphicsExportIsTranscodePossibleFromCurrentInput is removed; call GraphicsExportCanTranscode instead }
{ Graphics exporter settings: }
FUNCTION GraphicsExportRequestSettings(ci: GraphicsExportComponent; filterProc: ModalFilterYDUPP; yourDataProc: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetSettingsFromAtomContainer(ci: GraphicsExportComponent; qtAtomContainer: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetSettingsAsAtomContainer(ci: GraphicsExportComponent; qtAtomContainerPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetSettingsAsText(ci: GraphicsExportComponent; VAR theText: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}
{ Graphics exporters may implement some or none of the following: }
FUNCTION GraphicsExportSetDontRecompress(ci: GraphicsExportComponent; dontRecompress: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetDontRecompress(ci: GraphicsExportComponent; VAR dontRecompress: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInterlaceStyle(ci: GraphicsExportComponent; interlaceStyle: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInterlaceStyle(ci: GraphicsExportComponent; VAR interlaceStyle: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetMetaData(ci: GraphicsExportComponent; userData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetMetaData(ci: GraphicsExportComponent; userData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetTargetDataSize(ci: GraphicsExportComponent; targetDataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetTargetDataSize(ci: GraphicsExportComponent; VAR targetDataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetCompressionMethod(ci: GraphicsExportComponent; compressionMethod: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetCompressionMethod(ci: GraphicsExportComponent; VAR compressionMethod: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetCompressionQuality(ci: GraphicsExportComponent; spatialQuality: CodecQ): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetCompressionQuality(ci: GraphicsExportComponent; VAR spatialQuality: CodecQ): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetResolution(ci: GraphicsExportComponent; horizontalResolution: Fixed; verticalResolution: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetResolution(ci: GraphicsExportComponent; VAR horizontalResolution: Fixed; VAR verticalResolution: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetDepth(ci: GraphicsExportComponent; depth: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetDepth(ci: GraphicsExportComponent; VAR depth: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetColorSyncProfile(ci: GraphicsExportComponent; colorSyncProfile: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetColorSyncProfile(ci: GraphicsExportComponent; VAR colorSyncProfile: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0022, $7000, $A82A;
	{$ENDC}
{ Always implemented by the base graphics exporter: }
FUNCTION GraphicsExportSetProgressProc(ci: GraphicsExportComponent; progressProc: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetProgressProc(ci: GraphicsExportComponent; progressProc: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0024, $7000, $A82A;
	{$ENDC}
{ Sources for the input image: }
FUNCTION GraphicsExportSetInputDataReference(ci: GraphicsExportComponent; dataRef: Handle; dataRefType: OSType; desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputDataReference(ci: GraphicsExportComponent; VAR dataRef: Handle; VAR dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputFile(ci: GraphicsExportComponent; {CONST}VAR theFile: FSSpec; desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0027, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputFile(ci: GraphicsExportComponent; VAR theFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputHandle(ci: GraphicsExportComponent; h: Handle; desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputHandle(ci: GraphicsExportComponent; VAR h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputPtr(ci: GraphicsExportComponent; p: Ptr; size: UInt32; desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputPtr(ci: GraphicsExportComponent; VAR p: Ptr; VAR size: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputGraphicsImporter(ci: GraphicsExportComponent; grip: GraphicsImportComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputGraphicsImporter(ci: GraphicsExportComponent; VAR grip: GraphicsImportComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputPicture(ci: GraphicsExportComponent; picture: PicHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputPicture(ci: GraphicsExportComponent; VAR picture: PicHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0030, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputGWorld(ci: GraphicsExportComponent; gworld: GWorldPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0031, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputGWorld(ci: GraphicsExportComponent; VAR gworld: GWorldPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0032, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetInputPixmap(ci: GraphicsExportComponent; pixmap: PixMapHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0033, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputPixmap(ci: GraphicsExportComponent; VAR pixmap: PixMapHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0034, $7000, $A82A;
	{$ENDC}
{ Only applicable when the input is a data reference, file, handle or ptr: }
FUNCTION GraphicsExportSetInputOffsetAndLimit(ci: GraphicsExportComponent; offset: UInt32; limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0035, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputOffsetAndLimit(ci: GraphicsExportComponent; VAR offset: UInt32; VAR limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0036, $7000, $A82A;
	{$ENDC}
{ Used by format-specific graphics exporters when transcoding: }
FUNCTION GraphicsExportMayExporterReadInputData(ci: GraphicsExportComponent; VAR mayReadInputData: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0037, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputDataSize(ci: GraphicsExportComponent; VAR size: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0038, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportReadInputData(ci: GraphicsExportComponent; dataPtr: UNIV Ptr; dataOffset: UInt32; dataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0039, $7000, $A82A;
	{$ENDC}
{ Used by format-specific graphics exporters, especially when doing standalone export: }
FUNCTION GraphicsExportGetInputImageDescription(ci: GraphicsExportComponent; VAR desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputImageDimensions(ci: GraphicsExportComponent; VAR dimensions: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetInputImageDepth(ci: GraphicsExportComponent; VAR inputDepth: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportDrawInputImage(ci: GraphicsExportComponent; gw: CGrafPtr; gd: GDHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $003D, $7000, $A82A;
	{$ENDC}
{ Destinations for the output image: }
FUNCTION GraphicsExportSetOutputDataReference(ci: GraphicsExportComponent; dataRef: Handle; dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetOutputDataReference(ci: GraphicsExportComponent; VAR dataRef: Handle; VAR dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetOutputFile(ci: GraphicsExportComponent; {CONST}VAR theFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0040, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetOutputFile(ci: GraphicsExportComponent; VAR theFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0041, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetOutputHandle(ci: GraphicsExportComponent; h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0042, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetOutputHandle(ci: GraphicsExportComponent; VAR h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0043, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetOutputOffsetAndMaxSize(ci: GraphicsExportComponent; offset: UInt32; maxSize: UInt32; truncateFile: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0044, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetOutputOffsetAndMaxSize(ci: GraphicsExportComponent; VAR offset: UInt32; VAR maxSize: UInt32; VAR truncateFile: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0045, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetOutputFileTypeAndCreator(ci: GraphicsExportComponent; fileType: OSType; fileCreator: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0046, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetOutputFileTypeAndCreator(ci: GraphicsExportComponent; VAR fileType: OSType; VAR fileCreator: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0047, $7000, $A82A;
	{$ENDC}
{ Used by format-specific graphics exporters: }
FUNCTION GraphicsExportWriteOutputData(ci: GraphicsExportComponent; dataPtr: UNIV Ptr; dataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0048, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportSetOutputMark(ci: GraphicsExportComponent; mark: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0049, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportGetOutputMark(ci: GraphicsExportComponent; VAR mark: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsExportReadOutputData(ci: GraphicsExportComponent; dataPtr: UNIV Ptr; dataOffset: UInt32; dataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $004B, $7000, $A82A;
	{$ENDC}


TYPE
	ImageTranscoderComponent			= ComponentInstance;

CONST
	ImageTranscodererComponentType = 'imtc';


{* These are ImageTranscoder procedures *}
FUNCTION ImageTranscoderBeginSequence(itc: ImageTranscoderComponent; srcDesc: ImageDescriptionHandle; VAR dstDesc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION ImageTranscoderConvert(itc: ImageTranscoderComponent; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION ImageTranscoderDisposeData(itc: ImageTranscoderComponent; dstData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ImageTranscoderEndSequence(itc: ImageTranscoderComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}
{ UPP call backs }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ImageCompressionIncludes}

{$ENDC} {__IMAGECOMPRESSION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
