/******************************************************************************
 **									 										 **
 ** 	Module:		QD3DViewer.h											 **						
 **									 										 **
 **									 										 **
 ** 	Purpose: 	Viewer Controller Interface File.						 **			
 **									 										 **
 **									 										 **
 ** 	Copyright (C) 1994-1997 Apple Computer, Inc.  All rights reserved.	 **
 **									 										 **
 **									 										 **
 *****************************************************************************/
#ifndef QD3DViewer_h
#define QD3DViewer_h

#include "QD3D.h"
#include "QD3DGroup.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */ 
 
#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=small
#endif

#include <Events.h>
#include <Types.h>
#include <Windows.h>

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DVIEWER 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif


#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

typedef void *TQ3ViewerObject;

typedef OSErr (*TQ3ViewerDrawingCallbackMethod)(
		TQ3ViewerObject	theViewer,
		const void *data);


enum {
	kQ3ViewerShowBadge 			= 1<<0,
	kQ3ViewerActive				= 1<<1,
	kQ3ViewerControllerVisible	= 1<<2,
	kQ3ViewerDrawFrame			= 1<<3,
	kQ3ViewerDraggingOff		= 1<<4,
	
	kQ3ViewerButtonCamera		= 1<<5,
	kQ3ViewerButtonTruck		= 1<<6,
	kQ3ViewerButtonOrbit		= 1<<7,
	kQ3ViewerButtonZoom			= 1<<8,
	kQ3ViewerButtonDolly		= 1<<9,
	kQ3ViewerButtonReset		= 1<<10,
	
	kQ3ViewerOutputTextMode		= 1<<11,
	kQ3ViewerDragMode			= 1<<12,

	kQ3ViewerDrawGrowBox		= 1<<13,
	kQ3ViewerDrawDragBorder		= 1<<14,

	kQ3ViewerDraggingInOff		= 1<<15,
	kQ3ViewerDraggingOutOff		= 1<<16,

	kQ3ViewerDefault			= 1<<31
};

