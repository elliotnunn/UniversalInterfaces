{
     File:       CGContext.p
 
     Contains:   CoreGraphics context
 
     Version:    Technology: CoreGraphics-122 (Mac OS X 10.1)
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGContext;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGCONTEXT__}
{$SETC __CGCONTEXT__ := 1}

{$I+}
{$SETC CGContextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGAFFINETRANSFORM__}
{$I CGAffineTransform.p}
{$ENDC}
{$IFC UNDEFINED __CGCOLORSPACE__}
{$I CGColorSpace.p}
{$ENDC}
{$IFC UNDEFINED __CGFONT__}
{$I CGFont.p}
{$ENDC}
{$IFC UNDEFINED __CGIMAGE__}
{$I CGImage.p}
{$ENDC}
{$IFC UNDEFINED __CGPDFDOCUMENT__}
{$I CGPDFDocument.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGContextRef    = ^LONGINT; { an opaque 32-bit type }
	CGContextRefPtr = ^CGContextRef;  { when a VAR xx:CGContextRef parameter can be nil, it is changed to xx: CGContextRefPtr }
	CGPatternRef    = ^LONGINT; { an opaque 32-bit type }
	CGPatternRefPtr = ^CGPatternRef;  { when a VAR xx:CGPatternRef parameter can be nil, it is changed to xx: CGPatternRefPtr }
	{	 Line join styles. 	}
	CGLineJoin 					= SInt32;
CONST
	kCGLineJoinMiter			= 0;
	kCGLineJoinRound			= 1;
	kCGLineJoinBevel			= 2;

	{	 Line cap styles. 	}

TYPE
	CGLineCap 					= SInt32;
CONST
	kCGLineCapButt				= 0;
	kCGLineCapRound				= 1;
	kCGLineCapSquare			= 2;

	{	 Drawing modes for paths. 	}

TYPE
	CGPathDrawingMode 			= SInt32;
CONST
	kCGPathFill					= 0;
	kCGPathEOFill				= 1;
	kCGPathStroke				= 2;
	kCGPathFillStroke			= 3;
	kCGPathEOFillStroke			= 4;

	{	 Drawing modes for text. 	}

TYPE
	CGTextDrawingMode 			= SInt32;
CONST
	kCGTextFill					= 0;
	kCGTextStroke				= 1;
	kCGTextFillStroke			= 2;
	kCGTextInvisible			= 3;
	kCGTextFillClip				= 4;
	kCGTextStrokeClip			= 5;
	kCGTextFillStrokeClip		= 6;
	kCGTextClip					= 7;

	{	 Text encodings. 	}

TYPE
	CGTextEncoding 				= SInt32;
CONST
	kCGEncodingFontSpecific		= 0;
	kCGEncodingMacRoman			= 1;


TYPE
	CGInterpolationQuality 		= SInt32;
CONST
	kCGInterpolationDefault		= 0;							{  Let the context decide.  }
	kCGInterpolationNone		= 1;							{  Never interpolate.  }
	kCGInterpolationLow			= 2;							{  Fast, low quality.  }
	kCGInterpolationHigh		= 3;							{  Slow, high quality.  }


	{	* Graphics state functions. *	}
	{	 Push a copy of the current graphics state onto the graphics state
	 * stack. Note that the path is not considered part of the gstate, and is
	 * not saved. 	}
	{
	 *  CGContextSaveGState()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 and later
	 	}
PROCEDURE CGContextSaveGState(ctx: CGContextRef); C;

{ Restore the current graphics state from the one on the top of the
 * graphics state stack, popping the graphics state stack in the
 * process. }
{
 *  CGContextRestoreGState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextRestoreGState(ctx: CGContextRef); C;

{* Coordinate space transformations. *}
{ Scale the current graphics state's transformation matrix (the CTM) by
 * `(sx, sy)'. }
{
 *  CGContextScaleCTM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextScaleCTM(ctx: CGContextRef; sx: Single; sy: Single); C;

{ Translate the current graphics state's transformation matrix (the CTM)
 * by `(tx, ty)'. }
{
 *  CGContextTranslateCTM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextTranslateCTM(ctx: CGContextRef; tx: Single; ty: Single); C;

{ Rotate the current graphics state's transformation matrix (the CTM) by
 * `angle' radians. }
{
 *  CGContextRotateCTM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextRotateCTM(ctx: CGContextRef; angle: Single); C;

{ Concatenate the current graphics state's transformation matrix (the CTM)
 * with the affine transform `transform'. }
{
 *  CGContextConcatCTM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextConcatCTM(ctx: CGContextRef; transform: CGAffineTransform); C;

{ Return the current graphics state's transformation matrix. }
{
 *  CGContextGetCTM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextGetCTM(ctx: CGContextRef): CGAffineTransform; C;

{* Drawing attribute functions. *}
{ Set the line width in the current graphics state to `width'. }
{
 *  CGContextSetLineWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetLineWidth(ctx: CGContextRef; width: Single); C;

{ Set the line cap in the current graphics state to `cap'. }
{
 *  CGContextSetLineCap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetLineCap(ctx: CGContextRef; cap: CGLineCap); C;

{ Set the line join in the current graphics state to `join'. }
{
 *  CGContextSetLineJoin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetLineJoin(ctx: CGContextRef; join: CGLineJoin); C;

{ Set the miter limit in the current graphics state to `limit'. }
{
 *  CGContextSetMiterLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetMiterLimit(ctx: CGContextRef; limit: Single); C;

{ Set the line dash patttern in the current graphics state. }
{
 *  CGContextSetLineDash()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetLineDash(ctx: CGContextRef; phase: Single; {CONST}VAR lengths: Single; count: size_t); C;

{ Set the path flatness parameter in the current graphics state to
 * `flatness'. }
{
 *  CGContextSetFlatness()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetFlatness(ctx: CGContextRef; flatness: Single); C;

{ Set the alpha value in the current graphics state to `alpha'. }
{
 *  CGContextSetAlpha()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetAlpha(ctx: CGContextRef; alpha: Single); C;

{* Path construction functions. *}
{ Note that a context has a single path in use at any time: a path is not
 * part of the graphics state. }
{ Begin a new path.  The old path is discarded. }
{
 *  CGContextBeginPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextBeginPath(ctx: CGContextRef); C;

{ Start a new subpath at point `(x, y)' in the context's path. }
{
 *  CGContextMoveToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextMoveToPoint(ctx: CGContextRef; x: Single; y: Single); C;

{ Append a straight line segment from the current point to `(x, y)'. }
{
 *  CGContextAddLineToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddLineToPoint(ctx: CGContextRef; x: Single; y: Single); C;

{ Append a cubic Bezier curve from the current point to `(x,y)', with
 * control points `(cp1x, cp1y)' and `(cp2x, cp2y)'. }
{
 *  CGContextAddCurveToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddCurveToPoint(ctx: CGContextRef; cp1x: Single; cp1y: Single; cp2x: Single; cp2y: Single; x: Single; y: Single); C;

{ Append a quadratic curve from the current point to `(x, y)', with
 * control point `(cpx, cpy)'. }
{
 *  CGContextAddQuadCurveToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddQuadCurveToPoint(ctx: CGContextRef; cpx: Single; cpy: Single; x: Single; y: Single); C;

{ Close the current subpath of the context's path. }
{
 *  CGContextClosePath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextClosePath(ctx: CGContextRef); C;

{* Path construction convenience functions. *}
{ Add a single rect to the context's path. }
{
 *  CGContextAddRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddRect(ctx: CGContextRef; rect: CGRect); C;

{ Add a set of rects to the context's path. }
{
 *  CGContextAddRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddRects(ctx: CGContextRef; {CONST}VAR rects: CGRect; count: size_t); C;

{ Add a set of lines to the context's path. }
{
 *  CGContextAddLines()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddLines(ctx: CGContextRef; {CONST}VAR points: CGPoint; count: size_t); C;

{ Add an arc of a circle to the context's path, possibly preceded by a
 * straight line segment.  `(x, y)' is the center of the arc; `radius' is
 * its radius; `startAngle' is the angle to the first endpoint of the arc;
 * `endAngle' is the angle to the second endpoint of the arc; and
 * `clockwise' is 1 if the arc is to be drawn clockwise, 0 otherwise.
 * `startAngle' and `endAngle' are measured in radians. }
{
 *  CGContextAddArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddArc(ctx: CGContextRef; x: Single; y: Single; radius: Single; startAngle: Single; endAngle: Single; clockwise: LONGINT); C;

{ Add an arc of a circle to the context's path, possibly preceded by a
 * straight line segment.  `radius' is the radius of the arc.  The arc is
 * tangent to the line from the current point to `(x1, y1)', and the line
 * from `(x1, y1)' to `(x2, y2)'. }
{
 *  CGContextAddArcToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextAddArcToPoint(ctx: CGContextRef; x1: Single; y1: Single; x2: Single; y2: Single; radius: Single); C;

{* Path information functions. *}
{ Return 1 if the context's path contains no elements, 0 otherwise. }
{
 *  CGContextIsPathEmpty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextIsPathEmpty(ctx: CGContextRef): LONGINT; C;

{ Return the current point of the current subpath of the context's
 * path. }
{
 *  CGContextGetPathCurrentPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextGetPathCurrentPoint(ctx: CGContextRef): CGPoint; C;

{ Return the bounding box of the context's path.  The bounding box is the
 * smallest rectangle completely enclosing all points in the path,
 * including control points for Bezier and quadratic curves. }
{
 *  CGContextGetPathBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextGetPathBoundingBox(ctx: CGContextRef): CGRect; C;

{* Path drawing functions. *}
{ Draw the context's path using drawing mode `mode'. }
{
 *  CGContextDrawPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextDrawPath(ctx: CGContextRef; mode: CGPathDrawingMode); C;

{* Path drawing convenience functions. *}
{ Fill the context's path using the winding-number fill rule.  Any open
 * subpath of the path is implicitly closed. }
{
 *  CGContextFillPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextFillPath(ctx: CGContextRef); C;

{ Fill the context's path using the even-odd fill rule.  Any open subpath
 * of the path is implicitly closed. }
{
 *  CGContextEOFillPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextEOFillPath(ctx: CGContextRef); C;

{ Stroke the context's path. }
{
 *  CGContextStrokePath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextStrokePath(ctx: CGContextRef); C;

{ Fill `rect' with the current fill color. }
{
 *  CGContextFillRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextFillRect(ctx: CGContextRef; rect: CGRect); C;

{ Fill `rects', an array of `count' CGRects, with the current fill
 * color. }
{
 *  CGContextFillRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextFillRects(ctx: CGContextRef; {CONST}VAR rects: CGRect; count: size_t); C;

{ Stroke `rect' with the current stroke color and the current linewidth. }
{
 *  CGContextStrokeRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextStrokeRect(ctx: CGContextRef; rect: CGRect); C;

{ Stroke `rect' with the current stroke color, using `width' as the the
 * line width. }
{
 *  CGContextStrokeRectWithWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextStrokeRectWithWidth(ctx: CGContextRef; rect: CGRect; width: Single); C;

{ Clear `rect' (that is, set the region within the rect to
 * transparent). }
{
 *  CGContextClearRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextClearRect(c: CGContextRef; rect: CGRect); C;

{* Clipping functions. *}
{ Intersect the context's path with the current clip path and use the
 * resulting path as the clip path for subsequent rendering operations.
 * Use the winding-number fill rule for deciding what's inside the path. }
{
 *  CGContextClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextClip(ctx: CGContextRef); C;

{ Intersect the context's path with the current clip path and use the
 * resulting path as the clip path for subsequent rendering operations.
 * Use the even-odd fill rule for deciding what's inside the path. }
{
 *  CGContextEOClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextEOClip(ctx: CGContextRef); C;

{* Clipping convenience functions. *}
{ Intersect the current clipping path with `rect'.  Note that this
 * function resets the context's path to the empty path. }
{
 *  CGContextClipToRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextClipToRect(ctx: CGContextRef; rect: CGRect); C;

{ Intersect the current clipping path with the clipping region formed by
 * creating a path consisting of all rects in `rects'.  Note that this
 * function resets the context's path to the empty path. }
{
 *  CGContextClipToRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextClipToRects(ctx: CGContextRef; {CONST}VAR rects: CGRect; count: size_t); C;

{* Colorspace functions. *}
{ Set the components of the current fill color in the context `ctx' to the
 * values specifed by `components'.  The number of elements in `components'
 * must be one greater than the number of components in the current fill
 * colorspace (N color components + 1 alpha component).  The current fill
 * colorspace must not be a pattern colorspace. }
{
 *  CGContextSetFillColorSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetFillColorSpace(ctx: CGContextRef; colorspace: CGColorSpaceRef); C;

{ Set the components of the current fill color in the context `ctx' to the
 * values specifed by `components'.  The number of elements in `components'
 * must be one greater than the number of components in the current fill
 * colorspace (N color components + 1 alpha component).  The current fill
 * colorspace must not be a pattern colorspace. }
{
 *  CGContextSetStrokeColorSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetStrokeColorSpace(ctx: CGContextRef; colorspace: CGColorSpaceRef); C;

{* Color functions. *}
{ Set the components of the current fill color in the context `c' to the
 * values specifed by `components'.  The number of elements in `components'
 * must be one greater than the number of components in the current fill
 * colorspace (N color components + 1 alpha component).  The current fill
 * colorspace must not be a pattern colorspace. }
{
 *  CGContextSetFillColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetFillColor(c: CGContextRef; {CONST}VAR components: Single); C;

{ Set the components of the current stroke color in the context `c' to the
 * values specifed by `components'.  The number of elements in `components'
 * must be one greater than the number of components in the current stroke
 * colorspace (N color components + 1 alpha component).  The current stroke
 * colorspace must not be a pattern colorspace. }
{
 *  CGContextSetStrokeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetStrokeColor(c: CGContextRef; {CONST}VAR components: Single); C;

{* Pattern functions. *}
{ Set the components of the current fill color in the context `c' to the
 * values specifed by `components', and set the current fill pattern to
 * `pattern'.  The number of elements in `components' must be one greater
 * than the number of components in the current fill colorspace (N color
 * components + 1 alpha component).  The current fill colorspace must be a
 * pattern colorspace. }
{
 *  CGContextSetFillPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
PROCEDURE CGContextSetFillPattern(c: CGContextRef; pattern: CGPatternRef; {CONST}VAR components: Single); C;

{ Set the components of the current stroke color in the context `c' to the
 * values specifed by `components', and set the current stroke pattern to
 * `pattern'.  The number of elements in `components' must be one greater
 * than the number of components in the current stroke colorspace (N color
 * components + 1 alpha component).  The current stroke colorspace must be
 * a pattern colorspace. }
{
 *  CGContextSetStrokePattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
PROCEDURE CGContextSetStrokePattern(c: CGContextRef; pattern: CGPatternRef; {CONST}VAR components: Single); C;


{* Color convenience functions. *}
{ Set the current fill colorspace in the context `c' to `DeviceGray' and
 * set the components of the current fill color to `(gray, alpha)'. }
{
 *  CGContextSetGrayFillColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetGrayFillColor(ctx: CGContextRef; gray: Single; alpha: Single); C;

{ Set the current stroke colorspace in the context `c' to `DeviceGray' and
 * set the components of the current stroke color to `(gray, alpha)'. }
{
 *  CGContextSetGrayStrokeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetGrayStrokeColor(ctx: CGContextRef; gray: Single; alpha: Single); C;

{ Set the current fill colorspace in the context `c' to `DeviceRGB' and
 * set the components of the current fill color to `(red, green, blue,
 * alpha)'. }
{
 *  CGContextSetRGBFillColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetRGBFillColor(ctx: CGContextRef; red: Single; green: Single; blue: Single; alpha: Single); C;

{ Set the current stroke colorspace in the context `c' to `DeviceRGB' and
 * set the components of the current stroke color to `(red, green, blue,
 * alpha)'. }
{
 *  CGContextSetRGBStrokeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetRGBStrokeColor(ctx: CGContextRef; red: Single; green: Single; blue: Single; alpha: Single); C;

{ Set the current fill colorspace in the context `c' to `DeviceCMYK' and
 * set the components of the current fill color to `(cyan, magenta, yellow,
 * black, alpha)'. }
{
 *  CGContextSetCMYKFillColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetCMYKFillColor(ctx: CGContextRef; cyan: Single; magenta: Single; yellow: Single; black: Single; alpha: Single); C;

{ Set the current stroke colorspace in the context `c' to `DeviceCMYK' and
 * set the components of the current stroke color to `(cyan, magenta,
 * yellow, black, alpha)'. }
{
 *  CGContextSetCMYKStrokeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetCMYKStrokeColor(ctx: CGContextRef; cyan: Single; magenta: Single; yellow: Single; black: Single; alpha: Single); C;

{* Rendering intent. *}
{ Set the rendering intent in the graphics state to `intent'. }
{
 *  CGContextSetRenderingIntent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetRenderingIntent(c: CGContextRef; intent: CGColorRenderingIntent); C;

{* Image functions. *}
{ Draw `image' in the rectangular area specified by `rect'.  The image is
 * scaled, if necessary, to fit into `rect'. }
{
 *  CGContextDrawImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextDrawImage(ctx: CGContextRef; rect: CGRect; image: CGImageRef); C;

{ Return the interpolation quality for image rendering of the context `c'.
 * The interpolation quality is a gstate-parameter which controls the level
 * of interpolation performed when an image is interpolated (for example,
 * when scaling the image). Note that it is merely a hint to the context:
 * not all contexts support all interpolation quality levels. }
{
 *  CGContextGetInterpolationQuality()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION CGContextGetInterpolationQuality(c: CGContextRef): CGInterpolationQuality; C;

{ Set the interpolation quality of the context `c' to `quality'. }
{
 *  CGContextSetInterpolationQuality()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
PROCEDURE CGContextSetInterpolationQuality(c: CGContextRef; quality: CGInterpolationQuality); C;


{* Text functions. *}
{ Set the current character spacing in the context `ctx' to `spacing'.  The
 * character spacing is added to the displacement between the origin of one
 * character and the origin of the next. }
{
 *  CGContextSetCharacterSpacing()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetCharacterSpacing(ctx: CGContextRef; spacing: Single); C;

{ Set the user-space point at which text will be drawn to (x,y). }
{
 *  CGContextSetTextPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetTextPosition(ctx: CGContextRef; x: Single; y: Single); C;

{ Return the current user-space point at which text will be drawn to (x,y). }
{
 *  CGContextGetTextPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextGetTextPosition(ctx: CGContextRef): CGPoint; C;

{ Set the text matrix to `transform'. }
{
 *  CGContextSetTextMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetTextMatrix(ctx: CGContextRef; transform: CGAffineTransform); C;

{ Return the text matrix. }
{
 *  CGContextGetTextMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextGetTextMatrix(ctx: CGContextRef): CGAffineTransform; C;

{ Set the text drawing mode to `mode'. }
{
 *  CGContextSetTextDrawingMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetTextDrawingMode(ctx: CGContextRef; mode: CGTextDrawingMode); C;

{ Set the current font to `font'. }
{
 *  CGContextSetFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetFont(ctx: CGContextRef; font: CGFontRef); C;

{ Set the current font size to `size'. }
{
 *  CGContextSetFontSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetFontSize(ctx: CGContextRef; size: Single); C;


{ Attempts to find the font named `name'.  If successful, scales it to
 * `size' units in user space.  `textEncoding' specifies how to translate
 * from bytes to glyphs. }
{
 *  CGContextSelectFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSelectFont(ctx: CGContextRef; name: ConstCStringPtr; size: Single; textEncoding: CGTextEncoding); C;

{ Draw `string', a string of `length' bytes, at the point specified by the
 * current text matrix.  Each byte of the string is mapped through the
 * encoding vector of the current font to obtain the glyph to display. }
{
 *  CGContextShowText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextShowText(ctx: CGContextRef; cstring: ConstCStringPtr; length: size_t); C;

{ Draw the glyphs pointed to by `g', an array of `count' glyphs, at the
 * point specified by the current text matrix. }
{
 *  CGContextShowGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextShowGlyphs(ctx: CGContextRef; {CONST}VAR g: CGGlyph; count: size_t); C;


{* Text convenience functions. *}
{ Draw `string', a string of `length' bytes, at the point `(x, y)',
 * specified in user space.  Each byte of the string is mapped through the
 * encoding vector of the current font to obtain the glyph to display. }
{
 *  CGContextShowTextAtPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextShowTextAtPoint(ctx: CGContextRef; x: Single; y: Single; cstring: ConstCStringPtr; length: size_t); C;

{ Display the glyphs pointed to by `g', an array of `count' glyph ids, at
 * the point `(x, y)', specified in user space. }
{
 *  CGContextShowGlyphsAtPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextShowGlyphsAtPoint(ctx: CGContextRef; x: Single; y: Single; {CONST}VAR g: CGGlyph; count: size_t); C;


{* PDF document functions. *}
{ Draw `page' in `document' in the rectangular area specified by `rect'.
 * The media box of the page is scaled, if necessary, to fit into
 * `rect'. }
{
 *  CGContextDrawPDFDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextDrawPDFDocument(ctx: CGContextRef; rect: CGRect; document: CGPDFDocumentRef; page: LONGINT); C;

{* Page functions. *}
{ Begin a new page. }
{
 *  CGContextBeginPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextBeginPage(ctx: CGContextRef; {CONST}VAR mediaBox: CGRect); C;

{ End the current page. }
{
 *  CGContextEndPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextEndPage(ctx: CGContextRef); C;

{* Context functions. *}
{ Increment the retain count of `ctx' and return it.  All contexts are
 * created with an initial retain count of 1. }
{
 *  CGContextRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGContextRetain(ctx: CGContextRef): CGContextRef; C;

{ Decrement the retain count of `ctx'.  If the retain count reaches 0,
 * then free `ctx' and any associated resources. }
{
 *  CGContextRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextRelease(ctx: CGContextRef); C;

{ Flush all drawing to the destination. }
{
 *  CGContextFlush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextFlush(ctx: CGContextRef); C;

{ Synchronized drawing. }
{
 *  CGContextSynchronize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSynchronize(ctx: CGContextRef); C;

{* Antialiasing functions. *}
{ Turn off antialiasing if `shouldAntialias' is zero; turn it on
 * otherwise.  This parameter is part of the graphics state. }
{
 *  CGContextSetShouldAntialias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGContextSetShouldAntialias(ctx: CGContextRef; shouldAntialias: LONGINT); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGContextIncludes}

{$ENDC} {__CGCONTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}