/*
 	File:		Sound.h
 
 	Contains:	Sound Manager Interfaces.
 
 	Version:	Technology:	Sound Manager 3.3
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1986-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __SOUND__
#define __SOUND__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

/*
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
		AudioGetBass, AudioGetInfo, AudioGetMute, AudioGetOutputDevice,
		AudioGetTreble, AudioGetVolume, AudioMuteOnEvent, AudioSetBass,
		AudioSetMute, AudioSetToDefaults, AudioSetTreble, AudioSetVolume,
		OpenMixerSoundComponent, CloseMixerSoundComponent, SoundComponentAddSource,
		SoundComponentGetInfo, SoundComponentGetSource, SoundComponentGetSourceData,
		SoundComponentInitOutputDevice, SoundComponentPauseSource,
		SoundComponentPlaySourceBuffer, SoundComponentRemoveSource,
		SoundComponentSetInfo, SoundComponentSetOutput, SoundComponentSetSource,
		SoundComponentStartSource, SoundComponentStopSource
		ParseAIFFHeader(), ParseSndHeader()
*/
/*
	Interfaces for Sound Driver, !!! OBSOLETE and NOT SUPPORTED !!!

	These items are no longer defined, but appear here so that someone
	searching the interfaces might find them. If you are using one of these
	items, you must change your code to support the Sound Manager.

		swMode, ftMode, ffMode
		FreeWave, FFSynthRec, Tone, SWSynthRec, Wave, FTSoundRec
		SndCompletionProcPtr
		StartSound, StopSound, SoundDone
*/
/*
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constants
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
#define twelfthRootTwo 1.05946309435


enum {
	soundListRsrc				= FOUR_CHAR_CODE('snd '),		/*Resource type used by Sound Manager*/
	rate48khz					= (long)0xBB800000,				/*48000.00000 in fixed-point*/
	rate44khz					= (long)0xAC440000,				/*44100.00000 in fixed-point*/
	rate22050hz					= 0x56220000,					/*22050.00000 in fixed-point*/
	rate22khz					= 0x56EE8BA3,					/*22254.54545 in fixed-point*/
	rate11khz					= 0x2B7745D1,					/*11127.27273 in fixed-point*/
	rate11025hz					= 0x2B110000,					/*11025.00000 in fixed-point*/
																/*synthesizer numbers for SndNewChannel*/
	squareWaveSynth				= 1,							/*square wave synthesizer*/
	waveTableSynth				= 3,							/*wave table synthesizer*/
	sampledSynth				= 5,							/*sampled sound synthesizer*/
																/*old Sound Manager MACE synthesizer numbers*/
	MACE3snthID					= 11,
	MACE6snthID					= 13,
	kMiddleC					= 60,							/*MIDI note value for middle C*/
	kSimpleBeepID				= 1,							/*reserved resource ID for Simple Beep*/
	kFullVolume					= 0x0100,						/*1.0, setting for full hardware output volume*/
	kNoVolume					= 0,							/*setting for no sound volume*/
	stdQLength					= 128,
	dataOffsetFlag				= 0x8000,
	kUseOptionalOutputDevice	= -1,							/*only for Sound Manager 3.0 or later*/
	notCompressed				= 0,							/*compression ID's*/
	fixedCompression			= -1,							/*compression ID for fixed-sized compression*/
	variableCompression			= -2,							/*compression ID for variable-sized compression*/
	twoToOne					= 1,
	eightToThree				= 2,
	threeToOne					= 3,
	sixToOne					= 4,
	sixToOnePacketSize			= 8,
	threeToOnePacketSize		= 16,
	stateBlockSize				= 64,
	leftOverBlockSize			= 32,
	firstSoundFormat			= 0x0001,						/*general sound format*/
	secondSoundFormat			= 0x0002,						/*special sampled sound format (HyperCard)*/
	dbBufferReady				= 0x00000001,					/*double buffer is filled*/
	dbLastBuffer				= 0x00000004,					/*last double buffer to play*/
	sysBeepDisable				= 0x0000,						/*SysBeep() enable flags*/
	sysBeepEnable				= (1 << 0),
	sysBeepSynchronous			= (1 << 1),						/*if bit set, make alert sounds synchronous*/
	unitTypeNoSelection			= 0xFFFF,						/*unitTypes for AudioSelection.unitType*/
	unitTypeSeconds				= 0x0000
};


enum {
	stdSH						= 0x00,							/*Standard sound header encode value*/
	extSH						= 0xFF,							/*Extended sound header encode value*/
	cmpSH						= 0xFE							/*Compressed sound header encode value*/
};

/*command numbers for SndDoCommand and SndDoImmediate*/

enum {
	nullCmd						= 0,
	initCmd						= 1,
	freeCmd						= 2,
	quietCmd					= 3,
	flushCmd					= 4,
	reInitCmd					= 5,
	waitCmd						= 10,
	pauseCmd					= 11,
	resumeCmd					= 12,
	callBackCmd					= 13,
	syncCmd						= 14,
	availableCmd				= 24,
	versionCmd					= 25,
	totalLoadCmd				= 26,
	loadCmd						= 27,
	freqDurationCmd				= 40,
	restCmd						= 41,
	freqCmd						= 42,
	ampCmd						= 43,
	timbreCmd					= 44,
	getAmpCmd					= 45,
	volumeCmd					= 46,							/*sound manager 3.0 or later only*/
	getVolumeCmd				= 47,							/*sound manager 3.0 or later only*/
	clockComponentCmd			= 50,							/*sound manager 3.2.1 or later only*/
	getClockComponentCmd		= 51,							/*sound manager 3.2.1 or later only*/
	waveTableCmd				= 60,
	phaseCmd					= 61,
	soundCmd					= 80,
	bufferCmd					= 81,
	rateCmd						= 82,
	continueCmd					= 83,
	doubleBufferCmd				= 84,
	getRateCmd					= 85,
	rateMultiplierCmd			= 86,
	getRateMultiplierCmd		= 87,
	sizeCmd						= 90,							/*obsolete command*/
	convertCmd					= 91							/*obsolete MACE command*/
};

#if OLDROUTINENAMES
/*channel initialization parameters*/

enum {
	waveInitChannelMask			= 0x07,
	waveInitChannel0			= 0x04,							/*wave table only, Sound Manager 2.0 and earlier*/
	waveInitChannel1			= 0x05,							/*wave table only, Sound Manager 2.0 and earlier*/
	waveInitChannel2			= 0x06,							/*wave table only, Sound Manager 2.0 and earlier*/
	waveInitChannel3			= 0x07,							/*wave table only, Sound Manager 2.0 and earlier*/
	initChan0					= waveInitChannel0,				/*obsolete spelling*/
	initChan1					= waveInitChannel1,				/*obsolete spelling*/
	initChan2					= waveInitChannel2,				/*obsolete spelling*/
	initChan3					= waveInitChannel3				/*obsolete spelling*/
};


enum {
	outsideCmpSH				= 0,							/*obsolete MACE constant*/
	insideCmpSH					= 1,							/*obsolete MACE constant*/
	aceSuccess					= 0,							/*obsolete MACE constant*/
	aceMemFull					= 1,							/*obsolete MACE constant*/
	aceNilBlock					= 2,							/*obsolete MACE constant*/
	aceBadComp					= 3,							/*obsolete MACE constant*/
	aceBadEncode				= 4,							/*obsolete MACE constant*/
	aceBadDest					= 5,							/*obsolete MACE constant*/
	aceBadCmd					= 6								/*obsolete MACE constant*/
};

#endif  /* OLDROUTINENAMES */


enum {
	initChanLeft				= 0x0002,						/*left stereo channel*/
	initChanRight				= 0x0003,						/*right stereo channel*/
	initNoInterp				= 0x0004,						/*no linear interpolation*/
	initNoDrop					= 0x0008,						/*no drop-sample conversion*/
	initMono					= 0x0080,						/*monophonic channel*/
	initStereo					= 0x00C0,						/*stereo channel*/
	initMACE3					= 0x0300,						/*MACE 3:1*/
	initMACE6					= 0x0400,						/*MACE 6:1*/
	initPanMask					= 0x0003,						/*mask for right/left pan values*/
	initSRateMask				= 0x0030,						/*mask for sample rate values*/
	initStereoMask				= 0x00C0,						/*mask for mono/stereo values*/
	initCompMask				= 0xFF00						/*mask for compression IDs*/
};

