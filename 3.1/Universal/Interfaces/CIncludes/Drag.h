/*
 	File:		Drag.h
 
 	Contains:	Drag and Drop Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1992-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __DRAG__
#define __DRAG__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __EVENTS__
#include <Events.h>
#endif
#ifndef __FILES__
#include <Files.h>
#endif
#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

/*
  _________________________________________________________________________________________________________
      
   • DRAG MANAGER DATA TYPES
  _________________________________________________________________________________________________________
*/

typedef struct OpaqueDragReference* 	DragReference;
typedef UInt32 							ItemReference;
typedef OSType 							FlavorType;
/*
  _________________________________________________________________________________________________________
      
   • DRAG ATTRIBUTES
  _________________________________________________________________________________________________________
*/

typedef OptionBits 						DragAttributes;

enum {
	kDragHasLeftSenderWindow	= (1L << 0),					/* drag has left the source window since TrackDrag*/
	kDragInsideSenderApplication = (1L << 1),					/* drag is occurring within the sender application*/
	kDragInsideSenderWindow		= (1L << 2)						/* drag is occurring within the sender window*/
};

/*
  _________________________________________________________________________________________________________
      
   • DRAG IMAGE FLAGS
  _________________________________________________________________________________________________________
*/

typedef OptionBits 						DragImageFlags;

enum {
	kDragRegionAndImage			= (1L << 4)						/* drag region and image*/
};

/*
  _________________________________________________________________________________________________________
      
   • DRAG IMAGE TRANSLUCENCY LEVELS
  _________________________________________________________________________________________________________
*/

typedef UInt32 							DragImageTranslucency;

enum {
	kDragStandardTranslucency	= 0L,							/* 65% image translucency (standard)*/
	kDragDarkTranslucency		= 1L,							/* 50% image translucency*/
	kDragDarkerTranslucency		= 2L,							/* 25% image translucency*/
	kDragOpaqueTranslucency		= 3L							/* 0% image translucency (opaque)*/
};

/*
  _________________________________________________________________________________________________________
      
   • DRAG DRAWING PROCEDURE MESSAGES
  _________________________________________________________________________________________________________
*/

typedef SInt16 							DragRegionMessage;

enum {
	kDragRegionBegin			= 1,							/* initialize drawing*/
	kDragRegionDraw				= 2,							/* draw drag feedback*/
	kDragRegionHide				= 3,							/* hide drag feedback*/
	kDragRegionIdle				= 4,							/* drag feedback idle time*/
	kDragRegionEnd				= 5								/* end of drawing*/
};

/*
  _________________________________________________________________________________________________________
      
   • ZOOM ACCELERATION
  _________________________________________________________________________________________________________
*/

typedef SInt16 							ZoomAcceleration;

enum {
	kZoomNoAcceleration			= 0,							/* use linear interpolation*/
	kZoomAccelerate				= 1,							/* ramp up step size*/
	kZoomDecelerate				= 2								/* ramp down step size*/
};

/*
  _________________________________________________________________________________________________________
      
   • FLAVOR FLAGS
  _________________________________________________________________________________________________________
*/

typedef OptionBits 						FlavorFlags;

enum {
	flavorSenderOnly			= (1 << 0),						/* flavor is available to sender only*/
	flavorSenderTranslated		= (1 << 1),						/* flavor is translated by sender*/
	flavorNotSaved				= (1 << 2),						/* flavor should not be saved*/
	flavorSystemTranslated		= (1 << 8)						/* flavor is translated by system*/
};

/*
  _________________________________________________________________________________________________________
      
   • SPECIAL FLAVORS
  _________________________________________________________________________________________________________
*/


enum {
	flavorTypeHFS				= FOUR_CHAR_CODE('hfs '),		/* flavor type for HFS data*/
	flavorTypePromiseHFS		= FOUR_CHAR_CODE('phfs'),		/* flavor type for promised HFS data*/
	flavorTypeDirectory			= FOUR_CHAR_CODE('diry')		/* flavor type for AOCE directories*/
};

/*
  _________________________________________________________________________________________________________
      
   • FLAVORS FOR FINDER 8.0 AND LATER
  _________________________________________________________________________________________________________
*/


