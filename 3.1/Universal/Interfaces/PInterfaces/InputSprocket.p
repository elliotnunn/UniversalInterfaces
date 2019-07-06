{
 	File:		InputSprocket.p
 
 	Contains:	Games Sprockets: InputSprocket interfaaces
 
 	Version:	Technology:	Input Sprocket 1.2
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
 UNIT InputSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __INPUTSPROCKET__}
{$SETC __INPUTSPROCKET__ := 1}

{$I+}
{$SETC InputSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC UNDEFINED USE_OLD_INPUT_SPROCKET_LABELS }
{$SETC USE_OLD_INPUT_SPROCKET_LABELS := 1 }
{$ENDC}

{$IFC UNDEFINED USE_OLD_ISPNEED_STRUCT }
{$SETC USE_OLD_ISPNEED_STRUCT := 1 }
{$ENDC}

{$IFC TARGET_CPU_PPC }
{ ********************* data types ********************* }

TYPE
	ISpDeviceReference = ^LONGINT;
	ISpElementReference = ^LONGINT;
	ISpElementListReference = ^LONGINT;
{ ISpDeviceClass is a general classs of device, example: keyboard, mouse, joystick }
	ISpDeviceClass						= OSType;
{ ISpDeviceIdentifier is a specific device,  example: standard 1-button mouse, 105key ext. kbd. }
	ISpDeviceIdentifier					= OSType;
	ISpElementLabel						= OSType;
	ISpElementKind						= OSType;

{ *************** errors -30420 to -30439***************** }

CONST
	kISpInternalErr				= -30420;
	kISpSystemListErr			= -30421;
	kISpBufferToSmallErr		= -30422;
	kISpElementInListErr		= -30423;
	kISpElementNotInListErr		= -30424;
	kISpSystemInactiveErr		= -30425;
	kISpDeviceInactiveErr		= -30426;
	kISpSystemActiveErr			= -30427;
	kISpDeviceActiveErr			= -30428;
	kISpListBusyErr				= -30429;

{ *************** resources **************** }
	kISpApplicationResourceType	= 'isap';
	kISpSetListResourceType		= 'setl';
	kISpSetDataResourceType		= 'setd';


TYPE
	ISpApplicationResourceStructPtr = ^ISpApplicationResourceStruct;
	ISpApplicationResourceStruct = RECORD
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;


CONST
	kISpAppResFlag_UsesInputSprocket = $00000001;				{  true if the application uses InputSprocket }
	kISpAppResFlag_UsesISpInit	= $00000002;					{  true if the calls ISpInit (ie, uses the high level interface, calls ISpConfigure, has a needs list, etc...) }

{
 * ISpDeviceDefinition
 *
 * This structure provides all the available
 * information for an input device within the system
 *
 }

TYPE
	ISpDeviceDefinitionPtr = ^ISpDeviceDefinition;
	ISpDeviceDefinition = RECORD
		deviceName:				Str63;									{  a human readable name of the device  }
		theDeviceClass:			ISpDeviceClass;							{  general classs of device example : keyboard, mouse, joystick  }
		theDeviceIdentifier:	ISpDeviceIdentifier;					{  every distinguishable device should have an OSType  }
		permanentID:			UInt32;									{  a cross reboot id unique within that deviceType, 0 if not possible  }
		flags:					UInt32;									{  status flags  }
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;


CONST
	kISpDeviceFlag_HandleOwnEmulation = 1;

{
 * ISpElementEvent, ISpElementEventPtr
 *
 * This is the structure that event data is passed in.
 *
 }

TYPE
	ISpElementEventPtr = ^ISpElementEvent;
	ISpElementEvent = RECORD
		when:					AbsoluteTime;							{  this is absolute time on PCI or later, otherwise it is  }
																		{  0 for the hi 32 bits and TickCount for the low 32 bits  }
		element:				ISpElementReference;					{  a reference to the element that generated this event  }
		refCon:					UInt32;									{  for application usage, 0 on the global list  }
		data:					UInt32;									{  the data for this event  }
	END;

