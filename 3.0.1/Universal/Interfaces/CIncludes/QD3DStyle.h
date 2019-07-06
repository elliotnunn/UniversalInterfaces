/******************************************************************************
 **																			 **
 ** 	Module:		QD3DStyle.h												 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Style types and routines		 						 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DStyle_h
#define QD3DStyle_h

#include "QD3D.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DSTYLE 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */


/******************************************************************************
 **																			 **
 **							Style Base Class Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Style_GetType(
	TQ3StyleObject			style);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Style_Submit(
	TQ3StyleObject			style, 
	TQ3ViewObject			view);


/******************************************************************************
 **																			 **
 **								 Subdivision								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3SubdivisionMethod {
	kQ3SubdivisionMethodConstant,
	kQ3SubdivisionMethodWorldSpace,
	kQ3SubdivisionMethodScreenSpace
} TQ3SubdivisionMethod;

 
typedef struct TQ3SubdivisionStyleData {
	TQ3SubdivisionMethod			method;
	float							c1;
	float							c2;
} TQ3SubdivisionStyleData;


QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3SubdivisionStyle_New(
	const TQ3SubdivisionStyleData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3SubdivisionStyle_Submit(
	const TQ3SubdivisionStyleData	*data,
	TQ3ViewObject					view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3SubdivisionStyle_SetData(
	TQ3StyleObject					subdiv,
	const TQ3SubdivisionStyleData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3SubdivisionStyle_GetData(
	TQ3StyleObject					subdiv,
	TQ3SubdivisionStyleData			*data);


/******************************************************************************
 **																			 **
 **								Pick ID										 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3PickIDStyle_New(
	unsigned long			id);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3PickIDStyle_Submit(
	unsigned long			id,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PickIDStyle_Get(
	TQ3StyleObject			pickIDObject,
	unsigned long			*id);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PickIDStyle_Set(
	TQ3StyleObject			pickIDObject,
	unsigned long			id);
	
	
/******************************************************************************
 **																			 **
 **								Pick Parts									 **
 **																			 **
 *****************************************************************************/
 
typedef enum TQ3PickPartsMasks {
	kQ3PickPartsObject		= 0,
	kQ3PickPartsMaskFace	= 1 << 0,
	kQ3PickPartsMaskEdge	= 1 << 1,
	kQ3PickPartsMaskVertex	= 1 << 2
} TQ3PickPartsMasks;

