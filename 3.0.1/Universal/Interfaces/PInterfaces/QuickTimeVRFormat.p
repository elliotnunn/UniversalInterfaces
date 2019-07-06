{
 	File:		QuickTimeVRFormat.p
 
 	Contains:	QuickTime VR interfaces
 
 	Version:	Technology:	QuickTime VR 2.0.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeVRFormat;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMEVRFORMAT__}
{$SETC __QUICKTIMEVRFORMAT__ := 1}

{$I+}
{$SETC QuickTimeVRFormatIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEVR__}
{$I QuickTimeVR.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  User data type for the Movie Controller type specifier }

CONST
	kQTControllerType			= 'ctyp';						{  Atom & ID of where our }
	kQTControllerID				= 1;							{  … controller name is stored }

{  VRWorld atom types }
	kQTVRWorldHeaderAtomType	= 'vrsc';
	kQTVRImagingParentAtomType	= 'imgp';
	kQTVRPanoImagingAtomType	= 'impn';
	kQTVRObjectImagingAtomType	= 'imob';
	kQTVRNodeParentAtomType		= 'vrnp';
	kQTVRNodeIDAtomType			= 'vrni';
	kQTVRNodeLocationAtomType	= 'nloc';

{  NodeInfo atom types }
	kQTVRNodeHeaderAtomType		= 'ndhd';
	kQTVRHotSpotParentAtomType	= 'hspa';
	kQTVRHotSpotAtomType		= 'hots';
	kQTVRHotSpotInfoAtomType	= 'hsin';
	kQTVRLinkInfoAtomType		= 'link';

{  Miscellaneous atom types }
	kQTVRStringAtomType			= 'vrsg';
	kQTVRPanoSampleDataAtomType	= 'pdat';
	kQTVRObjectInfoAtomType		= 'obji';
	kQTVRAngleRangeAtomType		= 'arng';
	kQTVRTrackRefArrayAtomType	= 'tref';
	kQTVRPanConstraintAtomType	= 'pcon';
	kQTVRTiltConstraintAtomType	= 'tcon';
	kQTVRFOVConstraintAtomType	= 'fcon';

{  Track reference types }
	kQTVRImageTrackRefType		= 'imgt';
	kQTVRHotSpotTrackRefType	= 'hott';

{  Old hot spot types }
	kQTVRHotSpotNavigableType	= 'navg';

{  Valid bits used in QTVRLinkHotSpotAtom }
	kQTVRValidPan				= $01;
	kQTVRValidTilt				= $02;
	kQTVRValidFOV				= $04;
	kQTVRValidViewCenter		= $08;


{  Values for flags field in QTVRPanoSampleAtom }
	kQTVRPanoFlagHorizontal		= $01;
	kQTVRPanoFlagLast			= $80000000;


{  Values for locationFlags field in QTVRNodeLocationAtom }
	kQTVRSameFile				= 0;