{
 * ISpElementInfo, ISpElementInfoPtr
 *
 * This is the generic definition of an element.
 * Every element must contain this information.
 *
 }
	ISpElementInfoPtr = ^ISpElementInfo;
	ISpElementInfo = RECORD
		theLabel:				ISpElementLabel;
		theKind:				ISpElementKind;
		theString:				Str63;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	ISpNeedFlagBits						= UInt32;
{$IFC USE_OLD_ISPNEED_STRUCT }
	ISpNeedPtr = ^ISpNeed;
	ISpNeed = RECORD
		name:					Str63;
		iconSuiteResourceId:	INTEGER;								{  resource id of the icon suite  }
		reserved:				INTEGER;
		theKind:				ISpElementKind;
		theLabel:				ISpElementLabel;
		flags:					ISpNeedFlagBits;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

{$ELSEC}
	ISpNeed = RECORD
		name:					Str63;									{  human-readable string  }
		iconSuiteResourceId:	INTEGER;								{  resource id of the icon suite  }
		playerNum:				SInt8;									{  used for multi-player support  }
		group:					SInt8;									{  used to group related needs (eg, look left and look right button needs)  }
		theKind:				ISpElementKind;
		theLabel:				ISpElementLabel;
		flags:					ISpNeedFlagBits;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

{$ENDC}

CONST
	kISpNeedFlag_NoMultiConfig	= $00000001;					{  once this need is autoconfigured to one device dont autoconfigure to anything else }
	kISpNeedFlag_Utility		= $00000002;					{  this need is a utility function (like show framerate) which would not typically be assigned to anything but the keyboard }
	kISpNeedFlag_PolledOnly		= $00000004;
	kISpNeedFlag_EventsOnly		= $00000008;					{  *** kISpElementKind specific flags *** }
																{  these are flags specific to kISpElementKind_Button }
	kISpNeedFlag_Button_AlreadyAxis = $10000000;				{  there is a axis version of this button need }
	kISpNeedFlag_Button_ClickToggles = $20000000;
	kISpNeedFlag_Button_ActiveWhenDown = $40000000;				{  these are flags specific to kISpElementKind_DPad }
																{  these are flags specific to kISpElementKind_Axis }
	kISpNeedFlag_Axis_AlreadyButton = $10000000;				{  there is a button version of this axis need }
	kISpNeedFlag_Axis_Asymetric	= $20000000;					{  this axis need is asymetric	 }
																{  these are flags specific to kISpElementKind_Delta }
	kISpNeedFlag_Delta_AlreadyAxis = $10000000;					{  there is a axis version of this delta need }

{
 *
 * These are the current built values for ISpDeviceClass
 *
 }
	kISpDeviceClass_SpeechRecognition = 'talk';
	kISpDeviceClass_Mouse		= 'mous';
	kISpDeviceClass_Keyboard	= 'keyd';
	kISpDeviceClass_Joystick	= 'joys';
	kISpDeviceClass_Wheel		= 'whel';
	kISpDeviceClass_Pedals		= 'pedl';
	kISpDeviceClass_Levers		= 'levr';
	kISpDeviceClass_Tickle		= 'tckl';						{  a device of this class requires ISpTickle }

{
 * These are the current built in ISpElementKind's
 * 
 * These are all OSTypes.
 *
 }
	kISpElementKind_Button		= 'butn';
	kISpElementKind_DPad		= 'dpad';
	kISpElementKind_Axis		= 'axis';
	kISpElementKind_Delta		= 'dlta';
	kISpElementKind_Movement	= 'move';
	kISpElementKind_Virtual		= 'virt';


