/******************************************************************************
 **																			 **
 ** 	Module:		QD3DDrawContext.h										 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose:	Draw context class types and routines				   	 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1993-1997 Apple Computer, Inc. All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DDrawContext_h
#define QD3DDrawContext_h

#include "QD3D.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=small
#endif

#include <Quickdraw.h>
#include <FixMath.h>
#include <GXTypes.h>

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DDRAWCON 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */


#if defined(WINDOW_SYSTEM_X11) && WINDOW_SYSTEM_X11
	#include <X11/Xlib.h>
	#include <X11/Xutil.h>
#endif /* WINDOW_SYSTEM_X11 */

#if defined(WINDOW_SYSTEM_WIN32) && WINDOW_SYSTEM_WIN32
	#include <windows.h>
/******************************************************************************
 *																			 **
 * ABOUT   QD3D_NO_DIRECTDRAW:	 (Win32 Only)        						 **
 *																			 **
 * NOTE: Define QD3D_NO_DIRECTDRAW for your application makefile/project     **
 *       only if you don't need Q3DDSurfaceDrawContext support and don't     **
 *       have access to ddraw.h.	                                         ** 
 *																			 **
 *****************************************************************************/
#if !defined(QD3D_NO_DIRECTDRAW)
	#include <ddraw.h>
#endif /* !QD3D_NO_DIRECTDRAW */
#endif  /*  WINDOW_SYSTEM_WIN32  */

#ifdef __cplusplus
extern "C" {
#endif /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **							DrawContext Data Structures						 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3DrawContextClearImageMethod{
	kQ3ClearMethodNone,
	kQ3ClearMethodWithColor
} TQ3DrawContextClearImageMethod;


typedef struct TQ3DrawContextData {
	TQ3DrawContextClearImageMethod	clearImageMethod;
	TQ3ColorARGB					clearImageColor;
	TQ3Area							pane;
	TQ3Boolean						paneState;
	TQ3Bitmap						mask;
	TQ3Boolean						maskState;
	TQ3Boolean						doubleBufferState;
} TQ3DrawContextData;