typedef unsigned long TQ3PickParts;

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3PickPartsStyle_New(
	TQ3PickParts			parts);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3PickPartsStyle_Submit(
	TQ3PickParts			parts,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PickPartsStyle_Get(
	TQ3StyleObject			pickPartsObject,
	TQ3PickParts			*parts);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PickPartsStyle_Set(
	TQ3StyleObject			pickPartsObject,
	TQ3PickParts			parts);


/******************************************************************************
 **																			 **
 **							Receive Shadows									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3ReceiveShadowsStyle_New(
	TQ3Boolean				receives);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3ReceiveShadowsStyle_Submit(
	TQ3Boolean				receives,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ReceiveShadowsStyle_Get(
	TQ3StyleObject			styleObject,
	TQ3Boolean				*receives);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ReceiveShadowsStyle_Set(
	TQ3StyleObject			styleObject,
	TQ3Boolean				receives);


/******************************************************************************
 **																			 **
 **							Fill Styles										 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3FillStyle {
	kQ3FillStyleFilled,
	kQ3FillStyleEdges,
	kQ3FillStylePoints
} TQ3FillStyle;


QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3FillStyle_New(
	TQ3FillStyle 			fillStyle);

QD3D_EXPORT TQ3Status QD3D_CALL Q3FillStyle_Submit(
	TQ3FillStyle 			fillStyle,
	TQ3ViewObject 			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3FillStyle_Get(
	TQ3StyleObject			styleObject,
	TQ3FillStyle			*fillStyle);

QD3D_EXPORT TQ3Status QD3D_CALL Q3FillStyle_Set(
	TQ3StyleObject			styleObject,
	TQ3FillStyle			fillStyle);
	
	
/******************************************************************************
 **																			 **
 **							Backfacing Styles								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3BackfacingStyle {
	kQ3BackfacingStyleBoth,
	kQ3BackfacingStyleRemove,
	kQ3BackfacingStyleFlip
} TQ3BackfacingStyle;

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3BackfacingStyle_New(
	TQ3BackfacingStyle		backfacingStyle);

QD3D_EXPORT TQ3Status QD3D_CALL Q3BackfacingStyle_Submit(
	TQ3BackfacingStyle		backfacingStyle,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3BackfacingStyle_Get(
	TQ3StyleObject			backfacingObject,
	TQ3BackfacingStyle		*backfacingStyle);

QD3D_EXPORT TQ3Status QD3D_CALL Q3BackfacingStyle_Set(
	TQ3StyleObject			backfacingObject,
	TQ3BackfacingStyle		backfacingStyle);


/******************************************************************************
 **																			 **
 **							Interpolation Types								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3InterpolationStyle {
	kQ3InterpolationStyleNone,
	kQ3InterpolationStyleVertex,
	kQ3InterpolationStylePixel
} TQ3InterpolationStyle;

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3InterpolationStyle_New(
	TQ3InterpolationStyle	interpolationStyle);

QD3D_EXPORT TQ3Status QD3D_CALL Q3InterpolationStyle_Submit(
	TQ3InterpolationStyle 	interpolationStyle,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3InterpolationStyle_Get(
	TQ3StyleObject			interpolationObject,
	TQ3InterpolationStyle	*interpolationStyle);

QD3D_EXPORT TQ3Status QD3D_CALL Q3InterpolationStyle_Set(
	TQ3StyleObject			interpolationObject,
	TQ3InterpolationStyle	interpolationStyle);


/******************************************************************************
 **																			 **
 **								Highlight Style								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3HighlightStyle_New(
	TQ3AttributeSet			highlightAttribute);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3HighlightStyle_Submit(
	TQ3AttributeSet			highlightAttribute,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3HighlightStyle_Get(
	TQ3StyleObject			highlight,
	TQ3AttributeSet			*highlightAttribute);

QD3D_EXPORT TQ3Status QD3D_CALL Q3HighlightStyle_Set(
	TQ3StyleObject			highlight,
	TQ3AttributeSet			highlightAttribute);


/******************************************************************************
 **																			 **
 **							FrontFacing Direction Styles					 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3OrientationStyle {
	kQ3OrientationStyleCounterClockwise,
	kQ3OrientationStyleClockwise
} TQ3OrientationStyle;

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3OrientationStyle_New(
	TQ3OrientationStyle		frontFacingDirection);

QD3D_EXPORT TQ3Status QD3D_CALL Q3OrientationStyle_Submit(
	TQ3OrientationStyle		frontFacingDirection,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3OrientationStyle_Get(
	TQ3StyleObject			frontFacingDirectionObject,
	TQ3OrientationStyle		*frontFacingDirection);

QD3D_EXPORT TQ3Status QD3D_CALL Q3OrientationStyle_Set(
	TQ3StyleObject			frontFacingDirectionObject,
	TQ3OrientationStyle		frontFacingDirection);


/******************************************************************************
 **																			 **
 **								AntiAlias Style								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3AntiAliasModeMasks {
	kQ3AntiAliasModeMaskEdges	= 1 << 0,
	kQ3AntiAliasModeMaskFilled	= 1 << 1
} TQ3AntiAliasModeMasks;

typedef unsigned long TQ3AntiAliasMode;

typedef struct TQ3AntiAliasStyleData {
	TQ3Switch					state;
	TQ3AntiAliasMode			mode;
	float						quality;
} TQ3AntiAliasStyleData;

QD3D_EXPORT TQ3StyleObject QD3D_CALL Q3AntiAliasStyle_New(
	const TQ3AntiAliasStyleData		*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AntiAliasStyle_Submit(
	const TQ3AntiAliasStyleData		*data,
	TQ3ViewObject					view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AntiAliasStyle_GetData(
	TQ3StyleObject					styleObject,
	TQ3AntiAliasStyleData			*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AntiAliasStyle_SetData(
	TQ3StyleObject					styleObject,
	const TQ3AntiAliasStyleData		*data);


#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DSTYLE
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DSTYLE
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DStyle_h  */
