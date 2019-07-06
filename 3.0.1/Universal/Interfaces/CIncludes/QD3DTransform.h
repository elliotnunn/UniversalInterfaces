/******************************************************************************
 **																			 **
 ** 	Module:		QD3DTransform.h											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Transform routines 										 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1991-1997 Apple Computer, Inc. All rights reserved.	 **	
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DTransform_h
#define QD3DTransform_h

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
		#define PRAGMA_ENUM_RESET_QD3DTRANS 1
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
 **							Transform Routines							     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Transform_GetType(
	TQ3TransformObject	transform);

QD3D_EXPORT TQ3Matrix4x4 *QD3D_CALL Q3Transform_GetMatrix(
	TQ3TransformObject	transform,
	TQ3Matrix4x4		*matrix);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Transform_Submit(
	TQ3TransformObject	transform, 
	TQ3ViewObject		view);


/******************************************************************************
 **																			 **
 **							MatrixTransform Routines					     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3MatrixTransform_New(
	const TQ3Matrix4x4 	*matrix);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MatrixTransform_Submit(
	const TQ3Matrix4x4 	*matrix,
	TQ3ViewObject		view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MatrixTransform_Set(
	TQ3TransformObject	transform, 
	const TQ3Matrix4x4 	 *matrix);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MatrixTransform_Get(
	TQ3TransformObject	transform,
	TQ3Matrix4x4		*matrix);


/******************************************************************************
 **																			 **
 **							RotateTransform Data						     **
 **																			 **
 *****************************************************************************/

typedef struct TQ3RotateTransformData {
	TQ3Axis		axis;
	float		radians;
} TQ3RotateTransformData;


/******************************************************************************
 **																			 **
 **							RotateTransform Routines					     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3RotateTransform_New(
	const TQ3RotateTransformData	*data);


QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_Submit(
	const TQ3RotateTransformData	*data,
	TQ3ViewObject					view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_SetData(
	TQ3TransformObject				transform,
	const TQ3RotateTransformData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_GetData(
	TQ3TransformObject				transform,
	TQ3RotateTransformData			*data);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_SetAxis(
	TQ3TransformObject				transform,
	TQ3Axis							axis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_SetAngle(
	TQ3TransformObject				transform,
	float							radians);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_GetAxis(
	TQ3TransformObject 				renderable, 
	TQ3Axis 						*axis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateTransform_GetAngle(
	TQ3TransformObject 				transform, 
	float 							*radians);


/******************************************************************************
 **																			 **
 **					RotateAboutPointTransform Data							 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3RotateAboutPointTransformData {
	TQ3Axis			axis;
	float			radians;
	TQ3Point3D		about;
} TQ3RotateAboutPointTransformData;


/******************************************************************************
 **																			 **
 **					RotateAboutPointTransform Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3RotateAboutPointTransform_New(
	const TQ3RotateAboutPointTransformData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_Submit(
	const TQ3RotateAboutPointTransformData	*data,
	TQ3ViewObject							view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_SetData(
	TQ3TransformObject						transform,
	const TQ3RotateAboutPointTransformData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_GetData(
	TQ3TransformObject						transform,
	TQ3RotateAboutPointTransformData		*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_SetAxis(
	TQ3TransformObject						transform,
	TQ3Axis									axis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_GetAxis(
	TQ3TransformObject						transform,
	TQ3Axis									*axis);


QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_SetAngle(
	TQ3TransformObject						transform,
	float									radians);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_GetAngle(
	TQ3TransformObject						transform,
	float									*radians);


QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_SetAboutPoint(
	TQ3TransformObject						transform,
	const TQ3Point3D						*about);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutPointTransform_GetAboutPoint(
	TQ3TransformObject						transform,
	TQ3Point3D								*about);


/******************************************************************************
 **																			 **
 **					RotateAboutAxisTransform Data							 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3RotateAboutAxisTransformData {
	TQ3Point3D			origin;
	TQ3Vector3D			orientation;
	float				radians;
} TQ3RotateAboutAxisTransformData;


/******************************************************************************
 **																			 **
 **					RotateAboutAxisTransform Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3RotateAboutAxisTransform_New(
	const TQ3RotateAboutAxisTransformData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_Submit(
	const TQ3RotateAboutAxisTransformData	*data,
	TQ3ViewObject							view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_SetData(
	TQ3TransformObject						transform,
	const TQ3RotateAboutAxisTransformData	*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_GetData(
	TQ3TransformObject						transform,
	TQ3RotateAboutAxisTransformData			*data);


QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_SetOrientation(
	TQ3TransformObject						transform,
	const TQ3Vector3D						*axis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_GetOrientation(
	TQ3TransformObject						transform,
	TQ3Vector3D								*axis);


QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_SetAngle(
	TQ3TransformObject						transform,
	float									radians);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_GetAngle(
	TQ3TransformObject						transform,
	float									*radians);


QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_SetOrigin(
	TQ3TransformObject						transform,
	const TQ3Point3D							*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RotateAboutAxisTransform_GetOrigin(
	TQ3TransformObject						transform,
	TQ3Point3D								*origin);


/******************************************************************************
 **																			 **
 **							ScaleTransform Routines						     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3ScaleTransform_New(
	const TQ3Vector3D		*scale);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ScaleTransform_Submit(
	const TQ3Vector3D		*scale,
	TQ3ViewObject			view);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3ScaleTransform_Set(
	TQ3TransformObject		transform,
	const TQ3Vector3D		*scale);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ScaleTransform_Get(
	TQ3TransformObject		transform,
	TQ3Vector3D				*scale);


/******************************************************************************
 **																			 **
 **							TranslateTransform Routines					     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3TranslateTransform_New(
	const TQ3Vector3D		*translate);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TranslateTransform_Submit(
	const TQ3Vector3D		*translate,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TranslateTransform_Set(
	TQ3TransformObject		transform,
	const TQ3Vector3D		*translate);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TranslateTransform_Get(
	TQ3TransformObject		transform,
	TQ3Vector3D				*translate);


/******************************************************************************
 **																			 **
 **							QuaternionTransform Routines				     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3QuaternionTransform_New(
	const TQ3Quaternion		*quaternion);

QD3D_EXPORT TQ3Status QD3D_CALL Q3QuaternionTransform_Submit(
	const TQ3Quaternion		*quaternion,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3QuaternionTransform_Set(
	TQ3TransformObject		transform, 
	const TQ3Quaternion 	*quaternion);

QD3D_EXPORT TQ3Status QD3D_CALL Q3QuaternionTransform_Get(
	TQ3TransformObject		transform,
	TQ3Quaternion			*quaternion);


/******************************************************************************
 **																			 **
 **							ResetTransform Routines						     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TransformObject QD3D_CALL Q3ResetTransform_New(
	void);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ResetTransform_Submit(
	TQ3ViewObject			view);

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
	#if PRAGMA_ENUM_RESET_QD3DTRANS
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DTRANS
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DTransform_h  */
