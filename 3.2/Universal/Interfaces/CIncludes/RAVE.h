/*
 	File:		RAVE.h
 
 	Contains:	Interface for RAVE (Renderer Acceleration Virtual Engine)							
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __RAVE__
#define __RAVE__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#if TARGET_OS_MAC
#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#endif  /* TARGET_OS_MAC */

#if TARGET_OS_WIN32
#include <windows.h>
#ifndef RAVE_NO_DIRECTDRAW
#include <ddraw.h>
#endif  /* !defined(RAVE_NO_DIRECTDRAW) */

#endif  /* TARGET_OS_WIN32 */



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=power
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=int
#elif PRAGMA_ENUM_PACK
	#if __option(pack_enums)
		#define PRAGMA_ENUM_PACK__RAVE__
	#endif
	#pragma options(!pack_enums)
#endif


/******************************************************************************
 *
 * Platform macros.
 * This sets kQAPlatform to one of kQAMacOS, kQAWin32, or kQAGeneric.
 * kQAPlatform controls platform-specific compilation switches and types.
 *
 *****************************************************************************/

#if !defined(kQAMacOS)
#define	kQAMacOS		1			/* Target is MacOS					*/
#endif

#if !defined(kQAGeneric)
#define kQAGeneric		2			/* Target is generic platform		*/
#endif

#if !defined(kQAWin32)
#define kQAWin32		3			/* Target is Win32					*/
#endif

#if defined(_WIN32) || defined(_WINDOWS)
	#define kQAPlatform kQAWin32
#elif !defined(kQAPlatform)
	#define kQAPlatform kQAMacOS
#endif


/******************************************************************************
 *
 * Export Control
 *
 *****************************************************************************/
#if defined(_MSC_VER)
	/* Microsoft Visual C */
	#if defined(WIN32_RAVEEXPORTING)	
	/* define when building DLL */
		#define	RAVE_EXPORT		__declspec( dllexport )
		#define RAVE_CALL
		#define RAVE_CALLBACK
	#else
		#define RAVE_EXPORT		__declspec( dllimport )
		#define RAVE_CALL		__cdecl
		#define RAVE_CALLBACK	__cdecl
	#endif 
	/* WIN32_RAVEEXPORTING */
#else
	#define RAVE_EXPORT
	#define RAVE_CALL
	#define RAVE_CALLBACK
#endif 
/* _MSC_VER */

/******************************************************************************
 *
 * Platform dependent datatypes: TQAImagePixelType, TQADevice, TQAClip, and TQARect.
 *
 *****************************************************************************/

enum TQAImagePixelType {
	kQAPixel_Alpha1				= 0,							/* 1 bit/pixel alpha */
	kQAPixel_RGB16				= 1,							/* 16 bit/pixel, R=14:10, G=9:5, B=4:0 */
	kQAPixel_ARGB16				= 2,							/* 16 bit/pixel, A=15, R=14:10, G=9:5, B=4:0 */
	kQAPixel_RGB32				= 3,							/* 32 bit/pixel, R=23:16, G=15:8, B=7:0 */
	kQAPixel_ARGB32				= 4,							/* 32 bit/pixel, A=31:24, R=23:16, G=15:8, B=7:0 */
	kQAPixel_CL4				= 5,							/* 4 bit color look up table, always big endian, ie high 4 bits effect left pixel */
	kQAPixel_CL8				= 6,							/* 8 bit color look up table */
	kQAPixel_RGB16_565			= 7,							/* 16 bits/pixel, no alpha, R:5, G:6, B:5 WINDOWS ONLY */
	kQAPixel_RGB24				= 8								/* 24 bits/pixel, no alpha, R:8, G:8, B:8 WINDOWS ONLY */
};
typedef enum TQAImagePixelType TQAImagePixelType;


enum TQAColorTableType {
	kQAColorTable_CL8_RGB32		= 0,							/* 256 entry, 32 bit/pixel, R=23:16, G=15:8, B=7:0 */
	kQAColorTable_CL4_RGB32		= 1								/* 16 entry, 32 bit/pixel, R=23:16, G=15:8, B=7:0 */
};
typedef enum TQAColorTableType TQAColorTableType;

/* Selects target device type */

enum TQADeviceType {
	kQADeviceMemory				= 0,							/* Memory draw context */
	kQADeviceGDevice			= 1,							/* Macintosh GDevice draw context */
	kQADeviceWin32DC			= 2,							/* Win32 DC */
	kQADeviceDDSurface			= 3								/* Win32 DirectDraw Surface */
};
typedef enum TQADeviceType TQADeviceType;

/* Generic memory pixmap device */

struct TQADeviceMemory {
	long 							rowBytes;					/* Rowbytes */
	TQAImagePixelType 				pixelType;					/* Depth, color space, etc. */
	long 							width;						/* Width in pixels */
	long 							height;						/* Height in pixels */
	void *							baseAddr;					/* Base address of pixmap */
};
typedef struct TQADeviceMemory			TQADeviceMemory;
/* Selects target clip type */

enum TQAClipType {
	kQAClipRgn					= 0,							/* Macintosh clipRgn with serial number */
	kQAClipWin32Rgn				= 1								/* Win32 clip region */
};
typedef enum TQAClipType TQAClipType;


struct TQARect {
	long 							left;
	long 							right;
	long 							top;
	long 							bottom;
};
typedef struct TQARect					TQARect;
#if TARGET_OS_MAC

union TQAPlatformDevice {
	TQADeviceMemory 				memoryDevice;
	GDHandle 						gDevice;
};
typedef union TQAPlatformDevice			TQAPlatformDevice;

union TQAPlatformClip {
	RgnHandle 						clipRgn;
};
typedef union TQAPlatformClip			TQAPlatformClip;
typedef CALLBACK_API( void , TQADrawNotificationProcPtr )(short left, short top, short right, short bottom, long refCon);

typedef long 							TQADrawNotificationProcRefNum;
/* used to unregister your proc */
#elif TARGET_OS_WIN32

#if !defined(RAVE_NO_DIRECTDRAW)

	enum TQADirectDrawObjectSelector
	{
		kQADirectDrawObject		= 1,
		kQADirectDrawObject2	= 2
	};
	typedef enum TQADirectDrawObjectSelector TQADirectDrawObjectSelector;

	enum TQADirectDrawSurfaceSelector
	{
		kQADirectDrawSurface	= 1,
		kQADirectDrawSurface2	= 2
	};
	typedef enum TQADirectDrawSurfaceSelector TQADirectDrawSurfaceSelector;

