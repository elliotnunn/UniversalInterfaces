/*
 	File:		Controls.h
 
 	Contains:	Control Manager interfaces
 
 	Version:	Technology:	Mac OS 8.1
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __CONTROLS__
#define __CONTROLS__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __MENUS__
#include <Menus.h>
#endif
#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif
#ifndef __DRAG__
#include <Drag.h>
#endif
#ifndef __ICONS__
#include <Icons.h>
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


enum {
	_ControlDispatch			= 0xAA73
};

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Gestalt																							*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

enum {
	gestaltControlMgrAttr		= FOUR_CHAR_CODE('cntl'),
	gestaltControlMgrPresent	= (1L << 0)
};

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Resource Types																					*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlDefProcType			= FOUR_CHAR_CODE('CDEF'),
	kControlTemplateResourceType = FOUR_CHAR_CODE('CNTL'),
	kControlColorTableResourceType = FOUR_CHAR_CODE('cctb'),
	kControlDefProcResourceType	= FOUR_CHAR_CODE('CDEF'),
	kControlTabListResType		= FOUR_CHAR_CODE('tab#'),		/* used for tab control (Appearance 1.0 and later)*/
	kControlListDescResType		= FOUR_CHAR_CODE('ldes')		/* used for list box control (Appearance 1.0 and later)*/
};

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Format of a ‘CNTL’ resource																		*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

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
typedef struct ControlTemplate			ControlTemplate;
typedef ControlTemplate *				ControlTemplatePtr;
typedef ControlTemplatePtr *			ControlTemplateHandle;


#if !TARGET_OS_MAC
/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • NON-MAC COMPATIBILITY CODES (QuickTime 3.0)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

typedef UInt32 							ControlNotification;

enum {
	controlNotifyNothing		= FOUR_CHAR_CODE('nada'),		/* No (null) notification*/
	controlNotifyClick			= FOUR_CHAR_CODE('clik'),		/* Control was clicked*/
	controlNotifyFocus			= FOUR_CHAR_CODE('focu'),		/* Control got keyboard focus*/
	controlNotifyKey			= FOUR_CHAR_CODE('key ')		/* Control got a keypress*/
};

typedef UInt32 							ControlCapabilities;

enum {
	kControlCanAutoInvalidate	= 1L << 0						/* Control component automatically invalidates areas left behind after hide/move operation.*/
};

/* procID's for our added "controls"*/

enum {
	staticTextProc				= 256,							/* static text*/
	editTextProc				= 272,							/* editable text*/
	iconProc					= 288,							/* icon*/
	userItemProc				= 304,							/* user drawn item*/
	pictItemProc				= 320							/* pict*/
};

#endif  /* !TARGET_OS_MAC */

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• ControlHandle																						*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
typedef struct ControlRecord 			ControlRecord;
typedef ControlRecord *					ControlPtr;
typedef ControlPtr *					ControlHandle;
/* ControlRef is obsolete. Use ControlHandle.*/
typedef ControlHandle 					ControlRef;
typedef SInt16 							ControlPartCode;
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/* • Control ActionProcPtr																				*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( void , ControlActionProcPtr )(ControlHandle theControl, ControlPartCode partCode);
typedef STACK_UPP_TYPE(ControlActionProcPtr) 					ControlActionUPP;
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• ControlRecord																						*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

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

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/* • Control ActionProcPtr : Epilogue																	*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
enum { uppControlActionProcInfo = 0x000002C0 }; 				/* pascal no_return_value Func(4_bytes, 2_bytes) */
#define NewControlActionProc(userRoutine) 						(ControlActionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlActionProcInfo, GetCurrentArchitecture())
#define CallControlActionProc(userRoutine, theControl, partCode)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlActionProcInfo, (theControl), (partCode))
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Color Table																				*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

enum {
	cFrameColor					= 0,
	cBodyColor					= 1,
	cTextColor					= 2,
	cThumbColor					= 3,
	kNumberCtlCTabEntries		= 4
};


struct CtlCTab {
	SInt32 							ccSeed;
	SInt16 							ccRider;
	SInt16 							ctSize;
	ColorSpec 						ctTable[4];
};
typedef struct CtlCTab					CtlCTab;

typedef CtlCTab *						CCTabPtr;
typedef CCTabPtr *						CCTabHandle;
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Auxiliary Control Record																			*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

struct AuxCtlRec {
	Handle 							acNext;
	ControlHandle 					acOwner;
	CCTabHandle 					acCTable;
	SInt16 							acFlags;
	SInt32 							acReserved;
	SInt32 							acRefCon;
};
typedef struct AuxCtlRec				AuxCtlRec;

typedef AuxCtlRec *						AuxCtlPtr;
typedef AuxCtlPtr *						AuxCtlHandle;
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• PopUp Menu Private Data Structure																	*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

struct PopupPrivateData {
	MenuHandle 						mHandle;
	SInt16 							mID;
};
typedef struct PopupPrivateData			PopupPrivateData;
typedef PopupPrivateData *				PopupPrivateDataPtr;
typedef PopupPrivateDataPtr *			PopupPrivateDataHandle;

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Errors are in the range -30580 .. -30599															*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

enum {
	errMessageNotSupported		= -30580,
	errDataNotSupported			= -30581,
	errControlDoesntSupportFocus = -30582,
	errWindowDoesntSupportFocus	= -30583,
	errUnknownControl			= -30584,
	errCouldntSetFocus			= -30585,
	errNoRootControl			= -30586,
	errRootAlreadyExists		= -30587,
	errInvalidPartCode			= -30588,
	errControlsAlreadyExist		= -30589,
	errControlIsNotEmbedder		= -30590,
	errDataSizeMismatch			= -30591,
	errControlHiddenOrDisabled	= -30592,
	errWindowRegionCodeInvalid	= -30593,
	errCantEmbedIntoSelf		= -30594,
	errCantEmbedRoot			= -30595,
	errItemNotControl			= -30596,
	controlInvalidDataVersionErr = -30597,
	controlPropertyInvalid		= -5603,
	controlPropertyNotFoundErr	= -5604,
	controlHandleInvalidErr		= -30599
};

/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Definition ID’s																			*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/* Standard System 7 procIDs*/


enum {
	pushButProc					= 0,
	checkBoxProc				= 1,
	radioButProc				= 2,
	scrollBarProc				= 16,
	popupMenuProc				= 1008
};


/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Types and ID’s available only with Appearance 1.0 and later								*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/


enum {
	kControlSupportsNewMessages	= FOUR_CHAR_CODE(' ok ')		/* CDEF should return as result of kControlMsgTestNewMsgSupport*/
};

/* focusing part codes */

enum {
	kControlFocusNoPart			= 0,							/* tells control to clear its focus*/
	kControlFocusNextPart		= -1,							/* tells control to focus on the next part*/
	kControlFocusPrevPart		= -2							/* tells control to focus on the previous part*/
};


typedef SInt16 							ControlFocusPart;
/* Use this constant in Get/SetControlData when the data referred to is not			*/
/* specific to a part, but rather the entire control, e.g. the list handle of a 	*/
/* list box control.																*/

enum {
	kControlEntireControl		= 0
};

/* Key Filter result codes 															*/
/*																					*/
/* Certain controls can have a keyfilter attached to them. The filter proc should	*/
/* return one of the two constants below. If kKeyFilterBlockKey is returned, the	*/
/* key is blocked and never makes it to the control. If kKeyFilterPassKey is		*/
/* returned, the control receives the keystroke.									*/

enum {
	kControlKeyFilterBlockKey	= 0,
	kControlKeyFilterPassKey	= 1
};

typedef SInt16 							ControlKeyFilterResult;
/* ControlKeyScriptBehavior															*/
/*																					*/
/* These are the values you can use with kControlEditTextKeyScriptBehaviorTag on an */
/* Edit Text control.																*/
/* The default for password fields is kControlKeyScriptBehaviorPrefersRoman, while	*/
/* non password fields default to kControlKeyScriptBehaviorAllowAnyScript.			*/

enum {
	kControlKeyScriptBehaviorAllowAnyScript = FOUR_CHAR_CODE('any '), /* leaves the current keyboard alone and allows user to change the keyboard.*/
	kControlKeyScriptBehaviorPrefersRoman = FOUR_CHAR_CODE('prmn'), /* switches the keyboard to roman, but allows them to change it as desired.*/
	kControlKeyScriptBehaviorRequiresRoman = FOUR_CHAR_CODE('rrmn') /* switches the keyboard to roman and prevents the user from changing it.*/
};

typedef UInt32 							ControlKeyScriptBehavior;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	SPECIAL FONT USAGE NOTES: You can specify the font to use for many control types.
	The constants below are meta-font numbers which you can use to set a particular
	control's font usage. There are essentially two modes you can use: 1) default,
	which is essentially the same as it always has been, i.e. it uses the system font, unless
	directed to use the window font via a control variant. 2) you can specify to use
	the big or small system font in a generic manner. The Big system font is the font
	used in menus, etc. Chicago has filled that role for some time now. Small system
	font is currently Geneva 10. The meta-font number implies the size and style.

	NOTE:		Not all font attributes are used by all controls. Most, in fact, ignore
				the fore and back color (Static Text is the only one that does, for
				backwards compatibility). Also size, face, and addFontSize are ignored
				when using the meta-font numbering.
*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* Meta-font numbering - see not above */
	kControlFontBigSystemFont	= -1,							/* force to big system font*/
	kControlFontSmallSystemFont	= -2,							/* force to small system font*/
	kControlFontSmallBoldSystemFont = -3						/* force to small bold system font*/
};

/* Add these masks together to set the flags field of a ControlFontStyleRec	*/
/* They specify which fields to apply to the text. It is important to make	*/
/* sure that you specify only the fields that you wish to set.				*/