{
 *
 * These are the current built in ISpElementLabel's
 *
 * These are all OSTypes.
 *
 }
{$IFC USE_OLD_INPUT_SPROCKET_LABELS }
																{  axis  }
	kISpElementLabel_XAxis		= 'xaxi';
	kISpElementLabel_YAxis		= 'yaxi';
	kISpElementLabel_ZAxis		= 'zaxi';
	kISpElementLabel_Rx			= 'rxax';
	kISpElementLabel_Ry			= 'ryax';
	kISpElementLabel_Rz			= 'rzax';
	kISpElementLabel_Gas		= 'gasp';
	kISpElementLabel_Brake		= 'brak';
	kISpElementLabel_Clutch		= 'cltc';
	kISpElementLabel_Throttle	= 'thrt';
	kISpElementLabel_Trim		= 'trim';						{  direction pad  }
	kISpElementLabel_POVHat		= 'povh';
	kISpElementLabel_PadMove	= 'move';						{  buttons  }
	kISpElementLabel_Fire		= 'fire';
	kISpElementLabel_Start		= 'strt';
	kISpElementLabel_Select		= 'optn';

{$ENDC}
																{  generic  }
	kISpElementLabel_None		= 'none';						{  axis  }
	kISpElementLabel_Axis_XAxis	= 'xaxi';
	kISpElementLabel_Axis_YAxis	= 'yaxi';
	kISpElementLabel_Axis_ZAxis	= 'zaxi';
	kISpElementLabel_Axis_Rx	= 'rxax';
	kISpElementLabel_Axis_Ry	= 'ryax';
	kISpElementLabel_Axis_Rz	= 'rzax';
	kISpElementLabel_Axis_Roll	= 'rzax';
	kISpElementLabel_Axis_Pitch	= 'rxax';
	kISpElementLabel_Axis_Yaw	= 'ryax';
	kISpElementLabel_Axis_RollTrim = 'rxtm';
	kISpElementLabel_Axis_PitchTrim = 'trim';
	kISpElementLabel_Axis_YawTrim = 'rytm';
	kISpElementLabel_Axis_Gas	= 'gasp';
	kISpElementLabel_Axis_Brake	= 'brak';
	kISpElementLabel_Axis_Clutch = 'cltc';
	kISpElementLabel_Axis_Throttle = 'thrt';
	kISpElementLabel_Axis_Trim	= 'trim';
	kISpElementLabel_Axis_Rudder = 'rudd';						{  delta  }
	kISpElementLabel_Delta_X	= 'xdlt';
	kISpElementLabel_Delta_Y	= 'ydlt';
	kISpElementLabel_Delta_Z	= 'zdlt';
	kISpElementLabel_Delta_Rx	= 'rxdl';
	kISpElementLabel_Delta_Ry	= 'rydl';
	kISpElementLabel_Delta_Rz	= 'rzdl';
	kISpElementLabel_Delta_Roll	= 'rzdl';
	kISpElementLabel_Delta_Pitch = 'rxdl';
	kISpElementLabel_Delta_Yaw	= 'rydl';						{  direction pad  }
	kISpElementLabel_Pad_POV	= 'povh';
	kISpElementLabel_Pad_Move	= 'move';						{  buttons  }
	kISpElementLabel_Btn_Fire	= 'fire';
	kISpElementLabel_Btn_SecondaryFire = 'sfir';
	kISpElementLabel_Btn_Jump	= 'jump';
	kISpElementLabel_Btn_PauseResume = 'strt';					{  kISpElementLabel_Btn_PauseResume automatically binds to escape  }
	kISpElementLabel_Btn_Select	= 'optn';
	kISpElementLabel_Btn_SlideLeft = 'blft';
	kISpElementLabel_Btn_SlideRight = 'brgt';
	kISpElementLabel_Btn_MoveForward = 'btmf';
	kISpElementLabel_Btn_MoveBackward = 'btmb';
	kISpElementLabel_Btn_TurnLeft = 'bttl';
	kISpElementLabel_Btn_TurnRight = 'bttr';
	kISpElementLabel_Btn_LookLeft = 'btll';
	kISpElementLabel_Btn_LookRight = 'btlr';
	kISpElementLabel_Btn_LookUp	= 'btlu';
	kISpElementLabel_Btn_LookDown = 'btld';
	kISpElementLabel_Btn_Next	= 'btnx';
	kISpElementLabel_Btn_Previous = 'btpv';
	kISpElementLabel_Btn_SideStep = 'side';
	kISpElementLabel_Btn_Run	= 'quik';
	kISpElementLabel_Btn_Look	= 'blok';