#endif /* !RAVE_NO_DIRECTDRAW */

	union TQAPlatformDevice
	{
		TQADeviceMemory			memoryDevice;
		HDC						hdc;
#if !defined(RAVE_NO_DIRECTDRAW)
		struct
		{
			TQADirectDrawObjectSelector		objectSelector;
			union
			{
				LPDIRECTDRAW				lpDirectDraw;
				LPDIRECTDRAW2				lpDirectDraw2;
			};

			TQADirectDrawSurfaceSelector	surfaceSelector;
			union
			{
				LPDIRECTDRAWSURFACE			lpDirectDrawSurface;
				LPDIRECTDRAWSURFACE2		lpDirectDrawSurface2;
			};
		};
#endif /* RAVE_NO_DIRECTDRAW */
	};
	typedef union TQAPlatformDevice TQAPlatformDevice;
	
	union TQAPlatformClip
	{
		HRGN			clipRgn;
	};
	typedef union TQAPlatformClip TQAPlatformClip;

#else
/*
	 * Generic platform supports memory device only. TQARect is generic. TQAClip is ???.
	 */

union TQAPlatformDevice {
	TQADeviceMemory 				memoryDevice;
};
typedef union TQAPlatformDevice			TQAPlatformDevice;

union TQAPlatformClip {
	void *							region;						/* ??? */
};
typedef union TQAPlatformClip			TQAPlatformClip;
#endif  /*  */


struct TQADevice {
	TQADeviceType 					deviceType;
	TQAPlatformDevice 				device;
};
typedef struct TQADevice				TQADevice;

struct TQAClip {
	TQAClipType 					clipType;
	TQAPlatformClip 				clip;
};
typedef struct TQAClip					TQAClip;
/******************************************************************************
 *
 * Basic data types.
 *
 *****************************************************************************/

/* Pointer to a drawing engine */
typedef struct TQAEngine TQAEngine;
/* Pointer to an allocated texture */
typedef struct TQATexture TQATexture;
/* Pointer to an allocated bitmap */
typedef struct TQABitmap TQABitmap;
/* Engine's private draw context pointer */
typedef struct TQADrawPrivate TQADrawPrivate;
/* An engine specific color table structure */
typedef struct TQAColorTable TQAColorTable;
/* A single triangle element for QADrawTriMesh */

struct TQAIndexedTriangle {
	unsigned long 					triangleFlags;				/* Triangle flags, see kQATriFlags_ */
	unsigned long 					vertices[3];				/* Indices into a vertex array */
};
typedef struct TQAIndexedTriangle		TQAIndexedTriangle;
/* An image for use as texture or bitmap */

struct TQAImage {
	long 							width;						/* Width of pixmap */
	long 							height;						/* Height of pixmap */
	long 							rowBytes;					/* Rowbytes of pixmap */
	void *							pixmap;						/* Pixmap */
};
typedef struct TQAImage					TQAImage;
/* Standard error type */

enum TQAError {
	kQANoErr					= 0,							/* No error */
	kQAError					= 1,							/* Generic error flag */
	kQAOutOfMemory				= 2,							/* Insufficient memory */
	kQANotSupported				= 3,							/* Requested feature is not supported */
	kQAOutOfDate				= 4,							/* A newer drawing engine was registered */
	kQAParamErr					= 5,							/* Error in passed parameters */
	kQAGestaltUnknown			= 6,							/* Requested gestalt type isn't available */
	kQADisplayModeUnsupported	= 7,							/* Engine cannot render to the display in its current , */
																/* mode, but could if it were in some other mode */
	kQAOutOfVideoMemory			= 8								/* There is not enough VRAM to support the desired context dimensions */
};
typedef enum TQAError TQAError;

/************************************************************************************************
 *
 * Vertex data types.
 *
 ***********************************************************************************************/
/*
 * TQAVGouraud is used for Gouraud shading. Each vertex specifies position, color and Z.
 *
 * Alpha is always treated as indicating transparency. Drawing engines which don't
 * support Z-sorted rendering use the back-to-front transparency blending functions
 * shown below. (ARGBsrc are the source (new) values, ARGBdest are  the destination
 * (previous) pixel values.)
 *
 *		Premultiplied							Interpolated
 *
 *		A = 1 - (1 - Asrc) * (1 - Adest)		A = 1 - (1 - Asrc) * (1 - Adest) 
 *		R = (1 - Asrc) * Rdest + Rsrc			R = (1 - Asrc) * Rdest + Asrc * Rsrc
 *		G = (1 - Asrc) * Gdest + Gsrc			G = (1 - Asrc) * Gdest + Asrc * Gsrc
 *		B = (1 - Asrc) * Bdest + Bsrc			B = (1 - Asrc) * Bdest + Asrc * Bsrc
 *
 * Note that the use of other blending modes to implement antialiasing is performed
 * automatically by the drawing engine when the kQATag_Antialias variable !=
 * kQAAntiAlias_Fast. The driving software should continue to use the alpha fields
 * for transparency even when antialiasing is being used (the drawing engine will
 * resolve the multiple blending requirements as best as it can).
 *
 * Drawing engines which perform front-to-back Z-sorted rendering should replace
 * the blending function shown above with the equivalent front-to-back formula.
 */

struct TQAVGouraud {
	float 							x;							/* X pixel coordinate, 0.0 <= x < width */
	float 							y;							/* Y pixel coordinate, 0.0 <= y < height */
	float 							z;							/* Z coordinate, 0.0 <= z <= 1.0 */
	float 							invW;						/* 1 / w; required only when kQAPerspectiveZ_On is set */

