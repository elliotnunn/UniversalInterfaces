{
 	File:		Folders.p
 
 	Contains:	Folder Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kOnSystemDisk				= -32768;						{  previously was 0x8000 but that is an unsigned value whereas vRefNum is signed }

	kCreateFolder				= true;
	kDontCreateFolder			= false;

	kSystemFolderType			= 'macs';						{  the system folder  }
	kDesktopFolderType			= 'desk';						{  the desktop folder; objects in this folder show on the desk top.  }
	kTrashFolderType			= 'trsh';						{  the trash folder; objects in this folder show up in the trash  }
	kWhereToEmptyTrashFolderType = 'empt';						{  the "empty trash" folder; Finder starts empty from here down  }
	kPrintMonitorDocsFolderType	= 'prnt';						{  Print Monitor documents  }
	kStartupFolderType			= 'strt';						{  Finder objects (applications, documents, DAs, aliases, to...) to open at startup go here  }
	kShutdownFolderType			= 'shdf';						{  Finder objects (applications, documents, DAs, aliases, to...) to open at shutdown go here  }
	kAppleMenuFolderType		= 'amnu';						{  Finder objects to put into the Apple menu go here  }
	kControlPanelFolderType		= 'ctrl';						{  Control Panels go here (may contain INITs)  }
	kExtensionFolderType		= 'extn';						{  System extensions go here  }
	kFontsFolderType			= 'font';						{  Fonts go here  }
	kPreferencesFolderType		= 'pref';						{  preferences for applications go here  }
	kTemporaryFolderType		= 'temp';						{  temporary files go here (deleted periodically, but don't rely on it.)  }

{
	Note: 	The FindFolder trap was not implemented until System 7.  If you want to call FindFolder
			while running on System 6 machines, then define USE_FINDFOLDER_GLUE and link with
			Interface.o which contains glue to implement FindFolder on pre-System 7 machines.
}
{$IFC NOT UNDEFINED USE_FINDFOLDER_GLUE }
FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
{$ELSEC}
FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A823;
	{$ENDC}
{$ENDC}

FUNCTION ReleaseFolder(vRefNum: INTEGER; folderType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A823;
	{$ENDC}

{$IFC NOT TARGET_OS_MAC }
{ Since non-mac targets don't know about VRef's or DirID's, the Ex version returns
   the found folder path.
 }
FUNCTION FindFolderEx(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT; foundFolder: CStringPtr): OSErr; C;
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


{ FolderDescFlags values }
	kCreateFolderAtBoot			= $00000002;
	kFolderCreatedInvisible		= $00000004;
	kFolderCreatedNameLocked	= $00000008;


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
{*************************}
{ Folder Manager routines }
{*************************}
{ Folder Manager administration routines }
FUNCTION AddFolderDescriptor(foldType: FolderType; flags: FolderDescFlags; foldClass: FolderClass; foldLocation: FolderLocation; badgeSignature: OSType; badgeType: OSType; name: ConstStrFileNameParam; replaceFlag: BOOLEAN): OSErr;
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
	INLINE $7026, $A823;
	{$ENDC}
FUNCTION RemoveFolderRouting(fileType: OSType; routeFromFolder: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $A823;
	{$ENDC}
FUNCTION FindFolderRouting(fileType: OSType; routeFromFolder: FolderType; VAR routeToFolder: FolderType; VAR flags: RoutingFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $A823;
	{$ENDC}
FUNCTION GetFolderRoutings(requestedRoutingCount: UInt32; VAR totalRoutingCount: UInt32; routingSize: Size; VAR theRoutings: FolderRouting): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $A823;
	{$ENDC}
FUNCTION InvalidateFolderDescriptorCache(vRefNum: INTEGER; dirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $A823;
	{$ENDC}
FUNCTION IdentifyFolder(vRefNum: INTEGER; dirID: LONGINT; VAR foldType: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $A823;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FoldersIncludes}

{$ENDC} {__FOLDERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