enum {
	kFlavorTypeClippingName		= FOUR_CHAR_CODE('clnm'),		/* name hint for clipping file (preferred over 'clfn')*/
	kFlavorTypeClippingFilename	= FOUR_CHAR_CODE('clfn'),		/* name for clipping file*/
	kFlavorTypeDragToTrashOnly	= FOUR_CHAR_CODE('fdtt'),		/* for apps that want to allow dragging private data to the trash*/
	kFlavorTypeFinderNoTrackingBehavior = FOUR_CHAR_CODE('fntb') /* Finder completely ignores any drag containing this flavor*/
};

/*
  _________________________________________________________________________________________________________
      
   • DRAG TRACKING HANDLER MESSAGES
  _________________________________________________________________________________________________________
*/

typedef SInt16 							DragTrackingMessage;

enum {
	kDragTrackingEnterHandler	= 1,							/* drag has entered handler*/
	kDragTrackingEnterWindow	= 2,							/* drag has entered window*/
	kDragTrackingInWindow		= 3,							/* drag is moving within window*/
	kDragTrackingLeaveWindow	= 4,							/* drag has exited window*/
	kDragTrackingLeaveHandler	= 5								/* drag has exited handler*/
};

/*
  _________________________________________________________________________________________________________
      
   • HFS FLAVORS
  _________________________________________________________________________________________________________
*/


struct HFSFlavor {
	OSType 							fileType;					/* file type */
	OSType 							fileCreator;				/* file creator */
	UInt16 							fdFlags;					/* Finder flags */
	FSSpec 							fileSpec;					/* file system specification */
};
typedef struct HFSFlavor				HFSFlavor;

