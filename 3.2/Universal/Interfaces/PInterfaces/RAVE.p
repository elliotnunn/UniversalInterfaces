{
 	File:		RAVE.p
 
 	Contains:	Interface for RAVE (Renderer Acceleration Virtual Engine)							
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT RAVE;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RAVE__}
{$SETC __RAVE__ := 1}

{$I+}
{$SETC RAVEIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}

{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_WIN32 }
{$IFC UNDEFINED RAVE_NO_DIRECTDRAW }
{$ENDC}
{$ENDC}  {TARGET_OS_WIN32}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 *
 * Platform dependent datatypes: TQAImagePixelType, TQADevice, TQAClip, and TQARect.
 *
 ****************************************************************************}

TYPE
	TQAImagePixelType 			= LONGINT;
CONST
	kQAPixel_Alpha1				= {TQAImagePixelType}0;			{  1 bit/pixel alpha  }
	kQAPixel_RGB16				= {TQAImagePixelType}1;			{  16 bit/pixel, R=14:10, G=9:5, B=4:0  }
	kQAPixel_ARGB16				= {TQAImagePixelType}2;			{  16 bit/pixel, A=15, R=14:10, G=9:5, B=4:0  }
	kQAPixel_RGB32				= {TQAImagePixelType}3;			{  32 bit/pixel, R=23:16, G=15:8, B=7:0  }
	kQAPixel_ARGB32				= {TQAImagePixelType}4;			{  32 bit/pixel, A=31:24, R=23:16, G=15:8, B=7:0  }
	kQAPixel_CL4				= {TQAImagePixelType}5;			{  4 bit color look up table, always big endian, ie high 4 bits effect left pixel  }
	kQAPixel_CL8				= {TQAImagePixelType}6;			{  8 bit color look up table  }
	kQAPixel_RGB16_565			= {TQAImagePixelType}7;			{  16 bits/pixel, no alpha, R:5, G:6, B:5 WINDOWS ONLY  }
	kQAPixel_RGB24				= {TQAImagePixelType}8;			{  24 bits/pixel, no alpha, R:8, G:8, B:8 WINDOWS ONLY  }


TYPE
	TQAColorTableType 			= LONGINT;
CONST
	kQAColorTable_CL8_RGB32		= {TQAColorTableType}0;			{  256 entry, 32 bit/pixel, R=23:16, G=15:8, B=7:0  }
	kQAColorTable_CL4_RGB32		= {TQAColorTableType}1;			{  16 entry, 32 bit/pixel, R=23:16, G=15:8, B=7:0  }

{ Selects target device type }

TYPE
	TQADeviceType 				= LONGINT;
CONST
	kQADeviceMemory				= {TQADeviceType}0;				{  Memory draw context  }
	kQADeviceGDevice			= {TQADeviceType}1;				{  Macintosh GDevice draw context  }
	kQADeviceWin32DC			= {TQADeviceType}2;				{  Win32 DC  }
	kQADeviceDDSurface			= {TQADeviceType}3;				{  Win32 DirectDraw Surface  }

{ Generic memory pixmap device }

TYPE
	TQADeviceMemoryPtr = ^TQADeviceMemory;
	TQADeviceMemory = RECORD
		rowBytes:				LONGINT;								{  Rowbytes  }
		pixelType:				TQAImagePixelType;						{  Depth, color space, etc.  }
		width:					LONGINT;								{  Width in pixels  }
		height:					LONGINT;								{  Height in pixels  }
		baseAddr:				Ptr;									{  Base address of pixmap  }
	END;

{ Selects target clip type }
	TQAClipType 				= LONGINT;
CONST
	kQAClipRgn					= {TQAClipType}0;				{  Macintosh clipRgn with serial number  }
	kQAClipWin32Rgn				= {TQAClipType}1;				{  Win32 clip region  }


TYPE
	TQARectPtr = ^TQARect;
	TQARect = RECORD
		left:					LONGINT;
		right:					LONGINT;
		top:					LONGINT;
		bottom:					LONGINT;
	END;

{$IFC TARGET_OS_MAC }
	TQAPlatformDevicePtr = ^TQAPlatformDevice;
	TQAPlatformDevice = RECORD
		CASE INTEGER OF
		0: (
			memoryDevice:		TQADeviceMemory;
			);
		1: (
			gDevice:			GDHandle;
			);
	END;

	TQAPlatformClipPtr = ^TQAPlatformClip;
	TQAPlatformClip = RECORD
		CASE INTEGER OF
		0: (
			clipRgn:			RgnHandle;
			);
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawNotificationProcPtr = PROCEDURE(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; refCon: LONGINT);
{$ELSEC}
	TQADrawNotificationProcPtr = ProcPtr;
{$ENDC}

	TQADrawNotificationProcRefNum		= LONGINT;
{ used to unregister your proc }
{$ELSEC}
{$IFC TARGET_OS_WIN32 }
{$ELSEC}
{
	 * Generic platform supports memory device only. TQARect is generic. TQAClip is ???.
	 }
	TQAPlatformDevice = RECORD
		CASE INTEGER OF
		0: (
			memoryDevice:		TQADeviceMemory;
			);
	END;

	TQAPlatformClip = RECORD
		CASE INTEGER OF
		0: (
			region:				Ptr;									{  ???  }
			);
	END;

