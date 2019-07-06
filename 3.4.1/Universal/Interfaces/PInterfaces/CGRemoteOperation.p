{
     File:       CGRemoteOperation.p
 
     Contains:   CoreGraphics remote operation
 
     Version:    Technology: CoreGraphics-122 (Mac OS X 10.1)
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGRemoteOperation;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGREMOTEOPERATION__}
{$SETC __CGREMOTEOPERATION__ := 1}

{$I+}
{$SETC CGRemoteOperationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGGEOMETRY__}
{$I CGGeometry.p}
{$ENDC}
{$IFC UNDEFINED __CGERROR__}
{$I CGError.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGEventErr							= CGError;

CONST
	CGEventNoErr				= 0;


	{	 Screen refresh or drawing notification 	}
	{	
	 * Callback function pointer;
	 * Declare your callback function in this form.  When an area of the display is
	 * modified or refreshed, your callback function will be invoked with a count
	 * of the number of rectangles in the refreshed areas, and a list of the refreshed
	 * rectangles.  The rectangles are in global coordinates.
	 *
	 * Your function should not modify, deallocate or free memory pointed to by rectArray.
	 *
	 * The system continues to accumulate refreshed areas constantly.  Whenever new
	 * information is available, your callback function is invoked.The list of rects
	 * passed to the callback function are cleared from the accumulated refreshed area
	 * when the callback is made.
	 *
	 * This callback may be triggered by drawing operations, window movement, and
	 * display reconfiguration.
	 *
	 * Bear in mind that a single rectangle may occupy multiple displays,
	 * either by overlapping the displays, or by residing on coincident displays
	 * when mirroring is active.  Use the CGGetDisplaysWithRect() to determine
	 * the displays a rectangle occupies.
	 	}

TYPE
	CGRectCount							= u_int32_t;
{$IFC TYPED_FUNCTION_POINTERS}
	CGScreenRefreshCallback = PROCEDURE(count: CGRectCount; {CONST}VAR rectArray: CGRect; userParameter: UNIV Ptr); C;
{$ELSEC}
	CGScreenRefreshCallback = ProcPtr;
{$ENDC}

	{	
	 * Register a callback function to be invoked when an area of the display
	 * is refreshed, or modified.  The function is invoked on the same thread
	 * of execution that is processing events within your application.
	 * userParameter is passed back with each invocation of the callback function.
	 	}
	{
	 *  CGRegisterScreenRefreshCallback()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 and later
	 	}
PROCEDURE CGRegisterScreenRefreshCallback(callback: CGScreenRefreshCallback; userParameter: UNIV Ptr); C;

{
 * Remove a previously registered calback function.
 * Both the function and the userParameter must match the registered entry to be removed.
 }
{
 *  CGUnregisterScreenRefreshCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGUnregisterScreenRefreshCallback(callback: CGScreenRefreshCallback; userParameter: UNIV Ptr); C;


{
 * In some applications it may be preferable to have a seperate thread wait for screen refresh data.
 * This function should be called on a thread seperate from the event processing thread.
 * If screen refresh callback functions are registered, this function should not be used.
 * The mechanisms are mutually exclusive.
 *
 * Deallocate screen refresh rects using CGReleaseScreenRefreshRects().
 *
 * Returns an error code if parameters are invalid or an error occurs in retrieving
 * dirty screen rects from the server.
 }
{
 *  CGWaitForScreenRefreshRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGWaitForScreenRefreshRects(VAR pRectArray: UNIV Ptr; VAR pCount: CGRectCount): CGEventErr; C;

{
 * Deallocate the list of rects recieved from CGWaitForScreenRefreshRects()
 }
{
 *  CGReleaseScreenRefreshRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE CGReleaseScreenRefreshRects(VAR rectArray: CGRect); C;

{
 * Posting events: These functions post events into the system.  Use for remote
 * operation and virtualization.
 *
 * Note that remote operation requires a valid connection to the server, which
 * must be owned by either the root/Administrator user or the logged in console
 * user.  This means that your application must be running as root/Administrator
 * user or the logged in console user.
 }

{
 * Synthesize keyboard events.  Based on the values entered,
 * the appropriate key down, key up, and flags changed events are generated.
 * If keyChar is NUL (0), an apropriate value will be guessed at, based on the
 * default keymapping.
 *
 * All keystrokes needed to generate a character must be entered, including
 * SHIFT, CONTROL, OPTION, and COMMAND keys.  For example, to produce a 'Z',
 * the SHIFT key must be down, the 'z' key must go down, and then the SHIFT
 * and 'z' key must be released:
 *  CGPostKeyboardEvent( (CGCharCode)0, (CGKeyCode)56, true ); // shift down
 *  CGPostKeyboardEvent( (CGCharCode)'Z', (CGKeyCode)6, true ); // 'z' down
 *  CGPostKeyboardEvent( (CGCharCode)'Z', (CGKeyCode)6, false ); // 'z' up
 *  CGPostKeyboardEvent( (CGCharCode)0, (CGKeyCode)56, false ); // 'shift up
 }

TYPE
	CGCharCode							= u_int16_t;
	CGKeyCode							= u_int16_t;
	{
	 *  CGPostKeyboardEvent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION CGPostKeyboardEvent(keyChar: CGCharCode; virtualKey: CGKeyCode; keyDown: boolean_t): CGEventErr; C;

{
 * Warp the mouse cursor to the desired position in global
 * coordinates without generating events
 }
{
 *  CGWarpMouseCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGWarpMouseCursorPosition(newCursorPosition: CGPoint): CGEventErr; C;

{
 * Remote operation may want to inhibit local events (events from
 * the machine's keyboard and mouse).  This may be done either as a
 * explicit request (tracked per app) or as a short term side effect of
 * posting an event.
 *
 * CGInhibitLocalEvents() is typically used for long term remote operation
 * of a system, as in automated system testing or telecommuting applications.
 * Local device state changes are discarded.
 *
 * Local event inhibition is turned off if the app that requested it terminates.
 }
{
 *  CGInhibitLocalEvents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGInhibitLocalEvents(doInhibit: boolean_t): CGEventErr; C;

{
 * Set the period of time in seconds that local hardware events (keyboard and mouse)
 * are supressed after posting an event.  Defaults to 0.25 second.
 }
{
 *  CGSetLocalEventsSuppressionInterval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGSetLocalEventsSuppressionInterval(seconds: CFTimeInterval): CGEventErr; C;

{
 * By default, the flags that indicate modifier key state (Command, Alt, Shift, etc.)
 * from the system's keyboard and from other event sources are ORed together as an event is
 * posted into the system, and current key and mouse button state is considered in generating new events.
 * This function allows your application to enable or disable the
 * merging of event state.  When combining is turned off, the event state propagated in the events
 * posted by your app reflect state built up only by your app.  The state within your app's generated
 * event will not be combined with the system's current state, so the system-wide state reflecting key
 * and mouse button state will remain unchanged
 *
 * When called with doCombineState equal to FALSE, this function initializes local (per application)
 * state tracking information to a state of all keys, modifiers, and mouse buttons up.
 *
 * When called with doCombineState equal to TRUE, the current global state of keys, modifiers,
 * and mouse buttons are used in generating events.
 }
{
 *  CGEnableEventStateCombining()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION CGEnableEventStateCombining(doCombineState: boolean_t): CGEventErr; C;

{
 * By default the system supresses local hardware events from the keyboard and mouse during
 * a short interval after a synthetic event is posted (see CGSetLocalEventsSuppressionInterval())
 * and while a synthetic mouse drag (mouse movement with the left/only mouse button down).
 * Some classes of applications may want to enable events from some of the local hardware.
 * For example, an app may want to post only mouse events, and so may wish to permit local
 * keyboard hardware events to pass through.
 *
 * This interface lets an app specify a state (event supression interval, or mouse drag), and
 * a mask of event categories to be passed through.
 }

TYPE
	CGEventFilterMask 			= SInt32;
CONST
	kCGEventFilterMaskPermitLocalMouseEvents = $00000001;		{  Mouse, scroll wheel  }
	kCGEventFilterMaskPermitLocalKeyboardEvents = $00000002;	{  Alphanumeric keys and Command, Option, Control, Shift, AlphaLock  }
	kCGEventFilterMaskPermitSystemDefinedEvents = $00000004;	{  Power key, bezel buttons, sticky keys  }
	kCGEventFilterMaskPermitAllEvents = $00000007;


TYPE
	CGEventSupressionState 		= SInt32;
CONST
	kCGEventSupressionStateSupressionInterval = 0;
	kCGEventSupressionStateRemoteMouseDrag = 1;
	kCGNumberOfEventSupressionStates = 2;

	{
	 *  CGSetLocalEventsFilterDuringSupressionState()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.1 and later
	 	}
FUNCTION CGSetLocalEventsFilterDuringSupressionState(filter: CGEventFilterMask; state: CGEventSupressionState): CGEventErr; C;

{
 * Helper function to connect or disconnect the mouse and mouse cursor.
 * CGAssociateMouseAndMouseCursorPosition(false) has the same effect
 * as the following, without actually modifying the supression interval:
 *
 *  CGSetLocalEventsSuppressionInterval(MAX_DOUBLE);
 *  CGWarpMouseCursorPosition(currentPosition);
 *
 * While disconnected, mouse move and drag events will reflect the current position of
 * the mouse cursor position, which will not change with mouse movement. Use the
 * <CoreGraphics/CGDirectDisplay.h> function:
 *
 *  void CGGetLastMouseDelta( CGMouseDelta * deltaX, CGMouseDelta * deltaY );
 *
 * This will report mouse movement associated with the last mouse move or drag event.
 *
 * To update the display cursor position, use the function defined in this module:
 *
 *  CGEventErr CGWarpMouseCursorPosition( CGPoint newCursorPosition );
 }
{
 *  CGAssociateMouseAndMouseCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CGAssociateMouseAndMouseCursorPosition(connected: boolean_t): CGEventErr; C;

{
 * Some classes of applications need to detect when the window server process dies, or
 * is not running.  The easiest way to do this is to use a CFMachPortRef.
 *
 * If the CoreGraphics window server is not running, this function returns NULL.
 * If the server is running, a CFMachPortRef is returned.
 *
 * A program can register a callback function to use a CFMachPortRef to determine
 * when the CoreGraphics window server exits:
 *
 * static void handleWindowServerDeath( CFMachPortRef port, void *info )
 * (
 *     printf( "Window Server port death detected!\n" );
 *     CFRelease( port );
 *     exit( 1 );
 * )
 * 
 * static void watchForServerDeath()
 * (
 *     CFMachPortRef        port;
 *
 *     port = CGWindowServerCFMachPort();
 *     CFMachPortSetInvalidationCallBack( port, handleWindowServerDeath );
 * )
 *
 * Note that when the window server exits, there may be a few seconds during which
 * no window server is running, until the operating system starts a new
 * window server/loginwindow pair of processes.  This function will return NULL
 * until a new window server is running.
 *
 * Multiple calls to this function may return multiple CFMachPortRefs, each referring
 * to the same Mach port.  Multiple callbacks registered on multiple CFMachPortRefs
 * obtained in this way may fire in a nondetermanistic manner.
 *
 * Your program will need to run a CFRunLoop for the port death
 * callback to function.  A program which does not use a CFRunLoop may use
 * CFMachPortIsValid(CFMachPortRef port) periodically to check if the port is valid.
 }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGRemoteOperationIncludes}

{$ENDC} {__CGREMOTEOPERATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
