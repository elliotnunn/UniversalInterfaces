/*
 	File:		Folders.r
 
 	Contains:	Folder Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __FOLDERS_R__
#define __FOLDERS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define kOnSystemDisk 					0x8000
#define kCreateFolder 					1
#define kDontCreateFolder 				0

#define kSystemFolderType 				'macs'				/*  the system folder  */
#define kDesktopFolderType 				'desk'				/*  the desktop folder; objects in this folder show on the desk top.  */
#define kTrashFolderType 				'trsh'				/*  the trash folder; objects in this folder show up in the trash  */
#define kWhereToEmptyTrashFolderType 	'empt'				/*  the "empty trash" folder; Finder starts empty from here down  */
#define kPrintMonitorDocsFolderType 	'prnt'				/*  Print Monitor documents  */
#define kStartupFolderType 				'strt'				/*  Finder objects (applications, documents, DAs, aliases, to...) to open at startup go here  */
#define kShutdownFolderType 			'shdf'				/*  Finder objects (applications, documents, DAs, aliases, to...) to open at shutdown go here  */
#define kAppleMenuFolderType 			'amnu'				/*  Finder objects to put into the Apple menu go here  */
#define kControlPanelFolderType 		'ctrl'				/*  Control Panels go here (may contain INITs)  */
#define kExtensionFolderType 			'extn'				/*  Finder extensions go here  */
#define kFontsFolderType 				'font'				/*  Fonts go here  */
#define kPreferencesFolderType 			'pref'				/*  preferences for applications go here  */
#define kTemporaryFolderType 			'temp'				/*  temporary files go here (deleted periodically, but don't rely on it.)  */

#define badFolderDescErr 				(-4270)
#define duplicateFolderDescErr 			(-4271)
#define noMoreFolderDescErr 			(-4272)
#define invalidFolderTypeErr 			(-4273)
#define duplicateRoutingErr 			(-4274)
#define routingNotFoundErr 				(-4275)
#define badRoutingSizeErr 				(-4276)

#define kExtensionDisabledFolderType 	'extD'
#define kControlPanelDisabledFolderType  'ctrD'
#define kSystemExtensionDisabledFolderType  'macD'
#define kStartupItemsDisabledFolderType  'strD'
#define kShutdownItemsDisabledFolderType  'shdD'
#define kApplicationsFolderType 		'apps'
#define kDocumentsFolderType 			'docs'

															/*  new constants  */
#define kVolumeRootFolderType 			'root'				/*  root folder of a volume  */
#define kChewableItemsFolderType 		'flnt'				/*  items deleted at boot  */
#define kApplicationSupportFolderType 	'asup'				/*  third-party items and folders  */
#define kTextEncodingsFolderType 		'ƒtex'				/*  encoding tables  */
#define kStationeryFolderType 			'odst'				/*  stationery  */
#define kOpenDocFolderType 				'odod'				/*  OpenDoc root  */
#define kOpenDocShellPlugInsFolderType 	'odsp'				/*  OpenDoc Shell Plug-Ins in OpenDoc folder  */
#define kEditorsFolderType 				'oded'				/*  OpenDoc editors in MacOS Folder  */
#define kOpenDocEditorsFolderType 		'ƒodf'				/*  OpenDoc subfolder of Editors folder  */
#define kOpenDocLibrariesFolderType 	'odlb'				/*  OpenDoc libraries folder  */
#define kGenEditorsFolderType 			'ƒedi'				/*  CKH general editors folder at root level of Sys folder  */
#define kHelpFolderType 				'ƒhlp'				/*  CKH help folder currently at root of system folder  */
#define kInternetPlugInFolderType 		'ƒnet'				/*  CKH internet plug ins for browsers and stuff  */
#define kModemScriptsFolderType 		'ƒmod'				/*  CKH modem scripts, get 'em OUT of the Extensions folder  */
#define kPrinterDescriptionFolderType 	'ppdf'				/*  CKH new folder at root of System folder for printer descs.  */
#define kPrinterDriverFolderType 		'ƒprd'				/*  CKH new folder at root of System folder for printer drivers  */
#define kScriptingAdditionsFolderType 	'ƒscr'				/*  CKH at root of system folder  */
#define kSharedLibrariesFolderType 		'ƒlib'				/*  CKH for general shared libs.  */
#define kVoicesFolderType 				'fvoc'				/*  CKH macintalk can live here  */
#define kControlStripModulesFolderType 	'sdev'				/*  CKH for control strip modules  */
#define kAssistantsFolderType 			'astƒ'				/*  SJF for Assistants (MacOS Setup Assistant, etc)  */
#define kUtilitiesFolderType 			'utiƒ'				/*  SJF for Utilities folder  */
#define kAppleExtrasFolderType 			'aexƒ'				/*  SJF for Apple Extras folder  */
#define kContextualMenuItemsFolderType 	'cmnu'				/*  SJF for Contextual Menu items  */
#define kMacOSReadMesFolderType 		'morƒ'				/*  SJF for MacOS ReadMes folder  */
#define kALMModulesFolderType 			'walk'				/*  EAS for Location Manager Module files except type 'thng' (within kExtensionFolderType)  */
#define kALMPreferencesFolderType 		'trip'				/*  EAS for Location Manager Preferences (within kPreferencesFolderType; contains kALMLocationsFolderType)  */
#define kALMLocationsFolderType 		'fall'				/*  EAS for Location Manager Locations (within kALMPreferencesFolderType)  */

#define kCreateFolderAtBoot 			0x00000002
#define kFolderCreatedInvisible 		0x00000004
#define kFolderCreatedNameLocked 		0x00000008

#define kRelativeFolder 				'relf'
#define kSpecialFolder 					'spcf'

#define kBlessedFolder 					'blsf'
#define kRootFolder 					'rotf'


/* fld# • list of folder names for Folder Mgr */

	type 'fld#' {
		array {
			literal		longint;				// folder type
			integer		inSystemFolder = 0;		// version
			fill byte;							// high byte of data length
			pstring;							// folder name
			align word;
		};
	};

#endif /* __FOLDERS_R__ */

