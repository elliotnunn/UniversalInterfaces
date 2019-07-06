/******************************************************************************
 **																			 **
 ** 	Module:		QD3DGeometry.h											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Geometric primitives - data structures and routines		 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1991-1997 Apple Computer, Inc. All rights reserved.	 **
 **																			 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DGeometry_h
#define QD3DGeometry_h

#include "QD3D.h"
#include "QD3DSet.h"

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
		#define PRAGMA_ENUM_RESET_QD3DGEOM 1
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
 **								Geometry Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Geometry_GetType(
	TQ3GeometryObject	geometry);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Geometry_GetAttributeSet(
	TQ3GeometryObject	geometry,
	TQ3AttributeSet		*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Geometry_SetAttributeSet(
	TQ3GeometryObject	geometry,
	TQ3AttributeSet		attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Geometry_Submit(
	TQ3GeometryObject	geometry, 
	TQ3ViewObject		view);


/******************************************************************************
 **																			 **
 **							Box	Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3BoxData {
	TQ3Point3D			origin;
	TQ3Vector3D			orientation;
	TQ3Vector3D			majorAxis;
	TQ3Vector3D			minorAxis;
	TQ3AttributeSet		*faceAttributeSet;	/* Ordering : Left, right, 	*/
											/*			  front, back, 	*/
											/*			  top, bottom	*/
	TQ3AttributeSet		boxAttributeSet;
} TQ3BoxData;