/*Get&Set Sound Information Selectors*/

enum {
	siActiveChannels			= FOUR_CHAR_CODE('chac'),		/*active channels*/
	siActiveLevels				= FOUR_CHAR_CODE('lmac'),		/*active meter levels*/
	siAGCOnOff					= FOUR_CHAR_CODE('agc '),		/*automatic gain control state*/
	siAsync						= FOUR_CHAR_CODE('asyn'),		/*asynchronous capability*/
	siAVDisplayBehavior			= FOUR_CHAR_CODE('avdb'),
	siChannelAvailable			= FOUR_CHAR_CODE('chav'),		/*number of channels available*/
	siCompressionAvailable		= FOUR_CHAR_CODE('cmav'),		/*compression types available*/
	siCompressionFactor			= FOUR_CHAR_CODE('cmfa'),		/*current compression factor*/
	siCompressionHeader			= FOUR_CHAR_CODE('cmhd'),		/*return compression header*/
	siCompressionNames			= FOUR_CHAR_CODE('cnam'),		/*compression type names available*/
	siCompressionParams			= FOUR_CHAR_CODE('cmpp'),		/*compression parameters*/
	siCompressionType			= FOUR_CHAR_CODE('comp'),		/*current compression type*/
	siContinuous				= FOUR_CHAR_CODE('cont'),		/*continous recording*/
	siDeviceBufferInfo			= FOUR_CHAR_CODE('dbin'),		/*size of interrupt buffer*/
	siDeviceConnected			= FOUR_CHAR_CODE('dcon'),		/*input device connection status*/
	siDeviceIcon				= FOUR_CHAR_CODE('icon'),		/*input device icon*/
	siDeviceName				= FOUR_CHAR_CODE('name'),		/*input device name*/
	siHardwareBalance			= FOUR_CHAR_CODE('hbal'),
	siHardwareBalanceSteps		= FOUR_CHAR_CODE('hbls'),
	siHardwareBass				= FOUR_CHAR_CODE('hbas'),
	siHardwareBassSteps			= FOUR_CHAR_CODE('hbst'),
	siHardwareBusy				= FOUR_CHAR_CODE('hwbs'),		/*sound hardware is in use*/
	siHardwareFormat			= FOUR_CHAR_CODE('hwfm'),		/*get hardware format*/
	siHardwareMute				= FOUR_CHAR_CODE('hmut'),		/*mute state of all hardware*/
	siHardwareTreble			= FOUR_CHAR_CODE('htrb'),
	siHardwareTrebleSteps		= FOUR_CHAR_CODE('hwts'),
	siHardwareVolume			= FOUR_CHAR_CODE('hvol'),		/*volume level of all hardware*/
	siHardwareVolumeSteps		= FOUR_CHAR_CODE('hstp'),		/*number of volume steps for hardware*/
	siHeadphoneMute				= FOUR_CHAR_CODE('pmut'),		/*mute state of headphones*/
	siHeadphoneVolume			= FOUR_CHAR_CODE('pvol'),		/*volume level of headphones*/
	siHeadphoneVolumeSteps		= FOUR_CHAR_CODE('hdst'),		/*number of volume steps for headphones*/
	siInputAvailable			= FOUR_CHAR_CODE('inav'),		/*input sources available*/
	siInputGain					= FOUR_CHAR_CODE('gain'),		/*input gain*/
	siInputSource				= FOUR_CHAR_CODE('sour'),		/*input source selector*/
	siInputSourceNames			= FOUR_CHAR_CODE('snam'),		/*input source names*/
	siLevelMeterOnOff			= FOUR_CHAR_CODE('lmet'),		/*level meter state*/
	siModemGain					= FOUR_CHAR_CODE('mgai'),		/*modem input gain*/
	siMonitorAvailable			= FOUR_CHAR_CODE('mnav'),
	siMonitorSource				= FOUR_CHAR_CODE('mons'),
	siNumberChannels			= FOUR_CHAR_CODE('chan'),		/*current number of channels*/
	siOptionsDialog				= FOUR_CHAR_CODE('optd'),		/*display options dialog*/
	siPlayThruOnOff				= FOUR_CHAR_CODE('plth'),		/*playthrough state*/
	siPostMixerSoundComponent	= FOUR_CHAR_CODE('psmx'),		/*install post-mixer effect*/
	siPreMixerSoundComponent	= FOUR_CHAR_CODE('prmx'),		/*install pre-mixer effect*/
	siQuality					= FOUR_CHAR_CODE('qual'),		/*quality setting*/
	siRateMultiplier			= FOUR_CHAR_CODE('rmul'),		/*throttle rate setting*/
	siRecordingQuality			= FOUR_CHAR_CODE('qual'),		/*recording quality*/
	siSampleRate				= FOUR_CHAR_CODE('srat'),		/*current sample rate*/
	siSampleRateAvailable		= FOUR_CHAR_CODE('srav'),		/*sample rates available*/
	siSampleSize				= FOUR_CHAR_CODE('ssiz'),		/*current sample size*/
	siSampleSizeAvailable		= FOUR_CHAR_CODE('ssav'),		/*sample sizes available*/
	siSetupCDAudio				= FOUR_CHAR_CODE('sucd'),		/*setup sound hardware for CD audio*/
	siSetupModemAudio			= FOUR_CHAR_CODE('sumd'),		/*setup sound hardware for modem audio*/
	siSlopeAndIntercept			= FOUR_CHAR_CODE('flap'),		/*floating point variables for conversion*/
	siSoundClock				= FOUR_CHAR_CODE('sclk'),
	siSpeakerMute				= FOUR_CHAR_CODE('smut'),		/*mute state of all built-in speaker*/
	siSpeakerVolume				= FOUR_CHAR_CODE('svol'),		/*volume level of built-in speaker*/
	siSSpCPULoadLimit			= FOUR_CHAR_CODE('3dll'),
	siSSpLocalization			= FOUR_CHAR_CODE('3dif'),
	siSSpSpeakerSetup			= FOUR_CHAR_CODE('3dst'),
	siStereoInputGain			= FOUR_CHAR_CODE('sgai'),		/*stereo input gain*/
	siSubwooferMute				= FOUR_CHAR_CODE('bmut'),		/*mute state of sub-woofer*/
	siTwosComplementOnOff		= FOUR_CHAR_CODE('twos'),		/*two's complement state*/
	siVolume					= FOUR_CHAR_CODE('volu'),		/*volume level of source*/
	siVoxRecordInfo				= FOUR_CHAR_CODE('voxr'),		/*VOX record parameters*/
	siVoxStopInfo				= FOUR_CHAR_CODE('voxs'),		/*VOX stop parameters*/
	siWideStereo				= FOUR_CHAR_CODE('wide')		/*wide stereo setting*/
};


enum {
	siCloseDriver				= FOUR_CHAR_CODE('clos'),		/*reserved for internal use only*/
	siInitializeDriver			= FOUR_CHAR_CODE('init'),		/*reserved for internal use only*/
	siPauseRecording			= FOUR_CHAR_CODE('paus'),		/*reserved for internal use only*/
	siUserInterruptProc			= FOUR_CHAR_CODE('user')		/*reserved for internal use only*/
};

/*Sound Component Types and Subtypes*/

