/******************************************************************************
 **																			 **
 ** 	Module:		QD3DSet.h												 **
 **																			 **
 **																			 **
 ** 	Purpose: 	Set types and routines									 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DSet_h
#define QD3DSet_h

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
		#define PRAGMA_ENUM_RESET_QD3DSET 1
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
 **								Set Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3SetObject QD3D_CALL Q3Set_New(
	void);

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Set_GetType(
	TQ3SetObject		set);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Set_Add(
	TQ3SetObject 		set, 
	TQ3ElementType		type,
	const void 			*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Set_Get(
	TQ3SetObject 		set,
	TQ3ElementType		type,
	void				*data);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Set_Contains(
	TQ3SetObject 		set,
	TQ3ElementType		type);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Set_Clear(
	TQ3SetObject 		set, 
	TQ3ElementType		type);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Set_Empty(
	TQ3SetObject 		target);

/*
 *  Iterating through all elements in a set
 *
 *  Pass in kQ3ElementTypeNone to get first type
 *  kQ3ElementTypeNone is returned when end of list is reached
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3Set_GetNextElementType(
	TQ3SetObject 		set,
	TQ3ElementType		*type);		


/******************************************************************************
 **																			 **
 **								Attribute Types								 **
 **																			 **
 *****************************************************************************/

/* 
 *	For the data types listed below, pass in a pointer to it in the _Add 
 *	and _Get calls.
 *
 *	For surface shader attributes, reference counts are incremented on 
 *	the _Add and _Get 
 */

typedef enum TQ3AttributeTypes {				/* Data Type				*/
	kQ3AttributeTypeNone				=  0,	/* ---------				*/
	kQ3AttributeTypeSurfaceUV			=  1,	/* TQ3Param2D				*/ 
	kQ3AttributeTypeShadingUV			=  2,	/* TQ3Param2D 				*/
	kQ3AttributeTypeNormal				=  3,	/* TQ3Vector3D 				*/
	kQ3AttributeTypeAmbientCoefficient	=  4,	/* float 					*/
	kQ3AttributeTypeDiffuseColor		=  5,	/* TQ3ColorRGB				*/
	kQ3AttributeTypeSpecularColor		=  6,	/* TQ3ColorRGB				*/
	kQ3AttributeTypeSpecularControl		=  7,	/* float					*/
	kQ3AttributeTypeTransparencyColor	=  8,	/* TQ3ColorRGB				*/
	kQ3AttributeTypeSurfaceTangent		=  9,	/* TQ3Tangent2D  			*/
	kQ3AttributeTypeHighlightState		= 10,	/* TQ3Switch 				*/
	kQ3AttributeTypeSurfaceShader		= 11,	/* TQ3SurfaceShaderObject	*/
	kQ3AttributeTypeNumTypes
} TQ3AttributeTypes;

typedef TQ3ElementType TQ3AttributeType;


/******************************************************************************
 **																			 **
 **								Attribute Drawing							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3Attribute_Submit(
	TQ3AttributeType		attributeType,
	const void				*data,
	TQ3ViewObject			view);


/******************************************************************************
 **																			 **
 **							AttributeSet Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3AttributeSet QD3D_CALL Q3AttributeSet_New(
	void);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_Add(
	TQ3AttributeSet 		attributeSet, 
	TQ3AttributeType		type,
	const void 				*data);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3AttributeSet_Contains(
	TQ3AttributeSet			attributeSet,
	TQ3AttributeType		attributeType);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_Get(
	TQ3AttributeSet 		attributeSet,
	TQ3AttributeType		type,
	void					*data);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_Clear(
	TQ3AttributeSet 		attributeSet,
	TQ3AttributeType		type);

QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_Empty(
	TQ3AttributeSet 		target);

/*
 * Q3AttributeSet_GetNextAttributeType
 *
 * Pass in kQ3AttributeTypeNone to get first type
 * kQ3AttributeTypeNone is returned when end of list is reached
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_GetNextAttributeType(
	TQ3AttributeSet 		source,
	TQ3AttributeType		*type);		

QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_Submit(
	TQ3AttributeSet			attributeSet, 
	TQ3ViewObject			view);

/*
 * Inherit from parent->child into result
 *	Result attributes are:
 *		all child attributes + all parent attributes NOT in the child
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3AttributeSet_Inherit(
	TQ3AttributeSet			parent, 
	TQ3AttributeSet			child, 
	TQ3AttributeSet			result);


/******************************************************************************
 **																			 **
 **							Custom Element Registration						 **
 **																			 **
 *****************************************************************************/

