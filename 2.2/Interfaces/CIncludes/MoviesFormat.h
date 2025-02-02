/*
 	File:		MoviesFormat.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __MOVIESFORMAT__
#define __MOVIESFORMAT__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __WINDOWS__
#include <Windows.h>
#endif
#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif


enum {
	kMovieVersion				= 0								/* version number of the format here described */
};

/*
***************************************
*
*   General Types -
*		These types are used in more than one of the
*		directory types.
*
***************************************
*/
struct MoviesUserData {
	long 							size;						/* size of this user data */
	long 							udType;						/* type of user data */
	char 							data[1];					/* the user data */
};
typedef struct MoviesUserData MoviesUserData;

struct UserDataAtom {
	long 							size;
	long 							atomType;
	MoviesUserData 					userData[1];
};
typedef struct UserDataAtom UserDataAtom;

/*
 MoviesDataDescription tells us where the data for the movie or track lives.
   The data can follow the directory, be in the datafork of the same file as the directory resource,
   be in the resource fork of the same file as the directory resource, be in another file in the
   data fork or resource fork, or require a specific bottleneck to fetch the data. 
*/
/*
***************************************
*
*   MediaDirectory information -
*		The MediaDirectory is tightly coupled to the data.
*
***************************************
*/
struct SampleDescriptionAtom {
	long 							size;
	long 							atomType;					/* = 'stsd' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							numEntries;
	SampleDescription 				sampleDescTable[1];
};
typedef struct SampleDescriptionAtom SampleDescriptionAtom;

/* TimeToSampleNum maps physical sample time to physical sample number. */
struct TimeToSampleNum {
	long 							sampleCount;
	TimeValue 						sampleDuration;
};
typedef struct TimeToSampleNum TimeToSampleNum;

struct TimeToSampleNumAtom {
	long 							size;
	long 							atomType;					/* = 'stts' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							numEntries;
	TimeToSampleNum 				timeToSampleNumTable[1];
};
typedef struct TimeToSampleNumAtom TimeToSampleNumAtom;

/* SyncSamples is a list of the physical samples which are self contained. */
struct SyncSampleAtom {
	long 							size;
	long 							atomType;					/* = 'stss' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							numEntries;
	long 							syncSampleTable[1];
};
typedef struct SyncSampleAtom SyncSampleAtom;

/* SampleToChunk maps physical sample number to chunk number. */
/* same as SampleToChunk, but redundant first sample is removed */
struct SampleToChunk {
	long 							firstChunk;
	long 							samplesPerChunk;
	long 							sampleDescriptionID;
};
typedef struct SampleToChunk SampleToChunk;

struct SampleToChunkAtom {
	long 							size;
	long 							atomType;					/* = 'stsc' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							numEntries;
	SampleToChunk 					sampleToChunkTable[1];
};
typedef struct SampleToChunkAtom SampleToChunkAtom;

struct ChunkOffsetAtom {
	long 							size;
	long 							atomType;					/* = 'stco' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							numEntries;
	long 							chunkOffsetTable[1];
};
typedef struct ChunkOffsetAtom ChunkOffsetAtom;

struct SampleSizeAtom {
	long 							size;
	long 							atomType;					/* = 'stsz' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							sampleSize;
	long 							numEntries;
	long 							sampleSizeTable[1];
};
typedef struct SampleSizeAtom SampleSizeAtom;

struct ShadowSync {
	long 							fdSampleNum;
	long 							syncSampleNum;
};
typedef struct ShadowSync ShadowSync;

struct ShadowSyncAtom {
	long 							size;
	long 							atomType;					/* = 'stsz' */
	long 							flags;						/* 1 byte of version / 3 bytes of flags */
	long 							numEntries;
	ShadowSync 						shadowSyncTable[1];
};
typedef struct ShadowSyncAtom ShadowSyncAtom;

struct SampleTableAtom {
	long 							size;
	long 							atomType;					/* = 'stbl' */

