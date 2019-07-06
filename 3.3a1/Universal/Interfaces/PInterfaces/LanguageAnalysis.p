{
 	File:		LanguageAnalysis.p
 
 	Contains:	Language Analysis Manager Interfaces
 
 	Version:	Technology:	System 8
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1996, 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT LanguageAnalysis;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LANGUAGEANALYSIS__}
{$SETC __LANGUAGEANALYSIS__ := 1}

{$I+}
{$SETC LanguageAnalysisIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __DICTIONARY__}
{$I Dictionary.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


TYPE
	LAEnvironmentRef = ^LONGINT; { an opaque 32-bit type }
	LAContextRef = ^LONGINT; { an opaque 32-bit type }
	LAPropertyKey						= AEKeyword;
	LAPropertyType						= DescType;
{
	Data structure for high level API
}
	LAMorphemeRecPtr = ^LAMorphemeRec;
	LAMorphemeRec = RECORD
		sourceTextLength:		ByteCount;
		sourceTextPtr:			LogicalAddress;
		morphemeTextLength:		ByteCount;
		morphemeTextPtr:		LogicalAddress;
		partOfSpeech:			UInt32;
	END;

	LAMorphemesArrayPtr = ^LAMorphemesArray;
	LAMorphemesArray = RECORD
		morphemesCount:			ItemCount;
		processedTextLength:	ByteCount;
		morphemesTextLength:	ByteCount;
		morphemes:				ARRAY [0..0] OF LAMorphemeRec;
	END;


CONST
	kLAMorphemesArrayVersion	= 0;

{
	Definitions for result path/bundle structure
}

TYPE
	LAMorphemeBundle					= AERecord;
	LAMorphemeBundlePtr 				= ^LAMorphemeBundle;
	LAMorphemePath						= AERecord;
	LAMorphemePathPtr 					= ^LAMorphemePath;
	LAMorpheme							= AERecord;
	LAMorphemePtr 						= ^LAMorpheme;
	LAHomograph							= AERecord;
	LAHomographPtr 						= ^LAHomograph;

CONST
	keyAELAMorphemeBundle		= 'lmfb';
	keyAELAMorphemePath			= 'lmfp';
	keyAELAMorpheme				= 'lmfn';
	keyAELAHomograph			= 'lmfh';

	typeLAMorphemeBundle		= 'reco';
	typeLAMorphemePath			= 'reco';
	typeLAMorpheme				= 'list';
	typeLAHomograph				= 'list';

{
	Definitions for morpheme/homograph information
}
	keyAEMorphemePartOfSpeechCode = 'lamc';
	keyAEMorphemeTextRange		= 'lamt';

	typeAEMorphemePartOfSpeechCode = 'lamc';
	typeAEMorphemeTextRange		= 'lamt';


TYPE
	MorphemePartOfSpeech				= UInt32;
	MorphemeTextRangePtr = ^MorphemeTextRange;
	MorphemeTextRange = RECORD
		sourceOffset:			UInt32;
		length:					UInt32;
	END;

{
	Mask for High level API convert flags 
}

CONST
	kLAEndOfSourceTextMask		= $00000001;

{
	Constants for leading/trailing path of analysis function
}
	kLADefaultEdge				= 0;
	kLAFreeEdge					= 1;
	kLAIncompleteEdge			= 2;

{
	Constants for confirm and shift function
}
	kLAAllMorphemes				= 0;

{
	Error Value
}
	laEngineNotFoundErr			= -7000;						{  can't find the engine }
	laPropertyErr				= -6999;						{  Error in properties }
	laPropertyNotFoundErr		= -6998;						{  can't find the property }
	laPropertyIsReadOnlyErr		= -6997;						{  the property is read only }
	laPropertyUnknownErr		= -6996;						{  the property is unknown to this environment }
	laPropertyValueErr			= -6995;						{  Invalid property value }
	laDictionaryTooManyErr		= -6994;						{  too many dictionaries }
	laDictionaryUnknownErr		= -6993;						{  can't use this dictionary with this environment }
	laDictionaryNotOpenedErr	= -6992;						{  the dictionary is not opened }
	laTextOverFlowErr			= -6991;						{  text is too long }
	laFailAnalysisErr			= -6990;						{  analysis failed }
	laNoMoreMorphemeErr			= -6989;						{  nothing to read }
	laInvalidPathErr			= -6988;						{  path is not correct  }
	laEnvironmentExistErr		= -6987;						{  same name environment is already exists  }
	laEnvironmentNotFoundErr	= -6986;						{  can't fint the specified environment  }
	laEnvironmentBusyErr		= -6985;						{  specified environment is used  }
	laTooSmallBufferErr			= -6984;						{  output buffer is too small to store any result  }


{
	Library version
}
FUNCTION LALibraryVersion: UInt32;
{
	High level API
}
FUNCTION LATextToMorphemes(context: LAContextRef; preferedEncoding: TextEncoding; textLength: ByteCount; sourceText: ConstLogicalAddress; bufferSize: ByteCount; convertFlags: OptionBits; structureVersion: UInt32; VAR acceptedLength: ByteCount; resultBuffer: LAMorphemesArrayPtr): OSStatus;
{
	Handling Context
}
FUNCTION LAOpenAnalysisContext(environ: LAEnvironmentRef; VAR context: LAContextRef): OSStatus;
FUNCTION LACloseAnalysisContext(context: LAContextRef): OSStatus;
{
	Handling Environment
}
FUNCTION LAGetEnvironmentList(maxCount: UInt32; VAR actualCount: UInt32; VAR environmentList: LAEnvironmentRef): OSStatus;
FUNCTION LAGetEnvironmentName(environment: LAEnvironmentRef; VAR environmentName: Str63): OSStatus;
FUNCTION LAGetEnvironmentRef(targetEnvironmentName: Str63; VAR environment: LAEnvironmentRef): OSStatus;
FUNCTION LACreateCustomEnvironment(baseEnvironment: LAEnvironmentRef; newEnvironmentName: Str63; persistent: BOOLEAN; VAR newEnvironment: LAEnvironmentRef): OSStatus;
FUNCTION LADeleteCustomEnvironment(environment: LAEnvironmentRef): OSStatus;
{
	Handling dictionries
}
FUNCTION LAOpenDictionary(environ: LAEnvironmentRef; {CONST}VAR dictionary: FSSpec): OSStatus;
FUNCTION LACloseDictionary(environ: LAEnvironmentRef; {CONST}VAR dictionary: FSSpec): OSStatus;
FUNCTION LAListAvailableDictionaries(environ: LAEnvironmentRef; maxCount: ItemCount; VAR actualCount: ItemCount; VAR dictionaryList: FSSpec; VAR opened: BOOLEAN): OSStatus;
FUNCTION LAAddNewWord(environ: LAEnvironmentRef; {CONST}VAR dictionary: FSSpec; {CONST}VAR dataList: AEDesc): OSStatus;
{
	Analyzing text
}
FUNCTION LAMorphemeAnalysis(context: LAContextRef; text: ConstUniCharArrayPtr; textLength: UniCharCount; VAR leadingPath: LAMorphemePath; VAR trailingPath: LAMorphemePath; pathCount: ItemCount; VAR result: LAMorphemeBundle): OSStatus;
FUNCTION LAContinuousMorphemeAnalysis(context: LAContextRef; text: ConstUniCharArrayPtr; textLength: UniCharCount; incrementalText: BOOLEAN; VAR leadingPath: LAMorphemePath; VAR trailingPath: LAMorphemePath; VAR modified: BOOLEAN): OSStatus;
FUNCTION LAGetMorphemes(context: LAContextRef; VAR result: LAMorphemePath): OSStatus;
FUNCTION LAShiftMorphemes(context: LAContextRef; morphemeCount: ItemCount; VAR path: LAMorphemePath; VAR shiftedLength: UniCharCount): OSStatus;
FUNCTION LAResetAnalysis(context: LAContextRef): OSStatus;
{
	Check Language Analysis Manager availability
}
{$IFC TARGET_RT_MAC_CFM }
{
		LALanguageAnalysisAvailable() is a macro available only in C/C++.  
		To get the same functionality from pascal or assembly, you need
		to test if Language Analysis Manager functions are not NULL.
		For instance:
		
			IF @LALibraryVersion <> kUnresolvedCFragSymbolAddress THEN
				gLanguageAnalysisAvailable = TRUE;
			ELSE
				gLanguageAnalysisAvailable = FALSE;
			END
	
}
{$ENDC}  {TARGET_RT_MAC_CFM}

{
=============================================================================================
	Definitions for Japanese Analysis Module
=============================================================================================
}
{
	Names for default environments for Japanese analysis
}
{
	File cretor for dictionary of Apple Japanese access method
}

CONST
	kAppleJapaneseDictionarySignature = 'jlan';

{
	Engine limitations
}
	kMaxInputLengthOfAppleJapaneseEngine = 200;

{
	Definitions of information in the path/bundle
}

TYPE
	JapanesePartOfSpeech				= MorphemePartOfSpeech;
	HomographWeight						= UInt16;
	HomographAccent						= UInt8;
{
	AE keywords and type definitions for morpheme/homograph information
}

CONST
	keyAEHomographDicInfo		= 'lahd';
	keyAEHomographWeight		= 'lahw';
	keyAEHomographAccent		= 'laha';

	typeAEHomographDicInfo		= 'lahd';
	typeAEHomographWeight		= 'shor';
	typeAEHomographAccent		= 'laha';

{
	Structure for dictionary information of homograph
}

TYPE
	HomographDicInfoRecPtr = ^HomographDicInfoRec;
	HomographDicInfoRec = RECORD
		dictionaryID:			DCMDictionaryID;
		uniqueID:				DCMUniqueID;
	END;

{
=============================================================================================
	Definitions for Japanese part of speeches
=============================================================================================
}
{
	Masks for part of speeches
}

CONST
	kLASpeechRoughClassMask		= $0000F000;
	kLASpeechMediumClassMask	= $0000FF00;
	kLASpeechStrictClassMask	= $0000FFF0;
	kLASpeechKatsuyouMask		= $0000000F;


{
	Part of speeches
}
	kLASpeechMeishi				= $00000000;					{  noun  }
	kLASpeechFutsuuMeishi		= $00000000;					{  general noun  }
	kLASpeechJinmei				= $00000100;					{  person name  }
	kLASpeechJinmeiSei			= $00000110;					{  family name  }
	kLASpeechJinmeiMei			= $00000120;					{  first name  }
	kLASpeechChimei				= $00000200;					{  place name  }
	kLASpeechSetsubiChimei		= $00000210;					{  place name with suffix  }
	kLASpeechSoshikimei			= $00000300;					{  organization name  }
	kLASpeechKoyuuMeishi		= $00000400;					{  proper noun  }
	kLASpeechSahenMeishi		= $00000500;					{  special noun  }
	kLASpeechKeidouMeishi		= $00000600;					{  special noun  }
	kLASpeechRentaishi			= $00001000;
	kLASpeechFukushi			= $00002000;					{  adverb  }
	kLASpeechSetsuzokushi		= $00003000;					{  conjunction  }
	kLASpeechKandoushi			= $00004000;
	kLASpeechDoushi				= $00005000;					{  verb  }
	kLASpeechGodanDoushi		= $00005000;
	kLASpeechKagyouGodan		= $00005000;
	kLASpeechSagyouGodan		= $00005010;
	kLASpeechTagyouGodan		= $00005020;
	kLASpeechNagyouGodan		= $00005030;
	kLASpeechMagyouGodan		= $00005040;
	kLASpeechRagyouGodan		= $00005050;
	kLASpeechWagyouGodan		= $00005060;
	kLASpeechGagyouGodan		= $00005070;
	kLASpeechBagyouGodan		= $00005080;
	kLASpeechIchidanDoushi		= $00005100;
	kLASpeechKahenDoushi		= $00005200;
	kLASpeechSahenDoushi		= $00005300;
	kLASpeechZahenDoushi		= $00005400;
	kLASpeechKeiyoushi			= $00006000;					{  adjective  }
	kLASpeechKeiyoudoushi		= $00007000;
	kLASpeechSettougo			= $00008000;					{  prefix }
	kLASpeechSuujiSettougo		= $00008100;					{  prefix for numbers  }
	kLASpeechSetsubigo			= $00009000;					{  suffix  }
	kLASpeechJinmeiSetsubigo	= $00009100;					{  suffix for person name  }
	kLASpeechChimeiSetsubigo	= $00009200;					{  suffix for place name  }
	kLASpeechSoshikimeiSetsubigo = $00009300;					{  suffix for organization name  }
	kLASpeechSuujiSetsubigo		= $00009400;					{  suffix for numbers  }
	kLASpeechMuhinshi			= $0000A000;					{  no category  }
	kLASpeechTankanji			= $0000A000;					{  character  }
	kLASpeechKigou				= $0000A100;					{  symbol  }
	kLASpeechKuten				= $0000A110;
	kLASpeechTouten				= $0000A120;
	kLASpeechSuushi				= $0000A200;					{  numbers  }
	kLASpeechDokuritsugo		= $0000A300;
	kLASpeechSeiku				= $0000A400;
	kLASpeechJodoushi			= $0000B000;					{  auxiliary verb  }
	kLASpeechJoshi				= $0000C000;					{  postpositional particle  }


{
	Conjugations
 }
	kLASpeechKatsuyouGokan		= $00000001;					{  stem  }
	kLASpeechKatsuyouMizen		= $00000002;
	kLASpeechKatsuyouRenyou		= $00000003;
	kLASpeechKatsuyouSyuushi	= $00000004;
	kLASpeechKatsuyouRentai		= $00000005;
	kLASpeechKatsuyouKatei		= $00000006;
	kLASpeechKatsuyouMeirei		= $00000007;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := LanguageAnalysisIncludes}

{$ENDC} {__LANGUAGEANALYSIS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
