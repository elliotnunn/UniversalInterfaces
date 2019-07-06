{
     File:       Components.p
 
     Contains:   Component Manager Interfaces.
 
     Version:    Technology: QuickTime 4.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1991-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Components;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COMPONENTS__}
{$SETC __COMPONENTS__ := 1}

{$I+}
{$SETC ComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kAppleManufacturer			= 'appl';						{  Apple supplied components  }
	kComponentResourceType		= 'thng';						{  a components resource type  }
	kComponentAliasResourceType	= 'thga';						{  component alias resource type  }

	kAnyComponentType			= 0;
	kAnyComponentSubType		= 0;
	kAnyComponentManufacturer	= 0;
	kAnyComponentFlagsMask		= 0;

	cmpIsMissing				= $20000000;
	cmpWantsRegisterMessage		= $80000000;

	kComponentOpenSelect		= -1;							{  ComponentInstance for this open  }
	kComponentCloseSelect		= -2;							{  ComponentInstance for this close  }
	kComponentCanDoSelect		= -3;							{  selector # being queried  }
	kComponentVersionSelect		= -4;							{  no params  }
	kComponentRegisterSelect	= -5;							{  no params  }
	kComponentTargetSelect		= -6;							{  ComponentInstance for top of call chain  }
	kComponentUnregisterSelect	= -7;							{  no params  }
	kComponentGetMPWorkFunctionSelect = -8;						{  some params  }
	kComponentExecuteWiredActionSelect = -9;					{  QTAtomContainer actionContainer, QTAtom actionAtom, QTCustomActionTargetPtr target, QTEventRecordPtr event  }
	kComponentGetPublicResourceSelect = -10;					{  OSType resourceType, short resourceId, Handle *resource  }

{ Component Resource Extension flags }
	componentDoAutoVersion		= $01;
	componentWantsUnregister	= $02;
	componentAutoVersionIncludeFlags = $04;
	componentHasMultiplePlatforms = $08;
	componentLoadResident		= $10;



{ Set Default Component flags }
	defaultComponentIdentical	= 0;
	defaultComponentAnyFlags	= 1;
	defaultComponentAnyManufacturer = 2;
	defaultComponentAnySubType	= 4;
	defaultComponentAnyFlagsAnyManufacturer = 3;
	defaultComponentAnyFlagsAnyManufacturerAnySubType = 7;

{ RegisterComponentResource flags }
	registerComponentGlobal		= 1;
	registerComponentNoDuplicates = 2;
	registerComponentAfterExisting = 4;
	registerComponentAliasesOnly = 8;



TYPE
	ComponentDescriptionPtr = ^ComponentDescription;
	ComponentDescription = RECORD
		componentType:			OSType;									{  A unique 4-byte code indentifying the command set  }
		componentSubType:		OSType;									{  Particular flavor of this instance  }
		componentManufacturer:	OSType;									{  Vendor indentification  }
		componentFlags:			UInt32;									{  8 each for Component,Type,SubType,Manuf/revision  }
		componentFlagsMask:		UInt32;									{  Mask for specifying which flags to consider in search, zero during registration  }
	END;


	ResourceSpecPtr = ^ResourceSpec;
	ResourceSpec = RECORD
		resType:				OSType;									{  4-byte code   }
		resID:					INTEGER;								{           }
	END;

	ComponentResourcePtr = ^ComponentResource;
	ComponentResource = RECORD
		cd:						ComponentDescription;					{  Registration parameters  }
		component:				ResourceSpec;							{  resource where Component code is found  }
		componentName:			ResourceSpec;							{  name string resource  }
		componentInfo:			ResourceSpec;							{  info string resource  }
		componentIcon:			ResourceSpec;							{  icon resource  }
	END;

	ComponentResourceHandle				= ^ComponentResourcePtr;
	ComponentPlatformInfoPtr = ^ComponentPlatformInfo;
	ComponentPlatformInfo = RECORD
		componentFlags:			LONGINT;								{  flags of Component  }
		component:				ResourceSpec;							{  resource where Component code is found  }
		platformType:			INTEGER;								{  gestaltSysArchitecture result  }
	END;

	ComponentResourceExtensionPtr = ^ComponentResourceExtension;
	ComponentResourceExtension = RECORD
		componentVersion:		LONGINT;								{  version of Component  }
		componentRegisterFlags:	LONGINT;								{  flags for registration  }
		componentIconFamily:	INTEGER;								{  resource id of Icon Family  }
	END;

	ComponentPlatformInfoArrayPtr = ^ComponentPlatformInfoArray;
	ComponentPlatformInfoArray = RECORD
		count:					LONGINT;
		platformArray:			ARRAY [0..0] OF ComponentPlatformInfo;
	END;

	ExtComponentResourcePtr = ^ExtComponentResource;
	ExtComponentResource = RECORD
		cd:						ComponentDescription;					{  registration parameters  }
		component:				ResourceSpec;							{  resource where Component code is found  }
		componentName:			ResourceSpec;							{  name string resource  }
		componentInfo:			ResourceSpec;							{  info string resource  }
		componentIcon:			ResourceSpec;							{  icon resource  }
		componentVersion:		LONGINT;								{  version of Component  }
		componentRegisterFlags:	LONGINT;								{  flags for registration  }
		componentIconFamily:	INTEGER;								{  resource id of Icon Family  }
		count:					LONGINT;								{  elements in platformArray  }
		platformArray:			ARRAY [0..0] OF ComponentPlatformInfo;
	END;

	ExtComponentResourceHandle			= ^ExtComponentResourcePtr;
	ComponentAliasResourcePtr = ^ComponentAliasResource;
	ComponentAliasResource = RECORD
		cr:						ComponentResource;						{  Registration parameters  }
		aliasCD:				ComponentDescription;					{  component alias description  }
	END;

{  Structure received by Component:        }
	ComponentParametersPtr = ^ComponentParameters;
	ComponentParameters = PACKED RECORD
		flags:					UInt8;									{  call modifiers: sync/async, deferred, immed, etc  }
		paramSize:				UInt8;									{  size in bytes of actual parameters passed to this call  }
		what:					INTEGER;								{  routine selector, negative for Component management calls  }
		params:					ARRAY [0..0] OF LONGINT;				{  actual parameters for the indicated routine  }
	END;

	ComponentRecordPtr = ^ComponentRecord;
	ComponentRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Component							= ^ComponentRecord;
	ComponentInstanceRecordPtr = ^ComponentInstanceRecord;
	ComponentInstanceRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	ComponentInstance					= ^ComponentInstanceRecord;
	RegisteredComponentRecordPtr = ^RegisteredComponentRecord;
	RegisteredComponentRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	RegisteredComponentInstanceRecordPtr = ^RegisteredComponentInstanceRecord;
	RegisteredComponentInstanceRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	ComponentResult						= LONGINT;

CONST
	platform68k					= 1;							{  platform type (response from gestaltComponentPlatform)  }
	platformPowerPC				= 2;							{  (when gestaltComponentPlatform is not implemented, use  }
	platformInterpreted			= 3;							{  gestaltSysArchitecture)  }
	platformWin32				= 4;
	platformPowerPCNativeEntryPoint = 5;

	mpWorkFlagDoWork			= $01;
	mpWorkFlagDoCompletion		= $02;
	mpWorkFlagCopyWorkBlock		= $04;
	mpWorkFlagDontBlock			= $08;
	mpWorkFlagGetProcessorCount	= $10;
	mpWorkFlagGetIsRunning		= $40;

	cmpAliasNoFlags				= 0;
	cmpAliasOnlyThisFile		= 1;


TYPE
	ComponentMPWorkFunctionHeaderRecordPtr = ^ComponentMPWorkFunctionHeaderRecord;
	ComponentMPWorkFunctionHeaderRecord = RECORD
		headerSize:				UInt32;
		recordSize:				UInt32;
		workFlags:				UInt32;
		processorCount:			UInt16;
		unused:					SInt8;
		isRunning:				SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ComponentMPWorkFunctionProcPtr = FUNCTION(globalRefCon: UNIV Ptr; header: ComponentMPWorkFunctionHeaderRecordPtr): ComponentResult;
{$ELSEC}
	ComponentMPWorkFunctionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ComponentRoutineProcPtr = FUNCTION(VAR cp: ComponentParameters; componentStorage: Handle): ComponentResult;
{$ELSEC}
	ComponentRoutineProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	GetMissingComponentResourceProcPtr = FUNCTION(c: Component; resType: OSType; resID: INTEGER; refCon: UNIV Ptr; VAR resource: Handle): OSErr;
{$ELSEC}
	GetMissingComponentResourceProcPtr = ProcPtr;
{$ENDC}

	ComponentMPWorkFunctionUPP = UniversalProcPtr;
	ComponentRoutineUPP = UniversalProcPtr;
	GetMissingComponentResourceUPP = UniversalProcPtr;
{
    The parameter list for each ComponentFunction is unique. It is
    therefore up to users to create the appropriate procInfo for their
    own ComponentFunctions where necessary.
}
	ComponentFunctionUPP				= UniversalProcPtr;
{
    For Carbon, we add NewComponentFunctionUPP and DisposeComponentFunctionUPP
    calls that take a procInfo as their second parameter. This allows native
    Component writers to easily write a Carbon compliant component. Note that
    there is no InvokeComponentFunctionUPP, use the CallComponentFunction calls
    with the UPP instead.
}
{$IFC OPAQUE_UPP_TYPES }
FUNCTION NewComponentFunctionUPP(userRoutine: ProcPtr; procInfo: ProcInfoType): ComponentFunctionUPP;
PROCEDURE DisposeComponentFunctionUPP(userUPP: ComponentFunctionUPP);
{$ELSEC}
{$ENDC}  {OPAQUE_UPP_TYPES}



{*******************************************************
*                                                       *
*               APPLICATION LEVEL CALLS                 *
*                                                       *
*******************************************************}
{*******************************************************
* Component Database Add, Delete, and Query Routines
*******************************************************}
FUNCTION RegisterComponent(VAR cd: ComponentDescription; componentEntryPoint: ComponentRoutineUPP; global: INTEGER; componentName: Handle; componentInfo: Handle; componentIcon: Handle): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A82A;
	{$ENDC}
FUNCTION RegisterComponentResource(cr: ComponentResourceHandle; global: INTEGER): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $A82A;
	{$ENDC}
FUNCTION UnregisterComponent(aComponent: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A82A;
	{$ENDC}
FUNCTION FindNextComponent(aComponent: Component; VAR looking: ComponentDescription): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $A82A;
	{$ENDC}
FUNCTION CountComponents(VAR looking: ComponentDescription): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A82A;
	{$ENDC}
FUNCTION GetComponentInfo(aComponent: Component; VAR cd: ComponentDescription; componentName: Handle; componentInfo: Handle; componentIcon: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A82A;
	{$ENDC}
FUNCTION GetComponentListModSeed: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $A82A;
	{$ENDC}
FUNCTION GetComponentTypeModSeed(componentType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702C, $A82A;
	{$ENDC}
{*******************************************************
* Component Instance Allocation and dispatch routines
*******************************************************}
FUNCTION OpenAComponent(aComponent: Component; VAR ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702D, $A82A;
	{$ENDC}
FUNCTION OpenComponent(aComponent: Component): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $A82A;
	{$ENDC}
FUNCTION CloseComponent(aComponentInstance: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A82A;
	{$ENDC}
FUNCTION GetComponentInstanceError(aComponentInstance: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $A82A;
	{$ENDC}
{*******************************************************
*                                                       *
*                   CALLS MADE BY COMPONENTS            *
*                                                       *
*******************************************************}
{*******************************************************
* Component Management routines
*******************************************************}
PROCEDURE SetComponentInstanceError(aComponentInstance: ComponentInstance; theError: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A82A;
	{$ENDC}
FUNCTION GetComponentRefcon(aComponent: Component): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $A82A;
	{$ENDC}
PROCEDURE SetComponentRefcon(aComponent: Component; theRefcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $A82A;
	{$ENDC}
FUNCTION OpenComponentResFile(aComponent: Component): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $A82A;
	{$ENDC}
FUNCTION OpenAComponentResFile(aComponent: Component; VAR resRef: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702F, $A82A;
	{$ENDC}
FUNCTION CloseComponentResFile(refnum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $A82A;
	{$ENDC}
FUNCTION GetComponentResource(aComponent: Component; resType: OSType; resID: INTEGER; VAR theResource: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $A82A;
	{$ENDC}
FUNCTION GetComponentIndString(aComponent: Component; VAR theString: Str255; strListID: INTEGER; index: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $A82A;
	{$ENDC}
FUNCTION ResolveComponentAlias(aComponent: Component): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $A82A;
	{$ENDC}
FUNCTION GetComponentPublicResource(aComponent: Component; resourceType: OSType; resourceID: INTEGER; VAR theResource: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7038, $A82A;
	{$ENDC}
FUNCTION GetComponentPublicResourceList(resourceType: OSType; resourceID: INTEGER; flags: LONGINT; VAR cd: ComponentDescription; missingProc: GetMissingComponentResourceUPP; refCon: UNIV Ptr; atomContainerPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7039, $A82A;
	{$ENDC}

{*******************************************************
* Component Instance Management routines
*******************************************************}
FUNCTION GetComponentInstanceStorage(aComponentInstance: ComponentInstance): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A82A;
	{$ENDC}
PROCEDURE SetComponentInstanceStorage(aComponentInstance: ComponentInstance; theStorage: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $A82A;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetComponentInstanceA5(aComponentInstance: ComponentInstance): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $A82A;
	{$ENDC}
PROCEDURE SetComponentInstanceA5(aComponentInstance: ComponentInstance; theA5: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION CountComponentInstances(aComponent: Component): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $A82A;
	{$ENDC}
{ useful helper routines for convenient method dispatching }
FUNCTION CallComponentFunction(VAR params: ComponentParameters; func: ComponentFunctionUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $A82A;
	{$ENDC}
FUNCTION CallComponentFunctionWithStorage(storage: Handle; VAR params: ComponentParameters; func: ComponentFunctionUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $A82A;
	{$ENDC}
{$IFC TARGET_CPU_PPC AND TARGET_OS_MAC }
FUNCTION CallComponentFunctionWithStorageProcInfo(storage: Handle; VAR params: ComponentParameters; func: ProcPtr; funcProcInfo: ProcInfoType): LONGINT;
{$ELSEC}
{$ENDC}

FUNCTION DelegateComponentCall(VAR originalParams: ComponentParameters; ci: ComponentInstance): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $A82A;
	{$ENDC}
FUNCTION SetDefaultComponent(aComponent: Component; flags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $A82A;
	{$ENDC}
FUNCTION OpenDefaultComponent(componentType: OSType; componentSubType: OSType): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $A82A;
	{$ENDC}
FUNCTION OpenADefaultComponent(componentType: OSType; componentSubType: OSType; VAR ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702E, $A82A;
	{$ENDC}
FUNCTION CaptureComponent(capturedComponent: Component; capturingComponent: Component): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $A82A;
	{$ENDC}
FUNCTION UncaptureComponent(aComponent: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $A82A;
	{$ENDC}
FUNCTION RegisterComponentResourceFile(resRefNum: INTEGER; global: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $A82A;
	{$ENDC}
FUNCTION GetComponentIconSuite(aComponent: Component; VAR iconSuite: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $A82A;
	{$ENDC}

{*******************************************************
*                                                       *
*           Direct calls to the Components              *
*                                                       *
*******************************************************}
{  Old style names }

FUNCTION ComponentFunctionImplemented(ci: ComponentInstance; ftnNumber: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $FFFD, $7000, $A82A;
	{$ENDC}
FUNCTION GetComponentVersion(ci: ComponentInstance): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $FFFC, $7000, $A82A;
	{$ENDC}
FUNCTION ComponentSetTarget(ci: ComponentInstance; target: ComponentInstance): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $FFFA, $7000, $A82A;
	{$ENDC}
{  New style names }

FUNCTION CallComponentOpen(ci: ComponentInstance; self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $FFFF, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentClose(ci: ComponentInstance; self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $FFFE, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentCanDo(ci: ComponentInstance; ftnNumber: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $FFFD, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentVersion(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $FFFC, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentRegister(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $FFFB, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentTarget(ci: ComponentInstance; target: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $FFFA, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentUnregister(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $FFF9, $7000, $A82A;
	{$ENDC}
FUNCTION CallComponentGetMPWorkFunction(ci: ComponentInstance; VAR workFunction: ComponentMPWorkFunctionUPP; VAR refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $FFF8, $7000, $A82A;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CallComponentGetPublicResource(ci: ComponentInstance; resourceType: OSType; resourceID: INTEGER; VAR resource: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $FFF6, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC NOT TARGET_OS_MAC }
{ 
        CallComponent is used by ComponentGlue routines to manually call a component function on Win32
     }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CallComponent(ci: ComponentInstance; VAR cp: ComponentParameters): ComponentResult;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
    CallComponentDispatch is a CarbonLib routine that replaces CallComponent inline glue
    to call a component function.
 }
FUNCTION CallComponentDispatch(VAR cp: ComponentParameters): ComponentResult;

{ UPP call backs }

CONST
	uppComponentMPWorkFunctionProcInfo = $000003F0;
	uppComponentRoutineProcInfo = $000003F0;
	uppGetMissingComponentResourceProcInfo = $0000FBE0;

FUNCTION NewComponentMPWorkFunctionUPP(userRoutine: ComponentMPWorkFunctionProcPtr): ComponentMPWorkFunctionUPP; { old name was NewComponentMPWorkFunctionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewComponentRoutineUPP(userRoutine: ComponentRoutineProcPtr): ComponentRoutineUPP; { old name was NewComponentRoutineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewGetMissingComponentResourceUPP(userRoutine: GetMissingComponentResourceProcPtr): GetMissingComponentResourceUPP; { old name was NewGetMissingComponentResourceProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeComponentMPWorkFunctionUPP(userUPP: ComponentMPWorkFunctionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeComponentRoutineUPP(userUPP: ComponentRoutineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeGetMissingComponentResourceUPP(userUPP: GetMissingComponentResourceUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeComponentMPWorkFunctionUPP(globalRefCon: UNIV Ptr; header: ComponentMPWorkFunctionHeaderRecordPtr; userRoutine: ComponentMPWorkFunctionUPP): ComponentResult; { old name was CallComponentMPWorkFunctionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeComponentRoutineUPP(VAR cp: ComponentParameters; componentStorage: Handle; userRoutine: ComponentRoutineUPP): ComponentResult; { old name was CallComponentRoutineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeGetMissingComponentResourceUPP(c: Component; resType: OSType; resID: INTEGER; refCon: UNIV Ptr; VAR resource: Handle; userRoutine: GetMissingComponentResourceUPP): OSErr; { old name was CallGetMissingComponentResourceProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{ ProcInfos }






{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ComponentsIncludes}

{$ENDC} {__COMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