	float 							r;							/* Red, 0.0 <= r <= 1.0 */
	float 							g;							/* Green, 0.0 <= g <= 1.0 */
	float 							b;							/* Blue, 0.0 <= b <= 1.0 */
	float 							a;							/* Alpha, 0.0 <= a <= 1.0, 1.0 is opaque */
};
typedef struct TQAVGouraud				TQAVGouraud;
/*
 * TQAVTexture is used for texture mapping. The texture mapping operation
 * is controlled by the kQATag_TextureOp variable, which is a mask of
 * kQATextureOp_None/Modulate/Highlight/Decal. Below is pseudo-code for the
 * texture shading operation:
 *
 *		texPix = TextureLookup (uq/q, vq/q);
 *		if (kQATextureOp_Decal)
 *		{
 *			texPix.r = texPix.a * texPix.r + (1 - texPix.a) * r;
 *			texPix.g = texPix.a * texPix.g + (1 - texPix.a) * g;
 *			texPix.b = texPix.a * texPix.b + (1 - texPix.a) * b;
 *			texPix.a = a;
 *		}
 *		else
 *		{
 *			texPix.a = texPix.a * a;
 *		}
 *		if (kQATextureOp_Modulate)
 *		{
 *			texPix.r *= kd_r;		// Clamped to prevent overflow
 *			texPix.g *= kd_g;		// Clamped to prevent overflow
 *			texPix.b *= kd_b;		// Clamped to prevent overflow
 *		}
 *		if (kQATextureOp_Highlight)
 *		{
 *			texPix.r += ks_r;		// Clamped to prevent overflow
 *			texPix.g += ks_g;		// Clamped to prevent overflow
 *			texPix.b += ks_b;		// Clamped to prevent overflow
 *		}
 *
 * After computation of texPix, transparency blending (as shown
 * above for TQAVGouraud) is performed.
 */

struct TQAVTexture {
	float 							x;							/* X pixel coordinate, 0.0 <= x < width */
	float 							y;							/* Y pixel coordinate, 0.0 <= y < height */
	float 							z;							/* Z coordinate, 0.0 <= z <= 1.0 */
	float 							invW;						/* 1 / w (always required) */

																/* rgb are used only when kQATextureOp_Decal is set. a is always required */

	float 							r;							/* Red, 0.0 <= r <= 1.0 */
	float 							g;							/* Green, 0.0 <= g <= 1.0 */
	float 							b;							/* Blue, 0.0 <= b <= 1.0 */
	float 							a;							/* Alpha, 0.0 <= a <= 1.0, 1.0 is opaque */

																/* uOverW and vOverW are required by all modes */

	float 							uOverW;						/* u / w */
	float 							vOverW;						/* v / w */

																/* kd_r/g/b are used only when kQATextureOp_Modulate is set */

	float 							kd_r;						/* Scale factor for texture red, 0.0 <= kd_r */
	float 							kd_g;						/* Scale factor for texture green, 0.0 <= kd_g */
	float 							kd_b;						/* Scale factor for texture blue, 0.0 <= kd_b */

																/* ks_r/g/b are used only when kQATextureOp_Highlight is set */

	float 							ks_r;						/* Red specular highlight, 0.0 <= ks_r <= 1.0 */
	float 							ks_g;						/* Green specular highlight, 0.0 <= ks_g <= 1.0 */
	float 							ks_b;						/* Blue specular highlight, 0.0 <= ks_b <= 1.0 */
};
typedef struct TQAVTexture				TQAVTexture;
/************************************************************************************************
 *
 * Constants used for the state variables.
 *
 ***********************************************************************************************/
/*
 * kQATag_xxx is used to select a state variable when calling QASetFloat(), QASetInt(),
 * QAGetFloat() and QAGetInt(). The kQATag values are split into two separate
 * enumerated types: TQATagInt and TQATagFloat. TQATagInt is used for the QASet/GetInt()
 * functions, and TQATagFloat is used for the QASet/GetFloat() functions. (This is so
 * that a compiler that typechecks enums can flag a float/int tag mismatch during compile.)
 *
 * These variables are required by all drawing engines:
 *		kQATag_ZFunction			(Int)	One of kQAZFunction_xxx
 *		kQATag_ColorBG_a			(Float)	Background color alpha
 *		kQATag_ColorBG_r			(Float)	Background color red
 *		kQATag_ColorBG_g			(Float)	Background color green
 *		kQATag_ColorBG_b			(Float)	Background color blue
 *		kQATag_Width				(Float)	Line and point width (pixels)
 *		kQATag_ZMinOffset			(Float)	Min offset to Z to guarantee visibility (Read only!)
 *		kQATag_ZMinScale			(Float)	Min scale to Z to guarantee visibility (Read only!)
 
 * These variables are used for optional features:
 *		kQATag_Antialias			(Int)	One of kQAAntiAlias_xxx
 *		kQATag_Blend				(Int)	One of kQABlend_xxx
 *		kQATag_PerspectiveZ			(Int)	One of kQAPerspectiveZ_xxx
 *		kQATag_TextureFilter		(Int)	One of kQATextureFilter_xxx
 *		kQATag_TextureOp			(Int)	Mask of kQATextureOp_xxx
 *		kQATag_Texture				(Int)	Pointer to current TQATexture
 *		kQATag_CSGTag				(Int)	One of kQACSGTag_xxx
 *		kQATag_CSGEquation			(Int)	32 bit CSG truth table
 *
 * These variables are used for OpenGL™ support:
 *		kQATagGL_DrawBuffer			(Int)	Mask of kQAGL_DrawBuffer_xxx
 *		kQATagGL_TextureWrapU		(Int)	kQAGL_Clamp or kQAGL_Repeat
 *		kQATagGL_TextureWrapV		(Int)	kQAGL_Clamp or kQAGL_Repeat
 *		kQATagGL_TextureMagFilter	(Int)	kQAGL_Nearest or kQAGL_Linear
 *		kQATagGL_TextureMinFilter	(Int)	kQAGL_Nearest, etc.
 *		kQATagGL_ScissorXMin		(Int)	Minimum X value for scissor rectangle
 *		kQATagGL_ScissorYMin		(Int)	Minimum Y value for scissor rectangle
 *		kQATagGL_ScissorXMax		(Int)	Maximum X value for scissor rectangle
 *		kQATagGL_ScissorYMax		(Int)	Maximum Y value for scissor rectangle
 *		kQATagGL_BlendSrc			(Int)	Source blending operation
 *		kQATagGL_BlendDst			(Int)	Destination blending operation
 *		kQATagGL_LinePattern		(Int)	Line rasterization pattern
 *		kQATagGL_AreaPattern0		(Int)	First of 32 area pattern registers
 *		kQATagGL_AreaPattern31		(Int)	Last of 32 area pattern registers
 *		kQATagGL_DepthBG			(Float)	Background Z
 *		kQATagGL_TextureBorder_a	(Float)	Texture border color alpha
 *		kQATagGL_TextureBorder_r	(Float)	Texture border color red
 *		kQATagGL_TextureBorder_g	(Float)	Texture border color green
 *		kQATagGL_TextureBorder_b	(Float)	Texture border color blue
 *
 * Tags >= kQATag_EngineSpecific_Minimum may be assigned by the vendor for use as
 * engine-specific variables. NOTE: These should be used only in exceptional circumstances,
 * as functions performed by these variables won't be generally accessible. All other tag
 * values are reserved.
 *
 *		kQATag_EngineSpecific_Minimum	Minimum tag value for drawing-engine specific variables
 */

