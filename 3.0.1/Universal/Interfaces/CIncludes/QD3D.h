/******************************************************************************
 **									 										 **
 ** 	Module:		QD3D.h													 **						
 **									 										 **
 **									 										 **
 ** 	Purpose: 	System include file.									 **			
 **									 										 **
 **									 										 **
 **									 										 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 **									 										 **
 **									 										 **
 *****************************************************************************/
#ifndef QD3D_h
#define QD3D_h

#include <stdio.h>

/******************************************************************************
 **																			 **
 **								Porting Control								 **
 **																			 **
 *****************************************************************************/

/*
 *  NOTE:  To compile on a Unix workstation (assumes X11 window system):
 *				1. Add to compiler command line: "-DOS_MACINTOSH=0"
 *				2. Add "-DOS_UNIX=1"
 *				3. Add "-DWINDOW_SYSTEM_X11=1"
 */
 
#if defined(_WIN32) || defined(_WINDOWS)
	#define OS_MACINTOSH				0
	#define OS_WIN32					1
	#define OS_UNIX						0
	#define OS_NEXT						0

	#define WINDOW_SYSTEM_MACINTOSH		0
	#define WINDOW_SYSTEM_WIN32			1
	#define WINDOW_SYSTEM_X11			0
	#define WINDOW_SYSTEM_NEXT			0

#elif defined(NeXT) && NeXT
	#define OS_MACINTOSH				0
	#define OS_WIN32					0
	#define OS_UNIX						0
	#define OS_NEXT						1
	
	#define WINDOW_SYSTEM_MACINTOSH		0
	#define WINDOW_SYSTEM_WIN32			0
	#define WINDOW_SYSTEM_X11			0
	#define WINDOW_SYSTEM_NEXT			1

#elif !defined(OS_MACINTOSH)
	#define OS_MACINTOSH				1
	#define OS_WIN32					0
	#define OS_UNIX						0
	#define OS_NEXT						0

	#define WINDOW_SYSTEM_MACINTOSH		1
	#define WINDOW_SYSTEM_WIN32			0
	#define WINDOW_SYSTEM_X11			0
	#define WINDOW_SYSTEM_NEXT			0

	#if defined(__MRC__) || defined(__SC__) || defined(__MWERKS__)
	 	#define PRAGMA_ONCE				1
	#else
	 	#define PRAGMA_ONCE				0
	#endif  /* defined(__MRC__) || defined(__SC__) || defined(__MWERKS__)  */

	/*
	 *  Set required compiler options (if possible):
	 *   1. enums must always be ints in QD3D and in applications;
	 *      this consistency is required to prevent misinterpretation
	 *      of an app's enum values by an API; it is also required for
	 *      compliance with ANSI
	 *   2. alignment of longs, floats, and pointers in structures
	 *      is on long boundaries for PowerPC
	 */
	#if defined(__xlc__) || defined(__XLC121__)
		#pragma options enum=int
		#pragma options align=power
	#elif defined(__MWERKS__)
		#pragma enumsalwaysint on
		#pragma options align=native
	#elif defined(__MRC__) || defined(__SC__)
		#if __option(pack_enums)
			#define PRAGMA_ENUM_RESET_QD3D 1
		#endif
		#pragma options(!pack_enums)
		#pragma options align=power
	#endif
	
	#if 0	/* moved to Gestalt.h */
	enum {
		gestaltQD3D				= 'qd3d',
		gestaltQD3DVersion		= 'q3v ',
		gestaltQD3DNotPresent	= 0,
		gestaltQD3DAvailable	= 1
	};
	#endif 
	
#endif  /*  OS_MACINTOSH  */

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */ 
 

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */


/******************************************************************************
 **																			 **
 **								Export Control								 **
 **																			 **
 *****************************************************************************/
 
#if defined(_MSC_VER)	/* Microsoft Visual C */
	#if defined(WIN32_EXPORTING)	/* define when building DLL */
		#define QD3D_EXPORT __declspec( dllexport )	 
		#define QD3D_CALL	
		#define QD3D_CALLBACK	
	#else
		#define QD3D_EXPORT
		#define QD3D_CALL	__cdecl
		#define QD3D_CALLBACK	__cdecl	
	#endif /* WIN32_EXPORTING */
#else
	#define QD3D_EXPORT
	#define QD3D_CALL	
	#define QD3D_CALLBACK	
#endif  /*  _MSC_VER  */


/******************************************************************************
 **																			 **
 **								NULL definition								 **
 **																			 **
 *****************************************************************************/

#ifndef NULL
	#error NULL is undefined.
#endif /* NULL */


/******************************************************************************
 **																			 **
 **									Objects									 **
 **																			 **
 *****************************************************************************/
/*
 * Everything in QuickDraw 3D is an OBJECT: a bunch of data with a type,
 * deletion, duplication, and i/o methods.
 */
typedef long					TQ3ObjectType;

typedef struct TQ3ObjectPrivate	*TQ3Object;

/*
 * There are four subclasses of OBJECT:
 *	an ELEMENT, which is data that is placed in a SET
 *	a SHAREDOBJECT, which is reference-counted data that is shared
 *	VIEWs, which maintain state information for an image
 *	a PICK, which used to query a VIEW
 */
typedef TQ3Object				TQ3ElementObject;
typedef TQ3Object				TQ3SharedObject;
typedef TQ3Object				TQ3ViewObject;
typedef TQ3Object				TQ3PickObject;

