{
 	File:		RAVESystem.p
 
 	Contains:	Interfaces needed when building RAVE engines							
 
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
 UNIT RAVESystem;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RAVESYSTEM__}
{$SETC __RAVESYSTEM__ := 1}

{$I+}
{$SETC RAVESystemIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __RAVE__}
{$I RAVE.p}
{$ENDC}



{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{***********************************************************************************************
 *
 * Typedefs of texture/bitmap method functions provided by the drawing engine.
 *
 **********************************************************************************************}
{ TQAColorTableNew	parameter descriptions }
{ TQAColorTableType	pixelType			Depth, color space, etc. }
{ void					*pixelData			lookup table entries in pixelType format }
{ long					transparentIndex	boolean, false means no transparency, true means index 0 is transparent }
{ TQAColorTable		**newTable			(Out) Newly created TQAColorTable }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQAColorTableNew = FUNCTION(pixelType: TQAColorTableType; pixelData: UNIV Ptr; transparentIndex: LONGINT; VAR newTable: TQAColorTablePtr): TQAError; C;
{$ELSEC}
	TQAColorTableNew = ProcPtr;
{$ENDC}

{ TQAColorTableDelete	parameter descriptions }
{ TQAColorTable		*colorTable		Previously allocated by QAColorTableNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQAColorTableDelete = PROCEDURE(VAR colorTable: TQAColorTable); C;
{$ELSEC}
	TQAColorTableDelete = ProcPtr;
{$ENDC}

{ TQATextureNew	parameter descriptions }
{	unsigned long		flags				Mask of kQATexture_xxx flags }
{	TQAImagePixelType	pixelType			Depth, color space, etc. }
{	const TQAImage		images[]			Image(s) for texture }
{	TQATexture			**newTexture		(Out) Newly created TQATexture, or NULL on error }
{$IFC TYPED_FUNCTION_POINTERS}
	TQATextureNew = FUNCTION(flags: UInt32; pixelType: TQAImagePixelType; {CONST}VAR images: TQAImage; VAR newTexture: TQATexturePtr): TQAError; C;
{$ELSEC}
	TQATextureNew = ProcPtr;
{$ENDC}

{ TQATextureDetach	parameter descriptions }
{	TQATexture			*texture			Previously allocated by QATextureNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQATextureDetach = FUNCTION(VAR texture: TQATexture): TQAError; C;
{$ELSEC}
	TQATextureDetach = ProcPtr;
{$ENDC}

{ TQATextureDelete	parameter descriptions }
{	TQATexture			*texture			Previously allocated by QATextureNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQATextureDelete = PROCEDURE(VAR texture: TQATexture); C;
{$ELSEC}
	TQATextureDelete = ProcPtr;
{$ENDC}

{ TQATextureBindColorTable	parameter descriptions }
{	TQATexture			*texture			Previously allocated by QATextureNew() }
{	TQAColorTable		*colorTable			Previously allocated by QAColorTableNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQATextureBindColorTable = FUNCTION(VAR texture: TQATexture; VAR colorTable: TQAColorTable): TQAError; C;
{$ELSEC}
	TQATextureBindColorTable = ProcPtr;
{$ENDC}

{ TQABitmapNew	parameter descriptions }
{	unsigned long		flags				Mask of kQABitmap_xxx flags }
{	TQAImagePixelType	pixelType			Depth, color space, etc. }
{	const TQAImage		*image				Image }
{	TQABitmap			**newBitmap			(Out) Newly created TQABitmap, or NULL on error }
{$IFC TYPED_FUNCTION_POINTERS}
	TQABitmapNew = FUNCTION(flags: UInt32; pixelType: TQAImagePixelType; {CONST}VAR image: TQAImage; VAR newBitmap: TQABitmapPtr): TQAError; C;
{$ELSEC}
	TQABitmapNew = ProcPtr;
{$ENDC}

{ TQABitmapDetach	parameter descriptions }
{	TQABitmap			*bitmap			Previously allocated by QABitmapNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQABitmapDetach = FUNCTION(VAR bitmap: TQABitmap): TQAError; C;
{$ELSEC}
	TQABitmapDetach = ProcPtr;
{$ENDC}

{ TQABitmapDelete	parameter descriptions }
{	TQABitmap			*bitmap			Previously allocated by QABitmapNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQABitmapDelete = PROCEDURE(VAR bitmap: TQABitmap); C;
{$ELSEC}
	TQABitmapDelete = ProcPtr;
{$ENDC}

{ TQABitmapBindColorTable	parameter descriptions }
{	TQABitmap			*bitmap			Previously allocated by QABitmapNew() }
{	TQAColorTable		*colorTable		Previously allocated by QAColorTableNew() }
{$IFC TYPED_FUNCTION_POINTERS}
	TQABitmapBindColorTable = FUNCTION(VAR bitmap: TQABitmap; VAR colorTable: TQAColorTable): TQAError; C;
{$ELSEC}
	TQABitmapBindColorTable = ProcPtr;
{$ENDC}

{***********************************************************************************************
 *
 * Typedefs of private (system-only) functions provided by the drawing engine.
 *
 * The TQADrawPrivateNew function returns a TQADrawPrivate *, which points to the
 * engine-specific private data created for the context. (TQADrawPrivate is a dummy
 * type which is then cast to the correct engine-specific datatype by the engine code.)
 *
 * The TQADrawPrivateDelete function deletes the engine-specific private data.
 *
 * TQAStorePrivateNew and TQAStorePrivateDelete provide the same function as QADrawPrivateNew
 * and TQADrawPrivateDelete, but for the texture and bitmap storage context.
 *
 * TQADrawMethodGet and TQAStoreMethodGet are called by the RAVE manager to retrieve
 * the method pointers for a drawing engine.
 *
 * The TQAEngineCheckDevice function returns TRUE if the engine can render to the
 * indicated GDevice.
 *
 **********************************************************************************************}
{ TQADrawPrivateNew	parameter descriptions }
{	TQADrawContext		*newDrawContext		Draw context to initialize }
{	const TQADevice		*device				Target device }
{	const TQARect		*rect				Target rectangle (device coordinates) }
{	const TQAClip		*clip				2D clip region (or NULL) }
{	unsigned long		flags				Mask of kQAContext_xxx }
{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawPrivateNew = FUNCTION(VAR newDrawContext: TQADrawContext; {CONST}VAR device: TQADevice; {CONST}VAR rect: TQARect; {CONST}VAR clip: TQAClip; flags: UInt32): TQAError; C;
{$ELSEC}
	TQADrawPrivateNew = ProcPtr;
{$ENDC}

{ TQADrawPrivateDelete	parameter descriptions }
{	TQADrawPrivate		*drawPrivate		Private context data to delete }
{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawPrivateDelete = PROCEDURE(VAR drawPrivate: TQADrawPrivate); C;
{$ELSEC}
	TQADrawPrivateDelete = ProcPtr;
{$ENDC}

{ TQAEngineCheckDevice	parameter descriptions }
{	const TQADevice		*device			Target device }
{$IFC TYPED_FUNCTION_POINTERS}
	TQAEngineCheckDevice = FUNCTION({CONST}VAR device: TQADevice): TQAError; C;
{$ELSEC}
	TQAEngineCheckDevice = ProcPtr;
{$ENDC}

{ TQAEngineGestalt	parameter descriptions }
{	TQAGestaltSelector	selector			Gestalt parameter being requested }
{	void				*response			Buffer that receives response }
{$IFC TYPED_FUNCTION_POINTERS}
	TQAEngineGestalt = FUNCTION(selector: TQAGestaltSelector; response: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQAEngineGestalt = ProcPtr;
{$ENDC}

{***********************************************************************************************
 *
 * The TQAEngineMethod union is used to represent a single engine method (it's a
 * parameter to QAEngineGetMethod). TQAEngineMethodTag identifies which method is being
 * requested.
 *
 **********************************************************************************************}
	TQAEngineMethodPtr = ^TQAEngineMethod;
	TQAEngineMethod = RECORD
		CASE INTEGER OF
		0: (
			drawPrivateNew:		TQADrawPrivateNew;						{  Method: Create a private draw context  }
			);
		1: (
			drawPrivateDelete:	TQADrawPrivateDelete;					{  Method: Delete a private draw context  }
			);
		2: (
			engineCheckDevice:	TQAEngineCheckDevice;					{  Method: Check a device for drawing  }
			);
		3: (
			engineGestalt:		TQAEngineGestalt;						{  Method: Gestalt  }
			);
		4: (
			textureNew:			TQATextureNew;							{  Method: Create a texture (load is non-blocking)  }
			);
		5: (
			textureDetach:		TQATextureDetach;						{  Method: Complete load of a texture (blocking)  }
			);
		6: (
			textureDelete:		TQATextureDelete;						{  Method: Delete a texture  }
			);
		7: (
			bitmapNew:			TQABitmapNew;							{  Method: Create a bitmap (load is non-blocking)   }
			);
		8: (
			bitmapDetach:		TQABitmapDetach;						{  Method: Complete load of a bitmap (blocking)  }
			);
		9: (
			bitmapDelete:		TQABitmapDelete;						{  Method: Delete a bitmap  }
			);
		10: (
			colorTableNew:		TQAColorTableNew;						{  Method: Create a new color table  }
			);
		11: (
			colorTableDelete:	TQAColorTableDelete;					{  Method: Create a new color table  }
			);
		12: (
			textureBindColorTable: TQATextureBindColorTable;			{  Method: Bind a CLUT to a texture  }
			);
		13: (
			bitmapBindColorTable: TQABitmapBindColorTable;				{  Method: Bind a CLUT to a bitmap  }
			);
	END;

	TQAEngineMethodTag 			= LONGINT;
CONST
	kQADrawPrivateNew			= {TQAEngineMethodTag}0;
	kQADrawPrivateDelete		= {TQAEngineMethodTag}1;
	kQAEngineCheckDevice		= {TQAEngineMethodTag}2;
	kQAEngineGestalt			= {TQAEngineMethodTag}3;
	kQATextureNew				= {TQAEngineMethodTag}4;
	kQATextureDetach			= {TQAEngineMethodTag}5;
	kQATextureDelete			= {TQAEngineMethodTag}6;
	kQABitmapNew				= {TQAEngineMethodTag}7;
	kQABitmapDetach				= {TQAEngineMethodTag}8;
	kQABitmapDelete				= {TQAEngineMethodTag}9;
	kQAColorTableNew			= {TQAEngineMethodTag}10;
	kQAColorTableDelete			= {TQAEngineMethodTag}11;
	kQATextureBindColorTable	= {TQAEngineMethodTag}12;
	kQABitmapBindColorTable		= {TQAEngineMethodTag}13;

{***********************************************************************************************
 *
 * QARegisterEngine() registers a new engine. This is called at boot time by the drawing engine
 * initialization code to register itself with the system. This call takes only one parameter,
 * the engine's function that allows the manager to request the other methods.
 *
 **********************************************************************************************}
{ TQAEngineGetMethod	parameter descriptions }
{	TQAEngineMethodTag		methodTag				Method being requested }
{	TQAEngineMethod			*method					(Out) Method }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQAEngineGetMethod = FUNCTION(methodTag: TQAEngineMethodTag; VAR method: TQAEngineMethod): TQAError; C;
{$ELSEC}
	TQAEngineGetMethod = ProcPtr;
{$ENDC}

{ QARegisterEngine	parameter descriptions }
{	TQAEngineGetMethod		engineGetMethod		Engine's getMethod method }
FUNCTION QARegisterEngine(engineGetMethod: TQAEngineGetMethod): TQAError; C;
{***********************************************************************************************
 *
 * The TQADrawMethod union is used to represent a single draw context method (it's a
 * parameter to QARegisterDrawMethod). TQADrawMethodTag identifies which method is being
 * passed.
 *
 **********************************************************************************************}

TYPE
	TQADrawMethodPtr = ^TQADrawMethod;
	TQADrawMethod = RECORD
		CASE INTEGER OF
		0: (
			setFloat:			TQASetFloat;							{  Method: Set a float state variable  }
			);
		1: (
			setInt:				TQASetInt;								{  Method: Set an unsigned long state variable  }
			);
		2: (
			setPtr:				TQASetPtr;								{  Method: Set an unsigned long state variable  }
			);
		3: (
			getFloat:			TQAGetFloat;							{  Method: Get a float state variable  }
			);
		4: (
			getInt:				TQAGetInt;								{  Method: Get an unsigned long state variable  }
			);
		5: (
			getPtr:				TQAGetPtr;								{  Method: Get an pointer state variable  }
			);
		6: (
			drawPoint:			TQADrawPoint;							{  Method: Draw a point  }
			);
		7: (
			drawLine:			TQADrawLine;							{  Method: Draw a line  }
			);
		8: (
			drawTriGouraud:		TQADrawTriGouraud;						{  Method: Draw a Gouraud shaded triangle  }
			);
		9: (
			drawTriTexture:		TQADrawTriTexture;						{  Method: Draw a texture mapped triangle  }
			);
		10: (
			drawVGouraud:		TQADrawVGouraud;						{  Method: Draw Gouraud vertices  }
			);
		11: (
			drawVTexture:		TQADrawVTexture;						{  Method: Draw texture vertices  }
			);
		12: (
			drawBitmap:			TQADrawBitmap;							{  Method: Draw a bitmap  }
			);
		13: (
			renderStart:		TQARenderStart;							{  Method: Initialize for rendering  }
			);
		14: (
			renderEnd:			TQARenderEnd;							{  Method: Complete rendering and display  }
			);
		15: (
			renderAbort:		TQARenderAbort;							{  Method: Abort any outstanding rendering (blocking)  }
			);
		16: (
			flush:				TQAFlush;								{  Method: Start render of any queued commands (non-blocking)  }
			);
		17: (
			sync:				TQASync;								{  Method: Wait for completion of all rendering (blocking)  }
			);
		18: (
			submitVerticesGouraud: TQASubmitVerticesGouraud;			{  Method: Submit Gouraud vertices for trimesh  }
			);
		19: (
			submitVerticesTexture: TQASubmitVerticesTexture;			{  Method: Submit Texture vertices for trimesh  }
			);
		20: (
			drawTriMeshGouraud:	TQADrawTriMeshGouraud;					{  Method: Draw a Gouraud triangle mesh  }
			);
		21: (
			drawTriMeshTexture:	TQADrawTriMeshTexture;					{  Method: Draw a Texture triangle mesh  }
			);
		22: (
			setNoticeMethod:	TQASetNoticeMethod;						{  Method: Set a notice method  }
			);
		23: (
			getNoticeMethod:	TQAGetNoticeMethod;						{  Method: Get a notice method  }
			);
	END;

	TQADrawMethodTag 			= LONGINT;
CONST
	kQASetFloat					= {TQADrawMethodTag}0;
	kQASetInt					= {TQADrawMethodTag}1;
	kQASetPtr					= {TQADrawMethodTag}2;
	kQAGetFloat					= {TQADrawMethodTag}3;
	kQAGetInt					= {TQADrawMethodTag}4;
	kQAGetPtr					= {TQADrawMethodTag}5;
	kQADrawPoint				= {TQADrawMethodTag}6;
	kQADrawLine					= {TQADrawMethodTag}7;
	kQADrawTriGouraud			= {TQADrawMethodTag}8;
	kQADrawTriTexture			= {TQADrawMethodTag}9;
	kQADrawVGouraud				= {TQADrawMethodTag}10;
	kQADrawVTexture				= {TQADrawMethodTag}11;
	kQADrawBitmap				= {TQADrawMethodTag}12;
	kQARenderStart				= {TQADrawMethodTag}13;
	kQARenderEnd				= {TQADrawMethodTag}14;
	kQARenderAbort				= {TQADrawMethodTag}15;
	kQAFlush					= {TQADrawMethodTag}16;
	kQASync						= {TQADrawMethodTag}17;
	kQASubmitVerticesGouraud	= {TQADrawMethodTag}18;
	kQASubmitVerticesTexture	= {TQADrawMethodTag}19;
	kQADrawTriMeshGouraud		= {TQADrawMethodTag}20;
	kQADrawTriMeshTexture		= {TQADrawMethodTag}21;
	kQASetNoticeMethod			= {TQADrawMethodTag}22;
	kQAGetNoticeMethod			= {TQADrawMethodTag}23;

{***********************************************************************************************
 *
 * System call to register a new method for an engine. This is called during the engine's
 * draw private new functions (to set the initial value of the draw methods), and possibly
 * at other times when the engine needs to change a draw method.
 *
 **********************************************************************************************}
{ QARegisterDrawMethod	parameter descriptions }
{	TQADrawContext			*drawContext			Draw context in which to set method }
{	TQADrawMethodTag		methodTag				Method to set }
{	TQADrawMethod			method					Method }
FUNCTION QARegisterDrawMethod(VAR drawContext: TQADrawContext; methodTag: TQADrawMethodTag; method: TQADrawMethod): TQAError; C;






{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := RAVESystemIncludes}

{$ENDC} {__RAVESYSTEM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
