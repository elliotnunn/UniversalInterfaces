/*
 	File:		QuickTimeVRFormat.h
 
 	Contains:	QuickTime VR interfaces
 
 	Version:	Technology:	QuickTime VR 2.0.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __QUICKTIMEVRFORMAT__
#define __QUICKTIMEVRFORMAT__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif
#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
#endif
#ifndef __QUICKTIMEVR__
#include <QuickTimeVR.h>
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


/* File Format Version numbers */
#define kQTVRMajorVersion (2)
#define kQTVRMinorVersion (0)

/* User data type for the Movie Controller type specifier*/

enum {
	kQTControllerType			= kQTVRControllerSubType,		/* Atom & ID of where our*/
	kQTControllerID				= 1								/* … controller name is stored*/
};

/* VRWorld atom types*/

enum {
	kQTVRWorldHeaderAtomType	= FOUR_CHAR_CODE('vrsc'),
	kQTVRImagingParentAtomType	= FOUR_CHAR_CODE('imgp'),
	kQTVRPanoImagingAtomType	= FOUR_CHAR_CODE('impn'),
	kQTVRObjectImagingAtomType	= FOUR_CHAR_CODE('imob'),
	kQTVRNodeParentAtomType		= FOUR_CHAR_CODE('vrnp'),
	kQTVRNodeIDAtomType			= FOUR_CHAR_CODE('vrni'),
	kQTVRNodeLocationAtomType	= FOUR_CHAR_CODE('nloc')
};

/* NodeInfo atom types*/

enum {
	kQTVRNodeHeaderAtomType		= FOUR_CHAR_CODE('ndhd'),
	kQTVRHotSpotParentAtomType	= FOUR_CHAR_CODE('hspa'),
	kQTVRHotSpotAtomType		= FOUR_CHAR_CODE('hots'),
	kQTVRHotSpotInfoAtomType	= FOUR_CHAR_CODE('hsin'),
	kQTVRLinkInfoAtomType		= FOUR_CHAR_CODE('link')
};

/* Miscellaneous atom types*/

enum {
	kQTVRStringAtomType			= FOUR_CHAR_CODE('vrsg'),
	kQTVRPanoSampleDataAtomType	= FOUR_CHAR_CODE('pdat'),
	kQTVRObjectInfoAtomType		= FOUR_CHAR_CODE('obji'),
	kQTVRAngleRangeAtomType		= FOUR_CHAR_CODE('arng'),
	kQTVRTrackRefArrayAtomType	= FOUR_CHAR_CODE('tref'),
	kQTVRPanConstraintAtomType	= FOUR_CHAR_CODE('pcon'),
	kQTVRTiltConstraintAtomType	= FOUR_CHAR_CODE('tcon'),
	kQTVRFOVConstraintAtomType	= FOUR_CHAR_CODE('fcon')
};

/* Track reference types*/

enum {
	kQTVRImageTrackRefType		= FOUR_CHAR_CODE('imgt'),
	kQTVRHotSpotTrackRefType	= FOUR_CHAR_CODE('hott')
};

/* Old hot spot types*/

enum {
	kQTVRHotSpotNavigableType	= FOUR_CHAR_CODE('navg')
};

/* Valid bits used in QTVRLinkHotSpotAtom*/

enum {
	kQTVRValidPan				= 1 << 0,
	kQTVRValidTilt				= 1 << 1,
	kQTVRValidFOV				= 1 << 2,
	kQTVRValidViewCenter		= 1 << 3
};


/* Values for flags field in QTVRPanoSampleAtom*/

enum {
	kQTVRPanoFlagHorizontal		= 1 << 0,
	kQTVRPanoFlagLast			= 1 << 31
};


/* Values for locationFlags field in QTVRNodeLocationAtom*/

enum {
	kQTVRSameFile				= 0
};


/* Header for QTVR track's Sample Description record (vrWorld atom container is appended)*/
struct QTVRSampleDescription {
	UInt32 							descSize;					/* total size of the QTVRSampleDescription*/
	UInt32 							descType;					/* must be 'qtvr'*/

