{
     File:       AVComponents.p
 
     Contains:   Standard includes for standard AV panels
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1989-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AVComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AVCOMPONENTS__}
{$SETC __AVCOMPONENTS__ := 1}

{$I+}
{$SETC AVComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    The subtypes listed here are for example only.  The display manager will find _all_ panels
    with the appropriate types.  These panels return class information that is used to devide them
    up into groups to be displayed in the AV Windows (class means "geometry" or "color" or other groupings
    like that.
}

CONST
	kAVPanelType				= 'avpc';						{  Panel subtypes         }
	kBrightnessPanelSubType		= 'brit';
	kContrastPanelSubType		= 'cont';
	kBitDepthPanelSubType		= 'bitd';
	kAVEngineType				= 'avec';						{  Engine subtypes           }
	kBrightnessEngineSubType	= 'brit';
	kContrastEngineSubType		= 'cont';						{     kBitDepthEngineSubType     = 'bitd',       // Not used               }
	kAVPortType					= 'avdp';						{  subtypes are defined in each port's public .h file  }
	kAVUtilityType				= 'avuc';
	kAVBackChannelSubType		= 'avbc';
	kAVCommunicationType		= 'avcm';
	kAVDialogType				= 'avdg';

{ PortComponent subtypes are up to the port and display manager does not use the subtype
    to find port components.  Instead, display manager uses an internal cache to search for portcompoennts.
    It turns out to be useful to have a unique subtype so that engines can see if they should apply themselves to
    a particular port component.
  
   PortKinds are the "class" of port.  When a port is registered with display manager (creating a display ID), the
    caller of DMNewDisplayIDByPortComponent passes a portKind.  Ports of this type are returned by
    DMNewDevicePortList.
  
   PortKinds are NOT subtypes of components
   PortKinds ARE used to register and find port components with Display Manager.  Here are the basic port kinds:
  
   Video displays are distinct from video out because there are some video out ports that are not actaully displays.
    if EZAV is looking to configure displays, it needs to look for kAVVideoDisplayPortKind not kAVVideoOutPortKind.
}
	kAVVideoDisplayPortKind		= 'pkdo';						{  Video Display (CRT or panel display)           }
	kAVVideoOutPortKind			= 'pkvo';						{  Video out port (camera output).                 }
	kAVVideoInPortKind			= 'pkvi';						{  Video in port (camera input)                }
	kAVSoundOutPortKind			= 'pkso';						{  Sound out port (speaker or speaker jack)       }
	kAVSoundInPortKind			= 'pksi';						{  Sound in port (microphone or microphone jack)   }
	kAVDeviceType				= 'avdc';						{  Device Component subtypes are up to the manufacturor since each device may contain multiple function types (eg telecaster)  }
	kAVDisplayDeviceKind		= 'dkvo';						{  Display device }
																{  Device Component subtypes are up to the manufacturor since each device may contain multiple function types (eg telecaster) }
	kAVCategoryType				= 'avcc';
	kAVSoundInSubType			= 'avao';
	kAVSoundOutSubType			= 'avai';
	kAVVideoInSubType			= 'vdin';
	kAVVideoOutSubType			= 'vdou';
	kAVInvalidType				= 'badt';						{  Some calls return a component type, in case of errors, these types are set to kAVInvalidComponentType  }

{
   Interface Signatures are used to identify what kind of component
   calls can be made for a given component. Today this applies only
   to ports, but could be applied to other components as well.
}
	kAVGenericInterfaceSignature = 'dmgr';
	kAVAppleVisionInterfaceSignature = 'avav';

{ =============================                    }
{ Panel Class Constants                            }
{ =============================                    }
	kAVPanelClassDisplayDefault	= 'cdsp';
	kAVPanelClassColor			= 'cclr';
	kAVPanelClassGeometry		= 'cgeo';
	kAVPanelClassSound			= 'csnd';
	kAVPanelClassPreferences	= 'cprf';
	kAVPanelClassLCD			= 'clcd';
	kAVPanelClassMonitorSound	= 'cres';
	kAVPanelClassAlert			= 'calr';
	kAVPanelClassExtras			= 'cext';
	kAVPanelClassRearrange		= 'crea';


{ =============================                    }
{ AV Notification Types                            }
{ =============================                    }
{
   This notification will be sent whenever a
   device has been reset, for whatever reason.
}
	kAVNotifyDeviceReset		= 'rset';


{ =============================                    }
{ Component interface revision levels and history  }
{ =============================                    }
	kAVPanelComponentInterfaceRevOne = 1;
	kAVPanelComponentInterfaceRevTwo = 2;
	kAVEngineComponentInterfaceRevOne = 1;
	kAVPortComponentInterfaceRevOne = 1;
	kAVDeviceComponentInterfaceRevOne = 1;
	kAVUtilityComponentInterfaceRevOne = 1;


{ =============================                    }
{ Adornment Constants                              }
{ =============================                    }
	kAVPanelAdornmentNoBorder	= 0;
	kAVPanelAdornmentStandardBorder = 1;

	kAVPanelAdornmentNoName		= 0;
	kAVPanelAdornmentStandardName = 1;


{ =============================                    }
{ Selector Ranges                                  }
{ =============================                    }
	kBaseAVComponentSelector	= 256;							{  First apple-defined selector for AV components  }
	kAppleAVComponentSelector	= 512;							{  First apple-defined type-specific selector for AV components  }


{ =============================                }
{ Panel Standard component selectors           }
{ =============================                }
	kAVPanelFakeRegisterSelect	= -5;							{  -5  }
	kAVPanelSetCustomDataSelect	= 0;
	kAVPanelGetDitlSelect		= 1;
	kAVPanelGetTitleSelect		= 2;
	kAVPanelInstallSelect		= 3;
	kAVPanelEventSelect			= 4;
	kAVPanelItemSelect			= 5;
	kAVPanelRemoveSelect		= 6;
	kAVPanelValidateInputSelect	= 7;
	kAVPanelGetSettingsIdentifiersSelect = 8;
	kAVPanelGetSettingsSelect	= 9;
	kAVPanelSetSettingsSelect	= 10;
	kAVPanelSelectorGetFidelitySelect = 256;
	kAVPanelSelectorTargetDeviceSelect = 257;
	kAVPanelSelectorGetPanelClassSelect = 258;
	kAVPanelSelectorGetPanelAdornmentSelect = 259;
	kAVPanelSelectorGetBalloonHelpStringSelect = 260;
	kAVPanelSelectorAppleGuideRequestSelect = 261;


{ =============================                }
{ Engine Standard component selectors          }
{ =============================                }
	kAVEngineGetEngineFidelitySelect = 256;
	kAVEngineTargetDeviceSelect	= 257;


{ =============================                    }
{ Video Port Specific calls                        }
{ =============================                    }
	kAVPortCheckTimingModeSelect = 0;
	kAVPortReserved1Select		= 1;							{  Reserved }
	kAVPortReserved2Select		= 2;							{  Reserved }
	kAVPortGetDisplayTimingInfoSelect = 512;
	kAVPortGetDisplayProfileCountSelect = 513;
	kAVPortGetIndexedDisplayProfileSelect = 514;
	kAVPortGetDisplayGestaltSelect = 515;


{ =============================                    }
{ AV Port Specific calls                           }
{ =============================                    }
	kAVPortGetAVDeviceFidelitySelect = 256;						{  Port Standard Component selectors  }
	kAVPortGetWiggleSelect		= 257;
	kAVPortSetWiggleSelect		= 258;
	kAVPortGetNameSelect		= 259;
	kAVPortGetGraphicInfoSelect	= 260;
	kAVPortSetActiveSelect		= 261;
	kAVPortGetActiveSelect		= 262;
	kAVPortUnsed1Select			= 263;							{  Selector removed as part of API change.  We don't want to mess up the following selectors, so we put in this spacer (ie kPadSelector).  }
	kAVPortGetAVIDSelect		= 264;
	kAVPortSetAVIDSelect		= 265;
	kAVPortSetDeviceAVIDSelect	= 266;							{  For registrar to set device (instead of hitting global directly) -- should only be called once  }
	kAVPortGetDeviceAVIDSelect	= 267;							{  Called by display mgr for generic ports  }
	kAVPortGetPowerStateSelect	= 268;
	kAVPortSetPowerStateSelect	= 269;
	kAVPortGetMakeAndModelSelect = 270;							{  Get Make and model information }
	kAVPortGetInterfaceSignatureSelect = 271;					{  To determine what VideoPort-specific calls can be made }
	kAVPortReserved3Select		= 272;							{  Reserved }
	kAVPortGetManufactureInfoSelect = 273;						{  Get more Make and model information   }




{ =============================                    }
{ Device Component Standard Component selectors    }
{ =============================                    }
	kAVDeviceGetNameSelect		= 256;
	kAVDeviceGetGraphicInfoSelect = 257;
	kAVDeviceGetPowerStateSelect = 258;
	kAVDeviceSetPowerStateSelect = 259;
	kAVDeviceGetAVIDSelect		= 260;
	kAVDeviceSetAVIDSelect		= 261;

{ =============================                    }
{ AV Back-Channel Selectors                        }
{ =============================                    }
	kAVBackChannelReservedSelector = 1;
	kAVBackChannelPreModalFilterSelect = 2;
	kAVBackChannelModalFilterSelect = 3;
	kAVBackChannelAppleGuideLaunchSelect = 4;







{ =============================                }
{ Engine Standard component selectors          }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION AVEngineComponentGetFidelity(engineComponent: ComponentInstance; displayID: DisplayIDType; VAR engineFidelity: DMFidelityType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION AVEngineComponentTargetDevice(engineComponent: ComponentInstance; displayID: DisplayIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ Panel Standard Component calls               }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION AVPanelFakeRegister(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $FFFB, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelSetCustomData(ci: ComponentInstance; theCustomData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelGetDitl(ci: ComponentInstance; VAR ditl: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelGetTitle(ci: ComponentInstance; title: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelInstall(ci: ComponentInstance; dialog: DialogPtr; itemOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelEvent(ci: ComponentInstance; dialog: DialogPtr; itemOffset: LONGINT; VAR event: EventRecord; VAR itemHit: INTEGER; VAR handled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelItem(ci: ComponentInstance; dialog: DialogPtr; itemOffset: LONGINT; itemNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelRemove(ci: ComponentInstance; dialog: DialogPtr; itemOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelValidateInput(ci: ComponentInstance; VAR ok: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelGetSettingsIdentifiers(ci: ComponentInstance; VAR theID: INTEGER; VAR theType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelGetSettings(ci: ComponentInstance; VAR userDataHand: Handle; flags: LONGINT; theDialog: DialogPtr; itemsOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelSetSettings(ci: ComponentInstance; userDataHand: Handle; flags: LONGINT; theDialog: DialogPtr; itemsOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelGetFidelity(panelComponent: ComponentInstance; displayID: DisplayIDType; VAR panelFidelity: DMFidelityType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelComponentTargetDevice(panelComponent: ComponentInstance; displayID: DisplayIDType; theDialog: DialogPtr; itemsOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelComponentGetPanelClass(panelComponent: ComponentInstance; VAR panelClass: ResType; VAR subClass: ResType; reserved1: Ptr; reserved2: Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelComponentGetPanelAdornment(panelComponent: ComponentInstance; VAR panelBorderType: LONGINT; VAR panelNameType: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelComponentGetBalloonHelpString(panelComponent: ComponentInstance; item: INTEGER; balloonString: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION AVPanelComponentAppleGuideRequest(panelComponent: ComponentInstance; agSelector: OSType; agDataReply: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0105, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ Port Component Standard Component selectors  }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION AVPortGetAVDeviceFidelity(portComponent: ComponentInstance; deviceAVID: AVIDType; VAR portFidelity: DMFidelityType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetWiggle(portComponent: ComponentInstance; VAR wiggleDevice: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortSetWiggle(portComponent: ComponentInstance; wiggleDevice: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetName(portComponent: ComponentInstance; VAR portName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetGraphicInfo(portComponent: ComponentInstance; VAR thePict: PicHandle; VAR theIconSuite: Handle; theLocation: AVLocationPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortSetActive(portComponent: ComponentInstance; setActive: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetActive(portComponent: ComponentInstance; VAR isPortActive: BOOLEAN; VAR portCanBeActivated: BOOLEAN; reserved: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetAVID(portComponent: ComponentInstance; VAR avPortID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortSetAVID(portComponent: ComponentInstance; avPortID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortSetDeviceAVID(portComponent: ComponentInstance; avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetDeviceAVID(portComponent: ComponentInstance; VAR avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010B, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetPowerState(portComponent: ComponentInstance; getPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010C, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortSetPowerState(portComponent: ComponentInstance; setPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010D, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetMakeAndModel(portComponent: ComponentInstance; theDisplayID: DisplayIDType; VAR manufacturer: ResType; VAR model: UInt32; VAR serialNumber: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010E, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetInterfaceSignature(portComponent: ComponentInstance; VAR interfaceSignature: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010F, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetManufactureInfo(portComponent: ComponentInstance; theDisplayID: DisplayIDType; theMakeAndModel: DMMakeAndModelPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0111, $7000, $A82A;
	{$ENDC}

{ =============================                }
{ Video Out Port Component Selectors           }
{ =============================                }
FUNCTION AVPortCheckTimingMode(displayComponent: ComponentInstance; theDisplayID: DisplayIDType; connectInfo: VDDisplayConnectInfoPtr; modeTiming: VDTimingInfoPtr; reserved: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetDisplayTimingInfo(displayComponent: ComponentInstance; modeTiming: VDTimingInfoPtr; requestedVersion: UInt32; modeInfo: DMDisplayTimingInfoPtr; reserved: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0200, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetDisplayProfileCount(displayComponent: ComponentInstance; reserved: UInt32; VAR profileCount: UInt32; VAR profileSeed: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0201, $7000, $A82A;
	{$ENDC}
{ pascal ComponentResult AVPortGetIndexedDisplayProfile(ComponentInstance displayComponent, UInt32 reserved, UInt32 profileIndex, UInt32 profileSeed, CMProfileRef* indexedProfile) }
FUNCTION AVPortGetIndexedDisplayProfile(displayComponent: ComponentInstance; reserved: UInt32; profileIndex: UInt32; profileSeed: UInt32; indexedProfile: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0202, $7000, $A82A;
	{$ENDC}
FUNCTION AVPortGetDisplayGestalt(displayComponent: ComponentInstance; displayGestaltSelector: ResType; VAR displayGestaltResponse: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0203, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ AV Device Component Selectors                }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION AVDeviceGetName(deviceComponent: ComponentInstance; VAR portName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION AVDeviceGetGraphicInfo(deviceComponent: ComponentInstance; VAR thePict: PicHandle; VAR theIconSuite: Handle; theLocation: AVLocationPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION AVDeviceGetPowerState(deviceComponent: ComponentInstance; getPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION AVDeviceSetPowerState(deviceComponent: ComponentInstance; setPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION AVDeviceGetAVID(deviceComponent: ComponentInstance; VAR avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION AVDeviceSetAVID(deviceComponent: ComponentInstance; avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ AV BackChannel Component Selectors           }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION AVBackChannelPreModalFilter(compInstance: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION AVBackChannelModalFilter(compInstance: ComponentInstance; VAR theEvent: EventRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION AVBackChannelAppleGuideLaunch(compInstance: ComponentInstance; theSubject: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AVComponentsIncludes}

{$ENDC} {__AVCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
