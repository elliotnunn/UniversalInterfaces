/*
 	File:		ImageCompression.h
 
 	Contains:	QuickTime Image Compression Interfaces.
 
 	Version:	Technology:	QuickTime 2.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __IMAGECOMPRESSION__
#define __IMAGECOMPRESSION__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif
#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __STANDARDFILE__
#include <StandardFile.h>
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

struct MatrixRecord {
	Fixed 							matrix[3][3];
};
typedef struct MatrixRecord MatrixRecord;

typedef MatrixRecord *					MatrixRecordPtr;

struct FixedPoint {
	Fixed 							x;
	Fixed 							y;
};
typedef struct FixedPoint FixedPoint;


struct FixedRect {
	Fixed 							left;
	Fixed 							top;
	Fixed 							right;
	Fixed 							bottom;
};
typedef struct FixedRect FixedRect;


enum {
	kRawCodecType				= FOUR_CHAR_CODE('raw '),
	kCinepakCodecType			= FOUR_CHAR_CODE('cvid'),
	kGraphicsCodecType			= FOUR_CHAR_CODE('smc '),
	kAnimationCodecType			= FOUR_CHAR_CODE('rle '),
	kVideoCodecType				= FOUR_CHAR_CODE('rpza'),
	kComponentVideoCodecType	= FOUR_CHAR_CODE('yuv2'),
	kJPEGCodecType				= FOUR_CHAR_CODE('jpeg'),
	kMotionJPEGACodecType		= FOUR_CHAR_CODE('mjpa'),
	kMotionJPEGBCodecType		= FOUR_CHAR_CODE('mjpb'),
	kSGICodecType				= FOUR_CHAR_CODE('.SGI'),
	kPlanarRGBCodecType			= FOUR_CHAR_CODE('8BPS'),
	kMacPaintCodecType			= FOUR_CHAR_CODE('PNTG'),
	kGIFCodecType				= FOUR_CHAR_CODE('gif '),
	kPhotoCDCodecType			= FOUR_CHAR_CODE('kpcd'),
	kQuickDrawGXCodecType		= FOUR_CHAR_CODE('qdgx')
};




/* These are the bits that are set in the Component flags, and also in the codecInfo struct. */

enum {
	codecInfoDoes1				= (1L << 0),
	codecInfoDoes2				= (1L << 1),
	codecInfoDoes4				= (1L << 2),
	codecInfoDoes8				= (1L << 3),
	codecInfoDoes16				= (1L << 4),
	codecInfoDoes32				= (1L << 5),
	codecInfoDoesDither			= (1L << 6),
	codecInfoDoesStretch		= (1L << 7),
	codecInfoDoesShrink			= (1L << 8),
	codecInfoDoesMask			= (1L << 9),
	codecInfoDoesTemporal		= (1L << 10),
	codecInfoDoesDouble			= (1L << 11),
	codecInfoDoesQuad			= (1L << 12),
	codecInfoDoesHalf			= (1L << 13),
	codecInfoDoesQuarter		= (1L << 14),
	codecInfoDoesRotate			= (1L << 15),
	codecInfoDoesHorizFlip		= (1L << 16),
	codecInfoDoesVertFlip		= (1L << 17),
	codecInfoDoesSkew			= (1L << 18),
	codecInfoDoesBlend			= (1L << 19),
	codecInfoDoesWarp			= (1L << 20),
	codecInfoDoesRecompress		= (1L << 21),
	codecInfoDoesSpool			= (1L << 22),
	codecInfoDoesRateConstrain	= (1L << 23)
};



enum {
	codecInfoDepth1				= (1L << 0),
	codecInfoDepth2				= (1L << 1),
	codecInfoDepth4				= (1L << 2),
	codecInfoDepth8				= (1L << 3),
	codecInfoDepth16			= (1L << 4),
	codecInfoDepth32			= (1L << 5),
	codecInfoDepth24			= (1L << 6),
	codecInfoDepth33			= (1L << 7),
	codecInfoDepth34			= (1L << 8),
	codecInfoDepth36			= (1L << 9),
	codecInfoDepth40			= (1L << 10),
	codecInfoStoresClut			= (1L << 11),
	codecInfoDoesLossless		= (1L << 12),
	codecInfoSequenceSensitive	= (1L << 13)
};


enum {
	codecFlagUseImageBuffer		= (1L << 0),
	codecFlagUseScreenBuffer	= (1L << 1),
	codecFlagUpdatePrevious		= (1L << 2),
	codecFlagNoScreenUpdate		= (1L << 3),
	codecFlagWasCompressed		= (1L << 4),
	codecFlagDontOffscreen		= (1L << 5),
	codecFlagUpdatePreviousComp	= (1L << 6),
	codecFlagForceKeyFrame		= (1L << 7),
	codecFlagOnlyScreenUpdate	= (1L << 8),
	codecFlagLiveGrab			= (1L << 9),
	codecFlagDontUseNewImageBuffer = (1L << 10),
	codecFlagInterlaceUpdate	= (1L << 11),
	codecFlagCatchUpDiff		= (1L << 12),
	codecFlagImageBufferNotSourceImage = (1L << 13),
	codecFlagUsedNewImageBuffer	= (1L << 14),
	codecFlagUsedImageBuffer	= (1L << 15)
};




enum {
																/* The minimum data size for spooling in or out data */
	codecMinimumDataSize		= 32768L
};



enum {
	compressorComponentType		= FOUR_CHAR_CODE('imco'),		/* the type for "Components" which compress images */
	decompressorComponentType	= FOUR_CHAR_CODE('imdc')		/* the type for "Components" which decompress images */
};

typedef Component 						CompressorComponent;
typedef Component 						DecompressorComponent;
typedef Component 						CodecComponent;
#define	anyCodec				((CodecComponent)0)
#define	bestSpeedCodec			((CodecComponent)-1)
#define	bestFidelityCodec		((CodecComponent)-2)
#define	bestCompressionCodec	((CodecComponent)-3)
typedef long 							CodecType;
typedef unsigned short 					CodecFlags;
typedef unsigned long 					CodecQ;

enum {
	codecLosslessQuality		= 0x00000400,
	codecMaxQuality				= 0x000003FF,
	codecMinQuality				= 0x00000000,
	codecLowQuality				= 0x00000100,
	codecNormalQuality			= 0x00000200,
	codecHighQuality			= 0x00000300
};


enum {
	codecCompletionSource		= (1 << 0),						/* asynchronous codec is done with source data */
	codecCompletionDest			= (1 << 1),						/* asynchronous codec is done with destination data */
	codecCompletionDontUnshield	= (1 << 2)						/* on dest complete don't unshield cursor */
};


enum {
	codecProgressOpen			= 0,
	codecProgressUpdatePercent	= 1,
	codecProgressClose			= 2
};

typedef CALLBACK_API( OSErr , ICMDataProcPtr )(Ptr *dataP, long bytesNeeded, long refcon);
typedef CALLBACK_API( OSErr , ICMFlushProcPtr )(Ptr data, long bytesAdded, long refcon);
typedef CALLBACK_API( void , ICMCompletionProcPtr )(OSErr result, short flags, long refcon);
typedef CALLBACK_API( OSErr , ICMProgressProcPtr )(short message, Fixed completeness, long refcon);
typedef CALLBACK_API( void , StdPixProcPtr )(PixMap *src, Rect *srcRect, MatrixRecord *matrix, short mode, RgnHandle mask, PixMap *matte, Rect *matteRect, short flags);
typedef CALLBACK_API( void , ICMAlignmentProcPtr )(Rect *rp, long refcon);
typedef CALLBACK_API( void , ICMCursorShieldedProcPtr )(const Rect *r, void *refcon, long flags);
typedef CALLBACK_API( void , ICMMemoryDisposedProcPtr )(Ptr memoryBlock, void *refcon);
typedef void *							ICMCursorNotify;
typedef CALLBACK_API( OSErr , ICMConvertDataFormatProcPtr )(void *refCon, long flags, Handle desiredFormat, void *srcData, long srcDataSize, void **dstData, long *dstDataSize);
typedef STACK_UPP_TYPE(ICMDataProcPtr) 							ICMDataUPP;
typedef STACK_UPP_TYPE(ICMFlushProcPtr) 						ICMFlushUPP;
typedef STACK_UPP_TYPE(ICMCompletionProcPtr) 					ICMCompletionUPP;
typedef STACK_UPP_TYPE(ICMProgressProcPtr) 						ICMProgressUPP;
typedef STACK_UPP_TYPE(StdPixProcPtr) 							StdPixUPP;
typedef STACK_UPP_TYPE(ICMAlignmentProcPtr) 					ICMAlignmentUPP;
typedef STACK_UPP_TYPE(ICMCursorShieldedProcPtr) 				ICMCursorShieldedUPP;
typedef STACK_UPP_TYPE(ICMMemoryDisposedProcPtr) 				ICMMemoryDisposedUPP;
typedef STACK_UPP_TYPE(ICMConvertDataFormatProcPtr) 			ICMConvertDataFormatUPP;
typedef long 							ImageSequence;
typedef long 							ImageSequenceDataSource;
typedef long 							ImageTranscodeSequence;
typedef long 							ImageFieldSequence;
struct ICMProgressProcRecord {
	ICMProgressUPP 					progressProc;
	long 							progressRefCon;
};
typedef struct ICMProgressProcRecord ICMProgressProcRecord;