enum {
	kNoSoundComponentType		= FOUR_CHAR_CODE('****'),
	kSoundComponentType			= FOUR_CHAR_CODE('sift'),		/*component type*/
	kSoundComponentPPCType		= FOUR_CHAR_CODE('nift'),		/*component type for PowerPC code*/
	kRate8SubType				= FOUR_CHAR_CODE('ratb'),		/*8-bit rate converter*/
	kRate16SubType				= FOUR_CHAR_CODE('ratw'),		/*16-bit rate converter*/
	kConverterSubType			= FOUR_CHAR_CODE('conv'),		/*sample format converter*/
	kSndSourceSubType			= FOUR_CHAR_CODE('sour'),		/*generic source component*/
	kMixerType					= FOUR_CHAR_CODE('mixr'),
	kMixer8SubType				= FOUR_CHAR_CODE('mixb'),		/*8-bit mixer*/
	kMixer16SubType				= FOUR_CHAR_CODE('mixw'),		/*16-bit mixer*/
	kSoundOutputDeviceType		= FOUR_CHAR_CODE('sdev'),		/*sound output component*/
	kClassicSubType				= FOUR_CHAR_CODE('clas'),		/*classic hardware, i.e. Mac Plus*/
	kASCSubType					= FOUR_CHAR_CODE('asc '),		/*Apple Sound Chip device*/
	kDSPSubType					= FOUR_CHAR_CODE('dsp '),		/*DSP device*/
	kAwacsSubType				= FOUR_CHAR_CODE('awac'),		/*Another of Will's Audio Chips device*/
	kGCAwacsSubType				= FOUR_CHAR_CODE('awgc'),		/*Awacs audio with Grand Central DMA*/
	kSingerSubType				= FOUR_CHAR_CODE('sing'),		/*Singer (via Whitney) based sound*/
	kSinger2SubType				= FOUR_CHAR_CODE('sng2'),		/*Singer 2 (via Whitney) for Acme*/
	kWhitSubType				= FOUR_CHAR_CODE('whit'),		/*Whit sound component for PrimeTime 3*/
	kSoundBlasterSubType		= FOUR_CHAR_CODE('sbls'),		/*Sound Blaster for CHRP*/
	kSoundCompressor			= FOUR_CHAR_CODE('scom'),
	kSoundDecompressor			= FOUR_CHAR_CODE('sdec'),
	kSoundEffectsType			= FOUR_CHAR_CODE('snfx'),		/*sound effects type*/
	kSSpLocalizationSubType		= FOUR_CHAR_CODE('snd3')
};

/*Format Types*/

enum {
	kSoundNotCompressed			= FOUR_CHAR_CODE('NONE'),		/*sound is not compressed*/
	kOffsetBinary				= FOUR_CHAR_CODE('raw '),		/*offset binary*/
	kMACE3Compression			= FOUR_CHAR_CODE('MAC3'),		/*MACE 3:1*/
	kMACE6Compression			= FOUR_CHAR_CODE('MAC6'),		/*MACE 6:1*/
	kCDXA4Compression			= FOUR_CHAR_CODE('cdx4'),		/*CD/XA 4:1*/
	kCDXA2Compression			= FOUR_CHAR_CODE('cdx2'),		/*CD/XA 2:1*/
	kIMACompression				= FOUR_CHAR_CODE('ima4'),		/*IMA 4:1*/
	kULawCompression			= FOUR_CHAR_CODE('ulaw'),		/*µLaw 2:1*/
	kALawCompression			= FOUR_CHAR_CODE('alaw'),		/*aLaw 2:1*/
	kLittleEndianFormat			= FOUR_CHAR_CODE('sowt'),		/*Little-endian*/
	kFloat32Format				= FOUR_CHAR_CODE('fl32'),		/*32-bit floating point*/
	kFloat64Format				= FOUR_CHAR_CODE('fl64'),		/*64-bit floating point*/
	kTwosComplement				= FOUR_CHAR_CODE('twos')		/*old name for compatibility*/
};

/*Features Flags*/

enum {
	k8BitRawIn					= (1 << 0),						/*data description*/
	k8BitTwosIn					= (1 << 1),
	k16BitIn					= (1 << 2),
	kStereoIn					= (1 << 3),
	k8BitRawOut					= (1 << 8),
	k8BitTwosOut				= (1 << 9),
	k16BitOut					= (1 << 10),
	kStereoOut					= (1 << 11),
	kReverse					= (1L << 16),					/*  function description*/
	kRateConvert				= (1L << 17),
	kCreateSoundSource			= (1L << 18),
	kHighQuality				= (1L << 22),					/*  performance description*/
	kNonRealTime				= (1L << 23)
};

/*SoundComponentPlaySourceBuffer action flags*/

enum {
	kSourcePaused				= (1 << 0),
	kPassThrough				= (1L << 16),
	kNoSoundComponentChain		= (1L << 17)
};

/*SoundParamBlock flags, usefull for OpenMixerSoundComponent*/

enum {
	kNoMixing					= (1 << 0),						/*don't mix source*/
	kNoSampleRateConversion		= (1 << 1),						/*don't convert sample rate (i.e. 11 kHz -> 22 kHz)*/
	kNoSampleSizeConversion		= (1 << 2),						/*don't convert sample size (i.e. 16 -> 8)*/
	kNoSampleFormatConversion	= (1 << 3),						/*don't convert sample format (i.e. 'twos' -> 'raw ')*/
	kNoChannelConversion		= (1 << 4),						/*don't convert stereo/mono*/
	kNoDecompression			= (1 << 5),						/*don't decompress (i.e. 'MAC3' -> 'raw ')*/
	kNoVolumeConversion			= (1 << 6),						/*don't apply volume*/
	kNoRealtimeProcessing		= (1 << 7),						/*won't run at interrupt time*/
	kScheduledSource			= (1 << 8)						/*source is scheduled*/
};

/*SoundParamBlock quality settings*/

enum {
	kBestQuality				= (1 << 0)						/*use interpolation in rate conversion*/
};

/*useful bit masks*/

enum {
	kInputMask					= 0x000000FF,					/*masks off input bits*/
	kOutputMask					= 0x0000FF00,					/*masks off output bits*/
	kOutputShift				= 8,							/*amount output bits are shifted*/
	kActionMask					= 0x00FF0000,					/*masks off action bits*/
	kSoundComponentBits			= 0x00FFFFFF
};

/*siAVDisplayBehavior types*/

enum {
	kAVDisplayHeadphoneRemove	= 0,							/* monitor does not have a headphone attached*/
	kAVDisplayHeadphoneInsert	= 1,							/* monitor has a headphone attached*/
	kAVDisplayPlainTalkRemove	= 2,							/* monitor either sending no input through CPU input port or unable to tell if input is coming in*/
	kAVDisplayPlainTalkInsert	= 3								/* monitor sending PlainTalk level microphone source input through sound input port*/
};

/*Audio Component constants*/

enum {
																/*Values for whichChannel parameter*/
	audioAllChannels			= 0,							/*All channels (usually interpreted as both left and right)*/
	audioLeftChannel			= 1,							/*Left channel*/
	audioRightChannel			= 2,							/*Right channel*/
																/*Values for mute parameter*/
	audioUnmuted				= 0,							/*Device is unmuted*/
	audioMuted					= 1,							/*Device is muted*/
																/*Capabilities flags definitions*/
	audioDoesMono				= (1L << 0),					/*Device supports mono output*/
	audioDoesStereo				= (1L << 1),					/*Device supports stereo output*/
	audioDoesIndependentChannels = (1L << 2)					/*Device supports independent software control of each channel*/
};

/*Sound Input Qualities*/

enum {
	siCDQuality					= FOUR_CHAR_CODE('cd  '),		/*44.1kHz, stereo, 16 bit*/
	siBestQuality				= FOUR_CHAR_CODE('best'),		/*22kHz, mono, 8 bit*/
	siBetterQuality				= FOUR_CHAR_CODE('betr'),		/*22kHz, mono, MACE 3:1*/
	siGoodQuality				= FOUR_CHAR_CODE('good')		/*22kHz, mono, MACE 6:1*/
};


enum {
	siDeviceIsConnected			= 1,							/*input device is connected and ready for input*/
	siDeviceNotConnected		= 0,							/*input device is not connected*/
	siDontKnowIfConnected		= -1,							/*can't tell if input device is connected*/
	siReadPermission			= 0,							/*permission passed to SPBOpenDevice*/
	siWritePermission			= 1								/*permission passed to SPBOpenDevice*/
};

