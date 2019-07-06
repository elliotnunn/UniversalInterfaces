{
 	File:		HTMLRendering.p
 
 	Contains:	HTML Rendering Library Interfaces.
 
 	Version:	Technology:	1.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT HTMLRendering;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __HTMLRENDERING__}
{$SETC __HTMLRENDERING__ := 1}

{$I+}
{$SETC HTMLRenderingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	HRReference = ^LONGINT; { an opaque 32-bit type }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION HRGetHTMLRenderingLibVersion(VAR returnVers: NumVersion): OSStatus;
FUNCTION HRHTMLRenderingLibAvailable: BOOLEAN;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_RT_MAC_CFM }
{$ENDC}  {TARGET_RT_MAC_CFM}


CONST
	kHRRendererHTML32Type		= 'ht32';						{  HTML 3.2  }


{$IFC CALL_NOT_IN_CARBON }
FUNCTION HRNewReference(VAR hrRef: HRReference; rendererType: OSType; grafPtr: GrafPtr): OSStatus;
FUNCTION HRDisposeReference(hrRef: HRReference): OSStatus;

FUNCTION HRFreeMemory(inBytesNeeded: Size): SInt32;

{ System level notifications }
PROCEDURE HRScreenConfigurationChanged;
FUNCTION HRIsHREvent({CONST}VAR eventRecord: EventRecord): BOOLEAN;

{ Drawing }
FUNCTION HRSetGrafPtr(hrRef: HRReference; grafPtr: GrafPtr): OSStatus;
FUNCTION HRActivate(hrRef: HRReference): OSStatus;
FUNCTION HRDeactivate(hrRef: HRReference): OSStatus;
FUNCTION HRDraw(hrRef: HRReference; updateRgnH: RgnHandle): OSStatus;
FUNCTION HRSetRenderingRect(hrRef: HRReference; {CONST}VAR renderingRect: Rect): OSStatus;
FUNCTION HRGetRenderedImageSize(hrRef: HRReference; VAR renderingSize: Point): OSStatus;
FUNCTION HRScrollToLocation(hrRef: HRReference; VAR location: Point): OSStatus;
FUNCTION HRForceQuickdraw(hrRef: HRReference; forceQuickdraw: BOOLEAN): OSStatus;
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	HRScrollbarState 			= SInt16;
CONST
	eHRScrollbarOn				= 0;
	eHRScrollbarOff				= 1;
	eHRScrollbarAuto			= 2;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION HRSetScrollbarState(hrRef: HRReference; hScrollbarState: HRScrollbarState; vScrollbarState: HRScrollbarState): OSStatus;
