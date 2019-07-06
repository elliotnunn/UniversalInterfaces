/******************************************************************************
 **									 										 **
 ** 	Module:		QD3DIO.h												 **					
 **									 										 **
 **									 										 **
 ** 	Purpose:	QuickDraw 3D IO API										 **		
 **									 										 **
 **									 										 **
 **									 										 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 **									 										 **
 **									 										 **
 *****************************************************************************/
#ifndef QD3DIO_h
#define QD3DIO_h

#include "QD3D.h"
#include "QD3DDrawContext.h"
#include "QD3DView.h"

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
		#define PRAGMA_ENUM_RESET_QD3DIO 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */

#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/******************************************************************************
 **									 										 **
 **									Basic Types								 **												
 **									 										 **
 *****************************************************************************/

typedef unsigned char	TQ3Uns8;	/* 1 byte unsigned integer 				*/ 
typedef signed   char	TQ3Int8;	/* 1 byte signed integer 				*/ 
typedef unsigned short	TQ3Uns16;	/* 2 byte unsigned integer 				*/ 
typedef signed   short	TQ3Int16;	/* 2 byte signed integer 				*/ 
typedef unsigned long	TQ3Uns32;	/* 4 byte unsigned integer 				*/
typedef signed   long	TQ3Int32;	/* 4 byte signed integer 				*/

typedef struct TQ3Uns64 {
#if defined(OS_MACINTOSH) && OS_MACINTOSH
	unsigned long	hi;
	unsigned long 	lo;
#else
	unsigned long 	lo;
	unsigned long	hi;
#endif /* OS_MACINTOSH */
} TQ3Uns64;							/* 8 byte unsigned integer 				*/

typedef struct TQ3Int64 { 
#if defined(OS_MACINTOSH) && OS_MACINTOSH
	signed long		hi; 
	unsigned long	lo; 
#else
	unsigned long	lo; 
	signed long		hi; 
#endif /* OS_MACINTOSH */
} TQ3Int64;							/* 8 byte signed integer 				*/

typedef float			TQ3Float32;	/* 4 byte floating point number		 	*/
typedef double			TQ3Float64;	/* 8 byte floating point number		 	*/

typedef TQ3Uns32		TQ3Size;

/******************************************************************************
 **									 										 **
 **									File Types								 **
 **									 										 **
 *****************************************************************************/

typedef enum TQ3FileModeMasks {
	kQ3FileModeNormal		= 0,
	kQ3FileModeStream		= 1 << 0,
	kQ3FileModeDatabase		= 1 << 1,
	kQ3FileModeText			= 1 << 2
} TQ3FileModeMasks;

typedef unsigned long TQ3FileMode;

/******************************************************************************
 **									 										 **
 **									Method Types							 **
 **									 										 **
 *****************************************************************************/