/*
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   typedefs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

struct SndCommand {
	unsigned short 					cmd;
	short 							param1;
	long 							param2;
};
typedef struct SndCommand SndCommand;

typedef struct SndChannel 				SndChannel;
typedef SndChannel *					SndChannelPtr;
typedef CALLBACK_API( void , SndCallBackProcPtr )(SndChannelPtr chan, SndCommand *cmd);
typedef STACK_UPP_TYPE(SndCallBackProcPtr) 						SndCallBackUPP;


struct SndChannel {
	SndChannelPtr 					nextChan;
	Ptr 							firstMod;					/* reserved for the Sound Manager */
	SndCallBackUPP 					callBack;
	long 							userInfo;
	long 							wait;						/* The following is for internal Sound Manager use only.*/
	SndCommand 						cmdInProgress;
	short 							flags;
	short 							qLength;
	short 							qHead;
	short 							qTail;
	SndCommand 						queue[128];
};

/*MACE structures*/
struct StateBlock {
	short 							stateVar[64];
};
typedef struct StateBlock StateBlock;

typedef StateBlock *					StateBlockPtr;
struct LeftOverBlock {
	unsigned long 					count;
	SInt8 							sampleArea[32];
};
typedef struct LeftOverBlock LeftOverBlock;

typedef LeftOverBlock *					LeftOverBlockPtr;
struct ModRef {
	unsigned short 					modNumber;
	long 							modInit;
};
typedef struct ModRef ModRef;

struct SndListResource {
	short 							format;
	short 							numModifiers;
	ModRef 							modifierPart[1];
	short 							numCommands;
	SndCommand 						commandPart[1];
	UInt8 							dataPart[1];
};
typedef struct SndListResource SndListResource;

typedef SndListResource *				SndListPtr;
typedef SndListPtr *					SndListHndl;
typedef SndListPtr *					SndListHandle;
/*HyperCard sound resource format*/
struct Snd2ListResource {
	short 							format;
	short 							refCount;
	short 							numCommands;
	SndCommand 						commandPart[1];
	UInt8 							dataPart[1];
};
typedef struct Snd2ListResource Snd2ListResource;

typedef Snd2ListResource *				Snd2ListPtr;
typedef Snd2ListPtr *					Snd2ListHndl;
typedef Snd2ListPtr *					Snd2ListHandle;
struct SoundHeader {
	Ptr 							samplePtr;					/*if NIL then samples are in sampleArea*/
	unsigned long 					length;						/*length of sound in bytes*/
	UnsignedFixed 					sampleRate;					/*sample rate for this sound*/
	unsigned long 					loopStart;					/*start of looping portion*/
	unsigned long 					loopEnd;					/*end of looping portion*/
	UInt8 							encode;						/*header encoding*/
	UInt8 							baseFrequency;				/*baseFrequency value*/
	UInt8 							sampleArea[1];				/*space for when samples follow directly*/
};
typedef struct SoundHeader SoundHeader;

typedef SoundHeader *					SoundHeaderPtr;
struct CmpSoundHeader {
	Ptr 							samplePtr;					/*if nil then samples are in sample area*/
	unsigned long 					numChannels;				/*number of channels i.e. mono = 1*/
	UnsignedFixed 					sampleRate;					/*sample rate in Apples Fixed point representation*/
	unsigned long 					loopStart;					/*loopStart of sound before compression*/
	unsigned long 					loopEnd;					/*loopEnd of sound before compression*/
	UInt8 							encode;						/*data structure used , stdSH, extSH, or cmpSH*/
	UInt8 							baseFrequency;				/*same meaning as regular SoundHeader*/
	unsigned long 					numFrames;					/*length in frames ( packetFrames or sampleFrames )*/
	extended80 						AIFFSampleRate;				/*IEEE sample rate*/
	Ptr 							markerChunk;				/*sync track*/
	OSType 							format;						/*data format type, was futureUse1*/
	unsigned long 					futureUse2;					/*reserved by Apple*/
	StateBlockPtr 					stateVars;					/*pointer to State Block*/
	LeftOverBlockPtr 				leftOverSamples;			/*used to save truncated samples between compression calls*/
	short 							compressionID;				/*0 means no compression, non zero means compressionID*/
	unsigned short 					packetSize;					/*number of bits in compressed sample packet*/
	unsigned short 					snthID;						/*resource ID of Sound Manager snth that contains NRT C/E*/
	unsigned short 					sampleSize;					/*number of bits in non-compressed sample*/
	UInt8 							sampleArea[1];				/*space for when samples follow directly*/
};
typedef struct CmpSoundHeader CmpSoundHeader;

typedef CmpSoundHeader *				CmpSoundHeaderPtr;
struct ExtSoundHeader {
	Ptr 							samplePtr;					/*if nil then samples are in sample area*/
	unsigned long 					numChannels;				/*number of channels,  ie mono = 1*/
	UnsignedFixed 					sampleRate;					/*sample rate in Apples Fixed point representation*/
	unsigned long 					loopStart;					/*same meaning as regular SoundHeader*/
	unsigned long 					loopEnd;					/*same meaning as regular SoundHeader*/
	UInt8 							encode;						/*data structure used , stdSH, extSH, or cmpSH*/
	UInt8 							baseFrequency;				/*same meaning as regular SoundHeader*/
	unsigned long 					numFrames;					/*length in total number of frames*/
	extended80 						AIFFSampleRate;				/*IEEE sample rate*/
	Ptr 							markerChunk;				/*sync track*/
	Ptr 							instrumentChunks;			/*AIFF instrument chunks*/
	Ptr 							AESRecording;
	unsigned short 					sampleSize;					/*number of bits in sample*/
	unsigned short 					futureUse1;					/*reserved by Apple*/
	unsigned long 					futureUse2;					/*reserved by Apple*/
	unsigned long 					futureUse3;					/*reserved by Apple*/
	unsigned long 					futureUse4;					/*reserved by Apple*/
	UInt8 							sampleArea[1];				/*space for when samples follow directly*/
};
typedef struct ExtSoundHeader ExtSoundHeader;

typedef ExtSoundHeader *				ExtSoundHeaderPtr;
union SoundHeaderUnion {
	SoundHeader 					stdHeader;
	CmpSoundHeader 					cmpHeader;
	ExtSoundHeader 					extHeader;
};
typedef union SoundHeaderUnion SoundHeaderUnion;

struct ConversionBlock {
	short 							destination;
	short 							unused;
	CmpSoundHeaderPtr 				inputPtr;
	CmpSoundHeaderPtr 				outputPtr;
};
typedef struct ConversionBlock ConversionBlock;

typedef ConversionBlock *				ConversionBlockPtr;
struct SMStatus {
	short 							smMaxCPULoad;
	short 							smNumChannels;
	short 							smCurCPULoad;
};
typedef struct SMStatus SMStatus;

typedef SMStatus *						SMStatusPtr;
struct SCStatus {
	UnsignedFixed 					scStartTime;
	UnsignedFixed 					scEndTime;
	UnsignedFixed 					scCurrentTime;
	Boolean 						scChannelBusy;
	Boolean 						scChannelDisposed;
	Boolean 						scChannelPaused;
	Boolean 						scUnused;
	unsigned long 					scChannelAttributes;
	long 							scCPULoad;
};
typedef struct SCStatus SCStatus;

typedef SCStatus *						SCStatusPtr;
struct AudioSelection {
	long 							unitType;
	UnsignedFixed 					selStart;
	UnsignedFixed 					selEnd;
};
typedef struct AudioSelection AudioSelection;

typedef AudioSelection *				AudioSelectionPtr;
struct SndDoubleBuffer {
	long 							dbNumFrames;
	long 							dbFlags;
	long 							dbUserInfo[2];
	SInt8 							dbSoundData[1];
};
typedef struct SndDoubleBuffer SndDoubleBuffer;

typedef SndDoubleBuffer *				SndDoubleBufferPtr;


typedef CALLBACK_API( void , SndDoubleBackProcPtr )(SndChannelPtr channel, SndDoubleBufferPtr doubleBufferPtr);
typedef STACK_UPP_TYPE(SndDoubleBackProcPtr) 					SndDoubleBackUPP;