struct PromiseHFSFlavor {
	OSType 							fileType;					/* file type */
	OSType 							fileCreator;				/* file creator */
	UInt16 							fdFlags;					/* Finder flags */
	FlavorType 						promisedFlavor;				/* promised flavor containing an FSSpec */
};
typedef struct PromiseHFSFlavor			PromiseHFSFlavor;
/*
  _________________________________________________________________________________________________________
      
   • APPLICATION-DEFINED DRAG HANDLER ROUTINES
  _________________________________________________________________________________________________________
*/
typedef CALLBACK_API( OSErr , DragTrackingHandlerProcPtr )(DragTrackingMessage message, WindowPtr theWindow, void *handlerRefCon, DragReference theDrag);
typedef CALLBACK_API( OSErr , DragReceiveHandlerProcPtr )(WindowPtr theWindow, void *handlerRefCon, DragReference theDrag);
typedef STACK_UPP_TYPE(DragTrackingHandlerProcPtr) 				DragTrackingHandlerUPP;
typedef STACK_UPP_TYPE(DragReceiveHandlerProcPtr) 				DragReceiveHandlerUPP;
enum { uppDragTrackingHandlerProcInfo = 0x00003FA0 }; 			/* pascal 2_bytes Func(2_bytes, 4_bytes, 4_bytes, 4_bytes) */
enum { uppDragReceiveHandlerProcInfo = 0x00000FE0 }; 			/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes) */
#define NewDragTrackingHandlerProc(userRoutine) 				(DragTrackingHandlerUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragTrackingHandlerProcInfo, GetCurrentArchitecture())
#define NewDragReceiveHandlerProc(userRoutine) 					(DragReceiveHandlerUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragReceiveHandlerProcInfo, GetCurrentArchitecture())
#define CallDragTrackingHandlerProc(userRoutine, message, theWindow, handlerRefCon, theDrag)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppDragTrackingHandlerProcInfo, (message), (theWindow), (handlerRefCon), (theDrag))
#define CallDragReceiveHandlerProc(userRoutine, theWindow, handlerRefCon, theDrag)  CALL_THREE_PARAMETER_UPP((userRoutine), uppDragReceiveHandlerProcInfo, (theWindow), (handlerRefCon), (theDrag))
/*
  _________________________________________________________________________________________________________
      
   • APPLICATION-DEFINED ROUTINES
  _________________________________________________________________________________________________________
*/
typedef CALLBACK_API( OSErr , DragSendDataProcPtr )(FlavorType theType, void *dragSendRefCon, ItemReference theItemRef, DragReference theDrag);
typedef CALLBACK_API( OSErr , DragInputProcPtr )(Point *mouse, SInt16 *modifiers, void *dragInputRefCon, DragReference theDrag);
typedef CALLBACK_API( OSErr , DragDrawingProcPtr )(DragRegionMessage message, RgnHandle showRegion, Point showOrigin, RgnHandle hideRegion, Point hideOrigin, void *dragDrawingRefCon, DragReference theDrag);
typedef STACK_UPP_TYPE(DragSendDataProcPtr) 					DragSendDataUPP;
typedef STACK_UPP_TYPE(DragInputProcPtr) 						DragInputUPP;
typedef STACK_UPP_TYPE(DragDrawingProcPtr) 						DragDrawingUPP;
enum { uppDragSendDataProcInfo = 0x00003FE0 }; 					/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes, 4_bytes) */
enum { uppDragInputProcInfo = 0x00003FE0 }; 					/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes, 4_bytes) */
enum { uppDragDrawingProcInfo = 0x000FFFA0 }; 					/* pascal 2_bytes Func(2_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes) */
#define NewDragSendDataProc(userRoutine) 						(DragSendDataUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragSendDataProcInfo, GetCurrentArchitecture())
#define NewDragInputProc(userRoutine) 							(DragInputUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragInputProcInfo, GetCurrentArchitecture())
#define NewDragDrawingProc(userRoutine) 						(DragDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragDrawingProcInfo, GetCurrentArchitecture())
#define CallDragSendDataProc(userRoutine, theType, dragSendRefCon, theItemRef, theDrag)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppDragSendDataProcInfo, (theType), (dragSendRefCon), (theItemRef), (theDrag))
#define CallDragInputProc(userRoutine, mouse, modifiers, dragInputRefCon, theDrag)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppDragInputProcInfo, (mouse), (modifiers), (dragInputRefCon), (theDrag))
#define CallDragDrawingProc(userRoutine, message, showRegion, showOrigin, hideRegion, hideOrigin, dragDrawingRefCon, theDrag)  CALL_SEVEN_PARAMETER_UPP((userRoutine), uppDragDrawingProcInfo, (message), (showRegion), (showOrigin), (hideRegion), (hideOrigin), (dragDrawingRefCon), (theDrag))
/*
  _________________________________________________________________________________________________________
      
   • INSTALLING AND REMOVING HANDLERS API'S
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
InstallTrackingHandler			(DragTrackingHandlerUPP  trackingHandler,
								 WindowPtr 				theWindow,
								 void *					handlerRefCon)						TWOWORDINLINE(0x7001, 0xABED);

EXTERN_API( OSErr )
InstallReceiveHandler			(DragReceiveHandlerUPP 	receiveHandler,
								 WindowPtr 				theWindow,
								 void *					handlerRefCon)						TWOWORDINLINE(0x7002, 0xABED);

EXTERN_API( OSErr )
RemoveTrackingHandler			(DragTrackingHandlerUPP  trackingHandler,
								 WindowPtr 				theWindow)							TWOWORDINLINE(0x7003, 0xABED);

EXTERN_API( OSErr )
RemoveReceiveHandler			(DragReceiveHandlerUPP 	receiveHandler,
								 WindowPtr 				theWindow)							TWOWORDINLINE(0x7004, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • CREATING & DISPOSING
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
NewDrag							(DragReference *		theDrag)							TWOWORDINLINE(0x7005, 0xABED);

EXTERN_API( OSErr )
DisposeDrag						(DragReference 			theDrag)							TWOWORDINLINE(0x7006, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • ADDING DRAG ITEM FLAVORS
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
AddDragItemFlavor				(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 FlavorType 			theType,
								 const void *			dataPtr,
								 Size 					dataSize,
								 FlavorFlags 			theFlags)							TWOWORDINLINE(0x7007, 0xABED);

EXTERN_API( OSErr )
SetDragItemFlavorData			(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 FlavorType 			theType,
								 const void *			dataPtr,
								 Size 					dataSize,
								 UInt32 				dataOffset)							TWOWORDINLINE(0x7009, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • PROVIDING CALLBACK PROCEDURES
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
SetDragSendProc					(DragReference 			theDrag,
								 DragSendDataUPP 		sendProc,
								 void *					dragSendRefCon)						TWOWORDINLINE(0x700A, 0xABED);


EXTERN_API( OSErr )
SetDragInputProc				(DragReference 			theDrag,
								 DragInputUPP 			inputProc,
								 void *					dragInputRefCon)					TWOWORDINLINE(0x700B, 0xABED);

EXTERN_API( OSErr )
SetDragDrawingProc				(DragReference 			theDrag,
								 DragDrawingUPP 		drawingProc,
								 void *					dragDrawingRefCon)					TWOWORDINLINE(0x700C, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • SETTING THE DRAG IMAGE
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
SetDragImage					(DragReference 			theDrag,
								 PixMapHandle 			imagePixMap,
								 RgnHandle 				imageRgn,
								 Point 					imageOffsetPt,
								 DragImageFlags 		theImageFlags)						TWOWORDINLINE(0x7027, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • PERFORMING A DRAG
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
TrackDrag						(DragReference 			theDrag,
								 const EventRecord *	theEvent,
								 RgnHandle 				theRegion)							TWOWORDINLINE(0x700D, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • GETTING DRAG ITEM INFORMATION
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
CountDragItems					(DragReference 			theDrag,
								 UInt16 *				numItems)							TWOWORDINLINE(0x700E, 0xABED);

EXTERN_API( OSErr )
GetDragItemReferenceNumber		(DragReference 			theDrag,
								 UInt16 				index,
								 ItemReference *		theItemRef)							TWOWORDINLINE(0x700F, 0xABED);

EXTERN_API( OSErr )
CountDragItemFlavors			(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 UInt16 *				numFlavors)							TWOWORDINLINE(0x7010, 0xABED);

EXTERN_API( OSErr )
GetFlavorType					(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 UInt16 				index,
								 FlavorType *			theType)							TWOWORDINLINE(0x7011, 0xABED);

EXTERN_API( OSErr )
GetFlavorFlags					(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 FlavorType 			theType,
								 FlavorFlags *			theFlags)							TWOWORDINLINE(0x7012, 0xABED);

EXTERN_API( OSErr )
GetFlavorDataSize				(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 FlavorType 			theType,
								 Size *					dataSize)							TWOWORDINLINE(0x7013, 0xABED);

EXTERN_API( OSErr )
GetFlavorData					(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 FlavorType 			theType,
								 void *					dataPtr,
								 Size *					dataSize,
								 UInt32 				dataOffset)							TWOWORDINLINE(0x7014, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • DRAG ITEM BOUNDS
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
GetDragItemBounds				(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 Rect *					itemBounds)							TWOWORDINLINE(0x7015, 0xABED);

EXTERN_API( OSErr )
SetDragItemBounds				(DragReference 			theDrag,
								 ItemReference 			theItemRef,
								 const Rect *			itemBounds)							TWOWORDINLINE(0x7016, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • DROP LOCATIONS
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
GetDropLocation					(DragReference 			theDrag,
								 AEDesc *				dropLocation)						TWOWORDINLINE(0x7017, 0xABED);

EXTERN_API( OSErr )
SetDropLocation					(DragReference 			theDrag,
								 const AEDesc *			dropLocation)						TWOWORDINLINE(0x7018, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • GETTING INFORMATION ABOUT A DRAG
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
GetDragAttributes				(DragReference 			theDrag,
								 DragAttributes *		flags)								TWOWORDINLINE(0x7019, 0xABED);

EXTERN_API( OSErr )
GetDragMouse					(DragReference 			theDrag,
								 Point *				mouse,
								 Point *				globalPinnedMouse)					TWOWORDINLINE(0x701A, 0xABED);

EXTERN_API( OSErr )
SetDragMouse					(DragReference 			theDrag,
								 Point 					globalPinnedMouse)					TWOWORDINLINE(0x701B, 0xABED);

EXTERN_API( OSErr )
GetDragOrigin					(DragReference 			theDrag,
								 Point *				globalInitialMouse)					TWOWORDINLINE(0x701C, 0xABED);

EXTERN_API( OSErr )
GetDragModifiers				(DragReference 			theDrag,
								 SInt16 *				modifiers,
								 SInt16 *				mouseDownModifiers,
								 SInt16 *				mouseUpModifiers)					TWOWORDINLINE(0x701D, 0xABED);

/*
  _________________________________________________________________________________________________________
      
   • DRAG HIGHLIGHTING
  _________________________________________________________________________________________________________
*/

