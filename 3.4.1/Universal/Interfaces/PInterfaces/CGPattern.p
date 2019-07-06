{
     File:       CGPattern.p
 
     Contains:   CoreGraphics patterns
 
     Version:    Technology: CoreGraphics-122 (Mac OS X 10.1)
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGPattern;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGPATTERN__}
{$SETC __CGPATTERN__ := 1}

{$I+}
{$SETC CGPatternIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}



{ kCGPatternTilingNoDistortion: The pattern cell is not distorted when
 * painted, however the spacing between pattern cells may vary by as much
 * as 1 device pixel.
 *
 * kCGPatternTilingConstantSpacingMinimalDistortion: Pattern cells are
 * spaced consistently, however the pattern cell may be distorted by as
 * much as 1 device pixel when the pattern is painted.
 *
 * kCGPatternTilingConstantSpacing: Pattern cells are spaced consistently
 * as with kCGPatternTilingConstantSpacingMinimalDistortion, however the
 * pattern cell may be distorted additionally to permit a more efficient
 * implementation. }

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGPatternTiling 			= SInt32;
CONST
	kCGPatternTilingNoDistortion = 0;
	kCGPatternTilingConstantSpacingMinimalDistortion = 1;
	kCGPatternTilingConstantSpacing = 2;


	{	 The drawing of the pattern is delegated to the callbacks.  The callbacks
	 * may be called one or many times to draw the pattern.
	 *
	 * `version' is the version number of the structure passed in as a
	 * parameter to the CGPattern creation functions. The structure defined
	 * below is version 0.
	 *
	 * `drawPattern' should draw the pattern in the context `c'. `info' is the
	 * parameter originally passed to the CGPattern creation functions.
	 *
	 * `releaseInfo' is called when the pattern is deallocated. 	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CGDrawPatternProcPtr = PROCEDURE(info: UNIV Ptr; c: CGContextRef); C;
{$ELSEC}
	CGDrawPatternProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGReleaseInfoProcPtr = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CGReleaseInfoProcPtr = ProcPtr;
{$ENDC}

	CGPatternCallbacksPtr = ^CGPatternCallbacks;
	CGPatternCallbacks = RECORD
		version:				UInt32;
		drawPattern:			CGDrawPatternProcPtr;
		releaseInfo:			CGReleaseInfoProcPtr;
	END;

	{	 Create a pattern. 	}
	{
	 *  CGPatternCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.1 and later
	 	}
FUNCTION CGPatternCreate(info: UNIV Ptr; bounds: CGRect; matrix: CGAffineTransform; xStep: Single; yStep: Single; tiling: CGPatternTiling; isColored: LONGINT; {CONST}VAR callbacks: CGPatternCallbacks): CGPatternRef; C;

{ Increment the retain count of `pattern' and return it.  All patterns are
 * created with an initial retain count of 1. }
{
 *  CGPatternRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION CGPatternRetain(pattern: CGPatternRef): CGPatternRef; C;

{ Decrement the retain count of `pattern'.  If the retain count reaches 0,
 * then free it and release any associated resources. }
{
 *  CGPatternRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
PROCEDURE CGPatternRelease(pattern: CGPatternRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGPatternIncludes}

{$ENDC} {__CGPATTERN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
