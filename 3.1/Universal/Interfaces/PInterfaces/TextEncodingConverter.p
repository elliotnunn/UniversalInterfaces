{
 	File:		TextEncodingConverter.p
 
 	Contains:	Text Encoding Conversion Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TextEncodingConverter;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTENCODINGCONVERTER__}
{$SETC __TEXTENCODINGCONVERTER__ := 1}

{$I+}
{$SETC TextEncodingConverterIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	TECPluginSignature					= OSType;
	TECPluginVersion					= UInt32;
{ plugin signatures }

CONST
	kTECSignature				= 'encv';
	kTECUnicodePluginSignature	= 'puni';
	kTECJapanesePluginSignature	= 'pjpn';
	kTECChinesePluginSignature	= 'pzho';
	kTECKoreanPluginSignature	= 'pkor';


{ converter object reference }

TYPE
	TECObjectRef = ^LONGINT;
	TECSnifferObjectRef = ^LONGINT;
	TECPluginSig						= OSType;
	TECConversionInfoPtr = ^TECConversionInfo;
	TECConversionInfo = RECORD
		sourceEncoding:			TextEncoding;
		destinationEncoding:	TextEncoding;
		reserved1:				UInt16;
		reserved2:				UInt16;
	END;

{ return number of encodings types supported by user's configuraton of the encoding converter }
FUNCTION TECCountAvailableTextEncodings(VAR numberEncodings: ItemCount): OSStatus;
{ fill in an array of type TextEncoding passed in by the user with types of encodings the current configuration of the encoder can handle. }
FUNCTION TECGetAvailableTextEncodings(VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus;
{ return number of from-to encoding conversion pairs supported  }
FUNCTION TECCountDirectTextEncodingConversions(VAR numberOfEncodings: ItemCount): OSStatus;
{ fill in an array of type TextEncodingPair passed in by the user with types of encoding pairs the current configuration of the encoder can handle. }
FUNCTION TECGetDirectTextEncodingConversions(VAR availableConversions: TECConversionInfo; maxAvailableConversions: ItemCount; VAR actualAvailableConversions: ItemCount): OSStatus;
{ return number of encodings a given encoding can be converter into }
FUNCTION TECCountDestinationTextEncodings(inputEncoding: TextEncoding; VAR numberOfEncodings: ItemCount): OSStatus;
{ fill in an array of type TextEncodingPair passed in by the user with types of encodings pairs the current configuration of the encoder can handle. }
FUNCTION TECGetDestinationTextEncodings(inputEncoding: TextEncoding; VAR destinationEncodings: TextEncoding; maxDestinationEncodings: ItemCount; VAR actualDestinationEncodings: ItemCount): OSStatus;
{ get info about a text encoding }
FUNCTION TECGetTextEncodingInternetName(textEncoding: TextEncoding; VAR encodingName: Str255): OSStatus;
FUNCTION TECGetTextEncodingFromInternetName(VAR textEncoding: TextEncoding; encodingName: Str255): OSStatus;
{ create/dispose converters }
FUNCTION TECCreateConverter(VAR newEncodingConverter: TECObjectRef; inputEncoding: TextEncoding; outputEncoding: TextEncoding): OSStatus;
FUNCTION TECCreateConverterFromPath(VAR newEncodingConverter: TECObjectRef; {CONST}VAR inPath: TextEncoding; inEncodings: ItemCount): OSStatus;
FUNCTION TECDisposeConverter(newEncodingConverter: TECObjectRef): OSStatus;
{ convert text encodings }
FUNCTION TECClearConverterContextInfo(encodingConverter: TECObjectRef): OSStatus;
FUNCTION TECConvertText(encodingConverter: TECObjectRef; inputBuffer: ConstTextPtr; inputBufferLength: ByteCount; VAR actualInputLength: ByteCount; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount): OSStatus;
FUNCTION TECFlushText(encodingConverter: TECObjectRef; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount): OSStatus;
{ one-to-many routines }
FUNCTION TECCountSubTextEncodings(inputEncoding: TextEncoding; VAR numberOfEncodings: ItemCount): OSStatus;
FUNCTION TECGetSubTextEncodings(inputEncoding: TextEncoding; VAR subEncodings: TextEncoding; maxSubEncodings: ItemCount; VAR actualSubEncodings: ItemCount): OSStatus;
FUNCTION TECGetEncodingList(encodingConverter: TECObjectRef; VAR numEncodings: ItemCount; VAR encodingList: Handle): OSStatus;
FUNCTION TECCreateOneToManyConverter(VAR newEncodingConverter: TECObjectRef; inputEncoding: TextEncoding; numOutputEncodings: ItemCount; {CONST}VAR outputEncodings: TextEncoding): OSStatus;

FUNCTION TECConvertTextToMultipleEncodings(encodingConverter: TECObjectRef; inputBuffer: ConstTextPtr; inputBufferLength: ByteCount; VAR actualInputLength: ByteCount; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount; VAR outEncodingsBuffer: TextEncodingRun; maxOutEncodingRuns: ItemCount; VAR actualOutEncodingRuns: ItemCount): OSStatus;
FUNCTION TECFlushMultipleEncodings(encodingConverter: TECObjectRef; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount; VAR outEncodingsBuffer: TextEncodingRun; maxOutEncodingRuns: ItemCount; VAR actualOutEncodingRuns: ItemCount): OSStatus;
{ international internet info }
FUNCTION TECCountWebTextEncodings(locale: RegionCode; VAR numberEncodings: ItemCount): OSStatus;
FUNCTION TECGetWebTextEncodings(locale: RegionCode; VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus;
FUNCTION TECCountMailTextEncodings(locale: RegionCode; VAR numberEncodings: ItemCount): OSStatus;
FUNCTION TECGetMailTextEncodings(locale: RegionCode; VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus;
{ examine text encodings }
FUNCTION TECCountAvailableSniffers(VAR numberOfEncodings: ItemCount): OSStatus;
FUNCTION TECGetAvailableSniffers(VAR availableSniffers: TextEncoding; maxAvailableSniffers: ItemCount; VAR actualAvailableSniffers: ItemCount): OSStatus;
FUNCTION TECCreateSniffer(VAR encodingSniffer: TECSnifferObjectRef; VAR testEncodings: TextEncoding; numTextEncodings: ItemCount): OSStatus;
FUNCTION TECSniffTextEncoding(encodingSniffer: TECSnifferObjectRef; inputBuffer: TextPtr; inputBufferLength: ByteCount; VAR testEncodings: TextEncoding; numTextEncodings: ItemCount; VAR numErrsArray: ItemCount; maxErrs: ItemCount; VAR numFeaturesArray: ItemCount; maxFeatures: ItemCount): OSStatus;
FUNCTION TECDisposeSniffer(encodingSniffer: TECSnifferObjectRef): OSStatus;
FUNCTION TECClearSnifferContextInfo(encodingSniffer: TECSnifferObjectRef): OSStatus;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextEncodingConverterIncludes}

{$ENDC} {__TEXTENCODINGCONVERTER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
