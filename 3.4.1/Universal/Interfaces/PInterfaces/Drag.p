{
     File:       Drag.p
 
     Contains:   Drag and Drop Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 1992-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Drag;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRAG__}
{$SETC __DRAG__ := 1}

{$I+}
{$SETC DragIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
  _________________________________________________________________________________________________________
      
   • DRAG MANAGER DATA TYPES
  _________________________________________________________________________________________________________
}


TYPE
	DragRef    = ^LONGINT; { an opaque 32-bit type }
	DragRefPtr = ^DragRef;  { when a VAR xx:DragRef parameter can be nil, it is changed to xx: DragRefPtr }
	DragItemRef							= UInt32;
	FlavorType							= OSType;
	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG ATTRIBUTES
	  _________________________________________________________________________________________________________
	}
	DragAttributes 				= UInt32;
CONST
	kDragHasLeftSenderWindow	= $00000001;					{  drag has left the source window since TrackDrag }
	kDragInsideSenderApplication = $00000002;					{  drag is occurring within the sender application }
	kDragInsideSenderWindow		= $00000004;					{  drag is occurring within the sender window }

	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG BEHAVIORS
	  _________________________________________________________________________________________________________
	}

TYPE
	DragBehaviors 				= UInt32;
CONST
	kDragBehaviorNone			= 0;
	kDragBehaviorZoomBackAnimation = $00000001;					{  do zoomback animation for failed drags (normally enabled). }

	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG IMAGE FLAGS
	  _________________________________________________________________________________________________________
	}

TYPE
	DragImageFlags 				= UInt32;
CONST
	kDragRegionAndImage			= $00000010;					{  drag region and image }

	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG IMAGE TRANSLUCENCY LEVELS
	  _________________________________________________________________________________________________________
	}

	kDragStandardTranslucency	= 0;							{  65% image translucency (standard) }
	kDragDarkTranslucency		= 1;							{  50% image translucency }
	kDragDarkerTranslucency		= 2;							{  25% image translucency }
	kDragOpaqueTranslucency		= 3;							{  0% image translucency (opaque) }

	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG DRAWING PROCEDURE MESSAGES
	  _________________________________________________________________________________________________________
	}


TYPE
	DragRegionMessage 			= SInt16;
CONST
	kDragRegionBegin			= 1;							{  initialize drawing }
	kDragRegionDraw				= 2;							{  draw drag feedback }
	kDragRegionHide				= 3;							{  hide drag feedback }
	kDragRegionIdle				= 4;							{  drag feedback idle time }
	kDragRegionEnd				= 5;							{  end of drawing }

	{
	  _________________________________________________________________________________________________________
	      
	   • ZOOM ACCELERATION
	  _________________________________________________________________________________________________________
	}


TYPE
	ZoomAcceleration 			= SInt16;
CONST
	kZoomNoAcceleration			= 0;							{  use linear interpolation }
	kZoomAccelerate				= 1;							{  ramp up step size }
	kZoomDecelerate				= 2;							{  ramp down step size }

	{
	  _________________________________________________________________________________________________________
	      
	   • FLAVOR FLAGS
	  _________________________________________________________________________________________________________
	}


TYPE
	FlavorFlags 				= UInt32;
CONST
	flavorSenderOnly			= $01;							{  flavor is available to sender only }
	flavorSenderTranslated		= $02;							{  flavor is translated by sender }
	flavorNotSaved				= $04;							{  flavor should not be saved }
	flavorSystemTranslated		= $0100;						{  flavor is translated by system }
	flavorDataPromised			= $0200;						{  flavor data is promised by sender }

	{
	  _________________________________________________________________________________________________________
	      
	   • FILE SYSTEM CONSTANTS
	  _________________________________________________________________________________________________________
	}

	kDragFlavorTypeHFS			= 'hfs ';						{  flavor type for HFS data }
	kDragFlavorTypePromiseHFS	= 'phfs';						{  flavor type for promised HFS data }
	flavorTypeHFS				= 'hfs ';						{  old name }
	flavorTypePromiseHFS		= 'phfs';						{  old name }

	kDragPromisedFlavorFindFile	= 'rWm1';						{  promisedFlavor value for Find File }
	kDragPromisedFlavor			= 'fssP';						{  promisedFlavor value for everything else }

	kDragPseudoCreatorVolumeOrDirectory = 'MACS';				{  "creator code" for volume or directory }
	kDragPseudoFileTypeVolume	= 'disk';						{  "file type" for volume }
	kDragPseudoFileTypeDirectory = 'fold';						{  "file type" for directory }

	{
	  _________________________________________________________________________________________________________
	      
	   • SPECIAL FLAVORS
	  _________________________________________________________________________________________________________
	}

	flavorTypeDirectory			= 'diry';						{  flavor type for AOCE directories }

	{
	  _________________________________________________________________________________________________________
	      
	   • FLAVORS FOR FINDER 8.0 AND LATER
	  _________________________________________________________________________________________________________
	}

	kFlavorTypeClippingName		= 'clnm';						{  name hint for clipping file (preferred over 'clfn') }
	kFlavorTypeClippingFilename	= 'clfn';						{  name for clipping file }
	kFlavorTypeDragToTrashOnly	= 'fdtt';						{  for apps that want to allow dragging private data to the trash }
	kFlavorTypeFinderNoTrackingBehavior = 'fntb';				{  Finder completely ignores any drag containing this flavor }

	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG TRACKING HANDLER MESSAGES
	  _________________________________________________________________________________________________________
	}


