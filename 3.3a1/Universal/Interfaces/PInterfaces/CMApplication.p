{
 	File:		CMApplication.p
 
 	Contains:	Color Matching Interfaces
 
 	Version:	Technology:	ColorSync 3.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1992, 1994-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMAPPLICATION__}
{$SETC __CMAPPLICATION__ := 1}

{$I+}
{$SETC CMApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CMICCPROFILE__}
{$I CMICCProfile.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC TARGET_API_MAC_OS8 }
{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{$ENDC}  {TARGET_API_MAC_OS8}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kDefaultCMMSignature		= 'appl';

{ Macintosh 68K trap word }
	cmTrap						= $ABEE;


{ PicComment IDs }
	cmBeginProfile				= 220;
	cmEndProfile				= 221;
	cmEnableMatching			= 222;
	cmDisableMatching			= 223;
	cmComment					= 224;

{ PicComment selectors for cmComment }
	cmBeginProfileSel			= 0;
	cmContinueProfileSel		= 1;
	cmEndProfileSel				= 2;
	cmProfileIdentifierSel		= 3;


{ Defines for version 1.0 CMProfileSearchRecord.fieldMask }
	cmMatchCMMType				= $00000001;
	cmMatchApplProfileVersion	= $00000002;
	cmMatchDataType				= $00000004;
	cmMatchDeviceType			= $00000008;
	cmMatchDeviceManufacturer	= $00000010;
	cmMatchDeviceModel			= $00000020;
	cmMatchDeviceAttributes		= $00000040;
	cmMatchFlags				= $00000080;
	cmMatchOptions				= $00000100;
	cmMatchWhite				= $00000200;
	cmMatchBlack				= $00000400;

{ Defines for version 2.0 CMSearchRecord.searchMask }
	cmMatchAnyProfile			= $00000000;
	cmMatchProfileCMMType		= $00000001;
	cmMatchProfileClass			= $00000002;
	cmMatchDataColorSpace		= $00000004;
	cmMatchProfileConnectionSpace = $00000008;
	cmMatchManufacturer			= $00000010;
	cmMatchModel				= $00000020;
	cmMatchAttributes			= $00000040;
	cmMatchProfileFlags			= $00000080;

{ Result codes }
																{  General Errors  }
	cmProfileError				= -170;
	cmMethodError				= -171;
	cmMethodNotFound			= -175;							{  CMM not present  }
	cmProfileNotFound			= -176;							{  Responder error  }
	cmProfilesIdentical			= -177;							{  Profiles the same  }
	cmCantConcatenateError		= -178;							{  Profile can't be concatenated  }
	cmCantXYZ					= -179;							{  CMM cant handle XYZ space  }
	cmCantDeleteProfile			= -180;							{  Responder error  }
	cmUnsupportedDataType		= -181;							{  Responder error  }
	cmNoCurrentProfile			= -182;							{  Responder error  }
																{  Profile Access Errors  }
	cmElementTagNotFound		= -4200;
	cmIndexRangeErr				= -4201;						{  Tag index out of range  }
	cmCantDeleteElement			= -4202;
	cmFatalProfileErr			= -4203;
	cmInvalidProfile			= -4204;						{  A Profile must contain a 'cs1 ' tag to be valid  }
	cmInvalidProfileLocation	= -4205;						{  Operation not supported for this profile location  }
	cmCantCopyModifiedV1Profile	= -4215;						{  Illegal to copy version 1 profiles that have been modified  }
																{  Profile Search Errors  }
	cmInvalidSearch				= -4206;						{  Bad Search Handle  }
	cmSearchError				= -4207;
	cmErrIncompatibleProfile	= -4208;						{  Other ColorSync Errors  }
	cmInvalidColorSpace			= -4209;						{  Profile colorspace does not match bitmap type  }
	cmInvalidSrcMap				= -4210;						{  Source pix/bit map was invalid  }
	cmInvalidDstMap				= -4211;						{  Destination pix/bit map was invalid  }
	cmNoGDevicesError			= -4212;						{  Begin/End Matching -- no gdevices available  }
	cmInvalidProfileComment		= -4213;						{  Bad Profile comment during drawpicture  }
	cmRangeOverFlow				= -4214;						{  Color conversion warning that some output color values over/underflowed and were clipped  }
	cmNamedColorNotFound		= -4216;						{  NamedColor not found  }
	cmCantGamutCheckError		= -4217;						{  Gammut checking not supported by this ColorWorld  }

{ deviceType values for ColorSync 1.0 Device Profile access }
	cmSystemDevice				= 'sys ';
	cmGDevice					= 'gdev';

{ Commands for CMFlattenUPP(…) }
	cmOpenReadSpool				= 1;
	cmOpenWriteSpool			= 2;
	cmReadSpool					= 3;
	cmWriteSpool				= 4;
	cmCloseSpool				= 5;

{ Flags for PostScript-related functions }
	cmPS7bit					= 1;
	cmPS8bit					= 2;

{ Flags for profile embedding functions }
	cmEmbedWholeProfile			= $00000000;
	cmEmbedProfileIdentifier	= $00000001;

{ Commands for CMAccessUPP(…) }
	cmOpenReadAccess			= 1;
	cmOpenWriteAccess			= 2;
	cmReadAccess				= 3;
	cmWriteAccess				= 4;
	cmCloseAccess				= 5;
	cmCreateNewAccess			= 6;
	cmAbortWriteAccess			= 7;
	cmBeginAccess				= 8;
	cmEndAccess					= 9;


{ Abstract data type for memory-based Profile }

TYPE
	CMProfileRef = ^LONGINT; { an opaque 32-bit type }
{ Abstract data type for Profile search result }
	CMProfileSearchRef = ^LONGINT; { an opaque 32-bit type }
{ Abstract data type for BeginMatching(…) reference }
	CMMatchRef = ^LONGINT; { an opaque 32-bit type }
{ Abstract data type for ColorWorld reference }
	CMWorldRef = ^LONGINT; { an opaque 32-bit type }
{ Caller-supplied flatten function }
{$IFC TYPED_FUNCTION_POINTERS}
	CMFlattenProcPtr = FUNCTION(command: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMFlattenProcPtr = ProcPtr;
{$ENDC}

{ Caller-supplied progress function for Bitmap & PixMap matching routines }
{$IFC TYPED_FUNCTION_POINTERS}
	CMBitmapCallBackProcPtr = FUNCTION(progress: LONGINT; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	CMBitmapCallBackProcPtr = ProcPtr;
{$ENDC}

{ Caller-supplied progress function for NCMMConcatInit & NCMMNewLinkProfile routines }
{$IFC TYPED_FUNCTION_POINTERS}
	CMConcatCallBackProcPtr = FUNCTION(progress: LONGINT; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	CMConcatCallBackProcPtr = ProcPtr;
{$ENDC}

{ Caller-supplied filter function for Profile search }
{$IFC TYPED_FUNCTION_POINTERS}
	CMProfileFilterProcPtr = FUNCTION(prof: CMProfileRef; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	CMProfileFilterProcPtr = ProcPtr;
{$ENDC}

{ Caller-supplied function for profile access }
{$IFC TYPED_FUNCTION_POINTERS}
	CMProfileAccessProcPtr = FUNCTION(command: LONGINT; offset: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMProfileAccessProcPtr = ProcPtr;
{$ENDC}

	CMFlattenUPP = UniversalProcPtr;
	CMBitmapCallBackUPP = UniversalProcPtr;
	CMConcatCallBackUPP = UniversalProcPtr;
	CMProfileFilterUPP = UniversalProcPtr;
	CMProfileAccessUPP = UniversalProcPtr;

CONST
	uppCMFlattenProcInfo = $00003FE0;
	uppCMBitmapCallBackProcInfo = $000003D0;
	uppCMConcatCallBackProcInfo = $000003D0;
	uppCMProfileFilterProcInfo = $000003D0;
	uppCMProfileAccessProcInfo = $0000FFE0;

FUNCTION NewCMFlattenUPP(userRoutine: CMFlattenProcPtr): CMFlattenUPP; { old name was NewCMFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMBitmapCallBackUPP(userRoutine: CMBitmapCallBackProcPtr): CMBitmapCallBackUPP; { old name was NewCMBitmapCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMConcatCallBackUPP(userRoutine: CMConcatCallBackProcPtr): CMConcatCallBackUPP; { old name was NewCMConcatCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMProfileFilterUPP(userRoutine: CMProfileFilterProcPtr): CMProfileFilterUPP; { old name was NewCMProfileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMProfileAccessUPP(userRoutine: CMProfileAccessProcPtr): CMProfileAccessUPP; { old name was NewCMProfileAccessProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeCMFlattenUPP(userUPP: CMFlattenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCMBitmapCallBackUPP(userUPP: CMBitmapCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCMConcatCallBackUPP(userUPP: CMConcatCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCMProfileFilterUPP(userUPP: CMProfileFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCMProfileAccessUPP(userUPP: CMProfileAccessUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeCMFlattenUPP(command: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CMFlattenUPP): OSErr; { old name was CallCMFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCMBitmapCallBackUPP(progress: LONGINT; refCon: UNIV Ptr; userRoutine: CMBitmapCallBackUPP): BOOLEAN; { old name was CallCMBitmapCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCMConcatCallBackUPP(progress: LONGINT; refCon: UNIV Ptr; userRoutine: CMConcatCallBackUPP): BOOLEAN; { old name was CallCMConcatCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCMProfileFilterUPP(prof: CMProfileRef; refCon: UNIV Ptr; userRoutine: CMProfileFilterUPP): BOOLEAN; { old name was CallCMProfileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCMProfileAccessUPP(command: LONGINT; offset: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CMProfileAccessUPP): OSErr; { old name was CallCMProfileAccessProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	CMError								= LONGINT;
{ For 1.0 and 2.0 profile header variants }
{ CMAppleProfileHeader }
	CMAppleProfileHeaderPtr = ^CMAppleProfileHeader;
	CMAppleProfileHeader = RECORD
		CASE INTEGER OF
		0: (
			cm1:				CMHeader;
			);
		1: (
			cm2:				CM2Header;
			);
	END;

{ Param for CWConcatColorWorld(…) }
	CMConcatProfileSetPtr = ^CMConcatProfileSet;
	CMConcatProfileSet = RECORD
		keyIndex:				UInt16;									{  Zero-based  }
		count:					UInt16;									{  Min 1  }
		profileSet:				ARRAY [0..0] OF CMProfileRef;			{  Variable. Ordered from Source -> Dest  }
	END;


{ NCMConcatProfileSpec Tags }

CONST
	kNoTransform				= 0;							{  Not used  }
	kUseAtoB					= 1;							{  Use 'A2B*' tag from this profile or equivalent  }
	kUseBtoA					= 2;							{  Use 'B2A*' tag from this profile or equivalent  }
	kUseBtoB					= 3;							{  Use 'pre*' tag from this profile or equivalent  }
																{  For typical device profiles the following synonyms may be useful  }
	kDeviceToPCS				= 1;							{  Device Dependent to Device Independent  }
	kPCSToDevice				= 2;							{  Device Independent to Device Dependent  }
	kPCSToPCS					= 3;							{  Independent, through device's gamut  }
	kUseProfileIntent			= $FFFFFFFF;					{  For renderingIntent in NCMConcatProfileSpec	 }

{ NCMConcatProfileSpec }

TYPE
	NCMConcatProfileSpecPtr = ^NCMConcatProfileSpec;
	NCMConcatProfileSpec = RECORD
		renderingIntent:		UInt32;									{  renderingIntent override		 }
		transformTag:			UInt32;									{  transformTag, defined above	 }
		profile:				CMProfileRef;							{  profile  }
	END;

{ NCMConcatProfileSet }
	NCMConcatProfileSetPtr = ^NCMConcatProfileSet;
	NCMConcatProfileSet = RECORD
		cmm:					OSType;									{  e.g. 'KCMS', 'appl', ...  uniquely ids the cmm, or 0000  }
		flags:					UInt32;									{  specify quality, lookup only, no gamut checking ...  }
		flagsMask:				UInt32;									{  which bits of 'flags' to use to override profile  }
		profileCount:			UInt32;									{  how many ProfileSpecs in the following set  }
		profileSpecs:			ARRAY [0..0] OF NCMConcatProfileSpec;	{  Variable. Ordered from Source -> Dest  }
	END;

{ ColorSync color data types }
	CMRGBColorPtr = ^CMRGBColor;
	CMRGBColor = RECORD
		red:					UInt16;									{  0..65535  }
		green:					UInt16;
		blue:					UInt16;
	END;

	CMCMYKColorPtr = ^CMCMYKColor;
	CMCMYKColor = RECORD
		cyan:					UInt16;									{  0..65535  }
		magenta:				UInt16;
		yellow:					UInt16;
		black:					UInt16;
	END;

	CMCMYColorPtr = ^CMCMYColor;
	CMCMYColor = RECORD
		cyan:					UInt16;									{  0..65535  }
		magenta:				UInt16;
		yellow:					UInt16;
	END;

	CMHLSColorPtr = ^CMHLSColor;
	CMHLSColor = RECORD
		hue:					UInt16;									{  0..65535. Fraction of circle. Red at 0  }
		lightness:				UInt16;									{  0..65535  }
		saturation:				UInt16;									{  0..65535  }
	END;

	CMHSVColorPtr = ^CMHSVColor;
	CMHSVColor = RECORD
		hue:					UInt16;									{  0..65535. Fraction of circle. Red at 0  }
		saturation:				UInt16;									{  0..65535  }
		value:					UInt16;									{  0..65535  }
	END;

	CMLabColorPtr = ^CMLabColor;
	CMLabColor = RECORD
		L:						UInt16;									{  0..65535 maps to 0..100  }
		a:						UInt16;									{  0..65535 maps to -128..127.996  }
		b:						UInt16;									{  0..65535 maps to -128..127.996  }
	END;

	CMLuvColorPtr = ^CMLuvColor;
	CMLuvColor = RECORD
		L:						UInt16;									{  0..65535 maps to 0..100  }
		u:						UInt16;									{  0..65535 maps to -128..127.996  }
		v:						UInt16;									{  0..65535 maps to -128..127.996  }
	END;

	CMYxyColorPtr = ^CMYxyColor;
	CMYxyColor = RECORD
		capY:					UInt16;									{  0..65535 maps to 0..1  }
		x:						UInt16;									{  0..65535 maps to 0..1  }
		y:						UInt16;									{  0..65535 maps to 0..1  }
	END;

	CMGrayColorPtr = ^CMGrayColor;
	CMGrayColor = RECORD
		gray:					UInt16;									{  0..65535  }
	END;

	CMMultichannel5ColorPtr = ^CMMultichannel5Color;
	CMMultichannel5Color = RECORD
		components:				PACKED ARRAY [0..4] OF UInt8;			{  0..255  }
	END;

	CMMultichannel6ColorPtr = ^CMMultichannel6Color;
	CMMultichannel6Color = RECORD
		components:				PACKED ARRAY [0..5] OF UInt8;			{  0..255  }
	END;

	CMMultichannel7ColorPtr = ^CMMultichannel7Color;
	CMMultichannel7Color = RECORD
		components:				PACKED ARRAY [0..6] OF UInt8;			{  0..255  }
	END;

	CMMultichannel8ColorPtr = ^CMMultichannel8Color;
	CMMultichannel8Color = RECORD
		components:				PACKED ARRAY [0..7] OF UInt8;			{  0..255  }
	END;

	CMNamedColorPtr = ^CMNamedColor;
	CMNamedColor = RECORD
		namedColorIndex:		UInt32;									{  0..a lot  }
	END;

	CMColorPtr = ^CMColor;
	CMColor = RECORD
		CASE INTEGER OF
		0: (
			rgb:				CMRGBColor;
			);
		1: (
			hsv:				CMHSVColor;
			);
		2: (
			hls:				CMHLSColor;
			);
		3: (
			XYZ:				CMXYZColor;
			);
		4: (
			Lab:				CMLabColor;
			);
		5: (
			Luv:				CMLuvColor;
			);
		6: (
			Yxy:				CMYxyColor;
			);
		7: (
			cmyk:				CMCMYKColor;
			);
		8: (
			cmy:				CMCMYColor;
			);
		9: (
			gray:				CMGrayColor;
			);
		10: (
			mc5:				CMMultichannel5Color;
			);
		11: (
			mc6:				CMMultichannel6Color;
			);
		12: (
			mc7:				CMMultichannel7Color;
			);
		13: (
			mc8:				CMMultichannel8Color;
			);
		14: (
			namedColor:			CMNamedColor;
			);
	END;

	CMProfileSearchRecordPtr = ^CMProfileSearchRecord;
	CMProfileSearchRecord = RECORD
		header:					CMHeader;
		fieldMask:				UInt32;
		reserved:				ARRAY [0..1] OF UInt32;
	END;

	CMProfileSearchRecordHandle			= ^CMProfileSearchRecordPtr;
{ Search definition for 2.0 }
	CMSearchRecordPtr = ^CMSearchRecord;
	CMSearchRecord = RECORD
		CMMType:				OSType;
		profileClass:			OSType;
		dataColorSpace:			OSType;
		profileConnectionSpace:	OSType;
		deviceManufacturer:		UInt32;
		deviceModel:			UInt32;
		deviceAttributes:		ARRAY [0..1] OF UInt32;
		profileFlags:			UInt32;
		searchMask:				UInt32;
		filter:					CMProfileFilterUPP;
	END;

{ CMMInfo structure }
	CMMInfoPtr = ^CMMInfo;
	CMMInfo = RECORD
		dataSize:				UInt32;									{  Size of this structure - compatibility }
		CMMType:				OSType;									{  Signature, e.g. 'KCMS' }
		CMMMfr:					OSType;									{  Vendor, e.g. 'appl' }
		CMMVersion:				UInt32;									{  cmm version number }
		ASCIIName:				PACKED ARRAY [0..31] OF UInt8;			{  pascal string - name }
		ASCIIDesc:				PACKED ARRAY [0..255] OF UInt8;			{  pascal string - description or copyright }
		UniCodeNameCount:		UniCharCount;							{  count of UniChars in following array }
		UniCodeName:			ARRAY [0..31] OF UniChar;				{  the name in UniCode chars }
		UniCodeDescCount:		UniCharCount;							{  count of UniChars in following array }
		UniCodeDesc:			ARRAY [0..255] OF UniChar;				{  the description in UniCode chars }
	END;

{ GetCWInfo structures }
	CMMInfoRecordPtr = ^CMMInfoRecord;
	CMMInfoRecord = RECORD
		CMMType:				OSType;
		CMMVersion:				LONGINT;
	END;

	CMCWInfoRecordPtr = ^CMCWInfoRecord;
	CMCWInfoRecord = RECORD
		cmmCount:				UInt32;
		cmmInfo:				ARRAY [0..1] OF CMMInfoRecord;
	END;

{ profile identifier structures }
	CMProfileIdentifierPtr = ^CMProfileIdentifier;
	CMProfileIdentifier = RECORD
		profileHeader:			CM2Header;
		calibrationDate:		CMDateTime;
		ASCIIProfileDescriptionLen: UInt32;
		ASCIIProfileDescription: SInt8;									{  variable length  }
	END;

{ packing formats }

CONST
	cmNoColorPacking			= $0000;
	cmWord5ColorPacking			= $0500;
	cmWord565ColorPacking		= $0600;
	cmLong8ColorPacking			= $0800;
	cmLong10ColorPacking		= $0A00;
	cmAlphaFirstPacking			= $1000;
	cmOneBitDirectPacking		= $0B00;
	cmAlphaLastPacking			= $0000;
	cm8_8ColorPacking			= $2800;
	cm16_8ColorPacking			= $2000;
	cm24_8ColorPacking			= $2100;
	cm32_8ColorPacking			= $0800;
	cm40_8ColorPacking			= $2200;
	cm48_8ColorPacking			= $2300;
	cm56_8ColorPacking			= $2400;
	cm64_8ColorPacking			= $2500;
	cm32_16ColorPacking			= $2600;
	cm48_16ColorPacking			= $2900;
	cm64_16ColorPacking			= $2A00;
	cm32_32ColorPacking			= $2700;
	cmLittleEndianPacking		= $4000;
	cmReverseChannelPacking		= $8000;

{ colorspace masks }
	cmColorSpaceSpaceMask		= $0000007F;
	cmColorSpaceAlphaMask		= $00000080;
	cmColorSpaceSpaceAndAlphaMask = $000000FF;
	cmColorSpacePackingMask		= $0000FF00;
	cmColorSpaceReservedMask	= $FFFF0000;

{ general colorspaces }
	cmNoSpace					= 0;
	cmRGBSpace					= 1;
	cmCMYKSpace					= 2;
	cmHSVSpace					= 3;
	cmHLSSpace					= 4;
	cmYXYSpace					= 5;
	cmXYZSpace					= 6;
	cmLUVSpace					= 7;
	cmLABSpace					= 8;
	cmReservedSpace1			= 9;
	cmGraySpace					= 10;
	cmReservedSpace2			= 11;
	cmGamutResultSpace			= 12;
	cmNamedIndexedSpace			= 16;
	cmMCFiveSpace				= 17;
	cmMCSixSpace				= 18;
	cmMCSevenSpace				= 19;
	cmMCEightSpace				= 20;
	cmAlphaSpace				= $80;
	cmRGBASpace					= 129;
	cmGrayASpace				= 138;

{ supported CMBitmapColorSpaces - Each of the following is a }
{ combination of a general colospace and a packing formats. }
{ Each can also be or'd with cmReverseChannelPacking. }
	cmGray8Space				= 10250;
	cmGrayA16Space				= 8330;
	cmGray16Space				= 10;
	cmGrayA32Space				= 138;
	cmGray16LSpace				= 16394;
	cmGrayA32LSpace				= 16522;
	cmRGB16Space				= 1281;
	cmRGB16LSpace				= 17665;
	cmRGB565Space				= 1537;
	cmRGB565LSpace				= 17921;
	cmRGB24Space				= 8449;
	cmRGB32Space				= 2049;
	cmRGB48Space				= 10497;
	cmRGB48LSpace				= 26881;
	cmARGB32Space				= 6273;
	cmARGB64Space				= 14977;
	cmARGB64LSpace				= 31361;
	cmRGBA32Space				= 2177;
	cmRGBA64Space				= 10881;
	cmRGBA64LSpace				= 27265;
	cmCMYK32Space				= 2050;
	cmCMYK64Space				= 10754;
	cmCMYK64LSpace				= 27138;
	cmHSV32Space				= 2563;
	cmHLS32Space				= 2564;
	cmYXY32Space				= 2565;
	cmXYZ24Space				= 8454;
	cmXYZ32Space				= 2566;
	cmXYZ48Space				= 10502;
	cmXYZ48LSpace				= 26886;
	cmLUV32Space				= 2567;
	cmLAB24Space				= 8456;
	cmLAB32Space				= 2568;
	cmLAB48Space				= 10504;
	cmLAB48LSpace				= 26888;
	cmGamutResult1Space			= $0B0C;
	cmNamedIndexed32Space		= $2710;
	cmNamedIndexed32LSpace		= $6710;
	cmMCFive8Space				= $2211;
	cmMCSix8Space				= $2312;
	cmMCSeven8Space				= $2413;
	cmMCEight8Space				= $2514;



TYPE
	CMBitmapColorSpace					= UInt32;
	CMBitmapPtr = ^CMBitmap;
	CMBitmap = RECORD
		image:					CStringPtr;
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		pixelSize:				LONGINT;
		space:					CMBitmapColorSpace;
		user1:					LONGINT;
		user2:					LONGINT;
	END;


{ Classic Print Manager Stuff }
{$IFC TARGET_OS_MAC }

CONST
	enableColorMatchingOp		= 12;
	registerProfileOp			= 13;

{$ENDC}  {TARGET_OS_MAC}

{ Profile Locations }

CONST
	CS_MAX_PATH					= 256;

	cmNoProfileBase				= 0;
	cmFileBasedProfile			= 1;
	cmHandleBasedProfile		= 2;
	cmPtrBasedProfile			= 3;
	cmProcedureBasedProfile		= 4;
	cmPathBasedProfile			= 5;
	cmBufferBasedProfile		= 6;


TYPE
	CMFileLocationPtr = ^CMFileLocation;
	CMFileLocation = RECORD
		spec:					FSSpec;
	END;

	CMHandleLocationPtr = ^CMHandleLocation;
	CMHandleLocation = RECORD
		h:						Handle;
	END;

	CMPtrLocationPtr = ^CMPtrLocation;
	CMPtrLocation = RECORD
		p:						Ptr;
	END;

	CMProcedureLocationPtr = ^CMProcedureLocation;
	CMProcedureLocation = RECORD
		proc:					CMProfileAccessUPP;
		refCon:					Ptr;
	END;

	CMPathLocationPtr = ^CMPathLocation;
	CMPathLocation = RECORD
		path:					PACKED ARRAY [0..255] OF CHAR;
	END;

	CMBufferLocationPtr = ^CMBufferLocation;
	CMBufferLocation = RECORD
		buffer:					Ptr;
		size:					UInt32;
	END;

	CMProfLocPtr = ^CMProfLoc;
	CMProfLoc = RECORD
		CASE INTEGER OF
		0: (
			fileLoc:			CMFileLocation;
			);
		1: (
			handleLoc:			CMHandleLocation;
			);
		2: (
			ptrLoc:				CMPtrLocation;
			);
		3: (
			procLoc:			CMProcedureLocation;
			);
		4: (
			pathLoc:			CMPathLocation;
			);
		5: (
			bufferLoc:			CMBufferLocation;
			);
	END;

	CMProfileLocationPtr = ^CMProfileLocation;
	CMProfileLocation = RECORD
		locType:				INTEGER;
		u:						CMProfLoc;
	END;

{$IFC TARGET_OS_MAC }

CONST
	cmOriginalProfileLocationSize = 72;
	cmCurrentProfileLocationSize = 258;

{$ELSEC}

CONST
	cmOriginalProfileLocationSize = 258;
	cmCurrentProfileLocationSize = 258;

{$ENDC}  {TARGET_OS_MAC}

{ Struct and enums used for Profile iteration }
	cmProfileIterateDataVersion1 = $00010000;
	cmProfileIterateDataVersion2 = $00020000;


TYPE
	CMProfileIterateDataPtr = ^CMProfileIterateData;
	CMProfileIterateData = RECORD
		dataVersion:			UInt32;									{  cmProfileIterateDataVersion2  }
		header:					CM2Header;
		code:					ScriptCode;
		name:					Str255;
		location:				CMProfileLocation;
		uniCodeNameCount:		UniCharCount;
		uniCodeName:			UniCharPtr;
		asciiName:				Ptr;
		makeAndModel:			CMMakeAndModelPtr;
	END;

{ Caller-supplied callback function for Profile & CMM iteration }
{$IFC TYPED_FUNCTION_POINTERS}
	CMProfileIterateProcPtr = FUNCTION(VAR iterateData: CMProfileIterateData; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMProfileIterateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CMMIterateProcPtr = FUNCTION(VAR iterateData: CMMInfo; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMMIterateProcPtr = ProcPtr;
{$ENDC}

	CMProfileIterateUPP = UniversalProcPtr;
	CMMIterateUPP = UniversalProcPtr;

CONST
	uppCMProfileIterateProcInfo = $000003E0;
	uppCMMIterateProcInfo = $000003E0;

FUNCTION NewCMProfileIterateUPP(userRoutine: CMProfileIterateProcPtr): CMProfileIterateUPP; { old name was NewCMProfileIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMMIterateUPP(userRoutine: CMMIterateProcPtr): CMMIterateUPP; { old name was NewCMMIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeCMProfileIterateUPP(userUPP: CMProfileIterateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCMMIterateUPP(userUPP: CMMIterateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeCMProfileIterateUPP(VAR iterateData: CMProfileIterateData; refCon: UNIV Ptr; userRoutine: CMProfileIterateUPP): OSErr; { old name was CallCMProfileIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCMMIterateUPP(VAR iterateData: CMMInfo; refCon: UNIV Ptr; userRoutine: CMMIterateUPP): OSErr; { old name was CallCMMIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{ Profile file and element access }
FUNCTION CMNewProfile(VAR prof: CMProfileRef; {CONST}VAR theProfile: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001B, $ABEE;
	{$ENDC}
FUNCTION CMOpenProfile(VAR prof: CMProfileRef; {CONST}VAR theProfile: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001C, $ABEE;
	{$ENDC}
FUNCTION CMCloseProfile(prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $001D, $ABEE;
	{$ENDC}
FUNCTION CMUpdateProfile(prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0034, $ABEE;
	{$ENDC}
FUNCTION CMCopyProfile(VAR targetProf: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; srcProf: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0025, $ABEE;
	{$ENDC}
FUNCTION CMValidateProfile(prof: CMProfileRef; VAR valid: BOOLEAN; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0026, $ABEE;
	{$ENDC}
FUNCTION CMGetProfileLocation(prof: CMProfileRef; VAR theProfile: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003C, $ABEE;
	{$ENDC}
FUNCTION NCMGetProfileLocation(prof: CMProfileRef; VAR theProfile: CMProfileLocation; VAR locationSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0059, $ABEE;
	{$ENDC}
FUNCTION CMFlattenProfile(prof: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0031, $ABEE;
	{$ENDC}
{$IFC TARGET_OS_MAC }
FUNCTION CMUnflattenProfile(VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0032, $ABEE;
	{$ENDC}
{$ENDC}  {TARGET_OS_MAC}

FUNCTION CMGetProfileHeader(prof: CMProfileRef; VAR header: CMAppleProfileHeader): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0039, $ABEE;
	{$ENDC}
FUNCTION CMSetProfileHeader(prof: CMProfileRef; {CONST}VAR header: CMAppleProfileHeader): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003A, $ABEE;
	{$ENDC}
FUNCTION CMProfileElementExists(prof: CMProfileRef; tag: OSType; VAR found: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $001E, $ABEE;
	{$ENDC}
FUNCTION CMCountProfileElements(prof: CMProfileRef; VAR elementCount: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001F, $ABEE;
	{$ENDC}
FUNCTION CMGetProfileElement(prof: CMProfileRef; tag: OSType; VAR elementSize: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0020, $ABEE;
	{$ENDC}
FUNCTION CMSetProfileElement(prof: CMProfileRef; tag: OSType; elementSize: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0023, $ABEE;
	{$ENDC}
FUNCTION CMSetProfileElementSize(prof: CMProfileRef; tag: OSType; elementSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0038, $ABEE;
	{$ENDC}
FUNCTION CMSetProfileElementReference(prof: CMProfileRef; elementTag: OSType; referenceTag: OSType): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0035, $ABEE;
	{$ENDC}
FUNCTION CMGetPartialProfileElement(prof: CMProfileRef; tag: OSType; offset: UInt32; VAR byteCount: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0036, $ABEE;
	{$ENDC}
FUNCTION CMSetPartialProfileElement(prof: CMProfileRef; tag: OSType; offset: UInt32; byteCount: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0037, $ABEE;
	{$ENDC}
FUNCTION CMGetIndProfileElementInfo(prof: CMProfileRef; index: UInt32; VAR tag: OSType; VAR elementSize: UInt32; VAR refs: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0021, $ABEE;
	{$ENDC}
FUNCTION CMGetIndProfileElement(prof: CMProfileRef; index: UInt32; VAR elementSize: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0022, $ABEE;
	{$ENDC}
FUNCTION CMRemoveProfileElement(prof: CMProfileRef; tag: OSType): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0024, $ABEE;
	{$ENDC}
FUNCTION CMGetScriptProfileDescription(prof: CMProfileRef; VAR name: Str255; VAR code: ScriptCode): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $003E, $ABEE;
	{$ENDC}
FUNCTION CMGetProfileDescriptions(prof: CMProfileRef; aName: CStringPtr; VAR aCount: UInt32; VAR mName: Str255; VAR mCode: ScriptCode; VAR uName: UniChar; VAR uCount: UniCharCount): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001A, $0067, $ABEE;
	{$ENDC}
FUNCTION CMSetProfileDescriptions(prof: CMProfileRef; aName: ConstCStringPtr; aCount: UInt32; mName: Str255; mCode: ScriptCode; {CONST}VAR uName: UniChar; uCount: UniCharCount): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001A, $0068, $ABEE;
	{$ENDC}
FUNCTION CMCloneProfileRef(prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0042, $ABEE;
	{$ENDC}
FUNCTION CMGetProfileRefCount(prof: CMProfileRef; VAR count: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0043, $ABEE;
	{$ENDC}
FUNCTION CMProfileModified(prof: CMProfileRef; VAR modified: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0044, $ABEE;
	{$ENDC}

{ named Color access functions }
FUNCTION CMGetNamedColorInfo(prof: CMProfileRef; VAR deviceChannels: UInt32; VAR deviceColorSpace: OSType; VAR PCSColorSpace: OSType; VAR count: UInt32; prefix: StringPtr; suffix: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001C, $0046, $ABEE;
	{$ENDC}
FUNCTION CMGetNamedColorValue(prof: CMProfileRef; name: StringPtr; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0047, $ABEE;
	{$ENDC}
FUNCTION CMGetIndNamedColorValue(prof: CMProfileRef; index: UInt32; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0048, $ABEE;
	{$ENDC}
FUNCTION CMGetNamedColorIndex(prof: CMProfileRef; name: StringPtr; VAR index: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0049, $ABEE;
	{$ENDC}
FUNCTION CMGetNamedColorName(prof: CMProfileRef; index: UInt32; name: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $004A, $ABEE;
	{$ENDC}

{ General-purpose matching functions }
FUNCTION NCWNewColorWorld(VAR cw: CMWorldRef; src: CMProfileRef; dst: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0014, $ABEE;
	{$ENDC}
FUNCTION CWConcatColorWorld(VAR cw: CMWorldRef; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0015, $ABEE;
	{$ENDC}
FUNCTION CWNewLinkProfile(VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0033, $ABEE;
	{$ENDC}
FUNCTION NCWConcatColorWorld(VAR cw: CMWorldRef; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0061, $ABEE;
	{$ENDC}
FUNCTION NCWNewLinkProfile(VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0062, $ABEE;
	{$ENDC}
PROCEDURE CWDisposeColorWorld(cw: CMWorldRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0001, $ABEE;
	{$ENDC}
FUNCTION CWMatchColors(cw: CMWorldRef; VAR myColors: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0002, $ABEE;
	{$ENDC}
FUNCTION CWCheckColors(cw: CMWorldRef; VAR myColors: CMColor; count: UInt32; VAR result: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0003, $ABEE;
	{$ENDC}
FUNCTION CWMatchBitmap(cw: CMWorldRef; VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $002C, $ABEE;
	{$ENDC}
FUNCTION CWCheckBitmap(cw: CMWorldRef; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $002D, $ABEE;
	{$ENDC}

{ Quickdraw-specific matching }
FUNCTION CWMatchPixMap(cw: CMWorldRef; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0004, $ABEE;
	{$ENDC}
FUNCTION CWCheckPixMap(cw: CMWorldRef; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitMap: BitMap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0007, $ABEE;
	{$ENDC}
{$IFC TARGET_API_MAC_OS8 OR TARGET_API_MAC_CARBON }
FUNCTION NCMBeginMatching(src: CMProfileRef; dst: CMProfileRef; VAR myRef: CMMatchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0016, $ABEE;
	{$ENDC}
PROCEDURE CMEndMatching(myRef: CMMatchRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000B, $ABEE;
	{$ENDC}
PROCEDURE NCMDrawMatchedPicture(myPicture: PicHandle; dst: CMProfileRef; VAR myRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0017, $ABEE;
	{$ENDC}
PROCEDURE CMEnableMatchingComment(enableIt: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $000D, $ABEE;
	{$ENDC}
FUNCTION NCMUseProfileComment(prof: CMProfileRef; flags: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003B, $ABEE;
	{$ENDC}
{$ENDC}

{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CWMatchHBITMAP(cw: CMWorldRef; hBitmap: HBITMAP; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}

FUNCTION CMCreateProfileIdentifier(prof: CMProfileRef; ident: CMProfileIdentifierPtr; VAR size: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0041, $ABEE;
	{$ENDC}

{ System Profile access }
FUNCTION CMGetSystemProfile(VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0018, $ABEE;
	{$ENDC}
FUNCTION CMSetSystemProfile({CONST}VAR profileFileSpec: FSSpec): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0019, $ABEE;
	{$ENDC}
FUNCTION NCMSetSystemProfile({CONST}VAR profLoc: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0064, $ABEE;
	{$ENDC}
FUNCTION CMGetDefaultProfileBySpace(dataColorSpace: OSType; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005A, $ABEE;
	{$ENDC}
FUNCTION CMSetDefaultProfileBySpace(dataColorSpace: OSType; prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005B, $ABEE;
	{$ENDC}
{$IFC TARGET_OS_MAC }
FUNCTION CMGetProfileByAVID(theAVID: AVIDType; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005C, $ABEE;
	{$ENDC}
FUNCTION CMSetProfileByAVID(theAVID: AVIDType; prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005D, $ABEE;
	{$ENDC}
{$ENDC}  {TARGET_OS_MAC}

{ Profile Use enumerations }

CONST
	cmInputUse					= 'inpt';
	cmOutputUse					= 'outp';
	cmDisplayUse				= 'dply';
	cmProofUse					= 'pruf';

{ Profile access by Use }
FUNCTION CMGetDefaultProfileByUse(use: OSType; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0069, $ABEE;
	{$ENDC}
FUNCTION CMSetDefaultProfileByUse(use: OSType; prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0079, $ABEE;
	{$ENDC}
{ Profile Management }
FUNCTION CMNewProfileSearch(VAR searchSpec: CMSearchRecord; refCon: UNIV Ptr; VAR count: UInt32; VAR searchResult: CMProfileSearchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0027, $ABEE;
	{$ENDC}
FUNCTION CMUpdateProfileSearch(search: CMProfileSearchRef; refCon: UNIV Ptr; VAR count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0028, $ABEE;
	{$ENDC}
PROCEDURE CMDisposeProfileSearch(search: CMProfileSearchRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0029, $ABEE;
	{$ENDC}
FUNCTION CMSearchGetIndProfile(search: CMProfileSearchRef; index: UInt32; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $002A, $ABEE;
	{$ENDC}
FUNCTION CMSearchGetIndProfileFileSpec(search: CMProfileSearchRef; index: UInt32; VAR profileFile: FSSpec): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $002B, $ABEE;
	{$ENDC}
FUNCTION CMProfileIdentifierFolderSearch(ident: CMProfileIdentifierPtr; VAR matchedCount: UInt32; VAR searchResult: CMProfileSearchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $003F, $ABEE;
	{$ENDC}
FUNCTION CMProfileIdentifierListSearch(ident: CMProfileIdentifierPtr; VAR profileList: CMProfileRef; listSize: UInt32; VAR matchedCount: UInt32; VAR matchedList: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0040, $ABEE;
	{$ENDC}
FUNCTION CMIterateColorSyncFolder(proc: CMProfileIterateUPP; VAR seed: UInt32; VAR count: UInt32; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0058, $ABEE;
	{$ENDC}
FUNCTION NCMUnflattenProfile(VAR targetLocation: CMProfileLocation; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0065, $ABEE;
	{$ENDC}
{ Utilities }
{$IFC TARGET_OS_MAC }
FUNCTION CMGetColorSyncFolderSpec(vRefNum: INTEGER; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0011, $ABEE;
	{$ENDC}
{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_WIN32 OR TARGET_OS_UNIX }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CMGetColorSyncFolderPath(createFolder: BOOLEAN; lpBuffer: CStringPtr; uSize: UInt32): CMError;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

FUNCTION CMGetCWInfo(cw: CMWorldRef; VAR info: CMCWInfoRecord): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001A, $ABEE;
	{$ENDC}
{$IFC TARGET_API_MAC_OS8 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CMConvertProfile2to1(profv2: CMProfileRef; VAR profv1: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0045, $ABEE;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_API_MAC_OS8}

FUNCTION CMGetPreferredCMM(VAR cmmType: OSType; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005E, $ABEE;
	{$ENDC}
FUNCTION CMIterateCMMInfo(proc: CMMIterateUPP; VAR count: UInt32; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0063, $ABEE;
	{$ENDC}
FUNCTION CMGetColorSyncVersion(VAR version: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0066, $ABEE;
	{$ENDC}
FUNCTION CMLaunchControlPanel(flags: UInt32): CMError;
{ ColorSpace conversion functions }
FUNCTION CMConvertXYZToLab({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004B, $ABEE;
	{$ENDC}
FUNCTION CMConvertLabToXYZ({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004C, $ABEE;
	{$ENDC}
FUNCTION CMConvertXYZToLuv({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004D, $ABEE;
	{$ENDC}
FUNCTION CMConvertLuvToXYZ({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004E, $ABEE;
	{$ENDC}
FUNCTION CMConvertXYZToYxy({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $004F, $ABEE;
	{$ENDC}
FUNCTION CMConvertYxyToXYZ({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0050, $ABEE;
	{$ENDC}
FUNCTION CMConvertRGBToHLS({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0051, $ABEE;
	{$ENDC}
FUNCTION CMConvertHLSToRGB({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0052, $ABEE;
	{$ENDC}
FUNCTION CMConvertRGBToHSV({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0053, $ABEE;
	{$ENDC}
FUNCTION CMConvertHSVToRGB({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0054, $ABEE;
	{$ENDC}
FUNCTION CMConvertRGBToGray({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0055, $ABEE;
	{$ENDC}
FUNCTION CMConvertXYZToFixedXYZ({CONST}VAR src: CMXYZColor; VAR dst: CMFixedXYZColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0056, $ABEE;
	{$ENDC}
FUNCTION CMConvertFixedXYZToXYZ({CONST}VAR src: CMFixedXYZColor; VAR dst: CMXYZColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0057, $ABEE;
	{$ENDC}

{ PS-related }
FUNCTION CMGetPS2ColorSpace(srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $002E, $ABEE;
	{$ENDC}
FUNCTION CMGetPS2ColorRenderingIntent(srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $002F, $ABEE;
	{$ENDC}
FUNCTION CMGetPS2ColorRendering(srcProf: CMProfileRef; dstProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $0030, $ABEE;
	{$ENDC}
FUNCTION CMGetPS2ColorRenderingVMSize(srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: UInt32; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $003D, $ABEE;
	{$ENDC}

{ ColorSync 1.0 functions which have parallel 2.0 counterparts }
{$IFC TARGET_API_MAC_OS8 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CWNewColorWorld(VAR cw: CMWorldRef; src: CMProfileHandle; dst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0000, $ABEE;
	{$ENDC}
FUNCTION ConcatenateProfiles(thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $000C, $ABEE;
	{$ENDC}
FUNCTION CMBeginMatching(src: CMProfileHandle; dst: CMProfileHandle; VAR myRef: CMMatchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $000A, $ABEE;
	{$ENDC}
PROCEDURE CMDrawMatchedPicture(myPicture: PicHandle; dst: CMProfileHandle; VAR myRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0009, $ABEE;
	{$ENDC}
FUNCTION CMUseProfileComment(profile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0008, $ABEE;
	{$ENDC}
PROCEDURE CMGetProfileName(myProfile: CMProfileHandle; VAR IStringResult: CMIString);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000E, $ABEE;
	{$ENDC}
FUNCTION CMGetProfileAdditionalDataOffset(myProfile: CMProfileHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000F, $ABEE;
	{$ENDC}

{ ProfileResponder functions }
FUNCTION GetProfile(deviceType: OSType; refNum: LONGINT; aProfile: CMProfileHandle; VAR returnedProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0005, $ABEE;
	{$ENDC}
FUNCTION SetProfile(deviceType: OSType; refNum: LONGINT; newProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0006, $ABEE;
	{$ENDC}
FUNCTION SetProfileDescription(deviceType: OSType; refNum: LONGINT; deviceData: LONGINT; hProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0010, $ABEE;
	{$ENDC}
FUNCTION GetIndexedProfile(deviceType: OSType; refNum: LONGINT; search: CMProfileSearchRecordHandle; VAR returnProfile: CMProfileHandle; VAR index: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0012, $ABEE;
	{$ENDC}
FUNCTION DeleteDeviceProfile(deviceType: OSType; refNum: LONGINT; deleteMe: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0013, $ABEE;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OLDROUTINENAMES }
{ constants }

TYPE
	CMFlattenProc						= CMFlattenProcPtr;
	CMBitmapCallBackProc				= CMBitmapCallBackProcPtr;
	CMProfileFilterProc					= CMProfileFilterProcPtr;

CONST
	qdSystemDevice				= 'sys ';
	qdGDevice					= 'gdev';


	kMatchCMMType				= $00000001;
	kMatchApplProfileVersion	= $00000002;
	kMatchDataType				= $00000004;
	kMatchDeviceType			= $00000008;
	kMatchDeviceManufacturer	= $00000010;
	kMatchDeviceModel			= $00000020;
	kMatchDeviceAttributes		= $00000040;
	kMatchFlags					= $00000080;
	kMatchOptions				= $00000100;
	kMatchWhite					= $00000200;
	kMatchBlack					= $00000400;

{ types }

TYPE
	CMYKColor							= CMCMYKColor;
	CMYKColorPtr 						= ^CMYKColor;
	CWorld								= CMWorldRef;
	CMGamutResult						= ^LONGINT;
{ functions }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE EndMatching(myRef: CMMatchRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000B, $ABEE;
	{$ENDC}
PROCEDURE EnableMatching(enableIt: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $000D, $ABEE;
	{$ENDC}
FUNCTION GetColorSyncFolderSpec(vRefNum: INTEGER; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0011, $ABEE;
	{$ENDC}
FUNCTION BeginMatching(src: CMProfileHandle; dst: CMProfileHandle; VAR myRef: CMMatchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $000A, $ABEE;
	{$ENDC}
PROCEDURE DrawMatchedPicture(myPicture: PicHandle; dst: CMProfileHandle; VAR myRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0009, $ABEE;
	{$ENDC}
FUNCTION UseProfile(profile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0008, $ABEE;
	{$ENDC}
PROCEDURE GetProfileName(myProfile: CMProfileHandle; VAR IStringResult: CMIString);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000E, $ABEE;
	{$ENDC}
FUNCTION GetProfileAdditionalDataOffset(myProfile: CMProfileHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000F, $ABEE;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}
{  Deprecated stuff }

{ PrGeneral parameter blocks }

TYPE
	TEnableColorMatchingBlkPtr = ^TEnableColorMatchingBlk;
	TEnableColorMatchingBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fEnableIt:				BOOLEAN;
		filler:					SInt8;
	END;

	TRegisterProfileBlkPtr = ^TRegisterProfileBlk;
	TRegisterProfileBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fRegisterIt:			BOOLEAN;
		filler:					SInt8;
	END;

{$ENDC}  {TARGET_API_MAC_OS8}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMApplicationIncludes}

{$ENDC} {__CMAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
