{
 	File:		QD3DDrawContext.p
 
 	Contains:	Draw context class types and routines				   			
 
 	Version:	Technology:	Quickdraw 3D 1.5.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DDrawContext;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DDRAWCONTEXT__}
{$SETC __QD3DDRAWCONTEXT__ := 1}

{$I+}
{$SETC QD3DDrawContextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **																			 **
 **							DrawContext Data Structures						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3DrawContextClearImageMethod  = LONGINT;
CONST
	kQ3ClearMethodNone			= {TQ3DrawContextClearImageMethod}0;
	kQ3ClearMethodWithColor		= {TQ3DrawContextClearImageMethod}1;



TYPE
	TQ3DrawContextDataPtr = ^TQ3DrawContextData;
	TQ3DrawContextData = RECORD
		clearImageMethod:		TQ3DrawContextClearImageMethod;
		clearImageColor:		TQ3ColorARGB;
		pane:					TQ3Area;
		paneState:				TQ3Boolean;
		mask:					TQ3Bitmap;
		maskState:				TQ3Boolean;
		doubleBufferState:		TQ3Boolean;
	END;

{*****************************************************************************
 **																			 **
 **								DrawContext Routines						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3DrawContext_GetType(drawContext: TQ3DrawContextObject): LONGINT; C;
FUNCTION Q3DrawContext_SetData(context: TQ3DrawContextObject; {CONST}VAR contextData: TQ3DrawContextData): TQ3Status; C;
FUNCTION Q3DrawContext_GetData(context: TQ3DrawContextObject; VAR contextData: TQ3DrawContextData): TQ3Status; C;
FUNCTION Q3DrawContext_SetClearImageColor(context: TQ3DrawContextObject; {CONST}VAR color: TQ3ColorARGB): TQ3Status; C;
FUNCTION Q3DrawContext_GetClearImageColor(context: TQ3DrawContextObject; VAR color: TQ3ColorARGB): TQ3Status; C;
FUNCTION Q3DrawContext_SetPane(context: TQ3DrawContextObject; {CONST}VAR pane: TQ3Area): TQ3Status; C;
FUNCTION Q3DrawContext_GetPane(context: TQ3DrawContextObject; VAR pane: TQ3Area): TQ3Status; C;
FUNCTION Q3DrawContext_SetPaneState(context: TQ3DrawContextObject; state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_GetPaneState(context: TQ3DrawContextObject; VAR state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_SetClearImageMethod(context: TQ3DrawContextObject; method: TQ3DrawContextClearImageMethod): TQ3Status; C;
FUNCTION Q3DrawContext_GetClearImageMethod(context: TQ3DrawContextObject; VAR method: TQ3DrawContextClearImageMethod): TQ3Status; C;
FUNCTION Q3DrawContext_SetMask(context: TQ3DrawContextObject; {CONST}VAR mask: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3DrawContext_GetMask(context: TQ3DrawContextObject; VAR mask: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3DrawContext_SetMaskState(context: TQ3DrawContextObject; state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_GetMaskState(context: TQ3DrawContextObject; VAR state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_SetDoubleBufferState(context: TQ3DrawContextObject; state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_GetDoubleBufferState(context: TQ3DrawContextObject; VAR state: TQ3Boolean): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Pixmap Data Structure							 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3PixmapDrawContextDataPtr = ^TQ3PixmapDrawContextData;
	TQ3PixmapDrawContextData = RECORD
		drawContextData:		TQ3DrawContextData;
		pixmap:					TQ3Pixmap;
	END;

{*****************************************************************************
 **																			 **
 **						Pixmap DrawContext Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3PixmapDrawContext_New({CONST}VAR contextData: TQ3PixmapDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3PixmapDrawContext_SetPixmap(drawContext: TQ3DrawContextObject; {CONST}VAR pixmap: TQ3Pixmap): TQ3Status; C;
FUNCTION Q3PixmapDrawContext_GetPixmap(drawContext: TQ3DrawContextObject; VAR pixmap: TQ3Pixmap): TQ3Status; C;


{$IFC TARGET_OS_MAC }
{*****************************************************************************
 **																			 **
 **						Macintosh DrawContext Data Structures				 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3MacDrawContext2DLibrary 	= LONGINT;
CONST
	kQ3Mac2DLibraryNone			= {TQ3MacDrawContext2DLibrary}0;
	kQ3Mac2DLibraryQuickDraw	= {TQ3MacDrawContext2DLibrary}1;
	kQ3Mac2DLibraryQuickDrawGX	= {TQ3MacDrawContext2DLibrary}2;



TYPE
	TQ3MacDrawContextDataPtr = ^TQ3MacDrawContextData;
	TQ3MacDrawContextData = RECORD
		drawContextData:		TQ3DrawContextData;
		window:					CWindowPtr;
		library:				TQ3MacDrawContext2DLibrary;
		viewPort:				gxViewPort;
		grafPort:				CGrafPtr;
	END;

{*****************************************************************************
 **																			 **
 **						Macintosh DrawContext Routines						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3MacDrawContext_New({CONST}VAR drawContextData: TQ3MacDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3MacDrawContext_SetWindow(drawContext: TQ3DrawContextObject; window: CWindowPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_GetWindow(drawContext: TQ3DrawContextObject; VAR window: CWindowPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_SetGXViewPort(drawContext: TQ3DrawContextObject; viewPort: gxViewPort): TQ3Status; C;
FUNCTION Q3MacDrawContext_GetGXViewPort(drawContext: TQ3DrawContextObject; VAR viewPort: gxViewPort): TQ3Status; C;
FUNCTION Q3MacDrawContext_SetGrafPort(drawContext: TQ3DrawContextObject; grafPort: CGrafPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_GetGrafPort(drawContext: TQ3DrawContextObject; VAR grafPort: CGrafPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_Set2DLibrary(drawContext: TQ3DrawContextObject; library: TQ3MacDrawContext2DLibrary): TQ3Status; C;
FUNCTION Q3MacDrawContext_Get2DLibrary(drawContext: TQ3DrawContextObject; VAR library: TQ3MacDrawContext2DLibrary): TQ3Status; C;
{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_UNIX }
{*****************************************************************************
 **																			 **
 **						X/Windows DrawContext Data Structures				 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3XBufferObject = ^LONGINT;
	TQ3XColormapDataPtr = ^TQ3XColormapData;
	TQ3XColormapData = RECORD
		baseEntry:				LONGINT;
		maxRed:					LONGINT;
		maxGreen:				LONGINT;
		maxBlue:				LONGINT;
		multRed:				LONGINT;
		multGreen:				LONGINT;
		multBlue:				LONGINT;
	END;

	TQ3XDrawContextDataPtr = ^TQ3XDrawContextData;
	TQ3XDrawContextData = RECORD
		contextData:			TQ3DrawContextData;
		display:				DisplayPtr;
		drawable:				Drawable;
		visual:					VisualPtr;
		cmap:					Colormap;
		colorMapData:			TQ3XColormapDataPtr;
	END;

{*****************************************************************************
 **																			 **
 **						X/Windows DrawContext Routines						 **
 **																			 **
 ****************************************************************************}
{$IFC NOT UNDEFINED XDC_OLD }
FUNCTION Q3XDrawContext_New: TQ3DrawContextObject; C;
PROCEDURE Q3XDrawContext_Set(drawContext: TQ3DrawContextObject; flag: LONGINT; data: UNIV Ptr); C;
PROCEDURE Q3XDrawContext_Get(drawContext: TQ3DrawContextObject; flag: LONGINT; data: UNIV Ptr); C;
{$ENDC}
FUNCTION Q3XBuffers_New(VAR dpy: Display; numBuffers: LONGINT; window: Window): TQ3XBufferObject; C;
PROCEDURE Q3XBuffers_Swap(VAR dpy: Display; buffers: TQ3XBufferObject); C;
FUNCTION Q3X_GetVisualInfo(VAR dpy: Display; VAR screen: Screen): XVisualInfoPtr; C;

FUNCTION Q3XDrawContext_New({CONST}VAR xContextData: TQ3XDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3XDrawContext_SetDisplay(drawContext: TQ3DrawContextObject; {CONST}VAR display: Display): TQ3Status; C;
FUNCTION Q3XDrawContext_GetDisplay(drawContext: TQ3DrawContextObject; VAR display: DisplayPtr): TQ3Status; C;
FUNCTION Q3XDrawContext_SetDrawable(drawContext: TQ3DrawContextObject; drawable: Drawable): TQ3Status; C;
FUNCTION Q3XDrawContext_GetDrawable(drawContext: TQ3DrawContextObject; VAR drawable: Drawable): TQ3Status; C;
FUNCTION Q3XDrawContext_SetVisual(drawContext: TQ3DrawContextObject; {CONST}VAR visual: Visual): TQ3Status; C;
FUNCTION Q3XDrawContext_GetVisual(drawContext: TQ3DrawContextObject; VAR visual: VisualPtr): TQ3Status; C;
FUNCTION Q3XDrawContext_SetColormap(drawContext: TQ3DrawContextObject; colormap: Colormap): TQ3Status; C;
FUNCTION Q3XDrawContext_GetColormap(drawContext: TQ3DrawContextObject; VAR colormap: Colormap): TQ3Status; C;
FUNCTION Q3XDrawContext_SetColormapData(drawContext: TQ3DrawContextObject; {CONST}VAR colormapData: TQ3XColormapData): TQ3Status; C;
FUNCTION Q3XDrawContext_GetColormapData(drawContext: TQ3DrawContextObject; VAR colormapData: TQ3XColormapData): TQ3Status; C;
{$ENDC}  {TARGET_OS_UNIX}

{$IFC TARGET_OS_WIN32 }
{*****************************************************************************
 **																			 **
 **						 Win32 DrawContext Data Structures				 	 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3Win32DCDrawContextDataPtr = ^TQ3Win32DCDrawContextData;
	TQ3Win32DCDrawContextData = RECORD
		drawContextData:		TQ3DrawContextData;
		hdc:					HDC;
	END;

{$IFC NOT NOT UNDEFINED QD3D_NO_DIRECTDRAW }
	TQ3DirectDrawObjectSelector  = LONGINT;
CONST
	kQ3DirectDrawObject			= {TQ3DirectDrawObjectSelector}1;
	kQ3DirectDrawObject2		= {TQ3DirectDrawObjectSelector}2;


TYPE
	TQ3DirectDrawSurfaceSelector  = LONGINT;
CONST
	kQ3DirectDrawSurface		= {TQ3DirectDrawSurfaceSelector}1;
	kQ3DirectDrawSurface2		= {TQ3DirectDrawSurfaceSelector}2;


TYPE
	TQ3DDSurfaceDescriptorPtr = ^TQ3DDSurfaceDescriptor;
	TQ3DDSurfaceDescriptor = RECORD
		objectSelector:			TQ3DirectDrawObjectSelector;
		filler:					ARRAY [0..3] OF LONGINT;
	END;

	TQ3DDSurfaceDrawContextDataPtr = ^TQ3DDSurfaceDrawContextData;
	TQ3DDSurfaceDrawContextData = RECORD
		drawContextData:		TQ3DrawContextData;
		ddSurfaceDescriptor:	TQ3DDSurfaceDescriptor;
	END;

{$ENDC}
{*****************************************************************************
 **																			 **
 **							Win32DC DrawContext Routines					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Win32DCDrawContext_New({CONST}VAR drawContextData: TQ3Win32DCDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3Win32DCDrawContext_SetDC(drawContext: TQ3DrawContextObject; hdc: HDC): TQ3Status; C;
FUNCTION Q3Win32DCDrawContext_GetDC(drawContext: TQ3DrawContextObject; VAR hdc: HDC): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							DDSurface DrawContext Routines					 **
 **																			 **
 ****************************************************************************}
{$IFC NOT NOT UNDEFINED QD3D_NO_DIRECTDRAW }
FUNCTION Q3DDSurfaceDrawContext_New({CONST}VAR drawContextData: TQ3DDSurfaceDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3DDSurfaceDrawContext_SetDirectDrawSurface(drawContext: TQ3DrawContextObject; {CONST}VAR ddSurfaceDescriptor: TQ3DDSurfaceDescriptor): TQ3Status; C;
FUNCTION Q3DDSurfaceDrawContext_GetDirectDrawSurface(drawContext: TQ3DrawContextObject; VAR ddSurfaceDescriptor: TQ3DDSurfaceDescriptor): TQ3Status; C;
{$ENDC}
{$ENDC}  {TARGET_OS_WIN32}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DDrawContextIncludes}

{$ENDC} {__QD3DDRAWCONTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}