/******************************************************************************
 **																			 **
 **								Box Routines							     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Box_New(
	const TQ3BoxData	*boxData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_Submit(
	const TQ3BoxData	*boxData,
	TQ3ViewObject		view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_SetData(
	TQ3GeometryObject	box, 
	const TQ3BoxData	*boxData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_GetData(
	TQ3GeometryObject	box,
	TQ3BoxData			*boxData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_EmptyData(
	TQ3BoxData			*boxData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_SetOrigin(
	TQ3GeometryObject	box,
	const TQ3Point3D	*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_SetOrientation(
	TQ3GeometryObject	box,
	const TQ3Vector3D	*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_SetMajorAxis(
	TQ3GeometryObject	box,
	const TQ3Vector3D	*majorAxis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_SetMinorAxis(
	TQ3GeometryObject	box,
	const TQ3Vector3D	*minorAxis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_GetOrigin(
	TQ3GeometryObject	box,
	TQ3Point3D			*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_GetOrientation(
	TQ3GeometryObject	box,
	TQ3Vector3D			*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_GetMajorAxis(
	TQ3GeometryObject	box,
	TQ3Vector3D			*majorAxis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_GetMinorAxis(
	TQ3GeometryObject	box,
	TQ3Vector3D			*minorAxis);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_GetFaceAttributeSet(
	TQ3GeometryObject	box,
	unsigned long		faceIndex,
	TQ3AttributeSet		*faceAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Box_SetFaceAttributeSet(
	TQ3GeometryObject	box,
	unsigned long		faceIndex,
	TQ3AttributeSet		faceAttributeSet);


/******************************************************************************
 **																			 **
 **						Cone Data Structure Definitions					 	 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3ConeData {
	TQ3Point3D			origin;
	TQ3Vector3D			orientation;
	TQ3Vector3D			majorRadius;
	TQ3Vector3D			minorRadius;
	float				uMin, uMax,
						vMin, vMax;
	TQ3EndCap			caps;
	TQ3AttributeSet		interiorAttributeSet;
	TQ3AttributeSet		faceAttributeSet;
	TQ3AttributeSet		bottomAttributeSet;
	TQ3AttributeSet		coneAttributeSet;
} TQ3ConeData;


/******************************************************************************
 **																			 **
 **								Cone Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Cone_New(
	const TQ3ConeData		*coneData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_Submit(
	const TQ3ConeData		*coneData, 
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetData(
	TQ3GeometryObject		cone, 
	const TQ3ConeData		*coneData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetData(
	TQ3GeometryObject		cone,
	TQ3ConeData				*coneData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetOrigin(
	TQ3GeometryObject		cone,
	const TQ3Point3D		*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetOrientation(
	TQ3GeometryObject		cone,
	const TQ3Vector3D		*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetMajorRadius(
	TQ3GeometryObject		cone,
	const TQ3Vector3D		*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetMinorRadius(
	TQ3GeometryObject		cone,
	const TQ3Vector3D		*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetOrigin(
	TQ3GeometryObject		cone,
	TQ3Point3D				*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetOrientation(
	TQ3GeometryObject		cone,
	TQ3Vector3D				*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetMajorRadius(
	TQ3GeometryObject		cone,
	TQ3Vector3D				*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetMinorRadius(
	TQ3GeometryObject		cone,
	TQ3Vector3D				*minorRadius);
	

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetCaps(
	TQ3GeometryObject		cone,
	TQ3EndCap				caps);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetCaps(
	TQ3GeometryObject		cone,
	TQ3EndCap				*caps);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetBottomAttributeSet(
	TQ3GeometryObject		cone,
	TQ3AttributeSet			bottomAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetBottomAttributeSet(
	TQ3GeometryObject		cone,
	TQ3AttributeSet			*bottomAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_SetFaceAttributeSet(
	TQ3GeometryObject		cone,
	TQ3AttributeSet			faceAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_GetFaceAttributeSet(
	TQ3GeometryObject		cone,
	TQ3AttributeSet			*faceAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cone_EmptyData(
	TQ3ConeData				*coneData);


/******************************************************************************
 **																			 **
 **						Cylinder Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3CylinderData {
	TQ3Point3D			origin;
	TQ3Vector3D			orientation;
	TQ3Vector3D			majorRadius;
	TQ3Vector3D			minorRadius;
	float				uMin, uMax,
						vMin, vMax;
	TQ3EndCap 			caps;
	TQ3AttributeSet		interiorAttributeSet;
	TQ3AttributeSet		topAttributeSet;
	TQ3AttributeSet		faceAttributeSet;
	TQ3AttributeSet		bottomAttributeSet;
	TQ3AttributeSet		cylinderAttributeSet;
} TQ3CylinderData;


/******************************************************************************
 **																			 **
 **							Cylinder Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Cylinder_New(
	const TQ3CylinderData	*cylinderData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_Submit(
	const TQ3CylinderData	*cylinderData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetData(
	TQ3GeometryObject		cylinder, 
	const TQ3CylinderData	*cylinderData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetData(
	TQ3GeometryObject		cylinder,
	TQ3CylinderData			*cylinderData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetOrigin(
	TQ3GeometryObject		cylinder,
	const TQ3Point3D		*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetOrientation(
	TQ3GeometryObject		cylinder,
	const TQ3Vector3D		*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetMajorRadius(
	TQ3GeometryObject		cylinder,
	const TQ3Vector3D		*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetMinorRadius(
	TQ3GeometryObject		cylinder,
	const TQ3Vector3D		*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetOrigin(
	TQ3GeometryObject		cylinder,
	TQ3Point3D				*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetOrientation(
	TQ3GeometryObject		cylinder,
	TQ3Vector3D				*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetMajorRadius(
	TQ3GeometryObject		cylinder,
	TQ3Vector3D				*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetMinorRadius(
	TQ3GeometryObject		cylinder,
	TQ3Vector3D				*minorRadius);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetCaps(
	TQ3GeometryObject		cylinder,
	TQ3EndCap				caps);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetCaps(
	TQ3GeometryObject		cylinder,
	TQ3EndCap				*caps);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetTopAttributeSet(
	TQ3GeometryObject		cylinder,
	TQ3AttributeSet			topAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetTopAttributeSet(
	TQ3GeometryObject		cylinder,
	TQ3AttributeSet			*topAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetBottomAttributeSet(
	TQ3GeometryObject		cylinder,
	TQ3AttributeSet			bottomAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetBottomAttributeSet(
	TQ3GeometryObject		cylinder,
	TQ3AttributeSet			*bottomAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_SetFaceAttributeSet(
	TQ3GeometryObject		cylinder,
	TQ3AttributeSet			faceAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_GetFaceAttributeSet(
	TQ3GeometryObject		cylinder,
	TQ3AttributeSet			*faceAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Cylinder_EmptyData(
	TQ3CylinderData			*cylinderData);


/******************************************************************************
 **																			 **
 **						Disk Data Structure Definitions						 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3DiskData {
	TQ3Point3D			origin;
	TQ3Vector3D			majorRadius;
	TQ3Vector3D 		minorRadius;
	float				uMin, uMax,
						vMin, vMax;
	TQ3AttributeSet		diskAttributeSet;
} TQ3DiskData;


/******************************************************************************
 **																			 **
 **								Disk Routines							 	 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Disk_New(
	const TQ3DiskData		*diskData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_Submit(
	const TQ3DiskData		*diskData, 
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_SetData(
	TQ3GeometryObject		disk, 
	const TQ3DiskData		*diskData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_GetData(
	TQ3GeometryObject		disk, 
	TQ3DiskData				*diskData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_SetOrigin(
	TQ3GeometryObject		disk,
	const TQ3Point3D		*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_SetMajorRadius(
	TQ3GeometryObject		disk,
	const TQ3Vector3D		*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_SetMinorRadius(
	TQ3GeometryObject		disk,
	const TQ3Vector3D		*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_GetOrigin(
	TQ3GeometryObject		disk,
	TQ3Point3D				*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_GetMajorRadius(
	TQ3GeometryObject		disk,
	TQ3Vector3D				*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_GetMinorRadius(
	TQ3GeometryObject		disk,
	TQ3Vector3D				*minorRadius);
		

QD3D_EXPORT TQ3Status QD3D_CALL Q3Disk_EmptyData(
	TQ3DiskData				*diskData);


/******************************************************************************
 **																			 **
 **							Data Structure Definitions						 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3EllipseData {
	TQ3Point3D			origin;
	TQ3Vector3D			majorRadius;
	TQ3Vector3D			minorRadius;
	float				uMin, uMax;
	TQ3AttributeSet		ellipseAttributeSet;
} TQ3EllipseData;


/******************************************************************************
 **																			 **
 **								Ellipse Routines							 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Ellipse_New(
	const TQ3EllipseData	*ellipseData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_Submit(
	const TQ3EllipseData	*ellipseData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_SetData(
	TQ3GeometryObject		ellipse, 
	const TQ3EllipseData	*ellipseData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_GetData(
	TQ3GeometryObject		ellipse,
	TQ3EllipseData			*ellipseData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_SetOrigin(
	TQ3GeometryObject		ellipse,
	const TQ3Point3D		*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_SetMajorRadius(
	TQ3GeometryObject		ellipse,
	const TQ3Vector3D		*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_SetMinorRadius(
	TQ3GeometryObject		ellipse,
	const TQ3Vector3D		*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_GetOrigin(
	TQ3GeometryObject		ellipse,
	TQ3Point3D				*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_GetMajorRadius(
	TQ3GeometryObject		ellipse,
	TQ3Vector3D				*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_GetMinorRadius(
	TQ3GeometryObject		ellipse,
	TQ3Vector3D				*minorRadius);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipse_EmptyData(
	TQ3EllipseData			*ellipseData);


/******************************************************************************
 ** 																		 **
 **							Ellipsoid Data structures						 **
 ** 																		 **
 *****************************************************************************/

typedef struct TQ3EllipsoidData {
	TQ3Point3D			origin;
	TQ3Vector3D			orientation;
	TQ3Vector3D			majorRadius;
	TQ3Vector3D			minorRadius;
	float				uMin, uMax,
						vMin, vMax;
	TQ3EndCap			caps;
	TQ3AttributeSet		interiorAttributeSet;
	TQ3AttributeSet		ellipsoidAttributeSet;
} TQ3EllipsoidData;


/******************************************************************************
 ** 																		 **
 **							Procedures   									 **
 ** 																		 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Ellipsoid_New(
	const TQ3EllipsoidData	*ellipsoidData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_Submit(
	const TQ3EllipsoidData	*ellipsoidData, 
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_SetData(
	TQ3GeometryObject		ellipsoid, 
	const TQ3EllipsoidData	*ellipsoidData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_GetData(
	TQ3GeometryObject		ellipsoid,
	TQ3EllipsoidData		*ellipsoidData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_SetOrigin(
	TQ3GeometryObject		ellipsoid,
	const TQ3Point3D		*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_SetOrientation(
	TQ3GeometryObject		ellipsoid,
	const TQ3Vector3D		*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_SetMajorRadius(
	TQ3GeometryObject		ellipsoid,
	const TQ3Vector3D		*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_SetMinorRadius(
	TQ3GeometryObject		ellipsoid,
	const TQ3Vector3D		*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_GetOrigin(
	TQ3GeometryObject		ellipsoid,
	TQ3Point3D				*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_GetOrientation(
	TQ3GeometryObject		ellipsoid,
	TQ3Vector3D				*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_GetMajorRadius(
	TQ3GeometryObject		ellipsoid,
	TQ3Vector3D				*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_GetMinorRadius(
	TQ3GeometryObject		ellipsoid,
	TQ3Vector3D				*minorRadius);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Ellipsoid_EmptyData(
	TQ3EllipsoidData		*ellipsoidData);


/******************************************************************************
 **																			 **
 **					General Polygon Data Structure Definitions				 **
 **																			 **
 *****************************************************************************/
 
