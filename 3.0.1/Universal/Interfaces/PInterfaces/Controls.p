{
 	File:		Controls.p
 
 	Contains:	Control Manager interfaces
 
 	Version:	Technology:	MacOS 7.x
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Controls;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLS__}
{$SETC __CONTROLS__ := 1}

{$I+}
{$SETC ControlsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
  	• Resource types
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

CONST
	kControlDefProcType			= 'CDEF';
	kControlTemplateResourceType = 'CNTL';
	kControlColorTableResourceType = 'cctb';
	kControlDefProcResourceType	= 'CDEF';

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
  	• Format of a 'CNTL' resource
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}


TYPE
	ControlTemplatePtr = ^ControlTemplate;
	ControlTemplate = RECORD
		controlRect:			Rect;
		controlValue:			SInt16;
		controlVisible:			BOOLEAN;
		fill:					SInt8;
		controlMaximum:			SInt16;
		controlMinimum:			SInt16;
		controlDefProcID:		SInt16;
		controlReference:		SInt32;
		controlTitle:			Str255;
	END;

	ControlTemplateHandle				= ^ControlTemplatePtr;
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL DEFINITION ID'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

{  Standard System 7 procID's }


CONST
	pushButProc					= 0;
	checkBoxProc				= 1;
	radioButProc				= 2;
	scrollBarProc				= 16;
	popupMenuProc				= 1008;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • VARIANT CODES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

TYPE
	ControlVariant						= SInt16;

CONST
	kControlNoVariant			= 0;							{  No variant }
	kControlUsesOwningWindowsFontVariant = $08;					{  Control uses owning windows font to display text }

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL PART CODES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

TYPE
	ControlPartCode						= SInt16;

CONST
	kControlNoPart				= 0;
	kControlLabelPart			= 1;
	kControlMenuPart			= 2;
	kControlTrianglePart		= 4;
	kControlButtonPart			= 10;
	kControlCheckBoxPart		= 11;
	kControlRadioButtonPart		= 11;
	kControlUpButtonPart		= 20;
	kControlDownButtonPart		= 21;
	kControlPageUpPart			= 22;
	kControlPageDownPart		= 23;
	kControlIndicatorPart		= 129;
	kControlDisabledPart		= 254;
	kControlInactivePart		= 255;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CHECK BOX VALUES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

	kControlCheckBoxUncheckedValue = 0;
	kControlCheckBoxCheckedValue = 1;
	kControlCheckBoxMixedValue	= 2;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • RADIO BUTTON VALUES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

	kControlRadioButtonUncheckedValue = 0;
	kControlRadioButtonCheckedValue = 1;
	kControlRadioButtonMixedValue = 2;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   
   • CONTROL POP-UP MENU CONSTANTS
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

{  Variant codes for the System 7 pop-up menu }
	popupFixedWidth				= $01;
	popupVariableWidth			= $02;
	popupUseAddResMenu			= $04;
	popupUseWFont				= $08;

{  Menu label styles for the System 7 pop-up menu  }
	popupTitleBold				= $0100;
	popupTitleItalic			= $0200;
	popupTitleUnderline			= $0400;
	popupTitleOutline			= $0800;
	popupTitleShadow			= $1000;
	popupTitleCondense			= $2000;
	popupTitleExtend			= $4000;
	popupTitleNoStyle			= $8000;

{  Menu label justifications for the System 7 pop-up menu }
	popupTitleLeftJust			= $00000000;
	popupTitleCenterJust		= $00000001;
	popupTitleRightJust			= $000000FF;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL DRAGGRAYRGN CONSTANTS
     For DragGrayRgnUPP used in TrackControl() 
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

	noConstraint				= 0;
	hAxisOnly					= 1;
	vAxisOnly					= 2;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL COLOR TABLE PART CODES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

	cFrameColor					= 0;
	cBodyColor					= 1;
	cTextColor					= 2;
	cThumbColor					= 3;
	kNumberCtlCTabEntries		= 4;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROLHANDLE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}