enum TQATagInt {
	kQATag_ZFunction			= 0,
	kQATag_Antialias			= 8,
	kQATag_Blend				= 9,
	kQATag_PerspectiveZ			= 10,
	kQATag_TextureFilter		= 11,
	kQATag_TextureOp			= 12,
	kQATag_CSGTag				= 14,
	kQATag_CSGEquation			= 15,
	kQATag_BufferComposite		= 16,
	kQATagGL_DrawBuffer			= 100,
	kQATagGL_TextureWrapU		= 101,
	kQATagGL_TextureWrapV		= 102,
	kQATagGL_TextureMagFilter	= 103,
	kQATagGL_TextureMinFilter	= 104,
	kQATagGL_ScissorXMin		= 105,
	kQATagGL_ScissorYMin		= 106,
	kQATagGL_ScissorXMax		= 107,
	kQATagGL_ScissorYMax		= 108,
	kQATagGL_BlendSrc			= 109,
	kQATagGL_BlendDst			= 110,
	kQATagGL_LinePattern		= 111,
	kQATagGL_AreaPattern0		= 117,							/* ...1-30 */
	kQATagGL_AreaPattern31		= 148,
	kQATag_EngineSpecific_Minimum = 1000
};
typedef enum TQATagInt TQATagInt;


enum TQATagPtr {
	kQATag_Texture				= 13
};
typedef enum TQATagPtr TQATagPtr;


enum TQATagFloat {
	kQATag_ColorBG_a			= 1,
	kQATag_ColorBG_r			= 2,
	kQATag_ColorBG_g			= 3,
	kQATag_ColorBG_b			= 4,
	kQATag_Width				= 5,
	kQATag_ZMinOffset			= 6,
	kQATag_ZMinScale			= 7,
	kQATagGL_DepthBG			= 112,
	kQATagGL_TextureBorder_a	= 113,
	kQATagGL_TextureBorder_r	= 114,
	kQATagGL_TextureBorder_g	= 115,
	kQATagGL_TextureBorder_b	= 116
};
typedef enum TQATagFloat TQATagFloat;

/* kQATag_ZFunction */

enum {
	kQAZFunction_None			= 0,							/* Z is neither tested nor written (same as no Z buffer) */
	kQAZFunction_LT				= 1,							/* Znew < Zbuffer is visible */
	kQAZFunction_EQ				= 2,							/* OpenGL Only: Znew == Zbuffer is visible */
	kQAZFunction_LE				= 3,							/* OpenGL Only: Znew <= Zbuffer is visible */
	kQAZFunction_GT				= 4,							/* OpenGL Only: Znew > Zbuffer is visible */
	kQAZFunction_NE				= 5,							/* OpenGL Only: Znew != Zbuffer is visible */
	kQAZFunction_GE				= 6,							/* OpenGL Only: Znew >= Zbuffer is visible */
	kQAZFunction_True			= 7								/* Znew is always visible */
};

/* kQATag_Width */
#define kQAMaxWidth 128.0
/* kQATag_Antialias */

enum {
	kQAAntiAlias_Off			= 0,
	kQAAntiAlias_Fast			= 1,
	kQAAntiAlias_Mid			= 2,
	kQAAntiAlias_Best			= 3
};

/* kQATag_Blend */

enum {
	kQABlend_PreMultiply		= 0,
	kQABlend_Interpolate		= 1,
	kQABlend_OpenGL				= 2
};

/* kQATag_BufferComposite */

enum {
	kQABufferComposite_None		= 0,							/* Default: New pixels overwrite initial buffer contents */
	kQABufferComposite_PreMultiply = 1,							/* New pixels are blended with initial buffer contents via PreMultiply */
	kQABufferComposite_Interpolate = 2							/* New pixels are blended with initial buffer contents via Interpolate */
};

/* kQATag_PerspectiveZ */

enum {
	kQAPerspectiveZ_Off			= 0,							/* Use Z for hidden surface removal */
	kQAPerspectiveZ_On			= 1								/* Use InvW for hidden surface removal */
};

/* kQATag_TextureFilter */

enum {
																/* suggested meanings of these values */
	kQATextureFilter_Fast		= 0,							/* No filtering, pick nearest */
	kQATextureFilter_Mid		= 1,							/* Fastest method that does some filtering */
	kQATextureFilter_Best		= 2								/* Highest quality renderer can do */
};

/* kQATag_TextureOp (mask of one or more) */

enum {
	kQATextureOp_None			= 0,							/* Default texture mapping mode */
	kQATextureOp_Modulate		= (1 << 0),						/* Modulate texture color with kd_r/g/b */
	kQATextureOp_Highlight		= (1 << 1),						/* Add highlight value ks_r/g/b */
	kQATextureOp_Decal			= (1 << 2),						/* When texture alpha == 0, use rgb instead */
	kQATextureOp_Shrink			= (1 << 3)						/* This is a non-wrapping texture, so the ??? */
};

/* kQATag_CSGTag */
#define kQACSGTag_None 0xffffffffUL

enum {
	kQACSGTag_0					= 0,							/* Submitted tris have CSG ID 0 */
	kQACSGTag_1					= 1,							/* Submitted tris have CSG ID 1 */
	kQACSGTag_2					= 2,							/* Submitted tris have CSG ID 2 */
	kQACSGTag_3					= 3,							/* Submitted tris have CSG ID 3 */
	kQACSGTag_4					= 4								/* Submitted tris have CSG ID 4 */
};

