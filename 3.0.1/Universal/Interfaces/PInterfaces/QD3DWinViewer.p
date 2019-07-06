{
 	File:		QD3DWinViewer.p
 
 	Contains:	Win32 Viewer Controller Interface File.								
 
 	Version:	Technology:	Quickdraw 3D 1.5.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DWinViewer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DWINVIEWER__}
{$SETC __QD3DWINVIEWER__ := 1}

{$I+}
{$SETC QD3DWinViewerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DGROUP__}
{$I QD3DGroup.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC TARGET_OS_WIN32 }

TYPE
	TQ3ViewerObject						= Ptr;

CONST
	kQ3ViewerShowBadge			= $01;
	kQ3ViewerActive				= $02;
	kQ3ViewerControllerVisible	= $04;
	kQ3ViewerButtonCamera		= $08;
	kQ3ViewerButtonTruck		= $10;
	kQ3ViewerButtonOrbit		= $20;
	kQ3ViewerButtonZoom			= $40;
	kQ3ViewerButtonDolly		= $80;
	kQ3ViewerButtonReset		= $0100;
	kQ3ViewerButtonNone			= $0200;
	kQ3ViewerOutputTextMode		= $0400;
	kQ3ViewerDraggingInOff		= $0800;
	kQ3ViewerDefault			= $8000;


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
 **								WM_NOTIFY structures  						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3ViewerDropFilesPtr = ^TQ3ViewerDropFiles;
	TQ3ViewerDropFiles = RECORD
		nmhdr:					NMHDR;
		hDrop:					HANDLE;
	END;

	TQ3ViewerSetViewPtr = ^TQ3ViewerSetView;
	TQ3ViewerSetView = RECORD
		nmhdr:					NMHDR;
		view:					TQ3ViewerCameraView;
	END;

	TQ3ViewerSetViewNumberPtr = ^TQ3ViewerSetViewNumber;
	TQ3ViewerSetViewNumber = RECORD
		nmhdr:					NMHDR;
		number:					LONGINT;
	END;

	TQ3ViewerButtonSetPtr = ^TQ3ViewerButtonSet;
	TQ3ViewerButtonSet = RECORD
		nmhdr:					NMHDR;
		button:					LONGINT;
	END;

{*****************************************************************************
 **																			 **
 **								WM_NOTIFY defines  							 **
 **																			 **
 ****************************************************************************}
{*****************************************************************************
 **																			 **
 **							Win32 Window Class Name  						 **
 **		Can be passed as a parameter to CreateWindow or CreateWindowEx  	 **
 **																			 **
 ****************************************************************************}

