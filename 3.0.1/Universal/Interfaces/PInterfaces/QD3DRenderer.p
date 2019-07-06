{
 	File:		QD3DRenderer.p
 
 	Contains:	Q3Renderer types and routines	 						 			
 
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
 UNIT QD3DRenderer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DRENDERER__}
{$SETC __QD3DRENDERER__ := 1}

{$I+}
{$SETC QD3DRendererIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DSET__}
{$I QD3DSet.p}
{$ENDC}
{$IFC UNDEFINED __QD3DVIEW__}
{$I QD3DView.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **																			 **
 **							User Interface Things							 **
 **																			 **
 ****************************************************************************}
{$IFC TARGET_OS_MAC }
{
 *  A callback to an application's event handling code. This is needed to    
 *  support movable modal dialogs. The dialog's event filter calls this      
 *  callback with events it does not handle.                                 
 *  If an application handles the event it should return kQ3True.            
 *  If the application does not handle the event it must return kQ3False and 
 *  the dialog's event filter will pass the event to the system unhandled.   
 }

TYPE
	TQ3MacOSDialogEventHandler = ProcPtr;  { FUNCTION TQ3MacOSDialogEventHandler((CONST)VAR event: EventRecord): TQ3Boolean; C; }

	TQ3DialogAnchorPtr = ^TQ3DialogAnchor;
	TQ3DialogAnchor = RECORD
		clientEventHandler:		TQ3MacOSDialogEventHandler;
	END;

{$ELSEC}
{$IFC TARGET_OS_WIN32 }

TYPE
	TQ3DialogAnchor = RECORD
		ownerWindow:			HWND;
	END;

{$ELSEC}

TYPE
	TQ3DialogAnchorPtr = ^TQ3DialogAnchor;
	TQ3DialogAnchor = RECORD
		notUsed:				Ptr;									{  place holder  }
	END;

{$ENDC}
{$ENDC}