struct SndDoubleBufferHeader {
	short 							dbhNumChannels;
	short 							dbhSampleSize;
	short 							dbhCompressionID;
	short 							dbhPacketSize;
	UnsignedFixed 					dbhSampleRate;
	SndDoubleBufferPtr 				dbhBufferPtr[2];
	SndDoubleBackUPP 				dbhDoubleBack;
};
typedef struct SndDoubleBufferHeader SndDoubleBufferHeader;

typedef SndDoubleBufferHeader *			SndDoubleBufferHeaderPtr;
struct SndDoubleBufferHeader2 {
	short 							dbhNumChannels;
	short 							dbhSampleSize;
	short 							dbhCompressionID;
	short 							dbhPacketSize;
	UnsignedFixed 					dbhSampleRate;
	SndDoubleBufferPtr 				dbhBufferPtr[2];
	SndDoubleBackUPP 				dbhDoubleBack;
	OSType 							dbhFormat;
};
typedef struct SndDoubleBufferHeader2 SndDoubleBufferHeader2;

typedef SndDoubleBufferHeader2 *		SndDoubleBufferHeader2Ptr;
struct SoundInfoList {
	short 							count;
	Handle 							infoHandle;
};
typedef struct SoundInfoList SoundInfoList;

typedef SoundInfoList *					SoundInfoListPtr;
struct SoundComponentData {
	long 							flags;
	OSType 							format;
	short 							numChannels;
	short 							sampleSize;
	UnsignedFixed 					sampleRate;
	long 							sampleCount;
	Byte *							buffer;
	long 							reserved;
};
typedef struct SoundComponentData SoundComponentData;

typedef SoundComponentData *			SoundComponentDataPtr;
typedef struct SoundParamBlock 			SoundParamBlock;
typedef SoundParamBlock *				SoundParamBlockPtr;
typedef CALLBACK_API( Boolean , SoundParamProcPtr )(SoundParamBlockPtr *pb);
typedef STACK_UPP_TYPE(SoundParamProcPtr) 						SoundParamUPP;
struct SoundParamBlock {
	long 							recordSize;					/*size of this record in bytes*/
	SoundComponentData 				desc;						/*description of sound buffer*/
	UnsignedFixed 					rateMultiplier;				/*rate multiplier to apply to sound*/
	short 							leftVolume;					/*volumes to apply to sound*/
	short 							rightVolume;
	long 							quality;					/*quality to apply to sound*/
	ComponentInstance 				filter;						/*filter to apply to sound*/
	SoundParamUPP 					moreRtn;					/*routine to call to get more data*/
	SoundParamUPP 					completionRtn;				/*routine to call when buffer is complete*/
	long 							refCon;						/*user refcon*/
	short 							result;						/*result*/
};

struct CompressionInfo {
	long 							recordSize;
	OSType 							format;
	short 							compressionID;
	unsigned short 					samplesPerPacket;
	unsigned short 					bytesPerPacket;
	unsigned short 					bytesPerFrame;
	unsigned short 					bytesPerSample;
	unsigned short 					futureUse1;
};
typedef struct CompressionInfo CompressionInfo;

typedef CompressionInfo *				CompressionInfoPtr;
typedef CompressionInfoPtr *			CompressionInfoHandle;
/*private thing to use as a reference to a Sound Converter*/
typedef struct OpaqueSoundConverter* 	SoundConverter;
/*private thing to use as a reference to a Sound Source*/
typedef struct OpaqueSoundSource* 		SoundSource;
typedef SoundSource *					SoundSourcePtr;


struct SoundComponentLink {
	ComponentDescription 			description;				/*Describes the sound component*/
	SoundSource 					mixerID;					/*Reserved by Apple*/
	SoundSource *					linkID;						/*Reserved by Apple*/
};
typedef struct SoundComponentLink SoundComponentLink;

typedef SoundComponentLink *			SoundComponentLinkPtr;
struct AudioInfo {
	long 							capabilitiesFlags;			/*Describes device capabilities*/
	long 							reserved;					/*Reserved by Apple*/
	unsigned short 					numVolumeSteps;				/*Number of significant increments between min and max volume*/
};
typedef struct AudioInfo AudioInfo;

typedef AudioInfo *						AudioInfoPtr;



/*
   These two routines for Get/SetSoundVol should no longer be used.
   They were for old Apple Sound Chip machines, and do not support the DSP or PowerMacs.
   Use Get/SetDefaultOutputVolume instead, if you must change the user's machine.
*/

#if OLDROUTINENAMES && TARGET_CPU_68K
EXTERN_API( void )
SetSoundVol						(short 					level);


																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter GetSoundVol(__A0)
																							#endif
EXTERN_API( void )
GetSoundVol						(short *				level)								THREEWORDINLINE(0x4218, 0x10B8, 0x0260);

#endif  /* OLDROUTINENAMES && TARGET_CPU_68K */



/* Sound Input Structures*/
typedef struct SPB 						SPB;
typedef SPB *							SPBPtr;


/*user procedures called by sound input routines*/
typedef CALLBACK_API( void , SIInterruptProcPtr )(SPBPtr inParamPtr, Ptr dataBuffer, short peakAmplitude, long sampleSize);
/*
	WARNING: SIInterruptProcPtr uses register based parameters under classic 68k
			 and cannot be written in a high-level language without 
			 the help of mixed mode or assembly glue.
*/
typedef CALLBACK_API( void , FilePlayCompletionProcPtr )(SndChannelPtr chan);
typedef CALLBACK_API( void , SICompletionProcPtr )(SPBPtr inParamPtr);
typedef REGISTER_UPP_TYPE(SIInterruptProcPtr) 					SIInterruptUPP;
typedef STACK_UPP_TYPE(FilePlayCompletionProcPtr) 				FilePlayCompletionUPP;
typedef STACK_UPP_TYPE(SICompletionProcPtr) 					SICompletionUPP;


/*Sound Input Parameter Block*/
struct SPB {
	long 							inRefNum;					/*reference number of sound input device*/
	unsigned long 					count;						/*number of bytes to record*/
	unsigned long 					milliseconds;				/*number of milliseconds to record*/
	unsigned long 					bufferLength;				/*length of buffer in bytes*/
	Ptr 							bufferPtr;					/*buffer to store sound data in*/
	SICompletionUPP 				completionRoutine;			/*completion routine*/
	SIInterruptUPP 					interruptRoutine;			/*interrupt routine*/
	long 							userLong;					/*user-defined field*/
	OSErr 							error;						/*error*/
	long 							unused1;					/*reserved - must be zero*/
};

/*
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   functions for sound components
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
/*Sound Component Dispatch Selectors*/

enum {
	kSoundComponentInitOutputDeviceSelect = 1,					/*these calls cannot be delegated*/
	kSoundComponentSetSourceSelect = 2,
	kSoundComponentGetSourceSelect = 3,
	kSoundComponentGetSourceDataSelect = 4,
	kSoundComponentSetOutputSelect = 5,
	kDelegatedSoundComponentSelectors = 0x0100,					/*first selector that can be delegated up the chain*/
																/*these calls can be delegated and have own range*/
	kSoundComponentAddSourceSelect = kDelegatedSoundComponentSelectors + 1,
	kSoundComponentRemoveSourceSelect = kDelegatedSoundComponentSelectors + 2,
	kSoundComponentGetInfoSelect = kDelegatedSoundComponentSelectors + 3,
	kSoundComponentSetInfoSelect = kDelegatedSoundComponentSelectors + 4,
	kSoundComponentStartSourceSelect = kDelegatedSoundComponentSelectors + 5,
	kSoundComponentStopSourceSelect = kDelegatedSoundComponentSelectors + 6,
	kSoundComponentPauseSourceSelect = kDelegatedSoundComponentSelectors + 7,
	kSoundComponentPlaySourceBufferSelect = kDelegatedSoundComponentSelectors + 8
};

/*Audio Component selectors*/

