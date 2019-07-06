/*
 	File:		ATSLayoutTypes.h
 
 	Contains:	Apple Text Services layout public structures and constants.
 
 	Version:	Technology:	Allegro
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __ATSLAYOUTTYPES__
#define __ATSLAYOUTTYPES__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __SFNTTYPES__
#include <SFNTTypes.h>
#endif
#ifndef __SFNTLAYOUTTYPES__
#include <SFNTLayoutTypes.h>
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

/* ----------------------------------------------------------------------------------------- */
/* CONSTANTS */
/* LineOptions flags */

enum {
	kATSLineNoLayoutOptions		= 0x00000000,
	kATSLineIsDisplayOnly		= 0x00000001,
	kATSLineHasNoHangers		= 0x00000002,
	kATSLineHasNoOpticalAlignment = 0x00000004,
	kATSLineKeepSpacesOutOfMargin = 0x00000008,
	kATSLineNoSpecialJustification = 0x00000010,
	kATSLineLastNoJustification	= 0x00000020
};

/* Miscellaneous constants */

enum {
	kATSExtendedQDScale			= 81920L,						/* fixed value of 1.25 */
	kATSCondensedQDScale		= 52428L,						/* fixed value of approx. 0.8 */
	kATSItalicQDSkew			= (1 << 16) / 4,				/* fixed value of 0.25 */
	kATSRadiansFactor			= 1144,							/* fixed value of approx. pi/180 (0.0174560546875) */
	kATSNoTracking				= (long)0x80000000,				/* negativeInfinity */
	kATSDeletedGlyphcode		= 0xFFFF,
	kATSSelectToEnd				= (long)0xFFFFFFFF,
	kATSOffsetToNoData			= (long)0xFFFFFFFF
};

/* --------------------------------------------------------------------------- */
/* TYPES */
/* --------------------------------------------------------------------------- */
typedef UInt32 							ATSLineLayoutOptions;
/*
	The JustWidthDeltaEntryOverride structure specifies values for the grow and shrink case during
	justification, both on the left and on the right. It also contains flags.  This particular structure
	is used for passing justification overrides to LLC.  For further sfnt resource 'just' table
	constants and structures, see SFNTLayoutTypes.h.
*/

struct ATSJustWidthDeltaEntryOverride {
	Fixed 							beforeGrowLimit;			/* ems AW can grow by at most on LT */
	Fixed 							beforeShrinkLimit;			/* ems AW can shrink by at most on LT */
	Fixed 							afterGrowLimit;				/* ems AW can grow by at most on RB */
	Fixed 							afterShrinkLimit;			/* ems AW can shrink by at most on RB */
	JustificationFlags 				growFlags;					/* flags controlling grow case */
	JustificationFlags 				shrinkFlags;				/* flags controlling shrink case */
};
typedef struct ATSJustWidthDeltaEntryOverride ATSJustWidthDeltaEntryOverride;
/* The JustPriorityOverrides type is an array of 4 width delta records, one per priority level override. */

typedef ATSJustWidthDeltaEntryOverride 	ATSJustPriorityWidthDeltaOverrides[4];
/* --------------------------------------------------------------------------- */

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

#endif /* __ATSLAYOUTTYPES__ */