typedef ICMProgressProcRecord *			ICMProgressProcRecordPtr;
struct ICMCompletionProcRecord {
	ICMCompletionUPP 				completionProc;
	long 							completionRefCon;
};
typedef struct ICMCompletionProcRecord ICMCompletionProcRecord;

typedef ICMCompletionProcRecord *		ICMCompletionProcRecordPtr;
struct ICMDataProcRecord {
	ICMDataUPP 						dataProc;
	long 							dataRefCon;
};
typedef struct ICMDataProcRecord ICMDataProcRecord;

typedef ICMDataProcRecord *				ICMDataProcRecordPtr;
struct ICMFlushProcRecord {
	ICMFlushUPP 					flushProc;
	long 							flushRefCon;
};
typedef struct ICMFlushProcRecord ICMFlushProcRecord;

typedef ICMFlushProcRecord *			ICMFlushProcRecordPtr;
struct ICMAlignmentProcRecord {
	ICMAlignmentUPP 				alignmentProc;
	long 							alignmentRefCon;
};
typedef struct ICMAlignmentProcRecord ICMAlignmentProcRecord;

typedef ICMAlignmentProcRecord *		ICMAlignmentProcRecordPtr;
struct DataRateParams {
	long 							dataRate;
	long 							dataOverrun;
	long 							frameDuration;
	long 							keyFrameRate;
	CodecQ 							minSpatialQuality;
	CodecQ 							minTemporalQuality;
};
typedef struct DataRateParams DataRateParams;

typedef DataRateParams *				DataRateParamsPtr;
struct ImageDescription {
	long 							idSize;						/* total size of ImageDescription including extra data ( CLUTs and other per sequence data ) */
	CodecType 						cType;						/* what kind of codec compressed this data */
	long 							resvd1;						/* reserved for Apple use */
	short 							resvd2;						/* reserved for Apple use */
	short 							dataRefIndex;				/* set to zero  */
	short 							version;					/* which version is this data */
	short 							revisionLevel;				/* what version of that codec did this */
	long 							vendor;						/* whose  codec compressed this data */
	CodecQ 							temporalQuality;			/* what was the temporal quality factor  */
	CodecQ 							spatialQuality;				/* what was the spatial quality factor */
	short 							width;						/* how many pixels wide is this data */
	short 							height;						/* how many pixels high is this data */
	Fixed 							hRes;						/* horizontal resolution */
	Fixed 							vRes;						/* vertical resolution */
	long 							dataSize;					/* if known, the size of data for this image descriptor */
	short 							frameCount;					/* number of frames this description applies to */
	Str31 							name;						/* name of codec ( in case not installed )  */
	short 							depth;						/* what depth is this data (1-32) or ( 33-40 grayscale ) */
	short 							clutID;						/* clut id or if 0 clut follows  or -1 if no clut */
};
typedef struct ImageDescription ImageDescription;

typedef ImageDescription *				ImageDescriptionPtr;
typedef ImageDescriptionPtr *			ImageDescriptionHandle;
struct CodecInfo {
	Str31 							typeName;					/* name of the codec type i.e.: 'Apple Image Compression' */
	short 							version;					/* version of the codec data that this codec knows about */
	short 							revisionLevel;				/* revision level of this codec i.e: 0x00010001 (1.0.1) */
	long 							vendor;						/* Maker of this codec i.e: 'appl' */
	long 							decompressFlags;			/* codecInfo flags for decompression capabilities */
	long 							compressFlags;				/* codecInfo flags for compression capabilities */
	long 							formatFlags;				/* codecInfo flags for compression format details */
	UInt8 							compressionAccuracy;		/* measure (1-255) of accuracy of this codec for compress (0 if unknown) */
	UInt8 							decompressionAccuracy;		/* measure (1-255) of accuracy of this codec for decompress (0 if unknown) */
	unsigned short 					compressionSpeed;			/* ( millisecs for compressing 320x240 on base mac II) (0 if unknown)  */
	unsigned short 					decompressionSpeed;			/* ( millisecs for decompressing 320x240 on mac II)(0 if unknown)  */
	UInt8 							compressionLevel;			/* measure (1-255) of compression level of this codec (0 if unknown)  */
	UInt8 							resvd;						/* pad */
	short 							minimumHeight;				/* minimum height of image (block size) */
	short 							minimumWidth;				/* minimum width of image (block size) */
	short 							decompressPipelineLatency;	/* in milliseconds ( for asynchronous codecs ) */
	short 							compressPipelineLatency;	/* in milliseconds ( for asynchronous codecs ) */
	long 							privateData;
};
typedef struct CodecInfo CodecInfo;

struct CodecNameSpec {
	CodecComponent 					codec;
	CodecType 						cType;
	Str31 							typeName;
	Handle 							name;
};
typedef struct CodecNameSpec CodecNameSpec;

struct CodecNameSpecList {
	short 							count;
	CodecNameSpec 					list[1];
};
typedef struct CodecNameSpecList CodecNameSpecList;

typedef CodecNameSpecList *				CodecNameSpecListPtr;

enum {
	defaultDither				= 0,
	forceDither					= 1,
	suppressDither				= 2,
	useColorMatching			= 4
};


enum {
	callStdBits					= 1,
	callOldBits					= 2,
	noDefaultOpcodes			= 4
};


enum {
	graphicsModeStraightAlpha	= 256,
	graphicsModePreWhiteAlpha	= 257,
	graphicsModePreBlackAlpha	= 258,
	graphicsModeCompostion		= 259,
	graphicsModeStraightAlphaBlend = 260
};


enum {
	evenField1ToEvenFieldOut	= 1 << 0,
	evenField1ToOddFieldOut		= 1 << 1,
	oddField1ToEvenFieldOut		= 1 << 2,
	oddField1ToOddFieldOut		= 1 << 3,
	evenField2ToEvenFieldOut	= 1 << 4,
	evenField2ToOddFieldOut		= 1 << 5,
	oddField2ToEvenFieldOut		= 1 << 6,
	oddField2ToOddFieldOut		= 1 << 7
};

struct ICMFrameTimeRecord {
	wide 							value;						/* frame time*/
	long 							scale;						/* timescale of value/duration fields*/
	void *							base;						/* timebase*/

	long 							duration;					/* duration frame is to be displayed (0 if unknown)*/
	Fixed 							rate;						/* rate of timebase relative to wall-time*/

	long 							recordSize;					/* total number of bytes in ICMFrameTimeRecord*/

	long 							frameNumber;				/* number of frame, zero if not known*/
};
typedef struct ICMFrameTimeRecord ICMFrameTimeRecord;

