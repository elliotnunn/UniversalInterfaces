{
     File:       QD3DViewer.p
 
     Contains:   MacOS Viewer Controller Interface File.
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1995-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DViewer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DVIEWER__}
{$SETC __QD3DVIEWER__ := 1}

{$I+}
{$SETC QD3DViewerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DGROUP__}
{$I QD3DGroup.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


TYPE
	TQ3ViewerObject						= Ptr;
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerWindowResizeCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3ViewerWindowResizeCallbackMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerPaneResizeNotifyCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3ViewerPaneResizeNotifyCallbackMethod = ProcPtr;
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerDrawingCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): OSErr; C;
{$ELSEC}
	TQ3ViewerDrawingCallbackMethod = ProcPtr;
{$ENDC}


CONST
	kQ3ViewerShowBadge			= $01;
	kQ3ViewerActive				= $02;
	kQ3ViewerControllerVisible	= $04;
	kQ3ViewerDrawFrame			= $08;
	kQ3ViewerDraggingOff		= $10;
	kQ3ViewerButtonCamera		= $20;
	kQ3ViewerButtonTruck		= $40;
	kQ3ViewerButtonOrbit		= $80;
	kQ3ViewerButtonZoom			= $0100;
	kQ3ViewerButtonDolly		= $0200;
	kQ3ViewerButtonReset		= $0400;
	kQ3ViewerOutputTextMode		= $0800;
	kQ3ViewerDragMode			= $1000;
	kQ3ViewerDrawGrowBox		= $2000;
	kQ3ViewerDrawDragBorder		= $4000;
	kQ3ViewerDraggingInOff		= $8000;
	kQ3ViewerDraggingOutOff		= $00010000;
	kQ3ViewerButtonOptions		= $00020000;
	kQ3ViewerPaneGrowBox		= $00040000;
	kQ3ViewerDefault			= $80000000;

	kQ3ViewerEmpty				= 0;
	kQ3ViewerHasModel			= $01;
	kQ3ViewerHasUndo			= $02;


TYPE
	TQ3ViewerCameraView 		= SInt32;
CONST
	kQ3ViewerCameraRestore		= 0;
	kQ3ViewerCameraFit			= 1;
	kQ3ViewerCameraFront		= 2;
	kQ3ViewerCameraBack			= 3;
	kQ3ViewerCameraLeft			= 4;
	kQ3ViewerCameraRight		= 5;
	kQ3ViewerCameraTop			= 6;
	kQ3ViewerCameraBottom		= 7;