enum {
	kQ3ViewerEmpty    = 0,
	kQ3ViewerHasModel = 1<<0,
	kQ3ViewerHasUndo  = 1<<1
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

enum {
	gestaltQD3DViewer			= 'q3vc',
	gestaltQD3DViewerNotPresent	= 0,
	gestaltQD3DViewerAvailable	= 1
};

/******************************************************************************
 **																			 **
 **		Return viewer version number										 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerGetVersion(
	unsigned long		*majorRevision,
	unsigned long		*minorRevision);

	
	
/******************************************************************************
 **																			 **
 **		Return viewer release version number								 **
 **		(in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)				 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerGetReleaseVersion(
	unsigned long		*releaseRevision);

	
	
/******************************************************************************
 **																			 **
 **		Creation and destruction											 **
 **		Note that this is not a QuickDraw 3D object							 **
 **																			 **
 *****************************************************************************/

TQ3ViewerObject Q3ViewerNew(
	CGrafPtr		port,
	Rect			*rect,
	unsigned long	flags);
	
OSErr Q3ViewerDispose(
	TQ3ViewerObject theViewer);


/******************************************************************************
 **																			 **
 **		Functions to attach data to a viewer								 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerUseFile(
	TQ3ViewerObject	theViewer,
	long			refNum);
	
OSErr Q3ViewerUseData(
	TQ3ViewerObject	theViewer,
	void			*data,
	long			size);


/******************************************************************************
 **																			 **
 **		Functions to write data out from the Viewer							 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerWriteFile(
	TQ3ViewerObject	theViewer,
	long			refNum);
	
unsigned long Q3ViewerWriteData(
	TQ3ViewerObject	theViewer,
	void			**data);


/******************************************************************************
 **																			 **
 **		Use this function to force the Viewer to re-draw					 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerDraw(
	TQ3ViewerObject theViewer);

OSErr Q3ViewerDrawContent(
	TQ3ViewerObject theViewer);

OSErr Q3ViewerDrawControlStrip(
	TQ3ViewerObject theViewer);


/******************************************************************************
 **																			 **
 **		Function used by the Viewer to filter and handle events				 **
 **																			 **
 *****************************************************************************/

Boolean Q3ViewerEvent(
	TQ3ViewerObject	theViewer,
	EventRecord		*evt);


/******************************************************************************
 **																			 **
 **		This function returns a PICT of the contents of the 				 **
 **		Viewer's window.  The application should dispose the PICT.			 **
 **																			 **
 *****************************************************************************/

PicHandle Q3ViewerGetPict(
	TQ3ViewerObject theViewer);


/******************************************************************************
 **																			 **
 **		Calls for dealing with Buttons										 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerGetButtonRect(
	TQ3ViewerObject	theViewer,
	unsigned long	button,
	Rect			*rect);

unsigned long Q3ViewerGetCurrentButton(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerSetCurrentButton(
	TQ3ViewerObject	theViewer,
	unsigned long	button);


/******************************************************************************
 **																			 **
 **		Functions to set/get the group to be displayed by the Viewer.		 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerUseGroup(
	TQ3ViewerObject	theViewer,
	TQ3GroupObject	group);
	
TQ3GroupObject Q3ViewerGetGroup(
	TQ3ViewerObject	theViewer);


/******************************************************************************
 **																			 **
 **		Functions to set/get the color used to clear the window				 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetBackgroundColor(
	TQ3ViewerObject	theViewer,
	TQ3ColorARGB	*color);
	
OSErr Q3ViewerGetBackgroundColor(
	TQ3ViewerObject	theViewer,
	TQ3ColorARGB	*color);


/******************************************************************************
 **																			 **
 **		Getting/Setting a Viewer's View object. 							 **
 **																			 **
 *****************************************************************************/

TQ3ViewObject Q3ViewerGetView(
	TQ3ViewerObject	theViewer);

OSErr Q3ViewerRestoreView(
	TQ3ViewerObject	theViewer);


/******************************************************************************
 **																			 **
 **		Calls for setting/getting viewer flags								 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetFlags(
	TQ3ViewerObject	theViewer,
	unsigned long	flags);
	
unsigned long Q3ViewerGetFlags(
	TQ3ViewerObject	theViewer);


/******************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetBounds(
	TQ3ViewerObject	theViewer,
	Rect			*bounds);
	
OSErr Q3ViewerGetBounds(
	TQ3ViewerObject	theViewer,
	Rect			*bounds);

OSErr Q3ViewerSetDimension(
	TQ3ViewerObject	theViewer,
	unsigned long	width,
	unsigned long	height);

OSErr Q3ViewerGetDimension(
	TQ3ViewerObject	theViewer,
	unsigned long	*width,
	unsigned long	*height);

/* 1.1 */
OSErr Q3ViewerGetMinimumDimension(
	TQ3ViewerObject	theViewer,
	unsigned long	*width,
	unsigned long	*height);


/******************************************************************************
 **																			 **
 **		Port related calls													 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetPort(
	TQ3ViewerObject	theViewer,
	CGrafPtr		port);
	
CGrafPtr Q3ViewerGetPort(
	TQ3ViewerObject	theViewer);


/******************************************************************************
 **																			 **
 **		Adjust Cursor should be called from idle loop to allow the Viewer	 **
 **		to change the cursor according to the cursor position/object under	 **
 **		the cursor.															 **
 **																			 **
 *****************************************************************************/

Boolean Q3ViewerAdjustCursor(
	TQ3ViewerObject	theViewer,
	Point			*pt);

OSErr Q3ViewerCursorChanged(
	TQ3ViewerObject	theViewer);

	
/******************************************************************************
 **																			 **
 **		Returns the state of the viewer.  See the constant defined at the	 **
 **		top of this file.													 **
 **																			 **
 *****************************************************************************/

unsigned long Q3ViewerGetState(
	TQ3ViewerObject	theViewer);


/******************************************************************************
 **																			 **
 **		Clipboard utilities													 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerClear(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerCut(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerCopy(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerPaste(
	TQ3ViewerObject	theViewer);


/******************************************************************************
 **																		     **
 **		1.1																	 **
 **		New Event Model														 **
 **																			 **
 *****************************************************************************/

Boolean Q3ViewerMouseDown(
	TQ3ViewerObject	theViewer,
	long				x,
	long				y);

Boolean Q3ViewerContinueTracking(
	TQ3ViewerObject	theViewer,
	long				x,
	long				y);

Boolean Q3ViewerMouseUp(
	TQ3ViewerObject	theViewer,
	long				x,
	long				y);

Boolean Q3ViewerHandleKeyEvent(
	TQ3ViewerObject		theViewer,
	EventRecord			*evt);


/******************************************************************************
 **																		     **
 **		1.1																	 **
 **		Drawing CallBack													 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetDrawingCallbackMethod(
	TQ3ViewerObject					theViewer,
	TQ3ViewerDrawingCallbackMethod	callbackMethod,
	const void 						*data);


/******************************************************************************
 **																		     **
 **		1.1																	 **
 **		Undo													 			 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerUndo(
	TQ3ViewerObject	theViewer);
		
Boolean Q3ViewerGetUndoString(
	TQ3ViewerObject	theViewer, 
	char 			*string,
	unsigned long 	*cnt);


/******************************************************************************
 **																		     **
 **		1.1																	 **
 **		New Camera Stuff													 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerGetCameraCount(
	TQ3ViewerObject	theViewer, 
	unsigned long 	*cnt);

OSErr Q3ViewerSetCameraByNumber(
	TQ3ViewerObject	theViewer, 
	unsigned long 	cameraNo);

OSErr Q3ViewerSetCameraByView(
	TQ3ViewerObject		theViewer, 
	TQ3ViewerCameraView viewType);




#ifdef __cplusplus
}
#endif	/* __cplusplus */


#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DVIEWER
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DVIEWER
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif	/* QD3DViewer_h */