typedef ICMFrameTimeRecord *			ICMFrameTimePtr;
enum { uppICMDataProcInfo = 0x00000FE0 }; 						/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes) */
enum { uppICMFlushProcInfo = 0x00000FE0 }; 						/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes) */
enum { uppICMCompletionProcInfo = 0x00000E80 }; 				/* pascal no_return_value Func(2_bytes, 2_bytes, 4_bytes) */
enum { uppICMProgressProcInfo = 0x00000FA0 }; 					/* pascal 2_bytes Func(2_bytes, 4_bytes, 4_bytes) */
enum { uppStdPixProcInfo = 0x002FEFC0 }; 						/* pascal no_return_value Func(4_bytes, 4_bytes, 4_bytes, 2_bytes, 4_bytes, 4_bytes, 4_bytes, 2_bytes) */
enum { uppICMAlignmentProcInfo = 0x000003C0 }; 					/* pascal no_return_value Func(4_bytes, 4_bytes) */
enum { uppICMCursorShieldedProcInfo = 0x00000FC0 }; 			/* pascal no_return_value Func(4_bytes, 4_bytes, 4_bytes) */
enum { uppICMMemoryDisposedProcInfo = 0x000003C0 }; 			/* pascal no_return_value Func(4_bytes, 4_bytes) */
enum { uppICMConvertDataFormatProcInfo = 0x000FFFE0 }; 			/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes) */
#define NewICMDataProc(userRoutine) 							(ICMDataUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMDataProcInfo, GetCurrentArchitecture())
#define NewICMFlushProc(userRoutine) 							(ICMFlushUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMFlushProcInfo, GetCurrentArchitecture())
#define NewICMCompletionProc(userRoutine) 						(ICMCompletionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMCompletionProcInfo, GetCurrentArchitecture())
#define NewICMProgressProc(userRoutine) 						(ICMProgressUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMProgressProcInfo, GetCurrentArchitecture())
#define NewStdPixProc(userRoutine) 								(StdPixUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppStdPixProcInfo, GetCurrentArchitecture())
#define NewICMAlignmentProc(userRoutine) 						(ICMAlignmentUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMAlignmentProcInfo, GetCurrentArchitecture())
#define NewICMCursorShieldedProc(userRoutine) 					(ICMCursorShieldedUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMCursorShieldedProcInfo, GetCurrentArchitecture())
#define NewICMMemoryDisposedProc(userRoutine) 					(ICMMemoryDisposedUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMMemoryDisposedProcInfo, GetCurrentArchitecture())
#define NewICMConvertDataFormatProc(userRoutine) 				(ICMConvertDataFormatUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMConvertDataFormatProcInfo, GetCurrentArchitecture())
#define CallICMDataProc(userRoutine, dataP, bytesNeeded, refcon)  CALL_THREE_PARAMETER_UPP((userRoutine), uppICMDataProcInfo, (dataP), (bytesNeeded), (refcon))
#define CallICMFlushProc(userRoutine, data, bytesAdded, refcon)  CALL_THREE_PARAMETER_UPP((userRoutine), uppICMFlushProcInfo, (data), (bytesAdded), (refcon))
#define CallICMCompletionProc(userRoutine, result, flags, refcon)  CALL_THREE_PARAMETER_UPP((userRoutine), uppICMCompletionProcInfo, (result), (flags), (refcon))
#define CallICMProgressProc(userRoutine, message, completeness, refcon)  CALL_THREE_PARAMETER_UPP((userRoutine), uppICMProgressProcInfo, (message), (completeness), (refcon))
#define CallStdPixProc(userRoutine, src, srcRect, matrix, mode, mask, matte, matteRect, flags)  CALL_EIGHT_PARAMETER_UPP((userRoutine), uppStdPixProcInfo, (src), (srcRect), (matrix), (mode), (mask), (matte), (matteRect), (flags))
#define CallICMAlignmentProc(userRoutine, rp, refcon) 			CALL_TWO_PARAMETER_UPP((userRoutine), uppICMAlignmentProcInfo, (rp), (refcon))
#define CallICMCursorShieldedProc(userRoutine, r, refcon, flags)  CALL_THREE_PARAMETER_UPP((userRoutine), uppICMCursorShieldedProcInfo, (r), (refcon), (flags))
#define CallICMMemoryDisposedProc(userRoutine, memoryBlock, refcon)  CALL_TWO_PARAMETER_UPP((userRoutine), uppICMMemoryDisposedProcInfo, (memoryBlock), (refcon))
#define CallICMConvertDataFormatProc(userRoutine, refCon, flags, desiredFormat, srcData, srcDataSize, dstData, dstDataSize)  CALL_SEVEN_PARAMETER_UPP((userRoutine), uppICMConvertDataFormatProcInfo, (refCon), (flags), (desiredFormat), (srcData), (srcDataSize), (dstData), (dstDataSize))

EXTERN_API( OSErr )
CodecManagerVersion				(long *					version)							TWOWORDINLINE(0x7000, 0xAAA3);

EXTERN_API( OSErr )
GetCodecNameList				(CodecNameSpecListPtr *	list,
								 short 					showAll)							TWOWORDINLINE(0x7001, 0xAAA3);

EXTERN_API( OSErr )
DisposeCodecNameList			(CodecNameSpecListPtr 	list)								TWOWORDINLINE(0x700F, 0xAAA3);

EXTERN_API( OSErr )
GetCodecInfo					(CodecInfo *			info,
								 CodecType 				cType,
								 CodecComponent 		codec)								TWOWORDINLINE(0x7003, 0xAAA3);

EXTERN_API( OSErr )
GetMaxCompressionSize			(PixMapHandle 			src,
								 const Rect *			srcRect,
								 short 					colorDepth,
								 CodecQ 				quality,
								 CodecType 				cType,
								 CompressorComponent 	codec,
								 long *					size)								TWOWORDINLINE(0x7004, 0xAAA3);

EXTERN_API( OSErr )
GetCSequenceMaxCompressionSize	(ImageSequence 			seqID,
								 PixMapHandle 			src,
								 long *					size)								FOURWORDINLINE(0x203C, 0x000C, 0x0074, 0xAAA3);

EXTERN_API( OSErr )
GetCompressionTime				(PixMapHandle 			src,
								 const Rect *			srcRect,
								 short 					colorDepth,
								 CodecType 				cType,
								 CompressorComponent 	codec,
								 CodecQ *				spatialQuality,
								 CodecQ *				temporalQuality,
								 unsigned long *		compressTime)						TWOWORDINLINE(0x7005, 0xAAA3);

EXTERN_API( OSErr )
CompressImage					(PixMapHandle 			src,
								 const Rect *			srcRect,
								 CodecQ 				quality,
								 CodecType 				cType,
								 ImageDescriptionHandle  desc,
								 Ptr 					data)								TWOWORDINLINE(0x7006, 0xAAA3);

EXTERN_API( OSErr )
FCompressImage					(PixMapHandle 			src,
								 const Rect *			srcRect,
								 short 					colorDepth,
								 CodecQ 				quality,
								 CodecType 				cType,
								 CompressorComponent 	codec,
								 CTabHandle 			ctable,
								 CodecFlags 			flags,
								 long 					bufferSize,
								 ICMFlushProcRecordPtr 	flushProc,
								 ICMProgressProcRecordPtr  progressProc,
								 ImageDescriptionHandle  desc,
								 Ptr 					data)								TWOWORDINLINE(0x7007, 0xAAA3);

EXTERN_API( OSErr )
DecompressImage					(Ptr 					data,
								 ImageDescriptionHandle  desc,
								 PixMapHandle 			dst,
								 const Rect *			srcRect,
								 const Rect *			dstRect,
								 short 					mode,
								 RgnHandle 				mask)								TWOWORDINLINE(0x7008, 0xAAA3);

EXTERN_API( OSErr )
FDecompressImage				(Ptr 					data,
								 ImageDescriptionHandle  desc,
								 PixMapHandle 			dst,
								 const Rect *			srcRect,
								 MatrixRecordPtr 		matrix,
								 short 					mode,
								 RgnHandle 				mask,
								 PixMapHandle 			matte,
								 const Rect *			matteRect,
								 CodecQ 				accuracy,
								 DecompressorComponent 	codec,
								 long 					bufferSize,
								 ICMDataProcRecordPtr 	dataProc,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x7009, 0xAAA3);