/* kQATagGL_TextureWrapU/V */

enum {
	kQAGL_Repeat				= 0,
	kQAGL_Clamp					= 1
};

/* kQATagGL_BlendSrc */

enum {
	kQAGL_SourceBlend_XXX		= 0
};

/* kQATagGL_BlendDst */

enum {
	kQAGL_DestBlend_XXX			= 0
};

/* kQATagGL_DrawBuffer (mask of one or more) */

enum {
	kQAGL_DrawBuffer_None		= 0,
	kQAGL_DrawBuffer_FrontLeft	= (1 << 0),
	kQAGL_DrawBuffer_FrontRight	= (1 << 1),
	kQAGL_DrawBuffer_BackLeft	= (1 << 2),
	kQAGL_DrawBuffer_BackRight	= (1 << 3),
	kQAGL_DrawBuffer_Front		= (kQAGL_DrawBuffer_FrontLeft | kQAGL_DrawBuffer_FrontRight),
	kQAGL_DrawBuffer_Back		= (kQAGL_DrawBuffer_BackLeft | kQAGL_DrawBuffer_BackRight)
};

/************************************************************************************************
 *
 * Constants used as function parameters.
 *
 ***********************************************************************************************/
/*
 * TQAVertexMode is a parameter to QADrawVGouraud() and QADrawVTexture() that specifies how
 * to interpret and draw the vertex array.
 */

enum TQAVertexMode {
	kQAVertexMode_Point			= 0,							/* Draw nVertices points */
	kQAVertexMode_Line			= 1,							/* Draw nVertices/2 line segments */
	kQAVertexMode_Polyline		= 2,							/* Draw nVertices-1 connected line segments */
	kQAVertexMode_Tri			= 3,							/* Draw nVertices/3 triangles */
	kQAVertexMode_Strip			= 4,							/* Draw nVertices-2 triangles as a strip */
	kQAVertexMode_Fan			= 5,							/* Draw nVertices-2 triangles as a fan from v0 */
	kQAVertexMode_NumModes		= 6
};
typedef enum TQAVertexMode TQAVertexMode;

/*
 * TQAGestaltSelector is a parameter to QAEngineGestalt(). It selects which gestalt
 * parameter will be copied into 'response'.
 */

enum TQAGestaltSelector {
	kQAGestalt_OptionalFeatures	= 0,							/* Mask of one or more kQAOptional_xxx */
	kQAGestalt_FastFeatures		= 1,							/* Mask of one or more kQAFast_xxx */
	kQAGestalt_VendorID			= 2,							/* Vendor ID */
	kQAGestalt_EngineID			= 3,							/* Engine ID */
	kQAGestalt_Revision			= 4,							/* Revision number of this engine */
	kQAGestalt_ASCIINameLength	= 5,							/* strlen (asciiName) */
	kQAGestalt_ASCIIName		= 6,							/* Causes strcpy (response, asciiName) */
	kQAGestalt_TextureMemory	= 7,							/* amount of texture RAM currently available */
	kQAGestalt_FastTextureMemory = 8,							/* amount of texture RAM currently available */
	kQAGestalt_NumSelectors		= 9
};
typedef enum TQAGestaltSelector TQAGestaltSelector;

/*
 * TQAMethodSelector is a parameter to QASetNoticeMethod to select the notice method
 */

enum TQAMethodSelector {
	kQAMethod_RenderCompletion	= 0,							/* Called when rendering has completed and buffers swapped */
	kQAMethod_DisplayModeChanged = 1,							/* Called when a display mode has changed */
	kQAMethod_ReloadTextures	= 2,							/* Called when texture memory has been invalidated */
	kQAMethod_BufferInitialize	= 3,							/* Called when a buffer needs to be initialized */
	kQAMethod_BufferComposite	= 4,							/* Called when rendering is finished and its safe to composite */
	kQAMethod_NumSelectors		= 5
};
typedef enum TQAMethodSelector TQAMethodSelector;

/*
 * kQATriFlags_xxx are ORed together to generate the 'flags' parameter
 * to QADrawTriGouraud() and QADrawTriTexture().
 */

enum {
	kQATriFlags_None			= 0,							/* No flags (triangle is front-facing or don't care) */
	kQATriFlags_Backfacing		= (1 << 0)						/* Triangle is back-facing */
};

/*
 * kQATexture_xxx are ORed together to generate the 'flags' parameter to QATextureNew().
 */

enum {
	kQATexture_None				= 0,							/* No flags */
	kQATexture_Lock				= (1 << 0),						/* Don't swap this texture out */
	kQATexture_Mipmap			= (1 << 1),						/* This texture is mipmapped */
	kQATexture_NoCompression	= (1 << 2),						/* Do not compress this texture */
	kQATexture_HighCompression	= (1 << 3)						/* Compress texture, even if it takes a while */
};

/*
 * kQABitmap_xxx are ORed together to generate the 'flags' parameter to QABitmapNew().
 */

enum {
	kQABitmap_None				= 0,							/* No flags */
	kQABitmap_Lock				= (1 << 1),						/* Don't swap this bitmap out */
	kQABitmap_NoCompression		= (1 << 2),						/* Do not compress this bitmap */
	kQABitmap_HighCompression	= (1 << 3)						/* Compress bitmap, even if it takes a while */
};

/*
 * kQAContext_xxx are ORed together to generate the 'flags' parameter for QADrawContextNew().
 */

enum {
	kQAContext_None				= 0,							/* No flags */
	kQAContext_NoZBuffer		= (1 << 0),						/* No hidden surface removal */
	kQAContext_DeepZ			= (1 << 1),						/* Hidden surface precision >= 24 bits */
	kQAContext_DoubleBuffer		= (1 << 2),						/* Double buffered window */
	kQAContext_Cache			= (1 << 3),						/* This is a cache context */
	kQAContext_NoDither			= (1 << 4)						/* No dithering, straight color banding */
};

/*
 * kQAOptional_xxx are ORed together to generate the kQAGestalt_OptionalFeatures response
 * from QAEngineGestalt().
 */