/*
 *	IO Methods
 *
 *	The IO system treats all objects as groups of typed information.
 *	When you register your element or attribute, the "elementType" is the 
 *	binary type of your object, the "elementName" the ascii type.
 *	
 *	All objects in the metafile are made up of a "root" or parent object which
 *	defines the instantiated object type. You may define the format of your 
 *	data any way you wish as long as you use the primitives types above and the
 *	routines below.
 *
 *	Root Objects are often appended with additional child objects, called 
 *	subobjects. You may append your object with other QuickDraw 3D objects.
 *	
 *	Writing is straightforward: an object traverses itself any other objects 
 *	that make it up, then writes its own data. Writing uses two methods: 
 *	TQ3XObjectTraverseMethod and TQ3XObjectWriteMethod.
 *
 *	The TQ3XObjectTraverseMethod method should:
 *	+ First, Determine if the data should be written 
 *		- if you don't want to write out your object after examining your
 *			data, return kQ3Success in your Traverse method without calling
 *			any other submit calls.
 * 	+ Next, calculate the size of your object on disk
 * 	+ Gather whatever state from the view you need to preserve
 * 		- you may access the view state NOW, as the state of the
 * 			view duing your TQ3XObjectWriteMethod will not be valid. You may
 * 			pass a temporary buffer to your write method.
 * 	+ Submit your view write data using Q3View_SubmitWriteData
 * 		- note that you MUST call this before any other "_Submit" call.
 * 		- you may pass in a "deleteMethod" for your data. This method
 * 			will be called whether or not your write method succeeds or fails.
 * 	+ Submit your subobjects to the view
 * 	
 * 	The TQ3XObjectWriteMethod method should:
 * 	+ Write your data format to the file using the primitives routines below.
 * 		- If you passed a "deleteMethod" in your Q3View_SubmitWriteData, that
 *	 		method will be called upon exit of your write method.
 *
 *	Reading is less straightforward because your root object and
 *	any subobjects must be read inside of your TQ3XObjectReadDataMethod. There 
 *	is an implicit state contained in the file while reading, which you must 
 *	be aware of. When you first enter the read method, you must physically 
 *	read in your data format using the primitives routines until
 *	
 *	Q3File_IsEndOfData(file) == kQ3True
 *	
 *	Generally, your data format should be self-descriptive such that you do not
 *	need to call Q3File_IsEndOfData to determine if you are done reading. 
 *	However, this call is useful for determining zero-sized object or 
 *	determining the end of an object's data.
 *	
 *	Once you have read in all the data, you may collect subobjects. A metafile
 *	object ONLY has subobjects if it is in a container. The call
 *	
 *	Q3File_IsEndOfContainer(file)
 *	
 *	returns kQ3False if subobjects exist, and kQ3True if subobjects do not 
 *	exist.
 *	
 *	At this point, you may use
 *	
 *	Q3File_GetNextObjectType
 *	Q3File_IsNextObjectOfType
 *	Q3File_ReadObject
 *	Q3File_SkipObject
 *	
 *	to iterate through the subobjects until Q3File_IsEndOfContainer(file) 
 *	is kQ3True.
 * 
 */


/*
 * IO Methods
 */
#define kQ3XMethodTypeObjectFileVersion		Q3_METHOD_TYPE('v','e','r','s') /* version */
#define kQ3XMethodTypeObjectTraverse		Q3_METHOD_TYPE('t','r','v','s') /* byte count */
#define kQ3XMethodTypeObjectTraverseData	Q3_METHOD_TYPE('t','r','v','d') /* byte count */
#define kQ3XMethodTypeObjectWrite			Q3_METHOD_TYPE('w','r','i','t') /* Dump info to file */
#define kQ3XMethodTypeObjectReadData		Q3_METHOD_TYPE('r','d','d','t') /* Read info from file into buffer or, attach read data to parent */ 
#define kQ3XMethodTypeObjectRead			Q3_METHOD_TYPE('r','e','a','d')
#define kQ3XMethodTypeObjectAttach			Q3_METHOD_TYPE('a','t','t','c')

/*
 *	TQ3XObjectTraverseMethod
 *
 *	For "elements" (meaning "attributes, too), you will be passed NULL for 
 *	object. Sorry, custom objects will be available in the next major revision.
 *
 *	The "data" is a pointer to your internal element data.
 *
 *	The view is the current traversal view.
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectTraverseMethod)(
	TQ3Object			object,
	void				*data,
	TQ3ViewObject		view);

/*
 *  TQ3XObjectTraverseDataMethod
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectTraverseDataMethod)(
	TQ3Object			object,
	void				*data,
	TQ3ViewObject		view);

/*
 *  TQ3XObjectWriteMethod
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectWriteMethod)(
	const void			*object,
	TQ3FileObject		file);

/*
 *  Custom object writing 
 */
