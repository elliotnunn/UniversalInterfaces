/*
 	File:		ImageCompression.r
 
 	Contains:	QuickTime Image Compression Interfaces.
 
 	Version:	Technology:	QuickTime 2.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __IMAGECOMPRESSION_R__
#define __IMAGECOMPRESSION_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif


#ifndef __COMPONENTS_R__
#include "Components.r"	/* 'thng' template is now in Components.r
#endif

#define codecInfoDoes1 					0x00000001
#define codecInfoDoes2 					0x00000002
#define codecInfoDoes4 					0x00000004
#define codecInfoDoes8 					0x00000008
#define codecInfoDoes16 				0x00000010
#define codecInfoDoes32 				0x00000020
#define codecInfoDoesDither 			0x00000040
#define codecInfoDoesStretch 			0x00000080
#define codecInfoDoesShrink 			0x00000100
#define codecInfoDoesMask 				0x00000200
#define codecInfoDoesTemporal 			0x00000400
#define codecInfoDoesDouble 			0x00000800
#define codecInfoDoesQuad 				0x00001000
#define codecInfoDoesHalf 				0x00002000
#define codecInfoDoesQuarter 			0x00004000
#define codecInfoDoesRotate 			0x00008000
#define codecInfoDoesHorizFlip 			0x00010000
#define codecInfoDoesVertFlip 			0x00020000
#define codecInfoDoesSkew 				0x00040000
#define codecInfoDoesBlend 				0x00080000
#define codecInfoDoesWarp 				0x00100000
#define codecInfoDoesRecompress 		0x00200000
#define codecInfoDoesSpool 				0x00400000
#define codecInfoDoesRateConstrain 		0x00800000

#define codecInfoDepth1 				0x00000001
#define codecInfoDepth2 				0x00000002
#define codecInfoDepth4 				0x00000004
#define codecInfoDepth8 				0x00000008
#define codecInfoDepth16 				0x00000010
#define codecInfoDepth32 				0x00000020
#define codecInfoDepth24 				0x00000040
#define codecInfoDepth33 				0x00000080
#define codecInfoDepth34 				0x00000100
#define codecInfoDepth36 				0x00000200
#define codecInfoDepth40 				0x00000400
#define codecInfoStoresClut 			0x00000800
#define codecInfoDoesLossless 			0x00001000
#define codecInfoSequenceSensitive 		0x00002000

#define codecFlagUseImageBuffer 		0x00000001
#define codecFlagUseScreenBuffer 		0x00000002
#define codecFlagUpdatePrevious 		0x00000004
#define codecFlagNoScreenUpdate 		0x00000008
#define codecFlagWasCompressed 			0x00000010
#define codecFlagDontOffscreen 			0x00000020
#define codecFlagUpdatePreviousComp 	0x00000040
#define codecFlagForceKeyFrame 			0x00000080
#define codecFlagOnlyScreenUpdate 		0x00000100
#define codecFlagLiveGrab 				0x00000200
#define codecFlagDontUseNewImageBuffer 	0x00000400
#define codecFlagInterlaceUpdate 		0x00000800
#define codecFlagCatchUpDiff 			0x00001000
#define codecFlagImageBufferNotSourceImage  0x00002000
#define codecFlagUsedNewImageBuffer 	0x00004000
#define codecFlagUsedImageBuffer 		0x00008000


type 'cdci' {
	pstring[31];
	hex integer	version;
	hex integer	revlevel;
	hex longint	vendor;
	hex longint	decompressFlags;
	hex longint	compressFlags;
	hex longint	formatFlags;
	byte		compressionAccuracy;
	byte		decompressionAccuracy;
	integer		compressionSpeed;
	integer		decompressionSpeed;
	byte		compressionLevel;
	byte		resvd;
	integer		minimumHeight;
	integer		minimumWidth;
	integer		decompressPipelineLatency;
	integer		compressPipelineLatency;
	longint		privateData;
};

#define	compressorComponentType			'imco'
#define	decompressorComponentType		'imdc'

#endif /* __IMAGECOMPRESSION_R__ */

