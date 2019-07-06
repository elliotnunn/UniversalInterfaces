{
 	File:		Fonts.p
 
 	Contains:	Public interface to the Font Manager.
 
 	Version:	Technology:	Mac OS
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
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	systemFont					= 0;
	applFont					= 1;

{ kPlatformDefaultGuiFontID is used in QuickTime 3.0. }
{$IFC TARGET_OS_MAC }
	kPlatformDefaultGuiFontID	= 1;

{$ELSEC}
	kPlatformDefaultGuiFontID	= -1;

{$ENDC}  {TARGET_OS_MAC}

{	The following font constants are deprecated; use GetFNum() to look up the font ID by name. }
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
		fontHandle:				Handle;
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

	FMOutPtr							= FMOutputPtr;
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
		tabFont:				Handle;									{ font record used to build table }
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
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE InitFonts;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FE;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetFontLock(lockFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A903;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
FUNCTION FlushFonts: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A854;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION GetSysFont: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BA6;
	{$ENDC}
FUNCTION GetAppFont: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0984;
	{$ENDC}
{--------------------------------------------------------------------------------------}
{	Extended font data functions (available only with Mac OS 8.5 or later)				}
{--------------------------------------------------------------------------------------}
FUNCTION SetAntiAliasedTextEnabled(iEnable: BOOLEAN; iMinFontSize: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $A854;
	{$ENDC}
FUNCTION IsAntiAliasedTextEnabled(VAR oMinFontSize: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $A854;
	{$ENDC}
PROCEDURE QDTextBounds(byteCount: INTEGER; textAddr: UNIV Ptr; VAR bounds: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $A854;
	{$ENDC}
FUNCTION FetchFontInfo(fontID: SInt16; fontSize: SInt16; fontStyle: SInt16; VAR info: FontInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $A854;
	{$ENDC}
{--------------------------------------------------------------------------------------}
{	Font access and data management functions (available only with Mac OS 9.0 or later)	}
{--------------------------------------------------------------------------------------}

TYPE
	FMGeneration						= UInt32;
{ The FMFontFamily reference represents a collection of fonts with the same design     }
{ characteristics. It replaces the standard QuickDraw font identifer and may be used   }
{ with all QuickDraw functions including GetFontName and TextFont. It cannot be used   }
{ with the Resource Manager to access information from a FOND resource handle. A font  }
{ reference does not imply a particular script system, nor is the character encoding   }
{ of a font family determined by an arithmetic mapping of its value.                   }
	FMFontFamily						= SInt16;
	FMFontStyle							= SInt16;
	FMFontSize							= SInt16;
{ The font family is a collection of fonts, each of which is identified by an FMFont   }
{ reference that maps to a single object registered with the font database. The font	}
{ references associated with the font family consist of individual outline and         }
{ bitmapped fonts that may be used with the font access routines of the Font Manager   }
{ and ATS Unicode. }
	FMFont								= UInt32;
	FMFontFamilyInstancePtr = ^FMFontFamilyInstance;
	FMFontFamilyInstance = RECORD
		fontFamily:				FMFontFamily;
		fontStyle:				FMFontStyle;
	END;

	FMFontFamilyIteratorPtr = ^FMFontFamilyIterator;
	FMFontFamilyIterator = RECORD
		reserved:				ARRAY [0..15] OF UInt32;
	END;

	FMFontIteratorPtr = ^FMFontIterator;
	FMFontIterator = RECORD
		reserved:				ARRAY [0..15] OF UInt32;
	END;

	FMFontFamilyInstanceIteratorPtr = ^FMFontFamilyInstanceIterator;
	FMFontFamilyInstanceIterator = RECORD
		reserved:				ARRAY [0..15] OF UInt32;
	END;


CONST
	kInvalidGeneration			= 0;
	kInvalidFontFamily			= -1;
	kInvalidFont				= 0;
	kFMCurrentFilterFormat		= 0;
	kFMDefaultOptions			= 0;
	kFMUseGlobalScopeOption		= $00000001;


TYPE
	FMFilterSelector 			= UInt32;
CONST
	kFMInvalidFilterSelector	= 0;
	kFMFontTechnologyFilterSelector = 1;
	kFMFontContainerFilterSelector = 2;
	kFMGenerationFilterSelector	= 3;
	kFMFontFamilyCallbackFilterSelector = 4;
	kFMFontCallbackFilterSelector = 5;

	kFMTrueTypeFontTechnology	= 'true';
	kFMPostScriptFontTechnology	= 'typ1';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	FMFontFamilyCallbackFilterProcPtr = FUNCTION(iFontFamily: FMFontFamily; iRefCon: UNIV Ptr): OSStatus;
{$ELSEC}
	FMFontFamilyCallbackFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FMFontCallbackFilterProcPtr = FUNCTION(iFont: FMFont; iRefCon: UNIV Ptr): OSStatus;
{$ELSEC}
	FMFontCallbackFilterProcPtr = ProcPtr;
{$ENDC}

	FMFontFamilyCallbackFilterUPP = UniversalProcPtr;
	FMFontCallbackFilterUPP = UniversalProcPtr;

CONST
	uppFMFontFamilyCallbackFilterProcInfo = $000003B0;
	uppFMFontCallbackFilterProcInfo = $000003F0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewFMFontFamilyCallbackFilterUPP(userRoutine: FMFontFamilyCallbackFilterProcPtr): FMFontFamilyCallbackFilterUPP; { old name was NewFMFontFamilyCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFMFontCallbackFilterUPP(userRoutine: FMFontCallbackFilterProcPtr): FMFontCallbackFilterUPP; { old name was NewFMFontCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeFMFontFamilyCallbackFilterUPP(userUPP: FMFontFamilyCallbackFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeFMFontCallbackFilterUPP(userUPP: FMFontCallbackFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeFMFontFamilyCallbackFilterUPP(iFontFamily: FMFontFamily; iRefCon: UNIV Ptr; userRoutine: FMFontFamilyCallbackFilterUPP): OSStatus; { old name was CallFMFontFamilyCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeFMFontCallbackFilterUPP(iFont: FMFont; iRefCon: UNIV Ptr; userRoutine: FMFontCallbackFilterUPP): OSStatus; { old name was CallFMFontCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	FMFilterPtr = ^FMFilter;
	FMFilter = RECORD
		format:					UInt32;
		selector:				FMFilterSelector;
		CASE INTEGER OF
		0: (
			fontTechnologyFilter: FourCharCode;
			);
		1: (
			fontContainerFilter: FSSpec;
			);
		2: (
			generationFilter:	FMGeneration;
			);
		3: (
			fontFamilyCallbackFilter: FMFontFamilyCallbackFilterUPP;
			);
		4: (
			fontCallbackFilter:	FMFontCallbackFilterUPP;
			);
	END;


CONST
	kFMIterationCompleted		= -980;
	kFMInvalidFontFamilyErr		= -981;
	kFMInvalidFontErr			= -982;
	kFMIterationScopeModifiedErr = -983;
	kFMFontTableAccessErr		= -984;
	kFMFontContainerAccessErr	= -985;

{ Enumeration }
FUNCTION FMCreateFontFamilyIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontFamilyIterator): OSStatus; C;
FUNCTION FMDisposeFontFamilyIterator(VAR ioIterator: FMFontFamilyIterator): OSStatus; C;
FUNCTION FMResetFontFamilyIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontFamilyIterator): OSStatus; C;
FUNCTION FMGetNextFontFamily(VAR ioIterator: FMFontFamilyIterator; VAR oFontFamily: FMFontFamily): OSStatus; C;
FUNCTION FMCreateFontIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontIterator): OSStatus; C;
FUNCTION FMDisposeFontIterator(VAR ioIterator: FMFontIterator): OSStatus; C;
FUNCTION FMResetFontIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontIterator): OSStatus; C;
FUNCTION FMGetNextFont(VAR ioIterator: FMFontIterator; VAR oFont: FMFont): OSStatus; C;
{ Font families }
FUNCTION FMCreateFontFamilyInstanceIterator(iFontFamily: FMFontFamily; VAR ioIterator: FMFontFamilyInstanceIterator): OSStatus; C;
FUNCTION FMDisposeFontFamilyInstanceIterator(VAR ioIterator: FMFontFamilyInstanceIterator): OSStatus; C;
FUNCTION FMResetFontFamilyInstanceIterator(iFontFamily: FMFontFamily; VAR ioIterator: FMFontFamilyInstanceIterator): OSStatus; C;
FUNCTION FMGetNextFontFamilyInstance(VAR ioIterator: FMFontFamilyInstanceIterator; VAR oFont: FMFont; VAR oStyle: FMFontStyle; VAR oSize: FMFontSize): OSStatus; C;
FUNCTION FMGetFontFamilyFromName(iName: Str255): FMFontFamily; C;
FUNCTION FMGetFontFamilyName(iFontFamily: FMFontFamily; VAR oName: Str255): OSStatus; C;
FUNCTION FMGetFontFamilyTextEncoding(iFontFamily: FMFontFamily; VAR oTextEncoding: TextEncoding): OSStatus; C;
FUNCTION FMGetFontFamilyGeneration(iFontFamily: FMFontFamily; VAR oGeneration: FMGeneration): OSStatus; C;
{ Fonts }
FUNCTION FMGetFontFormat(iFont: FMFont; VAR oFormat: FourCharCode): OSStatus; C;
FUNCTION FMGetFontTableDirectory(iFont: FMFont; iLength: ByteCount; iBuffer: UNIV Ptr; VAR oActualLength: ByteCount): OSStatus; C;
FUNCTION FMGetFontTable(iFont: FMFont; iTag: FourCharCode; iOffset: ByteOffset; iLength: ByteCount; iBuffer: UNIV Ptr; VAR oActualLength: ByteCount): OSStatus; C;
FUNCTION FMGetFontGeneration(iFont: FMFont; VAR oGeneration: FMGeneration): OSStatus; C;
FUNCTION FMGetFontContainer(iFont: FMFont; VAR oFontContainer: FSSpec): OSStatus; C;
{ Conversion }
FUNCTION FMGetFontFromFontFamilyInstance(iFontFamily: FMFontFamily; iStyle: FMFontStyle; VAR oFont: FMFont; VAR oIntrinsicStyle: FMFontStyle): OSStatus; C;
FUNCTION FMGetFontFamilyInstanceFromFont(iFont: FMFont; VAR oFontFamily: FMFontFamily; VAR oStyle: FMFontStyle): OSStatus; C;
{ Activation }
FUNCTION FMActivateFonts({CONST}VAR iFontContainer: FSSpec; iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits): OSStatus; C;
FUNCTION FMDeactivateFonts({CONST}VAR iFontContainer: FSSpec; iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits): OSStatus; C;
FUNCTION FMGetGeneration: FMGeneration; C;

TYPE
	FontFamilyID						= FMFontFamily;
{--------------------------------------------------------------------------------------}
{$IFC OLDROUTINENAMES }

CONST
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

{--------------------------------------------------------------------------------------}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FontsIncludes}

{$ENDC} {__FONTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