{*****************************************************************************
 **																			 **
 **							Renderer Functions								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Renderer_NewFromType(rendererObjectType: TQ3ObjectType): TQ3RendererObject; C;
FUNCTION Q3Renderer_GetType(renderer: TQ3RendererObject): LONGINT; C;


{
 *	Non-blocking, flush all buffered graphics to rasterizer. May or
 *	may not update the draw context.
 *	
 *	This function has been replaced by Q3View_Flush
 }
FUNCTION Q3Renderer_Flush(renderer: TQ3RendererObject; view: TQ3ViewObject): TQ3Status; C;
{
 *	Blocking, flush all buffered graphics to rasterizer and update
 *	draw context.
 *	
 *	This function has been replaced by Q3View_Sync
 }
FUNCTION Q3Renderer_Sync(renderer: TQ3RendererObject; view: TQ3ViewObject): TQ3Status; C;


{
 *	Q3Renderer_IsInteractive
 *		Determine if this renderer is intended to be used interactively.
 }
FUNCTION Q3Renderer_IsInteractive(renderer: TQ3RendererObject): TQ3Boolean; C;

{
 *	Q3Renderer_HasModalConfigure
 *		Determine if this renderer has a modal settings dialog.
 *
 *	Q3Renderer_ModalConfigure
 *		Have the renderer pop up a modal dialog box to configure its settings.
 *	dialogAnchor - is platform specific data passed by the client to support
 *      movable modal dialogs. 
 *    MacOS: this is a callback to the calling application's event handler.
 *      The renderer calls this function with events not handled by the 
 *      settings dialog. This is necessary in order to support movable modal 
 *      dialogs. An application's event handler must return kQ3True if it 
 *      handles the event passed to the callback or kQ3False if not. 
 *      An application which doesn't want to support a movable modal configure
 *      dialog should pass NULL for the clientEventHandler of TQ3DialogAnchor.
 *    Win32: this is the HWND of the owning window (typically an application's
 *      main window).
 *  canceled - returns a boolean inditacating that the user canceled the 
 *	dialog.
 *      
 }
FUNCTION Q3Renderer_HasModalConfigure(renderer: TQ3RendererObject): TQ3Boolean; C;
FUNCTION Q3Renderer_ModalConfigure(renderer: TQ3RendererObject; dialogAnchor: TQ3DialogAnchor; VAR canceled: TQ3Boolean): TQ3Status; C;
{
 *	Q3RendererClass_GetNickNameString
 *		Allows an application to get a renderers name string, the 
 *		renderer is responsible for storing this in a localizable format
 *		for example as a resource.  This string can then be used to provide
 *		a selection mechanism for an application (for example in a menu).
 *
 *		If this call returns nil in the supplied string, then the App may 
 * 		choose to use the class name for the renderer.  You should always 
 *		try to get the name string before using the class name, since the
 *		class name is not localizable.
 }
FUNCTION Q3RendererClass_GetNickNameString(rendererClassType: TQ3ObjectType; VAR rendererClassString: TQ3ObjectClassNameString): TQ3Status; C;

{
 *	Q3Renderer_GetConfigurationData
 *		Allows an application to collect private renderer configuration data
 *      which it will then save. For example in a preference file or in a 
 *		style template. An application should tag this data with the 
 *		Renderer's object  name.
 *	
 *		if dataBuffer is NULL actualDataSize returns the required size in 
 *		bytes of a data buffer large enough to store private data. 
 *
 *      bufferSize is the actual size of the memory block pointed to by 
 *		dataBuffer
 *
 *		actualDataSize - on return the actual number of bytes written to the 
 *		buffer or if dataBuffer is NULL the required size of dataBuffer
 * 
 }
FUNCTION Q3Renderer_GetConfigurationData(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: LONGINT; VAR actualDataSize: LONGINT): TQ3Status; C;
FUNCTION Q3Renderer_SetConfigurationData(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: LONGINT): TQ3Status; C;


{*****************************************************************************
 **																			 **
 **						Interactive Renderer Specific Functions				 **
 **																			 **
 ****************************************************************************}
{ CSG IDs attribute }
{ Object IDs, to be applied as attributes on geometries }
{ Possible CSG equations }

TYPE
	TQ3CSGEquation 				= LONGINT;
CONST
	kQ3CSGEquationAandB			= {TQ3CSGEquation}$88888888;
	kQ3CSGEquationAandnotB		= {TQ3CSGEquation}$22222222;
	kQ3CSGEquationAanBonCad		= {TQ3CSGEquation}$2F222F22;
	kQ3CSGEquationnotAandB		= {TQ3CSGEquation}$44444444;
	kQ3CSGEquationnAaBorCanB	= {TQ3CSGEquation}$74747474;


TYPE
	TQ3HiddenSurfaceRemovalMode  = LONGINT;
CONST
	kQ3HiddenSurfaceRemovalMode_None = {TQ3HiddenSurfaceRemovalMode}0;
	kQ3HiddenSurfaceRemovalMode_Shallow = {TQ3HiddenSurfaceRemovalMode}1;
	kQ3HiddenSurfaceRemovalMode_Deep = {TQ3HiddenSurfaceRemovalMode}2;

FUNCTION Q3InteractiveRenderer_SetCSGEquation(renderer: TQ3RendererObject; equation: TQ3CSGEquation): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetCSGEquation(renderer: TQ3RendererObject; VAR equation: TQ3CSGEquation): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_SetPreferences(renderer: TQ3RendererObject; vendorID: LONGINT; engineID: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetPreferences(renderer: TQ3RendererObject; VAR vendorID: LONGINT; VAR engineID: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_SetDoubleBufferBypass(renderer: TQ3RendererObject; bypass: TQ3Boolean): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetDoubleBufferBypass(renderer: TQ3RendererObject; VAR bypass: TQ3Boolean): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_SetRAVEContextHints(renderer: TQ3RendererObject; RAVEContextHints: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetRAVEContextHints(renderer: TQ3RendererObject; VAR RAVEContextHints: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_SetRAVETextureFilter(renderer: TQ3RendererObject; RAVEtextureFilterValue: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetRAVETextureFilter(renderer: TQ3RendererObject; VAR RAVEtextureFilterValue: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Renderer View Tools								 **
 **																			 **
 **					You may only call these methods from a plug-in			 **
 **																			 **
 ****************************************************************************}
{
 *	Call by a renderer to call the user "idle" method, with progress 
 *	information.
 *	
 *	Pass in (view, 0, n) on first call
 *	Pass in (view, 1..n-1, n) during rendering
 *	Pass in (view, n, n) upon completion
 *	
 *	Note: The user must have supplied an idleProgress method with 
 *	Q3XView_SetIdleProgressMethod. Otherwise, the generic idle method is
 *	called with no progress data. e.g. the Q3View_SetIdleMethod method
 *	is called instead. (current and final are ignored, essentially.)
 *
 *	Returns kQ3Failure if rendering is cancelled.
 }
FUNCTION Q3XView_IdleProgress(view: TQ3ViewObject; current: LONGINT; completed: LONGINT): TQ3Status; C;
{
 *	Called by an asynchronous renderer when it completes a frame.
 }
FUNCTION Q3XView_EndFrame(view: TQ3ViewObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Renderer AttributeSet Tools						 **
 **																			 **
 **					You may only call these methods from a plug-in			 **
 **																			 **
 ****************************************************************************}
{
 *	Faster access to geometry attribute sets.
 *	
 *	Returns pointer to INTERNAL data structure for elements and attributes
 *	in an attributeSet, or NULL if no attribute exists.
 *	
 *	For attributes of type kQ3AttributeType..., the internal data structure
 *	is identical to the data structure used in Q3AttributeSet_Add.
 }
FUNCTION Q3XAttributeSet_GetPointer(attributeSet: TQ3AttributeSet; attributeType: TQ3AttributeType): Ptr; C;


CONST
	kQ3XAttributeMaskNone		= 0;
	kQ3XAttributeMaskSurfaceUV	= $01;
	kQ3XAttributeMaskShadingUV	= $02;
	kQ3XAttributeMaskNormal		= $04;
	kQ3XAttributeMaskAmbientCoefficient = $08;
	kQ3XAttributeMaskDiffuseColor = $10;
	kQ3XAttributeMaskSpecularColor = $20;
	kQ3XAttributeMaskSpecularControl = $40;
	kQ3XAttributeMaskTransparencyColor = $80;
	kQ3XAttributeMaskSurfaceTangent = $0100;
	kQ3XAttributeMaskHighlightState = $0200;
	kQ3XAttributeMaskSurfaceShader = $0400;
	kQ3XAttributeMaskCustomAttribute = $80000000;
	kQ3XAttributeMaskAll		= $800007FF;
	kQ3XAttributeMaskInherited	= $03FF;
	kQ3XAttributeMaskInterpolated = $01FF;


TYPE
	TQ3XAttributeMask					= LONGINT;
FUNCTION Q3XAttributeSet_GetMask(attributeSet: TQ3AttributeSet): TQ3XAttributeMask; C;

{*****************************************************************************
 **																			 **
 **							Renderer Draw Context Tools						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3XDrawRegion = ^LONGINT;
FUNCTION Q3XDrawContext_GetDrawRegion(drawContext: TQ3DrawContextObject; VAR drawRegion: TQ3XDrawRegion): TQ3Status; C;

TYPE
	TQ3XDrawContextValidationMasks  = LONGINT;
CONST
	kQ3XDrawContextValidationClearFlags = {TQ3XDrawContextValidationMasks}$00000000;
	kQ3XDrawContextValidationDoubleBuffer = {TQ3XDrawContextValidationMasks}$01;
	kQ3XDrawContextValidationShader = {TQ3XDrawContextValidationMasks}$02;
	kQ3XDrawContextValidationClearFunction = {TQ3XDrawContextValidationMasks}$04;
	kQ3XDrawContextValidationActiveBuffer = {TQ3XDrawContextValidationMasks}$08;
	kQ3XDrawContextValidationInternalOffScreen = {TQ3XDrawContextValidationMasks}$10;
	kQ3XDrawContextValidationPane = {TQ3XDrawContextValidationMasks}$20;
	kQ3XDrawContextValidationMask = {TQ3XDrawContextValidationMasks}$40;
	kQ3XDrawContextValidationDevice = {TQ3XDrawContextValidationMasks}$80;
	kQ3XDrawContextValidationWindow = {TQ3XDrawContextValidationMasks}$0100;
	kQ3XDrawContextValidationWindowSize = {TQ3XDrawContextValidationMasks}$0200;
	kQ3XDrawContextValidationWindowClip = {TQ3XDrawContextValidationMasks}$0400;
	kQ3XDrawContextValidationWindowPosition = {TQ3XDrawContextValidationMasks}$0800;
	kQ3XDrawContextValidationPlatformAttributes = {TQ3XDrawContextValidationMasks}$1000;
	kQ3XDrawContextValidationForegroundShader = {TQ3XDrawContextValidationMasks}$2000;
	kQ3XDrawContextValidationBackgroundShader = {TQ3XDrawContextValidationMasks}$4000;
	kQ3XDrawContextValidationColorPalette = {TQ3XDrawContextValidationMasks}$8000;
	kQ3XDrawContextValidationAll = {TQ3XDrawContextValidationMasks}$FFFFFFFF;


TYPE
	TQ3XDrawContextValidation			= LONGINT;
FUNCTION Q3XDrawContext_ClearValidationFlags(drawContext: TQ3DrawContextObject): TQ3Status; C;
FUNCTION Q3XDrawContext_GetValidationFlags(drawContext: TQ3DrawContextObject; VAR validationFlags: TQ3XDrawContextValidation): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Renderer Draw Region Tools						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3XDevicePixelType 		= LONGINT;
CONST
																{  These do not indicate byte ordering    }
	kQ3XDevicePixelTypeInvalid	= {TQ3XDevicePixelType}0;		{  Unknown, un-initialized type	  }
	kQ3XDevicePixelTypeRGB32	= {TQ3XDevicePixelType}1;		{  Alpha:8 (ignored), R:8, G:8, B:8  }
	kQ3XDevicePixelTypeARGB32	= {TQ3XDevicePixelType}2;		{  Alpha:8, R:8, G:8, B:8 			  }
	kQ3XDevicePixelTypeRGB24	= {TQ3XDevicePixelType}3;		{  24 bits/pixel, R:8, G:8, B:8	  }
	kQ3XDevicePixelTypeRGB16	= {TQ3XDevicePixelType}4;		{  Alpha:1 (ignored), R:5, G:5, B:5  }
	kQ3XDevicePixelTypeARGB16	= {TQ3XDevicePixelType}5;		{  Alpha:1, R:5, G:5, B:5 			  }
	kQ3XDevicePixelTypeRGB16_565 = {TQ3XDevicePixelType}6;		{  16 bits/pixel, R:5, G:6, B:5	  }
	kQ3XDevicePixelTypeIndexed8	= {TQ3XDevicePixelType}7;		{  8-bit color table index			  }
	kQ3XDevicePixelTypeIndexed4	= {TQ3XDevicePixelType}8;		{  4-bit color table index			  }
	kQ3XDevicePixelTypeIndexed2	= {TQ3XDevicePixelType}9;		{  2-bit color table index			  }
	kQ3XDevicePixelTypeIndexed1	= {TQ3XDevicePixelType}10;		{  1-bit color table index			  }


TYPE
	TQ3XClipMaskState 			= LONGINT;
CONST
	kQ3XClipMaskFullyExposed	= {TQ3XClipMaskState}0;
	kQ3XClipMaskPartiallyExposed = {TQ3XClipMaskState}1;
	kQ3XClipMaskNotExposed		= {TQ3XClipMaskState}2;


TYPE
	TQ3XColorDescriptorPtr = ^TQ3XColorDescriptor;
	TQ3XColorDescriptor = RECORD
		redShift:				LONGINT;
		redMask:				LONGINT;
		greenShift:				LONGINT;
		greenMask:				LONGINT;
		blueShift:				LONGINT;
		blueMask:				LONGINT;
		alphaShift:				LONGINT;
		alphaMask:				LONGINT;
	END;

	TQ3XDrawRegionDescriptorPtr = ^TQ3XDrawRegionDescriptor;
	TQ3XDrawRegionDescriptor = RECORD
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		pixelSize:				LONGINT;
		pixelType:				TQ3XDevicePixelType;
		colorDescriptor:		TQ3XColorDescriptor;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
		clipMask:				TQ3BitmapPtr;
	END;

	TQ3XDrawRegionServicesMasks  = LONGINT;
CONST
	kQ3XDrawRegionServicesNoneFlag = {TQ3XDrawRegionServicesMasks}0;
	kQ3XDrawRegionServicesClearFlag = {TQ3XDrawRegionServicesMasks}$01;
	kQ3XDrawRegionServicesDontLockDDSurfaceFlag = {TQ3XDrawRegionServicesMasks}$02;


TYPE
	TQ3XDrawRegionServices				= LONGINT;
	TQ3XDrawRegionRendererPrivateDeleteMethod = ProcPtr;  { PROCEDURE TQ3XDrawRegionRendererPrivateDeleteMethod(rendererPrivate: UNIV Ptr); C; }

FUNCTION Q3XDrawRegion_GetDeviceScaleX(drawRegion: TQ3XDrawRegion; VAR deviceScaleX: Single): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetDeviceScaleY(drawRegion: TQ3XDrawRegion; VAR deviceScaleY: Single): TQ3Status; C;

FUNCTION Q3XDrawRegion_GetDeviceOffsetX(drawRegion: TQ3XDrawRegion; VAR deviceOffsetX: Single): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetDeviceOffsetY(drawRegion: TQ3XDrawRegion; VAR deviceOffsetX: Single): TQ3Status; C;

FUNCTION Q3XDrawRegion_GetWindowScaleX(drawRegion: TQ3XDrawRegion; VAR windowScaleX: Single): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetWindowScaleY(drawRegion: TQ3XDrawRegion; VAR windowScaleY: Single): TQ3Status; C;

FUNCTION Q3XDrawRegion_GetWindowOffsetX(drawRegion: TQ3XDrawRegion; VAR windowOffsetX: Single): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetWindowOffsetY(drawRegion: TQ3XDrawRegion; VAR windowOffsetY: Single): TQ3Status; C;
FUNCTION Q3XDrawRegion_IsActive(drawRegion: TQ3XDrawRegion; VAR isActive: TQ3Boolean): TQ3Status; C;

FUNCTION Q3XDrawRegion_GetNextRegion(drawRegion: TQ3XDrawRegion; VAR nextDrawRegion: TQ3XDrawRegion): TQ3Status; C;
{ 
 *  One of the next two functions must be called before using a draw region 
 }
{
 *	Use this Start function if double buffering/image access services from the
 *	Draw Context are not needed, you may still request clear for example
 }
FUNCTION Q3XDrawRegion_Start(drawRegion: TQ3XDrawRegion; services: TQ3XDrawRegionServices; VAR descriptor: TQ3XDrawRegionDescriptorPtr): TQ3Status; C;
{
 *	Use this Start function if double buffering or image access services from 
 *  the Draw Context are needed.
 }
FUNCTION Q3XDrawRegion_StartAccessToImageBuffer(drawRegion: TQ3XDrawRegion; services: TQ3XDrawRegionServices; VAR descriptor: TQ3XDrawRegionDescriptorPtr; VAR image: UNIV Ptr): TQ3Status; C;
{
 *	This function is used to indicate that access to a DrawRegion is ended.
 }
FUNCTION Q3XDrawRegion_End(drawRegion: TQ3XDrawRegion): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetDeviceTransform(drawRegion: TQ3XDrawRegion; VAR deviceTransform: TQ3Matrix4x4Ptr): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetClipFlags(drawRegion: TQ3XDrawRegion; VAR clipMaskState: TQ3XClipMaskState): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetClipMask(drawRegion: TQ3XDrawRegion; VAR clipMask: TQ3BitmapPtr): TQ3Status; C;
{$IFC TARGET_OS_MAC }
FUNCTION Q3XDrawRegion_GetClipRegion(drawRegion: TQ3XDrawRegion; VAR rgnHandle: RgnHandle): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetGDHandle(drawRegion: TQ3XDrawRegion; VAR gdHandle: GDHandle): TQ3Status; C;
{$ENDC}  {TARGET_OS_MAC}

FUNCTION Q3XDrawRegion_GetRendererPrivate(drawRegion: TQ3XDrawRegion; VAR rendererPrivate: UNIV Ptr): TQ3Status; C;
FUNCTION Q3XDrawRegion_SetRendererPrivate(drawRegion: TQ3XDrawRegion; rendererPrivate: UNIV Ptr; deleteMethod: TQ3XDrawRegionRendererPrivateDeleteMethod): TQ3Status; C;
FUNCTION Q3XDrawRegion_SetUseDefaultRendererFlag(drawRegion: TQ3XDrawRegion; flag: TQ3Boolean): TQ3Status; C;
FUNCTION Q3XDrawRegion_GetUseDefaultRendererFlag(drawRegion: TQ3XDrawRegion; VAR useDefaultRenderingFlag: TQ3Boolean): TQ3Status; C;


{*****************************************************************************
 **																			 **
 **							Renderer Class Methods							 **
 **																			 **
 ****************************************************************************}
{
 *	Methods from Object
 *		kQ3XMethodTypeObjectClassRegister
 *		kQ3XMethodTypeObjectClassUnregister
 *		kQ3XMethodTypeObjectNew
 *		kQ3XMethodTypeObjectDelete
 *		kQ3XMethodTypeObjectRead
 *		kQ3XMethodTypeObjectTraverse
 *		kQ3XMethodTypeObjectWrite
 *		
 *	Methods from Shared
 *		kQ3MethodTypeSharedEdited
 *
 *	Renderer Methods
 *	
 *	The renderer methods should be implemented according to the type
 *	of renderer being written.
 *
 *	For the purposes of documentation, there are two basic types of
 *	renderers: 
 *
 *		Interactive
 *			Interactive Renderer
 *			WireFrame Renderer
 *		
 *		Deferred
 *			a ray-tracer
 *			painter's algorithm renderer (cached in a BSP triangle tree)
 *			an artistic renderer (simulates a pencil drawing, etc.)
 *
 *	The main difference is how each renderer handles incoming state and 
 *	geometry.
 *
 *	An interactive renderer immediately transforms, culls, and shades
 *	incoming geometry and performs rasterization. For example, in a 
 *	single-buffered WireFrame renderer, you will see a new triangle
 *	immediately after Q3Triangle_Draw (if it's visible, of course).
 *
 *	A deferred renderer caches the view state and each geometry, 
 *	converting into any internal queue of drawing commands. Rasterization
 *	is not actually performed until all data has been submitted.
 *	
 *	For example, a ray-tracer may not rasterize anything until the
 *	end of the rendering loop, or until an EndFrame call is made.
 }

{*****************************************************************************
 **																			 **
 **						Renderer User Interface Methods						 **
 **																			 **
 ****************************************************************************}
{
 *	kQ3XMethodTypeRendererIsInteractive
 *	
 *	There is no actual method with this - the metahandler simply returns
 *  "(TQ3XFunctionPointer)kQ3True" for this "method" if the renderer is 
 *  intended to be used in interactive settings, and   
 *	"(TQ3XFunctionPointer)kQ3False" otherwise. 
 *  
 *  If neither value is specified in the metahandler, the renderer 
 *  is *assumed to be non-interactive*!!!
 *	
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererIsInteractive = 'isin';


{
 *	TQ3XRendererModalConfigureMethod
 *	
 *	This method should pop up a modal dialog to edit the renderer settings 
 *	found in the renderer private. 
 *	
 *	dialogAnchor - is platform specific data passed by the client to support
 *      movable modal dialogs. 
 *    MacOS: this is a callback to the calling application's event handler.
 *      The renderer calls this function with events not handled by the 
 *      settings dialog. This is necessary in order to support movable modal 
 *      dialogs. An application's event handler must return kQ3True if it 
 *      handles the event passed to the callback or kQ3False if not. 
 *      An application which doesn't want to support a movable modal configure
 *      dialog should pass NULL for the clientEventHandler of TQ3DialogAnchor.
 *      A renderer should implement a non-movable style dialog in that case.
 *    Win32: this is the HWND of the owning window (typically an application's
 *      main window).  (Win32 application modal dialogs are always movable.)
 *  canceled - returns a boolean inditacating that the user canceled the 
 *	dialog.
 *	
 *	OPTIONAL
 }
	kQ3XMethodTypeRendererModalConfigure = 'rdmc';


TYPE
	TQ3XRendererModalConfigureMethod = ProcPtr;  { FUNCTION TQ3XRendererModalConfigureMethod(renderer: TQ3RendererObject; dialogAnchor: TQ3DialogAnchor; VAR canceled: TQ3Boolean; rendererPrivate: UNIV Ptr): TQ3Status; C; }

{
 *	kQ3XMethodTypeRendererGetNickNameString
 *	
 *		Allows an application to collect the name of the renderer for
 *		display in a user interface item such as a menu.
 *	
 *		If dataBuffer is NULL actualDataSize returns the required size in 
 *		bytes of a data buffer large enough to store the renderer name. 
 *
 *      bufferSize is the actual size of the memory block pointed to by 
 *		dataBuffer
 *
 *		actualDataSize - on return the actual number of bytes written to the
 *		buffer or if dataBuffer is NULL the required size of dataBuffer
 *
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererGetNickNameString = 'rdns';


TYPE
	TQ3XRendererGetNickNameStringMethod = ProcPtr;  { FUNCTION TQ3XRendererGetNickNameStringMethod(VAR dataBuffer: UInt8; bufferSize: LONGINT; VAR actualDataSize: LONGINT): TQ3Status; C; }

{
 *	kQ3XMethodTypeRendererGetConfigurationData
 *	
 *		Allows an application to collect private configuration data from the
 *      renderer which it will then save. For example in a preference file, 
 *      a registry key (on Windows) or in a style template. An application 
 *      should tag this data with the renderer's object name.
 *	
 *		If dataBuffer is NULL actualDataSize returns the required size in 
 *		bytes of a data buffer large enough to store private data. 
 *
 *      bufferSize is the actual size of the memory block pointed to by 
 *		dataBuffer
 *
 *		actualDataSize - on return the actual number of bytes written to the
 *		buffer or if dataBuffer is NULL the required size of dataBuffer
 *
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererGetConfigurationData = 'rdgp';


TYPE
	TQ3XRendererGetConfigurationDataMethod = ProcPtr;  { FUNCTION TQ3XRendererGetConfigurationDataMethod(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: LONGINT; VAR actualDataSize: LONGINT; rendererPrivate: UNIV Ptr): TQ3Status; C; }

{
 *	TQ3XRendererSetConfigurationDataMethod
 *	
 *		Allows an application to pass private configuration data which has
 * 		previously  been obtained from a renderer via 
 *		Q3Renderer_GetConfigurationData. For example in a preference file or 
 *		in a style template. An application should tag this data with the 
 *		renderer's object name.
 *	
 *      bufferSize is the actual size of the memory block pointed to by 
 *		dataBuffer
 *
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererSetConfigurationData = 'rdsp';


TYPE
	TQ3XRendererSetConfigurationDataMethod = ProcPtr;  { FUNCTION TQ3XRendererSetConfigurationDataMethod(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: LONGINT; rendererPrivate: UNIV Ptr): TQ3Status; C; }

{*****************************************************************************
 **																			 **
 **						Renderer Drawing State Methods						 **
 **																			 **
 ****************************************************************************}
{
 *	TQ3RendererStartFrame
 *	
 *	The StartFrame method is called first at Q3View_StartRendering
 *	and should:
 *		- initialize any renderer state to defaults
 *		- extract any and all useful data from the drawContext
 *
 *	If your renderer passed in kQ3RendererFlagClearBuffer at 
 *	registration, then it should also:
 *		- clear the drawContext 
 *	
 *		When clearing, your renderer may opt to:
 *		- NOT clear anything (if you touch every pixel, for example)
 *		- to clear with your own routine, or
 *		- to use the draw context default clear method by calling 
 *		Q3DrawContext_Clear. Q3DrawContext_Clear takes advantage of
 *		any available hardware in the system for clearing.
 *	
 *	This call also signals the start of all default submit commands from
 *	the view. The renderer will receive updates for the default view
 *	state via its Update methods before StartPass is called.
 *	
 *	REQUIRED
 }

CONST
	kQ3XMethodTypeRendererStartFrame = 'rdcl';


TYPE
	TQ3XRendererStartFrameMethod = ProcPtr;  { FUNCTION TQ3XRendererStartFrameMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; drawContext: TQ3DrawContextObject): TQ3Status; C; }

{
 *	kQ3XMethodTypeRendererStartPass
 *	TQ3XRendererStartPassMethod
 *	
 *	The StartPass method is called during Q3View_StartRendering but after
 *	the StartFrame command. It should:
 *		- collect camera and light information
 *	
 *	If your renderer supports deferred camera transformation, camera is the
 *	main camera which will be submitted in the hierarchy somewhere. It
 *	is never NULL.
 *
 *	If your renderer does not support deferred camera transformation, camera
 *	is the transformed camera.
 *
 *	If your renderer supports deferred light transformation, lights will be
 *	NULL, and will be submitted to your light draw methods instead.
 *
 *	This call signals the end of the default update state, and the start of 
 *  submit commands from the user to the view.
 *
 *	REQUIRED
 }

CONST
	kQ3XMethodTypeRendererStartPass = 'rdst';


TYPE
	TQ3XRendererStartPassMethod = ProcPtr;  { FUNCTION TQ3XRendererStartPassMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; camera: TQ3CameraObject; lightGroup: TQ3GroupObject): TQ3Status; C; }

{
 *	kQ3XMethodTypeRendererFlushFrame
 *	TQ3XRendererFlushFrameMethod
 *	
 *	This call is only implemented by asynchronous renderers.
 *	
 *	The FlushFrame method is called between the StartPass and EndPass
 *	methods and is called when the user wishes to flush any asynchronous
 *	drawing tasks (which draw to the drawcontext), but does not want 
 *	to block.
 *	
 *	The result of this call is that an image should "eventually" appear
 *	asynchronously.
 *	
 *	For asynchronous rendering, this call is non-blocking.
 *	
 *	An interactive renderer should ensure that all received
 *	geometries are drawn in the image.
 *	
 *	An interactive renderer that talks to hardware should force
 *	the hardware to generate an image.
 *	
 *	A deferred renderer should exhibit a similar behaviour,
 *	though it is not required.  A deferred renderer should spawn
 *	a process that generates a partial image from the currently
 *	accumulated drawing state. 
 *	
 *	However, for renderers such as ray-tracers which generally are
 *	quite compute-intensive, FlushFrame is not required and is a no-op.
 *
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererFlushFrame = 'rdfl';


TYPE
	TQ3XRendererFlushFrameMethod = ProcPtr;  { FUNCTION TQ3XRendererFlushFrameMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; drawContext: TQ3DrawContextObject): TQ3Status; C; }

{
 *	kQ3XMethodTypeRendererEndPass
 *	TQ3XRendererEndPassMethod
 *	
 *	The EndPass method is called at Q3View_EndRendering and signals
 *	the end of submit commands to the view.
 *
 *	If an error occurs, the renderer should call Q3XError_Post and
 *	return kQ3ViewStatusError.
 *	
 *	If a renderer requires another pass on the renderering data,
 *	it should return kQ3ViewStatusRetraverse.
 *	
 *	If rendering was cancelled, this function will not be called
 *	and the view will handle returning kQ3ViewStatusCancelled;
 *	
 *	Otherwise, your renderer should begin completing the process of 
 *	generating the image in the drawcontext. If you have buffered
 *	any drawing data, flush it. RendererEnd should have a similar
 *	effect as RendererFlushFrame.
 *	
 *	If the renderer is synchronous:
 *		- complete rendering of the entire frame
 *		if the renderer supports kQ3RendererClassSupportDoubleBuffer
 *			- Update the front buffer
 *		else
 *			- DrawContext will update the front buffer after returning
 *
 *	If the renderer is asynchronous
 *		- spawn rendering thread for entire frame
 *		if the renderer supports kQ3RendererClassSupportDoubleBuffer,
 *			- you must eventually update the front buffer asynchronously
 *		else
 *			- you must eventually update the back buffer asynchronously
 *			
 *	REQUIRED
 }

CONST
	kQ3XMethodTypeRendererEndPass = 'rded';


TYPE
	TQ3XRendererEndPassMethod = ProcPtr;  { FUNCTION TQ3XRendererEndPassMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr): TQ3ViewStatus; C; }

{
 *	kQ3XMethodTypeRendererEndFrame
 *	TQ3XRendererEndFrame
 *	
 *	This call is only implemented by asynchronous renderers.
 *
 *	The EndFrame method is called from Q3View_Sync, which is
 *	called after Q3View_EndRendering and signals that the user
 *	wishes to see the completed image and is willing to block.
 *	
 *	If your renderer supports kQ3RendererFlagDoubleBuffer
 *		- update the front buffer completely 
 *	else
 *		- update the back buffer completely
 *
 *	This call is equivalent in functionality to RendererFlushFrame
 *	but blocks until the image is completed.
 *	
 *	If no method is supplied, the default is a no-op.
 *	
 *	NOTE: Registering a method of this type indicates that your renderer will
 *	be rendering after Q3View_EndRendering has been called.
 *	
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererEndFrame = 'rdsy';


TYPE
	TQ3XRendererEndFrameMethod = ProcPtr;  { FUNCTION TQ3XRendererEndFrameMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; drawContext: TQ3DrawContextObject): TQ3Status; C; }

{
 *	The RendererCancel method is called after Q3View_StartRendering
 *	and signals the termination of all rendering operations.
 *
 *	A renderer should clean up any cached data, and cancel all 
 *	rendering operations.
 *	
 *	If called before Q3View_EndRendering, the RendererEnd method
 *	is NOT called.
 *	
 *	If called after Q3View_EndRendering, the renderer should kill
 *	any threads and terminate any further rendering.
 *	
 *	REQUIRED
 }

CONST
	kQ3XMethodTypeRendererCancel = 'rdab';


TYPE
	TQ3XRendererCancelMethod = ProcPtr;  { PROCEDURE TQ3XRendererCancelMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr); C; }

{*****************************************************************************
 **																			 **
 **						Renderer DrawContext Methods						 **
 **																			 **
 ****************************************************************************}
{
 *	kQ3XMethodTypeRendererPush
 *	TQ3XRendererPushMethod
 *	
 *	kQ3XMethodTypeRendererPop
 *	TQ3XRendererPopMethod
 *	
 *	These methods are called whenever the graphics state in the view
 *	is pushed or popped. The user may isolate state by calling:
 *	
 *	Q3Attribute_Submit(kQ3AttributeTypeDiffuseColor, &red, view);
 *	Q3Attribute_Submit(kQ3AttributeTypeTransparencyColor, &blue, view);
 *	Q3Attribute_Submit(kQ3AttributeTypeSpecularColor, &white, view);
 *	Q3Box_Submit(&unitBox, view);
 *	Q3TranslateTransform_Submit(&unitVector, view);
 *	Q3Push_Submit(view);
 *		Q3Attribute_Submit(kQ3AttributeTypeDiffuseColor, &blue, view);
 *		Q3Attribute_Submit(kQ3AttributeTypeTransparencyColor, &green, view);
 *		Q3Box_Submit(&unitBox, view);
 *	Q3Pop_Submit(view);	
 *	Q3TranslateTransform_Submit(&unitVector, view);
 *	Q3Box_Submit(&unitBox, view);
 *	
 *	or by submitting a display group which pushes and pops.
 *	
 *	If you support RendererPush and RendererPop in your renderer:
 *		- you must maintain your drawing state as a stack, as well.
 *		- you will not be updated with the popped state after
 *			RendererPop is called.
 *
 *	If you do not support Push and Pop in your renderer:
 *		- you may maintain a single copy of the drawing state.
 *		- you will be updated with changed fields after the view stack is
 *			popped.
 *
 *	A renderer that supports Push and Pop gets called in the following
 *	sequence (from example above):
 *	
 *	RendererUpdateAttributeDiffuseColor(&red,...)
 *	RendererUpdateAttributeTransparencyColor(&blue,...)
 *	RendererUpdateAttributeSpecularColor(&white,...)
 *	RendererUpdateMatrixLocalToWorld(...)
 *	RendererSubmitGeometryBox(...)
 *	RendererPush(...)
 *		RendererUpdateAttributeDiffuseColor(&blue,...)
 *		RendererUpdateAttributeTransparencyColor(&green,...)
 *		RendererSubmitGeometryBox(...)
 *	RendererPop(...)
 *	RendererUpdateMatrixLocalToWorld(...)
 *	RendererSubmitGeometryBox(...)
 *
 *	A renderer that does not supports Push and Pop gets called in the
 *	following sequence:
 *	
 *	RendererUpdateAttributeDiffuseColor(&red,...)
 *	RendererUpdateAttributeTransparencyColor(&blue,...)
 *	RendererUpdateAttributeSpecularColor(&white,...)
 *	RendererUpdateMatrixLocalToWorld(...)
 *	RendererSubmitGeometryBox(...)
 *		RendererUpdateAttributeDiffuseColor(&blue,...)
 *		RendererUpdateAttributeTransparencyColor(&green,...)
 *		RendererSubmitGeometryBox(...)
 *	RendererUpdateAttributeDiffuseColor(&red,...)
 *	RendererUpdateAttributeTransparencyColor(&blue,...)
 *	RendererUpdateMatrixLocalToWorld(...)
 *	RendererSubmitGeometryBox(...)
 *	
 }

CONST
	kQ3XMethodTypeRendererPush	= 'rdps';


TYPE
	TQ3XRendererPushMethod = ProcPtr;  { FUNCTION TQ3XRendererPushMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr): TQ3Status; C; }


CONST
	kQ3XMethodTypeRendererPop	= 'rdpo';


TYPE
	TQ3XRendererPopMethod = ProcPtr;  { FUNCTION TQ3XRendererPopMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr): TQ3Status; C; }

{*****************************************************************************
 **																			 **
 **							Renderer Cull Methods							 **
 **																			 **
 ****************************************************************************}
{
 *	kQ3XMethodTypeRendererIsBoundingBoxVisible
 *	TQ3XRendererIsBoundingBoxVisibleMethod
 *	
 *	This method is called to cull complex groups and geometries 
 *	given their bounding box in local space.
 *	
 *	It should transform the local-space bounding box coordinates to
 *	frustum space and return a TQ3Boolean return value indicating
 *	whether the box appears within the viewing frustum.
 *	
 *	If no method is supplied, the default behavior is to return
 *	kQ3True.
 *	
 }

CONST
	kQ3XMethodTypeRendererIsBoundingBoxVisible = 'rdbx';


TYPE
	TQ3XRendererIsBoundingBoxVisibleMethod = ProcPtr;  { FUNCTION TQ3XRendererIsBoundingBoxVisibleMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; (CONST)VAR bBox: TQ3BoundingBox): TQ3Boolean; C; }


{*****************************************************************************
 **																			 **
 **						Renderer Object Support Methods						 **
 **																			 **
 ****************************************************************************}
{
 *	Drawing methods (Geometry, Camera, Lights)
 *
 }
{
 *	Geometry MetaHandler
 *	
 *	This metaHandler is required to support 
 *	
 *	kQ3GeometryTypeTriangle
 *	kQ3GeometryTypeLine
 *	kQ3GeometryTypePoint
 *	kQ3GeometryTypeMarker
 *	kQ3GeometryTypePixmapMarker
 *	
 *	REQUIRED
 }

CONST
	kQ3XMethodTypeRendererSubmitGeometryMetaHandler = 'rdgm';


TYPE
	TQ3XRendererSubmitGeometryMetaHandlerMethod = ProcPtr;  { FUNCTION TQ3XRendererSubmitGeometryMetaHandlerMethod(geometryType: TQ3ObjectType): TQ3XFunctionPointer; C; }

{
 *	The TQ3XRendererSubmitGeometryMetaHandlerMethod switches on geometryType
 *	of kQ3GeometryTypeFoo and returns methods of type:
 }
	TQ3XRendererSubmitGeometryMethod = ProcPtr;  { FUNCTION TQ3XRendererSubmitGeometryMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; geometry: TQ3GeometryObject; publicData: UNIV Ptr): TQ3Status; C; }

{
 *	Camera MetaHandler
 *	
 *	This metaHandler, if supplied, indicates that your renderer
 *	handles deferred transformation of the main camera within a scene.
 *	
 *	If not supplied, or an unsupported camera is used, the view will do
 *	the transformation for the renderer and pass in a camera in the 
 *	StartPass method.
 *	
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererSubmitCameraMetaHandler = 'rdcm';


TYPE
	TQ3XRendererSubmitCameraMetaHandlerMethod = ProcPtr;  { FUNCTION TQ3XRendererSubmitCameraMetaHandlerMethod(cameraType: TQ3ObjectType): TQ3XFunctionPointer; C; }

{
 *	The TQ3XRendererSubmitCameraMetaHandlerMethod switches on cameraType
 *	of kQ3CameraTypeFoo and returns methods of type:
 }
	TQ3XRendererSubmitCameraMethod = ProcPtr;  { FUNCTION TQ3XRendererSubmitCameraMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; camera: TQ3CameraObject; publicData: UNIV Ptr): TQ3Status; C; }

{
 *	Light MetaHandler
 *	
 *	This metaHandler, if supplied, indicates that your renderer
 *	handles deferred transformation of lights within a scene.
 *	
 *	If an unsupported light is encountered, it is ignored.
 *
 *	OPTIONAL
 }

CONST
	kQ3XMethodTypeRendererSubmitLightMetaHandler = 'rdlg';


TYPE
	TQ3XRendererSubmitLightMetaHandlerMethod = ProcPtr;  { FUNCTION TQ3XRendererSubmitLightMetaHandlerMethod(lightType: TQ3ObjectType): TQ3XFunctionPointer; C; }

{
 *	The TQ3XRendererSubmitLightMetaHandlerMethod switches on lightType
 *	of kQ3LightTypeFoo and returns methods of type:
 }
	TQ3XRendererSubmitLightMethod = ProcPtr;  { FUNCTION TQ3XRendererSubmitLightMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; light: TQ3LightObject; publicData: UNIV Ptr): TQ3Status; C; }

{
 *
 *	Update methods
 *
 *	They are called whenever the state has changed. If the renderer supports
 *	the RendererPush and RendererPop methods, it must maintain its own state
 *	stack. Updates are not called for changed data when the view stack is
 *	popped.
 *
 *	See the comments for the RendererPush and RendererPop methods above
 *	for an example of how data is updated.
 *
 }
{
 *	Style
 }

CONST
	kQ3XMethodTypeRendererUpdateStyleMetaHandler = 'rdyu';


TYPE
	TQ3XRendererUpdateStyleMetaHandlerMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateStyleMetaHandlerMethod(styleType: TQ3ObjectType): TQ3XFunctionPointer; C; }

{
 *	The TQ3XRendererUpdateStyleMetaHandlerMethod switches on styleType
 *	of kQ3StyleTypeFoo and returns methods of type:
 }
	TQ3XRendererUpdateStyleMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateStyleMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; publicData: UNIV Ptr): TQ3Status; C; }

