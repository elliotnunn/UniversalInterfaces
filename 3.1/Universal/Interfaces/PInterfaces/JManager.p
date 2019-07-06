{
 	File:		JManager.p
 
 	Contains:	Routines that can be used to invoke the Java Virtual Machine in MRJ 
 
 	Version:	Technology:	MRJ 2.0
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1996-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT JManager;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __JMANAGER__}
{$SETC __JMANAGER__ := 1}

{$I+}
{$SETC JManagerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



CONST
	kJMVersion					= $11000003;					{  using Sun's 1.1 APIs, our current APIs.  }
	kDefaultJMTime				= $00000400;					{  how much time to give the JM library on "empty" events, in milliseconds.  }

	kJMVersionError				= -60000;
	kJMExceptionOccurred		= -60001;
	kJMBadClassPathError		= -60002;

{
 *	Private data structures
 *
 *	JMClientData		- enough bits to reliably store a pointer to arbitrary, client-specific data. 
 *	JMSessionRef		- references the entire java runtime 
 *	JMTextRef			- a Text string, length, and encoding 
 *	JMTextEncoding		- which encoding to use when converting in and out of Java strings.
 *	JMFrameRef			- a java frame 
 *	JMAWTContextRef 	- a context for the AWT to request frames, process events 
 *	JMAppletLocatorRef	- a device for locating, fetching, and parsing URLs that may contain applets 
 *	JMAppletViewerRef	- an object that displays applets in a Frame 
 }

TYPE
	JMClientData						= Ptr;
	JMSessionRef = ^LONGINT;
	JMFrameRef = ^LONGINT;
	JMTextRef = ^LONGINT;
	JMAWTContextRef = ^LONGINT;
	JMAppletLocatorRef = ^LONGINT;
	JMAppletViewerRef = ^LONGINT;
	JMTextEncoding						= TextEncoding;

{
 * The runtime requires certain callbacks be used to communicate between
 * session events and the embedding application.
 *
 * In general, you can pass nil as a callback and a "good" default will be used.
 *
 *	JMConsoleProcPtr  		- redirect stderr or stdout - the message is delivered in the encoding specified when
 *								you created the session, or possibly binary data.
 *	JMConsoleReadProcPtr 	- take input from the user from a console or file.  The input is expected to 
 *								be in the encoding specified when you opened the session.
 *	JMExitProcPtr  			- called via System.exit(int), return "true" to kill the current thread,
 *								false, to cause a 'QUIT' AppleEvent to be sent to the current process,
 *								or just tear down the runtime and exit to shell immediately
 * JMLowMemoryProcPtr  		- This callback is available to notify the embedding application that
 *								a low memory situation has occurred so it can attempt to recover appropriately.
 * JMAuthenicateURLProcPtr  - prompt the user for autentication based on the URL.  If you pass
 *								nil, JManager will prompt the user.  Return false if the user pressed cancel.
 }
{$IFC TYPED_FUNCTION_POINTERS}
	JMConsoleProcPtr = PROCEDURE(session: JMSessionRef; message: UNIV Ptr; messageLengthInBytes: UInt32); C;
{$ELSEC}
	JMConsoleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMConsoleReadProcPtr = FUNCTION(session: JMSessionRef; buffer: UNIV Ptr; maxBufferLength: SInt32): SInt32; C;
{$ELSEC}
	JMConsoleReadProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMExitProcPtr = FUNCTION(session: JMSessionRef; value: LONGINT): BOOLEAN; C;
{$ELSEC}
	JMExitProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMAuthenticateURLProcPtr = FUNCTION(session: JMSessionRef; url: ConstCStringPtr; realm: ConstCStringPtr; VAR userName: CHAR; VAR password: CHAR): BOOLEAN; C;
{$ELSEC}
	JMAuthenticateURLProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMLowMemoryProcPtr = PROCEDURE(session: JMSessionRef); C;
{$ELSEC}
	JMLowMemoryProcPtr = ProcPtr;
{$ENDC}

	JMSessionCallbacksPtr = ^JMSessionCallbacks;
	JMSessionCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fStandardOutput:		JMConsoleProcPtr;						{  JM will route "stdout" to this function.  }
		fStandardError:			JMConsoleProcPtr;						{  JM will route "stderr" to this function.  }
		fStandardIn:			JMConsoleReadProcPtr;					{  read from console - can be nil for default behavior (no console IO)  }
		fExitProc:				JMExitProcPtr;							{  handle System.exit(int) requests  }
		fAuthenticateProc:		JMAuthenticateURLProcPtr;				{  present basic authentication dialog  }
		fLowMemProc:			JMLowMemoryProcPtr;						{  Low Memory notification Proc  }
	END;

	JMVerifierOptions 			= LONGINT;
CONST
	eDontCheckCode				= {JMVerifierOptions}0;
	eCheckRemoteCode			= {JMVerifierOptions}1;
	eCheckAllCode				= {JMVerifierOptions}2;


{
 * JMRuntimeOptions is a mask that allows you to specify certain attributes
 * for the runtime. Bitwise or the fields together, or use one of the "premade" entries.
 * eJManager2Defaults is the factory default, and best bet to use.
 }

TYPE
	JMRuntimeOptions 			= LONGINT;
CONST
	eJManager2Defaults			= {JMRuntimeOptions}0;
	eUseAppHeapOnly				= {JMRuntimeOptions}$01;
	eDisableJITC				= {JMRuntimeOptions}$02;
	eEnableDebugger				= {JMRuntimeOptions}$04;
	eDisableInternetConfig		= {JMRuntimeOptions}$08;
	eInhibitClassUnloading		= {JMRuntimeOptions}$10;
	eEnableProfiling			= {JMRuntimeOptions}$20;
	eJManager1Compatible		= {JMRuntimeOptions}$18;




{
 * Returns the version of the currently installed JManager library.
 * Compare to kJMVersion.  This is the only call that doesn't
 * require a session, or a reference to something that references
 * a session.
 }
FUNCTION JMGetVersion: UInt32; C;
{
 * JMOpenSession creates a new Java Runtime.  Note that JManger 2.0 doesn't set 
 * security options at the time of runtime instantiation.  AppletViewer Objecs have
 * seperate security attributes bound to them, and the verifier is availiable elsewhere
 * as well.  The client data parameter lets a client associate an arbitgrary tagged pointer
 * with the seession.
 * When you create the session, you must specify the desired Text Encoding to use for
 * console IO.  Usually, its OK to use "kTextEncodingMacRoman".  See TextCommon.h for the list.
 }
FUNCTION JMOpenSession(VAR session: JMSessionRef; runtimeOptions: JMRuntimeOptions; verifyMode: JMVerifierOptions; {CONST}VAR callbacks: JMSessionCallbacks; desiredEncoding: JMTextEncoding; data: JMClientData): OSStatus; C;
FUNCTION JMCloseSession(session: JMSessionRef): OSStatus; C;

{
 * Client data getter/setter functions.
 }
FUNCTION JMGetSessionData(session: JMSessionRef; VAR data: JMClientData): OSStatus; C;
FUNCTION JMSetSessionData(session: JMSessionRef; data: JMClientData): OSStatus; C;

{
 * Prepend the target of the FSSpec to the class path.
 * If a file, .zip or other known archive file - not a .class file
 }
FUNCTION JMAddToClassPath(session: JMSessionRef; {CONST}VAR spec: FSSpec): OSStatus; C;

{
 * Utility returns (client owned) null terminated handle containing "file://xxxx", or nil if fnfErr
 }
FUNCTION JMFSSToURL(session: JMSessionRef; {CONST}VAR spec: FSSpec): Handle; C;

{
 * Turns "file:///disk/file" into an FSSpec.  other handlers return paramErr
 }
FUNCTION JMURLToFSS(session: JMSessionRef; urlString: ConstCStringPtr; VAR spec: FSSpec): OSStatus; C;

{
 * JMIdle gives time to all Java threads. Giving more time makes Java programs run faster,
 * but can reduce overall system responsiveness. JMIdle will return sooner if low-level (user)
 * events appear in the event queue.
 }
FUNCTION JMIdle(session: JMSessionRef; jmTimeMillis: UInt32): OSStatus; C;

{
 * Java defines system-wide properties that applets can use to make queries about the
 * host system. Many of these properties correspond to defaults provided by "Internet Config."
 * JMPutSessionProperty can be used by a client program to modify various system-wide properties.
 }
FUNCTION JMGetSessionProperty(session: JMSessionRef; propertyName: JMTextRef; VAR propertyValue: JMTextRef): OSStatus; C;
FUNCTION JMPutSessionProperty(session: JMSessionRef; propertyName: JMTextRef; propertyValue: JMTextRef): OSStatus; C;

{
 * JMText: opaque object that encapsulates a string, length, and
 * character encoding.  Strings passed between JManager and the
 * embedding application goes through this interface.  Only the most
 * rudimentary conversion routines are supplied - it is expected that
 * the embedding application will most of its work in the System Script.
 *
 * These APIs present some questions about who actually owns the 
 * JMText.  The rule is, if you created a JMTextRef, you are responsible
 * for deleting it after passing it into the runtime.  If the runtime passes
 * one to you, it will be deleted after the callback.
 *
 * If a pointer to an uninitialised JMTextRef is passed in to a routine (eg JMGetSessionProperty),
 * it is assumed to have been created for the caller, and it is the callers responsibility to
 * dispose of it.
 *
 * The encoding types are taken verbatim from the Text Encoding Converter,
 * which handles the ugly backside of script conversion.
 }
{
 * JMNewTextRef can create from a buffer of data in the specified encoding
 }
FUNCTION JMNewTextRef(session: JMSessionRef; VAR textRef: JMTextRef; encoding: JMTextEncoding; charBuffer: UNIV Ptr; bufferLengthInBytes: UInt32): OSStatus; C;

{
 * JMCopyTextRef clones a text ref.
 }
FUNCTION JMCopyTextRef(textRefSrc: JMTextRef; VAR textRefDst: JMTextRef): OSStatus; C;

{
 * Disposes of a text ref passed back from the runtime, or created explicitly through JMNewTextRef
 }
FUNCTION JMDisposeTextRef(textRef: JMTextRef): OSStatus; C;

{
 * Returns the text length, in characters
 }
FUNCTION JMGetTextLength(textRef: JMTextRef; VAR textLengthInCharacters: UInt32): OSStatus; C;

{
 * Returns the text length, in number of bytes taken in the destination encoding
 }
FUNCTION JMGetTextLengthInBytes(textRef: JMTextRef; dstEncoding: JMTextEncoding; VAR textLengthInBytes: UInt32): OSStatus; C;

{
 * Copies the specified number of characters to the destination buffer with the appropriate
 * destination encoding.
 }
FUNCTION JMGetTextBytes(textRef: JMTextRef; dstEncoding: JMTextEncoding; textBuffer: UNIV Ptr; textBufferLength: UInt32; VAR numCharsCopied: UInt32): OSStatus; C;

{
 * Returns a Handle to a null terminated, "C" string in the System Script.
 }
FUNCTION JMTextToMacOSCStringHandle(textRef: JMTextRef): Handle; C;



{
 * Proxy properties in the runtime.
 *
 * These will only be checked if InternetConfig isn't used to specify properties,
 * or if it doesn't have the data for these.
 }

TYPE
	JMProxyInfoPtr = ^JMProxyInfo;
	JMProxyInfo = RECORD
		useProxy:				BOOLEAN;
		proxyHost:				PACKED ARRAY [0..254] OF CHAR;
		proxyPort:				UInt16;
	END;

	JMProxyType 				= LONGINT;
CONST
	eHTTPProxy					= {JMProxyType}0;
	eFirewallProxy				= {JMProxyType}1;
	eFTPProxy					= {JMProxyType}2;

FUNCTION JMGetProxyInfo(session: JMSessionRef; proxyType: JMProxyType; VAR proxyInfo: JMProxyInfo): OSStatus; C;
FUNCTION JMSetProxyInfo(session: JMSessionRef; proxyType: JMProxyType; {CONST}VAR proxyInfo: JMProxyInfo): OSStatus; C;

{
 * Security - JManager 2.0 security is handled on a per-applet basis.
 * There are some security settings that are inherited from InternetConfig
 * (Proxy Servers) but the verifier can now be enabled and disabled.
 }
FUNCTION JMGetVerifyMode(session: JMSessionRef; VAR verifierOptions: JMVerifierOptions): OSStatus; C;
FUNCTION JMSetVerifyMode(session: JMSessionRef; verifierOptions: JMVerifierOptions): OSStatus; C;



{
 * The basic unit of AWT interaction is the JMFrame.  A JMFrame is bound to top level
 * awt Frame, Window, or Dialog.  When a user event occurs for a MacOS window, the event is passed
 * to the corrosponding frame object.  Similarly, when an AWT event occurs that requires the
 * Mac OS Window to change, a callback is made.  JManager 1.x bound the frame to the window through
 * a callback to set and restore the windows GrafPort.  In JManager 2.0, a GrafPort, Offset, and 
 * ClipRgn are specified up front - changes in visibility and structure require that these be re-set.
 * This enables support for the JavaSoft DrawingSurface API - and also improves graphics performance.
 * You should reset the graphics attributes anytime the visiblity changes, like when scrolling.
 * You should also set it initially when the AWTContext requests the frame.
 * At various times, JM will call back to the client to register a new JMFrame, 
 * indicating the frame type.  The client should take the following steps:
 *
 *	o	Create a new invisible window of the specified type
 *	o	Fill in the callbacks parameter with function pointers
 *	o	Do something to bind the frame to the window (like stuff the WindowPtr in the JMClientData of the frame)
 *	o	Register the visiblity parameters (GrafPtr, etc) with the frame
 }

TYPE
	ReorderRequest 				= LONGINT;
CONST
	eBringToFront				= {ReorderRequest}0;			{  bring the window to front  }
	eSendToBack					= {ReorderRequest}1;			{  send the window to back  }
	eSendBehindFront			= {ReorderRequest}2;			{  send the window behind the front window  }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMSetFrameSizeProcPtr = PROCEDURE(frame: JMFrameRef; {CONST}VAR newBounds: Rect); C;
{$ELSEC}
	JMSetFrameSizeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMFrameInvalRectProcPtr = PROCEDURE(frame: JMFrameRef; {CONST}VAR r: Rect); C;
{$ELSEC}
	JMFrameInvalRectProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMFrameShowHideProcPtr = PROCEDURE(frame: JMFrameRef; showFrameRequested: BOOLEAN); C;
{$ELSEC}
	JMFrameShowHideProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMSetTitleProcPtr = PROCEDURE(frame: JMFrameRef; title: JMTextRef); C;
{$ELSEC}
	JMSetTitleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMCheckUpdateProcPtr = PROCEDURE(frame: JMFrameRef); C;
{$ELSEC}
	JMCheckUpdateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMReorderFrame = PROCEDURE(frame: JMFrameRef; theRequest: ReorderRequest); C;
{$ELSEC}
	JMReorderFrame = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMSetResizeable = PROCEDURE(frame: JMFrameRef; resizeable: BOOLEAN); C;
{$ELSEC}
	JMSetResizeable = ProcPtr;
{$ENDC}

	JMFrameCallbacksPtr = ^JMFrameCallbacks;
	JMFrameCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fSetFrameSize:			JMSetFrameSizeProcPtr;
		fInvalRect:				JMFrameInvalRectProcPtr;
		fShowHide:				JMFrameShowHideProcPtr;
		fSetTitle:				JMSetTitleProcPtr;
		fCheckUpdate:			JMCheckUpdateProcPtr;
		fReorderFrame:			JMReorderFrame;
		fSetResizeable:			JMSetResizeable;
	END;

FUNCTION JMSetFrameVisibility(frame: JMFrameRef; famePort: GrafPtr; frameOrigin: Point; frameClip: RgnHandle): OSStatus; C;
FUNCTION JMGetFrameData(frame: JMFrameRef; VAR data: JMClientData): OSStatus; C;
FUNCTION JMSetFrameData(frame: JMFrameRef; data: JMClientData): OSStatus; C;
FUNCTION JMGetFrameSize(frame: JMFrameRef; VAR result: Rect): OSStatus; C;
{ note that the top left indicates the "global" position of this frame }
{ use this to update the frame position when it gets moved }
FUNCTION JMSetFrameSize(frame: JMFrameRef; {CONST}VAR newSize: Rect): OSStatus; C;
{
 * Dispatch a particular event to an embedded frame
 }
FUNCTION JMFrameClick(frame: JMFrameRef; localPos: Point; modifiers: INTEGER): OSStatus; C;
FUNCTION JMFrameKey(frame: JMFrameRef; asciiChar: ByteParameter; keyCode: ByteParameter; modifiers: INTEGER): OSStatus; C;
FUNCTION JMFrameKeyRelease(frame: JMFrameRef; asciiChar: ByteParameter; keyCode: ByteParameter; modifiers: INTEGER): OSStatus; C;
FUNCTION JMFrameUpdate(frame: JMFrameRef; updateRgn: RgnHandle): OSStatus; C;
FUNCTION JMFrameActivate(frame: JMFrameRef; activate: BOOLEAN): OSStatus; C;
FUNCTION JMFrameResume(frame: JMFrameRef; resume: BOOLEAN): OSStatus; C;
FUNCTION JMFrameMouseOver(frame: JMFrameRef; localPos: Point; modifiers: INTEGER): OSStatus; C;
FUNCTION JMFrameShowHide(frame: JMFrameRef; showFrame: BOOLEAN): OSStatus; C;
FUNCTION JMFrameGoAway(frame: JMFrameRef): OSStatus; C;
FUNCTION JMGetFrameContext(frame: JMFrameRef): JMAWTContextRef; C;
FUNCTION JMFrameDragTracking(frame: JMFrameRef; message: DragTrackingMessage; theDragRef: DragReference): OSStatus; C;
FUNCTION JMFrameDragReceive(frame: JMFrameRef; theDragRef: DragReference): OSStatus; C;
{
 * Window types
 }

TYPE
	JMFrameKind 				= LONGINT;
CONST
	eBorderlessModelessWindowFrame = {JMFrameKind}0;
	eModelessWindowFrame		= {JMFrameKind}1;
	eModalWindowFrame			= {JMFrameKind}2;
	eModelessDialogFrame		= {JMFrameKind}3;




{ JMAWTContext -
 * To create a top level frame, you must use a JMAWTContext object.
 * The JMAWTContext provides a context for the AWT to request frames.
 * A AWTContext has a threadgroup associated with it - all events and processing occurs
 * there.  When you create one, it is quiescent, you must call resume before it begins executing.
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMRequestFrameProcPtr = FUNCTION(context: JMAWTContextRef; newFrame: JMFrameRef; kind: JMFrameKind; {CONST}VAR initialBounds: Rect; resizeable: BOOLEAN; VAR callbacks: JMFrameCallbacks): OSStatus; C;
{$ELSEC}
	JMRequestFrameProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMReleaseFrameProcPtr = FUNCTION(context: JMAWTContextRef; oldFrame: JMFrameRef): OSStatus; C;
{$ELSEC}
	JMReleaseFrameProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMUniqueMenuIDProcPtr = FUNCTION(context: JMAWTContextRef; isSubmenu: BOOLEAN): SInt16; C;
{$ELSEC}
	JMUniqueMenuIDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMExceptionOccurredProcPtr = PROCEDURE(context: JMAWTContextRef; exceptionName: JMTextRef; exceptionMsg: JMTextRef; stackTrace: JMTextRef); C;
{$ELSEC}
	JMExceptionOccurredProcPtr = ProcPtr;
{$ENDC}

	JMAWTContextCallbacksPtr = ^JMAWTContextCallbacks;
	JMAWTContextCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fRequestFrame:			JMRequestFrameProcPtr;					{  a new frame is being created.  }
		fReleaseFrame:			JMReleaseFrameProcPtr;					{  an existing frame is being destroyed.  }
		fUniqueMenuID:			JMUniqueMenuIDProcPtr;					{  a new menu will be created with this id.  }
		fExceptionOccurred:		JMExceptionOccurredProcPtr;				{  just some notification that some recent operation caused an exception.  You can't do anything really from here.  }
	END;

FUNCTION JMNewAWTContext(VAR context: JMAWTContextRef; session: JMSessionRef; {CONST}VAR callbacks: JMAWTContextCallbacks; data: JMClientData): OSStatus; C;
FUNCTION JMDisposeAWTContext(context: JMAWTContextRef): OSStatus; C;
FUNCTION JMGetAWTContextData(context: JMAWTContextRef; VAR data: JMClientData): OSStatus; C;
FUNCTION JMSetAWTContextData(context: JMAWTContextRef; data: JMClientData): OSStatus; C;
FUNCTION JMCountAWTContextFrames(context: JMAWTContextRef; VAR frameCount: UInt32): OSStatus; C;
FUNCTION JMGetAWTContextFrame(context: JMAWTContextRef; frameIndex: UInt32; VAR frame: JMFrameRef): OSStatus; C;
FUNCTION JMMenuSelected(context: JMAWTContextRef; hMenu: MenuHandle; menuItem: INTEGER): OSStatus; C;



{*
 * JMAppletLocator - Since Java applets are always referenced by a Uniform Resource Locator
 * (see RFC 1737, http://www.w3.org/pub/WWW/Addressing/rfc1738.txt), we provide an object
 * that encapsulates the information about a set of applets. A JMAppletLocator is built
 * by providing a base URL, which must point at a valid HTML document containing applet
 * tags. To save a network transaction, the contents of the document may be passed optionally. 
 *
 * You can also use a JMLocatorInfoBlock for a synchronous resolution of the applet,
 * assuming that you already have the info for the tag.
 }

TYPE
	JMLocatorErrors 			= LONGINT;
CONST
	eLocatorNoErr				= {JMLocatorErrors}0;			{  the html was retrieved successfully }
	eHostNotFound				= {JMLocatorErrors}1;			{  the host specified by the url could not be found }
	eFileNotFound				= {JMLocatorErrors}2;			{  the file could not be found on the host }
	eLocatorTimeout				= {JMLocatorErrors}3;			{  a timeout occurred retrieving the html text }
	eLocatorKilled				= {JMLocatorErrors}4;			{  in response to a JMDisposeAppletLocator before it has completed }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMFetchCompleted = PROCEDURE(ref: JMAppletLocatorRef; status: JMLocatorErrors); C;
{$ELSEC}
	JMFetchCompleted = ProcPtr;
{$ENDC}

	JMAppletLocatorCallbacksPtr = ^JMAppletLocatorCallbacks;
	JMAppletLocatorCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fCompleted:				JMFetchCompleted;						{  called when the html has been completely fetched  }
	END;

{
 * These structures are used to pass pre-parsed parameter
 * tags to the AppletLocator.  Implies synchronous semantics.
 }

	JMLIBOptionalParamsPtr = ^JMLIBOptionalParams;
	JMLIBOptionalParams = RECORD
		fParamName:				JMTextRef;								{  could be from a <parameter name=foo value=bar> or "zipbase", etc  }
		fParamValue:			JMTextRef;								{  the value of this optional tag  }
	END;

	JMLocatorInfoBlockPtr = ^JMLocatorInfoBlock;
	JMLocatorInfoBlock = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
																		{  These are required to be present and not nil  }
		fBaseURL:				JMTextRef;								{  the URL of this applet's host page  }
		fAppletCode:			JMTextRef;								{  code= parameter  }
		fWidth:					INTEGER;								{  width= parameter  }
		fHeight:				INTEGER;								{  height= parameter  }
																		{  These are optional parameters  }
		fOptionalParameterCount: LONGINT;								{  how many in this array  }
		fParams:				JMLIBOptionalParamsPtr;					{  pointer to an array of these (points to first element)  }
	END;

FUNCTION JMNewAppletLocator(VAR locatorRef: JMAppletLocatorRef; session: JMSessionRef; {CONST}VAR callbacks: JMAppletLocatorCallbacks; url: JMTextRef; htmlText: JMTextRef; data: JMClientData): OSStatus; C;
FUNCTION JMNewAppletLocatorFromInfo(VAR locatorRef: JMAppletLocatorRef; session: JMSessionRef; {CONST}VAR info: JMLocatorInfoBlock; data: JMClientData): OSStatus; C;
FUNCTION JMDisposeAppletLocator(locatorRef: JMAppletLocatorRef): OSStatus; C;
FUNCTION JMGetAppletLocatorData(locatorRef: JMAppletLocatorRef; VAR data: JMClientData): OSStatus; C;
FUNCTION JMSetAppletLocatorData(locatorRef: JMAppletLocatorRef; data: JMClientData): OSStatus; C;
FUNCTION JMCountApplets(locatorRef: JMAppletLocatorRef; VAR appletCount: UInt32): OSStatus; C;
FUNCTION JMGetAppletDimensions(locatorRef: JMAppletLocatorRef; appletIndex: UInt32; VAR width: UInt32; VAR height: UInt32): OSStatus; C;
FUNCTION JMGetAppletTag(locatorRef: JMAppletLocatorRef; appletIndex: UInt32; VAR tagRef: JMTextRef): OSStatus; C;
FUNCTION JMGetAppletName(locatorRef: JMAppletLocatorRef; appletIndex: UInt32; VAR nameRef: JMTextRef): OSStatus; C;

{
 * JMAppletViewer - Applets are instantiated, one by one, by specifying a JMAppletLocator and
 * a zero-based index (Macintosh API's usually use one-based indexing, the Java language
 * uses zero, however.). The resulting applet is encapsulated in a JMAppletViewer object. 
 * Since applets can have one or more visible areas to draw in, one or more JMFrame objects
 * may be requested while the viewer is being created, or at a later time, thus the client
 * must provide callbacks to satisfy these requests.
 *
 * The window name for the ShowDocument callback is one of:
 *   _self		show in current frame
 *   _parent	show in parent frame
 *   _top		show in top-most frame
 *   _blank		show in new unnamed top-level window
 *   <other>	show in new top-level window named <other> 
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMShowDocumentProcPtr = PROCEDURE(viewer: JMAppletViewerRef; urlString: JMTextRef; windowName: JMTextRef); C;
{$ELSEC}
	JMShowDocumentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMSetStatusMsgProcPtr = PROCEDURE(viewer: JMAppletViewerRef; statusMsg: JMTextRef); C;
{$ELSEC}
	JMSetStatusMsgProcPtr = ProcPtr;
{$ENDC}

	JMAppletViewerCallbacksPtr = ^JMAppletViewerCallbacks;
	JMAppletViewerCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fShowDocument:			JMShowDocumentProcPtr;					{  go to a url, optionally in a new window  }
		fSetStatusMsg:			JMSetStatusMsgProcPtr;					{  applet changed status message  }
	END;

{
 * NEW: per-applet security settings
 * Previously, these settings were attached to the session.
 * JManager 2.0 allows them to be attached to each viewer.
 }
	JMNetworkSecurityOptions 	= LONGINT;
CONST
	eNoNetworkAccess			= {JMNetworkSecurityOptions}0;
	eAppletHostAccess			= {JMNetworkSecurityOptions}1;
	eUnrestrictedAccess			= {JMNetworkSecurityOptions}2;


TYPE
	JMFileSystemOptions 		= LONGINT;
CONST
	eNoFSAccess					= {JMFileSystemOptions}0;
	eLocalAppletAccess			= {JMFileSystemOptions}1;
	eAllFSAccess				= {JMFileSystemOptions}2;

{
 * Lists of packages are comma separated,
 * the default for mrj.security.system.access is
 * "sun,netscape,com.apple".
 }


TYPE
	JMAppletSecurityPtr = ^JMAppletSecurity;
	JMAppletSecurity = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fNetworkSecurity:		JMNetworkSecurityOptions;				{  can this applet access network resources  }
		fFileSystemSecurity:	JMFileSystemOptions;					{  can this applet access network resources  }
		fRestrictSystemAccess:	BOOLEAN;								{  restrict access to system packages (com.apple.*, sun.*, netscape.*) also found in the property "mrj.security.system.access"  }
		fRestrictSystemDefine:	BOOLEAN;								{  restrict classes from loading system packages (com.apple.*, sun.*, netscape.*) also found in the property "mrj.security.system.define"  }
		fRestrictApplicationAccess: BOOLEAN;							{  restrict access to application packages found in the property "mrj.security.application.access"  }
		fRestrictApplicationDefine: BOOLEAN;							{  restrict access to application packages found in the property "mrj.security.application.access"  }
	END;

{
 * AppletViewer methods
 }
FUNCTION JMNewAppletViewer(VAR viewer: JMAppletViewerRef; context: JMAWTContextRef; locatorRef: JMAppletLocatorRef; appletIndex: UInt32; {CONST}VAR security: JMAppletSecurity; {CONST}VAR callbacks: JMAppletViewerCallbacks; data: JMClientData): OSStatus; C;
FUNCTION JMDisposeAppletViewer(viewer: JMAppletViewerRef): OSStatus; C;
FUNCTION JMGetAppletViewerData(viewer: JMAppletViewerRef; VAR data: JMClientData): OSStatus; C;
FUNCTION JMSetAppletViewerData(viewer: JMAppletViewerRef; data: JMClientData): OSStatus; C;

{
 * You can change the applet security on the fly
 }
FUNCTION JMGetAppletViewerSecurity(viewer: JMAppletViewerRef; VAR data: JMAppletSecurity): OSStatus; C;
FUNCTION JMSetAppletViewerSecurity(viewer: JMAppletViewerRef; {CONST}VAR data: JMAppletSecurity): OSStatus; C;

{
 * JMReloadApplet reloads viewer's applet from the source.
 * JMRestartApplet reinstantiates the applet without reloading.
 }
FUNCTION JMReloadApplet(viewer: JMAppletViewerRef): OSStatus; C;
FUNCTION JMRestartApplet(viewer: JMAppletViewerRef): OSStatus; C;

{
 * JMSuspendApplet tells the Java thread scheduler to stop executing the viewer's applet.
 * JMResumeApplet resumes execution of the viewer's applet.
 }
FUNCTION JMSuspendApplet(viewer: JMAppletViewerRef): OSStatus; C;
FUNCTION JMResumeApplet(viewer: JMAppletViewerRef): OSStatus; C;

{ 
 * To get back to the JMAppletViewerRef instance from whence a frame came,
 * as well as the ultimate frame parent (the one created _for_ the applet viewer)
 }
FUNCTION JMGetFrameViewer(frame: JMFrameRef; VAR viewer: JMAppletViewerRef; VAR parentFrame: JMFrameRef): OSStatus; C;
{
 * To get a ref back to the Frame that was created for this JMAppletViewerRef
 }
FUNCTION JMGetViewerFrame(viewer: JMAppletViewerRef; VAR frame: JMFrameRef): OSStatus; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := JManagerIncludes}

{$ENDC} {__JMANAGER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