EXTERN_API( OSErr )
CompressSequenceBegin			(ImageSequence *		seqID,
								 PixMapHandle 			src,
								 PixMapHandle 			prev,
								 const Rect *			srcRect,
								 const Rect *			prevRect,
								 short 					colorDepth,
								 CodecType 				cType,
								 CompressorComponent 	codec,
								 CodecQ 				spatialQuality,
								 CodecQ 				temporalQuality,
								 long 					keyFrameRate,
								 CTabHandle 			ctable,
								 CodecFlags 			flags,
								 ImageDescriptionHandle  desc)								TWOWORDINLINE(0x700A, 0xAAA3);

EXTERN_API( OSErr )
CompressSequenceFrame			(ImageSequence 			seqID,
								 PixMapHandle 			src,
								 const Rect *			srcRect,
								 CodecFlags 			flags,
								 Ptr 					data,
								 long *					dataSize,
								 UInt8 *				similarity,
								 ICMCompletionProcRecordPtr  asyncCompletionProc)			TWOWORDINLINE(0x700B, 0xAAA3);

EXTERN_API( OSErr )
DecompressSequenceBegin			(ImageSequence *		seqID,
								 ImageDescriptionHandle  desc,
								 CGrafPtr 				port,
								 GDHandle 				gdh,
								 const Rect *			srcRect,
								 MatrixRecordPtr 		matrix,
								 short 					mode,
								 RgnHandle 				mask,
								 CodecFlags 			flags,
								 CodecQ 				accuracy,
								 DecompressorComponent 	codec)								TWOWORDINLINE(0x700D, 0xAAA3);

EXTERN_API( OSErr )
DecompressSequenceBeginS		(ImageSequence *		seqID,
								 ImageDescriptionHandle  desc,
								 Ptr 					data,
								 long 					dataSize,
								 CGrafPtr 				port,
								 GDHandle 				gdh,
								 const Rect *			srcRect,
								 MatrixRecordPtr 		matrix,
								 short 					mode,
								 RgnHandle 				mask,
								 CodecFlags 			flags,
								 CodecQ 				accuracy,
								 DecompressorComponent 	codec)								FOURWORDINLINE(0x203C, 0x0030, 0x005D, 0xAAA3);

EXTERN_API( OSErr )
DecompressSequenceFrame			(ImageSequence 			seqID,
								 Ptr 					data,
								 CodecFlags 			inFlags,
								 CodecFlags *			outFlags,
								 ICMCompletionProcRecordPtr  asyncCompletionProc)			TWOWORDINLINE(0x700E, 0xAAA3);

EXTERN_API( OSErr )
DecompressSequenceFrameS		(ImageSequence 			seqID,
								 Ptr 					data,
								 long 					dataSize,
								 CodecFlags 			inFlags,
								 CodecFlags *			outFlags,
								 ICMCompletionProcRecordPtr  asyncCompletionProc)			FOURWORDINLINE(0x203C, 0x0016, 0x0047, 0xAAA3);

