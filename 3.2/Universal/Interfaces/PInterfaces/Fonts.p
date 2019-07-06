{
 	File:		Fonts.p
 
 	Contains:	Font Manager Interfaces.
 
 	Version:	Technology:	MacOS 8
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Fonts;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FONTS__}
{$SETC __FONTS__ := 1}

{$I+}
{$SETC FontsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	systemFont					= 0;
	applFont					= 1;

{  kPlatformDefaultGuiFontID is used in QuickTime 3.0  }
{$IFC TARGET_OS_MAC }
	kPlatformDefaultGuiFontID	= 1;

{$ELSEC}
	kPlatformDefaultGuiFontID	= -1;

{$ENDC}  {TARGET_OS_MAC}

{
	The following font constants are deprecated.  
	Please use GetFNum() to look up the font ID by name.
}
	kFontIDNewYork				= 2;
	kFontIDGeneva				= 3;
	kFontIDMonaco				= 4;
	kFontIDVenice				= 5;
	kFontIDLondon				= 6;
	kFontIDAthens				= 7;
	kFontIDSanFrancisco			= 8;
	kFontIDToronto				= 9;
	kFontIDCairo				= 11;
	kFontIDLosAngeles			= 12;
	kFontIDTimes				= 20;
	kFontIDHelvetica			= 21;
	kFontIDCourier				= 22;
	kFontIDSymbol				= 23;
	kFontIDMobile				= 24;

{$IFC OLDROUTINENAMES }
	newYork						= 2;
	geneva						= 3;
	monaco						= 4;
	venice						= 5;
	london						= 6;
	athens						= 7;
	sanFran						= 8;
	toronto						= 9;
	cairo						= 11;
	losAngeles					= 12;
	times						= 20;
	helvetica					= 21;
	courier						= 22;
	symbol						= 23;
	mobile						= 24;

{$ENDC}  {OLDROUTINENAMES}

	commandMark					= 17;
	checkMark					= 18;
	diamondMark					= 19;
	appleMark					= 20;

	propFont					= 36864;
	prpFntH						= 36865;
	prpFntW						= 36866;
	prpFntHW					= 36867;
	fixedFont					= 45056;
	fxdFntH						= 45057;
	fxdFntW						= 45058;
	fxdFntHW					= 45059;
	fontWid						= 44208;


TYPE
	FMInputPtr = ^FMInput;
	FMInput = PACKED RECORD
		family:					INTEGER;
		size:					INTEGER;
		face:					Style;
		needBits:				BOOLEAN;
		device:					INTEGER;
		numer:					Point;
		denom:					Point;
	END;

	FMOutputPtr = ^FMOutput;
	FMOutput = PACKED RECORD
		errNum:					INTEGER;
		fontHandle:				Handle;									{  the previous "privateFontResult" was a mistake!  }
		boldPixels:				UInt8;
		italicPixels:			UInt8;
		ulOffset:				UInt8;
		ulShadow:				UInt8;
		ulThick:				UInt8;
		shadowPixels:			UInt8;
		extra:					SInt8;
		ascent:					UInt8;
		descent:				UInt8;
		widMax:					UInt8;
		leading:				SInt8;
		curStyle:				SInt8;
		numer:					Point;
		denom:					Point;
	END;

	FMOutPtr							= ^FMOutput;
	FontRecPtr = ^FontRec;
	FontRec = RECORD
		fontType:				INTEGER;								{ font type }
		firstChar:				INTEGER;								{ ASCII code of first character }
		lastChar:				INTEGER;								{ ASCII code of last character }
		widMax:					INTEGER;								{ maximum character width }
		kernMax:				INTEGER;								{ negative of maximum character kern }
		nDescent:				INTEGER;								{ negative of descent }
		fRectWidth:				INTEGER;								{ width of font rectangle }
		fRectHeight:			INTEGER;								{ height of font rectangle }
		owTLoc:					UInt16;									{ offset to offset/width table }
		ascent:					INTEGER;								{ ascent }
		descent:				INTEGER;								{ descent }
		leading:				INTEGER;								{ leading }
		rowWords:				INTEGER;								{ row width of bit image / 2  }
	END;

	FontRecHdl							= ^FontRecPtr;
	FMetricRecPtr = ^FMetricRec;
	FMetricRec = RECORD
		ascent:					Fixed;									{ base line to top }
		descent:				Fixed;									{ base line to bottom }
		leading:				Fixed;									{ leading between lines }
		widMax:					Fixed;									{ maximum character width }
		wTabHandle:				Handle;									{ handle to font width table }
	END;

{
   typedef struct FMetricRec FMetricRec, *FMetricRecPtr;
   typedef FMetricRecPtr *FMetricRecHandle;
}
	FMetricRecHandle					= ^FMetricRecPtr;
	WidEntryPtr = ^WidEntry;
	WidEntry = RECORD
		widStyle:				INTEGER;								{ style entry applies to }
	END;

	WidTablePtr = ^WidTable;
	WidTable = RECORD
		numWidths:				INTEGER;								{ number of entries - 1 }
	END;

	AsscEntryPtr = ^AsscEntry;
	AsscEntry = RECORD
		fontSize:				INTEGER;
		fontStyle:				INTEGER;
		fontID:					INTEGER;								{ font resource ID }
	END;

	FontAssocPtr = ^FontAssoc;
	FontAssoc = RECORD
		numAssoc:				INTEGER;								{ number of entries - 1 }
	END;

	StyleTablePtr = ^StyleTable;
	StyleTable = RECORD
		fontClass:				INTEGER;
		offset:					LONGINT;
		reserved:				LONGINT;
		indexes:				PACKED ARRAY [0..47] OF CHAR;
	END;

	NameTablePtr = ^NameTable;
	NameTable = RECORD
		stringCount:			INTEGER;
		baseFontName:			Str255;
	END;

	KernPairPtr = ^KernPair;
	KernPair = RECORD
		kernFirst:				SInt8;									{ 1st character of kerned pair }
		kernSecond:				SInt8;									{ 2nd character of kerned pair }
		kernWidth:				INTEGER;								{ kerning in 1pt fixed format }
	END;

	KernEntryPtr = ^KernEntry;
	KernEntry = RECORD
		kernStyle:				INTEGER;								{ style the entry applies to }
		kernLength:				INTEGER;								{ length of this entry }
	END;

	KernTablePtr = ^KernTable;
	KernTable = RECORD
		numKerns:				INTEGER;								{ number of kerning entries }
	END;

	WidthTablePtr = ^WidthTable;
	WidthTable = PACKED RECORD
		tabData:				ARRAY [0..255] OF Fixed;				{ character widths }
		tabFont:				Handle;									{ font record used to build table - the previous FontResult was a mistake! }
		sExtra:					LONGINT;								{ space extra used for table }
		style:					LONGINT;								{ extra due to style }
		fID:					INTEGER;								{ font family ID }
		fSize:					INTEGER;								{ font size request }
		face:					INTEGER;								{ style (face) request }
		device:					INTEGER;								{ device requested }
		inNumer:				Point;									{ scale factors requested }
		inDenom:				Point;									{ scale factors requested }
		aFID:					INTEGER;								{ actual font family ID for table }
		fHand:					Handle;									{ family record used to build up table }
		usedFam:				BOOLEAN;								{ used fixed point family widths }
		aFace:					UInt8;									{ actual face produced }
		vOutput:				INTEGER;								{ vertical scale output value }
		hOutput:				INTEGER;								{ horizontal scale output value }
		vFactor:				INTEGER;								{ vertical scale output value }
		hFactor:				INTEGER;								{ horizontal scale output value }
		aSize:					INTEGER;								{ actual size of actual font used }
		tabSize:				INTEGER;								{ total size of table }
	END;

	WidthTableHdl						= ^WidthTablePtr;

	FamRecPtr = ^FamRec;
	FamRec = RECORD
		ffFlags:				INTEGER;								{ flags for family }
		ffFamID:				INTEGER;								{ family ID number }
		ffFirstChar:			INTEGER;								{ ASCII code of 1st character }
		ffLastChar:				INTEGER;								{ ASCII code of last character }
		ffAscent:				INTEGER;								{ maximum ascent for 1pt font }
		ffDescent:				INTEGER;								{ maximum descent for 1pt font }
		ffLeading:				INTEGER;								{ maximum leading for 1pt font }
		ffWidMax:				INTEGER;								{ maximum widMax for 1pt font }
		ffWTabOff:				LONGINT;								{ offset to width table }
		ffKernOff:				LONGINT;								{ offset to kerning table }
		ffStylOff:				LONGINT;								{ offset to style mapping table }
		ffProperty:				ARRAY [0..8] OF INTEGER;				{ style property info }
		ffIntl:					ARRAY [0..1] OF INTEGER;				{ for international use }
		ffVersion:				INTEGER;								{ version number }
	END;

	FontPointSize						= SInt16;
	FontFamilyID						= SInt16;
PROCEDURE InitFonts;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FE;
	{$ENDC}
PROCEDURE GetFontName(familyID: INTEGER; VAR name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FF;
	{$ENDC}
PROCEDURE GetFNum(name: Str255; VAR familyID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A900;
	{$ENDC}
FUNCTION RealFont(fontNum: INTEGER; size: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A902;
	{$ENDC}
PROCEDURE SetFontLock(lockFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A903;
	{$ENDC}
FUNCTION FMSwapFont({CONST}VAR inRec: FMInput): FMOutPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A901;
	{$ENDC}
PROCEDURE SetFScaleDisable(fscaleDisable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A834;
	{$ENDC}
PROCEDURE FontMetrics(theMetrics: FMetricRecPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A835;
	{$ENDC}
PROCEDURE SetFractEnable(fractEnable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A814;
	{$ENDC}
FUNCTION GetDefFontSize: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BA8, $6604, $3EBC, $000C;
	{$ENDC}
FUNCTION IsOutline(numer: Point; denom: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A854;
	{$ENDC}
PROCEDURE SetOutlinePreferred(outlinePreferred: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A854;
	{$ENDC}
FUNCTION GetOutlinePreferred: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $A854;
	{$ENDC}
FUNCTION OutlineMetrics(byteCount: INTEGER; textPtr: UNIV Ptr; numer: Point; denom: Point; VAR yMax: INTEGER; VAR yMin: INTEGER; awArray: FixedPtr; lsbArray: FixedPtr; boundsArray: RectPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A854;
	{$ENDC}
PROCEDURE SetPreserveGlyph(preserveGlyph: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $A854;
	{$ENDC}
FUNCTION GetPreserveGlyph: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A854;
	{$ENDC}
FUNCTION FlushFonts: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A854;
	{$ENDC}
FUNCTION GetSysFont: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BA6;
	{$ENDC}
FUNCTION GetAppFont: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0984;
	{$ENDC}
{---------------------------------------------------------------------------------}
FUNCTION SetAntiAliasedTextEnabled(inEnable: BOOLEAN; inMinFontSize: SInt16): OSStatus;
FUNCTION IsAntiAliasedTextEnabled(VAR outMinFontSize: SInt16): BOOLEAN;
{---------------------------------------------------------------------------------}
PROCEDURE QDTextBounds(byteCount: INTEGER; textAddr: UNIV Ptr; VAR bounds: Rect);
FUNCTION FetchFontInfo(fontID: SInt16; fontSize: SInt16; fontStyle: SInt16; VAR info: FontInfo): OSErr;
{---------------------------------------------------------------------------------}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FontsIncludes}

{$ENDC} {__FONTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