/******************************************************************************
 **																			 **
 **								DrawContext Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3DrawContext_GetType(
	TQ3DrawContextObject		drawContext);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetData(
	TQ3DrawContextObject		context,
	const TQ3DrawContextData	*contextData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetData(
	TQ3DrawContextObject		context,
	TQ3DrawContextData			*contextData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetClearImageColor(
	TQ3DrawContextObject		context,
	const TQ3ColorARGB 			*color);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetClearImageColor(
	TQ3DrawContextObject		context,
	TQ3ColorARGB 				*color);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetPane(
	TQ3DrawContextObject		context,
	const TQ3Area	 			*pane);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetPane(
	TQ3DrawContextObject		context,
	TQ3Area	 					*pane);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetPaneState(
	TQ3DrawContextObject		context,
	TQ3Boolean					state);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetPaneState(
	TQ3DrawContextObject		context,
	TQ3Boolean					*state);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetClearImageMethod(
	TQ3DrawContextObject			context,
	TQ3DrawContextClearImageMethod 	method);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetClearImageMethod(
	TQ3DrawContextObject			context,
	TQ3DrawContextClearImageMethod 	*method);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetMask(
	TQ3DrawContextObject		context,
	const TQ3Bitmap				*mask);
		
QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetMask(
	TQ3DrawContextObject		context,
	TQ3Bitmap					*mask);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetMaskState(
	TQ3DrawContextObject		context,
	TQ3Boolean					state);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetMaskState(
	TQ3DrawContextObject		context,
	TQ3Boolean					*state);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_SetDoubleBufferState(
	TQ3DrawContextObject		context,
	TQ3Boolean 					state);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DrawContext_GetDoubleBufferState(
	TQ3DrawContextObject		context,
	TQ3Boolean 					*state);


/******************************************************************************
 **																			 **
 **							Pixmap Data Structure							 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3PixmapDrawContextData {
	TQ3DrawContextData		drawContextData;
	TQ3Pixmap				pixmap;
} TQ3PixmapDrawContextData;


/******************************************************************************
 **																			 **
 **						Pixmap DrawContext Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3DrawContextObject QD3D_CALL Q3PixmapDrawContext_New(
	const TQ3PixmapDrawContextData	*contextData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapDrawContext_SetPixmap(
	TQ3DrawContextObject			drawContext,
	const TQ3Pixmap					*pixmap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3PixmapDrawContext_GetPixmap(
	TQ3DrawContextObject			drawContext,
	TQ3Pixmap						*pixmap);

#if defined(WINDOW_SYSTEM_MACINTOSH) && WINDOW_SYSTEM_MACINTOSH

/******************************************************************************
 **																			 **
 **						Macintosh DrawContext Data Structures				 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3MacDrawContext2DLibrary {
	kQ3Mac2DLibraryNone,
	kQ3Mac2DLibraryQuickDraw,
	kQ3Mac2DLibraryQuickDrawGX
} TQ3MacDrawContext2DLibrary;


typedef struct TQ3MacDrawContextData {
	TQ3DrawContextData			drawContextData;
	CWindowPtr					window;
	TQ3MacDrawContext2DLibrary	library;
	gxViewPort					viewPort;
	CGrafPtr					grafPort;
} TQ3MacDrawContextData;


/******************************************************************************
 **																			 **
 **						Macintosh DrawContext Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3DrawContextObject QD3D_CALL Q3MacDrawContext_New(
	const TQ3MacDrawContextData	*drawContextData);
	
QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_SetWindow(
	TQ3DrawContextObject		drawContext,
	const CWindowPtr			window);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_GetWindow(
	TQ3DrawContextObject		drawContext,
	CWindowPtr					*window);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_SetGXViewPort(
	TQ3DrawContextObject		drawContext,
	const gxViewPort			viewPort);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_GetGXViewPort(
	TQ3DrawContextObject		drawContext,
	gxViewPort					*viewPort);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_SetGrafPort(
	TQ3DrawContextObject		drawContext,
	const CGrafPtr				grafPort);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_GetGrafPort(
	TQ3DrawContextObject		drawContext,
	CGrafPtr					*grafPort);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_Set2DLibrary(
	TQ3DrawContextObject		drawContext,
	TQ3MacDrawContext2DLibrary	library);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacDrawContext_Get2DLibrary(
	TQ3DrawContextObject		drawContext,
	TQ3MacDrawContext2DLibrary	*library);

#endif /* WINDOW_SYSTEM_MACINTOSH */

#if defined(WINDOW_SYSTEM_X11) && WINDOW_SYSTEM_X11

/******************************************************************************
 **																			 **
 **								Types										 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3XBufferData *TQ3XBufferObject;

typedef struct TQ3XColormapData {
	long		baseEntry;
	long		maxRed;
	long		maxGreen;
	long		maxBlue;
	long		multRed;
	long		multGreen;
	long		multBlue;
} TQ3XColormapData;


typedef struct TQ3XDrawContextData {
	TQ3DrawContextData		contextData;
	Display					*display;
	Drawable				drawable;
	Visual					*visual;
	Colormap				cmap;
	TQ3XColormapData		*colorMapData;
} TQ3XDrawContextData;


/******************************************************************************
 **																			 **
 **							XDrawContext Routines							 **
 **																			 **
 *****************************************************************************/

#ifdef XDC_OLD
QD3D_EXPORT TQ3DrawContextObject QD3D_CALL Q3XDrawContext_New(
	void);

QD3D_EXPORT void QD3D_CALL Q3XDrawContext_Set(
	TQ3DrawContextObject	drawContext,
	unsigned long			flag,							 
	void					*data);

QD3D_EXPORT void QD3D_CALL Q3XDrawContext_Get(
	TQ3DrawContextObject	drawContext,
	unsigned long			flag,							 
	void					*data);
#endif  /* XDC_OLD */

QD3D_EXPORT TQ3XBufferObject QD3D_CALL Q3XBuffers_New(
	Display					*dpy,					   
    unsigned long			numBuffers,
    Window					window);

QD3D_EXPORT void QD3D_CALL Q3XBuffers_Swap(
	Display					*dpy,
	TQ3XBufferObject		buffers);

QD3D_EXPORT XVisualInfo *QD3D_CALL Q3X_GetVisualInfo(
	Display					*dpy,
	Screen					*screen);