/*
 * There are several types of SharedObjects:
 *	RENDERERs, which paint to a drawContext
 *	DRAWCONTEXTs, which are an interface to a device 
 *	SETs, which maintains "mathematical sets" of ELEMENTs
 *	FILEs, which maintain state information for a metafile
 *	SHAPEs, which affect the state of the View
 *	SHAPEPARTs, which contain geometry-specific data about a picking hit
 *	CONTROLLERSTATEs, which hold state of the output channels for a CONTROLLER
 *	TRACKERs, which represent a position and orientation in the user interface
 *  STRINGs, which are abstractions of text string data.
 *	STORAGE, which is an abstraction for stream-based data storage (files, 
 *		memory)
 *	TEXTUREs, for sharing bitmap information for TEXTURESHADERS
 *	VIEWHINTs, which specifies viewing preferences in FILEs
 */
typedef TQ3SharedObject			TQ3RendererObject;
typedef TQ3SharedObject			TQ3DrawContextObject;
typedef TQ3SharedObject			TQ3SetObject;
typedef TQ3SharedObject			TQ3FileObject;
typedef TQ3SharedObject			TQ3ShapeObject;
typedef TQ3SharedObject			TQ3ShapePartObject;
typedef TQ3SharedObject			TQ3ControllerStateObject;
typedef TQ3SharedObject			TQ3TrackerObject;
typedef TQ3SharedObject			TQ3StringObject;
typedef TQ3SharedObject			TQ3StorageObject;
typedef TQ3SharedObject			TQ3TextureObject;
typedef TQ3SharedObject			TQ3ViewHintsObject;


/*
 * There is one types of SET:
 *	ATTRIBUTESETs, which contain ATTRIBUTEs which are inherited 
 */
typedef TQ3SetObject				TQ3AttributeSet;

/*
 * There are many types of SHAPEs:
 *	LIGHTs, which affect how the RENDERER draws 3-D cues
 *	CAMERAs, which affects the location and orientation of the RENDERER in 
 *		space
 *	GROUPs, which may contain any number of SHARED OBJECTS
 *	GEOMETRYs, which are representations of three-dimensional data
 *	SHADERs, which affect how colors are drawn on a geometry
 *	STYLEs, which affect how the RENDERER paints to the DRAWCONTEXT
 *	TRANSFORMs, which affect the coordinate system in the VIEW
 *	REFERENCEs, which are references to objects in FILEs
 *  UNKNOWN, which hold unknown objects read from a metafile.
 */
typedef TQ3ShapeObject			TQ3GroupObject;
typedef TQ3ShapeObject			TQ3GeometryObject;
typedef TQ3ShapeObject			TQ3ShaderObject;
typedef TQ3ShapeObject			TQ3StyleObject;
typedef TQ3ShapeObject			TQ3TransformObject;
typedef TQ3ShapeObject			TQ3LightObject;
typedef TQ3ShapeObject			TQ3CameraObject;
typedef TQ3ShapeObject			TQ3UnknownObject;
typedef TQ3ShapeObject			TQ3ReferenceObject;

/*
 * For now, there is only one type of SHAPEPARTs:
 *	MESHPARTs, which describe some part of a mesh
 */
typedef TQ3ShapePartObject		TQ3MeshPartObject;

/*
 * There are three types of MESHPARTs:
 *	MESHFACEPARTs, which describe a face of a mesh
 *	MESHEDGEPARTs, which describe a edge of a mesh
 *	MESHVERTEXPARTs, which describe a vertex of a mesh
 */
typedef TQ3MeshPartObject		TQ3MeshFacePartObject;
typedef TQ3MeshPartObject		TQ3MeshEdgePartObject;
typedef TQ3MeshPartObject		TQ3MeshVertexPartObject;

/*
 * A DISPLAY Group can be drawn to a view
 */
typedef TQ3GroupObject			TQ3DisplayGroupObject;

/*
 * There are many types of SHADERs:
 *	SURFACESHADERs, which affect how the surface of a geometry is painted
 *	ILLUMINATIONSHADERs, which affect how lights affect the color of a surface
 */
typedef TQ3ShaderObject			TQ3SurfaceShaderObject;
typedef TQ3ShaderObject			TQ3IlluminationShaderObject;

/*
 * A handle to an object in a group
 */
typedef struct TQ3GroupPositionPrivate	*TQ3GroupPosition;

/* 
 * TQ3ObjectClassNameString is used for the class name of an object
 */
enum {
	kQ3StringMaximumLength = 1024
};

typedef char TQ3ObjectClassNameString[kQ3StringMaximumLength];


/******************************************************************************
 **																			 **
 **							Client/Server Things							 **
 **																			 **
 *****************************************************************************/
 
typedef void *TQ3ControllerRef;


/******************************************************************************
 **																			 **
 **							Flags and Switches								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3Boolean {
	kQ3False,
	kQ3True
} TQ3Boolean;

typedef enum TQ3Switch {
	kQ3Off,
	kQ3On
} TQ3Switch;

typedef enum TQ3Status {
	kQ3Failure,
	kQ3Success
} TQ3Status;

typedef enum TQ3Axis {
	kQ3AxisX,
	kQ3AxisY,
	kQ3AxisZ
} TQ3Axis;

typedef enum TQ3PixelType {
	kQ3PixelTypeRGB32		= 0,	/* Alpha:8 (ignored), R:8, G:8, B:8	*/
	kQ3PixelTypeARGB32		= 1,	/* Alpha:8, R:8, G:8, B:8 			*/
	kQ3PixelTypeRGB16		= 2,	/* Alpha:1 (ignored), R:5, G:5, B:5	*/
	kQ3PixelTypeARGB16		= 3		/* Alpha:1, R:5, G:5, B:5 			*/
#if defined(WINDOW_SYSTEM_WIN32) && WINDOW_SYSTEM_WIN32
	,
	kQ3PixelTypeRGB16_565	= 4,	/* 16 bits/pixel, R:5, G:6, B:5		*/
	kQ3PixelTypeRGB24		= 5		/* 24 bits/pixel, R:8, G:8, B:8		*/
#endif /* WINDOW_SYSTEM_WIN32 */
} TQ3PixelType;

