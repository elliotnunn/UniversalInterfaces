{
 	File:		QD3DPick.p
 
 	Contains:	Q3Pick methods									
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DPick;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DPICK__}
{$SETC __QD3DPICK__ := 1}

{$I+}
{$SETC QD3DPickIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}

{$IFC UNDEFINED __QD3DSTYLE__}
{$I QD3DStyle.p}
{$ENDC}
{$IFC UNDEFINED __QD3DGEOMETRY__}
{$I QD3DGeometry.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{****************************************************************************
 **																			**
 **							Mask bits for hit information 					**
 **																			**
 ****************************************************************************}

TYPE
	TQ3PickDetailMasks 			= LONGINT;
CONST
	kQ3PickDetailNone			= {TQ3PickDetailMasks}0;
	kQ3PickDetailMaskPickID		= {TQ3PickDetailMasks}$01;
	kQ3PickDetailMaskPath		= {TQ3PickDetailMasks}$02;
	kQ3PickDetailMaskObject		= {TQ3PickDetailMasks}$04;
	kQ3PickDetailMaskLocalToWorldMatrix = {TQ3PickDetailMasks}$08;
	kQ3PickDetailMaskXYZ		= {TQ3PickDetailMasks}$10;
	kQ3PickDetailMaskDistance	= {TQ3PickDetailMasks}$20;
	kQ3PickDetailMaskNormal		= {TQ3PickDetailMasks}$40;
	kQ3PickDetailMaskShapePart	= {TQ3PickDetailMasks}$80;
	kQ3PickDetailMaskPickPart	= {TQ3PickDetailMasks}$0100;
	kQ3PickDetailMaskUV			= {TQ3PickDetailMasks}$0200;


TYPE
	TQ3PickDetail						= UInt32;
{*****************************************************************************
 **																			 **
 **								Hitlist sorting								 **
 **																			 **
 ****************************************************************************}
	TQ3PickSort 				= LONGINT;
CONST
	kQ3PickSortNone				= {TQ3PickSort}0;
	kQ3PickSortNearToFar		= {TQ3PickSort}1;
	kQ3PickSortFarToNear		= {TQ3PickSort}2;


{*****************************************************************************
 **																			 **
 **					Data structures to set up the pick object				 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PickDataPtr = ^TQ3PickData;
	TQ3PickData = RECORD
		sort:					TQ3PickSort;
		mask:					TQ3PickDetail;
		numHitsToReturn:		UInt32;
	END;

	TQ3WindowPointPickDataPtr = ^TQ3WindowPointPickData;
	TQ3WindowPointPickData = RECORD
		data:					TQ3PickData;
		point:					TQ3Point2D;
		vertexTolerance:		Single;
		edgeTolerance:			Single;
	END;

	TQ3WindowRectPickDataPtr = ^TQ3WindowRectPickData;
	TQ3WindowRectPickData = RECORD
		data:					TQ3PickData;
		rect:					TQ3Area;
	END;

{*****************************************************************************
 **																			 **
 **									Hit data								 **
 **																			 **
 ****************************************************************************}
	TQ3HitPathPtr = ^TQ3HitPath;
	TQ3HitPath = RECORD
		rootGroup:				TQ3GroupObject;
		depth:					UInt32;
		positions:				TQ3GroupPositionPtr;
	END;

{*****************************************************************************
 **																			 **
 **								Pick class methods							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Pick_GetType(pick: TQ3PickObject): TQ3ObjectType; C;
FUNCTION Q3Pick_GetData(pick: TQ3PickObject; VAR data: TQ3PickData): TQ3Status; C;
FUNCTION Q3Pick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3PickData): TQ3Status; C;
FUNCTION Q3Pick_GetVertexTolerance(pick: TQ3PickObject; VAR vertexTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_GetEdgeTolerance(pick: TQ3PickObject; VAR edgeTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_SetVertexTolerance(pick: TQ3PickObject; vertexTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_SetEdgeTolerance(pick: TQ3PickObject; edgeTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_GetNumHits(pick: TQ3PickObject; VAR numHits: UInt32): TQ3Status; C;
FUNCTION Q3Pick_EmptyHitList(pick: TQ3PickObject): TQ3Status; C;
FUNCTION Q3Pick_GetPickDetailValidMask(pick: TQ3PickObject; index: UInt32; VAR pickDetailValidMask: TQ3PickDetail): TQ3Status; C;
FUNCTION Q3Pick_GetPickDetailData(pick: TQ3PickObject; index: UInt32; pickDetailValue: TQ3PickDetail; detailData: UNIV Ptr): TQ3Status; C;
FUNCTION Q3HitPath_EmptyData(VAR hitPath: TQ3HitPath): TQ3Status; C;
{*****************************************************************************
 **																			 **
 **							Window point pick methods						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WindowPointPick_New({CONST}VAR data: TQ3WindowPointPickData): TQ3PickObject; C;
FUNCTION Q3WindowPointPick_GetPoint(pick: TQ3PickObject; VAR point: TQ3Point2D): TQ3Status; C;
FUNCTION Q3WindowPointPick_SetPoint(pick: TQ3PickObject; {CONST}VAR point: TQ3Point2D): TQ3Status; C;
FUNCTION Q3WindowPointPick_GetData(pick: TQ3PickObject; VAR data: TQ3WindowPointPickData): TQ3Status; C;
FUNCTION Q3WindowPointPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WindowPointPickData): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Window rect pick methods						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WindowRectPick_New({CONST}VAR data: TQ3WindowRectPickData): TQ3PickObject; C;
FUNCTION Q3WindowRectPick_GetRect(pick: TQ3PickObject; VAR rect: TQ3Area): TQ3Status; C;
FUNCTION Q3WindowRectPick_SetRect(pick: TQ3PickObject; {CONST}VAR rect: TQ3Area): TQ3Status; C;
FUNCTION Q3WindowRectPick_GetData(pick: TQ3PickObject; VAR data: TQ3WindowRectPickData): TQ3Status; C;
FUNCTION Q3WindowRectPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WindowRectPickData): TQ3Status; C;


{*****************************************************************************
 **																			 **
 **								Shape Part methods							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ShapePart_GetType(shapePartObject: TQ3ShapePartObject): TQ3ObjectType; C;
FUNCTION Q3MeshPart_GetType(meshPartObject: TQ3MeshPartObject): TQ3ObjectType; C;
FUNCTION Q3ShapePart_GetShape(shapePartObject: TQ3ShapePartObject; VAR shapeObject: TQ3ShapeObject): TQ3Status; C;
FUNCTION Q3MeshPart_GetComponent(meshPartObject: TQ3MeshPartObject; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3MeshFacePart_GetFace(meshFacePartObject: TQ3MeshFacePartObject; VAR face: TQ3MeshFace): TQ3Status; C;
FUNCTION Q3MeshEdgePart_GetEdge(meshEdgePartObject: TQ3MeshEdgePartObject; VAR edge: TQ3MeshEdge): TQ3Status; C;
FUNCTION Q3MeshVertexPart_GetVertex(meshVertexPartObject: TQ3MeshVertexPartObject; VAR vertex: TQ3MeshVertex): TQ3Status; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DPickIncludes}

{$ENDC} {__QD3DPICK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
