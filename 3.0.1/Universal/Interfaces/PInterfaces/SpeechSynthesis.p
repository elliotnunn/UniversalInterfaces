{
 	File:		SpeechSynthesis.p
 
 	Contains:	Speech Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1989-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SpeechSynthesis;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SPEECHSYNTHESIS__}
{$SETC __SPEECHSYNTHESIS__ := 1}

{$I+}
{$SETC SpeechSynthesisIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kTextToSpeechSynthType		= 'ttsc';
	kTextToSpeechVoiceType		= 'ttvd';
	kTextToSpeechVoiceFileType	= 'ttvf';
	kTextToSpeechVoiceBundleType = 'ttvb';

	kNoEndingProsody			= 1;
	kNoSpeechInterrupt			= 2;
	kPreflightThenPause			= 4;

	kImmediate					= 0;
	kEndOfWord					= 1;
	kEndOfSentence				= 2;


{------------------------------------------}
{ GetSpeechInfo & SetSpeechInfo selectors	}
{------------------------------------------}
	soStatus					= 'stat';
	soErrors					= 'erro';
	soInputMode					= 'inpt';
	soCharacterMode				= 'char';
	soNumberMode				= 'nmbr';
	soRate						= 'rate';
	soPitchBase					= 'pbas';
	soPitchMod					= 'pmod';
	soVolume					= 'volm';
	soSynthType					= 'vers';
	soRecentSync				= 'sync';
	soPhonemeSymbols			= 'phsy';
	soCurrentVoice				= 'cvox';
	soCommandDelimiter			= 'dlim';
	soReset						= 'rset';
	soCurrentA5					= 'myA5';
	soRefCon					= 'refc';
	soTextDoneCallBack			= 'tdcb';						{  use with SpeechTextDoneProcPtr }
	soSpeechDoneCallBack		= 'sdcb';						{  use with SpeechDoneProcPtr }
	soSyncCallBack				= 'sycb';						{  use with SpeechSyncProcPtr }
	soErrorCallBack				= 'ercb';						{  use with SpeechErrorProcPtr }
	soPhonemeCallBack			= 'phcb';						{  use with SpeechPhonemeProcPtr }
	soWordCallBack				= 'wdcb';
	soSynthExtension			= 'xtnd';
	soSoundOutput				= 'sndo';


{------------------------------------------}
{ Speaking Mode Constants 					}
{------------------------------------------}
	modeText					= 'TEXT';						{  input mode constants 					 }
	modePhonemes				= 'PHON';
	modeNormal					= 'NORM';						{  character mode and number mode constants  }
	modeLiteral					= 'LTRL';


	soVoiceDescription			= 'info';
	soVoiceFile					= 'fref';



TYPE
	SpeechChannelRecordPtr = ^SpeechChannelRecord;
	SpeechChannelRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SpeechChannel						= ^SpeechChannelRecord;

	VoiceSpecPtr = ^VoiceSpec;
	VoiceSpec = RECORD
		creator:				OSType;
		id:						OSType;
	END;



CONST
	kNeuter						= 0;
	kMale						= 1;
	kFemale						= 2;





TYPE
	VoiceDescriptionPtr = ^VoiceDescription;
	VoiceDescription = RECORD
		length:					LONGINT;
		voice:					VoiceSpec;
		version:				LONGINT;
		name:					Str63;
		comment:				Str255;
		gender:					INTEGER;
		age:					INTEGER;
		script:					INTEGER;
		language:				INTEGER;
		region:					INTEGER;
		reserved:				ARRAY [0..3] OF LONGINT;
	END;



	VoiceFileInfoPtr = ^VoiceFileInfo;
	VoiceFileInfo = RECORD
		fileSpec:				FSSpec;
		resID:					INTEGER;
	END;

	SpeechStatusInfoPtr = ^SpeechStatusInfo;
	SpeechStatusInfo = RECORD
		outputBusy:				BOOLEAN;
		outputPaused:			BOOLEAN;
		inputBytesLeft:			LONGINT;
		phonemeCode:			INTEGER;
	END;



	SpeechErrorInfoPtr = ^SpeechErrorInfo;
	SpeechErrorInfo = RECORD
		count:					INTEGER;
		oldest:					OSErr;
		oldPos:					LONGINT;
		newest:					OSErr;
		newPos:					LONGINT;
	END;



	SpeechVersionInfoPtr = ^SpeechVersionInfo;
	SpeechVersionInfo = RECORD
		synthType:				OSType;
		synthSubType:			OSType;
		synthManufacturer:		OSType;
		synthFlags:				LONGINT;
		synthVersion:			NumVersion;
	END;



	PhonemeInfoPtr = ^PhonemeInfo;
	PhonemeInfo = RECORD
		opcode:					INTEGER;
		phStr:					Str15;
		exampleStr:				Str31;
		hiliteStart:			INTEGER;
		hiliteEnd:				INTEGER;
	END;


	PhonemeDescriptorPtr = ^PhonemeDescriptor;
	PhonemeDescriptor = RECORD
		phonemeCount:			INTEGER;
		thePhonemes:			ARRAY [0..0] OF PhonemeInfo;
	END;

	SpeechXtndDataPtr = ^SpeechXtndData;
	SpeechXtndData = PACKED RECORD
		synthCreator:			OSType;
		synthData:				PACKED ARRAY [0..1] OF Byte;
	END;


	DelimiterInfoPtr = ^DelimiterInfo;
	DelimiterInfo = PACKED RECORD
		startDelimiter:			PACKED ARRAY [0..1] OF Byte;
		endDelimiter:			PACKED ARRAY [0..1] OF Byte;
	END;


	SpeechTextDoneProcPtr = ProcPtr;  { PROCEDURE SpeechTextDone(chan: SpeechChannel; refCon: LONGINT; VAR nextBuf: UNIV Ptr; VAR byteLen: LONGINT; VAR controlFlags: LONGINT); }

	SpeechDoneProcPtr = ProcPtr;  { PROCEDURE SpeechDone(chan: SpeechChannel; refCon: LONGINT); }

	SpeechSyncProcPtr = ProcPtr;  { PROCEDURE SpeechSync(chan: SpeechChannel; refCon: LONGINT; syncMessage: OSType); }

	SpeechErrorProcPtr = ProcPtr;  { PROCEDURE SpeechError(chan: SpeechChannel; refCon: LONGINT; theError: OSErr; bytePos: LONGINT); }

	SpeechPhonemeProcPtr = ProcPtr;  { PROCEDURE SpeechPhoneme(chan: SpeechChannel; refCon: LONGINT; phonemeOpcode: INTEGER); }

	SpeechWordProcPtr = ProcPtr;  { PROCEDURE SpeechWord(chan: SpeechChannel; refCon: LONGINT; wordPos: LONGINT; wordLen: INTEGER); }

	SpeechTextDoneUPP = UniversalProcPtr;
	SpeechDoneUPP = UniversalProcPtr;
	SpeechSyncUPP = UniversalProcPtr;
	SpeechErrorUPP = UniversalProcPtr;
	SpeechPhonemeUPP = UniversalProcPtr;
	SpeechWordUPP = UniversalProcPtr;

CONST
	uppSpeechTextDoneProcInfo = $0000FFC0;
	uppSpeechDoneProcInfo = $000003C0;
	uppSpeechSyncProcInfo = $00000FC0;
	uppSpeechErrorProcInfo = $00003BC0;
	uppSpeechPhonemeProcInfo = $00000BC0;
	uppSpeechWordProcInfo = $00002FC0;

FUNCTION NewSpeechTextDoneProc(userRoutine: SpeechTextDoneProcPtr): SpeechTextDoneUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechDoneProc(userRoutine: SpeechDoneProcPtr): SpeechDoneUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechSyncProc(userRoutine: SpeechSyncProcPtr): SpeechSyncUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechErrorProc(userRoutine: SpeechErrorProcPtr): SpeechErrorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechPhonemeProc(userRoutine: SpeechPhonemeProcPtr): SpeechPhonemeUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechWordProc(userRoutine: SpeechWordProcPtr): SpeechWordUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSpeechTextDoneProc(chan: SpeechChannel; refCon: LONGINT; VAR nextBuf: UNIV Ptr; VAR byteLen: LONGINT; VAR controlFlags: LONGINT; userRoutine: SpeechTextDoneUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechDoneProc(chan: SpeechChannel; refCon: LONGINT; userRoutine: SpeechDoneUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechSyncProc(chan: SpeechChannel; refCon: LONGINT; syncMessage: OSType; userRoutine: SpeechSyncUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechErrorProc(chan: SpeechChannel; refCon: LONGINT; theError: OSErr; bytePos: LONGINT; userRoutine: SpeechErrorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechPhonemeProc(chan: SpeechChannel; refCon: LONGINT; phonemeOpcode: INTEGER; userRoutine: SpeechPhonemeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechWordProc(chan: SpeechChannel; refCon: LONGINT; wordPos: LONGINT; wordLen: INTEGER; userRoutine: SpeechWordUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION SpeechManagerVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000C, $A800;
	{$ENDC}
FUNCTION MakeVoiceSpec(creator: OSType; id: OSType; VAR voice: VoiceSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0604, $000C, $A800;
	{$ENDC}
FUNCTION CountVoices(VAR numVoices: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0108, $000C, $A800;
	{$ENDC}
FUNCTION GetIndVoice(index: INTEGER; VAR voice: VoiceSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $030C, $000C, $A800;
	{$ENDC}
FUNCTION GetVoiceDescription({CONST}VAR voice: VoiceSpec; VAR info: VoiceDescription; infoLength: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0610, $000C, $A800;
	{$ENDC}
FUNCTION GetVoiceInfo({CONST}VAR voice: VoiceSpec; selector: OSType; voiceInfo: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0614, $000C, $A800;
	{$ENDC}
FUNCTION NewSpeechChannel(voice: VoiceSpecPtr; VAR chan: SpeechChannel): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0418, $000C, $A800;
	{$ENDC}
FUNCTION DisposeSpeechChannel(chan: SpeechChannel): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $021C, $000C, $A800;
	{$ENDC}
FUNCTION SpeakString(textToBeSpoken: ConstStr255Param): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0220, $000C, $A800;
	{$ENDC}
FUNCTION SpeakText(chan: SpeechChannel; textBuf: UNIV Ptr; textBytes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0624, $000C, $A800;
	{$ENDC}
FUNCTION SpeakBuffer(chan: SpeechChannel; textBuf: UNIV Ptr; textBytes: LONGINT; controlFlags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0828, $000C, $A800;
	{$ENDC}
FUNCTION StopSpeech(chan: SpeechChannel): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $022C, $000C, $A800;
	{$ENDC}
FUNCTION StopSpeechAt(chan: SpeechChannel; whereToStop: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0430, $000C, $A800;
	{$ENDC}
FUNCTION PauseSpeechAt(chan: SpeechChannel; whereToPause: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0434, $000C, $A800;
	{$ENDC}
FUNCTION ContinueSpeech(chan: SpeechChannel): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0238, $000C, $A800;
	{$ENDC}
FUNCTION SpeechBusy: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $003C, $000C, $A800;
	{$ENDC}
FUNCTION SpeechBusySystemWide: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0040, $000C, $A800;
	{$ENDC}
FUNCTION SetSpeechRate(chan: SpeechChannel; rate: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0444, $000C, $A800;
	{$ENDC}
FUNCTION GetSpeechRate(chan: SpeechChannel; VAR rate: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0448, $000C, $A800;
	{$ENDC}
FUNCTION SetSpeechPitch(chan: SpeechChannel; pitch: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $044C, $000C, $A800;
	{$ENDC}
FUNCTION GetSpeechPitch(chan: SpeechChannel; VAR pitch: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0450, $000C, $A800;
	{$ENDC}
FUNCTION SetSpeechInfo(chan: SpeechChannel; selector: OSType; speechInfo: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0654, $000C, $A800;
	{$ENDC}
FUNCTION GetSpeechInfo(chan: SpeechChannel; selector: OSType; speechInfo: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0658, $000C, $A800;
	{$ENDC}
FUNCTION TextToPhonemes(chan: SpeechChannel; textBuf: UNIV Ptr; textBytes: LONGINT; phonemeBuf: Handle; VAR phonemeBytes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0A5C, $000C, $A800;
	{$ENDC}
FUNCTION UseDictionary(chan: SpeechChannel; dictionary: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0460, $000C, $A800;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SpeechSynthesisIncludes}

{$ENDC} {__SPEECHSYNTHESIS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