TYPE
	DragTrackingMessage 		= SInt16;
CONST
	kDragTrackingEnterHandler	= 1;							{  drag has entered handler }
	kDragTrackingEnterWindow	= 2;							{  drag has entered window }
	kDragTrackingInWindow		= 3;							{  drag is moving within window }
	kDragTrackingLeaveWindow	= 4;							{  drag has exited window }
	kDragTrackingLeaveHandler	= 5;							{  drag has exited handler }


	{
	  _________________________________________________________________________________________________________
	      
	   • DRAG ACTIONS
	  _________________________________________________________________________________________________________
	}

	kDragActionNothing			= 0;
	kDragActionCopy				= 1;
	kDragActionAlias			= $00000002;
	kDragActionGeneric			= $00000004;
	kDragActionPrivate			= $00000008;
	kDragActionMove				= $00000010;
	kDragActionDelete			= $00000020;
	kDragActionAll				= $FFFFFFFF;


TYPE
	DragActions							= UInt32;
	{
	  _________________________________________________________________________________________________________
	      
	   • HFS FLAVORS
	  _________________________________________________________________________________________________________
	}
	HFSFlavorPtr = ^HFSFlavor;
	HFSFlavor = RECORD
		fileType:				OSType;									{  file type  }
		fileCreator:			OSType;									{  file creator  }
		fdFlags:				UInt16;									{  Finder flags  }
		fileSpec:				FSSpec;									{  file system specification  }
	END;

	PromiseHFSFlavorPtr = ^PromiseHFSFlavor;
	PromiseHFSFlavor = RECORD
		fileType:				OSType;									{  file type  }
		fileCreator:			OSType;									{  file creator  }
		fdFlags:				UInt16;									{  Finder flags  }
		promisedFlavor:			FlavorType;								{  promised flavor containing an FSSpec  }
	END;

	{
	  _________________________________________________________________________________________________________
	      
	   • APPLICATION-DEFINED DRAG HANDLER ROUTINES
	  _________________________________________________________________________________________________________
	}
{$IFC TYPED_FUNCTION_POINTERS}
	DragTrackingHandlerProcPtr = FUNCTION(message: DragTrackingMessage; theWindow: WindowRef; handlerRefCon: UNIV Ptr; theDrag: DragRef): OSErr;
{$ELSEC}
	DragTrackingHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DragReceiveHandlerProcPtr = FUNCTION(theWindow: WindowRef; handlerRefCon: UNIV Ptr; theDrag: DragRef): OSErr;
{$ELSEC}
	DragReceiveHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DragTrackingHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DragTrackingHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DragReceiveHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DragReceiveHandlerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDragTrackingHandlerProcInfo = $00003FA0;
	uppDragReceiveHandlerProcInfo = $00000FE0;
	{
	 *  NewDragTrackingHandlerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION NewDragTrackingHandlerUPP(userRoutine: DragTrackingHandlerProcPtr): DragTrackingHandlerUPP; { old name was NewDragTrackingHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDragReceiveHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewDragReceiveHandlerUPP(userRoutine: DragReceiveHandlerProcPtr): DragReceiveHandlerUPP; { old name was NewDragReceiveHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDragTrackingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeDragTrackingHandlerUPP(userUPP: DragTrackingHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDragReceiveHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeDragReceiveHandlerUPP(userUPP: DragReceiveHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDragTrackingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeDragTrackingHandlerUPP(message: DragTrackingMessage; theWindow: WindowRef; handlerRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragTrackingHandlerUPP): OSErr; { old name was CallDragTrackingHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDragReceiveHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeDragReceiveHandlerUPP(theWindow: WindowRef; handlerRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragReceiveHandlerUPP): OSErr; { old name was CallDragReceiveHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • APPLICATION-DEFINED ROUTINES
  _________________________________________________________________________________________________________
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DragSendDataProcPtr = FUNCTION(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: DragItemRef; theDrag: DragRef): OSErr;
{$ELSEC}
	DragSendDataProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DragInputProcPtr = FUNCTION(VAR mouse: Point; VAR modifiers: SInt16; dragInputRefCon: UNIV Ptr; theDrag: DragRef): OSErr;
{$ELSEC}
	DragInputProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DragDrawingProcPtr = FUNCTION(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDrag: DragRef): OSErr;
{$ELSEC}
	DragDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DragSendDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DragSendDataUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DragInputUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DragInputUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DragDrawingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DragDrawingUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDragSendDataProcInfo = $00003FE0;
	uppDragInputProcInfo = $00003FE0;
	uppDragDrawingProcInfo = $000FFFA0;
	{
	 *  NewDragSendDataUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 and later
	 	}
FUNCTION NewDragSendDataUPP(userRoutine: DragSendDataProcPtr): DragSendDataUPP; { old name was NewDragSendDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDragInputUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewDragInputUPP(userRoutine: DragInputProcPtr): DragInputUPP; { old name was NewDragInputProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDragDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewDragDrawingUPP(userRoutine: DragDrawingProcPtr): DragDrawingUPP; { old name was NewDragDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDragSendDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeDragSendDataUPP(userUPP: DragSendDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDragInputUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeDragInputUPP(userUPP: DragInputUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDragDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE DisposeDragDrawingUPP(userUPP: DragDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDragSendDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeDragSendDataUPP(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: DragItemRef; theDrag: DragRef; userRoutine: DragSendDataUPP): OSErr; { old name was CallDragSendDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDragInputUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeDragInputUPP(VAR mouse: Point; VAR modifiers: SInt16; dragInputRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragInputUPP): OSErr; { old name was CallDragInputProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDragDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InvokeDragDrawingUPP(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragDrawingUPP): OSErr; { old name was CallDragDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • INSTALLING AND REMOVING HANDLERS API'S
  _________________________________________________________________________________________________________
}

{
 *  InstallTrackingHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InstallTrackingHandler(trackingHandler: DragTrackingHandlerUPP; theWindow: WindowRef; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABED;
	{$ENDC}

{
 *  InstallReceiveHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION InstallReceiveHandler(receiveHandler: DragReceiveHandlerUPP; theWindow: WindowRef; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABED;
	{$ENDC}

{
 *  RemoveTrackingHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION RemoveTrackingHandler(trackingHandler: DragTrackingHandlerUPP; theWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $ABED;
	{$ENDC}

{
 *  RemoveReceiveHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION RemoveReceiveHandler(receiveHandler: DragReceiveHandlerUPP; theWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • CREATING & DISPOSING
  _________________________________________________________________________________________________________
}

{
 *  NewDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION NewDrag(VAR theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $ABED;
	{$ENDC}

{
 *  DisposeDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION DisposeDrag(theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • ADDING DRAG ITEM FLAVORS
  _________________________________________________________________________________________________________
}

{
    The method for setting Drag Manager promises differs from that for Scrap Manger promises.  This chart
    describes the method for setting drag promises via AddDragItemFlavor().
    
        dataPtr         dataSize                                result
     pointer value  actual data size    The data of size dataSize pointed to by dataPtr is added to the drag.
        NULL             ignored        A promise is placed on the drag.
}
{
 *  AddDragItemFlavor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION AddDragItemFlavor(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; theFlags: FlavorFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $ABED;
	{$ENDC}

{
 *  SetDragItemFlavorData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragItemFlavorData(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • PROVIDING CALLBACK PROCEDURES
  _________________________________________________________________________________________________________
}

{
 *  SetDragSendProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragSendProc(theDrag: DragRef; sendProc: DragSendDataUPP; dragSendRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $ABED;
	{$ENDC}


{
 *  SetDragInputProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragInputProc(theDrag: DragRef; inputProc: DragInputUPP; dragInputRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $ABED;
	{$ENDC}

{
 *  SetDragDrawingProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragDrawingProc(theDrag: DragRef; drawingProc: DragDrawingUPP; dragDrawingRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • SETTING THE DRAG IMAGE
  _________________________________________________________________________________________________________
}

{
 *  SetDragImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragImage(theDrag: DragRef; imagePixMap: PixMapHandle; imageRgn: RgnHandle; imageOffsetPt: Point; theImageFlags: DragImageFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $ABED;
	{$ENDC}


{
  _________________________________________________________________________________________________________
      
   • ALTERING THE BEHAVIOR OF A DRAG
  _________________________________________________________________________________________________________
}
{
 *  ChangeDragBehaviors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ChangeDragBehaviors(theDrag: DragRef; inBehaviorsToSet: DragBehaviors; inBehaviorsToClear: DragBehaviors): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7028, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • PERFORMING A DRAG
  _________________________________________________________________________________________________________
}
{
 *  TrackDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION TrackDrag(theDrag: DragRef; {CONST}VAR theEvent: EventRecord; theRegion: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $ABED;
	{$ENDC}


{
  _________________________________________________________________________________________________________
      
   • GETTING DRAG ITEM INFORMATION
  _________________________________________________________________________________________________________
}

{
 *  CountDragItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CountDragItems(theDrag: DragRef; VAR numItems: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $ABED;
	{$ENDC}

{
 *  GetDragItemReferenceNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragItemReferenceNumber(theDrag: DragRef; index: UInt16; VAR theItemRef: DragItemRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $ABED;
	{$ENDC}

{
 *  CountDragItemFlavors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CountDragItemFlavors(theDrag: DragRef; theItemRef: DragItemRef; VAR numFlavors: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $ABED;
	{$ENDC}

{
 *  GetFlavorType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetFlavorType(theDrag: DragRef; theItemRef: DragItemRef; index: UInt16; VAR theType: FlavorType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $ABED;
	{$ENDC}

{
 *  GetFlavorFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetFlavorFlags(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; VAR theFlags: FlavorFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $ABED;
	{$ENDC}

{
 *  GetFlavorDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetFlavorDataSize(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $ABED;
	{$ENDC}

{
 *  GetFlavorData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetFlavorData(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; dataPtr: UNIV Ptr; VAR dataSize: Size; dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • DRAG ITEM BOUNDS
  _________________________________________________________________________________________________________
}

{
 *  GetDragItemBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragItemBounds(theDrag: DragRef; theItemRef: DragItemRef; VAR itemBounds: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $ABED;
	{$ENDC}

{
 *  SetDragItemBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragItemBounds(theDrag: DragRef; theItemRef: DragItemRef; {CONST}VAR itemBounds: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • DROP LOCATIONS
  _________________________________________________________________________________________________________
}

{
 *  GetDropLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDropLocation(theDrag: DragRef; VAR dropLocation: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $ABED;
	{$ENDC}

{
 *  SetDropLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDropLocation(theDrag: DragRef; {CONST}VAR dropLocation: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • GETTING INFORMATION ABOUT A DRAG
  _________________________________________________________________________________________________________
}

{
 *  GetDragAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragAttributes(theDrag: DragRef; VAR flags: DragAttributes): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $ABED;
	{$ENDC}

{
 *  GetDragMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragMouse(theDrag: DragRef; VAR mouse: Point; VAR globalPinnedMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $ABED;
	{$ENDC}

{
 *  SetDragMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetDragMouse(theDrag: DragRef; globalPinnedMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $ABED;
	{$ENDC}

{
 *  GetDragOrigin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragOrigin(theDrag: DragRef; VAR globalInitialMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $ABED;
	{$ENDC}

{
 *  GetDragModifiers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragModifiers(theDrag: DragRef; VAR modifiers: SInt16; VAR mouseDownModifiers: SInt16; VAR mouseUpModifiers: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • ACCESSING DRAG ACTIONS
  _________________________________________________________________________________________________________
}

{
 *  GetDragAllowableActions()
 *  
 *  Discussion:
 *    Gets the actions the drag sender has allowed the receiver to
 *    perform. These are not requirements, but they highly suggested
 *    actions which allows the drag receiver to improve harmony across
 *    the system.  The allowable actions received are always those
 *    local to the caller's process.
 *  
 *  Parameters:
 *    
 *    theDrag:
 *      The drag reference from which to retreive the allowable drag
 *      actions.
 *    
 *    outActions:
 *      A pointer to receive the field of allowable drag actions.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION GetDragAllowableActions(theDrag: DragRef; VAR outActions: DragActions): OSStatus; C;

{
 *  SetDragAllowableActions()
 *  
 *  Discussion:
 *    Sets the actions the receiver of the drag is allowed to perform. 
 *    These are not requirements, but they highly suggested actions
 *    which allows the drag receiver to improve harmony across the
 *    system.  The caller may select wether these drag actions apply to
 *    a local or remote process.
 *  
 *  Parameters:
 *    
 *    theDrag:
 *      The drag reference in which to set the allowable drag actions.
 *    
 *    inActions:
 *      A field of allowable drag actions to be set.
 *    
 *    isLocal:
 *      A boolean value allowing the drag sender to distinguish between
 *      those drag actions allowable by the local receiver versus a
 *      remote one.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION SetDragAllowableActions(theDrag: DragRef; inActions: DragActions; isLocal: BOOLEAN): OSStatus; C;

{
 *  GetDragDropAction()
 *  
 *  Discussion:
 *    Gets the action performed by the receiver of the drag.  More than
 *    one action may have been performed.
 *  
 *  Parameters:
 *    
 *    theDrag:
 *      The drag reference from which to retreive the performed drop
 *      action.
 *    
 *    outAction:
 *      A pointer to receive the drag action performed.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION GetDragDropAction(theDrag: DragRef; VAR outAction: DragActions): OSStatus; C;

{
 *  SetDragDropAction()
 *  
 *  Discussion:
 *    Sets the action performed by the receiver of the drag.  More than
 *    one action may be performed.
 *  
 *  Parameters:
 *    
 *    theDrag:
 *      The drag reference in which to set the performed drop action.
 *    
 *    inAction:
 *      The drop action performed.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION SetDragDropAction(theDrag: DragRef; inAction: DragActions): OSStatus; C;

{
  _________________________________________________________________________________________________________
      
   • DRAG HIGHLIGHTING
  _________________________________________________________________________________________________________
}

{
 *  ShowDragHilite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ShowDragHilite(theDrag: DragRef; hiliteFrame: RgnHandle; inside: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $ABED;
	{$ENDC}

{
 *  HideDragHilite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION HideDragHilite(theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $ABED;
	{$ENDC}

{
 *  DragPreScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION DragPreScroll(theDrag: DragRef; dH: SInt16; dV: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $ABED;
	{$ENDC}

{
 *  DragPostScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION DragPostScroll(theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $ABED;
	{$ENDC}

{
 *  UpdateDragHilite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION UpdateDragHilite(theDrag: DragRef; updateRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $ABED;
	{$ENDC}

{
 *  GetDragHiliteColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION GetDragHiliteColor(window: WindowRef; VAR color: RGBColor): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $ABED;
	{$ENDC}


{
  _________________________________________________________________________________________________________
      
   • UTILITIES
  _________________________________________________________________________________________________________
}


{
 *  WaitMouseMoved()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION WaitMouseMoved(initialMouse: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $ABED;
	{$ENDC}


{
 *  ZoomRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ZoomRects({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; zoomSteps: SInt16; acceleration: ZoomAcceleration): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $ABED;
	{$ENDC}

{
 *  ZoomRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION ZoomRegion(region: RgnHandle; zoomDistance: Point; zoomSteps: SInt16; acceleration: ZoomAcceleration): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $ABED;
	{$ENDC}


{
  _________________________________________________________________________________________________________
   • OLD NAMES
     These are provided for compatiblity with older source bases.  It is recommended to not use them since
     they may removed from this interface file at any time.
  _________________________________________________________________________________________________________
}


TYPE
	DragReference						= DragRef;
	ItemReference						= DragItemRef;
{$IFC OLDROUTINENAMES }

CONST
	dragHasLeftSenderWindow		= $00000001;					{  drag has left the source window since TrackDrag  }
	dragInsideSenderApplication	= $00000002;					{  drag is occurring within the sender application  }
	dragInsideSenderWindow		= $00000004;					{  drag is occurring within the sender window  }

	dragTrackingEnterHandler	= 1;							{  drag has entered handler  }
	dragTrackingEnterWindow		= 2;							{  drag has entered window  }
	dragTrackingInWindow		= 3;							{  drag is moving within window  }
	dragTrackingLeaveWindow		= 4;							{  drag has exited window  }
	dragTrackingLeaveHandler	= 5;							{  drag has exited handler  }

	dragRegionBegin				= 1;							{  initialize drawing  }
	dragRegionDraw				= 2;							{  draw drag feedback  }
	dragRegionHide				= 3;							{  hide drag feedback  }
	dragRegionIdle				= 4;							{  drag feedback idle time  }
	dragRegionEnd				= 5;							{  end of drawing  }

	zoomNoAcceleration			= 0;							{  use linear interpolation  }
	zoomAccelerate				= 1;							{  ramp up step size  }
	zoomDecelerate				= 2;							{  ramp down step size  }

	kDragStandardImage			= 0;							{  65% image translucency (standard) }
	kDragDarkImage				= 1;							{  50% image translucency }
	kDragDarkerImage			= 2;							{  25% image translucency }
	kDragOpaqueImage			= 3;							{  0% image translucency (opaque) }

{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DragIncludes}

{$ENDC} {__DRAG__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
