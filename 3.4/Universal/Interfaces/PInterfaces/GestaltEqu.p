{
     File:       GestaltEqu.p
 
     Contains:   Gestalt Interfaces.
 
     Version:    Technology: Mac OS 9.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc.  All rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GestaltEqu;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GESTALTEQU__}
{$SETC __GESTALTEQU__ := 1}

{$I+}
{$SETC GestaltEquIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}




TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SelectorFunctionProcPtr = FUNCTION(selector: OSType; VAR response: LONGINT): OSErr;
{$ELSEC}
	SelectorFunctionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SelectorFunctionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SelectorFunctionUPP = UniversalProcPtr;
{$ENDC}	
	{
	 *  Gestalt()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION Gestalt(selector: OSType; VAR response: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $201F, $A1AD, $2288, $3E80;
	{$ENDC}


{
 *  ReplaceGestalt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReplaceGestalt(selector: OSType; gestaltFunction: SelectorFunctionUPP; VAR oldGestaltFunction: SelectorFunctionUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $205F, $201F, $2F09, $A5AD, $225F, $2288, $3E80;
	{$ENDC}

{
 *  NewGestalt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewGestalt(selector: OSType; gestaltFunction: SelectorFunctionUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $201F, $A3AD, $3E80;
	{$ENDC}

{   The GestaltValue functions are available in System 7.5 and later }

{
 *  NewGestaltValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewGestaltValue(selector: OSType; newValue: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0401, $ABF1;
	{$ENDC}

{
 *  ReplaceGestaltValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReplaceGestaltValue(selector: OSType; replacementValue: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0402, $ABF1;
	{$ENDC}

{
 *  SetGestaltValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetGestaltValue(selector: OSType; newValue: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $ABF1;
	{$ENDC}

{
 *  DeleteGestaltValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeleteGestaltValue(selector: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0203, $ABF1;
	{$ENDC}



CONST
	uppSelectorFunctionProcInfo = $000003E0;
	{
	 *  NewSelectorFunctionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewSelectorFunctionUPP(userRoutine: SelectorFunctionProcPtr): SelectorFunctionUPP; { old name was NewSelectorFunctionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSelectorFunctionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSelectorFunctionUPP(userUPP: SelectorFunctionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSelectorFunctionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSelectorFunctionUPP(selector: OSType; VAR response: LONGINT; userRoutine: SelectorFunctionUPP): OSErr; { old name was CallSelectorFunctionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{ Environment Selectors }

CONST
	gestaltAddressingModeAttr	= 'addr';						{  addressing mode attributes  }
	gestalt32BitAddressing		= 0;							{  using 32-bit addressing mode  }
	gestalt32BitSysZone			= 1;							{  32-bit compatible system zone  }
	gestalt32BitCapable			= 2;							{  Machine is 32-bit capable  }

	gestaltAFPClient			= 'afps';
	gestaltAFPClientVersionMask	= $0000FFFF;					{  low word of long is the  }
																{  client version 0x0001 -> 0x0007 }
	gestaltAFPClient3_5			= $0001;
	gestaltAFPClient3_6			= $0002;
	gestaltAFPClient3_6_1		= $0003;
	gestaltAFPClient3_6_2		= $0004;
	gestaltAFPClient3_6_3		= $0005;						{  including 3.6.4, 3.6.5 }
	gestaltAFPClient3_7			= $0006;						{  including 3.7.1 }
	gestaltAFPClient3_7_2		= $0007;						{  including 3.7.3, 3.7.4 }
	gestaltAFPClient3_8			= $0008;
	gestaltAFPClient3_8_1		= $0009;						{  including 3.8.2  }
	gestaltAFPClient3_8_3		= $000A;
	gestaltAFPClient3_8_4		= $000B;						{  including 3.8.5, 3.8.6  }
	gestaltAFPClientAttributeMask = $FFFF0000;					{  high word of long is a  }
																{  set of attribute bits }
	gestaltAFPClientCfgRsrc		= 16;							{  Client uses config resources }
	gestaltAFPClientSupportsIP	= 29;							{  Client supports AFP over TCP/IP }
	gestaltAFPClientVMUI		= 30;							{  Client can put up UI from the PBVolMount trap }
	gestaltAFPClientMultiReq	= 31;							{  Client supports multiple outstanding requests }


	gestaltAliasMgrAttr			= 'alis';						{  Alias Mgr Attributes  }
	gestaltAliasMgrPresent		= 0;							{  True if the Alias Mgr is present  }
	gestaltAliasMgrSupportsRemoteAppletalk = 1;					{  True if the Alias Mgr knows about Remote Appletalk  }
	gestaltAliasMgrSupportsAOCEKeychain = 2;					{  True if the Alias Mgr knows about the AOCE Keychain  }
	gestaltAliasMgrResolveAliasFileWithMountOptions = 3;		{  True if the Alias Mgr implements gestaltAliasMgrResolveAliasFileWithMountOptions() and IsAliasFile()  }
	gestaltAliasMgrFollowsAliasesWhenResolving = 4;
	gestaltAliasMgrSupportsExtendedCalls = 5;
	gestaltAliasMgrSupportsFSCalls = 6;							{  true if Alias Mgr supports HFS+ Calls  }

	{	 Gestalt selector and values for the Appearance Manager 	}
	gestaltAppearanceAttr		= 'appr';
	gestaltAppearanceExists		= 0;
	gestaltAppearanceCompatMode	= 1;

	{	 Gestalt selector for determining Appearance Manager version   	}
	{	 If this selector does not exist, but gestaltAppearanceAttr    	}
	{	 does, it indicates that the 1.0 version is installed. This    	}
	{	 gestalt returns a BCD number representing the version of the  	}
	{	 Appearance Manager that is currently running, e.g. 0x0101 for 	}
	{	 version 1.0.1.                                                	}
	gestaltAppearanceVersion	= 'apvr';

	gestaltArbitorAttr			= 'arb ';
	gestaltSerialArbitrationExists = 0;							{  this bit if the serial port arbitrator exists }

	gestaltAppleScriptVersion	= 'ascv';						{  AppleScript version }

	gestaltAppleScriptAttr		= 'ascr';						{  AppleScript attributes }
	gestaltAppleScriptPresent	= 0;
	gestaltAppleScriptPowerPCSupport = 1;

	gestaltATAAttr				= 'ata ';						{  ATA is the driver to support IDE hard disks  }
	gestaltATAPresent			= 0;							{  if set, ATA Manager is present  }

	gestaltATalkVersion			= 'atkv';						{  Detailed AppleTalk version; see comment above for format  }

	gestaltAppleTalkVersion		= 'atlk';						{  appletalk version  }

	{	
	    FORMAT OF gestaltATalkVersion RESPONSE
	    --------------------------------------
	    The version is stored in the high three bytes of the response value.  Let us number
	    the bytes in the response value from 0 to 3, where 0 is the least-significant byte.
	
	        Byte#:     3 2 1 0
	        Value:  0xMMNNRR00
	
	    Byte 3 (MM) contains the major revision number, byte 2 (NN) contains the minor
	    revision number, and byte 1 (RR) contains a constant that represents the release
	    stage.  Byte 0 always contains 0x00.  The constants for the release stages are:
	
	        development = 0x20
	        alpha       = 0x40
	        beta        = 0x60
	        final       = 0x80
	        release     = 0x80
	
	    For example, if you call Gestalt with the 'atkv' selector when AppleTalk version 57
	    is loaded, you receive the long integer response value 0x39008000.
		}
	gestaltAUXVersion			= 'a/ux';						{  a/ux version, if present  }

	gestaltMacOSCompatibilityBoxAttr = 'bbox';					{  Classic presence and features  }
	gestaltMacOSCompatibilityBoxPresent = 0;					{  True if running under the Classic  }
	gestaltMacOSCompatibilityBoxHasSerial = 1;					{  True if Classic serial support is implemented.  }
	gestaltMacOSCompatibilityBoxless = 2;						{  True if we're Boxless (screen shared with Carbon/Cocoa)  }

	gestaltBusClkSpeed			= 'bclk';						{  main I/O bus clock speed in hertz  }

	gestaltCloseViewAttr		= 'BSDa';						{  CloseView attributes  }
	gestaltCloseViewEnabled		= 0;							{  Closeview enabled (dynamic bit - returns current state)  }
	gestaltCloseViewDisplayMgrFriendly = 1;						{  Closeview compatible with Display Manager (FUTURE)  }

	gestaltCarbonVersion		= 'cbon';						{  version of Carbon API present in system  }

	gestaltCFMAttr				= 'cfrg';						{  Selector for information about the Code Fragment Manager  }
	gestaltCFMPresent			= 0;							{  True if the Code Fragment Manager is present  }
	gestaltCFMPresentMask		= $0001;
	gestaltCFM99Present			= 2;							{  True if the CFM-99 features are present.  }
	gestaltCFM99PresentMask		= $0004;

	gestaltCollectionMgrVersion	= 'cltn';						{  Collection Manager version  }

	gestaltColorMatchingAttr	= 'cmta';						{  ColorSync attributes  }
	gestaltHighLevelMatching	= 0;
	gestaltColorMatchingLibLoaded = 1;

	gestaltColorMatchingVersion	= 'cmtc';
	gestaltColorSync10			= $0100;						{  0x0100 & 0x0110 _Gestalt versions for 1.0-1.0.3 product  }
	gestaltColorSync11			= $0110;						{    0x0100 == low-level matching only  }
	gestaltColorSync104			= $0104;						{  Real version, by popular demand  }
	gestaltColorSync105			= $0105;
	gestaltColorSync20			= $0200;						{  ColorSync 2.0  }
	gestaltColorSync21			= $0210;
	gestaltColorSync211			= $0211;
	gestaltColorSync212			= $0212;
	gestaltColorSync213			= $0213;
	gestaltColorSync25			= $0250;
	gestaltColorSync26			= $0260;
	gestaltColorSync261			= $0261;
	gestaltColorSync30			= $0300;

	gestaltControlMgrVersion	= 'cmvr';						{  NOTE: The first version we return is 3.0.1, on Mac OS X plus update 2 }

	gestaltControlMgrAttr		= 'cntl';						{  Control Mgr }
	gestaltControlMgrPresent	= $00000001;					{  NOTE: this is a bit mask, whereas all other Gestalt constants of }
																{  this type are bit index values.   Universal Interfaces 3.2 slipped }
																{  out the door with this mistake. }
	gestaltControlMgrPresentBit	= 0;							{  bit number }
	gestaltControlMsgPresentMask = $00000001;

	gestaltConnMgrAttr			= 'conn';						{  connection mgr attributes     }
	gestaltConnMgrPresent		= 0;
	gestaltConnMgrCMSearchFix	= 1;							{  Fix to CMAddSearch?      }
	gestaltConnMgrErrorString	= 2;							{  has CMGetErrorString()  }
	gestaltConnMgrMultiAsyncIO	= 3;							{  CMNewIOPB, CMDisposeIOPB, CMPBRead, CMPBWrite, CMPBIOKill  }

	gestaltColorPickerVersion	= 'cpkr';						{  returns version of ColorPicker  }
	gestaltColorPicker			= 'cpkr';						{  gestaltColorPicker is old name for gestaltColorPickerVersion  }

	gestaltComponentMgr			= 'cpnt';						{  Component Mgr version  }
	gestaltComponentPlatform	= 'copl';						{  Component Platform number  }

	{	
	    The gestaltNativeCPUtype ('cput') selector can be used to determine the
	    native CPU type for all Macs running System 7.5 or later.
	
	    The 'cput' selector is not available when running System 7.0 (or earlier)
	    on most 68K machines.  If 'cput' is not available, then the 'proc' selector
	    should be used to determine the processor type.
	
	    An application should always try the 'cput' selector first.  This is because,
	    on PowerPC machines, the 'proc' selector will reflect the CPU type of the
	    emulator's "virtual processor" rather than the native CPU type.
	
	    The values specified below are accurate.  Prior versions of the Gestalt
	    interface file contained values that were off by one.
	
	    The Quadra 840AV and the Quadra 660AV contain a bug in the ROM code that
	    causes the 'cput' selector to respond with the value 5.  This behavior
	    occurs only when running System 7.1.  System 7.5 fixes the bug by replacing
	    the faulty 'cput' selector function with the correct one.
	
	    The gestaltNativeCPUfamily ('cpuf') selector can be used to determine the
	    general family the native CPU is in. This can be helpful for determing how
	    blitters and things should be written. In general, it is smarter to use this
	    selector (when available) than gestaltNativeCPUtype since newer processors
	    in the same family can be handled without revising your code.
	
	    gestaltNativeCPUfamily uses the same results as gestaltNativeCPUtype, but
	    will only return certain CPU values.
		}
	gestaltNativeCPUtype		= 'cput';						{  Native CPU type                           }
	gestaltNativeCPUfamily		= 'cpuf';						{  Native CPU family                       }
	gestaltCPU68000				= 0;							{  Various 68k CPUs...     }
	gestaltCPU68010				= 1;
	gestaltCPU68020				= 2;
	gestaltCPU68030				= 3;
	gestaltCPU68040				= 4;
	gestaltCPU601				= $0101;						{  IBM 601                                }
	gestaltCPU603				= $0103;
	gestaltCPU604				= $0104;
	gestaltCPU603e				= $0106;
	gestaltCPU603ev				= $0107;
	gestaltCPU750				= $0108;						{  Also 740 - "G3"  }
	gestaltCPU604e				= $0109;
	gestaltCPU604ev				= $010A;						{  Mach 5, 250Mhz and up  }
	gestaltCPUG4				= $010C;						{  Max  }

{$IFC TARGET_OS_WIN32 }
																{  x86 CPUs all start with 'i' in the high nybble  }
	gestaltCPU486				= 'i486';
	gestaltCPUPentium			= 'i586';
	gestaltCPUPentiumPro		= 'i5pr';
	gestaltCPUPentiumII			= 'i5ii';
	gestaltCPUX86				= 'ixxx';

{$ENDC}  {TARGET_OS_WIN32}

	gestaltCRMAttr				= 'crm ';						{  comm resource mgr attributes  }
	gestaltCRMPresent			= 0;
	gestaltCRMPersistentFix		= 1;							{  fix for persistent tools  }
	gestaltCRMToolRsrcCalls		= 2;							{  has CRMGetToolResource/ReleaseToolResource  }

	gestaltControlStripVersion	= 'csvr';						{  Control Strip version (was 'sdvr')  }

	gestaltCTBVersion			= 'ctbv';						{  CommToolbox version  }

	gestaltDBAccessMgrAttr		= 'dbac';						{  Database Access Mgr attributes  }
	gestaltDBAccessMgrPresent	= 0;							{  True if Database Access Mgr present  }

	gestaltDiskCacheSize		= 'dcsz';						{  Size of disk cache's buffers, in bytes  }

	gestaltSDPFindVersion		= 'dfnd';						{  OCE Standard Directory Panel }

	gestaltDictionaryMgrAttr	= 'dict';						{  Dictionary Manager attributes  }
	gestaltDictionaryMgrPresent	= 0;							{  Dictionary Manager attributes  }

	gestaltDITLExtAttr			= 'ditl';						{  AppenDITL, etc. calls from CTB  }
	gestaltDITLExtPresent		= 0;							{  True if calls are present  }
	gestaltDITLExtSupportsIctb	= 1;							{  True if AppendDITL, ShortenDITL support 'ictb's  }

	gestaltDialogMgrAttr		= 'dlog';						{  Dialog Mgr }
	gestaltDialogMgrPresent		= $00000001;					{  NOTE: this is a bit mask, whereas all other Gestalt constants of }
																{  this type are bit index values.   Universal Interfaces 3.2 slipped }
																{  out the door with this mistake. }
	gestaltDialogMgrPresentBit	= 0;							{  bit number }
	gestaltDialogMsgPresentMask	= $00000001;

	gestaltDesktopPicturesAttr	= 'dkpx';						{  Desktop Pictures attributes  }
	gestaltDesktopPicturesInstalled = 0;						{  True if control panel is installed  }
	gestaltDesktopPicturesDisplayed = 1;						{  True if a picture is currently displayed  }

	gestaltDisplayMgrVers		= 'dplv';						{  Display Manager version  }

	gestaltDisplayMgrAttr		= 'dply';						{  Display Manager attributes  }
	gestaltDisplayMgrPresent	= 0;							{  True if Display Mgr is present  }
	gestaltDisplayMgrCanSwitchMirrored = 2;						{  True if Display Mgr can switch modes on mirrored displays  }
	gestaltDisplayMgrSetDepthNotifies = 3;						{  True SetDepth generates displays mgr notification  }
	gestaltDisplayMgrCanConfirm	= 4;							{  True Display Manager supports DMConfirmConfiguration  }
	gestaltDisplayMgrColorSyncAware = 5;						{  True if Display Manager supports profiles for displays  }
	gestaltDisplayMgrGeneratesProfiles = 6;						{  True if Display Manager will automatically generate profiles for displays  }

	gestaltDragMgrAttr			= 'drag';						{  Drag Manager attributes  }
	gestaltDragMgrPresent		= 0;							{  Drag Manager is present  }
	gestaltDragMgrFloatingWind	= 1;							{  Drag Manager supports floating windows  }
	gestaltPPCDragLibPresent	= 2;							{  Drag Manager PPC DragLib is present  }
	gestaltDragMgrHasImageSupport = 3;							{  Drag Manager allows SetDragImage call  }
	gestaltCanStartDragInFloatWindow = 4;						{  Drag Manager supports starting a drag in a floating window  }
	gestaltSetDragImageUpdates	= 5;							{  Drag Manager supports drag image updating via SetDragImage  }

	gestaltDrawSprocketVersion	= 'dspv';						{  Draw Sprocket version (as a NumVersion)  }

	gestaltDigitalSignatureVersion = 'dsig';					{  returns Digital Signature Toolbox version in low-order word }

	{
	   Desktop Printing Feature Gestalt
	   Use this gestalt to check if third-party printer driver support is available
	}
	gestaltDTPFeatures			= 'dtpf';
	kDTPThirdPartySupported		= $00000004;					{  mask for checking if third-party drivers are supported }


	{
	   Desktop Printer Info Gestalt
	   Use this gestalt to get a hold of information for all of the active desktop printers
	}
	gestaltDTPInfo				= 'dtpx';						{  returns GestaltDTPInfoHdle }

	gestaltEasyAccessAttr		= 'easy';						{  Easy Access attributes  }
	gestaltEasyAccessOff		= 0;							{  if Easy Access present, but off (no icon)  }
	gestaltEasyAccessOn			= 1;							{  if Easy Access "On"  }
	gestaltEasyAccessSticky		= 2;							{  if Easy Access "Sticky"  }
	gestaltEasyAccessLocked		= 3;							{  if Easy Access "Locked"  }

	gestaltEditionMgrAttr		= 'edtn';						{  Edition Mgr attributes  }
	gestaltEditionMgrPresent	= 0;							{  True if Edition Mgr present  }
	gestaltEditionMgrTranslationAware = 1;						{  True if edition manager is translation manager aware  }

	gestaltAppleEventsAttr		= 'evnt';						{  Apple Events attributes  }
	gestaltAppleEventsPresent	= 0;							{  True if Apple Events present  }
	gestaltScriptingSupport		= 1;
	gestaltOSLInSystem			= 2;							{  OSL is in system so don’t use the one linked in to app  }

	gestaltExtensionTableVersion = 'etbl';						{  ExtensionTable version  }


	gestaltFBCIndexingState		= 'fbci';						{  Find By Content indexing state }
	gestaltFBCindexingSafe		= 0;							{  any search will result in synchronous wait }
	gestaltFBCindexingCritical	= 1;							{  any search will execute immediately }

	gestaltFBCVersion			= 'fbcv';						{  Find By Content version }
	gestaltFBCCurrentVersion	= $0011;						{  First release for OS 8/9 }
	gestaltOSXFBCCurrentVersion	= $0100;						{  First release for OS X }


	gestaltFileMappingAttr		= 'flmp';						{  File mapping attributes }
	gestaltFileMappingPresent	= 0;							{  bit is set if file mapping APIs are present }
	gestaltFileMappingMultipleFilesFix = 1;						{  bit is set if multiple files per volume can be mapped }

	gestaltFloppyAttr			= 'flpy';						{  Floppy disk drive/driver attributes  }
	gestaltFloppyIsMFMOnly		= 0;							{  Floppy driver only supports MFM disk formats  }
	gestaltFloppyIsManualEject	= 1;							{  Floppy drive, driver, and file system are in manual-eject mode  }
	gestaltFloppyUsesDiskInPlace = 2;							{  Floppy drive must have special DISK-IN-PLACE output; standard DISK-CHANGED not used  }

	gestaltFinderAttr			= 'fndr';						{  Finder attributes  }
	gestaltFinderDropEvent		= 0;							{  Finder recognizes drop event  }
	gestaltFinderMagicPlacement	= 1;							{  Finder supports magic icon placement  }
	gestaltFinderCallsAEProcess	= 2;							{  Finder calls AEProcessAppleEvent  }
	gestaltOSLCompliantFinder	= 3;							{  Finder is scriptable and recordable  }
	gestaltFinderSupports4GBVolumes = 4;						{  Finder correctly handles 4GB volumes  }
	gestaltFinderHasClippings	= 6;							{  Finder supports Drag Manager clipping files  }
	gestaltFinderFullDragManagerSupport = 7;					{  Finder accepts 'hfs ' flavors properly  }
	gestaltFinderFloppyRootComments = 8;						{  in MacOS 8 and later, will be set if Finder ever supports comments on Floppy icons  }
	gestaltFinderLargeAndNotSavedFlavorsOK = 9;					{  in MacOS 8 and later, this bit is set if drags with >1024-byte flavors and flavorNotSaved flavors work reliably  }
	gestaltFinderUsesExtensibleFolderManager = 10;				{  Finder uses Extensible Folder Manager (for example, for Magic Routing)  }
	gestaltFinderUnderstandsRedirectedDesktopFolder = 11;		{  Finder deals with startup disk's desktop folder residing on another disk  }

	gestaltFindFolderAttr		= 'fold';						{  Folder Mgr attributes  }
	gestaltFindFolderPresent	= 0;							{  True if Folder Mgr present  }
	gestaltFolderDescSupport	= 1;							{  True if Folder Mgr has FolderDesc calls  }
	gestaltFolderMgrFollowsAliasesWhenResolving = 2;			{  True if Folder Mgr follows folder aliases  }
	gestaltFolderMgrSupportsExtendedCalls = 3;					{  True if Folder Mgr supports the Extended calls  }
	gestaltFolderMgrSupportsDomains = 4;						{  True if Folder Mgr supports domains for the first parameter to FindFolder  }
	gestaltFolderMgrSupportsFSCalls = 5;						{  True if FOlder manager supports __FindFolderFSRef & __FindFolderExtendedFSRef  }

	gestaltFindFolderRedirectionAttr = 'fole';


	gestaltFontMgrAttr			= 'font';						{  Font Mgr attributes  }
	gestaltOutlineFonts			= 0;							{  True if Outline Fonts supported  }

	gestaltFPUType				= 'fpu ';						{  fpu type  }
	gestaltNoFPU				= 0;							{  no FPU  }
	gestalt68881				= 1;							{  68881 FPU  }
	gestalt68882				= 2;							{  68882 FPU  }
	gestalt68040FPU				= 3;							{  68040 built-in FPU  }

	gestaltFSAttr				= 'fs  ';						{  file system attributes  }
	gestaltFullExtFSDispatching	= 0;							{  has really cool new HFSDispatch dispatcher  }
	gestaltHasFSSpecCalls		= 1;							{  has FSSpec calls  }
	gestaltHasFileSystemManager	= 2;							{  has a file system manager  }
	gestaltFSMDoesDynamicLoad	= 3;							{  file system manager supports dynamic loading  }
	gestaltFSSupports4GBVols	= 4;							{  file system supports 4 gigabyte volumes  }
	gestaltFSSupports2TBVols	= 5;							{  file system supports 2 terabyte volumes  }
	gestaltHasExtendedDiskInit	= 6;							{  has extended Disk Initialization calls  }
	gestaltDTMgrSupportsFSM		= 7;							{  Desktop Manager support FSM-based foreign file systems  }
	gestaltFSNoMFSVols			= 8;							{  file system doesn't supports MFS volumes  }
	gestaltFSSupportsHFSPlusVols = 9;							{  file system supports HFS Plus volumes  }
	gestaltFSIncompatibleDFA82	= 10;							{  VCB and FCB structures changed; DFA 8.2 is incompatible  }

	gestaltHasHFSPlusAPIs		= 12;							{  file system supports HFS Plus APIs  }
	gestaltMustUseFCBAccessors	= 13;							{  FCBSPtr and FSFCBLen are invalid - must use FSM FCB accessor functions }
	gestaltFSUsesPOSIXPathsForConversion = 14;					{  The path interchange routines operate on POSIX paths instead of HFS paths  }

	gestaltAdminFeaturesFlagsAttr = 'fred';						{  a set of admin flags, mostly useful internally.  }
	gestaltFinderUsesSpecialOpenFoldersFile = 0;				{  the Finder uses a special file to store the list of open folders  }

	gestaltFSMVersion			= 'fsm ';						{  returns version of HFS External File Systems Manager (FSM)  }

	gestaltFXfrMgrAttr			= 'fxfr';						{  file transfer manager attributes  }
	gestaltFXfrMgrPresent		= 0;
	gestaltFXfrMgrMultiFile		= 1;							{  supports FTSend and FTReceive  }
	gestaltFXfrMgrErrorString	= 2;							{  supports FTGetErrorString  }
	gestaltFXfrMgrAsync			= 3;							{ supports FTSendAsync, FTReceiveAsync, FTCompletionAsync }

	gestaltGraphicsAttr			= 'gfxa';						{  Quickdraw GX attributes selector  }
	gestaltGraphicsIsDebugging	= $00000001;
	gestaltGraphicsIsLoaded		= $00000002;
	gestaltGraphicsIsPowerPC	= $00000004;

	gestaltGraphicsVersion		= 'grfx';						{  Quickdraw GX version selector  }
	gestaltCurrentGraphicsVersion = $00010200;					{  the version described in this set of headers  }

	gestaltHardwareAttr			= 'hdwr';						{  hardware attributes  }
	gestaltHasVIA1				= 0;							{  VIA1 exists  }
	gestaltHasVIA2				= 1;							{  VIA2 exists  }
	gestaltHasASC				= 3;							{  Apple Sound Chip exists  }
	gestaltHasSCC				= 4;							{  SCC exists  }
	gestaltHasSCSI				= 7;							{  SCSI exists  }
	gestaltHasSoftPowerOff		= 19;							{  Capable of software power off  }
	gestaltHasSCSI961			= 21;							{  53C96 SCSI controller on internal bus  }
	gestaltHasSCSI962			= 22;							{  53C96 SCSI controller on external bus  }
	gestaltHasUniversalROM		= 24;							{  Do we have a Universal ROM?  }
	gestaltHasEnhancedLtalk		= 30;							{  Do we have Enhanced LocalTalk?  }

	gestaltHelpMgrAttr			= 'help';						{  Help Mgr Attributes  }
	gestaltHelpMgrPresent		= 0;							{  true if help mgr is present  }
	gestaltHelpMgrExtensions	= 1;							{  true if help mgr extensions are installed  }
	gestaltAppleGuideIsDebug	= 30;
	gestaltAppleGuidePresent	= 31;							{  true if AppleGuide is installed  }

	gestaltHardwareVendorCode	= 'hrad';						{  Returns hardware vendor information  }
	gestaltHardwareVendorApple	= 'Appl';						{  Hardware built by Apple  }

	gestaltCompressionMgr		= 'icmp';						{  returns version of the Image Compression Manager  }

	gestaltIconUtilitiesAttr	= 'icon';						{  Icon Utilities attributes  (Note: available in System 7.0, despite gestalt)  }
	gestaltIconUtilitiesPresent	= 0;							{  true if icon utilities are present  }
	gestaltIconUtilitiesHas48PixelIcons = 1;					{  true if 48x48 icons are supported by IconUtilities  }
	gestaltIconUtilitiesHas32BitIcons = 2;						{  true if 32-bit deep icons are supported  }
	gestaltIconUtilitiesHas8BitDeepMasks = 3;					{  true if 8-bit deep masks are supported  }
	gestaltIconUtilitiesHasIconServices = 4;					{  true if IconServices is present  }

	gestaltInternalDisplay		= 'idsp';						{  slot number of internal display location  }

	{	
	    To obtain information about the connected keyboard(s), one should
	    use the ADB Manager API.  See Technical Note OV16 for details.
		}
	gestaltKeyboardType			= 'kbd ';						{  keyboard type  }
	gestaltMacKbd				= 1;
	gestaltMacAndPad			= 2;
	gestaltMacPlusKbd			= 3;
	gestaltExtADBKbd			= 4;
	gestaltStdADBKbd			= 5;
	gestaltPrtblADBKbd			= 6;
	gestaltPrtblISOKbd			= 7;
	gestaltStdISOADBKbd			= 8;
	gestaltExtISOADBKbd			= 9;
	gestaltADBKbdII				= 10;
	gestaltADBISOKbdII			= 11;
	gestaltPwrBookADBKbd		= 12;
	gestaltPwrBookISOADBKbd		= 13;
	gestaltAppleAdjustKeypad	= 14;
	gestaltAppleAdjustADBKbd	= 15;
	gestaltAppleAdjustISOKbd	= 16;
	gestaltJapanAdjustADBKbd	= 17;							{  Japan Adjustable Keyboard  }
	gestaltPwrBkExtISOKbd		= 20;							{  PowerBook Extended International Keyboard with function keys  }
	gestaltPwrBkExtJISKbd		= 21;							{  PowerBook Extended Japanese Keyboard with function keys       }
	gestaltPwrBkExtADBKbd		= 24;							{  PowerBook Extended Domestic Keyboard with function keys       }
	gestaltPS2Keyboard			= 27;							{  PS2 keyboard  }
	gestaltPwrBkSubDomKbd		= 28;							{  PowerBook Subnote Domestic Keyboard with function keys w/  inverted T   }
	gestaltPwrBkSubISOKbd		= 29;							{  PowerBook Subnote International Keyboard with function keys w/  inverted T      }
	gestaltPwrBkSubJISKbd		= 30;							{  PowerBook Subnote Japanese Keyboard with function keys w/ inverted T     }
	gestaltPwrBkEKDomKbd		= 195;							{  (0xC3) PowerBook Domestic Keyboard with Embedded Keypad, function keys & inverted T     }
	gestaltPwrBkEKISOKbd		= 196;							{  (0xC4) PowerBook International Keyboard with Embedded Keypad, function keys & inverted T    }
	gestaltPwrBkEKJISKbd		= 197;							{  (0xC5) PowerBook Japanese Keyboard with Embedded Keypad, function keys & inverted T       }
	gestaltUSBCosmoANSIKbd		= 198;							{  (0xC6) original USB Domestic (ANSI) Keyboard  }
	gestaltUSBCosmoISOKbd		= 199;							{  (0xC7) original USB International (ISO) Keyboard  }
	gestaltUSBCosmoJISKbd		= 200;							{  (0xC8) original USB Japanese (JIS) Keyboard  }
	gestaltPwrBk99JISKbd		= 201;							{  (0xC9) '99 PowerBook JIS Keyboard with Embedded Keypad, function keys & inverted T                }
	gestaltUSBAndyANSIKbd		= 204;							{  (0xCC) USB Pro Keyboard Domestic (ANSI) Keyboard                                  }
	gestaltUSBAndyISOKbd		= 205;							{  (0xCD) USB Pro Keyboard International (ISO) Keyboard                                }
	gestaltUSBAndyJISKbd		= 206;							{  (0xCE) USB Pro Keyboard Japanese (JIS) Keyboard                                     }


	{
	    This gestalt indicates the highest UDF version that the active UDF implementation supports.
	    The value should be assembled from a read version (upper word) and a write version (lower word)
	}
	gestaltUDFSupport			= 'kudf';						{     Used for communication between UDF implementations }

	gestaltLowMemorySize		= 'lmem';						{  size of low memory area  }

	gestaltLogicalRAMSize		= 'lram';						{  logical ram size  }

	{	
	    MACHINE TYPE CONSTANTS NAMING CONVENTION
	
	        All future machine type constant names take the following form:
	
	            gestalt<lineName><modelNumber>
	
	    Line Names
	
	        The following table contains the lines currently produced by Apple and the
	        lineName substrings associated with them:
	
	            Line                        lineName
	            -------------------------   ------------
	            Macintosh LC                "MacLC"
	            Macintosh Performa          "Performa"
	            Macintosh PowerBook         "PowerBook"
	            Macintosh PowerBook Duo     "PowerBookDuo"
	            Power Macintosh             "PowerMac"
	            Apple Workgroup Server      "AWS"
	
	        The following table contains lineNames for some discontinued lines:
	
	            Line                        lineName
	            -------------------------   ------------
	            Macintosh Quadra            "MacQuadra" (preferred)
	                                        "Quadra" (also used, but not preferred)
	            Macintosh Centris           "MacCentris"
	
	    Model Numbers
	
	        The modelNumber is a string representing the specific model of the machine
	        within its particular line.  For example, for the Power Macintosh 8100/80,
	        the modelNumber is "8100".
	
	        Some Performa & LC model numbers contain variations in the rightmost 1 or 2
	        digits to indicate different RAM and Hard Disk configurations.  A single
	        machine type is assigned for all variations of a specific model number.  In
	        this case, the modelNumber string consists of the constant leftmost part
	        of the model number with 0s for the variant digits.  For example, the
	        Performa 6115 and Performa 6116 are both return the same machine type
	        constant:  gestaltPerforma6100.
	
	
	    OLD NAMING CONVENTIONS
	
	    The "Underscore Speed" suffix
	
	        In the past, Apple differentiated between machines that had the same model
	        number but different speeds.  For example, the Power Macintosh 8100/80 and
	        Power Macintosh 8100/100 return different machine type constants.  This is
	        why some existing machine type constant names take the form:
	
	            gestalt<lineName><modelNumber>_<speed>
	
	        e.g.
	
	            gestaltPowerMac8100_110
	            gestaltPowerMac7100_80
	            gestaltPowerMac7100_66
	
	        It is no longer necessary to use the "underscore speed" suffix.  Starting with
	        the Power Surge machines (Power Macintosh 7200, 7500, 8500 and 9500), speed is
	        no longer used to differentiate between machine types.  This is why a Power
	        Macintosh 7200/75 and a Power Macintosh 7200/90 return the same machine type
	        constant:  gestaltPowerMac7200.
	
	    The "Screen Type" suffix
	
	        All PowerBook models prior to the PowerBook 190, and all PowerBook Duo models
	        before the PowerBook Duo 2300 take the form:
	
	            gestalt<lineName><modelNumber><screenType>
	
	        Where <screenType> is "c" or the empty string.
	
	        e.g.
	
	            gestaltPowerBook100
	            gestaltPowerBookDuo280
	            gestaltPowerBookDuo280c
	            gestaltPowerBook180
	            gestaltPowerBook180c
	
	        Starting with the PowerBook 190 series and the PowerBook Duo 2300 series, machine
	        types are no longer differentiated based on screen type.  This is why a PowerBook
	        5300cs/100 and a PowerBook 5300c/100 both return the same machine type constant:
	        gestaltPowerBook5300.
	
	        Macintosh LC 630                gestaltMacLC630
	        Macintosh Performa 6200         gestaltPerforma6200
	        Macintosh Quadra 700            gestaltQuadra700
	        Macintosh PowerBook 5300        gestaltPowerBook5300
	        Macintosh PowerBook Duo 2300    gestaltPowerBookDuo2300
	        Power Macintosh 8500            gestaltPowerMac8500
		}

	gestaltMachineType			= 'mach';						{  machine type  }
	gestaltClassic				= 1;
	gestaltMacXL				= 2;
	gestaltMac512KE				= 3;
	gestaltMacPlus				= 4;
	gestaltMacSE				= 5;
	gestaltMacII				= 6;
	gestaltMacIIx				= 7;
	gestaltMacIIcx				= 8;
	gestaltMacSE030				= 9;
	gestaltPortable				= 10;
	gestaltMacIIci				= 11;
	gestaltPowerMac8100_120		= 12;
	gestaltMacIIfx				= 13;
	gestaltMacClassic			= 17;
	gestaltMacIIsi				= 18;
	gestaltMacLC				= 19;
	gestaltMacQuadra900			= 20;
	gestaltPowerBook170			= 21;
	gestaltMacQuadra700			= 22;
	gestaltClassicII			= 23;
	gestaltPowerBook100			= 24;
	gestaltPowerBook140			= 25;
	gestaltMacQuadra950			= 26;
	gestaltMacLCIII				= 27;
	gestaltPerforma450			= 27;
	gestaltPowerBookDuo210		= 29;
	gestaltMacCentris650		= 30;
	gestaltPowerBookDuo230		= 32;
	gestaltPowerBook180			= 33;
	gestaltPowerBook160			= 34;
	gestaltMacQuadra800			= 35;
	gestaltMacQuadra650			= 36;
	gestaltMacLCII				= 37;
	gestaltPowerBookDuo250		= 38;
	gestaltAWS9150_80			= 39;
	gestaltPowerMac8100_110		= 40;
	gestaltAWS8150_110			= 40;
	gestaltPowerMac5200			= 41;
	gestaltPowerMac5260			= 41;
	gestaltPerforma5300			= 41;
	gestaltPowerMac6200			= 42;
	gestaltPerforma6300			= 42;
	gestaltMacIIvi				= 44;
	gestaltMacIIvm				= 45;
	gestaltPerforma600			= 45;
	gestaltPowerMac7100_80		= 47;
	gestaltMacIIvx				= 48;
	gestaltMacColorClassic		= 49;
	gestaltPerforma250			= 49;
	gestaltPowerBook165c		= 50;
	gestaltMacCentris610		= 52;
	gestaltMacQuadra610			= 53;
	gestaltPowerBook145			= 54;
	gestaltPowerMac8100_100		= 55;
	gestaltMacLC520				= 56;
	gestaltAWS9150_120			= 57;
	gestaltPowerMac6400			= 58;
	gestaltPerforma6400			= 58;
	gestaltPerforma6360			= 58;
	gestaltMacCentris660AV		= 60;
	gestaltMacQuadra660AV		= 60;
	gestaltPerforma46x			= 62;
	gestaltPowerMac8100_80		= 65;
	gestaltAWS8150_80			= 65;
	gestaltPowerMac9500			= 67;
	gestaltPowerMac9600			= 67;
	gestaltPowerMac7500			= 68;
	gestaltPowerMac7600			= 68;
	gestaltPowerMac8500			= 69;
	gestaltPowerMac8600			= 69;
	gestaltAWS8550				= 68;
	gestaltPowerBook180c		= 71;
	gestaltPowerBook520			= 72;
	gestaltPowerBook520c		= 72;
	gestaltPowerBook540			= 72;
	gestaltPowerBook540c		= 72;
	gestaltPowerMac5400			= 74;
	gestaltPowerMac6100_60		= 75;
	gestaltAWS6150_60			= 75;
	gestaltPowerBookDuo270c		= 77;
	gestaltMacQuadra840AV		= 78;
	gestaltPerforma550			= 80;
	gestaltPowerBook165			= 84;
	gestaltPowerBook190			= 85;
	gestaltMacTV				= 88;
	gestaltMacLC475				= 89;
	gestaltPerforma47x			= 89;
	gestaltMacLC575				= 92;
	gestaltMacQuadra605			= 94;
	gestaltMacQuadra630			= 98;
	gestaltMacLC580				= 99;
	gestaltPerforma580			= 99;
	gestaltPowerMac6100_66		= 100;
	gestaltAWS6150_66			= 100;
	gestaltPowerBookDuo280		= 102;
	gestaltPowerBookDuo280c		= 103;
	gestaltPowerMacLC475		= 104;							{  Mac LC 475 & PPC Processor Upgrade Card }
	gestaltPowerMacPerforma47x	= 104;
	gestaltPowerMacLC575		= 105;							{  Mac LC 575 & PPC Processor Upgrade Card  }
	gestaltPowerMacPerforma57x	= 105;
	gestaltPowerMacQuadra630	= 106;							{  Quadra 630 & PPC Processor Upgrade Card }
	gestaltPowerMacLC630		= 106;							{  Mac LC 630 & PPC Processor Upgrade Card }
	gestaltPowerMacPerforma63x	= 106;							{  Performa 63x & PPC Processor Upgrade Card }
	gestaltPowerMac7200			= 108;
	gestaltPowerMac7300			= 109;
	gestaltPowerMac7100_66		= 112;
	gestaltPowerBook150			= 115;
	gestaltPowerMacQuadra700	= 116;							{  Quadra 700 & Power PC Upgrade Card }
	gestaltPowerMacQuadra900	= 117;							{  Quadra 900 & Power PC Upgrade Card  }
	gestaltPowerMacQuadra950	= 118;							{  Quadra 950 & Power PC Upgrade Card  }
	gestaltPowerMacCentris610	= 119;							{  Centris 610 & Power PC Upgrade Card  }
	gestaltPowerMacCentris650	= 120;							{  Centris 650 & Power PC Upgrade Card  }
	gestaltPowerMacQuadra610	= 121;							{  Quadra 610 & Power PC Upgrade Card  }
	gestaltPowerMacQuadra650	= 122;							{  Quadra 650 & Power PC Upgrade Card  }
	gestaltPowerMacQuadra800	= 123;							{  Quadra 800 & Power PC Upgrade Card  }
	gestaltPowerBookDuo2300		= 124;
	gestaltPowerBook500PPCUpgrade = 126;
	gestaltPowerBook5300		= 128;
	gestaltPowerBook1400		= 310;
	gestaltPowerBook3400		= 306;
	gestaltPowerBook2400		= 307;
	gestaltPowerBookG3Series	= 312;
	gestaltPowerBookG3			= 313;
	gestaltPowerBookG3Series2	= 314;
	gestaltPowerMacNewWorld		= 406;							{  All NewWorld architecture Macs (iMac, blue G3, etc.) }
	gestaltPowerMacG3			= 510;
	gestaltPowerMac5500			= 512;
	gestalt20thAnniversary		= 512;
	gestaltPowerMac6500			= 513;
	gestaltPowerMac4400_160		= 514;							{  slower machine has different machine ID }
	gestaltPowerMac4400			= 515;
	gestaltMacOSCompatibility	= 1206;							{     Mac OS Compatibility on Mac OS X (Classic) }


	gestaltQuadra605			= 94;
	gestaltQuadra610			= 53;
	gestaltQuadra630			= 98;
	gestaltQuadra650			= 36;
	gestaltQuadra660AV			= 60;
	gestaltQuadra700			= 22;
	gestaltQuadra800			= 35;
	gestaltQuadra840AV			= 78;
	gestaltQuadra900			= 20;
	gestaltQuadra950			= 26;

	kMachineNameStrID			= -16395;

	gestaltSMPMailerVersion		= 'malr';						{  OCE StandardMail }

	gestaltMediaBay				= 'mbeh';						{  media bay driver type  }
	gestaltMBLegacy				= 0;							{  media bay support in PCCard 2.0  }
	gestaltMBSingleBay			= 1;							{  single bay media bay driver  }
	gestaltMBMultipleBays		= 2;							{  multi-bay media bay driver  }

	gestaltMessageMgrVersion	= 'mess';						{  GX Printing Message Manager Gestalt Selector  }


	{   Menu Manager Gestalt (Mac OS 8.5 and later) }
	gestaltMenuMgrAttr			= 'menu';						{  If this Gestalt exists, the Mac OS 8.5 Menu Manager is installed  }
	gestaltMenuMgrPresent		= $00000001;					{  NOTE: this is a bit mask, whereas all other Gestalt constants of this nature  }
																{  are bit index values. 3.2 interfaces slipped out with this mistake unnoticed.  }
																{  Sincere apologies for any inconvenience. }
	gestaltMenuMgrPresentBit	= 0;							{  bit number  }
	gestaltMenuMgrAquaLayoutBit	= 1;							{  menus have the Aqua 1.0 layout }
	gestaltMenuMgrMultipleItemsWithCommandIDBit = 2;			{  CountMenuItemsWithCommandID/GetIndMenuItemWithCommandID support multiple items with the same command ID }
	gestaltMenuMgrRetainsIconRefBit = 3;						{  SetMenuItemIconHandle, when passed an IconRef, calls AcquireIconRef }
	gestaltMenuMgrSendsMenuBoundsToDefProcBit = 4;				{  kMenuSizeMsg and kMenuPopUpMsg have menu bounding rect information }
																{  masks for the above bits }
	gestaltMenuMgrPresentMask	= $00000001;
	gestaltMenuMgrAquaLayoutMask = $00000002;
	gestaltMenuMgrMultipleItemsWithCommandIDMask = $00000004;
	gestaltMenuMgrRetainsIconRefMask = $00000008;
	gestaltMenuMgrSendsMenuBoundsToDefProcMask = $00000010;


	gestaltMultipleUsersState	= 'mfdr';						{  Gestalt selector returns MultiUserGestaltHandle (in Folders.h) }


	gestaltMachineIcon			= 'micn';						{  machine icon  }

	gestaltMiscAttr				= 'misc';						{  miscellaneous attributes  }
	gestaltScrollingThrottle	= 0;							{  true if scrolling throttle on  }
	gestaltSquareMenuBar		= 2;							{  true if menu bar is square  }


	{	
	    The name gestaltMixedModeVersion for the 'mixd' selector is semantically incorrect.
	    The same selector has been renamed gestaltMixedModeAttr to properly reflect the
	    Inside Mac: PowerPC System Software documentation.  The gestaltMixedModeVersion
	    symbol has been preserved only for backwards compatibility.
	
	    Developers are forewarned that gestaltMixedModeVersion has a limited lifespan and
	    will be removed in a future release of the Interfaces.
	
	    For the first version of Mixed Mode, both meanings of the 'mixd' selector are
	    functionally identical.  They both return 0x00000001.  In subsequent versions
	    of Mixed Mode, however, the 'mixd' selector will not respond with an increasing
	    version number, but rather, with 32 attribute bits with various meanings.
		}
	gestaltMixedModeVersion		= 'mixd';						{  returns version of Mixed Mode  }

	gestaltMixedModeAttr		= 'mixd';						{  returns Mixed Mode attributes  }
	gestaltMixedModePowerPC		= 0;							{  true if Mixed Mode supports PowerPC ABI calling conventions  }
	gestaltPowerPCAware			= 0;							{  old name for gestaltMixedModePowerPC  }
	gestaltMixedModeCFM68K		= 1;							{  true if Mixed Mode supports CFM-68K calling conventions  }
	gestaltMixedModeCFM68KHasTrap = 2;							{  true if CFM-68K Mixed Mode implements _MixedModeDispatch (versions 1.0.1 and prior did not)  }
	gestaltMixedModeCFM68KHasState = 3;							{  true if CFM-68K Mixed Mode exports Save/RestoreMixedModeState  }

	gestaltQuickTimeConferencing = 'mtlk';						{  returns QuickTime Conferencing version  }

	gestaltMemoryMapAttr		= 'mmap';						{  Memory map type  }
	gestaltMemoryMapSparse		= 0;							{  Sparse memory is on  }

	gestaltMMUType				= 'mmu ';						{  mmu type  }
	gestaltNoMMU				= 0;							{  no MMU  }
	gestaltAMU					= 1;							{  address management unit  }
	gestalt68851				= 2;							{  68851 PMMU  }
	gestalt68030MMU				= 3;							{  68030 built-in MMU  }
	gestalt68040MMU				= 4;							{  68040 built-in MMU  }
	gestaltEMMU1				= 5;							{  Emulated MMU type 1   }

	gestaltUserVisibleMachineName = 'mnam';						{  Coerce response into a StringPtr to get a user visible machine name  }

	gestaltMPCallableAPIsAttr	= 'mpsc';						{  Bitmap of toolbox/OS managers that can be called from MPLibrary MPTasks  }
	gestaltMPFileManager		= 0;							{  True if File Manager calls can be made from MPTasks  }
	gestaltMPDeviceManager		= 1;							{  True if synchronous Device Manager calls can be made from MPTasks  }
	gestaltMPTrapCalls			= 2;							{  True if most trap-based calls can be made from MPTasks  }

	gestaltStdNBPAttr			= 'nlup';						{  standard nbp attributes  }
	gestaltStdNBPPresent		= 0;
	gestaltStdNBPSupportsAutoPosition = 1;						{  StandardNBP takes (-1,-1) to mean alert position main screen  }

	gestaltNotificationMgrAttr	= 'nmgr';						{  notification manager attributes  }
	gestaltNotificationPresent	= 0;							{  notification manager exists  }

	gestaltNameRegistryVersion	= 'nreg';						{  NameRegistryLib version number, for System 7.5.2+ usage  }

	gestaltNuBusSlotCount		= 'nubs';						{  count of logical NuBus slots present  }

	gestaltOCEToolboxVersion	= 'ocet';						{  OCE Toolbox version  }
	gestaltOCETB				= $0102;						{  OCE Toolbox version 1.02  }
	gestaltSFServer				= $0100;						{  S&F Server version 1.0  }

	gestaltOCEToolboxAttr		= 'oceu';						{  OCE Toolbox attributes  }
	gestaltOCETBPresent			= $01;							{  OCE toolbox is present, not running  }
	gestaltOCETBAvailable		= $02;							{  OCE toolbox is running and available  }
	gestaltOCESFServerAvailable	= $04;							{  S&F Server is running and available  }
	gestaltOCETBNativeGlueAvailable = $10;						{  Native PowerPC Glue routines are availible  }

	gestaltOpenFirmwareInfo		= 'opfw';						{  Open Firmware info  }

	gestaltOSAttr				= 'os  ';						{  o/s attributes  }
	gestaltSysZoneGrowable		= 0;							{  system heap is growable  }
	gestaltLaunchCanReturn		= 1;							{  can return from launch  }
	gestaltLaunchFullFileSpec	= 2;							{  can launch from full file spec  }
	gestaltLaunchControl		= 3;							{  launch control support available  }
	gestaltTempMemSupport		= 4;							{  temp memory support  }
	gestaltRealTempMemory		= 5;							{  temp memory handles are real  }
	gestaltTempMemTracked		= 6;							{  temporary memory handles are tracked  }
	gestaltIPCSupport			= 7;							{  IPC support is present  }
	gestaltSysDebuggerSupport	= 8;							{  system debugger support is present  }
	gestaltNativeProcessMgrBit	= 19;							{  the process manager itself is native  }

	gestaltOSTable				= 'ostt';						{   OS trap table base   }


	{	******************************************************************************
	*   Gestalt Selectors for Open Transport Network Setup
	*
	*   Note: possible values for the version "stage" byte are:
	*   development = 0x20, alpha = 0x40, beta = 0x60, final & release = 0x80
	*******************************************************************************	}
	gestaltOpenTptNetworkSetup	= 'otcf';
	gestaltOpenTptNetworkSetupLegacyImport = 0;
	gestaltOpenTptNetworkSetupLegacyExport = 1;
	gestaltOpenTptNetworkSetupSupportsMultihoming = 2;

	gestaltOpenTptNetworkSetupVersion = 'otcv';

	{	******************************************************************************
	*   Gestalt Selectors for Open Transport-based Remote Access/PPP
	*
	*   Note: possible values for the version "stage" byte are:
	*   development = 0x20, alpha = 0x40, beta = 0x60, final & release = 0x80
	*******************************************************************************	}
	gestaltOpenTptRemoteAccess	= 'otra';
	gestaltOpenTptRemoteAccessPresent = 0;
	gestaltOpenTptRemoteAccessLoaded = 1;
	gestaltOpenTptRemoteAccessClientOnly = 2;
	gestaltOpenTptRemoteAccessPServer = 3;
	gestaltOpenTptRemoteAccessMPServer = 4;
	gestaltOpenTptPPPPresent	= 5;
	gestaltOpenTptARAPPresent	= 6;

	gestaltOpenTptRemoteAccessVersion = 'otrv';


	{  ***** Open Transport Gestalt ***** }


	gestaltOpenTptVersions		= 'otvr';						{  Defined by OT 1.1 and higher, response is NumVersion. }

	gestaltOpenTpt				= 'otan';						{  Defined by all versions, response is defined below. }
	gestaltOpenTptPresentMask	= $00000001;
	gestaltOpenTptLoadedMask	= $00000002;
	gestaltOpenTptAppleTalkPresentMask = $00000004;
	gestaltOpenTptAppleTalkLoadedMask = $00000008;
	gestaltOpenTptTCPPresentMask = $00000010;
	gestaltOpenTptTCPLoadedMask	= $00000020;
	gestaltOpenTptIPXSPXPresentMask = $00000040;
	gestaltOpenTptIPXSPXLoadedMask = $00000080;
	gestaltOpenTptPresentBit	= 0;
	gestaltOpenTptLoadedBit		= 1;
	gestaltOpenTptAppleTalkPresentBit = 2;
	gestaltOpenTptAppleTalkLoadedBit = 3;
	gestaltOpenTptTCPPresentBit	= 4;
	gestaltOpenTptTCPLoadedBit	= 5;
	gestaltOpenTptIPXSPXPresentBit = 6;
	gestaltOpenTptIPXSPXLoadedBit = 7;


	gestaltPCCard				= 'pccd';						{     PC Card attributes }
	gestaltCardServicesPresent	= 0;							{     PC Card 2.0 (68K) API is present }
	gestaltPCCardFamilyPresent	= 1;							{     PC Card 3.x (PowerPC) API is present }
	gestaltPCCardHasPowerControl = 2;							{     PCCardSetPowerLevel is supported }
	gestaltPCCardSupportsCardBus = 3;							{     CardBus is supported }

	gestaltProcClkSpeed			= 'pclk';						{  processor clock speed in hertz  }

	gestaltPCXAttr				= 'pcxg';						{  PC Exchange attributes  }
	gestaltPCXHas8and16BitFAT	= 0;							{  PC Exchange supports both 8 and 16 bit FATs  }
	gestaltPCXHasProDOS			= 1;							{  PC Exchange supports ProDOS  }
	gestaltPCXNewUI				= 2;
	gestaltPCXUseICMapping		= 3;							{  PC Exchange uses InternetConfig for file mappings  }

	gestaltLogicalPageSize		= 'pgsz';						{  logical page size  }

	{	    System 7.6 and later.  If gestaltScreenCaptureMain is not implemented,
	    PictWhap proceeds with screen capture in the usual way.
	
	    The high word of gestaltScreenCaptureMain is reserved (use 0).
	
	    To disable screen capture to disk, put zero in the low word.  To
	    specify a folder for captured pictures, put the vRefNum in the
	    low word of gestaltScreenCaptureMain, and put the directory ID in
	    gestaltScreenCaptureDir.
		}
	gestaltScreenCaptureMain	= 'pic1';						{  Zero, or vRefNum of disk to hold picture  }
	gestaltScreenCaptureDir		= 'pic2';						{  Directory ID of folder to hold picture  }

	gestaltGXPrintingMgrVersion	= 'pmgr';						{  QuickDraw GX Printing Manager Version }

	gestaltPopupAttr			= 'pop!';						{  popup cdef attributes  }
	gestaltPopupPresent			= 0;

	gestaltPowerMgrAttr			= 'powr';						{  power manager attributes  }
	gestaltPMgrExists			= 0;
	gestaltPMgrCPUIdle			= 1;
	gestaltPMgrSCC				= 2;
	gestaltPMgrSound			= 3;
	gestaltPMgrDispatchExists	= 4;
	gestaltPMgrSupportsAVPowerStateAtSleepWake = 5;

	gestaltPowerMgrVers			= 'pwrv';						{  power manager version  }

	{	
	 * PPC will return the combination of following bit fields.
	 * e.g. gestaltPPCSupportsRealTime +gestaltPPCSupportsIncoming + gestaltPPCSupportsOutGoing
	 * indicates PPC is cuurently is only supports real time delivery
	 * and both incoming and outgoing network sessions are allowed.
	 * By default local real time delivery is supported as long as PPCInit has been called.	}
	gestaltPPCToolboxAttr		= 'ppc ';						{  PPC toolbox attributes  }
	gestaltPPCToolboxPresent	= $0000;						{  PPC Toolbox is present  Requires PPCInit to be called  }
	gestaltPPCSupportsRealTime	= $1000;						{  PPC Supports real-time delivery  }
	gestaltPPCSupportsIncoming	= $0001;						{  PPC will allow incoming network requests  }
	gestaltPPCSupportsOutGoing	= $0002;						{  PPC will allow outgoing network requests  }
	gestaltPPCSupportsTCP_IP	= $0004;						{  PPC supports TCP/IP transport   }
	gestaltPPCSupportsIncomingAppleTalk = $0010;
	gestaltPPCSupportsIncomingTCP_IP = $0020;
	gestaltPPCSupportsOutgoingAppleTalk = $0100;
	gestaltPPCSupportsOutgoingTCP_IP = $0200;

	gestaltPowerPCProcessorFeatures = 'ppcf';					{  Optional PowerPC processor features  }
	gestaltPowerPCHasGraphicsInstructions = 0;					{  has fres, frsqrte, and fsel instructions  }
	gestaltPowerPCHasSTFIWXInstruction = 1;						{  has stfiwx instruction  }
	gestaltPowerPCHasSquareRootInstructions = 2;				{  has fsqrt and fsqrts instructions  }
	gestaltPowerPCHasDCBAInstruction = 3;						{  has dcba instruction  }
	gestaltPowerPCHasVectorInstructions = 4;					{  has vector instructions  }
	gestaltPowerPCHasDataStreams = 5;							{  has dst, dstt, dstst, dss, and dssall instructions  }

	gestaltProcessorType		= 'proc';						{  processor type  }
	gestalt68000				= 1;
	gestalt68010				= 2;
	gestalt68020				= 3;
	gestalt68030				= 4;
	gestalt68040				= 5;

	gestaltSDPPromptVersion		= 'prpv';						{  OCE Standard Directory Panel }

	gestaltParityAttr			= 'prty';						{  parity attributes  }
	gestaltHasParityCapability	= 0;							{  has ability to check parity  }
	gestaltParityEnabled		= 1;							{  parity checking enabled  }

	gestaltQD3DVersion			= 'q3v ';						{  Quickdraw 3D version in pack BCD }

	gestaltQD3DViewer			= 'q3vc';						{  Quickdraw 3D viewer attributes }
	gestaltQD3DViewerPresent	= 0;							{  bit 0 set if QD3D Viewer is available }

{$IFC OLDROUTINENAMES }
	gestaltQD3DViewerNotPresent	= $00;
	gestaltQD3DViewerAvailable	= $01;

{$ENDC}  {OLDROUTINENAMES}

	gestaltQuickdrawVersion		= 'qd  ';						{  quickdraw version  }
	gestaltOriginalQD			= $0000;						{  original 1-bit QD  }
	gestalt8BitQD				= $0100;						{  8-bit color QD  }
	gestalt32BitQD				= $0200;						{  32-bit color QD  }
	gestalt32BitQD11			= $0201;						{  32-bit color QDv1.1  }
	gestalt32BitQD12			= $0220;						{  32-bit color QDv1.2  }
	gestalt32BitQD13			= $0230;						{  32-bit color QDv1.3  }
	gestaltAllegroQD			= $0250;						{  Allegro QD OS 8.5  }
	gestaltMacOSXQD				= $0300;						{  Mac OS X QD  }

	gestaltQD3D					= 'qd3d';						{  Quickdraw 3D attributes }
	gestaltQD3DPresent			= 0;							{  bit 0 set if QD3D available }

{$IFC OLDROUTINENAMES }
	gestaltQD3DNotPresent		= $00;
	gestaltQD3DAvailable		= $01;

{$ENDC}  {OLDROUTINENAMES}

	gestaltGXVersion			= 'qdgx';						{  Overall QuickDraw GX Version }

	gestaltQuickdrawFeatures	= 'qdrw';						{  quickdraw features  }
	gestaltHasColor				= 0;							{  color quickdraw present  }
	gestaltHasDeepGWorlds		= 1;							{  GWorlds can be deeper than 1-bit  }
	gestaltHasDirectPixMaps		= 2;							{  PixMaps can be direct (16 or 32 bit)  }
	gestaltHasGrayishTextOr		= 3;							{  supports text mode grayishTextOr  }
	gestaltSupportsMirroring	= 4;							{  Supports video mirroring via the Display Manager.  }
	gestaltQDHasLongRowBytes	= 5;							{  Long rowBytes supported in GWorlds  }

	gestaltQDTextVersion		= 'qdtx';						{  QuickdrawText version  }
	gestaltOriginalQDText		= $0000;						{  up to and including 8.1  }
	gestaltAllegroQDText		= $0100;						{  starting with 8.5  }
	gestaltMacOSXQDText			= $0200;						{  we are in Mac OS X  }

	gestaltQDTextFeatures		= 'qdtf';						{  QuickdrawText features  }
	gestaltWSIISupport			= 0;							{  bit 0: WSII support included  }
	gestaltSbitFontSupport		= 1;							{  sbit-only fonts supported  }
	gestaltAntiAliasedTextAvailable = 2;						{  capable of antialiased text  }
	gestaltOFA2available		= 3;							{  OFA2 available  }
	gestaltCreatesAliasFontRsrc	= 4;							{  "real" datafork font support  }
	gestaltNativeType1FontSupport = 5;							{  we have scaler for Type1 fonts  }


	gestaltQuickTimeConferencingInfo = 'qtci';					{  returns pointer to QuickTime Conferencing information  }

	gestaltQuickTimeVersion		= 'qtim';						{  returns version of QuickTime  }
	gestaltQuickTime			= 'qtim';						{  gestaltQuickTime is old name for gestaltQuickTimeVersion  }

	gestaltQuickTimeFeatures	= 'qtrs';
	gestaltPPCQuickTimeLibPresent = 0;							{  PowerPC QuickTime glue library is present  }

	gestaltQuickTimeStreamingFeatures = 'qtsf';

	gestaltQuickTimeStreamingVersion = 'qtst';

	gestaltQTVRMgrAttr			= 'qtvr';						{  QuickTime VR attributes                                }
	gestaltQTVRMgrPresent		= 0;							{  QTVR API is present                                    }
	gestaltQTVRObjMoviesPresent	= 1;							{  QTVR runtime knows about object movies                 }
	gestaltQTVRCylinderPanosPresent = 2;						{  QTVR runtime knows about cylindrical panoramic movies  }
	gestaltQTVRCubicPanosPresent = 3;							{  QTVR runtime knows about cubic panoramic movies        }

	gestaltQTVRMgrVers			= 'qtvv';						{  QuickTime VR version                                   }

	gestaltPhysicalRAMSize		= 'ram ';						{  physical RAM size  }

	gestaltRBVAddr				= 'rbv ';						{  RBV base address   }

	gestaltROMSize				= 'rom ';						{  rom size  }

	gestaltROMVersion			= 'romv';						{  rom version  }

	gestaltResourceMgrAttr		= 'rsrc';						{  Resource Mgr attributes  }
	gestaltPartialRsrcs			= 0;							{  True if partial resources exist  }
	gestaltHasResourceOverrides	= 1;							{  Appears in the ROM; so put it here.  }

	gestaltResourceMgrBugFixesAttrs = 'rmbg';					{  Resource Mgr bug fixes  }
	gestaltRMForceSysHeapRolledIn = 0;
	gestaltRMFakeAppleMenuItemsRolledIn = 1;
	gestaltSanityCheckResourceFiles = 2;						{  Resource manager does sanity checking on resource files before opening them  }
	gestaltSupportsFSpResourceFileAlreadyOpenBit = 3;			{  The resource manager supports GetResFileRefNum and FSpGetResFileRefNum and FSpResourceFileAlreadyOpen  }
	gestaltRMSupportsFSCalls	= 4;							{  The resource manager supports OpenResFileFSRef, CreateResFileFSRef and  ResourceFileAlreadyOpenFSRef  }
	gestaltRMTypeIndexOrderingReverse = 8;						{  GetIndType() calls return resource types in opposite order to original 68k resource manager  }


	gestaltRealtimeMgrAttr		= 'rtmr';						{  Realtime manager attributes          }
	gestaltRealtimeMgrPresent	= 0;							{  true if the Realtime manager is present     }


	gestaltSafeOFAttr			= 'safe';
	gestaltVMZerosPagesBit		= 0;
	gestaltInitHeapZerosOutHeapsBit = 1;
	gestaltNewHandleReturnsZeroedMemoryBit = 2;
	gestaltNewPtrReturnsZeroedMemoryBit = 3;
	gestaltFileAllocationZeroedBlocksBit = 4;


	gestaltSCCReadAddr			= 'sccr';						{  scc read base address   }

	gestaltSCCWriteAddr			= 'sccw';						{  scc read base address   }

	gestaltScrapMgrAttr			= 'scra';						{  Scrap Manager attributes  }
	gestaltScrapMgrTranslationAware = 0;						{  True if scrap manager is translation aware  }

	gestaltScriptMgrVersion		= 'scri';						{  Script Manager version number      }

	gestaltScriptCount			= 'scr#';						{  number of active script systems    }

	gestaltSCSI					= 'scsi';						{  SCSI Manager attributes  }
	gestaltAsyncSCSI			= 0;							{  Supports Asynchronous SCSI  }
	gestaltAsyncSCSIINROM		= 1;							{  Async scsi is in ROM (available for booting)  }
	gestaltSCSISlotBoot			= 2;							{  ROM supports Slot-style PRAM for SCSI boots (PDM and later)  }
	gestaltSCSIPollSIH			= 3;							{  SCSI Manager will poll for interrupts if Secondary Interrupts are busy.  }

	gestaltControlStripAttr		= 'sdev';						{  Control Strip attributes  }
	gestaltControlStripExists	= 0;							{  Control Strip is installed  }
	gestaltControlStripVersionFixed = 1;						{  Control Strip version Gestalt selector was fixed  }
	gestaltControlStripUserFont	= 2;							{  supports user-selectable font/size  }
	gestaltControlStripUserHotKey = 3;							{  support user-selectable hot key to show/hide the window  }

	gestaltSDPStandardDirectoryVersion = 'sdvr';				{  OCE Standard Directory Panel }

	gestaltSerialAttr			= 'ser ';						{  Serial attributes  }
	gestaltHasGPIaToDCDa		= 0;							{  GPIa connected to DCDa }
	gestaltHasGPIaToRTxCa		= 1;							{  GPIa connected to RTxCa clock input }
	gestaltHasGPIbToDCDb		= 2;							{  GPIb connected to DCDb  }
	gestaltHidePortA			= 3;							{  Modem port (A) should be hidden from users  }
	gestaltHidePortB			= 4;							{  Printer port (B) should be hidden from users  }
	gestaltPortADisabled		= 5;							{  Modem port (A) disabled and should not be used by SW  }
	gestaltPortBDisabled		= 6;							{  Printer port (B) disabled and should not be used by SW  }

	gestaltShutdownAttributes	= 'shut';						{  ShutDown Manager Attributes  }
	gestaltShutdownHassdOnBootVolUnmount = 0;					{  True if ShutDown Manager unmounts boot & VM volume at shutdown time.  }

	gestaltNuBusConnectors		= 'sltc';						{  bitmap of NuBus connectors }

	gestaltSlotAttr				= 'slot';						{  slot attributes   }
	gestaltSlotMgrExists		= 0;							{  true is slot mgr exists   }
	gestaltNuBusPresent			= 1;							{  NuBus slots are present   }
	gestaltSESlotPresent		= 2;							{  SE PDS slot present   }
	gestaltSE30SlotPresent		= 3;							{  SE/30 slot present   }
	gestaltPortableSlotPresent	= 4;							{  Portable’s slot present   }

	gestaltFirstSlotNumber		= 'slt1';						{  returns first physical slot  }

	gestaltSoundAttr			= 'snd ';						{  sound attributes  }
	gestaltStereoCapability		= 0;							{  sound hardware has stereo capability  }
	gestaltStereoMixing			= 1;							{  stereo mixing on external speaker  }
	gestaltSoundIOMgrPresent	= 3;							{  The Sound I/O Manager is present  }
	gestaltBuiltInSoundInput	= 4;							{  built-in Sound Input hardware is present  }
	gestaltHasSoundInputDevice	= 5;							{  Sound Input device available  }
	gestaltPlayAndRecord		= 6;							{  built-in hardware can play and record simultaneously  }
	gestalt16BitSoundIO			= 7;							{  sound hardware can play and record 16-bit samples  }
	gestaltStereoInput			= 8;							{  sound hardware can record stereo  }
	gestaltLineLevelInput		= 9;							{  sound input port requires line level  }
																{  the following bits are not defined prior to Sound Mgr 3.0  }
	gestaltSndPlayDoubleBuffer	= 10;							{  SndPlayDoubleBuffer available, set by Sound Mgr 3.0 and later  }
	gestaltMultiChannels		= 11;							{  multiple channel support, set by Sound Mgr 3.0 and later  }
	gestalt16BitAudioSupport	= 12;							{  16 bit audio data supported, set by Sound Mgr 3.0 and later  }

	gestaltSplitOSAttr			= 'spos';
	gestaltSplitOSBootDriveIsNetworkVolume = 0;					{  the boot disk is a network 'disk', from the .LANDisk drive.  }
	gestaltSplitOSAware			= 1;							{  the system includes the code to deal with a split os situation.  }
	gestaltSplitOSEnablerVolumeIsDifferentFromBootVolume = 2;	{  the active enabler is on a different volume than the system file.  }
	gestaltSplitOSMachineNameSetToNetworkNameTemp = 3;			{  The machine name was set to the value given us from the BootP server  }
	gestaltSplitOSMachineNameStartupDiskIsNonPersistent = 5;	{  The startup disk ( vRefNum == -1 ) is non-persistent, meaning changes won't persist across a restart.  }

	gestaltSMPSPSendLetterVersion = 'spsl';						{  OCE StandardMail }

	gestaltSpeechRecognitionAttr = 'srta';						{  speech recognition attributes  }
	gestaltDesktopSpeechRecognition = 1;						{  recognition thru the desktop microphone is available  }
	gestaltTelephoneSpeechRecognition = 2;						{  recognition thru the telephone is available  }

	gestaltSpeechRecognitionVersion = 'srtb';					{  speech recognition version (0x0150 is the first version that fully supports the API)  }

	gestaltSoftwareVendorCode	= 'srad';						{  Returns system software vendor information  }
	gestaltSoftwareVendorApple	= 'Appl';						{  System software sold by Apple  }
	gestaltSoftwareVendorLicensee = 'Lcns';						{  System software sold by licensee  }

	gestaltStandardFileAttr		= 'stdf';						{  Standard File attributes  }
	gestaltStandardFile58		= 0;							{  True if selectors 5-8 (StandardPutFile-CustomGetFile) are supported  }
	gestaltStandardFileTranslationAware = 1;					{  True if standard file is translation manager aware  }
	gestaltStandardFileHasColorIcons = 2;						{  True if standard file has 16x16 color icons  }
	gestaltStandardFileUseGenericIcons = 3;						{  Standard file LDEF to use only the system generic icons if true  }
	gestaltStandardFileHasDynamicVolumeAllocation = 4;			{  True if standard file supports more than 20 volumes  }

	gestaltSysArchitecture		= 'sysa';						{  Native System Architecture  }
	gestalt68k					= 1;							{  Motorola MC68k architecture  }
	gestaltPowerPC				= 2;							{  IBM PowerPC architecture  }

	gestaltSystemUpdateVersion	= 'sysu';						{  System Update version  }

	gestaltSystemVersion		= 'sysv';						{  system version }

	gestaltToolboxTable			= 'tbtt';						{   OS trap table base   }

	gestaltTextEditVersion		= 'te  ';						{  TextEdit version number  }
	gestaltTE1					= 1;							{  TextEdit in MacIIci ROM  }
	gestaltTE2					= 2;							{  TextEdit with 6.0.4 Script Systems on MacIIci (Script bug fixes for MacIIci)  }
	gestaltTE3					= 3;							{  TextEdit with 6.0.4 Script Systems all but MacIIci  }
	gestaltTE4					= 4;							{  TextEdit in System 7.0  }
	gestaltTE5					= 5;							{  TextWidthHook available in TextEdit  }

	gestaltTEAttr				= 'teat';						{  TextEdit attributes  }
	gestaltTEHasGetHiliteRgn	= 0;							{  TextEdit has TEGetHiliteRgn  }
	gestaltTESupportsInlineInput = 1;							{  TextEdit does Inline Input  }
	gestaltTESupportsTextObjects = 2;							{  TextEdit does Text Objects  }
	gestaltTEHasWhiteBackground	= 3;							{  TextEdit supports overriding the TERec's background to white  }

	gestaltTeleMgrAttr			= 'tele';						{  Telephone manager attributes  }
	gestaltTeleMgrPresent		= 0;
	gestaltTeleMgrPowerPCSupport = 1;
	gestaltTeleMgrSoundStreams	= 2;
	gestaltTeleMgrAutoAnswer	= 3;
	gestaltTeleMgrIndHandset	= 4;
	gestaltTeleMgrSilenceDetect	= 5;
	gestaltTeleMgrNewTELNewSupport = 6;

	gestaltTermMgrAttr			= 'term';						{  terminal mgr attributes  }
	gestaltTermMgrPresent		= 0;
	gestaltTermMgrErrorString	= 2;

	gestaltThreadMgrAttr		= 'thds';						{  Thread Manager attributes  }
	gestaltThreadMgrPresent		= 0;							{  bit true if Thread Mgr is present  }
	gestaltSpecificMatchSupport	= 1;							{  bit true if Thread Mgr supports exact match creation option  }
	gestaltThreadsLibraryPresent = 2;							{  bit true if Thread Mgr shared library is present  }

	gestaltTimeMgrVersion		= 'tmgr';						{  time mgr version  }
	gestaltStandardTimeMgr		= 1;							{  standard time mgr is present  }
	gestaltRevisedTimeMgr		= 2;							{  revised time mgr is present  }
	gestaltExtendedTimeMgr		= 3;							{  extended time mgr is present  }
	gestaltNativeTimeMgr		= 4;							{  PowerPC native TimeMgr is present  }

	gestaltTSMTEVersion			= 'tmTV';
	gestaltTSMTE1				= $0100;						{  Original version of TSMTE  }
	gestaltTSMTE15				= $0150;						{  System 8.0  }
	gestaltTSMTE152				= $0152;						{  System 8.2  }

	gestaltTSMTEAttr			= 'tmTE';
	gestaltTSMTEPresent			= 0;
	gestaltTSMTE				= 0;							{  gestaltTSMTE is old name for gestaltTSMTEPresent  }

	gestaltAVLTreeAttr			= 'tree';						{  AVLTree utility routines attributes.  }
	gestaltAVLTreePresentBit	= 0;							{  if set, then the AVL Tree routines are available.  }

	gestaltALMAttr				= 'trip';						{  Settings Manager attributes (see also gestaltALMVers)  }
	gestaltALMPresent			= 0;							{  bit true if ALM is available  }
	gestaltALMHasSFGroup		= 1;							{  bit true if Put/Get/Merge Group calls are implmented  }
	gestaltALMHasCFMSupport		= 2;							{  bit true if CFM-based modules are supported  }
	gestaltALMHasRescanNotifiers = 3;							{  bit true if Rescan notifications/events will be sent to clients  }

	gestaltALMHasSFLocation		= 1;

	gestaltTSMgrVersion			= 'tsmv';						{  Text Services Mgr version, if present  }
	gestaltTSMgr15				= $0150;
	gestaltTSMgr20				= $0200;

	gestaltTSMgrAttr			= 'tsma';						{  Text Services Mgr attributes, if present  }
	gestaltTSMDisplayMgrAwareBit = 0;							{  TSM knows about display manager  }
	gestaltTSMdoesTSMTEBit		= 1;							{  TSM has integrated TSMTE  }

	gestaltSpeechAttr			= 'ttsc';						{  Speech Manager attributes  }
	gestaltSpeechMgrPresent		= 0;							{  bit set indicates that Speech Manager exists  }
	gestaltSpeechHasPPCGlue		= 1;							{  bit set indicates that native PPC glue for Speech Manager API exists  }

	gestaltTVAttr				= 'tv  ';						{  TV version  }
	gestaltHasTVTuner			= 0;							{  supports Philips FL1236F video tuner  }
	gestaltHasSoundFader		= 1;							{  supports Philips TEA6330 Sound Fader chip  }
	gestaltHasHWClosedCaptioning = 2;							{  supports Philips SAA5252 Closed Captioning  }
	gestaltHasIRRemote			= 3;							{  supports CyclopsII Infra Red Remote control  }
	gestaltHasVidDecoderScaler	= 4;							{  supports Philips SAA7194 Video Decoder/Scaler  }
	gestaltHasStereoDecoder		= 5;							{  supports Sony SBX1637A-01 stereo decoder  }
	gestaltHasSerialFader		= 6;							{  has fader audio in serial with system audio  }
	gestaltHasFMTuner			= 7;							{  has FM Tuner from donnybrook card  }
	gestaltHasSystemIRFunction	= 8;							{  Infra Red button function is set up by system and not by Video Startup  }
	gestaltIRDisabled			= 9;							{  Infra Red remote is not disabled.  }
	gestaltINeedIRPowerOffConfirm = 10;							{  Need IR power off confirm dialog.  }
	gestaltHasZoomedVideo		= 11;							{  Has Zoomed Video PC Card video input.  }


	gestaltATSUVersion			= 'uisv';
	gestaltOriginalATSUVersion	= $00010000;					{  ATSUI version 1.0 }
	gestaltATSUUpdate1			= $00020000;					{  ATSUI version 1.1 }
	gestaltATSUUpdate2			= $00030000;					{  ATSUI version 1.2 }
	gestaltATSUUpdate3			= $00040000;					{  ATSUI version 2.0 }
	gestaltATSUUpdate4			= $00050000;					{  ATSUI version in Mac OS 10.0.1  }
	gestaltATSUUpdate5			= $00060000;

	gestaltATSUFeatures			= 'uisf';
	gestaltATSUTrackingFeature	= $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSUMemoryFeature	= $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSUFallbacksFeature	= $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSUGlyphBoundsFeature = $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSULineControlFeature = $00000001;					{  feature introduced in ATSUI version 1.1 }
	gestaltATSULayoutCreateAndCopyFeature = $00000001;			{  feature introduced in ATSUI version 1.1 }
	gestaltATSULayoutCacheClearFeature = $00000001;				{  feature introduced in ATSUI version 1.1 }
	gestaltATSUTextLocatorUsageFeature = $00000002;				{  feature introduced in ATSUI version 1.2 }
	gestaltATSULowLevelOrigFeatures = $00000004;				{  first low-level features introduced in ATSUI version 2.0 }

	gestaltUSBAttr				= 'usb ';						{  USB Attributes  }
	gestaltUSBPresent			= 0;							{  USB Support available  }
	gestaltUSBHasIsoch			= 1;							{  USB Isochronous features available  }

	gestaltUSBVersion			= 'usbv';						{  USB version  }

	gestaltVersion				= 'vers';						{  gestalt version  }
	gestaltValueImplementedVers	= 5;							{  version of gestalt where gestaltValue is implemented.  }

	gestaltVIA1Addr				= 'via1';						{  via 1 base address   }

	gestaltVIA2Addr				= 'via2';						{  via 2 base address   }

	gestaltVMAttr				= 'vm  ';						{  virtual memory attributes  }
	gestaltVMPresent			= 0;							{  true if virtual memory is present  }
	gestaltVMHasLockMemoryForOutput = 1;						{  true if LockMemoryForOutput is available  }
	gestaltVMFilemappingOn		= 3;							{  true if filemapping is available  }
	gestaltVMHasPagingControl	= 4;							{  true if MakeMemoryResident, MakeMemoryNonResident, FlushMemory, and ReleaseMemoryData are available  }

	gestaltVMInfoType			= 'vmin';						{  Indicates how the Finder should display information about VM in  }
																{  the Finder about box.  }
	gestaltVMInfoSizeStorageType = 0;							{  Display VM on/off, backing store size and name  }
	gestaltVMInfoSizeType		= 1;							{  Display whether VM is on or off and the size of the backing store  }
	gestaltVMInfoSimpleType		= 2;							{  Display whether VM is on or off  }
	gestaltVMInfoNoneType		= 3;							{  Display no VM information  }

	gestaltVMBackingStoreFileRefNum = 'vmbs';					{  file refNum of virtual memory's main backing store file (returned in low word of result)  }



	gestaltALMVers				= 'walk';						{  Settings Manager version (see also gestaltALMAttr)  }

	gestaltWindowMgrAttr		= 'wind';						{  If this Gestalt exists, the Mac OS 8.5 Window Manager is installed }
	gestaltWindowMgrPresent		= $00000001;					{  NOTE: this is a bit mask, whereas all other Gestalt constants of }
																{  this type are bit index values.   Universal Interfaces 3.2 slipped }
																{  out the door with this mistake. }
	gestaltWindowMgrPresentBit	= 0;							{  bit number }
	gestaltExtendedWindowAttributes = 1;						{  Has ChangeWindowAttributes; GetWindowAttributes works for all windows }
	gestaltExtendedWindowAttributesBit = 1;						{  Has ChangeWindowAttributes; GetWindowAttributes works for all windows }
	gestaltHasFloatingWindows	= 2;							{  Floating window APIs work }
	gestaltHasFloatingWindowsBit = 2;							{  Floating window APIs work }
	gestaltHasWindowBuffering	= 3;							{  This system has buffering available }
	gestaltHasWindowBufferingBit = 3;							{  This system has buffering available }
	gestaltWindowLiveResizeBit	= 4;							{  live resizing of windows is available }
	gestaltWindowMinimizeToDockBit = 5;							{  windows minimize to the dock and do not windowshade (Mac OS X) }
	gestaltHasWindowShadowsBit	= 6;							{  windows have shadows }
	gestaltSheetsAreWindowModalBit = 7;							{  sheet windows are modal only to their parent window }
																{  masks for the above bits }
	gestaltWindowMgrPresentMask	= $00000001;
	gestaltExtendedWindowAttributesMask = $00000002;
	gestaltHasFloatingWindowsMask = $00000004;
	gestaltHasWindowBufferingMask = $00000008;
	gestaltWindowLiveResizeMask	= $00000010;
	gestaltWindowMinimizeToDockMask = $00000020;
	gestaltHasWindowShadowsMask	= $00000040;
	gestaltSheetsAreWindowModalMask = $00000080;


{$IFC TARGET_OS_WIN32 }
	gestaltX86Features			= 'x86f';
	gestaltX86HasFPU			= 0;							{  has an FPU that supports the 387 instructions }
	gestaltX86HasVME			= 1;							{  supports Virtual-8086 Mode Extensions }
	gestaltX86HasDE				= 2;							{  supports I/O breakpoints (Debug Extensions) }
	gestaltX86HasPSE			= 3;							{  supports 4-Mbyte pages (Page Size Extension) }
	gestaltX86HasTSC			= 4;							{  supports RTDSC instruction (Time Stamp Counter) }
	gestaltX86HasMSR			= 5;							{  supports Model Specific Registers }
	gestaltX86HasPAE			= 6;							{  supports physical addresses > 32 bits (Physical Address Extension) }
	gestaltX86HasMCE			= 7;							{  supports Machine Check Exception }
	gestaltX86HasCX8			= 8;							{  supports CMPXCHG8 instructions (Compare Exchange 8 bytes) }
	gestaltX86HasAPIC			= 9;							{  contains local APIC }
	gestaltX86Reserved10		= 10;							{  do not count on this bit value }
	gestaltX86HasSEP			= 11;							{  supports fast system call (SysEnter Present) }
	gestaltX86HasMTRR			= 12;							{  supports Memory Type Range Registers }
	gestaltX86HasPGE			= 13;							{  supports Page Global Enable }
	gestaltX86HasMCA			= 14;							{  supports Machine Check Architecture }
	gestaltX86HasCMOV			= 15;							{  supports CMOVcc instruction (Conditional Move). }
																{  If FPU bit is also set, supports FCMOVcc and FCOMI, too }
	gestaltX86HasPAT			= 16;							{  supports Page Attribute Table }
	gestaltX86HasPSE36			= 17;							{  supports 36-bit Page Size Extension }
	gestaltX86HasMMX			= 23;							{  supports MMX instructions }
	gestaltX86HasFXSR			= 24;							{  Supports FXSAVE and FXRSTOR instructions (fast FP save/restore) }

{$ENDC}  {TARGET_OS_WIN32}

	gestaltTranslationAttr		= 'xlat';						{  Translation Manager attributes  }
	gestaltTranslationMgrExists	= 0;							{  True if translation manager exists  }
	gestaltTranslationMgrHintOrder = 1;							{  True if hint order reversal in effect  }
	gestaltTranslationPPCAvail	= 2;
	gestaltTranslationGetPathAPIAvail = 3;

	gestaltExtToolboxTable		= 'xttt';						{  Extended Toolbox trap table base  }

	gestaltUSBPrinterSharingVersion = 'zak ';					{  USB Printer Sharing Version }
	gestaltUSBPrinterSharingVersionMask = $0000FFFF;			{  mask for bits in version }
	gestaltUSBPrinterSharingAttr = 'zak ';						{  USB Printer Sharing Attributes }
	gestaltUSBPrinterSharingAttrMask = $FFFF0000;				{   mask for attribute bits }
	gestaltUSBPrinterSharingAttrRunning = $80000000;			{  printer sharing is running }
	gestaltUSBPrinterSharingAttrBooted = $40000000;				{  printer sharing was installed at boot time }

	{ WorldScript settings; }
	gestaltWorldScriptIIVersion	= 'doub';
	gestaltWorldScriptIIAttr	= 'wsat';
	gestaltWSIICanPrintWithoutPrGeneralBit = 0;					{  bit 0 is on if WS II knows about PrinterStatus callback  }




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GestaltEquIncludes}

{$ENDC} {__GESTALTEQU__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