	SampleDescriptionAtom 			sampleDescription;
	TimeToSampleNumAtom 			timeToSampleNum;
	SampleToChunkAtom 				sampleToChunk;
	SyncSampleAtom 					syncSample;
	SampleSizeAtom 					sampleSize;
	ChunkOffsetAtom 				chunkOffset;
	ShadowSyncAtom 					shadowSync;
};
typedef struct SampleTableAtom SampleTableAtom;

struct PublicHandlerInfo {
	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	long 							componentType;
	long 							componentSubType;
	long 							componentManufacturer;
	long 							componentFlags;
	long 							componentFlagsMask;
	char 							componentName[1];
};
typedef struct PublicHandlerInfo PublicHandlerInfo;

struct HandlerAtom {
	long 							size;
	long 							atomType;					/* = 'hdlr' */

	PublicHandlerInfo 				hInfo;
};
typedef struct HandlerAtom HandlerAtom;

/* a data reference is a private structure */
typedef long DataRefAtom;
struct DataInfoAtom {
	long 							size;
	long 							atomType;					/* = 'dinf' */

	DataRefAtom 					dataRef;
};
typedef struct DataInfoAtom DataInfoAtom;

struct RgnAtom {
	long 							size;
	long 							atomType;

	short 							rgnSize;
	Rect 							rgnBBox;
	char 							data[1];
};
typedef struct RgnAtom RgnAtom;

struct MatteCompressedAtom {
	long 							size;
	long 							atomType;

	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	ImageDescription 				matteImageDescription;

	char 							matteData[1];
};
typedef struct MatteCompressedAtom MatteCompressedAtom;

struct MatteAtom {
	long 							size;
	long 							atomType;

	MatteCompressedAtom 			aCompressedMatte;
};
typedef struct MatteAtom MatteAtom;

struct ClippingAtom {
	long 							size;
	long 							atomType;

	RgnAtom 						aRgnClip;
};
typedef struct ClippingAtom ClippingAtom;

/*
**********************
* Media Info Example Structures
**********************
*/
struct VideoMediaInfoHeader {
	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	short 							graphicsMode;				/* for QD - transfer mode */
	short 							opColorRed;					/* opcolor for transfer mode */
	short 							opColorGreen;
	short 							opColorBlue;
};
typedef struct VideoMediaInfoHeader VideoMediaInfoHeader;

struct VideoMediaInfoHeaderAtom {
	long 							size;						/* size of Media info */
	long 							atomType;					/* = 'vmhd' */
	VideoMediaInfoHeader 			vmiHeader;
};
typedef struct VideoMediaInfoHeaderAtom VideoMediaInfoHeaderAtom;

struct VideoMediaInfo {
	long 							size;						/* size of Media info */
	long 							atomType;					/* = 'minf' */

	VideoMediaInfoHeaderAtom 		header;

	HandlerAtom 					dataHandler;

	DataInfoAtom 					dataInfo;

	SampleTableAtom 				sampleTable;
};
typedef struct VideoMediaInfo VideoMediaInfo;

struct SoundMediaInfoHeader {
	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	short 							balance;
	short 							rsrvd;
};
typedef struct SoundMediaInfoHeader SoundMediaInfoHeader;

struct SoundMediaInfoHeaderAtom {
	long 							size;						/* size of Media info */
	long 							atomType;					/* = 'vmhd' */

	SoundMediaInfoHeader 			smiHeader;
};
typedef struct SoundMediaInfoHeaderAtom SoundMediaInfoHeaderAtom;

struct SoundMediaInfo {
	long 							size;						/* size of Media info */
	long 							atomType;					/* = 'minf' */

	SoundMediaInfoHeaderAtom 		header;

	HandlerAtom 					dataHandler;

	DataRefAtom 					dataReference;

	SampleTableAtom 				sampleTable;
};
typedef struct SoundMediaInfo SoundMediaInfo;

/* whatever data the media handler needs goes after the atomType */
struct MediaInfo {
	long 							size;
	long 							atomType;
};
typedef struct MediaInfo MediaInfo;

/*
**********************
* Media Directory Structures
**********************
*/
struct MediaHeader {
	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	long 							creationTime;				/* seconds since Jan 1904 when directory was created */
	long 							modificationTime;			/* seconds since Jan 1904 when directory was appended */

	TimeValue 						timeScale;					/* start time for Media (Media time) */
	TimeValue 						duration;					/* length of Media (Media time) */