typedef enum TQ3Endian{
	kQ3EndianBig,
	kQ3EndianLittle
} TQ3Endian;

typedef enum TQ3EndCapMasks {
	kQ3EndCapNone			= 0,
	kQ3EndCapMaskTop		= 1 << 0,
	kQ3EndCapMaskBottom		= 1 << 1,
	kQ3EndCapMaskInterior	= 1 << 2
} TQ3EndCapMasks;

typedef unsigned long TQ3EndCap;

enum {
	kQ3ArrayIndexNULL = ~0
};


/******************************************************************************
 **																			 **
 **						Point and Vector Definitions						 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3Vector2D {
	float		x;
	float		y;
} TQ3Vector2D;

typedef struct TQ3Vector3D {
	float 		x;
	float		y;
	float		z;
} TQ3Vector3D;

typedef struct TQ3Point2D {
	float		x;
	float		y;
} TQ3Point2D;

typedef struct TQ3Point3D {
	float 		x;
	float		y;
	float		z;
} TQ3Point3D;

typedef struct TQ3RationalPoint4D {
	float 		x;
	float		y;
	float		z;
	float		w;
} TQ3RationalPoint4D;

typedef struct TQ3RationalPoint3D {
	float		x;
	float		y;
	float		w;
} TQ3RationalPoint3D;


/******************************************************************************
 **																			 **
 **								Quaternion									 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3Quaternion {
	float		w;
	float		x;
	float		y;
	float		z;
} TQ3Quaternion;


/******************************************************************************
 **																			 **
 **								Ray Definition								 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3Ray3D {
	TQ3Point3D		origin;
	TQ3Vector3D		direction;
} TQ3Ray3D;


/******************************************************************************
 **																			 **
 **						Parameterization Data Structures					 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3Param2D {
	float			u;
	float			v;
} TQ3Param2D;

typedef struct TQ3Param3D {
	float			u;
	float			v;
	float			w;
} TQ3Param3D;

typedef struct TQ3Tangent2D {
	TQ3Vector3D		uTangent;
	TQ3Vector3D		vTangent;
} TQ3Tangent2D;

typedef struct TQ3Tangent3D {
	TQ3Vector3D		uTangent;
	TQ3Vector3D		vTangent;
	TQ3Vector3D		wTangent;
} TQ3Tangent3D;


/******************************************************************************
 **																			 **
 **						Polar and Spherical Coordinates						 **
 **																			 **
 *****************************************************************************/
 
 typedef struct TQ3PolarPoint {
 	float		r;
 	float		theta;
  } TQ3PolarPoint;
 
 typedef struct TQ3SphericalPoint {
 	float		rho;
 	float		theta;
 	float		phi;
 } TQ3SphericalPoint;
 

/******************************************************************************
 **																			 **
 **							Color Definition								 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3ColorRGB {
	float 			r;
	float			g;
	float			b;
} TQ3ColorRGB;


typedef struct TQ3ColorARGB {
	float 			a;
	float 			r;
	float			g;
	float			b;
} TQ3ColorARGB;


/******************************************************************************
 **																			 **
 **									Vertices								 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3Vertex3D {
	TQ3Point3D			point;
	TQ3AttributeSet		attributeSet;
}  TQ3Vertex3D;


/******************************************************************************
 **																			 **
 **									Matrices								 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3Matrix3x3 {
	float	value[3][3];
} TQ3Matrix3x3;

typedef struct TQ3Matrix4x4 {
	float	value[4][4];
} TQ3Matrix4x4;




/******************************************************************************
 **																			 **
 **								Bitmap/Pixmap								 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3Pixmap {
	void				*image;
	unsigned long		width;
	unsigned long		height;
	unsigned long		rowBytes;
	unsigned long		pixelSize;	/* MUST be 16 or 32 to use with the		 */
									/* Interactive Renderer on Mac OS		 */
	TQ3PixelType		pixelType;
	TQ3Endian			bitOrder;
	TQ3Endian			byteOrder;
} TQ3Pixmap;

typedef struct TQ3StoragePixmap {
	TQ3StorageObject	image;
	unsigned long		width;
	unsigned long		height;
	unsigned long		rowBytes;
	unsigned long		pixelSize;	/* MUST be 16 or 32 to use with the 	*/
									/* Interactive Renderer on Mac OS		*/
	TQ3PixelType		pixelType;
	TQ3Endian			bitOrder;
	TQ3Endian			byteOrder;
} TQ3StoragePixmap;

typedef struct TQ3Bitmap {
	unsigned char		*image;
	unsigned long		width;
	unsigned long		height;
	unsigned long		rowBytes;
	TQ3Endian			bitOrder;
} TQ3Bitmap;

typedef struct TQ3MipmapImage {		/* An image for use as a texture mipmap  */
	unsigned long		width;		/* Width of mipmap, must be power of 2   */
	unsigned long		height;		/* Height of mipmap, must be power of 2  */
	unsigned long		rowBytes;	/* Rowbytes of mipmap                    */
	unsigned long		offset;		/* Offset from image base to this mipmap */
} TQ3MipmapImage;

typedef struct TQ3Mipmap {
	TQ3StorageObject	image;		/* Data containing the texture map and 	*/
									/* if (useMipmapping==kQ3True) the 		*/
									/* mipmap data 							*/
	TQ3Boolean			useMipmapping;/* True if mipmapping should be used 	*/
									/* and all mipmaps have been provided   */
	TQ3PixelType		pixelType;
	TQ3Endian			bitOrder;
	TQ3Endian			byteOrder;
	unsigned long		reserved;	/* leave NULL for next version */
	TQ3MipmapImage		mipmaps[32];/* The actual number of mipmaps is 		*/
									/* determined from the size of the 		*/
									/* first mipmap							*/
} TQ3Mipmap;


