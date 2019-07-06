/******************************************************************************
 **									 										 **
 ** 	Module:		QD3DWinViewer.h											 **						
 **									 										 **
 **									 										 **
 ** 	Purpose: 	WinViewer Controller Interface File.					 **			
 **									 										 **
 **									 										 **
 **									 										 **
 ** 	Copyright (C) 1996-1997 Apple Computer, Inc.  All rights reserved.   **
 **									 										 **
 **									 										 **
 *****************************************************************************/
#ifndef QD3DWinViewer_h
#define QD3DWinViewer_h

#include "QD3D.h"
#include "QD3DGroup.h"

#if defined(OS_WIN32) && OS_WIN32

#include <windows.h>

#if defined(_MSC_VER)	/* Microsoft Visual C */
	#if defined(Q3VIEWER_EXPORTING)	/* define when building DLL	*/
		#define Q3VIEWER_EXPORT __declspec( dllexport )	 
		#define Q3VIEWER_CALL 	 
	#else
		#define Q3VIEWER_EXPORT __declspec( dllimport )	
		#define Q3VIEWER_CALL __cdecl	 
	#endif /* WIN32_EXPORTING */
#else
	#define Q3VIEWER_EXPORT
	#define Q3VIEWER_CALL 	 
#endif  /*  _MSC_VER  */

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

typedef void *TQ3ViewerObject;

enum {
	kQ3ViewerShowBadge 			= 1 << 0,
	kQ3ViewerActive				= 1 << 1,
	kQ3ViewerControllerVisible	= 1 << 2,
	
	kQ3ViewerButtonCamera		= 1 << 3,
	kQ3ViewerButtonTruck		= 1 << 4,
	kQ3ViewerButtonOrbit		= 1 << 5,
	kQ3ViewerButtonZoom			= 1 << 6,
	kQ3ViewerButtonDolly		= 1 << 7,
	kQ3ViewerButtonReset		= 1 << 8,
	kQ3ViewerButtonNone			= 1 << 9,
	
	kQ3ViewerOutputTextMode		= 1 << 10,

	kQ3ViewerDraggingInOff		= 1 << 11,

	kQ3ViewerDefault			= 1 << 15
};


enum {
	kQ3ViewerEmpty    = 0,
	kQ3ViewerHasModel = 1 << 0,
	kQ3ViewerHasUndo  = 1 << 1
};

typedef enum TQ3ViewerCameraView {
	kQ3ViewerCameraRestore,
	kQ3ViewerCameraFit,
	kQ3ViewerCameraFront,
	kQ3ViewerCameraBack,
	kQ3ViewerCameraLeft,
	kQ3ViewerCameraRight,
	kQ3ViewerCameraTop,
	kQ3ViewerCameraBottom
} TQ3ViewerCameraView;


/******************************************************************************
 **																			 **
 **								WM_NOTIFY structures  						 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3ViewerDropFiles {
	NMHDR				nmhdr; 
    HANDLE				hDrop; 
} TQ3ViewerDropFiles;

typedef struct TQ3ViewerSetView {
	NMHDR				nmhdr;
	TQ3ViewerCameraView	view;
} TQ3ViewerSetView;

typedef struct TQ3ViewerSetViewNumber {
	NMHDR				nmhdr;
	unsigned long		number;
} TQ3ViewerSetViewNumber;

typedef struct TQ3ViewerButtonSet {
	NMHDR				nmhdr;
	unsigned long		button;
} TQ3ViewerButtonSet;


/******************************************************************************
 **																			 **
 **								WM_NOTIFY defines  							 **
 **																			 **
 *****************************************************************************/

#define Q3VNM_DROPFILES		0x5000
#define Q3VNM_CANUNDO		0x5001
#define Q3VNM_DRAWCOMPLETE	0x5002
#define Q3VNM_SETVIEW		0x5003
#define Q3VNM_SETVIEWNUMBER	0x5004
#define Q3VNM_BUTTONSET		0x5005
#define Q3VNM_BADGEHIT		0x5006


