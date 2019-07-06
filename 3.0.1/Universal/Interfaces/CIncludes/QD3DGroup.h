/******************************************************************************
 **																			 **
 ** 	Module:		QD3DGroup.h												 **
 **																			 **
 **																			 **
 ** 	Purpose:	Group definitions and routines							 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DGroup_h
#define QD3DGroup_h

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
		#define PRAGMA_ENUM_RESET_QD3DGROUP 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */

#ifdef __cplusplus
extern "C" {
#endif /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **							Group Typedefs									 **
 **																			 **
 *****************************************************************************/

/*
 *  These flags affect how a group is traversed
 *  They apply to when a group is "drawn", "picked", "bounded", "written"
 */
typedef enum TQ3DisplayGroupStateMasks {
	kQ3DisplayGroupStateNone					= 0,
	kQ3DisplayGroupStateMaskIsDrawn				= 1 << 0,
	kQ3DisplayGroupStateMaskIsInline			= 1 << 1,
	kQ3DisplayGroupStateMaskUseBoundingBox		= 1 << 2,
	kQ3DisplayGroupStateMaskUseBoundingSphere	= 1 << 3,
	kQ3DisplayGroupStateMaskIsPicked			= 1 << 4,
	kQ3DisplayGroupStateMaskIsWritten			= 1 << 5
} TQ3DisplayGroupStateMasks;

typedef unsigned long TQ3DisplayGroupState;


/******************************************************************************
 **																			 **
 **					Group Routines (apply to all groups)					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3Group_New(		/* May contain any shared object */
	void);
	
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Group_GetType(
	TQ3GroupObject			group);

QD3D_EXPORT TQ3GroupPosition QD3D_CALL Q3Group_AddObject(
	TQ3GroupObject			group,
	TQ3Object				object);
	
QD3D_EXPORT TQ3GroupPosition QD3D_CALL Q3Group_AddObjectBefore(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,
	TQ3Object				object);

QD3D_EXPORT TQ3GroupPosition QD3D_CALL Q3Group_AddObjectAfter(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,
	TQ3Object				object);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetPositionObject(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,	
	TQ3Object				*object);		

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_SetPositionObject(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,
	TQ3Object				object);

QD3D_EXPORT TQ3Object QD3D_CALL Q3Group_RemovePosition(
	TQ3GroupObject			group,
	TQ3GroupPosition		position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetFirstPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetLastPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetNextPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetPreviousPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_CountObjects(
	TQ3GroupObject			group,
	unsigned long			*nObjects);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_EmptyObjects(
	TQ3GroupObject			group);
	
/*
 * 	Typed Access
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetFirstPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetLastPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetNextPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetPreviousPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_CountObjectsOfType(
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	unsigned long			*nObjects);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_EmptyObjectsOfType(
	TQ3GroupObject			group,
	TQ3ObjectType			isType);

/*
 *	Determine position of objects in a group
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetFirstObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetLastObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetNextObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3Group_GetPreviousObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);
	

/******************************************************************************
 **																			 **
 **							Group Subclasses								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3LightGroup_New(	/* Must contain only lights */
	void);

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3InfoGroup_New(		/* Must contain only strings */
	void);


/******************************************************************************
 **																			 **
 **						Display Group Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3DisplayGroup_New(	/* May contain only drawables*/
	void);
	
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3DisplayGroup_GetType(
	TQ3GroupObject			group);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DisplayGroup_GetState(
	TQ3GroupObject			group,
	TQ3DisplayGroupState	*state);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3DisplayGroup_SetState(
	TQ3GroupObject			group,
	TQ3DisplayGroupState	state);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DisplayGroup_Submit(
	TQ3GroupObject			group, 
	TQ3ViewObject			view);


/*
 *
 *	Ordered Display Group
 *
 *	Ordered display groups keep objects in order by the type of object:
 *
 *	1	kQ3ShapeTypeTransform
 *	2	kQ3ShapeTypeStyle
 *	3	kQ3SetTypeAttribute
 *	4	kQ3ShapeTypeShader
 *	5	kQ3ShapeTypeCamera
 *	6	kQ3ShapeTypeLight
 *	7	kQ3ShapeTypeGeometry
 *	8	kQ3ShapeTypeGroup			
 *	9	kQ3ShapeTypeUnknown
 *
 *	Within a type, you are responsible for keeping things in order.
 *
 *	You may access and/or manipulate the group using the above types
 *	(fast), or you may use any parent or leaf class types (slower).
 *
 *	Additional types will be added as functionality grows.
 *
 *	The group calls which access by type are much faster for ordered 
 *	display group for the types above.*
 *
 *  N.B. In QuickDraw 3D 1.0 Lights and Cameras are a no-op when drawn
 *
 */

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3OrderedDisplayGroup_New(
	void);

