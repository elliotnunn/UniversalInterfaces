{
 	File:		Drag.p
 
 	Contains:	Drag and Drop Interfaces.
 
 	Version:	Technology:	System 8.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1992-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
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
	DragRef = ^LONGINT; { an opaque 32-bit type }
	DragItemRef							= UInt32;
	FlavorType							= OSType;
{
  _________________________________________________________________________________________________________
      
   • DRAG ATTRIBUTES
  _________________________________________________________________________________________________________
}
	DragAttributes						= OptionBits;

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
	DragBehaviors						= OptionBits;

CONST
	kDragBehaviorNone			= 0;
	kDragBehaviorZoomBackAnimation = $00000001;					{  do zoomback animation for failed drags (normally enabled). }

{
  _________________________________________________________________________________________________________
      
   • DRAG IMAGE FLAGS
  _________________________________________________________________________________________________________
}

TYPE
	DragImageFlags						= OptionBits;

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
	DragRegionMessage					= SInt16;

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
	ZoomAcceleration					= SInt16;

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
	FlavorFlags							= OptionBits;

CONST
	flavorSenderOnly			= $01;							{  flavor is available to sender only }
	flavorSenderTranslated		= $02;							{  flavor is translated by sender }
	flavorNotSaved				= $04;							{  flavor should not be saved }
	flavorSystemTranslated		= $0100;						{  flavor is translated by system }

{
  _________________________________________________________________________________________________________
      
   • SPECIAL FLAVORS
  _________________________________________________________________________________________________________
}

	flavorTypeHFS				= 'hfs ';						{  flavor type for HFS data }
	flavorTypePromiseHFS		= 'phfs';						{  flavor type for promised HFS data }
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
	DragTrackingMessage					= SInt16;

CONST
	kDragTrackingEnterHandler	= 1;							{  drag has entered handler }
	kDragTrackingEnterWindow	= 2;							{  drag has entered window }
	kDragTrackingInWindow		= 3;							{  drag is moving within window }
	kDragTrackingLeaveWindow	= 4;							{  drag has exited window }
	kDragTrackingLeaveHandler	= 5;							{  drag has exited handler }

{
  _________________________________________________________________________________________________________
      
   • HFS FLAVORS
  _________________________________________________________________________________________________________
}


TYPE
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

	DragTrackingHandlerUPP = UniversalProcPtr;
	DragReceiveHandlerUPP = UniversalProcPtr;

CONST
	uppDragTrackingHandlerProcInfo = $00003FA0;
	uppDragReceiveHandlerProcInfo = $00000FE0;

FUNCTION NewDragTrackingHandlerUPP(userRoutine: DragTrackingHandlerProcPtr): DragTrackingHandlerUPP; { old name was NewDragTrackingHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDragReceiveHandlerUPP(userRoutine: DragReceiveHandlerProcPtr): DragReceiveHandlerUPP; { old name was NewDragReceiveHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDragTrackingHandlerUPP(userUPP: DragTrackingHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDragReceiveHandlerUPP(userUPP: DragReceiveHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeDragTrackingHandlerUPP(message: DragTrackingMessage; theWindow: WindowRef; handlerRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragTrackingHandlerUPP): OSErr; { old name was CallDragTrackingHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

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

	DragSendDataUPP = UniversalProcPtr;
	DragInputUPP = UniversalProcPtr;
	DragDrawingUPP = UniversalProcPtr;

CONST
	uppDragSendDataProcInfo = $00003FE0;
	uppDragInputProcInfo = $00003FE0;
	uppDragDrawingProcInfo = $000FFFA0;

FUNCTION NewDragSendDataUPP(userRoutine: DragSendDataProcPtr): DragSendDataUPP; { old name was NewDragSendDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDragInputUPP(userRoutine: DragInputProcPtr): DragInputUPP; { old name was NewDragInputProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDragDrawingUPP(userRoutine: DragDrawingProcPtr): DragDrawingUPP; { old name was NewDragDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDragSendDataUPP(userUPP: DragSendDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDragInputUPP(userUPP: DragInputUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDragDrawingUPP(userUPP: DragDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeDragSendDataUPP(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: DragItemRef; theDrag: DragRef; userRoutine: DragSendDataUPP): OSErr; { old name was CallDragSendDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDragInputUPP(VAR mouse: Point; VAR modifiers: SInt16; dragInputRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragInputUPP): OSErr; { old name was CallDragInputProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDragDrawingUPP(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDrag: DragRef; userRoutine: DragDrawingUPP): OSErr; { old name was CallDragDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • INSTALLING AND REMOVING HANDLERS API'S
  _________________________________________________________________________________________________________
}

FUNCTION InstallTrackingHandler(trackingHandler: DragTrackingHandlerUPP; theWindow: WindowRef; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABED;
	{$ENDC}
FUNCTION InstallReceiveHandler(receiveHandler: DragReceiveHandlerUPP; theWindow: WindowRef; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABED;
	{$ENDC}
FUNCTION RemoveTrackingHandler(trackingHandler: DragTrackingHandlerUPP; theWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $ABED;
	{$ENDC}
FUNCTION RemoveReceiveHandler(receiveHandler: DragReceiveHandlerUPP; theWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • CREATING & DISPOSING
  _________________________________________________________________________________________________________
}

FUNCTION NewDrag(VAR theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $ABED;
	{$ENDC}
FUNCTION DisposeDrag(theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • ADDING DRAG ITEM FLAVORS
  _________________________________________________________________________________________________________
}

FUNCTION AddDragItemFlavor(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; theFlags: FlavorFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $ABED;
	{$ENDC}
FUNCTION SetDragItemFlavorData(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • PROVIDING CALLBACK PROCEDURES
  _________________________________________________________________________________________________________
}

FUNCTION SetDragSendProc(theDrag: DragRef; sendProc: DragSendDataUPP; dragSendRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $ABED;
	{$ENDC}

FUNCTION SetDragInputProc(theDrag: DragRef; inputProc: DragInputUPP; dragInputRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $ABED;
	{$ENDC}
FUNCTION SetDragDrawingProc(theDrag: DragRef; drawingProc: DragDrawingUPP; dragDrawingRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • SETTING THE DRAG IMAGE
  _________________________________________________________________________________________________________
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
FUNCTION ChangeDragBehaviors(theDrag: DragRef; inBehaviorsToSet: DragBehaviors; inBehaviorsToClear: DragBehaviors): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7028, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • PERFORMING A DRAG
  _________________________________________________________________________________________________________
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
FUNCTION CountDragItems(theDrag: DragRef; VAR numItems: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $ABED;
	{$ENDC}
FUNCTION GetDragItemReferenceNumber(theDrag: DragRef; index: UInt16; VAR theItemRef: DragItemRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $ABED;
	{$ENDC}
FUNCTION CountDragItemFlavors(theDrag: DragRef; theItemRef: DragItemRef; VAR numFlavors: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $ABED;
	{$ENDC}
FUNCTION GetFlavorType(theDrag: DragRef; theItemRef: DragItemRef; index: UInt16; VAR theType: FlavorType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $ABED;
	{$ENDC}
FUNCTION GetFlavorFlags(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; VAR theFlags: FlavorFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $ABED;
	{$ENDC}
FUNCTION GetFlavorDataSize(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $ABED;
	{$ENDC}
FUNCTION GetFlavorData(theDrag: DragRef; theItemRef: DragItemRef; theType: FlavorType; dataPtr: UNIV Ptr; VAR dataSize: Size; dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • DRAG ITEM BOUNDS
  _________________________________________________________________________________________________________
}

FUNCTION GetDragItemBounds(theDrag: DragRef; theItemRef: DragItemRef; VAR itemBounds: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $ABED;
	{$ENDC}
FUNCTION SetDragItemBounds(theDrag: DragRef; theItemRef: DragItemRef; {CONST}VAR itemBounds: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • DROP LOCATIONS
  _________________________________________________________________________________________________________
}

FUNCTION GetDropLocation(theDrag: DragRef; VAR dropLocation: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $ABED;
	{$ENDC}
FUNCTION SetDropLocation(theDrag: DragRef; {CONST}VAR dropLocation: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • GETTING INFORMATION ABOUT A DRAG
  _________________________________________________________________________________________________________
}

FUNCTION GetDragAttributes(theDrag: DragRef; VAR flags: DragAttributes): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $ABED;
	{$ENDC}
FUNCTION GetDragMouse(theDrag: DragRef; VAR mouse: Point; VAR globalPinnedMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $ABED;
	{$ENDC}
FUNCTION SetDragMouse(theDrag: DragRef; globalPinnedMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $ABED;
	{$ENDC}
FUNCTION GetDragOrigin(theDrag: DragRef; VAR globalInitialMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $ABED;
	{$ENDC}
FUNCTION GetDragModifiers(theDrag: DragRef; VAR modifiers: SInt16; VAR mouseDownModifiers: SInt16; VAR mouseUpModifiers: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • DRAG HIGHLIGHTING
  _________________________________________________________________________________________________________
}

FUNCTION ShowDragHilite(theDrag: DragRef; hiliteFrame: RgnHandle; inside: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $ABED;
	{$ENDC}
FUNCTION HideDragHilite(theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $ABED;
	{$ENDC}
FUNCTION DragPreScroll(theDrag: DragRef; dH: SInt16; dV: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $ABED;
	{$ENDC}
FUNCTION DragPostScroll(theDrag: DragRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $ABED;
	{$ENDC}
FUNCTION UpdateDragHilite(theDrag: DragRef; updateRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $ABED;
	{$ENDC}
FUNCTION GetDragHiliteColor(window: WindowRef; VAR color: RGBColor): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $ABED;
	{$ENDC}

{
  _________________________________________________________________________________________________________
      
   • UTILITIES
  _________________________________________________________________________________________________________
}


FUNCTION WaitMouseMoved(initialMouse: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $ABED;
	{$ENDC}

FUNCTION ZoomRects({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; zoomSteps: SInt16; acceleration: ZoomAcceleration): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $ABED;
	{$ENDC}
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
