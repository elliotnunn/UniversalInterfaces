{
 	File:		QuickdrawText.p
 
 	Contains:	Quickdraw Text Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1983-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickdrawText;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$SETC __QUICKDRAWTEXT__ := 1}

{$I+}
{$SETC QuickdrawTextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ new CGrafPort bottleneck ("newProc2") function, used in Unicode Text drawing }
FUNCTION StandardGlyphs(dataStream: UNIV Ptr; size: ByteCount): OSStatus; C;


CONST
																{  CharToPixel directions  }
	leftCaret					= 0;							{ Place caret for left block }
	rightCaret					= -1;							{ Place caret for right block }
	kHilite						= 1;							{ Direction is SysDirection }
	smLeftCaret					= 0;							{ Place caret for left block - obsolete  }
	smRightCaret				= -1;							{ Place caret for right block - obsolete  }
	smHilite					= 1;							{ Direction is TESysJust - obsolete  }

																{ Constants for styleRunPosition argument in PortionLine, DrawJustified, MeasureJustified, CharToPixel, and PixelToChar. }
	onlyStyleRun				= 0;							{  This is the only style run on the line  }
	leftStyleRun				= 1;							{  This is leftmost of multiple style runs on the line  }
	rightStyleRun				= 2;							{  This is rightmost of multiple style runs on the line  }
	middleStyleRun				= 3;							{  There are multiple style runs on the line and this is neither the leftmost nor the rightmost.  }
	smOnlyStyleRun				= 0;							{  obsolete  }
	smLeftStyleRun				= 1;							{  obsolete  }
	smRightStyleRun				= 2;							{  obsolete  }
	smMiddleStyleRun			= 3;							{  obsolete  }

{ type for styleRunPosition parameter in PixelToChar etc. }

TYPE
	JustStyleCode						= INTEGER;
	FontInfoPtr = ^FontInfo;
	FontInfo = RECORD
		ascent:					INTEGER;
		descent:				INTEGER;
		widMax:					INTEGER;
		leading:				INTEGER;
	END;

	FormatOrder							= ARRAY [0..0] OF INTEGER;
	FormatOrderPtr						= ^FormatOrder;
{ FormatStatus was moved to TextUtils.i }
	OffPairPtr = ^OffPair;
	OffPair = RECORD
		offFirst:				INTEGER;
		offSecond:				INTEGER;
	END;

	OffsetTable							= ARRAY [0..2] OF OffPair;
{$IFC TYPED_FUNCTION_POINTERS}
	StyleRunDirectionProcPtr = FUNCTION(styleRunIndex: INTEGER; dirParam: UNIV Ptr): BOOLEAN;
{$ELSEC}
	StyleRunDirectionProcPtr = ProcPtr;
{$ENDC}

	StyleRunDirectionUPP = UniversalProcPtr;

CONST
	uppStyleRunDirectionProcInfo = $00000390;