	UInt32 							reserved1;					/* must be zero*/
	UInt16 							reserved2;					/* must be zero*/
	UInt16 							dataRefIndex;				/* must be zero*/

	UInt32 							data;						/* Will be extended to hold vrWorld QTAtomContainer*/

};
typedef struct QTVRSampleDescription QTVRSampleDescription;

typedef QTVRSampleDescription *			QTVRSampleDescriptionPtr;
typedef QTVRSampleDescriptionPtr *		QTVRSampleDescriptionHandle;
/*
  =================================================================================================
   Definitions and structures used in the VRWorld QTAtomContainer
  -------------------------------------------------------------------------------------------------
*/


struct QTVRStringAtom {
	UInt16 							stringUsage;
	UInt16 							stringLength;
	unsigned char 					theString[4];				/* field previously named "string"*/
};
typedef struct QTVRStringAtom QTVRStringAtom;

typedef QTVRStringAtom *				QTVRStringAtomPtr;


struct QTVRWorldHeaderAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	QTAtomID 						nameAtomID;
	UInt32 							defaultNodeID;
	UInt32 							vrWorldFlags;

	UInt32 							reserved1;
	UInt32 							reserved2;
};
typedef struct QTVRWorldHeaderAtom QTVRWorldHeaderAtom;

typedef QTVRWorldHeaderAtom *			QTVRWorldHeaderAtomPtr;

/* Valid bits used in QTVRPanoImagingAtom*/

enum {
	kQTVRValidCorrection		= 1 << 0,
	kQTVRValidQuality			= 1 << 1,
	kQTVRValidDirectDraw		= 1 << 2,
	kQTVRValidFirstExtraProperty = 1 << 3
};

struct QTVRPanoImagingAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	UInt32 							imagingMode;
	UInt32 							imagingValidFlags;

	UInt32 							correction;
	UInt32 							quality;
	UInt32 							directDraw;
	UInt32 							imagingProperties[6];		/* for future properties*/

	UInt32 							reserved1;
	UInt32 							reserved2;
};
typedef struct QTVRPanoImagingAtom QTVRPanoImagingAtom;

typedef QTVRPanoImagingAtom *			QTVRPanoImagingAtomPtr;
struct QTVRNodeLocationAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	OSType 							nodeType;
	UInt32 							locationFlags;
	UInt32 							locationData;

	UInt32 							reserved1;
	UInt32 							reserved2;
};
typedef struct QTVRNodeLocationAtom QTVRNodeLocationAtom;

typedef QTVRNodeLocationAtom *			QTVRNodeLocationAtomPtr;
/*
  =================================================================================================
   Definitions and structures used in the Nodeinfo QTAtomContainer
  -------------------------------------------------------------------------------------------------
*/

struct QTVRNodeHeaderAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	OSType 							nodeType;
	QTAtomID 						nodeID;
	QTAtomID 						nameAtomID;
	QTAtomID 						commentAtomID;

	UInt32 							reserved1;
	UInt32 							reserved2;
};
typedef struct QTVRNodeHeaderAtom QTVRNodeHeaderAtom;

typedef QTVRNodeHeaderAtom *			QTVRNodeHeaderAtomPtr;
struct QTVRAngleRangeAtom {
	Float32 						minimumAngle;
	Float32 						maximumAngle;
};
typedef struct QTVRAngleRangeAtom QTVRAngleRangeAtom;

typedef QTVRAngleRangeAtom *			QTVRAngleRangeAtomPtr;
struct QTVRHotSpotInfoAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	OSType 							hotSpotType;
	QTAtomID 						nameAtomID;
	QTAtomID 						commentAtomID;

	SInt32 							cursorID[3];

																/* canonical view for this hot spot*/
	Float32 						bestPan;
	Float32 						bestTilt;
	Float32 						bestFOV;
	QTVRFloatPoint 					bestViewCenter;

																/* Bounding box for this hot spot*/
	Rect 							hotSpotRect;

	UInt32 							flags;
	UInt32 							reserved1;
	UInt32 							reserved2;
};
typedef struct QTVRHotSpotInfoAtom QTVRHotSpotInfoAtom;

