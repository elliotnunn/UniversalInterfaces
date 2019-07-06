{
 	File:		QD3DWinViewer.p
 
 	Contains:	Win32 Viewer Controller Interface File.								
 
 	Version:	Technology:	Quickdraw 3D 1.6
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1995-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerDrawingCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3ViewerDrawingCallbackMethod = ProcPtr;
{$ENDC}

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
	kQ3ViewerButtonOptions		= $1000;
	kQ3ViewerPaneGrowBox		= $2000;
	kQ3ViewerDefault			= $8000;


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
 **																			 **
 **								WM_NOTIFY structures  						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3ViewerDropFilesPtr = ^TQ3ViewerDropFiles;
	TQ3ViewerDropFiles = RECORD
		_nmhdr:					NMHDR;
		hDrop:					HANDLE;
	END;

	TQ3ViewerSetViewPtr = ^TQ3ViewerSetView;
	TQ3ViewerSetView = RECORD
		_nmhdr:					NMHDR;
		view:					TQ3ViewerCameraView;
	END;

	TQ3ViewerSetViewNumberPtr = ^TQ3ViewerSetViewNumber;
	TQ3ViewerSetViewNumber = RECORD
		_nmhdr:					NMHDR;
		number:					UInt32;
	END;

	TQ3ViewerButtonSetPtr = ^TQ3ViewerButtonSet;
	TQ3ViewerButtonSet = RECORD
		_nmhdr:					NMHDR;
		button:					UInt32;
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
{$IFC CALL_NOT_IN_CARBON }
FUNCTION Q3WinViewerGetVersion(VAR majorRevision: UInt32; VAR minorRevision: UInt32): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Return viewer release version number								 **
 **		(in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetReleaseVersion(VAR releaseRevision: UInt32): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **						Creation and destruction							 **
 **				Note that this is not a QuickDraw 3D object					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerNew(window: HWND; {CONST}VAR rect: RECT; flags: UInt32): TQ3ViewerObject; C;
FUNCTION Q3WinViewerDispose(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **					Functions to attach data to a WinViewer					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerUseFile(viewer: TQ3ViewerObject; fileHandle: HANDLE): TQ3Status; C;
FUNCTION Q3WinViewerUseData(viewer: TQ3ViewerObject; data: UNIV Ptr; size: UInt32): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **				Functions to write data out from the WinViewer				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerWriteFile(viewer: TQ3ViewerObject; fileHandle: HANDLE): TQ3Status; C;
FUNCTION Q3WinViewerWriteData(viewer: TQ3ViewerObject; data: UNIV Ptr; dataSize: UInt32; VAR actualDataSize: UInt32): TQ3Status; C;

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
FUNCTION Q3WinViewerGetButtonRect(viewer: TQ3ViewerObject; button: UInt32; VAR rectangle: RECT): TQ3Status; C;
FUNCTION Q3WinViewerGetCurrentButton(viewer: TQ3ViewerObject): UInt32; C;
FUNCTION Q3WinViewerSetCurrentButton(viewer: TQ3ViewerObject; button: UInt32): TQ3Status; C;

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
 **		Getting/Setting a WinViewer's View object.							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetView(viewer: TQ3ViewerObject): TQ3ViewObject; C;
FUNCTION Q3WinViewerRestoreView(viewer: TQ3ViewerObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **		Calls for setting/getting WinViewer flags							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerSetFlags(viewer: TQ3ViewerObject; flags: UInt32): TQ3Status; C;
FUNCTION Q3WinViewerGetFlags(viewer: TQ3ViewerObject): UInt32; C;

{*****************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerSetBounds(viewer: TQ3ViewerObject; VAR bounds: RECT): TQ3Status; C;
FUNCTION Q3WinViewerGetBounds(viewer: TQ3ViewerObject; VAR bounds: RECT): TQ3Status; C;
FUNCTION Q3WinViewerSetDimension(viewer: TQ3ViewerObject; width: UInt32; height: UInt32): TQ3Status; C;
FUNCTION Q3WinViewerGetDimension(viewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): TQ3Status; C;
FUNCTION Q3WinViewerGetMinimumDimension(viewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): TQ3Status; C;

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
FUNCTION Q3WinViewerGetState(viewer: TQ3ViewerObject): UInt32; C;

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
FUNCTION Q3WinViewerGetUndoString(viewer: TQ3ViewerObject; theString: CStringPtr; stringSize: UInt32; VAR actualSize: UInt32): TQ3Boolean; C;

{*****************************************************************************
 **																		     **
 **							New Camera Stuff								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3WinViewerGetCameraCount(viewer: TQ3ViewerObject; VAR count: UInt32): TQ3Status; C;
FUNCTION Q3WinViewerSetCameraNumber(viewer: TQ3ViewerObject; cameraNo: UInt32): TQ3Status; C;
FUNCTION Q3WinViewerSetCameraView(viewer: TQ3ViewerObject; viewType: TQ3ViewerCameraView): TQ3Status; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DWinViewerIncludes}

{$ENDC} {__QD3DWINVIEWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