/******************************************************************************
 **																			 **
 **						Higher dimension quantities							 **
 **																			 **
 *****************************************************************************/
 
typedef struct TQ3Area {
	TQ3Point2D 			min;
	TQ3Point2D 			max;
} TQ3Area;

typedef struct TQ3PlaneEquation {
	TQ3Vector3D			normal;
	float				constant;
} TQ3PlaneEquation;

typedef struct TQ3BoundingBox {
	TQ3Point3D 			min;
	TQ3Point3D 			max;
	TQ3Boolean			isEmpty;
} TQ3BoundingBox;

typedef struct TQ3BoundingSphere {
	TQ3Point3D			origin;
	float				radius;
	TQ3Boolean			isEmpty;
} TQ3BoundingSphere;

/*
 *	The TQ3ComputeBounds flag passed to StartBoundingBox or StartBoundingSphere
 *	calls in the View. It's a hint to the system as to how it should 
 *	compute the bbox of a shape:
 *
 *	kQ3ComputeBoundsExact:	
 *		Vertices of shapes are transformed into world space and
 *		the world space bounding box is computed from them.  Slow!
 *	
 *	kQ3ComputeBoundsApproximate: 
 *		A local space bounding box is computed from a shape's
 *		vertices.  This bbox is then transformed into world space,
 *		and its bounding box is taken as the shape's approximate
 *		bbox.  Fast but the bbox is larger than optimal.
 */
typedef enum TQ3ComputeBounds {
	kQ3ComputeBoundsExact,
	kQ3ComputeBoundsApproximate
} TQ3ComputeBounds;


/******************************************************************************
 **																			 **
 **							Object System Types								 **
 **																			 **
 *****************************************************************************/



typedef struct TQ3ObjectClassPrivate		*TQ3XObjectClass;

typedef unsigned long 						TQ3XMethodType;

/*
 *  Object methods
 */
#define kQ3XMethodTypeObjectUnregister		Q3_METHOD_TYPE('u','n','r','g')

/* 
 *  Return true from the metahandler if this 
 *  object can be submitted in a rendering loop 
 */
#define kQ3XMethodTypeObjectIsDrawable		Q3_METHOD_TYPE('i','s','d','r')	

typedef void (QD3D_CALLBACK *TQ3XFunctionPointer)(
	void);

typedef TQ3XFunctionPointer (QD3D_CALLBACK *TQ3XMetaHandler)(
	TQ3XMethodType		methodType);

/*
 * MetaHandler:
 *		When you give a metahandler to QuickDraw 3D, it is called multiple 
 *		times to build method tables, and then is thrown away. You are 
 *		guaranteed that your metahandler will never be called again after a 
 *		call that was passed a metahandler returns.
 *
 *		Your metahandler should contain a switch on the methodType passed to it
 *		and should return the corresponding method as an TQ3XFunctionPointer.
 *
 *		IMPORTANT: A metaHandler MUST always "return" a value. If you are
 *		passed a methodType that you do not understand, ALWAYS return NULL.
 *
 *		These types here are prototypes of how your functions should look.
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectUnregisterMethod)(
	TQ3XObjectClass		objectClass);
	
/*
 * See QD3DIO.h for the IO method types: 
 *		ObjectReadData, ObjectTraverse, ObjectWrite
 */


/******************************************************************************
 **																			 **
 **								Set Types									 **
 **																			 **
 *****************************************************************************/

typedef long					TQ3ElementType;

#define kQ3ElementTypeNone		0
#define kQ3ElementTypeUnknown	32
#define kQ3ElementTypeSet		33

/* 
 *	kQ3ElementTypeUnknown is a TQ3Object. 
 *	
 *		Do Q3Set_Add(s, ..., &obj) or Q3Set_Get(s, ..., &obj);
 *		
 *		Note that the object is always referenced when copying around. 
 *		
 *		Generally, it is an Unknown object, a Group of Unknown objects, or a 
 *		group of other "objects" which have been found in the metafile and
 *		have no attachment method to their parent. Be prepared to handle
 *		any or all of these cases if you actually access the set on a shape.
 *
 *	kQ3ElementTypeSet is a TQ3SetObject. 
 *	
 *		Q3Shape_GetSet(s,&o) is eqivalent to 
 *			Q3Shape_GetElement(s, kQ3ElementTypeSet, &o)
 *			
 *		Q3Shape_SetSet(s,o)  is eqivalent to 
 *			Q3Shape_SetElement(s, kQ3ElementTypeSet, &o)
 *	
 *		Note that the object is always referenced when copying around. 
 *		
 *	See the note below about the Set and Shape changes.
 */
 
/******************************************************************************
 **																			 **
 **							Object System Macros							 **
 **																			 **
 *****************************************************************************/

#define Q3_FOUR_CHARACTER_CONSTANT(a,b,c,d) 		\
			((const unsigned long) 					\
			((const unsigned long) (a) << 24) | 	\
			((const unsigned long) (b) << 16) |		\
			((const unsigned long) (c) << 8)  | 	\
			((const unsigned long) (d)))

#define Q3_OBJECT_TYPE(a,b,c,d) \
	((TQ3ObjectType) Q3_FOUR_CHARACTER_CONSTANT(a,b,c,d))

#define Q3_METHOD_TYPE(a,b,c,d) \
	((TQ3XMethodType) Q3_FOUR_CHARACTER_CONSTANT(a,b,c,d))



/******************************************************************************
 **																			 **
 **								Object Types								 **
 **																			 **
 *****************************************************************************/

/*
 * Note:	a call to Q3Foo_GetType will return a value kQ3FooTypeBar
 *			e.g. Q3Shared_GetType(object) returns kQ3SharedTypeShape, etc.
 */
