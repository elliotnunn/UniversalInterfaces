{
 	File:		QD3DGeometry.p
 
 	Contains:	Q3Geometry methods										
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DGeometry;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DGEOMETRY__}
{$SETC __QD3DGEOMETRY__ := 1}

{$I+}
{$SETC QD3DGeometryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}

{$IFC UNDEFINED __QD3DSET__}
{$I QD3DSet.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **																			 **
 **								Geometry Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Geometry_GetType(geometry: TQ3GeometryObject): LONGINT; C;
FUNCTION Q3Geometry_GetAttributeSet(geometry: TQ3GeometryObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Geometry_SetAttributeSet(geometry: TQ3GeometryObject; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Geometry_Submit(geometry: TQ3GeometryObject; view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **																			 **
 **							Box	Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3AttributeSetArray				= ARRAY [0..5] OF TQ3AttributeSet;
	TQ3AttributeSetArrayPtr				= ^TQ3AttributeSetArray;
	TQ3BoxDataPtr = ^TQ3BoxData;
	TQ3BoxData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		majorAxis:				TQ3Vector3D;
		minorAxis:				TQ3Vector3D;
		faceAttributeSet:		TQ3AttributeSetArrayPtr;				{  Ordering : Left, right, 	 }
																		{ 			  front, back, 	 }
																		{ 			  top, bottom	 }
		boxAttributeSet:		TQ3AttributeSet;
	END;


{*****************************************************************************
 **																			 **
 **								Box Routines							     **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Box_New({CONST}VAR boxData: TQ3BoxData): TQ3GeometryObject; C;
FUNCTION Q3Box_Submit({CONST}VAR boxData: TQ3BoxData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Box_SetData(box: TQ3GeometryObject; {CONST}VAR boxData: TQ3BoxData): TQ3Status; C;
FUNCTION Q3Box_GetData(box: TQ3GeometryObject; VAR boxData: TQ3BoxData): TQ3Status; C;
FUNCTION Q3Box_EmptyData(VAR boxData: TQ3BoxData): TQ3Status; C;
FUNCTION Q3Box_SetOrigin(box: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Box_SetOrientation(box: TQ3GeometryObject; {CONST}VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_SetMajorAxis(box: TQ3GeometryObject; {CONST}VAR majorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_SetMinorAxis(box: TQ3GeometryObject; {CONST}VAR minorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetOrigin(box: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Box_GetOrientation(box: TQ3GeometryObject; VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetMajorAxis(box: TQ3GeometryObject; VAR majorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetMinorAxis(box: TQ3GeometryObject; VAR minorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetFaceAttributeSet(box: TQ3GeometryObject; faceIndex: UInt32; VAR faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Box_SetFaceAttributeSet(box: TQ3GeometryObject; faceIndex: UInt32; faceAttributeSet: TQ3AttributeSet): TQ3Status; C;


{*****************************************************************************
 **																			 **
 **						Cone Data Structure Definitions					 	 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3ConeDataPtr = ^TQ3ConeData;
	TQ3ConeData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		majorRadius:			TQ3Vector3D;
		minorRadius:			TQ3Vector3D;
		uMin:					Single;
		uMax:					Single;
		vMin:					Single;
		vMax:					Single;
		caps:					TQ3EndCap;
		interiorAttributeSet:	TQ3AttributeSet;
		faceAttributeSet:		TQ3AttributeSet;
		bottomAttributeSet:		TQ3AttributeSet;
		coneAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Cone Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Cone_New({CONST}VAR coneData: TQ3ConeData): TQ3GeometryObject; C;
FUNCTION Q3Cone_Submit({CONST}VAR coneData: TQ3ConeData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Cone_SetData(cone: TQ3GeometryObject; {CONST}VAR coneData: TQ3ConeData): TQ3Status; C;
FUNCTION Q3Cone_GetData(cone: TQ3GeometryObject; VAR coneData: TQ3ConeData): TQ3Status; C;
FUNCTION Q3Cone_SetOrigin(cone: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Cone_SetOrientation(cone: TQ3GeometryObject; {CONST}VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cone_SetMajorRadius(cone: TQ3GeometryObject; {CONST}VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cone_SetMinorRadius(cone: TQ3GeometryObject; {CONST}VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cone_GetOrigin(cone: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Cone_GetOrientation(cone: TQ3GeometryObject; VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cone_GetMajorRadius(cone: TQ3GeometryObject; VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cone_GetMinorRadius(cone: TQ3GeometryObject; VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cone_SetCaps(cone: TQ3GeometryObject; caps: TQ3EndCap): TQ3Status; C;
FUNCTION Q3Cone_GetCaps(cone: TQ3GeometryObject; VAR caps: TQ3EndCap): TQ3Status; C;
FUNCTION Q3Cone_SetBottomAttributeSet(cone: TQ3GeometryObject; bottomAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cone_GetBottomAttributeSet(cone: TQ3GeometryObject; VAR bottomAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cone_SetFaceAttributeSet(cone: TQ3GeometryObject; faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cone_GetFaceAttributeSet(cone: TQ3GeometryObject; VAR faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cone_EmptyData(VAR coneData: TQ3ConeData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Cylinder Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3CylinderDataPtr = ^TQ3CylinderData;
	TQ3CylinderData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		majorRadius:			TQ3Vector3D;
		minorRadius:			TQ3Vector3D;
		uMin:					Single;
		uMax:					Single;
		vMin:					Single;
		vMax:					Single;
		caps:					TQ3EndCap;
		interiorAttributeSet:	TQ3AttributeSet;
		topAttributeSet:		TQ3AttributeSet;
		faceAttributeSet:		TQ3AttributeSet;
		bottomAttributeSet:		TQ3AttributeSet;
		cylinderAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **							Cylinder Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Cylinder_New({CONST}VAR cylinderData: TQ3CylinderData): TQ3GeometryObject; C;
FUNCTION Q3Cylinder_Submit({CONST}VAR cylinderData: TQ3CylinderData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Cylinder_SetData(cylinder: TQ3GeometryObject; {CONST}VAR cylinderData: TQ3CylinderData): TQ3Status; C;
FUNCTION Q3Cylinder_GetData(cylinder: TQ3GeometryObject; VAR cylinderData: TQ3CylinderData): TQ3Status; C;
FUNCTION Q3Cylinder_SetOrigin(cylinder: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Cylinder_SetOrientation(cylinder: TQ3GeometryObject; {CONST}VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cylinder_SetMajorRadius(cylinder: TQ3GeometryObject; {CONST}VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cylinder_SetMinorRadius(cylinder: TQ3GeometryObject; {CONST}VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cylinder_GetOrigin(cylinder: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Cylinder_GetOrientation(cylinder: TQ3GeometryObject; VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cylinder_GetMajorRadius(cylinder: TQ3GeometryObject; VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Cylinder_GetMinorRadius(cylinder: TQ3GeometryObject; VAR minorRadius: TQ3Vector3D): TQ3Status; C;

FUNCTION Q3Cylinder_SetCaps(cylinder: TQ3GeometryObject; caps: TQ3EndCap): TQ3Status; C;
FUNCTION Q3Cylinder_GetCaps(cylinder: TQ3GeometryObject; VAR caps: TQ3EndCap): TQ3Status; C;

FUNCTION Q3Cylinder_SetTopAttributeSet(cylinder: TQ3GeometryObject; topAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cylinder_GetTopAttributeSet(cylinder: TQ3GeometryObject; VAR topAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cylinder_SetBottomAttributeSet(cylinder: TQ3GeometryObject; bottomAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cylinder_GetBottomAttributeSet(cylinder: TQ3GeometryObject; VAR bottomAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cylinder_SetFaceAttributeSet(cylinder: TQ3GeometryObject; faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cylinder_GetFaceAttributeSet(cylinder: TQ3GeometryObject; VAR faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Cylinder_EmptyData(VAR cylinderData: TQ3CylinderData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Disk Data Structure Definitions						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3DiskDataPtr = ^TQ3DiskData;
	TQ3DiskData = RECORD
		origin:					TQ3Point3D;
		majorRadius:			TQ3Vector3D;
		minorRadius:			TQ3Vector3D;
		uMin:					Single;
		uMax:					Single;
		vMin:					Single;
		vMax:					Single;
		diskAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Disk Routines							 	 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Disk_New({CONST}VAR diskData: TQ3DiskData): TQ3GeometryObject; C;
FUNCTION Q3Disk_Submit({CONST}VAR diskData: TQ3DiskData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Disk_SetData(disk: TQ3GeometryObject; {CONST}VAR diskData: TQ3DiskData): TQ3Status; C;
FUNCTION Q3Disk_GetData(disk: TQ3GeometryObject; VAR diskData: TQ3DiskData): TQ3Status; C;
FUNCTION Q3Disk_SetOrigin(disk: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Disk_SetMajorRadius(disk: TQ3GeometryObject; {CONST}VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Disk_SetMinorRadius(disk: TQ3GeometryObject; {CONST}VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Disk_GetOrigin(disk: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Disk_GetMajorRadius(disk: TQ3GeometryObject; VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Disk_GetMinorRadius(disk: TQ3GeometryObject; VAR minorRadius: TQ3Vector3D): TQ3Status; C;

FUNCTION Q3Disk_EmptyData(VAR diskData: TQ3DiskData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **					 Ellipse Data Structure Definitions						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3EllipseDataPtr = ^TQ3EllipseData;
	TQ3EllipseData = RECORD
		origin:					TQ3Point3D;
		majorRadius:			TQ3Vector3D;
		minorRadius:			TQ3Vector3D;
		uMin:					Single;
		uMax:					Single;
		ellipseAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Ellipse Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Ellipse_New({CONST}VAR ellipseData: TQ3EllipseData): TQ3GeometryObject; C;
FUNCTION Q3Ellipse_Submit({CONST}VAR ellipseData: TQ3EllipseData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Ellipse_SetData(ellipse: TQ3GeometryObject; {CONST}VAR ellipseData: TQ3EllipseData): TQ3Status; C;
FUNCTION Q3Ellipse_GetData(ellipse: TQ3GeometryObject; VAR ellipseData: TQ3EllipseData): TQ3Status; C;
FUNCTION Q3Ellipse_SetOrigin(ellipse: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Ellipse_SetMajorRadius(ellipse: TQ3GeometryObject; {CONST}VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipse_SetMinorRadius(ellipse: TQ3GeometryObject; {CONST}VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipse_GetOrigin(ellipse: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Ellipse_GetMajorRadius(ellipse: TQ3GeometryObject; VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipse_GetMinorRadius(ellipse: TQ3GeometryObject; VAR minorRadius: TQ3Vector3D): TQ3Status; C;

FUNCTION Q3Ellipse_EmptyData(VAR ellipseData: TQ3EllipseData): TQ3Status; C;



{*****************************************************************************
 ** 																		 **
 **							Ellipsoid Data structures						 **
 ** 																		 **
 ****************************************************************************}

TYPE
	TQ3EllipsoidDataPtr = ^TQ3EllipsoidData;
	TQ3EllipsoidData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		majorRadius:			TQ3Vector3D;
		minorRadius:			TQ3Vector3D;
		uMin:					Single;
		uMax:					Single;
		vMin:					Single;
		vMax:					Single;
		caps:					TQ3EndCap;
		interiorAttributeSet:	TQ3AttributeSet;
		ellipsoidAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 ** 																		 **
 **							Ellipsoid Routines   							 **
 ** 																		 **
 ****************************************************************************}
FUNCTION Q3Ellipsoid_New({CONST}VAR ellipsoidData: TQ3EllipsoidData): TQ3GeometryObject; C;
FUNCTION Q3Ellipsoid_Submit({CONST}VAR ellipsoidData: TQ3EllipsoidData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Ellipsoid_SetData(ellipsoid: TQ3GeometryObject; {CONST}VAR ellipsoidData: TQ3EllipsoidData): TQ3Status; C;
FUNCTION Q3Ellipsoid_GetData(ellipsoid: TQ3GeometryObject; VAR ellipsoidData: TQ3EllipsoidData): TQ3Status; C;
FUNCTION Q3Ellipsoid_SetOrigin(ellipsoid: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_SetOrientation(ellipsoid: TQ3GeometryObject; {CONST}VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_SetMajorRadius(ellipsoid: TQ3GeometryObject; {CONST}VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_SetMinorRadius(ellipsoid: TQ3GeometryObject; {CONST}VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_GetOrigin(ellipsoid: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_GetOrientation(ellipsoid: TQ3GeometryObject; VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_GetMajorRadius(ellipsoid: TQ3GeometryObject; VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_GetMinorRadius(ellipsoid: TQ3GeometryObject; VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Ellipsoid_EmptyData(VAR ellipsoidData: TQ3EllipsoidData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **					General Polygon Data Structure Definitions				 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3GeneralPolygonShapeHint 	= LONGINT;
CONST
	kQ3GeneralPolygonShapeHintComplex = {TQ3GeneralPolygonShapeHint}0;
	kQ3GeneralPolygonShapeHintConcave = {TQ3GeneralPolygonShapeHint}1;
	kQ3GeneralPolygonShapeHintConvex = {TQ3GeneralPolygonShapeHint}2;


TYPE
	TQ3GeneralPolygonContourDataPtr = ^TQ3GeneralPolygonContourData;
	TQ3GeneralPolygonContourData = RECORD
		numVertices:			UInt32;
		vertices:				TQ3Vertex3DPtr;
	END;

	TQ3GeneralPolygonDataPtr = ^TQ3GeneralPolygonData;
	TQ3GeneralPolygonData = RECORD
		numContours:			UInt32;
		contours:				TQ3GeneralPolygonContourDataPtr;
		shapeHint:				TQ3GeneralPolygonShapeHint;
		generalPolygonAttributeSet: TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **							General polygon Routines						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3GeneralPolygon_New({CONST}VAR generalPolygonData: TQ3GeneralPolygonData): TQ3GeometryObject; C;
FUNCTION Q3GeneralPolygon_Submit({CONST}VAR generalPolygonData: TQ3GeneralPolygonData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetData(generalPolygon: TQ3GeometryObject; {CONST}VAR generalPolygonData: TQ3GeneralPolygonData): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetData(polygon: TQ3GeometryObject; VAR generalPolygonData: TQ3GeneralPolygonData): TQ3Status; C;
FUNCTION Q3GeneralPolygon_EmptyData(VAR generalPolygonData: TQ3GeneralPolygonData): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetVertexPosition(generalPolygon: TQ3GeometryObject; contourIndex: UInt32; pointIndex: UInt32; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetVertexPosition(generalPolygon: TQ3GeometryObject; contourIndex: UInt32; pointIndex: UInt32; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetVertexAttributeSet(generalPolygon: TQ3GeometryObject; contourIndex: UInt32; pointIndex: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetVertexAttributeSet(generalPolygon: TQ3GeometryObject; contourIndex: UInt32; pointIndex: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetShapeHint(generalPolygon: TQ3GeometryObject; shapeHint: TQ3GeneralPolygonShapeHint): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetShapeHint(generalPolygon: TQ3GeometryObject; VAR shapeHint: TQ3GeneralPolygonShapeHint): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Line Data Structure Definitions						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3LineDataPtr = ^TQ3LineData;
	TQ3LineData = RECORD
		vertices:				ARRAY [0..1] OF TQ3Vertex3D;
		lineAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **							Line Routines									 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Line_New({CONST}VAR lineData: TQ3LineData): TQ3GeometryObject; C;
FUNCTION Q3Line_Submit({CONST}VAR lineData: TQ3LineData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Line_GetData(line: TQ3GeometryObject; VAR lineData: TQ3LineData): TQ3Status; C;
FUNCTION Q3Line_SetData(line: TQ3GeometryObject; {CONST}VAR lineData: TQ3LineData): TQ3Status; C;
FUNCTION Q3Line_GetVertexPosition(line: TQ3GeometryObject; index: UInt32; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Line_SetVertexPosition(line: TQ3GeometryObject; index: UInt32; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Line_GetVertexAttributeSet(line: TQ3GeometryObject; index: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Line_SetVertexAttributeSet(line: TQ3GeometryObject; index: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Line_EmptyData(VAR lineData: TQ3LineData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Marker Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3MarkerDataPtr = ^TQ3MarkerData;
	TQ3MarkerData = RECORD
		location:				TQ3Point3D;
		xOffset:				LONGINT;
		yOffset:				LONGINT;
		bitmap:					TQ3Bitmap;
		markerAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Marker Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Marker_New({CONST}VAR markerData: TQ3MarkerData): TQ3GeometryObject; C;
FUNCTION Q3Marker_Submit({CONST}VAR markerData: TQ3MarkerData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Marker_SetData(geometry: TQ3GeometryObject; {CONST}VAR markerData: TQ3MarkerData): TQ3Status; C;
FUNCTION Q3Marker_GetData(geometry: TQ3GeometryObject; VAR markerData: TQ3MarkerData): TQ3Status; C;
FUNCTION Q3Marker_EmptyData(VAR markerData: TQ3MarkerData): TQ3Status; C;
FUNCTION Q3Marker_GetPosition(marker: TQ3GeometryObject; VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Marker_SetPosition(marker: TQ3GeometryObject; {CONST}VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Marker_GetXOffset(marker: TQ3GeometryObject; VAR xOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_SetXOffset(marker: TQ3GeometryObject; xOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_GetYOffset(marker: TQ3GeometryObject; VAR yOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_SetYOffset(marker: TQ3GeometryObject; yOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_GetBitmap(marker: TQ3GeometryObject; VAR bitmap: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3Marker_SetBitmap(marker: TQ3GeometryObject; {CONST}VAR bitmap: TQ3Bitmap): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Mesh Data Structure Definitions						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3MeshComponent = ^LONGINT;
	TQ3MeshVertex = ^LONGINT;
	TQ3MeshFace = ^LONGINT;
	TQ3MeshEdge = ^LONGINT;
	TQ3MeshContour = ^LONGINT;
{*****************************************************************************
 **																			 **
 **							Mesh Routines								 	 **
 **																			 **
 ****************************************************************************}
{
 *  Constructors
 }
FUNCTION Q3Mesh_New: TQ3GeometryObject; C;
FUNCTION Q3Mesh_VertexNew(mesh: TQ3GeometryObject; {CONST}VAR vertex: TQ3Vertex3D): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FaceNew(mesh: TQ3GeometryObject; numVertices: UInt32; {CONST}VAR vertices: TQ3MeshVertex; attributeSet: TQ3AttributeSet): TQ3MeshFace; C;
{
 *  Destructors
 }
FUNCTION Q3Mesh_VertexDelete(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex): TQ3Status; C;
FUNCTION Q3Mesh_FaceDelete(mesh: TQ3GeometryObject; face: TQ3MeshFace): TQ3Status; C;
{
 * Methods
 }
FUNCTION Q3Mesh_DelayUpdates(mesh: TQ3GeometryObject): TQ3Status; C;
FUNCTION Q3Mesh_ResumeUpdates(mesh: TQ3GeometryObject): TQ3Status; C;
FUNCTION Q3Mesh_FaceToContour(mesh: TQ3GeometryObject; containerFace: TQ3MeshFace; face: TQ3MeshFace): TQ3MeshContour; C;
FUNCTION Q3Mesh_ContourToFace(mesh: TQ3GeometryObject; contour: TQ3MeshContour): TQ3MeshFace; C;
{
 * Mesh
 }
FUNCTION Q3Mesh_GetNumComponents(mesh: TQ3GeometryObject; VAR numComponents: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetNumEdges(mesh: TQ3GeometryObject; VAR numEdges: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetNumVertices(mesh: TQ3GeometryObject; VAR numVertices: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetNumFaces(mesh: TQ3GeometryObject; VAR numFaces: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetNumCorners(mesh: TQ3GeometryObject; VAR numCorners: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetOrientable(mesh: TQ3GeometryObject; VAR orientable: TQ3Boolean): TQ3Status; C;
{
 * Component
 }
FUNCTION Q3Mesh_GetComponentNumVertices(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR numVertices: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetComponentNumEdges(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR numEdges: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetComponentBoundingBox(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR boundingBox: TQ3BoundingBox): TQ3Status; C;
FUNCTION Q3Mesh_GetComponentOrientable(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR orientable: TQ3Boolean): TQ3Status; C;
{
 * Vertex
 }
FUNCTION Q3Mesh_GetVertexCoordinates(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR coordinates: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexIndex(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR index: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexOnBoundary(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR onBoundary: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexComponent(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;

FUNCTION Q3Mesh_SetVertexCoordinates(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; {CONST}VAR coordinates: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Mesh_SetVertexAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; attributeSet: TQ3AttributeSet): TQ3Status; C;

{
 * Face
 }
FUNCTION Q3Mesh_GetFaceNumVertices(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR numVertices: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetFacePlaneEquation(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR planeEquation: TQ3PlaneEquation): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceNumContours(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR numContours: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceIndex(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR index: UInt32): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceComponent(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceAttributeSet(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;

FUNCTION Q3Mesh_SetFaceAttributeSet(mesh: TQ3GeometryObject; face: TQ3MeshFace; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
 * Edge
 }
FUNCTION Q3Mesh_GetEdgeVertices(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR vertex1: TQ3MeshVertex; VAR vertex2: TQ3MeshVertex): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeFaces(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR face1: TQ3MeshFace; VAR face2: TQ3MeshFace): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeOnBoundary(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR onBoundary: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeComponent(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeAttributeSet(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;

FUNCTION Q3Mesh_SetEdgeAttributeSet(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
 * Contour
 }
FUNCTION Q3Mesh_GetContourFace(mesh: TQ3GeometryObject; contour: TQ3MeshContour; VAR face: TQ3MeshFace): TQ3Status; C;
FUNCTION Q3Mesh_GetContourNumVertices(mesh: TQ3GeometryObject; contour: TQ3MeshContour; VAR numVertices: UInt32): TQ3Status; C;
{
 * Corner
 }
FUNCTION Q3Mesh_GetCornerAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; face: TQ3MeshFace; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Mesh_SetCornerAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; face: TQ3MeshFace; attributeSet: TQ3AttributeSet): TQ3Status; C;

{
 * Public Mesh Iterators
 }

TYPE
	TQ3MeshIteratorPtr = ^TQ3MeshIterator;
	TQ3MeshIterator = RECORD
		var1:					Ptr;
		var2:					Ptr;
		var3:					Ptr;
		field1:					Ptr;
		field2:					PACKED ARRAY [0..3] OF CHAR;
	END;

FUNCTION Q3Mesh_FirstMeshComponent(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshComponent; C;
FUNCTION Q3Mesh_NextMeshComponent(VAR iterator: TQ3MeshIterator): TQ3MeshComponent; C;
FUNCTION Q3Mesh_FirstComponentVertex(component: TQ3MeshComponent; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextComponentVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstComponentEdge(component: TQ3MeshComponent; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextComponentEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstMeshVertex(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextMeshVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstMeshFace(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextMeshFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_FirstMeshEdge(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextMeshEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstVertexEdge(vertex: TQ3MeshVertex; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextVertexEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstVertexVertex(vertex: TQ3MeshVertex; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextVertexVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstVertexFace(vertex: TQ3MeshVertex; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextVertexFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_FirstFaceEdge(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextFaceEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstFaceVertex(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextFaceVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstFaceFace(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextFaceFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_FirstFaceContour(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshContour; C;
FUNCTION Q3Mesh_NextFaceContour(VAR iterator: TQ3MeshIterator): TQ3MeshContour; C;
FUNCTION Q3Mesh_FirstContourEdge(contour: TQ3MeshContour; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextContourEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstContourVertex(contour: TQ3MeshContour; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextContourVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstContourFace(contour: TQ3MeshContour; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextContourFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;


{*****************************************************************************
 **																			 **
 **							Maximum order for NURB Curves					 **
 **																			 **
 ****************************************************************************}

{*****************************************************************************
 **																			 **
 **						NURB Data Structure Definitions						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3NURBCurveDataPtr = ^TQ3NURBCurveData;
	TQ3NURBCurveData = RECORD
		order:					UInt32;
		numPoints:				UInt32;
		controlPoints:			TQ3RationalPoint4DPtr;
		knots:					^Single;
		curveAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								NURB Curve Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3NURBCurve_New({CONST}VAR curveData: TQ3NURBCurveData): TQ3GeometryObject; C;
FUNCTION Q3NURBCurve_Submit({CONST}VAR curveData: TQ3NURBCurveData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3NURBCurve_SetData(curve: TQ3GeometryObject; {CONST}VAR nurbCurveData: TQ3NURBCurveData): TQ3Status; C;
FUNCTION Q3NURBCurve_GetData(curve: TQ3GeometryObject; VAR nurbCurveData: TQ3NURBCurveData): TQ3Status; C;
FUNCTION Q3NURBCurve_EmptyData(VAR nurbCurveData: TQ3NURBCurveData): TQ3Status; C;
FUNCTION Q3NURBCurve_SetControlPoint(curve: TQ3GeometryObject; pointIndex: UInt32; {CONST}VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBCurve_GetControlPoint(curve: TQ3GeometryObject; pointIndex: UInt32; VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBCurve_SetKnot(curve: TQ3GeometryObject; knotIndex: UInt32; knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBCurve_GetKnot(curve: TQ3GeometryObject; knotIndex: UInt32; VAR knotValue: Single): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Maximum NURB Patch Order						 **
 **																			 **
 ****************************************************************************}
{*****************************************************************************
 **																			 **
 **						NURB Patch Data Structure Definitions				 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3NURBPatchTrimCurveDataPtr = ^TQ3NURBPatchTrimCurveData;
	TQ3NURBPatchTrimCurveData = RECORD
		order:					UInt32;
		numPoints:				UInt32;
		controlPoints:			TQ3RationalPoint3DPtr;
		knots:					^Single;
	END;

	TQ3NURBPatchTrimLoopDataPtr = ^TQ3NURBPatchTrimLoopData;
	TQ3NURBPatchTrimLoopData = RECORD
		numTrimCurves:			UInt32;
		trimCurves:				TQ3NURBPatchTrimCurveDataPtr;
	END;

	TQ3NURBPatchDataPtr = ^TQ3NURBPatchData;
	TQ3NURBPatchData = RECORD
		uOrder:					UInt32;
		vOrder:					UInt32;
		numRows:				UInt32;
		numColumns:				UInt32;
		controlPoints:			TQ3RationalPoint4DPtr;
		uKnots:					^Single;
		vKnots:					^Single;
		numTrimLoops:			UInt32;
		trimLoops:				TQ3NURBPatchTrimLoopDataPtr;
		patchAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								NURB Patch Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3NURBPatch_New({CONST}VAR nurbPatchData: TQ3NURBPatchData): TQ3GeometryObject; C;
FUNCTION Q3NURBPatch_Submit({CONST}VAR nurbPatchData: TQ3NURBPatchData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3NURBPatch_SetData(nurbPatch: TQ3GeometryObject; {CONST}VAR nurbPatchData: TQ3NURBPatchData): TQ3Status; C;
FUNCTION Q3NURBPatch_GetData(nurbPatch: TQ3GeometryObject; VAR nurbPatchData: TQ3NURBPatchData): TQ3Status; C;
FUNCTION Q3NURBPatch_SetControlPoint(nurbPatch: TQ3GeometryObject; rowIndex: UInt32; columnIndex: UInt32; {CONST}VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBPatch_GetControlPoint(nurbPatch: TQ3GeometryObject; rowIndex: UInt32; columnIndex: UInt32; VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBPatch_SetUKnot(nurbPatch: TQ3GeometryObject; knotIndex: UInt32; knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_SetVKnot(nurbPatch: TQ3GeometryObject; knotIndex: UInt32; knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_GetUKnot(nurbPatch: TQ3GeometryObject; knotIndex: UInt32; VAR knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_GetVKnot(nurbPatch: TQ3GeometryObject; knotIndex: UInt32; VAR knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_EmptyData(VAR nurbPatchData: TQ3NURBPatchData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Pixmap Marker Data Structure Definitions			 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PixmapMarkerDataPtr = ^TQ3PixmapMarkerData;
	TQ3PixmapMarkerData = RECORD
		position:				TQ3Point3D;
		xOffset:				LONGINT;
		yOffset:				LONGINT;
		pixmap:					TQ3StoragePixmap;
		pixmapMarkerAttributeSet: TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Pixmap Marker Routines						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3PixmapMarker_New({CONST}VAR pixmapMarkerData: TQ3PixmapMarkerData): TQ3GeometryObject; C;
FUNCTION Q3PixmapMarker_Submit({CONST}VAR pixmapMarkerData: TQ3PixmapMarkerData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3PixmapMarker_SetData(geometry: TQ3GeometryObject; {CONST}VAR pixmapMarkerData: TQ3PixmapMarkerData): TQ3Status; C;
FUNCTION Q3PixmapMarker_GetData(geometry: TQ3GeometryObject; VAR pixmapMarkerData: TQ3PixmapMarkerData): TQ3Status; C;
FUNCTION Q3PixmapMarker_EmptyData(VAR pixmapMarkerData: TQ3PixmapMarkerData): TQ3Status; C;
FUNCTION Q3PixmapMarker_GetPosition(pixmapMarker: TQ3GeometryObject; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PixmapMarker_SetPosition(pixmapMarker: TQ3GeometryObject; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PixmapMarker_GetXOffset(pixmapMarker: TQ3GeometryObject; VAR xOffset: LONGINT): TQ3Status; C;
FUNCTION Q3PixmapMarker_SetXOffset(pixmapMarker: TQ3GeometryObject; xOffset: LONGINT): TQ3Status; C;
FUNCTION Q3PixmapMarker_GetYOffset(pixmapMarker: TQ3GeometryObject; VAR yOffset: LONGINT): TQ3Status; C;
FUNCTION Q3PixmapMarker_SetYOffset(pixmapMarker: TQ3GeometryObject; yOffset: LONGINT): TQ3Status; C;
FUNCTION Q3PixmapMarker_GetPixmap(pixmapMarker: TQ3GeometryObject; VAR pixmap: TQ3StoragePixmap): TQ3Status; C;
FUNCTION Q3PixmapMarker_SetPixmap(pixmapMarker: TQ3GeometryObject; {CONST}VAR pixmap: TQ3StoragePixmap): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Point Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PointDataPtr = ^TQ3PointData;
	TQ3PointData = RECORD
		point:					TQ3Point3D;
		pointAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Point Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Point_New({CONST}VAR pointData: TQ3PointData): TQ3GeometryObject; C;
FUNCTION Q3Point_Submit({CONST}VAR pointData: TQ3PointData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Point_GetData(point: TQ3GeometryObject; VAR pointData: TQ3PointData): TQ3Status; C;
FUNCTION Q3Point_SetData(point: TQ3GeometryObject; {CONST}VAR pointData: TQ3PointData): TQ3Status; C;
FUNCTION Q3Point_EmptyData(VAR pointData: TQ3PointData): TQ3Status; C;
FUNCTION Q3Point_SetPosition(point: TQ3GeometryObject; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Point_GetPosition(point: TQ3GeometryObject; VAR position: TQ3Point3D): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Polygon Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PolygonDataPtr = ^TQ3PolygonData;
	TQ3PolygonData = RECORD
		numVertices:			UInt32;
		vertices:				TQ3Vertex3DPtr;
		polygonAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **							Polygon Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Polygon_New({CONST}VAR polygonData: TQ3PolygonData): TQ3GeometryObject; C;
FUNCTION Q3Polygon_Submit({CONST}VAR polygonData: TQ3PolygonData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Polygon_SetData(polygon: TQ3GeometryObject; {CONST}VAR polygonData: TQ3PolygonData): TQ3Status; C;
FUNCTION Q3Polygon_GetData(polygon: TQ3GeometryObject; VAR polygonData: TQ3PolygonData): TQ3Status; C;
FUNCTION Q3Polygon_EmptyData(VAR polygonData: TQ3PolygonData): TQ3Status; C;
FUNCTION Q3Polygon_GetVertexPosition(polygon: TQ3GeometryObject; index: UInt32; VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Polygon_SetVertexPosition(polygon: TQ3GeometryObject; index: UInt32; {CONST}VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Polygon_GetVertexAttributeSet(polygon: TQ3GeometryObject; index: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Polygon_SetVertexAttributeSet(polygon: TQ3GeometryObject; index: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Polyhedron Data Structure Definitions				 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PolyhedronEdgeMasks 		= LONGINT;
CONST
	kQ3PolyhedronEdgeNone		= {TQ3PolyhedronEdgeMasks}0;
	kQ3PolyhedronEdge01			= {TQ3PolyhedronEdgeMasks}$01;
	kQ3PolyhedronEdge12			= {TQ3PolyhedronEdgeMasks}$02;
	kQ3PolyhedronEdge20			= {TQ3PolyhedronEdgeMasks}$04;
	kQ3PolyhedronEdgeAll		= {TQ3PolyhedronEdgeMasks}$07;


TYPE
	TQ3PolyhedronEdge					= UInt32;
	TQ3PolyhedronEdgeDataPtr = ^TQ3PolyhedronEdgeData;
	TQ3PolyhedronEdgeData = RECORD
		vertexIndices:			ARRAY [0..1] OF UInt32;
		triangleIndices:		ARRAY [0..1] OF UInt32;
		edgeAttributeSet:		TQ3AttributeSet;
	END;

	TQ3PolyhedronTriangleDataPtr = ^TQ3PolyhedronTriangleData;
	TQ3PolyhedronTriangleData = RECORD
		vertexIndices:			ARRAY [0..2] OF UInt32;
		edgeFlag:				TQ3PolyhedronEdge;
		triangleAttributeSet:	TQ3AttributeSet;
	END;

	TQ3PolyhedronDataPtr = ^TQ3PolyhedronData;
	TQ3PolyhedronData = RECORD
		numVertices:			UInt32;
		vertices:				TQ3Vertex3DPtr;
		numEdges:				UInt32;
		edges:					TQ3PolyhedronEdgeDataPtr;
		numTriangles:			UInt32;
		triangles:				TQ3PolyhedronTriangleDataPtr;
		polyhedronAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Polyhedron Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Polyhedron_New({CONST}VAR polyhedronData: TQ3PolyhedronData): TQ3GeometryObject; C;
FUNCTION Q3Polyhedron_Submit({CONST}VAR polyhedronData: TQ3PolyhedronData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Polyhedron_SetData(polyhedron: TQ3GeometryObject; {CONST}VAR polyhedronData: TQ3PolyhedronData): TQ3Status; C;
FUNCTION Q3Polyhedron_GetData(polyhedron: TQ3GeometryObject; VAR polyhedronData: TQ3PolyhedronData): TQ3Status; C;
FUNCTION Q3Polyhedron_EmptyData(VAR polyhedronData: TQ3PolyhedronData): TQ3Status; C;
FUNCTION Q3Polyhedron_SetVertexPosition(polyhedron: TQ3GeometryObject; index: UInt32; {CONST}VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Polyhedron_GetVertexPosition(polyhedron: TQ3GeometryObject; index: UInt32; VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Polyhedron_SetVertexAttributeSet(polyhedron: TQ3GeometryObject; index: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Polyhedron_GetVertexAttributeSet(polyhedron: TQ3GeometryObject; index: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Polyhedron_GetTriangleData(polyhedron: TQ3GeometryObject; triangleIndex: UInt32; VAR triangleData: TQ3PolyhedronTriangleData): TQ3Status; C;
FUNCTION Q3Polyhedron_SetTriangleData(polyhedron: TQ3GeometryObject; triangleIndex: UInt32; {CONST}VAR triangleData: TQ3PolyhedronTriangleData): TQ3Status; C;
FUNCTION Q3Polyhedron_GetEdgeData(polyhedron: TQ3GeometryObject; edgeIndex: UInt32; VAR edgeData: TQ3PolyhedronEdgeData): TQ3Status; C;
FUNCTION Q3Polyhedron_SetEdgeData(polyhedron: TQ3GeometryObject; edgeIndex: UInt32; {CONST}VAR edgeData: TQ3PolyhedronEdgeData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						PolyLine Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PolyLineDataPtr = ^TQ3PolyLineData;
	TQ3PolyLineData = RECORD
		numVertices:			UInt32;
		vertices:				TQ3Vertex3DPtr;
		segmentAttributeSet:	TQ3AttributeSetPtr;
		polyLineAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **							PolyLine Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3PolyLine_New({CONST}VAR polylineData: TQ3PolyLineData): TQ3GeometryObject; C;
FUNCTION Q3PolyLine_Submit({CONST}VAR polyLineData: TQ3PolyLineData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3PolyLine_SetData(polyLine: TQ3GeometryObject; {CONST}VAR polyLineData: TQ3PolyLineData): TQ3Status; C;
FUNCTION Q3PolyLine_GetData(polyLine: TQ3GeometryObject; VAR polyLineData: TQ3PolyLineData): TQ3Status; C;
FUNCTION Q3PolyLine_EmptyData(VAR polyLineData: TQ3PolyLineData): TQ3Status; C;
FUNCTION Q3PolyLine_GetVertexPosition(polyLine: TQ3GeometryObject; index: UInt32; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PolyLine_SetVertexPosition(polyLine: TQ3GeometryObject; index: UInt32; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PolyLine_GetVertexAttributeSet(polyLine: TQ3GeometryObject; index: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3PolyLine_SetVertexAttributeSet(polyLine: TQ3GeometryObject; index: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3PolyLine_GetSegmentAttributeSet(polyLine: TQ3GeometryObject; index: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3PolyLine_SetSegmentAttributeSet(polyLine: TQ3GeometryObject; index: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;




{*****************************************************************************
 **																			 **
 **						Torus Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3TorusDataPtr = ^TQ3TorusData;
	TQ3TorusData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		majorRadius:			TQ3Vector3D;
		minorRadius:			TQ3Vector3D;
		ratio:					Single;
		uMin:					Single;
		uMax:					Single;
		vMin:					Single;
		vMax:					Single;
		caps:					TQ3EndCap;
		interiorAttributeSet:	TQ3AttributeSet;
		torusAttributeSet:		TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								Torus Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Torus_New({CONST}VAR torusData: TQ3TorusData): TQ3GeometryObject; C;
FUNCTION Q3Torus_Submit({CONST}VAR torusData: TQ3TorusData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Torus_SetData(torus: TQ3GeometryObject; {CONST}VAR torusData: TQ3TorusData): TQ3Status; C;
FUNCTION Q3Torus_GetData(torus: TQ3GeometryObject; VAR torusData: TQ3TorusData): TQ3Status; C;
FUNCTION Q3Torus_SetOrigin(torus: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Torus_SetOrientation(torus: TQ3GeometryObject; {CONST}VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Torus_SetMajorRadius(torus: TQ3GeometryObject; {CONST}VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Torus_SetMinorRadius(torus: TQ3GeometryObject; {CONST}VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Torus_SetRatio(torus: TQ3GeometryObject; ratio: Single): TQ3Status; C;
FUNCTION Q3Torus_GetOrigin(torus: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Torus_GetOrientation(torus: TQ3GeometryObject; VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Torus_GetMajorRadius(torus: TQ3GeometryObject; VAR majorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Torus_GetMinorRadius(torus: TQ3GeometryObject; VAR minorRadius: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Torus_GetRatio(torus: TQ3GeometryObject; VAR ratio: Single): TQ3Status; C;
FUNCTION Q3Torus_EmptyData(VAR torusData: TQ3TorusData): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						Triangle Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3TriangleDataPtr = ^TQ3TriangleData;
	TQ3TriangleData = RECORD
		vertices:				ARRAY [0..2] OF TQ3Vertex3D;
		triangleAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **							Triangle Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Triangle_New({CONST}VAR triangleData: TQ3TriangleData): TQ3GeometryObject; C;
FUNCTION Q3Triangle_Submit({CONST}VAR triangleData: TQ3TriangleData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Triangle_SetData(triangle: TQ3GeometryObject; {CONST}VAR triangleData: TQ3TriangleData): TQ3Status; C;
FUNCTION Q3Triangle_GetData(triangle: TQ3GeometryObject; VAR triangleData: TQ3TriangleData): TQ3Status; C;
FUNCTION Q3Triangle_EmptyData(VAR triangleData: TQ3TriangleData): TQ3Status; C;
FUNCTION Q3Triangle_GetVertexPosition(triangle: TQ3GeometryObject; index: UInt32; VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Triangle_SetVertexPosition(triangle: TQ3GeometryObject; index: UInt32; {CONST}VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Triangle_GetVertexAttributeSet(triangle: TQ3GeometryObject; index: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Triangle_SetVertexAttributeSet(triangle: TQ3GeometryObject; index: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						TriGrid Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3TriGridDataPtr = ^TQ3TriGridData;
	TQ3TriGridData = RECORD
		numRows:				UInt32;
		numColumns:				UInt32;
		vertices:				TQ3Vertex3DPtr;
		facetAttributeSet:		TQ3AttributeSetPtr;
		triGridAttributeSet:	TQ3AttributeSet;
	END;

{*****************************************************************************
 **																			 **
 **								TriGrid Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3TriGrid_New({CONST}VAR triGridData: TQ3TriGridData): TQ3GeometryObject; C;
FUNCTION Q3TriGrid_Submit({CONST}VAR triGridData: TQ3TriGridData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3TriGrid_SetData(triGrid: TQ3GeometryObject; {CONST}VAR triGridData: TQ3TriGridData): TQ3Status; C;
FUNCTION Q3TriGrid_GetData(triGrid: TQ3GeometryObject; VAR triGridData: TQ3TriGridData): TQ3Status; C;
FUNCTION Q3TriGrid_EmptyData(VAR triGridData: TQ3TriGridData): TQ3Status; C;
FUNCTION Q3TriGrid_GetVertexPosition(triGrid: TQ3GeometryObject; rowIndex: UInt32; columnIndex: UInt32; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3TriGrid_SetVertexPosition(triGrid: TQ3GeometryObject; rowIndex: UInt32; columnIndex: UInt32; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3TriGrid_GetVertexAttributeSet(triGrid: TQ3GeometryObject; rowIndex: UInt32; columnIndex: UInt32; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3TriGrid_SetVertexAttributeSet(triGrid: TQ3GeometryObject; rowIndex: UInt32; columnIndex: UInt32; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3TriGrid_GetFacetAttributeSet(triGrid: TQ3GeometryObject; faceIndex: UInt32; VAR facetAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3TriGrid_SetFacetAttributeSet(triGrid: TQ3GeometryObject; faceIndex: UInt32; facetAttributeSet: TQ3AttributeSet): TQ3Status; C;



{*****************************************************************************
 **																			 **
 **						TriMesh Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3TriMeshTriangleDataPtr = ^TQ3TriMeshTriangleData;
	TQ3TriMeshTriangleData = RECORD
		pointIndices:			ARRAY [0..2] OF UInt32;
	END;

	TQ3TriMeshEdgeDataPtr = ^TQ3TriMeshEdgeData;
	TQ3TriMeshEdgeData = RECORD
		pointIndices:			ARRAY [0..1] OF UInt32;
		triangleIndices:		ARRAY [0..1] OF UInt32;
	END;

	TQ3TriMeshAttributeDataPtr = ^TQ3TriMeshAttributeData;
	TQ3TriMeshAttributeData = RECORD
		attributeType:			TQ3AttributeType;						{  The type of attribute 		  }
		data:					Ptr;									{  Pointer to the contiguous      }
																		{  attribute data.				  }
		attributeUseArray:		CStringPtr;								{  This is only used with custom  }
																		{  attributes 					  }
	END;

	TQ3TriMeshDataPtr = ^TQ3TriMeshData;
	TQ3TriMeshData = RECORD
		triMeshAttributeSet:	TQ3AttributeSet;
		numTriangles:			UInt32;
		triangles:				TQ3TriMeshTriangleDataPtr;
		numTriangleAttributeTypes: UInt32;
		triangleAttributeTypes:	TQ3TriMeshAttributeDataPtr;
		numEdges:				UInt32;
		edges:					TQ3TriMeshEdgeDataPtr;
		numEdgeAttributeTypes:	UInt32;
		edgeAttributeTypes:		TQ3TriMeshAttributeDataPtr;
		numPoints:				UInt32;
		points:					TQ3Point3DPtr;
		numVertexAttributeTypes: UInt32;
		vertexAttributeTypes:	TQ3TriMeshAttributeDataPtr;
		bBox:					TQ3BoundingBox;
	END;

{*****************************************************************************
 **																			 **
 **							TriMesh Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3TriMesh_New({CONST}VAR triMeshData: TQ3TriMeshData): TQ3GeometryObject; C;
FUNCTION Q3TriMesh_Submit({CONST}VAR triMeshData: TQ3TriMeshData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3TriMesh_SetData(triMesh: TQ3GeometryObject; {CONST}VAR triMeshData: TQ3TriMeshData): TQ3Status; C;
FUNCTION Q3TriMesh_GetData(triMesh: TQ3GeometryObject; VAR triMeshData: TQ3TriMeshData): TQ3Status; C;
FUNCTION Q3TriMesh_EmptyData(VAR triMeshData: TQ3TriMeshData): TQ3Status; C;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DGeometryIncludes}

{$ENDC} {__QD3DGEOMETRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