TYPE
	ControlRecordPtr = ^ControlRecord;
	ControlPtr							= ^ControlRecord;
	ControlHandle						= ^ControlPtr;
{  ControlRef is obsolete. Use ControlHandle.  }
	ControlRef							= ControlHandle;
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL ACTIONPROC POINTER
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
	ControlActionProcPtr = ProcPtr;  { PROCEDURE ControlAction(theControl: ControlHandle; partCode: ControlPartCode); }

	ControlActionUPP = UniversalProcPtr;
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL COLOR TABLE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
	CtlCTabPtr = ^CtlCTab;
	CtlCTab = RECORD
		ccSeed:					SInt32;
		ccRider:				SInt16;
		ctSize:					SInt16;
		ctTable:				ARRAY [0..3] OF ColorSpec;
	END;

	CCTabPtr							= ^CtlCTab;
	CCTabHandle							= ^CCTabPtr;
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL RECORD
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
	ControlRecord = PACKED RECORD
		nextControl:			ControlHandle;
		contrlOwner:			WindowPtr;
		contrlRect:				Rect;
		contrlVis:				UInt8;
		contrlHilite:			UInt8;
		contrlValue:			SInt16;
		contrlMin:				SInt16;
		contrlMax:				SInt16;
		contrlDefProc:			Handle;
		contrlData:				Handle;
		contrlAction:			ControlActionUPP;
		contrlRfCon:			SInt32;
		contrlTitle:			Str255;
	END;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • AUXILLARY CONTROL RECORD STRUCTURE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
	AuxCtlRecPtr = ^AuxCtlRec;
	AuxCtlRec = RECORD
		acNext:					Handle;
		acOwner:				ControlHandle;
		acCTable:				CCTabHandle;
		acFlags:				SInt16;
		acReserved:				SInt32;
		acRefCon:				SInt32;
	END;

	AuxCtlPtr							= ^AuxCtlRec;
	AuxCtlHandle						= ^AuxCtlPtr;
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • POP-UP MENU PRIVATE DATA STRUCTURE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
	PopupPrivateDataPtr = ^PopupPrivateData;
	PopupPrivateData = RECORD
		mHandle:				MenuHandle;
		mID:					SInt16;
	END;

	PopupPrivateDataHandle				= ^PopupPrivateDataPtr;
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL ACTION PROC UPP'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}



CONST
	uppControlActionProcInfo = $000002C0;