{
 *	Attributes
 }

CONST
	kQ3XMethodTypeRendererUpdateAttributeMetaHandler = 'rdau';


TYPE
	TQ3XRendererUpdateAttributeMetaHandlerMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateAttributeMetaHandlerMethod(attributeType: TQ3AttributeType): TQ3XFunctionPointer; C; }

{
 *	The TQ3XRendererUpdateStyleMetaHandlerMethod switches on attributeType
 *	of kQ3AttributeTypeFoo and returns methods of type:
 }
	TQ3XRendererUpdateAttributeMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateAttributeMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; publicData: UNIV Ptr): TQ3Status; C; }

{
 *	Shaders
 }

CONST
	kQ3XMethodTypeRendererUpdateShaderMetaHandler = 'rdsu';


TYPE
	TQ3XRendererUpdateShaderMetaHandlerMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateShaderMetaHandlerMethod(shaderType: TQ3ObjectType): TQ3XFunctionPointer; C; }

{
 *	The TQ3XRendererUpdateShaderMetaHandlerMethod switches on shaderType
 *	of kQ3ShaderTypeFoo and returns methods of type:
 }
	TQ3XRendererUpdateShaderMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateShaderMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; shaderObject: TQ3Object): TQ3Status; C; }

{
 *	Matrices
 }