enum {
	kAudioGetVolumeSelect		= 0,
	kAudioSetVolumeSelect		= 1,
	kAudioGetMuteSelect			= 2,
	kAudioSetMuteSelect			= 3,
	kAudioSetToDefaultsSelect	= 4,
	kAudioGetInfoSelect			= 5,
	kAudioGetBassSelect			= 6,
	kAudioSetBassSelect			= 7,
	kAudioGetTrebleSelect		= 8,
	kAudioSetTrebleSelect		= 9,
	kAudioGetOutputDeviceSelect	= 10,
	kAudioMuteOnEventSelect		= 129
};

/*
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   prototypes
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/* Sound Manager routines */
EXTERN_API( void )
SysBeep							(short 					duration)							ONEWORDINLINE(0xA9C8);

EXTERN_API( OSErr )
SndDoCommand					(SndChannelPtr 			chan,
								 const SndCommand *		cmd,
								 Boolean 				noWait)								ONEWORDINLINE(0xA803);

EXTERN_API( OSErr )
SndDoImmediate					(SndChannelPtr 			chan,
								 const SndCommand *		cmd)								ONEWORDINLINE(0xA804);

EXTERN_API( OSErr )
SndNewChannel					(SndChannelPtr *		chan,
								 short 					synth,
								 long 					init,
								 SndCallBackUPP 		userRoutine)						ONEWORDINLINE(0xA807);

EXTERN_API( OSErr )
SndDisposeChannel				(SndChannelPtr 			chan,
								 Boolean 				quietNow)							ONEWORDINLINE(0xA801);

EXTERN_API( OSErr )
SndPlay							(SndChannelPtr 			chan,
								 SndListHandle 			sndHandle,
								 Boolean 				async)								ONEWORDINLINE(0xA805);

#if OLDROUTINENAMES
EXTERN_API( OSErr )
SndAddModifier					(SndChannelPtr 			chan,
								 Ptr 					modifier,
								 short 					id,
								 long 					init)								ONEWORDINLINE(0xA802);

#endif  /* OLDROUTINENAMES */

EXTERN_API( OSErr )
SndControl						(short 					id,
								 SndCommand *			cmd)								ONEWORDINLINE(0xA806);