{  Header for QTVR track's Sample Description record (vrWorld atom container is appended) }

TYPE
	QTVRSampleDescriptionPtr = ^QTVRSampleDescription;
	QTVRSampleDescription = RECORD
		descSize:				UInt32;									{  total size of the QTVRSampleDescription }
		descType:				UInt32;									{  must be 'qtvr' }
		reserved1:				UInt32;									{  must be zero }
		reserved2:				UInt16;									{  must be zero }
		dataRefIndex:			UInt16;									{  must be zero }
		data:					UInt32;									{  Will be extended to hold vrWorld QTAtomContainer }
	END;

	QTVRSampleDescriptionHandle			= ^QTVRSampleDescriptionPtr;
{
  =================================================================================================
   Definitions and structures used in the VRWorld QTAtomContainer
  -------------------------------------------------------------------------------------------------
}


	QTVRStringAtomPtr = ^QTVRStringAtom;
	QTVRStringAtom = RECORD
		stringUsage:			UInt16;
		stringLength:			UInt16;
		theString:				PACKED ARRAY [0..3] OF UInt8;			{  field previously named "string" }
	END;



	QTVRWorldHeaderAtomPtr = ^QTVRWorldHeaderAtom;
	QTVRWorldHeaderAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		nameAtomID:				QTAtomID;
		defaultNodeID:			UInt32;
		vrWorldFlags:			UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;


{  Valid bits used in QTVRPanoImagingAtom }

CONST
	kQTVRValidCorrection		= $01;
	kQTVRValidQuality			= $02;
	kQTVRValidDirectDraw		= $04;
	kQTVRValidFirstExtraProperty = $08;


TYPE
	QTVRPanoImagingAtomPtr = ^QTVRPanoImagingAtom;
	QTVRPanoImagingAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		imagingMode:			UInt32;
		imagingValidFlags:		UInt32;
		correction:				UInt32;
		quality:				UInt32;
		directDraw:				UInt32;
		imagingProperties:		ARRAY [0..5] OF UInt32;					{  for future properties }
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	QTVRNodeLocationAtomPtr = ^QTVRNodeLocationAtom;
	QTVRNodeLocationAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		nodeType:				OSType;
		locationFlags:			UInt32;
		locationData:			UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

{
  =================================================================================================
   Definitions and structures used in the Nodeinfo QTAtomContainer
  -------------------------------------------------------------------------------------------------
}

	QTVRNodeHeaderAtomPtr = ^QTVRNodeHeaderAtom;
	QTVRNodeHeaderAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		nodeType:				OSType;
		nodeID:					QTAtomID;
		nameAtomID:				QTAtomID;
		commentAtomID:			QTAtomID;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	QTVRAngleRangeAtomPtr = ^QTVRAngleRangeAtom;
	QTVRAngleRangeAtom = RECORD
		minimumAngle:			Float32;
		maximumAngle:			Float32;
	END;

	QTVRHotSpotInfoAtomPtr = ^QTVRHotSpotInfoAtom;
	QTVRHotSpotInfoAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		hotSpotType:			OSType;
		nameAtomID:				QTAtomID;
		commentAtomID:			QTAtomID;
		cursorID:				ARRAY [0..2] OF SInt32;
																		{  canonical view for this hot spot }
		bestPan:				Float32;
		bestTilt:				Float32;
		bestFOV:				Float32;
		bestViewCenter:			QTVRFloatPoint;
																		{  Bounding box for this hot spot }
		hotSpotRect:			Rect;
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	QTVRLinkHotSpotAtomPtr = ^QTVRLinkHotSpotAtom;
	QTVRLinkHotSpotAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		toNodeID:				UInt32;
		fromValidFlags:			UInt32;
		fromPan:				Float32;
		fromTilt:				Float32;
		fromFOV:				Float32;
		fromViewCenter:			QTVRFloatPoint;
		toValidFlags:			UInt32;
		toPan:					Float32;
		toTilt:					Float32;
		toFOV:					Float32;
		toViewCenter:			QTVRFloatPoint;
		distance:				Float32;
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

{
  =================================================================================================
   Definitions and structures used in Panorama and Object tracks
  -------------------------------------------------------------------------------------------------
}

	QTVRPanoSampleAtomPtr = ^QTVRPanoSampleAtom;
	QTVRPanoSampleAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		imageRefTrackIndex:		UInt32;									{  track reference index of the full res image track }
		hotSpotRefTrackIndex:	UInt32;									{  track reference index of the full res hot spot track }
		minPan:					Float32;
		maxPan:					Float32;
		minTilt:				Float32;
		maxTilt:				Float32;
		minFieldOfView:			Float32;
		maxFieldOfView:			Float32;
		defaultPan:				Float32;
		defaultTilt:			Float32;
		defaultFieldOfView:		Float32;
																		{  Info for highest res version of image track }
		imageSizeX:				UInt32;									{  pixel width of the panorama (e.g. 768) }
		imageSizeY:				UInt32;									{  pixel height of the panorama (e.g. 2496) }
		imageNumFramesX:		UInt16;									{  diced frames wide (e.g. 1) }
		imageNumFramesY:		UInt16;									{  diced frames high (e.g. 24) }
																		{  Info for highest res version of hotSpot track }
		hotSpotSizeX:			UInt32;									{  pixel width of the hot spot panorama (e.g. 768) }
		hotSpotSizeY:			UInt32;									{  pixel height of the hot spot panorama (e.g. 2496) }
		hotSpotNumFramesX:		UInt16;									{  diced frames wide (e.g. 1) }
		hotSpotNumFramesY:		UInt16;									{  diced frames high (e.g. 24) }
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

{  Special resolution value for the FastStart low resolution image track }

CONST
	kQTVRFastStartTrackRes		= $8000;


TYPE
	QTVRTrackRefEntryPtr = ^QTVRTrackRefEntry;
	QTVRTrackRefEntry = RECORD
		trackRefType:			UInt32;
		trackResolution:		UInt16;
		trackRefIndex:			UInt32;
	END;

{
  =================================================================================================
   Object File format 2.0
  -------------------------------------------------------------------------------------------------
}

CONST
	kQTVRObjectAnimateViewFramesOn = $01;
	kQTVRObjectPalindromeViewFramesOn = $02;
	kQTVRObjectStartFirstViewFrameOn = $04;
	kQTVRObjectAnimateViewsOn	= $08;
	kQTVRObjectPalindromeViewsOn = $10;
	kQTVRObjectSyncViewToFrameRate = $20;
	kQTVRObjectDontLoopViewFramesOn = $40;

	kQTVRObjectWrapPanOn		= $01;
	kQTVRObjectWrapTiltOn		= $02;
	kQTVRObjectCanZoomOn		= $04;
	kQTVRObjectReverseHControlOn = $08;
	kQTVRObjectReverseVControlOn = $10;
	kQTVRObjectSwapHVControlOn	= $20;
	kQTVRObjectTranslationOn	= $40;

	kGrabberScrollerUI			= 1;							{  "Object"  }
	kOldJoyStickUI				= 2;							{   "1.0 Object as Scene"      }
	kJoystickUI					= 3;							{  "Object In Scene" }
	kGrabberUI					= 4;							{  "Grabber only" }
	kAbsoluteUI					= 5;							{  "Absolute pointer" }



TYPE
	QTVRObjectSampleAtomPtr = ^QTVRObjectSampleAtom;
	QTVRObjectSampleAtom = RECORD
		majorVersion:			UInt16;									{  kQTVRMajorVersion }
		minorVersion:			UInt16;									{  kQTVRMinorVersion }
		movieType:				UInt16;									{  ObjectUITypes }
		viewStateCount:			UInt16;									{  The number of view states 1 based }
		defaultViewState:		UInt16;									{  The default view state number. The number must be 1 to viewStateCount }
		mouseDownViewState:		UInt16;									{  The mouse down view state.   The number must be 1 to viewStateCount }
		viewDuration:			UInt32;									{  The duration of each view including all animation frames in a view }
		columns:				UInt32;									{  Number of columns in movie }
		rows:					UInt32;									{  Number rows in movie }
		mouseMotionScale:		Float32;								{  180.0 for kStandardObject or kQTVRObjectInScene, actual degrees for kOldNavigableMovieScene. }
		minPan:					Float32;								{  Start   horizontal pan angle in degrees }
		maxPan:					Float32;								{  End     horizontal pan angle in degrees }
		defaultPan:				Float32;								{  Initial horizontal pan angle in degrees (poster view) }
		minTilt:				Float32;								{  Start   vertical   pan angle in degrees }
		maxTilt:				Float32;								{  End     vertical   pan angle in degrees }
		defaultTilt:			Float32;								{  Initial vertical   pan angle in degrees (poster view)	 }
		minFieldOfView:			Float32;								{  minimum field of view setting (appears as the maximum zoom effect) must be >= 1 }
		fieldOfView:			Float32;								{  the field of view range must be >= 1 }
		defaultFieldOfView:		Float32;								{  must be in minFieldOfView and maxFieldOfView range inclusive }
		defaultViewCenterH:		Float32;
		defaultViewCenterV:		Float32;
		viewRate:				Float32;
		frameRate:				Float32;
		animationSettings:		UInt32;									{  32 reserved bit fields }
		controlSettings:		UInt32;									{  32 reserved bit fields }
	END;

{$IFC OLDROUTINENAMES }
	VRStringAtom						= QTVRStringAtom;
	VRStringAtomPtr 					= ^VRStringAtom;
	VRWorldHeaderAtom					= QTVRWorldHeaderAtom;
	VRWorldHeaderAtomPtr 				= ^VRWorldHeaderAtom;
	VRPanoImagingAtom					= QTVRPanoImagingAtom;
	VRPanoImagingAtomPtr 				= ^VRPanoImagingAtom;
	VRNodeLocationAtom					= QTVRNodeLocationAtom;
	VRNodeLocationAtomPtr 				= ^VRNodeLocationAtom;
	VRNodeHeaderAtom					= QTVRNodeHeaderAtom;
	VRNodeHeaderAtomPtr 				= ^VRNodeHeaderAtom;
	VRAngleRangeAtom					= QTVRAngleRangeAtom;
	VRAngleRangeAtomPtr 				= ^VRAngleRangeAtom;
	VRHotSpotInfoAtom					= QTVRHotSpotInfoAtom;
	VRHotSpotInfoAtomPtr 				= ^VRHotSpotInfoAtom;
	VRLinkHotSpotAtom					= QTVRLinkHotSpotAtom;
	VRLinkHotSpotAtomPtr 				= ^VRLinkHotSpotAtom;
	VRPanoSampleAtom					= QTVRPanoSampleAtom;
	VRPanoSampleAtomPtr 				= ^VRPanoSampleAtom;
	VRTrackRefEntry						= QTVRTrackRefEntry;
	VRTrackRefEntryPtr 					= ^VRTrackRefEntry;
	VRObjectSampleAtom					= QTVRObjectSampleAtom;
	VRObjectSampleAtomPtr 				= ^VRObjectSampleAtom;
{$ENDC}  {OLDROUTINENAMES}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeVRFormatIncludes}

{$ENDC} {__QUICKTIMEVRFORMAT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