EXTERN_API( OSErr )
ShowDragHilite					(DragReference 			theDrag,
								 RgnHandle 				hiliteFrame,
								 Boolean 				inside)								TWOWORDINLINE(0x701E, 0xABED);

EXTERN_API( OSErr )
HideDragHilite					(DragReference 			theDrag)							TWOWORDINLINE(0x701F, 0xABED);

EXTERN_API( OSErr )
DragPreScroll					(DragReference 			theDrag,
								 SInt16 				dH,
								 SInt16 				dV)									TWOWORDINLINE(0x7020, 0xABED);

EXTERN_API( OSErr )
DragPostScroll					(DragReference 			theDrag)							TWOWORDINLINE(0x7021, 0xABED);

EXTERN_API( OSErr )
UpdateDragHilite				(DragReference 			theDrag,
								 RgnHandle 				updateRgn)							TWOWORDINLINE(0x7022, 0xABED);

EXTERN_API( OSErr )
GetDragHiliteColor				(WindowPtr 				window,
								 RGBColor *				color)								TWOWORDINLINE(0x7026, 0xABED);


/*
  _________________________________________________________________________________________________________
      
   • UTILITIES
  _________________________________________________________________________________________________________
*/


EXTERN_API( Boolean )
WaitMouseMoved					(Point 					initialMouse)						TWOWORDINLINE(0x7023, 0xABED);


