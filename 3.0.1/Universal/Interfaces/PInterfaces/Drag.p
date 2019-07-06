{
 	File:		Drag.p
 
 	Contains:	Drag and Drop Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1992-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
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

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
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
	DragReference = ^LONGINT;
	ItemReference						= UInt32;
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


TYPE
	DragImageTranslucency				= UInt32;

CONST
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
	DragTrackingHandlerProcPtr = ProcPtr;  { FUNCTION DragTrackingHandler(message: DragTrackingMessage; theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDrag: DragReference): OSErr; }

	DragReceiveHandlerProcPtr = ProcPtr;  { FUNCTION DragReceiveHandler(theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDrag: DragReference): OSErr; }

	DragTrackingHandlerUPP = UniversalProcPtr;
	DragReceiveHandlerUPP = UniversalProcPtr;

CONST
	uppDragTrackingHandlerProcInfo = $00003FA0;
	uppDragReceiveHandlerProcInfo = $00000FE0;

FUNCTION NewDragTrackingHandlerProc(userRoutine: DragTrackingHandlerProcPtr): DragTrackingHandlerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDragReceiveHandlerProc(userRoutine: DragReceiveHandlerProcPtr): DragReceiveHandlerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragTrackingHandlerProc(message: DragTrackingMessage; theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDrag: DragReference; userRoutine: DragTrackingHandlerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDragReceiveHandlerProc(theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDrag: DragReference; userRoutine: DragReceiveHandlerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • APPLICATION-DEFINED ROUTINES
  _________________________________________________________________________________________________________
}

TYPE
	DragSendDataProcPtr = ProcPtr;  { FUNCTION DragSendData(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: ItemReference; theDrag: DragReference): OSErr; }

	DragInputProcPtr = ProcPtr;  { FUNCTION DragInput(VAR mouse: Point; VAR modifiers: SInt16; dragInputRefCon: UNIV Ptr; theDrag: DragReference): OSErr; }

	DragDrawingProcPtr = ProcPtr;  { FUNCTION DragDrawing(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDrag: DragReference): OSErr; }

	DragSendDataUPP = UniversalProcPtr;
	DragInputUPP = UniversalProcPtr;
	DragDrawingUPP = UniversalProcPtr;

CONST
	uppDragSendDataProcInfo = $00003FE0;
	uppDragInputProcInfo = $00003FE0;
	uppDragDrawingProcInfo = $000FFFA0;

FUNCTION NewDragSendDataProc(userRoutine: DragSendDataProcPtr): DragSendDataUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDragInputProc(userRoutine: DragInputProcPtr): DragInputUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDragDrawingProc(userRoutine: DragDrawingProcPtr): DragDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragSendDataProc(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: ItemReference; theDrag: DragReference; userRoutine: DragSendDataUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDragInputProc(VAR mouse: Point; VAR modifiers: SInt16; dragInputRefCon: UNIV Ptr; theDrag: DragReference; userRoutine: DragInputUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDragDrawingProc(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDrag: DragReference; userRoutine: DragDrawingUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • INSTALLING AND REMOVING HANDLERS API'S
  _________________________________________________________________________________________________________
}

FUNCTION InstallTrackingHandler(trackingHandler: DragTrackingHandlerUPP; theWindow: WindowPtr; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABED;
	{$ENDC}
FUNCTION InstallReceiveHandler(receiveHandler: DragReceiveHandlerUPP; theWindow: WindowPtr; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABED;
	{$ENDC}
FUNCTION RemoveTrackingHandler(trackingHandler: DragTrackingHandlerUPP; theWindow: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $ABED;
	{$ENDC}
FUNCTION RemoveReceiveHandler(receiveHandler: DragReceiveHandlerUPP; theWindow: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • CREATING & DISPOSING
  _________________________________________________________________________________________________________
}

FUNCTION NewDrag(VAR theDrag: DragReference): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $ABED;
	{$ENDC}
FUNCTION DisposeDrag(theDrag: DragReference): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • ADDING DRAG ITEM FLAVORS
  _________________________________________________________________________________________________________
}

FUNCTION AddDragItemFlavor(theDrag: DragReference; theItemRef: ItemReference; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; theFlags: FlavorFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $ABED;
	{$ENDC}
FUNCTION SetDragItemFlavorData(theDrag: DragReference; theItemRef: ItemReference; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • PROVIDING CALLBACK PROCEDURES
  _________________________________________________________________________________________________________
}

FUNCTION SetDragSendProc(theDrag: DragReference; sendProc: DragSendDataUPP; dragSendRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $ABED;
	{$ENDC}

FUNCTION SetDragInputProc(theDrag: DragReference; inputProc: DragInputUPP; dragInputRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $ABED;
	{$ENDC}
FUNCTION SetDragDrawingProc(theDrag: DragReference; drawingProc: DragDrawingUPP; dragDrawingRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • SETTING THE DRAG IMAGE
  _________________________________________________________________________________________________________
}

FUNCTION SetDragImage(theDrag: DragReference; imagePixMap: PixMapHandle; imageRgn: RgnHandle; imageOffsetPt: Point; theImageFlags: DragImageFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • PERFORMING A DRAG
  _________________________________________________________________________________________________________
}

FUNCTION TrackDrag(theDrag: DragReference; {CONST}VAR theEvent: EventRecord; theRegion: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • GETTING DRAG ITEM INFORMATION
  _________________________________________________________________________________________________________
}

FUNCTION CountDragItems(theDrag: DragReference; VAR numItems: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $ABED;
	{$ENDC}
FUNCTION GetDragItemReferenceNumber(theDrag: DragReference; index: UInt16; VAR theItemRef: ItemReference): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $ABED;
	{$ENDC}
FUNCTION CountDragItemFlavors(theDrag: DragReference; theItemRef: ItemReference; VAR numFlavors: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $ABED;
	{$ENDC}
FUNCTION GetFlavorType(theDrag: DragReference; theItemRef: ItemReference; index: UInt16; VAR theType: FlavorType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $ABED;
	{$ENDC}
FUNCTION GetFlavorFlags(theDrag: DragReference; theItemRef: ItemReference; theType: FlavorType; VAR theFlags: FlavorFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $ABED;
	{$ENDC}
FUNCTION GetFlavorDataSize(theDrag: DragReference; theItemRef: ItemReference; theType: FlavorType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $ABED;
	{$ENDC}
FUNCTION GetFlavorData(theDrag: DragReference; theItemRef: ItemReference; theType: FlavorType; dataPtr: UNIV Ptr; VAR dataSize: Size; dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • DRAG ITEM BOUNDS
  _________________________________________________________________________________________________________
}

FUNCTION GetDragItemBounds(theDrag: DragReference; theItemRef: ItemReference; VAR itemBounds: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $ABED;
	{$ENDC}
FUNCTION SetDragItemBounds(theDrag: DragReference; theItemRef: ItemReference; {CONST}VAR itemBounds: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • DROP LOCATIONS
  _________________________________________________________________________________________________________
}

FUNCTION GetDropLocation(theDrag: DragReference; VAR dropLocation: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $ABED;
	{$ENDC}
FUNCTION SetDropLocation(theDrag: DragReference; {CONST}VAR dropLocation: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • GETTING INFORMATION ABOUT A DRAG
  _________________________________________________________________________________________________________
}

FUNCTION GetDragAttributes(theDrag: DragReference; VAR flags: DragAttributes): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $ABED;
	{$ENDC}
FUNCTION GetDragMouse(theDrag: DragReference; VAR mouse: Point; VAR globalPinnedMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $ABED;
	{$ENDC}
FUNCTION SetDragMouse(theDrag: DragReference; globalPinnedMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $ABED;
	{$ENDC}
FUNCTION GetDragOrigin(theDrag: DragReference; VAR globalInitialMouse: Point): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $ABED;
	{$ENDC}
FUNCTION GetDragModifiers(theDrag: DragReference; VAR modifiers: SInt16; VAR mouseDownModifiers: SInt16; VAR mouseUpModifiers: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $ABED;
	{$ENDC}
{
  _________________________________________________________________________________________________________
      
   • DRAG HIGHLIGHTING
  _________________________________________________________________________________________________________
}

FUNCTION ShowDragHilite(theDrag: DragReference; hiliteFrame: RgnHandle; inside: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $ABED;
	{$ENDC}
FUNCTION HideDragHilite(theDrag: DragReference): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $ABED;
	{$ENDC}
FUNCTION DragPreScroll(theDrag: DragReference; dH: SInt16; dV: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $ABED;
	{$ENDC}
FUNCTION DragPostScroll(theDrag: DragReference): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $ABED;
	{$ENDC}
FUNCTION UpdateDragHilite(theDrag: DragReference; updateRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $ABED;
	{$ENDC}
FUNCTION GetDragHiliteColor(window: WindowPtr; VAR color: RGBColor): OSErr;
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