/*
 * Element Methods - 
 *
 * 		When you create a custom element, you control what structures are 
 *		passed around the API. For example, you may allow the Q3Set_Add call 
 *		take one type of argument, store your element internally in some 
 *		abstract data type, and have the Q3Set_Get call take a different 
 *		argument.
 *
 *		For example:
 *			
 *		There are four calls which at some point will copy an element:
 *
 *		Q3Set_Add (copied from Application memory to QuickDraw3D memory)
 *		Q3Set_Get (copied from QuickDraw3D memory to Application memory)
 *		Q3Object_Duplicate (all elements are copied internally)
 *		Q3AttributeSet_Inherit (all elements are copied internally)
 *
 * 		Either CopyAdd or CopyReplace is called during the "_Add" call.
 *			- CopyAdd is destructive and should assume "toElement" is garbage
 *			- CopyReplace is replacing an existing element.
 *
 * 		CopyGet is called during the "_Get" call.
 *
 * 		CopyDuplicate is called to duplicate an element's internal structure.
 *
 * Attributes Methods - 
 *
 *		For copying data while Inheriting. Element methods are used
 *		at all other times.
 *	
 * 		CopyInherit is called to duplicate an element's internal structure 
 *			during inheritance. You should make this as fast as possible.
 *			(for example, if your custom element contains objects, you
 *			 should do a Q3Shared_GetReference instead of a Q3Object_Duplicate)
 *			
 *		The ElementDelete method will be called for all of your elements 
 *		copied around via CopyAdd, CopyReplace, CopyDuplicate, and 
 *		CopyInherit.
 *		If CopyGet allocates any memory in it's destination, it is up to the 
 *		application to delete it on its side.
 */



#define kQ3XMethodTypeElementCopyAdd		Q3_METHOD_TYPE('e','c','p','a')
#define kQ3XMethodTypeElementCopyReplace	Q3_METHOD_TYPE('e','c','p','r')
#define kQ3XMethodTypeElementCopyGet		Q3_METHOD_TYPE('e','c','p','g')
#define kQ3XMethodTypeElementCopyDuplicate	Q3_METHOD_TYPE('e','c','p','d')
#define kQ3XMethodTypeElementDelete			Q3_METHOD_TYPE('e','d','e','l')

typedef TQ3Status (QD3D_CALLBACK *TQ3XElementCopyAddMethod)(	
	const void			*fromAPIElement,			/* element from _Add API call */
	void				*toInternalElement);		/* to new QD3D internal element */

typedef TQ3Status (QD3D_CALLBACK *TQ3XElementCopyReplaceMethod)(
	const void			*fromAPIElement,			/* element from _Add API call */
	void				*ontoInternalElement);		/* replacing QD3D internal element */

typedef TQ3Status (QD3D_CALLBACK *TQ3XElementCopyGetMethod)(
	const void			*fromInternalElement,		/* from QD3D internal element */
	void				*toAPIElement);				/* to _Get API call */

typedef TQ3Status (QD3D_CALLBACK *TQ3XElementCopyDuplicateMethod)(
	const void			*fromInternalElement,		/* from QD3D internal element */
	void				*toInternalElement);		/* to new QD3D internal element */

typedef TQ3Status (QD3D_CALLBACK *TQ3XElementDeleteMethod)(	
	void				*internalElement);

QD3D_EXPORT TQ3XObjectClass QD3D_CALL Q3XElementClass_Register(
 	TQ3ElementType		*elementType,
	const char			*name,
	unsigned long		sizeOfElement,
	TQ3XMetaHandler		metaHandler);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XElementType_GetElementSize(
 	TQ3ElementType		elementType,
	unsigned long		*sizeOfElement);


/******************************************************************************
 **																			 **
 **						Custom Attribute Registration						 **
 **																			 **
 *****************************************************************************/

#define kQ3XMethodTypeAttributeInherit		Q3_METHOD_TYPE('i','n','h','t')
typedef TQ3Boolean		TQ3XAttributeInheritMethod;
/* return kQ3True or kQ3False in your metahandler */

#define kQ3XMethodTypeAttributeCopyInherit	Q3_METHOD_TYPE('a','c','p','i')
typedef TQ3Status (QD3D_CALLBACK *TQ3XAttributeCopyInheritMethod)(
	const void			*fromInternalAttribute,		/* from QD3D internal element */
	void				*toInternalAttribute);		/* to new QD3D internal element */

QD3D_EXPORT TQ3XObjectClass QD3D_CALL Q3XAttributeClass_Register(
	TQ3AttributeType	*attributeType,
	const char			*creatorName,
	unsigned long		sizeOfElement,
	TQ3XMetaHandler		metaHandler);

/*
 *	Version 1.1
 */
#define kQ3XMethodTypeAttributeDefault		Q3_METHOD_TYPE('a','s','d','f')
typedef TQ3Status (QD3D_CALLBACK *TQ3XAttributeDefaultMethod)(	
	void				*internalElement);

#define kQ3XMethodTypeAttributeIsDefault	Q3_METHOD_TYPE('a','i','d','f')
typedef TQ3Boolean (QD3D_CALLBACK *TQ3XAttributeIsDefaultMethod)(	
	void				*internalElement);


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
	#if PRAGMA_ENUM_RESET_QD3DSET
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DSET
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif /*  QD3DSet_h */