	short 							language;
	short 							quality;
};
typedef struct MediaHeader MediaHeader;

struct MediaHeaderAtom {
	long 							size;
	long 							atomType;

	MediaHeader 					header;
};
typedef struct MediaHeaderAtom MediaHeaderAtom;

struct MediaDirectory {
	long 							size;
	long 							atomType;					/* = 'mdia' */

	MediaHeaderAtom 				mediaHeader;				/* standard Media information */

	HandlerAtom 					mediaHandler;

	MediaInfo 						mediaInfo;
};
typedef struct MediaDirectory MediaDirectory;

/*
**********************
* Track Structures
**********************
*/

enum {
	TrackEnable					= 1 << 0,
	TrackInMovie				= 1 << 1,
	TrackInPreview				= 1 << 2,
	TrackInPoster				= 1 << 3
};

struct TrackHeader {
	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	long 							creationTime;				/* seconds since Jan 1904 when directory was created */
	long 							modificationTime;			/* seconds since Jan 1904 when directory was appended */

	long 							trackID;

	long 							reserved1;

	TimeValue 						duration;					/* length of track (track time) */

	long 							reserved2;
	long 							reserved3;

	short 							layer;
	short 							alternateGroup;

	short 							volume;
	short 							reserved4;

	MatrixRecord 					matrix;
	Fixed 							trackWidth;
	Fixed 							trackHeight;
};
typedef struct TrackHeader TrackHeader;

struct TrackHeaderAtom {
	long 							size;						/* size of track header */
	long 							atomType;					/* = 'tkhd' */

	TrackHeader 					header;
};
typedef struct TrackHeaderAtom TrackHeaderAtom;

struct EditListType {
	TimeValue 						trackDuration;
	TimeValue 						mediaTime;
	Fixed 							mediaRate;
};
typedef struct EditListType EditListType;

struct EditListAtom {
	long 							size;
	long 							atomType;					/* = elst */

	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	long 							numEntries;
	EditListType 					editListTable[1];
};
typedef struct EditListAtom EditListAtom;

struct EditsAtom {
	long 							size;
	long 							atomType;					/* = edts */

	EditListAtom 					editList;
};
typedef struct EditsAtom EditsAtom;

struct TrackLoadSettings {
	TimeValue 						preloadStartTime;
	TimeValue 						preloadDuration;
	long 							preloadFlags;
	long 							defaultHints;
};
typedef struct TrackLoadSettings TrackLoadSettings;

struct TrackLoadSettingsAtom {
	long 							size;
	long 							atomType;					/* = load */

	TrackLoadSettings 				settings;
};
typedef struct TrackLoadSettingsAtom TrackLoadSettingsAtom;

struct TrackDirectory {
	long 							size;
	long 							atomType;					/* = 'trak' */

	TrackHeaderAtom 				trackHeader;				/* standard track information */

	ClippingAtom 					trackClip;

	EditsAtom 						edits;

	MediaDirectory 					media;

	UserDataAtom 					userData;					/* space for extending with new data types */
};
typedef struct TrackDirectory TrackDirectory;

/*
***************************************
*
*   MovieDirectory -
*		The MovieDirectory is the top level structure which
*		holds the TrackInstance describing where the
*		TrackDirectories are.
*
***************************************
*/
struct MovieHeader {
	long 							flags;						/* 1 byte of version / 3 bytes of flags */

	long 							creationTime;				/* seconds since Jan 1904 when directory was created */
	long 							modificationTime;			/* seconds since Jan 1904 when directory was appended */

	TimeValue 						timeScale;					/* Time specifications */
	TimeValue 						duration;
	Fixed 							preferredRate;				/* rate at which to play this movie */

	short 							preferredVolume;			/* volume to play movie at */
	short 							reserved1;

	long 							preferredLong1;
	long 							preferredLong2;

	MatrixRecord 					matrix;

	TimeValue 						previewTime;				/* time in track the proxy begins (track time) */
	TimeValue 						previewDuration;			/* how long the proxy lasts (track time) */

	TimeValue 						posterTime;					/* time in track the proxy begins (track time) */