FUNCTION NewStyleRunDirectionProc(userRoutine: StyleRunDirectionProcPtr): StyleRunDirectionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallStyleRunDirectionProc(styleRunIndex: INTEGER; dirParam: UNIV Ptr; userRoutine: StyleRunDirectionUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION Pixel2Char(textBuf: Ptr; textLen: INTEGER; slop: INTEGER; pixelWidth: INTEGER; VAR leadingEdge: BOOLEAN): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820E, $0014, $A8B5;
	{$ENDC}
FUNCTION Char2Pixel(textBuf: Ptr; textLen: INTEGER; slop: INTEGER; offset: INTEGER; direction: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $0016, $A8B5;
	{$ENDC}
FUNCTION PixelToChar(textBuf: Ptr; textLength: LONGINT; slop: Fixed; pixelWidth: Fixed; VAR leadingEdge: BOOLEAN; VAR widthRemaining: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8222, $002E, $A8B5;
	{$ENDC}
FUNCTION CharToPixel(textBuf: Ptr; textLength: LONGINT; slop: Fixed; offset: LONGINT; direction: INTEGER; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $821C, $0030, $A8B5;
	{$ENDC}
PROCEDURE DrawJustified(textPtr: Ptr; textLength: LONGINT; slop: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8016, $0032, $A8B5;
	{$ENDC}
PROCEDURE MeasureJustified(textPtr: Ptr; textLength: LONGINT; slop: Fixed; charLocs: Ptr; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $801A, $0034, $A8B5;
	{$ENDC}
FUNCTION PortionLine(textPtr: Ptr; textLen: LONGINT; styleRunPosition: JustStyleCode; numer: Point; denom: Point): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8412, $0036, $A8B5;
	{$ENDC}
PROCEDURE HiliteText(textPtr: Ptr; textLength: INTEGER; firstOffset: INTEGER; secondOffset: INTEGER; VAR offsets: OffsetTable);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $800E, $001C, $A8B5;
	{$ENDC}
PROCEDURE DrawJust(textPtr: Ptr; textLength: INTEGER; slop: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8008, $001E, $A8B5;
	{$ENDC}
PROCEDURE MeasureJust(textPtr: Ptr; textLength: INTEGER; slop: INTEGER; charLocs: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $800C, $0020, $A8B5;
	{$ENDC}
FUNCTION PortionText(textPtr: Ptr; textLength: LONGINT): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8408, $0024, $A8B5;
	{$ENDC}
FUNCTION VisibleLength(textPtr: Ptr; textLength: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8408, $0028, $A8B5;
	{$ENDC}
PROCEDURE GetFormatOrder(ordering: FormatOrderPtr; firstFormat: INTEGER; lastFormat: INTEGER; lineRight: BOOLEAN; rlDirProc: StyleRunDirectionUPP; dirParam: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8012, $FFFC, $A8B5;
	{$ENDC}


PROCEDURE TextFont(font: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A887;
	{$ENDC}
PROCEDURE TextFace(face: StyleParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A888;
	{$ENDC}
PROCEDURE TextMode(mode: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A889;
	{$ENDC}
PROCEDURE TextSize(size: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88A;
	{$ENDC}
PROCEDURE SpaceExtra(extra: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88E;
	{$ENDC}
PROCEDURE DrawChar(ch: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A883;
	{$ENDC}
PROCEDURE DrawString(s: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A884;
	{$ENDC}
PROCEDURE DrawText(textBuf: UNIV Ptr; firstByte: INTEGER; byteCount: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A885;
	{$ENDC}
FUNCTION CharWidth(ch: CharParameter): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88D;
	{$ENDC}
FUNCTION StringWidth(s: Str255): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88C;
	{$ENDC}
FUNCTION TextWidth(textBuf: UNIV Ptr; firstByte: INTEGER; byteCount: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A886;
	{$ENDC}
PROCEDURE MeasureText(count: INTEGER; textAddr: UNIV Ptr; charLocs: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A837;
	{$ENDC}
PROCEDURE GetFontInfo(VAR info: FontInfo);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88B;
	{$ENDC}
PROCEDURE CharExtra(extra: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA23;
	{$ENDC}
PROCEDURE StdText(count: INTEGER; textAddr: UNIV Ptr; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A882;
	{$ENDC}
FUNCTION StdTxMeas(byteCount: INTEGER; textAddr: UNIV Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8ED;
	{$ENDC}

{$IFC OLDROUTINENAMES }
FUNCTION NPixel2Char(textBuf: Ptr; textLength: LONGINT; slop: Fixed; pixelWidth: Fixed; VAR leadingEdge: BOOLEAN; VAR widthRemaining: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8222, $002E, $A8B5;
	{$ENDC}
FUNCTION NChar2Pixel(textBuf: Ptr; textLength: LONGINT; slop: Fixed; offset: LONGINT; direction: INTEGER; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $821C, $0030, $A8B5;
	{$ENDC}
PROCEDURE NDrawJust(textPtr: Ptr; textLength: LONGINT; slop: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8016, $0032, $A8B5;
	{$ENDC}
PROCEDURE NMeasureJust(textPtr: Ptr; textLength: LONGINT; slop: Fixed; charLocs: Ptr; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $801A, $0034, $A8B5;
	{$ENDC}
FUNCTION NPortionText(textPtr: Ptr; textLen: LONGINT; styleRunPosition: JustStyleCode; numer: Point; denom: Point): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8412, $0036, $A8B5;
	{$ENDC}
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickdrawTextIncludes}

{$ENDC} {__QUICKDRAWTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