/*
 *
 *	IO Proxy Display Group
 *
 *	IO Proxy display groups are used to place more than one
 *	representation of an object in a metafile. For example, if you know
 *	another program does not understand NURBPatches but does understand
 *	Meshes, you may place a mesh and a NURB Patch in an IO Proxy Group,
 *	and the reading program will select the desired representation.
 *
 *	Objects in an IO Proxy Display Group are placed in their preferred
 *	order, with the FIRST object being the MOST preferred, the LAST
 *	object the least preferred.
 *
 *	The behavior of an IO Proxy Display Group is that when drawn/picked/
 *	bounded, the first object in the group that is not "Unknown" is used,
 *	and the other objects ignored.
 *
 */

QD3D_EXPORT TQ3GroupObject QD3D_CALL Q3IOProxyDisplayGroup_New(
	void);

/******************************************************************************
 **																			 **
 **						Group Extension Definitions							 **
 **																			 **
 *****************************************************************************/
/*
 *	Searching methods - OPTIONAL
 */
#define kQ3XMethodType_GroupAcceptObject				\
	Q3_METHOD_TYPE('g','a','c','o')
typedef TQ3Boolean (QD3D_CALLBACK *TQ3XGroupAcceptObjectMethod)(
	TQ3GroupObject		group,
	TQ3Object			object);

#define kQ3XMethodType_GroupAddObject					\
	Q3_METHOD_TYPE('g','a','d','o')
typedef TQ3GroupPosition (QD3D_CALLBACK *TQ3XGroupAddObjectMethod)(
	TQ3GroupObject		group,
	TQ3Object			object);

#define kQ3XMethodType_GroupAddObjectBefore				\
	Q3_METHOD_TYPE('g','a','o','b')
typedef TQ3GroupPosition (QD3D_CALLBACK *TQ3XGroupAddObjectBeforeMethod)(
	TQ3GroupObject		group,
	TQ3GroupPosition	position,
	TQ3Object			object);

#define kQ3XMethodType_GroupAddObjectAfter				\
	Q3_METHOD_TYPE('g','a','o','a')
typedef TQ3GroupPosition (QD3D_CALLBACK *TQ3XGroupAddObjectAfterMethod)(
	TQ3GroupObject		group,
	TQ3GroupPosition	position,
	TQ3Object			object);

#define kQ3XMethodType_GroupSetPositionObject 			\
	Q3_METHOD_TYPE('g','s','p','o')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupSetPositionObjectMethod)(
	TQ3GroupObject		group,
	TQ3GroupPosition	gPos,
	TQ3Object			obj);

#define kQ3XMethodType_GroupRemovePosition				\
	Q3_METHOD_TYPE('g','r','m','p')
typedef TQ3Object (QD3D_CALLBACK *TQ3XGroupRemovePositionMethod)(
	TQ3GroupObject		group,
	TQ3GroupPosition	position);

/*
 *	Searching methods - OPTIONAL - default uses above methods
 */
