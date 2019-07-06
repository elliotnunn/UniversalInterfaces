{
 	File:		LocationManager.p
 
 	Contains:	LocationManager (manage preferences for different physical Locations)
 
 	Version:	Technology:	System 7.6
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT LocationManager;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LOCATIONMANAGER__}
{$SETC __LOCATIONMANAGER__ := 1}

{$I+}
{$SETC LocationManagerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  Location Manager API Support --------------------------------------------------------------------  }
{  A Location Token uniquely identifies a Location on a machine...  }


TYPE
	ALMToken = ^LONGINT;

CONST
	kALMNoLocationToken			= -1;							{  ALMToken of "off" Location... }

	kALMLocationNameMaxLen		= 31;							{  name (actually imposed by file system)...  }
	kALMMaxLocations			= 16;							{  arbitrary limit enforced by Location Manager...  }
	kALMNoLocationIndex			= -1;							{  index for the "off" Location (kALMNoLocationToken)...  }


TYPE
	ALMLocationName						= Str31;
{  Returned from ALMConfirmName...  }
	ALMConfirmChoice					= SInt16;

CONST
	kALMConfirmRename			= 1;
	kALMConfirmReplace			= 2;

{  ALMConfirmName dialog item numbers for use in callbacks (ALM 2.0)...  }

	kALMDuplicateRenameButton	= 1;							{  if Window refcon is kALMDuplicateDialogRefCon...  }
	kALMDuplicateReplaceButton	= 2;
	kALMDuplicateCancelButton	= 3;
	kALMDuplicatePromptText		= 5;

	kALMRenameRenameButton		= 1;							{  if Window refcon is kALMRenameDialogRefCon...  }
	kALMRenameCancelButton		= 2;
	kALMRenameEditText			= 3;
	kALMRenamePromptText		= 4;

{  Refcons of two windows in ALMConfirmName (ALM 2.0)...  }

	kALMDuplicateDialogRefCon	= 'dupl';
	kALMRenameDialogRefCon		= 'rnam';

{  Callback routine for Location awareness (mimics AppleEvents) in non-application code...  }


TYPE
	ALMNotificationProcPtr = ProcPtr;  { PROCEDURE ALMNotification(VAR theEvent: AppleEvent); }

	ALMNotificationUPP = UniversalProcPtr;

CONST
	uppALMNotificationProcInfo = $000000C0;