enum {
	kQAOptional_None			= 0,							/* No optional features */
	kQAOptional_DeepZ			= (1 << 0),						/* Hidden surface precision >= 24 bits */
	kQAOptional_Texture			= (1 << 1),						/* Texture mapping */
	kQAOptional_TextureHQ		= (1 << 2),						/* High quality texture (tri-linear mip or better) */
	kQAOptional_TextureColor	= (1 << 3),						/* Full color modulation and highlight of textures */
	kQAOptional_Blend			= (1 << 4),						/* Transparency blending of RGB */
	kQAOptional_BlendAlpha		= (1 << 5),						/* Transparency blending includes alpha channel */
	kQAOptional_Antialias		= (1 << 6),						/* Antialiased rendering */
	kQAOptional_ZSorted			= (1 << 7),						/* Z sorted rendering (for transparency, etc.) */
	kQAOptional_PerspectiveZ	= (1 << 8),						/* Hidden surface removal using InvW instead of Z */
	kQAOptional_OpenGL			= (1 << 9),						/* Extended rasterization features for OpenGL™ */
	kQAOptional_NoClear			= (1 << 10),					/* This drawing engine doesn't clear before drawing */
	kQAOptional_CSG				= (1 << 11),					/* kQATag_CSGxxx are implemented */
	kQAOptional_BoundToDevice	= (1 << 12),					/* This engine is tightly bound to GDevice */
	kQAOptional_CL4				= (1 << 13),					/* This engine suports kQAPixel_CL4 */
	kQAOptional_CL8				= (1 << 14),					/* This engine suports kQAPixel_CL8 */
	kQAOptional_BufferComposite	= (1 << 15),					/* This engine can composite with initial buffer contents */
	kQAOptional_NoDither		= (1 << 16)						/* This engine can draw with no dithering */
};

/*
 * kQAFast_xxx are ORed together to generate the kQAGestalt_FastFeatures response
 * from QAEngineGestalt().
 */

enum {
	kQAFast_None				= 0,							/* No accelerated features */
	kQAFast_Line				= (1 << 0),						/* Line drawing */
	kQAFast_Gouraud				= (1 << 1),						/* Gouraud shaded triangles */
	kQAFast_Texture				= (1 << 2),						/* Texture mapped triangles */
	kQAFast_TextureHQ			= (1 << 3),						/* High quality texture (tri-linear mip or better) */
	kQAFast_Blend				= (1 << 4),						/* Transparency blending */
	kQAFast_Antialiasing		= (1 << 5),						/* Antialiased rendering */
	kQAFast_ZSorted				= (1 << 6),						/* Z sorted rendering of non-opaque objects */
	kQAFast_CL4					= (1 << 7),						/* This engine accelerates kQAPixel_CL4 */
	kQAFast_CL8					= (1 << 8)						/* This engine accelerates kQAPixel_CL8 */
};


/************************************************************************************************
 *
 * Macro definitions for the drawing engine methods included in TQADrawContext. These
 * macros are the recommended means of accessing the engine's draw methods, e.g:
 *
 *		TQADrawContext	*drawContext;
 *		TQAVTexture		vertices[3];
 *
 *		drawContext = QADrawContextNew (rect, gdevice, engine, kQAContext_ZBuffer);
 *		...
 *		QASetInt (drawContext, kQATag_ZFunction, kQAZFunction_LT);
 *		QADrawTriGouraud (drawContext, &vertices[0], &vertices[1], &vertices[2], kQATriFlags_None);
 *
 * Note that QARenderStart(), QARenderEnd(), QAFlush() and QASync() have real function
 * definitions instead of macros. This is because these functions can afford the extra
 * per-call overhead of a function layer (which makes application code a little smaller),
 * and to allow a cleaner implementation of handling NULL parameters to QARenderStart().
 *
 ***********************************************************************************************/


#define QASetFloat(drawContext,tag,newValue) \
		(drawContext)->setFloat (drawContext,tag,newValue)

#define QASetInt(drawContext,tag,newValue) \
		(drawContext)->setInt (drawContext,tag,newValue)

#define QASetPtr(drawContext,tag,newValue) \
		(drawContext)->setPtr (drawContext,tag,newValue)

#define QAGetFloat(drawContext,tag) \
		(drawContext)->getFloat (drawContext,tag)

#define QAGetInt(drawContext,tag) \
		(drawContext)->getInt (drawContext,tag)

#define QAGetPtr(drawContext,tag) \
		(drawContext)->getPtr (drawContext,tag)

#define QADrawPoint(drawContext,v) \
		(drawContext)->drawPoint (drawContext,v)

#define QADrawLine(drawContext,v0,v1) \
		(drawContext)->drawLine (drawContext,v0,v1)

#define QADrawTriGouraud(drawContext,v0,v1,v2,flags) \
		(drawContext)->drawTriGouraud (drawContext,v0,v1,v2,flags)

#define QADrawTriTexture(drawContext,v0,v1,v2,flags) \
		(drawContext)->drawTriTexture (drawContext,v0,v1,v2,flags)

#define QASubmitVerticesGouraud(drawContext,nVertices,vertices) \
		(drawContext)->submitVerticesGouraud(drawContext,nVertices,vertices)
		
#define QASubmitVerticesTexture(drawContext,nVertices,vertices) \
		(drawContext)->submitVerticesTexture(drawContext,nVertices,vertices)

		
#define QADrawTriMeshGouraud(drawContext,nTriangle,triangles) \
		(drawContext)->drawTriMeshGouraud (drawContext,nTriangle,triangles)

#define QADrawTriMeshTexture(drawContext,nTriangle,triangles) \
		(drawContext)->drawTriMeshTexture (drawContext,nTriangle,triangles)

#define QADrawVGouraud(drawContext,nVertices,vertexMode,vertices,flags) \
		(drawContext)->drawVGouraud (drawContext,nVertices,vertexMode,vertices,flags)

#define QADrawVTexture(drawContext,nVertices,vertexMode,vertices,flags) \
		(drawContext)->drawVTexture (drawContext,nVertices,vertexMode,vertices,flags)

#define QADrawBitmap(drawContext,v,bitmap) \
		(drawContext)->drawBitmap (drawContext,v,bitmap)

#define QARenderStart(drawContext,dirtyRect,initialContext) \
		(drawContext)->renderStart (drawContext,dirtyRect,initialContext)

#define QARenderEnd(drawContext,modifiedRect) \
		(drawContext)->renderEnd (drawContext,modifiedRect)