typedef enum TQ3GeneralPolygonShapeHint {
	kQ3GeneralPolygonShapeHintComplex,
	kQ3GeneralPolygonShapeHintConcave,
	kQ3GeneralPolygonShapeHintConvex
} TQ3GeneralPolygonShapeHint;
 
typedef struct TQ3GeneralPolygonContourData {
	unsigned long					numVertices;		
	TQ3Vertex3D						*vertices;			
} TQ3GeneralPolygonContourData;

typedef struct TQ3GeneralPolygonData {
	unsigned long					numContours;
	TQ3GeneralPolygonContourData	*contours;
	TQ3GeneralPolygonShapeHint		shapeHint;
	TQ3AttributeSet					generalPolygonAttributeSet;
} TQ3GeneralPolygonData;


/******************************************************************************
 **																			 **
 **							General polygon Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3GeneralPolygon_New(
	const TQ3GeneralPolygonData		*generalPolygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_Submit(
     const TQ3GeneralPolygonData	*generalPolygonData,
     TQ3ViewObject					view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_SetData(
	TQ3GeometryObject				generalPolygon, 
	const TQ3GeneralPolygonData		*generalPolygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_GetData(
	TQ3GeometryObject				polygon,
	TQ3GeneralPolygonData			*generalPolygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_EmptyData(
	TQ3GeneralPolygonData			*generalPolygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_GetVertexPosition(
	TQ3GeometryObject				generalPolygon,
	unsigned long					contourIndex,
	unsigned long					pointIndex,
	TQ3Point3D						*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_SetVertexPosition(
	TQ3GeometryObject				generalPolygon,
	unsigned long					contourIndex,
	unsigned long					pointIndex,
	const TQ3Point3D				*position);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_GetVertexAttributeSet(
	TQ3GeometryObject				generalPolygon,
	unsigned long					contourIndex,
	unsigned long					pointIndex,
	TQ3AttributeSet					*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_SetVertexAttributeSet(
	TQ3GeometryObject				generalPolygon,
	unsigned long					contourIndex,
	unsigned long					pointIndex,
	TQ3AttributeSet					attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_SetShapeHint(
	TQ3GeometryObject				generalPolygon,
	TQ3GeneralPolygonShapeHint		shapeHint);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GeneralPolygon_GetShapeHint(
	TQ3GeometryObject				generalPolygon,
	TQ3GeneralPolygonShapeHint		*shapeHint);


/******************************************************************************
 **																			 **
 **						Line Data Structure Definitions						 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3LineData {
	TQ3Vertex3D			vertices[2];
	TQ3AttributeSet		lineAttributeSet;
} TQ3LineData;


/******************************************************************************
 **																			 **
 **							Line Routines									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Line_New(
	const TQ3LineData 		*lineData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_Submit(
	const TQ3LineData 		*lineData, 
	TQ3ViewObject 			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_GetData(
	TQ3GeometryObject 		line,
	TQ3LineData 			*lineData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_SetData(
	TQ3GeometryObject 		line,
	const TQ3LineData 		*lineData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_GetVertexPosition(
	TQ3GeometryObject		line,
	unsigned long			index,
	TQ3Point3D				*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_SetVertexPosition(
	TQ3GeometryObject		line,
	unsigned long			index,
	const TQ3Point3D		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_GetVertexAttributeSet(
	TQ3GeometryObject		line,
	unsigned long			index,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_SetVertexAttributeSet(
	TQ3GeometryObject		line,
	unsigned long			index,
	TQ3AttributeSet			attributeSet);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Line_EmptyData(
	TQ3LineData 			*lineData);


/******************************************************************************
 **																			 **
 **						Marker Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3MarkerData {
	TQ3Point3D			location;
	long				xOffset;
	long				yOffset;
	TQ3Bitmap			bitmap;
	TQ3AttributeSet		markerAttributeSet;
} TQ3MarkerData;


/******************************************************************************
 **																			 **
 **								Marker Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Marker_New(
	const TQ3MarkerData		*markerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_Submit(
	const TQ3MarkerData		*markerData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_SetData(
	TQ3GeometryObject		geometry, 
	const TQ3MarkerData		*markerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_GetData(
	TQ3GeometryObject		geometry,
	TQ3MarkerData			*markerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_EmptyData(
	TQ3MarkerData			*markerData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_GetPosition(
	TQ3GeometryObject		marker,
	TQ3Point3D				*location);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_SetPosition(
	TQ3GeometryObject		marker,
	const TQ3Point3D		*location);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_GetXOffset(
	TQ3GeometryObject		marker,
	long					*xOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_SetXOffset(
	TQ3GeometryObject		marker,
	long					xOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_GetYOffset(
	TQ3GeometryObject		marker,
	long					*yOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_SetYOffset(
	TQ3GeometryObject		marker,
	long					yOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_GetBitmap(
	TQ3GeometryObject		marker,
	TQ3Bitmap				*bitmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Marker_SetBitmap(
	TQ3GeometryObject		marker,
	const TQ3Bitmap			*bitmap);


/******************************************************************************
 **																			 **
 **						Mesh Data Structure Definitions						 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3MeshComponentPrivate 	*TQ3MeshComponent;
typedef struct TQ3MeshVertexPrivate 	*TQ3MeshVertex;
typedef struct TQ3MeshVertexPrivate 	*TQ3MeshFace;
typedef struct TQ3MeshEdgeRepPrivate 	*TQ3MeshEdge;
typedef struct TQ3MeshContourPrivate	*TQ3MeshContour;


/******************************************************************************
 **																			 **
 **							Mesh Routines								 	 **
 **																			 **
 *****************************************************************************/