#define kQ3ObjectTypeInvalid							0L
#define kQ3ObjectTypeView								Q3_OBJECT_TYPE('v','i','e','w')
#define kQ3ObjectTypeElement							Q3_OBJECT_TYPE('e','l','m','n')
	#define kQ3ElementTypeAttribute						Q3_OBJECT_TYPE('e','a','t','t')
#define kQ3ObjectTypePick								Q3_OBJECT_TYPE('p','i','c','k')
	#define kQ3PickTypeWindowPoint						Q3_OBJECT_TYPE('p','k','w','p')
	#define kQ3PickTypeWindowRect						Q3_OBJECT_TYPE('p','k','w','r')
#define kQ3ObjectTypeShared								Q3_OBJECT_TYPE('s','h','r','d')
	#define kQ3SharedTypeRenderer						Q3_OBJECT_TYPE('r','d','d','r')
		#define kQ3RendererTypeWireFrame				Q3_OBJECT_TYPE('w','r','f','r')
		#define kQ3RendererTypeGeneric					Q3_OBJECT_TYPE('g','n','r','r')
		#define kQ3RendererTypeInteractive				Q3_OBJECT_TYPE('c','t','w','n')
	#define kQ3SharedTypeShape							Q3_OBJECT_TYPE('s','h','a','p')
		#define kQ3ShapeTypeGeometry					Q3_OBJECT_TYPE('g','m','t','r')
			#define kQ3GeometryTypeBox					Q3_OBJECT_TYPE('b','o','x',' ')
			#define kQ3GeometryTypeGeneralPolygon		Q3_OBJECT_TYPE('g','p','g','n')
			#define kQ3GeometryTypeLine					Q3_OBJECT_TYPE('l','i','n','e')
			#define kQ3GeometryTypeMarker				Q3_OBJECT_TYPE('m','r','k','r')
			#define kQ3GeometryTypePixmapMarker			Q3_OBJECT_TYPE('m','r','k','p')
			#define kQ3GeometryTypeMesh					Q3_OBJECT_TYPE('m','e','s','h')
			#define kQ3GeometryTypeNURBCurve			Q3_OBJECT_TYPE('n','r','b','c')
			#define kQ3GeometryTypeNURBPatch			Q3_OBJECT_TYPE('n','r','b','p')
			#define kQ3GeometryTypePoint				Q3_OBJECT_TYPE('p','n','t',' ')
			#define kQ3GeometryTypePolygon				Q3_OBJECT_TYPE('p','l','y','g')
			#define kQ3GeometryTypePolyLine				Q3_OBJECT_TYPE('p','l','y','l')
			#define kQ3GeometryTypeTriangle				Q3_OBJECT_TYPE('t','r','n','g')
			#define kQ3GeometryTypeTriGrid				Q3_OBJECT_TYPE('t','r','i','g')
			#define kQ3GeometryTypeCone					Q3_OBJECT_TYPE('c','o','n','e')
			#define kQ3GeometryTypeCylinder				Q3_OBJECT_TYPE('c','y','l','n')
			#define kQ3GeometryTypeDisk					Q3_OBJECT_TYPE('d','i','s','k')
			#define kQ3GeometryTypeEllipse				Q3_OBJECT_TYPE('e','l','p','s')
			#define kQ3GeometryTypeEllipsoid			Q3_OBJECT_TYPE('e','l','p','d')
			#define kQ3GeometryTypePolyhedron			Q3_OBJECT_TYPE('p','l','h','d')
			#define kQ3GeometryTypeTorus				Q3_OBJECT_TYPE('t','o','r','s')
			#define kQ3GeometryTypeTriMesh				Q3_OBJECT_TYPE('t','m','s','h')
		#define kQ3ShapeTypeShader						Q3_OBJECT_TYPE('s','h','d','r')
			#define kQ3ShaderTypeSurface				Q3_OBJECT_TYPE('s','u','s','h')
				#define kQ3SurfaceShaderTypeTexture		Q3_OBJECT_TYPE('t','x','s','u')
			#define kQ3ShaderTypeIllumination			Q3_OBJECT_TYPE('i','l','s','h')
				#define kQ3IlluminationTypePhong		Q3_OBJECT_TYPE('p','h','i','l')
				#define kQ3IlluminationTypeLambert		Q3_OBJECT_TYPE('l','m','i','l')
				#define kQ3IlluminationTypeNULL			Q3_OBJECT_TYPE('n','u','i','l')
		#define kQ3ShapeTypeStyle						Q3_OBJECT_TYPE('s','t','y','l')
			#define kQ3StyleTypeBackfacing				Q3_OBJECT_TYPE('b','c','k','f')
			#define kQ3StyleTypeInterpolation			Q3_OBJECT_TYPE('i','n','t','p')
			#define kQ3StyleTypeFill					Q3_OBJECT_TYPE('f','i','s','t')
			#define kQ3StyleTypePickID					Q3_OBJECT_TYPE('p','k','i','d')
			#define kQ3StyleTypeReceiveShadows			Q3_OBJECT_TYPE('r','c','s','h')
			#define kQ3StyleTypeHighlight				Q3_OBJECT_TYPE('h','i','g','h')
			#define kQ3StyleTypeSubdivision				Q3_OBJECT_TYPE('s','b','d','v')
			#define kQ3StyleTypeOrientation				Q3_OBJECT_TYPE('o','f','d','r')
			#define kQ3StyleTypePickParts				Q3_OBJECT_TYPE('p','k','p','t')
			#define kQ3StyleTypeAntiAlias				Q3_OBJECT_TYPE('a','n','t','i')
		#define kQ3ShapeTypeTransform					Q3_OBJECT_TYPE('x','f','r','m')
			#define kQ3TransformTypeMatrix				Q3_OBJECT_TYPE('m','t','r','x')
			#define kQ3TransformTypeScale				Q3_OBJECT_TYPE('s','c','a','l')
			#define kQ3TransformTypeTranslate			Q3_OBJECT_TYPE('t','r','n','s')
			#define kQ3TransformTypeRotate				Q3_OBJECT_TYPE('r','o','t','t')
			#define kQ3TransformTypeRotateAboutPoint 	Q3_OBJECT_TYPE('r','t','a','p')
			#define kQ3TransformTypeRotateAboutAxis 	Q3_OBJECT_TYPE('r','t','a','a')
			#define kQ3TransformTypeQuaternion			Q3_OBJECT_TYPE('q','t','r','n')
			#define kQ3TransformTypeReset				Q3_OBJECT_TYPE('r','s','e','t')
		#define kQ3ShapeTypeLight						Q3_OBJECT_TYPE('l','g','h','t')
			#define kQ3LightTypeAmbient					Q3_OBJECT_TYPE('a','m','b','n')
			#define kQ3LightTypeDirectional				Q3_OBJECT_TYPE('d','r','c','t')
			#define kQ3LightTypePoint					Q3_OBJECT_TYPE('p','n','t','l')
			#define kQ3LightTypeSpot					Q3_OBJECT_TYPE('s','p','o','t')
		#define kQ3ShapeTypeCamera						Q3_OBJECT_TYPE('c','m','r','a')
			#define kQ3CameraTypeOrthographic			Q3_OBJECT_TYPE('o','r','t','h')
			#define kQ3CameraTypeViewPlane				Q3_OBJECT_TYPE('v','w','p','l')
			#define kQ3CameraTypeViewAngleAspect		Q3_OBJECT_TYPE('v','a','n','a')
	
		#define kQ3ShapeTypeGroup						Q3_OBJECT_TYPE('g','r','u','p')
			#define kQ3GroupTypeDisplay					Q3_OBJECT_TYPE('d','s','p','g')
				#define kQ3DisplayGroupTypeOrdered		Q3_OBJECT_TYPE('o','r','d','g')
				#define kQ3DisplayGroupTypeIOProxy		Q3_OBJECT_TYPE('i','o','p','x')
			#define kQ3GroupTypeLight					Q3_OBJECT_TYPE('l','g','h','g')
			#define kQ3GroupTypeInfo					Q3_OBJECT_TYPE('i','n','f','o')
		#define kQ3ShapeTypeUnknown						Q3_OBJECT_TYPE('u','n','k','n')
			#define kQ3UnknownTypeText					Q3_OBJECT_TYPE('u','k','t','x')
			#define kQ3UnknownTypeBinary				Q3_OBJECT_TYPE('u','k','b','n')
		#define kQ3ShapeTypeReference					Q3_OBJECT_TYPE('r','f','r','n')
			#define kQ3ReferenceTypeExternal			Q3_OBJECT_TYPE('r','f','e','x')
	#define kQ3SharedTypeSet							Q3_OBJECT_TYPE('s','e','t',' ')
		#define kQ3SetTypeAttribute						Q3_OBJECT_TYPE('a','t','t','r')
	#define kQ3SharedTypeDrawContext					Q3_OBJECT_TYPE('d','c','t','x')
		#define kQ3DrawContextTypePixmap				Q3_OBJECT_TYPE('d','p','x','p')
		#if defined(WINDOW_SYSTEM_MACINTOSH) && WINDOW_SYSTEM_MACINTOSH
		#define kQ3DrawContextTypeMacintosh				Q3_OBJECT_TYPE('d','m','a','c')
		#endif  /*  WINDOW_SYSTEM_MACINTOSH  */
		#if defined(WINDOW_SYSTEM_WIN32) && WINDOW_SYSTEM_WIN32
		#define kQ3DrawContextTypeWin32DC				Q3_OBJECT_TYPE('d','w','3','2')
		#define kQ3DrawContextTypeDDSurface				Q3_OBJECT_TYPE('d','d','d','s')
		#endif  /*  WINDOW_SYSTEM_WIN32  */
		#if defined(WINDOW_SYSTEM_X11) && WINDOW_SYSTEM_X11
		#define kQ3DrawContextTypeX11					Q3_OBJECT_TYPE('d','x','1','1')
		#endif  /*  WINDOW_SYSTEM_X11  */
	#define kQ3SharedTypeTexture						Q3_OBJECT_TYPE('t','x','t','r')
		#define kQ3TextureTypePixmap					Q3_OBJECT_TYPE('t','x','p','m')
		#define kQ3TextureTypeMipmap					Q3_OBJECT_TYPE('t','x','m','m')
	#define kQ3SharedTypeFile							Q3_OBJECT_TYPE('f','i','l','e')
	#define kQ3SharedTypeStorage						Q3_OBJECT_TYPE('s','t','r','g')
		#define kQ3StorageTypeMemory					Q3_OBJECT_TYPE('m','e','m','s')
			#if defined(OS_MACINTOSH) && OS_MACINTOSH
			#define kQ3MemoryStorageTypeHandle			Q3_OBJECT_TYPE('h','n','d','l')
			#endif  /*  OS_MACINTOSH  */
		#define kQ3StorageTypeUnix						Q3_OBJECT_TYPE('u','x','s','t')
			#define kQ3UnixStorageTypePath				Q3_OBJECT_TYPE('u','n','i','x')
		#if defined(OS_MACINTOSH) && OS_MACINTOSH
		#define kQ3StorageTypeMacintosh					Q3_OBJECT_TYPE('m','a','c','n')
			#define kQ3MacintoshStorageTypeFSSpec		Q3_OBJECT_TYPE('m','a','c','p')					
		#endif  /*  OS_MACINTOSH  */
		#if defined(OS_WIN32) && OS_WIN32
		#define kQ3StorageTypeWin32						Q3_OBJECT_TYPE('w','i','s','t')
		#endif  /*  OS_WIN32  */
	#define kQ3SharedTypeString							Q3_OBJECT_TYPE('s','t','r','n')
		#define kQ3StringTypeCString					Q3_OBJECT_TYPE('s','t','r','c')
	#define kQ3SharedTypeShapePart						Q3_OBJECT_TYPE('s','p','r','t')
		#define kQ3ShapePartTypeMeshPart				Q3_OBJECT_TYPE('s','p','m','h')
			#define kQ3MeshPartTypeMeshFacePart			Q3_OBJECT_TYPE('m','f','a','c')
			#define kQ3MeshPartTypeMeshEdgePart			Q3_OBJECT_TYPE('m','e','d','g')
			#define kQ3MeshPartTypeMeshVertexPart		Q3_OBJECT_TYPE('m','v','t','x')
	#define kQ3SharedTypeControllerState				Q3_OBJECT_TYPE('c','t','s','t')
	#define kQ3SharedTypeTracker						Q3_OBJECT_TYPE('t','r','k','r')
	#define kQ3SharedTypeViewHints						Q3_OBJECT_TYPE('v','w','h','n')
	#define kQ3SharedTypeEndGroup						Q3_OBJECT_TYPE('e','n','d','g')