#define QARenderAbort(drawContext) \
		(drawContext)->renderAbort (drawContext)

#define QAFlush(drawContext) \
		(drawContext)->flush (drawContext)

#define QASync(drawContext) \
		(drawContext)->sync (drawContext)

#define QASetNoticeMethod(drawContext, method, completionCallBack, refCon) \
		(drawContext)->setNoticeMethod (drawContext, method, completionCallBack, refCon)

#define QAGetNoticeMethod(drawContext, method, completionCallBack, refCon) \
		(drawContext)->getNoticeMethod (drawContext, method, completionCallBack, refCon)




/********************************************************************
 * TQAVersion sets the TQADrawContext 'version' field. It is set by
 * the manager to indicate the version of the TQADrawContext structure.
 *******************************************************************/

enum TQAVersion {
	kQAVersion_Prerelease		= 0,
	kQAVersion_1_0				= 1,
	kQAVersion_1_0_5			= 2,							/* Added tri mesh functions, color tables */
	kQAVersion_1_5				= 3								/* Added call backs, texture compression, and new error return code */
};
typedef enum TQAVersion TQAVersion;



/***********************************************************************
 * TQADrawContext structure holds method pointers.
 * This is a forward refrence. The structure is defined later.
 **********************************************************************/
typedef struct TQADrawContext 			TQADrawContext;
/************************************************************************************************
 *
 * Typedefs of draw method functions provided by the drawing engine. One function pointer
 * for each of these function types in stored in the TQADrawContext public data structure.
 *
 * These functions should be accessed through the QA<function>(context,...) macros,
 * defined above.
 *
 ***********************************************************************************************/
typedef CALLBACK_API_C( void , TQAStandardNoticeMethod )(const TQADrawContext *drawContext, void *refCon);
typedef CALLBACK_API_C( void , TQABufferNoticeMethod )(const TQADrawContext *drawContext, const TQADevice *buffer, const TQARect *dirtyRect, void *refCon);

union TQANoticeMethod {
	TQAStandardNoticeMethod 		standardNoticeMethod;		/* Used for non-buffer related methods */
	TQABufferNoticeMethod 			bufferNoticeMethod;			/* Used for buffer handling methods */
};
typedef union TQANoticeMethod			TQANoticeMethod;
typedef CALLBACK_API_C( void , TQASetFloat )(TQADrawContext *drawContext, TQATagFloat tag, float newValue);
typedef CALLBACK_API_C( void , TQASetInt )(TQADrawContext *drawContext, TQATagInt tag, unsigned long newValue);
typedef CALLBACK_API_C( void , TQASetPtr )(TQADrawContext *drawContext, TQATagPtr tag, const void *newValue);
typedef CALLBACK_API_C( float , TQAGetFloat )(const TQADrawContext *drawContext, TQATagFloat tag);
typedef CALLBACK_API_C( unsigned long , TQAGetInt )(const TQADrawContext *drawContext, TQATagInt tag);
typedef CALLBACK_API_C( void *, TQAGetPtr )(const TQADrawContext *drawContext, TQATagPtr tag);
typedef CALLBACK_API_C( void , TQADrawPoint )(const TQADrawContext *drawContext, const TQAVGouraud *v);
typedef CALLBACK_API_C( void , TQADrawLine )(const TQADrawContext *drawContext, const TQAVGouraud *v0, const TQAVGouraud *v1);
typedef CALLBACK_API_C( void , TQADrawTriGouraud )(const TQADrawContext *drawContext, const TQAVGouraud *v0, const TQAVGouraud *v1, const TQAVGouraud *v2, unsigned long flags);
typedef CALLBACK_API_C( void , TQADrawTriTexture )(const TQADrawContext *drawContext, const TQAVTexture *v0, const TQAVTexture *v1, const TQAVTexture *v2, unsigned long flags);
typedef CALLBACK_API_C( void , TQASubmitVerticesGouraud )(const TQADrawContext *drawContext, unsigned long nVertices, const TQAVGouraud *vertices);
typedef CALLBACK_API_C( void , TQASubmitVerticesTexture )(const TQADrawContext *drawContext, unsigned long nVertices, const TQAVTexture *vertices);
typedef CALLBACK_API_C( void , TQADrawTriMeshGouraud )(const TQADrawContext *drawContext, unsigned long nTriangles, const TQAIndexedTriangle *triangles);
typedef CALLBACK_API_C( void , TQADrawTriMeshTexture )(const TQADrawContext *drawContext, unsigned long nTriangles, const TQAIndexedTriangle *triangles);
typedef CALLBACK_API_C( void , TQADrawVGouraud )(const TQADrawContext *drawContext, unsigned long nVertices, TQAVertexMode vertexMode, const TQAVGouraud vertices[], const unsigned long flags[]);
typedef CALLBACK_API_C( void , TQADrawVTexture )(const TQADrawContext *drawContext, unsigned long nVertices, TQAVertexMode vertexMode, const TQAVTexture vertices[], const unsigned long flags[]);
typedef CALLBACK_API_C( void , TQADrawBitmap )(const TQADrawContext *drawContext, const TQAVGouraud *v, TQABitmap *bitmap);
typedef CALLBACK_API_C( void , TQARenderStart )(const TQADrawContext *drawContext, const TQARect *dirtyRect, const TQADrawContext *initialContext);
typedef CALLBACK_API_C( TQAError , TQARenderEnd )(const TQADrawContext *drawContext, const TQARect *modifiedRect);
typedef CALLBACK_API_C( TQAError , TQARenderAbort )(const TQADrawContext *drawContext);
typedef CALLBACK_API_C( TQAError , TQAFlush )(const TQADrawContext *drawContext);
typedef CALLBACK_API_C( TQAError , TQASync )(const TQADrawContext *drawContext);
typedef CALLBACK_API_C( TQAError , TQASetNoticeMethod )(const TQADrawContext *drawContext, TQAMethodSelector method, TQANoticeMethod completionCallBack, void *refCon);
typedef CALLBACK_API_C( TQAError , TQAGetNoticeMethod )(const TQADrawContext *drawContext, TQAMethodSelector method, TQANoticeMethod *completionCallBack, void **refCon);
/************************************************************************************************
 *
 * Public TQADrawContext structure. This contains function pointers for the chosen
 * drawing engine.
 *
 ***********************************************************************************************/