/******************************************************************************
 **																			 **
 **							Win32 Window Class Name  						 **
 **		Can be passed as a parameter to CreateWindow or CreateWindowEx  	 **
 **																			 **
 *****************************************************************************/

#define kQ3ViewerClassName "QD3DViewerWindow"


/******************************************************************************
 **																			 **
 **							Win32 Clipboard type     						 **
 **																			 **
 *****************************************************************************/

#define kQ3ViewerClipboardFormat "QuickDraw 3D Metafile"
/******************************************************************************
 **																			 **
 **		Return viewer version number										 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetVersion(
	unsigned long		*majorRevision,
	unsigned long		*minorRevision);

	
/******************************************************************************
 **																			 **
 **		Return viewer release version number								 **
 **		(in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)				 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetReleaseVersion(
	unsigned long		*releaseRevision);

	
/******************************************************************************
 **																			 **
 **						Creation and destruction							 **
 **				Note that this is not a QuickDraw 3D object					 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3ViewerObject Q3VIEWER_CALL Q3WinViewerNew (
	HWND 			window, 
	const RECT 		*rect, 
	unsigned long 	flags);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerDispose(
	TQ3ViewerObject	viewer);


/******************************************************************************
 **																			 **
 **					Functions to attach data to a WinViewer					 **
 **																			 **
 *****************************************************************************/
 
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerUseFile(
	TQ3ViewerObject		viewer,
	HANDLE				fileHandle);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerUseData(
	TQ3ViewerObject		viewer,
	void				*data,
	unsigned long		size);