/* Sound Manager 2.0 and later, uses _SoundDispatch */
EXTERN_API( NumVersion )
SndSoundManagerVersion			(void)														FOURWORDINLINE(0x203C, 0x000C, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndStartFilePlay				(SndChannelPtr 			chan,
								 short 					fRefNum,
								 short 					resNum,
								 long 					bufferSize,
								 void *					theBuffer,
								 AudioSelectionPtr 		theSelection,
								 FilePlayCompletionUPP 	theCompletion,
								 Boolean 				async)								FOURWORDINLINE(0x203C, 0x0D00, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndPauseFilePlay				(SndChannelPtr 			chan)								FOURWORDINLINE(0x203C, 0x0204, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndStopFilePlay					(SndChannelPtr 			chan,
								 Boolean 				quietNow)							FOURWORDINLINE(0x203C, 0x0308, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndChannelStatus				(SndChannelPtr 			chan,
								 short 					theLength,
								 SCStatusPtr 			theStatus)							FOURWORDINLINE(0x203C, 0x0510, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndManagerStatus				(short 					theLength,
								 SMStatusPtr 			theStatus)							FOURWORDINLINE(0x203C, 0x0314, 0x0008, 0xA800);

EXTERN_API( void )
SndGetSysBeepState				(short *				sysBeepState)						FOURWORDINLINE(0x203C, 0x0218, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndSetSysBeepState				(short 					sysBeepState)						FOURWORDINLINE(0x203C, 0x011C, 0x0008, 0xA800);

EXTERN_API( OSErr )
SndPlayDoubleBuffer				(SndChannelPtr 			chan,
								 SndDoubleBufferHeaderPtr  theParams)						FOURWORDINLINE(0x203C, 0x0420, 0x0008, 0xA800);

/* MACE compression routines */
EXTERN_API( NumVersion )
MACEVersion						(void)														FOURWORDINLINE(0x203C, 0x0000, 0x0010, 0xA800);

EXTERN_API( void )
Comp3to1						(const void *			inBuffer,
								 void *					outBuffer,
								 unsigned long 			cnt,
								 StateBlockPtr 			inState,
								 StateBlockPtr 			outState,
								 unsigned long 			numChannels,
								 unsigned long 			whichChannel)						FOURWORDINLINE(0x203C, 0x0004, 0x0010, 0xA800);

EXTERN_API( void )
Exp1to3							(const void *			inBuffer,
								 void *					outBuffer,
								 unsigned long 			cnt,
								 StateBlockPtr 			inState,
								 StateBlockPtr 			outState,
								 unsigned long 			numChannels,
								 unsigned long 			whichChannel)						FOURWORDINLINE(0x203C, 0x0008, 0x0010, 0xA800);

EXTERN_API( void )
Comp6to1						(const void *			inBuffer,
								 void *					outBuffer,
								 unsigned long 			cnt,
								 StateBlockPtr 			inState,
								 StateBlockPtr 			outState,
								 unsigned long 			numChannels,
								 unsigned long 			whichChannel)						FOURWORDINLINE(0x203C, 0x000C, 0x0010, 0xA800);

EXTERN_API( void )
Exp1to6							(const void *			inBuffer,
								 void *					outBuffer,
								 unsigned long 			cnt,
								 StateBlockPtr 			inState,
								 StateBlockPtr 			outState,
								 unsigned long 			numChannels,
								 unsigned long 			whichChannel)						FOURWORDINLINE(0x203C, 0x0010, 0x0010, 0xA800);

/* Sound Manager 3.0 and later calls */
EXTERN_API( OSErr )
GetSysBeepVolume				(long *					level)								FOURWORDINLINE(0x203C, 0x0224, 0x0018, 0xA800);

EXTERN_API( OSErr )
SetSysBeepVolume				(long 					level)								FOURWORDINLINE(0x203C, 0x0228, 0x0018, 0xA800);

EXTERN_API( OSErr )
GetDefaultOutputVolume			(long *					level)								FOURWORDINLINE(0x203C, 0x022C, 0x0018, 0xA800);

EXTERN_API( OSErr )
SetDefaultOutputVolume			(long 					level)								FOURWORDINLINE(0x203C, 0x0230, 0x0018, 0xA800);

EXTERN_API( OSErr )
GetSoundHeaderOffset			(SndListHandle 			sndHandle,
								 long *					offset)								FOURWORDINLINE(0x203C, 0x0404, 0x0018, 0xA800);

EXTERN_API( UnsignedFixed )
UnsignedFixedMulDiv				(UnsignedFixed 			value,
								 UnsignedFixed 			multiplier,
								 UnsignedFixed 			divisor)							FOURWORDINLINE(0x203C, 0x060C, 0x0018, 0xA800);

EXTERN_API( OSErr )
GetCompressionInfo				(short 					compressionID,
								 OSType 				format,
								 short 					numChannels,
								 short 					sampleSize,
								 CompressionInfoPtr 	cp)									FOURWORDINLINE(0x203C, 0x0710, 0x0018, 0xA800);

EXTERN_API( OSErr )
SetSoundPreference				(OSType 				theType,
								 Str255 				name,
								 Handle 				settings)							FOURWORDINLINE(0x203C, 0x0634, 0x0018, 0xA800);

EXTERN_API( OSErr )
GetSoundPreference				(OSType 				theType,
								 Str255 				name,
								 Handle 				settings)							FOURWORDINLINE(0x203C, 0x0638, 0x0018, 0xA800);

EXTERN_API( OSErr )
OpenMixerSoundComponent			(SoundComponentDataPtr 	outputDescription,
								 long 					outputFlags,
								 ComponentInstance *	mixerComponent)						FOURWORDINLINE(0x203C, 0x0614, 0x0018, 0xA800);

EXTERN_API( OSErr )
CloseMixerSoundComponent		(ComponentInstance 		ci)									FOURWORDINLINE(0x203C, 0x0218, 0x0018, 0xA800);

/* Sound Manager 3.1 and later calls */
EXTERN_API( OSErr )
SndGetInfo						(SndChannelPtr 			chan,
								 OSType 				selector,
								 void *					infoPtr)							FOURWORDINLINE(0x203C, 0x063C, 0x0018, 0xA800);

EXTERN_API( OSErr )
SndSetInfo						(SndChannelPtr 			chan,
								 OSType 				selector,
								 const void *			infoPtr)							FOURWORDINLINE(0x203C, 0x0640, 0x0018, 0xA800);

EXTERN_API( OSErr )
GetSoundOutputInfo				(Component 				outputDevice,
								 OSType 				selector,
								 void *					infoPtr)							FOURWORDINLINE(0x203C, 0x0644, 0x0018, 0xA800);

EXTERN_API( OSErr )
SetSoundOutputInfo				(Component 				outputDevice,
								 OSType 				selector,
								 const void *			infoPtr)							FOURWORDINLINE(0x203C, 0x0648, 0x0018, 0xA800);

/* Sound Manager 3.2 and later calls */
EXTERN_API( OSErr )
GetCompressionName				(OSType 				compressionType,
								 Str255 				compressionName)					FOURWORDINLINE(0x203C, 0x044C, 0x0018, 0xA800);

EXTERN_API( OSErr )
SoundConverterOpen				(const SoundComponentData * inputFormat,
								 const SoundComponentData * outputFormat,
								 SoundConverter *		sc)									FOURWORDINLINE(0x203C, 0x0650, 0x0018, 0xA800);

EXTERN_API( OSErr )
SoundConverterClose				(SoundConverter 		sc)									FOURWORDINLINE(0x203C, 0x0254, 0x0018, 0xA800);

EXTERN_API( OSErr )
SoundConverterGetBufferSizes	(SoundConverter 		sc,
								 unsigned long 			inputBytesTarget,
								 unsigned long *		inputFrames,
								 unsigned long *		inputBytes,
								 unsigned long *		outputBytes)						FOURWORDINLINE(0x203C, 0x0A58, 0x0018, 0xA800);

EXTERN_API( OSErr )
SoundConverterBeginConversion	(SoundConverter 		sc)									FOURWORDINLINE(0x203C, 0x025C, 0x0018, 0xA800);

EXTERN_API( OSErr )
SoundConverterConvertBuffer		(SoundConverter 		sc,
								 const void *			inputPtr,
								 unsigned long 			inputFrames,
								 void *					outputPtr,
								 unsigned long *		outputFrames,
								 unsigned long *		outputBytes)						FOURWORDINLINE(0x203C, 0x0C60, 0x0018, 0xA800);

EXTERN_API( OSErr )
SoundConverterEndConversion		(SoundConverter 		sc,
								 void *					outputPtr,
								 unsigned long *		outputFrames,
								 unsigned long *		outputBytes)						FOURWORDINLINE(0x203C, 0x0864, 0x0018, 0xA800);

/*
  Sound Component Functions
   basic sound component functions
*/
EXTERN_API( ComponentResult )
SoundComponentInitOutputDevice	(ComponentInstance 		ti,
								 long 					actions)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentSetSource			(ComponentInstance 		ti,
								 SoundSource 			sourceID,
								 ComponentInstance 		source)								FIVEWORDINLINE(0x2F3C, 0x0008, 0x0002, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentGetSource			(ComponentInstance 		ti,
								 SoundSource 			sourceID,
								 ComponentInstance *	source)								FIVEWORDINLINE(0x2F3C, 0x0008, 0x0003, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentGetSourceData		(ComponentInstance 		ti,
								 SoundComponentDataPtr * sourceData)						FIVEWORDINLINE(0x2F3C, 0x0004, 0x0004, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentSetOutput			(ComponentInstance 		ti,
								 SoundComponentDataPtr 	requested,
								 SoundComponentDataPtr * actual)							FIVEWORDINLINE(0x2F3C, 0x0008, 0x0005, 0x7000, 0xA82A);

/* junction methods for the mixer, must be called at non-interrupt level*/
EXTERN_API( ComponentResult )
SoundComponentAddSource			(ComponentInstance 		ti,
								 SoundSource *			sourceID)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentRemoveSource		(ComponentInstance 		ti,
								 SoundSource 			sourceID)							FIVEWORDINLINE(0x2F3C, 0x0004, 0x0102, 0x7000, 0xA82A);

/* info methods*/
EXTERN_API( ComponentResult )
SoundComponentGetInfo			(ComponentInstance 		ti,
								 SoundSource 			sourceID,
								 OSType 				selector,
								 void *					infoPtr)							FIVEWORDINLINE(0x2F3C, 0x000C, 0x0103, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentSetInfo			(ComponentInstance 		ti,
								 SoundSource 			sourceID,
								 OSType 				selector,
								 void *					infoPtr)							FIVEWORDINLINE(0x2F3C, 0x000C, 0x0104, 0x7000, 0xA82A);

/* control methods*/
EXTERN_API( ComponentResult )
SoundComponentStartSource		(ComponentInstance 		ti,
								 short 					count,
								 SoundSource *			sources)							FIVEWORDINLINE(0x2F3C, 0x0006, 0x0105, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentStopSource		(ComponentInstance 		ti,
								 short 					count,
								 SoundSource *			sources)							FIVEWORDINLINE(0x2F3C, 0x0006, 0x0106, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentPauseSource		(ComponentInstance 		ti,
								 short 					count,
								 SoundSource *			sources)							FIVEWORDINLINE(0x2F3C, 0x0006, 0x0107, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
SoundComponentPlaySourceBuffer	(ComponentInstance 		ti,
								 SoundSource 			sourceID,
								 SoundParamBlockPtr 	pb,
								 long 					actions)							FIVEWORDINLINE(0x2F3C, 0x000C, 0x0108, 0x7000, 0xA82A);

/*Audio Components*/
/*Volume is described as a value between 0 and 1, with 0 indicating minimum
  volume and 1 indicating maximum volume; if the device doesn't support
  software control of volume, then a value of unimpErr is returned, indicating
  that these functions are not supported by the device*/
EXTERN_API( ComponentResult )
AudioGetVolume					(ComponentInstance 		ac,
								 short 					whichChannel,
								 ShortFixed *			volume)								FIVEWORDINLINE(0x2F3C, 0x0006, 0x0000, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioSetVolume					(ComponentInstance 		ac,
								 short 					whichChannel,
								 ShortFixed 			volume)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);

/*If the device doesn't support software control of mute, then a value of unimpErr is
returned, indicating that these functions are not supported by the device.*/
EXTERN_API( ComponentResult )
AudioGetMute					(ComponentInstance 		ac,
								 short 					whichChannel,
								 short *				mute)								FIVEWORDINLINE(0x2F3C, 0x0006, 0x0002, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioSetMute					(ComponentInstance 		ac,
								 short 					whichChannel,
								 short 					mute)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

/*AudioSetToDefaults causes the associated device to reset its volume and mute values
(and perhaps other characteristics, e.g. attenuation) to "factory default" settings*/
EXTERN_API( ComponentResult )
AudioSetToDefaults				(ComponentInstance 		ac)									FIVEWORDINLINE(0x2F3C, 0x0000, 0x0004, 0x7000, 0xA82A);

/*This routine is required; it must be implemented by all audio components*/

EXTERN_API( ComponentResult )
AudioGetInfo					(ComponentInstance 		ac,
								 AudioInfoPtr 			info)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioGetBass					(ComponentInstance 		ac,
								 short 					whichChannel,
								 short *				bass)								FIVEWORDINLINE(0x2F3C, 0x0006, 0x0006, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioSetBass					(ComponentInstance 		ac,
								 short 					whichChannel,
								 short 					bass)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioGetTreble					(ComponentInstance 		ac,
								 short 					whichChannel,
								 short *				Treble)								FIVEWORDINLINE(0x2F3C, 0x0006, 0x0008, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioSetTreble					(ComponentInstance 		ac,
								 short 					whichChannel,
								 short 					Treble)								FIVEWORDINLINE(0x2F3C, 0x0004, 0x0009, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
AudioGetOutputDevice			(ComponentInstance 		ac,
								 Component *			outputDevice)						FIVEWORDINLINE(0x2F3C, 0x0004, 0x000A, 0x7000, 0xA82A);



/*This is routine is private to the AudioVision component.  It enables the watching of the mute key.*/
EXTERN_API( ComponentResult )
AudioMuteOnEvent				(ComponentInstance 		ac,
								 short 					muteOnEvent)						FIVEWORDINLINE(0x2F3C, 0x0002, 0x0081, 0x7000, 0xA82A);



/* Sound Input Manager routines */
EXTERN_API( NumVersion )
SPBVersion						(void)														FOURWORDINLINE(0x203C, 0x0000, 0x0014, 0xA800);

EXTERN_API( OSErr )
SndRecord						(ModalFilterUPP 		filterProc,
								 Point 					corner,
								 OSType 				quality,
								 SndListHandle *		sndHandle)							FOURWORDINLINE(0x203C, 0x0804, 0x0014, 0xA800);

EXTERN_API( OSErr )
SndRecordToFile					(ModalFilterUPP 		filterProc,
								 Point 					corner,
								 OSType 				quality,
								 short 					fRefNum)							FOURWORDINLINE(0x203C, 0x0708, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBSignInDevice					(short 					deviceRefNum,
								 ConstStr255Param 		deviceName)							FOURWORDINLINE(0x203C, 0x030C, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBSignOutDevice				(short 					deviceRefNum)						FOURWORDINLINE(0x203C, 0x0110, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBGetIndexedDevice				(short 					count,
								 Str255 				deviceName,
								 Handle *				deviceIconHandle)					FOURWORDINLINE(0x203C, 0x0514, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBOpenDevice					(ConstStr255Param 		deviceName,
								 short 					permission,
								 long *					inRefNum)							FOURWORDINLINE(0x203C, 0x0518, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBCloseDevice					(long 					inRefNum)							FOURWORDINLINE(0x203C, 0x021C, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBRecord						(SPBPtr 				inParamPtr,
								 Boolean 				asynchFlag)							FOURWORDINLINE(0x203C, 0x0320, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBRecordToFile					(short 					fRefNum,
								 SPBPtr 				inParamPtr,
								 Boolean 				asynchFlag)							FOURWORDINLINE(0x203C, 0x0424, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBPauseRecording				(long 					inRefNum)							FOURWORDINLINE(0x203C, 0x0228, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBResumeRecording				(long 					inRefNum)							FOURWORDINLINE(0x203C, 0x022C, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBStopRecording				(long 					inRefNum)							FOURWORDINLINE(0x203C, 0x0230, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBGetRecordingStatus			(long 					inRefNum,
								 short *				recordingStatus,
								 short *				meterLevel,
								 unsigned long *		totalSamplesToRecord,
								 unsigned long *		numberOfSamplesRecorded,
								 unsigned long *		totalMsecsToRecord,
								 unsigned long *		numberOfMsecsRecorded)				FOURWORDINLINE(0x203C, 0x0E34, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBGetDeviceInfo				(long 					inRefNum,
								 OSType 				infoType,
								 void *					infoData)							FOURWORDINLINE(0x203C, 0x0638, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBSetDeviceInfo				(long 					inRefNum,
								 OSType 				infoType,
								 void *					infoData)							FOURWORDINLINE(0x203C, 0x063C, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBMillisecondsToBytes			(long 					inRefNum,
								 long *					milliseconds)						FOURWORDINLINE(0x203C, 0x0440, 0x0014, 0xA800);

EXTERN_API( OSErr )
SPBBytesToMilliseconds			(long 					inRefNum,
								 long *					byteCount)							FOURWORDINLINE(0x203C, 0x0444, 0x0014, 0xA800);

EXTERN_API( OSErr )
SetupSndHeader					(SndListHandle 			sndHandle,
								 short 					numChannels,
								 UnsignedFixed 			sampleRate,
								 short 					sampleSize,
								 OSType 				compressionType,
								 short 					baseNote,
								 unsigned long 			numBytes,
								 short *				headerLen)							FOURWORDINLINE(0x203C, 0x0D48, 0x0014, 0xA800);

EXTERN_API( OSErr )
SetupAIFFHeader					(short 					fRefNum,
								 short 					numChannels,
								 UnsignedFixed 			sampleRate,
								 short 					sampleSize,
								 OSType 				compressionType,
								 unsigned long 			numBytes,
								 unsigned long 			numFrames)							FOURWORDINLINE(0x203C, 0x0B4C, 0x0014, 0xA800);

/* Sound Input Manager 1.1 and later calls */
EXTERN_API( OSErr )
ParseAIFFHeader					(short 					fRefNum,
								 SoundComponentData *	sndInfo,
								 unsigned long *		numFrames,
								 unsigned long *		dataOffset)							FOURWORDINLINE(0x203C, 0x0758, 0x0014, 0xA800);

EXTERN_API( OSErr )
ParseSndHeader					(SndListHandle 			sndHandle,
								 SoundComponentData *	sndInfo,
								 unsigned long *		numFrames,
								 unsigned long *		dataOffset)							FOURWORDINLINE(0x203C, 0x085C, 0x0014, 0xA800);

enum { uppSndCallBackProcInfo = 0x000003C0 }; 					/* pascal no_return_value Func(4_bytes, 4_bytes) */
enum { uppSndDoubleBackProcInfo = 0x000003C0 }; 				/* pascal no_return_value Func(4_bytes, 4_bytes) */
enum { uppSoundParamProcInfo = 0x000000D0 }; 					/* pascal 1_byte Func(4_bytes) */
enum { uppSIInterruptProcInfo = 0x1C579802 }; 					/* register no_return_value Func(4_bytes:A0, 4_bytes:A1, 2_bytes:D0, 4_bytes:D1) */
enum { uppFilePlayCompletionProcInfo = 0x000000C0 }; 			/* pascal no_return_value Func(4_bytes) */
enum { uppSICompletionProcInfo = 0x000000C0 }; 					/* pascal no_return_value Func(4_bytes) */
#define NewSndCallBackProc(userRoutine) 						(SndCallBackUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSndCallBackProcInfo, GetCurrentArchitecture())
#define NewSndDoubleBackProc(userRoutine) 						(SndDoubleBackUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSndDoubleBackProcInfo, GetCurrentArchitecture())
#define NewSoundParamProc(userRoutine) 							(SoundParamUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSoundParamProcInfo, GetCurrentArchitecture())
#define NewSIInterruptProc(userRoutine) 						(SIInterruptUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSIInterruptProcInfo, GetCurrentArchitecture())
#define NewFilePlayCompletionProc(userRoutine) 					(FilePlayCompletionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppFilePlayCompletionProcInfo, GetCurrentArchitecture())
#define NewSICompletionProc(userRoutine) 						(SICompletionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSICompletionProcInfo, GetCurrentArchitecture())
#define CallSndCallBackProc(userRoutine, chan, cmd) 			CALL_TWO_PARAMETER_UPP((userRoutine), uppSndCallBackProcInfo, (chan), (cmd))
#define CallSndDoubleBackProc(userRoutine, channel, doubleBufferPtr)  CALL_TWO_PARAMETER_UPP((userRoutine), uppSndDoubleBackProcInfo, (channel), (doubleBufferPtr))
#define CallSoundParamProc(userRoutine, pb) 					CALL_ONE_PARAMETER_UPP((userRoutine), uppSoundParamProcInfo, (pb))
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	/* CallSIInterruptProc can't be called from classic 68k without glue code */
#else
	#define CallSIInterruptProc(userRoutine, inParamPtr, dataBuffer, peakAmplitude, sampleSize)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppSIInterruptProcInfo, (inParamPtr), (dataBuffer), (peakAmplitude), (sampleSize))
#endif
#define CallFilePlayCompletionProc(userRoutine, chan) 			CALL_ONE_PARAMETER_UPP((userRoutine), uppFilePlayCompletionProcInfo, (chan))
#define CallSICompletionProc(userRoutine, inParamPtr) 			CALL_ONE_PARAMETER_UPP((userRoutine), uppSICompletionProcInfo, (inParamPtr))



#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SOUND__ */

