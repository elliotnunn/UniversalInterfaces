/******************************************************************************
 **																			 **
 ** 	Module:		QD3DPick.h												 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Public picking routines 								 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DPick_h
#define QD3DPick_h

#include "QD3D.h"
#include "QD3DStyle.h"
#include "QD3DGeometry.h"

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
		#define PRAGMA_ENUM_RESET_QD3DPICK 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */

#ifdef __cplusplus
extern "C" {
#endif  /*  __cplusplus  */


/*****************************************************************************
 **																			**
 **							Mask bits for hit information 					**
 **																			**
 *****************************************************************************/

typedef enum TQ3PickDetailMasks {
	kQ3PickDetailNone					= 0,
	kQ3PickDetailMaskPickID 			= 1 << 0,
	kQ3PickDetailMaskPath 				= 1 << 1,
	kQ3PickDetailMaskObject 			= 1 << 2,
	kQ3PickDetailMaskLocalToWorldMatrix	= 1 << 3,
	kQ3PickDetailMaskXYZ 				= 1 << 4,
	kQ3PickDetailMaskDistance 			= 1 << 5,
	kQ3PickDetailMaskNormal 			= 1 << 6,
	kQ3PickDetailMaskShapePart	 		= 1 << 7,
	kQ3PickDetailMaskPickPart 			= 1 << 8,
	kQ3PickDetailMaskUV 				= 1 << 9
} TQ3PickDetailMasks;

typedef unsigned long TQ3PickDetail;


/******************************************************************************
 **																			 **
 **								Hitlist sorting								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3PickSort {
	kQ3PickSortNone,
	kQ3PickSortNearToFar,
	kQ3PickSortFarToNear
} TQ3PickSort;


/******************************************************************************
 **																			 **
 **					Data structures to set up the pick object				 **
 **																			 **
 *****************************************************************************/
 
#define kQ3ReturnAllHits		0

typedef struct TQ3PickData {
	TQ3PickSort			sort;
	TQ3PickDetail		mask;
	unsigned long		numHitsToReturn;
} TQ3PickData;

typedef struct TQ3WindowPointPickData {
	TQ3PickData			data;
	TQ3Point2D			point;
	float				vertexTolerance;
	float				edgeTolerance;
} TQ3WindowPointPickData;

typedef struct TQ3WindowRectPickData {
	TQ3PickData			data;
	TQ3Area				rect;
} TQ3WindowRectPickData;


/******************************************************************************
 **																			 **
 **									Hit data								 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3HitPath {
	TQ3GroupObject			rootGroup;
	unsigned long 			depth;
	TQ3GroupPosition		*positions;
} TQ3HitPath;


/******************************************************************************
 **																			 **
 **								Pick class methods							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Pick_GetType(
	TQ3PickObject		pick);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_GetData(
	TQ3PickObject		pick,
	TQ3PickData			*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_SetData(
	TQ3PickObject		pick,
	const TQ3PickData	*data);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_GetVertexTolerance(
	TQ3PickObject		pick,
	float				*vertexTolerance);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_GetEdgeTolerance(
	TQ3PickObject		pick,
	float				*edgeTolerance);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_SetVertexTolerance(
	TQ3PickObject		pick,
	float				vertexTolerance);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_SetEdgeTolerance(
	TQ3PickObject		pick,
	float				edgeTolerance);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_GetNumHits(
	TQ3PickObject		pick,
	unsigned long		*numHits);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_EmptyHitList(
	TQ3PickObject		pick);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_GetPickDetailValidMask(
	TQ3PickObject		pick,
	unsigned long		index,
	TQ3PickDetail		*pickDetailValidMask);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Pick_GetPickDetailData(
	TQ3PickObject		pick,
	unsigned long		index,
	TQ3PickDetail		pickDetailValue,
	void				*detailData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3HitPath_EmptyData(
	TQ3HitPath			*hitPath);

	
/******************************************************************************
 **																			 **
 **							Window point pick methods						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3PickObject QD3D_CALL Q3WindowPointPick_New(
	const TQ3WindowPointPickData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowPointPick_GetPoint(
	TQ3PickObject					pick,
	TQ3Point2D						*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowPointPick_SetPoint(
	TQ3PickObject					pick,
	const TQ3Point2D				*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowPointPick_GetData(
	TQ3PickObject					pick,
	TQ3WindowPointPickData			*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowPointPick_SetData(
	TQ3PickObject					pick,
	const TQ3WindowPointPickData	*data);


/******************************************************************************
 **																			 **
 **							Window rect pick methods						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3PickObject QD3D_CALL Q3WindowRectPick_New(
	const TQ3WindowRectPickData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowRectPick_GetRect(
	TQ3PickObject				pick,
	TQ3Area						*rect);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowRectPick_SetRect(
	TQ3PickObject				pick,
	const TQ3Area				*rect);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowRectPick_GetData(
	TQ3PickObject				pick,
	TQ3WindowRectPickData		*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3WindowRectPick_SetData(
	TQ3PickObject				pick,
	const TQ3WindowRectPickData	*data);




/******************************************************************************
 **																			 **
 **								Shape Part methods							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3ShapePart_GetType(
	TQ3ShapePartObject			shapePartObject);

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3MeshPart_GetType(
	TQ3MeshPartObject			meshPartObject);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ShapePart_GetShape(
	TQ3ShapePartObject			shapePartObject,
	TQ3ShapeObject				*shapeObject);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MeshPart_GetComponent(
	TQ3MeshPartObject			meshPartObject,
	TQ3MeshComponent			*component);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MeshFacePart_GetFace(
	TQ3MeshFacePartObject		meshFacePartObject,
	TQ3MeshFace					*face);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MeshEdgePart_GetEdge(
	TQ3MeshEdgePartObject		meshEdgePartObject,
	TQ3MeshEdge					*edge);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MeshVertexPart_GetVertex(
	TQ3MeshVertexPartObject		meshVertexPartObject,
	TQ3MeshVertex				*vertex);

#ifdef __cplusplus
}
#endif  /*  __cplusplus  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DPICK
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DPICK
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DPick_h  */