EXTERN_API( OSErr )
ZoomRects						(const Rect *			fromRect,
								 const Rect *			toRect,
								 SInt16 				zoomSteps,
								 ZoomAcceleration 		acceleration)						TWOWORDINLINE(0x7024, 0xABED);

EXTERN_API( OSErr )
ZoomRegion						(RgnHandle 				region,
								 Point 					zoomDistance,
								 SInt16 				zoomSteps,
								 ZoomAcceleration 		acceleration)						TWOWORDINLINE(0x7025, 0xABED);


/*
  _________________________________________________________________________________________________________
   • OLD NAMES
     These are provided for compatiblity with older source bases.  It is recommended to not use them since
  	 they may removed from this interface file at any time.
  _________________________________________________________________________________________________________
*/

#if OLDROUTINENAMES

enum {
	dragHasLeftSenderWindow		= kDragHasLeftSenderWindow,		/* drag has left the source window since TrackDrag */
	dragInsideSenderApplication	= kDragInsideSenderApplication,	/* drag is occurring within the sender application */
	dragInsideSenderWindow		= kDragInsideSenderWindow		/* drag is occurring within the sender window */
};


enum {
	dragTrackingEnterHandler	= kDragTrackingEnterHandler,	/* drag has entered handler */
	dragTrackingEnterWindow		= kDragTrackingEnterWindow,		/* drag has entered window */
	dragTrackingInWindow		= kDragTrackingInWindow,		/* drag is moving within window */
	dragTrackingLeaveWindow		= kDragTrackingLeaveWindow,		/* drag has exited window */
	dragTrackingLeaveHandler	= kDragTrackingLeaveHandler		/* drag has exited handler */
};


enum {
	dragRegionBegin				= kDragRegionBegin,				/* initialize drawing */
	dragRegionDraw				= kDragRegionDraw,				/* draw drag feedback */
	dragRegionHide				= kDragRegionHide,				/* hide drag feedback */
	dragRegionIdle				= kDragRegionIdle,				/* drag feedback idle time */
	dragRegionEnd				= kDragRegionEnd				/* end of drawing */
};


enum {
	zoomNoAcceleration			= kZoomNoAcceleration,			/* use linear interpolation */
	zoomAccelerate				= kZoomAccelerate,				/* ramp up step size */
	zoomDecelerate				= kZoomDecelerate				/* ramp down step size */
};


enum {
	kDragStandardImage			= kDragStandardTranslucency,	/* 65% image translucency (standard)*/
	kDragDarkImage				= kDragDarkTranslucency,		/* 50% image translucency*/
	kDragDarkerImage			= kDragDarkerTranslucency,		/* 25% image translucency*/
	kDragOpaqueImage			= kDragOpaqueTranslucency		/* 0% image translucency (opaque)*/
};

#endif  /* OLDROUTINENAMES */


#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __DRAG__ */