FUNCTION NewControlActionProc(userRoutine: ControlActionProcPtr): ControlActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallControlActionProc(theControl: ControlHandle; partCode: ControlPartCode; userRoutine: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL CREATION / DELETION API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
FUNCTION NewControl(owningWindow: WindowPtr; {CONST}VAR boundsRect: Rect; controlTitle: ConstStr255Param; initiallyVisible: BOOLEAN; initialValue: SInt16; minimumValue: SInt16; maximumValue: SInt16; procID: SInt16; controlReference: SInt32): ControlHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A954;
	{$ENDC}
FUNCTION GetNewControl(resourceID: SInt16; owningWindow: WindowPtr): ControlHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BE;
	{$ENDC}
PROCEDURE DisposeControl(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A955;
	{$ENDC}
PROCEDURE KillControls(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A956;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL SHOWING/HIDING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE ShowControl(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A957;
	{$ENDC}
PROCEDURE HideControl(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A958;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL DRAWING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE DrawControls(theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A969;
	{$ENDC}
PROCEDURE Draw1Control(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96D;
	{$ENDC}

PROCEDURE UpdateControls(theWindow: WindowPtr; updateRegion: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A953;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL HIGHLIGHT API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE HiliteControl(theControl: ControlHandle; hiliteState: ControlPartCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95D;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL TRACKING/DRAGGING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

{
  	When using the TrackControl() call when tracking an indicator, the actionProc parameter (type ControlActionUPP) 
    should be replaced by a parameter of type DragGrayRgnUPP (see Quickdraw.h).
}
FUNCTION TrackControl(theControl: ControlHandle; startPoint: Point; actionProc: ControlActionUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A968;
	{$ENDC}
PROCEDURE DragControl(theControl: ControlHandle; startPoint: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: DragConstraint);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A967;
	{$ENDC}
FUNCTION TestControl(theControl: ControlHandle; testPoint: Point): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A966;
	{$ENDC}
FUNCTION FindControl(testPoint: Point; theWindow: WindowPtr; VAR theControl: ControlHandle): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96C;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL MOVING/SIZING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE MoveControl(theControl: ControlHandle; h: SInt16; v: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A959;
	{$ENDC}
PROCEDURE SizeControl(theControl: ControlHandle; w: SInt16; h: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95C;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL TITLE API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE SetControlTitle(theControl: ControlHandle; title: ConstStr255Param);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95F;
	{$ENDC}
PROCEDURE GetControlTitle(theControl: ControlHandle; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95E;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL VALUE, MIMIMUM, AND MAXIMUM API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

FUNCTION GetControlValue(theControl: ControlHandle): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A960;
	{$ENDC}
PROCEDURE SetControlValue(theControl: ControlHandle; newValue: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A963;
	{$ENDC}
FUNCTION GetControlMinimum(theControl: ControlHandle): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A961;
	{$ENDC}
PROCEDURE SetControlMinimum(theControl: ControlHandle; newMinimum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A964;
	{$ENDC}
FUNCTION GetControlMaximum(theControl: ControlHandle): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A962;
	{$ENDC}
PROCEDURE SetControlMaximum(theControl: ControlHandle; newMaximum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A965;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL VARIANT AND WINDOW INFORMATION API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

FUNCTION GetControlVariant(theControl: ControlHandle): ControlVariant;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A809;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL ACTION PROC API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE SetControlAction(theControl: ControlHandle; actionProc: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96B;
	{$ENDC}
FUNCTION GetControlAction(theControl: ControlHandle): ControlActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96A;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL ACCESSOR API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

PROCEDURE SetControlReference(theControl: ControlHandle; data: SInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95B;
	{$ENDC}
FUNCTION GetControlReference(theControl: ControlHandle): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95A;
	{$ENDC}
FUNCTION GetAuxiliaryControlRecord(theControl: ControlHandle; VAR acHndl: AuxCtlHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA44;
	{$ENDC}
PROCEDURE SetControlColor(theControl: ControlHandle; newColorTable: CCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA43;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • VALID 'CDEF' MESSAGES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}


TYPE
	ControlDefProcMessage				= SInt16;

CONST
	drawCntl					= 0;
	testCntl					= 1;
	calcCRgns					= 2;
	initCntl					= 3;
	dispCntl					= 4;
	posCntl						= 5;
	thumbCntl					= 6;
	dragCntl					= 7;
	autoTrack					= 8;
	calcCntlRgn					= 10;
	calcThumbRgn				= 11;
	drawThumbOutline			= 12;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • MAIN ENTRY POINT FOR 'CDEF'
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}


TYPE
	ControlDefProcPtr = ProcPtr;  { FUNCTION ControlDef(varCode: SInt16; theControl: ControlHandle; message: ControlDefProcMessage; param: SInt32): SInt32; }

	ControlDefUPP = UniversalProcPtr;

CONST
	uppControlDefProcInfo = $00003BB0;

FUNCTION NewControlDefProc(userRoutine: ControlDefProcPtr): ControlDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallControlDefProc(varCode: SInt16; theControl: ControlHandle; message: ControlDefProcMessage; param: SInt32; userRoutine: ControlDefUPP): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONSTANTS FOR DRAWCNTL MESSAGE PASSED IN PARAM
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

CONST
	kDrawControlEntireControl	= 0;
	kDrawControlIndicatorOnly	= 129;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONSTANTS FOR DRAGCNTL MESSAGE PASSED IN PARAM
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

	kDragControlEntireControl	= 0;
	kDragControlIndicator		= 1;

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • DRAG CONSTRAINT STRUCTURE PASSED IN PARAM FOR THUMBCNTL MESSAGE (IM I-332)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}


TYPE
	IndicatorDragConstraintPtr = ^IndicatorDragConstraint;
	IndicatorDragConstraint = RECORD
		limitRect:				Rect;
		slopRect:				Rect;
		axis:					DragConstraint;
	END;

	IndicatorDragConstraintHandle		= ^IndicatorDragConstraintPtr;
{$IFC OLDROUTINENAMES }
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • OLDROUTINENAMES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
{  Variants applicable to all controls (at least ones with text) }

CONST
	useWFont					= $08;

	inLabel						= 1;
	inMenu						= 2;
	inTriangle					= 4;
	inButton					= 10;
	inCheckBox					= 11;
	inUpButton					= 20;
	inDownButton				= 21;
	inPageUp					= 22;
	inPageDown					= 23;
	inThumb						= 129;

	kNoHiliteControlPart		= 0;
	kInLabelControlPart			= 1;
	kInMenuControlPart			= 2;
	kInTriangleControlPart		= 4;
	kInButtonControlPart		= 10;
	kInCheckBoxControlPart		= 11;
	kInUpButtonControlPart		= 20;
	kInDownButtonControlPart	= 21;
	kInPageUpControlPart		= 22;
	kInPageDownControlPart		= 23;
	kInIndicatorControlPart		= 129;
	kReservedControlPart		= 254;
	kControlInactiveControlPart	= 255;

PROCEDURE SetCTitle(theControl: ControlHandle; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95F;
	{$ENDC}
PROCEDURE GetCTitle(theControl: ControlHandle; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95E;
	{$ENDC}
PROCEDURE UpdtControl(theWindow: WindowPtr; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A953;
	{$ENDC}
PROCEDURE SetCtlValue(theControl: ControlHandle; theValue: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A963;
	{$ENDC}
FUNCTION GetCtlValue(theControl: ControlHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A960;
	{$ENDC}
PROCEDURE SetCtlMin(theControl: ControlHandle; minValue: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A964;
	{$ENDC}
FUNCTION GetCtlMin(theControl: ControlHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A961;
	{$ENDC}
PROCEDURE SetCtlMax(theControl: ControlHandle; maxValue: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A965;
	{$ENDC}
FUNCTION GetCtlMax(theControl: ControlHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A962;
	{$ENDC}
PROCEDURE SetCRefCon(theControl: ControlHandle; data: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95B;
	{$ENDC}
FUNCTION GetCRefCon(theControl: ControlHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95A;
	{$ENDC}
PROCEDURE SetCtlAction(theControl: ControlHandle; actionProc: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96B;
	{$ENDC}
FUNCTION GetCtlAction(theControl: ControlHandle): ControlActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96A;
	{$ENDC}
PROCEDURE SetCtlColor(theControl: ControlHandle; newColorTable: CCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA43;
	{$ENDC}
FUNCTION GetCVariant(theControl: ControlHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A809;
	{$ENDC}
{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlsIncludes}

{$ENDC} {__CONTROLS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