CONST
	kQ3XMethodTypeRendererUpdateMatrixMetaHandler = 'rdxu';


TYPE
	TQ3XRendererUpdateMatrixMetaHandlerMethod = TQ3XMetaHandler;
{
 *	The TQ3XRendererUpdateShaderMetaHandlerMethod switches on methods
 *	of the form kQ3MethodTypeRendererUpdateMatrixFoo:
 }

CONST
	kQ3XMethodTypeRendererUpdateMatrixLocalToWorld = 'ulwx';

	kQ3XMethodTypeRendererUpdateMatrixLocalToWorldInverse = 'ulwi';

	kQ3XMethodTypeRendererUpdateMatrixLocalToWorldInverseTranspose = 'ulwt';

	kQ3XMethodTypeRendererUpdateMatrixLocalToCamera = 'ulcx';

	kQ3XMethodTypeRendererUpdateMatrixLocalToFrustum = 'ulfx';

	kQ3XMethodTypeRendererUpdateMatrixWorldToFrustum = 'uwfx';

{
 *	and returns methods of type:
 }

TYPE
	TQ3XRendererUpdateMatrixMethod = ProcPtr;  { FUNCTION TQ3XRendererUpdateMatrixMethod(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; (CONST)VAR matrix: TQ3Matrix4x4): TQ3Status; C; }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DRendererIncludes}

{$ENDC} {__QD3DRENDERER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}