typedef QTVRHotSpotInfoAtom *			QTVRHotSpotInfoAtomPtr;
struct QTVRLinkHotSpotAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	UInt32 							toNodeID;

	UInt32 							fromValidFlags;
	Float32 						fromPan;
	Float32 						fromTilt;
	Float32 						fromFOV;
	QTVRFloatPoint 					fromViewCenter;

	UInt32 							toValidFlags;
	Float32 						toPan;
	Float32 						toTilt;
	Float32 						toFOV;
	QTVRFloatPoint 					toViewCenter;

	Float32 						distance;

	UInt32 							flags;
	UInt32 							reserved1;
	UInt32 							reserved2;
};
typedef struct QTVRLinkHotSpotAtom QTVRLinkHotSpotAtom;

typedef QTVRLinkHotSpotAtom *			QTVRLinkHotSpotAtomPtr;
/*
  =================================================================================================
   Definitions and structures used in Panorama and Object tracks
  -------------------------------------------------------------------------------------------------
*/

struct QTVRPanoSampleAtom {
	UInt16 							majorVersion;
	UInt16 							minorVersion;

	UInt32 							imageRefTrackIndex;			/* track reference index of the full res image track*/
	UInt32 							hotSpotRefTrackIndex;		/* track reference index of the full res hot spot track*/

	Float32 						minPan;
	Float32 						maxPan;
	Float32 						minTilt;
	Float32 						maxTilt;
	Float32 						minFieldOfView;
	Float32 						maxFieldOfView;

	Float32 						defaultPan;
	Float32 						defaultTilt;
	Float32 						defaultFieldOfView;

																/* Info for highest res version of image track*/
	UInt32 							imageSizeX;					/* pixel width of the panorama (e.g. 768)*/
	UInt32 							imageSizeY;					/* pixel height of the panorama (e.g. 2496)*/
	UInt16 							imageNumFramesX;			/* diced frames wide (e.g. 1)*/
	UInt16 							imageNumFramesY;			/* diced frames high (e.g. 24)*/

																/* Info for highest res version of hotSpot track*/
	UInt32 							hotSpotSizeX;				/* pixel width of the hot spot panorama (e.g. 768)*/
	UInt32 							hotSpotSizeY;				/* pixel height of the hot spot panorama (e.g. 2496)*/
	UInt16 							hotSpotNumFramesX;			/* diced frames wide (e.g. 1)*/
	UInt16 							hotSpotNumFramesY;			/* diced frames high (e.g. 24)*/

	UInt32 							flags;
	UInt32 							reserved1;
	UInt32 							reserved2;

};
typedef struct QTVRPanoSampleAtom QTVRPanoSampleAtom;

typedef QTVRPanoSampleAtom *			QTVRPanoSampleAtomPtr;
/* Special resolution value for the FastStart low resolution image track*/

enum {
	kQTVRFastStartTrackRes		= 0x8000
};

struct QTVRTrackRefEntry {
	UInt32 							trackRefType;
	UInt16 							trackResolution;
	UInt32 							trackRefIndex;
};
typedef struct QTVRTrackRefEntry QTVRTrackRefEntry;

/*
  =================================================================================================
   Object File format 2.0
  -------------------------------------------------------------------------------------------------
*/

enum {
	kQTVRObjectAnimateViewFramesOn = (1 << 0),
	kQTVRObjectPalindromeViewFramesOn = (1 << 1),
	kQTVRObjectStartFirstViewFrameOn = (1 << 2),
	kQTVRObjectAnimateViewsOn	= (1 << 3),
	kQTVRObjectPalindromeViewsOn = (1 << 4),
	kQTVRObjectSyncViewToFrameRate = (1 << 5),
	kQTVRObjectDontLoopViewFramesOn = (1 << 6)
};


