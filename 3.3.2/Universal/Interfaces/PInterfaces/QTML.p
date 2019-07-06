{
     File:       QTML.p
 
     Contains:   QuickTime Cross-platform specific interfaces
 
     Version:    Technology: QuickTime 4.1
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1997-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QTML;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QTML__}
{$SETC __QTML__ := 1}

{$I+}
{$SETC QTMLIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE QTMLYieldCPU;
PROCEDURE QTMLYieldCPUTime(milliSeconds: LONGINT; flags: UInt32);
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC (TARGET_API_MAC_CARBON OR TARGET_API_MAC_OSX OR TARGET_OS_UNIX OR TARGET_OS_WIN32) }

TYPE
	QTMLMutex							= LONGINT;
	QTMLSyncVar = ^LONGINT; { an opaque 32-bit type }
	QTMLSyncVarPtr						= ^QTMLSyncVar;

CONST
	kInitializeQTMLNoSoundFlag	= $00000001;					{  flag for requesting no sound when calling InitializeQTML }
	kInitializeQTMLUseGDIFlag	= $00000002;					{  flag for requesting GDI when calling InitializeQTML }
	kInitializeQTMLDisableDirectSound = $00000004;				{  disables QTML's use of DirectSound }
	kInitializeQTMLUseExclusiveFullScreenModeFlag = $00000008;	{  later than QTML 3.0: qtml starts up in exclusive full screen mode }

	kQTMLHandlePortEvents		= $00000001;					{  flag for requesting requesting QTML to handle events }
	kQTMLNoIdleEvents			= $00000002;					{  flag for requesting requesting QTML not to send Idle Events }

{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitializeQTML(flag: LONGINT): OSErr;
PROCEDURE TerminateQTML;
FUNCTION CreatePortAssociation(theWnd: UNIV Ptr; storage: Ptr; flags: LONGINT): GrafPtr;
PROCEDURE DestroyPortAssociation(cgp: CGrafPtr);
PROCEDURE QTMLGrabMutex(mu: QTMLMutex);
FUNCTION QTMLTryGrabMutex(mu: QTMLMutex): BOOLEAN;
PROCEDURE QTMLReturnMutex(mu: QTMLMutex);
FUNCTION QTMLCreateMutex: QTMLMutex;
PROCEDURE QTMLDestroyMutex(mu: QTMLMutex);
FUNCTION QTMLCreateSyncVar: QTMLSyncVarPtr;
PROCEDURE QTMLDestroySyncVar(p: QTMLSyncVarPtr);
FUNCTION QTMLTestAndSetSyncVar(sync: QTMLSyncVarPtr): LONGINT;
PROCEDURE QTMLWaitAndSetSyncVar(sync: QTMLSyncVarPtr);
PROCEDURE QTMLResetSyncVar(sync: QTMLSyncVarPtr);
PROCEDURE InitializeQHdr(VAR qhdr: QHdr);
PROCEDURE TerminateQHdr(VAR qhdr: QHdr);
PROCEDURE QTMLAcquireWindowList;
PROCEDURE QTMLReleaseWindowList;
{
   These routines are here to support "interrupt level" code
      These are dangerous routines, only use if you know what you are doing.
}

FUNCTION QTMLRegisterInterruptSafeThread(threadID: UInt32; threadInfo: UNIV Ptr): LONGINT;
FUNCTION QTMLUnregisterInterruptSafeThread(threadID: UInt32): LONGINT;
FUNCTION NativeEventToMacEvent(nativeEvent: UNIV Ptr; VAR macEvent: EventRecord): LONGINT;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION WinEventToMacEvent(winMsg: UNIV Ptr; VAR macEvent: EventRecord): LONGINT;
FUNCTION IsTaskBarVisible: BOOLEAN;
PROCEDURE ShowHideTaskBar(showIt: BOOLEAN);
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kDDSurfaceLocked			= $00000001;
	kDDSurfaceStatic			= $00000002;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTGetDDObject(VAR lpDDObject: UNIV Ptr): OSErr;
FUNCTION QTSetDDObject(lpNewDDObject: UNIV Ptr): OSErr;
FUNCTION QTSetDDPrimarySurface(lpNewDDSurface: UNIV Ptr; flags: UInt32): OSErr;
FUNCTION QTMLGetVolumeRootPath(fullPath: CStringPtr; volumeRootPath: CStringPtr; volumeRootLen: UInt32): OSErr;
PROCEDURE QTMLSetWindowWndProc(theWindow: WindowRef; windowProc: UNIV Ptr);
FUNCTION QTMLGetWindowWndProc(theWindow: WindowRef): Ptr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION QTMLGetCanonicalPathName(inName: CStringPtr; outName: CStringPtr; outLen: UInt32): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kFullNativePath				= 0;
	kFileNameOnly				= $01;
	kDirectoryPathOnly			= $02;
	kUFSFullPathName			= $04;
	kTryVDIMask					= $08;							{     Used in NativePathNameToFSSpec to specify to search VDI mountpoints }
	kFullPathSpecifiedMask		= $10;							{     the passed in name is a fully qualified full path }

{$IFC CALL_NOT_IN_CARBON }
FUNCTION FSSpecToNativePathName({CONST}VAR inFile: FSSpec; outName: CStringPtr; outLen: UInt32; flags: LONGINT): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kErrorIfFileNotFound		= $80000000;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION NativePathNameToFSSpec(inName: CStringPtr; VAR outFile: FSSpec; flags: LONGINT): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QTMLIncludes}

{$ENDC} {__QTML__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