FUNCTION NewALMNotificationProc(userRoutine: ALMNotificationProcPtr): ALMNotificationUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallALMNotificationProc(VAR theEvent: AppleEvent; userRoutine: ALMNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{  Notification AppleEvents sent to apps/registered code...   }

CONST
	kAELocationChangedNoticeKey	= 'walk';						{  Current Location changed...  }
	kAELocationRescanNoticeKey	= 'trip';						{  Location created/renamed/deleted...  }

{  ALMSwitchToLocation masks...  }


TYPE
	ALMSwitchActionFlags				= SInt32;

CONST
	kALMDefaultSwitchFlags		= $00000000;					{  No special action to take...  }
	kALMDontShowStatusWindow	= $00000001;					{  Suppress "switching" window...  }
	kALMSignalViaAE				= $00000002;					{  Switch by sending Finder AppleEvent...  }

{  Parameters for Get/Put/Merge Location calls...  }


TYPE
	ConstALMModuleTypeListPtr			= ^OSType;

CONST
	kALMAddAllOnSimple			= 0;							{  Add all single-instance, non-action modules...  }
	kALMAddAllOff				= -1;							{  Add all modules but turn them off...  }

{  Item numbers for use in Get/Put/Merge Location filters...  }

	kALMLocationSelectButton	= 1;
	kALMLocationCancelButton	= 2;
	kALMLocationBalloonHelp		= 3;
	kALMLocationLocationList	= 7;
	kALMLocationLocationNameEdit = 10;
	kALMLocationPromptText		= 11;

	kALMLocationSaveButton		= 1;

{  Location Manager Module API Support -------------------------------------------------------------  }

{  ALMGetScriptInfo stuff...  }

	kALMScriptInfoVersion		= 2;							{  Customarily put in resource for localization...  }


TYPE
	ALMScriptManagerInfoPtr = ^ALMScriptManagerInfo;
	ALMScriptManagerInfo = RECORD
		version:				SInt16;									{  Set to kALMScriptInfoVersion...  }
		scriptCode:				SInt16;
		regionCode:				SInt16;
		langCode:				SInt16;
		fontNum:				SInt16;
		fontSize:				SInt16;
	END;

{
   Alternate form of ScriptInfo is easier to localize in resources; it is used extensively in
   samples and internally, so....
}
	ALMAltScriptManagerInfoPtr = ^ALMAltScriptManagerInfo;
	ALMAltScriptManagerInfo = RECORD
		version:				SInt16;
		scriptCode:				SInt16;
		regionCode:				SInt16;
		langCode:				SInt16;
		fontSize:				SInt16;
		fontName:				Str63;
	END;

	ALMAltScriptManagerInfoHandle		= ^ALMAltScriptManagerInfoPtr;

CONST
	kALMAltScriptManagerInfoRsrcType = 'trip';
	kALMAltScriptManagerInfoRsrcID = 0;

{  Reboot information used on ALMSetCurrent (input/output parameter)...  }


TYPE
	ALMRebootFlags						= UInt32;

CONST
	kALMNoChange				= 0;
	kALMAvailableNow			= 1;
	kALMFinderRestart			= 2;
	kALMProcesses				= 3;
	kALMExtensions				= 4;
	kALMWarmBoot				= 5;
	kALMColdBoot				= 6;
	kALMShutdown				= 7;

{
   File types and signatures...
   Note: auto-routing of modules will not be supported for 'thng' files...
}

	kALMFileCreator				= 'fall';						{  Creator of Location Manager files...  }
	kALMComponentModuleFileType	= 'thng';						{  Type of a Component Manager Module file [v1.0]...  }
	kALMComponentStateModuleFileType = 'almn';					{  Type of a CM 'state' Module file...  }
	kALMComponentActionModuleFileType = 'almb';					{  Type of a CM 'action' Module file...  }
	kALMCFMStateModuleFileType	= 'almm';						{  Type of a CFM 'state' Module file...  }
	kALMCFMActionModuleFileType	= 'alma';						{  Type of a CFM 'action' Module file...  }

{  Component Manager 'thng' info...  }

	kALMComponentRsrcType		= 'thng';
	kALMComponentType			= 'walk';

{  CFM Modules require a bit of information (replacing some of the 'thng' resource)...  }

	kALMModuleInfoRsrcType		= 'walk';
	kALMModuleInfoOriginalVersion = 0;

{  These masks apply to the "Flags" field in the 'thng' or 'walk' resource...  }

	kALMMultiplePerLocation		= $00000001;					{  Module can be added more than once to a Location...  }
	kALMDescriptionGetsStale	= $00000002;					{  Descriptions may change though the setting didn't...   }

{  Misc stuff for older implementations ------------------------------------------------------------  }

{$IFC OLDROUTINENAMES }
{  Old error codes for compatibility - new names are in Errors interface...  }
	ALMInternalErr				= -30049;						{  use kALMInternalErr  }
	ALMLocationNotFound			= -30048;						{  use kALMLocationNotFoundErr  }
	ALMNoSuchModuleErr			= -30047;						{  use kALMNoSuchModuleErr  }
	ALMModuleCommunicationErr	= -30046;						{  use kALMModuleCommunicationErr  }
	ALMDuplicateModuleErr		= -30045;						{  use kALMDuplicateModuleErr  }
	ALMInstallationErr			= -30044;						{  use kALMInstallationErr  }
	ALMDeferSwitchErr			= -30043;						{  use kALMDeferSwitchErr  }

{  Old ALMConfirmName constants...  }

	ALMConfirmRenameConfig		= 1;
	ALMConfirmReplaceConfig		= 2;

{  Old AppleEvents...  }

	kAELocationNotice			= 'walk';


TYPE
	ALMScriptMgrInfo					= ALMScriptManagerInfo;
	ALMScriptMgrInfoPtr 				= ^ALMScriptMgrInfo;
	ALMComponentFlagsEnum				= UInt32;
{$ENDC}  {OLDROUTINENAMES}

{  Location Manager API ----------------------------------------------------------------------------  }

{  The following 7 routines are present if gestaltALMAttr has bit gestaltALMPresent set...  }

FUNCTION ALMGetCurrentLocation(VAR index: SInt16; VAR token: ALMToken; VAR name: ALMLocationName): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0600, $AAA4;
	{$ENDC}
FUNCTION ALMGetIndLocation(index: SInt16; VAR token: ALMToken; VAR name: ALMLocationName): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $AAA4;
	{$ENDC}
FUNCTION ALMCountLocations(VAR locationCount: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0202, $AAA4;
	{$ENDC}
FUNCTION ALMSwitchToLocation(newLocation: ALMToken; switchFlags: ALMSwitchActionFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0403, $AAA4;
	{$ENDC}
FUNCTION ALMRegisterNotifyProc(notificationProc: ALMNotificationUPP; {CONST}VAR whichPSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $AAA4;
	{$ENDC}
FUNCTION ALMRemoveNotifyProc(notificationProc: ALMNotificationUPP; {CONST}VAR whichPSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0405, $AAA4;
	{$ENDC}
FUNCTION ALMConfirmName(message: ConstStr255Param; VAR theName: Str255; VAR choice: ALMConfirmChoice; filter: ModalFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0806, $AAA4;
	{$ENDC}
{  The following 3 routines are present if gestaltALMAttr has bit gestaltALMHasSFLocation set...  }

FUNCTION ALMPutLocation(prompt: ConstStr255Param; VAR name: ALMLocationName; numTypes: SInt16; typeList: ConstALMModuleTypeListPtr; filter: ModalFilterYDUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B07, $AAA4;
	{$ENDC}
FUNCTION ALMGetLocation(prompt: ConstStr255Param; VAR name: ALMLocationName; filter: ModalFilterYDUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0808, $AAA4;
	{$ENDC}
FUNCTION ALMMergeLocation(prompt: ConstStr255Param; VAR name: ALMLocationName; numTypes: SInt16; typeList: ConstALMModuleTypeListPtr; filter: ModalFilterYDUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B09, $AAA4;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := LocationManagerIncludes}

{$ENDC} {__LOCATIONMANAGER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