{
 *
 * direction pad data & configuration information
 *
 }

TYPE
	ISpDPadData							= UInt32;

CONST
	kISpPadIdle					= 0;
	kISpPadLeft					= 1;
	kISpPadUpLeft				= 2;
	kISpPadUp					= 3;
	kISpPadUpRight				= 4;
	kISpPadRight				= 5;
	kISpPadDownRight			= 6;
	kISpPadDown					= 7;
	kISpPadDownLeft				= 8;


TYPE
	ISpDPadConfigurationInfoPtr = ^ISpDPadConfigurationInfo;
	ISpDPadConfigurationInfo = RECORD
		id:						UInt32;									{  ordering 1..n, 0 = no relavent ordering of direction pads  }
		fourWayPad:				BOOLEAN;								{  true if this pad can only produce idle + four directions  }
	END;

{
 *
 * button data & configuration information
 *
 }
	ISpButtonData						= UInt32;

CONST
	kISpButtonUp				= 0;
	kISpButtonDown				= 1;


TYPE
	ISpButtonConfigurationInfoPtr = ^ISpButtonConfigurationInfo;
	ISpButtonConfigurationInfo = RECORD
		id:						UInt32;									{  ordering 1..n, 0 = no relavent ordering of buttons  }
	END;

{
 *
 * axis data & configuration information 
 *
 }
	ISpAxisData							= UInt32;
	ISpAxisConfigurationInfoPtr = ^ISpAxisConfigurationInfo;
	ISpAxisConfigurationInfo = RECORD
		symetricAxis:			BOOLEAN;								{  axis is symetric, i.e. a joystick is symetric and a gas pedal is not  }
	END;

	ISpDeltaData						= Fixed;
	ISpDeltaConfigurationInfoPtr = ^ISpDeltaConfigurationInfo;
	ISpDeltaConfigurationInfo = RECORD
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	ISpMovementDataPtr = ^ISpMovementData;
	ISpMovementData = RECORD
		xAxis:					ISpAxisData;
		yAxis:					ISpAxisData;
		direction:				ISpDPadData;							{  ISpDPadData version of the movement  }
	END;


CONST
	kISpVirtualElementFlag_UseTempMem = 1;

	kISpElementListFlag_UseTempMem = 1;

	kISpFirstIconSuite			= 30000;
	kISpLastIconSuite			= 30100;
	kISpNoneIconSuite			= 30000;

{ ********************* user level functions ********************* }


{
 *
 * startup / shutdown
 *
 }
FUNCTION ISpStartup: OSStatus; C;
{  1.1 or later }
FUNCTION ISpShutdown: OSStatus; C;
{  1.1 or later }
{
 *
 * polling
 *
 }
FUNCTION ISpTickle: OSStatus; C;
{  1.1 or later }
{********* user interface functions *********}

FUNCTION ISpGetVersion: NumVersion; C;
{
 *
 * ISpElement_NewVirtual(ISpElementReference *outElement);
 *
 }
FUNCTION ISpElement_NewVirtual(dataSize: UInt32; VAR outElement: ISpElementReference; flags: UInt32): OSStatus; C;
{
 *
 * ISpElement_NewVirtualFromNeeds(UInt32 count, ISpNeeds *needs, ISpElementReference *outElements);
 *
 }
FUNCTION ISpElement_NewVirtualFromNeeds(count: UInt32; VAR needs: ISpNeed; VAR outElements: ISpElementReference; flags: UInt32): OSStatus; C;
{
 *
 * ISpElement_DisposeVirtual(inElement);
 *
 }
FUNCTION ISpElement_DisposeVirtual(count: UInt32; VAR inElements: ISpElementReference): OSStatus; C;
{
 * ISpInit
 *
 }
FUNCTION ISpInit(count: UInt32; VAR needs: ISpNeed; VAR inReferences: ISpElementReference; appCreatorCode: OSType; subCreatorCode: OSType; flags: UInt32; setListResourceId: INTEGER; reserved: UInt32): OSStatus; C;

