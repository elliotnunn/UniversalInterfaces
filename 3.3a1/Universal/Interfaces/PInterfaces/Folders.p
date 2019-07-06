{
 	File:		Folders.p
 
 	Contains:	Folder Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1995-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Folders;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FOLDERS__}
{$SETC __FOLDERS__ := 1}

{$I+}
{$SETC FoldersIncludes := UsingIncludes}
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


CONST
	kOnSystemDisk				= -32768;						{  previously was 0x8000 but that is an unsigned value whereas vRefNum is signed }
	kOnAppropriateDisk			= -32767;						{  Generally, the same as kOnSystemDisk, but it's clearer that this isn't always the 'boot' disk. }

	kCreateFolder				= true;
	kDontCreateFolder			= false;

	kSystemFolderType			= 'macs';						{  the system folder  }
	kDesktopFolderType			= 'desk';						{  the desktop folder; objects in this folder show on the desk top.  }
	kSystemDesktopFolderType	= 'sdsk';						{  the desktop folder at the root of the hard drive, never the redirected user desktop folder  }
	kTrashFolderType			= 'trsh';						{  the trash folder; objects in this folder show up in the trash  }
	kSystemTrashFolderType		= 'strs';						{  the trash folder at the root of the drive, never the redirected user trash folder  }
	kWhereToEmptyTrashFolderType = 'empt';						{  the "empty trash" folder; Finder starts empty from here down  }
	kPrintMonitorDocsFolderType	= 'prnt';						{  Print Monitor documents  }
	kStartupFolderType			= 'strt';						{  Finder objects (applications, documents, DAs, aliases, to...) to open at startup go here  }
	kShutdownFolderType			= 'shdf';						{  Finder objects (applications, documents, DAs, aliases, to...) to open at shutdown go here  }
	kAppleMenuFolderType		= 'amnu';						{  Finder objects to put into the Apple menu go here  }
	kControlPanelFolderType		= 'ctrl';						{  Control Panels go here (may contain INITs)  }
	kSystemControlPanelFolderType = 'sctl';						{  System control panels folder - never the redirected one, always "Control Panels" inside the System Folder  }
	kExtensionFolderType		= 'extn';						{  System extensions go here  }
	kFontsFolderType			= 'font';						{  Fonts go here  }
	kPreferencesFolderType		= 'pref';						{  preferences for applications go here  }
	kSystemPreferencesFolderType = 'sprf';						{  System-type Preferences go here - this is always the system's preferences folder, never a logged in user's  }
	kTemporaryFolderType		= 'temp';						{  temporary files go here (deleted periodically, but don't rely on it.)  }

{
	Note: 	The FindFolder trap was not implemented until System 7.  If you want to call FindFolder
			while running on System 6 machines, then define USE_FINDFOLDER_GLUE and link with
			Interface.o which contains glue to implement FindFolder on pre-System 7 machines.
}
{$IFC NOT UNDEFINED USE_FINDFOLDER_GLUE }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A823;
	{$ENDC}
{$ENDC}

FUNCTION FindFolderExtended(vol: INTEGER; foldType: OSType; createFolder: BOOLEAN; flags: UInt32; data: UNIV Ptr; VAR vRefNum: INTEGER; VAR dirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B2C, $A823;
	{$ENDC}
FUNCTION ReleaseFolder(vRefNum: INTEGER; folderType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A823;
	{$ENDC}

{$IFC NOT TARGET_OS_MAC }
{ Since non-mac targets don't know about VRef's or DirID's, the Ex version returns
   the found folder path.
 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION FindFolderEx(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT; foundFolder: CStringPtr): OSErr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{****************************************}
{ Extensible Folder Manager declarations }
{****************************************}

{**************************}
{ Folder Manager constants }
{**************************}


CONST
	kExtensionDisabledFolderType = 'extD';
	kControlPanelDisabledFolderType = 'ctrD';
	kSystemExtensionDisabledFolderType = 'macD';
	kStartupItemsDisabledFolderType = 'strD';
	kShutdownItemsDisabledFolderType = 'shdD';
	kApplicationsFolderType		= 'apps';
	kDocumentsFolderType		= 'docs';

																{  new constants  }
	kVolumeRootFolderType		= 'root';						{  root folder of a volume  }
	kChewableItemsFolderType	= 'flnt';						{  items deleted at boot  }
	kApplicationSupportFolderType = 'asup';						{  third-party items and folders  }
	kTextEncodingsFolderType	= 'ƒtex';						{  encoding tables  }
	kStationeryFolderType		= 'odst';						{  stationery  }
	kOpenDocFolderType			= 'odod';						{  OpenDoc root  }
	kOpenDocShellPlugInsFolderType = 'odsp';					{  OpenDoc Shell Plug-Ins in OpenDoc folder  }
	kEditorsFolderType			= 'oded';						{  OpenDoc editors in MacOS Folder  }
	kOpenDocEditorsFolderType	= 'ƒodf';						{  OpenDoc subfolder of Editors folder  }
	kOpenDocLibrariesFolderType	= 'odlb';						{  OpenDoc libraries folder  }
	kGenEditorsFolderType		= 'ƒedi';						{  CKH general editors folder at root level of Sys folder  }
	kHelpFolderType				= 'ƒhlp';						{  CKH help folder currently at root of system folder  }
	kInternetPlugInFolderType	= 'ƒnet';						{  CKH internet plug ins for browsers and stuff  }
	kModemScriptsFolderType		= 'ƒmod';						{  CKH modem scripts, get 'em OUT of the Extensions folder  }
	kPrinterDescriptionFolderType = 'ppdf';						{  CKH new folder at root of System folder for printer descs.  }
	kPrinterDriverFolderType	= 'ƒprd';						{  CKH new folder at root of System folder for printer drivers  }
	kScriptingAdditionsFolderType = 'ƒscr';						{  CKH at root of system folder  }
	kSharedLibrariesFolderType	= 'ƒlib';						{  CKH for general shared libs.  }
	kVoicesFolderType			= 'fvoc';						{  CKH macintalk can live here  }
	kControlStripModulesFolderType = 'sdev';					{  CKH for control strip modules  }
	kAssistantsFolderType		= 'astƒ';						{  SJF for Assistants (MacOS Setup Assistant, etc)  }
	kUtilitiesFolderType		= 'utiƒ';						{  SJF for Utilities folder  }
	kAppleExtrasFolderType		= 'aexƒ';						{  SJF for Apple Extras folder  }
	kContextualMenuItemsFolderType = 'cmnu';					{  SJF for Contextual Menu items  }
	kMacOSReadMesFolderType		= 'morƒ';						{  SJF for MacOS ReadMes folder  }
	kALMModulesFolderType		= 'walk';						{  EAS for Location Manager Module files except type 'thng' (within kExtensionFolderType)  }
	kALMPreferencesFolderType	= 'trip';						{  EAS for Location Manager Preferences (within kPreferencesFolderType; contains kALMLocationsFolderType)  }
	kALMLocationsFolderType		= 'fall';						{  EAS for Location Manager Locations (within kALMPreferencesFolderType)  }
	kColorSyncProfilesFolderType = 'prof';						{  for ColorSync™ Profiles  }
	kThemesFolderType			= 'thme';						{  for Theme data files  }
	kFavoritesFolderType		= 'favs';						{  Favorties folder for Navigation Services  }
	kInternetFolderType			= 'intƒ';						{  Internet folder (root level of startup volume)  }
	kAppearanceFolderType		= 'appr';						{  Appearance folder (root of system folder)  }
	kSoundSetsFolderType		= 'snds';						{  Sound Sets folder (in Appearance folder)  }
	kDesktopPicturesFolderType	= 'dtpƒ';						{  Desktop Pictures folder (in Appearance folder)  }
	kInternetSearchSitesFolderType = 'issf';					{  Internet Search Sites folder  }
	kFindSupportFolderType		= 'fnds';						{  Find support folder  }
	kFindByContentFolderType	= 'fbcf';						{  Find by content folder  }
	kInstallerLogsFolderType	= 'ilgf';						{  Installer Logs folder  }
	kScriptsFolderType			= 'scrƒ';						{  Scripts folder  }
	kFolderActionsFolderType	= 'fasf';						{  Folder Actions Scripts folder  }
	kLauncherItemsFolderType	= 'laun';						{  Launcher Items folder  }
	kRecentApplicationsFolderType = 'rapp';						{  Recent Applications folder  }
	kRecentDocumentsFolderType	= 'rdoc';						{  Recent Documents folder  }
	kRecentServersFolderType	= 'rsvr';						{  Recent Servers folder  }
	kSpeakableItemsFolderType	= 'spki';						{  Speakable Items folder  }
	kKeychainFolderType			= 'kchn';						{  Keychain folder  }
	kQuickTimeExtensionsFolderType = 'qtex';					{  QuickTime Extensions Folder (in Extensions folder)  }
	kDisplayExtensionsFolderType = 'dspl';						{  Display Extensions Folder (in Extensions folder)  }
	kMultiprocessingFolderType	= 'mpxf';						{  Multiprocessing Folder (in Extensions folder)  }
	kPrintingPlugInsFolderType	= 'pplg';						{  Printing Plug-Ins Folder (in Extensions folder)  }

	kLocalesFolderType			= 'ƒloc';						{  PKE for Locales folder  }
	kFindByContentPluginsFolderType = 'fbcp';					{  Find By Content Plug-ins  }

	kUsersFolderType			= 'usrs';						{  "Users" folder, contains one folder for each user.  }
	kCurrentUserFolderType		= 'cusr';						{  The folder for the currently logged on user.  }
	kCurrentUserRemoteFolderLocation = 'rusf';					{  The remote folder for the currently logged on user  }
	kCurrentUserRemoteFolderType = 'rusr';						{  The remote folder location for the currently logged on user  }
	kSharedUserDataFolderType	= 'sdat';						{  A Shared "Documents" folder, readable & writeable by all users  }
	kVolumeSettingsFolderType	= 'vsfd';						{  Volume specific user information goes here  }

{ FolderDescFlags values }
	kCreateFolderAtBoot			= $00000002;
	kFolderCreatedInvisible		= $00000004;
	kFolderCreatedNameLocked	= $00000008;
	kFolderCreatedAdminPrivs	= $00000010;

	kFolderInUserFolder			= $00000020;
	kFolderTrackedByAlias		= $00000040;
	kFolderInRemoteUserFolderIfAvailable = $00000080;
	kFolderNeverMatchedInIdentifyFolder = $00000100;
	kFolderMustStayOnSameVolume	= $00000200;
	kFolderInLocalOrRemoteUserFolder = $000000A0;


TYPE
	FolderDescFlags						= UInt32;
{ FolderClass values }

CONST
	kRelativeFolder				= 'relf';
	kSpecialFolder				= 'spcf';


TYPE
	FolderClass							= OSType;
{ special folder locations }

CONST
	kBlessedFolder				= 'blsf';
	kRootFolder					= 'rotf';

	kCurrentUserFolderLocation	= 'cusf';						{ 	the magic 'Current User' folder location }


TYPE
	FolderType							= OSType;
	FolderLocation						= OSType;

	FolderDescPtr = ^FolderDesc;
	FolderDesc = RECORD
		descSize:				Size;
		foldType:				FolderType;
		flags:					FolderDescFlags;
		foldClass:				FolderClass;
		foldLocation:			FolderType;
		badgeSignature:			OSType;
		badgeType:				OSType;
		reserved:				UInt32;
		name:					StrFileName;							{  Str63 on MacOS }
	END;


	RoutingFlags						= UInt32;
	FolderRoutingPtr = ^FolderRouting;
	FolderRouting = RECORD
		descSize:				Size;
		fileType:				OSType;
		routeFromFolder:		FolderType;
		routeToFolder:			FolderType;
		flags:					RoutingFlags;
	END;

{ routing constants }
{ 	These are bits in the .flags field of the FindFolderUserRedirectionGlobals struct }

CONST
																{ 	Set this bit to 1 in the .flags field of a FindFolderUserRedirectionGlobals }
																{ 	structure if the userName in the struct should be used as the current }
																{ 	"User" name }
	kFindFolderRedirectionFlagUseDistinctUserFoldersBit = 0;	{ 	Set this bit to 1 and the currentUserFolderVRefNum and currentUserFolderDirID }
																{ 	fields of the user record will get used instead of finding the user folder }
																{ 	with the userName field. }
	kFindFolderRedirectionFlagUseGivenVRefAndDirIDAsUserFolderBit = 1; { 	Set this bit to 1 and the remoteUserFolderVRefNum and remoteUserFolderDirID }
																{ 	fields of the user record will get used instead of finding the user folder }
																{ 	with the userName field. }
	kFindFolderRedirectionFlagsUseGivenVRefNumAndDirIDAsRemoteUserFolderBit = 2;


TYPE
	FindFolderUserRedirectionGlobalsPtr = ^FindFolderUserRedirectionGlobals;
	FindFolderUserRedirectionGlobals = RECORD
		version:				UInt32;
		flags:					UInt32;
		userName:				Str31;
		userNameScript:			INTEGER;
		currentUserFolderVRefNum: INTEGER;
		currentUserFolderDirID:	LONGINT;
		remoteUserFolderVRefNum: INTEGER;
		remoteUserFolderDirID:	LONGINT;
	END;


CONST
	kFolderManagerUserRedirectionGlobalsCurrentVersion = 1;

{
  	These are passed into FindFolderExtended(), FindFolderInternalExtended(), and
  	FindFolderNewInstallerEntryExtended() in the flags field. 
}
	kFindFolderExtendedFlagsDoNotFollowAliasesBit = 0;
	kFindFolderExtendedFlagsDoNotUseUserFolderBit = 1;
	kFindFolderExtendedFlagsUseOtherUserRecord = $01000000;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	FolderManagerNotificationProcPtr = FUNCTION(message: OSType; arg: UNIV Ptr; userRefCon: UNIV Ptr): OSStatus;
{$ELSEC}
	FolderManagerNotificationProcPtr = ProcPtr;
{$ENDC}

	FolderManagerNotificationUPP = UniversalProcPtr;

CONST
	uppFolderManagerNotificationProcInfo = $00000FF0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewFolderManagerNotificationUPP(userRoutine: FolderManagerNotificationProcPtr): FolderManagerNotificationUPP; { old name was NewFolderManagerNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeFolderManagerNotificationUPP(userUPP: FolderManagerNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeFolderManagerNotificationUPP(message: OSType; arg: UNIV Ptr; userRefCon: UNIV Ptr; userRoutine: FolderManagerNotificationUPP): OSStatus; { old name was CallFolderManagerNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kFolderManagerNotificationMessageUserLogIn = 'log+';		{ 	Sent by system & third party software after a user logs in.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationMessagePreUserLogIn = 'logj';		{ 	Sent by system & third party software before a user logs in.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationMessageUserLogOut = 'log-';		{ 	Sent by system & third party software before a user logs out.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationMessagePostUserLogOut = 'logp';	{ 	Sent by system & third party software after a user logs out.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationDiscardCachedData = 'dche';		{ 	Sent by third party software when the entire Folder Manager cache should be flushed }


{ 	These get used in the options parameter of FolderManagerRegisterNotificationProc() }
	kDoNotRemoveWhenCurrentApplicationQuitsBit = 0;
	kDoNotRemoveWheCurrentApplicationQuitsBit = 0;				{ 	Going away soon, use kDoNotRemoveWheCurrentApplicationQuitsBit }

{ 	These get used in the options parameter of FolderManagerCallNotificationProcs() }
	kStopIfAnyNotificationProcReturnsErrorBit = 31;

{*************************}
{ Folder Manager routines }
{*************************}
{ Folder Manager administration routines }
FUNCTION AddFolderDescriptor(foldType: FolderType; flags: FolderDescFlags; foldClass: FolderClass; foldLocation: FolderLocation; badgeSignature: OSType; badgeType: OSType; name: StrFileName; replaceFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $A823;
	{$ENDC}
FUNCTION GetFolderDescriptor(foldType: FolderType; descSize: Size; VAR foldDesc: FolderDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $A823;
	{$ENDC}
FUNCTION GetFolderTypes(requestedTypeCount: UInt32; VAR totalTypeCount: UInt32; VAR theTypes: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $A823;
	{$ENDC}
FUNCTION RemoveFolderDescriptor(foldType: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $A823;
	{$ENDC}
{ legacy routines }
FUNCTION GetFolderName(vRefNum: INTEGER; foldType: OSType; VAR foundVRefNum: INTEGER; VAR name: StrFileName): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $A823;
	{$ENDC}
{ routing routines }
FUNCTION AddFolderRouting(fileType: OSType; routeFromFolder: FolderType; routeToFolder: FolderType; flags: RoutingFlags; replaceFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0926, $A823;
	{$ENDC}
FUNCTION RemoveFolderRouting(fileType: OSType; routeFromFolder: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0427, $A823;
	{$ENDC}
FUNCTION FindFolderRouting(fileType: OSType; routeFromFolder: FolderType; VAR routeToFolder: FolderType; VAR flags: RoutingFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0822, $A823;
	{$ENDC}
FUNCTION GetFolderRoutings(requestedRoutingCount: UInt32; VAR totalRoutingCount: UInt32; routingSize: Size; VAR theRoutings: FolderRouting): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081E, $A823;
	{$ENDC}
FUNCTION InvalidateFolderDescriptorCache(vRefNum: INTEGER; dirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0325, $A823;
	{$ENDC}
FUNCTION IdentifyFolder(vRefNum: INTEGER; dirID: LONGINT; VAR foldType: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $051F, $A823;
	{$ENDC}

FUNCTION FolderManagerRegisterNotificationProc(notificationProc: FolderManagerNotificationUPP; refCon: UNIV Ptr; options: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $062F, $A823;
	{$ENDC}
FUNCTION FolderManagerUnregisterNotificationProc(notificationProc: FolderManagerNotificationUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0430, $A823;
	{$ENDC}
FUNCTION FolderManagerRegisterCallNotificationProcs(message: OSType; arg: UNIV Ptr; options: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0631, $A823;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FoldersIncludes}

{$ENDC} {__FOLDERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}