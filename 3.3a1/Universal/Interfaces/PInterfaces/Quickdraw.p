{
 	File:		Quickdraw.p
 
 	Contains:	Interface to Quickdraw Graphics
 
 	Version:	Technology:	Mac OS 8.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1985-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Quickdraw;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKDRAW__}
{$SETC __QUICKDRAW__ := 1}

{$I+}
{$SETC QuickdrawIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$I QuickdrawText.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	invalColReq					= -1;							{ invalid color table request }

																{  transfer modes  }
	srcCopy						= 0;							{ the 16 transfer modes }
	srcOr						= 1;
	srcXor						= 2;
	srcBic						= 3;
	notSrcCopy					= 4;
	notSrcOr					= 5;
	notSrcXor					= 6;
	notSrcBic					= 7;
	patCopy						= 8;
	patOr						= 9;
	patXor						= 10;
	patBic						= 11;
	notPatCopy					= 12;
	notPatOr					= 13;
	notPatXor					= 14;
	notPatBic					= 15;							{  Special Text Transfer Mode  }
	grayishTextOr				= 49;
	hilitetransfermode			= 50;
	hilite						= 50;							{  Arithmetic transfer modes  }
	blend						= 32;
	addPin						= 33;
	addOver						= 34;
	subPin						= 35;
	addMax						= 37;
	adMax						= 37;
	subOver						= 38;
	adMin						= 39;
	ditherCopy					= 64;							{  Transparent mode constant  }
	transparent					= 36;

	italicBit					= 1;
	ulineBit					= 2;
	outlineBit					= 3;
	shadowBit					= 4;
	condenseBit					= 5;
	extendBit					= 6;

																{  QuickDraw color separation constants  }
	normalBit					= 0;							{ normal screen mapping }
	inverseBit					= 1;							{ inverse screen mapping }
	redBit						= 4;							{ RGB additive mapping }
	greenBit					= 3;
	blueBit						= 2;
	cyanBit						= 8;							{ CMYBk subtractive mapping }
	magentaBit					= 7;
	yellowBit					= 6;
	blackBit					= 5;

	blackColor					= 33;							{ colors expressed in these mappings }
	whiteColor					= 30;
	redColor					= 205;
	greenColor					= 341;
	blueColor					= 409;
	cyanColor					= 273;
	magentaColor				= 137;
	yellowColor					= 69;

	picLParen					= 0;							{ standard picture comments }
	picRParen					= 1;
	clutType					= 0;							{ 0 if lookup table }
	fixedType					= 1;							{ 1 if fixed table }
	directType					= 2;							{ 2 if direct values }
	gdDevType					= 0;							{ 0 = monochrome 1 = color }

	interlacedDevice			= 2;							{  1 if single pixel lines look bad  }
	roundedDevice				= 5;							{  1 if device has been “rounded” into the GrayRgn  }
	hasAuxMenuBar				= 6;							{  1 if device has an aux menu bar on it  }
	burstDevice					= 7;
	ext32Device					= 8;
	ramInit						= 10;							{ 1 if initialized from 'scrn' resource }
	mainScreen					= 11;							{  1 if main screen  }
	allInit						= 12;							{  1 if all devices initialized  }
	screenDevice				= 13;							{ 1 if screen device [not used] }
	noDriver					= 14;							{  1 if no driver for this GDevice  }
	screenActive				= 15;							{ 1 if in use }
	hiliteBit					= 7;							{ flag bit in HiliteMode (lowMem flag) }
	pHiliteBit					= 0;							{ flag bit in HiliteMode used with BitClr procedure }
	defQDColors					= 127;							{ resource ID of clut for default QDColors }
																{  pixel type  }
	RGBDirect					= 16;							{  16 & 32 bits/pixel pixelType value  }
																{  pmVersion values  }
	baseAddr32					= 4;							{ pixmap base address is 32-bit address }


	sysPatListID				= 0;
	iBeamCursor					= 1;
	crossCursor					= 2;
	plusCursor					= 3;
	watchCursor					= 4;

	kQDGrafVerbFrame			= 0;
	kQDGrafVerbPaint			= 1;
	kQDGrafVerbErase			= 2;
	kQDGrafVerbInvert			= 3;
	kQDGrafVerbFill				= 4;

{$IFC OLDROUTINENAMES }
	frame						= 0;
	paint						= 1;
	erase						= 2;
	invert						= 3;
	fill						= 4;

{$ENDC}  {OLDROUTINENAMES}


TYPE
	GrafVerb							= SInt8;

CONST
	chunky						= 0;
	chunkyPlanar				= 1;
	planar						= 2;


TYPE
	PixelType							= SInt8;
	Bits16								= ARRAY [0..15] OF INTEGER;

{**************   IMPORTANT NOTE REGARDING Pattern  **************************************
   Patterns were originally defined as:
   
		C: 			typedef unsigned char Pattern[8];
		Pascal:		Pattern = PACKED ARRAY [0..7] OF 0..255;
		
   The old array definition of Pattern would cause 68000 based CPU's to crash in certain circum-
   stances. The new struct definition is safe, but may require source code changes to compile.
	
********************************************************************************************}
	PatternPtr = ^Pattern;
	Pattern = RECORD
		pat:					PACKED ARRAY [0..7] OF UInt8;
	END;

	PatPtr								= ^Pattern;
	PatHandle							= ^PatPtr;
	QDByte								= SignedByte;
	QDPtr								= Ptr;
	QDHandle							= Handle;
	QDErr								= INTEGER;

CONST
	singleDevicesBit			= 0;
	dontMatchSeedsBit			= 1;
	allDevicesBit				= 2;

	singleDevices				= $01;
	dontMatchSeeds				= $02;
	allDevices					= $04;


TYPE
	DeviceLoopFlags						= UInt32;
{
	PrinterStatusOpcode.  For communication with downloading and printing services.
}
	PrinterStatusOpcode					= SInt32;

CONST
	kPrinterFontStatus			= 0;
	kPrinterScalingStatus		= 1;


TYPE
	PrinterFontStatusPtr = ^PrinterFontStatus;
	PrinterFontStatus = RECORD
		oResult:				SInt32;
		iFondID:				SInt16;
		iStyle:					SInt8;
	END;

	PrinterScalingStatusPtr = ^PrinterScalingStatus;
	PrinterScalingStatus = RECORD
		oScalingFactors:		Point;
	END;

	BitMapPtr = ^BitMap;
	BitMap = RECORD
		baseAddr:				Ptr;
		rowBytes:				INTEGER;
		bounds:					Rect;
	END;

	BitMapHandle						= ^BitMapPtr;
	CursorPtr = ^Cursor;
	Cursor = RECORD
		data:					Bits16;
		mask:					Bits16;
		hotSpot:				Point;
	END;

	CursPtr								= ^Cursor;
	CursHandle							= ^CursPtr;
	PenStatePtr = ^PenState;
	PenState = RECORD
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPat:					Pattern;
	END;

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	MacRegionPtr = ^MacRegion;
	MacRegion = RECORD
		rgnSize:				UInt16;									{ size in bytes }
		rgnBBox:				Rect;									{ enclosing rectangle }
	END;

{
	The type name "Region" has a name space collision on Win32.
	Use MacRegion to be cross-platfrom safe.
}
{$IFC TARGET_OS_MAC }
	Region								= MacRegion;
	RegionPtr 							= ^Region;
{$ENDC}  {TARGET_OS_MAC}
	RgnPtr								= ^MacRegion;
	RgnHandle							= ^RgnPtr;
{$ELSEC}
	RgnHandle = ^LONGINT; { an opaque 32-bit type }
{$ENDC}

	PicturePtr = ^Picture;
	Picture = RECORD
		picSize:				INTEGER;
		picFrame:				Rect;
	END;

	PicPtr								= ^Picture;
	PicHandle							= ^PicPtr;
	MacPolygonPtr = ^MacPolygon;
	MacPolygon = RECORD
		polySize:				INTEGER;
		polyBBox:				Rect;
		polyPoints:				ARRAY [0..0] OF Point;
	END;

{
	The type name "Polygon" has a name space collision on Win32.
	Use MacPolygon to be cross-platfrom safe.
}
{$IFC TARGET_OS_MAC }
	Polygon								= MacPolygon;
	PolygonPtr 							= ^Polygon;
{$ENDC}  {TARGET_OS_MAC}

	PolyPtr								= ^MacPolygon;
	PolyHandle							= ^PolyPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	QDTextProcPtr = PROCEDURE(byteCount: INTEGER; textBuf: Ptr; numer: Point; denom: Point);
{$ELSEC}
	QDTextProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDLineProcPtr = PROCEDURE(newPt: Point);
{$ELSEC}
	QDLineProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDRectProcPtr = PROCEDURE(verb: GrafVerb; VAR r: Rect);
{$ELSEC}
	QDRectProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDRRectProcPtr = PROCEDURE(verb: GrafVerb; VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
{$ELSEC}
	QDRRectProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDOvalProcPtr = PROCEDURE(verb: GrafVerb; VAR r: Rect);
{$ELSEC}
	QDOvalProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDArcProcPtr = PROCEDURE(verb: GrafVerb; VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
{$ELSEC}
	QDArcProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPolyProcPtr = PROCEDURE(verb: GrafVerb; poly: PolyHandle);
{$ELSEC}
	QDPolyProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDRgnProcPtr = PROCEDURE(verb: GrafVerb; rgn: RgnHandle);
{$ELSEC}
	QDRgnProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDBitsProcPtr = PROCEDURE(VAR srcBits: BitMap; VAR srcRect: Rect; VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
{$ELSEC}
	QDBitsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDCommentProcPtr = PROCEDURE(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
{$ELSEC}
	QDCommentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDTxMeasProcPtr = FUNCTION(byteCount: INTEGER; textAddr: Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo): INTEGER;
{$ELSEC}
	QDTxMeasProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDGetPicProcPtr = PROCEDURE(dataPtr: Ptr; byteCount: INTEGER);
{$ELSEC}
	QDGetPicProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPutPicProcPtr = PROCEDURE(dataPtr: Ptr; byteCount: INTEGER);
{$ELSEC}
	QDPutPicProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDOpcodeProcPtr = PROCEDURE(VAR fromRect: Rect; VAR toRect: Rect; opcode: INTEGER; version: INTEGER);
{$ELSEC}
	QDOpcodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDStdGlyphsProcPtr = FUNCTION(dataStream: UNIV Ptr; size: ByteCount): OSStatus; C;
{$ELSEC}
	QDStdGlyphsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDJShieldCursorProcPtr = PROCEDURE(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
{$ELSEC}
	QDJShieldCursorProcPtr = ProcPtr;
{$ENDC}

	QDTextUPP = UniversalProcPtr;
	QDLineUPP = UniversalProcPtr;
	QDRectUPP = UniversalProcPtr;
	QDRRectUPP = UniversalProcPtr;
	QDOvalUPP = UniversalProcPtr;
	QDArcUPP = UniversalProcPtr;
	QDPolyUPP = UniversalProcPtr;
	QDRgnUPP = UniversalProcPtr;
	QDBitsUPP = UniversalProcPtr;
	QDCommentUPP = UniversalProcPtr;
	QDTxMeasUPP = UniversalProcPtr;
	QDGetPicUPP = UniversalProcPtr;
	QDPutPicUPP = UniversalProcPtr;
	QDOpcodeUPP = UniversalProcPtr;
	QDStdGlyphsUPP = UniversalProcPtr;
	QDJShieldCursorUPP = UniversalProcPtr;
	QDProcsPtr = ^QDProcs;
	QDProcs = RECORD
		textProc:				QDTextUPP;
		lineProc:				QDLineUPP;
		rectProc:				QDRectUPP;
		rRectProc:				QDRRectUPP;
		ovalProc:				QDOvalUPP;
		arcProc:				QDArcUPP;
		polyProc:				QDPolyUPP;
		rgnProc:				QDRgnUPP;
		bitsProc:				QDBitsUPP;
		commentProc:			QDCommentUPP;
		txMeasProc:				QDTxMeasUPP;
		getPicProc:				QDGetPicUPP;
		putPicProc:				QDPutPicUPP;
	END;


CONST
	uppQDTextProcInfo = $00003F80;
	uppQDLineProcInfo = $000000C0;
	uppQDRectProcInfo = $00000340;
	uppQDRRectProcInfo = $00002B40;
	uppQDOvalProcInfo = $00000340;
	uppQDArcProcInfo = $00002B40;
	uppQDPolyProcInfo = $00000340;
	uppQDRgnProcInfo = $00000340;
	uppQDBitsProcInfo = $0000EFC0;
	uppQDCommentProcInfo = $00000E80;
	uppQDTxMeasProcInfo = $0000FFA0;
	uppQDGetPicProcInfo = $000002C0;
	uppQDPutPicProcInfo = $000002C0;
	uppQDOpcodeProcInfo = $00002BC0;
	uppQDStdGlyphsProcInfo = $000003F1;
	uppQDJShieldCursorProcInfo = $00002A80;

FUNCTION NewQDTextUPP(userRoutine: QDTextProcPtr): QDTextUPP; { old name was NewQDTextProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDLineUPP(userRoutine: QDLineProcPtr): QDLineUPP; { old name was NewQDLineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDRectUPP(userRoutine: QDRectProcPtr): QDRectUPP; { old name was NewQDRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDRRectUPP(userRoutine: QDRRectProcPtr): QDRRectUPP; { old name was NewQDRRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDOvalUPP(userRoutine: QDOvalProcPtr): QDOvalUPP; { old name was NewQDOvalProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDArcUPP(userRoutine: QDArcProcPtr): QDArcUPP; { old name was NewQDArcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDPolyUPP(userRoutine: QDPolyProcPtr): QDPolyUPP; { old name was NewQDPolyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDRgnUPP(userRoutine: QDRgnProcPtr): QDRgnUPP; { old name was NewQDRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDBitsUPP(userRoutine: QDBitsProcPtr): QDBitsUPP; { old name was NewQDBitsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDCommentUPP(userRoutine: QDCommentProcPtr): QDCommentUPP; { old name was NewQDCommentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDTxMeasUPP(userRoutine: QDTxMeasProcPtr): QDTxMeasUPP; { old name was NewQDTxMeasProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDGetPicUPP(userRoutine: QDGetPicProcPtr): QDGetPicUPP; { old name was NewQDGetPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDPutPicUPP(userRoutine: QDPutPicProcPtr): QDPutPicUPP; { old name was NewQDPutPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDOpcodeUPP(userRoutine: QDOpcodeProcPtr): QDOpcodeUPP; { old name was NewQDOpcodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDStdGlyphsUPP(userRoutine: QDStdGlyphsProcPtr): QDStdGlyphsUPP; { old name was NewQDStdGlyphsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDJShieldCursorUPP(userRoutine: QDJShieldCursorProcPtr): QDJShieldCursorUPP; { old name was NewQDJShieldCursorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeQDTextUPP(userUPP: QDTextUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDLineUPP(userUPP: QDLineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDRectUPP(userUPP: QDRectUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDRRectUPP(userUPP: QDRRectUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDOvalUPP(userUPP: QDOvalUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDArcUPP(userUPP: QDArcUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDPolyUPP(userUPP: QDPolyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDRgnUPP(userUPP: QDRgnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDBitsUPP(userUPP: QDBitsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDCommentUPP(userUPP: QDCommentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDTxMeasUPP(userUPP: QDTxMeasUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDGetPicUPP(userUPP: QDGetPicUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDPutPicUPP(userUPP: QDPutPicUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDOpcodeUPP(userUPP: QDOpcodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDStdGlyphsUPP(userUPP: QDStdGlyphsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeQDJShieldCursorUPP(userUPP: QDJShieldCursorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeQDTextUPP(byteCount: INTEGER; textBuf: Ptr; numer: Point; denom: Point; userRoutine: QDTextUPP); { old name was CallQDTextProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDLineUPP(newPt: Point; userRoutine: QDLineUPP); { old name was CallQDLineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDRectUPP(verb: GrafVerb; VAR r: Rect; userRoutine: QDRectUPP); { old name was CallQDRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDRRectUPP(verb: GrafVerb; VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; userRoutine: QDRRectUPP); { old name was CallQDRRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDOvalUPP(verb: GrafVerb; VAR r: Rect; userRoutine: QDOvalUPP); { old name was CallQDOvalProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDArcUPP(verb: GrafVerb; VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; userRoutine: QDArcUPP); { old name was CallQDArcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDPolyUPP(verb: GrafVerb; poly: PolyHandle; userRoutine: QDPolyUPP); { old name was CallQDPolyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDRgnUPP(verb: GrafVerb; rgn: RgnHandle; userRoutine: QDRgnUPP); { old name was CallQDRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDBitsUPP(VAR srcBits: BitMap; VAR srcRect: Rect; VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle; userRoutine: QDBitsUPP); { old name was CallQDBitsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDCommentUPP(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle; userRoutine: QDCommentUPP); { old name was CallQDCommentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeQDTxMeasUPP(byteCount: INTEGER; textAddr: Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo; userRoutine: QDTxMeasUPP): INTEGER; { old name was CallQDTxMeasProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDGetPicUPP(dataPtr: Ptr; byteCount: INTEGER; userRoutine: QDGetPicUPP); { old name was CallQDGetPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDPutPicUPP(dataPtr: Ptr; byteCount: INTEGER; userRoutine: QDPutPicUPP); { old name was CallQDPutPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeQDOpcodeUPP(VAR fromRect: Rect; VAR toRect: Rect; opcode: INTEGER; version: INTEGER; userRoutine: QDOpcodeUPP); { old name was CallQDOpcodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeQDStdGlyphsUPP(dataStream: UNIV Ptr; size: ByteCount; userRoutine: QDStdGlyphsUPP): OSStatus; { old name was CallQDStdGlyphsProc }

PROCEDURE InvokeQDJShieldCursorUPP(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; userRoutine: QDJShieldCursorUPP); { old name was CallQDJShieldCursorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }

TYPE
	GrafPortPtr = ^GrafPort;
	GrafPort = RECORD
		device:					INTEGER;
		portBits:				BitMap;
		portRect:				Rect;
		visRgn:					RgnHandle;
		clipRgn:				RgnHandle;
		bkPat:					Pattern;
		fillPat:				Pattern;
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPat:					Pattern;
		pnVis:					INTEGER;
		txFont:					INTEGER;
		txFace:					StyleField;								{ StyleField occupies 16-bits, but only first 8-bits are used }
		txMode:					INTEGER;
		txSize:					INTEGER;
		spExtra:				Fixed;
		fgColor:				LONGINT;
		bkColor:				LONGINT;
		colrBit:				INTEGER;
		patStretch:				INTEGER;
		picSave:				Handle;
		rgnSave:				Handle;
		polySave:				Handle;
		grafProcs:				QDProcsPtr;
	END;

	GrafPtr								= ^GrafPort;
{
 *	This set of definitions "belongs" in Windows.
 *	But, there is a circularity in the headers where Windows includes Controls and
 *	Controls includes Windows. To break the circle, the information
 *	needed by Controls is moved from Windows to Quickdraw.
 }
	WindowPtr							= GrafPtr;
	DialogPtr							= WindowPtr;
{$ELSEC}

TYPE
	WindowPtr = ^LONGINT; { an opaque 32-bit type }
	DialogPtr = ^LONGINT; { an opaque 32-bit type }
	GrafPtr = ^LONGINT; { an opaque 32-bit type }
{$ENDC}

	WindowRef							= WindowPtr;
{  DragConstraint constants to pass to DragGray,DragTheRgn, or ConstrainedDragRgn }
	DragConstraint						= UInt16;

CONST
	kNoConstraint				= 0;
	kVerticalConstraint			= 1;
	kHorizontalConstraint		= 2;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DragGrayRgnProcPtr = PROCEDURE;
{$ELSEC}
	DragGrayRgnProcPtr = ProcPtr;
{$ENDC}

{
 *	Here ends the list of things that "belong" in Windows.
 }


	RGBColorPtr = ^RGBColor;
	RGBColor = RECORD
		red:					UInt16;									{ magnitude of red component }
		green:					UInt16;									{ magnitude of green component }
		blue:					UInt16;									{ magnitude of blue component }
	END;

	RGBColorHdl							= ^RGBColorPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ColorSearchProcPtr = FUNCTION(VAR rgb: RGBColor; VAR position: LONGINT): BOOLEAN;
{$ELSEC}
	ColorSearchProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ColorComplementProcPtr = FUNCTION(VAR rgb: RGBColor): BOOLEAN;
{$ELSEC}
	ColorComplementProcPtr = ProcPtr;
{$ENDC}

	DragGrayRgnUPP = UniversalProcPtr;
	ColorSearchUPP = UniversalProcPtr;
	ColorComplementUPP = UniversalProcPtr;

CONST
	uppDragGrayRgnProcInfo = $00000000;
	uppColorSearchProcInfo = $000003D0;
	uppColorComplementProcInfo = $000000D0;

FUNCTION NewDragGrayRgnUPP(userRoutine: DragGrayRgnProcPtr): DragGrayRgnUPP; { old name was NewDragGrayRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewColorSearchUPP(userRoutine: ColorSearchProcPtr): ColorSearchUPP; { old name was NewColorSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewColorComplementUPP(userRoutine: ColorComplementProcPtr): ColorComplementUPP; { old name was NewColorComplementProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDragGrayRgnUPP(userUPP: DragGrayRgnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeColorSearchUPP(userUPP: ColorSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeColorComplementUPP(userUPP: ColorComplementUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeDragGrayRgnUPP(userRoutine: DragGrayRgnUPP); { old name was CallDragGrayRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeColorSearchUPP(VAR rgb: RGBColor; VAR position: LONGINT; userRoutine: ColorSearchUPP): BOOLEAN; { old name was CallColorSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeColorComplementUPP(VAR rgb: RGBColor; userRoutine: ColorComplementUPP): BOOLEAN; { old name was CallColorComplementProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	ColorSpecPtr = ^ColorSpec;
	ColorSpec = RECORD
		value:					INTEGER;								{ index or other value }
		rgb:					RGBColor;								{ true color }
	END;

	CSpecArray							= ARRAY [0..0] OF ColorSpec;
	ColorTablePtr = ^ColorTable;
	ColorTable = RECORD
		ctSeed:					LONGINT;								{ unique identifier for table }
		ctFlags:				INTEGER;								{ high bit: 0 = PixMap; 1 = device }
		ctSize:					INTEGER;								{ number of entries in CTTable }
		ctTable:				CSpecArray;								{ array [0..0] of ColorSpec }
	END;

	CTabPtr								= ^ColorTable;
	CTabHandle							= ^CTabPtr;
	xColorSpecPtr = ^xColorSpec;
	xColorSpec = RECORD
		value:					INTEGER;								{ index or other value }
		rgb:					RGBColor;								{ true color }
		xalpha:					INTEGER;
	END;

	xCSpecArray							= ARRAY [0..0] OF xColorSpec;
	MatchRecPtr = ^MatchRec;
	MatchRec = RECORD
		red:					UInt16;
		green:					UInt16;
		blue:					UInt16;
		matchData:				LONGINT;
	END;

{
	QuickTime 3.0 makes PixMap data structure available on non-Mac OS's.
	In order to implement PixMap in these alternate environments, the PixMap
	had to be extended. The pmReserved field was changed to pmExt which is
	a Handle to extra info.  The planeBytes field was changed to pixelFormat.
}
{$IFC UNDEFINED OLDPIXMAPSTRUCT }
{$IFC NOT (TARGET_CARBON OR TARGET_OS_UNIX OR TARGET_OS_WIN32) }
{$SETC OLDPIXMAPSTRUCT := 1 }
{$ELSEC}
{$SETC OLDPIXMAPSTRUCT := 0 }
{$ENDC}
{$ENDC}

{  pixel formats }

CONST
	k1MonochromePixelFormat		= $00000001;					{  1 bit indexed }
	k2IndexedPixelFormat		= $00000002;					{  2 bit indexed }
	k4IndexedPixelFormat		= $00000004;					{  4 bit indexed }
	k8IndexedPixelFormat		= $00000008;					{  8 bit indexed }
	k16BE555PixelFormat			= $00000010;					{  16 bit BE rgb 555 (Mac) }
	k24RGBPixelFormat			= $00000018;					{  24 bit rgb  }
	k32ARGBPixelFormat			= $00000020;					{  32 bit argb	(Mac) }
	k1IndexedGrayPixelFormat	= $00000021;					{  1 bit indexed gray }
	k2IndexedGrayPixelFormat	= $00000022;					{  2 bit indexed gray }
	k4IndexedGrayPixelFormat	= $00000024;					{  4 bit indexed gray }
	k8IndexedGrayPixelFormat	= $00000028;					{  8 bit indexed gray }


{  values for PixMap.pixelFormat }
	k16LE555PixelFormat			= 'L555';						{  16 bit LE rgb 555 (PC) }
	k16LE5551PixelFormat		= '5551';						{  16 bit LE rgb 5551 }
	k16BE565PixelFormat			= 'B565';						{  16 bit BE rgb 565 }
	k16LE565PixelFormat			= 'L565';						{  16 bit LE rgb 565 }
	k24BGRPixelFormat			= '24BG';						{  24 bit bgr  }
	k32BGRAPixelFormat			= 'BGRA';						{  32 bit bgra	(Matrox) }
	k32ABGRPixelFormat			= 'ABGR';						{  32 bit abgr	 }
	k32RGBAPixelFormat			= 'RGBA';						{  32 bit rgba	 }
	kYUVSPixelFormat			= 'yuvs';						{  YUV 4:2:2 byte ordering 16-unsigned = 'YUY2' }
	kYUVUPixelFormat			= 'yuvu';						{  YUV 4:2:2 byte ordering 16-signed }
	kYVU9PixelFormat			= 'YVU9';						{  YVU9 Planar	9 }
	kYUV411PixelFormat			= 'Y411';						{  YUV 4:1:1 Interleaved	16 }
	kYVYU422PixelFormat			= 'YVYU';						{  YVYU 4:2:2 byte ordering	16 }
	kUYVY422PixelFormat			= 'UYVY';						{  UYVY 4:2:2 byte ordering	16 }
	kYUV211PixelFormat			= 'Y211';						{  YUV 2:1:1 Packed	8 }



TYPE
	PixMapPtr = ^PixMap;
	PixMap = RECORD
		baseAddr:				Ptr;									{ pointer to pixels }
		rowBytes:				INTEGER;								{ offset to next line }
		bounds:					Rect;									{ encloses bitmap }
		pmVersion:				INTEGER;								{ pixMap version number }
		packType:				INTEGER;								{ defines packing format }
		packSize:				LONGINT;								{ length of pixel data }
		hRes:					Fixed;									{ horiz. resolution (ppi) }
		vRes:					Fixed;									{ vert. resolution (ppi) }
		pixelType:				INTEGER;								{ defines pixel type }
		pixelSize:				INTEGER;								{ # bits in pixel }
		cmpCount:				INTEGER;								{ # components in pixel }
		cmpSize:				INTEGER;								{ # bits per component }
		planeBytes:				LONGINT;								{ offset to next plane }
		pmTable:				CTabHandle;								{ color map for this pixMap }
		pmReserved:				LONGINT;
	END;

	PixMapHandle						= ^PixMapPtr;
	PixPatPtr = ^PixPat;
	PixPat = RECORD
		patType:				INTEGER;								{ type of pattern }
		patMap:					PixMapHandle;							{ the pattern's pixMap }
		patData:				Handle;									{ pixmap's data }
		patXData:				Handle;									{ expanded Pattern data }
		patXValid:				INTEGER;								{ flags whether expanded Pattern valid }
		patXMap:				Handle;									{ Handle to expanded Pattern data }
		pat1Data:				Pattern;								{ old-Style pattern/RGB color }
	END;

	PixPatHandle						= ^PixPatPtr;
	CCrsrPtr = ^CCrsr;
	CCrsr = RECORD
		crsrType:				INTEGER;								{ type of cursor }
		crsrMap:				PixMapHandle;							{ the cursor's pixmap }
		crsrData:				Handle;									{ cursor's data }
		crsrXData:				Handle;									{ expanded cursor data }
		crsrXValid:				INTEGER;								{ depth of expanded data (0 if none) }
		crsrXHandle:			Handle;									{ future use }
		crsr1Data:				Bits16;									{ one-bit cursor }
		crsrMask:				Bits16;									{ cursor's mask }
		crsrHotSpot:			Point;									{ cursor's hotspot }
		crsrXTable:				LONGINT;								{ private }
		crsrID:					LONGINT;								{ private }
	END;

	CCrsrHandle							= ^CCrsrPtr;
	GammaTblPtr = ^GammaTbl;
	GammaTbl = RECORD
		gVersion:				INTEGER;								{ gamma version number }
		gType:					INTEGER;								{ gamma data type }
		gFormulaSize:			INTEGER;								{ Formula data size }
		gChanCnt:				INTEGER;								{ number of channels of data }
		gDataCnt:				INTEGER;								{ number of values/channel }
		gDataWidth:				INTEGER;								{ bits/corrected value (data packed to next larger byte size) }
		gFormulaData:			ARRAY [0..0] OF INTEGER;				{ data for formulas followed by gamma values }
	END;

	GammaTblHandle						= ^GammaTblPtr;
	ITabPtr = ^ITab;
	ITab = RECORD
		iTabSeed:				LONGINT;								{ copy of CTSeed from source CTable }
		iTabRes:				INTEGER;								{ bits/channel resolution of iTable }
		iTTable:				SInt8;									{ byte colortable index values }
	END;

	ITabHandle							= ^ITabPtr;
	SProcRecPtr = ^SProcRec;
	SProcRec = RECORD
		nxtSrch:				Handle;									{ SProcHndl Handle to next SProcRec }
		srchProc:				ColorSearchUPP;							{ search procedure proc ptr }
	END;

	SProcPtr							= ^SProcRec;
	SProcHndl							= ^SProcPtr;
	CProcRecPtr = ^CProcRec;
	CProcRec = RECORD
		nxtComp:				Handle;									{ CProcHndl Handle to next CProcRec }
		compProc:				ColorComplementUPP;						{ complement procedure proc ptr }
	END;

	CProcPtr							= ^CProcRec;
	CProcHndl							= ^CProcPtr;
{
	QuickTime 3.0 makes GDevice data structure available on non-Mac OS's.
	In order to implement GDevice in these alternate environments, the GDevice
	had to be extended. The gdReserved field was changed to gdExt which is
	a Handle to extra info.  
}
{$IFC UNDEFINED OLDGDEVICESTRUCT }
{$IFC NOT (TARGET_CARBON OR TARGET_OS_UNIX OR TARGET_OS_WIN32) }
{$SETC OLDGDEVICESTRUCT := 1 }
{$ELSEC}
{$SETC OLDGDEVICESTRUCT := 0 }
{$ENDC}
{$ENDC}

	GDevicePtr = ^GDevice;
	GDPtr								= ^GDevice;
	GDHandle							= ^GDPtr;
	GDevice = RECORD
		gdRefNum:				INTEGER;								{ driver's unit number }
		gdID:					INTEGER;								{ client ID for search procs }
		gdType:					INTEGER;								{ fixed/CLUT/direct }
		gdITable:				ITabHandle;								{ Handle to inverse lookup table }
		gdResPref:				INTEGER;								{ preferred resolution of GDITable }
		gdSearchProc:			SProcHndl;								{ search proc list head }
		gdCompProc:				CProcHndl;								{ complement proc list }
		gdFlags:				INTEGER;								{ grafDevice flags word }
		gdPMap:					PixMapHandle;							{ describing pixMap }
		gdRefCon:				LONGINT;								{ reference value }
		gdNextGD:				GDHandle;								{ GDHandle Handle of next gDevice }
		gdRect:					Rect;									{  device's bounds in global coordinates }
		gdMode:					LONGINT;								{ device's current mode }
		gdCCBytes:				INTEGER;								{ depth of expanded cursor data }
		gdCCDepth:				INTEGER;								{ depth of expanded cursor data }
		gdCCXData:				Handle;									{ Handle to cursor's expanded data }
		gdCCXMask:				Handle;									{ Handle to cursor's expanded mask }
		gdReserved:				LONGINT;								{ future use. MUST BE 0 }
	END;

	GrafVars = RECORD
		rgbOpColor:				RGBColor;								{ color for addPin  subPin and average }
		rgbHiliteColor:			RGBColor;								{ color for hiliting }
		pmFgColor:				Handle;									{ palette Handle for foreground color }
		pmFgIndex:				INTEGER;								{ index value for foreground }
		pmBkColor:				Handle;									{ palette Handle for background color }
		pmBkIndex:				INTEGER;								{ index value for background }
		pmFlags:				INTEGER;								{ flags for Palette Manager }
	END;
	GVarPtr								= ^GrafVars;
	GVarHandle							= ^GVarPtr;

{$IFC OPAQUE_TOOLBOX_STRUCTS }
	CGrafPtr							= GrafPtr;
{$ELSEC}
	CGrafPortPtr = ^CGrafPort;
	CGrafPtr							= ^CGrafPort;
{$ENDC}  {OPAQUE_TOOLBOX_STRUCTS}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPrinterStatusProcPtr = FUNCTION(opcode: PrinterStatusOpcode; currentPort: CGrafPtr; printerStatus: UNIV Ptr): OSStatus; C;
{$ELSEC}
	QDPrinterStatusProcPtr = ProcPtr;
{$ENDC}

	QDPrinterStatusUPP = UniversalProcPtr;

	CQDProcsPtr = ^CQDProcs;
	CQDProcs = RECORD
		textProc:				QDTextUPP;
		lineProc:				QDLineUPP;
		rectProc:				QDRectUPP;
		rRectProc:				QDRRectUPP;
		ovalProc:				QDOvalUPP;
		arcProc:				QDArcUPP;
		polyProc:				QDPolyUPP;
		rgnProc:				QDRgnUPP;
		bitsProc:				QDBitsUPP;
		commentProc:			QDCommentUPP;
		txMeasProc:				QDTxMeasUPP;
		getPicProc:				QDGetPicUPP;
		putPicProc:				QDPutPicUPP;
		opcodeProc:				QDOpcodeUPP;
		newProc1:				UniversalProcPtr;						{  this is the StdPix bottleneck -- see ImageCompression.h  }
		glyphsProc:				QDStdGlyphsUPP;							{  was newProc2; now used in Unicode text drawing  }
		printerStatusProc:		QDPrinterStatusUPP;						{  was newProc3;  now used to communicate status between Printing code and System imaging code  }
		newProc4:				UniversalProcPtr;
		newProc5:				UniversalProcPtr;
		newProc6:				UniversalProcPtr;
	END;

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	CGrafPort = RECORD
		device:					INTEGER;
		portPixMap:				PixMapHandle;							{ port's pixel map }
		portVersion:			INTEGER;								{ high 2 bits always set }
		grafVars:				Handle;									{ Handle to more fields }
		chExtra:				INTEGER;								{ character extra }
		pnLocHFrac:				INTEGER;								{ pen fraction }
		portRect:				Rect;
		visRgn:					RgnHandle;
		clipRgn:				RgnHandle;
		bkPixPat:				PixPatHandle;							{ background pattern }
		rgbFgColor:				RGBColor;								{ RGB components of fg }
		rgbBkColor:				RGBColor;								{ RGB components of bk }
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPixPat:				PixPatHandle;							{ pen's pattern }
		fillPixPat:				PixPatHandle;							{ fill pattern }
		pnVis:					INTEGER;
		txFont:					INTEGER;
		txFace:					StyleField;								{ StyleField occupies 16-bits, but only first 8-bits are used }
		txMode:					INTEGER;
		txSize:					INTEGER;
		spExtra:				Fixed;
		fgColor:				LONGINT;
		bkColor:				LONGINT;
		colrBit:				INTEGER;
		patStretch:				INTEGER;
		picSave:				Handle;
		rgnSave:				Handle;
		polySave:				Handle;
		grafProcs:				CQDProcsPtr;
	END;

{$ENDC}

{$IFC OPAQUE_TOOLBOX_STRUCTS }
	CWindowPtr							= WindowPtr;
{$ELSEC}
	CWindowPtr							= CGrafPtr;
{$ENDC}  {OPAQUE_TOOLBOX_STRUCTS}

	ReqListRecPtr = ^ReqListRec;
	ReqListRec = RECORD
		reqLSize:				INTEGER;								{ request list size }
		reqLData:				ARRAY [0..0] OF INTEGER;				{ request list data }
	END;

	OpenCPicParamsPtr = ^OpenCPicParams;
	OpenCPicParams = RECORD
		srcRect:				Rect;
		hRes:					Fixed;
		vRes:					Fixed;
		version:				INTEGER;
		reserved1:				INTEGER;
		reserved2:				LONGINT;
	END;


CONST
	kCursorImageMajorVersion	= $0001;
	kCursorImageMinorVersion	= $0000;


TYPE
	CursorImageRecPtr = ^CursorImageRec;
	CursorImageRec = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		cursorPixMap:			PixMapHandle;
		cursorBitMask:			BitMapHandle;
	END;

	CursorImagePtr						= ^CursorImageRec;
{$IFC TYPED_FUNCTION_POINTERS}
	DeviceLoopDrawingProcPtr = PROCEDURE(depth: INTEGER; deviceFlags: INTEGER; targetDevice: GDHandle; userData: LONGINT);
{$ELSEC}
	DeviceLoopDrawingProcPtr = ProcPtr;
{$ENDC}

	DeviceLoopDrawingUPP = UniversalProcPtr;

CONST
	uppDeviceLoopDrawingProcInfo = $00003E80;

FUNCTION NewDeviceLoopDrawingUPP(userRoutine: DeviceLoopDrawingProcPtr): DeviceLoopDrawingUPP; { old name was NewDeviceLoopDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDeviceLoopDrawingUPP(userUPP: DeviceLoopDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeDeviceLoopDrawingUPP(depth: INTEGER; deviceFlags: INTEGER; targetDevice: GDHandle; userData: LONGINT; userRoutine: DeviceLoopDrawingUPP); { old name was CallDeviceLoopDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{ In Carbon, use the QDGlobals accessors instead }
{$IFC NOT TARGET_CARBON }

TYPE
	QDGlobalsPtr = ^QDGlobals;
	QDGlobals = RECORD
		privates:				PACKED ARRAY [0..75] OF CHAR;
		randSeed:				LONGINT;
		screenBits:				BitMap;
		arrow:					Cursor;
		dkGray:					Pattern;
		ltGray:					Pattern;
		gray:					Pattern;
		black:					Pattern;
		white:					Pattern;
		thePort:				GrafPtr;
	END;

	QDGlobalsHdl						= ^QDGlobalsPtr;

{ To be in sync with the C interface to QuickDraw globals, pascal code must now }
{ qualify the QuickDraw globals with “qd.” (e.g. InitGraf(@qd.thePort);  )       }
VAR
	{$PUSH}
	{$J+}
	qd: QDGlobals;
	{$POP}
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE InitGraf(globalPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86E;
	{$ENDC}
PROCEDURE OpenPort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86F;
	{$ENDC}
PROCEDURE InitPort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86D;
	{$ENDC}
PROCEDURE ClosePort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87D;
	{$ENDC}
{
   These are Carbon only routines. They do nothing at all on
   Mac OS 8, but work flawlessly on Mac OS X.
}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION LockPortBits(port: GrafPtr): OSErr;
FUNCTION UnlockPortBits(port: GrafPtr): OSErr;
{  Break a region up into rectangles. }


CONST
	kQDParseRegionFromTop		= $01;
	kQDParseRegionFromBottom	= $02;
	kQDParseRegionFromLeft		= $04;
	kQDParseRegionFromRight		= $08;
	kQDParseRegionFromTopLeft	= $05;
	kQDParseRegionFromBottomRight = $0A;


TYPE
	QDRegionParseDirection				= SInt32;

CONST
	kQDRegionToRectsMsgInit		= 1;
	kQDRegionToRectsMsgParse	= 2;
	kQDRegionToRectsMsgTerminate = 3;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	RegionToRectsProcPtr = FUNCTION(message: UInt16; rgn: RgnHandle; {CONST}VAR rect: Rect; refCon: UNIV Ptr): OSStatus; C;
{$ELSEC}
	RegionToRectsProcPtr = ProcPtr;
{$ENDC}

	RegionToRectsUPP = UniversalProcPtr;

CONST
	uppQDPrinterStatusProcInfo = $00000FF1;
	uppRegionToRectsProcInfo = $00003FB1;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewQDPrinterStatusUPP(userRoutine: QDPrinterStatusProcPtr): QDPrinterStatusUPP; { old name was NewQDPrinterStatusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


FUNCTION NewRegionToRectsUPP(userRoutine: RegionToRectsProcPtr): RegionToRectsUPP; { old name was NewRegionToRectsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

PROCEDURE DisposeQDPrinterStatusUPP(userUPP: QDPrinterStatusUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


PROCEDURE DisposeRegionToRectsUPP(userUPP: RegionToRectsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }

FUNCTION InvokeQDPrinterStatusUPP(opcode: PrinterStatusOpcode; currentPort: CGrafPtr; printerStatus: UNIV Ptr; userRoutine: QDPrinterStatusUPP): OSStatus; { old name was CallQDPrinterStatusProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


FUNCTION InvokeRegionToRectsUPP(message: UInt16; rgn: RgnHandle; {CONST}VAR rect: Rect; refCon: UNIV Ptr; userRoutine: RegionToRectsUPP): OSStatus; { old name was CallRegionToRectsProc }
FUNCTION QDRegionToRects(rgn: RgnHandle; dir: QDRegionParseDirection; proc: RegionToRectsUPP; userData: UNIV Ptr): OSStatus; C;

{$IFC (TARGET_CARBON OR TARGET_OS_UNIX OR TARGET_OS_WIN32) }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION UpdatePort(port: GrafPtr): OSErr;
FUNCTION GetPortNativeWindow(macPort: GrafPtr): Ptr;
FUNCTION GetNativeWindowPort(nativeWindow: UNIV Ptr): GrafPtr;
FUNCTION MacRegionToNativeRegion(macRegion: RgnHandle): Ptr;
FUNCTION NativeRegionToMacRegion(nativeRegion: UNIV Ptr): RgnHandle;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetPortHWND(port: GrafPtr): Ptr;
FUNCTION GetHWNDPort(theHWND: UNIV Ptr): GrafPtr;
FUNCTION GetPortHDC(port: GrafPtr): Ptr;
FUNCTION GetPortHBITMAP(port: GrafPtr): Ptr;
FUNCTION GetPortHPALETTE(port: GrafPtr): Ptr;
FUNCTION GetPortHFONT(port: GrafPtr): Ptr;
FUNCTION GetDIBFromPICT(hPict: PicHandle): Ptr;
FUNCTION GetPICTFromDIB(h: UNIV Ptr): PicHandle;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}
{$ENDC}

PROCEDURE SetPort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A873;
	{$ENDC}
PROCEDURE GetPort(VAR port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A874;
	{$ENDC}
PROCEDURE GrafDevice(device: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A872;
	{$ENDC}
PROCEDURE SetPortBits({CONST}VAR bm: BitMap);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A875;
	{$ENDC}
PROCEDURE PortSize(width: INTEGER; height: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A876;
	{$ENDC}
PROCEDURE MovePortTo(leftGlobal: INTEGER; topGlobal: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A877;
	{$ENDC}
PROCEDURE SetOrigin(h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A878;
	{$ENDC}
PROCEDURE SetClip(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A879;
	{$ENDC}
PROCEDURE GetClip(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87A;
	{$ENDC}
PROCEDURE ClipRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87B;
	{$ENDC}
PROCEDURE BackPat({CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87C;
	{$ENDC}
PROCEDURE InitCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A850;
	{$ENDC}
PROCEDURE SetCursor({CONST}VAR crsr: Cursor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A851;
	{$ENDC}
PROCEDURE HideCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A852;
	{$ENDC}
PROCEDURE ShowCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A853;
	{$ENDC}
PROCEDURE ObscureCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A856;
	{$ENDC}
PROCEDURE HidePen;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A896;
	{$ENDC}
PROCEDURE ShowPen;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A897;
	{$ENDC}
PROCEDURE GetPen(VAR pt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89A;
	{$ENDC}
PROCEDURE GetPenState(VAR pnState: PenState);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A898;
	{$ENDC}
PROCEDURE SetPenState({CONST}VAR pnState: PenState);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A899;
	{$ENDC}
PROCEDURE PenSize(width: INTEGER; height: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89B;
	{$ENDC}
PROCEDURE PenMode(mode: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89C;
	{$ENDC}
PROCEDURE PenPat({CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89D;
	{$ENDC}
PROCEDURE PenNormal;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89E;
	{$ENDC}
PROCEDURE MoveTo(h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A893;
	{$ENDC}
PROCEDURE Move(dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A894;
	{$ENDC}
PROCEDURE LineTo(h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A891;
	{$ENDC}
PROCEDURE Line(dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A892;
	{$ENDC}
PROCEDURE ForeColor(color: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A862;
	{$ENDC}
PROCEDURE BackColor(color: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A863;
	{$ENDC}
PROCEDURE ColorBit(whichBit: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A864;
	{$ENDC}
PROCEDURE SetRect(VAR r: Rect; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A7;
	{$ENDC}
PROCEDURE OffsetRect(VAR r: Rect; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A8;
	{$ENDC}
PROCEDURE InsetRect(VAR r: Rect; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A9;
	{$ENDC}
FUNCTION SectRect({CONST}VAR src1: Rect; {CONST}VAR src2: Rect; VAR dstRect: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AA;
	{$ENDC}
PROCEDURE UnionRect({CONST}VAR src1: Rect; {CONST}VAR src2: Rect; VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AB;
	{$ENDC}
FUNCTION EqualRect({CONST}VAR rect1: Rect; {CONST}VAR rect2: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A6;
	{$ENDC}
FUNCTION EmptyRect({CONST}VAR r: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AE;
	{$ENDC}
PROCEDURE FrameRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A1;
	{$ENDC}
PROCEDURE PaintRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A2;
	{$ENDC}
PROCEDURE EraseRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A3;
	{$ENDC}
PROCEDURE InvertRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A4;
	{$ENDC}
PROCEDURE FillRect({CONST}VAR r: Rect; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A5;
	{$ENDC}
PROCEDURE FrameOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B7;
	{$ENDC}
PROCEDURE PaintOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B8;
	{$ENDC}
PROCEDURE EraseOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B9;
	{$ENDC}
PROCEDURE InvertOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BA;
	{$ENDC}
PROCEDURE FillOval({CONST}VAR r: Rect; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BB;
	{$ENDC}
PROCEDURE FrameRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B0;
	{$ENDC}
PROCEDURE PaintRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B1;
	{$ENDC}
PROCEDURE EraseRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B2;
	{$ENDC}
PROCEDURE InvertRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B3;
	{$ENDC}
PROCEDURE FillRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B4;
	{$ENDC}
PROCEDURE FrameArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BE;
	{$ENDC}
PROCEDURE PaintArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BF;
	{$ENDC}
PROCEDURE EraseArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C0;
	{$ENDC}
PROCEDURE InvertArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C1;
	{$ENDC}
PROCEDURE FillArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C2;
	{$ENDC}
FUNCTION NewRgn: RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D8;
	{$ENDC}
PROCEDURE OpenRgn;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DA;
	{$ENDC}
PROCEDURE CloseRgn(dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DB;
	{$ENDC}
FUNCTION BitMapToRegion(region: RgnHandle; {CONST}VAR bMap: BitMap): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D7;
	{$ENDC}
PROCEDURE DisposeRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D9;
	{$ENDC}
PROCEDURE CopyRgn(srcRgn: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DC;
	{$ENDC}
PROCEDURE SetEmptyRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DD;
	{$ENDC}
PROCEDURE SetRectRgn(rgn: RgnHandle; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DE;
	{$ENDC}
PROCEDURE RectRgn(rgn: RgnHandle; {CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DF;
	{$ENDC}
PROCEDURE OffsetRgn(rgn: RgnHandle; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E0;
	{$ENDC}
PROCEDURE InsetRgn(rgn: RgnHandle; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E1;
	{$ENDC}
PROCEDURE SectRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E4;
	{$ENDC}
PROCEDURE UnionRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E5;
	{$ENDC}
PROCEDURE DiffRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E6;
	{$ENDC}
PROCEDURE XorRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E7;
	{$ENDC}
FUNCTION RectInRgn({CONST}VAR r: Rect; rgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E9;
	{$ENDC}
FUNCTION EqualRgn(rgnA: RgnHandle; rgnB: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E3;
	{$ENDC}
FUNCTION EmptyRgn(rgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E2;
	{$ENDC}
PROCEDURE FrameRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D2;
	{$ENDC}
PROCEDURE PaintRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D3;
	{$ENDC}
PROCEDURE EraseRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D4;
	{$ENDC}
PROCEDURE InvertRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D5;
	{$ENDC}
PROCEDURE FillRgn(rgn: RgnHandle; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D6;
	{$ENDC}
PROCEDURE ScrollRect({CONST}VAR r: Rect; dh: INTEGER; dv: INTEGER; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EF;
	{$ENDC}
PROCEDURE CopyBits({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EC;
	{$ENDC}
PROCEDURE SeedFill(srcPtr: UNIV Ptr; dstPtr: UNIV Ptr; srcRow: INTEGER; dstRow: INTEGER; height: INTEGER; words: INTEGER; seedH: INTEGER; seedV: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A839;
	{$ENDC}
PROCEDURE CalcMask(srcPtr: UNIV Ptr; dstPtr: UNIV Ptr; srcRow: INTEGER; dstRow: INTEGER; height: INTEGER; words: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A838;
	{$ENDC}
PROCEDURE CopyMask({CONST}VAR srcBits: BitMap; {CONST}VAR maskBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR maskRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A817;
	{$ENDC}
FUNCTION OpenPicture({CONST}VAR picFrame: Rect): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F3;
	{$ENDC}
PROCEDURE PicComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F2;
	{$ENDC}
PROCEDURE ClosePicture;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F4;
	{$ENDC}
PROCEDURE DrawPicture(myPicture: PicHandle; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F6;
	{$ENDC}
PROCEDURE KillPicture(myPicture: PicHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F5;
	{$ENDC}
FUNCTION OpenPoly: PolyHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CB;
	{$ENDC}
PROCEDURE ClosePoly;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CC;
	{$ENDC}
PROCEDURE KillPoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CD;
	{$ENDC}
PROCEDURE OffsetPoly(poly: PolyHandle; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CE;
	{$ENDC}
PROCEDURE FramePoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C6;
	{$ENDC}
PROCEDURE PaintPoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C7;
	{$ENDC}
PROCEDURE ErasePoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C8;
	{$ENDC}
PROCEDURE InvertPoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C9;
	{$ENDC}
PROCEDURE FillPoly(poly: PolyHandle; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CA;
	{$ENDC}
PROCEDURE SetPt(VAR pt: Point; h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A880;
	{$ENDC}
PROCEDURE LocalToGlobal(VAR pt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A870;
	{$ENDC}
PROCEDURE GlobalToLocal(VAR pt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A871;
	{$ENDC}
FUNCTION Random: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A861;
	{$ENDC}
PROCEDURE StuffHex(thingPtr: UNIV Ptr; s: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A866;
	{$ENDC}
FUNCTION GetPixel(h: INTEGER; v: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A865;
	{$ENDC}
PROCEDURE ScalePt(VAR pt: Point; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F8;
	{$ENDC}
PROCEDURE MapPt(VAR pt: Point; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F9;
	{$ENDC}
PROCEDURE MapRect(VAR r: Rect; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FA;
	{$ENDC}
PROCEDURE MapRgn(rgn: RgnHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FB;
	{$ENDC}
PROCEDURE MapPoly(poly: PolyHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FC;
	{$ENDC}
PROCEDURE SetStdProcs(VAR procs: QDProcs);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EA;
	{$ENDC}
PROCEDURE StdRect(verb: GrafVerb; {CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A0;
	{$ENDC}
PROCEDURE StdRRect(verb: GrafVerb; {CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AF;
	{$ENDC}
PROCEDURE StdOval(verb: GrafVerb; {CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B6;
	{$ENDC}
PROCEDURE StdArc(verb: GrafVerb; {CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BD;
	{$ENDC}
PROCEDURE StdPoly(verb: GrafVerb; poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C5;
	{$ENDC}
PROCEDURE StdRgn(verb: GrafVerb; rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D1;
	{$ENDC}
PROCEDURE StdBits({CONST}VAR srcBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EB;
	{$ENDC}
PROCEDURE StdComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F1;
	{$ENDC}
PROCEDURE StdGetPic(dataPtr: UNIV Ptr; byteCount: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EE;
	{$ENDC}
PROCEDURE StdPutPic(dataPtr: UNIV Ptr; byteCount: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F0;
	{$ENDC}
PROCEDURE StdOpcode({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; opcode: UInt16; version: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $ABF8;
	{$ENDC}
PROCEDURE AddPt(src: Point; VAR dst: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87E;
	{$ENDC}
FUNCTION EqualPt(pt1: Point; pt2: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A881;
	{$ENDC}
FUNCTION PtInRect(pt: Point; {CONST}VAR r: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AD;
	{$ENDC}
PROCEDURE Pt2Rect(pt1: Point; pt2: Point; VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AC;
	{$ENDC}
PROCEDURE PtToAngle({CONST}VAR r: Rect; pt: Point; VAR angle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C3;
	{$ENDC}
PROCEDURE SubPt(src: Point; VAR dst: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87F;
	{$ENDC}
FUNCTION PtInRgn(pt: Point; rgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E8;
	{$ENDC}
PROCEDURE StdLine(newPt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A890;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE OpenCPort(port: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA00;
	{$ENDC}
PROCEDURE InitCPort(port: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA01;
	{$ENDC}
PROCEDURE CloseCPort(port: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA02;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION NewPixMap: PixMapHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA03;
	{$ENDC}
PROCEDURE DisposePixMap(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA04;
	{$ENDC}
PROCEDURE CopyPixMap(srcPM: PixMapHandle; dstPM: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA05;
	{$ENDC}
FUNCTION NewPixPat: PixPatHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA07;
	{$ENDC}
PROCEDURE DisposePixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA08;
	{$ENDC}
PROCEDURE CopyPixPat(srcPP: PixPatHandle; dstPP: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA09;
	{$ENDC}
PROCEDURE PenPixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0A;
	{$ENDC}
PROCEDURE BackPixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0B;
	{$ENDC}
FUNCTION GetPixPat(patID: INTEGER): PixPatHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0C;
	{$ENDC}
PROCEDURE MakeRGBPat(pp: PixPatHandle; {CONST}VAR myColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0D;
	{$ENDC}
PROCEDURE FillCRect({CONST}VAR r: Rect; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0E;
	{$ENDC}
PROCEDURE FillCOval({CONST}VAR r: Rect; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0F;
	{$ENDC}
PROCEDURE FillCRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA10;
	{$ENDC}
PROCEDURE FillCArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA11;
	{$ENDC}
PROCEDURE FillCRgn(rgn: RgnHandle; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA12;
	{$ENDC}
PROCEDURE FillCPoly(poly: PolyHandle; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA13;
	{$ENDC}
PROCEDURE RGBForeColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA14;
	{$ENDC}
PROCEDURE RGBBackColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA15;
	{$ENDC}
PROCEDURE SetCPixel(h: INTEGER; v: INTEGER; {CONST}VAR cPix: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA16;
	{$ENDC}
PROCEDURE SetPortPix(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA06;
	{$ENDC}
PROCEDURE GetCPixel(h: INTEGER; v: INTEGER; VAR cPix: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA17;
	{$ENDC}
PROCEDURE GetForeColor(VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA19;
	{$ENDC}
PROCEDURE GetBackColor(VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1A;
	{$ENDC}
PROCEDURE SeedCFill({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; seedH: INTEGER; seedV: INTEGER; matchProc: ColorSearchUPP; matchData: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA50;
	{$ENDC}
PROCEDURE CalcCMask({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; {CONST}VAR seedRGB: RGBColor; matchProc: ColorSearchUPP; matchData: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4F;
	{$ENDC}
FUNCTION OpenCPicture({CONST}VAR newHeader: OpenCPicParams): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA20;
	{$ENDC}
PROCEDURE OpColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA21;
	{$ENDC}
PROCEDURE HiliteColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA22;
	{$ENDC}
PROCEDURE DisposeCTable(cTable: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA24;
	{$ENDC}
FUNCTION GetCTable(ctID: INTEGER): CTabHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA18;
	{$ENDC}
FUNCTION GetCCursor(crsrID: INTEGER): CCrsrHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1B;
	{$ENDC}
PROCEDURE SetCCursor(cCrsr: CCrsrHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1C;
	{$ENDC}
PROCEDURE AllocCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1D;
	{$ENDC}
PROCEDURE DisposeCCursor(cCrsr: CCrsrHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA26;
	{$ENDC}
{  GetCIcon(), PlotCIcon(), and DisposeCIcon() moved to Icons.h }

PROCEDURE SetStdCProcs(VAR procs: CQDProcs);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4E;
	{$ENDC}
FUNCTION GetMaxDevice({CONST}VAR globalRect: Rect): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA27;
	{$ENDC}
FUNCTION GetCTSeed: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA28;
	{$ENDC}
FUNCTION GetDeviceList: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA29;
	{$ENDC}
FUNCTION GetMainDevice: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2A;
	{$ENDC}
FUNCTION GetNextDevice(curDevice: GDHandle): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2B;
	{$ENDC}
FUNCTION TestDeviceAttribute(gdh: GDHandle; attribute: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2C;
	{$ENDC}
PROCEDURE SetDeviceAttribute(gdh: GDHandle; attribute: INTEGER; value: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2D;
	{$ENDC}
PROCEDURE InitGDevice(qdRefNum: INTEGER; mode: LONGINT; gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2E;
	{$ENDC}
FUNCTION NewGDevice(refNum: INTEGER; mode: LONGINT): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2F;
	{$ENDC}
PROCEDURE DisposeGDevice(gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA30;
	{$ENDC}
PROCEDURE SetGDevice(gd: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA31;
	{$ENDC}
FUNCTION GetGDevice: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA32;
	{$ENDC}
FUNCTION Color2Index({CONST}VAR myColor: RGBColor): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA33;
	{$ENDC}
PROCEDURE Index2Color(index: LONGINT; VAR aColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA34;
	{$ENDC}
PROCEDURE InvertColor(VAR myColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA35;
	{$ENDC}
FUNCTION RealColor({CONST}VAR color: RGBColor): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA36;
	{$ENDC}
PROCEDURE GetSubTable(myColors: CTabHandle; iTabRes: INTEGER; targetTbl: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA37;
	{$ENDC}
PROCEDURE MakeITable(cTabH: CTabHandle; iTabH: ITabHandle; res: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA39;
	{$ENDC}
PROCEDURE AddSearch(searchProc: ColorSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3A;
	{$ENDC}
PROCEDURE AddComp(compProc: ColorComplementUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3B;
	{$ENDC}
PROCEDURE DelSearch(searchProc: ColorSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4C;
	{$ENDC}
PROCEDURE DelComp(compProc: ColorComplementUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4D;
	{$ENDC}
PROCEDURE SetClientID(id: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3C;
	{$ENDC}
PROCEDURE ProtectEntry(index: INTEGER; protect: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3D;
	{$ENDC}
PROCEDURE ReserveEntry(index: INTEGER; reserve: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3E;
	{$ENDC}
PROCEDURE SetEntries(start: INTEGER; count: INTEGER; VAR aTable: CSpecArray);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3F;
	{$ENDC}
PROCEDURE SaveEntries(srcTable: CTabHandle; resultTable: CTabHandle; VAR selection: ReqListRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA49;
	{$ENDC}
PROCEDURE RestoreEntries(srcTable: CTabHandle; dstTable: CTabHandle; VAR selection: ReqListRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4A;
	{$ENDC}
FUNCTION QDError: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA40;
	{$ENDC}
PROCEDURE CopyDeepMask({CONST}VAR srcBits: BitMap; {CONST}VAR maskBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR maskRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA51;
	{$ENDC}
PROCEDURE DeviceLoop(drawingRgn: RgnHandle; drawingProc: DeviceLoopDrawingUPP; userData: LONGINT; flags: DeviceLoopFlags);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $ABCA;
	{$ENDC}


FUNCTION GetMaskTable: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A836, $2E88;
	{$ENDC}

FUNCTION GetPattern(patternID: INTEGER): PatHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B8;
	{$ENDC}
FUNCTION GetCursor(cursorID: INTEGER): CursHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B9;
	{$ENDC}
FUNCTION GetPicture(pictureID: INTEGER): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BC;
	{$ENDC}
FUNCTION DeltaPoint(ptA: Point; ptB: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94F;
	{$ENDC}
PROCEDURE ShieldCursor({CONST}VAR shieldRect: Rect; offsetPt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A855;
	{$ENDC}
PROCEDURE ScreenRes(VAR scrnHRes: INTEGER; VAR scrnVRes: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $32B8, $0102, $225F, $32B8, $0104;
	{$ENDC}
PROCEDURE GetIndPattern(VAR thePat: Pattern; patternListID: INTEGER; index: INTEGER);
{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE DisposPixMap(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA04;
	{$ENDC}
PROCEDURE DisposPixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA08;
	{$ENDC}
PROCEDURE DisposCTable(cTable: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA24;
	{$ENDC}
PROCEDURE DisposCCursor(cCrsr: CCrsrHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA26;
	{$ENDC}
PROCEDURE DisposGDevice(gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA30;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{
	From ToolUtils.i
}
PROCEDURE PackBits(VAR srcPtr: Ptr; VAR dstPtr: Ptr; srcBytes: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CF;
	{$ENDC}
PROCEDURE UnpackBits(VAR srcPtr: Ptr; VAR dstPtr: Ptr; dstBytes: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D0;
	{$ENDC}
FUNCTION SlopeFromAngle(angle: INTEGER): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BC;
	{$ENDC}
FUNCTION AngleFromSlope(slope: Fixed): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C4;
	{$ENDC}
{ New transfer modes }

CONST
	colorXorXFer				= 52;
	noiseXFer					= 53;
	customXFer					= 54;

{ Custom XFer flags }
	kXFer1PixelAtATime			= $00000001;					{  1 pixel passed to custom XFer proc }
	kXFerConvertPixelToRGB32	= $00000002;					{  All color depths converted to 32 bit RGB }


TYPE
	CustomXFerRecPtr = ^CustomXFerRec;
	CustomXFerRec = RECORD
		version:				UInt32;
		srcPixels:				Ptr;
		destPixels:				Ptr;
		resultPixels:			Ptr;
		refCon:					UInt32;
		pixelSize:				UInt32;
		pixelCount:				UInt32;
		firstPixelHV:			Point;
		destBounds:				Rect;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CustomXFerProcPtr = PROCEDURE(info: CustomXFerRecPtr);
{$ELSEC}
	CustomXFerProcPtr = ProcPtr;
{$ENDC}

FUNCTION GetPortCustomXFerProc(port: CGrafPtr; VAR proc: CustomXFerProcPtr; VAR flags: UInt32; VAR refCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0019, $AB1D;
	{$ENDC}
FUNCTION SetPortCustomXFerProc(port: CGrafPtr; proc: CustomXFerProcPtr; flags: UInt32; refCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $001A, $AB1D;
	{$ENDC}


CONST
	kCursorComponentsVersion	= $00010001;

	kCursorComponentType		= 'curs';

{ Cursor Component capabilities flags }
	cursorDoesAnimate			= $00000001;
	cursorDoesHardware			= $00000002;
	cursorDoesUnreadableScreenBits = $00000004;

{ Cursor Component output mode flags }
	kRenderCursorInHardware		= $00000001;
	kRenderCursorInSoftware		= $00000002;

{ Cursor Component Info }

TYPE
	CursorInfoPtr = ^CursorInfo;
	CursorInfo = RECORD
		version:				LONGINT;								{  use kCursorComponentsVersion  }
		capabilities:			LONGINT;
		animateDuration:		LONGINT;								{  approximate time between animate tickles  }
		bounds:					Rect;
		hotspot:				Point;
		reserved:				LONGINT;								{  must set to zero  }
	END;

{ Cursor Component Selectors }

CONST
	kCursorComponentInit		= $0001;
	kCursorComponentGetInfo		= $0002;
	kCursorComponentSetOutputMode = $0003;
	kCursorComponentSetData		= $0004;
	kCursorComponentReconfigure	= $0005;
	kCursorComponentDraw		= $0006;
	kCursorComponentErase		= $0007;
	kCursorComponentMove		= $0008;
	kCursorComponentAnimate		= $0009;
	kCursorComponentLastReserved = $0050;

FUNCTION OpenCursorComponent(c: Component; VAR ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000B, $ABE0;
	{$ENDC}
FUNCTION CloseCursorComponent(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000C, $ABE0;
	{$ENDC}
FUNCTION SetCursorComponent(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000D, $ABE0;
	{$ENDC}
FUNCTION CursorComponentChanged(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000E, $ABE0;
	{$ENDC}
FUNCTION CursorComponentSetData(ci: ComponentInstance; data: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000F, $ABE0;
	{$ENDC}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ GrafPort }
{ Getters }
FUNCTION GetPortPixMap(port: CGrafPtr): PixMapHandle;
FUNCTION GetPortBounds(port: CGrafPtr; VAR rect: Rect): RectPtr;
FUNCTION GetPortForeColor(port: CGrafPtr; VAR foreColor: RGBColor): RGBColorPtr;
FUNCTION GetPortBackColor(port: CGrafPtr; VAR backColor: RGBColor): RGBColorPtr;
FUNCTION GetPortOpColor(port: CGrafPtr; VAR opColor: RGBColor): RGBColorPtr;
FUNCTION GetPortHiliteColor(port: CGrafPtr; VAR hiliteColor: RGBColor): RGBColorPtr;
FUNCTION GetPortGrafProcs(port: CGrafPtr): CQDProcsPtr;
FUNCTION GetPortTextFont(port: CGrafPtr): INTEGER;
FUNCTION GetPortTextFace(port: CGrafPtr): ByteParameter;
FUNCTION GetPortTextMode(port: CGrafPtr): INTEGER;
FUNCTION GetPortTextSize(port: CGrafPtr): INTEGER;
FUNCTION GetPortChExtra(port: CGrafPtr): INTEGER;
FUNCTION GetPortFracHPenLocation(port: CGrafPtr): INTEGER;
FUNCTION GetPortSpExtra(port: CGrafPtr): Fixed;
FUNCTION GetPortPenVisibility(port: CGrafPtr): INTEGER;
FUNCTION GetPortVisibleRegion(port: CGrafPtr; visRgn: RgnHandle): RgnHandle;
FUNCTION GetPortClipRegion(port: CGrafPtr; clipRgn: RgnHandle): RgnHandle;
FUNCTION GetPortBackPixPat(port: CGrafPtr; backPattern: PixPatHandle): PixPatHandle;
FUNCTION GetPortPenPixPat(port: CGrafPtr; penPattern: PixPatHandle): PixPatHandle;
FUNCTION GetPortFillPixPat(port: CGrafPtr; fillPattern: PixPatHandle): PixPatHandle;
FUNCTION GetPortPenSize(port: CGrafPtr; VAR penSize: Point): PointPtr;
FUNCTION GetPortPenMode(port: CGrafPtr): SInt32;
FUNCTION GetPortPenLocation(port: CGrafPtr; VAR penLocation: Point): PointPtr;
FUNCTION IsPortRegionBeingDefined(port: CGrafPtr): BOOLEAN;
FUNCTION IsPortPictureBeingDefined(port: CGrafPtr): BOOLEAN;
FUNCTION IsPortOffscreen(port: CGrafPtr): BOOLEAN;
{ Setters }
PROCEDURE SetPortBounds(port: CGrafPtr; {CONST}VAR rect: Rect);
PROCEDURE SetPortOpColor(port: CGrafPtr; {CONST}VAR opColor: RGBColor);
PROCEDURE SetPortGrafProcs(port: CGrafPtr; VAR procs: CQDProcs);
PROCEDURE SetPortVisibleRegion(port: CGrafPtr; visRgn: RgnHandle);
PROCEDURE SetPortClipRegion(port: CGrafPtr; clipRgn: RgnHandle);
PROCEDURE SetPortPenPixPat(port: CGrafPtr; penPattern: PixPatHandle);
PROCEDURE SetPortBackPixPat(port: CGrafPtr; backPattern: PixPatHandle);
PROCEDURE SetPortPenSize(port: CGrafPtr; penSize: Point);
PROCEDURE SetPortPenMode(port: CGrafPtr; penMode: SInt32);
PROCEDURE SetPortFracHPenLocation(port: CGrafPtr; pnLocHFrac: INTEGER);
{ PixMap }
FUNCTION GetPixBounds(pixMap: PixMapHandle; VAR bounds: Rect): RectPtr;
FUNCTION GetPixDepth(pixMap: PixMapHandle): INTEGER;
{ QDGlobals }
{ Getters }
FUNCTION GetQDGlobalsRandomSeed: LONGINT;
FUNCTION GetQDGlobalsScreenBits(VAR screenBits: BitMap): BitMapPtr;
FUNCTION GetQDGlobalsArrow(VAR arrow: Cursor): CursorPtr;
FUNCTION GetQDGlobalsDarkGray(VAR dkGray: Pattern): PatternPtr;
FUNCTION GetQDGlobalsLightGray(VAR ltGray: Pattern): PatternPtr;
FUNCTION GetQDGlobalsGray(VAR gray: Pattern): PatternPtr;
FUNCTION GetQDGlobalsBlack(VAR black: Pattern): PatternPtr;
FUNCTION GetQDGlobalsWhite(VAR white: Pattern): PatternPtr;
FUNCTION GetQDGlobalsThePort: CGrafPtr;
{ Setters }
PROCEDURE SetQDGlobalsRandomSeed(randomSeed: LONGINT);
PROCEDURE SetQDGlobalsArrow({CONST}VAR arrow: Cursor);
{ Regions }
FUNCTION GetRegionBounds(region: RgnHandle; VAR bounds: Rect): RectPtr;
FUNCTION IsRegionRectangular(region: RgnHandle): BOOLEAN;
{ Utilities }
{ To prevent upward dependencies, GetPortWindow is defined in Window Manager interface: }
{		pascal WindowPtr		GetPortWindow(CGrafPtr port); }
{ NewPtr/OpenCPort doesn't work with opaque structures }
FUNCTION CreateNewPort: CGrafPtr;
PROCEDURE DisposePort(port: CGrafPtr);
{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{
   Routines available on Mac OS X to flush buffered window ports...
   These calls do nothing on Mac OS 8/9. QDIsPortBuffered will always return false there.
}

FUNCTION QDIsPortBuffered(port: CGrafPtr): BOOLEAN;
FUNCTION QDIsPortBufferDirty(port: CGrafPtr): BOOLEAN;
PROCEDURE QDFlushPortBuffer(port: CGrafPtr; region: RgnHandle);
FUNCTION QDGetDirtyRegion(port: CGrafPtr; rgn: RgnHandle): OSStatus;
FUNCTION QDSetDirtyRegion(port: CGrafPtr; rgn: RgnHandle): OSStatus;












{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickdrawIncludes}

{$ENDC} {__QUICKDRAW__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