enum {
	kControlUseFontMask			= 0x0001,
	kControlUseFaceMask			= 0x0002,
	kControlUseSizeMask			= 0x0004,
	kControlUseForeColorMask	= 0x0008,
	kControlUseBackColorMask	= 0x0010,
	kControlUseModeMask			= 0x0020,
	kControlUseJustMask			= 0x0040,
	kControlUseAllMask			= 0x00FF,
	kControlAddFontSizeMask		= 0x0100
};

/* flags available in Appearance 1.1 or later */
/* AddToMetaFont indicates that we want to start with a standard system		*/
/* font, but then we'd like to add the other attributes. Normally, the meta	*/
/* font ignores all other flags 											*/

enum {
	kControlAddToMetaFontMask	= 0x0200
};


struct ControlFontStyleRec {
	SInt16 							flags;
	SInt16 							font;
	SInt16 							size;
	SInt16 							style;
	SInt16 							mode;
	SInt16 							just;
	RGBColor 						foreColor;
	RGBColor 						backColor;
};
typedef struct ControlFontStyleRec		ControlFontStyleRec;

typedef ControlFontStyleRec *			ControlFontStylePtr;
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Common data tags for Get/SetControlData															*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlFontStyleTag		= FOUR_CHAR_CODE('font'),
	kControlKeyFilterTag		= FOUR_CHAR_CODE('fltr')
};


/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Feature Bits																				*/
/*——————————————————————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* Control feature bits - returned by GetControlFeatures */
	kControlSupportsGhosting	= 1 << 0,
	kControlSupportsEmbedding	= 1 << 1,
	kControlSupportsFocus		= 1 << 2,
	kControlWantsIdle			= 1 << 3,
	kControlWantsActivate		= 1 << 4,
	kControlHandlesTracking		= 1 << 5,
	kControlSupportsDataAccess	= 1 << 6,
	kControlHasSpecialBackground = 1 << 7,
	kControlGetsFocusOnClick	= 1 << 8,
	kControlSupportsCalcBestRect = 1 << 9,
	kControlSupportsLiveFeedback = 1 << 10
};

/* Features introduced in Appearance 1.0.1 */

enum {
	kControlHasRadioBehavior	= 1 << 11
};

/* Features introduced in Appearance 1.1 */

enum {
	kControlAutoToggles			= 1 << 14,
	kControlSupportsGetRegion	= 1 << 17
};

/* Control Messages */

enum {
	kControlMsgDrawGhost		= 13,
	kControlMsgCalcBestRect		= 14,							/* Calculate best fitting rectangle for control*/
	kControlMsgHandleTracking	= 15,
	kControlMsgFocus			= 16,							/* param indicates action.*/
	kControlMsgKeyDown			= 17,
	kControlMsgIdle				= 18,
	kControlMsgGetFeatures		= 19,
	kControlMsgSetData			= 20,
	kControlMsgGetData			= 21,
	kControlMsgActivate			= 22,
	kControlMsgSetUpBackground	= 23,
	kControlMsgCalcValueFromPos	= 26,
	kControlMsgTestNewMsgSupport = 27							/* See if this control supports new messaging*/
};

/* Messages in Appearance 1.0.1 or later*/

enum {
	kControlMsgSubValueChanged	= 25,
	kControlMsgSubControlAdded	= 28,
	kControlMsgSubControlRemoved = 29
};

/* Messages in Appearance 1.1 or later */