{*****************************************************************************
 **                                                                          **
 **     Return viewer version number                                         **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION Q3ViewerGetVersion(VAR majorRevision: UInt32; VAR minorRevision: UInt32): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Return viewer release version number                                 **
 **     (in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)               **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerGetReleaseVersion(VAR releaseRevision: UInt32): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **                     Creation and destruction                             **
 **             Note that this is not a QuickDraw 3D object                  **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerNew(port: CGrafPtr; VAR rect: Rect; flags: UInt32): TQ3ViewerObject; C;
FUNCTION Q3ViewerDispose(theViewer: TQ3ViewerObject): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **                 Functions to attach data to a viewer                     **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerUseFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;
FUNCTION Q3ViewerUseData(theViewer: TQ3ViewerObject; data: UNIV Ptr; size: LONGINT): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Functions to write data out from the Viewer                          **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerWriteFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;
FUNCTION Q3ViewerWriteData(theViewer: TQ3ViewerObject; data: Handle): UInt32; C;

{*****************************************************************************
 **                                                                          **
 **     Use this function to force the Viewer to re-draw                     **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerDraw(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerDrawContent(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerDrawControlStrip(theViewer: TQ3ViewerObject): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Function used by the Viewer to filter and handle events              **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerEvent(theViewer: TQ3ViewerObject; VAR evt: EventRecord): BOOLEAN; C;

{*****************************************************************************
 **                                                                          **
 **     This function returns a PICT of the contents of the                  **
 **     Viewer's window.  The application should dispose the PICT.           **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerGetPict(theViewer: TQ3ViewerObject): PicHandle; C;

{*****************************************************************************
 **                                                                          **
 **                     Calls for dealing with Buttons                       **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerGetButtonRect(theViewer: TQ3ViewerObject; button: UInt32; VAR rect: Rect): OSErr; C;
FUNCTION Q3ViewerGetCurrentButton(theViewer: TQ3ViewerObject): UInt32; C;
FUNCTION Q3ViewerSetCurrentButton(theViewer: TQ3ViewerObject; button: UInt32): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Functions to set/get the group to be displayed by the Viewer.        **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerUseGroup(theViewer: TQ3ViewerObject; group: TQ3GroupObject): OSErr; C;
FUNCTION Q3ViewerGetGroup(theViewer: TQ3ViewerObject): TQ3GroupObject; C;

{*****************************************************************************
 **                                                                          **
 **     Functions to set/get the color used to clear the window              **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerSetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;
FUNCTION Q3ViewerGetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Getting/Setting a Viewer's View object.                              **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerGetView(theViewer: TQ3ViewerObject): TQ3ViewObject; C;
FUNCTION Q3ViewerRestoreView(theViewer: TQ3ViewerObject): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Calls for setting/getting viewer flags                               **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerSetFlags(theViewer: TQ3ViewerObject; flags: UInt32): OSErr; C;
FUNCTION Q3ViewerGetFlags(theViewer: TQ3ViewerObject): UInt32; C;

{*****************************************************************************
 **                                                                          **
 **     Calls related to bounds/dimensions.  Bounds is the size of           **
 **     the window.  Dimensions can either be the Rect from the ViewHints    **
 **     or the current dimensions of the window (if you do a Set).           **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerSetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;
FUNCTION Q3ViewerGetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;
FUNCTION Q3ViewerSetDimension(theViewer: TQ3ViewerObject; width: UInt32; height: UInt32): OSErr; C;
FUNCTION Q3ViewerGetDimension(theViewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): OSErr; C;
FUNCTION Q3ViewerGetMinimumDimension(theViewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **                         Port related calls                               **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerSetPort(theViewer: TQ3ViewerObject; port: CGrafPtr): OSErr; C;
FUNCTION Q3ViewerGetPort(theViewer: TQ3ViewerObject): CGrafPtr; C;

{*****************************************************************************
 **                                                                          **
 **     Adjust Cursor should be called from idle loop to allow the Viewer    **
 **     to change the cursor according to the cursor position/object under   **
 **     the cursor.                                                          **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerAdjustCursor(theViewer: TQ3ViewerObject; VAR pt: Point): BOOLEAN; C;
FUNCTION Q3ViewerCursorChanged(theViewer: TQ3ViewerObject): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **     Returns the state of the viewer.  See the constant defined at the    **
 **     top of this file.                                                    **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerGetState(theViewer: TQ3ViewerObject): UInt32; C;

{*****************************************************************************
 **                                                                          **
 **                         Clipboard utilities                              **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerClear(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerCut(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerCopy(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerPaste(theViewer: TQ3ViewerObject): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **                         New Event Model                                  **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerMouseDown(theViewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOLEAN; C;
FUNCTION Q3ViewerContinueTracking(theViewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOLEAN; C;
FUNCTION Q3ViewerMouseUp(theViewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOLEAN; C;
FUNCTION Q3ViewerHandleKeyEvent(theViewer: TQ3ViewerObject; VAR evt: EventRecord): BOOLEAN; C;

{*****************************************************************************
 **                                                                          **
 **                                 CallBacks                                **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerSetDrawingCallbackMethod(theViewer: TQ3ViewerObject; callbackMethod: TQ3ViewerDrawingCallbackMethod; data: UNIV Ptr): OSErr; C;
FUNCTION Q3ViewerSetWindowResizeCallback(theViewer: TQ3ViewerObject; windowResizeCallbackMethod: TQ3ViewerWindowResizeCallbackMethod; data: UNIV Ptr): OSErr; C;
FUNCTION Q3ViewerSetPaneResizeNotifyCallback(theViewer: TQ3ViewerObject; paneResizeNotifyCallbackMethod: TQ3ViewerPaneResizeNotifyCallbackMethod; data: UNIV Ptr): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **                                 Undo                                     **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerUndo(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerGetUndoString(theViewer: TQ3ViewerObject; str: CStringPtr; VAR cnt: UInt32): BOOLEAN; C;

{*****************************************************************************
 **                                                                          **
 **                             Camera Support                               **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerGetCameraCount(theViewer: TQ3ViewerObject; VAR cnt: UInt32): OSErr; C;
FUNCTION Q3ViewerSetCameraByNumber(theViewer: TQ3ViewerObject; cameraNo: UInt32): OSErr; C;
FUNCTION Q3ViewerSetCameraByView(theViewer: TQ3ViewerObject; viewType: TQ3ViewerCameraView): OSErr; C;

{*****************************************************************************
 **                                                                          **
 **                         Pop-up Button Options                            **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3ViewerSetRendererType(theViewer: TQ3ViewerObject; rendererType: TQ3ObjectType): OSErr; C;
FUNCTION Q3ViewerGetRendererType(theViewer: TQ3ViewerObject; VAR rendererType: TQ3ObjectType): OSErr; C;
FUNCTION Q3ViewerChangeBrightness(theViewer: TQ3ViewerObject; brightness: Single): OSErr; C;
FUNCTION Q3ViewerSetRemoveBackfaces(theViewer: TQ3ViewerObject; remove: TQ3Boolean): OSErr; C;
FUNCTION Q3ViewerGetRemoveBackfaces(theViewer: TQ3ViewerObject; VAR remove: TQ3Boolean): OSErr; C;
FUNCTION Q3ViewerSetPhongShading(theViewer: TQ3ViewerObject; phong: TQ3Boolean): OSErr; C;
FUNCTION Q3ViewerGetPhongShading(theViewer: TQ3ViewerObject; VAR phong: TQ3Boolean): OSErr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DViewerIncludes}

{$ENDC} {__QD3DVIEWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
