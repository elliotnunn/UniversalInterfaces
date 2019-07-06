{
 	File:		QD3DShader.p
 
 	Contains:	QuickDraw 3D Shader / Color Routines							
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DShader;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DSHADER__}
{$SETC __QD3DSHADER__ := 1}

{$I+}
{$SETC QD3DShaderIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **																			 **
 **								RGB Color routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ColorRGB_Set(VAR color: TQ3ColorRGB; r: Single; g: Single; b: Single): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorARGB_Set(VAR color: TQ3ColorARGB; a: Single; r: Single; g: Single; b: Single): TQ3ColorARGBPtr; C;
FUNCTION Q3ColorRGB_Add({CONST}VAR c1: TQ3ColorRGB; {CONST}VAR c2: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Subtract({CONST}VAR c1: TQ3ColorRGB; {CONST}VAR c2: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Scale({CONST}VAR color: TQ3ColorRGB; scale: Single; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Clamp({CONST}VAR color: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Lerp({CONST}VAR first: TQ3ColorRGB; {CONST}VAR last: TQ3ColorRGB; alpha: Single; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Accumulate({CONST}VAR src: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
{  Q3ColorRGB_Luminance really returns a pointer to a Single }
FUNCTION Q3ColorRGB_Luminance({CONST}VAR color: TQ3ColorRGB; VAR luminance: Single): Ptr; C;
{*****************************************************************************
 **																			 **
 **								Shader Types								 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3ShaderUVBoundary 		= LONGINT;
CONST
	kQ3ShaderUVBoundaryWrap		= {TQ3ShaderUVBoundary}0;
	kQ3ShaderUVBoundaryClamp	= {TQ3ShaderUVBoundary}1;


{*****************************************************************************
 **																			 **
 **								Shader Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Shader_GetType(shader: TQ3ShaderObject): LONGINT; C;
FUNCTION Q3Shader_Submit(shader: TQ3ShaderObject; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Shader_SetUVTransform(shader: TQ3ShaderObject; {CONST}VAR uvTransform: TQ3Matrix3x3): TQ3Status; C;
FUNCTION Q3Shader_GetUVTransform(shader: TQ3ShaderObject; VAR uvTransform: TQ3Matrix3x3): TQ3Status; C;
FUNCTION Q3Shader_SetUBoundary(shader: TQ3ShaderObject; uBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
FUNCTION Q3Shader_SetVBoundary(shader: TQ3ShaderObject; vBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
FUNCTION Q3Shader_GetUBoundary(shader: TQ3ShaderObject; VAR uBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
FUNCTION Q3Shader_GetVBoundary(shader: TQ3ShaderObject; VAR vBoundary: TQ3ShaderUVBoundary): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Illumination Shader	Classes						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3IlluminationShader_GetType(shader: TQ3ShaderObject): LONGINT; C;
FUNCTION Q3PhongIllumination_New: TQ3ShaderObject; C;
FUNCTION Q3LambertIllumination_New: TQ3ShaderObject; C;
FUNCTION Q3NULLIllumination_New: TQ3ShaderObject; C;

{*****************************************************************************
 **																			 **
 **								 Surface Shader								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3SurfaceShader_GetType(shader: TQ3SurfaceShaderObject): LONGINT; C;

{*****************************************************************************
 **																			 **
 **								Texture Shader								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3TextureShader_New(texture: TQ3TextureObject): TQ3ShaderObject; C;
FUNCTION Q3TextureShader_GetTexture(shader: TQ3ShaderObject; VAR texture: TQ3TextureObject): TQ3Status; C;
FUNCTION Q3TextureShader_SetTexture(shader: TQ3ShaderObject; texture: TQ3TextureObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **								Texture Objects								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Texture_GetType(texture: TQ3TextureObject): LONGINT; C;
FUNCTION Q3Texture_GetWidth(texture: TQ3TextureObject; VAR width: UInt32): TQ3Status; C;
FUNCTION Q3Texture_GetHeight(texture: TQ3TextureObject; VAR height: UInt32): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **								Pixmap Texture							     **
 **																			 **
 ****************************************************************************}
FUNCTION Q3PixmapTexture_New({CONST}VAR pixmap: TQ3StoragePixmap): TQ3TextureObject; C;
FUNCTION Q3PixmapTexture_GetPixmap(texture: TQ3TextureObject; VAR pixmap: TQ3StoragePixmap): TQ3Status; C;
FUNCTION Q3PixmapTexture_SetPixmap(texture: TQ3TextureObject; {CONST}VAR pixmap: TQ3StoragePixmap): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **								Mipmap Texture							     **
 **																			 **
 ****************************************************************************}
FUNCTION Q3MipmapTexture_New({CONST}VAR mipmap: TQ3Mipmap): TQ3TextureObject; C;
FUNCTION Q3MipmapTexture_GetMipmap(texture: TQ3TextureObject; VAR mipmap: TQ3Mipmap): TQ3Status; C;
FUNCTION Q3MipmapTexture_SetMipmap(texture: TQ3TextureObject; {CONST}VAR mipmap: TQ3Mipmap): TQ3Status; C;




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DShaderIncludes}

{$ENDC} {__QD3DSHADER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
