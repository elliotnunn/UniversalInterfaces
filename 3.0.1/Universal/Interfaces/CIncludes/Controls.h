/*
 	File:		Controls.h
 
 	Contains:	Control Manager interfaces
 
 	Version:	Technology:	MacOS 7.x
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __CONTROLS__
#define __CONTROLS__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __MENUS__
#include <Menus.h>
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
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
  	• Resource types
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

enum {
	kControlDefProcType			= FOUR_CHAR_CODE('CDEF'),
	kControlTemplateResourceType = FOUR_CHAR_CODE('CNTL'),
	kControlColorTableResourceType = FOUR_CHAR_CODE('cctb'),
	kControlDefProcResourceType	= FOUR_CHAR_CODE('CDEF')
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
  	• Format of a 'CNTL' resource
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

struct ControlTemplate {
	Rect 							controlRect;
	SInt16 							controlValue;
	Boolean 						controlVisible;
	UInt8 							fill;
	SInt16 							controlMaximum;
	SInt16 							controlMinimum;
	SInt16 							controlDefProcID;
	SInt32 							controlReference;
	Str255 							controlTitle;
};
typedef struct ControlTemplate ControlTemplate;

typedef ControlTemplate *				ControlTemplatePtr;
typedef ControlTemplatePtr *			ControlTemplateHandle;
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL DEFINITION ID'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

/* Standard System 7 procID's*/


