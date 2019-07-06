{
 	File:		SoundSprocket.p
 
 	Contains:	Games Sprockets: SoundSprocket interfaces
 
 	Version:	Technology:	NetSprocket 1.0
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1996-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SoundSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUNDSPROCKET__}
{$SETC __SOUNDSPROCKET__ := 1}

{$I+}
{$SETC SoundSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DCAMERA__}
{$I QD3DCamera.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{******************************************************************************
 *	This stuff will be moved to Errors.h in a subsequent release
 *****************************************************************************}

CONST
	kSSpInternalErr				= -30340;
	kSSpVersionErr				= -30341;
	kSSpCantInstallErr			= -30342;
	kSSpParallelUpVectorErr		= -30343;
	kSSpScaleToZeroErr			= -30344;


{******************************************************************************
 *	SndSetInfo/SndGetInfo Messages
 *****************************************************************************}
{	The siSSpCPULoadLimit = '3dll' selector for SndGetInfo fills in a value of	}
{	type UInt32.																}

	kSSpSpeakerKind_Stereo		= 0;
	kSSpSpeakerKind_Mono		= 1;
	kSSpSpeakerKind_Headphones	= 2;


{	This is the data type is used with the SndGet/SetInfo selector				}
{	siSSpSpeakerSetup = '3dst'													}

TYPE
	SSpSpeakerSetupDataPtr = ^SSpSpeakerSetupData;
	SSpSpeakerSetupData = RECORD
		speakerKind:			UInt32;									{  Speaker configuration				 }
		speakerAngle:			Single;									{  Angle formed by user and speakers	 }
		reserved0:				UInt32;									{  Reserved for future use -- set to 0	 }
		reserved1:				UInt32;									{  Reserved for future use -- set to 0	 }
	END;


CONST
	kSSpMedium_Air				= 0;
	kSSpMedium_Water			= 1;


	kSSpSourceMode_Unfiltered	= 0;							{  No filtering applied					 }
	kSSpSourceMode_Localized	= 1;							{  Localized by source position			 }
	kSSpSourceMode_Ambient		= 2;							{  Coming from all around				 }
	kSSpSourceMode_Binaural		= 3;							{  Already binaurally localized			 }



TYPE
	SSpLocationDataPtr = ^SSpLocationData;
	SSpLocationData = RECORD
		elevation:				Single;									{  Angle of the meridian -- pos is up	 }
		azimuth:				Single;									{  Angle of the parallel -- pos is left	 }
		distance:				Single;									{  Distance between source and listener	 }
		projectionAngle:		Single;									{  Cos(angle) between cone and listener	 }
		sourceVelocity:			Single;									{  Speed of source toward the listener	 }
		listenerVelocity:		Single;									{ Speed of listener toward the source	 }
	END;

	SSpVirtualSourceDataPtr = ^SSpVirtualSourceData;
	SSpVirtualSourceData = RECORD
		attenuation:			Single;									{  Attenuation factor					 }
		location:				SSpLocationData;						{  Location of virtual source			 }
	END;

{	This is the data type is used with the SndGet/SetInfo selector				}
{	siSSpLocalization = '3dif'													}
	SSpLocalizationDataPtr = ^SSpLocalizationData;
	SSpLocalizationData = RECORD
		cpuLoad:				UInt32;									{  CPU load vs. quality -- 0 is best	 }
		medium:					UInt32;									{  Medium for sound propagation			 }
		humidity:				Single;									{  Humidity when medium is air			 }
		roomSize:				Single;									{  Reverb model -- distance bet. walls	 }
		roomReflectivity:		Single;									{ Reverb model -- bounce attenuation	 }
		reverbAttenuation:		Single;									{ Reverb model -- mix level			 }
		sourceMode:				UInt32;									{  Type of filtering to apply			 }
		referenceDistance:		Single;									{ Nominal distance for recording		 }
		coneAngleCos:			Single;									{  Cos(angle/2) of attenuation cone		 }
		coneAttenuation:		Single;									{  Attenuation outside the cone			 }
		currentLocation:		SSpLocationData;						{  Location of the sound 				 }
		reserved0:				UInt32;									{  Reserved for future use -- set to 0	 }
		reserved1:				UInt32;									{  Reserved for future use -- set to 0	 }
		reserved2:				UInt32;									{  Reserved for future use -- set to 0	 }
		reserved3:				UInt32;									{  Reserved for future use -- set to 0	 }
		virtualSourceCount:		UInt32;									{ Number of reflections				 }
		virtualSource:			ARRAY [0..3] OF SSpVirtualSourceData;	{ The reflections						 }
	END;

{$IFC TARGET_CPU_PPC }
{$IFC TYPED_FUNCTION_POINTERS}
	SSpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	SSpEventProcPtr = ProcPtr;
{$ENDC}

{******************************************************************************
 *	Global functions
 *****************************************************************************}
FUNCTION SSpConfigureSpeakerSetup(inEventProcPtr: SSpEventProcPtr): OSStatus; C;
FUNCTION SSpGetCPULoadLimit(VAR outCPULoadLimit: UInt32): OSStatus; C;

{******************************************************************************
 *	Routines for Maniulating Listeners
 *****************************************************************************}

TYPE
	SSpListenerReference = ^LONGINT;
FUNCTION SSpListener_New(VAR outListenerReference: SSpListenerReference): OSStatus; C;
FUNCTION SSpListener_Dispose(inListenerReference: SSpListenerReference): OSStatus; C;
FUNCTION SSpListener_SetTransform(inListenerReference: SSpListenerReference; {CONST}VAR inTransform: TQ3Matrix4x4): OSStatus; C;
FUNCTION SSpListener_GetTransform(inListenerReference: SSpListenerReference; VAR outTransform: TQ3Matrix4x4): OSStatus; C;
FUNCTION SSpListener_SetPosition(inListenerReference: SSpListenerReference; {CONST}VAR inPosition: TQ3Point3D): OSStatus; C;
FUNCTION SSpListener_GetPosition(inListenerReference: SSpListenerReference; VAR outPosition: TQ3Point3D): OSStatus; C;
FUNCTION SSpListener_SetOrientation(inListenerReference: SSpListenerReference; {CONST}VAR inOrientation: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_GetOrientation(inListenerReference: SSpListenerReference; VAR outOrientation: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_SetUpVector(inListenerReference: SSpListenerReference; {CONST}VAR inUpVector: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_GetUpVector(inListenerReference: SSpListenerReference; VAR outUpVector: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_SetCameraPlacement(inListenerReference: SSpListenerReference; {CONST}VAR inCameraPlacement: TQ3CameraPlacement): OSStatus; C;
FUNCTION SSpListener_GetCameraPlacement(inListenerReference: SSpListenerReference; VAR outCameraPlacement: TQ3CameraPlacement): OSStatus; C;
FUNCTION SSpListener_SetVelocity(inListenerReference: SSpListenerReference; {CONST}VAR inVelocity: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_GetVelocity(inListenerReference: SSpListenerReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_GetActualVelocity(inListenerReference: SSpListenerReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;
FUNCTION SSpListener_SetMedium(inListenerReference: SSpListenerReference; inMedium: UInt32; inHumidity: Single): OSStatus; C;
FUNCTION SSpListener_GetMedium(inListenerReference: SSpListenerReference; VAR outMedium: UInt32; VAR outHumidity: Single): OSStatus; C;
FUNCTION SSpListener_SetReverb(inListenerReference: SSpListenerReference; inRoomSize: Single; inRoomReflectivity: Single; inReverbAttenuation: Single): OSStatus; C;
FUNCTION SSpListener_GetReverb(inListenerReference: SSpListenerReference; VAR outRoomSize: Single; VAR outRoomReflectivity: Single; VAR outReverbAttenuation: Single): OSStatus; C;
FUNCTION SSpListener_SetMetersPerUnit(inListenerReference: SSpListenerReference; inMetersPerUnit: Single): OSStatus; C;
FUNCTION SSpListener_GetMetersPerUnit(inListenerReference: SSpListenerReference; VAR outMetersPerUnit: Single): OSStatus; C;

{******************************************************************************
 *	Routines for Manipulating Sources
 *****************************************************************************}

TYPE
	SSpSourceReference = ^LONGINT;
FUNCTION SSpSource_New(VAR outSourceReference: SSpSourceReference): OSStatus; C;
FUNCTION SSpSource_Dispose(inSourceReference: SSpSourceReference): OSStatus; C;
FUNCTION SSpSource_CalcLocalization(inSourceReference: SSpSourceReference; inListenerReference: SSpListenerReference; VAR out3DInfo: SSpLocalizationData): OSStatus; C;
FUNCTION SSpSource_SetTransform(inSourceReference: SSpSourceReference; {CONST}VAR inTransform: TQ3Matrix4x4): OSStatus; C;
FUNCTION SSpSource_GetTransform(inSourceReference: SSpSourceReference; VAR outTransform: TQ3Matrix4x4): OSStatus; C;
FUNCTION SSpSource_SetPosition(inSourceReference: SSpSourceReference; {CONST}VAR inPosition: TQ3Point3D): OSStatus; C;
FUNCTION SSpSource_GetPosition(inSourceReference: SSpSourceReference; VAR outPosition: TQ3Point3D): OSStatus; C;
FUNCTION SSpSource_SetOrientation(inSourceReference: SSpSourceReference; {CONST}VAR inOrientation: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_GetOrientation(inSourceReference: SSpSourceReference; VAR outOrientation: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_SetUpVector(inSourceReference: SSpSourceReference; {CONST}VAR inUpVector: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_GetUpVector(inSourceReference: SSpSourceReference; VAR outUpVector: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_SetCameraPlacement(inSourceReference: SSpSourceReference; {CONST}VAR inCameraPlacement: TQ3CameraPlacement): OSStatus; C;
FUNCTION SSpSource_GetCameraPlacement(inSourceReference: SSpSourceReference; VAR outCameraPlacement: TQ3CameraPlacement): OSStatus; C;
FUNCTION SSpSource_SetVelocity(inSourceReference: SSpSourceReference; {CONST}VAR inVelocity: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_GetVelocity(inSourceReference: SSpSourceReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_GetActualVelocity(inSourceReference: SSpSourceReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;
FUNCTION SSpSource_SetCPULoad(inSourceReference: SSpSourceReference; inCPULoad: UInt32): OSStatus; C;
FUNCTION SSpSource_GetCPULoad(inSourceReference: SSpSourceReference; VAR outCPULoad: UInt32): OSStatus; C;
FUNCTION SSpSource_SetMode(inSourceReference: SSpSourceReference; inMode: UInt32): OSStatus; C;
FUNCTION SSpSource_GetMode(inSourceReference: SSpSourceReference; VAR outMode: UInt32): OSStatus; C;
FUNCTION SSpSource_SetReferenceDistance(inSourceReference: SSpSourceReference; inReferenceDistance: Single): OSStatus; C;
FUNCTION SSpSource_GetReferenceDistance(inSourceReference: SSpSourceReference; VAR outReferenceDistance: Single): OSStatus; C;
FUNCTION SSpSource_SetSize(inSourceReference: SSpSourceReference; inLength: Single; inWidth: Single; inHeight: Single): OSStatus; C;
FUNCTION SSpSource_GetSize(inSourceReference: SSpSourceReference; VAR outLength: Single; VAR outWidth: Single; VAR outHeight: Single): OSStatus; C;
FUNCTION SSpSource_SetAngularAttenuation(inSourceReference: SSpSourceReference; inConeAngle: Single; inConeAttenuation: Single): OSStatus; C;
FUNCTION SSpSource_GetAngularAttenuation(inSourceReference: SSpSourceReference; VAR outConeAngle: Single; VAR outConeAttenuation: Single): OSStatus; C;
{$ENDC}  {TARGET_CPU_PPC}


{******************************************************************************
 *	MORE LATE-BREAKING NEWS
 *
 *	The SndGetInfo selector siSSpFilterVersion and datatype SSpFilterVersionData
 *	have been removed in favor of an alternate way of accessing filter version
 *	information.  The following function may be used for this purpose.
 *******************************************************************************
// **************************** GetSSpFilterVersion ****************************
// Finds the manufacturer and version number of the SoundSprocket filter that
// may be installed.  inManufacturer should be the manufacturer code specified
// at the installation time, which may be zero to allow any manufacturer.
// If no error is encountered, outManufacturer is set to the actual manufacturer
// code and outMajorVersion and outMinorVersion are set to the component
// specification level and manufacturer's implementation revision, respectively.
OSStatus GetSSpFilterVersion(
	OSType					inManufacturer,
	OSType*					outManufacturer,
	UInt32*					outMajorVersion,
	UInt32*					outMinorVersion)
(
	OSStatus				err;
	ComponentDescription	description;
	Component				componentRef;
	UInt32					vers;
	
	// Set up the component description
    description.componentType			= kSoundEffectsType;
    description.componentSubType		= kSSpLocalizationSubType;
    description.componentManufacturer	= inManufacturer;
    description.componentFlags			= 0;        
    description.componentFlagsMask		= 0;    
	
	// Find a component matching the description
	componentRef = FindNextComponent(nil, &description);
	if (componentRef == nil)  return couldntGetRequiredComponent;
	
	// Get the component description (for the manufacturer code)
	err = GetComponentInfo(componentRef, &description, nil, nil, nil);
	if (err != noErr)  return err;
	
	// Get the version composite
	vers = (UInt32) GetComponentVersion((ComponentInstance) componentRef);
	
	// Return the results
	*outManufacturer = description.componentManufacturer;
	*outMajorVersion = HiWord(vers);
	*outMinorVersion = LoWord(vers);
	
	return noErr;
)
******************************************************************************}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundSprocketIncludes}

{$ENDC} {__SOUNDSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
