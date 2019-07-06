{
 	File:		MacLocales.p
 
 	Contains:	Types & prototypes for locale functions
 
 	Version:	Technology:	Mac OS 9.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1998-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacLocales;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACLOCALES__}
{$SETC __MACLOCALES__ := 1}

{$I+}
{$SETC MacLocalesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   -------------------------------------------------------------------------------------------------
   ERROR/STATUS CODES
   -------------------------------------------------------------------------------------------------
}


CONST
	kLocalesBufferTooSmallErr	= -30001;
	kLocalesTableFormatErr		= -30002;
	kLocalesDefaultDisplayStatus = -30029;						{  Requested display locale unavailable, used default }

{
   -------------------------------------------------------------------------------------------------
   TYPES & CONSTANTS
   -------------------------------------------------------------------------------------------------
}


TYPE
	LocaleRef = ^LONGINT; { an opaque 32-bit type }
	LocalePartMask						= UInt32;

CONST
																{  bit set requests the following: }
	kLocaleLanguageMask			= $00000001;					{  ISO 639-1 or -2 language code (2 or 3 letters) }
	kLocaleLanguageVariantMask	= $00000002;					{  custom string for language variant }
	kLocaleScriptMask			= $00000004;					{  ISO 15924 script code (2 letters) }
	kLocaleScriptVariantMask	= $00000008;					{  custom string for script variant }
	kLocaleRegionMask			= $00000010;					{  ISO 3166 country/region code (2 letters) }
	kLocaleRegionVariantMask	= $00000020;					{  custom string for region variant }
	kLocaleAllPartsMask			= $0000003F;					{  all of the above }


TYPE
	LocaleOperationClass				= FourCharCode;
{  constants for LocaleOperationClass are in UnicodeUtilities interfaces }
	LocaleOperationVariant				= FourCharCode;
	LocaleAndVariantPtr = ^LocaleAndVariant;
	LocaleAndVariant = RECORD
		locale:					LocaleRef;
		opVariant:				LocaleOperationVariant;
	END;

	LocaleNameMask						= UInt32;

CONST
																{  bit set requests the following: }
	kLocaleNameMask				= $00000001;					{  name of locale }
	kLocaleOperationVariantNameMask = $00000002;				{  name of LocaleOperationVariant }
	kLocaleAndVariantNameMask	= $00000003;					{  all of the above }

{
   -------------------------------------------------------------------------------------------------
   FUNCTION PROTOTYPES
   -------------------------------------------------------------------------------------------------
}

{  Convert to or from LocaleRefs (and related utilities) }

FUNCTION LocaleRefFromLangOrRegionCode(lang: LangCode; region: RegionCode; VAR locale: LocaleRef): OSStatus; C;
FUNCTION LocaleRefFromLocaleString({CONST}VAR localeString: CHAR; VAR locale: LocaleRef): OSStatus; C;
FUNCTION LocaleRefGetPartString(locale: LocaleRef; partMask: LocalePartMask; maxStringLen: ByteCount; VAR partString: CHAR): OSStatus; C;
FUNCTION LocaleStringToLangAndRegionCodes({CONST}VAR localeString: CHAR; VAR lang: LangCode; VAR region: RegionCode): OSStatus; C;
{  Enumerate locales for a LocaleOperationClass  }
FUNCTION LocaleOperationCountLocales(opClass: LocaleOperationClass; VAR localeCount: ItemCount): OSStatus; C;
FUNCTION LocaleOperationGetLocales(opClass: LocaleOperationClass; maxLocaleCount: ItemCount; VAR actualLocaleCount: ItemCount; VAR localeVariantList: LocaleAndVariant): OSStatus; C;
{  Get names for a locale (or a region's language) }

FUNCTION LocaleGetName(locale: LocaleRef; opVariant: LocaleOperationVariant; nameMask: LocaleNameMask; displayLocale: LocaleRef; maxNameLen: UniCharCount; VAR actualNameLen: UniCharCount; VAR displayName: UniChar): OSStatus; C;
FUNCTION LocaleCountNames(locale: LocaleRef; opVariant: LocaleOperationVariant; nameMask: LocaleNameMask; VAR nameCount: ItemCount): OSStatus; C;
FUNCTION LocaleGetIndName(locale: LocaleRef; opVariant: LocaleOperationVariant; nameMask: LocaleNameMask; nameIndex: ItemCount; maxNameLen: UniCharCount; VAR actualNameLen: UniCharCount; VAR displayName: UniChar; VAR displayLocale: LocaleRef): OSStatus; C;
FUNCTION LocaleGetRegionLanguageName(region: RegionCode; VAR languageName: Str255): OSStatus; C;
{  Get names for a LocaleOperationClass }
FUNCTION LocaleOperationGetName(opClass: LocaleOperationClass; displayLocale: LocaleRef; maxNameLen: UniCharCount; VAR actualNameLen: UniCharCount; VAR displayName: UniChar): OSStatus; C;
FUNCTION LocaleOperationCountNames(opClass: LocaleOperationClass; VAR nameCount: ItemCount): OSStatus; C;
FUNCTION LocaleOperationGetIndName(opClass: LocaleOperationClass; nameIndex: ItemCount; maxNameLen: UniCharCount; VAR actualNameLen: UniCharCount; VAR displayName: UniChar; VAR displayLocale: LocaleRef): OSStatus; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacLocalesIncludes}

{$ENDC} {__MACLOCALES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
