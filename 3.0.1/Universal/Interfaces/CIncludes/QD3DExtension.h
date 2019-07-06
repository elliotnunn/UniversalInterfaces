/******************************************************************************
 **																			 **
 ** 	Module:		QD3DExtension.h											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	QuickDraw 3D Plug-in Architecture						 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DExtension_h
#define QD3DExtension_h

#include "QD3D.h"
#include "QD3DErrors.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=small
#endif

#include <CodeFragments.h>

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DEXTEN 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif /* OS_MACINTOSH */


#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus  */

/******************************************************************************
 **																			 **
 **								Constants						 			 **
 **																			 **
 *****************************************************************************/
 
#if defined(OS_MACINTOSH) && OS_MACINTOSH

#define kQ3XExtensionMacCreatorType		Q3_OBJECT_TYPE('Q','3','X','T')
#define kQ3XExtensionMacFileType		Q3_OBJECT_TYPE('s','h','l','b')

#endif  /*  OS_MACINTOSH  */


/******************************************************************************
 **																			 **
 **									Macros								 	 **
 **																			 **
 *****************************************************************************/

/*
 * Use this Macro to pack the version number for your class.  This would most
 * likely get used in the  kQ3XMethodTypeObjectClassVersion to return the 
 * version for your class.  This method is set up in your meta handler.
 */

#define Q3_OBJECT_CLASS_VERSION(major, minor)			\
	(unsigned long) (((major) << 16) | (minor))

/*
 * Convenience macros to unpack a version number, accessing the major and the
 * minor version numbers
 */
#define Q3_OBJECT_CLASS_GET_MAJOR_VERSION(version)		\
	(unsigned long) ((version) >> 16)

#define Q3_OBJECT_CLASS_GET_MINOR_VERSION(version)		\
	(unsigned long) ((version) & 0x0000FFFF)



/******************************************************************************
 **																			 **
 **								Object Method types						 	 **
 **																			 **
 *****************************************************************************/

#define kQ3XMethodTypeObjectClassVersion		Q3_METHOD_TYPE('v','r','s','n')
typedef unsigned long	TQ3XObjectClassVersion;

#define kQ3XMethodTypeObjectClassRegister		Q3_METHOD_TYPE('r','g','s','t')
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectClassRegisterMethod)(
	TQ3XObjectClass		objectClass,
	void				*classPrivate);

#define kQ3XMethodTypeObjectClassReplace		Q3_METHOD_TYPE('r','g','r','p')
typedef void (QD3D_CALLBACK *TQ3XObjectClassReplaceMethod)(
	TQ3XObjectClass		oldObjectClass,
	void				*oldClassPrivate,
	TQ3XObjectClass		newObjectClass,
	void				*newClassPrivate);

#define kQ3XMethodTypeObjectClassUnregister		Q3_METHOD_TYPE('u','n','r','g')
typedef void (QD3D_CALLBACK *TQ3XObjectClassUnregisterMethod)(
	TQ3XObjectClass		objectClass,
	void				*classPrivate);
	
#define kQ3XMethodTypeObjectNew					Q3_METHOD_TYPE('n','e','w','o')
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectNewMethod)(
	TQ3Object			object,
	void				*privateData,		
	void				*parameters);		

#define kQ3XMethodTypeObjectDelete				Q3_METHOD_TYPE('d','l','t','e')
typedef void (QD3D_CALLBACK *TQ3XObjectDeleteMethod)(
	TQ3Object			object,
	void				*privateData);
	

#define kQ3XMethodTypeObjectDuplicate			Q3_METHOD_TYPE('d','u','p','l')
typedef TQ3Status (QD3D_CALLBACK *TQ3XObjectDuplicateMethod)(
	TQ3Object			fromObject,
	const void			*fromPrivateData,
	TQ3Object			toObject,
	const void			*toPrivateData);

typedef TQ3Status (QD3D_CALLBACK *TQ3XSharedLibraryRegister)(
	void);


/******************************************************************************
 **																			 **
 **							Object Hierarchy Registration		 			 **
 **																			 **
 *****************************************************************************/

/*
 *	Q3XObjectHierarchy_RegisterClass
 *	
 *	Register an object class in the QuickDraw 3D hierarchy.
 *	
 *	parentType			- an existing type in the hierarchy, or 0 to subclass
 *							TQ3Object
 *	objectType			- the new object class type, used in the binary 
 *                        metafile.  This is assigned at run time and returned
 *						  to you.
 *	objectName			- the new object name, used in the text metafile
 *	metaHandler			- a TQ3XMetaHandler (may be NULL for some classes) 
 *						  which returns non-virtual methods
 *	virtualMetaHandler	- a TQ3XMetaHandler (may be NULL as well) which returns
 *							virtual methods a child would inherit
 *	methodsSize			- the size of the class data needed (see 
 *							GetClassPrivate calls below)
 *	instanceSize		- the size of the object instance data needed (see 
 *							GetPrivate calls below)
 */
QD3D_EXPORT TQ3XObjectClass QD3D_CALL Q3XObjectHierarchy_RegisterClass(
	TQ3ObjectType			parentType,
	TQ3ObjectType			*objectType,
	char					*objectName,
	TQ3XMetaHandler			metaHandler,
	TQ3XMetaHandler			virtualMetaHandler,
	unsigned long			methodsSize,
	unsigned long			instanceSize);

