/******************************************************************************
 **																			 **
 ** 	Module:		QD3DString.h 											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose:														   	 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1994-1997 Apple Computer, Inc. All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DString_h
#define QD3DString_h

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
		#define PRAGMA_ENUM_RESET_QD3DSTRING 1
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
 **								String Routines								 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3String_GetType(
	TQ3StringObject		stringObj);


/******************************************************************************
 **																			 **
 **						C String Routines									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StringObject QD3D_CALL Q3CString_New(
	const char				*string);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CString_GetLength(
	TQ3StringObject			stringObj,
	unsigned long			*length);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CString_SetString(
	TQ3StringObject			stringObj,
	const char				*string);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CString_GetString(
	TQ3StringObject			stringObj,
	char					**string);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CString_EmptyData(
	char					**string);

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
	#if PRAGMA_ENUM_RESET_QD3DSTRING
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DSTRING
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DString_h  */