typedef void (QD3D_CALLBACK *TQ3XDataDeleteMethod)(
	void					*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XView_SubmitWriteData(
	TQ3ViewObject			view,
	TQ3Size					size,	
	void					*data,
	TQ3XDataDeleteMethod	deleteData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XView_SubmitSubObjectData(
	TQ3ViewObject			view,
	TQ3XObjectClass			objectClass,
	unsigned long			size,
	void					*data,
	TQ3XDataDeleteMethod	deleteData);

/*
 *  TQ3XObjectReadMethod
 */
typedef TQ3Object (QD3D_CALLBACK *TQ3XObjectReadMethod)(
	TQ3FileObject		file);

/*
 *	TQ3XObjectReadDataMethod
 *
 *  For "elements" (meaning "attributes", too), you must allocate stack space 
 *	and call Q3Set_Add on "parentObject", which is an TQ3SetObject.
 *
 *	Otherwise, parentObject is whatever object your element is a subobject of...
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectReadDataMethod)(
	TQ3Object			parentObject,
	TQ3FileObject		file);

/*
 *  TQ3XObjectAttachMethod
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectAttachMethod)(
	TQ3Object			childObject,
	TQ3Object			parentObject);


/******************************************************************************
 **									 										 **
 **								Versioning									 **
 **									 										 **
 *****************************************************************************/

#define Q3FileVersion(majorVersion, minorVersion)					\
	(TQ3FileVersion) ((((TQ3Uns32) majorVersion & 0xFFFF) << 16) | 	\
					   ((TQ3Uns32) minorVersion & 0xFFFF))

typedef unsigned long			TQ3FileVersion;
#define kQ3FileVersionCurrent	Q3FileVersion(1, 5)


/******************************************************************************
 **									 										 **
 **								File Routines								 **
 **									 										 **
 *****************************************************************************/
/*
 *  Creation and accessors
 */
QD3D_EXPORT TQ3FileObject QD3D_CALL Q3File_New(
	void);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_GetStorage(
	TQ3FileObject		file,
	TQ3StorageObject	*storage);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_SetStorage(
	TQ3FileObject		file,
	TQ3StorageObject	storage);

/*
 *  Opening, and accessing "open" state, closing/cancelling
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3File_OpenRead(
	TQ3FileObject		file,
	TQ3FileMode			*mode);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_OpenWrite(
	TQ3FileObject		file,
	TQ3FileMode			mode);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_IsOpen(
	TQ3FileObject		file,
	TQ3Boolean			*isOpen);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_GetMode(
	TQ3FileObject		file,
	TQ3FileMode			*mode);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_GetVersion(
	TQ3FileObject		file,
	TQ3FileVersion		*version);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_Close(
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_Cancel(
	TQ3FileObject		file);

/*
 *  Writing (Application)
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3View_StartWriting(
	TQ3ViewObject 		view,
	TQ3FileObject		file);

QD3D_EXPORT TQ3ViewStatus QD3D_CALL Q3View_EndWriting(
	TQ3ViewObject 		view);

/*
 *  Reading (Application)
 */
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3File_GetNextObjectType(
	TQ3FileObject		file);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3File_IsNextObjectOfType(
	TQ3FileObject		file,
	TQ3ObjectType		ofType);

QD3D_EXPORT TQ3Object QD3D_CALL Q3File_ReadObject(
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_SkipObject(
	TQ3FileObject		file);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3File_IsEndOfData(
	TQ3FileObject		file);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3File_IsEndOfContainer(
	TQ3FileObject		file,
	TQ3Object			rootObject);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3File_IsEndOfFile(
	TQ3FileObject		file);

/*	
 *  External file references
 */	
QD3D_EXPORT TQ3Status QD3D_CALL Q3File_MarkAsExternalReference(
	TQ3FileObject		file,
	TQ3SharedObject		sharedObject);

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3File_GetExternalReferences(
	TQ3FileObject			file);

/*	
 *  Tracking editing in read-in objects with custom elements
 */	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Shared_ClearEditTracking(
	TQ3SharedObject		sharedObject);
	
QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Shared_GetEditTrackingState(
	TQ3SharedObject		sharedObject);

/*	
 *  Reading objects inside a group one-by-one
 */	
typedef enum TQ3FileReadGroupStateMasks {
	kQ3FileReadWholeGroup		= 0,
	kQ3FileReadObjectsInGroup	= 1 << 0,
	kQ3FileCurrentlyInsideGroup	= 1 << 1
} TQ3FileReadGroupStateMasks;

typedef unsigned long TQ3FileReadGroupState;

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_SetReadInGroup(
	TQ3FileObject			file,
	TQ3FileReadGroupState	readGroupState);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3File_GetReadInGroup(
	TQ3FileObject			file,
	TQ3FileReadGroupState	*readGroupState);


/*
 *  Idling
 */
typedef TQ3Status (QD3D_CALLBACK *TQ3FileIdleMethod)(
	TQ3FileObject		file,
	const void			*idlerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3File_SetIdleMethod(
	TQ3FileObject		file,
	TQ3FileIdleMethod	idle,
	const void			*idleData);
	

/******************************************************************************
 **									 										 **
 **								Primitives Routines							 **
 **									 										 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3NewLine_Write(
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns8_Read(
	TQ3Uns8				*data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns8_Write(
	const TQ3Uns8		data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns16_Read(
	TQ3Uns16			*data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns16_Write(
	const TQ3Uns16		data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns32_Read(
	TQ3Uns32			*data,
	TQ3FileObject		file);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns32_Write(
	const TQ3Uns32		data,
	TQ3FileObject		file);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Int8_Read(
	TQ3Int8				*data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Int8_Write(
	const TQ3Int8		data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Int16_Read(
	TQ3Int16			*data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Int16_Write(
	const TQ3Int16		data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Int32_Read(
	TQ3Int32			*data,
	TQ3FileObject		file);
			
QD3D_EXPORT TQ3Status QD3D_CALL Q3Int32_Write(
	const TQ3Int32		data,
	TQ3FileObject		file);
			
QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns64_Read(
	TQ3Uns64			*data,
	TQ3FileObject		file);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3Uns64_Write(
	const TQ3Uns64		data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Int64_Read(
	TQ3Int64			*data,
	TQ3FileObject		file);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3Int64_Write(
	const TQ3Int64		data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Float32_Read(
	TQ3Float32			*data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Float32_Write(
	const TQ3Float32	data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Float64_Read(
	TQ3Float64			*data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Float64_Write(
	const TQ3Float64	data,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Size QD3D_CALL Q3Size_Pad(
	TQ3Size				size);

/*
 *  Pass a pointer to a buffer of kQ3StringMaximumLength bytes
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3String_Read(
	char				*data,
	unsigned long		*length,
	TQ3FileObject		file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3String_Write(
	const char			*data,
	TQ3FileObject		file);

/* 
 *  This call will read Q3Size_Pad(size) bytes,
 *	but only place size bytes into data.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3RawData_Read(
	unsigned char		*data,
	unsigned long		size,
	TQ3FileObject		file);

/* 
 *  This call will write Q3Size_Pad(size) bytes,
 *	adding 0's to pad to the nearest 4 byte boundary.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3RawData_Write(
	const unsigned char	*data,
	unsigned long		size,
	TQ3FileObject		file);

/******************************************************************************
 **									 										 **
 **						Convenient Primitives Routines						 **
 **									 										 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3Point2D_Read(
	TQ3Point2D					*point2D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Point2D_Write(
	const TQ3Point2D			*point2D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Point3D_Read(
	TQ3Point3D					*point3D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Point3D_Write(
	const TQ3Point3D			*point3D,
	TQ3FileObject				file);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3RationalPoint3D_Read(
	TQ3RationalPoint3D			*point3D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RationalPoint3D_Write(
	const TQ3RationalPoint3D	*point3D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RationalPoint4D_Read(
	TQ3RationalPoint4D			*point4D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3RationalPoint4D_Write(
	const TQ3RationalPoint4D	*point4D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Vector2D_Read(
	TQ3Vector2D					*vector2D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Vector2D_Write(
	const TQ3Vector2D			*vector2D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Vector3D_Read(
	TQ3Vector3D					*vector3D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Vector3D_Write(
	const TQ3Vector3D			*vector3D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Matrix4x4_Read(
	TQ3Matrix4x4				*matrix4x4,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Matrix4x4_Write(
	const TQ3Matrix4x4			*matrix4x4,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tangent2D_Read(
	TQ3Tangent2D				*tangent2D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tangent2D_Write(
	const TQ3Tangent2D			*tangent2D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tangent3D_Read(
	TQ3Tangent3D				*tangent3D,
	TQ3FileObject				file);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tangent3D_Write(
	const TQ3Tangent3D			*tangent3D,
	TQ3FileObject				file);

/*	
 *  This call affects only text Files - it is a no-op in binary files 
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Comment_Write(
	char						*comment,
	TQ3FileObject				file);

/******************************************************************************
 **									 										 **
 **								Unknown Object								 **
 **									 										 **
 **		Unknown objects are generated when reading files which contain		 **
 **		custom data which has not been registered in the current			 **
 **		instantiation of QuickDraw 3D.										 **
 **									 										 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Unknown_GetType(
	TQ3UnknownObject		unknownObject);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Unknown_GetDirtyState(
	TQ3UnknownObject		unknownObject,
	TQ3Boolean				*isDirty);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Unknown_SetDirtyState(
	TQ3UnknownObject		unknownObject,
	TQ3Boolean				isDirty);


/******************************************************************************
 **									 										 **
 **							Unknown Text Routines							 **
 **									 										 **
 *****************************************************************************/

typedef struct TQ3UnknownTextData {
	char					*objectName;	/* '\0' terminated */
	char					*contents;		/* '\0' terminated */
} TQ3UnknownTextData;

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnknownText_GetData(
	TQ3UnknownObject		unknownObject,
	TQ3UnknownTextData		*unknownTextData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnknownText_EmptyData(
	TQ3UnknownTextData		*unknownTextData);


/******************************************************************************
 **									 										 **
 **							Unknown Binary Routines							 **
 **									 										 **
 *****************************************************************************/

typedef struct TQ3UnknownBinaryData {
	TQ3ObjectType			objectType;
	unsigned long			size;
	TQ3Endian				byteOrder;
	char					*contents;
} TQ3UnknownBinaryData;

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnknownBinary_GetData(
	TQ3UnknownObject		unknownObject,
	TQ3UnknownBinaryData	*unknownBinaryData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnknownBinary_EmptyData(
	TQ3UnknownBinaryData	*unknownBinaryData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnknownBinary_GetTypeString(
	TQ3UnknownObject	unknownObject,
	char				**typeString);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3UnknownBinary_EmptyTypeString(
	char	**typeString);


/******************************************************************************
 **									 										 **
 **							ViewHints routines								 **
 **									 										 **
 **		ViewHints are an object in a metafile to give you some hints on how	 **
 **		to render a scene.	You may create a view with any of the objects	 **
 **		retrieved from it, or you can just throw it away.					 **
 **									 										 **
 **		To write a view hints to a file, create a view hints object from a	 **
 **		view and write the view hints.										 **
 **									 										 **
 *****************************************************************************/

QD3D_EXPORT TQ3ViewHintsObject QD3D_CALL Q3ViewHints_New(
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetRenderer(
	TQ3ViewHintsObject		viewHints,
	TQ3RendererObject		renderer);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetRenderer(
	TQ3ViewHintsObject		viewHints,
	TQ3RendererObject		*renderer);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetCamera(
	TQ3ViewHintsObject		viewHints,
	TQ3CameraObject			camera);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetCamera(
	TQ3ViewHintsObject		viewHints,
	TQ3CameraObject			*camera);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetLightGroup(
	TQ3ViewHintsObject		viewHints,
	TQ3GroupObject			lightGroup);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetLightGroup(
	TQ3ViewHintsObject		viewHints,
	TQ3GroupObject			*lightGroup);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetAttributeSet(
	TQ3ViewHintsObject		viewHints,
	TQ3AttributeSet			attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetAttributeSet(
	TQ3ViewHintsObject		viewHints,
	TQ3AttributeSet			*attributeSet);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetDimensionsState(
	TQ3ViewHintsObject		viewHints,
	TQ3Boolean				isValid);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetDimensionsState(
	TQ3ViewHintsObject		viewHints,
	TQ3Boolean				*isValid);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetDimensions(
	TQ3ViewHintsObject		viewHints,
	unsigned long			width,
	unsigned long			height);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetDimensions(
	TQ3ViewHintsObject		viewHints,
	unsigned long			*width,
	unsigned long			*height);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetMaskState(
	TQ3ViewHintsObject		viewHints,
	TQ3Boolean				isValid);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetMaskState(
	TQ3ViewHintsObject		viewHints,
	TQ3Boolean				*isValid);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetMask(	
	TQ3ViewHintsObject		viewHints,
	const TQ3Bitmap			*mask);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetMask(	
	TQ3ViewHintsObject		viewHints,
	TQ3Bitmap				*mask);

/* 
 *  Call Q3Bitmap_Empty when done with the mask	
 */

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetClearImageMethod(
	TQ3ViewHintsObject				viewHints,
	TQ3DrawContextClearImageMethod	clearMethod);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetClearImageMethod(
	TQ3ViewHintsObject				viewHints,
	TQ3DrawContextClearImageMethod	*clearMethod);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_SetClearImageColor(
	TQ3ViewHintsObject		viewHints,
	const TQ3ColorARGB 		*color);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ViewHints_GetClearImageColor(
	TQ3ViewHintsObject		viewHints,
	TQ3ColorARGB 			*color);


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
	#if PRAGMA_ENUM_RESET_QD3DIO
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DIO
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif /* QD3DIO_h */
