/******************************************************************************
 **																			 **
 ** 	Module:		QD3DShader.h											 **
 **																			 **
 **																			 **
 ** 	Purpose: 	QuickDraw 3D Shader / Color Routines					 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1991-1997 Apple Computer, Inc. All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DShader_h
#define QD3DShader_h

#include "QD3D.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DSHADER 1
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
 **								RGB Color routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Set(
	TQ3ColorRGB			*color,
	float				r,
	float				g,
	float				b);

QD3D_EXPORT TQ3ColorARGB *QD3D_CALL Q3ColorARGB_Set(
	TQ3ColorARGB		*color,
	float				a,
	float				r,
	float				g,
	float				b);

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Add(
	const TQ3ColorRGB 	*c1, 
	const TQ3ColorRGB 	*c2,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Subtract(
	const TQ3ColorRGB 	*c1, 
	const TQ3ColorRGB 	*c2,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Scale(
	const TQ3ColorRGB 	*color, 
	float				scale,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Clamp(
	const TQ3ColorRGB 	*color,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Lerp(
	const TQ3ColorRGB 	*first, 
	const TQ3ColorRGB 	*last, 
	float 				alpha,
	TQ3ColorRGB 		*result);

QD3D_EXPORT TQ3ColorRGB *QD3D_CALL Q3ColorRGB_Accumulate(
	const TQ3ColorRGB 	*src, 
	TQ3ColorRGB 		*result);

QD3D_EXPORT float *QD3D_CALL Q3ColorRGB_Luminance(
	const TQ3ColorRGB	*color, 
	float 				*luminance);


/******************************************************************************
 **																			 **
 **								Shader Types								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3ShaderUVBoundary {
	kQ3ShaderUVBoundaryWrap,
	kQ3ShaderUVBoundaryClamp
} TQ3ShaderUVBoundary;


/******************************************************************************
 **																			 **
 **								Shader Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Shader_GetType(
	TQ3ShaderObject			shader);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_Submit(
	TQ3ShaderObject			shader, 
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_SetUVTransform(
	TQ3ShaderObject			shader,
	const TQ3Matrix3x3		*uvTransform);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_GetUVTransform(
	TQ3ShaderObject			shader,
	TQ3Matrix3x3			*uvTransform);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_SetUBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		uBoundary);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_SetVBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		vBoundary);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_GetUBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		*uBoundary);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Shader_GetVBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		*vBoundary);


/******************************************************************************
 **																			 **
 **							Illumination Shader	Classes						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3IlluminationShader_GetType(
	TQ3ShaderObject				shader);

QD3D_EXPORT TQ3ShaderObject QD3D_CALL Q3PhongIllumination_New(
	void);

QD3D_EXPORT TQ3ShaderObject QD3D_CALL Q3LambertIllumination_New(
	void);

QD3D_EXPORT TQ3ShaderObject QD3D_CALL Q3NULLIllumination_New(
	void);


/******************************************************************************
 **																			 **
 **								 Surface Shader								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3SurfaceShader_GetType(
	TQ3SurfaceShaderObject		shader);


/******************************************************************************
 **																			 **
 **								Texture Shader								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ShaderObject QD3D_CALL Q3TextureShader_New(
	TQ3TextureObject			texture);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TextureShader_GetTexture(
	TQ3ShaderObject				shader,
	TQ3TextureObject			*texture);

QD3D_EXPORT TQ3Status QD3D_CALL Q3TextureShader_SetTexture(
	TQ3ShaderObject				shader,
	TQ3TextureObject			texture);


/******************************************************************************
 **																			 **
 **								Texture Objects								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Texture_GetType(
	TQ3TextureObject		texture);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Texture_GetWidth(
	TQ3TextureObject		texture,
	unsigned long			*width);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Texture_GetHeight(
	TQ3TextureObject		texture,
	unsigned long			*height);


/******************************************************************************
 **																			 **
 **								Pixmap Texture							     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TextureObject QD3D_CALL Q3PixmapTexture_New(
	const TQ3StoragePixmap	*pixmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapTexture_GetPixmap(
	TQ3TextureObject		texture,
	TQ3StoragePixmap		*pixmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapTexture_SetPixmap(
	TQ3TextureObject		texture,
	const TQ3StoragePixmap	*pixmap);


/******************************************************************************
 **																			 **
 **								Mipmap Texture							     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TextureObject QD3D_CALL Q3MipmapTexture_New(
	const TQ3Mipmap			*mipmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MipmapTexture_GetMipmap(
	TQ3TextureObject		texture,
	TQ3Mipmap				*mipmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MipmapTexture_SetMipmap(
	TQ3TextureObject		texture,
	const TQ3Mipmap			*mipmap);



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
	#if PRAGMA_ENUM_RESET_QD3DSHADER
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DSHADER
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DShader_h  */