{$ENDC}
{$ENDC}

	TQADevicePtr = ^TQADevice;
	TQADevice = RECORD
		deviceType:				TQADeviceType;
		device:					TQAPlatformDevice;
	END;

	TQAClipPtr = ^TQAClip;
	TQAClip = RECORD
		clipType:				TQAClipType;
		clip:					TQAPlatformClip;
	END;

{*****************************************************************************
 *
 * Basic data types.
 *
 ****************************************************************************}

	TQAEngine = ^LONGINT;
	TQAEnginePtr = ^LONGINT;
	TQATexture = ^LONGINT;
	TQATexturePtr = ^LONGINT;
	TQABitmap = ^LONGINT;
	TQABitmapPtr = ^LONGINT;
	TQADrawPrivate = ^LONGINT;
	TQADrawPrivatePtr = ^LONGINT;
	TQAColorTable = ^LONGINT;
	TQAColorTablePtr = ^LONGINT;
{ A single triangle element for QADrawTriMesh }
	TQAIndexedTrianglePtr = ^TQAIndexedTriangle;
	TQAIndexedTriangle = RECORD
		triangleFlags:			UInt32;									{  Triangle flags, see kQATriFlags_  }
		vertices:				ARRAY [0..2] OF UInt32;					{  Indices into a vertex array  }
	END;

{ An image for use as texture or bitmap }
	TQAImagePtr = ^TQAImage;
	TQAImage = RECORD
		width:					LONGINT;								{  Width of pixmap  }
		height:					LONGINT;								{  Height of pixmap  }
		rowBytes:				LONGINT;								{  Rowbytes of pixmap  }
		pixmap:					Ptr;									{  Pixmap  }
	END;

{ Standard error type }
	TQAError 					= LONGINT;
