{
     File:       ICACamera.p
 
     Contains:   Digital still camera-specific selectors and structures
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ICACamera;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ICACAMERA__}
{$SETC __ICACAMERA__ := 1}

{$I+}
{$SETC ICACameraIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   -------------------------------------------------------------------------
                                Selectors           
   -------------------------------------------------------------------------
}

CONST
																{  Camera properties }
																{  Refer to section 13 of the PIMA 15740 (PTP) specification for }
																{  descriptions and usage notes for these standard properties }
	kICAPropertyCameraBatteryLevel = '5001';					{  UInt8   enum/range }
	kICAPropertyCameraFunctionalMode = '5002';					{  UInt16     enum }
	kICAPropertyCameraImageSize	= '5003';						{  CFString     enum/range }
	kICAPropertyCameraCompressionSetting = '5004';				{  UInt8   enum/range }
	kICAPropertyCameraWhiteBalance = '5005';					{  UInt16     enum }
	kICAPropertyCameraRGBGain	= '5006';						{  null terminated string enum/range }
	kICAPropertyCameraFNumber	= '5007';						{  UInt16     enum }
	kICAPropertyCameraFocalLength = '5008';						{  UInt32     enum/range }
	kICAPropertyCameraFocusDistance = '5009';					{  UInt16     enum/range }
	kICAPropertyCameraFocusMode	= '500A';						{  UInt16     enum }
	kICAPropertyCameraExposureMeteringMode = '500B';			{  UInt16     enum }
	kICAPropertyCameraFlashMode	= '500C';						{  UInt16     enum }
	kICAPropertyCameraExposureTime = '500D';					{  UInt32     enum/range }
	kICAPropertyCameraExposureProgramMode = '500E';				{  UInt16     enum }
	kICAPropertyCameraExposureIndex = '500F';					{  UInt16     enum/range }
	kICAPropertyCameraExposureBiasCompensation = '5010';		{  UInt16     enum/range }
	kICAPropertyCameraDateTime	= '5011';						{  null terminated string     none }
	kICAPropertyCameraCaptureDelay = '5012';					{  UInt32     enum/range }
	kICAPropertyCameraStillCaptureMode = '5013';				{  UInt16     enum }
	kICAPropertyCameraContrast	= '5014';						{  UInt8   enum/range }
	kICAPropertyCameraSharpness	= '5015';						{  UInt8   enum/range }
	kICAPropertyCameraDigitalZoom = '5016';						{  UInt8   enum/range }
	kICAPropertyCameraEffectMode = '5017';						{  UInt16     enum }
	kICAPropertyCameraBurstNumber = '5018';						{  UInt16     enum/range }
	kICAPropertyCameraBurstInterval = '5019';					{  UInt16     enum/range }
	kICAPropertyCameraTimelapseNumber = '501A';					{  UInt16     enum/range }
	kICAPropertyCameraTimelapseInterval = '501B';				{  UInt32     enum/range }
	kICAPropertyCameraFocusMeteringMode = '501C';				{  UInt16     enum }

																{  Refer to section 5.5.3 of the PTP spec }
	kICAPropertyCameraStorageType = 'stor';						{  UInt16 }
	kICAPropertyCameraFilesystemType = 'fsys';					{  UInt16 }
	kICAPropertyCameraAccessCapability = 'acap';				{  UInt16 }
	kICAPropertyCameraMaxCapacity = 'maxc';						{  UInt64 }
	kICAPropertyCameraFreeSpaceInBytes = 'fres';				{  UInt64 }
	kICAPropertyCameraFreeSpaceInImages = 'frei';				{  UInt32 }
	kICAPropertyCameraStorageDescription = 'stod';				{  null terminated string }
	kICAPropertyCameraVolumeLabel = 'voll';						{  null terminated string }

																{  ICA specific }
	kICAPropertyCameraIcon		= 'icon';						{  ICAThumbnail }
	kICAPropertyCameraSupportedMessages = 'msgs';				{  array of OSTypes }

																{  Values for kICAPropertyCameraStorageType }
	kICAStorageFixedROM			= $0001;
	kICAStorageRemovableROM		= $0002;
	kICAStorageFixedRAM			= $0003;
	kICAStorageRemovableRAM		= $0004;

																{  Values for kICAPropertyCameraFilesystemType }
	kICAFileystemGenericFlat	= $0001;
	kICAFileystemGenericHierarchical = $0002;
	kICAFileystemDCF			= $0003;

																{  Values for kICAPropertyCameraAccessCapability }
	kICAAccessReadWrite			= $0000;
	kICAAccessReadOnly			= $0001;
	kICAAccessReadOnlyWithObjectDeletion = $0002;

																{  Camera messages }
	kICAMessageCameraCaptureNewImage = 'ccni';
	kICAMessageCameraDeleteOne	= 'del1';
	kICAMessageCameraDeleteAll	= 'dela';
	kICAMessageCameraSyncClock	= 'sclk';
	kICAMessageCameraUploadData	= 'load';

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ICACameraIncludes}

{$ENDC} {__ICACAMERA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
