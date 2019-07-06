{
     File:       NSL.p
 
     Contains:   Interface to API for using the NSL Manager
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT NSL;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NSL__}
{$SETC __NSL__ := 1}

{$I+}
{$SETC NSLIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __THREADS__}
{$I Threads.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kNSLMinSystemVersion		= $0900;						{  equivalent to 9.0 }
	kNSLMinOTVersion			= $0130;						{  equivalent to 1.3 }

	kNSLDefaultListSize			= 256;							{  default list size for service and protocol lists }

	kNSLURLDelimiter			= 44;							{  delimits URL's within memory buffers }

	kNSLNoContext				= 0;							{  the default context for NSLError structs }


TYPE
	NSLErrorPtr = ^NSLError;
	NSLError = RECORD
		theErr:					OSStatus;
		theContext:				UInt32;
	END;


CONST
																{  Constants to use with NSLPrepareRequest }
																{  kNSLDuplicateSearchInProgress is not strictly an error.  The client is free to ignore }
																{  this result, and nothing bad will happen if it does.  It is }
																{  informational only. }
	kNSLDuplicateSearchInProgress = 100;
	kNSLUserCanceled			= -128;							{  User hit cancel from the NSLStandardGetURL dialog  }
																{  Invalid enumeratorRef   }
	kNSLInvalidEnumeratorRef	= 0;							{  this is not an error; it is the equiv to a NULL ptr }


TYPE
	NSLSearchState 				= UInt16;
CONST
																{  State codes for notifiers. }
	kNSLSearchStateBufferFull	= 1;
	kNSLSearchStateOnGoing		= 2;
	kNSLSearchStateComplete		= 3;
	kNSLSearchStateStalled		= 4;
	kNSLWaitingForContinue		= 5;


TYPE
	NSLEventCode 				= UInt32;
CONST
																{  Event codes }
	kNSLServicesLookupDataEvent	= 6;
	kNSLNeighborhoodLookupDataEvent = 7;
	kNSLNewDataEvent			= 8;
	kNSLContinueLookupEvent		= 9;



TYPE
	NSLClientRef						= UInt32;
	NSLRequestRef						= UInt32;
	NSLOneBasedIndex					= UInt32;
	NSLPath								= ^CHAR;
	NSLServiceType						= ^CHAR;
	NSLServicesList						= Handle;
	NSLNeighborhood						= ^UInt8;
{
   cstring which is a comma delimited list of protocols which can be used to
   create a NSLProtocolList internally
}
	NSLDialogOptionFlags 		= UInt32;
CONST
	kNSLDefaultNSLDlogOptions	= $00000000;					{  use defaults for all the options  }
	kNSLNoURLTEField			= $00000001;					{  don't show url text field for manual entry  }


TYPE
	NSLDialogOptionsPtr = ^NSLDialogOptions;
	NSLDialogOptions = RECORD
		version:				UInt16;
		dialogOptionFlags:		NSLDialogOptionFlags;					{  option flags for affecting the dialog's behavior  }
		windowTitle:			Str255;
		actionButtonLabel:		Str255;									{  label of the default button (or null string for default)  }
		cancelButtonLabel:		Str255;									{  label of the cancel button (or null string for default)  }
		message:				Str255;									{  custom message prompt (or null string for default)  }
	END;

{  the async information block for client<->manager interaction }
	NSLClientAsyncInfoPtr = ^NSLClientAsyncInfo;
	NSLClientAsyncInfo = RECORD
		clientContextPtr:		Ptr;									{  set by the client for its own use }
		mgrContextPtr:			Ptr;									{  set by NSL mgr; ptr to request object ptr }
		resultBuffer:			CStringPtr;
		bufferLen:				LONGINT;
		maxBufferSize:			LONGINT;
		startTime:				UInt32;									{  when the search starts, to use with maxSearchTime to determine time-out condition }
		intStartTime:			UInt32;									{  used with alertInterval }
		maxSearchTime:			UInt32;									{  total time for search, in ticks (0 == no time limit) }
		alertInterval:			UInt32;									{  call client's notifier or return, every this many ticks ( 0 == don't use this param) }
		totalItems:				UInt32;									{  total number of tuples currently in buffer }
		alertThreshold:			UInt32;									{  call client's notifier or return, every this many items found ( 0 == don't use this param) }
		searchState:			NSLSearchState;
		searchResult:			NSLError;
		searchDataType:			NSLEventCode;							{  this is a data type code which allows the client's asyncNotifier to properly }
																		{  handle the data in resultBuffer. }
	END;

{  the async information block plugin<->manager interaction }
	NSLPluginAsyncInfoPtr = ^NSLPluginAsyncInfo;
	NSLPluginAsyncInfo = RECORD
		mgrContextPtr:			Ptr;									{  set by NSL mgr; ptr to request object ptr }
		pluginContextPtr:		Ptr;									{  set/used by individual plugins }
		pluginPtr:				Ptr;									{  ptr to the plugin object waiting for continue lookup call }
		resultBuffer:			CStringPtr;								{  set by plugin to point at data }
		bufferLen:				LONGINT;
		maxBufferSize:			LONGINT;
		maxSearchTime:			UInt32;									{  total time for search, in ticks (0 == no time limit) }
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
		clientRef:				NSLClientRef;
		requestRef:				NSLRequestRef;
		searchState:			NSLSearchState;
		searchResult:			OSStatus;
	END;

{  the mgr asynchronous notifier routine. }
{$IFC TYPED_FUNCTION_POINTERS}
	NSLMgrNotifyProcPtr = PROCEDURE(VAR thePluginAsyncInfo: NSLPluginAsyncInfo);
{$ELSEC}
	NSLMgrNotifyProcPtr = ProcPtr;
{$ENDC}

{  the client asynchronous notifier routine. }
{$IFC TYPED_FUNCTION_POINTERS}
	NSLClientNotifyProcPtr = PROCEDURE(VAR theClientAsyncInfo: NSLClientAsyncInfo);
{$ELSEC}
	NSLClientNotifyProcPtr = ProcPtr;
{$ENDC}

	NSLMgrNotifyUPP = UniversalProcPtr;
	NSLClientNotifyUPP = UniversalProcPtr;

CONST
	uppNSLMgrNotifyProcInfo = $000000C0;
	uppNSLClientNotifyProcInfo = $000000C0;

FUNCTION NewNSLMgrNotifyUPP(userRoutine: NSLMgrNotifyProcPtr): NSLMgrNotifyUPP; { old name was NewNSLMgrNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNSLClientNotifyUPP(userRoutine: NSLClientNotifyProcPtr): NSLClientNotifyUPP; { old name was NewNSLClientNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeNSLMgrNotifyUPP(userUPP: NSLMgrNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeNSLClientNotifyUPP(userUPP: NSLClientNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeNSLMgrNotifyUPP(VAR thePluginAsyncInfo: NSLPluginAsyncInfo; userRoutine: NSLMgrNotifyUPP); { old name was CallNSLMgrNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeNSLClientNotifyUPP(VAR theClientAsyncInfo: NSLClientAsyncInfo; userRoutine: NSLClientNotifyUPP); { old name was CallNSLClientNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
   this struct is a format for dealing with our internal data representation.  Typed data will be contiguous chunk of
   memory, with the first 4 bytes being a data "descriptor".
}

TYPE
	NSLTypedDataPtr = ^NSLTypedData;
	NSLTypedData = RECORD
		dataType:				UInt32;
		lengthOfData:			UInt32;
	END;

{
   This is just a header at the beginning of a handle that stores our list of service types.
   Each service type is a pascal string, so each service type starts after the end of the
   previous one.
}
	NSLServicesListHeaderPtr = ^NSLServicesListHeader;
	NSLServicesListHeader = RECORD
		numServices:			UInt32;
		logicalLen:				UInt32;									{  length of all usable data in handle }
	END;

{  some defs for common protocols }
{
   general information from a plug-in.  Includes supported protocols, data types and services,
   as well as an info/comment string describing the function of the plug-in in human-readable
   form.  The offsets point to the beginning of each list of data returned, and the protocol
   data offset is the startOfData member of the struct
}
	NSLPluginDataPtr = ^NSLPluginData;
	NSLPluginData = RECORD
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		reserved3:				LONGINT;
		supportsRegistration:	BOOLEAN;
		isPurgeable:			BOOLEAN;
		totalLen:				UInt16;									{  length of everything, including header }
		dataTypeOffset:			UInt16;
		serviceListOffset:		UInt16;
		protocolListOffset:		UInt16;
		commentStringOffset:	UInt16;
																		{  protocol data is first on the list }
	END;

{
  -----------------------------------------------------------------------------
    Finding out if the library is present and getting its version
  -----------------------------------------------------------------------------
}

FUNCTION NSLLibraryVersion: UInt32;

{
    NSLLibraryPresent() is a macro available only in C/C++.  
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NSLURLFilterProcPtr = FUNCTION(url: CStringPtr; VAR displayString: Str255): BOOLEAN;
{$ELSEC}
	NSLURLFilterProcPtr = ProcPtr;
{$ENDC}

{  you can provide for calls to NSLStandardGetURL }
{$IFC TYPED_FUNCTION_POINTERS}
	NSLEventProcPtr = PROCEDURE(VAR newEvent: EventRecord; userContext: UNIV Ptr);
{$ELSEC}
	NSLEventProcPtr = ProcPtr;
{$ENDC}

	NSLURLFilterUPP = UniversalProcPtr;
	NSLEventUPP = UniversalProcPtr;

CONST
	uppNSLURLFilterProcInfo = $000003D0;
	uppNSLEventProcInfo = $000003C0;

FUNCTION NewNSLURLFilterUPP(userRoutine: NSLURLFilterProcPtr): NSLURLFilterUPP; { old name was NewNSLURLFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNSLEventUPP(userRoutine: NSLEventProcPtr): NSLEventUPP; { old name was NewNSLEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeNSLURLFilterUPP(userUPP: NSLURLFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeNSLEventUPP(userUPP: NSLEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeNSLURLFilterUPP(url: CStringPtr; VAR displayString: Str255; userRoutine: NSLURLFilterUPP): BOOLEAN; { old name was CallNSLURLFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeNSLEventUPP(VAR newEvent: EventRecord; userContext: UNIV Ptr; userRoutine: NSLEventUPP); { old name was CallNSLEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  -----------------------------------------------------------------------------
    High level API calls: the following two calls are ALL an application needs
    to register/deregister its service.
    If you use these, you don't need to make any of the other calls to NSLAPI 
    (including NSLOpenNavigationAPI) 
  -----------------------------------------------------------------------------
}

{ <--- error code from registration }
{ ---> urlToRegister is a null terminated url that has only legal characters defined for URLs.  Use HexEncodeText to encode}
{          portions of the url that have illegal characters }
{ ---> neighborhoodToRegisterIn is an optional parameter for explicitly defining a neighborhood to register in.
            If parameter is NULL, then the plugins will determine where to register the service }
FUNCTION NSLStandardRegisterURL(urlToRegister: NSLPath; neighborhoodToRegisterIn: NSLNeighborhood): NSLError;
{ <--- error code from registration }
{ ---> urlToRegister is a null terminated url that has only legal characters defined for URLs.  Use HexEncodeText to encode}
{          portions of the url that have illegal characters }
{ ---> neighborhoodToDeregisterIn is an optional parameter for explicitly defining a neighborhood to register in.
            If parameter is NULL, then the plugins will determine where to register the service }
FUNCTION NSLStandardDeregisterURL(urlToDeregister: NSLPath; neighborhoodToDeregisterIn: NSLNeighborhood): NSLError;
{ <--- function returns OSStatus of the operation.  noErr will be returned if valid, kNSLUserCanceled will be returned if the user cancels }
{ ---> dialogOptions }
{ ---> eventProc }
{ ---> eventProcContextPtr }
{ ---> filterProc }
{ ---> serviceTypeList }
{ <--- userSelectedURL }
{ NSLDialogOptions* dialogOptions }
{
   dialogOptions is a user defined structure defining the look, feel and operation of NSLStandardGetURL dialog
   default behavior can be achieved by passing in a pointer to a structure that has been filled out by a previous
   call to NSLGetDefaultDialogOptions or by passing in NULL.
}
{ NSLEventUPP eventProc }
{
   the eventProc is a callback NSLURLFilterUPP that will
   get called with Events that the dialog doesn't handle.  If you pass in nil,
   you won't get update events while the NSLStandardGetURL dialog is open.
}
{ void* eventProcContextPtr }
{  you can provide a pointer to some contextual data that you want to have sent to your eventProc filter }
{ NSLURLFilterProcPtr filterProc }
{
   the filter param is a callback NSLURLFilterUPP that
   will get called (if not nil) for each url that is going to be displayed in
   the dialog's result list.  A result of false will not include the url for the
   user to select from.  You also have the option of handling the way the url looks
   in the dialog listing by copying the preferred name into the displayString
   parameter.  (If left alone, NSLStandardGetURL dialog will strip the service type
   portion off the url).
}
{ char* serviceTypeList }
{
   the serviceTypeList parameter is a null terminated string that will 
   directly affect the contents of the services popup in the dialog.
   The structure of this string is a set of tuples as follows:
   Name of ServiceType as to be represented in the popup followed by
   a comma delimted list of service descriptors (ie http,https) that will
   used in the search of that type.  Each comma delimited tuple is delimited
   by semi-colons.
}
{
   For example:
   If you want to search for services of type http (web), https (secure web),
   and ftp, you could pass in the string "Web Servers,http,https;FTP Servers,ftp".
   This would result in a popup list with two items ("Web Servers" and "FTP Servers")
   and searches performed on them will provide results of type http and https for the
   first, and ftp for the second.
}

{
   Results list Icons:
   NSLStandardGetURL provides icons in its listings for the following types:
   "http", "https", "ftp", "afp", "lpr", "LaserWriter", "AFPServer"
   any other types will get a generic icon.  However, you can provide icons
   if you wish by including an '#ics8' resource id at the end of your comma
   delimited list.  The dialog will then use that icon if found in its results
   list.  This icon will be used for all types in a tuple.
   For example:
   The param "Web Servers,http,https;Telnet Servers,telnet;NFS Servers,nfs,129"
   would result in lists of http and https services to be shown with their default
   icons, telnet servers would be shown with the default misc. icon and nfs
   servers would be shown with your icon at resource id 129.
}

{ char** url }
{
   pass in the address of a char* and it will point to the resulting url.  If the user
   cancels (the function returns false), the pointer will be set to nil.  If the function
   returns true (user selected a url), then you must call NSLFreeURL on the pointer when
   you are done with it.
}
{
   Call this to have the user select a url based service from a dialog.
   Function takes on input an optional filter proc, a serviceTypeList, and an address to a Ptr.
   Function sets the value of the Ptr to a newly created c-style null terminated string
   containing the user's choice of URL.
}

FUNCTION NSLStandardGetURL(dialogOptions: NSLDialogOptionsPtr; eventProc: NSLEventUPP; eventProcContextPtr: UNIV Ptr; filterProc: NSLURLFilterUPP; serviceTypeList: CStringPtr; VAR userSelectedURL: CStringPtr): OSStatus;
{ ----------------------------------------------------------------------------- }

FUNCTION NSLHexEncodeText(rawText: ConstCStringPtr; rawTextLen: UInt16; newTextBuffer: CStringPtr; VAR newTextBufferLen: UInt16; VAR textChanged: BOOLEAN): OSStatus;
FUNCTION NSLHexDecodeText(encodedText: ConstCStringPtr; encodedTextLen: UInt16; decodedTextBuffer: CStringPtr; VAR decodedTextBufferLen: UInt16; VAR textChanged: BOOLEAN): OSStatus;
FUNCTION NSLGetDefaultDialogOptions(VAR dialogOptions: NSLDialogOptions): OSStatus;
{ <--- function returns null (useful for setting variable at same time as freeing it }
{ ---> url is memory created by a call to NSLStandardGetURL }
FUNCTION NSLFreeURL(url: CStringPtr): CStringPtr;
{
  -----------------------------------------------------------------------------
    Basic API Utility calls: sufficient to create, and parse data structures
  -----------------------------------------------------------------------------
}

FUNCTION NSLMakeNewServicesList(initialServiceList: ConstCStringPtr): NSLServicesList;
FUNCTION NSLAddServiceToServicesList(serviceList: NSLServicesList; serviceType: NSLServiceType): NSLError;
PROCEDURE NSLDisposeServicesList(theList: NSLServicesList);
{
    The name reflects the name of the Neighborhood, i.e. "apple.com." or "AppleTalk Zone One".
    The protocolList is a comma delimited list of protocols that the Neighborhood might exist in.
    If the user passes in NULL, then all protocols will be queried.  The result must be disposed
    of by the user by calling NSLFreeNeighborhood.
}
FUNCTION NSLMakeNewNeighborhood(name: ConstCStringPtr; protocolList: ConstCStringPtr): NSLNeighborhood;
{ creates an exact copy of an existing neighborhood }
FUNCTION NSLCopyNeighborhood(neighborhood: NSLNeighborhood): NSLNeighborhood;
FUNCTION NSLFreeNeighborhood(neighborhood: NSLNeighborhood): NSLNeighborhood;
PROCEDURE NSLGetNameFromNeighborhood(neighborhood: NSLNeighborhood; VAR name: CStringPtr; VAR length: LONGINT);
{
   create a block of formatted data, pointed to by newDataPtr.  This will be used
   in calls (typically request-related calls) for plug-ins that handle the NSL data type.
}
FUNCTION NSLMakeServicesRequestPB(serviceList: NSLServicesList; VAR newDataPtr: NSLTypedDataPtr): OSStatus;
{  releases any storage created with MakeXXXPB calls, associated with TypedData. }
FUNCTION NSLFreeTypedDataPtr(nslTypeData: NSLTypedDataPtr): NSLTypedDataPtr;
{
   utility function that returns whether a url was found, a pointer to the beginning
   of the url, and the length of the URL.
}
FUNCTION NSLGetNextUrl(infoPtr: NSLClientAsyncInfoPtr; VAR urlPtr: CStringPtr; VAR urlLength: LONGINT): BOOLEAN;
{
   utility function that returns whether a Neighborhood was found, a pointer to the beginning
   of the Neighborhood, and the length of the Neighborhood.
}
FUNCTION NSLGetNextNeighborhood(infoPtr: NSLClientAsyncInfoPtr; VAR neighborhood: NSLNeighborhood; VAR neighborhoodLength: LONGINT): BOOLEAN;

{
   NSLErrorToString:    convert a numeric error code to its string equivalent.  Caller must
                        have allocated sufficient space to store both strings.  (Max 255 chars each)
                                
                        The errorString parameter will return a textual explanation of what is wrong,
                        while the solutionString returns a possible solution to get around the problem
}

FUNCTION NSLErrorToString(theErr: NSLError; errorString: CStringPtr; solutionString: CStringPtr): OSStatus;

{
  -----------------------------------------------------------------------------
    Basic API calls: sufficient to create simple requests, and receive answers
  -----------------------------------------------------------------------------
}

FUNCTION NSLOpenNavigationAPI(VAR newRef: NSLClientRef): OSStatus;
PROCEDURE NSLCloseNavigationAPI(theClient: NSLClientRef);
{
    NSLPrepareRequest:  creates an NSLRequestRef, sets up some internal data
    notifier is an NSLClientNotifyUPP that will be called when data is available, when the lookup has
    completed, or if an error occurs.  When the notifier is called, the cookie will be the NSLRequestRef.
    If notifier is NULL, then the NSLManager will assume that the request is made synchronously.  This
    should only be used while in a separate thread, so that the client app can still process events, etc.
    
    contextPtr is a void* which is passed as the contextPtr argument when the notifier is called.  
    
    upon exit:
    1) ref will contain a pointer to a NSLRequestRef which must be passed to all other functions
    which require a NSLRequestRef.
    2) infoPtr will point to a newly created ClientAsycnInfoPtr which will be disposed by the manager when the search is completed
    NOTE: Only one search can be running at a time per clientRef.
}

FUNCTION NSLPrepareRequest(notifier: NSLClientNotifyUPP; contextPtr: UNIV Ptr; theClient: NSLClientRef; VAR ref: NSLRequestRef; bufPtr: CStringPtr; bufLen: UInt32; VAR infoPtr: NSLClientAsyncInfoPtr): NSLError;

{
   NSLStartNeighborhoodLookup: looking for neighborhoods associated with or neighboring a particular neighborhood
    Passing in NULL for neighborhood will generate a list of a default neighborhood(s)
   
}

FUNCTION NSLStartNeighborhoodLookup(ref: NSLRequestRef; neighborhood: NSLNeighborhood; VAR asyncInfo: NSLClientAsyncInfo): NSLError;
{
   NSLStartServicesLookup: starts looking for entities if the specified type in the specified neighborhood
   
}

FUNCTION NSLStartServicesLookup(ref: NSLRequestRef; neighborhood: NSLNeighborhood; requestData: NSLTypedDataPtr; VAR asyncInfo: NSLClientAsyncInfo): NSLError;

{  NSLContinueLookup:  continues a paused/outstanding lookup }

FUNCTION NSLContinueLookup(VAR asyncInfo: NSLClientAsyncInfo): NSLError;

{  NSLCancelRequest: cancels an ongoing search }

FUNCTION NSLCancelRequest(ref: NSLRequestRef): NSLError;
{
   NSLDeleteRequest: deletes info associated with this ref.  The ClientAsyncInfoPtr will no longer be valid
    This must be called when the client is no longer using this requestRef.
}

FUNCTION NSLDeleteRequest(ref: NSLRequestRef): NSLError;

{
  -----------------------------------------------------------------------------
   Utility API calls: use these accessors to manipulate NSL's typed data
  -----------------------------------------------------------------------------
}

{  NSLParseServicesRequestPB provides the inverse of NSLMakeRequestPB, filling out the offsets found within newDataPtr }
{ <--- returns an OSStatus if any errors occur parsing the data }
{ <--- newDataPtr is the construct passed to the plugin }
{ ---> serviceListPtr is the address of a pointer which will be set to point at the portion of the newDataPtr that holds the serviceList to be searched }
{ ---> serviceListLen is the length of the serviceListPtr data pointed to by serviceListPtr }
FUNCTION NSLParseServicesRequestPB(newDataPtr: NSLTypedDataPtr; VAR serviceListPtr: CStringPtr; VAR serviceListLen: UInt16): OSStatus;

{  NSLParseServiceRegistrationPB provides for breaking apart a registration request from a client to a plugin }
{ <--- returns an OSStatus if any errors occur parsing the data }
{ <--- newDataPtr is the construct passed to the plugin }
{ ---> neighborhoodPtr gets set to point at the portion of the newDataPtr that contains the neighborhood }
{ ---> neighborhoodLen is the length of the neighborhood pointed to by neighborhoodPtr }
{ ---> urlPtr is the address of a pointer which will be set to point at the portion of the newDataPtr that holds the url to be registered }
{ ---> urlLen is the length of the url data pointed to by urlPtr }
FUNCTION NSLParseServiceRegistrationPB(newDataPtr: NSLTypedDataPtr; VAR neighborhoodPtr: NSLNeighborhood; VAR neighborhoodLen: UInt16; VAR urlPtr: CStringPtr; VAR urlLen: UInt16): OSStatus;
{
    NSLGetErrorStringsFromResource makes a basic assumption!
    errorString and solutionString both point to valid memory of at least 256 bytes!
}
{ <--- returns an OSStatus if any errors occur }
{ ---> theErr is an OSStatus to be matched against a resource list of errors }
{ ---> fileSpecPtr is a FSSpecPtr to the resource containing the list of errors }
{ ---> errorResID is the resourceID of the NSLI resource of the list of errors }
{ <--> errorString is a pointer to valid memory of at least 256 bytes which will be filled out by the error portion of the error string }
{ <--> solutionString is a pointer to valid memory of at least 256 bytes which will be filled out by the solution portion of the error string }
FUNCTION NSLGetErrorStringsFromResource(theErr: OSStatus; {CONST}VAR fileSpecPtr: FSSpec; errorResID: SInt16; errorString: CStringPtr; solutionString: CStringPtr): OSStatus;
{ <--- Returns true if given service is in the given service list }
{ ---> serviceList is a valid NSLServicesList containing information about services to be searched }
{ ---> svcToFind is an NSLServiceType of a particular service to check if it is in the serviceList }
FUNCTION NSLServiceIsInServiceList(serviceList: NSLServicesList; svcToFind: NSLServiceType): BOOLEAN;
{ <--- returns an OSStatus if any errors occur parsing the data }
{ ---> svcString is the address of a pointer which will be set to point at the portion of theURL that holds the serviceType of theURL }
{ ---> svcLen is the length of the serviceType pointed to by svcString }
FUNCTION NSLGetServiceFromURL(theURL: CStringPtr; VAR svcString: CStringPtr; VAR svcLen: UInt16): OSStatus;
{ <--- returns the length of a Neighborhood data structure }
{ ---> neighborhood is a valid NSLNeighborhood }
FUNCTION NSLGetNeighborhoodLength(neighborhood: NSLNeighborhood): LONGINT;
{
  -------------------------------------------------------------------------------------
   Utility API calls: use these routines to separate plugin threads from client threads
  -------------------------------------------------------------------------------------
}

{ this routine works the same as the Thread manager's routine NewThread, except }
{ that the thread is added to the NSL manager's thread list. }
FUNCTION NSLNewThread(threadStyle: ThreadStyle; threadEntry: ThreadEntryProcPtr; threadParam: UNIV Ptr; stackSize: Size; options: ThreadOptions; VAR threadResult: UNIV Ptr; VAR threadMade: ThreadID): OSErr;
{ this routine works the same as the Thread manager's routine DisposeThread, except }
{ that the thread is removed from the NSL manager's thread list. }
FUNCTION NSLDisposeThread(threadToDump: ThreadID; threadResult: UNIV Ptr; recycleThread: BOOLEAN): OSErr;
{$IFC OLDROUTINENAMES }

TYPE
	ClientAsyncInfo						= NSLClientAsyncInfo;
	ClientAsyncInfoPtr 					= ^ClientAsyncInfo;
	PluginAsyncInfo						= NSLPluginAsyncInfo;
	PluginAsyncInfoPtr 					= ^PluginAsyncInfo;
	TypedData							= NSLTypedData;
	TypedDataPtr 						= ^TypedData;
	PluginData							= NSLPluginData;
	PluginDataPtr 						= ^PluginData;
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NSLIncludes}

{$ENDC} {__NSL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
