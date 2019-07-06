{
 	File:		FontSync.p
 
 	Contains:	Public interface for FontSync
 
 	Version:	Technology:	FontSync 1.0 (Sonata)
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FontSync;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FONTSYNC__}
{$SETC __FONTSYNC__ := 1}

{$I+}
{$SETC FontSyncIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{ Status Codes }

CONST
	kFNSInvalidReferenceErr		= -29580;						{  ref. was NULL or otherwise bad  }
	kFNSBadReferenceVersionErr	= -29581;						{  ref. version is out of known range  }
	kFNSInvalidProfileErr		= -29582;						{  profile is NULL or otherwise bad  }
	kFNSBadProfileVersionErr	= -29583;						{  profile version is out of known range  }
	kFNSDuplicateReferenceErr	= -29584;						{  the ref. being added is already in the profile  }
	kFNSMismatchErr				= -29585;						{  reference didn't match or wasn't found in profile  }
	kFNSInsufficientDataErr		= -29586;						{  insufficient data for the operation  }
	kFNSBadFlattenedSizeErr		= -29587;						{  flattened size didn't match input or was too small  }
	kFNSNameNotFoundErr			= -29589;						{  The name with the requested paramters was not found  }


{ Matching Options }

TYPE
	FNSMatchOptions 			= UInt32;
CONST
	kFNSMatchNames				= $00000001;					{  font names must match  }
	kFNSMatchTechnology			= $00000002;					{  scaler technology must match  }
	kFNSMatchGlyphs				= $00000004;					{  glyph data must match  }
	kFNSMatchEncodings			= $00000008;					{  cmaps must match  }
	kFNSMatchQDMetrics			= $00000010;					{  QuickDraw Text metrics must match  }
	kFNSMatchATSUMetrics		= $00000020;					{  ATSUI metrics (incl. vertical) must match  }
	kFNSMatchKerning			= $00000040;					{  kerning data must match  }
	kFNSMatchWSLayout			= $00000080;					{  WorldScript layout tables must match  }
	kFNSMatchAATLayout			= $00000100;					{  AAT (incl. OpenType) layout tables must match  }
	kFNSMatchPrintEncoding		= $00000200;					{  PostScript font and glyph names and re-encoding vector must match  }
	kFNSMissingDataNoMatch		= $80000000;					{  treat missing data as mismatch  }
	kFNSMatchAll				= $FFFFFFFF;					{  everything must match  }
	kFNSMatchDefaults			= 0;							{  use global default match options  }

FUNCTION FNSMatchDefaultsGet: FNSMatchOptions; C;

{ Version control }

TYPE
	FNSObjectVersion 			= UInt32;
CONST
	kFNSVersionDontCare			= 0;
	kFNSCurSysInfoVersion		= 1;

{  No features defined yet. }

TYPE
	FNSFeatureFlags						= UInt32;
{
   The FontSync library version number is binary-coded decimal:
   8 bits of major version, 4 minor version and 4 bits revision.
}
	FNSSysInfoPtr = ^FNSSysInfo;
	FNSSysInfo = RECORD
		iSysInfoVersion:		FNSObjectVersion;						{  fill this in before calling FNSSysInfoGet }
		oFeatures:				FNSFeatureFlags;
		oCurRefVersion:			FNSObjectVersion;
		oMinRefVersion:			FNSObjectVersion;
		oCurProfileVersion:		FNSObjectVersion;
		oMinProfileVersion:		FNSObjectVersion;
		oFontSyncVersion:		UInt16;
	END;

PROCEDURE FNSSysInfoGet(VAR ioInfo: FNSSysInfo); C;

{ FontSync References }

TYPE
	FNSFontReference = ^LONGINT; { an opaque 32-bit type }
FUNCTION FNSReferenceGetVersion(iReference: FNSFontReference; VAR oVersion: FNSObjectVersion): OSStatus; C;
FUNCTION FNSReferenceDispose(iReference: FNSFontReference): OSStatus; C;
FUNCTION FNSReferenceMatch(iReference1: FNSFontReference; iReference2: FNSFontReference; iOptions: FNSMatchOptions; VAR oFailedMatchOptions: FNSMatchOptions): OSStatus; C;
FUNCTION FNSReferenceFlattenedSize(iReference: FNSFontReference; VAR oFlattenedSize: ByteCount): OSStatus; C;
FUNCTION FNSReferenceFlatten(iReference: FNSFontReference; oFlatReference: UNIV Ptr; VAR oFlattenedSize: ByteCount): OSStatus; C;
FUNCTION FNSReferenceUnflatten(iFlatReference: UNIV Ptr; iFlattenedSize: ByteCount; VAR oReference: FNSFontReference): OSStatus; C;

{ FontSync Profiles }

CONST
	kFNSCreatorDefault			= 0;
	kFNSProfileFileType			= 'fnsp';


TYPE
	FNSFontProfile = ^LONGINT; { an opaque 32-bit type }
FUNCTION FNSProfileCreate({CONST}VAR iFile: FSSpec; iCreator: FourCharCode; iEstNumRefs: ItemCount; iDesiredVersion: FNSObjectVersion; VAR oProfile: FNSFontProfile): OSStatus; C;
FUNCTION FNSProfileOpen({CONST}VAR iFile: FSSpec; iOpenForWrite: BOOLEAN; VAR oProfile: FNSFontProfile): OSStatus; C;
FUNCTION FNSProfileGetVersion(iProfile: FNSFontProfile; VAR oVersion: FNSObjectVersion): OSStatus; C;
FUNCTION FNSProfileCompact(iProfile: FNSFontProfile): OSStatus; C;
FUNCTION FNSProfileClose(iProfile: FNSFontProfile): OSStatus; C;
FUNCTION FNSProfileAddReference(iProfile: FNSFontProfile; iReference: FNSFontReference): OSStatus; C;
FUNCTION FNSProfileRemoveReference(iProfile: FNSFontProfile; iReference: FNSFontReference): OSStatus; C;
FUNCTION FNSProfileRemoveIndReference(iProfile: FNSFontProfile; iIndex: UInt32): OSStatus; C;
FUNCTION FNSProfileClear(iProfile: FNSFontProfile): OSStatus; C;
FUNCTION FNSProfileCountReferences(iProfile: FNSFontProfile; VAR oCount: ItemCount): OSStatus; C;
FUNCTION FNSProfileGetIndReference(iProfile: FNSFontProfile; iWhichReference: UInt32; VAR oReference: FNSFontReference): OSStatus; C;
FUNCTION FNSProfileMatchReference(iProfile: FNSFontProfile; iReference: FNSFontReference; iMatchOptions: FNSMatchOptions; iOutputSize: ItemCount; oIndices: LongIntPtr; VAR oNumMatches: ItemCount): OSStatus; C;

{ Mapping to and from Font Objects }
FUNCTION FNSReferenceCreate(iFont: FMFont; iDesiredVersion: FNSObjectVersion; VAR oReference: FNSFontReference): OSStatus; C;
FUNCTION FNSReferenceMatchFonts(iReference: FNSFontReference; iMatchOptions: FNSMatchOptions; iOutputSize: ItemCount; oFonts: LongIntPtr; VAR oNumMatches: ItemCount): OSStatus; C;

{ Mapping to and from Font Families }
FUNCTION FNSReferenceCreateFromFamily(iFamily: FMFontFamily; iStyle: FMFontStyle; iDesiredVersion: FNSObjectVersion; VAR oReference: FNSFontReference; VAR oActualStyle: FMFontStyle): OSStatus; C;
FUNCTION FNSReferenceMatchFamilies(iReference: FNSFontReference; iMatchOptions: FNSMatchOptions; iOutputSize: ItemCount; oFonts: FMFontFamilyInstancePtr; VAR oNumMatches: ItemCount): OSStatus; C;

{ UI Support }
FUNCTION FNSReferenceGetFamilyInfo(iReference: FNSFontReference; oFamilyName: StringPtr; VAR oFamilyNameScript: ScriptCode; VAR oActualStyle: FMFontStyle): OSStatus; C;
FUNCTION FNSReferenceCountNames(iReference: FNSFontReference; VAR oNameCount: ItemCount): OSStatus; C;
FUNCTION FNSReferenceGetIndName(iReference: FNSFontReference; iFontNameIndex: ItemCount; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameCode: FontNameCode; VAR oFontNamePlatform: FontPlatformCode; VAR oFontNameScript: FontScriptCode; VAR oFontNameLanguage: FontLanguageCode): OSStatus; C;
FUNCTION FNSReferenceFindName(iReference: FNSFontReference; iFontNameCode: FontNameCode; iFontNamePlatform: FontPlatformCode; iFontNameScript: FontScriptCode; iFontNameLanguage: FontLanguageCode; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameIndex: ItemCount): OSStatus; C;
{ Miscellany }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION FNSEnabled: BOOLEAN; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FontSyncIncludes}

{$ENDC} {__FONTSYNC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