EXTERN_API( OSErr )
DecompressSequenceFrameWhen		(ImageSequence 			seqID,
								 Ptr 					data,
								 long 					dataSize,
								 CodecFlags 			inFlags,
								 CodecFlags *			outFlags,
								 ICMCompletionProcRecordPtr  asyncCompletionProc,
								 const ICMFrameTimeRecord * frameTime)						FOURWORDINLINE(0x203C, 0x001A, 0x005E, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceFlush					(ImageSequence 			seqID)								FOURWORDINLINE(0x203C, 0x0004, 0x005F, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceMatrix				(ImageSequence 			seqID,
								 MatrixRecordPtr 		matrix)								TWOWORDINLINE(0x7010, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceMatte				(ImageSequence 			seqID,
								 PixMapHandle 			matte,
								 const Rect *			matteRect)							TWOWORDINLINE(0x7011, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceMask				(ImageSequence 			seqID,
								 RgnHandle 				mask)								TWOWORDINLINE(0x7012, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceTransferMode		(ImageSequence 			seqID,
								 short 					mode,
								 const RGBColor *		opColor)							TWOWORDINLINE(0x7013, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceDataProc			(ImageSequence 			seqID,
								 ICMDataProcRecordPtr 	dataProc,
								 long 					bufferSize)							TWOWORDINLINE(0x7014, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceAccuracy			(ImageSequence 			seqID,
								 CodecQ 				accuracy)							TWOWORDINLINE(0x7034, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceSrcRect				(ImageSequence 			seqID,
								 const Rect *			srcRect)							TWOWORDINLINE(0x7035, 0xAAA3);


EXTERN_API( OSErr )
GetDSequenceImageBuffer			(ImageSequence 			seqID,
								 GWorldPtr *			gworld)								TWOWORDINLINE(0x7015, 0xAAA3);

EXTERN_API( OSErr )
GetDSequenceScreenBuffer		(ImageSequence 			seqID,
								 GWorldPtr *			gworld)								TWOWORDINLINE(0x7016, 0xAAA3);

EXTERN_API( OSErr )
SetCSequenceQuality				(ImageSequence 			seqID,
								 CodecQ 				spatialQuality,
								 CodecQ 				temporalQuality)					TWOWORDINLINE(0x7017, 0xAAA3);

EXTERN_API( OSErr )
SetCSequencePrev				(ImageSequence 			seqID,
								 PixMapHandle 			prev,
								 const Rect *			prevRect)							TWOWORDINLINE(0x7018, 0xAAA3);

EXTERN_API( OSErr )
SetCSequenceFlushProc			(ImageSequence 			seqID,
								 ICMFlushProcRecordPtr 	flushProc,
								 long 					bufferSize)							TWOWORDINLINE(0x7033, 0xAAA3);

EXTERN_API( OSErr )
SetCSequenceKeyFrameRate		(ImageSequence 			seqID,
								 long 					keyFrameRate)						TWOWORDINLINE(0x7036, 0xAAA3);

EXTERN_API( OSErr )
GetCSequenceKeyFrameRate		(ImageSequence 			seqID,
								 long *					keyFrameRate)						FOURWORDINLINE(0x203C, 0x0008, 0x004B, 0xAAA3);

EXTERN_API( OSErr )
GetCSequencePrevBuffer			(ImageSequence 			seqID,
								 GWorldPtr *			gworld)								TWOWORDINLINE(0x7019, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceBusy					(ImageSequence 			seqID)								TWOWORDINLINE(0x701A, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceEnd					(ImageSequence 			seqID)								TWOWORDINLINE(0x701B, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceEquivalentImageDescription (ImageSequence 	seqID,
								 ImageDescriptionHandle  newDesc,
								 Boolean *				equivalent)							FOURWORDINLINE(0x203C, 0x000C, 0x0065, 0xAAA3);

EXTERN_API( OSErr )
GetCompressedImageSize			(ImageDescriptionHandle  desc,
								 Ptr 					data,
								 long 					bufferSize,
								 ICMDataProcRecordPtr 	dataProc,
								 long *					dataSize)							TWOWORDINLINE(0x701C, 0xAAA3);

EXTERN_API( OSErr )
GetSimilarity					(PixMapHandle 			src,
								 const Rect *			srcRect,
								 ImageDescriptionHandle  desc,
								 Ptr 					data,
								 Fixed *				similarity)							TWOWORDINLINE(0x701D, 0xAAA3);

EXTERN_API( OSErr )
GetImageDescriptionCTable		(ImageDescriptionHandle  desc,
								 CTabHandle *			ctable)								TWOWORDINLINE(0x701E, 0xAAA3);

EXTERN_API( OSErr )
SetImageDescriptionCTable		(ImageDescriptionHandle  desc,
								 CTabHandle 			ctable)								TWOWORDINLINE(0x701F, 0xAAA3);

EXTERN_API( OSErr )
GetImageDescriptionExtension	(ImageDescriptionHandle  desc,
								 Handle *				extension,
								 long 					idType,
								 long 					index)								TWOWORDINLINE(0x7020, 0xAAA3);

EXTERN_API( OSErr )
AddImageDescriptionExtension	(ImageDescriptionHandle  desc,
								 Handle 				extension,
								 long 					idType)								TWOWORDINLINE(0x7021, 0xAAA3);


EXTERN_API( OSErr )
RemoveImageDescriptionExtension	(ImageDescriptionHandle  desc,
								 long 					idType,
								 long 					index)								FOURWORDINLINE(0x203C, 0x000C, 0x003A, 0xAAA3);

EXTERN_API( OSErr )
CountImageDescriptionExtensionType (ImageDescriptionHandle  desc,
								 long 					idType,
								 long *					count)								FOURWORDINLINE(0x203C, 0x000C, 0x003B, 0xAAA3);

EXTERN_API( OSErr )
GetNextImageDescriptionExtensionType (ImageDescriptionHandle  desc,
								 long *					idType)								FOURWORDINLINE(0x203C, 0x0008, 0x003C, 0xAAA3);

EXTERN_API( OSErr )
FindCodec						(CodecType 				cType,
								 CodecComponent 		specCodec,
								 CompressorComponent *	compressor,
								 DecompressorComponent * decompressor)						TWOWORDINLINE(0x7023, 0xAAA3);

EXTERN_API( OSErr )
CompressPicture					(PicHandle 				srcPicture,
								 PicHandle 				dstPicture,
								 CodecQ 				quality,
								 CodecType 				cType)								TWOWORDINLINE(0x7024, 0xAAA3);

EXTERN_API( OSErr )
FCompressPicture				(PicHandle 				srcPicture,
								 PicHandle 				dstPicture,
								 short 					colorDepth,
								 CTabHandle 			ctable,
								 CodecQ 				quality,
								 short 					doDither,
								 short 					compressAgain,
								 ICMProgressProcRecordPtr  progressProc,
								 CodecType 				cType,
								 CompressorComponent 	codec)								TWOWORDINLINE(0x7025, 0xAAA3);

EXTERN_API( OSErr )
CompressPictureFile				(short 					srcRefNum,
								 short 					dstRefNum,
								 CodecQ 				quality,
								 CodecType 				cType)								TWOWORDINLINE(0x7026, 0xAAA3);

EXTERN_API( OSErr )
FCompressPictureFile			(short 					srcRefNum,
								 short 					dstRefNum,
								 short 					colorDepth,
								 CTabHandle 			ctable,
								 CodecQ 				quality,
								 short 					doDither,
								 short 					compressAgain,
								 ICMProgressProcRecordPtr  progressProc,
								 CodecType 				cType,
								 CompressorComponent 	codec)								TWOWORDINLINE(0x7027, 0xAAA3);

EXTERN_API( OSErr )
GetPictureFileHeader			(short 					refNum,
								 Rect *					frame,
								 OpenCPicParams *		header)								TWOWORDINLINE(0x7028, 0xAAA3);

EXTERN_API( OSErr )
DrawPictureFile					(short 					refNum,
								 const Rect *			frame,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x7029, 0xAAA3);

EXTERN_API( OSErr )
DrawTrimmedPicture				(PicHandle 				srcPicture,
								 const Rect *			frame,
								 RgnHandle 				trimMask,
								 short 					doDither,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x702E, 0xAAA3);

EXTERN_API( OSErr )
DrawTrimmedPictureFile			(short 					srcRefnum,
								 const Rect *			frame,
								 RgnHandle 				trimMask,
								 short 					doDither,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x702F, 0xAAA3);

EXTERN_API( OSErr )
MakeThumbnailFromPicture		(PicHandle 				picture,
								 short 					colorDepth,
								 PicHandle 				thumbnail,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x702A, 0xAAA3);

EXTERN_API( OSErr )
MakeThumbnailFromPictureFile	(short 					refNum,
								 short 					colorDepth,
								 PicHandle 				thumbnail,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x702B, 0xAAA3);

EXTERN_API( OSErr )
MakeThumbnailFromPixMap			(PixMapHandle 			src,
								 const Rect *			srcRect,
								 short 					colorDepth,
								 PicHandle 				thumbnail,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x702C, 0xAAA3);

EXTERN_API( OSErr )
TrimImage						(ImageDescriptionHandle  desc,
								 Ptr 					inData,
								 long 					inBufferSize,
								 ICMDataProcRecordPtr 	dataProc,
								 Ptr 					outData,
								 long 					outBufferSize,
								 ICMFlushProcRecordPtr 	flushProc,
								 Rect *					trimRect,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x702D, 0xAAA3);

EXTERN_API( OSErr )
ConvertImage					(ImageDescriptionHandle  srcDD,
								 Ptr 					srcData,
								 short 					colorDepth,
								 CTabHandle 			ctable,
								 CodecQ 				accuracy,
								 CodecQ 				quality,
								 CodecType 				cType,
								 CodecComponent 		codec,
								 ImageDescriptionHandle  dstDD,
								 Ptr 					dstData)							TWOWORDINLINE(0x7030, 0xAAA3);

EXTERN_API( OSErr )
GetCompressedPixMapInfo			(PixMapPtr 				pix,
								 ImageDescriptionHandle * desc,
								 Ptr *					data,
								 long *					bufferSize,
								 ICMDataProcRecord *	dataProc,
								 ICMProgressProcRecord * progressProc)						TWOWORDINLINE(0x7037, 0xAAA3);

EXTERN_API( OSErr )
SetCompressedPixMapInfo			(PixMapPtr 				pix,
								 ImageDescriptionHandle  desc,
								 Ptr 					data,
								 long 					bufferSize,
								 ICMDataProcRecordPtr 	dataProc,
								 ICMProgressProcRecordPtr  progressProc)					TWOWORDINLINE(0x7038, 0xAAA3);

EXTERN_API( void )
StdPix							(PixMapPtr 				src,
								 const Rect *			srcRect,
								 MatrixRecordPtr 		matrix,
								 short 					mode,
								 RgnHandle 				mask,
								 PixMapPtr 				matte,
								 const Rect *			matteRect,
								 short 					flags)								TWOWORDINLINE(0x700C, 0xAAA3);

EXTERN_API( OSErr )
TransformRgn					(MatrixRecordPtr 		matrix,
								 RgnHandle 				rgn)								TWOWORDINLINE(0x7039, 0xAAA3);


/***********
	preview stuff
***********/
EXTERN_API( void )
SFGetFilePreview				(Point 					where,
								 ConstStr255Param 		prompt,
								 FileFilterUPP 			fileFilter,
								 short 					numTypes,
								 ConstSFTypeListPtr 	typeList,
								 DlgHookUPP 			dlgHook,
								 SFReply *				reply)								TWOWORDINLINE(0x7041, 0xAAA3);

EXTERN_API( void )
SFPGetFilePreview				(Point 					where,
								 ConstStr255Param 		prompt,
								 FileFilterUPP 			fileFilter,
								 short 					numTypes,
								 ConstSFTypeListPtr 	typeList,
								 DlgHookUPP 			dlgHook,
								 SFReply *				reply,
								 short 					dlgID,
								 ModalFilterUPP 		filterProc)							TWOWORDINLINE(0x7042, 0xAAA3);

EXTERN_API( void )
StandardGetFilePreview			(FileFilterUPP 			fileFilter,
								 short 					numTypes,
								 ConstSFTypeListPtr 	typeList,
								 StandardFileReply *	reply)								TWOWORDINLINE(0x7043, 0xAAA3);

EXTERN_API( void )
CustomGetFilePreview			(FileFilterYDUPP 		fileFilter,
								 short 					numTypes,
								 ConstSFTypeListPtr 	typeList,
								 StandardFileReply *	reply,
								 short 					dlgID,
								 Point 					where,
								 DlgHookYDUPP 			dlgHook,
								 ModalFilterYDUPP 		filterProc,
								 ActivationOrderListPtr  activeList,
								 ActivateYDUPP 			activateProc,
								 void *					yourDataPtr)						TWOWORDINLINE(0x7044, 0xAAA3);

EXTERN_API( OSErr )
MakeFilePreview					(short 					resRefNum,
								 ICMProgressProcRecordPtr  progress)						TWOWORDINLINE(0x7045, 0xAAA3);

EXTERN_API( OSErr )
AddFilePreview					(short 					resRefNum,
								 OSType 				previewType,
								 Handle 				previewData)						TWOWORDINLINE(0x7046, 0xAAA3);


enum {
	sfpItemPreviewAreaUser		= 11,
	sfpItemPreviewStaticText	= 12,
	sfpItemPreviewDividerUser	= 13,
	sfpItemCreatePreviewButton	= 14,
	sfpItemShowPreviewButton	= 15
};

struct PreviewResourceRecord {
	unsigned long 					modDate;
	short 							version;
	OSType 							resType;
	short 							resID;
};
typedef struct PreviewResourceRecord PreviewResourceRecord;

typedef PreviewResourceRecord *			PreviewResourcePtr;
typedef PreviewResourcePtr *			PreviewResource;
EXTERN_API( void )
AlignScreenRect					(Rect *					rp,
								 ICMAlignmentProcRecordPtr  alignmentProc)					FOURWORDINLINE(0x203C, 0x0008, 0x004C, 0xAAA3);

EXTERN_API( void )
AlignWindow						(WindowPtr 				wp,
								 Boolean 				front,
								 const Rect *			alignmentRect,
								 ICMAlignmentProcRecordPtr  alignmentProc)					FOURWORDINLINE(0x203C, 0x000E, 0x004D, 0xAAA3);

EXTERN_API( void )
DragAlignedWindow				(WindowPtr 				wp,
								 Point 					startPt,
								 Rect *					boundsRect,
								 Rect *					alignmentRect,
								 ICMAlignmentProcRecordPtr  alignmentProc)					FOURWORDINLINE(0x203C, 0x0014, 0x004E, 0xAAA3);

EXTERN_API( long )
DragAlignedGrayRgn				(RgnHandle 				theRgn,
								 Point 					startPt,
								 Rect *					boundsRect,
								 Rect *					slopRect,
								 short 					axis,
								 UniversalProcPtr 		actionProc,
								 Rect *					alignmentRect,
								 ICMAlignmentProcRecordPtr  alignmentProc)					FOURWORDINLINE(0x203C, 0x001E, 0x004F, 0xAAA3);

EXTERN_API( OSErr )
SetCSequenceDataRateParams		(ImageSequence 			seqID,
								 DataRateParamsPtr 		params)								FOURWORDINLINE(0x203C, 0x0008, 0x0050, 0xAAA3);

EXTERN_API( OSErr )
SetCSequenceFrameNumber			(ImageSequence 			seqID,
								 long 					frameNumber)						FOURWORDINLINE(0x203C, 0x0008, 0x0051, 0xAAA3);

EXTERN_API( OSErr )
SetCSequencePreferredPacketSize	(ImageSequence 			seqID,
								 long 					preferredPacketSizeInBytes)			FOURWORDINLINE(0x203C, 0x0008, 0x0078, 0xAAA3);

EXTERN_API( OSErr )
NewImageGWorld					(GWorldPtr *			gworld,
								 ImageDescriptionHandle  idh,
								 GWorldFlags 			flags)								FOURWORDINLINE(0x203C, 0x000C, 0x0052, 0xAAA3);

EXTERN_API( OSErr )
GetCSequenceDataRateParams		(ImageSequence 			seqID,
								 DataRateParamsPtr 		params)								FOURWORDINLINE(0x203C, 0x0008, 0x0053, 0xAAA3);

EXTERN_API( OSErr )
GetCSequenceFrameNumber			(ImageSequence 			seqID,
								 long *					frameNumber)						FOURWORDINLINE(0x203C, 0x0008, 0x0054, 0xAAA3);

EXTERN_API( OSErr )
GetBestDeviceRect				(GDHandle *				gdh,
								 Rect *					rp)									FOURWORDINLINE(0x203C, 0x0008, 0x0055, 0xAAA3);

EXTERN_API( OSErr )
SetSequenceProgressProc			(ImageSequence 			seqID,
								 ICMProgressProcRecord * progressProc)						FOURWORDINLINE(0x203C, 0x0008, 0x0056, 0xAAA3);

EXTERN_API( OSErr )
GDHasScale						(GDHandle 				gdh,
								 short 					depth,
								 Fixed *				scale)								FOURWORDINLINE(0x203C, 0x000A, 0x005A, 0xAAA3);

EXTERN_API( OSErr )
GDGetScale						(GDHandle 				gdh,
								 Fixed *				scale,
								 short *				flags)								FOURWORDINLINE(0x203C, 0x000C, 0x005B, 0xAAA3);

EXTERN_API( OSErr )
GDSetScale						(GDHandle 				gdh,
								 Fixed 					scale,
								 short 					flags)								FOURWORDINLINE(0x203C, 0x000A, 0x005C, 0xAAA3);

EXTERN_API( OSErr )
ICMShieldSequenceCursor			(ImageSequence 			seqID)								FOURWORDINLINE(0x203C, 0x0004, 0x0062, 0xAAA3);

EXTERN_API( void )
ICMDecompressComplete			(ImageSequence 			seqID,
								 OSErr 					err,
								 short 					flag,
								 ICMCompletionProcRecordPtr  completionRtn)					FOURWORDINLINE(0x203C, 0x000C, 0x0063, 0xAAA3);

EXTERN_API( OSErr )
SetDSequenceTimeCode			(ImageSequence 			seqID,
								 void *					timeCodeFormat,
								 void *					timeCodeTime)						FOURWORDINLINE(0x203C, 0x000C, 0x0064, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceNewMemory				(ImageSequence 			seqID,
								 Ptr *					data,
								 Size 					dataSize,
								 long 					dataUse,
								 ICMMemoryDisposedUPP 	memoryGoneProc,
								 void *					refCon)								FOURWORDINLINE(0x203C, 0x0018, 0x0066, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceDisposeMemory			(ImageSequence 			seqID,
								 Ptr 					data)								FOURWORDINLINE(0x203C, 0x0008, 0x0067, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceNewDataSource			(ImageSequence 			seqID,
								 ImageSequenceDataSource * sourceID,
								 OSType 				sourceType,
								 long 					sourceInputNumber,
								 Handle 				dataDescription,
								 void *					transferProc,
								 void *					refCon)								FOURWORDINLINE(0x203C, 0x001C, 0x0068, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceDisposeDataSource		(ImageSequenceDataSource  sourceID)							FOURWORDINLINE(0x203C, 0x0004, 0x0069, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceSetSourceData			(ImageSequenceDataSource  sourceID,
								 void *					data,
								 long 					dataSize)							FOURWORDINLINE(0x203C, 0x000C, 0x006A, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceChangedSourceData		(ImageSequenceDataSource  sourceID)							FOURWORDINLINE(0x203C, 0x0004, 0x006B, 0xAAA3);

EXTERN_API( OSErr )
PtInDSequenceData				(ImageSequence 			seqID,
								 void *					data,
								 Size 					dataSize,
								 Point 					where,
								 Boolean *				hit)								FOURWORDINLINE(0x203C, 0x0014, 0x006C, 0xAAA3);

EXTERN_API( OSErr )
GetGraphicsImporterForFile		(const FSSpec *			theFile,
								 ComponentInstance *	gi)									FOURWORDINLINE(0x203C, 0x0008, 0x006E, 0xAAA3);

EXTERN_API( OSErr )
GetGraphicsImporterForDataRef	(Handle 				dataRef,
								 OSType 				dataRefType,
								 ComponentInstance *	gi)									FOURWORDINLINE(0x203C, 0x000C, 0x0077, 0xAAA3);

EXTERN_API( OSErr )
ImageTranscodeSequenceBegin		(ImageTranscodeSequence * its,
								 ImageDescriptionHandle  srcDesc,
								 OSType 				destType,
								 ImageDescriptionHandle * dstDesc,
								 void *					data,
								 long 					dataSize)							FOURWORDINLINE(0x203C, 0x0018, 0x006F, 0xAAA3);

EXTERN_API( OSErr )
ImageTranscodeSequenceEnd		(ImageTranscodeSequence  its)								FOURWORDINLINE(0x203C, 0x0004, 0x0070, 0xAAA3);

EXTERN_API( OSErr )
ImageTranscodeFrame				(ImageTranscodeSequence  its,
								 void *					srcData,
								 long 					srcDataSize,
								 void **				dstData,
								 long *					dstDataSize)						FOURWORDINLINE(0x203C, 0x0014, 0x0071, 0xAAA3);

EXTERN_API( OSErr )
ImageTranscodeDisposeFrameData	(ImageTranscodeSequence  its,
								 void *					dstData)							FOURWORDINLINE(0x203C, 0x0008, 0x0072, 0xAAA3);

EXTERN_API( OSErr )
CDSequenceInvalidate			(ImageSequence 			seqID,
								 RgnHandle 				invalRgn)							FOURWORDINLINE(0x203C, 0x0008, 0x0073, 0xAAA3);

EXTERN_API( OSErr )
ImageFieldSequenceBegin			(ImageFieldSequence *	ifs,
								 ImageDescriptionHandle  desc1,
								 ImageDescriptionHandle  desc2,
								 ImageDescriptionHandle  descOut)							FOURWORDINLINE(0x203C, 0x0010, 0x006D, 0xAAA3);

EXTERN_API( OSErr )
ImageFieldSequenceExtractCombine (ImageFieldSequence 	ifs,
								 long 					fieldFlags,
								 void *					data1,
								 long 					dataSize1,
								 void *					data2,
								 long 					dataSize2,
								 void *					outputData,
								 long *					outDataSize)						FOURWORDINLINE(0x203C, 0x0020, 0x0075, 0xAAA3);

EXTERN_API( OSErr )
ImageFieldSequenceEnd			(ImageFieldSequence 	ifs)								FOURWORDINLINE(0x203C, 0x0004, 0x0076, 0xAAA3);





enum {
	identityMatrixType			= 0x00,							/* result if matrix is identity */
	translateMatrixType			= 0x01,							/* result if matrix translates */
	scaleMatrixType				= 0x02,							/* result if matrix scales */
	scaleTranslateMatrixType	= 0x03,							/* result if matrix scales and translates */
	linearMatrixType			= 0x04,							/* result if matrix is general 2 x 2 */
	linearTranslateMatrixType	= 0x05,							/* result if matrix is general 2 x 2 and translates */
	perspectiveMatrixType		= 0x06							/* result if matrix is general 3 x 3 */
};

typedef unsigned short 					MatrixFlags;
EXTERN_API( short )
GetMatrixType					(const MatrixRecord *	m)									TWOWORDINLINE(0x7014, 0xABC2);

EXTERN_API( void )
CopyMatrix						(const MatrixRecord *	m1,
								 MatrixRecord *			m2)									TWOWORDINLINE(0x7020, 0xABC2);

EXTERN_API( Boolean )
EqualMatrix						(const MatrixRecord *	m1,
								 const MatrixRecord *	m2)									TWOWORDINLINE(0x7021, 0xABC2);

EXTERN_API( void )
SetIdentityMatrix				(MatrixRecord *			matrix)								TWOWORDINLINE(0x7015, 0xABC2);

EXTERN_API( void )
TranslateMatrix					(MatrixRecord *			m,
								 Fixed 					deltaH,
								 Fixed 					deltaV)								TWOWORDINLINE(0x7019, 0xABC2);

EXTERN_API( void )
RotateMatrix					(MatrixRecord *			m,
								 Fixed 					degrees,
								 Fixed 					aboutX,
								 Fixed 					aboutY)								TWOWORDINLINE(0x7016, 0xABC2);

EXTERN_API( void )
ScaleMatrix						(MatrixRecord *			m,
								 Fixed 					scaleX,
								 Fixed 					scaleY,
								 Fixed 					aboutX,
								 Fixed 					aboutY)								TWOWORDINLINE(0x7017, 0xABC2);

EXTERN_API( void )
SkewMatrix						(MatrixRecord *			m,
								 Fixed 					skewX,
								 Fixed 					skewY,
								 Fixed 					aboutX,
								 Fixed 					aboutY)								TWOWORDINLINE(0x7018, 0xABC2);

EXTERN_API( OSErr )
TransformFixedPoints			(const MatrixRecord *	m,
								 FixedPoint *			fpt,
								 long 					count)								TWOWORDINLINE(0x7022, 0xABC2);

EXTERN_API( OSErr )
TransformPoints					(const MatrixRecord *	mp,
								 Point *				pt1,
								 long 					count)								TWOWORDINLINE(0x7023, 0xABC2);

EXTERN_API( Boolean )
TransformFixedRect				(const MatrixRecord *	m,
								 FixedRect *			fr,
								 FixedPoint *			fpp)								TWOWORDINLINE(0x7024, 0xABC2);

EXTERN_API( Boolean )
TransformRect					(const MatrixRecord *	m,
								 Rect *					r,
								 FixedPoint *			fpp)								TWOWORDINLINE(0x7025, 0xABC2);

EXTERN_API( Boolean )
InverseMatrix					(const MatrixRecord *	m,
								 MatrixRecord *			im)									TWOWORDINLINE(0x701C, 0xABC2);

EXTERN_API( void )
ConcatMatrix					(const MatrixRecord *	a,
								 MatrixRecord *			b)									TWOWORDINLINE(0x701B, 0xABC2);

EXTERN_API( void )
RectMatrix						(MatrixRecord *			matrix,
								 const Rect *			srcRect,
								 const Rect *			dstRect)							TWOWORDINLINE(0x701E, 0xABC2);

EXTERN_API( void )
MapMatrix						(MatrixRecord *			matrix,
								 const Rect *			fromRect,
								 const Rect *			toRect)								TWOWORDINLINE(0x701D, 0xABC2);







EXTERN_API( void )
CompAdd							(wide *					src,
								 wide *					dst)								TWOWORDINLINE(0x7001, 0xABC2);

EXTERN_API( void )
CompSub							(wide *					src,
								 wide *					dst)								TWOWORDINLINE(0x7002, 0xABC2);

EXTERN_API( void )
CompNeg							(wide *					dst)								TWOWORDINLINE(0x7003, 0xABC2);

EXTERN_API( void )
CompShift						(wide *					src,
								 short 					shift)								TWOWORDINLINE(0x7004, 0xABC2);

EXTERN_API( void )
CompMul							(long 					src1,
								 long 					src2,
								 wide *					dst)								TWOWORDINLINE(0x7005, 0xABC2);

EXTERN_API( long )
CompDiv							(wide *					numerator,
								 long 					denominator,
								 long *					remainder)							TWOWORDINLINE(0x7006, 0xABC2);

EXTERN_API( void )
CompFixMul						(wide *					compSrc,
								 Fixed 					fixSrc,
								 wide *					compDst)							TWOWORDINLINE(0x7007, 0xABC2);

EXTERN_API( void )
CompMulDiv						(wide *					co,
								 long 					mul,
								 long 					divisor)							TWOWORDINLINE(0x7008, 0xABC2);

EXTERN_API( void )
CompMulDivTrunc					(wide *					co,
								 long 					mul,
								 long 					divisor,
								 long *					remainder)							TWOWORDINLINE(0x700C, 0xABC2);

EXTERN_API( long )
CompCompare						(wide *					a,
								 wide *					minusb)								TWOWORDINLINE(0x7009, 0xABC2);

EXTERN_API( Fixed )
FixMulDiv						(Fixed 					src,
								 Fixed 					mul,
								 Fixed 					divisor)							TWOWORDINLINE(0x700A, 0xABC2);

EXTERN_API( Fixed )
UnsignedFixMulDiv				(Fixed 					src,
								 Fixed 					mul,
								 Fixed 					divisor)							TWOWORDINLINE(0x700D, 0xABC2);

EXTERN_API( Fract )
FracSinCos						(Fixed 					degree,
								 Fract *				cosOut)								TWOWORDINLINE(0x700B, 0xABC2);

EXTERN_API( Fixed )
FixExp2							(Fixed 					src)								TWOWORDINLINE(0x700E, 0xABC2);

EXTERN_API( Fixed )
FixLog2							(Fixed 					src)								TWOWORDINLINE(0x700F, 0xABC2);

EXTERN_API( Fixed )
FixPow							(Fixed 					base,
								 Fixed 					exp)								TWOWORDINLINE(0x7010, 0xABC2);




typedef ComponentInstance 				GraphicsImportComponent;

enum {
	GraphicsImporterComponentType = FOUR_CHAR_CODE('grip')
};



/** These are GraphicsImport procedures **/
EXTERN_API( ComponentResult )
GraphicsImportSetDataReference	(GraphicsImportComponent  ci,
								 Handle 				dataRef,
								 OSType 				dataReType)							FIVEWORDINLINE(0x2F3C, 0x0008, 0x0001, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetDataReference	(GraphicsImportComponent  ci,
								 Handle *				dataRef,
								 OSType *				dataReType)							FIVEWORDINLINE(0x2F3C, 0x0008, 0x0002, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetDataFile		(GraphicsImportComponent  ci,
								 const FSSpec *			theFile)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetDataFile		(GraphicsImportComponent  ci,
								 FSSpec *				theFile)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0004, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetDataHandle		(GraphicsImportComponent  ci,
								 Handle 				h)									FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetDataHandle		(GraphicsImportComponent  ci,
								 Handle *				h)									FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetImageDescription (GraphicsImportComponent  ci,
								 ImageDescriptionHandle * desc)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetDataOffsetAndSize (GraphicsImportComponent  ci,
								 unsigned long *		offset,
								 unsigned long *		size)								FIVEWORDINLINE(0x2F3C, 0x0008, 0x0008, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportReadData			(GraphicsImportComponent  ci,
								 void *					dataPtr,
								 unsigned long 			dataOffset,
								 unsigned long 			dataSize)							FIVEWORDINLINE(0x2F3C, 0x000C, 0x0009, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetClip			(GraphicsImportComponent  ci,
								 RgnHandle 				clipRgn)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x000A, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetClip			(GraphicsImportComponent  ci,
								 RgnHandle *			clipRgn)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x000B, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetSourceRect		(GraphicsImportComponent  ci,
								 const Rect *			sourceRect)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetSourceRect		(GraphicsImportComponent  ci,
								 Rect *					sourceRect)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetNaturalBounds	(GraphicsImportComponent  ci,
								 Rect *					naturalBounds)						FIVEWORDINLINE(0x2F3C, 0x0004, 0x000E, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportDraw				(GraphicsImportComponent  ci)								FIVEWORDINLINE(0x2F3C, 0x0000, 0x000F, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetGWorld			(GraphicsImportComponent  ci,
								 CGrafPtr 				port,
								 GDHandle 				gd)									FIVEWORDINLINE(0x2F3C, 0x0008, 0x0010, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetGWorld			(GraphicsImportComponent  ci,
								 CGrafPtr *				port,
								 GDHandle *				gd)									FIVEWORDINLINE(0x2F3C, 0x0008, 0x0011, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetMatrix			(GraphicsImportComponent  ci,
								 const MatrixRecord *	matrix)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0012, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetMatrix			(GraphicsImportComponent  ci,
								 MatrixRecord *			matrix)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0013, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetBoundsRect		(GraphicsImportComponent  ci,
								 const Rect *			bounds)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0014, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetBoundsRect		(GraphicsImportComponent  ci,
								 Rect *					bounds)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0015, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSaveAsPicture		(GraphicsImportComponent  ci,
								 const FSSpec *			fss,
								 ScriptCode 			scriptTag)							FIVEWORDINLINE(0x2F3C, 0x0006, 0x0016, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetGraphicsMode	(GraphicsImportComponent  ci,
								 long 					graphicsMode,
								 const RGBColor *		opColor)							FIVEWORDINLINE(0x2F3C, 0x0008, 0x0017, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetGraphicsMode	(GraphicsImportComponent  ci,
								 long *					graphicsMode,
								 RGBColor *				opColor)							FIVEWORDINLINE(0x2F3C, 0x0008, 0x0018, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetQuality		(GraphicsImportComponent  ci,
								 CodecQ 				quality)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0019, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetQuality		(GraphicsImportComponent  ci,
								 CodecQ *				quality)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x001A, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSaveAsQuickTimeImageFile (GraphicsImportComponent  ci,
								 const FSSpec *			fss,
								 ScriptCode 			scriptTag)							FIVEWORDINLINE(0x2F3C, 0x0006, 0x001B, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportSetDataReferenceOffsetAndLimit (GraphicsImportComponent  ci,
								 unsigned long 			offset,
								 unsigned long 			limit)								FIVEWORDINLINE(0x2F3C, 0x0008, 0x001C, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetDataReferenceOffsetAndLimit (GraphicsImportComponent  ci,
								 unsigned long *		offset,
								 unsigned long *		limit)								FIVEWORDINLINE(0x2F3C, 0x0008, 0x001D, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportGetAliasedDataReference (GraphicsImportComponent  ci,
								 Handle *				dataRef,
								 OSType *				dataRefType)						FIVEWORDINLINE(0x2F3C, 0x0008, 0x001E, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
GraphicsImportValidate			(GraphicsImportComponent  ci,
								 Boolean *				valid)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x001F, 0x7000, 0xA82A);


typedef ComponentInstance 				ImageTranscoderComponent;

enum {
	ImageTranscodererComponentType = FOUR_CHAR_CODE('imtc')
};


/** These are ImageTranscoder procedures **/
EXTERN_API( ComponentResult )
ImageTranscoderBeginSequence	(ImageTranscoderComponent  itc,
								 ImageDescriptionHandle  srcDesc,
								 ImageDescriptionHandle * dstDesc,
								 void *					data,
								 long 					dataSize)							FIVEWORDINLINE(0x2F3C, 0x0010, 0x0001, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
ImageTranscoderConvert			(ImageTranscoderComponent  itc,
								 void *					srcData,
								 long 					srcDataSize,
								 void **				dstData,
								 long *					dstDataSize)						FIVEWORDINLINE(0x2F3C, 0x0010, 0x0002, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
ImageTranscoderDisposeData		(ImageTranscoderComponent  itc,
								 void *					dstData)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
ImageTranscoderEndSequence		(ImageTranscoderComponent  itc)								FIVEWORDINLINE(0x2F3C, 0x0000, 0x0004, 0x7000, 0xA82A);

/* UPP call backs */

/* selectors for component calls */
enum {
	kGraphicsImportSetDataReferenceSelect			= 0x0001,
	kGraphicsImportGetDataReferenceSelect			= 0x0002,
	kGraphicsImportSetDataFileSelect				= 0x0003,
	kGraphicsImportGetDataFileSelect				= 0x0004,
	kGraphicsImportSetDataHandleSelect				= 0x0005,
	kGraphicsImportGetDataHandleSelect				= 0x0006,
	kGraphicsImportGetImageDescriptionSelect		= 0x0007,
	kGraphicsImportGetDataOffsetAndSizeSelect		= 0x0008,
	kGraphicsImportReadDataSelect					= 0x0009,
	kGraphicsImportSetClipSelect					= 0x000A,
	kGraphicsImportGetClipSelect					= 0x000B,
	kGraphicsImportSetSourceRectSelect				= 0x000C,
	kGraphicsImportGetSourceRectSelect				= 0x000D,
	kGraphicsImportGetNaturalBoundsSelect			= 0x000E,
	kGraphicsImportDrawSelect						= 0x000F,
	kGraphicsImportSetGWorldSelect					= 0x0010,
	kGraphicsImportGetGWorldSelect					= 0x0011,
	kGraphicsImportSetMatrixSelect					= 0x0012,
	kGraphicsImportGetMatrixSelect					= 0x0013,
	kGraphicsImportSetBoundsRectSelect				= 0x0014,
	kGraphicsImportGetBoundsRectSelect				= 0x0015,
	kGraphicsImportSaveAsPictureSelect				= 0x0016,
	kGraphicsImportSetGraphicsModeSelect			= 0x0017,
	kGraphicsImportGetGraphicsModeSelect			= 0x0018,
	kGraphicsImportSetQualitySelect					= 0x0019,
	kGraphicsImportGetQualitySelect					= 0x001A,
	kGraphicsImportSaveAsQuickTimeImageFileSelect	= 0x001B,
	kGraphicsImportSetDataReferenceOffsetAndLimitSelect = 0x001C,
	kGraphicsImportGetDataReferenceOffsetAndLimitSelect = 0x001D,
	kGraphicsImportGetAliasedDataReferenceSelect	= 0x001E,
	kGraphicsImportValidateSelect					= 0x001F,
	kImageTranscoderBeginSequenceSelect				= 0x0001,
	kImageTranscoderConvertSelect					= 0x0002,
	kImageTranscoderDisposeDataSelect				= 0x0003,
	kImageTranscoderEndSequenceSelect				= 0x0004
};


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

#endif /* __IMAGECOMPRESSION__ */