	TimeValue 						selectionTime;				/* time in track the proxy begins (track time) */
	TimeValue 						selectionDuration;			/* time in track the proxy begins (track time) */
	TimeValue 						currentTime;				/* time in track the proxy begins (track time) */

	long 							nextTrackID;				/* next value to use for a TrackID */
};
typedef struct MovieHeader MovieHeader;

struct MovieHeaderAtom {
	long 							size;
	long 							atomType;					/* = 'mvhd' */

	MovieHeader 					header;
};
typedef struct MovieHeaderAtom MovieHeaderAtom;

struct TrackDirectoryEntry {
	TrackDirectory 					trackDirectory;				/* Track directory information */
};
typedef struct TrackDirectoryEntry TrackDirectoryEntry;

struct MovieDirectory {
	long 							size;
	long 							atomType;					/* = 'moov' */

	MovieHeaderAtom 				header;

	ClippingAtom 					movieClip;

																/* Track Directories */
	TrackDirectoryEntry 			track[1];					/* Track directory information */

																/* User data for Movie */
	UserDataAtom 					userData;					/* space for user extensions */
};
typedef struct MovieDirectory MovieDirectory;

/*
***************************************
***************************************
*/
/* Movie formats and tags */

enum {
																/* some system defined format IDs */
	MOVIE_TYPE					= 'moov',
	TRACK_TYPE					= 'trak',
	MEDIA_TYPE					= 'mdia',
	VIDEO_TYPE					= 'vide',
	SOUND_TYPE					= 'soun'
};

/* atom id's */

enum {
	MovieAID					= 'moov',
	MovieHeaderAID				= 'mvhd',
	ClipAID						= 'clip',
	RgnClipAID					= 'crgn',
	MatteAID					= 'matt',
	MatteCompAID				= 'kmat',
	TrackAID					= 'trak',
	UserDataAID					= 'udta',
	TrackHeaderAID				= 'tkhd',
	EditsAID					= 'edts',
	EditListAID					= 'elst',
	MediaAID					= 'mdia',
	MediaHeaderAID				= 'mdhd',
	MediaInfoAID				= 'minf',
	VideoMediaInfoHeaderAID		= 'vmhd',
	SoundMediaInfoHeaderAID		= 'smhd',
	GenericMediaInfoHeaderAID	= 'gmhd',
	GenericMediaInfoAID			= 'gmin',
	DataInfoAID					= 'dinf',
	DataRefAID					= 'dref',
	SampleTableAID				= 'stbl',
	STSampleDescAID				= 'stsd',
	STTimeToSampAID				= 'stts',
	STSyncSampleAID				= 'stss',
	STSampleToChunkAID			= 'stsc',
	STShadowSyncAID				= 'stsh',
	HandlerAID					= 'hdlr',
	STSampleSizeAID				= 'stsz',
	STChunkOffsetAID			= 'stco',
	STChunkOffset64AID			= 'co64',
	DataRefContainerAID			= 'drfc',
	TrackReferenceAID			= 'tref',
	ColorTableAID				= 'ctab',
	LoadSettingsAID				= 'load',
	PropertyAtomAID				= 'code',
	InputMapAID					= 'imap',
	MovieBufferHintsAID			= 'mbfh',
	MovieDataRefAliasAID		= 'mdra',
	SoundLocalizationAID		= 'sloc'
};

/* Text ATOM definitions*/
struct TextBoxAtom {
	long 							size;
	long 							atomType;					/* = 'tbox' */
	Rect 							textBox;					/* New text box (overrides defaultTextBox)*/
};
typedef struct TextBoxAtom TextBoxAtom;

struct HiliteAtom {
	long 							size;
	long 							atomType;					/* = 'hlit' */
	long 							selStart;					/* hilite selection start character*/
	long 							selEnd;						/* hilite selection end character*/
};
typedef struct HiliteAtom HiliteAtom;

struct KaraokeRec {
	TimeValue 						timeVal;
	short 							beginHilite;
	short 							endHilite;
};
typedef struct KaraokeRec KaraokeRec;

struct KaraokeAtom {
	long 							numEntries;
	KaraokeRec 						karaokeEntries[1];
};
typedef struct KaraokeAtom KaraokeAtom;


#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MOVIESFORMAT__ */