enum {
	kQTVRObjectWrapPanOn		= (1 << 0),
	kQTVRObjectWrapTiltOn		= (1 << 1),
	kQTVRObjectCanZoomOn		= (1 << 2),
	kQTVRObjectReverseHControlOn = (1 << 3),
	kQTVRObjectReverseVControlOn = (1 << 4),
	kQTVRObjectSwapHVControlOn	= (1 << 5),
	kQTVRObjectTranslationOn	= (1 << 6)
};


enum {
	kGrabberScrollerUI			= 1,							/* "Object" */
	kOldJoyStickUI				= 2,							/*  "1.0 Object as Scene"     */
	kJoystickUI					= 3,							/* "Object In Scene"*/
	kGrabberUI					= 4,							/* "Grabber only"*/
	kAbsoluteUI					= 5								/* "Absolute pointer"*/
};


struct QTVRObjectSampleAtom {
	UInt16 							majorVersion;				/* kQTVRMajorVersion*/
	UInt16 							minorVersion;				/* kQTVRMinorVersion*/
	UInt16 							movieType;					/* ObjectUITypes*/
	UInt16 							viewStateCount;				/* The number of view states 1 based*/
	UInt16 							defaultViewState;			/* The default view state number. The number must be 1 to viewStateCount*/
	UInt16 							mouseDownViewState;			/* The mouse down view state.   The number must be 1 to viewStateCount*/
	UInt32 							viewDuration;				/* The duration of each view including all animation frames in a view*/
	UInt32 							columns;					/* Number of columns in movie*/
	UInt32 							rows;						/* Number rows in movie*/
	Float32 						mouseMotionScale;			/* 180.0 for kStandardObject or kQTVRObjectInScene, actual degrees for kOldNavigableMovieScene.*/
	Float32 						minPan;						/* Start   horizontal pan angle in degrees*/
	Float32 						maxPan;						/* End     horizontal pan angle in degrees*/
	Float32 						defaultPan;					/* Initial horizontal pan angle in degrees (poster view)*/
	Float32 						minTilt;					/* Start   vertical   pan angle in degrees*/
	Float32 						maxTilt;					/* End     vertical   pan angle in degrees*/
	Float32 						defaultTilt;				/* Initial vertical   pan angle in degrees (poster view)	*/
	Float32 						minFieldOfView;				/* minimum field of view setting (appears as the maximum zoom effect) must be >= 1*/
	Float32 						fieldOfView;				/* the field of view range must be >= 1*/
	Float32 						defaultFieldOfView;			/* must be in minFieldOfView and maxFieldOfView range inclusive*/
	Float32 						defaultViewCenterH;
	Float32 						defaultViewCenterV;

	Float32 						viewRate;
	Float32 						frameRate;
	UInt32 							animationSettings;			/* 32 reserved bit fields*/
	UInt32 							controlSettings;			/* 32 reserved bit fields*/

};
typedef struct QTVRObjectSampleAtom QTVRObjectSampleAtom;

typedef QTVRObjectSampleAtom *			QTVRObjectSampleAtomPtr;
#if OLDROUTINENAMES
typedef QTVRStringAtom 					VRStringAtom;
typedef QTVRWorldHeaderAtom 			VRWorldHeaderAtom;
typedef QTVRPanoImagingAtom 			VRPanoImagingAtom;
typedef QTVRNodeLocationAtom 			VRNodeLocationAtom;
typedef QTVRNodeHeaderAtom 				VRNodeHeaderAtom;
typedef QTVRAngleRangeAtom 				VRAngleRangeAtom;
typedef QTVRHotSpotInfoAtom 			VRHotSpotInfoAtom;
typedef QTVRLinkHotSpotAtom 			VRLinkHotSpotAtom;
typedef QTVRPanoSampleAtom 				VRPanoSampleAtom;
typedef QTVRTrackRefEntry 				VRTrackRefEntry;
typedef QTVRObjectSampleAtom 			VRObjectSampleAtom;
#endif  /* OLDROUTINENAMES */




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

#endif /* __QUICKTIMEVRFORMAT__ */

