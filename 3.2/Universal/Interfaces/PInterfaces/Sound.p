{
 	File:		Sound.p
 
 	Contains:	Sound Manager Interfaces.
 
 	Version:	Technology:	Sound Manager 3.3
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1986-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Sound;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUND__}
{$SETC __SOUND__ := 1}

{$I+}
{$SETC SoundIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
						* * *  N O T E  * * *

	This file has been updated to include Sound Manager 3.3 interfaces.

	Some of the Sound Manager 3.0 interfaces were not put into the InterfaceLib
	that originally shipped with the PowerMacs. These missing functions and the
	new 3.3 interfaces have been released in the SoundLib library for PowerPC
	developers to link with. The runtime library for these functions are
	installed by the Sound Manager. The following functions are found in SoundLib.

		GetCompressionInfo(), GetSoundPreference(), SetSoundPreference(),
		UnsignedFixedMulDiv(), SndGetInfo(), SndSetInfo(), GetSoundOutputInfo(),
		SetSoundOutputInfo(), GetCompressionName(), SoundConverterOpen(),
		SoundConverterClose(), SoundConverterGetBufferSizes(), SoundConverterBeginConversion(),
		SoundConverterConvertBuffer(), SoundConverterEndConversion(),
		AudioGetBass(), AudioGetInfo(), AudioGetMute(), AudioGetOutputDevice(),
		AudioGetTreble(), AudioGetVolume(), AudioMuteOnEvent(), AudioSetBass(),
		AudioSetMute(), AudioSetToDefaults(), AudioSetTreble(), AudioSetVolume(),
		OpenMixerSoundComponent(), CloseMixerSoundComponent(), SoundComponentAddSource(),
		SoundComponentGetInfo(), SoundComponentGetSource(), SoundComponentGetSourceData(),
		SoundComponentInitOutputDevice(), SoundComponentPauseSource(),
		SoundComponentPlaySourceBuffer(), SoundComponentRemoveSource(),
		SoundComponentSetInfo(), SoundComponentSetOutput(), SoundComponentSetSource(),
		SoundComponentStartSource(), SoundComponentStopSource(),
		ParseAIFFHeader(), ParseSndHeader(), SoundConverterGetInfo(), SoundConverterSetInfo()
}
{
	Interfaces for Sound Driver, !!! OBSOLETE and NOT SUPPORTED !!!

	These items are no longer defined, but appear here so that someone
	searching the interfaces might find them. If you are using one of these
	items, you must change your code to support the Sound Manager.

		swMode, ftMode, ffMode
		FreeWave, FFSynthRec, Tone, SWSynthRec, Wave, FTSoundRec
		SndCompletionProcPtr
		StartSound, StopSound, SoundDone
}
{
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constants
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}
CONST twelfthRootTwo = 1.05946309435;


