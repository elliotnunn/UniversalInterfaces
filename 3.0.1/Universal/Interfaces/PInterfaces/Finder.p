{
 	File:		Finder.p
 
 	Contains:	Finder flags and container types.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Finder;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FINDER__}
{$SETC __FINDER__ := 1}

{$I+}
{$SETC FinderIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kCustomIconResource			= -16455;						{  Custom icon family resource ID  }

	kContainerFolderAliasType	= 'fdrp';						{  type for folder aliases  }
	kContainerTrashAliasType	= 'trsh';						{  type for trash folder aliases  }
	kContainerHardDiskAliasType	= 'hdsk';						{  type for hard disk aliases  }
	kContainerFloppyAliasType	= 'flpy';						{  type for floppy aliases  }
	kContainerServerAliasType	= 'srvr';						{  type for server aliases  }
	kApplicationAliasType		= 'adrp';						{  type for application aliases  }
	kContainerAliasType			= 'drop';						{  type for all other containers  }
																{  types for Special folder aliases  }
	kSystemFolderAliasType		= 'fasy';
	kAppleMenuFolderAliasType	= 'faam';
	kStartupFolderAliasType		= 'fast';
	kPrintMonitorDocsFolderAliasType = 'fapn';
	kPreferencesFolderAliasType	= 'fapf';
	kControlPanelFolderAliasType = 'fact';
	kExtensionFolderAliasType	= 'faex';						{  types for AppleShare folder aliases  }
	kExportedFolderAliasType	= 'faet';
	kDropFolderAliasType		= 'fadr';
	kSharedFolderAliasType		= 'fash';
	kMountedFolderAliasType		= 'famn';

																{  Finder Flags  }
	kIsOnDesk					= $0001;
	kColor						= $000E;
	kIsShared					= $0040;						{  bit 0x0080 is hasNoINITS  }
	kHasBeenInited				= $0100;						{  bit 0x0200 was the letter bit for AOCE, but is now reserved for future use  }
	kHasCustomIcon				= $0400;
	kIsStationery				= $0800;
	kNameLocked					= $1000;
	kHasBundle					= $2000;
	kIsInvisible				= $4000;
	kIsAlias					= $8000;

{$IFC OLDROUTINENAMES }
	kIsStationary				= $0800;

{$ENDC}  {OLDROUTINENAMES}

{	
	The following declerations used to be in Files.≈, 
	but are Finder specific and were moved here.
}
																{  Finder Constants  }
	fOnDesk						= 1;
	fHasBundle					= 8192;
	fTrash						= -3;
	fDesktop					= -2;
	fDisk						= 0;


TYPE
	FInfoPtr = ^FInfo;
	FInfo = RECORD
		fdType:					OSType;									{ the type of the file }
		fdCreator:				OSType;									{ file's creator }
		fdFlags:				INTEGER;								{ flags ex. hasbundle,invisible,locked, etc. }
		fdLocation:				Point;									{ file's location in folder }
		fdFldr:					INTEGER;								{ folder containing file }
	END;

	FXInfoPtr = ^FXInfo;
	FXInfo = RECORD
		fdIconID:				INTEGER;								{ Icon ID }
		fdUnused:				ARRAY [0..2] OF INTEGER;				{ unused but reserved 6 bytes }
		fdScript:				SInt8;									{ Script flag and number }
		fdXFlags:				SInt8;									{ More flag bits }
		fdComment:				INTEGER;								{ Comment ID }
		fdPutAway:				LONGINT;								{ Home Dir ID }
	END;

	DInfoPtr = ^DInfo;
	DInfo = RECORD
		frRect:					Rect;									{ folder rect }
		frFlags:				INTEGER;								{ Flags }
		frLocation:				Point;									{ folder location }
		frView:					INTEGER;								{ folder view }
	END;

	DXInfoPtr = ^DXInfo;
	DXInfo = RECORD
		frScroll:				Point;									{ scroll position }
		frOpenChain:			LONGINT;								{ DirID chain of open folders }
		frScript:				SInt8;									{ Script flag and number }
		frXFlags:				SInt8;									{ More flag bits }
		frComment:				INTEGER;								{ comment }
		frPutAway:				LONGINT;								{ DirID }
	END;


{ Values of the 'message' parameter to a Control Panel 'cdev' }

CONST
	initDev						= 0;							{ Time for cdev to initialize itself }
	hitDev						= 1;							{ Hit on one of my items }
	closeDev					= 2;							{ Close yourself }
	nulDev						= 3;							{ Null event }
	updateDev					= 4;							{ Update event }
	activDev					= 5;							{ Activate event }
	deactivDev					= 6;							{ Deactivate event }
	keyEvtDev					= 7;							{ Key down/auto key }
	macDev						= 8;							{ Decide whether or not to show up }
	undoDev						= 9;
	cutDev						= 10;
	copyDev						= 11;
	pasteDev					= 12;
	clearDev					= 13;
	cursorDev					= 14;


{ Special values a Control Panel 'cdev' can return }
	cdevGenErr					= -1;							{ General error; gray cdev w/o alert }
	cdevMemErr					= 0;							{ Memory shortfall; alert user please }
	cdevResErr					= 1;							{ Couldn't get a needed resource; alert }
	cdevUnset					= 3;							{  cdevValue is initialized to this }

{ Control Panel Default Proc }

TYPE
	ControlPanelDefProcPtr = ProcPtr;  { FUNCTION ControlPanelDef(message: INTEGER; item: INTEGER; numItems: INTEGER; cPanelID: INTEGER; VAR theEvent: EventRecord; cdevValue: LONGINT; cpDialog: DialogPtr): LONGINT; }

	ControlPanelDefUPP = UniversalProcPtr;

CONST
	uppControlPanelDefProcInfo = $000FEAB0;

FUNCTION NewControlPanelDefProc(userRoutine: ControlPanelDefProcPtr): ControlPanelDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallControlPanelDefProc(message: INTEGER; item: INTEGER; numItems: INTEGER; cPanelID: INTEGER; VAR theEvent: EventRecord; cdevValue: LONGINT; cpDialog: DialogPtr; userRoutine: ControlPanelDefUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FinderIncludes}

{$ENDC} {__FINDER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