/******************************************************************************
 **																			 **
 **							QuickDraw 3D System Routines					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3Initialize(
	void);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Exit(
	void);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3IsInitialized(
	void);

QD3D_EXPORT TQ3Status QD3D_CALL Q3GetVersion(
	unsigned long		*majorRevision,
	unsigned long		*minorRevision);

/*
 *  Q3GetReleaseVersion returns the release version number,
 *  in the format of the first four bytes of a 'vers' resource
 *  (e.g. 0x01518000 ==> 1.5.1 release).
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3GetReleaseVersion(
	unsigned long		*releaseRevision);


/******************************************************************************
 **																			 **
 **							ObjectClass Routines							 **
 **																			 **
 *****************************************************************************/


/* 
 *  New object system calls to query the object system.
 *
 *  These comments to move to the stubs file before final release, they 
 *  are here for documentation for developers using early seeds.
 */

/*
 *  Given a class name as a string return the associated class type for the 
 *  class, may return kQ3Failure if the string representing the class is 
 *  invalid.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3ObjectHierarchy_GetTypeFromString(
	TQ3ObjectClassNameString	objectClassString, 
	TQ3ObjectType 				*objectClassType);
	
/*
 *  Given a class type as return the associated string for the class name, 
 *  may return kQ3Failure if the type representing the class is invalid.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3ObjectHierarchy_GetStringFromType(
	TQ3ObjectType				objectClassType, 
	TQ3ObjectClassNameString 	objectClassString);

/* 
 *  Return true if the class with this type is registered, false if not 
 */