enum {
	pushButProc					= 0,
	checkBoxProc				= 1,
	radioButProc				= 2,
	scrollBarProc				= 16,
	popupMenuProc				= 1008
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • VARIANT CODES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
typedef SInt16 							ControlVariant;

enum {
	kControlNoVariant			= 0,							/* No variant*/
	kControlUsesOwningWindowsFontVariant = 1 << 3				/* Control uses owning windows font to display text*/
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL PART CODES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
typedef SInt16 							ControlPartCode;

enum {
	kControlNoPart				= 0,
	kControlLabelPart			= 1,
	kControlMenuPart			= 2,
	kControlTrianglePart		= 4,
	kControlButtonPart			= 10,
	kControlCheckBoxPart		= 11,
	kControlRadioButtonPart		= 11,
	kControlUpButtonPart		= 20,
	kControlDownButtonPart		= 21,
	kControlPageUpPart			= 22,
	kControlPageDownPart		= 23,
	kControlIndicatorPart		= 129,
	kControlDisabledPart		= 254,
	kControlInactivePart		= 255
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CHECK BOX VALUES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/


enum {
	kControlCheckBoxUncheckedValue = 0,
	kControlCheckBoxCheckedValue = 1,
	kControlCheckBoxMixedValue	= 2
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • RADIO BUTTON VALUES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/


enum {
	kControlRadioButtonUncheckedValue = 0,
	kControlRadioButtonCheckedValue = 1,
	kControlRadioButtonMixedValue = 2
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   
   • CONTROL POP-UP MENU CONSTANTS
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

/* Variant codes for the System 7 pop-up menu*/

enum {
	popupFixedWidth				= 1 << 0,
	popupVariableWidth			= 1 << 1,
	popupUseAddResMenu			= 1 << 2,
	popupUseWFont				= 1 << 3
};

/* Menu label styles for the System 7 pop-up menu */

enum {
	popupTitleBold				= 1 << 8,
	popupTitleItalic			= 1 << 9,
	popupTitleUnderline			= 1 << 10,
	popupTitleOutline			= 1 << 11,
	popupTitleShadow			= 1 << 12,
	popupTitleCondense			= 1 << 13,
	popupTitleExtend			= 1 << 14,
	popupTitleNoStyle			= 1 << 15
};

/* Menu label justifications for the System 7 pop-up menu*/

enum {
	popupTitleLeftJust			= 0x00000000,
	popupTitleCenterJust		= 0x00000001,
	popupTitleRightJust			= 0x000000FF
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL DRAGGRAYRGN CONSTANTS
     For DragGrayRgnUPP used in TrackControl() 
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/


enum {
	noConstraint				= kNoConstraint,
	hAxisOnly					= 1,
	vAxisOnly					= 2
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL COLOR TABLE PART CODES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/


enum {
	cFrameColor					= 0,
	cBodyColor					= 1,
	cTextColor					= 2,
	cThumbColor					= 3,
	kNumberCtlCTabEntries		= 4
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROLHANDLE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

typedef struct ControlRecord 			ControlRecord;
typedef ControlRecord *					ControlPtr;
typedef ControlPtr *					ControlHandle;
/* ControlRef is obsolete. Use ControlHandle. */
typedef ControlHandle 					ControlRef;
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL ACTIONPROC POINTER
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
typedef CALLBACK_API( void , ControlActionProcPtr )(ControlHandle theControl, ControlPartCode partCode);
typedef STACK_UPP_TYPE(ControlActionProcPtr) 					ControlActionUPP;
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL COLOR TABLE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
struct CtlCTab {
	SInt32 							ccSeed;
	SInt16 							ccRider;
	SInt16 							ctSize;
	ColorSpec 						ctTable[4];
};
typedef struct CtlCTab CtlCTab;

typedef CtlCTab *						CCTabPtr;
typedef CCTabPtr *						CCTabHandle;
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL RECORD
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
struct ControlRecord {
	ControlHandle 					nextControl;
	WindowPtr 						contrlOwner;
	Rect 							contrlRect;
	UInt8 							contrlVis;
	UInt8 							contrlHilite;
	SInt16 							contrlValue;
	SInt16 							contrlMin;
	SInt16 							contrlMax;
	Handle 							contrlDefProc;
	Handle 							contrlData;
	ControlActionUPP 				contrlAction;
	SInt32 							contrlRfCon;
	Str255 							contrlTitle;
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • AUXILLARY CONTROL RECORD STRUCTURE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
struct AuxCtlRec {
	Handle 							acNext;
	ControlHandle 					acOwner;
	CCTabHandle 					acCTable;
	SInt16 							acFlags;
	SInt32 							acReserved;
	SInt32 							acRefCon;
};
typedef struct AuxCtlRec AuxCtlRec;

typedef AuxCtlRec *						AuxCtlPtr;
typedef AuxCtlPtr *						AuxCtlHandle;
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • POP-UP MENU PRIVATE DATA STRUCTURE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
struct PopupPrivateData {
	MenuHandle 						mHandle;
	SInt16 							mID;
};
typedef struct PopupPrivateData PopupPrivateData;

typedef PopupPrivateData *				PopupPrivateDataPtr;
typedef PopupPrivateDataPtr *			PopupPrivateDataHandle;
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • CONTROL ACTION PROC UPP'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/


enum { uppControlActionProcInfo = 0x000002C0 }; 				/* pascal no_return_value Func(4_bytes, 2_bytes) */
#define NewControlActionProc(userRoutine) 						(ControlActionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlActionProcInfo, GetCurrentArchitecture())
#define CallControlActionProc(userRoutine, theControl, partCode)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlActionProcInfo, (theControl), (partCode))
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL CREATION / DELETION API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API( ControlHandle )
NewControl						(WindowPtr 				owningWindow,
								 const Rect *			boundsRect,
								 ConstStr255Param 		controlTitle,
								 Boolean 				initiallyVisible,
								 SInt16 				initialValue,
								 SInt16 				minimumValue,
								 SInt16 				maximumValue,
								 SInt16 				procID,
								 SInt32 				controlReference)					ONEWORDINLINE(0xA954);

EXTERN_API( ControlHandle )
GetNewControl					(SInt16 				resourceID,
								 WindowPtr 				owningWindow)						ONEWORDINLINE(0xA9BE);

EXTERN_API( void )
DisposeControl					(ControlHandle 			theControl)							ONEWORDINLINE(0xA955);

EXTERN_API( void )
KillControls					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA956);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL SHOWING/HIDING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
ShowControl						(ControlHandle 			theControl)							ONEWORDINLINE(0xA957);

EXTERN_API( void )
HideControl						(ControlHandle 			theControl)							ONEWORDINLINE(0xA958);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL DRAWING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
DrawControls					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA969);

EXTERN_API( void )
Draw1Control					(ControlHandle 			theControl)							ONEWORDINLINE(0xA96D);

#define DrawOneControl(theControl) Draw1Control(theControl)

EXTERN_API( void )
UpdateControls					(WindowPtr 				theWindow,
								 RgnHandle 				updateRegion)						ONEWORDINLINE(0xA953);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL HIGHLIGHT API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
HiliteControl					(ControlHandle 			theControl,
								 ControlPartCode 		hiliteState)						ONEWORDINLINE(0xA95D);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL TRACKING/DRAGGING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

/*
  	When using the TrackControl() call when tracking an indicator, the actionProc parameter (type ControlActionUPP) 
    should be replaced by a parameter of type DragGrayRgnUPP (see Quickdraw.h).
*/
EXTERN_API( ControlPartCode )
TrackControl					(ControlHandle 			theControl,
								 Point 					startPoint,
								 ControlActionUPP 		actionProc)							ONEWORDINLINE(0xA968);

EXTERN_API( void )
DragControl						(ControlHandle 			theControl,
								 Point 					startPoint,
								 const Rect *			limitRect,
								 const Rect *			slopRect,
								 DragConstraint 		axis)								ONEWORDINLINE(0xA967);

EXTERN_API( ControlPartCode )
TestControl						(ControlHandle 			theControl,
								 Point 					testPoint)							ONEWORDINLINE(0xA966);

EXTERN_API( ControlPartCode )
FindControl						(Point 					testPoint,
								 WindowPtr 				theWindow,
								 ControlHandle *		theControl)							ONEWORDINLINE(0xA96C);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL MOVING/SIZING API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
MoveControl						(ControlHandle 			theControl,
								 SInt16 				h,
								 SInt16 				v)									ONEWORDINLINE(0xA959);

EXTERN_API( void )
SizeControl						(ControlHandle 			theControl,
								 SInt16 				w,
								 SInt16 				h)									ONEWORDINLINE(0xA95C);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL TITLE API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
SetControlTitle					(ControlHandle 			theControl,
								 ConstStr255Param 		title)								ONEWORDINLINE(0xA95F);

EXTERN_API( void )
GetControlTitle					(ControlHandle 			theControl,
								 Str255 				title)								ONEWORDINLINE(0xA95E);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL VALUE, MIMIMUM, AND MAXIMUM API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( SInt16 )
GetControlValue					(ControlHandle 			theControl)							ONEWORDINLINE(0xA960);

EXTERN_API( void )
SetControlValue					(ControlHandle 			theControl,
								 SInt16 				newValue)							ONEWORDINLINE(0xA963);

EXTERN_API( SInt16 )
GetControlMinimum				(ControlHandle 			theControl)							ONEWORDINLINE(0xA961);

EXTERN_API( void )
SetControlMinimum				(ControlHandle 			theControl,
								 SInt16 				newMinimum)							ONEWORDINLINE(0xA964);

EXTERN_API( SInt16 )
GetControlMaximum				(ControlHandle 			theControl)							ONEWORDINLINE(0xA962);

EXTERN_API( void )
SetControlMaximum				(ControlHandle 			theControl,
								 SInt16 				newMaximum)							ONEWORDINLINE(0xA965);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL VARIANT AND WINDOW INFORMATION API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( ControlVariant )
GetControlVariant				(ControlHandle 			theControl)							ONEWORDINLINE(0xA809);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL ACTION PROC API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
SetControlAction				(ControlHandle 			theControl,
								 ControlActionUPP 		actionProc)							ONEWORDINLINE(0xA96B);

EXTERN_API( ControlActionUPP )
GetControlAction				(ControlHandle 			theControl)							ONEWORDINLINE(0xA96A);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONTROL ACCESSOR API'S
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( void )
SetControlReference				(ControlHandle 			theControl,
								 SInt32 				data)								ONEWORDINLINE(0xA95B);

EXTERN_API( SInt32 )
GetControlReference				(ControlHandle 			theControl)							ONEWORDINLINE(0xA95A);

EXTERN_API( Boolean )
GetAuxiliaryControlRecord		(ControlHandle 			theControl,
								 AuxCtlHandle *			acHndl)								ONEWORDINLINE(0xAA44);

EXTERN_API( void )
SetControlColor					(ControlHandle 			theControl,
								 CCTabHandle 			newColorTable)						ONEWORDINLINE(0xAA43);

#define GetControlListFromWindow(theWindow)		( *(ControlHandle *) (((UInt8 *) theWindow) + sizeof(GrafPort) + 0x20))
#define GetControlOwningWindowControlList(theWindow)		( *(ControlHandle *) (((UInt8 *) theWindow) + sizeof(GrafPort) + 0x20))
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • VALID 'CDEF' MESSAGES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

typedef SInt16 							ControlDefProcMessage;

enum {
	drawCntl					= 0,
	testCntl					= 1,
	calcCRgns					= 2,
	initCntl					= 3,
	dispCntl					= 4,
	posCntl						= 5,
	thumbCntl					= 6,
	dragCntl					= 7,
	autoTrack					= 8,
	calcCntlRgn					= 10,
	calcThumbRgn				= 11,
	drawThumbOutline			= 12
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • MAIN ENTRY POINT FOR 'CDEF'
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

typedef CALLBACK_API( SInt32 , ControlDefProcPtr )(SInt16 varCode, ControlHandle theControl, ControlDefProcMessage message, SInt32 param);
typedef STACK_UPP_TYPE(ControlDefProcPtr) 						ControlDefUPP;
enum { uppControlDefProcInfo = 0x00003BB0 }; 					/* pascal 4_bytes Func(2_bytes, 4_bytes, 2_bytes, 4_bytes) */
#define NewControlDefProc(userRoutine) 							(ControlDefUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlDefProcInfo, GetCurrentArchitecture())
#define CallControlDefProc(userRoutine, varCode, theControl, message, param)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppControlDefProcInfo, (varCode), (theControl), (message), (param))
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONSTANTS FOR DRAWCNTL MESSAGE PASSED IN PARAM
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

enum {
	kDrawControlEntireControl	= 0,
	kDrawControlIndicatorOnly	= 129
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • CONSTANTS FOR DRAGCNTL MESSAGE PASSED IN PARAM
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/


enum {
	kDragControlEntireControl	= 0,
	kDragControlIndicator		= 1
};

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
      
