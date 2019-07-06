/*
 	File:		SFNTTypes.h
 
 	Contains:	Font file structures.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __SFNTTYPES__
#define __SFNTTYPES__

#ifndef __TYPES__
#include <Types.h>
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

struct sfntDirectoryEntry {
	FourCharCode 					tableTag;
	UInt32 							checkSum;
	UInt32 							offset;
	UInt32 							length;
};
typedef struct sfntDirectoryEntry sfntDirectoryEntry;

/* The search fields limits numOffsets to 4096. */
struct sfntDirectory {
	FourCharCode 					format;
	UInt16 							numOffsets;					/* number of tables */
	UInt16 							searchRange;				/* (max2 <= numOffsets)*16 */
	UInt16 							entrySelector;				/* log2(max2 <= numOffsets) */
	UInt16 							rangeShift;					/* numOffsets*16-searchRange*/
	sfntDirectoryEntry 				table[1];					/* table[numOffsets] */
};
typedef struct sfntDirectory sfntDirectory;


enum {
	sizeof_sfntDirectory		= 12
};

/* Cmap - character id to glyph id mapping */

enum {
	cmapFontTableTag			= FOUR_CHAR_CODE('cmap')
};

struct sfntCMapSubHeader {
	UInt16 							format;
	UInt16 							length;
	UInt16 							languageID;					/* base-1 */
};
typedef struct sfntCMapSubHeader sfntCMapSubHeader;


enum {
	sizeof_sfntCMapSubHeader	= 6
};

struct sfntCMapEncoding {
	UInt16 							platformID;					/* base-0 */
	UInt16 							scriptID;					/* base-0 */
	UInt32 							offset;
};
typedef struct sfntCMapEncoding sfntCMapEncoding;


enum {
	sizeof_sfntCMapEncoding		= 8
};

struct sfntCMapHeader {
	UInt16 							version;
	UInt16 							numTables;
	sfntCMapEncoding 				encoding[1];
};
typedef struct sfntCMapHeader sfntCMapHeader;


enum {
	sizeof_sfntCMapHeader		= 4
};

/* Name table */

enum {
	nameFontTableTag			= FOUR_CHAR_CODE('name')
};

struct sfntNameRecord {
	UInt16 							platformID;					/* base-0 */
	UInt16 							scriptID;					/* base-0 */
	UInt16 							languageID;					/* base-0 */
	UInt16 							nameID;						/* base-0 */
	UInt16 							length;
	UInt16 							offset;
};
typedef struct sfntNameRecord sfntNameRecord;


enum {
	sizeof_sfntNameRecord		= 12
};

struct sfntNameHeader {
	UInt16 							format;
	UInt16 							count;
	UInt16 							stringOffset;
	sfntNameRecord 					rec[1];
};
typedef struct sfntNameHeader sfntNameHeader;


enum {
	sizeof_sfntNameHeader		= 6
};

/* Fvar table - font variations */

enum {
	variationFontTableTag		= FOUR_CHAR_CODE('fvar')
};

/* These define each font variation */
struct sfntVariationAxis {
	FourCharCode 					axisTag;
	Fixed 							minValue;
	Fixed 							defaultValue;
	Fixed 							maxValue;
	SInt16 							flags;
	SInt16 							nameID;
};
typedef struct sfntVariationAxis sfntVariationAxis;


enum {
	sizeof_sfntVariationAxis	= 20
};

/* These are named locations in style-space for the user */
struct sfntInstance {
	SInt16 							nameID;
	SInt16 							flags;
	Fixed 							coord[1];					/* [axisCount] */
																/* room to grow since the header carries a tupleSize field */
};
typedef struct sfntInstance sfntInstance;


enum {
	sizeof_sfntInstance			= 4
};

struct sfntVariationHeader {
	Fixed 							version;					/* 1.0 Fixed */
	UInt16 							offsetToData;				/* to first axis = 16*/
	UInt16 							countSizePairs;				/* axis+inst = 2 */
	UInt16 							axisCount;
	UInt16 							axisSize;
	UInt16 							instanceCount;
	UInt16 							instanceSize;
																/* …other <count,size> pairs */
	sfntVariationAxis 				axis[1];					/* [axisCount] */
	sfntInstance 					instance[1];				/* [instanceCount]  …other arrays of data */
};
typedef struct sfntVariationHeader sfntVariationHeader;


enum {
	sizeof_sfntVariationHeader	= 16
};

/* Fdsc table - font descriptor */

enum {
	descriptorFontTableTag		= FOUR_CHAR_CODE('fdsc')
};

struct sfntFontDescriptor {
	FourCharCode 					name;
	Fixed 							value;
};
typedef struct sfntFontDescriptor sfntFontDescriptor;

struct sfntDescriptorHeader {
	Fixed 							version;					/* 1.0 in Fixed */
	SInt32 							descriptorCount;
	sfntFontDescriptor 				descriptor[1];
};
typedef struct sfntDescriptorHeader sfntDescriptorHeader;


enum {
	sizeof_sfntDescriptorHeader	= 8
};

/* Feat Table - layout feature table */

enum {
	featureFontTableTag			= FOUR_CHAR_CODE('feat')
};

struct sfntFeatureName {
	UInt16 							featureType;
	UInt16 							settingCount;
	SInt32 							offsetToSettings;
	UInt16 							featureFlags;
	UInt16 							nameID;
};
typedef struct sfntFeatureName sfntFeatureName;

struct sfntFontFeatureSetting {
	UInt16 							setting;
	UInt16 							nameID;
};
typedef struct sfntFontFeatureSetting sfntFontFeatureSetting;

struct sfntFontRunFeature {
	UInt16 							featureType;
	UInt16 							setting;
};
typedef struct sfntFontRunFeature sfntFontRunFeature;

struct sfntFeatureHeader {
	SInt32 							version;					/* 1.0 */
	UInt16 							featureNameCount;
	UInt16 							featureSetCount;
	SInt32 							reserved;					/* set to 0 */
	sfntFeatureName 				names[1];
	sfntFontFeatureSetting 			settings[1];
	sfntFontRunFeature 				runs[1];
};
typedef struct sfntFeatureHeader sfntFeatureHeader;

/* OS/2 Table */

enum {
	os2FontTableTag				= FOUR_CHAR_CODE('OS/2')
};

/*  Special invalid glyph ID value, useful as a sentinel value, for example */

enum {
	nonGlyphID					= 65535L
};

/* Data types for encoding components as used in interfaces */
typedef UInt32 							FontPlatformCode;
typedef UInt32 							FontScriptCode;
typedef UInt32 							FontLanguageCode;

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

#endif /* __SFNTTYPES__ */