/******************************************************************************
 **																			 **
 **				Functions to write data out from the WinViewer				 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerWriteFile(
	TQ3ViewerObject		viewer,
	HANDLE				fileHandle);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerWriteData(
	TQ3ViewerObject		viewer,
	void				*data,
	unsigned long		dataSize,
	unsigned long		*actualDataSize);


/******************************************************************************
 **																			 **
 **		Use this function to force the WinViewer to re-draw					 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerDraw(
	TQ3ViewerObject		viewer);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerDrawContent(
	TQ3ViewerObject 	viewer);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerDrawControlStrip(
	TQ3ViewerObject 	viewer);


/******************************************************************************
 **																			 **
 **		Function used by the WinViewer to filter and handle events			 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT BOOL Q3VIEWER_CALL Q3WinViewerMouseDown(
	TQ3ViewerObject		viewer,
	long				x,
	long				y);

Q3VIEWER_EXPORT BOOL Q3VIEWER_CALL Q3WinViewerContinueTracking(
	TQ3ViewerObject		viewer,
	long				x,
	long				y);

Q3VIEWER_EXPORT BOOL Q3VIEWER_CALL Q3WinViewerMouseUp(
	TQ3ViewerObject		viewer,
	long				x,
	long				y);


/******************************************************************************
 **																			 **
 **		This function returns a Bitmap of the contents of the 				 **
 **		WinViewer's window.  The application should dispose the Bitmap.		 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT HBITMAP Q3VIEWER_CALL Q3WinViewerGetBitmap(
	TQ3ViewerObject		viewer);
	
	
/******************************************************************************
 **																			 **
 **					Calls for dealing with Buttons							 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetButtonRect(
	TQ3ViewerObject		viewer,
	unsigned long		button,
	RECT				*rectangle);

Q3VIEWER_EXPORT unsigned long Q3VIEWER_CALL Q3WinViewerGetCurrentButton(
	TQ3ViewerObject	viewer);
	
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetCurrentButton(
	TQ3ViewerObject		viewer,
	unsigned long		button);


/******************************************************************************
 **																			 **
 **		Functions to set/get the group to be displayed by the WinViewer.	 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerUseGroup(
	TQ3ViewerObject		viewer,
	TQ3GroupObject		group);
	
Q3VIEWER_EXPORT TQ3GroupObject Q3VIEWER_CALL Q3WinViewerGetGroup(
	TQ3ViewerObject		viewer);


/******************************************************************************
 **																			 **
 **		Functions to set/get the color used to clear the window				 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetBackgroundColor(
	TQ3ViewerObject		viewer,
	TQ3ColorARGB		*color);
	
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetBackgroundColor(
	TQ3ViewerObject		viewer,
	TQ3ColorARGB		*color);


/******************************************************************************
 **																			 **
 **		Getting/Setting a WinViewer's View object.  Disposal is needed.		 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3ViewObject Q3VIEWER_CALL Q3WinViewerGetView(
	TQ3ViewerObject		viewer);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerRestoreView(
	TQ3ViewerObject		viewer);


/******************************************************************************
 **																			 **
 **		Calls for setting/getting WinViewer flags							 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetFlags(
	TQ3ViewerObject		viewer,
	unsigned long		flags);

Q3VIEWER_EXPORT unsigned long Q3VIEWER_CALL Q3WinViewerGetFlags(
	TQ3ViewerObject		viewer);


/******************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetBounds(
	TQ3ViewerObject		viewer,
	RECT				*bounds);
	
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetBounds(
	TQ3ViewerObject		viewer,
	RECT				*bounds);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetDimension(
	TQ3ViewerObject		viewer,
	unsigned long		width,
	unsigned long		height);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetDimension(
	TQ3ViewerObject		viewer,
	unsigned long		*width,
	unsigned long		*height);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetMinimumDimension(
	TQ3ViewerObject		viewer,
	unsigned long		*width,
	unsigned long		*height);


/******************************************************************************
 **																			 **
 **							Window related calls							 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetWindow(
	TQ3ViewerObject		viewer,
	HWND				window);
	
Q3VIEWER_EXPORT HWND Q3VIEWER_CALL Q3WinViewerGetWindow(
	TQ3ViewerObject		viewer);

Q3VIEWER_EXPORT TQ3ViewerObject Q3VIEWER_CALL Q3WinViewerGetViewer(
	HWND				theWindow);

Q3VIEWER_EXPORT HWND Q3VIEWER_CALL Q3WinViewerGetControlStrip (
	TQ3ViewerObject 	viewer);


/******************************************************************************
 **																			 **
 **		Adjust Cursor provided for compatibility with Mac Viewer			 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Boolean Q3VIEWER_CALL Q3WinViewerAdjustCursor(
	TQ3ViewerObject		viewer,
	long				x,
	long				y);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerCursorChanged(
	TQ3ViewerObject		viewer);


/******************************************************************************
 **																			 **
 **		Returns the state of the WinViewer.  See the constant defined at the **
 **		top of this file.													 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT unsigned long Q3VIEWER_CALL Q3WinViewerGetState(
	TQ3ViewerObject		viewer);


/******************************************************************************
 **																			 **
 **							Clipboard utilities								 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerClear(
	TQ3ViewerObject	viewer);
	
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerCut(
	TQ3ViewerObject	viewer);
	
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerCopy(
	TQ3ViewerObject	viewer);
	
Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerPaste(
	TQ3ViewerObject	viewer);


/******************************************************************************
 **																		     **
 **								Undo							 			 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerUndo(
	TQ3ViewerObject	viewer);
		
Q3VIEWER_EXPORT TQ3Boolean Q3VIEWER_CALL Q3WinViewerGetUndoString(
	TQ3ViewerObject	viewer, 
	char 			*string,
	unsigned long 	stringSize,
	unsigned long	*actualSize);


/******************************************************************************
 **																		     **
 **							New Camera Stuff								 **
 **																			 **
 *****************************************************************************/

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerGetCameraCount(
	TQ3ViewerObject		viewer, 
	unsigned long 		*count);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetCameraNumber(
	TQ3ViewerObject		viewer, 
	unsigned long 		cameraNo);

Q3VIEWER_EXPORT TQ3Status Q3VIEWER_CALL Q3WinViewerSetCameraView(
	TQ3ViewerObject		viewer, 
	TQ3ViewerCameraView viewType);

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#endif 	/* OS_WIN32 */

#endif	/* QD3DWinViewer_h */