QD3D_EXPORT TQ3DrawContextObject QD3D_CALL Q3XDrawContext_New(
	const TQ3XDrawContextData	*xContextData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_SetDisplay(
	TQ3DrawContextObject		drawContext,
	const Display				*display);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_GetDisplay(
	TQ3DrawContextObject		drawContext,
	Display						**display);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_SetDrawable(
	TQ3DrawContextObject		drawContext,
	Drawable					drawable);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_GetDrawable(
	TQ3DrawContextObject		drawContext,
	Drawable					*drawable);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_SetVisual(
	TQ3DrawContextObject		drawContext,
	const Visual				*visual);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_GetVisual(
	TQ3DrawContextObject		drawContext,
	Visual						**visual);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_SetColormap(
	TQ3DrawContextObject		drawContext,
	Colormap					colormap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_GetColormap(
	TQ3DrawContextObject		drawContext,
	Colormap					*colormap);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_SetColormapData(
	TQ3DrawContextObject		drawContext,
	const TQ3XColormapData		*colormapData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3XDrawContext_GetColormapData(
	TQ3DrawContextObject		drawContext,
	TQ3XColormapData			*colormapData);

#endif /* WINDOW_SYSTEM_X11 */

#if defined(WINDOW_SYSTEM_WIN32) && WINDOW_SYSTEM_WIN32

/******************************************************************************
 **																			 **
 **								Types										 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3Win32DCDrawContextData {
	TQ3DrawContextData		drawContextData;
	HDC						hdc;
} TQ3Win32DCDrawContextData;

#if !defined(QD3D_NO_DIRECTDRAW)

typedef enum {
	kQ3DirectDrawObject		= 1,
	kQ3DirectDrawObject2	= 2
} TQ3DirectDrawObjectSelector;

typedef enum {
	kQ3DirectDrawSurface	= 1,
	kQ3DirectDrawSurface2	= 2
} TQ3DirectDrawSurfaceSelector;

typedef struct TQ3DDSurfaceDescriptor {
	TQ3DirectDrawObjectSelector		objectSelector;
	union
	{
		LPDIRECTDRAW				lpDirectDraw;
		LPDIRECTDRAW2				lpDirectDraw2;
	};

	TQ3DirectDrawSurfaceSelector	surfaceSelector;
	union
	{
		LPDIRECTDRAWSURFACE			lpDirectDrawSurface;
		LPDIRECTDRAWSURFACE2		lpDirectDrawSurface2;
	};
} TQ3DDSurfaceDescriptor;

typedef struct TQ3DDSurfaceDrawContextData {
	TQ3DrawContextData				drawContextData;
	TQ3DDSurfaceDescriptor			ddSurfaceDescriptor;
} TQ3DDSurfaceDrawContextData;

#endif /* !QD3D_NO_DIRECTDRAW */

/******************************************************************************
 **																			 **
 **							Win32DC DrawContext Routines					 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3DrawContextObject QD3D_CALL Q3Win32DCDrawContext_New(
	const TQ3Win32DCDrawContextData	*drawContextData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Win32DCDrawContext_SetDC(
	TQ3DrawContextObject		drawContext,
	const HDC					hdc);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Win32DCDrawContext_GetDC(
	TQ3DrawContextObject		drawContext,
	HDC							*hdc);


/******************************************************************************
 **																			 **
 **							DDSurface DrawContext Routines					 **
 **																			 **
 *****************************************************************************/
#if !defined(QD3D_NO_DIRECTDRAW)

QD3D_EXPORT TQ3DrawContextObject QD3D_CALL Q3DDSurfaceDrawContext_New(
	const TQ3DDSurfaceDrawContextData	*drawContextData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DDSurfaceDrawContext_SetDirectDrawSurface(
	TQ3DrawContextObject			drawContext,
	const TQ3DDSurfaceDescriptor	*ddSurfaceDescriptor);

QD3D_EXPORT TQ3Status QD3D_CALL Q3DDSurfaceDrawContext_GetDirectDrawSurface(
	TQ3DrawContextObject		drawContext,
	TQ3DDSurfaceDescriptor		*ddSurfaceDescriptor);

#endif /* !QD3D_NO_DIRECTDRAW */

#endif  /*  WINDOW_SYSTEM_WIN32  */


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
	#if PRAGMA_ENUM_RESET_QD3DDRAWCON
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DDRAWCON
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DDrawContext_h  */