/*
 *	Q3XObjectHierarchy_UnregisterClass
 *	
 *	Returns kQ3Failure if the objectClass still has objects 
 * around; the class remains registered.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3XObjectHierarchy_UnregisterClass(
	TQ3XObjectClass			objectClass);

/*
 *	Q3XObjectClass_GetMethod
 *	
 *	For use in TQ3XObjectClassRegisterMethod call
 */
QD3D_EXPORT TQ3XFunctionPointer QD3D_CALL Q3XObjectClass_GetMethod(
	TQ3XObjectClass			objectClass,
	TQ3XMethodType			methodType);

/*
 *	Q3XObjectHierarchy_NewObject
 *	
 *	To create a new object. Parameters is passed into the 
 *	TQ3XObjectNewMethod as the "parameters" parameter.
 */
QD3D_EXPORT TQ3Object QD3D_CALL Q3XObjectHierarchy_NewObject(
	TQ3XObjectClass			objectClass,
	void					*parameters);

/*
 *	Q3XObjectClass_GetLeafType
 *	
 *	Return the leaf type of a class.
 */
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3XObjectClass_GetLeafType(
	TQ3XObjectClass			objectClass);

/*
 *	Q3XObjectHierarchy_GetClassVersion
 *
 *	This routine obtains the the version of a class, referenced by an
 *	object class type.  Functions for getting the type are in QD3D.h,
 *	if you have the class name.
 */ 
QD3D_EXPORT TQ3Status QD3D_CALL Q3XObjectHierarchy_GetClassVersion(
	TQ3ObjectType			objectClassType,
	TQ3XObjectClassVersion	*version);

/*
 *	Q3XObjectClass_GetType 
 *
 *	This can be used to get the type, given a reference 
 *	to a class.  This is most useful in the instance where you register a 
 *	an element/attribute and need to get the type.  When you register an
 *	element, QD3D will take the type you pass in and modify it (to avoid
 *	namespace clashes).  Many object system calls require an object type
 *	so this API call allows you to get the type from the class referernce
 *	that you will ordinarily store when you register the class.
 */
QD3D_EXPORT TQ3Status QD3D_CALL Q3XObjectClass_GetType( 
	TQ3XObjectClass 		objectClass, 
	TQ3ObjectType 			*type);


QD3D_EXPORT TQ3XObjectClass QD3D_CALL Q3XObjectHierarchy_FindClassByType(
	TQ3ObjectType			type);



/*
 *	Q3XObjectClass_GetPrivate
 *	
 *	Return a pointer to private instance data, a block of instanceSize bytes, 
 *	from the Q3XObjectHierarchy_RegisterClass call.
 *	
 *	If instanceSize was zero, NULL is always returned.
 */
QD3D_EXPORT void *QD3D_CALL Q3XObjectClass_GetPrivate(
	TQ3XObjectClass			objectClass,
	TQ3Object				targetObject);
		
/*
 * Return the "TQ3XObjectClass" of an object
 */
QD3D_EXPORT TQ3XObjectClass QD3D_CALL Q3XObject_GetClass(
	TQ3Object 		object);
	


/******************************************************************************
 **																			 **
 **					Shared Library Registration Entry Point		 			 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3XSharedLibraryInfo {
	TQ3XSharedLibraryRegister	registerFunction;	
	unsigned long				sharedLibrary;
} TQ3XSharedLibraryInfo;

QD3D_EXPORT TQ3Status QD3D_CALL Q3XSharedLibrary_Register(
	TQ3XSharedLibraryInfo	*sharedLibraryInfo);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XSharedLibrary_Unregister(
	unsigned long			sharedLibrary);
	

/******************************************************************************
 **																			 **
 **								Posting Errors					 			 **
 **																			 **
 **			You may only call these functions from within an extension		 **
 **																			 **
 *****************************************************************************/

/*
 *	Q3XError_Post
 *	
 *	Post a QuickDraw 3D Error from an extension.
 */
QD3D_EXPORT void QD3D_CALL Q3XError_Post(
	TQ3Error		error);

/*
 *	Q3XWarning_Post
 *	
 *	Post a QuickDraw 3D Warning, from an extension.  Note the warning code you
 *	pass into this routine must already be defined in the table above.
 */
QD3D_EXPORT void QD3D_CALL Q3XWarning_Post(
	TQ3Warning		warning);

/*
 *	Q3XNotice_Post
 *	
 *	Post a QuickDraw 3D Notice, from an extension.  Note the notice code you
 *	pass into this routine must already be defined in the table above.
 */
QD3D_EXPORT void QD3D_CALL Q3XNotice_Post(
	TQ3Notice		notice);


#if defined(OS_MACINTOSH) && OS_MACINTOSH

/*
 *	Q3XMacintoshError_Post
 *	
 *	Post the QuickDraw 3D Error, kQ3ErrorMacintoshError, and the Macintosh
 *	OSErr macOSErr. (Retrieved with Q3MacintoshError_Get)
 */
QD3D_EXPORT void QD3D_CALL Q3XMacintoshError_Post(
	OSErr			macOSErr);

#endif  /*  OS_MACINTOSH  */


#ifdef __cplusplus
}
#endif  /* __cplusplus  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DEXTEN
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DEXTEN
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /* QD3DExtension_h  */