QD3D_EXPORT TQ3Boolean QD3D_CALL Q3ObjectHierarchy_IsTypeRegistered(
	TQ3ObjectType				objectClassType);

/* 
 *  Return true if the class with this name is registered, false if not 
 */
QD3D_EXPORT TQ3Boolean QD3D_CALL Q3ObjectHierarchy_IsNameRegistered(
	const char					*objectClassName);

/*
 * TQ3SubClassData is used when querying the object system for
 * the subclasses of a particular parent type:
 */
typedef struct TQ3SubClassData {
	unsigned long 		numClasses;		/* the # of subclass types found */
										/* for a parent class 			 */
	TQ3ObjectType		*classTypes;	/* an array containing the class */
										/* types                         */
} TQ3SubClassData;

/*
 *  Given a parent type and an instance of the TQ3SubClassData struct fill
 *  it in with the number and class types of all of the subclasses immediately
 *  below the parent in the class hierarchy.  Return kQ3Success to indicate no
 *  errors occurred, else kQ3Failure.
 *
 *  NOTE:  This function will allocate memory for the classTypes array.  Be 
 *	sure to call Q3ObjectClass_EmptySubClassData to free this memory up.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3ObjectHierarchy_GetSubClassData(
	TQ3ObjectType				objectClassType, 
	TQ3SubClassData				*subClassData);

/*
 *  Given an instance of the TQ3SubClassData struct free all memory allocated 
 *	by the Q3ObjectClass_GetSubClassData call.
 *
 *  NOTE: This call MUST be made after a call to Q3ObjectClass_GetSubClassData
 *  to avoid memory leaks.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3ObjectHierarchy_EmptySubClassData(
	TQ3SubClassData				*subClassData);


/******************************************************************************
 **																			 **
 **								Object Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3Object_Dispose(
	TQ3Object 			object);
	
QD3D_EXPORT TQ3Object QD3D_CALL Q3Object_Duplicate(
	TQ3Object			object);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Object_Submit(
	TQ3Object			object,
	TQ3ViewObject		view);
	
QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Object_IsDrawable(
	TQ3Object			object);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Object_IsWritable(
	TQ3Object			object,
	TQ3FileObject		file);


/******************************************************************************
 **																			 **
 **							Object Type Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Object_GetType(
	TQ3Object			object);

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Object_GetLeafType(
	TQ3Object			object);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Object_IsType(
	TQ3Object			object,
	TQ3ObjectType		type);


/******************************************************************************
 **																			 **
 **							Shared Object Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Shared_GetType(
	TQ3SharedObject 	sharedObject);

QD3D_EXPORT TQ3SharedObject QD3D_CALL Q3Shared_GetReference(
	TQ3SharedObject 	sharedObject);

/* 
 *	Q3Shared_IsReferenced
 *		Returns kQ3True if there is more than one reference to sharedObject.
 *		Returns kQ3False if there is ONE reference to sharedObject.
 *	
 *	This call is intended to allow applications and plug-in objects to delete
 *	objects of which they hold THE ONLY REFERENCE. This is useful when
 *	caching objects, etc.
 *	
 *	Although many may be tempted, DO NOT DO THIS:
 *		while (Q3Shared_IsReferenced(foo)) { Q3Object_Dispose(foo); }
 *	
 *	Your application will crash and no one will buy it. Chapter 11 is 
 *	never fun (unless you short the stock). Thanks.
 */
QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Shared_IsReferenced(
	TQ3SharedObject 		sharedObject);

/*
 *	Q3Shared_GetEditIndex
 *		Returns the "serial number" of sharedObject. Usefuly for caching 
 *		object information. Returns 0 on error.
 *		
 *		Hold onto this number to determine if an object has changed since you
 *		last built your caches... To validate, do:
 *		
 *		if (Q3Shared_GetEditIndex(foo) == oldFooEditIndex) {
 *			// Cache is valid
 *		} else {
 *			// Cache is invalid
 *			RebuildSomeSortOfCache(foo);
 *			oldFooEditIndex = Q3Shared_GetEditIndex(foo);
 *		}
 */
QD3D_EXPORT unsigned long QD3D_CALL Q3Shared_GetEditIndex(
	TQ3SharedObject 		sharedObject);

/*
 *	Q3Shared_Edited
 *		Bumps the "serial number" of sharedObject to a different value. This
 *		call is intended to be used solely from a plug-in object which is 
 *		shared. Call this whenever your private instance data changes.
 *		
 *		Returns kQ3Failure iff sharedObject is not a shared object, OR
 *			QuickDraw 3D isn't initialized.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Shared_Edited(
	TQ3SharedObject 		sharedObject);


/******************************************************************************
 **																			 **
 **								Shape Routines								 **
 **																			 **
 *****************************************************************************/

/*
 *	QuickDraw 3D 1.1 Note:
 *
 *	Shapes and Sets are now (sort of) polymorphic.
 *
 *		You may call Q3Shape_Foo or Q3Set_Foo on a shape or a set.
 *		The following calls are identical, in implementation:
 *
 *			Q3Shape_GetElement			=	Q3Set_Get
 *			Q3Shape_AddElement			=	Q3Set_Add
 *			Q3Shape_ContainsElement		=	Q3Set_Contains
 *			Q3Shape_GetNextElementType	=	Q3Set_GetNextElementType
 *			Q3Shape_EmptyElements		=	Q3Set_Empty
 *			Q3Shape_ClearElement		=	Q3Set_Clear
 *
 *	All of these calls accept a shape or a set as their first parameter.
 *
 *	The Q3Shape_GetSet and Q3ShapeSetSet calls are implemented via a new
 *	element type kQ3ElementTypeSet. See the note above about 
 *	kQ3ElementTypeSet;
 *
 *	It is important to note that the new Q3Shape_...Element... calls do not
 *	create a set on a shape and then add the element to it. This data is
 *	attached directly to the shape. Therefore, it is possible for an element
 *	to exist on a shape without a set existing on it as well. 
 *
 *	In your application, if you attach an element to a shape like this:
 *		(this isn't checking for errors for simplicity)
 *
 *		set = Q3Set_New();
 *		Q3Set_Add(set, gMyElemType, &data);
 *		Q3Shape_SetSet(shape, set);
 *
 *	You should retrieve it in the same manner:
 *
 *		Q3Shape_GetSet(shape, &set);
 *		if (Q3Set_Contains(set, gMyElemType) == kQ3True) {
 *			Q3Set_Get(set, gMyElemType, &data);
 *		}
 *
 *	Similarly, if you attach data to a shape with the new calls:
 *
 *		Q3Shape_AddElement(shape, gMyElemType, &data);
 *
 *	You should retrieve it in the same manner:
 *
 *		if (Q3Shape_ContainsElement(set, gMyElemType) == kQ3True) {
 *			Q3Shape_GetElement(set, gMyElemType, &data);
 *		}
 *
 *	This really becomes an issue when dealing with version 1.0 and version 1.1 
 *	metafiles.
 *
 *	When attempting to find a particular element on a shape, you should
 *	first check with Q3Shape_GetNextElementType or Q3Shape_GetElement, then,
 *	Q3Shape_GetSet(s, &set) (or Q3Shape_GetElement(s, kQ3ElementTypeSet, &set))
 *	and then Q3Shape_GetElement(set, ...).
 *
 *	In terms of implementation, Q3Shape_SetSet and Q3Shape_GetSet should only be
 *	used for sets of information that are shared among multiple shapes.
 *	
 *	Q3Shape_AddElement, Q3Shape_GetElement, etc. calls should only be used
 *	for elements that are unique for a particular shape.
 *	
 */
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Shape_GetType(
	TQ3ShapeObject	shape);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_GetSet(
	TQ3ShapeObject	shape,
	TQ3SetObject	*set);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_SetSet(
	TQ3ShapeObject	shape,
	TQ3SetObject 	set);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_AddElement(
	TQ3ShapeObject	shape,
	TQ3ElementType	type,
	const void		*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_GetElement(
	TQ3ShapeObject	shape,
	TQ3ElementType	type,
	void			*data);
	
QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Shape_ContainsElement(
	TQ3ShapeObject	shape,
	TQ3ElementType	type);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_GetNextElementType(
	TQ3ShapeObject	shape,
	TQ3ElementType	*type);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_EmptyElements(
	TQ3ShapeObject	shape);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shape_ClearElement(
	TQ3ShapeObject	shape,
	TQ3ElementType	type);


/******************************************************************************
 **																			 **
 **							Color Table Routines							 **
 **																			 **
 *****************************************************************************/


QD3D_EXPORT TQ3Status QD3D_CALL Q3Bitmap_Empty(
	TQ3Bitmap					*bitmap);

QD3D_EXPORT unsigned long QD3D_CALL Q3Bitmap_GetImageSize(
	unsigned long				width,
	unsigned long				height);

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
	#if PRAGMA_ENUM_RESET_QD3D
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3D
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif /*  QD3D_h  */