/*
 *  Constructors
 */
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Mesh_New(
	void);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_VertexNew(
	TQ3GeometryObject	mesh,
	const TQ3Vertex3D	*vertex);
			
QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_FaceNew(
	TQ3GeometryObject	mesh,
	unsigned long		numVertices,
	const TQ3MeshVertex	*vertices,
	TQ3AttributeSet		attributeSet);

/*
 *  Destructors
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_VertexDelete( 
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_FaceDelete(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face);

/*
 * Methods
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_DelayUpdates(
	TQ3GeometryObject	mesh);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_ResumeUpdates(
	TQ3GeometryObject	mesh);
	
QD3D_EXPORT TQ3MeshContour QD3D_CALL Q3Mesh_FaceToContour(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			containerFace,
	TQ3MeshFace			face);
	
QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_ContourToFace(
	TQ3GeometryObject	mesh,
	TQ3MeshContour		contour);

/*
 * Mesh
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetNumComponents(
	TQ3GeometryObject	mesh,
	unsigned long		*numComponents);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetNumEdges(
	TQ3GeometryObject	mesh,
	unsigned long		*numEdges);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetNumVertices(
	TQ3GeometryObject	mesh,
	unsigned long		*numVertices);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetNumFaces(
	TQ3GeometryObject	mesh,
	unsigned long		*numFaces);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetNumCorners(
	TQ3GeometryObject	mesh,
	unsigned long		*numCorners);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetOrientable(
	TQ3GeometryObject	mesh,
	TQ3Boolean			*orientable);

/*
 * Component
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetComponentNumVertices(
	TQ3GeometryObject	mesh,
	TQ3MeshComponent	component,
	unsigned long		*numVertices);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetComponentNumEdges(
	TQ3GeometryObject	mesh,
	TQ3MeshComponent	component,
	unsigned long		*numEdges);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetComponentBoundingBox(
	TQ3GeometryObject	mesh,
	TQ3MeshComponent	component,
	TQ3BoundingBox		*boundingBox);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetComponentOrientable(
	TQ3GeometryObject	mesh,
	TQ3MeshComponent	component,
	TQ3Boolean			*orientable);

/*
 * Vertex
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetVertexCoordinates(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3Point3D			*coordinates);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetVertexIndex(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	unsigned long		*index);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetVertexOnBoundary(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3Boolean			*onBoundary);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetVertexComponent(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3MeshComponent	*component);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetVertexAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3AttributeSet		*attributeSet);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_SetVertexCoordinates(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	const TQ3Point3D	*coordinates);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_SetVertexAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3AttributeSet		attributeSet);

/*
 * Face
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetFaceNumVertices(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	unsigned long		*numVertices);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetFacePlaneEquation(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	TQ3PlaneEquation	*planeEquation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetFaceNumContours(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	unsigned long		*numContours);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetFaceIndex(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	unsigned long		*index);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetFaceComponent(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	TQ3MeshComponent	*component);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetFaceAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	TQ3AttributeSet		*attributeSet);


QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_SetFaceAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshFace			face,
	TQ3AttributeSet		attributeSet);

/*
 * Edge
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetEdgeVertices(
	TQ3GeometryObject	mesh,
	TQ3MeshEdge			edge,
	TQ3MeshVertex		*vertex1,
	TQ3MeshVertex		*vertex2);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetEdgeFaces(
	TQ3GeometryObject	mesh,
	TQ3MeshEdge			edge,
	TQ3MeshFace			*face1,
	TQ3MeshFace			*face2);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetEdgeOnBoundary(
	TQ3GeometryObject	mesh,
	TQ3MeshEdge			edge,
	TQ3Boolean			*onBoundary);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetEdgeComponent(
	TQ3GeometryObject	mesh,
	TQ3MeshEdge			edge,
	TQ3MeshComponent	*component);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetEdgeAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshEdge			edge,
	TQ3AttributeSet		*attributeSet);
	

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_SetEdgeAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshEdge			edge,
	TQ3AttributeSet		attributeSet);
	
/*
 * Contour
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetContourFace(
	TQ3GeometryObject	mesh,
	TQ3MeshContour		contour,
	TQ3MeshFace			*face);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetContourNumVertices(
	TQ3GeometryObject	mesh,
	TQ3MeshContour		contour,
	unsigned long		*numVertices);

/*
 * Corner
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_GetCornerAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3MeshFace			face,
	TQ3AttributeSet		*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Mesh_SetCornerAttributeSet(
	TQ3GeometryObject	mesh,
	TQ3MeshVertex		vertex,
	TQ3MeshFace			face,
	TQ3AttributeSet		attributeSet);

/*
 * Public Mesh Iterators
 */
typedef struct TQ3MeshIterator {
	void				*var1;
	void				*var2;
	void				*var3;
	struct {
		void			*field1;
		char			field2[4];
	} var4;
} TQ3MeshIterator;
 