   • DRAG CONSTRAINT STRUCTURE PASSED IN PARAM FOR THUMBCNTL MESSAGE (IM I-332)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

struct IndicatorDragConstraint {
	Rect 							limitRect;
	Rect 							slopRect;
	DragConstraint 					axis;
};
typedef struct IndicatorDragConstraint IndicatorDragConstraint;

typedef IndicatorDragConstraint *		IndicatorDragConstraintPtr;
typedef IndicatorDragConstraintPtr *	IndicatorDragConstraintHandle;
#if CGLUESUPPORTED
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • C GLUE
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( void )
dragcontrol						(ControlHandle 			theControl,
								 Point *				startPt,
								 const Rect *			limitRect,
								 const Rect *			slopRect,
								 short 					axis);

EXTERN_API_C( ControlHandle )
newcontrol						(WindowPtr 				theWindow,
								 const Rect *			boundsRect,
								 const char *			title,
								 Boolean 				visible,
								 short 					value,
								 short 					min,
								 short 					max,
								 short 					procID,
								 long 					refCon);

EXTERN_API_C( short )
findcontrol						(Point *				thePoint,
								 WindowPtr 				theWindow,
								 ControlHandle *		theControl);

EXTERN_API_C( void )
getcontroltitle					(ControlHandle 			theControl,
								 char *					title);

EXTERN_API_C( void )
setcontroltitle					(ControlHandle 			theControl,
								 const char *			title);

EXTERN_API_C( short )
trackcontrol					(ControlHandle 			theControl,
								 Point *				thePoint,
								 ControlActionUPP 		actionProc);

EXTERN_API_C( short )
testcontrol						(ControlHandle 			theControl,
								 Point *				thePt);

#endif  /* CGLUESUPPORTED */

#if OLDROUTINENAMES
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • OLDROUTINENAMES
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
/* Variants applicable to all controls (at least ones with text)*/

enum {
	useWFont					= popupUseWFont
};


enum {
	kControlCheckboxUncheckedValue = kControlCheckBoxUncheckedValue,
	kControlCheckboxCheckedValue = kControlCheckBoxCheckedValue,
	kControlCheckboxMixedValue	= kControlCheckBoxMixedValue
};


enum {
	inLabel						= kControlLabelPart,
	inMenu						= kControlMenuPart,
	inTriangle					= kControlTrianglePart,
	inButton					= kControlButtonPart,
	inCheckBox					= kControlCheckBoxPart,
	inUpButton					= kControlUpButtonPart,
	inDownButton				= kControlDownButtonPart,
	inPageUp					= kControlPageUpPart,
	inPageDown					= kControlPageDownPart,
	inThumb						= kControlIndicatorPart
};


enum {
	kNoHiliteControlPart		= kControlNoPart,
	kInLabelControlPart			= kControlLabelPart,
	kInMenuControlPart			= kControlMenuPart,
	kInTriangleControlPart		= kControlTrianglePart,
	kInButtonControlPart		= kControlButtonPart,
	kInCheckBoxControlPart		= kControlCheckBoxPart,
	kInUpButtonControlPart		= kControlUpButtonPart,
	kInDownButtonControlPart	= kControlDownButtonPart,
	kInPageUpControlPart		= kControlPageUpPart,
	kInPageDownControlPart		= kControlPageDownPart,
	kInIndicatorControlPart		= kControlIndicatorPart,
	kReservedControlPart		= kControlDisabledPart,
	kControlInactiveControlPart	= kControlInactivePart
};

#define SetCTitle(theControl, title) SetControlTitle(theControl, title)
#define GetCTitle(theControl, title) GetControlTitle(theControl, title)
#define UpdtControl(theWindow, updateRgn) UpdateControls(theWindow, updateRgn)
#define SetCtlValue(theControl, theValue) SetControlValue(theControl, theValue)
#define GetCtlValue(theControl) GetControlValue(theControl)
#define SetCtlMin(theControl, minValue) SetControlMinimum(theControl, minValue)
#define GetCtlMin(theControl) GetControlMinimum(theControl)
#define SetCtlMax(theControl, maxValue) SetControlMaximum(theControl, maxValue)
#define GetCtlMax(theControl) GetControlMaximum(theControl)
#define GetAuxCtl(theControl, acHndl) GetAuxiliaryControlRecord(theControl, acHndl)
#define SetCRefCon(theControl, data) SetControlReference(theControl, data)
#define GetCRefCon(theControl) GetControlReference(theControl)
#define SetCtlAction(theControl, actionProc) SetControlAction(theControl, actionProc)
#define GetCtlAction(theControl) GetControlAction(theControl)
#define SetCtlColor(theControl, newColorTable) SetControlColor(theControl, newColorTable)
#define GetCVariant(theControl) GetControlVariant(theControl)
#define getctitle(theControl, title) getcontroltitle(theControl, title)
#define setctitle(theControl, title) setcontroltitle(theControl, title)
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

#endif /* __CONTROLS__ */

