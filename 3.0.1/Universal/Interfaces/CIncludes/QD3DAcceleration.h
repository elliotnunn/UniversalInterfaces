/******************************************************************************
 **																			 **
 ** 	Module:		QD3DAcceleration.h										 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Header file for low-level 3D driver API					 **
 ** 				Vendor IDs, and Apple's engine IDs						 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1994-97 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DAcceleration_h
#define QD3DAcceleration_h

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
		#define PRAGMA_ENUM_RESET_QD3DACCEL 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************************************
 **																			 **
 ** 						Vendor ID definitions							 **
 **																			 **
 *****************************************************************************/

/*
 *  If kQAVendor_BestChoice is used, the system chooses the "best" drawing 
 *  engine available for the target device. This should be used for the 
 *  default.
 */
#define kQAVendor_BestChoice		(-1)

/*
 *  The other definitions (kQAVendor_Apple, etc.) identify specific vendors
 *  of drawing engines. When a vendor ID is used in conjunction with a
 *  vendor-defined engine ID, a specific drawing engine can be selected.
 */
#define kQAVendor_Apple			0
#define kQAVendor_ATI			1
#define kQAVendor_Radius		2
#define kQAVendor_Mentor		3
#define kQAVendor_Matrox		4
#define kQAVendor_Yarc			5
#define kQAVendor_DiamondMM		6
#define kQAVendor_3DLabs		7
#define kQAVendor_D3DAdaptor	8
#define kQAVendor_IXMicro		9

/******************************************************************************
 **																			 **
 **						 Apple's engine ID definitions						 **
 **																			 **
 *****************************************************************************/

#define kQAEngine_AppleSW		0		/*  Default software rasterizer	 	*/
#define kQAEngine_AppleHW		(-1)	/*  QuickDraw 3D Accelerator Card 	*/
#define kQAEngine_AppleHW2		1		/*  Another Apple accelerator 		*/
#define kQAEngine_AppleHW3		2		/*  Another Apple accelerator 		*/

#ifdef __cplusplus
}
#endif

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DACCEL
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DACCEL
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif /* QD3DAcceleration_h */