#define kQ3XMethodType_GroupGetFirstPositionOfType 		\
	Q3_METHOD_TYPE('g','f','r','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetFirstPositionOfTypeMethod)(
	TQ3GroupObject		group,
	TQ3ObjectType		isType,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupGetLastPositionOfType		\
	Q3_METHOD_TYPE('g','l','s','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetLastPositionOfTypeMethod)(
	TQ3GroupObject		group,
	TQ3ObjectType		isType,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupGetNextPositionOfType		\
	Q3_METHOD_TYPE('g','n','x','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetNextPositionOfTypeMethod)(
	TQ3GroupObject		group,
	TQ3ObjectType		isType,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupGetPrevPositionOfType		\
	Q3_METHOD_TYPE('g','p','v','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetPrevPositionOfTypeMethod)(
	TQ3GroupObject		group,
	TQ3ObjectType		isType,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupCountObjectsOfType			\
	Q3_METHOD_TYPE('g','c','n','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupCountObjectsOfTypeMethod)(
	TQ3GroupObject		group,
	TQ3ObjectType		isType,
	unsigned long		*nObjects);

#define kQ3XMethodType_GroupEmptyObjectsOfType			\
	Q3_METHOD_TYPE('g','e','o','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupEmptyObjectsOfTypeMethod)(
	TQ3GroupObject		group,
	TQ3ObjectType		isType);

#define kQ3XMethodType_GroupGetFirstObjectPosition		\
	Q3_METHOD_TYPE('g','f','o','p')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetFirstObjectPositionMethod)(
	TQ3GroupObject		group,
	TQ3Object			object,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupGetLastObjectPosition		\
	Q3_METHOD_TYPE('g','l','o','p')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetLastObjectPositionMethod)(
	TQ3GroupObject		group,
	TQ3Object			object,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupGetNextObjectPosition		\
	Q3_METHOD_TYPE('g','n','o','p')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetNextObjectPositionMethod)(
	TQ3GroupObject		group,
	TQ3Object			object,
	TQ3GroupPosition	*gPos);

#define kQ3XMethodType_GroupGetPrevObjectPosition		\
	Q3_METHOD_TYPE('g','p','o','p')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupGetPrevObjectPositionMethod)(
	TQ3GroupObject		group,
	TQ3Object			object,
	TQ3GroupPosition	*gPos);

/*
 *	Group Position Methods
 *	
 */
#define kQ3XMethodType_GroupPositionSize			\
	Q3_METHOD_TYPE('g','g','p','z')
typedef unsigned long TQ3XMethodTypeGroupPositionSize;

#define kQ3XMethodType_GroupPositionNew				\
	Q3_METHOD_TYPE('g','g','p','n')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupPositionNewMethod)(
	void					*gPos,
	TQ3Object				object,
	const void				*initData);

#define kQ3XMethodType_GroupPositionCopy			\
	Q3_METHOD_TYPE('g','g','p','c')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupPositionCopyMethod)(
	void					*srcGPos,
	void					*dstGPos);

#define kQ3XMethodType_GroupPositionDelete			\
	Q3_METHOD_TYPE('g','g','p','d')
typedef void (QD3D_CALLBACK *TQ3XGroupPositionDeleteMethod)(
	void					*gPos);

/*
 *	View Drawing Helpers
 *	
 *	TQ3XGroupStartIterateMethod
 *
 *		Pass back *object = NULL to NOT call EndIterate iterate
 *		Pass back *object != NULL to draw object
 *		 (other side will pass it to EndIterate for deletion!)
 *
 *		*iterator is uninitialized, use for iteration state. Caller should 
 *		 ignore it.
 *	
 *	TQ3XGroupEndIterateMethod
 *	
 *		*object is previous object, dispose it or play with it.
 *		Pass back NULL when last iteration has occurred
 *		*iterator is previous value, use for iteration state Caller should 
 *		ignore it.
 */
#define kQ3XMethodType_GroupStartIterate			\
	Q3_METHOD_TYPE('g','s','t','d')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupStartIterateMethod)(
	TQ3GroupObject		group,
	TQ3GroupPosition	*iterator,
	TQ3Object 			*object,
	TQ3ViewObject		view);

#define kQ3XMethodType_GroupEndIterate				\
	Q3_METHOD_TYPE('g','i','t','d')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupEndIterateMethod)(
	TQ3GroupObject		group,
	TQ3GroupPosition	*iterator,
	TQ3Object 			*object,
	TQ3ViewObject		view);

/*
 *	IO  Helpers
 *	
 *	TQ3XGroupEndReadMethod
 *		Called when a group has been completely read. Group should perform
 *		validation and clean up any reading caches.
 */
#define kQ3XMethodType_GroupEndRead					\
	Q3_METHOD_TYPE('g','e','r','d')
typedef TQ3Status (QD3D_CALLBACK *TQ3XGroupEndReadMethod)(
	TQ3GroupObject		group);


QD3D_EXPORT void *QD3D_CALL Q3XGroup_GetPositionPrivate(
	TQ3GroupObject			group,
	TQ3GroupPosition		position);
	
#ifdef __cplusplus
}
#endif /*  __cplusplus  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DGROUP
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DGROUP
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif /*  QD3DGroup_h  */