FUNCTION HRSetDrawBorder(hrRef: HRReference; drawBorder: BOOLEAN): OSStatus;
FUNCTION HRSetGrowboxCutout(hrRef: HRReference; allowCutout: BOOLEAN): OSStatus;
{ Navigation }
FUNCTION HRGoToFile(hrRef: HRReference; {CONST}VAR fsspec: FSSpec; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;
FUNCTION HRGoToURL(hrRef: HRReference; url: ConstCStringPtr; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;
FUNCTION HRGoToAnchor(hrRef: HRReference; anchorName: ConstCStringPtr): OSStatus;
FUNCTION HRGoToPtr(hrRef: HRReference; buffer: CStringPtr; bufferSize: UInt32; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;
{ Accessors }
{ either file url or url of <base> tag }
FUNCTION HRGetRootURL(hrRef: HRReference; rootURLH: Handle): OSStatus;
{ url of <base> tag }
FUNCTION HRGetBaseURL(hrRef: HRReference; baseURLH: Handle): OSStatus;
{ file url }
FUNCTION HRGetHTMLURL(hrRef: HRReference; HTMLURLH: Handle): OSStatus;
FUNCTION HRGetTitle(hrRef: HRReference; title: StringPtr): OSStatus;
FUNCTION HRGetHTMLFile(hrRef: HRReference; VAR fsspec: FSSpec): OSStatus;

{ Utilities }
FUNCTION HRUtilCreateFullURL(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; fullURLH: Handle): OSStatus;
FUNCTION HRUtilGetFSSpecFromURL(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; VAR destSpec: FSSpec): OSStatus;
{ urlHandle should be valid on input }
FUNCTION HRUtilGetURLFromFSSpec({CONST}VAR fsspec: FSSpec; urlHandle: Handle): OSStatus;
{
	Visited links

	If you register a function here, it will be called to determine
	whether or not the given URL has been visited. It should return
	true if the URL has been visited.
	
	In addition to the URLs that the application may add to the list
	of visited links, it should also add URLs that the user clicks
	on. These URLs can be caught by the "add URL to history" callback
	below.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRWasURLVisitedProcPtr = FUNCTION(url: ConstCStringPtr; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	HRWasURLVisitedProcPtr = ProcPtr;
{$ENDC}

	HRWasURLVisitedUPP = UniversalProcPtr;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE HRRegisterWasURLVisitedUPP(inWasURLVisitedUPP: HRWasURLVisitedUPP; hrRef: HRReference; inRefCon: UNIV Ptr);
PROCEDURE HRUnregisterWasURLVisitedUPP(hrRef: HRReference);


{
	New URL

	If you register a function here, it will be called every time
	the renderer is going to display a new URL. A few examples of how
	you might use this include...
	
		(a) maintaining a history of URLs
		(b) maintainging a list of visited links
		(c) setting a window title based on the new URL
}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRNewURLProcPtr = FUNCTION(url: ConstCStringPtr; targetFrame: ConstCStringPtr; addToHistory: BOOLEAN; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	HRNewURLProcPtr = ProcPtr;
{$ENDC}

	HRNewURLUPP = UniversalProcPtr;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE HRRegisterNewURLUPP(inNewURLUPP: HRNewURLUPP; hrRef: HRReference; inRefCon: UNIV Ptr);
PROCEDURE HRUnregisterNewURLUPP(hrRef: HRReference);



{
	URL to FSSpec function

	If you register a function here, it will be called every time
	the renderer is going to locate a file. The function will be
	passed an enum indicating the type of file being asked for.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	URLSourceType 				= UInt16;
CONST
	kHRLookingForHTMLSource		= 1;
	kHRLookingForImage			= 2;
	kHRLookingForEmbedded		= 3;
	kHRLookingForImageMap		= 4;
	kHRLookingForFrame			= 5;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRURLToFSSpecProcPtr = FUNCTION(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; VAR fsspec: FSSpec; urlSourceType: URLSourceType; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	HRURLToFSSpecProcPtr = ProcPtr;
{$ENDC}

	HRURLToFSSpecUPP = UniversalProcPtr;
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE HRRegisterURLToFSSpecUPP(inURLToFSSpecUPP: HRURLToFSSpecUPP; hrRef: HRReference; inRefCon: UNIV Ptr);
PROCEDURE HRUnregisterURLToFSSpecUPP(hrRef: HRReference);


{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	uppHRWasURLVisitedProcInfo = $000003D0;
	uppHRNewURLProcInfo = $000037F0;
	uppHRURLToFSSpecProcInfo = $0000EFF0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewHRWasURLVisitedUPP(userRoutine: HRWasURLVisitedProcPtr): HRWasURLVisitedUPP; { old name was NewHRWasURLVisitedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHRNewURLUPP(userRoutine: HRNewURLProcPtr): HRNewURLUPP; { old name was NewHRNewURLProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHRURLToFSSpecUPP(userRoutine: HRURLToFSSpecProcPtr): HRURLToFSSpecUPP; { old name was NewHRURLToFSSpecProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeHRWasURLVisitedUPP(userUPP: HRWasURLVisitedUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeHRNewURLUPP(userUPP: HRNewURLUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeHRURLToFSSpecUPP(userUPP: HRURLToFSSpecUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeHRWasURLVisitedUPP(url: ConstCStringPtr; refCon: UNIV Ptr; userRoutine: HRWasURLVisitedUPP): BOOLEAN; { old name was CallHRWasURLVisitedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeHRNewURLUPP(url: ConstCStringPtr; targetFrame: ConstCStringPtr; addToHistory: BOOLEAN; refCon: UNIV Ptr; userRoutine: HRNewURLUPP): OSStatus; { old name was CallHRNewURLProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeHRURLToFSSpecUPP(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; VAR fsspec: FSSpec; urlSourceType: URLSourceType; refCon: UNIV Ptr; userRoutine: HRURLToFSSpecUPP): OSStatus; { old name was CallHRURLToFSSpecProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := HTMLRenderingIncludes}

{$ENDC} {__HTMLRENDERING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
