{
 	File:		QD3DViewer.p
 
 	Contains:	MacOS Viewer Controller Interface File.								
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

{$IFC TARGET_OS_MAC }

TYPE
	TQ3ViewerObject						= Ptr;
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
	kQ3ViewerDefault			= $80000000;

	kQ3ViewerEmpty				= 0;
	kQ3ViewerHasModel			= $01;
	kQ3ViewerHasUndo			= $02;


TYPE
	TQ3ViewerCameraView 		= LONGINT;
CONST
	kQ3ViewerCameraRestore		= {TQ3ViewerCameraView}0;
	kQ3ViewerCameraFit			= {TQ3ViewerCameraView}1;
	kQ3ViewerCameraFront		= {TQ3ViewerCameraView}2;
	kQ3ViewerCameraBack			= {TQ3ViewerCameraView}3;
	kQ3ViewerCameraLeft			= {TQ3ViewerCameraView}4;
	kQ3ViewerCameraRight		= {TQ3ViewerCameraView}5;
	kQ3ViewerCameraTop			= {TQ3ViewerCameraView}6;
	kQ3ViewerCameraBottom		= {TQ3ViewerCameraView}7;


{*****************************************************************************
 **																			 **
 **		Return viewer version number										 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerGetVersion(VAR majorRevision: UInt32; VAR minorRevision: UInt32): OSErr; C;


{*****************************************************************************
 **																			 **
 **		Return viewer release version number								 **
 **		(in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerGetReleaseVersion(VAR releaseRevision: UInt32): OSErr; C;

{*****************************************************************************
 **																			 **
 **						Creation and destruction							 **
 **				Note that this is not a QuickDraw 3D object					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerNew(port: CGrafPtr; VAR rect: Rect; flags: UInt32): TQ3ViewerObject; C;
FUNCTION Q3ViewerDispose(theViewer: TQ3ViewerObject): OSErr; C;
{*****************************************************************************
 **																			 **
 **					Functions to attach data to a viewer					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerUseFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;
FUNCTION Q3ViewerUseData(theViewer: TQ3ViewerObject; data: UNIV Ptr; size: LONGINT): OSErr; C;
{*****************************************************************************
 **																			 **
 **		Functions to write data out from the Viewer							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerWriteFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;
FUNCTION Q3ViewerWriteData(theViewer: TQ3ViewerObject; data: Handle): UInt32; C;
{*****************************************************************************
 **																			 **
 **		Use this function to force the Viewer to re-draw					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerDraw(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerDrawContent(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerDrawControlStrip(theViewer: TQ3ViewerObject): OSErr; C;
{*****************************************************************************
 **																			 **
 **		Function used by the Viewer to filter and handle events				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerEvent(theViewer: TQ3ViewerObject; VAR evt: EventRecord): BOOLEAN; C;
{*****************************************************************************
 **																			 **
 **		This function returns a PICT of the contents of the 				 **
 **		Viewer's window.  The application should dispose the PICT.			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerGetPict(theViewer: TQ3ViewerObject): PicHandle; C;
{*****************************************************************************
 **																			 **
 **						Calls for dealing with Buttons						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerGetButtonRect(theViewer: TQ3ViewerObject; button: UInt32; VAR rect: Rect): OSErr; C;
FUNCTION Q3ViewerGetCurrentButton(theViewer: TQ3ViewerObject): UInt32; C;
FUNCTION Q3ViewerSetCurrentButton(theViewer: TQ3ViewerObject; button: UInt32): OSErr; C;
{*****************************************************************************
 **																			 **
 **		Functions to set/get the group to be displayed by the Viewer.		 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerUseGroup(theViewer: TQ3ViewerObject; group: TQ3GroupObject): OSErr; C;
FUNCTION Q3ViewerGetGroup(theViewer: TQ3ViewerObject): TQ3GroupObject; C;
{*****************************************************************************
 **																			 **
 **		Functions to set/get the color used to clear the window				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerSetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;
FUNCTION Q3ViewerGetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;
{*****************************************************************************
 **																			 **
 **		Getting/Setting a Viewer's View object.  Disposal is needed.		 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerGetView(theViewer: TQ3ViewerObject): TQ3ViewObject; C;
FUNCTION Q3ViewerRestoreView(theViewer: TQ3ViewerObject): OSErr; C;
{*****************************************************************************
 **																			 **
 **		Calls for setting/getting viewer flags								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerSetFlags(theViewer: TQ3ViewerObject; flags: UInt32): OSErr; C;
FUNCTION Q3ViewerGetFlags(theViewer: TQ3ViewerObject): UInt32; C;
{*****************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerSetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;
FUNCTION Q3ViewerGetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;
FUNCTION Q3ViewerSetDimension(theViewer: TQ3ViewerObject; width: UInt32; height: UInt32): OSErr; C;
FUNCTION Q3ViewerGetDimension(theViewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): OSErr; C;
{ 1.1 }
FUNCTION Q3ViewerGetMinimumDimension(theViewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): OSErr; C;
{*****************************************************************************
 **																			 **
 **							Port related calls								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerSetPort(theViewer: TQ3ViewerObject; port: CGrafPtr): OSErr; C;
FUNCTION Q3ViewerGetPort(theViewer: TQ3ViewerObject): CGrafPtr; C;
{*****************************************************************************
 **																			 **
 **		Adjust Cursor should be called from idle loop to allow the Viewer	 **
 **		to change the cursor according to the cursor position/object under	 **
 **		the cursor.															 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerAdjustCursor(theViewer: TQ3ViewerObject; VAR pt: Point): BOOLEAN; C;
FUNCTION Q3ViewerCursorChanged(theViewer: TQ3ViewerObject): OSErr; C;

{*****************************************************************************
 **																			 **
 **		Returns the state of the viewer.  See the constant defined at the	 **
 **		top of this file.													 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerGetState(theViewer: TQ3ViewerObject): UInt32; C;
{*****************************************************************************
 **																			 **
 **							Clipboard utilities								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3ViewerClear(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerCut(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerCopy(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerPaste(theViewer: TQ3ViewerObject): OSErr; C;
{$ENDC}  {TARGET_OS_MAC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DViewerIncludes}

{$ENDC} {__QD3DVIEWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
