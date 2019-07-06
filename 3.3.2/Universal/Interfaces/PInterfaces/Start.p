{
     File:       Start.p
 
     Contains:   Start Manager Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1987-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Start;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __START__}
{$SETC __START__ := 1}

{$I+}
{$SETC StartIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    Important: When the major version number of kExtensionTableVersion and the value
    returned by gestaltExtensionTableVersion change, it indicates that the Extension
    Table startup mechanism has radically changed and code that doesn't know about
    the new major version must not attempt to use the Extension Table startup
    mechanism.
    
    Changes to the minor version number of kExtensionTableVersion indicate that the
    definition of the ExtensionElement structure has been extended, but the fields
    defined for previous minor versions of kExtensionTableVersion have not changed.
}

CONST
	kExtensionTableVersion		= $00000100;					{  current ExtensionTable version (1.0.0)  }

{ ExtensionNotification message codes }
	extNotificationBeforeFirst	= 0;							{  Before any extensions have loaded  }
	extNotificationAfterLast	= 1;							{  After all extensions have loaded  }
	extNotificationBeforeCurrent = 2;							{  Before extension at extElementIndex is loaded  }
	extNotificationAfterCurrent	= 3;							{  After extension at extElementIndex is loaded  }


TYPE
	ExtensionElementPtr = ^ExtensionElement;
	ExtensionElement = RECORD
		fileName:				Str31;									{  The file name  }
		parentDirID:			LONGINT;								{  the file's parent directory ID  }
																		{  and everything after ioNamePtr in the HParamBlockRec.fileParam variant  }
		ioVRefNum:				INTEGER;								{  always the real volume reference number (not a drive, default, or working dirID)  }
		ioFRefNum:				INTEGER;
		ioFVersNum:				SInt8;
		filler1:				SInt8;
		ioFDirIndex:			INTEGER;								{  always 0 in table  }
		ioFlAttrib:				SInt8;
		ioFlVersNum:			SInt8;
		ioFlFndrInfo:			FInfo;
		ioDirID:				LONGINT;
		ioFlStBlk:				UInt16;
		ioFlLgLen:				LONGINT;
		ioFlPyLen:				LONGINT;
		ioFlRStBlk:				UInt16;
		ioFlRLgLen:				LONGINT;
		ioFlRPyLen:				LONGINT;
		ioFlCrDat:				UInt32;
		ioFlMdDat:				UInt32;
	END;

	ExtensionTableHeaderPtr = ^ExtensionTableHeader;
	ExtensionTableHeader = RECORD
		extTableHeaderSize:		UInt32;									{  size of ExtensionTable header ( equal to offsetof(ExtensionTable, extElements[0]) )  }
		extTableVersion:		UInt32;									{  current ExtensionTable version (same as returned by gestaltExtTableVersion Gestalt selector)  }
		extElementIndex:		UInt32;									{  current index into ExtensionElement records (zero-based)  }
		extElementSize:			UInt32;									{  size of ExtensionElement  }
		extElementCount:		UInt32;									{  number of ExtensionElement records in table (1-based)  }
	END;

	ExtensionTablePtr = ^ExtensionTable;
	ExtensionTable = RECORD
		extTableHeader:			ExtensionTableHeader;					{  the ExtensionTableHeader  }
		extElements:			ARRAY [0..0] OF ExtensionElement;		{  one element for each extension to load  }
	END;

	ExtensionTableHandle				= ^ExtensionTablePtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ExtensionNotificationProcPtr = PROCEDURE(message: UInt32; param: UNIV Ptr; extElement: ExtensionElementPtr);
{$ELSEC}
	ExtensionNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ExtensionTableHandlerProcPtr = PROCEDURE(message: UInt32; param: UNIV Ptr; extTableHandle: ExtensionTableHandle);
{$ELSEC}
	ExtensionTableHandlerProcPtr = ProcPtr;
{$ENDC}

	ExtensionNotificationUPP = UniversalProcPtr;
	ExtensionTableHandlerUPP = UniversalProcPtr;

CONST
	uppExtensionNotificationProcInfo = $00000FC0;
	uppExtensionTableHandlerProcInfo = $00000FC0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewExtensionNotificationUPP(userRoutine: ExtensionNotificationProcPtr): ExtensionNotificationUPP; { old name was NewExtensionNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewExtensionTableHandlerUPP(userRoutine: ExtensionTableHandlerProcPtr): ExtensionTableHandlerUPP; { old name was NewExtensionTableHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeExtensionNotificationUPP(userUPP: ExtensionNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeExtensionTableHandlerUPP(userUPP: ExtensionTableHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeExtensionNotificationUPP(message: UInt32; param: UNIV Ptr; extElement: ExtensionElementPtr; userRoutine: ExtensionNotificationUPP); { old name was CallExtensionNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeExtensionTableHandlerUPP(message: UInt32; param: UNIV Ptr; extTableHandle: ExtensionTableHandle; userRoutine: ExtensionTableHandlerUPP); { old name was CallExtensionTableHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	DefStartRecPtr = ^DefStartRec;
	DefStartRec = RECORD
		CASE INTEGER OF
		0: (
			sdExtDevID:			SignedByte;
			sdPartition:		SignedByte;
			sdSlotNum:			SignedByte;
			sdSRsrcID:			SignedByte;
		   );
		1: (
			sdReserved1:		SignedByte;
			sdReserved2:		SignedByte;
			sdRefNum:			INTEGER;
		   );
	END;

	DefStartPtr							= ^DefStartRec;
	DefStartPtrPtr 						= ^DefStartPtr;
	DefVideoRecPtr = ^DefVideoRec;
	DefVideoRec = RECORD
		sdSlot:					SignedByte;
		sdsResource:			SignedByte;
	END;

	DefVideoPtr							= ^DefVideoRec;
	DefOSRecPtr = ^DefOSRec;
	DefOSRec = RECORD
		sdReserved:				SignedByte;
		sdOSType:				SignedByte;
	END;

	DefOSPtr							= ^DefOSRec;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE GetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A07D;
	{$ENDC}
PROCEDURE SetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A07E;
	{$ENDC}
PROCEDURE GetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A080;
	{$ENDC}
PROCEDURE SetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A081;
	{$ENDC}
PROCEDURE GetOSDefault(paramBlock: DefOSPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A084;
	{$ENDC}
PROCEDURE SetOSDefault(paramBlock: DefOSPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A083;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE SetTimeout(count: INTEGER);
PROCEDURE GetTimeout(VAR count: INTEGER);
{$ENDC}  {CALL_NOT_IN_CARBON}

{
    InstallExtensionNotificationProc

    Installs an ExtensionNotificationUPP.

    Parameters:
        extNotificationProc The ExtensionNotificationUPP to install.

    Results:
        noErr       0       The ExtensionNotificationUPP was installed.
        paramErr    -50     This ExtensionNotificationUPP has already been installed.
        memFullErr  -108    Not enough memory to install the ExtensionNotificationUPP.
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION InstallExtensionNotificationProc(extNotificationProc: ExtensionNotificationUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA7D;
	{$ENDC}

{
    RemoveExtensionNotificationProc

    Removes an ExtensionNotificationUPP.
    
    Note:   ExtensionNotificationUPPs can't call RemoveExtensionNotificationProc.

    Parameters:
        extNotificationProc The ExtensionNotificationUPP to remove.

    Results:
        noErr       0       The ExtensionNotificationUPP was removed.
        paramErr    -50     The ExtensionNotificationUPP was not found, or
                            RemoveExtensionNotificationProc was called from within
                            a ExtensionNotificationUPP (ExtensionNotificationUPPs can't
                            call RemoveExtensionNotificationProc).
}
FUNCTION RemoveExtensionNotificationProc(extNotificationProc: ExtensionNotificationUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA7D;
	{$ENDC}

{
    InstallExtensionTableHandlerProc

    Installs an ExtensionTableHandlerUPP. Control is taken away from the system's default
    handler and the ExtensionTableHandlerUPP is responsible for all changes to the
    ExtensionTable (except for incrementing extElementIndex between extensions). This is
    always the first handler called with extNotificationBeforeFirst and
    extNotificationBeforeCurrent messages and the last handler called with
    extNotificationAfterLast and extNotificationAfterCurrent messages. extElementIndex
    is always incremented immediately after the ExtensionTableHandlerUPP is called with
    the extNotificationAfterCurrent message.
    
    There can only be one ExtensionTableHandler installed.
    
    Warning:    The only safe time to change what ExtensionElement is at
                ExtensionTable.extElements[extElementIndex] is when your
                ExtensionTableHandlerUPP is called with the extNotificationAfterCurrent
                message. You may change the ExtensionTable or the extElementIndex at other
                times, but you must ensure that the ExtensionElement at
                ExtensionTable.extElements[extElementIndex] stays the same.
                
    Note:       If the ExtensionTable or the contents of the folders included in the
                ExtensionTable are changed after installing an ExtensionTableHandler,
                RemoveExtensionTableHandlerProc cannot be called.

    Parameters:
        extMgrProc          The ExtensionTableHandlerUPP to install.
        extTable            A pointer to an ExtensionTableHandle where
                            InstallExtensionTableHandlerProc will return the current
                            ExtensionTableHandle. You don't own the handle itself and
                            must not dispose of it, but you can change the extElementIndex.
                            the extElementCount, and the ExtensionElements in the table.

    Results:
        noErr       0       The ExtensionTableHandlerUPP was installed.
        paramErr    -50     Another ExtensionTableHandlerUPP has already been installed.
        memFullErr  -108    Not enough memory to install the ExtensionTableHandlerUPP.
}
FUNCTION InstallExtensionTableHandlerProc(extMgrProc: ExtensionTableHandlerUPP; VAR extTable: ExtensionTableHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA7D;
	{$ENDC}

{
    RemoveExtensionTableHandlerProc

    Remove an ExtensionTableUPP. Control is passed back to the default handler.

    Parameters:
        extMgrProc          The ExtensionTableUPP to remove.

    Results:
        noErr       0       The ExtensionTableUPP was removed.
        paramErr    -50     This ExtensionTableUPP was not installed,
                            or the ExtensionTable no longer matches the
                            original boot ExtensionTable.
}
FUNCTION RemoveExtensionTableHandlerProc(extMgrProc: ExtensionTableHandlerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA7D;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StartIncludes}

{$ENDC} {__START__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