enum {
	kControlMsgApplyTextColor	= 30,
	kControlMsgGetRegion		= 31
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	This structure is passed into a CDEF when called with the kControlMsgHandleTracking	*/
/*	message 																			*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlTrackingRec {
	Point 							startPt;
	SInt16 							modifiers;
	ControlActionUPP 				action;
};
typedef struct ControlTrackingRec		ControlTrackingRec;

typedef ControlTrackingRec *			ControlTrackingPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgKeyDown message */
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlKeyDownRec {
	SInt16 							modifiers;
	SInt16 							keyCode;
	SInt16 							charCode;
};
typedef struct ControlKeyDownRec		ControlKeyDownRec;

typedef ControlKeyDownRec *				ControlKeyDownPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgGetData or		*/
/* kControlMsgSetData message 															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlDataAccessRec {
	ResType 						tag;
	ResType 						part;
	Size 							size;
	Ptr 							dataPtr;
};
typedef struct ControlDataAccessRec		ControlDataAccessRec;

typedef ControlDataAccessRec *			ControlDataAccessPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlCalcBestRect msg 	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlCalcSizeRec {
	SInt16 							height;
	SInt16 							width;
	SInt16 							baseLine;
};
typedef struct ControlCalcSizeRec		ControlCalcSizeRec;

typedef ControlCalcSizeRec *			ControlCalcSizePtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgSetUpBackground */
/* message is sent																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlBackgroundRec {
	SInt16 							depth;
	Boolean 						colorDevice;
};
typedef struct ControlBackgroundRec		ControlBackgroundRec;

typedef ControlBackgroundRec *			ControlBackgroundPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgApplyTextColor	*/
/* message is sent																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlApplyTextColorRec {
	SInt16 							depth;
	Boolean 						colorDevice;
	Boolean 						active;
};
typedef struct ControlApplyTextColorRec	ControlApplyTextColorRec;

typedef ControlApplyTextColorRec *		ControlApplyTextColorPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgGetRegion		*/
/* message is sent																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct ControlGetRegionRec {
	RgnHandle 						region;
	ControlPartCode 				part;
};
typedef struct ControlGetRegionRec		ControlGetRegionRec;

typedef ControlGetRegionRec *			ControlGetRegionPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Key Filter																			*/
/*																						*/
/* Definition of a key filter for intercepting and possibly changing keystrokes			*/
/* which are destined for a control														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( ControlKeyFilterResult , ControlKeyFilterProcPtr )(ControlHandle theControl, SInt16 *keyCode, SInt16 *charCode, SInt16 *modifiers);
typedef STACK_UPP_TYPE(ControlKeyFilterProcPtr) 				ControlKeyFilterUPP;
enum { uppControlKeyFilterProcInfo = 0x00003FE0 }; 				/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes, 4_bytes) */
#define NewControlKeyFilterProc(userRoutine) 					(ControlKeyFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlKeyFilterProcInfo, GetCurrentArchitecture())
#define CallControlKeyFilterProc(userRoutine, theControl, keyCode, charCode, modifiers)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppControlKeyFilterProcInfo, (theControl), (keyCode), (charCode), (modifiers))
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• BEVEL BUTTON INTERFACE (CDEF 2)													*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Bevel buttons allow you to control the content type (pict/icon/etc.), the behavior	*/
/* (pushbutton/toggle/sticky), and the bevel size. You also have the option of			*/
/*	attaching a menu to it. When a menu is present, you can specify which way the 		*/
/*	popup arrow is facing (down or right).												*/
/*																						*/
/*	This is all made possible by overloading the Min, Max, and Value parameters for the	*/
/*	control, as well as adjusting the variant. Here's the breakdown of what goes where:	*/
/*																						*/
/*	Parameter					What Goes Here											*/
/*	———————————————————			————————————————————————————————————————————————————	*/
/*	Min							Hi Byte = Behavior, Lo Byte = content type.				*/
/*	Max							ResID for resource-based content types.					*/
/*	Value						MenuID to attach, 0 = no menu, please.					*/
/*																						*/
/*	The variant is broken down into two halfs. The low 2 bits control the bevel type.	*/
/*	Bit 2 controls the popup arrow direction (if a menu is present) and bit 3 controls	*/
/*	whether or not to use the control's owning window's font.							*/
/*																						*/
/*	Constants for all you need to put this together are below. The values for behaviors	*/
/*	are set up so that you can simply add them to the content type and pass them into	*/
/*	the Min parameter of NewControl.													*/
/*																						*/
/*	An example call:																	*/
/*																						*/
/*	control = NewControl( window, &bounds, "\p", true, 0, kContentIconSuiteRes + 		*/
/*							kBehaviorToggles, myIconSuiteID, bevelButtonSmallBevelProc,	*/
/*							0L );														*/
/*																						*/
/*	Attaching a menu:																	*/
/*																						*/
/*	control = NewControl( window, &bounds, "\p", true, kMyMenuID, kContentIconSuiteRes,	*/
/*			myIconSuiteID, bevelButtonSmallBevelProc + kBevelButtonMenuOnRight, 0L );	*/
/*																						*/
/*	This will attach menu ID kMyMenuID to the button, with the popup arrow facing right.*/
/*	This also puts the menu up to the right of the button. You can also specify that a	*/
/*	menu can have multiple items checked at once by adding kBehaviorMultiValueMenus		*/
/*	into the Min parameter. If you do use multivalue menus, the GetBevelButtonMenuValue	*/
/*	helper function will return the last item chosen from the menu, whether or not it	*/
/*	was checked.																		*/
/*																						*/
/*	NOTE: 	Bevel buttons with menus actually have *two* values. The value of the 		*/
/*			button (on/off), and the value of the menu. The menu value can be gotten	*/
/*			with the GetBevelButtonMenuValue helper function.							*/
/*																						*/
/*	Handle-based Content																*/
/*	————————————————————																*/
/*	You can create your control and then set the content to an existing handle to an	*/
/*	icon suite, etc. using the macros below. Please keep in mind that resource-based	*/
/*	content is owned by the control, handle-based content is owned by you. The CDEF will*/
/*	not try to dispose of handle-based content. If you are changing the content type of	*/
/*	the button on the fly, you must make sure that if you are replacing a handle-		*/
/*	based content with a resource-based content to properly dispose of the handle,		*/
/*	else a memory leak will ensue.														*/
/*																						*/

enum {
																/* Bevel Button Proc IDs */
	kControlBevelButtonSmallBevelProc = 32,
	kControlBevelButtonNormalBevelProc = 33,
	kControlBevelButtonLargeBevelProc = 34
};


enum {
																/* Bevel button graphic alignment values */
	kControlBevelButtonAlignSysDirection = -1,					/* only left or right*/
	kControlBevelButtonAlignCenter = 0,
	kControlBevelButtonAlignLeft = 1,
	kControlBevelButtonAlignRight = 2,
	kControlBevelButtonAlignTop	= 3,
	kControlBevelButtonAlignBottom = 4,
	kControlBevelButtonAlignTopLeft = 5,
	kControlBevelButtonAlignBottomLeft = 6,
	kControlBevelButtonAlignTopRight = 7,
	kControlBevelButtonAlignBottomRight = 8
};

typedef SInt16 							ControlButtonGraphicAlignment;

enum {
																/* Bevel button text alignment values */
	kControlBevelButtonAlignTextSysDirection = teFlushDefault,
	kControlBevelButtonAlignTextCenter = teCenter,
	kControlBevelButtonAlignTextFlushRight = teFlushRight,
	kControlBevelButtonAlignTextFlushLeft = teFlushLeft
};

typedef SInt16 							ControlButtonTextAlignment;

enum {
																/* Bevel button text placement values */
	kControlBevelButtonPlaceSysDirection = -1,					/* if graphic on right, then on left*/
	kControlBevelButtonPlaceNormally = 0,
	kControlBevelButtonPlaceToRightOfGraphic = 1,
	kControlBevelButtonPlaceToLeftOfGraphic = 2,
	kControlBevelButtonPlaceBelowGraphic = 3,
	kControlBevelButtonPlaceAboveGraphic = 4
};

typedef SInt16 							ControlButtonTextPlacement;
/* Add these variant codes to kBevelButtonSmallBevelProc to change the type of button */

enum {
	kControlBevelButtonSmallBevelVariant = 0,
	kControlBevelButtonNormalBevelVariant = (1 << 0),
	kControlBevelButtonLargeBevelVariant = (1 << 1),
	kControlBevelButtonMenuOnRight = (1 << 2)
};

/*
   Behaviors of bevel buttons. These are set up so you can add
   them together with the content types.
*/

enum {
	kControlBehaviorPushbutton	= 0,
	kControlBehaviorToggles		= 0x0100,
	kControlBehaviorSticky		= 0x0200,
	kControlBehaviorMultiValueMenu = 0x4000,					/* only makes sense when a menu is attached.*/
	kControlBehaviorOffsetContents = 0x8000
};

/* Behaviors for 1.0.1 or later */

enum {
	kControlBehaviorCommandMenu	= 0x2000						/* menu holds commands, not choices. Overrides multi-value bit.*/
};

/* Content types supported by bevel buttons *and* image wells*/

enum {
	kControlContentTextOnly		= 0,
	kControlContentIconSuiteRes	= 1,
	kControlContentCIconRes		= 2,
	kControlContentPictRes		= 3,
	kControlContentIconSuiteHandle = 129,
	kControlContentCIconHandle	= 130,
	kControlContentPictHandle	= 131,
	kControlContentIconRef		= 132
};

typedef SInt16 							ControlContentType;
/* Data tags supported by the bevel button controls */

enum {
	kControlBevelButtonContentTag = FOUR_CHAR_CODE('cont'),		/* ButtonContentInfo*/
	kControlBevelButtonTransformTag = FOUR_CHAR_CODE('tran'),	/* IconTransformType*/
	kControlBevelButtonTextAlignTag = FOUR_CHAR_CODE('tali'),	/* ButtonTextAlignment*/
	kControlBevelButtonTextOffsetTag = FOUR_CHAR_CODE('toff'),	/* SInt16*/
	kControlBevelButtonGraphicAlignTag = FOUR_CHAR_CODE('gali'), /* ButtonGraphicAlignment*/
	kControlBevelButtonGraphicOffsetTag = FOUR_CHAR_CODE('goff'), /* Point*/
	kControlBevelButtonTextPlaceTag = FOUR_CHAR_CODE('tplc'),	/* ButtonTextPlacement*/
	kControlBevelButtonMenuValueTag = FOUR_CHAR_CODE('mval'),	/* SInt16*/
	kControlBevelButtonMenuHandleTag = FOUR_CHAR_CODE('mhnd'),	/* MenuHandle*/
	kControlBevelButtonCenterPopupGlyphTag = FOUR_CHAR_CODE('pglc') /* Boolean: true = center, false = bottom right*/
};

/* These are tags in 1.0.1 or later */

enum {
	kControlBevelButtonLastMenuTag = FOUR_CHAR_CODE('lmnu'),	/* SInt16: menuID of last menu item selected from*/
	kControlBevelButtonMenuDelayTag = FOUR_CHAR_CODE('mdly')	/* SInt32: ticks to delay before menu appears*/
};

/* tags available with Appearance 1.1 or later */

enum {
																/* Boolean: True = if an icon of the ideal size for*/
																/* the button isn't available, scale a larger or*/
																/* smaller icon to the ideal size. False = don't*/
																/* scale; draw a smaller icon or clip a larger icon.*/
																/* Default is false. Only applies to IconSuites and*/
	kControlBevelButtonScaleIconTag = FOUR_CHAR_CODE('scal')	/* IconRefs.*/
};

/* Structure to pass into bevel buttons and image wells to set/get content type */

struct ControlButtonContentInfo {
	ControlContentType 				contentType;
	union {
		SInt16 							resID;
		CIconHandle 					cIconHandle;
		Handle 							iconSuite;
		Handle 							iconRef;
		PicHandle 						picture;
	} 								u;
};
typedef struct ControlButtonContentInfo	ControlButtonContentInfo;
typedef ControlButtonContentInfo *		ControlButtonContentInfoPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• SLIDER (CDEF 3)																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	There are several variants that control the behavior of the slider control. Any		*/
/*	combination of the following three constants can be added to the basic CDEF ID		*/
/*	(kSliderProc).																		*/
/*																						*/
/*	Variants:																			*/
/*																						*/
/*		kSliderLiveFeedback	 	Slider does not use "ghosted" indicator when tracking.	*/
/*								ActionProc is called (set via SetControlAction) as the	*/
/*								indicator is dragged. The value is updated so that the	*/
/*								actionproc can adjust some other property based on the	*/
/*								value each time the action proc is called. If no action	*/
/*								proc is installed, it reverts to the ghost indicator.	*/
/*																						*/
/*		kSliderHasTickMarks	 	Slider is drawn with 'tick marks'. The control			*/
/*								rectangle must be large enough to accomidate the tick	*/
/*								marks.													*/
/*																						*/
/*		kSliderReverseDirection	Slider thumb points in opposite direction than normal.	*/
/*								If the slider is vertical, the thumb will point to the	*/
/*								left, if the slider is horizontal, the thumb will point	*/
/*								upwards.												*/
/*																						*/
/*		kSliderNonDirectional	This option overrides the kSliderReverseDirection and	*/
/*								kSliderHasTickMarks variants. It creates an indicator	*/
/*								which is rectangular and doesn't point in any direction	*/
/*								like the normal indicator does.							*/

enum {
																/* Slider proc IDs */
	kControlSliderProc			= 48,
	kControlSliderLiveFeedback	= (1 << 0),
	kControlSliderHasTickMarks	= (1 << 1),
	kControlSliderReverseDirection = (1 << 2),
	kControlSliderNonDirectional = (1 << 3)
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• DISCLOSURE TRIANGLE (CDEF 4)														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	This control can be used as either left or right facing. It can also handle its own	*/
/*	tracking if you wish. This means that when the 'autotoggle' variant is used, if the	*/
/*	user clicks the control, it's state will change automatically from open to closed	*/
/*	and vice-versa depending on its initial state. After a successful call to Track-	*/
/* 	Control, you can just check the current value to see what state it was switched to.	*/

enum {
																/* Triangle proc IDs */
	kControlTriangleProc		= 64,
	kControlTriangleLeftFacingProc = 65,
	kControlTriangleAutoToggleProc = 66,
	kControlTriangleLeftFacingAutoToggleProc = 67
};


enum {
																/* Tagged data supported by disclosure triangles */
	kControlTriangleLastValueTag = FOUR_CHAR_CODE('last')		/* SInt16*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• PROGRESS INDICATOR (CDEF 5)														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	This CDEF implements both determinate and indeterminate progress bars. To switch, 	*/
/*	just use SetControlData to set the indeterminate flag to make it indeterminate call	*/
/*	IdleControls to step thru the animation. IdleControls should be called at least		*/
/*	once during your event loop.														*/
/*																						*/

enum {
																/* Progress Bar proc IDs */
	kControlProgressBarProc		= 80
};


enum {
																/* Tagged data supported by progress bars */
	kControlProgressBarIndeterminateTag = FOUR_CHAR_CODE('inde') /* Boolean*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• LITTLE ARROWS (CDEF 6)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	This control implements the little up and down arrows you'd see in the Memory		*/
/*	control panel for adjusting the cache size. 										*/

enum {
																/* Little Arrows proc IDs */
	kControlLittleArrowsProc	= 96
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• CHASING ARROWS (CDEF 7)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	To animate this control, make sure to call IdleControls repeatedly.					*/
/*																						*/

enum {
																/* Chasing Arrows proc IDs */
	kControlChasingArrowsProc	= 112
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• TABS (CDEF 8)																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Tabs use an auxiliary resource (tab#) to hold tab information such as the tab name	*/
/*	and an icon suite ID for each tab.													*/
/*																						*/
/*	The ID of the tab# resource that you wish to associate with a tab control should 	*/
/*	be passed in as the Value parameter of the control. If you are using GetNewControl, */
/*	then the Value slot in the CNTL resource should have the ID of the 'tab#' resource	*/
/*	on creation.																		*/
/*																						*/
/*	Passing zero in for the tab# resource tells the control not to read in a tab# res.	*/
/*	You can then use SetControlMaximum to add tabs, followed by a call to SetControlData*/
/*	with the kControlTabInfoTag, passing in a pointer to a ControlTabInfoRec. This sets	*/
/* 	the name and optionally an icon for a tab.											*/

enum {
																/* Tabs proc IDs */
	kControlTabLargeProc		= 128,							/* Large tab size, north facing	*/
	kControlTabSmallProc		= 129,							/* Small tab size, north facing	*/
	kControlTabLargeNorthProc	= 128,							/* Large tab size, north facing	*/
	kControlTabSmallNorthProc	= 129,							/* Small tab size, north facing	*/
	kControlTabLargeSouthProc	= 130,							/* Large tab size, south facing	*/
	kControlTabSmallSouthProc	= 131,							/* Small tab size, south facing	*/
	kControlTabLargeEastProc	= 132,							/* Large tab size, east facing	*/
	kControlTabSmallEastProc	= 133,							/* Small tab size, east facing	*/
	kControlTabLargeWestProc	= 134,							/* Large tab size, west facing	*/
	kControlTabSmallWestProc	= 135							/* Small tab size, west facing	*/
};


enum {
																/* Tagged data supported by progress bars */
	kControlTabContentRectTag	= FOUR_CHAR_CODE('rect'),		/* Rect*/
	kControlTabEnabledFlagTag	= FOUR_CHAR_CODE('enab'),		/* Boolean*/
	kControlTabFontStyleTag		= kControlFontStyleTag			/* ControlFontStyleRec*/
};

/* New tags in 1.0.1 or later */

enum {
	kControlTabInfoTag			= FOUR_CHAR_CODE('tabi')		/* ControlTabInfoRec*/
};


enum {
	kControlTabInfoVersionZero	= 0
};


struct ControlTabInfoRec {
	SInt16 							version;					/* version of this structure.*/
	SInt16 							iconSuiteID;				/* icon suite to use. Zero indicates no icon*/
	Str255 							name;						/* name to be displayed on the tab*/
};
typedef struct ControlTabInfoRec		ControlTabInfoRec;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• VISUAL SEPARATOR (CDEF 9)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Separator lines determine their orientation (horizontal or vertical) automatically	*/
/*	based on the relative height and width of their contrlRect.							*/

enum {
																/* Visual separator proc IDs */
	kControlSeparatorLineProc	= 144
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• GROUP BOX (CDEF 10)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	The group box CDEF can be use in several ways. It can have no title, a text title, 	*/
/*	a check box as the title, or a popup button as a title. There are two versions of 	*/
/*	group boxes, primary and secondary, which look slightly different.					*/

enum {
																/* Group Box proc IDs */
	kControlGroupBoxTextTitleProc = 160,
	kControlGroupBoxCheckBoxProc = 161,
	kControlGroupBoxPopupButtonProc = 162,
	kControlGroupBoxSecondaryTextTitleProc = 164,
	kControlGroupBoxSecondaryCheckBoxProc = 165,
	kControlGroupBoxSecondaryPopupButtonProc = 166
};


enum {
																/* Tagged data supported by group box */
	kControlGroupBoxMenuHandleTag = FOUR_CHAR_CODE('mhan'),		/* MenuHandle (popup title only)*/
	kControlGroupBoxFontStyleTag = kControlFontStyleTag			/* ControlFontStyleRec*/
};

/* tags available with Appearance 1.1 or later */

enum {
	kControlGroupBoxTitleRectTag = FOUR_CHAR_CODE('trec')		/* Rect. Rectangle that the title text/control is drawn in. (get only)*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• IMAGE WELL (CDEF 11)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Image Wells allow you to control the content type (pict/icon/etc.) shown in the 	*/
/*	well.																				*/
/*																						*/
/*	This is made possible by overloading the Min and Value parameters for the control.	*/
/*																						*/
/*	Parameter					What Goes Here											*/
/*	———————————————————			——————————————————————————————————————————————————		*/
/*	Min							content type (see constants for bevel buttons)			*/
/*	Value						Resource ID of content type, if resource-based.			*/
/*																						*/
/*																						*/
/*	Handle-based Content																*/
/*	————————————————————																*/
/*	You can create your control and then set the content to an existing handle to an	*/
/*	icon suite, etc. using the macros below. Please keep in mind that resource-based	*/
/*	content is owned by the control, handle-based content is owned by you. The CDEF will*/
/*	not try to dispose of handle-based content. If you are changing the content type of	*/
/*	the button on the fly, you must make sure that if you are replacing a handle-		*/
/*	based content with a resource-based content to properly dispose of the handle,		*/
/*	else a memory leak will ensue.														*/
/*																						*/

enum {
																/* Image Well proc IDs */
	kControlImageWellProc		= 176
};


enum {
																/* Tagged data supported by image wells */
	kControlImageWellContentTag	= FOUR_CHAR_CODE('cont'),		/* ButtonContentInfo*/
	kControlImageWellTransformTag = FOUR_CHAR_CODE('tran')		/* IconTransformType*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• POPUP ARROW (CDEF 12)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	The popup arrow CDEF is used to draw the small arrow normally associated with a 	*/
/*	popup control. The arrow can point in four directions, and a small or large version */
/*	can be used. This control is provided to allow clients to draw the arrow in a 		*/
/*	normalized fashion which will take advantage of themes automatically.				*/
/*																						*/

enum {
																/* Popup Arrow proc IDs */
	kControlPopupArrowEastProc	= 192,
	kControlPopupArrowWestProc	= 193,
	kControlPopupArrowNorthProc	= 194,
	kControlPopupArrowSouthProc	= 195,
	kControlPopupArrowSmallEastProc = 196,
	kControlPopupArrowSmallWestProc = 197,
	kControlPopupArrowSmallNorthProc = 198,
	kControlPopupArrowSmallSouthProc = 199
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• PLACARD (CDEF 14)																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* Placard proc IDs */
	kControlPlacardProc			= 224
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• CLOCK (CDEF 15)																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	NOTE:	You can specify more options in the Value paramter when creating the clock.	*/
/*			See below.																	*/
/*																						*/
/*	NOTE:	Under Appearance 1.1, the clock control knows and returns more part codes.	*/
/*			The new clock-specific part codes are defined with the other control parts.	*/
/*			Besides these clock-specific parts, we also return kControlUpButtonPart		*/
/*			and kControlDownButtonPart when they hit the up and down arrows.			*/
/*			The new part codes give you more flexibility for focusing and hit testing.	*/
/*																						*/
/*			The original kControlClockPart is still valid. When hit testing, it means	*/
/*			that some non-editable area of the clock's whitespace has been clicked.		*/
/*			When focusing a currently unfocused clock, it changes the focus to the		*/
/*			first part; it is the same as passing kControlFocusNextPart. When			*/
/*			re-focusing a focused clock, it will not change the focus at all.			*/

enum {
																/* Clock proc IDs */
	kControlClockTimeProc		= 240,
	kControlClockTimeSecondsProc = 241,
	kControlClockDateProc		= 242,
	kControlClockMonthYearProc	= 243
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	These flags can be passed into 'value' field on creation of the control.			*/
/* 	Value is set to 0 after control is created.											*/
/*																						*/
/*	The kClockIsLive value tells the clock to automatically update on idle (clock will	*/
/*	have the current time). This flag is only valid when the kClockIsDisplayOnly flag	*/
/*	is set.																				*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlClockNoFlags		= 0,
	kControlClockIsDisplayOnly	= 1,
	kControlClockIsLive			= 2
};


enum {
																/* Tagged data supported by clocks */
	kControlClockLongDateTag	= FOUR_CHAR_CODE('date'),		/* LongDateRec*/
	kControlClockFontStyleTag	= kControlFontStyleTag			/* ControlFontStyleRec*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• USER PANE (CDEF 16)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* User Pane proc IDs */
	kControlUserPaneProc		= 256
};

/* Tagged data supported by user panes */
/* Currently, they are all proc ptrs for doing things like drawing and hit testing, etc. */

enum {
	kControlUserItemDrawProcTag	= FOUR_CHAR_CODE('uidp'),		/* UserItemUPP*/
	kControlUserPaneDrawProcTag	= FOUR_CHAR_CODE('draw'),		/* ControlUserPaneDrawingUPP*/
	kControlUserPaneHitTestProcTag = FOUR_CHAR_CODE('hitt'),	/* ControlUserPaneHitTestUPP*/
	kControlUserPaneTrackingProcTag = FOUR_CHAR_CODE('trak'),	/* ControlUserPaneTrackingUPP*/
	kControlUserPaneIdleProcTag	= FOUR_CHAR_CODE('idle'),		/* ControlUserPaneIdleUPP*/
	kControlUserPaneKeyDownProcTag = FOUR_CHAR_CODE('keyd'),	/* ControlUserPaneKeyDownUPP*/
	kControlUserPaneActivateProcTag = FOUR_CHAR_CODE('acti'),	/* ControlUserPaneActivateUPP*/
	kControlUserPaneFocusProcTag = FOUR_CHAR_CODE('foci'),		/* ControlUserPaneFocusUPP*/
	kControlUserPaneBackgroundProcTag = FOUR_CHAR_CODE('back')	/* ControlUserPaneBackgroundUPP*/
};

typedef CALLBACK_API( void , ControlUserPaneDrawProcPtr )(ControlHandle control, SInt16 part);
typedef CALLBACK_API( ControlPartCode , ControlUserPaneHitTestProcPtr )(ControlHandle control, Point where);
typedef CALLBACK_API( ControlPartCode , ControlUserPaneTrackingProcPtr )(ControlHandle control, Point startPt, ControlActionUPP actionProc);
typedef CALLBACK_API( void , ControlUserPaneIdleProcPtr )(ControlHandle control);
typedef CALLBACK_API( ControlPartCode , ControlUserPaneKeyDownProcPtr )(ControlHandle control, SInt16 keyCode, SInt16 charCode, SInt16 modifiers);
typedef CALLBACK_API( void , ControlUserPaneActivateProcPtr )(ControlHandle control, Boolean activating);
typedef CALLBACK_API( ControlPartCode , ControlUserPaneFocusProcPtr )(ControlHandle control, ControlFocusPart action);
typedef CALLBACK_API( void , ControlUserPaneBackgroundProcPtr )(ControlHandle control, ControlBackgroundPtr info);
typedef STACK_UPP_TYPE(ControlUserPaneDrawProcPtr) 				ControlUserPaneDrawUPP;
typedef STACK_UPP_TYPE(ControlUserPaneHitTestProcPtr) 			ControlUserPaneHitTestUPP;
typedef STACK_UPP_TYPE(ControlUserPaneTrackingProcPtr) 			ControlUserPaneTrackingUPP;
typedef STACK_UPP_TYPE(ControlUserPaneIdleProcPtr) 				ControlUserPaneIdleUPP;
typedef STACK_UPP_TYPE(ControlUserPaneKeyDownProcPtr) 			ControlUserPaneKeyDownUPP;
typedef STACK_UPP_TYPE(ControlUserPaneActivateProcPtr) 			ControlUserPaneActivateUPP;
typedef STACK_UPP_TYPE(ControlUserPaneFocusProcPtr) 			ControlUserPaneFocusUPP;
typedef STACK_UPP_TYPE(ControlUserPaneBackgroundProcPtr) 		ControlUserPaneBackgroundUPP;
enum { uppControlUserPaneDrawProcInfo = 0x000002C0 }; 			/* pascal no_return_value Func(4_bytes, 2_bytes) */
enum { uppControlUserPaneHitTestProcInfo = 0x000003E0 }; 		/* pascal 2_bytes Func(4_bytes, 4_bytes) */
enum { uppControlUserPaneTrackingProcInfo = 0x00000FE0 }; 		/* pascal 2_bytes Func(4_bytes, 4_bytes, 4_bytes) */
enum { uppControlUserPaneIdleProcInfo = 0x000000C0 }; 			/* pascal no_return_value Func(4_bytes) */
enum { uppControlUserPaneKeyDownProcInfo = 0x00002AE0 }; 		/* pascal 2_bytes Func(4_bytes, 2_bytes, 2_bytes, 2_bytes) */
enum { uppControlUserPaneActivateProcInfo = 0x000001C0 }; 		/* pascal no_return_value Func(4_bytes, 1_byte) */
enum { uppControlUserPaneFocusProcInfo = 0x000002E0 }; 			/* pascal 2_bytes Func(4_bytes, 2_bytes) */
enum { uppControlUserPaneBackgroundProcInfo = 0x000003C0 }; 	/* pascal no_return_value Func(4_bytes, 4_bytes) */
#define NewControlUserPaneDrawProc(userRoutine) 				(ControlUserPaneDrawUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneDrawProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneHitTestProc(userRoutine) 				(ControlUserPaneHitTestUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneHitTestProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneTrackingProc(userRoutine) 			(ControlUserPaneTrackingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneTrackingProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneIdleProc(userRoutine) 				(ControlUserPaneIdleUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneIdleProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneKeyDownProc(userRoutine) 				(ControlUserPaneKeyDownUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneKeyDownProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneActivateProc(userRoutine) 			(ControlUserPaneActivateUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneActivateProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneFocusProc(userRoutine) 				(ControlUserPaneFocusUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneFocusProcInfo, GetCurrentArchitecture())
#define NewControlUserPaneBackgroundProc(userRoutine) 			(ControlUserPaneBackgroundUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlUserPaneBackgroundProcInfo, GetCurrentArchitecture())
#define CallControlUserPaneDrawProc(userRoutine, control, part)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlUserPaneDrawProcInfo, (control), (part))
#define CallControlUserPaneHitTestProc(userRoutine, control, where)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlUserPaneHitTestProcInfo, (control), (where))
#define CallControlUserPaneTrackingProc(userRoutine, control, startPt, actionProc)  CALL_THREE_PARAMETER_UPP((userRoutine), uppControlUserPaneTrackingProcInfo, (control), (startPt), (actionProc))
#define CallControlUserPaneIdleProc(userRoutine, control) 		CALL_ONE_PARAMETER_UPP((userRoutine), uppControlUserPaneIdleProcInfo, (control))
#define CallControlUserPaneKeyDownProc(userRoutine, control, keyCode, charCode, modifiers)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppControlUserPaneKeyDownProcInfo, (control), (keyCode), (charCode), (modifiers))
#define CallControlUserPaneActivateProc(userRoutine, control, activating)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlUserPaneActivateProcInfo, (control), (activating))
#define CallControlUserPaneFocusProc(userRoutine, control, action)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlUserPaneFocusProcInfo, (control), (action))
#define CallControlUserPaneBackgroundProc(userRoutine, control, info)  CALL_TWO_PARAMETER_UPP((userRoutine), uppControlUserPaneBackgroundProcInfo, (control), (info))
/*
  ——————————————————————————————————————————————————————————————————————————————————————————
  	• EDIT TEXT (CDEF 17)
  ——————————————————————————————————————————————————————————————————————————————————————————
*/

enum {
																/* Edit Text proc IDs */
	kControlEditTextProc		= 272,
	kControlEditTextPasswordProc = 274
};

/* proc IDs available with Appearance 1.1 or later */

enum {
	kControlEditTextInlineInputProc = 276						/* Can't combine with the other variants*/
};


enum {
																/* Tagged data supported by edit text */
	kControlEditTextStyleTag	= kControlFontStyleTag,			/* ControlFontStyleRec*/
	kControlEditTextTextTag		= FOUR_CHAR_CODE('text'),		/* Buffer of chars - you supply the buffer*/
	kControlEditTextTEHandleTag	= FOUR_CHAR_CODE('than'),		/* The TEHandle of the text edit record*/
	kControlEditTextKeyFilterTag = kControlKeyFilterTag,
	kControlEditTextSelectionTag = FOUR_CHAR_CODE('sele'),		/* EditTextSelectionRec*/
	kControlEditTextPasswordTag	= FOUR_CHAR_CODE('pass')		/* The clear text password text*/
};

/* tags available with Appearance 1.1 or later */

enum {
	kControlEditTextKeyScriptBehaviorTag = FOUR_CHAR_CODE('kscr'), /* ControlKeyScriptBehavior. Defaults to "PrefersRoman" for password fields,*/
																/*		or "AllowAnyScript" for non-password fields.*/
	kControlEditTextLockedTag	= FOUR_CHAR_CODE('lock'),		/* Boolean. Locking disables editability.*/
	kControlEditTextFixedTextTag = FOUR_CHAR_CODE('ftxt'),		/* Like the normal text tag, but fixes inline input first*/
	kControlEditTextValidationProcTag = FOUR_CHAR_CODE('vali'),	/* ControlEditTextValidationUPP. Called when a key filter can't be: after cut, paste, etc.*/
	kControlEditTextInlinePreUpdateProcTag = FOUR_CHAR_CODE('prup'), /* TSMTEPreUpdateUPP and TSMTEPostUpdateUpp. For use with inline input variant...*/
	kControlEditTextInlinePostUpdateProcTag = FOUR_CHAR_CODE('poup') /* ...The refCon parameter will contain the ControlHandle.*/
};


struct ControlEditTextSelectionRec {
																/* Structure for getting the edit text selection */
	SInt16 							selStart;
	SInt16 							selEnd;
};
typedef struct ControlEditTextSelectionRec ControlEditTextSelectionRec;

typedef ControlEditTextSelectionRec *	ControlEditTextSelectionPtr;
typedef CALLBACK_API( void , ControlEditTextValidationProcPtr )(ControlHandle control);
typedef STACK_UPP_TYPE(ControlEditTextValidationProcPtr) 		ControlEditTextValidationUPP;
enum { uppControlEditTextValidationProcInfo = 0x000000C0 }; 	/* pascal no_return_value Func(4_bytes) */
#define NewControlEditTextValidationProc(userRoutine) 			(ControlEditTextValidationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlEditTextValidationProcInfo, GetCurrentArchitecture())
#define CallControlEditTextValidationProc(userRoutine, control)  CALL_ONE_PARAMETER_UPP((userRoutine), uppControlEditTextValidationProcInfo, (control))
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• STATIC TEXT (CDEF 18)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Static Text proc IDs */

enum {
	kControlStaticTextProc		= 288
};

/* Tagged data supported by static text */

enum {
	kControlStaticTextStyleTag	= kControlFontStyleTag,			/* ControlFontStyleRec*/
	kControlStaticTextTextTag	= FOUR_CHAR_CODE('text'),		/* Copy of text*/
	kControlStaticTextTextHeightTag = FOUR_CHAR_CODE('thei')	/* SInt16*/
};

/* Tags available with appearance 1.1 or later */

enum {
	kControlStaticTextTruncTag	= FOUR_CHAR_CODE('trun')		/* TruncCode (-1 means no truncation)*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• PICTURE CONTROL (CDEF 19)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Value parameter should contain the ID of the picture you wish to display when		*/
/*	creating controls of this type. If you don't want the control tracked at all, use 	*/
/*	the 'no track' variant.																*/

enum {
																/* Picture control proc IDs */
	kControlPictureProc			= 304,
	kControlPictureNoTrackProc	= 305							/* immediately returns kControlPicturePart*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• ICON CONTROL (CDEF 20)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Value parameter should contain the ID of the ICON or cicn you wish to display when	*/
/*	creating controls of this type. If you don't want the control tracked at all, use 	*/
/*	the 'no track' variant.																*/
/* Icon control proc IDs */

enum {
	kControlIconProc			= 320,
	kControlIconNoTrackProc		= 321,							/* immediately returns kControlIconPart*/
	kControlIconSuiteProc		= 322,
	kControlIconSuiteNoTrackProc = 323							/* immediately returns kControlIconPart*/
};


enum {
																/* icon ref controls may have either an icon, color icon, icon suite, or icon ref.*/
																/* for data other than icon, you must set the data by passing a*/
																/* ControlButtonContentInfo to SetControlData*/
	kControlIconRefProc			= 324,
	kControlIconRefNoTrackProc	= 325							/* immediately returns kControlIconPart*/
};

/* Tagged data supported by icon controls */

enum {
	kControlIconTransformTag	= FOUR_CHAR_CODE('trfm'),		/* IconTransformType*/
	kControlIconAlignmentTag	= FOUR_CHAR_CODE('algn')		/* IconAlignmentType*/
};

/* Tags available with appearance 1.1 or later */

enum {
	kControlIconResourceIDTag	= FOUR_CHAR_CODE('ires'),		/* SInt16 resource ID of icon to use*/
	kControlIconContentTag		= FOUR_CHAR_CODE('cont')		/* accepts a ControlButtonContentInfo*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• WINDOW HEADER (CDEF 21)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* Window Header proc IDs */
	kControlWindowHeaderProc	= 336,							/* normal header*/
	kControlWindowListViewHeaderProc = 337						/* variant for list views - no bottom line*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• LIST BOX (CDEF 22)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	Lists use an auxiliary resource to define their format. The resource type used is 	*/
/*	'ldes' and a definition for it can be found in Appearance.r. The resource ID for 	*/
/*	the ldes is passed in the 'value' parameter when creating the control. You may pass */
/*	zero in value. This tells the List Box control to not use a resource. The list will */
/*	be created with default values, and will use the standard LDEF (0). You can change	*/
/*	the list by getting the list handle. You can set the LDEF to use by using the tag	*/
/*	below (kControlListBoxLDEFTag)														*/

enum {
																/* List Box proc IDs */
	kControlListBoxProc			= 352,
	kControlListBoxAutoSizeProc	= 353
};


enum {
																/* Tagged data supported by list box */
	kControlListBoxListHandleTag = FOUR_CHAR_CODE('lhan'),		/* ListHandle*/
	kControlListBoxKeyFilterTag	= kControlKeyFilterTag,			/* ControlKeyFilterUPP*/
	kControlListBoxFontStyleTag	= kControlFontStyleTag			/* ControlFontStyleRec*/
};

/* New tags in 1.0.1 or later */

enum {
	kControlListBoxDoubleClickTag = FOUR_CHAR_CODE('dblc'),		/* Boolean. Was last click a double-click?*/
	kControlListBoxLDEFTag		= FOUR_CHAR_CODE('ldef')		/* SInt16. ID of LDEF to use.*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• PUSH BUTTON (CDEF 23)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	The new standard checkbox and radio button controls support a "mixed" value that	*/
/*	indicates that the current setting contains a mixed set of on and off values. The 	*/
/*	control value used to display this indication is defined in Controls.h:				*/
/*																						*/
/*		kControlCheckBoxMixedValue = 2													*/
/*																						*/
/*	Two new variants of the standard pushbutton have been added to the standard control	*/
/*	suite that draw a color icon next to the control title. One variant draws the icon	*/
/*	on the left side, the other draws it on the right side (when the system justifica-	*/
/*	tion is right to left, these are reversed).											*/
/*																						*/
/*	When either of the icon pushbuttons are created, the contrlMax field of the control */
/*	record is used to determine the ID of the 'cicn' resource drawn in the pushbutton.	*/
/*																						*/
/*	In addition, a push button can now be told to draw with a default outline using the	*/
/*	SetControlData routine with the kPushButtonDefaultTag below.						*/
/*																						*/
/*	A push button may also be marked using the kControlPushButtonCancelTag. This has	*/
/*	no visible representation, but does cause the button to play the CancelButton theme	*/
/*	sound instead of the regular pushbutton theme sound when pressed.					*/
/*																						*/

enum {
																/* Theme Push Button/Check Box/Radio Button proc IDs */
	kControlPushButtonProc		= 368,
	kControlCheckBoxProc		= 369,
	kControlRadioButtonProc		= 370,
	kControlPushButLeftIconProc	= 374,							/* Standard pushbutton with left-side icon*/
	kControlPushButRightIconProc = 375							/* Standard pushbutton with right-side icon*/
};

/* Variants with Appearance 1.1 or later */

enum {
	kControlCheckBoxAutoToggleProc = 371,
	kControlRadioButtonAutoToggleProc = 372
};


enum {
																/* Tagged data supported by standard buttons */
	kControlPushButtonDefaultTag = FOUR_CHAR_CODE('dflt')		/* default ring flag*/
};


enum {
	kControlPushButtonCancelTag	= FOUR_CHAR_CODE('cncl')		/* cancel button flag (1.1 and later)*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• SCROLL BAR (CDEF 24)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	This is the new Appearance scroll bar.												*/
/*																						*/

enum {
																/* Theme Scroll Bar proc IDs */
	kControlScrollBarProc		= 384,							/* normal scroll bar*/
	kControlScrollBarLiveProc	= 386							/* live scrolling variant*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• POPUP BUTTON (CDEF 25)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	This is the new Appearance Popup Button. It takes the same variants and does the 	*/
/*	same overloading as the previous popup menu control. There are some differences:	*/
/*																						*/
/*	Passing in a menu ID of -12345 causes the popup not to try and get the menu from a	*/
/*	resource. Instead, you can build the menu and later stuff the menuhandle field in 	*/
/*	the popup data information.															*/
/*																						*/
/*	You can pass -1 in the Max parameter to have the control calculate the width of the	*/
/*	title on its own instead of guessing and then tweaking to get it right. It adds the	*/
/*	appropriate amount of space between the title and the popup.						*/
/*																						*/

enum {
																/* Theme Popup Button proc IDs */
	kControlPopupButtonProc		= 400,
	kControlPopupFixedWidthVariant = 1 << 0,
	kControlPopupVariableWidthVariant = 1 << 1,
	kControlPopupUseAddResMenuVariant = 1 << 2,
	kControlPopupUseWFontVariant = 1 << 3						/* kControlUsesOwningWindowsFontVariant*/
};

/* These tags are available in 1.0.1 or later of Appearance */

enum {
	kControlPopupButtonMenuHandleTag = FOUR_CHAR_CODE('mhan'),	/* MenuHandle*/
	kControlPopupButtonMenuIDTag = FOUR_CHAR_CODE('mnid')		/* SInt16*/
};

/* These tags are available in 1.1 or later of Appearance */

enum {
	kControlPopupButtonExtraHeightTag = FOUR_CHAR_CODE('exht')	/* SInt16 extra vertical whitespace within the button*/
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• RADIO GROUP (CDEF 26)																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	This control implements a radio group. It is an embedding control and can therefore	*/
/* 	only be used when a control hierarchy is established for its owning window. You		*/
/*	should only embed radio buttons within it. As radio buttons are embedded into it,	*/
/*	the group sets up its value, min, and max to represent the number of embedded items.*/
/*	The current value of the control is the index of the sub-control that is the current*/
/*	'on' radio button. To get the current radio button control handle, you can use the	*/
/*	control manager call GetIndSubControl, passing in the value of the radio group.		*/
/*																						*/
/*	NOTE: This control is only available with Appearance 1.0.1.							*/

enum {
	kControlRadioGroupProc		= 416
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• SCROLL TEXT BOX (CDEF 27)															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	This control implements a scrolling box of (non-editable) text.	This is useful for	*/
/*	credits in about boxes, etc.														*/
/*	The standard version of this control has a scroll bar, but the autoscrolling		*/
/*	variant does not. The autoscrolling variant needs two pieces of information to		*/
/*	work: delay (in ticks) before the scrolling starts, and time (in ticks) between		*/
/*	scrolls. It will scroll one pixel at a time, unless changed via SetControlData.		*/
/*																						*/
/*	Parameter					What Goes Here											*/
/*	———————————————————			————————————————————————————————————————————————————	*/
/*	Value						Resource ID of 'TEXT'/'styl' content.					*/
/*	Min							Scroll start delay (in ticks)						.	*/
/*	Max							Delay (in ticks) between scrolls.						*/
/*																						*/
/*	NOTE: This control is only available with Appearance 1.1.							*/

enum {
	kControlScrollTextBoxProc	= 432,
	kControlScrollTextBoxAutoScrollProc = 433
};


enum {
	kControlScrollTextBoxDelayBeforeAutoScrollTag = FOUR_CHAR_CODE('stdl'), /* UInt32 (ticks until autoscrolling starts)*/
	kControlScrollTextBoxDelayBetweenAutoScrollTag = FOUR_CHAR_CODE('scdl'), /* UInt32 (ticks between scrolls)*/
	kControlScrollTextBoxAutoScrollAmountTag = FOUR_CHAR_CODE('samt'), /* UInt16 (pixels per scroll) -- defaults to 1*/
	kControlScrollTextBoxContentsTag = FOUR_CHAR_CODE('tres')	/* SInt16 (resource ID of 'TEXT'/'styl') -- write only!*/
};


/*  —— end of stuff only available with Appearance 1.0 and later*/


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Variants																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef SInt16 							ControlVariant;

enum {
	kControlNoVariant			= 0,							/* No variant*/
	kControlUsesOwningWindowsFontVariant = 1 << 3				/* Control uses owning windows font to display text*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Part Codes																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlNoPart				= 0,
	kControlLabelPart			= 1,
	kControlMenuPart			= 2,
	kControlTrianglePart		= 4,
	kControlEditTextPart		= 5,							/* Appearance 1.0 and later*/
	kControlPicturePart			= 6,							/* Appearance 1.0 and later*/
	kControlIconPart			= 7,							/* Appearance 1.0 and later*/
	kControlClockPart			= 8,							/* Appearance 1.0 and later*/
	kControlListBoxPart			= 24,							/* Appearance 1.0 and later*/
	kControlListBoxDoubleClickPart = 25,						/* Appearance 1.0 and later*/
	kControlImageWellPart		= 26,							/* Appearance 1.0 and later*/
	kControlRadioGroupPart		= 27,							/* Appearance 1.0.2 and later*/
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


enum {
	kControlClockHourDayPart	= 9,							/* Appearance 1.1 and later*/
	kControlClockMinuteMonthPart = 10,							/* Appearance 1.1 and later*/
	kControlClockSecondYearPart	= 11,							/* Appearance 1.1 and later*/
	kControlClockAMPMPart		= 12							/* Appearance 1.1 and later*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	Meta-Parts																			*/
/*
|* 	If you haven't guessed from looking at other toolbox headers. We like the word 		*/
/*	'meta'. It's cool. So here's one more for you. A meta-part is a part used in a call	*/
/* 	to the GetControlRegion API. These parts are parts that might be defined by a		*/
/*	control, but should not be returned from calls like TestControl, et al. They define	*/
/* 	a region of a control, presently the structure and the content region. The content	*/
/* 	region is only defined by controls that can embed other controls. It is the area	*/
/* 	that embedded content can live.														*/
/*																						*/
/*	Along with these parts, you can also pass in normal part codes to get the regions	*/
/* 	of the parts. Not all controls fully support this at the time this was written.		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlStructureMetaPart	= -1,
	kControlContentMetaPart		= -2
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Check Box Values																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlCheckBoxUncheckedValue = 0,
	kControlCheckBoxCheckedValue = 1,
	kControlCheckBoxMixedValue	= 2
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Radio Button Values																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlRadioButtonUncheckedValue = 0,
	kControlRadioButtonCheckedValue = 1,
	kControlRadioButtonMixedValue = 2
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Pop-Up Menu Control Constants														*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Variant codes for the System 7 pop-up menu*/

enum {
	popupFixedWidth				= 1 << 0,
	popupVariableWidth			= 1 << 1,
	popupUseAddResMenu			= 1 << 2,
	popupUseWFont				= 1 << 3
};

/* Menu label styles for the System 7 pop-up menu*/

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

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* 	• DragGrayRgn Constatns																*/
/*																						*/
/*   For DragGrayRgnUPP used in TrackControl() 											*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	noConstraint				= kNoConstraint,
	hAxisOnly					= 1,
	vAxisOnly					= 2
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Creation/Deletion															*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
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

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Visible State																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
HiliteControl					(ControlHandle 			theControl,
								 ControlPartCode 		hiliteState)						ONEWORDINLINE(0xA95D);

EXTERN_API( void )
ShowControl						(ControlHandle 			theControl)							ONEWORDINLINE(0xA957);

EXTERN_API( void )
HideControl						(ControlHandle 			theControl)							ONEWORDINLINE(0xA958);


/* following state routines available only with Appearance 1.0 and later*/
EXTERN_API( Boolean )
IsControlActive					(ControlHandle 			inControl)							THREEWORDINLINE(0x303C, 0x0005, 0xAA73);

EXTERN_API( Boolean )
IsControlVisible				(ControlHandle 			inControl)							THREEWORDINLINE(0x303C, 0x0006, 0xAA73);

EXTERN_API( OSErr )
ActivateControl					(ControlHandle 			inControl)							THREEWORDINLINE(0x303C, 0x0007, 0xAA73);

EXTERN_API( OSErr )
DeactivateControl				(ControlHandle 			inControl)							THREEWORDINLINE(0x303C, 0x0008, 0xAA73);

EXTERN_API( OSErr )
SetControlVisibility			(ControlHandle 			inControl,
								 Boolean 				inIsVisible,
								 Boolean 				inDoDraw)							THREEWORDINLINE(0x303C, 0x001E, 0xAA73);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Imaging																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
DrawControls					(WindowPtr 				theWindow)							ONEWORDINLINE(0xA969);

EXTERN_API( void )
Draw1Control					(ControlHandle 			theControl)							ONEWORDINLINE(0xA96D);

#define DrawOneControl(theControl) Draw1Control(theControl)

EXTERN_API( void )
UpdateControls					(WindowPtr 				theWindow,
								 RgnHandle 				updateRegion)						ONEWORDINLINE(0xA953);


/* following imaging routines available only with Appearance 1.0 and later*/
EXTERN_API( OSErr )
GetBestControlRect				(ControlHandle 			inControl,
								 Rect *					outRect,
								 SInt16 *				outBaseLineOffset)					THREEWORDINLINE(0x303C, 0x001B, 0xAA73);

EXTERN_API( OSErr )
SetControlFontStyle				(ControlHandle 			inControl,
								 const ControlFontStyleRec * inStyle)						THREEWORDINLINE(0x303C, 0x001C, 0xAA73);

EXTERN_API( void )
DrawControlInCurrentPort		(ControlHandle 			inControl)							THREEWORDINLINE(0x303C, 0x0018, 0xAA73);

EXTERN_API( OSErr )
SetUpControlBackground			(ControlHandle 			inControl,
								 SInt16 				inDepth,
								 Boolean 				inIsColorDevice)					THREEWORDINLINE(0x303C, 0x001D, 0xAA73);

/* SetUpControlTextColor is available in Appearance 1.1 or later.*/
EXTERN_API( OSErr )
SetUpControlTextColor			(ControlHandle 			inControl,
								 SInt16 				inDepth,
								 Boolean 				inIsColorDevice);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Mousing																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
	NOTE ON CONTROL ACTION PROCS

	When using the TrackControl() call when tracking an indicator, the actionProc parameter
	(type ControlActionUPP) should be replaced by a parameter of type DragGrayRgnUPP
	(see Quickdraw.h).

	If, however, you are using the live feedback variants of scroll bars or sliders, you
	can pass a ControlActionUPP in when tracking the indicator as well. This functionality
	is available in Appearance 1.0 or later.
*/
EXTERN_API( ControlPartCode )
TrackControl					(ControlHandle 			theControl,
								 Point 					startPoint,
								 ControlActionUPP 		actionProc) /* can be NULL */		ONEWORDINLINE(0xA968);

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

/* The following mousing routines available only with Appearance 1.0 and later	*/
/*																				*/
/* FindControlUnderMouse is preferrable to TrackControl when running under		*/
/* Appearance 1.0 as you can pass in modifiers, which some of the new controls	*/
/* use, such as edit text and list boxes.										*/
EXTERN_API( ControlHandle )
FindControlUnderMouse			(Point 					inWhere,
								 WindowPtr 				inWindow,
								 SInt16 *				outPart)							THREEWORDINLINE(0x303C, 0x0009, 0xAA73);

EXTERN_API( ControlPartCode )
HandleControlClick				(ControlHandle 			inControl,
								 Point 					inWhere,
								 SInt16 				inModifiers,
								 ControlActionUPP 		inAction) /* can be NULL */			THREEWORDINLINE(0x303C, 0x000A, 0xAA73);




/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Events (available only with Appearance 1.0 and later)						*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( SInt16 )
HandleControlKey				(ControlHandle 			inControl,
								 SInt16 				inKeyCode,
								 SInt16 				inCharCode,
								 SInt16 				inModifiers)						THREEWORDINLINE(0x303C, 0x000B, 0xAA73);

EXTERN_API( void )
IdleControls					(WindowPtr 				inWindow)							THREEWORDINLINE(0x303C, 0x000C, 0xAA73);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Positioning																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
MoveControl						(ControlHandle 			theControl,
								 SInt16 				h,
								 SInt16 				v)									ONEWORDINLINE(0xA959);

EXTERN_API( void )
SizeControl						(ControlHandle 			theControl,
								 SInt16 				w,
								 SInt16 				h)									ONEWORDINLINE(0xA95C);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Title																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
SetControlTitle					(ControlHandle 			theControl,
								 ConstStr255Param 		title)								ONEWORDINLINE(0xA95F);

EXTERN_API( void )
GetControlTitle					(ControlHandle 			theControl,
								 Str255 				title)								ONEWORDINLINE(0xA95E);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Value																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
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


/* proportional scrolling/32-bit value support is new with Appearance 1.1*/

EXTERN_API( SInt32 )
GetControlViewSize				(ControlHandle 			theControl);

EXTERN_API( void )
SetControlViewSize				(ControlHandle 			theControl,
								 SInt32 				newViewSize);

EXTERN_API( SInt32 )
GetControl32BitValue			(ControlHandle 			theControl);

EXTERN_API( void )
SetControl32BitValue			(ControlHandle 			theControl,
								 SInt32 				newValue);

EXTERN_API( SInt32 )
GetControl32BitMaximum			(ControlHandle 			theControl);

EXTERN_API( void )
SetControl32BitMaximum			(ControlHandle 			theControl,
								 SInt32 				newMaximum);

EXTERN_API( SInt32 )
GetControl32BitMinimum			(ControlHandle 			theControl);

EXTERN_API( void )
SetControl32BitMinimum			(ControlHandle 			theControl,
								 SInt32 				newMinimum);

/*
   	IsValidControlHandle will tell you if the handle you pass in belongs to a control
  	the Control Manager knows about. It does not sanity check the data in the control.
*/

EXTERN_API( Boolean )
IsValidControlHandle			(ControlHandle 			theControl);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Properties																			*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
GetControlProperty				(ControlHandle 			control,
								 OSType 				propertyCreator,
								 OSType 				propertyTag,
								 UInt32 				bufferSize,
								 UInt32 *				actualSize,
								 void *					propertyBuffer);

EXTERN_API( OSStatus )
GetControlPropertySize			(ControlHandle 			control,
								 OSType 				propertyCreator,
								 OSType 				propertyTag,
								 UInt32 *				size);

EXTERN_API( OSStatus )
SetControlProperty				(ControlHandle 			control,
								 OSType 				propertyCreator,
								 OSType 				propertyTag,
								 UInt32 				propertySize,
								 void *					propertyData);

EXTERN_API( OSStatus )
RemoveControlProperty			(ControlHandle 			control,
								 OSType 				propertyCreator,
								 OSType 				propertyTag);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Regions (Appearance 1.1 or later)											*/
/*																						*/
/*	See the discussion on meta-parts in this header for more information				*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
GetControlRegion				(ControlHandle 			inControl,
								 ControlPartCode 		inPart,
								 RgnHandle 				outRegion);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Variant																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( ControlVariant )
GetControlVariant				(ControlHandle 			theControl)							ONEWORDINLINE(0xA809);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Action																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( void )
SetControlAction				(ControlHandle 			theControl,
								 ControlActionUPP 		actionProc)							ONEWORDINLINE(0xA96B);

EXTERN_API( ControlActionUPP )
GetControlAction				(ControlHandle 			theControl)							ONEWORDINLINE(0xA96A);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Control Accessors																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
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

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• HELPERS (available only with Appearance 1.0 and later)							*/
/*																						*/
/* These routines are available only thru the shared library/glue						*/
/* Bevel button routines																*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

EXTERN_API( OSErr )
GetBevelButtonMenuValue			(ControlHandle 			inButton,
								 SInt16 *				outValue);

EXTERN_API( OSErr )
SetBevelButtonMenuValue			(ControlHandle 			inButton,
								 SInt16 				inValue);

EXTERN_API( OSErr )
GetBevelButtonMenuHandle		(ControlHandle 			inButton,
								 MenuHandle *			outHandle);

EXTERN_API( OSErr )
GetBevelButtonContentInfo		(ControlHandle 			inButton,
								 ControlButtonContentInfoPtr  outContent);

EXTERN_API( OSErr )
SetBevelButtonContentInfo		(ControlHandle 			inButton,
								 ControlButtonContentInfoPtr  inContent);

EXTERN_API( OSErr )
SetBevelButtonTransform			(ControlHandle 			inButton,
								 IconTransformType 		transform);

EXTERN_API( OSErr )
SetBevelButtonGraphicAlignment	(ControlHandle 			inButton,
								 ControlButtonGraphicAlignment  inAlign,
								 SInt16 				inHOffset,
								 SInt16 				inVOffset);

EXTERN_API( OSErr )
SetBevelButtonTextAlignment		(ControlHandle 			inButton,
								 ControlButtonTextAlignment  inAlign,
								 SInt16 				inHOffset);

EXTERN_API( OSErr )
SetBevelButtonTextPlacement		(ControlHandle 			inButton,
								 ControlButtonTextPlacement  inWhere);

/* Image well routines*/

EXTERN_API( OSErr )
GetImageWellContentInfo			(ControlHandle 			inButton,
								 ControlButtonContentInfoPtr  outContent);

EXTERN_API( OSErr )
SetImageWellContentInfo			(ControlHandle 			inButton,
								 ControlButtonContentInfoPtr  inContent);

EXTERN_API( OSErr )
SetImageWellTransform			(ControlHandle 			inButton,
								 IconTransformType 		inTransform);

/* Tab routines*/

EXTERN_API( OSErr )
GetTabContentRect				(ControlHandle 			inTabControl,
								 Rect *					outContentRect);

EXTERN_API( OSErr )
SetTabEnabled					(ControlHandle 			inTabControl,
								 SInt16 				inTabToHilite,
								 Boolean 				inEnabled);

/* Disclosure triangles*/

EXTERN_API( OSErr )
SetDisclosureTriangleLastValue	(ControlHandle 			inTabControl,
								 SInt16 				inValue);

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Hierarchy (Appearance 1.0 and later only)									*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( SInt32 )
SendControlMessage				(ControlHandle 			inControl,
								 SInt16 				inMessage,
								 SInt32 				inParam)							THREEWORDINLINE(0x303C, 0xFFFE, 0xAA73);

EXTERN_API( OSErr )
DumpControlHierarchy			(WindowPtr 				inWindow,
								 const FSSpec *			inDumpFile)							THREEWORDINLINE(0x303C, 0xFFFF, 0xAA73);

EXTERN_API( OSErr )
CreateRootControl				(WindowPtr 				inWindow,
								 ControlHandle *		outControl)							THREEWORDINLINE(0x303C, 0x0001, 0xAA73);

EXTERN_API( OSErr )
GetRootControl					(WindowPtr 				inWindow,
								 ControlHandle *		outControl)							THREEWORDINLINE(0x303C, 0x0002, 0xAA73);

EXTERN_API( OSErr )
EmbedControl					(ControlHandle 			inControl,
								 ControlHandle 			inContainer)						THREEWORDINLINE(0x303C, 0x0003, 0xAA73);

EXTERN_API( OSErr )
AutoEmbedControl				(ControlHandle 			inControl,
								 WindowPtr 				inWindow)							THREEWORDINLINE(0x303C, 0x0004, 0xAA73);

EXTERN_API( OSErr )
GetSuperControl					(ControlHandle 			inControl,
								 ControlHandle *		outParent)							THREEWORDINLINE(0x303C, 0x0015, 0xAA73);

EXTERN_API( OSErr )
CountSubControls				(ControlHandle 			inControl,
								 UInt16 *				outNumChildren)						THREEWORDINLINE(0x303C, 0x0016, 0xAA73);

EXTERN_API( OSErr )
GetIndexedSubControl			(ControlHandle 			inControl,
								 UInt16 				inIndex,
								 ControlHandle *		outSubControl)						THREEWORDINLINE(0x303C, 0x0017, 0xAA73);

EXTERN_API( OSErr )
SetControlSupervisor			(ControlHandle 			inControl,
								 ControlHandle 			inBoss)								THREEWORDINLINE(0x303C, 0x001A, 0xAA73);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Keyboard Focus (available only with Appearance 1.0 and later)						*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSErr )
GetKeyboardFocus				(WindowPtr 				inWindow,
								 ControlHandle *		outControl)							THREEWORDINLINE(0x303C, 0x000D, 0xAA73);

EXTERN_API( OSErr )
SetKeyboardFocus				(WindowPtr 				inWindow,
								 ControlHandle 			inControl,
								 ControlFocusPart 		inPart)								THREEWORDINLINE(0x303C, 0x000E, 0xAA73);

EXTERN_API( OSErr )
AdvanceKeyboardFocus			(WindowPtr 				inWindow)							THREEWORDINLINE(0x303C, 0x000F, 0xAA73);

EXTERN_API( OSErr )
ReverseKeyboardFocus			(WindowPtr 				inWindow)							THREEWORDINLINE(0x303C, 0x0010, 0xAA73);

EXTERN_API( OSErr )
ClearKeyboardFocus				(WindowPtr 				inWindow)							THREEWORDINLINE(0x303C, 0x0019, 0xAA73);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Control Data (available only with Appearance 1.0 and later)						*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

EXTERN_API( OSErr )
GetControlFeatures				(ControlHandle 			inControl,
								 UInt32 *				outFeatures)						THREEWORDINLINE(0x303C, 0x0011, 0xAA73);

EXTERN_API( OSErr )
SetControlData					(ControlHandle 			inControl,
								 ControlPartCode 		inPart,
								 ResType 				inTagName,
								 Size 					inSize,
								 Ptr 					inData)								THREEWORDINLINE(0x303C, 0x0012, 0xAA73);

EXTERN_API( OSErr )
GetControlData					(ControlHandle 			inControl,
								 ControlPartCode 		inPart,
								 ResType 				inTagName,
								 Size 					inBufferSize,
								 Ptr 					inBuffer,
								 Size *					outActualSize)						THREEWORDINLINE(0x303C, 0x0013, 0xAA73);

EXTERN_API( OSErr )
GetControlDataSize				(ControlHandle 			inControl,
								 ControlPartCode 		inPart,
								 ResType 				inTagName,
								 Size *					outMaxSize)							THREEWORDINLINE(0x303C, 0x0014, 0xAA73);




/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• ‘CDEF’ messages																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
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

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• ‘CDEF’ entrypoint																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( SInt32 , ControlDefProcPtr )(SInt16 varCode, ControlHandle theControl, ControlDefProcMessage message, SInt32 param);
typedef STACK_UPP_TYPE(ControlDefProcPtr) 						ControlDefUPP;
enum { uppControlDefProcInfo = 0x00003BB0 }; 					/* pascal 4_bytes Func(2_bytes, 4_bytes, 2_bytes, 4_bytes) */
#define NewControlDefProc(userRoutine) 							(ControlDefUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlDefProcInfo, GetCurrentArchitecture())
#define CallControlDefProc(userRoutine, varCode, theControl, message, param)  CALL_FOUR_PARAMETER_UPP((userRoutine), uppControlDefProcInfo, (varCode), (theControl), (message), (param))
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Constants for drawCntl message (passed in param)									*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kDrawControlEntireControl	= 0,
	kDrawControlIndicatorOnly	= 129
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Constants for dragCntl message (passed in param)									*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kDragControlEntireControl	= 0,
	kDragControlIndicator		= 1
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• Drag Constraint Structure for thumbCntl message (passed in param)					*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

struct IndicatorDragConstraint {
	Rect 							limitRect;
	Rect 							slopRect;
	DragConstraint 					axis;
};
typedef struct IndicatorDragConstraint	IndicatorDragConstraint;
typedef IndicatorDragConstraint *		IndicatorDragConstraintPtr;
typedef IndicatorDragConstraintPtr *	IndicatorDragConstraintHandle;
#if !TARGET_OS_MAC
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• QuickTime 3.0 Win32/unix notification	mechanism									*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Proc used to notify window that something happened to the control*/
typedef CALLBACK_API_C( void , ControlNotificationProcPtr )(WindowPtr theWindow, ControlHandle theControl, ControlNotification notification, long param1, long param2);
/*
   Proc used to prefilter events before handled by control.  A client of a control calls
   CTRLSetPreFilterProc() to have the control call this proc before handling the event.
   If the proc returns TRUE, the control can go ahead and handle the event.
*/
typedef CALLBACK_API_C( Boolean , PreFilterEventProc )(ControlHandle theControl, EventRecord *theEvent);
EXTERN_API_C( long )
GetControlComponentInstance		(ControlHandle 			theControl);

EXTERN_API_C( ControlHandle )
GetControlHandleFromCookie		(long 					cookie);

EXTERN_API_C( void )
SetControlDefProc				(short 					resID,
								 ControlDefProcPtr 		proc);

#endif  /* !TARGET_OS_MAC */

#if CGLUESUPPORTED
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• C Glue																			*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
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
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*	• OLDROUTINENAMES																	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
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

#define GetControlListFromWindow(theWindow)		( *(ControlHandle *) (((UInt8 *) theWindow) + sizeof(GrafPort) + 0x20))
#define GetControlOwningWindowControlList(theWindow)		( *(ControlHandle *) (((UInt8 *) theWindow) + sizeof(GrafPort) + 0x20))







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