{
 * ISpConfigure
 *
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ISpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	ISpEventProcPtr = ProcPtr;
{$ENDC}

FUNCTION ISpConfigure(inEventProcPtr: ISpEventProcPtr): OSStatus; C;
{
 *
 * ISpStop
 *
 }
FUNCTION ISpStop: OSStatus; C;
{
 *
 * ISpSuspend, ISpResume
 *
 * ISpSuspend turns all devices off and allocates memory so that the state may be later resumed.
 * ISpResume resumes to the previous state of the system after a suspend call.
 * 
 * Return Codes
 * memFullErr
 *
 }
FUNCTION ISpSuspend: OSStatus; C;
FUNCTION ISpResume: OSStatus; C;
{
 * ISpDevices_Extract, ISpDevices_ExtractByClass, ISpDevices_ExtractByIdentifier
 *
 * These will extract as many device references from the system wide list as will fit in your buffer.  
 *
 * inBufferCount - the size of your buffer (in units of sizeof(ISpDeviceReference)) this may be zero
 * buffer - a pointer to your buffer
 * outCount - contains the number of devices in the system
 *
 * ISpDevices_ExtractByClass extracts and counts devices of the specified ISpDeviceClass
 * ISpDevices_ExtractByIdentifier extracts and counts devices of the specified ISpDeviceIdentifier
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpDevices_Extract(inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpDeviceReference): OSStatus; C;
FUNCTION ISpDevices_ExtractByClass(inClass: ISpDeviceClass; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpDeviceReference): OSStatus; C;
FUNCTION ISpDevices_ExtractByIdentifier(inIdentifier: ISpDeviceIdentifier; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpDeviceReference): OSStatus; C;

{
 * ISpDevices_ActivateClass, ISpDevices_DeactivateClass, ISpDevices_Activate, ISpDevices_Deactivate, ISpDevice_IsActive
 *
 * ISpDevices_Activate, ISpDevices_Deactivate
 *
 * This will activate/deactivate a block of devices.
 * inDeviceCount - the number of devices to activate / deactivate
 * inDevicesToActivate/inDevicesToDeactivate - a pointer to a block of memory contains the devices references
 *
 * ISpDevices_ActivateClass, ISpDevices_DeactivateClass
 * inClass - the class of devices to activate or deactivate
 *
 * ISpDevice_IsActive
 * inDevice - the device reference that you wish to 
 * outIsActive - a boolean value that is true when the device is active
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpDevices_ActivateClass(inClass: ISpDeviceClass): OSStatus; C;
{  1.1 or later }
FUNCTION ISpDevices_DeactivateClass(inClass: ISpDeviceClass): OSStatus; C;
{  1.1 or later }
FUNCTION ISpDevices_Activate(inDeviceCount: UInt32; VAR inDevicesToActivate: ISpDeviceReference): OSStatus; C;
FUNCTION ISpDevices_Deactivate(inDeviceCount: UInt32; VAR inDevicesToDeactivate: ISpDeviceReference): OSStatus; C;
FUNCTION ISpDevice_IsActive(inDevice: ISpDeviceReference; VAR outIsActive: BOOLEAN): OSStatus; C;
{
 * ISpDevice_GetDefinition
 *
 *
 * inDevice - the device you want to get the definition for
 * inBuflen - the size of the structure (sizeof(ISpDeviceDefinition))
 * outStruct - a pointer to where you want the structure copied
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpDevice_GetDefinition(inDevice: ISpDeviceReference; inBuflen: UInt32; VAR outStruct: ISpDeviceDefinition): OSStatus; C;

{
 *
 * ISpDevice_GetElementList
 *
 * inDevice - the device whose element list you wish to get
 * outElementList - a pointer to where you want a reference to that list stored
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpDevice_GetElementList(inDevice: ISpDeviceReference; VAR outElementList: ISpElementListReference): OSStatus; C;
{
 *
 * takes an ISpElementReference and returns the group that it is in or 0 if there is
 * no group
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpElement_GetGroup(inElement: ISpElementReference; VAR outGroup: UInt32): OSStatus; C;
{
 *
 * takes an ISpElementReference and returns the device that the element belongs 
 * to.
 *
 * Return Codes
 * paramErr if inElement is 0 or outDevice is nil
 *
 }
FUNCTION ISpElement_GetDevice(inElement: ISpElementReference; VAR outDevice: ISpDeviceReference): OSStatus; C;
{
 *
 * takes an ISpElementReference and gives the ISpElementInfo for that Element.  This is the
 * the set of standard information.  You get ISpElementKind specific information
 * through ISpElement_GetConfigurationInfo.
 *
 * Return Codes
 * paramErr if inElement is 0 or outInfo is nil
 *
 }
FUNCTION ISpElement_GetInfo(inElement: ISpElementReference; outInfo: ISpElementInfoPtr): OSStatus; C;
{
 *
 * 		
 *
 * takes an ISpElementReference and gives the ISpElementKind specific configuration information
 * 
 * if buflen is not long enough to hold the information ISpElement_GetConfigurationInfo will
 * copy buflen bytes of the data into the block of memory pointed to by configInfo and
 * will return something error.
 *
 * Return Codes
 * paramErr if inElement or configInfo is nil
 *
 }
FUNCTION ISpElement_GetConfigurationInfo(inElement: ISpElementReference; buflen: UInt32; configInfo: UNIV Ptr): OSStatus; C;
{
 *
 * ISpElement_GetSimpleState
 *
 * Takes an ISpElementReference and returns the current state of that element.  This is a 
 * specialized version of ISpElement_GetComplexState that is only appropriate for elements
 * whose data fits in a signed 32 bit integer.
 *
 *
 *
 * Return Codes
 * paramErr if inElement is 0 or state is nil
 *
 }
FUNCTION ISpElement_GetSimpleState(inElement: ISpElementReference; VAR state: UInt32): OSStatus; C;
{
 *
 * ISpElement_GetComplexState
 *
 * Takes an ISpElementReference and returns the current state of that element.  
 * Will copy up to buflen bytes of the current state of the device into
 * state.
 *
 *
 * Return Codes
 * paramErr if inElement is 0 or state is nil
 *
 }
FUNCTION ISpElement_GetComplexState(inElement: ISpElementReference; buflen: UInt32; state: UNIV Ptr): OSStatus; C;

{
 * ISpElement_GetNextEvent
 *
 * It takes in an element  reference and the buffer size of the ISpElementEventPtr
 * it will set wasEvent to true if there was an event and false otherwise.  If there
 * was not enough space to fill in the whole event structure that event will be
 * dequed, as much of the event as will fit in the buffer will by copied and
 * ISpElement_GetNextEvent will return an error.
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpElement_GetNextEvent(inElement: ISpElementReference; bufSize: UInt32; event: ISpElementEventPtr; VAR wasEvent: BOOLEAN): OSStatus; C;
{
 *
 * ISpElement_Flush
 *
 * It takes an ISpElementReference and flushes all the events on that element.  All it guaruntees is
 * that any events that made it to this layer before the time of the flush call will be flushed and
 * it will not flush any events that make it to this layer after the time when the call has returned.
 * What happens to events that occur during the flush is undefined.
 *
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpElement_Flush(inElement: ISpElementReference): OSStatus; C;


{
 * ISpElementList_New
 *
 * Creates a new element list and returns it in outElementList.  In count specifies 
 * the number of element references in the list pointed to by inElements.  If inCount
 * is non zero the list is created with inCount elements in at as specified by the 
 * inElements parameter.  Otherwise the list is created empty.
 *
 *
 * Return Codes
 * out of memory - If it failed to allocate the list because it was out of memory
                   it will also set outElementList to 0
 * paramErr if outElementList was nil
 *
 *
 * Special Concerns
 *
 * interrupt unsafe
 *
 }
FUNCTION ISpElementList_New(inCount: UInt32; VAR inElements: ISpElementReference; VAR outElementList: ISpElementListReference; flags: UInt32): OSStatus; C;
{
 * ISpElementList_Dispose
 *
 * Deletes an already existing memory list.  
 *
 *
 * Return Codes
 * paramErr if inElementList was 0
 *
 *
 * Special Concerns
 *
 * interrupt unsafe
 *
 }
FUNCTION ISpElementList_Dispose(inElementList: ISpElementListReference): OSStatus; C;
{
 * ISpGetGlobalElementList
 *
 * returns the global element list
 *
 * Return Codes
 * paramErr if outElementList is nil
 *
 }
FUNCTION ISpGetGlobalElementList(VAR outElementList: ISpElementListReference): OSStatus; C;
{
 * ISpElementList_AddElement
 *
 * adds an element to the element list
 *
 * Return Codes
 * paramErr if inElementList is 0 or newElement is 0
 * memory error if the system is unable to allocate enough memory
 *
 * Special Concerns
 * interrupt Unsafe
 * 
 }
FUNCTION ISpElementList_AddElements(inElementList: ISpElementListReference; refCon: UInt32; count: UInt32; VAR newElements: ISpElementReference): OSStatus; C;
{
 * ISpElementList_RemoveElement
 *
 * removes the specified element from the element list
 *
 * Return Codes
 * paramErr if inElementList is 0 or oldElement is 0
 * memory error if the system is unable to allocate enough memory
 *
 * Special Concerns
 * interrupt Unsafe
 * 
 }
FUNCTION ISpElementList_RemoveElements(inElementList: ISpElementListReference; count: UInt32; VAR oldElement: ISpElementReference): OSStatus; C;
{
 * ISpElementList_Extract
 *
 * ISpElementList_Extract will extract as many of the elements from an element list as possible.  You pass
 * in an element list, a pointer to an array of element references and the number of elements in that array.
 * It will return how many items are in the element list in the outCount parameter and copy the minimum of 
 * that number and the size of the array into the buffer.
 *
 * ByKind and ByLabel are the same except that they will only count and copy element references to elements
 * that have the specified kind and label.
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpElementList_Extract(inElementList: ISpElementListReference; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpElementReference): OSStatus; C;
FUNCTION ISpElementList_ExtractByKind(inElementList: ISpElementListReference; inKind: ISpElementKind; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpElementReference): OSStatus; C;
FUNCTION ISpElementList_ExtractByLabel(inElementList: ISpElementListReference; inLabel: ISpElementLabel; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpElementReference): OSStatus; C;
{
 * ISpElementList_GetNextEvent
 *
 * It takes in an element list reference and the buffer size of the ISpElementEventPtr
 * it will set wasEvent to true if there was an event and false otherwise.  If there
 * was not enough space to fill in the whole event structure that event will be
 * dequed, as much of the event as will fit in the buffer will by copied and
 * ISpElementList_GetNextEvent will return an error.
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpElementList_GetNextEvent(inElementList: ISpElementListReference; bufSize: UInt32; event: ISpElementEventPtr; VAR wasEvent: BOOLEAN): OSStatus; C;
{
 *
 * ISpElementList_Flush
 *
 * It takes an ISpElementListReference and flushes all the events on that list.  All it guaruntees is
 * that any events that made it to this layer before the time of the flush call will be flushed and
 * it will not flush any events that make it to this layer after the time when the call has returned.
 * What happens to events that occur during the flush is undefined.
 *
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpElementList_Flush(inElementList: ISpElementListReference): OSStatus; C;
{
 *
 * ISpTimeToMicroseconds
 *
 *
 * This function takes time from an input sprocket event and converts it
 * into microseconds. (Version 1.2 or later of InputSprocket.)
 *
 *
 * Return Codes
 * paramErr
 *
 }
FUNCTION ISpTimeToMicroseconds({CONST}VAR inTime: AbsoluteTime; VAR outMicroseconds: UnsignedWide): OSStatus; C;

{$ENDC}  {TARGET_CPU_PPC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := InputSprocketIncludes}

{$ENDC} {__INPUTSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