QD3D_EXPORT TQ3MeshComponent QD3D_CALL Q3Mesh_FirstMeshComponent(
	TQ3GeometryObject	mesh,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshComponent QD3D_CALL Q3Mesh_NextMeshComponent(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_FirstComponentVertex(
	TQ3MeshComponent	component,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_NextComponentVertex(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_FirstComponentEdge(
	TQ3MeshComponent	component,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_NextComponentEdge(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_FirstMeshVertex(
	TQ3GeometryObject	mesh,
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_NextMeshVertex(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_FirstMeshFace(
	TQ3GeometryObject	mesh,
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_NextMeshFace(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_FirstMeshEdge(
	TQ3GeometryObject	mesh,
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_NextMeshEdge(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_FirstVertexEdge(
	TQ3MeshVertex		vertex,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_NextVertexEdge(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_FirstVertexVertex(
	TQ3MeshVertex		vertex,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_NextVertexVertex(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_FirstVertexFace(
	TQ3MeshVertex		vertex,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_NextVertexFace(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_FirstFaceEdge(
	TQ3MeshFace			face,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_NextFaceEdge(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_FirstFaceVertex(
	TQ3MeshFace			face,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_NextFaceVertex(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_FirstFaceFace(
	TQ3MeshFace			face,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_NextFaceFace(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshContour QD3D_CALL Q3Mesh_FirstFaceContour(
	TQ3MeshFace			face,
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshContour QD3D_CALL Q3Mesh_NextFaceContour(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_FirstContourEdge(
	TQ3MeshContour		contour,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshEdge QD3D_CALL Q3Mesh_NextContourEdge(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_FirstContourVertex(
	TQ3MeshContour		contour,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshVertex QD3D_CALL Q3Mesh_NextContourVertex(
	TQ3MeshIterator		*iterator);

QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_FirstContourFace(
	TQ3MeshContour		contour,
	TQ3MeshIterator		*iterator);
	
QD3D_EXPORT TQ3MeshFace QD3D_CALL Q3Mesh_NextContourFace(
	TQ3MeshIterator		*iterator);

#define	Q3ForEachMeshComponent(m,c,i)										\
	for ( (c) = Q3Mesh_FirstMeshComponent((m),(i));							\
		  (c);																\
		  (c) = Q3Mesh_NextMeshComponent((i)) )

#define Q3ForEachComponentVertex(c,v,i)										\
	for ( (v) = Q3Mesh_FirstComponentVertex((c),(i));						\
		  (v);																\
		  (v) = Q3Mesh_NextComponentVertex((i)) )
		  
#define Q3ForEachComponentEdge(c,e,i)										\
	for ( (e) = Q3Mesh_FirstComponentEdge((c),(i));							\
		  (e);																\
		  (e) = Q3Mesh_NextComponentEdge((i)) )

#define Q3ForEachMeshVertex(m,v,i)											\
	for ( (v) = Q3Mesh_FirstMeshVertex((m),(i));							\
		  (v);																\
		  (v) = Q3Mesh_NextMeshVertex((i)) )

#define Q3ForEachMeshFace(m,f,i)											\
	for ( (f) = Q3Mesh_FirstMeshFace((m),(i));								\
		  (f);																\
		  (f) = Q3Mesh_NextMeshFace((i)) )

#define Q3ForEachMeshEdge(m,e,i)											\
	for ( (e) = Q3Mesh_FirstMeshEdge((m),(i));								\
		  (e);																\
		  (e) = Q3Mesh_NextMeshEdge((i)) )

#define Q3ForEachVertexEdge(v,e,i)											\
	for ( (e) = Q3Mesh_FirstVertexEdge((v),(i));							\
		  (e);																\
		  (e) = Q3Mesh_NextVertexEdge((i)) )

#define Q3ForEachVertexVertex(v,n,i)										\
	for ( (n) = Q3Mesh_FirstVertexVertex((v),(i));							\
		  (n);																\
		  (n) = Q3Mesh_NextVertexVertex((i)) )

#define Q3ForEachVertexFace(v,f,i)											\
	for ( (f) = Q3Mesh_FirstVertexFace((v),(i));							\
		  (f);																\
		  (f) = Q3Mesh_NextVertexFace((i)) )

#define Q3ForEachFaceEdge(f,e,i)											\
	for ( (e) = Q3Mesh_FirstFaceEdge((f),(i));								\
		  (e);																\
		  (e) = Q3Mesh_NextFaceEdge((i)) )

#define Q3ForEachFaceVertex(f,v,i)											\
	for ( (v) = Q3Mesh_FirstFaceVertex((f),(i));							\
		  (v);																\
		  (v) = Q3Mesh_NextFaceVertex((i)) )
	
#define Q3ForEachFaceFace(f,n,i)											\
	for ( (n) = Q3Mesh_FirstFaceFace((f),(i));  							\
		  (n);																\
		  (n) = Q3Mesh_NextFaceFace((i)) )
		  
#define Q3ForEachFaceContour(f,h,i)											\
	for ( (h) = Q3Mesh_FirstFaceContour((f),(i));							\
	      (h);																\
	      (h) = Q3Mesh_NextFaceContour((i)) )

#define Q3ForEachContourEdge(h,e,i)											\
	for ( (e) = Q3Mesh_FirstContourEdge((h),(i));							\
	      (e);																\
	      (e) = Q3Mesh_NextContourEdge((i)) )

#define Q3ForEachContourVertex(h,v,i)										\
	for ( (v) = Q3Mesh_FirstContourVertex((h),(i));							\
	      (v);																\
	      (v) = Q3Mesh_NextContourVertex((i)) )

#define Q3ForEachContourFace(h,f,i)											\
	for ( (f) = Q3Mesh_FirstContourFace((h),(i));							\
	      (f);																\
	      (f) = Q3Mesh_NextContourFace((i)) )


/******************************************************************************
 **																			 **
 **							Maximum order for NURB Curves					 **
 **																			 **
 *****************************************************************************/

#define kQ3NURBCurveMaxOrder	16


/******************************************************************************
 **																			 **
 **							NURB CurveData Structure Definitions						 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3NURBCurveData {
 	unsigned long			order;
 	unsigned long			numPoints;
 	TQ3RationalPoint4D		*controlPoints;
 	float					*knots;
 	TQ3AttributeSet			curveAttributeSet;
} TQ3NURBCurveData;


/******************************************************************************
 **																			 **
 **								NURB Curve Routines							 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3NURBCurve_New(
	const TQ3NURBCurveData		*curveData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_Submit(
	const TQ3NURBCurveData		*curveData,
	TQ3ViewObject				view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_SetData(
	TQ3GeometryObject			curve, 
	const TQ3NURBCurveData		*nurbCurveData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_GetData(
	TQ3GeometryObject			curve,
	TQ3NURBCurveData			*nurbCurveData); 

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_EmptyData(
	TQ3NURBCurveData			*nurbCurveData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_SetControlPoint(
	TQ3GeometryObject			curve,
	unsigned long				pointIndex,
	const TQ3RationalPoint4D	*point4D);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_GetControlPoint(
	TQ3GeometryObject			curve,
	unsigned long				pointIndex,
	TQ3RationalPoint4D			*point4D);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_SetKnot(
	TQ3GeometryObject			curve,
	unsigned long				knotIndex,
	float						knotValue);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBCurve_GetKnot(
	TQ3GeometryObject			curve,
	unsigned long				knotIndex,
	float						*knotValue);


/******************************************************************************
 **																			 **
 **							Maximum NURB Patch Order						 **
 **																			 **
 *****************************************************************************/

#define	kQ3NURBPatchMaxOrder	11

/******************************************************************************
 **																			 **
 **						NURB Patch Data Structure Definitions				 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3NURBPatchTrimCurveData {
 	unsigned long					order;
 	unsigned long					numPoints;
 	TQ3RationalPoint3D				*controlPoints;	
	float							*knots;	
} TQ3NURBPatchTrimCurveData;

typedef struct TQ3NURBPatchTrimLoopData {
	unsigned long					numTrimCurves;
	TQ3NURBPatchTrimCurveData		*trimCurves;
} TQ3NURBPatchTrimLoopData;

typedef struct TQ3NURBPatchData {
	unsigned long			   	 	uOrder;
	unsigned long					vOrder;
	unsigned long					numRows;
	unsigned long			   	 	numColumns;	                              
	TQ3RationalPoint4D				*controlPoints;
	float					    	*uKnots; 
	float					    	*vKnots;
	unsigned long					numTrimLoops;
	TQ3NURBPatchTrimLoopData		*trimLoops;
	TQ3AttributeSet					patchAttributeSet;
} TQ3NURBPatchData;


/******************************************************************************
 **																			 **
 **								NURB Patch Routines							 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3NURBPatch_New(
	const TQ3NURBPatchData		*nurbPatchData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_Submit(
	const TQ3NURBPatchData		*nurbPatchData,
	TQ3ViewObject				view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_SetData(
	TQ3GeometryObject			nurbPatch, 
	const TQ3NURBPatchData		*nurbPatchData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_GetData(
	TQ3GeometryObject			nurbPatch, 
	TQ3NURBPatchData			*nurbPatchData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_SetControlPoint(
	TQ3GeometryObject			nurbPatch,
	unsigned long				rowIndex,
	unsigned long				columnIndex,
	const TQ3RationalPoint4D	*point4D);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_GetControlPoint(
	TQ3GeometryObject			nurbPatch,
	unsigned long				rowIndex,
	unsigned long				columnIndex,
	TQ3RationalPoint4D			*point4D);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_SetUKnot(
	TQ3GeometryObject			nurbPatch,
	unsigned long				knotIndex,
	float						knotValue);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_SetVKnot(
	TQ3GeometryObject			nurbPatch,
	unsigned long				knotIndex,
	float						knotValue);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_GetUKnot(
	TQ3GeometryObject			nurbPatch,
	unsigned long				knotIndex,
	float						*knotValue);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_GetVKnot(
	TQ3GeometryObject			nurbPatch,
	unsigned long				knotIndex,
	float						*knotValue);

QD3D_EXPORT TQ3Status QD3D_CALL Q3NURBPatch_EmptyData(
	TQ3NURBPatchData			*nurbPatchData);


/******************************************************************************
 **																			 **
 **						Pixmap Marker Data Structure Definitions			 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3PixmapMarkerData {
	TQ3Point3D			position;
	long				xOffset;
	long				yOffset;
	TQ3StoragePixmap	pixmap;
	TQ3AttributeSet		pixmapMarkerAttributeSet;
} TQ3PixmapMarkerData;


/******************************************************************************
 **																			 **
 **								Pixmap Marker Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3PixmapMarker_New(
	const TQ3PixmapMarkerData	*pixmapMarkerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_Submit(
	const TQ3PixmapMarkerData	*pixmapMarkerData,
	TQ3ViewObject				view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_SetData(
	TQ3GeometryObject			geometry, 
	const TQ3PixmapMarkerData	*pixmapMarkerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_GetData(
	TQ3GeometryObject			geometry,
	TQ3PixmapMarkerData			*pixmapMarkerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_EmptyData(
	TQ3PixmapMarkerData			*pixmapMarkerData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_GetPosition(
	TQ3GeometryObject			pixmapMarker,
	TQ3Point3D					*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_SetPosition(
	TQ3GeometryObject			pixmapMarker,
	const TQ3Point3D			*position);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_GetXOffset(
	TQ3GeometryObject			pixmapMarker,
	long						*xOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_SetXOffset(
	TQ3GeometryObject			pixmapMarker,
	long						xOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_GetYOffset(
	TQ3GeometryObject			pixmapMarker,
	long						*yOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_SetYOffset(
	TQ3GeometryObject			pixmapMarker,
	long						yOffset);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_GetPixmap(
	TQ3GeometryObject			pixmapMarker,
	TQ3StoragePixmap			*pixmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapMarker_SetPixmap(
	TQ3GeometryObject			pixmapMarker,
	const TQ3StoragePixmap		*pixmap);


/******************************************************************************
 **																			 **
 **						Point Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3PointData {
	TQ3Point3D			point;
	TQ3AttributeSet		pointAttributeSet;
} TQ3PointData;


/******************************************************************************
 **																			 **
 **								Point Routines								 **
 **																			 **
 *****************************************************************************/
	
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Point_New(
	const TQ3PointData 		*pointData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Point_Submit(
	const TQ3PointData 		*pointData,
	TQ3ViewObject 			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Point_GetData(
	TQ3GeometryObject 		point,
	TQ3PointData			*pointData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Point_SetData(
	TQ3GeometryObject 		point,
	const TQ3PointData 		*pointData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Point_EmptyData(
	TQ3PointData 			*pointData);	
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Point_SetPosition(
	TQ3GeometryObject		point,
	const TQ3Point3D		*position);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Point_GetPosition(
	TQ3GeometryObject		point,
	TQ3Point3D				*position);


/******************************************************************************
 **																			 **
 **						Polygon Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3PolygonData {
	unsigned long		numVertices;		
	TQ3Vertex3D			*vertices;			
	TQ3AttributeSet		polygonAttributeSet;
} TQ3PolygonData;


/******************************************************************************
 **																			 **
 **							Polygon Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Polygon_New(
	const TQ3PolygonData	*polygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_Submit(
	const TQ3PolygonData	*polygonData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_SetData(
	TQ3GeometryObject		polygon, 
	const TQ3PolygonData	*polygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_GetData(
	TQ3GeometryObject		polygon,
	TQ3PolygonData			*polygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_EmptyData(
	TQ3PolygonData			*polygonData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_GetVertexPosition(
	TQ3GeometryObject		polygon,
	unsigned long			index,
	TQ3Point3D				*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_SetVertexPosition(
	TQ3GeometryObject		polygon,
	unsigned long			index,
	const TQ3Point3D		*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_GetVertexAttributeSet(
	TQ3GeometryObject		polygon,
	unsigned long			index,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polygon_SetVertexAttributeSet(
	TQ3GeometryObject		polygon,
	unsigned long			index,
	TQ3AttributeSet			attributeSet);


/******************************************************************************
 **																			 **
 **						Polyhedron Data Structure Definitions				 **
 **																			 **
 *****************************************************************************/
 
typedef enum TQ3PolyhedronEdgeMasks {
	kQ3PolyhedronEdgeNone	= 0,
	kQ3PolyhedronEdge01		= 1 << 0,
	kQ3PolyhedronEdge12		= 1 << 1,
	kQ3PolyhedronEdge20		= 1 << 2,
	kQ3PolyhedronEdgeAll	= kQ3PolyhedronEdge01 	| 
							  kQ3PolyhedronEdge12	|
							  kQ3PolyhedronEdge20
} TQ3PolyhedronEdgeMasks;

typedef unsigned long TQ3PolyhedronEdge;

typedef struct TQ3PolyhedronEdgeData {
	unsigned long				vertexIndices[2];
	unsigned long				triangleIndices[2];
	TQ3AttributeSet				edgeAttributeSet;
} TQ3PolyhedronEdgeData;
	
typedef struct TQ3PolyhedronTriangleData {
	unsigned long				vertexIndices[3];
	TQ3PolyhedronEdge			edgeFlag;
	TQ3AttributeSet				triangleAttributeSet;
} TQ3PolyhedronTriangleData;

typedef struct TQ3PolyhedronData {
	unsigned long				numVertices;
	TQ3Vertex3D					*vertices;
	unsigned long				numEdges;
	TQ3PolyhedronEdgeData		*edges;
	unsigned long				numTriangles;
	TQ3PolyhedronTriangleData	*triangles;
	TQ3AttributeSet				polyhedronAttributeSet;
} TQ3PolyhedronData;


/******************************************************************************
 **																			 **
 **								Polyhedron Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Polyhedron_New(
	const TQ3PolyhedronData		*polyhedronData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_Submit(
	const TQ3PolyhedronData		*polyhedronData,
	TQ3ViewObject				view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_SetData(
	TQ3GeometryObject			polyhedron, 
	const TQ3PolyhedronData		*polyhedronData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_GetData(
	TQ3GeometryObject			polyhedron,
	TQ3PolyhedronData			*polyhedronData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_EmptyData(
	TQ3PolyhedronData			*polyhedronData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_SetVertexPosition(
	TQ3GeometryObject			polyhedron,
	unsigned long				index,
	const TQ3Point3D			*point);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_GetVertexPosition(
	TQ3GeometryObject			polyhedron,
	unsigned long				index,
	TQ3Point3D					*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_SetVertexAttributeSet(
	TQ3GeometryObject			polyhedron,
	unsigned long				index,
	TQ3AttributeSet				attributeSet);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_GetVertexAttributeSet(
	TQ3GeometryObject			polyhedron,
	unsigned long				index,
	TQ3AttributeSet				*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_GetTriangleData(
	TQ3GeometryObject				polyhedron,
	unsigned long					triangleIndex,
	TQ3PolyhedronTriangleData		*triangleData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_SetTriangleData(
	TQ3GeometryObject				polyhedron,
	unsigned long					triangleIndex,
	const TQ3PolyhedronTriangleData	*triangleData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_GetEdgeData(
	TQ3GeometryObject			polyhedron,
	unsigned long				edgeIndex,
	TQ3PolyhedronEdgeData		*edgeData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Polyhedron_SetEdgeData(
	TQ3GeometryObject			polyhedron,
	unsigned long				edgeIndex,
	const TQ3PolyhedronEdgeData	*edgeData);


/******************************************************************************
 **																			 **
 **						PolyLine Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3PolyLineData {
	unsigned long   	numVertices;			
	TQ3Vertex3D			*vertices;				
	TQ3AttributeSet		*segmentAttributeSet;		
	TQ3AttributeSet		polyLineAttributeSet;		
} TQ3PolyLineData;
	

/******************************************************************************
 **																			 **
 **							PolyLine Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3PolyLine_New(
	const TQ3PolyLineData	*polylineData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_Submit(
	const TQ3PolyLineData	*polyLineData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_SetData(
	TQ3GeometryObject		polyLine, 
	const TQ3PolyLineData	*polyLineData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_GetData(
	TQ3GeometryObject		polyLine,
	TQ3PolyLineData			*polyLineData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_EmptyData(
	TQ3PolyLineData			*polyLineData);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_GetVertexPosition(
	TQ3GeometryObject		polyLine,
	unsigned long			index,
	TQ3Point3D				*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_SetVertexPosition(
	TQ3GeometryObject		polyLine,
	unsigned long			index,
	const TQ3Point3D		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_GetVertexAttributeSet(
	TQ3GeometryObject		polyLine,
	unsigned long			index,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_SetVertexAttributeSet(
	TQ3GeometryObject		polyLine,
	unsigned long			index,
	TQ3AttributeSet			attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_GetSegmentAttributeSet(
	TQ3GeometryObject		polyLine,
	unsigned long			index,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PolyLine_SetSegmentAttributeSet(
	TQ3GeometryObject		polyLine,
	unsigned long			index,
	TQ3AttributeSet			attributeSet);


/******************************************************************************
 **																			 **
 **						Torus Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/
	
typedef struct TQ3TorusData {
	TQ3Point3D			origin;
	TQ3Vector3D			orientation;
	TQ3Vector3D			majorRadius;
	TQ3Vector3D			minorRadius;
	float				ratio;
	float				uMin, uMax,
						vMin, vMax;
	TQ3EndCap			caps;
	TQ3AttributeSet		interiorAttributeSet;
	TQ3AttributeSet		torusAttributeSet;
} TQ3TorusData;


/******************************************************************************
 **																			 **
 **								Torus Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Torus_New(
	const TQ3TorusData		*torusData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_Submit(
	const TQ3TorusData		*torusData, 
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_SetData(
	TQ3GeometryObject		torus, 
	const TQ3TorusData		*torusData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_GetData(
	TQ3GeometryObject		torus, 
	TQ3TorusData			*torusData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_SetOrigin(
	TQ3GeometryObject		torus,
	const TQ3Point3D		*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_SetOrientation(
	TQ3GeometryObject		torus,
	const TQ3Vector3D		*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_SetMajorRadius(
	TQ3GeometryObject		torus,
	const TQ3Vector3D		*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_SetMinorRadius(
	TQ3GeometryObject		torus,
	const TQ3Vector3D		*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_SetRatio(
	TQ3GeometryObject		torus,
	float					ratio);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_GetOrigin(
	TQ3GeometryObject		torus,
	TQ3Point3D				*origin);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_GetOrientation(
	TQ3GeometryObject		torus,
	TQ3Vector3D				*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_GetMajorRadius(
	TQ3GeometryObject		torus,
	TQ3Vector3D				*majorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_GetMinorRadius(
	TQ3GeometryObject		torus,
	TQ3Vector3D				*minorRadius);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_GetRatio(
	TQ3GeometryObject		torus,
 	float					*ratio);
 	

QD3D_EXPORT TQ3Status QD3D_CALL Q3Torus_EmptyData(
	TQ3TorusData			*torusData);


/******************************************************************************
 **																			 **
 **						Triangle Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3TriangleData {
	TQ3Vertex3D			vertices[3];
	TQ3AttributeSet		triangleAttributeSet;
} TQ3TriangleData;


/******************************************************************************
 **																			 **
 **							Triangle Routines								 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3Triangle_New(
	const TQ3TriangleData	*triangleData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_Submit(
	const TQ3TriangleData	*triangleData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_SetData(
	TQ3GeometryObject		triangle, 
	const TQ3TriangleData	*triangleData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_GetData(
	TQ3GeometryObject		triangle,
	TQ3TriangleData			*triangleData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_EmptyData(
	TQ3TriangleData			*triangleData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_GetVertexPosition(
	TQ3GeometryObject		triangle,
	unsigned long			index,
	TQ3Point3D				*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_SetVertexPosition(
	TQ3GeometryObject		triangle,
	unsigned long			index,
	const TQ3Point3D		*point);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_GetVertexAttributeSet(
	TQ3GeometryObject		triangle,
	unsigned long			index,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Triangle_SetVertexAttributeSet(
	TQ3GeometryObject		triangle,
	unsigned long		 	index,
	TQ3AttributeSet		 	attributeSet);


/******************************************************************************
 **																			 **
 **						TriGrid Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3TriGridData {
	unsigned long		numRows;			
	unsigned long		numColumns;
	TQ3Vertex3D			*vertices;			
	TQ3AttributeSet		*facetAttributeSet;
	TQ3AttributeSet		triGridAttributeSet;
} TQ3TriGridData;


/******************************************************************************
 **																			 **
 **								TriGrid Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3TriGrid_New(
	const TQ3TriGridData	*triGridData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_Submit(
	const TQ3TriGridData	*triGridData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_SetData(
	TQ3GeometryObject		triGrid, 
	const TQ3TriGridData	*triGridData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_GetData(
	TQ3GeometryObject		triGrid,
	TQ3TriGridData			*triGridData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_EmptyData(
	TQ3TriGridData			*triGridData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_GetVertexPosition(
	TQ3GeometryObject		triGrid,
	unsigned long			rowIndex,
	unsigned long			columnIndex,
	TQ3Point3D				*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_SetVertexPosition(
	TQ3GeometryObject		triGrid,
	unsigned long			rowIndex,
	unsigned long			columnIndex,
	const TQ3Point3D		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_GetVertexAttributeSet(
	TQ3GeometryObject		triGrid,
	unsigned long			rowIndex,
	unsigned long			columnIndex,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_SetVertexAttributeSet(
	TQ3GeometryObject		triGrid,
	unsigned long			rowIndex,
	unsigned long			columnIndex,
	TQ3AttributeSet			attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_GetFacetAttributeSet(
	TQ3GeometryObject		triGrid,
	unsigned long			faceIndex,
	TQ3AttributeSet			*facetAttributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriGrid_SetFacetAttributeSet(
	TQ3GeometryObject		triGrid,
	unsigned long			faceIndex,
	TQ3AttributeSet			facetAttributeSet);


/******************************************************************************
 **																			 **
 **						TriMesh Data Structure Definitions					 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3TriMeshTriangleData {
	unsigned long		pointIndices[3];
} TQ3TriMeshTriangleData;

typedef struct TQ3TriMeshEdgeData {
	unsigned long		pointIndices[2];
	unsigned long		triangleIndices[2];
} TQ3TriMeshEdgeData;

typedef struct TQ3TriMeshAttributeData {
	TQ3AttributeType	attributeType;		/* The type of attribute 		 */
	void				*data;				/* Pointer to the contiguous     */
											/* attribute data.				 */
	char				*attributeUseArray; /* This is only used with custom */
											/* attributes 					 */
} TQ3TriMeshAttributeData;

typedef struct TQ3TriMeshData {
	TQ3AttributeSet				triMeshAttributeSet;
	
	unsigned long				numTriangles;
	TQ3TriMeshTriangleData		*triangles;
	
	unsigned long				numTriangleAttributeTypes;
	TQ3TriMeshAttributeData		*triangleAttributeTypes;
	
	unsigned long				numEdges;
	TQ3TriMeshEdgeData			*edges;
	
	unsigned long				numEdgeAttributeTypes;
	TQ3TriMeshAttributeData		*edgeAttributeTypes;
	
	unsigned long				numPoints;
	TQ3Point3D					*points;
	
	unsigned long				numVertexAttributeTypes;
	TQ3TriMeshAttributeData		*vertexAttributeTypes;

	TQ3BoundingBox				bBox;
} TQ3TriMeshData;


/******************************************************************************
 **																			 **
 **							TriMesh Routines								 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3GeometryObject QD3D_CALL Q3TriMesh_New(
	const TQ3TriMeshData	*triMeshData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriMesh_Submit(
	const TQ3TriMeshData	*triMeshData,
	TQ3ViewObject			view);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3TriMesh_SetData(
	TQ3GeometryObject		triMesh, 
	const TQ3TriMeshData	*triMeshData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriMesh_GetData(
	TQ3GeometryObject		triMesh,
	TQ3TriMeshData			*triMeshData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TriMesh_EmptyData(
	TQ3TriMeshData			*triMeshData);
	

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
	#if PRAGMA_ENUM_RESET_QD3DGEOM
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DGEOM
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /* QD3DGeometry_h  */