struct TQADrawContext {
	TQADrawPrivate *				drawPrivate;				/* Engine's private data for this context */
	TQAVersion 						version;					/* Version number */
	TQASetFloat 					setFloat;					/* Method: Set a float state variable */
	TQASetInt 						setInt;						/* Method: Set an unsigned long state variable */
	TQASetPtr 						setPtr;						/* Method: Set an unsigned long state variable */
	TQAGetFloat 					getFloat;					/* Method: Get a float state variable */
	TQAGetInt 						getInt;						/* Method: Get an unsigned long state variable */
	TQAGetPtr 						getPtr;						/* Method: Get an pointer state variable */
	TQADrawPoint 					drawPoint;					/* Method: Draw a point */
	TQADrawLine 					drawLine;					/* Method: Draw a line */
	TQADrawTriGouraud 				drawTriGouraud;				/* Method: Draw a Gouraud shaded triangle */
	TQADrawTriTexture 				drawTriTexture;				/* Method: Draw a texture mapped triangle */
	TQADrawVGouraud 				drawVGouraud;				/* Method: Draw Gouraud vertices */
	TQADrawVTexture 				drawVTexture;				/* Method: Draw texture vertices */
	TQADrawBitmap 					drawBitmap;					/* Method: Draw a bitmap */
	TQARenderStart 					renderStart;				/* Method: Initialize for rendering */
	TQARenderEnd 					renderEnd;					/* Method: Complete rendering and display */
	TQARenderAbort 					renderAbort;				/* Method: Abort any outstanding rendering (blocking) */
	TQAFlush 						flush;						/* Method: Start render of any queued commands (non-blocking) */
	TQASync 						sync;						/* Method: Wait for completion of all rendering (blocking) */
	TQASubmitVerticesGouraud 		submitVerticesGouraud;		/* Method: Submit Gouraud vertices for trimesh */
	TQASubmitVerticesTexture 		submitVerticesTexture;		/* Method: Submit Texture vertices for trimesh */
	TQADrawTriMeshGouraud 			drawTriMeshGouraud;			/* Method: Draw a Gouraud triangle mesh */
	TQADrawTriMeshTexture 			drawTriMeshTexture;			/* Method: Draw a Texture triangle mesh */
	TQASetNoticeMethod 				setNoticeMethod;			/* Method: Set a notice method */
	TQAGetNoticeMethod 				getNoticeMethod;			/* Method: Get a notice method */
};

/************************************************************************************************
 *
 * Acceleration manager function prototypes.
 *
 ***********************************************************************************************/
EXTERN_API_C( TQAError )
QADrawContextNew				(const TQADevice *		device,
								 const TQARect *		rect,
								 const TQAClip *		clip,
								 const TQAEngine *		engine,
								 unsigned long 			flags,
								 TQADrawContext **		newDrawContext);

EXTERN_API_C( void )
QADrawContextDelete				(TQADrawContext *		drawContext);

EXTERN_API_C( TQAError )
QAColorTableNew					(const TQAEngine *		engine,
								 TQAColorTableType 		tableType,
								 void *					pixelData,
								 long 					transparentIndexFlag,
								 TQAColorTable **		newTable);

EXTERN_API_C( void )
QAColorTableDelete				(const TQAEngine *		engine,
								 TQAColorTable *		colorTable);

EXTERN_API_C( TQAError )
QATextureNew					(const TQAEngine *		engine,
								 unsigned long 			flags,
								 TQAImagePixelType 		pixelType,
								 const TQAImage 		images[],
								 TQATexture **			newTexture);

EXTERN_API_C( TQAError )
QATextureDetach					(const TQAEngine *		engine,
								 TQATexture *			texture);

EXTERN_API_C( void )
QATextureDelete					(const TQAEngine *		engine,
								 TQATexture *			texture);

EXTERN_API_C( TQAError )
QATextureBindColorTable			(const TQAEngine *		engine,
								 TQATexture *			texture,
								 TQAColorTable *		colorTable);

EXTERN_API_C( TQAError )
QABitmapNew						(const TQAEngine *		engine,
								 unsigned long 			flags,
								 TQAImagePixelType 		pixelType,
								 const TQAImage *		image,
								 TQABitmap **			newBitmap);

EXTERN_API_C( TQAError )
QABitmapDetach					(const TQAEngine *		engine,
								 TQABitmap *			bitmap);

EXTERN_API_C( void )
QABitmapDelete					(const TQAEngine *		engine,
								 TQABitmap *			bitmap);

EXTERN_API_C( TQAError )
QABitmapBindColorTable			(const TQAEngine *		engine,
								 TQABitmap *			bitmap,
								 TQAColorTable *		colorTable);

EXTERN_API_C( TQAEngine *)
QADeviceGetFirstEngine			(const TQADevice *		device);

EXTERN_API_C( TQAEngine *)
QADeviceGetNextEngine			(const TQADevice *		device,
								 const TQAEngine *		currentEngine);

EXTERN_API_C( TQAError )
QAEngineCheckDevice				(const TQAEngine *		engine,
								 const TQADevice *		device);

EXTERN_API_C( TQAError )
QAEngineGestalt					(const TQAEngine *		engine,
								 TQAGestaltSelector 	selector,
								 void *					response);

EXTERN_API_C( TQAError )
QAEngineEnable					(long 					vendorID,
								 long 					engineID);

EXTERN_API_C( TQAError )
QAEngineDisable					(long 					vendorID,
								 long 					engineID);


#if TARGET_OS_MAC
EXTERN_API_C( TQAError )
QARegisterDrawNotificationProc	(Rect *					globalRect,
								 TQADrawNotificationProcPtr  proc,
								 long 					refCon,
								 TQADrawNotificationProcRefNum * refNum);

EXTERN_API_C( TQAError )
QAUnregisterDrawNotificationProc (TQADrawNotificationProcRefNum  refNum);

#endif  /* TARGET_OS_MAC */








#if PRAGMA_ENUM_ALWAYSINT
	#pragma enumsalwaysint reset
#elif PRAGMA_ENUM_OPTIONS
	#pragma option enum=reset
#elif defined(PRAGMA_ENUM_PACK__RAVE__)
	#pragma options(pack_enums)
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __RAVE__ */