CONST
	soundListRsrc				= 'snd ';						{ Resource type used by Sound Manager }

	kSimpleBeepID				= 1;							{ reserved resource ID for Simple Beep }

	rate48khz					= $BB800000;					{ 48000.00000 in fixed-point }
	rate44khz					= $AC440000;					{ 44100.00000 in fixed-point }
	rate22050hz					= $56220000;					{ 22050.00000 in fixed-point }
	rate22khz					= $56EE8BA3;					{ 22254.54545 in fixed-point }
	rate11khz					= $2B7745D1;					{ 11127.27273 in fixed-point }
	rate11025hz					= $2B110000;					{ 11025.00000 in fixed-point }

																{ synthesizer numbers for SndNewChannel }
	squareWaveSynth				= 1;							{ square wave synthesizer }
	waveTableSynth				= 3;							{ wave table synthesizer }
	sampledSynth				= 5;							{ sampled sound synthesizer }
																{ old Sound Manager MACE synthesizer numbers }
	MACE3snthID					= 11;
	MACE6snthID					= 13;

	kMiddleC					= 60;							{ MIDI note value for middle C }

	kNoVolume					= 0;							{ setting for no sound volume }
	kFullVolume					= $0100;						{ 1.0, setting for full hardware output volume }

	stdQLength					= 128;

	dataOffsetFlag				= $8000;

	kUseOptionalOutputDevice	= -1;							{ only for Sound Manager 3.0 or later }

	notCompressed				= 0;							{ compression ID's }
	fixedCompression			= -1;							{ compression ID for fixed-sized compression }
	variableCompression			= -2;							{ compression ID for variable-sized compression }

	twoToOne					= 1;
	eightToThree				= 2;
	threeToOne					= 3;
	sixToOne					= 4;
	sixToOnePacketSize			= 8;
	threeToOnePacketSize		= 16;

	stateBlockSize				= 64;
	leftOverBlockSize			= 32;

	firstSoundFormat			= $0001;						{ general sound format }
	secondSoundFormat			= $0002;						{ special sampled sound format (HyperCard) }

	dbBufferReady				= $00000001;					{ double buffer is filled }
	dbLastBuffer				= $00000004;					{ last double buffer to play }

	sysBeepDisable				= $0000;						{ SysBeep() enable flags }
	sysBeepEnable				= $01;
	sysBeepSynchronous			= $02;							{ if bit set, make alert sounds synchronous }

	unitTypeNoSelection			= $FFFF;						{ unitTypes for AudioSelection.unitType }
	unitTypeSeconds				= $0000;

	stdSH						= $00;							{ Standard sound header encode value }
	extSH						= $FF;							{ Extended sound header encode value }
	cmpSH						= $FE;							{ Compressed sound header encode value }

{command numbers for SndDoCommand and SndDoImmediate}
	nullCmd						= 0;
	initCmd						= 1;
	freeCmd						= 2;
	quietCmd					= 3;
	flushCmd					= 4;
	reInitCmd					= 5;
	waitCmd						= 10;
	pauseCmd					= 11;
	resumeCmd					= 12;
	callBackCmd					= 13;
	syncCmd						= 14;
	availableCmd				= 24;
	versionCmd					= 25;
	totalLoadCmd				= 26;
	loadCmd						= 27;
	freqDurationCmd				= 40;
	restCmd						= 41;
	freqCmd						= 42;
	ampCmd						= 43;
	timbreCmd					= 44;
	getAmpCmd					= 45;
	volumeCmd					= 46;							{ sound manager 3.0 or later only }
	getVolumeCmd				= 47;							{ sound manager 3.0 or later only }
	clockComponentCmd			= 50;							{ sound manager 3.2.1 or later only }
	getClockComponentCmd		= 51;							{ sound manager 3.2.1 or later only }
	scheduledSoundCmd			= 52;							{ sound manager 3.3 or later only }
	linkSoundComponentsCmd		= 53;							{ sound manager 3.3 or later only }
	waveTableCmd				= 60;
	phaseCmd					= 61;
	soundCmd					= 80;
	bufferCmd					= 81;
	rateCmd						= 82;
	continueCmd					= 83;
	doubleBufferCmd				= 84;
	getRateCmd					= 85;
	rateMultiplierCmd			= 86;
	getRateMultiplierCmd		= 87;
	sizeCmd						= 90;							{ obsolete command }
	convertCmd					= 91;							{ obsolete MACE command }

{$IFC OLDROUTINENAMES }
{channel initialization parameters}
	waveInitChannelMask			= $07;
	waveInitChannel0			= $04;							{ wave table only, Sound Manager 2.0 and earlier }
	waveInitChannel1			= $05;							{ wave table only, Sound Manager 2.0 and earlier }
	waveInitChannel2			= $06;							{ wave table only, Sound Manager 2.0 and earlier }
	waveInitChannel3			= $07;							{ wave table only, Sound Manager 2.0 and earlier }
	initChan0					= $04;							{ obsolete spelling }
	initChan1					= $05;							{ obsolete spelling }
	initChan2					= $06;							{ obsolete spelling }
	initChan3					= $07;							{ obsolete spelling }

	outsideCmpSH				= 0;							{ obsolete MACE constant }
	insideCmpSH					= 1;							{ obsolete MACE constant }
	aceSuccess					= 0;							{ obsolete MACE constant }
	aceMemFull					= 1;							{ obsolete MACE constant }
	aceNilBlock					= 2;							{ obsolete MACE constant }
	aceBadComp					= 3;							{ obsolete MACE constant }
	aceBadEncode				= 4;							{ obsolete MACE constant }
	aceBadDest					= 5;							{ obsolete MACE constant }
	aceBadCmd					= 6;							{ obsolete MACE constant }

{$ENDC}  {OLDROUTINENAMES}

	initChanLeft				= $0002;						{ left stereo channel }
	initChanRight				= $0003;						{ right stereo channel }
	initNoInterp				= $0004;						{ no linear interpolation }
	initNoDrop					= $0008;						{ no drop-sample conversion }
	initMono					= $0080;						{ monophonic channel }
	initStereo					= $00C0;						{ stereo channel }
	initMACE3					= $0300;						{ MACE 3:1 }
	initMACE6					= $0400;						{ MACE 6:1 }
	initPanMask					= $0003;						{ mask for right/left pan values }
	initSRateMask				= $0030;						{ mask for sample rate values }
	initStereoMask				= $00C0;						{ mask for mono/stereo values }
	initCompMask				= $FF00;						{ mask for compression IDs }

{Get&Set Sound Information Selectors}
	siActiveChannels			= 'chac';						{ active channels }
	siActiveLevels				= 'lmac';						{ active meter levels }
	siAGCOnOff					= 'agc ';						{ automatic gain control state }
	siAsync						= 'asyn';						{ asynchronous capability }
	siAVDisplayBehavior			= 'avdb';
	siChannelAvailable			= 'chav';						{ number of channels available }
	siCompressionAvailable		= 'cmav';						{ compression types available }
	siCompressionChannels		= 'cpct';						{ compressor's number of channels }
	siCompressionFactor			= 'cmfa';						{ current compression factor }
	siCompressionHeader			= 'cmhd';						{ return compression header }
	siCompressionNames			= 'cnam';						{ compression type names available }
	siCompressionParams			= 'evaw';						{ compression parameters }
	siCompressionSampleRate		= 'cprt';						{ compressor's sample rate }
	siCompressionType			= 'comp';						{ current compression type }
	siContinuous				= 'cont';						{ continous recording }
	siDecompressionParams		= 'wave';						{ decompression parameters }
	siDeviceBufferInfo			= 'dbin';						{ size of interrupt buffer }
	siDeviceConnected			= 'dcon';						{ input device connection status }
	siDeviceIcon				= 'icon';						{ input device icon }
	siDeviceName				= 'name';						{ input device name }
	siHardwareBalance			= 'hbal';
	siHardwareBalanceSteps		= 'hbls';
	siHardwareBass				= 'hbas';
	siHardwareBassSteps			= 'hbst';
	siHardwareBusy				= 'hwbs';						{ sound hardware is in use }
	siHardwareFormat			= 'hwfm';						{ get hardware format }
	siHardwareMute				= 'hmut';						{ mute state of all hardware }
	siHardwareTreble			= 'htrb';
	siHardwareTrebleSteps		= 'hwts';
	siHardwareVolume			= 'hvol';						{ volume level of all hardware }
	siHardwareVolumeSteps		= 'hstp';						{ number of volume steps for hardware }
	siHeadphoneMute				= 'pmut';						{ mute state of headphones }
	siHeadphoneVolume			= 'pvol';						{ volume level of headphones }
	siHeadphoneVolumeSteps		= 'hdst';						{ number of volume steps for headphones }
	siInputAvailable			= 'inav';						{ input sources available }
	siInputGain					= 'gain';						{ input gain }
	siInputSource				= 'sour';						{ input source selector }
	siInputSourceNames			= 'snam';						{ input source names }
	siLevelMeterOnOff			= 'lmet';						{ level meter state }
	siModemGain					= 'mgai';						{ modem input gain }
	siMonitorAvailable			= 'mnav';
	siMonitorSource				= 'mons';
	siNumberChannels			= 'chan';						{ current number of channels }
	siOptionsDialog				= 'optd';						{ display options dialog }
	siOSTypeInputSource			= 'inpt';						{ input source by OSType }
	siOSTypeInputAvailable		= 'inav';						{ list of available input source OSTypes }
	siPlayThruOnOff				= 'plth';						{ playthrough state }
	siPostMixerSoundComponent	= 'psmx';						{ install post-mixer effect }
	siPreMixerSoundComponent	= 'prmx';						{ install pre-mixer effect }
	siQuality					= 'qual';						{ quality setting }
	siRateMultiplier			= 'rmul';						{ throttle rate setting }
	siRecordingQuality			= 'qual';						{ recording quality }
	siSampleRate				= 'srat';						{ current sample rate }
	siSampleRateAvailable		= 'srav';						{ sample rates available }
	siSampleSize				= 'ssiz';						{ current sample size }
	siSampleSizeAvailable		= 'ssav';						{ sample sizes available }
	siSetupCDAudio				= 'sucd';						{ setup sound hardware for CD audio }
	siSetupModemAudio			= 'sumd';						{ setup sound hardware for modem audio }
	siSlopeAndIntercept			= 'flap';						{ floating point variables for conversion }
	siSoundClock				= 'sclk';
	siUseThisSoundClock			= 'sclc';						{ sdev uses this to tell the mixer to use his sound clock }
	siSpeakerMute				= 'smut';						{ mute state of all built-in speaker }
	siSpeakerVolume				= 'svol';						{ volume level of built-in speaker }
	siSSpCPULoadLimit			= '3dll';
	siSSpLocalization			= '3dif';
	siSSpSpeakerSetup			= '3dst';
	siStereoInputGain			= 'sgai';						{ stereo input gain }
	siSubwooferMute				= 'bmut';						{ mute state of sub-woofer }
	siTwosComplementOnOff		= 'twos';						{ two's complement state }
	siVolume					= 'volu';						{ volume level of source }
	siVoxRecordInfo				= 'voxr';						{ VOX record parameters }
	siVoxStopInfo				= 'voxs';						{ VOX stop parameters }
	siWideStereo				= 'wide';						{ wide stereo setting }

	siCloseDriver				= 'clos';						{ reserved for internal use only }
	siInitializeDriver			= 'init';						{ reserved for internal use only }
	siPauseRecording			= 'paus';						{ reserved for internal use only }
	siUserInterruptProc			= 'user';						{ reserved for internal use only }

{  input source Types }
	kInvalidSource				= $FFFFFFFF;					{ this source may be returned from GetInfo if no other source is the monitored source }
	kNoSource					= 'none';						{ no source selection }
	kCDSource					= 'cd  ';						{ internal CD player input }
	kExtMicSource				= 'emic';						{ external mic input }
	kSoundInSource				= 'sinj';						{ sound input jack }
	kRCAInSource				= 'irca';						{ RCA jack input }
	kTVFMTunerSource			= 'tvfm';
	kDAVInSource				= 'idav';						{ DAV analog input }
	kIntMicSource				= 'imic';						{ internal mic input }
	kMediaBaySource				= 'mbay';						{ media bay input }
	kModemSource				= 'modm';						{ modem input (internal modem on desktops, PCI input on PowerBooks) }
	kPCCardSource				= 'pcm ';						{ PC Card pwm input }
	kZoomVideoSource			= 'zvpc';						{ zoom video input }
	kDVDSource					= 'dvda';						{ DVD audio input }

{ Sound Component Types and Subtypes }
	kNoSoundComponentType		= '****';
	kSoundComponentType			= 'sift';						{ component type }
	kSoundComponentPPCType		= 'nift';						{ component type for PowerPC code }
	kRate8SubType				= 'ratb';						{ 8-bit rate converter }
	kRate16SubType				= 'ratw';						{ 16-bit rate converter }
	kConverterSubType			= 'conv';						{ sample format converter }
	kSndSourceSubType			= 'sour';						{ generic source component }
	kMixerType					= 'mixr';
	kMixer8SubType				= 'mixb';						{ 8-bit mixer }
	kMixer16SubType				= 'mixw';						{ 16-bit mixer }
	kSoundInputDeviceType		= 'sinp';						{ sound input component }
	kWaveInSubType				= 'wavi';						{ Windows Wave }
	kSoundOutputDeviceType		= 'sdev';						{ sound output component }
	kClassicSubType				= 'clas';						{ classic hardware, i.e. Mac Plus }
	kASCSubType					= 'asc ';						{ Apple Sound Chip device }
	kDSPSubType					= 'dsp ';						{ DSP device }
	kAwacsSubType				= 'awac';						{ Another of Will's Audio Chips device }
	kGCAwacsSubType				= 'awgc';						{ Awacs audio with Grand Central DMA }
	kSingerSubType				= 'sing';						{ Singer (via Whitney) based sound }
	kSinger2SubType				= 'sng2';						{ Singer 2 (via Whitney) for Acme }
	kWhitSubType				= 'whit';						{ Whit sound component for PrimeTime 3 }
	kSoundBlasterSubType		= 'sbls';						{ Sound Blaster for CHRP }
	kWaveOutSubType				= 'wavo';						{ Windows Wave }
	kDirectSoundSubType			= 'dsnd';						{ Direct Sound }
	kUNIXsdevSubType			= 'un1x';						{ UNIX base sdev }
	kSoundCompressor			= 'scom';
	kSoundDecompressor			= 'sdec';
	kAudioComponentType			= 'adio';						{ Audio components and sub-types }
	kAwacsPhoneSubType			= 'hphn';
	kAudioVisionSpeakerSubType	= 'telc';
	kAudioVisionHeadphoneSubType = 'telh';
	kPhilipsFaderSubType		= 'tvav';
	kSGSToneSubType				= 'sgs0';
	kSoundEffectsType			= 'snfx';						{ sound effects type }
	kSSpLocalizationSubType		= 'snd3';

{ Format Types }
	kSoundNotCompressed			= 'NONE';						{ sound is not compressed }
	k8BitOffsetBinaryFormat		= 'raw ';						{ 8-bit offset binary }
	k16BitBigEndianFormat		= 'twos';						{ 16-bit big endian }
	k16BitLittleEndianFormat	= 'sowt';						{ 16-bit little endian }
	kFloat32Format				= 'fl32';						{ 32-bit floating point }
	kFloat64Format				= 'fl64';						{ 64-bit floating point }
	k24BitFormat				= 'in24';						{ 24-bit integer }
	k32BitFormat				= 'in32';						{ 32-bit integer }
	kMACE3Compression			= 'MAC3';						{ MACE 3:1 }
	kMACE6Compression			= 'MAC6';						{ MACE 6:1 }
	kCDXA4Compression			= 'cdx4';						{ CD/XA 4:1 }
	kCDXA2Compression			= 'cdx2';						{ CD/XA 2:1 }
	kIMACompression				= 'ima4';						{ IMA 4:1 }
	kULawCompression			= 'ulaw';						{ µLaw 2:1 }
	kALawCompression			= 'alaw';						{ aLaw 2:1 }
	kMicrosoftADPCMFormat		= $6D730002;					{ Microsoft ADPCM - ACM code 2 }
	kDVIIntelIMAFormat			= $6D730011;					{ DVI/Intel IMA ADPCM - ACM code 17 }
	kDVAudioFormat				= 'dvca';						{ DV Audio }
	kQDesignCompression			= 'QDMC';						{ QDesign music }
	kQUALCOMMCompression		= 'Qclp';						{ QUALCOMM PureVoice }
	kOffsetBinary				= 'raw ';						{ for compatibility }
	kTwosComplement				= 'twos';						{ for compatibility }
	kLittleEndianFormat			= 'sowt';						{ for compatibility }

{$IFC TARGET_RT_LITTLE_ENDIAN }
	k16BitNativeEndianFormat	= 'sowt';
	k16BitNonNativeEndianFormat	= 'twos';

{$ELSEC}
	k16BitNativeEndianFormat	= 'twos';
	k16BitNonNativeEndianFormat	= 'sowt';

{$ENDC}  {TARGET_RT_LITTLE_ENDIAN}

{ Features Flags }
	k8BitRawIn					= $01;							{ data description }
	k8BitTwosIn					= $02;
	k16BitIn					= $04;
	kStereoIn					= $08;
	k8BitRawOut					= $0100;
	k8BitTwosOut				= $0200;
	k16BitOut					= $0400;
	kStereoOut					= $0800;
	kReverse					= $00010000;					{   function description }
	kRateConvert				= $00020000;
	kCreateSoundSource			= $00040000;
	kHighQuality				= $00400000;					{   performance description }
	kNonRealTime				= $00800000;

{ SoundComponentPlaySourceBuffer action flags }
	kSourcePaused				= $01;
	kPassThrough				= $00010000;
	kNoSoundComponentChain		= $00020000;

{ SoundParamBlock flags, usefull for OpenMixerSoundComponent }
	kNoMixing					= $01;							{ don't mix source }
	kNoSampleRateConversion		= $02;							{ don't convert sample rate (i.e. 11 kHz -> 22 kHz) }
	kNoSampleSizeConversion		= $04;							{ don't convert sample size (i.e. 16 -> 8) }
	kNoSampleFormatConversion	= $08;							{ don't convert sample format (i.e. 'twos' -> 'raw ') }
	kNoChannelConversion		= $10;							{ don't convert stereo/mono }
	kNoDecompression			= $20;							{ don't decompress (i.e. 'MAC3' -> 'raw ') }
	kNoVolumeConversion			= $40;							{ don't apply volume }
	kNoRealtimeProcessing		= $80;							{ won't run at interrupt time }
	kScheduledSource			= $0100;						{ source is scheduled }

{ SoundParamBlock quality settings }
	kBestQuality				= $01;							{ use interpolation in rate conversion }

{ useful bit masks }
	kInputMask					= $000000FF;					{ masks off input bits }
	kOutputMask					= $0000FF00;					{ masks off output bits }
	kOutputShift				= 8;							{ amount output bits are shifted }
	kActionMask					= $00FF0000;					{ masks off action bits }
	kSoundComponentBits			= $00FFFFFF;

{ audio atom types }
	kAudioFormatAtomType		= 'frma';
	kAudioEndianAtomType		= 'enda';
	kAudioTerminatorAtomType	= 0;

{ siAVDisplayBehavior types }
	kAVDisplayHeadphoneRemove	= 0;							{  monitor does not have a headphone attached }
	kAVDisplayHeadphoneInsert	= 1;							{  monitor has a headphone attached }
	kAVDisplayPlainTalkRemove	= 2;							{  monitor either sending no input through CPU input port or unable to tell if input is coming in }
	kAVDisplayPlainTalkInsert	= 3;							{  monitor sending PlainTalk level microphone source input through sound input port }

{ Audio Component constants }
																{ Values for whichChannel parameter }
	audioAllChannels			= 0;							{ All channels (usually interpreted as both left and right) }
	audioLeftChannel			= 1;							{ Left channel }
	audioRightChannel			= 2;							{ Right channel }
																{ Values for mute parameter }
	audioUnmuted				= 0;							{ Device is unmuted }
	audioMuted					= 1;							{ Device is muted }
																{ Capabilities flags definitions }
	audioDoesMono				= $00000001;					{ Device supports mono output }
	audioDoesStereo				= $00000002;					{ Device supports stereo output }
	audioDoesIndependentChannels = $00000004;					{ Device supports independent software control of each channel }

{Sound Input Qualities}
	siCDQuality					= 'cd  ';						{ 44.1kHz, stereo, 16 bit }
	siBestQuality				= 'best';						{ 22kHz, mono, 8 bit }
	siBetterQuality				= 'betr';						{ 22kHz, mono, MACE 3:1 }
	siGoodQuality				= 'good';						{ 22kHz, mono, MACE 6:1 }
	siNoneQuality				= 'none';						{ settings don't match any quality for a get call }

	siDeviceIsConnected			= 1;							{ input device is connected and ready for input }
	siDeviceNotConnected		= 0;							{ input device is not connected }
	siDontKnowIfConnected		= -1;							{ can't tell if input device is connected }
	siReadPermission			= 0;							{ permission passed to SPBOpenDevice }
	siWritePermission			= 1;							{ permission passed to SPBOpenDevice }

{
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   typedefs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}


TYPE
	SndCommandPtr = ^SndCommand;
	SndCommand = PACKED RECORD
		cmd:					UInt16;
		param1:					INTEGER;
		param2:					LONGINT;
	END;

	SndChannelPtr = ^SndChannel;
{$IFC TYPED_FUNCTION_POINTERS}
	SndCallBackProcPtr = PROCEDURE(chan: SndChannelPtr; VAR cmd: SndCommand);
{$ELSEC}
	SndCallBackProcPtr = ProcPtr;
{$ENDC}

	SndCallBackUPP = UniversalProcPtr;
	SndChannel = PACKED RECORD
		nextChan:				SndChannelPtr;
		firstMod:				Ptr;									{  reserved for the Sound Manager  }
		callBack:				SndCallBackUPP;
		userInfo:				LONGINT;
		wait:					LONGINT;								{  The following is for internal Sound Manager use only. }
		cmdInProgress:			SndCommand;
		flags:					INTEGER;
		qLength:				INTEGER;
		qHead:					INTEGER;
		qTail:					INTEGER;
		queue:					ARRAY [0..127] OF SndCommand;
	END;

{MACE structures}
	StateBlockPtr = ^StateBlock;
	StateBlock = RECORD
		stateVar:				ARRAY [0..63] OF INTEGER;
	END;

	LeftOverBlockPtr = ^LeftOverBlock;
	LeftOverBlock = RECORD
		count:					UInt32;
		sampleArea:				ARRAY [0..31] OF SInt8;
	END;

	ModRefPtr = ^ModRef;
	ModRef = RECORD
		modNumber:				UInt16;
		modInit:				LONGINT;
	END;

	SndListResourcePtr = ^SndListResource;
	SndListResource = RECORD
		format:					INTEGER;
		numModifiers:			INTEGER;
		modifierPart:			ARRAY [0..0] OF ModRef;
		numCommands:			INTEGER;
		commandPart:			ARRAY [0..0] OF SndCommand;
		dataPart:				SInt8;
	END;

	SndListPtr							= ^SndListResource;
	SndListHandle						= ^SndListPtr;
	SndListHndl							= SndListHandle;
{HyperCard sound resource format}
	Snd2ListResourcePtr = ^Snd2ListResource;
	Snd2ListResource = RECORD
		format:					INTEGER;
		refCount:				INTEGER;
		numCommands:			INTEGER;
		commandPart:			ARRAY [0..0] OF SndCommand;
		dataPart:				SInt8;
	END;

	Snd2ListPtr							= ^Snd2ListResource;
	Snd2ListHandle						= ^Snd2ListPtr;
	Snd2ListHndl						= Snd2ListHandle;
	SoundHeaderPtr = ^SoundHeader;
	SoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{ if NIL then samples are in sampleArea }
		length:					UInt32;									{ length of sound in bytes }
		sampleRate:				UnsignedFixed;							{ sample rate for this sound }
		loopStart:				UInt32;									{ start of looping portion }
		loopEnd:				UInt32;									{ end of looping portion }
		encode:					UInt8;									{ header encoding }
		baseFrequency:			UInt8;									{ baseFrequency value }
		sampleArea:				PACKED ARRAY [0..0] OF UInt8;			{ space for when samples follow directly }
	END;

	CmpSoundHeaderPtr = ^CmpSoundHeader;
	CmpSoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{ if nil then samples are in sample area }
		numChannels:			UInt32;									{ number of channels i.e. mono = 1 }
		sampleRate:				UnsignedFixed;							{ sample rate in Apples Fixed point representation }
		loopStart:				UInt32;									{ loopStart of sound before compression }
		loopEnd:				UInt32;									{ loopEnd of sound before compression }
		encode:					UInt8;									{ data structure used , stdSH, extSH, or cmpSH }
		baseFrequency:			UInt8;									{ same meaning as regular SoundHeader }
		numFrames:				UInt32;									{ length in frames ( packetFrames or sampleFrames ) }
		AIFFSampleRate:			extended80;								{ IEEE sample rate }
		markerChunk:			Ptr;									{ sync track }
		format:					OSType;									{ data format type, was futureUse1 }
		futureUse2:				UInt32;									{ reserved by Apple }
		stateVars:				StateBlockPtr;							{ pointer to State Block }
		leftOverSamples:		LeftOverBlockPtr;						{ used to save truncated samples between compression calls }
		compressionID:			INTEGER;								{ 0 means no compression, non zero means compressionID }
		packetSize:				UInt16;									{ number of bits in compressed sample packet }
		snthID:					UInt16;									{ resource ID of Sound Manager snth that contains NRT C/E }
		sampleSize:				UInt16;									{ number of bits in non-compressed sample }
		sampleArea:				PACKED ARRAY [0..0] OF UInt8;			{ space for when samples follow directly }
	END;

	ExtSoundHeaderPtr = ^ExtSoundHeader;
	ExtSoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{ if nil then samples are in sample area }
		numChannels:			UInt32;									{ number of channels,  ie mono = 1 }
		sampleRate:				UnsignedFixed;							{ sample rate in Apples Fixed point representation }
		loopStart:				UInt32;									{ same meaning as regular SoundHeader }
		loopEnd:				UInt32;									{ same meaning as regular SoundHeader }
		encode:					UInt8;									{ data structure used , stdSH, extSH, or cmpSH }
		baseFrequency:			UInt8;									{ same meaning as regular SoundHeader }
		numFrames:				UInt32;									{ length in total number of frames }
		AIFFSampleRate:			extended80;								{ IEEE sample rate }
		markerChunk:			Ptr;									{ sync track }
		instrumentChunks:		Ptr;									{ AIFF instrument chunks }
		AESRecording:			Ptr;
		sampleSize:				UInt16;									{ number of bits in sample }
		futureUse1:				UInt16;									{ reserved by Apple }
		futureUse2:				UInt32;									{ reserved by Apple }
		futureUse3:				UInt32;									{ reserved by Apple }
		futureUse4:				UInt32;									{ reserved by Apple }
		sampleArea:				PACKED ARRAY [0..0] OF UInt8;			{ space for when samples follow directly }
	END;

	SoundHeaderUnionPtr = ^SoundHeaderUnion;
	SoundHeaderUnion = RECORD
		CASE INTEGER OF
		0: (
			stdHeader:			SoundHeader;
			);
		1: (
			cmpHeader:			CmpSoundHeader;
			);
		2: (
			extHeader:			ExtSoundHeader;
			);
	END;

	ConversionBlockPtr = ^ConversionBlock;
	ConversionBlock = RECORD
		destination:			INTEGER;
		unused:					INTEGER;
		inputPtr:				CmpSoundHeaderPtr;
		outputPtr:				CmpSoundHeaderPtr;
	END;

{  ScheduledSoundHeader flags }

CONST
	kScheduledSoundDoScheduled	= $01;
	kScheduledSoundDoCallBack	= $02;


TYPE
	ScheduledSoundHeaderPtr = ^ScheduledSoundHeader;
	ScheduledSoundHeader = RECORD
		u:						SoundHeaderUnion;
		flags:					LONGINT;
		reserved:				INTEGER;
		callBackParam1:			INTEGER;
		callBackParam2:			LONGINT;
		startTime:				TimeRecord;
	END;

	SMStatusPtr = ^SMStatus;
	SMStatus = PACKED RECORD
		smMaxCPULoad:			INTEGER;
		smNumChannels:			INTEGER;
		smCurCPULoad:			INTEGER;
	END;

	SCStatusPtr = ^SCStatus;
	SCStatus = RECORD
		scStartTime:			UnsignedFixed;
		scEndTime:				UnsignedFixed;
		scCurrentTime:			UnsignedFixed;
		scChannelBusy:			BOOLEAN;
		scChannelDisposed:		BOOLEAN;
		scChannelPaused:		BOOLEAN;
		scUnused:				BOOLEAN;
		scChannelAttributes:	UInt32;
		scCPULoad:				LONGINT;
	END;

	AudioSelectionPtr = ^AudioSelection;
	AudioSelection = PACKED RECORD
		unitType:				LONGINT;
		selStart:				UnsignedFixed;
		selEnd:					UnsignedFixed;
	END;

	SndDoubleBufferPtr = ^SndDoubleBuffer;
	SndDoubleBuffer = PACKED RECORD
		dbNumFrames:			LONGINT;
		dbFlags:				LONGINT;
		dbUserInfo:				ARRAY [0..1] OF LONGINT;
		dbSoundData:			ARRAY [0..0] OF SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	SndDoubleBackProcPtr = PROCEDURE(channel: SndChannelPtr; doubleBufferPtr: SndDoubleBufferPtr);
{$ELSEC}
	SndDoubleBackProcPtr = ProcPtr;
{$ENDC}

	SndDoubleBackUPP = UniversalProcPtr;
	SndDoubleBufferHeaderPtr = ^SndDoubleBufferHeader;
	SndDoubleBufferHeader = PACKED RECORD
		dbhNumChannels:			INTEGER;
		dbhSampleSize:			INTEGER;
		dbhCompressionID:		INTEGER;
		dbhPacketSize:			INTEGER;
		dbhSampleRate:			UnsignedFixed;
		dbhBufferPtr:			ARRAY [0..1] OF SndDoubleBufferPtr;
		dbhDoubleBack:			SndDoubleBackUPP;
	END;

	SndDoubleBufferHeader2Ptr = ^SndDoubleBufferHeader2;
	SndDoubleBufferHeader2 = PACKED RECORD
		dbhNumChannels:			INTEGER;
		dbhSampleSize:			INTEGER;
		dbhCompressionID:		INTEGER;
		dbhPacketSize:			INTEGER;
		dbhSampleRate:			UnsignedFixed;
		dbhBufferPtr:			ARRAY [0..1] OF SndDoubleBufferPtr;
		dbhDoubleBack:			SndDoubleBackUPP;
		dbhFormat:				OSType;
	END;

	SoundInfoListPtr = ^SoundInfoList;
	SoundInfoList = PACKED RECORD
		count:					INTEGER;
		infoHandle:				Handle;
	END;

	SoundComponentDataPtr = ^SoundComponentData;
	SoundComponentData = RECORD
		flags:					LONGINT;
		format:					OSType;
		numChannels:			INTEGER;
		sampleSize:				INTEGER;
		sampleRate:				UnsignedFixed;
		sampleCount:			LONGINT;
		buffer:					Ptr;
		reserved:				LONGINT;
	END;

	SoundParamBlockPtr = ^SoundParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	SoundParamProcPtr = FUNCTION(VAR pb: SoundParamBlockPtr): BOOLEAN;
{$ELSEC}
	SoundParamProcPtr = ProcPtr;
{$ENDC}

	SoundParamUPP = UniversalProcPtr;
	SoundParamBlock = RECORD
		recordSize:				LONGINT;								{ size of this record in bytes }
		desc:					SoundComponentData;						{ description of sound buffer }
		rateMultiplier:			UnsignedFixed;							{ rate multiplier to apply to sound }
		leftVolume:				INTEGER;								{ volumes to apply to sound }
		rightVolume:			INTEGER;
		quality:				LONGINT;								{ quality to apply to sound }
		filter:					ComponentInstance;						{ filter to apply to sound }
		moreRtn:				SoundParamUPP;							{ routine to call to get more data }
		completionRtn:			SoundParamUPP;							{ routine to call when buffer is complete }
		refCon:					LONGINT;								{ user refcon }
		result:					INTEGER;								{ result }
	END;

	CompressionInfoPtr = ^CompressionInfo;
	CompressionInfo = RECORD
		recordSize:				LONGINT;
		format:					OSType;
		compressionID:			INTEGER;
		samplesPerPacket:		UInt16;
		bytesPerPacket:			UInt16;
		bytesPerFrame:			UInt16;
		bytesPerSample:			UInt16;
		futureUse1:				UInt16;
	END;

	CompressionInfoHandle				= ^CompressionInfoPtr;
{ variables for floating point conversion }
	SoundSlopeAndInterceptRecordPtr = ^SoundSlopeAndInterceptRecord;
	SoundSlopeAndInterceptRecord = RECORD
		slope:					Float64;
		intercept:				Float64;
		minClip:				Float64;
		maxClip:				Float64;
	END;

	SoundSlopeAndInterceptPtr			= ^SoundSlopeAndInterceptRecord;
{ private thing to use as a reference to a Sound Converter }
	SoundConverter = ^LONGINT;
{ private thing to use as a reference to a Sound Source }
	SoundSource = ^LONGINT;
	SoundSourcePtr						= ^SoundSource;
	SoundComponentLinkPtr = ^SoundComponentLink;
	SoundComponentLink = RECORD
		description:			ComponentDescription;					{ Describes the sound component }
		mixerID:				SoundSource;							{ Reserved by Apple }
		linkID:					SoundSourcePtr;							{ Reserved by Apple }
	END;

	AudioInfoPtr = ^AudioInfo;
	AudioInfo = RECORD
		capabilitiesFlags:		LONGINT;								{ Describes device capabilities }
		reserved:				LONGINT;								{ Reserved by Apple }
		numVolumeSteps:			UInt16;									{ Number of significant increments between min and max volume }
	END;

	AudioFormatAtomPtr = ^AudioFormatAtom;
	AudioFormatAtom = RECORD
		size:					LONGINT;								{  = sizeof(AudioFormatAtom) }
		atomType:				OSType;									{  = kAudioFormatAtomType }
		format:					OSType;
	END;

	AudioEndianAtomPtr = ^AudioEndianAtom;
	AudioEndianAtom = RECORD
		size:					LONGINT;								{  = sizeof(AudioEndianAtom) }
		atomType:				OSType;									{  = kAudioEndianAtomType }
		littleEndian:			INTEGER;
	END;

	AudioTerminatorAtomPtr = ^AudioTerminatorAtom;
	AudioTerminatorAtom = RECORD
		size:					LONGINT;								{  = sizeof(AudioTerminatorAtom) }
		atomType:				OSType;									{  = kAudioTerminatorAtomType }
	END;

{  Sound Input Structures }
	SPBPtr = ^SPB;
{user procedures called by sound input routines}
{$IFC TYPED_FUNCTION_POINTERS}
	SIInterruptProcPtr = PROCEDURE(inParamPtr: SPBPtr; dataBuffer: Ptr; peakAmplitude: INTEGER; sampleSize: LONGINT);
{$ELSEC}
	SIInterruptProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FilePlayCompletionProcPtr = PROCEDURE(chan: SndChannelPtr);
{$ELSEC}
	FilePlayCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SICompletionProcPtr = PROCEDURE(inParamPtr: SPBPtr);
{$ELSEC}
	SICompletionProcPtr = ProcPtr;
{$ENDC}

	SIInterruptUPP = UniversalProcPtr;
	FilePlayCompletionUPP = UniversalProcPtr;
	SICompletionUPP = UniversalProcPtr;
{Sound Input Parameter Block}
	SPB = RECORD
		inRefNum:				LONGINT;								{ reference number of sound input device }
		count:					UInt32;									{ number of bytes to record }
		milliseconds:			UInt32;									{ number of milliseconds to record }
		bufferLength:			UInt32;									{ length of buffer in bytes }
		bufferPtr:				Ptr;									{ buffer to store sound data in }
		completionRoutine:		SICompletionUPP;						{ completion routine }
		interruptRoutine:		SIInterruptUPP;							{ interrupt routine }
		userLong:				LONGINT;								{ user-defined field }
		error:					OSErr;									{ error }
		unused1:				LONGINT;								{ reserved - must be zero }
	END;

{
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   prototypes
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}

{
   These two routines for Get/SetSoundVol should no longer be used.
   They were for old Apple Sound Chip machines, and do not support the DSP or PowerMacs.
   Use Get/SetDefaultOutputVolume instead, if you must change the user's machine.
}

{$IFC TARGET_CPU_68K }
PROCEDURE SetSoundVol(level: INTEGER);

PROCEDURE GetSoundVol(VAR level: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4218, $10B8, $0260;
	{$ENDC}
{$ENDC}  {TARGET_CPU_68K}

{ Sound Manager routines }
PROCEDURE SysBeep(duration: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C8;
	{$ENDC}
FUNCTION SndDoCommand(chan: SndChannelPtr; {CONST}VAR cmd: SndCommand; noWait: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A803;
	{$ENDC}
FUNCTION SndDoImmediate(chan: SndChannelPtr; {CONST}VAR cmd: SndCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A804;
	{$ENDC}
FUNCTION SndNewChannel(VAR chan: SndChannelPtr; synth: INTEGER; init: LONGINT; userRoutine: SndCallBackUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A807;
	{$ENDC}
FUNCTION SndDisposeChannel(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A801;
	{$ENDC}
FUNCTION SndPlay(chan: SndChannelPtr; sndHandle: SndListHandle; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A805;
	{$ENDC}
{$IFC OLDROUTINENAMES }
FUNCTION SndAddModifier(chan: SndChannelPtr; modifier: Ptr; id: INTEGER; init: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A802;
	{$ENDC}
{$ENDC}  {OLDROUTINENAMES}

FUNCTION SndControl(id: INTEGER; VAR cmd: SndCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A806;
	{$ENDC}
{ Sound Manager 2.0 and later, uses _SoundDispatch }
FUNCTION SndSoundManagerVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0008, $A800;
	{$ENDC}
FUNCTION SndStartFilePlay(chan: SndChannelPtr; fRefNum: INTEGER; resNum: INTEGER; bufferSize: LONGINT; theBuffer: UNIV Ptr; theSelection: AudioSelectionPtr; theCompletion: FilePlayCompletionUPP; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0D00, $0008, $A800;
	{$ENDC}
FUNCTION SndPauseFilePlay(chan: SndChannelPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0204, $0008, $A800;
	{$ENDC}
FUNCTION SndStopFilePlay(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0308, $0008, $A800;
	{$ENDC}
FUNCTION SndChannelStatus(chan: SndChannelPtr; theLength: INTEGER; theStatus: SCStatusPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0510, $0008, $A800;
	{$ENDC}
FUNCTION SndManagerStatus(theLength: INTEGER; theStatus: SMStatusPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0314, $0008, $A800;
	{$ENDC}
PROCEDURE SndGetSysBeepState(VAR sysBeepState: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0218, $0008, $A800;
	{$ENDC}
FUNCTION SndSetSysBeepState(sysBeepState: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $011C, $0008, $A800;
	{$ENDC}
FUNCTION SndPlayDoubleBuffer(chan: SndChannelPtr; theParams: SndDoubleBufferHeaderPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0420, $0008, $A800;
	{$ENDC}
{ MACE compression routines, uses _SoundDispatch }
FUNCTION MACEVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0010, $A800;
	{$ENDC}
PROCEDURE Comp3to1(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0010, $A800;
	{$ENDC}
PROCEDURE Exp1to3(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0010, $A800;
	{$ENDC}
PROCEDURE Comp6to1(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0010, $A800;
	{$ENDC}
PROCEDURE Exp1to6(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0010, $A800;
	{$ENDC}
{ Sound Manager 3.0 and later calls, uses _SoundDispatch }
FUNCTION GetSysBeepVolume(VAR level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0224, $0018, $A800;
	{$ENDC}
FUNCTION SetSysBeepVolume(level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0228, $0018, $A800;
	{$ENDC}
FUNCTION GetDefaultOutputVolume(VAR level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $022C, $0018, $A800;
	{$ENDC}
FUNCTION SetDefaultOutputVolume(level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0230, $0018, $A800;
	{$ENDC}
FUNCTION GetSoundHeaderOffset(sndHandle: SndListHandle; VAR offset: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0404, $0018, $A800;
	{$ENDC}
FUNCTION UnsignedFixedMulDiv(value: UnsignedFixed; multiplier: UnsignedFixed; divisor: UnsignedFixed): UnsignedFixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $060C, $0018, $A800;
	{$ENDC}
FUNCTION GetCompressionInfo(compressionID: INTEGER; format: OSType; numChannels: INTEGER; sampleSize: INTEGER; cp: CompressionInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0710, $0018, $A800;
	{$ENDC}
FUNCTION SetSoundPreference(theType: OSType; VAR name: Str255; settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0634, $0018, $A800;
	{$ENDC}
FUNCTION GetSoundPreference(theType: OSType; VAR name: Str255; settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0638, $0018, $A800;
	{$ENDC}
FUNCTION OpenMixerSoundComponent(outputDescription: SoundComponentDataPtr; outputFlags: LONGINT; VAR mixerComponent: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0614, $0018, $A800;
	{$ENDC}
FUNCTION CloseMixerSoundComponent(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0218, $0018, $A800;
	{$ENDC}
{ Sound Manager 3.1 and later calls, uses _SoundDispatch }
FUNCTION SndGetInfo(chan: SndChannelPtr; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $063C, $0018, $A800;
	{$ENDC}
FUNCTION SndSetInfo(chan: SndChannelPtr; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0640, $0018, $A800;
	{$ENDC}
FUNCTION GetSoundOutputInfo(outputDevice: Component; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0644, $0018, $A800;
	{$ENDC}
FUNCTION SetSoundOutputInfo(outputDevice: Component; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0648, $0018, $A800;
	{$ENDC}
{ Sound Manager 3.2 and later calls, uses _SoundDispatch }
FUNCTION GetCompressionName(compressionType: OSType; VAR compressionName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $044C, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterOpen({CONST}VAR inputFormat: SoundComponentData; {CONST}VAR outputFormat: SoundComponentData; VAR sc: SoundConverter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0650, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterClose(sc: SoundConverter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0254, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterGetBufferSizes(sc: SoundConverter; inputBytesTarget: UInt32; VAR inputFrames: UInt32; VAR inputBytes: UInt32; VAR outputBytes: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0A58, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterBeginConversion(sc: SoundConverter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $025C, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterConvertBuffer(sc: SoundConverter; inputPtr: UNIV Ptr; inputFrames: UInt32; outputPtr: UNIV Ptr; VAR outputFrames: UInt32; VAR outputBytes: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0C60, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterEndConversion(sc: SoundConverter; outputPtr: UNIV Ptr; VAR outputFrames: UInt32; VAR outputBytes: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0864, $0018, $A800;
	{$ENDC}
{ Sound Manager 3.3 and later calls, uses _SoundDispatch }
FUNCTION SoundConverterGetInfo(sc: SoundConverter; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0668, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterSetInfo(sc: SoundConverter; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $066C, $0018, $A800;
	{$ENDC}
{
  Sound Component Functions
   basic sound component functions
}

FUNCTION SoundComponentInitOutputDevice(ti: ComponentInstance; actions: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentSetSource(ti: ComponentInstance; sourceID: SoundSource; source: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentGetSource(ti: ComponentInstance; sourceID: SoundSource; VAR source: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentGetSourceData(ti: ComponentInstance; VAR sourceData: SoundComponentDataPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentSetOutput(ti: ComponentInstance; requested: SoundComponentDataPtr; VAR actual: SoundComponentDataPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}
{  junction methods for the mixer, must be called at non-interrupt level }
FUNCTION SoundComponentAddSource(ti: ComponentInstance; VAR sourceID: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentRemoveSource(ti: ComponentInstance; sourceID: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
{  info methods }
FUNCTION SoundComponentGetInfo(ti: ComponentInstance; sourceID: SoundSource; selector: OSType; infoPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentSetInfo(ti: ComponentInstance; sourceID: SoundSource; selector: OSType; infoPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0104, $7000, $A82A;
	{$ENDC}
{  control methods }
FUNCTION SoundComponentStartSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentStopSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentPauseSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentPlaySourceBuffer(ti: ComponentInstance; sourceID: SoundSource; pb: SoundParamBlockPtr; actions: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0108, $7000, $A82A;
	{$ENDC}
{ Audio Components }
{Volume is described as a value between 0 and 1, with 0 indicating minimum
  volume and 1 indicating maximum volume; if the device doesn't support
  software control of volume, then a value of unimpErr is returned, indicating
  that these functions are not supported by the device}
FUNCTION AudioGetVolume(ac: ComponentInstance; whichChannel: INTEGER; VAR volume: ShortFixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetVolume(ac: ComponentInstance; whichChannel: INTEGER; volume: ShortFixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
{If the device doesn't support software control of mute, then a value of unimpErr is
returned, indicating that these functions are not supported by the device.}
FUNCTION AudioGetMute(ac: ComponentInstance; whichChannel: INTEGER; VAR mute: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetMute(ac: ComponentInstance; whichChannel: INTEGER; mute: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
{AudioSetToDefaults causes the associated device to reset its volume and mute values
(and perhaps other characteristics, e.g. attenuation) to "factory default" settings}
FUNCTION AudioSetToDefaults(ac: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}
{ This routine is required; it must be implemented by all audio components }

FUNCTION AudioGetInfo(ac: ComponentInstance; info: AudioInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION AudioGetBass(ac: ComponentInstance; whichChannel: INTEGER; VAR bass: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetBass(ac: ComponentInstance; whichChannel: INTEGER; bass: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION AudioGetTreble(ac: ComponentInstance; whichChannel: INTEGER; VAR Treble: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetTreble(ac: ComponentInstance; whichChannel: INTEGER; Treble: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION AudioGetOutputDevice(ac: ComponentInstance; VAR outputDevice: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

{ This is routine is private to the AudioVision component.  It enables the watching of the mute key. }
FUNCTION AudioMuteOnEvent(ac: ComponentInstance; muteOnEvent: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0081, $7000, $A82A;
	{$ENDC}

CONST
	kDelegatedSoundComponentSelectors = $0100;

{ Sound Input Manager routines, uses _SoundDispatch }
FUNCTION SPBVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0014, $A800;
	{$ENDC}
FUNCTION SndRecord(filterProc: ModalFilterUPP; corner: Point; quality: OSType; VAR sndHandle: SndListHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0804, $0014, $A800;
	{$ENDC}
FUNCTION SndRecordToFile(filterProc: ModalFilterUPP; corner: Point; quality: OSType; fRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0708, $0014, $A800;
	{$ENDC}
FUNCTION SPBSignInDevice(deviceRefNum: INTEGER; deviceName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $030C, $0014, $A800;
	{$ENDC}
FUNCTION SPBSignOutDevice(deviceRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0110, $0014, $A800;
	{$ENDC}
FUNCTION SPBGetIndexedDevice(count: INTEGER; VAR deviceName: Str255; VAR deviceIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0514, $0014, $A800;
	{$ENDC}
FUNCTION SPBOpenDevice(deviceName: Str255; permission: INTEGER; VAR inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0518, $0014, $A800;
	{$ENDC}
FUNCTION SPBCloseDevice(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $021C, $0014, $A800;
	{$ENDC}
FUNCTION SPBRecord(inParamPtr: SPBPtr; asynchFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0320, $0014, $A800;
	{$ENDC}
FUNCTION SPBRecordToFile(fRefNum: INTEGER; inParamPtr: SPBPtr; asynchFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0424, $0014, $A800;
	{$ENDC}
FUNCTION SPBPauseRecording(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0228, $0014, $A800;
	{$ENDC}
FUNCTION SPBResumeRecording(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $022C, $0014, $A800;
	{$ENDC}
FUNCTION SPBStopRecording(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0230, $0014, $A800;
	{$ENDC}
FUNCTION SPBGetRecordingStatus(inRefNum: LONGINT; VAR recordingStatus: INTEGER; VAR meterLevel: INTEGER; VAR totalSamplesToRecord: UInt32; VAR numberOfSamplesRecorded: UInt32; VAR totalMsecsToRecord: UInt32; VAR numberOfMsecsRecorded: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0E34, $0014, $A800;
	{$ENDC}
FUNCTION SPBGetDeviceInfo(inRefNum: LONGINT; infoType: OSType; infoData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0638, $0014, $A800;
	{$ENDC}
FUNCTION SPBSetDeviceInfo(inRefNum: LONGINT; infoType: OSType; infoData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $063C, $0014, $A800;
	{$ENDC}
FUNCTION SPBMillisecondsToBytes(inRefNum: LONGINT; VAR milliseconds: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0440, $0014, $A800;
	{$ENDC}
FUNCTION SPBBytesToMilliseconds(inRefNum: LONGINT; VAR byteCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0444, $0014, $A800;
	{$ENDC}
FUNCTION SetupSndHeader(sndHandle: SndListHandle; numChannels: INTEGER; sampleRate: UnsignedFixed; sampleSize: INTEGER; compressionType: OSType; baseNote: INTEGER; numBytes: UInt32; VAR headerLen: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0D48, $0014, $A800;
	{$ENDC}
FUNCTION SetupAIFFHeader(fRefNum: INTEGER; numChannels: INTEGER; sampleRate: UnsignedFixed; sampleSize: INTEGER; compressionType: OSType; numBytes: UInt32; numFrames: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0B4C, $0014, $A800;
	{$ENDC}
{ Sound Input Manager 1.1 and later calls, uses _SoundDispatch }
FUNCTION ParseAIFFHeader(fRefNum: INTEGER; VAR sndInfo: SoundComponentData; VAR numFrames: UInt32; VAR dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0758, $0014, $A800;
	{$ENDC}
FUNCTION ParseSndHeader(sndHandle: SndListHandle; VAR sndInfo: SoundComponentData; VAR numFrames: UInt32; VAR dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $085C, $0014, $A800;
	{$ENDC}

CONST
	uppSndCallBackProcInfo = $000003C0;
	uppSndDoubleBackProcInfo = $000003C0;
	uppSoundParamProcInfo = $000000D0;
	uppSIInterruptProcInfo = $1C579802;
	uppFilePlayCompletionProcInfo = $000000C0;
	uppSICompletionProcInfo = $000000C0;

FUNCTION NewSndCallBackProc(userRoutine: SndCallBackProcPtr): SndCallBackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSndDoubleBackProc(userRoutine: SndDoubleBackProcPtr): SndDoubleBackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSoundParamProc(userRoutine: SoundParamProcPtr): SoundParamUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSIInterruptProc(userRoutine: SIInterruptProcPtr): SIInterruptUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFilePlayCompletionProc(userRoutine: FilePlayCompletionProcPtr): FilePlayCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSICompletionProc(userRoutine: SICompletionProcPtr): SICompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSndCallBackProc(chan: SndChannelPtr; VAR cmd: SndCommand; userRoutine: SndCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSndDoubleBackProc(channel: SndChannelPtr; doubleBufferPtr: SndDoubleBufferPtr; userRoutine: SndDoubleBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallSoundParamProc(VAR pb: SoundParamBlockPtr; userRoutine: SoundParamUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSIInterruptProc(inParamPtr: SPBPtr; dataBuffer: Ptr; peakAmplitude: INTEGER; sampleSize: LONGINT; userRoutine: SIInterruptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallFilePlayCompletionProc(chan: SndChannelPtr; userRoutine: FilePlayCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSICompletionProc(inParamPtr: SPBPtr; userRoutine: SICompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC NOT TARGET_OS_MAC }
{  Only to be used if you are writing a sound input component; this }
{  is the param block for a read request from the SoundMgr to the   }
{  sound input component.  Not to be confused with the SPB struct   }
{  above, which is the param block for a read request from an app   }
{  to the SoundMgr.                                                 }

TYPE
	SndInputCmpParamPtr = ^SndInputCmpParam;
{$IFC TYPED_FUNCTION_POINTERS}
	SICCompletionProcPtr = PROCEDURE(SICParmPtr: SndInputCmpParamPtr);
{$ELSEC}
	SICCompletionProcPtr = ProcPtr;
{$ENDC}

	SndInputCmpParam = RECORD
		ioCompletion:			SICCompletionProcPtr;					{  completion routine [pointer] }
		ioInterrupt:			SIInterruptProcPtr;						{  interrupt routine [pointer] }
		ioResult:				OSErr;									{  I/O result code [word] }
		pad:					INTEGER;
		ioReqCount:				UInt32;
		ioActCount:				UInt32;
		ioBuffer:				Ptr;
		ioMisc:					Ptr;
	END;

FUNCTION SndInputReadAsync(self: ComponentInstance; SICParmPtr: SndInputCmpParamPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputReadSync(self: ComponentInstance; SICParmPtr: SndInputCmpParamPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputPauseRecording(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputResumeRecording(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputStopRecording(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputGetStatus(self: ComponentInstance; VAR recordingStatus: INTEGER; VAR totalSamplesToRecord: UInt32; VAR numberOfSamplesRecorded: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputGetDeviceInfo(self: ComponentInstance; infoType: OSType; infoData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputSetDeviceInfo(self: ComponentInstance; infoType: OSType; infoData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION SndInputInitHardware(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

CONST
	uppSICCompletionProcInfo = $000000C0;

FUNCTION NewSICCompletionProc(userRoutine: SICCompletionProcPtr): SICCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSICCompletionProc(SICParmPtr: SndInputCmpParamPtr; userRoutine: SICCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundIncludes}

{$ENDC} {__SOUND__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}