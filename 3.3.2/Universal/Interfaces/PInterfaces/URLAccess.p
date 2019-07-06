{
     File:       URLAccess.p
 
     Contains:   URL Access Interfaces.
 
     Version:    Technology: URLAccess 2.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1994-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT URLAccess;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __URLACCESS__}
{$SETC __URLACCESS__ := 1}

{$I+}
{$SETC URLAccessIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __FILESIGNING__}
{$I FileSigning.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Data structures and types }

TYPE
	URLReference = ^LONGINT; { an opaque 32-bit type }
	URLOpenFlags 				= UInt32;
CONST
	kURLReplaceExistingFlag		= $01;
	kURLBinHexFileFlag			= $02;							{  Binhex before uploading if necessary }
	kURLExpandFileFlag			= $04;							{  Use StuffIt engine to expand file if necessary }
	kURLDisplayProgressFlag		= $08;
	kURLDisplayAuthFlag			= $10;							{  Display auth dialog if guest connection fails }
	kURLUploadFlag				= $20;							{  Do an upload instead of a download }
	kURLIsDirectoryHintFlag		= $40;							{  Hint: the URL is a directory }
	kURLDoNotTryAnonymousFlag	= $80;							{  Don't try to connect anonymously before getting logon info }
	kURLDirectoryListingFlag	= $0100;						{  Download the directory listing, not the whole directory }
	kURLExpandAndVerifyFlag		= $0200;						{  Expand file and then verify using signature resource }
	kURLNoAutoRedirectFlag		= $0400;						{  Do not automatically redirect to new URL }
	kURLDebinhexOnlyFlag		= $0800;						{  Do not use Stuffit Expander - just internal debinhex engine }
	kURLReservedFlag			= $80000000;					{  reserved for Apple internal use }


TYPE
	URLState 					= UInt32;
CONST
	kURLNullState				= 0;
	kURLInitiatingState			= 1;
	kURLLookingUpHostState		= 2;
	kURLConnectingState			= 3;
	kURLResourceFoundState		= 4;
	kURLDownloadingState		= 5;
	kURLDataAvailableState		= $15;
	kURLTransactionCompleteState = 6;
	kURLErrorOccurredState		= 7;
	kURLAbortingState			= 8;
	kURLCompletedState			= 9;
	kURLUploadingState			= 10;


TYPE
	URLEvent 					= UInt32;
CONST
	kURLInitiatedEvent			= 1;
	kURLResourceFoundEvent		= 4;
	kURLDownloadingEvent		= 5;
	kURLAbortInitiatedEvent		= 8;
	kURLCompletedEvent			= 9;
	kURLErrorOccurredEvent		= 7;
	kURLDataAvailableEvent		= $15;
	kURLTransactionCompleteEvent = 6;
	kURLUploadingEvent			= 10;
	kURLSystemEvent				= 29;
	kURLPercentEvent			= 30;
	kURLPeriodicEvent			= 31;
	kURLPropertyChangedEvent	= 32;


TYPE
	URLEventMask 				= UInt32;
CONST
	kURLInitiatedEventMask		= $01;
	kURLResourceFoundEventMask	= $08;
	kURLDownloadingMask			= $10;
	kURLUploadingMask			= $0200;
	kURLAbortInitiatedMask		= $80;
	kURLCompletedEventMask		= $0100;
	kURLErrorOccurredEventMask	= $40;
	kURLDataAvailableEventMask	= $00100000;
	kURLTransactionCompleteEventMask = $20;
	kURLSystemEventMask			= $10000000;
	kURLPercentEventMask		= $20000000;
	kURLPeriodicEventMask		= $40000000;
	kURLPropertyChangedEventMask = $80000000;
	kURLAllBufferEventsMask		= $00100020;
	kURLAllNonBufferEventsMask	= $E00003D1;
	kURLAllEventsMask			= $FFFFFFFF;



TYPE
	URLCallbackInfoPtr = ^URLCallbackInfo;
	URLCallbackInfo = RECORD
		version:				UInt32;
		urlRef:					URLReference;
		property:				ConstCStringPtr;
		currentSize:			UInt32;
		systemEvent:			EventRecordPtr;
	END;

{  http and https properties }

{  authentication type flags }

CONST
	kUserNameAndPasswordFlag	= $00000001;

FUNCTION URLGetURLAccessVersion(VAR returnVers: UInt32): OSStatus;
{$IFC TARGET_RT_MAC_CFM }
{
        URLAccessAvailable() is a macro/inline available only in C/C++.  
        To get the same functionality from pascal or assembly, you need
        to test if URLGetURLAccessVersion function is not NULL.  For instance:
        
            gURLAccessAvailable = FALSE;
            IF @URLAccessAvailable <> kUnresolvedCFragSymbolAddress THEN
                gURLAccessAvailable = TRUE;
            END
    
    }
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
{ URL Access is always available on OS X }
  {$ENDC}
{$ENDC}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	URLNotifyProcPtr = FUNCTION(userContext: UNIV Ptr; event: URLEvent; VAR callbackInfo: URLCallbackInfo): OSStatus;
{$ELSEC}
	URLNotifyProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	URLSystemEventProcPtr = FUNCTION(userContext: UNIV Ptr; VAR event: EventRecord): OSStatus;
{$ELSEC}
	URLSystemEventProcPtr = ProcPtr;
{$ENDC}

	URLNotifyUPP = ^LONGINT;  { an opaque UPP }
	URLSystemEventUPP = ^LONGINT;  { an opaque UPP }

CONST
	uppURLNotifyProcInfo = $00000FF0;
	uppURLSystemEventProcInfo = $000003F0;

FUNCTION NewURLNotifyUPP(userRoutine: URLNotifyProcPtr): URLNotifyUPP; { old name was NewURLNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewURLSystemEventUPP(userRoutine: URLSystemEventProcPtr): URLSystemEventUPP; { old name was NewURLSystemEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeURLNotifyUPP(userUPP: URLNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeURLSystemEventUPP(userUPP: URLSystemEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeURLNotifyUPP(userContext: UNIV Ptr; event: URLEvent; VAR callbackInfo: URLCallbackInfo; userRoutine: URLNotifyUPP): OSStatus; { old name was CallURLNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeURLSystemEventUPP(userContext: UNIV Ptr; VAR event: EventRecord; userRoutine: URLSystemEventUPP): OSStatus; { old name was CallURLSystemEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION URLSimpleDownload(url: ConstCStringPtr; VAR destination: FSSpec; destinationHandle: Handle; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;
FUNCTION URLDownload(urlRef: URLReference; VAR destination: FSSpec; destinationHandle: Handle; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;
FUNCTION URLSimpleUpload(url: ConstCStringPtr; {CONST}VAR source: FSSpec; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;
FUNCTION URLUpload(urlRef: URLReference; {CONST}VAR source: FSSpec; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;
FUNCTION URLNewReference(url: ConstCStringPtr; VAR urlRef: URLReference): OSStatus;
FUNCTION URLDisposeReference(urlRef: URLReference): OSStatus;
FUNCTION URLOpen(urlRef: URLReference; VAR fileSpec: FSSpec; openFlags: URLOpenFlags; notifyProc: URLNotifyUPP; eventRegister: URLEventMask; userContext: UNIV Ptr): OSStatus;
FUNCTION URLAbort(urlRef: URLReference): OSStatus;
FUNCTION URLGetDataAvailable(urlRef: URLReference; VAR dataSize: Size): OSStatus;
FUNCTION URLGetBuffer(urlRef: URLReference; VAR buffer: UNIV Ptr; VAR bufferSize: Size): OSStatus;
FUNCTION URLReleaseBuffer(urlRef: URLReference; buffer: UNIV Ptr): OSStatus;
FUNCTION URLGetProperty(urlRef: URLReference; property: ConstCStringPtr; propertyBuffer: UNIV Ptr; bufferSize: Size): OSStatus;
FUNCTION URLGetPropertySize(urlRef: URLReference; property: ConstCStringPtr; VAR propertySize: Size): OSStatus;
FUNCTION URLSetProperty(urlRef: URLReference; property: ConstCStringPtr; propertyBuffer: UNIV Ptr; bufferSize: Size): OSStatus;
FUNCTION URLGetCurrentState(urlRef: URLReference; VAR state: URLState): OSStatus;
FUNCTION URLGetError(urlRef: URLReference; VAR urlError: OSStatus): OSStatus;
FUNCTION URLIdle: OSStatus;
FUNCTION URLGetFileInfo(fName: StringPtr; VAR fType: OSType; VAR fCreator: OSType): OSStatus;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := URLAccessIncludes}

{$ENDC} {__URLACCESS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