{*****************************************************************************
 **																			 **
 **							Win32 Clipboard type     						 **
 **																			 **
 ****************************************************************************}
{*****************************************************************************
 **																			 **
 **		Return viewer version number										 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetVersion(VAR majorRevision: LONGINT; VAR minorRevision: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Return viewer release version number								 **
 **		(in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetReleaseVersion(VAR releaseRevision: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **						Creation and destruction							 **
 **				Note that this is not a QuickDraw 3D object					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerNew(window: HWND; {CONST}VAR rect: RECT; flags: LONGINT): TQ3ViewerObject; C;
FUNCTION Q3WinViewerDispose(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **					Functions to attach data to a WinViewer					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerUseFile(viewer: TQ3ViewerObject; fileHandle: HANDLE): TQ3Status; C;
FUNCTION Q3WinViewerUseData(viewer: TQ3ViewerObject; data: UNIV Ptr; size: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **				Functions to write data out from the WinViewer				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerWriteFile(viewer: TQ3ViewerObject; fileHandle: HANDLE): TQ3Status; C;
FUNCTION Q3WinViewerWriteData(viewer: TQ3ViewerObject; data: UNIV Ptr; dataSize: LONGINT; VAR actualDataSize: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Use this function to force the WinViewer to re-draw					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerDraw(viewer: TQ3ViewerObject): TQ3Status; C;
FUNCTION Q3WinViewerDrawContent(viewer: TQ3ViewerObject): TQ3Status; C;
FUNCTION Q3WinViewerDrawControlStrip(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Function used by the WinViewer to filter and handle events			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerMouseDown(viewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOL; C;
FUNCTION Q3WinViewerContinueTracking(viewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOL; C;
FUNCTION Q3WinViewerMouseUp(viewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOL; C;

{*****************************************************************************
 **																			 **
 **		This function returns a Bitmap of the contents of the 				 **
 **		WinViewer's window.  The application should dispose the Bitmap.		 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetBitmap(viewer: TQ3ViewerObject): HBITMAP; C;

{*****************************************************************************
 **																			 **
 **					Calls for dealing with Buttons							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetButtonRect(viewer: TQ3ViewerObject; button: LONGINT; VAR rectangle: RECT): TQ3Status; C;
FUNCTION Q3WinViewerGetCurrentButton(viewer: TQ3ViewerObject): LONGINT; C;
FUNCTION Q3WinViewerSetCurrentButton(viewer: TQ3ViewerObject; button: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Functions to set/get the group to be displayed by the WinViewer.	 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerUseGroup(viewer: TQ3ViewerObject; group: TQ3GroupObject): TQ3Status; C;
FUNCTION Q3WinViewerGetGroup(viewer: TQ3ViewerObject): TQ3GroupObject; C;

{*****************************************************************************
 **																			 **
 **		Functions to set/get the color used to clear the window				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerSetBackgroundColor(viewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): TQ3Status; C;
FUNCTION Q3WinViewerGetBackgroundColor(viewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Getting/Setting a WinViewer's View object.  Disposal is needed.		 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetView(viewer: TQ3ViewerObject): TQ3ViewObject; C;
FUNCTION Q3WinViewerRestoreView(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Calls for setting/getting WinViewer flags							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerSetFlags(viewer: TQ3ViewerObject; flags: LONGINT): TQ3Status; C;
FUNCTION Q3WinViewerGetFlags(viewer: TQ3ViewerObject): LONGINT; C;

{*****************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerSetBounds(viewer: TQ3ViewerObject; VAR bounds: RECT): TQ3Status; C;
FUNCTION Q3WinViewerGetBounds(viewer: TQ3ViewerObject; VAR bounds: RECT): TQ3Status; C;
FUNCTION Q3WinViewerSetDimension(viewer: TQ3ViewerObject; width: LONGINT; height: LONGINT): TQ3Status; C;
FUNCTION Q3WinViewerGetDimension(viewer: TQ3ViewerObject; VAR width: LONGINT; VAR height: LONGINT): TQ3Status; C;
FUNCTION Q3WinViewerGetMinimumDimension(viewer: TQ3ViewerObject; VAR width: LONGINT; VAR height: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Window related calls							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerSetWindow(viewer: TQ3ViewerObject; window: HWND): TQ3Status; C;
FUNCTION Q3WinViewerGetWindow(viewer: TQ3ViewerObject): HWND; C;
FUNCTION Q3WinViewerGetViewer(theWindow: HWND): TQ3ViewerObject; C;
FUNCTION Q3WinViewerGetControlStrip(viewer: TQ3ViewerObject): HWND; C;

{*****************************************************************************
 **																			 **
 **		Adjust Cursor provided for compatibility with Mac Viewer			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerAdjustCursor(viewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): TQ3Boolean; C;
FUNCTION Q3WinViewerCursorChanged(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Returns the state of the WinViewer.  See the constant defined at the **
 **		top of this file.													 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetState(viewer: TQ3ViewerObject): LONGINT; C;

{*****************************************************************************
 **																			 **
 **							Clipboard utilities								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerClear(viewer: TQ3ViewerObject): TQ3Status; C;
FUNCTION Q3WinViewerCut(viewer: TQ3ViewerObject): TQ3Status; C;
FUNCTION Q3WinViewerCopy(viewer: TQ3ViewerObject): TQ3Status; C;
FUNCTION Q3WinViewerPaste(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																		     **
 **								Undo							 			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerUndo(viewer: TQ3ViewerObject): TQ3Status; C;
FUNCTION Q3WinViewerGetUndoString(viewer: TQ3ViewerObject; theString: CStringPtr; stringSize: LONGINT; VAR actualSize: LONGINT): TQ3Boolean; C;

{*****************************************************************************
 **																		     **
 **							New Camera Stuff								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetCameraCount(viewer: TQ3ViewerObject; VAR count: LONGINT): TQ3Status; C;
FUNCTION Q3WinViewerSetCameraNumber(viewer: TQ3ViewerObject; cameraNo: LONGINT): TQ3Status; C;
FUNCTION Q3WinViewerSetCameraView(viewer: TQ3ViewerObject; viewType: TQ3ViewerCameraView): TQ3Status; C;
{$ENDC}  {TARGET_OS_WIN32}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DWinViewerIncludes}

{$ENDC} {__QD3DWINVIEWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