CONST
	kQANoErr					= {TQAError}0;					{  No error  }
	kQAError					= {TQAError}1;					{  Generic error flag  }
	kQAOutOfMemory				= {TQAError}2;					{  Insufficient memory  }
	kQANotSupported				= {TQAError}3;					{  Requested feature is not supported  }
	kQAOutOfDate				= {TQAError}4;					{  A newer drawing engine was registered  }
	kQAParamErr					= {TQAError}5;					{  Error in passed parameters  }
	kQAGestaltUnknown			= {TQAError}6;					{  Requested gestalt type isn't available  }
	kQADisplayModeUnsupported	= {TQAError}7;					{  Engine cannot render to the display in its current ,  }
																{  mode, but could if it were in some other mode  }
	kQAOutOfVideoMemory			= {TQAError}8;					{  There is not enough VRAM to support the desired context dimensions  }

{***********************************************************************************************
 *
 * Vertex data types.
 *
 **********************************************************************************************}
{
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
 }

TYPE
	TQAVGouraudPtr = ^TQAVGouraud;
	TQAVGouraud = RECORD
		x:						Single;									{  X pixel coordinate, 0.0 <= x < width  }
		y:						Single;									{  Y pixel coordinate, 0.0 <= y < height  }
		z:						Single;									{  Z coordinate, 0.0 <= z <= 1.0  }
		invW:					Single;									{  1 / w; required only when kQAPerspectiveZ_On is set  }
		r:						Single;									{  Red, 0.0 <= r <= 1.0  }
		g:						Single;									{  Green, 0.0 <= g <= 1.0  }
		b:						Single;									{  Blue, 0.0 <= b <= 1.0  }
		a:						Single;									{  Alpha, 0.0 <= a <= 1.0, 1.0 is opaque  }
	END;

{
 * TQAVTexture is used for texture mapping. The texture mapping operation
 * is controlled by the kQATag_TextureOp variable, which is a mask of
 * kQATextureOp_None/Modulate/Highlight/Decal. Below is pseudo-code for the
 * texture shading operation:
 *
 *		texPix = TextureLookup (uq/q, vq/q);
 *		if (kQATextureOp_Decal)
 *		(
 *			texPix.r = texPix.a * texPix.r + (1 - texPix.a) * r;
 *			texPix.g = texPix.a * texPix.g + (1 - texPix.a) * g;
 *			texPix.b = texPix.a * texPix.b + (1 - texPix.a) * b;
 *			texPix.a = a;
 *		)
 *		else
 *		(
 *			texPix.a = texPix.a * a;
 *		)
 *		if (kQATextureOp_Modulate)
 *		(
 *			texPix.r *= kd_r;		// Clamped to prevent overflow
 *			texPix.g *= kd_g;		// Clamped to prevent overflow
 *			texPix.b *= kd_b;		// Clamped to prevent overflow
 *		)
 *		if (kQATextureOp_Highlight)
 *		(
 *			texPix.r += ks_r;		// Clamped to prevent overflow
 *			texPix.g += ks_g;		// Clamped to prevent overflow
 *			texPix.b += ks_b;		// Clamped to prevent overflow
 *		)
 *
 * After computation of texPix, transparency blending (as shown
 * above for TQAVGouraud) is performed.
 }
	TQAVTexturePtr = ^TQAVTexture;
	TQAVTexture = RECORD
		x:						Single;									{  X pixel coordinate, 0.0 <= x < width  }
		y:						Single;									{  Y pixel coordinate, 0.0 <= y < height  }
		z:						Single;									{  Z coordinate, 0.0 <= z <= 1.0  }
		invW:					Single;									{  1 / w (always required)  }
																		{  rgb are used only when kQATextureOp_Decal is set. a is always required  }
		r:						Single;									{  Red, 0.0 <= r <= 1.0  }
		g:						Single;									{  Green, 0.0 <= g <= 1.0  }
		b:						Single;									{  Blue, 0.0 <= b <= 1.0  }
		a:						Single;									{  Alpha, 0.0 <= a <= 1.0, 1.0 is opaque  }
																		{  uOverW and vOverW are required by all modes  }
		uOverW:					Single;									{  u / w  }
		vOverW:					Single;									{  v / w  }
																		{  kd_r/g/b are used only when kQATextureOp_Modulate is set  }
		kd_r:					Single;									{  Scale factor for texture red, 0.0 <= kd_r  }
		kd_g:					Single;									{  Scale factor for texture green, 0.0 <= kd_g  }
		kd_b:					Single;									{  Scale factor for texture blue, 0.0 <= kd_b  }
																		{  ks_r/g/b are used only when kQATextureOp_Highlight is set  }
		ks_r:					Single;									{  Red specular highlight, 0.0 <= ks_r <= 1.0  }
		ks_g:					Single;									{  Green specular highlight, 0.0 <= ks_g <= 1.0  }
		ks_b:					Single;									{  Blue specular highlight, 0.0 <= ks_b <= 1.0  }
	END;

{***********************************************************************************************
 *
 * Constants used for the state variables.
 *
 **********************************************************************************************}
{
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
 }
	TQATagInt 					= LONGINT;
CONST
	kQATag_ZFunction			= {TQATagInt}0;
	kQATag_Antialias			= {TQATagInt}8;
	kQATag_Blend				= {TQATagInt}9;
	kQATag_PerspectiveZ			= {TQATagInt}10;
	kQATag_TextureFilter		= {TQATagInt}11;
	kQATag_TextureOp			= {TQATagInt}12;
	kQATag_CSGTag				= {TQATagInt}14;
	kQATag_CSGEquation			= {TQATagInt}15;
	kQATag_BufferComposite		= {TQATagInt}16;
	kQATagGL_DrawBuffer			= {TQATagInt}100;
	kQATagGL_TextureWrapU		= {TQATagInt}101;
	kQATagGL_TextureWrapV		= {TQATagInt}102;
	kQATagGL_TextureMagFilter	= {TQATagInt}103;
	kQATagGL_TextureMinFilter	= {TQATagInt}104;
	kQATagGL_ScissorXMin		= {TQATagInt}105;
	kQATagGL_ScissorYMin		= {TQATagInt}106;
	kQATagGL_ScissorXMax		= {TQATagInt}107;
	kQATagGL_ScissorYMax		= {TQATagInt}108;
	kQATagGL_BlendSrc			= {TQATagInt}109;
	kQATagGL_BlendDst			= {TQATagInt}110;
	kQATagGL_LinePattern		= {TQATagInt}111;
	kQATagGL_AreaPattern0		= {TQATagInt}117;				{  ...1-30  }
	kQATagGL_AreaPattern31		= {TQATagInt}148;
	kQATag_EngineSpecific_Minimum = {TQATagInt}1000;


TYPE
	TQATagPtr 					= LONGINT;
CONST
	kQATag_Texture				= {TQATagPtr}13;


TYPE
	TQATagFloat 				= LONGINT;
CONST
	kQATag_ColorBG_a			= {TQATagFloat}1;
	kQATag_ColorBG_r			= {TQATagFloat}2;
	kQATag_ColorBG_g			= {TQATagFloat}3;
	kQATag_ColorBG_b			= {TQATagFloat}4;
	kQATag_Width				= {TQATagFloat}5;
	kQATag_ZMinOffset			= {TQATagFloat}6;
	kQATag_ZMinScale			= {TQATagFloat}7;
	kQATagGL_DepthBG			= {TQATagFloat}112;
	kQATagGL_TextureBorder_a	= {TQATagFloat}113;
	kQATagGL_TextureBorder_r	= {TQATagFloat}114;
	kQATagGL_TextureBorder_g	= {TQATagFloat}115;
	kQATagGL_TextureBorder_b	= {TQATagFloat}116;

{ kQATag_ZFunction }
	kQAZFunction_None			= 0;							{  Z is neither tested nor written (same as no Z buffer)  }
	kQAZFunction_LT				= 1;							{  Znew < Zbuffer is visible  }
	kQAZFunction_EQ				= 2;							{  OpenGL Only: Znew == Zbuffer is visible  }
	kQAZFunction_LE				= 3;							{  OpenGL Only: Znew <= Zbuffer is visible  }
	kQAZFunction_GT				= 4;							{  OpenGL Only: Znew > Zbuffer is visible  }
	kQAZFunction_NE				= 5;							{  OpenGL Only: Znew != Zbuffer is visible  }
	kQAZFunction_GE				= 6;							{  OpenGL Only: Znew >= Zbuffer is visible  }
	kQAZFunction_True			= 7;							{  Znew is always visible  }

{ kQATag_Width }
	kQAMaxWidth = 128.0;
{ kQATag_Antialias }
	kQAAntiAlias_Off			= 0;
	kQAAntiAlias_Fast			= 1;
	kQAAntiAlias_Mid			= 2;
	kQAAntiAlias_Best			= 3;

{ kQATag_Blend }
	kQABlend_PreMultiply		= 0;
	kQABlend_Interpolate		= 1;
	kQABlend_OpenGL				= 2;

{ kQATag_BufferComposite }
	kQABufferComposite_None		= 0;							{  Default: New pixels overwrite initial buffer contents  }
	kQABufferComposite_PreMultiply = 1;							{  New pixels are blended with initial buffer contents via PreMultiply  }
	kQABufferComposite_Interpolate = 2;							{  New pixels are blended with initial buffer contents via Interpolate  }

{ kQATag_PerspectiveZ }
	kQAPerspectiveZ_Off			= 0;							{  Use Z for hidden surface removal  }
	kQAPerspectiveZ_On			= 1;							{  Use InvW for hidden surface removal  }

{ kQATag_TextureFilter }
																{  suggested meanings of these values  }
	kQATextureFilter_Fast		= 0;							{  No filtering, pick nearest  }
	kQATextureFilter_Mid		= 1;							{  Fastest method that does some filtering  }
	kQATextureFilter_Best		= 2;							{  Highest quality renderer can do  }

{ kQATag_TextureOp (mask of one or more) }
	kQATextureOp_None			= 0;							{  Default texture mapping mode  }
	kQATextureOp_Modulate		= $01;							{  Modulate texture color with kd_r/g/b  }
	kQATextureOp_Highlight		= $02;							{  Add highlight value ks_r/g/b  }
	kQATextureOp_Decal			= $04;							{  When texture alpha == 0, use rgb instead  }
	kQATextureOp_Shrink			= $08;							{  This is a non-wrapping texture, so the ???  }

{ kQATag_CSGTag }
	kQACSGTag_0					= 0;							{  Submitted tris have CSG ID 0  }
	kQACSGTag_1					= 1;							{  Submitted tris have CSG ID 1  }
	kQACSGTag_2					= 2;							{  Submitted tris have CSG ID 2  }
	kQACSGTag_3					= 3;							{  Submitted tris have CSG ID 3  }
	kQACSGTag_4					= 4;							{  Submitted tris have CSG ID 4  }

{ kQATagGL_TextureWrapU/V }
	kQAGL_Repeat				= 0;
	kQAGL_Clamp					= 1;

{ kQATagGL_BlendSrc }
	kQAGL_SourceBlend_XXX		= 0;

{ kQATagGL_BlendDst }
	kQAGL_DestBlend_XXX			= 0;

{ kQATagGL_DrawBuffer (mask of one or more) }
	kQAGL_DrawBuffer_None		= 0;
	kQAGL_DrawBuffer_FrontLeft	= $01;
	kQAGL_DrawBuffer_FrontRight	= $02;
	kQAGL_DrawBuffer_BackLeft	= $04;
	kQAGL_DrawBuffer_BackRight	= $08;
	kQAGL_DrawBuffer_Front		= $03;
	kQAGL_DrawBuffer_Back		= $0C;

{***********************************************************************************************
 *
 * Constants used as function parameters.
 *
 **********************************************************************************************}
{
 * TQAVertexMode is a parameter to QADrawVGouraud() and QADrawVTexture() that specifies how
 * to interpret and draw the vertex array.
 }

TYPE
	TQAVertexMode 				= LONGINT;
CONST
	kQAVertexMode_Point			= {TQAVertexMode}0;				{  Draw nVertices points  }
	kQAVertexMode_Line			= {TQAVertexMode}1;				{  Draw nVertices/2 line segments  }
	kQAVertexMode_Polyline		= {TQAVertexMode}2;				{  Draw nVertices-1 connected line segments  }
	kQAVertexMode_Tri			= {TQAVertexMode}3;				{  Draw nVertices/3 triangles  }
	kQAVertexMode_Strip			= {TQAVertexMode}4;				{  Draw nVertices-2 triangles as a strip  }
	kQAVertexMode_Fan			= {TQAVertexMode}5;				{  Draw nVertices-2 triangles as a fan from v0  }
	kQAVertexMode_NumModes		= {TQAVertexMode}6;

{
 * TQAGestaltSelector is a parameter to QAEngineGestalt(). It selects which gestalt
 * parameter will be copied into 'response'.
 }

TYPE
	TQAGestaltSelector 			= LONGINT;
CONST
	kQAGestalt_OptionalFeatures	= {TQAGestaltSelector}0;		{  Mask of one or more kQAOptional_xxx  }
	kQAGestalt_FastFeatures		= {TQAGestaltSelector}1;		{  Mask of one or more kQAFast_xxx  }
	kQAGestalt_VendorID			= {TQAGestaltSelector}2;		{  Vendor ID  }
	kQAGestalt_EngineID			= {TQAGestaltSelector}3;		{  Engine ID  }
	kQAGestalt_Revision			= {TQAGestaltSelector}4;		{  Revision number of this engine  }
	kQAGestalt_ASCIINameLength	= {TQAGestaltSelector}5;		{  strlen (asciiName)  }
	kQAGestalt_ASCIIName		= {TQAGestaltSelector}6;		{  Causes strcpy (response, asciiName)  }
	kQAGestalt_TextureMemory	= {TQAGestaltSelector}7;		{  amount of texture RAM currently available  }
	kQAGestalt_FastTextureMemory = {TQAGestaltSelector}8;		{  amount of texture RAM currently available  }
	kQAGestalt_NumSelectors		= {TQAGestaltSelector}9;

{
 * TQAMethodSelector is a parameter to QASetNoticeMethod to select the notice method
 }

TYPE
	TQAMethodSelector 			= LONGINT;
CONST
	kQAMethod_RenderCompletion	= {TQAMethodSelector}0;			{  Called when rendering has completed and buffers swapped  }
	kQAMethod_DisplayModeChanged = {TQAMethodSelector}1;		{  Called when a display mode has changed  }
	kQAMethod_ReloadTextures	= {TQAMethodSelector}2;			{  Called when texture memory has been invalidated  }
	kQAMethod_BufferInitialize	= {TQAMethodSelector}3;			{  Called when a buffer needs to be initialized  }
	kQAMethod_BufferComposite	= {TQAMethodSelector}4;			{  Called when rendering is finished and its safe to composite  }
	kQAMethod_NumSelectors		= {TQAMethodSelector}5;

{
 * kQATriFlags_xxx are ORed together to generate the 'flags' parameter
 * to QADrawTriGouraud() and QADrawTriTexture().
 }
	kQATriFlags_None			= 0;							{  No flags (triangle is front-facing or don't care)  }
	kQATriFlags_Backfacing		= $01;							{  Triangle is back-facing  }

{
 * kQATexture_xxx are ORed together to generate the 'flags' parameter to QATextureNew().
 }
	kQATexture_None				= 0;							{  No flags  }
	kQATexture_Lock				= $01;							{  Don't swap this texture out  }
	kQATexture_Mipmap			= $02;							{  This texture is mipmapped  }
	kQATexture_NoCompression	= $04;							{  Do not compress this texture  }
	kQATexture_HighCompression	= $08;							{  Compress texture, even if it takes a while  }

{
 * kQABitmap_xxx are ORed together to generate the 'flags' parameter to QABitmapNew().
 }
	kQABitmap_None				= 0;							{  No flags  }
	kQABitmap_Lock				= $02;							{  Don't swap this bitmap out  }
	kQABitmap_NoCompression		= $04;							{  Do not compress this bitmap  }
	kQABitmap_HighCompression	= $08;							{  Compress bitmap, even if it takes a while  }

{
 * kQAContext_xxx are ORed together to generate the 'flags' parameter for QADrawContextNew().
 }
	kQAContext_None				= 0;							{  No flags  }
	kQAContext_NoZBuffer		= $01;							{  No hidden surface removal  }
	kQAContext_DeepZ			= $02;							{  Hidden surface precision >= 24 bits  }
	kQAContext_DoubleBuffer		= $04;							{  Double buffered window  }
	kQAContext_Cache			= $08;							{  This is a cache context  }
	kQAContext_NoDither			= $10;							{  No dithering, straight color banding  }

{
 * kQAOptional_xxx are ORed together to generate the kQAGestalt_OptionalFeatures response
 * from QAEngineGestalt().
 }
	kQAOptional_None			= 0;							{  No optional features  }
	kQAOptional_DeepZ			= $01;							{  Hidden surface precision >= 24 bits  }
	kQAOptional_Texture			= $02;							{  Texture mapping  }
	kQAOptional_TextureHQ		= $04;							{  High quality texture (tri-linear mip or better)  }
	kQAOptional_TextureColor	= $08;							{  Full color modulation and highlight of textures  }
	kQAOptional_Blend			= $10;							{  Transparency blending of RGB  }
	kQAOptional_BlendAlpha		= $20;							{  Transparency blending includes alpha channel  }
	kQAOptional_Antialias		= $40;							{  Antialiased rendering  }
	kQAOptional_ZSorted			= $80;							{  Z sorted rendering (for transparency, etc.)  }
	kQAOptional_PerspectiveZ	= $0100;						{  Hidden surface removal using InvW instead of Z  }
	kQAOptional_OpenGL			= $0200;						{  Extended rasterization features for OpenGL™  }
	kQAOptional_NoClear			= $0400;						{  This drawing engine doesn't clear before drawing  }
	kQAOptional_CSG				= $0800;						{  kQATag_CSGxxx are implemented  }
	kQAOptional_BoundToDevice	= $1000;						{  This engine is tightly bound to GDevice  }
	kQAOptional_CL4				= $2000;						{  This engine suports kQAPixel_CL4  }
	kQAOptional_CL8				= $4000;						{  This engine suports kQAPixel_CL8  }
	kQAOptional_BufferComposite	= $8000;						{  This engine can composite with initial buffer contents  }
	kQAOptional_NoDither		= $00010000;					{  This engine can draw with no dithering  }

{
 * kQAFast_xxx are ORed together to generate the kQAGestalt_FastFeatures response
 * from QAEngineGestalt().
 }
	kQAFast_None				= 0;							{  No accelerated features  }
	kQAFast_Line				= $01;							{  Line drawing  }
	kQAFast_Gouraud				= $02;							{  Gouraud shaded triangles  }
	kQAFast_Texture				= $04;							{  Texture mapped triangles  }
	kQAFast_TextureHQ			= $08;							{  High quality texture (tri-linear mip or better)  }
	kQAFast_Blend				= $10;							{  Transparency blending  }
	kQAFast_Antialiasing		= $20;							{  Antialiased rendering  }
	kQAFast_ZSorted				= $40;							{  Z sorted rendering of non-opaque objects  }
	kQAFast_CL4					= $80;							{  This engine accelerates kQAPixel_CL4  }
	kQAFast_CL8					= $0100;						{  This engine accelerates kQAPixel_CL8  }




{*******************************************************************
 * TQAVersion sets the TQADrawContext 'version' field. It is set by
 * the manager to indicate the version of the TQADrawContext structure.
 ******************************************************************}

TYPE
	TQAVersion 					= LONGINT;
CONST
	kQAVersion_Prerelease		= {TQAVersion}0;
	kQAVersion_1_0				= {TQAVersion}1;
	kQAVersion_1_0_5			= {TQAVersion}2;				{  Added tri mesh functions, color tables  }
	kQAVersion_1_5				= {TQAVersion}3;				{  Added call backs, texture compression, and new error return code  }



{**********************************************************************
 * TQADrawContext structure holds method pointers.
 * This is a forward refrence. The structure is defined later.
 *********************************************************************}

TYPE
	TQADrawContextPtr = ^TQADrawContext;
{***********************************************************************************************
 *
 * Typedefs of draw method functions provided by the drawing engine. One function pointer
 * for each of these function types in stored in the TQADrawContext public data structure.
 *
 * These functions should be accessed through the QA<function>(context,...) macros,
 * defined above.
 *
 **********************************************************************************************}
{$IFC TYPED_FUNCTION_POINTERS}
	TQAStandardNoticeMethod = PROCEDURE({CONST}VAR drawContext: TQADrawContext; refCon: UNIV Ptr); C;
{$ELSEC}
	TQAStandardNoticeMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQABufferNoticeMethod = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR buffer: TQADevice; {CONST}VAR dirtyRect: TQARect; refCon: UNIV Ptr); C;
{$ELSEC}
	TQABufferNoticeMethod = ProcPtr;
{$ENDC}

	TQANoticeMethodPtr = ^TQANoticeMethod;
	TQANoticeMethod = RECORD
		CASE INTEGER OF
		0: (
			standardNoticeMethod: TQAStandardNoticeMethod;				{  Used for non-buffer related methods  }
			);
		1: (
			bufferNoticeMethod:	TQABufferNoticeMethod;					{  Used for buffer handling methods  }
			);
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetFloat = PROCEDURE(VAR drawContext: TQADrawContext; tag: TQATagFloat; newValue: Single); C;
{$ELSEC}
	TQASetFloat = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetInt = PROCEDURE(VAR drawContext: TQADrawContext; tag: TQATagInt; newValue: UInt32); C;
{$ELSEC}
	TQASetInt = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetPtr = PROCEDURE(VAR drawContext: TQADrawContext; tag: TQATagPtr; newValue: UNIV Ptr); C;
{$ELSEC}
	TQASetPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetFloat = FUNCTION({CONST}VAR drawContext: TQADrawContext; tag: TQATagFloat): Single; C;
{$ELSEC}
	TQAGetFloat = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetInt = FUNCTION({CONST}VAR drawContext: TQADrawContext; tag: TQATagInt): UInt32; C;
{$ELSEC}
	TQAGetInt = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetPtr = FUNCTION({CONST}VAR drawContext: TQADrawContext; tag: TQATagPtr): Ptr; C;
{$ELSEC}
	TQAGetPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawPoint = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v: TQAVGouraud); C;
{$ELSEC}
	TQADrawPoint = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawLine = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v0: TQAVGouraud; {CONST}VAR v1: TQAVGouraud); C;
{$ELSEC}
	TQADrawLine = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v0: TQAVGouraud; {CONST}VAR v1: TQAVGouraud; {CONST}VAR v2: TQAVGouraud; flags: UInt32); C;
{$ELSEC}
	TQADrawTriGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v0: TQAVTexture; {CONST}VAR v1: TQAVTexture; {CONST}VAR v2: TQAVTexture; flags: UInt32); C;
{$ELSEC}
	TQADrawTriTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASubmitVerticesGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; {CONST}VAR vertices: TQAVGouraud); C;
{$ELSEC}
	TQASubmitVerticesGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASubmitVerticesTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; {CONST}VAR vertices: TQAVTexture); C;
{$ELSEC}
	TQASubmitVerticesTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriMeshGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nTriangles: UInt32; {CONST}VAR triangles: TQAIndexedTriangle); C;
{$ELSEC}
	TQADrawTriMeshGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriMeshTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nTriangles: UInt32; {CONST}VAR triangles: TQAIndexedTriangle); C;
{$ELSEC}
	TQADrawTriMeshTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawVGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; vertexMode: TQAVertexMode; {CONST}VAR vertices: TQAVGouraud; {CONST}VAR flags: UInt32); C;
{$ELSEC}
	TQADrawVGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawVTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; vertexMode: TQAVertexMode; {CONST}VAR vertices: TQAVTexture; {CONST}VAR flags: UInt32); C;
{$ELSEC}
	TQADrawVTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawBitmap = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v: TQAVGouraud; VAR bitmap: TQABitmap); C;
{$ELSEC}
	TQADrawBitmap = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQARenderStart = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR dirtyRect: TQARect; {CONST}VAR initialContext: TQADrawContext); C;
{$ELSEC}
	TQARenderStart = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQARenderEnd = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR modifiedRect: TQARect): TQAError; C;
{$ELSEC}
	TQARenderEnd = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQARenderAbort = FUNCTION({CONST}VAR drawContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQARenderAbort = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAFlush = FUNCTION({CONST}VAR drawContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQAFlush = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASync = FUNCTION({CONST}VAR drawContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQASync = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetNoticeMethod = FUNCTION({CONST}VAR drawContext: TQADrawContext; method: TQAMethodSelector; completionCallBack: TQANoticeMethod; refCon: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQASetNoticeMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetNoticeMethod = FUNCTION({CONST}VAR drawContext: TQADrawContext; method: TQAMethodSelector; VAR completionCallBack: TQANoticeMethod; VAR refCon: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQAGetNoticeMethod = ProcPtr;
{$ENDC}

{***********************************************************************************************
 *
 * Public TQADrawContext structure. This contains function pointers for the chosen
 * drawing engine.
 *
 **********************************************************************************************}
	TQADrawContext = RECORD
		drawPrivate:			TQADrawPrivatePtr;						{  Engine's private data for this context  }
		version:				TQAVersion;								{  Version number  }
		setFloat:				TQASetFloat;							{  Method: Set a float state variable  }
		setInt:					TQASetInt;								{  Method: Set an unsigned long state variable  }
		setPtr:					TQASetPtr;								{  Method: Set an unsigned long state variable  }
		getFloat:				TQAGetFloat;							{  Method: Get a float state variable  }
		getInt:					TQAGetInt;								{  Method: Get an unsigned long state variable  }
		getPtr:					TQAGetPtr;								{  Method: Get an pointer state variable  }
		drawPoint:				TQADrawPoint;							{  Method: Draw a point  }
		drawLine:				TQADrawLine;							{  Method: Draw a line  }
		drawTriGouraud:			TQADrawTriGouraud;						{  Method: Draw a Gouraud shaded triangle  }
		drawTriTexture:			TQADrawTriTexture;						{  Method: Draw a texture mapped triangle  }
		drawVGouraud:			TQADrawVGouraud;						{  Method: Draw Gouraud vertices  }
		drawVTexture:			TQADrawVTexture;						{  Method: Draw texture vertices  }
		drawBitmap:				TQADrawBitmap;							{  Method: Draw a bitmap  }
		renderStart:			TQARenderStart;							{  Method: Initialize for rendering  }
		renderEnd:				TQARenderEnd;							{  Method: Complete rendering and display  }
		renderAbort:			TQARenderAbort;							{  Method: Abort any outstanding rendering (blocking)  }
		flush:					TQAFlush;								{  Method: Start render of any queued commands (non-blocking)  }
		sync:					TQASync;								{  Method: Wait for completion of all rendering (blocking)  }
		submitVerticesGouraud:	TQASubmitVerticesGouraud;				{  Method: Submit Gouraud vertices for trimesh  }
		submitVerticesTexture:	TQASubmitVerticesTexture;				{  Method: Submit Texture vertices for trimesh  }
		drawTriMeshGouraud:		TQADrawTriMeshGouraud;					{  Method: Draw a Gouraud triangle mesh  }
		drawTriMeshTexture:		TQADrawTriMeshTexture;					{  Method: Draw a Texture triangle mesh  }
		setNoticeMethod:		TQASetNoticeMethod;						{  Method: Set a notice method  }
		getNoticeMethod:		TQAGetNoticeMethod;						{  Method: Get a notice method  }
	END;

{***********************************************************************************************
 *
 * Acceleration manager function prototypes.
 *
 **********************************************************************************************}
FUNCTION QADrawContextNew({CONST}VAR device: TQADevice; {CONST}VAR rect: TQARect; {CONST}VAR clip: TQAClip; {CONST}VAR engine: TQAEngine; flags: UInt32; VAR newDrawContext: TQADrawContextPtr): TQAError; C;
PROCEDURE QADrawContextDelete(VAR drawContext: TQADrawContext); C;
FUNCTION QAColorTableNew({CONST}VAR engine: TQAEngine; tableType: TQAColorTableType; pixelData: UNIV Ptr; transparentIndexFlag: LONGINT; VAR newTable: TQAColorTablePtr): TQAError; C;
PROCEDURE QAColorTableDelete({CONST}VAR engine: TQAEngine; VAR colorTable: TQAColorTable); C;
FUNCTION QATextureNew({CONST}VAR engine: TQAEngine; flags: UInt32; pixelType: TQAImagePixelType; {CONST}VAR images: TQAImage; VAR newTexture: TQATexturePtr): TQAError; C;
FUNCTION QATextureDetach({CONST}VAR engine: TQAEngine; VAR texture: TQATexture): TQAError; C;
PROCEDURE QATextureDelete({CONST}VAR engine: TQAEngine; VAR texture: TQATexture); C;
FUNCTION QATextureBindColorTable({CONST}VAR engine: TQAEngine; VAR texture: TQATexture; VAR colorTable: TQAColorTable): TQAError; C;
FUNCTION QABitmapNew({CONST}VAR engine: TQAEngine; flags: UInt32; pixelType: TQAImagePixelType; {CONST}VAR image: TQAImage; VAR newBitmap: TQABitmapPtr): TQAError; C;
FUNCTION QABitmapDetach({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap): TQAError; C;
PROCEDURE QABitmapDelete({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap); C;
FUNCTION QABitmapBindColorTable({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap; VAR colorTable: TQAColorTable): TQAError; C;
FUNCTION QADeviceGetFirstEngine({CONST}VAR device: TQADevice): TQAEnginePtr; C;
FUNCTION QADeviceGetNextEngine({CONST}VAR device: TQADevice; {CONST}VAR currentEngine: TQAEngine): TQAEnginePtr; C;
FUNCTION QAEngineCheckDevice({CONST}VAR engine: TQAEngine; {CONST}VAR device: TQADevice): TQAError; C;
FUNCTION QAEngineGestalt({CONST}VAR engine: TQAEngine; selector: TQAGestaltSelector; response: UNIV Ptr): TQAError; C;
FUNCTION QAEngineEnable(vendorID: LONGINT; engineID: LONGINT): TQAError; C;
FUNCTION QAEngineDisable(vendorID: LONGINT; engineID: LONGINT): TQAError; C;

{$IFC TARGET_OS_MAC }
FUNCTION QARegisterDrawNotificationProc(VAR globalRect: Rect; proc: TQADrawNotificationProcPtr; refCon: LONGINT; VAR refNum: TQADrawNotificationProcRefNum): TQAError; C;
FUNCTION QAUnregisterDrawNotificationProc(refNum: TQADrawNotificationProcRefNum): TQAError; C;
{$ENDC}  {TARGET_OS_MAC}







{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := RAVEIncludes}

{$ENDC} {__RAVE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
